// scripts\common\activity_nexus\activity_player_broadcasting.gsc  (hash_569138730a0a130f.gscc) (size: 8590 Bytes / 0x218e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa9b05007 (2846904327)
// size ...... 8590 (0x218e)
// includes .. 14  (offset: 0x1ea6)
// strings ... 5   (offset: 0x1f16)
// dev strs .. 40  (offset: 0x1f62)
// exports ... 27  (offset: 0x13ea)
// cseg ...... 0xc3 + 0x1327 (0x13ea)
// imports ... 50  (offset: 0x1822)
// animtree1 . 0   (offset: 0x218e)
// animtree2 . 0   (offset: 0x218e)
#using script_4e1f1a7ef824ddd5;
#using script_570f992e202c79b4;
#using script_77873e194e406c6d;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_nexus_debug;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\activity_nexus\activity_player_common;
#using scripts\common\callbacks;
#using scripts\common\conditional_container;
#using scripts\common\data_tracker;
#using scripts\common\devgui;
#using scripts\common\player_broadcasting;

#namespace activity_player_broadcasting;

// Namespace activity_player_broadcasting
// Params 1
// Checksum 0x2e513702, Offset: 0xe1
// Size: 0x73
function function_6eb258f51ed07851( var_ca3f65fdba0a9ed2 )
{
    activitynexussettings = level.activities.activitynexussettings;
    var_ca3f65fdba0a9ed2.var_a4a513e0fe075256 = namespace_4d597cbac7f48986::function_57d71970ad2eab25( activitynexussettings.var_99893e3216463d57 );
    var_ca3f65fdba0a9ed2.var_a4fd71cdbb5546e5 = [];
    var_ca3f65fdba0a9ed2.var_a4fd71cdbb5546e5[ "TitleSplash" ] = "Delay";
    namespace_2aca03e533f9f843::function_7975ee848848e12a();
}

// Namespace activity_player_broadcasting
// Params 1
// Checksum 0x9751bcde, Offset: 0x15c
// Size: 0x117
function function_999f4d62e6798267( activityinstance )
{
    var_a953217975e7cf60 = activityinstance.var_2c769a213204c445;
    
    if ( !isdefined( var_a953217975e7cf60.var_1eaa249a063a0dba ) )
    {
        var_a953217975e7cf60.var_1eaa249a063a0dba = [];
    }
    
    var_f504771295c70965 = activity_definition_utils::function_4dbc827bb8b7e595( activityinstance );
    var_38c5026e3d88a5d = level.activities.activitymoments;
    var_38c5026e3d88a5d[ var_38c5026e3d88a5d.size ] = "ActivationName";
    
    foreach ( activitymoment in var_38c5026e3d88a5d )
    {
        var_149c29864caf2d81 = var_f504771295c70965.var_8b90311fda82dea4[ activitymoment ];
        
        if ( isdefined( var_149c29864caf2d81 ) && var_149c29864caf2d81.size > 0 )
        {
            var_a953217975e7cf60.var_1eaa249a063a0dba[ activitymoment ] = 1;
        }
    }
}

// Namespace activity_player_broadcasting
// Params 2
// Checksum 0xde3822c4, Offset: 0x27b
// Size: 0xc0
function function_a1894473756950fa( activityinstance, dataobject )
{
    uniquename = data_tracker::function_83a7663cb3e8d879( dataobject );
    
    if ( !isarray( self.activebroadcasts ) )
    {
        return;
    }
    
    foreach ( activebroadcastinstance in activityinstance.activebroadcasts )
    {
        if ( namespace_2aca03e533f9f843::function_554224fe208bff0b( activebroadcastinstance, uniquename ) )
        {
            player_broadcasting::updatebroadcast( activebroadcastinstance );
        }
    }
}

// Namespace activity_player_broadcasting
// Params 1
// Checksum 0x2c0a4e8a, Offset: 0x343
// Size: 0xcc
function function_400c462d24b8f61( playerlist )
{
    /#
        namespace_634561435cfb3169::activitynexuslog( "<dev string:x24>", @"hash_3b38e79d9ffe7e9f", self, playerlist );
    #/
    
    if ( !isarray( self.activebroadcasts ) )
    {
        return;
    }
    
    foreach ( broadcast in self.activebroadcasts )
    {
        if ( istrue( broadcast.broadcastdefinition.var_8efdce03c52f7421 ) )
        {
            player_broadcasting::broadcasttoplayers( playerlist, broadcast );
        }
    }
}

