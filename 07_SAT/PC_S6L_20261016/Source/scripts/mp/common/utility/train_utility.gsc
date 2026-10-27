// scripts\mp\common\utility\train_utility.gsc  (hash_4bc071ceee4f6a86.gscc) (size: 5648 Bytes / 0x1610 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x201f813 (33683475)
// size ...... 5648 (0x1610)
// includes .. 0   (offset: 0x15bc)
// strings ... 7   (offset: 0x15bc)
// dev strs .. 0   (offset: 0x1610)
// exports ... 17  (offset: 0x1048)
// cseg ...... 0x113 + 0xf35 (0x1048)
// imports ... 23  (offset: 0x12f0)
// animtree1 . 0   (offset: 0x1610)
// animtree2 . 0   (offset: 0x1610)
#namespace train_utility;

// Namespace train_utility
// Params 0
// Checksum 0xa390eab4, Offset: 0x131
// Size: 0x28, Type: bool
function player_standing_on_train()
{
    potential_train = self getmovingplatformparent();
    
    if ( isdefined( potential_train ) )
    {
        if ( is_train_ent( potential_train ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace train_utility
// Params 0
// Checksum 0x4bd8a316, Offset: 0x162
// Size: 0xb8
function get_train_engine()
{
    if ( level.wztrain_info.train_array[ 0 ] )
    {
        return level.wztrain_info.train_array[ 0 ];
    }
    
    if ( level.var_9d79d0e953b26e80 )
    {
        foreach ( train in level.var_9d79d0e953b26e80 )
        {
            return train.engine;
        }
    }
}

// Namespace train_utility
// Params 1
// Checksum 0xf4502816, Offset: 0x222
// Size: 0x1f3, Type: bool
function is_train_ent( hitent )
{
    if ( isdefined( level.wztrain_info ) )
    {
        foreach ( ent in level.wztrain_info.train_array )
        {
            if ( !isdefined( ent ) )
            {
                continue;
            }
            
            if ( ent == hitent )
            {
                return true;
            }
            
            if ( ent.linked_model == hitent )
            {
                return true;
            }
        }
    }
    
    if ( level.var_9d79d0e953b26e80 )
    {
        foreach ( train in level.var_9d79d0e953b26e80 )
        {
            foreach ( traincar in train.traincars )
            {
                if ( hitent == traincar.model || hitent == traincar.brush || traincar.hurts && arraycontains( traincar.hurts, hitent ) )
                {
                    return true;
                }
            }
        }
    }
    
    return false;
}

// Namespace train_utility
// Params 0
// Checksum 0xe9c952a7, Offset: 0x41e
// Size: 0x37
function function_8f8b1d91271dffd8()
{
    if ( !level.wztrain_info && !level.var_9d79d0e953b26e80 )
    {
        return;
    }
    
    potential_train = self getmovingplatformparent();
    return get_train_name( potential_train );
}

// Namespace train_utility
// Params 1
// Checksum 0x504a3052, Offset: 0x45e
// Size: 0x234
function get_train_name( hitent )
{
    if ( !isdefined( hitent ) )
    {
        return;
    }
    
    if ( level.wztrain_info.trains )
    {
        foreach ( train, array in level.wztrain_info.trains )
        {
            foreach ( ent in array )
            {
                if ( ent == hitent )
                {
                    return train;
                }
                
                if ( ent.linked_model == hitent )
                {
                    return train;
                }
            }
        }
    }
    
    if ( level.var_9d79d0e953b26e80 )
    {
        foreach ( name, train in level.var_9d79d0e953b26e80 )
        {
            foreach ( traincar in train.traincars )
            {
                if ( hitent == traincar.model || hitent == traincar.brush )
                {
                    return name;
                }
            }
        }
    }
}

// Namespace train_utility
// Params 0
// Checksum 0xb3c322cc, Offset: 0x69b
// Size: 0x54
function function_d2c2c502947f8c4a()
{
    content = [ "physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicle", "physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_playerclip" ];
    return physics_createcontents( content );
}

// Namespace train_utility
// Params 1
// Checksum 0x4fbb4d7b, Offset: 0x6f8
// Size: 0x1ce, Type: bool
function is_moving_platform_train( movingplatforment )
{
    if ( !isdefined( movingplatforment ) )
    {
        return false;
    }
    
    if ( isdefined( level.wztrain_info ) )
    {
        foreach ( ent in level.wztrain_info.train_array )
        {
            if ( ent == movingplatforment )
            {
                return true;
            }
            
            if ( ent.linked_model == movingplatforment )
            {
                return true;
            }
        }
    }
    
    if ( level.var_9d79d0e953b26e80 )
    {
        foreach ( train in level.var_9d79d0e953b26e80 )
        {
            foreach ( traincar in train.traincars )
            {
                if ( movingplatforment == traincar.model || movingplatforment == traincar.brush )
                {
                    return true;
                }
            }
        }
    }
    
    return false;
}

// Namespace train_utility
// Params 9
// Checksum 0x50cbed1a, Offset: 0x8cf
// Size: 0x7a
function isplayerinsiderectangularzonebasedonent( player, referenceent, var_f7d559b3a9791757, var_8f52523a22e01091, var_365595e6474f6ba, var_722b340f83d85d8f, zonelength, zonewidth, zoneheight )
{
    rectangularzone = createrectangularzonebasedonent( referenceent, var_f7d559b3a9791757, var_8f52523a22e01091, var_365595e6474f6ba, var_722b340f83d85d8f, zonelength, zonewidth, zoneheight );
    return isplayerinsiderectangularzone( player, rectangularzone );
}

// Namespace train_utility
// Params 2
// Checksum 0x4ce6a49d, Offset: 0x952
// Size: 0xd2, Type: bool
function isplayerinsiderectangularzone( player, rectangularzone )
{
    player_x = player.origin[ 0 ];
    player_y = player.origin[ 1 ];
    player_z = player.origin[ 2 ];
    
    if ( player_x > rectangularzone.max_x )
    {
        return false;
    }
    
    if ( player_x < rectangularzone.min_x )
    {
        return false;
    }
    
    if ( player_y > rectangularzone.max_y )
    {
        return false;
    }
    
    if ( player_y < rectangularzone.min_y )
    {
        return false;
    }
    
    if ( player_z > rectangularzone.max_z )
    {
        return false;
    }
    
    if ( player_z < rectangularzone.min_z )
    {
        return false;
    }
    
    return true;
}

// Namespace train_utility
// Params 8
// Checksum 0x5625d1fb, Offset: 0xa2d
// Size: 0x2df
function createrectangularzonebasedonent( referenceent, var_f7d559b3a9791757, var_8f52523a22e01091, var_365595e6474f6ba, var_722b340f83d85d8f, zonelength, zonewidth, zoneheight )
{
    rectangularzone = createdefaultrectangularzone();
    referenceforward = anglestoforward( referenceent.angles );
    referenceright = anglestoright( referenceent.angles );
    referenceup = anglestoup( referenceent.angles );
    basetagpos = referenceent gettagorigin( var_f7d559b3a9791757 );
    zonecenter = basetagpos + referenceforward * var_8f52523a22e01091 + referenceright * var_365595e6474f6ba + referenceup * var_722b340f83d85d8f;
    
    /#
        var_4029cd693d655232 = [];
        function_c1b281bd4d4c6ea( zonecenter );
    #/
    
    halflength = zonelength / 2;
    halfwidth = zonewidth / 2;
    halfheight = zoneheight / 2;
    var_2848f46b2cfa40b = [ halflength, halflength * -1 ];
    var_93777ef4dcaeb373 = [ halfwidth, halfwidth * -1 ];
    zoneheightoffset = [ halfheight, halfheight * -1 ];
    
    foreach ( lengthoffset in var_2848f46b2cfa40b )
    {
        foreach ( widthoffset in var_93777ef4dcaeb373 )
        {
            foreach ( heightoffset in zoneheightoffset )
            {
                var_b7b9c0b1fa32a775 = zonecenter + referenceforward * lengthoffset + referenceright * widthoffset + referenceup * heightoffset;
                
                /#
                    function_60ee8668fda9bd3e( var_b7b9c0b1fa32a775 );
                    var_4029cd693d655232[ var_4029cd693d655232.size ] = var_b7b9c0b1fa32a775;
                #/
                
                updaterectangularzone( var_b7b9c0b1fa32a775, rectangularzone );
            }
        }
    }
    
    /#
        function_76f4c391b7890087( var_4029cd693d655232 );
    #/
    
    return rectangularzone;
}

// Namespace train_utility
// Params 2
// Checksum 0x9940c504, Offset: 0xd15
// Size: 0xfa
function updaterectangularzone( var_b7b9c0b1fa32a775, rectangularzone )
{
    var_4029d4693d656197 = var_b7b9c0b1fa32a775[ 0 ];
    var_4029d3693d655f64 = var_b7b9c0b1fa32a775[ 1 ];
    var_4029d6693d6565fd = var_b7b9c0b1fa32a775[ 2 ];
    
    if ( var_4029d4693d656197 > rectangularzone.max_x )
    {
        rectangularzone.max_x = var_4029d4693d656197;
    }
    
    if ( var_4029d4693d656197 < rectangularzone.min_x )
    {
        rectangularzone.min_x = var_4029d4693d656197;
    }
    
    if ( var_4029d3693d655f64 > rectangularzone.max_y )
    {
        rectangularzone.max_y = var_4029d3693d655f64;
    }
    
    if ( var_4029d3693d655f64 < rectangularzone.min_y )
    {
        rectangularzone.min_y = var_4029d3693d655f64;
    }
    
    if ( var_4029d6693d6565fd > rectangularzone.max_z )
    {
        rectangularzone.max_z = var_4029d6693d6565fd;
    }
    
    if ( var_4029d6693d6565fd < rectangularzone.min_z )
    {
        rectangularzone.min_z = var_4029d6693d6565fd;
    }
}

// Namespace train_utility
// Params 0
// Checksum 0x85a258d4, Offset: 0xe17
// Size: 0x7a
function createdefaultrectangularzone()
{
    rectangularzone = spawnstruct();
    rectangularzone.max_x = -999999;
    rectangularzone.min_x = 999999;
    rectangularzone.max_y = -999999;
    rectangularzone.min_y = 999999;
    rectangularzone.max_z = -999999;
    rectangularzone.min_z = 999999;
    return rectangularzone;
}

/#

    // Namespace train_utility
    // Params 1
    // Checksum 0x19500d49, Offset: 0xe9a
    // Size: 0x33, Type: dev
    function function_c1b281bd4d4c6ea( zonecenter )
    {
        if ( !function_a6284691bab08ec4() )
        {
            return;
        }
        
        sphere( zonecenter, 2, ( 1, 0, 0 ), 0, 60 );
    }

    // Namespace train_utility
    // Params 1
    // Checksum 0x589edb69, Offset: 0xed5
    // Size: 0x33, Type: dev
    function function_60ee8668fda9bd3e( var_b7b9c0b1fa32a775 )
    {
        if ( !function_a6284691bab08ec4() )
        {
            return;
        }
        
        sphere( var_b7b9c0b1fa32a775, 2, ( 0, 1, 0 ), 0, 60 );
    }

    // Namespace train_utility
    // Params 1
    // Checksum 0xedd31b64, Offset: 0xf10
    // Size: 0x11a, Type: dev
    function function_76f4c391b7890087( var_4029cd693d655232 )
    {
        if ( !function_a6284691bab08ec4() )
        {
            return;
        }
        
        foreach ( var_b7b9c0b1fa32a775 in var_4029cd693d655232 )
        {
            var_799fd403af3d4383 = var_4029cd693d655232;
            
            foreach ( var_8264fc1560b58902 in var_799fd403af3d4383 )
            {
                if ( var_8264fc1560b58902 == var_b7b9c0b1fa32a775 )
                {
                    continue;
                }
                
                line( var_b7b9c0b1fa32a775, var_8264fc1560b58902, ( 0, 0, 1 ), 1, 0, 60 );
            }
        }
    }

    // Namespace train_utility
    // Params 0
    // Checksum 0x9eea5b7c, Offset: 0x1032
    // Size: 0x16, Type: dev
    function function_a6284691bab08ec4()
    {
        return getdvarint( @"hash_aaddf2135ab39ed5", 0 ) != 0;
    }

#/
