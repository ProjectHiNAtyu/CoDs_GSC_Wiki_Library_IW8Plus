// script_5218f92aaa1d8675  (hash_5218f92aaa1d8675.gscc) (size: 7187 Bytes / 0x1c13 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x437b85de (1132168670)
// size ...... 7187 (0x1c13)
// includes .. 6   (offset: 0x1adf)
// strings ... 18  (offset: 0x1b0f)
// dev strs .. 1   (offset: 0x1c07)
// exports ... 14  (offset: 0x122b)
// cseg ...... 0x1a1 + 0x108a (0x122b)
// imports ... 56  (offset: 0x145b)
// animtree1 . 0   (offset: 0x1c13)
// animtree2 . 0   (offset: 0x1c13)
#using scripts\common\utility;
#using scripts\common\vehicle_tracking;
#using scripts\mp\br\gametypes\br_lootchopper;
#using scripts\mp\common\killstreaks\chopper_support;
#using scripts\mp\common\utility\teams;
#using scripts\mp\sentientpoolmanager;

#namespace namespace_1999aeb00a58bdf6;

// Namespace namespace_1999aeb00a58bdf6
// Params 0
// Checksum 0x68d40073, Offset: 0x1bf
// Size: 0x17
function init()
{
    if ( !isdefined( level.loot_choppers ) )
    {
        br_lootchopper::init();
    }
}