// Namespace activity_player_broadcasting
// Params 2
// Checksum 0x300162bc, Offset: 0x417
// Size: 0x29
function function_aecad054257dd057( activityinstance, broadcastinstance )
{
    player_broadcasting::broadcasttoplayers( activityinstance.playerparticipants, broadcastinstance );
}

// Namespace activity_player_broadcasting
// Params 2
// Checksum 0x6d4e0682, Offset: 0x448
// Size: 0x167
function broadcast( broadcastinstance, playerlist )
{
    activityinstance = self;
    
    /#
        namespace_634561435cfb3169::activitynexuslog( "<dev string:x5f>" + function_1c4eb71627ffe619( broadcastinstance ), @"hash_3b38e79d9ffe7e9f", activityinstance, playerlist );
    #/
    
    switch ( broadcastinstance.broadcastdefinition.destination ?? "Instance" )
    {
        case #"hash_f29608411835dbd2":
            function_aecad054257dd057( activityinstance, broadcastinstance );
            break;
        case #"hash_fad3c75d039713f1":
            var_35112ac57a104d8a = activity_player_common::function_44ef43ff1f6d21d4( playerlist[ 0 ] );
            player_broadcasting::broadcasttoplayers( var_35112ac57a104d8a, broadcastinstance );
            break;
        case #"hash_f81f6f6ee4ce49a2":
            centerpoint = activity_instance_common::function_776ee11e7acc64a5( activityinstance );
            var_1da1177b9a39fc14 = namespace_2aca03e533f9f843::function_17903639bb0d3288( broadcastinstance );
            player_broadcasting::broadcasttoplayers( var_1da1177b9a39fc14, broadcastinstance );
            break;
        case #"hash_edac25dbcb316612":
            player_broadcasting::function_da6c88178b7cb6af( broadcastinstance );
            break;
        case #"hash_ce0097f935cd75a8":
        default:
            player_broadcasting::broadcasttoplayers( playerlist, broadcastinstance );
            break;
    }
    
    if ( istrue( broadcastinstance.broadcastdefinition.var_8efdce03c52f7421 ) || istrue( broadcastinstance.broadcastdefinition.hasdynamicdata ) )
    {
        function_41d410d801bd31f7( broadcastinstance, activityinstance );
    }
}

// Namespace activity_player_broadcasting
// Params 2
// Checksum 0xbe8b673e, Offset: 0x5b7
// Size: 0xef
function function_849396805a2d9d98( activationmoment, playerlist )
{
    activityinstance = self;
    
    /#
        namespace_634561435cfb3169::activitynexuslog( "<dev string:x82>" + activationmoment, @"hash_3b38e79d9ffe7e9f", activityinstance, playerlist );
    #/
    
    if ( activationmoment == "ActivationName" )
    {
        assertmsg( "<dev string:xb4>" );
        return;
    }
    
    broadcastinstancestructs = namespace_2aca03e533f9f843::function_c710a41fae98cbec( activationmoment, activityinstance );
    
    foreach ( broadcastinstance in broadcastinstancestructs )
    {
        if ( !isdefined( playerlist ) )
        {
            playerlist = activityinstance.playerparticipants;
        }
        
        broadcast( broadcastinstance, playerlist );
    }
}

// Namespace activity_player_broadcasting
// Params 2
// Checksum 0x6321a34e, Offset: 0x6ae
// Size: 0x79
function function_c2b1e8bad2e95e69( uniquename, playerlist )
{
    /#
        namespace_634561435cfb3169::activitynexuslog( "<dev string:x12a>" + uniquename, @"hash_3b38e79d9ffe7e9f", self, playerlist );
    #/
    
    activityinstance = self;
    broadcastinstancestructs = [];
    broadcastinstancestruct = namespace_2aca03e533f9f843::function_d4938f10afc95724( activityinstance, uniquename );
    
    if ( isdefined( broadcastinstancestruct ) )
    {
        broadcastinstancestructs = [ broadcastinstancestruct ];
    }
    
    function_9b830d84195c93e( broadcastinstancestructs, uniquename, playerlist, 0 );
}

