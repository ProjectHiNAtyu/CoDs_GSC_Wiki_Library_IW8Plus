// scripts\common\vehicle_collision.gsc  (hash_22d33ead163e3943.gscc) (size: 14686 Bytes / 0x395e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1663feb9 (375652025)
// size ...... 14686 (0x395e)
// includes .. 6   (offset: 0x3782)
// strings ... 25  (offset: 0x37b2)
// dev strs .. 3   (offset: 0x393a)
// exports ... 31  (offset: 0x2742)
// cseg ...... 0x209 + 0x2539 (0x2742)
// imports ... 89  (offset: 0x2c1a)
// animtree1 . 0   (offset: 0x395e)
// animtree2 . 0   (offset: 0x395e)
#using scripts\common\math;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_paths;

#namespace vehicle_collision;

// Namespace vehicle_collision
// Params 0
// Checksum 0x56194f9a, Offset: 0x227
// Size: 0xa7
function init()
{
    assert( isdefined( level.vehicle ), "<dev string:x24>" );
    
    if ( utility::issharedfuncdefined( #"vehicle_collision", #"init" ) )
    {
        [[ utility::getsharedfunc( #"vehicle_collision", #"init" ) ]]();
    }
    
    level.var_b69d75a0873a5870 = getdvarint( @"hash_72990c24f27d9759", 1 ) == 1;
    level.var_d444ccbc31b10404 = getdvarint( @"hash_51781d75e2ddda6a", 1 ) == 1;
    level.var_fa176214d87ef2fc = getdvarfloat( @"hash_ba56da9845f4904f", 1 );
    thread update();
}

// Namespace vehicle_collision
// Params 0, eflags: 0x4
// Checksum 0xc79e7625, Offset: 0x2d6
// Size: 0x21
function private update()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        level.var_a4174766ac7188e6 = [];
        waitframe();
    }
}

// Namespace vehicle_collision
// Params 1
// Checksum 0xbb32a67c, Offset: 0x2ff
// Size: 0x4c9
function update_instance( vehicle )
{
    level endon( #"game_ended" );
    assert( vehicle vehicle::is_vehicle(), "<dev string:x5c>" );
    data = get_data( vehicle vehicle::get_ref(), 0, 1 );
    
    if ( !isdefined( data ) )
    {
        return;
    }
    
    handleWorldCollision = undefined;
    
    if ( utility::issharedfuncdefined( vehicle vehicle::get_ref(), #"handleWorldCollision" ) )
    {
        handleWorldCollision = utility::getsharedfunc( vehicle vehicle::get_ref(), #"handleWorldCollision" );
    }
    
    vehicle notify( #"vehicle_collision_updateinstance" );
    vehicle endon( #"vehicle_collision_updateinstance" );
    vehicle endon( #"death" );
    vehiclenum = vehicle getentitynumber();
    var_9a4868e46f325cd0 = gettime() + 5000;
    vehicle vehphys_enablecollisioncallback( 1 );
    
    while ( isdefined( vehicle ) )
    {
        vehicle waittill( #"collision", body0, body1, flag0, flag1, position, normal, normalspeed, ent );
        
        if ( isdefined( ent ) && ent.iscrossbowbolt )
        {
            continue;
        }
        
        if ( isplayer( ent ) )
        {
            continue;
        }
        
        if ( vehicle vehicle::ishelicopter() && ( !( isdefined( ent ) && isdefined( ent.classname ) ) || ent.classname == "worldspawn" ) )
        {
            vehicle thread function_9a12b1f4777c3cb3();
        }
        
        destroy_hit_ent( vehicle, ent );
        
        if ( isdefined( vehicle.var_c971b9fb0896d7c6 ) && isdefined( ent.classname ) && !ent vehicle::is_vehicle() && ent.classname != "worldspawn" )
        {
            [[ vehicle.var_c971b9fb0896d7c6 ]]( vehicle, ent );
        }
        
        if ( isdefined( handleWorldCollision ) && ( !( isdefined( ent ) && isdefined( ent.classname ) ) || ent.classname == "worldspawn" || ent == vehicle ) )
        {
            vehicle thread [[ handleWorldCollision ]]( position );
        }
        
        if ( level.gametypebundle.var_cec2589931315388 && function_45fdeb14df65661b( body0 ) && function_45fdeb14df65661b( body1 ) )
        {
            vehicle.var_9d5c37753aed59c7 = gettime();
            ent.var_9d5c37753aed59c7 = gettime();
            
            if ( vehicle hascomponent( "c2p" ) )
            {
                vehicle thread vehicle_paths::function_ae6e16cd074e8f59();
            }
            
            if ( ent hascomponent( "c2p" ) )
            {
                ent thread vehicle_paths::function_ae6e16cd074e8f59();
            }
        }
        
        if ( vehicle.var_300686ebe3a78e39 )
        {
            continue;
        }
        
        if ( gettime() < var_9a4868e46f325cd0 )
        {
            continue;
        }
        
        if ( isdefined( level.var_a4174766ac7188e6[ vehiclenum ] ) || isdefined( ent ) && isdefined( ent getentitynumber() ) && ent vehicle::is_vehicle() && isdefined( level.var_a4174766ac7188e6[ ent getentitynumber() ] ) )
        {
            continue;
        }
        
        var_5e3b5b2143fc9c3d = isent( ent ) && isdefined( ent getentitynumber() ) && ent vehicle::is_vehicle() && ent != vehicle;
        level.var_a4174766ac7188e6[ vehiclenum ] = 1;
        
        if ( var_5e3b5b2143fc9c3d )
        {
            level.var_a4174766ac7188e6[ ent getentitynumber() ] = 1;
            ent notify( #"veh_hit_veh", self );
        }
        
        if ( level.var_b69d75a0873a5870 )
        {
            if ( !var_5e3b5b2143fc9c3d && !vehicle vehicle::ishelicopter() && normal[ 2 ] > 0.9 )
            {
                level thread handle_fall_damage( vehicle, position, normal );
            }
            else
            {
                level thread function_1bad3c9d42a3bf11( vehicle, ent, body0, body1, flag0, flag1, position, normal, normalspeed );
            }
        }
        
        if ( var_5e3b5b2143fc9c3d )
        {
            foreach ( tempvehicle in [ vehicle, ent ] )
            {
                if ( isdefined( tempvehicle.handleeventcallback ) )
                {
                    tempvehicle [[ tempvehicle.handleeventcallback ]]( arrayremove( [ vehicle, ent ], tempvehicle )[ 0 ] );
                }
                
                leveldataforvehicle = get_data( tempvehicle vehicle::get_ref(), 0, 1 );
                
                if ( !isdefined( leveldataforvehicle ) )
                {
                    continue;
                }
                
                if ( isdefined( leveldataforvehicle.handleeventcallback ) )
                {
                    [[ leveldataforvehicle.handleeventcallback ]]( vehicle, ent, position );
                }
            }
        }
    }
}

// Namespace vehicle_collision
// Params 9, eflags: 0x4
// Checksum 0xb166ac73, Offset: 0x7d0
// Size: 0x8d1
function private function_1bad3c9d42a3bf11( vehicle, otherent, body0, body1, flag0, flag1, position, normal, normalspeed )
{
    level endon( #"game_ended" );
    
    if ( vehicle.var_d095febef1095bf9 && vehicle.var_d095febef1095bf9 + 300 > gettime() )
    {
        return;
    }
    
    var_4528dc04bda9ec95 = function_5d778229abbf7183( vehicle );
    var_4cdc7c696999f528 = function_5d778229abbf7183( otherent );
    waitframe();
    
    if ( !isdefined( vehicle ) )
    {
        return;
    }
    
    var_366bdf70365083e6 = get_velocity( vehicle );
    var_244de96e6b3df4ed = get_velocity( otherent );
    var_e226e0a127eb0853 = isdefined( otherent ) && otherent vehicle::is_vehicle() && vehicle::has_data( otherent vehicle::get_ref() ) && isdefined( vehicle::get_data( otherent vehicle::get_ref() ).damage ) && isdefined( vehicle );
    impulse = length( var_366bdf70365083e6 - var_4528dc04bda9ec95 ) + length( var_4cdc7c696999f528 - var_244de96e6b3df4ed );
    var_14af063128b4f612 = undefined;
    var_bf3fa5b592aa573e = undefined;
    
    if ( var_e226e0a127eb0853 )
    {
        handle_stability( [ vehicle, otherent ], [ var_4528dc04bda9ec95, var_4cdc7c696999f528 ], normal );
    }
    
    if ( !var_e226e0a127eb0853 )
    {
        if ( isdefined( otherent ) && isdefined( otherent.maxhealth ) && otherent vehicle::is_vehicle() )
        {
            var_14af063128b4f612 = otherent;
        }
        else if ( isdefined( vehicle ) && isdefined( vehicle.maxhealth ) )
        {
            var_14af063128b4f612 = vehicle;
        }
        else
        {
            return;
        }
        
        ref = var_14af063128b4f612 vehicle::get_ref();
        
        if ( !isdefined( ref ) )
        {
            return;
        }
        
        if ( !vehicle::has_data( ref ) )
        {
            return;
        }
        
        if ( !level.var_d444ccbc31b10404 && isdefined( var_14af063128b4f612.riders ) && var_14af063128b4f612.riders.size > 0 )
        {
            return;
        }
        
        alldata = vehicle::get_data( ref );
        
        if ( !( isdefined( alldata ) && isdefined( alldata.damage ) ) )
        {
            return;
        }
        
        var_bf3fa5b592aa573e = alldata.damage;
        multiplier = 1;
        
        if ( var_14af063128b4f612 vehicle::is_floating() )
        {
            multiplier = vehicle.var_429d5e520209434f.var_998a69fa223f881a ?? var_bf3fa5b592aa573e.var_998a69fa223f881a ?? 1;
        }
        else
        {
            multiplier = vehicle.var_429d5e520209434f.var_efa813d230db5cdc ?? var_bf3fa5b592aa573e.var_efa813d230db5cdc ?? 1;
        }
        
        if ( multiplier <= 0 )
        {
            return;
        }
        
        impulse *= multiplier;
    }
    
    /#
        if ( getdvarint( @"scr_debug_vehicle_collision", 0 ) == 1 )
        {
            debugaxis( position, vectortoangles( normal ), impulse / 5, 1, 0, 400 );
        }
    #/
    
    if ( isdefined( otherent.var_514172427acb20c1 ) )
    {
        vehicle [[ otherent.var_514172427acb20c1 ]]( otherent, impulse );
        return;
    }
    
    damagepercentage = 0;
    radius = 35;
    
    if ( impulse > 650 )
    {
        damagepercentage = 1;
        radius = 110;
        
        /#
            if ( getdvarint( @"scr_debug_vehicle_collision", 0 ) == 1 )
            {
                sphere( position, radius, ( 1, 0, 0 ), 0, 400 );
            }
        #/
    }
    else if ( impulse > 450 )
    {
        damagepercentage = 0.75;
        radius = 90;
        
        /#
            if ( getdvarint( @"scr_debug_vehicle_collision", 0 ) == 1 )
            {
                sphere( position, radius, ( 1, 0, 1 ), 0, 400 );
            }
        #/
    }
    else if ( impulse > 250 )
    {
        damagepercentage = 0.5;
        radius = 75;
        
        /#
            if ( getdvarint( @"scr_debug_vehicle_collision", 0 ) == 1 )
            {
                sphere( position, radius, ( 0, 1, 0 ), 0, 400 );
            }
        #/
    }
    
    /#
        if ( getdvarint( @"scr_debug_vehicle_collision", 0 ) == 1 )
        {
            print3d( position, impulse, ( 1, 1, 1 ), 1, 1, 400, 1 );
        }
    #/
    
    if ( var_e226e0a127eb0853 )
    {
        if ( damagepercentage < 0.5 )
        {
            return;
        }
        
        basedata = vehicle::get_data( vehicle vehicle::get_ref() ).damage;
        otherdata = vehicle::get_data( otherent vehicle::get_ref() ).damage;
        baseclass = basedata.class ?? "medium";
        otherclass = otherdata.class ?? "medium";
        [ baseweightratio, otherweightratio ] = get_weight_damage_ratio( baseclass, otherclass );
        [ basespeedratio, otherspeedratio ] = get_speed_damage_ratio( length( var_4528dc04bda9ec95 ), length( var_4cdc7c696999f528 ) );
        basespeedratio = clamp( basespeedratio, 0.2, 0.8 );
        otherspeedratio = clamp( otherspeedratio, 0.2, 0.8 );
        vehiclemaxhealth = ( vehicle.maxhealth ?? 1 ) - ( vehicle.healthbuffer ?? 0 );
        otherentmaxhealth = ( otherent.maxhealth ?? 1 ) - ( otherent.healthbuffer ?? 0 );
        var_add95e283856b5c9 = vehicle.var_429d5e520209434f.var_df106d0e92fab581 ?? basedata.var_df106d0e92fab581 ?? 1;
        var_8328cd590754592c = otherent.var_429d5e520209434f.var_df106d0e92fab581 ?? otherdata.var_df106d0e92fab581 ?? 1;
        basemultiplier = var_add95e283856b5c9 * 2 * damagepercentage * basespeedratio * baseweightratio * level.var_fa176214d87ef2fc;
        othermultiplier = var_8328cd590754592c * 2 * damagepercentage * otherspeedratio * otherweightratio * level.var_fa176214d87ef2fc;
        basedamage = vehiclemaxhealth * function_b7337cb1631d8998( baseclass ) * basemultiplier;
        otherdamage = otherentmaxhealth * function_b7337cb1631d8998( otherclass ) * othermultiplier;
        vehicledriver = vehicle_occupancy::get_driver( vehicle );
        otherdriver = vehicle_occupancy::get_driver( otherent, 1 );
        
        if ( basedata.skipburndown )
        {
            vehicle vehicle_damage::function_658976b407a5b2e1( 1 );
        }
        
        if ( otherdata.skipburndown )
        {
            otherent vehicle_damage::function_658976b407a5b2e1( 1 );
        }
        
        vehicle dodamage( int( basedamage ), position, otherdriver, otherent, "MOD_CRUSH", otherent.objweapon );
        otherent dodamage( int( otherdamage ), position, vehicledriver, vehicle, "MOD_CRUSH", vehicle.objweapon );
        
        if ( isdefined( vehicle ) )
        {
            vehicle vehicle_damage::function_658976b407a5b2e1( 0 );
        }
        
        if ( isdefined( otherent ) )
        {
            otherent vehicle_damage::function_658976b407a5b2e1( 0 );
        }
        
        vehicle_damage::function_eb89abdecc0cacc0( vehicle, basedamage * 0.75, position, radius );
        vehicle_damage::function_eb89abdecc0cacc0( otherent, otherdamage * 0.75, position, radius );
        
        if ( isdefined( vehicle ) )
        {
            vehicle.var_d095febef1095bf9 = gettime();
        }
        
        if ( isdefined( otherent ) )
        {
            otherent.var_d095febef1095bf9 = gettime();
        }
        
        return;
    }
    
    if ( vehicle.var_429d5e520209434f.var_7b3d457e74c528c3 )
    {
        damage = impulse;
    }
    else
    {
        damage = ( var_14af063128b4f612.maxhealth - ( var_14af063128b4f612.healthbuffer ?? 0 ) ) * function_f4e935cfd9063a8a( var_bf3fa5b592aa573e.class ?? "medium" );
    }
    
    if ( var_14af063128b4f612.var_937263baf40c151 )
    {
        damage = var_14af063128b4f612.maxhealth;
    }
    
    vehicle_damage::function_eb89abdecc0cacc0( var_14af063128b4f612, damage * 0.75, position, radius );
    
    if ( damage <= 0 || impulse <= ( vehicle.var_429d5e520209434f.var_5ff053fe35a3561c ?? alldata.damage.var_5ff053fe35a3561c ) )
    {
        return;
    }
    
    if ( var_bf3fa5b592aa573e.skipburndown )
    {
        var_14af063128b4f612 vehicle_damage::function_658976b407a5b2e1( 1 );
    }
    
    var_14af063128b4f612 dodamage( int( damage ), position, undefined, undefined, "MOD_CRUSH" );
    
    if ( var_14af063128b4f612 )
    {
        var_14af063128b4f612 vehicle_damage::function_658976b407a5b2e1( 0 );
        var_14af063128b4f612.var_d095febef1095bf9 = gettime();
    }
}

// Namespace vehicle_collision
// Params 3, eflags: 0x4
// Checksum 0xfee4dc07, Offset: 0x10a9
// Size: 0x173
function private handle_stability( vehicles, var_3eba1586ed890796, normal )
{
    foreach ( index, hitvehicle in vehicles )
    {
        if ( hitvehicle isscriptable() )
        {
            if ( !hitvehicle getscriptablehaspart( "stability" ) )
            {
                continue;
            }
        }
        else
        {
            continue;
        }
        
        if ( vehicle_occupancy::get_all_occupants( hitvehicle ).size > 0 )
        {
            continue;
        }
        
        othervehicle = vehicles[ 1 - index ];
        data = vehicle::get_data( hitvehicle vehicle::get_ref() );
        var_4cdc7c696999f528 = var_3eba1586ed890796[ 1 - index ];
        var_d466040bf789c15d = abs( vectordot( var_4cdc7c696999f528, normal ) );
        var_470e203ce88b45f7 = 1;
        
        if ( othervehicle.code_classname == "script_vehicle" )
        {
            var_470e203ce88b45f7 = othervehicle function_8d5e756e5cd572ae( "mass" );
        }
        
        if ( var_d466040bf789c15d >= ( data.var_2a3667dbc24f2786 ?? 0 ) && var_470e203ce88b45f7 >= ( data.var_da8458e7145339c3 ?? 0 ) )
        {
            hitvehicle utility::function_7c10ea82c1e305b8( "stability", "unstable" );
        }
    }
}

// Namespace vehicle_collision
// Params 3, eflags: 0x4
// Checksum 0x3735afb5, Offset: 0x1224
// Size: 0x37d
function private handle_fall_damage( vehicle, position, normal )
{
    data = vehicle::get_data( vehicle vehicle::get_ref() ).damage;
    fallspeed = -1 * function_5d778229abbf7183( vehicle )[ 2 ] * 0.056818;
    multiplier = vehicle.var_429d5e520209434f.falldamagemultiplier ?? data.falldamagemultiplier ?? 1;
    
    if ( multiplier <= 0 )
    {
        return;
    }
    
    var_5a168b79b608557f = [ 25, 35, 45, 55, 65 ];
    damagetier = 0;
    
    for ( tier = var_5a168b79b608557f.size; tier > 0 ; tier-- )
    {
        var_ec7df50de2f847 = var_5a168b79b608557f[ tier - 1 ];
        
        if ( fallspeed > var_ec7df50de2f847 )
        {
            damagetier = tier;
            break;
        }
    }
    
    if ( !damagetier )
    {
        return;
    }
    
    /#
        if ( getdvarint( @"scr_debug_vehicle_collision", 0 ) == 1 )
        {
            color = ( 1, 0, 0 );
            
            switch ( damagetier )
            {
                case 5:
                    color = ( 1, 0, 0 );
                    break;
                case 4:
                    color = ( 1, 1, 0 );
                    break;
                case 3:
                    color = ( 0, 0, 1 );
                    break;
                case 2:
                    color = ( 0, 1, 1 );
                    break;
                case 1:
                    color = ( 0, 1, 0 );
                    break;
                default:
                    break;
            }
            
            print3d( position, "<dev string:xa1>" + damagetier, color, 1, 1, 4000 );
            debugaxis( position, vectortoangles( normal ), 16, 1, 0, 4000 );
        }
    #/
    
    damagepercentage = 1;
    wheeldamage = 50;
    wheelstodamage = 0;
    
    switch ( damagetier )
    {
        case 5:
            damagepercentage = 1;
            wheeldamage = 250;
            wheelstodamage = 4;
            break;
        case 4:
            damagepercentage = 0.8;
            wheeldamage = 250;
            wheelstodamage = 4;
            break;
        case 3:
            damagepercentage = 0.6;
            wheeldamage = 150;
            wheelstodamage = 2;
            break;
        case 2:
            damagepercentage = 0.4;
            wheeldamage = 100;
            wheelstodamage = 1;
            break;
        case 1:
            damagepercentage = 0.2;
            wheeldamage = 40;
            wheelstodamage = 1;
            break;
        default:
            break;
    }
    
    vehicle_damage::function_95120e6392cd14f1( vehicle, wheeldamage, position, wheelstodamage );
    class = data.class ?? "medium";
    damage = function_ef056874538d5fe7( class ) * damagepercentage * multiplier * vehicle.maxhealth;
    
    if ( data.skipburndown )
    {
        vehicle vehicle_damage::function_658976b407a5b2e1( 1 );
    }
    
    vehicle dodamage( int( damage ), position, undefined, undefined, "MOD_CRUSH" );
    vehicle vehicle_damage::function_658976b407a5b2e1( 0 );
}

// Namespace vehicle_collision
// Params 2, eflags: 0x4
// Checksum 0x61c5e1bd, Offset: 0x15a9
// Size: 0x1e6
function private destroy_hit_ent( vehicle, ent )
{
    if ( !isdefined( ent ) )
    {
        return;
    }
    
    ent = ent.cover ?? ent;
    
    if ( ent.equipmentref == "equip_tac_cover" && isdefined( ent.deletefunc ) && !ent.ishitbyvehicle )
    {
        ent.ishitbyvehicle = 1;
        ent thread [[ ent.deletefunc ]]( undefined, 0, 0 );
        return;
    }
    
    if ( ent.weapon_name == "deployed_decoy_mp" )
    {
        ent thread [[ ent.entdeletefunc ]]();
        return;
    }
    
    if ( ent.isriotshield && utility::callsharedfunc( #"super_riotshield", #"hash_6d54acc12b075f40", vehicle ) )
    {
        ent thread [[ ent.deletefunc ]]();
        return;
    }
    
    if ( ent.classname == "misc_turret" || isdefined( ent.turretowner ) && ent.turretowner.classname == "misc_turret" )
    {
        if ( ent.classname == "misc_turret" )
        {
            turret = ent;
        }
        else if ( isdefined( ent.turretowner ) && ent.turretowner.classname == "misc_turret" )
        {
            turret = ent.turretowner;
        }
        
        turret_parent = turret getlinkedparent();
        
        if ( turret_parent == vehicle )
        {
            return;
        }
        
        if ( isdefined( turret.hitbyvehiclefunc ) && !turret.ishitbyvehicle )
        {
            turret.ishitbyvehicle = 1;
            turret thread [[ turret.hitbyvehiclefunc ]]( vehicle );
        }
    }
}

// Namespace vehicle_collision
// Params 0
// Checksum 0x9bf8b8d0, Offset: 0x1797
// Size: 0x5d
function function_9a12b1f4777c3cb3()
{
    self notify( #"hash_f07e8278dfb9311" );
    self endon( #"hash_f07e8278dfb9311" );
    self endon( #"death" );
    
    while ( true )
    {
        if ( vehicle_occupancy::get_driver( self ) )
        {
            break;
        }
        
        if ( self.var_5e585054698af751 )
        {
            break;
        }
        
        if ( self vehicle_isonground() )
        {
            self setrotorsactive( 0 );
            break;
        }
        
        waitframe();
    }
}

// Namespace vehicle_collision
// Params 1
// Checksum 0xb86eba63, Offset: 0x17fc
// Size: 0x63
function get_velocity( vehicle )
{
    if ( !isent( vehicle ) || !vehicle vehicle::is_vehicle() || vehicle vehicle::is_static() )
    {
        return ( 0, 0, 0 );
    }
    
    var_7237854e3be197ca = vehicle.velocity;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    return vehicle vehicle_getvelocity();
}

// Namespace vehicle_collision
// Params 1
// Checksum 0xd2a685df, Offset: 0x1868
// Size: 0x1e
function get_speed( vehicle )
{
    return length( get_velocity( vehicle ) ) * 0.056818;
}

// Namespace vehicle_collision
// Params 1, eflags: 0x4
// Checksum 0xb6e4ba03, Offset: 0x188f
// Size: 0x63
function private function_5d778229abbf7183( vehicle )
{
    if ( !isent( vehicle ) || !vehicle vehicle::is_vehicle() || vehicle vehicle::is_static() )
    {
        return ( 0, 0, 0 );
    }
    
    var_7237854e3be197ca = vehicle.velocity;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    return vehicle function_19e2beab469c788e();
}

// Namespace vehicle_collision
// Params 2, eflags: 0x4
// Checksum 0x65b905a8, Offset: 0x18fb
// Size: 0x5a
function private get_weight_damage_ratio( damageclass1, damageclass2 )
{
    weight1 = function_1b971a2963c4d589( damageclass1 );
    weight2 = function_1b971a2963c4d589( damageclass2 );
    sum = weight1 + weight2;
    return [ weight2 / sum, weight1 / sum ];
}

// Namespace vehicle_collision
// Params 2, eflags: 0x4
// Checksum 0xb0faec01, Offset: 0x195e
// Size: 0x51
function private get_speed_damage_ratio( speed1, speed2 )
{
    sum = speed1 + speed2;
    
    if ( sum <= 0 )
    {
        return [ 0.5, 0.5 ];
    }
    
    return [ speed2 / sum, speed1 / sum ];
}

// Namespace vehicle_collision
// Params 1, eflags: 0x4
// Checksum 0x23a9aeff, Offset: 0x19b8
// Size: 0xa7
function private function_1b971a2963c4d589( damageclass )
{
    switch ( damageclass )
    {
        case #"hash_d2a55c7ac538641b":
            return 0.1;
        case #"hash_d582c3286e5c390f":
            return 0.2;
        case #"hash_21622ca3ad06efb5":
            return 0.6;
        case #"hash_c71b112fe04823d6":
            return 1;
        case #"hash_53e0b558455f04c6":
            return 3;
        case #"hash_2453c9ffec9f5c20":
            return 5;
        case #"hash_e8ec392f4f2724e4":
            return 10;
        case #"hash_ee4a12a81f84ff3f":
            return 1000;
        default:
            return 1;
    }
}

// Namespace vehicle_collision
// Params 1, eflags: 0x4
// Checksum 0xbd3b1982, Offset: 0x1a67
// Size: 0xac
function private function_f4e935cfd9063a8a( damageclass )
{
    switch ( damageclass )
    {
        case #"hash_d2a55c7ac538641b":
            return 0.065;
        case #"hash_d582c3286e5c390f":
            return 0.05;
        case #"hash_21622ca3ad06efb5":
            return 0.03;
        case #"hash_c71b112fe04823d6":
            return 0.025;
        case #"hash_53e0b558455f04c6":
            return 0.015;
        case #"hash_2453c9ffec9f5c20":
            return 0.005;
        case #"hash_e8ec392f4f2724e4":
            return 0;
        case #"hash_ee4a12a81f84ff3f":
            return 0;
        default:
            return 0;
    }
}

// Namespace vehicle_collision
// Params 1, eflags: 0x4
// Checksum 0xbeaeba47, Offset: 0x1b1b
// Size: 0xb4
function private function_ef056874538d5fe7( damageclass )
{
    switch ( damageclass )
    {
        case #"hash_d2a55c7ac538641b":
            return 0.25;
        case #"hash_d582c3286e5c390f":
            return 0.25;
        case #"hash_21622ca3ad06efb5":
            return 0.25;
        case #"hash_c71b112fe04823d6":
            return 0.25;
        case #"hash_53e0b558455f04c6":
            return 0.25;
        case #"hash_2453c9ffec9f5c20":
            return 0.2;
        case #"hash_e8ec392f4f2724e4":
            return 0.2;
        case #"hash_ee4a12a81f84ff3f":
            return 0;
        default:
            return 0.25;
    }
}

// Namespace vehicle_collision
// Params 1, eflags: 0x4
// Checksum 0xc661a68f, Offset: 0x1bd7
// Size: 0xb4
function private function_b7337cb1631d8998( damageclass )
{
    switch ( damageclass )
    {
        case #"hash_d2a55c7ac538641b":
            return 0.6;
        case #"hash_d582c3286e5c390f":
            return 0.5;
        case #"hash_21622ca3ad06efb5":
            return 0.4;
        case #"hash_c71b112fe04823d6":
            return 0.3;
        case #"hash_53e0b558455f04c6":
            return 0.2;
        case #"hash_2453c9ffec9f5c20":
            return 0.15;
        case #"hash_e8ec392f4f2724e4":
            return 0.1;
        case #"hash_ee4a12a81f84ff3f":
            return 0;
        default:
            return 0.4;
    }
}

// Namespace vehicle_collision
// Params 3
// Checksum 0xfb403488, Offset: 0x1c93
// Size: 0x10f
function get_data( vehicleref, create, var_e6c819f806ce2c86 )
{
    if ( create && ( !vehicle::has_data( vehicleref ) || !isdefined( vehicle::get_data( vehicleref ).damage ) || !isdefined( get_data( vehicleref ).damage.class ) ) )
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
        
        data.damage.ref = vehicleref;
        data.damage.class = "medium";
        vehicle::add_data( vehicleref, data );
    }
    
    if ( vehicle::has_data( vehicleref ) )
    {
        return vehicle::get_data( vehicleref ).damage;
    }
}

// Namespace vehicle_collision
// Params 3
// Checksum 0xf1f56aa, Offset: 0x1daa
// Size: 0xc0
function function_b456610deaad175( vehicle, othervehicle, duration )
{
    vehicle endon( #"death" );
    
    if ( !isdefined( vehicle.vehcolignorelist ) )
    {
        vehicle.vehcolignorelist = [];
    }
    
    othervehicleid = othervehicle getentitynumber();
    vehicle.vehcolignorelist[ othervehicleid ] = othervehicle;
    wait duration;
    
    if ( isdefined( vehicle ) && isdefined( vehicle.vehcolignorelist ) )
    {
        vehicle.vehcolignorelist[ othervehicleid ] = undefined;
    }
    
    if ( isdefined( vehicle ) && isdefined( vehicle.vehcolignorelist ) && vehicle.vehcolignorelist.size == 0 )
    {
        vehicle.vehcolignorelist = undefined;
    }
}

// Namespace vehicle_collision
// Params 2
// Checksum 0x1d784ae7, Offset: 0x1e72
// Size: 0x4e, Type: bool
function is_in_ignore_list( vehicle, vehicletarget )
{
    vehicletargetid = vehicletarget getentitynumber();
    
    if ( vehicle.vehcolignorelist.size > 0 )
    {
        if ( isdefined( vehicle.vehcolignorelist[ vehicletargetid ] ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace vehicle_collision
// Params 2
// Checksum 0x1a9ddcda, Offset: 0x1ec9
// Size: 0x115, Type: bool
function function_419e88170394a188( vehicle, player )
{
    if ( vehicle_occupancy::is_enemy_to_player( vehicle, player ) )
    {
        playerwasinlaststand = istrue( player.inlaststand );
        var_ca02bfdd611a56f4 = player.health;
        
        if ( isdefined( vehicle.objweapon ) )
        {
            level.overrideobituarymod = "MOD_EXPLOSIVE";
        }
        
        attacker = undefined;
        
        if ( isdefined( vehicle.streakinfo ) )
        {
            attacker = vehicle.owner ?? player;
        }
        else
        {
            attacker = vehicle_occupancy::get_driver( vehicle ) ?? player;
        }
        
        player dodamage( 1000, vehicle.origin, attacker, vehicle, "MOD_CRUSH", vehicle.objweapon );
        level.overrideobituarymod = undefined;
        
        if ( !isalive( player ) )
        {
            return true;
        }
        
        if ( !playerwasinlaststand && player.inlaststand )
        {
            return true;
        }
        
        if ( var_ca02bfdd611a56f4 > player.health )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace vehicle_collision
// Params 2
// Checksum 0xc8703d47, Offset: 0x1fe7
// Size: 0x86
function function_e3bc60c772acd609( vehicle, player )
{
    player endon( #"disconnect" );
    player notify( #"vehicle_preventplayercollisiondamagefortimeafterexit" );
    player endon( #"vehicle_preventplayercollisiondamagefortimeafterexit" );
    player.vehiclecollisionignorearray = [];
    player.vehiclecollisionignorearray[ "inflictor" ] = vehicle;
    player.vehiclecollisionignorearray[ "meansOfDeath" ] = "MOD_CRUSH";
    function_790f8f52eaa61daf( player );
    thread function_c9850217a7d398f3( player );
}

// Namespace vehicle_collision
// Params 1, eflags: 0x4
// Checksum 0x7bd94cf0, Offset: 0x2075
// Size: 0x82
function private function_790f8f52eaa61daf( player )
{
    player endon( #"death" );
    
    if ( isdefined( level.vehicle ) && isdefined( level.vehicle.occupancy ) && isdefined( level.vehicle.occupancy.var_f706d2ddeaba4c7 ) )
    {
        wait level.vehicle.occupancy.var_f706d2ddeaba4c7;
        return;
    }
    
    wait 4;
}

// Namespace vehicle_collision
// Params 1
// Checksum 0x67e5362a, Offset: 0x20ff
// Size: 0x24
function function_c9850217a7d398f3( player )
{
    player notify( #"vehicle_preventplayercollisiondamagefortimeafterexit" );
    player.vehiclecollisionignorearray = undefined;
}

// Namespace vehicle_collision
// Params 4
// Checksum 0x92c90904, Offset: 0x212b
// Size: 0x7f, Type: bool
function function_898c68dd6412f983( inflictor, victim, meansofdeath, objweapon )
{
    if ( !isdefined( victim.vehiclecollisionignorearray ) )
    {
        return false;
    }
    
    if ( !isdefined( inflictor ) )
    {
        return false;
    }
    
    if ( !( inflictor === victim.vehiclecollisionignorearray[ "inflictor" ] ) )
    {
        return false;
    }
    
    if ( isdefined( meansofdeath ) && !( meansofdeath === victim.vehiclecollisionignorearray[ "meansOfDeath" ] ) )
    {
        return false;
    }
    
    return true;
}

// Namespace vehicle_collision
// Params 3
// Checksum 0xa11935aa, Offset: 0x21b3
// Size: 0x227, Type: bool
function function_dc1f303123867705( inflictor, victim, smeansofdeath )
{
    if ( !( smeansofdeath == "MOD_CRUSH" ) )
    {
        return false;
    }
    
    if ( !( isdefined( victim ) && isdefined( victim.origin ) ) )
    {
        return false;
    }
    
    if ( !( isdefined( inflictor ) && isdefined( inflictor.origin ) && isdefined( inflictor.angles ) ) )
    {
        return false;
    }
    
    if ( !inflictor vehicle::is_vehicle() || inflictor vehicle::get_ref() == "cargo_train" || !isent( inflictor ) || inflictor.classname != "script_vehicle" )
    {
        return false;
    }
    
    vehicleref = inflictor vehicle::get_ref();
    
    if ( !vehicle::has_data( vehicleref ) )
    {
        return false;
    }
    
    data = vehicle::get_data( vehicleref );
    
    if ( data.canfly || data.isboat )
    {
        return false;
    }
    
    extents = data.occupancy.exitextents;
    
    if ( !isdefined( extents ) )
    {
        return false;
    }
    
    if ( !inflictor vehicle_isonground() )
    {
        return false;
    }
    
    if ( inflictor vehicle_getspeed() < 1 )
    {
        return false;
    }
    
    if ( !( isdefined( extents[ "front" ] ) && isdefined( extents[ "back" ] ) ) )
    {
        return false;
    }
    
    forward = anglestoforward( inflictor.angles );
    moving = inflictor vehicle_getvelocity();
    between = math::anglebetweenvectors( forward, moving );
    movingforward = undefined;
    
    if ( between < 45 )
    {
        movingforward = 1;
    }
    else if ( between > 135 )
    {
        movingforward = 0;
    }
    else
    {
        return false;
    }
    
    localorigin = coordtransformtranspose( victim.origin, inflictor.origin, inflictor.angles );
    
    if ( movingforward && localorigin[ 0 ] < extents[ "front" ] - 30 )
    {
        return true;
    }
    
    if ( !movingforward && localorigin[ 0 ] > -1 * ( extents[ "back" ] - 30 ) )
    {
        return true;
    }
    
    return false;
}

// Namespace vehicle_collision
// Params 1
// Checksum 0x56400106, Offset: 0x23e3
// Size: 0x4c, Type: bool
function function_ff24898d8aa594cd( deathdata )
{
    if ( deathdata.meansofdeath != "MOD_CRUSH" )
    {
        return false;
    }
    
    if ( !isdefined( deathdata.inflictor ) || !deathdata.inflictor vehicle::is_vehicle() )
    {
        return false;
    }
    
    return true;
}

// Namespace vehicle_collision
// Params 1
// Checksum 0xb5755679, Offset: 0x2438
// Size: 0x58, Type: bool
function function_202aa0d37286dc21( deathdata )
{
    return isdismembermentenabled() && !deathdata.victim.liveragdoll && deathdata.inflictor.isheli && deathdata.damage == 999999;
}

// Namespace vehicle_collision
// Params 1
// Checksum 0x99bf36ab, Offset: 0x2499
// Size: 0x150
function function_9a63065217865db4( deathdata )
{
    if ( !function_ff24898d8aa594cd( deathdata ) )
    {
        return;
    }
    
    if ( deathdata.inflictor.vehiclename )
    {
        vehicledata = vehicle::get_data( deathdata.inflictor.vehiclename );
    }
    
    if ( function_202aa0d37286dc21( deathdata ) )
    {
        thread player_killed_fx( deathdata.victim, "corpseMist", 1 );
        return;
    }
    
    speed = deathdata.inflictor vehicle_getspeed();
    
    if ( abs( speed ) > 1 )
    {
        showcorpse = 1;
        part = "runOverSlow";
        speedthreshold = 40;
        
        if ( abs( speed ) > speedthreshold )
        {
            showcorpse = 0;
            part = "runOverFast";
        }
        
        thread player_killed_fx( deathdata.victim, part, !showcorpse );
        return;
    }
    
    var_9be9490640ae9ba1 = vehicledata.damage.var_be70a786cd553819 ?? #"vehicle_body_hit";
    playsoundatpos( deathdata.victim.origin + ( 0, 0, 30 ), var_9be9490640ae9ba1 );
}

// Namespace vehicle_collision
// Params 3
// Checksum 0xea9891f, Offset: 0x25f1
// Size: 0x151
function player_killed_fx( victim, part, nocorpse )
{
    var_9df9bbec75709f0f = 35;
    
    if ( nocorpse )
    {
        victim.nocorpse = 1;
    }
    
    if ( !isdefined( level.playerswithoutdismemberment ) || level.playerswithoutdismemberment.size < var_9df9bbec75709f0f )
    {
        fxent = spawn( "script_model", victim gettagorigin( "j_mainroot" ) );
        fxent.angles = victim.angles;
        fxent setmodel( "iw9_player_death_fx" );
        
        if ( fxent.model != "" )
        {
            fxent setscriptablepartstate( part, "effects", 0 );
        }
        
        if ( isdefined( level.playerswithoutdismemberment ) )
        {
            foreach ( player in level.playerswithoutdismemberment )
            {
                fxent hidefromplayer( player );
            }
        }
        
        wait 0.5;
        fxent delete();
    }
}

