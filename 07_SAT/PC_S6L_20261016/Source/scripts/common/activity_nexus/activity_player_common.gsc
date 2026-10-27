// scripts\common\activity_nexus\activity_player_common.gsc  (hash_31805e8ef07bfa53.gscc) (size: 12304 Bytes / 0x3010 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7e21f4d3 (2116154579)
// size ...... 12304 (0x3010)
// includes .. 12  (offset: 0x2ea8)
// strings ... 13  (offset: 0x2f08)
// dev strs .. 7   (offset: 0x2fb0)
// exports ... 46  (offset: 0x1d8c)
// cseg ...... 0x179 + 0x1c13 (0x1d8c)
// imports ... 79  (offset: 0x24bc)
// animtree1 . 0   (offset: 0x3010)
// animtree2 . 0   (offset: 0x3010)
#using script_77873e194e406c6d;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_objective_markers;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\activity_nexus\activity_player_broadcasting;
#using scripts\common\activity_nexus\activity_ui;
#using scripts\common\callbacks;
#using scripts\common\conditional_container;
#using scripts\common\omnvar_utility;
#using scripts\common\utility;

#namespace activity_player_common;

// Namespace activity_player_common
// Params 1
// Checksum 0x5bd65763, Offset: 0x197
// Size: 0x117
function function_2654b580d1cc4ea1( var_ca3f65fdba0a9ed2 )
{
    var_63e1c142fe761ef7 = utility::getsharedfunc( #"activity_participation", #"hash_bd9fe8041a91dd60" );
    
    if ( !isdefined( var_63e1c142fe761ef7 ) )
    {
        var_63e1c142fe761ef7 = &activity_participation::function_ef4e919227bc4515;
    }
    
    [[ var_63e1c142fe761ef7 ]]();
    callback::add( #"player_connect", &function_c00388453e7dc3aa );
    callback::add( #"player_death", &_onplayerdeath );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &function_d71e948fd9f2e5de );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &function_1bc8e088822a307e );
    var_ca3f65fdba0a9ed2.playerfocusconditions = spawnstruct();
    var_ca3f65fdba0a9ed2.playerfocusconditions conditional_container::function_3c3be461141746c0();
    
    if ( activity_common::function_8fe1a47c40904418( 1 ) )
    {
        conditional_container::addcondition( var_ca3f65fdba0a9ed2.playerfocusconditions, &activity_participation::function_d1ee7fc846133adf, [] );
        playerfocuscountdowntimer = var_ca3f65fdba0a9ed2.activitynexussettings.playerfocuscountdowntimer;
        conditional_container::addcondition( var_ca3f65fdba0a9ed2.playerfocusconditions, &function_b8ce206806d98976, [ playerfocuscountdowntimer ] );
        level thread function_d9442bc6f22205a4();
    }
}

// Namespace activity_player_common
// Params 1
// Checksum 0xf18dbbc0, Offset: 0x2b6
// Size: 0x58
function function_44ef43ff1f6d21d4( player )
{
    var_9dbf94c363ad63ab = utility::getsharedfunc( #"hash_bfef14c27a599b88", #"hash_5d319eff2d9589f" );
    
    if ( isdefined( var_9dbf94c363ad63ab ) )
    {
        return utility::callsharedfunc( #"hash_bfef14c27a599b88", #"hash_5d319eff2d9589f", player );
    }
    
    return [ player ];
}

// Namespace activity_player_common
// Params 1
// Checksum 0x1cd7139b, Offset: 0x317
// Size: 0x34
function function_ecea5c2a0aaa9c90( player )
{
    if ( isplayer( player ) && !function_762fb7fa3dbba07a( player ) )
    {
        player.activities = function_94a02052a73127eb();
    }
}

// Namespace activity_player_common
// Params 1
// Checksum 0xec6655c0, Offset: 0x353
// Size: 0x18, Type: bool
function function_762fb7fa3dbba07a( player )
{
    return isdefined( player.activities );
}

// Namespace activity_player_common
// Params 1
// Checksum 0xa09eaa68, Offset: 0x374
// Size: 0x2c
function function_ef912bdece1bc4ef( player )
{
    if ( !function_762fb7fa3dbba07a( player ) )
    {
        function_ecea5c2a0aaa9c90( player );
    }
    
    return player.activities;
}

// Namespace activity_player_common
// Params 0, eflags: 0xc
// Checksum 0x17071b1c, Offset: 0x3a9
// Size: 0xff
function private function_d9442bc6f22205a4()
{
    self notify( #"hash_23886a08ce272ce4" );
    self endon( #"hash_23886a08ce272ce4" );
    level endon( #"game_ended" );
    var_173abe592dbebc0f = spawnstruct();
    var_be6d32d0af4abdc8 = level.activities.playerfocusconditions;
    var_173abe592dbebc0f.var_be6d32d0af4abdc8 = var_be6d32d0af4abdc8;
    activitynexussettings = level.activities.activitynexussettings;
    var_523ebb34350932c3 = activitynexussettings.var_523ebb34350932c3;
    
    while ( !isdefined( level.players ) )
    {
        waitframe();
    }
    
    utility::flag_wait( "activity_nexus_definition_registered" );
    
    while ( true )
    {
        activityinstances = level.activities.instances;
        
        if ( activityinstances.size > 0 )
        {
            var_173abe592dbebc0f utility::function_a38b3ca4783bca3b( level.players, &function_7fca538261c8b079, &utility::object_is_valid_player, undefined, var_523ebb34350932c3, 0 );
        }
        
        waitframe();
    }
}

// Namespace activity_player_common
// Params 2
// Checksum 0xf1ef7ff6, Offset: 0x4b0
// Size: 0x122
function function_227ea43efd2cfb5c( player, types )
{
    closestid = undefined;
    closestdistance = undefined;
    var_ccc91d79bfa22c3a = activity_participation::function_e8eabd79cc49540e( player, types );
    
    foreach ( instanceid, activityinfostruct in var_ccc91d79bfa22c3a )
    {
        activityinstance = level.activities.instances[ instanceid ];
        playerdistancesq = distancesquared( player.origin, activity_instance_common::function_776ee11e7acc64a5( activityinstance ) );
        
        if ( !( isdefined( closestid ) && isdefined( closestdistance ) ) || playerdistancesq < closestdistance )
        {
            closestdistance = playerdistancesq;
            closestid = instanceid;
        }
    }
    
    if ( isdefined( closestid ) )
    {
        return level.activities.instances[ closestid ];
    }
}

// Namespace activity_player_common
// Params 2
// Checksum 0x33edd5b0, Offset: 0x5db
// Size: 0x168
function function_61357ba7bfe9177d( player, var_bbb9dd1803cef896 )
{
    if ( !activity_common::function_8fe1a47c40904418( 1 ) )
    {
        return;
    }
    
    var_fdb62c27d5202004 = function_e811448130016c90( player );
    
    if ( var_fdb62c27d5202004 )
    {
        relevantinfostruct = spawnstruct();
        relevantinfostruct.playerlist = [ player ];
        activity_instance_common::announceactivitymoment( var_fdb62c27d5202004, "PlayerLoseFocusedOnActivity", relevantinfostruct );
        
        /#
            if ( namespace_634561435cfb3169::function_a940a26e08d4ac7e( @"hash_15cad8df54bccf1e" ) )
            {
                logtext = "<dev string:x24>" + namespace_634561435cfb3169::function_76ff83856214495d( var_fdb62c27d5202004 ) + "<dev string:x4c>" + namespace_634561435cfb3169::function_76ff83856214495d( var_bbb9dd1803cef896 );
                namespace_634561435cfb3169::activitynexuslog( logtext, @"hash_15cad8df54bccf1e", undefined, [ player ] );
            }
        #/
    }
    
    function_2e7308ddfab5092b( player );
    var_3f2801438446bbab = var_bbb9dd1803cef896.id;
    var_ccc91d79bfa22c3a = activity_participation::function_e8eabd79cc49540e( player );
    var_fdc901c0c44d0583 = var_ccc91d79bfa22c3a[ var_3f2801438446bbab ];
    var_265ef6372caa068a = istrue( var_fdc901c0c44d0583.var_c1037ce8aa4e3ba8 );
    player function_32c04a849a1c0b00( var_bbb9dd1803cef896 );
    relevantinfostruct = spawnstruct();
    relevantinfostruct.playerlist = [ player ];
    activity_instance_common::announceactivitymoment( var_bbb9dd1803cef896, "PlayerFocusedOnActivity", relevantinfostruct );
    
    if ( var_265ef6372caa068a )
    {
        activity_instance_common::announceactivitymoment( var_bbb9dd1803cef896, "PlayerRefocusedOnActivity", relevantinfostruct );
    }
    
    function_436fea445dc2ab9d( player, var_bbb9dd1803cef896 );
}

// Namespace activity_player_common
// Params 1, eflags: 0x4
// Checksum 0x14a05d2, Offset: 0x74b
// Size: 0x17
function private function_3c88046be2a6c11b( activityinstance )
{
    return activityinstance.var_f9892c97568a5184;
}

// Namespace activity_player_common
// Params 1
// Checksum 0x7a2c22ed, Offset: 0x76b
// Size: 0x88
function function_958e5ad8050bb4c9( player )
{
    if ( !activity_common::function_8fe1a47c40904418( 1 ) )
    {
        return;
    }
    
    var_f0d5d1d9023b649a = function_4d91a4618b9a4e05( player, &function_3c88046be2a6c11b );
    
    if ( !isdefined( var_f0d5d1d9023b649a ) )
    {
        var_f0d5d1d9023b649a = function_4d91a4618b9a4e05( player );
    }
    
    if ( isdefined( var_f0d5d1d9023b649a ) )
    {
        var_7a8312ed07be51e1 = var_f0d5d1d9023b649a.id;
        var_988f5a884102e768 = player function_d0ab7745c02373ea();
        
        if ( var_7a8312ed07be51e1 != var_988f5a884102e768 )
        {
            function_61357ba7bfe9177d( player, var_f0d5d1d9023b649a );
        }
    }
    
    activity_definition_utils::function_f3faf60f17dfa84e( player );
}

// Namespace activity_player_common
// Params 1
// Checksum 0x9056e129, Offset: 0x7fb
// Size: 0x30, Type: bool
function function_c86afeac9d8e3a20( player )
{
    if ( activity_common::function_8fe1a47c40904418( 1 ) )
    {
        var_10caf36a3e4735d8 = player function_d0ab7745c02373ea();
        return isdefined( var_10caf36a3e4735d8 );
    }
    
    return false;
}

// Namespace activity_player_common
// Params 2
// Checksum 0xa4d32d36, Offset: 0x834
// Size: 0x48
function function_cfe457fffc399834( player, activityinstance )
{
    if ( activity_common::function_8fe1a47c40904418( 1 ) )
    {
        var_10caf36a3e4735d8 = player function_d0ab7745c02373ea();
        return ( var_10caf36a3e4735d8 == activityinstance.id );
    }
    
    return 0;
}

// Namespace activity_player_common
// Params 2
// Checksum 0xc60d9f, Offset: 0x884
// Size: 0x71, Type: bool
function function_ea1e42420617891c( player, activitytype )
{
    if ( activity_common::function_8fe1a47c40904418( 1 ) )
    {
        var_988f5a884102e768 = player function_d0ab7745c02373ea();
        
        if ( isdefined( var_988f5a884102e768 ) )
        {
            var_129646c41fa9ce9d = level.activities.instances[ var_988f5a884102e768 ];
            return ( isdefined( var_129646c41fa9ce9d ) && var_129646c41fa9ce9d.type == activitytype );
        }
    }
    
    return false;
}

// Namespace activity_player_common
// Params 1
// Checksum 0x21adc2d3, Offset: 0x8fe
// Size: 0x45
function function_2e7308ddfab5092b( player )
{
    if ( activity_common::function_8fe1a47c40904418( 1 ) )
    {
        oldinstance = function_e811448130016c90( player );
        
        if ( isdefined( oldinstance ) )
        {
            function_20c6baaecc72ce61( player, oldinstance );
        }
        
        player function_5c20943dfb3553f2( undefined );
    }
}

// Namespace activity_player_common
// Params 2
// Checksum 0x1c9e9d24, Offset: 0x94b
// Size: 0x4f
function function_1960a1b711afa75d( player, activityinstance )
{
    if ( isdefined( level.activities.nexusoverrides[ 6 ] ) )
    {
        return activity_common::function_2ba08ba0c0544a1a( 6, [ activityinstance, player ], 0 );
    }
    
    return function_1e14fab5ff9fc461( player, activityinstance );
}

// Namespace activity_player_common
// Params 2
// Checksum 0x38a09dbe, Offset: 0x9a3
// Size: 0x3f
function function_20c6baaecc72ce61( player, activityinstance )
{
    activityinstance namespace_49c2d747a467dc5f::function_4438b88dbb95b69d( player );
    activityinstance activity_player_broadcasting::function_188434aa0a77d1af( [ player ] );
    activityinstance activity_ui::function_9b636510b59558bf( [ player ] );
}

// Namespace activity_player_common
// Params 2
// Checksum 0x964e4141, Offset: 0x9ea
// Size: 0x3f
function function_436fea445dc2ab9d( player, activityinstance )
{
    activityinstance activity_player_broadcasting::function_400c462d24b8f61( [ player ] );
    activityinstance namespace_49c2d747a467dc5f::function_12b8e5d644d86f4e( player );
    activityinstance activity_ui::function_14f2860d96cf2c0f( [ player ] );
}

// Namespace activity_player_common
// Params 1
// Checksum 0xa974c656, Offset: 0xa31
// Size: 0x2b
function function_f2a52859f0878e78( player )
{
    var_502a5f74699d2293 = function_ef912bdece1bc4ef( player );
    return var_502a5f74699d2293.completedactivities;
}

// Namespace activity_player_common
// Params 1
// Checksum 0xa296960a, Offset: 0xa65
// Size: 0x48
function function_e811448130016c90( player )
{
    if ( activity_common::function_8fe1a47c40904418( 1 ) )
    {
        focusedactivityid = player function_d0ab7745c02373ea();
        
        if ( isdefined( focusedactivityid ) )
        {
            return level.activities.instances[ focusedactivityid ];
        }
    }
}

// Namespace activity_player_common
// Params 2
// Checksum 0xce342016, Offset: 0xab6
// Size: 0xc2
function function_998dd43a8f736345( player, activityinstance )
{
    completedactivityinfo = spawnstruct();
    var_502a5f74699d2293 = function_ef912bdece1bc4ef( player );
    var_502a5f74699d2293.completedactivities[ var_502a5f74699d2293.completedactivities.size ] = completedactivityinfo;
    completedactivityinfo.success = activity_instance_common::function_6bb0be4a3940d6e3( activityinstance );
    completedactivityinfo.activitytype = activityinstance.type;
    completedactivityinfo.varianttag = activityinstance.varianttag;
    completedactivityinfo.difficulty = activityinstance.difficulty_region;
    completedactivityinfo.category = activityinstance.category;
}

// Namespace activity_player_common
// Params 2
// Checksum 0x47a7f45f, Offset: 0xb80
// Size: 0x67
function function_b7c78b50ec8b1f64( player, params )
{
    assert( params.size == 1 && isdefined( params[ 0 ] ), "<dev string:x58>" );
    activityinstance = params[ 0 ];
    
    if ( !activity_common::function_8fe1a47c40904418( 1 ) )
    {
        return 1;
    }
    
    var_9486b7b8229d6ee8 = function_cfe457fffc399834( player, activityinstance );
    return var_9486b7b8229d6ee8;
}

// Namespace activity_player_common
// Params 2
// Checksum 0x2b8b66c2, Offset: 0xbef
// Size: 0x6e, Type: bool
function function_a5abbbd5e6dac189( player, params )
{
    assert( params.size == 1 && isdefined( params[ 0 ] ), "<dev string:x58>" );
    activityinstance = params[ 0 ];
    var_9486b7b8229d6ee8 = function_cfe457fffc399834( player, activityinstance );
    var_4225ad9dc4496a7c = isdefined( player function_d0ab7745c02373ea() );
    return var_9486b7b8229d6ee8 || !var_4225ad9dc4496a7c;
}

// Namespace activity_player_common
// Params 2
// Checksum 0x1667694c, Offset: 0xc66
// Size: 0x76
function function_b8ce206806d98976( player, params )
{
    assert( isarray( params ) && params.size == 1 && isnumber( params[ 0 ] ), "<dev string:xbb>" );
    playerfocuscountdowntimer = params[ 0 ];
    var_ac2ad41423a28bd2 = player function_d3a790c439439c67();
    var_e4ed7aee01561038 = !isdefined( var_ac2ad41423a28bd2 ) || var_ac2ad41423a28bd2 > playerfocuscountdowntimer;
    return var_e4ed7aee01561038;
}

// Namespace activity_player_common
// Params 2
// Checksum 0x67f0816b, Offset: 0xce5
// Size: 0x30, Type: bool
function function_4991abc5e15f6b5e( player, params )
{
    var_72c760b239114bf7 = isdefined( player.var_50f741a14f09a6 );
    return !var_72c760b239114bf7;
}

// Namespace activity_player_common
// Params 2
// Checksum 0xb7264a6a, Offset: 0xd1e
// Size: 0x1b
function function_a8e2e37e992cbd07( player, params )
{
    return isplayer( player );
}

// Namespace activity_player_common
// Params 2
// Checksum 0x6429e447, Offset: 0xd42
// Size: 0x60, Type: bool
function function_9c9b820cfe15a80a( player, activityinstance )
{
    instanceid = activityinstance.id;
    var_ccc91d79bfa22c3a = activity_participation::function_e8eabd79cc49540e( player );
    activityinfostruct = var_ccc91d79bfa22c3a[ instanceid ];
    
    if ( isdefined( activityinfostruct ) )
    {
        return istrue( activityinfostruct.currentlyabandoning );
    }
    
    return false;
}

// Namespace activity_player_common
// Params 2
// Checksum 0xecce7d43, Offset: 0xdab
// Size: 0x60
function function_7dd92a1f01ccc6e9( player, activityinstance )
{
    instanceid = activityinstance.id;
    var_ccc91d79bfa22c3a = activity_participation::function_e8eabd79cc49540e( player );
    activityinfostruct = var_ccc91d79bfa22c3a[ instanceid ];
    
    if ( isdefined( activityinfostruct ) )
    {
        activityinfostruct.currentlyabandoning = 1;
    }
}

// Namespace activity_player_common
// Params 2
// Checksum 0xc70931f1, Offset: 0xe13
// Size: 0x5f
function function_fd5dfb647d6fbc16( player, activityinstance )
{
    instanceid = activityinstance.id;
    var_ccc91d79bfa22c3a = activity_participation::function_e8eabd79cc49540e( player );
    activityinfostruct = var_ccc91d79bfa22c3a[ instanceid ];
    
    if ( isdefined( activityinfostruct ) )
    {
        activityinfostruct.currentlyabandoning = 0;
    }
}

// Namespace activity_player_common
// Params 5
// Checksum 0x199a3f39, Offset: 0xe7a
// Size: 0x151
function function_674cca638cafcae3( players, activityinstance, omnvar, value, resetvalue )
{
    if ( !isdefined( value ) )
    {
        /#
            namespace_634561435cfb3169::activitynexuslog( "<dev string:x110>" + omnvar + "<dev string:x137>", @"hash_22e4e38cab273e93", activityinstance, players );
        #/
        
        return;
    }
    
    activityid = activityinstance.id;
    
    foreach ( player in players )
    {
        var_76ef9abea109c872 = function_4d91a4618b9a4e05( player, &activity_definition_utils::function_a0de4120bd59665 ).id;
        focusedactivityid = function_e811448130016c90( player ).id;
        
        if ( activityid == var_76ef9abea109c872 || activityid == focusedactivityid || getdvarint( @"hash_502b93ffa6355f97", 1 ) )
        {
            player omnvar_utility::setcachedclientomnvar( omnvar, value );
        }
    }
    
    activity_instance_common::function_dde540f74dc06621( activityinstance, omnvar, value, resetvalue );
}

// Namespace activity_player_common
// Params 5
// Checksum 0xf39236e2, Offset: 0xfd3
// Size: 0xf0
function function_38557fdfe48344e2( player, activityinstance, omnvar, value, resetvalue )
{
    if ( !isdefined( value ) )
    {
        /#
            namespace_634561435cfb3169::activitynexuslog( "<dev string:x110>" + omnvar + "<dev string:x137>", @"hash_22e4e38cab273e93", activityinstance, [ player ] );
        #/
        
        return;
    }
    
    activityid = activityinstance.id;
    var_76ef9abea109c872 = function_4d91a4618b9a4e05( player, &activity_definition_utils::function_a0de4120bd59665 ).id;
    focusedactivityid = function_e811448130016c90( player ).id;
    
    if ( activityid == var_76ef9abea109c872 || activityid == focusedactivityid || getdvarint( @"hash_502b93ffa6355f97", 1 ) )
    {
        player omnvar_utility::setcachedclientomnvar( omnvar, value );
    }
    
    activity_instance_common::function_dde540f74dc06621( activityinstance, omnvar, value, resetvalue );
}

// Namespace activity_player_common
// Params 2
// Checksum 0x187768b4, Offset: 0x10cb
// Size: 0x105, Type: bool
function function_a4d7e63988b570a7( player, params )
{
    assert( params.size == 1, "<dev string:x152>" );
    activityinstance = params[ 0 ];
    activityinstancecategory = activityinstance.category;
    var_ccc91d79bfa22c3a = activity_participation::function_e8eabd79cc49540e( player );
    
    foreach ( instanceid, var_109d60f71f42acad in var_ccc91d79bfa22c3a )
    {
        participatinginstance = level.activities.instances[ instanceid ];
        var_6a585d8c29adf176 = participatinginstance.category;
        
        if ( var_6a585d8c29adf176 == activityinstancecategory )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace activity_player_common
// Params 0, eflags: 0x4
// Checksum 0xf810fd61, Offset: 0x11d9
// Size: 0x4f
function private function_94a02052a73127eb()
{
    playeractivitydata = spawnstruct();
    playeractivitydata.participatingactivities = [];
    playeractivitydata.completedactivities = [];
    playeractivitydata.focusedactivityid = undefined;
    playeractivitydata.var_c9b2ba03323b2baa = undefined;
    playeractivitydata.var_ec35f87299d3788 = undefined;
    return playeractivitydata;
}

// Namespace activity_player_common
// Params 1, eflags: 0x4
// Checksum 0xc8e0e07f, Offset: 0x1231
// Size: 0x3e
function private function_c00388453e7dc3aa( params )
{
    function_ecea5c2a0aaa9c90( self );
    callback::add( #"player_spawned", &_onplayerspawned );
    callback::add( #"player_disconnect", &function_f9e41a4119386314 );
}

// Namespace activity_player_common
// Params 1, eflags: 0x4
// Checksum 0x74ec107c, Offset: 0x1277
// Size: 0x151
function private _onplayerdeath( params )
{
    player = self;
    activityinstancestoend = [];
    var_e287da7b36de07d7 = activity_participation::function_e8eabd79cc49540e( player );
    
    foreach ( instanceid, instanceinfostruct in var_e287da7b36de07d7 )
    {
        activityinstance = level.activities.instances[ instanceid ];
        
        if ( isdefined( activityinstance ) )
        {
            activityinstance notify( #"activity_player_died", player );
            
            if ( activity_definition_utils::function_65a59cc724e4ec89( activityinstance, 1 ) )
            {
                activityinstancestoend[ activityinstancestoend.size ] = activityinstance;
            }
        }
    }
    
    foreach ( activityinstance in activityinstancestoend )
    {
        activity_participation::function_267e1d48764a0750( activityinstance, player, 1 );
    }
}

// Namespace activity_player_common
// Params 1, eflags: 0x4
// Checksum 0xff923659, Offset: 0x13d0
// Size: 0x45
function private _onplayerspawned( params )
{
    player = self;
    
    if ( isdefined( level.activities.nexusoverrides[ 5 ] ) )
    {
        activity_common::function_2ba08ba0c0544a1a( 5, [ player ], 1 );
    }
}

// Namespace activity_player_common
// Params 1, eflags: 0x4
// Checksum 0xee3be9ce, Offset: 0x141d
// Size: 0x159
function private function_f9e41a4119386314( params )
{
    player = self;
    
    if ( !isdefined( player ) )
    {
        foreach ( instance in level.activities.instances )
        {
            instance.playerparticipants = function_5713d46873b29625( instance.playerparticipants );
        }
        
        return;
    }
    
    var_ccc91d79bfa22c3a = activity_participation::function_e8eabd79cc49540e( player );
    
    foreach ( instanceid, activityinfostruct in var_ccc91d79bfa22c3a )
    {
        activityinstance = level.activities.instances[ instanceid ];
        activity_participation::function_61aa2b2879f2c0a2( activityinstance, player );
    }
}

// Namespace activity_player_common
// Params 0, eflags: 0x4
// Checksum 0xfc1a4497, Offset: 0x157e
// Size: 0x20
function private function_d0ab7745c02373ea()
{
    var_502a5f74699d2293 = function_ef912bdece1bc4ef( self );
    return var_502a5f74699d2293.focusedactivityid;
}

// Namespace activity_player_common
// Params 0, eflags: 0x4
// Checksum 0x7a70f032, Offset: 0x15a7
// Size: 0x46
function private function_d3a790c439439c67()
{
    var_502a5f74699d2293 = function_ef912bdece1bc4ef( self );
    
    if ( !isdefined( var_502a5f74699d2293.var_c9b2ba03323b2baa ) )
    {
        return;
    }
    
    currenttimeinseconds = gettime() / 1000;
    return currenttimeinseconds - var_502a5f74699d2293.var_c9b2ba03323b2baa;
}

// Namespace activity_player_common
// Params 1, eflags: 0x4
// Checksum 0x7fd956a5, Offset: 0x15f6
// Size: 0x6c
function private function_32c04a849a1c0b00( activityinstance )
{
    player = self;
    instanceid = activityinstance.id;
    player function_5c20943dfb3553f2( instanceid );
    var_ccc91d79bfa22c3a = activity_participation::function_e8eabd79cc49540e( player );
    var_7dc2e516d704aaa3 = var_ccc91d79bfa22c3a[ instanceid ];
    
    if ( isdefined( var_7dc2e516d704aaa3 ) )
    {
        var_7dc2e516d704aaa3.var_c1037ce8aa4e3ba8 = 1;
    }
}

// Namespace activity_player_common
// Params 1, eflags: 0x4
// Checksum 0x46a2a6ed, Offset: 0x166a
// Size: 0x41
function private function_5c20943dfb3553f2( id )
{
    var_502a5f74699d2293 = function_ef912bdece1bc4ef( self );
    var_502a5f74699d2293.focusedactivityid = id;
    var_502a5f74699d2293.var_c9b2ba03323b2baa = gettime() / 1000;
}

// Namespace activity_player_common
// Params 2
// Checksum 0xbfdc3a25, Offset: 0x16b3
// Size: 0x14c
function function_4d91a4618b9a4e05( player, filterfunc )
{
    var_73e202c78e2deec5 = -1;
    var_ac5070e2495ab18c = [];
    var_ccc91d79bfa22c3a = activity_participation::function_e8eabd79cc49540e( player );
    
    foreach ( instanceid, activityinfostruct in var_ccc91d79bfa22c3a )
    {
        var_49a12bdc8783683b = level.activities.instances[ instanceid ];
        var_eb0305cd5f0fe90d = function_1960a1b711afa75d( player, var_49a12bdc8783683b );
        
        if ( filterfunc && [[ filterfunc ]]( var_49a12bdc8783683b ) )
        {
            continue;
        }
        
        if ( var_eb0305cd5f0fe90d > var_73e202c78e2deec5 )
        {
            var_73e202c78e2deec5 = var_eb0305cd5f0fe90d;
            var_ac5070e2495ab18c = [ var_49a12bdc8783683b ];
            continue;
        }
        
        if ( var_eb0305cd5f0fe90d == var_73e202c78e2deec5 )
        {
            var_ac5070e2495ab18c[ var_ac5070e2495ab18c.size ] = var_49a12bdc8783683b;
        }
    }
    
    var_6e4fc2322a525f3 = undefined;
    
    if ( var_ac5070e2495ab18c.size == 1 )
    {
        var_6e4fc2322a525f3 = var_ac5070e2495ab18c[ 0 ];
    }
    else if ( var_ac5070e2495ab18c.size > 1 )
    {
        var_6e4fc2322a525f3 = activity_common::function_3eba33db536a1da6( player.origin, var_ac5070e2495ab18c );
    }
    
    return var_6e4fc2322a525f3;
}

// Namespace activity_player_common
// Params 2, eflags: 0x4
// Checksum 0x309e430e, Offset: 0x1808
// Size: 0x112
function private function_1e14fab5ff9fc461( player, activityinstance )
{
    var_336ea060892948ee = 10;
    var_603307371beca1f5 = 1;
    var_7f320c34b9c9b070 = 0;
    var_7f3842593aa37d1d = activityinstance.var_c01a5323cc5fc8c0;
    var_7f320c34b9c9b070 += var_7f3842593aa37d1d * var_336ea060892948ee;
    var_d1728f088ba862c1 = activityinstance.id;
    var_ccc91d79bfa22c3a = activity_participation::function_e8eabd79cc49540e( player );
    var_7f456246b2755d41 = 0;
    var_90567a4d45894d61 = var_ccc91d79bfa22c3a[ var_d1728f088ba862c1 ];
    
    if ( isdefined( var_90567a4d45894d61 ) )
    {
        playerjoinreason = var_90567a4d45894d61.joinreason;
        
        if ( playerjoinreason == "PlayerJoinedInteract" || playerjoinreason == "PlayerJoinedOther" )
        {
            var_7f456246b2755d41 = 10;
        }
        else if ( playerjoinreason == "PlayerJoinedDamage" || playerjoinreason == "PlayerJoinedSquad" )
        {
            var_7f456246b2755d41 = 6;
        }
        else if ( playerjoinreason == "PlayerJoinedProximity" )
        {
            var_7f456246b2755d41 = 4;
        }
        else
        {
            var_7f456246b2755d41 = 5;
        }
    }
    
    var_7f320c34b9c9b070 += var_7f456246b2755d41 * var_603307371beca1f5;
    return var_7f320c34b9c9b070;
}

// Namespace activity_player_common
// Params 2, eflags: 0x4
// Checksum 0x56c73809, Offset: 0x1923
// Size: 0x41
function private function_7fca538261c8b079( player, playerarraykey )
{
    var_173abe592dbebc0f = self;
    
    if ( conditional_container::function_33051347e9187361( var_173abe592dbebc0f.var_be6d32d0af4abdc8, player ) )
    {
        function_958e5ad8050bb4c9( player );
    }
}

// Namespace activity_player_common
// Params 1, eflags: 0x4
// Checksum 0x33085d2b, Offset: 0x196c
// Size: 0x289
function private function_d71e948fd9f2e5de( relevantinfostruct )
{
    activityinstance = self;
    playerlist = relevantinfostruct.playerlist;
    
    foreach ( player in playerlist )
    {
        if ( activity_common::function_8fe1a47c40904418( 1 ) )
        {
            function_958e5ad8050bb4c9( player );
        }
        else
        {
            function_436fea445dc2ab9d( player, activityinstance );
        }
        
        activity_definition_utils::function_f3faf60f17dfa84e( player );
        var_e287da7b36de07d7 = activity_participation::function_e8eabd79cc49540e( player );
        
        foreach ( instanceid, instanceinfostruct in var_e287da7b36de07d7 )
        {
            if ( instanceid != activityinstance.id )
            {
                var_d1c368a4952536e = level.activities.instances[ instanceid ];
                
                if ( activity_definition_utils::function_65a59cc724e4ec89( var_d1c368a4952536e, 3 ) )
                {
                    var_f393956a4ef608b5 = activity_definition_utils::function_ac11e0fa8d55a478( var_d1c368a4952536e, 3 );
                    
                    if ( var_f393956a4ef608b5.var_350ba18db76d6b42 || var_f393956a4ef608b5.var_255c20a42eb5bb75 && activityinstance.type == var_d1c368a4952536e.type || var_f393956a4ef608b5.var_8beddde520991689 && activityinstance.category == var_d1c368a4952536e.category )
                    {
                        activity_participation::function_267e1d48764a0750( var_d1c368a4952536e, player, 3 );
                    }
                }
            }
        }
    }
    
    instid = activityinstance.id;
    activitystate = activityinstance.state;
    var_99fc92632e8e4de0 = activitystate == "Ended" || activitystate == "Cleanup";
    
    if ( activityinstance.playerparticipants.size == 0 && !var_99fc92632e8e4de0 )
    {
        level.activities.var_d520b27efd9742e5[ instid ] = activityinstance;
        return;
    }
    
    level.activities.var_d520b27efd9742e5[ instid ] = undefined;
}

// Namespace activity_player_common
// Params 1, eflags: 0x4
// Checksum 0x6736cda1, Offset: 0x1bfd
// Size: 0x18f
function private function_1bc8e088822a307e( relevantinfostruct )
{
    activityinstance = self;
    playerlist = relevantinfostruct.playerlist;
    currentstate = activityinstance.state;
    
    foreach ( player in playerlist )
    {
        if ( activity_common::function_8fe1a47c40904418( 1 ) )
        {
            if ( function_cfe457fffc399834( player, activityinstance ) )
            {
                function_2e7308ddfab5092b( player );
                function_958e5ad8050bb4c9( player );
            }
        }
        else
        {
            function_20c6baaecc72ce61( player, activityinstance );
        }
        
        activity_definition_utils::function_f3faf60f17dfa84e( player );
        
        if ( currentstate == "Ended" )
        {
            function_998dd43a8f736345( player, activityinstance );
        }
    }
    
    instid = activityinstance.id;
    activitystate = activityinstance.state;
    var_99fc92632e8e4de0 = activitystate == "Ended" || activitystate == "Cleanup";
    
    if ( activityinstance.playerparticipants.size == 0 && !var_99fc92632e8e4de0 )
    {
        level.activities.var_d520b27efd9742e5[ instid ] = activityinstance;
        return;
    }
    
    level.activities.var_d520b27efd9742e5[ instid ] = undefined;
}

