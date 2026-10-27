// scripts\mp\common\killstreaks\switchblade_drone.gsc  (hash_36b82af4b595e5b7.gscc) (size: 21122 Bytes / 0x5282 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2dd936ad (769210029)
// size ...... 21122 (0x5282)
// includes .. 15  (offset: 0x4d1a)
// strings ... 78  (offset: 0x4d92)
// dev strs .. 2   (offset: 0x526a)
// exports ... 33  (offset: 0x3622)
// cseg ...... 0x606 + 0x301c (0x3622)
// imports ... 133 (offset: 0x3b4a)
// animtree1 . 0   (offset: 0x5282)
// animtree2 . 0   (offset: 0x5282)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\functionals_utility;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\math;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\equipment\haywire;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\emp_debuff;
#using scripts\mp\objidpoolmanager;

#namespace switchblade_drone;

// Namespace switchblade_drone
// Params 0, eflags: 0x1
// Checksum 0xd2e711ab, Offset: 0x624
// Size: 0x17
function autoexec main()
{
    killstreak_shared::registerkillstreakinitfunction( getxhash( "switchblade_drone" ), &init );
}

// Namespace switchblade_drone
// Params 0, eflags: 0x4
// Checksum 0xe86ad728, Offset: 0x643
// Size: 0x134
function private init()
{
    if ( utility::issharedfuncdefined( #"switchblade_drone", #"init" ) )
    {
        [[ utility::getsharedfunc( #"switchblade_drone", #"init" ) ]]();
    }
    
    if ( utility::issharedfuncdefined( #"killstreak", #"registerkillstreak" ) )
    {
        [[ utility::getsharedfunc( #"killstreak", #"registerkillstreak" ) ]]( "switchblade_drone", &tryuseswitchbladedrone );
    }
    
    utility::registersharedfunc( "switchblade_drone", #"tryusekillstreak", &tryuseswitchbladedrone );
    switchblade_drone_initdvars();
    function_ddff2c6adccfae21();
    val::group_register( "switchbladeDrone_deploy", [ "melee", "offhand_weapons", "sprint", "weapon_switch" ] );
    bundle = level.streakglobals.streakbundles[ "switchblade_drone" ];
    namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( "switchblade_drone", bundle.var_74199c73017aa0db, #"donotregister" );
    level.var_5c437b4bacee8b92 = 0;
    level.var_582606b02cd15adc = [];
    level.switchbladedrones = [];
}

// Namespace switchblade_drone
// Params 0
// Checksum 0x8e93df3d, Offset: 0x77f
// Size: 0x1b2
function switchblade_drone_initdvars()
{
    setdvarifuninitialized( @"hash_b171aaba052d2c50", 5 );
    setdvarifuninitialized( @"hash_cda65d1126957523", 1 );
    setdvarifuninitialized( @"hash_7ad66a5bc22f0e3c", 0.4 );
    setdvarifuninitialized( @"hash_fec9a646e847f81b", 0.3 );
    setdvarifuninitialized( @"hash_bb25bfbed73b667b", 0.15 );
    setdvarifuninitialized( @"hash_aea510623d9c4c10", 1250 );
    setdvarifuninitialized( @"hash_79f9928723395f7f", -90 );
    setdvarifuninitialized( @"scr_switchblade_drone_velocity", 300 );
    setdvarifuninitialized( @"hash_7bd25800dfc29105", 65 );
    setdvarifuninitialized( @"hash_832a4160ba33c74b", 12 );
    setdvarifuninitialized( @"hash_57306177bd6ed859", 20 );
    setdvarifuninitialized( @"hash_fa505002fe5586de", 10 );
    setdvarifuninitialized( @"hash_636a1d843f1957eb", 7 );
    setdvarifuninitialized( @"hash_f10e873f6059cd5f", 20 );
    setdvarifuninitialized( @"hash_a80f427a9d36e9fe", 75 );
    setdvarifuninitialized( @"hash_d40e17bd9fa003a1", 35 );
    setdvarifuninitialized( @"hash_836eeca87d3a3d6f", 500 );
    setdvarifuninitialized( @"hash_fc2d155242a3fc25", 800 );
    setdvarifuninitialized( @"hash_1da226fe14849c74", 800 );
    setdvarifuninitialized( @"hash_22f1ccc4024de95e", 600 );
    setdvarifuninitialized( @"hash_deabefeda3824f1d", 1000 );
    setdvarifuninitialized( @"hash_c17694dce62bf907", 1000 );
    setdvarifuninitialized( @"hash_b9597bb5bad14e63", 50 );
    setdvarifuninitialized( @"scr_switchblade_drone_debug_duration", 500 );
    setdvarifuninitialized( @"hash_b0c1d0793ae379c7", 0 );
    setdvarifuninitialized( @"scr_switchblade_drone_debug", 0 );
}

// Namespace switchblade_drone
// Params 0
// Checksum 0x7db46c6f, Offset: 0x939
// Size: 0x61
function function_ddff2c6adccfae21()
{
    game[ "dialog" ][ "switchblade_ause" ] = "ause";
    game[ "dialog" ][ "switchblade_euse" ] = "euse";
    game[ "dialog" ][ "switchblade_lcra" ] = "lcra";
    game[ "dialog" ][ "switchblade_ltim" ] = "ltim";
    game[ "dialog" ][ "switchblade_earn" ] = "earn";
}

// Namespace switchblade_drone
// Params 1
// Checksum 0xf475e13f, Offset: 0x9a2
// Size: 0x146
function tryuseswitchbladedrone( streakinfo = killstreak_utility::createstreakinfo( "switchblade_drone", self ) )
{
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            return 0;
        }
    }
    
    if ( !function_f1954168d8525dfb() )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( "KILLSTREAKS/SWITCHBLADE_COUNT_OVER_LIMIT" );
        }
        
        return 0;
    }
    
    bundle = level.streakglobals.streakbundles[ "switchblade_drone" ];
    val::set( "switchbladeDrone", "usability", 0 );
    deployweaponobj = makeweapon( bundle.var_74199c73017aa0db );
    deployresult = killstreakdeploy::streakdeploy_doweaponfireddeploy( streakinfo, deployweaponobj, "grenade_fire", undefined, &function_a3f3dcf1acda73f6, &function_1f60c0f597463c24 );
    
    if ( !deployresult )
    {
        val::reset( "switchbladeDrone", "usability" );
        return;
    }
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            return 0;
        }
    }
    
    val::reset( "switchbladeDrone", "usability" );
    return 1;
}

// Namespace switchblade_drone
// Params 0
// Checksum 0xfdea71d9, Offset: 0xaf1
// Size: 0x190, Type: bool
function function_f1954168d8525dfb()
{
    bundle = level.streakglobals.streakbundles[ "switchblade_drone" ];
    dronelist = level.switchbladedrones;
    var_891e39780574a410 = 0;
    var_ec8dae01dc8e3c57 = 0;
    
    if ( !isdefined( level.var_582606b02cd15adc[ self.team ] ) )
    {
        level.var_582606b02cd15adc[ self.team ] = 0;
    }
    
    foreach ( key, drone in dronelist )
    {
        if ( !isdefined( drone ) )
        {
            level.switchbladedrones[ key ] = undefined;
            continue;
        }
        
        if ( drone.owner == self )
        {
            var_ec8dae01dc8e3c57++;
            var_891e39780574a410++;
            continue;
        }
        
        if ( drone.team == self.team )
        {
            var_891e39780574a410++;
        }
    }
    
    if ( level.switchbladedrones.size + level.var_5c437b4bacee8b92 > bundle.var_c3ffd77ea024a733 )
    {
        return false;
    }
    
    if ( var_891e39780574a410 + level.var_582606b02cd15adc[ self.team ] > bundle.var_5d911f8b15173a8 )
    {
        return false;
    }
    
    if ( var_ec8dae01dc8e3c57 >= bundle.var_dbe507f17c20cde4 )
    {
        return false;
    }
    
    return true;
}

// Namespace switchblade_drone
// Params 2
// Checksum 0xd97d03ea, Offset: 0xc8a
// Size: 0x55
function function_a3f3dcf1acda73f6( streakinfo, switchresult )
{
    if ( switchresult )
    {
        level.var_5c437b4bacee8b92++;
        level.var_582606b02cd15adc[ self.team ]++;
        thread function_7392dfec8331a281();
        thread switchblade_drone_watchplayerweapon( streakinfo );
        val::group_set( "switchbladeDrone_deploy", 0 );
    }
}

// Namespace switchblade_drone
// Params 0
// Checksum 0x38d1d5d6, Offset: 0xce7
// Size: 0xb2
function function_7392dfec8331a281()
{
    self endon( #"disconnect" );
    self endon( #"cancel_deploy" );
    self endon( #"weapon_switch_started" );
    self endon( #"grenade_fire" );
    self endon( #"death" );
    self notifyonplayercommand( "attempt_fire", "+attack" );
    
    while ( true )
    {
        self waittill( #"attempt_fire" );
        
        if ( !self function_7d9030f26f9e9820() )
        {
            if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
            {
                self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"killstreaks/cannot_be_placed" );
            }
        }
        
        wait 0.1;
    }
}

// Namespace switchblade_drone
// Params 1
// Checksum 0xf3b70f66, Offset: 0xda1
// Size: 0x160
function switchblade_drone_watchplayerweapon( streakinfo )
{
    self endon( #"disconnect" );
    self endon( #"grenade_fire" );
    
    if ( !isbot( self ) )
    {
        self notifyonplayercommand( "cancel_deploy", "+actionslot 3" );
        self notifyonplayercommand( "cancel_deploy", "+actionslot 4" );
        self notifyonplayercommand( "cancel_deploy", "+actionslot 5" );
        self notifyonplayercommand( "cancel_deploy", "+actionslot 6" );
        self notifyonplayercommand( "cancel_deploy", "killstreak1" );
        self notifyonplayercommand( "cancel_deploy", "killstreak2" );
        self notifyonplayercommand( "cancel_deploy", "killstreak3" );
        self notifyonplayercommand( "cancel_deploy", "killstreak4" );
        self notifyonplayercommand( "cancel_deploy", "+weapprev" );
        self notifyonplayercommand( "cancel_deploy", "+weapnext" );
        self notifyonplayercommand( "cancel_deploy", "selectweapon1" );
        self notifyonplayercommand( "cancel_deploy", "selectweapon2" );
    }
    
    result = utility::waittill_any_return( "cancel_deploy", "weapon_switch_started" );
    val::group_reset( "switchbladeDrone_deploy" );
    
    if ( !isdefined( result ) )
    {
        return;
    }
    
    self allowfire( 1 );
    self.blockingfire = 0;
    streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
    wait 0.5;
    level.var_5c437b4bacee8b92--;
    level.var_582606b02cd15adc[ self.team ]--;
}

// Namespace switchblade_drone
// Params 3
// Checksum 0xdcb5ee90, Offset: 0xf09
// Size: 0x5dc
function function_1f60c0f597463c24( streakinfo, weaponobj, projectile )
{
    var_e7de05a59523ded8 = 0;
    switchblade_drone = function_42dffc3cd44eb381( projectile );
    bundle = level.streakglobals.streakbundles[ "switchblade_drone" ];
    
    if ( !isdefined( switchblade_drone ) )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( "KILLSTREAKS/SWITCHBLADE_DRONE_CANNOT_BE_USED" );
        }
        
        function_891286cd2d83cfd( weaponobj );
        level.var_5c437b4bacee8b92--;
        level.var_582606b02cd15adc[ self.team ]--;
        return "continue";
    }
    
    if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) )
    {
        self thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( "used_" + "switchblade_drone", self );
    }
    
    switchblade_drone emp_debuff::set_apply_emp_callback( &switchblade_drone_empapplied );
    
    if ( level.killstreak_emp_initialized )
    {
        switchblade_drone.ksempapplycallback = &switchblade_drone_empapplied;
    }
    
    switchblade_drone haywire::function_7f69a1eb3d590f76( &switchblade_drone_haywireapplied );
    var_e7de05a59523ded8 = switchblade_drone function_bb4c3b83ccb10112();
    
    if ( !var_e7de05a59523ded8 )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"KILLSTREAKS/SWITCHBLADE_DRONE_CANNOT_BE_USED" );
        }
        
        function_891286cd2d83cfd( weaponobj );
        
        if ( bundle.var_e896a6e2245b8dc5 )
        {
            switchblade_drone functionals_utility::clearminimapid();
        }
        
        switchblade_drone thread function_86274791b06a03e4( 1 );
        level.var_5c437b4bacee8b92--;
        level.var_582606b02cd15adc[ self.team ]--;
        return "continue";
    }
    
    level.switchbladedrones[ level.switchbladedrones.size ] = switchblade_drone;
    level.var_5c437b4bacee8b92--;
    level.var_582606b02cd15adc[ self.team ]--;
    
    if ( utility::issharedfuncdefined( #"killstreak", #"addtoactivekillstreaklist" ) )
    {
        switchblade_drone [[ utility::getsharedfunc( #"killstreak", #"addtoactivekillstreaklist" ) ]]( streakinfo.streakname, "Killstreak_Air", self, 0, 1, 100 );
    }
    
    switchblade_drone.streakinfo = streakinfo;
    var_74066f7d48ba5a99 = getdvarfloat( @"hash_7ad66a5bc22f0e3c" );
    wait var_74066f7d48ba5a99;
    var_f8ae09889dbd22a = getdvarfloat( @"hash_fec9a646e847f81b" );
    var_e97028e46b6178b2 = getdvarfloat( @"hash_bb25bfbed73b667b" );
    thread function_891286cd2d83cfd( weaponobj, var_f8ae09889dbd22a, var_e97028e46b6178b2 );
    
    if ( isdefined( switchblade_drone ) )
    {
        switchblade_drone.targetorigin = switchblade_drone.origin;
        var_e7de05a59523ded8 = switchblade_drone function_bb4c3b83ccb10112();
    }
    else
    {
        if ( utility::issharedfuncdefined( #"switchblade_drone", #"munitionused" ) )
        {
            self [[ utility::getsharedfunc( #"switchblade_drone", #"munitionused" ) ]]();
        }
        
        return "success";
    }
    
    params = spawnstruct();
    params.fromtrigger = 0;
    switchblade_drone thread functionals_utility::functionals_timeout( bundle.dronelifetime, @"scr_switchblade_drone_debug", &switchblade_drone_timeout, params );
    switchblade_drone functionals_utility::function_f9c3bc385df6f245( streakinfo, &function_2fd31dd9e3c72c80 );
    switchblade_drone setscriptablepartstate( "lockedOn", "activate", 0 );
    switchblade_drone.vodestroyed = "switchblade_drone_teamleader_destroyed";
    switchblade_drone.streakname = "switchblade_drone";
    switchblade_drone.streakinfo = streakinfo;
    
    if ( bundle.candamage && utility::issharedfuncdefined( #"damage", #"monitordamage" ) )
    {
        switchblade_drone thread [[ utility::getsharedfunc( #"damage", #"monitordamage" ) ]]( bundle.maxhealth, "hitequip", &functionals_utility::functionals_handlefataldamage, &functionals_utility::functionals_handledamage, 0 );
    }
    
    if ( utility::issharedfuncdefined( #"sound", #"playkillstreakdeploydialog" ) )
    {
        switchblade_drone.owner [[ utility::getsharedfunc( #"sound", #"playkillstreakdeploydialog" ) ]]( streakinfo.streakname );
    }
    
    if ( isdefined( bundle ) && isdefined( bundle.dangerzoneheight ) && !bundle.var_cdb412d03773acb7 )
    {
        var_f8068b0b6432fcdf = switchblade_drone.centerpos - ( 0, 0, bundle.dangerzoneheight );
        switchblade_drone killstreak_utility::function_e6fc48237c0a5166( #"hash_eafb9a6b88def4ca", var_f8068b0b6432fcdf, switchblade_drone.team, switchblade_drone.owner );
    }
    
    self endon( #"death" );
    self endon( #"disconnect" );
    switchblade_drone_velocity = getdvarint( @"scr_switchblade_drone_velocity" );
    switchblade_drone thread function_1e637d2988bab39b( switchblade_drone.centerpos, switchblade_drone.startpos, switchblade_drone_velocity );
    switchblade_drone thread function_774b08d19c5893ec();
    switchblade_drone thread function_275fcb5acd73ea13();
    
    if ( bundle.var_68f30e7a3a59ee78 )
    {
        switchblade_drone thread function_f2a4a24c41351e69( "notify_switchblade_drone_explode", bundle.dronelifetime, bundle.dronemaxradius, bundle.var_91f7fa4d8870a52a, bundle.var_265f2d3f9f98a8a );
    }
    
    if ( isdefined( switchblade_drone ) )
    {
        switchblade_drone thread function_d353828f3fe83995();
    }
    
    if ( utility::issharedfuncdefined( #"switchblade_drone", #"munitionused" ) )
    {
        self [[ utility::getsharedfunc( #"switchblade_drone", #"munitionused" ) ]]();
    }
    
    return "success";
}

// Namespace switchblade_drone
// Params 3
// Checksum 0x1b9c8527, Offset: 0x14ee
// Size: 0xb5
function function_891286cd2d83cfd( weaponobj, swapdelay, takedelay )
{
    if ( isdefined( takedelay ) )
    {
        wait takedelay;
    }
    
    val::group_reset( "switchbladeDrone_deploy" );
    
    if ( !isdefined( self.lastdroppableweaponobj ) || !self hasweapon( self.lastdroppableweaponobj ) )
    {
        lastweaponobj = level.defaultfist;
    }
    else
    {
        var_834e1ea1f94aef8a = getdvarint( @"hash_dba4a054e67dd255", 0 ) == 1;
        lastweaponobj = weapon_utility::restoreweaponstates( self.lastdroppableweaponobj, var_834e1ea1f94aef8a );
    }
    
    if ( isdefined( swapdelay ) )
    {
        wait swapdelay;
    }
    
    inventory_utility::_switchtoweaponimmediate( lastweaponobj );
    inventory_utility::_takeweapon( weaponobj );
}

// Namespace switchblade_drone
// Params 1
// Checksum 0x4a7cd219, Offset: 0x15ab
// Size: 0x3c
function function_86274791b06a03e4( isswitchblade )
{
    self hide();
    
    if ( isswitchblade )
    {
        level.switchbladedrones = arrayremove( level.switchbladedrones, self );
    }
    
    wait 1;
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace switchblade_drone
// Params 1
// Checksum 0x3bbb570e, Offset: 0x15ef
// Size: 0x284
function function_42dffc3cd44eb381( grenade )
{
    grenade thread function_86274791b06a03e4();
    var_74066f7d48ba5a99 = getdvarfloat( @"hash_7ad66a5bc22f0e3c" );
    facingangles = self getgunangles();
    launchpoint = grenade.origin;
    startpointdistance = 100;
    endpointdistance = 1250 * var_74066f7d48ba5a99;
    expectedstartpoint = launchpoint + anglestoforward( facingangles ) * startpointdistance;
    expectedendpoint = launchpoint + anglestoforward( facingangles ) * endpointdistance;
    startvelocity = anglestoforward( facingangles ) * 1250;
    collisioncontents = physics_createcontents( [ "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot" ] );
    tracehit = physics_raycast( self gettagorigin( "tag_eye" ), expectedstartpoint, collisioncontents, self, 0, "physicsquery_any" );
    
    if ( tracehit )
    {
        return;
    }
    
    bundle = level.streakglobals.streakbundles[ "switchblade_drone" ];
    switchblade_drone = self launchgrenade( bundle.droneweapon, expectedstartpoint, startvelocity );
    switchblade_drone setscriptablepartstate( "visibility", "show" );
    switchblade_drone.angles = grenade.angles;
    switchblade_drone.team = self.team;
    switchblade_drone.owner = self;
    switchblade_drone.targetorigin = expectedendpoint;
    
    if ( bundle.var_e896a6e2245b8dc5 && utility::issharedfuncdefined( #"game", #"createobjective" ) )
    {
        switchblade_drone.minimapid = switchblade_drone [[ utility::getsharedfunc( #"game", #"createobjective" ) ]]( bundle.minimapicon, switchblade_drone.team, 1, 1, 1 );
        objidpoolmanager::update_objective_description( switchblade_drone.minimapid, &"killstreaks/switchblade_drone" );
        
        if ( level.streakglobals.var_3feb5f5305e6fe83 )
        {
            function_46a5a0ae8a411d8d( switchblade_drone.minimapid, bundle.var_77216bac95c39355 );
            function_a9992b78cd05e28b( switchblade_drone.minimapid, bundle.var_4d7d4b6afc661107 );
            function_82408b23a25468f3( switchblade_drone.minimapid, expectedendpoint );
        }
    }
    
    return switchblade_drone;
}

// Namespace switchblade_drone
// Params 2
// Checksum 0xec10db97, Offset: 0x187c
// Size: 0x2fc
function function_bb4c3b83ccb10112( streakname, location )
{
    level notify( #"hash_363cdbbb6d7377d" );
    level endon( #"game_ended" );
    
    if ( !isdefined( location ) )
    {
        self endon( #"death" );
    }
    
    if ( !isdefined( streakname ) )
    {
        streakname = "switchblade_drone";
    }
    
    bundle = level.streakglobals.streakbundles[ streakname ];
    var_26981f5fbe8fc77d = getdvarint( @"hash_a80f427a9d36e9fe" );
    var_c68a2e573fb94f1c = getdvarint( @"hash_f10e873f6059cd5f" );
    var_1c4ae8897bda6a2b = getdvarint( @"hash_b171aaba052d2c50" );
    debugactive = getdvarint( @"scr_switchblade_drone_debug" );
    dvar_debug_duration = getdvarint( @"scr_switchblade_drone_debug_duration" );
    radius = bundle.dronemaxradius;
    height = bundle.droneminheight;
    centerpos = undefined;
    launchheight = undefined;
    
    if ( isdefined( location ) )
    {
        centerpos = location;
        launchheight = location[ 2 ];
    }
    else
    {
        centerpos = self.targetorigin;
        launchheight = self.targetorigin[ 2 ];
    }
    
    contents = physics_createcontents( [ "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_glass", "physicscontents_ainoshoot" ] );
    var_e7de05a59523ded8 = 0;
    
    while ( !var_e7de05a59523ded8 )
    {
        radiusvector = ( radius + var_1c4ae8897bda6a2b, radius + var_1c4ae8897bda6a2b, var_1c4ae8897bda6a2b );
        centerpos = ( centerpos[ 0 ], centerpos[ 1 ], launchheight + height );
        aabbmin = centerpos - radiusvector;
        aabbmax = centerpos + radiusvector;
        hits = physics_aabbquery( aabbmin, aabbmax, contents, [], "physicsquery_all" );
        
        /#
            if ( debugactive > 0 )
            {
                functionals_utility::function_3fd21b027afc9a0e( aabbmin, aabbmax, dvar_debug_duration );
            }
        #/
        
        if ( hits.size == 0 )
        {
            var_e7de05a59523ded8 = 1;
        }
        
        while ( !var_e7de05a59523ded8 && height <= bundle.dronemaxheight )
        {
            height += var_26981f5fbe8fc77d;
            centerpos = ( centerpos[ 0 ], centerpos[ 1 ], launchheight + height );
            aabbmin = centerpos - radiusvector;
            aabbmax = centerpos + radiusvector;
            hits = physics_aabbquery( aabbmin, aabbmax, contents, [], "physicsquery_all" );
            
            /#
                if ( debugactive > 0 )
                {
                    functionals_utility::function_3fd21b027afc9a0e( aabbmin, aabbmax, dvar_debug_duration );
                }
            #/
            
            if ( hits.size == 0 )
            {
                var_e7de05a59523ded8 = 1;
                break;
            }
        }
        
        if ( var_e7de05a59523ded8 && !isdefined( location ) )
        {
            startlocation = centerpos + anglestoforward( self.angles ) * radius;
            self.startpos = startlocation;
            self.centerpos = centerpos;
            continue;
        }
        
        if ( !var_e7de05a59523ded8 && radius >= bundle.droneminradius + var_c68a2e573fb94f1c )
        {
            radius -= var_c68a2e573fb94f1c;
            height = bundle.droneminheight;
            continue;
        }
        
        break;
    }
    
    return var_e7de05a59523ded8;
}

// Namespace switchblade_drone
// Params 0
// Checksum 0x328f3624, Offset: 0x1b81
// Size: 0x1e7
function function_774b08d19c5893ec()
{
    self notify( #"hash_508231fdc050f4cb" );
    self endon( #"death" );
    level endon( #"game_ended" );
    self endon( #"hash_508231fdc050f4cb" );
    maxrolldegrees = getdvarint( @"hash_7bd25800dfc29105" );
    maxyawdiff = getdvarint( @"hash_832a4160ba33c74b" );
    var_b3b5221672606c23 = ( 1, 0, 0 );
    unityvector = ( 0, 1, 0 );
    var_8e7f7373961acda1 = ( 0, 0, -1 );
    waitframe();
    self.previousorigin = self.origin;
    self.targetangles = self.angles;
    
    while ( true )
    {
        stepvector = self.origin - self.previousorigin;
        stepunit = vectornormalize( stepvector );
        pitch = asin( vectordot( stepunit, var_8e7f7373961acda1 ) );
        stepunit = ( stepunit[ 0 ], stepunit[ 1 ], 0 );
        stepunit = vectornormalize( stepunit );
        yaw = acos( vectordot( stepunit, var_b3b5221672606c23 ) );
        
        if ( vectordot( stepunit, unityvector ) < 0 )
        {
            yaw = 360 - yaw;
        }
        
        yawdiff = yaw - self.targetangles[ 1 ];
        
        if ( abs( yawdiff ) > 300 )
        {
            yawdiff -= 360;
        }
        
        yawdiffclamped = clamp( yawdiff, maxyawdiff * -1, maxyawdiff );
        turnproportion = yawdiffclamped / maxyawdiff;
        roll = maxrolldegrees * turnproportion * -1;
        self.previousorigin = self.origin;
        newangles = ( pitch, yaw, roll );
        self.targetangles = newangles;
        wait 0.05;
    }
}

// Namespace switchblade_drone
// Params 0
// Checksum 0x91dec12a, Offset: 0x1d70
// Size: 0x2eb
function function_275fcb5acd73ea13()
{
    self notify( #"hash_9504c2c40b2c038" );
    self endon( #"death" );
    level endon( #"game_ended" );
    self endon( #"hash_9504c2c40b2c038" );
    var_145553ccdeeee4fe = getdvarint( @"hash_57306177bd6ed859" );
    var_b2408d5d438efa81 = getdvarint( @"hash_fa505002fe5586de" );
    var_22c1b97edc05d826 = getdvarint( @"hash_636a1d843f1957eb" );
    self.previousangles = self.angles;
    
    while ( true )
    {
        if ( isdefined( self.targetangles ) )
        {
            fixedtargetpitch = angleclamp( self.targetangles[ 0 ] );
            fixedcurrentpitch = angleclamp( self.angles[ 0 ] );
            fixedtargetyaw = angleclamp( self.targetangles[ 1 ] );
            fixedcurrentyaw = angleclamp( self.angles[ 1 ] );
            var_30ddd3838d59b50e = angleclamp( self.targetangles[ 2 ] );
            var_b979e0b993e4ba7a = angleclamp( self.angles[ 2 ] );
            pitcherror = fixedtargetpitch - fixedcurrentpitch;
            yawerror = fixedtargetyaw - fixedcurrentyaw;
            rollerror = var_30ddd3838d59b50e - var_b979e0b993e4ba7a;
            var_cbd944e4ba546d33 = fixedtargetpitch - fixedcurrentpitch + 360;
            var_a53258bb87f4a2d3 = fixedtargetpitch - fixedcurrentpitch - 360;
            
            if ( abs( var_cbd944e4ba546d33 ) < abs( pitcherror ) )
            {
                pitcherror = var_cbd944e4ba546d33;
            }
            else if ( abs( var_a53258bb87f4a2d3 ) < abs( pitcherror ) )
            {
                pitcherror = var_a53258bb87f4a2d3;
            }
            
            var_e552259be5fcf270 = fixedtargetyaw - fixedcurrentyaw + 360;
            var_266c985c48b44710 = fixedtargetyaw - fixedcurrentyaw - 360;
            
            if ( abs( var_e552259be5fcf270 ) < abs( yawerror ) )
            {
                yawerror = var_e552259be5fcf270;
            }
            else if ( abs( var_266c985c48b44710 ) < abs( yawerror ) )
            {
                yawerror = var_266c985c48b44710;
            }
            
            var_460b780b174cde4e = var_30ddd3838d59b50e - var_b979e0b993e4ba7a + 360;
            var_2f3bd518735af06e = var_30ddd3838d59b50e - var_b979e0b993e4ba7a - 360;
            
            if ( abs( var_460b780b174cde4e ) < abs( rollerror ) )
            {
                rollerror = var_460b780b174cde4e;
            }
            else if ( abs( var_2f3bd518735af06e ) < abs( rollerror ) )
            {
                rollerror = var_2f3bd518735af06e;
            }
            
            pitchstep = self.angles[ 0 ] + clamp( pitcherror, var_b2408d5d438efa81 * -1, var_b2408d5d438efa81 );
            yawstep = self.angles[ 1 ] + clamp( yawerror, var_145553ccdeeee4fe * -1, var_145553ccdeeee4fe );
            rollstep = self.angles[ 2 ] + clamp( rollerror, var_22c1b97edc05d826 * -1, var_22c1b97edc05d826 );
            newangles = ( pitchstep, yawstep, rollstep );
            self.angles = newangles;
            lastsign = utility::sign( yawerror );
        }
        
        wait 0.05;
    }
}

// Namespace switchblade_drone
// Params 3
// Checksum 0xac6c931a, Offset: 0x2063
// Size: 0x240
function function_1e637d2988bab39b( centerpos, startpos, flyvelocity )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    dvar_fly_time = getdvarint( @"hash_aea510623d9c4c10" );
    var_315fa6968b02a14e = getdvarint( @"hash_79f9928723395f7f" );
    anglevector = centerpos - startpos;
    flytotaltime = dvar_fly_time;
    flystarttime = gettime();
    flystartpoint = self.origin;
    var_683d85697d1567f5 = ( flystartpoint[ 0 ], flystartpoint[ 1 ], 0 );
    var_4e83848190ef063f = flystartpoint[ 2 ];
    targetpos = centerpos - anglevector;
    targetposhorizontal = ( targetpos[ 0 ], targetpos[ 1 ], 0 );
    targetposvertical = targetpos[ 2 ];
    flytimepassed = 0;
    collisioncontents = physics_createcontents( [ "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot" ] );
    
    while ( flytimepassed < flytotaltime )
    {
        flytimepassed = gettime() - flystarttime;
        proportion = flytimepassed / flytotaltime;
        var_f1c4b45993094c46 = math::lerp( var_4e83848190ef063f, targetposvertical, easesine( proportion, 1, 1 ) );
        circleangles = ( 0, math::angle_lerp( 0, var_315fa6968b02a14e, proportion ), 0 );
        linearcomponent = vectorlerp( var_683d85697d1567f5, targetposhorizontal, proportion );
        anglevector = var_683d85697d1567f5 - targetposhorizontal;
        circlecomponent = var_683d85697d1567f5 - rotatevector( anglevector, circleangles );
        var_e88571e6d2486120 = vectorlerp( linearcomponent, circlecomponent, proportion );
        newpos = ( var_e88571e6d2486120[ 0 ], var_e88571e6d2486120[ 1 ], var_f1c4b45993094c46 );
        tracehit = physics_raycast( self.origin, newpos, collisioncontents, self, 0, "physicsquery_any" );
        
        if ( tracehit )
        {
            switchblade_drone_self_destruct( 0 );
            return;
        }
        
        self.origin = newpos;
        waitframe();
    }
    
    var_9a536418807c2709 = ( 0, var_315fa6968b02a14e, 0 );
    anglevector = centerpos - startpos;
    rotatedstartpos = centerpos - rotatevector( anglevector, var_9a536418807c2709 );
    thread function_d32356ca1f7fa343( centerpos, rotatedstartpos, flyvelocity );
}

// Namespace switchblade_drone
// Params 3
// Checksum 0x82c0fcbc, Offset: 0x22ab
// Size: 0x152
function function_d32356ca1f7fa343( centerpos, startpos, flyvelocity )
{
    self notify( #"hash_ca59c633a924494c" );
    self endon( #"death" );
    self endon( #"hash_9e8daf5ca454e94" );
    self endon( #"divebombing" );
    self endon( #"hash_ca59c633a924494c" );
    level endon( #"game_ended" );
    anglevector = centerpos - startpos;
    flyradius = distance( startpos, centerpos );
    totaltime = float( 6.28 * flyradius / flyvelocity ) * 1000;
    starttime = gettime();
    startangle = 0;
    endangle = 180;
    
    while ( true )
    {
        if ( !isdefined( self ) )
        {
            return;
        }
        
        timepassed = gettime() - starttime;
        fraction = min( timepassed / totaltime, 1 );
        var_a5339e30ffa145c1 = math::angle_lerp( startangle, endangle, fraction );
        newvector = rotatevector( anglevector, ( 0, var_a5339e30ffa145c1, 0 ) );
        newpos = centerpos - newvector;
        self.origin = newpos;
        
        if ( fraction >= 1 )
        {
            starttime = gettime();
            anglevector = newvector;
        }
        
        waitframe();
    }
}

// Namespace switchblade_drone
// Params 2
// Checksum 0x8c9e02b0, Offset: 0x2405
// Size: 0x40f
function function_d353828f3fe83995( streakname, centerposzoffset )
{
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    level endon( #"game_end" );
    var_88cdd7dd6ca4d9d0 = getdvarint( @"hash_cda65d1126957523" );
    wait var_88cdd7dd6ca4d9d0;
    contents = physics_createcontents( [ "physicscontents_characterproxy", "physicscontents_vehicle" ] );
    
    while ( true )
    {
        centerpos = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] / 1.5 );
        
        if ( !isdefined( streakname ) )
        {
            streakname = "switchblade_drone";
        }
        
        if ( isdefined( centerposzoffset ) )
        {
            centerpos += ( 0, 0, centerposzoffset );
        }
        
        bundle = level.streakglobals.streakbundles[ "switchblade_drone" ];
        var_1c4ae8897bda6a2b = getdvarint( @"hash_b171aaba052d2c50" );
        lengthvector = ( bundle.var_91f7fa4d8870a52a / 2 + var_1c4ae8897bda6a2b, bundle.var_265f2d3f9f98a8a / 2 + var_1c4ae8897bda6a2b, bundle.var_203af7c76d1f3385 + var_1c4ae8897bda6a2b );
        aabbmin = centerpos - lengthvector;
        aabbmax = centerpos + lengthvector;
        hits = physics_aabbquery( aabbmin, aabbmax, contents, [], "physicsquery_all" );
        
        /#
            var_1871d23e9c8ba8d2 = getdvarint( @"hash_b0c1d0793ae379c7" );
            debugactive = getdvarint( @"scr_switchblade_drone_debug" );
            
            if ( debugactive > 0 )
            {
                dvar_debug_duration = getdvarint( @"scr_switchblade_drone_debug_duration" );
                functionals_utility::function_3fd21b027afc9a0e( aabbmin, aabbmax, dvar_debug_duration );
            }
        #/
        
        validtargets = [];
        index = 0;
        
        foreach ( hit in hits )
        {
            if ( ( isplayer( hit ) || isagent( hit ) ) && isdefined( hit.perks[ "specialty_blindeye" ] ) )
            {
                continue;
            }
            
            if ( isdefined( hit.team ) && hit.team != self.team )
            {
                /#
                    function_8d74b17cc3469a6d( hit.origin );
                #/
                
                if ( isplayer( hit ) || isagent( hit ) )
                {
                    validtargets[ index ] = hit;
                    index++;
                }
                else if ( isdefined( hit.owner ) && isdefined( hit.ownerteam ) && hit.ownerteam != self.team )
                {
                    validtargets[ index ] = hit;
                    index++;
                }
                else if ( isdefined( hit.vehicletype ) && hit.team != "neutral" )
                {
                    validtargets[ index ] = hit;
                    index++;
                }
            }
            
            /#
                if ( var_1871d23e9c8ba8d2 )
                {
                    if ( ( isplayer( hit ) || isagent( hit ) ) && isdefined( hit.team ) && hit.team == self.team )
                    {
                        function_8d74b17cc3469a6d( hit.origin );
                        validtargets[ index ] = hit;
                        index++;
                        continue;
                    }
                    
                    if ( isdefined( hit.owner ) && hit.ownerteam == self.team )
                    {
                        function_8d74b17cc3469a6d( hit.origin );
                        validtargets[ index ] = hit;
                        index++;
                    }
                }
            #/
        }
        
        if ( validtargets.size > 0 )
        {
            switchblade_drone_getbesttarget( validtargets );
        }
        
        wait bundle.var_2b56b80d59b3a013;
    }
}

// Namespace switchblade_drone
// Params 1
// Checksum 0x20294b46, Offset: 0x281c
// Size: 0x1bb
function switchblade_drone_getbesttarget( validtargets )
{
    validtargets = sortbydistance( validtargets, self.origin );
    raycastcontents = physics_createcontents( [ "physicscontents_vehicleclip", "physicscontents_item", "physicscontents_ainoshoot" ] );
    var_9f31a6a46d7d7fb4 = physics_createcontents( [ "physicscontents_item", "physicscontents_ainoshoot" ] );
    
    foreach ( target in validtargets )
    {
        /#
            debugactive = getdvarint( @"scr_switchblade_drone_debug" );
            
            if ( debugactive > 0 )
            {
                dvar_debug_duration = getdvarint( @"scr_switchblade_drone_debug_duration" );
                line( self.origin, target.origin, ( 0, 0, 100 ), 1, 0, dvar_debug_duration );
            }
        #/
        
        raycastresults = undefined;
        
        if ( isplayer( target ) || isagent( target ) )
        {
            raycastresults = physics_raycast( self.origin, target.origin, raycastcontents, undefined, 0, "physicsquery_closest" );
        }
        else
        {
            raycastresults = physics_raycast( self.origin, target.origin, var_9f31a6a46d7d7fb4, undefined, 0, "physicsquery_closest" );
        }
        
        if ( raycastresults.size == 0 )
        {
            self notify( #"hash_9e8daf5ca454e94" );
            function_d1404124d2dfbbb7( target );
            break;
        }
    }
}

// Namespace switchblade_drone
// Params 1
// Checksum 0x90aacd18, Offset: 0x29df
// Size: 0xd0, Type: bool
function switchblade_drone_check_los( besttarget )
{
    raycastcontents = physics_createcontents( [ "physicscontents_vehicleclip", "physicscontents_item", "physicscontents_ainoshoot" ] );
    var_9f31a6a46d7d7fb4 = physics_createcontents( [ "physicscontents_item", "physicscontents_ainoshoot" ] );
    raycastresults = undefined;
    
    if ( isplayer( besttarget ) || isagent( besttarget ) )
    {
        raycastresults = physics_raycast( self.origin, besttarget.origin, raycastcontents, undefined, 0, "physicsquery_closest", 1 );
    }
    else
    {
        raycastresults = physics_raycast( self.origin, besttarget.origin, var_9f31a6a46d7d7fb4, undefined, 0, "physicsquery_closest", 1 );
    }
    
    if ( raycastresults.size == 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace switchblade_drone
// Params 2
// Checksum 0x511e5f8e, Offset: 0x2ab8
// Size: 0x212
function function_d1404124d2dfbbb7( besttarget, targetloc )
{
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    level endon( #"game_end" );
    self.ispreparing = 1;
    starttime = gettime();
    timepassed = 0;
    var_1dac301287832185 = getdvarint( @"hash_836eeca87d3a3d6f" );
    var_8ae5781689956187 = getdvarint( @"hash_fc2d155242a3fc25" );
    
    if ( self.streakname == "drone_swarm" )
    {
        var_1dac301287832185 = getdvarint( @"hash_f065b6bad78c93b9" );
        var_8ae5781689956187 = getdvarint( @"hash_b6455b787cd7cbab" );
    }
    
    assert( var_1dac301287832185 > 0 );
    assert( var_8ae5781689956187 > 0 );
    self setscriptablepartstate( "lockedOn", "preparing", 1 );
    var_658e4fc8548788a5 = getdvarint( @"scr_switchblade_drone_velocity" );
    var_6101d05629fefd8e = getdvarint( @"hash_d40e17bd9fa003a1" );
    preparecenter = self.origin + vectornormalize( self.centerpos - self.origin ) * var_6101d05629fefd8e;
    thread function_d32356ca1f7fa343( preparecenter, self.origin, var_658e4fc8548788a5 );
    
    while ( timepassed < var_1dac301287832185 )
    {
        timepassed = gettime() - starttime;
        
        if ( isent( besttarget ) )
        {
            isinlos = switchblade_drone_check_los( besttarget );
        }
        
        if ( isdefined( isinlos ) && !isinlos )
        {
            self setscriptablepartstate( "lockedOn", "idle", 1 );
            thread function_d32356ca1f7fa343( self.centerpos, self.origin, var_658e4fc8548788a5 );
            self.ispreparing = 0;
            return;
        }
        
        wait 0.1;
    }
    
    while ( timepassed < var_8ae5781689956187 )
    {
        timepassed = gettime() - starttime;
        
        if ( function_37b14cadb91ebb5c( besttarget, targetloc ) )
        {
            function_96c8a569f09d58b9( besttarget, targetloc );
            return;
        }
        
        wait 0.1;
    }
    
    function_96c8a569f09d58b9( besttarget, targetloc );
}

// Namespace switchblade_drone
// Params 2
// Checksum 0x121c2399, Offset: 0x2cd2
// Size: 0xd3, Type: bool
function function_37b14cadb91ebb5c( target, targetloc )
{
    targetorigin = undefined;
    
    if ( isdefined( target ) )
    {
        targetorigin = target.origin;
    }
    else if ( isdefined( targetloc ) )
    {
        targetorigin = targetloc;
    }
    else
    {
        assertmsg( "<dev string:x24>" );
        return false;
    }
    
    var_38f0ad203bc66b8c = ( targetorigin[ 0 ], targetorigin[ 1 ], targetorigin[ 2 ] );
    fromtarget = vectornormalize( var_38f0ad203bc66b8c - self.origin );
    droneaim = vectornormalize( anglestoforward( self.angles ) );
    dot = vectordot( fromtarget, droneaim );
    
    if ( dot <= 0 )
    {
        return false;
    }
    
    dotthreshold = 0.7;
    
    if ( dot > dotthreshold )
    {
        return true;
    }
    
    return false;
}

// Namespace switchblade_drone
// Params 2
// Checksum 0x74d47970, Offset: 0x2dae
// Size: 0x2b2
function function_96c8a569f09d58b9( target, targetloc )
{
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    level endon( #"game_end" );
    self notify( #"divebombing" );
    assert( isdefined( target ) || isdefined( targetloc ) );
    targetpos = undefined;
    
    if ( isdefined( target ) )
    {
        targetpos = target.origin;
    }
    else if ( isdefined( targetloc ) )
    {
        targetpos = targetloc;
    }
    else
    {
        assertmsg( "<dev string:x65>" );
        switchblade_drone_self_destruct( 1 );
        return;
    }
    
    starttime = gettime();
    startpos = self.origin;
    totaldistance = distance( self.origin, targetpos );
    self setscriptablepartstate( "lockedOn", "moving", 1 );
    var_8c5f7c4ffd77656d = getdvarint( @"hash_1da226fe14849c74" );
    var_a1fc1f6684353bb4 = getdvarint( @"hash_b9597bb5bad14e63" );
    
    if ( self.streakname == "drone_swarm" )
    {
        var_8c5f7c4ffd77656d = getdvarint( @"hash_9719cfd50a1766ee" );
    }
    
    totaltime = float( totaldistance / var_8c5f7c4ffd77656d * 1000 );
    assert( totaltime > 0 );
    collisioncontents = undefined;
    
    if ( isplayer( target ) || isagent( target ) )
    {
        collisioncontents = physics_createcontents( [ "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot" ] );
    }
    else
    {
        collisioncontents = physics_createcontents( [ "physicscontents_missileclip", "physicscontents_clipshot" ] );
    }
    
    if ( isdefined( level.var_d8f10f1cfdbaac7e ) )
    {
        thread [[ level.var_d8f10f1cfdbaac7e ]]( self.streakinfo );
    }
    
    while ( distance( self.origin, targetpos ) > var_a1fc1f6684353bb4 )
    {
        timepassed = gettime() - starttime;
        fraction = float( min( timepassed / totaltime, 1 ) );
        targetlocation = math::lerp( startpos, targetpos, easepower( fraction, 2, 1, 1 ) );
        tracehit = physics_raycast( self.origin, targetlocation, collisioncontents, self, 0, "physicsquery_any" );
        
        if ( tracehit )
        {
            switchblade_drone_self_destruct( 1 );
            return;
        }
        
        self.origin = targetlocation;
        waitframe();
    }
    
    self.ispreparing = 0;
    switchblade_drone_self_destruct( 1 );
    
    if ( isdefined( level.var_fa0d180f4b71bc0e ) )
    {
        thread [[ level.var_fa0d180f4b71bc0e ]]( self.streakinfo );
    }
}

// Namespace switchblade_drone
// Params 1
// Checksum 0xad619cf, Offset: 0x3068
// Size: 0x14
function switchblade_drone_empapplied( data )
{
    switchblade_drone_self_destruct( 0 );
}

// Namespace switchblade_drone
// Params 1
// Checksum 0x2e3bf62f, Offset: 0x3084
// Size: 0x14
function switchblade_drone_haywireapplied( data )
{
    switchblade_drone_self_destruct( 0 );
}

// Namespace switchblade_drone
// Params 1
// Checksum 0x3c043345, Offset: 0x30a0
// Size: 0x43
function switchblade_drone_self_destruct( fromtrigger )
{
    params = spawnstruct();
    params.fromtrigger = fromtrigger;
    switchblade_drone_explode( params );
    callback::callback( #"on_functional_death" );
}

// Namespace switchblade_drone
// Params 1
// Checksum 0x5541e373, Offset: 0x30eb
// Size: 0x28
function function_2fd31dd9e3c72c80( params )
{
    params = spawnstruct();
    params.fromtrigger = 0;
    switchblade_drone_explode( params );
}

// Namespace switchblade_drone
// Params 1
// Checksum 0x18be0031, Offset: 0x311b
// Size: 0x3c
function switchblade_drone_timeout( params )
{
    self.owner killstreak_utility::playkillstreakteamleaderdialog( self.streakinfo, "switchblade_drone_teamleader_timeout", #"leave" );
    switchblade_drone_explode( params );
}

// Namespace switchblade_drone
// Params 1
// Checksum 0xece8dfb9, Offset: 0x315f
// Size: 0x20c
function switchblade_drone_explode( params )
{
    if ( isdefined( level.var_845fe19bc9ff4b8e ) )
    {
        thread [[ level.var_845fe19bc9ff4b8e ]]( self.streakinfo, self.origin, 0 );
    }
    
    level.switchbladedrones = arrayremove( level.switchbladedrones, self );
    fromtrigger = params.fromtrigger;
    partstatename = "explode";
    
    if ( isbrgamemode() )
    {
        partstatename = "explode_noDamage";
    }
    
    var_b5ac39bac279ba2f = self getscriptablepartstate( partstatename );
    
    if ( var_b5ac39bac279ba2f == "fromtrigger" )
    {
        return;
    }
    
    if ( self.streakname == "switchblade_drone" )
    {
        self.owner killstreak_utility::recordkillstreakendstats( self.streakinfo );
    }
    
    bundle = level.streakglobals.streakbundles[ "switchblade_drone" ];
    dmgradius = bundle.dronedamageradius;
    maxdmg = bundle.dronemaxdamage;
    mindmg = bundle.dronemindamage;
    var_3bb8306d5e9e1121 = bundle.var_113cc339d05b2610;
    var_c6df6e5913033817 = bundle.var_11718994d0941420;
    var_9926c6df80278d55 = bundle.var_fecf9a84d6ebb2da;
    sourcename = fromtrigger ? "fromtrigger" : "fromdamage";
    
    if ( isbrgamemode() )
    {
        owner = self.owner;
        
        if ( !isdefined( owner ) )
        {
            owner = undefined;
        }
        
        if ( sourcename == "fromtrigger" )
        {
            self radiusdamage( self.origin, dmgradius, maxdmg, mindmg, owner, "MOD_EXPLOSIVE", "switchblade_drone_mp" );
        }
        else
        {
            self radiusdamage( self.origin, var_3bb8306d5e9e1121, var_c6df6e5913033817, var_9926c6df80278d55, owner, "MOD_EXPLOSIVE", "switchblade_drone_mp" );
        }
    }
    
    self setscriptablepartstate( partstatename, sourcename, 0 );
    self notify( #"notify_switchblade_drone_explode" );
}

// Namespace switchblade_drone
// Params 5
// Checksum 0x8990d5f7, Offset: 0x3373
// Size: 0x266
function function_f2a4a24c41351e69( msg, timer, radius, targetlength, targetwidth )
{
    level endon( #"game_ended" );
    drone = self;
    alliedplayers = [];
    alliedplayers = utility::callsharedfunc( #"game", #"getteamdata", drone.owner.team, "players" );
    circleradius = int( int( min( targetlength, targetwidth ) / 2 ) + radius );
    drone.enemycircle = spawnstruct();
    drone.allycircle = spawnstruct();
    drone.enemycircle game_utility::questcircle_create( "switchblade_drone_danger_radius", drone.origin, circleradius );
    drone.enemycircle game_utility::questcircle_showtoall();
    
    foreach ( player in alliedplayers )
    {
        drone.enemycircle game_utility::questcircle_hidefromplayer( player );
    }
    
    drone.allycircle game_utility::questcircle_create( "switchblade_drone_ally_radius", drone.origin, circleradius );
    
    foreach ( player in alliedplayers )
    {
        drone.allycircle game_utility::questcircle_showtoplayer( player );
    }
    
    utility::waittill_any_timeout( timer, msg, "game_ended" );
    drone.enemycircle game_utility::questcircle_hidefromall();
    drone.enemycircle game_utility::questcircle_delete();
    drone.allycircle game_utility::questcircle_hidefromall();
    drone.allycircle game_utility::questcircle_delete();
}

/#

    // Namespace switchblade_drone
    // Params 1
    // Checksum 0xa98f94e8, Offset: 0x35e1
    // Size: 0x41, Type: dev
    function function_8d74b17cc3469a6d( center )
    {
        dvar_debug_duration = getdvarint( @"scr_switchblade_drone_debug_duration" );
        sphere( center, 15, ( 0, 0, 255 ), 0, dvar_debug_duration );
    }

#/
