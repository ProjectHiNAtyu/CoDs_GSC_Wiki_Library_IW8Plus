// scripts\mp\common\killstreaks\bombardment_gas.gsc  (hash_2bd4e0b52e93e073.gscc) (size: 3525 Bytes / 0xdc5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1620fa91 (371260049)
// size ...... 3525 (0xdc5)
// includes .. 3   (offset: 0xd49)
// strings ... 5   (offset: 0xd61)
// dev strs .. 0   (offset: 0xdc5)
// exports ... 11  (offset: 0x7b5)
// cseg ...... 0xd0 + 0x6e5 (0x7b5)
// imports ... 35  (offset: 0x96d)
// animtree1 . 0   (offset: 0xdc5)
// animtree2 . 0   (offset: 0xdc5)
#using script_16ea1b94f0f381b3;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\utility;

#namespace bombardment_gas;

// Namespace bombardment_gas
// Params 0, eflags: 0x1
// Checksum 0x67b3ecc6, Offset: 0xee
// Size: 0x23
function autoexec main()
{
    utility::flag_init( "bombardment_gas_initialized" );
    killstreak_shared::registerkillstreakinitfunction( getxhash( "bombardment_gas" ), &init );
}

// Namespace bombardment_gas
// Params 0
// Checksum 0xac65a53a, Offset: 0x119
// Size: 0x4d
function init()
{
    namespace_9d8e359c3b1041e5::registerkillstreaksharedfunc( "bombardment_gas", &function_e9e643f2f37e4ac5 );
    bundle = level.streakglobals.streakbundles[ "bombardment_gas" ];
    utility::flag_set( "bombardment_gas_initialized" );
    thread function_ca7642ac3cd22d57( bundle );
}

