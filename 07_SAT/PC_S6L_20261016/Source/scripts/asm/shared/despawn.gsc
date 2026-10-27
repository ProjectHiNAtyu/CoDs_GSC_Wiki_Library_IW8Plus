// scripts\asm\shared\despawn.gsc  (hash_5ed19553eeed5eee.gscc) (size: 1183 Bytes / 0x49f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x15f4f7e1 (368375777)
// size ...... 1183 (0x49f)
// includes .. 3   (offset: 0x44b)
// strings ... 4   (offset: 0x463)
// dev strs .. 0   (offset: 0x49f)
// exports ... 4   (offset: 0x26f)
// cseg ...... 0xac + 0x1c3 (0x26f)
// imports ... 11  (offset: 0x30f)
// animtree1 . 0   (offset: 0x49f)
// animtree2 . 0   (offset: 0x49f)
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\values;

#namespace despawn;

// Namespace despawn
// Params 3
// Checksum 0xb3fbdea3, Offset: 0xca
// Size: 0x27
function function_e61aced3b2555fe5( asmname, statename, params )
{
    thread function_68097764ce2c6124( params );
}

// Namespace despawn
// Params 1
// Checksum 0xd43c18c3, Offset: 0xf9
// Size: 0x13b
function function_68097764ce2c6124( bypassthrottle = 0 )
{
    if ( utility::ent_flag( "in_queue_despawn" ) )
    {
        return;
    }
    
    self endon( #"death" );
    level endon( #"game_ended" );
    utility::ent_flag_set( "in_queue_despawn" );
    
    if ( !isdefined( level.despawnThrottle ) )
    {
        level.despawnThrottle = throttle::throttle_initialize( "despawnThrottle", getdvarint( @"hash_31df6612d8150a09", 3 ), level.framedurationseconds );
    }
    
    if ( !bypassthrottle )
    {
        throttle::throttle_wait_in_queue( level.despawnThrottle, self );
    }
    
    if ( self.var_b1d9042e7d29abb8 )
    {
        self.nocorpse = 1;
    }
    
    self._blackboard.var_903cd88c07cfc16b = 0;
    utility::ent_flag_clear( "in_queue_despawn" );
    
    if ( val::get( "damageshield" ) && val::get( "damageshield_allow_delete" ) )
    {
        if ( utility::issharedfuncdefined( #"ai", #"hash_c649178f35fe47cf" ) )
        {
            utility::callsharedfunc( #"ai", #"hash_c649178f35fe47cf" );
        }
        else
        {
            return;
        }
    }
    else if ( val::get( "damageshield" ) )
    {
        return;
    }
    
    self kill();
}

// Namespace despawn
// Params 3
// Checksum 0xa41c005d, Offset: 0x23c
// Size: 0x32, Type: bool
function checkdespawn( asmname, statename, params )
{
    return !self._blackboard.var_903cd88c07cfc16b;
}

