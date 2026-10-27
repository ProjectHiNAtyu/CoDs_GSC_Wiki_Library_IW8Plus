// scripts\mp\vehicles\damage.gsc  (hash_67554f1a4f439eb7.gscc) (size: 11584 Bytes / 0x2d40 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x89522b0e (2303863566)
// size ...... 11584 (0x2d40)
// includes .. 18  (offset: 0x2ad4)
// strings ... 22  (offset: 0x2b64)
// dev strs .. 16  (offset: 0x2c78)
// exports ... 17  (offset: 0x1da8)
// cseg ...... 0x1e2 + 0x1bc6 (0x1da8)
// imports ... 90  (offset: 0x2050)
// animtree1 . 0   (offset: 0x2d40)
// animtree2 . 0   (offset: 0x2d40)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_interact;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_omnvar_utility;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\damage;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\entity;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\damage;
#using scripts\mp\damagefeedback;
#using scripts\mp\events;

#namespace damage;

// Namespace damage
// Params 0
// Checksum 0xd33aa312, Offset: 0x200
// Size: 0x22
function init()
{
    if ( !isdefined( level.vehicles ) )
    {
        level.vehicles = spawnstruct();
    }
    
    init_damage_callback_data();
}

// Namespace damage
// Params 0
// Checksum 0x900e02db, Offset: 0x22a
// Size: 0xa5
function init_damage_callback_data()
{
    assert( isdefined( level.vehicles ), "<dev string:x24>" );
    level.vehicles.damagecallback = &callback_vehicledamage;
    level.vehicles.deathcallback = &callback_vehicledeath;
    data = spawnstruct();
    data.premoddamagecallbacks = [];
    data.postmoddamagecallbacks = [];
    data.deathcallbacks = [];
    data.var_4fd75520421f29dd = [];
    level.vehicles.damagecallbacks = data;
}

// Namespace damage
// Params 1
// Checksum 0x15ee652b, Offset: 0x2d7
// Size: 0x64
function get_pre_mod_damage_callback( ref )
{
    assert( isdefined( level.vehicles ), "<dev string:x6e>" );
    assert( isdefined( level.vehicles.damagecallbacks ), "<dev string:xb5>" );
    return level.vehicles.damagecallbacks.premoddamagecallbacks[ ref ];
}

// Namespace damage
// Params 1
// Checksum 0xe42838aa, Offset: 0x344
// Size: 0x64
function get_post_mod_damage_callback( ref )
{
    assert( isdefined( level.vehicles ), "<dev string:x10c>" );
    assert( isdefined( level.vehicles.damagecallbacks ), "<dev string:x154>" );
    return level.vehicles.damagecallbacks.postmoddamagecallbacks[ ref ];
}

// Namespace damage
// Params 1
// Checksum 0x4bb7e101, Offset: 0x3b1
// Size: 0x64
function get_death_callback( ref )
{
    assert( isdefined( level.vehicles ), "<dev string:x1ac>" );
    assert( isdefined( level.vehicles.damagecallbacks ), "<dev string:x1ea>" );
    return level.vehicles.damagecallbacks.deathcallbacks[ ref ];
}

// Namespace damage
// Params 1, eflags: 0x4
// Checksum 0xc81aa018, Offset: 0x41e
// Size: 0x64
function private function_e481109de5633970( ref )
{
    assert( isdefined( level.vehicles ), "<dev string:x238>" );
    assert( isdefined( level.vehicles.damagecallbacks ), "<dev string:x282>" );
    return level.vehicles.damagecallbacks.var_4fd75520421f29dd[ ref ];
}

// Namespace damage
// Params 2
// Checksum 0x2adba52e, Offset: 0x48b
// Size: 0x6f
function set_pre_mod_damage_callback( ref, func )
{
    assert( isdefined( level.vehicles ), "<dev string:x2dc>" );
    assert( isdefined( level.vehicles.damagecallbacks ), "<dev string:x323>" );
    level.vehicles.damagecallbacks.premoddamagecallbacks[ ref ] = func;
}

// Namespace damage
// Params 2
// Checksum 0xf9a01d1b, Offset: 0x502
// Size: 0x6f
function set_post_mod_damage_callback( ref, func )
{
    assert( isdefined( level.vehicles ), "<dev string:x37a>" );
    assert( isdefined( level.vehicles.damagecallbacks ), "<dev string:x3c2>" );
    level.vehicles.damagecallbacks.postmoddamagecallbacks[ ref ] = func;
}

