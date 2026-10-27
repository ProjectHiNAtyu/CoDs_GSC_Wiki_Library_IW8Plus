// scripts\mp\zm\systems\relics\zm_relic_mrp_events.gsc  (hash_45e1c753917c8703.gscc) (size: 8951 Bytes / 0x22f7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdd94e121 (3717521697)
// size ...... 8951 (0x22f7)
// includes .. 9   (offset: 0x214b)
// strings ... 22  (offset: 0x2193)
// dev strs .. 6   (offset: 0x22af)
// exports ... 17  (offset: 0x1557)
// cseg ...... 0x22d + 0x132a (0x1557)
// imports ... 80  (offset: 0x17ff)
// animtree1 . 0   (offset: 0x22f7)
// animtree2 . 0   (offset: 0x22f7)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\script;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;

#namespace zm_relic_mrp_events;

// Namespace zm_relic_mrp_events
// Params 0, eflags: 0x5
// Checksum 0xebe339bd, Offset: 0x24b
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_58c19ab4edc19c0d", undefined, undefined, &init_mrp_events );
}

// Namespace zm_relic_mrp_events
// Params 0
// Checksum 0x56896d24, Offset: 0x26c
// Size: 0x36
function init_mrp_events()
{
    if ( !getdvarint( @"hash_70ef86ad43e08120", 0 ) && !level.var_8a98c33a6b47db4a )
    {
        return;
    }
    
    if ( !is_valid_gametype() )
    {
        return;
    }
    
    level thread post_init_mrp_events();
}

