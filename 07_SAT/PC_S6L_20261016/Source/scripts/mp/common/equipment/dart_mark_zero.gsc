// scripts\mp\common\equipment\dart_mark_zero.gsc  (hash_02d08d9a1148b92d.gscc) (size: 26051 Bytes / 0x65c3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x65506a8e (1699768974)
// size ...... 26051 (0x65c3)
// includes .. 21  (offset: 0x6047)
// strings ... 73  (offset: 0x60ef)
// dev strs .. 14  (offset: 0x64ef)
// exports ... 62  (offset: 0x3e47)
// cseg ...... 0x661 + 0x37e6 (0x3e47)
// imports ... 202 (offset: 0x47f7)
// animtree1 . 0   (offset: 0x65b3)
// animtree2 . 1   (offset: 0x65b3)
#using script_16ea1b94f0f381b3;
#using scripts\common\active_env\utility;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\math;
#using scripts\common\shellshock_utility;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_tracking;
#using scripts\common\weapon;
#using scripts\mp\common\utility\equipment_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\damage;
#using scripts\mp\entityheadicons;
#using scripts\mp\equipment;
#using scripts\mp\outofbounds;
#using scripts\mp\telemetry_mp;
#using scripts\mp\weapons;

#namespace dart_mark_zero;

// Namespace dart_mark_zero
// Params 0, eflags: 0x1
// Checksum 0xae207aea, Offset: 0x67f
// Size: 0xa
function autoexec main()
{
    level dart_init();
}

