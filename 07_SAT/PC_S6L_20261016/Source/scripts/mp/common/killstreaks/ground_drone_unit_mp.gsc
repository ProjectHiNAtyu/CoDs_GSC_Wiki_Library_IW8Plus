// scripts\mp\common\killstreaks\ground_drone_unit_mp.gsc  (hash_0dfecf18a43ad5ed.gscc) (size: 41945 Bytes / 0xa3d9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf9842ea1 (4186189473)
// size ...... 41945 (0xa3d9)
// includes .. 29  (offset: 0x9c1d)
// strings ... 81  (offset: 0x9d05)
// dev strs .. 34  (offset: 0xa231)
// exports ... 82  (offset: 0x6c91)
// cseg ...... 0x647 + 0x664a (0x6c91)
// imports ... 272 (offset: 0x7961)
// animtree1 . 0   (offset: 0xa3d9)
// animtree2 . 0   (offset: 0xa3d9)
#using script_13865ca76df87ea;
#using script_16ea1b94f0f381b3;
#using scripts\common\anim;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\killstreaks\killstreak_common;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_roads;
#using scripts\common\vehicle_tracking;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\damage;
#using scripts\mp\emp_debuff;
#using scripts\mp\entityheadicons;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\spawnlogic;
#using scripts\mp\weapons;

#namespace ground_drone_unit_mp;

// Namespace ground_drone_unit_mp
// Params 0, eflags: 0x1
// Checksum 0xb7412e65, Offset: 0x665
// Size: 0x17
function autoexec main()
{
    killstreak_shared::registerkillstreakinitfunction( getxhash( "ground_drone_unit" ), &gdu_init );
}

