// script_293ee32112d20771  (hash_293ee32112d20771.gscc) (size: 5957 Bytes / 0x1745 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5f8ff57f (1603270015)
// size ...... 5957 (0x1745)
// includes .. 14  (offset: 0x160d)
// strings ... 16  (offset: 0x167d)
// dev strs .. 0   (offset: 0x1745)
// exports ... 16  (offset: 0xcdd)
// cseg ...... 0x1bb + 0xb22 (0xcdd)
// imports ... 60  (offset: 0xf5d)
// animtree1 . 0   (offset: 0x1745)
// animtree2 . 0   (offset: 0x1745)
#using script_31ee2a173f3499b7;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_tracking;
#using scripts\mp\zm\ztron\ztron_camera;
#using scripts\mp\zm\ztron\ztron_debug;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_player;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace namespace_a0f5e29744a1f79c;

// Namespace namespace_a0f5e29744a1f79c
// Params 0, eflags: 0x5
// Checksum 0xd3c15a94, Offset: 0x1d9
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_421e6e0140cdc8bd", #"ztron_item", undefined, &init );
}

// Namespace namespace_a0f5e29744a1f79c
// Params 0
// Checksum 0xb16c4bf0, Offset: 0x202
// Size: 0xa9
function init()
{
    ztron_item::function_5844a9c240f7dc8d( #"tank", #"use", &usetank );
    ztron_item::function_5844a9c240f7dc8d( #"tank", #"canautouse", &canautouse );
    ztron_item::function_5844a9c240f7dc8d( #"tank", #"postspawnitem", &postspawned );
    ztron_item::function_5844a9c240f7dc8d( #"tank", #"hash_2dbdd4400cffa8b8", &canitemspawn );
    ztron_sound::function_4ac735395b173fe( "tank_item_pickup_activated_OS", "evt_ztron_pickup_hind_consumed" );
    utility::registersharedfunc( %"hash_17e7c0ed24911a3f", #"exitStart", &function_41c6121a2865563a );
}

// Namespace namespace_a0f5e29744a1f79c
// Params 2
// Checksum 0xb3fefd4b, Offset: 0x2b3
// Size: 0x55
function postspawned( item, params )
{
    if ( !params.mapbased )
    {
        level.ztron.var_6f73e640811b9d47 = gettime();
        level.ztron.var_562e7a4129b9daae = "tank";
    }
}

// Namespace namespace_a0f5e29744a1f79c
// Params 1
// Checksum 0x37324c43, Offset: 0x310
// Size: 0x63, Type: bool
function canitemspawn( params )
{
    if ( isdefined( level.ztron.var_6f73e640811b9d47 ) )
    {
        if ( params.mapbased )
        {
            return true;
        }
        
        time = gettime();
        return ( time - level.ztron.var_6f73e640811b9d47 > 300000 );
    }
    
    return true;
}

// Namespace namespace_a0f5e29744a1f79c
// Params 1, eflags: 0x4
// Checksum 0x233ab8bd, Offset: 0x37c
// Size: 0x63, Type: bool
function private canautouse( params )
{
    return !isdefined( self.ztron.vehicle ) && !isdefined( self.ztron.vehicleblocked ) && !self.inlaststand && !self getcamerathirdperson() && !level utility::flag( "ztron_cutscene" );
}

// Namespace namespace_a0f5e29744a1f79c
// Params 6, eflags: 0x4
// Checksum 0x1e5ce54d, Offset: 0x3e8
// Size: 0x6c
function private function_41c6121a2865563a( vehicle, seatid, newseatid, player, data, specialexit )
{
    navpoint = player ztron_util::function_4693a81423b56106( vehicle.origin );
    
    if ( isdefined( navpoint ) )
    {
        data.exitposition = navpoint;
    }
}

// Namespace namespace_a0f5e29744a1f79c
// Params 1, eflags: 0x4
// Checksum 0xf0eadeb9, Offset: 0x45c
// Size: 0x1a6
function private usetank( params )
{
    level endon( #"ztron_game_is_over" );
    owner = params.player;
    owner endon( #"disconnect" );
    
    if ( !isdefined( owner ) || isdefined( owner.ztron.vehicle ) || owner.ztron.vehicleblocked )
    {
        return;
    }
    
    if ( !isdefined( owner.ztron ) )
    {
        owner.ztron = spawnstruct();
    }
    
    tank = owner function_cf1fb46c44255526();
    
    if ( !isdefined( tank ) )
    {
        return;
    }
    
    ztron_sound::ztron_playsound( "tank_item_pickup_activated_OS", tank.origin );
    owner.ztron.vehicle = tank;
    tank thread ztron_util::function_1544885c712921f8( owner );
    owner.ztron.vehicleblocked = 1;
    owner ztron_player_utility::playerinvulnerability( 1 );
    itemdata = ztron_item::function_998f2b10462afbf4( params.bundle );
    duration = itemdata.duration ?? 30;
    
    if ( owner.ztron.upgradeMask & 2097152 )
    {
        duration *= 1.25;
    }
    
    duration = owner ztron_player_utility::function_10777122eee28fa8( duration );
    owner thread function_10619887557aac4( duration );
    owner thread function_d992576e66dfa6b2();
    owner thread function_cb3e44adb9d27ad();
    owner thread function_7053b5646f27bd1();
    owner ztron_ui::function_787d89891b886acf( "VEH_EXIT_HINT" );
}

// Namespace namespace_a0f5e29744a1f79c
// Params 0, eflags: 0x4
// Checksum 0xed99422e, Offset: 0x60a
// Size: 0x206
function private function_7053b5646f27bd1()
{
    self endon( #"disconnect" );
    self endon( #"tank_destroyed" );
    level endon( #"ztron_game_is_over" );
    tank = self.ztron.vehicle;
    
    while ( true )
    {
        var_76f2993cdc2d1b61 = tank getturretworldangles();
        turretforward = anglestoforward( ( 0, var_76f2993cdc2d1b61[ 1 ], 0 ) );
        besttarget = undefined;
        var_2b61811e5dee492 = ztron_camera::function_4963ef31446ec8d9( self.ztron.var_a46fa357ac82e4a );
        
        if ( var_2b61811e5dee492 )
        {
            var_7fdb3d6b269c1829 = getentitiesinradiusfrompartitiongrid( self.origin, 1000, level.var_64b7737168df26be, [ self ] );
            currentdistance = 0;
            
            foreach ( ent in var_7fdb3d6b269c1829 )
            {
                origindelta = ent.origin - tank.origin;
                var_c527272f7a17e566 = vectordot( turretforward, vectornormalize( ( origindelta[ 0 ], origindelta[ 1 ], 0 ) ) );
                
                if ( var_c527272f7a17e566 > cos( 10 ) )
                {
                    entdistance = distancesquared( ent.origin, tank.origin );
                    
                    if ( !isdefined( besttarget ) || entdistance < currentdistance )
                    {
                        besttarget = ent;
                        currentdistance = entdistance;
                    }
                }
            }
        }
        
        if ( besttarget )
        {
            trigger_half_size = function_decb653c5689e4ca( besttarget.model );
            tank setturrettargetent( besttarget, ( 0, 0, trigger_half_size[ 2 ] ), 1 );
        }
        else
        {
            tank clearturrettarget( 1 );
        }
        
        wait 0.5;
    }
}

// Namespace namespace_a0f5e29744a1f79c
// Params 0, eflags: 0x4
// Checksum 0xe2efd73a, Offset: 0x818
// Size: 0x1a1
function private function_cf1fb46c44255526()
{
    vehiclespawndata = spawnstruct();
    vehiclespawndata.origin = self.origin + ( 0, 0, 50 );
    vehiclespawndata.angles = self.angles;
    vehiclespawndata.script_modelname = "xcomp_veh_sat_mini_tank_fmbt_" + self.ztron.color;
    faildata = spawnstruct();
    tank = vehicle::spawn( "veh_ztron_mil_ru_tank_t72", vehiclespawndata, faildata );
    
    if ( !isdefined( tank ) )
    {
        ztron_debug::debugmsg( " ztron spawnZtronTank failed for player:" + self.name + " reason:" + faildata.fail, 1 );
        return;
    }
    
    tank.team = self.team;
    tank.owner = self;
    tank.var_9ba75406da00630d = 1;
    tank.no_shell_eject = 1;
    tank.var_f4cb64a84a917d5b = 1;
    tank.forcefp = 0;
    tank.var_826c7bc2c0346845 = 1;
    tank.godmode = 1;
    tank.dontspawnhusk = 1;
    level thread vehicle_occupancy::enter( tank, "driver", self, undefined, 1 );
    ztron_player::function_37facbabb748eff2();
    tank makeunusable();
    tank.maxhealth = 9999999;
    tank.health = 9999999;
    tank thread function_d300b0e42af3d9a();
    tank thread tankwatchturretfire();
    return tank;
}

// Namespace namespace_a0f5e29744a1f79c
// Params 0, eflags: 0x4
// Checksum 0xd05bf211, Offset: 0x9c2
// Size: 0x55
function private function_d300b0e42af3d9a()
{
    self.owner endon( #"disconnect" );
    self.owner endon( #"tank_destroyed" );
    level endon( #"ztron_game_is_over" );
    utility::waittill_any( "explode" );
    self.owner function_dc4fd08c5fff7f5a( 1, 0 );
}

// Namespace namespace_a0f5e29744a1f79c
// Params 0, eflags: 0x4
// Checksum 0x22465686, Offset: 0xa1f
// Size: 0x72
function private tankwatchturretfire()
{
    self.owner endon( #"disconnect" );
    self.owner endon( #"tank_destroyed" );
    level endon( #"ztron_game_is_over" );
    
    while ( true )
    {
        self waittill( #"missile_fire", missile );
        
        if ( isdefined( missile ) )
        {
            missile.owner = self.owner;
        }
    }
}

// Namespace namespace_a0f5e29744a1f79c
// Params 1, eflags: 0x4
// Checksum 0x83b4b87e, Offset: 0xa99
// Size: 0x48
function private function_10619887557aac4( time )
{
    self endon( #"disconnect" );
    self endon( #"tank_destroyed" );
    level endon( #"ztron_game_is_over" );
    
    while ( !ztron_item::function_4b0636e7b2fc461f() )
    {
        waitframe();
    }
    
    wait time;
    function_dc4fd08c5fff7f5a();
}

// Namespace namespace_a0f5e29744a1f79c
// Params 0, eflags: 0x4
// Checksum 0x85d40e5c, Offset: 0xae9
// Size: 0x43
function private function_d992576e66dfa6b2()
{
    self endon( #"disconnect" );
    self endon( #"tank_destroyed" );
    level endon( #"ztron_game_is_over" );
    utility::waittill_any( "ztron_player_dump_vehicle", "ztron_exit_taken", "ztron_teleporter_taken" );
    function_dc4fd08c5fff7f5a();
}

// Namespace namespace_a0f5e29744a1f79c
// Params 0, eflags: 0x4
// Checksum 0xc42758ad, Offset: 0xb34
// Size: 0x72
function private function_cb3e44adb9d27ad()
{
    self endon( #"disconnect" );
    self endon( #"tank_destroyed" );
    level endon( #"ztron_game_is_over" );
    tank = self.ztron.vehicle;
    tank setturretscriptcontrolled( 1, 1 );
    
    while ( true )
    {
        if ( !tank function_7cc4e445cca9566f( 0 ) )
        {
            tank requestfireweapon( 1 );
        }
        
        wait 0.05;
    }
}

// Namespace namespace_a0f5e29744a1f79c
// Params 2, eflags: 0x4
// Checksum 0x4f5fed50, Offset: 0xbae
// Size: 0x12f
function private function_dc4fd08c5fff7f5a( callexist = 1, deletevehicle = 1 )
{
    self endon( #"disconnect" );
    ztron_player_utility::playerinvulnerability( 0, 1 );
    val::set( "ztron_vehicle_block", "fire", 0 );
    tank = self.ztron.vehicle;
    
    if ( isdefined( tank ) )
    {
        if ( callexist )
        {
            vehicle_occupancy::exit( tank, "driver", self, undefined, 1 );
        }
        
        if ( deletevehicle )
        {
            vehicle_tracking::delete_vehicle( tank );
        }
    }
    
    self.ignoreme = 0;
    self.ztron.vehicle = undefined;
    self.ztron.var_fe6f1fc8ee223cf0 = undefined;
    self.ztron.var_538334d0040b7d5f = gettime();
    self.ztron.dmggrace = self.ztron.var_538334d0040b7d5f + 1000;
    ztron_player::function_ca94aec68892d78f();
    thread ztron_player_utility::function_985a085be4ea0ba4( 1 );
    thread ztron_player::function_9886753b3100ebd0();
    self notify( #"tank_destroyed" );
}

