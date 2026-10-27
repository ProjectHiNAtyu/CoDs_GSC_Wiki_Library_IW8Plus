// scripts\mp\common\killstreaks\drone_formation_swarm.gsc  (hash_1df3fbb0e5cd1b01.gscc) (size: 32160 Bytes / 0x7da0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2ec6bddb (784776667)
// size ...... 32160 (0x7da0)
// includes .. 15  (offset: 0x7b28)
// strings ... 28  (offset: 0x7ba0)
// dev strs .. 3   (offset: 0x7d7c)
// exports ... 65  (offset: 0x5a60)
// cseg ...... 0x231 + 0x582f (0x5a60)
// imports ... 177 (offset: 0x6488)
// animtree1 . 0   (offset: 0x7da0)
// animtree2 . 0   (offset: 0x7da0)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\killstreaks\killstreak_common;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\damagefeedback;

#namespace drone_formation_swarm;

// Namespace drone_formation_swarm
// Params 0, eflags: 0x1
// Checksum 0x6aa24aed, Offset: 0x24f
// Size: 0x35
function autoexec main()
{
    killstreak_shared::registerkillstreakinitfunction( getxhash( "drone_formation_swarm" ), &drone_formation_swarm_init );
    utility::registersharedfunc( #"drone_formation_swarm", #"hash_cbb23b2459946638", &function_1a6d6bacdf54a2b9 );
}

// Namespace drone_formation_swarm
// Params 0
// Checksum 0xbd95ddbb, Offset: 0x28c
// Size: 0x171
function drone_formation_swarm_init()
{
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"killstreak" ][ #"registerkillstreak" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]( "drone_formation_swarm", &function_1a6d6bacdf54a2b9 );
    }
    
    /#
        setdevdvarifuninitialized( @"hash_e556d9dc6cc585f8", 0 );
        setdevdvarifuninitialized( @"hash_69a4f1340fcd6361", 0 );
        setdevdvarifuninitialized( @"hash_81f6443909ae1049", 0 );
        setdevdvarifuninitialized( @"hash_103c4a39d909274a", 0 );
        setdevdvarifuninitialized( @"hash_634d48410ffe9ff4", 0 );
        setdevdvarifuninitialized( @"hash_151bfe36ac5e512e", 0 );
        setdevdvarifuninitialized( @"hash_1a02650ce2ba5c22", 0 );
        setdevdvarifuninitialized( @"hash_a6b4a65601b24a2b", 0 );
        setdevdvarifuninitialized( @"hash_501936329df6d62d", 0 );
        setdevdvarifuninitialized( @"hash_cafa8d073abad8d", 0 );
        setdevdvarifuninitialized( @"hash_9dbfc09df178de12", 0 );
    #/
    
    level init_drone_formation_swarm_fx();
    assert( utility::issharedfuncdefined( #"killstreak", #"getmodifieddamageusingdamagetuning" ) );
    level function_4b34a3c3e3c38647();
    bundle = level.streakglobals.streakbundles[ "drone_formation_swarm" ];
    killstreaks::registerkillstreakdamagedealingweapon( "drone_formation_swarm", bundle.var_8903cd068487af84, #"large" );
    callback::add( #"player_spawned", &on_player_spawned );
}

// Namespace drone_formation_swarm
// Params 1
// Checksum 0xf0712ab3, Offset: 0x405
// Size: 0x2d
function on_player_spawned( params )
{
    self.var_f37384dc201982c3 = gettime() + level.var_8b8da69164d7e6b9.var_4b5eaa8c78d3a731;
}

// Namespace drone_formation_swarm
// Params 0
// Checksum 0xa0d9c11, Offset: 0x43a
// Size: 0x5a
function init_drone_formation_swarm_fx()
{
    bundle = level.streakglobals.streakbundles[ "drone_formation_swarm" ];
    var_83c0b52191840d65 = bundle.var_604dd1561bd04338 ?? "vfx_sat_core_strk_drone_swarm_target_start";
    level._effect[ "drone_wink" ] = loadfxasset( var_83c0b52191840d65 );
}

// Namespace drone_formation_swarm
// Params 0
// Checksum 0x8d2ba864, Offset: 0x49c
// Size: 0x1ce
function function_4b34a3c3e3c38647()
{
    bundle = level.streakglobals.streakbundles[ "drone_formation_swarm" ];
    numformations = bundle.var_6117436b88116931.size;
    dronehealth = bundle.var_f61b5bb47434b87e ?? 20;
    level.var_8b8da69164d7e6b9 = { #maxhealth:999999, #var_92b773b38090784f:dronehealth, #collisioncontents:trace::create_contents( 1, 1, 0, 1, 1 ), #var_4b5eaa8c78d3a731:( bundle.var_5503c3c87c31705f ?? 0 ) * 1000 + level.spawnprotectiontimer * 1000, #var_88735ec78eb56276:( bundle.var_5a9a9effce2004fa ?? 0 ) * 1000, #numformations:numformations, #vehcount:0, #leavedistance:bundle.var_6b70fc2f8a3ebd3d ?? 0, #approachdistance:bundle.var_962faf31004489a4 ?? 0, #var_5d1a0cefd56111c5:bundle.var_5bfbe151e7c0a00c ?? 7, #flyinduration:bundle.var_35eb59fa61167e9b ?? 7, #projweapon:bundle.var_8903cd068487af84, #var_ca68f807340ec162:( bundle.var_16ea4502c8f4429f ?? 3 ) * 1000, #var_fb404cacec3dd6dd:bundle.var_5ef6317299304e3a ?? 500, #bundle:bundle, #cachelocation:level.mapcenter - ( 0, 0, 1000 ) };
}

// Namespace drone_formation_swarm
// Params 1
// Checksum 0x8e182ab6, Offset: 0x672
// Size: 0x1d6
function function_1a6d6bacdf54a2b9( streakinfo = killstreak_utility::createstreakinfo( "drone_formation_swarm", self ) )
{
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            return 0;
        }
    }
    
    bundle = level.streakglobals.streakbundles[ "drone_formation_swarm" ];
    deploymentweapon = bundle.deployweaponname ?? "ks_gesture_phone_mp";
    deployresult = killstreakdeploy::streakdeploy_dogesturedeploy( streakinfo, makeweapon( deploymentweapon ) );
    
    if ( !deployresult )
    {
        return;
    }
    
    streakinfo.streakduration = ( bundle.var_5255569767b951d8 ?? 30 ) + level.var_8b8da69164d7e6b9.flyinduration;
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            return 0;
        }
    }
    
    self notify( #"munitions_used", "drone_formation_swarm" );
    
    if ( isplayer( self ) )
    {
        if ( utility::issharedfuncdefined( #"sound", #"playkillstreakdeploydialog" ) )
        {
            self [[ utility::getsharedfunc( #"sound", #"playkillstreakdeploydialog" ) ]]( streakinfo.streakname );
            var_68dd22d5a51ac3c0 = 2.5;
        }
        
        thread killstreak_utility::playkillstreaktacomdialog( streakinfo, undefined, #"arrive", undefined, var_68dd22d5a51ac3c0 );
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hud" ][ #"teamplayercardsplash" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self thread [[ var_32dbca3143d9c4a5 ]]( "used_" + "drone_formation_swarm", self );
    }
    
    self.var_e73f627a785541a2[ streakinfo.streakname ] = 0;
    thread function_4825e787f1e66716( streakinfo );
    return 1;
}

// Namespace drone_formation_swarm
// Params 1, eflags: 0x4
// Checksum 0xc1aef035, Offset: 0x851
// Size: 0xb5
function private function_6d04e9764fbf8f23( bundle )
{
    mapoverrides = bundle.var_d9ccc9ad3aa607da;
    var_2fdeeb266e218e37 = getxhashasset( level.mapname );
    
    foreach ( override in mapoverrides )
    {
        if ( override.var_82d5cb54d2450735 == var_2fdeeb266e218e37 )
        {
            return override;
        }
    }
}

// Namespace drone_formation_swarm
// Params 1, eflags: 0x4
// Checksum 0x783aee7f, Offset: 0x90e
// Size: 0x72d
function private function_4825e787f1e66716( streakinfo )
{
    bundle = level.streakglobals.streakbundles[ streakinfo.streakname ];
    mapoverrides = function_6d04e9764fbf8f23( bundle );
    numformations = level.var_8b8da69164d7e6b9.numformations;
    assert( numformations >= 1 );
    var_2edfeb64c9bbd9e2 = 360 / numformations;
    var_206402db038a2f37 = level.mapcenter + ( mapoverrides.var_5049fb9fc7c3a2a1 ?? 0, mapoverrides.var_da925d21d6272be6 ?? 0, mapoverrides.var_7a4c1e58682daf43 ?? 0 );
    self.var_8b8da69164d7e6b9 = { #vehicles:[] };
    var_bf37bc6a3979c7c1 = undefined;
    var_8e4d19f707263067 = undefined;
    thread drone_formation_swarm_watchgameended( streakinfo );
    
    for ( i = 0; i < numformations ; i++ )
    {
        formationbundle = bundle.var_6117436b88116931[ i ];
        flyindelay = formationbundle.var_5a835099f0aec21e ?? 0;
        var_77d329f76244e310 = formationbundle.var_9ea8741caaa949f3 ?? 0;
        movementtype = formationbundle.var_25e5f04ae58a6ca ?? #"wander";
        movespeedmph = formationbundle.var_f7963b8e2f719658 ?? 50;
        var_f05c77bf02ca97c2 = formationbundle.var_a209763ef40b3d05 ?? 30;
        attachradius = ( formationbundle.var_f3050f142ad084c9 ?? 300 ) * ( mapoverrides.var_2f0d61f6f3863fae ?? 1 );
        clockwise = formationbundle.var_d86a64007cb7be6f;
        flightcenter = var_206402db038a2f37 + ( 0, 0, var_f05c77bf02ca97c2 );
        incomingangle = angleclamp( self.angles[ 1 ] + 180 + var_2edfeb64c9bbd9e2 * i );
        dir = clockwise ? 90 : -90;
        var_1f9365a7040d3de6 = ( anglestoforward( ( 0, incomingangle, 0 ) ) + anglestoforward( ( 0, incomingangle + dir, 0 ) ) ) * attachradius;
        approachangles = ( 0, incomingangle, 0 );
        pathgoal = flightcenter - anglestoforward( approachangles ) * attachradius + var_1f9365a7040d3de6;
        
        if ( !var_bf37bc6a3979c7c1 || var_bf37bc6a3979c7c1 > flightcenter[ 2 ] )
        {
            var_bf37bc6a3979c7c1 = flightcenter[ 2 ];
        }
        
        if ( !var_8e4d19f707263067 || var_8e4d19f707263067 < flightcenter[ 2 ] )
        {
            var_8e4d19f707263067 = flightcenter[ 2 ];
        }
        
        if ( movementtype == #"circle" )
        {
            pathgoal = flightcenter - anglestoforward( approachangles ) * attachradius;
            pathstart = pathgoal - anglestoforward( approachangles ) * level.var_8b8da69164d7e6b9.approachdistance;
            veh = function_4632e080ac75646f( i, streakinfo, pathstart, pathgoal );
            veh.clockwise = clockwise;
            veh.movespeedmph = movespeedmph * ( clockwise ? 1 : -1 );
            veh.attachradius = attachradius;
            veh.var_c9d31d5a11421ed3 = formationbundle.var_97377ec36e837ba7;
            veh.var_895934dcc1414cfa = formationbundle.var_75eb5b27f90b1252;
            
            /#
                if ( getdvarint( @"hash_e556d9dc6cc585f8", 0 ) > 0 )
                {
                    veh thread function_e5a28653440198c0( attachradius, flightcenter );
                }
            #/
        }
        else if ( movementtype == #"wander" )
        {
            pathgoal = flightcenter - anglestoforward( approachangles ) * attachradius + var_1f9365a7040d3de6;
            clockwise = 1;
            pathstart = pathgoal - anglestoforward( approachangles ) * level.var_8b8da69164d7e6b9.approachdistance;
            veh = function_4632e080ac75646f( i, streakinfo, pathstart, pathgoal );
            veh.movespeedmph = movespeedmph;
            veh.var_6aaf51a2d372073a = formationbundle.var_82f295b7a38615f5 ?? 20;
        }
        else
        {
            assert( "<dev string:x24>" );
        }
        
        if ( !isdefined( self.var_8b8da69164d7e6b9.vehicles ) )
        {
            self.var_8b8da69164d7e6b9.vehicles = [];
        }
        
        self.var_8b8da69164d7e6b9.vehicles[ self.var_8b8da69164d7e6b9.vehicles.size ] = veh;
        veh rotateto( approachangles, 1 );
        veh.formationbundle = formationbundle;
        veh.flyindelay = flyindelay;
        veh.var_77d329f76244e310 = var_77d329f76244e310;
        veh.movementtype = movementtype;
        veh.flightcenter = flightcenter;
        veh.empd = undefined;
        
        /#
            if ( getdvarint( @"hash_69a4f1340fcd6361", 0 ) > 0 )
            {
                veh thread debug_draw_vehicle_position();
            }
            
            if ( getdvarint( @"hash_81f6443909ae1049", 0 ) > 0 )
            {
                veh thread debug_draw_vehicle_speed();
            }
            
            if ( getdvarint( @"hash_634d48410ffe9ff4", 0 ) > 0 )
            {
                veh thread function_bd964012b2ff1ebe();
            }
            
            if ( getdvarint( @"hash_a6b4a65601b24a2b", 0 ) > 0 )
            {
                veh thread function_28123691afbf70cc();
            }
            
            if ( getdvarint( @"hash_1a02650ce2ba5c22", 0 ) > 0 )
            {
                veh thread function_3829a24a685a6675();
            }
        #/
        
        veh.var_2f90c64ece38d4e3 = undefined;
        veh function_2aa5d372d2378080();
        
        foreach ( tagname, tagnum in veh.var_403c938b88bc99d7 )
        {
            veh setscriptablepartstate( tagname, #"on" );
        }
        
        veh thread drone_formation_swarm_process();
        level.var_8b8da69164d7e6b9.vehcount++;
        waitframe();
    }
    
    foreach ( veh in self.var_8b8da69164d7e6b9.vehicles )
    {
        if ( var_bf37bc6a3979c7c1 && var_8e4d19f707263067 && var_bf37bc6a3979c7c1 > 0 && var_8e4d19f707263067 > 0 && var_bf37bc6a3979c7c1 != var_8e4d19f707263067 )
        {
            veh.var_461a5ffa48ca520b = 1 - ( veh.flightcenter[ 2 ] - var_bf37bc6a3979c7c1 ) / ( var_8e4d19f707263067 - var_bf37bc6a3979c7c1 );
            continue;
        }
        
        veh.var_461a5ffa48ca520b = 0;
    }
    
    thread function_23cda5bbe1a1d42d( flightcenter, self.var_8b8da69164d7e6b9.vehicles );
    thread function_e5dbe06dd6359aab();
    
    if ( isdefined( self.owner ) )
    {
        self.owner val::set( "drone_swarm", "killstreaks", 0 );
    }
}

// Namespace drone_formation_swarm
// Params 0, eflags: 0x4
// Checksum 0x75397091, Offset: 0x1043
// Size: 0x1a0
function private drone_formation_swarm_process()
{
    veh = self;
    randint = randomint( 4 );
    veh setscriptablepartstate( #"formation_animations", "intro_" + randint );
    veh thread function_b1ddbc8ae14a13b2();
    veh drone_formation_swarm_flyin();
    veh setscriptablepartstate( #"formation_animations", "idle_" + randint );
    veh drone_formation_swarm_loiter();
    veh.var_aba92588804fb442 = 1;
    bundle = veh.owner killstreak::function_85b2d8e857ab4898( "drone_formation_swarm" );
    loiterduration = bundle.var_5255569767b951d8 ?? 30;
    result = veh utility::waittill_any_timeout( loiterduration, "emp_fx_complete", "vSXmPNBRsboHejvxmSYB" );
    veh.var_aba92588804fb442 = 0;
    veh notify( #"loiter_end" );
    
    if ( result == "timeout" )
    {
        veh.owner notify( #"hash_cbdc56fabddc7cf1" );
    }
    
    veh.var_2f90c64ece38d4e3 = 1;
    
    if ( veh.health <= 0 || result == "vSXmPNBRsboHejvxmSYB" )
    {
        veh drone_formation_swarm_explode();
    }
    else
    {
        veh drone_formation_swarm_flyout();
    }
    
    veh setscriptablepartstate( #"formation_animations", #"none" );
    veh function_dc02021c891d9e3();
    veh notify( #"drone_formation_swarm_ended" );
    
    if ( veh.var_72b1e09e96a28cbb )
    {
        veh.var_72b1e09e96a28cbb delete();
    }
    
    veh delete();
}

// Namespace drone_formation_swarm
// Params 4, eflags: 0x4
// Checksum 0x22cfb04a, Offset: 0x11eb
// Size: 0x401
function private function_4632e080ac75646f( idx, streakinfo, pathstart, pathgoal )
{
    spawndata = spawnstruct();
    spawndata.angles = ( 0, 0, 0 );
    spawndata.origin = pathstart;
    spawndata.vehicletype = "veh_sat_drone_formation_swarm";
    spawndata.targetname = "swarm";
    spawndata.damageableparts = [];
    bundle = level.streakglobals.streakbundles[ streakinfo.streakname ];
    veh = spawn( "script_model", level.var_8b8da69164d7e6b9.cachelocation );
    veh.var_72b1e09e96a28cbb = spawn( "script_model", level.var_8b8da69164d7e6b9.cachelocation );
    veh setmodel( bundle.var_7710cd918c8d9886 );
    scriptmodelsetweapon( veh, bundle.var_8903cd068487af84 );
    veh.vehiclename = "drone_formation_swarm";
    veh setcandamage( 1 );
    veh.origin = pathstart;
    veh.streakinfo = streakinfo;
    veh.team = self.team;
    veh setotherent( self );
    veh.owner = self;
    veh.maxhealth = level.var_8b8da69164d7e6b9.maxhealth;
    veh.health = level.var_8b8da69164d7e6b9.maxhealth;
    veh.pathstart = pathstart;
    veh.pathgoal = pathgoal;
    var_92b773b38090784f = level.var_8b8da69164d7e6b9.var_92b773b38090784f;
    
    for ( i = 1; i <= 16 ; i++ )
    {
        tagname = function_adfd5d56653d5bf( i );
        spawndata.damageableparts[ tagname ] = { #blockbulletdamage:1, #blockexplosivedamage:1, #explosivedamagehealthvalue:var_92b773b38090784f, #healthvalue:var_92b773b38090784f };
    }
    
    if ( utility::issharedfuncdefined( #"killstreak", #"addtoactivekillstreaklist" ) )
    {
        veh [[ utility::getsharedfunc( #"killstreak", #"addtoactivekillstreaklist" ) ]]( streakinfo.streakname, "Killstreak_Air", self, 0, level.var_8b8da69164d7e6b9.headicon_enable, 100 );
    }
    
    vehicle_damage::get_data( veh.vehiclename, 1 );
    vehicle_damage::activate_parts( veh, spawndata );
    vehicledata = vehicle_damage::get_data( veh.vehiclename );
    vehicledata.damageableparts = veh.damageableparts;
    veh thread function_582bca02b3ab9c1b();
    veh thread drone_formation_swarm_handleincomingstinger();
    
    if ( level.var_36218e71baa7e689 )
    {
        level.var_89fe7f9fa2bc945d[ level.var_89fe7f9fa2bc945d.size ] = veh;
    }
    
    if ( level.var_36218e71baa7e689 )
    {
        veh.var_c5ccf9dff3b5e393 = &function_9ce825dfe1c2fa21;
    }
    
    /#
        if ( getdvarint( @"hash_151bfe36ac5e512e", 0 ) > 0 )
        {
            if ( !isdefined( level.var_8b8da69164d7e6b9.vehicles ) )
            {
                level.var_8b8da69164d7e6b9.vehicles = [];
            }
            
            if ( !isdefined( level.var_8b8da69164d7e6b9.vehicles ) )
            {
                level.var_8b8da69164d7e6b9.vehicles = [];
            }
            
            level.var_8b8da69164d7e6b9.vehicles[ level.var_8b8da69164d7e6b9.vehicles.size ] = veh;
        }
    #/
    
    return veh;
}

// Namespace drone_formation_swarm
// Params 0
// Checksum 0xbe21b543, Offset: 0x15f5
// Size: 0x5a
function function_e5dbe06dd6359aab()
{
    level endon( #"game_ended" );
    self endon( #"death", #"explode" );
    
    while ( true )
    {
        level waittill( #"valkyrie_incoming", player, missile );
        missile thread function_19173f64ee5ea20e( self, player );
    }
}

// Namespace drone_formation_swarm
// Params 2
// Checksum 0x2374d3f1, Offset: 0x1657
// Size: 0x1e6
function function_19173f64ee5ea20e( formationowner, valkyrieowner )
{
    level endon( #"game_ended" );
    self endon( #"death", #"exploded" );
    
    while ( formationowner.var_8b8da69164d7e6b9.vehicles )
    {
        foreach ( veh in formationowner.var_8b8da69164d7e6b9.vehicles )
        {
            if ( self && veh.health && veh.health > 0 )
            {
                var_2bffe4cd095fe7a8 = distancesquared( self.origin, veh.origin );
                
                if ( var_2bffe4cd095fe7a8 < 40000 )
                {
                    missiledamage = level.var_8b8da69164d7e6b9.maxhealth;
                    self radiusdamage( self.origin, 1536, missiledamage, missiledamage, valkyrieowner, "MOD_EXPLOSIVE", self.weapon_name );
                    waitframe();
                    
                    if ( self.owner )
                    {
                        damageisfatal = veh.health <= 0;
                        
                        if ( damageisfatal )
                        {
                            var_cf8e9b1ae515338 = veh.owner && self.owner == veh.owner;
                            
                            if ( !var_cf8e9b1ae515338 )
                            {
                                self.owner thread points::doscoreevent( #"hash_19f6493288ae95e" );
                            }
                            
                            if ( veh )
                            {
                                veh notify( #"death" );
                            }
                        }
                    }
                }
            }
        }
        
        waitframe();
    }
}

// Namespace drone_formation_swarm
// Params 0
// Checksum 0xc480910d, Offset: 0x1845
// Size: 0x6d
function drone_formation_swarm_handleincomingstinger()
{
    level endon( #"game_ended" );
    self endon( #"death", #"explode" );
    
    while ( true )
    {
        level waittill( #"stinger_fired", player, missile, locktarget );
        
        if ( locktarget != self )
        {
            continue;
        }
        
        missile thread function_dccc13d5e93cba49( locktarget, player );
    }
}

// Namespace drone_formation_swarm
// Params 2
// Checksum 0x64cfb388, Offset: 0x18ba
// Size: 0x1a9
function function_dccc13d5e93cba49( target, player )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    prevtargetlocation = target getpointinbounds( 0, 0, 0 );
    var_65f403bd0dfc82ed = distancesquared( self.origin, prevtargetlocation );
    
    while ( true )
    {
        if ( target )
        {
            curtargetlocation = target getpointinbounds( 0, 0, 0 );
        }
        else
        {
            curtargetlocation = prevtargetlocation;
        }
        
        prevtargetlocation = curtargetlocation;
        var_2bffe4cd095fe7a8 = distancesquared( self.origin, curtargetlocation );
        
        if ( var_2bffe4cd095fe7a8 < var_65f403bd0dfc82ed )
        {
            var_65f403bd0dfc82ed = var_2bffe4cd095fe7a8;
        }
        
        if ( var_2bffe4cd095fe7a8 > var_65f403bd0dfc82ed )
        {
            if ( var_2bffe4cd095fe7a8 > 2359296 )
            {
                return;
            }
            
            waitframe();
            missiledamage = level.var_8b8da69164d7e6b9.maxhealth;
            self radiusdamage( self.origin, 1536, missiledamage, missiledamage, player, "MOD_EXPLOSIVE", self.weapon_name );
            self hide();
            self notify( #"deleted" );
            waitframe();
            
            if ( self.owner )
            {
                damageisfatal = target.health <= 0;
                
                if ( damageisfatal )
                {
                    var_cf8e9b1ae515338 = target.owner && self.owner == target.owner;
                    
                    if ( !var_cf8e9b1ae515338 )
                    {
                        self.owner thread points::doscoreevent( #"hash_19f6493288ae95e" );
                    }
                }
            }
            
            waitframe();
            
            if ( self.killcament )
            {
                self.killcament delete();
            }
            
            self delete();
        }
        
        waitframe();
    }
}

// Namespace drone_formation_swarm
// Params 1
// Checksum 0x8e29b160, Offset: 0x1a6b
// Size: 0x33e
function function_9ce825dfe1c2fa21( data )
{
    level endon( #"game_ended" );
    veh = self;
    veh.owner notify( #"hash_cbdc56fabddc7cf1" );
    maxdelay = 3;
    delay = veh.var_461a5ffa48ca520b * maxdelay + randomfloatrange( 0, maxdelay / 10 );
    veh.empd = 1;
    wait delay;
    
    if ( !self.streakinfo.var_b9e621acb40af602 && self.owner )
    {
        self.owner thread killstreak_utility::playkillstreaktacomdialog( self.streakinfo, undefined, #"destroyed" );
        self.streakinfo.var_b9e621acb40af602 = 1;
    }
    
    if ( veh )
    {
        veh setscriptablepartstate( #"sounds", #"empd" );
    }
    
    numdestroyed = 0;
    
    foreach ( dronedata in veh.availabledrones )
    {
        if ( !veh )
        {
            break;
        }
        
        if ( dronedata.tagname )
        {
            veh setscriptablepartstate( dronedata.tagname, #"empd" );
            veh setscriptablepartstate( dronedata.var_169a159b05da2a81, #"off" );
        }
        
        veh function_2984e1cc1b3de267( dronedata );
        numdestroyed++;
        waitframe();
    }
    
    if ( !self.streakinfo.var_529e5994d90299db && data.attacker )
    {
        if ( isdefined( level.sharedfuncs[ #"player" ][ #"doScoreEvent" ] ) )
        {
            data.attacker thread [[ level.sharedfuncs[ #"player" ][ #"doScoreEvent" ] ]]( #"hash_19f6493288ae95e", data.objweapon, undefined, undefined, data.victim );
        }
        
        self.streakinfo.var_529e5994d90299db = 1;
    }
    
    if ( veh )
    {
        veh notify( #"death" );
    }
    
    waitframe();
    wait 4;
    
    if ( veh )
    {
        foreach ( tagname, tagnum in veh.var_403c938b88bc99d7 )
        {
            veh setscriptablepartstate( tagname, #"hide_vfx_and_collision" );
        }
        
        veh notify( #"emp_fx_complete" );
        veh setscriptablepartstate( #"sounds", #"off" );
        veh stopsounds();
    }
}

// Namespace drone_formation_swarm
// Params 0, eflags: 0x4
// Checksum 0x1f317783, Offset: 0x1db1
// Size: 0x27c
function private function_582bca02b3ab9c1b()
{
    veh = self;
    level endon( #"game_ended" );
    veh endon( #"death" );
    targetent = veh getentitynumber();
    
    while ( true )
    {
        veh waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor, time );
        var_cf8e9b1ae515338 = veh.owner && attacker == veh.owner;
        
        if ( !isplayer( attacker ) || self.team && attacker.team && self.team == attacker.team && !var_cf8e9b1ae515338 )
        {
            continue;
        }
        
        data = { #damage:damage, #point:point, #meansofdeath:meansofdeath, #partname:partname, #objweapon:objweapon, #attacker:attacker };
        function_6523aee1b89ebf4b( data );
        var_81430703f4f6c83d = vehicle_damage::function_eefd0f962152cc9f( veh, data, damage );
        damageisfatal = veh.damageableparts[ partname ].healthvalue <= 0;
        
        if ( isdefined( attacker ) )
        {
            var_7731d58f6f82f082 = { #mod:meansofdeath, #direction_vec:direction_vec, #point:point, #objweapon:objweapon, #victim:veh };
            attacker damagefeedback::updatedamagefeedback( "hitequip", damageisfatal, 0, "hitequip", undefined, 1, targetent, undefined, undefined, var_7731d58f6f82f082 );
            
            if ( damageisfatal )
            {
                if ( !var_cf8e9b1ae515338 )
                {
                    attacker thread points::doscoreevent( #"destroyed_drone_formation_swarm", objweapon );
                }
                
                continue;
            }
        }
        
        if ( veh.health <= 0 )
        {
            return;
        }
    }
}

// Namespace drone_formation_swarm
// Params 1, eflags: 0x4
// Checksum 0xe717454f, Offset: 0x2035
// Size: 0xa6
function private function_6523aee1b89ebf4b( data )
{
    if ( level.var_deb9d2b3de25799b )
    {
        bundle = level.streakglobals.streakbundles[ "drone_formation_swarm" ];
        data.damage = self [[ utility::getsharedfunc( #"killstreak", #"getmodifieddamageusingdamagetuning" ) ]]( data.attacker, data.objweapon, data.meansofdeath, data.damage, self.maxhealth, bundle.var_20cb8f4e47f3353e, data );
    }
}

// Namespace drone_formation_swarm
// Params 0, eflags: 0x4
// Checksum 0x5d716356, Offset: 0x20e3
// Size: 0xc3
function private function_2aa5d372d2378080()
{
    vehicleref = vehicle::get_ref();
    self.var_403c938b88bc99d7 = [];
    self.availabledrones = [];
    
    for ( i = 1; i <= 16 ; i++ )
    {
        data = { #target:undefined, #var_169a159b05da2a81:function_bb31a2c49f76f55e( i ), #tagname:function_adfd5d56653d5bf( i ), #tagnumber:i };
        self.availabledrones[ i ] = data;
        self.var_403c938b88bc99d7[ data.tagname ] = i;
        vehicle_damage::function_ec222609915dafe4( vehicleref, data.tagname, &function_221b48afca63ac62 );
    }
}

// Namespace drone_formation_swarm
// Params 2, eflags: 0x4
// Checksum 0x877b459e, Offset: 0x21ae
// Size: 0xc5
function private function_221b48afca63ac62( veh, damagedata )
{
    tagnumber = veh.var_403c938b88bc99d7[ damagedata.partname ];
    dronedata = veh.availabledrones[ tagnumber ];
    veh function_2984e1cc1b3de267( dronedata );
    veh setscriptablepartstate( #"sounds", #"drone_destroyed" );
    wait 4;
    veh setscriptablepartstate( damagedata.partname, #"hide_vfx_and_collision" );
    veh setscriptablepartstate( dronedata.var_169a159b05da2a81, #"off" );
    veh setscriptablepartstate( #"sounds", #"off" );
}

// Namespace drone_formation_swarm
// Params 0, eflags: 0x4
// Checksum 0x44534573, Offset: 0x227b
// Size: 0xcb
function private drone_formation_swarm_flyin()
{
    veh = self;
    wait veh.flyindelay;
    var_a80e07e8753821cd = veh.origin - veh.pathgoal;
    veh.var_72b1e09e96a28cbb.origin = veh.flightcenter + var_a80e07e8753821cd;
    veh linkto( veh.var_72b1e09e96a28cbb );
    veh.var_72b1e09e96a28cbb moveto( veh.flightcenter, level.var_8b8da69164d7e6b9.flyinduration, 0, level.var_8b8da69164d7e6b9.flyinduration / 2 );
    wait level.var_8b8da69164d7e6b9.flyinduration;
}

// Namespace drone_formation_swarm
// Params 0, eflags: 0x4
// Checksum 0x8eec255, Offset: 0x234e
// Size: 0x64
function private drone_formation_swarm_loiter()
{
    veh = self;
    
    if ( veh.movementtype == #"circle" )
    {
        veh thread drone_formation_swarm_circle();
        return;
    }
    
    if ( veh.movementtype == #"wander" )
    {
        veh thread drone_formation_swarm_wander();
        return;
    }
    
    assertmsg( "<dev string:x50>" );
}

// Namespace drone_formation_swarm
// Params 1, eflags: 0x4
// Checksum 0x882a49b2, Offset: 0x23ba
// Size: 0xde
function private function_22b3a6054e153561( var_56cde73f3adfa1cf )
{
    veh = self;
    veh endon( #"loiter_end" );
    veh endon( #"death" );
    level endon( #"game_ended" );
    bundle = veh.owner killstreak::function_85b2d8e857ab4898( "drone_formation_swarm" );
    loiterduration = bundle.var_5255569767b951d8 ?? 30;
    var_56cde73f3adfa1cf = gettime() + loiterduration * 1000;
    
    while ( gettime() < var_56cde73f3adfa1cf )
    {
        if ( veh.movedir )
        {
            veh.origin += veh.movedir * veh.currspeed * level.framedurationseconds;
        }
        
        waitframe();
    }
}

// Namespace drone_formation_swarm
// Params 0, eflags: 0x4
// Checksum 0xb127c58d, Offset: 0x24a0
// Size: 0xb3
function private function_7bf5352afa7f14e0()
{
    veh = self;
    x = veh.origin[ 0 ] - veh.flightcenter[ 0 ];
    y = veh.origin[ 1 ] - veh.flightcenter[ 1 ];
    var_1342e6959d4b5e03 = x == 0 ? y >= 0 ? 90 : -90 : atan( y / x );
    
    if ( var_1342e6959d4b5e03 < 0 )
    {
        var_1342e6959d4b5e03 += 360;
    }
    
    if ( x < 0 )
    {
        var_1342e6959d4b5e03 += 180;
    }
    
    angleclamp( var_1342e6959d4b5e03 );
    return var_1342e6959d4b5e03;
}

// Namespace drone_formation_swarm
// Params 2, eflags: 0x4
// Checksum 0x337ef1f9, Offset: 0x255c
// Size: 0x67
function private function_696ddf25eb0c7293( origin, target )
{
    forward = vectornormalize( target - origin );
    right = vectornormalize( vectorcross( forward, ( 0, 0, 1 ) ) );
    up = vectornormalize( vectorcross( right, forward ) );
    return axistoangles( forward, right, up );
}

// Namespace drone_formation_swarm
// Params 0, eflags: 0x4
// Checksum 0xd105bf8f, Offset: 0x25cc
// Size: 0x188
function private drone_formation_swarm_circle()
{
    veh = self;
    veh endon( #"loiter_end" );
    veh endon( #"death" );
    level endon( #"game_ended" );
    bundle = veh.owner killstreak::function_85b2d8e857ab4898( "drone_formation_swarm" );
    loiterduration = bundle.var_5255569767b951d8 ?? 30;
    var_f44c2960b4ec7f4 = min( loiterduration / 4, 3 );
    veh.var_72b1e09e96a28cbb rotatevelocity( ( 0, veh.movespeedmph * -1, 0 ), loiterduration + 3, var_f44c2960b4ec7f4, var_f44c2960b4ec7f4 );
    var_901ca6178755a09d = veh.angles;
    var_cdadcc0e17b1579 = bundle.var_4ad0506b88606d82 ?? 0;
    var_fc20d9ab55d09928 = bundle.var_94d4b7fff9d9e0e1 ?? 2;
    var_a38e77283cec7cfa = bundle.var_3ae2bea0eb38ddd7 ?? 5;
    veh thread function_29a8b9d642938af9( loiterduration, var_cdadcc0e17b1579, var_fc20d9ab55d09928, var_a38e77283cec7cfa );
    
    if ( veh.var_c9d31d5a11421ed3 )
    {
        if ( veh.var_895934dcc1414cfa )
        {
            veh function_df5739f0bfd07279( function_696ddf25eb0c7293( veh.flightcenter, veh.origin ), 2, 1, 1 );
        }
        
        return;
    }
    
    while ( true )
    {
        veh.angles = var_901ca6178755a09d;
        waitframe();
    }
}

// Namespace drone_formation_swarm
// Params 4, eflags: 0x4
// Checksum 0xcbbc78af, Offset: 0x275c
// Size: 0x158
function private function_29a8b9d642938af9( loiterduration, var_cdadcc0e17b1579, var_fc20d9ab55d09928, var_a38e77283cec7cfa )
{
    veh = self;
    veh endon( #"loiter_end" );
    veh endon( #"death" );
    level endon( #"game_ended" );
    
    if ( var_cdadcc0e17b1579 <= 0 )
    {
        return;
    }
    
    var_56cde73f3adfa1cf = gettime() + loiterduration * 1000;
    var_636f59368d7642 = gettime() + loiterduration * 1000 - var_a38e77283cec7cfa * 1000;
    basepos = veh.var_72b1e09e96a28cbb.origin;
    
    while ( gettime() < var_636f59368d7642 )
    {
        var_17fcc095490940e0 = randomfloatrange( 0, var_cdadcc0e17b1579 * 2 ) - var_cdadcc0e17b1579;
        var_35a3e1163c2b88d0 = randomfloatrange( var_fc20d9ab55d09928, var_a38e77283cec7cfa );
        desiredpos = ( basepos[ 0 ], basepos[ 1 ], basepos[ 2 ] + var_17fcc095490940e0 );
        veh.var_72b1e09e96a28cbb moveto( desiredpos, var_35a3e1163c2b88d0, var_35a3e1163c2b88d0 / 4, var_35a3e1163c2b88d0 / 4 );
        wait var_35a3e1163c2b88d0;
    }
    
    var_933fa5a4b2c5d19 = ( var_56cde73f3adfa1cf - gettime() ) * 0.001;
    veh.var_72b1e09e96a28cbb moveto( basepos, var_933fa5a4b2c5d19, var_933fa5a4b2c5d19 / 4, var_933fa5a4b2c5d19 / 4 );
}

// Namespace drone_formation_swarm
// Params 0, eflags: 0x4
// Checksum 0xdc0c1e7d, Offset: 0x28bc
// Size: 0xf5
function private drone_formation_swarm_wander()
{
    veh = self;
    veh endon( #"loiter_end" );
    veh endon( #"death" );
    level endon( #"game_ended" );
    mapradius = level.mapsize * 0.5;
    veh thread function_22b3a6054e153561();
    
    while ( veh )
    {
        nextpos = veh function_ff9a943d53d50d59( mapradius );
        var_9d800cdf765e0a1b = randomfloatrange( 5, 10 );
        
        /#
            if ( getdvarint( @"hash_501936329df6d62d", 0 ) > 0 )
            {
                veh thread debug_draw_next_position( nextpos, var_9d800cdf765e0a1b );
            }
        #/
        
        veh function_542b87b67ac984b0( nextpos );
        wait var_9d800cdf765e0a1b;
        nextpos = veh function_4f6afb3f4ed96bc4();
        var_9d800cdf765e0a1b = randomfloatrange( 5, 10 );
        
        /#
            if ( getdvarint( @"hash_501936329df6d62d", 0 ) > 0 )
            {
                veh thread debug_draw_next_position( nextpos, var_9d800cdf765e0a1b );
            }
        #/
        
        veh function_542b87b67ac984b0( nextpos );
        wait var_9d800cdf765e0a1b;
        waitframe();
    }
}

// Namespace drone_formation_swarm
// Params 1, eflags: 0x4
// Checksum 0x96543be5, Offset: 0x29b9
// Size: 0x29f
function private function_542b87b67ac984b0( destination )
{
    veh = self;
    veh endon( #"loiter_end" );
    veh endon( #"death" );
    level endon( #"game_ended" );
    veh.currspeed = 0;
    veh.movedir = vectornormalize( destination - veh.origin );
    topspeed = self.movespeedmph * 17.6;
    acceleration = self.var_6aaf51a2d372073a * 17.6;
    totaldistance = distance( destination, veh.origin );
    var_7843d99347e64c30 = topspeed / acceleration;
    var_10ec39e37db8c602 = 0.5 * acceleration * squared( var_7843d99347e64c30 );
    totaldistance = distance( veh.origin, destination );
    
    if ( var_10ec39e37db8c602 * 2 <= totaldistance )
    {
        remainingdistance = totaldistance - 2 * var_10ec39e37db8c602;
        var_14c797a6f8092d10 = remainingdistance / topspeed;
        totaltime = 2 * var_7843d99347e64c30 + var_14c797a6f8092d10;
        var_46f7a961c4126bb2 = gettime() + var_7843d99347e64c30 * 1000;
        
        while ( gettime() < var_46f7a961c4126bb2 )
        {
            veh.currspeed += acceleration * level.framedurationseconds;
            waitframe();
        }
        
        veh.currspeed = topspeed;
        var_a0f4df7dfa476ec1 = gettime() + var_14c797a6f8092d10 * 1000;
        wait var_14c797a6f8092d10;
        var_dd3ac321f4bfa778 = gettime() + var_7843d99347e64c30 * 1000;
        
        while ( gettime() < var_dd3ac321f4bfa778 )
        {
            veh.currspeed -= acceleration * level.framedurationseconds;
            waitframe();
        }
    }
    else
    {
        maxdistance = totaldistance / 2;
        var_523c43c797cd81f = sqrt( 2 * maxdistance / acceleration );
        var_46f7a961c4126bb2 = gettime() + var_523c43c797cd81f * 1000;
        
        while ( gettime() < var_46f7a961c4126bb2 )
        {
            veh.currspeed += acceleration * level.framedurationseconds;
            waitframe();
        }
        
        var_dd3ac321f4bfa778 = gettime() + var_523c43c797cd81f * 1000;
        
        while ( gettime() < var_dd3ac321f4bfa778 )
        {
            veh.currspeed -= acceleration * level.framedurationseconds;
            waitframe();
        }
    }
    
    veh.currspeed = 0;
    veh moveto( destination, 1 );
}

// Namespace drone_formation_swarm
// Params 0, eflags: 0x4
// Checksum 0x965f49b7, Offset: 0x2c60
// Size: 0x9c
function private function_4f6afb3f4ed96bc4()
{
    veh = self;
    xdiff = veh.flightcenter[ 0 ] - veh.origin[ 0 ];
    ydiff = veh.flightcenter[ 1 ] - veh.origin[ 1 ];
    navpos = getclosestpointonnavmesh( veh.flightcenter + ( xdiff, ydiff, 0 ) );
    nextpos = ( navpos[ 0 ], navpos[ 1 ], veh.origin[ 2 ] );
    return nextpos;
}

// Namespace drone_formation_swarm
// Params 1, eflags: 0x4
// Checksum 0xbe1d2733, Offset: 0x2d05
// Size: 0x68
function private function_ff9a943d53d50d59( mapradius )
{
    veh = self;
    randpos = utility::getrandompointincircle( veh.flightcenter, mapradius );
    navpos = getclosestpointonnavmesh( randpos );
    nextpos = ( navpos[ 0 ], navpos[ 1 ], veh.origin[ 2 ] );
    return nextpos;
}

// Namespace drone_formation_swarm
// Params 0, eflags: 0x4
// Checksum 0x4545edb8, Offset: 0x2d76
// Size: 0x1a3
function private drone_formation_swarm_explode()
{
    veh = self;
    level endon( #"game_ended" );
    
    if ( !veh )
    {
        return;
    }
    
    veh setscriptablepartstate( #"formation_destruction", #"explode" );
    
    foreach ( dronedata in veh.availabledrones )
    {
        if ( dronedata.tagname )
        {
            veh setscriptablepartstate( dronedata.tagname, #"death" );
            veh setscriptablepartstate( dronedata.var_169a159b05da2a81, #"off" );
        }
        
        veh function_2984e1cc1b3de267( dronedata );
        waitframe();
    }
    
    wait 4;
    
    if ( veh )
    {
        foreach ( tagname, tagnum in veh.var_403c938b88bc99d7 )
        {
            veh setscriptablepartstate( tagname, #"hide_vfx_and_collision" );
        }
        
        veh setscriptablepartstate( #"sounds", #"off" );
        veh stopsounds();
    }
}

// Namespace drone_formation_swarm
// Params 0, eflags: 0x4
// Checksum 0xc5fdd27a, Offset: 0x2f21
// Size: 0x119
function private drone_formation_swarm_flyout()
{
    veh = self;
    level endon( #"game_ended" );
    wait veh.var_77d329f76244e310;
    var_1342e6959d4b5e03 = veh function_7bf5352afa7f14e0();
    var_1342e6959d4b5e03 += veh.clockwise ? -90 : 90;
    endgoal = ( cos( var_1342e6959d4b5e03 ), sin( var_1342e6959d4b5e03 ), 0 ) * level.var_8b8da69164d7e6b9.leavedistance;
    veh.var_72b1e09e96a28cbb moveto( endgoal, level.var_8b8da69164d7e6b9.var_5d1a0cefd56111c5, level.var_8b8da69164d7e6b9.var_5d1a0cefd56111c5 );
    
    if ( !veh.empd )
    {
        veh setscriptablepartstate( #"sounds", #"outro" );
    }
    
    wait level.var_8b8da69164d7e6b9.var_5d1a0cefd56111c5;
    veh setscriptablepartstate( #"sounds", #"off" );
    veh stopsounds();
}

// Namespace drone_formation_swarm
// Params 2, eflags: 0x4
// Checksum 0xdee1a126, Offset: 0x3042
// Size: 0x78
function private function_449240cfc5f671f9( var_169a159b05da2a81, var_633880f2fdef00f7 )
{
    veh = self;
    veh endon( #"death" );
    veh endon( #"drone_formation_swarm_ended" );
    level endon( #"game_ended" );
    
    if ( var_169a159b05da2a81 )
    {
        wait var_633880f2fdef00f7;
        self setscriptablepartstate( var_169a159b05da2a81, #"on" );
        wait 2;
        self setscriptablepartstate( var_169a159b05da2a81, #"off" );
    }
}

// Namespace drone_formation_swarm
// Params 0, eflags: 0x4
// Checksum 0xe96bba5d, Offset: 0x30c2
// Size: 0x7ea
function private function_b1ddbc8ae14a13b2()
{
    veh = self;
    veh endon( #"death" );
    veh endon( #"drone_formation_swarm_ended" );
    level endon( #"game_ended" );
    
    if ( !isdefined( level.var_8b8da69164d7e6b9.var_d430c290f1ff70d6 ) )
    {
        level.var_8b8da69164d7e6b9.var_d430c290f1ff70d6 = [ 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 1, 1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 1, 0, 1, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 0 ];
    }
    
    if ( !isdefined( level.var_8b8da69164d7e6b9.var_eb7512472636c0e3 ) )
    {
        level.var_8b8da69164d7e6b9.var_eb7512472636c0e3 = [ 0.7347, 1, 0.7143, 0.9796, 0.5306, 0.4082, 0.8571, 0.9388, 0.1837, 0.7755, 0.1429, 0.0612, 0.9592, 0.1224, 0.3265, 0.5714, 0.3061, 0.6939, 0.7959, 0.2449, 0.8163, 0.5102, 0.4286, 0.3469, 0.4694, 0.898, 0.2653, 0.6735, 0.3673, 0.7551, 0.4898, 0.2245, 0.8776, 0.2857, 0.8367, 0.3878, 0.1633, 0.0408, 0.6327, 0.551, 0.0204, 0.5918, 0, 0.6531, 0.6122, 0.2041, 0.102, 0.9184, 0.0816, 0.449 ];
    }
    
    boolindex = randomintrange( 0, level.var_8b8da69164d7e6b9.var_d430c290f1ff70d6.size );
    var_fce9ee7192b6947d = randomintrange( 0, 11 );
    floatindex = randomintrange( 0, level.var_8b8da69164d7e6b9.var_eb7512472636c0e3.size );
    var_f3b74306a457ef0b = randomintrange( 0, 7 );
    
    while ( true )
    {
        foreach ( dronedata in veh.availabledrones )
        {
            if ( level.var_8b8da69164d7e6b9.var_d430c290f1ff70d6[ boolindex ] )
            {
                var_633880f2fdef00f7 = level.var_8b8da69164d7e6b9.var_eb7512472636c0e3[ floatindex ];
                veh thread function_449240cfc5f671f9( dronedata.var_169a159b05da2a81, var_633880f2fdef00f7 );
                floatindex += var_f3b74306a457ef0b;
                floatindex %= level.var_8b8da69164d7e6b9.var_eb7512472636c0e3.size;
            }
            
            boolindex += var_fce9ee7192b6947d;
            boolindex %= level.var_8b8da69164d7e6b9.var_d430c290f1ff70d6.size;
        }
        
        wait 3;
    }
}

// Namespace drone_formation_swarm
// Params 0, eflags: 0x4
// Checksum 0xebfaf116, Offset: 0x38b4
// Size: 0xce
function private function_dc02021c891d9e3()
{
    veh = self;
    level.var_8b8da69164d7e6b9.vehcount--;
    
    if ( level.var_8b8da69164d7e6b9.vehcount == 0 )
    {
        if ( self.owner )
        {
            self.owner val::set( "drone_swarm", "killstreaks", 1 );
        }
        
        level callback::callback( #"killstreak_finish_use", { #streakinfo:veh.streakinfo } );
        
        if ( self.owner )
        {
            self.owner killstreak_utility::recordkillstreakendstats( veh.streakinfo );
        }
    }
    
    /#
        if ( getdvarint( @"hash_151bfe36ac5e512e", 0 ) > 0 )
        {
            level thread function_6f27bdfa85d0c11d();
        }
    #/
}

// Namespace drone_formation_swarm
// Params 2, eflags: 0x4
// Checksum 0x5c84cc41, Offset: 0x398a
// Size: 0x54d
function private function_23cda5bbe1a1d42d( flightcenter, vehicles )
{
    level endon( #"game_ended" );
    self endon( #"hash_cbdc56fabddc7cf1" );
    
    if ( level.teambased && isdefined( self.team ) )
    {
        enemyteam = team_utility::getenemyteams( self.team );
    }
    
    var_fb404cacec3dd6dd = level.var_8b8da69164d7e6b9.var_fb404cacec3dd6dd ?? 500;
    bundle = killstreak::function_85b2d8e857ab4898( "drone_formation_swarm" );
    loiterduration = bundle.var_5255569767b951d8 ?? 30;
    var_e041b85a7c4f2997 = bundle.var_ad671173c0213e56 ?? 2;
    endtimems = gettime() + loiterduration * 1000;
    
    while ( gettime() < endtimems )
    {
        targets = isdefined( enemyteam ) ? getplayersandaiarrayinradius( flightcenter, var_fb404cacec3dd6dd, enemyteam ) : getplayersandaiarrayinradius( flightcenter, var_fb404cacec3dd6dd );
        
        foreach ( target in targets )
        {
            if ( !target )
            {
                continue;
            }
            
            if ( target == self )
            {
                continue;
            }
            
            if ( target.var_374b12304be35ea8 )
            {
                continue;
            }
            
            currenttime = gettime();
            
            if ( target.var_a736fceede2f3c48 > currenttime )
            {
                continue;
            }
            
            if ( target.var_8e3d213ca89049db >= var_e041b85a7c4f2997 )
            {
                target.var_8e3d213ca89049db = 0;
            }
            
            if ( isplayer( target ) )
            {
                if ( target.var_f37384dc201982c3 > currenttime )
                {
                    continue;
                }
                
                if ( isdefined( target.perks[ "specialty_blindeye" ] ) )
                {
                    continue;
                }
            }
            
            entnum = target getentitynumber();
            
            if ( level.activekillstreaks[ entnum ] )
            {
                target.var_374b12304be35ea8 = 1;
                continue;
            }
            
            bestveh = undefined;
            var_4cce10a297137aa8 = undefined;
            var_3870c30ec9fba455 = undefined;
            
            foreach ( veh in vehicles )
            {
                if ( veh.var_aba92588804fb442 && !veh.empd )
                {
                    var_3f40407edd3d9eee = target.origin - veh.origin;
                    veh_direction = anglestoforward( veh.angles );
                    dotproduct = vectordot2( var_3f40407edd3d9eee, veh_direction );
                    
                    if ( !bestveh )
                    {
                        bestveh = veh;
                        var_4cce10a297137aa8 = dotproduct;
                        rayorigin = veh.availabledrones[ 0 ] ? veh gettagorigin( veh.availabledrones[ 0 ].tagname ) : veh.origin;
                        trace = trace::ray_trace( rayorigin, target.origin, veh, level.var_8b8da69164d7e6b9.collisioncontents );
                        var_3870c30ec9fba455 = trace[ "entity" ] == target ? 1 : 0;
                        continue;
                    }
                    
                    if ( var_4cce10a297137aa8 < dotproduct || !var_3870c30ec9fba455 )
                    {
                        rayorigin = veh.availabledrones[ 0 ] ? veh gettagorigin( veh.availabledrones[ 0 ].tagname ) : veh.origin;
                        trace = trace::ray_trace( rayorigin, target.origin, veh, level.var_8b8da69164d7e6b9.collisioncontents );
                        var_a0b7c97bde8a8f3 = trace[ "entity" ] == target ? 1 : 0;
                        
                        if ( var_a0b7c97bde8a8f3 )
                        {
                            bestveh = veh;
                            var_4cce10a297137aa8 = dotproduct;
                            var_3870c30ec9fba455 = var_a0b7c97bde8a8f3;
                            
                            if ( var_4cce10a297137aa8 > 0.707 )
                            {
                                break;
                            }
                        }
                    }
                }
            }
            
            if ( bestveh )
            {
                dronedata = bestveh function_8fbd471fbcf5580a( target );
                
                if ( dronedata )
                {
                    bestveh setscriptablepartstate( dronedata.tagname, #"hide_vfx_and_collision" );
                    bestveh setscriptablepartstate( dronedata.var_169a159b05da2a81, #"off" );
                    missile = bestveh drone_formation_swarm_missile_spawn( dronedata );
                    missile thread function_f7e8ccf6645f5281( bestveh );
                    bestveh thread function_72843ffb162ed61e( missile );
                    bestveh.var_8090d752ba8d7531 = 0;
                    
                    if ( isplayer( target ) )
                    {
                        playfxontagforclients( utility::getfx( "drone_wink" ), bestveh, dronedata.tagname, target );
                        target playsoundtoplayer( "kls_sat_drone_swarm_target_acquired", target );
                    }
                }
            }
            
            waitframe();
        }
        
        waitframe();
    }
    
    clear_target_drone_count( flightcenter, var_fb404cacec3dd6dd );
}

// Namespace drone_formation_swarm
// Params 1, eflags: 0x4
// Checksum 0xde8bcf84, Offset: 0x3edf
// Size: 0x19a
function private function_72843ffb162ed61e( missile )
{
    veh = self;
    target = missile.dronedata.target;
    missile function_5e956ca1f251e3ee( veh, target );
    
    if ( missile.dronedata.var_ab64297446d37799 )
    {
        missile unlink();
        missile.killcament = spawn( "script_model", missile.origin + anglestoforward( missile.angles ) * -75 - anglestoright( missile.angles ) * 0 - anglestoup( missile.angles ) * 25 );
        missile.killcament.origin = missile.origin + anglestoforward( missile.angles ) * -75 - anglestoright( missile.angles ) * 0 - anglestoup( missile.angles ) * 25;
        missile.killcament.starttime = gettime();
        missile.killcament setmodel( "tag_origin" );
        missile.killcament linkto( missile, "tag_origin" );
        missile.killcament namespace_9d8e359c3b1041e5::setscriptmoverkillcamsharedfunc( "missile", 25, 75 );
        missile thread function_1d7ec672c9b2bc06( target );
        missile thread function_661511a36bd1f1d9( target );
        return;
    }
    
    if ( missile )
    {
        missile thread function_648b479ca87c6922( veh );
    }
}

// Namespace drone_formation_swarm
// Params 1
// Checksum 0xecde05e9, Offset: 0x4081
// Size: 0xed
function function_661511a36bd1f1d9( target )
{
    level endon( #"game_ended" );
    prevtargetlocation = target getpointinbounds( 0, 0, 0 );
    var_65f403bd0dfc82ed = distancesquared( self.origin, prevtargetlocation );
    killcament = self.killcament;
    
    while ( true )
    {
        if ( !self )
        {
            if ( killcament )
            {
                killcament delete();
            }
            
            return;
        }
        
        if ( target )
        {
            curtargetlocation = target getpointinbounds( 0, 0, 0 );
        }
        else
        {
            curtargetlocation = prevtargetlocation;
        }
        
        prevtargetlocation = curtargetlocation;
        var_2bffe4cd095fe7a8 = distancesquared( self.origin, curtargetlocation );
        
        if ( var_2bffe4cd095fe7a8 < var_65f403bd0dfc82ed )
        {
            var_65f403bd0dfc82ed = var_2bffe4cd095fe7a8;
        }
        
        if ( var_2bffe4cd095fe7a8 > var_65f403bd0dfc82ed )
        {
            wait 1.8;
            
            if ( self )
            {
                if ( self.killcament )
                {
                    self.killcament delete();
                }
                
                self detonate();
                waitframe();
            }
        }
        
        waitframe();
    }
}

// Namespace drone_formation_swarm
// Params 1, eflags: 0x4
// Checksum 0xfbbcd838, Offset: 0x4176
// Size: 0x1c2
function private function_1d7ec672c9b2bc06( target )
{
    missile = self;
    missile endon( #"death" );
    level endon( #"game_ended" );
    var_2027e64abb16bc7e = undefined;
    
    while ( true )
    {
        if ( !target.origin )
        {
            break;
        }
        
        var_2027e64abb16bc7e = target.origin;
        trace = trace::ray_trace( missile.origin, target.origin, undefined, level.var_8b8da69164d7e6b9.collisioncontents );
        
        if ( trace[ "entity" ] != target && !isdefined( trace[ "entity" ].dronedata ) )
        {
            break;
        }
        
        /#
            if ( getdvarint( @"hash_9dbfc09df178de12", 0 ) > 0 )
            {
                utility::draw_capsule( missile.origin, 10, 10, ( 0, 0, 0 ), ( 1, 0, 0 ), 1, 1 );
                line( missile.origin, target.origin, ( 1, 0, 0 ), 1 );
            }
        #/
        
        waitframe();
    }
    
    if ( var_2027e64abb16bc7e )
    {
        missile missile_cleartarget();
        missile missile_settargetpos( var_2027e64abb16bc7e );
    }
    
    /#
        if ( getdvarint( @"hash_9dbfc09df178de12", 0 ) > 0 )
        {
            while ( true )
            {
                utility::draw_capsule( missile.origin, 10, 10, ( 0, 0, 0 ), ( 0, 1, 0 ), 1, 1 );
                line( missile.origin, var_2027e64abb16bc7e, ( 0, 1, 0 ), 1 );
                waitframe();
            }
        }
    #/
}

// Namespace drone_formation_swarm
// Params 1, eflags: 0x4
// Checksum 0xba915a71, Offset: 0x4340
// Size: 0xa0
function private function_f7e8ccf6645f5281( veh )
{
    missile = self;
    veh endon( #"death" );
    missile waittill( #"death" );
    
    if ( !missile.var_90f42bcfeee48b3 )
    {
        veh function_2984e1cc1b3de267( missile.dronedata );
    }
    
    if ( missile.dronedata.target )
    {
        missile.dronedata.target function_e8e39ea26baf692e();
        missile.dronedata.target = undefined;
    }
}

// Namespace drone_formation_swarm
// Params 1, eflags: 0x4
// Checksum 0x3ac63f5d, Offset: 0x43e8
// Size: 0x1ab
function private function_8fbd471fbcf5580a( target )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    veh = self;
    var_2f4f6b62da96ecf3 = gettime();
    var_d3f18ab219fb8127 = [ self.owner, veh ];
    perfslot = 0;
    var_8d71df1a8ff6d2f3 = function_8fc063681724727f() % 8;
    
    foreach ( dronedata in veh.availabledrones )
    {
        perfslot++;
        
        if ( perfslot % 8 != var_8d71df1a8ff6d2f3 )
        {
            continue;
        }
        
        if ( dronedata.target )
        {
            continue;
        }
        
        if ( dronedata.target == target )
        {
            continue;
        }
        
        if ( dronedata.var_c2b2275272b4b158 >= var_2f4f6b62da96ecf3 )
        {
            continue;
        }
        
        droneorigin = veh gettagorigin( dronedata.tagname );
        trace = trace::ray_trace( droneorigin, target.origin, var_d3f18ab219fb8127, level.var_8b8da69164d7e6b9.collisioncontents );
        
        if ( trace[ "entity" ] != target )
        {
            continue;
        }
        
        dronedata.target = target;
        veh function_eff03e2fbbc986aa( target );
        return dronedata;
    }
}

// Namespace drone_formation_swarm
// Params 1, eflags: 0x4
// Checksum 0x662d36f7, Offset: 0x459b
// Size: 0x68
function private function_945de5086dd5053( dronedata )
{
    veh = self;
    
    if ( dronedata.target )
    {
        dronedata.target function_e8e39ea26baf692e();
    }
    
    dronedata.target = undefined;
    dronedata.var_c2b2275272b4b158 = gettime() + level.var_8b8da69164d7e6b9.var_ca68f807340ec162;
}

// Namespace drone_formation_swarm
// Params 2, eflags: 0x4
// Checksum 0x685350a1, Offset: 0x460b
// Size: 0x226
function private function_5e956ca1f251e3ee( veh, target )
{
    missile = self;
    dronedata = missile.dronedata;
    bundle = veh.owner killstreak::function_85b2d8e857ab4898( "drone_formation_swarm" );
    var_f4c86ef938188cd4 = gettime() + ( bundle.var_7f73b3aa28339eed ?? 3 ) * 1000;
    var_b26234a841a92d13 = ( bundle.var_9c906ba263873ebc ?? 0.25 ) * 1000;
    var_abea9afe7d32eb0e = level.var_8b8da69164d7e6b9.var_fb404cacec3dd6dd * level.var_8b8da69164d7e6b9.var_fb404cacec3dd6dd;
    
    while ( true )
    {
        if ( !missile )
        {
            return;
        }
        
        if ( !target )
        {
            return;
        }
        
        if ( veh.var_2f90c64ece38d4e3 )
        {
            return;
        }
        
        if ( distancesquared( missile.origin, target.origin ) > var_abea9afe7d32eb0e )
        {
            missile.var_26bfd778883feef4 = undefined;
            return;
        }
        
        currtime = gettime();
        
        if ( currtime >= var_f4c86ef938188cd4 - 100 && !missile.var_26bfd778883feef4 )
        {
            missile missile_settargetent( target );
            missile missile_setflightmodedirect();
            missile.var_26bfd778883feef4 = 1;
        }
        
        if ( currtime >= var_f4c86ef938188cd4 )
        {
            if ( !isdefined( target.var_5a3df7cc1cbabf2e ) || currtime > target.var_5a3df7cc1cbabf2e + var_b26234a841a92d13 )
            {
                target.var_5a3df7cc1cbabf2e = currtime;
                dronedata.var_ab64297446d37799 = 1;
                return;
            }
        }
        
        /#
            if ( getdvarint( @"hash_9dbfc09df178de12", 0 ) > 0 )
            {
                utility::draw_capsule( missile.origin, 10, 10, ( 0, 0, 0 ), ( 1, 0.65, 0 ), 1, 1 );
                line( missile.origin, target.origin, ( 1, 0.65, 0 ), 1 );
            }
        #/
        
        waitframe();
    }
}

// Namespace drone_formation_swarm
// Params 1, eflags: 0x4
// Checksum 0x810c4f0a, Offset: 0x4839
// Size: 0xee
function private function_648b479ca87c6922( veh )
{
    missile = self;
    missile endon( #"death" );
    missile missile_cleartarget();
    
    while ( veh )
    {
        tagangles = veh gettagangles( missile.dronedata.tagname );
        
        if ( vectornormalize( missile.angles ) == vectornormalize( tagangles ) )
        {
            break;
        }
        
        waitframe();
    }
    
    if ( veh )
    {
        veh setscriptablepartstate( getxhash( missile.dronedata.tagname ), #"on", 1 );
        veh function_945de5086dd5053( missile.dronedata );
    }
    
    missile.var_90f42bcfeee48b3 = 1;
    
    if ( missile.killcament )
    {
        missile.killcament delete();
    }
    
    missile delete();
}

// Namespace drone_formation_swarm
// Params 1, eflags: 0x4
// Checksum 0x14e8e840, Offset: 0x492f
// Size: 0x35
function private function_2984e1cc1b3de267( dronedata )
{
    veh = self;
    
    if ( dronedata )
    {
        veh.availabledrones[ dronedata.tagnumber ] = undefined;
    }
}

// Namespace drone_formation_swarm
// Params 1, eflags: 0x4
// Checksum 0xdd3e238b, Offset: 0x496c
// Size: 0xe7
function private function_eff03e2fbbc986aa( target )
{
    veh = self;
    
    if ( target )
    {
        bundle = self.owner killstreak::function_85b2d8e857ab4898( "drone_formation_swarm" );
        var_e041b85a7c4f2997 = bundle.var_ad671173c0213e56 ?? 2;
        assert( !isdefined( target.var_8e3d213ca89049db ) || target.var_8e3d213ca89049db < var_e041b85a7c4f2997 );
        
        if ( !isdefined( target.var_8e3d213ca89049db ) )
        {
            target.var_8e3d213ca89049db = 0;
        }
        
        target.var_8e3d213ca89049db += 1;
        
        if ( target.var_8e3d213ca89049db == var_e041b85a7c4f2997 )
        {
            target.var_a736fceede2f3c48 = gettime() + level.var_8b8da69164d7e6b9.var_88735ec78eb56276;
        }
    }
}

// Namespace drone_formation_swarm
// Params 0, eflags: 0x4
// Checksum 0xc4eb7760, Offset: 0x4a5b
// Size: 0x52
function private function_e8e39ea26baf692e()
{
    target = self;
    
    if ( target.var_8e3d213ca89049db )
    {
        target.var_8e3d213ca89049db -= 1;
        
        if ( target.var_8e3d213ca89049db == 0 )
        {
            target.var_8e3d213ca89049db = undefined;
        }
    }
}

// Namespace drone_formation_swarm
// Params 2, eflags: 0x4
// Checksum 0x47e538e5, Offset: 0x4ab5
// Size: 0xa5
function private clear_target_drone_count( flightcenter, var_fb404cacec3dd6dd )
{
    targets = getplayersandaiarrayinradius( flightcenter, var_fb404cacec3dd6dd );
    
    foreach ( target in targets )
    {
        target.var_8e3d213ca89049db = undefined;
        target.var_374b12304be35ea8 = undefined;
    }
}

// Namespace drone_formation_swarm
// Params 1, eflags: 0x4
// Checksum 0xc605925, Offset: 0x4b62
// Size: 0x34
function private function_adfd5d56653d5bf( tagnumber )
{
    return getxhash( "tag_drone_attach_" + ( tagnumber < 10 ? "00" : "0" ) + tagnumber + "_d0" );
}

// Namespace drone_formation_swarm
// Params 1, eflags: 0x4
// Checksum 0xe20c1cb8, Offset: 0x4b9f
// Size: 0x34
function private function_bb31a2c49f76f55e( tagnumber )
{
    return getxhash( "tag_drone_attach_" + ( tagnumber < 10 ? "00" : "0" ) + tagnumber + "_d0_light" );
}

// Namespace drone_formation_swarm
// Params 1, eflags: 0x4
// Checksum 0xea13daf, Offset: 0x4bdc
// Size: 0x1f2
function private drone_formation_swarm_missile_spawn( dronedata )
{
    veh = self;
    target = dronedata.target;
    tagpos = veh gettagorigin( dronedata.tagname );
    obj = makeweapon( level.var_8b8da69164d7e6b9.projweapon );
    missile = namespace_9d8e359c3b1041e5::magicbulletsharedfunc( obj, tagpos, target.origin, veh.owner ?? undefined );
    
    /#
        if ( getdvarint( @"hash_151bfe36ac5e512e", 0 ) > 0 )
        {
            if ( !isdefined( level.var_8b8da69164d7e6b9.missiles ) )
            {
                level.var_8b8da69164d7e6b9.missiles = [];
            }
            
            if ( !isdefined( level.var_8b8da69164d7e6b9.missiles ) )
            {
                level.var_8b8da69164d7e6b9.missiles = [];
            }
            
            level.var_8b8da69164d7e6b9.missiles[ level.var_8b8da69164d7e6b9.missiles.size ] = missile;
        }
    #/
    
    missile.streakinfo = veh.streakinfo;
    missile.angles = veh gettagangles( dronedata.tagname );
    missile function_978b547c26b0c99( veh );
    missile setcandamage( 1 );
    missile.dronedata = dronedata;
    missile.health = int( veh vehicle_damage::function_2673f58d98e0d40b( dronedata.tagname ) );
    missile thread function_924e55b60eedbdb( veh );
    missile linkto( veh, dronedata.tagname );
    missile enableplayermarks( #"air_killstreak" );
    
    /#
        if ( getdvarint( @"hash_103c4a39d909274a", 0 ) > 0 )
        {
            missile thread debug_draw_missile_speed();
        }
    #/
    
    return missile;
}

// Namespace drone_formation_swarm
// Params 1, eflags: 0x4
// Checksum 0x49df9e2d, Offset: 0x4dd7
// Size: 0x218
function private function_924e55b60eedbdb( veh )
{
    missile = self;
    level endon( #"game_ended" );
    veh endon( #"death" );
    hitmarkertype = "hitequip";
    iscriticaldamage = 0;
    targetent = missile getentitynumber();
    
    while ( true )
    {
        missile waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor, time );
        var_cf8e9b1ae515338 = missile.owner && attacker == missile.owner;
        
        if ( !isplayer( attacker ) || self.team && attacker.team && self.team == attacker.team && !var_cf8e9b1ae515338 )
        {
            continue;
        }
        
        damageisfatal = missile.health <= 0;
        
        if ( isdefined( attacker ) )
        {
            var_7731d58f6f82f082 = { #mod:meansofdeath, #direction_vec:direction_vec, #point:point, #objweapon:objweapon, #victim:missile };
            attacker damagefeedback::updatedamagefeedback( hitmarkertype, damageisfatal, iscriticaldamage, "hitequip", undefined, 1, targetent, undefined, undefined, var_7731d58f6f82f082 );
            
            if ( damageisfatal )
            {
                if ( !var_cf8e9b1ae515338 )
                {
                    attacker thread points::doscoreevent( #"destroyed_drone_formation_swarm", objweapon );
                }
                
                return;
            }
        }
        
        if ( damageisfatal )
        {
            return;
        }
    }
}

// Namespace drone_formation_swarm
// Params 1, eflags: 0x4
// Checksum 0x200e5cb1, Offset: 0x4ff7
// Size: 0xf6
function private drone_formation_swarm_watchgameended( streakinfo )
{
    self endon( #"disconnect" );
    level waittill( #"game_ended" );
    
    if ( isplayer( self ) && streakinfo )
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"killstreak" ][ #"hash_bf17c172d25e8b3d" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            self [[ var_32dbca3143d9c4a5 ]]( streakinfo );
        }
    }
    
    wait 0.1;
    
    foreach ( veh in self.var_8b8da69164d7e6b9.vehicles )
    {
        veh notify( #"vSXmPNBRsboHejvxmSYB" );
        waitframe();
    }
}

/#

    // Namespace drone_formation_swarm
    // Params 0
    // Checksum 0x38aea2f7, Offset: 0x50f5
    // Size: 0x1ea, Type: dev
    function function_6f27bdfa85d0c11d()
    {
        level endon( #"game_ended" );
        targetents = [];
        
        foreach ( veh in level.var_8b8da69164d7e6b9.vehicles )
        {
            foreach ( dronedata in veh.availabledrones )
            {
                if ( dronedata.target )
                {
                    entnum = dronedata.target getentitynumber();
                    
                    if ( !isdefined( targetents[ entnum ] ) )
                    {
                        targetents[ entnum ] = 0;
                    }
                    
                    targetents[ entnum ] += 1;
                }
            }
        }
        
        foreach ( player in level.players )
        {
            if ( player )
            {
                entnum = player getentitynumber();
                assert( !isdefined( player.var_8e3d213ca89049db ) || player.var_8e3d213ca89049db == targetents[ entnum ] );
            }
        }
    }

    // Namespace drone_formation_swarm
    // Params 1
    // Checksum 0xd7db82f4, Offset: 0x52e7
    // Size: 0xaa, Type: dev
    function function_4b81f17014fb1517( target )
    {
        missile = self;
        missile endon( #"death" );
        target endon( #"death" );
        level endon( #"game_ended" );
        
        while ( true )
        {
            color = ( 1, 0, 0 );
            line( missile.origin, target.origin, color, 1 );
            utility::draw_capsule( missile.origin, 10, 10, ( 0, 0, 0 ), color, 1, 1 );
            waitframe();
        }
    }

    // Namespace drone_formation_swarm
    // Params 0
    // Checksum 0xd3667ed1, Offset: 0x5399
    // Size: 0x29, Type: dev
    function function_e296b4859ffce185()
    {
        utility::draw_circle( self.origin, 50, ( 0, 1, 0 ), 1, 0, 1 );
    }

    // Namespace drone_formation_swarm
    // Params 0
    // Checksum 0x9974ba55, Offset: 0x53ca
    // Size: 0xdc, Type: dev
    function debug_draw_vehicle_speed()
    {
        self notify( #"hash_8e7f110c90fbb307" );
        self endon( #"hash_8e7f110c90fbb307" );
        veh = self;
        veh endon( #"death" );
        
        while ( veh )
        {
            prevorigin = veh.origin;
            waitframe();
            distinches = distance( veh.origin, prevorigin );
            timesec = level.framedurationseconds;
            speedips = distinches / timesec;
            speedmph = int( speedips * 0.056818 );
            print3d( veh.origin + ( 0, 0, 100 ), speedmph, ( 1, 0, 0 ), 1, 5, 1, 1 );
        }
    }

    // Namespace drone_formation_swarm
    // Params 0
    // Checksum 0xf0e53faf, Offset: 0x54ae
    // Size: 0xfb, Type: dev
    function debug_draw_missile_speed()
    {
        self notify( #"hash_635ba42bda8baa83" );
        self endon( #"hash_635ba42bda8baa83" );
        missile = self;
        missile endon( #"death" );
        
        while ( missile )
        {
            prevorigin = missile.origin;
            t = gettime();
            waitframe();
            distinches = distance( missile.origin, prevorigin );
            timesec = level.framedurationseconds;
            speedips = distinches / timesec;
            speedmph = int( speedips * 0.056818 );
            dt = gettime() - t;
            print3d( missile.origin + ( 0, 0, 100 ), speedmph, ( 1, 0, 0 ), 1, 5, 1, 1 );
        }
    }

    // Namespace drone_formation_swarm
    // Params 0
    // Checksum 0x5586dba, Offset: 0x55b1
    // Size: 0x4f, Type: dev
    function debug_draw_vehicle_position()
    {
        veh = self;
        
        while ( veh )
        {
            utility::draw_capsule( veh.origin, 50, 50, ( 0, 0, 0 ), ( 0, 0, 1 ), 1, 1 );
            waitframe();
        }
    }

    // Namespace drone_formation_swarm
    // Params 2
    // Checksum 0x20c27410, Offset: 0x5608
    // Size: 0x70, Type: dev
    function function_e5a28653440198c0( attachradius, flightcenter )
    {
        veh = self;
        veh endon( #"loiter_end" );
        veh endon( #"death" );
        level endon( #"game_ended" );
        
        while ( veh )
        {
            utility::draw_circle( flightcenter, attachradius, ( 1, 0, 0 ), 1, 0, 1 );
            waitframe();
        }
    }

    // Namespace drone_formation_swarm
    // Params 0
    // Checksum 0xa3579ca5, Offset: 0x5680
    // Size: 0x8d, Type: dev
    function function_bd964012b2ff1ebe()
    {
        veh = self;
        veh endon( #"loiter_end" );
        veh endon( #"death" );
        level endon( #"game_ended" );
        
        while ( veh )
        {
            prevorigin = veh.origin;
            waitframe();
            
            if ( veh )
            {
                line( veh.origin, prevorigin, ( 0, 0, 1 ), 1, 0, 500 );
                prevorigin = veh.origin;
            }
        }
    }

    // Namespace drone_formation_swarm
    // Params 0
    // Checksum 0x1a22c514, Offset: 0x5715
    // Size: 0xdc, Type: dev
    function function_28123691afbf70cc()
    {
        veh = self;
        veh endon( #"loiter_end" );
        veh endon( #"death" );
        level endon( #"game_ended" );
        var_4234ca4760eaa181 = 500;
        mapradius = level.mapsize * 0.5;
        utility::draw_capsule( level.mapcenter, 50, 500, ( 0, 0, 0 ), ( 1, 0, 0 ), 1, var_4234ca4760eaa181 );
        
        while ( var_4234ca4760eaa181 > 0 )
        {
            var_4234ca4760eaa181--;
            groundpos = function_ff9a943d53d50d59( mapradius );
            utility::draw_capsule( groundpos, 50, 50, ( 0, 0, 0 ), ( 0, 0, 1 ), 1, var_4234ca4760eaa181 );
            waitframe();
        }
    }

    // Namespace drone_formation_swarm
    // Params 0
    // Checksum 0xcb0d6b73, Offset: 0x57f9
    // Size: 0xb5, Type: dev
    function function_3829a24a685a6675()
    {
        veh = self;
        veh endon( #"loiter_end" );
        veh endon( #"death" );
        level endon( #"game_ended" );
        mapradius = level.mapsize * 0.5;
        
        while ( veh )
        {
            utility::draw_capsule( veh.flightcenter, 50, 2000, ( 0, 0, 0 ), ( 0, 0, 1 ), 1, 1 );
            utility::draw_circle( veh.flightcenter, mapradius, ( 1, 0, 0 ), 1, 0, 1 );
            waitframe();
        }
    }

    // Namespace drone_formation_swarm
    // Params 2
    // Checksum 0x78f6bde3, Offset: 0x58b6
    // Size: 0x1aa, Type: dev
    function debug_draw_next_position( nextpos, var_9d800cdf765e0a1b )
    {
        veh = self;
        veh endon( #"loiter_end" );
        veh endon( #"death" );
        level endon( #"game_ended" );
        bundle = self.owner killstreak::function_85b2d8e857ab4898( "<dev string:x65>" );
        loiterduration = bundle.var_5255569767b951d8 ?? 30;
        loiterendtime = gettime() * 0.001 + loiterduration;
        startpos = veh.origin;
        var_d96ebe54b98495ed = gettime() * 0.001 + var_9d800cdf765e0a1b;
        var_66bd2050446e3951 = int( ( loiterendtime - gettime() * 0.001 ) * 1000 );
        
        while ( gettime() * 0.001 < min( loiterendtime, var_d96ebe54b98495ed ) )
        {
            utility::draw_capsule( nextpos, 50, 50, ( 0, 0, 0 ), ( 1, 0, 0 ), 0, 1 );
            line( startpos, veh.origin, ( 1, 0, 0 ), 1, 0, 1 );
            line( veh.origin, nextpos, ( 1, 1, 1 ), 1, 0, 1 );
            waitframe();
        }
        
        while ( gettime() * 0.001 < loiterendtime )
        {
            line( startpos, nextpos, ( 1, 0, 0 ), 1, 0, 1 );
            waitframe();
        }
    }

#/
