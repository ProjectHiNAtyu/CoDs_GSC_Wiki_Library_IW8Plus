// script_7de19de2e1aaef02  (hash_7de19de2e1aaef02.gscc) (size: 1896 Bytes / 0x768 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3dbb86da (1035699930)
// size ...... 1896 (0x768)
// includes .. 2   (offset: 0x6fc)
// strings ... 1   (offset: 0x70c)
// dev strs .. 6   (offset: 0x718)
// exports ... 4   (offset: 0x538)
// cseg ...... 0x76 + 0x4c2 (0x538)
// imports ... 9   (offset: 0x5d8)
// animtree1 . 0   (offset: 0x768)
// animtree2 . 0   (offset: 0x768)
#using scripts\common\math;
#using scripts\common\utility;

#namespace namespace_55cc783e00cbf8a;

// Namespace namespace_55cc783e00cbf8a
// Params 0, eflags: 0x1
// Checksum 0x220effce, Offset: 0x94
// Size: 0x20
function autoexec init_scaling_vehicle_attack()
{
    utility::registersharedfunc( #"zombie", #"hash_97c7552f5ba94f2c", &function_85d2042a11bbf65b );
}

// Namespace namespace_55cc783e00cbf8a
// Params 1
// Checksum 0xbeb151dd, Offset: 0xbc
// Size: 0x330
function function_85d2042a11bbf65b( fixed_round_number )
{
    if ( level.var_9c7fce064a6bec19 )
    {
        return;
    }
    
    assert( isdefined( fixed_round_number ), "<dev string:x24>" );
    
    if ( !isdefined( fixed_round_number ) )
    {
        return;
    }
    
    if ( isdefined( fixed_round_number ) )
    {
        roundnumber = fixed_round_number;
    }
    
    if ( !isdefined( self.var_d6894f01a36b4ff3.vehicleattackscalingscriptbundle ) )
    {
        return;
    }
    
    scriptbundle_name = self.var_d6894f01a36b4ff3.vehicleattackscalingscriptbundle;
    
    if ( !isdefined( level.var_21cf44cf05be53d6 ) )
    {
        level.var_21cf44cf05be53d6 = [];
    }
    
    if ( !isdefined( level.var_21cf44cf05be53d6[ scriptbundle_name ] ) )
    {
        var_f2c3d4741ca37252 = getscriptbundle( "vehicleattackscalinground:" + scriptbundle_name );
        
        if ( !isdefined( var_f2c3d4741ca37252 ) )
        {
            assert( "<dev string:x69>" + ( self.subclass ?? "<dev string:xa6>" ) );
            return;
        }
        
        level.var_21cf44cf05be53d6[ scriptbundle_name ] = var_f2c3d4741ca37252;
    }
    else
    {
        var_f2c3d4741ca37252 = level.var_21cf44cf05be53d6[ scriptbundle_name ];
    }
    
    assert( isdefined( var_f2c3d4741ca37252 ) );
    
    if ( self.var_d6894f01a36b4ff3.var_e1709a8e0b14d29b )
    {
        var_663647898de5233c = function_719baf979078f7e8( var_f2c3d4741ca37252.var_98427a43ccf00bf9, roundnumber );
        vehicle_attack_leap_intro_playback_rate = var_663647898de5233c[ 0 ];
        
        if ( vehicle_attack_leap_intro_playback_rate != -1 )
        {
            self._blackboard.var_53d396aac913b6e9 = getdvarfloat( @"vehicle_attack_leap_intro_playback_rate", vehicle_attack_leap_intro_playback_rate );
            
            if ( var_f2c3d4741ca37252.var_fd57582dedd37a22 )
            {
                self._blackboard.var_53d396aac913b6e9 = min( self._blackboard.var_53d396aac913b6e9, var_f2c3d4741ca37252.var_53b021557f66c08b );
            }
        }
        
        var_58550b0ea4b68d1e = var_663647898de5233c[ 1 ];
        
        if ( var_58550b0ea4b68d1e != -1 )
        {
            self._blackboard.var_996dd37c98c814bd = getdvarfloat( @"hash_ff8f074e50a3790e", var_58550b0ea4b68d1e );
            
            if ( var_f2c3d4741ca37252.var_d1b99e6c9eac551e )
            {
                self._blackboard.var_996dd37c98c814bd = min( self._blackboard.var_996dd37c98c814bd, var_f2c3d4741ca37252.var_ef5ca70554cbc757 );
            }
        }
        
        var_d6feca6319fb17c4 = var_663647898de5233c[ 2 ];
        
        if ( var_d6feca6319fb17c4 != -1 )
        {
            self._blackboard.var_61735da3a2cbdc4b = getdvarfloat( @"hash_72e92df9cf5e7e10", var_d6feca6319fb17c4 );
            
            if ( var_f2c3d4741ca37252.var_d1b99e6c9eac551e )
            {
                self._blackboard.var_61735da3a2cbdc4b = min( self._blackboard.var_61735da3a2cbdc4b, var_f2c3d4741ca37252.var_ef5ca70554cbc757 );
            }
        }
        
        var_484733ddae479748 = var_663647898de5233c[ 3 ];
        
        if ( var_484733ddae479748 != -1 )
        {
            self._blackboard.var_6a353391014208b2 = math::degrees_to_radians( getdvarfloat( @"hash_509d0272ce77ef8a", var_484733ddae479748 ) );
        }
        
        var_14b332f26735ca29 = var_663647898de5233c[ 4 ];
        
        if ( var_14b332f26735ca29 != -1 )
        {
            self._blackboard.var_a6c4c8d6043787b3 = math::degrees_to_radians( getdvarfloat( @"hash_744f864d7ef5f01", var_14b332f26735ca29 ) );
        }
    }
}

// Namespace namespace_55cc783e00cbf8a
// Params 2, eflags: 0x4
// Checksum 0xbdcd30b5, Offset: 0x3f4
// Size: 0x143
function private function_719baf979078f7e8( var_cf1fb427d9a1e87b, round_num )
{
    if ( isdefined( var_cf1fb427d9a1e87b ) && var_cf1fb427d9a1e87b.size > 0 )
    {
        var_78a63f139cf07707 = undefined;
        
        for ( i = var_cf1fb427d9a1e87b.size - 1; i >= 0 ; i-- )
        {
            if ( var_cf1fb427d9a1e87b[ i ].startround >= var_78a63f139cf07707 )
            {
                assert( "<dev string:xa7>" + ( self.subclass ?? "<dev string:xa6>" ) );
                return [ -1, -1 ];
            }
            
            if ( round_num >= var_cf1fb427d9a1e87b[ i ].startround )
            {
                return [ var_cf1fb427d9a1e87b[ i ].var_53d396aac913b6e9, var_cf1fb427d9a1e87b[ i ].var_da1cfe4dbb82e3db, var_cf1fb427d9a1e87b[ i ].var_3b9fe3e06e46f8a9, var_cf1fb427d9a1e87b[ i ].var_e9191c57b47e894c, var_cf1fb427d9a1e87b[ i ].var_21679fd5a203d387 ];
            }
            
            var_78a63f139cf07707 = var_cf1fb427d9a1e87b[ i ].startround;
        }
    }
    
    assert( "<dev string:x12a>" + round_num + "<dev string:x18d>" + ( self.subclass ?? "<dev string:xa6>" ) );
    return [ -1, -1 ];
}

