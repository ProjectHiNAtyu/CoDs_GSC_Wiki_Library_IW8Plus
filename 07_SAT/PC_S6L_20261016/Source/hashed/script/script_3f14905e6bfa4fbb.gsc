// script_3f14905e6bfa4fbb  (hash_3f14905e6bfa4fbb.gscc) (size: 9764 Bytes / 0x2624 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7db4e7d8 (2109007832)
// size ...... 9764 (0x2624)
// includes .. 9   (offset: 0x2518)
// strings ... 13  (offset: 0x2560)
// dev strs .. 3   (offset: 0x2600)
// exports ... 32  (offset: 0x1748)
// cseg ...... 0x153 + 0x15f5 (0x1748)
// imports ... 76  (offset: 0x1c48)
// animtree1 . 0   (offset: 0x2624)
// animtree2 . 0   (offset: 0x2624)
#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\common\ai\smartobjects\utility;
#using scripts\common\cap;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle_aianim;
#using scripts\common\vehicle_occupancy;

#namespace combat;

// Namespace combat
// Params 0
// Checksum 0x984dc79c, Offset: 0x171
// Size: 0x33
function soldier_init_common()
{
    cap::init_cap();
    self.disablecoveringfire = 0;
    self.var_e04c40a1043ed9d = 1.5;
    self function_5c50b48c0c81d566( "all", 1, "bt" );
}

// Namespace combat
// Params 1
// Checksum 0x576e3db6, Offset: 0x1ac
// Size: 0x1b3
function function_1586434511dd01c5( guy )
{
    points = [];
    forward = anglestoforward( self.angles );
    left = anglestoleft( self.angles );
    up = anglestoup( self.angles );
    guyvehicle = guy getlinkedparent();
    guyspeed = length( guyvehicle vehicle_getvelocity() );
    var_26f8151bc07767c7 = anglestoforward( guyvehicle.angles );
    selfvelocity = self vehicle_getvelocity();
    selfspeed = length( selfvelocity );
    isreverse = vectordot( forward, selfvelocity ) < 0;
    
    if ( isreverse )
    {
        selfspeed *= -1;
    }
    
    vehiclejumpoffsets = [];
    vehiclejumpoffsets[ 0 ] = ( -50, 0, -10 );
    
    foreach ( offsetdata in vehiclejumpoffsets )
    {
        forwardvector = forward * offsetdata[ 0 ];
        leftvector = left * offsetdata[ 1 ];
        upvector = up * offsetdata[ 2 ];
        point = self.origin + forwardvector + leftvector + upvector;
        points[ points.size ] = point;
    }
    
    return points;
}

