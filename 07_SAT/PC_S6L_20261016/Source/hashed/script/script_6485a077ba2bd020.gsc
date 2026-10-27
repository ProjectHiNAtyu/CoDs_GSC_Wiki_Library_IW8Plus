// script_6485a077ba2bd020  (hash_6485a077ba2bd020.gscc) (size: 6978 Bytes / 0x1b42 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x270fc448 (655344712)
// size ...... 6978 (0x1b42)
// includes .. 15  (offset: 0x19c6)
// strings ... 20  (offset: 0x1a3e)
// dev strs .. 1   (offset: 0x1b36)
// exports ... 17  (offset: 0xfa2)
// cseg ...... 0x1eb + 0xdb7 (0xfa2)
// imports ... 67  (offset: 0x124a)
// animtree1 . 0   (offset: 0x1b42)
// animtree2 . 0   (offset: 0x1b42)
#using script_31ee2a173f3499b7;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\system;
#using scripts\common\trace;
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
#using scripts\mp\zm\ztron\ztron_utility;

#namespace namespace_4e282cd6c250c6ed;

// Namespace namespace_4e282cd6c250c6ed
// Params 0, eflags: 0x5
// Checksum 0x19931727, Offset: 0x209
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_2fdea2968fbb50fc", #"ztron_item", undefined, &init );
}