// Namespace zm_relic_mrp_events
// Params 0
// Checksum 0xee489269, Offset: 0x2aa
// Size: 0x255
function post_init_mrp_events()
{
    utility::waittill_any_timeout( 5, "create_script_initialized" );
    
    if ( !getdvarint( @"hash_be4855acac8d71e9", 0 ) )
    {
        level utility::flag_wait_or_timeout( "cursed_mode_validation_set", 120 );
    }
    
    if ( game_utility::getgametype() == "zm_rb_r_mod_survival" )
    {
        poiname = function_64c3a9143299dacb();
        utility::registersharedfunc( #"zm_survival", #"get_survival_poi_name", &function_64c3a9143299dacb );
        level.var_103d11662a9d894b = utility::getstructarray( poiname + "_mrp_event", "script_noteworthy" );
    }
    else
    {
        level.var_103d11662a9d894b = utility::getstructarray( "mrp_event", "targetname" );
    }
    
    if ( !level.var_103d11662a9d894b.size > 0 )
    {
        return;
    }
    
    map_name = game_utility::getmapname();
    
    if ( map_name == "zm_sat_scarab" && level.var_103d11662a9d894b.size == 10 )
    {
        level.var_103d11662a9d894b = arrayremove( level.var_103d11662a9d894b, level.var_103d11662a9d894b[ 9 ] );
        level.var_103d11662a9d894b = arrayremove( level.var_103d11662a9d894b, level.var_103d11662a9d894b[ 8 ] );
        level.var_103d11662a9d894b = arrayremove( level.var_103d11662a9d894b, level.var_103d11662a9d894b[ 7 ] );
        level.var_103d11662a9d894b = arrayremove( level.var_103d11662a9d894b, level.var_103d11662a9d894b[ 6 ] );
        level.var_103d11662a9d894b = arrayremove( level.var_103d11662a9d894b, level.var_103d11662a9d894b[ 5 ] );
    }
    
    level.relic_mr_peeks = undefined;
    
    if ( game_utility::getgametype() != "zm_rb_rh_mod" )
    {
        level.var_966e7e1f42f9a195 = getscriptbundle( %"hash_2d453bdcd3bb8569" );
    }
    else
    {
        level.var_966e7e1f42f9a195 = getscriptbundle( %"hash_1fa040df87f446e8" );
    }
    
    level callback::add( "on_round_start", &on_round_start );
    level callback::add( #"player_used_item", &on_item_used );
    scriptable::scriptable_addnotifycallback( "relic_mrp_destroyed", &relic_mrp_destroyed );
    level._effect[ #"mr_peeks_disappear" ] = loadfxasset( "vfx_t10_gameplay_zm_magic_box_bunny_rarity_white_disappear" );
    level._effect[ #"mr_peeks_warp" ] = loadfxasset( "vfx_t10_gameplay_zm_magic_box_bunny_rarity_white" );
    
    /#
        level thread init_mrp_events_debug();
    #/
}

// Namespace zm_relic_mrp_events
// Params 0
// Checksum 0x66aee3, Offset: 0x507
// Size: 0x34
function function_64c3a9143299dacb()
{
    dvar_hash = hashcat( @"scr_", level.mapname, "_survival_poi" );
    return getdvar( dvar_hash, "null" );
}

// Namespace zm_relic_mrp_events
// Params 1, eflags: 0x4
// Checksum 0x8a500d4, Offset: 0x544
// Size: 0x111
function private on_round_start( params )
{
    if ( !level.var_103d11662a9d894b.size > 0 )
    {
        return;
    }
    
    if ( getdvarint( @"spawn_all_mrpeeks", 0 ) )
    {
        foreach ( relic_mrp in level.var_103d11662a9d894b )
        {
            spawn_mr_peeks( relic_mrp );
        }
        
        return;
    }
    
    spawn_chance = level.var_966e7e1f42f9a195.spawnchance * 100;
    
    if ( utility::percent_chance( spawn_chance ) )
    {
        index = randomintrange( 0, level.var_103d11662a9d894b.size );
        spawn_struct = level.var_103d11662a9d894b[ index ];
        
        if ( spawn_struct )
        {
            level spawn_mr_peeks( spawn_struct );
        }
    }
}

// Namespace zm_relic_mrp_events
// Params 1, eflags: 0x4
// Checksum 0xa60035, Offset: 0x65d
// Size: 0x4bd
function private spawn_mr_peeks( spawn_struct )
{
    if ( !level.zm_relic_tier > 0 && !getdvarint( @"spawn_all_mrpeeks", 0 ) )
    {
        return;
    }
    
    if ( level.var_4857036439a479b5.var_88199b319e187762 && !getdvarint( @"spawn_all_mrpeeks", 0 ) )
    {
        level.var_4857036439a479b5 freescriptable();
    }
    
    if ( level.relic_mr_peeks && !getdvarint( @"spawn_all_mrpeeks", 0 ) )
    {
        level delete_mr_peeks( level.relic_mr_peeks );
    }
    
    level.relic_mr_peeks = utility::spawn_model( level.var_966e7e1f42f9a195.eventmodel, spawn_struct.origin, spawn_struct.angles );
    level.relic_mr_peeks setscriptablepartstate( #"base", #"default", 0 );
    level.relic_mr_peeks setscriptablepartstate( #"damage", #"alive", 0 );
    level.relic_mr_peeks setscriptablepartstate( #"icon", #"active", 0 );
    level.relic_mr_peeks = interaction::register_scriptable_interact( level.relic_mr_peeks getlinkedscriptableinstance(), &function_847f7bb734850ad7 );
    level.relic_mr_peeks.can_use_mrpeeks = 1;
    level.relic_mr_peeks.spawn_struct = spawn_struct;
    level.relic_mr_peeks.entity setcandamage( 1 );
    var_8ba819582d95df67 = undefined;
    egg_origin = level.relic_mr_peeks.entity gettagorigin( "J_easter_egg" );
    egg_angles = level.relic_mr_peeks.entity gettagangles( "J_easter_egg" );
    
    if ( level.zm_relic_tier > 0 )
    {
        spawnoptions = common_item::function_bc5ff2958b71a708( egg_origin, egg_angles );
        spawnoptions.var_fd47e835523b473f = 1;
        spawnoptions.dropradiusscale = 0;
        spawnoptions.critical = 1;
        positioningdata = common_item::function_b4bee4333994e45a( egg_origin, egg_angles );
        spawn_tier = randomintrange( 0, 100 );
        var_5f20fcfc47cfd8a6 = 0;
        var_a56435b1b0921265 = 0;
        var_cbcede934ccf106c = 0;
        var_18126b4d448ed35c = undefined;
        var_ccb45992fc1dce16 = 0;
        egg_to_spawn = undefined;
        
        switch ( level.zm_relic_tier )
        {
            case 1:
                var_18126b4d448ed35c = level.var_966e7e1f42f9a195.var_8ae17ca76487286a;
                break;
            case 2:
                var_18126b4d448ed35c = level.var_966e7e1f42f9a195.var_c4d4d230a2be4f85;
                break;
            case 3:
                var_18126b4d448ed35c = level.var_966e7e1f42f9a195.var_9c1d2891b1c97c08;
                break;
        }
        
        var_5f20fcfc47cfd8a6 = var_18126b4d448ed35c.var_e9b519071e5a11e8 ?? 0;
        var_a56435b1b0921265 = var_18126b4d448ed35c.var_7a7362428327eb25 ?? 0;
        var_cbcede934ccf106c = var_18126b4d448ed35c.var_ebd4cae95e264b3e ?? 0;
        
        if ( spawn_tier < var_cbcede934ccf106c )
        {
            var_ccb45992fc1dce16 = 3;
        }
        else if ( spawn_tier < var_a56435b1b0921265 + var_cbcede934ccf106c && spawn_tier >= var_cbcede934ccf106c )
        {
            var_ccb45992fc1dce16 = 2;
        }
        else
        {
            var_ccb45992fc1dce16 = 1;
        }
        
        switch ( var_ccb45992fc1dce16 )
        {
            case 1:
                egg_to_spawn = level.var_966e7e1f42f9a195.var_e812e904e6ed98e;
                break;
            case 2:
                egg_to_spawn = level.var_966e7e1f42f9a195.var_a5e2e996deb8f9ed;
                break;
            case 3:
                egg_to_spawn = level.var_966e7e1f42f9a195.var_e04bbe555cbd90d4;
                break;
        }
        
        if ( egg_to_spawn )
        {
            egg_bundle = getscriptbundle( egg_to_spawn );
            level.var_4857036439a479b5 = common_item::function_2352d25db9e97696( egg_bundle, 1, positioningdata, spawnoptions );
            level.var_4857036439a479b5 function_7653c765b6c7b815();
            level.var_4857036439a479b5.bundle = egg_bundle;
            level.var_4857036439a479b5.var_88199b319e187762 = 1;
            level.var_4857036439a479b5.tier = var_ccb45992fc1dce16;
            e_mover = utility::spawn_model( "tag_origin", egg_origin, egg_angles );
            level.var_4857036439a479b5 utility::scriptable_setparententity( e_mover );
            e_mover linkto( level.relic_mr_peeks.entity, "J_easter_egg" );
        }
        
        level thread function_60f1589153d1e1fa();
    }
}

// Namespace zm_relic_mrp_events
// Params 0, eflags: 0x4
// Checksum 0x872d0755, Offset: 0xb22
// Size: 0x71
function private function_60f1589153d1e1fa()
{
    level endon( #"mrp_event_finished" );
    lifetime = level.var_966e7e1f42f9a195.lifetime;
    wait lifetime;
    
    if ( level.var_4857036439a479b5.var_88199b319e187762 )
    {
        level.var_4857036439a479b5 freescriptable();
    }
    
    if ( level.relic_mr_peeks )
    {
        level thread delete_mr_peeks( level.relic_mr_peeks );
    }
}

// Namespace zm_relic_mrp_events
// Params 2, eflags: 0x4
// Checksum 0xc9ebd73, Offset: 0xb9b
// Size: 0xc8
function private delete_mr_peeks( scriptable_spawn, var_d39c53f1e6835e32 )
{
    level notify( #"mrp_event_finished" );
    
    if ( scriptable_spawn )
    {
        if ( var_d39c53f1e6835e32 )
        {
            scriptable_spawn setscriptablepartstate( #"damage", #"dead", 0 );
        }
        
        if ( scriptable_spawn.entity )
        {
            scriptable_spawn.entity setcandamage( 0 );
            pos = scriptable_spawn.entity.origin;
        }
        
        wait 0.3;
        
        if ( pos )
        {
            playfx( level._effect[ #"mr_peeks_disappear" ], pos );
        }
        
        if ( scriptable_spawn.entity )
        {
            scriptable_spawn.entity delete();
        }
    }
}

// Namespace zm_relic_mrp_events
// Params 4, eflags: 0x4
// Checksum 0x611943b0, Offset: 0xc6b
// Size: 0x40
function private function_847f7bb734850ad7( instance, note, param, var_64ffacba090c91be )
{
    if ( !instance.can_use_mrpeeks )
    {
        return;
    }
    
    instance thread launch_mrp_event_egg();
}

// Namespace zm_relic_mrp_events
// Params 4, eflags: 0x4
// Checksum 0x8d527045, Offset: 0xcb3
// Size: 0x41
function private relic_mrp_destroyed( instance, note, param, var_64ffacba090c91be )
{
    if ( !instance.can_use_mrpeeks )
    {
        return;
    }
    
    level thread launch_mrp_event_egg( instance );
}

// Namespace zm_relic_mrp_events
// Params 1
// Checksum 0x787cb964, Offset: 0xcfc
// Size: 0x1b2
function launch_mrp_event_egg( mrpscriptable )
{
    map_name = game_utility::getmapname();
    
    if ( map_name == "zm_sat_scarab" )
    {
        [ reward_struct ] = utility::getstructarray( mrpscriptable.spawn_struct.target, "targetname" );
    }
    else
    {
        reward_struct = utility::getstruct( mrpscriptable.spawn_struct.target, "targetname" );
    }
    
    level thread delete_mr_peeks( mrpscriptable, 1 );
    
    if ( level.var_4857036439a479b5 )
    {
        origin = level.var_4857036439a479b5.origin;
        angles = level.var_4857036439a479b5.angles;
        bundle = level.var_4857036439a479b5.bundle;
        tier = level.var_4857036439a479b5.tier;
        level.var_4857036439a479b5 freescriptable();
        spawn_options = common_item::function_f5dfaa3bbdf99a33( reward_struct.origin, origin );
        spawn_options.var_23d3495c57d61bdf = 1;
        spawn_options.var_b8402e625c429a31 = 1;
        spawn_options.var_90cdc5dbcd319e5d = 1;
        spawn_options.var_9161cf0784b6951d = 1;
        positioningdata = common_item::function_b4bee4333994e45a( origin, angles );
        level.var_4857036439a479b5 = common_item::function_61c2c0251e742ffd( bundle, 1, spawn_options );
        level.var_4857036439a479b5.var_ee6e77d4de743d14 = tier;
    }
}

// Namespace zm_relic_mrp_events
// Params 1, eflags: 0x4
// Checksum 0x8f0ec5d1, Offset: 0xeb6
// Size: 0x415
function private on_item_used( params )
{
    if ( !params.item.var_ee6e77d4de743d14 )
    {
        return;
    }
    
    tier = params.item.var_ee6e77d4de743d14;
    var_e9564cd22ae43276 = undefined;
    reward = undefined;
    count = 0;
    
    switch ( tier )
    {
        case 1:
            var_e9564cd22ae43276 = level.var_966e7e1f42f9a195.var_11414237c992bf41.var_36ab00b9ea8953d4;
            reward = level.var_966e7e1f42f9a195.var_11414237c992bf41;
            count = 10;
            break;
        case 2:
            var_e9564cd22ae43276 = level.var_966e7e1f42f9a195.var_11413f37c992b8a8.var_36ab00b9ea8953d4;
            reward = level.var_966e7e1f42f9a195.var_11413f37c992b8a8;
            count = 22;
            break;
        case 3:
            var_e9564cd22ae43276 = level.var_966e7e1f42f9a195.var_11414037c992badb.var_36ab00b9ea8953d4;
            reward = level.var_966e7e1f42f9a195.var_11414037c992badb;
            count = 27;
            break;
    }
    
    if ( var_e9564cd22ae43276 )
    {
        spawnoptions = common_item::items_initspawnoptions_spawnfromposition( params.item.origin );
        common_item::function_577fe3f000fcb275( 0.1, count, var_e9564cd22ae43276, spawnoptions );
        
        foreach ( rewardref in reward.var_e03185bbc6167b4b )
        {
            switch ( rewardref.var_e03185bbc6167b4b )
            {
                case #"map_wonder_weapon":
                    if ( level.mapname == "zm_sat_ruby" && !level utility::flag( "ruby_wwq_complete" ) )
                    {
                        break;
                    }
                    else if ( level.mapname == "zm_sat_locust" && !level utility::flag( "ww_step_08" ) )
                    {
                        break;
                    }
                    else
                    {
                        wonder_weapons_items = level.var_8b6bf63f61fe01f9;
                    }
                    
                    wonder_weapons_items = level.var_8b6bf63f61fe01f9;
                    wonder_bundle = getscriptbundle( wonder_weapons_items );
                    possible_weapons = [];
                    
                    foreach ( item in wonder_bundle.itementries )
                    {
                        item_bundle = getscriptbundle( item.itemspawnentry );
                        var_2e08e94c9cb1747c = getxhashasset( item_bundle.ref );
                        
                        if ( level.weaponmetadata[ var_2e08e94c9cb1747c ].var_3e8739d232e1b023 )
                        {
                            possible_weapons[ possible_weapons.size ] = item;
                        }
                    }
                    
                    if ( possible_weapons.size > 0 )
                    {
                        item_to_spawn = utility::array_random( possible_weapons );
                        common_item::function_57b88e025e5fb03e( item_to_spawn.itemspawnentry, undefined, spawnoptions );
                    }
                    
                    break;
                default:
                    break;
            }
        }
        
        effect = spawnscriptable( level.var_966e7e1f42f9a195.rewardeffect, params.item.origin, params.item.angles );
        wait 5;
        effect setscriptablepartstate( #"base", #"hidden", 0 );
        wait 2;
        
        if ( effect )
        {
            effect freescriptable();
        }
    }
}

// Namespace zm_relic_mrp_events
// Params 0, eflags: 0x4
// Checksum 0xd61245f7, Offset: 0x12d3
// Size: 0x15, Type: bool
function private is_valid_gametype()
{
    if ( game_utility::getgametype() == "zm_rb_echo" )
    {
        return false;
    }
    
    return true;
}

/#

    // Namespace zm_relic_mrp_events
    // Params 0
    // Checksum 0xf0eae96c, Offset: 0x12f1
    // Size: 0xbe, Type: dev
    function init_mrp_events_debug()
    {
        wait 5;
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        
        foreach ( key, value in level.var_103d11662a9d894b )
        {
            devgui::function_cd4e263c1f3018ae( "<dev string:x40>" + key, "<dev string:x53>" + key, &debug_spawn_mr_peeks, 0 );
        }
        
        devgui::add_devgui_func( "<dev string:x69>", "<dev string:x7a>", &function_bc0060a49c7517c8 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_relic_mrp_events
    // Params 1
    // Checksum 0xe8036e4e, Offset: 0x13b7
    // Size: 0x14f, Type: dev
    function function_bc0060a49c7517c8( warplocation )
    {
        if ( level.relic_mr_peeks )
        {
            foreach ( player in level.players )
            {
                origin = level.relic_mr_peeks.origin;
                angles = level.relic_mr_peeks.angles + ( 0, -90, 0 );
                right = anglestoright( level.relic_mr_peeks.angles );
                plangles = vectortoangles( right ) + ( 0, 180, 0 );
                var_dfcdb500ce642a84 = origin + anglestoforward( angles ) * 24;
                var_dfcdb500ce642a84 = getgroundposition( var_dfcdb500ce642a84, 16 );
                player setorigin( var_dfcdb500ce642a84 );
                player setplayerangles( plangles );
            }
            
            return;
        }
        
        iprintlnbold( "<dev string:x95>" );
    }

    // Namespace zm_relic_mrp_events
    // Params 1
    // Checksum 0xb6ed1f3, Offset: 0x150e
    // Size: 0x49, Type: dev
    function debug_spawn_mr_peeks( params )
    {
        if ( level.var_4857036439a479b5 )
        {
            level.var_4857036439a479b5 freescriptable();
        }
        
        waitframe();
        level spawn_mr_peeks( level.var_103d11662a9d894b[ int( script::stringtofloat( params[ 0 ] ) ) ] );
    }

#/
