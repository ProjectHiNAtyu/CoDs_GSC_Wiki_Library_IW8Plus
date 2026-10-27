// scripts\mp\ob\activities\ob_activity_utility.gsc  (hash_096d3ed6f46e10f4.gscc) (size: 20783 Bytes / 0x512f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x58bbfb20 (1488714528)
// size ...... 20783 (0x512f)
// includes .. 31  (offset: 0x4cdf)
// strings ... 37  (offset: 0x4dd7)
// dev strs .. 26  (offset: 0x4fd3)
// exports ... 57  (offset: 0x3133)
// cseg ...... 0x343 + 0x2df0 (0x3133)
// imports ... 161 (offset: 0x3a1b)
// animtree1 . 0   (offset: 0x512f)
// animtree2 . 0   (offset: 0x512f)
#using script_3edd59d0d3fc3262;
#using script_4e1f1a7ef824ddd5;
#using script_4eb10b8076cd40c;
#using script_61b40095fd0502f0;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_player_broadcasting;
#using scripts\common\activity_nexus\activity_player_common;
#using scripts\common\callbacks;
#using scripts\common\killstreaks\killstreak_common;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_sentry_turret;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\killstreaks\dawg_mp;
#using scripts\mp\common\killstreaks\ground_drone_unit_mp;
#using scripts\mp\common\utility\entity;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\emp_debuff;
#using scripts\mp\gametypes\ob;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;
#using scripts\mp\ob\ob_soldier_util;
#using scripts\mp\ob\systems\ob_activity_manager;
#using scripts\mp\ob\systems\ob_resource_manager;
#using scripts\mp\ob\systems\region_difficulty_manager;
#using scripts\mp\overlord;

#namespace ob_activity_utility;

// Namespace ob_activity_utility
// Params 0, eflags: 0x1
// Checksum 0x5d1dcf6f, Offset: 0x361
// Size: 0xad
function autoexec main()
{
    level callback::add( "activities_registered", &function_14a82ff172667871 );
    function_dc134e545eb7ba98();
    thread function_4c0c5c655fe0972e();
    level.setup_linked_activities_throttle = throttle::throttle_initialize( "setup_linked_activities", 1 );
    var_bb86f77304f193c4 = ob::get_ob_settings();
    level.var_11d170def6f138c8 = var_bb86f77304f193c4.var_a70d76070fb9e40c;
    level.var_5ce446dbab1ef427 = [];
    level.var_548de8bedb4418f4 = [];
    level.var_548de8bedb4418f4[ "ob_ai_turret" ] = &function_cdf739f72d3d5189;
    level.var_40ec5338fb7bc8ef = [];
    level.var_40ec5338fb7bc8ef[ "ob_ai_turret" ] = &function_de2880eddd20e235;
    thread function_efd4bbd8925ab8b9();
}

// Namespace ob_activity_utility
// Params 0
// Checksum 0x57a4cab4, Offset: 0x416
// Size: 0x24
function function_dc134e545eb7ba98()
{
    if ( !isdefined( level.sentrysettings[ "ai_sentry_turret" ] ) )
    {
        ai_sentry_turret::init();
    }
    
    ob_soldier_util::function_ee2d8b51c96bb64a();
}

// Namespace ob_activity_utility
// Params 0
// Checksum 0xd8cee478, Offset: 0x442
// Size: 0x167
function function_1467dab20b2d22()
{
    var_687bebb4c84063f4 = [];
    
    foreach ( delayed_entity in level.var_5ce446dbab1ef427 )
    {
        if ( delayed_entity.spawn_struct.activity_instance != self )
        {
            continue;
        }
        
        var_687bebb4c84063f4[ var_687bebb4c84063f4.size ] = delayed_entity;
        
        if ( !delayed_entity.spawned )
        {
            continue;
        }
        
        if ( delayed_entity.entity )
        {
            delayed_entity.spawn_struct.activity_instance [[ level.var_40ec5338fb7bc8ef[ delayed_entity.delayedspawntype ] ]]( delayed_entity );
        }
    }
    
    foreach ( delayed_entity in var_687bebb4c84063f4 )
    {
        level.var_5ce446dbab1ef427 = arrayremove( level.var_5ce446dbab1ef427, delayed_entity );
    }
}

// Namespace ob_activity_utility
// Params 5
// Checksum 0x11698e75, Offset: 0x5b1
// Size: 0x67
function ob_activity_spawn_turret( struct, callback, owner, var_fde960703f3de0f, var_fde970703f3e042 )
{
    struct.delayedspawntype = "ob_ai_turret";
    struct.var_fde960703f3de0f = var_fde960703f3de0f;
    struct.var_fde970703f3e042 = var_fde970703f3e042;
    return function_c980b094258046b9( struct, callback, owner );
}

