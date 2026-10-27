// script_570f992e202c79b4  (hash_570f992e202c79b4.gscc) (size: 2522 Bytes / 0x9da / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd611ab1c (3591482140)
// size ...... 2522 (0x9da)
// includes .. 1   (offset: 0x942)
// strings ... 0   (offset: 0x94a)
// dev strs .. 11  (offset: 0x94a)
// exports ... 13  (offset: 0x4d6)
// cseg ...... 0x58 + 0x47e (0x4d6)
// imports ... 20  (offset: 0x6de)
// animtree1 . 0   (offset: 0x9da)
// animtree2 . 0   (offset: 0x9da)
#using scripts\common\linked_list;

#namespace namespace_4d597cbac7f48986;

// Namespace namespace_4d597cbac7f48986
// Params 1
// Checksum 0x580d4c5e, Offset: 0x76
// Size: 0x6a
function function_57d71970ad2eab25( cachesize )
{
    assert( cachesize > 0, "<dev string:x24>" );
    var_458c0d30de34938f = spawnstruct();
    var_458c0d30de34938f.cachesize = cachesize;
    var_458c0d30de34938f.var_dd8b1141a1e516d3 = linked_list::createstruct_linkedlist();
    var_458c0d30de34938f.datamap = [];
    var_458c0d30de34938f.var_f43722fe557294cf = 1;
    return var_458c0d30de34938f;
}

// Namespace namespace_4d597cbac7f48986
// Params 1
// Checksum 0xbe269212, Offset: 0xe9
// Size: 0x24, Type: bool
function function_f43722fe557294cf( var_8d3df9b53a3abd70 )
{
    return isstruct( var_8d3df9b53a3abd70 ) && var_8d3df9b53a3abd70.var_f43722fe557294cf == 1;
}

// Namespace namespace_4d597cbac7f48986
// Params 2
// Checksum 0xed5a587d, Offset: 0x116
// Size: 0x178
function addtocache( datakey, datacontents )
{
    assert( function_f43722fe557294cf( self ), "<dev string:x51>" );
    var_458c0d30de34938f = self;
    
    if ( isdefined( var_458c0d30de34938f.datamap[ datakey ] ) )
    {
        linkedlistnode = var_458c0d30de34938f.datamap[ datakey ];
        var_458c0d30de34938f.var_dd8b1141a1e516d3 linked_list::movenodetostart( linkedlistnode );
        return;
    }
    
    linkedlistnode = linked_list::createstruct_linkedlistnode();
    linkedlistnode.contents = datacontents;
    linkedlistnode.datakey = datakey;
    var_458c0d30de34938f.datamap[ datakey ] = linkedlistnode;
    var_458c0d30de34938f.var_dd8b1141a1e516d3 linked_list::addnodestart( linkedlistnode );
    
    /#
        if ( var_458c0d30de34938f function_4d16757981e669f4() )
        {
            function_251e8cb807aea1b9( "<dev string:xa2>" + datakey + "<dev string:xcf>" );
        }
    #/
    
    if ( var_458c0d30de34938f.var_dd8b1141a1e516d3 linked_list::getsize() > var_458c0d30de34938f.cachesize )
    {
        var_eba42617ae8aba56 = var_458c0d30de34938f.var_dd8b1141a1e516d3 linked_list::getendnode();
        var_458c0d30de34938f removefromcache( var_eba42617ae8aba56.datakey );
        
        /#
            if ( var_458c0d30de34938f function_4d16757981e669f4() )
            {
                function_251e8cb807aea1b9( "<dev string:xd1>" + var_458c0d30de34938f.cachesize + "<dev string:xfb>" + datakey + "<dev string:x123>" + var_eba42617ae8aba56.datakey + "<dev string:x150>" );
            }
        #/
    }
}

