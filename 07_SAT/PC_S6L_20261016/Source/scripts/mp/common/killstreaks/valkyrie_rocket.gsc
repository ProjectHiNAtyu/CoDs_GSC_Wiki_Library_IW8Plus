// scripts\mp\common\killstreaks\valkyrie_rocket.gsc  (hash_08462d605c46ead6.gscc) (size: 28078 Bytes / 0x6dae / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6fb632f6 (1874211574)
// size ...... 28078 (0x6dae)
// includes .. 13  (offset: 0x686e)
// strings ... 58  (offset: 0x68d6)
// dev strs .. 18  (offset: 0x6cba)
// exports ... 73  (offset: 0x3f7e)
// cseg ...... 0x46e + 0x3b10 (0x3f7e)
// imports ... 244 (offset: 0x4ae6)
// animtree1 . 0   (offset: 0x6dae)
// animtree2 . 0   (offset: 0x6dae)
#using script_13865ca76df87ea;
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\damage_tuning;
#using scripts\common\killstreaks\killstreak_common;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\shellshock_utility;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_tracking;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\killstreak_utility;

#namespace valkyrie_rocket;

// Namespace valkyrie_rocket
// Params 0, eflags: 0x1
// Checksum 0xff49da5d, Offset: 0x48c
// Size: 0x17
function autoexec main()
{
    killstreak_shared::registerkillstreakinitfunction( #"valkyrie_rocket", &init );
}

// Namespace valkyrie_rocket
// Params 0
// Checksum 0xac522be6, Offset: 0x4ab
// Size: 0x100
function init()
{
    bundle = level.streakglobals.streakbundles[ "valkyrie_rocket" ];
    
    if ( isdefined( bundle.var_e8c2fad51f4754d4 ) )
    {
        level._effect[ "valkyrie_muzzle_fx" ] = loadfxasset( bundle.var_e8c2fad51f4754d4 );
    }
    
    if ( isdefined( bundle.var_78a9d5afea20b02d ) )
    {
        level._effect[ "valkyrie_exhaust_fx" ] = loadfxasset( bundle.var_78a9d5afea20b02d );
    }
    
    namespace_9d8e359c3b1041e5::registerkillstreaksharedfunc( "valkyrie_rocket", &function_79224948e6ccf0b2, &function_f9201d4d112a2368, undefined, &function_4afaee487cd79f3d );
    killstreaks::function_86727939e376e882( function_5b219a2bf6b02f20() );
    namespace_9d8e359c3b1041e5::registerkillstreakstowableweaponsharedfunc( "valkyrie_rocket", utility::get_scripted_weapon_name( #"valkyrie_rocket" ), &function_b3b4a6933c37b76d, "launcherWeapon", undefined, bundle.usedsplashref );
    namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( "valkyrie_rocket", function_5b219a2bf6b02f20(), #"low" );
    level function_4dae86ddc2eada6f();
}

// Namespace valkyrie_rocket
// Params 1
// Checksum 0x5b7871c4, Offset: 0x5b3
// Size: 0x85
function function_79224948e6ccf0b2( streakinfo )
{
    if ( !isdefined( self.var_759c7fd51c75b043 ) )
    {
        function_81bc936380cb266e( streakinfo );
    }
    
    streakinfo.var_eb73e9ec9b9d912d = 1;
    childthread function_21834c8d4a08630c( streakinfo );
    childthread function_b7b84d855a5f0ff6( streakinfo );
    
    if ( utility::issharedfuncdefined( #"sound", #"playkillstreakdeploydialog" ) )
    {
        self [[ utility::getsharedfunc( #"sound", #"playkillstreakdeploydialog" ) ]]( streakinfo.streakname );
    }
}

// Namespace valkyrie_rocket
// Params 1
// Checksum 0x27169baa, Offset: 0x640
// Size: 0xc
function function_f9201d4d112a2368( streakitem )
{
    
}

// Namespace valkyrie_rocket
// Params 1, eflags: 0x4
// Checksum 0x909c942, Offset: 0x654
// Size: 0x75
function private function_81bc936380cb266e( streakitem )
{
    assert( !isdefined( self.var_759c7fd51c75b043 ), "<dev string:x24>" );
    lastclipammo = 1;
    self.var_759c7fd51c75b043 = { #currrocket:undefined, #streakitem:streakitem, #laststockammo:2 - lastclipammo, #lastclipammo:lastclipammo, #remainammo:2 };
}

// Namespace valkyrie_rocket
// Params 0
// Checksum 0xfa315497, Offset: 0x6d1
// Size: 0xc
function function_8a4f05d4b5f8d3fd()
{
    self.var_759c7fd51c75b043 = undefined;
}

// Namespace valkyrie_rocket
// Params 0
// Checksum 0x99ecb981, Offset: 0x6e5
// Size: 0x2c7
function function_4dae86ddc2eada6f()
{
    if ( isdefined( level.var_7d9f145aacaa2eb1 ) )
    {
        return;
    }
    
    var_c25a2344d1a97bb = level.streakglobals.streakbundles[ "valkyrie_rocket" ];
    
    if ( !isdefined( var_c25a2344d1a97bb ) )
    {
        var_c25a2344d1a97bb = spawnstruct();
    }
    
    level.var_7d9f145aacaa2eb1 = spawnstruct();
    level.var_7d9f145aacaa2eb1.lifetime = var_c25a2344d1a97bb.var_cf17ba523149df60 ?? 10;
    level.var_7d9f145aacaa2eb1.maxdistance = var_c25a2344d1a97bb.var_43b9f57a2f87b648 ?? 8000;
    level.var_7d9f145aacaa2eb1.health = var_c25a2344d1a97bb.var_1b063c9f4cd6b5fd ?? 100;
    level.var_7d9f145aacaa2eb1.normalspeed = var_c25a2344d1a97bb.var_207a3ca45333abcf ?? 25;
    level.var_7d9f145aacaa2eb1.topspeed = var_c25a2344d1a97bb.var_6efaacb4ed1197a5 ?? 50;
    level.var_7d9f145aacaa2eb1.maxdamage = var_c25a2344d1a97bb.var_c8835a93fcd6fb82 ?? 500;
    level.var_7d9f145aacaa2eb1.mindamage = var_c25a2344d1a97bb.var_9cd7471804f06118 ?? 10;
    level.var_7d9f145aacaa2eb1.damagerange = var_c25a2344d1a97bb.var_54fd0bbc28a32447 ?? 200;
    level.var_7d9f145aacaa2eb1.var_6037aa9d74feb190 = var_c25a2344d1a97bb.var_3fc225aed153e74b ?? 200;
    level.var_7d9f145aacaa2eb1.var_85083a1f5deb6439 = var_c25a2344d1a97bb.var_2fa47bbfd91028aa ?? 50;
    level.var_7d9f145aacaa2eb1.physicsscale = var_c25a2344d1a97bb.var_e131b79ec445ac24 ?? 1;
    level.var_7d9f145aacaa2eb1.var_daf36cd34eed831d = var_c25a2344d1a97bb.var_2498d9497b192afb ?? "";
    level.var_7d9f145aacaa2eb1.var_d2db3f7765ecb94a = var_c25a2344d1a97bb.var_3256556639ad91b ?? "";
    level.var_7d9f145aacaa2eb1.var_d96e788ca76a6582 = var_c25a2344d1a97bb.var_dce6ede0eb57005c ?? "";
    level.var_7d9f145aacaa2eb1.var_7b5b5381c90bcf8d = var_c25a2344d1a97bb.var_10f4d1e03b166b6a ?? "";
    killstreak_shared::function_28d986de72ce85f8( "cruise_color_mp" );
    val::group_register( "driving_valkyrie_rocket", [ "weapon_switch", "autoreload", "reload", "shellshock" ] );
    namespace_9d8e359c3b1041e5::registervisibilityomnvarforkillstreaksharedfunc( "valkyrie_rocket", "on", 18 );
}

// Namespace valkyrie_rocket
// Params 1
// Checksum 0xa5592863, Offset: 0x9b4
// Size: 0x10c
function function_627b85b049914275( streakinfo )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"valkyrie_fired" );
    streakinfo endon( #"killstreak_finished_with_deploy_weapon" );
    launcherweaponname = function_b3b4a6933c37b76d( streakinfo );
    
    while ( true )
    {
        if ( !utility::isusingremote() )
        {
            if ( self playerads() < 0.85 || self getcurrentweapon().basename != launcherweaponname )
            {
                namespace_9d8e359c3b1041e5::function_f6af4ffa6dbb4645( streakinfo.streakname, "off" );
                fullscreenfxoff( #"hud" );
            }
            else if ( self playerads() >= 0.85 )
            {
                namespace_9d8e359c3b1041e5::function_f6af4ffa6dbb4645( streakinfo.streakname, "on" );
                fullscreenfxon( #"hud" );
            }
            
            /#
                function_55a6fbf961ff03bd();
            #/
            
            /#
                if ( getdvarint( @"hash_59985c2387aae260", 0 ) )
                {
                    function_630c0896a950b0fb();
                }
            #/
        }
        
        waitframe();
    }
}

/#

    // Namespace valkyrie_rocket
    // Params 0
    // Checksum 0x73952dd5, Offset: 0xac8
    // Size: 0x71, Type: dev
    function function_55a6fbf961ff03bd()
    {
        bundle = level.streakglobals.streakbundles[ "<dev string:x55>" ];
        
        if ( self playerads() >= 1 )
        {
            if ( function_c0b9de28c106c66( bundle.var_ae6678efcb8f1679 ?? 500 ) )
            {
                printtoscreen2d( 700, 400, "<dev string:x65>", ( 1, 0, 0 ), 1.5 );
            }
        }
    }

    // Namespace valkyrie_rocket
    // Params 0
    // Checksum 0x8b40a01a, Offset: 0xb41
    // Size: 0x64, Type: dev
    function function_630c0896a950b0fb()
    {
        if ( self playerads() >= 1 )
        {
            utility::draw_capsule( function_6522bc5437ffed5c(), 3, 0, ( 0, 0, 0 ), ( 1, 0, 0 ) );
            utility::draw_capsule( function_e496da54d5482867(), 3, 0, ( 0, 0, 0 ), ( 0, 1, 0 ) );
        }
    }

#/

// Namespace valkyrie_rocket
// Params 1
// Checksum 0xe360e859, Offset: 0xbad
// Size: 0x130
function function_b7b84d855a5f0ff6( streakinfo )
{
    self endon( #"death" );
    level endon( #"hash_fa0cfbee663b705f" );
    streakinfo endon( #"killstreak_stowable_weapon_switched" );
    
    if ( !isdefined( self.var_759c7fd51c75b043 ) )
    {
        return;
    }
    
    while ( self.var_759c7fd51c75b043.remainammo > 0 )
    {
        val::reset( "trigger_killstreak", "interactions" );
        launcherweaponname = function_b3b4a6933c37b76d( streakinfo );
        
        if ( self getcurrentweapon().basename != launcherweaponname )
        {
            waitframe();
            continue;
        }
        else if ( self getammocount( self getcurrentweapon() ) <= 0 )
        {
            break;
        }
        
        fireresult = function_4af863d00d39c131( streakinfo );
        
        if ( fireresult )
        {
            val::set( "trigger_killstreak", "interactions", 0 );
            self.var_759c7fd51c75b043.remainammo--;
            self waittill( #"hash_769534f8253e5aa7" );
        }
        
        waitframe();
    }
    
    val::reset( "trigger_killstreak", "interactions" );
    streakinfo notify( #"hash_63d442da696dc5c9" );
    function_8a4f05d4b5f8d3fd();
    streakinfo notify( function_b3b4a6933c37b76d( streakinfo ) + "_killstreak_ammo_used_all" );
}

// Namespace valkyrie_rocket
// Params 1
// Checksum 0xb8ed9af7, Offset: 0xce5
// Size: 0xb9
function function_21834c8d4a08630c( streakinfo )
{
    self notify( #"hash_c6a543d52b9ffd64" );
    self endon( #"hash_c6a543d52b9ffd64" );
    streakinfo endon( #"hash_63d442da696dc5c9" );
    self waittill( #"death" );
    
    if ( isdefined( self.var_759c7fd51c75b043.currrocket ) && self.var_759c7fd51c75b043.currrocket.owneralive )
    {
        self.var_759c7fd51c75b043.currrocket.owneralive = 0;
    }
    else
    {
        function_c44fa84f8bf81248( streakinfo );
        namespace_9d8e359c3b1041e5::function_f6af4ffa6dbb4645( "valkyrie_rocket", "off" );
    }
    
    function_8a4f05d4b5f8d3fd();
}

// Namespace valkyrie_rocket
// Params 0
// Checksum 0x19b57d66, Offset: 0xda6
// Size: 0x18d
function function_d2e08308d747dbf4()
{
    self endon( #"exploded" );
    wait 0.3;
    
    while ( true )
    {
        self waittill( #"collision", body0, body1, flag0, flag1, position, normal, impulse, ent );
        
        if ( ent )
        {
            if ( isplayer( ent ) || isai( ent ) )
            {
                if ( level.teambased && ent != self.owner && ent.team === self.owner.team )
                {
                    waitframe();
                    continue;
                }
            }
            else if ( ent.var_aa82c7f64e626133 )
            {
                continue;
            }
            else
            {
                surfacetype = physics_getsurfacetypefromflags( flag1 )[ "name" ];
                
                if ( surfacetype == "surftype_glass_pane" )
                {
                    currtime = gettime();
                    
                    if ( !self.var_fd48c3196a686869 || ( currtime - self.var_fd48c3196a686869 ) * 0.001 > 0.1 )
                    {
                        glassradiusdamage( self.origin, 100, 1000, 1000 );
                        self.var_fd48c3196a686869 = currtime;
                        waitframe();
                        continue;
                    }
                    
                    self.var_fd48c3196a686869 = currtime;
                }
            }
        }
        
        self notify( #"explode_collision", body0, body1, flag0, flag1, position, normal, impulse, ent );
        waitframe();
    }
}

// Namespace valkyrie_rocket
// Params 0
// Checksum 0x21976b77, Offset: 0xf3b
// Size: 0x57
function function_e88cda0867dde64e()
{
    self endon( #"exploded" );
    hitwater = 0;
    
    while ( true )
    {
        rocketloc = self getorigin();
        
        if ( isdefined( rocketloc ) )
        {
            hitwater = utility::ispointinwater( rocketloc );
        }
        
        if ( hitwater )
        {
            self notify( #"water_collision" );
            break;
        }
        
        waitframe();
    }
}

// Namespace valkyrie_rocket
// Params 1
// Checksum 0xe7c7e989, Offset: 0xf9a
// Size: 0xeb
function onexplode( explodeinfo )
{
    if ( isdefined( self.owner ) )
    {
        var_7d8721c04744106f = 26 * anglestoforward( self.angles );
        self radiusdamage( self.origin + var_7d8721c04744106f, level.var_7d9f145aacaa2eb1.damagerange, level.var_7d9f145aacaa2eb1.maxdamage, level.var_7d9f145aacaa2eb1.mindamage, self.owner, "MOD_EXPLOSIVE", function_5b219a2bf6b02f20() );
    }
    
    physicsexplosionsphere( self.origin, level.var_7d9f145aacaa2eb1.var_6037aa9d74feb190, level.var_7d9f145aacaa2eb1.var_85083a1f5deb6439, level.var_7d9f145aacaa2eb1.physicsscale );
    thread function_cabd8c60dde2905b( explodeinfo );
    thread rocketcleanup();
}

// Namespace valkyrie_rocket
// Params 1
// Checksum 0xb8c76e6f, Offset: 0x108d
// Size: 0x161
function function_cabd8c60dde2905b( explodeinfo )
{
    self.var_ccb1b15bbdb66cd1 delete();
    fxent = spawn( "script_model", self gettagorigin( "tag_origin" ) );
    fxent setmodel( "ks_valkyrie_rocket" );
    fxent.angles = self gettagangles( "tag_origin" );
    fxent.team = self.team;
    fxent linkto( self, "tag_origin" );
    
    if ( explodeinfo.msg == "water_collision" )
    {
        fxent setscriptablepartstate( "water_explosion", "on", 0 );
    }
    else if ( explodeinfo.msg == "explode_collision" )
    {
        worldup = ( 0, 0, 1 );
        surfacenormal = explodeinfo.param6;
        self.angles = vectortoangles( surfacenormal );
        angledirection = vectordot( surfacenormal, worldup );
        
        if ( angledirection >= 0.7 )
        {
            fxent setscriptablepartstate( "ground_explosion", "on", 0 );
        }
        else
        {
            fxent setscriptablepartstate( "air_explosion", "on", 0 );
        }
    }
    else
    {
        fxent setscriptablepartstate( "air_explosion", "on", 0 );
    }
    
    wait 0.5;
    fxent unlink();
    fxent delete();
}

// Namespace valkyrie_rocket
// Params 1
// Checksum 0xb229fed8, Offset: 0x11f6
// Size: 0xbf
function function_61635dbbf2c39aee( rocket )
{
    level endon( #"hash_fa0cfbee663b705f" );
    self endon( #"killstreak_cancel" );
    rocket vehphys_enablecollisioncallback( 1 );
    rocket thread function_ba35668748495bf8();
    rocket thread function_74b597be24082454();
    rocket thread function_e88cda0867dde64e();
    rocket thread function_d2e08308d747dbf4();
    childthread function_22ebbf785dc1b047( rocket );
    childthread function_46f4575812bcd452( rocket );
    explodeinfo = rocket function_1508367dbb980769( "water_collision", "explode_collision", "explode_portal_collision", "expired", "detonate", "shot_down", "exceed_range" );
    
    if ( isdefined( rocket ) )
    {
        function_e587117a01b3ee47( rocket );
        rocket onexplode( explodeinfo );
    }
    
    self notify( #"hash_769534f8253e5aa7" );
}

// Namespace valkyrie_rocket
// Params 0
// Checksum 0x2ac32a62, Offset: 0x12bd
// Size: 0x6e
function rocketcleanup()
{
    if ( isdefined( self.owner ) )
    {
        self.owner function_47457b9ec007482e( "ui_veh_warning", 2, 1, 0 );
    }
    
    self notify( #"exploded" );
    clearsfx_third( self );
    function_8d1a70f9d83e1a54( self );
    
    if ( isdefined( self.killcament ) )
    {
        self.killcament delete();
    }
    
    vehicle_tracking::deregister_instance( self );
    vehicle_tracking::delete_vehicle( self );
}

// Namespace valkyrie_rocket
// Params 2
// Checksum 0xfe656239, Offset: 0x1333
// Size: 0x1b8
function function_e587117a01b3ee47( rocket, cancel )
{
    if ( !rocket.var_8b3c828f5635c6b8 )
    {
        rocket.var_8b3c828f5635c6b8 = 1;
    }
    else
    {
        return;
    }
    
    if ( isalive( self ) && rocket.owneralive )
    {
        level thread namespace_9d8e359c3b1041e5::restorekillstreakplayeranglessharedfunc( self );
        
        if ( cancel )
        {
            thread function_2d9e422485c28b56( 0 );
            thread function_3c12a0bce5605bbe( 0 );
            thread function_a5f58631f47e83f5();
        }
        else
        {
            fullscreenfxon( #"explosion" );
            thread function_2d9e422485c28b56( 0.35 );
            thread function_3c12a0bce5605bbe( 0.5 );
            thread function_a5f58631f47e83f5( 0.35 );
        }
    }
    else
    {
        function_c44fa84f8bf81248( rocket.streakinfo );
        thread function_3c12a0bce5605bbe( 0 );
        thread function_2d9e422485c28b56( 0.5 );
        thread function_a5f58631f47e83f5();
    }
    
    if ( self isvehicleactive() )
    {
        self leavevehicle();
    }
    
    if ( rocket.var_77ff08dd90ccd98c )
    {
        self cameraunlink();
    }
    
    if ( !utility::issp() )
    {
        self lerpfovbypreset( "default" );
    }
    
    namespace_9d8e359c3b1041e5::function_f6af4ffa6dbb4645( "valkyrie_rocket", "off" );
    killstreak_shared::function_76bbbe12ce816ed2();
    killstreak_shared::function_b3302c4317df36c6();
    clearsfx_first( rocket );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"flare_system" ][ #"defender_cleanup" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        rocket [[ var_32dbca3143d9c4a5 ]]();
    }
    
    if ( level.gametypebundle.var_711e33239e4c9925 )
    {
        assert( callback::exists( #"killstreak_cancel", &function_bb67bb3858761f2e, rocket ) );
        callback::remove( #"killstreak_cancel", &function_bb67bb3858761f2e, rocket );
    }
}

// Namespace valkyrie_rocket
// Params 1, eflags: 0x4
// Checksum 0xfa1fd478, Offset: 0x14f3
// Size: 0x73
function private function_c44fa84f8bf81248( streakinfo )
{
    if ( streakinfo && killstreaks::function_86ffe5755d194a83( streakinfo, streakinfo.weaponstruct.basename ) )
    {
        function_42a41485dd13f935( streakinfo );
        
        if ( streakinfo.var_1672d83eade494f7 )
        {
            level callback::callback( #"killstreak_finish_use", { #streakinfo:streakinfo } );
            streakinfo.var_1672d83eade494f7 = 0;
        }
    }
}

// Namespace valkyrie_rocket
// Params 2, eflags: 0x4
// Checksum 0x4cc31d88, Offset: 0x156e
// Size: 0x1e
function private function_4afaee487cd79f3d( streakitem, streakinfo )
{
    function_42a41485dd13f935( streakinfo );
}

// Namespace valkyrie_rocket
// Params 1, eflags: 0x4
// Checksum 0xf7ccec3e, Offset: 0x1594
// Size: 0x2c
function private function_42a41485dd13f935( streakinfo )
{
    if ( isdefined( streakinfo ) && !isdefined( streakinfo.var_66b36a56400a5730 ) )
    {
        namespace_9d8e359c3b1041e5::recordkillstreakendstatssharedfunc( streakinfo );
    }
}

// Namespace valkyrie_rocket
// Params 1
// Checksum 0x8b1bfe28, Offset: 0x15c8
// Size: 0x2e
function function_3c12a0bce5605bbe( delayduration )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    wait delayduration;
    namespace_9d8e359c3b1041e5::clearusingremotesharedfunc();
}

// Namespace valkyrie_rocket
// Params 0
// Checksum 0x7d088f27, Offset: 0x15fe
// Size: 0xf
function function_886ae52bdcf37f52()
{
    val::group_set( "driving_valkyrie_rocket", 0 );
}

// Namespace valkyrie_rocket
// Params 1
// Checksum 0x6a996a84, Offset: 0x1615
// Size: 0x39
function function_a5f58631f47e83f5( duration )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( isdefined( duration ) )
    {
        wait duration;
    }
    
    val::group_reset( "driving_valkyrie_rocket" );
}

// Namespace valkyrie_rocket
// Params 0
// Checksum 0xa8b5ba82, Offset: 0x1656
// Size: 0xc7
function function_74b597be24082454()
{
    self endon( #"exploded" );
    self.lifetimeendtime = self.lifetime * 1000 + gettime();
    self.currlifetime = 0;
    player = self.owner;
    
    while ( self.currlifetime < self.lifetime )
    {
        self.currlifetime += level.framedurationseconds * function_2ba35a78aa082f73() / level.var_7d9f145aacaa2eb1.normalspeed;
        player setclientomnvar( "ui_killstreak_lifetime", 1 - self.currlifetime / self.lifetime );
        waitframe();
    }
    
    self notify( #"expired" );
}

// Namespace valkyrie_rocket
// Params 0
// Checksum 0x3cfbb083, Offset: 0x1725
// Size: 0x2af
function function_ba35668748495bf8()
{
    self endon( #"exploded" );
    
    if ( !self.owner function_5c766d1d0140b86( "ui_valkyrie_rocket_signal_strength" ) )
    {
        return;
    }
    
    self.var_57a79936d19666aa = spawn( "script_origin", self.origin );
    self.var_57a79936d19666aa linkto( self );
    self.var_57a79936d19666aa hide();
    self.var_57a79936d19666aa showtoplayer( self.owner );
    prevstrength = 0;
    
    while ( true )
    {
        rocketdistance = length( self getorigin() - self.spawnlocation );
        
        if ( rocketdistance >= level.var_7d9f145aacaa2eb1.maxdistance )
        {
            self.owner setclientomnvar( "ui_valkyrie_rocket_signal_strength", 0 );
            self.owner fullscreenfxoff( #"med_signal" );
            self.owner fullscreenfxoff( #"low_signal" );
            self notify( #"exceed_range" );
            break;
        }
        
        distratio = rocketdistance / level.var_7d9f145aacaa2eb1.maxdistance;
        
        if ( distratio < getdvarfloat( @"hash_9b56c77cd244176", 0.25 ) )
        {
            currstrength = 1;
        }
        else if ( distratio < getdvarfloat( @"hash_dd31c175af94638a", 0.75 ) )
        {
            currstrength = 2;
        }
        else
        {
            currstrength = 3;
        }
        
        if ( prevstrength != currstrength )
        {
            self.owner setclientomnvar( "ui_valkyrie_rocket_signal_strength", currstrength );
            
            switch ( currstrength )
            {
                case 1:
                    self.owner fullscreenfxoff( #"med_signal" );
                    self.owner fullscreenfxoff( #"low_signal" );
                    self.var_57a79936d19666aa stoploopsound();
                    break;
                case 2:
                    self.owner fullscreenfxon( #"med_signal" );
                    self.owner fullscreenfxoff( #"low_signal" );
                    self.var_57a79936d19666aa playloopsound( "ks_valkyrie_rocket_lp_signal_loss" );
                    break;
                case 3:
                    self.owner fullscreenfxoff( #"med_signal" );
                    self.owner fullscreenfxon( #"low_signal" );
                    self.var_57a79936d19666aa playloopsound( "ks_valkyrie_rocket_lp_signal_loss" );
                    break;
                default:
                    break;
            }
            
            prevstrength = currstrength;
        }
        
        waitframe();
    }
}

// Namespace valkyrie_rocket
// Params 1
// Checksum 0x8523d9de, Offset: 0x19dc
// Size: 0x28
function function_22ebbf785dc1b047( rocket )
{
    rocket endon( #"exploded" );
    wait 0.8;
    childthread function_3b7e699da5dddd22( rocket );
}

// Namespace valkyrie_rocket
// Params 1
// Checksum 0x67016a09, Offset: 0x1a0c
// Size: 0x32
function function_3b7e699da5dddd22( rocket )
{
    while ( self attackbuttonpressed() )
    {
        waitframe();
    }
    
    while ( !self attackbuttonpressed() )
    {
        waitframe();
    }
    
    rocket notify( #"detonate" );
}

// Namespace valkyrie_rocket
// Params 1
// Checksum 0x37f53249, Offset: 0x1a46
// Size: 0x15e
function function_46f4575812bcd452( rocket )
{
    rocket endon( #"exploded" );
    
    if ( isbot( self ) )
    {
        return;
    }
    
    while ( self sprintbuttonpressed() )
    {
        waitframe();
    }
    
    while ( !self sprintbuttonpressed() )
    {
        waitframe();
    }
    
    rocket function_33d2754103778ebf();
    rocket notify( #"rocket_boost" );
    thread function_8dc7058631df00c3( rocket );
    fullscreenfxon( #"boost" );
    function_8df6e9ea6f1e832b( rocket, level.var_7d9f145aacaa2eb1.var_d96e788ca76a6582, level.var_7d9f145aacaa2eb1.var_7b5b5381c90bcf8d );
    
    if ( !utility::issp() )
    {
        self lerpfovbypreset( "valkyrie_rocket_zoom_in" );
    }
    
    bundle = level.streakglobals.streakbundles[ "valkyrie_rocket" ];
    
    if ( isdefined( bundle.alertfulllength ) )
    {
        curlifetime = rocket.currlifetime ?? 0;
        var_4d808b8cc863e746 = ( rocket.lifetime - curlifetime ) * level.var_7d9f145aacaa2eb1.normalspeed / level.var_7d9f145aacaa2eb1.topspeed;
        endtime = gettime() + utility::function_4b74c15943231980( var_4d808b8cc863e746 );
        rocket killstreak_shared::function_852e7d8d403629e3( endtime );
    }
}

// Namespace valkyrie_rocket
// Params 1
// Checksum 0x731476ef, Offset: 0x1bac
// Size: 0x2e3, Type: bool
function function_4af863d00d39c131( streakinfo )
{
    if ( self getcurrentweaponclipammo() <= 0 )
    {
        return false;
    }
    
    thread function_627b85b049914275( streakinfo );
    launcherweaponname = function_b3b4a6933c37b76d( streakinfo );
    
    while ( !self attackbuttonpressed() || self isreloading() )
    {
        if ( self getcurrentweapon().basename != launcherweaponname )
        {
            return false;
        }
        
        waitframe();
    }
    
    while ( self playerads() < 1 )
    {
        waitframe();
    }
    
    self setweaponammoclip( self getcurrentweapon(), 0 );
    self painvisionoff();
    var_2c50ebc26185557b = level.sharedfuncs[ #"damage_effects" ][ #"hash_7ff5e70e05a98fb0" ];
    
    if ( isdefined( var_2c50ebc26185557b ) )
    {
        [[ var_2c50ebc26185557b ]]( 0.2 );
    }
    
    self notify( #"valkyrie_fired" );
    namespace_9d8e359c3b1041e5::registerkillstreakweaponfiresharedfunc( streakinfo, launcherweaponname );
    function_886ae52bdcf37f52();
    namespace_9d8e359c3b1041e5::setusingremotesharedfunc( streakinfo.streakname );
    shellshock_utility::_stopshellshock();
    rocket = function_f09fda9d907f25eb( streakinfo );
    
    if ( !isdefined( rocket ) )
    {
        fullscreenfxon( #"explosion" );
        thread function_2d9e422485c28b56( 0.35 );
        thread function_3c12a0bce5605bbe( 0.5 );
        thread function_a5f58631f47e83f5();
        namespace_9d8e359c3b1041e5::function_f6af4ffa6dbb4645( streakinfo.streakname, "off" );
        self.var_759c7fd51c75b043.remainammo--;
        thread function_c916cfd0c75eb5ca( streakinfo, function_3d8343e08a8d1604(), self getgunangles() );
        return false;
    }
    
    if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) )
    {
        self thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( "used_" + "valkyrie_rocket", self );
    }
    
    rocket.killcament = spawn( "script_model", rocket.var_ccb1b15bbdb66cd1 gettagorigin( "tag_player" ) );
    rocket.killcament setmodel( "tag_origin" );
    rocket.killcament linkto( rocket.var_ccb1b15bbdb66cd1, "tag_player" );
    rocket.killcament namespace_9d8e359c3b1041e5::setscriptmoverkillcamsharedfunc( "rocket", 0, 0 );
    self.var_759c7fd51c75b043.currrocket = rocket;
    thread function_2d1785db3d30b41e( rocket );
    rocket thread function_172d10845c36e3a( streakinfo );
    rocket thread watchdisconnect();
    rocket.var_670c0bc02418cdc3 = &function_bf416f1bf5eb2087;
    
    if ( level.gametypebundle.var_711e33239e4c9925 )
    {
        assert( !callback::exists( #"killstreak_cancel", &function_bb67bb3858761f2e, rocket ) );
        callback::add( #"killstreak_cancel", &function_bb67bb3858761f2e, rocket );
    }
    
    function_9c32d5d9e47044e2( streakinfo, rocket );
    
    /#
        thread function_b476bd9b8da862e2( rocket );
    #/
    
    rocket thread function_111f62279289db91();
    return true;
}

// Namespace valkyrie_rocket
// Params 0
// Checksum 0xaedb959a, Offset: 0x1e98
// Size: 0x119
function function_111f62279289db91()
{
    self endon( #"exploded" );
    radius = 196;
    
    while ( true )
    {
        var_4049537beff91e38 = getentitylessscriptablearray( undefined, undefined, self.origin, radius, "door" );
        
        foreach ( door in var_4049537beff91e38 )
        {
            if ( door.var_395c22e69066741d )
            {
                door.var_395c22e69066741d notify( #"trigger", self );
            }
        }
        
        nearestdoor = function_6cf720856f2ecd74( self.origin, radius );
        
        if ( isdefined( nearestdoor ) && nearestdoor isscriptableinstance() && nearestdoor scriptabledoorisclosed() )
        {
            nearestdoor scriptabledooropen( "away", self.origin );
        }
        
        waitframe();
    }
}

// Namespace valkyrie_rocket
// Params 1
// Checksum 0xeacc4406, Offset: 0x1fb9
// Size: 0xb3
function function_2d1785db3d30b41e( rocket )
{
    rocket endon( #"exploded" );
    rocket endon( #"rocket_boost" );
    thread function_c640580c2b04fee4( rocket );
    self earthquakeforplayer( 0.2, 0.4, rocket.origin, 5000 );
    wait 0.4;
    
    while ( true )
    {
        scale = randomfloatrange( 0.04, 0.05 );
        duration = randomfloatrange( 0.3, 0.8 );
        self function_1424d4f7ff5404c5( scale, scale, scale, duration + 1, rocket.origin, 5000, 10000, 15000 );
        wait duration;
    }
}

// Namespace valkyrie_rocket
// Params 1
// Checksum 0x613f59f6, Offset: 0x2074
// Size: 0x8d
function function_c640580c2b04fee4( rocket )
{
    rocket endon( #"exploded" );
    rocket waittill( #"rocket_boost" );
    wait 0.4;
    
    while ( true )
    {
        scale = randomfloatrange( 0.05, 0.08 );
        duration = randomfloatrange( 0.2, 0.3 );
        self function_1424d4f7ff5404c5( scale, scale, scale, duration + 1, rocket.origin, 5000, 10000, 15000 );
        wait duration;
    }
}

// Namespace valkyrie_rocket
// Params 3
// Checksum 0xc1e2737a, Offset: 0x2109
// Size: 0xf8
function function_c916cfd0c75eb5ca( streakinfo, pos, angle )
{
    rocket = utility::spawn_tag_origin();
    rocket.streakinfo = streakinfo;
    self kill( pos, self, rocket, "MOD_EXPLOSIVE", function_5b219a2bf6b02f20() );
    rocket radiusdamage( pos, level.var_7d9f145aacaa2eb1.damagerange, level.var_7d9f145aacaa2eb1.maxdamage, level.var_7d9f145aacaa2eb1.mindamage, self, "MOD_EXPLOSIVE", function_5b219a2bf6b02f20() );
    physicsexplosionsphere( pos, level.var_7d9f145aacaa2eb1.var_6037aa9d74feb190, level.var_7d9f145aacaa2eb1.var_85083a1f5deb6439, level.var_7d9f145aacaa2eb1.physicsscale );
    thread function_824aab4bc4d1f7ff( pos, angle );
    wait 0.5;
    rocket delete();
}

// Namespace valkyrie_rocket
// Params 2
// Checksum 0xdd32a75a, Offset: 0x2209
// Size: 0x65
function function_824aab4bc4d1f7ff( pos, angle )
{
    fxent = spawn( "script_model", pos );
    fxent setmodel( "ks_valkyrie_rocket" );
    fxent.angles = angle;
    fxent setscriptablepartstate( "air_explosion", "on", 0 );
    wait 0.5;
    fxent delete();
}

/#

    // Namespace valkyrie_rocket
    // Params 1
    // Checksum 0x2a93c590, Offset: 0x2276
    // Size: 0xf4, Type: dev
    function function_b476bd9b8da862e2( rocket )
    {
        level endon( #"game_ended" );
        self endon( #"disconnect" );
        
        while ( isdefined( rocket ) )
        {
            if ( !rocket.owneralive )
            {
                break;
            }
            
            printtoscreen2d( 1500, 1900, "<dev string:x7a>", ( 1, 1, 1 ), 3 );
            printtoscreen2d( 2200, 1900, int( length( rocket getorigin() - rocket.spawnlocation ) ) + "<dev string:x96>" + level.var_7d9f145aacaa2eb1.maxdistance, ( 1, 1, 1 ), 3 );
            
            if ( rocket.veh_speed > level.var_7d9f145aacaa2eb1.normalspeed + 5 )
            {
                printtoscreen2d( 1800, 1700, "<dev string:x98>", ( 1, 0, 0 ), 3 );
            }
            
            waitframe();
        }
    }

#/

// Namespace valkyrie_rocket
// Params 1
// Checksum 0x9c311cc8, Offset: 0x2372
// Size: 0xdd
function function_c4fbc50aa13556b1( rocket )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    rocket endon( #"exploded" );
    var_4565558cb4444c1e = [];
    bundle = killstreak::function_85b2d8e857ab4898( "valkyrie_rocket" );
    
    foreach ( data in bundle.var_e0715b47471288fb )
    {
        var_4565558cb4444c1e[ var_4565558cb4444c1e.size ] = data.killstreakname;
    }
    
    killstreak_shared::function_505d16f50dee75d2( var_4565558cb4444c1e );
}

// Namespace valkyrie_rocket
// Params 1, eflags: 0x4
// Checksum 0x4e2939b7, Offset: 0x2457
// Size: 0x60
function private function_3f95c619a3d55825( params )
{
    if ( params.attacker.streakinfo && self.owner )
    {
        self.owner thread killstreak_utility::playkillstreaktacomdialog( params.attacker.streakinfo, undefined, #"target_archangel" );
    }
}

// Namespace valkyrie_rocket
// Params 2
// Checksum 0x9f82d9f, Offset: 0x24bf
// Size: 0x21b
function function_9c32d5d9e47044e2( streakinfo, rocket )
{
    self.restoreangles = self.angles;
    
    if ( utility::issharedfuncdefined( #"killstreak", #"addtoactivekillstreaklist" ) )
    {
        rocket [[ utility::getsharedfunc( #"killstreak", #"addtoactivekillstreaklist" ) ]]( streakinfo.streakname, "Killstreak_Air", self, 0, 0, 100 );
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"flare_system" ][ #"defender_init" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        rocket [[ var_32dbca3143d9c4a5 ]]( 0, 0, 0, 1, 1, &function_3f95c619a3d55825 );
    }
    
    thread function_ccd11930ee549565( streakinfo, rocket );
    
    if ( rocket.var_77ff08dd90ccd98c )
    {
        self cameraunlink();
        self cameralinkto( rocket, "tag_player", 1 );
    }
    
    self usevehicle( rocket, 0 );
    bundle = level.streakglobals.streakbundles[ "valkyrie_rocket" ];
    
    if ( isdefined( bundle.alertfulllength ) )
    {
        endtime = gettime() + utility::function_4b74c15943231980( rocket.lifetime );
        rocket thread killstreak_shared::function_585fb909f40d8659( endtime, bundle.alertfulllength, bundle.var_c3193942aa25f78, bundle.var_28e5801bce7f4815, bundle.var_b84c3eae995cb030, bundle.var_ed6c729701a7f3ed );
    }
    
    rocket rcplane_settopspeedboost( level.var_7d9f145aacaa2eb1.topspeed );
    level notify( #"valkyrie_incoming", self, rocket );
    thread function_33c4765d04ccdad3( rocket );
    thread function_fd2e086e052fd8e8( rocket );
    namespace_9d8e359c3b1041e5::function_f6af4ffa6dbb4645( streakinfo.streakname, "on" );
    killstreak_shared::function_9fc2f7ee10890d99( "valkyrie_rocket" );
    killstreak_shared::function_a402a9f43d6f7512( "killstreak_shared", bundle.var_598d79add3230927, bundle.var_f057b69340b14a5c, bundle.var_225c495bde49787b );
    thread function_c4fbc50aa13556b1( rocket );
    thread function_61635dbbf2c39aee( rocket );
}

// Namespace valkyrie_rocket
// Params 1
// Checksum 0xe922b098, Offset: 0x26e2
// Size: 0x1ac
function function_33c4765d04ccdad3( rocket )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    rocket endon( #"exploded" );
    rocket endon( #"rocket_boost" );
    wait 0.1;
    
    if ( utility::fxexists( "valkyrie_muzzle_fx" ) )
    {
        playfx( utility::getfx( "valkyrie_muzzle_fx" ), function_6522bc5437ffed5c(), function_fd69ddbe8530c682(), anglestoup( function_fd69ddbe8530c682() ) );
    }
    
    if ( utility::fxexists( "valkyrie_exhaust_fx" ) )
    {
        playfx( utility::getfx( "valkyrie_exhaust_fx" ), function_e496da54d5482867(), function_fd69ddbe8530c682(), anglestoup( function_fd69ddbe8530c682() ) );
    }
    
    wait 0.1;
    rocket.var_ccb1b15bbdb66cd1 show();
    rocket.var_ccb1b15bbdb66cd1 setscriptablepartstate( "main_thruster", "on" );
    rocket.var_ccb1b15bbdb66cd1 unlink();
    tiltoffsetvec = ( -8, 0, 0 );
    
    while ( lengthsquared( rocket.angles + tiltoffsetvec - rocket.var_ccb1b15bbdb66cd1.angles ) > 1 )
    {
        rocket.var_ccb1b15bbdb66cd1.origin = rocket.origin;
        rocket.var_ccb1b15bbdb66cd1.angles = anglelerpquat( rocket.var_ccb1b15bbdb66cd1.angles, rocket.angles + tiltoffsetvec, 1.5 );
        waitframe();
    }
    
    rocket.var_ccb1b15bbdb66cd1 linkto( rocket );
}

// Namespace valkyrie_rocket
// Params 1
// Checksum 0xe50d6726, Offset: 0x2896
// Size: 0x113
function function_8dc7058631df00c3( rocket )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    rocket endon( #"exploded" );
    rocket.var_ccb1b15bbdb66cd1 unlink();
    rocket.var_ccb1b15bbdb66cd1 setscriptablepartstate( "main_thruster", "off" );
    rocket.var_ccb1b15bbdb66cd1 setscriptablepartstate( "boost_thruster", "on" );
    
    while ( lengthsquared( rocket.angles - rocket.var_ccb1b15bbdb66cd1.angles ) > 1 )
    {
        rocket.var_ccb1b15bbdb66cd1.origin = rocket.origin;
        rocket.var_ccb1b15bbdb66cd1.angles = anglelerpquat( rocket.var_ccb1b15bbdb66cd1.angles, rocket.angles, 2 );
        waitframe();
    }
    
    rocket.var_ccb1b15bbdb66cd1 linkto( rocket );
}

// Namespace valkyrie_rocket
// Params 1
// Checksum 0x17f5ea8c, Offset: 0x29b1
// Size: 0x7f
function function_fd2e086e052fd8e8( rocket )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    rocket endon( #"exploded" );
    rocket endon( #"rocket_boost" );
    rocket function_bbd72f8cae3ff50f( level.var_7d9f145aacaa2eb1.normalspeed / 2 );
    wait 0.25;
    rocket function_bbd72f8cae3ff50f( level.var_7d9f145aacaa2eb1.normalspeed );
}

// Namespace valkyrie_rocket
// Params 1
// Checksum 0x8ab991ac, Offset: 0x2a38
// Size: 0x33
function function_bbd72f8cae3ff50f( speed )
{
    if ( self.var_77ff08dd90ccd98c )
    {
        self rcplane_setminspeed( speed );
        self rcplane_settopspeed( speed );
        return;
    }
    
    self vehicle_settopspeedforward( speed );
}

// Namespace valkyrie_rocket
// Params 2
// Checksum 0x89f4ea2f, Offset: 0x2a73
// Size: 0x10b
function function_ccd11930ee549565( streakinfo, rocket )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"death" );
    rocket endon( #"exploded" );
    rocket endon( #"rocket_boost" );
    bundle = level.streakglobals.streakbundles[ "valkyrie_rocket" ];
    
    if ( isdefined( bundle.var_f7b4468ef595f097 ) )
    {
        self playlocalsound( bundle.var_f7b4468ef595f097 );
    }
    
    if ( isdefined( bundle.var_21998136f675ef47 ) )
    {
        if ( utility::issp() )
        {
            self playsound( bundle.var_21998136f675ef47 );
        }
        else
        {
            self playsound( bundle.var_21998136f675ef47, self );
        }
    }
    
    wait 0.5;
    function_8df6e9ea6f1e832b( rocket, level.var_7d9f145aacaa2eb1.var_daf36cd34eed831d, level.var_7d9f145aacaa2eb1.var_d2db3f7765ecb94a );
}

// Namespace valkyrie_rocket
// Params 3
// Checksum 0x997e507a, Offset: 0x2b86
// Size: 0x8c
function function_8df6e9ea6f1e832b( rocket, sfx_first, sfx_third )
{
    if ( isdefined( rocket.flightsfx_first ) )
    {
        rocket.flightsfx_first stoploopsound();
        
        if ( isdefined( sfx_first ) )
        {
            rocket.flightsfx_first playloopsound( sfx_first );
        }
    }
    
    if ( isdefined( rocket.flightsfx_third ) )
    {
        rocket.flightsfx_third stoploopsound();
        
        if ( isdefined( sfx_third ) )
        {
            rocket.flightsfx_third playloopsound( sfx_third );
        }
    }
}

// Namespace valkyrie_rocket
// Params 1, eflags: 0x4
// Checksum 0xb7b1365f, Offset: 0x2c1a
// Size: 0x3b
function private clearsfx_first( rocket )
{
    if ( isdefined( rocket.flightsfx_first ) )
    {
        rocket.flightsfx_first stoploopsound();
        rocket.flightsfx_first delete();
    }
}

// Namespace valkyrie_rocket
// Params 1, eflags: 0x4
// Checksum 0xb7b1365f, Offset: 0x2c5d
// Size: 0x3b
function private clearsfx_third( rocket )
{
    if ( isdefined( rocket.flightsfx_third ) )
    {
        rocket.flightsfx_third stoploopsound();
        rocket.flightsfx_third delete();
    }
}

// Namespace valkyrie_rocket
// Params 1, eflags: 0x4
// Checksum 0xc14f7ae, Offset: 0x2ca0
// Size: 0x3b
function private function_8d1a70f9d83e1a54( rocket )
{
    if ( isdefined( rocket.var_57a79936d19666aa ) )
    {
        rocket.var_57a79936d19666aa stoploopsound();
        rocket.var_57a79936d19666aa delete();
    }
}

// Namespace valkyrie_rocket
// Params 1, eflags: 0x4
// Checksum 0x67b3d1d3, Offset: 0x2ce3
// Size: 0x26
function private function_bf416f1bf5eb2087( trigger )
{
    rocket = self;
    rocket notify( #"explode_portal_collision" );
}

// Namespace valkyrie_rocket
// Params 0, eflags: 0x4
// Checksum 0x64066818, Offset: 0x2d11
// Size: 0xb, Type: bool
function private function_3b7c8e5f57419d63()
{
    return !function_c0b9de28c106c66( 90 );
}

// Namespace valkyrie_rocket
// Params 1, eflags: 0x4
// Checksum 0x8b0e19c0, Offset: 0x2d25
// Size: 0x22f, Type: bool
function private function_c0b9de28c106c66( tracedistance )
{
    tracestartpos = function_3d8343e08a8d1604();
    traceendpos = tracestartpos + anglestoforward( self getgunangles() ) * tracedistance;
    tracecontent = trace::create_contents( 1, 1, 1, 1, 1, 1, 1, 0, 0 );
    ignorelist = [ self ];
    
    if ( level.teambased && self.team )
    {
        allies = getplayersinradius( tracestartpos, tracedistance, undefined, 0, self, self.team );
        
        if ( allies )
        {
            ignorelist = arraycombine( ignorelist, allies );
        }
    }
    
    traceback = trace::sphere_trace( tracestartpos, traceendpos, 3, ignorelist, tracecontent );
    
    if ( traceback[ "hittype" ] != "hittype_none" )
    {
        /#
            debugtextcolor = ( 0, 1, 0 );
            debugtextscale = 2;
            debugdrawframeduration = 600;
            debugposx = 500;
            debugposy = 1000;
            var_55c913ff3ae8f46a = 30;
            printtoscreen2d( debugposx, debugposy, "<dev string:xa0>" + traceback[ "<dev string:xb3>" ], debugtextcolor, debugtextscale, debugdrawframeduration );
            
            if ( isdefined( traceback[ "<dev string:xbb>" ] ) )
            {
                printtoscreen2d( debugposx, debugposy + var_55c913ff3ae8f46a * 2, "<dev string:xc2>" + ( traceback[ "<dev string:xbb>" ].classname ?? "<dev string:xce>" ), debugtextcolor, debugtextscale, debugdrawframeduration );
                printtoscreen2d( debugposx, debugposy + var_55c913ff3ae8f46a * 3, "<dev string:xd6>" + ( traceback[ "<dev string:xbb>" ].model ?? "<dev string:xce>" ), debugtextcolor, debugtextscale, debugdrawframeduration );
                printtoscreen2d( debugposx, debugposy + var_55c913ff3ae8f46a * 4, "<dev string:xde>" + ( traceback[ "<dev string:xbb>" ].owner.guid ?? "<dev string:xce>" ), debugtextcolor, debugtextscale, debugdrawframeduration );
                printtoscreen2d( debugposx, debugposy + var_55c913ff3ae8f46a * 5, "<dev string:xeb>" + ( traceback[ "<dev string:xbb>" ].owner.team ?? "<dev string:xce>" ), debugtextcolor, debugtextscale, debugdrawframeduration );
            }
        #/
        
        return true;
    }
    
    return false;
}

// Namespace valkyrie_rocket
// Params 1
// Checksum 0x8769f14d, Offset: 0x2f5d
// Size: 0x487
function function_f09fda9d907f25eb( streakinfo )
{
    spawnangle = self getgunangles();
    gunpos = function_3d8343e08a8d1604();
    var_18b45ddfd99be265 = anglestoforward( spawnangle ) * 10;
    spawnpos = gunpos + var_18b45ddfd99be265 + anglestoup( spawnangle ) * 0 + anglestoright( spawnangle ) * 0;
    
    if ( !function_3b7c8e5f57419d63() )
    {
        return;
    }
    
    var_77ff08dd90ccd98c = 1;
    spawndata = spawnstruct();
    spawndata.origin = spawnpos;
    spawndata.angles = spawnangle + ( 0, 0, randomintrange( -3, 3 ) );
    spawndata.vehicletype = streakinfo.bundle.deployedvehicle;
    spawndata.targetname = "rcplane";
    
    if ( var_77ff08dd90ccd98c )
    {
        spawndata.modelname = "tag_origin_rigid_valk_missile";
        spawndata.vehicletype = "veh_t10_valkyrie_rocket_deprecated";
    }
    
    faildata = spawnstruct();
    rocket = vehicle_tracking::spawn_vehicle( spawndata, faildata );
    
    if ( !isdefined( rocket ) )
    {
        /#
            thread utility::error( "<dev string:xf8>" );
        #/
        
        return;
    }
    
    bundle = level.streakglobals.streakbundles[ "valkyrie_rocket" ];
    rocket.var_77ff08dd90ccd98c = var_77ff08dd90ccd98c;
    rocket.angles = spawndata.angles;
    rocket.team = self.team;
    rocket.type = "remote";
    rockethealth = level.var_7d9f145aacaa2eb1.health;
    rocket.health = rockethealth;
    rocket.maxhealth = rockethealth;
    rocket.currenthealth = rockethealth;
    rocket.owner = self;
    rocket.lifetime = level.var_7d9f145aacaa2eb1.lifetime;
    rocket.weapon_name = function_5b219a2bf6b02f20();
    rocket.owneralive = isalive( self );
    rocket.spawnlocation = rocket.origin;
    rocket.streakinfo = streakinfo;
    rocket damage_tuning::setupdamagetuning( bundle.var_20cb8f4e47f3353e, rocket.maxhealth );
    rocket setvehicleteam( rocket.team );
    rocket setcandamage( 1 );
    rocket setscriptablepartstate( #"visibility", #"hide", 0 );
    var_ccb1b15bbdb66cd1 = utility::spawn_model( function_6c34fd225fadb4c4( streakinfo ), rocket.origin, rocket.angles );
    var_ccb1b15bbdb66cd1 linkto( rocket, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_ccb1b15bbdb66cd1 enableplayermarks( #"air_killstreak" );
    var_ccb1b15bbdb66cd1 filteroutplayermarks( level.teambased ? self.team : self );
    rocket.var_ccb1b15bbdb66cd1 = var_ccb1b15bbdb66cd1;
    rocket.var_ccb1b15bbdb66cd1 hide();
    rocket.flightsfx_first = spawn( "script_origin", rocket.origin );
    rocket.flightsfx_first linkto( rocket );
    rocket.flightsfx_first hide();
    rocket.flightsfx_first showtoplayer( self );
    rocket.flightsfx_third = spawn( "script_origin", rocket.origin );
    rocket.flightsfx_third linkto( rocket );
    rocket.flightsfx_third hidefromplayer( self );
    namespace_9d8e359c3b1041e5::killstreak_setupvehicledamagefunctionalitysharedfunc( "valkyrie_rocket", rocket, undefined, undefined, #"perform_callout", undefined, undefined, undefined, &function_2af2bc9743bd750d, &function_e5b90c60d16ee5a1 );
    vehicle_tracking::register_instance( rocket );
    
    if ( utility::issharedfuncdefined( #"spawn", #"addSpawnInfluencer" ) )
    {
        [[ utility::getsharedfunc( #"spawn", #"addSpawnInfluencer" ) ]]( #"killstreak_valkyrie", rocket.origin, rocket.team, rocket.owner, rocket );
    }
    
    return rocket;
}

// Namespace valkyrie_rocket
// Params 1
// Checksum 0x32056dbc, Offset: 0x33ed
// Size: 0x170, Type: bool
function function_2af2bc9743bd750d( data )
{
    objweapon = data.objweapon;
    type = data.meansofdeath;
    attacker = data.attacker;
    modifieddamage = data.damage;
    
    if ( level.var_deb9d2b3de25799b && utility::issharedfuncdefined( #"killstreak", #"getmodifieddamageusingdamagetuning" ) )
    {
        bundle = level.streakglobals.streakbundles[ "valkyrie_rocket" ];
        modifieddamage = self [[ utility::getsharedfunc( #"killstreak", #"getmodifieddamageusingdamagetuning" ) ]]( attacker, objweapon, type, modifieddamage, self.maxhealth, bundle.var_20cb8f4e47f3353e, data );
    }
    else if ( utility::issharedfuncdefined( #"killstreak", #"getmodifiedantikillstreakdamage" ) )
    {
        modifieddamage = self [[ utility::getsharedfunc( #"killstreak", #"getmodifiedantikillstreakdamage" ) ]]( attacker, objweapon, type, modifieddamage, self.maxhealth, 2, 3, 4, 12, 400 );
    }
    
    data.damage = modifieddamage;
    self.currenthealth -= modifieddamage;
    namespace_9d8e359c3b1041e5::killstreak_updatedamagestatesharedfunc( self.currenthealth );
    return true;
}

// Namespace valkyrie_rocket
// Params 1
// Checksum 0x58cbf750, Offset: 0x3566
// Size: 0x6a
function function_e5b90c60d16ee5a1( data )
{
    if ( data.objweapon.var_25b0062cbe4d9c99 == #"black_hat_sat_mp" && self.owner )
    {
        self.owner thread killstreak_utility::playkillstreaktacomdialog( self.streakinfo, undefined, #"destroyed_hacked" );
    }
    
    self notify( #"shot_down" );
}

// Namespace valkyrie_rocket
// Params 0
// Checksum 0x61b7c353, Offset: 0x35d8
// Size: 0x2c
function function_2ba35a78aa082f73()
{
    if ( isdefined( self.veh_speed ) )
    {
        return self.veh_speed;
    }
    
    return level.var_7d9f145aacaa2eb1.normalspeed;
}

// Namespace valkyrie_rocket
// Params 7
// Checksum 0xe9381eaf, Offset: 0x360d
// Size: 0x1d1
function function_1508367dbb980769( var_19eee95063be9ec9, var_19eee65063be9830, var_19eee75063be9a63, var_19eeec5063bea562, var_19eeed5063bea795, var_19eeea5063bea0fc, var_19eeeb5063bea32f )
{
    self endon( #"exploded" );
    ent = spawnstruct();
    
    if ( isdefined( var_19eee95063be9ec9 ) )
    {
        thread function_5af432e99cf487eb( var_19eee95063be9ec9, ent );
    }
    
    if ( isdefined( var_19eee65063be9830 ) )
    {
        thread function_5af432e99cf487eb( var_19eee65063be9830, ent );
    }
    
    if ( isdefined( var_19eee75063be9a63 ) )
    {
        thread function_5af432e99cf487eb( var_19eee75063be9a63, ent );
    }
    
    if ( isdefined( var_19eeec5063bea562 ) )
    {
        thread function_5af432e99cf487eb( var_19eeec5063bea562, ent );
    }
    
    if ( isdefined( var_19eeed5063bea795 ) )
    {
        thread function_5af432e99cf487eb( var_19eeed5063bea795, ent );
    }
    
    if ( isdefined( var_19eeea5063bea0fc ) )
    {
        thread function_5af432e99cf487eb( var_19eeea5063bea0fc, ent );
    }
    
    if ( isdefined( var_19eeeb5063bea32f ) )
    {
        thread function_5af432e99cf487eb( var_19eeeb5063bea32f, ent );
    }
    
    ent waittill( #"returned", msg, param1, param2, param3, param4, param5, param6, param7, param8 );
    ent notify( #"die" );
    explodeinfo = spawnstruct();
    explodeinfo.msg = msg;
    explodeinfo.param1 = param1;
    explodeinfo.param2 = param2;
    explodeinfo.param3 = param3;
    explodeinfo.param4 = param4;
    explodeinfo.param5 = param5;
    explodeinfo.param6 = param6;
    explodeinfo.param7 = param7;
    explodeinfo.param8 = param8;
    return explodeinfo;
}

// Namespace valkyrie_rocket
// Params 0, eflags: 0x4
// Checksum 0x2b4905f, Offset: 0x37e7
// Size: 0x1f
function private function_3d8343e08a8d1604()
{
    if ( self tagexists( "j_gun" ) )
    {
        return self gettagorigin( "j_gun" );
    }
    
    return self geteye();
}

// Namespace valkyrie_rocket
// Params 0, eflags: 0x4
// Checksum 0xae3fa717, Offset: 0x380f
// Size: 0x1f
function private function_fd69ddbe8530c682()
{
    if ( self tagexists( "j_gun" ) )
    {
        return self gettagangles( "j_gun" );
    }
    
    return self getgunangles();
}

// Namespace valkyrie_rocket
// Params 0
// Checksum 0xcb35fa2c, Offset: 0x3837
// Size: 0x68
function function_5b219a2bf6b02f20()
{
    if ( utility::issharedfuncdefined( #"valkyrie_rocket", #"hash_b385b994dc71fe33" ) )
    {
        return [[ utility::getsharedfunc( #"valkyrie_rocket", #"hash_b385b994dc71fe33" ) ]]();
    }
    
    bundle = level.streakglobals.streakbundles[ "valkyrie_rocket" ];
    return bundle.var_61f3d538f346e28c;
}

// Namespace valkyrie_rocket
// Params 2
// Checksum 0xcfef3e3a, Offset: 0x38a8
// Size: 0x7d
function function_5af432e99cf487eb( msg, ent )
{
    ent endon( #"die" );
    self waittill( msg, param1, param2, param3, param4, param5, param6 );
    ent notify( #"returned", msg, param1, param2, param3, param4, param5, param6 );
}

// Namespace valkyrie_rocket
// Params 1, eflags: 0x4
// Checksum 0xa9a34c77, Offset: 0x392d
// Size: 0xcd
function private function_172d10845c36e3a( streakinfo )
{
    self endon( #"exploded" );
    level waittill( #"hash_fa0cfbee663b705f" );
    streakinfo notify( #"hash_63d442da696dc5c9" );
    self.var_759c7fd51c75b043 = undefined;
    streakinfo notify( function_b3b4a6933c37b76d( streakinfo ) + "_killstreak_ammo_used_all" );
    clearsfx_first( self );
    clearsfx_third( self );
    function_8d1a70f9d83e1a54( self );
    
    if ( self.owner )
    {
        if ( streakinfo )
        {
            var_32dbca3143d9c4a5 = level.sharedfuncs[ #"killstreak" ][ #"hash_bf17c172d25e8b3d" ];
            
            if ( isdefined( var_32dbca3143d9c4a5 ) )
            {
                self.owner [[ var_32dbca3143d9c4a5 ]]( streakinfo );
            }
        }
        
        self.owner function_2d9e422485c28b56();
    }
    
    thread rocketcleanup();
}

// Namespace valkyrie_rocket
// Params 0, eflags: 0x4
// Checksum 0x8f42114d, Offset: 0x3a02
// Size: 0x4a
function private watchdisconnect()
{
    self endon( #"exploded" );
    self.owner waittill( #"disconnect" );
    self.owner function_8a4f05d4b5f8d3fd();
    thread onexplode();
    clearsfx_first( self );
    function_8d1a70f9d83e1a54( self );
}

// Namespace valkyrie_rocket
// Params 2, eflags: 0x4
// Checksum 0xec613a82, Offset: 0x3a54
// Size: 0x5a
function private function_bb67bb3858761f2e( params, rocket )
{
    function_e587117a01b3ee47( rocket, 1 );
    
    if ( isdefined( rocket.var_ccb1b15bbdb66cd1 ) )
    {
        rocket.var_ccb1b15bbdb66cd1 delete();
    }
    
    if ( isdefined( rocket ) )
    {
        rocket thread rocketcleanup();
    }
    
    self notify( #"hash_769534f8253e5aa7" );
}

// Namespace valkyrie_rocket
// Params 0, eflags: 0x4
// Checksum 0x1e36d60c, Offset: 0x3ab6
// Size: 0x61
function private function_6522bc5437ffed5c()
{
    bundle = level.streakglobals.streakbundles[ "valkyrie_rocket" ];
    spawnangle = function_fd69ddbe8530c682();
    var_18b45ddfd99be265 = anglestoforward( spawnangle ) * ( bundle.var_547e02679d62ccaf ?? 35 );
    return function_3d8343e08a8d1604() + var_18b45ddfd99be265;
}

// Namespace valkyrie_rocket
// Params 0, eflags: 0x4
// Checksum 0x33a6cc4, Offset: 0x3b20
// Size: 0x61
function private function_e496da54d5482867()
{
    bundle = level.streakglobals.streakbundles[ "valkyrie_rocket" ];
    spawnangle = function_fd69ddbe8530c682();
    var_bc2d8932725fff59 = anglestoforward( spawnangle ) * ( bundle.var_b74778a854918d42 ?? 23 );
    return function_3d8343e08a8d1604() - var_bc2d8932725fff59;
}

// Namespace valkyrie_rocket
// Params 1, eflags: 0x4
// Checksum 0x1f065dfd, Offset: 0x3b8a
// Size: 0x27
function private fullscreenfxon( fx_type )
{
    assert( isdefined( fx_type ), "<dev string:x14a>" );
    function_935732eb06e0f22f( fx_type, 1 );
}

// Namespace valkyrie_rocket
// Params 1, eflags: 0x4
// Checksum 0x67b523f5, Offset: 0x3bb9
// Size: 0x26
function private fullscreenfxoff( fx_type )
{
    assert( isdefined( fx_type ), "<dev string:x184>" );
    function_935732eb06e0f22f( fx_type, 0 );
}

// Namespace valkyrie_rocket
// Params 1, eflags: 0x4
// Checksum 0xc80d7df5, Offset: 0x3be7
// Size: 0x81
function private function_2d9e422485c28b56( delay_s )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( isdefined( delay_s ) )
    {
        wait delay_s;
    }
    
    if ( self )
    {
        fullscreenfxoff( #"explosion" );
        fullscreenfxoff( #"hud" );
        fullscreenfxoff( #"boost" );
        fullscreenfxoff( #"med_signal" );
        fullscreenfxoff( #"low_signal" );
    }
}

// Namespace valkyrie_rocket
// Params 2, eflags: 0x4
// Checksum 0xc2585429, Offset: 0x3c70
// Size: 0x1c5
function private function_935732eb06e0f22f( fx_type, ison )
{
    bundle = level.streakglobals.streakbundles[ "valkyrie_rocket" ];
    
    switch ( fx_type )
    {
        case #"hud":
            fullscreenfxparams = { #visionset:"cruise_color_mp", #postfxbundlename:bundle.var_2836bdd7955f67f1 };
            break;
        case #"boost":
            fullscreenfxparams = { #visionset:undefined, #postfxbundlename:bundle.var_3509dbb461bc4fb8 };
            break;
        case #"explosion":
            fullscreenfxparams = { #visionset:"killstreak_static", #postfxbundlename:bundle.var_4eb476fe6b0efd82 };
            break;
        case #"med_signal":
            fullscreenfxparams = { #visionset:undefined, #postfxbundlename:bundle.var_39ae53729b241f74 };
            break;
        case #"low_signal":
            fullscreenfxparams = { #visionset:undefined, #postfxbundlename:bundle.var_4ea017d1dc969817 };
            break;
        default:
            assertmsg( "<dev string:x1bf>" );
            fullscreenfxparams = { #visionset:undefined, #postfxbundlename:undefined };
            break;
    }
    
    if ( ison )
    {
        self [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_d6d2b1e7868b8f30" ] ]]( fullscreenfxparams );
        return;
    }
    
    self [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_fd9af8d6ec7cc6fb" ] ]]( fullscreenfxparams );
}

// Namespace valkyrie_rocket
// Params 1, eflags: 0x4
// Checksum 0xd9f947ed, Offset: 0x3e3d
// Size: 0x9c
function private function_b3b4a6933c37b76d( streakinfo )
{
    blueprintindex = streakinfo.mpstreaksysteminfo.blueprintindex ?? streakinfo.blueprintindex;
    
    if ( !isdefined( blueprintindex ) )
    {
        return;
    }
    
    bundle = level.streakglobals.streakbundles[ "valkyrie_rocket" ];
    weaponname = namespace_de7b719e85d98dcc::genericblueprint_getweaponname( namespace_de7b719e85d98dcc::function_9800c005d17e1d42( bundle, blueprintindex ), "launcherWeapon" );
    
    if ( !isdefined( weaponname ) )
    {
        weaponname = utility::get_scripted_weapon_name( #"valkyrie_rocket" );
    }
    
    return weaponname;
}

// Namespace valkyrie_rocket
// Params 1, eflags: 0x4
// Checksum 0xafa718b1, Offset: 0x3ee2
// Size: 0x9b
function private function_6c34fd225fadb4c4( streakinfo )
{
    blueprintindex = streakinfo.mpstreaksysteminfo.blueprintindex ?? streakinfo.blueprintindex;
    
    if ( !isdefined( blueprintindex ) )
    {
        return;
    }
    
    bundle = level.streakglobals.streakbundles[ "valkyrie_rocket" ];
    modelname = namespace_de7b719e85d98dcc::function_4854a08f7de8f427( namespace_de7b719e85d98dcc::function_9800c005d17e1d42( bundle, blueprintindex ), #"xmodel", "rocketModel" );
    
    if ( !isdefined( modelname ) )
    {
        modelname = "projectile_streak_t10_valkyrie_missile";
    }
    
    return modelname;
}

