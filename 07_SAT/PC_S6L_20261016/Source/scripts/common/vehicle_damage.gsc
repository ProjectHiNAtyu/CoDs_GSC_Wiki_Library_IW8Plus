// scripts\common\vehicle_damage.gsc  (hash_628cef0a0b5f8066.gscc) (size: 69119 Bytes / 0x10dff / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x798328d1 (2038638801)
// size ...... 69119 (0x10dff)
// includes .. 13  (offset: 0x10487)
// strings ... 108 (offset: 0x104ef)
// dev strs .. 42  (offset: 0x10bc7)
// exports ... 188 (offset: 0xb90b)
// cseg ...... 0x93a + 0xafd1 (0xb90b)
// imports ... 341 (offset: 0xd66b)
// animtree1 . 0   (offset: 0x10dff)
// animtree2 . 0   (offset: 0x10dff)
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\script;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_ai;
#using scripts\common\vehicle_interact;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_omnvar_utility;
#using scripts\common\vehicle_spawn;
#using scripts\common\vehicle_tracking;

#namespace vehicle_damage;

// Namespace vehicle_damage
// Params 1
// Checksum 0xb9eef53b, Offset: 0x958
// Size: 0xb8
function set_can_damage( bool )
{
    linkedents = self getlinkedchildren( 1 );
    
    if ( isdefined( linkedents ) )
    {
        foreach ( linkedent in linkedents )
        {
            if ( linkedent.code_classname == "misc_turret" )
            {
                linkedent setcandamage( bool );
            }
        }
    }
    
    self setcandamage( bool );
    function_8a2d9000eaf56a61( self );
}

// Namespace vehicle_damage
// Params 3
// Checksum 0x4b0569a6, Offset: 0xa18
// Size: 0x153
function get_data( vehicleref, create, var_e6c819f806ce2c86 )
{
    if ( create && ( !vehicle::has_data( vehicleref ) || !isdefined( vehicle::get_data( vehicleref ).damage ) || !isdefined( vehicle::get_data( vehicleref ).damage.class ) ) )
    {
        data = undefined;
        
        if ( !vehicle::has_data( vehicleref ) )
        {
            data = spawnstruct();
        }
        else
        {
            data = vehicle::get_data( vehicleref );
        }
        
        if ( !isdefined( data.damage ) )
        {
            data.damage = spawnstruct();
        }
        
        data.damage.damagestatedata = [];
        data.damage.class = "none";
        data.damage.visualpercents = [];
        data.damage.visualcallbacks = [];
        data.damage.visualclearcallbacks = [];
        vehicle::add_data( vehicleref, data );
    }
    
    if ( vehicle::has_data( vehicleref ) )
    {
        return vehicle::get_data( vehicleref ).damage;
    }
}

// Namespace vehicle_damage
// Params 3
// Checksum 0xf5e39224, Offset: 0xb73
// Size: 0xc5
function get_instance_data( vehicle, create, var_e6c819f806ce2c86 )
{
    instancedataforvehicle = vehicle.damagedata;
    
    if ( !isdefined( instancedataforvehicle ) )
    {
        if ( create )
        {
            instancedataforvehicle = spawnstruct();
            vehicle.damagedata = instancedataforvehicle;
            instancedataforvehicle.destroyscoreevent = undefined;
            instancedataforvehicle.destroyscorelaunchonly = undefined;
            instancedataforvehicle.destroyaward = undefined;
            instancedataforvehicle.destroyawardlaunchonly = undefined;
            instancedataforvehicle.heavydamagescoreevent = undefined;
            instancedataforvehicle.heavydamagescorelaunchonly = undefined;
            instancedataforvehicle.heavydamageaward = undefined;
            instancedataforvehicle.heavydamageawardlaunchonly = undefined;
        }
        else if ( !var_e6c819f806ce2c86 )
        {
            assertmsg( "<dev string:x24>" );
        }
    }
    
    return instancedataforvehicle;
}

// Namespace vehicle_damage
// Params 1
// Checksum 0xaa1ab6ee, Offset: 0xc41
// Size: 0x17
function deregister_instance( vehicle )
{
    vehicle.damagedata = undefined;
}

// Namespace vehicle_damage
// Params 4
// Checksum 0x86acba55, Offset: 0xc60
// Size: 0xa5
function function_9a9c7f377e631a4d( vehicleref, stateref, create, var_e6c819f806ce2c86 )
{
    leveldataforvehicle = get_data( vehicleref, create, var_e6c819f806ce2c86 );
    leveldatafordamagestate = leveldataforvehicle.damagestatedata[ stateref ];
    
    if ( !isdefined( leveldatafordamagestate ) )
    {
        if ( create )
        {
            leveldatafordamagestate = spawnstruct();
            leveldataforvehicle.damagestatedata[ stateref ] = leveldatafordamagestate;
            leveldatafordamagestate.onentercallback = undefined;
            leveldatafordamagestate.onexitcallback = undefined;
        }
        else if ( !var_e6c819f806ce2c86 )
        {
            assertmsg( "<dev string:x78>" );
        }
    }
    
    return leveldatafordamagestate;
}

// Namespace vehicle_damage
// Params 3
// Checksum 0x324f9893, Offset: 0xd0e
// Size: 0xb9
function clear_visuals( data, changed, fromdeath )
{
    leveldataforvehicle = get_data( vehicle::get_ref(), 0, 1 );
    
    if ( isdefined( leveldataforvehicle ) )
    {
        foreach ( callback in leveldataforvehicle.visualclearcallbacks )
        {
            self thread [[ callback ]]( data, changed, fromdeath );
        }
    }
}

// Namespace vehicle_damage
// Params 0
// Checksum 0x849e9117, Offset: 0xdcf
// Size: 0x12
function restore_max_health()
{
    add_health( self.maxhealth );
}

// Namespace vehicle_damage
// Params 1
// Checksum 0x480e9235, Offset: 0xde9
// Size: 0x62
function add_health( var_27f5fc9f07f89733 )
{
    set_current_health( min( self.health + var_27f5fc9f07f89733, self.maxhealth ) );
    leveldataforvehicle = get_data( vehicle::get_ref(), undefined, 1 );
    
    if ( !isdefined( leveldataforvehicle ) )
    {
        return;
    }
    
    update_state_internal( undefined, 0, 1 );
    vehicle_omnvar::function_ca8a66bb3a611610( self );
}

// Namespace vehicle_damage
// Params 1
// Checksum 0x20d94346, Offset: 0xe53
// Size: 0x4b
function set_health( healthtoset )
{
    set_current_health( healthtoset );
    leveldataforvehicle = get_data( vehicle::get_ref(), undefined, 1 );
    
    if ( !isdefined( leveldataforvehicle ) )
    {
        return;
    }
    
    update_state_internal( undefined, 0, 1 );
    vehicle_omnvar::function_ca8a66bb3a611610( self );
}

// Namespace vehicle_damage
// Params 1, eflags: 0x4
// Checksum 0x642b066c, Offset: 0xea6
// Size: 0x55
function private set_current_health( healthtoset )
{
    if ( utility::issp() )
    {
        var_c833e6f08a4e3e09 = clamp( healthtoset / self.maxhealth, 0, 1 );
        
        if ( var_c833e6f08a4e3e09 > 0 )
        {
            self setnormalhealth( var_c833e6f08a4e3e09 );
        }
        
        return;
    }
    
    self.health = int( healthtoset );
}