// Namespace namespace_1999aeb00a58bdf6
// Params 4
// Checksum 0x6e5d05b6, Offset: 0x1de
// Size: 0x803
function custom_chopper_spawn( var_530a642361ea8773, initialtarget, initialorigin, spawn_properties )
{
    level.averagealliesz = 0;
    startingposition = initialorigin;
    startingangles = ( 0, 0, 0 );
    spawnvehicletype = "veh_chopper_support_dmz_mp";
    chopper = vehicle_tracking::spawn_helicopter( undefined, startingposition, startingangles, spawnvehicletype, "veh8_mil_air_palfa_east" );
    
    if ( !isdefined( chopper ) )
    {
        return;
    }
    
    chopper.speed = spawn_properties.speed;
    chopper.accel = spawn_properties.accel;
    chopper.lifetime = getdvarint( @"hash_c9bf362f07c0b844", 9999 );
    chopper.team = spawn_properties.team;
    chopper.angles = startingangles;
    chopper.flaresreservecount = getdvarint( @"hash_8bb2d173674d701a", 0 );
    chopper.pathstart = startingposition;
    chopper.pathgoal = var_530a642361ea8773.origin;
    chopper.currentaction = undefined;
    chopper.currenttarget = var_530a642361ea8773;
    chopper.heightoffset = ( 0, 0, getdvarint( @"hash_5e4f7a1dffad4bd0", 750 ) );
    chopper.patrolzone = undefined;
    chopper.patrollocation = undefined;
    chopper.patrolradius = undefined;
    chopper.stage3accradius = 35;
    chopper.crashoffset = chopper.heightoffset[ 2 ] - 250;
    chopper.predeterminedtargets = chopper function_dd1b9b9db137236a( initialtarget );
    chopper setmaxpitchroll( 15, 15 );
    chopper vehicle_setspeed( spawn_properties.speed, spawn_properties.accel );
    chopper sethoverparams( 50, 5, 2.5 );
    chopper setturningability( 0.5 );
    chopper setyawspeed( 100, 25, 25, 0.1 );
    chopper setcandamage( 1 );
    chopper setneargoalnotifydist( 768 );
    chopper setvehicleteam( chopper.team );
    chopper.currenthealth = getdvarint( @"hash_bb80e65b55c98289", spawn_properties.health );
    chopper.health = spawn_properties.health;
    chopper.maxhealth = getdvarint( @"hash_bb80e65b55c98289", spawn_properties.health );
    chopper sentientpoolmanager::registersentient( "Level_Vehicle", chopper.team );
    chopper br_lootchopper::lootchopper_setupdamagefunctionality();
    chopper setscriptablepartstate( "blinking_lights", "on", 0 );
    chopper setscriptablepartstate( "engine", "on", 0 );
    chopper.turretproperties = spawnstruct();
    chopper.turretproperties.ammo = 16;
    chopper.turretproperties.cooldown = 3;
    chopper.turretproperties.var_e3b4cbb02d09d139 = 0.1;
    chopper.turretproperties.accuracy = 40;
    chopper.turretproperties.range_squared = 4000000;
    chopper.frontturret = spawnturret( "misc_turret", chopper gettagorigin( "tag_turret_front" ), "chopper_support_turret_mp" );
    chopper.frontturret setmodel( "veh9_mil_air_heli_ahotel64_turret" );
    chopper.frontturret.team = chopper.team;
    chopper.frontturret.angles = chopper.angles;
    chopper.frontturret.turreton = 1;
    chopper.frontturret.name = "front_turret";
    chopper.frontturret.attackingtarget = var_530a642361ea8773;
    chopper.frontturret.vehicleparent = "loot_chopper";
    chopper.frontturret linkto( chopper );
    chopper.frontturret setturretteam( chopper.team );
    chopper.frontturret setturretmodechangewait( 0 );
    chopper.frontturret setmode( "manual" );
    chopper.frontturret setdefaultdroppitch( 45 );
    chopper.frontturret.owner = chopper;
    chopper.frontturret.groundtargetent = spawn( "script_model", chopper.origin );
    chopper.frontturret.groundtargetent setmodel( "tag_origin" );
    chopper.frontturret.groundtargetent dontinterpolate();
    chopper.rearturret = spawnturret( "misc_turret", chopper gettagorigin( "tag_turret_rear" ), "chopper_support_turret_mp" );
    chopper.rearturret setmodel( "veh9_mil_air_heli_ahotel64_turret" );
    chopper.rearturret.team = chopper.team;
    chopper.rearturret.angles = chopper.angles;
    chopper.rearturret.turreton = 1;
    chopper.rearturret.name = "rear_turret";
    chopper.rearturret.attackingtarget = var_530a642361ea8773;
    chopper.rearturret.vehicleparent = "loot_chopper";
    chopper.rearturret linkto( chopper );
    chopper.rearturret setturretteam( chopper.team );
    chopper.rearturret setturretmodechangewait( 0 );
    chopper.rearturret setmode( "manual" );
    chopper.rearturret setdefaultdroppitch( 45 );
    chopper.rearturret.owner = chopper;
    chopper.rearturret.groundtargetent = spawn( "script_model", chopper.origin );
    chopper.rearturret.groundtargetent setmodel( "tag_origin" );
    chopper.rearturret.groundtargetent dontinterpolate();
    chopper.frontturret thread function_2dfc1f0ec56cd65f();
    chopper.frontturret thread function_f160599fd6ec77a5();
    chopper.rearturret thread function_2dfc1f0ec56cd65f();
    chopper.rearturret thread function_f160599fd6ec77a5();
    chopper thread function_1c9fcbc2201fd854();
    chopper notify( #"change_movement_type", &function_b178b367906b8a92 );
    chopper thread function_392aab933e809426();
    level.loot_choppers[ level.loot_choppers.size ] = chopper;
    chopper.patrolfunc = &function_1c9fcbc2201fd854;
    chopper.cleanupfunc = &custom_chopper_cleanup;
    chopper thread chopper_support::choppersupport_neargoalsettings();
    
    if ( utility::issharedfuncdefined( #"flares", #"hash_c8c23ade5da7f4bb" ) )
    {
        chopper thread [[ utility::getsharedfunc( #"flares", #"hash_c8c23ade5da7f4bb" ) ]]( &chopper_support::choppersupport_handlemissiledetection );
    }
    
    chopper thread chopper_support::choppersupport_movetolocation( chopper.pathgoal, 1 );
    return chopper;
}

// Namespace namespace_1999aeb00a58bdf6
// Params 1
// Checksum 0x5af4627f, Offset: 0x9ea
// Size: 0x4c
function function_dd1b9b9db137236a( player )
{
    squadmates = teams::getsquadmates( player.team );
    
    if ( !isdefined( squadmates ) )
    {
        if ( isplayer( player ) )
        {
            return player;
        }
        
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    return squadmates;
}

// Namespace namespace_1999aeb00a58bdf6
// Params 0
// Checksum 0x543df732, Offset: 0xa3f
// Size: 0xb8
function function_b7ee5d2c9c1e274c()
{
    new_target = undefined;
    
    if ( !isdefined( self.predeterminedtargets ) || self.predeterminedtargets.size <= 0 )
    {
        return;
    }
    
    foreach ( target in self.predeterminedtargets )
    {
        if ( isdefined( target ) && target != self.currenttarget )
        {
            new_target = target;
        }
    }
    
    return new_target;
}

// Namespace namespace_1999aeb00a58bdf6
// Params 0
// Checksum 0x3e2a9465, Offset: 0xb00
// Size: 0xcb
function function_799229df97d8f636()
{
    potential_targets = self.predeterminedtargets;
    
    foreach ( target in self.predeterminedtargets )
    {
        if ( isdefined( target ) )
        {
            if ( distance2dsquared( self.origin, target.origin ) > self.turretproperties.range_squared )
            {
                potential_targets = arrayremove( potential_targets, target );
            }
        }
    }
    
    return utility::array_random( potential_targets );
}

// Namespace namespace_1999aeb00a58bdf6
// Params 1
// Checksum 0x5d853c8f, Offset: 0xbd4
// Size: 0x4b
function function_1c9fcbc2201fd854( initialpatrol )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"change_movement_type", movement_thread );
        self thread [[ movement_thread ]]();
    }
}

// Namespace namespace_1999aeb00a58bdf6
// Params 0
// Checksum 0xb351cefc, Offset: 0xc27
// Size: 0x8e
function function_b178b367906b8a92()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"change_movement_type" );
    self endon( #"leaving" );
    
    while ( true )
    {
        wait 4;
        
        if ( !isdefined( self.currenttarget ) )
        {
            self notify( #"change_target", function_b7ee5d2c9c1e274c() );
        }
        
        if ( !isdefined( self.predeterminedtargets ) || self.predeterminedtargets.size <= 0 )
        {
            return;
        }
        
        chopper_support::choppersupport_movetolocation( self.currenttarget, 1 );
    }
}

// Namespace namespace_1999aeb00a58bdf6
// Params 0
// Checksum 0x23402a82, Offset: 0xcbd
// Size: 0x38
function function_f80115a30e1e8149()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"change_movement_type" );
    
    while ( true )
    {
        wait randomfloat( 1 );
    }
}

// Namespace namespace_1999aeb00a58bdf6
// Params 0
// Checksum 0xd6083fab, Offset: 0xcfd
// Size: 0x19b
function function_f160599fd6ec77a5()
{
    level endon( #"game_ended" );
    self.owner endon( #"death" );
    self.owner endon( #"leaving" );
    waitframe();
    self.oncooldown = 0;
    self.ammo = self.owner.turretproperties.ammo;
    
    if ( !isdefined( self.owner.predeterminedtargets ) || self.owner.predeterminedtargets.size <= 0 )
    {
        return;
    }
    
    self.owner chopper_support::choppersupport_setcurrenttarget( self, self.owner.predeterminedtargets[ 0 ] );
    
    while ( true )
    {
        if ( !isdefined( self.owner.currenttarget ) )
        {
            self.attackingtarget = self.owner function_799229df97d8f636();
            
            if ( !isdefined( self.attackingtarget ) )
            {
                break;
            }
        }
        
        if ( !self.oncooldown && distance2dsquared( self.owner.currenttarget.origin, self.origin ) < self.owner.turretproperties.range_squared )
        {
            self.oncooldown = 1;
            thread function_3ee9796bc2fc4942( self.ammo, self.owner.turretproperties.var_e3b4cbb02d09d139 );
        }
        
        waitframe();
    }
}

// Namespace namespace_1999aeb00a58bdf6
// Params 2
// Checksum 0xc8fdb788, Offset: 0xea0
// Size: 0x219
function function_3ee9796bc2fc4942( var_c5f2ea434b79460e, var_54ffb81288a4d6ad )
{
    level endon( #"game_ended" );
    self.owner endon( #"death" );
    self.owner endon( #"leaving" );
    shotsfired = 0;
    
    while ( shotsfired < var_c5f2ea434b79460e )
    {
        self.attackingtarget = self.owner function_799229df97d8f636();
        
        if ( !isdefined( self.attackingtarget ) )
        {
            return;
        }
        
        self.groundtargetent.origin = self.attackingtarget.origin;
        x = self.groundtargetent.origin[ 0 ];
        y = self.groundtargetent.origin[ 1 ];
        z = self.groundtargetent.origin[ 2 ];
        var_9308af3e182222e4 = randomint( 10 ) > 5 ? -1 : 1;
        var_9308b03e18222517 = randomint( 10 ) > 5 ? -1 : 1;
        x_offset = randomfloat( 1 ) * self.owner.turretproperties.accuracy * var_9308af3e182222e4 + x;
        y_offset = randomfloat( 1 ) * self.owner.turretproperties.accuracy * var_9308b03e18222517 + y;
        self.groundtargetent.origin += ( x_offset, y_offset, z );
        self shootturret( "tag_flash" );
        shotsfired += 1;
        wait var_54ffb81288a4d6ad;
    }
    
    wait self.owner.turretproperties.cooldown;
    self.oncooldown = 0;
}

// Namespace namespace_1999aeb00a58bdf6
// Params 1
// Checksum 0x35edf1fa, Offset: 0x10c1
// Size: 0xf0
function function_2dfc1f0ec56cd65f( giventarget )
{
    level endon( #"game_ended" );
    self.owner endon( #"death" );
    self.owner endon( #"leaving" );
    self.attackingtarget = self.owner.predeterminedtargets[ 0 ];
    self.owner setlookatent( self.attackingtarget );
    
    while ( true )
    {
        if ( !isdefined( self.owner.predeterminedtargets ) || self.owner.predeterminedtargets.size <= 0 )
        {
            return;
        }
        
        self.groundtargetent.origin = self.owner.currenttarget.origin + ( 0, 0, 32 );
        waitframe();
    }
}

// Namespace namespace_1999aeb00a58bdf6
// Params 0
// Checksum 0x37d6c809, Offset: 0x11b9
// Size: 0x61
function function_392aab933e809426()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"change_target", new_target );
        
        if ( !isdefined( new_target ) )
        {
            self notify( #"hash_1b391899c7a1c5d2", &function_f80115a30e1e8149 );
            continue;
        }
        
        self.currenttarget = new_target;
    }
}

// Namespace namespace_1999aeb00a58bdf6
// Params 0
// Checksum 0xf5933856, Offset: 0x1222
// Size: 0x9
function custom_chopper_cleanup()
{
    br_lootchopper::lootchopper_cleanup();
}

