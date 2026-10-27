// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_floating_rocks.gsc  (hash_1a97eb337367385f.gscc) (size: 11059 Bytes / 0x2b33 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x848378b9 (2223208633)
// size ...... 11059 (0x2b33)
// includes .. 16  (offset: 0x28e7)
// strings ... 19  (offset: 0x2967)
// dev strs .. 17  (offset: 0x2a67)
// exports ... 25  (offset: 0x1a83)
// cseg ...... 0x18d + 0x18f6 (0x1a83)
// imports ... 87  (offset: 0x1e6b)
// animtree1 . 0   (offset: 0x2b33)
// animtree2 . 0   (offset: 0x2b33)
#using script_3d250c1a364843aa;
#using script_61b40095fd0502f0;
#using scripts\common\devgui;
#using scripts\common\script;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\common\equipment\mini_sentry;
#using scripts\mp\common\equipment\molotov;
#using scripts\mp\common\equipment\shock_stick;
#using scripts\mp\common\equipment\smart_seeker;
#using scripts\mp\common\killstreaks\rcxd_shared;
#using scripts\mp\loot\common_item;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_locust_floating_rocks;

// Namespace zm_sat_locust_floating_rocks
// Params 0, eflags: 0x5
// Checksum 0x78efcd9, Offset: 0x1ab
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"floating_rocks", undefined, undefined, &post_main );
}

// Namespace zm_sat_locust_floating_rocks
// Params 0, eflags: 0x4
// Checksum 0x81e563ad, Offset: 0x1cc
// Size: 0xa
function private post_main()
{
    level thread init();
}

