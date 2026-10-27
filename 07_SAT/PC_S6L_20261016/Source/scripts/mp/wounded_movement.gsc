// scripts\mp\wounded_movement.gsc  (hash_62360685460e1458.gscc) (size: 5992 Bytes / 0x1768 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb50c0687 (3037464199)
// size ...... 5992 (0x1768)
// includes .. 11  (offset: 0x1648)
// strings ... 11  (offset: 0x16a0)
// dev strs .. 1   (offset: 0x175c)
// exports ... 17  (offset: 0xda4)
// cseg ...... 0x121 + 0xc83 (0xda4)
// imports ... 50  (offset: 0x104c)
// animtree1 . 0   (offset: 0x1768)
// animtree2 . 0   (offset: 0x1768)
#using scripts\common\callbacks;
#using scripts\common\dev;
#using scripts\common\math;
#using scripts\common\system;
#using scripts\common\values;
#using scripts\mp\common\perks\perks;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\gametypes\common;
#using scripts\mp\health_chunks;
#using scripts\mp\playerhealth;

#namespace wounded_movement;

// Namespace wounded_movement
// Params 0, eflags: 0x5
// Checksum 0xca174da, Offset: 0x13f
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"wounded_movement", undefined, undefined, &init );
}

// Namespace wounded_movement
// Params 0
// Checksum 0xe1423efa, Offset: 0x160
// Size: 0x93
function init()
{
    if ( !isenabled() || isdefined( level.var_c1bb08b1169797fd ) )
    {
        return;
    }
    
    function_1f62f1762cc4c85();
    callback::add( #"player_spawned", &onplayerconnect );
    callback::add( #"player_damaged", &function_9fe35b09302906a0 );
    callback::add( #"on_spawn_agent", &function_d04f171d1b9ba122 );
    playerhealth::function_bdfdee3e2bcb10d8( &function_9fe35b09302906a0 );
    level.var_2464e8c70801e60f = &function_2464e8c70801e60f;
    
    /#
        dev::devcommandwatcher( @"wounded_movement", &function_38ab8fd9c73708c0 );
    #/
}

// Namespace wounded_movement
// Params 1
// Checksum 0xfdee2a7, Offset: 0x1fb
// Size: 0x4e
function function_98cf49e23fa0aa( player )
{
    if ( !isdefined( player.refent ) )
    {
        player.refent = spawn( "script_model", ( 0, 0, 0 ) );
    }
    
    player playersetgroundreferenceent( player.refent );
}

// Namespace wounded_movement
// Params 6
// Checksum 0x945abc5e, Offset: 0x251
// Size: 0x32f
function limp( player, var_1452eb3bac0944c9, var_6d8d8e4d70ba3bfb = level.var_c1bb08b1169797fd.var_71d8e392a851ce0a, var_c0f115dc40f51ec = level.var_c1bb08b1169797fd.var_20fabbf135505beb, rolldegrees = level.var_c1bb08b1169797fd.var_483f6aac36f340be, holdtime = level.var_c1bb08b1169797fd.var_27f88b78d8a92481 )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( !isdefined( var_1452eb3bac0944c9 ) )
    {
        thresholdhealth = clamp( function_8b9426d3f6b856af( player ), player.health, player.maxhealth );
        time = math::factor_value( level.var_c1bb08b1169797fd.var_9720dbb402c60a56, level.var_c1bb08b1169797fd.var_c404df43a98cf938, player.health / thresholdhealth );
    }
    else
    {
        time = var_1452eb3bac0944c9;
    }
    
    currenttime = gettime();
    animtime = time * 1000;
    endtime = animtime + currenttime;
    
    while ( currenttime < endtime )
    {
        axis = anglestoaxis( player.angles );
        forward = axis[ "forward" ];
        right = axis[ "right" ];
        rotscalar = easeback( 1 - ( endtime - currenttime ) / animtime, var_6d8d8e4d70ba3bfb, var_c0f115dc40f51ec, 1, 1 );
        newangles = ( right + forward ) * 0.5 * rolldegrees * -1;
        var_3a7499de4b894818 = ( newangles[ 1 ], 0, newangles[ 0 ] ) * rotscalar;
        player.refent.angles = var_3a7499de4b894818;
        waitframe();
        currenttime = gettime();
    }
    
    wait holdtime;
    
    while ( player getnormalizedmovement() == ( 0, 0, 0 ) )
    {
        waitframe();
    }
    
    if ( !isdefined( var_1452eb3bac0944c9 ) )
    {
        thresholdhealth = clamp( function_8b9426d3f6b856af( player ), player.health, player.maxhealth );
        time = math::factor_value( level.var_c1bb08b1169797fd.var_9720dbb402c60a56, level.var_c1bb08b1169797fd.var_c404df43a98cf938, player.health / thresholdhealth );
    }
    else
    {
        time = var_1452eb3bac0944c9;
    }
    
    currenttime = gettime();
    animtime = time * 1000;
    endtime = animtime + currenttime;
    
    while ( currenttime < endtime )
    {
        axis = anglestoaxis( player.angles );
        forward = axis[ "forward" ];
        right = axis[ "right" ];
        newangles = ( right + forward ) * 0.5 * rolldegrees * -1;
        var_3a7499de4b894818 = ( newangles[ 1 ], 0, newangles[ 0 ] );
        player.refent.angles = vectorlerp( var_3a7499de4b894818, ( 0, 0, 0 ), 1 - ( endtime - currenttime ) / animtime );
        waitframe();
        currenttime = gettime();
    }
    
    wait holdtime;
}

// Namespace wounded_movement
// Params 0
// Checksum 0x5f1be033, Offset: 0x588
// Size: 0x5e
function isenabled()
{
    if ( !isdefined( level.gametypebundle ) )
    {
        assertmsg( "<dev string:x24>" );
        return 0;
    }
    
    if ( !isdefined( level.var_ffb0162b8d0fc006 ) )
    {
        level.var_ffb0162b8d0fc006 = getdvarint( @"scr_wounded_movement_enabled", istrue( level.gametypebundle.var_ffb0162b8d0fc006 ) );
    }
    
    return level.var_ffb0162b8d0fc006;
}

// Namespace wounded_movement
// Params 1
// Checksum 0x461308fe, Offset: 0x5ef
// Size: 0x23, Type: bool
function function_4f2523327bf73947( player )
{
    return isenabled() && player val::get( "wounded_movement" );
}

// Namespace wounded_movement
// Params 1
// Checksum 0xc94e8e4f, Offset: 0x61b
// Size: 0x1a
function function_2464e8c70801e60f( val )
{
    if ( val )
    {
        return;
    }
    
    function_c2656af50525a274( self );
}

// Namespace wounded_movement
// Params 1, eflags: 0x4
// Checksum 0x8a39d1c9, Offset: 0x63d
// Size: 0x5d
function private function_c2656af50525a274( player )
{
    player.playerstreakspeedscale = 0;
    
    if ( player common::function_8ff835bf23198a0( "playerStreakSpeedScale" ) )
    {
        player common::function_d85a92c557ea5a52( "playerStreakSpeedScale" );
        player common::function_65276d8c156b2ec9( 2 );
    }
    
    player setmovespeedscale( 1 );
    player val::reset_all( "wounded_movement" );
}

// Namespace wounded_movement
// Params 0, eflags: 0x4
// Checksum 0xcc52b01c, Offset: 0x6a2
// Size: 0x2d2
function private function_1f62f1762cc4c85()
{
    level.var_c1bb08b1169797fd = spawnstruct();
    level.var_c1bb08b1169797fd.var_f43ab8dd2b51a0b9 = getdvarint( @"hash_ef885ea537bca007", level.gametypebundle.var_f43ab8dd2b51a0b9 ?? 1 );
    level.var_c1bb08b1169797fd.minspeedscalar = getdvarfloat( @"hash_9ba83cb7065e63f3", level.gametypebundle.var_18ea4bfa8100fa0f ?? 1 );
    level.var_c1bb08b1169797fd.var_6759e517a055b157 = getdvarint( @"hash_5614c66a488a409a", level.gametypebundle.var_6759e517a055b157 ?? 10 ) / 100;
    level.var_c1bb08b1169797fd.var_5a93ed5063c3b2c2 = getdvarint( @"hash_788c8cc53a63822e", level.gametypebundle.var_5a93ed5063c3b2c2 ?? 0 );
    level.var_c1bb08b1169797fd.var_2824fbeb5b97b339 = getdvarint( @"hash_e8f908d1fa8735a9", level.gametypebundle.var_2824fbeb5b97b339 ?? 1 );
    level.var_c1bb08b1169797fd.var_a5e8acff6312a0d1 = getdvarint( @"hash_efe4eae2ff9384b6", level.gametypebundle.var_a5e8acff6312a0d1 ?? 1 );
    level.var_c1bb08b1169797fd.var_483f6aac36f340be = getdvarfloat( @"hash_bcdf9bf8a8c140e6", level.gametypebundle.var_483f6aac36f340be ?? 6 );
    level.var_c1bb08b1169797fd.var_c404df43a98cf938 = getdvarfloat( @"hash_cb62ad745cc910e7", level.gametypebundle.var_c404df43a98cf938 ?? 0.6 );
    level.var_c1bb08b1169797fd.var_9720dbb402c60a56 = getdvarfloat( @"hash_b60dd6777487afe5", level.gametypebundle.var_9720dbb402c60a56 ?? 0.6 );
    level.var_c1bb08b1169797fd.var_27f88b78d8a92481 = getdvarfloat( @"hash_3d29b3ddb5e06abc", level.gametypebundle.var_27f88b78d8a92481 ?? 0.15 );
    level.var_c1bb08b1169797fd.var_71d8e392a851ce0a = getdvarfloat( @"hash_81ab5a1a387e0993", level.gametypebundle.var_71d8e392a851ce0a ?? 0.5 );
    level.var_c1bb08b1169797fd.var_20fabbf135505beb = getdvarfloat( @"hash_62e688f4736f7ab0", level.gametypebundle.var_20fabbf135505beb ?? 3 );
}

// Namespace wounded_movement
// Params 1, eflags: 0x4
// Checksum 0x241f1b86, Offset: 0x97c
// Size: 0x18
function private function_d04f171d1b9ba122( params )
{
    perk::giveperk( "specialty_tracker_jammer" );
}

// Namespace wounded_movement
// Params 1, eflags: 0x4
// Checksum 0x92afa665, Offset: 0x99c
// Size: 0xd2
function private onplayerconnect( params )
{
    player = self;
    player val::set( "wounded_movement_key", "wounded_movement", 1 );
    
    if ( !isdefined( level.var_b3d6c8db95f62b4a ) )
    {
        level.var_b3d6c8db95f62b4a = perks::function_ae69f867e887ac4a( "specialty_tracker_jammer" ) && perks::function_ae69f867e887ac4a( "specialty_tracker_pro" );
    }
    
    if ( level.var_b3d6c8db95f62b4a )
    {
        player perk::giveperk( "specialty_tracker_pro" );
        player perk::giveperk( "specialty_tracker_jammer" );
    }
    
    if ( level.var_c1bb08b1169797fd.var_a5e8acff6312a0d1 )
    {
        thread function_f935b5feaae398db( player );
    }
    
    if ( params.revivespawn && level.var_c1bb08b1169797fd.var_f43ab8dd2b51a0b9 )
    {
        function_9fe35b09302906a0( params );
    }
}

// Namespace wounded_movement
// Params 1, eflags: 0x4
// Checksum 0xd1cb4e4d, Offset: 0xa76
// Size: 0xd1, Type: bool
function private function_625260fd431d764a( player )
{
    if ( !function_4f2523327bf73947( player ) )
    {
        return false;
    }
    
    var_29ef0baea737ad2f = player.health <= ceil( player.maxhealth * level.var_c1bb08b1169797fd.var_6759e517a055b157 );
    
    if ( level.var_c1bb08b1169797fd.var_5a93ed5063c3b2c2 && health_chunks::function_9cb515de902172b5( player ) && player.var_144ad4a5bcb22c3 )
    {
        currentchunk = health_chunks::function_592f3ae4a5ba7280( player );
        
        if ( isdefined( currentchunk ) )
        {
            var_29ef0baea737ad2f = currentchunk.index <= level.var_c1bb08b1169797fd.var_2824fbeb5b97b339 - 1;
        }
    }
    
    return var_29ef0baea737ad2f || level.forcewounded;
}

// Namespace wounded_movement
// Params 1, eflags: 0x4
// Checksum 0x63d271db, Offset: 0xb50
// Size: 0x2b
function private function_8b9426d3f6b856af( player )
{
    return player.maxhealth * level.var_c1bb08b1169797fd.var_6759e517a055b157;
}

// Namespace wounded_movement
// Params 1
// Checksum 0x66baa6cd, Offset: 0xb84
// Size: 0x11d
function function_9fe35b09302906a0( params )
{
    player = self;
    
    if ( !isplayer( player ) || !function_4f2523327bf73947( player ) )
    {
        return;
    }
    
    if ( function_625260fd431d764a( player ) )
    {
        if ( level.var_c1bb08b1169797fd.var_f43ab8dd2b51a0b9 )
        {
            player val::set( "wounded_movement", "move_speed_scale", level.var_c1bb08b1169797fd.minspeedscalar );
        }
        
        player val::set( "wounded_movement", "jog", 0 );
        player val::set( "wounded_movement", "supersprint", 0 );
        
        if ( level.var_b3d6c8db95f62b4a && !player.var_9fe6b7a664c6bffd )
        {
            player perk::removeperk( "specialty_tracker_jammer" );
        }
        
        player.var_9fe6b7a664c6bffd = 1;
        return;
    }
    
    player val::reset_all( "wounded_movement" );
    
    if ( level.var_b3d6c8db95f62b4a && player.var_9fe6b7a664c6bffd )
    {
        player perk::giveperk( "specialty_tracker_jammer" );
    }
    
    player.var_9fe6b7a664c6bffd = undefined;
}

// Namespace wounded_movement
// Params 1, eflags: 0xc
// Checksum 0x8249a442, Offset: 0xca9
// Size: 0x9f
function private function_f935b5feaae398db( player )
{
    self notify( #"hash_40c161b8603a9b8d" );
    self endon( #"hash_40c161b8603a9b8d" );
    player endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    function_98cf49e23fa0aa( player );
    
    while ( true )
    {
        if ( !player::isreallyalive( player ) || !function_4f2523327bf73947( player ) || !function_625260fd431d764a( player ) || player getnormalizedmovement()[ 0 ] == 0 || player playerads() > 0.2 )
        {
            waitframe();
            continue;
        }
        
        limp( player );
    }
}

/#

    // Namespace wounded_movement
    // Params 2, eflags: 0x4
    // Checksum 0xb7bae73d, Offset: 0xd50
    // Size: 0x54, Type: dev
    function private function_38ab8fd9c73708c0( command, args )
    {
        switch ( command )
        {
            case #"hash_63a3625db07241a5":
                level.forcewounded = !istrue( level.forcewounded );
                break;
            default:
                break;
        }
    }

#/
