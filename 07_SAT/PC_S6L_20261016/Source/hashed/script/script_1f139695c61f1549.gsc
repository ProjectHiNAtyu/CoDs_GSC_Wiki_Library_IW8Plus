// script_1f139695c61f1549  (hash_1f139695c61f1549.gscc) (size: 2739 Bytes / 0xab3)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x457d30b0 (1165832368)
// size ...... 2739 (0xab3)
// includes .. 0   (offset: 0xab3)
// strings ... 0   (offset: 0xab3)
// dev strs .. 0   (offset: 0xab3)
// exports ... 19  (offset: 0x6bf)
// cseg ...... 0x58 + 0x667 (0x6bf)
// imports ... 8   (offset: 0x9b7)
// animtree1 . 0   (offset: 0xab3)
// animtree2 . 0   (offset: 0xab3)
#namespace namespace_191965e8dea0924e;

// Namespace namespace_191965e8dea0924e
// Params 1
// Checksum 0x61754f04, Offset: 0x76
// Size: 0x46
function function_b493dffc6327a910( var_6bfba741713ac7c4 )
{
    if ( isdefined( var_6bfba741713ac7c4 ) )
    {
        if ( isdefined( var_6bfba741713ac7c4.variant_object ) )
        {
            return var_6bfba741713ac7c4.variant_object.activityrewardcaches;
        }
        
        return var_6bfba741713ac7c4.activityrewardcaches;
    }
}

// Namespace namespace_191965e8dea0924e
// Params 1
// Checksum 0xb0a6dc14, Offset: 0xc5
// Size: 0x65
function function_7c46a45e35ee81c( var_6bfba741713ac7c4 )
{
    if ( !isdefined( var_6bfba741713ac7c4 ) )
    {
        return;
    }
    
    sharingsettings = var_6bfba741713ac7c4.sharingsettings;
    
    if ( !isdefined( sharingsettings ) )
    {
        return;
    }
    
    if ( !isdefined( sharingsettings.var_bf1e12453e0fd495 ) )
    {
        return;
    }
    
    var_bf1e12453e0fd495 = sharingsettings.var_bf1e12453e0fd495.variant_object;
    return var_bf1e12453e0fd495;
}

// Namespace namespace_191965e8dea0924e
// Params 1
// Checksum 0xa6dbe662, Offset: 0x133
// Size: 0x32
function function_1fac541a92b053dc( var_6bfba741713ac7c4 )
{
    parent = function_7c46a45e35ee81c( var_6bfba741713ac7c4 );
    
    if ( isdefined( parent ) )
    {
        return parent.activitycategory;
    }
}

// Namespace namespace_191965e8dea0924e
// Params 1
// Checksum 0x13f98d67, Offset: 0x16e
// Size: 0x32
function function_8eed7508d9aa91e8( var_6bfba741713ac7c4 )
{
    parent = function_7c46a45e35ee81c( var_6bfba741713ac7c4 );
    
    if ( isdefined( parent ) )
    {
        return parent.sharingtype;
    }
}

#namespace namespace_548228027aad4e18;

// Namespace namespace_548228027aad4e18
// Params 1
// Checksum 0xca443bfa, Offset: 0x1a9
// Size: 0x5a
function function_9cb4a154d3957d83( var_548228027aad4e18 )
{
    parent = function_1016d02ec576b8bf( var_548228027aad4e18 );
    
    if ( isdefined( parent ) )
    {
        if ( isdefined( parent.variant_object ) )
        {
            return parent.variant_object.rewardcacheassetname;
        }
        
        return parent.rewardcacheassetname;
    }
}

// Namespace namespace_548228027aad4e18
// Params 1
// Checksum 0x2e289009, Offset: 0x20c
// Size: 0x5a
function function_15f3f29887361cad( var_548228027aad4e18 )
{
    parent = function_1016d02ec576b8bf( var_548228027aad4e18 );
    
    if ( isdefined( parent ) )
    {
        if ( isdefined( parent.variant_object ) )
        {
            return parent.variant_object.var_4b2c3f9949122eea;
        }
        
        return parent.var_4b2c3f9949122eea;
    }
}

// Namespace namespace_548228027aad4e18
// Params 1
// Checksum 0x9e28a2d5, Offset: 0x26f
// Size: 0x5a
function function_21cd9567e49d3263( var_548228027aad4e18 )
{
    parent = function_de0d087d486b0aad( var_548228027aad4e18 );
    
    if ( isdefined( parent ) )
    {
        if ( isdefined( parent.variant_object ) )
        {
            return parent.variant_object.perplayerloot;
        }
        
        return parent.perplayerloot;
    }
}

// Namespace namespace_548228027aad4e18
// Params 1
// Checksum 0x155f2e1e, Offset: 0x2d2
// Size: 0x5a
function function_834a856f1f56abad( var_548228027aad4e18 )
{
    parent = function_cb8127f1a981fbfd( var_548228027aad4e18 );
    
    if ( isdefined( parent ) )
    {
        if ( isdefined( parent.variant_object ) )
        {
            return parent.variant_object.rewardgrouptype;
        }
        
        return parent.rewardgrouptype;
    }
}

