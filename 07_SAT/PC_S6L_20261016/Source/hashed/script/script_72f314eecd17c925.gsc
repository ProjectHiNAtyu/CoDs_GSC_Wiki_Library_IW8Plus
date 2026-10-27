// script_72f314eecd17c925  (hash_72f314eecd17c925.gscc) (size: 843 Bytes / 0x34b)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x242bb606 (606844422)
// size ...... 843 (0x34b)
// includes .. 0   (offset: 0x33f)
// strings ... 0   (offset: 0x33f)
// dev strs .. 1   (offset: 0x33f)
// exports ... 5   (offset: 0x21f)
// cseg ...... 0x58 + 0x1c7 (0x21f)
// imports ... 3   (offset: 0x2e7)
// animtree1 . 0   (offset: 0x34b)
// animtree2 . 0   (offset: 0x34b)
#namespace namespace_6c82574868b070c3;

// Namespace namespace_6c82574868b070c3
// Params 3
// Checksum 0xa391a34, Offset: 0x76
// Size: 0x57
function function_603cb2783e12568c( var_4e250044c834f802, var_2a6412b65b3b85dc, var_4d6e31701cd8323 )
{
    var_f19d6458dc53122d = {};
    var_f19d6458dc53122d.var_4e250044c834f802 = var_4e250044c834f802;
    var_f19d6458dc53122d.var_2a6412b65b3b85dc = var_2a6412b65b3b85dc;
    var_f19d6458dc53122d.var_4d6e31701cd8323 = var_4d6e31701cd8323;
    return var_f19d6458dc53122d;
}

// Namespace namespace_6c82574868b070c3
// Params 1
// Checksum 0xc56216c8, Offset: 0xd6
// Size: 0x2f
function function_ada7ba1ebece5ddd( currentargument )
{
    self.var_8bf6b45f43883633 = 1;
    self.currentargument = currentargument;
    self.actionstarttime = gettime();
}

// Namespace namespace_6c82574868b070c3
// Params 0
// Checksum 0x91b11ab4, Offset: 0x10d
// Size: 0x20
function function_e58c06eabfee4606()
{
    self.var_8bf6b45f43883633 = undefined;
    self.currentargument = undefined;
    self.actionstarttime = undefined;
}

// Namespace namespace_6c82574868b070c3
// Params 1
// Checksum 0xdf1dc875, Offset: 0x135
// Size: 0xe9
function function_cba069b412001a09( argument )
{
    if ( !self.var_8bf6b45f43883633 )
    {
        return 0;
    }
    
    if ( !isdefined( self.var_2a6412b65b3b85dc ) )
    {
        return 0;
    }
    
    if ( isdefined( self.currentargument ) != isdefined( argument ) )
    {
        return 0;
    }
    
    if ( isdefined( self.currentargument ) )
    {
        if ( isdefined( self.var_4e250044c834f802 ) )
        {
            if ( ![[ self.var_4e250044c834f802 ]]( self.currentargument, argument ) )
            {
                return 0;
            }
        }
        else
        {
            assert( !isstruct( self.currentargument ), "<dev string:x24>" );
            
            if ( self.currentargument != argument )
            {
                return 0;
            }
        }
    }
    
    sunkcost = ( gettime() - self.actionstarttime ) * self.var_2a6412b65b3b85dc * 0.001;
    
    if ( sunkcost > self.var_4d6e31701cd8323 )
    {
        sunkcost = self.var_4d6e31701cd8323;
    }
    
    return sunkcost;
}