// Namespace damage
// Params 2
// Checksum 0x6ebc6a0a, Offset: 0x579
// Size: 0x6f
function set_death_callback( ref, func )
{
    assert( isdefined( level.vehicles ), "<dev string:x41a>" );
    assert( isdefined( level.vehicles.damagecallbacks ), "<dev string:x458>" );
    level.vehicles.damagecallbacks.deathcallbacks[ ref ] = func;
}

// Namespace damage
// Params 2
// Checksum 0xb056d07a, Offset: 0x5f0
// Size: 0xde
function register_additional_death_callback( ref, func )
{
    assert( isdefined( level.vehicles ), "<dev string:x41a>" );
    assert( isdefined( level.vehicles.damagecallbacks ), "<dev string:x458>" );
    
    if ( !isdefined( level.vehicles.damagecallbacks.var_4fd75520421f29dd[ ref ] ) )
    {
        level.vehicles.damagecallbacks.var_4fd75520421f29dd[ ref ] = [];
    }
    
    level.vehicles.damagecallbacks.var_4fd75520421f29dd[ ref ] = arraycombineunique( level.vehicles.damagecallbacks.var_4fd75520421f29dd[ ref ], [ func ] );
}

// Namespace damage
// Params 14
// Checksum 0x78e30aac, Offset: 0x6d6
// Size: 0x114
function callback_vehicledamage( inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname, eventid )
{
    self endon( #"death" );
    data = damage_utility::packdamagedata( attacker, self, damage, objweapon, meansofdeath, inflictor, point, dir, modelindex, attachtagname, partname, undefined, dflags, eventid, hitloc );
    
    if ( inflictor.superinfo )
    {
        data.var_2b24a6314418af4 = inflictor.superinfo;
    }
    
    if ( inflictor.streakinfo )
    {
        data.var_9757ca0e774a004b = inflictor.streakinfo;
    }
    
    data.timeoffset = timeoffset;
    callback_vehicledamage_internal( data );
}

// Namespace damage
// Params 1
// Checksum 0x8baa4642, Offset: 0x7f2
// Size: 0x11c1
function callback_vehicledamage_internal( data )
{
    if ( isdefined( data.attacker ) && data.attacker.classname == "worldspawn" )
    {
        data.attacker = undefined;
    }
    
    if ( !isplayer( data.attacker ) )
    {
        if ( isdefined( data.attacker ) && isdefined( data.attacker.owner ) )
        {
            data.attacker = data.attacker.owner;
        }
        else if ( isdefined( data.inflictor ) )
        {
            if ( isplayer( data.inflictor ) )
            {
                data.attacker = data.inflictor;
            }
            else
            {
                data.attacker = data.inflictor.owner;
            }
        }
        else
        {
            data.attacker = undefined;
        }
    }
    
    if ( isdefined( level.hostmigrationtimer ) )
    {
        return;
    }
    
    if ( isdefined( data.attacker ) && !isdefined( _validateattacker( data.attacker ) ) )
    {
        return;
    }
    
    if ( game_utility_mp::getgamestate( data.attacker ) == "postgame" )
    {
        return;
    }
    
    if ( data.damage <= 0 )
    {
        return;
    }
    
    if ( vehicle::is_god() )
    {
        return;
    }
    
    if ( should_filter_out_friendly_damage( data ) && filter_out_friendly_damage( self, data.attacker ) )
    {
        vehicle_damage::function_a964146d900cef25( self, data );
        return;
    }
    
    if ( self.var_c82fdb1998fb5a8e )
    {
        vehicle_damage::function_eefd0f962152cc9f( self, data, data.damage );
        vehicle_damage::function_751760054809604d( data );
        return;
    }
    
    bulletdamage = utility::isbulletdamage( data.meansofdeath );
    
    if ( bulletdamage )
    {
        if ( isplayer( data.attacker ) && ( !isdefined( data.inflictor ) || data.inflictor == data.attacker || entity::isturret( data.inflictor ) ) )
        {
            attackervehicle = data.attacker vehicle::get_vehicle();
            
            if ( isdefined( data.attacker.externalvehicle ) )
            {
                attackervehicle = data.attacker.externalvehicle;
            }
            
            if ( !isdefined( level.var_90c6d74d480fb593 ) )
            {
                level.var_90c6d74d480fb593 = getdvarint( @"hash_de6cc6ced551f5f7", 0 );
            }
            
            if ( attackervehicle == self && ( level.var_90c6d74d480fb593 || !vehicle::is_enemy_to_player( self, data.attacker ) ) )
            {
                return;
            }
        }
    }
    
    if ( isexplosivedamagemod( data.meansofdeath ) && !vehicle_damage::function_f2a732b19943daa0( data ) )
    {
        return;
    }
    
    if ( self.bundle.equipmentinteractions )
    {
        utility::callsharedfunc( #"equipment_interaction", #"on_hit", self, data.attacker, data.inflictor, data.objweapon );
    }
    
    if ( utility::callsharedfunc( #"hash_f83d1f091b9a1e8e", #"isdefibrillator", data.objweapon ) )
    {
        return;
    }
    
    unmodifieddamage = data.damage;
    vehiclename = vehicle::get_ref();
    
    if ( isdefined( vehiclename ) )
    {
        premoddamagecallback = get_pre_mod_damage_callback( vehiclename );
        
        if ( isdefined( premoddamagecallback ) )
        {
            shouldcontinue = self [[ premoddamagecallback ]]( data );
            
            if ( !shouldcontinue )
            {
                vehicle_damage::function_a964146d900cef25( self, data );
                return;
            }
        }
    }
    
    if ( non_player_should_ignore_damage( data.attacker, data.objweapon, data.inflictor, data.meansofdeath ) )
    {
        return;
    }
    
    if ( isdefined( level.modifyvehicledamage ) )
    {
        data.damage = self [[ level.modifyvehicledamage ]]( data );
    }
    
    if ( isarray( level.var_6c2fb896a2ebe7d9 ) )
    {
        modified_damage = data.damage;
        
        foreach ( func in level.var_6c2fb896a2ebe7d9 )
        {
            new_damage = self [[ func ]]( data );
            
            if ( new_damage != -1 )
            {
                modified_damage = new_damage;
            }
        }
        
        data.damage = modified_damage;
    }
    
    if ( data.damage <= 0 )
    {
        return;
    }
    
    var_81430703f4f6c83d = vehicle_damage::function_eefd0f962152cc9f( self, data, data.damage );
    vehicle_damage::modify_vehicle_damage( data );
    
    if ( !level.var_deb9d2b3de25799b )
    {
        if ( data.meansofdeath == "MOD_MELEE" )
        {
            if ( killstreak::function_17736ca3e3ad4382( vehiclename ) )
            {
            }
            else
            {
                allowmeleedamage = 0;
                
                if ( isdefined( vehiclename ) && vehicle_damage::get_data( vehiclename ).allowmeleedamage )
                {
                    allowmeleedamage = 1;
                }
                
                if ( !allowmeleedamage && isdefined( level.modeallowmeleevehicledamage ) )
                {
                    allowmeleedamage = self [[ level.modeallowmeleevehicledamage ]]( data );
                }
                
                if ( !allowmeleedamage )
                {
                    data.damage = 0;
                }
            }
        }
        else if ( data.meansofdeath == "MOD_IMPACT" )
        {
            if ( isdefined( vehiclename ) && !vehicle_damage::get_data( vehiclename ).allowimpactdamage )
            {
                if ( killstreak::function_17736ca3e3ad4382( vehiclename ) || vehiclename == "assault_drone" || vehiclename == "ground_drone_unit" )
                {
                    if ( weapon::isthrowingknife( data.objweapon ) || weapon::isthrowingstar( data.objweapon ) )
                    {
                        data.damage = self.maxhealth;
                    }
                    else
                    {
                        data.damage = 0;
                    }
                }
                else if ( isdefined( vehiclename ) && weapon::function_33e74163843b348e( data.objweapon ) )
                {
                    data.damage = vehicle_damage::get_mod_damage( data.damage, self, data.objweapon, data.attacker );
                }
                else
                {
                    data.damage = 0;
                }
            }
        }
        else if ( isexplosivedamagemod( data.meansofdeath ) || data.meansofdeath == "MOD_FIRE" )
        {
            if ( isdefined( level.modeignorevehicleexplosivedamage ) && self [[ level.modeignorevehicleexplosivedamage ]]( data ) )
            {
                data.damage = 0;
            }
            else if ( issmallsplashdamage( data.objweapon ) && !isdefined( self.streakinfo ) )
            {
                data.damage = 0;
            }
            else if ( data.meansofdeath == "MOD_EXPLOSIVE_BULLET" && isdefined( vehiclename ) )
            {
                data.damage = vehicle_damage::get_mod_damage( data.damage, self, data.objweapon, data.attacker );
            }
            else if ( isdefined( vehiclename ) )
            {
                data.damage = vehicle_damage::get_hit_damage( data.damage, self, data.objweapon );
            }
        }
        else if ( bulletdamage )
        {
            if ( isspreadweapon( data.objweapon ) )
            {
                data.damage = spreadshotdamagemod( self, data.attacker, data.objweapon, data.damage, data.idflags );
                
                if ( isdefined( vehiclename ) )
                {
                    data.damage = vehicle_damage::get_mod_damage( data.damage, self, data.objweapon, data.attacker );
                }
            }
            else if ( damage_utility::iscrossbowdamage( data.objweapon ) )
            {
                if ( isdefined( vehiclename ) && ( killstreak::function_17736ca3e3ad4382( vehiclename ) || vehiclename == "assault_drone" ) )
                {
                    data.damage = self.maxhealth;
                }
                else if ( shouldcrossbowhitmarker( self, data ) )
                {
                    data.damage = 1;
                }
                else
                {
                    data.damage = 0;
                }
            }
            else
            {
                var_c04d36d92a6f0731 = vehicle_damage::get_hit_damage( data.damage, self, data.objweapon );
                
                if ( var_c04d36d92a6f0731 != data.damage )
                {
                    data.damage = var_c04d36d92a6f0731;
                }
                else if ( isdefined( vehiclename ) )
                {
                    data.damage = vehicle_damage::get_mod_damage( data.damage, self, data.objweapon, data.attacker ?? data.inflictor );
                }
            }
        }
    }
    
    if ( vehicle::is_demigod() )
    {
        minhealth = vehicle_damage::function_8c4b44320250db18( self, vehiclename ) + 1;
        maxdamage = self.health - minhealth;
        data.damage = min( maxdamage, data.damage );
        
        if ( data.damage <= 0 )
        {
            data.damage = 1;
            self.health += 1;
        }
    }
    
    if ( data.damage != 0 )
    {
        data.damage = max( 1, data.damage * var_81430703f4f6c83d );
    }
    
    vehicle_damage::log_event( self, data );
    
    if ( isdefined( vehiclename ) )
    {
        postmoddamagecallback = get_post_mod_damage_callback( vehiclename );
        
        if ( isdefined( postmoddamagecallback ) )
        {
            shouldcontinue = self [[ postmoddamagecallback ]]( data );
            
            if ( !shouldcontinue )
            {
                return;
            }
        }
    }
    
    vehicleref = vehicle::get_ref();
    
    if ( isdefined( vehicleref ) && !vehicle::isvehiclehusk() )
    {
        vehicledata = vehicle_damage::get_data( vehicleref );
        
        if ( isdefined( vehicledata ) && vehicledata.scrapassist )
        {
            killstreaks::updatescrapassistdata( data.attacker, data.damage );
        }
    }
    
    shouldskipburndown = vehicle_damage::function_bbbc556bc9d51672( data );
    
    if ( !shouldskipburndown )
    {
        damagestate = vehicle_damage::get_state();
        
        if ( damagestate == "heavy" )
        {
            damagemod = isexplosivedamagemod( data.meansofdeath ) || data.meansofdeath == "MOD_FIRE" ? 0.15 : 0.25;
            data.damage *= damagemod;
        }
    }
    
    vehicle_damage::update_state( data, shouldskipburndown, 1 );
    vehicle_damage::function_751760054809604d( data );
    vehicle_omnvar::function_ca8a66bb3a611610( self, data );
    thread vehicle_interact::on_damage( data );
    
    if ( !isdefined( data.damage ) || data.damage <= 0 )
    {
        assert( isdefined( data.damage ), "<dev string:x4a6>" );
        return;
    }
    
    if ( level.vehiclegod )
    {
        data.damage = 0;
    }
    
    non_player_log_attacker_data( data );
    
    if ( vehicle::is_killstreak() )
    {
        function_5c52d54234e3d0( data );
    }
    
    modifieddamage = data.damage;
    modifieddamageratio = 1 - max( unmodifieddamage - modifieddamage, 0 ) / unmodifieddamage;
    damageisfatal = data.damage >= self.health;
    iscriticaldamage = data.isrearcriticaldamage || data.issidecriticaldamage;
    hitmarkertype = "hitequip";
    
    if ( self.var_bdc51be80cbeef82 )
    {
        hitmarkertype = "hitextrahealth";
    }
    
    if ( getdvarint( @"hash_1db87c3b655b5645", 0 ) == 1 && damageisfatal )
    {
        hitmarkertype = "hitveharmorbreak";
    }
    else if ( level.projectbundle.var_4b0a96a3b624c9ec )
    {
        if ( data.var_cb916f2feae7c8bd )
        {
            hitmarkertype = "vehicleengine";
        }
        else if ( data.iswheeldamage )
        {
            hitmarkertype = "vehiclewheel";
        }
        else if ( data.isdoordamage )
        {
            hitmarkertype = "vehicledoor";
        }
        
        if ( data.var_1870b782aa5a399c )
        {
            hitmarkertype = "minigunmodule";
        }
        else if ( data.var_dd3e9795a8b0c772 )
        {
            hitmarkertype = "gasgrenademodule";
        }
        else if ( data.var_41e6bccd18c3ff31 )
        {
            hitmarkertype = "dronemodule";
        }
        
        if ( data.var_82d2e439f09ab8e2 )
        {
            hitmarkertype += data.var_82d2e439f09ab8e2;
        }
    }
    
    occupants = vehicle_occupancy::get_all_occupants( self, 0 );
    
    if ( occupants )
    {
        foreach ( player in occupants )
        {
            if ( isdefined( player.perks[ "specialty_repair_occupied_vehicle" ] ) )
            {
                hitmarkertype = "hitvehiclerepair";
                break;
            }
        }
    }
    
    if ( iscriticaldamage && isdefined( data.objweapon.basename ) )
    {
        switch ( data.objweapon.basename )
        {
            case #"hash_8c12df11df01f306":
                break;
            default:
                data.attacker thread points::givexpwithtext( #"critical_vehicle_damage" );
                break;
        }
    }
    
    targetent = -1;
    
    if ( getdvarint( @"hash_1db87c3b655b5645", 0 ) == 1 && !vehicle::isvehiclehusk() )
    {
        if ( damageisfatal )
        {
            deathpoint = spawn( "script_model", self.origin );
            deathpoint setentityowner( data.attacker );
            deathpoint utility::delaycall( 3, &delete );
            targetent = deathpoint getentitynumber();
        }
        else
        {
            targetent = self getentitynumber();
        }
    }
    
    if ( isdefined( data.attacker ) )
    {
        var_7731d58f6f82f082 = { #mod:data.meansofdeath, #direction_vec:data.direction_vec, #point:data.point, #objweapon:data.objweapon, #victim:self };
        data.attacker damagefeedback::updatedamagefeedback( hitmarkertype, damageisfatal, iscriticaldamage, "hitequip", undefined, 1, targetent, undefined, undefined, var_7731d58f6f82f082 );
    }
    
    vehicle_occupancy::update_damage_feedback( data );
    callback::callback( #"vehicle_damage", data );
    
    if ( damageisfatal )
    {
        if ( !isent( self ) )
        {
            return;
        }
        
        if ( isdefined( self.deathcallback ) )
        {
            self thread [[ self.deathcallback ]]( data.inflictor, data.attacker, data.damage, data.idflags, data.meansofdeath, data.objweapon, data.point, data.direction_vec, data.hitloc, data.timeoffset, data.modelindex, data.partname );
            return;
        }
        
        if ( isdefined( level.vehicles ) && isdefined( level.vehicles.deathcallback ) )
        {
            self thread [[ level.vehicles.deathcallback ]]( data );
            return;
        }
        
        self vehicle_finishdamage( data.inflictor, data.attacker, int( data.damage ), data.idflags, data.meansofdeath, data.objweapon, data.point, data.direction_vec, data.hitloc, data.timeoffset, data.modelname, #"tag_origin", data.partname );
        return;
    }
    
    self vehicle_finishdamage( data.inflictor, data.attacker, int( data.damage ), data.damageflags, data.meansofdeath, data.objweapon, data.point, data.direction_vec, data.hitloc, data.timeoffset, data.modelname, data.attachtagname, data.partname );
}

// Namespace damage
// Params 1
// Checksum 0xe9841f0f, Offset: 0x19bb
// Size: 0x1ed
function callback_vehicledeath( data )
{
    if ( !isdefined( data.attacker ) && isdefined( self.burndownattacker ) )
    {
        data.attacker = self.burndownattacker;
    }
    
    if ( ( !isdefined( data.objweapon ) || isnullweapon( data.objweapon ) ) && isdefined( self.burndownweapon ) )
    {
        data.objweapon = self.burndownweapon;
    }
    
    vehiclename = vehicle::get_ref();
    
    if ( isdefined( vehiclename ) )
    {
        var_4fd75520421f29dd = function_e481109de5633970( vehiclename );
        
        if ( isdefined( var_4fd75520421f29dd ) )
        {
            foreach ( callback in var_4fd75520421f29dd )
            {
                self thread [[ callback ]]( data );
            }
        }
        
        deathcallback = get_death_callback( vehiclename );
        
        if ( isdefined( deathcallback ) )
        {
            shouldcontinue = self [[ deathcallback ]]( data );
            
            if ( !shouldcontinue )
            {
                if ( isdefined( level.var_21c20150e6597b09 ) )
                {
                    [[ level.var_21c20150e6597b09 ]]( vehiclename, data.victim.team, data.attacker );
                }
                
                return;
            }
        }
    }
    
    self.health = 0;
    vehicle_damage::set_can_damage( 0 );
    vehicle_damage::clear_visuals( undefined, undefined, 1 );
    non_player_clear_attacker_data();
    events::vehiclekilled( data );
    
    if ( isdefined( level.var_21c20150e6597b09 ) )
    {
        [[ level.var_21c20150e6597b09 ]]( vehiclename, data.team, data.attacker );
    }
}

// Namespace damage
// Params 3
// Checksum 0xbfcd0aeb, Offset: 0x1bb0
// Size: 0xbd
function filter_out_friendly_damage( vehicle, attacker, team )
{
    if ( !isdefined( attacker ) && !isdefined( team ) )
    {
        return 0;
    }
    
    if ( vehicle_damage::is_owner_damage_enabled( vehicle ) )
    {
        if ( attacker == vehicle.owner )
        {
            return 0;
        }
    }
    
    ffenabled = level.vehiclefriendlydamage || 0;
    
    if ( level.teambased )
    {
        if ( !ffenabled )
        {
            if ( isdefined( team ) && !isdefined( attacker ) )
            {
                return vehicle::function_977daeae4e2f0e30( vehicle, team );
            }
            else
            {
                return vehicle::is_friendly_to_player( vehicle, attacker );
            }
        }
        
        return 0;
    }
    
    if ( !ffenabled )
    {
        if ( isdefined( attacker ) )
        {
            return vehicle::is_friendly_to_player( vehicle, attacker );
        }
        
        return 0;
    }
    
    return 0;
}

// Namespace damage
// Params 1
// Checksum 0xe080ce82, Offset: 0x1c75
// Size: 0x70, Type: bool
function should_filter_out_friendly_damage( data )
{
    if ( isdefined( data.objweapon ) )
    {
        basename = undefined;
        
        if ( isstring( data.objweapon ) )
        {
            basename = data.objweapon;
        }
        else
        {
            basename = data.objweapon.basename;
        }
        
        if ( basename == "nuke_mp" )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace damage
// Params 2
// Checksum 0x9085ab91, Offset: 0x1cee
// Size: 0xb9, Type: bool
function shouldcrossbowhitmarker( vehicle, data )
{
    if ( damage_utility::function_607262ae5e772af4( data.objweapon ) )
    {
        return true;
    }
    
    tags = vehicle_damage::function_f983e067957101f2( vehicle, data );
    
    foreach ( tagname in tags )
    {
        if ( vehicle_damage::is_crossbow_damage_location( vehicle, tagname, 0 ) )
        {
            return true;
        }
    }
    
    return false;
}

