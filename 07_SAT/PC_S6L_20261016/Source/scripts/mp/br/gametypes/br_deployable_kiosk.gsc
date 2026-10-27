// scripts\mp\br\gametypes\br_deployable_kiosk.gsc  (hash_0b548cb1b912a827.gscc) (size: 16155 Bytes / 0x3f1b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8aa2a006 (2325913606)
// size ...... 16155 (0x3f1b)
// includes .. 24  (offset: 0x3c37)
// strings ... 41  (offset: 0x3cf7)
// dev strs .. 1   (offset: 0x3f0f)
// exports ... 45  (offset: 0x28b7)
// cseg ...... 0x3d8 + 0x24df (0x28b7)
// imports ... 104 (offset: 0x2fbf)
// animtree1 . 0   (offset: 0x3f1b)
// animtree2 . 0   (offset: 0x3f1b)
#using script_16ea1b94f0f381b3;
#using scripts\common\ae_utility;
#using scripts\common\script;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\airdrop_scriptbundle;
#using scripts\mp\br\gametypes\br_armory_kiosk;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_exclusion_zone;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_publicevents;
#using scripts\mp\br\gametypes\br_redeploy_drone;
#using scripts\mp\challenges;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\currency;
#using scripts\mp\hud_message;
#using scripts\mp\loot\common_kiosk;
#using scripts\mp\outofbounds;
#using scripts\mp\supers;
#using scripts\mp\weapons;

#namespace br_deployable_kiosk;

// Namespace br_deployable_kiosk
// Params 0, eflags: 0x5
// Checksum 0xbb3d7baf, Offset: 0x3f6
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"br_deployable_kiosk", undefined, undefined, &post_main );
}

// Namespace br_deployable_kiosk
// Params 0
// Checksum 0xf7d5212a, Offset: 0x417
// Size: 0x41
function post_main()
{
    /#
        if ( isofflinetoolrun( 31 ) )
        {
            return;
        }
    #/
    
    if ( !getdvarint( @"scr_br_deployable_kiosk_enabled", 1 ) )
    {
        return;
    }
    
    if ( !isbrgamemode() )
    {
        return;
    }
    
    initdeployablekiosk();
    function_1b5a4c5469c7f668();
    thread initializeairdrop();
}

