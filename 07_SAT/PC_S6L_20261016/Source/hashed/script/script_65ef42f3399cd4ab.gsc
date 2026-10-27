// script_65ef42f3399cd4ab  (hash_65ef42f3399cd4ab.gscc) (size: 4353 Bytes / 0x1101 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb045c122 (2957361442)
// size ...... 4353 (0x1101)
// includes .. 7   (offset: 0x1085)
// strings ... 5   (offset: 0x10bd)
// dev strs .. 0   (offset: 0x1101)
// exports ... 10  (offset: 0xc51)
// cseg ...... 0xab + 0xba6 (0xc51)
// imports ... 22  (offset: 0xde1)
// animtree1 . 0   (offset: 0x1101)
// animtree2 . 0   (offset: 0x1101)
#using scripts\asm\asm;
#using scripts\common\vehicle;
#using scripts\common\vehicle_aianim;
#using scripts\common\vehicle_code;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_occupancy;
#using scripts\vehicle\vehicle_common;

#namespace vehicle;

// Namespace vehicle
// Params 1
// Checksum 0x73c04b8d, Offset: 0xc9
// Size: 0x6c
function function_89446cc14c5a287f( taskid )
{
    self._blackboard.var_d8b9e2ebdf7d6e95 = 1;
    vehicle = self._blackboard.currentvehicle;
    vehicle.var_2c1b14ee4b7cd97c[ self._blackboard.var_84de977d30197688 ] = 1;
    return anim.success;
}

// Namespace vehicle
// Params 1
// Checksum 0x1bed79f7, Offset: 0x13e
// Size: 0x3e
function function_12a3fec25588b428( taskid )
{
    if ( self._blackboard.var_25799974c1f2939b == self._blackboard.var_84de977d30197688 )
    {
        return;
    }
    
    vehicle_common::function_134a8f5d5a23d3cb();
}

// Namespace vehicle
// Params 3
// Checksum 0xe09cff25, Offset: 0x184
// Size: 0x45, Type: bool
function isvalidanimation( statename, fromalias, toalias )
{
    alias = fromalias + "_to_" + toalias;
    
    if ( asm::asm_hasalias( statename, alias ) )
    {
        return true;
    }
    
    return false;
}

// Namespace vehicle
// Params 3
// Checksum 0x8c30f20c, Offset: 0x1d2
// Size: 0x110
function function_cdfbbe01448f7481( vehicleinfo, vehicle, var_64bbd5e0cb8e2152 )
{
    var_c16e5810ba8efa15 = "vehicle_idle_change_seats";
    
    for ( i = 0; i < vehicleinfo.size ; i++ )
    {
        if ( !vehicle.usedpositions[ i ] && !vehicle.var_2c1b14ee4b7cd97c[ i ] && !vehicleinfo[ i ].var_14f441f730dc229d )
        {
            if ( vehicleinfo[ var_64bbd5e0cb8e2152 ].seataliasoverride )
            {
                fromseatalias = vehicleinfo[ var_64bbd5e0cb8e2152 ].seataliasoverride;
            }
            else
            {
                fromseatalias = string( var_64bbd5e0cb8e2152 );
            }
            
            if ( vehicleinfo[ i ].seataliasoverride )
            {
                var_e83d03dc323bde06 = vehicleinfo[ i ].seataliasoverride;
            }
            else
            {
                var_e83d03dc323bde06 = string( i );
            }
            
            if ( isvalidanimation( var_c16e5810ba8efa15, fromseatalias, var_e83d03dc323bde06 ) )
            {
                self._blackboard.var_d26a80bcdfbf2fc1 = -1;
                return i;
            }
        }
    }
    
    return -1;
}

// Namespace vehicle
// Params 3
// Checksum 0x2044b40e, Offset: 0x2eb
// Size: 0xa9
function function_7435701a71a72200( vehicleyaw, enemyorigin, fromorigin )
{
    toenemy = enemyorigin - fromorigin;
    toenemy = self.enemy.origin - self.origin;
    toenemyyaw = angleclamp180( vectortoyaw( toenemy ) - self.angles[ 1 ] );
    
    if ( toenemyyaw > 135 )
    {
        return 2;
    }
    
    if ( toenemyyaw > 45 )
    {
        return 4;
    }
    
    if ( toenemyyaw > -45 )
    {
        return 8;
    }
    
    if ( toenemyyaw > -135 )
    {
        return 6;
    }
    
    return 2;
}