// Namespace namespace_548228027aad4e18
// Params 1
// Checksum 0x1ab3eff1, Offset: 0x335
// Size: 0x5a
function function_9355d86d3e5d7b2( var_548228027aad4e18 )
{
    parent = function_e82d6313fc6d644a( var_548228027aad4e18 );
    
    if ( isdefined( parent ) )
    {
        if ( isdefined( parent.variant_object ) )
        {
            return parent.variant_object.rewardspawnlocationtype;
        }
        
        return parent.rewardspawnlocationtype;
    }
}

// Namespace namespace_548228027aad4e18
// Params 1
// Checksum 0x606a09d2, Offset: 0x398
// Size: 0x5a
function function_cd1c6dd1f011d236( var_548228027aad4e18 )
{
    parent = function_bd138940db55c1ed( var_548228027aad4e18 );
    
    if ( isdefined( parent ) )
    {
        if ( isdefined( parent.variant_object ) )
        {
            return parent.variant_object.activationname;
        }
        
        return parent.activationname;
    }
}

// Namespace namespace_548228027aad4e18
// Params 1
// Checksum 0x3f7b61b4, Offset: 0x3fb
// Size: 0x5a
function function_d94eefd0faaae460( var_548228027aad4e18 )
{
    parent = function_bd138940db55c1ed( var_548228027aad4e18 );
    
    if ( isdefined( parent ) )
    {
        if ( isdefined( parent.variant_object ) )
        {
            return parent.variant_object.activitymoment;
        }
        
        return parent.activitymoment;
    }
}

// Namespace namespace_548228027aad4e18
// Params 1, eflags: 0x4
// Checksum 0xaf6df0c3, Offset: 0x45e
// Size: 0xe
function private function_1016d02ec576b8bf( var_548228027aad4e18 )
{
    return var_548228027aad4e18;
}

// Namespace namespace_548228027aad4e18
// Params 1, eflags: 0x4
// Checksum 0x25b01e1f, Offset: 0x475
// Size: 0x5a
function private function_de0d087d486b0aad( var_548228027aad4e18 )
{
    parent = function_1016d02ec576b8bf( var_548228027aad4e18 );
    
    if ( isdefined( parent ) )
    {
        if ( isdefined( parent.variant_object ) )
        {
            return parent.variant_object.rewardgroupoptions;
        }
        
        return parent.rewardgroupoptions;
    }
}

// Namespace namespace_548228027aad4e18
// Params 1, eflags: 0x4
// Checksum 0x8b98487f, Offset: 0x4d8
// Size: 0x5a
function private function_cb8127f1a981fbfd( var_548228027aad4e18 )
{
    parent = function_de0d087d486b0aad( var_548228027aad4e18 );
    
    if ( isdefined( parent ) )
    {
        if ( isdefined( parent.variant_object ) )
        {
            return parent.variant_object.rewardgroupselection;
        }
        
        return parent.rewardgroupselection;
    }
}

// Namespace namespace_548228027aad4e18
// Params 1, eflags: 0x4
// Checksum 0x7114145, Offset: 0x53b
// Size: 0x5a
function private function_a33596e61444779b( var_548228027aad4e18 )
{
    parent = function_1016d02ec576b8bf( var_548228027aad4e18 );
    
    if ( isdefined( parent ) )
    {
        if ( isdefined( parent.variant_object ) )
        {
            return parent.variant_object.spawnlocationoptions;
        }
        
        return parent.spawnlocationoptions;
    }
}

// Namespace namespace_548228027aad4e18
// Params 1, eflags: 0x4
// Checksum 0x74935812, Offset: 0x59e
// Size: 0x5a
function private function_e82d6313fc6d644a( var_548228027aad4e18 )
{
    parent = function_a33596e61444779b( var_548228027aad4e18 );
    
    if ( isdefined( parent ) )
    {
        if ( isdefined( parent.variant_object ) )
        {
            return parent.variant_object.rewardspawnlocation;
        }
        
        return parent.rewardspawnlocation;
    }
}

// Namespace namespace_548228027aad4e18
// Params 1, eflags: 0x4
// Checksum 0x6407b4ad, Offset: 0x601
// Size: 0x5a
function private function_d8aaf7a9a511f96( var_548228027aad4e18 )
{
    parent = function_1016d02ec576b8bf( var_548228027aad4e18 );
    
    if ( isdefined( parent ) )
    {
        if ( isdefined( parent.variant_object ) )
        {
            return parent.variant_object.spawnoptions;
        }
        
        return parent.spawnoptions;
    }
}

// Namespace namespace_548228027aad4e18
// Params 1, eflags: 0x4
// Checksum 0xa8013b26, Offset: 0x664
// Size: 0x5a
function private function_bd138940db55c1ed( var_548228027aad4e18 )
{
    parent = function_d8aaf7a9a511f96( var_548228027aad4e18 );
    
    if ( isdefined( parent ) )
    {
        if ( isdefined( parent.variant_object ) )
        {
            return parent.variant_object.spawnactivitymoment;
        }
        
        return parent.spawnactivitymoment;
    }
}