// Namespace combat
// Params 1
// Checksum 0x84d6f743, Offset: 0x368
// Size: 0x5e4
function vehiclejump( taskid )
{
    if ( !getdvarint( @"hash_18f07c17515921ea" ) )
    {
        return anim.failure;
    }
    
    if ( !self.var_54255f3ab05444f1 )
    {
        return anim.failure;
    }
    
    vehicle = self._blackboard.currentvehicle;
    
    if ( gettime() < 5000 )
    {
        return anim.failure;
    }
    
    if ( !isdefined( level.player.veh ) )
    {
        return anim.failure;
    }
    
    player_vehicle = level.player.veh;
    
    if ( isdefined( player_vehicle.jumperrider ) )
    {
        return anim.failure;
    }
    
    if ( !isdefined( level.var_48069d79f75860a8 ) )
    {
        level.var_48069d79f75860a8 = 0;
    }
    
    if ( gettime() < level.var_48069d79f75860a8 )
    {
        return anim.failure;
    }
    
    if ( self.var_38c348375f5455ef )
    {
        return anim.failure;
    }
    
    var_c4f1097876935509 = self._blackboard.currentvehicleanimalias;
    var_c4b257b1c21359c2 = self._blackboard.chosenvehicleanimpos_seatalias;
    animresult = archetypegetrandomalias( var_c4f1097876935509, "vehicle_jumper_jump", var_c4b257b1c21359c2 );
    
    if ( !isdefined( animresult ) )
    {
        return anim.failure;
    }
    
    jumptoarcname = player_vehicle.vehicleanimalias;
    jumptoalias = string( 2 );
    animresult = archetypegetrandomalias( jumptoarcname, "vehicle_jumper_get_up", jumptoalias );
    
    if ( !isdefined( animresult ) )
    {
        return anim.failure;
    }
    
    if ( !isalive( player_vehicle ) )
    {
        return anim.failure;
    }
    
    if ( distancesquared( player_vehicle.origin, vehicle.origin ) > 40000 )
    {
        return anim.failure;
    }
    
    if ( self.vehicle_position == 0 )
    {
        var_47e8bb84ac6b9e2b = vehicle.riders.size == 1 || vehicle.health < 25;
        
        if ( !var_47e8bb84ac6b9e2b )
        {
            return anim.failure;
        }
    }
    
    var_8b6714ee2b009ebe = self._blackboard.var_fef1650fd4ff6f6 && self.canshootinvehicle;
    to_vehicle_angles = vectortoangles( player_vehicle.origin - self.origin );
    to_vehicle_yaw = angleclamp( to_vehicle_angles[ 1 ] );
    facing_yaw = angleclamp( self.angles[ 1 ] );
    angle_diff = angleclamp180( to_vehicle_yaw - facing_yaw );
    
    if ( var_8b6714ee2b009ebe && abs( angle_diff ) > 45 )
    {
        return anim.failure;
    }
    
    if ( !self islinked() )
    {
        return anim.failure;
    }
    
    jumpdata = spawnstruct();
    jumpdata.vehicle = player_vehicle;
    jumpdata.prevvehicle = vehicle;
    points = player_vehicle function_1586434511dd01c5( self );
    var_c2bda762e264b1cb = 99999999;
    
    foreach ( index, point in points )
    {
        var_513f906a77bfa122 = distancesquared( point, self.origin );
        
        if ( var_513f906a77bfa122 <= 57600 )
        {
            jumpdata.index = index;
            jumpdata.point = point;
            var_c2bda762e264b1cb = var_513f906a77bfa122;
            break;
        }
    }
    
    if ( !isdefined( jumpdata.point ) )
    {
        return anim.failure;
    }
    
    foreach ( rider in vehicle.riders )
    {
        if ( self != rider )
        {
            drivercanjump = vehicle.health < 25;
            
            if ( rider.vehicle_position != 0 || drivercanjump )
            {
                if ( distancesquared( jumpdata.point, rider.origin ) < var_c2bda762e264b1cb )
                {
                    return anim.failure;
                }
            }
        }
    }
    
    vehicle_yaw = angleclamp180( player_vehicle.angles[ 1 ] );
    angles = vectortoangles( self.origin - jumpdata.point );
    yaw = angleclamp180( angles[ 1 ] );
    yaw_diff = angleclamp180( yaw - vehicle_yaw );
    
    if ( yaw_diff < 82 && yaw_diff > -82 || yaw_diff > 98 || yaw_diff < -98 )
    {
        return anim.failure;
    }
    
    self.jumpdata = jumpdata;
    player_vehicle.jumperrider = self;
    level.var_48069d79f75860a8 = gettime() + 20000;
    cap::cap_start( "vehicle_jumper", player_vehicle.vehicleanimalias );
    vehicle.riders = arrayremove( vehicle.riders, self );
    vehicle_occupancy::update_occupancy( self );
    return anim.success;
}

// Namespace combat
// Params 1
// Checksum 0x6a9cd12, Offset: 0x955
// Size: 0x8e
function VehicleMayMelee( taskid )
{
    vehicle = self._blackboard.currentvehicle;
    
    if ( !isdefined( vehicle ) )
    {
        return anim.failure;
    }
    
    pos = self._blackboard.var_25799974c1f2939b;
    aianims = vehicle_aianim::anim_pos( vehicle, pos );
    
    if ( !aianims.canmeleeinvehicle )
    {
        return anim.failure;
    }
    
    return anim.success;
}

// Namespace combat
// Params 1
// Checksum 0x7c36ae70, Offset: 0x9ec
// Size: 0x120
function updateeveryframe_noncombat( taskid )
{
    asm_bb::bb_requestweapon( weaponclass( self.primaryweapon ) );
    whizbyevent = asm::asm_getephemeraleventdata( "ai_notify", "bulletwhizby" );
    
    if ( isdefined( whizbyevent ) )
    {
        if ( !self.disablebulletwhizbyreaction )
        {
            whizbyenemy = whizbyevent[ 0 ];
            enemynear = isdefined( whizbyenemy ) && distancesquared( self.origin, whizbyenemy.origin ) < 160000;
            
            if ( enemynear || utility::cointoss() )
            {
                self._blackboard.whizbyeventtime = gettime() - 50;
            }
        }
    }
    else
    {
        var_aa1811af1a698594 = 100;
        
        if ( isdefined( self._blackboard.whizbyeventtime ) && gettime() > self._blackboard.whizbyeventtime + var_aa1811af1a698594 )
        {
            self._blackboard.whizbyeventtime = undefined;
        }
    }
    
    self.looktarget = undefined;
    return anim.success;
}

