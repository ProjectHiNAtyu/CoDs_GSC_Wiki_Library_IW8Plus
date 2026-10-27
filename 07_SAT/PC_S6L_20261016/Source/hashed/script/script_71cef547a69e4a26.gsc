// script_71cef547a69e4a26  (hash_71cef547a69e4a26.gscc) (size: 24133 Bytes / 0x5e45 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf5cbad35 (4123766069)
// size ...... 24133 (0x5e45)
// includes .. 8   (offset: 0x557d)
// strings ... 45  (offset: 0x55bd)
// dev strs .. 112 (offset: 0x58d5)
// exports ... 65  (offset: 0x3b3d)
// cseg ...... 0x4d4 + 0x3669 (0x3b3d)
// imports ... 122 (offset: 0x4565)
// animtree1 . 0   (offset: 0x5e45)
// animtree2 . 0   (offset: 0x5e45)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\omnvar_utility;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\hud_util;

#namespace ability_manager;

// Namespace ability_manager
// Params 0, eflags: 0x5
// Checksum 0xc1aa2c28, Offset: 0x4f2
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"ability_manager", undefined, &pre_main, &post_main );
}

// Namespace ability_manager
// Params 0, eflags: 0x5
// Checksum 0x4411ebc0, Offset: 0x517
// Size: 0x3a
function private autoexec ignore()
{
    if ( !isdefined( game_utility_mp::function_4b7180ed8c2e9742( #"hash_d9e83cdce1523312" ) ) || !getdvarint( @"hash_ce99a5a91f25171", 1 ) )
    {
        system::ignore( #"ability_manager" );
    }
}

// Namespace ability_manager
// Params 0, eflags: 0x4
// Checksum 0x9af3e039, Offset: 0x559
// Size: 0xa7
function private pre_main()
{
    level.ability_manager = { #log_level:getdvarint( @"hash_5cb6413598119127", -1 ), #bundles:[], #slots:[], #ability_slots:[], #defs:[] };
    level.ability_manager.omnvar_slots = [ "ui_ability_slot_1", "ui_ability_slot_2", "ui_ability_slot_3" ];
    assert( level.ability_manager.omnvar_slots.size == 3, "<dev string:x24>" );
    init_from_bundle();
}

// Namespace ability_manager
// Params 0, eflags: 0x4
// Checksum 0xc9448b05, Offset: 0x608
// Size: 0x200
function private init_from_bundle()
{
    list_bundle = game_utility_mp::function_4b7180ed8c2e9742( #"hash_d9e83cdce1523312" );
    
    if ( !isdefined( list_bundle ) )
    {
        if ( 0 <= level.ability_manager.log_level )
        {
            logstring( "[AbilityMgr]" + " " + "playerabilitylist bundle is missing, no slots or abilities will be registered" );
        }
        
        return;
    }
    
    foreach ( index, slot_def in list_bundle.slots )
    {
        init_slot( slot_def, index );
    }
    
    foreach ( index, entry in list_bundle.abilities )
    {
        bundle = getscriptbundle( entry.ability );
        
        if ( !isdefined( bundle ) )
        {
            assertmsg( "<dev string:x70>" );
            continue;
        }
        
        ref = bundle.var_83195f10e1e12a6a.variant.variant_object.abilitytype;
        
        if ( !ref )
        {
            assertmsg( "<dev string:xb7>" );
            continue;
        }
        
        assert( index <= 31, "<dev string:x106>" + index + "<dev string:x115>" );
        level.ability_manager.bundles[ ref ] = { #index:index, #bundle:entry.ability };
    }
}

// Namespace ability_manager
// Params 2, eflags: 0x4
// Checksum 0x6a57c269, Offset: 0x810
// Size: 0xf7
function private init_slot( slot_def, bundle_index )
{
    slot_def = slot_def.variant_object;
    
    if ( slot_def.slot == "none" )
    {
        assertmsg( "<dev string:x171>" );
        return;
    }
    
    assert( bundle_index <= 15, "<dev string:x1aa>" + bundle_index + "<dev string:x1b6>" );
    binds = [];
    release_binds = [];
    
    if ( slot_def.pressbind )
    {
        binds[ binds.size ] = slot_def.pressbind;
    }
    
    if ( slot_def.releasebind )
    {
        release_binds[ release_binds.size ] = slot_def.releasebind;
    }
    
    level.ability_manager.slots[ slot_def.slot ] = { #index:bundle_index, #release_binds:release_binds, #binds:binds };
}

// Namespace ability_manager
// Params 0, eflags: 0x4
// Checksum 0xc5c5345f, Offset: 0x90f
// Size: 0x88
function private post_main()
{
    if ( level.ability_manager.defs.size == 0 )
    {
        level.ability_manager = undefined;
        return;
    }
    
    level callback::add( #"player_connect", &on_player_connect );
    level callback::add( #"player_disconnect", &on_player_disconnect );
    level callback::add( #"player_spawned", &on_player_spawned );
    level callback::add( #"player_death", &on_player_killed );
    
    /#
        init_debug();
    #/
}

// Namespace ability_manager
// Params 1
// Checksum 0xd0790b1d, Offset: 0x99f
// Size: 0x2e2
function register_ability( def )
{
    /#
        assert( def, "<dev string:x206>" );
        assert( def.ref, "<dev string:x217>" );
        assert( def.activate_func, "<dev string:x22b>" );
        assert( isfunction( def.activate_func ), "<dev string:x249>" );
        
        if ( def.can_activate_func )
        {
            assert( isfunction( def.can_activate_func ), "<dev string:x275>" );
        }
        
        if ( def.assigned_func )
        {
            assert( isfunction( def.assigned_func ), "<dev string:x2a5>" );
        }
        
        if ( def.cleanup_func )
        {
            assert( isfunction( def.cleanup_func ), "<dev string:x2d1>" );
        }
        
        if ( def.charge_func )
        {
            assert( isfunction( def.charge_func ), "<dev string:x2fc>" );
        }
        
        bundle = get_ability_bundle( def.ref );
        assert( isdefined( bundle ), "<dev string:x326>" + def.ref + "<dev string:x328>" );
        
        if ( bundle && bundle.cooldownseconds )
        {
            assert( bundle.cooldownseconds >= level.framedurationseconds, "<dev string:x38d>" + def.ref + "<dev string:x3a7>" );
            
            if ( def.refresh_func )
            {
                assert( isfunction( def.refresh_func ), "<dev string:x3d9>" );
            }
        }
        
        charge = get_charge_settings( def.ref );
        
        if ( isdefined( charge ) )
        {
            assert( def.charge_func, "<dev string:x326>" + def.ref + "<dev string:x404>" );
            
            if ( charge.var_c3ca9df87ea0117e )
            {
                assert( charge.var_c3ca9df87ea0117e >= level.framedurationseconds, "<dev string:x43e>" + def.ref + "<dev string:x460>" );
            }
        }
        else
        {
            assert( !isdefined( def.charge_func ), "<dev string:x326>" + def.ref + "<dev string:x49a>" );
        }
    #/
    
    level.ability_manager.defs[ def.ref ] = def;
    
    if ( 1 <= level.ability_manager.log_level )
    {
        logstring( "[AbilityMgr]" + " " + "registered ability '" + def.ref + "'" );
    }
}

// Namespace ability_manager
// Params 2
// Checksum 0x1aefc210, Offset: 0xc89
// Size: 0x2e8
function assign_ability( ref, slot )
{
    profilestart();
    def = level.ability_manager.defs[ ref ];
    
    if ( !def )
    {
        assertmsg( "<dev string:x504>" + ref + "<dev string:x326>" );
        profilestop();
        return;
    }
    
    assert( arraycontains( getarraykeys( level.ability_manager.slots ), slot ), "<dev string:x520>" + slot + "<dev string:x527>" );
    existing_slot = function_e71db2cbcca4ef20( slot );
    
    if ( existing_slot && existing_slot.ref == ref )
    {
        if ( 2 <= level.ability_manager.log_level )
        {
            logstring( "[AbilityMgr]" + " " + "assign skipped: '" + ref + "' already in slot '" + slot + "' for player " + self.name );
        }
        
        profilestop();
        return;
    }
    
    if ( function_d9911c70ee1ac503( ref ) )
    {
        if ( 2 <= level.ability_manager.log_level )
        {
            logstring( "[AbilityMgr]" + " " + "assign skipped: '" + ref + "' already assigned to another slot" + " for player " + self.name );
        }
        
        profilestop();
        return;
    }
    
    if ( existing_slot )
    {
        function_38de268b81340e01( existing_slot.ref );
    }
    
    ability_slots = get_ability_slots();
    
    if ( ability_slots.size >= 1 && function_cf9d662765c4ba5c( slot, ability_slots ) )
    {
        profilestop();
        return;
    }
    
    ui_slot = function_d40a071a460f051a();
    ability_slots[ slot ] = { #progress:100, #charge_fraction:0, #has_error:0, #var_214bc6cea3285fe4:0, #is_active:0, #on_cooldown:0, #ui_slot:ui_slot, #slot:slot, #ref:ref };
    
    /#
        function_ecf4b3ff8bca6245( ability_slots[ slot ] );
    #/
    
    init_ability_omnvar( ability_slots[ slot ] );
    
    if ( 1 <= level.ability_manager.log_level )
    {
        logstring( "[AbilityMgr]" + " " + "assigned '" + ref + "' to slot '" + slot + "' for player " + self.name );
    }
    
    if ( def.assigned_func )
    {
        if ( 2 <= level.ability_manager.log_level )
        {
            logstring( "[AbilityMgr]" + " " + "calling assigned_func for '" + ref + "' on player " + self.name );
        }
        
        self [[ def.assigned_func ]]( function_ee7172eb30cc9d68( def.ref, slot ) );
    }
    
    thread monitor_slot( def, slot );
    profilestop();
}

// Namespace ability_manager
// Params 1
// Checksum 0x807dc3df, Offset: 0xf79
// Size: 0x1b5
function function_38de268b81340e01( ref )
{
    profilestart();
    def = level.ability_manager.defs[ ref ];
    
    if ( !def )
    {
        assertmsg( "<dev string:x504>" + ref + "<dev string:x326>" );
        profilestop();
        return;
    }
    
    ability_slots = get_ability_slots();
    
    if ( !ability_slots.size )
    {
        profilestop();
        return;
    }
    
    var_362be81e2d9fced7 = function_c45a9e301b6b6056( ability_slots, #ref, ref );
    
    if ( !isdefined( var_362be81e2d9fced7 ) )
    {
        profilestop();
        return;
    }
    
    ability = ability_slots[ var_362be81e2d9fced7 ];
    
    if ( ( ability.is_active || ability.var_214bc6cea3285fe4 ) && def.cleanup_func )
    {
        if ( 1 <= level.ability_manager.log_level )
        {
            logstring( "[AbilityMgr]" + " " + "unassigning active ability '" + ref + "', calling cleanup for player " + self.name );
        }
        
        interrupt_ability( ref );
        self thread [[ def.cleanup_func ]]( function_ee7172eb30cc9d68( def.ref, var_362be81e2d9fced7 ) );
    }
    
    remove_binds( def, var_362be81e2d9fced7 );
    function_5c94017994968c( ability.ui_slot );
    
    /#
        function_cb67c6c7122588df( ability );
    #/
    
    ability_slots[ var_362be81e2d9fced7 ] = undefined;
    
    if ( 1 <= level.ability_manager.log_level )
    {
        logstring( "[AbilityMgr]" + " " + "unassigned '" + ref + "' from player " + self.name );
    }
    
    self notify( "ability_manager_cleared_" + ability.ref );
    profilestop();
}

// Namespace ability_manager
// Params 0
// Checksum 0x4f66e35b, Offset: 0x1136
// Size: 0x98
function function_5e3b7fab0d6d1449()
{
    profilestart();
    ability_slots = get_ability_slots();
    
    if ( !ability_slots.size )
    {
        profilestop();
        return;
    }
    
    foreach ( ability in ability_slots )
    {
        function_38de268b81340e01( ability.ref );
    }
    
    profilestop();
}

// Namespace ability_manager
// Params 1
// Checksum 0xbbbb3a7, Offset: 0x11d6
// Size: 0x75
function interrupt_ability( ref )
{
    ability = function_d9911c70ee1ac503( ref );
    
    if ( !isdefined( ability ) )
    {
        return;
    }
    
    if ( 1 <= level.ability_manager.log_level )
    {
        logstring( "[AbilityMgr]" + " " + "interrupting '" + ref + "' on player " + self.name );
    }
    
    self notify( "ability_manager_interrupt_" + ref );
}

// Namespace ability_manager
// Params 0
// Checksum 0xd2956189, Offset: 0x1253
// Size: 0x1f, Type: bool
function function_a60baa4cf3d415d0()
{
    ability_slots = get_ability_slots();
    
    if ( !ability_slots.size )
    {
        return false;
    }
    
    return true;
}

// Namespace ability_manager
// Params 1
// Checksum 0xda694eab, Offset: 0x127b
// Size: 0x22
function function_e71db2cbcca4ef20( slot )
{
    ability_slots = get_ability_slots();
    return ability_slots[ slot ];
}

// Namespace ability_manager
// Params 1
// Checksum 0x5a423087, Offset: 0x12a6
// Size: 0x4d
function function_d9911c70ee1ac503( ref )
{
    ability_slots = get_ability_slots();
    
    if ( !ability_slots.size )
    {
        return;
    }
    
    var_362be81e2d9fced7 = function_c45a9e301b6b6056( ability_slots, #ref, ref );
    
    if ( !isdefined( var_362be81e2d9fced7 ) )
    {
        return;
    }
    
    return ability_slots[ var_362be81e2d9fced7 ];
}

// Namespace ability_manager
// Params 1
// Checksum 0x78a6311d, Offset: 0x12fc
// Size: 0x3e
function function_46f903265663b45b( ref )
{
    var_83195f10e1e12a6a = function_4e65acc84241bf3b( ref, #"hash_3fb9fd1f8becc0dd" );
    return var_83195f10e1e12a6a.variant.variant_object;
}

// Namespace ability_manager
// Params 1
// Checksum 0xd40d1b15, Offset: 0x1343
// Size: 0x6e
function get_charge_settings( ref )
{
    bundle = get_ability_bundle( ref );
    
    if ( !bundle.charge.variant_type || bundle.charge.variant_type == "Types_AbilityChargeBase" )
    {
        return;
    }
    
    return bundle.charge.variant_object;
}

// Namespace ability_manager
// Params 1, eflags: 0x4
// Checksum 0x73b4d3c0, Offset: 0x13ba
// Size: 0x54
function private on_player_connect( params )
{
    assert( !level.ability_manager.ability_slots[ self getxuidint64() ], "<dev string:x54f>" + self getxuidint64() );
    level.ability_manager.ability_slots[ self getxuidint64() ] = [];
}

// Namespace ability_manager
// Params 1, eflags: 0x4
// Checksum 0x5ff044f0, Offset: 0x1416
// Size: 0x51
function private on_player_disconnect( params )
{
    assert( level.ability_manager.ability_slots[ self getxuidint64() ], "<dev string:x584>" + self getxuidint64() );
    level.ability_manager.ability_slots[ self getxuidint64() ] = undefined;
}

// Namespace ability_manager
// Params 1, eflags: 0x4
// Checksum 0x87d763e7, Offset: 0x146f
// Size: 0x130
function private on_player_spawned( params )
{
    ability_slots = get_ability_slots();
    
    if ( !ability_slots.size )
    {
        return;
    }
    
    foreach ( slot, ability in ability_slots )
    {
        def = level.ability_manager.defs[ ability.ref ];
        function_e0ef53e3dd4b99d2( ability );
        init_ability_omnvar( ability );
        
        if ( 2 <= level.ability_manager.log_level )
        {
            logstring( "[AbilityMgr]" + " " + "respawn: re-arming slot '" + slot + "' with '" + ability.ref + "' for player " + self.name );
        }
        
        thread monitor_slot( def, ability.slot );
    }
}

// Namespace ability_manager
// Params 1, eflags: 0x4
// Checksum 0xbb4035cb, Offset: 0x15a7
// Size: 0x183
function private on_player_killed( params )
{
    profilestart();
    ability_slots = get_ability_slots();
    
    if ( !ability_slots.size )
    {
        profilestop();
        return;
    }
    
    foreach ( slot, ability in ability_slots )
    {
        def = level.ability_manager.defs[ ability.ref ];
        
        if ( ( ability.is_active || ability.var_214bc6cea3285fe4 ) && def.cleanup_func )
        {
            if ( 1 <= level.ability_manager.log_level )
            {
                logstring( "[AbilityMgr]" + " " + "death cleanup for active ability '" + ability.ref + "' on player " + self.name );
            }
            
            self thread [[ def.cleanup_func ]]( function_ee7172eb30cc9d68( def.ref, slot ) );
        }
        
        remove_binds( def, ability.slot );
        function_e0ef53e3dd4b99d2( ability );
        update_progress_omnvar( ability, 100 );
        update_status_omnvar( ability );
    }
    
    profilestop();
}

// Namespace ability_manager
// Params 1, eflags: 0x4
// Checksum 0x35147325, Offset: 0x1732
// Size: 0x30
function private get_ability_bundle( ref )
{
    return getscriptbundle( level.ability_manager.bundles[ ref ].bundle );
}

// Namespace ability_manager
// Params 2, eflags: 0x4
// Checksum 0xa6f2a0c2, Offset: 0x176b
// Size: 0x70
function private function_4e65acc84241bf3b( ref, field )
{
    assert( level.ability_manager.bundles[ ref ].bundle );
    assert( isxhash( field ) );
    return getscriptbundlefieldvalue( level.ability_manager.bundles[ ref ].bundle, field );
}

// Namespace ability_manager
// Params 0, eflags: 0x4
// Checksum 0x1d0428be, Offset: 0x17e4
// Size: 0x1b
function private get_ability_slots()
{
    return level.ability_manager.ability_slots[ self getxuidint64() ];
}

// Namespace ability_manager
// Params 1, eflags: 0x4
// Checksum 0xc075a0c0, Offset: 0x1808
// Size: 0x4d
function private function_e0ef53e3dd4b99d2( ability )
{
    ability.on_cooldown = 0;
    ability.is_active = 0;
    ability.var_214bc6cea3285fe4 = 0;
    ability.has_error = 0;
    ability.charge_fraction = 0;
}

// Namespace ability_manager
// Params 2, eflags: 0x4
// Checksum 0x8ab1a42b, Offset: 0x185d
// Size: 0x4b
function private function_ee7172eb30cc9d68( ref, slot )
{
    return { #charge_fraction:1, #var_83195f10e1e12a6a:function_46f903265663b45b( ref ), #slot:slot, #ref:ref };
}

// Namespace ability_manager
// Params 2, eflags: 0x4
// Checksum 0x65795de3, Offset: 0x18b1
// Size: 0xe4, Type: bool
function private function_cf9d662765c4ba5c( new_slot, ability_slots )
{
    var_b2f7a862c24946d6 = level.ability_manager.slots[ new_slot ];
    
    foreach ( ability in ability_slots )
    {
        var_4bcf4d570e8044a5 = level.ability_manager.slots[ ability.slot ];
        
        if ( function_a83ac7e42e9b3c22( new_slot, var_b2f7a862c24946d6, ability.slot, var_4bcf4d570e8044a5 ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace ability_manager
// Params 4, eflags: 0x4
// Checksum 0x711edfe2, Offset: 0x199e
// Size: 0xbc, Type: bool
function private function_a83ac7e42e9b3c22( slot_a, var_85b180d9fa04d3fb, slot_b, var_85b181d9fa04d62e )
{
    if ( function_77e82e5a032aa154( var_85b180d9fa04d3fb.binds, var_85b181d9fa04d62e.binds, slot_a, slot_b ) )
    {
        return true;
    }
    
    if ( function_77e82e5a032aa154( var_85b180d9fa04d3fb.binds, var_85b181d9fa04d62e.release_binds, slot_a, slot_b ) )
    {
        return true;
    }
    
    if ( function_77e82e5a032aa154( var_85b180d9fa04d3fb.release_binds, var_85b181d9fa04d62e.binds, slot_a, slot_b ) )
    {
        return true;
    }
    
    if ( function_77e82e5a032aa154( var_85b180d9fa04d3fb.release_binds, var_85b181d9fa04d62e.release_binds, slot_a, slot_b ) )
    {
        return true;
    }
    
    return false;
}

// Namespace ability_manager
// Params 4, eflags: 0x4
// Checksum 0x96883b4f, Offset: 0x1a63
// Size: 0xe9, Type: bool
function private function_77e82e5a032aa154( binds_a, binds_b, slot_a, slot_b )
{
    if ( !binds_a.size || !binds_b.size )
    {
        return false;
    }
    
    conflicts = arrayintersection( binds_a, binds_b );
    
    if ( conflicts.size == 0 )
    {
        return false;
    }
    
    /#
        foreach ( bind in conflicts )
        {
            assertmsg( "<dev string:x5b8>" + slot_a + "<dev string:x5d5>" + slot_b + "<dev string:x5e2>" + bind + "<dev string:x326>" );
        }
    #/
    
    return true;
}

// Namespace ability_manager
// Params 2, eflags: 0x4
// Checksum 0xe630682b, Offset: 0x1b55
// Size: 0x16b
function private setup_binds( def, slot )
{
    slot_data = level.ability_manager.slots[ slot ];
    activate_notify = "ability_manager_activate_" + def.ref;
    release_notify = "ability_manager_release_" + def.ref;
    
    foreach ( bind in slot_data.binds )
    {
        self notifyonplayercommand( activate_notify, bind );
    }
    
    if ( get_charge_settings( def.ref ) )
    {
        foreach ( bind in slot_data.release_binds )
        {
            self notifyonplayercommand( release_notify, bind );
        }
    }
}

// Namespace ability_manager
// Params 2, eflags: 0x4
// Checksum 0xfe7b2699, Offset: 0x1cc8
// Size: 0x16b
function private remove_binds( def, slot )
{
    slot_data = level.ability_manager.slots[ slot ];
    activate_notify = "ability_manager_activate_" + def.ref;
    release_notify = "ability_manager_release_" + def.ref;
    
    foreach ( bind in slot_data.binds )
    {
        self notifyonplayercommandremove( activate_notify, bind );
    }
    
    if ( get_charge_settings( def.ref ) )
    {
        foreach ( bind in slot_data.release_binds )
        {
            self notifyonplayercommandremove( release_notify, bind );
        }
    }
}

// Namespace ability_manager
// Params 2, eflags: 0x4
// Checksum 0x734a6548, Offset: 0x1e3b
// Size: 0x34d
function private monitor_slot( def, var_362be81e2d9fced7 )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( "ability_manager_cleared_" + def.ref );
    setup_binds( def, var_362be81e2d9fced7 );
    bundle = get_ability_bundle( def.ref );
    cooldown_seconds = bundle.cooldownseconds;
    charge = get_charge_settings( def.ref );
    
    while ( true )
    {
        self waittill( "ability_manager_activate_" + def.ref );
        ability_slots = get_ability_slots();
        ability = ability_slots[ var_362be81e2d9fced7 ];
        
        if ( ability.on_cooldown )
        {
            if ( 2 <= level.ability_manager.log_level )
            {
                logstring( "[AbilityMgr]" + " " + "activate blocked: '" + def.ref + "' on cooldown for player " + self.name );
            }
            
            thread ability_error( def, ability );
            continue;
        }
        
        def = level.ability_manager.defs[ ability.ref ];
        params = function_ee7172eb30cc9d68( def.ref, var_362be81e2d9fced7 );
        
        if ( !can_activate_ability( def, params ) )
        {
            if ( 2 <= level.ability_manager.log_level )
            {
                logstring( "[AbilityMgr]" + " " + "activate blocked: '" + def.ref + "' rejected by can_activate_func for player " + self.name );
            }
            
            thread ability_error( def, ability );
            continue;
        }
        
        ability.on_cooldown = 1;
        
        if ( isdefined( charge ) && !run_charge( def, ability, params, charge ) )
        {
            fail_charge( def, ability, params, charge );
            continue;
        }
        
        ability.is_active = 1;
        update_status_omnvar( ability );
        update_progress_omnvar( ability, 0 );
        
        if ( 1 <= level.ability_manager.log_level )
        {
            logstring( "[AbilityMgr]" + " " + "activated '" + def.ref + "' for player " + self.name );
        }
        
        self [[ def.activate_func ]]( params );
        ability.is_active = 0;
        ability.charge_fraction = 0;
        
        if ( cooldown_seconds )
        {
            update_status_omnvar( ability );
            monitor_cooldown_progress( cooldown_seconds, ability );
        }
        
        if ( 1 <= level.ability_manager.log_level )
        {
            logstring( "[AbilityMgr]" + " " + "cooldown expired for '" + def.ref + "' on player " + self.name );
        }
        
        ability.on_cooldown = 0;
        update_progress_omnvar( ability, 100 );
        update_status_omnvar( ability );
        
        if ( def.refresh_func )
        {
            profilestart();
            self [[ def.refresh_func ]]( params );
            profilestop();
        }
    }
}

// Namespace ability_manager
// Params 2, eflags: 0x4
// Checksum 0x782ea57e, Offset: 0x2190
// Size: 0x4f
function private can_activate_ability( def, params )
{
    profilestart();
    
    if ( self isnoclip() || self isufo() )
    {
        profilestop();
        return 0;
    }
    
    if ( !isdefined( def.can_activate_func ) )
    {
        profilestop();
        return 1;
    }
    
    profilestop();
    return self [[ def.can_activate_func ]]( params );
}

// Namespace ability_manager
// Params 4, eflags: 0x4
// Checksum 0xfce0dcc7, Offset: 0x21e9
// Size: 0x244, Type: bool
function private run_charge( def, ability, params, charge )
{
    ability.var_214bc6cea3285fe4 = 1;
    ability.charge_fraction = 0;
    update_status_omnvar( ability );
    update_progress_omnvar( ability, 0 );
    
    if ( 1 <= level.ability_manager.log_level )
    {
        logstring( "[AbilityMgr]" + " " + "charging '" + def.ref + "' for player " + self.name );
    }
    
    childthread function_1b5c5e1eb8124db7( def, params );
    childthread function_ee0dbcdceb802689( def, ability, charge );
    interrupt_notify = "ability_manager_interrupt_" + def.ref;
    result = utility::waittill_any_return( "ability_manager_release_" + def.ref, interrupt_notify );
    self notify( "ability_manager_charge_end_" + def.ref );
    ability.var_214bc6cea3285fe4 = 0;
    params.charge_fraction = ability.charge_fraction;
    
    if ( result == interrupt_notify )
    {
        if ( 1 <= level.ability_manager.log_level )
        {
            logstring( "[AbilityMgr]" + " " + "charge interrupted for '" + def.ref + "' on player " + self.name );
        }
        
        return false;
    }
    
    if ( ability.charge_fraction < charge.var_560e0db3a1c87896 )
    {
        if ( 2 <= level.ability_manager.log_level )
        {
            logstring( "[AbilityMgr]" + " " + "charge released short for '" + def.ref + "' on player " + self.name );
        }
        
        return false;
    }
    
    if ( !can_activate_ability( def, params ) )
    {
        if ( 2 <= level.ability_manager.log_level )
        {
            logstring( "[AbilityMgr]" + " " + "charge release rejected by can_activate_func for '" + def.ref + "' on player " + self.name );
        }
        
        return false;
    }
    
    return true;
}

// Namespace ability_manager
// Params 2, eflags: 0x4
// Checksum 0x40105d47, Offset: 0x2436
// Size: 0x3a
function private function_1b5c5e1eb8124db7( def, params )
{
    self endon( "ability_manager_charge_end_" + def.ref );
    self [[ def.charge_func ]]( params );
}

// Namespace ability_manager
// Params 4, eflags: 0x4
// Checksum 0x8096d2d2, Offset: 0x2478
// Size: 0x9f
function private fail_charge( def, ability, params, charge )
{
    if ( def.cleanup_func )
    {
        self thread [[ def.cleanup_func ]]( params );
    }
    
    ability.charge_fraction = 0;
    update_progress_omnvar( ability, 100 );
    fail_seconds = charge.var_c3ca9df87ea0117e;
    
    if ( !fail_seconds )
    {
        fail_seconds = undefined;
    }
    
    ability_error( def, ability, fail_seconds );
    ability.on_cooldown = 0;
    update_status_omnvar( ability );
}

// Namespace ability_manager
// Params 3, eflags: 0x4
// Checksum 0x5e6544, Offset: 0x251f
// Size: 0x188
function private function_ee0dbcdceb802689( def, ability, charge )
{
    self endon( "ability_manager_charge_end_" + def.ref );
    start_time = gettime();
    var_79e9f9d2dae26ef = charge.chargeseconds * 1000;
    full_time = undefined;
    
    while ( true )
    {
        fraction = ( gettime() - start_time ) / var_79e9f9d2dae26ef;
        
        if ( fraction > 1 )
        {
            fraction = 1;
        }
        
        ability.charge_fraction = fraction;
        progress = int( fraction * 100 );
        
        if ( progress != ability.progress )
        {
            update_progress_omnvar( ability, progress );
        }
        
        if ( fraction >= 1 )
        {
            if ( !isdefined( full_time ) )
            {
                full_time = gettime();
                self notify( "ability_manager_charge_full_" + def.ref );
            }
            
            if ( charge.var_78d4469306b298a6 >= 0 && gettime() - full_time >= charge.var_78d4469306b298a6 * 1000 )
            {
                if ( 2 <= level.ability_manager.log_level )
                {
                    logstring( "[AbilityMgr]" + " " + "max hold reached for '" + def.ref + "' on player " + self.name );
                }
                
                self notify( "ability_manager_release_" + def.ref );
                return;
            }
        }
        
        waitframe();
    }
}

// Namespace ability_manager
// Params 2, eflags: 0x4
// Checksum 0x943a33de, Offset: 0x26af
// Size: 0x87
function private monitor_cooldown_progress( cooldown_seconds, ability )
{
    start_time = gettime();
    var_79e9f9d2dae26ef = cooldown_seconds * 1000;
    
    while ( true )
    {
        elapsed_msec = gettime() - start_time;
        
        if ( elapsed_msec >= var_79e9f9d2dae26ef )
        {
            return;
        }
        
        progress = int( elapsed_msec / var_79e9f9d2dae26ef * 100 );
        
        if ( progress != ability.progress )
        {
            update_progress_omnvar( ability, progress );
        }
        
        waitframe();
    }
}

// Namespace ability_manager
// Params 3, eflags: 0x4
// Checksum 0xab28c81c, Offset: 0x273e
// Size: 0xa2
function private ability_error( def, ability, flash_seconds )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( "ability_manager_cleared_" + def.ref );
    
    if ( ability.has_error )
    {
        return;
    }
    
    if ( !isdefined( flash_seconds ) )
    {
        flash_seconds = getdvarfloat( @"hash_9ae5203c08d77cd3", 0.5 );
    }
    
    ability.has_error = 1;
    update_status_omnvar( ability );
    wait flash_seconds;
    ability.has_error = 0;
    update_status_omnvar( ability );
}

// Namespace ability_manager
// Params 0, eflags: 0x4
// Checksum 0x1fcfa2e6, Offset: 0x27e8
// Size: 0x86
function private function_d40a071a460f051a()
{
    ability_slots = get_ability_slots();
    
    for ( ui_slot = 0; ui_slot < 3 ; ui_slot++ )
    {
        if ( !isdefined( function_c45a9e301b6b6056( ability_slots, #ui_slot, ui_slot ) ) )
        {
            return ui_slot;
        }
    }
    
    if ( 0 <= level.ability_manager.log_level )
    {
        logstring( "[AbilityMgr]" + " " + "no free UI slot for player " + self.name + ", ability will have no UI" );
    }
    
    return -1;
}

// Namespace ability_manager
// Params 4, eflags: 0x4
// Checksum 0xd8292a80, Offset: 0x2877
// Size: 0x63
function private set_ability_omnvar( ability, bit_offset, bit_width, value )
{
    if ( ability.ui_slot == -1 )
    {
        return;
    }
    
    omnvar_utility::function_85d5f88af471ac4b( level.ability_manager.omnvar_slots[ ability.ui_slot ], bit_offset, bit_width, value );
}

// Namespace ability_manager
// Params 1, eflags: 0x4
// Checksum 0xd0d590eb, Offset: 0x28e2
// Size: 0x3d
function private init_ability_omnvar( ability )
{
    function_fe396bc9f85aaa4d( ability );
    function_bf69417aeb82a546( ability );
    function_be0cd731f11d77a6( ability, 1 );
    update_progress_omnvar( ability, 100 );
    update_status_omnvar( ability );
}

// Namespace ability_manager
// Params 1, eflags: 0x4
// Checksum 0xb548d01c, Offset: 0x2927
// Size: 0x36
function private function_5c94017994968c( ui_slot )
{
    if ( ui_slot == -1 )
    {
        return;
    }
    
    omnvar_utility::function_85d5f88af471ac4b( level.ability_manager.omnvar_slots[ ui_slot ], 0, 20, 0 );
}

// Namespace ability_manager
// Params 1, eflags: 0x4
// Checksum 0x3c69493d, Offset: 0x2965
// Size: 0x89
function private update_status_omnvar( ability )
{
    if ( ability.has_error )
    {
        state = 3;
    }
    else if ( ability.is_active )
    {
        state = 4;
    }
    else if ( ability.var_214bc6cea3285fe4 )
    {
        state = 5;
    }
    else if ( ability.on_cooldown )
    {
        state = 1;
    }
    else
    {
        state = 2;
    }
    
    set_ability_omnvar( ability, 0, 3, state );
    
    /#
        function_788a381c75959afb( ability, state );
    #/
}

// Namespace ability_manager
// Params 2, eflags: 0x4
// Checksum 0xeaac111c, Offset: 0x29f6
// Size: 0x3f
function private update_progress_omnvar( ability, progress )
{
    ability.progress = progress;
    set_ability_omnvar( ability, 3, 7, progress );
    
    /#
        function_7fa04bb4f6f01472( ability, progress );
    #/
}

// Namespace ability_manager
// Params 1, eflags: 0x4
// Checksum 0x4b87bdab, Offset: 0x2a3d
// Size: 0x58
function private function_fe396bc9f85aaa4d( ability )
{
    definition_index = level.ability_manager.bundles[ ability.ref ].index;
    
    if ( !isdefined( definition_index ) )
    {
        return;
    }
    
    set_ability_omnvar( ability, 10, 5, definition_index );
}

// Namespace ability_manager
// Params 1, eflags: 0x4
// Checksum 0xa80dd5bb, Offset: 0x2a9d
// Size: 0x42
function private function_bf69417aeb82a546( ability )
{
    set_ability_omnvar( ability, 15, 4, level.ability_manager.slots[ ability.slot ].index );
}

// Namespace ability_manager
// Params 2, eflags: 0x4
// Checksum 0x708bb8a1, Offset: 0x2ae7
// Size: 0x2d
function private function_be0cd731f11d77a6( ability, visible )
{
    set_ability_omnvar( ability, 19, 1, visible ? 1 : 0 );
}

/#

    // Namespace ability_manager
    // Params 1, eflags: 0x4
    // Checksum 0xe9ffb942, Offset: 0x2b1c
    // Size: 0x19a, Type: dev
    function private function_ecf4b3ff8bca6245( ability )
    {
        if ( !getdvarint( @"hash_c22a6484d41e6081", 0 ) )
        {
            return;
        }
        
        if ( ability.ui_slot == -1 )
        {
            return;
        }
        
        if ( !isdefined( self.var_a00343ba17a00f4a ) )
        {
            self.var_a00343ba17a00f4a = [];
        }
        
        row_y = 200 + 24 * ability.ui_slot;
        label = hud_util::createfontstring( "<dev string:x5ee>", 1.2 );
        label.x = 15;
        label.y = row_y;
        label.alignx = "<dev string:x5f6>";
        label.aligny = "<dev string:x5fb>";
        label.horzalign = "<dev string:x5ff>";
        label.vertalign = "<dev string:x60f>";
        label.alpha = 1;
        label.glowalpha = 0;
        label.hidewheninmenu = 1;
        label.archived = 0;
        bar = hud_util::createbar( ( 1, 1, 1 ), 120, 6 );
        bar hud_util::setpoint( "<dev string:x61e>", "<dev string:x61e>", 165, row_y );
        bar.hidewheninmenu = 1;
        bar.archived = 0;
        self.var_a00343ba17a00f4a[ ability.ref ] = { #bar:bar, #label:label };
    }

    // Namespace ability_manager
    // Params 1, eflags: 0x4
    // Checksum 0xf0fac81b, Offset: 0x2cbe
    // Size: 0x71, Type: dev
    function private function_cb67c6c7122588df( ability )
    {
        hud = self.var_a00343ba17a00f4a[ ability.ref ];
        
        if ( !isdefined( hud ) )
        {
            return;
        }
        
        hud.label hud_util::destroyelem();
        hud.bar hud_util::destroyelem();
        self.var_a00343ba17a00f4a[ ability.ref ] = undefined;
    }

    // Namespace ability_manager
    // Params 2, eflags: 0x4
    // Checksum 0x8d0ceb45, Offset: 0x2d37
    // Size: 0x93, Type: dev
    function private function_788a381c75959afb( ability, state )
    {
        hud = self.var_a00343ba17a00f4a[ ability.ref ];
        
        if ( !isdefined( hud ) )
        {
            return;
        }
        
        hud.label setdevtext( ability.ref + "<dev string:x626>" + debug_hud_state_name( state ) );
        hud.bar.bar.color = function_482a5546844ffb81( state );
    }

    // Namespace ability_manager
    // Params 2, eflags: 0x4
    // Checksum 0x44369ccf, Offset: 0x2dd2
    // Size: 0x58, Type: dev
    function private function_7fa04bb4f6f01472( ability, progress )
    {
        hud = self.var_a00343ba17a00f4a[ ability.ref ];
        
        if ( !isdefined( hud ) )
        {
            return;
        }
        
        hud.bar hud_util::updatebar( progress / 100 );
    }

    // Namespace ability_manager
    // Params 1, eflags: 0x4
    // Checksum 0xffeb096d, Offset: 0x2e32
    // Size: 0x97, Type: dev
    function private debug_hud_state_name( state )
    {
        switch ( state )
        {
            case 0:
                return "<dev string:x629>";
            case 1:
                return "<dev string:x62e>";
            case 2:
                return "<dev string:x637>";
            case 3:
                return "<dev string:x63d>";
            case 4:
                return "<dev string:x642>";
            case 5:
                return "<dev string:x649>";
            default:
                return "<dev string:x652>";
        }
    }

    // Namespace ability_manager
    // Params 1, eflags: 0x4
    // Checksum 0x68079f04, Offset: 0x2ed1
    // Size: 0x9b, Type: dev
    function private function_482a5546844ffb81( state )
    {
        switch ( state )
        {
            case 5:
                return ( 1, 0.8, 0 );
            case 1:
                return ( 0.3, 0.5, 1 );
            case 3:
                return ( 1, 0.2, 0.2 );
            case 4:
                return ( 0.2, 1, 0.2 );
            default:
                return ( 1, 1, 1 );
        }
    }

    // Namespace ability_manager
    // Params 0, eflags: 0x4
    // Checksum 0x742af843, Offset: 0x2f74
    // Size: 0x34d, Type: dev
    function private init_debug()
    {
        setdvarifuninitialized( @"hash_65179bb81f88efed", 0, 0, 17 );
        setdvarifuninitialized( @"hash_5cb6413598119127", -1, -1, 2 );
        devgui::function_9082edeb5db93280( "<dev string:x65a>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x66e>", "<dev string:x683>", &function_3dca4a05852c6e03 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x693>", "<dev string:x6a5>", &function_3dca4a05852c6e03 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x6b4>", "<dev string:x6c5>", &function_3dca4a05852c6e03 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x6d4>", "<dev string:x6e8>", &function_3dca4a05852c6e03 );
        devgui::add_devgui_dvar( "<dev string:x6f7>", @"hash_65179bb81f88efed", 2 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x706>", "<dev string:x722>", &function_cd193d19525d1b4e );
        devgui::function_cd4e263c1f3018ae( "<dev string:x732>", "<dev string:x751>", &function_cd193d19525d1b4e );
        devgui::function_cd4e263c1f3018ae( "<dev string:x763>", "<dev string:x782>", &function_cd193d19525d1b4e );
        
        foreach ( var_362be81e2d9fced7, slot in level.ability_manager.slots )
        {
            devgui::function_cd4e263c1f3018ae( "<dev string:x794>" + var_362be81e2d9fced7, "<dev string:x7a3>" + var_362be81e2d9fced7, &function_c9afe6c7ce65a270 );
        }
        
        foreach ( ref, def in level.ability_manager.defs )
        {
            devgui::function_cd4e263c1f3018ae( ref + "<dev string:x7ac>", "<dev string:x7b9>" + ref, &function_aab81b8070ca8b25 );
            devgui::function_cd4e263c1f3018ae( ref + "<dev string:x7c9>", "<dev string:x7d9>" + ref, &function_aab81b8070ca8b25 );
            devgui::function_cd4e263c1f3018ae( ref + "<dev string:x7eb>", "<dev string:x7fb>" + ref, &function_aab81b8070ca8b25 );
            devgui::function_cd4e263c1f3018ae( ref + "<dev string:x80d>", "<dev string:x81c>" + ref, &function_76a30005a3e0a82a );
            devgui::function_cd4e263c1f3018ae( ref + "<dev string:x82e>", "<dev string:x840>" + ref, &function_76a30005a3e0a82a );
            devgui::function_cd4e263c1f3018ae( ref + "<dev string:x854>", "<dev string:x866>" + ref, &function_76a30005a3e0a82a );
            devgui::function_cd4e263c1f3018ae( ref + "<dev string:x87a>", "<dev string:x895>" + ref, &function_5c0ae3c0d0c62c71 );
            devgui::function_cd4e263c1f3018ae( ref + "<dev string:x8a7>", "<dev string:x8c5>" + ref, &function_5c0ae3c0d0c62c71 );
            devgui::function_cd4e263c1f3018ae( ref + "<dev string:x8d9>", "<dev string:x8f7>" + ref, &function_5c0ae3c0d0c62c71 );
            devgui::function_cd4e263c1f3018ae( ref + "<dev string:x90b>", "<dev string:x925>" + ref, &function_9eedbe0692659dfa );
            devgui::function_cd4e263c1f3018ae( ref + "<dev string:x936>", "<dev string:x953>" + ref, &function_9eedbe0692659dfa );
            devgui::function_cd4e263c1f3018ae( ref + "<dev string:x966>", "<dev string:x983>" + ref, &function_9eedbe0692659dfa );
        }
        
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace ability_manager
    // Params 1, eflags: 0x4
    // Checksum 0xfde82988, Offset: 0x32c9
    // Size: 0xb1, Type: dev
    function private function_cd193d19525d1b4e( params )
    {
        player = function_9e40af51e99b02db( params[ 0 ] );
        
        if ( !player )
        {
            return;
        }
        
        entity_num = player getxuidint64();
        level.ability_manager.var_4cc3d6cdce87e92c[ entity_num ] = !level.ability_manager.var_4cc3d6cdce87e92c[ entity_num ];
        
        if ( level.ability_manager.var_4cc3d6cdce87e92c[ entity_num ] )
        {
            player thread function_8da6ef2e7047226c();
            return;
        }
        
        player notify( #"hash_79b5a75fef93f4a0" );
        level.ability_manager.var_4cc3d6cdce87e92c[ entity_num ] = undefined;
    }

    // Namespace ability_manager
    // Params 0, eflags: 0xc
    // Checksum 0x7b996455, Offset: 0x3382
    // Size: 0x3d3, Type: dev
    function private function_8da6ef2e7047226c()
    {
        self notify( #"hash_82613c92b8744d45" );
        self endon( #"hash_82613c92b8744d45" );
        level endon( #"game_ended" );
        self endon( #"disconnect" );
        self endon( #"hash_79b5a75fef93f4a0" );
        entity_num = self getxuidint64();
        
        while ( true )
        {
            pos_x = 48;
            pos_y = 400;
            line_h = 18;
            color = ( 0.8, 1, 0.8 );
            var_4b4c3bda6f10b0f8 = level.ability_manager.slots.size * 2 + 2;
            overlay_index = function_f02c63b99c9614c9( getarraykeys( level.ability_manager.var_4cc3d6cdce87e92c ), entity_num );
            line_index = overlay_index * var_4b4c3bda6f10b0f8;
            printtoscreen2d( pos_x, pos_y + line_h * line_index, "<dev string:x996>" + "<dev string:x9a3>" + self.name + "<dev string:x9a5>" + self getentitynumber() + "<dev string:x9a5>" + ( level.ability_manager.debug_slot ?? "<dev string:x9a9>" ), color, 1.25, 1 );
            line_index++;
            ability_slots = get_ability_slots();
            
            if ( !isdefined( ability_slots ) )
            {
                printtoscreen2d( pos_x, pos_y + line_h * line_index, "<dev string:x9b6>", ( 1, 0.3, 0.3 ), 1, 1 );
            }
            else
            {
                foreach ( var_362be81e2d9fced7, slot in level.ability_manager.slots )
                {
                    ability = ability_slots[ var_362be81e2d9fced7 ];
                    
                    if ( !isdefined( ability ) )
                    {
                        printtoscreen2d( pos_x, pos_y + line_h * line_index, "<dev string:x9cf>" + var_362be81e2d9fced7 + "<dev string:x9d5>", ( 0.7, 0.7, 0.7 ), 1, 1 );
                        line_index++;
                        continue;
                    }
                    
                    var_f8ce25e924ec5bfe = ability.ref;
                    var_4905cdcf563ab1d6 = 0;
                    
                    if ( ability.ui_slot != -1 )
                    {
                        var_4905cdcf563ab1d6 = omnvar_utility::function_feb50abd0ba8a2e7( level.ability_manager.omnvar_slots[ ability.ui_slot ], 0, 20 );
                    }
                    
                    line_text = "<dev string:x9cf>" + var_362be81e2d9fced7 + "<dev string:x9e2>" + var_f8ce25e924ec5bfe + "<dev string:x9ec>" + ability.is_active + "<dev string:x9f5>" + ability.var_214bc6cea3285fe4 + "<dev string:xa00>" + ability.on_cooldown;
                    printtoscreen2d( pos_x, pos_y + line_h * line_index, line_text, color, 1, 1 );
                    line_index++;
                    line_text = "<dev string:xa0b>" + ability.ui_slot + "<dev string:xa13>" + ( level.ability_manager.bundles[ ability.ref ].index ?? -1 ) + "<dev string:xa19>" + level.ability_manager.slots[ ability.slot ].index + "<dev string:xa23>" + ability.progress + "<dev string:xa2e>" + ability.charge_fraction + "<dev string:xa37>" + var_4905cdcf563ab1d6;
                    printtoscreen2d( pos_x, pos_y + line_h * line_index, line_text, color, 1, 1 );
                    line_index++;
                }
            }
            
            waitframe();
        }
    }

    // Namespace ability_manager
    // Params 1, eflags: 0x4
    // Checksum 0xfe335840, Offset: 0x375d
    // Size: 0x26, Type: dev
    function private function_c9afe6c7ce65a270( params )
    {
        level.ability_manager.debug_slot = params[ 0 ];
    }

    // Namespace ability_manager
    // Params 1, eflags: 0x4
    // Checksum 0x456b59b6, Offset: 0x378b
    // Size: 0x4b, Type: dev
    function private function_3dca4a05852c6e03( params )
    {
        level.ability_manager.log_level = int( params[ 0 ] );
        setdvar( @"hash_5cb6413598119127", level.ability_manager.log_level );
    }

    // Namespace ability_manager
    // Params 1, eflags: 0x4
    // Checksum 0xce8f95cb, Offset: 0x37de
    // Size: 0x7f, Type: dev
    function private function_aab81b8070ca8b25( params )
    {
        if ( !level.ability_manager.debug_slot )
        {
            iprintlnbold( "<dev string:xa40>" );
            return;
        }
        
        player = function_9e40af51e99b02db( params[ 0 ] );
        ref = params[ 1 ];
        
        if ( !player || !ref )
        {
            return;
        }
        
        player assign_ability( ref, level.ability_manager.debug_slot );
    }

    // Namespace ability_manager
    // Params 1, eflags: 0x4
    // Checksum 0x52ee1abd, Offset: 0x3865
    // Size: 0x4a, Type: dev
    function private function_76a30005a3e0a82a( params )
    {
        player = function_9e40af51e99b02db( params[ 0 ] );
        ref = params[ 1 ];
        
        if ( !player || !ref )
        {
            return;
        }
        
        player function_38de268b81340e01( ref );
    }

    // Namespace ability_manager
    // Params 1, eflags: 0x4
    // Checksum 0xd97e86ab, Offset: 0x38b7
    // Size: 0x6a, Type: dev
    function private function_5c0ae3c0d0c62c71( params )
    {
        player = function_9e40af51e99b02db( params[ 0 ] );
        ref = params[ 1 ];
        
        if ( !player || !ref )
        {
            return;
        }
        
        def = level.ability_manager.defs[ ref ];
        player thread function_827cfe78f9c68717( def );
    }

    // Namespace ability_manager
    // Params 1, eflags: 0x4
    // Checksum 0xbf337a0f, Offset: 0x3929
    // Size: 0x97, Type: dev
    function private function_827cfe78f9c68717( def )
    {
        level endon( #"game_ended" );
        self endon( #"death_or_disconnect" );
        self endon( "<dev string:xa69>" + def.ref );
        self endon( "<dev string:xa82>" + def.ref );
        ability = function_d9911c70ee1ac503( def.ref );
        self [[ def.activate_func ]]( function_ee7172eb30cc9d68( def.ref, ability.slot ) );
    }

    // Namespace ability_manager
    // Params 1, eflags: 0x4
    // Checksum 0x5b821e3e, Offset: 0x39c8
    // Size: 0xb2, Type: dev
    function private function_9eedbe0692659dfa( params )
    {
        player = function_9e40af51e99b02db( params[ 0 ] );
        ref = params[ 1 ];
        
        if ( !player || !ref )
        {
            return;
        }
        
        def = level.ability_manager.defs[ ref ];
        
        if ( !def.cleanup_func )
        {
            return;
        }
        
        player notify( "<dev string:xa82>" + ref );
        ability = player function_d9911c70ee1ac503( ref );
        player thread [[ def.cleanup_func ]]( function_ee7172eb30cc9d68( ref, ability.slot ) );
    }

    // Namespace ability_manager
    // Params 1, eflags: 0x4
    // Checksum 0xc9bc5e9d, Offset: 0x3a82
    // Size: 0xbb, Type: dev
    function private function_9e40af51e99b02db( target )
    {
        if ( target == "<dev string:xa9d>" )
        {
            return level.players[ 0 ];
        }
        
        if ( target == "<dev string:xaa2>" )
        {
            return level.players[ getdvarint( @"hash_65179bb81f88efed" ) ];
        }
        
        host = level.players[ 0 ];
        forward = anglestoforward( host getplayerangles() );
        trace = trace::ray_trace( host geteye(), host geteye() + forward * 1000, host );
        
        if ( trace[ "<dev string:xaa9>" ] && isplayer( trace[ "<dev string:xaa9>" ] ) )
        {
            return trace[ "<dev string:xaa9>" ];
        }
        
        return;
    }

#/
