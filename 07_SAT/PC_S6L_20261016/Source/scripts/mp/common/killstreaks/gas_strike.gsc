// scripts\mp\common\killstreaks\gas_strike.gsc  (hash_20d790517ec92fde.gscc) (size: 11097 Bytes / 0x2b59 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6fa9bbd0 (1873394640)
// size ...... 11097 (0x2b59)
// includes .. 12  (offset: 0x29a1)
// strings ... 18  (offset: 0x2a01)
// dev strs .. 1   (offset: 0x2b31)
// exports ... 29  (offset: 0x1c79)
// cseg ...... 0x1d6 + 0x1aa3 (0x1c79)
// imports ... 73  (offset: 0x2101)
// animtree1 . 1   (offset: 0x2b3d)
// animtree2 . 1   (offset: 0x2b49)
#using scripts\common\callbacks;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\utility;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\killstreaks\mapselect;
#using scripts\mp\common\killstreaks\white_phosphorus;
#using scripts\mp\common\supers\gas_trap;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\shellshock_utility;

#namespace gas_strike;

// Namespace gas_strike
// Params 0, eflags: 0x1
// Checksum 0x556f881c, Offset: 0x1f4
// Size: 0x17
function autoexec main()
{
    killstreak_shared::registerkillstreakinitfunction( getxhash( "gas_strike" ), &init );
}

// Namespace gas_strike
// Params 0
// Checksum 0x6d3425ff, Offset: 0x213
// Size: 0x85
function init()
{
    bundle = level.streakglobals.streakbundles[ "gas_strike" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    killstreaks::registerkillstreak( "gas_strike", &function_b6ac6b248211db58 );
    level function_f9aee26082ae3cbd();
    level registervfx();
    var_392e7de132a8e132 = getgameprops();
    
    if ( !isdefined( var_392e7de132a8e132 ) && isdefined( bundle.var_88221697cc90f289 ) )
    {
        setgameprops( bundle.var_88221697cc90f289 );
    }
}

// Namespace gas_strike
// Params 0
// Checksum 0x877d1f70, Offset: 0x2a0
// Size: 0x352
function function_f9aee26082ae3cbd()
{
    bundle = level.streakglobals.streakbundles[ "gas_strike" ];
    assert( isdefined( bundle ) );
    assert( isdefined( bundle.var_3eab8702618b8b9a ) );
    assert( isdefined( bundle.var_26852a444c9ab969 ) );
    assert( isdefined( bundle.var_9ca50a2c0866771d ) );
    assert( isdefined( bundle.var_71ffa55409b8284a ) );
    assert( isdefined( bundle.var_80e39cb1d05ca21d ) );
    assert( isdefined( bundle.var_1fc48e36dcebec52 ) );
    assert( isdefined( bundle.var_6b14dbea25d14738 ) );
    assert( isdefined( bundle.var_50362ba0610dbe3c ) );
    assert( isdefined( bundle.var_fe329aa36595ceb9 ) );
    assert( isdefined( bundle.var_21e275bf6bac5d36 ) );
    assert( isdefined( bundle.var_6fd3ff6e072c548f ) );
    assert( isdefined( bundle.var_c6052f43b051c347 ) );
    assert( isdefined( bundle.deployweaponname ) );
    level.var_7ad4199154e6fc90 = spawnstruct();
    level.var_7ad4199154e6fc90.height = bundle.var_3eab8702618b8b9a;
    level.var_7ad4199154e6fc90.initialradius = bundle.var_26852a444c9ab969;
    level.var_7ad4199154e6fc90.finalradius = bundle.var_9ca50a2c0866771d;
    level.var_7ad4199154e6fc90.var_8bf4ac2a46c4e331 = bundle.var_71ffa55409b8284a;
    level.var_7ad4199154e6fc90.var_8440257504ad2a6a = bundle.var_80e39cb1d05ca21d;
    level.var_7ad4199154e6fc90.hallucinationduration = bundle.var_1fc48e36dcebec52;
    level.var_7ad4199154e6fc90.damage = bundle.var_6b14dbea25d14738;
    level.var_7ad4199154e6fc90.reduceddamage = bundle.var_50362ba0610dbe3c;
    level.var_7ad4199154e6fc90.damageperiod = bundle.var_fe329aa36595ceb9;
    level.var_7ad4199154e6fc90.airspacelimit = bundle.var_21e275bf6bac5d36;
    level.var_7ad4199154e6fc90.spawnprotectionduration = bundle.var_6fd3ff6e072c548f * 1000;
    level.var_7ad4199154e6fc90.vfx = bundle.var_c6052f43b051c347;
    level.var_7ad4199154e6fc90.deployweaponname = bundle.deployweaponname;
    level.var_7ad4199154e6fc90.bundleid = function_43b5ed5a14a56573( #"scriptbundle_killstreak", bundle.var_d80db24c90d421fb );
    killstreaks::registerkillstreakdamagedealingweapon( "gas_strike", bundle.var_8bae5fdc06d1dc42, #"large" );
    level.gasstrike = spawnstruct();
    level.gasstrike.projectile = bundle.var_8bae5fdc06d1dc42;
}

// Namespace gas_strike
// Params 1
// Checksum 0x29505f26, Offset: 0x5fa
// Size: 0x187, Type: bool
function function_b6ac6b248211db58( streakinfo )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( level.gasstrike.active )
    {
        return false;
    }
    
    bundle = level.streakglobals.streakbundles[ "gas_strike" ];
    streakinfo.weaponname = bundle.deployweaponname;
    
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    if ( !isdefined( streakinfo.locationoverride ) )
    {
        deployresult = killstreakdeploy::streakdeploy_doweaponswitchdeploy( streakinfo, makeweapon( level.var_7ad4199154e6fc90.deployweaponname ), 1, &function_fcfdcc569faf906d );
        
        if ( !deployresult )
        {
            return false;
        }
    }
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    useresult = function_9bd0974391dd97ac( streakinfo );
    
    if ( !useresult )
    {
        return false;
    }
    
    used_splash_ref = bundle.usedsplashref;
    
    if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) )
    {
        self thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( used_splash_ref, self );
    }
    
    killstreak_utility::function_e4f54128963e182( level.gasstrike.projectile );
    return true;
}