// Namespace activity_player_broadcasting
// Params 2
// Checksum 0xc4840495, Offset: 0x72f
// Size: 0x7a
function function_c032d78d1155d62b( uniquename, playerlist )
{
    /#
        namespace_634561435cfb3169::activitynexuslog( "<dev string:x156>" + uniquename, @"hash_3b38e79d9ffe7e9f", self, playerlist );
    #/
    
    activityinstance = self;
    broadcastinstancestructs = [];
    broadcastinstancestruct = namespace_2aca03e533f9f843::function_d4938f10afc95724( activityinstance, uniquename );
    
    if ( isdefined( broadcastinstancestruct ) )
    {
        broadcastinstancestructs = [ broadcastinstancestruct ];
    }
    
    function_9b830d84195c93e( broadcastinstancestructs, uniquename, undefined, 1 );
}

// Namespace activity_player_broadcasting
// Params 1
// Checksum 0x3ba9bce8, Offset: 0x7b1
// Size: 0x72
function function_b2586a2a96fdf7eb( uniquename )
{
    /#
        namespace_634561435cfb3169::activitynexuslog( "<dev string:x17d>" + uniquename + uniquename, @"hash_3b38e79d9ffe7e9f", self );
    #/
    
    activityinstance = self;
    broadcastinstancestructs = [];
    broadcastinstancestruct = namespace_2aca03e533f9f843::function_d4938f10afc95724( activityinstance, uniquename );
    
    if ( isdefined( broadcastinstancestruct ) )
    {
        broadcastinstancestructs = [ broadcastinstancestruct ];
    }
    
    function_9b830d84195c93e( broadcastinstancestructs, uniquename, undefined, 2 );
}

// Namespace activity_player_broadcasting
// Params 2
// Checksum 0x20f625c0, Offset: 0x82b
// Size: 0x6b
function function_cb4750c84882dd07( activationname, playerlist )
{
    var_bdff29cb8b08ca81 = activity_definition_utils::function_f9aac5b745dab95a( self );
    
    if ( var_bdff29cb8b08ca81 )
    {
        return;
    }
    
    /#
        namespace_634561435cfb3169::activitynexuslog( "<dev string:x1a7>" + activationname, @"hash_3b38e79d9ffe7e9f", self, playerlist );
    #/
    
    broadcastinstancestructs = namespace_2aca03e533f9f843::function_a9c87ab2939586d3( activationname, self );
    function_9b830d84195c93e( broadcastinstancestructs, activationname, playerlist, 0 );
}

// Namespace activity_player_broadcasting
// Params 2
// Checksum 0xb0bf5219, Offset: 0x89e
// Size: 0x55
function function_14b649cbfe7ea3c4( activationname, playerlist )
{
    /#
        namespace_634561435cfb3169::activitynexuslog( "<dev string:x1d7>" + activationname, @"hash_3b38e79d9ffe7e9f", self, playerlist );
    #/
    
    broadcastinstancestructs = namespace_2aca03e533f9f843::function_a9c87ab2939586d3( activationname, self );
    function_9b830d84195c93e( broadcastinstancestructs, activationname, playerlist, 1 );
}

// Namespace activity_player_broadcasting
// Params 1
// Checksum 0x3178cc14, Offset: 0x8fb
// Size: 0x112
function function_b48d25e3756ccf58( activitymoment )
{
    activityinstance = self;
    
    /#
        namespace_634561435cfb3169::activitynexuslog( "<dev string:x202>" + activitymoment, @"hash_3b38e79d9ffe7e9f", activityinstance );
    #/
    
    if ( activitymoment == "ActivationName" )
    {
        assertmsg( "<dev string:x23b>" );
        return;
    }
    
    if ( !isarray( self.activebroadcasts ) )
    {
        return;
    }
    
    foreach ( broadcastinstance in activityinstance.activebroadcasts )
    {
        deactivationmoment = broadcastinstance.broadcastdefinition.deactivationmoment ?? "None";
        
        if ( deactivationmoment == activitymoment )
        {
            player_broadcasting::function_d5e0cfa5ea5a12f( broadcastinstance );
            function_3375ec2c973b6dfb( broadcastinstance, activityinstance );
        }
    }
}

