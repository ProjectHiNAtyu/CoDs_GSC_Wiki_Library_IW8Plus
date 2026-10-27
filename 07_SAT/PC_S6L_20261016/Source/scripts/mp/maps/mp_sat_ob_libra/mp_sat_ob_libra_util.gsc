// scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_util.gsc  (hash_6cb474d53fa1382c.gscc) (size: 44959 Bytes / 0xaf9f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x16a92e4c (380186188)
// size ...... 44959 (0xaf9f)
// includes .. 21  (offset: 0xa423)
// strings ... 194 (offset: 0xa4cb)
// dev strs .. 5   (offset: 0xaf63)
// exports ... 102 (offset: 0x744f)
// cseg ...... 0x1128 + 0x6327 (0x744f)
// imports ... 249 (offset: 0x843f)
// animtree1 . 0   (offset: 0xaf9f)
// animtree2 . 0   (offset: 0xaf9f)
#using script_636bd827a012af12;
#using script_66878054d141dbc0;
#using scripts\common\ai;
#using scripts\common\ai\ai_utility;
#using scripts\common\hints;
#using scripts\common\scene;
#using scripts\common\scriptable;
#using scripts\common\snd\snd;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\waypoint_objective_handler;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\scriptable_door_utility;
#using scripts\mp\damagefeedback;
#using scripts\mp\gameobjects;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\ob\systems\ob_flying_drone;

#namespace mp_sat_ob_libra_util;

// Namespace mp_sat_ob_libra_util
// Params 7
// Checksum 0x104f502f, Offset: 0x1146
// Size: 0x17a
function function_c58a10af89e58f3f( t_name, flag_name, var_81916649a7b1af22 = &"sat_ob_story_missions/interact_activate", radius = 64, displayrange = 128, displayfov = 360, usefov = 45 )
{
    button = utility::getstruct( t_name, "targetname" );
    button.interact = interaction::register_interact( button.origin, radius, &button_interact, var_81916649a7b1af22, undefined, undefined, undefined, "HINT_BUTTON" );
    button.interact.flag_name = flag_name;
    button.interact.obj_root = self;
    button.interact sethintdisplayrange( displayrange );
    button.interact sethintdisplayfov( displayfov );
    button.interact setusefov( usefov );
    
    if ( isdefined( button.target ) )
    {
        var_ed92d3edd3eded9 = utility::getstruct( button.target );
        
        if ( isdefined( var_ed92d3edd3eded9 ) && isdefined( var_ed92d3edd3eded9.script_scenescriptbundle ) )
        {
            button.interact.scene_struct = var_ed92d3edd3eded9;
        }
    }
}

// Namespace mp_sat_ob_libra_util
// Params 7
// Checksum 0x73f0e37e, Offset: 0x12c8
// Size: 0xe9
function function_d0cffe518d66927f( ent, flag_name, var_81916649a7b1af22 = &"sat_ob_story_missions/interact_activate", radius = 64, displayrange = 128, displayfov = 360, usefov = 45 )
{
    ent.interact = interaction::register_interact( ent, radius, &button_interact, var_81916649a7b1af22, undefined, undefined, undefined, "HINT_BUTTON" );
    ent.interact.flag_name = flag_name;
    ent.interact sethintdisplayrange( displayrange );
    ent.interact sethintdisplayfov( displayfov );
    ent.interact setusefov( usefov );
}

// Namespace mp_sat_ob_libra_util
// Params 1
// Checksum 0xfd9e48d3, Offset: 0x13b9
// Size: 0x98
function button_interact( player )
{
    if ( self.in_use )
    {
        return;
    }
    
    self.in_use = 1;
    
    if ( isdefined( self.obj_root ) )
    {
        self.obj_root ob_story_mission_utils::objective_marker_clear( self.var_8029d4363972e15 );
    }
    
    self makeunusable();
    level.pullforward_initiator = player;
    
    if ( isdefined( self.scene_struct ) )
    {
        function_b570488e88a69d60( player );
    }
    
    if ( isdefined( self.flag_name ) )
    {
        utility::flag_set( self.flag_name );
    }
    
    self.in_use = undefined;
}

