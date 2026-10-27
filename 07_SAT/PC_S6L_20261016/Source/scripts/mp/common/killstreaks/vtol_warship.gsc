// scripts\mp\common\killstreaks\vtol_warship.gsc  (hash_71d46d098c1ba864.gscc) (size: 33044 Bytes / 0x8114 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6d722be5 (1836198885)
// size ...... 33044 (0x8114)
// includes .. 25  (offset: 0x7a04)
// strings ... 108 (offset: 0x7acc)
// dev strs .. 3   (offset: 0x80f0)
// exports ... 69  (offset: 0x4db8)
// cseg ...... 0x844 + 0x4574 (0x4db8)
// imports ... 276 (offset: 0x5880)
// animtree1 . 0   (offset: 0x8114)
// animtree2 . 0   (offset: 0x8114)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\killstreaks\killstreak_common;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\scene;
#using scripts\common\targetmarkergroups;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_omnvar_utility;
#using scripts\common\vehicle_tracking;
#using scripts\mp\common\killstreaks\chopper_support;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\shellshock_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\outofbounds;
#using scripts\mp\sentientpoolmanager;

#namespace vtol_warship;

// Namespace vtol_warship
// Params 0, eflags: 0x1
// Checksum 0xf3e41a70, Offset: 0x862
// Size: 0x17
function autoexec main()
{
    killstreak_shared::registerkillstreakinitfunction( getxhash( "vtol_warship" ), &vtolwarship_init );
}