// Namespace combat
// Params 0
// Checksum 0x6ed0deff, Offset: 0xb15
// Size: 0x1a
function shouldbefrantic()
{
    if ( isdefined( self.frantic ) )
    {
        return self.frantic;
    }
    
    return 0;
}

// Namespace combat
// Params 0
// Checksum 0xafdc0377, Offset: 0xb38
// Size: 0x4c, Type: bool
function hasammoinclip()
{
    turret = getusedturret();
    
    if ( isdefined( turret ) )
    {
        return true;
    }
    
    if ( !isdefined( self.weapon ) )
    {
        return false;
    }
    
    if ( self.bulletsinclip > 0 || self.disablereload )
    {
        return true;
    }
    
    return false;
}

// Namespace combat
// Params 2
// Checksum 0x593d41fb, Offset: 0xb8d
// Size: 0x33
function islowonammo( task, params )
{
    if ( utility_common::needtoreload( params ) )
    {
        return anim.success;
    }
    
    return anim.failure;
}

// Namespace combat
// Params 2
// Checksum 0x71b01aea, Offset: 0xbc9
// Size: 0x68
function withindistancetoenemy( task, params )
{
    if ( !isdefined( self.enemy ) )
    {
        return anim.failure;
    }
    
    if ( distancesquared( self.origin, self.enemy.origin ) <= params * params )
    {
        return anim.success;
    }
    
    return anim.failure;
}

// Namespace combat
// Params 1
// Checksum 0x1f005422, Offset: 0xc3a
// Size: 0x69
function mayshoot( task )
{
    if ( !isdefined( self.weapon ) )
    {
        return anim.failure;
    }
    
    bshouldshoot = shouldshoot();
    
    if ( bshouldshoot )
    {
        bshouldshoot = calcgoodshootpos();
    }
    else
    {
        self.goodshootpos = undefined;
    }
    
    if ( !bshouldshoot )
    {
        return anim.failure;
    }
    
    return anim.success;
}

// Namespace combat
// Params 1
// Checksum 0xabbd8891, Offset: 0xcac
// Size: 0x3d
function updatelooktarget( taskid )
{
    if ( self.looktarget != self.enemy )
    {
        self.looktarget = self.enemy;
    }
    
    return anim.success;
}

// Namespace combat
// Params 0
// Checksum 0xa442853, Offset: 0xcf2
// Size: 0x17
function shoot_clearconvergence()
{
    self._blackboard.shootparams_bconvergeontarget = 0;
}

// Namespace combat
// Params 0
// Checksum 0xee676694, Offset: 0xd11
// Size: 0x18
function shoot_enableconvergence()
{
    self._blackboard.shootparams_bconvergeontarget = 1;
}

// Namespace combat
// Params 0
// Checksum 0xb2531262, Offset: 0xd31
// Size: 0x15, Type: bool
function isaimedataimtarget()
{
    return isdefined( self.asmtrackasm ) && self aimedataimtarget();
}

// Namespace combat
// Params 1
// Checksum 0xa979f4a0, Offset: 0xd4f
// Size: 0x38, Type: bool
function hasatleastammo( threshold )
{
    if ( isnullweapon( self.weapon ) )
    {
        return false;
    }
    
    return self.bulletsinclip >= weaponclipsize( self.weapon ) * threshold;
}

// Namespace combat
// Params 0
// Checksum 0x340739cd, Offset: 0xd90
// Size: 0x4d
function reload_cheatammo()
{
    clipsize = weaponclipsize( self.weapon );
    self.bulletsinclip = int( clipsize * 0.5 );
    self.bulletsinclip = int( clamp( self.bulletsinclip, 0, clipsize ) );
}

// Namespace combat
// Params 0
// Checksum 0xe3d8db69, Offset: 0xde5
// Size: 0x2f, Type: bool
function shouldbeajerk()
{
    if ( !isdefined( level.gameskill ) )
    {
        return false;
    }
    
    return level.gameskill == 3 && isplayer( self.enemy );
}

// Namespace combat
// Params 1
// Checksum 0xa752fefe, Offset: 0xe1d
// Size: 0x34, Type: bool
function shoulddosemiforvariety( distancesq )
{
    choice = randomfloat( 1 );
    var_cfe1fa85e264c775 = shoulddosemiprobabilityline( distancesq );
    return choice <= var_cfe1fa85e264c775;
}

