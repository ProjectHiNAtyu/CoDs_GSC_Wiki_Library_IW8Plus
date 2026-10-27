// script_169bdade354e8571  (hash_169bdade354e8571.gscc) (size: 23045 Bytes / 0x5a05 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb302a8fc (3003295996)
// size ...... 23045 (0x5a05)
// includes .. 16  (offset: 0x5369)
// strings ... 67  (offset: 0x53e9)
// dev strs .. 28  (offset: 0x5899)
// exports ... 42  (offset: 0x3b9d)
// cseg ...... 0x5bb + 0x35e2 (0x3b9d)
// imports ... 129 (offset: 0x422d)
// animtree1 . 0   (offset: 0x5a05)
// animtree2 . 0   (offset: 0x5a05)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\destructibles\destructibles;
#using scripts\mp\loot\common_item;
#using scripts\mp\zm\spawners\zone_spawner;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_reward_bundle;
#using scripts\mp\zm\systems\zm_vo;

#namespace namespace_f56500c5c92c7217;

// Namespace namespace_f56500c5c92c7217
// Params 0, eflags: 0x5
// Checksum 0x960e0aec, Offset: 0x5d9
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_mantis_ee_alchemy", undefined, undefined, &post_main );
}

// Namespace namespace_f56500c5c92c7217
// Params 0
// Checksum 0x78257d1e, Offset: 0x5fa
// Size: 0xfc
function post_main()
{
    if ( game_utility::function_21211f3255f8ea58() )
    {
        return;
    }
    
    if ( !getdvarint( @"hash_bb9c6e9d56b8b577", 0 ) )
    {
        return;
    }
    
    zm_quest::register_quest_step( #"mantis_ee_alchemy", #"find_materials", &function_62abef68214859c9, &function_e0197dd686d26c2e );
    zm_quest::register_quest_step( #"mantis_ee_alchemy", #"feed_cyst", &function_62abec6821485330, &function_e0197cd686d269fb );
    zm_quest::register_quest_step( #"mantis_ee_alchemy", #"kill_zombie", &function_62abed6821485563, &function_e0197bd686d267c8 );
    zm_quest::register_quest_step( #"mantis_ee_alchemy", #"kill_hvt", &function_62abf26821486062, &function_e01982d686d2772d );
    
    while ( function_88019988a923b7b0() )
    {
        /#
            if ( getdvarint( @"hash_1ef28e19509f7f3e", 0 ) )
            {
                break;
            }
        #/
        
        wait 1;
    }
    
    level thread setup_alchemy_quest();
    level thread zm_quest::start_quest( #"mantis_ee_alchemy" );
    level thread watch_boss_fight_begin();
    
    /#
        setup_alchemy_ee_devgui();
    #/
}

// Namespace namespace_f56500c5c92c7217
// Params 0, eflags: 0x4
// Checksum 0xd5da3193, Offset: 0x6fe
// Size: 0x33, Type: bool
function private function_88019988a923b7b0()
{
    wwq = level.zm_quests[ #"mantis_ww_quest" ];
    return wwq && !wwq.completed;
}

// Namespace namespace_f56500c5c92c7217
// Params 0
// Checksum 0xa4972597, Offset: 0x73a
// Size: 0x34
function setup_alchemy_quest()
{
    level.alchemy_ee = spawnstruct();
    level utility::flag_wait( "scriptables_ready" );
    level thread function_475e03dd01a488af();
    level thread spawn_alchemy_bowl();
    level thread function_9fe68ecd941a07dd();
}

// Namespace namespace_f56500c5c92c7217
// Params 0
// Checksum 0xc10f22ac, Offset: 0x776
// Size: 0xb2
function function_9fe68ecd941a07dd()
{
    s_alchemy_cyst = utility::getstruct( "alchemy_cyst", "script_noteworthy" );
    s_alchemy_cyst.sbl = spawnscriptable( "sat_destructible_souleater_cyst_alchemy_ee", s_alchemy_cyst.origin, s_alchemy_cyst.angles );
    
    if ( !s_alchemy_cyst.interact )
    {
        s_alchemy_cyst.interact = zm_quest::function_91f9590e98d57ff6( s_alchemy_cyst.origin, &function_1850db5fff77be77, &loot_cyst_interact_hint, "small" );
        s_alchemy_cyst.interact.parent = s_alchemy_cyst;
    }
    
    level.alchemy_ee.cyst = s_alchemy_cyst;
}

// Namespace namespace_f56500c5c92c7217
// Params 0
// Checksum 0x9dc42966, Offset: 0x830
// Size: 0xf7
function spawn_alchemy_bowl()
{
    var_e6bff873de487c70 = utility::getstruct( "alchemy_bowl", "script_noteworthy" );
    drop_positions = utility::getstructarray( var_e6bff873de487c70.target );
    var_e6bff873de487c70.mdl = utility::spawn_model( "fence_wood_planks_01_64", var_e6bff873de487c70.origin, var_e6bff873de487c70.angles );
    var_e6bff873de487c70.drop_positions = drop_positions;
    s_bowl_interact = utility::getstruct( "alchemy_bowl_interact", "script_noteworthy" );
    
    if ( !var_e6bff873de487c70.interact )
    {
        var_e6bff873de487c70.interact = zm_quest::function_91f9590e98d57ff6( s_bowl_interact.origin, &on_alchemy_bowl_interact, &alchemy_bowl_interact_hint, "small" );
        var_e6bff873de487c70.interact.parent = var_e6bff873de487c70;
    }
    
    level.alchemy_ee.bowl = var_e6bff873de487c70;
}

// Namespace namespace_f56500c5c92c7217
// Params 0
// Checksum 0xf1d48748, Offset: 0x92f
// Size: 0x236
function function_475e03dd01a488af()
{
    level.var_9d8bab492621b48 = [];
    level.var_cb950293ce77991a = [];
    level.var_77247bfdb5c8dbd0 = [];
    level.alchemy_formula[ "formula_1" ] = [ "meat", "bone", "metal" ];
    level.alchemy_formula[ "formula_2" ] = [ "meat", "bone", "collar" ];
    level.alchemy_formula[ "formula_3" ] = [ "meat", "bone", "blood", "battery" ];
    level.alchemy_formula[ "formula_4" ] = [ "meat", "bone", "skull", "blood" ];
    level.alchemy_formula[ "formula_5" ] = [ "meat", "bone", "skull", "blood", "battery", "metal", "collar" ];
    level.var_fd5e7f04bf7582cb[ 0 ] = [];
    level.var_fd5e7f04bf7582cb[ 1 ] = "zombie_base_armored_heavy";
    level.var_fd5e7f04bf7582cb[ 2 ] = "zombie_methone";
    level.var_fd5e7f04bf7582cb[ 3 ] = "zombie_mimic_hvt";
    level.var_fd5e7f04bf7582cb[ 4 ] = "zombie_ghoul_hvt";
    level.var_fd5e7f04bf7582cb[ 5 ] = "all";
    level.var_52df2de48eff5cda = [];
    level.var_52df2de48eff5cda[ "meat" ] = "t10_food_market_goods_raw_meat_04";
    level.var_52df2de48eff5cda[ "bone" ] = "p7_skulls_bones_arm_lower";
    level.var_52df2de48eff5cda[ "battery" ] = "uk_automotive_car_battery_01";
    level.var_52df2de48eff5cda[ "blood" ] = "t10_zm_gore_organs_pile_11";
    level.var_52df2de48eff5cda[ "collar" ] = "jup_zm_relic_hunt_collar";
    level.var_52df2de48eff5cda[ "skull" ] = "c_sat_zmb_corpse_vandorn_skull";
    level.var_52df2de48eff5cda[ "metal" ] = "decor_misc_props_01_bucket_metal";
}

// Namespace namespace_f56500c5c92c7217
// Params 1
// Checksum 0xf8739195, Offset: 0xb6d
// Size: 0xe7
function function_a4f0f30adb7895d8( var_7cc8750aa7cac27b = 1 )
{
    level thread spawn_material( "alchemy_ee_material_battery", "battery", "uk_automotive_car_battery_01", "uin_zm_common_pickup_item_important", var_7cc8750aa7cac27b );
    level thread spawn_material( "alchemy_ee_material_blood", "blood", "t10_zm_gore_organs_pile_11", "uin_zm_common_pickup_item_important", var_7cc8750aa7cac27b );
    level thread spawn_material( "alchemy_ee_material_bone", "bone", "p7_skulls_bones_arm_lower", "uin_zm_common_pickup_item_important", var_7cc8750aa7cac27b );
    level thread spawn_material( "alchemy_ee_material_collar", "collar", "jup_zm_relic_hunt_collar", "uin_zm_common_pickup_item_important", var_7cc8750aa7cac27b );
    level thread spawn_material( "alchemy_ee_material_meat", "meat", "t10_food_market_goods_raw_meat_04", "uin_zm_common_pickup_item_important", var_7cc8750aa7cac27b );
    level thread spawn_material( "alchemy_ee_material_metal", "metal", "decor_misc_props_01_bucket_metal", "uin_zm_common_pickup_item_important", var_7cc8750aa7cac27b );
    level thread spawn_material( "alchemy_ee_material_skull", "skull", "c_sat_zmb_corpse_vandorn_skull", "uin_zm_common_pickup_item_important", var_7cc8750aa7cac27b );
}

// Namespace namespace_f56500c5c92c7217
// Params 1
// Checksum 0xf06990a4, Offset: 0xc5c
// Size: 0x108
function function_88bbb676b286190( var_7cc8750aa7cac27b )
{
    function_e1242234d311fb26( "battery", zm_quest::function_73720cdf21c3cfd7( #"mantis_ee_alchemy", #"battery" ) );
    function_e1242234d311fb26( "blood", zm_quest::function_73720cdf21c3cfd7( #"mantis_ee_alchemy", #"blood" ) );
    function_e1242234d311fb26( "bone", zm_quest::function_73720cdf21c3cfd7( #"mantis_ee_alchemy", #"bone" ) );
    function_e1242234d311fb26( "collar", zm_quest::function_73720cdf21c3cfd7( #"mantis_ee_alchemy", #"collar" ) );
    function_e1242234d311fb26( "meat", zm_quest::function_73720cdf21c3cfd7( #"mantis_ee_alchemy", #"meat" ) );
    function_e1242234d311fb26( "metal", zm_quest::function_73720cdf21c3cfd7( #"mantis_ee_alchemy", #"metal" ) );
    function_e1242234d311fb26( "skull", zm_quest::function_73720cdf21c3cfd7( #"mantis_ee_alchemy", #"skull" ) );
}

// Namespace namespace_f56500c5c92c7217
// Params 2
// Checksum 0x9a069f2a, Offset: 0xd6c
// Size: 0xaa
function function_e1242234d311fb26( var_21ea2a5f47371b4b, state = 1 )
{
    switch ( state )
    {
        case 1:
            level thread spawn_material( "alchemy_ee_material_" + var_21ea2a5f47371b4b, var_21ea2a5f47371b4b, level.var_52df2de48eff5cda[ var_21ea2a5f47371b4b ], "uin_zm_common_pickup_item_important", 1 );
            break;
        case 2:
            level.var_9d8bab492621b48[ level.var_9d8bab492621b48.size ] = var_21ea2a5f47371b4b;
            break;
        case 3:
            level thread function_6d5d28b4f263b89a( var_21ea2a5f47371b4b );
            break;
        case 4:
            break;
    }
}

// Namespace namespace_f56500c5c92c7217
// Params 1
// Checksum 0x7b875c1b, Offset: 0xe1e
// Size: 0x13e
function function_6d5d28b4f263b89a( var_21ea2a5f47371b4b )
{
    foreach ( pos in level.alchemy_ee.bowl.drop_positions )
    {
        if ( pos.script_label == var_21ea2a5f47371b4b )
        {
            mdl = utility::spawn_model( level.var_52df2de48eff5cda[ var_21ea2a5f47371b4b ], pos.origin, pos.angles );
            level.var_77247bfdb5c8dbd0 = arraycombineunique( level.var_77247bfdb5c8dbd0, [ mdl ] );
            
            /#
                printtoscreen2d( 500, 500, "<dev string:x24>" + var_21ea2a5f47371b4b );
            #/
            
            break;
        }
    }
    
    level.var_cb950293ce77991a = arraycombineunique( level.var_cb950293ce77991a, [ var_21ea2a5f47371b4b ] );
    level.var_9d8bab492621b48 = arrayremove( level.var_9d8bab492621b48, var_21ea2a5f47371b4b );
}

// Namespace namespace_f56500c5c92c7217
// Params 6
// Checksum 0x6ff44760, Offset: 0xf64
// Size: 0x1cd
function spawn_material( struct, var_21ea2a5f47371b4b, mdl, sound, var_7cc8750aa7cac27b = 1, var_4fc19e7c0b29a031 = "small" )
{
    s_item_spawn = utility::getstruct( struct, "script_noteworthy" );
    
    if ( !s_item_spawn )
    {
        return;
    }
    
    if ( !s_item_spawn.mdl )
    {
        s_item_spawn.mdl = utility::spawn_model( mdl, s_item_spawn.origin, s_item_spawn.angles );
    }
    
    if ( !s_item_spawn.var_21ea2a5f47371b4b )
    {
        s_item_spawn.var_21ea2a5f47371b4b = var_21ea2a5f47371b4b;
    }
    
    if ( !var_7cc8750aa7cac27b )
    {
        return;
    }
    
    if ( !s_item_spawn.interact )
    {
        s_item_spawn.interact = zm_quest::function_91f9590e98d57ff6( s_item_spawn.origin, &function_5ba6bd37d0d2a6ae, &function_29c58890dd0ff38c, var_4fc19e7c0b29a031 );
        s_item_spawn.interact.sound = sound;
        s_item_spawn.interact.parent = s_item_spawn;
    }
    
    if ( getdvarint( @"alchemy_ee_draw_debug", 0 ) )
    {
        /#
            s_item_spawn thread draw_sphere();
        #/
    }
    
    while ( !level.alchemy_ee )
    {
        wait 1;
    }
    
    if ( !isdefined( level.alchemy_ee.materials ) )
    {
        level.alchemy_ee.materials = [];
    }
    
    level.alchemy_ee.materials[ level.alchemy_ee.materials.size ] = s_item_spawn;
    function_d4903f0e601640e3( s_item_spawn.var_21ea2a5f47371b4b, 1 );
}

// Namespace namespace_f56500c5c92c7217
// Params 1
// Checksum 0x120241ec, Offset: 0x1139
// Size: 0xf0
function function_5ba6bd37d0d2a6ae( player )
{
    if ( !self.parent )
    {
        return;
    }
    
    s_item_spawn = self.parent;
    
    /#
        printtoscreen2d( 500, 500, "<dev string:x36>" + s_item_spawn.var_21ea2a5f47371b4b );
    #/
    
    player playlocalsound( self.sound );
    level.var_9d8bab492621b48[ level.var_9d8bab492621b48.size ] = s_item_spawn.var_21ea2a5f47371b4b;
    level.alchemy_ee.materials = arrayremove( level.alchemy_ee.materials, s_item_spawn );
    utility::flag_set( "collected_material" );
    
    if ( s_item_spawn.mdl )
    {
        s_item_spawn.mdl delete();
    }
    
    zm_quest::function_9170db4686f796e2();
    function_d4903f0e601640e3( s_item_spawn.var_21ea2a5f47371b4b, 2 );
}

// Namespace namespace_f56500c5c92c7217
// Params 2
// Checksum 0x39188ce2, Offset: 0x1231
// Size: 0x33
function function_d4903f0e601640e3( var_21ea2a5f47371b4b, value )
{
    if ( isdefined( var_21ea2a5f47371b4b ) )
    {
        zm_quest::function_4eefe6de31f5ddab( #"mantis_ee_alchemy", getxhash( var_21ea2a5f47371b4b ), value );
    }
}

// Namespace namespace_f56500c5c92c7217
// Params 2
// Checksum 0x7d2e487c, Offset: 0x126c
// Size: 0x59
function function_29c58890dd0ff38c( interact, player )
{
    /#
        sphere( interact.origin, 10, ( 0, 1, 0 ), 0 );
    #/
    
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace namespace_f56500c5c92c7217
// Params 1
// Checksum 0xb852a24b, Offset: 0x12ce
// Size: 0x487
function function_1850db5fff77be77( player )
{
    context = function_dc23ca251a135240( level.var_cb950293ce77991a );
    
    if ( !context )
    {
        return;
    }
    
    if ( context.is_enough )
    {
        /#
            printtoscreen2d( 500, 500, "<dev string:x45>" + context.formula );
        #/
        
        level.alchemy_ee.spawn_aitype = level.var_fd5e7f04bf7582cb[ context.formula ];
        zm_quest::function_4eefe6de31f5ddab( #"mantis_ee_alchemy", #"elite_aitype", context.formula );
        
        switch ( level.alchemy_ee.spawn_aitype )
        {
            case #"hash_99a38be9e88b5244":
                level.alchemy_ee.required_souls = 20;
                break;
            case #"hash_e54f647382ba2db2":
                level.alchemy_ee.required_souls = 20;
                break;
            case #"hash_c1fa8721b046b258":
                level.alchemy_ee.required_souls = 30;
                break;
            case #"hash_818f3678466848ec":
                level.alchemy_ee.required_souls = 30;
                break;
            case #"hash_c482c6c109150a4":
                level.alchemy_ee.required_souls = 50;
                break;
        }
        
        zm_quest::function_4eefe6de31f5ddab( #"mantis_ee_alchemy", #"hash_aeed6ca2f388259", level.alchemy_ee.required_souls );
        zm_quest::function_9170db4686f796e2();
        level.alchemy_ee.bowl.interact zm_quest::function_9170db4686f796e2();
        
        foreach ( mdl in level.var_77247bfdb5c8dbd0 )
        {
            playfxontag( utility::getfx( #"hash_88f6d1ad054f367a" ), mdl, "tag_origin" );
            mdl playsound( #"hash_91a1a82002fddba0" );
            mdl moveto( level.alchemy_ee.cyst.sbl.origin, 1, 0, 0 );
            mdl rotatepitch( 45, 1 );
            mdl waittill( #"movedone" );
            
            if ( mdl )
            {
                playsoundatpos( mdl.origin, #"hash_641d78b87b726117" );
                stopfxontag( utility::getfx( #"hash_88f6d1ad054f367a" ), mdl, "tag_origin" );
                mdl delete();
            }
            
            level.alchemy_ee.cyst.sbl setscriptablepartstate( "effect", "harvest" );
        }
        
        foreach ( material in level.var_cb950293ce77991a )
        {
            function_d4903f0e601640e3( material, 4 );
        }
        
        level.var_77247bfdb5c8dbd0 = undefined;
        level.var_9d8bab492621b48 = undefined;
        level.var_cb950293ce77991a = undefined;
        
        foreach ( material in level.alchemy_ee.materials )
        {
            if ( material.mdl )
            {
                material.mdl delete();
            }
            
            if ( material.interact )
            {
                material.interact zm_quest::function_9170db4686f796e2();
            }
        }
        
        level.alchemy_ee.materials = undefined;
        utility::flag_set( "feeded_cyst" );
    }
}

// Namespace namespace_f56500c5c92c7217
// Params 2
// Checksum 0x1296f285, Offset: 0x175d
// Size: 0x59
function loot_cyst_interact_hint( interact, player )
{
    /#
        sphere( interact.origin, 10, ( 0, 1, 0 ), 0 );
    #/
    
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace namespace_f56500c5c92c7217
// Params 1
// Checksum 0x92f3692, Offset: 0x17bf
// Size: 0x180
function on_alchemy_bowl_interact( player )
{
    var_e6bff873de487c70 = self.parent;
    
    if ( !var_e6bff873de487c70 )
    {
        return;
    }
    
    if ( level.var_9d8bab492621b48.size == 0 )
    {
        return;
    }
    
    mat_name = level.var_9d8bab492621b48[ 0 ];
    
    foreach ( pos in var_e6bff873de487c70.drop_positions )
    {
        if ( pos.script_label == mat_name )
        {
            mdl = utility::spawn_model( level.var_52df2de48eff5cda[ mat_name ], pos.origin, pos.angles );
            level.var_77247bfdb5c8dbd0[ level.var_77247bfdb5c8dbd0.size ] = mdl;
            mdl playsound( #"hash_94fdb8b27ff3af84" );
            function_d4903f0e601640e3( mat_name, 3 );
            
            /#
                printtoscreen2d( 500, 500, "<dev string:x24>" + mat_name );
            #/
            
            break;
        }
    }
    
    level.var_cb950293ce77991a = arraycombineunique( level.var_cb950293ce77991a, [ mat_name ] );
    level.var_9d8bab492621b48 = arrayremove( level.var_9d8bab492621b48, mat_name );
}

// Namespace namespace_f56500c5c92c7217
// Params 2
// Checksum 0xfa5e7660, Offset: 0x1947
// Size: 0x59
function alchemy_bowl_interact_hint( interact, player )
{
    /#
        sphere( interact.origin, 10, ( 0, 1, 0 ), 0 );
    #/
    
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace namespace_f56500c5c92c7217
// Params 1
// Checksum 0x6dcb8c, Offset: 0x19a9
// Size: 0x15f
function function_dc23ca251a135240( alchemy_array )
{
    context = spawnstruct();
    context.is_enough = 0;
    context.formula = undefined;
    
    if ( function_2064bd6885e0f891( alchemy_array, level.alchemy_formula[ "formula_5" ] ) )
    {
        context.is_enough = 1;
        context.formula = 5;
        return context;
    }
    else if ( function_2064bd6885e0f891( alchemy_array, level.alchemy_formula[ "formula_4" ] ) )
    {
        context.is_enough = 1;
        context.formula = 4;
        return context;
    }
    else if ( function_2064bd6885e0f891( alchemy_array, level.alchemy_formula[ "formula_3" ] ) )
    {
        context.is_enough = 1;
        context.formula = 3;
        return context;
    }
    else if ( function_2064bd6885e0f891( alchemy_array, level.alchemy_formula[ "formula_2" ] ) )
    {
        context.is_enough = 1;
        context.formula = 2;
        return context;
    }
    else if ( function_2064bd6885e0f891( alchemy_array, level.alchemy_formula[ "formula_1" ] ) )
    {
        context.is_enough = 1;
        context.formula = 1;
        return context;
    }
    
    return context;
}

// Namespace namespace_f56500c5c92c7217
// Params 2
// Checksum 0xce9edca1, Offset: 0x1b11
// Size: 0x8d, Type: bool
function function_2064bd6885e0f891( arraya, arrayb )
{
    foreach ( value in arrayb )
    {
        if ( !arraycontains( arraya, value ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace namespace_f56500c5c92c7217
// Params 2
// Checksum 0xc4d734ae, Offset: 0x1ba7
// Size: 0x54
function function_62abef68214859c9( b_skipped, b_save_restored )
{
    wait 1;
    level.var_52c6d92e2b1b482b = 1;
    zm_quest::function_4eefe6de31f5ddab( #"mantis_ee_alchemy", #"quest_step", 1 );
    level thread function_a4f0f30adb7895d8( 1 );
    utility::flag_wait( "collected_material" );
}

// Namespace namespace_f56500c5c92c7217
// Params 2
// Checksum 0xed05599a, Offset: 0x1c03
// Size: 0x48
function function_e0197dd686d26c2e( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        while ( !isdefined( level.alchemy_ee.cyst ) )
        {
            wait 1;
        }
        
        level thread function_88bbb676b286190( 1 );
    }
}

// Namespace namespace_f56500c5c92c7217
// Params 2
// Checksum 0x44835d7d, Offset: 0x1c53
// Size: 0x47
function function_62abec6821485330( b_skipped, b_save_restored )
{
    level.var_52c6d92e2b1b482b = 2;
    zm_quest::function_4eefe6de31f5ddab( #"mantis_ee_alchemy", #"quest_step", 2 );
    utility::flag_wait( "feeded_cyst" );
}

// Namespace namespace_f56500c5c92c7217
// Params 2
// Checksum 0x2d9ab085, Offset: 0x1ca2
// Size: 0x20d
function function_e0197cd686d269fb( b_skipped, b_save_restored )
{
    foreach ( material in level.alchemy_ee.materials )
    {
        if ( material.mdl )
        {
            material.mdl delete();
        }
        
        if ( material.interact )
        {
            material.interact zm_quest::function_9170db4686f796e2();
        }
    }
    
    level.alchemy_ee.cyst.interact zm_quest::function_9170db4686f796e2();
    
    if ( b_skipped || b_save_restored )
    {
        if ( zm_quest::function_73720cdf21c3cfd7( #"mantis_ee_alchemy", #"elite_aitype" ) )
        {
            formula = zm_quest::function_73720cdf21c3cfd7( #"mantis_ee_alchemy", #"elite_aitype" );
            level.alchemy_ee.spawn_aitype = level.var_fd5e7f04bf7582cb[ formula ];
        }
        else
        {
            level.alchemy_ee.spawn_aitype = "zombie_base_armored_heavy";
        }
        
        if ( zm_quest::function_73720cdf21c3cfd7( #"mantis_ee_alchemy", #"hash_aeed6ca2f388259" ) )
        {
            level.alchemy_ee.required_souls = zm_quest::function_73720cdf21c3cfd7( #"mantis_ee_alchemy", #"hash_aeed6ca2f388259" );
        }
        else
        {
            level.alchemy_ee.required_souls = 20;
        }
        
        level thread function_9464570ccdf080fd();
        
        if ( !level callback::exists( #"on_ai_killed", &function_8c5e06ee1e60aeb7 ) )
        {
            level callback::add( #"on_ai_killed", &function_8c5e06ee1e60aeb7 );
        }
        
        return;
    }
}

// Namespace namespace_f56500c5c92c7217
// Params 2
// Checksum 0x321d7344, Offset: 0x1eb7
// Size: 0x91
function function_62abed6821485563( b_skipped, b_save_restored )
{
    /#
        printtoscreen2d( 500, 500, "<dev string:x4f>" );
    #/
    
    level.var_52c6d92e2b1b482b = 3;
    zm_quest::function_4eefe6de31f5ddab( #"mantis_ee_alchemy", #"quest_step", 3 );
    level thread function_9464570ccdf080fd();
    
    if ( !level callback::exists( #"on_ai_killed", &function_8c5e06ee1e60aeb7 ) )
    {
        level callback::add( #"on_ai_killed", &function_8c5e06ee1e60aeb7 );
    }
    
    utility::flag_wait( "harvest_soul_complete" );
}

// Namespace namespace_f56500c5c92c7217
// Params 2
// Checksum 0x2dfc267d, Offset: 0x1f50
// Size: 0xda
function function_e0197bd686d267c8( b_skipped, b_save_restored )
{
    level notify( #"hash_3fe6b2a1e329b07d" );
    level.alchemy_ee.cyst.sbl destructible::destroy();
    
    foreach ( zombie in level.var_b460f69918d4d908 )
    {
        if ( !zombie || !isalive( zombie ) )
        {
            continue;
        }
        
        zombie kill();
    }
    
    level.var_b460f69918d4d908 = undefined;
}

// Namespace namespace_f56500c5c92c7217
// Params 2
// Checksum 0xac89e015, Offset: 0x2032
// Size: 0x128
function function_62abf26821486062( b_skipped, b_save_restored )
{
    level.var_52c6d92e2b1b482b = 4;
    zm_quest::function_4eefe6de31f5ddab( #"mantis_ee_alchemy", #"quest_step", 4 );
    
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level.alchemy_ee.elite_zombie = [];
    
    switch ( level.alchemy_ee.spawn_aitype )
    {
        case #"hash_818f3678466848ec":
        case #"hash_99a38be9e88b5244":
        case #"hash_c1fa8721b046b258":
        case #"hash_e54f647382ba2db2":
            level thread function_ca324608b1b53bec( level.alchemy_ee.spawn_aitype );
            break;
        case #"hash_c482c6c109150a4":
            level thread function_ca324608b1b53bec( "zombie_base_armored_heavy", 0.5 );
            level thread function_ca324608b1b53bec( "zombie_methone", 0.5 );
            level thread function_ca324608b1b53bec( "zombie_mimic_hvt", 0.5 );
            level thread function_ca324608b1b53bec( "zombie_ghoul_hvt", 0.5 );
            break;
    }
    
    utility::flag_wait( "ee_alchemy_complete" );
}

// Namespace namespace_f56500c5c92c7217
// Params 2
// Checksum 0xc965a8c9, Offset: 0x2162
// Size: 0x37
function function_e01982d686d2772d( b_skipped, b_save_restored )
{
    level.var_52c6d92e2b1b482b = 5;
    
    if ( b_skipped || b_save_restored )
    {
        level notify( #"hash_4a060e44bd20ca92" );
    }
}

// Namespace namespace_f56500c5c92c7217
// Params 0
// Checksum 0x116f9ab1, Offset: 0x21a1
// Size: 0x301
function function_9464570ccdf080fd()
{
    self notify( #"hash_80bfd2b94713ff62" );
    self endon( #"hash_80bfd2b94713ff62" );
    level endon( #"game_ended" );
    level endon( #"hash_3fe6b2a1e329b07d" );
    level endon( #"boss_fight_started" );
    var_6469c1e4d3ac4060 = utility::getstruct( "alchemy_spawner", "script_noteworthy" );
    a_s_spawners = utility::getstructarray( var_6469c1e4d3ac4060.target, "targetname" );
    
    if ( !a_s_spawners )
    {
        return;
    }
    
    if ( !level.var_b460f69918d4d908 )
    {
        level.var_b460f69918d4d908 = [];
    }
    
    while ( true )
    {
        is_player_nearby = 0;
        
        foreach ( player in level.players )
        {
            if ( distance2dsquared( player.origin, a_s_spawners[ 0 ].origin ) < 360000 )
            {
                is_player_nearby = 1;
            }
        }
        
        if ( !is_player_nearby )
        {
            wait 1;
            continue;
        }
        
        foreach ( s_spawn_loc in a_s_spawners )
        {
            spawn_origin = getclosestpointonnavmesh( s_spawn_loc.origin );
            
            if ( !spawn_origin )
            {
                continue;
            }
            
            zombie = agent_manager::spawn_agent( "zombie_base", spawn_origin );
            
            if ( !zombie )
            {
                continue;
            }
            
            zombie.no_powerups = 1;
            zombie val::set( "alchemy_ee", "ignore_cleanup", 1 );
            zombie.ignore_enemy_count = 1;
            zombie.b_cleanup_no_respawn = 1;
            zombie.var_825b17c932865df = 1;
            zombie.b_ignore_cleanup = 1;
            zombie.var_a13bed1ac47e1b2c = 1;
            zombie.var_7ee152b43c7188e1 = 1;
            zombie.disable_brain_rot = 1;
            zombie.is_alchemy_ee_zombie = 1;
            zombie thread zone_spawner::function_ce10e453e7f7bb8e( s_spawn_loc );
            zombie zombie_utils::function_a8ce00e0448cb6f0( "sprint", "alchemy_ee", 6 );
            zombie setscriptablepartstate( "base", "base_purple_eyes" );
            
            if ( !isdefined( level.var_b460f69918d4d908 ) )
            {
                level.var_b460f69918d4d908 = [];
            }
            
            level.var_b460f69918d4d908[ level.var_b460f69918d4d908.size ] = zombie;
            wait 1;
        }
        
        level.var_b460f69918d4d908 = function_46f9072493651dc9( level.var_b460f69918d4d908 );
        waitframe();
    }
}

// Namespace namespace_f56500c5c92c7217
// Params 1
// Checksum 0xc787f08, Offset: 0x24aa
// Size: 0x60
function function_8c5e06ee1e60aeb7( var_b19ce51dfc12b7f8 )
{
    cyst = level.alchemy_ee.cyst.sbl;
    
    if ( distance2d( self.origin, cyst.origin ) < 300 )
    {
        cyst thread harvest_soul( self, 5 );
    }
}

// Namespace namespace_f56500c5c92c7217
// Params 0
// Checksum 0xa8fa96d1, Offset: 0x2512
// Size: 0x128
function function_5b55de462aaa6694()
{
    level endon( #"game_ended" );
    level endon( #"boss_fight_started" );
    level endon( #"hash_4a060e44bd20ca92" );
    self waittill( #"death", attacker );
    
    if ( attacker.classname == "worldspawn" )
    {
        return;
    }
    
    level.alchemy_ee.elite_zombie = arrayremove( level.alchemy_ee.elite_zombie, self );
    level.alchemy_ee.elite_zombie = function_46f9072493651dc9( level.alchemy_ee.elite_zombie );
    
    if ( level.alchemy_ee.elite_zombie.size > 0 )
    {
        return;
    }
    
    if ( attacker namespace_c0b4f2882c9d100f::is_hero_operator() )
    {
        attacker thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"alchemy_ee_end" );
    }
    else
    {
        level thread battlechatter_mp::trysaylocalsound( attacker, #"bc_flavor_player_negative", undefined, undefined, undefined, undefined, undefined, undefined, 1 );
    }
    
    level thread spawn_rewards( self.origin, attacker.origin );
    utility::flag_set( "ee_alchemy_complete" );
}

// Namespace namespace_f56500c5c92c7217
// Params 2
// Checksum 0x90d9ab96, Offset: 0x2642
// Size: 0x4c4
function function_ca324608b1b53bec( aitype, var_eab9d49b6c271d50 = 1 )
{
    level endon( #"game_ended" );
    level endon( #"boss_fight_started" );
    s_spawn_loc = utility::getstruct( "alchemy_" + aitype, "script_noteworthy" );
    spawn_origin = getclosestpointonnavmesh( s_spawn_loc.origin );
    cyst = level.alchemy_ee.cyst.sbl;
    is_player_nearby = 0;
    
    while ( !is_player_nearby )
    {
        foreach ( player in level.players )
        {
            if ( distance2dsquared( player.origin, s_spawn_loc.origin ) < 360000 )
            {
                is_player_nearby = 1;
            }
        }
        
        wait 1;
    }
    
    level notify( #"hash_429f9f61546fbfd0" );
    var_76ff015046c9aa1 = utility::spawn_model( "tag_origin", cyst.origin );
    waitframe();
    
    if ( utility::fxexists( #"hash_604cfaa80b608b89" ) )
    {
        playfx( utility::getfx( #"hash_604cfaa80b608b89" ), cyst.origin );
    }
    
    var_76ff015046c9aa1 utility::playsoundontag( #"hash_fcad7134d3223937", "tag_origin", 1 );
    var_76ff015046c9aa1 thread zm_quest::function_b8743f5a9219cf9b( cyst.origin, spawn_origin, #"hash_88f6d1ad054f367a", 0, undefined, 0, 5, undefined, undefined, 0 );
    var_76ff015046c9aa1 waittill( #"curve_done" );
    
    if ( utility::fxexists( #"hash_604cfaa80b608b89" ) )
    {
        playfxontag( utility::getfx( #"hash_929c5a896f6cb634" ), var_76ff015046c9aa1, "tag_origin" );
    }
    
    var_76ff015046c9aa1 delete();
    playsoundatpos( cyst.origin, #"hash_b7912c59774d638a" );
    playfx( level._effect[ "exfil_hvt_spawn_portal_vfx" ], spawn_origin );
    playsoundatpos( spawn_origin, #"hash_99e75f4c3fcc421c" );
    wait 2;
    zombie = agent_manager::spawn_agent( aitype, spawn_origin, s_spawn_loc.angles, "team_two_hundred" );
    
    if ( !zombie )
    {
        return;
    }
    
    if ( zombie )
    {
        zombie.no_powerups = 1;
        zombie val::set( "alchemy_ee", "ignore_cleanup", 1 );
        zombie.ignore_enemy_count = 1;
        zombie.b_cleanup_no_respawn = 1;
        zombie.var_825b17c932865df = 1;
        zombie.b_ignore_cleanup = 1;
        zombie.var_a13bed1ac47e1b2c = 1;
        zombie.var_7ee152b43c7188e1 = 1;
        zombie.disable_brain_rot = 1;
        var_49f7091014d2c59 = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( zombie.origin );
        zombie zombie_utils::set_zombie_round_difficulty( var_49f7091014d2c59 + 10 );
        
        switch ( aitype )
        {
            case #"hash_99a38be9e88b5244":
                zombie.health = int( zombie.maxhealth * 4 * var_eab9d49b6c271d50 );
                zombie.maxhealth = int( zombie.maxhealth * 4 * var_eab9d49b6c271d50 );
                break;
            case #"hash_e54f647382ba2db2":
                zombie.health = int( zombie.maxhealth * 32 * var_eab9d49b6c271d50 );
                zombie.maxhealth = int( zombie.maxhealth * 32 * var_eab9d49b6c271d50 );
                break;
            case #"hash_c1fa8721b046b258":
                zombie.health = int( zombie.maxhealth * 1 * var_eab9d49b6c271d50 );
                zombie.maxhealth = int( zombie.maxhealth * 1 * var_eab9d49b6c271d50 );
                break;
            case #"hash_818f3678466848ec":
                zombie.health = int( zombie.maxhealth * 1 * var_eab9d49b6c271d50 );
                zombie.maxhealth = int( zombie.maxhealth * 1 * var_eab9d49b6c271d50 );
                break;
        }
    }
    
    zombie thread function_5b55de462aaa6694();
    level.alchemy_ee.elite_zombie[ level.alchemy_ee.elite_zombie.size ] = zombie;
    return zombie;
}

// Namespace namespace_f56500c5c92c7217
// Params 2
// Checksum 0x78ad47c2, Offset: 0x2b0f
// Size: 0x245
function spawn_rewards( var_282f5d37962482d6, attacker_location )
{
    if ( distance2dsquared( var_282f5d37962482d6, attacker_location ) > 1000000 )
    {
        var_282f5d37962482d6 = attacker_location;
    }
    
    v_reward_location = getclosestpointonnavmesh( var_282f5d37962482d6 );
    itemorigin = v_reward_location + ( 0, 0, 60 );
    var_8b5270de14dff72e = undefined;
    reward_ref = undefined;
    
    switch ( level.alchemy_ee.spawn_aitype )
    {
        case #"hash_99a38be9e88b5244":
            reward_ref = "formula_1";
            break;
        case #"hash_e54f647382ba2db2":
            reward_ref = "formula_2";
            break;
        case #"hash_c1fa8721b046b258":
            reward_ref = "formula_3";
            break;
        case #"hash_818f3678466848ec":
            reward_ref = "formula_4";
            break;
        case #"hash_c482c6c109150a4":
            reward_ref = "formula_5";
            break;
    }
    
    params = spawnstruct();
    params.timestamp = gettime();
    params.questname = #"alchemy_ee";
    params.var_be82617e5e8087bd = level.players;
    params.event = #"hash_4e0c5e5e46ea8fef";
    level callback::callback( #"hash_6c71d319dc089c27", params );
    level callback::callback( #"hash_4e0c5e5e46ea8fef", params );
    
    foreach ( player in level.players )
    {
        player playsoundtoplayer( "evt_ee_complete_success_stinger", player );
    }
    
    var_8b5270de14dff72e = zm_round_reward_bundle::function_8cbad2bff5b7cc1( "zm_round_reward_bundle_alchemy_ee_rewards", reward_ref );
    
    for ( i = 0; i < var_8b5270de14dff72e.size ; i++ )
    {
        if ( var_8b5270de14dff72e[ i ] )
        {
            random_point = getrandomnavpoint( v_reward_location, 200 );
            common_item::function_47324f290423b2d1( var_8b5270de14dff72e[ i ], itemorigin, random_point, undefined, 1 );
            waitframe();
        }
    }
}

// Namespace namespace_f56500c5c92c7217
// Params 2, eflags: 0x4
// Checksum 0xc42c7ffe, Offset: 0x2d5c
// Size: 0x1c1
function private harvest_soul( harvested_agent, speed = 5 )
{
    level endon( #"boss_fight_started" );
    
    if ( level.alchemy_ee.required_souls <= 0 )
    {
        return;
    }
    
    soul_spawn_position = harvested_agent gettagorigin( "j_spineupper", 1 ) ?? harvested_agent.origin;
    var_76ff015046c9aa1 = utility::spawn_model( "tag_origin", soul_spawn_position );
    waitframe();
    
    if ( utility::fxexists( #"hash_604cfaa80b608b89" ) )
    {
        playfx( utility::getfx( #"hash_604cfaa80b608b89" ), soul_spawn_position );
    }
    
    var_76ff015046c9aa1 utility::playsoundontag( #"hash_fcad7134d3223937", "tag_origin", 1 );
    var_76ff015046c9aa1 thread zm_quest::function_b8743f5a9219cf9b( var_76ff015046c9aa1.origin, self.origin, #"hash_88f6d1ad054f367a", 0, undefined, 0, speed, undefined, undefined, 0 );
    var_76ff015046c9aa1 waittill( #"curve_done" );
    
    if ( utility::fxexists( #"hash_604cfaa80b608b89" ) )
    {
        playfxontag( utility::getfx( #"hash_929c5a896f6cb634" ), var_76ff015046c9aa1, "tag_origin" );
    }
    
    var_76ff015046c9aa1 delete();
    
    if ( isdefined( self.var_be660d5924a1eaaf ) && isdefined( self.var_8522d40367bee98b ) )
    {
        self setscriptablepartstate( self.var_be660d5924a1eaaf, self.var_8522d40367bee98b );
    }
    
    playsoundatpos( self.origin, #"hash_b7912c59774d638a" );
    level.alchemy_ee.required_souls--;
    
    if ( level.alchemy_ee.required_souls <= 0 )
    {
        destructible::destroy();
        wait 0.6;
        utility::flag_set( "harvest_soul_complete" );
    }
}

// Namespace namespace_f56500c5c92c7217
// Params 0, eflags: 0x4
// Checksum 0x84198906, Offset: 0x2f25
// Size: 0x9d6
function private watch_boss_fight_begin()
{
    level endon( #"game_ended" );
    
    while ( !utility::flag( "start_boss_fight" ) )
    {
        wait 1;
    }
    
    level notify( #"boss_fight_started" );
    
    foreach ( material in level.alchemy_ee.materials )
    {
        if ( material.mdl )
        {
            material.mdl hide();
        }
        
        if ( material.interact )
        {
            material.interact zm_quest::function_9170db4686f796e2();
        }
    }
    
    if ( level.alchemy_ee.bowl.mdl )
    {
        level.alchemy_ee.bowl.mdl hide();
    }
    
    level.alchemy_ee.bowl.interact zm_quest::function_9170db4686f796e2();
    
    if ( level.alchemy_ee.cyst.sbl )
    {
        level.alchemy_ee.cyst.sbl freescriptable();
    }
    
    level.alchemy_ee.cyst.interact zm_quest::function_9170db4686f796e2();
    
    foreach ( mdl in level.var_77247bfdb5c8dbd0 )
    {
        if ( mdl )
        {
            mdl hide();
        }
    }
    
    a_clips = getentarray( "alchemy_clip", #targetname );
    
    foreach ( clip in a_clips )
    {
        clip hide();
        clip connectpaths();
    }
    
    if ( level callback::exists( #"on_ai_killed", &function_8c5e06ee1e60aeb7 ) )
    {
        level callback::remove( #"on_ai_killed", &function_8c5e06ee1e60aeb7 );
        
        foreach ( zombie in level.var_b460f69918d4d908 )
        {
            if ( !zombie || !isalive( zombie ) )
            {
                continue;
            }
            
            zombie kill();
        }
        
        level.var_b460f69918d4d908 = [];
    }
    
    if ( level.alchemy_ee.elite_zombie )
    {
        foreach ( zombie in level.alchemy_ee.elite_zombie )
        {
            if ( !zombie || !isalive( zombie ) )
            {
                continue;
            }
            
            zombie kill();
        }
    }
    
    level.alchemy_ee.elite_zombie = [];
    
    while ( !utility::flag( "boss_fight_done" ) )
    {
        wait 1;
    }
    
    foreach ( material in level.alchemy_ee.materials )
    {
        if ( material.mdl )
        {
            material.mdl show();
        }
        
        if ( !material.interact )
        {
            material.interact = zm_quest::function_91f9590e98d57ff6( material.origin, &function_5ba6bd37d0d2a6ae, &function_29c58890dd0ff38c, "small" );
            material.interact.sound = "uin_zm_common_pickup_item_important";
            material.interact.parent = material;
        }
    }
    
    foreach ( mdl in level.var_77247bfdb5c8dbd0 )
    {
        if ( mdl )
        {
            mdl show();
        }
    }
    
    if ( level.alchemy_ee.bowl.mdl )
    {
        level.alchemy_ee.bowl.mdl show();
    }
    
    if ( level.alchemy_ee.cyst )
    {
        level.alchemy_ee.cyst.sbl = spawnscriptable( "sat_destructible_souleater_cyst_alchemy_ee", level.alchemy_ee.cyst.origin, level.alchemy_ee.cyst.angles );
    }
    
    a_clips = getentarray( "alchemy_clip", #targetname );
    
    foreach ( clip in a_clips )
    {
        clip show();
        clip disconnectpaths();
    }
    
    if ( level.var_52c6d92e2b1b482b <= 2 )
    {
        if ( !level.alchemy_ee.bowl.interact )
        {
            s_bowl_interact = utility::getstruct( "alchemy_bowl_interact", "script_noteworthy" );
            level.alchemy_ee.bowl.interact = zm_quest::function_91f9590e98d57ff6( s_bowl_interact.origin, &on_alchemy_bowl_interact, &alchemy_bowl_interact_hint, "small" );
            level.alchemy_ee.bowl.interact.parent = level.alchemy_ee.bowl;
        }
        
        if ( !level.alchemy_ee.cyst.interact )
        {
            level.alchemy_ee.cyst.interact = zm_quest::function_91f9590e98d57ff6( level.alchemy_ee.cyst.origin, &function_1850db5fff77be77, &loot_cyst_interact_hint, "small" );
            level.alchemy_ee.cyst.interact.parent = level.alchemy_ee.cyst;
        }
        
        return;
    }
    
    if ( level.var_52c6d92e2b1b482b == 3 )
    {
        level thread function_9464570ccdf080fd();
        
        if ( !level callback::exists( #"on_ai_killed", &function_8c5e06ee1e60aeb7 ) )
        {
            level callback::add( #"on_ai_killed", &function_8c5e06ee1e60aeb7 );
        }
        
        return;
    }
    
    if ( level.var_52c6d92e2b1b482b == 4 )
    {
        switch ( level.alchemy_ee.spawn_aitype )
        {
            case #"hash_818f3678466848ec":
            case #"hash_99a38be9e88b5244":
            case #"hash_c1fa8721b046b258":
            case #"hash_e54f647382ba2db2":
                level thread function_ca324608b1b53bec( level.alchemy_ee.spawn_aitype );
                break;
            case #"hash_c482c6c109150a4":
                level thread function_ca324608b1b53bec( "zombie_base_armored_heavy", 0.5 );
                level thread function_ca324608b1b53bec( "zombie_methone", 0.5 );
                level thread function_ca324608b1b53bec( "zombie_mimic_hvt", 0.5 );
                level thread function_ca324608b1b53bec( "zombie_ghoul_hvt", 0.5 );
                break;
        }
        
        level.alchemy_ee.cyst.sbl destructible::destroy();
        return;
    }
    
    if ( level.var_52c6d92e2b1b482b == 5 )
    {
        level.alchemy_ee.cyst.sbl destructible::destroy();
    }
}

/#

    // Namespace namespace_f56500c5c92c7217
    // Params 0
    // Checksum 0xbea4bb31, Offset: 0x3903
    // Size: 0x73, Type: dev
    function draw_sphere()
    {
        self notify( #"hash_4cf61e728d7b288a" );
        self endon( #"hash_4cf61e728d7b288a" );
        level endon( #"game_ended" );
        self endon( #"death" );
        
        while ( true )
        {
            sphere( self.origin, 10, ( 1, 0, 0 ), 0 );
            print3d( self.origin, self.var_21ea2a5f47371b4b );
            waitframe();
        }
    }

    // Namespace namespace_f56500c5c92c7217
    // Params 0, eflags: 0x4
    // Checksum 0xe364d0ed, Offset: 0x397e
    // Size: 0x156, Type: dev
    function private setup_alchemy_ee_devgui()
    {
        level utility::flag_wait( "<dev string:x62>" );
        waitframe();
        root = "<dev string:x77>";
        devgui::function_9082edeb5db93280( root );
        devgui::add_devgui_func( "<dev string:x93>", "<dev string:x9c>", &debug_vo );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( root + "<dev string:xa5>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:xb3>", "<dev string:xce>" + "<dev string:xe3>", &function_e8036314a4626c30 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xfd>", "<dev string:xce>" + "<dev string:x118>", &function_e8036314a4626c30 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x127>", "<dev string:xce>" + "<dev string:x14a>", &function_e8036314a4626c30 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x15b>", "<dev string:xce>" + "<dev string:x178>", &function_e8036314a4626c30 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( root + "<dev string:x189>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x199>", "<dev string:x1b0>" + "<dev string:x1c1>", &function_8b2df3fc0874ed12 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1cb>", "<dev string:x1b0>" + "<dev string:x1e2>", &function_8b2df3fc0874ed12 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1ec>", "<dev string:x1b0>" + "<dev string:x20b>", &function_8b2df3fc0874ed12 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x215>", "<dev string:x1b0>" + "<dev string:x22e>", &function_8b2df3fc0874ed12 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_f56500c5c92c7217
    // Params 0
    // Checksum 0xbd240523, Offset: 0x3adc
    // Size: 0x57, Type: dev
    function debug_vo()
    {
        player = level.players[ 0 ];
        
        if ( player namespace_c0b4f2882c9d100f::is_hero_operator() )
        {
            player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"alchemy_ee_end" );
            return;
        }
        
        level thread battlechatter_mp::trysaylocalsound( player, #"bc_flavor_player_negative", undefined, undefined, undefined, undefined, undefined, undefined, 1 );
    }

    // Namespace namespace_f56500c5c92c7217
    // Params 1
    // Checksum 0xc6c8aa47, Offset: 0x3b3b
    // Size: 0x27, Type: dev
    function function_e8036314a4626c30( params )
    {
        var_ff75798b22968d50 = params[ 0 ];
        function_ca324608b1b53bec( var_ff75798b22968d50 );
    }

    // Namespace namespace_f56500c5c92c7217
    // Params 1
    // Checksum 0x5b5cca41, Offset: 0x3b6a
    // Size: 0x33, Type: dev
    function function_8b2df3fc0874ed12( params )
    {
        str_formula = params[ 0 ];
        level.var_9d8bab492621b48 = level.alchemy_formula[ str_formula ];
    }

#/
