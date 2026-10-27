// scripts\common\player_broadcasting.gsc  (hash_2290ad4ac6031e33.gscc) (size: 6294 Bytes / 0x1896 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x81a309f6 (2174945782)
// size ...... 6294 (0x1896)
// includes .. 2   (offset: 0x1792)
// strings ... 0   (offset: 0x17a2)
// dev strs .. 20  (offset: 0x17a2)
// exports ... 38  (offset: 0xd6e)
// cseg ...... 0x58 + 0xd16 (0xd6e)
// imports ... 34  (offset: 0x135e)
// animtree1 . 0   (offset: 0x1896)
// animtree2 . 0   (offset: 0x1896)
#using scripts\common\conditional_container;
#using scripts\common\utility;

#namespace player_broadcasting;

// Namespace player_broadcasting
// Params 0
// Checksum 0x60e333c3, Offset: 0x76
// Size: 0x18
function function_7fc000126b792810()
{
    if ( !isdefined( level.var_f8e918ef76c136a9 ) )
    {
        level.var_f8e918ef76c136a9 = [];
    }
}

// Namespace player_broadcasting
// Params 2
// Checksum 0x46b10f79, Offset: 0x96
// Size: 0x39
function function_f5e10214f3edd9df( broadcasttype, handofffunction )
{
    if ( !isdefined( level.var_f8e918ef76c136a9 ) )
    {
        level.var_f8e918ef76c136a9 = [];
    }
    
    level.var_f8e918ef76c136a9[ broadcasttype ] = handofffunction;
}