// Namespace combat
// Params 1
// Checksum 0x940d0c47, Offset: 0xe5a
// Size: 0x2e
function shoulddosemiprobabilityline( distancetotarget )
{
    if ( distancetotarget < 2.56e+06 )
    {
        return -1;
    }
    
    return -4.65839e-08 * distancetotarget - -0.119255 + 0.5;
}

// Namespace combat
// Params 0
// Checksum 0x7c6a7687, Offset: 0xe91
// Size: 0x1b
function getusedturret()
{
    if ( isdefined( self.fngetusedturret ) )
    {
        return [[ self.fngetusedturret ]]();
    }
}

// Namespace combat
// Params 0
// Checksum 0xd1ecd094, Offset: 0xeb4
// Size: 0xc3, Type: bool
function shouldshoot()
{
    if ( !self aimayshoot() )
    {
        return false;
    }
    
    if ( self._blackboard.partialgestureplaying )
    {
        /#
            if ( getdvarint( @"hash_3493aa8adc34457e", 0 ) )
            {
                print3d( self.origin - ( 0, 0, 12 ), "<dev string:x24>", ( 1, 0, 0 ), 1, 0.75 );
            }
        #/
        
        return false;
    }
    
    if ( self function_a62d6fc00d9d45ff() )
    {
        /#
            if ( getdvarint( @"hash_3493aa8adc34457e", 0 ) )
            {
                print3d( self.origin - ( 0, 0, 12 ), "<dev string:x2e>", ( 1, 0, 0 ), 1, 0.75 );
            }
        #/
        
        return false;
    }
    
    return true;
}

// Namespace combat
// Params 0
// Checksum 0xae0d15aa, Offset: 0xf80
// Size: 0x98
function calcgoodshootpos()
{
    if ( self cansee( self.enemy ) )
    {
        if ( self canshootenemy() )
        {
            self.goodshootpos = self.enemy getshootatpos();
            return 1;
        }
    }
    
    bshouldshoot = utility_common::cansuppressenemy();
    
    /#
        if ( !bshouldshoot && getdvarint( @"hash_3493aa8adc34457e", 0 ) )
        {
            print3d( self.origin - ( 0, 0, 12 ), "<dev string:x44>", ( 1, 0, 0 ), 1, 0.75 );
        }
    #/
    
    return bshouldshoot;
}

// Namespace combat
// Params 1
// Checksum 0x15a144cc, Offset: 0x1021
// Size: 0x9e, Type: bool
function valid_reaction_sound( npcid )
{
    switch ( npcid )
    {
        case #"hash_31100bbc01bd3230":
        case #"hash_31100cbc01bd33c3":
        case #"hash_31100fbc01bd387c":
        case #"hash_311010bc01bd3a0f":
        case #"hash_311011bc01bd3ba2":
        case #"hash_311012bc01bd3d35":
        case #"hash_3689ba6c261f7001":
        case #"hash_9009aa6c552a085a":
        case #"hash_fa4482f6bd79a6ac":
        case #"hash_fa4484f6bd79a9d2":
        case #"hash_fa4485f6bd79ab65":
            return true;
    }
    
    return false;
}

// Namespace combat
// Params 1
// Checksum 0x2c064408, Offset: 0x10c8
// Size: 0x34
function turretrequested( task )
{
    if ( isdefined( asm_bb::bb_getrequestedturret() ) || isdefined( asm_bb::function_988e0cf7bedac7eb() ) )
    {
        return anim.success;
    }
    
    return anim.failure;
}

// Namespace combat
// Params 1
// Checksum 0xd3e96972, Offset: 0x1105
// Size: 0xb1
function ifshoulddosmartobject( taskid )
{
    smartobj = asm_bb::bb_getrequestedsmartobject();
    
    if ( !isdefined( smartobj ) )
    {
        return anim.failure;
    }
    
    if ( isdefined( self.disablesmartobjects ) )
    {
        return anim.failure;
    }
    
    zdiff = self.origin[ 2 ] - smartobj.origin[ 2 ];
    
    if ( zdiff * zdiff > 5184 )
    {
        return anim.failure;
    }
    
    if ( distance2dsquared( self.origin, smartobj.origin ) > 225 )
    {
        return anim.failure;
    }
    
    return anim.success;
}

// Namespace combat
// Params 1
// Checksum 0x5c76e67c, Offset: 0x11bf
// Size: 0x5e
function dosmartobject_init( taskid )
{
    asm_bb::bb_requestplaysmartobject();
    
    if ( isdefined( self.customarrivalangles ) )
    {
        self.customarrivalangles = undefined;
    }
    
    self.bt.instancedata[ taskid ] = self.disableautolookat;
    self.disableautolookat = 1;
    return anim.success;
}

