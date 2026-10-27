// scripts\mp\br\gametypes\br_detonator_challenge.gsc  (hash_08d7ea5bc991d2fc.gscc) (size: 5651 Bytes / 0x1613 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7dc9fb36 (2110389046)
// size ...... 5651 (0x1613)
// includes .. 9   (offset: 0x14a3)
// strings ... 21  (offset: 0x14eb)
// dev strs .. 0   (offset: 0x1613)
// exports ... 18  (offset: 0xc53)
// cseg ...... 0x1d7 + 0xa7c (0xc53)
// imports ... 48  (offset: 0xf23)
// animtree1 . 0   (offset: 0x1613)
// animtree2 . 0   (offset: 0x1613)
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\flags;
#using scripts\mp\poi;

#namespace br_detonator_challenge;

// Namespace br_detonator_challenge
// Params 0
// Checksum 0x5ccaac5f, Offset: 0x1f5
// Size: 0x1d
function main()
{
    if ( getdvarint( @"hash_fdd2344d2352c119", 0 ) == 0 )
    {
        return;
    }
    
    init();
}

// Namespace br_detonator_challenge
// Params 0
// Checksum 0x5d5a5f4b, Offset: 0x21a
// Size: 0x37
function init()
{
    level.detonator_challenge = spawnstruct();
    scriptable::scriptable_addusedcallbackbypart( "br_bomb_detonator", &function_42a8a43404a25f58 );
    level thread initpostmain();
    level thread onplayerconnect();
    initdialog();
}

// Namespace br_detonator_challenge
// Params 0
// Checksum 0xd129c449, Offset: 0x259
// Size: 0x31
function initpostmain()
{
    waittillframeend();
    flags::gameflaginit( "detonators_spawned", 0 );
    function_5608bc2dda252e9f();
    registerdvars();
    flags::gameflagwait( "prematch_fade_done" );
    spawndetonators();
}

// Namespace br_detonator_challenge
// Params 0
// Checksum 0xf2f0c5c5, Offset: 0x292
// Size: 0x60
function initdialog()
{
    if ( game_utility::getgametype() == "dmz" )
    {
        game[ "dialog" ][ "found_detonator" ] = "bmbd_ovld_fond";
        game[ "dialog" ][ "near_detonator" ] = "bmbd_ovld_near";
        return;
    }
    
    game[ "dialog" ][ "found_detonator" ] = "bmbd_wzan_foun";
    game[ "dialog" ][ "near_detonator" ] = "bmbd_wzan_near";
}

// Namespace br_detonator_challenge
// Params 0
// Checksum 0xfb3ba284, Offset: 0x2fa
// Size: 0x118
function registerdvars()
{
    level.detonator_challenge.var_4acb023a32995698 = [];
    
    foreach ( poiname, _ in level.detonator_challenge.var_ea15e8203b4fe797 )
    {
        var_655ed0b73feb1e5a = hashcat( @"hash_8cc03276a2993c6a", poiname );
        
        if ( isdvardefined( var_655ed0b73feb1e5a ) )
        {
            level.detonator_challenge.var_4acb023a32995698[ poiname ] = getdvarint( var_655ed0b73feb1e5a );
        }
    }
    
    level.detonator_challenge.var_97a0153692eba75f = getdvarint( @"hash_48b16f2ada78cc12", 1 );
    
    /#
        level.detonator_challenge.var_278f43ea266ed8eb = getdvarint( @"hash_4c8b3119a2a2ce38", 0 );
    #/
}

