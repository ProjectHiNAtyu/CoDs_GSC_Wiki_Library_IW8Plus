// script_50d64da88d76cc49  (hash_50d64da88d76cc49.gscc) (size: 2958 Bytes / 0xb8e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc936b42f (3375805487)
// size ...... 2958 (0xb8e)
// includes .. 2   (offset: 0xace)
// strings ... 10  (offset: 0xade)
// dev strs .. 1   (offset: 0xb7a)
// exports ... 10  (offset: 0x706)
// cseg ...... 0x11f + 0x5e7 (0x706)
// imports ... 18  (offset: 0x896)
// animtree1 . 0   (offset: 0xb8e)
// animtree2 . 0   (offset: 0xb8e)
#using script_3f182ddb21e37fd3;
#using scripts\autotests\autotests;

#namespace namespace_3de4448935d84ec8;

// Namespace namespace_3de4448935d84ec8/testautomation
// Params 0, eflags: 0x20
// Checksum 0xbd5c5486, Offset: 0x13d
// Size: 0xb2
function event_handler[testautomation] main()
{
    namespace_3637061638c5e37a::function_6b8b68fa6ee6a023( "gettestparameters", &function_43ef8af194b1a64c, "autotest" );
    namespace_3637061638c5e37a::function_6b8b68fa6ee6a023( "settestassets", &function_71ae9ed6b8e5af69, "autotest" );
    namespace_3637061638c5e37a::function_6b8b68fa6ee6a023( "gettestassettypes", &function_322605c62b7c25fe, "autotest" );
    namespace_3637061638c5e37a::function_6b8b68fa6ee6a023( "gettestfeaturetargets", &function_fd56b556ec51765f, "autotest" );
    namespace_3637061638c5e37a::function_6b8b68fa6ee6a023( "getautotestsdebuginformation", &function_50310a626c81728, "autotest" );
    namespace_3637061638c5e37a::function_6b8b68fa6ee6a023( "getautotests", &get_registered_autotests, "autotest" );
    namespace_3637061638c5e37a::function_6b8b68fa6ee6a023( "getautotestslist", &function_275517a1259fb194, "autotest" );
    namespace_3637061638c5e37a::function_6b8b68fa6ee6a023( "getautotestslistcontent", &function_35e88f370a1d1456, "autotest" );
}

// Namespace namespace_3de4448935d84ec8
// Params 0, eflags: 0x4
// Checksum 0xa857b125, Offset: 0x1f7
// Size: 0x8d
function private function_50310a626c81728()
{
    res = spawnstruct();
    
    if ( isdefined( level.autotests ) )
    {
        if ( isdefined( level.autotests.var_299b18fe7755901b ) )
        {
            res.var_299b18fe7755901b = level.autotests.var_299b18fe7755901b;
        }
        
        if ( isdefined( level.autotests.stateisvalid ) )
        {
            res.stateisvalid = level.autotests.stateisvalid;
        }
    }
    
    return res;
}

// Namespace namespace_3de4448935d84ec8
// Params 0, eflags: 0x4
// Checksum 0xed2c746f, Offset: 0x28d
// Size: 0x118
function private get_registered_autotests()
{
    res = spawnstruct();
    
    if ( isdefined( level.autotests ) && isdefined( level.autotests.tests ) )
    {
        res.type = "hash";
        
        /#
            res.type = "<dev string:x24>";
        #/
        
        res.keys = [];
        
        foreach ( key, value in level.autotests.tests )
        {
            var_e7e1f07c9168e73d = getxhashhexname( key );
            
            /#
                var_e7e1f07c9168e73d = getxhashsourcename( key );
            #/
            
            res.keys[ res.keys.size ] = var_e7e1f07c9168e73d;
        }
    }
    
    return res;
}

// Namespace namespace_3de4448935d84ec8
// Params 0, eflags: 0x4
// Checksum 0x6461e658, Offset: 0x3ae
// Size: 0x118
function private function_275517a1259fb194()
{
    res = spawnstruct();
    
    if ( isdefined( level.autotests ) && isdefined( level.autotests.var_dc5c2d60123d0b4f ) )
    {
        res.type = "hash";
        
        /#
            res.type = "<dev string:x24>";
        #/
        
        res.keys = [];
        
        foreach ( key, value in level.autotests.var_dc5c2d60123d0b4f )
        {
            var_e7e1f07c9168e73d = getxhashhexname( key );
            
            /#
                var_e7e1f07c9168e73d = getxhashsourcename( key );
            #/
            
            res.keys[ res.keys.size ] = var_e7e1f07c9168e73d;
        }
    }
    
    return res;
}

// Namespace namespace_3de4448935d84ec8
// Params 1, eflags: 0x4
// Checksum 0xfe8799c6, Offset: 0x4cf
// Size: 0x19e
function private function_35e88f370a1d1456( params )
{
    res = spawnstruct();
    
    if ( isdefined( level.autotests ) && isdefined( level.autotests.var_dc5c2d60123d0b4f ) && isdefined( params.autotestlist ) )
    {
        var_f9bef20ec277ab43 = hashcat( %"hash_4ccbd4c240f98b31", params.autotestlist );
        
        if ( isdefined( level.autotests.var_dc5c2d60123d0b4f[ var_f9bef20ec277ab43 ] ) )
        {
            if ( isdefined( level.autotests.var_dc5c2d60123d0b4f[ var_f9bef20ec277ab43 ].autotest_list ) )
            {
                res.type = "hash";
                
                /#
                    res.type = "<dev string:x24>";
                #/
                
                res.keys = [];
                
                foreach ( key, value in level.autotests.var_dc5c2d60123d0b4f[ var_f9bef20ec277ab43 ].autotest_list )
                {
                    var_e7e1f07c9168e73d = getxhashhexname( key );
                    
                    /#
                        var_e7e1f07c9168e73d = getxhashsourcename( key );
                    #/
                    
                    res.keys[ res.keys.size ] = var_e7e1f07c9168e73d;
                }
            }
        }
    }
    
    return res;
}

// Namespace namespace_3de4448935d84ec8
// Params 1, eflags: 0x4
// Checksum 0x9ac24c8b, Offset: 0x676
// Size: 0x1d
function private function_43ef8af194b1a64c( data )
{
    return autotests::function_1676d5bbfb60ce82( data.parameter );
}

// Namespace namespace_3de4448935d84ec8
// Params 1, eflags: 0x4
// Checksum 0x5c1ecee, Offset: 0x69c
// Size: 0x1d
function private function_322605c62b7c25fe( data )
{
    return autotests::function_3b4985eec125f0ae( data.parameter );
}

// Namespace namespace_3de4448935d84ec8
// Params 1, eflags: 0x4
// Checksum 0xdcf1ca52, Offset: 0x6c2
// Size: 0x1d
function private function_fd56b556ec51765f( data )
{
    return autotests::function_61a59ea25ae0943( data.parameter );
}

// Namespace namespace_3de4448935d84ec8
// Params 1, eflags: 0x4
// Checksum 0x1b484ff8, Offset: 0x6e8
// Size: 0x1d
function private function_71ae9ed6b8e5af69( data )
{
    return autotests::set_test_assets( data.parameter );
}