// Namespace gas_strike
// Params 4
// Checksum 0x2825f072, Offset: 0x78a
// Size: 0xc1
function function_f46cb2655e856aa1( location, startradius, finalradius, owner )
{
    level.gasstrike.var_6361f46951e07425 = spawn( "script_model", ( location[ 0 ], location[ 1 ], startradius ) );
    level.gasstrike.var_6361f46951e07425.hidden = 0;
    level.gasstrike.var_6361f46951e07425 setotherent( owner );
    setomnvar( "ui_gas_strike_ent", level.gasstrike.var_6361f46951e07425 );
    setomnvar( "gas_strike_xhash_asset_idx", level.var_7ad4199154e6fc90.bundleid );
}

// Namespace gas_strike
// Params 2
// Checksum 0xc5ed083b, Offset: 0x853
// Size: 0x4f
function function_e9774827007eccf( var_6361f46951e07425, radius )
{
    decrement = var_6361f46951e07425.origin[ 2 ] - radius;
    var_6361f46951e07425.origin -= ( 0, 0, decrement );
}

// Namespace gas_strike
// Params 1
// Checksum 0x4f06a6ff, Offset: 0x8aa
// Size: 0x31, Type: bool
function function_fcfdcc569faf906d( streakinfo )
{
    mapselect::function_74e31405d43e142( 0, 0, "circle_marker", 0, undefined, level.var_7ad4199154e6fc90.finalradius );
    return true;
}

