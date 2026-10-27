// scripts\common\linked_list.gsc  (hash_6ebd0d5f9b30a55a.gscc) (size: 6516 Bytes / 0x1974 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6412f2cb (1678963403)
// size ...... 6516 (0x1974)
// includes .. 0   (offset: 0x1834)
// strings ... 0   (offset: 0x1834)
// dev strs .. 21  (offset: 0x1834)
// exports ... 27  (offset: 0x1044)
// cseg ...... 0x58 + 0xfec (0x1044)
// imports ... 20  (offset: 0x147c)
// animtree1 . 0   (offset: 0x1974)
// animtree2 . 0   (offset: 0x1974)
#namespace linked_list;

// Namespace linked_list
// Params 0
// Checksum 0xb061b2e7, Offset: 0x76
// Size: 0x1d
function createstruct_linkedlist()
{
    linkedlist = spawnstruct();
    linkedlist function_9908785e958dc8a6();
    return linkedlist;
}

// Namespace linked_list
// Params 0
// Checksum 0x9d3148d7, Offset: 0x9c
// Size: 0x9e
function function_9908785e958dc8a6()
{
    var_1c5feb02cc3efe03 = self;
    assert( isstruct( var_1c5feb02cc3efe03 ), "<dev string:x24>" );
    assert( !islinkedlist( var_1c5feb02cc3efe03 ), "<dev string:x61>" );
    var_1c5feb02cc3efe03.startnode = undefined;
    var_1c5feb02cc3efe03.endnode = undefined;
    var_1c5feb02cc3efe03.nodecount = 0;
    
    /#
        level.listid = level.listid ?? 0;
        var_1c5feb02cc3efe03.var_232df2e3f4018786 = level.listid;
        level.listid += 1;
    #/
}

// Namespace linked_list
// Params 0
// Checksum 0x1764339d, Offset: 0x142
// Size: 0xa9
function function_b7f0ddd6cba5ef53()
{
    assert( islinkedlist( self ), "<dev string:xad>" );
    linkedlist = self;
    
    for ( currentnode = linkedlist.startnode; isdefined( currentnode ) ; currentnode = nextnode )
    {
        nextnode = currentnode.nextnode;
        currentnode.prevnode = undefined;
        currentnode.nextnode = undefined;
    }
    
    linkedlist.startnode = undefined;
    linkedlist.endnode = undefined;
    
    /#
        if ( linkedlist function_4d16757981e669f4() )
        {
            function_b8044fdd64444e57( "<dev string:x108>" );
            linkedlist function_d4adc16795851750();
        }
    #/
}

// Namespace linked_list
// Params 1
// Checksum 0x2bdf813e, Offset: 0x1f3
// Size: 0x26
function islinkedlist( possiblelinkedlist )
{
    /#
        return isstruct( possiblelinkedlist ) && isdefined( possiblelinkedlist.var_232df2e3f4018786 );
    #/
}

// Namespace linked_list
// Params 0
// Checksum 0x82f99a9, Offset: 0x221
// Size: 0x2a
function createstruct_linkedlistnode()
{
    node = spawnstruct();
    node.nextnode = undefined;
    node.prevnode = undefined;
    return node;
}

// Namespace linked_list
// Params 1
// Checksum 0xfa2dde48, Offset: 0x254
// Size: 0x132
function addnode( newnode )
{
    linkedlist = self;
    
    /#
        assert( islinkedlist( linkedlist ), "<dev string:xad>" );
        assert( !isdefined( newnode.var_456c8dcee90ec96 ) );
        assert( !isdefined( newnode.prev ) );
        assert( !isdefined( newnode.next ) );
        newnode.var_456c8dcee90ec96 = linkedlist.var_232df2e3f4018786;
    #/
    
    if ( linkedlist.nodecount == 0 )
    {
        linkedlist.startnode = newnode;
        linkedlist.endnode = newnode;
    }
    else
    {
        linkedlist.endnode.nextnode = newnode;
        newnode.prevnode = linkedlist.endnode;
        linkedlist.endnode = newnode;
    }
    
    linkedlist.nodecount += 1;
    
    /#
        if ( linkedlist function_4d16757981e669f4() )
        {
            function_b8044fdd64444e57( "<dev string:x11e>" );
            linkedlist function_d4adc16795851750();
        }
    #/
    
    return newnode;
}

