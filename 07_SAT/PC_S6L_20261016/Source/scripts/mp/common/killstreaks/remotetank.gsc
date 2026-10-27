// scripts\mp\common\killstreaks\remotetank.gsc  (hash_497972a153d3c5b8.gscc) (size: 8220 Bytes / 0x201c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf45f7ea2 (4099899042)
// size ...... 8220 (0x201c)
// includes .. 12  (offset: 0x1e90)
// strings ... 21  (offset: 0x1ef0)
// dev strs .. 0   (offset: 0x201c)
// exports ... 34  (offset: 0x1050)
// cseg ...... 0x1a3 + 0xead (0x1050)
// imports ... 78  (offset: 0x15a0)
// animtree1 . 0   (offset: 0x201c)
// animtree2 . 0   (offset: 0x201c)
#using script_13865ca76df87ea;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_omnvar_utility;
#using scripts\mp\chaff_debuff;
#using scripts\mp\common\equipment\haywire;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\emp_debuff;

#namespace remotetank;

// Namespace remotetank
// Params 1
// Checksum 0x3c76f2e6, Offset: 0x1c1
// Size: 0x103
function function_8071e6a7afd3150( tanktype )
{
    bundle = killstreak_utility::function_f943c0602acdc2af( tanktype );
    utility::flag_wait( "vehicle_init_done" );
    
    if ( bundle.deployedvehiclebundle && vehicle::has_data( bundle.deployedvehiclebundle ) )
    {
        killstreaks::registerkillstreakdamagedealingweapon( bundle.killstreakref, vehicle_damage::get_weapon_string( bundle.deployedvehiclebundle ), #"low" );
    }
    else if ( bundle.deployedvehicle && vehicle::has_data( getxhashasset( bundle.deployedvehicle ) ) )
    {
        killstreaks::registerkillstreakdamagedealingweapon( bundle.killstreakref, vehicle_damage::get_weapon_string( getxhashasset( bundle.deployedvehicle ) ), #"low" );
    }
    
    if ( bundle.var_c56b0231474b9c98 )
    {
        utility::registersharedfunc( bundle.killstreakref, #"interactswithoobtrigger", &function_fb6e7f2054bb919b );
    }
}

// Namespace remotetank
// Params 2, eflags: 0x4
// Checksum 0xa18d688b, Offset: 0x2cc
// Size: 0xe6
function private function_ec1cc0b8aad2a111( bundle, blueprintindex )
{
    genericblueprintname = undefined;
    
    if ( bundle.genericblueprintlist.blueprints.size > 0 && blueprintindex > 0 )
    {
        genericblueprintname = bundle.genericblueprintlist.blueprints[ blueprintindex - 1 ].genericblueprint;
    }
    else if ( isdefined( bundle.genericblueprintlist.blueprint_default ) )
    {
        genericblueprintname = bundle.genericblueprintlist.blueprint_default;
    }
    
    compositemodel = bundle.var_b10905350747afcc;
    
    if ( isdefined( genericblueprintname ) )
    {
        compositemodel = namespace_de7b719e85d98dcc::function_4854a08f7de8f427( genericblueprintname, #"xmodel", #"xcompositemodel" );
    }
    
    bundle.modelbase = compositemodel;
    return bundle;
}

// Namespace remotetank
// Params 3
// Checksum 0xee8577c6, Offset: 0x3bb
// Size: 0x29
function function_4176973a847e0899( tanktype, omnvarstate, omnvarvalue )
{
    killstreak_utility::registervisibilityomnvarforkillstreak( tanktype, omnvarstate, omnvarvalue );
}

// Namespace remotetank
// Params 2, eflags: 0x4
// Checksum 0xb85be933, Offset: 0x3ec
// Size: 0x35, Type: bool
function private function_fb6e7f2054bb919b( trigger, vehicle )
{
    return ispointinvolume( vehicle.origin, trigger ) && vehicle.isactive;
}

// Namespace remotetank
// Params 8
// Checksum 0x692c000a, Offset: 0x42a
// Size: 0x158
function remote_tank_create( owner, streakinfo, spawnloc, spawnangles, var_a213b0eb2076a1e7, var_65354c0b7473812, deathfunc, var_10215d5906f4fc28 )
{
    tank = killstreak_utility::killstreak_vehicle_create( owner, streakinfo, spawnloc, spawnangles, var_a213b0eb2076a1e7, var_65354c0b7473812, deathfunc, &remote_tank_remove );
    function_8ec792dde497ecf5( tank );
    function_8ec792dde497ecf5( tank, 1 );
    function_e0afb378d63fad75( tank );
    function_6c4e24382ee4f650( tank );
    
    if ( !var_10215d5906f4fc28 )
    {
        tank thread function_39b4679376930f19();
        tank thread function_689b30c0edbcdbf();
    }
    
    tank vehicle_turnengineon();
    lightstate = "daytime";
    
    if ( level.mapname == "mp_jup_grandprix_pm_2" || utility::isnightmap() )
    {
        lightstate = "nighttime";
    }
    
    tank setscriptablepartstate( "lights", lightstate, 0 );
    tank killstreak::addtoactivekillstreaklist( streakinfo.streakname, "Killstreak_Ground", tank.owner, 0, 1, 60 );
    level notify( #"matchrecording_small_ground_vehicle", tank );
    
    if ( !isdefined( level.var_4f0fd2ebe1215d76 ) )
    {
        level.var_4f0fd2ebe1215d76 = [];
    }
    
    level.var_4f0fd2ebe1215d76[ level.var_4f0fd2ebe1215d76.size ] = tank;
    return tank;
}

// Namespace remotetank
// Params 1
// Checksum 0x90662bc8, Offset: 0x58b
// Size: 0x24
function remote_tank_remove( tank )
{
    level.var_4f0fd2ebe1215d76 = arrayremove( level.var_4f0fd2ebe1215d76, tank );
}

// Namespace remotetank
// Params 0, eflags: 0x4
// Checksum 0xbf8ff0fe, Offset: 0x5b7
// Size: 0xbf
function private function_39b4679376930f19()
{
    self endon( #"death" );
    dustactive = 0;
    
    while ( true )
    {
        currentvehiclespeed = self vehicle_getspeed();
        var_5d88c6a0cf76b5c9 = currentvehiclespeed * 1.60934;
        
        if ( currentvehiclespeed > 1 && !dustactive )
        {
            dustactive = 1;
            
            if ( self getscriptablehaspart( "dust" ) )
            {
                self setscriptablepartstate( "dust", "on" );
            }
        }
        else if ( currentvehiclespeed <= 1 && dustactive )
        {
            dustactive = 0;
            
            if ( self getscriptablehaspart( "dust" ) )
            {
                self setscriptablepartstate( "dust", "off" );
            }
        }
        
        self.owner setclientomnvar( "ui_pac_sentry_speed", int( var_5d88c6a0cf76b5c9 ) );
        waitframe();
    }
}

// Namespace remotetank
// Params 0, eflags: 0x4
// Checksum 0xd2b3fbca, Offset: 0x67e
// Size: 0x9a
function private function_689b30c0edbcdbf()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    thread function_32c47beeda5a15dd();
    
    while ( true )
    {
        if ( function_5cdfe27f3e8ee406( self ) )
        {
            waitframe();
            continue;
        }
        
        driver = self.owner;
        
        if ( isdefined( driver ) )
        {
            movementinput = driver getnormalizedmovement();
            var_9c3923d8345f310b = abs( movementinput[ 0 ] );
            
            if ( var_9c3923d8345f310b >= 0.15 )
            {
                function_c8894ca7ef6b5642();
            }
            else
            {
                function_7defc80750ce3dc2();
            }
        }
        else
        {
            function_7defc80750ce3dc2();
        }
        
        waitframe();
    }
}

// Namespace remotetank
// Params 0
// Checksum 0xe9fa6f63, Offset: 0x720
// Size: 0x5a
function function_c8894ca7ef6b5642()
{
    self endon( #"death" );
    self endon( #"hash_9bf59ddbf7a5e770" );
    level endon( #"game_ended" );
    
    if ( self.engine_audio_active )
    {
        return;
    }
    
    self.engine_audio_active = 1;
    self playsoundonmovingent( "veh_wheelson_engine_start" );
    wait 0.5;
    self playloopsound( "veh_wheelson_engine_lp" );
}

// Namespace remotetank
// Params 1
// Checksum 0x5ca1ab8e, Offset: 0x782
// Size: 0x84
function function_7defc80750ce3dc2( fromdeath )
{
    if ( fromdeath )
    {
        self notify( #"hash_9bf59ddbf7a5e770" );
        self.engine_audio_active = undefined;
        self stoploopsound( "veh_wheelson_engine_lp" );
        return;
    }
    
    if ( self.engine_audio_active )
    {
        self notify( #"hash_9bf59ddbf7a5e770" );
        self endon( #"hash_9bf59ddbf7a5e770" );
        self.engine_audio_active = undefined;
        self playsoundonmovingent( "veh_wheelson_engine_stop" );
        wait 0.5;
        
        if ( isdefined( self ) )
        {
            self stoploopsound( "veh_wheelson_engine_lp" );
        }
    }
}

// Namespace remotetank
// Params 0, eflags: 0x4
// Checksum 0xf7061e30, Offset: 0x80e
// Size: 0x22
function private function_32c47beeda5a15dd()
{
    self endon( #"death" );
    level waittill( #"game_ended" );
    thread function_7defc80750ce3dc2();
}

// Namespace remotetank
// Params 2
// Checksum 0xf89bca94, Offset: 0x838
// Size: 0x2b
function function_51d427f6f87f1b46( tanktype, var_c63ebdc4f116b251 )
{
    if ( isdefined( tanktype ) && isdefined( var_c63ebdc4f116b251 ) )
    {
        vehicle_damage::set_vehicle_hit_damage_data( tanktype, var_c63ebdc4f116b251 );
    }
}

// Namespace remotetank
// Params 4
// Checksum 0x94d50465, Offset: 0x86b
// Size: 0x5e
function function_97ff0a36e51334d2( tanktype, weaponname, weaponhitsperattack, var_ffcfe5819a7a67f1 )
{
    if ( isdefined( tanktype ) && isdefined( weaponname ) && isdefined( weaponhitsperattack ) && isdefined( var_ffcfe5819a7a67f1 ) )
    {
        utility::callsharedfunc( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon", weaponname, weaponhitsperattack, var_ffcfe5819a7a67f1, tanktype );
    }
}

// Namespace remotetank
// Params 4
// Checksum 0x44bf0d16, Offset: 0x8d1
// Size: 0xa7
function function_8ec792dde497ecf5( tank, var_9b55f122c8a2773a, empstartedfunc, empclearedfunc )
{
    if ( var_9b55f122c8a2773a )
    {
        empstartedfunc = empstartedfunc ?? &function_9b203b2e4b9f4c8b;
        empclearedfunc = empclearedfunc ?? &function_8182f7315aececaa;
        
        if ( level.killstreak_emp_initialized )
        {
            tank.ksempapplycallback = empstartedfunc;
        }
        
        if ( level.killstreak_emp_initialized )
        {
            tank.ksempclearcallback = empclearedfunc;
        }
        
        return;
    }
    
    empstartedfunc = empstartedfunc ?? &remote_tank_empstarted;
    empclearedfunc = empclearedfunc ?? &remote_tank_empcleared;
    tank emp_debuff::set_start_emp_callback( empstartedfunc );
    tank emp_debuff::set_clear_emp_callback( empclearedfunc );
}

// Namespace remotetank
// Params 3
// Checksum 0xaf09a1fa, Offset: 0x980
// Size: 0x4a
function function_e0afb378d63fad75( tank, var_c7162a234b4bdf, var_231d00ef6afb7e42 )
{
    var_c7162a234b4bdf = var_c7162a234b4bdf ?? &function_c1ee2ba611df36b9;
    var_231d00ef6afb7e42 = var_231d00ef6afb7e42 ?? &function_1134868176b9db20;
    tank chaff_debuff::function_4118b0299dc40ea( var_c7162a234b4bdf );
    tank chaff_debuff::function_324dd42a2703bc25( var_231d00ef6afb7e42 );
}

// Namespace remotetank
// Params 3
// Checksum 0x43ff6d5b, Offset: 0x9d2
// Size: 0x4a
function function_6c4e24382ee4f650( tank, haywirestartfunc, var_38f7e81e0feb0e09 )
{
    haywirestartfunc = haywirestartfunc ?? &function_b197cd576851910e;
    var_38f7e81e0feb0e09 = var_38f7e81e0feb0e09 ?? &function_af829e4321ea2fdf;
    tank haywire::function_7f69a1eb3d590f76( haywirestartfunc );
    tank haywire::function_d7496c23fe4085d4( var_38f7e81e0feb0e09 );
}

// Namespace remotetank
// Params 1
// Checksum 0x5d9f1254, Offset: 0xa24
// Size: 0x2a
function remote_tank_empstarted( data )
{
    if ( !isdefined( self.owner ) )
    {
        return;
    }
    
    function_e36d934d3670a1f2( 1 );
    self vehicle_turnengineoff();
}

// Namespace remotetank
// Params 1
// Checksum 0xbe0f4f60, Offset: 0xa56
// Size: 0x15
function function_9b203b2e4b9f4c8b( data )
{
    remote_tank_empstarted( data );
}

// Namespace remotetank
// Params 1
// Checksum 0x614cbb5f, Offset: 0xa73
// Size: 0x41
function remote_tank_empcleared( isdeath )
{
    if ( !isdefined( self.owner ) )
    {
        return;
    }
    
    self vehicle_turnengineon();
    
    if ( !isdeath )
    {
        function_e36d934d3670a1f2( 0 );
    }
    
    self.owner thread emp_debuff::stop_emp_scramble( 5 );
}

// Namespace remotetank
// Params 1
// Checksum 0x13fcbc1a, Offset: 0xabc
// Size: 0x13
function function_8182f7315aececaa( data )
{
    remote_tank_empcleared();
}

// Namespace remotetank
// Params 1
// Checksum 0x96059c1e, Offset: 0xad7
// Size: 0x4c
function function_c1ee2ba611df36b9( data )
{
    if ( !isdefined( self.owner ) )
    {
        return;
    }
    
    function_e36d934d3670a1f2( 1 );
    self vehicle_turnengineoff();
    
    if ( isplayer( self.owner ) )
    {
        self.owner thread chaff_debuff::function_f966e23bd8f1adb5( 5 );
    }
}

// Namespace remotetank
// Params 1
// Checksum 0x4374b8b2, Offset: 0xb2b
// Size: 0x41
function function_1134868176b9db20( isdeath )
{
    if ( !isdefined( self.owner ) )
    {
        return;
    }
    
    self vehicle_turnengineon();
    
    if ( !isdeath )
    {
        function_e36d934d3670a1f2( 0 );
    }
    
    self.owner thread chaff_debuff::function_c1fa63136ba5a433( 5 );
}

// Namespace remotetank
// Params 1
// Checksum 0x6847a133, Offset: 0xb74
// Size: 0x8a
function function_b197cd576851910e( data )
{
    remotetank = data.victim;
    
    if ( !isdefined( remotetank.owner ) || remotetank.ishaywire )
    {
        return;
    }
    
    var_deb596d315f498c8 = self hascomponent( "p2p" );
    
    if ( !var_deb596d315f498c8 )
    {
        vehicle_omnvar::show_warning( "shockStickAttached", remotetank.owner, remotetank vehicle::get_ref() );
    }
    
    remotetank.ishaywire = 1;
}

// Namespace remotetank
// Params 1
// Checksum 0xf1caf645, Offset: 0xc06
// Size: 0x7a
function function_af829e4321ea2fdf( data )
{
    remotetank = data.victim;
    
    if ( !isdefined( remotetank.owner ) )
    {
        return;
    }
    
    var_deb596d315f498c8 = self hascomponent( "p2p" );
    
    if ( !var_deb596d315f498c8 )
    {
        vehicle_omnvar::hide_warning( "shockStickAttached", remotetank.owner, remotetank vehicle::get_ref() );
    }
    
    remotetank.ishaywire = 0;
}

// Namespace remotetank
// Params 1
// Checksum 0x2fe76302, Offset: 0xc88
// Size: 0x56
function function_e36d934d3670a1f2( isenabled )
{
    var_deb596d315f498c8 = self hascomponent( "p2p" );
    
    if ( !var_deb596d315f498c8 )
    {
        self.owner player::_freezelookcontrols( isenabled );
        self.owner player::_freezecontrols( isenabled );
    }
    
    function_88c76d348551059f( isenabled, var_deb596d315f498c8 );
}

// Namespace remotetank
// Params 2
// Checksum 0x677127b8, Offset: 0xce6
// Size: 0xa1
function function_88c76d348551059f( isenabled, var_deb596d315f498c8 )
{
    if ( !isenabled )
    {
        if ( var_deb596d315f498c8 )
        {
            self setconfigvalue( "p2p", "pause", 1 );
        }
        else
        {
            vehicle_omnvar::show_warning( "movementDisabled", self.owner, vehicle::get_ref() );
            self function_92e333ef50ff2c83( 1 );
            self.veh_throttle = 0;
        }
        
        return;
    }
    
    if ( var_deb596d315f498c8 )
    {
        self setconfigvalue( "p2p", "resume", 1 );
        return;
    }
    
    vehicle_omnvar::hide_warning( "movementDisabled", self.owner, vehicle::get_ref() );
    self function_92e333ef50ff2c83( 0 );
}

// Namespace remotetank
// Params 1
// Checksum 0x4027c982, Offset: 0xd8f
// Size: 0x1c
function function_7bd25a0153736d16( tanktype )
{
    if ( !isdefined( tanktype ) )
    {
        return;
    }
    
    return killstreak_utility::function_f943c0602acdc2af( tanktype );
}

// Namespace remotetank
// Params 1
// Checksum 0x49f4a72a, Offset: 0xdb4
// Size: 0x12d
function function_bc0ca08e83bd890( tank )
{
    bundle = killstreak_utility::function_f943c0602acdc2af( tank.tanktype );
    weaponentries = killstreak_utility::function_b5d94c2d60f51b9d( tank.tanktype );
    config = spawnstruct();
    config.weaponinfo = weaponentries[ 0 ].weaponname ?? "pac_sentry_turret_mp";
    config.burstmin = bundle.var_c76c192ff454508c;
    config.burstmax = bundle.var_c749272ff42e279e;
    config.pausemin = bundle.var_af3c7d85d7740450;
    config.pausemax = bundle.var_af197385d74da69a;
    config.lockstrength = bundle.var_af702617126e0f10;
    config.spinuptime = bundle.var_a48db9dae3008efe;
    config.overheattime = bundle.var_356b23049c8bb6ab;
    config.cooldowntime = bundle.var_92c4d72b2366efb2;
    return config;
}

// Namespace remotetank
// Params 1
// Checksum 0x5f57c4, Offset: 0xeea
// Size: 0x2b
function function_77f58ab9fe555946( tank )
{
    if ( !isdefined( tank ) )
    {
        return;
    }
    
    tank.pauseengine = 1;
    tank function_7defc80750ce3dc2();
}

// Namespace remotetank
// Params 1
// Checksum 0x7144e703, Offset: 0xf1d
// Size: 0x21
function function_af02905dc24acceb( tank )
{
    if ( !isdefined( tank ) )
    {
        return;
    }
    
    tank.pauseengine = 0;
}

// Namespace remotetank
// Params 1
// Checksum 0x2bcba50d, Offset: 0xf46
// Size: 0x18, Type: bool
function function_5cdfe27f3e8ee406( tank )
{
    return istrue( tank.pauseengine );
}

// Namespace remotetank
// Params 1
// Checksum 0x2c53cb7f, Offset: 0xf67
// Size: 0x21
function remote_tank_setactive( tank )
{
    tank.isactive = 1;
    tank vehicle_turnengineon();
}

// Namespace remotetank
// Params 1, eflags: 0x4
// Checksum 0x8b88c200, Offset: 0xf90
// Size: 0xbf
function private function_73ffe70ddf3170be( var_f518fe9aba9af002 )
{
    var_822ee5de03b7b5e = undefined;
    vehicletok = strtok( var_f518fe9aba9af002, "_" );
    
    foreach ( token in vehicletok )
    {
        if ( token == "mp" )
        {
            break;
        }
        
        if ( isdefined( var_822ee5de03b7b5e ) )
        {
            var_822ee5de03b7b5e = var_822ee5de03b7b5e + "_" + token;
            continue;
        }
        
        var_822ee5de03b7b5e = token;
    }
    
    return var_822ee5de03b7b5e;
}