// Namespace gas_strike
// Params 1
// Checksum 0x644412bf, Offset: 0x8e4
// Size: 0x224, Type: bool
function function_9bd0974391dd97ac( streakinfo )
{
    location = function_b20e2f785b1788e6( streakinfo );
    
    if ( !isdefined( location ) )
    {
        return false;
    }
    
    startradius = streakinfo.var_6f4deb730c0e1d9c ?? level.var_7ad4199154e6fc90.initialradius;
    finalradius = streakinfo.var_c3c4d1c2e7d20554 ?? level.var_7ad4199154e6fc90.finalradius;
    var_8bf4ac2a46c4e331 = streakinfo.var_bc066946c94c8f21 ?? level.var_7ad4199154e6fc90.var_8bf4ac2a46c4e331;
    var_8440257504ad2a6a = streakinfo.var_13d48fdb8c265002 ?? level.var_7ad4199154e6fc90.var_8440257504ad2a6a;
    level.gasstrike.circle = spawn( "script_model", location );
    level.gasstrike.circle.streakinfo = streakinfo;
    level.gasstrike.circle setentityowner( self );
    level.gasstrike.circle.origin = ( location[ 0 ], location[ 1 ], 0 );
    level.gasstrike.circle.radius = startradius;
    level.gasstrike.owner = self;
    level.gasstrike.active = 1;
    level.gasstrike function_f46cb2655e856aa1( location, startradius, finalradius, level.gasstrike.owner );
    level.gasstrike.circle thread function_a8b2786f5ae383f5();
    level thread function_f4547072f340b76d( startradius, finalradius, var_8bf4ac2a46c4e331, var_8440257504ad2a6a );
    var_df09b0750237d451 = spawnbrcircle( location[ 0 ], location[ 1 ], startradius );
    var_df09b0750237d451 brcirclemoveto( location[ 0 ], location[ 1 ], finalradius, var_8bf4ac2a46c4e331 );
    level thread function_d44597fa99e07b82( var_8bf4ac2a46c4e331, var_8440257504ad2a6a, var_df09b0750237d451 );
    return true;
}

