// scripts\mp\br\gametypes\br_quest_chain_manager.gsc  (hash_72a098af390f1072.gscc) (size: 6894 Bytes / 0x1aee / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb231bf2c (2989604652)
// size ...... 6894 (0x1aee)
// includes .. 5   (offset: 0x1996)
// strings ... 10  (offset: 0x19be)
// dev strs .. 8   (offset: 0x1a86)
// exports ... 23  (offset: 0x112a)
// cseg ...... 0xee + 0x103c (0x112a)
// imports ... 39  (offset: 0x14c2)
// animtree1 . 0   (offset: 0x1aee)
// animtree2 . 0   (offset: 0x1aee)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\common\utility\teams;

#namespace quest_chain;

// Namespace quest_chain
// Params 0, eflags: 0x5
// Checksum 0x862dfa82, Offset: 0x10c
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"quest_chain", undefined, undefined, &post_main );
}

// Namespace quest_chain
// Params 0
// Checksum 0x96611569, Offset: 0x12d
// Size: 0x2d
function post_main()
{
    if ( !isdefined( level.brgametype ) )
    {
        return;
    }
    
    if ( !getdvarint( @"hash_33dfb5a00b144fa9", 1 ) )
    {
        return;
    }
    
    level thread initinternal();
}

// Namespace quest_chain
// Params 0
// Checksum 0x93b8763f, Offset: 0x162
// Size: 0x2f
function initinternal()
{
    level endon( #"game_ended" );
    utility::flag_wait( "StartGameTypeCallbackFinished" );
    initleveldata();
    setupcallbacks();
    function_1f8b1f080a6376f0();
}

// Namespace quest_chain
// Params 0
// Checksum 0xca4513ce, Offset: 0x199
// Size: 0xb2
function initleveldata()
{
    assert( !isdefined( level.var_7f7712f1dc8a87b4 ), "<dev string:x24>" );
    level.var_7f7712f1dc8a87b4 = spawnstruct();
    level.var_7f7712f1dc8a87b4.var_af2a0bc6b54931e = [];
    level.var_7f7712f1dc8a87b4.activechains = [];
    level.var_7f7712f1dc8a87b4.teaminstances = [];
    level.var_7f7712f1dc8a87b4.waittime = getdvarfloat( @"hash_9170c7bf6eebab04", 5 );
    level.var_7f7712f1dc8a87b4.var_e0a3f74ac0ff9479 = getdvarint( @"hash_9f9977b7c37ebb8f", 1 );
}

// Namespace quest_chain
// Params 0
// Checksum 0xd18737f, Offset: 0x253
// Size: 0x4a
function setupcallbacks()
{
    callback::add( #"on_contract_start", &oncontractstart );
    callback::add( #"on_contract_end", &oncontractend );
    utility::registersharedfunc( #"gametype", #"hash_b5249490580ccb18", &ongiverewards );
}

// Namespace quest_chain
// Params 0
// Checksum 0x9fc49ba3, Offset: 0x2a5
// Size: 0x1d8
function function_1f8b1f080a6376f0()
{
    assert( isdefined( level.var_7f7712f1dc8a87b4 ), "<dev string:x51>" );
    
    if ( !isdefined( level.var_7f7712f1dc8a87b4 ) )
    {
        return;
    }
    
    var_3a6c717c90f4d156 = getdvarint( @"hash_27fa6ed1a82a8436", 4 );
    
    switch ( var_3a6c717c90f4d156 )
    {
        case 6:
            registerquestchain( "elite", [ "vip", "vip", "vip" ], 0 );
            break;
        case 5:
            registerquestchain( "elite", [ "elite_resurgence", "elite_resurgence", "elite_resurgence" ], 0 );
            break;
        case 4:
            registerquestchain( "elite", [ "elite_geiger", "safecracker", "elite_chopper" ], 0 );
            break;
        case 3:
            registerquestchain( "elite", [ "elite_chopper", "elite_geiger", "safecracker" ], 0 );
            break;
        case 2:
            registerquestchain( "elite", [ "safecracker", "elite_geiger", "elite_chopper" ], 0 );
            break;
        case 1:
            registerquestchain( "elite", [ "safecracker", "vip", "elite_chopper" ], 0 );
            break;
        default:
            registerquestchain( "elite", [ "scavenger", "vip", "intel" ], 0 );
            break;
    }
}

// Namespace quest_chain
// Params 3
// Checksum 0x29b3a88f, Offset: 0x485
// Size: 0x5f
function registerquestchain( var_11da3fca8c3d852a, var_67d78488de2454fa, flags )
{
    assert( isdefined( level.var_7f7712f1dc8a87b4 ), "<dev string:x51>" );
    
    if ( !isdefined( level.var_7f7712f1dc8a87b4 ) )
    {
        return;
    }
    
    level.var_7f7712f1dc8a87b4.var_af2a0bc6b54931e[ var_11da3fca8c3d852a ] = var_67d78488de2454fa;
}

// Namespace quest_chain
// Params 7
// Checksum 0x210d6803, Offset: 0x4ec
// Size: 0x1c0
function function_51eeee1b9f448eba( var_11da3fca8c3d852a, var_bcec7d4c9e80f6ae, var_d699a78e44b533ce, var_e00f33985eb6a4d2, var_e92aa0ac6a8a3a6e, var_c4ee18185b18dbf1, var_c894ca0e266a034f )
{
    assert( isdefined( level.var_7f7712f1dc8a87b4 ), "<dev string:x51>" );
    
    if ( !isdefined( level.var_7f7712f1dc8a87b4 ) )
    {
        return;
    }
    
    task = self.task;
    
    if ( !isdefined( task ) )
    {
        return;
    }
    
    array = level.var_7f7712f1dc8a87b4.var_af2a0bc6b54931e[ var_11da3fca8c3d852a ];
    task.questchain = spawnstruct();
    task.questchain.ref = var_11da3fca8c3d852a;
    task.questchain.index = -1;
    task.questchain.len = array.size;
    task.questchain.dropcount = 0;
    task.questchain.var_35acf406e1ff3c1d = var_bcec7d4c9e80f6ae;
    task.questchain.var_e0c04778128f2e3d = var_d699a78e44b533ce;
    task.questchain.var_d1d480e7a4343fd1 = var_e00f33985eb6a4d2;
    task.questchain.var_8b3dce2c2540c1dd = var_e92aa0ac6a8a3a6e;
    task.questchain.ongiverewards = var_c4ee18185b18dbf1;
    task.questchain.var_b14c50122ad3a864 = var_c894ca0e266a034f;
    task.questchain.startertask = task;
}

// Namespace quest_chain
// Params 1
// Checksum 0xe6e82db1, Offset: 0x6b4
// Size: 0x4d
function oncontractstart( params )
{
    if ( !isdefined( level.var_7f7712f1dc8a87b4 ) )
    {
        return;
    }
    
    if ( function_fad667532e76bc72( params.task ) )
    {
        level thread function_f2d7a51c9f1de87( params.task, params.index );
    }
}

// Namespace quest_chain
// Params 1
// Checksum 0x6bac88fb, Offset: 0x709
// Size: 0xc9
function oncontractend( params )
{
    if ( !isdefined( level.var_7f7712f1dc8a87b4 ) )
    {
        return;
    }
    
    if ( function_182d3e78244dadee( params.index ) )
    {
        questchain = level.var_7f7712f1dc8a87b4.teaminstances[ params.index ];
        
        if ( params.task == questchain.startertask )
        {
            level thread function_c25f2bde1b6a73e6( params.task, params.index, params.success );
            return;
        }
        
        level thread function_11c4df5599649f04( params.task, params.index, params.success );
    }
}

// Namespace quest_chain
// Params 3
// Checksum 0xb3860e55, Offset: 0x7da
// Size: 0xb7
function function_c25f2bde1b6a73e6( task, team, success )
{
    function_9597c2caed3d8482( task, team, success );
    questchain = function_2d09fe0b8396ea40( team );
    assert( isdefined( questchain ), "<dev string:x79>" );
    
    if ( isfunction( questchain.var_b14c50122ad3a864 ) )
    {
        task [[ questchain.var_b14c50122ad3a864 ]]( team, success );
    }
    
    level.var_7f7712f1dc8a87b4.activechains = arrayremove( level.var_7f7712f1dc8a87b4.activechains, questchain );
    level.var_7f7712f1dc8a87b4.teaminstances[ team ] = undefined;
}

// Namespace quest_chain
// Params 3
// Checksum 0xb2711d0d, Offset: 0x899
// Size: 0x118
function function_11c4df5599649f04( task, team, success )
{
    level endon( #"game_ended" );
    questchain = function_2d09fe0b8396ea40( team );
    assert( isdefined( questchain ), "<dev string:xbf>" );
    
    if ( success )
    {
        if ( level.var_7f7712f1dc8a87b4.var_e0a3f74ac0ff9479 )
        {
            questchain.rewardpickup = 1;
            questchain waittill( #"reward_pickup", reward );
            questchain.rewardpickup = undefined;
            function_1cb2ebfdb5d8d2e8( team );
        }
    }
    
    br_contract_manager::function_645d5f233e8b5442( team, undefined );
    level.contractmanager.currenttasks = arrayremove( level.contractmanager.currenttasks, task );
    
    if ( success && questchain.index < questchain.len - 1 )
    {
        function_55fe5497fb8b533c( task, team );
        return;
    }
    
    function_9597c2caed3d8482( task, team, success );
}

// Namespace quest_chain
// Params 7
// Checksum 0xf1a2f01, Offset: 0x9b9
// Size: 0x110
function ongiverewards( group, team, rewardorigin, rewardangles, rewardscriptable, players, squadindex )
{
    if ( !isdefined( level.var_7f7712f1dc8a87b4 ) )
    {
        return;
    }
    
    if ( function_182d3e78244dadee( team ) )
    {
        questchain = function_2d09fe0b8396ea40( team );
        var_67d78488de2454fa = level.var_7f7712f1dc8a87b4.var_af2a0bc6b54931e[ questchain.ref ];
        contractref = var_67d78488de2454fa[ questchain.index ];
        contractbundle = br_contract_manager::function_33c901ddb7f5c50( contractref );
        groupref = contractbundle.rewardgroup;
        
        if ( isdefined( group ) && isdefined( groupref ) && group == groupref && isfunction( questchain.ongiverewards ) )
        {
            [[ questchain.ongiverewards ]]( team, rewardorigin, rewardangles );
        }
    }
}

// Namespace quest_chain
// Params 2
// Checksum 0xe661c0fa, Offset: 0xad1
// Size: 0x153
function function_f2d7a51c9f1de87( task, team )
{
    level endon( #"game_ended" );
    questchain = task.questchain;
    assert( isdefined( questchain ), "<dev string:xfc>" );
    
    if ( !isdefined( questchain ) )
    {
        return;
    }
    
    level.var_7f7712f1dc8a87b4.activechains[ level.var_7f7712f1dc8a87b4.activechains.size ] = questchain;
    level.var_7f7712f1dc8a87b4.teaminstances[ team ] = questchain;
    
    if ( isfunction( questchain.var_35acf406e1ff3c1d ) )
    {
        task [[ questchain.var_35acf406e1ff3c1d ]]( team );
    }
    
    if ( task.var_34a8bcec977ba3ee || questchain.index >= questchain.len - 1 )
    {
        return;
    }
    
    if ( level.var_7f7712f1dc8a87b4.waittime > 0 )
    {
        wait level.var_7f7712f1dc8a87b4.waittime;
    }
    
    br_contract_manager::function_645d5f233e8b5442( team, undefined );
    level.contractmanager.currenttasks = arrayremove( level.contractmanager.currenttasks, task );
    function_55fe5497fb8b533c( task, team );
}

// Namespace quest_chain
// Params 2
// Checksum 0x21abb86b, Offset: 0xc2c
// Size: 0x180
function function_55fe5497fb8b533c( task, team )
{
    questchain = function_2d09fe0b8396ea40( team );
    assert( isdefined( questchain ), "<dev string:x13a>" );
    
    if ( !isdefined( questchain ) )
    {
        return;
    }
    
    questchain.index++;
    var_67d78488de2454fa = level.var_7f7712f1dc8a87b4.var_af2a0bc6b54931e[ questchain.ref ];
    contractref = var_67d78488de2454fa[ questchain.index ];
    teammates = teams::getteamdata( team, "players" );
    player = undefined;
    
    foreach ( teammate in teammates )
    {
        if ( !isdefined( player ) )
        {
            player = teammate;
        }
        
        if ( isalive( teammate ) && !isbot( teammate ) )
        {
            player = teammate;
            break;
        }
    }
    
    if ( isfunction( questchain.var_e0c04778128f2e3d ) )
    {
        task [[ questchain.var_e0c04778128f2e3d ]]( team );
    }
    
    player function_1cad6ce5620874e4( contractref, task.payload );
    task.payload = undefined;
}

// Namespace quest_chain
// Params 3
// Checksum 0x11b819ba, Offset: 0xdb4
// Size: 0x132
function function_9597c2caed3d8482( task, team, success )
{
    questchain = function_2d09fe0b8396ea40( team );
    assert( isdefined( questchain ), "<dev string:x177>" );
    
    if ( !isdefined( questchain ) )
    {
        return;
    }
    
    questchain.complete = 1;
    questchain.success = success;
    
    if ( isfunction( questchain.var_d1d480e7a4343fd1 ) )
    {
        task [[ questchain.var_d1d480e7a4343fd1 ]]( team, success );
    }
    
    if ( success && isdefined( questchain.startertask ) )
    {
        br_contract_manager::function_645d5f233e8b5442( team, questchain.startertask );
        level.contractmanager.currenttasks[ level.contractmanager.currenttasks.size ] = questchain.startertask;
        
        if ( isdefined( questchain.startertask.category ) )
        {
            questindex = br_contract_manager::getquesttableindex( questchain.startertask.category );
            task br_contract_manager::function_3ee820240b414ddb( questindex );
        }
    }
}

// Namespace quest_chain
// Params 1
// Checksum 0x2e058c00, Offset: 0xeee
// Size: 0x8e
function function_1cb2ebfdb5d8d2e8( team )
{
    if ( level.var_7f7712f1dc8a87b4.waittime <= 0 )
    {
        return;
    }
    
    task = self;
    questchain = function_2d09fe0b8396ea40( team );
    assert( isdefined( questchain ), "<dev string:x1af>" );
    
    if ( !isdefined( questchain ) )
    {
        return;
    }
    
    level endon( #"game_ended" );
    
    if ( isfunction( questchain.var_8b3dce2c2540c1dd ) )
    {
        task [[ questchain.var_8b3dce2c2540c1dd ]]( team );
    }
}

// Namespace quest_chain
// Params 1
// Checksum 0xb5d3bcb4, Offset: 0xf84
// Size: 0xac
function function_7e8b3b905b2c2360( var_11da3fca8c3d852a )
{
    task = self.task;
    
    if ( !( isdefined( task ) && isdefined( task.questchain ) ) )
    {
        return;
    }
    
    task.questchain.tablets = [];
    var_67d78488de2454fa = level.var_7f7712f1dc8a87b4.var_af2a0bc6b54931e[ var_11da3fca8c3d852a ];
    nexttablet = undefined;
    prevtablet = undefined;
    
    for ( i = 0; i < var_67d78488de2454fa.size ; i++ )
    {
        contractref = var_67d78488de2454fa[ i ];
    }
}

// Namespace quest_chain
// Params 2
// Checksum 0xfb4d96d3, Offset: 0x1038
// Size: 0x7a
function function_1cad6ce5620874e4( contractref, payload )
{
    player = self;
    iselite = 1;
    tablet = br_contract_manager::function_afc15d4bdb062dff( contractref, player.origin, player.angles, iselite );
    tablet.task.payload = payload;
    player br_contract_manager::function_9490728b1fe4323( tablet );
}

// Namespace quest_chain
// Params 1
// Checksum 0x9ae0b67a, Offset: 0x10ba
// Size: 0x23, Type: bool
function function_182d3e78244dadee( team )
{
    return isdefined( level.var_7f7712f1dc8a87b4.teaminstances[ team ] );
}

// Namespace quest_chain
// Params 1
// Checksum 0x9f50fa84, Offset: 0x10e6
// Size: 0x18, Type: bool
function function_fad667532e76bc72( task )
{
    return isdefined( task.questchain );
}

// Namespace quest_chain
// Params 1
// Checksum 0xa49c2a94, Offset: 0x1107
// Size: 0x22
function function_2d09fe0b8396ea40( team )
{
    return level.var_7f7712f1dc8a87b4.teaminstances[ team ];
}