// Namespace ob_activity_utility
// Params 3, eflags: 0x4
// Checksum 0xeca67096, Offset: 0x621
// Size: 0x73
function private function_c980b094258046b9( struct, callback, owner )
{
    struct.var_bcbe4f7f70951e0 = 1;
    struct.var_cf34d10873711169 = callback;
    struct.spawn_struct = { #owner:owner, #activity_instance:self };
    level.var_5ce446dbab1ef427[ level.var_5ce446dbab1ef427.size ] = struct;
}

// Namespace ob_activity_utility
// Params 0, eflags: 0x4
// Checksum 0xf39fc5f6, Offset: 0x69d
// Size: 0x134
function private function_efd4bbd8925ab8b9()
{
    while ( true )
    {
        foreach ( delayed_spawn_struct in level.var_5ce446dbab1ef427 )
        {
            playersinradius = getplayersinradius( delayed_spawn_struct.origin, level.var_11d170def6f138c8 );
            
            if ( playersinradius.size != 0 )
            {
                if ( !delayed_spawn_struct.spawned )
                {
                    delayed_spawn_struct.spawn_struct.activity_instance [[ level.var_548de8bedb4418f4[ delayed_spawn_struct.delayedspawntype ] ]]( delayed_spawn_struct );
                }
                
                continue;
            }
            
            if ( delayed_spawn_struct.spawned && delayed_spawn_struct.entity )
            {
                delayed_spawn_struct.spawn_struct.activity_instance [[ level.var_40ec5338fb7bc8ef[ delayed_spawn_struct.delayedspawntype ] ]]( delayed_spawn_struct );
            }
        }
        
        wait 1;
    }
}

// Namespace ob_activity_utility
// Params 1, eflags: 0x4
// Checksum 0x8ea1ea9d, Offset: 0x7d9
// Size: 0x62
function private function_de2880eddd20e235( delayed_spawn_struct )
{
    delayed_spawn_struct.entity notify( #"kill_turret", delayed_spawn_struct.var_fde960703f3de0f, delayed_spawn_struct.var_fde970703f3e042 );
    ob_resource_manager::function_360d7e0860217cf4( delayed_spawn_struct.entity );
    delayed_spawn_struct.entity = undefined;
    delayed_spawn_struct.spawned = 0;
}

// Namespace ob_activity_utility
// Params 1, eflags: 0x4
// Checksum 0xf4b75a12, Offset: 0x843
// Size: 0xb2
function private function_cdf739f72d3d5189( delayed_spawn_struct )
{
    sentry = ob_soldier_util::ob_sentry_turret_spawn( delayed_spawn_struct );
    sentry.owner = delayed_spawn_struct.owner;
    sentry.is_sentry = 1;
    delayed_spawn_struct.spawned = 1;
    delayed_spawn_struct.entity = sentry;
    ob_resource_manager::function_4d956586279ad989( sentry );
    
    if ( isdefined( sentry.colmodel ) )
    {
        sentry.colmodel show();
    }
    
    if ( delayed_spawn_struct.var_cf34d10873711169 )
    {
        sentry [[ delayed_spawn_struct.var_cf34d10873711169 ]]( delayed_spawn_struct.spawn_struct );
    }
}

// Namespace ob_activity_utility
// Params 0
// Checksum 0x428ef4fe, Offset: 0x8fd
// Size: 0x41
function function_d12ca4c58fe5faf0()
{
    if ( !isdefined( level.ob_fake_trap_owner ) )
    {
        level.ob_fake_trap_owner = ob_create_trap_owner();
        level.ob_fake_trap_owner.targetname = "fake_trap_owner";
    }
    
    return level.ob_fake_trap_owner;
}

// Namespace ob_activity_utility
// Params 1
// Checksum 0xe344145c, Offset: 0x947
// Size: 0x33
function ob_create_trap_owner( origin )
{
    fakeent = utility::spawn_tag_origin( origin );
    fakeent.team = "team_hundred_ninety";
    return fakeent;
}

// Namespace ob_activity_utility
// Params 6
// Checksum 0xc8b09ea2, Offset: 0x983
// Size: 0xb5
function function_311417deee5b4c1c( enabled = 1, goalradius = 600, var_fdb8cea7b59d24a7 = 1000, var_9527799d8958e9d8 = 1000, var_7dc98687161b176a = 1200, var_dbf2777cf444eb01 = 120 )
{
    self.var_a2591b7b6a16fd5d = enabled;
    self.var_98cf63ab16b959b0 = goalradius;
    self.var_a121ed2739a790f2 = var_fdb8cea7b59d24a7;
    self.var_4edc38d4c8a9c8a1 = var_9527799d8958e9d8;
    self.var_474b847739dc06a5 = var_7dc98687161b176a;
    self.var_67b408e641f22e42 = var_dbf2777cf444eb01;
}

// Namespace ob_activity_utility
// Params 6
// Checksum 0x7c57952, Offset: 0xa40
// Size: 0x38b
function function_894ac80e038636c5( var_516c054ba706c01d, recipient_list, handler_list, delay, var_bd72145694cf4d00, var_af3d85cfc12c8d60 )
{
    if ( !activity_instance_common::isactivityinstance( self ) )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    var_bdff29cb8b08ca81 = namespace_9085ae059032a84f::function_f9aac5b745dab95a( self );
    
    if ( var_bdff29cb8b08ca81 )
    {
        return;
    }
    
    if ( !isdefined( recipient_list ) )
    {
        recipient_list = self.playerparticipants;
    }
    
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    foreach ( player in recipient_list )
    {
        if ( isfunction( var_bd72145694cf4d00 ) )
        {
            var_516c054ba706c01d = [[ var_bd72145694cf4d00 ]]( player, var_516c054ba706c01d );
        }
        
        if ( !isdefined( handler_list ) )
        {
            handler_list = function_9394208f4c48dda0( var_516c054ba706c01d, player );
        }
        
        if ( !isarray( handler_list ) || handler_list.size == 0 )
        {
            /#
                logstring( "<dev string:x5c>" + var_516c054ba706c01d + "<dev string:x6d>" );
            #/
            
            return;
        }
        
        handler = function_85000f9bc6872d03( handler_list, player );
        
        if ( !isstring( handler ) )
        {
            assertmsg( "<dev string:xaf>" );
            return;
        }
        
        /#
            var_39b127242f3e06f0 = getdvar( @"hash_e4a0f2e1f5ccb2f9", "<dev string:xcc>" );
            
            if ( var_39b127242f3e06f0 != "<dev string:xcc>" )
            {
                handler = "<dev string:xcd>" + var_39b127242f3e06f0;
            }
        #/
        
        /#
            iprintlnbold( "<dev string:xcf>" + handler + "<dev string:xd3>" + var_516c054ba706c01d + "<dev string:xf2>" + player.name + "<dev string:x102>" );
        #/
        
        activity_player_broadcasting::function_cb4750c84882dd07( var_516c054ba706c01d + handler, [ player ] );
        thread function_3d23ffc29175b666( var_516c054ba706c01d, handler, var_af3d85cfc12c8d60, player );
    }
    
    /#
        if ( !isarray( recipient_list ) || recipient_list.size == 0 )
        {
            logstring( "<dev string:x106>" + handler + "<dev string:x117>" + var_516c054ba706c01d + "<dev string:x120>" );
            return;
        }
        
        broadcastinstancestructs = namespace_2aca03e533f9f843::function_a9c87ab2939586d3( var_516c054ba706c01d + handler, self );
        
        if ( !isdefined( broadcastinstancestructs ) || broadcastinstancestructs.size == 0 )
        {
            logstring( "<dev string:x106>" + handler + "<dev string:x117>" + var_516c054ba706c01d + "<dev string:x14c>" );
            return;
        }
        
        foreach ( struct in broadcastinstancestructs )
        {
            if ( istrue( struct.broadcastdefinition.var_f5f468009a5b98c3 ) && isdefined( self.playerparticipants ) && arraycontains( self.playerparticipants, recipient_list[ 0 ] ) )
            {
                logstring( "<dev string:x106>" + handler + "<dev string:x117>" + var_516c054ba706c01d + "<dev string:x1c4>" );
            }
            
            if ( !namespace_e55955ff7520be97::function_a5abbbd5e6dac189( recipient_list[ 0 ], [ self ] ) && !istrue( struct.broadcastdefinition.var_e3b59605ee21ecf9 ) )
            {
                focused_activity = namespace_e55955ff7520be97::function_e811448130016c90( recipient_list[ 0 ] );
                logstring( "<dev string:x106>" + handler + "<dev string:x117>" + var_516c054ba706c01d + "<dev string:x205>" + focused_activity.varianttag + "<dev string:x254>" );
            }
        }
    #/
}

// Namespace ob_activity_utility
// Params 4, eflags: 0x4
// Checksum 0x318a3102, Offset: 0xdd3
// Size: 0xaf
function private function_3d23ffc29175b666( var_d4fb4211fa314e58, handler, clapback_callback, player )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    clapback_array = undefined;
    
    if ( isfunction( clapback_callback ) )
    {
        clapback_array = [[ clapback_callback ]]( var_d4fb4211fa314e58 + handler );
    }
    
    if ( isarray( clapback_array ) )
    {
        wait get_conversation_cooldown_time( var_d4fb4211fa314e58 + handler );
        var_19a9b5fe9e231623 = function_f4eab4031266ea3b( clapback_array[ 0 ], player );
        
        if ( isdefined( clapback_array[ 1 ] ) )
        {
            wait get_conversation_cooldown_time( var_19a9b5fe9e231623 );
            activity_player_broadcasting::function_cb4750c84882dd07( clapback_array[ 1 ] + handler, [ player ] );
        }
    }
}

// Namespace ob_activity_utility
// Params 2, eflags: 0x4
// Checksum 0xed7f85e5, Offset: 0xe8a
// Size: 0x104
function private function_9394208f4c48dda0( var_516c054ba706c01d, player )
{
    handler_list = [];
    var_b1ba7093e66d7dfb = namespace_9085ae059032a84f::function_4dbc827bb8b7e595( self ).var_3184d3dd50546cc3;
    
    foreach ( name, array in var_b1ba7093e66d7dfb )
    {
        nametok = strtok( name, "_" );
        
        if ( nametok[ 0 ] == var_516c054ba706c01d )
        {
            handler_list[ handler_list.size ] = "_" + nametok[ 1 ];
        }
    }
    
    if ( !story_contract_util::is_activity_completed( player, #"libra_complete" ) )
    {
        if ( arraycontains( handler_list, "_razor" ) )
        {
            handler_list = arrayremove( handler_list, "_razor" );
        }
    }
    
    return handler_list;
}

// Namespace ob_activity_utility
// Params 2, eflags: 0x4
// Checksum 0x1b3bbf79, Offset: 0xf97
// Size: 0xca
function private function_85000f9bc6872d03( handler_list, player )
{
    if ( !isdefined( self.var_b91228339d5bfc5c ) )
    {
        self.var_b91228339d5bfc5c = [];
    }
    
    if ( !self.var_b91228339d5bfc5c[ player.guid ] )
    {
        self.var_b91228339d5bfc5c[ player.guid ] = function_fdd66c79e8313a16( player );
    }
    
    var_5042b16c0bc1b7f9 = arrayremove( [ "_karma", "_marshall" ], self.var_b91228339d5bfc5c[ player.guid ] );
    var_58b81a3c3e0db0ed = arrayremove( handler_list, var_5042b16c0bc1b7f9 );
    handler = utility::array_random( var_58b81a3c3e0db0ed );
    assert( isdefined( handler ) );
    return handler;
}

// Namespace ob_activity_utility
// Params 1, eflags: 0x4
// Checksum 0x16e6757, Offset: 0x106a
// Size: 0x9a
function private function_fdd66c79e8313a16( player )
{
    if ( player.activities.var_3d924463fc53fc41 )
    {
        main_handler = utility::array_random( arrayremove( [ "_karma", "_marshall" ], player.activities.var_3d924463fc53fc41 ) );
    }
    else
    {
        main_handler = utility::array_random( [ "_karma", "_marshall" ] );
    }
    
    player.activities.var_3d924463fc53fc41 = main_handler;
    return main_handler;
}

// Namespace ob_activity_utility
// Params 2, eflags: 0x4
// Checksum 0x70573104, Offset: 0x110d
// Size: 0x52
function private function_f4eab4031266ea3b( var_516c054ba706c01d, player )
{
    var_c95d888d0704ae2a = function_9394208f4c48dda0( var_516c054ba706c01d, player );
    handler = utility::array_random( var_c95d888d0704ae2a );
    activity_player_broadcasting::function_cb4750c84882dd07( var_516c054ba706c01d + handler, [ player ] );
    return var_516c054ba706c01d + handler;
}

// Namespace ob_activity_utility
// Params 1
// Checksum 0xff75065e, Offset: 0x1168
// Size: 0x1bd
function get_conversation_cooldown_time( activation_name )
{
    var_bdff29cb8b08ca81 = namespace_9085ae059032a84f::function_f9aac5b745dab95a( self );
    
    if ( var_bdff29cb8b08ca81 || !isdefined( activation_name ) )
    {
        return 1;
    }
    
    waittime = 0;
    broadcastinstancestructs = namespace_2aca03e533f9f843::function_a9c87ab2939586d3( activation_name, self );
    
    foreach ( struct in broadcastinstancestructs )
    {
        foreach ( obj in struct.broadcastdataobjects )
        {
            if ( isdefined( obj.var_3543d9eb46f58f8e ) )
            {
                hash_ref = getxhash( obj.var_3543d9eb46f58f8e );
                
                if ( obj.isoverlordconversation )
                {
                    waittime += overlord::function_e4b6b75b01ea6bc9( hash_ref );
                    continue;
                }
                
                if ( isnumber( level.overlord.events[ hash_ref ].timeout ) )
                {
                    waittime += level.overlord.events[ hash_ref ].timeout;
                }
            }
        }
    }
    
    return waittime + 0.5;
}

// Namespace ob_activity_utility
// Params 0
// Checksum 0xbc98231e, Offset: 0x132e
// Size: 0x16b
function function_4c0c5c655fe0972e()
{
    utility::flag_wait( "airdrop_init_crate_data" );
    leveldata = airdrop::getleveldata( "ob_activity_share_crate" );
    leveldata.capturestring = &"mp/dmz_plunder_crate_capture";
    
    if ( getdvarint( @"ob_codmas", 0 ) || getdvarint( @"hash_cccd37bc48ebd5b1", 0 ) )
    {
        leveldata.basemodel = "sat_ava_storage_lootbox_01_fxanim_ob_supply_codmas";
    }
    else
    {
        leveldata.basemodel = "sat_ava_storage_lootbox_01_fxanim_ob_supply";
    }
    
    leveldata.var_f49b9544396e05ea = undefined;
    leveldata.supportsownercapture = 0;
    leveldata.headicon = undefined;
    leveldata.usepriority = -1;
    leveldata.usefov = 180;
    leveldata.friendlyuseonly = 0;
    leveldata.ownerusetime = 2.5;
    leveldata.otherusetime = 2.5;
    leveldata.var_58f58ae1d854e3e4 = 1;
    leveldata.activatecallback = &function_7f76e63bb8238ac6;
    leveldata.capturecallback = &function_db9266f23db42e55;
    leveldata.destroycallback = &function_74534d028b3f4d69;
    leveldata.destroyoncapture = 0;
    leveldata.isdropcrate = 1;
    leveldata.nevertimeout = 1;
    leveldata.objectid = "override_locks";
}

// Namespace ob_activity_utility
// Params 1
// Checksum 0x569f7682, Offset: 0x14a1
// Size: 0x13
function function_7f76e63bb8238ac6( isfirstactivation )
{
    thread function_334c494526e2a75f();
}

// Namespace ob_activity_utility
// Params 1
// Checksum 0x2bcc3267, Offset: 0x14bc
// Size: 0x15
function function_db9266f23db42e55( player )
{
    function_23187fe8f3b5865e( player );
}

// Namespace ob_activity_utility
// Params 1
// Checksum 0x3527793e, Offset: 0x14d9
// Size: 0xc
function function_74534d028b3f4d69( immediate )
{
    
}

// Namespace ob_activity_utility
// Params 2
// Checksum 0xa8c4fef4, Offset: 0x14ed
// Size: 0x99
function drop_loot( activityinstance, scriptkey )
{
    crate = airdrop::dropcrate( undefined, undefined, "ob_activity_share_crate", self.origin, ( 0, randomfloat( 360 ), 0 ), self.origin, undefined, 0 );
    crate.disallowheadiconid = 1;
    crate.skipminimapicon = 1;
    
    if ( isdefined( activityinstance ) )
    {
        crate.varianttag = activityinstance.varianttag;
    }
    
    if ( isdefined( scriptkey ) )
    {
        crate.scriptkey = scriptkey;
    }
}

// Namespace ob_activity_utility
// Params 0
// Checksum 0xbf7f5261, Offset: 0x158e
// Size: 0xbf
function function_334c494526e2a75f()
{
    self endon( #"death" );
    self endon( #"crate_opened" );
    self physics_registerforcollisioncallback();
    
    while ( true )
    {
        self waittill( #"collision", body0, body1, flag0, flag1, position, normal, impulse, ent );
        surface = physics_getsurfacetypefromflags( flag1 );
        surfacetype = surface[ "name" ];
        
        if ( surfacetype == "surftype_water" )
        {
            self.moverdoesnotkill = 1;
            return;
        }
    }
}

// Namespace ob_activity_utility
// Params 3
// Checksum 0x96e04a1f, Offset: 0x1655
// Size: 0xab
function function_35188a2507b69255( owner, origin, angles )
{
    var_ca88cceb7a44579d = getdvarfloat( @"hash_d52ed360881ff7ea", 0 );
    var_87f1ca786683bb52 = getdvarint( @"hash_e1f0699f852f9193", 2 );
    region = region_difficulty_manager::function_f9fbb630598afdc7( origin );
    spawngdu = randomfloat( 1 ) < var_ca88cceb7a44579d || region.difficultyint < var_87f1ca786683bb52;
    
    if ( spawngdu )
    {
        ground_drone_unit_mp::function_212cf2d1cbe3a717( origin );
        return;
    }
    
    function_ded5fcf7673a2ae6( owner, origin, angles );
}

// Namespace ob_activity_utility
// Params 3
// Checksum 0xe11c57a3, Offset: 0x1708
// Size: 0x67
function function_ded5fcf7673a2ae6( owner, origin, angles )
{
    streakinfo = killstreak_utility::createstreakinfo( "dawg" );
    streakinfo.team = owner.team;
    streakinfo.var_8caa143e85b803d9 = 1;
    dawg_mp::function_d85e6a2236d6e603( owner, origin, angles, streakinfo );
}

// Namespace ob_activity_utility
// Params 1
// Checksum 0x559d9b15, Offset: 0x1777
// Size: 0xc7
function spawn_gdu( origin )
{
    bundle = killstreak::function_85b2d8e857ab4898( "ground_drone_unit" );
    streakinfo = spawnstruct();
    streakinfo.owner = self;
    streakinfo.streakname = "ground_drone_unit";
    streakinfo.team = self.team;
    streakinfo.var_fc297c214692ba76 = 1;
    streakinfo.var_2cf65238266c20bc = 30;
    streakinfo.var_b60175dee49da226 = 30;
    streakinfo.bundle = bundle;
    
    if ( !isdefined( self.spawnedgdus ) )
    {
        self.spawnedgdus = 0;
    }
    
    self.spawnedgdus++;
    thread ground_drone_unit_mp::function_bf849300daf6e7da( self, origin, streakinfo );
}

// Namespace ob_activity_utility
// Params 1
// Checksum 0xf0176df1, Offset: 0x1846
// Size: 0x1a3
function function_23187fe8f3b5865e( player )
{
    self notify( #"crate_opened" );
    airdrop::makecrateunusable();
    var_6d008e54234e07b0 = function_11635f111a5a5ae3( self.origin );
    var_f67995529827f79 = common_cache::function_525b81b5b46043f7( self.scriptkey, var_6d008e54234e07b0 );
    items = common_item::items_selectfromlist( var_f67995529827f79.spawnlistname, var_f67995529827f79.spawncount );
    
    foreach ( item in items )
    {
        common_cache::cache_additem( self, item, undefined, 0, player );
    }
    
    if ( level.var_9afcf1fa7009bc81 )
    {
        if ( self getscriptableparthasstate( #"ob_supply_drop", #"fully_opening_unusable" ) )
        {
            self setscriptablepartstate( #"ob_supply_drop", #"fully_opening_unusable" );
        }
    }
    
    wait 0.5;
    var_538c0694c880e740 = player squad_utility::getsquadmembers( undefined, 0 );
    cache_scriptable = self getlinkedscriptableinstance();
    self.type = cache_scriptable.type;
    common_cache::opencache( self, player, var_538c0694c880e740 );
    var_9522501df385679d = self.var_9522501df385679d ? self.var_9522501df385679d : 30;
    thread function_ef1b5c1ce4991a7c( var_9522501df385679d );
}

// Namespace ob_activity_utility
// Params 1, eflags: 0x4
// Checksum 0x5ba7a4cd, Offset: 0x19f1
// Size: 0x59
function private function_ef1b5c1ce4991a7c( var_9522501df385679d )
{
    self endon( #"entitydeleted" );
    wait var_9522501df385679d;
    deletiondelay = level.framedurationseconds;
    self physicslaunchserver( ( 0, 0, 0 ), ( 0, 0, 0 ) );
    airdrop::deletecrate( deletiondelay );
}

// Namespace ob_activity_utility
// Params 1
// Checksum 0xef24380e, Offset: 0x1a52
// Size: 0x131
function function_11635f111a5a5ae3( origin )
{
    region = region_difficulty_manager::function_f9fbb630598afdc7( origin );
    zone_name = region.difficultyint >= 2 ? "difficulty" + region.difficultyint : "global";
    zone_list_bundle = getscriptbundlefieldvalues( level.gametypebundle.var_3842463aacfdc5ca, [ #"hash_11eb633eb96632df" ] );
    
    foreach ( entry in zone_list_bundle.zonedefs )
    {
        if ( entry.zonename == zone_name )
        {
            var_6d008e54234e07b0 = entry.zonedef;
            break;
        }
    }
    
    assert( isdefined( var_6d008e54234e07b0 ), "<dev string:x257>" + zone_name );
    return var_6d008e54234e07b0;
}

// Namespace ob_activity_utility
// Params 4
// Checksum 0x66b1bf1, Offset: 0x1b8c
// Size: 0x133
function function_fe0fd74238abb635( varianttype, varianttag, variantclass = "Activity", additionalspawndata )
{
    regions = region_difficulty_manager::function_4f8f6054ecabf2dc();
    
    foreach ( region in regions )
    {
        instanceinfo = level.var_e607236b193eb0c1.activityinstances[ variantclass ][ region.index ][ varianttype ][ varianttag ];
        var_c233e7a3293d7096 = level.var_e607236b193eb0c1.var_559750d3b21f479f[ variantclass ][ region.index ][ varianttype ][ varianttag ];
        
        if ( var_c233e7a3293d7096 )
        {
            return;
        }
        
        if ( instanceinfo )
        {
            return ob_activity_manager::ob_activity_instance_init( instanceinfo, additionalspawndata );
        }
    }
    
    assertmsg( varianttag + "<dev string:x276>" );
}

// Namespace ob_activity_utility
// Params 2
// Checksum 0x66bf009d, Offset: 0x1cc7
// Size: 0x12f
function function_79fdb88a3c375980( targetname, team )
{
    var_aee5186e591de3b2 = getnoentvolumearray( targetname, #targetname );
    
    if ( isdefined( var_aee5186e591de3b2 ) )
    {
        self.nav_obstacles = [];
        
        foreach ( var_43aedf856cd54ff5 in var_aee5186e591de3b2 )
        {
            if ( var_43aedf856cd54ff5.target == self.varianttag )
            {
                half_size = var_43aedf856cd54ff5 getboundshalfsize();
                var_12aadf5d8bbfdafd = createnavbadplacebybounds( var_43aedf856cd54ff5.origin, half_size, var_43aedf856cd54ff5.angles, team );
                self.nav_obstacles[ self.nav_obstacles.size ] = var_12aadf5d8bbfdafd;
            }
        }
        
        if ( self.nav_obstacles.size == 0 )
        {
            self.nav_obstacles = undefined;
            return;
        }
        
        thread function_c8d177422310b57e();
    }
}

// Namespace ob_activity_utility
// Params 0, eflags: 0x4
// Checksum 0x5dcd26b, Offset: 0x1dfe
// Size: 0xa1
function private function_c8d177422310b57e()
{
    utility::waittill_any( "activity_ended", "instance_destroyed" );
    
    if ( isdefined( self.nav_obstacles ) )
    {
        foreach ( var_12aadf5d8bbfdafd in self.nav_obstacles )
        {
            destroynavobstacle( var_12aadf5d8bbfdafd );
        }
        
        self.nav_obstacles = undefined;
    }
}

// Namespace ob_activity_utility
// Params 5
// Checksum 0x1cb66da4, Offset: 0x1ea7
// Size: 0x1ae
function function_aaf7ae640bd564ff( scriptkey, origin, angles, var_dc52ed27bb340e19, payload )
{
    var_16d763e03ef0bbc = undefined;
    
    if ( isstruct( var_dc52ed27bb340e19 ) )
    {
        var_16d763e03ef0bbc = var_dc52ed27bb340e19;
    }
    else if ( isstring( var_dc52ed27bb340e19 ) )
    {
        var_16d763e03ef0bbc = getscriptbundlefieldvalues( "itemspawnzonedef:" + var_dc52ed27bb340e19, [ #"hash_32a95aa45b53f917" ] );
    }
    else
    {
        var_16d763e03ef0bbc = common_item::function_f852430ffb889f14( origin, [ #"hash_32a95aa45b53f917" ] );
    }
    
    if ( !isdefined( var_16d763e03ef0bbc ) )
    {
        /#
            if ( isdefined( var_dc52ed27bb340e19 ) )
            {
                assertmsg( "<dev string:x281>" + getxhashsourcename( scriptkey ) + "<dev string:x2cb>" + origin + "<dev string:x2d9>" + var_dc52ed27bb340e19 + "<dev string:x30a>" );
                return;
            }
            
            assertmsg( "<dev string:x281>" + getxhashsourcename( scriptkey ) + "<dev string:x2cb>" + origin + "<dev string:x30d>" );
        #/
        
        return;
    }
    
    foreach ( var_ed138fd6cba553a4 in var_16d763e03ef0bbc.var_a72bc938c97bce90 )
    {
        if ( var_ed138fd6cba553a4.scriptkey == scriptkey )
        {
            spawn_options = common_item::items_initspawnoptions_spawnfromposition( origin );
            var_c7c306b169cf129b = common_item::function_38cde6a6acb68ea6( var_ed138fd6cba553a4.itemspawnlist, var_ed138fd6cba553a4.itemspawnquantity, spawn_options );
            return var_c7c306b169cf129b;
        }
    }
}

// Namespace ob_activity_utility
// Params 1
// Checksum 0x930d3ec5, Offset: 0x205e
// Size: 0x7d
function setup_dawg_on_spawned( agent )
{
    if ( agent.subclass != "dawg" )
    {
        return;
    }
    
    agent stealth::initstealthfunctions();
    dawg_owner = function_d12ca4c58fe5faf0();
    agent dawg::dawgpostinit( dawg_owner );
    agent emp_debuff::set_apply_emp_callback( &dawg::on_emp_applied );
    emp_debuff::add_emp_ent( agent );
    agent emp_debuff::set_clear_emp_callback( &dawg::on_emp_cleared );
    agent.owner = undefined;
    agent function_54d3d4ceb3d0bc90();
}

// Namespace ob_activity_utility
// Params 1, eflags: 0x4
// Checksum 0xdf8d23ab, Offset: 0x20e3
// Size: 0x93, Type: bool
function private function_e10336e3f6e6a7b1( instance )
{
    var_adaa36a32f5a1ca2 = { #activitycategory:instance.class, #region:instance.region, #activitytype:instance.type };
    
    if ( !ob_activity_manager::function_1d95b7e579d89404( var_adaa36a32f5a1ca2, [] ) )
    {
        return false;
    }
    
    if ( !ob_activity_manager::function_f1d8de22c8cc2109( instance, [] ) )
    {
        return false;
    }
    
    if ( !ob_activity_manager::function_b5bdbf846da577f( instance, [] ) )
    {
        return false;
    }
    
    if ( !ob_activity_manager::function_f450550b51bd8fb5( instance, [] ) )
    {
        return false;
    }
    
    return true;
}

// Namespace ob_activity_utility
// Params 1, eflags: 0x4
// Checksum 0x21bed92b, Offset: 0x217f
// Size: 0x2d, Type: bool
function private function_e1d5d0c34db38204( instance )
{
    ob_activity_manager::ob_activity_instance_init( instance );
    logstring( "MSQ1 activity: spawn " + instance.name );
    return true;
}

// Namespace ob_activity_utility
// Params 0, eflags: 0x4
// Checksum 0x5a8d20bc, Offset: 0x21b5
// Size: 0x1f5
function private function_be422943b242605c()
{
    level endon( #"game_ended" );
    ob_activity_manager::ob_activity_manager_toggle( 0 );
    heistinstances = [];
    var_436c3e7dc285647c = [];
    
    foreach ( instance in level.var_e607236b193eb0c1.var_5992a4946aeeca5a )
    {
        if ( !function_e10336e3f6e6a7b1( instance ) )
        {
            continue;
        }
        
        if ( instance.type == "REV_OB_HEIST" )
        {
            heistinstances[ heistinstances.size ] = instance;
            continue;
        }
        
        if ( instance.type == "REV_OB_MERC_STRONGHOLD" )
        {
            var_436c3e7dc285647c[ var_436c3e7dc285647c.size ] = instance;
            continue;
        }
        
        if ( function_e1d5d0c34db38204( instance ) )
        {
            waitframe();
        }
    }
    
    var_965cb4870b783a5b = 0;
    
    if ( heistinstances.size > 0 && var_436c3e7dc285647c.size > 2 )
    {
        var_436c3e7dc285647c = arrayrandomize( var_436c3e7dc285647c );
        var_965cb4870b783a5b = 2;
        logstring( "MSQ1 activity: Luck strongholds that chosen by His myjesty Heist contract is [" + var_436c3e7dc285647c[ 0 ].name + " ] and [ " + var_436c3e7dc285647c[ 1 ].name + " ]" );
    }
    
    for ( i = var_965cb4870b783a5b; i < var_436c3e7dc285647c.size ; i++ )
    {
        if ( function_e1d5d0c34db38204( var_436c3e7dc285647c[ i ] ) )
        {
            waitframe();
        }
    }
    
    foreach ( instance in heistinstances )
    {
        if ( function_e1d5d0c34db38204( instance ) )
        {
            waitframe();
        }
    }
    
    ob_activity_manager::ob_activity_manager_toggle( 1 );
}

// Namespace ob_activity_utility
// Params 1, eflags: 0x4
// Checksum 0xa5e434d4, Offset: 0x23b2
// Size: 0x42
function private function_14a82ff172667871( params )
{
    if ( getdvar( @"hash_7e309d3e43728293", "" ) )
    {
        thread function_dd66ed5f8dd7eb36();
        return;
    }
    
    if ( getdvarint( @"hash_ea7bd6b0dd54ecb7", 0 ) )
    {
        thread function_be422943b242605c();
        return;
    }
}

// Namespace ob_activity_utility
// Params 0, eflags: 0x4
// Checksum 0x8d02035e, Offset: 0x23fc
// Size: 0xd8
function private function_dd66ed5f8dd7eb36()
{
    value = getdvar( @"hash_7e309d3e43728293", "" );
    
    if ( value )
    {
        ob_activity_manager::ob_activity_manager_toggle( 0 );
        activities = strtoksubstr( value, "," );
        
        foreach ( varianttag in activities )
        {
            instance = level.var_e607236b193eb0c1.var_5992a4946aeeca5a[ varianttag ];
            
            if ( instance )
            {
                ob_activity_manager::ob_activity_instance_init( instance );
                waitframe();
            }
        }
    }
}

// Namespace ob_activity_utility
// Params 1
// Checksum 0x5b40b17b, Offset: 0x24dc
// Size: 0x12e
function ob_enable_cover_nodes( var_edd0cb6e9ee724e9 )
{
    if ( !var_edd0cb6e9ee724e9 )
    {
        if ( isdefined( self.varianttag ) && isdefined( self.computer_station.supply_drop_loc.script_noteworthy ) )
        {
            var_edd0cb6e9ee724e9 = "covernode_" + self.varianttag + "_" + self.computer_station.supply_drop_loc.script_noteworthy;
        }
        else if ( isdefined( self.varianttag ) )
        {
            var_edd0cb6e9ee724e9 = "covernode_" + self.varianttag;
        }
    }
    
    cover_nodes = getnodearray( var_edd0cb6e9ee724e9, "targetname" );
    
    if ( cover_nodes.size > 0 )
    {
        self.cover_nodes = cover_nodes;
        
        foreach ( cover_node in cover_nodes )
        {
            cover_node connectnode();
        }
    }
}

// Namespace ob_activity_utility
// Params 0
// Checksum 0xcda91ca8, Offset: 0x2612
// Size: 0xa0
function ob_disable_cover_nodes()
{
    if ( isdefined( self.cover_nodes ) && self.cover_nodes.size > 0 )
    {
        foreach ( cover_node in self.cover_nodes )
        {
            cover_node disconnectnode();
        }
        
        self.cover_nodes = undefined;
    }
}

// Namespace ob_activity_utility
// Params 6
// Checksum 0x8b51cd2, Offset: 0x26ba
// Size: 0xf2
function ob_agent_keep_rushing_to_goal( goal_origin, origin_variance = 128, goal_radius_override = 256, update_interval = 2, random_time_offset = 1, time_period = 30 )
{
    self endon( #"death" );
    
    if ( !isdefined( level.agent_keep_rushing_to_goal_throttle ) )
    {
        level.agent_keep_rushing_to_goal_throttle = throttle::throttle_initialize( "agent_keep_rushing_to_goal_throttle", 3 );
    }
    
    wait_time = 0;
    
    while ( wait_time < time_period )
    {
        if ( !self.combatrushing )
        {
            throttle::throttle_wait_in_queue( level.agent_keep_rushing_to_goal_throttle, self );
            thread ai_behavior::function_ec43a817c7bf1915( self, goal_origin, origin_variance, goal_radius_override );
        }
        
        interval = update_interval + randomfloat( random_time_offset );
        wait interval;
        wait_time += interval;
    }
}

// Namespace ob_activity_utility
// Params 3
// Checksum 0x20afba29, Offset: 0x27b4
// Size: 0xbc
function function_b701238b439c04f4( chevron_count, chevron_radius, chevron_scriptable_name )
{
    self.var_55bcb1f81e429cb1 = 1;
    segment_degrees = 360 / chevron_count;
    
    for ( i = 0; i < chevron_count ; i++ )
    {
        local_offset = anglestoforward( ( 0, segment_degrees * i, 0 ) ) * chevron_radius;
        chevron_org = coordtransform( local_offset, self.origin, self.angles );
        chevron_ang = vectortoangles( chevron_org - self.origin );
        self.chevrons[ i ] = spawnscriptable( chevron_scriptable_name, chevron_org, chevron_ang );
    }
}

// Namespace ob_activity_utility
// Params 1
// Checksum 0x5317378f, Offset: 0x2878
// Size: 0x90
function function_52548dcec01f46ba( state )
{
    foreach ( chevron in self.chevrons )
    {
        chevron utility::function_32b24db3127bff40( #"hash_a332abc279ec2760", state );
    }
}

// Namespace ob_activity_utility
// Params 0
// Checksum 0x67c55a9f, Offset: 0x2910
// Size: 0x83
function ob_destroy_chevrons()
{
    foreach ( chevron in self.chevrons )
    {
        chevron freescriptable();
    }
    
    self.var_55bcb1f81e429cb1 = 0;
}

// Namespace ob_activity_utility
// Params 4
// Checksum 0x27ff747a, Offset: 0x299b
// Size: 0x1aa
function function_4ad66bfa02812252( default_vehicle_ref, spawn_point_structs, var_ef6edb3c0c32d200, var_108248b18fdc4985 = 512 )
{
    self.ambient_vehicles = [];
    
    foreach ( struct in spawn_point_structs )
    {
        if ( isdefined( struct.script_noteworthy ) )
        {
            vehicle_ref = struct.script_noteworthy;
        }
        else
        {
            vehicle_ref = default_vehicle_ref;
        }
        
        spawn_data = spawnstruct();
        spawn_data.origin = struct.origin + ( 0, 0, 128 );
        spawn_data.angles = struct.angles;
        possible_barricades = entity::getentitiesinradius( spawn_data.origin, var_108248b18fdc4985, undefined, undefined, trace::create_vehicle_contents() );
        
        if ( !possible_barricades.size )
        {
            vehicle = ob_resource_manager::function_5833e4ba6b50b615( vehicle_ref, spawn_data );
        }
        
        if ( isdefined( vehicle ) )
        {
            self.ambient_vehicles[ self.ambient_vehicles.size ] = vehicle;
        }
        
        waitframe();
    }
    
    if ( self.ambient_vehicles.size > 0 )
    {
        thread function_676342913dd13593( self.ambient_vehicles, [ "activity_ended", "instance_destroyed" ], var_ef6edb3c0c32d200 );
    }
}

// Namespace ob_activity_utility
// Params 3, eflags: 0x4
// Checksum 0x79a4492c, Offset: 0x2b4d
// Size: 0xa0
function private function_676342913dd13593( var_2ce6b8a691499a8, var_87f96a04e1e3dc5c, var_ef6edb3c0c32d200 )
{
    utility::waittill_any_in_array( var_87f96a04e1e3dc5c );
    
    foreach ( vehicle in var_2ce6b8a691499a8 )
    {
        if ( isdefined( vehicle ) )
        {
            vehicle thread function_16f13e7feb0abb24( var_ef6edb3c0c32d200 );
        }
    }
}

// Namespace ob_activity_utility
// Params 2
// Checksum 0x8a32a2ef, Offset: 0x2bf5
// Size: 0xe1
function function_16f13e7feb0abb24( radius, check_interval_seconds = 1 )
{
    self notify( #"hash_6cd7f5cf4c74649d" );
    self endon( #"hash_6cd7f5cf4c74649d" );
    self endon( #"death" );
    self endon( #"entitydeleted" );
    assert( isdefined( self.origin ) );
    
    while ( isdefined( self ) )
    {
        players = getplayersinradius( self.origin, radius );
        
        if ( players.size == 0 )
        {
            if ( vehicle::is_vehicle() )
            {
                self.dontspawnhusk = 1;
                level thread vehicle::death( self );
            }
            else if ( isent( self ) )
            {
                self delete();
            }
            else if ( self isscriptableinstance() )
            {
                self freescriptable();
            }
            else
            {
                assert( 0, "<dev string:x33a>" );
            }
            
            break;
        }
        
        wait check_interval_seconds;
    }
}

// Namespace ob_activity_utility
// Params 3
// Checksum 0x25c3906d, Offset: 0x2cde
// Size: 0xfa
function function_468428fa3b477b54( radius = 5000, skip_self = 0, aliveonly = 0 )
{
    all_squad_members = squad_utility::getsquadmembers( undefined, aliveonly );
    squad_members_nearby = [];
    
    foreach ( player in all_squad_members )
    {
        if ( player == self && skip_self )
        {
            continue;
        }
        
        if ( distancesquared( self.origin, player.origin ) <= squared( radius ) )
        {
            squad_members_nearby[ squad_members_nearby.size ] = player;
        }
    }
    
    return squad_members_nearby;
}

// Namespace ob_activity_utility
// Params 1
// Checksum 0xfb95f256, Offset: 0x2de1
// Size: 0x3e
function function_fd8fc0e0d2300792( vector )
{
    if ( !isvector( vector ) )
    {
        assertmsg( "<dev string:x385>" );
        return vector;
    }
    
    return ( int( vector[ 0 ] ), int( vector[ 1 ] ), int( vector[ 2 ] ) );
}

// Namespace ob_activity_utility
// Params 3
// Checksum 0xbcb0326f, Offset: 0x2e28
// Size: 0xa2, Type: bool
function function_e710f3efecb65567( player_array, target_position, radius )
{
    foreach ( player in player_array )
    {
        if ( distance( player.origin, target_position ) <= radius )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace ob_activity_utility
// Params 2
// Checksum 0xb917e909, Offset: 0x2ed3
// Size: 0x10b, Type: bool
function function_2ffc785b6076484e( player_array, target_position )
{
    if ( !isdefined( level.var_5b5a91e46581b112 ) )
    {
        level.var_5b5a91e46581b112 = trace::create_contents( 0, 1, 0, 1, 0, 0, 1 );
    }
    
    foreach ( player in player_array )
    {
        eye_origin = player geteye();
        is_in_fov = utility::within_fov( eye_origin, player getplayerangles(), target_position, 0.5 );
        
        if ( is_in_fov )
        {
            ignore_entity_array = [];
            
            if ( trace::ray_trace_passed( eye_origin, target_position + ( 0, 0, 80 ), ignore_entity_array, level.var_5b5a91e46581b112 ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace ob_activity_utility
// Params 0
// Checksum 0x9ae7385, Offset: 0x2fe7
// Size: 0x51
function function_798aace978e876b()
{
    self endon( #"death" );
    watch_timeout_seconds = 60;
    
    while ( self && watch_timeout_seconds > 0 )
    {
        if ( utility::ispointinwater( self gettagorigin( "j_head" ) ) )
        {
            self kill();
            break;
        }
        
        wait 1;
        watch_timeout_seconds -= 1;
    }
}

// Namespace ob_activity_utility
// Params 1
// Checksum 0x4b0204c0, Offset: 0x3040
// Size: 0x7f
function register_aether_blade_target( cyst )
{
    if ( !isdefined( level.ob.cysts ) )
    {
        level.ob.cysts = [];
    }
    
    if ( !arraycontains( level.ob.cysts, cyst ) )
    {
        level.ob.cysts[ level.ob.cysts.size ] = cyst;
    }
}

// Namespace ob_activity_utility
// Params 1
// Checksum 0x79e24b4a, Offset: 0x30c7
// Size: 0x6c
function function_f257a06b8f9e4c53( cyst )
{
    if ( level.ob.cysts && arraycontains( level.ob.cysts, cyst ) )
    {
        level.ob.cysts = arrayremove( level.ob.cysts, cyst );
    }
}