// Namespace vtol_warship
// Params 0, eflags: 0x4
// Checksum 0x8a87a372, Offset: 0x881
// Size: 0x1b0
function private vtolwarship_init()
{
    killstreaks::registerkillstreak( "vtol_warship", &function_c1d54a36b82eb87 );
    utility::registersharedfunc( #"chopper_gunner", #"set_vehicle_hit_damage_data", &function_1278599b230de316 );
    utility::registersharedfunc( #"chopper_gunner", #"findtargetstruct", &vtolwarship_findtargetstruct );
    utility::registersharedfunc( #"chopper_gunner", #"hash_2ebe6213013cff11", &function_f91e87bc8ebda76 );
    
    /#
        setdevdvarifuninitialized( @"hash_71a6f6c87fec61ef", 0 );
        setdevdvarifuninitialized( @"hash_36f79934e22a53b5", 0 );
    #/
    
    bundle = killstreak_utility::function_f943c0602acdc2af( "vtol_warship" );
    function_a9482f05ec2eee15( bundle );
    utility::registersharedfunc( #"chopper_gunner", #"playintro", &function_2d629b17d5984d1a );
    level thread vtolwarship_register_on_kill_medal();
    utility::flag_set( "vtol_shared_initialized" );
    
    /#
        setdevdvarifuninitialized( @"hash_5053673c4770b74", 0 );
        setdevdvarifuninitialized( @"hash_f3fcf3899fa2e1b0", 0 );
        setdevdvarifuninitialized( @"hash_a34a2f5a7d33e3bb", 0 );
        setdevdvarifuninitialized( @"hash_804b68f93e7911ba", 1 );
        setdevdvarifuninitialized( @"hash_6dcbef72bd1fd758", 0 );
        setdevdvarifuninitialized( @"hash_c1fa04efebbe3e6b", -1 );
    #/
    
    val::group_register( "vtolWarshipUse", [ "killstreaks", "allow_movement", "fire", "weapon_switch", "melee", "usability", "shellshock", "allow_jump", "offhand_weapons" ] );
    namespace_9d8e359c3b1041e5::registervisibilityomnvarforkillstreaksharedfunc( "vtol_warship", "on", 27 );
}

// Namespace vtol_warship
// Params 1, eflags: 0x4
// Checksum 0x9ad4270a, Offset: 0xa39
// Size: 0x76
function private function_a9482f05ec2eee15( bundle )
{
    vehicle_turret = bundle.vtolwarship_turret ?? "vtol_warship_turret_mp";
    killstreaks::registerkillstreakdamagedealingweapon( "vtol_warship", vehicle_turret, #"large" );
    missile_weapon = bundle.vtolwarship_missile ?? "sat_vtol_warship_proj_mp";
    killstreaks::registerkillstreakdamagedealingweapon( "vtol_warship", missile_weapon, #"large" );
}

// Namespace vtol_warship
// Params 2, eflags: 0x4
// Checksum 0x597bdb23, Offset: 0xab7
// Size: 0x1f
function private function_1278599b230de316( ref, hitstokill )
{
    vehicle_damage::set_vehicle_hit_damage_data( ref, hitstokill );
}

// Namespace vtol_warship
// Params 2, eflags: 0x4
// Checksum 0xb2330c8d, Offset: 0xade
// Size: 0x1e
function private vtolwarship_findtargetstruct( structlinkname, var_a421ae2a63911fea )
{
    return chopper_support::choppersupport_findtargetstruct( structlinkname, var_a421ae2a63911fea );
}

// Namespace vtol_warship
// Params 0, eflags: 0x4
// Checksum 0xde82ff7e, Offset: 0xb05
// Size: 0x71
function private vtolwarship_register_on_kill_medal()
{
    level utility::flag_wait( "StartGameTypeCallbackFinished" );
    
    if ( utility::issharedfuncdefined( #"medal", #"register_on_kill_medal_callback", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"register_on_kill_medal_callback", "vtol_warship_turret_mp", &function_e5e09b71bfd57d71 );
        utility::callsharedfunc( #"medal", #"register_on_kill_medal_callback", "sat_vtol_warship_proj_mp", &function_e5e09b71bfd57d71 );
    }
}

// Namespace vtol_warship
// Params 0, eflags: 0x4
// Checksum 0x6ff1b186, Offset: 0xb7e
// Size: 0xd5
function private vtolwarship_handlemissilefire()
{
    self endon( #"death", #"leaving", #"crashing" );
    level endon( #"game_ended" );
    streakinfo = self.streakinfo;
    self.var_c9de5f7a664b2c9d = 0;
    self.isboosting = 0;
    self setscriptablepartstate( #"booster", #"off" );
    self.owner notifyonplayercommand( "shoot_missile", "+frag" );
    self.owner setclientomnvar( "ui_killstreak_weapon_1_ammo", ( streakinfo.bundle.var_b3b977af67a42de3 ?? 6 ) - self.var_c9de5f7a664b2c9d );
    thread function_350c2122a9f7e22();
    thread function_b9b8c2cd40f1d8c8( streakinfo );
    thread function_9f07f0f4e880604c( streakinfo );
}

// Namespace vtol_warship
// Params 5, eflags: 0x4
// Checksum 0xec628884, Offset: 0xc5b
// Size: 0x279
function private function_2d629b17d5984d1a( pathgoal, angles, bundle, vtol, streakinfo )
{
    level endon( #"game_ended" );
    vtol.var_835075bb2467fb1b = 1;
    namespace_9d8e359c3b1041e5::allow_empsharedfunc( 0 );
    self.animname = "Player 1";
    destination = pathgoal;
    vtol setscriptablepartstate( #"intro_scene", #"on" );
    vtol setscriptablepartstate( #"thrusters", #"no_procedural_drivers", 0 );
    vtol setscriptablepartstate( "blinking_lights", "on", 0 );
    vtol setscriptablepartstate( "interior_light", "off", 0 );
    vtol setscriptablepartstate( "engine", "on", 0 );
    scene_struct = utility::spawn_model( "tag_origin", destination, angles );
    scene_struct scene::set_scriptbundle( "sat_scorestreak_vtol" );
    scene_struct linkto( vtol, "tag_body_animate" );
    scene::add_scene_func( scene_struct.script_scenescriptbundle, &function_9ed889695de0146f, "callback_done" );
    vehanim = scene_struct scene::function_d0df7c35d793d179( "VTOL", 0 );
    var_97b555a9332e878c = 1;
    vtol animscripted( "", destination, angles, vehanim[ 0 ], undefined, undefined, 0, 1, undefined, undefined, undefined, undefined, undefined, undefined, var_97b555a9332e878c );
    self setclientomnvar( "ui_hide_objectives", 1 );
    scene_struct thread scene::play( [ self ], "shot_010", "sat_scorestreak_vtol" );
    vtol setotherent( self );
    vtol setentityowner( self );
    var_496bf23d3a3ce123 = 7.5;
    streakinfo.var_e8b8649e71024d0 = 0.15;
    killstreak_utility::function_7ab4bfe11ada17a( streakinfo.bundle );
    
    while ( true )
    {
        msg = scene_struct utility::waittill_any_timeout( var_496bf23d3a3ce123, "vtol_intro_scene_complete" );
        
        if ( msg == "timeout" )
        {
            thread killstreak_utility::function_d0d9fe7a213e3bd3( bundle );
            continue;
        }
        
        break;
    }
    
    self setclientomnvar( "ui_hide_objectives", 0 );
    vtol vehicleclearanims();
    vtol stopanimscripted();
    turretindex = 0;
    vtol setturretscriptcontrolled( 1, turretindex );
    waitframe();
    scene_struct unlink();
    vtol setscriptablepartstate( #"intro_scene", #"off" );
    vtol.var_835075bb2467fb1b = 0;
    namespace_9d8e359c3b1041e5::allow_empsharedfunc( 1 );
}

// Namespace vtol_warship
// Params 0, eflags: 0x4
// Checksum 0xd361ea96, Offset: 0xedc
// Size: 0xe
function private function_9ed889695de0146f()
{
    self notify( #"vtol_intro_scene_complete" );
}

// Namespace vtol_warship
// Params 1, eflags: 0x4
// Checksum 0xd55025f5, Offset: 0xef2
// Size: 0x91
function private function_c39662f110e6533( togglestate )
{
    bundle = level.streakglobals.streakbundles[ self.streakinfo.streakname ];
    self.owner killstreak_shared::function_a402a9f43d6f7512( "killstreak_shared", bundle.var_598d79add3230927, bundle.var_f057b69340b14a5c, bundle.var_225c495bde49787b, 1, self );
    self.owner thread function_fc87adc3374cc9b3( self.streakinfo );
}

// Namespace vtol_warship
// Params 1, eflags: 0x4
// Checksum 0xbd2af122, Offset: 0xf8b
// Size: 0xe2
function private function_fc87adc3374cc9b3( streakinfo )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"hellstorm_missile_finished" );
    var_4565558cb4444c1e = [];
    bundle = killstreak::function_85b2d8e857ab4898( streakinfo.streakname );
    
    foreach ( data in bundle.var_e0715b47471288fb )
    {
        var_4565558cb4444c1e[ var_4565558cb4444c1e.size ] = data.killstreakname;
    }
    
    killstreak_shared::function_505d16f50dee75d2( var_4565558cb4444c1e );
}

// Namespace vtol_warship
// Params 0, eflags: 0x4
// Checksum 0xf904afe9, Offset: 0x1075
// Size: 0x54
function private function_350c2122a9f7e22()
{
    self endon( #"death", #"leaving", #"crashing" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self.owner waittill( #"shoot_missile" );
        self.var_288c9e3f82cafb17 = 1;
    }
}

// Namespace vtol_warship
// Params 3, eflags: 0x4
// Checksum 0x73549ede, Offset: 0x10d1
// Size: 0x167
function private function_ed5b0228f408cbfc( owner, lifetime, infinite )
{
    owner endon( #"disconnect" );
    self endon( #"death", #"leaving", #"crashing" );
    level endon( #"game_ended" );
    
    if ( infinite || !isdefined( lifetime ) || lifetime <= 0 )
    {
        owner setclientomnvar( "ui_killstreak_lifetime", 1 );
        return;
    }
    
    lifetimems = lifetime * 1000;
    var_599207f768bab343 = lifetimems * ( self.streakinfo.bundle.var_4c65d66691fbdf3 ?? 0.25 );
    endtimems = gettime() + lifetimems;
    var_805c02b5a28ede5a = endtimems - var_599207f768bab343;
    self.lifetimeendtime = endtimems;
    var_a3862284ea970033 = 0;
    
    while ( true )
    {
        timeleftms = endtimems - gettime();
        
        if ( timeleftms <= 0 )
        {
            owner setclientomnvar( "ui_killstreak_lifetime", 0 );
            break;
        }
        
        if ( var_a3862284ea970033 == 0 )
        {
            var_9c5e2488f64ce147 = var_805c02b5a28ede5a - gettime();
            
            if ( var_9c5e2488f64ce147 <= 0 )
            {
                var_a3862284ea970033 = 1;
                owner playlocalsound( "uin_veh_warning_out_of_fuel_heli" );
            }
        }
        
        owner setclientomnvar( "ui_killstreak_lifetime", timeleftms / lifetimems );
        wait 0.1;
    }
}

// Namespace vtol_warship
// Params 1, eflags: 0x4
// Checksum 0x5be47bf8, Offset: 0x1240
// Size: 0xb8
function private function_b9b8c2cd40f1d8c8( streakinfo )
{
    self.owner endon( #"disconnect" );
    self endon( #"death", #"leaving", #"crashing" );
    level endon( #"game_ended" );
    isbot = isbot( self.owner );
    self.lockedonenemies = [];
    self.var_a688a00957fcf19f = gettime() + ( streakinfo.bundle.var_ff9286891befda3e ?? 1 ) * 1000;
    
    while ( true )
    {
        function_8e8c6276c27ee881( streakinfo, isbot );
        function_d3758c0078aba8f( streakinfo );
        waitframe();
    }
}

// Namespace vtol_warship
// Params 2, eflags: 0x4
// Checksum 0x8c626ce9, Offset: 0x1300
// Size: 0x4e6
function private function_8e8c6276c27ee881( streakinfo, isbot )
{
    var_3e9a50c690b1956a = [];
    
    if ( utility::issharedfuncdefined( #"killstreak", #"hash_435a8597e671e695" ) )
    {
        enemies = utility::callsharedfunc( #"killstreak", #"hash_435a8597e671e695" );
    }
    else
    {
        enemies = teams::getenemyplayers( self.owner.team, 1 );
    }
    
    fov = self.owner playergetzoomfov();
    
    foreach ( i, lockedonenemy in self.lockedonenemies )
    {
        if ( isalive( lockedonenemy ) && lockedonenemy killstreak_shared::function_f87d3123e9b737d6( self.owner ) && self.owner worldpointinreticle_circle( lockedonenemy.origin, fov, 250 ) )
        {
            continue;
        }
        
        lockedonenemy killstreak_shared::function_2b135a54666d89ce( self.owner );
        self.lockedonenemies[ i ] = undefined;
    }
    
    nowms = gettime();
    
    foreach ( enemy in enemies )
    {
        if ( arraycontains( self.lockedonenemies, enemy ) )
        {
            continue;
        }
        
        if ( isdefined( enemy.perks[ "specialty_covert_ops" ] ) || isdefined( enemy.perks[ "specialty_blindeye" ] ) )
        {
            continue;
        }
        
        if ( !isbot && isdefined( self.owner.enemytargetmarkergroup ) && !targetmarkergroups::function_8057fbde5c4ad4d2( enemy, self.owner.enemytargetmarkergroup ) )
        {
            if ( !enemy.isjuggernaut )
            {
                targetmarkergroups::targetmarkergroup_markentity( enemy, self.owner.enemytargetmarkergroup );
            }
        }
        
        if ( enemy.isjuggernaut )
        {
            if ( isdefined( self.owner.enemytargetmarkergroup ) )
            {
                if ( enemy.var_cea7d03870dc1372 )
                {
                    if ( targetmarkergroups::function_8057fbde5c4ad4d2( enemy, self.owner.enemytargetmarkergroup ) || !targetmarkergroups::function_8057fbde5c4ad4d2( enemy.var_cea7d03870dc1372, self.owner.enemytargetmarkergroup ) )
                    {
                        targetmarkergroups::targetmarkergroup_unmarkentity( enemy, self.owner.enemytargetmarkergroup );
                        targetmarkergroups::targetmarkergroup_markentity( enemy.var_cea7d03870dc1372, self.owner.enemytargetmarkergroup );
                    }
                }
                else if ( !targetmarkergroups::function_8057fbde5c4ad4d2( enemy, self.owner.enemytargetmarkergroup ) )
                {
                    targetmarkergroups::targetmarkergroup_markentity( enemy, self.owner.enemytargetmarkergroup );
                }
            }
        }
        
        if ( nowms < self.var_a688a00957fcf19f )
        {
            continue;
        }
        
        if ( !enemy killstreak_shared::function_f87d3123e9b737d6( self.owner ) )
        {
            continue;
        }
        
        if ( !self.owner worldpointinreticle_circle( enemy.origin, fov, 250 ) )
        {
            continue;
        }
        
        var_3e9a50c690b1956a[ var_3e9a50c690b1956a.size ] = enemy;
        self.var_a688a00957fcf19f = nowms + ( streakinfo.bundle.var_ff9286891befda3e ?? 1 ) * 1000;
    }
    
    var_57bc9138f9a69e97 = streakinfo.bundle.var_b3b977af67a42de3 ?? 6;
    
    foreach ( i, enemyentity in var_3e9a50c690b1956a )
    {
        if ( self.lockedonenemies.size >= var_57bc9138f9a69e97 - self.var_c9de5f7a664b2c9d )
        {
            continue;
        }
        
        if ( !isbot )
        {
            enemyentity killstreak_shared::function_70e34750441c92eb( self.owner );
            self.owner playlocalsound( "kls_vtol_warship_target_aquired" );
        }
        
        self.lockedonenemies = arraycombineunique( self.lockedonenemies, [ enemyentity ] );
    }
}

// Namespace vtol_warship
// Params 1, eflags: 0x4
// Checksum 0x4f331144, Offset: 0x17ee
// Size: 0x284
function private function_94abf3d922d2da6( lockedonenemy )
{
    self.var_c9de5f7a664b2c9d++;
    self.var_d0fce72a469c40c5++;
    
    /#
        infinitemissiles = getdvarint( @"hash_71a6f6c87fec61ef", 0 );
        
        if ( infinitemissiles )
        {
            self.var_c9de5f7a664b2c9d = 1;
        }
    #/
    
    if ( self.var_c9de5f7a664b2c9d == 1 || self.var_c9de5f7a664b2c9d == 5 )
    {
        missileorigin = self gettagorigin( #"tag_fx_rockets_left" );
    }
    else if ( self.var_c9de5f7a664b2c9d == 2 || self.var_c9de5f7a664b2c9d == 6 )
    {
        missileorigin = self gettagorigin( #"tag_fx_rockets_right" );
    }
    else if ( self.var_c9de5f7a664b2c9d == 3 )
    {
        missileorigin = self gettagorigin( #"tag_fx_missiles_left" );
    }
    else if ( self.var_c9de5f7a664b2c9d == 4 )
    {
        missileorigin = self gettagorigin( #"tag_fx_missiles_right" );
    }
    
    self.owner setclientomnvar( "ui_killstreak_weapon_1_ammo", ( self.streakinfo.bundle.var_b3b977af67a42de3 ?? 6 ) - self.var_c9de5f7a664b2c9d );
    missile = namespace_9d8e359c3b1041e5::magicbulletsharedfunc( makeweapon( "sat_vtol_warship_proj_mp" ), missileorigin, missileorigin + anglestoforward( self.angles ), self );
    missile.streakinfo = self.streakinfo;
    
    if ( lockedonenemy )
    {
        missile missile_settargetent( lockedonenemy );
        missile thread function_6c2de2873bfb2494( lockedonenemy );
        missile thread function_d24be18eba70df17( lockedonenemy );
        self.var_e7db8afd56641253[ self.var_e7db8afd56641253.size ] = lockedonenemy;
    }
    else
    {
        barrelorigin = self gettagorigin( #"tag_barrel" );
        cameraforward = anglestoforward( self.owner getplayercameraangles() );
        var_958fb91bc0e2247d = barrelorigin + cameraforward * 5000;
        trace = trace::ray_trace( barrelorigin, var_958fb91bc0e2247d, self, trace::create_shotclip_contents() );
        targetposition = trace[ "fraction" ] < 1 ? trace[ "position" ] : var_958fb91bc0e2247d;
        missile missile_settargetpos( targetposition );
    }
    
    self.owner playrumbleonpositionforclient( "defaultweapon_fire", self.origin );
    wait self.streakinfo.bundle.var_38b517a82955f4af ?? 0.5;
}

// Namespace vtol_warship
// Params 1, eflags: 0x4
// Checksum 0x5aed8969, Offset: 0x1a7a
// Size: 0x84
function private function_d3758c0078aba8f( streakinfo )
{
    if ( !self.var_288c9e3f82cafb17 )
    {
        return;
    }
    
    self.var_288c9e3f82cafb17 = undefined;
    self.var_e7db8afd56641253 = [];
    self.var_d0fce72a469c40c5 = 0;
    
    if ( self.var_c9de5f7a664b2c9d < ( streakinfo.bundle.var_b3b977af67a42de3 ?? 6 ) )
    {
        function_94abf3d922d2da6();
    }
    
    self.lockedonenemies = [];
    self.var_e7db8afd56641253 = undefined;
    self.var_d0fce72a469c40c5 = undefined;
}

// Namespace vtol_warship
// Params 1, eflags: 0x4
// Checksum 0x3e2e5253, Offset: 0x1b06
// Size: 0x1b8
function private function_9f07f0f4e880604c( streakinfo )
{
    self endon( #"death", #"leaving", #"crashing" );
    level endon( #"game_ended" );
    
    if ( !self function_cb9640aa0dbf3a74() )
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"flare_system" ][ #"defender_init" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            self [[ var_32dbca3143d9c4a5 ]]( 0, 0, 0, 1, 0, &function_11f2dc1755b4907, 1 );
        }
        
        self.owner setclientomnvar( "ui_killstreak_boost_button_enabled", 0 );
        return;
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"flare_system" ][ #"defender_init" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]( 10, 1, 10, 1, 0, &function_11f2dc1755b4907, 1 );
    }
    
    self.owner setclientomnvar( "ui_killstreak_boost_button_enabled", 1 );
    
    while ( true )
    {
        var_ac96d340eccdeba6 = self.isboosting;
        self.isboosting = self isboosting();
        
        if ( self.isboosting && !var_ac96d340eccdeba6 )
        {
            self setscriptablepartstate( #"booster", #"on" );
            var_32dbca3143d9c4a5 = level.sharedfuncs[ #"flare_system" ][ #"hash_1101719e6ff74ce" ];
            
            if ( isdefined( var_32dbca3143d9c4a5 ) )
            {
                self [[ var_32dbca3143d9c4a5 ]]();
            }
        }
        else if ( !self.isboosting && var_ac96d340eccdeba6 )
        {
            self setscriptablepartstate( #"booster", #"off" );
        }
        
        boostcharge = self function_8219169c22f3c66d();
        self.owner setclientomnvar( "ui_killstreak_boost_recharge_percentage", boostcharge );
        waitframe();
    }
}

// Namespace vtol_warship
// Params 1, eflags: 0x4
// Checksum 0x8225a623, Offset: 0x1cc6
// Size: 0x60
function private function_11f2dc1755b4907( params )
{
    if ( params.attacker.streakinfo && self.owner )
    {
        self.owner thread killstreak_utility::playkillstreaktacomdialog( params.attacker.streakinfo, undefined, #"target_vtol" );
    }
}

// Namespace vtol_warship
// Params 1, eflags: 0x4
// Checksum 0xa0ecf45b, Offset: 0x1d2e
// Size: 0x4a
function private function_d24be18eba70df17( targetent )
{
    level endon( #"game_ended" );
    
    if ( targetent )
    {
        targetent.vtollockedon = 1;
    }
    
    self waittill( #"death" );
    
    if ( targetent )
    {
        targetent.vtollockedon = 0;
    }
}

// Namespace vtol_warship
// Params 1, eflags: 0x4
// Checksum 0xf47ddcde, Offset: 0x1d80
// Size: 0x38
function private function_6c2de2873bfb2494( targetent )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    targetent waittill( #"death" );
    self missile_cleartarget();
}

// Namespace vtol_warship
// Params 0, eflags: 0x4
// Checksum 0xb46f820c, Offset: 0x1dc0
// Size: 0x36
function private vtolwarship_handlethermalswitch()
{
    vtolowner = self.owner;
    vtolowner thread player_utility::watchthermalinputchange();
    vtolwarship_handlethermalswitchinternal();
    
    if ( isdefined( vtolowner ) )
    {
        vtolowner player_utility::stopwatchingthermalinputchange();
    }
}

// Namespace vtol_warship
// Params 0, eflags: 0xc
// Checksum 0xd62157bf, Offset: 0x1dfe
// Size: 0x113
function private vtolwarship_handlethermalswitchinternal()
{
    self notify( #"hash_ef150bade7d9292b" );
    self endon( #"hash_ef150bade7d9292b" );
    self endon( #"death", #"leaving", #"crashing" );
    vtolowner = self.owner;
    
    if ( !isdefined( self.streakinfo.bundle.var_cce52496889d53e2 ) )
    {
        return;
    }
    
    function_55af6d015c4cb895( vtolowner, self.streakinfo.bundle.var_cce52496889d53e2 );
    
    while ( true )
    {
        vtolowner waittill( #"switch_thermal_mode" );
        function_fe2123dba85371ec( vtolowner );
        self setscriptablepartstate( #"thermals", #"toggle_off" );
        vtolowner waittill( #"switch_thermal_mode" );
        function_55af6d015c4cb895( vtolowner, self.streakinfo.bundle.var_cce52496889d53e2 );
        self setscriptablepartstate( #"thermals", #"toggle_on" );
    }
}

// Namespace vtol_warship
// Params 4, eflags: 0x4
// Checksum 0x2dab63ff, Offset: 0x1f19
// Size: 0xef
function private function_e5e09b71bfd57d71( victim, einflictor, smeansofdeath, sweapon )
{
    if ( utility::issharedfuncdefined( #"medal", #"track_rapid_kill", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"track_rapid_kill", "vtol_warship", sweapon );
    }
    
    if ( isdefined( self.rapidkill_data ) )
    {
        if ( isdefined( self.rapidkill_data[ "vtol_warship" ] ) && self.rapidkill_data[ "vtol_warship" ].rapidkill_count == 15 )
        {
            namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_overwhelmingforce" );
        }
    }
    
    if ( utility::issharedfuncdefined( #"medal", #"track_scorestreak_kill", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"track_scorestreak_kill", "vtol_warship", victim );
    }
}

// Namespace vtol_warship
// Params 1, eflags: 0x4
// Checksum 0x7de964bf, Offset: 0x2010
// Size: 0x18
function private function_b539c85f0e992684( streakinfo )
{
    self notify( #"finished_deploy_weapon" );
}

// Namespace vtol_warship
// Params 1
// Checksum 0x3624beed, Offset: 0x2030
// Size: 0x15
function function_f912c4bac1ef4021( streakinfo )
{
    function_c1d54a36b82eb87( streakinfo );
}

// Namespace vtol_warship
// Params 1, eflags: 0x4
// Checksum 0x96c45bc6, Offset: 0x204d
// Size: 0x367, Type: bool
function private function_c1d54a36b82eb87( streakinfo )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self notify( #"using_remote" );
    var_87fc2c034785a46c = function_508530e3c7fe6b44( streakinfo );
    
    if ( !var_87fc2c034785a46c )
    {
        if ( utility::issharedfuncdefined( #"vehicle", #"decrementfauxvehiclecount" ) )
        {
            [[ utility::getsharedfunc( #"vehicle", #"decrementfauxvehiclecount" ) ]]();
        }
        
        vehicle_tracking::function_4f76f5b4541acef1();
        return false;
    }
    
    streakinfo.streakduration = 60;
    var_6e519cf217378eb1 = function_5160298b0316dd29( streakinfo );
    
    if ( !var_6e519cf217378eb1 )
    {
        val::reset_all( "vtolWarship" );
        
        if ( utility::issharedfuncdefined( #"vehicle", #"decrementfauxvehiclecount" ) )
        {
            [[ utility::getsharedfunc( #"vehicle", #"decrementfauxvehiclecount" ) ]]();
        }
        
        vehicle_tracking::function_4f76f5b4541acef1();
        streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
        return false;
    }
    
    if ( utility::issharedfuncdefined( #"game", #"disable_backpack_inventory" ) )
    {
        self [[ utility::getsharedfunc( #"game", #"disable_backpack_inventory" ) ]]( 1 );
    }
    
    streakinfo thread function_4eeccad8f0133d29( self, streakinfo );
    vtolwarship = function_4d183c3b29dad60( self, streakinfo );
    vehicle_tracking::function_4f76f5b4541acef1();
    
    if ( !isdefined( vtolwarship ) || vtolwarship.var_e79c0b705996c5dd )
    {
        if ( utility::issharedfuncdefined( #"vehicle", #"decrementfauxvehiclecount" ) )
        {
            [[ utility::getsharedfunc( #"vehicle", #"decrementfauxvehiclecount" ) ]]();
        }
        
        streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
        return false;
    }
    
    self prestreamasset( "entity", vtolwarship, 1000 );
    
    if ( level.killstreak_emp_initialized )
    {
        vtolwarship.ksempapplycallback = &vtolwarship_empapplied;
    }
    
    thread utility::callsharedfunc( #"killstreak", #"hash_dd9f16672046c094", vtolwarship );
    
    if ( utility::issharedfuncdefined( #"killstreak", #"logkillstreakevent" ) )
    {
        self [[ utility::getsharedfunc( #"killstreak", #"logkillstreakevent" ) ]]( "chopper_gunner", self.origin );
    }
    
    used_splash_ref = streakinfo.bundle.usedsplashref;
    
    if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) )
    {
        self thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( used_splash_ref, self );
    }
    
    var_65934120c2efeb81 = undefined;
    
    if ( utility::issharedfuncdefined( #"sound", #"playkillstreakdeploydialog" ) )
    {
        self [[ utility::getsharedfunc( #"sound", #"playkillstreakdeploydialog" ) ]]( streakinfo.streakname );
        var_65934120c2efeb81 = 2;
    }
    
    thread killstreak_utility::playkillstreaktacomdialog( streakinfo, "vtol_warship" + "_use", #"use", 1, var_65934120c2efeb81 );
    vtolwarship thread function_5b6d42d897321234( self );
    
    if ( utility::issharedfuncdefined( #"killstreak", #"hash_2a2fdd5408aca764" ) )
    {
        vtolwarship [[ utility::getsharedfunc( #"killstreak", #"hash_2a2fdd5408aca764" ) ]]();
    }
    
    vtolwarship function_620ea4f7a46db56a();
    return true;
}

// Namespace vtol_warship
// Params 1, eflags: 0x4
// Checksum 0x7443f466, Offset: 0x23bd
// Size: 0x9d, Type: bool
function private function_508530e3c7fe6b44( streakinfo )
{
    if ( utility::issharedfuncdefined( #"vehicle", #"incrementfauxvehiclecount" ) )
    {
        [[ utility::getsharedfunc( #"vehicle", #"incrementfauxvehiclecount" ) ]]();
    }
    
    if ( !vehicle_tracking::reserve_vehicle() )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"KILLSTREAKS/TOO_MANY_VEHICLES" );
        }
        
        return false;
    }
    
    if ( level.gameended )
    {
        return false;
    }
    
    return true;
}

// Namespace vtol_warship
// Params 1, eflags: 0x4
// Checksum 0xb706bb12, Offset: 0x2463
// Size: 0x95, Type: bool
function private function_5160298b0316dd29( streakinfo )
{
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    deployweaponname = streakinfo.bundle.deployweaponname;
    deployresult = killstreakdeploy::streakdeploy_doweapontabletdeploy( streakinfo, undefined, undefined, undefined, &function_b539c85f0e992684, deployweaponname );
    
    if ( !deployresult )
    {
        return false;
    }
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace vtol_warship
// Params 2, eflags: 0x4
// Checksum 0x4e6ea8e, Offset: 0x2501
// Size: 0xa18
function private function_4d183c3b29dad60( owner, streakinfo )
{
    bundle = streakinfo.bundle;
    owner disablephysicaldepthoffieldscripting();
    pathgoal = ( owner.origin + anglestoforward( owner.angles ) * 2000 ) * ( 1, 1, 0 );
    angles = owner.angles;
    
    if ( bundle.var_847555ca79068926 )
    {
        verticaloffset = 0;
        
        if ( bundle.var_d5f7d3d6d38f9f2f )
        {
            tracecontents = trace::create_contents( 0, 1, 0, 0, 1, 1, 0, 1 );
            info = physics_raycast( pathgoal + ( 0, 0, 50000 ), pathgoal, tracecontents, [], 0, "physicsquery_closest" );
            verticaloffset = info[ 0 ][ "position" ][ 2 ] > owner.origin[ 2 ] ? info[ 0 ][ "position" ][ 2 ] - owner.origin[ 2 ] : 0;
        }
        
        var_944f36edc0a4edad = 0;
        
        if ( utility::issharedfuncdefined( #"vtol_warship", #"hash_cae65ac11ecaf3b7" ) )
        {
            var_944f36edc0a4edad = [[ utility::getsharedfunc( #"vtol_warship", #"hash_cae65ac11ecaf3b7" ) ]]( owner );
        }
        
        verticaldelta = bundle.var_b5d5341a70f7d6c0 ?? 0;
        pathgoal += ( 0, 0, owner.origin[ 2 ] + verticaldelta + verticaloffset + var_944f36edc0a4edad );
    }
    else if ( isdefined( level.heli_structs_entrances ) && level.heli_structs_entrances.size > 0 )
    {
        var_53eeea462a8fe959 = randomint( level.heli_structs_entrances.size );
        
        if ( utility::issharedfuncdefined( #"chopper_gunner", #"hash_2ebe6213013cff11" ) )
        {
            var_53eeea462a8fe959 = level utility::callsharedfunc( #"chopper_gunner", #"hash_2ebe6213013cff11", owner.origin );
        }
        
        /#
            debugindex = getdvarint( @"hash_c1fa04efebbe3e6b", -1 );
            
            if ( debugindex != -1 )
            {
                var_53eeea462a8fe959 = debugindex;
            }
        #/
        
        entrancestruct = level.heli_structs_entrances[ var_53eeea462a8fe959 ];
        
        if ( utility::issharedfuncdefined( #"chopper_gunner", #"findtargetstruct" ) )
        {
            goalstruct = [[ utility::getsharedfunc( #"chopper_gunner", #"findtargetstruct" ) ]]( entrancestruct.script_linkto, level.heli_structs_goals );
            
            if ( isdefined( goalstruct ) )
            {
                newheightoffset = 200;
                heightoffset = ( 0, 0, goalstruct.origin[ 2 ] + newheightoffset );
                
                /#
                    var_526fa115c3fc4688 = getdvarint( @"hash_f3fcf3899fa2e1b0", 0 );
                    heightoffset += ( 0, 0, var_526fa115c3fc4688 );
                #/
                
                var_ef058b074a4eda1d = entrancestruct.origin * ( 1, 1, 0 ) + heightoffset;
                var_78591ed6a66cbafe = goalstruct.origin * ( 1, 1, 0 ) + heightoffset;
                entranceforward = vectornormalize( var_78591ed6a66cbafe - var_ef058b074a4eda1d );
                pathgoal = var_78591ed6a66cbafe + entranceforward * 500;
                angles = vectortoangles( entranceforward );
                
                if ( utility::issharedfuncdefined( #"vtol", #"vtol_spawn_start" ) )
                {
                    thread utility::callsharedfunc( #"vtol", #"vtol_spawn_start", owner, var_ef058b074a4eda1d );
                }
                
                /#
                    level thread debug_utility::drawsphere( var_ef058b074a4eda1d, 20, 60, ( 1, 0, 0 ) );
                    level thread debug_utility::drawline( var_ef058b074a4eda1d, var_78591ed6a66cbafe, 60, ( 1, 1, 1 ) );
                    level thread debug_utility::drawsphere( var_78591ed6a66cbafe, 20, 60, ( 0, 1, 0 ) );
                #/
            }
            else
            {
                /#
                    owner iprintlnbold( "<dev string:x24>" + entrancestruct.script_linkto + "<dev string:x34>" );
                #/
            }
        }
    }
    else if ( isdefined( streakinfo.var_85efcf1c5b41189b ) )
    {
        entranceinfo = [[ streakinfo.var_85efcf1c5b41189b ]]( owner );
        pathgoal = entranceinfo.pathgoal;
        angles = entranceinfo.angles;
    }
    else
    {
        owner iprintlnbold( "Level is missing heli structs, please set them up!" );
    }
    
    vtolwarship = vtolwarship_spawn( streakinfo, pathgoal, angles );
    
    if ( !isdefined( vtolwarship ) )
    {
        return;
    }
    
    modifiedlifetime = 60;
    
    /#
        var_ae24eaad32921ae2 = getdvarint( @"hash_2c01d701bac5d9d3", 0 );
        
        if ( var_ae24eaad32921ae2 )
        {
            modifiedlifetime = 9999;
        }
    #/
    
    vtolwarship.owner = owner;
    vtolwarship.streakinfo = streakinfo;
    vtolwarship.teamfriendlyto = owner.team;
    vtolwarship.var_4d91de78824da316 = streakinfo.bundle.var_3d706f46064a05eb;
    vtolwarship.var_c1d01968dc304438 = streakinfo.bundle.var_c1d01968dc304438;
    vtolwarship.var_bdc51be80cbeef82 = bundle.var_bdc51be80cbeef82;
    vtolwarship.streakname = streakinfo.streakname;
    vtolwarship.speed = 100;
    vtolwarship.accel = 50;
    vtolwarship.lifetime = modifiedlifetime;
    vtolwarship.team = owner.team;
    vtolwarship.angles = angles;
    vtolwarship setvehicleteam( vtolwarship.team );
    level thread killstreak_utility::function_6348c97b79ee8a08( vtolwarship, owner, &vtolwarship_delete );
    vtolwarship thread vtolwarship_watchintrodisown( "disconnect", streakinfo );
    vtolwarship thread vtolwarship_watchintrodisown( "joined_team", streakinfo );
    vtolwarship thread vtolwarship_watchintrodisown( "joined_spectator", streakinfo );
    vtolwarship thread vtolwarship_watchintrodisown( "player_fatal_death", streakinfo );
    vtolwarship setcandamage( 0 );
    vtolwarship function_d2b8ee2e1275daaf( 1 );
    var_b6ba48086272dc92 = 40;
    turretindex = 0;
    shouldsnap = 1;
    vtolwarship setturrettargetlocalangles( ( var_b6ba48086272dc92, 0, 0 ), turretindex, shouldsnap );
    owner namespace_9d8e359c3b1041e5::freezecontrolssharedfunc( 1 );
    owner function_2d629b17d5984d1a( pathgoal, angles, bundle, vtolwarship, streakinfo );
    vtolwarship function_d2b8ee2e1275daaf( 0 );
    vtolwarship setcandamage( 1 );
    
    if ( vtolwarship.var_e79c0b705996c5dd )
    {
        vtolwarship thread vtolwarship_leave();
        return;
    }
    
    vtolwarship vehphys_forcekeyframedmotion();
    vtolwarship.ispiloted = 1;
    vtolwarship.owner.vehicle = vtolwarship;
    vtolwarship.flaresreservecount = 1;
    vtolwarship.pathgoal = pathgoal;
    vtolwarship.missilesleft = getdvarint( @"hash_52bf6045193decbf", 8 );
    vtolwarship.animname = "ks_chopper_gunner_vehicle_camera";
    vtolwarship.infinite_chopper = istrue( owner.infinite_chopper );
    vtolwarship.heightoffset = heightoffset;
    vtolwarship outofbounds::function_676cf3ab5a90bec2();
    outofbounds::registerentforoob( vtolwarship, "killstreak" );
    utility::registersharedfunc( vtolwarship vehicle::get_ref(), #"interactswithoobtrigger", &function_572f5f09e092f7f7 );
    utility::registersharedfunc( vtolwarship vehicle::get_ref(), #"hash_3365a912c11d2ba0", &function_d2c496ae44aad48b );
    killstreak_shared::function_28d986de72ce85f8( bundle.var_b9d390a05155bc2f );
    vtolwarship setotherent( owner );
    vtolwarship vtolwarship_setspeed( vtolwarship.speed );
    vtolwarship setscriptablepartstate( #"thrusters", #"dynamic", 0 );
    vtolwarship.killcament = spawn( "script_model", vtolwarship gettagorigin( vtolwarship tagexists( #"tag_camera_turret" ) ? #"tag_camera_turret" : #"tag_origin" ) );
    originoffset = ( bundle.var_15869b5e2c380579 ?? 0, bundle.var_15869a5e2c380346 ?? 0, bundle.var_1586995e2c380113 ?? 0 );
    vtolwarship.killcament linkto( vtolwarship, "tag_origin", originoffset, ( 0, 0, 0 ) );
    
    if ( utility::issharedfuncdefined( #"chopper_gunner", #"attachxrays" ) )
    {
        vtolwarship = [[ utility::getsharedfunc( #"chopper_gunner", #"attachxrays" ) ]]( vtolwarship );
    }
    
    maxhealth = vtolwarship.health;
    vtolwarship.health = maxhealth;
    vtolwarship.maxhealth = maxhealth;
    vtolwarship.currenthealth = maxhealth;
    vtolwarship sentientpoolmanager::registersentient( "Killstreak_Air", owner );
    vtolwarship vtolwarship_setupdamagefunctionality( streakinfo.streakname );
    
    if ( utility::issharedfuncdefined( #"killstreak", #"addtoactivekillstreaklist" ) )
    {
        vtolwarship [[ utility::getsharedfunc( #"killstreak", #"addtoactivekillstreaklist" ) ]]( streakinfo.streakname, "Killstreak_Air", owner, 0, 1, 100 );
    }
    
    level notify( #"matchrecording_chopper", vtolwarship );
    self notify( #"chopper_gunner_used" );
    shellshock_utility_cpmp::_stopshellshock();
    self.restoreangles = self getplayerangles();
    val::group_set( "vtolWarshipUse", 0 );
    self setcinematicmotionoverride( "player_chopper_gunner_ride_mp" );
    thread killstreak_utility::function_785239235d790099( "80_instant_noscale", 1 );
    self setclientomnvar( "ui_apache_screens_state", 1 );
    self painvisionoff();
    killstreak_shared::killstreak_savenvgstate();
    vtolwarship playsoundtoplayer( "mp_killstreak_apache_transition_lr", self );
    killstreak_utility::playkillstreaktacomdialog( vtolwarship.streakinfo, undefined, #"arrive" );
    
    if ( !isdefined( vtolwarship ) || vtolwarship.isexploding )
    {
        return;
    }
    
    vtolwarship notify( #"start_chopper_use" );
    return vtolwarship;
}

// Namespace vtol_warship
// Params 0, eflags: 0x4
// Checksum 0x96e938ee, Offset: 0x2f22
// Size: 0xe
function private function_d2c496ae44aad48b()
{
    self notify( #"killstreakexit" );
}

// Namespace vtol_warship
// Params 2, eflags: 0x4
// Checksum 0x92672aee, Offset: 0x2f38
// Size: 0x8d, Type: bool
function private function_572f5f09e092f7f7( trigger, vehicle )
{
    if ( getdvarint( @"hash_bbf435b7cd7005db", 0 ) )
    {
        if ( trigger.targetname == "VTOL_OutOfBounds" )
        {
            return true;
        }
        
        triggertargetname = level.var_b7c2a92ffb41344 ? level.var_b7c2a92ffb41344 : "OutOfBounds";
        return ( trigger.targetname == triggertargetname );
    }
    
    if ( trigger.targetname != "VTOL_OutOfBounds" )
    {
        return false;
    }
    
    return true;
}

// Namespace vtol_warship
// Params 1, eflags: 0x4
// Checksum 0xbd5580af, Offset: 0x2fce
// Size: 0x108
function private vtolwarship_setupdamagefunctionality( streakname )
{
    killstreakvehicle = self;
    scorepopup = "destroyed_" + streakname;
    vodestroyed = undefined;
    destroyedsplash = "callout_destroyed_" + streakname;
    var_c96bcef6709d6df1 = vehicle_damage::set_vehicle_hit_damage_data( streakname, 12 );
    var_d188942a41771ea1 = undefined;
    premoddamagecallback = &vtolwarship_premodifydamage;
    postmoddamagecallback = &vtolwarship_postmodifydamage;
    deathcallback = &vtolwarship_handledeathdamage;
    killstreak_utility::killstreak_setupvehicledamagefunctionality( streakname, killstreakvehicle, scorepopup, vodestroyed, destroyedsplash, var_c96bcef6709d6df1, var_d188942a41771ea1, premoddamagecallback, postmoddamagecallback, deathcallback );
    vehicle_tracking::register_instance( self, self.owner, self.owner.team );
    vehicle_occupancy::register_instance( self );
    killstreak_utility::function_b555369eba6b0252( 1, 1500, &function_1d7c593d0375d968 );
    killstreak_utility::function_b555369eba6b0252( 2, 1000, &function_6e7c227b5603c41d );
    killstreak_utility::function_b555369eba6b0252( 3, 500, &function_6d08146f478e207d );
}

// Namespace vtol_warship
// Params 2, eflags: 0x4
// Checksum 0x46aee69a, Offset: 0x30de
// Size: 0x71
function private vtolwarship_watchintrodisown( exitaction, streakinfo )
{
    vtol = self;
    owner = self.owner;
    vtol endon( #"death", #"exit_chopper_intro", #"start_chopper_use" );
    level endon( #"game_ended" );
    owner waittill( exitaction );
    self.var_e79c0b705996c5dd = 1;
}

// Namespace vtol_warship
// Params 0, eflags: 0x4
// Checksum 0xc8867d0a, Offset: 0x3157
// Size: 0x85
function private function_ca56677832f3e163()
{
    vtol = self;
    wait 0.1;
    
    if ( vtol && vtol.health > 0 && vtol.owner )
    {
        turretindex = 0;
        vtol setturretscriptcontrolled( 0, turretindex );
        var_13fbe074b3e52d31 = vtol getturretworldangles( turretindex );
        vtol.owner setplayerangles( var_13fbe074b3e52d31 );
        vtol.owner namespace_9d8e359c3b1041e5::freezecontrolssharedfunc( 0 );
    }
}

// Namespace vtol_warship
// Params 1, eflags: 0x4
// Checksum 0x59d67481, Offset: 0x31e4
// Size: 0x4b8
function private function_5b6d42d897321234( gunner )
{
    self endon( #"death", #"explode", #"leaving", #"crashing" );
    level endon( #"game_ended" );
    
    if ( isdefined( level.var_d8f10f1cfdbaac7e ) )
    {
        thread [[ level.var_d8f10f1cfdbaac7e ]]( self.streakinfo );
    }
    
    if ( utility::issharedfuncdefined( #"vehicle", #"decrementfauxvehiclecount" ) )
    {
        [[ utility::getsharedfunc( #"vehicle", #"decrementfauxvehiclecount" ) ]]();
    }
    
    gunner = self.owner;
    gunner disablephysicaldepthoffieldscripting();
    gunner val::set( "vtolWarship", "allow_movement", 1 );
    gunner val::set( "vtolWarship", "fire", 1 );
    gunner val::set( "vtolWarship", "ads", 1 );
    gunner cameraunlink();
    gunner thread killstreak_utility::function_785239235d790099( "default" );
    gunner shellshock_utility_cpmp::_shellshock( %"killstreak_veh_camera_mp", #"top", self.lifetime, 0 );
    function_c39662f110e6533( 1 );
    
    if ( isdefined( level.choppervisionset ) )
    {
        self.currentvisionset = level.choppervisionset;
    }
    
    if ( !isdefined( self.playersfx ) )
    {
        self.playersfx = spawn( "script_origin", self.origin );
        self.playersfx linkto( self );
    }
    
    if ( utility::issharedfuncdefined( #"chopper_gunner", #"hash_fd6c8efa17b475bf" ) )
    {
        self thread [[ utility::getsharedfunc( #"chopper_gunner", #"hash_fd6c8efa17b475bf" ) ]]();
    }
    else
    {
        weapon_utility::setlockedoncallback( self, &vtolwarship_lockedoncallback );
    }
    
    if ( utility::issharedfuncdefined( #"chopper_gunner", #"hash_7a22056416abf8db" ) )
    {
        self thread [[ utility::getsharedfunc( #"chopper_gunner", #"hash_7a22056416abf8db" ) ]]();
    }
    else
    {
        weapon_utility::setlockedonremovedcallback( self, &vtolwarship_lockedonremovedcallback );
    }
    
    self setcandamage( 1 );
    thread vtolwarship_handlethermalswitch();
    thread vtolwarship_watchturretfire();
    thread vtolwarship_watchgameendleave();
    thread vtolwarship_watchownerexitaction( "disconnect" );
    thread vtolwarship_watchownerexitaction( "joined_team" );
    thread vtolwarship_watchownerexitaction( "joined_spectator" );
    thread vtolwarship_watchownerexitaction( "team_kill_punish" );
    thread vtolwarship_watchownerexitaction( "player_fatal_death" );
    thread vtolwarship_watchownerexitaction( "last_stand_enter" );
    thread function_b3ccbf49a7ca14e3();
    thread vtolwarship_handlemissilefire();
    
    if ( !self.infinite_chopper )
    {
        thread vtolwarship_watchlifetime();
        self.owner setclientomnvar( "ui_killstreak_countdown", gettime() + int( self.lifetime * 1000 ) );
    }
    
    thread function_ed5b0228f408cbfc( self.owner, self.lifetime, self.infinite_chopper );
    
    if ( utility::issharedfuncdefined( #"chopper_gunner", #"hash_1b30f8a402dc719c" ) )
    {
        self thread [[ utility::getsharedfunc( #"chopper_gunner", #"hash_1b30f8a402dc719c" ) ]]();
    }
    
    if ( isdefined( level.choppervisionset ) )
    {
        self.currentvisionset = level.choppervisionset;
    }
    
    if ( self.currentvisionset )
    {
        gunner killstreak_utility::killstreak_setmainvision( self.currentvisionset );
    }
    
    self.playersfx playloopsound( "veh_apache_killstreak_amb_lr" );
    
    if ( utility::issharedfuncdefined( #"vtol", #"hash_f301da7513baf73" ) )
    {
        utility::callsharedfunc( #"vtol", #"hash_f301da7513baf73", gunner );
    }
    
    gunner setclienttriggeraudiozone( "kls_sat_vtol_warship", 0.5 );
    
    if ( self.ksempd )
    {
        vtolwarship_handledeathdamage( gunner.var_c7dc16398800176e );
    }
    
    turretindex = 0;
    self.owner usevehicle( self, turretindex );
    thread function_ca56677832f3e163();
    
    if ( self vehicle_isphysveh() )
    {
        self vehphys_setdefaultmotion();
    }
    
    thread vtolwarship_watchearlyexit();
    wait 0.4;
    gunner namespace_9d8e359c3b1041e5::function_f6af4ffa6dbb4645( self.streakinfo.streakname, "on" );
    gunner setclientomnvar( o"ui_apache_screens_state", 0 );
    gunner setclientomnvar( o"ui_apache_controls", 1 );
    gunner setclientomnvar( o"ui_killstreak_weapon_1_ammo", self.missilesleft );
    gunner setclientomnvar( o"ui_killstreak_health", self.health / self.maxhealth );
    gunner setclientomnvar( o"ui_killstreak_flares", self.flaresreservecount );
    gunner setclientomnvar( o"ui_killstreak_damage_state", 0 );
}

// Namespace vtol_warship
// Params 0, eflags: 0x4
// Checksum 0x7f8d2a5a, Offset: 0x36a4
// Size: 0x1c
function private vtolwarship_lockedoncallback()
{
    vehicle_omnvar::show_warning( "missileLocking", self.owner, "killstreak" );
}

// Namespace vtol_warship
// Params 0, eflags: 0x4
// Checksum 0x96fbe3f7, Offset: 0x36c8
// Size: 0x1c
function private vtolwarship_lockedonremovedcallback()
{
    vehicle_omnvar::hide_warning( "missileLocking", self.owner, "killstreak" );
}

// Namespace vtol_warship
// Params 0, eflags: 0x4
// Checksum 0xfc8de574, Offset: 0x36ec
// Size: 0xc2
function private vtolwarship_watchturretfire()
{
    vtol = self;
    vtol endon( #"death", #"leaving", #"crashing" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        vtol waittill( #"missile_fire", missile );
        vtol.owner earthquakeforplayer( 0.15, 0.1, vtol.origin, 150 );
        missile.streakinfo = vtol.streakinfo;
        vtol.streakinfo.shots_fired++;
        missile thread vtolwarship_watchexplosioninfluencepoint( vtol.owner );
    }
}

// Namespace vtol_warship
// Params 0, eflags: 0x4
// Checksum 0xc2c3d267, Offset: 0x37b6
// Size: 0xa6
function private vtolwarship_watchlifetime()
{
    vtol = self;
    vtol endon( #"death", #"explode", #"leaving", #"crashing", #"game_ended" );
    halfwaytimeout = vtol.lifetime * 0.5;
    wait halfwaytimeout;
    vtol killstreak_utility::playkillstreaktacomdialog( vtol.streakinfo, undefined, #"halfway" );
    wait halfwaytimeout;
    vtol killstreak_utility::playkillstreaktacomdialog( vtol.streakinfo, undefined, #"leave" );
    vtol thread vtolwarship_leave();
}

// Namespace vtol_warship
// Params 2, eflags: 0x4
// Checksum 0x55bb28c4, Offset: 0x3864
// Size: 0x82
function private function_4eeccad8f0133d29( owner, streakinfo )
{
    owner endon( #"disconnect" );
    streakinfo endon( #"hash_ea06acef2ba7e5e1" );
    level utility::waittill_any( "start_game_ended", "game_ended" );
    
    if ( owner && streakinfo )
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"killstreak" ][ #"hash_bf17c172d25e8b3d" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            owner [[ var_32dbca3143d9c4a5 ]]( streakinfo );
        }
    }
}

// Namespace vtol_warship
// Params 0, eflags: 0x4
// Checksum 0xf96a0d1f, Offset: 0x38ee
// Size: 0xd7
function private vtolwarship_watchgameendleave()
{
    self.streakinfo notify( #"hash_ea06acef2ba7e5e1" );
    vtol = self;
    vtol.owner endon( #"disconnect" );
    vtol endon( #"death", #"explode", #"leaving", #"crashing" );
    level utility::waittill_any( "start_game_ended", "game_ended" );
    
    if ( self.owner && self.streakinfo )
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"killstreak" ][ #"hash_bf17c172d25e8b3d" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            self.owner [[ var_32dbca3143d9c4a5 ]]( self.streakinfo );
        }
    }
    
    thread vtolwarship_leave();
}

// Namespace vtol_warship
// Params 1, eflags: 0x4
// Checksum 0xa854e0cf, Offset: 0x39cd
// Size: 0x86
function private vtolwarship_watchownerexitaction( exitaction )
{
    vtol = self;
    vtol endon( #"death", #"explode", #"leaving", #"crashing" );
    level endon( #"game_ended" );
    vtol.owner waittill( exitaction );
    
    if ( exitaction == "player_fatal_death" )
    {
        vtol thread vtolwarship_leave();
        return;
    }
    
    vtol thread vtolwarship_returnplayer();
    vtol thread vtolwarship_explode();
}

// Namespace vtol_warship
// Params 0, eflags: 0x4
// Checksum 0x59f7a912, Offset: 0x3a5b
// Size: 0x22b
function private function_b3ccbf49a7ca14e3()
{
    vtol = self;
    vtol endon( #"death", #"leaving", #"crashing" );
    vtol.owner endon( #"disconnect" );
    level endon( #"game_ended" );
    vtol.var_def1d41fdfcdaa7 = 0;
    vtol.var_5b044033d5ec9a1a = undefined;
    vtol childthread vtolwarship_watchkills();
    vtol childthread function_d48af4024c78dbfb();
    streakinfo = vtol.streakinfo;
    
    while ( true )
    {
        if ( vtol.var_def1d41fdfcdaa7 != 0 )
        {
            wait 2;
            
            if ( vtol.var_5b044033d5ec9a1a == "vtol_warship_turret_mp" )
            {
                if ( vtol.var_def1d41fdfcdaa7 == 1 )
                {
                    vtol killstreak_utility::playkillstreaktacomdialog( streakinfo, undefined, #"hash_92d720d8838629b3" );
                }
                else if ( vtol.var_def1d41fdfcdaa7 == 2 )
                {
                    vtol killstreak_utility::playkillstreaktacomdialog( streakinfo, undefined, #"hash_92d721d883862b66" );
                }
                else if ( vtol.var_def1d41fdfcdaa7 == 3 )
                {
                    vtol killstreak_utility::playkillstreaktacomdialog( streakinfo, undefined, #"hash_92d722d883862d19" );
                }
                else if ( vtol.var_def1d41fdfcdaa7 > 3 )
                {
                    vtol killstreak_utility::playkillstreaktacomdialog( streakinfo, undefined, #"hash_7a55f15b8a598fa5" );
                }
            }
            else if ( vtol.var_5b044033d5ec9a1a == "sat_vtol_warship_proj_mp" )
            {
                if ( vtol.var_def1d41fdfcdaa7 == 1 )
                {
                    vtol killstreak_utility::playkillstreaktacomdialog( streakinfo, undefined, #"hash_9c602b2dbd6faf36" );
                }
                else if ( vtol.var_def1d41fdfcdaa7 == 2 )
                {
                    vtol killstreak_utility::playkillstreaktacomdialog( streakinfo, undefined, #"hash_9c602a2dbd6fad83" );
                }
                else if ( vtol.var_def1d41fdfcdaa7 == 3 )
                {
                    vtol killstreak_utility::playkillstreaktacomdialog( streakinfo, undefined, #"hash_9c60292dbd6fabd0" );
                }
                else if ( vtol.var_def1d41fdfcdaa7 > 3 )
                {
                    vtol killstreak_utility::playkillstreaktacomdialog( streakinfo, undefined, #"hash_33710c20397e3ea4" );
                }
            }
            
            vtol.var_def1d41fdfcdaa7 = 0;
            vtol.var_5b044033d5ec9a1a = undefined;
            wait 1;
        }
        
        waitframe();
    }
}

// Namespace vtol_warship
// Params 0, eflags: 0x4
// Checksum 0x9508b971, Offset: 0x3c8e
// Size: 0x6c
function private vtolwarship_watchkills()
{
    vtol = self;
    
    while ( true )
    {
        vtol.owner waittill( #"update_rapid_kill_buffered", recentkills, var_95795539e2a8343 );
        
        if ( isdefined( recentkills ) && isstring( var_95795539e2a8343 ) )
        {
            vtol.var_def1d41fdfcdaa7++;
            vtol.var_5b044033d5ec9a1a = var_95795539e2a8343;
        }
    }
}

// Namespace vtol_warship
// Params 0, eflags: 0x4
// Checksum 0x1a2db97b, Offset: 0x3d02
// Size: 0x6c
function private function_d48af4024c78dbfb()
{
    vtol = self;
    
    while ( true )
    {
        vtol.owner waittill( #"update_rapid_agent_kill_buffered", recentkills, weaponname );
        
        if ( isdefined( recentkills ) && isstring( weaponname ) )
        {
            vtol.var_def1d41fdfcdaa7++;
            vtol.var_5b044033d5ec9a1a = weaponname;
        }
    }
}

/#

    // Namespace vtol_warship
    // Params 0, eflags: 0x4
    // Checksum 0x97372342, Offset: 0x3d76
    // Size: 0x43, Type: dev
    function private printspeed()
    {
        while ( self )
        {
            speed = self vehicle_getspeed();
            print3d( self.origin, speed, ( 1, 0, 0 ), 1, 10, 1, 1 );
            waitframe();
        }
    }

#/

// Namespace vtol_warship
// Params 0
// Checksum 0xd39e59b4, Offset: 0x3dc1
// Size: 0x1c6
function vtolwarship_leave()
{
    self endon( #"death", #"crashing" );
    level callback::callback( #"killstreak_finish_use", { #streakinfo:self.streakinfo } );
    
    if ( utility::issharedfuncdefined( #"vtol", #"vtol_leave" ) )
    {
        utility::callsharedfunc( #"vtol", #"vtol_leave" );
        return;
    }
    
    /#
    #/
    
    thread vtolwarship_returnplayer();
    self setscriptablepartstate( #"camera_turret", #"show", 0 );
    self function_d2b8ee2e1275daaf( 1 );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"flare_system" ][ #"hash_93285145eafb4db4" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]( 0 );
    }
    
    self clearlookatent();
    self notify( #"leaving" );
    self.isleaving = 1;
    pathgoal = self.origin + anglestoforward( ( 0, self.angles[ 1 ], 0 ) ) * 100000;
    wait 1;
    
    if ( self.owner )
    {
        self.owner killstreak_utility::playkillstreaktacomdialog( self.streakinfo, undefined, #"timeout" );
    }
    
    self function_5a9a3101070af0ea( 250 );
    vtolwarship_setspeed( 250 );
    
    if ( self.streakinfo.bundle.var_6a38d8e90114248c )
    {
        self vehphys_impulse( ( 0, 0, 1 ), 255, 1 );
    }
    
    function_9e2dc3451d5a7f99( pathgoal, 0, 100, 1, 0 );
    utility::waittill_any_timeout( 20, "near_goal" );
    self notify( #"gone" );
    thread vtolwarship_delete( 0 );
}

// Namespace vtol_warship
// Params 1, eflags: 0x4
// Checksum 0x37d14958, Offset: 0x3f8f
// Size: 0xc4, Type: bool
function private vtolwarship_premodifydamage( data )
{
    if ( !level.var_deb9d2b3de25799b )
    {
        return true;
    }
    
    var_2e92350940c6845e = level.sharedfuncs[ #"killstreak" ][ #"getmodifieddamageusingdamagetuning" ];
    
    if ( !isdefined( var_2e92350940c6845e ) )
    {
        return true;
    }
    
    data.iskillstreak = 1;
    data.damage = self [[ var_2e92350940c6845e ]]( data.attacker, data.objweapon, data.meansofdeath, data.damage, self.maxhealth, self.streakinfo.bundle.var_20cb8f4e47f3353e, data );
    return true;
}

// Namespace vtol_warship
// Params 1, eflags: 0x4
// Checksum 0x45f92552, Offset: 0x405c
// Size: 0x150, Type: bool
function private vtolwarship_postmodifydamage( data )
{
    type = data.meansofdeath;
    damage = data.damage;
    
    if ( self.owner && self.owner.vehicle )
    {
        var_44320290cb66d730 = "light";
        
        if ( isexplosivedamagemod( type ) )
        {
            if ( ceil( damage / self.maxhealth ) >= 0.33 )
            {
                self.owner earthquakeforplayer( 0.25, 0.2, self.origin, 150 );
                self.owner playrumbleonentity( "damage_heavy" );
                var_44320290cb66d730 = "heavy";
            }
            else
            {
                self.owner earthquakeforplayer( 0.15, 0.15, self.origin, 150 );
                self.owner playrumbleonentity( "damage_light" );
            }
        }
        
        if ( self.currentvisionset )
        {
            self.owner killstreak_shared::function_9fd22f7d1a941d8a( self.currentvisionset, var_44320290cb66d730 );
        }
    }
    
    self.currenthealth -= damage;
    killstreak_utility::killstreak_updatedamagestate( self.currenthealth );
    return true;
}

// Namespace vtol_warship
// Params 0, eflags: 0x4
// Checksum 0x27d4cdf1, Offset: 0x41b5
// Size: 0x41
function private function_1d7c593d0375d968()
{
    self setscriptablepartstate( "body_damage_light", "on" );
    
    if ( self.owner )
    {
        self.owner killstreak_utility::playkillstreaktacomdialog( self.streakinfo, undefined, #"damage_light" );
    }
}

// Namespace vtol_warship
// Params 0, eflags: 0x4
// Checksum 0xd2a2271f, Offset: 0x41fe
// Size: 0x12
function private function_6e7c227b5603c41d()
{
    self setscriptablepartstate( "body_damage_medium", "on" );
}

// Namespace vtol_warship
// Params 0, eflags: 0x4
// Checksum 0xf8f76987, Offset: 0x4218
// Size: 0x41
function private function_6d08146f478e207d()
{
    self setscriptablepartstate( "body_damage_heavy", "on" );
    
    if ( self.owner )
    {
        self.owner killstreak_utility::playkillstreaktacomdialog( self.streakinfo, undefined, #"damage_heavy" );
    }
}

// Namespace vtol_warship
// Params 1, eflags: 0x4
// Checksum 0xa839c1b6, Offset: 0x4261
// Size: 0x3f, Type: bool
function private vtolwarship_handledeathdamage( data )
{
    self.killedbyweapon = data.objweapon;
    thread function_d641e4509173f2e3( data.attacker, data.objweapon );
    return true;
}

// Namespace vtol_warship
// Params 2, eflags: 0x4
// Checksum 0x68b992b, Offset: 0x42a9
// Size: 0x5f
function private function_d641e4509173f2e3( attacker, killedbyweapon )
{
    self endon( #"explode" );
    
    if ( self.owner && self.owner.vehicle )
    {
        thread vtolwarship_returnplayer( 1 );
    }
    
    vtolwarship_crash( 150, killedbyweapon );
    thread vtolwarship_explode();
}

// Namespace vtol_warship
// Params 3, eflags: 0x4
// Checksum 0x5bf3b8b3, Offset: 0x4310
// Size: 0x12a
function private vtolwarship_crash( speed, weaponkilledby, var_efd6abd0ea217b3d )
{
    self endon( #"explode" );
    self.iscrashing = 1;
    self clearlookatent();
    self notify( #"crashing" );
    self setscriptablepartstate( "engine_explosion", "on", 0 );
    self function_81aef1578a91f39e();
    glassdamagestate = "missile_damage";
    
    if ( weapon_utility::isbulletweapon( weaponkilledby ) )
    {
        glassdamagestate = "bullet_damage";
    }
    
    self setscriptablepartstate( "glass", glassdamagestate, 0 );
    self vehphys_crash();
    self function_d2b8ee2e1275daaf( 0 );
    self vehphys_enablecollisioncallback( 1 );
    thread function_6886803dbdf02738();
    bundle = self.streakinfo.bundle;
    crashtime = bundle.var_59c1f28fba40f5b5 ?? 5;
    utility::waittill_any_timeout( crashtime, "collision" );
    self notify( #"stop_trace_for_any_collision" );
    self function_d2b8ee2e1275daaf( 1 );
    self vehphys_enablecollisioncallback( 0 );
    killstreak_utility::function_daa9374e3f6779a5( self.streakinfo.streakname, "pilot" );
}

// Namespace vtol_warship
// Params 0, eflags: 0xc
// Checksum 0xcd9250ab, Offset: 0x4442
// Size: 0xcd
function private function_6886803dbdf02738()
{
    self notify( #"hash_c2f8a7a1881cc841" );
    self endon( #"hash_c2f8a7a1881cc841" );
    self endon( #"traceforanycollision", #"death", #"stop_trace_for_any_collision" );
    ignorelist = [ self ];
    
    while ( true )
    {
        currentpos = self.origin;
        velocity = self vehicle_getvelocity();
        testpos = currentpos + velocity * level.framedurationseconds;
        collisiontrace = trace::sphere_trace( currentpos, testpos, 250, ignorelist );
        
        if ( isdefined( collisiontrace ) )
        {
            if ( collisiontrace[ "hittype" ] != "hittype_none" )
            {
                self notify( #"collision" );
            }
        }
        
        waitframe();
        
        if ( !isdefined( self ) )
        {
            return;
        }
    }
}

// Namespace vtol_warship
// Params 0, eflags: 0x4
// Checksum 0x22b50346, Offset: 0x4517
// Size: 0xaa
function private vtolwarship_explode()
{
    if ( self.isexploding )
    {
        return;
    }
    
    if ( self.owner )
    {
        self.owner thread killstreak_utility::playkillstreaktacomdialog( self.streakinfo, undefined, #"destroyed" );
    }
    
    self notify( #"explode" );
    self.isexploding = 1;
    level callback::callback( #"killstreak_finish_use", { #streakinfo:self.streakinfo } );
    self setscriptablepartstate( "explode", "on", 0 );
    self setscriptablepartstate( "explode_smoke", "on", 0 );
    wait 0.35;
    thread vtolwarship_delete( 1 );
}

// Namespace vtol_warship
// Params 1
// Checksum 0x6830447c, Offset: 0x45c9
// Size: 0x107
function vtolwarship_delete( wasdestroyed )
{
    if ( self.iscleaning )
    {
        return;
    }
    
    self.iscleaning = 1;
    
    /#
        if ( utility::issharedfuncdefined( #"player", #"printgameaction" ) )
        {
            [[ utility::getsharedfunc( #"player", #"printgameaction" ) ]]( "<dev string:x43>", self.owner );
        }
    #/
    
    if ( self.streakinfo )
    {
        self.streakinfo.expiredbydeath = istrue( wasdestroyed );
        
        if ( self.owner )
        {
            self.owner killstreak_utility::recordkillstreakendstats( self.streakinfo );
        }
    }
    
    self stoploopsound();
    
    if ( isdefined( self.firetarget ) )
    {
        self.firetarget delete();
    }
    
    if ( isdefined( self.killcament ) )
    {
        self.killcament delete();
    }
    
    vehicle_tracking::deregister_instance( self );
    vehicle_occupancy::deregister_instance( self );
    vehicle_tracking::delete_vehicle( self );
}

// Namespace vtol_warship
// Params 1
// Checksum 0xc63e59f4, Offset: 0x46d8
// Size: 0x21b
function vtolwarship_returnplayer( iscrashing )
{
    owner = self.owner;
    
    if ( !isdefined( owner ) )
    {
        return;
    }
    
    bundle = killstreak_utility::function_f943c0602acdc2af( "vtol_warship" );
    streakinfo = self.streakinfo;
    
    if ( owner isvehicleactive() )
    {
        owner thread killstreak_utility::function_7018f59706013760( bundle );
        owner leavevehicle();
    }
    
    owner setclientomnvar( o"ui_apache_controls", 0 );
    owner namespace_9d8e359c3b1041e5::function_f6af4ffa6dbb4645( streakinfo.streakname, "off" );
    namespace_9d8e359c3b1041e5::clearoobsharedfunc( self, 1 );
    
    if ( isdefined( level.var_fa0d180f4b71bc0e ) )
    {
        thread [[ level.var_fa0d180f4b71bc0e ]]( streakinfo );
    }
    
    owner.vehicle = undefined;
    thread function_93dcd1d0293867bb( owner, iscrashing, streakinfo );
    owner notify( #"vtolwarship_returning_player" );
    owner endon( #"disconnect" );
    
    if ( utility::issharedfuncdefined( #"game", #"disable_backpack_inventory" ) )
    {
        owner [[ utility::getsharedfunc( #"game", #"disable_backpack_inventory" ) ]]( 0 );
    }
    
    if ( isdefined( self.playersfx ) )
    {
        self.playersfx stoploopsound();
        self.playersfx delete();
    }
    
    vtolwarship_lockedonremovedcallback();
    owner clearclienttriggeraudiozone( 0.5 );
    owner val::set( "vtolWarship", "allow_movement", 0 );
    owner clearcinematicmotionoverride();
    owner player_utility::setthermalvision( 0 );
    function_fe2123dba85371ec( owner );
    owner killstreak_utility::killstreak_setmainvision( "" );
    owner shellshock_utility_cpmp::_stopshellshock();
    owner val::group_reset( "vtolWarshipUse" );
    owner val::reset_all( "vtolWarship" );
    level thread killstreak_utility::restorekillstreakplayerangles( owner );
    owner killstreak_utility::function_f1c03b279632ba1e();
    owner namespace_9d8e359c3b1041e5::freezecontrolssharedfunc( 0 );
    owner setclientomnvar( "ui_apache_screens_state", 0 );
    owner painvisionon();
    owner killstreak_shared::killstreak_restorenvgstate();
    owner killstreak_shared::function_b3302c4317df36c6();
    owner notify( #"vtolwarship_finished_crash_anim" );
    streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
}

// Namespace vtol_warship
// Params 3, eflags: 0x4
// Checksum 0xc092e5fc, Offset: 0x48fb
// Size: 0xce
function private function_93dcd1d0293867bb( owner, iscrashing, streakinfo )
{
    if ( !iscrashing )
    {
        return;
    }
    
    self endon( #"explode" );
    owner endon( #"disconnect" );
    streakinfo endon( #"killstreak_finished_with_deploy_weapon" );
    level endon( #"game_ended" );
    self waittill( #"death" );
    owner killstreak_utility::killstreak_setmainvision( "killstreak_static" );
    owner cameraunlink();
    owner killstreak_utility::killstreak_setmainvision( "" );
    level thread killstreak_utility::restorekillstreakplayerangles( owner );
    owner killstreak_utility::function_f1c03b279632ba1e();
    owner namespace_9d8e359c3b1041e5::freezecontrolssharedfunc( 0 );
    owner setclientomnvar( "ui_apache_screens_state", 0 );
    owner painvisionon();
    owner killstreak_shared::killstreak_restorenvgstate();
    streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
}

// Namespace vtol_warship
// Params 0, eflags: 0x4
// Checksum 0x82badfb2, Offset: 0x49d1
// Size: 0x70
function private vtolwarship_watchearlyexit()
{
    self endon( #"death", #"leaving", #"crashing" );
    
    if ( utility::issharedfuncdefined( #"killstreak", #"allowridekillstreakplayerexit" ) )
    {
        self thread [[ utility::getsharedfunc( #"killstreak", #"allowridekillstreakplayerexit" ) ]]( "leaving" );
    }
    
    self waittill( #"killstreakexit" );
    thread vtolwarship_leave();
}

// Namespace vtol_warship
// Params 1, eflags: 0x4
// Checksum 0x8389519, Offset: 0x4a49
// Size: 0x9b
function private vtolwarship_watchexplosioninfluencepoint( owner )
{
    owner endon( #"disconnect" );
    level endon( #"game_ended" );
    self waittill( #"explode", position );
    owner notify( #"gunner_turret_impact", position );
    
    if ( utility::issharedfuncdefined( #"spawn", #"addSpawnInfluencer" ) )
    {
        [[ utility::getsharedfunc( #"spawn", #"addSpawnInfluencer" ) ]]( #"hash_eafb9a6b88def4ca", position, owner.team, owner );
    }
}

// Namespace vtol_warship
// Params 1, eflags: 0x4
// Checksum 0x83f0dec4, Offset: 0x4aec
// Size: 0x1a
function private vtolwarship_empapplied( data )
{
    if ( isdefined( self ) )
    {
        vtolwarship_handledeathdamage( data );
    }
}

// Namespace vtol_warship
// Params 3, eflags: 0x4
// Checksum 0x62ea9e37, Offset: 0x4b0e
// Size: 0xc9
function private vtolwarship_spawn( streakinfo, origin, angles )
{
    vehicletype = self.team == "axis" ? streakinfo.bundle.vtolwarship_vehicleguild : streakinfo.bundle.vtolwarship_vehicle;
    spawndata = { #vehicletype:vehicletype, #targetname:streakinfo.streakname, #angles:angles, #origin:origin };
    vtolwarship = vehicle_tracking::spawn_vehicle( spawndata );
    vtolwarship addcomponent( "p2p" );
    return vtolwarship;
}

// Namespace vtol_warship
// Params 5
// Checksum 0x57d958da, Offset: 0x4be0
// Size: 0xb0
function function_9e2dc3451d5a7f99( goalpoint, stopatgoal, goaldistance, var_33a7f54f64823521, goalheightenable )
{
    self function_eb88c4e66edbc855( "p2p", "goalPoint", goalpoint );
    self function_eb88c4e66edbc855( "p2p", "stopAtGoal", stopatgoal );
    self function_eb88c4e66edbc855( "p2p", "goalThreshold", goaldistance );
    self function_eb88c4e66edbc855( "p2p", "reachGoal2DEnable", var_33a7f54f64823521 );
    self function_eb88c4e66edbc855( "p2p", "vtol3DReachGoalHeightEnable", goalheightenable );
    self function_eb88c4e66edbc855( "p2p", "stopAtGoalOscillationFrequency", 0.25 );
    self function_eb88c4e66edbc855( "p2p", "vtol3DStrafeInputEnable", 0 );
}

// Namespace vtol_warship
// Params 1
// Checksum 0x7aaf880c, Offset: 0x4c98
// Size: 0x24
function vtolwarship_setspeed( speedmph )
{
    self function_eb88c4e66edbc855( "p2p", "manualSpeed", utility::mph_to_ips( speedmph ) );
}

// Namespace vtol_warship
// Params 1, eflags: 0x4
// Checksum 0x3d6e11f3, Offset: 0x4cc4
// Size: 0xf3
function private function_f91e87bc8ebda76( playerorigin )
{
    currindex = 0;
    closedist = 3.40282e+38;
    var_aed5686dadbc210f = utility::issharedfuncdefined( #"chopper_gunner", #"findtargetstruct" );
    
    for ( i = 0; i < level.heli_structs_entrances.size ; i++ )
    {
        entrancestruct = level.heli_structs_entrances[ i ];
        goalstruct = undefined;
        
        if ( var_aed5686dadbc210f )
        {
            goalstruct = [[ utility::getsharedfunc( #"chopper_gunner", #"findtargetstruct" ) ]]( entrancestruct.script_linkto, level.heli_structs_goals );
        }
        
        if ( isdefined( goalstruct ) )
        {
            currdist = distancesquared( playerorigin, goalstruct.origin );
            
            if ( currdist < closedist )
            {
                currindex = i;
                closedist = currdist;
            }
        }
    }
    
    return currindex;
}

