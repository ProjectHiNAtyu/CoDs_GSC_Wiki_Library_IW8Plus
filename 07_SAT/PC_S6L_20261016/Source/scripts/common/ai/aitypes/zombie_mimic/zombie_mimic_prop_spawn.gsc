// scripts\common\ai\aitypes\zombie_mimic\zombie_mimic_prop_spawn.gsc  (hash_606754bc418969dc.gscc) (size: 28316 Bytes / 0x6e9c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6edcf7fa (1859975162)
// size ...... 28316 (0x6e9c)
// includes .. 10  (offset: 0x6a10)
// strings ... 32  (offset: 0x6a60)
// dev strs .. 51  (offset: 0x6c28)
// exports ... 74  (offset: 0x482c)
// cseg ...... 0x2c9 + 0x4563 (0x482c)
// imports ... 180 (offset: 0x53bc)
// animtree1 . 0   (offset: 0x6e9c)
// animtree2 . 0   (offset: 0x6e9c)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_mimic\zombie_mimic_medal;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\scriptable;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_mimic_prop_spawn;

// Namespace zombie_mimic_prop_spawn
// Params 1
// Checksum 0xc6c9f775, Offset: 0x2e7
// Size: 0x183
function function_2ff4d4f70bcc117c( aitypescriptbundle )
{
    settings = zombie_utils::function_a225e7aa4a243fb2( aitypescriptbundle );
    
    if ( isdefined( settings ) )
    {
        if ( settings.var_4fe07df5d3e9d4f1 )
        {
            utility::add_fx( "mimic_hide_fx", settings.var_4fe07df5d3e9d4f1 );
        }
        
        if ( settings.var_bb1ba7ecc1aa4550 )
        {
            utility::add_fx( "mimic_prop_emerge_fx", settings.var_bb1ba7ecc1aa4550 );
        }
        
        if ( settings.var_39e253c559c70493 )
        {
            utility::add_fx( "mimic_prop_spawn_in_fx", settings.var_39e253c559c70493 );
        }
        
        if ( settings.var_bde6cfef5c9cc340 )
        {
            utility::add_fx( "mimic_prop_spawn_out_fx", settings.var_bde6cfef5c9cc340 );
        }
        
        if ( settings.var_df1d1e08fe18cbbb )
        {
            utility::add_fx( "mimic_prop_rattle_fx", settings.var_df1d1e08fe18cbbb );
        }
    }
    
    level.var_8cae4ac35bfedc51 = ( 0, 0, 64 );
    level.var_5f10511273162163 = 100;
    level.var_83264e2a7e28fd81 = 3;
    utility::registersharedfunc( #"mimic_prop", #"hash_652981ac6cb6e8c9", &function_93a8605debe833a4 );
    utility::registersharedfunc( #"mimic_prop", #"hash_fcfe4302fe1691b6", &function_c727c09ec08aed83 );
    utility::registersharedfunc( #"mimic_prop", #"hash_992dc6999e4dab86", &function_284333c6441018ff );
    scriptable::scriptable_addusedcallback( &function_4562257262b19ce9 );
    
    /#
        setdevdvarifuninitialized( @"hash_821690ed248715f7", 0 );
    #/
}

// Namespace zombie_mimic_prop_spawn
// Params 0
// Checksum 0x3f5bde1d, Offset: 0x472
// Size: 0x157
function function_de819190b982b94e()
{
    level.var_bdaf1d69422ab15b = [];
    level.mimic_trap_props = [];
    level.var_c79ae97e80404ba5 = [];
    level.var_d9352319e43c7c73 = [];
    level.var_8939c433088c0f10 = &function_8939c433088c0f10;
    waitframe();
    level.var_67625bb718718d94 = 1;
    level.var_8ab41ebe366796e5 = utility::getstructarray( "mimic_spawn_point", "variantname" );
    level.var_c7c8ff1d46d97ab8 = level.var_8ab41ebe366796e5.size > 0;
    level thread function_d8187e8640ab51d8();
    
    /#
        function_92a855af75563ed();
    #/
    
    level.var_fbc96d6bb4163faf = 3;
    level.var_f58d04c3618ccf7d = 5;
    level.var_94767e4d2b626bdc = 400;
    level.var_f9c0de15cbc254d4 = 0.35;
    wait 5;
    ambient_mimic_spawn_points = utility::getstructarray( "ambient_mimic_spawn", "script_noteworthy" );
    
    foreach ( point in ambient_mimic_spawn_points )
    {
        level.var_8ab41ebe366796e5 = arraycombineunique( level.var_8ab41ebe366796e5, [ point ] );
    }
}

// Namespace zombie_mimic_prop_spawn
// Params 0
// Checksum 0xc18c81eb, Offset: 0x5d1
// Size: 0x15b
function function_d8187e8640ab51d8()
{
    wait 5;
    
    if ( isdefined( level.interacts ) )
    {
        foreach ( interact in level.interacts )
        {
            if ( !isent( interact ) || isdefined( interact.s_doorbuy ) || isdefined( interact.s_exfil ) )
            {
                continue;
            }
            
            if ( !isdefined( interact.model ) || interact.model == "" || interact.model == "tag_origin" )
            {
                continue;
            }
            
            prop = spawnstruct();
            prop.interact = interact;
            prop.var_c47c1baf88389769 = 1;
            prop.origin = interact.origin;
            prop.angles = interact.angles;
            level.var_8ab41ebe366796e5[ level.var_8ab41ebe366796e5.size ] = prop;
        }
    }
}

// Namespace zombie_mimic_prop_spawn
// Params 5
// Checksum 0xb9708baf, Offset: 0x734
// Size: 0x143
function function_93a8605debe833a4( prop_spawn_points, entity, trap_prop_point, var_63af90461049806d, reveal_condition_func )
{
    var_82209d06b3fad29d = [];
    
    if ( prop_spawn_points.size > 0 )
    {
        var_ac7feb217012872f = randomintrange( level.var_fbc96d6bb4163faf, level.var_f58d04c3618ccf7d );
        var_82209d06b3fad29d = function_e70ea3c496e4c1ac( prop_spawn_points, var_ac7feb217012872f, entity, var_63af90461049806d );
    }
    
    if ( !isdefined( trap_prop_point ) )
    {
        if ( self.var_d1c1b9dfa9a899a1 )
        {
            foreach ( prop in var_82209d06b3fad29d )
            {
                players = namespace_9d8e359c3b1041e5::getplayersinradiussharedfunc( prop.origin, level.var_94767e4d2b626bdc );
                
                if ( players.size == 0 )
                {
                    trap_prop_point = prop;
                    break;
                }
            }
        }
        
        if ( !isdefined( trap_prop_point ) && var_82209d06b3fad29d.size > 0 )
        {
            trap_prop_point = var_82209d06b3fad29d[ 0 ];
        }
    }
    
    return function_c9f4c7f5803b1ce5( var_82209d06b3fad29d, entity, trap_prop_point, undefined, var_63af90461049806d, reveal_condition_func );
}

// Namespace zombie_mimic_prop_spawn
// Params 6
// Checksum 0xa202afbf, Offset: 0x880
// Size: 0xb7
function function_c6b4aadecefb2d63( origin, entity, trap_prop_point, var_636415fd6306e863 = randomintrange( level.var_fbc96d6bb4163faf, level.var_f58d04c3618ccf7d ), search_radius = 1000, reveal_condition_func )
{
    if ( isdefined( level.var_1e8f8c176c29b14e ) )
    {
        search_radius = level.var_1e8f8c176c29b14e;
    }
    
    spawn_points = function_e1614198bafc8acf( origin, search_radius, var_636415fd6306e863 );
    
    if ( spawn_points.size || isdefined( trap_prop_point ) )
    {
        if ( !spawn_points.size )
        {
            spawn_points[ spawn_points.size ] = trap_prop_point;
        }
        
        return function_93a8605debe833a4( spawn_points, entity, trap_prop_point, undefined, reveal_condition_func );
    }
}

// Namespace zombie_mimic_prop_spawn
// Params 6
// Checksum 0xc75ae380, Offset: 0x93f
// Size: 0x1ae
function function_c9f4c7f5803b1ce5( var_82209d06b3fad29d, mimic, var_b1f3dccf5a1b9bb7, var_c0915e2e6ebeece6, var_63af90461049806d, reveal_condition_func )
{
    if ( isstruct( var_b1f3dccf5a1b9bb7 ) )
    {
        if ( isdefined( level.var_b45db6e1ed3b4f06[ var_b1f3dccf5a1b9bb7.var_c47c1baf88389769 ] ) )
        {
            [ prop, var_eeaed1eb223197cd ] = [[ level.var_b45db6e1ed3b4f06[ var_b1f3dccf5a1b9bb7.var_c47c1baf88389769 ].handler ]]( var_b1f3dccf5a1b9bb7 );
            var_b1f3dccf5a1b9bb7 = prop;
            reveal_condition_func = var_eeaed1eb223197cd;
        }
        else
        {
            var_b1f3dccf5a1b9bb7 = function_364d9cde07043d7( var_b1f3dccf5a1b9bb7, var_63af90461049806d );
        }
        
        if ( isdefined( var_b1f3dccf5a1b9bb7 ) )
        {
            var_82209d06b3fad29d[ var_82209d06b3fad29d.size ] = var_b1f3dccf5a1b9bb7;
        }
    }
    
    if ( !var_82209d06b3fad29d.size )
    {
        return;
    }
    
    if ( !isdefined( var_b1f3dccf5a1b9bb7 ) )
    {
        random_prop_array = arrayrandomize( var_82209d06b3fad29d );
        
        foreach ( prop in random_prop_array )
        {
            if ( prop.is_trap_prop )
            {
                var_b1f3dccf5a1b9bb7 = prop;
                break;
            }
        }
        
        if ( !isdefined( var_b1f3dccf5a1b9bb7 ) )
        {
            var_b1f3dccf5a1b9bb7 = random_prop_array[ 0 ];
        }
    }
    
    if ( !isdefined( var_b1f3dccf5a1b9bb7 ) )
    {
        return;
    }
    
    level.mimic_trap_props = arraycombineunique( level.mimic_trap_props, [ var_b1f3dccf5a1b9bb7 ] );
    
    if ( isdefined( var_c0915e2e6ebeece6 ) )
    {
        var_b1f3dccf5a1b9bb7.origin = var_c0915e2e6ebeece6;
    }
    
    function_2e6c79373f411ab( mimic, var_b1f3dccf5a1b9bb7, var_82209d06b3fad29d, reveal_condition_func );
    return var_b1f3dccf5a1b9bb7;
}

// Namespace zombie_mimic_prop_spawn
// Params 1
// Checksum 0x26203cad, Offset: 0xaf6
// Size: 0xff, Type: bool
function function_35dd5c93e4c73e1c( position )
{
    if ( can_spawn_props( 1 ) )
    {
        return true;
    }
    else if ( isdefined( position ) )
    {
        var_81c28b45cff6d485 = utility::get_array_of_closest( position, level.var_8ab41ebe366796e5, undefined, undefined, 1000 );
        
        foreach ( spawn_point in var_81c28b45cff6d485 )
        {
            if ( isdefined( spawn_point.var_c47c1baf88389769 ) && isdefined( level.var_b45db6e1ed3b4f06[ spawn_point.var_c47c1baf88389769 ] ) && [[ level.var_b45db6e1ed3b4f06[ spawn_point.var_c47c1baf88389769 ].var_b1b868a4e6037838 ]]( spawn_point ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace zombie_mimic_prop_spawn
// Params 0
// Checksum 0x1db2b8a3, Offset: 0xbfe
// Size: 0x21
function get_trap_props()
{
    level.mimic_trap_props = function_5713d46873b29625( level.mimic_trap_props );
    return level.mimic_trap_props;
}

// Namespace zombie_mimic_prop_spawn
// Params 0
// Checksum 0xab69cc6d, Offset: 0xc28
// Size: 0xad
function function_374a64a5b03ab73f()
{
    level.mimic_trap_props = function_5713d46873b29625( level.mimic_trap_props );
    var_a9e35d87d6985bc7 = [];
    
    foreach ( prop in level.mimic_trap_props )
    {
        if ( !prop val::get( "hide" ) )
        {
            var_a9e35d87d6985bc7[ var_a9e35d87d6985bc7.size ] = prop;
        }
    }
    
    return var_a9e35d87d6985bc7;
}

// Namespace zombie_mimic_prop_spawn
// Params 0
// Checksum 0xcc5550b6, Offset: 0xcde
// Size: 0x13
function function_fa5388c8c0ccfc3c()
{
    if ( !isdefined( level.var_b45db6e1ed3b4f06 ) )
    {
        return [];
    }
    
    return [];
}

// Namespace zombie_mimic_prop_spawn
// Params 4
// Checksum 0x7f2bf818, Offset: 0xcfa
// Size: 0x263
function function_e1614198bafc8acf( origin, radius, var_636415fd6306e863, var_af81a3653f961e4a = 1 )
{
    var_81c28b45cff6d485 = utility::get_array_of_closest( origin, level.var_8ab41ebe366796e5, undefined, undefined, radius );
    prop_spawn_locs = [];
    weights = [];
    
    foreach ( spawn_point in var_81c28b45cff6d485 )
    {
        if ( isdefined( spawn_point.var_c47c1baf88389769 ) && isdefined( level.var_b45db6e1ed3b4f06[ spawn_point.var_c47c1baf88389769 ] ) && ![[ level.var_b45db6e1ed3b4f06[ spawn_point.var_c47c1baf88389769 ].var_b1b868a4e6037838 ]]( spawn_point ) )
        {
            continue;
        }
        
        if ( var_af81a3653f961e4a && spawn_point.claimed )
        {
            continue;
        }
        
        prop_spawn_locs[ prop_spawn_locs.size ] = spawn_point;
        weights[ weights.size ] = spawn_point.script_int ?? 1;
    }
    
    if ( prop_spawn_locs.size > 1 )
    {
        trap_prop_loc = utility::random_weighted( prop_spawn_locs, weights );
        prop_spawn_locs = arrayrandomize( prop_spawn_locs );
        array_size = 1;
        var_696775d26c4da3fd = [ trap_prop_loc ];
        
        if ( array_size < var_636415fd6306e863 )
        {
            foreach ( var_11cdcfd134cee516 in prop_spawn_locs )
            {
                if ( var_11cdcfd134cee516 != trap_prop_loc )
                {
                    var_696775d26c4da3fd[ array_size ] = var_11cdcfd134cee516;
                    array_size++;
                }
                
                if ( array_size >= var_636415fd6306e863 )
                {
                    break;
                }
            }
        }
        
        prop_spawn_locs = var_696775d26c4da3fd;
    }
    
    if ( prop_spawn_locs.size < 1 && isdefined( level.var_8939c433088c0f10 ) && !level.var_c7c8ff1d46d97ab8 )
    {
        prop_spawn_locs = arraycombine( prop_spawn_locs, [[ level.var_8939c433088c0f10 ]]( origin, var_636415fd6306e863 - prop_spawn_locs.size ) );
    }
    
    return prop_spawn_locs;
}

// Namespace zombie_mimic_prop_spawn
// Params 2
// Checksum 0x1ff72de, Offset: 0xf66
// Size: 0x55, Type: bool
function can_spawn_props( var_636415fd6306e863, entity )
{
    var_38f0a324ae3f6447 = isdefined( entity ) && arraycontains( level.var_c79ae97e80404ba5, entity );
    return 30 - level.var_bdaf1d69422ab15b.size + level.var_c79ae97e80404ba5.size - var_38f0a324ae3f6447 >= var_636415fd6306e863;
}

// Namespace zombie_mimic_prop_spawn
// Params 4
// Checksum 0xf56b021e, Offset: 0xfc4
// Size: 0x1a2
function function_e70ea3c496e4c1ac( spawn_points, var_636415fd6306e863, entity, var_63af90461049806d )
{
    var_636415fd6306e863 = min( var_636415fd6306e863, spawn_points.size );
    level.var_bdaf1d69422ab15b = function_5713d46873b29625( level.var_bdaf1d69422ab15b );
    var_82209d06b3fad29d = [];
    
    if ( !can_spawn_props( var_636415fd6306e863, entity ) )
    {
        var_38f0a324ae3f6447 = isdefined( entity ) && arraycontains( level.var_c79ae97e80404ba5, entity );
        
        if ( level.var_bdaf1d69422ab15b.size + level.var_c79ae97e80404ba5.size >= 30 )
        {
            return var_82209d06b3fad29d;
        }
        
        var_636415fd6306e863 = 30 - level.var_bdaf1d69422ab15b.size + level.var_c79ae97e80404ba5.size - var_38f0a324ae3f6447;
    }
    
    if ( !spawn_points.size )
    {
        return var_82209d06b3fad29d;
    }
    
    spawn_points = arrayrandomize( spawn_points );
    
    foreach ( loc in spawn_points )
    {
        if ( namespace_9d8e359c3b1041e5::getplayersinradiussharedfunc( loc.origin, 300 ).size && !loc.ignore_spawn_distance )
        {
            continue;
        }
        
        if ( isdefined( loc.var_c47c1baf88389769 ) )
        {
            var_82209d06b3fad29d[ var_82209d06b3fad29d.size ] = loc;
            continue;
        }
        
        prop = function_364d9cde07043d7( loc, var_63af90461049806d );
        var_82209d06b3fad29d[ var_82209d06b3fad29d.size ] = prop;
        
        if ( var_82209d06b3fad29d.size >= var_636415fd6306e863 )
        {
            break;
        }
    }
    
    return var_82209d06b3fad29d;
}

// Namespace zombie_mimic_prop_spawn
// Params 2
// Checksum 0x281f048, Offset: 0x116f
// Size: 0x31d
function get_prop_info( spawn_loc, var_63af90461049806d )
{
    bundle = undefined;
    override_model_name = undefined;
    
    if ( isdefined( var_63af90461049806d ) )
    {
        bundle = getscriptbundle( var_63af90461049806d );
    }
    else if ( isdefined( spawn_loc.script_modelname ) )
    {
        bundle = undefined;
        override_model_name = spawn_loc.script_modelname;
    }
    else if ( isdefined( spawn_loc.scriptbundlename ) )
    {
        bundle = getscriptbundle( spawn_loc.scriptbundlename );
    }
    else if ( isdefined( level.var_29b254229e44041c ) )
    {
        bundle = getscriptbundle( level.var_29b254229e44041c );
    }
    else
    {
        bundle = getscriptbundle( "mimicproplist:mimic_prop_list_default" );
    }
    
    result = spawnstruct();
    
    if ( !isdefined( bundle ) )
    {
        result.prop_name = override_model_name;
        
        if ( !isdefined( result.prop_name ) )
        {
            result.prop_name = "decor_barrel_metal_rusty_01";
        }
        
        result.pos_offset = ( 0, 0, 0 );
        result.angle_offset = ( 0, 0, 0 );
        result.var_626ff4de8bf51f24 = 1;
        return result;
    }
    
    var_9ef0e043aff2a4e4 = bundle.itementries[ randomint( bundle.itementries.size ) ];
    
    if ( !isdefined( var_9ef0e043aff2a4e4 ) )
    {
        return;
    }
    
    result.pos_offset = ( var_9ef0e043aff2a4e4.offset_x ?? 0, var_9ef0e043aff2a4e4.offset_y ?? 0, var_9ef0e043aff2a4e4.offset_z ?? 0 );
    result.angle_offset = ( var_9ef0e043aff2a4e4.pitch ?? 0, var_9ef0e043aff2a4e4.yaw ?? 0, var_9ef0e043aff2a4e4.roll ?? 0 );
    result.prop_name = var_9ef0e043aff2a4e4.model;
    
    if ( !isdefined( var_9ef0e043aff2a4e4.model ) && isdefined( var_9ef0e043aff2a4e4.itemspawnentry ) )
    {
        result.var_70982855c9113555 = 1;
        result.prop_name = "itemspawnentry:" + var_9ef0e043aff2a4e4.itemspawnentry;
    }
    
    result.rattle_sound = var_9ef0e043aff2a4e4.rattle_sound;
    result.var_73ef38c940c391ef = var_9ef0e043aff2a4e4.var_69f694b540ae649a;
    result.var_626ff4de8bf51f24 = istrue( var_9ef0e043aff2a4e4.var_5601f36fe65cd245 );
    
    if ( isdefined( spawn_loc.script_linkto ) )
    {
        var_c8692c885ac9b10d = getent( spawn_loc.script_linkto, "script_linkname" );
        
        if ( !isdefined( var_c8692c885ac9b10d ) )
        {
            linked_s = utility::getstruct( spawn_loc.script_linkto, "script_linkname" );
            
            if ( isdefined( linked_s ) )
            {
                var_c8692c885ac9b10d = linked_s.var_7fac639c5e7fd54 ?? linked_s.mdl_ammo_cache ?? linked_s.mdl_arsenal ?? linked_s.mdl_perk_machine;
            }
        }
        
        result.prop_linked_ent = var_c8692c885ac9b10d;
    }
    
    return result;
}

// Namespace zombie_mimic_prop_spawn
// Params 4
// Checksum 0xc8bae90c, Offset: 0x1495
// Size: 0x37b
function function_364d9cde07043d7( spawn_loc, var_63af90461049806d, model_name_override, var_a1b4aefb83f1a9ee )
{
    prop_spawn_info = get_prop_info( spawn_loc, var_63af90461049806d );
    model_name = "tag_origin";
    var_34cdd5cda21b2ad1 = undefined;
    item_scriptable_name = undefined;
    
    if ( !isdefined( spawn_loc.angles ) )
    {
        spawn_loc.angles = ( 0, 0, 0 );
    }
    
    if ( prop_spawn_info.var_70982855c9113555 )
    {
        itemspawnentry = getscriptbundle( prop_spawn_info.prop_name );
        prop_spawn_info.pos_offset = ( itemspawnentry.var_17c626587c17976a ?? 0, itemspawnentry.var_17c627587c17999d ?? 0, itemspawnentry.positionoffsetz ?? 0 );
        prop_spawn_info.angle_offset = ( itemspawnentry.var_87702108b863fe1a ?? 0, itemspawnentry.var_87702208b864004d ?? 0, itemspawnentry.var_87701f08b863f9b4 ?? 0 );
        
        if ( isdefined( itemspawnentry.scriptable ) )
        {
            item_scriptable_name = itemspawnentry.scriptable;
            var_34cdd5cda21b2ad1 = spawnscriptable( itemspawnentry.scriptable, spawn_loc.origin + prop_spawn_info.pos_offset, spawn_loc.angles + prop_spawn_info.angle_offset );
            var_34cdd5cda21b2ad1.disable = 1;
        }
        else if ( isdefined( itemspawnentry.worldmodel ) )
        {
            model_name = itemspawnentry.worldmodel;
        }
    }
    else
    {
        model_name = prop_spawn_info.prop_name;
    }
    
    if ( isdefined( model_name_override ) )
    {
        model_name = model_name_override;
    }
    
    if ( !var_a1b4aefb83f1a9ee && !spawn_loc.no_spawn_fx )
    {
        playfx( utility::getfx( "mimic_prop_spawn_in_fx" ), spawn_loc.origin + prop_spawn_info.pos_offset );
    }
    
    model = utility::spawn_model( model_name, spawn_loc.origin + prop_spawn_info.pos_offset, spawn_loc.angles + prop_spawn_info.angle_offset );
    spawn_loc.claimed = 1;
    model.spawn_loc = spawn_loc;
    model.rattle_sound = prop_spawn_info.rattle_sound;
    model.var_626ff4de8bf51f24 = prop_spawn_info.var_626ff4de8bf51f24;
    model.var_73ef38c940c391ef = prop_spawn_info.var_73ef38c940c391ef;
    model.prop_linked_ent = prop_spawn_info.prop_linked_ent;
    model.var_34cdd5cda21b2ad1 = var_34cdd5cda21b2ad1;
    model.item_scriptable_name = item_scriptable_name;
    
    if ( model.var_626ff4de8bf51f24 )
    {
        model.navobstacle = createnavobstaclebyent( model );
    }
    else
    {
        model notsolid();
        model.var_52aee7937d5ee2d6 = utility::spawn_model( "t10_zm_gameplay_collision_01", model.origin, model.angles );
    }
    
    if ( isent( model.prop_linked_ent ) )
    {
        model.prop_linked_ent hide();
    }
    
    model thread utility::thread_on_notify_no_endon_death( "death", &on_prop_deleted );
    level.var_bdaf1d69422ab15b[ level.var_bdaf1d69422ab15b.size ] = model;
    return model;
}

// Namespace zombie_mimic_prop_spawn
// Params 0
// Checksum 0x829aa22e, Offset: 0x1819
// Size: 0x5b
function on_prop_deleted()
{
    if ( isdefined( self.spawn_loc ) )
    {
        self.spawn_loc.claimed = undefined;
    }
    
    if ( isdefined( self.var_52aee7937d5ee2d6 ) )
    {
        self.var_52aee7937d5ee2d6 delete();
    }
    
    if ( isent( self.prop_linked_ent ) )
    {
        self.prop_linked_ent show();
    }
}

// Namespace zombie_mimic_prop_spawn
// Params 1
// Checksum 0x10c8f338, Offset: 0x187c
// Size: 0x54
function function_3d3b310d86c29df7( entity )
{
    can_spawn_props = can_spawn_props( 1, entity );
    
    if ( can_spawn_props && !arraycontains( level.var_c79ae97e80404ba5, entity ) )
    {
        level.var_c79ae97e80404ba5[ level.var_c79ae97e80404ba5.size ] = entity;
    }
    
    return can_spawn_props;
}

// Namespace zombie_mimic_prop_spawn
// Params 1
// Checksum 0xe17cc67b, Offset: 0x18d9
// Size: 0x24
function function_e51a7d37ed94f968( entity )
{
    level.var_c79ae97e80404ba5 = arrayremove( level.var_c79ae97e80404ba5, entity );
}

// Namespace zombie_mimic_prop_spawn
// Params 3
// Checksum 0xb5139fe9, Offset: 0x1905
// Size: 0x1ab
function setup_trap_prop( prop, var_82209d06b3fad29d, var_dee0b274f8baa38a = &function_284333c6441018ff )
{
    prop.is_trap_prop = 1;
    prop.var_8416c4f108867070 = getclosestpointonnavmesh( prop.origin );
    
    if ( isdefined( prop.var_8416c4f108867070 ) )
    {
        if ( abs( prop.origin[ 2 ] - prop.var_8416c4f108867070[ 2 ] ) > 64 )
        {
            prop.var_8416c4f108867070 = undefined;
        }
        
        if ( isdefined( prop.var_8416c4f108867070 ) && prop.var_626ff4de8bf51f24 )
        {
            prop thread function_af868309a8575918();
        }
    }
    
    prop thread function_e08eac7d6eb48fd2( var_dee0b274f8baa38a );
    
    if ( !isdefined( prop.var_c47c1baf88389769 ) )
    {
        prop thread function_b6e1ed9002aaa051();
        prop val::reset( "mimic_spawn", "hide" );
    }
    
    if ( isdefined( prop.var_52aee7937d5ee2d6 ) )
    {
        prop thread function_b6e1ed9002aaa051( prop.var_52aee7937d5ee2d6 );
    }
    
    if ( prop.var_626ff4de8bf51f24 )
    {
        prop solid();
    }
    
    if ( isdefined( prop.var_73ef38c940c391ef ) )
    {
        level thread spawn_lure_model( prop );
    }
    
    if ( isdefined( prop.item_scriptable_name ) && !isdefined( prop.var_34cdd5cda21b2ad1 ) )
    {
        prop.var_34cdd5cda21b2ad1 = spawnscriptable( prop.item_scriptable_name, prop.origin, prop.angles );
        prop.var_34cdd5cda21b2ad1.disable = 1;
    }
}

// Namespace zombie_mimic_prop_spawn
// Params 0
// Checksum 0x28c2af07, Offset: 0x1ab8
// Size: 0x4b
function function_af868309a8575918()
{
    self endon( #"death_or_disconnect" );
    wait 1;
    
    if ( isdefined( self ) )
    {
        v_forward = anglestoforward( self.angles ) * 8;
        self.var_8416c4f108867070 = getclosestpointonnavmesh( self.var_8416c4f108867070 + v_forward );
    }
}

// Namespace zombie_mimic_prop_spawn
// Params 1
// Checksum 0x33cf8856, Offset: 0x1b0b
// Size: 0xca
function spawn_lure_model( prop )
{
    a_points = getrandomnavpoints( prop.origin, 48, 12 );
    
    if ( a_points.size == 0 )
    {
        return;
    }
    
    if ( isdefined( level.var_9ae4002dd7cfdc5d ) )
    {
        loc = [[ level.var_9ae4002dd7cfdc5d ]]( prop.origin, a_points );
    }
    else
    {
        loc = utility::array_random( a_points );
    }
    
    if ( !isdefined( loc ) )
    {
        return;
    }
    
    v_spawn_loc = utility::groundpos( loc, 32 );
    var_75fbfc91c172c98e = utility::spawn_model( prop.var_73ef38c940c391ef, v_spawn_loc, ( 0, 0, 0 ) );
    
    if ( isdefined( var_75fbfc91c172c98e ) )
    {
        prop.var_75fbfc91c172c98e = var_75fbfc91c172c98e;
    }
}

// Namespace zombie_mimic_prop_spawn
// Params 4
// Checksum 0xc81ac8f9, Offset: 0x1bdd
// Size: 0x80
function function_2e6c79373f411ab( mimic, var_b1f3dccf5a1b9bb7, var_82209d06b3fad29d, reveal_condition_func )
{
    assert( arraycontains( var_82209d06b3fad29d, var_b1f3dccf5a1b9bb7 ), "<dev string:x24>" );
    var_b1f3dccf5a1b9bb7.var_82209d06b3fad29d = var_82209d06b3fad29d;
    
    if ( isdefined( mimic ) )
    {
        function_a4dc66049af27342( mimic, var_b1f3dccf5a1b9bb7 );
        
        if ( isdefined( mimic.reveal_condition_func ) )
        {
            reveal_condition_func = mimic.reveal_condition_func;
        }
    }
    
    setup_trap_prop( var_b1f3dccf5a1b9bb7, var_82209d06b3fad29d, reveal_condition_func );
}

// Namespace zombie_mimic_prop_spawn
// Params 2
// Checksum 0x84ee8e85, Offset: 0x1c65
// Size: 0x4a
function function_8939c433088c0f10( origin, num_points )
{
    if ( !isdefined( origin ) )
    {
        return [];
    }
    
    spawn_points = utility::function_4cf0c9c46de1da7d( origin, num_points * 2, 50, 1000, 0 );
    spawn_points = function_3de5f95ec64e2ca( spawn_points, num_points );
    return spawn_points;
}

// Namespace zombie_mimic_prop_spawn
// Params 2
// Checksum 0x80cab88f, Offset: 0x1cb8
// Size: 0xdc
function function_3de5f95ec64e2ca( points, num )
{
    var_32ddd74997c5712 = [];
    var_559051b4bd85e4ec = function_5713d46873b29625( level.var_bdaf1d69422ab15b );
    
    foreach ( point in points )
    {
        if ( utility::get_array_of_closest( point.origin, var_559051b4bd85e4ec, undefined, undefined, 32 ).size > 0 )
        {
            continue;
        }
        
        var_32ddd74997c5712[ var_32ddd74997c5712.size ] = point;
        var_559051b4bd85e4ec[ var_559051b4bd85e4ec.size ] = point;
        
        if ( var_32ddd74997c5712.size >= num )
        {
            break;
        }
    }
    
    return var_32ddd74997c5712;
}

// Namespace zombie_mimic_prop_spawn
// Params 1
// Checksum 0x87b49e4d, Offset: 0x1d9d
// Size: 0x576
function function_284333c6441018ff( var_4bb18a854633e0cc )
{
    if ( !isdefined( self.var_a3ef75fffe785f40 ) )
    {
        self.var_a3ef75fffe785f40 = -1;
    }
    
    var_39bb09f75156b5bf = -1;
    var_5cd76d50b8075eb8 = 1;
    
    if ( isdefined( self.var_71c219f2ccf139c0 ) )
    {
        foreach ( entity in self.var_71c219f2ccf139c0 )
        {
            if ( entity.var_95d7a6c4a8f4d254 )
            {
                var_39bb09f75156b5bf = 0;
            }
            else if ( isdefined( entity.var_be7d65cc226b7bb5 ) )
            {
                var_39bb09f75156b5bf = entity.var_be7d65cc226b7bb5;
            }
            
            if ( isdefined( entity.var_4fde6a8624b2abf0 ) )
            {
                var_5cd76d50b8075eb8 = entity.var_4fde6a8624b2abf0;
            }
        }
    }
    
    /#
        if ( getdvarint( @"hash_821690ed248715f7", 0 ) )
        {
            box( self.origin, 0, ( 1, 0, 0 ), 1, 1 );
            sphere( self.origin + level.var_8cae4ac35bfedc51, 10, ( 1, 0, 0 ), 1, 1 );
            line( self.origin, self.origin + level.var_8cae4ac35bfedc51, ( 1, 0, 0 ), 1, 1, 1 );
        }
    #/
    
    players = namespace_9d8e359c3b1041e5::getplayersinradiussharedfunc( self.origin, var_4bb18a854633e0cc ?? level.var_94767e4d2b626bdc );
    
    if ( players.size )
    {
        foreach ( player in players )
        {
            if ( !isalive( player ) )
            {
                continue;
            }
            
            if ( player.ignoreme || player.inlaststand || player.notarget || player.aether_shroud_active )
            {
                continue;
            }
            
            /#
                if ( getdvarint( @"hash_821690ed248715f7", 0 ) )
                {
                    sphere( player.origin, 20, ( 0, 1, 0 ), 0, 1 );
                }
            #/
            
            if ( isdefined( player.last_valid_position ) && isdefined( self.var_8416c4f108867070 ) )
            {
                if ( !trace::ray_trace_passed( player.last_valid_position, self.var_8416c4f108867070 + ( 0, 0, 16 ), [ self, self.var_52aee7937d5ee2d6 ], trace::create_default_contents( 1 ) ) )
                {
                    /#
                        if ( getdvarint( @"hash_821690ed248715f7", 0 ) )
                        {
                            line( player.last_valid_position, self.var_8416c4f108867070 + ( 0, 0, 16 ), ( 0, 1, 1 ), 1, 0, 1 );
                            sphere( self.var_8416c4f108867070, 20, ( 1, 0, 0 ), 0, 1 );
                        }
                    #/
                    
                    continue;
                }
            }
            else
            {
                var_82f0fb6dc1c89261 = player gettagorigin( "j_spine4" );
                
                if ( !isdefined( var_82f0fb6dc1c89261 ) )
                {
                    var_82f0fb6dc1c89261 = player getcentroid();
                }
                
                if ( isdefined( var_82f0fb6dc1c89261 ) && !sighttracepassed( self.origin + level.var_8cae4ac35bfedc51, var_82f0fb6dc1c89261, 0, self ) )
                {
                    /#
                        if ( getdvarint( @"hash_821690ed248715f7", 0 ) )
                        {
                            line( self.origin + level.var_8cae4ac35bfedc51, player gettagorigin( "<dev string:x4a>" ), ( 1, 1, 0 ), 1, 0, 1 );
                        }
                    #/
                    
                    continue;
                }
            }
            
            if ( var_5cd76d50b8075eb8 )
            {
                traceresult = playerphysicstrace( self.origin + ( 0, 0, 20 ), player.origin + ( 0, 0, 36 ), player, undefined, self, 1 );
                
                if ( traceresult[ "fraction" ] < 1 )
                {
                    /#
                        if ( getdvarint( @"hash_821690ed248715f7", 0 ) )
                        {
                            line( self.origin + ( 0, 0, 8 ), player.origin + ( 0, 0, 8 ), ( 1, 0, 0 ), 1, 0, 1 );
                            sphere( traceresult[ "<dev string:x53>" ], 4, ( 1, 0, 0 ), 0, 1 );
                        }
                    #/
                    
                    continue;
                }
            }
            
            if ( var_39bb09f75156b5bf >= 0 )
            {
                if ( utility::within_fov( player geteye(), player getplayerangles(), self.origin, cos( 45 ) ) )
                {
                    if ( self.var_a3ef75fffe785f40 < 0 )
                    {
                        self.var_a3ef75fffe785f40 = 0;
                    }
                    
                    self.var_a3ef75fffe785f40 += level.framedurationseconds;
                }
                else
                {
                    self.var_a3ef75fffe785f40 = -1;
                }
                
                if ( self.var_a3ef75fffe785f40 < var_39bb09f75156b5bf )
                {
                    continue;
                }
            }
            
            self notify( #"stop_shake_tell" );
            return player;
        }
    }
}

// Namespace zombie_mimic_prop_spawn
// Params 0
// Checksum 0x74cc7627, Offset: 0x231b
// Size: 0xa0, Type: bool
function function_828ba10e528c6aec()
{
    if ( self.var_39ce2fee55797172 )
    {
        return true;
    }
    
    if ( isdefined( self.var_71c219f2ccf139c0 ) )
    {
        foreach ( entity in self.var_71c219f2ccf139c0 )
        {
            if ( entity.var_39ce2fee55797172 )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace zombie_mimic_prop_spawn
// Params 1
// Checksum 0x7ca4fe92, Offset: 0x23c4
// Size: 0xe9
function function_e08eac7d6eb48fd2( var_dee0b274f8baa38a )
{
    self endon( #"death" );
    self endon( #"damage_transform" );
    self endon( #"normal_transform" );
    level endon( #"game_ended" );
    
    if ( !isdefined( level.mimic_trap_prop_throttle ) )
    {
        level.mimic_trap_prop_throttle = throttle::throttle_initialize( "mimic_trap_prop", 1 );
    }
    
    while ( true )
    {
        throttle::throttle_wait_in_queue( level.mimic_trap_prop_throttle, self );
        
        if ( function_828ba10e528c6aec() )
        {
            continue;
        }
        
        activator = self [[ var_dee0b274f8baa38a ]]();
        
        if ( isdefined( activator ) )
        {
            var_ea8a8c50c7c7f096 = [ activator ];
            
            if ( self.health > 0 )
            {
                function_cf8c7294325e9516( self, level.var_f9c0de15cbc254d4, 0.05, 8 );
            }
            
            level thread function_b8a2fee812bf9ede( self, var_ea8a8c50c7c7f096 );
            self notify( #"normal_transform" );
            return;
        }
    }
}

// Namespace zombie_mimic_prop_spawn
// Params 0
// Checksum 0x167a8ede, Offset: 0x24b5
// Size: 0x88
function function_2b026b1a229d8a04()
{
    self.var_b4af7a3c497b8c72 = 1;
    self.original_angles = self.angles;
    
    while ( true )
    {
        result = utility::waittill_any_timeout( 2, "death", "stop_shake_tell" );
        
        if ( result != "timeout" )
        {
            break;
        }
        
        function_cf8c7294325e9516( self, 0.75, 0.05, 2 );
    }
    
    if ( isdefined( self ) )
    {
        self.angles = self.original_angles;
        self.var_b4af7a3c497b8c72 = undefined;
    }
}

// Namespace zombie_mimic_prop_spawn
// Params 4
// Checksum 0x69152f78, Offset: 0x2545
// Size: 0xcf
function function_cf8c7294325e9516( var_b1f3dccf5a1b9bb7, total_time, var_4ee6baf1063a4e93, angle )
{
    original_angles = var_b1f3dccf5a1b9bb7.angles;
    iterations = total_time / var_4ee6baf1063a4e93;
    var_b46b4b0e9ef4742c = var_b1f3dccf5a1b9bb7.angles[ 2 ];
    var_5ab0a355db2f214e = angle;
    playsoundatpos( var_b1f3dccf5a1b9bb7.origin + ( 0, 0, 50 ), "evt_mimic_prop_rattle" );
    
    for ( i = 0; i < iterations ; i++ )
    {
        var_b1f3dccf5a1b9bb7 rotateroll( var_b46b4b0e9ef4742c + var_5ab0a355db2f214e, var_4ee6baf1063a4e93 );
        var_5ab0a355db2f214e *= -1;
        wait var_4ee6baf1063a4e93;
    }
    
    var_b1f3dccf5a1b9bb7.angles = original_angles;
}

// Namespace zombie_mimic_prop_spawn
// Params 1
// Checksum 0xdebe9afa, Offset: 0x261c
// Size: 0x13f
function function_b6e1ed9002aaa051( damaged_ent )
{
    self endon( #"death" );
    self endon( #"normal_transform" );
    level endon( #"game_ended" );
    
    if ( !isdefined( damaged_ent ) )
    {
        damaged_ent = self;
    }
    
    damaged_ent.health = self.var_47408019f3d23ca3 ?? 50000;
    damaged_ent setcandamage( 1 );
    self.var_a32d8a873fd3ee6c = 0;
    self.last_damage_time = 0;
    
    while ( true )
    {
        damaged_ent waittill( #"damage", idamage, eattacker );
        
        if ( function_828ba10e528c6aec() || !isplayer( eattacker ) )
        {
            continue;
        }
        
        if ( gettime() - self.last_damage_time > level.var_83264e2a7e28fd81 * 1000 )
        {
            self.var_a32d8a873fd3ee6c = 0;
        }
        
        self.var_a32d8a873fd3ee6c += idamage;
        self.last_damage_time = gettime();
        
        if ( self.var_a32d8a873fd3ee6c >= level.var_5f10511273162163 )
        {
            self notify( #"damage_transform" );
            function_b8a2fee812bf9ede( self, [ eattacker ], "damaged" );
            break;
        }
    }
    
    damaged_ent setcandamage( 0 );
}

// Namespace zombie_mimic_prop_spawn
// Params 1
// Checksum 0x71d75b1c, Offset: 0x2763
// Size: 0x8d
function function_5327a1cc6ff13535( var_3f9dae2e14cef497 )
{
    self endon( #"death" );
    var_3f9dae2e14cef497 endon( #"death" );
    level endon( #"game_ended" );
    self.health = var_3f9dae2e14cef497.health;
    self setcandamage( 1 );
    
    while ( isdefined( self ) )
    {
        self waittill( #"damage", idamage, eattacker );
        var_3f9dae2e14cef497 dodamage( idamage, var_3f9dae2e14cef497.origin, eattacker );
    }
}

// Namespace zombie_mimic_prop_spawn
// Params 2
// Checksum 0xe63ba917, Offset: 0x27f8
// Size: 0x53
function setup_revealed_ai( var_b1f3dccf5a1b9bb7, mimic )
{
    mimic.var_ccff365714afac79 = gettime();
    params = spawnstruct();
    params.zombie = mimic;
    mimic callback::callback( "setup_revealed_ai", params );
}

// Namespace zombie_mimic_prop_spawn
// Params 3
// Checksum 0xc04ccc97, Offset: 0x2853
// Size: 0x3a6
function function_b8a2fee812bf9ede( prop, var_ea8a8c50c7c7f096, var_e67b929c9afaae3b )
{
    if ( isdefined( prop.mimic_transform_start ) )
    {
        [[ prop.mimic_transform_start ]]( prop );
        prop.mimic_transform_start = undefined;
    }
    
    var_a877d7c4fa845011 = spawnstruct();
    var_a877d7c4fa845011.var_ea8a8c50c7c7f096 = var_ea8a8c50c7c7f096;
    var_a877d7c4fa845011.var_e67b929c9afaae3b = var_e67b929c9afaae3b;
    
    if ( isdefined( prop.var_71c219f2ccf139c0 ) )
    {
        prop.var_71c219f2ccf139c0 = function_5713d46873b29625( prop.var_71c219f2ccf139c0 );
        
        foreach ( entity in prop.var_71c219f2ccf139c0 )
        {
            setup_revealed_ai( prop, entity );
            entity callback::callback( "on_entity_revealed", var_a877d7c4fa845011 );
            entity zombie_mimic_medal::function_eebb37610fa6d82f();
        }
    }
    else
    {
        var_125301da917ada8a = namespace_9d8e359c3b1041e5::getfreeaicount_sharedfunc() > 0;
        
        if ( !var_125301da917ada8a && isdefined( level.var_e040334d54228edf ) && [[ level.var_e040334d54228edf ]]() )
        {
            var_125301da917ada8a = 1;
        }
        
        if ( var_125301da917ada8a )
        {
            assert( isdefined( level.var_35b49e9ab3037480 ) );
            var_215a10e5098417ea = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( level.var_35b49e9ab3037480, prop.origin, prop.angles, prop.team );
            
            if ( isdefined( var_215a10e5098417ea ) )
            {
                var_215a10e5098417ea.var_a13bed1ac47e1b2c = prop.var_a13bed1ac47e1b2c;
                var_215a10e5098417ea.no_powerups = prop.no_powerups;
                var_215a10e5098417ea.var_46b1f5d89aec84a9 = prop.var_46b1f5d89aec84a9;
                var_215a10e5098417ea.ignore_enemy_count = prop.ignore_enemy_count;
                var_215a10e5098417ea.var_f895c28d17024434 = prop.var_f895c28d17024434;
                var_215a10e5098417ea.var_50c96a5c56dab386 = prop.var_50c96a5c56dab386;
                var_215a10e5098417ea.var_15598d8e493afe88 = prop.var_15598d8e493afe88;
                var_215a10e5098417ea.var_2dfd8b4c56744f49 = prop.var_2dfd8b4c56744f49;
                function_a4dc66049af27342( var_215a10e5098417ea, prop );
                setup_revealed_ai( prop, var_215a10e5098417ea );
                waitframe();
                
                if ( isdefined( var_215a10e5098417ea ) )
                {
                    var_215a10e5098417ea callback::callback( "on_entity_revealed", var_a877d7c4fa845011 );
                    var_215a10e5098417ea zombie_mimic_medal::function_eebb37610fa6d82f();
                }
            }
        }
        else
        {
            println( "<dev string:x5c>" );
        }
    }
    
    if ( !isdefined( prop ) )
    {
        return;
    }
    
    playfx( utility::getfx( "mimic_prop_rattle_fx" ), prop.origin + ( 0, 0, 16 ) );
    prop.var_71c219f2ccf139c0 = undefined;
    
    if ( !isdefined( prop.var_c47c1baf88389769 ) )
    {
        prop val::set( "mimic_spawn", "hide", 1 );
        prop notsolid();
    }
    
    if ( isdefined( prop.navobstacle ) )
    {
        destroynavobstacle( prop.navobstacle );
        prop.navobstacle = undefined;
    }
    
    if ( isdefined( prop.var_75fbfc91c172c98e ) )
    {
        prop.var_75fbfc91c172c98e delete();
        prop.var_75fbfc91c172c98e = undefined;
    }
    
    if ( isdefined( prop.var_34cdd5cda21b2ad1 ) )
    {
        prop.var_34cdd5cda21b2ad1 freescriptable();
        prop.var_34cdd5cda21b2ad1 = undefined;
    }
}

// Namespace zombie_mimic_prop_spawn
// Params 2
// Checksum 0x269e2c94, Offset: 0x2c01
// Size: 0x145
function function_a4dc66049af27342( entity, prop )
{
    assert( !entity.hidden_in_prop, "<dev string:x84>" );
    
    if ( !isdefined( entity.var_82209d06b3fad29d ) )
    {
        entity callback::add( #"on_ai_killed", &function_d9c968f581c5ea5c );
    }
    
    entity.hidden_in_prop = 1;
    entity.var_b1f3dccf5a1b9bb7 = prop;
    entity.b_skip_spawn_anim = 1;
    entity.var_82209d06b3fad29d = prop.var_82209d06b3fad29d;
    
    if ( isdefined( prop.var_34cdd5cda21b2ad1 ) )
    {
        entity zombie_mimic_medal::function_cb6aaffca1a53fd8();
    }
    
    entity hide();
    entity setsolid( 0 );
    entity dontinterpolate();
    entity forceteleport( prop.origin, prop.angles );
    params = spawnstruct();
    params.prop = prop;
    entity callback::callback( "on_entity_hidden_in_prop", params );
    
    if ( !isdefined( prop.var_71c219f2ccf139c0 ) )
    {
        prop.var_71c219f2ccf139c0 = [];
    }
    
    prop.var_71c219f2ccf139c0[ prop.var_71c219f2ccf139c0.size ] = entity;
}

// Namespace zombie_mimic_prop_spawn
// Params 1
// Checksum 0x37b9ab52, Offset: 0x2d4e
// Size: 0xb9
function function_d9c968f581c5ea5c( params )
{
    self.var_82209d06b3fad29d = function_5713d46873b29625( self.var_82209d06b3fad29d );
    
    foreach ( prop in self.var_82209d06b3fad29d )
    {
        if ( isdefined( prop.var_8aa77779eb1a5e0b ) )
        {
            [[ prop.var_8aa77779eb1a5e0b ]]();
        }
        
        level thread function_c727c09ec08aed83( prop );
    }
}

// Namespace zombie_mimic_prop_spawn
// Params 2
// Checksum 0x93ea3ff3, Offset: 0x2e0f
// Size: 0x224
function function_c727c09ec08aed83( prop, var_44fcb185a56b5356 )
{
    if ( !isdefined( prop ) )
    {
        return;
    }
    
    level endon( #"game_ended" );
    prop endon( #"death" );
    
    if ( isdefined( prop.var_71c219f2ccf139c0 ) )
    {
        foreach ( var_2ffcdb46889d1294 in prop.var_71c219f2ccf139c0 )
        {
            if ( isdefined( var_2ffcdb46889d1294 ) )
            {
                var_2ffcdb46889d1294 kill();
            }
        }
    }
    
    level.var_bdaf1d69422ab15b = arrayremove( level.var_bdaf1d69422ab15b, prop );
    level.mimic_trap_props = arrayremove( level.mimic_trap_props, prop );
    
    if ( isdefined( prop.mimic_transform_start ) )
    {
        [[ prop.mimic_transform_start ]]( prop );
        prop.mimic_transform_start = undefined;
    }
    
    prop notify( #"hash_fcfe4302fe1691b6" );
    
    if ( isdefined( prop.origin ) && ( var_44fcb185a56b5356 ?? 1 ) )
    {
        playfx( utility::getfx( "mimic_prop_spawn_out_fx" ), prop.origin );
        playsoundatpos( prop.origin + ( 0, 0, 16 ), "evt_mimic_prop_hide" );
    }
    
    if ( isdefined( prop.var_c47c1baf88389769 ) )
    {
        return;
    }
    
    wait 0.5;
    
    if ( isdefined( prop.var_75fbfc91c172c98e ) )
    {
        prop.var_75fbfc91c172c98e delete();
        prop.var_75fbfc91c172c98e = undefined;
    }
    
    if ( isdefined( prop.var_34cdd5cda21b2ad1 ) )
    {
        prop.var_34cdd5cda21b2ad1 freescriptable();
        prop.var_34cdd5cda21b2ad1 = undefined;
    }
    
    if ( isdefined( prop.navobstacle ) )
    {
        destroynavobstacle( prop.navobstacle );
        prop.navobstacle = undefined;
    }
    
    if ( isdefined( prop ) )
    {
        prop delete();
    }
}

// Namespace zombie_mimic_prop_spawn
// Params 0
// Checksum 0xd296631d, Offset: 0x303b
// Size: 0x82
function function_fc9d2a064d586b7()
{
    foreach ( prop in level.var_bdaf1d69422ab15b )
    {
        if ( isdefined( prop ) )
        {
            level thread function_c727c09ec08aed83( prop );
        }
    }
}

// Namespace zombie_mimic_prop_spawn
// Params 3
// Checksum 0x851cc0e0, Offset: 0x30c5
// Size: 0x7f
function function_e38030e0f56f312b( type, handler, var_b1b868a4e6037838 )
{
    if ( !isdefined( level.var_b45db6e1ed3b4f06 ) )
    {
        level.var_b45db6e1ed3b4f06 = [];
    }
    
    if ( isdefined( level.var_b45db6e1ed3b4f06[ type ] ) )
    {
        return;
    }
    
    struct = spawnstruct();
    struct.handler = handler;
    struct.var_b1b868a4e6037838 = var_b1b868a4e6037838;
    level.var_b45db6e1ed3b4f06[ type ] = struct;
}

// Namespace zombie_mimic_prop_spawn
// Params 1
// Checksum 0x881fc72f, Offset: 0x314c
// Size: 0x88
function function_931cd02a834f49f7( var_10ceb6b70c29c3b9 )
{
    interact = var_10ceb6b70c29c3b9.interact;
    interact.prop = var_10ceb6b70c29c3b9;
    var_10ceb6b70c29c3b9.var_9333a5670fd3babd = interact.var_d8e3b07237845727;
    var_10ceb6b70c29c3b9.mimic_transform_start = &function_2947dfeb91923ede;
    interact.var_d8e3b07237845727 = [ &mimic_interact_activate ];
    var_10ceb6b70c29c3b9 thread function_e013da446f4ffdbf();
    return [ var_10ceb6b70c29c3b9, &reveal_on_activate ];
}

// Namespace zombie_mimic_prop_spawn
// Params 1
// Checksum 0xf2c745aa, Offset: 0x31dd
// Size: 0x68
function function_fd46d381d3c3c5bf( var_e90b611bc05b4adf )
{
    if ( !isdefined( var_e90b611bc05b4adf ) )
    {
        return;
    }
    
    var_b1f3dccf5a1b9bb7 = var_e90b611bc05b4adf.prop;
    var_b1f3dccf5a1b9bb7.spawn_loc = var_e90b611bc05b4adf;
    var_b1f3dccf5a1b9bb7.var_47408019f3d23ca3 = 5;
    var_b1f3dccf5a1b9bb7.mimic_transform_start = &function_2947dfeb91923ede;
    return [ var_b1f3dccf5a1b9bb7, &reveal_on_activate ];
}

// Namespace zombie_mimic_prop_spawn
// Params 1
// Checksum 0x407430c6, Offset: 0x324e
// Size: 0x84
function function_6fd93ef4b4edf515( var_b35e2b2169def6fa )
{
    if ( !isdefined( var_b35e2b2169def6fa ) )
    {
        return;
    }
    
    var_b1f3dccf5a1b9bb7 = var_b35e2b2169def6fa.prop;
    var_b1f3dccf5a1b9bb7.var_dcf8cc4067ac1c74 = 1;
    var_b1f3dccf5a1b9bb7.spawn_loc = var_b35e2b2169def6fa;
    var_b1f3dccf5a1b9bb7.var_fd99bc493499553c = 1;
    var_b1f3dccf5a1b9bb7.var_ac1d8531c74a2d17 = 1;
    var_b1f3dccf5a1b9bb7.mimic_transform_start = &function_335a153963e215ec;
    return [ var_b1f3dccf5a1b9bb7, &reveal_on_activate ];
}

// Namespace zombie_mimic_prop_spawn
// Params 1
// Checksum 0x4f457a6e, Offset: 0x32db
// Size: 0x23
function function_69fb7131b3e13b83( params )
{
    self notify( #"mimic_prop_activated", params.attacker );
}

// Namespace zombie_mimic_prop_spawn
// Params 1
// Checksum 0xf0d6639, Offset: 0x3306
// Size: 0x22
function mimic_interact_activate( player )
{
    self.prop notify( #"mimic_prop_activated", player );
}

// Namespace zombie_mimic_prop_spawn
// Params 1
// Checksum 0xdcc6663d, Offset: 0x3330
// Size: 0x24
function function_f363e1407f99a1e0( var_5a5626a7d4b2feb )
{
    self.var_dcf8cc4067ac1c74 = 0;
    self notify( #"mimic_prop_activated", var_5a5626a7d4b2feb );
}

// Namespace zombie_mimic_prop_spawn
// Params 1
// Checksum 0x5d14f600, Offset: 0x335c
// Size: 0x27
function reveal_on_activate( params )
{
    self waittill( #"mimic_prop_activated", activator );
    return activator;
}

// Namespace zombie_mimic_prop_spawn
// Params 1
// Checksum 0xae80918, Offset: 0x338c
// Size: 0x32
function function_2947dfeb91923ede( var_b1f3dccf5a1b9bb7 )
{
    if ( !isdefined( var_b1f3dccf5a1b9bb7.interact ) )
    {
        return;
    }
    
    level thread function_c47923c394858937( var_b1f3dccf5a1b9bb7.interact, var_b1f3dccf5a1b9bb7 );
}

// Namespace zombie_mimic_prop_spawn
// Params 2
// Checksum 0x839f820, Offset: 0x33c6
// Size: 0xa2
function function_c47923c394858937( interact, prop )
{
    level endon( #"game_ended" );
    interact endon( #"death" );
    interact val::set( "mimic_lure_transform", "hide", 1 );
    interact notsolid();
    interact connectpaths();
    prop waittill( #"hash_fcfe4302fe1691b6" );
    interact val::reset( "mimic_lure_transform", "hide" );
    interact solid();
    interact disconnectpaths();
    interact.var_d8e3b07237845727 = prop.var_9333a5670fd3babd;
    interact.prop = undefined;
}

// Namespace zombie_mimic_prop_spawn
// Params 6
// Checksum 0x8d33b527, Offset: 0x3470
// Size: 0xad
function function_4562257262b19ce9( item, part, state, player, autouse, usestring )
{
    if ( item.mimic_prop && !item.mimic_prop.mimic_spawned )
    {
        item.mimic_prop notify( #"damage_transform" );
        item.mimic_prop.mimic_spawned = 1;
        function_b8a2fee812bf9ede( item.mimic_prop, [ player ], "used" );
    }
}

// Namespace zombie_mimic_prop_spawn
// Params 1
// Checksum 0xa21c26b1, Offset: 0x3525
// Size: 0x18
function function_335a153963e215ec( var_cf844282bb11d5ba )
{
    level thread function_b8d53a2ac79cbad7( var_cf844282bb11d5ba, 5 );
}

// Namespace zombie_mimic_prop_spawn
// Params 2
// Checksum 0x72a13ba2, Offset: 0x3545
// Size: 0x62
function function_b8d53a2ac79cbad7( vehicle, var_6f3336e642e405d8 )
{
    level endon( #"game_ended" );
    vehicle val::set( "mimic_lure_transform", "hide", 1 );
    vehicle notsolid();
    wait var_6f3336e642e405d8;
    
    if ( !isdefined( vehicle ) )
    {
        return;
    }
    
    vehicle val::reset( "mimic_lure_transform", "hide" );
    vehicle solid();
}

// Namespace zombie_mimic_prop_spawn
// Params 0
// Checksum 0xe6aaa90b, Offset: 0x35af
// Size: 0xad
function function_e663d7f5627a4977()
{
    foreach ( prop in level.mimic_trap_props )
    {
        if ( !isdefined( prop ) || prop val::get( "hide" ) )
        {
            continue;
        }
        
        level thread function_b8a2fee812bf9ede( prop, level.players );
        prop notify( #"normal_transform" );
    }
}

// Namespace zombie_mimic_prop_spawn
// Params 0
// Checksum 0x287439e3, Offset: 0x3664
// Size: 0x64
function function_e013da446f4ffdbf()
{
    level endon( #"game_ended" );
    self endon( #"mimic_prop_activated" );
    self endon( #"hash_fcfe4302fe1691b6" );
    wait 60;
    
    while ( true )
    {
        activator = self.interact function_284333c6441018ff();
        
        if ( isdefined( activator ) )
        {
            self notify( #"mimic_prop_activated", activator );
            return;
        }
        
        wait 1;
    }
}

/#

    // Namespace zombie_mimic_prop_spawn
    // Params 0
    // Checksum 0xc75d5f6, Offset: 0x36d0
    // Size: 0x1a4, Type: dev
    function function_92a855af75563ed()
    {
        devgui::function_9082edeb5db93280( "<dev string:xa2>" );
        devgui::add_devgui_func( "<dev string:xbe>", "<dev string:xce>", &function_f46f75103b60c186, 1 );
        devgui::add_devgui_func( "<dev string:xde>", "<dev string:xf1>", &function_64d132d13bc9b2f1, 1 );
        devgui::add_devgui_func( "<dev string:x104>", "<dev string:x11c>", &function_d1be7edce7824210, 1 );
        devgui::add_devgui_func( "<dev string:x134>", "<dev string:x150>", &function_6d34b0171cda05c0, 1 );
        devgui::add_devgui_func( "<dev string:x16f>", "<dev string:x18d>", &function_d8f2aeae9264be9b, 1 );
        devgui::add_devgui_func( "<dev string:x1ae>", "<dev string:x1bf>", &function_2e2535176290bf58 );
        devgui::add_devgui_func( "<dev string:x1d0>", "<dev string:x1f1>", &function_dd9195d8809d716 );
        devgui::add_devgui_func( "<dev string:x20c>", "<dev string:x227>", &function_1b7b43e451007ce7, 1 );
        devgui::add_devgui_func( "<dev string:x23b>", "<dev string:x255>", &function_32b4a8ec9578da84, 1 );
        devgui::add_devgui_func( "<dev string:x268>", "<dev string:x28f>", &function_37d468e13efe1896 );
        devgui::add_devgui_func( "<dev string:x2b1>", "<dev string:x2c3>", &function_6144175fbc502e58 );
        devgui::add_devgui_func( "<dev string:x2d6>", "<dev string:x2e9>", &function_fc9d2a064d586b7 );
        devgui::add_devgui_func( "<dev string:x2fc>", "<dev string:x311>", &function_e663d7f5627a4977 );
        devgui::add_devgui_func( "<dev string:x326>", "<dev string:x343>", &function_570ad6681426cbb );
        devgui::add_devgui_func( "<dev string:x355>", "<dev string:x367>", &function_24af61585a59ba85 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x379>", "<dev string:x397>", &function_ea19cc8c0094753a );
        devgui::function_cd4e263c1f3018ae( "<dev string:x3bc>", "<dev string:x3d7>", &function_ea19cc8c0094753a );
        devgui::function_77df7fe7dd273e10();
        level thread function_e3699bbf777cfbc5();
    }

    // Namespace zombie_mimic_prop_spawn
    // Params 0
    // Checksum 0x4f1dfa68, Offset: 0x387c
    // Size: 0x15a, Type: dev
    function function_e3699bbf777cfbc5()
    {
        level endon( #"game_ended" );
        var_b0dd18e3624806d7 = [];
        
        foreach ( point in level.var_8ab41ebe366796e5 )
        {
            if ( isdefined( point.scriptbundlename ) && !arraycontains( var_b0dd18e3624806d7, point.scriptbundlename ) )
            {
                var_b0dd18e3624806d7[ var_b0dd18e3624806d7.size ] = point.scriptbundlename;
            }
        }
        
        if ( !var_b0dd18e3624806d7.size )
        {
            return;
        }
        
        devgui::function_9082edeb5db93280( "<dev string:x403>" );
        
        foreach ( name in var_b0dd18e3624806d7 )
        {
            devgui::function_cd4e263c1f3018ae( name, "<dev string:x429>" + name, &function_a95903e9a1affcc );
        }
        
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_mimic_prop_spawn
    // Params 1
    // Checksum 0xcbd89352, Offset: 0x39de
    // Size: 0x1b, Type: dev
    function function_a95903e9a1affcc( params )
    {
        level.var_e7915e436bf5443d = params[ 0 ];
    }

    // Namespace zombie_mimic_prop_spawn
    // Params 1
    // Checksum 0x6a26d83f, Offset: 0x3a01
    // Size: 0x46, Type: dev
    function function_ea19cc8c0094753a( params )
    {
        dvar_name = hashcat( @"scr_", params[ 0 ] );
        dvar_value = getdvarint( dvar_name, 0 );
        setdvar( dvar_name, !dvar_value );
    }

    // Namespace zombie_mimic_prop_spawn
    // Params 0
    // Checksum 0x549e3bc5, Offset: 0x3a4f
    // Size: 0x12f, Type: dev
    function function_f46f75103b60c186()
    {
        while ( true )
        {
            foreach ( var_b1f3dccf5a1b9bb7 in level.mimic_trap_props )
            {
                if ( !isdefined( var_b1f3dccf5a1b9bb7 ) )
                {
                    continue;
                }
                
                color = var_b1f3dccf5a1b9bb7.var_39ce2fee55797172 ? ( 1, 0, 0 ) : ( 1, 1, 0 );
                debugstar( var_b1f3dccf5a1b9bb7.origin, color, 1 );
                line( var_b1f3dccf5a1b9bb7.origin, var_b1f3dccf5a1b9bb7.origin + ( 0, 0, 900 ), color );
                
                if ( var_b1f3dccf5a1b9bb7.var_39ce2fee55797172 )
                {
                    print3d( var_b1f3dccf5a1b9bb7.origin + ( 0, 0, 48 ), "<dev string:x43e>", color );
                }
            }
            
            waitframe();
        }
    }

    // Namespace zombie_mimic_prop_spawn
    // Params 0
    // Checksum 0x7e9d52be, Offset: 0x3b86
    // Size: 0xb6, Type: dev
    function function_64d132d13bc9b2f1()
    {
        while ( true )
        {
            foreach ( prop in level.var_bdaf1d69422ab15b )
            {
                if ( !isdefined( prop ) || prop.is_trap_prop )
                {
                    continue;
                }
                
                debugstar( prop.origin, ( 0, 1, 0 ), 1 );
            }
            
            waitframe();
        }
    }

    // Namespace zombie_mimic_prop_spawn
    // Params 0
    // Checksum 0xe4bc9125, Offset: 0x3c44
    // Size: 0x88, Type: dev
    function function_365ed20c8ad262b8()
    {
        waitframe();
        player = level.players[ 0 ];
        direction = player getplayerangles();
        direction_vec = anglestoforward( direction );
        eye = player geteye();
        scale = 2000;
        direction_vec = ( direction_vec[ 0 ] * scale, direction_vec[ 1 ] * scale, direction_vec[ 2 ] * scale );
        endposition = physicstrace( eye, eye + direction_vec );
        return endposition;
    }

    // Namespace zombie_mimic_prop_spawn
    // Params 0
    // Checksum 0x17bb505a, Offset: 0x3cd4
    // Size: 0x47, Type: dev
    function function_2e2535176290bf58()
    {
        position = function_365ed20c8ad262b8();
        spawn_points = function_8939c433088c0f10( position, 5 );
        
        if ( !spawn_points.size )
        {
            return;
        }
        
        function_93a8605debe833a4( spawn_points, undefined, undefined, level.var_e7915e436bf5443d );
    }

    // Namespace zombie_mimic_prop_spawn
    // Params 0
    // Checksum 0x3aa2666f, Offset: 0x3d23
    // Size: 0x1ca, Type: dev
    function function_1b7b43e451007ce7()
    {
        spawn_points = utility::getstructarray( "<dev string:x445>", "<dev string:x459>" );
        debug_draw_points = [];
        
        foreach ( point in spawn_points )
        {
            if ( distancesquared( point.origin, level.players[ 0 ].origin ) <= squared( 7000 ) )
            {
                debug_draw_points[ debug_draw_points.size ] = point;
                function_93a8605debe833a4( [ point ], undefined, undefined, point.proplist );
            }
        }
        
        while ( true )
        {
            foreach ( point in debug_draw_points )
            {
                if ( !isdefined( point ) )
                {
                    continue;
                }
                
                color = point.var_39ce2fee55797172 ? ( 1, 0, 0 ) : ( 1, 1, 0 );
                debugstar( point.origin, color, 1 );
                line( point.origin, point.origin + ( 0, 0, 900 ), color );
            }
            
            waitframe();
        }
    }

    // Namespace zombie_mimic_prop_spawn
    // Params 0
    // Checksum 0x1f3ce0e4, Offset: 0x3ef5
    // Size: 0x1af, Type: dev
    function function_32b4a8ec9578da84()
    {
        spawn_points = utility::getstructarray( "<dev string:x445>", "<dev string:x459>" );
        debug_draw_points = [];
        
        foreach ( point in spawn_points )
        {
            if ( distancesquared( point.origin, level.players[ 0 ].origin ) <= squared( 7000 ) )
            {
                debug_draw_points[ debug_draw_points.size ] = point;
            }
        }
        
        while ( true )
        {
            foreach ( point in debug_draw_points )
            {
                if ( !isdefined( point ) )
                {
                    continue;
                }
                
                color = point.var_39ce2fee55797172 ? ( 1, 0, 0 ) : ( 1, 1, 0 );
                debugstar( point.origin, color, 1 );
                line( point.origin, point.origin + ( 0, 0, 900 ), color );
            }
            
            waitframe();
        }
    }

    // Namespace zombie_mimic_prop_spawn
    // Params 0
    // Checksum 0xb0df9bcb, Offset: 0x40ac
    // Size: 0x24, Type: dev
    function function_dd9195d8809d716()
    {
        position = function_365ed20c8ad262b8();
        function_c6b4aadecefb2d63( position, undefined, undefined, 3 );
    }

    // Namespace zombie_mimic_prop_spawn
    // Params 0
    // Checksum 0x8da78cf1, Offset: 0x40d8
    // Size: 0x24, Type: dev
    function function_37d468e13efe1896()
    {
        position = function_365ed20c8ad262b8();
        function_c6b4aadecefb2d63( position, undefined, undefined, 1 );
    }

    // Namespace zombie_mimic_prop_spawn
    // Params 0
    // Checksum 0xeef1345c, Offset: 0x4104
    // Size: 0x6e, Type: dev
    function function_6144175fbc502e58()
    {
        mimic = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x46b>" );
        
        if ( !isdefined( mimic ) )
        {
            mimic = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x478>" );
        }
        
        if ( isdefined( mimic ) )
        {
            mimic function_786bb6aa1b76c7ee( "<dev string:x489>", 1 );
        }
    }

    // Namespace zombie_mimic_prop_spawn
    // Params 0
    // Checksum 0xae41076f, Offset: 0x417a
    // Size: 0x6e, Type: dev
    function function_24af61585a59ba85()
    {
        mimic = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x46b>" );
        
        if ( !isdefined( mimic ) )
        {
            mimic = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x478>" );
        }
        
        if ( isdefined( mimic ) )
        {
            mimic function_786bb6aa1b76c7ee( "<dev string:x495>", 1 );
        }
    }

    // Namespace zombie_mimic_prop_spawn
    // Params 0
    // Checksum 0x9dd72ca0, Offset: 0x41f0
    // Size: 0x9f, Type: dev
    function function_d1be7edce7824210()
    {
        while ( true )
        {
            foreach ( point in level.var_8ab41ebe366796e5 )
            {
                debugstar( point.origin, ( 1, 0, 0 ), 20 );
            }
            
            wait 1;
        }
    }

    // Namespace zombie_mimic_prop_spawn
    // Params 0
    // Checksum 0xf24d6958, Offset: 0x4297
    // Size: 0xe9, Type: dev
    function function_6d34b0171cda05c0()
    {
        while ( true )
        {
            foreach ( point in level.var_8ab41ebe366796e5 )
            {
                if ( isdefined( point.var_c47c1baf88389769 ) )
                {
                    debugstar( point.origin, ( 0, 1, 0 ), 100 );
                    line( point.origin, point.origin + ( 0, 0, 64 ), ( 0, 1, 0 ), 1, 0, 100 );
                }
            }
            
            wait 4;
        }
    }

    // Namespace zombie_mimic_prop_spawn
    // Params 0
    // Checksum 0x6289eef8, Offset: 0x4388
    // Size: 0xea, Type: dev
    function function_d8f2aeae9264be9b()
    {
        while ( true )
        {
            foreach ( point in level.var_8ab41ebe366796e5 )
            {
                if ( !isdefined( point.var_c47c1baf88389769 ) )
                {
                    debugstar( point.origin, ( 0, 0, 1 ), 100 );
                    line( point.origin, point.origin + ( 0, 0, 64 ), ( 0, 0, 1 ), 1, 0, 100 );
                }
            }
            
            wait 4;
        }
    }

    // Namespace zombie_mimic_prop_spawn
    // Params 0
    // Checksum 0x3067a38c, Offset: 0x447a
    // Size: 0x4e, Type: dev
    function function_570ad6681426cbb()
    {
        position = function_365ed20c8ad262b8();
        var_b019719ed237b270 = function_fa5388c8c0ccfc3c();
        
        if ( !var_b019719ed237b270.size )
        {
            return;
        }
        
        var_a2621f468b05d4c3 = function_47c86977a18df38b( var_b019719ed237b270, position );
        function_93a8605debe833a4( [ var_a2621f468b05d4c3 ] );
    }

    // Namespace zombie_mimic_prop_spawn
    // Params 0
    // Checksum 0x5a0275a8, Offset: 0x44d0
    // Size: 0xed, Type: dev
    function function_1f719c8b9873536c()
    {
        all_spawn_points = function_fa5388c8c0ccfc3c();
        all_spawn_points = arraycombine( level.var_8ab41ebe366796e5, all_spawn_points );
        waitframe();
        
        while ( true )
        {
            position = function_365ed20c8ad262b8();
            debugstar( position, ( 0, 1, 1 ), 100 );
            spawn_points = sortbydistance( all_spawn_points, position );
            
            foreach ( point in spawn_points )
            {
                info = validate_mimic_spawn_point( point );
                function_6c70ed35debb3997( info );
            }
            
            wait 5;
        }
    }

    // Namespace zombie_mimic_prop_spawn
    // Params 1, eflags: 0x4
    // Checksum 0x90847510, Offset: 0x45c5
    // Size: 0x146, Type: dev
    function private validate_mimic_spawn_point( point )
    {
        if ( isdefined( point.var_c47c1baf88389769 ) )
        {
            switch ( point.var_c47c1baf88389769 )
            {
                case 0:
                    var_98e2761316de945 = point.trigger.scriptmodel ?? point.scriptmodel;
                    point = var_98e2761316de945 ?? point;
                    break;
                case 1:
                    if ( isdefined( point.targetname ) && point.targetname == "<dev string:x4a4>" )
                    {
                        point = point.var_75385495715741fb;
                    }
                    
                    break;
                default:
                    break;
            }
            
            new_origin = point.origin;
        }
        else
        {
            new_origin = utility::groundpos( point.origin, 15 );
        }
        
        var_a5267b17515d2852 = spawnstruct();
        var_a5267b17515d2852.origin = new_origin;
        var_a5267b17515d2852.angles = point.angles;
        var_a5267b17515d2852.var_e6abb0cddd3d31d2 = [];
        var_96df850e9408366d = "<dev string:x4b3>";
        return var_a5267b17515d2852;
    }

    // Namespace zombie_mimic_prop_spawn
    // Params 1, eflags: 0x4
    // Checksum 0x2473f516, Offset: 0x4713
    // Size: 0x119, Type: dev
    function private function_6c70ed35debb3997( var_a5267b17515d2852 )
    {
        foreach ( var_e6abb0cddd3d31d2 in var_a5267b17515d2852.var_e6abb0cddd3d31d2 )
        {
            color = var_e6abb0cddd3d31d2.passed ? ( 0, 1, 0 ) : ( 1, 0, 0 );
            debugstar( var_e6abb0cddd3d31d2.grab_start_pos, color, 100 );
            line( var_e6abb0cddd3d31d2.grab_start_pos, var_e6abb0cddd3d31d2.grab_end_pos, color, 1, 0, 100 );
            line( var_e6abb0cddd3d31d2.var_75f155d51d27a992, var_e6abb0cddd3d31d2.grab_start_pos, ( 1, 0, 1 ), 1, 0, 100 );
        }
    }

#/