// Namespace combat
// Params 1
// Checksum 0x18474d82, Offset: 0x1226
// Size: 0x4c
function dosmartobject( taskid )
{
    if ( self asmephemeraleventfired( "smartobject", "finished" ) )
    {
        smartobj = asm_bb::bb_getrequestedsmartobject();
        smartobj utility::smartobject_setnextuse();
        return anim.success;
    }
    
    return anim.running;
}

// Namespace combat
// Params 1
// Checksum 0xf8cb6f2a, Offset: 0x127b
// Size: 0x4e
function dosmartobjectterminate( taskid )
{
    utility::clearsmartobject( asm_bb::bb_getrequestedsmartobject() );
    self.disableautolookat = self.bt.instancedata[ taskid ];
    self.bt.instancedata[ taskid ] = undefined;
}

// Namespace combat
// Params 0
// Checksum 0xc994294b, Offset: 0x12d1
// Size: 0x1d4
function low_cover_combat_areas()
{
    if ( level.low_cover_combat_setup )
    {
        return;
    }
    
    level.low_cover_combat_setup = 1;
    
    /#
        setdvarifuninitialized( @"hash_e9e10e8b10abb8b", 0 );
    #/
    
    while ( true )
    {
        lowareas = getentarray( "low_cover_area", #targetname );
        
        foreach ( player in level.players )
        {
            covervol = undefined;
            
            foreach ( vol in lowareas )
            {
                if ( vol.disabled )
                {
                    continue;
                }
                
                if ( ispointinvolume( player.origin, vol ) )
                {
                    covervol = vol;
                    break;
                }
            }
            
            if ( isdefined( player.lowcovervolume ) && player.lowcovervolume != covervol )
            {
                player notify( #"hash_96bdb41be3310f11" );
                player.underlowcover = 0;
            }
            
            if ( isdefined( covervol ) && covervol != player.lowcovervolume )
            {
                player thread transfer_damage_to_player( covervol );
                player thread player_under_low_cover_monitor( covervol );
            }
            
            player.lowcovervolume = covervol;
        }
        
        waitframe();
    }
}

// Namespace combat
// Params 1
// Checksum 0xd920d7c4, Offset: 0x14ad
// Size: 0x10e
function player_under_low_cover_monitor( vol )
{
    self endon( #"hash_96bdb41be3310f11" );
    self endon( #"death" );
    dotrace = 1;
    
    if ( vol.script_trace == 0 )
    {
        dotrace = 0;
    }
    
    while ( true )
    {
        if ( dotrace && !trace::ray_trace_passed( self.origin, self.origin + ( 0, 0, 60 ), self ) )
        {
            self.underlowcover = 1;
        }
        else if ( !dotrace && ispointinvolume( self.origin, vol ) )
        {
            self.underlowcover = 1;
        }
        else
        {
            self.underlowcover = 0;
        }
        
        /#
            if ( getdvarint( @"hash_e9e10e8b10abb8b" ) && self.underlowcover )
            {
                line( self.origin, vol.origin, ( 1, 1, 1 ), 1, 0, 3 );
            }
        #/
        
        wait 0.15;
    }
}

// Namespace combat
// Params 1
// Checksum 0xc21bf0f, Offset: 0x15c3
// Size: 0x185
function transfer_damage_to_player( vol )
{
    self endon( #"hash_96bdb41be3310f11" );
    self endon( #"death" );
    dmg_trig = vol utility::get_linked_ents()[ 0 ];
    
    if ( !isdefined( dmg_trig ) )
    {
        return;
    }
    
    first_shot = 1;
    
    while ( isdefined( dmg_trig ) )
    {
        dmg_trig waittill( #"damage", amt, attacker, dir, point, type, modelname, tagname, partname, dflags, objweapon );
        
        if ( !isalive( attacker ) )
        {
            continue;
        }
        
        if ( attacker == self )
        {
            continue;
        }
        
        if ( !self istouching( dmg_trig ) )
        {
            continue;
        }
        
        if ( type == "MOD_MELEE" )
        {
            continue;
        }
        
        if ( issubstr( type, "BULLET" ) )
        {
            forward = anglestoforward( attacker gettagangles( "tag_flash" ) );
            normal = vectornormalize( self geteye() - attacker gettagorigin( "tag_flash" ) );
            
            if ( vectordot( forward, normal ) < 0.9 )
            {
                continue;
            }
            
            if ( first_shot )
            {
                first_shot = 0;
                wait 2;
                continue;
            }
        }
        
        self dodamage( amt, attacker.origin, attacker, attacker, type, attacker.weapon );
    }
}