// Namespace linked_list
// Params 1
// Checksum 0x4cdacccd, Offset: 0x38f
// Size: 0x132
function addnodestart( newnode )
{
    linkedlist = self;
    
    /#
        assert( islinkedlist( linkedlist ), "<dev string:xad>" );
        assert( !isdefined( newnode.var_456c8dcee90ec96 ) );
        assert( !isdefined( newnode.prev ) );
        assert( !isdefined( newnode.next ) );
        newnode.var_456c8dcee90ec96 = linkedlist.var_232df2e3f4018786;
    #/
    
    if ( linkedlist.nodecount == 0 )
    {
        linkedlist.startnode = newnode;
        linkedlist.endnode = newnode;
    }
    else
    {
        newnode.nextnode = linkedlist.startnode;
        linkedlist.startnode.prevnode = newnode;
        linkedlist.startnode = newnode;
    }
    
    linkedlist.nodecount += 1;
    
    /#
        if ( linkedlist function_4d16757981e669f4() )
        {
            function_b8044fdd64444e57( "<dev string:x129>" );
            linkedlist function_d4adc16795851750();
        }
    #/
    
    return newnode;
}

// Namespace linked_list
// Params 2
// Checksum 0x801b4b40, Offset: 0x4ca
// Size: 0x15c
function addnodeafter( newnode, afterthisnode )
{
    linkedlist = self;
    
    /#
        assert( islinkedlist( linkedlist ), "<dev string:xad>" );
        assert( !isdefined( newnode.var_456c8dcee90ec96 ) );
        assert( !isdefined( newnode.prev ) );
        assert( !isdefined( newnode.next ) );
        assert( isdefined( afterthisnode.var_456c8dcee90ec96 ) );
        assert( afterthisnode.var_456c8dcee90ec96 == linkedlist.var_232df2e3f4018786 );
        newnode.var_456c8dcee90ec96 = linkedlist.var_232df2e3f4018786;
    #/
    
    newnode.nextnode = afterthisnode.nextnode;
    newnode.prevnode = afterthisnode;
    afterthisnode.nextnode = newnode;
    
    if ( isdefined( newnode.nextnode ) )
    {
        newnode.nextnode.prevnode = newnode;
    }
    
    linkedlist.nodecount += 1;
    
    /#
        if ( linkedlist function_4d16757981e669f4() )
        {
            function_b8044fdd64444e57( "<dev string:x13a>" );
            linkedlist function_d4adc16795851750();
        }
    #/
    
    return newnode;
}

// Namespace linked_list
// Params 2
// Checksum 0x4e882c32, Offset: 0x62f
// Size: 0x14e
function addnodebefore( newnode, beforethisnode )
{
    linkedlist = self;
    
    /#
        assert( islinkedlist( linkedlist ), "<dev string:xad>" );
        assert( !isdefined( newnode.var_456c8dcee90ec96 ) );
        assert( !isdefined( newnode.prev ) );
        assert( !isdefined( newnode.next ) );
        assert( isdefined( beforethisnode.var_456c8dcee90ec96 ) );
        assert( beforethisnode.var_456c8dcee90ec96 == linkedlist.var_232df2e3f4018786 );
        newnode.var_456c8dcee90ec96 = linkedlist.var_232df2e3f4018786;
    #/
    
    newnode.nextnode = beforethisnode;
    newnode.prevnode = beforethisnode.prevnode;
    
    if ( isdefined( newnode.prevnode ) )
    {
        newnode.prevnode.nextnode = newnode;
    }
    
    linkedlist.nodecount += 1;
    
    /#
        if ( linkedlist function_4d16757981e669f4() )
        {
            function_b8044fdd64444e57( "<dev string:x14b>" );
            linkedlist function_d4adc16795851750();
        }
    #/
    
    return newnode;
}

// Namespace linked_list
// Params 1
// Checksum 0x669e459b, Offset: 0x786
// Size: 0x1a7
function removenode( nodetoremove )
{
    linkedlist = self;
    
    /#
        assert( islinkedlist( linkedlist ), "<dev string:xad>" );
        assert( isdefined( nodetoremove.var_456c8dcee90ec96 ) );
        assert( nodetoremove.var_456c8dcee90ec96 == linkedlist.var_232df2e3f4018786 );
    #/
    
    if ( !isdefined( nodetoremove.prevnode ) )
    {
        linkedlist.startnode = nodetoremove.nextnode;
        
        if ( isdefined( linkedlist.startnode ) )
        {
            linkedlist.startnode.prevnode = undefined;
        }
        else
        {
            linkedlist.endnode = undefined;
        }
    }
    else if ( !isdefined( nodetoremove.nextnode ) )
    {
        linkedlist.endnode = nodetoremove.prevnode;
        nodetoremove.prevnode.nextnode = undefined;
    }
    else
    {
        nodetoremove.prevnode.nextnode = nodetoremove.nextnode;
        nodetoremove.nextnode.prevnode = nodetoremove.prevnode;
    }
    
    nodetoremove.nextnode = undefined;
    nodetoremove.prevnode = undefined;
    
    /#
        nodetoremove.var_456c8dcee90ec96 = undefined;
    #/
    
    linkedlist.nodecount = max( linkedlist.nodecount - 1, 0 );
    
    /#
        if ( linkedlist function_4d16757981e669f4() )
        {
            function_b8044fdd64444e57( "<dev string:x15d>" );
            linkedlist function_d4adc16795851750();
        }
    #/
}