// Namespace zm_sat_locust_floating_rocks
// Params 0, eflags: 0x4
// Checksum 0x5688ecc1, Offset: 0x1de
// Size: 0x16e
function private init()
{
    utility::flag_wait( "scriptables_ready" );
    level.floating_rocks = {};
    level.floating_rocks.groups = [];
    level.floating_rocks.full_list = [];
    level.floating_rocks.standing_list = [];
    level.floating_rocks.var_2e3da9d8f4a7838 = [];
    rocks = getentitylessscriptablearray( "floating_rocks", #targetname );
    
    foreach ( rock in rocks )
    {
        setup_rock( rock, rock.script_noteworthy );
        
        if ( rock.target )
        {
            group = rock.script_noteworthy;
            
            for ( ;; )
            {
                rock = getentitylessscriptablearray( rock.target, #targetname )[ 0 ];
                setup_rock( rock, group );
                
                if ( !isdefined( rock.target ) )
                {
                    break;
                }
            }
        }
    }
    
    /#
        debug_init();
    #/
}

// Namespace zm_sat_locust_floating_rocks
// Params 2, eflags: 0x4
// Checksum 0xb6e83ef3, Offset: 0x354
// Size: 0x1ec
function private setup_rock( rock, group )
{
    assert( rock getscriptablehaspart( #"model" ), "<dev string:x24>" );
    assert( rock getscriptablehaspart( #"effects" ), "<dev string:x37>" );
    assert( !isent( rock ) && rock isscriptableinstance(), "<dev string:x4c>" );
    rock.nodes = getnodearray( rock.script_noteworthy, #script_noteworthy );
    
    foreach ( node in rock.nodes )
    {
        if ( node.type == "Begin" )
        {
            function_30dc1efdafe7681e( node, 0 );
        }
    }
    
    if ( !isdefined( level.floating_rocks.groups[ group ] ) )
    {
        level.floating_rocks.groups[ group ] = [];
    }
    
    level.floating_rocks.groups[ group ][ level.floating_rocks.groups[ group ].size ] = rock;
    level.floating_rocks.full_list[ level.floating_rocks.full_list.size ] = rock;
    
    if ( rock.type != %"sat_zm_rock_watson_04" )
    {
        level.floating_rocks.standing_list[ level.floating_rocks.standing_list.size ] = rock;
    }
}

// Namespace zm_sat_locust_floating_rocks
// Params 1
// Checksum 0x69726a0a, Offset: 0x548
// Size: 0x66
function get_group( group_name )
{
    assert( isdefined( level.floating_rocks.groups[ group_name ] ) && level.floating_rocks.groups[ group_name ].size > 0, "<dev string:x71>" + group_name );
    return level.floating_rocks.groups[ group_name ];
}

// Namespace zm_sat_locust_floating_rocks
// Params 4
// Checksum 0xaa46803f, Offset: 0x5b7
// Size: 0x1c7
function show_group( group_name, with_effects = 0, enable_traversals = 0, delay_times )
{
    if ( isarray( group_name ) )
    {
        group_names = group_name;
        
        foreach ( group_name in group_names )
        {
            foreach ( rock in get_group( group_name ) )
            {
                show_rock( rock, with_effects, enable_traversals, delay_times );
            }
            
            activateworldevent( "we_" + group_name + "_show" );
        }
    }
    else
    {
        foreach ( rock in get_group( group_name ) )
        {
            show_rock( rock, with_effects, enable_traversals, delay_times );
        }
        
        activateworldevent( "we_" + group_name + "_show" );
    }
    
    level notify( group_name );
}

// Namespace zm_sat_locust_floating_rocks
// Params 4
// Checksum 0x3a47676f, Offset: 0x786
// Size: 0x1c2
function hide_group( group_name, with_effects = 0, disable_traversals = 0, delay_times )
{
    if ( isarray( group_name ) )
    {
        group_names = group_name;
        
        foreach ( group_name in group_names )
        {
            foreach ( rock in get_group( group_name ) )
            {
                hide_rock( rock, with_effects, disable_traversals, delay_times );
            }
            
            deactivateworldevent( "we_" + group_name + "_show" );
        }
        
        return;
    }
    
    foreach ( rock in get_group( group_name ) )
    {
        hide_rock( rock, with_effects, disable_traversals, delay_times );
    }
    
    deactivateworldevent( "we_" + group_name + "_show" );
}

// Namespace zm_sat_locust_floating_rocks
// Params 4
// Checksum 0x3d1063d8, Offset: 0x950
// Size: 0x15a
function show_rock( rock, with_effects = 0, enable_traversals = 0, delay_times )
{
    if ( delay_times )
    {
        assert( delay_times.size == 2 );
        assert( delay_times[ 0 ] < delay_times[ 1 ] );
        
        if ( isdefined( rock.script_parameters ) )
        {
            f_delay = script::stringtofloat( rock.script_parameters );
            wait f_delay;
        }
        else
        {
            wait randomfloatrange( delay_times[ 0 ], delay_times[ 1 ] );
        }
    }
    
    rock utility::function_7c10ea82c1e305b8( #"model", #"visible" );
    function_e66219e6ec4938ad( rock );
    
    if ( with_effects )
    {
        rock utility::function_7c10ea82c1e305b8( #"effects", #"spawn_in" );
    }
    
    if ( enable_traversals )
    {
        foreach ( node in rock.nodes )
        {
            function_30dc1efdafe7681e( node, 1 );
        }
    }
}

// Namespace zm_sat_locust_floating_rocks
// Params 4
// Checksum 0x8b6be781, Offset: 0xab2
// Size: 0x169
function hide_rock( rock, with_effects = 0, disable_traversals = 0, delay_times )
{
    if ( delay_times )
    {
        assert( delay_times.size == 2 );
        assert( delay_times[ 0 ] < delay_times[ 1 ] );
        wait randomfloatrange( delay_times[ 0 ], delay_times[ 1 ] );
    }
    
    profilestart();
    var_f089e9fea8462fc5 = get_sentients();
    valid_sentients = function_4c7a429eb024b0d0( rock, var_f089e9fea8462fc5 );
    function_d7f112c494a55aee( valid_sentients );
    valid_loot = function_905b0ef6c0784627( rock );
    function_15dc626270558a9d( valid_loot );
    profilestop();
    rock utility::function_7c10ea82c1e305b8( #"model", #"default" );
    
    if ( with_effects )
    {
        rock utility::function_7c10ea82c1e305b8( #"effects", #"spawn_out" );
    }
    
    if ( disable_traversals )
    {
        foreach ( node in rock.nodes )
        {
            function_30dc1efdafe7681e( node, 0 );
        }
    }
}

// Namespace zm_sat_locust_floating_rocks
// Params 1
// Checksum 0x2905224f, Offset: 0xc23
// Size: 0x99
function function_e66219e6ec4938ad( rock )
{
    assert( rock.model, "<dev string:x88>" );
    
    if ( isdefined( level.floating_rocks.var_2e3da9d8f4a7838[ rock.model ] ) )
    {
        return;
    }
    
    level.floating_rocks.var_2e3da9d8f4a7838[ rock.model ] = { #midpoint:function_caaf4dc13b656242( rock.model ), #halfsize:function_decb653c5689e4ca( rock.model ) };
}

// Namespace zm_sat_locust_floating_rocks
// Params 1
// Checksum 0x38a1463a, Offset: 0xcc4
// Size: 0x2b
function get_rock_data( rock )
{
    return level.floating_rocks.var_2e3da9d8f4a7838[ rock.model ];
}

// Namespace zm_sat_locust_floating_rocks
// Params 2, eflags: 0x4
// Checksum 0x40d5be1, Offset: 0xcf8
// Size: 0x20d
function private function_4c7a429eb024b0d0( rock, var_f089e9fea8462fc5 )
{
    data = get_rock_data( rock );
    
    if ( !isdefined( data ) )
    {
        return [];
    }
    
    if ( rock.type == %"sat_zm_rock_watson_05" )
    {
        origin = rock.origin + anglestoforward( rock.angles ) * data.halfsize + ( 0, 0, data.halfsize[ 2 ] * 2 );
        triggers = getnoentvolumearray( "ww_kill_trigger", #targetname );
        trigger = function_47c86977a18df38b( triggers, origin );
        touching_sentients = [];
        
        foreach ( sentient in var_f089e9fea8462fc5 )
        {
            if ( !sentient istouching( trigger ) )
            {
                continue;
            }
            
            touching_sentients[ touching_sentients.size ] = sentient;
        }
        
        /#
            radius = data.halfsize[ 1 ] * 1.1;
            utility::draw_circle( origin, radius, ( 0, 1, 0 ), 1, 0, int( 5 / level.framedurationseconds ) );
        #/
        
        return touching_sentients;
    }
    
    origin = rock.origin + ( 0, 0, data.halfsize[ 2 ] * 2 );
    radius = data.halfsize[ 1 ] * 1.1;
    var_f089e9fea8462fc5 = function_6a293b884c444a20( var_f089e9fea8462fc5, origin, radius );
    
    /#
        utility::draw_circle( origin, radius, ( 0, 1, 0 ), 1, 0, int( 5 / level.framedurationseconds ) );
    #/
    
    return var_f089e9fea8462fc5;
}

// Namespace zm_sat_locust_floating_rocks
// Params 1, eflags: 0x4
// Checksum 0x72a891f1, Offset: 0xf0d
// Size: 0x2e7
function private function_d7f112c494a55aee( var_f089e9fea8462fc5 )
{
    profilestart();
    
    foreach ( sentient in var_f089e9fea8462fc5 )
    {
        if ( sentient.equipmentref == "equip_mini_sentry" )
        {
            sentient thread namespace_e6861a39b2264899::on_destruction();
            continue;
        }
        
        if ( sentient.streakname == "dawg" )
        {
            sentient.owner notify( #"killstreak_cancel" );
            sentient thread dawg::dawg_self_destruct();
            continue;
        }
        
        if ( sentient.streakname == "remote_turret" )
        {
            sentient.owner notify( #"killstreak_cancel" );
            sentient notify( #"kill_turret", 1, 1, 0, 1 );
            continue;
        }
        
        if ( sentient.streakname == "rcxd" )
        {
            sentient.owner notify( #"killstreak_cancel" );
            sentient thread rcxd_shared::rcxd_explode();
            continue;
        }
        
        if ( sentient.equipmentref == "equip_smart_seeker" )
        {
            sentient thread smart_seeker::function_16e1c3f278107106();
            continue;
        }
        
        if ( sentient.equipmentref == "equip_combataxe" )
        {
            sentient [[ sentient.deletefunction ]]();
            continue;
        }
        
        if ( sentient.equipmentref == "equip_molotov" )
        {
            sentient molotov::molotov_burn_destroy( 1 );
            continue;
        }
        
        if ( sentient.equipmentref == "equip_shockstick" )
        {
            sentient shock_stick::function_5ea9a3b277397a1b();
            continue;
        }
        
        if ( level.var_80ec21e17cb08bce && arraycontains( level.var_80ec21e17cb08bce, sentient ) )
        {
            sentient thread utility::callsharedfunc( #"zm_toxic_growth", #"delete_toxic_growth", 1 );
            continue;
        }
        
        if ( level.mdl_ball_array && arraycontains( level.mdl_ball_array, sentient ) )
        {
            sentient thread utility::callsharedfunc( #"zm_energy_mine", #"delete_energy_mine" );
            continue;
        }
        
        if ( sentient.health > 0 )
        {
            sentient notify( #"damage", sentient.health, level.players[ 0 ], ( 0, 0, 0 ), sentient.origin, "MOD_EXPLOSIVE_BULLET" );
            continue;
        }
        
        sentient delete();
        assert( !sentient, "<dev string:xa8>" + sentient.code_classname + "<dev string:xb9>" + ( sentient.equipmentref ?? sentient.streakname ?? "<dev string:xbb>" ) );
    }
    
    profilestop();
}

// Namespace zm_sat_locust_floating_rocks
// Params 1, eflags: 0x4
// Checksum 0xb5265e17, Offset: 0x11fc
// Size: 0x2bb
function private function_905b0ef6c0784627( rock )
{
    data = get_rock_data( rock );
    
    if ( !isdefined( data ) )
    {
        return [];
    }
    
    if ( rock.type == %"sat_zm_rock_watson_05" )
    {
        origin = rock.origin + anglestoforward( rock.angles ) * data.halfsize + ( 0, 0, data.halfsize[ 2 ] * 2 );
        radius = data.halfsize[ 1 ] * 4;
        triggers = getnoentvolumearray( "ww_kill_trigger", #targetname );
        trigger = function_47c86977a18df38b( triggers, origin );
        scriptables = getentitylessscriptablearray( undefined, undefined, origin, radius );
        valid_loot = [];
        
        foreach ( scriptable in scriptables )
        {
            if ( !common_item::items_isitem( scriptable.type ) )
            {
                continue;
            }
            
            if ( !ispointinvolume( scriptable.origin, trigger ) )
            {
                continue;
            }
            
            valid_loot[ valid_loot.size ] = scriptable;
        }
        
        /#
            utility::draw_circle( origin, radius, ( 1, 0, 0 ), 1, 0, int( 5 / level.framedurationseconds ) );
        #/
        
        return valid_loot;
    }
    
    origin = rock.origin + ( 0, 0, data.halfsize[ 2 ] * 2 );
    radius = data.halfsize[ 1 ] * 1.1;
    scriptables = getentitylessscriptablearray( undefined, undefined, origin, radius );
    valid_loot = [];
    
    foreach ( scriptable in scriptables )
    {
        if ( !common_item::items_isitem( scriptable.type ) )
        {
            continue;
        }
        
        valid_loot[ valid_loot.size ] = scriptable;
    }
    
    /#
        utility::draw_circle( origin, radius, ( 1, 0, 0 ), 1, 0, int( 5 / level.framedurationseconds ) );
    #/
    
    return valid_loot;
}

// Namespace zm_sat_locust_floating_rocks
// Params 1, eflags: 0x4
// Checksum 0x9fc0acd2, Offset: 0x14bf
// Size: 0x80
function private function_15dc626270558a9d( loot )
{
    profilestart();
    
    foreach ( item in loot )
    {
        common_item::function_869d7676e359a627( item );
    }
    
    profilestop();
}

// Namespace zm_sat_locust_floating_rocks
// Params 1
// Checksum 0x6eede3b2, Offset: 0x1547
// Size: 0x180
function function_b8628007359aae67( override )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    /#
        if ( self isnoclip() || self isufo() )
        {
            return;
        }
    #/
    
    self setscriptablepartstate( "oob_teleport_sfx", "out", 0 );
    
    if ( !override )
    {
        z_offset = ( 0, 0, 128 );
        closest_rock = function_47c86977a18df38b( level.floating_rocks.standing_list, self.origin - z_offset );
        closest_tacpoint = function_a4a0660084b84def( closest_rock.origin, 1 );
        position = closest_tacpoint.origin;
        angles = self getplayerangles();
    }
    else
    {
        position = override.origin;
        angles = override.angles;
    }
    
    self.is_resetting = 1;
    zm_utility::teleport_player( position, angles, "teleport_out_of_map", 0, 0.5 );
    self.is_resetting = 0;
    thread namespace_8a6b6b859e6fcad::function_a7464203b6956dd7();
    level thread zm_quest::function_835556fe63cd2edd( self.origin, 256 );
    damage = self.health / 2;
    damage = clamp( damage, 1, self.maxhealth );
    
    if ( damage > 1 )
    {
        self dodamage( damage, self.origin, self, self, "MOD_TRIGGER_HURT" );
    }
}

// Namespace zm_sat_locust_floating_rocks
// Params 0
// Checksum 0x28143675, Offset: 0x16cf
// Size: 0x7f
function get_sentients()
{
    var_f089e9fea8462fc5 = sentientpoolmanager::function_ad3d873516899a0e();
    var_f089e9fea8462fc5 = arraycombineunique( var_f089e9fea8462fc5, level.grenades, level.missiles, weapon::function_3aafcaf7ff6dea9e(), level.activekillstreaks, level.vehicle.all, level.cratedata.crates, level.var_80ec21e17cb08bce, level.mdl_ball_array );
    var_f089e9fea8462fc5 = function_5713d46873b29625( var_f089e9fea8462fc5 );
    return var_f089e9fea8462fc5;
}

/#

    // Namespace zm_sat_locust_floating_rocks
    // Params 0, eflags: 0x4
    // Checksum 0x51896b59, Offset: 0x1757
    // Size: 0xc, Type: dev
    function private debug_init()
    {
        devgui_init();
    }

    // Namespace zm_sat_locust_floating_rocks
    // Params 0, eflags: 0x4
    // Checksum 0x37d646c, Offset: 0x176b
    // Size: 0xc, Type: dev
    function private devgui_init()
    {
        function_5be608cf275b855();
    }

    // Namespace zm_sat_locust_floating_rocks
    // Params 0, eflags: 0x4
    // Checksum 0xb53bef70, Offset: 0x177f
    // Size: 0x110, Type: dev
    function private function_5be608cf275b855()
    {
        foreach ( key, arr in level.floating_rocks.groups )
        {
            devgui::function_9082edeb5db93280( "<dev string:xc2>" );
            devgui::function_cd4e263c1f3018ae( key, "<dev string:xf3>" + key, &function_8a6105431e8c3408 );
            devgui::function_77df7fe7dd273e10();
            devgui::function_9082edeb5db93280( "<dev string:x10a>" );
            devgui::function_cd4e263c1f3018ae( key, "<dev string:x13b>" + key, &function_35493267b4c9ae61 );
            devgui::function_77df7fe7dd273e10();
        }
        
        devgui::function_9082edeb5db93280( "<dev string:x152>" );
        devgui::add_devgui_func( "<dev string:x178>", "<dev string:x184>", &function_2c83598d5e28d571 );
        devgui::add_devgui_func( "<dev string:x19b>", "<dev string:x1ab>", &function_da73e52f148a673b );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_sat_locust_floating_rocks
    // Params 1, eflags: 0x4
    // Checksum 0x6cca694a, Offset: 0x1897
    // Size: 0x31, Type: dev
    function private function_8a6105431e8c3408( args )
    {
        level thread show_group( args[ 0 ], 1, 1, [ 0.65, 0.75 ] );
    }

    // Namespace zm_sat_locust_floating_rocks
    // Params 1, eflags: 0x4
    // Checksum 0x6cac0f78, Offset: 0x18d0
    // Size: 0x1e, Type: dev
    function private function_35493267b4c9ae61( args )
    {
        level thread hide_group( args[ 0 ], 1, 1 );
    }

    // Namespace zm_sat_locust_floating_rocks
    // Params 0, eflags: 0x4
    // Checksum 0xbc5fb756, Offset: 0x18f6
    // Size: 0xba, Type: dev
    function private function_2c83598d5e28d571()
    {
        foreach ( rock in level.floating_rocks.full_list )
        {
            if ( rock utility::function_9f2c41c1dcc8c94( #"model", #"default" ) )
            {
                continue;
            }
            
            valid_loot = function_905b0ef6c0784627( rock );
            function_15dc626270558a9d( valid_loot );
        }
    }

    // Namespace zm_sat_locust_floating_rocks
    // Params 0, eflags: 0x4
    // Checksum 0xd3ef2a0f, Offset: 0x19b8
    // Size: 0xcb, Type: dev
    function private function_da73e52f148a673b()
    {
        var_f089e9fea8462fc5 = get_sentients();
        
        foreach ( rock in level.floating_rocks.full_list )
        {
            if ( rock utility::function_9f2c41c1dcc8c94( #"model", #"default" ) )
            {
                continue;
            }
            
            valid_sentients = function_4c7a429eb024b0d0( rock, var_f089e9fea8462fc5 );
            function_d7f112c494a55aee( valid_sentients );
        }
    }

#/