// Namespace gas_strike
// Params 3
// Checksum 0x8c9f3da5, Offset: 0xb11
// Size: 0x115
function function_d44597fa99e07b82( var_8bf4ac2a46c4e331, var_8440257504ad2a6a, var_df09b0750237d451 )
{
    var_dfac704f421c92f4 = var_8bf4ac2a46c4e331 + var_8440257504ad2a6a;
    wait var_dfac704f421c92f4;
    var_df09b0750237d451 delete();
    level notify( #"hash_94cdd40f23e6a0d9" );
    level callback::callback( #"killstreak_finish_use", { #streakinfo:level.gasstrike.circle.streakinfo } );
    level destroyemitters( level.gasstrike.emittersprimary );
    level destroyemitters( level.gasstrike.emitterssecondary );
    level destroyemitters( level.gasstrike.emitterstertiary );
    level destroyemitters( level.gasstrike.var_514ad9e62df907ad );
    level.gasstrike.active = 0;
    level.gasstrike.var_6361f46951e07425 delete();
}

// Namespace gas_strike
// Params 4
// Checksum 0x3a1686dd, Offset: 0xc2e
// Size: 0xf1
function function_f4547072f340b76d( startradius, endradius, var_8bf4ac2a46c4e331, var_8440257504ad2a6a )
{
    level endon( #"game_ended" );
    level endon( #"hash_94cdd40f23e6a0d9" );
    wait 0.1;
    starttime = var_8bf4ac2a46c4e331;
    radiusdifference = startradius - endradius;
    
    while ( true )
    {
        if ( var_8bf4ac2a46c4e331 > 0 )
        {
            pct = var_8bf4ac2a46c4e331 / starttime;
            level.gasstrike.circle.radius = endradius + radiusdifference * pct;
            level.gasstrike function_e9774827007eccf( level.gasstrike.var_6361f46951e07425, level.gasstrike.circle.radius );
            var_8bf4ac2a46c4e331 -= level.framedurationseconds;
        }
        
        waitframe();
    }
}

// Namespace gas_strike
// Params 4
// Checksum 0xaebae71d, Offset: 0xd27
// Size: 0x3f4
function function_415bc011722768c6( startradius, endradius, var_8bf4ac2a46c4e331, var_8440257504ad2a6a )
{
    level endon( #"game_ended" );
    level endon( #"hash_94cdd40f23e6a0d9" );
    level.gasstrike.emittersprimary = spawnentsincircle( level.gasstrike.circle.origin, level.gasstrike.circle.radius, 35 );
    level.gasstrike.emitterssecondary = spawnentsincircle( level.gasstrike.circle.origin, level.var_7ad4199154e6fc90.initialradius * 1.25, 35 );
    level.gasstrike.emitterstertiary = spawnentsincircle( level.gasstrike.circle.origin, level.var_7ad4199154e6fc90.initialradius * 1.75, 35 );
    level.gasstrike.var_514ad9e62df907ad = spawnentsincircle( level.gasstrike.circle.origin, level.var_7ad4199154e6fc90.initialradius * 2.25, 35 );
    wait 0.1;
    function_246c243d0545fd1a( level.gasstrike.emittersprimary );
    function_246c243d0545fd1a( level.gasstrike.emitterssecondary );
    function_246c243d0545fd1a( level.gasstrike.emitterstertiary );
    function_246c243d0545fd1a( level.gasstrike.var_514ad9e62df907ad );
    starttime = var_8bf4ac2a46c4e331;
    var_f9025f5baadbf04b = 5;
    radiusdifference = startradius - endradius;
    
    while ( true )
    {
        if ( var_8bf4ac2a46c4e331 > 0 )
        {
            pct = var_8bf4ac2a46c4e331 / starttime;
            level.gasstrike.circle.radius = endradius + radiusdifference * pct;
            level.gasstrike function_e9774827007eccf( level.gasstrike.var_6361f46951e07425, level.gasstrike.circle.radius );
            var_8bf4ac2a46c4e331 -= level.framedurationseconds;
            updateemitterpositions( level.gasstrike.circle.origin, level.gasstrike.circle.radius, level.gasstrike.emittersprimary );
        }
        
        if ( var_f9025f5baadbf04b <= 0 )
        {
            function_f87dbcadd617b68c( level.gasstrike.emittersprimary );
            function_f87dbcadd617b68c( level.gasstrike.emitterssecondary );
            function_f87dbcadd617b68c( level.gasstrike.emitterstertiary );
            function_f87dbcadd617b68c( level.gasstrike.var_514ad9e62df907ad );
            var_f9025f5baadbf04b = 5;
            wait 0.1;
            function_246c243d0545fd1a( level.gasstrike.emittersprimary );
            function_246c243d0545fd1a( level.gasstrike.emitterssecondary );
            function_246c243d0545fd1a( level.gasstrike.emitterstertiary );
            function_246c243d0545fd1a( level.gasstrike.var_514ad9e62df907ad );
        }
        
        var_f9025f5baadbf04b -= level.framedurationseconds;
        waitframe();
    }
}

// Namespace gas_strike
// Params 1
// Checksum 0xe5c41cca, Offset: 0x1123
// Size: 0x44
function function_246c243d0545fd1a( emitters )
{
    for ( i = 0; i < emitters.size ; i++ )
    {
        playfxontag( level._effect[ "vfx_gas_ring_puffy" ], emitters[ i ], "tag_origin" );
    }
}

// Namespace gas_strike
// Params 3
// Checksum 0x687eaae0, Offset: 0x116f
// Size: 0xe0
function spawnentsincircle( center, radius, steps )
{
    emitters = [];
    stepdegrees = 360 / steps;
    
    for ( i = 0; i < steps ; i++ )
    {
        angle = stepdegrees * i;
        y = sin( angle ) * radius;
        x = cos( angle ) * radius;
        groundpos = center + ( x, y, 0 );
        emitters[ i ] = spawn( "script_model", groundpos );
        emitters[ i ] setmodel( "tag_origin" );
        emitters[ i ].origin = groundpos;
        emitters[ i ].angles = ( 0, angle + 180, 0 );
    }
    
    return emitters;
}

// Namespace gas_strike
// Params 3
// Checksum 0x92dad1ec, Offset: 0x1258
// Size: 0xc2
function updateemitterpositions( center, newradius, emitters )
{
    count = emitters.size;
    stepdegrees = 360 / count;
    
    for ( i = 0; i < count ; i++ )
    {
        angle = stepdegrees * i;
        y = sin( angle ) * newradius;
        x = cos( angle ) * newradius;
        groundpos = center + ( x, y, 0 );
        emitters[ i ].origin = groundpos;
        emitters[ i ].angles = ( 0, angle + 180, 0 );
    }
}

// Namespace gas_strike
// Params 1
// Checksum 0xb69011ed, Offset: 0x1322
// Size: 0x4c
function function_f87dbcadd617b68c( emitters )
{
    for ( i = 0; i < emitters.size ; i++ )
    {
        if ( isdefined( emitters[ i ] ) )
        {
            stopfxontag( level._effect[ "vfx_gas_ring_puffy" ], emitters[ i ], "tag_origin" );
        }
    }
}

// Namespace gas_strike
// Params 1
// Checksum 0x5b89b6c4, Offset: 0x1376
// Size: 0x55
function destroyemitters( emitters )
{
    for ( i = 0; i < emitters.size ; i++ )
    {
        if ( isdefined( emitters[ i ] ) )
        {
            stopfxontag( level._effect[ "vfx_gas_ring_puffy" ], emitters[ i ], "tag_origin" );
            emitters[ i ] delete();
        }
    }
}

// Namespace gas_strike
// Params 0
// Checksum 0xce3cee5d, Offset: 0x13d3
// Size: 0x29
function registervfx()
{
    level._effect[ "vfx_gas_ring_puffy" ] = loadfxasset( level.var_7ad4199154e6fc90.vfx );
}

/#

    // Namespace gas_strike
    // Params 0
    // Checksum 0xb07356b0, Offset: 0x1404
    // Size: 0xba, Type: dev
    function function_ada3eca343dfee0b()
    {
        level endon( #"game_ended" );
        level endon( #"hash_94cdd40f23e6a0d9" );
        circle = self;
        
        while ( true )
        {
            waitframe();
            center = ( circle.origin[ 0 ], circle.origin[ 1 ], 0 );
            line( center, center + ( 0, 0, 5000 ), ( 1, 1, 0 ), 1, 1, 1 );
            cylinder( center, center + ( 0, 0, 5000 ), circle.radius, ( 1, 1, 0 ), 1, 1 );
        }
    }

#/

// Namespace gas_strike
// Params 0
// Checksum 0x807f2c17, Offset: 0x14c6
// Size: 0x2d5
function function_a8b2786f5ae383f5()
{
    level endon( #"game_ended" );
    level endon( #"hash_94cdd40f23e6a0d9" );
    damagetick = level.var_7ad4199154e6fc90.damage;
    var_2018719f1f199d0c = level.var_7ad4199154e6fc90.reduceddamage;
    
    while ( true )
    {
        radiussquared = level.gasstrike.circle.radius * level.gasstrike.circle.radius;
        currenttime = gettime();
        
        foreach ( player in level.players )
        {
            if ( !( isdefined( player ) && isdefined( player.origin ) ) )
            {
                continue;
            }
            
            if ( !player::isreallyalive( player ) )
            {
                continue;
            }
            
            if ( !level.gasstrike.owner player_utility::isenemy( player ) )
            {
                continue;
            }
            
            if ( distance2dsquared( level.gasstrike.circle.origin, player.origin ) >= radiussquared )
            {
                if ( currenttime - player.lastspawntime < level.var_7ad4199154e6fc90.spawnprotectionduration )
                {
                    continue;
                }
                
                if ( !isdefined( player.perks[ "specialty_gas_immunity" ] ) )
                {
                    if ( isdefined( player.perks[ "specialty_gas_grenade_resist" ] ) )
                    {
                        player dodamage( var_2018719f1f199d0c, player.origin, level.gasstrike.owner, level.gasstrike.circle, "MOD_TRIGGER_HURT", level.gasstrike.projectile );
                    }
                    else
                    {
                        player dodamage( damagetick, player.origin, level.gasstrike.owner, level.gasstrike.circle, "MOD_TRIGGER_HURT", level.gasstrike.projectile );
                    }
                }
                
                if ( !isdefined( player.perks[ "specialty_hallucination_immunity" ] ) )
                {
                    if ( !player.var_955518e3fd692fbd )
                    {
                        player thread function_2784be45c88f07fe();
                    }
                }
            }
        }
        
        wait level.var_7ad4199154e6fc90.damageperiod;
    }
}

// Namespace gas_strike
// Params 0
// Checksum 0xb1516dc6, Offset: 0x17a3
// Size: 0xa0
function function_2784be45c88f07fe()
{
    self notify( #"hash_d34858705883798c" );
    self endon( #"hash_d34858705883798c" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self.var_955518e3fd692fbd = 1;
    childthread function_f3bf1eea0ce171b7();
    function_bcea4ea5717aad7e();
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"gas_hallucination" ][ #"hash_fafb93cf2eff0b4b" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]( level.streakglobals.streakbundles[ "gas_strike" ] );
    }
    
    childthread function_e4fcae43cfa6ae68();
}

// Namespace gas_strike
// Params 0
// Checksum 0x29c6e234, Offset: 0x184b
// Size: 0x9b
function function_f3bf1eea0ce171b7()
{
    waitmsg = utility::waittill_any_timeout( level.var_7ad4199154e6fc90.hallucinationduration, "death" );
    clearedondeath = waitmsg == "death";
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"gas_hallucination" ][ #"hash_f00f78b8f103a397" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]( level.streakglobals.streakbundles[ "gas_strike" ] );
    }
    
    function_a7b4913761adc9b();
    self.var_955518e3fd692fbd = 0;
}

// Namespace gas_strike
// Params 0
// Checksum 0x3c2ce5c5, Offset: 0x18ee
// Size: 0x2b
function function_e4fcae43cfa6ae68()
{
    while ( self.var_955518e3fd692fbd )
    {
        gas_trap::function_ecdaac79558cbea0( level.gasstrike.owner );
    }
}

// Namespace gas_strike
// Params 0
// Checksum 0xd8ace0ff, Offset: 0x1921
// Size: 0x8b
function function_bcea4ea5717aad7e()
{
    bundle = level.streakglobals.streakbundles[ "gas_strike" ];
    [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_382df7654f0561bd" ] ]]( { #postfxbundlename:bundle.var_a07a5f015d0081ef ?? %"cer_hallucination_gas" }, 1, 1 );
    shellshock_utility_cpmp::_shellshock( %"gas_grenade_light_full_movement_mp", #"gas", 7, 0 );
}

// Namespace gas_strike
// Params 0
// Checksum 0xdf5f2c92, Offset: 0x19b4
// Size: 0x76
function function_a7b4913761adc9b()
{
    bundle = level.streakglobals.streakbundles[ "gas_strike" ];
    [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_494b07757cd511a5" ] ]]( { #postfxbundlename:bundle.var_a07a5f015d0081ef ?? %"cer_hallucination_gas" } );
    
    if ( !self.var_955518e3fd692fbd )
    {
        return;
    }
}

// Namespace gas_strike
// Params 0
// Checksum 0xf65bcb9, Offset: 0x1a32
// Size: 0x2c
function function_2e2251606a04976f()
{
    gas_trap::function_b40b196978589f78( 0 );
    childthread gas_trap::function_cb34c58ba3ad40fb( level.gasstrike.owner, 0 );
    white_phosphorus::enableloopingcoughaudio();
}

#using_animtree( "script_model" );

// Namespace gas_strike
// Params 0
// Checksum 0xf21d3812, Offset: 0x1a66
// Size: 0x33
function function_b885089bc25f1d63()
{
    level.scr_animtree[ "gas_strike" ] = #animtree;
    level.scr_anim[ "gas_strike" ][ "flyby" ] = %mp_alfa10_flyin;
}

// Namespace gas_strike
// Params 1
// Checksum 0x5a4416a3, Offset: 0x1aa1
// Size: 0xe8
function function_b20e2f785b1788e6( streakinfo )
{
    var_8224dc8ea3556e1e = undefined;
    
    if ( !isdefined( streakinfo.locationoverride ) )
    {
        mappointinfo = undefined;
        directionalselection = 0;
        self setsoundsubmix( "mp_killstreak_overlay" );
        mappointinfo = mapselect::function_ec95e9f1b6d329fb( streakinfo, undefined, directionalselection );
        
        if ( !isdefined( mappointinfo ) )
        {
            return;
        }
        
        self clearsoundsubmix( "mp_killstreak_overlay" );
        streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
        
        if ( !inmapbounds( mappointinfo[ 0 ].location ) )
        {
            /#
                printtoscreen2d( 1000, 500, "<dev string:x24>", ( 1, 1, 1 ), 3, 150 );
            #/
            
            return;
        }
        
        var_8224dc8ea3556e1e = mappointinfo[ 0 ].location;
    }
    else
    {
        var_8224dc8ea3556e1e = streakinfo.locationoverride;
    }
    
    var_8224dc8ea3556e1e = getclosestpointonnavmesh( var_8224dc8ea3556e1e );
    self notify( #"successful_fire" );
    return var_8224dc8ea3556e1e;
}

// Namespace gas_strike
// Params 1
// Checksum 0x29819c41, Offset: 0x1b92
// Size: 0xe6, Type: bool
function inmapbounds( point )
{
    spherecast_radius = 250;
    contents = physics_createcontents( [ "physicscontents_trigger" ] );
    results = physics_spherecast( point, point, spherecast_radius, contents, undefined, "physicsquery_all", undefined, 1 );
    
    foreach ( result in results )
    {
        ent = result[ "entity" ];
        
        if ( isdefined( ent ) && ent.targetname == "OutOfBounds" )
        {
            return false;
        }
    }
    
    return true;
}

