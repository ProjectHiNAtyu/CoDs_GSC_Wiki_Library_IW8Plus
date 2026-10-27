// scripts\mp\common\killstreaks\remote_robot.gsc  (hash_6259287daff1e33b.gscc) (size: 34097 Bytes / 0x8531 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x37547c (3626108)
// size ...... 34097 (0x8531)
// includes .. 43  (offset: 0x7c2d)
// strings ... 116 (offset: 0x7d85)
// dev strs .. 3   (offset: 0x850d)
// exports ... 51  (offset: 0x5221)
// cseg ...... 0x94f + 0x48d2 (0x5221)
// imports ... 284 (offset: 0x5a19)
// animtree1 . 0   (offset: 0x8531)
// animtree2 . 0   (offset: 0x8531)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\functionals_utility;
#using scripts\common\killstreaks\killstreak_common;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\scene;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_omnvar_utility;
#using scripts\common\weapon;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\class;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\killstreaks\juggernaut;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\perks\perkfunctions;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\emp_debuff;
#using scripts\mp\execution;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\juggernaut;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\operator;
#using scripts\mp\outofbounds;
#using scripts\mp\teams;
#using scripts\mp\weapons;

#namespace remote_robot;

// Namespace remote_robot
// Params 0, eflags: 0x5
// Checksum 0x4968739a, Offset: 0x96d
// Size: 0x1c9
function private autoexec main()
{
    killstreaks::registerkillstreak( "remote_robot", &function_f71b4ae9d3d63954 );
    killstreak_shared::registerkillstreakinitfunction( getxhash( "remote_robot" ), &remote_robot_init );
    remoterobotweaponname = utility::get_scripted_weapon_name( #"remote_robot" );
    
    if ( isdefined( remoterobotweaponname ) )
    {
        killstreaks::registerkillstreakdamagedealingweapon( "remote_robot", remoterobotweaponname, #"medium", 1 );
    }
    
    killstreaks::registerkillstreakdamagedealingweapon( "remote_robot", "sat_remote_robot_timeout_explosion", #"medium", 0 );
    killstreaks::registerkillstreakdamagedealingweapon( "remote_robot", "sat_remote_robot_landing_explosion", #"medium", 0 );
    
    /#
        setdevdvarifuninitialized( @"hash_2a7e29e8884635a3", 0 );
    #/
    
    classstruct = class::loadout_getclassstruct();
    classstruct.loadoutprimary = remoterobotweaponname;
    var_c579642e7884f976 = getdvarint( @"hash_8e7b516accf9e30d", 10 );
    juggconfig = { #var_3732cb298af9e000:throttle::throttle_initialize( "remote_robot_hud_outlines_throttle", var_c579642e7884f976 ), #var_5e3298d5f5ff231f:7, #maxvehicledamagedivisor:5, #infiniteammo:1, #perks:[], #classstruct:classstruct };
    juggconfig.activatefunc = &activateremoterobot;
    juggconfig.removefunc = &removeremoterobot;
    juggconfig.modifydamagefunc = &remoteRobotModifyDamageTaken;
    juggconfig.getminigunweaponfunc = &function_226074f15c61b467;
    level.juggconfig = juggconfig;
    level callback::add( #"register_perk", &function_41bffb9d49d9e59b );
    level callback::add( #"player_death", &function_cd32264cb376a88a );
    level callback::add( #"on_ai_killed", &function_cd32264cb376a88a );
}

// Namespace remote_robot
// Params 0
// Checksum 0xad4e91e4, Offset: 0xb3e
// Size: 0x89
function remote_robot_init()
{
    bundle = level.streakglobals.streakbundles[ "remote_robot" ];
    
    if ( bundle.remoterobotdeathfx )
    {
        utility::add_fx( "remote_robot_death", bundle.remoterobotdeathfx );
    }
    
    killstreak_utility::registervisibilityomnvarforkillstreak( "remote_robot", "on", 30 );
    utility::registersharedfunc( #"remote_robot", #"hack", &hack );
    utility::flag_set( "remote_robot_initialized" );
}

// Namespace remote_robot
// Params 1
// Checksum 0xb486453b, Offset: 0xbcf
// Size: 0x2f
function function_41bffb9d49d9e59b( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_remote_robot" );
    }
}

// Namespace remote_robot
// Params 1
// Checksum 0x2e5ec743, Offset: 0xc06
// Size: 0x282
function function_f71b4ae9d3d63954( streakinfo )
{
    if ( !juggernaut::function_11863370c607058c( streakinfo ) )
    {
        return 0;
    }
    
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            return 0;
        }
    }
    
    if ( weapon::function_ecbdce6df0e16a2a( #"remote_robot" ) )
    {
        weapons::denyusage();
        return 0;
    }
    
    if ( self.var_e6e285922d86ab7f )
    {
        streakinfo.dropposition = getclosestpointonnavmesh( self.origin ) + ( 0, 0, 40 );
        
        if ( !isdefined( streakinfo.dropposition ) )
        {
            return 0;
        }
    }
    else
    {
        streakinfo.dropposition = function_72266bf8fa2efb5a();
        
        if ( !isdefined( streakinfo.dropposition ) )
        {
            if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
            {
                self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"hash_2e0b77a71f30bcc" );
            }
            
            return 0;
        }
    }
    
    thread killstreak_utility::playkillstreaktacomdialog( streakinfo, undefined, #"arrive", 1, 2 );
    thread function_fde35f1461ef68b1();
    deployweaponobj = makeweapon( "sat_ks_remote_device_mp" );
    streakinfo.var_47d906c0c5d19d0a = self getcurrentweapon();
    streakinfo.var_ec96691f3a2c45c0 = 0;
    
    if ( self.var_adc43141e2117c18 )
    {
        deployresult = 1;
    }
    else
    {
        deployresult = killstreakdeploy::streakdeploy_doweapontabletdeploy( streakinfo, undefined, undefined, undefined, undefined, "sat_ks_remote_device_mp", 1, undefined, undefined, undefined, undefined, 1 );
    }
    
    val::reset_all( "usingRemote" );
    
    if ( deployresult )
    {
        thread activateremoterobot( streakinfo );
        
        if ( isdefined( self.var_aa0bd298d1ac2539 ) )
        {
            self.var_aa0bd298d1ac2539.inuse = undefined;
            self.var_aa0bd298d1ac2539 = undefined;
        }
        
        self.usingremote = "remote_robot";
        msg = undefined;
        msg = utility::waittill_any_return( "intro_sequence_started" );
        
        if ( !isdefined( msg ) )
        {
            deployresult = 0;
        }
        else if ( isdefined( level.killstreakbeginusefunc ) )
        {
            if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
            {
                deployresult = 0;
            }
        }
        
        if ( utility::issharedfuncdefined( #"killstreak", #"addtoactivekillstreaklist" ) )
        {
            self [[ utility::getsharedfunc( #"killstreak", #"addtoactivekillstreaklist" ) ]]( "remote_robot", "Killstreak_Ground", self, 0, 1 );
        }
    }
    else
    {
        self.usingremote = undefined;
        self notify( #"stopped_using_remote" );
    }
    
    return deployresult;
}

// Namespace remote_robot
// Params 1
// Checksum 0x3bd2feea, Offset: 0xe91
// Size: 0xb9
function function_c75696e00d6fb489( rhinoplayer )
{
    if ( isdefined( level.var_e2f4b643d9aa57ae ) )
    {
        foreach ( point in level.var_e2f4b643d9aa57ae )
        {
            if ( !point.inuse )
            {
                point.inuse = 1;
                return point;
            }
        }
        
        waitframe();
    }
    
    return utility::array_random( level.var_e2f4b643d9aa57ae );
}

// Namespace remote_robot
// Params 0
// Checksum 0x4c65db79, Offset: 0xf53
// Size: 0x4c2
function function_72266bf8fa2efb5a()
{
    spawnattempts = 0;
    collisioncontents = trace::create_contents( 0, 1, 0, 1, 1 );
    ignorelist = [];
    startpos = self.origin;
    startangles = self.angles;
    
    if ( isdefined( level.var_e2f4b643d9aa57ae ) )
    {
        closestpos = function_c75696e00d6fb489( self );
        
        if ( isdefined( closestpos ) )
        {
            startpos = closestpos.origin;
            startangles = closestpos.angles;
            self.var_aa0bd298d1ac2539 = closestpos;
        }
    }
    
    forward = anglestoforward( startangles );
    right = anglestoright( startangles );
    var_a442c567bbc4858a = undefined;
    var_f916c6ea28dbc972 = undefined;
    
    while ( true )
    {
        if ( spawnattempts > 50 )
        {
            return var_a442c567bbc4858a;
        }
        
        spawnangles = [ forward, forward * -1, 0.707 * ( forward + right ), 0.707 * ( forward - right ), right * -1, right, 0.707 * ( forward * -1 + right ), 0.707 * ( forward * -1 - right ) ];
        spawnpoint = getclosestpointonnavmesh( startpos );
        movingplatforminfo = airdrop::function_6d2c704914d1e4b5( spawnpoint );
        
        if ( !isdefined( movingplatforminfo ) )
        {
            var_2cdce2757ff7bfb1 = trace::create_contents( 0, 0, 0, 0, 1 );
            endpoint = spawnpoint + ( 0, 0, 3000 );
            hitresults = physics_spherecast( spawnpoint, endpoint, 2.35294, var_2cdce2757ff7bfb1, ignorelist, "physicsquery_all" );
            var_b1281d954abe142e = 0;
            
            foreach ( hitresult in hitresults )
            {
                if ( hitresult[ "entity" ].streakref == "airdrop_crate" )
                {
                    var_b1281d954abe142e = 1;
                    break;
                }
            }
            
            if ( !var_b1281d954abe142e )
            {
                spawnpoint += ( 0, 0, 40 );
                endpoint = spawnpoint + ( 0, 0, 3000 );
                hitresults = physics_spherecast( spawnpoint, endpoint, 2.35294, collisioncontents, ignorelist, "physicsquery_all" );
                
                if ( hitresults.size == 0 )
                {
                    var_1c896b70ed19ff18 = function_3de2cd2ce6de68dd( hitresults, spawnpoint, var_a442c567bbc4858a, var_f916c6ea28dbc972 );
                    
                    if ( var_1c896b70ed19ff18.dropverified )
                    {
                        return spawnpoint;
                    }
                    else if ( isdefined( var_1c896b70ed19ff18.var_a442c567bbc4858a ) )
                    {
                        var_a442c567bbc4858a = var_1c896b70ed19ff18.var_a442c567bbc4858a;
                        var_f916c6ea28dbc972 = var_1c896b70ed19ff18.var_f916c6ea28dbc972;
                    }
                }
            }
        }
        
        foreach ( spawnangle in spawnangles )
        {
            spawnpoint = getclosestpointonnavmesh( startpos + spawnangle * ( spawnattempts + 1 ) * 50 );
            movingplatforminfo = airdrop::function_6d2c704914d1e4b5( spawnpoint );
            
            if ( isdefined( movingplatforminfo ) )
            {
                continue;
            }
            
            spawnpoint += ( 0, 0, 40 );
            endpoint = spawnpoint + ( 0, 0, 3000 );
            hitresults = physics_spherecast( spawnpoint, endpoint, 20, collisioncontents, ignorelist, "physicsquery_all" );
            
            /#
                if ( getdvarint( @"hash_2a7e29e8884635a3", 0 ) )
                {
                    line( spawnpoint, endpoint, ( 0, 1, 0 ), 1, 0, 300 );
                    
                    foreach ( hitresult in hitresults )
                    {
                        sphere( hitresult[ "<dev string:x24>" ], 20, ( 1, 0, 0 ), 0, 300 );
                    }
                }
            #/
            
            if ( hitresults.size > 0 )
            {
                continue;
            }
            
            var_1c896b70ed19ff18 = function_3de2cd2ce6de68dd( hitresults, spawnpoint, var_a442c567bbc4858a, var_f916c6ea28dbc972 );
            
            if ( var_1c896b70ed19ff18.dropverified )
            {
                return spawnpoint;
            }
            
            if ( isdefined( var_1c896b70ed19ff18.var_a442c567bbc4858a ) )
            {
                var_a442c567bbc4858a = var_1c896b70ed19ff18.var_a442c567bbc4858a;
                var_f916c6ea28dbc972 = var_1c896b70ed19ff18.var_f916c6ea28dbc972;
            }
        }
        
        spawnattempts++;
        waitframe();
    }
}

// Namespace remote_robot
// Params 4
// Checksum 0x433e87db, Offset: 0x141d
// Size: 0xb9
function function_3de2cd2ce6de68dd( hitresults, spawnpoint, var_a442c567bbc4858a, var_f916c6ea28dbc972 )
{
    var_1c896b70ed19ff18 = spawnstruct();
    var_1c896b70ed19ff18.dropverified = 0;
    verifyresult = function_9e864832ad01ac0d( spawnpoint );
    
    if ( verifyresult.var_59843231c822ceab == 0 )
    {
        if ( !var_a442c567bbc4858a || var_f916c6ea28dbc972 < verifyresult.distancesquared )
        {
            var_1c896b70ed19ff18.var_a442c567bbc4858a = spawnpoint;
            var_1c896b70ed19ff18.var_f916c6ea28dbc972 = verifyresult.distancesquared;
        }
    }
    else
    {
        var_1c896b70ed19ff18.dropverified = 1;
        return var_1c896b70ed19ff18;
    }
    
    return var_1c896b70ed19ff18;
}

// Namespace remote_robot
// Params 1
// Checksum 0xad799f9c, Offset: 0x14df
// Size: 0xc7
function function_9e864832ad01ac0d( var_54b132d0c562c6b1 )
{
    verifyresult = spawnstruct();
    verifyresult.var_59843231c822ceab = 1;
    collisioncontents = trace::create_contents( 0, 1, 1, 1, 0, 1 );
    ignorelist = [];
    anglesbackward = anglestoforward( self.angles ) * -1;
    offset = anglesbackward * 150;
    hitresult = physics_raycast( var_54b132d0c562c6b1, var_54b132d0c562c6b1 + offset, collisioncontents, ignorelist, 0, "physicsquery_closest" );
    
    if ( hitresult.size > 0 )
    {
        verifyresult.var_59843231c822ceab = 0;
        verifyresult.distancesquared = distance2dsquared( var_54b132d0c562c6b1, hitresult[ 0 ][ "position" ] );
    }
    
    return verifyresult;
}

// Namespace remote_robot
// Params 0
// Checksum 0x76f70b3f, Offset: 0x15af
// Size: 0x67
function function_226074f15c61b467()
{
    assert( killstreak::isjuggernaut(), "<dev string:x2d>" );
    juggconfig = self.juggcontext.juggconfig ?? level.juggconfig;
    minigunweaponobj = weapon_utility::function_d2c8356dc369d9ce( juggconfig.classstruct.loadoutprimary );
    return minigunweaponobj;
}

// Namespace remote_robot
// Params 0, eflags: 0xc
// Checksum 0x4c8525f2, Offset: 0x161f
// Size: 0x11f
function private function_fde35f1461ef68b1()
{
    self notify( #"hash_94564e72cfd1ddc6" );
    self endon( #"hash_94564e72cfd1ddc6" );
    self endon( #"juggernaut_removed" );
    level endon( #"game_ended" );
    msg = utility::waittill_any_return( "remote_robot_activate", "joined_team", "death_or_disconnect" );
    
    if ( msg == "remote_robot_activate" )
    {
        msg = utility::waittill_any_return( "intro_sequence_started", "joined_team" );
        
        if ( msg == "intro_sequence_started" )
        {
            self waittill( #"joined_team" );
            
            if ( self.body )
            {
                self.body hide();
            }
            
            jugginitialized = 1;
        }
        
        self stopcinematicforplayer();
        self setclientomnvar( "ui_using_killstreak_remote", 0 );
        namespace_9d8e359c3b1041e5::function_f6af4ffa6dbb4645( "remote_robot", "on" );
        killstreak_shared::function_9fc2f7ee10890d99( "remote_robot" );
        
        if ( jugginitialized )
        {
            juggernaut::jugg_removejuggernaut( { #instantdeath:1 } );
        }
        else
        {
            removeremoterobot( { #instantdeath:1 } );
        }
        
        return;
    }
    
    if ( isdefined( self ) )
    {
        self setclientomnvar( "ui_using_killstreak_remote", 0 );
    }
}

// Namespace remote_robot
// Params 1
// Checksum 0x9dc30eec, Offset: 0x1746
// Size: 0x38
function function_d3dd5cf54318cdbb( streakinfo )
{
    self endon( #"intro_sequence_started" );
    level endon( #"game_ended" );
    self waittill( #"death_or_disconnect" );
    removeremoterobot();
}

// Namespace remote_robot
// Params 1
// Checksum 0x34158c6f, Offset: 0x1786
// Size: 0xcad
function activateremoterobot( streakinfo )
{
    self.var_a84311e2c57646de = undefined;
    self.takedamage = 1;
    function_eada01fb2fa988fd( "activate begin\n" );
    self notify( #"remote_robot_activate" );
    self endon( #"remote_robot_ended", #"joined_team" );
    level endon( #"game_ended" );
    thread function_d3dd5cf54318cdbb( streakinfo );
    dummyveh = spawnvehicle( "tag_origin", "script_vehicle", "veh_sat_remote_robot_empty", self.origin, self.angles );
    dummyveh enablelinkto();
    dummyveh linkto( self );
    self.var_cea7d03870dc1372 = dummyveh;
    self function_66dc8b6ae969f66d( 1 );
    
    if ( !isdefined( self.var_e6e285922d86ab7f ) )
    {
        function_eada01fb2fa988fd( "prepare for intro\n" );
        transitionfx = streakinfo.bundle.var_819962c339af1b4d ?? "sat_remote_robot_scorestreak_transition";
        fullscreenfxparams = { #visionset:undefined, #postfxbundlename:transitionfx };
        self [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_d6d2b1e7868b8f30" ] ]]( fullscreenfxparams );
        self playsoundtoplayer( "kls_jugbot_static_trans_plr", self );
        
        if ( self getscriptablepartstate( "remote_robot_intro_outro_fx", 1 ) != "intro" )
        {
            self setscriptablepartstate( "remote_robot_intro_outro_fx", "intro", 0 );
        }
        
        function_eada01fb2fa988fd( "freeze controls\n" );
        player::_freezecontrols( 1 );
        wait 0.38;
        function_eada01fb2fa988fd( "camo delay complete\n" );
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        if ( namespace_9d8e359c3b1041e5::issuperinusesharedfunc() )
        {
            if ( utility::issharedfuncdefined( #"supers", #"superusefinished" ) )
            {
                self thread [[ utility::getsharedfunc( #"supers", #"superusefinished" ) ]]( 0, 0, 1 );
            }
        }
        
        player::_freezecontrols( 0 );
        function_eada01fb2fa988fd( "freeze controls end\n" );
        self playcinematicforplayer( streakinfo.bundle.var_8dcf114aacb7a691 ?? "sat_scorestreak_transition" );
    }
    
    weapons::function_ef0cb557b1a93af9( self );
    thread function_9a9cfc886fefa649();
    thread function_3d88d06c1be4f2ed();
    
    if ( streakinfo.bundle.var_cfdb1d92778c12fd )
    {
        thread function_cad7693c8fafd6f( streakinfo.bundle );
    }
    
    self.damage.var_fbe723a36365e86c = 1;
    remoteroboton = 1;
    function_a5ac1081fc661eed( remoteroboton );
    function_6c1121cff1dae85( remoteroboton );
    function_eada01fb2fa988fd( "player values and movement capabilities set\n" );
    weapon_utility::setlockedoncallback( self, &lockedoncallback );
    weapon_utility::setlockedonremovedcallback( self, &lockedonremovedcallback );
    weapon_utility::setincomingcallback( self, &incomingcallback );
    weapon_utility::setincomingremovedcallback( self, &incomingremovedcallback );
    customization = operator::getoperatorcustomization();
    bundle = streakinfo.bundle;
    modifiedlifetime = bundle.remoterobotlifetime ?? 60;
    
    if ( utility::issharedfuncdefined( #"juggernaut", #"hash_218fc0adf5bd9638" ) )
    {
        modifiedlifetime = utility::callsharedfunc( #"juggernaut", #"hash_218fc0adf5bd9638", modifiedlifetime );
    }
    
    streakinfo.streakduration = modifiedlifetime;
    juggcontext = { #lifetimeendtime:int( modifiedlifetime * 1000 + gettime() ), #streakinfo:streakinfo, #var_80684ddb68796647:!( bundle.var_2efbf315050c1117 ?? 0 ), #var_d12b1fde7880be25:self.var_d1b3f29a9c852576, #var_cd97b289c3fd6df7:self.var_aab5beb67c1704ec ?? 0, #var_307d13ca97e891d9:bundle.var_1f78f26ee860c087 ?? 1, #var_fb68c148d6ef3479:bundle.var_76a486bf714fc163 ?? 1, #hidefromhellstorm:bundle.var_a8dacb956eececb0 ?? 1, #prevexecution:self.operatorcustomization.execution, #var_47d906c0c5d19d0a:streakinfo.var_47d906c0c5d19d0a, #prevoperator:operator::function_30f20ce375c4ee40( self.operatorcustomization.skinref ), #prevsuit:self.operatorcustomization.suit, #prevskin:self.operatorcustomization.skinref, #activationangles:self.angles, #activationorigin:self.origin, #maskomnvar:"ui_gas_mask_juggernaut", #var_4d02add3473b34e7:self.disable_third_person_toggle, #var_5e8ed45dc891b7a2:self.perkthirdperson, #prevstance:self getstance(), #var_975438351ed2702c:self.operatorcustomization.geartype, #prevclothtype:self.clothtype, #prevhead:customization[ 1 ], #prevbody:customization[ 0 ], #prevclass:self.class, #prevhealth:self.health, #prevmaxhealth:self.maxhealth };
    function_eada01fb2fa988fd( "juggcontext created\n" );
    movingplatforminfo = airdrop::function_6d2c704914d1e4b5( self.origin );
    
    if ( movingplatforminfo.groundent && !movingplatforminfo.groundent vehicle::is_vehicle() )
    {
        juggcontext.var_e2cfe4439bfa8b61 = movingplatforminfo.groundent;
        juggcontext.movingplatformoffset = self.origin - movingplatforminfo.groundent.origin;
    }
    
    self.juggcontext = juggcontext;
    function_eada01fb2fa988fd( "juggcontext set\n" );
    
    if ( isdefined( bundle.remoterobotexecution ) )
    {
        execution::_giveexecution( bundle.remoterobotexecution );
    }
    
    loadoutperks = self.loadoutperks;
    
    foreach ( perk in loadoutperks )
    {
        while ( isdefined( self.perks[ perk ] ) )
        {
            perk::removeperk( perk );
        }
    }
    
    perk::giveperk( "specialty_remote_robot" );
    function_eada01fb2fa988fd( "perks set\n" );
    saveperks = bundle.var_e0fba1331c96860f ?? 1;
    juggcontext.respawnitems = class::respawnitems_saveplayeritemstostruct( 1, 1, 0, saveperks, 1 );
    
    if ( utility::issharedfuncdefined( #"remote_robot", #"hash_faa2ffebcab9bda2" ) )
    {
        utility::callsharedfunc( #"remote_robot", #"hash_faa2ffebcab9bda2", juggcontext.respawnitems );
    }
    
    function_eada01fb2fa988fd( "respawn items set\n" );
    weaplist = self getweaponslistprimaries();
    
    foreach ( weap in weaplist )
    {
        inventory_utility::_takeweapon( weap );
    }
    
    if ( game_utility_mp::function_4818e8dcc8c3ec96() && !self.ignoreskydiving )
    {
        self skydive_setbasejumpingstatus( 0 );
    }
    
    streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
    waitframe();
    function_eada01fb2fa988fd( "killstreak_finished_with_deploy_weapon notified\n" );
    callback::callback( #"hash_21d7e4119185d412" );
    self.isjuggernaut = 1;
    self.var_56e1683c857afcf5 = undefined;
    self.var_e4dae87a649544c3 = 1;
    self.var_dc35d76e762774ed = 1;
    self.juggernautmodifydamage = bundle.var_6f1178426a21e8da ?? 1;
    self.var_e74f076f63e44ec0 = 18;
    self.var_aab5beb67c1704ec = 1;
    self.var_7cd86348fc758d00 = bundle.empedscoreevent;
    self.var_d1b3f29a9c852576 = ( 0, 0, 40 );
    remoterobothealth = bundle.maxhealth ?? 4000;
    self.maxhealth = remoterobothealth;
    self.health = remoterobothealth;
    killstreak_utility::function_bea4bda17e40ffb0( self );
    remoterobotweaponname = utility::get_scripted_weapon_name( #"remote_robot" );
    juggcontext.classstruct = { #loadoutprimary:remoterobotweaponname };
    remoterobotweapon = weapon::buildweapon( remoterobotweaponname );
    inventory_utility::_giveweapon( remoterobotweapon );
    inventory_utility::_switchtoweaponimmediate( remoterobotweapon );
    weapon::fixupplayerweapons( self, remoterobotweapon );
    item_weapon::function_f9f12ddfa1766b72();
    function_eada01fb2fa988fd( "weapons set up\n" );
    juggcontext.juggconfig = level.juggconfig;
    
    if ( !isdefined( self.var_ec0bb630fbaa253a ) )
    {
        self.var_ec0bb630fbaa253a = [];
    }
    
    streakinfo.streakname = "remote_robot";
    self.juggcontext.remoterobotweapon = remoterobotweapon;
    
    /#
        var_ae24eaad32921ae2 = getdvarint( @"hash_2c01d701bac5d9d3", 0 );
        
        if ( var_ae24eaad32921ae2 )
        {
            modifiedlifetime = 9999;
        }
        
        lifetimedebug = getdvarint( @"scr_killstreak_lifetime", 0 );
        
        if ( lifetimedebug > 0 )
        {
            modifiedlifetime = lifetimedebug;
        }
    #/
    
    streakinfo.lifetime = modifiedlifetime;
    self.var_941f0a8363236c43 = self getthreatbiasgroup();
    createthreatbiasgroup( "remote_robot" );
    self setthreatbiasgroup( "remote_robot" );
    self notify( #"jugg_mask_off" );
    self.juggoverlaystatelabel = undefined;
    self.juggoverlaystate = undefined;
    self.juggcontext.enemieskilled = 0;
    self setclientomnvar( juggcontext.maskomnvar, 0 );
    self setclientomnvar( "ui_remote_robot_enemies_killed", self.juggcontext.enemieskilled );
    self.var_ec0bb630fbaa253a[ remoterobotweaponname ] = streakinfo;
    self.var_ec0bb630fbaa253a[ "sat_remote_robot_timeout_explosion" ] = streakinfo;
    self.var_ec0bb630fbaa253a[ "sat_remote_robot_landing_explosion" ] = streakinfo;
    callback::add( #"player_damaged", &function_e05e7d5aa089092e );
    self.var_1d63f3432078fb2c = 1;
    functionals_utility::clearminimapid();
    
    if ( utility::issharedfuncdefined( #"game", #"createobjective" ) )
    {
        self.minimapid = self [[ utility::getsharedfunc( #"game", #"createobjective" ) ]]( bundle.minimapicon, self.team, 0, 1, 1 );
        objidpoolmanager::function_e4d6a71507372662( self.minimapid, 0 );
    }
    
    if ( bundle.var_4731da2e1fa2575e )
    {
        level utility::callsharedfunc( #"gametype", #"hash_c0713b1d38d78d84", self );
        
        if ( self.carryobject )
        {
            self.carryobject thread gameobjects::setdropped();
        }
    }
    
    if ( !self.var_7193c22a10fb5738 )
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hud" ][ #"teamplayercardsplash" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            self [[ var_32dbca3143d9c4a5 ]]( streakinfo.bundle.usedsplashref, self );
        }
    }
    
    var_a61c289e6ab22688 = streakinfo.bundle.var_780d4a5ebbb3d1a2 ?? 10000;
    function_eada01fb2fa988fd( "wait before watch threads\n" );
    waitframe();
    self setclientomnvar( "ui_remote_robot_lifetime_timer", streakinfo.lifetime * 1000 );
    thread function_5bd122ed059fc1ab( streakinfo, var_a61c289e6ab22688 );
    thread function_d475ccedac0aeb2b( streakinfo );
    thread function_7014eab38cc786fb( streakinfo );
    thread watchgameended( streakinfo );
    namespace_9d8e359c3b1041e5::emp_debuff_register_sharedfunc( self, &empapplied, undefined, undefined );
    
    if ( level.var_36218e71baa7e689 )
    {
        self.var_c5ccf9dff3b5e393 = &function_c5886af82b5f3df;
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"assisted_targeting" ][ #"applydisabled" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]();
    }
    
    return 1;
}

// Namespace remote_robot
// Params 1
// Checksum 0xecefdbae, Offset: 0x243c
// Size: 0x5ef
function function_d475ccedac0aeb2b( streakinfo )
{
    self endon( #"remote_robot_ended" );
    self notify( #"intro_sequence_started" );
    function_eada01fb2fa988fd( "intro sequence started\n" );
    
    if ( !isdefined( self.var_e6e285922d86ab7f ) )
    {
        var_a61c289e6ab22688 = streakinfo.bundle.var_780d4a5ebbb3d1a2 ?? 10000;
        neworigin = streakinfo.dropposition + ( 0, 0, var_a61c289e6ab22688 );
        startpos = neworigin;
        endpos = neworigin - ( 0, 0, 12000 );
        var_7b9ae2047be4c11d = trace::create_contents( 0, 1, 0, 1, 1, 0 );
        groundresult = physics_raycast( startpos, endpos, var_7b9ae2047be4c11d, undefined, 0, "physicsquery_closest" );
        groundpos = groundresult[ 0 ][ "position" ] ?? streakinfo.dropposition;
        
        if ( utility::issharedfuncdefined( #"remote_robot", #"remote_robot_portal_spawn" ) )
        {
            thread utility::callsharedfunc( #"remote_robot", #"remote_robot_portal_spawn", self, neworigin );
        }
        
        function_eada01fb2fa988fd( "setting up scene\n" );
        self.animname = "Player 1";
        self.juggcontext.scene_struct = utility::spawn_model( "tag_origin", neworigin, self.angles );
        self.juggcontext.scene_struct scene::set_scriptbundle( "sat_scorestreak_remote_robot" );
        self.juggcontext.scene_struct.var_3544485fbc851ac2 = "tag_player";
        self showlegs();
        self.falldamageprotection = 1;
        self.juggcontext.scene_struct thread scene::play( [ self ], "shot_010", "sat_scorestreak_remote_robot" );
        function_eada01fb2fa988fd( "scene play started\n" );
        bundle = killstreak::function_85b2d8e857ab4898( "remote_robot" );
        skintype = self.team == "axis" ? bundle.var_bfb2f1773c87e8b4 : bundle.remoterobotskin;
        function_d5c0b70528396ad2( skintype, bundle.remoterobotsuit );
        self lerpfovbypreset( "remote_robot_intro" );
        fullscreenfxparams = { #visionsetname:undefined, #postfxbundlename:"cer_mp_rcxd_drive" };
        self [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_d6d2b1e7868b8f30" ] ]]( fullscreenfxparams );
        val::set( "remote_robot", "fire", 0 );
        self.takedamage = 0;
        val::set( "remote_robot", "interacts_with_oob_triggers", 0 );
        player::_freezecontrols( 1 );
        function_eada01fb2fa988fd( "descent started\n" );
        self.juggcontext.scene_struct thread robot_descent( self, groundpos );
        utility::waittill_any( "remote_robot_landed", "remote_robot_ended" );
        function_eada01fb2fa988fd( "descent ended\n" );
        var_bf41620fc37842d8 = bundle.var_bf41620fc37842d8 ?? 50;
        var_ccf29e46628fffbf = bundle.var_ccf29e46628fffbf ?? 200;
        var_cccf8c4662699071 = bundle.var_cccf8c4662699071 ?? 50;
        
        /#
            if ( getdvarint( @"hash_2a7e29e8884635a3", 0 ) )
            {
                sphere( groundpos, var_bf41620fc37842d8, ( 1, 0, 0 ), 0, 100 );
            }
        #/
        
        self radiusdamage( groundpos, var_bf41620fc37842d8, var_ccf29e46628fffbf, var_cccf8c4662699071, self, "MOD_CRUSH", "sat_remote_robot_landing_explosion" );
        self.juggcontext.scene_struct scene::stop();
        self.juggcontext.scene_struct.origin = groundpos;
        self.falldamageprotection = 0;
        self [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_fd9af8d6ec7cc6fb" ] ]]( spawnstruct() );
        self lerpfovbypreset( "default" );
        self.juggcontext.scene_struct scene::play( [ self ], "shot_020", "sat_scorestreak_remote_robot" );
        self stopanimscriptsceneevent();
    }
    else
    {
        bundle = killstreak::function_85b2d8e857ab4898( "remote_robot" );
        skintype = self.team == "axis" ? bundle.var_bfb2f1773c87e8b4 : bundle.remoterobotskin;
        function_d5c0b70528396ad2( skintype, bundle.remoterobotsuit );
    }
    
    thread function_310647bcdbdbff9();
    val::reset( "remote_robot", "fire" );
    val::reset( "remote_robot", "interacts_with_oob_triggers" );
    self.takedamage = 1;
    self disableusability();
    self notify( #"remote_robot_intro_ended" );
    self.disable_third_person_toggle = 1;
    perkfunctions::setthirdpersonmode();
    self function_5dd5184dca17e29b( 0 );
    waitframe();
    self function_5dd5184dca17e29b( 1 );
    player::_freezecontrols( 0 );
    
    if ( !self.var_32b5f6d602b8ffc8 )
    {
        thread function_a1e03f6f9f4a3f0d();
    }
    
    self notify( #"intro_landing_finished" );
    self setclientomnvar( "ui_using_killstreak_remote", 0 );
    namespace_9d8e359c3b1041e5::function_f6af4ffa6dbb4645( "remote_robot", "on" );
    killstreak_shared::function_9fc2f7ee10890d99( "remote_robot" );
    hideoverlaytargetmarkerfriendly = 0;
    var_598d79add3230927 = streakinfo.bundle.var_598d79add3230927;
    var_f057b69340b14a5c = streakinfo.bundle.var_f057b69340b14a5c;
    params = { #var_4ef38b0aefb507c6:var_f057b69340b14a5c, #var_d33b439c3dce3f3d:var_598d79add3230927, #hideoverlaytargetmarkerfriendly:hideoverlaytargetmarkerfriendly };
    killstreak_shared::killstreak_assigntargetmarkers( params );
    thread function_fc87adc3374cc9b3( streakinfo );
}

// Namespace remote_robot
// Params 1, eflags: 0x4
// Checksum 0xb1250300, Offset: 0x2a33
// Size: 0xe2
function private function_fc87adc3374cc9b3( streakinfo )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"remote_robot_ended" );
    var_4565558cb4444c1e = [];
    bundle = killstreak::function_85b2d8e857ab4898( streakinfo.streakname );
    
    foreach ( data in bundle.var_e0715b47471288fb )
    {
        var_4565558cb4444c1e[ var_4565558cb4444c1e.size ] = data.killstreakname;
    }
    
    killstreak_shared::function_505d16f50dee75d2( var_4565558cb4444c1e );
}

// Namespace remote_robot
// Params 2, eflags: 0x4
// Checksum 0x1dbdfb7a, Offset: 0x2b1d
// Size: 0x288
function private robot_descent( player, groundpos )
{
    player endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    player endon( #"remote_robot_ended" );
    scene_struct = self;
    gravity = getdvarfloat( @"bg_gravity", 800 );
    startz = scene_struct.origin[ 2 ];
    endz = groundpos[ 2 ];
    assert( startz > endz, "<dev string:x82>" );
    posz = startz;
    velz = 0;
    lasttime = gettime();
    glasspositions = function_b9c90667fb9126fa( player.origin, groundpos );
    glassindex = 0;
    checkglass = glasspositions.size > 0;
    
    while ( posz > endz )
    {
        player val::set( "remote_robot", "show_ui_out_of_bounds", 0 );
        currenttime = gettime();
        frametime = ( currenttime - lasttime ) * 0.001;
        lasttime = currenttime;
        velz += gravity * -1 * frametime;
        var_213ea50e4377cc5f = posz + velz * frametime;
        
        if ( checkglass )
        {
            if ( posz >= glasspositions[ glassindex ][ 2 ] && var_213ea50e4377cc5f <= glasspositions[ glassindex ][ 2 ] || abs( posz - glasspositions[ glassindex ][ 2 ] ) < 10 )
            {
                glassradiusdamage( glasspositions[ glassindex ], 175, 1000, 1000 );
                glassindex++;
                checkglass = glassindex < glasspositions.size;
            }
        }
        
        currpos = player.origin;
        nextpos = player.origin + ( 0, 0, var_213ea50e4377cc5f );
        var_113555c7430c0744 = trace::create_contents( 0, 0, 0, 0, 0, 1 );
        var_27061cd880775f77 = physics_raycast( currpos, nextpos, var_113555c7430c0744, undefined, 0, "physicsquery_closest" );
        
        if ( var_27061cd880775f77.size > 0 )
        {
            vehentity = var_27061cd880775f77[ 0 ][ "entity" ];
            vehentity dodamage( vehentity.health, nextpos, player, player, "MOD_SCORESTREAK" );
        }
        
        posz = var_213ea50e4377cc5f;
        
        if ( posz < endz )
        {
            posz = endz;
        }
        
        if ( isdefined( scene_struct ) )
        {
            scene_struct.origin = ( scene_struct.origin[ 0 ], scene_struct.origin[ 1 ], posz );
        }
        
        waitframe();
    }
    
    player notify( #"remote_robot_landed" );
}

// Namespace remote_robot
// Params 2, eflags: 0x4
// Checksum 0xf70c3276, Offset: 0x2dad
// Size: 0xf7
function private function_b9c90667fb9126fa( startpos, endpos )
{
    var_872b3dd7d8e6e720 = trace::create_contents( 0, 0, 1 );
    glassresults = physics_raycast( startpos, endpos, var_872b3dd7d8e6e720, undefined, 0, "physicsquery_closest" );
    glasspositions = [];
    glassindex = 0;
    
    foreach ( glassresult in glassresults )
    {
        surfacetype = physics_getsurfacetypefromflags( glassresult[ "surfaceflags" ] );
        
        if ( surfacetype[ "name" ] == "surftype_glass_pane" )
        {
            glasspositions[ glassindex ] = glassresult[ "position" ];
            glassindex++;
        }
    }
    
    return glasspositions;
}

// Namespace remote_robot
// Params 1
// Checksum 0xc6fe5949, Offset: 0x2ead
// Size: 0x8c
function watchgameended( streakinfo )
{
    self endon( #"death_or_disconnect", #"juggernaut_removed" );
    level waittill( #"game_ended" );
    
    if ( self && streakinfo )
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"killstreak" ][ #"hash_bf17c172d25e8b3d" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            self [[ var_32dbca3143d9c4a5 ]]( streakinfo );
        }
    }
    
    wait 0.5;
    
    if ( self )
    {
        juggernaut::jugg_removejuggernaut( { #instantdeath:1 } );
    }
}

// Namespace remote_robot
// Params 1
// Checksum 0x332e7640, Offset: 0x2f41
// Size: 0x73
function function_7014eab38cc786fb( streakinfo )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self endon( #"juggernaut_removed" );
    self waittill( #"remote_robot_manual_exit", instantdeath );
    damagedata = spawnstruct();
    
    if ( instantdeath )
    {
        damagedata.instantdeath = 1;
    }
    
    juggernaut::jugg_removejuggernaut( damagedata );
}

// Namespace remote_robot
// Params 2
// Checksum 0x88a51146, Offset: 0x2fbc
// Size: 0x1a6
function function_5bd122ed059fc1ab( streakinfo, startingheight )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self endon( #"juggernaut_removed" );
    var_9d8e288d4d2a1acf = 1 / ( level.framedurationseconds ?? 0.016 );
    var_e0c7f53f1576bc69 = self getlocalgravity();
    droptime = sqrt( 2 * startingheight / var_e0c7f53f1576bc69 );
    var_17530b1167ed3df1 = 1 / droptime / var_9d8e288d4d2a1acf;
    dropprogress = 0;
    
    while ( true )
    {
        dropprogress += var_17530b1167ed3df1;
        
        if ( dropprogress >= 1 )
        {
            dropprogress = 1;
            self setclientomnvar( "ui_remote_robot_lifetime_progress", dropprogress );
            break;
        }
        
        self setclientomnvar( "ui_remote_robot_lifetime_progress", dropprogress );
        waitframe();
    }
    
    if ( !isdefined( self.var_e6e285922d86ab7f ) )
    {
        self waittill( #"intro_landing_finished" );
    }
    
    timeouttime = gettime() + streakinfo.lifetime * 1000;
    
    if ( streakinfo.bundle.var_641d6a75f1c561cf )
    {
        thread function_4552995e996638f( streakinfo.bundle, streakinfo.lifetime );
    }
    
    while ( true )
    {
        remainingtime = timeouttime - gettime();
        self setclientomnvar( "ui_remote_robot_lifetime_timer", max( remainingtime, 0 ) );
        self setclientomnvar( "ui_remote_robot_lifetime_progress", max( remainingtime / streakinfo.lifetime * 1000, 0 ) );
        
        if ( remainingtime <= 0 )
        {
            break;
        }
        
        waitframe();
    }
    
    juggernaut::jugg_removejuggernaut();
}

// Namespace remote_robot
// Params 0
// Checksum 0x4a2e8194, Offset: 0x316a
// Size: 0x206
function function_310647bcdbdbff9()
{
    self notify( #"hash_82184f896e98b2d0" );
    self endon( #"hash_82184f896e98b2d0" );
    self endon( #"remote_robot_ended", #"disconnect" );
    
    if ( !isdefined( self.juggcontext.var_a82ef22299b4c38c ) )
    {
        self.juggcontext.var_a82ef22299b4c38c = [];
    }
    
    bundle = killstreak::function_85b2d8e857ab4898( "remote_robot" );
    remoterobothudoutline = bundle.remoterobothudoutline ?? "sat_remote_robot_enemy";
    bundle = undefined;
    
    while ( true )
    {
        enemies = teams::getenemyplayers( self.team, 0 );
        
        foreach ( enemy in enemies )
        {
            throttle::throttle_wait_in_queue( level.juggconfig.var_3732cb298af9e000, self );
            
            if ( !isdefined( enemy ) )
            {
                continue;
            }
            
            var_94748e1809081c3a = self.juggcontext.var_a82ef22299b4c38c[ enemy.guid ];
            
            if ( isdefined( enemy.perks[ "specialty_coldblooded" ] ) || !isalive( enemy ) || enemy.juggcontext )
            {
                if ( var_94748e1809081c3a )
                {
                    outline::outlinedisable( var_94748e1809081c3a, enemy );
                    self.juggcontext.var_a82ef22299b4c38c[ enemy.guid ] = undefined;
                }
                
                continue;
            }
            
            if ( var_94748e1809081c3a )
            {
                continue;
            }
            
            self.juggcontext.var_a82ef22299b4c38c[ enemy.guid ] = outline::outlineenableforplayer( enemy, self, remoterobothudoutline, "killstreak" );
        }
        
        wait 0.1;
    }
}

// Namespace remote_robot
// Params 1, eflags: 0x4
// Checksum 0x6e68cccf, Offset: 0x3378
// Size: 0x39
function private function_c5886af82b5f3df( data )
{
    data.attacker thread points::doscoreevent( #"remote_robot_destroyed", data.objweapon );
    juggernaut::jugg_removejuggernaut();
}

// Namespace remote_robot
// Params 0
// Checksum 0xd6cda3b2, Offset: 0x33b9
// Size: 0x145
function function_e76a54331a052d4d()
{
    bundle = level.streakglobals.streakbundles[ "remote_robot" ];
    timeoutexplosionradius = bundle.var_9f9dbc6d77e20d40 ?? 100;
    var_d1b43559cfa167f9 = bundle.var_4496093b1e3b0ad7 ?? 200;
    var_d1912759cf7b0177 = bundle.var_44b8f73b1e612af9 ?? 50;
    var_68ec7c02c8843ccd = 0;
    var_f1cac1798741bde6 = { #objweapon:"sat_remote_robot_timeout_explosion", #damagemin:var_d1912759cf7b0177, #damagemax:var_d1b43559cfa167f9, #radius:timeoutexplosionradius };
    
    /#
        if ( getdvarint( @"hash_2a7e29e8884635a3", 0 ) )
        {
            sphere( self.origin, timeoutexplosionradius, ( 1, 0, 0 ), 0, 60 );
        }
    #/
    
    if ( utility::issharedfuncdefined( #"remote_robot", #"hash_2e29256d840c1a5f" ) )
    {
        var_68ec7c02c8843ccd = utility::callsharedfunc( #"remote_robot", #"hash_2e29256d840c1a5f", var_f1cac1798741bde6 );
    }
    
    self radiusdamage( self.origin, timeoutexplosionradius, var_d1b43559cfa167f9, var_d1912759cf7b0177, self, "MOD_EXPLOSIVE", "sat_remote_robot_timeout_explosion", var_68ec7c02c8843ccd );
}

// Namespace remote_robot
// Params 1
// Checksum 0x2af1d4ec, Offset: 0x3506
// Size: 0x1dd
function playdeathfx( instantdeath )
{
    bundle = killstreak::function_85b2d8e857ab4898( "remote_robot" );
    
    if ( self.suit != bundle.remoterobotsuit )
    {
        return;
    }
    
    if ( instantdeath )
    {
        self setscriptablepartstate( "death_fx", "instant_death" );
        waitframe();
    }
    else
    {
        val::set( "remote_robot", "fire", 0 );
        self setscriptablepartstate( "death_fx", "on" );
        
        if ( isdefined( self.juggcontext.scene_struct ) )
        {
            self.juggcontext.scene_struct delete();
        }
        
        self.juggcontext.scene_struct = utility::spawn_model( "tag_origin", self.origin, self.angles );
        self.juggcontext.scene_struct.var_3544485fbc851ac2 = undefined;
        self.juggcontext.scene_struct scene::set_scriptbundle( "sat_scorestreak_remote_robot_death" );
        self.juggcontext.scene_struct thread scene::play( [ self ], "shot_010", "sat_scorestreak_remote_robot_death" );
        emp_debuff::play_emp_scramble( bundle.var_33622da4f3c62a36 ?? 3 );
        self.takedamage = 0;
        utility::waittill_any_timeout( bundle.var_3b7f8da5aa3ba402 ?? 0, "remote_robot_ended" );
        self.juggcontext.scene_struct thread scene::stop();
        self.takedamage = 1;
        emp_debuff::stop_emp_scramble( bundle.var_33622da4f3c62a36 ?? 3 );
        val::reset( "remote_robot", "fire" );
        self setscriptablepartstate( "death_fx", "off" );
    }
    
    function_e76a54331a052d4d();
}

// Namespace remote_robot
// Params 1
// Checksum 0x388a36b, Offset: 0x36eb
// Size: 0x2d
function function_42df8ef766e7ad78( params )
{
    if ( params.smeansofdeath == "MOD_TRIGGER_HURT" )
    {
        params.idamage = 0;
    }
}

// Namespace remote_robot
// Params 1
// Checksum 0x19bac420, Offset: 0x3720
// Size: 0x90a
function removeremoterobot( damagedata )
{
    player = self;
    
    if ( utility::issharedfuncdefined( #"remote_robot", #"hash_dc4fcbad159518e1" ) )
    {
        player utility::callsharedfunc( #"remote_robot", #"hash_dc4fcbad159518e1" );
    }
    
    if ( !player callback::exists( #"hash_652eb614ba902b3d", &function_42df8ef766e7ad78 ) )
    {
        player callback::add( #"hash_652eb614ba902b3d", &function_42df8ef766e7ad78 );
    }
    
    if ( player.var_cea7d03870dc1372 )
    {
        if ( player.var_cea7d03870dc1372 islinked() )
        {
            player.var_cea7d03870dc1372 unlink();
        }
        
        player.var_cea7d03870dc1372 delete();
    }
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( isdefined( damagedata.attacker.team ) && player_utility::isenemy( damagedata.attacker ) )
    {
        player thread killstreak_utility::playkillstreaktacomdialog( player.juggcontext.streakinfo, undefined, #"destroyed" );
        
        if ( damagedata.attacker )
        {
            damagedata.attacker battlechatter_mp::killstreakdestroyed( "remote_robot" );
        }
    }
    
    player playdeathfx( damagedata.instantdeath );
    
    if ( isdefined( player.juggcontext.scene_struct ) )
    {
        player.juggcontext.scene_struct scene::stop();
        player.juggcontext.scene_struct delete();
        player.juggcontext.scene_struct = undefined;
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"assisted_targeting" ][ #"removedisabled" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        player [[ var_32dbca3143d9c4a5 ]]();
    }
    
    player function_66dc8b6ae969f66d( 0 );
    self disableplayermarks( #"killstreak" );
    
    if ( utility::issharedfuncdefined( #"killstreak", #"removefromactivekillstreaklist" ) )
    {
        self [[ utility::getsharedfunc( #"killstreak", #"removefromactivekillstreaklist" ) ]]( self getentitynumber() );
    }
    
    weapons::function_d5eafafe8f6a97bf( player );
    player perk::removeperk( "specialty_remote_robot" );
    player callback::remove( #"player_damaged", &function_e05e7d5aa089092e );
    player.var_1d63f3432078fb2c = undefined;
    weapon_utility::setlockedoncallback( player, undefined );
    weapon_utility::setlockedonremovedcallback( player, undefined );
    weapon_utility::setincomingcallback( player, undefined );
    weapon_utility::setincomingremovedcallback( player, undefined );
    
    if ( damagedata.attacker && damagedata.attacker != player )
    {
        damagedata.attacker points::doscoreevent( #"remote_robot_destroyed", damagedata.objweapon );
    }
    
    remoteroboton = 0;
    function_a5ac1081fc661eed( remoteroboton );
    function_6c1121cff1dae85( remoteroboton );
    player.damage.var_fbe723a36365e86c = 0;
    
    if ( isdefined( player.juggcontext ) )
    {
        player function_d5c0b70528396ad2( player.juggcontext.prevskin, player.juggcontext.prevsuit );
        player execution::_giveexecution( player.juggcontext.prevexecution );
    }
    
    if ( self ismantling() )
    {
        self cancelmantle();
    }
    
    if ( isalive( player ) && isdefined( player.juggcontext ) )
    {
        if ( self.isjuggernaut )
        {
            player inventory_utility::_takeweapon( player.juggcontext.remoterobotweapon );
        }
        
        item_weapon::function_f9f12ddfa1766b72();
        player switchtoweapon( player.juggcontext.var_47d906c0c5d19d0a );
        
        if ( !player.var_b8a3eb3d2a1c3998 )
        {
            var_373d2bc4e76f6fb3 = player.juggcontext.activationorigin;
            
            if ( isdefined( player.juggcontext.var_e2cfe4439bfa8b61 ) )
            {
                var_373d2bc4e76f6fb3 = player.juggcontext.var_e2cfe4439bfa8b61.origin + player.juggcontext.movingplatformoffset;
                
                if ( outofbounds::ispointinoutofbounds( var_373d2bc4e76f6fb3 ) )
                {
                    var_373d2bc4e76f6fb3 = getclosestpointonnavmesh( var_373d2bc4e76f6fb3 );
                }
            }
            
            player setorigin( var_373d2bc4e76f6fb3 );
            player setplayerangles( player.juggcontext.activationangles );
        }
        
        player.maxhealth = player.juggcontext.prevmaxhealth;
        player.health = player.maxhealth;
    }
    
    player killstreak_shared::function_b3302c4317df36c6();
    player functionals_utility::clearminimapid();
    player killstreak_utility::function_d546aaa588f088c3( "remote_robot", "off" );
    player killstreak_shared::function_76bbbe12ce816ed2();
    player enableusability();
    enemies = teams::getenemyplayers( self.team, 0 );
    
    foreach ( enemy in enemies )
    {
        var_94748e1809081c3a = self.juggcontext.var_a82ef22299b4c38c[ enemy.guid ];
        
        if ( var_94748e1809081c3a )
        {
            outline::outlinedisable( var_94748e1809081c3a, enemy );
        }
    }
    
    player callback::callback( #"on_remote_robot_ended" );
    player setjumpheightscale( 1 );
    player.isjuggernaut = 0;
    player.var_e4dae87a649544c3 = 0;
    player.var_dc35d76e762774ed = 0;
    
    if ( isdefined( player.juggcontext ) )
    {
        player.juggcontext.var_a82ef22299b4c38c = undefined;
        player.juggcontext.hidefromhellstorm = 0;
        player.juggcontext.var_fb68c148d6ef3479 = 0;
        player.var_aab5beb67c1704ec = player.juggcontext.var_cd97b289c3fd6df7;
        player.var_d1b3f29a9c852576 = player.juggcontext.var_d12b1fde7880be25;
        
        if ( isdefined( player.juggcontext.prevstance ) )
        {
            player setstance( player.juggcontext.prevstance, undefined, 1, 1 );
        }
        
        self.disable_third_person_toggle = player.juggcontext.var_4d02add3473b34e7;
    }
    else
    {
        self.disable_third_person_toggle = 0;
    }
    
    player.usingremote = undefined;
    player.var_7bbad00825f3c09a = 1;
    
    if ( !player.juggcontext.var_5e8ed45dc891b7a2 )
    {
        player perkfunctions::function_1a8b6c7b9a39972();
    }
    
    player.var_7cd86348fc758d00 = undefined;
    player namespace_9d8e359c3b1041e5::emp_debuff_deregister_sharedfunc( player );
    
    if ( level.var_36218e71baa7e689 )
    {
        player.var_c5ccf9dff3b5e393 = undefined;
    }
    
    player notify( #"stopped_using_remote" );
    player.var_7bbad00825f3c09a = undefined;
    
    if ( threatbiasgroupexists( self.var_941f0a8363236c43 ) )
    {
        self setthreatbiasgroup( self.var_941f0a8363236c43 );
    }
    
    self.var_941f0a8363236c43 = undefined;
    bundle = killstreak::function_85b2d8e857ab4898( "remote_robot" );
    
    if ( !isdefined( self.var_e6e285922d86ab7f ) )
    {
        transitionfx = bundle.var_819962c339af1b4d ?? "sat_remote_robot_scorestreak_transition";
        fullscreenfxparams = { #visionset:undefined, #postfxbundlename:transitionfx };
        self [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_d6d2b1e7868b8f30" ] ]]( fullscreenfxparams );
        self playsoundtoplayer( "kls_jugbot_static_trans_plr", self );
    }
    
    self setscriptablepartstate( "remote_robot_intro_outro_fx", "outro_add_camo", 0 );
    
    if ( game_utility_mp::function_4818e8dcc8c3ec96() && !self.ignoreskydiving )
    {
        self skydive_setbasejumpingstatus( 1 );
    }
    
    player killstreak_utility::recordkillstreakendstats( player.juggcontext.streakinfo );
    
    if ( isdefined( player.juggcontext ) )
    {
        level callback::callback( #"killstreak_finish_use", { #streakinfo:player.juggcontext.streakinfo } );
    }
    
    player notify( #"remote_robot_ended" );
    
    if ( player callback::exists( #"hash_652eb614ba902b3d", &function_42df8ef766e7ad78 ) )
    {
        player callback::remove( #"hash_652eb614ba902b3d", &function_42df8ef766e7ad78 );
    }
}

// Namespace remote_robot
// Params 2, eflags: 0x4
// Checksum 0xcba3e62d, Offset: 0x4032
// Size: 0x277
function private function_d5c0b70528396ad2( skin, suitoverride )
{
    self.operatorcustomization.skinref = skin;
    operator = operator::function_30f20ce375c4ee40( skin );
    suit = suitoverride ?? utility::function_f825237e0eda5adf();
    self.operatorcustomization.suit = suit;
    gender = operator::getoperatorgender( operator );
    clothtype = operator::function_b1788ccf1b3c0ae9( skin );
    geartype = operator::function_d633420b529828e8( skin );
    self setoperatorcustomization( operator, skin );
    bodymodelname = self getcustomizationbody();
    headmodelname = self getcustomizationhead();
    bodymodelname = teams::function_7c810013ad96976( bodymodelname, headmodelname );
    player::_setsuit( self.operatorcustomization.suit );
    
    if ( isdefined( self.headmodel ) )
    {
        self detach( self.headmodel );
    }
    
    self setmodel( bodymodelname );
    self.bodymodel = bodymodelname;
    
    if ( isdefined( headmodelname ) )
    {
        self attach( headmodelname, "", 1 );
        self.headmodel = headmodelname;
    }
    
    self notify( #"set_operator" );
    
    if ( gender == "1" )
    {
        self setclientgender( "female" );
        self.operatorcustomization.gender = "female";
    }
    else
    {
        self setclientgender( "" );
        self.operatorcustomization.gender = "male";
    }
    
    if ( !isdefined( clothtype ) || clothtype == "" )
    {
        clothtype = "vestlight";
    }
    
    if ( isdefined( self.operatorcustomization.clothtype ) && self.operatorcustomization.clothtype != clothtype )
    {
        self.operatorcustomization.clothtype = clothtype;
        self setclothtype( getxhash( clothtype ) );
    }
    
    if ( !isdefined( geartype ) || geartype == "" )
    {
        geartype = "millghtgr";
    }
    
    if ( isdefined( self.operatorcustomization.geartype ) && self.operatorcustomization.geartype != geartype )
    {
        self.operatorcustomization.geartype = geartype;
        self setgeartype( getxhash( geartype ) );
    }
}

// Namespace remote_robot
// Params 1
// Checksum 0x9648c4ea, Offset: 0x42b1
// Size: 0x9e
function setfullscreenfx( ison )
{
    bundle = level.streakglobals.streakbundles[ "remote_robot" ];
    fullscreenfxparams = { #postfxbundlename:bundle.var_5fe08ba318a2131f };
    
    if ( ison )
    {
        self [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_d6d2b1e7868b8f30" ] ]]( fullscreenfxparams );
        return;
    }
    
    self [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_fd9af8d6ec7cc6fb" ] ]]( fullscreenfxparams );
}

// Namespace remote_robot
// Params 1
// Checksum 0x526dc5fc, Offset: 0x4357
// Size: 0x12c
function function_a5ac1081fc661eed( remoteroboton )
{
    self allowcrouch( !remoteroboton );
    self allowprone( !remoteroboton );
    self allowslide( !remoteroboton );
    self allowdive( !remoteroboton );
    self allowsupersprint( !remoteroboton );
    
    if ( remoteroboton )
    {
        val::set( "remote_robot", "ladder", 0 );
        val::set( "remote_robot", "crate_use", 0 );
        val::set( "remote_robot", "swimming", 0 );
        val::set( "remote_robot", "weapon_pickup", 0 );
        val::set( "remote_robot", "offhand_throwback", 0 );
        self disableexecutionvictim();
        class::blockclasschange();
    }
    else
    {
        val::reset( "remote_robot", "ladder" );
        val::reset( "remote_robot", "crate_use" );
        val::reset( "remote_robot", "swimming" );
        val::reset( "remote_robot", "weapon_pickup" );
        val::reset( "remote_robot", "offhand_throwback" );
        self enableexecutionvictim();
        class::unblockclasschange();
    }
    
    if ( self.swim )
    {
        self.swim.var_401e9f3c6e4789da = remoteroboton;
    }
}

// Namespace remote_robot
// Params 1
// Checksum 0x3a0e2da4, Offset: 0x448b
// Size: 0x98
function function_6c1121cff1dae85( remoteroboton )
{
    val::set( "remote_robot", "health_regen", !remoteroboton );
    val::set( "remote_robot", "supers", !remoteroboton );
    val::set( "remote_robot", "killstreaks", !remoteroboton );
    val::set( "remote_robot", "equipment_primary", !remoteroboton );
    val::set( "remote_robot", "equipment_secondary", !remoteroboton );
    val::set( "remote_robot", "allow_emote", !remoteroboton );
    val::set( "remote_robot", "ledgehang", !remoteroboton );
}

// Namespace remote_robot
// Params 0
// Checksum 0xa438e07e, Offset: 0x452b
// Size: 0x9d
function function_9a9cfc886fefa649()
{
    self endon( #"death_or_disconnect" );
    self endon( #"remote_robot_ended" );
    bundle = killstreak::function_85b2d8e857ab4898( "remote_robot" );
    jumpheightscale = bundle.var_a7d9f6420a679214 ?? 1;
    
    while ( true )
    {
        utility::waittill_any( #"swim_breathing_disabled_begin", #"swim_breathing_disabled_end" );
        waitframe();
        
        if ( self.swim.underwater )
        {
            self setjumpheightscale( jumpheightscale );
        }
        else
        {
            self setjumpheightscale( 1 );
        }
        
        waitframe();
    }
}

// Namespace remote_robot
// Params 2
// Checksum 0x6a4c58ac, Offset: 0x45d0
// Size: 0xcf
function function_4552995e996638f( bundle, duration )
{
    if ( !bundle.var_641d6a75f1c561cf )
    {
        return;
    }
    
    self endon( #"remote_robot_ended" );
    self endon( #"disconnect" );
    self endon( #"death" );
    level endon( #"game_ended" );
    var_e06e6ccfab27c9f7 = bundle.var_4b348a9391c7f249 ?? 10;
    timeoutstarttime = duration - var_e06e6ccfab27c9f7;
    wait timeoutstarttime;
    self.soundent = spawn( "script_origin", self.origin );
    self.soundent showonlytoplayer( self );
    self.soundent playloopsound( bundle.var_641d6a75f1c561cf );
    thread function_33cfd4085e5018ba( bundle, var_e06e6ccfab27c9f7 );
}

// Namespace remote_robot
// Params 2
// Checksum 0x21179105, Offset: 0x46a7
// Size: 0x6b
function function_33cfd4085e5018ba( bundle, duration )
{
    if ( !bundle.var_641d6a75f1c561cf )
    {
        return;
    }
    
    utility::waittill_any_timeout( duration, "death", "remote_robot_ended" );
    
    if ( self.soundent )
    {
        self.soundent stoploopsound( bundle.var_641d6a75f1c561cf );
        self.soundent delete();
    }
}

// Namespace remote_robot
// Params 1
// Checksum 0x56e97a5c, Offset: 0x471a
// Size: 0x31
function function_952126ec59cb6a30( duration )
{
    utility::waittill_any_timeout( duration, "death", "remote_robot_ended" );
    self function_c67c92094ae6ccf7();
    self notify( #"radar_ping_end" );
}

// Namespace remote_robot
// Params 1
// Checksum 0xe62034df, Offset: 0x4753
// Size: 0x104
function function_cad7693c8fafd6f( bundle )
{
    self endon( #"remote_robot_ended" );
    self endon( #"disconnect" );
    self endon( #"death" );
    level endon( #"game_ended" );
    
    if ( bundle.var_fc2426ed24b89bc8 )
    {
        pingduration = bundle.remoterobotlifetime ?? 60;
    }
    
    if ( !isdefined( pingduration ) )
    {
        pingduration = bundle.var_c11039e6760bccbc ?? 0;
    }
    
    self.var_667ea7413e3ee64e = bundle.radarpingsweepradius;
    self waittill( #"remote_robot_intro_ended" );
    self setclientomnvar( "radar_ping", function_43b5ed5a14a56573( #"scriptbundle_killstreak", bundle.var_d80db24c90d421fb ) );
    self function_744ec8023439271f( int( bundle.radarpingsweepradius ), int( bundle.radarpingsweeptime * 1000 ), int( bundle.var_2962c1bc94835e40 * 1000 ) );
    thread function_952126ec59cb6a30( pingduration );
}

// Namespace remote_robot
// Params 0
// Checksum 0x462c72d9, Offset: 0x485f
// Size: 0x3a
function function_3d88d06c1be4f2ed()
{
    self endon( #"remote_robot_ended" );
    self endon( #"death" );
    level endon( #"game_ended" );
    self waittill( #"disconnect" );
    functionals_utility::clearminimapid();
}

// Namespace remote_robot
// Params 6
// Checksum 0x4322a537, Offset: 0x48a1
// Size: 0x110
function remoteRobotModifyDamageTaken( attacker, victim, objweapon, inflictor, smeansofdeath, damage )
{
    function_eada01fb2fa988fd( "remoteRobotModifyDamageTaken\n" );
    bundle = killstreak::function_85b2d8e857ab4898( "remote_robot" );
    
    if ( level.var_deb9d2b3de25799b && utility::issharedfuncdefined( #"killstreak", #"getmodifieddamageusingdamagetuning" ) )
    {
        damage = self [[ utility::getsharedfunc( #"killstreak", #"getmodifieddamageusingdamagetuning" ) ]]( attacker, objweapon, smeansofdeath, damage, self.maxhealth, bundle.var_20cb8f4e47f3353e, { #iskillstreak:1, #inflictor:inflictor } );
    }
    
    if ( utility::issharedfuncdefined( #"remote_robot", #"hash_e955882301181a5a" ) )
    {
        damage = utility::callsharedfunc( #"remote_robot", #"hash_e955882301181a5a", attacker, damage, smeansofdeath, objweapon, inflictor );
    }
    
    return damage;
}

// Namespace remote_robot
// Params 1
// Checksum 0x7d487d1d, Offset: 0x49ba
// Size: 0x1f
function function_e05e7d5aa089092e( damageparams )
{
    function_eada01fb2fa988fd( "remote robot damaged\n" );
    function_dd789d49042395f();
}

// Namespace remote_robot
// Params 0
// Checksum 0x97baf986, Offset: 0x49e1
// Size: 0xdc
function function_dd789d49042395f()
{
    bundle = level.streakglobals.streakbundles[ "remote_robot" ];
    healthpercent = self.health / self.maxhealth;
    
    if ( healthpercent <= ( bundle.var_28bf756d926348df ?? 0.25 ) )
    {
        utility::function_32b24db3127bff40( "body_damage", "heavy" );
        return;
    }
    
    if ( healthpercent <= ( bundle.var_f8214c78be43288f ?? 0.5 ) )
    {
        utility::function_32b24db3127bff40( "body_damage", "medium" );
        return;
    }
    
    if ( healthpercent <= ( bundle.var_f2e309c373b6a0b2 ?? 0.75 ) )
    {
        utility::function_32b24db3127bff40( "body_damage", "light" );
        return;
    }
    
    utility::function_32b24db3127bff40( "body_damage", "off" );
}

// Namespace remote_robot
// Params 1
// Checksum 0x266eae4e, Offset: 0x4ac5
// Size: 0xfa
function function_cd32264cb376a88a( params )
{
    attacker = params.attacker ?? params.eattacker;
    inflictor = params.inflictor ?? params.einflictor;
    
    if ( !isplayer( attacker ) )
    {
        return;
    }
    
    if ( player_utility::function_51a0c300008ab56b( self, attacker ) )
    {
        return;
    }
    
    if ( attacker.isjuggernaut == 0 || !isdefined( attacker.juggcontext.streakinfo ) )
    {
        return;
    }
    
    if ( attacker != inflictor )
    {
        return;
    }
    
    if ( attacker.var_bcf0a081c3d4a305 )
    {
        return;
    }
    
    attacker.juggcontext.streakinfo.kills++;
    attacker setclientomnvar( "ui_remote_robot_enemies_killed", attacker.juggcontext.streakinfo.kills );
}

// Namespace remote_robot
// Params 2, eflags: 0xc
// Checksum 0x2bf28537, Offset: 0x4bc7
// Size: 0xf7
function private function_6fe699c5d9519c2e( duration, magnitude )
{
    self notify( #"hash_1020738719b34c60" );
    self endon( #"hash_1020738719b34c60" );
    self endon( #"disconnect" );
    perk::removeperk( "specialty_remote_robot" );
    self allowsprint( 0 );
    self.remoterobotspeed = 0;
    
    for ( i = 0; i < 5 ; i++ )
    {
        self.remoterobotspeed -= magnitude;
        weapons::updatemovespeedscale();
        wait 0.2;
    }
    
    utility::waittill_any_timeout( duration, "remote_robot_ended", "death" );
    perk::giveperk( "specialty_remote_robot" );
    self allowsprint( 1 );
    
    for ( i = 0; i < 5 ; i++ )
    {
        self.remoterobotspeed += magnitude;
        weapons::updatemovespeedscale();
        wait 0.2;
    }
    
    self.remoterobotspeed = undefined;
}

// Namespace remote_robot
// Params 2, eflags: 0x4
// Checksum 0x9f4cde7, Offset: 0x4cc6
// Size: 0x239
function private scramblehud( duration, attacker )
{
    black_hat_data = attacker.black_hat_data;
    bundle = black_hat_data.bundle;
    black_hat_weapon = black_hat_data.weaponref;
    data = damage_utility::packdamagedata( attacker, self, 1, black_hat_weapon );
    data.doscoreevent = 0;
    emp_debuff::apply_emp_struct( data, 0, 1 );
    gamescore::trackdebuffassist( attacker, self, black_hat_weapon.basename );
    emp_debuff::play_emp_scramble( bundle.var_46cc13ca23ff97dd );
    
    if ( bundle.var_632bd4c2417cee0b )
    {
        self playloopsound( bundle.var_632bd4c2417cee0b );
    }
    
    if ( self.var_f997d7e36fbef3af )
    {
        foreach ( callback in self.var_f997d7e36fbef3af )
        {
            self [[ callback ]]();
        }
    }
    
    function_b262ef3b6aea5f88( duration );
    
    if ( self )
    {
        emp_debuff::remove_emp();
        
        if ( bundle.var_2ad1f7a54064db67 )
        {
            emp_debuff::stop_emp_scramble( bundle.var_46cc13ca23ff97dd );
            
            if ( bundle.var_632bd4c2417cee0b )
            {
                self stoploopsound( bundle.var_632bd4c2417cee0b, 1 );
            }
        }
        
        if ( player::isreallyalive( attacker ) )
        {
            gamescore::untrackdebuffassist( attacker, self, black_hat_weapon.basename );
        }
        
        if ( self.var_14a1cc3e3b76a02c )
        {
            foreach ( callback in self.var_14a1cc3e3b76a02c )
            {
                self [[ callback ]]();
            }
        }
    }
}

// Namespace remote_robot
// Params 1, eflags: 0x4
// Checksum 0x8ab9c973, Offset: 0x4f07
// Size: 0x27
function private function_b262ef3b6aea5f88( duration )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    wait duration;
}

// Namespace remote_robot
// Params 2, eflags: 0x4
// Checksum 0x93a29590, Offset: 0x4f36
// Size: 0xc2
function private hack( hackeffect, attacker )
{
    if ( !hackeffect.hackduration || !hackeffect.speedscale )
    {
        return;
    }
    
    thread killstreak_utility::playkillstreaktacomdialog( self.juggcontext.streakinfo, undefined, #"disrupted_hacked" );
    
    if ( self getscriptablehaspart( "hack" ) && self getscriptableparthasstate( "hack", "hack_shocked" ) )
    {
        self setscriptablepartstate( "hack", "hack_shocked" );
    }
    
    thread function_6fe699c5d9519c2e( hackeffect.hackduration / 1000, hackeffect.speedscale );
    thread scramblehud( hackeffect.hackduration / 1000, attacker );
}

// Namespace remote_robot
// Params 1, eflags: 0x4
// Checksum 0xa77fa0fa, Offset: 0x5000
// Size: 0xa3
function private empapplied( data )
{
    bundle = level.streakglobals.streakbundles[ "remote_robot" ];
    
    if ( !bundle.disruptionduration || !bundle.slowmagnitude )
    {
        return;
    }
    
    self setscriptablepartstate( "playerEMP", "on" );
    function_6fe699c5d9519c2e( bundle.disruptionduration, bundle.slowmagnitude );
    
    if ( isalive( self ) && self.isjuggernaut )
    {
        self setscriptablepartstate( "playerEMP", "off" );
    }
}

// Namespace remote_robot
// Params 0, eflags: 0x4
// Checksum 0xa00eebd2, Offset: 0x50ab
// Size: 0x14
function private lockedoncallback()
{
    vehicle_omnvar::show_warning( "missileLocking", self, "killstreak" );
}

// Namespace remote_robot
// Params 0, eflags: 0x4
// Checksum 0x7874eccf, Offset: 0x50c7
// Size: 0x14
function private lockedonremovedcallback()
{
    vehicle_omnvar::hide_warning( "missileLocking", self, "killstreak" );
}

// Namespace remote_robot
// Params 0, eflags: 0x4
// Checksum 0x2a6cac84, Offset: 0x50e3
// Size: 0x14
function private incomingcallback()
{
    vehicle_omnvar::show_warning( "missileIncoming", self, "killstreak" );
}

// Namespace remote_robot
// Params 0, eflags: 0x4
// Checksum 0x7c37c36a, Offset: 0x50ff
// Size: 0x14
function private incomingremovedcallback()
{
    vehicle_omnvar::hide_warning( "missileIncoming", self, "killstreak" );
}

// Namespace remote_robot
// Params 1, eflags: 0x4
// Checksum 0x622a4292, Offset: 0x511b
// Size: 0xd2
function private function_a1e03f6f9f4a3f0d( overrideholdtime )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"remote_robot_ended" );
    holdtime = 0.75;
    
    if ( isdefined( overrideholdtime ) )
    {
        holdtime = overrideholdtime;
    }
    
    updaterate = level.framedurationseconds;
    timerdirty = 1;
    
    while ( true )
    {
        timeused = 0;
        
        if ( timerdirty == 1 )
        {
            self setclientomnvar( "ui_exit_progress", 0 );
            timerdirty = 0;
        }
        
        while ( self usebuttonpressed() )
        {
            timeused += updaterate;
            timerdirty = 1;
            self setclientomnvar( "ui_exit_progress", timeused / holdtime );
            
            if ( timeused > holdtime )
            {
                self notify( #"remote_robot_manual_exit" );
                return;
            }
            
            wait updaterate;
        }
        
        wait updaterate;
    }
}

// Namespace remote_robot
// Params 1, eflags: 0x4
// Checksum 0x40a536d8, Offset: 0x51f5
// Size: 0x2c
function private function_eada01fb2fa988fd( str )
{
    if ( getbuildversion() != "SHIP" )
    {
        logstring( "REMOTE ROBOT LOG" + ": " + str );
    }
}

