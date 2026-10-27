// script_1369fbbc07aed8e7  (hash_1369fbbc07aed8e7.gscc) (size: 1887 Bytes / 0x75f)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf1054fc (252728572)
// size ...... 1887 (0x75f)
// includes .. 0   (offset: 0x753)
// strings ... 0   (offset: 0x753)
// dev strs .. 1   (offset: 0x753)
// exports ... 7   (offset: 0x4fb)
// cseg ...... 0x58 + 0x4a3 (0x4fb)
// imports ... 11  (offset: 0x613)
// animtree1 . 0   (offset: 0x75f)
// animtree2 . 0   (offset: 0x75f)
#namespace ai_pickups;

// Namespace ai_pickups
// Params 9
// Checksum 0xeab04cf, Offset: 0x76
// Size: 0x10e
function function_4bee0d4450a7939d( name, seekradius, pickupgoalradius, var_68db451932994a4a, var_b8e662437ae5df0, var_aed555f549dd22d3, canusefunc, usefunc, additionaldata )
{
    if ( !isdefined( level.var_635e0041bbcebce8 ) )
    {
        level.var_635e0041bbcebce8 = [];
    }
    
    assert( !isdefined( level.var_635e0041bbcebce8[ name ] ) );
    newpickupdef = spawnstruct();
    newpickupdef.seekradius = seekradius;
    newpickupdef.pickupgoalradius = pickupgoalradius;
    newpickupdef.var_68db451932994a4a = var_68db451932994a4a;
    newpickupdef.var_b8e662437ae5df0 = var_b8e662437ae5df0;
    newpickupdef.var_aed555f549dd22d3 = var_aed555f549dd22d3;
    newpickupdef.canusefunc = canusefunc;
    newpickupdef.usefunc = usefunc;
    newpickupdef.additionaldata = additionaldata;
    level.var_635e0041bbcebce8[ name ] = newpickupdef;
}

// Namespace ai_pickups
// Params 1
// Checksum 0x4c64edc8, Offset: 0x18c
// Size: 0x21
function function_9a076652fb03a42b( ent )
{
    return level.var_635e0041bbcebce8[ ent.aipickupname ];
}

// Namespace ai_pickups
// Params 1
// Checksum 0x7e9035f4, Offset: 0x1b6
// Size: 0x4b
function function_ef75a31990d4e5c8( pickupname )
{
    self.aipickupname = pickupname;
    pickupdef = function_9a076652fb03a42b( self );
    assert( isdefined( pickupdef ), "<dev string:x24>" );
    addaipickup( self, pickupdef.seekradius );
}

// Namespace ai_pickups
// Params 1
// Checksum 0x8b0d140d, Offset: 0x209
// Size: 0xea
function function_4f30cff20917300e( taskid )
{
    pickups = getaipickups();
    pickupssorted = sortbydistance( pickups, self.origin );
    
    foreach ( pickup in pickupssorted )
    {
        pickupdef = function_9a076652fb03a42b( pickup );
        
        if ( [[ pickupdef.var_68db451932994a4a ]]( self, pickup ) )
        {
            self.bt.pickupitem = pickup;
            return anim.success;
        }
    }
    
    return anim.failure;
}

// Namespace ai_pickups
// Params 1
// Checksum 0xfae8b697, Offset: 0x2fc
// Size: 0xc2
function SeekPickupItem_SetGoal( taskid )
{
    if ( !isdefined( self.bt.pickupitem ) )
    {
        return anim.failure;
    }
    
    pickupdef = function_9a076652fb03a42b( self.bt.pickupitem );
    self setbtgoalpos( 3, self.bt.pickupitem.origin );
    self setbtgoalradius( 3, pickupdef.pickupgoalradius );
    var_b8e662437ae5df0 = pickupdef.var_b8e662437ae5df0;
    [[ var_b8e662437ae5df0 ]]( self, self.bt.pickupitem );
    return anim.success;
}

// Namespace ai_pickups
// Params 1
// Checksum 0x9a2d466d, Offset: 0x3c7
// Size: 0x133
function SeekPickupItem_Update( taskid )
{
    if ( !isdefined( self.bt.pickupitem ) )
    {
        return anim.failure;
    }
    
    pickupdef = function_9a076652fb03a42b( self.bt.pickupitem );
    var_aed555f549dd22d3 = pickupdef.var_aed555f549dd22d3;
    
    if ( [[ var_aed555f549dd22d3 ]]( self, self.bt.pickupitem ) )
    {
        return anim.failure;
    }
    
    if ( isdefined( self.var_9ba1d2db6b92df1 ) )
    {
        [[ self.var_9ba1d2db6b92df1 ]]( self, self.bt.pickupitem );
    }
    
    canusefunc = pickupdef.canusefunc;
    
    if ( [[ canusefunc ]]( self, self.bt.pickupitem ) )
    {
        usefunc = pickupdef.usefunc;
        [[ usefunc ]]( self, self.bt.pickupitem );
        self clearbtgoal( 3 );
        return anim.success;
    }
    
    return anim.running;
}

