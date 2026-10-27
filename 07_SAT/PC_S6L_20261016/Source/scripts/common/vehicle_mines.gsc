// scripts\common\vehicle_mines.gsc  (hash_1aa1d55da85d1a3f.gscc) (size: 3845 Bytes / 0xf05 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1deb078 (31371384)
// size ...... 3845 (0xf05)
// includes .. 3   (offset: 0xe99)
// strings ... 5   (offset: 0xeb1)
// dev strs .. 2   (offset: 0xeed)
// exports ... 11  (offset: 0x9d1)
// cseg ...... 0xda + 0x8f7 (0x9d1)
// imports ... 25  (offset: 0xb89)
// animtree1 . 0   (offset: 0xf05)
// animtree2 . 0   (offset: 0xf05)
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;

#namespace vehicle_mines;

// Namespace vehicle_mines
// Params 0
// Checksum 0x6e6d13aa, Offset: 0xf8
// Size: 0x82
function init()
{
    assert( isdefined( level.vehicle ), "<dev string:x24>" );
    leveldata = spawnstruct();
    leveldata.minedata = [];
    level.vehicle.minetriggerdata = leveldata;
    
    if ( utility::issharedfuncdefined( #"vehicle_mines", #"init" ) )
    {
        [[ utility::getsharedfunc( #"vehicle_mines", #"init" ) ]]();
    }
}

// Namespace vehicle_mines
// Params 0
// Checksum 0x3707f4bc, Offset: 0x182
// Size: 0x36
function get_level_data()
{
    assert( isdefined( level.vehicle.minetriggerdata ), "<dev string:x58>" );
    return level.vehicle.minetriggerdata;
}

// Namespace vehicle_mines
// Params 2
// Checksum 0x4d717a71, Offset: 0x1c1
// Size: 0xd5
function get_data( vehicleref, create )
{
    leveldataforvehicle = vehicle_damage::get_data( vehicleref, create );
    
    if ( !( isdefined( leveldataforvehicle ) && isdefined( leveldataforvehicle.frontextents ) ) && create )
    {
        if ( !isdefined( leveldataforvehicle ) )
        {
            leveldataforvehicle = spawnstruct();
        }
        
        leveldataforvehicle.frontextents = 90;
        leveldataforvehicle.backextents = 115;
        leveldataforvehicle.leftextents = 38;
        leveldataforvehicle.rightextents = 38;
        leveldataforvehicle.bottomextents = 40;
        leveldataforvehicle.topextents = 40;
        leveldataforvehicle.loscheckoffset = ( 0, 0, 37 );
        vehicle::get_data( vehicleref ).damage = leveldataforvehicle;
    }
    
    return leveldataforvehicle;
}

// Namespace vehicle_mines
// Params 2
// Checksum 0x897086c4, Offset: 0x29f
// Size: 0xe5
function function_fcfe63b165cc9a8( vehicleref, data )
{
    leveldataforvehicle = vehicle_damage::get_data( vehicleref );
    
    if ( isdefined( leveldataforvehicle ) )
    {
        leveldataforvehicle.frontextents = data.frontextents;
        leveldataforvehicle.backextents = data.backextents;
        leveldataforvehicle.leftextents = data.leftextents;
        leveldataforvehicle.rightextents = data.rightextents;
        leveldataforvehicle.bottomextents = data.bottomextents;
        leveldataforvehicle.topextents = data.topextents;
        leveldataforvehicle.loscheckoffset = data.loscheckoffset;
        vehicle::get_data( vehicleref ).damage = leveldataforvehicle;
    }
}

// Namespace vehicle_mines
// Params 2
// Checksum 0xaeaf5f89, Offset: 0x38c
// Size: 0x7d
function get_mine_data( equipref, create )
{
    leveldata = get_level_data();
    leveldataformine = leveldata.minedata[ equipref ];
    
    if ( !isdefined( leveldataformine ) && create )
    {
        leveldataformine = spawnstruct();
        leveldataformine.radius = 10;
        leveldataformine.triggercallback = undefined;
        leveldata.minedata[ equipref ] = leveldataformine;
    }
    
    return leveldataformine;
}

// Namespace vehicle_mines
// Params 2
// Checksum 0xe1f5b76d, Offset: 0x412
// Size: 0x388, Type: bool
function function_60d53a1a3bd504cd( vehicle, mine )
{
    if ( !vehicle vehicle::is_vehicle() )
    {
        return false;
    }
    
    if ( vehicle.var_1c98f583383286ef )
    {
        return false;
    }
    
    leveldataforvehicle = get_data( vehicle vehicle::get_ref() ) ?? get_data( vehicle.targetname );
    
    if ( !isdefined( leveldataforvehicle ) )
    {
        return false;
    }
    
    leveldataformine = get_mine_data( mine.equipmentref );
    
    if ( !isdefined( leveldataformine ) )
    {
        return false;
    }
    
    if ( mine.exploding )
    {
        return false;
    }
    
    if ( lengthsquared( vehicle vehicle_getvelocity() ) < 100 )
    {
        if ( lengthsquared( vehicle vehicle_getangularvelocity() ) < 400 )
        {
            return false;
        }
    }
    
    if ( vehicle vehicle::is_destroyed() )
    {
        return false;
    }
    
    forward = anglestoforward( vehicle.angles );
    right = anglestoright( vehicle.angles );
    frontoffsetvec = forward * leveldataforvehicle.frontextents;
    backoffsetvec = forward * -1 * leveldataforvehicle.backextents;
    leftoffsetvec = right * -1 * leveldataforvehicle.leftextents;
    rightoffsetvec = right * leveldataforvehicle.rightextents;
    vehicleorigin = vehicle.origin + leveldataforvehicle.loscheckoffset;
    frontleft = vehicleorigin + frontoffsetvec + leftoffsetvec;
    frontright = vehicleorigin + frontoffsetvec + rightoffsetvec;
    backleft = vehicleorigin + backoffsetvec + leftoffsetvec;
    backright = vehicleorigin + backoffsetvec + rightoffsetvec;
    var_fd16c62c79f9ed28 = ( frontright - frontleft ) * ( 1, 1, 0 );
    var_d67fbff6f2d6dd52 = ( frontleft - backleft ) * ( 1, 1, 0 );
    between = frontleft - mine.origin;
    betweendot = vectordot( vectornormalize( function_5acc9514819ccd43( var_fd16c62c79f9ed28 ) ), between );
    
    if ( betweendot > leveldataformine.radius )
    {
        return false;
    }
    
    betweendot = vectordot( vectornormalize( function_5acc9514819ccd43( var_d67fbff6f2d6dd52 ) ), between );
    
    if ( betweendot > leveldataformine.radius )
    {
        return false;
    }
    
    var_d00c432a6fea236c = ( backleft - backright ) * ( 1, 1, 0 );
    var_45bdc73e7060352f = ( backright - frontright ) * ( 1, 1, 0 );
    between = backright - mine.origin;
    betweendot = vectordot( vectornormalize( function_5acc9514819ccd43( var_d00c432a6fea236c ) ), between );
    
    if ( betweendot > leveldataformine.radius )
    {
        return false;
    }
    
    betweendot = vectordot( vectornormalize( function_5acc9514819ccd43( var_45bdc73e7060352f ) ), between );
    
    if ( betweendot > leveldataformine.radius )
    {
        return false;
    }
    
    up = anglestoup( vehicle.angles );
    vehiclebottom = vehicleorigin - up * leveldataforvehicle.bottomextents;
    var_c32265c39f79f347 = mine.origin - vehiclebottom;
    betweendot = vectordot( var_c32265c39f79f347, up );
    
    if ( betweendot > leveldataforvehicle.bottomextents + leveldataforvehicle.topextents )
    {
        return false;
    }
    else if ( betweendot < 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace vehicle_mines
// Params 2
// Checksum 0xfe3f6058, Offset: 0x7a3
// Size: 0xc3
function trigger_mine( vehicle, mine )
{
    leveldataformine = get_mine_data( mine.equipmentref );
    
    if ( isdefined( leveldataformine.triggercallback ) )
    {
        thread [[ leveldataformine.triggercallback ]]( vehicle, mine );
    }
    
    leveldataforvehicle = get_data( vehicle vehicle::get_ref() );
    
    if ( isdefined( leveldataforvehicle.triggercallback ) )
    {
        thread [[ leveldataforvehicle.triggercallback ]]( vehicle, mine );
    }
    
    if ( utility::issharedfuncdefined( #"vehicle_mines", #"trigger" ) )
    {
        thread [[ utility::getsharedfunc( #"vehicle_mines", #"trigger" ) ]]( vehicle, mine );
    }
}

// Namespace vehicle_mines
// Params 1
// Checksum 0x4a346189, Offset: 0x86e
// Size: 0x104
function function_56d954c642e8acea( mine )
{
    friendlytomine = 0;
    
    if ( level.teambased )
    {
        mineteam = mine.team;
        
        if ( !isdefined( mineteam ) )
        {
            if ( isdefined( mine.owner ) )
            {
                mineteam = mine.owner.team;
            }
        }
        
        if ( isdefined( mineteam ) )
        {
            friendlytomine = vehicle::function_977daeae4e2f0e30( self, mineteam );
        }
    }
    else if ( isdefined( mine.owner ) )
    {
        friendlytomine = vehicle::is_friendly_to_player( self, mine.owner );
    }
    
    if ( !friendlytomine )
    {
        if ( isdefined( self.owner ) )
        {
            if ( level.teambased )
            {
                if ( self.owner.team == mine.team )
                {
                    friendlytomine = 1;
                }
            }
            else if ( self.owner == mine.owner )
            {
                friendlytomine = 1;
            }
        }
    }
    
    return friendlytomine;
}

// Namespace vehicle_mines
// Params 1
// Checksum 0x3f6d296b, Offset: 0x97b
// Size: 0x18
function function_5acc9514819ccd43( vector )
{
    return ( vector[ 1 ], vector[ 0 ] * -1, 0 );
}

// Namespace vehicle_mines
// Params 0
// Checksum 0x2212d085, Offset: 0x99c
// Size: 0x34
function function_70d072049d790ed7()
{
    return physics_createcontents( [ "physicscontents_water", "physicscontents_glass", "physicscontents_item", "physicscontents_vehicle", "physicscontents_ainosight" ] );
}