// Namespace activity_player_broadcasting
// Params 1
// Checksum 0x1352f39b, Offset: 0xa15
// Size: 0x13c
function function_b9b05383569833c7( deactivationname )
{
    activityinstance = self;
    
    /#
        namespace_634561435cfb3169::activitynexuslog( "<dev string:x2b0>" + deactivationname, @"hash_3b38e79d9ffe7e9f", activityinstance );
    #/
    
    if ( !isarray( self.activebroadcasts ) )
    {
        return;
    }
    
    foreach ( broadcastinstance in activityinstance.activebroadcasts )
    {
        deactivationmoment = broadcastinstance.broadcastdefinition.deactivationmoment ?? "None";
        name = broadcastinstance.broadcastdefinition.deactivationname;
        var_18e1af9a451816d9 = deactivationmoment == "ActivationName";
        deactivationnamematches = name == deactivationname;
        
        if ( var_18e1af9a451816d9 && deactivationnamematches )
        {
            player_broadcasting::function_d5e0cfa5ea5a12f( broadcastinstance );
            function_3375ec2c973b6dfb( broadcastinstance, activityinstance );
        }
    }
}

// Namespace activity_player_broadcasting
// Params 1
// Checksum 0x53355624, Offset: 0xb59
// Size: 0xb3
function function_188434aa0a77d1af( playerlist )
{
    /#
        namespace_634561435cfb3169::activitynexuslog( "<dev string:x2e7>", @"hash_3b38e79d9ffe7e9f", self, playerlist );
    #/
    
    if ( !isarray( self.activebroadcasts ) )
    {
        return;
    }
    
    foreach ( broadcastinstancestruct in self.activebroadcasts )
    {
        player_broadcasting::function_b5f131802b22606e( playerlist, broadcastinstancestruct );
    }
}

// Namespace activity_player_broadcasting
// Params 1
// Checksum 0xb6c6165a, Offset: 0xc14
// Size: 0x39
function getactivebroadcastinstance( broadcastuniqueid )
{
    activebroadcast = undefined;
    
    if ( isdefined( self.activebroadcasts[ broadcastuniqueid ] ) )
    {
        activebroadcast = self.activebroadcasts[ broadcastuniqueid ];
    }
    
    return activebroadcast;
}

// Namespace activity_player_broadcasting
// Params 4
// Checksum 0x588b54d9, Offset: 0xc56
// Size: 0x50
function function_5e55b75611f91b21( activityinstance, var_7e256f8317a878a6, var_f98aa3d4e1c7a436, var_13e1db5338546002 )
{
    var_a353866a3bf6ceac = spawnstruct();
    var_a353866a3bf6ceac conditional_container::function_3c3be461141746c0();
    function_210338c60bbfa246( var_a353866a3bf6ceac, activityinstance, var_7e256f8317a878a6, var_f98aa3d4e1c7a436, var_13e1db5338546002 );
    return var_a353866a3bf6ceac;
}

// Namespace activity_player_broadcasting
// Params 5
// Checksum 0xae77a498, Offset: 0xcaf
// Size: 0xed
function function_210338c60bbfa246( var_62dc0596d42b82c8, activityinstance, var_7e256f8317a878a6 = 1, var_f98aa3d4e1c7a436 = 0, var_13e1db5338546002 = 1 )
{
    conditional_container::addcondition( var_62dc0596d42b82c8, &activity_player_common::function_a8e2e37e992cbd07, [] );
    conditional_container::addcondition( var_62dc0596d42b82c8, &function_2d073fd971636296, [ var_62dc0596d42b82c8, activityinstance ] );
    
    if ( var_f98aa3d4e1c7a436 )
    {
        conditional_container::addcondition( var_62dc0596d42b82c8, &activity_participation::function_ad5bd80478398b57, [ activityinstance ] );
    }
    
    if ( var_7e256f8317a878a6 )
    {
        conditional_container::addcondition( var_62dc0596d42b82c8, &activity_player_common::function_a5abbbd5e6dac189, [ activityinstance ] );
    }
    
    if ( var_13e1db5338546002 )
    {
        conditional_container::addcondition( var_62dc0596d42b82c8, &activity_player_common::function_4991abc5e15f6b5e, [] );
    }
    
    if ( isdefined( level.activities.nexusoverrides[ 13 ] ) )
    {
        activity_common::function_2ba08ba0c0544a1a( 13, [ var_62dc0596d42b82c8, activityinstance ], 0 );
    }
}

