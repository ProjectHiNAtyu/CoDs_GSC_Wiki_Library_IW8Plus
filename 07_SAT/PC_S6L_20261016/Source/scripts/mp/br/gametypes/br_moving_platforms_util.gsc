// scripts\mp\br\gametypes\br_moving_platforms_util.gsc  (hash_76710ffb9f59cf40.gscc) (size: 5710 Bytes / 0x164e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xacbe3259 (2898145881)
// size ...... 5710 (0x164e)
// includes .. 10  (offset: 0x155a)
// strings ... 9   (offset: 0x15aa)
// dev strs .. 0   (offset: 0x164e)
// exports ... 19  (offset: 0xcfa)
// cseg ...... 0x116 + 0xbe4 (0xcfa)
// imports ... 47  (offset: 0xff2)
// animtree1 . 0   (offset: 0x164e)
// animtree2 . 0   (offset: 0x164e)
#using scripts\common\math;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_collision;
#using scripts\common\vehicle_damage;
#using scripts\mp\br\gametypes\br_armory_kiosk;
#using scripts\mp\br\gametypes\br_weapon_upgrade;
#using scripts\mp\flags;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_kiosk;

#namespace br_moving_platforms_util;

// Namespace br_moving_platforms_util
// Params 2
// Checksum 0x2a2b082f, Offset: 0x134
// Size: 0x154
function function_e0a4b01c145d401b( var_63b4574d606f91e0, var_bfec031524a5516c )
{
    scriptablearray = [];
    
    foreach ( loot in var_63b4574d606f91e0.lootarray )
    {
        type = loot.targetname;
        
        switch ( type )
        {
            case #"hash_735d8d8888878a53":
                scriptable = function_bcd8bb47c82370fb( loot );
                break;
            case #"hash_48c2dbc1e832de89":
                scriptable = function_5666d665034f7b40( loot );
                break;
            case #"hash_417c605750c7baa5":
                if ( isdefined( var_63b4574d606f91e0.var_52044e72f30a9735 ) )
                {
                    scriptable = [[ var_63b4574d606f91e0.var_52044e72f30a9735 ]]( var_63b4574d606f91e0, loot, type );
                }
                else
                {
                    scriptable = function_7cf0720d5f3ef083( loot, type );
                }
                
                break;
            default:
                scriptable = undefined;
                break;
        }
        
        if ( isdefined( scriptable ) )
        {
            scriptablearray[ scriptablearray.size ] = scriptable;
        }
    }
    
    thread function_a137069acbf13d1( var_63b4574d606f91e0, scriptablearray, var_bfec031524a5516c );
}

// Namespace br_moving_platforms_util
// Params 1
// Checksum 0x1f54ebd8, Offset: 0x290
// Size: 0x49
function function_bcd8bb47c82370fb( loot )
{
    if ( common_item::items_isenabled() )
    {
        scriptable = common_kiosk::function_27da31038bf50233( loot );
    }
    else
    {
        scriptable = br_armory_kiosk::function_1d91196be82c23bd( loot );
    }
    
    scriptable setscriptablepartstate( "br_plunder_box", "hidden" );
    return scriptable;
}

// Namespace br_moving_platforms_util
// Params 1
// Checksum 0x2dc6397b, Offset: 0x2e2
// Size: 0x54
function function_5666d665034f7b40( loot )
{
    if ( br_weapon_upgrade::function_f931980fcbcda20b() )
    {
        scriptable = spawnscriptable( "br_workbench", loot.origin, loot.angles );
        scriptable setscriptablepartstate( "br_workbench", "visible" );
        return scriptable;
    }
}

// Namespace br_moving_platforms_util
// Params 2
// Checksum 0x2b075b61, Offset: 0x33e
// Size: 0x48
function function_7cf0720d5f3ef083( loot, type )
{
    scriptable = spawnscriptable( type, loot.origin, loot.angles );
    thread function_2a5d3149998b776a( scriptable );
    return scriptable;
}

// Namespace br_moving_platforms_util
// Params 1
// Checksum 0xb7784e49, Offset: 0x38f
// Size: 0x4b
function function_4ad1be68090cbc56( var_ef091d37dff54373 )
{
    flags::gameflagwait( "prematch_fade_done" );
    
    if ( var_ef091d37dff54373 getscriptablehaspart( "body" ) && var_ef091d37dff54373 getscriptableparthasstate( "body", "hidden" ) )
    {
        var_ef091d37dff54373 setscriptablepartstate( "body", "hidden" );
    }
}