// Namespace dart_mark_zero
// Params 0, eflags: 0x4
// Checksum 0xbf99926, Offset: 0x691
// Size: 0x125
function private dart_init()
{
    utility::flag_wait( "equipment_initialized" );
    equipment_mp::registercallback( "equip_dart_mark_zero", "onGive", &function_b697c9e8f281de3a );
    equipment_mp::registercallback( "equip_dart_mark_zero", "onTake", &function_f1122cb9171da0e0 );
    equipment_mp::registercallback( "equip_dart_mark_zero", "onDestroyedByTrophy", &function_19461580867e34f2 );
    weapons::registerusedcallback( "dart_mark_zero", &dart_used );
    weapons::function_2cd25260a11d5e40( #"dart_mark_zero", &onpullback );
    utility::registersharedfunc( #"dart_mark_zero", #"hack", &hack );
    utility::registersharedfunc( #"dart_mark_zero", #"hash_5af6280fe208d22d", &function_6ac9d9a6de774c78 );
    killstreak_shared::function_28d986de72ce85f8( "cruise_color_mp" );
    killstreak_shared::function_28d986de72ce85f8( "vision/killstreak_rcxd_jammed.vision" );
    val::group_register( "driving_dart_mark_zero", [ "weapon_switch", "autoreload", "reload", "shellshock", "fire", "backpack_inventory" ] );
    utility::add_fx( "dart_mark_zero_friendly_light", "vfx_sat_core_equip_dart_mark_zero_light_friendly" );
    equipmentinteractinit();
}

// Namespace dart_mark_zero
// Params 0
// Checksum 0xf413e8b6, Offset: 0x7be
// Size: 0x9b
function equipmentinteractinit()
{
    bundle = level.equipment.table[ "equip_dart_mark_zero" ].bundle;
    
    if ( !bundle.equipmentinteractions )
    {
        return;
    }
    
    utility::registersharedfunc( getxhash( "equip_dart_mark_zero" ), #"hash_4dc9e6a6a37c45b8", &function_26476c75e95a6825 );
    utility::registersharedfunc( getxhash( "equip_dart_mark_zero" ), #"hash_e67962dfd5c63cde", &function_a839f709a3317e71 );
    utility::registersharedfunc( getxhash( "equip_dart_mark_zero" ), #"interactdestroy", &function_e3e9b944bde1ba13 );
}

// Namespace dart_mark_zero
// Params 4
// Checksum 0xbf86b502, Offset: 0x861
// Size: 0x2e
function function_b697c9e8f281de3a( equipmentref, equipmentslot, variantid, attachments )
{
    thread function_adeb38a847419508();
}

// Namespace dart_mark_zero
// Params 2
// Checksum 0x29f109d7, Offset: 0x897
// Size: 0x32
function function_f1122cb9171da0e0( equipmentref, slot )
{
    self notify( #"dart_mark_zero_on_take" );
    function_1bb10c5c0524da9e();
    self.var_7588cd7b3ce2ce66 = undefined;
}

// Namespace dart_mark_zero
// Params 0, eflags: 0xc
// Checksum 0x8a5cc159, Offset: 0x8d1
// Size: 0x197
function private function_adeb38a847419508()
{
    self notify( #"hash_98e3f8a85ee2bc56" );
    self endon( #"hash_98e3f8a85ee2bc56" );
    self endon( #"dart_mark_zero_on_take" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    bundle = level.equipment.table[ "equip_dart_mark_zero" ].bundle;
    
    if ( !isdefined( self.var_7588cd7b3ce2ce66 ) )
    {
        self.var_7588cd7b3ce2ce66 = 0;
    }
    
    var_8321d76528b840a1 = self meleebuttonpressed( 1 );
    
    while ( true )
    {
        if ( self.var_6393c8b48079c059 )
        {
            self.var_6393c8b48079c059 = 0;
            function_1bb10c5c0524da9e();
            wait 1;
            self.var_7588cd7b3ce2ce66 = 0;
        }
        
        if ( self isvehicleactive() )
        {
            function_1bb10c5c0524da9e();
            self.var_7588cd7b3ce2ce66 = 0;
        }
        else if ( player::isreallyalive( self ) )
        {
            currentweapon = weapon::getgrenadeinpullback();
            
            if ( currentweapon.basename == bundle.useweapon )
            {
                if ( self meleebuttonpressed( 1 ) && !var_8321d76528b840a1 )
                {
                    self.var_7588cd7b3ce2ce66 = !self.var_7588cd7b3ce2ce66;
                    self playlocalsound( "eqp_sat_dart_mark_zero_switch_mode" );
                }
                
                if ( self.var_7588cd7b3ce2ce66 )
                {
                    function_de181017e819cb35( 0 );
                }
                else
                {
                    function_de181017e819cb35( 1 );
                }
            }
            else
            {
                function_1bb10c5c0524da9e();
                self.var_7588cd7b3ce2ce66 = 0;
            }
        }
        else
        {
            function_1bb10c5c0524da9e();
            self.var_7588cd7b3ce2ce66 = 0;
        }
        
        var_8321d76528b840a1 = self meleebuttonpressed( 1 );
        waitframe();
    }
}

// Namespace dart_mark_zero
// Params 1
// Checksum 0x947a4f21, Offset: 0xa70
// Size: 0x493
function dart_used( dart )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    dart endon( #"exploded" );
    killfxontag( utility::getfx( "dart_mark_zero_friendly_light" ), dart, "tag_fx" );
    self.var_6393c8b48079c059 = 1;
    ref = equipment_mp::function_fdc4a655fbde0dec( dart.weapon_name );
    tableinfo = weapon::getequipmenttableinfo( ref );
    dart.var_d995ff3a8a3cb9c = tableinfo.bundle;
    assert( isdefined( dart.var_d995ff3a8a3cb9c ), "<dev string:x24>" );
    dart.owner = self;
    dart setentityowner( self );
    dart setotherent( self );
    dart setnonstick( 1 );
    dart setnodeploy( 1 );
    dart.headiconid = entityheadicons::setheadicon_equipment( dart );
    dart setscriptablepartstate( #"breacher_setup", #"on", 0 );
    dart thread dart_watchplayerdeath();
    dart thread function_daed9275d9e1b964();
    dart thread function_37c1211d42c75ec0();
    dart thread dart_watchgameended();
    darthealth = dart.var_d995ff3a8a3cb9c.var_8188aa2b5ea2096a ?? 10;
    damagefeedback = "hitequip";
    dart.var_ce8cb07fc75576b1 = 1;
    dart setcandamage( 1 );
    dart thread damage::monitordamage( darthealth, damagefeedback, &function_e3e9b944bde1ba13 );
    namespace_9d8e359c3b1041e5::emp_debuff_register_sharedfunc( dart, &function_9ccf8f848600a053 );
    gunangle = self getgunangles();
    launchdirection = anglestoforward( gunangle );
    launch_offset = 15;
    self.restoreangles = undefined;
    dart.origin += launchdirection * launch_offset;
    dart.launchdirection = launchdirection;
    
    if ( self.var_7588cd7b3ce2ce66 && !isai( self ) )
    {
        dart.var_ec2a7a632e045ea6 = 1;
        self painvisionoff();
        shellshock_utility::_stopshellshock();
        var_2c50ebc26185557b = level.sharedfuncs[ #"damage_effects" ][ #"hash_7ff5e70e05a98fb0" ];
        
        if ( var_2c50ebc26185557b )
        {
            [[ var_2c50ebc26185557b ]]( 0.2 );
        }
        
        vehicle = dart_spawnvehicle( dart );
        
        if ( !vehicle )
        {
            fullscreenfxon( #"explosion" );
            thread function_2d9e422485c28b56( 0.35 );
            thread function_5353ca5972c46747();
            thread function_761c945c08e6de5d( dart );
        }
        else
        {
            vehicle.var_92f27893e3e47b21 = 1;
            dart.var_358dc66a42bbb556 = vehicle;
            dart linkto( vehicle, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
            dart.var_14f08f0fbff8e052 = [ vehicle ];
            vehicle_init( vehicle );
        }
    }
    else
    {
        if ( dart.var_d995ff3a8a3cb9c.var_c7709714d768097c && dart.weapon_object hasattachmenthash( dart.var_d995ff3a8a3cb9c.var_c7709714d768097c ) )
        {
            dartspeed = dart.var_d995ff3a8a3cb9c.var_facceaeda6db76a7;
        }
        
        if ( !isdefined( dartspeed ) )
        {
            dartspeed = dart.var_d995ff3a8a3cb9c.var_f90b4fdff0ac1e27 ?? 500;
        }
        
        dart.speed = dartspeed;
        dart thread function_f12be320efcfb2ed();
        dart thread function_4dcb70f8062232e4( launchdirection, dartspeed );
        lifetime = dart.var_d995ff3a8a3cb9c.var_9014033e64a2ace ?? 6;
        dart thread function_457c2f12b540e875( lifetime );
    }
    
    if ( !isdefined( level.var_80c6e313f9c36e80 ) )
    {
        level.var_80c6e313f9c36e80 = [];
    }
    
    level.var_80c6e313f9c36e80[ level.var_80c6e313f9c36e80.size ] = dart;
    dart thread weapons::watchkillbordercallback( &function_4c836fca22cb798a );
    dart function_9bd258cf8a1bb961();
    self.var_7588cd7b3ce2ce66 = 0;
    
    if ( level.var_36218e71baa7e689 )
    {
        level.var_89fe7f9fa2bc945d[ level.var_89fe7f9fa2bc945d.size ] = dart;
    }
    
    if ( level.var_36218e71baa7e689 )
    {
        dart.var_c5ccf9dff3b5e393 = &function_9ccf8f848600a053;
    }
    
    weapons::onequipmentplanted( dart, "equip_dart_mark_zero", &function_e3e9b944bde1ba13, undefined, !dart.var_d995ff3a8a3cb9c.var_24e0e7e5ebb5f557 );
}

// Namespace dart_mark_zero
// Params 1
// Checksum 0x3ea934fd, Offset: 0xf0b
// Size: 0xa1
function function_26476c75e95a6825( data )
{
    vehicle = self.var_358dc66a42bbb556;
    
    if ( vehicle )
    {
        function_b2c516329ac97bf7( vehicle );
        return;
    }
    
    slowedspeed = self.speed * ( data.equipmentinteraction.var_26de7042038f0d51 ?? 0.5 );
    
    if ( self getscriptablehaspart( #"jammed" ) )
    {
        self setscriptablepartstate( #"jammed", #"on", 0 );
    }
    
    thread function_4dcb70f8062232e4( self.launchdirection, slowedspeed, 1 );
}

// Namespace dart_mark_zero
// Params 1
// Checksum 0x562440f7, Offset: 0xfb4
// Size: 0x77
function function_a839f709a3317e71( data )
{
    vehicle = self.var_358dc66a42bbb556;
    
    if ( vehicle )
    {
        function_3496a96dca04b3ff( vehicle );
        return;
    }
    
    if ( self getscriptablehaspart( #"jammed" ) )
    {
        self setscriptablepartstate( #"jammed", #"off", 0 );
    }
    
    thread function_4dcb70f8062232e4( self.launchdirection, self.speed, 1 );
}

// Namespace dart_mark_zero
// Params 0
// Checksum 0x987e733e, Offset: 0x1033
// Size: 0xc
function function_4c836fca22cb798a()
{
    thread function_e3e9b944bde1ba13( undefined, 1 );
}

// Namespace dart_mark_zero
// Params 0
// Checksum 0x5e08ddff, Offset: 0x1047
// Size: 0x65
function function_9bd258cf8a1bb961()
{
    if ( utility::issharedfuncdefined( #"spawn", #"addSpawnInfluencer" ) )
    {
        self.dangerzoneid = [[ utility::getsharedfunc( #"spawn", #"addSpawnInfluencer" ) ]]( #"equipment_small", self.origin, self.team, self.owner, self );
    }
}

// Namespace dart_mark_zero
// Params 0
// Checksum 0x2e7acdf2, Offset: 0x10b4
// Size: 0x9a
function function_925873cc428e541f()
{
    if ( utility::issharedfuncdefined( #"spawn", #"isspawninfluenceractive" ) && utility::issharedfuncdefined( #"spawn", #"removeSpawnInfluencer" ) )
    {
        if ( self.dangerzoneid && [[ utility::getsharedfunc( #"spawn", #"isspawninfluenceractive" ) ]]( self.dangerzoneid ) )
        {
            [[ utility::getsharedfunc( #"spawn", #"removeSpawnInfluencer" ) ]]( self.dangerzoneid );
            self.dangerzoneid = undefined;
        }
    }
}

// Namespace dart_mark_zero
// Params 0, eflags: 0x4
// Checksum 0xf367fa5a, Offset: 0x1156
// Size: 0x100
function private function_f12be320efcfb2ed()
{
    self endon( #"death" );
    self endon( #"exploded" );
    endangles = self.angles;
    xtilt = self.angles[ 0 ] + -20;
    startangle = ( xtilt, self.angles[ 1 ], self.angles[ 2 ] );
    self.angles = anglelerpquat( self.angles, startangle, 1 );
    lerpfraction = 0;
    starttime = gettime();
    lerpduration = 2500;
    
    while ( true )
    {
        timepassed = gettime() - starttime;
        lerpfraction = timepassed / lerpduration;
        
        if ( lerpfraction < 1 )
        {
            self.angles = math::lerp( startangle, endangles, lerpfraction );
        }
        else
        {
            wait 0.2;
            function_8e2f34e3505a0faa();
        }
        
        waitframe();
    }
}

// Namespace dart_mark_zero
// Params 0, eflags: 0xc
// Checksum 0x5be688d0, Offset: 0x125e
// Size: 0x108
function private function_8e2f34e3505a0faa()
{
    self notify( #"hash_9a119d4072a91782" );
    self endon( #"hash_9a119d4072a91782" );
    self endon( #"death" );
    self endon( #"exploded" );
    startangle = self.angles;
    xtilt_flight = self.angles[ 0 ] + 20;
    endangles = ( xtilt_flight, self.angles[ 1 ], self.angles[ 2 ] );
    self.angles = anglelerpquat( self.angles, endangles, 1 );
    lerpfraction = 0;
    starttime = gettime();
    lerpduration = 2500;
    
    while ( true )
    {
        timepassed = gettime() - starttime;
        lerpfraction = timepassed / lerpduration;
        
        if ( lerpfraction < 1 )
        {
            self.angles = math::lerp( startangle, endangles, lerpfraction );
        }
        
        waitframe();
    }
}

// Namespace dart_mark_zero
// Params 3, eflags: 0xc
// Checksum 0x7e529c5a, Offset: 0x136e
// Size: 0x49f
function private function_4dcb70f8062232e4( direction, speed, var_6dfc9fcf4bc06816 )
{
    self notify( #"hash_6c59a525b32dd78a" );
    self endon( #"hash_6c59a525b32dd78a" );
    self endon( #"death" );
    self endon( #"exploded" );
    level endon( #"game_ended" );
    self.owner endon( #"disconnect" );
    var_db9e33a8831c62c4 = var_6dfc9fcf4bc06816 ? 0 : 0.5;
    lifetime = self.var_d995ff3a8a3cb9c.var_9014033e64a2ace ?? 6;
    vectordistance = speed * lifetime;
    lerpduration = lifetime * 1000;
    startpos = self.origin;
    previouspos = self.origin;
    targetpos = startpos + direction * vectordistance + self.owner getvelocity() * var_db9e33a8831c62c4;
    direction = vectornormalize( targetpos - startpos );
    starttime = gettime();
    raycaststart = self.origin;
    raycastdistance = 20;
    raycastend = raycaststart + direction * raycastdistance;
    collisioncontents = trace::create_contents( 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 0, 1 );
    var_2da10fd09e300ae8 = [ self, self.owner ];
    var_7a88b212b65edfea = 200;
    
    while ( true )
    {
        currtime = gettime();
        timepassed = currtime - starttime;
        lerpfraction = timepassed / lerpduration;
        traceresults = trace::ray_trace_get_all_results( previouspos, raycastend, var_2da10fd09e300ae8, collisioncontents, 1, 1, self.owner.team );
        
        foreach ( traceresult in traceresults )
        {
            if ( !traceresult[ "hittype" ] || traceresult[ "hittype" ] == "hittype_none" )
            {
                continue;
            }
            else if ( traceresult[ "hittype" ] == "hittype_entity" )
            {
                ent = traceresult[ "entity" ];
                
                if ( ent.var_aa82c7f64e626133 )
                {
                    continue;
                }
                
                if ( isplayer( ent ) || isai( ent ) )
                {
                    if ( level.teambased && ent.team === self.owner.team )
                    {
                        continue;
                    }
                }
            }
            
            if ( traceresult[ "surfacetype" ] == "surftype_glass_pane" )
            {
                if ( !self.var_fd48c3196a686869 || ( currtime - self.var_fd48c3196a686869 ) * 0.001 > 0.1 )
                {
                    glassradiusdamage( self.origin, 100, 1000, 1000 );
                    self.var_fd48c3196a686869 = currtime;
                    continue;
                }
                
                self.var_fd48c3196a686869 = currtime;
            }
            
            thread function_e3e9b944bde1ba13();
            break;
        }
        
        if ( self.isteleporting )
        {
            newpos = self.teleportpos;
            teleportdelta = self.teleportpos - previouspos;
            previouspos = self.teleportpos;
            startpos += teleportdelta;
            startpos = utility::function_6b6c127afa12d17( self.teleportpos, startpos, self.teleportrot );
            targetpos += teleportdelta;
            targetpos = utility::function_6b6c127afa12d17( self.teleportpos, targetpos, self.teleportrot );
            direction = utility::function_6b6c127afa12d17( ( 0, 0, 0 ), direction, self.teleportrot );
            self.angles = self.teleportrot;
            self.isteleporting = 0;
        }
        else
        {
            newpos = math::lerp( startpos, targetpos, lerpfraction );
            previouspos = self.origin;
        }
        
        self.origin = newpos;
        
        if ( utility::ispointinwater( self.origin ) && currtime - self.birthtime > var_7a88b212b65edfea )
        {
            thread function_e3e9b944bde1ba13( undefined, 1 );
        }
        
        raycastend = self.origin + direction * raycastdistance;
        waitframe();
    }
}

// Namespace dart_mark_zero
// Params 2
// Checksum 0x15b0aa2f, Offset: 0x1815
// Size: 0x36
function function_6ac9d9a6de774c78( teleportpos, teleportrot )
{
    self.isteleporting = 1;
    self.teleportpos = teleportpos;
    self.teleportrot = teleportrot;
}

// Namespace dart_mark_zero
// Params 1, eflags: 0x4
// Checksum 0xe4ec0f60, Offset: 0x1853
// Size: 0x65
function private function_457c2f12b540e875( time )
{
    self endon( #"death" );
    self endon( #"exploded" );
    self.owner endon( #"disconnect" );
    wait time;
    
    if ( self.var_d995ff3a8a3cb9c.var_dbf04d9ef02a441b )
    {
        thread function_e3e9b944bde1ba13();
        return;
    }
    
    thread function_e3e9b944bde1ba13( undefined, 1 );
}

// Namespace dart_mark_zero
// Params 1
// Checksum 0x6bddd62, Offset: 0x18c0
// Size: 0x2f7
function dart_spawnvehicle( dart )
{
    if ( function_3fa7aee4ef2f6001( dart ) )
    {
        return;
    }
    
    if ( dart.var_d995ff3a8a3cb9c.var_e36b84555e7df1d3 && dart.weapon_object hasattachmenthash( dart.var_d995ff3a8a3cb9c.var_e36b84555e7df1d3 ) )
    {
        vehicleasset = dart.bundle.var_9874f7e6d815734d ?? "veh_sat_dart_mark_zero_controlled";
    }
    else
    {
        vehicleasset = "veh_sat_dart_mark_zero_controlled";
    }
    
    var_77ff08dd90ccd98c = 1;
    
    if ( var_77ff08dd90ccd98c )
    {
        vehicleasset = "veh_sat_dart_mark_zero_controlled_deprecated";
    }
    
    bundle = level.equipment.table[ "equip_dart_mark_zero" ].bundle;
    spawndata = {};
    spawndata.origin = dart.origin;
    spawndata.angles = dart.angles;
    
    if ( var_77ff08dd90ccd98c )
    {
        spawndata.modelname = "tag_origin_rigid_dart_mark_zero";
    }
    
    spawndata.vehicletype = vehicleasset;
    spawndata.targetname = "rcplane";
    faildata = {};
    vehicle = vehicle_tracking::spawn_vehicle( spawndata, faildata );
    
    if ( !vehicle )
    {
        /#
            thread utility::error( "<dev string:x43>" );
        #/
        
        return;
    }
    
    vehicle.var_77ff08dd90ccd98c = var_77ff08dd90ccd98c;
    vehicle.angles = spawndata.angles;
    vehicle.team = self.team;
    vehicle.type = "remote";
    vehiclehealth = dart.var_d995ff3a8a3cb9c.var_8188aa2b5ea2096a ?? 10;
    vehicle.health = vehiclehealth;
    vehicle.maxhealth = vehiclehealth;
    vehicle.currenthealth = vehiclehealth;
    vehicle.owner = self;
    vehicle setentityowner( self );
    vehicle setotherent( self );
    vehicle setnonstick( 1 );
    vehicle setnodeploy( 1 );
    vehicle.lifetime = dart.var_d995ff3a8a3cb9c.var_4e52a854495ab91 ?? 6;
    vehicle.weapon_name = bundle.useweapon;
    vehicle.weaponobj = dart.weapon_object;
    vehicle.owneralive = isalive( self );
    vehicle.spawnlocation = vehicle.origin;
    vehicle.vehiclename = vehicleasset;
    vehicle.controlleddart = dart;
    vehicle setvehicleteam( vehicle.team );
    vehicle_tracking::register_instance( vehicle );
    vehicle setcandamage( 0 );
    return vehicle;
}

// Namespace dart_mark_zero
// Params 1
// Checksum 0xcb975fb2, Offset: 0x1bc0
// Size: 0x277, Type: bool
function function_3fa7aee4ef2f6001( dart )
{
    tracestartpos = dart.origin;
    tracedistance = 50;
    traceradius = 3;
    traceendpos = tracestartpos + anglestoforward( self getgunangles() ) * tracedistance;
    tracecontent = trace::create_contents( 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 1, 0 );
    ignorelist = [ self, dart ];
    
    if ( level.teambased && self.team )
    {
        allies = getplayersinradius( tracestartpos, tracedistance, undefined, 0, self, self.team );
        
        if ( allies )
        {
            ignorelist = arraycombine( ignorelist, allies );
        }
    }
    
    traceback = trace::sphere_trace( tracestartpos, traceendpos, traceradius, ignorelist, tracecontent, 1 );
    
    if ( traceback[ "hittype" ] != "hittype_none" )
    {
        /#
            debugtextcolor = ( 0, 1, 0 );
            debugtextscale = 2;
            debugdrawframeduration = 600;
            debugposx = 500;
            debugposy = 1000;
            var_55c913ff3ae8f46a = 30;
            printtoscreen2d( debugposx, debugposy, "<dev string:x95>" + traceback[ "<dev string:xb6>" ], debugtextcolor, debugtextscale, debugdrawframeduration );
            
            if ( traceback[ "<dev string:xbe>" ] )
            {
                printtoscreen2d( debugposx, debugposy + var_55c913ff3ae8f46a * 2, "<dev string:xc5>" + ( traceback[ "<dev string:xbe>" ].classname ?? "<dev string:xd1>" ), debugtextcolor, debugtextscale, debugdrawframeduration );
                printtoscreen2d( debugposx, debugposy + var_55c913ff3ae8f46a * 3, "<dev string:xd9>" + ( traceback[ "<dev string:xbe>" ].model ?? "<dev string:xd1>" ), debugtextcolor, debugtextscale, debugdrawframeduration );
                printtoscreen2d( debugposx, debugposy + var_55c913ff3ae8f46a * 4, "<dev string:xe1>" + ( traceback[ "<dev string:xbe>" ].owner.guid ?? "<dev string:xd1>" ), debugtextcolor, debugtextscale, debugdrawframeduration );
                printtoscreen2d( debugposx, debugposy + var_55c913ff3ae8f46a * 5, "<dev string:xee>" + ( traceback[ "<dev string:xbe>" ].owner.team ?? "<dev string:xd1>" ), debugtextcolor, debugtextscale, debugdrawframeduration );
            }
        #/
        
        if ( traceback[ "surfacetype" ] == "surftype_water" )
        {
            dart.var_93198476367910e5 = 1;
            return false;
        }
        
        return true;
    }
    
    return false;
}

// Namespace dart_mark_zero
// Params 1
// Checksum 0x14206c33, Offset: 0x1e40
// Size: 0x35a
function vehicle_init( vehicle )
{
    thread vehicle_ownerdeploytablet( vehicle );
    self.restoreangles = self.angles;
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"flare_system" ][ #"defender_init" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        vehicle [[ var_32dbca3143d9c4a5 ]]( 0, 0, 0 );
    }
    
    val::group_set( "driving_dart_mark_zero", 0 );
    player::setusingremote( "equip_dart_mark_zero" );
    telemetry_mp::function_80a95f340a7c8f67( self, self, vehicle.weaponobj, vehicle getentitynumber() );
    self notifyonplayercommand( "dart_mark_zero_detonate", "+attack" );
    
    if ( vehicle.var_77ff08dd90ccd98c )
    {
        self cameraunlink();
        self cameralinkto( vehicle, "tag_player", 1 );
    }
    
    self usevehicle( vehicle, 0 );
    vehicle.var_670c0bc02418cdc3 = &function_9b89be53c42407a;
    bundle = level.equipment.table[ "equip_dart_mark_zero" ].bundle;
    var_4dc75c50e4d42a2f = bundle.var_574f525cbf75a6d0;
    
    if ( vehicle.controlleddart )
    {
        alertfulllength = vehicle.lifetime / 2;
        var_c3193942aa25f78 = 0.25;
        var_28e5801bce7f4815 = 0.65;
        var_b84c3eae995cb030 = 0.001;
        var_ed6c729701a7f3ed = 0.05;
        endtime = gettime() + utility::function_4b74c15943231980( vehicle.lifetime );
        vehicle.controlleddart thread killstreak_shared::function_585fb909f40d8659( endtime, alertfulllength, var_c3193942aa25f78, var_28e5801bce7f4815, var_b84c3eae995cb030, var_ed6c729701a7f3ed );
    }
    
    if ( vehicle.controlleddart.var_d995ff3a8a3cb9c.var_e36b84555e7df1d3 && vehicle.controlleddart.weapon_object hasattachmenthash( vehicle.controlleddart.var_d995ff3a8a3cb9c.var_e36b84555e7df1d3 ) )
    {
        self setclientomnvar( "ui_killstreak_boost_button_enabled", 1 );
    }
    else
    {
        self setclientomnvar( "ui_killstreak_boost_button_enabled", 0 );
    }
    
    self setclientomnvar( o"ui_killstreak_controls", 29 );
    var_225c495bde49787b = 1;
    var_20fb10612153223 = 1;
    killstreak_shared::function_b3302c4317df36c6();
    var_3953c24c42c3e037 = 0;
    
    if ( utility::issharedfuncdefined( #"dart_mark_zero", #"disabletargetmarker" ) )
    {
        var_3953c24c42c3e037 = utility::callsharedfunc( #"dart_mark_zero", #"disabletargetmarker" );
    }
    
    if ( !var_3953c24c42c3e037 )
    {
        killstreak_shared::function_a402a9f43d6f7512( "killstreak_shared", undefined, undefined, var_225c495bde49787b, var_20fb10612153223 );
    }
    
    thread function_91c68919a40c6ec2( vehicle );
    thread function_4879bddac631d15f( vehicle );
    vehicle.ispiloted = 1;
    vehicle outofbounds::function_4cb3ccaabd7eedf9();
    namespace_9d8e359c3b1041e5::registerentforoobsharedfunc( vehicle, "killstreak" );
    utility::registersharedfunc( vehicle.vehiclename, #"interactswithoobtrigger", &function_44bcf50464a0df06 );
    utility::registersharedfunc( vehicle.vehiclename, #"hash_3365a912c11d2ba0", &function_2d26fbfda4f66efe );
    utility::callsharedfunc( #"jamming_system", #"hash_b99e77a93a09b9d5", vehicle, &function_b2c516329ac97bf7, &function_3496a96dca04b3ff );
}

// Namespace dart_mark_zero
// Params 1
// Checksum 0x1bd75aab, Offset: 0x21a2
// Size: 0x3a
function function_9b89be53c42407a( trigger )
{
    vehicle = self;
    dart = vehicle.controlleddart;
    dart thread function_e3e9b944bde1ba13( undefined, 1 );
}

// Namespace dart_mark_zero
// Params 0
// Checksum 0x2ea4ce02, Offset: 0x21e4
// Size: 0xe
function function_2d26fbfda4f66efe()
{
    self notify( #"expired" );
}

// Namespace dart_mark_zero
// Params 2
// Checksum 0x97c9d196, Offset: 0x21fa
// Size: 0x2d, Type: bool
function function_44bcf50464a0df06( trigger, vehicle )
{
    if ( trigger.targetname == "Drone_OutOfBounds" )
    {
        return true;
    }
    
    return false;
}

// Namespace dart_mark_zero
// Params 1
// Checksum 0xd289a974, Offset: 0x2230
// Size: 0x95
function function_91c68919a40c6ec2( vehicle )
{
    self endon( #"death_or_disconnect" );
    vehicle endon( #"exploded" );
    var_4565558cb4444c1e = [ "missile_turret", "sentry_gun", "rcxd", "tank_drone", "counter_uav", "uav", "chopper_door_gunner", "airdrop_escort", "hellstorm_missile", "airdrop" ];
    killstreak_shared::function_505d16f50dee75d2( var_4565558cb4444c1e );
}

#using_animtree( "script_model" );

// Namespace dart_mark_zero
// Params 1
// Checksum 0xc429aab0, Offset: 0x22cd
// Size: 0xf8
function vehicle_ownerdeploytablet( vehicle )
{
    self endon( #"death_or_disconnect" );
    vehicle endon( #"exploded" );
    bundle = level.equipment.table[ "equip_dart_mark_zero" ].bundle;
    
    if ( !bundle.var_e9c9dc9856cdb631 )
    {
        assertmsg( "<dev string:xfb>" );
        return;
    }
    
    tabletobj = makeweapon( bundle.var_e9c9dc9856cdb631 );
    deployanim = %vm_ks_tablet_tap_raise;
    self.var_f21f0a08550fe96d = tabletobj;
    self.var_ee17b99754dc6511 = self getcurrentweapon();
    inventory_utility::_giveweapon( tabletobj, 0, 0, 1 );
    self function_a00aa20bed47ee69( 1 );
    switchresult = inventory_utility::domonitoredweaponswitch( tabletobj, 1, 1 );
    self function_a00aa20bed47ee69( 0 );
    
    if ( !switchresult )
    {
        self.var_ee17b99754dc6511 = undefined;
    }
}

// Namespace dart_mark_zero
// Params 0
// Checksum 0xc1d7bfa5, Offset: 0x23cd
// Size: 0x90
function function_f60f078487804e09()
{
    if ( !self )
    {
        return;
    }
    
    if ( self.var_f21f0a08550fe96d )
    {
        self takeweapon( self.var_f21f0a08550fe96d );
        self.var_f21f0a08550fe96d = undefined;
    }
    
    if ( isalive( self ) && self.var_ee17b99754dc6511 && !player::isinlaststand( self ) )
    {
        if ( !self hasweapon( self.var_ee17b99754dc6511 ) )
        {
            self.var_ee17b99754dc6511 = self.primaryweaponobj;
        }
        
        thread inventory_utility::domonitoredweaponswitch( self.var_ee17b99754dc6511, 1, 1 );
        self.var_ee17b99754dc6511 = undefined;
    }
}

// Namespace dart_mark_zero
// Params 1
// Checksum 0x9e10175a, Offset: 0x2465
// Size: 0x110
function function_b2c516329ac97bf7( vehicle )
{
    if ( vehicle.isboosting )
    {
        vehicle.owner fullscreenfxoff( #"boost" );
    }
    
    vehicle.owner fullscreenfxon( #"jammed" );
    vehicle.controlleddart setscriptablepartstate( #"jammed", #"on", 0 );
    vehicle.var_8903b68424de5c4a = vehicle.veh_speed ?? vehicle.veh_topspeed;
    jammedspeed = vehicle.var_8903b68424de5c4a * ( vehicle.controlleddart.var_d995ff3a8a3cb9c.var_f7238baad0b21895 ?? 0.5 );
    
    if ( vehicle.var_77ff08dd90ccd98c )
    {
        vehicle rcplane_setminspeed( jammedspeed );
        vehicle rcplane_settopspeed( jammedspeed );
        vehicle rcplane_settopspeedboost( jammedspeed );
        return;
    }
    
    vehicle function_ccacc3fd2c146e8( 0 );
    vehicle vehicle_settopspeedforward( jammedspeed );
}

// Namespace dart_mark_zero
// Params 1
// Checksum 0x298e0943, Offset: 0x257d
// Size: 0xd5
function function_3496a96dca04b3ff( vehicle )
{
    vehicle.owner fullscreenfxoff( #"jammed" );
    
    if ( vehicle.isboosting )
    {
        vehicle.owner fullscreenfxon( #"boost" );
    }
    
    vehicle.controlleddart setscriptablepartstate( #"jammed", #"off", 0 );
    
    if ( vehicle.var_77ff08dd90ccd98c )
    {
        vehicle rcplane_setminspeed( vehicle.var_8903b68424de5c4a );
        vehicle rcplane_settopspeed( vehicle.var_8903b68424de5c4a );
        vehicle rcplane_settopspeedboost( vehicle.var_8903b68424de5c4a );
        return;
    }
    
    vehicle function_ccacc3fd2c146e8( 1 );
    vehicle vehicle_settopspeedforward( vehicle.var_8903b68424de5c4a );
}

// Namespace dart_mark_zero
// Params 1
// Checksum 0x7c58fd9d, Offset: 0x265a
// Size: 0x191
function function_4879bddac631d15f( vehicle )
{
    level endon( #"game_ended" );
    vehicle vehphys_enablecollisioncallback( 1 );
    vehicle thread vehicle_watchlifetime();
    vehicle thread function_d8fc88e61f0da9c7();
    vehicle thread function_22b86bd8784f4dc1();
    vehicle thread function_32ac72f0283d4efa();
    childthread function_ad0a628cd7611060( vehicle );
    
    if ( vehicle.controlleddart.var_d995ff3a8a3cb9c.var_e36b84555e7df1d3 && vehicle.controlleddart.weapon_object hasattachmenthash( vehicle.controlleddart.var_d995ff3a8a3cb9c.var_e36b84555e7df1d3 ) )
    {
        childthread function_9f7508b65c75f8a1( vehicle );
    }
    
    explodeinfo = vehicle function_69a5817d0c499fb1( "water_collision", "explode_collision", "expired", "detonate", "shot_down", "exceed_range" );
    
    if ( vehicle )
    {
        function_cec36baec949341a( vehicle );
        
        if ( vehicle.controlleddart )
        {
            if ( explodeinfo.msg == "expired" && !vehicle.controlleddart.var_d995ff3a8a3cb9c.var_dbf04d9ef02a441b )
            {
                vehicle.controlleddart thread function_e3e9b944bde1ba13( undefined, 1 );
                return;
            }
            
            if ( explodeinfo.msg == "water_collision" )
            {
                vehicle.controlleddart thread function_e3e9b944bde1ba13( undefined, 1 );
                return;
            }
            
            vehicle.controlleddart thread function_e3e9b944bde1ba13();
        }
    }
}

// Namespace dart_mark_zero
// Params 2
// Checksum 0x3d34769a, Offset: 0x27f3
// Size: 0x7d
function function_5af432e99cf487eb( msg, ent )
{
    ent endon( #"die" );
    self waittill( msg, param1, param2, param3, param4, param5, param6 );
    ent notify( #"returned", msg, param1, param2, param3, param4, param5, param6 );
}

// Namespace dart_mark_zero
// Params 6
// Checksum 0xd0945479, Offset: 0x2878
// Size: 0x19f
function function_69a5817d0c499fb1( var_19eee95063be9ec9, var_19eee65063be9830, var_19eee75063be9a63, var_19eeec5063bea562, var_19eeed5063bea795, var_19eeea5063bea0fc )
{
    self endon( #"exploded" );
    ent = {};
    
    if ( var_19eee95063be9ec9 )
    {
        thread function_5af432e99cf487eb( var_19eee95063be9ec9, ent );
    }
    
    if ( var_19eee65063be9830 )
    {
        thread function_5af432e99cf487eb( var_19eee65063be9830, ent );
    }
    
    if ( var_19eee75063be9a63 )
    {
        thread function_5af432e99cf487eb( var_19eee75063be9a63, ent );
    }
    
    if ( var_19eeec5063bea562 )
    {
        thread function_5af432e99cf487eb( var_19eeec5063bea562, ent );
    }
    
    if ( var_19eeed5063bea795 )
    {
        thread function_5af432e99cf487eb( var_19eeed5063bea795, ent );
    }
    
    if ( var_19eeea5063bea0fc )
    {
        thread function_5af432e99cf487eb( var_19eeea5063bea0fc, ent );
    }
    
    ent waittill( #"returned", msg, param1, param2, param3, param4, param5, param6, param7, param8 );
    explodeinfo = {};
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

// Namespace dart_mark_zero
// Params 0
// Checksum 0xdcf9d553, Offset: 0x2a20
// Size: 0x7a
function function_d8fc88e61f0da9c7()
{
    self endon( #"exploded" );
    hitwater = 0;
    
    if ( self.controlleddart.var_93198476367910e5 )
    {
        waitframe();
        self notify( #"water_collision" );
        return;
    }
    
    while ( true )
    {
        vehicleloc = self getorigin();
        
        if ( vehicleloc )
        {
            hitwater = utility::ispointinwater( vehicleloc );
        }
        
        if ( hitwater )
        {
            self notify( #"water_collision" );
            break;
        }
        
        waitframe();
    }
}

// Namespace dart_mark_zero
// Params 0
// Checksum 0x58ed9e57, Offset: 0x2aa2
// Size: 0x1a0
function function_22b86bd8784f4dc1()
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
                else if ( self.isteleporting )
                {
                    waitframe();
                    continue;
                }
            }
        }
        
        self notify( #"explode_collision", body0, body1, flag0, flag1, position, normal, impulse, ent );
        waitframe();
    }
}

// Namespace dart_mark_zero
// Params 0
// Checksum 0x7a5126ab, Offset: 0x2c4a
// Size: 0x120
function function_32ac72f0283d4efa()
{
    self endon( #"exploded" );
    radius = 96;
    collisioncontents = trace::create_contents( 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 0, 1 );
    var_2da10fd09e300ae8 = [ self, self.owner, self.controlleddart ];
    
    while ( true )
    {
        nearestdoor = function_6cf720856f2ecd74( self.origin, radius );
        
        if ( nearestdoor && nearestdoor isscriptableinstance() )
        {
            startpos = self.origin;
            endpos = self.origin + vectornormalize( anglestoforward( self.angles ) ) * radius;
            traceresult = trace::ray_trace( startpos, endpos, var_2da10fd09e300ae8, collisioncontents );
            
            if ( traceresult[ "hittype" ] && traceresult[ "hittype" ] != "hittype_none" )
            {
                self notify( #"explode_collision" );
                return;
            }
            else
            {
                wait 0.1;
            }
        }
        
        waitframe();
    }
}

// Namespace dart_mark_zero
// Params 0
// Checksum 0xe9bcb9ab, Offset: 0x2d72
// Size: 0x24
function vehicle_teleporttimer()
{
    self endon( #"exploded" );
    self.isteleporting = 1;
    waitframe();
    self.isteleporting = 0;
}

// Namespace dart_mark_zero
// Params 1
// Checksum 0x174cc85f, Offset: 0x2d9e
// Size: 0x39
function function_ad0a628cd7611060( vehicle )
{
    vehicle endon( #"exploded" );
    wait 0.4;
    self waittill( #"dart_mark_zero_detonate" );
    vehicle notify( #"detonate" );
}

// Namespace dart_mark_zero
// Params 1
// Checksum 0xfa2dcc67, Offset: 0x2ddf
// Size: 0xdc
function function_9f7508b65c75f8a1( vehicle )
{
    vehicle endon( #"exploded" );
    self setclientomnvar( "ui_killstreak_boost_recharge_percentage", 1 );
    
    while ( self sprintbuttonpressed() )
    {
        waitframe();
    }
    
    while ( !self sprintbuttonpressed() )
    {
        waitframe();
    }
    
    vehicle thread function_6c33bbf5d6195fb3();
    
    if ( vehicle.var_77ff08dd90ccd98c )
    {
        vehicle function_33d2754103778ebf();
    }
    else
    {
        vehicle vehicle_settopspeedforward( 35 );
    }
    
    vehicle.isboosting = 1;
    
    if ( !vehicle.isjammed )
    {
        fullscreenfxon( #"boost" );
    }
    
    if ( vehicle.controlleddart )
    {
        vehicle.controlleddart setscriptablepartstate( #"boost", #"on", 0 );
    }
    
    if ( !utility::issp() )
    {
        self lerpfovbypreset( "valkyrie_rocket_zoom_in" );
    }
}

// Namespace dart_mark_zero
// Params 0
// Checksum 0xa7408668, Offset: 0x2ec3
// Size: 0xa3
function function_6c33bbf5d6195fb3()
{
    self endon( #"exploded" );
    percentage = 1;
    totaltimems = 500;
    starttime = gettime();
    
    while ( self.owner )
    {
        deltatime = gettime() - starttime;
        percentage = 1 - float( deltatime ) / totaltimems;
        
        if ( percentage < 0 )
        {
            self.owner setclientomnvar( "ui_killstreak_boost_recharge_percentage", 0 );
            return;
        }
        
        self.owner setclientomnvar( "ui_killstreak_boost_recharge_percentage", percentage );
        waitframe();
    }
}

// Namespace dart_mark_zero
// Params 1
// Checksum 0xab97e53e, Offset: 0x2f6e
// Size: 0x2e
function function_94a1cab72c7aa78f( delayduration )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    wait delayduration;
    namespace_9d8e359c3b1041e5::clearusingremotesharedfunc();
}

// Namespace dart_mark_zero
// Params 0
// Checksum 0x8b4e34fb, Offset: 0x2fa4
// Size: 0xb1
function vehicle_watchlifetime()
{
    self endon( #"exploded" );
    self.currlifetime = 0;
    player = self.owner;
    self.lifetimeendtime = self.lifetime * 1000 + gettime();
    
    while ( self.currlifetime < self.lifetime )
    {
        self.currlifetime += level.framedurationseconds;
        
        if ( player )
        {
            player setclientomnvar( "ui_killstreak_lifetime", 1 - self.currlifetime / self.lifetime );
        }
        
        waitframe();
    }
    
    self notify( #"expired" );
}

// Namespace dart_mark_zero
// Params 2
// Checksum 0x5dfb2da0, Offset: 0x305d
// Size: 0x46c
function function_e3e9b944bde1ba13( damageinfo, var_fbbc049604f06150 )
{
    if ( !self || self.exploding )
    {
        return;
    }
    
    self.exploding = 1;
    self notify( #"exploded" );
    bundle = level.equipment.table[ "equip_dart_mark_zero" ].bundle;
    
    if ( damageinfo )
    {
        if ( !isdefined( var_fbbc049604f06150 ) )
        {
            var_fbbc049604f06150 = 1;
        }
        
        attacker = damageinfo.attacker;
        
        if ( !attacker || attacker && !isplayer( attacker ) )
        {
            if ( attacker.owner && isplayer( attacker.owner ) )
            {
                attacker = attacker.owner;
            }
        }
        
        if ( player_utility::playersareenemies( self.owner, attacker ) )
        {
            attacker equipment_mp::function_ada7da3083a6c593( self, damageinfo.objweapon );
        }
    }
    
    if ( utility::ispointinwater( self.origin ) )
    {
        var_fbbc049604f06150 = 1;
    }
    
    if ( !var_fbbc049604f06150 )
    {
        self setscriptablepartstate( #"explode", #"on", 0 );
    }
    else
    {
        self setscriptablepartstate( #"explode", #"on_nodamage", 0 );
    }
    
    function_925873cc428e541f();
    
    if ( self.var_ec2a7a632e045ea6 && self.var_358dc66a42bbb556 )
    {
        if ( self.owner )
        {
            self.owner function_cec36baec949341a( self.var_358dc66a42bbb556 );
        }
        
        self.var_358dc66a42bbb556 thread vehicle_cleanup();
        self.var_358dc66a42bbb556 = undefined;
    }
    
    if ( !var_fbbc049604f06150 )
    {
        if ( self.var_d995ff3a8a3cb9c.var_c7709714d768097c && self.weapon_object hasattachmenthash( self.var_d995ff3a8a3cb9c.var_c7709714d768097c ) )
        {
            innerrange = self.var_d995ff3a8a3cb9c.var_433eefba41ce0630;
            innerdmg = self.var_d995ff3a8a3cb9c.var_4ca6380025a3705;
            midrange = self.var_d995ff3a8a3cb9c.var_6e492af5742dca8e;
            middmg = self.var_d995ff3a8a3cb9c.var_f15cb1bd409cf663;
            outerrange = self.var_d995ff3a8a3cb9c.var_36a5d83bcdbc835;
            outerdmg = self.var_d995ff3a8a3cb9c.var_2e20b2b79e9fb93c;
        }
        
        if ( !isdefined( innerrange ) )
        {
            innerrange = self.var_d995ff3a8a3cb9c.var_284506057d8b61b0 ?? 60;
        }
        
        if ( !isdefined( innerdmg ) )
        {
            innerdmg = self.var_d995ff3a8a3cb9c.var_59c7b31e44ed2685 ?? 140;
        }
        
        if ( !isdefined( midrange ) )
        {
            midrange = self.var_d995ff3a8a3cb9c.var_c3467a93b6c0ba0e ?? 120;
        }
        
        if ( !isdefined( middmg ) )
        {
            middmg = self.var_d995ff3a8a3cb9c.var_cc4834c3860359e3 ?? 100;
        }
        
        if ( !isdefined( outerrange ) )
        {
            outerrange = self.var_d995ff3a8a3cb9c.var_e87073cef89923b5 ?? 180;
        }
        
        if ( !isdefined( outerdmg ) )
        {
            outerdmg = self.var_d995ff3a8a3cb9c.var_831e0255e132a8bc ?? 70;
        }
        
        meansofdeath = toupper( self.var_d995ff3a8a3cb9c.var_132036d3279aba56 ?? "MOD_EXPLOSIVE" );
        explosionattacker = damageinfo.attacker ?? self.owner;
        
        if ( !explosionattacker )
        {
            explosionattacker = undefined;
        }
        
        self radiusdamagestepped( self.origin, innerrange, innerdmg, midrange, middmg, outerrange, outerdmg, explosionattacker, meansofdeath, bundle.useweapon );
        physicsscale = 1;
        physicsexplosionsphere( self.origin, outerrange, innerrange, physicsscale );
    }
    
    wait 0.2;
    
    if ( self )
    {
        self delete();
    }
    
    if ( self.owner && isalive( self.owner ) && self.owner.restoreangles )
    {
        self.owner setplayerangles( ( self.owner.restoreangles[ 0 ], self.owner.restoreangles[ 1 ], 0 ) );
    }
}

// Namespace dart_mark_zero
// Params 0
// Checksum 0xd9fcbdef, Offset: 0x34d1
// Size: 0xc
function function_19461580867e34f2()
{
    thread function_e3e9b944bde1ba13( undefined, 1 );
}

// Namespace dart_mark_zero
// Params 1
// Checksum 0xcb78d79e, Offset: 0x34e5
// Size: 0x17
function function_9ccf8f848600a053( empstruct )
{
    thread function_e3e9b944bde1ba13( empstruct, 1 );
}

// Namespace dart_mark_zero
// Params 0
// Checksum 0xd0448ea0, Offset: 0x3504
// Size: 0x5c
function vehicle_cleanup()
{
    if ( self.owner )
    {
        self.owner function_47457b9ec007482e( "ui_veh_warning", 2, 1, 0 );
    }
    
    utility::callsharedfunc( #"jamming_system", #"hash_216d35a250cd860", self );
    self notify( #"exploded" );
    vehicle_tracking::deregister_instance( self );
    vehicle_tracking::delete_vehicle( self );
}

// Namespace dart_mark_zero
// Params 1
// Checksum 0xaad8676a, Offset: 0x3568
// Size: 0x165
function function_cec36baec949341a( vehicle )
{
    if ( !vehicle )
    {
        return;
    }
    
    if ( !vehicle.var_8b3c828f5635c6b8 )
    {
        vehicle.var_8b3c828f5635c6b8 = 1;
    }
    else
    {
        return;
    }
    
    thread telemetry_mp::function_e097bffa2fd8f2a0( self, vehicle.weaponobj, vehicle getentitynumber(), 1 );
    
    if ( vehicle.ispiloted )
    {
        namespace_9d8e359c3b1041e5::clearoobsharedfunc( vehicle, 1 );
    }
    
    function_fe2123dba85371ec( self );
    thread function_f60f078487804e09();
    
    if ( isalive( self ) && vehicle.owneralive )
    {
        fullscreenfxon( #"explosion" );
        thread function_2d9e422485c28b56( 0.35 );
        self playlocalsound( "ks_exp_screen_static" );
        thread function_94a1cab72c7aa78f( 0.5 );
    }
    else
    {
        thread function_94a1cab72c7aa78f( 0 );
        thread function_2d9e422485c28b56( 0.5 );
    }
    
    thread function_5353ca5972c46747();
    function_2c0784a62f89f89b();
    
    if ( vehicle.var_77ff08dd90ccd98c )
    {
        self cameraunlink();
    }
    
    if ( !utility::issp() )
    {
        self lerpfovbypreset( "default" );
    }
    
    self painvisionon();
    self setclientomnvar( "ui_killstreak_controls", 0 );
    killstreak_shared::function_76bbbe12ce816ed2();
    killstreak_shared::function_b3302c4317df36c6();
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"flare_system" ][ #"defender_cleanup" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        vehicle [[ var_32dbca3143d9c4a5 ]]();
    }
}

// Namespace dart_mark_zero
// Params 0
// Checksum 0x658cba9, Offset: 0x36d5
// Size: 0x23
function function_2c0784a62f89f89b()
{
    waitframe();
    
    if ( isalive( self ) )
    {
        if ( self isvehicleactive() )
        {
            self leavevehicle( 0 );
        }
        
        level thread namespace_9d8e359c3b1041e5::restorekillstreakplayeranglessharedfunc( self );
    }
}

// Namespace dart_mark_zero
// Params 1
// Checksum 0x8e944a4, Offset: 0x3700
// Size: 0xa0
function function_761c945c08e6de5d( dart )
{
    if ( getdvarint( @"hash_9fb50877bf37a4ad", 0 ) )
    {
        bundle = level.equipment.table[ "equip_dart_mark_zero" ].bundle;
        meansofdeath = toupper( dart.var_d995ff3a8a3cb9c.var_132036d3279aba56 ?? "MOD_EXPLOSIVE" );
        self kill( dart.origin, self, dart, meansofdeath, bundle.useweapon );
    }
    
    dart thread function_e3e9b944bde1ba13();
}

// Namespace dart_mark_zero
// Params 0
// Checksum 0x35fd77ee, Offset: 0x37a8
// Size: 0x3f
function function_5353ca5972c46747()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( self.usingremote )
    {
        self waittill( #"stopped_using_remote" );
    }
    
    val::group_reset( "driving_dart_mark_zero" );
}

// Namespace dart_mark_zero
// Params 0, eflags: 0xc
// Checksum 0x76fa89db, Offset: 0x37ef
// Size: 0x9d
function private dart_watchplayerdeath()
{
    self notify( #"hash_d91ad11ebc9cca91" );
    self endon( #"hash_d91ad11ebc9cca91" );
    dart_watchfortimeoutdisownedendearly();
    var_63d3efab778fca39 = self.var_d995ff3a8a3cb9c.var_397791255c32ab9;
    
    if ( self.var_ec2a7a632e045ea6 && self.var_358dc66a42bbb556.owneralive )
    {
        self.var_358dc66a42bbb556.owneralive = 0;
        
        if ( var_63d3efab778fca39 )
        {
            self.owner function_cec36baec949341a( self.var_358dc66a42bbb556 );
            thread function_e3e9b944bde1ba13();
        }
    }
}

// Namespace dart_mark_zero
// Params 0, eflags: 0x4
// Checksum 0xd63f5400, Offset: 0x3894
// Size: 0x99
function private dart_watchfortimeoutdisownedendearly()
{
    self.owner endon( #"disconnect" );
    self.owner endon( #"joined_team" );
    self.owner endon( #"joined_spectators" );
    self.owner endon( #"last_stand_enter" );
    self.owner endon( #"team_kill_punish" );
    level endon( #"game_ended" );
    lifetime = self.var_d995ff3a8a3cb9c.var_4e52a854495ab91 ?? 6;
    wait lifetime;
}

// Namespace dart_mark_zero
// Params 0, eflags: 0x4
// Checksum 0x9b2407cf, Offset: 0x3935
// Size: 0x4d
function private function_daed9275d9e1b964()
{
    self.owner endon( #"disconnect" );
    self endon( #"exploded" );
    level endon( #"game_ended" );
    self.owner waittill( #"player_suicide_death" );
    thread function_e3e9b944bde1ba13( undefined, 1 );
}

// Namespace dart_mark_zero
// Params 0, eflags: 0xc
// Checksum 0xf95450e7, Offset: 0x398a
// Size: 0x42
function private function_37c1211d42c75ec0()
{
    self notify( #"hash_2acad6fb691edaf3" );
    self endon( #"hash_2acad6fb691edaf3" );
    self endon( #"exploded" );
    self.owner waittill( #"disconnect" );
    thread function_e3e9b944bde1ba13();
}

// Namespace dart_mark_zero
// Params 0, eflags: 0xc
// Checksum 0x1e147d0b, Offset: 0x39d4
// Size: 0x5a
function private dart_watchgameended()
{
    self notify( #"hash_436863695439b3ad" );
    self endon( #"hash_436863695439b3ad" );
    self endon( #"exploded" );
    self.owner endon( #"death", #"disconnect" );
    level waittill( #"game_ended" );
    thread function_e3e9b944bde1ba13( undefined, 1 );
}

// Namespace dart_mark_zero
// Params 1, eflags: 0x4
// Checksum 0xeddd155d, Offset: 0x3a36
// Size: 0x27
function private fullscreenfxon( fx_type )
{
    assert( isdefined( fx_type ), "<dev string:x133>" );
    function_935732eb06e0f22f( fx_type, 1 );
}

// Namespace dart_mark_zero
// Params 1, eflags: 0x4
// Checksum 0x956e6b55, Offset: 0x3a65
// Size: 0x26
function private fullscreenfxoff( fx_type )
{
    assert( isdefined( fx_type ), "<dev string:x16d>" );
    function_935732eb06e0f22f( fx_type, 0 );
}

// Namespace dart_mark_zero
// Params 1, eflags: 0x4
// Checksum 0xce926aa7, Offset: 0x3a93
// Size: 0x90
function private function_2d9e422485c28b56( delay_s )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( delay_s )
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
        fullscreenfxoff( #"jammed" );
    }
}

// Namespace dart_mark_zero
// Params 2, eflags: 0x4
// Checksum 0x4b7547b4, Offset: 0x3b2b
// Size: 0x1b2
function private function_935732eb06e0f22f( fx_type, ison )
{
    switch ( fx_type )
    {
        case #"hud":
            fullscreenfxparams = { #visionset:"cruise_color_mp", #postfxbundlename:"cer_mp_valkyrie_drive" };
            break;
        case #"boost":
            fullscreenfxparams = { #visionset:undefined, #postfxbundlename:"cer_mp_valkyrie_boost" };
            break;
        case #"explosion":
            fullscreenfxparams = { #visionset:"killstreak_static", #postfxbundlename:"cer_scorestreak_transition" };
            break;
        case #"med_signal":
            fullscreenfxparams = { #visionset:undefined, #postfxbundlename:"cer_mp_valkyrie_med_signal" };
            break;
        case #"low_signal":
            fullscreenfxparams = { #visionset:undefined, #postfxbundlename:"cer_mp_valkyrie_low_signal" };
            break;
        case #"jammed":
            fullscreenfxparams = { #visionset:"vision/killstreak_rcxd_jammed.vision", #postfxbundlename:"cer_mp_rcxd_drive_jammed" };
            break;
        default:
            assertmsg( "<dev string:x1a8>" );
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

// Namespace dart_mark_zero
// Params 2, eflags: 0x4
// Checksum 0x8685915f, Offset: 0x3ce5
// Size: 0x62
function private hack( hackeffect, attacker )
{
    if ( hackeffect.var_30e7de3d76d5a085 )
    {
        return;
    }
    
    self.owner thread equipment_utility::function_364a1a0e0c018518( self.equipmentref, #"destroyed_hacked" );
    attacker thread points::doscoreevent( #"hash_32dfbbfece96181f" );
    thread function_e3e9b944bde1ba13( undefined, 1 );
}

// Namespace dart_mark_zero
// Params 1, eflags: 0x4
// Checksum 0x15a4e86c, Offset: 0x3d4f
// Size: 0x80
function private function_de181017e819cb35( var_2ab131289fb7863e )
{
    if ( !isdefined( self.var_208e7f8b4e8599be ) )
    {
        self.var_208e7f8b4e8599be = 0;
    }
    
    if ( var_2ab131289fb7863e && self.var_208e7f8b4e8599be != 1 )
    {
        self.var_208e7f8b4e8599be = 1;
        self setclientomnvar( "ui_dart_mark_zero_operation_mode", 1 );
        return;
    }
    
    if ( !var_2ab131289fb7863e && self.var_208e7f8b4e8599be != 2 )
    {
        self.var_208e7f8b4e8599be = 2;
        self setclientomnvar( "ui_dart_mark_zero_operation_mode", 2 );
    }
}

// Namespace dart_mark_zero
// Params 0, eflags: 0x4
// Checksum 0xf8541345, Offset: 0x3dd7
// Size: 0x18
function private function_1bb10c5c0524da9e()
{
    self.var_208e7f8b4e8599be = undefined;
    self setclientomnvar( "ui_dart_mark_zero_operation_mode", 0 );
}

// Namespace dart_mark_zero
// Params 1, eflags: 0x4
// Checksum 0xa529868c, Offset: 0x3df7
// Size: 0x50
function private onpullback( params )
{
    var_627fb43f841ec021 = utility::callsharedfunc( #"map", #"hash_b4fafa9d5f310a7e", self );
    
    if ( weapon::function_ecbdce6df0e16a2a( #"dart_mark_zero" ) || var_627fb43f841ec021 )
    {
        weapons::denyusage();
    }
}

