// script_60cd1c57e94be8d7  (hash_60cd1c57e94be8d7.gscc) (size: 5079 Bytes / 0x13d7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3f1d10d8 (1058869464)
// size ...... 5079 (0x13d7)
// includes .. 9   (offset: 0x1303)
// strings ... 3   (offset: 0x134b)
// dev strs .. 8   (offset: 0x1373)
// exports ... 20  (offset: 0xad3)
// cseg ...... 0x9f + 0xa34 (0xad3)
// imports ... 43  (offset: 0xdf3)
// animtree1 . 0   (offset: 0x13d7)
// animtree2 . 0   (offset: 0x13d7)
#using script_77873e194e406c6d;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_objective_markers;
#using scripts\common\spatial_zone_container;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\objective_marker_bundle_helper_mp;
#using scripts\mp\objidpoolmanager;

#namespace namespace_d7fa4530141146a5;

// Namespace namespace_d7fa4530141146a5
// Params 0, eflags: 0x5
// Checksum 0x97410c7f, Offset: 0xbd
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_ea9af0cf72701518", undefined, &function_a2291599cd8a9d65, undefined );
}

// Namespace namespace_d7fa4530141146a5
// Params 0, eflags: 0x4
// Checksum 0x85d39b5b, Offset: 0xde
// Size: 0x98
function private function_a2291599cd8a9d65()
{
    utility::registersharedfunc( #"hash_61266e374b6a4978", #"hash_2c771489de24ca63", &function_61356838ae30aa48 );
    utility::registersharedfunc( #"hash_61266e374b6a4978", #"hash_a9dac899f49dbbe", &function_a81d40bfa4f7bfef );
    utility::registersharedfunc( #"hash_61266e374b6a4978", #"hash_32b413eabeba80ce", &function_cce7ddea05b66b0f );
    utility::registersharedfunc( #"hash_61266e374b6a4978", #"hash_cfba68776eb6b6d1", &function_5fd4f84e2596b9e3 );
    utility::registersharedfunc( #"hash_61266e374b6a4978", #"hash_82d433365dffce54", &function_6d48496b3713956e );
}

// Namespace namespace_d7fa4530141146a5
// Params 3
// Checksum 0xfb7a1823, Offset: 0x17e
// Size: 0x43
function function_de87bf7072515cd3( bundlename, shouldpin, var_2cbc109c4db9ad8 )
{
    bundlexhash = hashcat( %"hash_334a4b8da1c7fd3f", bundlename );
    return function_f94c04cdce542f08( bundlexhash, shouldpin, var_2cbc109c4db9ad8 );
}

// Namespace namespace_d7fa4530141146a5
// Params 3
// Checksum 0xc7f83124, Offset: 0x1ca
// Size: 0x86
function function_f94c04cdce542f08( bundlexhash, shouldpin = 0, var_2cbc109c4db9ad8 = 1 )
{
    var_613f2dca5673d005 = objective_marker_bundle_helper_mp::mp_createobjectivemarkerfrombundlexhash( bundlexhash );
    
    if ( isdefined( var_613f2dca5673d005 ) && var_613f2dca5673d005 != -1 )
    {
        function_e27cc6376feeb35c( var_613f2dca5673d005, shouldpin, var_2cbc109c4db9ad8 );
    }
    else
    {
        assertmsg( "<dev string:x24>" + getxhashsourcename( bundlexhash ) + "<dev string:x55>" + self.varianttag );
    }
    
    return var_613f2dca5673d005;
}

// Namespace namespace_d7fa4530141146a5
// Params 3
// Checksum 0x82f60e61, Offset: 0x259
// Size: 0xda
function function_e27cc6376feeb35c( markerid, shouldpin, var_2cbc109c4db9ad8 = 1 )
{
    if ( !isdefined( self.objectivemarkers ) )
    {
        self.objectivemarkers = [];
    }
    
    self.objectivemarkers[ markerid ] = spawnstruct();
    self.objectivemarkers[ markerid ].id = markerid;
    self.objectivemarkers[ markerid ].shouldpin = istrue( shouldpin );
    self.objectivemarkers[ markerid ].var_468968d4414a387c = var_2cbc109c4db9ad8;
    
    /#
        namespace_634561435cfb3169::activitynexuslog( "<dev string:x71>" + function_7ddefa6eac47423c( markerid ), @"hash_ee2680c4a8804012", self );
    #/
    
    if ( var_2cbc109c4db9ad8 )
    {
        objective_removeallfrommask( markerid );
        function_7c5730b9151d91( self.playerparticipants, markerid );
    }
    
    return markerid;
}

// Namespace namespace_d7fa4530141146a5
// Params 1
// Checksum 0xdcb71a5f, Offset: 0x33c
// Size: 0x4c
function function_423139673498b11f( markerid )
{
    if ( !isdefined( self.objectivemarkers[ markerid ] ) )
    {
        return;
    }
    
    self.objectivemarkers[ markerid ] = undefined;
    
    /#
        namespace_634561435cfb3169::activitynexuslog( "<dev string:x8a>" + function_7ddefa6eac47423c( markerid ), @"hash_ee2680c4a8804012", self );
    #/
}

// Namespace namespace_d7fa4530141146a5
// Params 1
// Checksum 0x20287a83, Offset: 0x390
// Size: 0x67
function function_501e44ea1cb9219d( markerid )
{
    if ( !( isdefined( markerid ) && isdefined( self.objectivemarkers[ markerid ] ) ) )
    {
        return;
    }
    
    self.objectivemarkers[ markerid ] = undefined;
    
    if ( !objidpoolmanager::function_fb05d646a96ed99e( markerid ) )
    {
        objidpoolmanager::returnobjectiveid( markerid );
    }
    
    /#
        namespace_634561435cfb3169::activitynexuslog( "<dev string:xad>" + function_7ddefa6eac47423c( markerid ), @"hash_ee2680c4a8804012", self );
    #/
}

// Namespace namespace_d7fa4530141146a5
// Params 2
// Checksum 0xef80a600, Offset: 0x3ff
// Size: 0xb1
function function_7c5730b9151d91( players, markerid )
{
    foreach ( player in players )
    {
        objective_addclienttomask( markerid, player );
        objective_showtoplayersinmask( markerid );
        
        /#
            namespace_634561435cfb3169::activitynexuslog( "<dev string:xd0>" + function_7ddefa6eac47423c( markerid ), @"hash_ee2680c4a8804012", self, players );
        #/
    }
}

// Namespace namespace_d7fa4530141146a5
// Params 2
// Checksum 0x34d0a328, Offset: 0x4b8
// Size: 0xaa
function function_831cf83f2b250537( players, markerid )
{
    foreach ( player in players )
    {
        objective_removeclientfrommask( markerid, player );
        
        /#
            namespace_634561435cfb3169::activitynexuslog( "<dev string:xf8>" + function_7ddefa6eac47423c( markerid ), @"hash_ee2680c4a8804012", self, players );
        #/
    }
}

// Namespace namespace_d7fa4530141146a5
// Params 1
// Checksum 0x354a7bea, Offset: 0x56a
// Size: 0x51
function function_517fe328c656a8e6( markerid )
{
    assert( isdefined( self.objectivemarkers[ markerid ] ), "<dev string:x124>" );
    self.objectivemarkers[ markerid ].shouldpin = 1;
    function_16b416bc7065c747( self.playerparticipants, markerid );
}

// Namespace namespace_d7fa4530141146a5
// Params 1
// Checksum 0xc85ba02d, Offset: 0x5c3
// Size: 0x50
function function_39c4425f122c7763( markerid )
{
    assert( isdefined( self.objectivemarkers[ markerid ] ), "<dev string:x124>" );
    self.objectivemarkers[ markerid ].shouldpin = 0;
    function_13becfcf4b19e3ce( self.playerparticipants, markerid );
}

// Namespace namespace_d7fa4530141146a5
// Params 1
// Checksum 0x59f24be4, Offset: 0x61b
// Size: 0xda
function function_61356838ae30aa48( player )
{
    objectivemarkers = self.objectivemarkers ?? [];
    
    foreach ( marker in objectivemarkers )
    {
        if ( marker.var_468968d4414a387c )
        {
            function_7c5730b9151d91( [ player ], marker.id );
            
            if ( marker.shouldpin )
            {
                function_16b416bc7065c747( [ player ], marker.id );
            }
        }
    }
}

// Namespace namespace_d7fa4530141146a5
// Params 1
// Checksum 0x4edbd483, Offset: 0x6fd
// Size: 0xda
function function_a81d40bfa4f7bfef( player )
{
    objectivemarkers = self.objectivemarkers ?? [];
    
    foreach ( marker in objectivemarkers )
    {
        if ( marker.var_468968d4414a387c )
        {
            function_831cf83f2b250537( [ player ], marker.id );
            
            if ( marker.shouldpin )
            {
                function_13becfcf4b19e3ce( [ player ], marker.id );
            }
        }
    }
}

// Namespace namespace_d7fa4530141146a5
// Params 0
// Checksum 0x53ee4a89, Offset: 0x7df
// Size: 0xb3
function function_cce7ddea05b66b0f()
{
    objectivemarkers = self.objectivemarkers ?? [];
    
    foreach ( marker in objectivemarkers )
    {
        if ( !objidpoolmanager::function_fb05d646a96ed99e( marker.id ) )
        {
            objidpoolmanager::returnobjectiveid( marker.id );
        }
    }
    
    self.objectivemarkers = [];
}

// Namespace namespace_d7fa4530141146a5
// Params 1, eflags: 0x4
// Checksum 0xf87ee916, Offset: 0x89a
// Size: 0xba
function private function_5fd4f84e2596b9e3( activityinstance )
{
    var_8c44ee09c0e97aa8 = activity_definition_utils::function_9461b89496773d9( activityinstance );
    var_337ab7a0ccddd0e7 = activity_definition_utils::function_f5e99efc55cb0385( activityinstance );
    shouldpin = activity_definition_utils::function_ca3542bdf90eb3d( activityinstance );
    var_5c2906e1d8d435e9 = activityinstance function_f94c04cdce542f08( var_8c44ee09c0e97aa8, shouldpin, var_337ab7a0ccddd0e7 );
    origin = activity_instance_common::function_776ee11e7acc64a5( activityinstance );
    
    if ( spatial_zone_container::function_3819f09eefb741e2( activityinstance, "Objective_Marker_Center_Zone" ) )
    {
        origin = spatial_zone_container::function_46a131256b075dc1( activityinstance, "Objective_Marker_Center_Zone" );
    }
    
    objidpoolmanager::update_objective_position( var_5c2906e1d8d435e9, origin );
    var_e7b6adbe385c7c18 = namespace_49c2d747a467dc5f::function_238da7a43b91b2b6( "GSCScript", var_5c2906e1d8d435e9 );
    activityinstance.var_e7b6adbe385c7c18 = var_e7b6adbe385c7c18;
}

// Namespace namespace_d7fa4530141146a5
// Params 1, eflags: 0x4
// Checksum 0x29be5ba1, Offset: 0x95c
// Size: 0x3a
function private function_6d48496b3713956e( activityinstance )
{
    var_e7b6adbe385c7c18 = namespace_49c2d747a467dc5f::function_1dafaa12626eed2b( activityinstance );
    
    if ( isdefined( var_e7b6adbe385c7c18 ) )
    {
        activityinstance function_501e44ea1cb9219d( var_e7b6adbe385c7c18.objectivemarkerid );
    }
}

// Namespace namespace_d7fa4530141146a5
// Params 2, eflags: 0x4
// Checksum 0x47f6f15d, Offset: 0x99e
// Size: 0x88
function private function_16b416bc7065c747( players, markerid )
{
    foreach ( player in players )
    {
        objidpoolmanager::objective_pin_player( markerid, player );
    }
}

// Namespace namespace_d7fa4530141146a5
// Params 2, eflags: 0x4
// Checksum 0x7557ce29, Offset: 0xa2e
// Size: 0x88
function private function_13becfcf4b19e3ce( players, markerid )
{
    foreach ( player in players )
    {
        objidpoolmanager::objective_unpin_player( markerid, player );
    }
}

// Namespace namespace_d7fa4530141146a5
// Params 1, eflags: 0x4
// Checksum 0x8ec4c2b6, Offset: 0xabe
// Size: 0x14
function private function_7ddefa6eac47423c( markerid )
{
    return " objective marker id: " + markerid;
}