// Namespace mp_sat_ob_libra_util
// Params 1
// Checksum 0xb64b30e4, Offset: 0x1459
// Size: 0x95
function function_b570488e88a69d60( player )
{
    player endon( #"death_or_disconnect" );
    self.scene_struct thread scene::play( player );
    
    switch ( self.scene_struct.script_scenescriptbundle )
    {
        case #"hash_4c94b0d0ee1eef00":
            delay = 0.9;
            break;
        case #"hash_d7d059c5445b24a0":
            delay = 1.2;
            break;
        default:
            delay = 1;
            break;
    }
    
    wait delay;
}

// Namespace mp_sat_ob_libra_util
// Params 2
// Checksum 0x49e7a275, Offset: 0x14f6
// Size: 0x52
function function_666afe336bbc23e3( triggername, key = #targetname )
{
    if ( isdefined( triggername ) )
    {
        triggers = getentarray( triggername, key );
        
        if ( isdefined( triggers ) )
        {
            utility::array_thread( triggers, &function_845c4d518e09f661 );
        }
    }
}

// Namespace mp_sat_ob_libra_util
// Params 2
// Checksum 0x158d328d, Offset: 0x1550
// Size: 0x50
function function_7beb2eae4a2ffc52( structname, key = "targetname" )
{
    if ( isdefined( structname ) )
    {
        structs = utility::getstructarray( structname, key );
        
        if ( isdefined( structs ) )
        {
            utility::array_thread( structs, &function_845c4d518e09f661 );
        }
    }
}

// Namespace mp_sat_ob_libra_util
// Params 0
// Checksum 0x62fa1feb, Offset: 0x15a8
// Size: 0x31f
function function_845c4d518e09f661()
{
    level endon( #"hash_866273063a45342c" );
    
    if ( isent( self ) )
    {
        self endon( #"death" );
        var_ed92d3edd3eded9 = utility::getstruct( self.target );
        skip_trigger = 0;
    }
    else
    {
        var_ed92d3edd3eded9 = self;
        skip_trigger = 1;
    }
    
    while ( true )
    {
        if ( isdefined( var_ed92d3edd3eded9 ) )
        {
            if ( skip_trigger )
            {
                wait randomfloatrange( var_ed92d3edd3eded9.script_wait_min, var_ed92d3edd3eded9.script_wait_max );
            }
            else
            {
                self waittill( #"trigger" );
            }
            
            if ( isdefined( var_ed92d3edd3eded9.script_soundalias ) )
            {
                playsoundatpos( var_ed92d3edd3eded9.origin, var_ed92d3edd3eded9.script_soundalias );
            }
            
            if ( isdefined( var_ed92d3edd3eded9.script_fxid ) )
            {
                utility::exploder( var_ed92d3edd3eded9.script_fxid );
            }
            
            if ( isdefined( var_ed92d3edd3eded9.script_rumble ) )
            {
                playrumbleonposition( var_ed92d3edd3eded9.script_rumble, var_ed92d3edd3eded9.origin );
            }
            
            if ( isdefined( var_ed92d3edd3eded9.script_parameters ) )
            {
                switch ( var_ed92d3edd3eded9.script_parameters )
                {
                    case #"hash_5971965ed985a26c":
                        level thread function_18fee449c48ecd39( var_ed92d3edd3eded9.origin );
                        break;
                    case #"hash_c71b112fe04823d6":
                        level thread function_df1651443c034889( var_ed92d3edd3eded9.origin );
                        break;
                    case #"hash_4bf33d595d8f4894":
                        level thread function_f81852ae0f4c0835( var_ed92d3edd3eded9.origin );
                        break;
                    default:
                        break;
                }
            }
            
            var_e67d2b409143afde = utility::getstructarray( var_ed92d3edd3eded9.target, "targetname" );
            
            if ( isdefined( var_e67d2b409143afde ) )
            {
                foreach ( struct in var_e67d2b409143afde )
                {
                    if ( struct.script_noteworthy == "do_damage" )
                    {
                        if ( isdefined( struct.radius ) )
                        {
                            radius = struct.radius;
                        }
                        else
                        {
                            radius = 32;
                        }
                        
                        struct thread trigger_damage( radius );
                    }
                }
            }
            
            scriptables = getentitylessscriptablearray( var_ed92d3edd3eded9.target, #targetname );
            
            if ( isdefined( scriptables ) )
            {
                foreach ( scriptable in scriptables )
                {
                    scriptable thread function_6c497742d1e669ac();
                }
            }
            
            if ( var_ed92d3edd3eded9.script_looping )
            {
                continue;
            }
            
            return;
        }
    }
}

// Namespace mp_sat_ob_libra_util
// Params 1
// Checksum 0xea465a42, Offset: 0x18cf
// Size: 0xad
function trigger_damage( radius )
{
    radiusdamage( self.origin, radius, self.script_damage, self.script_damage / 2, undefined, undefined, undefined, 1, 0 );
    function_df0d7efb44b35968( self.origin, radius, radius * 0.8, ( 20, 20, 20 ) );
    waitframe();
    radiusdamage( self.origin, radius, self.script_damage, self.script_damage / 2, undefined, undefined, undefined, 1, 0 );
    function_df0d7efb44b35968( self.origin, radius, radius * 0.8, ( 20, 20, 20 ) );
}

// Namespace mp_sat_ob_libra_util
// Params 0
// Checksum 0xb595cbd2, Offset: 0x1984
// Size: 0xb1
function function_6c497742d1e669ac()
{
    scriptable = self;
    level utility::flag_wait( "scriptables_ready" );
    
    if ( isdefined( scriptable.script_delay ) )
    {
        wait scriptable.script_delay;
    }
    
    if ( isdefined( scriptable.script_state ) )
    {
        tokens = strtok( scriptable.script_state, " " );
        
        if ( isdefined( tokens[ 1 ] ) )
        {
            if ( scriptable getscriptableparthasstate( tokens[ 0 ], tokens[ 1 ] ) )
            {
                scriptable setscriptablepartstate( tokens[ 0 ], tokens[ 1 ] );
            }
        }
        
        return;
    }
    
    if ( scriptable getscriptableparthasstate( "main", "destr" ) )
    {
        scriptable setscriptablepartstate( "main", "destr" );
    }
}

// Namespace mp_sat_ob_libra_util
// Params 8
// Checksum 0xbb7f1a84, Offset: 0x1a3d
// Size: 0xa9
function libra_shake( position, duration = 1, scalemax = 0.35, scalemid = 0.15, scalemin = 0.05, radiusmax = 800, radiusmid = 2500, radiusmin = 10000 )
{
    earthquakeadvanced( scalemax, scalemid, scalemin, duration, position, radiusmax, radiusmid, radiusmin );
}

// Namespace mp_sat_ob_libra_util
// Params 1
// Checksum 0xa9200799, Offset: 0x1aee
// Size: 0xc1
function function_18fee449c48ecd39( origin )
{
    shakeduration = 0.0375;
    var_39bbe706cd34d2ec = 0.0125;
    var_39deeb06cd5b2370 = 0.0075;
    var_39def506cd5b396e = 0.004;
    radiusscalemax = 10;
    radiusscalemid = 20;
    radiusscalemin = 30;
    libra_shake( origin, shakeduration, var_39bbe706cd34d2ec, var_39deeb06cd5b2370, var_39def506cd5b396e, radiusscalemax, radiusscalemid, radiusscalemin );
    
    if ( !level.var_49dba571eb2cc910 )
    {
        snd::play( "amb_evt_screen_shake_sml", origin );
        return;
    }
    
    if ( level.var_49dba571eb2cc910 )
    {
        snd::play( "amb_evt_screen_shake_sml_cradled", origin );
    }
}

// Namespace mp_sat_ob_libra_util
// Params 1
// Checksum 0xf663be8a, Offset: 0x1bb7
// Size: 0xac
function function_df1651443c034889( origin )
{
    shakeduration = 0.75;
    var_39bbe706cd34d2ec = 0.25;
    var_39deeb06cd5b2370 = 0.15;
    var_39def506cd5b396e = 0.08;
    radiusscalemax = 200;
    radiusscalemid = 400;
    radiusscalemin = 600;
    libra_shake( origin, shakeduration, var_39bbe706cd34d2ec, var_39deeb06cd5b2370, var_39def506cd5b396e, radiusscalemax, radiusscalemid, radiusscalemin );
    
    if ( !level.var_49dba571eb2cc910 )
    {
        snd::play( "amb_evt_screen_shake_sml", origin );
        return;
    }
    
    if ( level.var_49dba571eb2cc910 )
    {
    }
}

// Namespace mp_sat_ob_libra_util
// Params 1
// Checksum 0xa073a29a, Offset: 0x1c6b
// Size: 0xc1
function function_f81852ae0f4c0835( origin )
{
    shakeduration = 1.125;
    var_39bbe706cd34d2ec = 0.375;
    var_39deeb06cd5b2370 = 0.225;
    var_39def506cd5b396e = 0.12;
    radiusscalemax = 300;
    radiusscalemid = 600;
    radiusscalemin = 900;
    libra_shake( origin, shakeduration, var_39bbe706cd34d2ec, var_39deeb06cd5b2370, var_39def506cd5b396e, radiusscalemax, radiusscalemid, radiusscalemin );
    
    if ( !level.var_49dba571eb2cc910 )
    {
        snd::play( "amb_evt_screen_shake_lrg", origin );
        return;
    }
    
    if ( level.var_49dba571eb2cc910 )
    {
        snd::play( "amb_evt_screen_shake_lrg_cradled", origin );
    }
}

// Namespace mp_sat_ob_libra_util
// Params 1
// Checksum 0x59fc2b0e, Offset: 0x1d34
// Size: 0x73
function function_d2bb8bdd5246e2ca( ender )
{
    level endon( ender );
    wait 6;
    
    while ( true )
    {
        duration = randomfloatrange( 0.1, 0.5 );
        delay = randomfloatrange( 4, 6 );
        level thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "light", duration, undefined, level.players, undefined, undefined, 1 );
        wait delay + duration;
    }
}

// Namespace mp_sat_ob_libra_util
// Params 1
// Checksum 0xe97bd0b0, Offset: 0x1daf
// Size: 0x76
function start_interact_scene( scene_targetname )
{
    self endon( #"death_or_disconnect" );
    self endon( #"last_stand_enter" );
    self endon( #"hash_180ed222c486806b" );
    player = self;
    scene_struct = utility::getstruct( scene_targetname );
    scene_struct scene::play( player, "enter" );
    
    if ( isalive( player ) )
    {
        scene_struct thread scene::play( player, "idle" );
    }
}

// Namespace mp_sat_ob_libra_util
// Params 1
// Checksum 0x43a0f59d, Offset: 0x1e2d
// Size: 0xb1
function function_d68eec31414afe2e( scene_targetname )
{
    player = self;
    self notify( #"hash_180ed222c486806b" );
    self endon( #"death_or_disconnect" );
    self endon( #"last_stand_enter" );
    scene_struct = utility::getstruct( scene_targetname );
    scene_struct scene::stop();
    
    if ( player::isinlaststand( player ) )
    {
        return;
    }
    
    scene_struct scene::play( player, "exit" );
    
    if ( isalive( player ) && player getcurrentweapon() == level.weaponnone && player.lastnormalweaponobj )
    {
        player switchtoweapon( player.lastnormalweaponobj );
    }
}

// Namespace mp_sat_ob_libra_util
// Params 0
// Checksum 0x5390d004, Offset: 0x1ee6
// Size: 0x34
function function_8f97ea6ececa5d()
{
    level.var_eb1cb96d31019392 = init_model_pos( "hatch_door_a", "hatch_door_a_open_pos" );
    level.var_eb1cb96d31019392 = init_model_pos( "hatch_door_b", "hatch_door_b_open_pos" );
}

// Namespace mp_sat_ob_libra_util
// Params 2
// Checksum 0xa4dfae01, Offset: 0x1f22
// Size: 0x81
function init_model_pos( model_targetname, struct_targetname )
{
    the_model = getent( model_targetname, "targetname" );
    
    if ( !isdefined( the_model.original_origin ) )
    {
        the_model.original_origin = the_model.origin;
    }
    
    init_pos = utility::getstruct( struct_targetname, "targetname" );
    the_model.origin = init_pos.origin;
    return the_model;
}

/#

    // Namespace mp_sat_ob_libra_util
    // Params 0
    // Checksum 0x798fab5c, Offset: 0x1fac
    // Size: 0x5, Type: dev
    function function_a99d13af2370eddb()
    {
        
    }

#/

// Namespace mp_sat_ob_libra_util
// Params 2
// Checksum 0x58aebe2d, Offset: 0x1fb9
// Size: 0x3c7
function item_spawn_weapon( struct_targetname, var_b60496d5b429ae0f )
{
    if ( !isdefined( level.loot_drop_script_throttle ) )
    {
        level.loot_drop_script_throttle = throttle::throttle_initialize( "loot_drop_script", 1, level.framedurationseconds );
    }
    
    a_s_weapon = utility::getstructarray( struct_targetname, "targetname" );
    
    if ( a_s_weapon.size == 0 )
    {
        return;
    }
    
    foreach ( var_fe68cd50dcda7fdc in a_s_weapon )
    {
        spawned_wpn = undefined;
        throttle::throttle_wait_in_queue( level.loot_drop_script_throttle, var_fe68cd50dcda7fdc );
        wpn_spawn_options = common_item::function_bc5ff2958b71a708( var_fe68cd50dcda7fdc.origin, var_fe68cd50dcda7fdc.angles - ( 0, 90, 0 ) );
        wpn_spawn_options.var_90cdc5dbcd319e5d = 1;
        wpn_spawn_options.var_fd47e835523b473f = 1;
        wpn_spawn_options.var_8d4f327170228364 = 1;
        wpn_spawn_options.dropradiusscale = 0;
        wpn_spawn_options.var_23d3495c57d61bdf = 1;
        var_5b97ae4b727ee516 = strtok( var_fe68cd50dcda7fdc.script_noteworthy, "," );
        
        if ( isstartstr( var_5b97ae4b727ee516[ 0 ], "zm_" ) || isstartstr( var_5b97ae4b727ee516[ 0 ], "ob_" ) )
        {
            wpn_bundle = undefined;
            wpn_specific = var_5b97ae4b727ee516[ 0 ];
            
            if ( isdefined( var_5b97ae4b727ee516[ 1 ] ) )
            {
                wpn_rarity = var_5b97ae4b727ee516[ 1 ];
                
                if ( isdefined( var_5b97ae4b727ee516[ 2 ] ) && utility::cointoss() )
                {
                    wpn_rarity = var_5b97ae4b727ee516[ 2 ];
                }
                
                wpn_specific = var_5b97ae4b727ee516[ 0 ] + "_" + wpn_rarity;
            }
            
            wpn_bundle = getscriptbundle( "itemspawnentry:" + wpn_specific );
            
            if ( isdefined( wpn_bundle ) )
            {
                spawned_wpn = item_weapon::function_b960bc85ea91de14( wpn_bundle, wpn_spawn_options );
            }
        }
        else
        {
            switch ( var_5b97ae4b727ee516[ 0 ] )
            {
                case #"hash_98dcd2e7e7e3c632":
                case #"hash_fa18d2f6bd57925a":
                    wpn_list = "ob_sat_items_weapons_ar_";
                    break;
                case #"hash_589e620d9c37ef93":
                case #"hash_fa0ed9f6bd4f4e9a":
                    wpn_list = "ob_sat_items_weapons_dm_";
                    break;
                case #"hash_ba39cac9c099d4f1":
                case #"hash_fa27bdf6bd62aa3e":
                    wpn_list = "ob_sat_items_weapons_la_";
                    break;
                case #"hash_2f2d546c2247838f":
                case #"hash_bb3bd3f7cd7a8a5c":
                case #"hash_fa27b9f6bd62a3f2":
                    wpn_list = "ob_sat_items_weapons_lm_";
                    break;
                case #"hash_40a94c5d9e4e265b":
                case #"hash_fa24ddf6bd609e07":
                    wpn_list = "ob_sat_items_weapons_me_";
                    break;
                case #"hash_719417cb1de832b6":
                case #"hash_fa4dbdf6bd80bf52":
                    wpn_list = "ob_sat_items_weapons_pi_";
                    break;
                case #"hash_23209741b93850b5":
                case #"hash_fa50b4f6bd82efbe":
                    wpn_list = "ob_sat_items_weapons_sh_";
                    break;
                case #"hash_900cb96c552c5e8e":
                case #"hash_fa50b9f6bd82f79d":
                    wpn_list = "ob_sat_items_weapons_sm_";
                    break;
                case #"hash_6191aaef9f922f96":
                case #"hash_fa50b6f6bd82f2e4":
                    wpn_list = "ob_sat_items_weapons_sn_";
                    break;
                default:
                    wpn_list = "ob_sat_items_weapons_";
                    break;
            }
            
            wpn_rarity = "base";
            
            if ( isdefined( var_5b97ae4b727ee516[ 1 ] ) )
            {
                wpn_rarity = var_5b97ae4b727ee516[ 1 ];
                
                if ( isdefined( var_5b97ae4b727ee516[ 2 ] ) && utility::cointoss() )
                {
                    wpn_rarity = var_5b97ae4b727ee516[ 2 ];
                }
            }
            
            spawned_wpn = common_item::function_38cde6a6acb68ea6( wpn_list + wpn_rarity, 1, wpn_spawn_options );
        }
        
        if ( isdefined( spawned_wpn ) )
        {
            thread item_cleanup( spawned_wpn, var_b60496d5b429ae0f );
        }
        
        waitframe();
    }
}

// Namespace mp_sat_ob_libra_util
// Params 2
// Checksum 0x75cdb484, Offset: 0x2388
// Size: 0x3ce
function item_spawn_equipment( struct_targetname, var_b60496d5b429ae0f )
{
    if ( !isdefined( level.loot_drop_script_throttle ) )
    {
        level.loot_drop_script_throttle = throttle::throttle_initialize( "loot_drop_script", 1, level.framedurationseconds );
    }
    
    a_s_equipment = utility::getstructarray( struct_targetname, "targetname" );
    
    if ( a_s_equipment.size == 0 )
    {
        return;
    }
    
    foreach ( s_equipment in a_s_equipment )
    {
        throttle::throttle_wait_in_queue( level.loot_drop_script_throttle, s_equipment );
        equip_spawn_options = common_item::function_bc5ff2958b71a708( s_equipment.origin, s_equipment.angles );
        equip_spawn_options.var_90cdc5dbcd319e5d = 1;
        equip_spawn_options.var_fd47e835523b473f = 1;
        
        if ( isdefined( s_equipment.script_count ) || isdefined( s_equipment.script_count_min ) || isdefined( s_equipment.script_count_max ) )
        {
            if ( isdefined( s_equipment.script_count_max ) )
            {
                equip_min = 0;
                
                if ( isdefined( s_equipment.script_count_min ) )
                {
                    equip_min = s_equipment.script_count_min;
                }
                
                var_20cb062e6c21e1ee = randomintrange( equip_min, s_equipment.script_count_max + 1 );
            }
            else if ( isdefined( s_equipment.script_count ) || isdefined( s_equipment.script_count_min ) )
            {
                var_20cb062e6c21e1ee = s_equipment.script_count;
            }
            
            if ( var_20cb062e6c21e1ee == 0 )
            {
                waitframe();
                continue;
            }
            else if ( var_20cb062e6c21e1ee > 1 )
            {
                if ( isdefined( s_equipment.radius ) )
                {
                    equip_spawn_options.dropradiusscale = s_equipment.radius / 64;
                }
                else
                {
                    equip_spawn_options.dropradiusscale = 1;
                }
            }
            else
            {
                equip_spawn_options.dropradiusscale = 0;
            }
        }
        else
        {
            equip_spawn_options.var_8d4f327170228364 = 1;
            equip_spawn_options.dropradiusscale = 0;
            equip_spawn_options.var_23d3495c57d61bdf = 1;
            var_20cb062e6c21e1ee = 1;
        }
        
        equip_type = s_equipment.script_noteworthy;
        
        if ( isstartstr( equip_type, "zm_" ) || isstartstr( equip_type, "ob_" ) )
        {
            equip_bundle = undefined;
            equip_bundle = getscriptbundle( "itemspawnentry:" + equip_type );
            
            if ( isdefined( equip_bundle ) )
            {
                spawned_equip = common_item::function_61c2c0251e742ffd( equip_bundle, var_20cb062e6c21e1ee, equip_spawn_options );
            }
        }
        else
        {
            switch ( equip_type )
            {
                case #"hash_339227cb650975db":
                    equip_list = "ob_sat_items_lethals";
                    break;
                case #"hash_850999d7864fa3b4":
                    equip_list = "ob_sat_items_tacticals";
                    break;
                case #"hash_293629fa55ab7dd3":
                    equip_list = "ob_sat_items_zm_lethals";
                    break;
                case #"hash_4d1dbaaa0bfd6c7c":
                    equip_list = "ob_sat_items_zm_tacticals";
                    break;
                case #"hash_ed740cdc7ab43d5":
                    equip_list = "ob_sat_items_field_upgrades";
                    break;
                default:
                    equip_list = "ob_sat_items_equipment_sm";
                    break;
            }
            
            spawned_equip = common_item::function_38cde6a6acb68ea6( equip_list, 1, equip_spawn_options );
            
            if ( var_20cb062e6c21e1ee > 1 )
            {
                equip_bundle = undefined;
                equip_bundle = common_item::function_6b8ff3d5f2688336( spawned_equip[ 0 ] );
                
                if ( isdefined( equip_bundle ) )
                {
                    for ( i = 0; i < var_20cb062e6c21e1ee - 1 ; i++ )
                    {
                        add_equip = common_item::function_61c2c0251e742ffd( equip_bundle, var_20cb062e6c21e1ee, equip_spawn_options );
                        spawned_equip[ spawned_equip.size ] = add_equip;
                    }
                }
            }
        }
        
        if ( isdefined( spawned_equip ) )
        {
            thread item_cleanup( spawned_equip, var_b60496d5b429ae0f );
        }
        
        waitframe();
    }
}

// Namespace mp_sat_ob_libra_util
// Params 2
// Checksum 0xf499e035, Offset: 0x275e
// Size: 0xe4
function item_cleanup( item, var_b60496d5b429ae0f )
{
    utility::waittill_any( "activity_ended", "instance_destroyed" );
    
    if ( isdefined( var_b60496d5b429ae0f ) )
    {
        level utility::flag_wait( var_b60496d5b429ae0f );
    }
    
    if ( !isarray( item ) )
    {
        var_f0110ccab3f4a8a6 = [ item ];
    }
    else
    {
        var_f0110ccab3f4a8a6 = item;
    }
    
    foreach ( item in var_f0110ccab3f4a8a6 )
    {
        if ( isdefined( item ) )
        {
            item.cleanupdisabled = 0;
            item.var_fd47e835523b473f = 0;
            item thread common_item::items_scriptable_waitandcleanup( 90 );
        }
    }
}

// Namespace mp_sat_ob_libra_util
// Params 0
// Checksum 0x8ee0df22, Offset: 0x284a
// Size: 0x158
function function_e3164f9f3de54eaa()
{
    doortriggers = getentarray( "door_trigger", "targetname" );
    
    if ( isdefined( doortriggers ) )
    {
        foreach ( trigger in doortriggers )
        {
            if ( trigger.script_parameters == "force_locked_no_open" )
            {
                trigger thread scriptable_door_utility::simple_lock_door();
                continue;
            }
            
            structs = utility::getstructarray( trigger.target, "targetname" );
            
            foreach ( struct in structs )
            {
                if ( struct.script_noteworthy == "console_unlock" )
                {
                    thread handle_console_unlock( trigger, struct );
                    break;
                }
            }
        }
        
        thread function_b561ec29665b6138();
    }
}

// Namespace mp_sat_ob_libra_util
// Params 2
// Checksum 0xf90e1f3f, Offset: 0x29aa
// Size: 0xc6
function handle_console_unlock( trigger, unlockstruct )
{
    trigger endon( #"death" );
    
    if ( isdefined( unlockstruct.script_flag_wait ) )
    {
        trigger thread scriptable_door_utility::simple_lock_door();
        level utility::flag_wait( unlockstruct.script_flag_wait );
    }
    
    prompt = gameobjects::createhintobject( unlockstruct.origin, "HINT_BUTTON", undefined, &"sat_ob_story_missions/interact_unlock" );
    prompt waittill( #"trigger" );
    
    if ( isdefined( unlockstruct.script_flag_set ) )
    {
        level utility::flag_set( unlockstruct.script_flag_set );
    }
    
    trigger scriptable_door_utility::simple_unlock_door();
    trigger notify( #"door_opened" );
    prompt delete();
}

/#

    // Namespace mp_sat_ob_libra_util
    // Params 0
    // Checksum 0x8790c1df, Offset: 0x2a78
    // Size: 0xa0, Type: dev
    function function_610b0007a345a42a()
    {
        if ( isdefined( self.script_noteworthy ) )
        {
            doorlist = getentitylessscriptablearray( self.target, "<dev string:x24>", undefined, undefined, "<dev string:x2f>" );
            
            if ( doorlist.size > 0 )
            {
                org = doorlist[ 0 ].origin + ( 0, 0, 110 );
                out = self.script_noteworthy;
                
                while ( true )
                {
                    print3d( org, out, ( 0, 1, 0 ), 1, 0.5, 1, 1 );
                    waitframe();
                }
            }
        }
    }

#/

// Namespace mp_sat_ob_libra_util
// Params 0
// Checksum 0x6839f6de, Offset: 0x2b20
// Size: 0x6d
function function_b561ec29665b6138()
{
    trigger = getent( "Unlocked. Scripted open / close", "script_noteworthy" );
    
    if ( trigger )
    {
        trigger endon( #"death_or_disconnect" );
        
        while ( true )
        {
            wait randomfloatrange( 0.1, 3.5 );
            trigger scriptable_door_utility::function_ebbc2714ba8e6bd9( "opening" );
            wait randomfloatrange( 0.1, 3 );
            trigger scriptable_door_utility::function_ebbc2714ba8e6bd9( "closing" );
        }
    }
}

// Namespace mp_sat_ob_libra_util
// Params 4
// Checksum 0xf9a71579, Offset: 0x2b95
// Size: 0x10e
function function_3404036aa1432445( script_noteworthy, close = 0, var_906b3a060fa55014 = 1, var_c2430dc7e4227985 = 0 )
{
    level utility::flag_wait( "scriptables_ready" );
    trigs = getentarray( script_noteworthy, "script_noteworthy" );
    
    foreach ( trig in trigs )
    {
        if ( close )
        {
            trig scriptable_door_utility::function_ebbc2714ba8e6bd9( "closing" );
            
            if ( var_c2430dc7e4227985 )
            {
                wait 1;
                trig scriptable_door_utility::simple_lock_door();
            }
            
            continue;
        }
        
        if ( var_906b3a060fa55014 )
        {
            trig scriptable_door_utility::simple_unlock_door();
        }
        
        trig scriptable_door_utility::function_ebbc2714ba8e6bd9( "opening" );
    }
}

// Namespace mp_sat_ob_libra_util
// Params 3
// Checksum 0x9b2fe3c1, Offset: 0x2cab
// Size: 0x85
function lerpvalue( var_a61491b0a32e905f, endvalue, duration )
{
    starttime = gettime();
    endtime = starttime + duration;
    
    while ( gettime() < endtime )
    {
        currenttime = gettime();
        t = ( currenttime - starttime ) / duration;
        currentvalue = var_a61491b0a32e905f + t * ( endvalue - var_a61491b0a32e905f );
        wait 0.05;
    }
    
    currentvalue = endvalue;
}

// Namespace mp_sat_ob_libra_util
// Params 3
// Checksum 0x41dbc43d, Offset: 0x2d38
// Size: 0x15f
function function_96910d9608e728ce( triggername, var_d271dc2d13288dc, var_c810450e0af7b948 )
{
    level utility::flag_wait( "scriptables_ready" );
    trigger = getent( triggername, var_d271dc2d13288dc );
    
    if ( isdefined( trigger ) )
    {
        doorlist = getentitylessscriptablearray( trigger.target, "targetname", undefined, undefined, "door" );
        
        if ( isdefined( doorlist ) )
        {
            if ( var_c810450e0af7b948 )
            {
                foreach ( door in doorlist )
                {
                    door setscriptablepartstate( "door", "hidden" );
                }
                
                return;
            }
            
            foreach ( door in doorlist )
            {
                door setscriptablepartstate( "door", "static" );
            }
        }
    }
}

// Namespace mp_sat_ob_libra_util
// Params 9
// Checksum 0x75807f5f, Offset: 0x2e9f
// Size: 0x95
function function_4f33c858a708f9d4( tname, var_e061405aa325b731, var_e084525aa34c267f, min_rotation_time, max_rotation_time, key = #targetname, ender, novfx, var_b9988984b5068f56 )
{
    vista_spheres = getentarray( tname, key );
    
    if ( isdefined( vista_spheres ) )
    {
        utility::array_thread( vista_spheres, &vista_sphere_behavior, ender, var_e061405aa325b731, var_e084525aa34c267f, min_rotation_time, max_rotation_time, novfx, var_b9988984b5068f56 );
    }
}

// Namespace mp_sat_ob_libra_util
// Params 7
// Checksum 0x57ac0836, Offset: 0x2f3c
// Size: 0x21e
function vista_sphere_behavior( ender, var_e061405aa325b731, var_e084525aa34c267f, min_rotation_time, max_rotation_time, novfx = 0, var_b9988984b5068f56 = 0 )
{
    if ( self.inited )
    {
        return;
    }
    
    self.linked_ents = utility::get_linked_ents();
    
    if ( isdefined( self.linked_ents ) )
    {
        foreach ( ent in self.linked_ents )
        {
            ent linkto( self );
        }
    }
    
    if ( isdefined( self.script_forceyaw ) )
    {
        self.linker = utility::spawn_tag_origin();
        self.linker dontinterpolate();
        self linkto( self.linker );
    }
    
    if ( !var_b9988984b5068f56 )
    {
        thread function_4a00cb4cc63a78ab();
        thread function_f119c2b09a306486( min_rotation_time, max_rotation_time );
    }
    
    if ( !novfx )
    {
        thread vista_sphere_vfx( var_e061405aa325b731, var_e084525aa34c267f );
    }
    
    self.inited = 1;
    
    if ( isdefined( ender ) )
    {
        level waittill( ender );
        self notify( #"hash_82a5a1cb6d89257" );
        
        if ( isdefined( self.linker ) )
        {
            self unlink();
            self.linker delete();
        }
        
        if ( isdefined( self.linked_ents ) )
        {
            foreach ( ent in self.linked_ents )
            {
                ent unlink();
                ent delete();
            }
        }
        
        self delete();
    }
}

// Namespace mp_sat_ob_libra_util
// Params 2
// Checksum 0x5a87857b, Offset: 0x3162
// Size: 0x131
function function_f119c2b09a306486( min_rotation_time = 40, max_rotation_time = 70 )
{
    self endon( #"death" );
    self endon( #"hash_82a5a1cb6d89257" );
    original_angles = self.angles;
    wait 0.05;
    
    if ( isdefined( self.script_forceyaw ) )
    {
        rotation_angles = ( 0, 360, 0 );
        var_4dfec929b4a0bad4 = randomfloatrange( min_rotation_time, max_rotation_time ) * 3;
        
        while ( true )
        {
            self function_f137e973856d34d9( ( 0, 360, 0 ), var_4dfec929b4a0bad4 );
            wait var_4dfec929b4a0bad4;
            self unlink();
            self linkto( self.linker );
        }
        
        return;
    }
    
    pitch = randomfloatrange( 1, 5 );
    yaw = 360;
    roll = randomfloatrange( 1, 5 );
    var_4dfec929b4a0bad4 = randomfloatrange( min_rotation_time, max_rotation_time ) * 3;
    
    while ( true )
    {
        self rotateby( ( pitch, yaw, roll ), var_4dfec929b4a0bad4 );
        wait var_4dfec929b4a0bad4;
    }
}

// Namespace mp_sat_ob_libra_util
// Params 0
// Checksum 0x1804e09b, Offset: 0x329b
// Size: 0x1cf
function function_4a00cb4cc63a78ab()
{
    self endon( #"death" );
    self endon( #"hash_82a5a1cb6d89257" );
    var_fd2b79a21fb987dc = self.linker.origin;
    
    if ( isdefined( self.script_forceyaw ) )
    {
        bob_speed_min = 10;
        bob_speed_max = 20;
        bob_height_min = 20;
        bob_height_max = 40;
        bob_height = randomfloatrange( bob_height_min, bob_height_max );
        bob_speed = randomfloatrange( bob_speed_min, bob_speed_max ) * 2;
        wait 0.05;
        var_d27ff46b8904dfde = self.linker.origin + anglestoup( self.linker.angles ) * bob_height;
        
        while ( true )
        {
            self.linker moveto( var_d27ff46b8904dfde, bob_speed, bob_speed * 0.25, bob_speed * 0.25 );
            self.linker waittill( #"movedone" );
            self.linker moveto( var_fd2b79a21fb987dc, bob_speed, bob_speed * 0.25, bob_speed * 0.25 );
            self.linker waittill( #"movedone" );
        }
        
        return;
    }
    
    bob_speed_min = 10;
    bob_speed_max = 20;
    bob_height_min = 20;
    bob_height_max = 40;
    bob_height = randomfloatrange( bob_height_min, bob_height_max );
    bob_speed = randomfloatrange( bob_speed_min, bob_speed_max );
    wait 0.05;
    
    while ( true )
    {
        self movez( bob_height, bob_speed, bob_speed * 0.25, bob_speed * 0.25 );
        self waittill( #"movedone" );
        self movez( bob_height * -1, bob_speed, bob_speed * 0.25, bob_speed * 0.25 );
        self waittill( #"movedone" );
    }
}

// Namespace mp_sat_ob_libra_util
// Params 2
// Checksum 0x6f01cc45, Offset: 0x3472
// Size: 0x13e
function vista_sphere_vfx( var_e061405aa325b731, var_e084525aa34c267f )
{
    self endon( #"death" );
    self endon( #"hash_82a5a1cb6d89257" );
    vfxarray = [];
    vfxarray[ vfxarray.size ] = "vfx_sat_levels_mp_ob_libra_vistaroom_cradle_sphere_valve_leak_underwater_1";
    tags = [];
    tags[ tags.size ] = "j_piston_01";
    tags[ tags.size ] = "j_piston_02";
    tags[ tags.size ] = "j_piston_03";
    tags[ tags.size ] = "j_piston_04";
    tags[ tags.size ] = "j_piston_05";
    tags[ tags.size ] = "j_piston_06";
    tags[ tags.size ] = "j_piston_07";
    tags[ tags.size ] = "j_piston_08";
    initial_delay_min = 3;
    initial_delay_max = 12;
    var_4cf5749f34f1831b = 3;
    initial_delay = randomfloatrange( initial_delay_min, initial_delay_max );
    
    while ( true )
    {
        tags = arrayrandomize( tags );
        waitarray = [];
        
        for ( i = 0; i < var_4cf5749f34f1831b ; i++ )
        {
            thread function_ce6c8742be0bd294( initial_delay, tags[ i ], vfxarray, var_e061405aa325b731, var_e084525aa34c267f );
            waitarray[ waitarray.size ] = i + "_finished";
        }
        
        utility::waittill_all_in_array( waitarray );
    }
}

// Namespace mp_sat_ob_libra_util
// Params 5
// Checksum 0xf4d6c45b, Offset: 0x35b8
// Size: 0xb3
function function_ce6c8742be0bd294( initial_delay, tagname, vfxarray, var_e061405aa325b731 = 2, var_e084525aa34c267f = 12 )
{
    self endon( #"death" );
    self endon( #"hash_82a5a1cb6d89257" );
    fx_duration = 7;
    wait initial_delay;
    
    while ( true )
    {
        fx_padding = randomfloatrange( var_e061405aa325b731, var_e084525aa34c267f );
        playfxontag( utility::getfx( utility::array_random( vfxarray ) ), self, tagname );
        wait fx_duration + fx_padding;
        self notify( tagname + "_finished" );
    }
}

// Namespace mp_sat_ob_libra_util
// Params 1
// Checksum 0xcb483d84, Offset: 0x3673
// Size: 0x18f
function function_d253e2f28e08ec19( ender )
{
    level endon( ender );
    
    while ( true )
    {
        utility::ent_flag_wait( "flag_inside_hallucination" );
        self playlocalsound( "evt_libra_vista_water_enter" );
        level.audio.var_8af083e7838b625c = "cradle_light_underwater";
        level.audio.var_e505b827fc3bc597 = "cradle_medium_underwater";
        level.audio.var_e06681f0753bde67 = "cradle_heavy_underwater";
        self setsoundsubmix( "mp_sat_ob_libra_vista_chamber" );
        level thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "heavy", undefined, undefined, self, undefined, undefined, 1 );
        playfxontagforclients( utility::getfx( "vfx_sat_levels_mp_ob_libra_vistaroom_breath_bubbles" ), self, "tag_eye", self );
        self.hallucination_scene_struct thread scene::play( undefined, "rise", "scene_sat_cin_libra_stor_pack_hal" );
        utility::ent_flag_waitopen_any( "flag_inside_hallucination" );
        self playlocalsound( "evt_libra_vista_water_exit" );
        level.audio.var_8af083e7838b625c = undefined;
        level.audio.var_e505b827fc3bc597 = undefined;
        level.audio.var_e06681f0753bde67 = undefined;
        self clearsoundsubmix( "mp_sat_ob_libra_vista_chamber" );
        self.hallucination_scene_struct thread scene::play( undefined, "fall", "scene_sat_cin_libra_stor_pack_hal" );
        var_f55661f3b76c5c75 = player::isinlaststand( self ) && !isalive( self );
        
        if ( !var_f55661f3b76c5c75 )
        {
            level thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "heavy", undefined, undefined, self, undefined, undefined, 1 );
        }
        
        killfxontag( utility::getfx( "vfx_sat_levels_mp_ob_libra_vistaroom_breath_bubbles" ), self, "tag_eye" );
    }
}

// Namespace mp_sat_ob_libra_util
// Params 1
// Checksum 0xe052745c, Offset: 0x380a
// Size: 0x96
function function_2bc2cecd260a5613( scene_structnames )
{
    foreach ( scene_targetname in scene_structnames )
    {
        scene_struct = utility::getstruct( scene_targetname );
        scene_struct thread scene::play( undefined, "init" );
    }
}

// Namespace mp_sat_ob_libra_util
// Params 1
// Checksum 0x3445638a, Offset: 0x38a8
// Size: 0x92
function function_cabd5f53e8d27f19( scene_structnames )
{
    foreach ( scene_targetname in scene_structnames )
    {
        scene_struct = utility::getstruct( scene_targetname );
        scene_struct scene::cleanup( 1 );
    }
}

// Namespace mp_sat_ob_libra_util
// Params 2
// Checksum 0x7750eeec, Offset: 0x3942
// Size: 0x351
function setup_robotic_modules( scene_root_targetname, endernotify )
{
    level.robotic_packing_modules_destroyed = 0;
    level utility::flag_wait( "scriptables_ready" );
    scriptable::scriptable_addnotifycallback( "cradle_loader_dead", &function_7893403a6719637f );
    var_989c04ca8776c84 = utility::getstructarray( scene_root_targetname );
    
    if ( isdefined( var_989c04ca8776c84 ) )
    {
        foreach ( root in var_989c04ca8776c84 )
        {
            root scene::add_spawn_function( &loader_spawn_function, "loader" );
            root scene::add_spawn_function( &function_a785747ff1948c98, "canister_01" );
            root scene::add_spawn_function( &function_a785747ff1948c98, "canister_02" );
            root scene::add_spawn_function( &function_a785747ff1948c98, "canister_03" );
            root scene::add_spawn_function( &function_a785747ff1948c98, "canister_04" );
            root scene::add_spawn_function( &glass_spawn_function, "glass" );
            base = getscriptablearray( root.target, #targetname );
            root.var_2625efdafde82b32 = getentarray( root.target, #targetname );
            
            if ( isdefined( root.var_2625efdafde82b32 ) )
            {
                foreach ( ent in root.var_2625efdafde82b32 )
                {
                    if ( ent.script_noteworthy == "robotic_arm_light" )
                    {
                        root.light = ent;
                    }
                }
            }
            
            if ( isdefined( base ) )
            {
                if ( isdefined( base[ 0 ] ) )
                {
                    base[ 0 ].scene_root = root;
                    
                    if ( isdefined( base[ 0 ].script_noteworthy ) )
                    {
                        base[ 0 ].group_waypoint_org = utility::getstruct( base[ 0 ].script_noteworthy + "_group_waypoint_org", "targetname" );
                        
                        if ( isdefined( base[ 0 ].group_waypoint_org ) )
                        {
                            base[ 0 ] thread base_objective_waypoint();
                        }
                    }
                    else if ( base[ 0 ] getscriptablepartstate( "main" ) != "healthy" )
                    {
                        base[ 0 ] setscriptablepartstate( "main", "healthy" );
                    }
                }
            }
            
            root utility::delaythread( randomfloatrange( 0, 5 ), &scene::play, undefined, undefined, "scene_sat_cin_libra_packing_dispenser" );
        }
    }
    
    if ( isdefined( endernotify ) )
    {
        level waittill( endernotify );
    }
    
    if ( isdefined( var_989c04ca8776c84 ) )
    {
        foreach ( root in var_989c04ca8776c84 )
        {
            root thread scene::cleanup( 1 );
        }
    }
}

// Namespace mp_sat_ob_libra_util
// Params 11
// Checksum 0xe87a08d4, Offset: 0x3c9b
// Size: 0xf3
function function_c50fc0694e69ce63( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( !( isdefined( instance ) && isdefined( instance.type ) ) || instance.type != "sat_machinery_cradle_loader_01_libra_server" )
    {
        return;
    }
    
    if ( smeansofdeath == "MOD_MELEE" )
    {
        return;
    }
    
    if ( isplayer( eattacker ) )
    {
        eattacker damagefeedback::updatehitmarker( "standard", 0, 0, 1, "hitequip" );
        return;
    }
    
    if ( isplayer( eattacker.owner ) )
    {
        eattacker.owner damagefeedback::updatehitmarker( "standard", 0, 0, 1, "hitequip" );
    }
}

// Namespace mp_sat_ob_libra_util
// Params 0
// Checksum 0xd3af8024, Offset: 0x3d96
// Size: 0x111
function base_objective_waypoint()
{
    if ( isdefined( self.group_waypoint_org ) )
    {
        if ( isdefined( self.group_waypoint_org.script_parameters ) )
        {
            level utility::flag_wait( self.group_waypoint_org.script_parameters );
            
            if ( self getscriptablepartstate( "main" ) != "healthy" )
            {
                self setscriptablepartstate( "main", "healthy" );
            }
            
            if ( isdefined( self.group_waypoint_org ) )
            {
                if ( !isdefined( self.group_waypoint_org.waypoint_set ) )
                {
                    if ( !isdefined( self.group_waypoint_org.destroyed ) )
                    {
                        str_objective_start = self.script_noteworthy + "_group_waypoint_org";
                        level.current_activity thread ob_story_mission_utils::function_56960723e6738b6c( undefined, str_objective_start, undefined, str_objective_start + "_waypoint_org_done", undefined, undefined, 1, 1 );
                        level thread function_776ea74dd9e92d46( self.group_waypoint_org.script_flag_set, str_objective_start );
                        self.group_waypoint_org.waypoint_set = 1;
                    }
                }
            }
        }
    }
}

// Namespace mp_sat_ob_libra_util
// Params 4
// Checksum 0x58e0f7e4, Offset: 0x3eaf
// Size: 0x376
function function_7893403a6719637f( instance, note, param, var_64ffacba090c91be )
{
    if ( isdefined( level.current_activity ) )
    {
        level.current_activity ob_story_mission_utils::function_315d79883d962ba7( level.robotic_packing_modules_destroyed, level.var_6fae192d5fa4845d );
    }
    
    if ( level utility::flag( "flag_packing_robotic_arms_group_02_group_destroyed" ) && level utility::flag( "flag_packing_robotic_arms_group_03_group_destroyed" ) )
    {
        level utility::flag_set( "flag_all_robotic_packing_modules_destroyed" );
    }
    
    if ( isdefined( instance.entity ) )
    {
        if ( isplayer( var_64ffacba090c91be ) )
        {
            var_64ffacba090c91be damagefeedback::updatehitmarker( "standard", 1, 0, 1, "hitequip" );
        }
        else if ( isplayer( var_64ffacba090c91be.owner ) )
        {
            var_64ffacba090c91be.owner damagefeedback::updatehitmarker( "standard", 1, 0, 1, "hitequip" );
        }
        
        instance.entity notify( #"scene_paused" );
        
        if ( isdefined( instance.entity.scene_root ) )
        {
            if ( isdefined( instance.entity.scene_root.light ) )
            {
                instance.entity.scene_root.light setlightintensity( 0 );
            }
            
            instance.entity.scene_root thread scene::pause();
            
            if ( isdefined( instance.entity.group_waypoint_org ) )
            {
                if ( !isdefined( instance.entity.group_waypoint_org.destroyed ) )
                {
                    level.robotic_packing_modules_destroyed++;
                    instance.entity.group_waypoint_org.destroyed = 1;
                }
                
                if ( isdefined( instance.entity.group_waypoint_org.script_flag_set ) )
                {
                    level utility::flag_set( instance.entity.group_waypoint_org.script_flag_set );
                }
                
                if ( isdefined( instance.entity.group_waypoint_org.waypoint_set ) )
                {
                    level.current_activity ob_story_mission_utils::objective_marker_clear( instance.entity.group_waypoint_org.var_8029d4363972e15 );
                }
            }
        }
        
        if ( isdefined( instance.entity.script_noteworthy ) )
        {
            bases = getscriptablearray( instance.entity.script_noteworthy, #script_noteworthy );
            
            if ( isdefined( bases ) )
            {
                foreach ( base in bases )
                {
                    if ( base != instance.entity )
                    {
                        var_b663fc67159f514d = base getscriptablepartstate( "main" );
                        
                        if ( var_b663fc67159f514d != "loader_dead" )
                        {
                            base setscriptablepartstate( "main", "loader_dead" );
                        }
                    }
                }
            }
        }
    }
}

// Namespace mp_sat_ob_libra_util
// Params 0
// Checksum 0x5faeaf98, Offset: 0x422d
// Size: 0x1c
function loader_spawn_function()
{
    self.health = 150;
    self setcandamage( 1 );
    thread function_cc1bbbbeebb82041();
}

// Namespace mp_sat_ob_libra_util
// Params 0
// Checksum 0x46658241, Offset: 0x4251
// Size: 0x28
function function_cc1bbbbeebb82041()
{
    self endon( #"entitydeleted" );
    self waittill( #"death" );
    
    if ( isdefined( self.origin ) )
    {
    }
}

// Namespace mp_sat_ob_libra_util
// Params 0
// Checksum 0x5faeaf3c, Offset: 0x4281
// Size: 0x1c
function function_a785747ff1948c98()
{
    self.health = 50;
    self setcandamage( 1 );
    thread function_1d1b15ec0f1a5a07();
}

// Namespace mp_sat_ob_libra_util
// Params 0
// Checksum 0xc7f5ea4f, Offset: 0x42a5
// Size: 0xba
function function_1d1b15ec0f1a5a07()
{
    self endon( #"entitydeleted" );
    self waittill( #"death", attacker );
    
    if ( isdefined( self.origin ) )
    {
        self setmodel( %"sat_storage_canister_cradle_01_destr_02" );
        playfx( utility::getfx( "vfx_sat_storage_canister_cradle_01_b" ), self.origin, anglestoforward( self.angles ) );
        playrumbleonposition( "grenade_rumble", self.origin );
        earthquake( 0.4, 0.75, self.origin, 200 );
        
        if ( isdefined( attacker ) )
        {
            attacker namespace_a350a26c6d662a6a::cradle_burst( self.origin, 200, "medium", undefined, 200, 1 );
        }
    }
}

// Namespace mp_sat_ob_libra_util
// Params 0
// Checksum 0x5faeaf3c, Offset: 0x4367
// Size: 0x1c
function glass_spawn_function()
{
    self.health = 50;
    self setcandamage( 1 );
    thread function_1386605caa761ec();
}

// Namespace mp_sat_ob_libra_util
// Params 0
// Checksum 0x692d5662, Offset: 0x438b
// Size: 0x5d
function function_1386605caa761ec()
{
    self endon( #"entitydeleted" );
    self waittill( #"death" );
    
    if ( isdefined( self.origin ) )
    {
        self setmodel( %"sat_machinery_cradle_loader_01_glass_destr" );
        playfx( utility::getfx( "vfx_sat_machinery_cradle_loader_01_glass" ), self.origin, anglestoforward( self.angles ) );
    }
}

// Namespace mp_sat_ob_libra_util
// Params 0
// Checksum 0x1ab961a9, Offset: 0x43f0
// Size: 0x269
function function_d6294e91e307ff3a()
{
    nodes_to_spawn = [];
    nodes_to_spawn[ nodes_to_spawn.size ] = [ ( -48, 0, 16 ), ( 0, 0, 0 ), "Cover Stand" ];
    nodes_to_spawn[ nodes_to_spawn.size ] = [ ( 0, -48, 16 ), ( 0, 90, 0 ), "Cover Stand" ];
    nodes_to_spawn[ nodes_to_spawn.size ] = [ ( 48, 0, 16 ), ( 0, 180, 0 ), "Cover Stand" ];
    nodes_to_spawn[ nodes_to_spawn.size ] = [ ( 0, 48, 16 ), ( 0, 270, 0 ), "Cover Stand" ];
    nodes_to_spawn[ nodes_to_spawn.size ] = [ ( -48, -18, 16 ), ( 0, 0, 0 ), "Cover Right" ];
    nodes_to_spawn[ nodes_to_spawn.size ] = [ ( -18, -48, 16 ), ( 0, 90, 0 ), "Cover Right" ];
    nodes_to_spawn[ nodes_to_spawn.size ] = [ ( 48, -18, 16 ), ( 0, 180, 0 ), "Cover Right" ];
    nodes_to_spawn[ nodes_to_spawn.size ] = [ ( -18, 48, 16 ), ( 0, 270, 0 ), "Cover Right" ];
    nodes_to_spawn[ nodes_to_spawn.size ] = [ ( -48, 18, 16 ), ( 0, 0, 0 ), "Cover Left" ];
    nodes_to_spawn[ nodes_to_spawn.size ] = [ ( 18, -48, 16 ), ( 0, 90, 0 ), "Cover Left" ];
    nodes_to_spawn[ nodes_to_spawn.size ] = [ ( 48, 18, 16 ), ( 0, 180, 0 ), "Cover Left" ];
    nodes_to_spawn[ nodes_to_spawn.size ] = [ ( 18, 48, 16 ), ( 0, 270, 0 ), "Cover Left" ];
    return nodes_to_spawn;
}

// Namespace mp_sat_ob_libra_util
// Params 0
// Checksum 0x127f7698, Offset: 0x4662
// Size: 0x121
function cradle_crate_spawn_nodes()
{
    self.var_b2f8e5c576d3e25f = [];
    nodes_to_spawn = function_d6294e91e307ff3a();
    
    foreach ( data in nodes_to_spawn )
    {
        if ( !isdefined( self.angles ) )
        {
            self.angles = ( 0, 0, 0 );
        }
        
        var_12ef0eb32b573cf1 = coordtransform( data[ 0 ], self.origin, self.angles );
        var_bf3e21e5d4373139 = self.angles + data[ 1 ];
        var_4a1ac098d5898640 = spawncovernode( var_12ef0eb32b573cf1, var_bf3e21e5d4373139, data[ 2 ] );
        
        if ( isdefined( var_4a1ac098d5898640 ) )
        {
            var_4a1ac098d5898640 connectnode();
            self.var_b2f8e5c576d3e25f = arraycombineunique( self.var_b2f8e5c576d3e25f, [ var_4a1ac098d5898640 ] );
        }
    }
}

// Namespace mp_sat_ob_libra_util
// Params 0
// Checksum 0xcb0b1c5f, Offset: 0x478b
// Size: 0x96
function function_889f3afecd07ea9e()
{
    if ( isdefined( self.var_b2f8e5c576d3e25f ) )
    {
        foreach ( var_4a1ac098d5898640 in self.var_b2f8e5c576d3e25f )
        {
            var_4a1ac098d5898640 disconnectnode();
            
            if ( var_4a1ac098d5898640 isspawnedcovernode() )
            {
                despawncovernode( var_4a1ac098d5898640 );
            }
        }
    }
}

// Namespace mp_sat_ob_libra_util
// Params 0
// Checksum 0x70a25ce5, Offset: 0x4829
// Size: 0x11d
function function_7c6f64dfa8ae940c()
{
    ents = getentarray( "processing_ladder_ai_clip", "targetname" );
    
    if ( level.players.size <= 2 )
    {
        foreach ( ent in ents )
        {
            ent solid();
            ent disconnectpaths();
        }
        
        thread ob_story_mission_utils::item_spawn_equipment( "2p_equip_processing" );
        return;
    }
    
    foreach ( ent in ents )
    {
        ent notsolid();
        ent connectpaths();
    }
}

/#

    // Namespace mp_sat_ob_libra_util
    // Params 2
    // Checksum 0xac095e39, Offset: 0x494e
    // Size: 0xec, Type: dev
    function function_2fd559479db565bc( force_field_name, key )
    {
        level utility::flag_wait( "<dev string:x34>" );
        force_fields = getentarray( force_field_name, key );
        
        foreach ( ff in force_fields )
        {
            ff hide();
            ff notsolid();
            ff.var_7c4a63493e09272c = utility::function_e1bb0bf82dab729e();
            
            if ( isdefined( ff.var_7c4a63493e09272c[ 0 ] ) )
            {
                ff.var_7c4a63493e09272c[ 0 ] setscriptablepartstate( "<dev string:x46>", "<dev string:x4b>" );
            }
        }
    }

#/

// Namespace mp_sat_ob_libra_util
// Params 4
// Checksum 0xe18c5677, Offset: 0x4a42
// Size: 0x120
function function_7e4765db24e0ee73( state = "off", force_field_name, key = #targetname, remove_power_supply )
{
    level utility::flag_wait( "scriptables_ready" );
    
    if ( !level.var_ad5a2bd25598da74 )
    {
        scriptable::scriptable_addnotifycallback( "force_field_death", &force_field_power_supply_death );
        level.var_ad5a2bd25598da74 = 1;
    }
    
    force_fields = getentarray( force_field_name, key );
    
    foreach ( ff in force_fields )
    {
        ff force_field_setup();
        
        if ( state == "off" )
        {
            ff force_field_off( 1, remove_power_supply );
            continue;
        }
        
        ff force_field_on();
    }
}

// Namespace mp_sat_ob_libra_util
// Params 0
// Checksum 0x807cc01c, Offset: 0x4b6a
// Size: 0x4af
function force_field_setup()
{
    ff = self;
    ff hide( 1 );
    ff notsolid();
    
    if ( ff.inited )
    {
        return;
    }
    
    ff.targetscriptables = getscriptablearray( ff.target, #targetname );
    isdestroyed = 0;
    
    if ( isdefined( ff.targetscriptables ) )
    {
        foreach ( scriptable in ff.targetscriptables )
        {
            if ( scriptable.script_noteworthy == "power_supply" )
            {
                ff.power_supply = scriptable;
                
                if ( !isdefined( scriptable.ff ) )
                {
                    scriptable.ff = [];
                }
                
                isdestroyed = scriptable getscriptablepartstate( "force_field_power_supply", 1 ) == "destroyed";
                scriptable.ff[ scriptable.ff.size ] = ff;
            }
        }
    }
    
    if ( isdefined( ff.script_linkto ) )
    {
        ff.var_7c4a63493e09272c = ff utility::function_e1bb0bf82dab729e();
        
        if ( isdefined( ff.var_7c4a63493e09272c[ 0 ] ) )
        {
            ff.ff_scriptable = ff.var_7c4a63493e09272c[ 0 ];
        }
    }
    
    ff.targetents = getentarray( ff.target, "targetname" );
    
    if ( isdefined( ff.targetents ) )
    {
        foreach ( ent in ff.targetents )
        {
            if ( ent.script_noteworthy == "power_cable" )
            {
                ff.power_cable = ent;
                
                if ( !isdefined( ff.power_supply.power_cable ) )
                {
                    tokens = strtok( ent.model, "::" );
                    
                    if ( isdefined( tokens[ 1 ] ) )
                    {
                        ent.base_model_name = tokens[ 1 ];
                    }
                    
                    ff.power_supply.power_cable = ent;
                }
            }
        }
    }
    
    if ( isdestroyed )
    {
        ff.inited = 1;
        ff force_field_off();
        return;
    }
    
    ff.targetstructs = utility::getstructarray( ff.target, "targetname" );
    
    if ( isdefined( ff.targetstructs ) )
    {
        foreach ( struct in ff.targetstructs )
        {
            if ( struct.script_noteworthy == "interact" )
            {
                ff.interact_struct = struct;
                
                if ( !isdefined( struct.ff ) )
                {
                    struct.ff = [];
                }
                
                struct.ff[ struct.ff.size ] = ff;
                
                if ( !isdefined( struct.interact ) )
                {
                    struct.interact = interaction::register_interact( struct.origin, 32, &function_fb4826422bc54835, &"sat_ob_story_missions/interact_toggle", undefined, undefined, undefined, "HINT_BUTTON" );
                    struct.interact sethintdisplayrange( 100 );
                }
                
                if ( !isdefined( struct.interact.ff ) )
                {
                    struct.interact.ff = [];
                }
                
                struct.interact.ff[ struct.interact.ff.size ] = ff;
                ff.interact = struct.interact;
            }
        }
    }
    
    ff.inited = 1;
}

// Namespace mp_sat_ob_libra_util
// Params 0
// Checksum 0x70643f90, Offset: 0x5021
// Size: 0x241
function force_field_on()
{
    ff = self;
    
    if ( isdefined( ff.on ) )
    {
        return;
    }
    
    if ( isdefined( ff.targetscriptables ) )
    {
        foreach ( scriptable in ff.targetscriptables )
        {
            if ( scriptable.script_noteworthy == "power_supply" )
            {
                if ( scriptable getscriptablepartstate( "force_field_power_supply", 1 ) == "destroyed" )
                {
                    return;
                }
            }
        }
    }
    
    ff show();
    ff solid();
    
    if ( isdefined( ff.power_supply.power_cable ) )
    {
        ff.power_supply.power_cable function_4fdecaa2fa5ed383( 1 );
    }
    
    ff.ff_scriptable setscriptablepartstate( "main", "startup" );
    nav_ent = getent( ff.script_parameters, #script_noteworthy );
    
    if ( nav_ent )
    {
        ff.var_12aadf5d8bbfdafd = function_aafd9c2a00b86dba( nav_ent, "custom_default_on" );
    }
    else
    {
        ff.var_12aadf5d8bbfdafd = function_aafd9c2a00b86dba( ff, "custom_default_on" );
    }
    
    if ( isdefined( ff.script_fxid ) )
    {
        utility::exploder( ff.script_fxid );
    }
    
    if ( !isdefined( ff.audio_loop ) )
    {
        ff.audio_loop = snd::play( "amb_force_field_lp", ff.origin );
        snd::play( "amb_force_field_switch_on", ff.origin );
    }
    
    if ( isdefined( ff.interact ) )
    {
        snd::play( "uin_force_field_switch_on", ff.interact.origin );
        ff.interact sethintstring( &"sat_ob_story_missions/interact_toggle" );
    }
    
    ff.on = 1;
}

// Namespace mp_sat_ob_libra_util
// Params 2
// Checksum 0xac2d3c86, Offset: 0x526a
// Size: 0x1ca
function force_field_off( scripted_off, remove_power_supply = 0 )
{
    ff = self;
    
    if ( isdefined( ff.power_supply.power_cable ) )
    {
        ff.power_supply.power_cable function_4fdecaa2fa5ed383( 0 );
    }
    
    if ( remove_power_supply )
    {
        ff.power_supply setscriptablepartstate( "force_field_power_supply", "off" );
    }
    
    ff notsolid();
    ff hide( 1 );
    
    if ( scripted_off )
    {
        ff.ff_scriptable setscriptablepartstate( "main", "off" );
    }
    else
    {
        ff.ff_scriptable setscriptablepartstate( "main", "shut down" );
    }
    
    if ( isdefined( ff.var_12aadf5d8bbfdafd ) )
    {
        destroynavobstacle( ff.var_12aadf5d8bbfdafd );
    }
    
    if ( isdefined( ff.script_fxid ) )
    {
        utility::stop_exploder( ff.script_fxid );
    }
    
    if ( isdefined( ff.audio_loop ) )
    {
        snd::stop( ff.audio_loop );
        ff.audio_loop = undefined;
        snd::play( "amb_force_field_switch_off", ff.origin );
    }
    
    if ( isdefined( ff.interact ) )
    {
        snd::play( "uin_force_field_switch_off", ff.interact.origin );
        ff.interact sethintstring( &"sat_ob_story_missions/interact_toggle" );
    }
    
    if ( !scripted_off )
    {
        if ( isdefined( ff.script_flag_set ) )
        {
            level utility::flag_set( ff.script_flag_set );
        }
    }
    
    ff.on = undefined;
}

// Namespace mp_sat_ob_libra_util
// Params 1
// Checksum 0x5a94b069, Offset: 0x543c
// Size: 0x1f
function function_90c440460dba0ba2( var_ab4b4c27b2c67244 )
{
    if ( isdefined( var_ab4b4c27b2c67244 ) )
    {
        self function_78a8bbd6805e6296( "custom_default_on", var_ab4b4c27b2c67244 );
    }
}

// Namespace mp_sat_ob_libra_util
// Params 4
// Checksum 0x24e4c4cb, Offset: 0x5463
// Size: 0xe4
function force_field_power_supply_death( instance, note, param, var_64ffacba090c91be )
{
    if ( isdefined( instance.entity.ff ) )
    {
        foreach ( ff in instance.entity.ff )
        {
            if ( isdefined( ff.interact ) )
            {
                ff.interact delete();
            }
            
            ff force_field_off();
        }
    }
}

// Namespace mp_sat_ob_libra_util
// Params 1
// Checksum 0xdb1004b3, Offset: 0x554f
// Size: 0x50
function function_4fdecaa2fa5ed383( var_e619071b03ea2479 )
{
    if ( var_e619071b03ea2479 )
    {
        variant = "on::";
        self setmodel( variant + self.base_model_name );
        return;
    }
    
    variant = "base::";
    self setmodel( variant + self.base_model_name );
}

// Namespace mp_sat_ob_libra_util
// Params 1
// Checksum 0xeabf9671, Offset: 0x55a7
// Size: 0xb8
function function_fb4826422bc54835( player )
{
    self endon( #"death" );
    
    if ( isdefined( self.ff ) )
    {
        foreach ( ff in self.ff )
        {
            if ( ff.on )
            {
                ff force_field_off();
                continue;
            }
            
            ff force_field_on();
        }
    }
}

// Namespace mp_sat_ob_libra_util
// Params 0
// Checksum 0xd54db272, Offset: 0x5667
// Size: 0x20
function setup_cradle_canister_burst()
{
    level utility::flag_wait( "scriptables_ready" );
    scriptable::scriptable_addnotifycallback( "cradle_canister_burst", &namespace_a350a26c6d662a6a::cradle_canister_burst_scriptable );
}

// Namespace mp_sat_ob_libra_util
// Params 1
// Checksum 0x6fecb6ff, Offset: 0x568f
// Size: 0x1cc
function function_afa9097075953144( var_16c19461cc7f0e41 )
{
    self endon( #"death" );
    var_8a8e38178b359264 = [];
    var_8a8e38178b359264[ var_8a8e38178b359264.size ] = "damage";
    var_8a8e38178b359264[ var_8a8e38178b359264.size ] = "suppression";
    var_8a8e38178b359264[ var_8a8e38178b359264.size ] = "bulletwhizby";
    var_8a8e38178b359264[ var_8a8e38178b359264.size ] = "explosion";
    var_8a8e38178b359264[ var_8a8e38178b359264.size ] = "grenade danger";
    var_8a8e38178b359264[ var_8a8e38178b359264.size ] = "projectile_impact";
    var_8a8e38178b359264[ var_8a8e38178b359264.size ] = "gunshot_impact";
    var_8a8e38178b359264[ var_8a8e38178b359264.size ] = "proximity";
    var_8a8e38178b359264[ var_8a8e38178b359264.size ] = "silenced_shot_impact";
    var_8a8e38178b359264[ var_8a8e38178b359264.size ] = "decoy_grenade";
    
    foreach ( event in var_8a8e38178b359264 )
    {
        self addaieventlistener( event );
    }
    
    while ( true )
    {
        self waittill( #"ai_events", events );
        
        foreach ( event in events )
        {
            if ( isdefined( event.type ) && arraycontains( var_8a8e38178b359264, event.type ) )
            {
                if ( isplayer( event.entity ) )
                {
                    self.var_87b6158bd19786b8 = 1;
                    thread function_9325b08fd5fadcbe( var_16c19461cc7f0e41 );
                    return;
                }
            }
        }
        
        waitframe();
    }
}

// Namespace mp_sat_ob_libra_util
// Params 1
// Checksum 0x6d904bf4, Offset: 0x5863
// Size: 0x7f
function function_9325b08fd5fadcbe( var_16c19461cc7f0e41 )
{
    self notify( #"hash_25d6e5ffa53912c2" );
    self endon( #"hash_25d6e5ffa53912c2" );
    self endon( #"death" );
    self leaveinteraction();
    self setgoalpos( self.origin, 0 );
    wait randomfloatrange( 2, 3.5 );
    volume = getnoentvolumearray( var_16c19461cc7f0e41, #targetname )[ 0 ];
    
    if ( isdefined( volume ) )
    {
        thread ai_utility::go_to_node();
    }
}

// Namespace mp_sat_ob_libra_util
// Params 0
// Checksum 0xc016c022, Offset: 0x58ea
// Size: 0x16
function function_8b236fd87f53b446()
{
    if ( self.var_87b6158bd19786b8 )
    {
        return 1;
    }
    
    return 0;
}

// Namespace mp_sat_ob_libra_util
// Params 0
// Checksum 0xf117421f, Offset: 0x5908
// Size: 0x1a1
function fire_custom()
{
    self endon( #"death" );
    tag = "tag_flash";
    tracedist = 3000;
    
    while ( true )
    {
        self waittill( #"fire" );
        linked_ents = self getlinkedchildren();
        
        if ( isdefined( linked_ents[ 0 ] ) )
        {
            gun = linked_ents[ 0 ];
            data = gun function_7ca48b456a70eda7();
            start = gun gettagorigin( tag );
            end = start + anglestoforward( gun gettagangles( tag ) ) * tracedist;
            playfxontag( data.muzzle_fx, gun, tag );
            
            if ( soundexists( data.var_7049eff624cd105a ) )
            {
                playsoundatpos( start, data.var_7049eff624cd105a );
            }
            
            trace = trace::ray_trace( start, end, [ self, gun ], trace::create_default_contents( 0 ), 1, 1, 1 );
            
            if ( isdefined( trace[ "position" ] && trace[ "surfacetype" ] ) )
            {
                if ( issubstr( trace[ "surfacetype" ], "metal" ) )
                {
                    impact_fx = utility::getfx( "vfx_sat_core_impacts_impact_metal_nonpen_med" );
                }
                else if ( issubstr( trace[ "surfacetype" ], "concrete" ) )
                {
                    impact_fx = utility::getfx( "vfx_sat_core_impacts_impact_concrete_med" );
                }
                else if ( issubstr( trace[ "surfacetype" ], "flesh" ) )
                {
                }
                else
                {
                    impact_fx = utility::getfx( "vfx_sat_core_impacts_impact_concrete_med" );
                }
                
                playfx( impact_fx, trace[ "position" ], trace[ "normal" ] );
            }
        }
    }
}

// Namespace mp_sat_ob_libra_util
// Params 0
// Checksum 0x998eb917, Offset: 0x5ab1
// Size: 0x1c3
function function_7ca48b456a70eda7()
{
    if ( isdefined( self.model ) )
    {
        if ( issubstr( self.model, "zebra" ) )
        {
            data = spawnstruct();
            data.muzzle_fx = utility::getfx( "vfx_sat_wc_igc_muz_sm_zebra" );
            data.var_7049eff624cd105a = "wpn_sm_zebra_fire_npc";
            data.weapon = "sat_sm_zebra_mp";
            return data;
        }
        
        if ( issubstr( self.model, "condor" ) )
        {
            data = spawnstruct();
            data.muzzle_fx = utility::getfx( "vfx_sat_wc_igc_muz_ar_condor" );
            data.var_7049eff624cd105a = "wpn_dm_scotia_fire_npc";
            data.weapon = "sat_dm_scotia_mp";
            return data;
        }
        
        if ( issubstr( self.model, "scotia" ) )
        {
            data = spawnstruct();
            data.muzzle_fx = utility::getfx( "vfx_sat_wc_igc_muz_dm_scotia" );
            data.var_7049eff624cd105a = "wpn_dm_scotia_fire_npc";
            data.weapon = "sat_dm_scotia_mp";
            return data;
        }
        
        if ( issubstr( self.model, "falcon" ) )
        {
            data = spawnstruct();
            data.muzzle_fx = utility::getfx( "vfx_sat_wc_igc_muz_ar_falcon" );
            data.var_7049eff624cd105a = "wpn_ar_falcon_fire_npc";
            data.weapon = "sat_ar_falcon_mp";
            return data;
        }
        
        data = spawnstruct();
        data.muzzle_fx = utility::getfx( "vfx_sat_wc_igc_muz_ar_enemy" );
        data.var_7049eff624cd105a = "wpn_ar_falcon_fire_npc";
        data.weapon = "sat_ar_falcon_mp";
        return data;
    }
}

// Namespace mp_sat_ob_libra_util
// Params 4
// Checksum 0xc42a411f, Offset: 0x5c7c
// Size: 0xb7
function get_player_view_controller( model, tag, originoffset, turret = "player_view_turret" )
{
    origin = model gettagorigin( tag );
    player_view_controller = spawnturret( "misc_turret", origin, turret );
    player_view_controller dontinterpolate();
    player_view_controller.angles = model gettagangles( tag );
    player_view_controller setmodel( %"tag_turret_mech" );
    player_view_controller linkto( model, tag, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    player_view_controller setmode( "manual" );
    return player_view_controller;
}

// Namespace mp_sat_ob_libra_util
// Params 5
// Checksum 0xdedd0253, Offset: 0x5d3c
// Size: 0x15c
function function_c8c6f25fb6f7f1d4( spawn_group_targetname, var_46f1327fcd04fb1e, var_82fc71dbcd0dd897, all_dead_flag, group_array )
{
    var_bf05c3168959c2db = utility::getstructarray( spawn_group_targetname );
    
    if ( isdefined( var_bf05c3168959c2db ) )
    {
        foreach ( struct in var_bf05c3168959c2db )
        {
            struct scene::init();
            bot = struct scene::get_entity( "Actor 1" );
            
            if ( isdefined( bot ) )
            {
                bot.group_array = group_array;
                bot.scene_root = struct;
                bot.var_46f1327fcd04fb1e = var_46f1327fcd04fb1e;
                bot.var_82fc71dbcd0dd897 = var_82fc71dbcd0dd897;
                bot thread function_9c68cbb6f1149dff( all_dead_flag );
                
                if ( isdefined( bot.scene_root.target ) )
                {
                    bot.target = bot.scene_root.target;
                    bot thread ai_utility::go_to_node();
                }
            }
        }
    }
}

// Namespace mp_sat_ob_libra_util
// Params 1
// Checksum 0xda30ab03, Offset: 0x5ea0
// Size: 0x14d
function function_9c68cbb6f1149dff( all_dead_flag )
{
    level.var_c0ee7b6e1e1f71c6[ self.group_array ][ level.var_c0ee7b6e1e1f71c6[ self.group_array ].size ] = self;
    self.team = "team_hundred_ninety";
    self.var_24954f14e27b448d = 0;
    self.ignoreme = 1;
    self.ignoreall = 1;
    self disableaimassist();
    utility::set_battlechatter( 0 );
    thread function_90c440460dba0ba2( 0 );
    thread function_87c9dc12f3244d2d( all_dead_flag );
    level utility::flag_wait( self.var_46f1327fcd04fb1e );
    
    if ( issubstr( self.scene_root.scenescriptbundle, "wall" ) )
    {
        if ( utility::cointoss() )
        {
            shot = "exit_01";
        }
        else
        {
            shot = "exit_02";
        }
    }
    else
    {
        shot = "exit_0" + randomintrange( 1, 4 );
    }
    
    wait self.var_82fc71dbcd0dd897;
    self.scene_root thread scene::play( self, shot );
    wait 0.5;
    val::set( "scene_shot", "damage", 0 );
    self.ignoreme = 0;
    self.ignoreall = 0;
    self.var_24954f14e27b448d = 1;
    self enableaimassist();
    utility::set_battlechatter( 1 );
}

// Namespace mp_sat_ob_libra_util
// Params 1
// Checksum 0xf1aaf4bc, Offset: 0x5ff5
// Size: 0x6a
function function_87c9dc12f3244d2d( all_dead_flag )
{
    group_array = self.group_array;
    self waittill( #"death" );
    level.var_c0ee7b6e1e1f71c6[ group_array ] = utility::array_removedead_or_dying( level.var_c0ee7b6e1e1f71c6[ group_array ] );
    
    if ( level.var_c0ee7b6e1e1f71c6[ group_array ].size < 1 )
    {
        level utility::flag_set( all_dead_flag );
    }
}

// Namespace mp_sat_ob_libra_util
// Params 4
// Checksum 0xc367b5b0, Offset: 0x6067
// Size: 0x4d
function function_776ea74dd9e92d46( waitflag, structtargetname, var_1288e7582a6bdb5 = undefined, ender )
{
    if ( ender )
    {
        level endon( ender );
    }
    
    level utility::flag_wait( waitflag );
    waypoint_objective_handler::waypoint_objective_handler_cancel( structtargetname, var_1288e7582a6bdb5 );
}

// Namespace mp_sat_ob_libra_util
// Params 3
// Checksum 0x9fb40e59, Offset: 0x60bc
// Size: 0x95
function function_bf06941991e5f14( pos, rumble_name, var_4c310eb5827b77dc )
{
    if ( isdefined( rumble_name ) )
    {
        playrumbleonposition( rumble_name, pos );
    }
    
    if ( var_4c310eb5827b77dc )
    {
        switch ( var_4c310eb5827b77dc )
        {
            case #"hash_5971965ed985a26c":
                level thread function_18fee449c48ecd39( pos );
                break;
            case #"hash_c71b112fe04823d6":
                level thread function_df1651443c034889( pos );
                break;
            case #"hash_4bf33d595d8f4894":
                level thread function_f81852ae0f4c0835( pos );
                break;
            default:
                break;
        }
    }
}

// Namespace mp_sat_ob_libra_util
// Params 3
// Checksum 0xeca23d10, Offset: 0x6159
// Size: 0x67
function function_d8b65cd09b5a50bb( array, var_5eb8d9eaa9cf4c47, var_d0fee849997aeeb7 = 0 )
{
    assert( isdefined( array ) );
    
    while ( array.size )
    {
        if ( var_d0fee849997aeeb7 )
        {
            function_4ec2db15072c88f3( array );
        }
        
        array = utility::array_removedead_or_dying( array );
        wait 0.1;
    }
    
    if ( isdefined( var_5eb8d9eaa9cf4c47 ) )
    {
        utility::flag_set( var_5eb8d9eaa9cf4c47 );
    }
}

// Namespace mp_sat_ob_libra_util
// Params 6
// Checksum 0x1d1e5e44, Offset: 0x61c8
// Size: 0xef
function handle_drones( var_1f727fc6db558e07, offset = ( 0, 0, 0 ), delay, type = "turret", dronedata, var_b60496d5b429ae0f )
{
    if ( !isdefined( level.ob_drone_throttle ) )
    {
        function_190956a43f7f0633();
    }
    
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    spawn_points = utility::getstructarray( var_1f727fc6db558e07, "targetname" );
    count = spawn_points.size;
    self.dronescount = spawn_points.size;
    level.storage_drones = [];
    
    for ( index = 0; index < count ; index++ )
    {
        level.storage_drones[ level.storage_drones.size ] = function_7c91f56fa8065a89( type, offset, spawn_points[ index ], dronedata, var_b60496d5b429ae0f );
    }
}

// Namespace mp_sat_ob_libra_util
// Params 10
// Checksum 0x47d9560e, Offset: 0x62bf
// Size: 0x17d
function setup_drone_values( movedistance = 500, var_6f8e1815c814e080 = 200, var_6f6b0e15c7ee82ca = 64, engagedmovetime = 2, alertmovetime = 2, dashmovetime = 2, var_c48a311adb63f5da = 0.75, var_7a09c045385eacee = 0.75, stationarytime = 2, var_4f9479db21cbaf60 = 2 )
{
    dronedata = spawnstruct();
    dronedata.movedistance = movedistance;
    dronedata.var_6f8e1815c814e080 = var_6f8e1815c814e080;
    dronedata.var_6f6b0e15c7ee82ca = var_6f6b0e15c7ee82ca;
    dronedata.engagedmovetime = engagedmovetime;
    dronedata.alertmovetime = alertmovetime;
    dronedata.dashmovetime = dashmovetime;
    dronedata.var_c48a311adb63f5da = var_c48a311adb63f5da;
    dronedata.var_7a09c045385eacee = var_7a09c045385eacee;
    dronedata.stationarytime = stationarytime;
    dronedata.var_4f9479db21cbaf60 = var_4f9479db21cbaf60;
    dronedata.memory = { #bad_pos:[], #vis_stack:[] };
    return dronedata;
}

// Namespace mp_sat_ob_libra_util
// Params 0
// Checksum 0x41556ba6, Offset: 0x6445
// Size: 0x30
function function_190956a43f7f0633()
{
    level.ob_drone_throttle = throttle::throttle_initialize( "ob_drone_move", 1, level.framedurationseconds ?? 0.1 );
    ob_flying_drone::setup_helper_drones();
}

// Namespace mp_sat_ob_libra_util
// Params 5
// Checksum 0x8f8da0ec, Offset: 0x647d
// Size: 0x19c
function function_7c91f56fa8065a89( type, offset, struct, dronedata = setup_drone_values(), var_b60496d5b429ae0f )
{
    spawn_path_array = [ struct.origin + offset ];
    drone = ob_flying_drone::spawn_helper_drone( type, level.players[ 0 ], spawn_path_array );
    drone.movedistance = dronedata.movedistance;
    drone.var_6f8e1815c814e080 = dronedata.var_6f8e1815c814e080;
    drone.var_6f6b0e15c7ee82ca = dronedata.var_6f6b0e15c7ee82ca;
    drone.engagedmovetime = dronedata.engagedmovetime;
    drone.alertmovetime = dronedata.alertmovetime;
    drone.dashmovetime = dronedata.dashmovetime;
    drone.var_c48a311adb63f5da = dronedata.var_c48a311adb63f5da;
    drone.var_7a09c045385eacee = dronedata.var_7a09c045385eacee;
    drone.stationarytime = dronedata.stationarytime;
    drone.var_4f9479db21cbaf60 = dronedata.var_4f9479db21cbaf60;
    drone.memory = dronedata.memory;
    
    if ( isdefined( var_b60496d5b429ae0f ) )
    {
        drone thread function_de15b1fe5f750ea2( var_b60496d5b429ae0f );
    }
    
    drone thread ob_flying_drone::function_dbc3536438aea5e0();
    drone thread ob_flying_drone::drone_movebehavior();
    return drone;
}

// Namespace mp_sat_ob_libra_util
// Params 1
// Checksum 0xbac1b7d, Offset: 0x6622
// Size: 0x5e
function function_de15b1fe5f750ea2( var_b60496d5b429ae0f )
{
    drone = self;
    drone endon( #"main_drone_destroyed" );
    drone endon( #"hash_84941674cca5e76d" );
    drone endon( #"drone_cleaned_up" );
    drone endon( #"death" );
    level utility::flag_wait( var_b60496d5b429ae0f );
    drone delete();
}

// Namespace mp_sat_ob_libra_util
// Params 2
// Checksum 0xf8cb25a9, Offset: 0x6688
// Size: 0x118
function ai_nerf( var_c93772d0d8fd27c4 = 2, var_361a087ab08adc1c )
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    self endon( #"death" );
    
    if ( utility::ent_flag( "ai_nerf" ) )
    {
        return;
    }
    
    utility::ent_flag_set( "ai_nerf" );
    
    if ( isdefined( self.attackeraccuracy ) )
    {
        self.attackeraccuracy *= var_c93772d0d8fd27c4;
    }
    
    self.baseaccuracy *= 0.5;
    ai::set_ai_max_health( int( self.health * 0.5 ) + 1 );
    
    if ( isdefined( self.armorhealth ) )
    {
        self.armorhealth = int( self.armorhealth * 0.5 ) + 1;
    }
    
    self.ignoresuppression = 1;
    self setcoverstate( "exposed" );
    self.balwayscoverexposed = 1;
    self.defaultcoverselector = %"cover_exposed_nodes";
    self requestcoverfind( 1, 1, %"cover_exposed_nodes" );
}

// Namespace mp_sat_ob_libra_util
// Params 3
// Checksum 0x1465dbd8, Offset: 0x67a8
// Size: 0x43
function function_bd1845bf5896dd1b( var_190f59357d8260f7, variant, modelname )
{
    if ( isdefined( var_190f59357d8260f7 ) )
    {
        modelstring = variant + "::" + modelname;
        var_190f59357d8260f7 setmodel( modelstring );
    }
}

// Namespace mp_sat_ob_libra_util
// Params 5
// Checksum 0x1bf3ae4d, Offset: 0x67f3
// Size: 0x138
function function_32b80bf22f39a811( targetname, var_b4d9de79d0d10d09, var_e2fd1130fc1f0cc1, cleanupflag, var_6254d57caf9b4017 )
{
    if ( var_6254d57caf9b4017 )
    {
        structs = utility::getstructarray( targetname );
        
        if ( isdefined( structs ) )
        {
            var_ad5f2230708242f8 = [];
            
            foreach ( struct in structs )
            {
                var_1e548ec484f9695b = spawn( "script_model", struct.origin );
                var_1e548ec484f9695b.angles = struct.angles;
                var_1e548ec484f9695b setmodel( var_6254d57caf9b4017 );
                var_1e548ec484f9695b dontinterpolate();
                var_ad5f2230708242f8[ var_ad5f2230708242f8.size ] = var_1e548ec484f9695b;
            }
        }
    }
    else
    {
        var_ad5f2230708242f8 = getentarray( targetname, #targetname );
    }
    
    if ( isdefined( var_ad5f2230708242f8 ) )
    {
        utility::array_thread( var_ad5f2230708242f8, &function_553c5df3ad8c45dc, var_b4d9de79d0d10d09, var_e2fd1130fc1f0cc1, cleanupflag );
    }
}

// Namespace mp_sat_ob_libra_util
// Params 3
// Checksum 0xbc17a376, Offset: 0x6933
// Size: 0xb8
function function_553c5df3ad8c45dc( var_b4d9de79d0d10d09, var_e2fd1130fc1f0cc1, cleanupflag )
{
    level endon( cleanupflag );
    self.var_f007e26d53ba7bef = snd::play( "amb_emt_industrial_fan_lp_01", self );
    thread delete_on_flag( cleanupflag );
    
    while ( true )
    {
        if ( var_b4d9de79d0d10d09 == "pitch" )
        {
            self rotatepitch( 360, var_e2fd1130fc1f0cc1 );
            self waittill( #"rotatedone" );
            continue;
        }
        
        if ( var_b4d9de79d0d10d09 == "yaw" )
        {
            self rotateyaw( 360, var_e2fd1130fc1f0cc1 );
            self waittill( #"rotatedone" );
            continue;
        }
        
        if ( var_b4d9de79d0d10d09 == "roll" )
        {
            self rotateroll( 360, var_e2fd1130fc1f0cc1 );
            self waittill( #"rotatedone" );
        }
    }
}

// Namespace mp_sat_ob_libra_util
// Params 1
// Checksum 0x9b72e8a9, Offset: 0x69f3
// Size: 0x3b
function delete_on_flag( cleanupflag )
{
    level utility::flag_wait( cleanupflag );
    
    if ( isdefined( self ) )
    {
        snd::stop( self.var_f007e26d53ba7bef );
        self.var_f007e26d53ba7bef = undefined;
        self delete();
    }
}

// Namespace mp_sat_ob_libra_util
// Params 2
// Checksum 0x89783fb, Offset: 0x6a36
// Size: 0x7a
function handle_alarms( var_b441e339542b82c7, var_68b32a8bafee7061 )
{
    alarm_loops = snd::play( "amb_libra_generic_alarm", var_b441e339542b82c7 );
    
    while ( !utility::flag( var_68b32a8bafee7061 ) )
    {
        activateworldevent( var_b441e339542b82c7 );
        wait 0.2;
        deactivateworldevent( var_b441e339542b82c7 );
        wait 0.1;
        activateworldevent( var_b441e339542b82c7 );
        wait 0.2;
        deactivateworldevent( var_b441e339542b82c7 );
        wait 0.5;
    }
    
    snd::stop( alarm_loops );
}

// Namespace mp_sat_ob_libra_util
// Params 2
// Checksum 0xb6489e17, Offset: 0x6ab8
// Size: 0xc9
function function_4003e4e7ea24dd2b( variant, duration = -1 )
{
    foreach ( player in level.players )
    {
        modelstring = variant + "::" + "sat_libra_electronics_server_console_standing_01b";
        player utility::player_prestream_assets( "libra_util", "model", [ modelstring ], [ 200 ], duration );
    }
}

// Namespace mp_sat_ob_libra_util
// Params 0
// Checksum 0x56f3d3b3, Offset: 0x6b89
// Size: 0x197
function function_9886d86be8c62744()
{
    legs = getentarray( "armory_mech_legs", #targetname );
    clips = getentarray( "mech_torso_clip", #script_noteworthy );
    
    if ( isdefined( legs ) )
    {
        i = 0;
        
        foreach ( base in legs )
        {
            base.torso = spawn( "script_model", base gettagorigin( "tag_turret_attach" ) );
            base.torso setmodel( %"xcomp_veh_sat_mil_drone_biped_top_scriptable" );
            base.torso linkto( base, "tag_turret_attach", ( 0, 0, 0 ), ( 0, 0, 0 ) );
            
            if ( isdefined( clips ) )
            {
                base.torso.clip = clips[ i ];
                base.torso.clip linkto( base.torso, "tag_turret", ( 0, 0, 0 ), ( 0, 0, 0 ) );
            }
            
            base.torso thread function_e7759fab925967d2();
            i++;
        }
    }
}

// Namespace mp_sat_ob_libra_util
// Params 0
// Checksum 0xaf8fe7f3, Offset: 0x6d28
// Size: 0x35
function function_e7759fab925967d2()
{
    level utility::flag_wait( "flag_boss_intro_regroup_countdown_finished" );
    
    if ( isdefined( self.clip ) )
    {
        self.clip delete();
    }
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace mp_sat_ob_libra_util
// Params 0
// Checksum 0xcf568d36, Offset: 0x6d65
// Size: 0x96
function function_4761f7db1c5265f0()
{
    current_weapons = self getweaponslistall();
    
    foreach ( weapon in current_weapons )
    {
        if ( weapon.basename == "sat_pi_timir_mp" )
        {
            self takeweapon( weapon );
        }
    }
}

// Namespace mp_sat_ob_libra_util
// Params 1
// Checksum 0xb05d3623, Offset: 0x6e03
// Size: 0xa9
function function_4ec2db15072c88f3( ai )
{
    if ( isarray( ai ) )
    {
        foreach ( guy in ai )
        {
            if ( guy is_off_navmesh() )
            {
                guy ai_utility::delete_ai();
            }
        }
        
        return;
    }
    
    if ( ai is_off_navmesh() )
    {
        ai ai_utility::delete_ai();
    }
}

// Namespace mp_sat_ob_libra_util
// Params 0
// Checksum 0xd4c1ef5f, Offset: 0x6eb4
// Size: 0x44
function is_off_navmesh()
{
    if ( isalive( self ) )
    {
        point = getclosestpointonnavmesh( self.origin );
        
        if ( isdefined( point ) )
        {
            if ( distance2dsquared( self.origin, point ) > 1024 )
            {
                return 1;
            }
        }
        
        return 0;
    }
}

// Namespace mp_sat_ob_libra_util
// Params 1
// Checksum 0x7d7dc9c9, Offset: 0x6f00
// Size: 0x20
function function_cf3e18e44adf3387( var_c810450e0af7b948 )
{
    level thread function_b076a562af645b43( var_c810450e0af7b948 );
    level thread function_da83ef43d3d9d5c( var_c810450e0af7b948 );
}

// Namespace mp_sat_ob_libra_util
// Params 1
// Checksum 0x57867e44, Offset: 0x6f28
// Size: 0x14
function function_b076a562af645b43( var_c810450e0af7b948 )
{
    if ( var_c810450e0af7b948 )
    {
    }
}

// Namespace mp_sat_ob_libra_util
// Params 1
// Checksum 0xe583636, Offset: 0x6f44
// Size: 0x196
function function_da83ef43d3d9d5c( var_c810450e0af7b948 )
{
    escape_hull_tube_link_positions = utility::getstructarray( "escape_hull_tube_link_pos" );
    
    if ( isdefined( escape_hull_tube_link_positions ) )
    {
        foreach ( pos in escape_hull_tube_link_positions )
        {
            ents = getentarray( pos.target, #targetname );
            
            if ( isdefined( ents ) )
            {
                if ( var_c810450e0af7b948 )
                {
                    foreach ( ent in ents )
                    {
                        ent hide( 1 );
                    }
                    
                    continue;
                }
                
                foreach ( ent in ents )
                {
                    ent show();
                }
            }
        }
    }
}

// Namespace mp_sat_ob_libra_util
// Params 2
// Checksum 0xee7447d3, Offset: 0x70e2
// Size: 0x99
function function_51599a610d3dc9af( category, waitflag )
{
    level utility::flag_wait( waitflag );
    
    foreach ( player in level.players )
    {
        player utility::player_prestream_clear( category );
    }
}

// Namespace mp_sat_ob_libra_util
// Params 3
// Checksum 0x4377fd40, Offset: 0x7183
// Size: 0xb4
function show_hint_toast( hint_id, kbm_hint, gamepad_hint )
{
    foreach ( player in level.players )
    {
        hintstring = kbm_hint;
        
        if ( player usinggamepad() )
        {
            hintstring = gamepad_hint;
        }
        
        player hints::hint_add_simple( hint_id, hintstring, 5 );
    }
}

// Namespace mp_sat_ob_libra_util
// Params 0
// Checksum 0xa843dd88, Offset: 0x723f
// Size: 0x1e
function function_4634dc9b969d833b()
{
    level thread nightmare_transition( undefined, 1, 1, 1 );
    level thread nightmare_transition_off( "flag_escape_gauntlet_solo_door_burst" );
}

// Namespace mp_sat_ob_libra_util
// Params 5
// Checksum 0x8f3e6076, Offset: 0x7265
// Size: 0x70
function nightmare_transition( flag_name, index = 1, do_transition = 1, var_ad30c944bbd232d7 = 1, delay )
{
    if ( isdefined( flag_name ) )
    {
        level utility::flag_wait( flag_name );
    }
    
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    level thread ob_story_mission_utils::function_ecbb860d6714e9f3( index, do_transition, var_ad30c944bbd232d7 );
}

// Namespace mp_sat_ob_libra_util
// Params 1
// Checksum 0x639d507b, Offset: 0x72dd
// Size: 0x23
function nightmare_transition_off( flag_name )
{
    level utility::flag_wait( flag_name );
    level thread ob_story_mission_utils::function_ecbb860d6714e9f3( 0, 1, 1 );
}

// Namespace mp_sat_ob_libra_util
// Params 1
// Checksum 0x1fdbdadf, Offset: 0x7308
// Size: 0x99
function nightmare_transition_stream( origin )
{
    level endon( #"hash_9f84d6fb0f86cfdf" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            player predictstreamposuntilcleared( origin );
        }
        
        waitframe();
    }
}

// Namespace mp_sat_ob_libra_util
// Params 0
// Checksum 0x47a8ee8, Offset: 0x73a9
// Size: 0xa6
function cooling_pool_hurt_trigger()
{
    if ( level utility::flag( "flag_cooling_pool_hurt_trigger_enabled" ) )
    {
        return;
    }
    
    trigger = getent( "cooling_pool_hurt_trigger", "targetname" );
    level endon( #"flag_boss_intro_regroup_countdown_finished" );
    
    if ( isdefined( trigger ) )
    {
        level utility::flag_set( "flag_cooling_pool_hurt_trigger_enabled" );
        trigger endon( #"death" );
        
        while ( true )
        {
            trigger waittill( #"trigger", player );
            
            if ( isalive( player ) && &player::isinlaststand && player.sessionstate == "playing" )
            {
                player kill();
            }
        }
    }
}