// Namespace br_moving_platforms_util
// Params 1
// Checksum 0x7a657513, Offset: 0x3e2
// Size: 0x89
function function_2a5d3149998b776a( var_ef091d37dff54373 )
{
    flags::gameflagwait( "prematch_fade_done" );
    
    if ( var_ef091d37dff54373 getscriptablehaspart( "body" ) && var_ef091d37dff54373 getscriptableparthasstate( "body", #"closed_usable_no_collision" ) )
    {
        var_ef091d37dff54373 setscriptablepartstate( "body", #"closed_usable_no_collision" );
        return;
    }
    
    if ( var_ef091d37dff54373 getscriptablehaspart( "body" ) && var_ef091d37dff54373 getscriptableparthasstate( "body", "closed_usable" ) )
    {
        var_ef091d37dff54373 setscriptablepartstate( "body", "closed_usable" );
    }
}

// Namespace br_moving_platforms_util
// Params 3
// Checksum 0x622e3871, Offset: 0x473
// Size: 0xbc
function function_a137069acbf13d1( var_63b4574d606f91e0, scriptablearray, var_bfec031524a5516c )
{
    flags::gameflagwait( "prematch_fade_done" );
    
    foreach ( scriptable in scriptablearray )
    {
        offset = function_f14e3e473d328abf( scriptable, var_63b4574d606f91e0 );
        scriptable thread function_46df5b2e53decb09( var_bfec031524a5516c, offset, scriptable.angles );
    }
}

// Namespace br_moving_platforms_util
// Params 2
// Checksum 0xa77a61a2, Offset: 0x537
// Size: 0x3a
function function_f14e3e473d328abf( loot, var_63b4574d606f91e0 )
{
    var_72db38fac8bc7c23 = loot.origin - var_63b4574d606f91e0.parentorigin;
    return var_72db38fac8bc7c23;
}

// Namespace br_moving_platforms_util
// Params 3
// Checksum 0x12a81976, Offset: 0x57a
// Size: 0x41
function function_46df5b2e53decb09( scriptmodel, offset, angles )
{
    level endon( #"game_ended" );
    waitframe();
    utility::scriptable_setparententity( scriptmodel, offset, angles );
    self.parent = scriptmodel;
}

// Namespace br_moving_platforms_util
// Params 5
// Checksum 0xce851f7c, Offset: 0x5c3
// Size: 0xa8
function function_7154926f1e826f60( animent, animref, currentrate, targetrate, time )
{
    acceleration = targetrate >= currentrate ? 1 : -1;
    minvalue = acceleration >= 0 ? currentrate : targetrate;
    maxvalue = acceleration >= 0 ? targetrate : currentrate;
    accelerationrate = ( maxvalue - minvalue ) / time;
    
    while ( currentrate != targetrate )
    {
        currentrate = function_9d3219c7962d81ca( animent, animref, acceleration, accelerationrate, currentrate, targetrate );
        waitframe();
    }
    
    return currentrate;
}

// Namespace br_moving_platforms_util
// Params 3
// Checksum 0xb6d5c99c, Offset: 0x674
// Size: 0x2b
function function_5016fcb45ade7fe5( currentrate, targetrate, time )
{
    return 0.5 * ( currentrate + targetrate ) * time;
}

// Namespace br_moving_platforms_util
// Params 6
// Checksum 0x4507a17e, Offset: 0x6a8
// Size: 0x99
function function_9d3219c7962d81ca( animent, animref, acceleration, accelerationrate, currentrate, targetrate )
{
    newrate = currentrate + acceleration * level.framedurationseconds * accelerationrate;
    
    if ( acceleration == 1 && newrate >= targetrate || acceleration == -1 && newrate <= targetrate )
    {
        newrate = targetrate;
    }
    
    if ( newrate != currentrate )
    {
        currentrate = newrate;
        
        if ( isdefined( animent ) )
        {
            function_744d037303d4179f( animent, animref, currentrate );
        }
    }
    
    return currentrate;
}

// Namespace br_moving_platforms_util
// Params 3
// Checksum 0xe4b8bef9, Offset: 0x74a
// Size: 0x48
function function_744d037303d4179f( animent, animref, newrate )
{
    animent setanimrate( animref, newrate );
    
    if ( isdefined( animent.var_ae02e6199e52ca42 ) )
    {
        [[ animent.var_ae02e6199e52ca42 ]]( animent, animref, newrate );
    }
}

// Namespace br_moving_platforms_util
// Params 2
// Checksum 0xa0ee0a90, Offset: 0x79a
// Size: 0x3d
function function_12dfff59bb8e05c7( assemblyent, animref )
{
    var_37c2b489b23e2485 = assemblyent getanimtime( animref );
    var_a04b6c8941a8f183 = getanimlength( animref ) * var_37c2b489b23e2485;
    return var_a04b6c8941a8f183;
}

// Namespace br_moving_platforms_util
// Params 0
// Checksum 0x6e489512, Offset: 0x7e0
// Size: 0x72
function function_905cbeab47d4a3d9()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self.velocity = ( 0, 0, 0 );
    
    while ( true )
    {
        self.lastorigin = self.origin;
        wait 0.05;
        self.velocity = ( self.origin - self.lastorigin ) / 0.05;
    }
}

// Namespace br_moving_platforms_util
// Params 5
// Checksum 0x644c86a2, Offset: 0x85a
// Size: 0x39e
function function_50beefc634f5b6ac( vehicle1, vehicle2, var_2a42106d7fab5ae1, collisioncooldown, var_dbb40ce8f2176838 )
{
    var_a953ba47f87cfcaa = vehicle1 vehicle::get_ref();
    istrain = var_a953ba47f87cfcaa == var_2a42106d7fab5ae1 || vehicle::get_data( var_a953ba47f87cfcaa ).istrain;
    
    if ( istrain )
    {
        movingplatform = vehicle1;
        vehicle = vehicle2;
    }
    else
    {
        movingplatform = vehicle2;
        vehicle = vehicle1;
    }
    
    if ( vehicle_collision::is_in_ignore_list( vehicle, movingplatform ) )
    {
        return;
    }
    
    if ( !( isdefined( vehicle ) && isdefined( vehicle.health ) ) )
    {
        return;
    }
    
    movingplatformvelocity = undefined;
    vehiclevelocity = vehicle vehicle_getvelocity();
    
    if ( isdefined( movingplatform.velocity ) )
    {
        movingplatformvelocity = movingplatform.velocity;
    }
    else if ( isdefined( movingplatform getlinkedchildren() ) )
    {
        velocity = undefined;
        children = movingplatform getlinkedchildren();
        
        foreach ( child in children )
        {
            if ( isdefined( child.velocity ) )
            {
                movingplatformvelocity = child.velocity;
                break;
            }
        }
    }
    
    magdamagemodifier = 1;
    dirdamagemodifier = 1;
    dvarmodifier = 1;
    var_47925b7fffa4c390 = 1;
    var_3dda7b37a84f78fa = 20;
    var_512d245e0421aeac = 0.5;
    var_c65552494dd5caee = 30;
    var_663ac03ca94e3df8 = length( vehiclevelocity );
    magdamagemodifier = math::remap( var_663ac03ca94e3df8, 0, 600, var_47925b7fffa4c390, var_3dda7b37a84f78fa );
    var_2be1e5087f607b31 = math::anglebetweenvectorsunit( vectornormalize( vehiclevelocity ), vectornormalize( movingplatformvelocity ) );
    dirdamagemodifier = math::remap( var_2be1e5087f607b31, 0, 180, var_512d245e0421aeac, var_c65552494dd5caee );
    
    if ( getdvarfloat( @"hash_c243128198440f06", -1 ) != -1 )
    {
        dvarmodifier = getdvarfloat( @"hash_c243128198440f06", -1 );
    }
    
    health = vehicle.health;
    mindamage = health / 10;
    damage = mindamage * dirdamagemodifier * magdamagemodifier * dvarmodifier;
    
    if ( vehicle.isdrone )
    {
        vehicle vehicle_damage::function_658976b407a5b2e1( 1 );
        damage = vehicle.maxhealth;
    }
    
    isvehicledestroyed = damage >= health;
    
    if ( isvehicledestroyed )
    {
        vehicle.dontspawnhusk = 1;
    }
    
    vehicle dodamage( damage, movingplatform.origin, movingplatform, movingplatform, "MOD_CRUSH" );
    
    if ( vehicle vehicle_isphysveh() )
    {
        impulsestrength = var_dbb40ce8f2176838 ?? 250;
        vehicle vehphys_impulse( vehicle.origin - movingplatform.origin + ( 0, 0, 200 ), impulsestrength, 1 );
    }
    
    if ( vehicle.health < health )
    {
        level thread vehicle_collision::function_b456610deaad175( vehicle, movingplatform, collisioncooldown );
    }
    
    collisionresult = spawnstruct();
    collisionresult.movingplatform = movingplatform;
    collisionresult.vehicle = vehicle;
    collisionresult.isvehicledestroyed = isvehicledestroyed;
    return collisionresult;
}

// Namespace br_moving_platforms_util
// Params 2
// Checksum 0x20f7a5f6, Offset: 0xc01
// Size: 0x6c
function function_52c1c5b599ce76ac( scriptable, model_name )
{
    collider = spawn( "script_model", scriptable.origin );
    collider setmodel( model_name );
    collider markkeyframedmover();
    collider forcenetfieldhighlod( 1 );
    collider setmoveroptimized( 1 );
    collider setmoverantilagged( 1 );
    level thread function_cb7ccd14acf5a673( scriptable, collider );
    return collider;
}

// Namespace br_moving_platforms_util
// Params 2, eflags: 0x4
// Checksum 0xe207bfd8, Offset: 0xc76
// Size: 0x84
function private function_cb7ccd14acf5a673( scriptable, collider )
{
    level endon( #"game_ended" );
    collider endon( #"death" );
    
    while ( !isdefined( scriptable.linkedparent ) )
    {
        wait 1;
    }
    
    collider.origin = scriptable.origin;
    collider.angles = scriptable.angles;
    collider linkto( scriptable.linkedparent );
}