// Namespace br_deployable_kiosk
// Params 0
// Checksum 0xf9fb59ee, Offset: 0x460
// Size: 0x199
function initdeployablekiosk()
{
    br_redeploy_drone::initvariables();
    scriptable::scriptable_addusedcallback( &deployablekioskused );
    level.deployablekiosks = spawnstruct();
    level.deployablekiosks.var_745b422219e67eeb = getdvarint( @"hash_7d6d2cb2d139a844", 5 );
    level.deployablekiosks.buystations = [];
    level.deployablekiosks.var_ead68225b02d1935 = getdvarint( @"hash_37c837989177c57c", 7 );
    level.deployablekiosks.var_c41faf9ad9c61181 = getdvarint( @"hash_83b158696cbcbcfd", 0 ) == 1;
    level.deployablekiosks.var_c69cdd1baa75e2ac = getdvarint( @"hash_3e56c6bbb230d4cd", 4000 );
    level.deployablekiosks.var_fe3437bbc52ad866 = getdvarint( @"hash_20375e1dd455ac75", 0 );
    level.deployablekiosks.var_e253c9f921155d75 = getdvarint( @"hash_2b642e46a41d6d73", 0 );
    level.deployablekiosks.var_5bf6f7f59364efc8 = { #targets:[], #var_b67307bc31d9e86f:1 };
    weapons::registerusedcallback( #"hash_5d2751f016a281df", &function_37a10a66c4282777 );
    br_circle::registercirclecallbacks( 15, &dangercircletick_deployablekiosk, &function_e2392f7910fae24e, &enabledeployablekiosk, &function_a59453e63a9bc44e );
    
    if ( getdvarint( @"hash_ad4aed3730427bc5", 1 ) )
    {
        level thread function_fd9b4fce6e78327a();
    }
    
    level._effect[ "deployable_kiosk_explosion" ] = loadfxasset( "vfx_iw9_prop_script_military_deployable_buystation" );
}

// Namespace br_deployable_kiosk
// Params 0
// Checksum 0x9eb84c07, Offset: 0x601
// Size: 0x4b
function function_1b5a4c5469c7f668()
{
    assert( isdefined( game[ "<dev string:x24>" ] ) );
    game[ "dialog" ][ "deploy_ready" ] = "dplb_wzan_redy";
    game[ "dialog" ][ "enemy_active" ] = "dplb_wzan_nmy1";
    game[ "dialog" ][ "friendly_active" ] = "dplb_wzan_frnd";
}

// Namespace br_deployable_kiosk
// Params 0, eflags: 0x4
// Checksum 0xaf11368e, Offset: 0x654
// Size: 0x4f
function private initializeairdrop()
{
    utility::flag_wait( "loadEquipmentBundles_finished" );
    var_e89972838ed5fbcf = level.equipment.table[ "equip_deployable_kiosk_drop" ].bundle;
    function_1cc0e3b19bbe480c( var_e89972838ed5fbcf.airdrop );
}

// Namespace br_deployable_kiosk
// Params 1
// Checksum 0x2b4789a1, Offset: 0x6ab
// Size: 0xc7
function function_1cc0e3b19bbe480c( airdropname )
{
    airdrop_scriptbundle::registerairdrop( airdropname );
    utility::flag_wait( "airdrop_init_crate_data" );
    var_ba6814cd47c33a25 = airdrop::getleveldata( airdropname );
    var_ba6814cd47c33a25.hasnointeraction = 1;
    var_ba6814cd47c33a25.capturevisualsdeletiondelay = 1.4;
    airdrop_scriptbundle::function_eeb87fc1f31bec35( airdropname, #"cratedestroyfunc", &function_741b9abec1a3b9e );
    airdrop_scriptbundle::function_eeb87fc1f31bec35( airdropname, #"crateactivatefunc", &activatedeployablekiosk );
    airdrop_scriptbundle::function_eeb87fc1f31bec35( airdropname, #"hash_f35f0e2b6123474f", &function_5dce73d456f8ba69 );
    airdrop_scriptbundle::function_eeb87fc1f31bec35( airdropname, #"hash_cb68d69fe85eb56f", &function_6e9d8ba6cb62d8d7 );
    airdrop_scriptbundle::function_eeb87fc1f31bec35( airdropname, #"hash_e9a6accd033eb4b9", &function_14371b8d475c62ca );
}

// Namespace br_deployable_kiosk
// Params 3
// Checksum 0xa0cc0f32, Offset: 0x77a
// Size: 0xf8
function function_4ea13304e302cf2a( origin, angles = ( 0, 0, 0 ), var_8b674cd588a0201c = undefined )
{
    targetstate = function_426cf7998a7f00d8();
    function_b9829f8c2dbaab91();
    target = { #var_8b674cd588a0201c:var_8b674cd588a0201c, #kiosk:undefined, #cancelled:0, #failed:0, #var_9aaebddcbd952541:1, #followentity:undefined, #angles:angles, #origin:origin, #targetid:targetstate.var_b67307bc31d9e86f };
    targetstate.var_b67307bc31d9e86f++;
    targetstate.targets[ targetstate.targets.size ] = target;
    return target.targetid;
}

// Namespace br_deployable_kiosk
// Params 2
// Checksum 0x8755337b, Offset: 0x87b
// Size: 0x64
function function_3b2eefd0e491e3cd( targetid, followentity )
{
    if ( !isdefined( targetid ) || !function_cf1e5789ca979453( followentity ) )
    {
        return;
    }
    
    target = function_3cf3d8098e05c9d7( targetid );
    
    if ( !isdefined( target ) || !target.var_9aaebddcbd952541 )
    {
        return;
    }
    
    target.followentity = followentity;
}

// Namespace br_deployable_kiosk
// Params 2
// Checksum 0xbb7f50, Offset: 0x8e7
// Size: 0xb8
function function_89d9b01a8deaecf7( targetid, kiosk )
{
    if ( !( isdefined( targetid ) && isdefined( kiosk ) ) )
    {
        return;
    }
    
    target = function_3cf3d8098e05c9d7( targetid );
    
    if ( !isdefined( target ) )
    {
        return;
    }
    
    target.kiosk = kiosk;
    target.origin = kiosk.origin;
    target.angles = kiosk.angles;
    target.followentity = undefined;
    target.var_9aaebddcbd952541 = 0;
    target.failed = 0;
    target.cancelled = 0;
    target.var_8b674cd588a0201c = undefined;
}

// Namespace br_deployable_kiosk
// Params 1
// Checksum 0x4bc1812c, Offset: 0x9a7
// Size: 0x64
function function_8ae7bc4f3e1e982f( targetid )
{
    target = function_3cf3d8098e05c9d7( targetid );
    
    if ( !isdefined( target ) )
    {
        return;
    }
    
    target.failed = 1;
    target.cancelled = 0;
    target.kiosk = undefined;
    target.followentity = undefined;
    target.var_8b674cd588a0201c = undefined;
}

// Namespace br_deployable_kiosk
// Params 1
// Checksum 0x9ef1f5fb, Offset: 0xa13
// Size: 0x64
function function_27d286fdbdd37401( targetid )
{
    target = function_3cf3d8098e05c9d7( targetid );
    
    if ( !isdefined( target ) )
    {
        return;
    }
    
    target.failed = 0;
    target.cancelled = 1;
    target.kiosk = undefined;
    target.followentity = undefined;
    target.var_8b674cd588a0201c = undefined;
}

// Namespace br_deployable_kiosk
// Params 1
// Checksum 0xeafa4539, Offset: 0xa7f
// Size: 0x6e
function function_723054718bc154a5( targetid )
{
    target = function_3cf3d8098e05c9d7( targetid );
    
    if ( !isdefined( target ) || !target.var_9aaebddcbd952541 || function_5755bf1594da64df( target ) || !isdefined( target.var_8b674cd588a0201c ) )
    {
        return 0;
    }
    
    return [[ target.var_8b674cd588a0201c ]]( target.targetid );
}

// Namespace br_deployable_kiosk
// Params 1
// Checksum 0xe7a08a4f, Offset: 0xaf6
// Size: 0x121
function function_3cf3d8098e05c9d7( targetid )
{
    if ( !isdefined( targetid ) )
    {
        return;
    }
    
    function_b9829f8c2dbaab91();
    targetstate = function_426cf7998a7f00d8();
    
    foreach ( target in targetstate.targets )
    {
        if ( target.targetid != targetid )
        {
            continue;
        }
        
        if ( target.var_9aaebddcbd952541 )
        {
            function_bd538bde8157c992( target );
            return target;
        }
        
        if ( !isdefined( target.kiosk ) )
        {
            return;
        }
        
        target.origin = target.kiosk.origin;
        target.angles = target.kiosk.angles;
        return target;
    }
}

// Namespace br_deployable_kiosk
// Params 1
// Checksum 0x5e0ad413, Offset: 0xc20
// Size: 0xe8
function function_2fb4258a6b28de5d( var_aa490f87dc0f5c1b = 1 )
{
    pendingtargets = [];
    function_b9829f8c2dbaab91();
    targetstate = function_426cf7998a7f00d8();
    
    foreach ( target in targetstate.targets )
    {
        if ( !target.var_9aaebddcbd952541 || target.failed )
        {
            continue;
        }
        
        if ( var_aa490f87dc0f5c1b && !function_5755bf1594da64df( target ) )
        {
            continue;
        }
        
        pendingtargets[ pendingtargets.size ] = target;
    }
    
    return pendingtargets;
}

// Namespace br_deployable_kiosk
// Params 0
// Checksum 0x9741eec1, Offset: 0xd11
// Size: 0x116
function function_4fc195ced6b34583()
{
    activetargets = [];
    
    if ( !isdefined( level.deployablekiosks.buystations ) )
    {
        return activetargets;
    }
    
    foreach ( kiosk in level.deployablekiosks.buystations )
    {
        if ( !function_89cad7b93fb573d4( kiosk ) )
        {
            continue;
        }
        
        activetarget = { #targetid:kiosk.var_60de57e0dd65d20a, #kiosk:kiosk, #var_9aaebddcbd952541:0, #angles:kiosk.angles, #origin:kiosk.origin };
        activetargets[ activetargets.size ] = activetarget;
    }
    
    return activetargets;
}

// Namespace br_deployable_kiosk
// Params 1
// Checksum 0x54ef3d81, Offset: 0xe30
// Size: 0x40, Type: bool
function function_89cad7b93fb573d4( kiosk )
{
    if ( !isdefined( kiosk ) || !kiosk.var_ea4a540642460712 )
    {
        return false;
    }
    
    return kiosk.isinteractable && !kiosk.b_force_disabled;
}

// Namespace br_deployable_kiosk
// Params 0, eflags: 0x4
// Checksum 0x1b82b3c9, Offset: 0xe79
// Size: 0x6e
function private function_426cf7998a7f00d8()
{
    if ( !isdefined( level.deployablekiosks ) )
    {
        level.deployablekiosks = spawnstruct();
    }
    
    if ( !isdefined( level.deployablekiosks.var_5bf6f7f59364efc8 ) )
    {
        level.deployablekiosks.var_5bf6f7f59364efc8 = { #targets:[], #var_b67307bc31d9e86f:1 };
    }
    
    return level.deployablekiosks.var_5bf6f7f59364efc8;
}

// Namespace br_deployable_kiosk
// Params 0, eflags: 0x4
// Checksum 0x5ca6ad14, Offset: 0xef0
// Size: 0xef
function private function_b9829f8c2dbaab91()
{
    targetstate = function_426cf7998a7f00d8();
    validtargets = [];
    
    foreach ( target in targetstate.targets )
    {
        if ( !isdefined( target ) || target.failed || target.cancelled )
        {
            continue;
        }
        
        if ( !target.var_9aaebddcbd952541 && !isdefined( target.kiosk ) )
        {
            continue;
        }
        
        validtargets[ validtargets.size ] = target;
    }
    
    targetstate.targets = validtargets;
}

// Namespace br_deployable_kiosk
// Params 1, eflags: 0x4
// Checksum 0xa691915d, Offset: 0xfe7
// Size: 0x18, Type: bool
function private function_cf1e5789ca979453( followentity )
{
    return isdefined( followentity.origin );
}

// Namespace br_deployable_kiosk
// Params 1, eflags: 0x4
// Checksum 0x3799af4c, Offset: 0x1008
// Size: 0x26, Type: bool
function private function_5755bf1594da64df( target )
{
    function_bd538bde8157c992( target );
    return function_cf1e5789ca979453( target.followentity );
}

// Namespace br_deployable_kiosk
// Params 1, eflags: 0x4
// Checksum 0x84b1523e, Offset: 0x1037
// Size: 0x4b
function private function_bd538bde8157c992( target )
{
    if ( function_cf1e5789ca979453( target.followentity.package ) )
    {
        target.followentity = target.followentity.package;
    }
}

// Namespace br_deployable_kiosk
// Params 6
// Checksum 0x371d2498, Offset: 0x108a
// Size: 0x14f
function deployablekioskused( instance, part, state, player, bautouse, usestring )
{
    kiosk = instance.entity ?? instance;
    
    if ( !kiosk.isdeployablekiosk )
    {
        return;
    }
    
    if ( kiosk.isemped )
    {
        player playlocalsound( "br_plunder_atm_cancel" );
        player hud_message::showerrormessage( %"MP_BR_INGAME/EMPED_DEPLOYABLE_KIOSK" );
        return;
    }
    
    if ( !kiosk.isinteractable )
    {
        player playlocalsound( "br_plunder_atm_cancel" );
        return;
    }
    
    if ( player.iszombie )
    {
        player playlocalsound( "br_plunder_atm_cancel" );
        return;
    }
    
    if ( !isdefined( instance.playersusing ) )
    {
        instance.playersusing = [];
    }
    
    instance.playersusing[ instance.playersusing.size ] = player;
    
    if ( utility::issharedfuncdefined( #"biometricscan", #"reportkeycardcount" ) )
    {
        [[ utility::getsharedfunc( #"biometricscan", #"reportkeycardcount" ) ]]( player );
    }
    
    instance.isdeployablekiosk = 1;
    player thread common_kiosk::_runpurchasemenu( instance );
}

// Namespace br_deployable_kiosk
// Params 6
// Checksum 0xd1f77821, Offset: 0x11e1
// Size: 0xe3
function deployablekioskspawn( player, location, fromevent, airdrop = undefined, var_599c89611404fc2d = undefined, var_60de57e0dd65d20a = undefined )
{
    overridestruct = { #droporigin:location };
    overridestruct.extradata = { #var_60de57e0dd65d20a:var_60de57e0dd65d20a, #iskiosk:1, #var_599c89611404fc2d:var_599c89611404fc2d, #fromevent:fromevent };
    
    if ( !isdefined( airdrop ) )
    {
        airdrop = level.equipment.table[ "equip_deployable_kiosk_drop" ].bundle.airdrop;
    }
    
    thread airdrop_scriptbundle::startairdrop( airdrop, player, undefined, overridestruct );
}

// Namespace br_deployable_kiosk
// Params 1
// Checksum 0x15ca6c, Offset: 0x12cc
// Size: 0x7f
function deployablekioskemp( data )
{
    disabledeployablekiosk();
    superbundle = level.superglobals.staticsuperdata[ "super_deployable_kiosk" ].bundle;
    
    if ( superbundle.var_127f49e33444be5a && superbundle.var_a20ca36a8d87ba8e )
    {
        data.time = superbundle.var_a20ca36a8d87ba8e;
    }
    
    thread br_armory_kiosk::function_61b87feb2e19416f( data );
}

// Namespace br_deployable_kiosk
// Params 0
// Checksum 0xe21c82f5, Offset: 0x1353
// Size: 0x254
function function_6ceb8e6acf7dfe70()
{
    buystation = self;
    
    if ( level.deployablekiosks.var_c41faf9ad9c61181 )
    {
        foreach ( deployablekiosk in level.deployablekiosks.buystations )
        {
            if ( deployablekiosk == buystation )
            {
                continue;
            }
            
            if ( deployablekiosk.var_ea4a540642460712 )
            {
                continue;
            }
            
            if ( !( isdefined( buystation.team ) && isdefined( deployablekiosk.team ) ) )
            {
                continue;
            }
            
            if ( buystation.team == deployablekiosk.team )
            {
                deployablekiosk thread deployablekioskremove();
            }
        }
    }
    
    var_d5f9285caa9e2b80 = 0;
    
    foreach ( dronebuystation in level.deployablekiosks.buystations )
    {
        if ( !isdefined( dronebuystation ) )
        {
            continue;
        }
        
        if ( dronebuystation.var_ea4a540642460712 )
        {
            continue;
        }
        
        var_d5f9285caa9e2b80++;
    }
    
    if ( var_d5f9285caa9e2b80 > level.deployablekiosks.var_ead68225b02d1935 )
    {
        foreach ( var_ab9a12de6502697 in level.deployablekiosks.buystations )
        {
            if ( !isdefined( var_ab9a12de6502697 ) || var_ab9a12de6502697.var_ea4a540642460712 )
            {
                continue;
            }
            
            var_ab9a12de6502697 thread deployablekioskremove();
            break;
        }
    }
}

// Namespace br_deployable_kiosk
// Params 3
// Checksum 0x41bd8801, Offset: 0x15af
// Size: 0x17b
function dangercircletick_deployablekiosk( dangercircleorigin, dangercircleradius, thresholdradius )
{
    if ( getdvarint( @"hash_271d21fb3081ae5f", 0 ) == 1 )
    {
        return;
    }
    
    if ( !isdefined( level.deployablekiosks.buystations ) )
    {
        return;
    }
    
    var_1bdc861911b3625e = dangercircleradius + level.var_ea96217a33eb6457;
    var_b37e42f15ca6902b = var_1bdc861911b3625e * var_1bdc861911b3625e;
    
    foreach ( deployablekiosk in level.deployablekiosks.buystations )
    {
        var_8b217f269a1d0c8d = !isdefined( deployablekiosk.deconeffectcount ) && exclusion_zones::function_1efc19de6199fff6( deployablekiosk.origin, 0, 0 ) == -1 && distance2dsquared( deployablekiosk.origin, dangercircleorigin ) + level.var_ea96217a33eb6457 > var_b37e42f15ca6902b;
        
        if ( deployablekiosk.isinteractable )
        {
            if ( var_8b217f269a1d0c8d )
            {
                deployablekiosk disabledeployablekiosk();
            }
            
            continue;
        }
        
        if ( !var_8b217f269a1d0c8d && !deployablekiosk.isemped )
        {
            enabledeployablekiosk( deployablekiosk );
        }
    }
}

// Namespace br_deployable_kiosk
// Params 3
// Checksum 0x87cb67cd, Offset: 0x1732
// Size: 0x171
function function_e2392f7910fae24e( dangercircleorigin, dangercircleradius, thresholdradius )
{
    if ( getdvarint( @"hash_271d21fb3081ae5f", 0 ) == 1 )
    {
        return;
    }
    
    if ( !isdefined( level.deployablekiosks.buystations ) )
    {
        return;
    }
    
    hiddenkiosks = [];
    
    foreach ( deployablekiosk in level.deployablekiosks.buystations )
    {
        var_8b217f269a1d0c8d = !isdefined( deployablekiosk.deconeffectcount ) && exclusion_zones::function_1efc19de6199fff6( deployablekiosk.origin, 0, 0 ) == -1 && !br_circle_util::ispointinmulticircledanger( deployablekiosk.origin, level.var_ea96217a33eb6457 );
        
        if ( deployablekiosk.isinteractable )
        {
            if ( var_8b217f269a1d0c8d )
            {
                hiddenkiosks[ hiddenkiosks.size ] = deployablekiosk;
                deployablekiosk disabledeployablekiosk();
            }
            
            continue;
        }
        
        if ( !var_8b217f269a1d0c8d && !deployablekiosk.isemped )
        {
            hiddenkiosks = arrayremove( hiddenkiosks, deployablekiosk );
            enabledeployablekiosk( deployablekiosk );
        }
    }
    
    return hiddenkiosks;
}

// Namespace br_deployable_kiosk
// Params 0
// Checksum 0x1676753a, Offset: 0x18ac
// Size: 0xad
function function_a59453e63a9bc44e()
{
    if ( !isdefined( level.deployablekiosks.buystations ) )
    {
        return;
    }
    
    foreach ( deployablekiosk in level.deployablekiosks.buystations )
    {
        if ( isdefined( deployablekiosk.isinteractable ) )
        {
            deployablekiosk disabledeployablekiosk();
        }
    }
}

// Namespace br_deployable_kiosk
// Params 1
// Checksum 0x22042959, Offset: 0x1961
// Size: 0x74
function enabledeployablekiosk( deployablekiosk )
{
    if ( deployablekiosk.var_96c948fbd84c94a6 )
    {
        return;
    }
    
    deployablekiosk.isinteractable = 1;
    
    if ( !deployablekiosk.var_ea4a540642460712 )
    {
        deployablekiosk setscriptablepartstate( #"screen", #"activated", 0 );
    }
    
    deployablekiosk setscriptablepartstate( #"hash_a99bf6d1b5ae6089", #"useable" );
    deployablekiosk function_44807f7b02a309a1();
}

// Namespace br_deployable_kiosk
// Params 0
// Checksum 0x777a7cf4, Offset: 0x19dd
// Size: 0x13c
function disabledeployablekiosk()
{
    deployablekiosk = self;
    deployablekiosk.isinteractable = 0;
    
    if ( !deployablekiosk.var_ea4a540642460712 )
    {
        deployablekiosk setscriptablepartstate( #"screen", #"deactivated", 0 );
    }
    
    deployablekiosk setscriptablepartstate( #"hash_a99bf6d1b5ae6089", #"unusable" );
    deployablekiosk setscriptablepartstate( #"objective", #"inactive" );
    
    foreach ( p in level.players )
    {
        kiosk = p.br_kiosk.entity ?? p.br_kiosk ?? p.common_kiosk.entity;
        
        if ( kiosk == deployablekiosk )
        {
            p common_kiosk::_closepurchasemenuwithresponse( 2 );
        }
    }
}

// Namespace br_deployable_kiosk
// Params 0
// Checksum 0x601a7eca, Offset: 0x1b21
// Size: 0xf5, Type: bool
function function_c0d46fd3da4248d0()
{
    player = self;
    var_f40ecb3da0926369 = 0;
    
    foreach ( drone in level.package_airdrop.activedrones )
    {
        if ( drone.airdropsettings.extradata.fromevent )
        {
            continue;
        }
        
        var_f40ecb3da0926369++;
    }
    
    if ( var_f40ecb3da0926369 >= level.deployablekiosks.var_745b422219e67eeb )
    {
        player playlocalsound( "br_plunder_atm_cancel" );
        player hud_message::showerrormessage( %"mp_br_ingame/airspace_crowded_deployable_kiosk" );
        return true;
    }
    
    return false;
}

// Namespace br_deployable_kiosk
// Params 0
// Checksum 0x1e11b111, Offset: 0x1c1f
// Size: 0x16
function deployablekioskremove()
{
    if ( self.var_ea4a540642460712 )
    {
        return;
    }
    
    airdrop::destroycrate();
}

// Namespace br_deployable_kiosk
// Params 1
// Checksum 0x95ac2c6b, Offset: 0x1c3d
// Size: 0x30f
function deployablekioskanalytics( eattacker )
{
    drone = self;
    
    if ( !isdefined( drone.owner ) )
    {
        return;
    }
    
    eventparams = [];
    eventparams[ eventparams.size ] = "shots_taken";
    var_1994a551a4e4de5b = drone.var_1994a551a4e4de5b ?? 0;
    eventparams[ eventparams.size ] = var_1994a551a4e4de5b;
    eventparams[ eventparams.size ] = "shot_down";
    var_bef6a09a6455164 = isdefined( eattacker ) ? 1 : 0;
    eventparams[ eventparams.size ] = var_bef6a09a6455164;
    eventparams[ eventparams.size ] = "shot_down_by_enemy";
    var_6df1bce6fb8d655a = isdefined( eattacker );
    var_76d4561635a1f09b = var_6df1bce6fb8d655a && drone.owner.team != eattacker.team ? 1 : 0;
    eventparams[ eventparams.size ] = var_76d4561635a1f09b;
    eventparams[ eventparams.size ] = "percentage_distance_travelled";
    var_2af4e711238d26da = distance2dsquared( drone.spawnlocation, drone.goto.origin );
    var_1499e283a2c587d9 = distance2dsquared( drone.spawnlocation, drone.origin );
    
    if ( var_2af4e711238d26da <= 0 )
    {
        percentagedistancetravelled = 100;
    }
    else
    {
        percentagedistancetravelled = var_1499e283a2c587d9 / var_2af4e711238d26da * 100;
    }
    
    eventparams[ eventparams.size ] = int( percentagedistancetravelled );
    eventparams[ eventparams.size ] = "weapon_shot_down";
    var_5160a78a1a7eb85f = isdefined( eattacker ) && isdefined( eattacker.currentweapon ) && isdefined( eattacker.currentweapon.basename );
    weaponshotdown = "";
    
    if ( var_5160a78a1a7eb85f )
    {
        weaponshotdown = eattacker.currentweapon.basename;
    }
    
    eventparams[ eventparams.size ] = weaponshotdown;
    eventparams[ eventparams.size ] = "request_x";
    var_9fc7759a507e70a3 = drone.airdropsettings.var_c2fa1e6335a19103[ 0 ] ?? -1;
    eventparams[ eventparams.size ] = var_9fc7759a507e70a3;
    eventparams[ eventparams.size ] = "request_y";
    var_9fc7749a507e6e70 = drone.airdropsettings.var_c2fa1e6335a19103[ 1 ] ?? -1;
    eventparams[ eventparams.size ] = var_9fc7749a507e6e70;
    eventparams[ eventparams.size ] = "request_z";
    var_9fc7779a507e7509 = drone.airdropsettings.var_c2fa1e6335a19103[ 2 ] ?? -1;
    eventparams[ eventparams.size ] = var_9fc7779a507e7509;
    eventparams[ eventparams.size ] = "total_squad_cash";
    eventparams[ eventparams.size ] = drone.var_fc180128df7ac0f5;
    eventparams[ eventparams.size ] = "circle_index";
    circleindex = -1;
    
    if ( isdefined( level.br_circle ) && isdefined( level.br_circle.circleindex ) )
    {
        circleindex = level.br_circle.circleindex;
    }
    
    eventparams[ eventparams.size ] = circleindex;
    drone.owner dlog_recordplayerevent( "dlog_event_br_deployable_kiosk", eventparams );
}

// Namespace br_deployable_kiosk
// Params 0, eflags: 0x4
// Checksum 0xd85b630d, Offset: 0x1f54
// Size: 0x70
function private function_44807f7b02a309a1()
{
    buystation = self;
    
    if ( !isdefined( buystation ) || !buystation.isinteractable )
    {
        return;
    }
    
    if ( br_publicevents::ispubliceventoftypeactive( %"firesale" ) )
    {
        buystation setscriptablepartstate( #"objective", #"firesale_active", 0 );
        return;
    }
    
    buystation setscriptablepartstate( #"objective", #"active", 0 );
}

// Namespace br_deployable_kiosk
// Params 0, eflags: 0x4
// Checksum 0x4944785d, Offset: 0x1fcc
// Size: 0x4b
function private function_684d5852e6c56ef3()
{
    buystation = self;
    level endon( #"game_ended" );
    buystation endon( #"death" );
    
    while ( true )
    {
        level utility::waittill_any( "public_event_firesale_start", "public_event_firesale_end" );
        buystation function_44807f7b02a309a1();
    }
}

// Namespace br_deployable_kiosk
// Params 1
// Checksum 0x1c279a58, Offset: 0x201f
// Size: 0x106
function function_37a10a66c4282777( grenade )
{
    player = self;
    player endon( #"disconnect" );
    grenade endon( #"explode_end" );
    grenade thread script::notifyafterframeend( "death", "explode_end" );
    player thread function_c808653c400f63e0( grenade );
    grenade waittill( #"explode", position );
    player notify( #"hash_f8392c03ab1a3b19" );
    thread function_c77328fac8befcba( position );
    
    if ( outofbounds::ispointinoutofbounds( position ) || player function_c0d46fd3da4248d0() )
    {
        if ( isdefined( grenade ) )
        {
            grenade delete();
        }
        
        if ( isdefined( player.super ) )
        {
            player supers_mp::refundsuper();
        }
        
        return;
    }
    
    challenges::function_a0936b0e5b4550f3( "equip_deployable_kiosk_drop_jup", ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"use" ) );
    deployablekioskspawn( player, position );
    
    if ( isdefined( player.super ) )
    {
        player supers_mp::superusefinished( undefined, undefined, undefined, 1 );
    }
}

// Namespace br_deployable_kiosk
// Params 1, eflags: 0x4
// Checksum 0x9a2e1ed2, Offset: 0x212d
// Size: 0xbe
function private function_741b9abec1a3b9e( immediate )
{
    playfx( utility::getfx( "deployable_kiosk_explosion" ), self.origin, anglestoforward( self.angles ), anglestoup( self.angles ) );
    self playsound( "br_deployable_kiosk_explode" );
    
    if ( isdefined( self.var_60de57e0dd65d20a ) )
    {
        function_8ae7bc4f3e1e982f( self.var_60de57e0dd65d20a );
    }
    
    level.deployablekiosks.buystations = arrayremove( level.deployablekiosks.buystations, self );
    level.deployablekiosks.buystations = function_5713d46873b29625( level.deployablekiosks.buystations );
}

// Namespace br_deployable_kiosk
// Params 1
// Checksum 0x31fcb650, Offset: 0x21f3
// Size: 0x305
function function_6e9d8ba6cb62d8d7( drone )
{
    if ( isdefined( drone.airdropsettings.extradata.var_60de57e0dd65d20a ) )
    {
        function_3b2eefd0e491e3cd( drone.airdropsettings.extradata.var_60de57e0dd65d20a, drone );
    }
    
    drone.var_92c7f6e9874d8adc = level.deployablekiosks.var_fe3437bbc52ad866;
    player = drone.airdropsettings.player;
    totalplunder = 0;
    
    if ( isdefined( player ) )
    {
        teammates = level.teamdata[ player.team ][ "alivePlayers" ];
        
        if ( teammates.size > 0 )
        {
            foreach ( teammate in teammates )
            {
                if ( !isdefined( teammate ) )
                {
                    continue;
                }
                
                teammate thread hud_message::showsplash( "br_deployable_kiosk_incoming", undefined, drone.owner );
                totalplunder += teammate currency::get_currency_amount( "cash" );
            }
        }
        
        drone playsoundtoplayer( "kiosk_drone_eng_swt", player, drone );
    }
    
    drone.var_fc180128df7ac0f5 = totalplunder;
    team = drone.airdropsettings.team;
    
    if ( isdefined( team ) )
    {
        goto = drone.goto;
        level thread br_public::brleaderdialogteam( "friendly_active", team, 1, 2, undefined );
        droneteam = teams::getteamdata( team, "players" );
        midwaypoint = ( ( goto.origin[ 0 ] + drone.origin[ 0 ] ) / 2, ( goto.origin[ 1 ] + drone.origin[ 1 ] ) / 2, ( goto.origin[ 2 ] + drone.origin[ 2 ] ) / 2 );
        var_f95922e04c20dd20 = br_public::droptogroundmultitrace( midwaypoint );
        var_a6b0ef283bbe5ad2 = br_public::droptogroundmultitrace( goto.origin );
        var_a11daf0a3d76391c = player_utility::script_getplayersinradius( var_f95922e04c20dd20, level.deployablekiosks.var_c69cdd1baa75e2ac, undefined, droneteam );
        var_b344704513ee3d32 = player_utility::script_getplayersinradius( var_a6b0ef283bbe5ad2, level.deployablekiosks.var_c69cdd1baa75e2ac, undefined, droneteam );
        var_a11daf0a3d76391c = arraycombine( var_a11daf0a3d76391c, var_b344704513ee3d32 );
        
        if ( isdefined( var_a11daf0a3d76391c ) && var_a11daf0a3d76391c.size > 0 )
        {
            br_public::brleaderdialog( "enemy_active", 1, var_a11daf0a3d76391c, undefined, 2 );
        }
    }
}

// Namespace br_deployable_kiosk
// Params 2
// Checksum 0x1aae1f87, Offset: 0x2500
// Size: 0x82
function function_14371b8d475c62ca( drone, eattacker )
{
    if ( isdefined( drone.airdropsettings.extradata.var_60de57e0dd65d20a ) && isdefined( drone.package ) )
    {
        function_3b2eefd0e491e3cd( drone.airdropsettings.extradata.var_60de57e0dd65d20a, drone.package );
    }
    
    drone deployablekioskanalytics( eattacker );
}

// Namespace br_deployable_kiosk
// Params 1
// Checksum 0x55a05bf2, Offset: 0x258a
// Size: 0x6e
function activatedeployablekiosk( isfirstactivation )
{
    thread function_684d5852e6c56ef3();
    
    if ( isfirstactivation )
    {
        self.reactivatefunc = &enabledeployablekiosk;
    }
    
    if ( !self.isemped )
    {
        enabledeployablekiosk( self );
    }
    
    if ( utility::flag_exist( "br_final_circle" ) && getdvarint( @"hash_ad4aed3730427bc5", 1 ) )
    {
        disabledeployablekiosk();
    }
    
    self.isdeployablekiosk = 1;
}

// Namespace br_deployable_kiosk
// Params 1, eflags: 0x4
// Checksum 0x3965b3b6, Offset: 0x2600
// Size: 0x125
function private function_5dce73d456f8ba69( airdropsettings )
{
    kiosk = self;
    kiosk.var_60de57e0dd65d20a = airdropsettings.extradata.var_60de57e0dd65d20a;
    
    if ( isdefined( kiosk.var_60de57e0dd65d20a ) )
    {
        function_3b2eefd0e491e3cd( kiosk.var_60de57e0dd65d20a, kiosk );
    }
    
    level.deployablekiosks.buystations[ level.deployablekiosks.buystations.size ] = kiosk;
    superbundle = level.superglobals.staticsuperdata[ "super_deployable_kiosk" ].bundle;
    
    if ( level.deployablekiosks.var_e253c9f921155d75 || superbundle.var_127f49e33444be5a )
    {
        namespace_9d8e359c3b1041e5::emp_debuff_register_sharedfunc( kiosk, &deployablekioskemp );
        kiosk.var_5b3dbacfeda0fd01 = &deployablekioskemp;
    }
    
    if ( !kiosk.airdropsettings.extradata.fromevent )
    {
        kiosk function_6ceb8e6acf7dfe70();
    }
}

// Namespace br_deployable_kiosk
// Params 1
// Checksum 0x994677f0, Offset: 0x272d
// Size: 0x5c
function function_c808653c400f63e0( grenade )
{
    player = self;
    player endon( #"disconnect" );
    player endon( #"hash_f8392c03ab1a3b19" );
    grenade waittill( #"death" );
    waitframe();
    
    if ( isdefined( player.super ) )
    {
        player supers_mp::superusefinished( 1 );
    }
}

// Namespace br_deployable_kiosk
// Params 1
// Checksum 0xf9e0f174, Offset: 0x2791
// Size: 0x54
function function_c77328fac8befcba( position )
{
    smoke_sfx = spawn( "script_origin", position );
    smoke_sfx playloopsound( "smoke_carepackage_smoke_lp" );
    wait 21;
    smoke_sfx playsound( "smoke_canister_tail_dissipate" );
    smoke_sfx stoploopsound( "smoke_carepackage_smoke_lp" );
    wait 5;
    smoke_sfx delete();
}

// Namespace br_deployable_kiosk
// Params 0
// Checksum 0x2699e2cc, Offset: 0x27ed
// Size: 0xca
function function_fd9b4fce6e78327a()
{
    level endon( #"game_ended" );
    level waittill( #"br_final_circle" );
    br_circle::function_e441e2dbc58966e8( 15 );
    
    if ( isdefined( level.deployablekiosks.buystations ) )
    {
        foreach ( deployablekiosk in level.deployablekiosks.buystations )
        {
            deployablekiosk.var_96c948fbd84c94a6 = 1;
        }
    }
    
    function_a59453e63a9bc44e();
}

