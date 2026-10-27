// scripts\mp\common\killstreaks\drone_swarm.gsc  (hash_36b04f1e02cbfff9.gscc) (size: 15111 Bytes / 0x3b07 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfb82134f (4219605839)
// size ...... 15111 (0x3b07)
// includes .. 9   (offset: 0x3743)
// strings ... 53  (offset: 0x378b)
// dev strs .. 0   (offset: 0x3b07)
// exports ... 24  (offset: 0x27c7)
// cseg ...... 0x387 + 0x2440 (0x27c7)
// imports ... 90  (offset: 0x2b87)
// animtree1 . 0   (offset: 0x3b07)
// animtree2 . 0   (offset: 0x3b07)
#using scripts\common\callbacks;
#using scripts\common\functionals_utility;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\utility;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\killstreaks\switchblade_drone;
#using scripts\mp\common\utility\dialog_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak_utility;

#namespace drone_swarm;

// Namespace drone_swarm
// Params 0, eflags: 0x1
// Checksum 0x53075cda, Offset: 0x3a5
// Size: 0x35
function autoexec main()
{
    killstreak_shared::registerkillstreakinitfunction( getxhash( "drone_swarm" ), &function_bb58e197c9b829c6 );
    utility::registersharedfunc( #"drone_swarm", #"tryusedroneswarm", &tryusedroneswarm );
}

// Namespace drone_swarm
// Params 0
// Checksum 0x96fc712a, Offset: 0x3e2
// Size: 0x6a
function function_bb58e197c9b829c6()
{
    if ( utility::issharedfuncdefined( #"killstreak", #"registerkillstreak" ) )
    {
        [[ utility::getsharedfunc( #"killstreak", #"registerkillstreak" ) ]]( "drone_swarm", &tryusedroneswarm );
    }
    
    utility::registersharedfunc( "drone_swarm", #"tryusekillstreak", &tryusedroneswarm );
    drone_swarm_initdvars();
    drone_swarm_init_vo();
}

// Namespace drone_swarm
// Params 0
// Checksum 0x353b7883, Offset: 0x454
// Size: 0xdb
function drone_swarm_initdvars()
{
    /#
        setdvarifuninitialized( @"scr_drone_swarm_debug", 0 );
    #/
    
    setdvarifuninitialized( @"scr_drone_swarm_num_groups", 100 );
    setdvarifuninitialized( @"hash_c2591707a1f66eea", 1 );
    setdvarifuninitialized( @"hash_ed4f0310e6fe1f5b", 200 );
    setdvarifuninitialized( @"hash_bf387ddf15b94493", 700 );
    setdvarifuninitialized( @"scr_drone_swarm_respawn_delay", 3 );
    setdvarifuninitialized( @"hash_6ca247ada3a708ab", 8000 );
    setdvarifuninitialized( @"hash_ab9a39e96f2dff27", 15 );
    setdvarifuninitialized( @"hash_955594666ea4a4e0", 1 );
    setdvarifuninitialized( @"hash_ec1167396d530042", 0.05 );
    setdvarifuninitialized( @"hash_f065b6bad78c93b9", 200 );
    setdvarifuninitialized( @"hash_b6455b787cd7cbab", 500 );
    setdvarifuninitialized( @"hash_9719cfd50a1766ee", 1400 );
}

// Namespace drone_swarm
// Params 0
// Checksum 0xe8c1d50a, Offset: 0x537
// Size: 0x1b
function drone_swarm_init_vo()
{
    game[ "dialog" ][ "drone_swarm_use" ] = "killstreak_remote_operator" + "_request_response";
}

// Namespace drone_swarm
// Params 1
// Checksum 0xf6b47e2f, Offset: 0x55a
// Size: 0x1c5
function tryusedroneswarm( streakinfo )
{
    if ( !isdefined( level.var_6b693ee75ce87960 ) || game_utility::islargemap() )
    {
        function_c369f0944ca8d4f9();
    }
    
    if ( !isdefined( streakinfo ) )
    {
        streakinfo = killstreak_utility::createstreakinfo( "drone_swarm", self );
    }
    
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            return 0;
        }
    }
    
    bundle = level.streakglobals.streakbundles[ "drone_swarm" ];
    deploymentweapon = bundle.deployweaponname ?? "ks_gesture_phone_mp";
    deployresult = killstreakdeploy::streakdeploy_dogesturedeploy( streakinfo, makeweapon( deploymentweapon ) );
    
    if ( !deployresult )
    {
        return;
    }
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            return 0;
        }
    }
    
    self notify( #"munitions_used", "drone_swarm" );
    
    if ( isplayer( self ) )
    {
        if ( utility::issharedfuncdefined( #"sound", #"playkillstreakdeploydialog" ) )
        {
            self [[ utility::getsharedfunc( #"sound", #"playkillstreakdeploydialog" ) ]]( streakinfo.streakname );
            var_65934120c2efeb81 = 2.5;
        }
        
        thread killstreak_utility::playkillstreakoperatordialog( streakinfo.streakname, streakinfo.streakname + "_use", #"use_drone_swarm" );
    }
    
    if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) )
    {
        self thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( "used_" + "drone_swarm", self );
    }
    
    thread drone_swarm_wait( streakinfo );
    return 1;
}

// Namespace drone_swarm
// Params 1
// Checksum 0x2f1c07bf, Offset: 0x728
// Size: 0x20b
function drone_swarm_wait( streakinfo )
{
    bundle = level.streakglobals.streakbundles[ "drone_swarm" ];
    var_e298dcb55f5403ca = getdvarint( @"hash_ab9a39e96f2dff27" );
    actuallyspawned = 0;
    result = function_5e2b470e3ba80673( streakinfo );
    level.var_6ca63672f6953d28 = result[ 0 ];
    deploy_plane = function_1ec6d390833cafd8( streakinfo, var_e298dcb55f5403ca, result[ 1 ] );
    var_a650eecbc8d42ddd = getdvarfloat( @"hash_955594666ea4a4e0" );
    wait var_a650eecbc8d42ddd;
    var_9d5f358f12a57505 = getdvarfloat( @"hash_ec1167396d530042" );
    
    foreach ( location in level.var_6b693ee75ce87960 )
    {
        if ( actuallyspawned > bundle.maxdrones )
        {
            break;
        }
        
        thread function_e9ab6cb8a4df9139( deploy_plane.origin, location, streakinfo );
        actuallyspawned++;
        wait var_9d5f358f12a57505;
    }
    
    level.droneswarmactive = 1;
    thread function_d287c2dc1660b847();
    
    if ( bundle.var_7798ed31dc26c2e0 > 0 )
    {
        level.var_71105df95dea195c = bundle.var_7798ed31dc26c2e0;
    }
    
    /#
        var_4fbec1d543a5610 = getdvarint( @"hash_5a8e2bfaac44df7f" );
        
        if ( isdefined( var_4fbec1d543a5610 ) )
        {
            level.var_71105df95dea195c = var_4fbec1d543a5610;
        }
    #/
    
    thread drone_swarm_empapplied( streakinfo );
    streakinfo.owner endon( #"emp_applied" );
    wait bundle.dronelifetime;
    streakinfo.owner notify( #"drone_swarm_timeout" );
    thread function_9925428dce5ad7e0();
    drone_swarm_cleanup( streakinfo );
}

// Namespace drone_swarm
// Params 0
// Checksum 0x666cff09, Offset: 0x93b
// Size: 0x7d
function function_9925428dce5ad7e0()
{
    teamtocheck = self.pers[ "team" ];
    characterref = dialog_utility::function_8f16d04b74c7bcd1( teamtocheck );
    character = dialog_utility::function_b857dac241739eeb( "Character", characterref );
    
    if ( !isdefined( character ) )
    {
        character = "mili";
    }
    
    dialogalias = "dx_mp_core_anno_" + character + "_cdef";
    thread killstreak_utility::playkillstreakoperatordialog( "drone_swarm", dialogalias, "drone_swarm_end" );
}

// Namespace drone_swarm
// Params 0
// Checksum 0xf72bd446, Offset: 0x9c0
// Size: 0x7d
function function_d287c2dc1660b847()
{
    teamtocheck = self.pers[ "team" ];
    characterref = dialog_utility::function_8f16d04b74c7bcd1( teamtocheck );
    character = dialog_utility::function_b857dac241739eeb( "Character", characterref );
    
    if ( !isdefined( character ) )
    {
        character = "mili";
    }
    
    dialogalias = "dx_mp_core_anno_" + character + "_cdrf";
    thread killstreak_utility::playkillstreakoperatordialog( "drone_swarm", dialogalias, "drone_swarm_active" );
}

// Namespace drone_swarm
// Params 1
// Checksum 0x7ca1fbb3, Offset: 0xa45
// Size: 0xdf
function function_35ae81741acbc570( location )
{
    var_e7de05a59523ded8 = switchblade_drone::function_bb4c3b83ccb10112( "drone_swarm", location );
    zmult = 0;
    zstep = 500;
    bundle = level.streakglobals.streakbundles[ "drone_swarm" ];
    
    while ( !var_e7de05a59523ded8 )
    {
        zmult++;
        newz = location[ 2 ] + zstep * zmult;
        location = ( location[ 0 ], location[ 1 ], newz );
        var_e7de05a59523ded8 = switchblade_drone::function_bb4c3b83ccb10112( "drone_swarm", location );
    }
    
    if ( !isdefined( self.var_a184934811b36115 ) || self.var_a184934811b36115 < zmult * zstep + bundle.dronemaxheight )
    {
        self.var_a184934811b36115 = zmult * zstep + bundle.dronemaxheight;
    }
}

// Namespace drone_swarm
// Params 1
// Checksum 0x2d8248da, Offset: 0xb2c
// Size: 0x1c9
function function_5e2b470e3ba80673( streakinfo )
{
    bundle = level.streakglobals.streakbundles[ "drone_swarm" ];
    location = function_54bb9146ad948b1e() + ( 0, 0, bundle.var_1f734f2e6f67714c );
    
    if ( game_utility::islargemap() )
    {
        if ( self.var_a184934811b36115 > 0 && self.var_a184934811b36115 > bundle.var_1f734f2e6f67714c )
        {
            location = ( location[ 0 ], location[ 1 ], self.var_a184934811b36115 );
        }
    }
    
    if ( location[ 2 ] <= self.origin[ 2 ] || location[ 2 ] - self.origin[ 2 ] < bundle.var_1f734f2e6f67714c )
    {
        newz = self.origin[ 2 ] + bundle.var_1f734f2e6f67714c < bundle.var_b9ef9ac95c3174fe ? self.origin[ 2 ] + bundle.var_1f734f2e6f67714c : bundle.var_b9ef9ac95c3174fe;
        location = ( location[ 0 ], location[ 1 ], newz );
    }
    
    self.var_2852dd203c16860c = location[ 2 ];
    
    if ( issubstr( level.mapname, "highrise" ) )
    {
        self.var_a184934811b36115 = 2000;
    }
    
    if ( issubstr( level.mapname, "observatory" ) )
    {
        self.var_a184934811b36115 = 4000;
    }
    
    scriptable = spawnscriptable( bundle.var_8ce714f2e60ab130, location );
    scriptable.owner = streakinfo.owner;
    thread function_6b3c328f1e93d143( location, 1500, 1500, 0 );
    return [ scriptable, location ];
}

// Namespace drone_swarm
// Params 0
// Checksum 0xefe5b0fc, Offset: 0xcfe
// Size: 0x606
function function_c369f0944ca8d4f9()
{
    bundle = level.streakglobals.streakbundles[ "drone_swarm" ];
    var_a996636b32725fe9 = 0;
    groupbuffer = getdvarint( @"hash_bf387ddf15b94493" );
    level.var_6b693ee75ce87960 = [];
    
    if ( !game_utility::islargemap() && getdvarint( @"hash_2cb1cc59241439e5", 0 ) )
    {
        dmspawns = getallnodes();
        level.numnodes = dmspawns.size;
        
        while ( dmspawns.size > 0 && level.var_6b693ee75ce87960.size < bundle.maxdrones )
        {
            randomindex = randomint( dmspawns.size );
            var_ffe6572afd37c790 = dmspawns[ randomindex ];
            var_9849edec3e8d6568 = var_ffe6572afd37c790.origin;
            level.var_6b693ee75ce87960[ level.var_6b693ee75ce87960.size ] = var_9849edec3e8d6568;
            dmspawns = arrayremove( dmspawns, var_ffe6572afd37c790 );
            var_3c084bcd9a043ee0 = function_6a293b884c444a20( dmspawns, var_9849edec3e8d6568, groupbuffer );
            dmspawns = arrayremove( dmspawns, var_3c084bcd9a043ee0 );
        }
        
        return;
    }
    
    startlocation = undefined;
    
    if ( game_utility::islargemap() )
    {
        startlocation = self.origin;
    }
    else
    {
        startlocation = function_54bb9146ad948b1e();
    }
    
    bundle = level.streakglobals.streakbundles[ "drone_swarm" ];
    curzoffset = bundle.droneminheight;
    staticxoffset = 700;
    staticyoffset = 700;
    dronelocations = [];
    offsetmult = 1;
    var_5e60a5c192287565 = [ "highrise", "observatory", "shipment", "rust", "slaughterhouse", "_home_" ];
    
    foreach ( map in var_5e60a5c192287565 )
    {
        if ( issubstr( level.mapname, map ) )
        {
            staticxoffset = int( staticxoffset * 0.6 );
            staticyoffset = int( staticyoffset * 0.6 );
            var_a996636b32725fe9 = 1;
            break;
        }
    }
    
    while ( dronelocations.size < bundle.maxdrones )
    {
        if ( dronelocations.size == 0 )
        {
            dronelocations[ 0 ] = startlocation + ( 0, 0, bundle.droneminheight );
            continue;
        }
        
        curzoffset = curzoffset == bundle.droneminheight ? bundle.dronemaxheight : bundle.droneminheight;
        x = offsetmult * -1;
        
        while ( x <= offsetmult )
        {
            y = offsetmult * -1;
            
            while ( y <= offsetmult )
            {
                if ( x != offsetmult * -1 && x != offsetmult && y != offsetmult * -1 && y != offsetmult )
                {
                }
                else
                {
                    newxoffset = staticxoffset * x;
                    newyoffset = staticyoffset * y;
                    location = startlocation + ( newxoffset, newyoffset, curzoffset );
                    var_d0d9503b37181496 = [ "observatory", "shipment", "rust", "slaughterhouse", "favela", "skidrow", "urca", "_home_", "security", "zooquarium" ];
                    var_1501516fa4fd51aa = 0;
                    
                    foreach ( map in var_d0d9503b37181496 )
                    {
                        if ( issubstr( level.mapname, map ) )
                        {
                            var_1501516fa4fd51aa = 1;
                            break;
                        }
                    }
                    
                    if ( var_1501516fa4fd51aa || utility::issharedfuncdefined( #"game", #"ispointinoutofbounds" ) && ![[ utility::getsharedfunc( #"game", #"ispointinoutofbounds" ) ]]( location ) && !arraycontains( dronelocations, location ) && level.mapname != "mp_jup_observatory" )
                    {
                        dronelocations[ dronelocations.size ] = startlocation + ( newxoffset, newyoffset, curzoffset );
                    }
                    else if ( utility::issharedfuncdefined( #"game", #"ispointinoutofbounds" ) && ![[ utility::getsharedfunc( #"game", #"ispointinoutofbounds" ) ]]( location ) && !arraycontains( dronelocations, location ) && !var_1501516fa4fd51aa )
                    {
                        dronelocations[ dronelocations.size ] = startlocation + ( newxoffset, newyoffset, curzoffset );
                    }
                    else if ( !var_a996636b32725fe9 && dronelocations.size < 8 )
                    {
                        x = offsetmult * -1;
                        y = offsetmult * -1 - 2;
                        staticxoffset = int( staticxoffset * 0.6 );
                        staticyoffset = int( staticyoffset * 0.6 );
                        dronelocations = [];
                        var_a996636b32725fe9 = 1;
                    }
                }
                
                y += 2;
            }
            
            x += 2;
        }
        
        offsetmult++;
    }
    
    level.var_6b693ee75ce87960 = dronelocations;
    self.var_a184934811b36115 = 0;
    
    if ( game_utility::islargemap() )
    {
        foreach ( location in dronelocations )
        {
            function_35ae81741acbc570( location );
        }
    }
}

// Namespace drone_swarm
// Params 0
// Checksum 0xb71fbf7, Offset: 0x130c
// Size: 0x17c
function function_54bb9146ad948b1e()
{
    center = undefined;
    
    if ( game_utility::islargemap() )
    {
        if ( isdefined( level.mapcenter ) )
        {
            center = ( self.origin[ 0 ], self.origin[ 1 ], level.mapcenter[ 2 ] );
        }
        else if ( utility::issharedfuncdefined( #"game", #"hash_9f5916152dc84f2a" ) && isdefined( level.spawnmins ) && isdefined( level.spawnmaxs ) )
        {
            mapcenter = [[ utility::getsharedfunc( #"game", #"hash_9f5916152dc84f2a" ) ]]( level.spawnmins, level.spawnmaxs );
            center = ( self.origin[ 0 ], self.origin[ 1 ], mapcenter[ 2 ] );
        }
        else
        {
            center = self.origin;
        }
    }
    else if ( isdefined( level.mapcenter ) )
    {
        center = level.mapcenter;
    }
    else if ( utility::issharedfuncdefined( #"game", #"hash_9f5916152dc84f2a" ) && isdefined( level.spawnmins ) && isdefined( level.spawnmaxs ) )
    {
        center = [[ utility::getsharedfunc( #"game", #"hash_9f5916152dc84f2a" ) ]]( level.spawnmins, level.spawnmaxs );
    }
    else
    {
        center = ( 0, 0, 0 );
    }
    
    return center;
}

// Namespace drone_swarm
// Params 3
// Checksum 0xfc83ccc5, Offset: 0x1491
// Size: 0x448
function function_1ec6d390833cafd8( streakinfo, var_e298dcb55f5403ca, location )
{
    level endon( #"game_ended" );
    bundle = level.streakglobals.streakbundles[ "drone_swarm" ];
    planeflyheight = bundle.var_b9ef9ac95c3174fe;
    
    if ( game_utility::islargemap() )
    {
        if ( planeflyheight < self.origin[ 2 ] + bundle.var_b9ef9ac95c3174fe )
        {
            planeflyheight = self.origin[ 2 ] + bundle.var_b9ef9ac95c3174fe;
        }
        
        if ( self.var_a184934811b36115 > 0 && self.var_a184934811b36115 + 500 > planeflyheight )
        {
            planeflyheight = self.var_a184934811b36115 + 500;
        }
        
        if ( self.var_2852dd203c16860c + 500 > planeflyheight )
        {
            planeflyheight = self.var_2852dd203c16860c + 500;
        }
    }
    else if ( isdefined( self.var_a184934811b36115 ) )
    {
        planeflyheight += self.var_a184934811b36115;
    }
    
    self.var_3454b4853648dd9f = planeflyheight;
    var_fd1e2725984f8b98 = getdvarint( @"hash_6ca247ada3a708ab" );
    mapcenter = function_54bb9146ad948b1e();
    planespawnloc = ( mapcenter[ 0 ] + var_fd1e2725984f8b98 * 1.5, mapcenter[ 1 ] + var_fd1e2725984f8b98 * 1.5, planeflyheight * 1.35 );
    var_82dea62ff0dafcf6 = ( mapcenter[ 0 ] - var_fd1e2725984f8b98 * 1.5, mapcenter[ 1 ] - var_fd1e2725984f8b98 * 1.5, planeflyheight * 1.35 );
    pathstart = ( mapcenter[ 0 ] + var_fd1e2725984f8b98 / 2, mapcenter[ 1 ] + var_fd1e2725984f8b98 / 2, planeflyheight );
    pathend = ( mapcenter[ 0 ] - var_fd1e2725984f8b98 / 2, mapcenter[ 1 ] - var_fd1e2725984f8b98 / 2, planeflyheight );
    enterangles = vectortoangles( pathstart - planespawnloc );
    deployangles = vectortoangles( pathend - pathstart );
    exitangles = vectortoangles( var_82dea62ff0dafcf6 - pathend );
    deploydist = distance( pathstart, pathend );
    enterexittime = distance( planespawnloc, pathstart ) / deploydist / var_e298dcb55f5403ca / 2;
    deploy_plane = spawn( "script_model", planespawnloc );
    bundle = level.streakglobals.streakbundles[ "drone_swarm" ];
    
    if ( !isdefined( deploy_plane ) )
    {
        return;
    }
    
    deploy_plane setmodel( bundle.deployplanemodel );
    deploy_plane.angles = enterangles;
    deploy_plane.owner = streakinfo.owner;
    deploy_plane.team = streakinfo.owner.team;
    deploy_plane.health = 999999;
    deploy_plane.maxhealth = 999999;
    deploy_plane.currenthealth = deploy_plane.maxhealth;
    deploy_plane.streakinfo = streakinfo;
    deploy_plane.streakname = streakinfo.streakname;
    
    if ( utility::issharedfuncdefined( #"game", #"createobjective" ) )
    {
        deploy_plane.minimapid = deploy_plane [[ utility::getsharedfunc( #"game", #"createobjective" ) ]]( bundle.var_1fa9d09714bec2f8, deploy_plane.team, 1, 1, 1 );
    }
    
    deploy_plane moveto( pathstart, enterexittime, 0, 1 );
    deploy_plane playsoundonmovingent( "kls_drone_swarm_jet_start" );
    wait enterexittime - 2;
    deploy_plane function_aaf84942c0b84b46( pathstart - planespawnloc, pathend - pathstart );
    
    if ( !isdefined( deploy_plane ) )
    {
        return;
    }
    
    deploy_plane moveto( pathend, var_e298dcb55f5403ca, var_e298dcb55f5403ca * 0, var_e298dcb55f5403ca * 0 );
    level.var_6ca63672f6953d28 setscriptablepartstate( "planeSfx", "enabled" );
    level.var_6ca63672f6953d28 setscriptablepartstate( "vfx", "enabled" );
    level.var_6ca63672f6953d28 setscriptablepartstate( "droneSfx", "enabled" );
    deploy_plane setscriptablepartstate( "drone_swarm_deploy", "on" );
    deploy_plane thread function_265651d080eba225( var_e298dcb55f5403ca, pathend - pathstart, var_82dea62ff0dafcf6 - pathend, var_82dea62ff0dafcf6, enterexittime );
    return deploy_plane;
}

// Namespace drone_swarm
// Params 2
// Checksum 0x87269a79, Offset: 0x18e2
// Size: 0x6b
function function_aaf84942c0b84b46( vector1, vector2 )
{
    time = 0;
    
    while ( time < 1.5 )
    {
        self.angles = vectortoangles( vectorlerp( vector1, vector2, time / 1.5 ) );
        wait 0.1;
        time += 0.1;
    }
    
    self.angles = vectortoangles( vector2 );
}

// Namespace drone_swarm
// Params 5
// Checksum 0x351879e2, Offset: 0x1955
// Size: 0xcc
function function_265651d080eba225( deploytime, deployvector, exitvector, exitloc, exittime )
{
    level endon( #"game_ended" );
    wait deploytime - 2;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    function_aaf84942c0b84b46( deployvector, exitvector );
    self moveto( exitloc, exittime, 0, 0 );
    level.var_6ca63672f6953d28 setscriptablepartstate( "planeSfx", "disabled" );
    self setscriptablepartstate( "drone_swarm_deploy", "off" );
    wait exittime;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !self.owner.ksempd )
    {
        level.var_6ca63672f6953d28 setscriptablepartstate( "planeSfx", "disabled" );
    }
    
    functionals_utility::clearminimapid();
    self delete();
}

// Namespace drone_swarm
// Params 3
// Checksum 0x7f5bfebd, Offset: 0x1a29
// Size: 0x140
function function_e9ab6cb8a4df9139( spawnlocation, targetlocation, streakinfo )
{
    bundle = level.streakglobals.streakbundles[ "drone_swarm" ];
    movetime = 5;
    dronescriptmodel = spawn( "script_model", spawnlocation );
    dronescriptmodel setmodel( bundle.dronemodel );
    dronescriptmodel moveto( targetlocation, movetime, 0.25, 0.25 );
    wait movetime;
    
    if ( !streakinfo.owner.ksempd )
    {
        spawneddrone = function_9353050551690d( targetlocation, streakinfo );
        
        if ( isdefined( spawneddrone ) )
        {
            if ( !isdefined( level.var_ca5d755a7f4645f5 ) )
            {
                level.var_ca5d755a7f4645f5 = [];
            }
            
            level.var_ca5d755a7f4645f5[ level.var_ca5d755a7f4645f5.size ] = spawneddrone;
            
            if ( utility::issharedfuncdefined( #"killstreak", #"addtoactivekillstreaklist" ) )
            {
                spawneddrone [[ utility::getsharedfunc( #"killstreak", #"addtoactivekillstreaklist" ) ]]( streakinfo.streakname, "Killstreak_Air", self, 0, 1, 100 );
            }
        }
    }
    
    dronescriptmodel delete();
}

// Namespace drone_swarm
// Params 2
// Checksum 0x5a31fcf9, Offset: 0x1b71
// Size: 0x370
function function_9353050551690d( location, streakinfo )
{
    bundle = level.streakglobals.streakbundles[ "drone_swarm" ];
    spawneddrone = self launchgrenade( bundle.droneweapon, location, ( 0, 0, 0 ) );
    spawneddrone setscriptablepartstate( "visibility", "show" );
    spawneddrone.targetorigin = location;
    spawneddrone.owner = streakinfo.owner;
    spawneddrone.team = streakinfo.owner.team;
    spawneddrone.streakinfo = streakinfo;
    var_93c3d1eb8ee6818b = undefined;
    
    /#
        var_93c3d1eb8ee6818b = getdvarint( @"hash_dc292ed5d6a897a4", 0 );
    #/
    
    if ( ( bundle.var_e896a6e2245b8dc5 || var_93c3d1eb8ee6818b ) && utility::issharedfuncdefined( #"game", #"createobjective" ) )
    {
        spawneddrone.minimapid = spawneddrone [[ utility::getsharedfunc( #"game", #"createobjective" ) ]]( bundle.minimapicon, spawneddrone.team, 1, 1, 1 );
    }
    
    var_e7de05a59523ded8 = 0;
    var_e7de05a59523ded8 = spawneddrone switchblade_drone::function_bb4c3b83ccb10112( "drone_swarm" );
    
    if ( !var_e7de05a59523ded8 && level.mapname == "mp_jup_afghan_v2" )
    {
        var_e7de05a59523ded8 = 1;
        centerpos = ( spawneddrone.targetorigin[ 0 ], spawneddrone.targetorigin[ 1 ], spawneddrone.targetorigin[ 2 ] + bundle.dronemaxheight );
        startlocation = centerpos + anglestoforward( spawneddrone.angles ) * bundle.droneminradius;
        spawneddrone.startpos = startlocation;
        spawneddrone.centerpos = centerpos;
    }
    
    /#
        var_93c3d1eb8ee6818b = getdvarint( @"hash_dc292ed5d6a897a4", 0 );
    #/
    
    if ( !var_e7de05a59523ded8 )
    {
        if ( bundle.var_e896a6e2245b8dc5 || var_93c3d1eb8ee6818b )
        {
            spawneddrone functionals_utility::clearminimapid();
        }
        
        spawneddrone thread switchblade_drone::function_86274791b06a03e4();
        return;
    }
    
    params = spawnstruct();
    params.streakinfo = streakinfo;
    spawneddrone callback::add( #"on_functional_death", &function_463ee5f97bebadaa, params );
    spawneddrone.var_88f80ee5f6fd30fd = 1;
    
    if ( bundle.candamage && utility::issharedfuncdefined( #"damage", #"monitordamage" ) )
    {
        spawneddrone thread [[ utility::getsharedfunc( #"damage", #"monitordamage" ) ]]( bundle.maxhealth ?? 25, "hitequip", &functionals_utility::functionals_handlefataldamage, &functionals_utility::functionals_handledamage, 0 );
    }
    
    spawneddrone thread functionals_utility::function_d858d002df0a2feb( 65, 12 );
    spawneddrone thread functionals_utility::function_3d1c0cb00ce4d44e( 20, 10, 7 );
    flyvelocity = randomfloatrange( 400, 650 );
    spawneddrone thread switchblade_drone::function_d32356ca1f7fa343( spawneddrone.centerpos, spawneddrone.startpos, flyvelocity );
    spawneddrone thread switchblade_drone::function_d353828f3fe83995( "drone_swarm", -400 );
    spawneddrone thread function_66d1f94fd4d2ee84( 5, 10 );
    return spawneddrone;
}

// Namespace drone_swarm
// Params 1
// Checksum 0x214a2f15, Offset: 0x1eea
// Size: 0x42
function drone_swarm_empapplied( streakinfo )
{
    streakinfo.owner endon( #"drone_swarm_timeout" );
    streakinfo.owner waittill( #"emp_applied" );
    drone_swarm_cleanup( streakinfo );
}

// Namespace drone_swarm
// Params 2
// Checksum 0x2b390dbe, Offset: 0x1f34
// Size: 0x1b4
function function_463ee5f97bebadaa( callbackparams, additionalparams )
{
    bundle = level.streakglobals.streakbundles[ "drone_swarm" ];
    
    /#
        var_4fbec1d543a5610 = getdvarint( @"hash_5a8e2bfaac44df7f" );
        
        if ( var_4fbec1d543a5610 < 0 )
        {
            unlimiteddrones = 1;
        }
    #/
    
    if ( self.var_88f80ee5f6fd30fd && level.droneswarmactive && ( level.var_71105df95dea195c > 0 || bundle.var_7798ed31dc26c2e0 < 0 || unlimiteddrones ) )
    {
        zoffset = bundle.var_b9ef9ac95c3174fe + ( self.var_a184934811b36115 ?? 0 );
        respawnoffset = ( 500, 500, zoffset );
        spawnlocation = self.targetorigin + respawnoffset;
        self.owner thread function_e9ab6cb8a4df9139( spawnlocation, self.targetorigin, additionalparams.streakinfo );
        
        if ( bundle.var_7798ed31dc26c2e0 > 0 )
        {
            level.var_71105df95dea195c--;
        }
    }
    
    switchblade_drone::function_2fd31dd9e3c72c80( additionalparams );
    level.var_ca5d755a7f4645f5 = arrayremove( level.var_ca5d755a7f4645f5, self );
    bundle = level.streakglobals.streakbundles[ "drone_swarm" ];
    var_93c3d1eb8ee6818b = undefined;
    
    /#
        var_93c3d1eb8ee6818b = getdvarint( @"hash_dc292ed5d6a897a4", 0 );
    #/
    
    if ( bundle.var_e896a6e2245b8dc5 || var_93c3d1eb8ee6818b )
    {
        functionals_utility::clearminimapid();
    }
    
    wait 1;
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace drone_swarm
// Params 0
// Checksum 0xed525854, Offset: 0x20f0
// Size: 0x7b
function function_9e446e6189b745ee()
{
    randomdelay = randomfloatrange( 0, 3 );
    wait randomdelay;
    
    if ( !self.ispreparing )
    {
        thread switchblade_drone::function_d1404124d2dfbbb7( undefined, utility::groundpos( self.targetorigin ) );
    }
    
    bundle = level.streakglobals.streakbundles[ "drone_swarm" ];
    
    if ( bundle.var_e896a6e2245b8dc5 )
    {
        functionals_utility::clearminimapid();
    }
}

// Namespace drone_swarm
// Params 1
// Checksum 0xb7301e5f, Offset: 0x2173
// Size: 0x126
function drone_swarm_cleanup( streakinfo )
{
    level.droneswarmactive = 0;
    self playsoundonmovingent( "kls_drone_swarm_exit" );
    
    if ( isdefined( level.var_ca5d755a7f4645f5 ) )
    {
        foreach ( var_1c66fb306f7bde0c in level.var_ca5d755a7f4645f5 )
        {
            if ( isdefined( var_1c66fb306f7bde0c ) )
            {
                var_1c66fb306f7bde0c.var_88f80ee5f6fd30fd = 0;
                var_1c66fb306f7bde0c thread function_9e446e6189b745ee();
            }
        }
    }
    
    if ( isdefined( level.var_6ca63672f6953d28 ) )
    {
        level.var_6ca63672f6953d28 setscriptablepartstate( "vfx", "disabled" );
        level.var_6ca63672f6953d28 setscriptablepartstate( "droneSfx", "disabled" );
        level.var_6ca63672f6953d28 setscriptablepartstate( "music", "disabled" );
        level.var_6ca63672f6953d28 freescriptable();
    }
    
    killstreak_utility::recordkillstreakendstats( streakinfo );
}

// Namespace drone_swarm
// Params 4
// Checksum 0x1671d645, Offset: 0x22a1
// Size: 0x485
function function_6b3c328f1e93d143( location, offsetx, offsety, offsetz )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( isdefined( level.player ) )
    {
        level.player setsoundsubmix( "jup_kls_drone_swarm", 0 );
    }
    else
    {
        foreach ( player in level.players )
        {
            player setsoundsubmix( "jup_kls_drone_swarm", 0 );
        }
    }
    
    if ( game_utility::islargemap() )
    {
        offsetx *= 2;
        offsety *= 2;
    }
    
    var_8461dc891a04914a = spawn( "script_origin", location + ( offsetx * -1, 0, offsetz ) );
    var_8461db891a048f17 = spawn( "script_origin", location + ( offsetx, 0, offsetz ) );
    var_2bd808a43d921ebf = spawn( "script_origin", location + ( 0, offsety * -1, offsetz ) );
    var_2bd809a43d9220f2 = spawn( "script_origin", location + ( 0, offsety, offsetz ) );
    wait 7;
    var_8461dc891a04914a playloopsound( "kls_drone_swarm_lp_01" );
    var_8461db891a048f17 playloopsound( "kls_drone_swarm_lp_02" );
    var_2bd808a43d921ebf playloopsound( "kls_drone_swarm_lp_03" );
    var_2bd809a43d9220f2 playloopsound( "kls_drone_swarm_lp_04" );
    
    if ( isdefined( level.player ) )
    {
        level.player clearsoundsubmix( "jup_kls_drone_swarm", 3 );
    }
    else
    {
        foreach ( player in level.players )
        {
            player setsoundsubmix( "jup_kls_drone_swarm", 0 );
        }
    }
    
    wait 7;
    
    if ( isdefined( level.player ) )
    {
        level.player setsoundsubmix( "jup_kls_drone_swarm", 0, 0 );
    }
    else
    {
        foreach ( player in level.players )
        {
            player setsoundsubmix( "jup_kls_drone_swarm", 0, 0 );
        }
    }
    
    utility::waittill_any_timeout( level.streakglobals.streakbundles[ "drone_swarm" ].dronelifetime, "emp_applied" );
    
    if ( isdefined( level.player ) )
    {
        level.player setsoundsubmix( "jup_kls_drone_swarm", 5, 1 );
    }
    else
    {
        foreach ( player in level.players )
        {
            player setsoundsubmix( "jup_kls_drone_swarm", 5, 1 );
        }
    }
    
    wait 1.1;
    
    if ( isdefined( level.player ) )
    {
        level.player clearsoundsubmix( "jup_kls_drone_swarm", 1 );
    }
    else
    {
        foreach ( player in level.players )
        {
            player clearsoundsubmix( "jup_kls_drone_swarm", 1 );
        }
    }
    
    var_8461dc891a04914a stoploopsound( "kls_drone_swarm_lp_01" );
    var_8461db891a048f17 stoploopsound( "kls_drone_swarm_lp_02" );
    var_2bd808a43d921ebf stoploopsound( "kls_drone_swarm_lp_03" );
    var_2bd809a43d9220f2 stoploopsound( "kls_drone_swarm_lp_04" );
    var_8461dc891a04914a delete();
    var_8461db891a048f17 delete();
    var_2bd808a43d921ebf delete();
    var_2bd809a43d9220f2 delete();
}

// Namespace drone_swarm
// Params 2
// Checksum 0xb02899a4, Offset: 0x272f
// Size: 0x97
function function_66d1f94fd4d2ee84( minrate, maxrate )
{
    self endon( #"emp_applied" );
    self endon( #"death" );
    self endon( #"hash_9e8daf5ca454e94" );
    self endon( #"divebombing" );
    self endon( #"hash_ca59c633a924494c" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        ranrate = randomintrange( minrate, maxrate );
        wait ranrate;
        self playsoundonmovingent( "kls_drone_swarm_flybys" );
        
        if ( level.droneswarmactive == 0 )
        {
            break;
        }
    }
}