// Namespace linked_list
// Params 0
// Checksum 0xab36c037, Offset: 0x935
// Size: 0x120
function removestartnode()
{
    linkedlist = self;
    
    /#
        assert( islinkedlist( linkedlist ), "<dev string:xad>" );
        assert( isdefined( linkedlist.startnode.var_456c8dcee90ec96 ) );
        assert( linkedlist.startnode.var_456c8dcee90ec96 == linkedlist.var_232df2e3f4018786 );
    #/
    
    if ( isdefined( linkedlist.startnode ) && linkedlist.nodecount > 1 )
    {
        linkedlist.startnode = linkedlist.startnode.nextnode;
        linkedlist.startnode.prevnode = undefined;
    }
    else
    {
        linkedlist.startnode = undefined;
        linkedlist.endnode = undefined;
    }
    
    linkedlist.nodecount = max( linkedlist.nodecount - 1, 0 );
    
    /#
        if ( linkedlist function_4d16757981e669f4() )
        {
            function_b8044fdd64444e57( "<dev string:x15d>" );
            linkedlist function_d4adc16795851750();
        }
    #/
}

// Namespace linked_list
// Params 0
// Checksum 0x5a4a8c3c, Offset: 0xa5d
// Size: 0x120
function removeendnode()
{
    linkedlist = self;
    
    /#
        assert( islinkedlist( linkedlist ), "<dev string:xad>" );
        assert( isdefined( linkedlist.endnode.var_456c8dcee90ec96 ) );
        assert( linkedlist.endnode.var_456c8dcee90ec96 == linkedlist.var_232df2e3f4018786 );
    #/
    
    if ( isdefined( linkedlist.endnode ) && linkedlist.nodecount > 1 )
    {
        linkedlist.endnode = linkedlist.endnode.prevnode;
        linkedlist.endnode.nextnode = undefined;
    }
    else
    {
        linkedlist.startnode = undefined;
        linkedlist.endnode = undefined;
    }
    
    linkedlist.nodecount = max( linkedlist.nodecount - 1, 0 );
    
    /#
        if ( linkedlist function_4d16757981e669f4() )
        {
            function_b8044fdd64444e57( "<dev string:x15d>" );
            linkedlist function_d4adc16795851750();
        }
    #/
}

// Namespace linked_list
// Params 1
// Checksum 0xd25cd221, Offset: 0xb85
// Size: 0xad
function movenodetostart( nodetomove )
{
    linkedlist = self;
    
    /#
        assert( islinkedlist( linkedlist ), "<dev string:xad>" );
        assert( isdefined( nodetomove.var_456c8dcee90ec96 ) );
        assert( nodetomove.var_456c8dcee90ec96 == linkedlist.var_232df2e3f4018786 );
    #/
    
    if ( linkedlist.startnode == nodetomove )
    {
        return;
    }
    
    linkedlist removenode( nodetomove );
    linkedlist addnodestart( nodetomove );
    
    /#
        if ( linkedlist function_4d16757981e669f4() )
        {
            function_b8044fdd64444e57( "<dev string:x16a>" );
            linkedlist function_d4adc16795851750();
        }
    #/
}

// Namespace linked_list
// Params 0
// Checksum 0xc1062c4d, Offset: 0xc3a
// Size: 0x2f
function getsize()
{
    linkedlist = self;
    assert( islinkedlist( linkedlist ), "<dev string:xad>" );
    return linkedlist.nodecount;
}

// Namespace linked_list
// Params 0
// Checksum 0xd785c3c7, Offset: 0xc72
// Size: 0x79
function getstartnode()
{
    linkedlist = self;
    
    /#
        assert( islinkedlist( linkedlist ), "<dev string:xad>" );
        assert( isdefined( linkedlist.startnode.var_456c8dcee90ec96 ) );
        assert( linkedlist.startnode.var_456c8dcee90ec96 == linkedlist.var_232df2e3f4018786 );
    #/
    
    return linkedlist.startnode;
}

// Namespace linked_list
// Params 0
// Checksum 0xa1a11b8e, Offset: 0xcf4
// Size: 0x79
function getendnode()
{
    linkedlist = self;
    
    /#
        assert( islinkedlist( linkedlist ), "<dev string:xad>" );
        assert( isdefined( linkedlist.endnode.var_456c8dcee90ec96 ) );
        assert( linkedlist.endnode.var_456c8dcee90ec96 == linkedlist.var_232df2e3f4018786 );
    #/
    
    return linkedlist.endnode;
}