// Namespace vehicle
// Params 5
// Checksum 0x7aca785, Offset: 0x39c
// Size: 0x2d2
function function_195f4b7a210d6416( enemylocation, vehicleinfo, vehicle, var_64bbd5e0cb8e2152, var_93ecb85b8b30a792 )
{
    var_ce18e57bbe4f6b9e = "vehicle_combat_change_seats";
    bestseatindex = -1;
    bestdist = 9999999;
    
    for ( i = 0; i < vehicleinfo.size ; i++ )
    {
        if ( !vehicle.usedpositions[ i ] && !vehicle.var_2c1b14ee4b7cd97c[ i ] && vehicleinfo[ i ].canshootinvehicle )
        {
            seattag = vehicleinfo[ i ].sittag;
            seatorg = vehicle gettagorigin( seattag );
            
            if ( isdefined( vehicleinfo[ i ].linkoffset ) )
            {
                seatorg += rotatevector( vehicleinfo[ i ].linkoffset, vehicle.angles );
            }
            
            seatdist = distancesquared( seatorg, enemylocation );
            
            if ( vehicleinfo[ var_64bbd5e0cb8e2152 ].seataliasoverride )
            {
            }
            
            if ( vehicleinfo[ i ].seataliasoverride )
            {
                var_e83d03dc323bde06 = vehicleinfo[ i ].seataliasoverride;
            }
            else
            {
                var_e83d03dc323bde06 = string( i );
            }
            
            if ( seatdist < bestdist )
            {
                currdir = self._blackboard.vehicledir;
                
                if ( isdefined( self.enemy ) )
                {
                    vehicleyaw = vehicle.angles[ 1 ];
                    currdir = function_7435701a71a72200( vehicleyaw, self.enemy.origin, self.origin );
                    
                    if ( currdir == 0 )
                    {
                        currdir = 8;
                    }
                }
                else if ( currdir == 0 )
                {
                    currdir = 8;
                }
                
                alias = self._blackboard.chosenvehicleanimpos_seatalias + "_8_to_" + var_e83d03dc323bde06 + "_" + string( currdir );
                
                if ( asm::asm_hasalias( var_ce18e57bbe4f6b9e, alias ) )
                {
                    bestdist = seatdist;
                    bestseatindex = i;
                    hasanim = 1;
                    self._blackboard.var_84de977d30197688 = bestseatindex;
                    self._blackboard.vehicledir = 8;
                    self._blackboard.var_d26a80bcdfbf2fc1 = currdir;
                    break;
                }
                
                if ( !hasanim )
                {
                    alias = self._blackboard.chosenvehicleanimpos_seatalias + "_to_" + var_e83d03dc323bde06;
                    
                    if ( asm::asm_hasalias( var_ce18e57bbe4f6b9e, alias ) )
                    {
                        bestdist = seatdist;
                        bestseatindex = i;
                        self._blackboard.var_d26a80bcdfbf2fc1 = -1;
                    }
                }
            }
        }
    }
    
    return bestseatindex;
}

// Namespace vehicle
// Params 3
// Checksum 0xa5c8aeba, Offset: 0x677
// Size: 0x121
function function_ce5e3fc006465524( vehicleinfo, vehicle, var_64bbd5e0cb8e2152 )
{
    var_abc30b56e5a7fbc6 = "vehicle_idle_change_seats";
    
    for ( i = 0; i < vehicleinfo.size ; i++ )
    {
        if ( !vehicle.usedpositions[ i ] && !vehicle.var_2c1b14ee4b7cd97c[ i ] && vehicleinfo[ i ].var_14f441f730dc229d && vehicleinfo[ i ].canshootinvehicle )
        {
            if ( vehicleinfo[ var_64bbd5e0cb8e2152 ].seataliasoverride )
            {
                fromseatalias = vehicleinfo[ var_64bbd5e0cb8e2152 ].seataliasoverride;
            }
            else
            {
                fromseatalias = string( var_64bbd5e0cb8e2152 );
            }
            
            if ( vehicleinfo[ i ].seataliasoverride )
            {
                var_e83d03dc323bde06 = vehicleinfo[ i ].seataliasoverride;
            }
            else
            {
                var_e83d03dc323bde06 = string( i );
            }
            
            if ( isvalidanimation( var_abc30b56e5a7fbc6, fromseatalias, var_e83d03dc323bde06 ) )
            {
                self._blackboard.var_d26a80bcdfbf2fc1 = -1;
                return i;
            }
        }
    }
    
    return -1;
}