// Namespace vehicle_damage
// Params 8
// Checksum 0x38566892, Offset: 0xf03
// Size: 0x17c
function function_c95ff728d8d53bce( vehicle, player, idamage, idflags, shitloc, smeansofdeath, eattacker, objweapon )
{
    if ( !vehicle_occupancy::instance_is_registered( vehicle ) )
    {
        return idamage;
    }
    
    seatid = vehicle_occupancy::get_occupant_seat( vehicle, player );
    
    if ( !isdefined( seatid ) )
    {
        return idamage;
    }
    
    leveldataforvehicle = get_data( vehicle vehicle::get_ref() );
    seatdata = vehicle_occupancy::function_568cd324ac705619( vehicle vehicle::get_ref(), seatid );
    
    if ( isdefined( leveldataforvehicle.occupantdamagescale[ seatid ] ) )
    {
        idamage *= leveldataforvehicle.occupantdamagescale[ seatid ];
    }
    
    if ( isdefined( leveldataforvehicle.occupantdamageclamp[ seatid ] ) )
    {
        idamage = clamp( idamage, 0, leveldataforvehicle.occupantdamageclamp[ seatid ] );
    }
    
    if ( isdefined( seatdata ) && isdefined( seatdata.var_86386389c0f70b5d ) && isdefined( idflags ) && idflags & 8 && !( idflags & 16384 ) && !player isinvehicleleanout() && !( utility::callsharedfunc( #"damage", #"isheadshot", shitloc, smeansofdeath, eattacker ) && isdefined( objweapon ) && weaponclass( objweapon ) == "sniper" ) )
    {
        idamage *= seatdata.var_86386389c0f70b5d;
    }
    
    return idamage;
}

// Namespace vehicle_damage
// Params 15, eflags: 0x4
// Checksum 0x3afd42cd, Offset: 0x1088
// Size: 0x1a2
function private pack_damage_data( attacker, victim, damage, objweapon, meansofdeath, inflictor, point, direction_vec, modelname, attachtagname, partname, tagname, idflags, eventid, hitloc )
{
    struct = spawnstruct();
    struct.attacker = attacker;
    struct.victim = victim;
    struct.damage = damage;
    struct.objweapon = objweapon;
    struct.meansofdeath = meansofdeath;
    struct.inflictor = inflictor;
    struct.point = point;
    struct.direction_vec = direction_vec;
    struct.modelname = modelname;
    struct.attachtagname = attachtagname;
    struct.partname = partname;
    struct.tagname = tagname;
    struct.idflags = idflags;
    struct.damageflags = idflags;
    struct.eventid = eventid;
    struct.hitloc = hitloc;
    
    if ( isdefined( struct.attacker ) )
    {
        struct.attacker.assistedsuicide = 0;
    }
    
    return struct;
}

// Namespace vehicle_damage
// Params 4
// Checksum 0x9d5140dd, Offset: 0x1233
// Size: 0x6b
function function_7ff73b86270811a9( instance, note, param, var_64ffacba090c91be )
{
    instance.entity dodamage( int( instance.entity.maxhealth * param / 100 ), instance.entity.origin );
}

// Namespace vehicle_damage
// Params 0
// Checksum 0x7ad5c85d, Offset: 0x12a6
// Size: 0x43d
function watch_damage_notify()
{
    self endon( #"death" );
    ref = vehicle::get_ref();
    vehicledata = get_data( ref );
    
    while ( true )
    {
        unmodified_health = self.health;
        self waittill( #"damage", amount, attacker, direction_vec, damagelocation, meansofdeath, modelname, attachtagname, partname, dflags, objweapon, origin, angles, normal, inflictor, time );
        partname = vehicle::function_d88b357b027cbaed( partname );
        attachtagname = vehicle::function_d88b357b027cbaed( attachtagname );
        data = pack_damage_data( attacker, self, amount, objweapon, meansofdeath, inflictor, damagelocation, direction_vec, modelname, attachtagname, partname, dflags, undefined, damagelocation );
        
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
        
        if ( data.damage <= 0 )
        {
            continue;
        }
        
        if ( vehicle::is_god() || level.vehiclegod )
        {
            self.health = self.maxhealth;
            continue;
        }
        
        new_damage = data.damage;
        
        if ( data.objweapon && data.meansofdeath && ( utility::isbulletdamage( data.meansofdeath ) || isexplosivedamagemod( data.meansofdeath ) || data.meansofdeath == "MOD_FIRE" || data.meansofdeath == "MOD_IMPACT" ) )
        {
            new_damage = get_hit_damage( data.damage, self, data.objweapon );
            
            if ( data.damage == new_damage )
            {
                new_damage = get_mod_damage( data.damage, self, data.objweapon, data.attacker );
            }
        }
        
        if ( data.damage != new_damage )
        {
            data.damage = new_damage;
            var_c833e6f08a4e3e09 = clamp( ( unmodified_health - data.damage ) / self.maxhealth, 0, 1 );
            
            if ( var_c833e6f08a4e3e09 > 0 )
            {
                self setnormalhealth( var_c833e6f08a4e3e09 );
            }
        }
        else if ( vehicledata.var_dc3a1788b82d490d )
        {
            data.damage = 0;
            var_c833e6f08a4e3e09 = clamp( unmodified_health / self.maxhealth, 0, 1 );
            self setnormalhealth( var_c833e6f08a4e3e09 );
            continue;
        }
        
        callback::callback( #"vehicle_damage", data );
        var_81430703f4f6c83d = function_eefd0f962152cc9f( self, data, data.damage );
        log_event( self, data );
        update_state( data, 0, 1 );
        vehicle_omnvar::function_ca8a66bb3a611610( self, data );
        thread vehicle_interact::on_damage( data );
        vehicle_occupancy::update_damage_feedback( data );
    }
}

// Namespace vehicle_damage
// Params 0
// Checksum 0x8b33c31b, Offset: 0x16eb
// Size: 0x41
function watch_death_notify()
{
    self waittill( #"death" );
    
    if ( !isdefined( self ) || self.isdestroyed )
    {
        return;
    }
    
    if ( utility::issp() && self.var_e0b54303300bc72a )
    {
        return;
    }
    
    vehicle::explode();
}

// Namespace vehicle_damage
// Params 0
// Checksum 0x47d5ebca, Offset: 0x1734
// Size: 0x61e
function reactive_armor_think()
{
    self endon( #"death" );
    
    if ( !utility::issharedfuncdefined( #"game_utility", #"createProjectilePartition" ) )
    {
        return;
    }
    
    createProjectilePartition = utility::getsharedfunc( #"game_utility", #"createProjectilePartition" );
    reactiveArmorPiecesUsed = 2;
    
    if ( utility::callsharedfunc( #"game", #"isusingmatchrulesdata" ) )
    {
        reactiveArmorPiecesUsed = utility::callsharedfunc( #"game", #"getmatchrulesdata", "commonOption", "reactiveArmorPiecesUsed" );
    }
    
    create_reactive_armor_explosion();
    castcontents = physics_createcontents( [ "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_glass", "physicscontents_water", "physicscontents_item" ] );
    
    while ( true )
    {
        if ( !isdefined( self.reactivearmor ) || self.reactivearmor.size == 0 || !isdefined( self.origin ) )
        {
            break;
        }
        
        if ( self.reactivearmordisabled )
        {
            waitframe();
            continue;
        }
        
        friendlyteam = vehicle_occupancy::function_88fc32afbd317644( self );
        [[ createProjectilePartition ]]();
        
        foreach ( projectilearray in level.projectilepartition utility::function_92fef8fe5211a388( self.origin ) )
        {
            foreach ( projectile in projectilearray )
            {
                if ( !( isdefined( projectile ) && isdefined( projectile.origin ) ) )
                {
                    continue;
                }
                
                if ( distancesquared( projectile.origin, self.origin ) > 160000 )
                {
                    continue;
                }
                
                owner = projectile.owner;
                
                if ( !isdefined( owner ) && isdefined( projectile.weapon_name ) && weaponclass( projectile.weapon_name ) == "grenade" )
                {
                    owner = getmissileowner( projectile );
                }
                
                var_7abb8ea921e296dc = 1;
                
                /#
                    if ( getdvarint( @"hash_3c6c485214ca7673", 0 ) == 1 )
                    {
                        var_7abb8ea921e296dc = 0;
                    }
                #/
                
                if ( var_7abb8ea921e296dc && isdefined( owner ) && friendlyteam == owner.team )
                {
                    continue;
                }
                
                /#
                    if ( getdvarint( @"hash_b16f847dc3049239" ) )
                    {
                        sphere( projectile.origin, 15, ( 1, 0, 0 ) );
                    }
                #/
                
                projectileorigin = projectile.origin;
                
                foreach ( tagname, data in self.reactivearmor )
                {
                    tagorigin = self gettagorigin( tagname );
                    totag = projectileorigin - tagorigin;
                    angle = math::anglebetweenvectors( totag, anglestoforward( self gettagangles( tagname ) ) );
                    
                    if ( angle > 30 )
                    {
                        continue;
                    }
                    
                    castresults = physics_raycast( tagorigin, projectileorigin, castcontents, [ self, projectile ], 0, "physicsquery_closest" );
                    
                    if ( isdefined( castresults ) && castresults.size > 0 )
                    {
                        continue;
                    }
                    
                    isleft = issubstr( tagname, "left" );
                    
                    if ( reactiveArmorPiecesUsed > 1 )
                    {
                        randomkeys = arrayrandomize( getarraykeys( self.reactivearmor ) );
                        var_6c60e7be5bcaf3e0 = 0;
                        
                        foreach ( othertag in randomkeys )
                        {
                            data = self.reactivearmor[ othertag ];
                            
                            if ( othertag == tagname || issubstr( othertag, "left" ) != isleft )
                            {
                                continue;
                            }
                            
                            kill_part( self, othertag, undefined, 1 );
                            var_6c60e7be5bcaf3e0 += 1;
                            
                            if ( var_6c60e7be5bcaf3e0 >= reactiveArmorPiecesUsed - 1 )
                            {
                                break;
                            }
                        }
                    }
                    
                    kill_part( self, tagname, undefined, 1 );
                    
                    if ( isdefined( self.onreactivearmor ) )
                    {
                        self thread [[ self.onreactivearmor ]]();
                    }
                    
                    destroy_projectile( projectile );
                    break;
                }
            }
        }
        
        /#
            if ( getdvarint( @"hash_b16f847dc3049239" ) )
            {
                sphere( self.origin, 400, ( 0, 0, 1 ) );
                
                foreach ( tagname, data in self.reactivearmor )
                {
                    start = self gettagorigin( tagname );
                    end = start + anglestoforward( self gettagangles( tagname ) ) * 250;
                    line( start, end, ( 0, 0, 1 ) );
                }
            }
        #/
        
        waitframe();
    }
}

// Namespace vehicle_damage
// Params 1
// Checksum 0xb37701e8, Offset: 0x1d5a
// Size: 0x186
function destroy_projectile( target )
{
    target setcandamage( 0 );
    target.exploding = 1;
    target stopsounds();
    
    if ( !isdefined( target.owner ) )
    {
        return;
    }
    
    if ( isplayer( target.owner ) )
    {
        target.owner utility::callsharedfunc( #"damage", #"updatedamagefeedback", "reactivearmorexplosion" );
    }
    
    self.reactivearmorexplosion.origin = target.origin;
    up = target.origin - self.origin;
    right = up + ( 1, 0, 0 );
    forward = vectorcross( up, right );
    right = vectorcross( forward, up );
    self.reactivearmorexplosion.angles = axistoangles( forward, right, up );
    
    if ( self.explode1available )
    {
        self.reactivearmorexplosion setscriptablepartstate( "explode1", "activeDirectional", 0 );
        self.explode1available = 0;
    }
    else
    {
        self.reactivearmorexplosion setscriptablepartstate( "explode2", "activeDirectional", 0 );
        self.explode1available = 1;
    }
    
    if ( target.streakname == "cruise_predator" )
    {
        target notify( #"trophy_blocked" );
        return;
    }
    
    target delete();
}

// Namespace vehicle_damage
// Params 0, eflags: 0x4
// Checksum 0xdb60f2bd, Offset: 0x1ee8
// Size: 0x4f
function private create_reactive_armor_explosion()
{
    self.explode1available = 1;
    self.reactivearmorexplosion = spawnscriptable( vehicle::get_data( vehicle::get_ref() ).tank.reactivearmorexplosion ?? %"hash_7f2b644720862187", self.origin );
}

// Namespace vehicle_damage
// Params 1
// Checksum 0x42e1d59b, Offset: 0x1f3f
// Size: 0x1e
function get_all_parts( vehicleref )
{
    return get_data( vehicleref ).var_5e5dc92250389a1f;
}

// Namespace vehicle_damage
// Params 1
// Checksum 0x59f20e13, Offset: 0x1f66
// Size: 0x1e
function function_18d800e98361417f( vehicleref )
{
    return get_data( vehicleref ).var_4adaed6d37ec6c16;
}

// Namespace vehicle_damage
// Params 2
// Checksum 0x174c2cef, Offset: 0x1f8d
// Size: 0x37
function function_b84ee64d4e9bd27f( vehicleref, expdamageradiussq )
{
    leveldataforvehicle = get_data( vehicleref );
    leveldataforvehicle.expdamageradiussq = expdamageradiussq;
}

// Namespace vehicle_damage
// Params 2
// Checksum 0xbcc926f9, Offset: 0x1fcc
// Size: 0x1ca
function activate_parts( vehicle, spawndata )
{
    leveldataforvehicle = get_data( vehicle vehicle::get_ref(), 0, 1 );
    ishusk = vehicle vehicle::is_husk();
    tags = undefined;
    
    if ( isdefined( spawndata.damageableparts ) )
    {
        tags = spawndata.damageableparts;
    }
    else if ( ishusk )
    {
        tags = leveldataforvehicle.var_4adaed6d37ec6c16;
    }
    else
    {
        tags = leveldataforvehicle.var_5e5dc92250389a1f;
    }
    
    if ( isdefined( tags ) )
    {
        vehicle.damageableparts = [];
        
        foreach ( tagname, damageablepartdata in tags )
        {
            if ( damageablepartdata.inactive )
            {
                continue;
            }
            
            instancedata = { #damaged:damageablepartdata.damaged, #explosivedamagehealthvalue:damageablepartdata.explosivedamagehealthvalue, #healthvalue:damageablepartdata.healthvalue };
            vehicle.damageableparts[ tagname ] = instancedata;
            
            if ( damageablepartdata.isreactivearmor && !ishusk )
            {
                if ( !isdefined( vehicle.reactivearmor ) )
                {
                    vehicle.reactivearmor = [];
                }
                
                vehicle.reactivearmor[ tagname ] = instancedata;
            }
        }
    }
    
    if ( isdefined( vehicle.reactivearmor ) )
    {
        vehicle thread reactive_armor_think();
    }
}

// Namespace vehicle_damage
// Params 2
// Checksum 0xef4baad8, Offset: 0x219e
// Size: 0xf6
function activate_part( vehicle, tag )
{
    if ( !( isdefined( vehicle ) && isdefined( tag ) ) )
    {
        return 0;
    }
    
    data = get_data( vehicle vehicle::get_ref() );
    tags = undefined;
    
    if ( vehicle vehicle::is_husk() )
    {
        tags = data.var_4adaed6d37ec6c16;
    }
    else
    {
        tags = data.var_5e5dc92250389a1f;
    }
    
    if ( !isdefined( tags[ tag ] ) )
    {
        return 0;
    }
    
    damageablepartdata = spawnstruct();
    damageablepartdata.healthvalue = tags[ tag ].healthvalue;
    damageablepartdata.explosivedamagehealthvalue = tags[ tag ].explosivedamagehealthvalue;
    
    if ( !isdefined( vehicle.damageableparts ) )
    {
        vehicle.damageableparts = [];
    }
    
    vehicle.damageableparts[ tag ] = damageablepartdata;
    vehicle setscriptablepartstate( tag, "default" );
}

// Namespace vehicle_damage
// Params 1
// Checksum 0x23d21a13, Offset: 0x229c
// Size: 0xf9
function deactivate_wheels( vehicle )
{
    if ( !isdefined( vehicle ) || !vehicle vehicle::is_vehicle() )
    {
        return;
    }
    
    data = get_data( vehicle vehicle::get_ref() );
    
    if ( !isdefined( data ) )
    {
        return;
    }
    
    tags = vehicle vehicle::is_husk() ? data.var_4adaed6d37ec6c16 : data.var_5e5dc92250389a1f;
    
    if ( !isdefined( tags ) )
    {
        return;
    }
    
    foreach ( tagname, damageablepartdata in tags )
    {
        if ( isdefined( damageablepartdata.wheelref ) )
        {
            deactivate_part( vehicle, tagname );
        }
    }
}

// Namespace vehicle_damage
// Params 1
// Checksum 0x7a35eb4, Offset: 0x239d
// Size: 0xf9
function deactivate_doors( vehicle )
{
    if ( !isdefined( vehicle ) || !vehicle vehicle::is_vehicle() )
    {
        return;
    }
    
    data = get_data( vehicle vehicle::get_ref() );
    
    if ( !isdefined( data ) )
    {
        return;
    }
    
    tags = vehicle vehicle::is_husk() ? data.var_4adaed6d37ec6c16 : data.var_5e5dc92250389a1f;
    
    if ( !isdefined( tags ) )
    {
        return;
    }
    
    foreach ( tagname, damageablepartdata in tags )
    {
        if ( isdefined( damageablepartdata.doorref ) )
        {
            deactivate_part( vehicle, tagname );
        }
    }
}

// Namespace vehicle_damage
// Params 2
// Checksum 0xabd3e687, Offset: 0x249e
// Size: 0x47
function deactivate_part( vehicle, tag )
{
    if ( !( isdefined( vehicle ) && isdefined( tag ) ) )
    {
        return 0;
    }
    
    if ( !isdefined( vehicle.damageableparts[ tag ] ) )
    {
        return 0;
    }
    
    vehicle.damageableparts[ tag ] = undefined;
}

// Namespace vehicle_damage
// Params 1
// Checksum 0xc06d7465, Offset: 0x24ed
// Size: 0x22b
function function_45cd8b1d7ce8e74( vehicle )
{
    if ( !isdefined( vehicle ) || !vehicle vehicle::is_vehicle() || vehicle vehicle::is_husk() )
    {
        return;
    }
    
    data = vehicle::get_data( vehicle vehicle::get_ref() );
    tags = data.damage.var_5e5dc92250389a1f;
    
    if ( !( isdefined( data ) && isdefined( data.interact ) && isdefined( data.interact.lights ) && isdefined( vehicle.damageableparts ) && isdefined( tags ) ) )
    {
        return;
    }
    
    foreach ( tag, light in data.interact.lights )
    {
        if ( !isdefined( vehicle.damageableparts[ tag ] ) || !is_part_dead( vehicle.damageableparts[ tag ] ) )
        {
            continue;
        }
        
        if ( !isdefined( tags[ tag ] ) )
        {
            return;
        }
        
        vehicle.damageableparts[ tag ] = spawnstruct();
        vehicle.damageableparts[ tag ].healthvalue = tags[ tag ].healthvalue;
        vehicle.damageableparts[ tag ].explosivedamagehealthvalue = tags[ tag ].explosivedamagehealthvalue;
        state = "off";
        
        if ( vehicle.enginelightson )
        {
            if ( light.type == "engine_is_on_day_and_night" )
            {
                state = "on";
            }
            else if ( utility::isnightmap() && light.type == "engine_is_on_at_night" )
            {
                state = "on";
            }
        }
        
        vehicle setscriptablepartstate( tag, state );
        break;
    }
}

// Namespace vehicle_damage
// Params 3
// Checksum 0x271e0e0b, Offset: 0x2720
// Size: 0x438
function function_eefd0f962152cc9f( vehicle, damagedata, unmodifieddamage )
{
    damagemultiplier = 1;
    tagnames = function_f983e067957101f2( vehicle, damagedata );
    ref = vehicle vehicle::get_ref();
    vehicledata = get_data( ref );
    
    /#
        if ( getdvarint( @"hash_d6a84652bcb25596", 0 ) == 1 && tagnames.size > 0 )
        {
            string = "<dev string:xc3>";
            
            foreach ( tag in tagnames )
            {
                string += tag + "<dev string:xc9>";
            }
            
            string += "<dev string:xcc>" + unmodifieddamage;
            iprintlnbold( string );
        }
    #/
    
    foreach ( tagname in tagnames )
    {
        if ( !function_ea5f5ad915b3206f( vehicle, tagname, damagedata ) )
        {
            continue;
        }
        
        if ( isdefined( vehicledata.damageableparts[ tagname ].wheelref ) )
        {
            damagedata.iswheeldamage = 1;
        }
        else if ( isdefined( vehicledata.damageableparts[ tagname ].doorref ) )
        {
            damagedata.isdoordamage = 1;
        }
        
        if ( isexplosivedamagemod( damagedata.meansofdeath ) )
        {
            if ( vehicledata.damageableparts[ tagname ].var_5785352fb80e135c != 0 && !vehicle.damageableparts[ tagname ].damaged && function_badd1a49fc9ab374( vehicle, tagname ) )
            {
                damage_part( vehicle, tagname );
            }
            else
            {
                var_25fa5e5ade4d01a8 = vehicle.damageableparts[ tagname ].explosivedamagehealthvalue;
                var_1f8307fc54187c6d = var_25fa5e5ade4d01a8 - unmodifieddamage;
                vehicle.damageableparts[ tagname ].explosivedamagehealthvalue = max( 0, var_1f8307fc54187c6d );
            }
            
            if ( vehicledata.damageableparts[ tagname ].blockexplosivedamage )
            {
                damagemultiplier *= 0.33;
            }
        }
        else
        {
            var_78ab58f95a296c5d = vehicle.damageableparts[ tagname ].healthvalue;
            
            if ( level.gametypebundle.var_242026b9c3290bf8 > 1 && vehicle vehicle_ai::has_riders() && vehicledata.damageableparts[ tagname ].wheelref )
            {
                damage = max( 0, unmodifieddamage * level.gametypebundle.var_242026b9c3290bf8 - get_part_damage_reduction( ref, tagname ) );
            }
            else
            {
                damage = max( 0, unmodifieddamage - get_part_damage_reduction( ref, tagname ) );
            }
            
            var_c6bbfef8c7c86952 = max( 0, var_78ab58f95a296c5d - damage );
            vehicle.damageableparts[ tagname ].healthvalue = var_c6bbfef8c7c86952;
            
            if ( vehicledata.damageableparts[ tagname ].blockbulletdamage )
            {
                damagemultiplier = 0.0001;
            }
        }
        
        if ( is_part_dead( vehicle.damageableparts[ tagname ] ) )
        {
            kill_part( vehicle, tagname, damagedata );
            continue;
        }
        
        if ( vehicledata.damageableparts[ tagname ].var_8ff3785a03b4a866 != 0 && !vehicle.damageableparts[ tagname ].damaged && function_e2e7b1a840f99653( vehicle, tagname ) )
        {
            damage_part( vehicle, tagname );
        }
    }
    
    return damagemultiplier;
}

// Namespace vehicle_damage
// Params 1
// Checksum 0x5def890f, Offset: 0x2b61
// Size: 0x22
function function_2673f58d98e0d40b( tagname )
{
    return self.damageableparts[ tagname ].healthvalue;
}

// Namespace vehicle_damage
// Params 2
// Checksum 0x801af145, Offset: 0x2b8c
// Size: 0x2f7
function function_a964146d900cef25( vehicle, damagedata )
{
    ref = vehicle vehicle::get_ref();
    
    if ( !isdefined( ref ) )
    {
        return;
    }
    
    vehicledata = get_data( ref );
    
    if ( !isdefined( vehicledata ) )
    {
        return;
    }
    
    partdata = vehicledata.damageableparts;
    
    if ( !isdefined( partdata ) )
    {
        return;
    }
    
    tagnames = function_f983e067957101f2( vehicle, damagedata );
    
    /#
        if ( getdvarint( @"hash_d6a84652bcb25596", 0 ) == 1 && tagnames.size > 0 )
        {
            string = "<dev string:xc3>";
            
            foreach ( tag in tagnames )
            {
                string += tag + "<dev string:xc9>";
            }
            
            iprintlnbold( string );
        }
    #/
    
    foreach ( tagname in tagnames )
    {
        if ( function_ea5f5ad915b3206f( vehicle, tagname, damagedata ) )
        {
            if ( !( isdefined( partdata[ tagname ] ) && isdefined( partdata[ tagname ].windowref ) ) )
            {
                continue;
            }
            
            if ( isexplosivedamagemod( damagedata.meansofdeath ) )
            {
                var_1f8307fc54187c6d = vehicle.damageableparts[ tagname ].explosivedamagehealthvalue - damagedata.damage;
                vehicle.damageableparts[ tagname ].explosivedamagehealthvalue = max( 0, var_1f8307fc54187c6d );
            }
            else
            {
                damage = max( 0, damagedata.damage - get_part_damage_reduction( ref, tagname ) );
                var_c6bbfef8c7c86952 = max( 0, vehicle.damageableparts[ tagname ].healthvalue - damage );
                vehicle.damageableparts[ tagname ].healthvalue = var_c6bbfef8c7c86952;
            }
            
            if ( is_part_dead( vehicle.damageableparts[ tagname ] ) )
            {
                kill_part( vehicle, tagname, damagedata );
                continue;
            }
            
            if ( vehicledata.damageableparts[ tagname ].var_8ff3785a03b4a866 != 0 && !vehicle.damageableparts[ tagname ].damaged && function_e2e7b1a840f99653( vehicle, tagname ) )
            {
                damage_part( vehicle, tagname );
            }
        }
    }
}

// Namespace vehicle_damage
// Params 4
// Checksum 0x9d9fb63d, Offset: 0x2e8b
// Size: 0xa1
function function_ad39d0a9e71456f8( instance, note, param, var_64ffacba090c91be )
{
    part = function_41bec0232e24ee41( note, "damage vehicle part " );
    data = instance.entity.damageableparts[ part ];
    
    if ( isdefined( data ) && function_badd1a49fc9ab374( instance.entity, part ) && !data.damaged )
    {
        damage_part( instance.entity, part );
    }
}

// Namespace vehicle_damage
// Params 2
// Checksum 0x2dc2173f, Offset: 0x2f34
// Size: 0x3f
function damage_part( vehicle, tagname )
{
    vehicle.damageableparts[ tagname ].damaged = 1;
    vehicle setscriptablepartstate( tagname, "damaged", 1 );
}

// Namespace vehicle_damage
// Params 4
// Checksum 0x5d81d04, Offset: 0x2f7b
// Size: 0x87
function function_6757cfd75a460ed5( instance, note, param, var_64ffacba090c91be )
{
    part = function_41bec0232e24ee41( note, "kill vehicle part " );
    data = instance.entity.damageableparts[ part ];
    
    if ( isdefined( data ) && !is_part_dead( data ) )
    {
        kill_part( instance.entity, part );
    }
}

// Namespace vehicle_damage
// Params 4
// Checksum 0x23e23ae7, Offset: 0x300a
// Size: 0x278
function kill_part( vehicle, tagname, damagedata, reactivearmorexplosion )
{
    deathstatename = function_7b560d1e1dadd7e1( vehicle, tagname, reactivearmorexplosion );
    
    if ( vehicle getscriptableparthasstate( tagname, deathstatename ) )
    {
        vehicle setscriptablepartstate( tagname, deathstatename, 1 );
    }
    
    var_d6aa641e123523f4 = function_d1683f189b6bff40( vehicle vehicle::get_ref(), tagname );
    damageablepartdata = get_part_data( vehicle vehicle::get_ref() )[ tagname ];
    
    if ( isdefined( vehicle.damageableparts[ tagname ] ) )
    {
        vehicle.damageableparts[ tagname ].healthvalue = 0;
    }
    
    if ( isdefined( damageablepartdata ) && isdefined( damageablepartdata.wheelref ) )
    {
        if ( !isdefined( vehicle.deadwheels ) )
        {
            vehicle.deadwheels = [];
        }
        
        vehicle.deadwheels[ tagname ] = damageablepartdata;
    }
    
    if ( isdefined( damageablepartdata ) && isdefined( damageablepartdata.windowref ) && isdefined( damagedata ) && isplayer( damagedata.attacker ) )
    {
        isenemy = vehicle::is_enemy_to_player( vehicle, damagedata.attacker );
        callback::callback( "player_shatter_window", { #isenemy:isenemy, #vehicle:vehicle, #player:damagedata.attacker } );
    }
    
    if ( isdefined( damageablepartdata ) && isdefined( damageablepartdata.doorref ) )
    {
        if ( !isdefined( vehicle.var_6711e9077cf90709 ) )
        {
            vehicle.var_6711e9077cf90709 = [];
        }
        
        vehicle.var_6711e9077cf90709[ damageablepartdata.doorref ] = 1;
        
        if ( vehicle function_2b7271a5e9ac2ec6( damageablepartdata.doorref ) )
        {
            vehicle destroy_door_window( damageablepartdata.doorref );
        }
        
        occupant = vehicle_occupancy::get_seat_occupant( vehicle, damageablepartdata.doorref );
        
        if ( isdefined( occupant ) )
        {
            occupant val::set( "vehicle_occupant", "vehicle_lean_out", 0 );
            vehicle_omnvar::set_current_seat( vehicle, damageablepartdata.doorref, occupant );
        }
    }
    
    if ( isdefined( damageablepartdata ) && isdefined( vehicle.reactivearmor ) && damageablepartdata.isreactivearmor )
    {
        vehicle.reactivearmor[ tagname ] = undefined;
    }
    
    if ( isdefined( var_d6aa641e123523f4 ) )
    {
        vehicle thread [[ var_d6aa641e123523f4 ]]( vehicle, damagedata );
    }
}

// Namespace vehicle_damage
// Params 1
// Checksum 0x62d972e5, Offset: 0x328a
// Size: 0x2d, Type: bool
function is_door_alive( seatref )
{
    return !( isdefined( self ) && isdefined( self.var_6711e9077cf90709 ) ) || !self.var_6711e9077cf90709[ seatref ];
}

// Namespace vehicle_damage
// Params 2
// Checksum 0x2b9f9407, Offset: 0x32c0
// Size: 0xad
function function_c0997f62f7c7cbd8( vehicle, damagedata )
{
    if ( isdefined( vehicle.damageableparts ) )
    {
        foreach ( tagname, data in vehicle.damageableparts )
        {
            if ( !is_part_dead( data ) )
            {
                kill_part( vehicle, tagname, damagedata );
            }
        }
    }
}

// Namespace vehicle_damage
// Params 1
// Checksum 0x549e1d7d, Offset: 0x3375
// Size: 0xc2
function activate_all_parts( vehicle )
{
    data = get_data( vehicle vehicle::get_ref() );
    tags = undefined;
    
    if ( vehicle vehicle::is_husk() )
    {
        tags = data.var_4adaed6d37ec6c16;
    }
    else
    {
        tags = data.var_5e5dc92250389a1f;
    }
    
    foreach ( tag, data in tags )
    {
        activate_part( vehicle, tag );
    }
}

// Namespace vehicle_damage
// Params 1, eflags: 0x4
// Checksum 0x6bab572a, Offset: 0x343f
// Size: 0x1f8
function private function_4716d5b665e24428( vehicle )
{
    if ( isdefined( vehicle.damageableparts ) )
    {
        damageablepartdata = get_part_data( vehicle vehicle::get_ref() );
        
        if ( !isdefined( vehicle.var_e1bf31539c4e8995 ) || vehicle.var_e1bf31539c4e8995.size == 0 )
        {
            windowkeys = [];
            
            foreach ( tagname, data in vehicle.damageableparts )
            {
                if ( isdefined( damageablepartdata[ tagname ].windowref ) )
                {
                    windowkeys[ windowkeys.size ] = tagname;
                }
            }
            
            vehicle.var_e1bf31539c4e8995 = arrayrandomize( windowkeys );
        }
        
        foreach ( tagname in vehicle.var_e1bf31539c4e8995 )
        {
            data = vehicle.damageableparts[ tagname ];
            
            if ( !is_part_dead( data ) )
            {
                data.healthvalue = max( 0, data.healthvalue - randomintrange( 50, 125 ) );
                
                if ( is_part_dead( data ) )
                {
                    kill_part( vehicle, tagname );
                }
                
                vehicle.var_e1bf31539c4e8995 = arrayremove( vehicle.var_e1bf31539c4e8995, tagname );
                break;
            }
            
            vehicle.var_e1bf31539c4e8995 = arrayremove( vehicle.var_e1bf31539c4e8995, tagname );
        }
    }
}

// Namespace vehicle_damage
// Params 3
// Checksum 0xf32c0d4b, Offset: 0x363f
// Size: 0x7f
function hide_part( vehicle, tagname, damagedata )
{
    scriptablepartname = function_832c3ca9c66e59ba( vehicle vehicle::get_ref(), tagname );
    
    if ( vehicle getscriptableparthasstate( scriptablepartname, "hide" ) )
    {
        vehicle setscriptablepartstate( scriptablepartname, "hide" );
    }
    
    var_d6aa641e123523f4 = function_d1683f189b6bff40( vehicle vehicle::get_ref(), tagname );
    
    if ( isdefined( var_d6aa641e123523f4 ) )
    {
        vehicle thread [[ var_d6aa641e123523f4 ]]( vehicle, damagedata );
    }
}

// Namespace vehicle_damage
// Params 2
// Checksum 0xc4c3db40, Offset: 0x36c6
// Size: 0x21
function function_4d63793b20448722( vehicle, damagedata )
{
    set_tire_flat( vehicle, 0, damagedata );
}

// Namespace vehicle_damage
// Params 2
// Checksum 0x45832cf0, Offset: 0x36ef
// Size: 0x22
function function_4d53fdec4c872dbf( vehicle, damagedata )
{
    set_tire_flat( vehicle, 1, damagedata );
}

// Namespace vehicle_damage
// Params 2
// Checksum 0x5d21bd43, Offset: 0x3719
// Size: 0x22
function function_15797dca5168f05f( vehicle, damagedata )
{
    set_tire_flat( vehicle, 2, damagedata );
}

// Namespace vehicle_damage
// Params 2
// Checksum 0x321dfe02, Offset: 0x3743
// Size: 0x22
function function_769a396f81a9b18c( vehicle, damagedata )
{
    set_tire_flat( vehicle, 3, damagedata );
}

// Namespace vehicle_damage
// Params 2
// Checksum 0x9caf6285, Offset: 0x376d
// Size: 0x22
function function_7faccfa4db0c08bc( vehicle, damagedata )
{
    set_tire_flat( vehicle, 4, damagedata );
}

// Namespace vehicle_damage
// Params 2
// Checksum 0xa9b8b26b, Offset: 0x3797
// Size: 0x22
function function_7c170f3977150969( vehicle, damagedata )
{
    set_tire_flat( vehicle, 5, damagedata );
}

// Namespace vehicle_damage
// Params 2
// Checksum 0xb5947704, Offset: 0x37c1
// Size: 0x22
function function_cbacf54d43d06309( vehicle, damagedata )
{
    set_tire_flat( vehicle, 6, damagedata );
}

// Namespace vehicle_damage
// Params 2
// Checksum 0xdd205be6, Offset: 0x37eb
// Size: 0x22
function function_92c1df7b033bf896( vehicle, damagedata )
{
    set_tire_flat( vehicle, 7, damagedata );
}

// Namespace vehicle_damage
// Params 3, eflags: 0x4
// Checksum 0x6be40f83, Offset: 0x3815
// Size: 0x338
function private set_tire_flat( vehicle, tireindex, damagedata )
{
    isstatic = vehicle vehicle::is_static();
    
    if ( !isstatic )
    {
        vehicle blowuptire( tireindex );
    }
    
    if ( !isdefined( vehicle.flattiremask ) )
    {
        vehicle.flattiremask = 0;
    }
    
    vehicle.flattiremask |= 1 << tireindex;
    occupants = vehicle_occupancy::function_8ed9bcd8e9ea74f5( self, 0 );
    
    if ( isdefined( occupants ) )
    {
        foreach ( occupant in occupants )
        {
            function_5ca0c600bb09b1d2( vehicle, occupant );
        }
    }
    
    tagname = undefined;
    
    if ( isdefined( damagedata ) && isstring( damagedata.partname ) && damagedata.partname != "" )
    {
        tagname = damagedata.partname;
    }
    else if ( isdefined( damagedata ) && isstring( damagedata.attachtagname ) && damagedata.attachtagname != "" )
    {
        tagname = damagedata.attachtagname;
    }
    
    if ( !isstatic && isdefined( vehicle.origin ) && isdefined( tagname ) && vehicle vehicle_isphysveh() && !self hascomponent( "c2p" ) )
    {
        data = vehicle::get_data( vehicle vehicle::get_ref() );
        speed = vehicle vehicle_getspeed();
        maxspeed = vehicle vehicle_gettopspeedforward();
        force = math::normalize_value( 0, maxspeed / 2, speed );
        force = force * 0.8 + 0.2;
        force *= data.damage.var_a7bd60167008f054;
        self vehphys_impulse( vehicle.origin - vehicle gettagorigin( tagname ) + ( 0, 0, 300 ), int( 255 * force ), 1 );
    }
    
    if ( isdefined( damagedata ) && !vehicle vehicle::is_husk() && isplayer( damagedata.attacker ) )
    {
        isenemy = vehicle::is_enemy_to_player( vehicle, damagedata.attacker );
        damagedata.givepointsandxp = isenemy;
        damagedata.attacker function_d060bb312634dea7( #"destroyed_vehicle_tire", undefined, damagedata, vehicle );
        callback::callback( "player_pop_enemy_tire", { #isenemy:isenemy, #vehicle:vehicle, #player:damagedata.attacker } );
    }
    
    callback::callback( "player_pop_tire", { #vehicle:vehicle, #player:damagedata.attacker } );
}

// Namespace vehicle_damage
// Params 0, eflags: 0x4
// Checksum 0xa92fbb1f, Offset: 0x3b55
// Size: 0xe
function private function_d20754d07226daaf()
{
    scriptable::scriptable_addusedcallback( &on_repair_tire );
}

// Namespace vehicle_damage
// Params 6
// Checksum 0x15dbca15, Offset: 0x3b6b
// Size: 0xe4
function on_repair_tire( instance, part, state, player, bautouse, usestring )
{
    if ( !( isdefined( usestring ) && isdefined( instance ) && isdefined( instance.entity ) ) || !instance.entity vehicle::is_vehicle() )
    {
        return;
    }
    
    if ( usestring == "row1_left" || usestring == "row1_right" || usestring == "row2_left" || usestring == "row2_right" || usestring == "row3_left" || usestring == "row3_right" || usestring == "row4_left" || usestring == "row4_right" )
    {
        repair_tire( instance.entity, instance, part, usestring, player, 0 );
    }
}

// Namespace vehicle_damage
// Params 1
// Checksum 0x6ab524db, Offset: 0x3c57
// Size: 0xa9
function function_4b56eb7facbe21a6( vehicle )
{
    if ( isdefined( vehicle.deadwheels ) )
    {
        foreach ( part, data in vehicle.deadwheels )
        {
            repair_tire( vehicle, vehicle, part, data.wheelref, undefined, 1 );
            break;
        }
    }
}

// Namespace vehicle_damage
// Params 1
// Checksum 0xef9d79a0, Offset: 0x3d08
// Size: 0xa8
function function_b0ba8090957b72f3( vehicle )
{
    if ( isdefined( vehicle.deadwheels ) )
    {
        foreach ( part, data in vehicle.deadwheels )
        {
            vehicle thread repair_tire( vehicle, vehicle, part, data.wheelref, undefined, 1 );
        }
    }
}

// Namespace vehicle_damage
// Params 6, eflags: 0x4
// Checksum 0xdaa7268e, Offset: 0x3db8
// Size: 0x1f0
function private repair_tire( vehicle, scriptable, part, tirename, player, var_3ea59fa343133a74 )
{
    vehicle endon( #"death" );
    
    if ( isdefined( player ) )
    {
        player thread repair_tire_anim();
    }
    
    scriptable setscriptablepartstate( part, "repaired" );
    wait 0.1;
    tireindex = function_171e25698ffc0189( tirename );
    vehicle pristinetire( tireindex );
    
    if ( isdefined( vehicle.deadwheels[ part ] ) )
    {
        vehicle.damageableparts[ part ].healthvalue = vehicle.deadwheels[ part ].healthvalue;
        vehicle.damageableparts[ part ].explosivedamagehealthvalue = vehicle.deadwheels[ part ].explosivedamagehealthvalue;
    }
    
    if ( !isdefined( vehicle.flattiremask ) )
    {
        vehicle.flattiremask = 0;
    }
    
    vehicle.flattiremask &= ~( 1 << tireindex );
    occupants = vehicle_occupancy::function_8ed9bcd8e9ea74f5( vehicle, 0 );
    
    if ( isdefined( occupants ) )
    {
        foreach ( occupant in occupants )
        {
            function_5ca0c600bb09b1d2( vehicle, occupant );
        }
    }
    
    vehicle.deadwheels[ part ] = undefined;
    
    if ( vehicle.deadwheels.size == 0 )
    {
        vehicle.deadwheels = undefined;
    }
    
    function_6d5a43e898d2d97( vehicle, part, var_3ea59fa343133a74 );
}

// Namespace vehicle_damage
// Params 0, eflags: 0x4
// Checksum 0x98e1906d, Offset: 0x3fb0
// Size: 0x43
function private repair_tire_anim()
{
    self endon( #"death_or_disconnect" );
    weapobj = makeweapon( "iw8_ges_plyr_loot_pickup" );
    self giveandfireoffhand( weapobj );
    wait 1.17;
    
    if ( self hasweapon( weapobj ) )
    {
        self takeweapon( weapobj );
    }
}

// Namespace vehicle_damage
// Params 3, eflags: 0x4
// Checksum 0x1c460d17, Offset: 0x3ffb
// Size: 0x54
function private function_6d5a43e898d2d97( vehicle, part, var_3ea59fa343133a74 )
{
    repairsoundlocation = vehicle gettagorigin( part );
    repairsound = "veh_repair_tire";
    
    if ( var_3ea59fa343133a74 )
    {
        repairsound = "veh_repair_tire_at_station";
    }
    
    playsoundatpos( repairsoundlocation, repairsound );
}

// Namespace vehicle_damage
// Params 1, eflags: 0x4
// Checksum 0x7fd7c4d5, Offset: 0x4057
// Size: 0xa6
function private function_171e25698ffc0189( tirename )
{
    switch ( tirename )
    {
        case #"hash_19baa7ca5b52f06a":
            return 0;
        case #"hash_60b26be014fd7337":
            return 1;
        case #"hash_67ed6be3637f19ed":
            return 2;
        case #"hash_227fe4df4167aa26":
            return 3;
        case #"hash_f0704f57a0dd2250":
            return 4;
        case #"hash_cbd67f63f80e6245":
            return 5;
        case #"hash_711797dce2a722a3":
            return 6;
        case #"hash_6ade103971ce6e2c":
            return 7;
        default:
            assert( "<dev string:xd6>" );
            break;
    }
}

// Namespace vehicle_damage
// Params 2
// Checksum 0x71508425, Offset: 0x4105
// Size: 0x47
function function_5ca0c600bb09b1d2( vehicle, player )
{
    if ( !isdefined( vehicle.flattiremask ) )
    {
        vehicle.flattiremask = 0;
    }
    
    player setclientomnvar( "ui_veh_flat_tire_mask", vehicle.flattiremask );
}

// Namespace vehicle_damage
// Params 1
// Checksum 0xd4f6f8e7, Offset: 0x4154
// Size: 0xc0
function modify_vehicle_damage( data )
{
    ref = vehicle::get_ref();
    
    if ( !isdefined( ref ) || !vehicle::has_data( ref ) )
    {
        return;
    }
    
    utility::script_func( "check_vehicle_weak_points", data );
    
    if ( isagent( data.inflictor ) )
    {
        vehicledata = vehicle::get_data( ref );
        
        if ( isdefined( vehicledata ) && isdefined( vehicledata.damage ) && isdefined( vehicledata.damage.agentdamagemultiplier ) )
        {
            data.damage *= vehicledata.damage.agentdamagemultiplier;
        }
    }
}

// Namespace vehicle_damage
// Params 1
// Checksum 0xf4dee4cd, Offset: 0x421c
// Size: 0x1aa, Type: bool
function function_f2a732b19943daa0( data )
{
    if ( !( isdefined( data.point ) && isdefined( data.objweapon ) && isdefined( data.objweapon.damageradius ) ) )
    {
        return true;
    }
    
    ref = vehicle::get_ref();
    
    if ( !isdefined( ref ) || !vehicle::has_data( ref ) )
    {
        return true;
    }
    
    vehicledata = vehicle::get_data( ref );
    
    if ( !( isdefined( vehicledata ) && isdefined( vehicledata.damage ) && isdefined( vehicledata.damage.explosionextents ) ) )
    {
        return true;
    }
    
    radius = data.objweapon.damageradius;
    bounds = vehicledata.damage.explosionextents;
    localorigin = coordtransformtranspose( data.point, self.origin, self.angles );
    return localorigin[ 0 ] > ( bounds.back + radius ) * -1 && localorigin[ 0 ] < bounds.front + radius && localorigin[ 1 ] > ( bounds.left + radius ) * -1 && localorigin[ 1 ] < bounds.right + radius && localorigin[ 2 ] > ( bounds.bottom + radius ) * -1 && localorigin[ 2 ] < bounds.top + radius;
}

// Namespace vehicle_damage
// Params 0
// Checksum 0xfcfc777, Offset: 0x43cf
// Size: 0x19f
function init()
{
    assert( isdefined( level.vehicle ), "<dev string:x111>" );
    assert( !isdefined( level.vehicle.damage ), "<dev string:x146>" );
    leveldata = spawnstruct();
    level.vehicle.damage = leveldata;
    level.var_a78a5c3c321451a4 = getdvarint( @"hash_4421544b585f6be5", utility::ismp() ) == 1;
    
    if ( level.projectbundle.var_4b0a96a3b624c9ec && function_4042d2fbe6237835( #"hash_4ba7f1603e721859" ) )
    {
        level.projectbundle.var_4b0a96a3b624c9ec = 0;
    }
    
    if ( level.projectbundle.var_f58a6e2322572bc2 && function_4042d2fbe6237835( #"hash_f13e37a2307443e0" ) )
    {
        level.projectbundle.var_f58a6e2322572bc2 = 0;
    }
    
    leveldata.mediumstatehealthratio = getdvarfloat( @"hash_4217d1e671e33953", 0.5 );
    leveldata.burndowntime = getdvarfloat( @"hash_1021d59d6f0d99a0", 8 );
    
    if ( utility::issharedfuncdefined( #"vehicle_damage", #"init" ) )
    {
        [[ utility::getsharedfunc( #"vehicle_damage", #"init" ) ]]();
    }
    
    init_hit_damage_data();
    init_mod_damage_data();
    load_table();
    init_debug();
    function_d20754d07226daaf();
    callback::add( #"on_ai_killed", &onagentkilled );
}

// Namespace vehicle_damage
// Params 0, eflags: 0x4
// Checksum 0xa22117c3, Offset: 0x4576
// Size: 0x194
function private load_table()
{
    if ( !( isdefined( level.gametypebundle ) && isdefined( level.gametypebundle.damagetable ) ) )
    {
        return;
    }
    
    leveldata = get_level_data();
    leveldata.table = getscriptbundle( level.gametypebundle.damagetable );
    
    foreach ( struct in leveldata.table.weapons )
    {
        set_weapon_hit_damage_data( struct.weapon, struct.hits );
    }
    
    foreach ( struct in leveldata.table.perks )
    {
        set_perk_mod_damage( struct.perk, struct.modifier, struct.type == "Multiplicative" );
    }
}

// Namespace vehicle_damage
// Params 2
// Checksum 0xe29dba42, Offset: 0x4712
// Size: 0x565
function function_f80dee5b045a4ee8( vehicleref, var_e6c819f806ce2c86 )
{
    leveldata = get_level_data();
    table = leveldata.table;
    leveldataforvehicle = get_data( vehicleref, undefined, var_e6c819f806ce2c86 );
    
    if ( !( isdefined( leveldataforvehicle ) && isdefined( table ) ) )
    {
        return;
    }
    
    class = leveldataforvehicle.class;
    
    if ( isdefined( class ) )
    {
        foreach ( struct in table.var_2d3d5a248d07d8aa )
        {
            switch ( class )
            {
                case #"hash_d2a55c7ac538641b":
                    modifier = struct.super_light;
                    break;
                case #"hash_d582c3286e5c390f":
                    modifier = struct.light;
                    break;
                case #"hash_21622ca3ad06efb5":
                    modifier = struct.medium_light;
                    break;
                case #"hash_c71b112fe04823d6":
                    modifier = struct.medium;
                    break;
                case #"hash_53e0b558455f04c6":
                    modifier = struct.medium_heavy;
                    break;
                case #"hash_2453c9ffec9f5c20":
                    modifier = struct.heavy;
                    break;
                case #"hash_e8ec392f4f2724e4":
                    modifier = struct.super_heavy;
                    break;
                default:
                    assertmsg( "<dev string:x179>" + class );
                    continue;
            }
            
            function_86431c2d7f105aee( struct.weapon_class, modifier, 0, vehicleref );
        }
        
        foreach ( struct in table.var_62aaa5c1b920ac4a )
        {
            switch ( class )
            {
                case #"hash_d2a55c7ac538641b":
                    hits = struct.super_light;
                    break;
                case #"hash_d582c3286e5c390f":
                    hits = struct.light;
                    break;
                case #"hash_21622ca3ad06efb5":
                    hits = struct.medium_light;
                    break;
                case #"hash_c71b112fe04823d6":
                    hits = struct.medium;
                    break;
                case #"hash_53e0b558455f04c6":
                    hits = struct.medium_heavy;
                    break;
                case #"hash_2453c9ffec9f5c20":
                    hits = struct.heavy;
                    break;
                case #"hash_e8ec392f4f2724e4":
                    hits = struct.super_heavy;
                    break;
                default:
                    assertmsg( "<dev string:x179>" + class );
                    continue;
            }
            
            set_weapon_hit_damage_data_for_vehicle( struct.weapon, hits, vehicleref );
            set_vehicle_hit_damage_data_for_weapon( vehicleref, 100, struct.weapon );
        }
    }
    
    foreach ( struct in table.var_7846c0aacadee0f6 )
    {
        hits = undefined;
        
        switch ( vehicleref )
        {
            case %"hash_32b7b34facdfbf9":
            case %"hash_7f492eb947d5169a":
                hits = struct.veh9_cougar;
                break;
            case %"vehiclebundle:light_tank_mp":
            case %"hash_6105e9957d92349e":
                hits = struct.light_tank;
                break;
            case %"hash_57d0b185054b4bd4":
            case %"hash_79d97f9d1822b8fc":
                hits = struct.veh9_apc_8x8;
                break;
            case %"hash_1dd941f8f4026e3":
            case %"hash_186daea1f5e4cba0":
            case %"hash_27bdeb5659b41c74":
                hits = struct.veh9_palfa;
                break;
            case %"hash_5768bc9b7102816a":
            case %"veh_rex_air_heli_little_mp":
                hits = struct.veh_rex_air_heli_little;
                break;
            case %"hash_504bee88802b214a":
            case %"hash_506dea88804800e4":
            case %"veh_rex_air_heli_blima_mp":
            case %"veh_rex_air_heli_blima_sp":
                hits = struct.veh_rex_air_heli_blima;
                break;
            case %"veh_rex_lnd_ifv_tow_meltdown_sp":
                hits = struct.var_766dda3bd3a0ce92;
                break;
            default:
                return;
        }
        
        if ( !isdefined( hits ) )
        {
            continue;
        }
        
        set_weapon_hit_damage_data_for_vehicle( struct.weapon, hits, vehicleref );
        set_vehicle_hit_damage_data_for_weapon( vehicleref, 100, struct.weapon );
    }
}

// Namespace vehicle_damage
// Params 0
// Checksum 0x97aacc42, Offset: 0x4c7f
// Size: 0x36
function get_level_data()
{
    assert( isdefined( level.vehicle.damage ), "<dev string:x18e>" );
    return level.vehicle.damage;
}

// Namespace vehicle_damage
// Params 2
// Checksum 0x14f69781, Offset: 0x4cbe
// Size: 0x11f, Type: bool
function is_self_damage( vehicle, data )
{
    if ( isdefined( data.inflictor ) )
    {
        if ( data.inflictor == vehicle )
        {
            return true;
        }
        
        turrets = vehicle::get_turrets( vehicle );
        
        foreach ( turret in turrets )
        {
            if ( data.inflictor == turret )
            {
                return true;
            }
        }
        
        if ( data.inflictor.classname == "rocket" && isdefined( data.inflictor.vehicle ) && data.inflictor.vehicle == vehicle )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace vehicle_damage
// Params 1
// Checksum 0x6f2695dd, Offset: 0x4de6
// Size: 0x1a
function function_f22ce6c0cf2d903b( vehicle )
{
    vehicle.ownerdamageenabled = 1;
}

// Namespace vehicle_damage
// Params 1
// Checksum 0xe6d35fee, Offset: 0x4e08
// Size: 0x19
function function_4217194be51deba2( vehicle )
{
    vehicle.ownerdamageenabled = 0;
}

// Namespace vehicle_damage
// Params 1
// Checksum 0x5b5ecba6, Offset: 0x4e29
// Size: 0x64
function is_owner_damage_enabled( vehicle )
{
    if ( isdefined( vehicle.ownerdamageenabled ) )
    {
        return vehicle.ownerdamageenabled;
    }
    
    if ( vehicle::has_data( vehicle.vehiclename ) )
    {
        vehdata = get_data( vehicle.vehiclename );
    }
    
    return !vehdata.var_2406067d86a843f4;
}

// Namespace vehicle_damage
// Params 2
// Checksum 0xb8d2eb2a, Offset: 0x4e96
// Size: 0x103
function log_event( vehicle, data )
{
    if ( !isdefined( vehicle.damageevents ) )
    {
        vehicle.damageevents = [];
    }
    
    vehicle.damageevents[ vehicle.damageevents.size ] = data;
    
    if ( isdefined( data.attacker ) && isdefined( data.attacker.super ) && data.attacker.overridefieldupgrade1 == "super_suppression_rounds" )
    {
        if ( isdefined( data.attacker.super.vehiclehitcount ) )
        {
            data.attacker.super.vehiclehitcount++;
        }
        else
        {
            data.attacker.super.vehiclehitcount = 1;
        }
    }
    
    thread function_ade9cadb785cabe3( vehicle );
}

// Namespace vehicle_damage
// Params 1
// Checksum 0x4a856a50, Offset: 0x4fa1
// Size: 0x24
function function_8a2d9000eaf56a61( vehicle )
{
    vehicle notify( #"vehicle_damage_cleareventlog" );
    vehicle.damageevents = undefined;
}

// Namespace vehicle_damage
// Params 1
// Checksum 0xac1e1572, Offset: 0x4fcd
// Size: 0x4a
function function_ade9cadb785cabe3( vehicle )
{
    vehicle endon( #"death" );
    vehicle endon( #"vehicle_damage_cleareventlog" );
    vehicle notify( #"vehicle_damage_cleareventlogatframeend" );
    vehicle endon( #"vehicle_damage_cleareventlogatframeend" );
    waittillframeend();
    thread function_8a2d9000eaf56a61( vehicle );
}

// Namespace vehicle_damage
// Params 2
// Checksum 0xe6035f00, Offset: 0x501f
// Size: 0xf0
function function_ae99b703d6f83373( stateref, data )
{
    self notify( #"vehicle_damage_visualstopwatchingspeedchange" );
    self endon( #"vehicle_damage_visualstopwatchingspeedchange" );
    oldspeedstate = undefined;
    
    while ( isdefined( self ) )
    {
        speedstate = undefined;
        speed = int( self vehicle_getspeed() );
        canfly = istrue( vehicle::can_fly() );
        
        if ( canfly && self vehicle_isonground() )
        {
            speedstate = 0;
        }
        else if ( !canfly && speed <= 3 )
        {
            speedstate = 0;
        }
        else if ( speed <= 25 )
        {
            speedstate = 1;
        }
        else
        {
            speedstate = 2;
        }
        
        if ( isdefined( oldspeedstate ) && speedstate != oldspeedstate )
        {
            leveldatafordamagestate = function_9a9c7f377e631a4d( vehicle::get_ref(), stateref );
            self thread [[ leveldatafordamagestate.onentercallback ]]( stateref, data );
            return;
        }
        
        oldspeedstate = speedstate;
        wait 0.1;
    }
}

// Namespace vehicle_damage
// Params 0
// Checksum 0x5a69a341, Offset: 0x5117
// Size: 0xe
function function_e0917adf3efd7fca()
{
    self notify( #"vehicle_damage_visualstopwatchingspeedchange" );
}

// Namespace vehicle_damage
// Params 2
// Checksum 0x9c84f1ff, Offset: 0x512d
// Size: 0xbf
function function_7e4bf1b30c77e5b7( data, changed )
{
    speed = int( self vehicle_getspeed() );
    canfly = istrue( vehicle::can_fly() );
    
    if ( canfly && self vehicle_isonground() )
    {
        self setscriptablepartstate( "damageLight", "stopped", 1 );
    }
    else if ( !canfly && speed <= 3 )
    {
        self setscriptablepartstate( "damageLight", "stopped", 1 );
    }
    else if ( speed <= 25 )
    {
        self setscriptablepartstate( "damageLight", "lowSpeed", 1 );
    }
    else
    {
        self setscriptablepartstate( "damageLight", "highSpeed", 1 );
    }
    
    thread function_ae99b703d6f83373( "light", data );
}

// Namespace vehicle_damage
// Params 3
// Checksum 0xc2d63211, Offset: 0x51f4
// Size: 0x18a
function function_608f2ee15878882d( data, changed, fromdeath )
{
    function_e0917adf3efd7fca();
    
    if ( !self isscriptable() )
    {
        if ( isdefined( self.vehiclename ) )
        {
            ref = self.vehiclename;
        }
        else
        {
            ref = "undefined";
        }
        
        if ( isdefined( self.vehicletype ) )
        {
            type = self.vehicletype;
        }
        else
        {
            type = "undefined";
        }
        
        script::demoforcesre( "Vehicle is not a scriptable: ref: " + ref + " type: " + type );
        return;
    }
    
    if ( !self getscriptablehaspart( "damageLight" ) )
    {
        if ( isdefined( self.vehiclename ) )
        {
            ref = self.vehiclename;
        }
        else
        {
            ref = "undefined";
        }
        
        if ( isdefined( self.vehicletype ) )
        {
            type = self.vehicletype;
        }
        else
        {
            type = "undefined";
        }
        
        script::demoforcesre( "Vehicle does not have damageLight part: ref: " + ref + " type: " + type );
        return;
    }
    
    if ( !self getscriptableparthasstate( "damageLight", "off" ) )
    {
        if ( isdefined( self.vehiclename ) )
        {
            ref = self.vehiclename;
        }
        else
        {
            ref = "undefined";
        }
        
        if ( isdefined( self.vehicletype ) )
        {
            type = self.vehicletype;
        }
        else
        {
            type = "undefined";
        }
        
        script::demoforcesre( "Vehicle does not have part damageLight with state off: ref: " + ref + " type: " + type );
        return;
    }
    
    self setscriptablepartstate( "damageLight", "off", 1 );
}

// Namespace vehicle_damage
// Params 2
// Checksum 0xb62ff0ba, Offset: 0x5386
// Size: 0x142
function function_ca478928dc5fa5a4( data, changed )
{
    speed = int( self vehicle_getspeed() );
    canfly = istrue( vehicle::can_fly() );
    
    if ( canfly && self vehicle_isonground() && self getscriptablehaspart( "damageMedium" ) && self getscriptableparthasstate( "damageMedium", "stopped" ) )
    {
        self setscriptablepartstate( "damageMedium", "stopped", 1 );
    }
    else if ( !canfly && speed <= 3 && self getscriptablehaspart( "damageMedium" ) && self getscriptableparthasstate( "damageMedium", "stopped" ) )
    {
        self setscriptablepartstate( "damageMedium", "stopped", 1 );
    }
    else if ( speed <= 25 && self getscriptablehaspart( "damageMedium" ) && self getscriptableparthasstate( "damageMedium", "lowSpeed" ) )
    {
        self setscriptablepartstate( "damageMedium", "lowSpeed", 1 );
    }
    else if ( self getscriptablehaspart( "damageMedium" ) && self getscriptableparthasstate( "damageMedium", "highSpeed" ) )
    {
        self setscriptablepartstate( "damageMedium", "highSpeed", 1 );
    }
    
    thread function_ae99b703d6f83373( "medium", data );
}

// Namespace vehicle_damage
// Params 3
// Checksum 0xa0c94cd0, Offset: 0x54d0
// Size: 0x37
function function_dc4ddc6821110582( data, changed, fromdeath )
{
    function_e0917adf3efd7fca();
    self setscriptablepartstate( "damageMedium", "off", 1 );
}

// Namespace vehicle_damage
// Params 2
// Checksum 0xf48c0897, Offset: 0x550f
// Size: 0xbf
function function_d7e4fea731d24020( data, changed )
{
    speed = int( self vehicle_getspeed() );
    canfly = istrue( vehicle::can_fly() );
    
    if ( canfly && self vehicle_isonground() )
    {
        self setscriptablepartstate( "damageHeavy", "stopped", 1 );
    }
    else if ( !canfly && speed <= 3 )
    {
        self setscriptablepartstate( "damageHeavy", "stopped", 1 );
    }
    else if ( speed <= 25 )
    {
        self setscriptablepartstate( "damageHeavy", "lowSpeed", 1 );
    }
    else
    {
        self setscriptablepartstate( "damageHeavy", "highSpeed", 1 );
    }
    
    thread function_ae99b703d6f83373( "heavy", data );
}

// Namespace vehicle_damage
// Params 3
// Checksum 0x86f82bbd, Offset: 0x55d6
// Size: 0x37
function function_f60f559ead41cb86( data, changed, fromdeath )
{
    function_e0917adf3efd7fca();
    self setscriptablepartstate( "damageHeavy", "off", 1 );
}

// Namespace vehicle_damage
// Params 2
// Checksum 0x51c14d33, Offset: 0x5615
// Size: 0x4b
function function_721a99ea5b048315( data, changed )
{
    if ( utility::function_9f2c41c1dcc8c94( "damageEngine", "explode" ) )
    {
        self setscriptablepartstate( "damageEngine", "explode", 1 );
    }
    
    if ( !vehicle::can_fly() )
    {
        vehicle_occupancy::disable_engine();
    }
}

// Namespace vehicle_damage
// Params 3
// Checksum 0x39541985, Offset: 0x5668
// Size: 0x30
function function_d034de5e6901e7f7( data, changed, fromdeath )
{
    self setscriptablepartstate( "damageEngine", "off", 1 );
}

// Namespace vehicle_damage
// Params 0
// Checksum 0x59deefa5, Offset: 0x56a0
// Size: 0x13, Type: bool
function get_state()
{
    return self.damagestateref ?? "pristine";
}

// Namespace vehicle_damage
// Params 3
// Checksum 0x15af06d4, Offset: 0x56bc
// Size: 0xdc
function set_state( stateref, oldstateref, data )
{
    assert( isdefined( stateref ) && isdefined( oldstateref ) && stateref != oldstateref );
    self notify( #"damage_state_change" );
    ref = vehicle::get_ref();
    
    if ( oldstateref != "pristine" )
    {
        var_32d2c4b687724ddc = function_9a9c7f377e631a4d( ref, oldstateref, 0, 1 );
        
        if ( isdefined( var_32d2c4b687724ddc.onexitcallback ) )
        {
            self thread [[ var_32d2c4b687724ddc.onexitcallback ]]( stateref, data );
        }
    }
    
    if ( stateref != "pristine" )
    {
        var_32d2c4b687724ddc = function_9a9c7f377e631a4d( ref, stateref, 0, 1 );
        
        if ( isdefined( var_32d2c4b687724ddc.onentercallback ) )
        {
            self thread [[ var_32d2c4b687724ddc.onentercallback ]]( oldstateref, data );
        }
    }
    
    self.damagestateref = stateref;
}

// Namespace vehicle_damage
// Params 1
// Checksum 0x15bdf664, Offset: 0x57a0
// Size: 0x2c7
function force_set_state( stateref )
{
    assert( vehicle::is_vehicle() && vehicle::has_data( vehicle::get_ref() ), "<dev string:x1d5>" );
    assert( stateref == "<dev string:x1f1>" || stateref == "<dev string:x1fa>" || stateref == "<dev string:x200>" || stateref == "<dev string:x207>", "<dev string:x20d>" + ( stateref ?? "<dev string:x226>" ) );
    leveldata = get_level_data();
    leveldataforvehicle = get_data( vehicle::get_ref() );
    
    if ( get_state() == stateref )
    {
        return;
    }
    
    /#
        if ( vehicle::is_husk() )
        {
            haslight = 0;
            hasmedium = 0;
            hasheavy = 1;
        }
        else
        {
            haslight = !isdefined( leveldataforvehicle.damagestates ) || leveldataforvehicle.damagestates == "<dev string:x230>";
            hasmedium = haslight || !isdefined( leveldataforvehicle.damagestates ) || leveldataforvehicle.damagestates == "<dev string:x243>";
            hasheavy = hasmedium || !isdefined( leveldataforvehicle.damagestates ) || leveldataforvehicle.damagestates == "<dev string:x207>";
        }
        
        assert( stateref == "<dev string:x1f1>" || haslight && stateref == "<dev string:x1fa>" || hasmedium && stateref == "<dev string:x200>" || hasheavy && stateref == "<dev string:x207>", "<dev string:x250>" + stateref );
    #/
    
    if ( leveldataforvehicle.var_a090dfa65197b852 )
    {
        states = [ "heavy":self.maxhealth * leveldataforvehicle.var_ba4f5726e822c571 / 100, "medium":self.maxhealth * leveldataforvehicle.var_86cdcfef9a17b4d3 / 100, "light":self.maxhealth * leveldataforvehicle.var_9a083e0f55accd4c / 100, "pristine":self.maxhealth ];
    }
    else
    {
        states = [ "heavy":function_8c4b44320250db18( self ), "medium":self.maxhealth * leveldata.mediumstatehealthratio, "light":self.maxhealth * 0.9, "pristine":self.maxhealth ];
    }
    
    goalhealth = states[ stateref ];
    
    if ( self.health < goalhealth )
    {
        add_health( goalhealth - self.health - 1 );
        return;
    }
    
    self dodamage( self.health - goalhealth + 1, self.origin );
}

// Namespace vehicle_damage
// Params 3
// Checksum 0x5f74f5ea, Offset: 0x5a6f
// Size: 0x59
function update_state( data, var_b35b7da28aec24cd, var_e6c819f806ce2c86 )
{
    leveldataforvehicle = get_data( vehicle::get_ref(), undefined, var_e6c819f806ce2c86 );
    
    if ( !isdefined( leveldataforvehicle ) )
    {
        return;
    }
    
    self.lasttimedamaged = gettime();
    update_state_internal( data, var_b35b7da28aec24cd, var_e6c819f806ce2c86 );
}

// Namespace vehicle_damage
// Params 3, eflags: 0x4
// Checksum 0x3f71b3bb, Offset: 0x5ad0
// Size: 0x2bd
function private update_state_internal( data, var_b35b7da28aec24cd, var_e6c819f806ce2c86 )
{
    leveldata = get_level_data();
    leveldataforvehicle = get_data( vehicle::get_ref(), undefined, var_e6c819f806ce2c86 );
    vehiclehealth = self.health;
    
    if ( isdefined( data ) && isdefined( data.damage ) && !utility::issp() )
    {
        vehiclehealth -= int( data.damage );
    }
    
    beststateref = "pristine";
    var_7ceb88916f0fff03 = self.maxhealth;
    
    if ( vehicle::is_husk() )
    {
        states = [ "heavy":function_8c4b44320250db18( self ) ];
    }
    else if ( leveldataforvehicle.var_a090dfa65197b852 )
    {
        states = [ "heavy":self.maxhealth * leveldataforvehicle.var_ba4f5726e822c571 / 100, "medium":self.maxhealth * leveldataforvehicle.var_86cdcfef9a17b4d3 / 100, "light":self.maxhealth * leveldataforvehicle.var_9a083e0f55accd4c / 100 ];
    }
    else
    {
        states = [ "heavy":function_8c4b44320250db18( self ), "medium":self.maxhealth * leveldata.mediumstatehealthratio, "light":self.maxhealth * 0.9 ];
    }
    
    foreach ( stateref, maxhealth in states )
    {
        if ( maxhealth < var_7ceb88916f0fff03 && vehiclehealth <= maxhealth )
        {
            beststateref = stateref;
            var_7ceb88916f0fff03 = maxhealth;
        }
    }
    
    oldstateref = get_state();
    
    if ( beststateref != oldstateref )
    {
        if ( !var_b35b7da28aec24cd && beststateref == "heavy" && !self.disableheavystatedamagefloor )
        {
            heavystatemaxhealth = function_8c4b44320250db18( undefined, vehicle::get_ref() );
            
            if ( isdefined( heavystatemaxhealth ) )
            {
                var_933222aa4ef8d86b = heavystatemaxhealth;
                
                if ( !utility::issp() )
                {
                    var_933222aa4ef8d86b += data.damage;
                }
                
                if ( isdefined( data.damage ) && data.damage != 0 )
                {
                    set_current_health( max( self.health, var_933222aa4ef8d86b ) );
                }
            }
        }
        
        set_state( beststateref, oldstateref, data );
    }
}

// Namespace vehicle_damage
// Params 1
// Checksum 0xa923dd2, Offset: 0x5d95
// Size: 0x29
function function_658976b407a5b2e1( bool )
{
    if ( bool )
    {
        self.disableheavystatedamagefloor = 1;
        return;
    }
    
    self.disableheavystatedamagefloor = undefined;
}

// Namespace vehicle_damage
// Params 2
// Checksum 0x7ef7e6d4, Offset: 0x5dc6
// Size: 0x20
function function_c8cee5463d38045b( oldstateref, data )
{
    function_7e4bf1b30c77e5b7( data, 1 );
}

// Namespace vehicle_damage
// Params 2
// Checksum 0xf03fead0, Offset: 0x5dee
// Size: 0x20
function function_29e415d33db31135( newstateref, data )
{
    function_608f2ee15878882d( data, 1 );
}

// Namespace vehicle_damage
// Params 2
// Checksum 0xb6cd1168, Offset: 0x5e16
// Size: 0x20
function function_35d199879ef7efaa( oldstateref, data )
{
    function_ca478928dc5fa5a4( data, 1 );
}

// Namespace vehicle_damage
// Params 2
// Checksum 0x4efe760c, Offset: 0x5e3e
// Size: 0x20
function function_5beb7eb571bec434( newstateref, data )
{
    function_dc4ddc6821110582( data, 1 );
}

// Namespace vehicle_damage
// Params 2
// Checksum 0x81a96400, Offset: 0x5e66
// Size: 0xc8
function function_f4c9964d3c4ddd44( oldstateref, data )
{
    if ( utility::issharedfuncdefined( #"vehicle", #"hash_c91a9f6e5e3f772f" ) )
    {
        skip_logic = utility::callsharedfunc( #"vehicle", #"hash_c91a9f6e5e3f772f", {} );
        
        if ( skip_logic )
        {
            return;
        }
    }
    
    if ( vehicle::is_husk() )
    {
        function_56353dccab157e56( data );
    }
    else
    {
        function_d7e4fea731d24020( data, 1 );
        function_721a99ea5b048315( data, 1 );
    }
    
    if ( oldstateref != "heavy" )
    {
        vehicle_occupancy::allow_movement( self, 0 );
        vehicle_occupancy::function_6d9760c4971403c2( self, 0 );
        vehicle_interact::allow_use( self, 0 );
        
        if ( function_2fec514ed5f9106d() )
        {
            function_6c7722241a521e9( oldstateref, data );
        }
        
        thread begin_burn_down( data );
    }
}

// Namespace vehicle_damage
// Params 2
// Checksum 0xa62bd1fd, Offset: 0x5f36
// Size: 0x7a
function function_7e728a3ed58dd4e6( newstateref, data )
{
    if ( vehicle::is_husk() )
    {
        function_32e3d0ee599bd470( data );
    }
    else
    {
        function_f60f559ead41cb86( data, 1 );
        function_d034de5e6901e7f7( data, 1 );
    }
    
    if ( newstateref != "heavy" )
    {
        if ( !vehicle::is_husk() )
        {
            vehicle_occupancy::allow_movement( self, 1 );
            vehicle_occupancy::function_6d9760c4971403c2( self, 1 );
            vehicle_interact::allow_use( self, 1 );
        }
        
        end_burn_down();
    }
}

// Namespace vehicle_damage
// Params 1
// Checksum 0xded1927c, Offset: 0x5fb8
// Size: 0x162
function register_default_states( vehicleref )
{
    leveldataforvehicle = get_data( vehicleref, 1 );
    haslight = !isdefined( leveldataforvehicle.damagestates ) || leveldataforvehicle.damagestates == "light_medium_heavy";
    hasmedium = haslight || !isdefined( leveldataforvehicle.damagestates ) || leveldataforvehicle.damagestates == "medium_heavy";
    hasheavy = hasmedium || !isdefined( leveldataforvehicle.damagestates ) || leveldataforvehicle.damagestates == "heavy";
    
    if ( haslight )
    {
        leveldatafordamagestate = function_9a9c7f377e631a4d( vehicleref, "light", 1 );
        leveldatafordamagestate.onentercallback = &function_c8cee5463d38045b;
        leveldatafordamagestate.onexitcallback = &function_29e415d33db31135;
    }
    
    if ( hasmedium )
    {
        leveldatafordamagestate = function_9a9c7f377e631a4d( vehicleref, "medium", 1 );
        leveldatafordamagestate.onentercallback = &function_35d199879ef7efaa;
        leveldatafordamagestate.onexitcallback = &function_5beb7eb571bec434;
    }
    
    if ( hasheavy )
    {
        leveldatafordamagestate = function_9a9c7f377e631a4d( vehicleref, "heavy", 1 );
        leveldatafordamagestate.onentercallback = &function_f4c9964d3c4ddd44;
        leveldatafordamagestate.onexitcallback = &function_7e728a3ed58dd4e6;
    }
}

// Namespace vehicle_damage
// Params 1
// Checksum 0xe66dbf21, Offset: 0x6122
// Size: 0xba
function function_56353dccab157e56( data )
{
    var_6fd04269d9f0829e = utility::function_edc4cc03e9e60b3e( @"hash_6fa2847af53be191", 0, level.gametypebundle.var_6fd04269d9f0829e );
    state = undefined;
    
    if ( self getscriptableparthasstate( "damageHeavy", "on" ) )
    {
        state = var_6fd04269d9f0829e ? "only_smoke" : "on";
    }
    else if ( self getscriptableparthasstate( "damageHeavy", "stopped" ) )
    {
        state = var_6fd04269d9f0829e ? "only_smoke" : "stopped";
    }
    
    if ( isdefined( state ) && self getscriptableparthasstate( "damageHeavy", state ) )
    {
        self setscriptablepartstate( "damageHeavy", state, 1 );
    }
}

// Namespace vehicle_damage
// Params 1
// Checksum 0x11235a1e, Offset: 0x61e4
// Size: 0xbe
function function_32e3d0ee599bd470( data )
{
    self setscriptablepartstate( "damageHeavy", "off", 1 );
    transitionscriptableparts = vehicle_spawn::function_b65e41134b5a89af( self.pristineref );
    
    if ( isdefined( transitionscriptableparts ) )
    {
        foreach ( struct in transitionscriptableparts )
        {
            self setscriptablepartstate( struct.var_bfed29f09b275d4b, "off", 1 );
        }
    }
}

// Namespace vehicle_damage
// Params 2
// Checksum 0x106a8b43, Offset: 0x62aa
// Size: 0xcd
function get_max_health( vehicle, vehicleref = vehicle vehicle::get_ref() )
{
    spawndata = vehicle vehicle_tracking::get_spawn_data();
    
    if ( isdefined( spawndata.script_startinghealth ) )
    {
        maxhealth = spawndata.script_startinghealth;
    }
    else
    {
        leveldataforvehicle = get_data( vehicleref, 1 );
        
        if ( !( isdefined( leveldataforvehicle ) && isdefined( leveldataforvehicle.health ) ) )
        {
            if ( isdefined( vehicle ) )
            {
                return vehicle.maxhealth;
            }
            
            return;
        }
        
        maxhealth = leveldataforvehicle.health;
    }
    
    heavystatehealthadd = function_9063fec90e443ad3( vehicleref );
    
    if ( isdefined( heavystatehealthadd ) )
    {
        maxhealth += heavystatehealthadd;
    }
    
    return int( maxhealth );
}

// Namespace vehicle_damage
// Params 2
// Checksum 0x98241e2e, Offset: 0x6380
// Size: 0x89
function function_a5c118b954f2ccba( vehicle, vehicleref = vehicle vehicle::get_ref() )
{
    leveldata = get_level_data();
    
    if ( !isdefined( leveldata.mediumstatehealthratio ) )
    {
        return;
    }
    
    leveldataforvehicle = get_data( vehicleref );
    
    if ( !isdefined( leveldataforvehicle ) )
    {
        return;
    }
    
    if ( !isdefined( leveldataforvehicle.health ) )
    {
        return;
    }
    
    return leveldataforvehicle.health * leveldata.mediumstatehealthratio;
}

// Namespace vehicle_damage
// Params 2
// Checksum 0xd189ba01, Offset: 0x6412
// Size: 0x79
function function_8c4b44320250db18( vehicle, vehicleref = vehicle vehicle::get_ref() )
{
    leveldataforvehicle = get_data( vehicleref );
    
    if ( !isdefined( leveldataforvehicle ) )
    {
        return;
    }
    
    if ( !isdefined( leveldataforvehicle.health ) )
    {
        return;
    }
    
    heavystatehealthadd = function_9063fec90e443ad3( vehicleref );
    
    if ( !isdefined( heavystatehealthadd ) || heavystatehealthadd <= 0 )
    {
        return;
    }
    
    return int( heavystatehealthadd );
}

// Namespace vehicle_damage
// Params 1
// Checksum 0x761924a6, Offset: 0x6494
// Size: 0x26
function function_9063fec90e443ad3( vehicleref )
{
    return int( get_data( vehicleref ).heavystatehealthadd ?? 0 );
}

// Namespace vehicle_damage
// Params 1
// Checksum 0xc89dafaa, Offset: 0x64c3
// Size: 0x18b, Type: bool
function function_fbafe88248510c34( data )
{
    if ( isdefined( data.objweapon ) && isdefined( data.objweapon.basename ) )
    {
        switch ( data.objweapon.basename )
        {
            case #"hash_708fb6e22f87a3a4":
            case #"hash_a622e958420b92a0":
                return ( isdefined( data.meansofdeath ) && ( data.meansofdeath == "MOD_PROJECTILE" || data.meansofdeath == "MOD_RIFLE_BULLET" ) );
            case #"hash_13608f01c909bed3":
            case #"hash_13a265ac820ea0df":
            case #"hash_1717a0115ff7a1c4":
            case #"hash_348ae4b5cc97ad79":
            case #"hash_3e782fd775b72022":
            case #"hash_5c272c0617caebf0":
            case #"hash_8c12df11df01f306":
            case #"hash_a86d4075406d2de4":
            case #"hash_fd9c279f85990dad":
                return ( isdefined( data.meansofdeath ) && data.meansofdeath == "MOD_PROJECTILE" );
            case #"hash_c500a77b6bb7c5d0":
                return ( isdefined( data.meansofdeath ) && data.meansofdeath == "MOD_GRENADE" );
            case #"hash_56ee829cc162271a":
                return ( isdefined( data.meansofdeath ) && data.meansofdeath == "MOD_EXPLOSIVE" );
        }
    }
    
    return false;
}

// Namespace vehicle_damage
// Params 1
// Checksum 0x5b2d6551, Offset: 0x6657
// Size: 0x283
function function_751760054809604d( data )
{
    ref = vehicle::get_ref();
    
    if ( !isdefined( ref ) )
    {
        return;
    }
    
    if ( data.meansofdeath == "MOD_GRENADE" || data.meansofdeath == "MOD_GRENADE_SPLASH" || data.meansofdeath == "MOD_PROJECTILE" || data.meansofdeath == "MOD_PROJECTILE_SPLASH" || data.meansofdeath == "MOD_EXPLOSIVE" )
    {
        if ( vehicle::has_data( ref ) )
        {
            bundle = vehicle::get_data( ref );
            
            if ( !isdefined( bundle ) )
            {
                return;
            }
            
            if ( !isdefined( bundle.damageknockback ) )
            {
                return;
            }
        }
        else
        {
            return;
        }
        
        magnitude = clamp( data.damage, 0, bundle.damageknockback.var_f4ca450e4481d219 ) / bundle.damageknockback.var_f4ca450e4481d219 * bundle.damageknockback.var_53d3481c22156866;
        
        if ( magnitude < 0.01 )
        {
            return;
        }
        
        forcevec = data.direction_vec * magnitude;
        forcevec *= bundle.damageknockback.var_514ba586d40dfce4;
        forcevec += ( 0, 0, magnitude * bundle.damageknockback.var_514ba586d40dfce4 * bundle.damageknockback.var_834463582355514d );
        
        if ( vehicle::is_husk() )
        {
            forcevec *= bundle.damageknockback.var_4752892bd8d9257e;
        }
        
        if ( isdefined( self getvehicleowner() ) )
        {
            forcevec *= bundle.damageknockback.var_62b13ee648fd7ba4;
            collisionblend = bundle.damageknockback.var_292f5cff38e96f56;
        }
        else
        {
            collisionblend = bundle.damageknockback.var_377aef654c7ac8b5;
            
            if ( self getscriptablehaspart( "stability" ) )
            {
                utility::function_7c10ea82c1e305b8( "stability", "unstable" );
            }
        }
        
        forcevec = coordtransformtranspose( forcevec, ( 0, 0, 0 ), self.angles );
        point = function_dfdf2f34d4908f2a( data.point, collisionblend );
        forcevec = function_31abc9d9133eddfa( forcevec, bundle );
        self vehphys_force( forcevec, point, 0 );
    }
}

// Namespace vehicle_damage
// Params 2, eflags: 0x4
// Checksum 0x82991a8, Offset: 0x68e2
// Size: 0xbf
function private function_dfdf2f34d4908f2a( point, percentage )
{
    point = coordtransformtranspose( point, self.origin, self.angles );
    cornersarray = self getboundscorners();
    cornersarray[ 0 ] = coordtransformtranspose( cornersarray[ 0 ], self.origin, self.angles );
    cornersarray[ 1 ] = coordtransformtranspose( cornersarray[ 1 ], self.origin, self.angles );
    point = ( clamp( point[ 0 ], cornersarray[ 1 ][ 0 ], cornersarray[ 0 ][ 0 ] ), clamp( point[ 1 ], cornersarray[ 1 ][ 1 ], cornersarray[ 0 ][ 1 ] ), clamp( point[ 2 ], cornersarray[ 1 ][ 2 ], cornersarray[ 0 ][ 2 ] ) );
    return point * percentage;
}

// Namespace vehicle_damage
// Params 0
// Checksum 0x408f88b3, Offset: 0x69aa
// Size: 0x9
function function_bdf87ac8d69f745e()
{
    thread function_fc722083e5cc3687();
}

// Namespace vehicle_damage
// Params 0, eflags: 0x4
// Checksum 0x2351ae53, Offset: 0x69bb
// Size: 0x182
function private function_fc722083e5cc3687()
{
    ref = vehicle::get_ref();
    
    if ( !isdefined( ref ) )
    {
        return;
    }
    
    bundle = vehicle::get_data( ref );
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    self endon( #"death" );
    waitframe();
    forcevec = rotatevector( ( 1, 0, 0 ), ( 0, randomfloat( 360 ), 0 ) ) * bundle.damageknockback.var_2a748c4ee31cc1fc * bundle.damageknockback.var_53d3481c22156866;
    forcevec += ( 0, 0, bundle.damageknockback.var_e09d2a9f1a91ea6a * bundle.damageknockback.var_53d3481c22156866 );
    forcevec = coordtransformtranspose( forcevec, self.origin, self.angles );
    forceloc = ( randomfloatrange( bundle.damageknockback.var_10bbbefa82858738, bundle.damageknockback.var_48d2e287b3893e1a ), randomfloatrange( bundle.damageknockback.var_366046c646e23f7b, bundle.damageknockback.var_73080944f8087da5 ), 0 );
    forceloc = ( forceloc[ 0 ] * ( randomintrange( 0, 2 ) * 2 - 1 ), forceloc[ 1 ] * ( randomintrange( 0, 2 ) * 2 - 1 ), 0 );
    self vehphys_force( forcevec, forceloc, 0 );
}

// Namespace vehicle_damage
// Params 2, eflags: 0x4
// Checksum 0x4828440e, Offset: 0x6b45
// Size: 0x8d
function private function_31abc9d9133eddfa( force, bundle )
{
    recordedtime = gettime();
    
    if ( isdefined( self.lastdamagedtime ) && recordedtime - self.lastdamagedtime < bundle.damageknockback.var_16f1e0129aabafd9 * 1000 )
    {
        self.lastdamagedtime = recordedtime;
        return ( force * bundle.damageknockback.var_56f933d5cdad385c );
    }
    
    self.lastdamagedtime = recordedtime;
    return force;
}

// Namespace vehicle_damage
// Params 3, eflags: 0x4
// Checksum 0xf7ff4c9f, Offset: 0x6bdb
// Size: 0x214
function private function_ea5f5ad915b3206f( vehicle, tagname, damagedata )
{
    if ( !isdefined( vehicle.damageableparts ) )
    {
        return 0;
    }
    
    if ( !isdefined( tagname ) )
    {
        return 0;
    }
    
    if ( !isdefined( vehicle.damageableparts[ tagname ] ) )
    {
        return 0;
    }
    
    if ( is_part_dead( vehicle.damageableparts[ tagname ] ) )
    {
        return 0;
    }
    
    if ( isdefined( damagedata ) && isdefined( damagedata.objweapon ) && ( utility::callsharedfunc( #"weapons", #"isthrowingknife", damagedata.objweapon ) || utility::callsharedfunc( #"weapons", #"isThrowStar", damagedata.objweapon ) ) )
    {
        damageablepartdata = get_part_data( vehicle vehicle::get_ref() );
        
        if ( !isdefined( damageablepartdata[ tagname ].wheelref ) )
        {
            return 0;
        }
    }
    
    if ( isdefined( damagedata ) && isdefined( damagedata.objweapon ) && damagedata.meansofdeath == "MOD_MELEE" )
    {
        damageablepartdata = get_part_data( vehicle vehicle::get_ref() );
        issharp = utility::callsharedfunc( #"weapons", #"isSharpMeleeWeapon", damagedata.objweapon );
        iswindow = isdefined( damageablepartdata[ tagname ].windowref );
        istire = isdefined( damageablepartdata[ tagname ].wheelref );
        
        if ( issharp && !iswindow && !istire )
        {
            return 0;
        }
        else if ( !issharp && !iswindow )
        {
            return 0;
        }
    }
    
    state = vehicle getscriptablepartstate( tagname, 1 );
    
    if ( isdefined( state ) && ( state == "start_hidden" || state == "hidden_usable" ) )
    {
        return 0;
    }
    
    damagefilterfunc = function_46e4d0ba5e829f68( vehicle vehicle::get_ref(), tagname );
    
    if ( isdefined( damagefilterfunc ) )
    {
        return [[ damagefilterfunc ]]( damagedata );
    }
    
    return 1;
}

// Namespace vehicle_damage
// Params 1
// Checksum 0x8448b408, Offset: 0x6df8
// Size: 0xa2, Type: bool
function function_2b7271a5e9ac2ec6( seatid )
{
    data = vehicle_occupancy::get_data( vehicle::get_ref() );
    return isdefined( data.seatdata[ seatid ] ) && isdefined( data.seatdata[ seatid ].doorwindowref ) && isdefined( self.damageableparts[ data.seatdata[ seatid ].doorwindowref ] ) && !is_part_dead( self.damageableparts[ data.seatdata[ seatid ].doorwindowref ] );
}

// Namespace vehicle_damage
// Params 1
// Checksum 0x5907f884, Offset: 0x6ea3
// Size: 0x72
function destroy_door_window( seatid )
{
    data = vehicle_occupancy::get_data( vehicle::get_ref() );
    
    if ( isdefined( data.seatdata[ seatid ] ) && isdefined( data.seatdata[ seatid ].doorwindowref ) )
    {
        kill_part( self, data.seatdata[ seatid ].doorwindowref );
    }
}

// Namespace vehicle_damage
// Params 2
// Checksum 0xff324d8b, Offset: 0x6f1d
// Size: 0x54
function function_8b54529d7c41c894( vehicle, seatid )
{
    self endon( #"death_or_disconnect" );
    self endon( #"vehicle_seat_exit" );
    utility::waittill_any( "vehicle_leanout_begin", "roof_exit" );
    
    if ( vehicle function_2b7271a5e9ac2ec6( seatid ) )
    {
        vehicle destroy_door_window( seatid );
    }
}

// Namespace vehicle_damage
// Params 2
// Checksum 0xe8b96793, Offset: 0x6f79
// Size: 0x6d
function function_46e4d0ba5e829f68( vehicleref, tagname )
{
    leveldataforvehicle = get_data( vehicleref );
    damagefilter = leveldataforvehicle.damageableparts[ tagname ].damagefilter;
    
    if ( isdefined( damagefilter ) )
    {
        switch ( damagefilter )
        {
            case #"hash_519952040ad478cb":
                return &function_d05a153bd013b437;
        }
    }
}

// Namespace vehicle_damage
// Params 1
// Checksum 0x5c3ce8f, Offset: 0x6fef
// Size: 0x2b
function get_part_data( vehicleref )
{
    leveldataforvehicle = get_data( vehicleref );
    return leveldataforvehicle.damageableparts;
}

// Namespace vehicle_damage
// Params 2
// Checksum 0xae4b5fe, Offset: 0x7023
// Size: 0x41
function function_832c3ca9c66e59ba( vehicleref, tagname )
{
    leveldataforvehicle = get_data( vehicleref );
    return leveldataforvehicle.damageableparts[ tagname ].scriptablepartname;
}

// Namespace vehicle_damage
// Params 3
// Checksum 0xdc38e554, Offset: 0x706d
// Size: 0x4c
function function_ec222609915dafe4( vehicleref, tagname, callbackfunc )
{
    leveldataforvehicle = get_data( vehicleref );
    leveldataforvehicle.damageableparts[ tagname ].var_d6aa641e123523f4 = callbackfunc;
}

// Namespace vehicle_damage
// Params 2
// Checksum 0xe30d2551, Offset: 0x70c1
// Size: 0x41
function function_d1683f189b6bff40( vehicleref, tagname )
{
    leveldataforvehicle = get_data( vehicleref );
    return leveldataforvehicle.damageableparts[ tagname ].var_d6aa641e123523f4;
}

// Namespace vehicle_damage
// Params 1
// Checksum 0x221aed9a, Offset: 0x710b
// Size: 0xe2
function function_37a5eba1057e9f53( chance = 0 )
{
    if ( !isdefined( self ) || !vehicle::is_vehicle() )
    {
        return;
    }
    
    data = get_data( vehicle::get_ref() );
    
    if ( !isdefined( data ) )
    {
        return;
    }
    
    tags = data.damageableparts;
    
    if ( !isdefined( tags ) )
    {
        return;
    }
    
    foreach ( tagname, damageablepartdata in tags )
    {
        if ( damageablepartdata.wheelref )
        {
            function_e1a2ac299197f480( tagname, chance );
        }
    }
}

// Namespace vehicle_damage
// Params 2
// Checksum 0xd41c905a, Offset: 0x71f5
// Size: 0x52
function function_e1a2ac299197f480( part, chance )
{
    spawndata = vehicle_tracking::get_base_spawn_data();
    
    if ( !isdefined( spawndata.var_67ef11b9f2bef4cf ) )
    {
        spawndata.var_67ef11b9f2bef4cf = [];
    }
    
    spawndata.var_67ef11b9f2bef4cf[ part ] = chance;
}

// Namespace vehicle_damage
// Params 2
// Checksum 0x8ac56ebd, Offset: 0x724f
// Size: 0x6c
function function_f2b615c14472e0a4( vehicleref, tagname )
{
    var_7237854e3be197ca = vehicle_tracking::get_base_spawn_data().var_67ef11b9f2bef4cf[ tagname ];
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    leveldataforvehicle = get_data( vehicleref );
    return leveldataforvehicle.damageableparts[ tagname ].var_67ef11b9f2bef4cf ?? 30;
}

// Namespace vehicle_damage
// Params 2
// Checksum 0x1e7d450d, Offset: 0x72c4
// Size: 0x42, Type: bool
function function_2e51ef7ed0446ca7( vehicleref, tagname )
{
    leveldataforvehicle = get_data( vehicleref );
    return istrue( leveldataforvehicle.damageableparts[ tagname ].var_aab34cb56f293c25 );
}

// Namespace vehicle_damage
// Params 2
// Checksum 0xbb6a25b4, Offset: 0x730f
// Size: 0x55
function get_part_damage_reduction( vehicleref, tagname )
{
    leveldataforvehicle = get_data( vehicleref );
    reduction = leveldataforvehicle.damageableparts[ tagname ].damagereduction;
    
    if ( !isdefined( reduction ) )
    {
        reduction = 0;
    }
    
    return reduction;
}

// Namespace vehicle_damage
// Params 3
// Checksum 0x91158df, Offset: 0x736d
// Size: 0xca, Type: bool
function is_crossbow_damage_location( vehicle, tagname, var_d64226ce9e21e098 = 1 )
{
    if ( !isdefined( tagname ) )
    {
        return false;
    }
    
    if ( !isdefined( vehicle.damageableparts ) )
    {
        return false;
    }
    
    if ( !isdefined( vehicle.damageableparts[ tagname ] ) )
    {
        return false;
    }
    
    damageablepartdata = get_part_data( vehicle vehicle::get_ref() );
    iswindow = isdefined( damageablepartdata[ tagname ].windowref );
    istire = isdefined( damageablepartdata[ tagname ].wheelref );
    
    if ( istire )
    {
        return true;
    }
    
    if ( var_d64226ce9e21e098 )
    {
        if ( iswindow )
        {
            return true;
        }
        
        if ( issubstr( tagname, "tag_light" ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace vehicle_damage
// Params 3
// Checksum 0x31ba55a1, Offset: 0x7440
// Size: 0xb5
function function_7b560d1e1dadd7e1( vehicle, tagname, reactivearmorexplosion )
{
    data = vehicle::get_data( vehicle vehicle::get_ref() );
    damageablepartdata = data.damage.damageableparts[ tagname ];
    
    if ( reactivearmorexplosion )
    {
        return "reactive_armor_explosion";
    }
    
    if ( !vehicle vehicle::is_husk() && isdefined( damageablepartdata.wheelref ) && damageablepartdata.wheelref != "not_a_wheel" && level.var_a78a5c3c321451a4 )
    {
        return "death_usable";
    }
    
    return "death";
}

// Namespace vehicle_damage
// Params 4
// Checksum 0xccbbd1fb, Offset: 0x74fd
// Size: 0x207
function function_eb89abdecc0cacc0( vehicle, damage, point, radius )
{
    if ( !( isdefined( vehicle ) && isdefined( vehicle.damageableparts ) ) || vehicle.damageableparts.size == 0 )
    {
        return;
    }
    
    ref = vehicle vehicle::get_ref();
    expdamageradiussq = function_8832382ea33eb692( ref );
    damageablepartdata = get_part_data( ref );
    radiussquared = radius * radius;
    var_a6cb44236bf4ac6f = undefined;
    var_92117d7cc8d83c0c = undefined;
    var_f4f434fa13cd3d2c = undefined;
    
    foreach ( tagname, healthdata in vehicle.damageableparts )
    {
        if ( vehicle tagexists( tagname ) && damageablepartdata[ tagname ].var_f0bb6cc5e876fad5 )
        {
            var_4b0a0dc6f6033efb = distancesquared( point, vehicle gettagorigin( tagname ) );
            
            if ( var_4b0a0dc6f6033efb <= radiussquared && function_ea5f5ad915b3206f( vehicle, tagname ) && ( !isdefined( var_a6cb44236bf4ac6f ) || var_4b0a0dc6f6033efb < var_a6cb44236bf4ac6f ) )
            {
                var_a6cb44236bf4ac6f = var_4b0a0dc6f6033efb;
                var_92117d7cc8d83c0c = tagname;
                var_f4f434fa13cd3d2c = healthdata;
            }
        }
    }
    
    if ( isdefined( var_92117d7cc8d83c0c ) && isdefined( var_f4f434fa13cd3d2c ) )
    {
        if ( damageablepartdata[ var_92117d7cc8d83c0c ].var_ef2241083f89be87 != 0 && !var_f4f434fa13cd3d2c.damaged && function_badd1a49fc9ab374( vehicle, var_92117d7cc8d83c0c ) )
        {
            damage_part( vehicle, var_92117d7cc8d83c0c );
            return;
        }
        
        var_f4f434fa13cd3d2c.healthvalue = max( 0, var_f4f434fa13cd3d2c.healthvalue - damage );
        
        if ( is_part_dead( var_f4f434fa13cd3d2c ) )
        {
            kill_part( vehicle, var_92117d7cc8d83c0c );
        }
    }
}

// Namespace vehicle_damage
// Params 4
// Checksum 0x42a3328e, Offset: 0x770c
// Size: 0x283, Type: bool
function function_95120e6392cd14f1( vehicle, damage, point, wheelstodamage )
{
    if ( !( isdefined( vehicle ) && isdefined( vehicle.damageableparts ) ) || vehicle.damageableparts.size == 0 || wheelstodamage == 0 )
    {
        return false;
    }
    
    ref = vehicle vehicle::get_ref();
    damageablepartdata = get_part_data( ref );
    wheels = [];
    
    foreach ( tagname, healthdata in vehicle.damageableparts )
    {
        if ( !vehicle tagexists( tagname ) || !( isdefined( damageablepartdata[ tagname ].wheelref ) && isdefined( vehicle.damageableparts[ tagname ] ) ) || is_part_dead( vehicle.damageableparts[ tagname ] ) )
        {
            continue;
        }
        
        wheeldata = spawnstruct();
        wheeldata.origin = vehicle gettagorigin( tagname );
        wheeldata.tag = tagname;
        wheeldata.data = healthdata;
        wheels[ wheels.size ] = wheeldata;
    }
    
    if ( wheels.size == 0 )
    {
        return false;
    }
    
    if ( isdefined( point ) )
    {
        wheels = sortbydistance( wheels, point );
    }
    else
    {
        wheels = arrayrandomize( wheels );
    }
    
    foreach ( wheel in wheels )
    {
        wheel.data.healthvalue = max( 0, wheel.data.healthvalue - damage );
        
        if ( is_part_dead( wheel.data ) )
        {
            kill_part( vehicle, wheel.tag );
        }
        
        wheelstodamage -= 1;
        
        if ( wheelstodamage <= 0 )
        {
            return true;
        }
    }
    
    return true;
}

// Namespace vehicle_damage
// Params 2
// Checksum 0x1ffe682a, Offset: 0x7998
// Size: 0x3fa
function function_f983e067957101f2( vehicle, damagedata )
{
    tagnames = [];
    tagdistances = [];
    data = get_data( vehicle vehicle::get_ref() );
    
    if ( damagedata.partname && damagedata.partname != "tag_origin" && vehicle tagexists( damagedata.partname ) )
    {
        tagnames[ damagedata.partname ] = damagedata.partname;
    }
    
    if ( damagedata.attachtagname && damagedata.attachtagname != "tag_origin" && vehicle tagexists( damagedata.attachtagname ) )
    {
        tagnames[ damagedata.attachtagname ] = damagedata.attachtagname;
    }
    
    foreach ( tag in tagnames )
    {
        tagdistances[ tag ] = distancesquared( damagedata.point, vehicle gettagorigin( tag ) );
    }
    
    if ( isdefined( vehicle.damageableparts ) && vehicle.damageableparts.size > 0 && isexplosivedamagemod( damagedata.meansofdeath ) )
    {
        expdamageradiussq = data.expdamageradiussq;
        var_cf73a18783d75c7b = data.var_ad08183ba8a73943;
        
        foreach ( tagname, healthvalue in vehicle.damageableparts )
        {
            if ( vehicle tagexists( tagname ) && !is_part_dead( healthvalue ) && !isdefined( tagnames[ tagname ] ) )
            {
                distancesq = distancesquared( damagedata.point, vehicle gettagorigin( tagname ) );
                
                if ( distancesq <= expdamageradiussq )
                {
                    tagnames[ tagname ] = tagname;
                    tagdistances[ tagname ] = distancesq;
                }
            }
        }
        
        if ( tagdistances.size > var_cf73a18783d75c7b )
        {
            closesttagnames = [];
            
            for ( i = 0; i < var_cf73a18783d75c7b ; i++ )
            {
                closest = undefined;
                closestdistance = undefined;
                
                foreach ( tagname, tagdistance in tagdistances )
                {
                    if ( !isdefined( closestdistance ) || tagdistance < closestdistance )
                    {
                        closestdistance = tagdistance;
                        closest = tagname;
                    }
                }
                
                if ( isdefined( closest ) )
                {
                    closesttagnames[ i ] = closest;
                    tagdistances[ closest ] = undefined;
                    continue;
                }
                
                return closesttagnames;
            }
            
            return closesttagnames;
        }
    }
    
    if ( isdefined( data.var_a24bea462b38d510 ) )
    {
        foreach ( tagnamekey, tagnamevalue in tagnames )
        {
            if ( isdefined( data.var_a24bea462b38d510[ tagnamevalue ] ) )
            {
                tagnames[ tagnamekey ] = data.var_a24bea462b38d510[ tagnamevalue ];
            }
        }
    }
    
    return tagnames;
}

// Namespace vehicle_damage
// Params 2
// Checksum 0x85ce1321, Offset: 0x7d9b
// Size: 0xf3
function function_62b5a7480945627a( vehicleref, damageableparts )
{
    huskdamageableparts = function_18d800e98361417f( vehicleref );
    var_d46fcf6efb6584f9 = [];
    
    foreach ( tag, part in huskdamageableparts )
    {
        if ( isdefined( damageableparts[ tag ] ) )
        {
            var_d46fcf6efb6584f9[ tag ] = damageableparts[ tag ];
            continue;
        }
        
        var_b4b92133f6140876 = spawnstruct();
        var_b4b92133f6140876.healthvalue = part.healthvalue;
        var_b4b92133f6140876.explosivedamagehealthvalue = part.explosivedamagehealthvalue;
        var_d46fcf6efb6584f9[ tag ] = var_b4b92133f6140876;
    }
    
    return var_d46fcf6efb6584f9;
}

// Namespace vehicle_damage
// Params 3
// Checksum 0x9eaf9e9f, Offset: 0x7e97
// Size: 0x126
function function_f7cac766d4a43bba( vehicleref, damageableparts, isstatic )
{
    if ( !isdefined( damageableparts ) )
    {
        return;
    }
    
    var_b5fa492caf504f56 = !vehicle_tracking::get_base_spawn_data() vehicle_spawn::has_flag( 5 );
    
    foreach ( tagname, var_b4b92133f6140876 in damageableparts )
    {
        if ( should_hide_part( vehicleref, tagname, var_b4b92133f6140876 ) )
        {
            var_b4b92133f6140876.healthvalue = 0;
            hide_part( self, tagname, undefined );
            continue;
        }
        
        if ( should_destroy_part( vehicleref, tagname, var_b4b92133f6140876, isstatic ) )
        {
            if ( !var_b5fa492caf504f56 )
            {
                var_b4b92133f6140876.healthvalue = 0;
                hide_part( self, tagname, undefined );
            }
            else
            {
                kill_part( self, tagname, undefined );
            }
            
            continue;
        }
        
        if ( var_b4b92133f6140876.damaged )
        {
            damage_part( self, tagname );
        }
    }
}

// Namespace vehicle_damage
// Params 4
// Checksum 0x4fd30bab, Offset: 0x7fc5
// Size: 0x99, Type: bool
function should_destroy_part( vehicleref, parttag, healthvalues, isstatic = 0 )
{
    if ( isstatic && isdefined( get_part_data( vehicleref )[ parttag ].wheelref ) )
    {
        return false;
    }
    
    if ( healthvalues.damaged && !get_part_data( vehicleref )[ parttag ].var_61fb2f12d4523437 )
    {
        return true;
    }
    
    destructionchance = function_f2b615c14472e0a4( vehicleref, parttag );
    return randomint( 100 ) < destructionchance;
}

// Namespace vehicle_damage
// Params 3
// Checksum 0x4ca1ee00, Offset: 0x8067
// Size: 0x33, Type: bool
function should_hide_part( vehicleref, parttag, healthvalues )
{
    return function_2e51ef7ed0446ca7( vehicleref, parttag ) || is_part_dead( healthvalues );
}

// Namespace vehicle_damage
// Params 1
// Checksum 0x6cb75b50, Offset: 0x80a3
// Size: 0x52, Type: bool
function is_part_dead( var_2e99083896d72ad8 )
{
    if ( isstring( var_2e99083896d72ad8 ) )
    {
        var_b4b92133f6140876 = self.damageableparts[ var_2e99083896d72ad8 ];
    }
    else
    {
        var_b4b92133f6140876 = var_2e99083896d72ad8;
    }
    
    return var_b4b92133f6140876.healthvalue <= 0 || var_b4b92133f6140876.explosivedamagehealthvalue <= 0;
}

// Namespace vehicle_damage
// Params 2
// Checksum 0x294a8c8a, Offset: 0x80fe
// Size: 0x65, Type: bool
function function_badd1a49fc9ab374( vehicle, part )
{
    partdata = get_part_data( vehicle vehicle::get_ref() );
    
    if ( !partdata[ part ].hasdamagedstate )
    {
        return false;
    }
    
    if ( vehicle vehicle::is_husk() && !partdata[ part ].var_61fb2f12d4523437 )
    {
        return false;
    }
    
    return true;
}

// Namespace vehicle_damage
// Params 2
// Checksum 0x739ad610, Offset: 0x816c
// Size: 0xab
function function_e2e7b1a840f99653( vehicle, part )
{
    if ( !isdefined( vehicle.damageableparts[ part ].healthvalue ) )
    {
        return;
    }
    
    partdata = get_part_data( vehicle vehicle::get_ref() );
    
    if ( !partdata[ part ].hasdamagedstate )
    {
        return 0;
    }
    
    var_c1e3d757bf1e235a = ( partdata[ part ].damagedhealthpercent ?? 60 ) / 100 * partdata[ part ].healthvalue;
    return vehicle.damageableparts[ part ].healthvalue < var_c1e3d757bf1e235a;
}

// Namespace vehicle_damage
// Params 1
// Checksum 0x6cbd6943, Offset: 0x8220
// Size: 0x2b
function function_8832382ea33eb692( vehicleref )
{
    leveldataforvehicle = get_data( vehicleref );
    return leveldataforvehicle.expdamageradiussq;
}

// Namespace vehicle_damage
// Params 1
// Checksum 0xeba777d5, Offset: 0x8254
// Size: 0x1b
function function_d05a153bd013b437( damagedata )
{
    return isexplosivedamagemod( damagedata.meansofdeath );
}

// Namespace vehicle_damage
// Params 1, eflags: 0x4
// Checksum 0x3962f1d1, Offset: 0x8278
// Size: 0x339
function private begin_burn_down( data )
{
    self endon( #"death" );
    self endon( #"end_burn_down" );
    self notify( #"begin_burn_down" );
    ref = vehicle::get_ref();
    
    if ( self.var_1c590489c81560c9 )
    {
        thread vehicle::explode( data, 0 );
        return;
    }
    
    if ( !self.burningdown )
    {
        leveldataforvehicle = vehicle::get_data( ref );
        burndowntime = function_b78d1e92d6ea2ac1( ref, data.objweapon.basename );
        utility::script_func( "onBeginBurndown", data );
        self.burningdown = 1;
        
        if ( isdefined( data ) )
        {
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
            
            self.burndownattacker = data.attacker;
            
            if ( isdefined( data.objweapon ) )
            {
                self.burndownweapon = data.objweapon;
            }
            else
            {
                self.burndownweapon = undefined;
            }
            
            /#
                if ( isdefined( data.attacker ) )
                {
                    assert( isdefined( data.objweapon ), "<dev string:x278>" );
                    assert( isdefined( data.objweapon ) && isdefined( data.objweapon.basename ), "<dev string:x2d0>" );
                }
            #/
        }
        
        occupants = vehicle_occupancy::function_8ed9bcd8e9ea74f5( self, 0 );
        
        if ( isdefined( occupants ) )
        {
            vehicle_omnvar::show_warning( "burningDown", occupants, ref );
        }
        
        if ( utility::issharedfuncdefined( ref, #"beginBurnDown" ) )
        {
            [[ utility::getsharedfunc( ref, #"beginBurnDown" ) ]]();
        }
        
        callback::callback( #"hash_c3a49dc6a4b72b73", data );
        explosiondata = vehicle::is_husk() || self.dontspawnhusk && isdefined( leveldataforvehicle.huskexplosion ) ? leveldataforvehicle.huskexplosion : leveldataforvehicle.pristineexplosion;
        radius = int( explosiondata.radius ?? 250 ) + 50;
        childthread function_3713d15304443663( data, burndowntime, radius );
        wait burndowntime;
        self.burningdown = undefined;
        deathfunc = level.vehicles.deathcallback ?? &vehicle::explode;
        self thread [[ deathfunc ]]( data );
        return;
    }
}

// Namespace vehicle_damage
// Params 3, eflags: 0x4
// Checksum 0xfb93ceb7, Offset: 0x85b9
// Size: 0x35d
function private function_3713d15304443663( data, burndowntime, radius )
{
    if ( vehicle::is_static() )
    {
        wait burndowntime;
        
        if ( utility::issp() )
        {
            self notify( #"death" );
        }
        else if ( isdefined( level.vehicles.deathcallback ) )
        {
            level thread [[ level.vehicles.deathcallback ]]( { #direction_vec:( 0, 0, 0 ), #point:( 0, 0, 0 ), #meansofdeath:"MOD_UNKNOWN", #damage:self.health, #victim:self } );
        }
        
        return;
    }
    
    remaininghealth = self.health;
    
    if ( isdefined( data ) && isdefined( data.damage ) )
    {
        remaininghealth = self.health - data.damage;
    }
    
    if ( burndowntime == 0 )
    {
        var_c64f4d1e3ae6e664 = 1;
        damagepertick = int( ceil( remaininghealth / 0.25 ) );
    }
    else
    {
        var_c64f4d1e3ae6e664 = int( ceil( burndowntime / 1 ) );
        damagepertick = int( ceil( remaininghealth / var_c64f4d1e3ae6e664 / 0.25 ) );
    }
    
    badplaceorigin = undefined;
    
    for ( i = 0; i < var_c64f4d1e3ae6e664 ; i++ )
    {
        wait 1;
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        self dodamage( damagepertick, self.origin );
        function_4716d5b665e24428( self );
        
        if ( i > 1 )
        {
            if ( !isdefined( badplaceorigin ) && utility::level_supports_ai() )
            {
                badplaceorigin = self.origin;
                
                if ( isdefined( level.var_3d90777bfb7fc504 ) )
                {
                    self.explosionbadplace = function_8c64f71738a17713( badplaceorigin, ( 0, 0, 0 ), 8, radius, radius, level.var_3d90777bfb7fc504 );
                }
                else
                {
                    self.explosionbadplace = createnavbadplacebyshape( badplaceorigin, ( 0, 0, 0 ), 8, radius, radius );
                }
                
                foreach ( agent in utility::agentsnear( badplaceorigin, radius ) )
                {
                    agent.stealth_idledemeanor = "combat";
                    agent.var_b52fca22f7f1e144 = "combat";
                }
            }
            
            if ( isdefined( badplaceorigin ) && isdefined( self.origin ) && isdefined( self.explosionbadplace ) && distance( badplaceorigin, self.origin ) > 100 )
            {
                destroynavobstacle( self.explosionbadplace );
                badplaceorigin = self.origin;
                
                if ( isdefined( level.var_3d90777bfb7fc504 ) )
                {
                    self.explosionbadplace = function_8c64f71738a17713( badplaceorigin, ( 0, 0, 0 ), 8, radius, radius, level.var_3d90777bfb7fc504 );
                    continue;
                }
                
                self.explosionbadplace = createnavbadplacebyshape( badplaceorigin, ( 0, 0, 0 ), 8, radius, radius );
            }
        }
    }
}

// Namespace vehicle_damage
// Params 1, eflags: 0x4
// Checksum 0x5e5a9098, Offset: 0x891e
// Size: 0x64
function private end_burn_down( fromdeath )
{
    if ( !self.burningdown )
    {
        return;
    }
    
    self notify( #"end_burn_down" );
    
    if ( !fromdeath )
    {
        occupants = vehicle_occupancy::function_8ed9bcd8e9ea74f5( self, 0 );
        
        if ( isdefined( occupants ) )
        {
            vehicle_omnvar::hide_warning( "burningDown", occupants, vehicle::get_ref() );
        }
    }
    
    self.burningdown = undefined;
}

// Namespace vehicle_damage
// Params 0
// Checksum 0xfc2e98f9, Offset: 0x898a
// Size: 0xc, Type: bool
function is_burning_down()
{
    return istrue( self.burningdown );
}

// Namespace vehicle_damage
// Params 2
// Checksum 0x76bc923c, Offset: 0x899f
// Size: 0x310
function function_b78d1e92d6ea2ac1( vehicleref, weaponname )
{
    var_7237854e3be197ca = self.var_d17d7176fa6477c9;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    leveldata = get_level_data();
    burndowntimes = [ leveldata.burndowntime ];
    vehicledata = get_data( vehicleref );
    
    if ( isdefined( vehicledata.burndowntime ) )
    {
        burndowntimes[ burndowntimes.size ] = vehicledata.burndowntime;
    }
    
    if ( isdefined( self.burndowntime ) )
    {
        burndowntimes[ burndowntimes.size ] = self.burndowntime;
    }
    
    if ( isdefined( vehicledata.class ) && isdefined( weaponname ) && vehicledata.class != "none" )
    {
        hash = getxhash( weaponname );
        tableburndowntime = undefined;
        
        if ( isdefined( leveldata.table.var_2d338257de595229[ hash ] ) )
        {
            switch ( vehicledata.class )
            {
                case #"hash_d2a55c7ac538641b":
                    tableburndowntime = leveldata.table.var_2d338257de595229[ hash ].super_light;
                    break;
                case #"hash_d582c3286e5c390f":
                    tableburndowntime = leveldata.table.var_2d338257de595229[ hash ].light;
                    break;
                case #"hash_21622ca3ad06efb5":
                    tableburndowntime = leveldata.table.var_2d338257de595229[ hash ].medium_light;
                    break;
                case #"hash_c71b112fe04823d6":
                    tableburndowntime = leveldata.table.var_2d338257de595229[ hash ].medium;
                    break;
                case #"hash_53e0b558455f04c6":
                    tableburndowntime = leveldata.table.var_2d338257de595229[ hash ].medium_heavy;
                    break;
                case #"hash_2453c9ffec9f5c20":
                    tableburndowntime = leveldata.table.var_2d338257de595229[ hash ].heavy;
                    break;
                case #"hash_e8ec392f4f2724e4":
                    tableburndowntime = leveldata.table.var_2d338257de595229[ hash ].super_heavy;
                    break;
            }
        }
        
        if ( isdefined( tableburndowntime ) )
        {
            burndowntimes[ burndowntimes.size ] = tableburndowntime;
        }
    }
    
    mintime = burndowntimes[ 0 ];
    
    foreach ( time in burndowntimes )
    {
        mintime = min( time, mintime );
    }
    
    return mintime;
}

// Namespace vehicle_damage
// Params 1
// Checksum 0x82d26aed, Offset: 0x8cb8
// Size: 0x335
function function_bbbc556bc9d51672( data )
{
    if ( level.var_7de0db416e5d903b && isdefined( data.victim ) && data.victim.maxhealth == data.victim.health && isdefined( data.damage ) && data.damage >= data.victim.maxhealth )
    {
        return 0;
    }
    
    if ( vehicle::is_killstreak() )
    {
        return 1;
    }
    
    if ( isdefined( data.meansofdeath ) )
    {
        if ( !isexplosivedamagemod( data.meansofdeath ) && data.meansofdeath != "MOD_FIRE" )
        {
            return 0;
        }
        
        if ( data.meansofdeath == "MOD_CRUSH" )
        {
            return 1;
        }
    }
    
    objweapon = data.objweapon;
    
    if ( isdefined( objweapon ) && isdefined( vehicle::get_ref() ) && !isnullweapon( objweapon ) )
    {
        shouldskipburndown = undefined;
        vehiclename = vehicle::get_ref();
        leveldataforvehicle = get_data( vehiclename, undefined, 1 );
        
        if ( isdefined( leveldataforvehicle ) )
        {
            classname = leveldataforvehicle.class;
            
            if ( !isdefined( classname ) || classname == "none" )
            {
                return 1;
            }
            
            if ( leveldataforvehicle.skipburndown )
            {
                return 1;
            }
            
            leveldata = get_level_data();
            table = leveldata.table;
            weaponname = objweapon.basename;
            hash = getxhash( weaponname );
            
            if ( isdefined( table.var_fc11f9579ab02463[ hash ] ) )
            {
                switch ( classname )
                {
                    case #"hash_d2a55c7ac538641b":
                        shouldskipburndown = table.var_fc11f9579ab02463[ hash ].super_light;
                        break;
                    case #"hash_d582c3286e5c390f":
                        shouldskipburndown = table.var_fc11f9579ab02463[ hash ].light;
                        break;
                    case #"hash_21622ca3ad06efb5":
                        shouldskipburndown = table.var_fc11f9579ab02463[ hash ].medium_light;
                        break;
                    case #"hash_c71b112fe04823d6":
                        shouldskipburndown = table.var_fc11f9579ab02463[ hash ].medium;
                        break;
                    case #"hash_53e0b558455f04c6":
                        shouldskipburndown = table.var_fc11f9579ab02463[ hash ].medium_heavy;
                        break;
                    case #"hash_2453c9ffec9f5c20":
                        shouldskipburndown = table.var_fc11f9579ab02463[ hash ].heavy;
                        break;
                    case #"hash_e8ec392f4f2724e4":
                        shouldskipburndown = table.var_fc11f9579ab02463[ hash ].super_heavy;
                        break;
                }
            }
            
            var_7237854e3be197ca = shouldskipburndown;
            
            if ( isdefined( var_7237854e3be197ca ) )
            {
                return var_7237854e3be197ca;
            }
        }
        else
        {
            return 1;
        }
    }
    else
    {
        return 1;
    }
    
    return 0;
}

// Namespace vehicle_damage
// Params 1
// Checksum 0x6404ecf4, Offset: 0x8ff6
// Size: 0x1e
function get_weapon_string( vehicleref )
{
    return vehicle::get_data( vehicleref ).weapon;
}

// Namespace vehicle_damage
// Params 1
// Checksum 0xc691590e, Offset: 0x901d
// Size: 0x2b
function get_husk_weapon_string( vehicleref )
{
    data = vehicle::get_data( vehicleref );
    return data.weapon;
}

// Namespace vehicle_damage
// Params 0
// Checksum 0x7c8038f6, Offset: 0x9051
// Size: 0x30c
function explode()
{
    if ( !vehicle::can_explode() )
    {
        return;
    }
    
    ref = vehicle::get_ref();
    data = vehicle::get_data( ref );
    ishusk = vehicle::is_husk();
    explosiondata = ishusk || self.dontspawnhusk && isdefined( data.huskexplosion ) ? data.huskexplosion : data.pristineexplosion;
    weaponstring = ishusk ? get_husk_weapon_string( ref ) : get_weapon_string( ref );
    mtx = self.mtx;
    waittillframeend();
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    assert( isdefined( explosiondata ), "<dev string:x346>" );
    explosionposition = self gettagorigin( explosiondata.tag );
    damageposition = explosionposition;
    
    if ( isdefined( explosiondata.damageoffset ) )
    {
        damageposition += rotatevector( ( explosiondata.damageoffset.x ?? 0, explosiondata.damageoffset.y ?? 0, explosiondata.damageoffset.z ?? 0 ), self.angles );
    }
    
    attacker = self.burndownattacker ?? self;
    
    if ( !isent( attacker ) )
    {
        attacker = undefined;
    }
    
    self radiusdamage( damageposition, explosiondata.radius, explosiondata.maxdamage, explosiondata.mindamage, attacker, "MOD_EXPLOSIVE", weaponstring );
    self stopsounds();
    explosionstring = vehicle::is_husk() ? "_husk_explosion" : "_explosion";
    fxname = isxhashasset( vehicle::get_ref() ) ? hashcat( vehicle::get_ref(), explosionstring ) : vehicle::get_ref() + explosionstring;
    function_c10f854d96e7458f( explosiondata, damageposition, fxname, mtx );
    
    if ( level.projectbundle.var_f58a6e2322572bc2 && function_4042d2fbe6237835( #"hash_f13e37a2307443e0" ) )
    {
        level.projectbundle.var_f58a6e2322572bc2 = 0;
    }
    
    if ( level.projectbundle.var_f58a6e2322572bc2 && isdefined( explosiondata.shockwave ) )
    {
        utility::function_ce86ddbb7d60e9bd( explosionposition, explosiondata.shockwave, self.owner );
    }
    else
    {
        if ( explosiondata.earthquakescale > 0 )
        {
            earthquake( explosiondata.earthquakescale, explosiondata.earthquakeduration, explosionposition, explosiondata.earthquakeradius );
        }
        
        playrumbleonposition( "grenade_rumble", explosionposition );
    }
    
    physicsexplosionsphere( explosionposition, explosiondata.physicsouterradius, explosiondata.physicsinnerradius, explosiondata.physicsscale );
}

// Namespace vehicle_damage
// Params 4
// Checksum 0xf3a324f0, Offset: 0x9365
// Size: 0x13c
function function_c10f854d96e7458f( explosiondata, explosionposition, explosionfxname, mtx )
{
    if ( isdefined( explosiondata.scriptable ) )
    {
        explosionscriptable = spawn( "script_model", explosionposition );
        explosionscriptable setmodel( explosiondata.scriptable );
        explosionscriptable.angles = self.angles;
        
        if ( isdefined( mtx.var_d461a71290fd3dcd ) && explosionscriptable getscriptableparthasstate( "explosion", mtx.var_d461a71290fd3dcd ) )
        {
            explosionscriptable setscriptablepartstate( "explosion", mtx.var_d461a71290fd3dcd );
        }
        else
        {
            explosionscriptable setscriptablepartstate( "explosion", "on" );
        }
        
        explosionscriptable utility::delaycall( explosiondata.scriptablelifetime ?? 7, &delete );
        return;
    }
    
    if ( utility::fxexists( explosionfxname ) )
    {
        playfx( utility::getfx( explosionfxname ), explosionposition, anglestoforward( self.angles ), anglestoup( self.angles ) );
    }
    
    if ( isdefined( explosiondata.sfx ) )
    {
        playsoundatpos( explosionposition, explosiondata.sfx );
    }
}

// Namespace vehicle_damage
// Params 0
// Checksum 0xc1d7a98, Offset: 0x94a9
// Size: 0x13
function function_2fec514ed5f9106d()
{
    if ( vehicle::is_husk() )
    {
        return 0;
    }
    
    return 1;
}

// Namespace vehicle_damage
// Params 2
// Checksum 0x25bfa5ca, Offset: 0x94c4
// Size: 0x242
function function_6c7722241a521e9( oldstateref, data )
{
    if ( isdefined( data ) && isdefined( data.attacker ) )
    {
        leveldataforvehicle = get_data( vehicle::get_ref(), undefined, 1 );
        
        if ( isdefined( leveldataforvehicle ) )
        {
            instancedataforvehicle = get_instance_data( self, undefined, 1 );
            scoreevent = undefined;
            var_3eb1a94a2f14121 = undefined;
            award = undefined;
            awardlaunchonly = undefined;
            
            if ( isdefined( instancedataforvehicle ) )
            {
                scoreevent = instancedataforvehicle.heavydamagescoreevent;
                var_3eb1a94a2f14121 = instancedataforvehicle.heavydamagescorelaunchonly;
                award = instancedataforvehicle.heavydamageaward;
                awardlaunchonly = instancedataforvehicle.heavydamageawardlaunchonly;
            }
            
            if ( isdefined( leveldataforvehicle.class ) )
            {
                if ( !isdefined( scoreevent ) )
                {
                    switch ( leveldataforvehicle.class )
                    {
                        case #"hash_d2a55c7ac538641b":
                        case #"hash_d582c3286e5c390f":
                            scoreevent = #"disabled_vehicle_light";
                            break;
                        case #"hash_21622ca3ad06efb5":
                        case #"hash_53e0b558455f04c6":
                        case #"hash_c71b112fe04823d6":
                            scoreevent = #"disabled_vehicle_medium";
                            break;
                        case #"hash_2453c9ffec9f5c20":
                        case #"hash_e8ec392f4f2724e4":
                            scoreevent = #"disabled_vehicle_heavy";
                            break;
                    }
                }
                
                if ( !isdefined( award ) )
                {
                }
            }
            
            if ( scoreevent == #"none" )
            {
                scoreevent = undefined;
            }
            
            if ( award == "none" )
            {
                award = undefined;
            }
            
            if ( !data.givepointsandxp && isplayer( data.attacker ) )
            {
                data.givepointsandxp = vehicle::is_enemy_to_player( self, data.attacker );
            }
            
            if ( isdefined( data.objweapon ) && weaponclass( data.objweapon.basename ) != "rocketlauncher" )
            {
                if ( var_3eb1a94a2f14121 )
                {
                    data.scoreeventnoweaponxp = 1;
                }
                
                if ( awardlaunchonly )
                {
                    data.awardnoweaponxp = 1;
                }
            }
            
            data.attacker thread function_d060bb312634dea7( scoreevent, award, data, self );
        }
    }
}

// Namespace vehicle_damage
// Params 1
// Checksum 0x722703d8, Offset: 0x970e
// Size: 0x356
function on_death_score( data )
{
    if ( vehicle::is_killstreak() || self.alreadydestroyed )
    {
        return;
    }
    
    if ( isdefined( data ) && isdefined( data.attacker ) )
    {
        leveldataforvehicle = get_data( vehicle::get_ref(), undefined, 1 );
        
        if ( isdefined( leveldataforvehicle ) )
        {
            instancedataforvehicle = get_instance_data( self, undefined, 1 );
            scoreevent = undefined;
            var_3eb1a94a2f14121 = undefined;
            award = undefined;
            awardlaunchonly = undefined;
            
            if ( isdefined( instancedataforvehicle ) )
            {
                scoreevent = instancedataforvehicle.destroyscoreevent;
                var_3eb1a94a2f14121 = instancedataforvehicle.destroyscorelaunchonly;
                award = instancedataforvehicle.destroyaward;
                awardlaunchonly = instancedataforvehicle.destroyawardlaunchonly;
            }
            
            if ( isdefined( leveldataforvehicle.class ) )
            {
                if ( !isdefined( scoreevent ) )
                {
                    switch ( leveldataforvehicle.class )
                    {
                        case #"hash_d2a55c7ac538641b":
                        case #"hash_d582c3286e5c390f":
                            scoreevent = #"destroyed_vehicle_light";
                            break;
                        case #"hash_21622ca3ad06efb5":
                        case #"hash_53e0b558455f04c6":
                        case #"hash_c71b112fe04823d6":
                            scoreevent = #"destroyed_vehicle_medium";
                            break;
                        case #"hash_2453c9ffec9f5c20":
                        case #"hash_e8ec392f4f2724e4":
                            scoreevent = #"destroyed_vehicle_heavy";
                            break;
                        default:
                            scoreevent = #"none";
                            break;
                    }
                }
                
                if ( !isdefined( award ) )
                {
                }
            }
            
            if ( scoreevent == #"none" )
            {
                scoreevent = undefined;
            }
            
            if ( award == "none" )
            {
                award = undefined;
            }
            
            if ( isplayer( data.attacker ) )
            {
                if ( !isdefined( data.givepointsandxp ) )
                {
                    data.givepointsandxp = vehicle::is_enemy_to_player( self, data.attacker );
                }
                else if ( data.givepointsandxp && vehicle::is_friendly_to_player( self, data.attacker ) )
                {
                    data.givepointsandxp = 0;
                }
                else if ( !data.givepointsandxp && vehicle::is_enemy_to_player( self, data.attacker ) )
                {
                    data.givepointsandxp = 1;
                }
            }
            else
            {
                data.givepointsandxp = 0;
            }
            
            if ( isdefined( data.objweapon ) && weaponclass( data.objweapon.basename ) != "rocketlauncher" )
            {
                if ( var_3eb1a94a2f14121 )
                {
                    data.scoreeventnoweaponxp = 1;
                }
                
                if ( awardlaunchonly )
                {
                    data.awardnoweaponxp = 1;
                }
            }
            
            data.attacker function_1921aed0ac6366ed( scoreevent, award, data, self getentitynumber() );
            self.alreadydestroyed = 1;
        }
        
        if ( utility::issharedfuncdefined( #"challenges", #"onVehicleKilled" ) )
        {
            data.attacker thread [[ utility::getsharedfunc( #"challenges", #"onVehicleKilled" ) ]]( self, data.attacker, data.damage, data.objweapon );
        }
    }
}

// Namespace vehicle_damage
// Params 1
// Checksum 0xd29d3842, Offset: 0x9a6c
// Size: 0x94
function process_scrap_assist( data )
{
    vehicleref = vehicle::get_ref();
    
    if ( isdefined( vehicleref ) && isdefined( data ) )
    {
        vehicledata = get_data( vehicleref );
        
        if ( isdefined( vehicledata ) && vehicledata.scrapassist && utility::issharedfuncdefined( #"killstreak", #"processscrapassist" ) )
        {
            self thread [[ utility::getsharedfunc( #"killstreak", #"processscrapassist" ) ]]( data.attacker );
        }
    }
}

// Namespace vehicle_damage
// Params 4, eflags: 0x4
// Checksum 0x32484b04, Offset: 0x9b08
// Size: 0x6a
function private function_d060bb312634dea7( scoreevent, award, data, vehicle )
{
    if ( vehicle vehicle::is_killstreak() )
    {
        return;
    }
    
    vehentnum = vehicle getentitynumber();
    self endon( #"disconnect" );
    self endon( "vehicle_damage_giveScoreAndXP" + vehentnum );
    waittillframeend();
    thread function_1921aed0ac6366ed( scoreevent, award, data, vehentnum );
}

// Namespace vehicle_damage
// Params 4, eflags: 0x4
// Checksum 0xa3a05e6b, Offset: 0x9b7a
// Size: 0x114
function private function_1921aed0ac6366ed( scoreevent, award, data, vehentnum )
{
    self notify( "vehicle_damage_giveScoreAndXP" + vehentnum );
    
    if ( isdefined( scoreevent ) && utility::issharedfuncdefined( #"vehicle_damage", #"givescore" ) )
    {
        objweapon = data.scoreeventnoweaponxp ? undefined : data.objweapon;
        self [[ utility::getsharedfunc( #"vehicle_damage", #"givescore" ) ]]( scoreevent, objweapon, !data.givepointsandxp );
    }
    
    if ( isdefined( award ) && utility::issharedfuncdefined( #"vehicle_damage", #"giveaward" ) )
    {
        objweapon = data.awardnoweaponxp ? undefined : data.objweapon;
        self [[ utility::getsharedfunc( #"vehicle_damage", #"giveaward" ) ]]( award, objweapon, !data.givepointsandxp );
    }
}

// Namespace vehicle_damage
// Params 0, eflags: 0x4
// Checksum 0xae602e35, Offset: 0x9c96
// Size: 0x59
function private init_hit_damage_data()
{
    assert( isdefined( level.vehicle ), "<dev string:x3e6>" );
    data = spawnstruct();
    level.vehicle.hitdamage = data;
    data.vehicles = [];
    data.weapons = [];
}

// Namespace vehicle_damage
// Params 0, eflags: 0x4
// Checksum 0xc29d64b5, Offset: 0x9cf7
// Size: 0x73
function private init_mod_damage_data()
{
    assert( isdefined( level.vehicle ), "<dev string:x42a>" );
    data = spawnstruct();
    level.vehicle.moddamage = data;
    data.vehicles = [];
    data.weaponclasses = [];
    data.perks = [];
    data.attachments = [];
}

// Namespace vehicle_damage
// Params 3
// Checksum 0xa77bc948, Offset: 0x9d72
// Size: 0x146
function get_hit_damage( damage, vehicle, objweapon )
{
    vehicleref = vehicle vehicle::get_ref();
    weaponref = objweapon.basename;
    vehicledata = get_vehicle_hit_damage_data( vehicleref );
    weapondata = get_weapon_hit_damage_data( weaponref );
    
    if ( isdefined( vehicledata ) && isdefined( weapondata ) )
    {
        hitstokill = weapondata.vehiclehitstokill[ vehicleref ];
        
        if ( !isdefined( hitstokill ) || hitstokill == 0 )
        {
            hitstokill = vehicledata.hitstokill;
        }
        
        hitsperattack = vehicledata.weaponhitsperattack[ weaponref ];
        
        if ( !isdefined( hitsperattack ) || hitsperattack == 0 )
        {
            hitsperattack = weapondata.hitsperattack;
        }
        
        if ( hitstokill > 0 && hitsperattack > 0 && !vehicle.debugdamage )
        {
            healthratio = hitsperattack / hitstokill;
            maxhealth = get_data( vehicleref ).health ?? vehicle.maxhealth;
            damage = int( ceil( healthratio * maxhealth ) );
        }
    }
    
    return damage;
}

// Namespace vehicle_damage
// Params 4
// Checksum 0x15538593, Offset: 0x9ec1
// Size: 0x45
function get_mod_damage( damage, vehicle, objweapon, attacker )
{
    modifier = get_mod_damage_modifier( vehicle, objweapon, attacker );
    return ceil( damage * modifier );
}

// Namespace vehicle_damage
// Params 3, eflags: 0x4
// Checksum 0x3a6491fe, Offset: 0x9f0f
// Size: 0x318
function private get_mod_damage_modifier( vehicle, objweapon, attacker )
{
    assert( vehicle vehicle::is_vehicle(), "<dev string:x46e>" );
    assert( isdefined( objweapon ), "<dev string:x4a8>" );
    modifier = 0;
    var_24113db7b0ea127d = 1;
    vehicleref = vehicle vehicle::get_ref();
    vehicledata = get_vehicle_mod_damage_data( vehicleref );
    
    if ( isdefined( vehicledata ) )
    {
        weaponclassref = objweapon.classname;
        weaponclassdata = get_weapon_class_mod_damage_data( weaponclassref );
        
        if ( isdefined( weaponclassdata ) )
        {
            var_cf498c8cc6bcacae = vehicledata.weaponclassdata[ weaponclassref ];
            
            if ( isdefined( var_cf498c8cc6bcacae ) )
            {
                weaponclassdata = var_cf498c8cc6bcacae;
            }
            
            if ( weaponclassdata.modifier != 0 )
            {
                if ( weaponclassdata.ismultiplicative )
                {
                    var_24113db7b0ea127d *= weaponclassdata.modifier;
                }
                else
                {
                    modifier += weaponclassdata.modifier;
                }
            }
        }
        
        if ( isdefined( attacker ) && isdefined( attacker.perks ) )
        {
            foreach ( perkref, stackcount in attacker.perks )
            {
                perkdata = get_perk_mod_damage_data( perkref );
                
                if ( isdefined( perkdata ) )
                {
                    var_69060e8a58f7c7d2 = vehicledata.perkdata[ perkref ];
                    
                    if ( isdefined( var_69060e8a58f7c7d2 ) )
                    {
                        perkdata = var_69060e8a58f7c7d2;
                    }
                    
                    if ( perkdata.modifier != 0 )
                    {
                        if ( perkdata.ismultiplicative )
                        {
                            var_24113db7b0ea127d *= perkdata.modifier;
                            continue;
                        }
                        
                        modifier += perkdata.modifier;
                    }
                }
            }
        }
        
        if ( isdefined( objweapon.attachments ) )
        {
            foreach ( attachmentref in objweapon.attachments )
            {
                attachmentref = attachmentref;
                attachmentdata = get_attachment_mod_damage_data( attachmentref );
                
                if ( isdefined( attachmentdata ) )
                {
                    var_fb81c3cdc0040af3 = vehicledata.attachmentdata[ attachmentref ];
                    
                    if ( isdefined( var_fb81c3cdc0040af3 ) )
                    {
                        attachmentdata = var_fb81c3cdc0040af3;
                    }
                    
                    if ( attachmentdata.modifier != 0 )
                    {
                        if ( attachmentdata.ismultiplicative )
                        {
                            var_24113db7b0ea127d *= attachmentdata.modifier;
                            continue;
                        }
                        
                        modifier += attachmentdata.modifier;
                    }
                }
            }
        }
    }
    
    return modifier + var_24113db7b0ea127d;
}

// Namespace vehicle_damage
// Params 4
// Checksum 0x7568039f, Offset: 0xa230
// Size: 0xaf
function function_86431c2d7f105aee( weaponclass, mod, var_39391a3c00d2aba0, vehicleref )
{
    if ( var_39391a3c00d2aba0 )
    {
        assert( mod > 0, "<dev string:x4e4>" );
    }
    
    vehicledata = get_vehicle_mod_damage_data( vehicleref, 1 );
    get_weapon_class_mod_damage_data( weaponclass, 1 );
    data = vehicledata.weaponclassdata[ weaponclass ];
    
    if ( !isdefined( data ) )
    {
        data = create_mod_damage_data_empty();
    }
    
    data.modifier = mod;
    data.ismultiplicative = var_39391a3c00d2aba0;
    vehicledata.weaponclassdata[ weaponclass ] = data;
}

// Namespace vehicle_damage
// Params 3
// Checksum 0xfddcf991, Offset: 0xa2e7
// Size: 0x66
function set_perk_mod_damage( ref, mod, var_39391a3c00d2aba0 )
{
    if ( var_39391a3c00d2aba0 )
    {
        assert( mod > 0, "<dev string:x4e4>" );
    }
    
    data = get_perk_mod_damage_data( ref, 1 );
    data.modifier = mod;
    data.ismultiplicative = var_39391a3c00d2aba0;
}

// Namespace vehicle_damage
// Params 2
// Checksum 0x130e618d, Offset: 0xa355
// Size: 0x9b
function get_perk_mod_damage_data( ref, create )
{
    assert( isdefined( level.vehicle.moddamage ), "<dev string:x50c>" );
    data = level.vehicle.moddamage.perks[ ref ];
    
    if ( !isdefined( data ) && create )
    {
        data = create_mod_damage_data_empty();
        level.vehicle.moddamage.perks[ ref ] = data;
    }
    
    return data;
}

// Namespace vehicle_damage
// Params 0
// Checksum 0xcfa6c050, Offset: 0xa3f9
// Size: 0x2e
function create_mod_damage_data_empty()
{
    data = spawnstruct();
    data.modifier = 0;
    data.ismultiplicative = 0;
    return data;
}

// Namespace vehicle_damage
// Params 2
// Checksum 0xea06158a, Offset: 0xa430
// Size: 0x4a
function set_weapon_hit_damage_data( weaponref, hitsperattack )
{
    assert( hitsperattack > 0, "<dev string:x54d>" );
    data = get_weapon_hit_damage_data( weaponref, 1 );
    data.hitsperattack = hitsperattack;
}

// Namespace vehicle_damage
// Params 2
// Checksum 0xc9880bc, Offset: 0xa482
// Size: 0xc1
function get_weapon_hit_damage_data( ref, create )
{
    assert( isdefined( level.vehicle.hitdamage ), "<dev string:x577>" );
    data = level.vehicle.hitdamage.weapons[ ref ];
    
    if ( !isdefined( data ) && create )
    {
        data = spawnstruct();
        data.ref = ref;
        data.hitsperattack = 0;
        data.vehiclehitstokill = [];
        level.vehicle.hitdamage.weapons[ ref ] = data;
    }
    
    return data;
}

// Namespace vehicle_damage
// Params 2
// Checksum 0x773635a1, Offset: 0xa54c
// Size: 0x4a
function set_vehicle_hit_damage_data( ref, hitstokill )
{
    assert( hitstokill > 0, "<dev string:x5be>" );
    data = get_vehicle_hit_damage_data( ref, 1 );
    data.hitstokill = hitstokill;
}

// Namespace vehicle_damage
// Params 3
// Checksum 0xc8948fb2, Offset: 0xa59e
// Size: 0x69
function set_vehicle_hit_damage_data_for_weapon( ref, hitstokill, weaponref )
{
    assert( hitstokill > 0, "<dev string:x5be>" );
    data = get_vehicle_hit_damage_data( ref, 1 );
    weapondata = get_weapon_hit_damage_data( weaponref, 1 );
    weapondata.vehiclehitstokill[ ref ] = hitstokill;
}

// Namespace vehicle_damage
// Params 3
// Checksum 0x7da4fa72, Offset: 0xa60f
// Size: 0x69
function set_weapon_hit_damage_data_for_vehicle( weaponref, hitsperattack, vehicleref )
{
    assert( hitsperattack > 0, "<dev string:x54d>" );
    data = get_weapon_hit_damage_data( weaponref, 1 );
    vehicledata = get_vehicle_hit_damage_data( vehicleref, 1 );
    vehicledata.weaponhitsperattack[ weaponref ] = hitsperattack;
}

// Namespace vehicle_damage
// Params 2
// Checksum 0x953d19d, Offset: 0xa680
// Size: 0xc1
function get_vehicle_hit_damage_data( ref, create )
{
    assert( isdefined( level.vehicle.hitdamage ), "<dev string:x5e5>" );
    data = level.vehicle.hitdamage.vehicles[ ref ];
    
    if ( !isdefined( data ) && create )
    {
        data = spawnstruct();
        data.ref = ref;
        data.hitstokill = 0;
        data.weaponhitsperattack = [];
        level.vehicle.hitdamage.vehicles[ ref ] = data;
    }
    
    return data;
}

// Namespace vehicle_damage
// Params 2
// Checksum 0xde005189, Offset: 0xa74a
// Size: 0xc0
function get_vehicle_mod_damage_data( ref, create )
{
    assert( isdefined( level.vehicle.moddamage ), "<dev string:x62d>" );
    data = level.vehicle.moddamage.vehicles[ ref ];
    
    if ( !isdefined( data ) && create )
    {
        data = spawnstruct();
        data.weaponclassdata = [];
        data.perkdata = [];
        data.attachmentdata = [];
        level.vehicle.moddamage.vehicles[ ref ] = data;
    }
    
    return data;
}

// Namespace vehicle_damage
// Params 2
// Checksum 0x9e90f210, Offset: 0xa813
// Size: 0x9b
function get_weapon_class_mod_damage_data( ref, create )
{
    assert( isdefined( level.vehicle.moddamage ), "<dev string:x671>" );
    data = level.vehicle.moddamage.weaponclasses[ ref ];
    
    if ( !isdefined( data ) && create )
    {
        data = create_mod_damage_data_empty();
        level.vehicle.moddamage.weaponclasses[ ref ] = data;
    }
    
    return data;
}

// Namespace vehicle_damage
// Params 2
// Checksum 0x2d692360, Offset: 0xa8b7
// Size: 0x9b
function get_attachment_mod_damage_data( ref, create )
{
    assert( isdefined( level.vehicle.moddamage ), "<dev string:x6ba>" );
    data = level.vehicle.moddamage.attachments[ ref ];
    
    if ( !isdefined( data ) && create )
    {
        data = create_mod_damage_data_empty();
        level.vehicle.moddamage.attachments[ ref ] = data;
    }
    
    return data;
}

// Namespace vehicle_damage
// Params 3
// Checksum 0xcdfd712f, Offset: 0xa95b
// Size: 0x66
function set_weapon_class_mod_damage_data( ref, mod, var_39391a3c00d2aba0 )
{
    if ( var_39391a3c00d2aba0 )
    {
        assert( mod > 0, "<dev string:x4e4>" );
    }
    
    data = get_weapon_class_mod_damage_data( ref, 1 );
    data.modifier = mod;
    data.ismultiplicative = var_39391a3c00d2aba0;
}

// Namespace vehicle_damage
// Params 3
// Checksum 0xb743e48e, Offset: 0xa9c9
// Size: 0x66
function set_perk_mod_damage_data( ref, mod, var_39391a3c00d2aba0 )
{
    if ( var_39391a3c00d2aba0 )
    {
        assert( mod > 0, "<dev string:x4e4>" );
    }
    
    data = get_perk_mod_damage_data( ref, 1 );
    data.modifier = mod;
    data.ismultiplicative = var_39391a3c00d2aba0;
}

// Namespace vehicle_damage
// Params 4
// Checksum 0xfbee1c9f, Offset: 0xaa37
// Size: 0xaf
function set_perk_mod_damage_data_for_vehicle( ref, mod, var_39391a3c00d2aba0, vehicleref )
{
    if ( var_39391a3c00d2aba0 )
    {
        assert( mod > 0, "<dev string:x4e4>" );
    }
    
    vehicledata = get_vehicle_mod_damage_data( vehicleref, 1 );
    get_perk_mod_damage_data( ref, 1 );
    data = vehicledata.perkdata[ ref ];
    
    if ( !isdefined( data ) )
    {
        data = create_mod_damage_data_empty();
    }
    
    data.modifier = mod;
    data.ismultiplicative = var_39391a3c00d2aba0;
    vehicledata.perkdata[ ref ] = data;
}

// Namespace vehicle_damage
// Params 3
// Checksum 0x2041b5ce, Offset: 0xaaee
// Size: 0x66
function set_attachment_mod_damage_data( ref, mod, var_39391a3c00d2aba0 )
{
    if ( var_39391a3c00d2aba0 )
    {
        assert( mod > 0, "<dev string:x4e4>" );
    }
    
    data = get_attachment_mod_damage_data( ref, 1 );
    data.modifier = mod;
    data.ismultiplicative = var_39391a3c00d2aba0;
}

// Namespace vehicle_damage
// Params 4
// Checksum 0x6b0db2cd, Offset: 0xab5c
// Size: 0xaf
function set_attachment_mod_damage_data_for_vehicle( ref, mod, var_39391a3c00d2aba0, vehicleref )
{
    if ( var_39391a3c00d2aba0 )
    {
        assert( mod > 0, "<dev string:x4e4>" );
    }
    
    vehicledata = get_vehicle_mod_damage_data( vehicleref, 1 );
    get_attachment_mod_damage_data( ref, 1 );
    data = vehicledata.attachmentdata[ ref ];
    
    if ( !isdefined( data ) )
    {
        data = create_mod_damage_data_empty();
    }
    
    data.modifier = mod;
    data.ismultiplicative = var_39391a3c00d2aba0;
    vehicledata.attachmentdata[ ref ] = data;
}

// Namespace vehicle_damage
// Params 2
// Checksum 0xc4a216df, Offset: 0xac13
// Size: 0x4e
function set_pre_mod_damage_callback( vehicleref, callback )
{
    if ( utility::issharedfuncdefined( #"vehicle_damage", #"setPreModDamageCallback" ) )
    {
        [[ utility::getsharedfunc( #"vehicle_damage", #"setPreModDamageCallback" ) ]]( vehicleref, callback );
    }
}

// Namespace vehicle_damage
// Params 2
// Checksum 0xb3e43c12, Offset: 0xac69
// Size: 0x4e
function set_post_mod_damage_callback( vehicleref, callback )
{
    if ( utility::issharedfuncdefined( #"vehicle_damage", #"setPostModDamageCallback" ) )
    {
        [[ utility::getsharedfunc( #"vehicle_damage", #"setPostModDamageCallback" ) ]]( vehicleref, callback );
    }
}

// Namespace vehicle_damage
// Params 2
// Checksum 0xf0c233da, Offset: 0xacbf
// Size: 0x4e
function set_death_callback( vehicleref, callback )
{
    if ( utility::issharedfuncdefined( #"vehicle_damage", #"setDeathCallback" ) )
    {
        [[ utility::getsharedfunc( #"vehicle_damage", #"setDeathCallback" ) ]]( vehicleref, callback );
    }
}

// Namespace vehicle_damage
// Params 3
// Checksum 0xb5acd3f1, Offset: 0xad15
// Size: 0x5f
function set_occupant_damage_scale( vehicleref, seatid, damagescale )
{
    leveldataforvehicle = get_data( vehicleref, 1 );
    
    if ( !isdefined( leveldataforvehicle.occupantdamagescale ) )
    {
        leveldataforvehicle.occupantdamagescale = [];
    }
    
    leveldataforvehicle.occupantdamagescale[ seatid ] = damagescale;
}

// Namespace vehicle_damage
// Params 3
// Checksum 0xf9e9818f, Offset: 0xad7c
// Size: 0x5f
function function_e0545be231a5016c( vehicleref, seatid, damageclamp )
{
    leveldataforvehicle = get_data( vehicleref, 1 );
    
    if ( !isdefined( leveldataforvehicle.occupantdamageclamp ) )
    {
        leveldataforvehicle.occupantdamageclamp = [];
    }
    
    leveldataforvehicle.occupantdamageclamp[ seatid ] = damageclamp;
}

// Namespace vehicle_damage
// Params 1, eflags: 0x4
// Checksum 0x39497d14, Offset: 0xade3
// Size: 0xd6
function private onagentkilled( params )
{
    if ( params.smeansofdeath != "MOD_CRUSH" )
    {
        return;
    }
    
    vehicle = params.einflictor;
    
    if ( !isdefined( vehicle ) || !vehicle vehicle::is_vehicle() )
    {
        return;
    }
    
    ref = vehicle vehicle::get_ref();
    
    if ( !isdefined( ref ) || !vehicle::has_data( ref ) )
    {
        return;
    }
    
    data = get_data( ref );
    
    if ( !isdefined( data.var_bcfe42623f129b7b ) )
    {
        return;
    }
    
    vehicle dodamage( int( vehicle.maxhealth * data.var_bcfe42623f129b7b / 100 ), vehicle.origin, self, self, "MOD_CRUSH", get_weapon_string( ref ) );
}

// Namespace vehicle_damage
// Params 1
// Checksum 0x72f59a8b, Offset: 0xaec1
// Size: 0x216
function function_182f0b7ab120aa9b( dmg_struct )
{
    if ( dmg_struct.smeansofdeath == "MOD_CRUSH" )
    {
        attackent = undefined;
        
        if ( isdefined( dmg_struct.eattacker ) && dmg_struct.eattacker vehicle::is_vehicle() )
        {
            attackent = dmg_struct.eattacker;
        }
        else if ( isdefined( dmg_struct.einflictor ) && dmg_struct.einflictor vehicle::is_vehicle() )
        {
            attackent = dmg_struct.einflictor;
        }
        else
        {
            return;
        }
        
        if ( attackent.var_1f9a4101434e0129 || attackent.var_1f9d76cca64c48f6 )
        {
            return;
        }
        
        attackent.b_collided = 1;
        println( "<dev string:x701>" + attackent.maxhealth );
        
        if ( attackent.maxhealth > 0 )
        {
            maximpact = attackent.maxhealth / 100 * 80;
            
            if ( isdefined( self.var_70c857eac4e87637 ) )
            {
                if ( utility::time_has_passed( self.var_70c857eac4e87637, 1 ) )
                {
                    self.var_70c857eac4e87637 = gettime();
                    self.recentimpactdamage = 0;
                }
                
                if ( self.recentimpactdamage > maximpact )
                {
                    attackent.b_collided = undefined;
                    return;
                }
            }
            else
            {
                self.var_70c857eac4e87637 = gettime();
                self.recentimpactdamage = 0;
            }
        }
        
        if ( isdefined( dmg_struct.idamage ) )
        {
            if ( attackent vehicle_getspeed() < 5 )
            {
                attackent.b_collided = undefined;
                return;
            }
            
            if ( dmg_struct.idamage < 15 )
            {
                attackent.b_collided = undefined;
                return;
            }
            
            var_8a871acb1f1990b7 = function_89aca93fe7ead18a( attackent, self, dmg_struct.vdir );
            var_8a871acb1f1990b7 = floor( var_8a871acb1f1990b7 );
            
            if ( !isdefined( self.recentimpactdamage ) )
            {
                self.recentimpactdamage = 0;
            }
            
            self.recentimpactdamage += var_8a871acb1f1990b7;
            attackent thread vehicle_collide( var_8a871acb1f1990b7, self );
        }
    }
}

// Namespace vehicle_damage
// Params 2
// Checksum 0x5f888d63, Offset: 0xb0df
// Size: 0x106
function vehicle_collide( n_damage, collideent )
{
    self endon( #"death" );
    
    if ( level.var_19dac4c03e6cd6cb )
    {
        playsoundatpos( self.origin, level.var_19dac4c03e6cd6cb );
    }
    
    occupants = vehicle_occupancy::function_8ed9bcd8e9ea74f5( self, 0 );
    
    if ( isdefined( occupants ) )
    {
        foreach ( occupant in occupants )
        {
            if ( isplayer( occupant ) )
            {
                occupant playrumbleonpositionforclient( "artillery_rumble_heavy", self.origin );
            }
        }
    }
    
    self dodamage( n_damage, self.origin, collideent );
    wait 0.1;
    self.b_collided = undefined;
}

// Namespace vehicle_damage
// Params 4, eflags: 0x4
// Checksum 0x5b0235b2, Offset: 0xb1ed
// Size: 0x1ef
function private function_d8f1defd7f63f734( vehicle, agent, bpbundle, vehbundle )
{
    var_1889ca0c89277604 = 2.223;
    
    if ( utility::issharedfuncdefined( #"damage", #"hash_537f8ab65c181efd" ) )
    {
        var_1889ca0c89277604 = utility::callsharedfunc( #"damage", #"hash_537f8ab65c181efd", vehicle, agent, bpbundle, vehbundle ) ?? 2.223;
    }
    else if ( agent.type == "human" )
    {
        var_1889ca0c89277604 = vehbundle.damage.var_629984d018f37877 ?? 2.223;
    }
    else if ( agent.type == "zombie" && isdefined( agent.aicategory ) )
    {
        switch ( agent.aicategory )
        {
            case #"hash_84fcf5e68d7230b2":
                var_1889ca0c89277604 = bpbundle.var_629984d018f37877 ?? vehbundle.damage.var_629984d018f37877 ?? 0;
                break;
            case #"hash_8c089e813083e510":
                var_1889ca0c89277604 = bpbundle.var_67ee6478ec16e55d ?? vehbundle.damage.var_67ee6478ec16e55d ?? 0;
                break;
            case #"hash_7b0e2f2ed84f34":
                var_1889ca0c89277604 = bpbundle.var_c628f12f50dc18e1 ?? vehbundle.damage.var_c628f12f50dc18e1 ?? 0;
                break;
            case #"hash_4e47eb6c32f5b165":
            case #"hash_7e8a002ed096276c":
                var_1889ca0c89277604 = bpbundle.var_63e605add1ac73ba ?? vehbundle.damage.var_63e605add1ac73ba ?? 0;
                break;
        }
    }
    
    return var_1889ca0c89277604 / 100;
}

// Namespace vehicle_damage
// Params 3, eflags: 0x4
// Checksum 0x871c7aac, Offset: 0xb3e5
// Size: 0x249
function private function_89aca93fe7ead18a( vehicle, agent, touchdir )
{
    var_8a871acb1f1990b7 = 0;
    var_e2135a579d15e713 = vehicle.var_429d5e520209434f;
    bundledata = undefined;
    ref = vehicle vehicle::get_ref();
    
    if ( vehicle::has_data( ref ) )
    {
        bundledata = vehicle::get_data( ref );
    }
    
    var_1889ca0c89277604 = function_d8f1defd7f63f734( vehicle, agent, var_e2135a579d15e713, bundledata );
    vehiclevelocity = vehicle vehicle_getvelocity();
    
    if ( vehiclevelocity )
    {
        var_d466040bf789c15d = vectordot( vehiclevelocity, touchdir );
        var_285d7ff883332fcb = ( var_e2135a579d15e713.var_d01fc94cff762652 ?? bundledata.damage.var_d01fc94cff762652 ) * 17.6 ?? 0;
        var_283a95f8830d1875 = ( var_e2135a579d15e713.var_cffbd34cff4dc198 ?? bundledata.damage.var_cffbd34cff4dc198 ) * 17.6 ?? 0;
        collisiondamagemin = var_e2135a579d15e713.collisiondamagemin ?? bundledata.damage.collisiondamagemin ?? 0;
        collisiondamagemax = var_e2135a579d15e713.collisiondamagemax ?? bundledata.damage.collisiondamagemax ?? 0;
        
        if ( var_283a95f8830d1875 > var_285d7ff883332fcb )
        {
            var_9eb29155374ca29a = math::remap( var_d466040bf789c15d, var_285d7ff883332fcb, var_283a95f8830d1875, collisiondamagemin, collisiondamagemax );
        }
        else if ( var_d466040bf789c15d > collisiondamagemin )
        {
            var_9eb29155374ca29a = collisiondamagemax;
        }
        else
        {
            var_9eb29155374ca29a = 0;
        }
        
        var_9eb29155374ca29a = clamp( var_9eb29155374ca29a, collisiondamagemin, collisiondamagemax );
        var_8a871acb1f1990b7 = min( vehicle.maxhealth * ( var_1889ca0c89277604 ?? 0.0222 ), var_9eb29155374ca29a );
    }
    else
    {
        var_8a871acb1f1990b7 = vehicle.maxhealth * ( var_1889ca0c89277604 ?? 0.0222 );
    }
    
    if ( utility::issharedfuncdefined( #"damage", #"hash_1962174a5b426182" ) )
    {
        var_8a871acb1f1990b7 = utility::callsharedfunc( #"damage", #"hash_1962174a5b426182", var_8a871acb1f1990b7, vehicle, agent, var_e2135a579d15e713, bundledata );
    }
    
    return var_8a871acb1f1990b7;
}

// Namespace vehicle_damage
// Params 0, eflags: 0x4
// Checksum 0xe522ca, Offset: 0xb637
// Size: 0x3f
function private init_debug()
{
    /#
        if ( getdvarint( @"nodebug", 0 ) >= 1 )
        {
            return;
        }
        
        setdvarifuninitialized( @"scr_vehiclegod", 0 );
        setdvarifuninitialized( @"hash_4827ebae75561872", 0 );
        thread monitor_debug();
    #/
}

/#

    // Namespace vehicle_damage
    // Params 0, eflags: 0x4
    // Checksum 0xd762277a, Offset: 0xb67e
    // Size: 0x156, Type: dev
    function private monitor_debug()
    {
        level.vehiclegod = getdvarint( @"scr_vehiclegod", 0 ) > 0;
        
        while ( true )
        {
            simulatedamagepercent = getdvarint( @"hash_4827ebae75561872", 0 );
            
            if ( simulatedamagepercent > 0 )
            {
                vehicles = vehicle_tracking::function_5820a38c9873992e();
                
                if ( vehicles.size > 0 )
                {
                    iprintln( "<dev string:x718>" + simulatedamagepercent + "<dev string:x71a>" );
                }
                
                foreach ( vehicle in vehicles )
                {
                    if ( isdefined( vehicle ) && !vehicle vehicle::is_destroyed() )
                    {
                        simulate_damage( vehicle, simulatedamagepercent );
                    }
                }
                
                setdevdvar( @"hash_4827ebae75561872", 0 );
            }
            
            vehiclegod = getdvarint( @"scr_vehiclegod", 0 ) > 0;
            
            if ( level.vehiclegod != vehiclegod )
            {
                if ( vehiclegod )
                {
                    iprintln( "<dev string:x731>" );
                }
                else
                {
                    iprintln( "<dev string:x740>" );
                }
                
                level.vehiclegod = vehiclegod;
            }
            
            waitframe();
        }
    }

    // Namespace vehicle_damage
    // Params 2
    // Checksum 0xa5572110, Offset: 0xb7dc
    // Size: 0x94, Type: dev
    function simulate_damage( vehicle, percent )
    {
        attacker = level.players[ 0 ];
        percent = min( percent, 100 ) / 100;
        damage = int( min( vehicle.health, ceil( vehicle.maxhealth * percent ) ) );
        thread function_818bb739ba11dd25();
        vehicle dodamage( damage, vehicle.origin, attacker, undefined, "<dev string:x750>" );
        thread function_dbf73fb86f62937f();
    }

    // Namespace vehicle_damage
    // Params 0
    // Checksum 0x2e89858, Offset: 0xb878
    // Size: 0x51, Type: dev
    function function_818bb739ba11dd25()
    {
        level notify( #"hash_dcc023421b3c666f" );
        level endon( #"hash_dcc023421b3c666f" );
        
        if ( !isdefined( level.vehiclefriendlydamageold ) )
        {
            level.vehiclefriendlydamageold = istrue( level.vehiclefriendlydamage );
            level.vehiclefriendlydamage = 1;
        }
        
        waittillframeend();
        thread function_dbf73fb86f62937f();
    }

    // Namespace vehicle_damage
    // Params 0
    // Checksum 0x54c1483d, Offset: 0xb8d1
    // Size: 0x3a, Type: dev
    function function_dbf73fb86f62937f()
    {
        level notify( #"hash_dcc023421b3c666f" );
        
        if ( isdefined( level.vehiclefriendlydamageold ) )
        {
            level.vehiclefriendlydamage = level.vehiclefriendlydamageold;
            level.vehiclefriendlydamageold = undefined;
        }
    }

#/