// Namespace ground_drone_unit_mp
// Params 0, eflags: 0x4
// Checksum 0xf8f1ba88, Offset: 0x684
// Size: 0x199
function private gdu_init()
{
    /#
        level thread function_e287d8a698337a41();
    #/
    
    if ( utility::issharedfuncdefined( #"killstreak", #"registerkillstreak" ) )
    {
        [[ utility::getsharedfunc( #"killstreak", #"registerkillstreak" ) ]]( "ground_drone_unit", &function_1892c216d432c57c );
        bundle = level.streakglobals.streakbundles[ "ground_drone_unit" ];
        vehbundlename = "vehiclebundle:" + bundle.deployedvehiclebundle;
        vehbundle = getscriptbundle( getxhashasset( vehbundlename ) );
        
        if ( isstruct( vehbundle ) && isdefined( vehbundle.weapon ) )
        {
            namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( "ground_drone_unit", vehbundle.weapon, #"large" );
        }
    }
    
    utility::registersharedfunc( #"ground_drone_unit", #"hack", &gdu_hack );
    utility::registersharedfunc( #"ground_drone_unit", #"freeze", &gdu_freeze );
    utility::registersharedfunc( #"ground_drone_unit", #"hash_6f529a6e863454a1", &gdu_freeze );
    utility::registersharedfunc( #"ground_drone_unit", #"teardown", &gdu_teardown );
    level.var_1200396612528afe = [];
    
    if ( !isdefined( level.var_cf1a19e5b5e12970 ) )
    {
        level.var_cf1a19e5b5e12970 = throttle::throttle_initialize( "ground_drone_look_for_targets", 1 );
    }
    
    utility::flag_set( "ground_drone_unit_initialized" );
    function_a77d3005042d57f3();
    
    /#
        gdu_debug();
    #/
}

// Namespace ground_drone_unit_mp
// Params 1, eflags: 0x4
// Checksum 0xfb753d1c, Offset: 0x825
// Size: 0xf9
function private function_254c4ad11edac24a( grounddrone )
{
    grounddrone vehphys_enablecollisioncallback( 1 );
    
    while ( grounddrone )
    {
        grounddrone waittill( #"collision", body0, body1, flag0, flag1, position, normal, normalspeed, ent );
        
        if ( function_45fdeb14df65661b( body1 ) && ent === level.wonder_veh )
        {
            explosionradius = explosionradius ?? grounddrone.bundle.gduexplosionradius ?? 225;
            explosiondamage = explosiondamage ?? grounddrone.bundle.var_395b93d2fa9ee5de ?? 500;
            grounddrone thread gdu_explode( explosionradius, explosiondamage, 1 );
            break;
        }
    }
}

/#

    // Namespace ground_drone_unit_mp
    // Params 0, eflags: 0xc
    // Checksum 0xc91caaf7, Offset: 0x926
    // Size: 0xef, Type: dev
    function private function_e287d8a698337a41()
    {
        self notify( #"hash_79998ef253f62dc2" );
        self endon( #"hash_79998ef253f62dc2" );
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_8793bde3437aca7c", 0 ) )
            {
                foreach ( var_c05deaa057ac4a91 in level.var_3d1af6b4fa55bd37 )
                {
                    circle( var_c05deaa057ac4a91.origin, sqrt( var_c05deaa057ac4a91.radiussquared ), ( 0, 0, 1 ), ( 1, 0, 0 ), 0, 1 );
                }
            }
            
            waitframe();
        }
    }

#/

// Namespace ground_drone_unit_mp
// Params 1, eflags: 0x4
// Checksum 0x56445632, Offset: 0xa1d
// Size: 0x1c1, Type: bool
function private function_1892c216d432c57c( streakinfo )
{
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    bundle = streakinfo.bundle ?? level.streakglobals.streakbundles[ "ground_drone_unit" ];
    gestureweaponobj = makeweapon( bundle.deployweaponname );
    animationresult = killstreakdeploy::streakdeploy_dogesturedeploy( streakinfo, gestureweaponobj );
    
    if ( !animationresult )
    {
        return false;
    }
    
    streakinfo.streakduration = ( bundle.gdutimeout ?? 60 ) + 15;
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
            return false;
        }
    }
    
    if ( level.gameended )
    {
        streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
        return false;
    }
    
    level thread function_f9b4c7aa28280fa6( self, streakinfo );
    var_65934120c2efeb81 = undefined;
    
    if ( utility::issharedfuncdefined( #"sound", #"playkillstreakdeploydialog" ) )
    {
        self [[ utility::getsharedfunc( #"sound", #"playkillstreakdeploydialog" ) ]]( streakinfo.streakname );
        var_65934120c2efeb81 = 2;
    }
    
    thread killstreak_utility::playkillstreaktacomdialog( streakinfo, "ground_drone_unit" + "_use", #"use", 1, var_65934120c2efeb81 );
    
    if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) )
    {
        self thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( "used_" + "ground_drone_unit", self );
    }
    
    return true;
}

// Namespace ground_drone_unit_mp
// Params 2, eflags: 0xc
// Checksum 0xdeabe13c, Offset: 0xbe7
// Size: 0x5b
function private function_f9b4c7aa28280fa6( player, streakinfo )
{
    self notify( #"hash_291c108a5077f617" );
    self endon( #"hash_291c108a5077f617" );
    level endon( #"game_ended" );
    player notify( #"ground_drone_used" );
    level thread function_2776f3e18cff78ab( player, streakinfo );
    player thread gdu_watchgameend( streakinfo );
}

// Namespace ground_drone_unit_mp
// Params 7, eflags: 0x4
// Checksum 0x7fbcf945, Offset: 0xc4a
// Size: 0x36b
function private function_8fb172a7cb712f43( spawndata, minradius, maxradius, gdus, var_3ce2f3eec5959d29, useparachute, contentoverride )
{
    droneowner = self;
    searchheight = 512;
    
    for ( tacpoints = function_a034a927128ada11( droneowner.origin, maxradius, minradius, searchheight ); tacpoints.size == 0 && searchheight < 9000 ; tacpoints = function_a034a927128ada11( droneowner.origin, maxradius, minradius, searchheight ) )
    {
        searchheight *= 2;
    }
    
    foreach ( point in tacpoints )
    {
        if ( point.groundpos )
        {
            targetlocation = point.groundpos;
            
            if ( useparachute )
            {
                spawnlocation = targetlocation + ( 0, 0, 5000 );
            }
            
            skip = 0;
            
            foreach ( var_c05deaa057ac4a91 in level.var_3d1af6b4fa55bd37 )
            {
                if ( distance2dsquared( targetlocation, var_c05deaa057ac4a91.origin ) < var_c05deaa057ac4a91.radiussquared )
                {
                    skip = 1;
                    break;
                }
            }
            
            if ( skip )
            {
                continue;
            }
            
            if ( spawndata.spawns.size > 0 )
            {
                foreach ( spawn in spawndata.spawns )
                {
                    if ( distancesquared( targetlocation, spawn[ 0 ] ) < var_3ce2f3eec5959d29 )
                    {
                        skip = 1;
                        break;
                    }
                }
                
                if ( skip )
                {
                    continue;
                }
            }
            
            if ( !tacpointexposedtosky( point, 1 ) )
            {
                continue;
            }
            
            if ( utility::issharedfuncdefined( #"gdu", #"hash_639342328e0ad856" ) && !utility::callsharedfunc( #"gdu", #"hash_639342328e0ad856", targetlocation ) )
            {
                continue;
            }
            
            traceresult = trace::sphere_trace( targetlocation + ( 0, 0, 100 ), targetlocation + ( 0, 0, 2000 ), 50, [], contentoverride );
            waitframe();
            
            if ( traceresult[ "hittype" ] != "hittype_none" )
            {
                continue;
            }
            
            /#
            #/
            
            spawndata.spawns[ spawndata.spawns.size ] = [ targetlocation, spawnlocation ];
        }
        
        if ( spawndata.spawns.size == gdus )
        {
            return;
        }
    }
}

/#

    // Namespace ground_drone_unit_mp
    // Params 1, eflags: 0x4
    // Checksum 0x1bd81fe0, Offset: 0xfbd
    // Size: 0x3f, Type: dev
    function private function_46fa71a4a4a466e3( targetlocation )
    {
        circle( ( targetlocation[ 0 ], targetlocation[ 1 ], 1000 ), 20, ( 0, 0, 1 ), ( 0, 0, 1 ), 0, 1000 );
    }

#/

// Namespace ground_drone_unit_mp
// Params 2, eflags: 0x4
// Checksum 0x2bb262da, Offset: 0x1004
// Size: 0xfc
function private function_5ed755a95eee7c63( spawndata, streakinfo )
{
    droneowner = self;
    bundle = streakinfo.bundle ?? level.streakglobals.streakbundles[ "ground_drone_unit" ];
    gdus = bundle.var_98b7d82e1abdb13f;
    useparachute = bundle.var_17fdb7e0949d129e ?? 1;
    var_1015b2967c75bab8 = droneowner.origin;
    var_3ce2f3eec5959d29 = bundle.var_f8d5ded860459592 ?? 250;
    var_3ce2f3eec5959d29 *= var_3ce2f3eec5959d29;
    contentoverride = trace::create_contents( 0, 1, 0 );
    InvalidOpCode( 0x8f, [] );
    // Unknown operator ( 0x8f, t11, Black Ops 7 )
}

/#

    // Namespace ground_drone_unit_mp
    // Params 1, eflags: 0x4
    // Checksum 0x2e852a03, Offset: 0x11b5
    // Size: 0x278, Type: dev
    function private function_283f920f0473cfc5( streakinfo )
    {
        droneowner = self;
        spawndata = { #spawns:[] };
        goodspawns = [];
        badspawns = [];
        lastposition = droneowner.origin;
        contents = trace::create_contents( 0, 1, 0 );
        
        while ( true )
        {
            if ( distance2dsquared( droneowner.origin, lastposition ) > 10000 )
            {
                lastposition = droneowner.origin;
                droneowner function_5ed755a95eee7c63( spawndata, streakinfo );
                
                foreach ( spawn in spawndata.spawns )
                {
                    traceresult = trace::sphere_trace( spawn[ 0 ] + ( 0, 0, 100 ), spawn[ 0 ] + ( 0, 0, 10000 ), 10, [], contents );
                    
                    if ( traceresult[ "<dev string:x40>" ] == "<dev string:x48>" )
                    {
                        goodspawns[ goodspawns.size ] = spawn[ 0 ];
                        continue;
                    }
                    
                    badspawns[ badspawns.size ] = spawn[ 0 ];
                }
                
                spawndata = { #spawns:[] };
            }
            
            foreach ( spawn in goodspawns )
            {
                /#
                    sphere( spawn, 10, ( 0, 1, 0 ), 0, 1 );
                #/
            }
            
            foreach ( spawn in badspawns )
            {
                /#
                    sphere( spawn, 20, ( 1, 0, 0 ), 0, 1 );
                #/
            }
            
            waitframe();
        }
    }

#/

// Namespace ground_drone_unit_mp
// Params 2, eflags: 0x4
// Checksum 0x431dcde5, Offset: 0x1435
// Size: 0x2ba
function private function_2776f3e18cff78ab( droneowner, streakinfo )
{
    level endon( #"hash_10fa63cc8152d54f" );
    bundle = streakinfo.bundle ?? level.streakglobals.streakbundles[ "ground_drone_unit" ];
    droneowner.var_a26ef65e475429e = 0;
    droneowner.var_c6f1d72f26715ecf = 0;
    gdus = bundle.var_98b7d82e1abdb13f;
    spawnattempts = 0;
    
    if ( !isdefined( level.var_1200396612528afe[ droneowner.team ] ) )
    {
        level.var_1200396612528afe[ droneowner.team ] = ( 0, 2000, 0 );
    }
    
    collisioncontents = physics_createcontents( [ "physicscontents_missileclip" ] );
    
    /#
        if ( getdvarint( @"scr_ground_drone_unit_debug", getdvarint( @"hash_22473e6f3d6e4627", 0 ) ) )
        {
            gdus = getdvarint( @"scr_ground_drone_unit_debug", getdvarint( @"hash_22473e6f3d6e4627", 0 ) );
            spawnpoint = droneowner.origin + anglestoforward( droneowner.angles ) * 100 + anglestoleft( droneowner.angles ) * 50 * ( gdus - 1 ) / 2 + anglestoup( droneowner.angles ) * 10;
            streakinfo.spawnedgdus = 0;
            
            while ( streakinfo.spawnedgdus < gdus )
            {
                thread function_bf849300daf6e7da( droneowner, droneowner.team, spawnpoint, streakinfo );
                spawnpoint += anglestoright( droneowner.angles ) * 50;
                waitframe();
                streakinfo.spawnedgdus++;
            }
            
            return;
        }
    #/
    
    /#
    #/
    
    spawndata = { #spawns:[] };
    droneowner function_5ed755a95eee7c63( spawndata, streakinfo );
    droneownerteam = droneowner.team;
    streakinfo.spawnedgdus = ( streakinfo.spawnedgdus ?? 0 ) + spawndata.spawns.size;
    
    foreach ( spawn in spawndata.spawns )
    {
        thread gdu_deploydrone( droneowner, droneownerteam, spawn[ 0 ], spawn[ 1 ], bundle, streakinfo );
        wait 1;
    }
}

// Namespace ground_drone_unit_mp
// Params 6, eflags: 0x4
// Checksum 0x4e687f91, Offset: 0x16f7
// Size: 0x539
function private gdu_deploydrone( droneowner, droneownerteam, targetlocation, spawnlocation, bundle, streakinfo )
{
    level endon( #"hash_10fa63cc8152d54f" );
    
    if ( utility::issharedfuncdefined( #"gdu", #"gdu_spawn_start" ) )
    {
        spawnlocation = utility::callsharedfunc( #"gdu", #"gdu_spawn_start", droneowner, targetlocation, spawnlocation, bundle, streakinfo );
        thread function_bf849300daf6e7da( droneowner, droneownerteam, spawnlocation, streakinfo );
        return;
    }
    
    useparachute = bundle.var_17fdb7e0949d129e ?? 1;
    var_d4391e69e13d7fa4 = bundle.var_b5b869e9022b7853;
    
    if ( useparachute )
    {
        chuteanim = bundle.var_43e24e183eff94a0 ?? 0;
        animid = "brc130_drop_low";
        animlengthmodifier = 6.5;
        animzoffset = 950;
        
        if ( chuteanim == 1 )
        {
            animid = "brc130_drop_med";
            animlengthmodifier = 8;
            animzoffset = 800;
        }
        else if ( chuteanim == 2 )
        {
            animid = "brc130_drop_high";
            animlengthmodifier = 8;
            animzoffset = 800;
        }
        
        releaseheight = bundle.var_1ee190337ef24242 ?? 1100;
        dummypod = spawn( "script_model", targetlocation + ( 0, 0, animzoffset + releaseheight ) );
        
        if ( var_d4391e69e13d7fa4 && getdvarint( @"hash_ebe5848ab1d80847", 0 ) != 1 )
        {
            dummypod.var_5f8ae329b421d7d1 = dummypod objidpoolmanager::createobjective( "ui_map_icon_jugg_drop", droneownerteam, 0, 1, 0 );
        }
        
        if ( isplayer( self.owner ) )
        {
            dummypod setentityowner( self.owner );
        }
        
        dummypod setmodel( "xcomp_veh_sat_mil_drone_gdu_chute" );
        dummypod.animname = "care_package_chute";
        dummypod animation::setanimtree();
        dummypod.dropanim = level.scr_anim[ dummypod.animname ][ animid ];
        dummypod.animlength = getanimlength( dummypod.dropanim );
        dummypod thread animation::anim_single_solo( dummypod, animid );
        dummypod.team = droneowner.team;
        dummypod playloopsound( "veh_sat_kls_gdu_plane_para_drop_lp" );
        dummypod.owner = droneowner;
        dummypod.streakinfo = streakinfo;
        
        if ( bundle.var_e5cbe40a8c95763a )
        {
            cannisterhealth = bundle.var_a0c1e0c5c112bbc1 ?? 50;
            dummypod thread damage::monitordamage( cannisterhealth, "hitequip", &function_26f155791aba81a8, undefined );
            
            if ( level.var_36218e71baa7e689 )
            {
                dummypod.var_c5ccf9dff3b5e393 = &function_5518ee0639d4515b;
            }
            
            if ( level.var_36218e71baa7e689 )
            {
                level.var_89fe7f9fa2bc945d[ level.var_89fe7f9fa2bc945d.size ] = dummypod;
            }
        }
        
        wait dummypod.animlength - animlengthmodifier;
        
        if ( isdefined( dummypod ) && !dummypod.isexploding )
        {
            dummypod unlink();
            dummypod stoploopsound();
            var_41b85f1da7cc0140 = dummypod.origin - ( 0, 0, 30 );
            dummypod setscriptablepartstate( "deploy", "on" );
            waitframe();
            
            if ( dummypod.var_5f8ae329b421d7d1 )
            {
                utility::callsharedfunc( #"game", #"returnobjectiveid", dummypod.var_5f8ae329b421d7d1 );
                dummypod.var_5f8ae329b421d7d1 = undefined;
            }
            
            thread function_bf849300daf6e7da( droneowner, droneownerteam, var_41b85f1da7cc0140, streakinfo );
            wait 3;
            
            if ( dummypod )
            {
                dummypod delete();
            }
        }
        else
        {
            streakinfo.spawnedgdus--;
            var_1731f5a72d7af7d = bundle.var_1731f5a72d7af7d ?? 2;
            
            if ( streakinfo.spawnedgdus == var_1731f5a72d7af7d )
            {
                level callback::callback( #"killstreak_finish_use", { #streakinfo:streakinfo } );
            }
        }
        
        return;
    }
    
    wait 1;
    pod = namespace_9d8e359c3b1041e5::magicbulletsharedfunc( makeweapon( bundle.projectileweapon ), spawnlocation, targetlocation, droneowner );
    pod setentityowner( droneowner );
    pod setotherent( droneowner );
    impactinfo = pod killstreak_shared::killstreak_waittillexplode( "collision", "explode", "death", "disowned", "emp_defused", "trophy_blocked" );
    dummypod = spawn( "script_model", targetlocation );
    dummypod setmodel( bundle.var_4b9fcae2c5599494 );
    dummypod.angles = pod.angles;
    playfx( utility::getfx( "skewer_impact_ground" ), pod.origin );
    wait 3;
    playsoundatpos( dummypod.origin, "iw9_frag_grenade_expl_trans" );
    dummypod setscriptablepartstate( "deploy", "on" );
    waitframe();
    spawndirection = ( targetlocation - spawnlocation ) * ( 1, 1, 0 );
    thread function_bf849300daf6e7da( droneowner, targetlocation, streakinfo, spawndirection );
    dummypod endon( #"death" );
    wait 3;
    
    if ( dummypod )
    {
        dummypod delete();
    }
}

// Namespace ground_drone_unit_mp
// Params 1, eflags: 0x4
// Checksum 0xbd236518, Offset: 0x1c38
// Size: 0x10b
function private function_26f155791aba81a8( data )
{
    self.isexploding = 1;
    self setscriptablepartstate( "explode", "on" );
    dummygdu = spawn( "script_model", self.origin );
    dummygdu setmodel( "veh_sat_mil_drone_gdu" );
    dummygdu setscriptablepartstate( #"explode", #"on" );
    
    if ( isplayer( data.attacker ) && data.attacker.team != self.team )
    {
        data.attacker thread points::doscoreevent( #"hash_c43f2101aca97973" );
    }
    
    if ( self.var_5f8ae329b421d7d1 )
    {
        utility::callsharedfunc( #"game", #"returnobjectiveid", self.var_5f8ae329b421d7d1 );
        self.var_5f8ae329b421d7d1 = undefined;
    }
    
    wait 3;
    
    if ( self )
    {
        self delete();
    }
    
    if ( dummygdu )
    {
        dummygdu delete();
    }
}

// Namespace ground_drone_unit_mp
// Params 2, eflags: 0x4
// Checksum 0x82e33094, Offset: 0x1d4b
// Size: 0x12b
function private function_6fdde82e2cb182fe( collisioncontents, var_a4acb1826b72e655 )
{
    self endon( #"death" );
    
    while ( true )
    {
        var_87b5222b397a5a98 = abs( var_a4acb1826b72e655 - self.origin[ 2 ] );
        assert( var_87b5222b397a5a98 < 500, "<dev string:x55>" );
        var_a4acb1826b72e655 = self.origin[ 2 ];
        castresults = physics_raycast( self.origin, self.origin - ( 0, 0, max( 50, var_87b5222b397a5a98 ) * 2 ), collisioncontents, undefined, 0, "physicsquery_all" );
        
        foreach ( result in castresults )
        {
            if ( result[ "entity" ].script_noteworthy != "heli_height_mesh" )
            {
                self function_d2b8ee2e1275daaf( 0 );
                return;
            }
        }
        
        waitframe();
    }
}

// Namespace ground_drone_unit_mp
// Params 0, eflags: 0x4
// Checksum 0xc3f88cc5, Offset: 0x1e7e
// Size: 0x15b
function private function_50e5c7d94ea0a4bf()
{
    self endon( #"death" );
    collisioncontents = physics_createcontents( [ "physicscontents_vehicleclip" ] );
    var_a4acb1826b72e655 = self.origin[ 2 ];
    
    while ( true )
    {
        var_87b5222b397a5a98 = abs( var_a4acb1826b72e655 - self.origin[ 2 ] );
        assert( var_87b5222b397a5a98 < 500, "<dev string:x55>" );
        var_a4acb1826b72e655 = self.origin[ 2 ];
        castresults = physics_raycast( self.origin, self.origin - ( 0, 0, max( 50, var_87b5222b397a5a98 ) * 2 ), collisioncontents, undefined, 0, "physicsquery_all" );
        
        foreach ( result in castresults )
        {
            if ( result[ "entity" ].script_noteworthy == "heli_height_mesh" )
            {
                self function_d2b8ee2e1275daaf( 1 );
                waitframe();
                function_6fdde82e2cb182fe( collisioncontents, var_a4acb1826b72e655 );
                return;
            }
        }
        
        if ( self vehicle_isonground() )
        {
            return;
        }
        
        waitframe();
    }
}

// Namespace ground_drone_unit_mp
// Params 0, eflags: 0xc
// Checksum 0xfd733666, Offset: 0x1fe1
// Size: 0x7b
function private function_9a6651cd855bbc82()
{
    self notify( #"hash_ce0dc728c565a066" );
    self endon( #"hash_ce0dc728c565a066" );
    self endon( #"death" );
    level endon( #"game_ended" );
    var_39b5782a22b0ec09 = level.var_caa27c0a57e26d5c ?? 10;
    
    while ( true )
    {
        if ( self function_43f4bc8ff857e68e() > var_39b5782a22b0ec09 )
        {
            break;
        }
        
        waitframe();
    }
    
    self dodamage( self.health, self.origin );
}

// Namespace ground_drone_unit_mp
// Params 0, eflags: 0xc
// Checksum 0xc8a78ab, Offset: 0x2064
// Size: 0x71
function private function_186a91cea9c507e5()
{
    self notify( #"hash_4b0fde4fc3add213" );
    self endon( #"hash_4b0fde4fc3add213" );
    self endon( #"death" );
    function_50e5c7d94ea0a4bf();
    waitframe();
    self vehphys_impulse( ( 0, 0, 1 ), 8, 1 );
    thread weapons::watchkillbordercallback( &gdu_detonate, undefined, 0.25 );
    self setscriptablepartstate( #"initial_ground_impact", #"on", 0 );
    waitframe();
}

// Namespace ground_drone_unit_mp
// Params 6
// Checksum 0xc91d97b5, Offset: 0x20dd
// Size: 0x8c3
function function_bf849300daf6e7da( droneowner, droneownerteam, spawnpoint, streakinfo, spawndirection = undefined, spawncallback = undefined )
{
    level endon( #"hash_10fa63cc8152d54f" );
    bundle = streakinfo.bundle ?? level.streakglobals.streakbundles[ "ground_drone_unit" ];
    vehicletype = droneownerteam == "axis" ? bundle.var_35d4cc3eacf39373 : bundle.gduvehicletype;
    spawndata = { #vehicletype:vehicletype, #targetname:streakinfo.streakname, #angles:droneowner.angles ?? ( 0, 0, 0 ), #origin:spawnpoint };
    faildata = spawnstruct();
    grounddrone = vehicle_tracking::spawn_vehicle( spawndata, faildata );
    
    if ( !grounddrone )
    {
        logstring( "ground drone failed to spawn: " + faildata.fail + ", max vehicles: " + level.maxvehiclecount + ", current vehicles: " + level.vehiclecount );
        return;
    }
    
    blueprintindex = streakinfo.mpstreaksysteminfo.blueprintindex;
    
    if ( blueprintindex > 0 )
    {
        modelname = namespace_de7b719e85d98dcc::function_4854a08f7de8f427( namespace_de7b719e85d98dcc::function_9800c005d17e1d42( bundle, blueprintindex ), #"xmodel", "projModel" );
        grounddrone setmodel( modelname );
    }
    
    grounddrone.owner = droneowner;
    grounddrone.team = droneownerteam;
    
    if ( !isdefined( grounddrone.owner.var_425766479c15a2a0 ) )
    {
        grounddrone.owner.var_425766479c15a2a0 = [];
    }
    
    grounddrone.owner.var_425766479c15a2a0[ grounddrone.owner.var_425766479c15a2a0.size ] = grounddrone;
    
    if ( !isdefined( level.var_1200396612528afe[ droneownerteam ] ) )
    {
        level.var_1200396612528afe[ droneownerteam ] = ( 0, 2000, 0 );
    }
    
    if ( !grounddrone hascomponent( "p2p" ) )
    {
        grounddrone addcomponent( "p2p" );
    }
    
    if ( !grounddrone hascomponent( "path" ) )
    {
        grounddrone addcomponent( "path" );
    }
    
    grounddrone setconfigvalue( "p2p", "checkStuck", 0 );
    speedips = utility::mph_to_ips( bundle.var_2fefba772e66567f ?? 20 );
    var_87296c66fae9cc51 = getdvarfloat( @"hash_6b693b0b0753edf8", 0 );
    var_73e33013ec05cfd1 = ( var_87296c66fae9cc51 > 0 ? var_87296c66fae9cc51 : bundle.var_51b5307561dd2dc7 ) ?? 50;
    grounddrone setconfigvalue( "p2p", "brakeAtGoal", 0 );
    grounddrone setconfigvalue( "p2p", "automaticFast", 1 );
    grounddrone setconfigvalue( "p2p", "brakeOnGoalGasbrake", 0 );
    grounddrone setconfigvalue( "p2p", "brakeOnGoalGasthrottle", 0 );
    grounddrone setconfigvalue( "p2p", "goalPoint", grounddrone.origin );
    grounddrone setconfigvalue( "p2p", "goalThreshold", 30 );
    grounddrone setconfigvalue( "p2p", "throttleSpeedClose", speedips );
    grounddrone setconfigvalue( "p2p", "throttleSpeedThreshold", 2 );
    grounddrone setconfigvalue( "p2p", "automaticFastTopspeedFraction", 1 );
    grounddrone setconfigvalue( "p2p", "throttleSpeedFarBelow", speedips );
    grounddrone setconfigvalue( "p2p", "throttleSpeedFarAbove", speedips );
    grounddrone setconfigvalue( "p2p", "gasToStopMovement", 0.5 );
    grounddrone setconfigvalue( "p2p", "steeringMultiplier", 1 );
    grounddrone setconfigvalue( "p2p", "checkStuck", 1 );
    grounddrone setconfigvalue( "p2p", "stuckTime", 1 );
    grounddrone setconfigvalue( "p2p", "reverseForBehindGoal", 0 );
    grounddrone setconfigvalue( "p2p", "stuckForcedReverseTime", 1 );
    grounddrone setconfigvalue( "p2p", "reverseGasWhileStuck", 0.3 );
    grounddrone setconfigvalue( "p2p", "stuckDistanceThreshold", 5 );
    grounddrone setconfigvalue( "p2p", "manualSpeed", speedips );
    grounddrone setconfigvalue( "path", "radiusToStep", var_73e33013ec05cfd1 );
    grounddrone setconfigvalue( "path", "warpOnStart", 0 );
    grounddrone setconfigvalue( "path", "useManualSpeed", 1 );
    grounddrone setconfigvalue( "path", "instantaneousSpeed", speedips );
    grounddrone.streakname = "ground_drone_unit";
    grounddrone.streakinfo = streakinfo;
    grounddrone.bundle = bundle;
    grounddrone.bundlename = getxhashasset( "vehiclebundle:" + bundle.deployedvehiclebundle );
    grounddrone.maxhealth = grounddrone.health;
    grounddrone.currenthealth = grounddrone.health;
    grounddrone.var_bdc51be80cbeef82 = bundle.var_bdc51be80cbeef82;
    
    if ( isplayer( droneowner ) )
    {
        grounddrone setotherent( droneowner );
    }
    
    grounddrone setvehicleteam( grounddrone.team );
    grounddrone.headiconid = entityheadicons::setheadicon_killstreak( grounddrone );
    grounddrone.isgdu = 1;
    
    if ( utility::issharedfuncdefined( #"killstreak", #"addtoactivekillstreaklist" ) )
    {
        grounddrone [[ utility::getsharedfunc( #"killstreak", #"addtoactivekillstreaklist" ) ]]( streakinfo.streakname, "Killstreak_Ground", droneowner );
    }
    
    grounddrone setscriptablepartstate( #"lights", #"on" );
    grounddrone setscriptablepartstate( #"alert", #"off" );
    grounddrone sentientpoolmanager::registersentient( "Killstreak_Ground", droneowner, 1 );
    grounddrone endon( #"death" );
    grounddrone vehicle_damage::set_can_damage( 1 );
    grounddrone gdu_setupdamagefunctionality( "ground_drone_unit" );
    
    if ( grounddrone function_d8b2dc2e45832e08() )
    {
        grounddrone emp_debuff::set_apply_emp_callback( &function_826442bbaa8f5014 );
        emp_debuff::add_emp_ent( grounddrone );
        grounddrone emp_debuff::set_clear_emp_callback( &function_7f549080b33876c5 );
    }
    
    utility::callsharedfunc( #"jamming_system", #"hash_b99e77a93a09b9d5", grounddrone, &function_a538def00b0ed0f5, &function_7b021058875d4499 );
    grounddrone thread function_9a6651cd855bbc82();
    grounddrone thread function_186a91cea9c507e5();
    grounddrone thread weapons::watchkillbordercallback( &gdu_detonate );
    grounddrone thread function_254c4ad11edac24a( grounddrone );
    
    if ( isdefined( spawndirection ) )
    {
        grounddrone vehphys_impulse( spawndirection, 15, 1 );
    }
    else
    {
        wait 2;
    }
    
    grounddrone.followplayer = istrue( bundle.gdufollowplayer );
    
    if ( grounddrone.followplayer )
    {
        grounddrone.followdistance = bundle.var_fe7cee64db121902 ?? 1500;
    }
    
    if ( spawnlogic::function_1f5152a92aada360( #"start" ) )
    {
        grounddrone.destination = grounddrone function_ca82d35e08de257d();
    }
    else
    {
        grounddrone.destination = grounddrone function_4ba1b4809ac8b9ed();
    }
    
    if ( isfunction( spawncallback ) )
    {
        self [[ spawncallback ]]( grounddrone );
    }
    
    /#
        if ( droneowner && droneowner.var_364c87df61679b25 )
        {
            droneowner usevehicle( grounddrone, 0 );
            grounddrone thread function_2f96a9b1ab4a18df( droneowner );
        }
    #/
    
    wait bundle.gduactivationdelay ?? 1;
    
    /#
        if ( getdvarint( @"hash_22473e6f3d6e4627", 0 ) )
        {
            level.debug_gdus[ level.debug_gdus.size ] = grounddrone;
            grounddrone thread function_7cca71da389c78a4();
            return grounddrone;
        }
    #/
    
    gdutimeout = bundle.gdutimeout ?? 60;
    grounddrone.lifetimeendtime = int( gdutimeout * 1000 + gettime() );
    
    /#
        var_ae24eaad32921ae2 = getdvarint( @"hash_2c01d701bac5d9d3", 0 );
        
        if ( var_ae24eaad32921ae2 )
        {
            gdutimeout = 9999;
        }
    #/
    
    grounddrone thread function_7d57c966c9a886e4( gdutimeout );
    grounddrone function_76e96222a80ccc76();
    
    if ( level.var_36218e71baa7e689 )
    {
        grounddrone.var_c5ccf9dff3b5e393 = &function_f6453b7afec7b864;
    }
    
    if ( level.var_36218e71baa7e689 )
    {
        level.var_89fe7f9fa2bc945d[ level.var_89fe7f9fa2bc945d.size ] = grounddrone;
    }
    
    return grounddrone;
}

// Namespace ground_drone_unit_mp
// Params 1, eflags: 0x4
// Checksum 0xa911f7, Offset: 0x29a9
// Size: 0x29
function private function_2f96a9b1ab4a18df( droneowner )
{
    droneowner waittill( #"gdu_detonate" );
    droneowner leavevehicle( 0 );
    thread gdu_detonate();
}

// Namespace ground_drone_unit_mp
// Params 0, eflags: 0xc
// Checksum 0xe635867, Offset: 0x29da
// Size: 0xff
function private function_76e96222a80ccc76()
{
    self notify( #"hash_77bc7025b0fff1f8" );
    self endon( #"hash_77bc7025b0fff1f8" );
    grounddrone = self;
    
    if ( grounddrone.var_7568cab78e4268cc )
    {
        grounddrone childthread function_87261db8e25f5017();
        grounddrone childthread function_7d4d398bc51aeb03();
        grounddrone childthread function_83f8cf1b706c6934();
        return;
    }
    
    if ( !grounddrone.streakinfo.var_4f800172deb23070 )
    {
        grounddrone childthread function_e170b7e897daad61();
    }
    
    if ( grounddrone.streakinfo.bundle.var_2af264dd2ac22ff0 )
    {
        grounddrone childthread function_ab24b20cc19e04ca();
    }
    
    grounddrone.usecatmullrom = 1;
    grounddrone childthread gdu_navigate();
    grounddrone childthread function_e320e54c0e95e1b0();
    grounddrone childthread vehicle_roads::watch_stuck();
    grounddrone childthread vehicle_roads::watch_interrupt();
    grounddrone childthread function_1fe906c78aa93cd2();
    wait 2;
    
    if ( grounddrone )
    {
        grounddrone childthread function_7d4d398bc51aeb03();
        grounddrone childthread function_83f8cf1b706c6934();
        grounddrone childthread function_87261db8e25f5017();
    }
}

// Namespace ground_drone_unit_mp
// Params 0, eflags: 0x4
// Checksum 0x2530d3fd, Offset: 0x2ae1
// Size: 0x1a, Type: bool
function private function_d8b2dc2e45832e08()
{
    return self.bundle.var_c75ccc6a310cd2e3 ?? 1;
}

// Namespace ground_drone_unit_mp
// Params 1, eflags: 0x4
// Checksum 0x3e932c9, Offset: 0x2b04
// Size: 0x76
function private function_2319fda353595bc0( jammedgdu )
{
    jammedgdu endon( #"death" );
    
    if ( jammedgdu.var_7568cab78e4268cc )
    {
        jammedgdu notify( #"emp_gdu" );
        jammedgdu setscriptablepartstate( "emp", "on", 0 );
        jammedgdu function_eb88c4e66edbc855( "p2p", "manualSpeed", 0 );
        return;
    }
    
    jammedgdu function_76e96222a80ccc76();
    jammedgdu setscriptablepartstate( "emp", "off", 0 );
}

// Namespace ground_drone_unit_mp
// Params 1, eflags: 0x4
// Checksum 0x72923b06, Offset: 0x2b82
// Size: 0x3d
function private function_a538def00b0ed0f5( jammedgdu )
{
    if ( !isdefined( jammedgdu.var_7568cab78e4268cc ) )
    {
        jammedgdu.var_7568cab78e4268cc = 0;
    }
    
    jammedgdu.var_7568cab78e4268cc++;
    jammedgdu thread function_2319fda353595bc0( jammedgdu );
}

// Namespace ground_drone_unit_mp
// Params 1, eflags: 0x4
// Checksum 0xd25b9e0a, Offset: 0x2bc7
// Size: 0x22
function private function_7b021058875d4499( jammedgdu )
{
    jammedgdu.var_7568cab78e4268cc--;
    jammedgdu thread function_2319fda353595bc0( jammedgdu );
}

// Namespace ground_drone_unit_mp
// Params 1, eflags: 0x4
// Checksum 0xb28772a8, Offset: 0x2bf1
// Size: 0x51
function private function_826442bbaa8f5014( data )
{
    grounddrone = self;
    
    if ( !grounddrone )
    {
        return;
    }
    
    grounddrone notify( #"emp_gdu" );
    grounddrone setscriptablepartstate( "emp", "on", 0 );
    grounddrone function_eb88c4e66edbc855( "p2p", "manualSpeed", 0 );
}

// Namespace ground_drone_unit_mp
// Params 1, eflags: 0x4
// Checksum 0x5d2e6bd6, Offset: 0x2c4a
// Size: 0x4c
function private function_7f549080b33876c5( data )
{
    grounddrone = self;
    
    if ( !grounddrone )
    {
        return;
    }
    
    grounddrone function_76e96222a80ccc76();
    
    if ( !grounddrone )
    {
        return;
    }
    
    grounddrone setscriptablepartstate( "emp", "off", 0 );
    grounddrone thread function_2319fda353595bc0( grounddrone );
}

// Namespace ground_drone_unit_mp
// Params 0, eflags: 0x4
// Checksum 0x6da794f2, Offset: 0x2c9e
// Size: 0xa7
function private function_77b5789eb99c0300()
{
    grounddrone = self;
    collisioncontents = physics_createcontents( [ "physicscontents_missileclip" ] );
    
    for ( i = 0; i < 30 ; i++ )
    {
        hitents = physics_raycast( grounddrone.origin, grounddrone.origin - ( 0, 0, 10 ), collisioncontents, undefined, 0, "physicsquery_all" );
        
        if ( hitents.size > 0 )
        {
            /#
                if ( getdvarint( @"scr_ground_drone_unit_debug_text" ) )
                {
                    iprintln( "<dev string:x76>" );
                }
            #/
            
            return;
        }
        
        wait 0.1;
    }
}

// Namespace ground_drone_unit_mp
// Params 0, eflags: 0xc
// Checksum 0x24ae5fb3, Offset: 0x2d4d
// Size: 0xf8
function private function_8e9d635ea70fb7a3()
{
    self notify( #"hash_a3ba000f460ca081" );
    self endon( #"hash_a3ba000f460ca081" );
    self endon( #"death", #"emp_gdu", #"hash_b15a39d4ac9b1720" );
    grounddrone = self;
    var_d7725c32c8d0a617 = 500;
    
    if ( grounddrone.followplayer )
    {
        var_d7725c32c8d0a617 = grounddrone.followdistance / 2;
    }
    
    if ( self.var_c27afbd9fa0dce21 )
    {
        var_d7725c32c8d0a617 = 75;
    }
    
    var_d74d70f7538e160c = var_d7725c32c8d0a617 * var_d7725c32c8d0a617;
    
    while ( grounddrone )
    {
        if ( !isdefined( grounddrone.destination ) || distancesquared( grounddrone.origin, grounddrone.destination ) < var_d74d70f7538e160c )
        {
            if ( self.forced_destination && self.var_c27afbd9fa0dce21 )
            {
                grounddrone thread gdu_detonate();
                return;
            }
            
            grounddrone notify( #"find_new_path" );
        }
        
        waitframe();
    }
}

// Namespace ground_drone_unit_mp
// Params 0, eflags: 0xc
// Checksum 0xbbaf5a90, Offset: 0x2e4d
// Size: 0x15a
function private gdu_navigate()
{
    self notify( #"hash_7082e53be47c112c" );
    self endon( #"hash_7082e53be47c112c" );
    self endon( #"death", #"emp_gdu", #"hash_b15a39d4ac9b1720" );
    grounddrone = self;
    grounddrone function_6a6d9e5ce7a3921c();
    
    /#
        if ( getdvarint( @"hash_22473e6f3d6e4627", 0 ) )
        {
            while ( distance( grounddrone.origin, grounddrone.forced_destination ) > 100 )
            {
                waitframe();
            }
            
            grounddrone.forced_destination = undefined;
        }
    #/
    
    grounddrone thread function_8e9d635ea70fb7a3();
    
    /#
        grounddrone thread function_39f8b6f3f23fbd0c();
    #/
    
    while ( true )
    {
        result = grounddrone utility::waittill_any_timeout( 60, "found_target", "find_new_path", "reload_path" );
        
        if ( result == "find_new_path" )
        {
            grounddrone.destination = grounddrone function_ca82d35e08de257d();
            grounddrone setscriptablepartstate( #"scanner", #"on" );
            
            /#
                if ( getdvarint( @"scr_ground_drone_unit_debug_text" ) )
                {
                    iprintln( "<dev string:x8b>" );
                }
            #/
        }
        else if ( result == "reload_path" )
        {
            /#
                if ( getdvarint( @"scr_ground_drone_unit_debug_text" ) )
                {
                    iprintln( "<dev string:xb7>" );
                }
            #/
        }
        
        grounddrone function_6a6d9e5ce7a3921c();
    }
}

/#

    // Namespace ground_drone_unit_mp
    // Params 0, eflags: 0xc
    // Checksum 0xc2b4aced, Offset: 0x2faf
    // Size: 0xdc, Type: dev
    function private function_39f8b6f3f23fbd0c()
    {
        self notify( #"hash_e0b424e9633c14a1" );
        self endon( #"hash_e0b424e9633c14a1" );
        grounddrone = self;
        grounddrone endon( #"death" );
        period = level.framedurationseconds;
        
        while ( true )
        {
            if ( getdvarint( @"hash_4ef35e7fc05acb67" ) && grounddrone.destination )
            {
                level thread debug::drawline( grounddrone.origin, grounddrone.destination, period, ( 1, 0, 0 ) );
                level thread debug::drawline( grounddrone.destination, grounddrone.destination + ( 0, 0, 1000 ), period, ( 1, 0, 0 ) );
            }
            
            wait period;
        }
    }

#/

// Namespace ground_drone_unit_mp
// Params 0, eflags: 0x4
// Checksum 0x937d2b06, Offset: 0x3093
// Size: 0x2e3
function private function_f59fb735f7f950ec()
{
    gdu = self;
    
    if ( gdu.owner.var_7197c4b3db0665fe )
    {
        gdu gdu_clearcurrenttarget();
        return;
    }
    
    if ( isalive( gdu.currenttarget ) )
    {
        return gdu.currenttarget;
    }
    
    if ( isstruct( gdu.owner ) )
    {
        besttarget = { #origin:gdu.owner.origin };
    }
    else
    {
        var_90dba5da64aa1c79 = utility::callsharedfunc( #"gdu", #"hash_bd7316aff22a0e6d" );
        
        if ( var_90dba5da64aa1c79 && isvector( var_90dba5da64aa1c79.origin ) )
        {
            besttarget = var_90dba5da64aa1c79;
        }
        else if ( self.owner )
        {
            if ( spawnlogic::function_1f5152a92aada360( #"start" ) )
            {
                if ( !isdefined( level.gduteams ) )
                {
                    level.gduteams = [ self.team, team_utility::getotherteam( self.team ) ];
                }
                
                targetteam = utility::array_random( level.gduteams );
                spawn_points = self.owner spawnlogic::function_f89ebff0bfb8555( #"start", targetteam );
                besttarget = spawn_points[ randomintrange( 0, spawn_points.size ) ];
            }
            else
            {
                besttarget = self.owner getspawnpointforplayer();
            }
        }
    }
    
    if ( besttarget )
    {
        besttarget.gducounter = 0;
    }
    
    currenttime = gettime();
    
    foreach ( player in teams::getenemyplayers( gdu.team, 1 ) )
    {
        if ( !isdefined( player.gducounter ) )
        {
            player.gducounter = 0;
        }
        
        if ( level.var_86587f097a6ea895 && isdefined( player.var_e5002d881897ae07[ gdu.entnum ?? utility::get_entity_number( gdu ) ] ) && currenttime < player.var_e5002d881897ae07[ gdu.entnum ?? utility::get_entity_number( gdu ) ] )
        {
            continue;
        }
        
        if ( !isdefined( player.perks[ "specialty_blindeye" ] ) && ( isstruct( besttarget ) || player.gducounter < besttarget.gducounter ) )
        {
            besttarget = player;
        }
    }
    
    if ( !besttarget )
    {
        return;
    }
    
    besttarget.gducounter++;
    return besttarget;
}

// Namespace ground_drone_unit_mp
// Params 0, eflags: 0x4
// Checksum 0xe5e06ffe, Offset: 0x337f
// Size: 0x15a
function private function_4ba1b4809ac8b9ed()
{
    if ( self.forced_destination )
    {
        self.destination = getclosestpointonnavmesh( self.forced_destination );
        return;
    }
    
    level.var_1200396612528afe[ self.team ] = rotatevector( level.var_1200396612528afe[ self.team ], vectortoangles( ( 0, randomintrange( 45, 270 ), 0 ) ) );
    var_c752d3f388f9b70a = squared( 2000 );
    
    if ( self.owner && self.followplayer )
    {
        return getclosestpointonnavmesh( self.owner.origin + vectornormalize( level.var_1200396612528afe[ self.team ] ) * self.followdistance );
    }
    
    if ( isdefined( level.mapcenter ) && distancesquared( self.origin, level.mapcenter + level.var_1200396612528afe[ self.team ] ) < var_c752d3f388f9b70a )
    {
        return getclosestpointonnavmesh( level.mapcenter + level.var_1200396612528afe[ self.team ] );
    }
    
    center = self.origin;
    return getclosestpointonnavmesh( center + level.var_1200396612528afe[ self.team ] );
}

// Namespace ground_drone_unit_mp
// Params 0, eflags: 0x4
// Checksum 0x1e356191, Offset: 0x34e1
// Size: 0x1f
function private function_ca82d35e08de257d()
{
    besttarget = function_f59fb735f7f950ec();
    return besttarget.origin;
}

// Namespace ground_drone_unit_mp
// Params 2, eflags: 0x4
// Checksum 0x574bb2ee, Offset: 0x3509
// Size: 0x2b
function private function_b4c9a325bde27872( destination, var_86e6773dafc61be1 )
{
    self.forced_destination = destination;
    self.var_c27afbd9fa0dce21 = var_86e6773dafc61be1;
}

// Namespace ground_drone_unit_mp
// Params 0, eflags: 0xc
// Checksum 0xb1e8cb83, Offset: 0x353c
// Size: 0x439
function private function_6a6d9e5ce7a3921c()
{
    self notify( #"hash_c2edb921a0dce729" );
    self endon( #"hash_c2edb921a0dce729" );
    
    if ( self.forced_destination )
    {
        self.destination = self.forced_destination;
    }
    
    if ( !self.destination )
    {
        return;
    }
    
    pointspacing = 50;
    disttodest = distance( self.origin, self.destination );
    
    if ( disttodest < 500 )
    {
        pointspacing = disttodest / 10;
    }
    else if ( disttodest > 14000 )
    {
        self.destination = self.origin + vectornormalize( self.destination - self.origin ) * 14000 * 0.5;
        destinationclamped = 1;
    }
    
    var_6ba7397cdf0f5a11 = self.streakinfo.var_2cf65238266c20bc ?? 200;
    var_18ed0377b06bf7cf = self.streakinfo.var_b60175dee49da226 ?? 200;
    forwardvector = anglestoforward( self.angles );
    startpos = getclosestpointonnavmesh( self.origin );
    endpos = getclosestpointonnavmesh( self.destination );
    var_ad73dc98288cbce5 = distance( startpos, endpos );
    function_1d44f32bbd313a67( #"hash_ac18453e4d3816d5", var_ad73dc98288cbce5 );
    usecatmullrom = self.usecatmullrom ? 2 : 1;
    lookaheadoffset = 100;
    var_c1c33da0718576c1 = 0.25;
    splinepoints = self findsplinepath( startpos, endpos, var_6ba7397cdf0f5a11, var_18ed0377b06bf7cf, pointspacing, forwardvector, ( 0, 0, 0 ), lookaheadoffset, var_c1c33da0718576c1, 0, "small_veh_jump", undefined, 0, usecatmullrom );
    
    if ( level.var_86587f097a6ea895 && !destinationclamped && splinepoints.size > 0 && self.var_f16b9b9de1c8214c )
    {
        finalnode = splinepoints[ splinepoints.size - 1 ];
        
        if ( distancesquared( finalnode, endpos ) > 3600 )
        {
            if ( isdefined( self.currenttarget ) )
            {
                if ( !isdefined( self.currenttarget.var_e5002d881897ae07 ) )
                {
                    self.currenttarget.var_e5002d881897ae07 = [];
                }
                
                self.currenttarget.var_e5002d881897ae07[ self.entnum ?? utility::get_entity_number( self ) ] = gettime() + 5000;
            }
            
            gdu_clearcurrenttarget();
            
            /#
                if ( getdvarint( @"scr_ground_drone_unit_debug_text" ) )
                {
                    iprintln( "<dev string:xd7>" );
                }
            #/
            
            self notify( #"find_new_path" );
            return;
        }
    }
    
    speedmph = isdefined( self.var_f16b9b9de1c8214c ) || level.gdu_boost_debug ? self.bundle.var_e6c9119eb92a8a4b ?? 40 : self.bundle.var_2fefba772e66567f ?? 20;
    speedips = utility::mph_to_ips( speedmph );
    
    if ( usecatmullrom == 2 && isdefined( splinepoints ) && splinepoints.size > 4 )
    {
        if ( splinepoints.size >= 48 )
        {
            splinepoints = utility::array_slice( splinepoints, 0, 47 );
        }
        
        var_f2031896fbadeb97 = function_4c272d7ad789a554( splinepoints, speedips );
        
        if ( isdefined( splinepoints ) && isdefined( var_f2031896fbadeb97 ) )
        {
            splineid = function_53253e8ea222ed60( splinepoints, var_f2031896fbadeb97 );
            self setconfigvalue( "path", "catmullRomId", splineid );
            self.destination = splinepoints[ splinepoints.size - 1 ];
        }
    }
    
    self setconfigvalue( "p2p", "manualSpeed", speedips );
    self setconfigvalue( "p2p", "throttleSpeedFarBelow", speedips );
    self setconfigvalue( "p2p", "throttleSpeedFarAbove", speedips );
    self setconfigvalue( "p2p", "throttleSpeedClose", speedips );
    self setconfigvalue( "path", "instantaneousSpeed", speedips );
    
    /#
        if ( isdefined( splinepoints ) )
        {
            if ( getdvarint( @"hash_6df02de63de0987b" ) )
            {
                thread vehicle_roads::function_2b723e6a5a86a006( splinepoints, ( 1, 0, 0 ) );
            }
        }
    #/
}

// Namespace ground_drone_unit_mp
// Params 0, eflags: 0x4
// Checksum 0xb12f29bf, Offset: 0x397d
// Size: 0xd6
function private gdu_clearcurrenttarget()
{
    if ( isdefined( self.currenttarget ) )
    {
        self.currenttarget.gdutarget = undefined;
    }
    
    self.currenttarget = undefined;
    self.var_f16b9b9de1c8214c = undefined;
    self.lastupdate = undefined;
    self.var_43cba94fa35c4a4c = undefined;
    self.var_fd50365c07ed7af2 = undefined;
    self.destination = undefined;
    self setscriptablepartstate( #"lights", #"on" );
    self setscriptablepartstate( #"alert", #"off" );
    self setscriptablepartstate( #"locked_on", #"off" );
    self setscriptablepartstate( #"hash_8bbd1e9dfde216e8", #"off" );
    self setscriptablepartstate( #"scanner", #"on" );
}

// Namespace ground_drone_unit_mp
// Params 3, eflags: 0x4
// Checksum 0x941c6c22, Offset: 0x3a5b
// Size: 0x53
function private function_298b7fc17047443e( startpos, endpos, speed )
{
    segmentlength = distance( startpos, endpos );
    moverate = segmentlength / speed;
    
    if ( moverate < 0.05 )
    {
        moverate = 0.05;
    }
    
    return moverate;
}

// Namespace ground_drone_unit_mp
// Params 2, eflags: 0x4
// Checksum 0xc5247de2, Offset: 0x3ab7
// Size: 0x94
function private function_4c272d7ad789a554( splinepoints, speedips )
{
    durations = [];
    assert( splinepoints.size < 48 );
    
    if ( splinepoints.size >= 2 )
    {
        for ( index = 0; index < splinepoints.size - 1 ; index++ )
        {
            currentpoint = splinepoints[ index ];
            nextpoint = splinepoints[ index + 1 ];
            durations[ durations.size ] = function_298b7fc17047443e( currentpoint, nextpoint, speedips );
        }
        
        durations[ durations.size ] = durations[ durations.size - 1 ];
    }
    
    return durations;
}

// Namespace ground_drone_unit_mp
// Params 1, eflags: 0x4
// Checksum 0x9e72bc4, Offset: 0x3b54
// Size: 0x5b0
function private function_cda8373b1f520a14( potentialtarget )
{
    grounddrone = self;
    detonationdistance = grounddrone.bundle.var_98cfa0c586dbacda ?? 200;
    var_978831c6cc85ec35 = squared( detonationdistance );
    
    if ( isdefined( potentialtarget ) )
    {
        if ( distancesquared( potentialtarget.origin, grounddrone.origin ) < var_978831c6cc85ec35 )
        {
            grounddrone thread gdu_detonate();
            return;
        }
        
        if ( isdefined( potentialtarget.gdutarget ) && potentialtarget.gdutarget != grounddrone )
        {
            if ( distancesquared( grounddrone.origin, potentialtarget.origin ) >= distancesquared( potentialtarget.gdutarget.origin, potentialtarget.origin ) )
            {
                potentialtarget.gdutarget.currenttarget = undefined;
                potentialtarget.gdutarget = grounddrone;
            }
            else
            {
                return;
            }
        }
        
        if ( isdefined( grounddrone.currenttarget ) && potentialtarget != grounddrone.currenttarget )
        {
            grounddrone.lastupdate = undefined;
            grounddrone.currenttarget.gdutarget = undefined;
            grounddrone.var_43cba94fa35c4a4c = undefined;
            grounddrone.var_fd50365c07ed7af2 = undefined;
            grounddrone setscriptablepartstate( #"scanner", #"on" );
            grounddrone setscriptablepartstate( #"hash_8bbd1e9dfde216e8", #"off" );
        }
        
        grounddrone.currenttarget = potentialtarget;
        grounddrone.currenttarget.gdutarget = grounddrone;
        bundle = grounddrone.bundle;
        var_2b53f65a1e09bc71 = bundle.var_608510bebd3304c7 ?? 500;
        var_27357b66438184f2 = squared( var_2b53f65a1e09bc71 );
        
        if ( !grounddrone.var_fd50365c07ed7af2 && distancesquared( grounddrone.origin, potentialtarget.origin ) < var_27357b66438184f2 )
        {
            grounddrone.var_fd50365c07ed7af2 = 1;
            
            if ( !grounddrone.var_43cba94fa35c4a4c )
            {
                grounddrone.var_43cba94fa35c4a4c = 1;
                
                if ( isdefined( bundle.var_fc29393dd6a75899 ) && isplayer( grounddrone.currenttarget ) )
                {
                    grounddrone playsoundtoplayer( bundle.var_fc29393dd6a75899, grounddrone.currenttarget );
                    grounddrone setscriptablepartstate( #"locked_on", #"on" );
                    grounddrone setscriptablepartstate( #"hash_8bbd1e9dfde216e8", #"on" );
                    grounddrone setscriptablepartstate( #"scanner", #"off" );
                }
            }
            
            if ( isdefined( bundle.var_80ac010543fb1314 ) )
            {
                if ( isplayer( grounddrone.currenttarget ) )
                {
                    grounddrone playsoundtoplayer( bundle.var_80ac010543fb1314, grounddrone.currenttarget );
                }
                else if ( grounddrone.currenttarget vehicle::is_vehicle() )
                {
                    occupants = vehicle_occupancy::get_all_occupants( grounddrone.currenttarget );
                    
                    foreach ( occupant in occupants )
                    {
                        grounddrone playsoundtoplayer( bundle.var_80ac010543fb1314, occupant );
                    }
                }
            }
        }
        
        grounddrone.var_f16b9b9de1c8214c = grounddrone.currenttarget.origin;
        
        /#
            if ( getdvarint( @"scr_ground_drone_unit_debug_text" ) )
            {
                iprintln( "<dev string:x118>" );
            }
        #/
        
        grounddrone setscriptablepartstate( #"lights", #"off" );
        grounddrone setscriptablepartstate( #"alert", #"on" );
        
        if ( !grounddrone.isjumping && distance( grounddrone.origin, grounddrone.currenttarget.origin ) < detonationdistance * 1.5 )
        {
            var_ed900f3828515217 = vectornormalize( grounddrone.currenttarget.origin - grounddrone.origin ) + ( 0, 0, 0.66 );
            grounddrone thread gdu_jump( var_ed900f3828515217, 15, 1 );
        }
        
        currenttime = gettime();
        
        if ( !isdefined( grounddrone.lastupdate ) )
        {
            grounddrone.lastupdate = currenttime;
            grounddrone notify( #"found_target" );
        }
        
        if ( isdefined( grounddrone.lastupdate ) && currenttime - grounddrone.lastupdate > 500 )
        {
            grounddrone.lastupdate = undefined;
            grounddrone setscriptablepartstate( #"hash_8bbd1e9dfde216e8", #"off" );
        }
        
        return;
    }
    
    if ( isdefined( grounddrone.var_f16b9b9de1c8214c ) && ( distance( grounddrone.origin, grounddrone.var_f16b9b9de1c8214c ) < detonationdistance || !isalive( grounddrone.currenttarget ) ) )
    {
        grounddrone gdu_clearcurrenttarget();
        
        /#
            if ( getdvarint( @"scr_ground_drone_unit_debug_text" ) )
            {
                iprintln( "<dev string:x138>" );
            }
        #/
    }
}

// Namespace ground_drone_unit_mp
// Params 3, eflags: 0xc
// Checksum 0xfb9cd2a7, Offset: 0x410c
// Size: 0xab
function private gdu_jump( direction, force, usevfx )
{
    self notify( #"hash_3968d1c68d157e08" );
    self endon( #"hash_3968d1c68d157e08" );
    self endon( #"death" );
    self vehphys_impulse( direction, force, 1 );
    self.isjumping = 1;
    
    if ( usevfx )
    {
        self setscriptablepartstate( #"jump", #"on" );
    }
    
    wait 1;
    
    if ( isdefined( self ) )
    {
        self.isjumping = 0;
        self setscriptablepartstate( #"jump", #"off" );
    }
    
    self notify( #"reload_path" );
}

// Namespace ground_drone_unit_mp
// Params 1, eflags: 0x4
// Checksum 0xe2984a05, Offset: 0x41bf
// Size: 0x211, Type: bool
function private gdu_cantarget( ent )
{
    grounddrone = self;
    
    if ( grounddrone.owner.var_7197c4b3db0665fe )
    {
        return false;
    }
    
    if ( !isdefined( ent ) )
    {
        /#
            if ( getdvarint( @"scr_ground_drone_unit_debug_text" ) )
            {
                iprintln( "<dev string:x155>" + ent getentitynumber() + "<dev string:x15e>" );
            }
        #/
        
        return false;
    }
    
    if ( ent == self )
    {
        /#
            if ( getdvarint( @"scr_ground_drone_unit_debug_text" ) )
            {
                iprintln( "<dev string:x155>" + ent getentitynumber() + "<dev string:x16c>" );
            }
        #/
        
        return false;
    }
    
    if ( !isdefined( ent.team ) || ent.team == grounddrone.team )
    {
        return false;
    }
    
    if ( isdefined( grounddrone.var_5800352c39c9d945 ) && grounddrone.var_5800352c39c9d945 != ent.team )
    {
        return false;
    }
    
    if ( isdefined( ent.perks[ "specialty_blindeye" ] ) )
    {
        return false;
    }
    
    if ( ent isscriptable() && ent getscriptablepartstate( "active_camo_fx", 1 ) == #"super_fx_on" )
    {
        return false;
    }
    
    if ( isdefined( ent.gdutarget ) && ent.gdutarget != grounddrone && distancesquared( grounddrone.origin, ent.origin ) >= distancesquared( ent.gdutarget.origin, ent.origin ) )
    {
        return false;
    }
    
    if ( ent.bundle.var_abe63dfc8bf52329 )
    {
        return false;
    }
    
    if ( level.var_86587f097a6ea895 && isdefined( ent.var_e5002d881897ae07[ grounddrone.entnum ?? utility::get_entity_number( grounddrone ) ] ) && gettime() < ent.var_e5002d881897ae07[ grounddrone.entnum ?? utility::get_entity_number( grounddrone ) ] )
    {
        return false;
    }
    
    return true;
}

// Namespace ground_drone_unit_mp
// Params 0, eflags: 0xc
// Checksum 0x4a6a36a7, Offset: 0x43d9
// Size: 0x1e9
function private function_e170b7e897daad61()
{
    self notify( #"hash_3f91aba1fbcd0ea" );
    self endon( #"hash_3f91aba1fbcd0ea" );
    grounddrone = self;
    grounddrone endon( #"death", #"emp_gdu", #"hash_b15a39d4ac9b1720" );
    playersearchradius = grounddrone.bundle.var_78690c4249aff10f ?? 2500;
    detonationradius = grounddrone.bundle.var_98cfa0c586dbacda ?? 200;
    var_cca72e710d69f47d = detonationradius * detonationradius;
    assert( playersearchradius > detonationradius );
    
    while ( true )
    {
        if ( !isdefined( grounddrone ) )
        {
            return;
        }
        
        throttle::throttle_wait_in_queue( level.var_cf1a19e5b5e12970, grounddrone );
        var_4e82d0cafb625933 = 0;
        besttarget = undefined;
        players = getplayersinradius( grounddrone.origin, playersearchradius );
        
        foreach ( player in players )
        {
            if ( !isalive( player ) || !gdu_cantarget( player ) )
            {
                continue;
            }
            
            distancesq = distancesquared( player.origin, grounddrone.origin );
            
            if ( distancesq < var_cca72e710d69f47d )
            {
                grounddrone thread gdu_detonate();
                return;
            }
            
            if ( !besttarget || distancesq < var_4e82d0cafb625933 )
            {
                var_4e82d0cafb625933 = distancesq;
                besttarget = player;
            }
        }
        
        if ( isdefined( besttarget ) || isdefined( grounddrone.var_f16b9b9de1c8214c ) )
        {
            grounddrone function_cda8373b1f520a14( besttarget );
        }
        
        waitframe();
    }
}

// Namespace ground_drone_unit_mp
// Params 0, eflags: 0xc
// Checksum 0xfdd55cd8, Offset: 0x45ca
// Size: 0x27d
function private function_ab24b20cc19e04ca()
{
    self notify( #"hash_480c24c84e758166" );
    self endon( #"hash_480c24c84e758166" );
    self endon( #"death", #"emp_gdu", #"hash_b15a39d4ac9b1720" );
    grounddrone = self;
    playersearchradius = grounddrone.bundle.var_78690c4249aff10f ?? 2500;
    var_850852de1c360389 = squared( playersearchradius );
    detonationradius = grounddrone.bundle.var_98cfa0c586dbacda ?? 200;
    var_cca72e710d69f47d = squared( detonationradius );
    assert( var_850852de1c360389 > var_cca72e710d69f47d );
    
    while ( true )
    {
        throttle::throttle_wait_in_queue( level.var_cf1a19e5b5e12970, self );
        potentialtarget = undefined;
        aisarray = getaiarrayinradius( self.origin, playersearchradius );
        
        if ( utility::issharedfuncdefined( #"zm", #"hash_275603844e04e7ac" ) )
        {
            if ( self.owner )
            {
                aisarray = level [[ utility::getsharedfunc( #"zm", #"hash_275603844e04e7ac" ) ]]( aisarray, self.owner );
            }
        }
        
        foreach ( ai in aisarray )
        {
            var_6807b2ee4d1ea246 = distancesquared( ai.origin, grounddrone.origin );
            
            if ( var_6807b2ee4d1ea246 > var_850852de1c360389 )
            {
                continue;
            }
            
            if ( !gdu_cantarget( ai ) )
            {
                continue;
            }
            
            if ( var_6807b2ee4d1ea246 < var_cca72e710d69f47d )
            {
                grounddrone thread gdu_detonate( grounddrone.bundle.gduexplosionradius ?? 225, grounddrone.bundle.var_f30f65c68e7d34ec ?? 500 );
                return;
            }
            
            if ( !isdefined( potentialtarget ) || var_6807b2ee4d1ea246 < distancesquared( potentialtarget.origin, grounddrone.origin ) )
            {
                potentialtarget = ai;
            }
        }
        
        if ( isdefined( potentialtarget ) || isdefined( grounddrone.var_f16b9b9de1c8214c ) )
        {
            grounddrone function_cda8373b1f520a14( potentialtarget );
        }
        
        waitframe();
    }
}

// Namespace ground_drone_unit_mp
// Params 1, eflags: 0x4
// Checksum 0xe73746eb, Offset: 0x484f
// Size: 0x46
function private function_f6453b7afec7b864( data )
{
    data.attacker thread points::doscoreevent( #"hash_731419bf767945ec", data.objweapon, undefined, undefined, data.victim );
    gdu_detonate();
}

// Namespace ground_drone_unit_mp
// Params 1, eflags: 0x4
// Checksum 0xdc0d9650, Offset: 0x489d
// Size: 0x7e
function private function_5518ee0639d4515b( data )
{
    data.attacker thread points::doscoreevent( #"hash_731419bf767945ec", data.objweapon, undefined, undefined, data.victim );
    
    if ( self.var_5f8ae329b421d7d1 )
    {
        utility::callsharedfunc( #"game", #"returnobjectiveid", self.var_5f8ae329b421d7d1 );
        self.var_5f8ae329b421d7d1 = undefined;
    }
    
    function_49878dcffc3897d3();
}

// Namespace ground_drone_unit_mp
// Params 0, eflags: 0x4
// Checksum 0xebc0855, Offset: 0x4923
// Size: 0x2b
function private function_49878dcffc3897d3()
{
    self setscriptablepartstate( #"explode", #"on" );
    wait 0.1;
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace ground_drone_unit_mp
// Params 2, eflags: 0xc
// Checksum 0x608c88fa, Offset: 0x4956
// Size: 0x1a4
function private gdu_detonate( explosionradius, explosiondamage )
{
    self notify( #"hash_f436c8839eda5ac4" );
    self endon( #"hash_f436c8839eda5ac4" );
    self notify( #"death" );
    self endon( #"death" );
    grounddrone = self;
    
    if ( grounddrone.isdetonating || !grounddrone getcandamage() )
    {
        /#
            if ( getdvarint( @"scr_ground_drone_unit_debug_text" ) )
            {
                iprintln( "<dev string:x181>" + istrue( grounddrone.isdetonating ) + "<dev string:x1bc>" + !grounddrone getcandamage() );
            }
        #/
        
        return;
    }
    
    if ( isdefined( grounddrone.bundle.var_1a32a2efdd7fb91b ) )
    {
        /#
            if ( getdvarint( @"scr_ground_drone_unit_debug_text" ) )
            {
                iprintln( "<dev string:x1c8>" );
                debugstar( grounddrone.origin + ( 0, 0, 25 ), ( 1, 0, 0 ), int( grounddrone.bundle.var_1a32a2efdd7fb91b / level.framedurationseconds ), "<dev string:x1ef>", 0.4 );
            }
        #/
        
        grounddrone.isdetonating = 1;
        wait grounddrone.bundle.var_1a32a2efdd7fb91b;
    }
    
    explosionradius = explosionradius ?? grounddrone.bundle.gduexplosionradius ?? 225;
    explosiondamage = explosiondamage ?? grounddrone.bundle.var_395b93d2fa9ee5de ?? 500;
    grounddrone thread gdu_explode( explosionradius, explosiondamage );
}

// Namespace ground_drone_unit_mp
// Params 0
// Checksum 0x95a251d3, Offset: 0x4b02
// Size: 0x14e
function gdu_teardown()
{
    if ( !self )
    {
        return;
    }
    
    self notify( #"death" );
    grounddrone = self;
    streakinfo = grounddrone.streakinfo;
    owner = grounddrone.originalowner ?? grounddrone.owner;
    
    if ( owner.var_425766479c15a2a0 )
    {
        owner.var_425766479c15a2a0 = arrayremove( owner.var_425766479c15a2a0, grounddrone );
    }
    
    if ( streakinfo && !streakinfo.var_fc297c214692ba76 && streakinfo.spawnedgdus > 0 )
    {
        streakinfo.spawnedgdus--;
    }
    
    grounddrone vehicle_damage::set_can_damage( 0 );
    
    if ( grounddrone.currenttarget )
    {
        grounddrone.currenttarget.gdutarget = undefined;
    }
    
    entityheadicons::setheadicon_deleteicon( grounddrone.headiconid );
    grounddrone delete();
    
    if ( owner && streakinfo && !streakinfo.var_fc297c214692ba76 && !streakinfo.spawnedgdus && !streakinfo.var_c0a2080fc59d32d4 )
    {
        owner killstreak_utility::recordkillstreakendstats( streakinfo );
        owner notify( #"hash_7e98ed31da590793" );
    }
}

// Namespace ground_drone_unit_mp
// Params 3, eflags: 0xc
// Checksum 0xbd0eae63, Offset: 0x4c58
// Size: 0x330, Type: bool
function private gdu_explode( explosionradius, explosiondamage, var_42a73acd85d56be5 )
{
    self notify( #"hash_25c9fa9d309f3b92" );
    self endon( #"hash_25c9fa9d309f3b92" );
    self notify( #"death" );
    grounddrone = self;
    streakinfo = grounddrone.streakinfo;
    owner = grounddrone.originalowner ?? grounddrone.owner;
    
    if ( owner.var_425766479c15a2a0 )
    {
        owner.var_425766479c15a2a0 = arrayremove( owner.var_425766479c15a2a0, grounddrone );
    }
    
    if ( !streakinfo.var_fc297c214692ba76 )
    {
        if ( streakinfo.spawnedgdus > 0 )
        {
            streakinfo.spawnedgdus--;
        }
        else if ( !isdefined( streakinfo.spawnedgdus ) )
        {
            assertmsg( "<dev string:x1fa>" );
        }
        else if ( streakinfo.spawnedgdus <= 0 )
        {
            assertmsg( "<dev string:x210>" );
        }
    }
    
    bundle = grounddrone.bundle;
    var_1731f5a72d7af7d = bundle.var_1731f5a72d7af7d ?? 2;
    
    /#
        if ( getdvarint( @"scr_ground_drone_unit_debug", getdvarint( @"hash_22473e6f3d6e4627", 0 ) ) )
        {
            level callback::callback( #"killstreak_finish_use", { #streakinfo:streakinfo } );
        }
    #/
    
    if ( !streakinfo.var_fc297c214692ba76 && streakinfo.spawnedgdus == var_1731f5a72d7af7d )
    {
        level callback::callback( #"killstreak_finish_use", { #streakinfo:streakinfo } );
    }
    
    grounddrone vehicle_damage::set_can_damage( 0 );
    
    if ( isdefined( grounddrone.currenttarget ) && isdefined( grounddrone.currenttarget.gdutarget ) )
    {
        grounddrone.currenttarget.gdutarget = undefined;
    }
    
    var_42a73acd85d56be5 = var_42a73acd85d56be5 ?? 0;
    
    if ( var_42a73acd85d56be5 )
    {
        grounddrone.damageblockedteam = grounddrone.owner.team ?? grounddrone.team;
    }
    
    if ( isplayer( grounddrone.owner ) && !var_42a73acd85d56be5 )
    {
        grounddrone radiusdamage( grounddrone.origin, explosionradius, explosiondamage, explosiondamage, grounddrone.owner, "MOD_EXPLOSIVE", "ground_drone_unit" );
    }
    else
    {
        grounddrone radiusdamage( grounddrone.origin, explosionradius, explosiondamage, explosiondamage, grounddrone, "MOD_EXPLOSIVE", "ground_drone_unit" );
    }
    
    grounddrone setscriptablepartstate( #"explode", #"on" );
    
    if ( owner && streakinfo.spawnedgdus == 0 && !streakinfo.var_c0a2080fc59d32d4 )
    {
        owner killstreak_utility::recordkillstreakendstats( streakinfo );
        owner notify( #"hash_7e98ed31da590793" );
    }
    
    wait 0.1;
    
    if ( isdefined( grounddrone ) )
    {
        entityheadicons::setheadicon_deleteicon( grounddrone.headiconid );
        grounddrone delete();
    }
    
    return false;
}

// Namespace ground_drone_unit_mp
// Params 1, eflags: 0x4
// Checksum 0x2f9e9df8, Offset: 0x4f91
// Size: 0x4e, Type: bool
function private function_b9141bc33db0d651( streakinfo )
{
    if ( utility::issharedfuncdefined( #"killstreak", #"hash_bc456c37cf700436" ) )
    {
        self [[ utility::getsharedfunc( #"killstreak", #"hash_bc456c37cf700436" ) ]]( undefined, undefined, undefined, undefined, streakinfo, 1000 );
    }
    
    return true;
}

// Namespace ground_drone_unit_mp
// Params 1, eflags: 0xc
// Checksum 0x70745934, Offset: 0x4fe8
// Size: 0x54
function private function_7d57c966c9a886e4( timeout )
{
    self notify( #"hash_42004f54f6e93a73" );
    self endon( #"hash_42004f54f6e93a73" );
    self endon( #"death" );
    wait timeout;
    thread gdu_detonate( undefined, self.bundle.var_6a04c067c94e2f5d ?? 500 );
}

// Namespace ground_drone_unit_mp
// Params 1, eflags: 0x4
// Checksum 0x78f0571c, Offset: 0x5044
// Size: 0xd3
function private gdu_setupdamagefunctionality( streakname )
{
    killstreakvehicle = self;
    scorepopup = "destroyed_" + streakname;
    vodestroyed = "destroyed_" + streakname;
    destroyedsplash = "callout_destroyed_" + streakname;
    var_c96bcef6709d6df1 = &function_71ea7dc7b8875dc1;
    var_d188942a41771ea1 = &function_309ba3aff609372b;
    premoddamagecallback = &gdu_premodifydamage;
    postmoddamagecallback = &gdu_postmodifydamage;
    deathcallback = &gdu_handledeathdamage;
    namespace_9d8e359c3b1041e5::killstreak_setupvehicledamagefunctionalitysharedfunc( streakname, killstreakvehicle, scorepopup, vodestroyed, destroyedsplash, var_c96bcef6709d6df1, var_d188942a41771ea1, premoddamagecallback, postmoddamagecallback, deathcallback );
    vehicle_tracking::register_instance( self, self.owner, self.owner.team );
}

// Namespace ground_drone_unit_mp
// Params 1, eflags: 0x4
// Checksum 0x98b5b53, Offset: 0x511f
// Size: 0xc
function private function_71ea7dc7b8875dc1( streakname )
{
    
}

// Namespace ground_drone_unit_mp
// Params 1, eflags: 0x4
// Checksum 0xb91c7b78, Offset: 0x5133
// Size: 0xc
function private function_309ba3aff609372b( streakname )
{
    
}

// Namespace ground_drone_unit_mp
// Params 1, eflags: 0x4
// Checksum 0x6d567f7c, Offset: 0x5147
// Size: 0x155
function private gdu_premodifydamage( data )
{
    if ( utility::issharedfuncdefined( #"gdu", #"gdu_premodifydamage" ) )
    {
        modify_result = utility::callsharedfunc( #"gdu", #"gdu_premodifydamage", data );
        
        if ( modify_result )
        {
            return modify_result;
        }
    }
    
    if ( data.inflictor.streakname == "ground_drone_unit" )
    {
        if ( level.teambased && self.team == data.inflictor.team )
        {
            data.damage = 0;
            return 1;
        }
    }
    
    if ( level.var_deb9d2b3de25799b )
    {
        var_2e92350940c6845e = level.sharedfuncs[ #"killstreak" ][ #"getmodifieddamageusingdamagetuning" ];
        
        if ( var_2e92350940c6845e )
        {
            data.iskillstreak = 1;
            data.damage = self [[ var_2e92350940c6845e ]]( data.attacker, data.objweapon, data.meansofdeath, data.damage, self.maxhealth, self.bundle.var_20cb8f4e47f3353e, data );
        }
    }
    
    return 1;
}

// Namespace ground_drone_unit_mp
// Params 1, eflags: 0x4
// Checksum 0xa6fbbc59, Offset: 0x52a5
// Size: 0x3c, Type: bool
function private gdu_postmodifydamage( data )
{
    self.currenthealth -= data.damage;
    namespace_9d8e359c3b1041e5::killstreak_updatedamagestatesharedfunc( self.currenthealth );
    return true;
}

// Namespace ground_drone_unit_mp
// Params 1, eflags: 0x4
// Checksum 0x9d8937fc, Offset: 0x52ea
// Size: 0x1bb, Type: bool
function private gdu_handledeathdamage( data )
{
    self notify( #"death" );
    self notify( #"enemy_destroyed_equipment", data.attacker );
    grounddrone = self;
    
    if ( self.owner && data.attacker && data.attacker != self.owner )
    {
        self.owner.var_a26ef65e475429e++;
        
        if ( self.owner.var_a26ef65e475429e >= 2 )
        {
            currenttime = gettime();
            
            if ( self.owner.var_c6f1d72f26715ecf + 7000 < currenttime )
            {
                self.owner.var_c6f1d72f26715ecf = currenttime;
            }
        }
        
        data.attacker thread points::doscoreevent( #"hash_731419bf767945ec", data.objweapon, undefined, undefined, self );
        
        if ( utility::issharedfuncdefined( #"challenges", #"onVehicleKilled" ) )
        {
            data.attacker thread [[ utility::getsharedfunc( #"challenges", #"onVehicleKilled" ) ]]( self, data.attacker, data.damage, data.objweapon );
        }
    }
    
    self.killedbyweapon = data.objweapon;
    thread gdu_explode( grounddrone.bundle.var_c3af4691cbded308 ?? 128, grounddrone.bundle.var_395b93d2fa9ee5de ?? 500 );
    return false;
}

// Namespace ground_drone_unit_mp
// Params 0, eflags: 0xc
// Checksum 0x684f3eeb, Offset: 0x54ae
// Size: 0x85
function private function_7d4d398bc51aeb03()
{
    self notify( #"hash_8e723c0e218fbff9" );
    self endon( #"hash_8e723c0e218fbff9" );
    self endon( #"death", #"emp_gdu", #"hash_b15a39d4ac9b1720" );
    grounddrone = self;
    
    while ( true )
    {
        self waittill( #"vehiclenavsplineinterrupted" );
        
        /#
            if ( getdvarint( @"scr_ground_drone_unit_debug_text" ) )
            {
                iprintln( "<dev string:x229>" );
            }
        #/
        
        grounddrone notify( #"reload_path" );
        waitframe();
    }
}

// Namespace ground_drone_unit_mp
// Params 0, eflags: 0xc
// Checksum 0xa1410d15, Offset: 0x553b
// Size: 0x19c
function private function_1fe906c78aa93cd2()
{
    self notify( #"hash_93d70ab58937ef81" );
    self endon( #"hash_93d70ab58937ef81" );
    self endon( #"death", #"emp_gdu", #"hash_b15a39d4ac9b1720" );
    
    if ( !isdefined( level.ground_drone_monitor_doors_throttle ) )
    {
        level.ground_drone_monitor_doors_throttle = throttle::throttle_initialize( "ground_drone_monitor_doors", 3 );
    }
    
    radius = 96;
    
    if ( isbrgamemode() )
    {
        function_9bd00c78b7087327( radius );
        return;
    }
    
    while ( true )
    {
        throttle::throttle_wait_in_queue( level.ground_drone_monitor_doors_throttle, self );
        var_4049537beff91e38 = getentitylessscriptablearray( undefined, undefined, self.origin, radius, "door" );
        
        foreach ( door in var_4049537beff91e38 )
        {
            if ( door.var_395c22e69066741d )
            {
                door.var_395c22e69066741d notify( #"trigger", self );
                continue;
            }
            
            if ( door.var_e958f5af05f687d1 )
            {
                door.var_e958f5af05f687d1 notify( #"trigger", self );
                continue;
            }
            
            if ( door isscriptableinstance() && door scriptableisdoor() && door scriptabledoorisclosed() )
            {
                door scriptabledooropen( "away", self.origin );
            }
        }
        
        waitframe();
    }
}

// Namespace ground_drone_unit_mp
// Params 1, eflags: 0x4
// Checksum 0x886f414a, Offset: 0x56df
// Size: 0x11e
function private function_9bd00c78b7087327( radius )
{
    while ( true )
    {
        var_4049537beff91e38 = function_15a5bbafd4a4bb67( self.origin, radius );
        
        foreach ( door in var_4049537beff91e38 )
        {
            if ( door.var_395c22e69066741d )
            {
                door.var_395c22e69066741d notify( #"trigger", self );
                continue;
            }
            
            if ( door.var_e958f5af05f687d1 )
            {
                door.var_e958f5af05f687d1 notify( #"trigger", self );
                continue;
            }
            
            if ( door isscriptableinstance() && door scriptableisdoor() && door scriptabledoorisclosed() )
            {
                door scriptabledooropen( "away", self.origin );
            }
        }
        
        wait 0.5;
    }
}

// Namespace ground_drone_unit_mp
// Params 0, eflags: 0xc
// Checksum 0x6c5616d3, Offset: 0x5805
// Size: 0x120
function private function_83f8cf1b706c6934()
{
    self notify( #"hash_f3096f733d948591" );
    self endon( #"hash_f3096f733d948591" );
    self endon( #"death", #"emp_gdu", #"hash_b15a39d4ac9b1720" );
    grounddrone = self;
    
    while ( true )
    {
        if ( grounddrone.veh_speed < 4 )
        {
            currenttime = gettime();
            
            if ( !isdefined( grounddrone.stucktime ) )
            {
                grounddrone.stucktime = currenttime;
            }
            else if ( currenttime - grounddrone.stucktime > 5000 )
            {
                /#
                    if ( getdvarint( @"hash_2b6772e960f7573e" ) )
                    {
                        iprintln( "<dev string:x243>" );
                    }
                #/
                
                if ( !grounddrone.hopping )
                {
                    grounddrone gdu_hop();
                }
                else
                {
                    while ( grounddrone.hopping )
                    {
                        waitframe();
                    }
                }
                
                grounddrone.stucktime = undefined;
            }
        }
        else
        {
            grounddrone.stucktime = undefined;
            
            if ( isdefined( grounddrone.hops ) )
            {
                grounddrone.hops = undefined;
            }
        }
        
        waitframe();
    }
}

// Namespace ground_drone_unit_mp
// Params 0, eflags: 0xc
// Checksum 0xb2863571, Offset: 0x592d
// Size: 0x145
function private function_87261db8e25f5017()
{
    self notify( #"hash_379d9b0c036dd92c" );
    self endon( #"hash_379d9b0c036dd92c" );
    self endon( #"death", #"emp_gdu", #"hash_b15a39d4ac9b1720" );
    grounddrone = self;
    stuckdistance = getdvarint( @"hash_7b247d30b0ae904e", 100 );
    var_e1b53a0e2422581 = getdvarint( @"hash_ceb5b49e96f9da48", 1000 );
    lastpoint = grounddrone.origin;
    stucktime = gettime();
    distancetraveled = 0;
    
    while ( true )
    {
        distancetraveled += distance( lastpoint, self.origin );
        lastpoint = self.origin;
        
        if ( gettime() > stucktime + var_e1b53a0e2422581 )
        {
            if ( !grounddrone.hopping )
            {
                grounddrone gdu_hop();
                grounddrone notify( #"find_new_path" );
            }
            else
            {
                while ( grounddrone.hopping )
                {
                    waitframe();
                }
                
                stucktime = gettime();
                distancetraveled = 0;
                grounddrone notify( #"reload_path" );
            }
        }
        
        if ( distancetraveled > stuckdistance )
        {
            stucktime = gettime();
            distancetraveled = 0;
            grounddrone.hops = undefined;
        }
        
        waitframe();
    }
}

// Namespace ground_drone_unit_mp
// Params 0, eflags: 0xc
// Checksum 0x9b5c7d94, Offset: 0x5a7a
// Size: 0xc9
function private function_e320e54c0e95e1b0()
{
    self notify( #"hash_940f50c74a5a25ef" );
    self endon( #"hash_940f50c74a5a25ef" );
    self endon( #"death", #"emp_gdu", #"hash_b15a39d4ac9b1720" );
    var_9cfc54fb7f27a969 = ( 0, 0, 0 );
    
    while ( true )
    {
        self waittill( #"vehicle_traversal", traversal );
        var_9cfc54fb7f27a969 = self function_9f2ca3b67c0f1fe5();
        
        if ( var_9cfc54fb7f27a969 && vectordot( var_9cfc54fb7f27a969, ( 0, 0, 1 ) ) <= 0 )
        {
            self vehphys_impulse( var_9cfc54fb7f27a969, 15, 1 );
            wait 0.5;
            function_77b5789eb99c0300();
            self notify( #"reload_path" );
            continue;
        }
        
        self notify( #"find_new_path" );
    }
}

// Namespace ground_drone_unit_mp
// Params 2, eflags: 0x4
// Checksum 0xc87d321d, Offset: 0x5b4b
// Size: 0x109
function private gdu_hack( hackeffect, attacker )
{
    self notify( #"hash_b15a39d4ac9b1720" );
    
    if ( !hackeffect.var_30e7de3d76d5a085 )
    {
        return;
    }
    
    if ( self.owner )
    {
        self.owner thread killstreak_utility::playkillstreaktacomdialog( self.streakinfo, undefined, #"stolen_hacked" );
    }
    
    self.originalowner = self.owner;
    self.owner = attacker;
    self.team = attacker.team;
    self.vehicleowner = attacker;
    self setotherent( attacker );
    self setscriptablepartstate( #"hacked", #"stolen", 0 );
    gdutimeout = self.bundle.gdutimeout ?? 60;
    self.lifetimeendtime = int( gdutimeout * 1000 + gettime() );
    thread function_7d57c966c9a886e4( gdutimeout );
    thread function_76e96222a80ccc76();
}

// Namespace ground_drone_unit_mp
// Params 0, eflags: 0x4
// Checksum 0xc8c2c263, Offset: 0x5c5c
// Size: 0x9e
function private gdu_hop()
{
    if ( !isdefined( self.hops ) )
    {
        self.hops = 1;
    }
    else if ( self.hops == 2 )
    {
        thread gdu_detonate();
    }
    else
    {
        self.hops++;
    }
    
    self.hopping = 1;
    self vehphys_impulse( anglestoforward( self.angles ) + ( 0, 0, 1 ), 4, 1 );
    waitframe();
    self rotateto( vectortoangles( ( 0, 0, 0 ) ), 0.1 );
    wait 3;
    self.hopping = undefined;
}

// Namespace ground_drone_unit_mp
// Params 1
// Checksum 0x8c894ae4, Offset: 0x5d02
// Size: 0x158
function function_212cf2d1cbe3a717( spawnlocation )
{
    fakeowner = spawnstruct();
    fakeowner.origin = spawnlocation;
    fakeowner.angles = vectortoangles( ( 0, 1, 0 ) );
    fakeowner.team = "none";
    streakinfo = spawnstruct();
    streakinfo.owner = fakeowner;
    streakinfo.streakname = "ground_drone_unit";
    streakinfo.team = "none";
    streakinfo.var_fc297c214692ba76 = 1;
    bundle = killstreak::function_85b2d8e857ab4898( "ground_drone_unit" );
    streakinfo.bundle = bundle ?? level.streakglobals.streakbundles[ "ground_drone_unit" ];
    
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            return 0;
        }
    }
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
            return 0;
        }
    }
    
    if ( level.gameended )
    {
        streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
        return 0;
    }
    
    level thread function_f9b4c7aa28280fa6( fakeowner, streakinfo );
}

// Namespace ground_drone_unit_mp
// Params 2, eflags: 0x4
// Checksum 0xb0148082, Offset: 0x5e62
// Size: 0x87
function private gdu_freeze( attacker, freezemultiplier )
{
    speedmph = isdefined( self.var_f16b9b9de1c8214c ) ? self.bundle.var_e6c9119eb92a8a4b ?? 40 : self.bundle.var_2fefba772e66567f ?? 20;
    speedips = utility::mph_to_ips( speedmph );
    self function_eb88c4e66edbc855( "p2p", "manualSpeed", speedips * freezemultiplier );
}

// Namespace ground_drone_unit_mp
// Params 0, eflags: 0x4
// Checksum 0x711ad944, Offset: 0x5ef1
// Size: 0x9
function private gdu_unfreeze()
{
    function_76e96222a80ccc76();
}

// Namespace ground_drone_unit_mp
// Params 1, eflags: 0x4
// Checksum 0x49a98588, Offset: 0x5f02
// Size: 0x6f
function private gdu_watchgameend( streakinfo )
{
    self endon( #"disconnected", #"hash_7e98ed31da590793" );
    level waittill( #"game_ended" );
    
    if ( self && streakinfo )
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"killstreak" ][ #"hash_bf17c172d25e8b3d" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            self [[ var_32dbca3143d9c4a5 ]]( streakinfo );
        }
    }
}

/#

    // Namespace ground_drone_unit_mp
    // Params 0, eflags: 0x4
    // Checksum 0x6fbf44a2, Offset: 0x5f79
    // Size: 0x102, Type: dev
    function private function_bc57d3b29f4fa2ed()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_f4ddd875b84ad5b4", 0 ) )
            {
                previousgdu = undefined;
                destination = undefined;
                
                foreach ( gdu in level.debug_gdus )
                {
                    destination = gdu.owner.origin;
                    
                    if ( previousgdu )
                    {
                        destination = previousgdu.origin;
                    }
                    
                    if ( distance( gdu.origin, destination ) > 250 )
                    {
                        gdu.destination = destination;
                        gdu thread function_6a6d9e5ce7a3921c();
                    }
                    
                    waitframe();
                }
            }
            
            wait 0.5;
        }
    }

    // Namespace ground_drone_unit_mp
    // Params 0, eflags: 0x4
    // Checksum 0x7d6f738a, Offset: 0x6083
    // Size: 0xaf, Type: dev
    function private _gdu_debug_jump()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_5ec10a598166f3de", 0 ) )
            {
                foreach ( gdu in level.debug_gdus )
                {
                    gdu thread gdu_jump( ( 0, 0, 1 ), 7, 1 );
                }
                
                wait 2;
                continue;
            }
            
            waitframe();
        }
    }

    // Namespace ground_drone_unit_mp
    // Params 0, eflags: 0x4
    // Checksum 0xf5d16ce8, Offset: 0x613a
    // Size: 0x1c4, Type: dev
    function private function_4b930d4187a8cddf()
    {
        while ( true )
        {
            foreach ( gdu in level.debug_gdus )
            {
                if ( getdvarint( @"hash_dea7238ed6be8dd3", 0 ) )
                {
                    if ( !gdu.var_890255784493fa61 )
                    {
                        gdu setscriptablepartstate( #"locked_on", #"on" );
                        gdu setscriptablepartstate( #"hash_8bbd1e9dfde216e8", #"on" );
                        gdu setscriptablepartstate( #"scanner", #"off" );
                        gdu setscriptablepartstate( #"lights", #"off" );
                        gdu setscriptablepartstate( #"alert", #"on" );
                        gdu.var_890255784493fa61 = 1;
                    }
                    
                    continue;
                }
                
                if ( gdu.var_890255784493fa61 )
                {
                    gdu setscriptablepartstate( #"locked_on", #"off" );
                    gdu setscriptablepartstate( #"hash_8bbd1e9dfde216e8", #"off" );
                    gdu setscriptablepartstate( #"scanner", #"on" );
                    gdu setscriptablepartstate( #"lights", #"on" );
                    gdu setscriptablepartstate( #"alert", #"off" );
                    gdu.var_890255784493fa61 = 0;
                }
            }
            
            waitframe();
        }
    }

    // Namespace ground_drone_unit_mp
    // Params 0, eflags: 0x4
    // Checksum 0xade18c7f, Offset: 0x6306
    // Size: 0xdb, Type: dev
    function private function_575cbe99f429074d()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_6b1c4d90b19b3d63", 0 ) )
            {
                foreach ( gdu in level.debug_gdus )
                {
                    var_b7e295786fca3ba7 = anglestoright( gdu.angles );
                    gdu.destination = gdu.origin + anglestoright( gdu.angles ) * 10;
                    gdu thread function_6a6d9e5ce7a3921c();
                }
            }
            
            waitframe();
        }
    }

    // Namespace ground_drone_unit_mp
    // Params 0, eflags: 0x4
    // Checksum 0x34981839, Offset: 0x63e9
    // Size: 0x7e, Type: dev
    function private function_9cb52b320d46c405()
    {
        foreach ( gdu in level.debug_gdus )
        {
            gdu thread gdu_detonate();
        }
    }

    // Namespace ground_drone_unit_mp
    // Params 1, eflags: 0x4
    // Checksum 0xa319bb5a, Offset: 0x646f
    // Size: 0xed, Type: dev
    function private function_a0e069a24e822fe8( var_6e4cf32910d62e5b )
    {
        foreach ( player in level.players )
        {
            if ( var_6e4cf32910d62e5b == player.name )
            {
                player.var_364c87df61679b25 = player.var_364c87df61679b25 ?? 0;
                player.var_364c87df61679b25 = !player.var_364c87df61679b25;
                
                if ( player )
                {
                    player notifyonplayercommand( "<dev string:x257>", "<dev string:x264>" );
                    continue;
                }
                
                player notifyonplayercommandremove( "<dev string:x257>", "<dev string:x264>" );
            }
        }
    }

    // Namespace ground_drone_unit_mp
    // Params 0, eflags: 0x4
    // Checksum 0x69de2db6, Offset: 0x6564
    // Size: 0x9f, Type: dev
    function private function_4f5711dd00220a10()
    {
        level endon( #"game_ended" );
        
        foreach ( player in level.players )
        {
            if ( isplayer( player ) )
            {
                player function_212cf2d1cbe3a717( player.origin );
                return;
            }
        }
    }

    // Namespace ground_drone_unit_mp
    // Params 0, eflags: 0x4
    // Checksum 0x89f13530, Offset: 0x660b
    // Size: 0xdc, Type: dev
    function private gdu_debug()
    {
        devgui::function_9082edeb5db93280( "<dev string:x26c>" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x282>", @"hash_22473e6f3d6e4627" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x29c>", @"hash_bb3ac8791efdd0c4" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x2a9>", @"hash_3472a23cc9ee7f98" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x2bb>", @"hash_f4ddd875b84ad5b4" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x2c9>", @"hash_5ec10a598166f3de" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x2d5>", @"hash_dea7238ed6be8dd3" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x2e2>", @"hash_6b1c4d90b19b3d63" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x2f0>", @"hash_d963ad33fe173a" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x2ff>", @"hash_9cc7f8709549573b" );
        devgui::function_77df7fe7dd273e10();
        thread _gdu_debug();
    }

    // Namespace ground_drone_unit_mp
    // Params 0, eflags: 0x4
    // Checksum 0xe6cc64e5, Offset: 0x66ef
    // Size: 0x177, Type: dev
    function private _gdu_debug()
    {
        level.debug_gdus = [];
        thread function_bc57d3b29f4fa2ed();
        thread _gdu_debug_jump();
        thread function_4b930d4187a8cddf();
        thread function_575cbe99f429074d();
        
        while ( true )
        {
            var_6e4cf32910d62e5b = getdvar( @"cheat_player" );
            
            if ( getdvarint( @"hash_bb3ac8791efdd0c4", 0 ) )
            {
                setdvar( @"hash_bb3ac8791efdd0c4", 0 );
                thread _gdu_debug_spawn( var_6e4cf32910d62e5b );
            }
            
            if ( getdvarint( @"hash_3472a23cc9ee7f98", 0 ) )
            {
                setdvar( @"hash_3472a23cc9ee7f98", 0 );
                
                foreach ( player in level.players )
                {
                    if ( player.name == var_6e4cf32910d62e5b )
                    {
                        function_212cf2d1cbe3a717( player.origin );
                    }
                }
            }
            
            if ( getdvarint( @"hash_d963ad33fe173a", 0 ) )
            {
                setdvar( @"hash_d963ad33fe173a", 0 );
                thread function_9cb52b320d46c405();
            }
            
            if ( getdvarint( @"hash_9cc7f8709549573b", 0 ) )
            {
                setdvar( @"hash_9cc7f8709549573b", 0 );
                thread function_a0e069a24e822fe8( var_6e4cf32910d62e5b );
            }
            
            waitframe();
        }
    }

    // Namespace ground_drone_unit_mp
    // Params 0, eflags: 0xc
    // Checksum 0xc628aa6a, Offset: 0x686e
    // Size: 0x63, Type: dev
    function private function_7cca71da389c78a4()
    {
        self notify( #"hash_dbaaebaf16950a9" );
        self endon( #"hash_dbaaebaf16950a9" );
        self.owner waittill( #"weapon_fired" );
        lookatpos = player_utility::getplayerlookatpos( self.owner );
        self.forced_destination = getclosestpointonnavmesh( lookatpos );
        function_76e96222a80ccc76();
    }

    // Namespace ground_drone_unit_mp
    // Params 1, eflags: 0x4
    // Checksum 0x2fb30dee, Offset: 0x68d9
    // Size: 0x156, Type: dev
    function private _gdu_debug_spawn( var_6e4cf32910d62e5b )
    {
        foreach ( player in level.players )
        {
            if ( player.name == var_6e4cf32910d62e5b )
            {
                streakinfo = spawnstruct();
                streakinfo.owner = player;
                streakinfo.streakname = "<dev string:x30c>";
                streakinfo.team = player.team;
                spawnpoint = player.origin + anglestoforward( player.angles ) * 100 + anglestoup( player.angles ) * 10;
                
                if ( !isdefined( streakinfo.spawnedgdus ) )
                {
                    streakinfo.spawnedgdus = 0;
                }
                
                streakinfo.spawnedgdus++;
                gdu = function_bf849300daf6e7da( player, player.team, spawnpoint, streakinfo );
            }
        }
    }

    // Namespace ground_drone_unit_mp
    // Params 1, eflags: 0xc
    // Checksum 0x7a4712d9, Offset: 0x6a37
    // Size: 0x25a, Type: dev
    function private function_1e77d301783825eb( streakinfo )
    {
        self notify( #"hash_9f865f9b3adbb975" );
        self endon( #"hash_9f865f9b3adbb975" );
        level endon( #"game_ended" );
        droneowner = self;
        var_4006ded933c58a6b = [];
        var_9c24cda4231d198d = [];
        var_3ce2f3eec5959d29 = squared( 250 );
        targetspawns = 8;
        lastorigin = self.origin;
        mindistancesq = 14400;
        
        while ( true )
        {
            if ( getdvarint( @"dpm", 0 ) == 0 && distancesquared( lastorigin, self.origin ) >= mindistancesq )
            {
                lastorigin = self.origin;
                spawndata = { #spawns:[] };
                i = droneowner function_5ed755a95eee7c63( spawndata, streakinfo );
                
                if ( spawndata.spawns.size >= targetspawns )
                {
                    data = { #spawns:spawndata.spawns, #origin:self.origin };
                    var_4006ded933c58a6b[ var_4006ded933c58a6b.size ] = data;
                }
                else
                {
                    var_9c24cda4231d198d[ var_9c24cda4231d198d.size ] = self.origin;
                }
            }
            
            foreach ( data in var_4006ded933c58a6b )
            {
                print3d( data.origin, i, ( 0, 1, 0 ), 1, 10, 1 );
            }
            
            foreach ( point in var_9c24cda4231d198d )
            {
                level thread debug::drawsphere( point, 10, 1, ( 1, 0, 0 ) );
            }
            
            waitframe();
        }
    }

#/