// Namespace activity_player_broadcasting
// Params 2
// Checksum 0xa5464379, Offset: 0xda4
// Size: 0x83
function function_2d073fd971636296( player, params )
{
    broadcastinstance = params[ 0 ];
    activityinstance = params[ 1 ];
    
    if ( !player_broadcasting::function_674ee71664c02724( broadcastinstance ) )
    {
        return 1;
    }
    
    payload = { #activityinstance:activityinstance, #broadcastinstance:broadcastinstance };
    var_5c25657d6e6dab7a = player callback::response( 2, #"hash_caf9b33006ac87e0", payload );
    return var_5c25657d6e6dab7a;
}

// Namespace activity_player_broadcasting
// Params 4, eflags: 0x4
// Checksum 0x82a79546, Offset: 0xe30
// Size: 0xf2
function private function_9b830d84195c93e( broadcastinstancestructs, activationname, playerlist, var_3e5b2eb1729345e8 )
{
    activityinstance = self;
    
    if ( !isdefined( playerlist ) )
    {
        playerlist = activityinstance.playerparticipants;
    }
    
    foreach ( broadcastinstancestruct in broadcastinstancestructs )
    {
        if ( var_3e5b2eb1729345e8 == 0 )
        {
            broadcast( broadcastinstancestruct, playerlist );
            continue;
        }
        
        if ( var_3e5b2eb1729345e8 == 1 )
        {
            player_broadcasting::function_b5f131802b22606e( playerlist, broadcastinstancestruct );
            continue;
        }
        
        if ( var_3e5b2eb1729345e8 == 2 )
        {
            player_broadcasting::function_b5f131802b22606e( playerlist, broadcastinstancestruct );
            function_3375ec2c973b6dfb( broadcastinstancestruct, activityinstance );
        }
    }
}

// Namespace activity_player_broadcasting
// Params 1, eflags: 0x4
// Checksum 0x80eb8c03, Offset: 0xf2a
// Size: 0xc6
function private function_b97739a34e9b6045( activationname )
{
    var_dc445397dd71e036 = [];
    
    if ( isarray( self.activebroadcasts ) )
    {
        foreach ( activebroadcastinstance in self.activebroadcasts )
        {
            broadcastactivationname = activebroadcastinstance.broadcastdefinition.activationname;
            
            if ( broadcastactivationname == activationname )
            {
                var_dc445397dd71e036[ var_dc445397dd71e036.size ] = activebroadcastinstance;
            }
        }
    }
    
    return var_dc445397dd71e036;
}

// Namespace activity_player_broadcasting
// Params 2, eflags: 0x4
// Checksum 0x71339d5c, Offset: 0xff9
// Size: 0x8a
function private function_41d410d801bd31f7( broadcastinstance, activityinstance )
{
    /#
        namespace_634561435cfb3169::activitynexuslog( "<dev string:x31a>" + function_1c4eb71627ffe619( broadcastinstance ), @"hash_3b38e79d9ffe7e9f", activityinstance );
    #/
    
    uniqueid = broadcastinstance player_broadcasting::getbroadcastuniqueid();
    
    if ( activityinstance.activebroadcasts )
    {
        activityinstance.activebroadcasts[ uniqueid ] = broadcastinstance;
        return;
    }
    
    activityinstance.activebroadcasts = [];
    activityinstance.activebroadcasts[ uniqueid ] = broadcastinstance;
}

// Namespace activity_player_broadcasting
// Params 2, eflags: 0x4
// Checksum 0x1826747d, Offset: 0x108b
// Size: 0x8a
function private function_3375ec2c973b6dfb( broadcastinstance, activityinstance )
{
    /#
        namespace_634561435cfb3169::activitynexuslog( "<dev string:x35f>" + function_1c4eb71627ffe619( broadcastinstance ), @"hash_3b38e79d9ffe7e9f", activityinstance );
    #/
    
    if ( !isarray( activityinstance.activebroadcasts ) )
    {
        return;
    }
    
    uniqueid = broadcastinstance player_broadcasting::getbroadcastuniqueid();
    activityinstance.activebroadcasts[ uniqueid ] = undefined;
    
    if ( activityinstance.activebroadcasts.size == 0 )
    {
        activityinstance.activebroadcasts = undefined;
    }
}

/#

    // Namespace activity_player_broadcasting
    // Params 0
    // Checksum 0xaf501b1b, Offset: 0x111d
    // Size: 0x15f, Type: dev
    function function_22e418c00e4f046d()
    {
        var_72a41c61e0a93ba7 = activity_nexus_debug::function_3a45e311cf4d30b7();
        devgui::function_9082edeb5db93280( var_72a41c61e0a93ba7 + "<dev string:x3a9>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x3d7>", "<dev string:x409>" + "<dev string:x418>" + "<dev string:x426>", &function_54173f4bc553b1c9 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x428>", "<dev string:x409>" + "<dev string:x458>" + "<dev string:x426>", &function_54173f4bc553b1c9 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x464>", "<dev string:x409>" + "<dev string:x496>" + "<dev string:x426>", &function_54173f4bc553b1c9 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x4a4>", "<dev string:x409>" + "<dev string:x4d4>" + "<dev string:x426>", &function_54173f4bc553b1c9 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x4e0>", "<dev string:x409>" + "<dev string:x514>" + "<dev string:x426>", &function_54173f4bc553b1c9 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x524>", "<dev string:x409>" + "<dev string:x558>" + "<dev string:x426>", &function_54173f4bc553b1c9 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x568>", "<dev string:x409>" + "<dev string:x597>" + "<dev string:x426>", &function_54173f4bc553b1c9 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x5a2>", "<dev string:x409>" + "<dev string:x5d2>" + "<dev string:x426>", &function_54173f4bc553b1c9 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x5de>", "<dev string:x409>" + "<dev string:x61e>" + "<dev string:x426>", &function_54173f4bc553b1c9 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace activity_player_broadcasting
    // Params 1, eflags: 0x4
    // Checksum 0x8bc0094d, Offset: 0x1284
    // Size: 0x5f, Type: dev
    function private function_1c4eb71627ffe619( broadcastinstance )
    {
        broadcastinfostring = "<dev string:x638>" + broadcastinstance player_broadcasting::getbroadcasttype() + "<dev string:x64b>" + broadcastinstance player_broadcasting::getbroadcastuniqueid() + "<dev string:x658>" + ( broadcastinstance.broadcastdefinition.destination ?? "<dev string:x667>" );
        return broadcastinfostring;
    }

    // Namespace activity_player_broadcasting
    // Params 1, eflags: 0x4
    // Checksum 0xb204875c, Offset: 0x12eb
    // Size: 0xff, Type: dev
    function private function_54173f4bc553b1c9( params )
    {
        hostplayer = undefined;
        
        if ( isdefined( level.players ) )
        {
            hostplayer = level.players[ 0 ];
        }
        else
        {
            hostplayer = level.player;
        }
        
        if ( isplayer( hostplayer ) && isdefined( hostplayer.activities.focusedactivityid ) )
        {
            id = hostplayer.activities.focusedactivityid;
            instance = level.activities.instances[ id ];
            moment = params[ 0 ];
            
            if ( moment == "<dev string:x597>" || moment == "<dev string:x5d2>" || moment == "<dev string:x61e>" )
            {
                instance function_849396805a2d9d98( moment, [ hostplayer ] );
                return;
            }
            
            instance function_849396805a2d9d98( moment, instance.playerparticipants );
        }
    }

#/
