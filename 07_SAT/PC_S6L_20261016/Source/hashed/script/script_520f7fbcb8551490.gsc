// script_520f7fbcb8551490  (hash_520f7fbcb8551490.gscc) (size: 1735 Bytes / 0x6c7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x10541bab (273947563)
// size ...... 1735 (0x6c7)
// includes .. 1   (offset: 0x63f)
// strings ... 1   (offset: 0x647)
// dev strs .. 8   (offset: 0x653)
// exports ... 5   (offset: 0x467)
// cseg ...... 0x7a + 0x3ed (0x467)
// imports ... 9   (offset: 0x52f)
// animtree1 . 0   (offset: 0x6c7)
// animtree2 . 0   (offset: 0x6c7)
#using scripts\common\utility;

#namespace namespace_7543f4bfd12711ac;

// Namespace namespace_7543f4bfd12711ac
// Params 0, eflags: 0x1
// Checksum 0x26a3f970, Offset: 0x98
// Size: 0x20
function autoexec init_scaling_emergence_spawning()
{
    utility::registersharedfunc( #"zombie", #"hash_c726695b2536f1a", &function_bcfcf87237e24ae1 );
}

// Namespace namespace_7543f4bfd12711ac
// Params 1
// Checksum 0xf560db61, Offset: 0xc0
// Size: 0x1e3
function function_bcfcf87237e24ae1( fixed_round_number )
{
    if ( level.var_9bcd22d6c999aec3 )
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
    
    if ( !isdefined( self.var_d6894f01a36b4ff3.var_3da28da78ef10740 ) )
    {
        return;
    }
    
    scriptbundle_name = self.var_d6894f01a36b4ff3.var_3da28da78ef10740;
    
    if ( !isdefined( level.ai_damage_bundles ) )
    {
        level.ai_damage_bundles = [];
    }
    
    if ( !isdefined( level.ai_damage_bundles[ scriptbundle_name ] ) )
    {
        var_4baeff549a33df1c = getscriptbundle( "emergencespawningscalinground:" + scriptbundle_name );
        
        if ( !isdefined( var_4baeff549a33df1c ) )
        {
            assert( "<dev string:x6d>" + ( self.subclass ?? "<dev string:xae>" ) );
            return;
        }
        
        level.ai_damage_bundles[ scriptbundle_name ] = var_4baeff549a33df1c;
    }
    else
    {
        var_4baeff549a33df1c = level.ai_damage_bundles[ scriptbundle_name ];
    }
    
    assert( isdefined( var_4baeff549a33df1c ) );
    is_emergence_spawning_enabled = self.var_d6894f01a36b4ff3.var_d7922471e61ba16 || self.var_d6894f01a36b4ff3.var_8d07b1181350233d;
    var_6ce8ec231a713907 = istrue( self.var_d6894f01a36b4ff3.var_d7922471e61ba16 );
    
    if ( is_emergence_spawning_enabled )
    {
        var_c48c0b5d1126a9a = function_3347ff432e5ea974( var_4baeff549a33df1c.var_f7f4e44551bc63d1, roundnumber );
        
        if ( var_c48c0b5d1126a9a != -1 )
        {
            self._blackboard.var_5d7a0203e35cff2f = utility::function_4b74c15943231980( var_c48c0b5d1126a9a );
        }
    }
    
    if ( var_6ce8ec231a713907 )
    {
        var_986558bacc5e964d = function_cc096ae2430d67dd( var_4baeff549a33df1c.var_59154c43212f6e33, roundnumber );
        
        if ( var_986558bacc5e964d != -1 )
        {
            self.var_5383a40cc937dbd1 = getdvarfloat( @"hash_dbba9a86b67e3e41", var_986558bacc5e964d );
        }
    }
}

// Namespace namespace_7543f4bfd12711ac
// Params 2, eflags: 0x4
// Checksum 0x979f0a02, Offset: 0x2ab
// Size: 0xd9
function private function_3347ff432e5ea974( var_3292f2fc8f8bc4bf, round_num )
{
    if ( var_3292f2fc8f8bc4bf.size > 0 )
    {
        var_78a63f139cf07707 = undefined;
        
        for ( i = var_3292f2fc8f8bc4bf.size - 1; i >= 0 ; i-- )
        {
            if ( var_3292f2fc8f8bc4bf[ i ].startround >= var_78a63f139cf07707 )
            {
                assert( "<dev string:xaf>" + ( self.subclass ?? "<dev string:xae>" ) );
                return -1;
            }
            
            if ( round_num >= var_3292f2fc8f8bc4bf[ i ].startround )
            {
                return var_3292f2fc8f8bc4bf[ i ].var_aa99c9f15fe4087c;
            }
            
            var_78a63f139cf07707 = var_3292f2fc8f8bc4bf[ i ].startround;
        }
    }
    
    assert( "<dev string:x12b>" + round_num + "<dev string:x1a8>" + ( self.subclass ?? "<dev string:xae>" ) );
    return -1;
}

// Namespace namespace_7543f4bfd12711ac
// Params 2, eflags: 0x4
// Checksum 0xc6ee5ddc, Offset: 0x38d
// Size: 0xd9
function private function_cc096ae2430d67dd( var_524a79762d8386fc, round_num )
{
    if ( var_524a79762d8386fc.size > 0 )
    {
        var_78a63f139cf07707 = undefined;
        
        for ( i = var_524a79762d8386fc.size - 1; i >= 0 ; i-- )
        {
            if ( var_524a79762d8386fc[ i ].startround >= var_78a63f139cf07707 )
            {
                assert( "<dev string:x1c2>" + ( self.subclass ?? "<dev string:xae>" ) );
                return -1;
            }
            
            if ( round_num >= var_524a79762d8386fc[ i ].startround )
            {
                return var_524a79762d8386fc[ i ].var_5383a40cc937dbd1;
            }
            
            var_78a63f139cf07707 = var_524a79762d8386fc[ i ].startround;
        }
    }
    
    assert( "<dev string:x246>" + round_num + "<dev string:x1a8>" + ( self.subclass ?? "<dev string:xae>" ) );
    return -1;
}