// Namespace vehicle
// Params 2
// Checksum 0xde20b00b, Offset: 0x7a1
// Size: 0x20d, Type: bool
function function_9f129e5ed99b329b( seatindex, vehicleinfo )
{
    if ( seatindex != -1 && seatindex != self._blackboard.var_a8ce6d0645e7aa2 )
    {
        self._blackboard.var_84de977d30197688 = seatindex;
        
        if ( vehicleinfo[ seatindex ].seataliasoverride )
        {
            self._blackboard.var_357610f2b1b38df6 = vehicleinfo[ seatindex ].seataliasoverride;
        }
        else
        {
            self._blackboard.var_357610f2b1b38df6 = string( seatindex );
        }
        
        self._blackboard.var_3b97675e43c4276d = 1;
        vehicleanimpos = vehicle_aianim::anim_pos( self._blackboard.currentvehicle, seatindex );
        
        if ( vehicleanimpos.var_14f441f730dc229d )
        {
            vehicledata = vehicle_occupancy::get_data( self._blackboard.currentvehicle get_ref() );
            
            foreach ( var_3cf992bebf42052a in vehicledata.seatdata )
            {
                if ( var_3cf992bebf42052a.animtag == vehicleanimpos.sittag )
                {
                    if ( self._blackboard.currentvehicle vehicle_damage::function_2b7271a5e9ac2ec6( var_3cf992bebf42052a.ref ) )
                    {
                        self._blackboard.currentvehicle vehicle_damage::destroy_door_window( var_3cf992bebf42052a.ref );
                    }
                    
                    break;
                }
            }
        }
        
        self._blackboard.var_93ecb85b8b30a792 = vehicleanimpos.var_14f441f730dc229d;
        return true;
    }
    
    return false;
}

// Namespace vehicle
// Params 1
// Checksum 0xe60b7ee5, Offset: 0x9b7
// Size: 0x299
function function_2b74cb18e598d79c( taskid )
{
    vehicle = self._blackboard.currentvehicle;
    vehicleinfo = level.vehicle.templates.aianims[ vehicle vehicle_code::get_vehicle_classname() ];
    
    if ( !isdefined( vehicle ) || !isdefined( vehicleinfo ) )
    {
        return anim.failure;
    }
    
    var_4aeed02a2868afe1 = istrue( self._blackboard.exitvehiclerequested );
    var_64bbd5e0cb8e2152 = int( self._blackboard.chosenvehicleanimpos_seatalias );
    currentseat = vehicleinfo[ var_64bbd5e0cb8e2152 ];
    var_93ecb85b8b30a792 = currentseat.var_14f441f730dc229d;
    var_3d189aa22108290c = istrue( self.var_3d189aa22108290c );
    var_ab639a1034a2a92c = var_93ecb85b8b30a792 && self._blackboard.var_ec9fcc2062506ba7;
    
    if ( self._blackboard.var_f74fb3b375109c97 && !var_4aeed02a2868afe1 )
    {
        var_f9c2abd9407ffd7 = function_ce5e3fc006465524( vehicleinfo, vehicle, var_64bbd5e0cb8e2152 );
        
        if ( function_9f129e5ed99b329b( var_f9c2abd9407ffd7, vehicleinfo ) )
        {
            return anim.success;
        }
    }
    else if ( var_ab639a1034a2a92c )
    {
        var_286a3900db5c4c3a = function_cdfbbe01448f7481( vehicleinfo, vehicle, var_64bbd5e0cb8e2152 );
        
        if ( function_9f129e5ed99b329b( var_286a3900db5c4c3a, vehicleinfo ) )
        {
            return anim.success;
        }
    }
    else if ( isdefined( self.enemy ) && isdefined( var_64bbd5e0cb8e2152 ) )
    {
        if ( var_4aeed02a2868afe1 || var_3d189aa22108290c )
        {
            var_286a3900db5c4c3a = function_cdfbbe01448f7481( vehicleinfo, vehicle, var_64bbd5e0cb8e2152 );
            
            if ( function_9f129e5ed99b329b( var_286a3900db5c4c3a, vehicleinfo ) )
            {
                return anim.success;
            }
        }
        else if ( !self._blackboard.var_ec9fcc2062506ba7 )
        {
            var_71402f4e0d79705f = function_195f4b7a210d6416( self.enemy.origin, vehicleinfo, vehicle, var_64bbd5e0cb8e2152, var_93ecb85b8b30a792 );
            
            if ( var_71402f4e0d79705f == -1 )
            {
                self._blackboard.var_d8b9e2ebdf7d6e95 = 0;
                return anim.failure;
            }
            else if ( function_9f129e5ed99b329b( var_71402f4e0d79705f, vehicleinfo ) )
            {
                return anim.success;
            }
        }
    }
    else if ( var_4aeed02a2868afe1 )
    {
        if ( var_93ecb85b8b30a792 )
        {
            var_286a3900db5c4c3a = function_cdfbbe01448f7481( vehicleinfo, vehicle, var_64bbd5e0cb8e2152 );
            
            if ( function_9f129e5ed99b329b( var_286a3900db5c4c3a, vehicleinfo ) )
            {
                return anim.success;
            }
        }
    }
    
    self._blackboard.var_d8b9e2ebdf7d6e95 = 0;
    return anim.failure;
}