// Namespace br_detonator_challenge
// Params 0
// Checksum 0x463408ea, Offset: 0x41a
// Size: 0x2c
function onplayerconnect()
{
    while ( true )
    {
        level waittill( #"connected", player );
        player thread function_6d0dc0c6ad356407();
    }
}

// Namespace br_detonator_challenge
// Params 0
// Checksum 0x5bbf3f29, Offset: 0x44e
// Size: 0x38
function function_6d0dc0c6ad356407()
{
    player = self;
    player endon( #"disconnect" );
    flags::gameflagwait( "detonators_spawned" );
    function_63bb02bb5dc347b1();
    player thread function_281a1d4e57eb0bcd();
}

// Namespace br_detonator_challenge
// Params 0
// Checksum 0x50e88221, Offset: 0x48e
// Size: 0x8f
function function_6d2d0f28a032e434()
{
    player = self;
    
    foreach ( instance in level.detonator_challenge.detonatorscriptables )
    {
        instance disablescriptableplayeruse( player );
    }
}

// Namespace br_detonator_challenge
// Params 0
// Checksum 0x9d4d1dfb, Offset: 0x525
// Size: 0x8f
function function_63bb02bb5dc347b1()
{
    player = self;
    
    foreach ( instance in level.detonator_challenge.detonatorscriptables )
    {
        instance enablescriptableplayeruse( player );
    }
}

// Namespace br_detonator_challenge
// Params 0
// Checksum 0x85e62d85, Offset: 0x5bc
// Size: 0xd7
function function_5608bc2dda252e9f()
{
    while ( !utility::flag_exist( "create_script_initialized" ) )
    {
        waitframe();
    }
    
    utility::flag_wait( "create_script_initialized" );
    waitframe();
    detonators = utility::getstructarray( "bomb_detonator_location", "targetname" );
    level.detonator_challenge.var_ea15e8203b4fe797 = [];
    
    foreach ( detonator in detonators )
    {
        function_606d2adda4a27ed1( detonator.origin, detonator.angles );
    }
}

// Namespace br_detonator_challenge
// Params 2
// Checksum 0x8da7eb3a, Offset: 0x69b
// Size: 0xcc
function function_606d2adda4a27ed1( origin, angles )
{
    detonatorpoi = poi::poi_findpoioriginisin( origin );
    
    if ( !isdefined( detonatorpoi ) )
    {
        return;
    }
    
    detonatorpoi = strtok( detonatorpoi, "_" )[ 1 ];
    
    if ( !isdefined( level.detonator_challenge.var_ea15e8203b4fe797[ detonatorpoi ] ) )
    {
        level.detonator_challenge.var_ea15e8203b4fe797[ detonatorpoi ] = [];
    }
    
    detonatortransform = spawnstruct();
    detonatortransform.origin = origin;
    detonatortransform.angles = angles;
    level.detonator_challenge.var_ea15e8203b4fe797[ detonatorpoi ][ level.detonator_challenge.var_ea15e8203b4fe797[ detonatorpoi ].size ] = detonatortransform;
}

// Namespace br_detonator_challenge
// Params 0
// Checksum 0xa1724ab3, Offset: 0x76f
// Size: 0x13c
function spawndetonators()
{
    level.detonator_challenge.detonatorscriptables = [];
    
    foreach ( poiname, var_ea15e8203b4fe797 in level.detonator_challenge.var_ea15e8203b4fe797 )
    {
        if ( isdefined( level.detonator_challenge.var_4acb023a32995698[ poiname ] ) )
        {
            forcedindex = level.detonator_challenge.var_4acb023a32995698[ poiname ];
            function_44ed11119ace80b4( poiname, var_ea15e8203b4fe797[ forcedindex ] );
            continue;
        }
        
        var_ea15e8203b4fe797 = arrayrandomize( var_ea15e8203b4fe797 );
        detonatorscount = int( min( level.detonator_challenge.var_97a0153692eba75f, var_ea15e8203b4fe797.size ) );
        
        for ( i = 0; i < detonatorscount ; i++ )
        {
            function_44ed11119ace80b4( poiname, var_ea15e8203b4fe797[ i ] );
        }
    }
    
    flags::gameflagset( "detonators_spawned" );
}

// Namespace br_detonator_challenge
// Params 0
// Checksum 0xe238c860, Offset: 0x8b3
// Size: 0xc6
function function_281a1d4e57eb0bcd()
{
    player = self;
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    voradius = getdvarint( @"hash_f952180d2a24d4c9", 450 );
    cooldowntime = getdvarint( @"hash_58b55aeb05b4d7ae", 60 );
    
    if ( cooldowntime == 0 )
    {
        return;
    }
    
    while ( true )
    {
        detonatorinrange = function_be8a545434902072( player, voradius );
        
        if ( isdefined( detonatorinrange ) && !arraycontains( detonatorinrange.var_99a19cd7b9c155ef, player ) )
        {
            level thread br_public::brleaderdialogplayer( "near_detonator", player, 1, 0, undefined, undefined, "dx_br_bds4_" );
            wait cooldowntime;
            function_e4fa6083a75e665c( player, voradius );
            continue;
        }
        
        wait 1;
    }
}

// Namespace br_detonator_challenge
// Params 2
// Checksum 0xb94c32b6, Offset: 0x981
// Size: 0x115
function function_be8a545434902072( player, maxradius )
{
    assert( isdefined( level.detonator_challenge ) );
    assert( isdefined( level.detonator_challenge.detonatorscriptables ) );
    
    if ( !player::isreallyalive( player ) )
    {
        return;
    }
    
    maxradiussquared = maxradius * maxradius;
    
    foreach ( detonator in level.detonator_challenge.detonatorscriptables )
    {
        assert( isdefined( detonator ) && isdefined( detonator.origin ) );
        
        if ( distancesquared( detonator.origin, player.origin ) <= maxradiussquared )
        {
            return detonator;
        }
    }
}

// Namespace br_detonator_challenge
// Params 2
// Checksum 0x93f1eeaf, Offset: 0xa9f
// Size: 0x28
function function_e4fa6083a75e665c( player, voradius )
{
    while ( isdefined( function_be8a545434902072( player, voradius ) ) )
    {
        wait 1;
    }
}

// Namespace br_detonator_challenge
// Params 2
// Checksum 0x16efe2db, Offset: 0xacf
// Size: 0xc6
function function_44ed11119ace80b4( poiname, detonatortransform )
{
    scriptable = spawn( "script_model", detonatortransform.origin );
    scriptable.angles = detonatortransform.angles;
    scriptable setmodel( "offhand_2h_wm_briefcase_bomb_delta" );
    scriptable hudoutlineenable( "shimmer_default" );
    level.detonator_challenge.detonatorscriptables[ poiname ] = scriptable;
    scriptable.var_99a19cd7b9c155ef = [];
    
    /#
        if ( level.detonator_challenge.var_278f43ea266ed8eb )
        {
            thread debug::drawsphere( detonatortransform.origin, 128, 10000, ( 0, 1, 0 ) );
        }
    #/
}

// Namespace br_detonator_challenge
// Params 6
// Checksum 0x7449d0ab, Offset: 0xb9d
// Size: 0xb6
function function_42a8a43404a25f58( instance, part, state, player, bautouse, usestring )
{
    if ( state == "on" )
    {
        challenges::function_37e945722d6497f3( player, "find_bomb_detonator", 1 );
        level thread br_public::brleaderdialogplayer( "found_detonator", player, 1, 0, undefined, undefined, "dx_br_bds4_" );
        instance disablescriptableplayeruse( player );
        instance.entity hudoutlinedisableforclient( player );
        instance.entity.var_99a19cd7b9c155ef[ instance.entity.var_99a19cd7b9c155ef.size ] = player;
    }
}