// Namespace bombardment_gas
// Params 1
// Checksum 0x18c1b2dd, Offset: 0x16e
// Size: 0xdb
function function_ca7642ac3cd22d57( bundle )
{
    while ( !utility::flag_exist( "bombardment_common_initialized" ) || !utility::flag( "bombardment_common_initialized" ) )
    {
        waitframe();
    }
    
    utility::callsharedfunc( #"bombardment_common", #"register", "bombardment_gas", bundle.bcdata, &function_9e17699244861696, &function_cb413cc7d1b83efb );
    
    if ( utility::callsharedfunc( #"gas", #"hash_43bf0d88a1c3c9b8", bundle ) )
    {
        gasbundle = getscriptbundle( bundle.gassettings );
        
        if ( !utility::callsharedfunc( #"gas", #"hash_72b9083857205f79", "bombardment_gas" ) )
        {
            utility::callsharedfunc( #"gas", #"hash_b1acc2201b601807", "bombardment_gas", gasbundle );
        }
    }
}

// Namespace bombardment_gas
// Params 6
// Checksum 0x328cbd25, Offset: 0x251
// Size: 0x15f
function function_9e17699244861696( streakinfo, var_ff2c40cf5f0d3cc8, var_d0b84b2215b34610, var_2bfd178bc84d73d7, var_e563c7b55d6eb727, var_56aff40dfda39956 )
{
    bcdata = streakinfo.bundle.bcdata;
    payloadcount = bcdata.bc_payload_per_wave;
    payloadindex = function_3c618cb17219ea2c( streakinfo, var_e563c7b55d6eb727, var_56aff40dfda39956 );
    playerangles = streakinfo.var_37a67976b515ddf;
    wavedistance = streakinfo.bundle.var_d99ac5958c933355 ?? 300;
    angle = 360 / payloadcount * payloadindex + playerangles[ 1 ];
    x = var_ff2c40cf5f0d3cc8[ 0 ] + var_d0b84b2215b34610 * cos( angle );
    y = var_ff2c40cf5f0d3cc8[ 1 ] + var_d0b84b2215b34610 * sin( angle );
    t = ( var_d0b84b2215b34610 + wavedistance * var_e563c7b55d6eb727 ) / var_d0b84b2215b34610;
    finalpoint = ( ( 1 - t ) * var_ff2c40cf5f0d3cc8[ 0 ] + t * ( x, y, var_ff2c40cf5f0d3cc8[ 2 ] )[ 0 ], ( 1 - t ) * var_ff2c40cf5f0d3cc8[ 1 ] + t * ( x, y, var_ff2c40cf5f0d3cc8[ 2 ] )[ 1 ], 0 );
    return ( finalpoint[ 0 ], finalpoint[ 1 ], var_ff2c40cf5f0d3cc8[ 2 ] );
}

// Namespace bombardment_gas
// Params 3
// Checksum 0x6b448cbf, Offset: 0x3b9
// Size: 0x108
function function_3c618cb17219ea2c( streakinfo, var_e563c7b55d6eb727, var_56aff40dfda39956 )
{
    bcdata = streakinfo.bundle.bcdata;
    payloadcount = bcdata.bc_payload_per_wave;
    
    if ( !isdefined( streakinfo.var_bfdb279bcb573687 ) )
    {
        streakinfo.var_bfdb279bcb573687 = [];
    }
    
    if ( !streakinfo.var_bfdb279bcb573687[ var_e563c7b55d6eb727 ] )
    {
        availableindexes = [];
        
        for ( i = 0; i < payloadcount ; i++ )
        {
            availableindexes[ availableindexes.size ] = i;
        }
        
        indexarray = [];
        
        for ( i = 0; i < payloadcount ; i++ )
        {
            index = utility::array_random( availableindexes );
            indexarray[ indexarray.size ] = index;
            availableindexes = arrayremove( availableindexes, index );
        }
        
        streakinfo.var_bfdb279bcb573687[ var_e563c7b55d6eb727 ] = indexarray;
    }
    
    return streakinfo.var_bfdb279bcb573687[ var_e563c7b55d6eb727 ][ var_56aff40dfda39956 ];
}

// Namespace bombardment_gas
// Params 3
// Checksum 0x24cea472, Offset: 0x4ca
// Size: 0x28
function function_cb413cc7d1b83efb( pos, streakinfo, missile )
{
    thread spawngas( pos, streakinfo );
}

// Namespace bombardment_gas
// Params 2
// Checksum 0xaf746d9c, Offset: 0x4fa
// Size: 0x1ab
function spawngas( pos, streakinfo )
{
    bundle = level.streakglobals.streakbundles[ "bombardment_gas" ];
    gassettings = getscriptbundlefieldvalues( bundle.gassettings, [ #"duration", #"radius", #"height" ] );
    createtriggerfunc = utility::getsharedfunc( #"gas", #"hash_87b583f48f67914e" );
    trigger = [[ createtriggerfunc ]]( "bombardment_gas", pos, self, self.team, gassettings.duration, 1, gassettings.radius, gassettings.height, undefined, streakinfo );
    
    /#
        if ( getdvarint( @"hash_8b17514ed1412081", 0 ) )
        {
            thread function_6c07e8d852573aa1( trigger, gassettings.duration );
        }
    #/
    
    gasscriptable = spawnscriptable( bundle.var_bbc749bbd5a4c701 ?? "wz_bombardment_gas", trigger.origin, trigger.angles );
    mapcircle = spawnquestcircle( "NovaGas_Br", trigger.origin[ 0 ], trigger.origin[ 1 ], trigger.radius, self );
    mapcircle show();
    trigger waittill( #"death" );
    gasscriptable freescriptable();
    gasscriptable notify( #"death" );
    mapcircle delete();
}

/#

    // Namespace bombardment_gas
    // Params 2, eflags: 0x4
    // Checksum 0x9a630ef8, Offset: 0x6ad
    // Size: 0xae, Type: dev
    function private function_6c07e8d852573aa1( trigger, duration )
    {
        trigger endon( #"death" );
        radius = trigger.radius;
        height = trigger.height;
        durationms = duration * 1000;
        elapsedtime = 0;
        framedurationms = getframeduration();
        
        while ( elapsedtime < durationms )
        {
            cylinder( trigger.origin, trigger.origin + ( 0, 0, height ), radius );
            waitframe();
            elapsedtime += framedurationms;
        }
    }

#/

// Namespace bombardment_gas
// Params 0
// Checksum 0x8c97adf2, Offset: 0x763
// Size: 0x22
function function_a0507dd99433a3ac()
{
    streakinfo = namespace_9d8e359c3b1041e5::createstreakinfosharedfunc( "bombardment_gas", self );
    return function_e9e643f2f37e4ac5( streakinfo );
}

// Namespace bombardment_gas
// Params 1
// Checksum 0xad5e414, Offset: 0x78e
// Size: 0x26
function function_e9e643f2f37e4ac5( streakinfo )
{
    return utility::callsharedfunc( #"bombardment_common", #"use", streakinfo );
}

