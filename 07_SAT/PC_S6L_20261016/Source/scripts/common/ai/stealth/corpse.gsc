// scripts\common\ai\stealth\corpse.gsc  (hash_7b86b7ae0a3ab923.gscc) (size: 2346 Bytes / 0x92a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5e5f9c12 (1583324178)
// size ...... 2346 (0x92a)
// includes .. 1   (offset: 0x8aa)
// strings ... 9   (offset: 0x8b2)
// dev strs .. 0   (offset: 0x92a)
// exports ... 9   (offset: 0x52e)
// cseg ...... 0xd8 + 0x456 (0x52e)
// imports ... 18  (offset: 0x696)
// animtree1 . 0   (offset: 0x92a)
// animtree2 . 0   (offset: 0x92a)
#using scripts\common\ai\stealth\utility;

#namespace corpse;

// Namespace corpse
// Params 0
// Checksum 0x706b5190, Offset: 0xf6
// Size: 0x2c
function corpse_init_entity()
{
    assert( isdefined( self.stealth ) );
    self.stealth.corpse = spawnstruct();
}

// Namespace corpse
// Params 0
// Checksum 0x5d041aa, Offset: 0x12a
// Size: 0x8a
function corpse_init_level()
{
    if ( isdefined( level.stealth ) && isdefined( level.stealth.corpse ) )
    {
        return;
    }
    
    level.stealth.corpse = spawnstruct();
    level.stealth.corpse.reset_time = 30;
    level utility::set_stealth_func( "saw_corpse", &corpse_seen );
    level utility::set_stealth_func( "found_corpse", &corpse_found );
    set_corpse_ranges_default();
}

// Namespace corpse
// Params 0
// Checksum 0xdd2007cc, Offset: 0x1bc
// Size: 0x35
function set_corpse_ranges_default()
{
    array[ "sight_dist" ] = 768;
    array[ "detect_dist" ] = 256;
    array[ "found_dist" ] = 32;
    set_corpse_ranges( array );
}

// Namespace corpse
// Params 1
// Checksum 0x8c097452, Offset: 0x1f9
// Size: 0x34
function set_corpse_ranges( array )
{
    array = arraycopy( array );
    
    if ( !isdefined( array[ "shadow_dist" ] ) )
    {
        array[ "shadow_dist" ] = array[ "found_dist" ];
    }
    
    setstealthcorpsedistances( array );
}

// Namespace corpse
// Params 0
// Checksum 0x985b85d4, Offset: 0x235
// Size: 0x17
function set_corpse_ignore()
{
    assert( isent( self ) );
    setcorpseignored( self, 1 );
}

// Namespace corpse
// Params 1
// Checksum 0x9c98a43d, Offset: 0x254
// Size: 0xee, Type: bool
function corpse_check_shadow( origin )
{
    if ( !isdefined( self.in_shadow_origin ) || distancesquared( self.in_shadow_origin, origin ) > 1 )
    {
        self.in_shadow = undefined;
        
        if ( isdefined( level.trigger_stealth_shadow ) )
        {
            foreach ( trigger in level.trigger_stealth_shadow )
            {
                if ( isdefined( trigger ) && ispointinvolume( origin, trigger ) )
                {
                    self.in_shadow = 1;
                    break;
                }
            }
        }
        
        self.in_shadow_origin = origin;
    }
    
    return istrue( self.in_shadow );
}

// Namespace corpse
// Params 1
// Checksum 0xbb5b7576, Offset: 0x34b
// Size: 0xf7
function corpse_found( event )
{
    self notify( #"corpse_found" );
    self endon( #"corpse_found" );
    self endon( #"death" );
    
    if ( isdefined( level.battlechatter ) )
    {
        addbattlechatternotify( self, undefined, "corpse_found" );
    }
    
    corpse = event.entity;
    corpseorigin = getcorpseorigin( corpse );
    
    if ( isdefined( self.var_12d5685d122fc3d4 ) && self.var_12d5685d122fc3d4 != corpse )
    {
        setcorpseseen( self.var_12d5685d122fc3d4, 0 );
    }
    
    self.var_12d5685d122fc3d4 = corpse;
    
    if ( !isdefined( self.var_bfe4af4a56df4654 ) || self.var_bfe4af4a56df4654 == "small" )
    {
        self.bexaminerequested = 1;
    }
    
    corpse setcorpseforceremovetimer( level.stealth.corpse.reset_time );
}

// Namespace corpse
// Params 1
// Checksum 0x763c12f3, Offset: 0x44a
// Size: 0xe4
function corpse_seen( event )
{
    if ( isdefined( level.battlechatter ) )
    {
        addbattlechatternotify( self, undefined, "corpse_seen" );
    }
    
    corpse = event.entity;
    corpseorigin = getcorpseorigin( corpse );
    self.stealth.corpse.origin = corpseorigin;
    
    if ( !isdefined( self.var_bfe4af4a56df4654 ) || self.var_bfe4af4a56df4654 == "small" )
    {
        self.bexaminerequested = 1;
    }
    
    self notify( #"corpse_seen_claim" );
    
    if ( isdefined( self.var_12d5685d122fc3d4 ) && self.var_12d5685d122fc3d4 != corpse )
    {
        setcorpseseen( self.var_12d5685d122fc3d4, 0 );
    }
    
    setcorpseseen( corpse, 1 );
    self.var_12d5685d122fc3d4 = corpse;
}