// Namespace namespace_4d597cbac7f48986
// Params 1
// Checksum 0x58d1136b, Offset: 0x296
// Size: 0x84
function removefromcache( datakey )
{
    assert( function_f43722fe557294cf( self ), "<dev string:x51>" );
    var_458c0d30de34938f = self;
    
    if ( isdefined( var_458c0d30de34938f.datamap[ datakey ] ) )
    {
        linkedlistnode = var_458c0d30de34938f.datamap[ datakey ];
        var_458c0d30de34938f.var_dd8b1141a1e516d3 linked_list::removenode( linkedlistnode );
        linkedlistnode.contents = undefined;
        var_458c0d30de34938f.datamap[ datakey ] = undefined;
    }
}

// Namespace namespace_4d597cbac7f48986
// Params 1
// Checksum 0x7476ba4d, Offset: 0x322
// Size: 0x77
function function_5c0524b11019fac5( datakey )
{
    assert( function_f43722fe557294cf( self ), "<dev string:x51>" );
    var_458c0d30de34938f = self;
    
    if ( isdefined( var_458c0d30de34938f.datamap[ datakey ] ) )
    {
        linkedlistnode = var_458c0d30de34938f.datamap[ datakey ];
        var_458c0d30de34938f.var_dd8b1141a1e516d3 linked_list::movenodetostart( linkedlistnode );
        return linkedlistnode.contents;
    }
}

/#

    // Namespace namespace_4d597cbac7f48986
    // Params 0
    // Checksum 0x90c1d7de, Offset: 0x3a2
    // Size: 0x5, Type: dev
    function function_641ea609de23cf1f()
    {
        
    }

    // Namespace namespace_4d597cbac7f48986
    // Params 0
    // Checksum 0x274fb95c, Offset: 0x3af
    // Size: 0x23, Type: dev
    function function_b76b98ba581008cd()
    {
        var_bb8eb3b4eb117c14 = function_57d71970ad2eab25();
        var_bb8eb3b4eb117c14 function_f06e1066c157cc84();
        return var_bb8eb3b4eb117c14;
    }

    // Namespace namespace_4d597cbac7f48986
    // Params 1
    // Checksum 0x98388dd8, Offset: 0x3da
    // Size: 0x5a, Type: dev
    function function_f06e1066c157cc84( var_4ad65b54acfaefa1 )
    {
        assert( function_f43722fe557294cf( self ), "<dev string:x51>" );
        var_bb8eb3b4eb117c14 = self;
        var_bb8eb3b4eb117c14.var_d2af92eb129017e7 = 1;
        
        if ( var_4ad65b54acfaefa1 )
        {
            var_bb8eb3b4eb117c14.var_dd8b1141a1e516d3 linked_list::function_9c89bbdf0877adac( &function_4a6956680d941e07 );
        }
    }

    // Namespace namespace_4d597cbac7f48986
    // Params 0, eflags: 0x4
    // Checksum 0x141c0f7, Offset: 0x43c
    // Size: 0x33, Type: dev
    function private function_4d16757981e669f4()
    {
        assert( function_f43722fe557294cf( self ), "<dev string:x161>" );
        var_458c0d30de34938f = self;
        return istrue( var_458c0d30de34938f.var_d2af92eb129017e7 );
    }

    // Namespace namespace_4d597cbac7f48986
    // Params 1, eflags: 0x4
    // Checksum 0x63967124, Offset: 0x477
    // Size: 0x27, Type: dev
    function private function_4a6956680d941e07( nodereference )
    {
        function_251e8cb807aea1b9( "<dev string:x1bc>" + nodereference.datakey );
    }

    // Namespace namespace_4d597cbac7f48986
    // Params 0, eflags: 0x4
    // Checksum 0x957c41e, Offset: 0x4a6
    // Size: 0xb, Type: dev
    function private function_be995d408c090a9d()
    {
        return "<dev string:x1c7>";
    }

    // Namespace namespace_4d597cbac7f48986
    // Params 1, eflags: 0x4
    // Checksum 0x4bfd68f9, Offset: 0x4b9
    // Size: 0x1d, Type: dev
    function private function_251e8cb807aea1b9( var_ec97aea8c57cd6ca )
    {
        iprintln( function_be995d408c090a9d() + var_ec97aea8c57cd6ca );
    }

#/