// Namespace namespace_4e282cd6c250c6ed
// Params 0
// Checksum 0x8e210860, Offset: 0x232
// Size: 0x98
function init()
{
    ztron_item::function_5844a9c240f7dc8d( #"helicopter", #"use", &usehelicopter );
    ztron_item::function_5844a9c240f7dc8d( #"helicopter", #"canautouse", &canautouse );
    ztron_item::function_5844a9c240f7dc8d( #"helicopter", #"postspawnitem", &postspawned );
    ztron_item::function_5844a9c240f7dc8d( #"helicopter", #"hash_2dbdd4400cffa8b8", &canitemspawn );
    utility::registersharedfunc( %"hash_1cc68ca83a7fc620", #"exitStart", &function_f673263c798b41ca );
}

// Namespace namespace_4e282cd6c250c6ed
// Params 2
// Checksum 0xbea8b9d1, Offset: 0x2d2
// Size: 0x55
function postspawned( item, params )
{
    if ( !params.mapbased )
    {
        level.ztron.var_6f73e640811b9d47 = gettime();
        level.ztron.var_562e7a4129b9daae = "helicopter";
    }
}

// Namespace namespace_4e282cd6c250c6ed
// Params 1
// Checksum 0x321699b1, Offset: 0x32f
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

// Namespace namespace_4e282cd6c250c6ed
// Params 1
// Checksum 0x261e6d4b, Offset: 0x39b
// Size: 0x63, Type: bool
function canautouse( params )
{
    return !isdefined( self.ztron.vehicle ) && !isdefined( self.ztron.vehicleblocked ) && !self.inlaststand && !self getcamerathirdperson() && !level utility::flag( "ztron_cutscene" );
}

// Namespace namespace_4e282cd6c250c6ed
// Params 6
// Checksum 0x6dfcd901, Offset: 0x407
// Size: 0xfc
function function_f673263c798b41ca( vehicle, seatid, newseatid, player, data, specialexit )
{
    startpos = vehicle.origin + ( 0, 0, 100 );
    endpos = vehicle.origin + ( 0, 0, -100 );
    var_7b9ae2047be4c11d = trace::create_contents( 0, 1, 0, 0, 1, 0, 1 );
    groundresult = physics_raycast( startpos, endpos, var_7b9ae2047be4c11d, undefined, 0, "physicsquery_closest" );
    origin = groundresult[ 0 ][ "position" ] ?? vehicle.origin;
    navpoint = player ztron_util::function_4693a81423b56106( origin );
    
    if ( isdefined( navpoint ) )
    {
        data.exitposition = navpoint;
    }
}

// Namespace namespace_4e282cd6c250c6ed
// Params 1
// Checksum 0x15f4946b, Offset: 0x50b
// Size: 0x61
function function_e0ca7c537d7b1c36( owner )
{
    self notify( #"hash_17a60ce6f17ff2bf" );
    self endon( #"hash_17a60ce6f17ff2bf" );
    self endon( #"death" );
    owner waittill( #"disconnect" );
    
    if ( isdefined( self.attractor ) )
    {
        zombie_attractor_manager::remove_attractor( self.attractor );
    }
    
    self delete();
}

// Namespace namespace_4e282cd6c250c6ed
// Params 1, eflags: 0x4
// Checksum 0x16f2e6bd, Offset: 0x574
// Size: 0x1d9
function private usehelicopter( params )
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
    
    helicopter = owner function_740b8302665cfa7b();
    
    if ( !isdefined( helicopter ) )
    {
        return;
    }
    
    owner.ztron.vehicle = helicopter;
    helicopter thread function_e0ca7c537d7b1c36( owner );
    
    if ( owner.ztron.upgradeMask & 128 )
    {
        helicopter.attractor = zombie_attractor_manager::add_attractor( helicopter, 7, undefined, undefined, undefined, &attractor_validator, 0, undefined, 1 );
    }
    
    owner.ztron.vehicleblocked = 1;
    owner ztron_player_utility::playerinvulnerability( 1 );
    itemdata = ztron_item::function_998f2b10462afbf4( params.bundle );
    duration = itemdata.duration ?? 30;
    
    if ( owner.ztron.upgradeMask & 2097152 )
    {
        duration *= 1.25;
    }
    
    duration = owner ztron_player_utility::function_10777122eee28fa8( duration );
    owner thread function_45a06682d213862a( helicopter );
    owner thread helicopterwatchtimeout( duration );
    owner thread function_700541b3ad1ae991();
    owner thread function_e7af8c49bffdb1b6();
    owner playrumblelooponentity( "damage_light" );
    owner ztron_ui::function_787d89891b886acf( "VEH_EXIT_HINT" );
}

// Namespace namespace_4e282cd6c250c6ed
// Params 2, eflags: 0x4
// Checksum 0x679db7cc, Offset: 0x755
// Size: 0xba
function private attractor_validator( attractor, zombie )
{
    if ( zombie.b_ignore_monkey_bomb )
    {
        return 0;
    }
    
    if ( zombie.subclass == "zombie_hellhound" )
    {
        return 0;
    }
    
    if ( zombie.var_840153567385cc6b )
    {
        return 0;
    }
    
    if ( zombie.aicategory == "normal" || zombie.aicategory == "special" || zombie.aicategory == "elite" )
    {
        if ( zombie.team != attractor.source.team )
        {
            return 1;
        }
        else
        {
            return 0;
        }
        
        return;
    }
    
    return 0;
}

// Namespace namespace_4e282cd6c250c6ed
// Params 0, eflags: 0x4
// Checksum 0xb9260237, Offset: 0x817
// Size: 0x20b
function private function_e7af8c49bffdb1b6()
{
    self endon( #"disconnect" );
    self endon( #"helicopter_destroyed" );
    level endon( #"ztron_game_is_over" );
    helicopter = self.ztron.vehicle;
    
    while ( isdefined( helicopter ) )
    {
        turretforward = anglestoforward( ( 0, helicopter.angles[ 1 ], 0 ) );
        besttarget = undefined;
        var_2b61811e5dee492 = ztron_camera::function_4963ef31446ec8d9( self.ztron.var_a46fa357ac82e4a );
        
        if ( var_2b61811e5dee492 )
        {
            var_7fdb3d6b269c1829 = getentitiesinradiusfrompartitiongrid( self.origin, 1000, level.var_64b7737168df26be, [ self ] );
            currentdistance = 0;
            
            foreach ( ent in var_7fdb3d6b269c1829 )
            {
                origindelta = ent.origin - helicopter.origin;
                var_c527272f7a17e566 = vectordot( turretforward, vectornormalize( ( origindelta[ 0 ], origindelta[ 1 ], 0 ) ) );
                
                if ( var_c527272f7a17e566 > cos( 10 ) )
                {
                    entdistance = distancesquared( ent.origin, helicopter.origin );
                    
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
            helicopter setturrettargetent( besttarget, ( 0, 0, trigger_half_size[ 2 ] ) );
            helicopter.besttarget = besttarget;
        }
        else
        {
            helicopter clearturrettarget();
        }
        
        wait 0.05;
    }
}

// Namespace namespace_4e282cd6c250c6ed
// Params 0, eflags: 0x4
// Checksum 0x31989ebe, Offset: 0xa2a
// Size: 0x18b
function private function_740b8302665cfa7b()
{
    vehiclespawndata = spawnstruct();
    vehiclespawndata.origin = self.origin + ( 0, 0, 85 );
    vehiclespawndata.angles = self.angles;
    vehiclespawndata.script_modelname = "xcomp_ztron_sat_mini_heli_light_attack";
    vehiclespawndata.var_305ce2bb6ec0993d = self.ztron.color;
    faildata = spawnstruct();
    helicopter = vehicle::spawn( "veh_ztron_mil_us_heli_medium", vehiclespawndata );
    
    if ( !isdefined( helicopter ) )
    {
        ztron_debug::debugmsg( " ztron spawnZtronHelicopter failed for player:" + self.name + " reason:" + faildata.fail, 1 );
        return;
    }
    
    helicopter.team = self.team;
    helicopter.owner = self;
    helicopter.var_9ba75406da00630d = 1;
    helicopter.no_shell_eject = 1;
    helicopter.var_f4cb64a84a917d5b = 1;
    helicopter.forcefp = 0;
    helicopter.var_826c7bc2c0346845 = 1;
    helicopter.godmode = 1;
    level thread vehicle_occupancy::enter( helicopter, "driver", self, undefined, 1 );
    ztron_player::function_37facbabb748eff2();
    helicopter makeunusable();
    helicopter.maxhealth = 9999999;
    helicopter.health = 9999999;
    return helicopter;
}

// Namespace namespace_4e282cd6c250c6ed
// Params 3, eflags: 0x4
// Checksum 0xc06a8764, Offset: 0xbbe
// Size: 0x16c
function private firemissile( player, weapon, var_9a89c6c5cc974ca3 )
{
    pitch = randomfloatrange( 4, 7 );
    angles = ( pitch, self.angles[ 1 ], 0 );
    
    if ( isdefined( player ) )
    {
        if ( player.ztron.var_a4c2f70bbc713f98 )
        {
            viewangles = player getplayerangles();
            angles = ( viewangles[ 0 ], self.angles[ 1 ], 0 );
        }
    }
    
    forward = anglestoforward( angles );
    right = anglestoright( angles );
    offset = forward * -40 + ( 0, 0, -10 );
    
    if ( var_9a89c6c5cc974ca3 )
    {
        offset += right * 20;
    }
    else
    {
        offset -= right * 20;
    }
    
    start = self.origin + offset;
    end = start + forward * 1000;
    
    if ( self.besttarget )
    {
        end = self.besttarget.origin;
        self.besttarget = undefined;
    }
    
    assert( !isnullweapon( weapon ), "<dev string:x24>" );
    projectile = magicbullet( weapon, start, end, self );
    projectile.owner = player;
}

// Namespace namespace_4e282cd6c250c6ed
// Params 1, eflags: 0x4
// Checksum 0x3a849b45, Offset: 0xd32
// Size: 0x82
function private function_45a06682d213862a( helicopter )
{
    self endon( #"disconnect" );
    self endon( #"helicopter_destroyed" );
    level endon( #"ztron_game_is_over" );
    weapon = helicopter getturretweapon( 1 );
    var_9a89c6c5cc974ca3 = 1;
    
    while ( isdefined( helicopter ) )
    {
        if ( !helicopter function_7cc4e445cca9566f( 0 ) )
        {
            helicopter firemissile( self, weapon, var_9a89c6c5cc974ca3 );
            var_9a89c6c5cc974ca3 = !var_9a89c6c5cc974ca3;
        }
        
        wait weapon.firetime;
    }
}

// Namespace namespace_4e282cd6c250c6ed
// Params 1
// Checksum 0x5cbb120c, Offset: 0xdbc
// Size: 0x48
function helicopterwatchtimeout( time )
{
    self endon( #"disconnect" );
    self endon( #"helicopter_destroyed" );
    level endon( #"ztron_game_is_over" );
    
    while ( !ztron_item::function_4b0636e7b2fc461f() )
    {
        waitframe();
    }
    
    wait time;
    function_ed8af7a8979c4e87();
}

// Namespace namespace_4e282cd6c250c6ed
// Params 0
// Checksum 0xf607f3f5, Offset: 0xe0c
// Size: 0x43
function function_700541b3ad1ae991()
{
    self endon( #"disconnect" );
    self endon( #"helicopter_destroyed" );
    level endon( #"ztron_game_is_over" );
    utility::waittill_any( "ztron_player_dump_vehicle", "ztron_exit_taken", "ztron_teleporter_taken" );
    function_ed8af7a8979c4e87();
}

// Namespace namespace_4e282cd6c250c6ed
// Params 1, eflags: 0x4
// Checksum 0x11400983, Offset: 0xe57
// Size: 0x14b
function private function_ed8af7a8979c4e87( callexist = 1 )
{
    helicopter = self.ztron.vehicle;
    self endon( #"disconnect" );
    ztron_player_utility::playerinvulnerability( 0, 1 );
    val::set( "ztron_vehicle_block", "fire", 0 );
    
    if ( callexist && isdefined( helicopter ) )
    {
        vehicle_occupancy::exit( helicopter, "driver", self, undefined, 1 );
    }
    
    self.ignoreme = 0;
    self.ztron.vehicle = undefined;
    self.ztron.var_fe6f1fc8ee223cf0 = undefined;
    self.ztron.var_538334d0040b7d5f = gettime();
    self.ztron.dmggrace = self.ztron.var_538334d0040b7d5f + 1000;
    ztron_player::function_ca94aec68892d78f();
    thread ztron_player_utility::turnPlayerShieldOn( 1 );
    
    if ( isdefined( helicopter ) )
    {
        if ( isdefined( helicopter.attractor ) )
        {
            zombie_attractor_manager::remove_attractor( helicopter.attractor );
        }
        
        vehicle_tracking::delete_vehicle( helicopter );
    }
    
    self stoprumble( "damage_light" );
    thread ztron_player::function_9886753b3100ebd0();
    self notify( #"helicopter_destroyed" );
}