// Namespace player_broadcasting
// Params 2
// Checksum 0xc06276e4, Offset: 0xd7
// Size: 0x149
function broadcasttoplayer( player, broadcastinstance )
{
    if ( utility::issharedfuncdefined( #"player", #"hash_d4410b0e9a24e367" ) && utility::callsharedfunc( #"player", #"hash_d4410b0e9a24e367", player ) )
    {
        /#
            function_87e2cc6f2f74da48( player, broadcastinstance, 0, "<dev string:x24>" );
        #/
        
        return;
    }
    
    var_bdb4012cb2da2dc3 = function_4ece54fb7c7912f( player, broadcastinstance );
    
    if ( !var_bdb4012cb2da2dc3 )
    {
        var_46c713cae9b1e8a0 = spawnstruct();
        var_46c713cae9b1e8a0.player = player;
        var_46c713cae9b1e8a0.broadcastinstance = broadcastinstance;
        var_367fbf2bb993acaa = broadcastinstance function_b68aa0e52a945be2();
        playermetbroadcastconditionsfunc = utility::getsharedfunc( #"player_broadcasting", #"playermetbroadcastconditions" );
        
        if ( !isdefined( playermetbroadcastconditionsfunc ) )
        {
            playermetbroadcastconditionsfunc = &function_eff64a64542bd3a1;
        }
        
        if ( var_367fbf2bb993acaa > 0 )
        {
            conditional_container::function_d3aa02b26606173a( broadcastinstance, player, playermetbroadcastconditionsfunc, var_46c713cae9b1e8a0, var_367fbf2bb993acaa );
        }
        else
        {
            var_da379b72cb25f425 = conditional_container::function_33051347e9187361( broadcastinstance, player );
            
            if ( var_da379b72cb25f425 )
            {
                [[ playermetbroadcastconditionsfunc ]]( var_46c713cae9b1e8a0 );
            }
            else
            {
                /#
                    function_87e2cc6f2f74da48( player, broadcastinstance, 0, "<dev string:x6d>" );
                #/
            }
        }
        
        return;
    }
    
    /#
        function_87e2cc6f2f74da48( player, broadcastinstance, 0, "<dev string:xac>" );
    #/
}

// Namespace player_broadcasting
// Params 2
// Checksum 0x43170fe0, Offset: 0x228
// Size: 0x88
function broadcasttoplayers( playerlist, broadcastinstance )
{
    foreach ( player in playerlist )
    {
        broadcasttoplayer( player, broadcastinstance );
    }
}

// Namespace player_broadcasting
// Params 2
// Checksum 0x67cf1c1, Offset: 0x2b8
// Size: 0x88
function function_5e1c0f6552045c72( player, broadcastinstancearray )
{
    foreach ( broadcastinstance in broadcastinstancearray )
    {
        broadcasttoplayer( player, broadcastinstance );
    }
}

// Namespace player_broadcasting
// Params 1
// Checksum 0x1d4160d7, Offset: 0x348
// Size: 0x94
function updatebroadcast( broadcastinstance )
{
    foreach ( player in level.players )
    {
        if ( function_4ece54fb7c7912f( player, broadcastinstance ) )
        {
            handoffbroadcast( player, broadcastinstance, 1 );
        }
    }
}

// Namespace player_broadcasting
// Params 1
// Checksum 0x959af2d9, Offset: 0x3e4
// Size: 0x7e
function updatebroadcastarray( broadcastinstancearray )
{
    foreach ( broadcastinstance in broadcastinstancearray )
    {
        updatebroadcast( broadcastinstance );
    }
}

// Namespace player_broadcasting
// Params 2
// Checksum 0xd570fbb3, Offset: 0x46a
// Size: 0x4d
function function_222166eb4fa67ba9( player, broadcastinstance )
{
    if ( !function_4ece54fb7c7912f( player, broadcastinstance ) )
    {
        /#
            function_87e2cc6f2f74da48( player, broadcastinstance, 2, "<dev string:xd4>" );
        #/
        
        return;
    }
    
    function_2e666f244552bcb4( player, broadcastinstance );
    handoffbroadcast( player, broadcastinstance, 2 );
}

// Namespace player_broadcasting
// Params 2
// Checksum 0xc2ac2748, Offset: 0x4bf
// Size: 0x88
function function_c2b475946583f034( player, broadcastinstancearray )
{
    foreach ( broadcastinstance in broadcastinstancearray )
    {
        function_222166eb4fa67ba9( player, broadcastinstance );
    }
}

// Namespace player_broadcasting
// Params 1
// Checksum 0xa852528c, Offset: 0x54f
// Size: 0x94
function function_d5e0cfa5ea5a12f( broadcastinstance )
{
    foreach ( player in level.players )
    {
        if ( function_4ece54fb7c7912f( player, broadcastinstance ) )
        {
            handoffbroadcast( player, broadcastinstance, 2 );
        }
    }
}

// Namespace player_broadcasting
// Params 2
// Checksum 0x8ac92b7c, Offset: 0x5eb
// Size: 0x88
function function_b5f131802b22606e( playerlist, broadcastinstance )
{
    foreach ( player in playerlist )
    {
        function_222166eb4fa67ba9( player, broadcastinstance );
    }
}

// Namespace player_broadcasting
// Params 1
// Checksum 0x5568d78d, Offset: 0x67b
// Size: 0x1e
function function_da6c88178b7cb6af( broadcastinstance )
{
    broadcasttoplayers( level.players, broadcastinstance );
}

// Namespace player_broadcasting
// Params 3
// Checksum 0x2b495138, Offset: 0x6a1
// Size: 0xa5
function function_93dff9a4c6e9c3a( broadcastorigin, maxdistancefromorigin, broadcastinstance )
{
    foreach ( player in level.players )
    {
        if ( utility::playerwithindistance( player, broadcastorigin, maxdistancefromorigin ) )
        {
            broadcasttoplayer( player, broadcastinstance );
        }
    }
}

// Namespace player_broadcasting
// Params 1
// Checksum 0xb7325db, Offset: 0x74e
// Size: 0xce
function function_f13a82c402b6308f( broadcasttype )
{
    broadcastinstance = spawnstruct();
    broadcastinstance.var_7dfc6ab3a8ad954d = 0;
    broadcastinstance.broadcasttype = broadcasttype;
    broadcastinstance.broadcastdataobjects = [];
    broadcastinstance.associateddatatracker = undefined;
    broadcastinstance.var_5e8f325f1ff3f73 = 1;
    broadcastinstance.var_d09022230b7f1900 = 0;
    
    if ( !isdefined( level.broadcastuniqueid ) )
    {
        level.broadcastuniqueid = 0;
    }
    
    broadcastinstance.uniqueid = level.broadcastuniqueid;
    broadcastinstance.groupid = broadcastinstance.uniqueid;
    level.broadcastuniqueid++;
    broadcastinstance.var_1c8fa902eda73226 = [];
    broadcastinstance conditional_container::function_3c3be461141746c0();
    return broadcastinstance;
}

/#

    // Namespace player_broadcasting
    // Params 1
    // Checksum 0x5b41d206, Offset: 0x825
    // Size: 0x37, Type: dev
    function function_d3eceea51dcf4ad6( messagetext )
    {
        broadcastinstance = function_f13a82c402b6308f( "<dev string:x123>" );
        broadcastinstance.text = messagetext;
        return broadcastinstance;
    }

#/

// Namespace player_broadcasting
// Params 1
// Checksum 0x681f1056, Offset: 0x864
// Size: 0x18, Type: bool
function function_674ee71664c02724( broadcastinstance )
{
    return istrue( broadcastinstance.var_5e8f325f1ff3f73 );
}

// Namespace player_broadcasting
// Params 0
// Checksum 0x43750989, Offset: 0x885
// Size: 0xc, Type: bool
function function_5deff0a365af6523()
{
    return istrue( self.var_7dfc6ab3a8ad954d );
}

// Namespace player_broadcasting
// Params 0
// Checksum 0x73aea62f, Offset: 0x89a
// Size: 0xb
function function_d95fdf9867bbbdc3()
{
    return self.broadcastdataobjects;
}

// Namespace player_broadcasting
// Params 0
// Checksum 0xed921da4, Offset: 0x8ae
// Size: 0x22
function getbroadcasttype()
{
    assert( isdefined( self.broadcasttype ), "<dev string:x129>" );
    return self.broadcasttype;
}

// Namespace player_broadcasting
// Params 0
// Checksum 0x3e53763d, Offset: 0x8d9
// Size: 0xb
function getbroadcastuniqueid()
{
    return self.uniqueid;
}

// Namespace player_broadcasting
// Params 0
// Checksum 0x20a4421f, Offset: 0x8ed
// Size: 0xb
function function_4aba6bea906de8b9()
{
    return self.groupid;
}

// Namespace player_broadcasting
// Params 0
// Checksum 0x36c2aaae, Offset: 0x901
// Size: 0xb
function function_b68aa0e52a945be2()
{
    return self.var_d09022230b7f1900;
}

// Namespace player_broadcasting
// Params 0
// Checksum 0x1d7621d2, Offset: 0x915
// Size: 0xb
function function_a716cbac4f23f938()
{
    return self.associateddatatracker;
}

// Namespace player_broadcasting
// Params 1
// Checksum 0xb1bc0a5, Offset: 0x929
// Size: 0x17
function function_e4c57927206b93fc( datatracker )
{
    self.associateddatatracker = datatracker;
}

// Namespace player_broadcasting
// Params 1
// Checksum 0xd177ddff, Offset: 0x948
// Size: 0x17
function function_2f5e3169b01237e8( var_367fbf2bb993acaa )
{
    self.var_d09022230b7f1900 = var_367fbf2bb993acaa;
}

// Namespace player_broadcasting
// Params 2
// Checksum 0x7f7ff228, Offset: 0x967
// Size: 0x56, Type: bool
function function_4ece54fb7c7912f( player, broadcastinstance )
{
    playerguid = utility::callsharedfunc( #"player", #"getPlayerGuid", player );
    playerseen = broadcastinstance.var_1c8fa902eda73226[ playerguid ];
    return istrue( playerseen );
}

// Namespace player_broadcasting
// Params 3
// Checksum 0x1e33de67, Offset: 0x9c6
// Size: 0x9a
function handoffbroadcast( player, broadcastinstance, broadcastcommand )
{
    if ( !isdefined( player ) )
    {
        assertmsg( "<dev string:x194>" + broadcastinstance getbroadcastuniqueid() + "<dev string:x1f6>" + broadcastcommand );
        return;
    }
    
    broadcasttype = broadcastinstance getbroadcasttype();
    
    if ( isdefined( broadcasttype ) )
    {
        assert( isdefined( level.var_f8e918ef76c136a9[ broadcasttype ] ), "<dev string:x207>" );
        [[ level.var_f8e918ef76c136a9[ broadcasttype ] ]]( player, broadcastinstance, broadcastcommand );
        
        /#
            function_b645e83b85464724( player, broadcastinstance, broadcastcommand );
        #/
    }
}

// Namespace player_broadcasting
// Params 2
// Checksum 0x22b88702, Offset: 0xa68
// Size: 0x4c
function function_b4619f9972ef2377( player, broadcastinstance )
{
    playerguid = utility::callsharedfunc( #"player", #"getPlayerGuid", player );
    broadcastinstance.var_1c8fa902eda73226[ playerguid ] = 1;
}

// Namespace player_broadcasting
// Params 1, eflags: 0x4
// Checksum 0xa3f3d950, Offset: 0xabc
// Size: 0x4d
function private function_eff64a64542bd3a1( var_46c713cae9b1e8a0 )
{
    player = var_46c713cae9b1e8a0.player;
    broadcastinstance = var_46c713cae9b1e8a0.broadcastinstance;
    function_b4619f9972ef2377( player, broadcastinstance );
    handoffbroadcast( player, broadcastinstance, 0 );
}

// Namespace player_broadcasting
// Params 2, eflags: 0x4
// Checksum 0xa9da0a41, Offset: 0xb11
// Size: 0x4b
function private function_2e666f244552bcb4( player, broadcastinstance )
{
    playerguid = utility::callsharedfunc( #"player", #"getPlayerGuid", player );
    broadcastinstance.var_1c8fa902eda73226[ playerguid ] = 0;
}

// Namespace player_broadcasting
// Params 2, eflags: 0x4
// Checksum 0xad0de06e, Offset: 0xb64
// Size: 0x17, Type: bool
function private function_1f5f8cd87c51e2dc( player, params )
{
    return true;
}

/#

    // Namespace player_broadcasting
    // Params 1
    // Checksum 0xb03cacd, Offset: 0xb84
    // Size: 0x3b, Type: dev
    function function_65c80123b8a2c99a( broadcastinstance )
    {
        generalbroadcastinstance = "<dev string:x25b>" + broadcastinstance getbroadcasttype() + "<dev string:x26e>" + broadcastinstance getbroadcastuniqueid();
        return generalbroadcastinstance;
    }

    // Namespace player_broadcasting
    // Params 0, eflags: 0x4
    // Checksum 0x78d15e57, Offset: 0xbc7
    // Size: 0x24, Type: dev
    function private function_c12ad90fba760849()
    {
        enableddvar = getdvarint( @"hash_26b7e4a2ecc0df79", 0 );
        return enableddvar != 0;
    }

    // Namespace player_broadcasting
    // Params 3, eflags: 0x4
    // Checksum 0x351b8cc9, Offset: 0xbf3
    // Size: 0x7e, Type: dev
    function private function_b645e83b85464724( player, broadcastinstance, broadcastcommand )
    {
        if ( !function_c12ad90fba760849() )
        {
            return;
        }
        
        playerguid = utility::callsharedfunc( #"player", #"getPlayerGuid", player );
        iprintln( function_2614d431a8f72fa7() + "<dev string:x27b>" + "<dev string:x290>" + playerguid + function_65c80123b8a2c99a( broadcastinstance ) + function_5e690b595c8692f3( broadcastcommand ) );
    }

    // Namespace player_broadcasting
    // Params 4, eflags: 0x4
    // Checksum 0x1b43b9, Offset: 0xc79
    // Size: 0x90, Type: dev
    function private function_87e2cc6f2f74da48( player, broadcastinstance, broadcastcommand, details )
    {
        if ( !function_c12ad90fba760849() )
        {
            return;
        }
        
        playerguid = utility::callsharedfunc( #"player", #"getPlayerGuid", player );
        iprintln( function_2614d431a8f72fa7() + "<dev string:x29a>" + "<dev string:x290>" + playerguid + function_65c80123b8a2c99a( broadcastinstance ) + function_5e690b595c8692f3( broadcastcommand ) + "<dev string:x2b6>" + details );
    }

    // Namespace player_broadcasting
    // Params 1, eflags: 0x4
    // Checksum 0x896f5b52, Offset: 0xd11
    // Size: 0x4a, Type: dev
    function private function_5e690b595c8692f3( broadcastcommand )
    {
        commandstring = "<dev string:x2c1>";
        
        if ( broadcastcommand == 1 )
        {
            commandstring = "<dev string:x2c5>";
        }
        else if ( broadcastcommand == 2 )
        {
            commandstring = "<dev string:x2cc>";
        }
        
        return "<dev string:x2d3>" + commandstring;
    }

    // Namespace player_broadcasting
    // Params 0, eflags: 0x4
    // Checksum 0x1f42518a, Offset: 0xd63
    // Size: 0xb, Type: dev
    function private function_2614d431a8f72fa7()
    {
        return "<dev string:x2e3>";
    }

#/