// Namespace linked_list
// Params 0
// Checksum 0x4bf8a6c, Offset: 0xd76
// Size: 0x1d
function getnextnode()
{
    assert( isdefined( self.var_456c8dcee90ec96 ) );
    return self.nextnode;
}

// Namespace linked_list
// Params 0
// Checksum 0x6919d349, Offset: 0xd9c
// Size: 0x17
function clearlinkedlist()
{
    while ( getsize() > 0 )
    {
        removeendnode();
    }
}

/#

    // Namespace linked_list
    // Params 0
    // Checksum 0xe05dfd44, Offset: 0xdbb
    // Size: 0x5, Type: dev
    function function_8dc8c452d8c0d5bd()
    {
        
    }

    // Namespace linked_list
    // Params 1
    // Checksum 0x21d21d2b, Offset: 0xdc8
    // Size: 0x2e, Type: dev
    function function_6bebcbe8164797b5( var_975ef523dfba96fb )
    {
        debuglinkedlist = createstruct_linkedlist();
        debuglinkedlist function_9c89bbdf0877adac( var_975ef523dfba96fb );
        return debuglinkedlist;
    }

    // Namespace linked_list
    // Params 1
    // Checksum 0x77a6fd62, Offset: 0xdfe
    // Size: 0x4c, Type: dev
    function function_9c89bbdf0877adac( var_975ef523dfba96fb )
    {
        assert( islinkedlist( self ), "<dev string:xad>" );
        debuglinkedlist = self;
        debuglinkedlist.var_d2af92eb129017e7 = 1;
        debuglinkedlist.var_975ef523dfba96fb = var_975ef523dfba96fb;
    }

    // Namespace linked_list
    // Params 1
    // Checksum 0x27de9694, Offset: 0xe52
    // Size: 0x13f, Type: dev
    function printlinkedlist( var_975ef523dfba96fb )
    {
        assert( islinkedlist( self ), "<dev string:xad>" );
        linkedlist = self;
        nodecount = 1;
        nodereference = linkedlist.startnode;
        function_b8044fdd64444e57( "<dev string:x18e>" );
        
        /#
            function_b8044fdd64444e57( "<dev string:x1ac>" + linkedlist.var_232df2e3f4018786 );
        #/
        
        function_b8044fdd64444e57( "<dev string:x1b6>" + linkedlist getsize() );
        
        if ( linkedlist.startnode )
        {
            function_b8044fdd64444e57( "<dev string:x1c2>" );
            [[ var_975ef523dfba96fb ]]( linkedlist.startnode );
        }
        else
        {
            function_b8044fdd64444e57( "<dev string:x1cf>" );
        }
        
        if ( linkedlist.endnode )
        {
            function_b8044fdd64444e57( "<dev string:x1e6>" );
            [[ var_975ef523dfba96fb ]]( linkedlist.endnode );
        }
        else
        {
            function_b8044fdd64444e57( "<dev string:x1f1>" );
        }
        
        while ( isdefined( nodereference ) )
        {
            function_b8044fdd64444e57( "<dev string:x206>" + nodecount + "<dev string:x219>" );
            [[ var_975ef523dfba96fb ]]( nodereference );
            nodereference = nodereference.nextnode;
            nodecount++;
        }
        
        function_b8044fdd64444e57( "<dev string:x21c>" );
    }

    // Namespace linked_list
    // Params 0, eflags: 0x4
    // Checksum 0xb8246eec, Offset: 0xf99
    // Size: 0x38, Type: dev
    function private function_d4adc16795851750()
    {
        assert( islinkedlist( self ), "<dev string:xad>" );
        debuglinkedlist = self;
        printlinkedlist( debuglinkedlist.var_975ef523dfba96fb );
    }

    // Namespace linked_list
    // Params 0, eflags: 0x4
    // Checksum 0xd5029120, Offset: 0xfd9
    // Size: 0x33, Type: dev
    function private function_4d16757981e669f4()
    {
        assert( islinkedlist( self ), "<dev string:xad>" );
        linkedlist = self;
        return istrue( linkedlist.var_d2af92eb129017e7 );
    }

    // Namespace linked_list
    // Params 0, eflags: 0x4
    // Checksum 0x1932baa0, Offset: 0x1014
    // Size: 0xb, Type: dev
    function private function_4d100b31849123dd()
    {
        return "<dev string:x238>";
    }

    // Namespace linked_list
    // Params 1, eflags: 0x4
    // Checksum 0xd49a8821, Offset: 0x1027
    // Size: 0x1d, Type: dev
    function private function_b8044fdd64444e57( var_ec97aea8c57cd6ca )
    {
        iprintln( function_4d100b31849123dd() + var_ec97aea8c57cd6ca );
    }

#/
