// script_1f7a0c4a27e7e186  (hash_1f7a0c4a27e7e186.gscc) (size: 4661 Bytes / 0x1235 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa836964a (2822149706)
// size ...... 4661 (0x1235)
// includes .. 1   (offset: 0x1129)
// strings ... 17  (offset: 0x1131)
// dev strs .. 0   (offset: 0x1235)
// exports ... 23  (offset: 0x971)
// cseg ...... 0x164 + 0x80d (0x971)
// imports ... 34  (offset: 0xd09)
// animtree1 . 0   (offset: 0x1235)
// animtree2 . 0   (offset: 0x1235)
#using scripts\common\callbacks;

#namespace namespace_69870d3a29bda576;

// Namespace namespace_69870d3a29bda576
// Params 0, eflags: 0x1
// Checksum 0xe0ab23df, Offset: 0x182
// Size: 0x112
function autoexec init()
{
    if ( getdvarint( @"hash_b42e148f11d9d225", 0 ) == 0 )
    {
        return;
    }
    
    level.var_94e7945270937496 = [];
    level.var_fe93b2d87b86b70d = function_14c1332f43be5ca();
    function_72af222c246062ec( "lootcache_looted", "lootcache_looted" );
    function_72af222c246062ec( "item_pickup", #"player_item_pickup" );
    function_72af222c246062ec( "item_manual_pickup", #"player_item_pickup" );
    function_72af222c246062ec( "used_item", #"player_used_item" );
    function_72af222c246062ec( "used_ascender", #"player_used_ascender" );
    function_72af222c246062ec( "mantle", #"mantle_begin" );
    function_72af222c246062ec( "deal_damage", #"player_deal_damage" );
    function_72af222c246062ec( "revive_start", #"hash_4cd04b297f3576a" );
    function_72af222c246062ec( "crate_used", #"player_used_crate" );
    function_72af222c246062ec( "vehicle_enter", #"player_vehicle_enter" );
    function_72af222c246062ec( "swim_enter", #"on_swim_enter" );
}

// Namespace namespace_69870d3a29bda576
// Params 2
// Checksum 0xb73e3290, Offset: 0x29c
// Size: 0x5d
function function_72af222c246062ec( var_469072f93ecbd83b, callbackname )
{
    if ( getdvarint( @"hash_b42e148f11d9d225", 0 ) == 0 )
    {
        return;
    }
    
    if ( isdefined( var_469072f93ecbd83b ) && isdefined( callbackname ) && arraycontains( level.var_fe93b2d87b86b70d, var_469072f93ecbd83b ) )
    {
        level.var_94e7945270937496[ callbackname ] = function_db9188039354c695( var_469072f93ecbd83b );
    }
}

// Namespace namespace_69870d3a29bda576
// Params 0
// Checksum 0x6f57c77e, Offset: 0x301
// Size: 0xb1
function function_6b1acbf1e055f37f()
{
    if ( getdvarint( @"hash_b42e148f11d9d225", 0 ) == 0 )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        if ( isbot( player ) )
        {
            continue;
        }
        
        player thread function_c869b26cf6f7875d();
    }
    
    level callback::add( #"player_connect", &function_87b129bb3544ed43 );
}

// Namespace namespace_69870d3a29bda576
// Params 1
// Checksum 0xe7087181, Offset: 0x3ba
// Size: 0x27
function function_87b129bb3544ed43( params )
{
    if ( !isdefined( self.pers[ "passedAFKActions" ] ) )
    {
        thread function_c869b26cf6f7875d();
    }
}

// Namespace namespace_69870d3a29bda576
// Params 0, eflags: 0x4
// Checksum 0x7d877f71, Offset: 0x3e9
// Size: 0x2b
function private function_14c1332f43be5ca()
{
    actionsval = getdvar( @"hash_df77ba0fe5525046", "" );
    return strtok( actionsval, "|" );
}

// Namespace namespace_69870d3a29bda576
// Params 0, eflags: 0x4
// Checksum 0xcf61396c, Offset: 0x41d
// Size: 0x14a
function private function_c869b26cf6f7875d()
{
    self.pers[ "passedAFKActions" ] = 0;
    self.pers[ "passedAFKTime" ] = gettime();
    
    if ( isdefined( level.gametypebundle.var_25acead60a233819 ) )
    {
        foreach ( activity in level.gametypebundle.var_25acead60a233819 )
        {
            callback::add( activity.var_cb7c429c22d88f0, &function_448d3c637303a216 );
        }
        
        return;
    }
    
    foreach ( callbackname, var_74713542c89d8448 in level.var_94e7945270937496 )
    {
        function_358ba564bd6c2fc7( callbackname, var_74713542c89d8448 );
    }
}

// Namespace namespace_69870d3a29bda576
// Params 1, eflags: 0x4
// Checksum 0xc3d8e545, Offset: 0x56f
// Size: 0x3a
function private function_448d3c637303a216( params )
{
    if ( isdefined( level.var_f5c49cf37c68f91c ) )
    {
        [[ level.var_f5c49cf37c68f91c ]]();
        return;
    }
    
    self.pers[ "passedAFKActions" ] = 1;
}

// Namespace namespace_69870d3a29bda576
// Params 1, eflags: 0x4
// Checksum 0x3e2f53a0, Offset: 0x5b1
// Size: 0x96
function private function_c4d0b3ce7ba184f9( var_469072f93ecbd83b )
{
    function_448d3c637303a216();
    function_621c7bb5f46c94ec( var_469072f93ecbd83b );
    
    foreach ( callbackname, var_74713542c89d8448 in level.var_94e7945270937496 )
    {
        callback::remove( callbackname, var_74713542c89d8448 );
    }
}

// Namespace namespace_69870d3a29bda576
// Params 2, eflags: 0x4
// Checksum 0x75c21bac, Offset: 0x64f
// Size: 0x1f
function private function_358ba564bd6c2fc7( callbackname, var_74713542c89d8448 )
{
    callback::add( callbackname, var_74713542c89d8448 );
}

// Namespace namespace_69870d3a29bda576
// Params 1, eflags: 0x4
// Checksum 0xa2120da5, Offset: 0x676
// Size: 0xdc
function private function_db9188039354c695( var_469072f93ecbd83b )
{
    switch ( var_469072f93ecbd83b )
    {
        case #"hash_f35d8fda8f5aa137":
            return &function_f6655ad1f193c25a;
        case #"hash_1d7eb4d6d396ade3":
            return &function_d23118be0bc54c20;
        case #"hash_bc7b2c50024e8e42":
            return &function_61c65431c476a22f;
        case #"hash_1a8b7a3e72d9b2fe":
            return &function_8fc61982cf5c5b61;
        case #"hash_9f8737fb9ab2a0f4":
            return &function_87f433fde5dc44fb;
        case #"hash_35405ef168cb4d6":
            return &function_8e4f583d89a6427f;
        case #"hash_4c53b9b48093b141":
            return &function_e0fc87bd391d7506;
        case #"hash_dbe2633d2a345647":
            return &function_bd21c6252831f1e;
        case #"hash_96ddd5f832ddad78":
            return &function_e8bad271bd5cb4d;
        case #"hash_8661f460881c12d6":
            return &function_a64bf54ccd491229;
        case #"hash_ecfa236e8409ce40":
            return &function_74ecf4a57a6c5605;
    }
}

// Namespace namespace_69870d3a29bda576
// Params 1, eflags: 0x4
// Checksum 0x56be7ce3, Offset: 0x75a
// Size: 0x45
function private function_621c7bb5f46c94ec( var_469072f93ecbd83b )
{
    player = self;
    eventparams = [ "action", getxhash( var_469072f93ecbd83b ) ];
    player dlog_recordplayerevent( "dlog_event_player_afk_action_passed", eventparams );
}

// Namespace namespace_69870d3a29bda576
// Params 2, eflags: 0x4
// Checksum 0x405f7a19, Offset: 0x7a7
// Size: 0x21
function private function_f6655ad1f193c25a( params, additionalparams )
{
    function_c4d0b3ce7ba184f9( "lootcache_looted" );
}

// Namespace namespace_69870d3a29bda576
// Params 2, eflags: 0x4
// Checksum 0xd2e4a8a9, Offset: 0x7d0
// Size: 0x21
function private function_d23118be0bc54c20( params, additionalparams )
{
    function_c4d0b3ce7ba184f9( "item_pickup" );
}

// Namespace namespace_69870d3a29bda576
// Params 2, eflags: 0x4
// Checksum 0x6b9a1d84, Offset: 0x7f9
// Size: 0x30
function private function_61c65431c476a22f( params, additionalparams )
{
    if ( params.autouse )
    {
        return;
    }
    
    function_c4d0b3ce7ba184f9( "item_manual_pickup" );
}

// Namespace namespace_69870d3a29bda576
// Params 2, eflags: 0x4
// Checksum 0x1dc532e4, Offset: 0x831
// Size: 0x21
function private function_8fc61982cf5c5b61( params, additionalparams )
{
    function_c4d0b3ce7ba184f9( "used_item" );
}

// Namespace namespace_69870d3a29bda576
// Params 2, eflags: 0x4
// Checksum 0x87e92c9a, Offset: 0x85a
// Size: 0x21
function private function_87f433fde5dc44fb( params, additionalparams )
{
    function_c4d0b3ce7ba184f9( "used_ascender" );
}

// Namespace namespace_69870d3a29bda576
// Params 2, eflags: 0x4
// Checksum 0x16d39034, Offset: 0x883
// Size: 0x21
function private function_8e4f583d89a6427f( params, additionalparams )
{
    function_c4d0b3ce7ba184f9( "mantle" );
}

// Namespace namespace_69870d3a29bda576
// Params 2, eflags: 0x4
// Checksum 0xd2e4a8a9, Offset: 0x8ac
// Size: 0x21
function private function_e0fc87bd391d7506( params, additionalparams )
{
    function_c4d0b3ce7ba184f9( "deal_damage" );
}

// Namespace namespace_69870d3a29bda576
// Params 2, eflags: 0x4
// Checksum 0xf8a96ce5, Offset: 0x8d5
// Size: 0x21
function private function_bd21c6252831f1e( params, additionalparams )
{
    function_c4d0b3ce7ba184f9( "revive_start" );
}

// Namespace namespace_69870d3a29bda576
// Params 2, eflags: 0x4
// Checksum 0xf00b7052, Offset: 0x8fe
// Size: 0x21
function private function_e8bad271bd5cb4d( params, additionalparams )
{
    function_c4d0b3ce7ba184f9( "crate_used" );
}

// Namespace namespace_69870d3a29bda576
// Params 2, eflags: 0x4
// Checksum 0x87e92c9a, Offset: 0x927
// Size: 0x21
function private function_a64bf54ccd491229( params, additionalparams )
{
    function_c4d0b3ce7ba184f9( "vehicle_enter" );
}

// Namespace namespace_69870d3a29bda576
// Params 2, eflags: 0x4
// Checksum 0xf00b7052, Offset: 0x950
// Size: 0x21
function private function_74ecf4a57a6c5605( params, additionalparams )
{
    function_c4d0b3ce7ba184f9( "swim_enter" );
}

