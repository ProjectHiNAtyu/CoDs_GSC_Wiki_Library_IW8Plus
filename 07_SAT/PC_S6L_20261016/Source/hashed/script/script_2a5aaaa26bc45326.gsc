// script_2a5aaaa26bc45326  (hash_2a5aaaa26bc45326.gscc) (size: 17024 Bytes / 0x4280 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6a2c56d (111330669)
// size ...... 17024 (0x4280)
// includes .. 10  (offset: 0x41ac)
// strings ... 9   (offset: 0x41fc)
// dev strs .. 0   (offset: 0x4280)
// exports ... 30  (offset: 0x3118)
// cseg ...... 0xec + 0x302c (0x3118)
// imports ... 95  (offset: 0x35c8)
// animtree1 . 0   (offset: 0x4280)
// animtree2 . 0   (offset: 0x4280)
#using script_2202b0478c57bf0d;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\airdrop_scriptbundle;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\damagefeedback;
#using scripts\mp\weapons;

#namespace namespace_13d6a823fb364dea;

// Namespace namespace_13d6a823fb364dea
// Params 0, eflags: 0x5
// Checksum 0xd3cc391e, Offset: 0x10a
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_d32634bec6de2935", #"airdrop_scriptbundle", &pre_main, undefined );
}

// Namespace namespace_13d6a823fb364dea
// Params 0, eflags: 0x4
// Checksum 0xcc63b90c, Offset: 0x133
// Size: 0x55
function private pre_main()
{
    if ( !level.package_airdrop.enabled )
    {
        return;
    }
    
    level.package_airdrop.var_20752dbe2e8b4a47 = [];
    level thread function_e383ac8d1544066b();
    utility::registersharedfunc( #"start_airdrop", #"flee_drone", &function_a6b97d86b3d5be99 );
}

// Namespace namespace_13d6a823fb364dea
// Params 0, eflags: 0x4
// Checksum 0xcdb90da3, Offset: 0x190
// Size: 0xc9
function private function_e383ac8d1544066b()
{
    level waittill( #"game_ended" );
    
    foreach ( drone in level.package_airdrop.var_20752dbe2e8b4a47 )
    {
        if ( !isdefined( drone ) || drone.var_44f52ace6119ee1d || drone.var_dcf7b7678590b6c5 || drone.var_f97ddc37d2cacd36 )
        {
            continue;
        }
        
        drone thread function_6905a67cd601eff2();
    }
}

// Namespace namespace_13d6a823fb364dea
// Params 0, eflags: 0x4
// Checksum 0xacb46f6d, Offset: 0x261
// Size: 0x180
function private function_6905a67cd601eff2()
{
    drone = self;
    drone endon( #"main_drone_destroyed" );
    
    if ( drone.var_44f52ace6119ee1d || drone.var_dcf7b7678590b6c5 || drone.var_f97ddc37d2cacd36 )
    {
        return;
    }
    
    behaviorsettings = level.package_airdrop.airdroptypes[ drone.airdropsettings.airdropidentifier ].airdropbehavior[ 0 ].variant_object;
    drone.disabledamage = 1;
    drone setcandamage( 0 );
    drone notify( #"hash_84941674cca5e76d" );
    drone notify( #"stop_moving" );
    
    if ( !behaviorsettings.neverdrop && !drone.airdropsettings.extradata.skipdrop && !drone.var_a1e594c2cae42e0b )
    {
        detachvelocity = drone function_4c9331f364c0b70a();
        drone function_4e9df023166f6742( undefined, detachvelocity );
    }
    
    if ( randomint( 100 ) < 35 )
    {
        wait randomfloatrange( 0.1, 0.6 );
        
        if ( !isdefined( drone ) )
        {
            return;
        }
        
        drone namespace_df4ff65d6946b16b::droneexplosion();
        drone namespace_df4ff65d6946b16b::function_3168a034ee7decb5();
        drone function_106af240fb18f2e0();
        drone delete();
        return;
    }
    
    drone thread function_7a48b23074c12bce( randomfloatrange( 0.25, 1.5 ) );
}

// Namespace namespace_13d6a823fb364dea
// Params 1, eflags: 0x4
// Checksum 0xa6f956e3, Offset: 0x3e9
// Size: 0x3b4
function private function_a6b97d86b3d5be99( airdropsettings )
{
    behaviorsettings = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ].airdropbehavior[ 0 ].variant_object;
    
    if ( airdropsettings.overrideoptions.fleespawnorigin )
    {
        droplocation = airdropsettings.overrideoptions.fleespawnorigin;
    }
    else
    {
        groundlocation = airdrop_scriptbundle::function_15ad4ce1fcf6748f( airdropsettings.droparea.origin ) ?? airdropsettings.droparea.origin;
        dropheight = airdropsettings.overrideoptions.dropheight ?? behaviorsettings.dropheight;
        droplocation = ( groundlocation[ 0 ], groundlocation[ 1 ], groundlocation[ 2 ] + dropheight );
    }
    
    drone = spawn( "script_model", droplocation );
    drone setmodel( behaviorsettings.dronemodel );
    drone.angles = airdropsettings.overrideoptions.fleespawnangles ?? ( 0, 0, 0 );
    drone setcandamage( 1 );
    drone enableaimassist();
    drone.var_514172427acb20c1 = &function_bb490c52d8dffb3b;
    drone.health = airdropsettings.overrideoptions.fleehealth ?? behaviorsettings.dronehealth;
    drone.maxhealth = airdropsettings.overrideoptions.fleemaxhealth ?? behaviorsettings.dronehealth;
    drone.owner = airdropsettings.player;
    drone.team = airdropsettings.team ?? "drone_dummy_team";
    drone.airdropsettings = airdropsettings;
    drone.var_a1e594c2cae42e0b = 0;
    drone.disabledamage = 0;
    drone.spawnlocation = droplocation;
    drone.var_fe3437bbc52ad866 = behaviorsettings.var_fe3437bbc52ad866;
    weapons::function_ef0cb557b1a93af9( drone );
    
    if ( behaviorsettings.var_5a56c0c764b7a755 )
    {
        drone.linkedscriptable = spawnscriptable( behaviorsettings.var_5a56c0c764b7a755, drone.origin );
        drone.linkedscriptable utility::scriptable_setparententity( drone, ( 0, 0, behaviorsettings.var_e89bbdec27fe1979 ) );
    }
    
    drone namespace_df4ff65d6946b16b::function_9e7626e811447e42();
    function_8cea566167e35b04( drone, airdropsettings.overrideoptions.fleeattacker );
    level.package_airdrop.var_20752dbe2e8b4a47[ level.package_airdrop.var_20752dbe2e8b4a47.size ] = drone;
    calloutmarkerping::function_6052d1ed5729bcfc( drone );
    
    if ( drone.var_fe3437bbc52ad866 )
    {
        utility::callsharedfunc( #"emp", #"hash_71bd51894f6f9085", drone, &droneemp );
        
        if ( level.var_36218e71baa7e689 )
        {
            drone.var_c5ccf9dff3b5e393 = &function_9df8d8c8ffb546dd;
        }
        
        if ( level.var_36218e71baa7e689 )
        {
            level.var_89fe7f9fa2bc945d[ level.var_89fe7f9fa2bc945d.size ] = drone;
        }
    }
    
    drone airdrop_scriptbundle::function_e9dbf2aaef9f1c96( airdropsettings, #"hash_cb68d69fe85eb56f", drone );
    drone namespace_df4ff65d6946b16b::function_8eeb9413290d228a();
    drone thread function_2e32e363bba89747();
    drone thread damagethink();
}

// Namespace namespace_13d6a823fb364dea
// Params 2, eflags: 0x4
// Checksum 0x421ad395, Offset: 0x7a5
// Size: 0x39d
function private function_8cea566167e35b04( drone, eattacker )
{
    behaviorsettings = level.package_airdrop.airdroptypes[ drone.airdropsettings.airdropidentifier ].airdropbehavior[ 0 ].variant_object;
    now = gettime();
    drone.targetplayer = eattacker;
    drone.lastattacker = eattacker;
    drone.fleespeed = 0;
    drone.var_b2a55cf858bab65a = behaviorsettings.cruisespeed;
    drone.var_ea8113b034db4ba5 = drone.angles[ 1 ];
    drone.var_1ffe7021d6fdf7ca = drone.angles[ 1 ];
    drone.var_6e0dd18fd1037fec = drone.angles[ 1 ];
    drone.droporigin = drone.airdropsettings.droparea.origin;
    drone.var_c6f24c128f315724 = now;
    drone.fleestarttime = now;
    drone.washovering = 0;
    drone.var_d811a597fd3a6771 = drone.origin[ 2 ];
    drone.var_8ef6e8c9d6d975af = 0;
    drone.smoothpitch = 0;
    drone.smoothroll = 0;
    drone.var_505d58445149b0e5 = 0;
    drone.var_46abfca91bf4538f = 0;
    drone.var_7e234d45e587e24d = 0;
    drone.var_7543d7c29172e65f = 0;
    drone.var_d63af54b76276dfe = 0;
    drone.obstacleclimbing = 0;
    drone.var_1eb092b0eeac4d81 = drone.origin[ 2 ];
    drone.var_7629eac10ec2ee88 = behaviorsettings.var_6109d8ca45d6e5da;
    drone.var_c0fe0d0126ed0a63 = undefined;
    initialvelocity = drone.airdropsettings.overrideoptions.var_5a1a4638f0b8eae1;
    
    if ( initialvelocity )
    {
        var_a9d821f6f2fdb303 = distance( ( initialvelocity[ 0 ], initialvelocity[ 1 ], 0 ), ( 0, 0, 0 ) );
        
        if ( var_a9d821f6f2fdb303 > 1 )
        {
            drone.fleespeed = min( var_a9d821f6f2fdb303, behaviorsettings.cruisespeed );
            drone.var_1ffe7021d6fdf7ca = vectortoangles( vectornormalize2( initialvelocity ) )[ 1 ];
            drone.var_6e0dd18fd1037fec = drone.var_1ffe7021d6fdf7ca;
            tiltmag = drone.fleespeed / behaviorsettings.cruisespeed;
            
            if ( tiltmag > 1 )
            {
                tiltmag = 1;
            }
            
            droneforward = anglestoforward( ( 0, drone.var_ea8113b034db4ba5, 0 ) );
            droneright = anglestoright( ( 0, drone.var_ea8113b034db4ba5, 0 ) );
            movedir = anglestoforward( ( 0, drone.var_1ffe7021d6fdf7ca, 0 ) );
            tiltfactor = behaviorsettings.movetilt * tiltmag;
            drone.smoothpitch = tiltfactor * vectordot( movedir, droneforward );
            drone.smoothroll = tiltfactor * vectordot( movedir, droneright );
        }
        
        drone.var_8ef6e8c9d6d975af = initialvelocity[ 2 ];
    }
}

// Namespace namespace_13d6a823fb364dea
// Params 2, eflags: 0x4
// Checksum 0x15994e19, Offset: 0xb4a
// Size: 0x80
function private function_bb490c52d8dffb3b( drone, impulse )
{
    if ( !drone || drone.disabledamage || impulse <= 0 )
    {
        return;
    }
    
    vehicle = self;
    attacker = vehicle_occupancy::get_driver( vehicle );
    
    if ( !isdefined( attacker ) )
    {
        attacker = vehicle;
    }
    
    drone dodamage( drone.health, drone.origin, attacker, vehicle, "MOD_CRUSH" );
}

// Namespace namespace_13d6a823fb364dea
// Params 0, eflags: 0x4
// Checksum 0x720bbce4, Offset: 0xbd2
// Size: 0x1d1
function private damagethink()
{
    drone = self;
    level endon( #"game_ended" );
    drone endon( #"main_drone_destroyed" );
    
    while ( true )
    {
        waitframe();
        drone waittill( #"damage", idamage, eattacker, vdir, vpoint, smeansofdeath, smodelname, stagname, spartname, idflags, objweapon );
        
        if ( drone.disabledamage )
        {
            continue;
        }
        
        if ( !isplayer( eattacker ) )
        {
            if ( isplayer( eattacker.owner ) )
            {
                eattacker = eattacker.owner;
            }
            else
            {
                continue;
            }
        }
        
        drone.health -= int( idamage );
        drone.lastattacker = eattacker;
        var_795e8a31194a39ac = { #var_3e13d05260eee4e1:1, #var_4dba57e6e29ded8e:1, #var_f561a4dd442b0d91:1 };
        eattacker damagefeedback::updatehitmarker( "hitequip", drone.health <= 0, 0, 1, "hitequip", undefined, undefined, var_795e8a31194a39ac, 1 );
        drone namespace_df4ff65d6946b16b::function_c86427bd7d0b3189( eattacker );
        airdrop_scriptbundle::function_e9dbf2aaef9f1c96( drone.airdropsettings, #"hash_ad000e5ba06523ee", drone, eattacker );
        
        if ( drone.health <= 0 )
        {
            drone thread dronedestroyed( eattacker, vdir, vpoint );
            return;
        }
        
        drone.targetplayer = eattacker;
        drone.var_c6f24c128f315724 = gettime();
        drone thread dronedash();
    }
}

// Namespace namespace_13d6a823fb364dea
// Params 2, eflags: 0x4
// Checksum 0xaf7dceef, Offset: 0xdab
// Size: 0x1fa, Type: bool
function private function_e3d98a41bdf8695( eattacker, detachvelocity )
{
    drone = self;
    behaviorsettings = level.package_airdrop.airdroptypes[ drone.airdropsettings.airdropidentifier ].airdropbehavior[ 0 ].variant_object;
    
    if ( drone.var_a1e594c2cae42e0b )
    {
        return true;
    }
    
    packageorigin = drone.origin + ( 0, 0, behaviorsettings.var_e89bbdec27fe1979 );
    packageangles = drone.angles;
    playsoundatpos( packageorigin, "br_deployable_kiosk_detach" );
    
    if ( utility::issharedfuncdefined( #"flee_drone", #"package_dropped" ) )
    {
        drone utility::callsharedfunc( #"flee_drone", #"package_dropped", eattacker ?? drone.lastattacker );
    }
    
    package = airdrop_scriptbundle::function_2c2cd0fc4ff63793( drone.airdropsettings, packageorigin, packageorigin, packageangles, detachvelocity );
    
    if ( !isdefined( package ) )
    {
        return false;
    }
    
    drone namespace_df4ff65d6946b16b::function_3168a034ee7decb5();
    drone function_106af240fb18f2e0();
    drone.package = package;
    drone.package.eattacker = eattacker ?? drone.lastattacker;
    drone.package.var_57eb671c310bb38e = drone namespace_df4ff65d6946b16b::function_c48a408d8c7eb9be();
    drone.var_a1e594c2cae42e0b = 1;
    drone namespace_df4ff65d6946b16b::analyticsdronedelivery();
    calloutmarkerping::function_9bd4bf4f8fe74b16( drone, drone.package, 9 );
    calloutmarkerping::function_ab4e5514677fba94( drone );
    airdrop_scriptbundle::function_e9dbf2aaef9f1c96( drone.airdropsettings, #"hash_e9a6accd033eb4b9", drone, eattacker ?? drone.lastattacker );
    return true;
}

// Namespace namespace_13d6a823fb364dea
// Params 0, eflags: 0x4
// Checksum 0xa1a8f62c, Offset: 0xfae
// Size: 0x6b
function private function_4c9331f364c0b70a()
{
    forward = anglestoforward( ( 0, self.var_1ffe7021d6fdf7ca ?? self.angles[ 1 ], 0 ) );
    horizontalspeed = self.fleespeed ?? 0;
    verticalspeed = self.var_8ef6e8c9d6d975af ?? 0;
    return ( forward[ 0 ] * horizontalspeed, forward[ 1 ] * horizontalspeed, verticalspeed );
}

// Namespace namespace_13d6a823fb364dea
// Params 1, eflags: 0x4
// Checksum 0x731a7ef5, Offset: 0x1022
// Size: 0x1c
function private function_f9cc05f73658cc0d( airdropidentifier )
{
    while ( !airdrop_scriptbundle::function_c4567c2030476d19( airdropidentifier ) )
    {
        waitframe();
    }
}

// Namespace namespace_13d6a823fb364dea
// Params 2, eflags: 0x4
// Checksum 0x79c1596, Offset: 0x1046
// Size: 0x9b
function private function_4e9df023166f6742( eattacker = undefined, detachvelocity = undefined )
{
    drone = self;
    
    while ( true )
    {
        if ( !isdefined( drone ) )
        {
            return 0;
        }
        
        if ( drone.var_a1e594c2cae42e0b )
        {
            return 1;
        }
        
        function_f9cc05f73658cc0d( drone.airdropsettings.airdropidentifier );
        
        if ( !isdefined( drone ) )
        {
            return 0;
        }
        
        if ( drone.var_a1e594c2cae42e0b )
        {
            return 1;
        }
        
        if ( drone function_e3d98a41bdf8695( eattacker, detachvelocity ) )
        {
            return 1;
        }
        
        waitframe();
    }
}

// Namespace namespace_13d6a823fb364dea
// Params 1, eflags: 0x4
// Checksum 0xab837060, Offset: 0x10e9
// Size: 0x125
function private function_7a48b23074c12bce( predelay = 0 )
{
    drone = self;
    
    if ( drone.var_44f52ace6119ee1d )
    {
        return;
    }
    
    drone.var_44f52ace6119ee1d = 1;
    drone endon( #"main_drone_destroyed" );
    behaviorsettings = level.package_airdrop.airdroptypes[ drone.airdropsettings.airdropidentifier ].airdropbehavior[ 0 ].variant_object;
    wait predelay;
    drone notify( #"hash_84941674cca5e76d" );
    drone notify( #"stop_moving" );
    lifetime = behaviorsettings.var_3684447841b3ba58;
    var_2024b9a8bb752418 = drone.origin + ( 0, 0, behaviorsettings.var_1564b16dac510452 );
    drone moveto( var_2024b9a8bb752418, lifetime, lifetime, 0 );
    wait lifetime;
    
    if ( !isdefined( drone ) )
    {
        return;
    }
    
    airdrop_scriptbundle::function_e9dbf2aaef9f1c96( drone.airdropsettings, #"hash_82fb75eefaf0a89a", drone );
    drone delete();
}

// Namespace namespace_13d6a823fb364dea
// Params 1, eflags: 0x4
// Checksum 0x2658b345, Offset: 0x1216
// Size: 0x137
function private droneemp( data )
{
    drone = self;
    drone endon( #"main_drone_destroyed" );
    
    if ( drone.var_dcf7b7678590b6c5 || drone.var_f97ddc37d2cacd36 )
    {
        return;
    }
    
    drone.var_dcf7b7678590b6c5 = 1;
    drone.disabledamage = 1;
    drone setcandamage( 0 );
    drone notify( #"hash_84941674cca5e76d" );
    drone notify( #"stop_moving" );
    
    if ( !drone.var_a1e594c2cae42e0b )
    {
        detachvelocity = drone function_4c9331f364c0b70a();
        drone function_4e9df023166f6742( data.attacker, detachvelocity );
    }
    
    if ( !isdefined( drone ) )
    {
        return;
    }
    
    drone function_106af240fb18f2e0();
    
    if ( !drone.var_a1e594c2cae42e0b )
    {
        return;
    }
    
    if ( randomint( 100 ) < 35 )
    {
        wait randomfloatrange( 0.1, 0.6 );
        
        if ( !isdefined( drone ) )
        {
            return;
        }
        
        drone namespace_df4ff65d6946b16b::droneexplosion();
        drone namespace_df4ff65d6946b16b::function_3168a034ee7decb5();
        drone function_106af240fb18f2e0();
        drone delete();
        return;
    }
    
    drone thread function_7a48b23074c12bce( randomfloatrange( 0.25, 1.5 ) );
}

// Namespace namespace_13d6a823fb364dea
// Params 1, eflags: 0x4
// Checksum 0x948c200c, Offset: 0x1355
// Size: 0x15
function private function_9df8d8c8ffb546dd( data )
{
    thread droneemp( data );
}

// Namespace namespace_13d6a823fb364dea
// Params 3, eflags: 0x4
// Checksum 0x4e33245a, Offset: 0x1372
// Size: 0x10c
function private dronedestroyed( eattacker, damagedir, impactpoint )
{
    drone = self;
    
    if ( drone.var_f97ddc37d2cacd36 || drone.var_dcf7b7678590b6c5 )
    {
        return;
    }
    
    drone.var_f97ddc37d2cacd36 = 1;
    drone.disabledamage = 1;
    drone notify( #"hash_84941674cca5e76d" );
    drone notify( #"stop_moving" );
    drone notify( #"main_drone_destroyed" );
    drone namespace_df4ff65d6946b16b::function_ce8365a343fe648d( eattacker );
    airdrop_scriptbundle::function_e9dbf2aaef9f1c96( drone.airdropsettings, #"hash_852023c9f529dca6", drone, eattacker );
    detachvelocity = drone function_4c9331f364c0b70a();
    drone namespace_df4ff65d6946b16b::function_fb19909cdff52447( eattacker );
    
    if ( !drone.var_a1e594c2cae42e0b )
    {
        drone function_4e9df023166f6742( eattacker, detachvelocity );
    }
    
    drone namespace_df4ff65d6946b16b::droneexplosion();
    drone namespace_df4ff65d6946b16b::function_3168a034ee7decb5();
    drone function_106af240fb18f2e0();
    drone delete();
}

// Namespace namespace_13d6a823fb364dea
// Params 0, eflags: 0x4
// Checksum 0xdb530d88, Offset: 0x1486
// Size: 0x36
function private function_106af240fb18f2e0()
{
    if ( self.linkedscriptable )
    {
        self.linkedscriptable utility::scriptable_clearparententity();
        self.linkedscriptable freescriptable();
        self.linkedscriptable = undefined;
    }
}

// Namespace namespace_13d6a823fb364dea
// Params 3, eflags: 0x4
// Checksum 0xa542ed41, Offset: 0x14c4
// Size: 0x62c
function private function_82145ca370109644( behaviorsettings, groundcontents, avoidwater )
{
    drone = self;
    players = getplayersinradius( drone.origin, behaviorsettings.var_93bcd261a63c2f96 + 1500 );
    aggregatedir = ( 0, 0, 0 );
    var_64e9ba7b5cf672b = 0;
    nearestdist = behaviorsettings.var_93bcd261a63c2f96;
    nearestenemy = undefined;
    
    foreach ( player in players )
    {
        if ( !isalive( player ) )
        {
            continue;
        }
        
        dist = distance2d( drone.origin, player.origin );
        
        if ( dist >= behaviorsettings.var_93bcd261a63c2f96 )
        {
            continue;
        }
        
        dir = vectornormalize2( drone.origin - player.origin );
        weight = 1 - dist / behaviorsettings.var_93bcd261a63c2f96;
        aggregatedir += dir * weight;
        var_64e9ba7b5cf672b = 1;
        
        if ( dist < nearestdist )
        {
            nearestdist = dist;
            nearestenemy = player;
        }
    }
    
    anchororigin = drone.droporigin ?? drone.spawnlocation ?? drone.origin;
    avoidgas = isdefined( level.br_circle ) && ( behaviorsettings.avoidgas ?? 1 );
    
    if ( avoidgas && br_circle::function_6bf5d4e680297398( anchororigin ) )
    {
        anchororigin = br_circle::getdangercircleorigin() ?? anchororigin;
    }
    
    var_6ffdf2ceff7e2473 = ( anchororigin[ 0 ], anchororigin[ 1 ], drone.origin[ 2 ] );
    
    if ( avoidwater && !function_bcf3b74a9bec88d7( var_6ffdf2ceff7e2473, groundcontents, avoidwater ) )
    {
        anchororigin = br_circle::getdangercircleorigin() ?? drone.spawnlocation ?? anchororigin;
    }
    
    var_68027916ca5c9297 = distance2d( drone.origin, anchororigin );
    now = gettime();
    var_1d87dabb054346df = ( now - drone.fleestarttime ) / 1000;
    var_65357c024973b34 = var_1d87dabb054346df < behaviorsettings.var_a3ee243fee8d1cee;
    
    if ( behaviorsettings.patrolmode )
    {
        drone.var_7629eac10ec2ee88 += 0.5;
        
        if ( drone.var_7629eac10ec2ee88 >= behaviorsettings.var_6109d8ca45d6e5da )
        {
            drone.var_7629eac10ec2ee88 = 0;
            patrolangle = randomint( 360 );
            patroloffset = anglestoforward( ( 0, patrolangle, 0 ) ) * behaviorsettings.patrolradius;
            patrolwaypoint = ( anchororigin[ 0 ] + patroloffset[ 0 ], anchororigin[ 1 ] + patroloffset[ 1 ], drone.origin[ 2 ] );
            drone.var_6e0dd18fd1037fec = vectortoangles( vectornormalize2( patrolwaypoint - drone.origin ) )[ 1 ];
            drone.var_b2a55cf858bab65a = behaviorsettings.patrolspeed;
        }
        
        if ( !var_65357c024973b34 && !drone.washovering )
        {
            if ( var_1d87dabb054346df >= behaviorsettings.delivertimeout )
            {
                drone.washovering = 1;
                drone.var_c6f24c128f315724 = now;
                drone.var_b2a55cf858bab65a = 0;
            }
        }
        else if ( drone.washovering )
        {
            drone.var_b2a55cf858bab65a = 0;
        }
    }
    else if ( var_64e9ba7b5cf672b )
    {
        drone.washovering = 0;
        drone.var_c6f24c128f315724 = now;
        drone.targetplayer = nearestenemy;
        fleedir = vectornormalize( aggregatedir );
        
        if ( var_68027916ca5c9297 > behaviorsettings.var_a716abfaa090cb99 * 0.7 )
        {
            returndir = vectornormalize2( anchororigin - drone.origin );
            fleedir = vectornormalize( fleedir + returndir );
        }
        
        if ( drone.var_505d58445149b0e5 <= 0 )
        {
            drone.var_6e0dd18fd1037fec = vectortoangles( fleedir )[ 1 ];
        }
        
        drone.var_b2a55cf858bab65a = behaviorsettings.cruisespeed;
    }
    else if ( !drone.washovering && var_68027916ca5c9297 > behaviorsettings.returntolerance )
    {
        if ( drone.var_505d58445149b0e5 <= 0 )
        {
            drone.var_6e0dd18fd1037fec = vectortoangles( vectornormalize2( anchororigin - drone.origin ) )[ 1 ];
        }
        
        drone.var_b2a55cf858bab65a = behaviorsettings.cruisespeed;
    }
    else if ( !var_65357c024973b34 )
    {
        if ( !drone.washovering )
        {
            drone.washovering = 1;
            drone.var_c6f24c128f315724 = now;
        }
        
        drone.var_b2a55cf858bab65a = 0;
    }
    
    if ( avoidgas && br_circle::function_6bf5d4e680297398( drone.origin ) || avoidwater && !function_bcf3b74a9bec88d7( drone.origin, groundcontents, avoidwater ) )
    {
        drone.washovering = 0;
        
        if ( drone.var_505d58445149b0e5 <= 0 && distance2d( drone.origin, anchororigin ) > 1 )
        {
            drone.var_6e0dd18fd1037fec = vectortoangles( vectornormalize2( anchororigin - drone.origin ) )[ 1 ];
        }
        
        drone.var_b2a55cf858bab65a = behaviorsettings.cruisespeed;
    }
}

// Namespace namespace_13d6a823fb364dea
// Params 4, eflags: 0x4
// Checksum 0xbd30e371, Offset: 0x1af8
// Size: 0x275
function private function_69ee974c1d7ff927( behaviorsettings, obstaclecontents, groundcontents, avoidwater )
{
    drone = self;
    avoidgas = isdefined( level.br_circle ) && ( behaviorsettings.avoidgas ?? 1 );
    desireddiff = function_2dc20a79b0a204a3( drone.var_6e0dd18fd1037fec - drone.var_1ffe7021d6fdf7ca );
    var_df0a0846b5346e2 = desireddiff >= 0 ? 1 : -1;
    chosenangle = undefined;
    probeoffset = 30;
    
    while ( probeoffset <= 180 )
    {
        for ( sideidx = 0; sideidx < 2 ; sideidx++ )
        {
            side = sideidx == 0 ? var_df0a0846b5346e2 : var_df0a0846b5346e2 * -1;
            candidateangle = drone.var_1ffe7021d6fdf7ca + probeoffset * side;
            probeforward = anglestoforward( ( 0, candidateangle, 0 ) );
            probeend = drone.origin + probeforward * behaviorsettings.var_3c1bd684f022141b;
            probepoint = ( probeend[ 0 ], probeend[ 1 ], drone.origin[ 2 ] );
            
            if ( !trace::sphere_trace_passed( drone.origin, probepoint, 70, drone, obstaclecontents ) )
            {
                continue;
            }
            
            if ( !function_bcf3b74a9bec88d7( probepoint, groundcontents, avoidwater ) )
            {
                continue;
            }
            
            if ( avoidgas && br_circle::function_6bf5d4e680297398( probepoint ) )
            {
                continue;
            }
            
            chosenangle = candidateangle;
            break;
        }
        
        if ( isdefined( chosenangle ) )
        {
            break;
        }
        
        probeoffset += 30;
    }
    
    if ( isdefined( chosenangle ) )
    {
        return chosenangle;
    }
    
    reverseangle = drone.var_1ffe7021d6fdf7ca + 180;
    reverseprobe = anglestoforward( ( 0, reverseangle, 0 ) );
    reverseend = drone.origin + reverseprobe * behaviorsettings.var_3c1bd684f022141b;
    reversepoint = ( reverseend[ 0 ], reverseend[ 1 ], drone.origin[ 2 ] );
    
    if ( !function_bcf3b74a9bec88d7( reversepoint, groundcontents, avoidwater ) )
    {
        return;
    }
    
    if ( !trace::sphere_trace_passed( drone.origin, reversepoint, 70, drone, obstaclecontents ) )
    {
        return;
    }
    
    if ( avoidgas && br_circle::function_6bf5d4e680297398( reversepoint ) )
    {
        return;
    }
    
    return reverseangle;
}

// Namespace namespace_13d6a823fb364dea
// Params 7, eflags: 0x4
// Checksum 0xfbbebc21, Offset: 0x1d76
// Size: 0x2f6
function private function_19d2cd91ffbc110e( behaviorsettings, forward, obstaclecontents, var_373a5c3c9d962bfc, groundcontents, avoidwater, dt )
{
    drone = self;
    avoidgas = isdefined( level.br_circle ) && ( behaviorsettings.avoidgas ?? 1 );
    
    if ( drone.var_505d58445149b0e5 > 0 )
    {
        drone.var_505d58445149b0e5 -= dt;
    }
    
    turnradius = drone.fleespeed * var_373a5c3c9d962bfc;
    lookaheaddist = turnradius > behaviorsettings.var_3c1bd684f022141b ? turnradius : behaviorsettings.var_3c1bd684f022141b;
    farlookahead = drone.origin + forward * lookaheaddist;
    var_a3234f9977de3ffa = ( farlookahead[ 0 ], farlookahead[ 1 ], drone.origin[ 2 ] );
    drone.var_7e234d45e587e24d -= dt;
    
    if ( drone.var_7e234d45e587e24d <= 0 )
    {
        dynamicinterval = drone.fleespeed > 1 ? 150 / drone.fleespeed : 0.1;
        
        if ( dynamicinterval < 0.033 )
        {
            dynamicinterval = 0.033;
        }
        
        if ( dynamicinterval > 0.1 )
        {
            dynamicinterval = 0.1;
        }
        
        drone.var_7e234d45e587e24d = dynamicinterval;
        obstacletrace = trace::sphere_trace( drone.origin, var_a3234f9977de3ffa, 70, drone, obstaclecontents );
        nearfraction = 400 / lookaheaddist;
        drone.var_7543d7c29172e65f = obstacletrace[ "fraction" ] < 1;
        drone.var_d63af54b76276dfe = obstacletrace[ "fraction" ] < nearfraction;
        
        if ( !drone.var_7543d7c29172e65f && drone.var_505d58445149b0e5 <= 0 && !function_bcf3b74a9bec88d7( var_a3234f9977de3ffa, groundcontents, avoidwater ) )
        {
            drone.var_7543d7c29172e65f = 1;
        }
    }
    
    farblocked = drone.var_7543d7c29172e65f;
    
    if ( !farblocked && avoidgas )
    {
        if ( br_circle::function_6bf5d4e680297398( var_a3234f9977de3ffa ) )
        {
            farblocked = 1;
        }
    }
    
    if ( !farblocked )
    {
        drone.obstacleclimbing = 0;
        drone.var_1eb092b0eeac4d81 = drone.origin[ 2 ];
    }
    
    if ( farblocked && drone.var_505d58445149b0e5 <= 0 )
    {
        drone function_5316d366dab71ca1( behaviorsettings, obstaclecontents, groundcontents, avoidwater );
    }
    
    if ( drone.var_d63af54b76276dfe || drone.obstacleclimbing )
    {
        drone.var_b2a55cf858bab65a = 0;
    }
}

// Namespace namespace_13d6a823fb364dea
// Params 4, eflags: 0x4
// Checksum 0x86eaf1ac, Offset: 0x2074
// Size: 0x1d5
function private function_5316d366dab71ca1( behaviorsettings, obstaclecontents, groundcontents, avoidwater )
{
    drone = self;
    chosenangle = drone function_69ee974c1d7ff927( behaviorsettings, obstaclecontents, groundcontents, avoidwater );
    
    if ( !isdefined( chosenangle ) )
    {
        if ( avoidwater && !function_bcf3b74a9bec88d7( drone.origin, groundcontents, avoidwater ) )
        {
            drone.var_505d58445149b0e5 = 0.5;
            return;
        }
        
        drone.var_b2a55cf858bab65a = 0;
        drone.obstacleclimbing = 1;
        var_9084437e2f96479 = ( drone.spawnlocation[ 2 ] ?? drone.origin[ 2 ] ) + behaviorsettings.hoverheight;
        drone.var_1eb092b0eeac4d81 = min( var_9084437e2f96479, drone.origin[ 2 ] + behaviorsettings.hoverheight );
        
        if ( drone.var_1eb092b0eeac4d81 < drone.origin[ 2 ] )
        {
            drone.var_1eb092b0eeac4d81 = drone.origin[ 2 ];
        }
        
        drone.var_505d58445149b0e5 = 0.5;
        return;
    }
    
    drone.obstacleclimbing = 0;
    drone.var_1eb092b0eeac4d81 = drone.origin[ 2 ];
    drone.var_46abfca91bf4538f = chosenangle;
    turnneeded = function_2dc20a79b0a204a3( chosenangle - drone.var_1ffe7021d6fdf7ca );
    drone.var_505d58445149b0e5 = abs( turnneeded ) / behaviorsettings.yawrate + 0.5;
    drone.var_6e0dd18fd1037fec = drone.var_46abfca91bf4538f;
}

// Namespace namespace_13d6a823fb364dea
// Params 3, eflags: 0x4
// Checksum 0x7e151185, Offset: 0x2251
// Size: 0x294
function private function_9243726cc369713b( behaviorsettings, groundpos, dt )
{
    drone = self;
    var_b1798b71f0c28435 = groundpos ? groundpos[ 2 ] + behaviorsettings.hoverheight : drone.var_d811a597fd3a6771;
    
    if ( drone.obstacleclimbing && drone.var_1eb092b0eeac4d81 > var_b1798b71f0c28435 )
    {
        var_b1798b71f0c28435 = drone.var_1eb092b0eeac4d81;
    }
    
    var_d36d18c88251cb0 = var_b1798b71f0c28435 - drone.var_d811a597fd3a6771;
    altgap = abs( var_d36d18c88251cb0 );
    var_9ab00a7463d5e716 = var_d36d18c88251cb0 > 0 ? 0.15 : 0.05;
    drone.var_d811a597fd3a6771 += var_d36d18c88251cb0 * ( var_9ab00a7463d5e716 + var_9ab00a7463d5e716 * altgap / ( altgap + 200 ) );
    
    if ( drone.washovering )
    {
        if ( drone.var_d811a597fd3a6771 > drone.origin[ 2 ] )
        {
            drone.var_d811a597fd3a6771 = drone.origin[ 2 ];
        }
    }
    
    altdiff = drone.var_d811a597fd3a6771 - drone.origin[ 2 ];
    
    if ( drone.fleespeed < 50 && altdiff > 0 && !drone.obstacleclimbing )
    {
        altdiff = 0;
    }
    
    var_abaeb2779e3915b8 = altdiff * 1.5;
    
    if ( var_abaeb2779e3915b8 > 2000 )
    {
        var_abaeb2779e3915b8 = 2000;
    }
    else if ( var_abaeb2779e3915b8 < -2000 )
    {
        var_abaeb2779e3915b8 = -2000;
    }
    
    if ( abs( drone.var_8ef6e8c9d6d975af ) < abs( var_abaeb2779e3915b8 ) && drone.var_8ef6e8c9d6d975af * var_abaeb2779e3915b8 >= 0 )
    {
        if ( drone.var_8ef6e8c9d6d975af < var_abaeb2779e3915b8 )
        {
            drone.var_8ef6e8c9d6d975af += 500 * dt;
            
            if ( drone.var_8ef6e8c9d6d975af > var_abaeb2779e3915b8 )
            {
                drone.var_8ef6e8c9d6d975af = var_abaeb2779e3915b8;
            }
        }
        else if ( drone.var_8ef6e8c9d6d975af > var_abaeb2779e3915b8 )
        {
            drone.var_8ef6e8c9d6d975af -= 500 * dt;
            
            if ( drone.var_8ef6e8c9d6d975af < var_abaeb2779e3915b8 )
            {
                drone.var_8ef6e8c9d6d975af = var_abaeb2779e3915b8;
            }
        }
        
        return;
    }
    
    drone.var_8ef6e8c9d6d975af = var_abaeb2779e3915b8;
}

// Namespace namespace_13d6a823fb364dea
// Params 3, eflags: 0x4
// Checksum 0xfb04c817, Offset: 0x24ed
// Size: 0x1ff
function private function_7182d0850be56b12( behaviorsettings, var_4d1a8bbd4a19c026, dt )
{
    drone = self;
    
    if ( drone.fleespeed > 50 )
    {
        var_5c39d611c83c6a6e = function_2dc20a79b0a204a3( var_4d1a8bbd4a19c026 - drone.var_ea8113b034db4ba5 );
        var_c00701534b7a5631 = behaviorsettings.var_9a4f3f6fb67f8843 * dt;
        
        if ( abs( var_5c39d611c83c6a6e ) <= var_c00701534b7a5631 )
        {
            drone.var_ea8113b034db4ba5 += var_5c39d611c83c6a6e;
        }
        else if ( var_5c39d611c83c6a6e > 0 )
        {
            drone.var_ea8113b034db4ba5 += var_c00701534b7a5631;
        }
        else
        {
            drone.var_ea8113b034db4ba5 -= var_c00701534b7a5631;
        }
    }
    
    tiltmag = drone.fleespeed / behaviorsettings.cruisespeed;
    
    if ( tiltmag > 1 )
    {
        tiltmag = 1;
    }
    
    if ( tiltmag > 0 )
    {
        droneforward = anglestoforward( ( 0, drone.var_ea8113b034db4ba5, 0 ) );
        droneright = anglestoright( ( 0, drone.var_ea8113b034db4ba5, 0 ) );
        movedir = anglestoforward( ( 0, var_4d1a8bbd4a19c026, 0 ) );
        tiltfactor = behaviorsettings.movetilt * tiltmag;
        pitch = tiltfactor * vectordot( movedir, droneforward );
        roll = tiltfactor * vectordot( movedir, droneright );
    }
    else
    {
        pitch = 0;
        roll = 0;
    }
    
    drone.smoothpitch += ( pitch - drone.smoothpitch ) * 0.08;
    drone.smoothroll += ( roll - drone.smoothroll ) * 0.08;
}

// Namespace namespace_13d6a823fb364dea
// Params 0, eflags: 0xc
// Checksum 0xae7bc77b, Offset: 0x26f4
// Size: 0x66e
function private function_2e32e363bba89747()
{
    self notify( #"hash_4999fd3f5ce94f24" );
    self endon( #"hash_4999fd3f5ce94f24" );
    drone = self;
    level endon( #"game_ended" );
    drone endon( #"main_drone_destroyed" );
    drone endon( #"hash_84941674cca5e76d" );
    behaviorsettings = level.package_airdrop.airdroptypes[ drone.airdropsettings.airdropidentifier ].airdropbehavior[ 0 ].variant_object;
    obstaclecontents = trace::create_default_contents( 1 );
    playerchecktimer = 0.5;
    groundchecktimer = 0.2;
    var_8c9bf95bf3d19ff1 = behaviorsettings.var_e89bbdec27fe1979 * 2;
    var_373a5c3c9d962bfc = 90 / behaviorsettings.yawrate;
    groundcontents = trace::create_default_contents( 1 );
    prevtime = gettime();
    dt = 0.05;
    drone function_c5a388ac27bf9809();
    drone.var_b2a55cf858bab65a = behaviorsettings.cruisespeed;
    
    while ( true )
    {
        var_c28339f5f985d7b6 = behaviorsettings.acceleration * dt;
        var_5e78a9102cd5bf49 = behaviorsettings.yawrate * dt;
        playerchecktimer += dt;
        
        if ( playerchecktimer >= 0.5 )
        {
            playerchecktimer = 0;
            drone function_82145ca370109644( behaviorsettings, groundcontents, behaviorsettings.avoidwater );
        }
        
        if ( drone.fleespeed < drone.var_b2a55cf858bab65a )
        {
            drone.fleespeed += var_c28339f5f985d7b6;
            
            if ( drone.fleespeed > drone.var_b2a55cf858bab65a )
            {
                drone.fleespeed = drone.var_b2a55cf858bab65a;
            }
        }
        else if ( drone.fleespeed > drone.var_b2a55cf858bab65a )
        {
            drone.fleespeed -= var_c28339f5f985d7b6;
            
            if ( drone.fleespeed < drone.var_b2a55cf858bab65a )
            {
                drone.fleespeed = drone.var_b2a55cf858bab65a;
            }
        }
        
        if ( drone.fleespeed > 0 || drone.obstacleclimbing )
        {
            forward = anglestoforward( ( 0, drone.var_1ffe7021d6fdf7ca, 0 ) );
            drone function_19d2cd91ffbc110e( behaviorsettings, forward, obstaclecontents, var_373a5c3c9d962bfc, groundcontents, behaviorsettings.avoidwater, dt );
        }
        
        var_b93e64f2007f7d46 = drone.var_505d58445149b0e5 > 0 ? drone.var_46abfca91bf4538f : drone.var_6e0dd18fd1037fec;
        anglediff = function_2dc20a79b0a204a3( var_b93e64f2007f7d46 - drone.var_1ffe7021d6fdf7ca );
        
        if ( abs( anglediff ) <= var_5e78a9102cd5bf49 )
        {
            drone.var_1ffe7021d6fdf7ca += anglediff;
        }
        else if ( anglediff > 0 )
        {
            drone.var_1ffe7021d6fdf7ca += var_5e78a9102cd5bf49;
        }
        else
        {
            drone.var_1ffe7021d6fdf7ca -= var_5e78a9102cd5bf49;
        }
        
        if ( drone.fleespeed > 0 )
        {
            forward = anglestoforward( ( 0, drone.var_1ffe7021d6fdf7ca, 0 ) );
            newx = drone.origin[ 0 ] + forward[ 0 ] * drone.fleespeed * dt;
            newy = drone.origin[ 1 ] + forward[ 1 ] * drone.fleespeed * dt;
            
            if ( !drone.washovering )
            {
                groundchecktimer += dt;
                
                if ( groundchecktimer >= 0.2 )
                {
                    groundchecktimer = 0;
                    tracestart = ( newx, newy, drone.origin[ 2 ] + var_8c9bf95bf3d19ff1 );
                    groundtrace = trace::ray_trace( tracestart, ( tracestart[ 0 ], tracestart[ 1 ], tracestart[ 2 ] - 10000 ), drone, groundcontents );
                    
                    if ( groundtrace[ "fraction" ] < 1 && ( !behaviorsettings.avoidwater || groundtrace[ "surfacetype" ] != "surftype_water" ) )
                    {
                        drone.var_c0fe0d0126ed0a63 = groundtrace[ "position" ];
                    }
                    else
                    {
                        drone.var_c0fe0d0126ed0a63 = undefined;
                    }
                }
            }
        }
        else
        {
            newx = drone.origin[ 0 ];
            newy = drone.origin[ 1 ];
        }
        
        drone function_9243726cc369713b( behaviorsettings, drone.var_c0fe0d0126ed0a63, dt );
        newz = drone.origin[ 2 ] + drone.var_8ef6e8c9d6d975af * dt;
        
        if ( drone.var_c0fe0d0126ed0a63 && newz < drone.var_c0fe0d0126ed0a63[ 2 ] + 50 )
        {
            newz = drone.var_c0fe0d0126ed0a63[ 2 ] + 50;
            drone.var_8ef6e8c9d6d975af = 0;
        }
        
        if ( drone.washovering && !drone.var_a1e594c2cae42e0b )
        {
            if ( ( gettime() - drone.var_c6f24c128f315724 ) / 1000 >= behaviorsettings.delivertimeout )
            {
                if ( airdrop_scriptbundle::function_c4567c2030476d19( drone.airdropsettings.airdropidentifier ) )
                {
                    if ( !behaviorsettings.neverdrop )
                    {
                        detachvelocity = drone function_4c9331f364c0b70a();
                        drone function_4e9df023166f6742( undefined, detachvelocity );
                    }
                    
                    drone thread function_7a48b23074c12bce();
                    return;
                }
            }
        }
        
        drone function_7182d0850be56b12( behaviorsettings, drone.var_1ffe7021d6fdf7ca, dt );
        drone moveto( ( newx, newy, newz ), dt, 0, 0 );
        drone.angles = ( drone.smoothpitch, drone.var_ea8113b034db4ba5, drone.smoothroll );
        wait 0.05;
        now = gettime();
        dt = ( now - prevtime ) / 1000;
        prevtime = now;
    }
}

// Namespace namespace_13d6a823fb364dea
// Params 0, eflags: 0xc
// Checksum 0xab90abfb, Offset: 0x2d6a
// Size: 0x243
function private dronedash()
{
    self notify( #"hash_3a4c5d1af2730417" );
    self endon( #"hash_3a4c5d1af2730417" );
    drone = self;
    level endon( #"game_ended" );
    drone endon( #"main_drone_destroyed" );
    drone endon( #"hash_84941674cca5e76d" );
    behaviorsettings = level.package_airdrop.airdroptypes[ drone.airdropsettings.airdropidentifier ].airdropbehavior[ 0 ].variant_object;
    
    if ( drone.targetplayer && drone.var_505d58445149b0e5 <= 0 )
    {
        avoidgas = isdefined( level.br_circle ) && ( behaviorsettings.avoidgas ?? 1 );
        fleedir = vectornormalize2( drone.origin - drone.targetplayer.origin );
        dashangle = vectortoangles( fleedir )[ 1 ] + randomintrange( -30, 30 );
        dashcontents = trace::create_default_contents( 1 );
        dashforward = anglestoforward( ( 0, dashangle, 0 ) );
        var_34465563cb45bd34 = ( drone.origin[ 0 ] + dashforward[ 0 ] * behaviorsettings.var_3c1bd684f022141b, drone.origin[ 1 ] + dashforward[ 1 ] * behaviorsettings.var_3c1bd684f022141b, drone.origin[ 2 ] );
        
        if ( trace::sphere_trace_passed( drone.origin, var_34465563cb45bd34, 70, drone, dashcontents ) && function_bcf3b74a9bec88d7( var_34465563cb45bd34, dashcontents, behaviorsettings.avoidwater ) && ( !avoidgas || !br_circle::function_6bf5d4e680297398( var_34465563cb45bd34 ) ) )
        {
            drone.var_6e0dd18fd1037fec = dashangle;
        }
    }
    
    drone.var_b2a55cf858bab65a = behaviorsettings.dashspeed;
    drone.var_c6f24c128f315724 = gettime();
    wait 1.5;
    
    if ( !isdefined( drone ) )
    {
        return;
    }
    
    drone.var_b2a55cf858bab65a = behaviorsettings.cruisespeed;
}

// Namespace namespace_13d6a823fb364dea
// Params 0, eflags: 0x4
// Checksum 0x40f687db, Offset: 0x2fb5
// Size: 0x77
function private function_9cbf0900bdedcd8d()
{
    drone = self;
    
    if ( drone.targetplayer )
    {
        direction = vectornormalize2( drone.origin - drone.targetplayer.origin );
        angles = vectortoangles( direction ) + ( 0, randomintrange( -90, 90 ), 0 );
        return anglestoforward( angles );
    }
    
    return utility::randomvector( 1 );
}

// Namespace namespace_13d6a823fb364dea
// Params 0, eflags: 0x4
// Checksum 0x42dfe9ed, Offset: 0x3035
// Size: 0x26
function private function_c5a388ac27bf9809()
{
    direction = function_9cbf0900bdedcd8d();
    self.var_6e0dd18fd1037fec = vectortoangles( direction )[ 1 ];
}

// Namespace namespace_13d6a823fb364dea
// Params 3, eflags: 0x4
// Checksum 0xfc8de9bf, Offset: 0x3063
// Size: 0x7f, Type: bool
function private function_bcf3b74a9bec88d7( point, groundcontents, avoidwater = 0 )
{
    traceend = ( point[ 0 ], point[ 1 ], point[ 2 ] - 10000 );
    result = trace::ray_trace( point, traceend, undefined, groundcontents, avoidwater );
    
    if ( result[ "fraction" ] == 1 )
    {
        return false;
    }
    
    return !avoidwater || result[ "surfacetype" ] != "surftype_water";
}

// Namespace namespace_13d6a823fb364dea
// Params 1, eflags: 0x4
// Checksum 0x7dfd2b8a, Offset: 0x30eb
// Size: 0x2c
function private function_2dc20a79b0a204a3( diff )
{
    if ( diff > 180 )
    {
        return ( diff - 360 );
    }
    
    if ( diff < -180 )
    {
        return ( diff + 360 );
    }
    
    return diff;
}

