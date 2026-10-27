// scripts\mp\common\field_upgrades\field_upgrades_toxic_growth.gsc  (hash_2d723e2f5feb672b.gscc) (size: 30106 Bytes / 0x759a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7e1c02d7 (2115764951)
// size ...... 30106 (0x759a)
// includes .. 26  (offset: 0x6ff6)
// strings ... 51  (offset: 0x70c6)
// dev strs .. 17  (offset: 0x74ca)
// exports ... 52  (offset: 0x4ce2)
// cseg ...... 0x40a + 0x48d8 (0x4ce2)
// imports ... 216 (offset: 0x5502)
// animtree1 . 0   (offset: 0x759a)
// animtree2 . 0   (offset: 0x759a)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai;
#using scripts\common\ai\ai_utility;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\bots\bots_util;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\scene;
#using scripts\common\status_effects\effect_charm;
#using scripts\common\status_effects\effect_slow;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\common\field_upgrades\field_upgrades;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\entityheadicons;
#using scripts\mp\loot\common_item;
#using scripts\mp\playerhealth;
#using scripts\mp\supers;

#namespace field_upgrades_toxic_growth;

// Namespace field_upgrades_toxic_growth
// Params 0, eflags: 0x5
// Checksum 0x8726694f, Offset: 0x428
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"toxic_growth", undefined, undefined, &init );
}

// Namespace field_upgrades_toxic_growth
// Params 0
// Checksum 0x73752019, Offset: 0x449
// Size: 0x1ff
function init()
{
    superbundle = field_upgrades::function_1fcc83f10e7752e5( "super_toxic_growth" );
    
    if ( !isdefined( superbundle ) )
    {
        return;
    }
    
    utility::flag_wait( "supers_initialized" );
    
    if ( !isdefined( level.var_80ec21e17cb08bce ) )
    {
        level.var_80ec21e17cb08bce = [];
    }
    
    supers_mp::function_48aaa60b2ce7b8a1( "super_toxic_growth", &set_toxic_growth, &unset_toxic_growth, &begin_use_toxic_growth, &function_543be607382d7fa3, undefined, &set_toxic_growth );
    utility::registersharedfunc( #"zm_toxic_growth", #"delete_toxic_growth", &delete_toxic_growth );
    level._effect[ "toxic_growth_aoe_explode" ] = loadfxasset( "vfx_sat_zm_gp_toxic_growth_aoe_exp" );
    level._effect[ "toxic_growth_launch" ] = loadfxasset( "vfx_sat_zm_gp_toxic_growth_vines_amb" );
    level callback::add( #"on_ai_killed_medal", &on_killed_medal );
    level callback::add( "scripted_item_used", &eat_toxic_growth_plant_food );
    level callback::add( #"on_ai_killed", &function_8d5505819cc6e1c2 );
    level callback::add( "scripted_item_can_use", &function_76e0df8a973d88c7 );
    level callback::add( "scripted_item_can_autouse", &function_317b563828f85e00 );
    scene::function_85b13b837056bc8b( &function_caae8949ac8b51e1 );
    
    if ( utility::issharedfuncdefined( #"medal", #"register_on_kill_medal_callback", 0 ) )
    {
        if ( isdefined( level.field_upgrade_bundles[ "super_toxic_growth" ] ) )
        {
            var_aa7919c06884da72 = level.field_upgrade_bundles[ "super_toxic_growth" ].offhandweapon;
            utility::callsharedfunc( #"medal", #"register_on_kill_medal_callback", var_aa7919c06884da72, &function_46b4c3e05957a762 );
        }
    }
    
    /#
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_command( "<dev string:x3a>", "<dev string:x4c>" );
        devgui::add_devgui_command( "<dev string:x7a>", "<dev string:x8f>" );
        devgui::add_devgui_func( "<dev string:xc1>", "<dev string:xde>", &function_81bd2847fbb94956, 1 );
        devgui::add_devgui_func( "<dev string:xf6>", "<dev string:x10f>", &function_8f96fc5e3f1a54c7 );
        devgui::function_77df7fe7dd273e10();
    #/
}

/#

    // Namespace field_upgrades_toxic_growth
    // Params 0
    // Checksum 0xee0d2a69, Offset: 0x650
    // Size: 0xc, Type: dev
    function function_8f96fc5e3f1a54c7()
    {
        function_14172eaf8868741f();
    }

    // Namespace field_upgrades_toxic_growth
    // Params 0
    // Checksum 0x2a914fb3, Offset: 0x664
    // Size: 0x241, Type: dev
    function function_81bd2847fbb94956()
    {
        while ( true )
        {
            foreach ( mdl_toxic_growth in level.var_80ec21e17cb08bce )
            {
                print3d( mdl_toxic_growth.origin, "<dev string:x128>" + ( mdl_toxic_growth.owner.name ?? "<dev string:x13d>" ), ( 0, 0.75, 0 ), undefined, 0.25, undefined, 1 );
                print3d( mdl_toxic_growth.origin + ( 0, 0, -5 ), "<dev string:x13e>" + mdl_toxic_growth.health, ( 0, 0.75, 0 ), undefined, 0.25, undefined, 1 );
                
                if ( isdefined( mdl_toxic_growth.var_dcee11752ff222a4 ) )
                {
                    sphere( mdl_toxic_growth.var_dcee11752ff222a4.origin, 10, ( 0, 0.75, 0 ) );
                }
                
                if ( isdefined( mdl_toxic_growth.var_2943ca440c2e5191 ) )
                {
                    var_77be3669189a4fe3 = int( ( mdl_toxic_growth.var_2943ca440c2e5191 - gettime() ) * 0.001 );
                    print3d( mdl_toxic_growth.origin + ( 0, 0, -10 ), "<dev string:x154>" + var_77be3669189a4fe3, ( 0, 0.75, 0 ), undefined, 0.25, undefined, 1 );
                }
                
                if ( isalive( mdl_toxic_growth.var_d0f3f031717444b8 ) && isdefined( mdl_toxic_growth.var_d0f3f031717444b8.var_afe5dff090911def ) )
                {
                    var_77be3669189a4fe3 = int( ( mdl_toxic_growth.var_d0f3f031717444b8.var_afe5dff090911def - gettime() ) * 0.001 );
                    print3d( mdl_toxic_growth.origin + ( 0, 0, 80 ), "<dev string:x172>" + var_77be3669189a4fe3, ( 0, 0.75, 0 ), undefined, 0.25, undefined, 1 );
                }
            }
            
            waitframe();
        }
    }

#/

// Namespace field_upgrades_toxic_growth
// Params 0, eflags: 0x4
// Checksum 0x3fc5160b, Offset: 0x8ad
// Size: 0x84
function private function_caae8949ac8b51e1()
{
    var_79b71dd6eb150719 = scene::function_5fe163f439457bd0();
    
    foreach ( player in var_79b71dd6eb150719 )
    {
        function_14172eaf8868741f( player );
    }
}

// Namespace field_upgrades_toxic_growth
// Params 0
// Checksum 0xda591d69, Offset: 0x939
// Size: 0x47
function set_toxic_growth()
{
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"toxic_growth_extra_charge" ) && !isdefined( self.perks[ "specialty_overcharge_field_upgrade" ] ) )
    {
        perk::giveperk( "specialty_overcharge_field_upgrade" );
    }
}

// Namespace field_upgrades_toxic_growth
// Params 0
// Checksum 0x93101931, Offset: 0x988
// Size: 0x7a
function unset_toxic_growth()
{
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"toxic_growth_extra_charge" ) && isdefined( self.perks[ "specialty_overcharge_field_upgrade" ] ) )
    {
        perk::removeperk( "specialty_overcharge_field_upgrade" );
    }
    
    if ( isdefined( self.var_87e9b1896b9a4e5f ) )
    {
        self.super.staticdata.usetime = self.var_87e9b1896b9a4e5f;
    }
}

// Namespace field_upgrades_toxic_growth
// Params 0
// Checksum 0x25c0b990, Offset: 0xa0a
// Size: 0x4b, Type: bool
function can_use_toxic_growth()
{
    if ( !self isonground() )
    {
        v_ground = getgroundposition( self.origin, 32 );
        var_2dc7498b24b43347 = distance( v_ground, self.origin );
        
        if ( var_2dc7498b24b43347 > 200 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace field_upgrades_toxic_growth
// Params 0
// Checksum 0xddb530b7, Offset: 0xa5e
// Size: 0xc4, Type: bool
function begin_use_toxic_growth()
{
    bundle = level.field_upgrade_bundles[ "super_toxic_growth" ];
    
    if ( isdefined( bundle ) && can_use_toxic_growth() )
    {
        var_aa7919c06884da72 = bundle.offhandweapon;
        deploysuccess = field_upgrades::field_upgrade_play_gesture( var_aa7919c06884da72, "super_toxic_growth" );
        
        if ( deploysuccess )
        {
            utility::function_7c10ea82c1e305b8( #"wand_fx_toxic_growth", #"on" );
            thread run_toxic_growth( var_aa7919c06884da72 );
            
            if ( bundle.var_8b9eade13fbfb044 )
            {
                assert( !callback::exists( #"super_cancel", &cancel ) );
                callback::add( #"super_cancel", &cancel );
            }
            
            return true;
        }
    }
    
    return false;
}

// Namespace field_upgrades_toxic_growth
// Params 2
// Checksum 0xafc9cb00, Offset: 0xb2b
// Size: 0x16, Type: bool
function function_543be607382d7fa3( fromdeath, attacker )
{
    return false;
}

// Namespace field_upgrades_toxic_growth
// Params 1, eflags: 0x4
// Checksum 0x704d3385, Offset: 0xb4a
// Size: 0xa1
function private cancel( params )
{
    if ( isarray( self.toxic_growth_array ) )
    {
        foreach ( toxic_growth in self.toxic_growth_array )
        {
            toxic_growth delete_toxic_growth( 1 );
        }
        
        self.toxic_growth_array = undefined;
    }
}

// Namespace field_upgrades_toxic_growth
// Params 1
// Checksum 0xed0b28a2, Offset: 0xbf3
// Size: 0x4d1
function run_toxic_growth( var_aa7919c06884da72 )
{
    if ( !isplayer( self ) || !isalive( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.var_80ec21e17cb08bce ) )
    {
        self.var_80ec21e17cb08bce = [];
    }
    
    self.var_4df597be2980bf60 = 0;
    self.var_901b08308f13264a = 0;
    result = vehicle::is_in_vehicle();
    
    if ( result )
    {
        seatid = vehicle_occupancy::get_occupant_seat( self.vehicle, self );
        data = vehicle_occupancy::function_759b1ac7685fb992( self.vehicle, self, seatid );
        
        if ( isdefined( data.origin ) )
        {
            location = data.origin;
            mdl_toxic_growth = spawn_toxic_growth( location, self.angles, var_aa7919c06884da72 );
        }
        else
        {
            location = self.vehicle.origin + ( 0, 0, 10 );
            mdl_toxic_growth = spawn_toxic_growth( location, self.angles, var_aa7919c06884da72 );
        }
    }
    else
    {
        upvector = ( 0, 0, 1 );
        forward = anglestoforward( self getplayerangles() );
        var_aaeb5466ff9c9f8f = 20;
        var_7cb64e9619dc529f = 30;
        var_72ade1f0d2b935c8 = getdvarint( @"hash_87e056e706f7847f", 275 );
        
        if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"toxic_growth_crescent" ) )
        {
            origin = self gettagorigin( "j_wrist_le", 1 );
            
            if ( !isdefined( origin ) )
            {
                origin = self gettagorigin( "tag_accessory_left" );
            }
            
            var_1efb0219d589ac0e = origin + upvector * var_aaeb5466ff9c9f8f + forward * var_7cb64e9619dc529f;
            var_8eb93aaf975c2c0d = forward * var_72ade1f0d2b935c8 / 2 + self getvelocity();
            var_e25d6b069308d27 = spawn_toxic_growth( origin, self.angles, var_aa7919c06884da72, var_1efb0219d589ac0e, var_8eb93aaf975c2c0d, "left" );
            var_c33f230cf6ba23d8 = spawn_toxic_growth( origin, self.angles, var_aa7919c06884da72, var_1efb0219d589ac0e, var_8eb93aaf975c2c0d, "right" );
            mdl_toxic_growth = [ var_e25d6b069308d27, var_c33f230cf6ba23d8 ];
            var_e25d6b069308d27.var_73df21921266bd70 = [ var_c33f230cf6ba23d8 ];
            var_c33f230cf6ba23d8.var_73df21921266bd70 = [ var_e25d6b069308d27 ];
            var_e25d6b069308d27.iscrescent = 1;
            var_c33f230cf6ba23d8.iscrescent = 1;
        }
        else
        {
            origin = self gettagorigin( "j_wrist_le", 1 );
            
            if ( !isdefined( origin ) )
            {
                origin = self gettagorigin( "tag_accessory_left" );
            }
            
            var_1efb0219d589ac0e = origin + upvector * var_aaeb5466ff9c9f8f + forward * var_7cb64e9619dc529f;
            var_8eb93aaf975c2c0d = forward * var_72ade1f0d2b935c8 + self getvelocity();
            mdl_toxic_growth = spawn_toxic_growth( origin, self.angles, var_aa7919c06884da72, var_1efb0219d589ac0e, var_8eb93aaf975c2c0d );
        }
    }
    
    if ( isarray( mdl_toxic_growth ) )
    {
        foreach ( e_toxic_growth in mdl_toxic_growth )
        {
            self.var_80ec21e17cb08bce[ self.var_80ec21e17cb08bce.size ] = e_toxic_growth;
            level.var_80ec21e17cb08bce[ level.var_80ec21e17cb08bce.size ] = e_toxic_growth;
        }
    }
    else
    {
        self.var_80ec21e17cb08bce[ self.var_80ec21e17cb08bce.size ] = mdl_toxic_growth;
        level.var_80ec21e17cb08bce[ level.var_80ec21e17cb08bce.size ] = mdl_toxic_growth;
    }
    
    var_69e8dcdd7cf844e9 = level.field_upgrade_bundles[ "super_toxic_growth" ].var_4db822c0f530998a ?? 3;
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"toxic_growth_crescent" ) )
    {
        var_f6dab7dee3767b4e = var_69e8dcdd7cf844e9 * 2;
    }
    else
    {
        var_f6dab7dee3767b4e = var_69e8dcdd7cf844e9;
    }
    
    if ( self.var_80ec21e17cb08bce.size > var_f6dab7dee3767b4e )
    {
        n_to_remove = self.var_80ec21e17cb08bce.size - var_f6dab7dee3767b4e;
        var_18f02c033420136f = [];
        
        for ( i = 0; i < n_to_remove ; i++ )
        {
            var_18f02c033420136f[ var_18f02c033420136f.size ] = self.var_80ec21e17cb08bce[ i ];
        }
        
        foreach ( var_775cdc5566d72418 in var_18f02c033420136f )
        {
            var_775cdc5566d72418 thread delete_toxic_growth();
        }
    }
}

// Namespace field_upgrades_toxic_growth
// Params 6, eflags: 0x4
// Checksum 0xd41ce036, Offset: 0x10cc
// Size: 0x137
function private spawn_toxic_growth( origin, angles, var_aa7919c06884da72, var_1efb0219d589ac0e, var_8eb93aaf975c2c0d, var_a847330c22697d85 )
{
    grenade = magicgrenademanual( var_aa7919c06884da72, origin, var_8eb93aaf975c2c0d, 99999, self );
    grenade.var_9eb0e951b21fa1ff = 1;
    grenade.var_b914fa7e22321b2a = &function_7b6e67dfdbc467a5;
    mdl_toxic_growth = utility::spawn_model( %"tag_origin", grenade.origin, grenade.angles );
    playfxontag( utility::getfx( "toxic_growth_launch" ), mdl_toxic_growth, "tag_origin" );
    mdl_toxic_growth linkto( grenade, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    mdl_toxic_growth.var_dcee11752ff222a4 = grenade;
    grenade.mdl_toxic_growth = mdl_toxic_growth;
    
    if ( !isdefined( self.toxic_growth_array ) )
    {
        self.toxic_growth_array = [];
    }
    
    self.toxic_growth_array[ self.toxic_growth_array.size ] = mdl_toxic_growth;
    thread _spawn_toxic_growth( grenade, mdl_toxic_growth, var_aa7919c06884da72, var_a847330c22697d85 );
    return mdl_toxic_growth;
}

// Namespace field_upgrades_toxic_growth
// Params 0, eflags: 0x4
// Checksum 0x9205f00d, Offset: 0x120c
// Size: 0x28
function private function_7b6e67dfdbc467a5()
{
    if ( isdefined( self.mdl_toxic_growth ) )
    {
        self.mdl_toxic_growth thread delete_toxic_growth();
        return;
    }
    
    self delete();
}

// Namespace field_upgrades_toxic_growth
// Params 4, eflags: 0x4
// Checksum 0x4427db21, Offset: 0x123c
// Size: 0x7b5
function private _spawn_toxic_growth( grenade, mdl_toxic_growth, var_aa7919c06884da72, var_a847330c22697d85 )
{
    n_start_time = gettime();
    msg = grenade utility::waittill_any_timeout( 3, "missile_stuck" );
    var_9414e2939faf3eec = gettime() - n_start_time;
    var_93ffd2f6efbaf7f5 = 1000;
    
    if ( var_9414e2939faf3eec < var_93ffd2f6efbaf7f5 )
    {
        wait utility::function_6f5d2e1f1ff70482( var_93ffd2f6efbaf7f5 - var_9414e2939faf3eec );
    }
    
    if ( !( isdefined( self ) && isdefined( grenade ) ) )
    {
        if ( isdefined( grenade ) )
        {
            grenade delete();
        }
        
        return;
    }
    
    if ( var_a847330c22697d85 == "left" )
    {
        var_1797ef2d4e032c54 = grenade.origin + anglestoleft( grenade.angles ) * getdvarint( @"scr_toxic_growth_crescent_offset", 40 );
        v_left_angles = combineangles( grenade.angles, ( 0, getdvarint( @"scr_toxic_growth_crescent_angle", 35 ), 0 ) );
        grenade.angles = v_left_angles;
        var_8b3d3e644b9204f = var_1797ef2d4e032c54;
    }
    else if ( var_a847330c22697d85 == "right" )
    {
        v_right = grenade.origin + anglestoright( grenade.angles ) * getdvarint( @"scr_toxic_growth_crescent_offset", 40 );
        v_right_angles = combineangles( grenade.angles, ( 0, -1 * getdvarint( @"scr_toxic_growth_crescent_angle", 35 ), 0 ) );
        grenade.angles = v_right_angles;
        var_8b3d3e644b9204f = v_right;
    }
    else
    {
        var_8b3d3e644b9204f = grenade.origin;
    }
    
    if ( !ispointonnavmesh( var_8b3d3e644b9204f, undefined, undefined, undefined, undefined, 1 ) || utility::issharedfuncdefined( #"zombie", #"hash_bad01cbc996e3dba" ) && !utility::callsharedfunc( #"zombie", #"hash_bad01cbc996e3dba", var_8b3d3e644b9204f ) )
    {
        var_9203d05f9e8c274f = getrandomnavpoints( self.origin ?? var_8b3d3e644b9204f, 400, 25, undefined, 1 );
        var_42a12bb791ae12d8 = [];
        
        foreach ( v_navmesh_point in var_9203d05f9e8c274f )
        {
            if ( !ispointonnavmesh( v_navmesh_point ) || utility::issharedfuncdefined( #"zombie", #"hash_bad01cbc996e3dba" ) && !utility::callsharedfunc( #"zombie", #"hash_bad01cbc996e3dba", v_navmesh_point ) )
            {
                continue;
            }
            
            var_42a12bb791ae12d8[ var_42a12bb791ae12d8.size ] = { #origin:v_navmesh_point };
        }
        
        var_42a12bb791ae12d8 = utility::get_array_of_closest( var_8b3d3e644b9204f, var_42a12bb791ae12d8 );
        var_6b1405306af8590b = var_42a12bb791ae12d8[ 0 ].origin ?? self.origin ?? var_8b3d3e644b9204f;
        
        if ( var_a847330c22697d85 == "left" )
        {
            var_1797ef2d4e032c54 = var_6b1405306af8590b;
        }
        else if ( var_a847330c22697d85 == "right" )
        {
            v_right = var_6b1405306af8590b;
        }
        else
        {
            grenade.origin = var_6b1405306af8590b;
            mdl_toxic_growth.origin = var_6b1405306af8590b;
        }
    }
    
    if ( isdefined( var_a847330c22697d85 ) )
    {
        thread delay_stop_fx_on_tag( 2, utility::getfx( "toxic_growth_launch" ), mdl_toxic_growth, "tag_origin" );
        mdl_toxic_growth setmodel( %"sat_zm_gp_toxic_growth_fxanim" );
        mdl_toxic_growth utility::function_7c10ea82c1e305b8( "base", "on" );
        e_mover = utility::spawn_tag_origin( grenade.origin, grenade.angles );
        grenade linkto( e_mover, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        e_mover moveto( var_1797ef2d4e032c54 ?? v_right, 1 );
        e_mover rotateto( v_left_angles ?? v_right_angles, 1 );
        e_mover waittill( #"movedone" );
        e_mover delete();
    }
    else
    {
        thread delay_stop_fx_on_tag( 2, utility::getfx( "toxic_growth_launch" ), mdl_toxic_growth, "tag_origin" );
        mdl_toxic_growth setmodel( %"sat_zm_gp_toxic_growth_fxanim" );
        mdl_toxic_growth utility::function_7c10ea82c1e305b8( "base", "on" );
    }
    
    var_c2dc9586a6672e5 = level.field_upgrade_bundles[ "super_toxic_growth" ];
    mdl_toxic_growth.weapon = makeweapon( var_aa7919c06884da72 );
    mdl_toxic_growth.owner = self;
    mdl_toxic_growth.trigger = spawn( "noent_volume_trigger_box", mdl_toxic_growth.origin, 0, ( 25, 45, 30 ), ( 25, 45, 30 ) );
    mdl_toxic_growth.trigger.angles = mdl_toxic_growth.angles;
    mdl_toxic_growth.trigger.mdl_toxic_growth = mdl_toxic_growth;
    mdl_toxic_growth.health = var_c2dc9586a6672e5.toxicgrowthhealth ?? 1000;
    
    if ( var_c2dc9586a6672e5.var_9526fd5c44eee510 && var_c2dc9586a6672e5.headicon_enable )
    {
        mdl_toxic_growth.superref = "super_toxic_growth";
        mdl_toxic_growth.team = self.team;
        mdl_toxic_growth.headiconid = entityheadicons::setheadicon_fieldupgrade( mdl_toxic_growth, undefined, mdl_toxic_growth.origin + ( 0, 0, 50 ) );
    }
    
    if ( utility::issharedfuncdefined( #"zm_toxic_growth", #"get_toxic_growth_location" ) )
    {
        utility::callsharedfunc( #"zm_toxic_growth", #"get_toxic_growth_location", mdl_toxic_growth.origin );
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"toxic_growth_green_thumb" ) )
    {
        mdl_toxic_growth.health += int( mdl_toxic_growth.health * ( level.zombie_augments[ #"toxic_growth_green_thumb" ].var_e4406386dc8ec8ff ?? 1 ) );
    }
    
    mdl_toxic_growth.badplace = toxic_growth_badplace( grenade.origin ?? mdl_toxic_growth.origin, 50 );
    trigger::makeenterexittrigger( mdl_toxic_growth.trigger, &toxic_growth_trigger_enter, &toxic_growth_trigger_exit );
    mdl_toxic_growth thread toxic_growth_lifetime( var_c2dc9586a6672e5.var_ea637cbf53813f21 );
    
    if ( var_c2dc9586a6672e5.var_14bc203b507ca838 )
    {
        mdl_toxic_growth.protection_radius = var_c2dc9586a6672e5.var_e9fc3916b5af56ef ?? 50;
        mdl_toxic_growth.on_damage_func = &on_damage_toxic_growth;
        mdl_toxic_growth.protected_players = [];
        a_squad_members = squad_utility::getsquadmembers();
        
        foreach ( squadmate in a_squad_members )
        {
            squadmate.var_d681f0e0f5023f4f = squadmate.var_d681f0e0f5023f4f ?? [];
            squadmate.var_d681f0e0f5023f4f[ mdl_toxic_growth getentitynumber() ] = mdl_toxic_growth;
            mdl_toxic_growth.protected_players[ mdl_toxic_growth.protected_players.size ] = squadmate;
        }
    }
}

// Namespace field_upgrades_toxic_growth
// Params 4, eflags: 0x4
// Checksum 0x89b8facf, Offset: 0x19f9
// Size: 0x51
function private delay_stop_fx_on_tag( delay, effectid, entity, tag )
{
    level endon( #"game_ended" );
    entity endon( #"death" );
    wait delay;
    
    if ( entity )
    {
        stopfxontag( effectid, entity, tag );
    }
}

// Namespace field_upgrades_toxic_growth
// Params 1, eflags: 0xc
// Checksum 0xb82472ce, Offset: 0x1a52
// Size: 0x58
function private toxic_growth_lifetime( n_lifetime = 300 )
{
    self notify( #"hash_274b244b1ba1cdea" );
    self endon( #"hash_274b244b1ba1cdea" );
    self endon( #"death" );
    self.var_2943ca440c2e5191 = gettime() + n_lifetime * 1000;
    wait n_lifetime;
    thread delete_toxic_growth();
}

// Namespace field_upgrades_toxic_growth
// Params 1, eflags: 0x4
// Checksum 0x4ea0a890, Offset: 0x1ab2
// Size: 0x3a
function private on_damage_toxic_growth( damage )
{
    if ( self.health < damage )
    {
        thread delete_toxic_growth();
        return;
    }
    
    self.health -= damage;
}

// Namespace field_upgrades_toxic_growth
// Params 1, eflags: 0x4
// Checksum 0xe016c0a, Offset: 0x1af4
// Size: 0x114
function private function_14172eaf8868741f( player )
{
    if ( isplayer( player ) )
    {
        if ( isarray( player.var_80ec21e17cb08bce ) )
        {
            foreach ( mdl_toxic_growth in player.var_80ec21e17cb08bce )
            {
                mdl_toxic_growth thread delete_toxic_growth();
            }
        }
        
        return;
    }
    
    foreach ( mdl_toxic_growth in level.var_80ec21e17cb08bce )
    {
        mdl_toxic_growth thread delete_toxic_growth();
    }
}

// Namespace field_upgrades_toxic_growth
// Params 1, eflags: 0x4
// Checksum 0xb5ae74b4, Offset: 0x1c10
// Size: 0x416
function private delete_toxic_growth( skip_state_change = 0 )
{
    if ( self.var_5a033095d6202ea9 )
    {
        return;
    }
    
    player = self.owner;
    self.var_5a033095d6202ea9 = 1;
    
    if ( isdefined( player ) && isarray( player.toxic_growth_array ) )
    {
        player.toxic_growth_array = arrayremove( player.toxic_growth_array, self );
    }
    
    bundle = level.field_upgrade_bundles[ "super_toxic_growth" ];
    
    if ( bundle.var_8b9eade13fbfb044 && ( !isdefined( player.toxic_growth_array ) || player.toxic_growth_array.size == 0 ) )
    {
        assert( player callback::exists( #"super_cancel", &cancel ) );
        player callback::remove( #"super_cancel", &cancel );
    }
    
    if ( !skip_state_change )
    {
        utility::function_7c10ea82c1e305b8( "base", "off" );
    }
    
    if ( isdefined( self.protected_players ) )
    {
        foreach ( squadmate in self.protected_players )
        {
            if ( isdefined( squadmate.var_d681f0e0f5023f4f ) && isdefined( squadmate.var_d681f0e0f5023f4f[ self getentitynumber() ] ) )
            {
                squadmate.var_d681f0e0f5023f4f[ self getentitynumber() ] = undefined;
            }
        }
    }
    
    if ( isdefined( self.badplace ) )
    {
        destroynavobstacle( self.badplace );
    }
    
    if ( isalive( self.var_d0f3f031717444b8 ) )
    {
        self.var_d0f3f031717444b8 thread end_charm_cordyception( self );
    }
    
    if ( !skip_state_change )
    {
        wait 1;
    }
    
    if ( isarray( self.trigger.mdl_toxic_growth.var_ba596b7dfc5c2597 ) )
    {
        foreach ( ai in self.trigger.mdl_toxic_growth.var_ba596b7dfc5c2597 )
        {
            ai function_f4fd17bc34aaad58( self.trigger );
        }
    }
    
    if ( isdefined( self.trigger ) )
    {
        if ( isarray( self.trigger.triggerenterents ) )
        {
            foreach ( ent in self.trigger.triggerenterents )
            {
                toxic_growth_trigger_exit( ent, self.trigger );
            }
        }
        
        self.trigger delete();
    }
    
    if ( isdefined( self ) )
    {
        if ( isdefined( self.owner ) )
        {
            self.owner callback::callback( "field_upgrade_ended", { #ref:"super_toxic_growth" } );
        }
        
        if ( isdefined( self.var_dcee11752ff222a4 ) )
        {
            self.var_dcee11752ff222a4 delete();
        }
        
        self delete();
    }
    
    if ( isdefined( player ) && isdefined( player.var_80ec21e17cb08bce ) )
    {
        player.var_80ec21e17cb08bce = function_5713d46873b29625( player.var_80ec21e17cb08bce );
    }
    
    level.var_80ec21e17cb08bce = function_5713d46873b29625( level.var_80ec21e17cb08bce );
}

// Namespace field_upgrades_toxic_growth
// Params 1
// Checksum 0xeee33bec, Offset: 0x202e
// Size: 0xbc, Type: bool
function function_3579c8407b772f( mdl_toxic_growth )
{
    if ( !isalive( self ) )
    {
        return false;
    }
    
    if ( !isagent( self ) )
    {
        return false;
    }
    
    if ( self.aicategory == "boss" && !self.var_e0207904c8bca4eb )
    {
        return false;
    }
    
    if ( self.b_ignore_toxic_growth )
    {
        return false;
    }
    
    if ( self.var_2259f0a89be4759f )
    {
        return false;
    }
    
    if ( !isdefined( mdl_toxic_growth ) )
    {
        return false;
    }
    
    if ( mdl_toxic_growth.var_5a033095d6202ea9 )
    {
        return false;
    }
    
    if ( self.var_282c85074c0691df )
    {
        return false;
    }
    
    if ( isdefined( self.mdl_toxic_growth_zoochory ) )
    {
        return false;
    }
    
    if ( self.team == mdl_toxic_growth.owner.team )
    {
        return false;
    }
    
    return true;
}

// Namespace field_upgrades_toxic_growth
// Params 1
// Checksum 0xc5c8f612, Offset: 0x20f3
// Size: 0x94, Type: bool
function function_dfe8a0bbe8c4f2f0( mdl_toxic_growth )
{
    if ( !level.field_upgrade_bundles[ "super_toxic_growth" ].var_bd734b0a67eb71eb )
    {
        return false;
    }
    
    if ( !isalive( self ) )
    {
        return false;
    }
    
    if ( !isdefined( mdl_toxic_growth ) )
    {
        return false;
    }
    
    if ( mdl_toxic_growth.var_5a033095d6202ea9 )
    {
        return false;
    }
    
    if ( self.var_2259f0a89be4759f )
    {
        return false;
    }
    
    if ( self == mdl_toxic_growth.owner || self.team == mdl_toxic_growth.owner.team )
    {
        return false;
    }
    
    return true;
}

// Namespace field_upgrades_toxic_growth
// Params 1, eflags: 0x4
// Checksum 0x39408d76, Offset: 0x2190
// Size: 0x538
function private function_21b98f676d874b7a( trigger )
{
    if ( !function_3579c8407b772f( trigger.mdl_toxic_growth ) )
    {
        return;
    }
    
    self notify( #"toxic_growth_entered", trigger );
    self.var_2259f0a89be4759f = 1;
    self.var_595a3c94bf52f0ce = trigger.mdl_toxic_growth;
    player = trigger.mdl_toxic_growth.owner;
    utility::function_7c10ea82c1e305b8( #"toxic_growth_fx", #"on" );
    
    if ( function_7dceb390b3a588c0( player, trigger ) )
    {
        trigger.mdl_toxic_growth.var_4ae20f38c7bce776 = 1;
        trigger.mdl_toxic_growth.var_d0f3f031717444b8 = self;
        var_dc58879cfee40e71 = level.zombie_augments[ #"toxic_growth_cordyception" ].var_f96ca3ae285c8ab0;
        self.var_afe5dff090911def = gettime() + var_dc58879cfee40e71 * 1000;
        namespace_59c416dec50ffbc3::charm( var_dc58879cfee40e71, player, &end_charm_cordyception, "toxic" );
        val::set( "toxic_growth", "collide_with_ai_allies", 0 );
        self disableaimassist();
        self function_fa32376aaa88a7a2( self.origin, 1000 );
        enemiesarray = [ self ];
        level notify( #"highvis_reload_outline", player.team, enemiesarray, 1 );
        base_zombie_maxhealth = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", zombie_utils::get_zombie_round_difficulty() );
        var_e4b17a51430e8fa5 = level.var_b7d9d7926154819d.ammomodbundles[ "brainrot" ].var_79ee00753258f705 ?? 0.5;
        var_afe71cbf6df8b2c9 = level.var_b7d9d7926154819d.ammomodbundles[ "brainrot" ].var_4f81d183aac26f25 ?? 2;
        var_172e08a154e4fddd = level.var_b7d9d7926154819d.ammomodbundles[ "brainrot" ].var_803c1fd06889eca5 ?? 2;
        var_29f2cb5ee0852502 = 0;
        
        if ( isplayer( player ) && player utility::callsharedfunc( #"zombie", #"player_has_augment", #"brainrot_more_damage" ) )
        {
            var_db8854d93beb49c7 = 1;
            var_29f2cb5ee0852502 = level.zombie_augments[ #"brainrot_more_damage" ].var_2ccdfad329f73c24 ?? 0.5;
            var_29f2cb5ee0852502 *= base_zombie_maxhealth;
        }
        
        ai_tier = ai_utility::get_ai_tier();
        
        if ( ai_tier == 1 )
        {
            self.var_cab75db7e9e5b64c = base_zombie_maxhealth * var_e4b17a51430e8fa5;
            
            if ( var_29f2cb5ee0852502 != 0 )
            {
                self.var_cab75db7e9e5b64c += var_29f2cb5ee0852502;
            }
        }
        else if ( ai_tier == 2 )
        {
            self.var_cab75db7e9e5b64c = base_zombie_maxhealth * var_afe71cbf6df8b2c9;
            
            if ( var_29f2cb5ee0852502 != 0 )
            {
                self.var_cab75db7e9e5b64c += var_29f2cb5ee0852502;
            }
        }
        else if ( ai_tier == 3 )
        {
            self.var_cab75db7e9e5b64c = base_zombie_maxhealth * var_172e08a154e4fddd;
            
            if ( var_29f2cb5ee0852502 != 0 )
            {
                self.var_cab75db7e9e5b64c += var_29f2cb5ee0852502;
            }
        }
        
        self.var_282c85074c0691df = 1;
        self.ignore_enemy_count = 1;
        val::set( "brainrot", "ignoreme", 1 );
        self.var_6ca4658d0dbdfa45 = player;
        utility::function_7c10ea82c1e305b8( #"toxic_growth_fx", #"on_charmed" );
        self.var_343e94251a521741 = utility::spawn_tag_origin( self.origin, self.angles );
        self.collide_with_ai = 0;
        self motionwarpcancel();
        self linkto( self.var_343e94251a521741 );
        thread function_5e78c91f49586729( trigger.mdl_toxic_growth );
        thread function_d40ddbd0f20e7bbb();
        callback::remove( #"on_ai_killed", &function_5e2740f6837b1cc9 );
        callback::add( #"on_ai_killed", &function_5e2740f6837b1cc9 );
        callback::callback( "on_turned", {} );
    }
    else if ( function_2e2fa19772b96696( player, trigger ) )
    {
        thread function_f104dd2ed4964dbe( player, trigger );
    }
    
    if ( !isdefined( trigger.mdl_toxic_growth.var_d0f3f031717444b8 ) || self != trigger.mdl_toxic_growth.var_d0f3f031717444b8 )
    {
        can_affect = 1;
        
        if ( utility::issharedfuncdefined( #"zm", #"hash_8e5cbc74839b479b" ) )
        {
            can_affect = level [[ utility::getsharedfunc( #"zm", #"hash_8e5cbc74839b479b" ) ]]( player, self );
        }
        
        if ( can_affect )
        {
            var_8f0939653663fe14 = player get_toxic_growth_slow_percentage( self );
            effect_slow::slow( "toxic_growth", var_8f0939653663fe14, 999, player, &function_3d9014a4ca5e10d2, 1, "toxic" );
            
            if ( trigger.mdl_toxic_growth.var_ee7dc3d79eae1c50 )
            {
                trigger.mdl_toxic_growth.var_ba596b7dfc5c2597 = arraycombineunique( trigger.mdl_toxic_growth.var_ba596b7dfc5c2597, [ self ] );
            }
            
            thread toxic_growth_ai_damage( trigger );
        }
    }
}

// Namespace field_upgrades_toxic_growth
// Params 1, eflags: 0x4
// Checksum 0xd91a093b, Offset: 0x26d0
// Size: 0xc3
function private function_f32da985dc1a6b21( trigger )
{
    if ( !function_dfe8a0bbe8c4f2f0( trigger.mdl_toxic_growth ) )
    {
        return;
    }
    
    player = trigger.mdl_toxic_growth.owner;
    self notify( #"toxic_growth_entered", trigger );
    self.var_2259f0a89be4759f = 1;
    self.var_595a3c94bf52f0ce = trigger.mdl_toxic_growth;
    var_8f0939653663fe14 = level.field_upgrade_bundles[ "super_toxic_growth" ].var_ee77572c3cd03dd9 ?? 0.4;
    effect_slow::slow( "toxic_growth", var_8f0939653663fe14, 999, player, &function_3d9014a4ca5e10d2, 1, "toxic" );
    thread toxic_growth_player_damage( trigger );
}

// Namespace field_upgrades_toxic_growth
// Params 1, eflags: 0x4
// Checksum 0xcd4120dc, Offset: 0x279b
// Size: 0x69
function private function_b10015b0cdf68ef3( trigger )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( self.var_2259f0a89be4759f )
    {
        self.var_2259f0a89be4759f = undefined;
        
        if ( self.var_595a3c94bf52f0ce == trigger.mdl_toxic_growth )
        {
            self.var_595a3c94bf52f0ce = undefined;
        }
        
        effect_slow::function_80a4bd13b5ba303a( "toxic_growth" );
        self notify( "endon_toxic_growth_player_damage" + string( self getentitynumber() ) );
    }
}

// Namespace field_upgrades_toxic_growth
// Params 1
// Checksum 0x63e07467, Offset: 0x280c
// Size: 0x2d9
function toxic_growth_player_damage( trigger )
{
    self notify( #"hash_ae93b0155e338ac7" );
    self endon( #"hash_ae93b0155e338ac7" );
    self endon( "endon_toxic_growth_player_damage" + string( self getentitynumber() ) );
    self endon( #"disconnect" );
    trigger endon( #"death" );
    owner = trigger.mdl_toxic_growth.owner;
    var_c8fd15f5db57829d = level.field_upgrade_bundles[ "super_toxic_growth" ].var_552623c43b2e75a1 ?? 20;
    n_damage = var_c8fd15f5db57829d * 1;
    
    if ( n_damage <= 0 )
    {
        return;
    }
    
    while ( isalive( self ) && self.var_2259f0a89be4759f && isdefined( trigger ) )
    {
        v_origin = self gettagorigin( "j_spine4", 1 ) ?? self.origin;
        trigger.mdl_toxic_growth.health = int( trigger.mdl_toxic_growth.health - n_damage );
        
        if ( isarray( trigger.mdl_toxic_growth.var_73df21921266bd70 ) )
        {
            foreach ( var_284c47bb174b2cdf in trigger.mdl_toxic_growth.var_73df21921266bd70 )
            {
                var_284c47bb174b2cdf.health = int( var_284c47bb174b2cdf.health - n_damage );
            }
        }
        
        self dodamage( n_damage, v_origin, owner, trigger.mdl_toxic_growth, "MOD_ELEMENTAL_TOXIC", trigger.mdl_toxic_growth.weapon, "torso_upper", undefined, 65536 );
        wait 1;
        
        if ( trigger.mdl_toxic_growth.health <= 0 )
        {
            if ( isarray( trigger.mdl_toxic_growth.var_73df21921266bd70 ) )
            {
                foreach ( var_284c47bb174b2cdf in trigger.mdl_toxic_growth.var_73df21921266bd70 )
                {
                    var_284c47bb174b2cdf thread delete_toxic_growth();
                }
            }
            
            trigger.mdl_toxic_growth thread delete_toxic_growth();
            break;
        }
    }
}

// Namespace field_upgrades_toxic_growth
// Params 6
// Checksum 0x558581ee, Offset: 0x2aed
// Size: 0x479
function toxic_growth_explode( player, ai_inflictor, v_origin, n_radius, var_7609c5fb50bbd3e9, mdl_toxic_growth )
{
    var_a7d1d717be62a064 = physics_querypoint( v_origin, n_radius, trace::create_character_contents(), undefined, "physicsquery_all" );
    a_ai_nearby = [];
    
    foreach ( var_777f6f64f92fa683 in var_a7d1d717be62a064 )
    {
        ai = var_777f6f64f92fa683[ "entity" ];
        
        if ( isalive( ai ) && isagent( ai ) )
        {
            if ( utility::issharedfuncdefined( #"zm", #"hash_8e5cbc74839b479b" ) )
            {
                if ( !level [[ utility::getsharedfunc( #"zm", #"hash_8e5cbc74839b479b" ) ]]( player, ai ) )
                {
                    continue;
                }
            }
            
            a_ai_nearby[ a_ai_nearby.size ] = ai;
            
            if ( ai.aicategory == "boss" )
            {
                ai.var_18681c6877202d21 = var_777f6f64f92fa683[ "position" ] + ( 0, 0, 48 );
            }
        }
    }
    
    var_da0f07c1090c50d4 = level.zombie_augments[ #"toxic_growth_pollination" ].var_9887ffe89e32fd51;
    
    if ( isdefined( var_da0f07c1090c50d4 ) )
    {
        zombie_health_bundle = level.gametypebundle.var_e039e3d3a8e46ee6 ?? "health_zombie_base";
        n_round = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( v_origin );
        base_zombie_maxhealth = namespace_9d8e359c3b1041e5::function_bb9b98eb7368a15a( zombie_health_bundle, n_round );
        n_damage = base_zombie_maxhealth * var_da0f07c1090c50d4;
        var_309d3d200b85f4ed = level.field_upgrade_bundles[ "super_toxic_growth" ].var_75b56a537d60ba33 ?? 0;
        
        if ( n_damage < var_309d3d200b85f4ed )
        {
            n_damage = var_309d3d200b85f4ed;
        }
    }
    
    playfx( utility::getfx( "toxic_growth_aoe_explode" ), v_origin );
    playsoundatpos( v_origin, #"hash_117d624f00d42bcb" );
    var_8f0939653663fe14 = player get_toxic_growth_slow_percentage();
    var_4880bcb9cb1cf632 = 0;
    
    foreach ( ai in a_ai_nearby )
    {
        if ( isalive( ai ) )
        {
            if ( ai.aicategory != "boss" || ai.aicategory == "boss" && ai.var_e0207904c8bca4eb )
            {
                ai effect_slow::slow( "toxic_growth", var_8f0939653663fe14, level.zombie_augments[ #"toxic_growth_pollination" ].var_5f533c68641ac468, player, &function_3d9014a4ca5e10d2, 1, "toxic" );
                
                if ( ai effect_slow::function_c1be3c9f2d0b92d2( "toxic_growth" ) )
                {
                    var_4880bcb9cb1cf632 += 1;
                }
            }
            
            ai dodamage( n_damage, ai.var_18681c6877202d21 ?? ai.origin, player, ai_inflictor, "MOD_ELEMENTAL_TOXIC", mdl_toxic_growth.weapon, "torso_upper", undefined, 65536 );
            ai.var_18681c6877202d21 = undefined;
            waitframe();
        }
    }
    
    var_8a24917f6d586fa3 = damage_utility::function_cf1c753aefa70ea1( mdl_toxic_growth.owner.team );
    radius_sqrd = n_radius;
    
    foreach ( ent in var_8a24917f6d586fa3 )
    {
        if ( distancesquared( ent.origin, v_origin ) <= radius_sqrd )
        {
            ent dodamage( n_damage, ent.origin, player, ai_inflictor, "MOD_ELEMENTAL_TOXIC", mdl_toxic_growth.weapon, undefined, undefined, 65536 );
        }
    }
}

// Namespace field_upgrades_toxic_growth
// Params 1
// Checksum 0x56b39555, Offset: 0x2f6e
// Size: 0x568
function toxic_growth_ai_damage( trigger )
{
    self notify( #"hash_45aec1a9065c604c" );
    self endon( #"hash_45aec1a9065c604c" );
    self endon( "endon_toxic_growth_ai_damage" + string( self getentitynumber() ) );
    trigger endon( #"death" );
    player = trigger.mdl_toxic_growth.owner;
    
    while ( isalive( self ) && self.var_2259f0a89be4759f && isdefined( trigger ) && !self.var_282c85074c0691df )
    {
        if ( isdefined( self.aicategory ) )
        {
            switch ( self.aicategory )
            {
                case #"hash_84fcf5e68d7230b2":
                default:
                    var_da0f07c1090c50d4 = level.field_upgrade_bundles[ "super_toxic_growth" ].var_f01d09f5f7559773 ?? 0.2;
                    break;
                case #"hash_8c089e813083e510":
                    var_da0f07c1090c50d4 = level.field_upgrade_bundles[ "super_toxic_growth" ].var_d3715f5aa5f3876b ?? 0.025;
                    break;
                case #"hash_7b0e2f2ed84f34":
                case #"hash_4e47eb6c32f5b165":
                    var_da0f07c1090c50d4 = level.field_upgrade_bundles[ "super_toxic_growth" ].var_47e39451d772ad2b ?? 0.025;
                    break;
                case #"hash_7e8a002ed096276c":
                    var_da0f07c1090c50d4 = level.field_upgrade_bundles[ "super_toxic_growth" ].var_f750ae180393e5f9 ?? 0;
                    break;
            }
        }
        else
        {
            n_damage = 0.2 * self.maxhealth;
        }
        
        v_origin = self gettagorigin( "j_spine4", 1 ) ?? self.origin;
        
        if ( isdefined( var_da0f07c1090c50d4 ) )
        {
            zombie_health_bundle = level.gametypebundle.var_e039e3d3a8e46ee6 ?? "health_zombie_base";
            n_round = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( v_origin );
            base_zombie_maxhealth = namespace_9d8e359c3b1041e5::function_bb9b98eb7368a15a( zombie_health_bundle, n_round );
            n_damage = base_zombie_maxhealth * var_da0f07c1090c50d4;
        }
        else if ( !isdefined( n_damage ) )
        {
            n_damage = var_da0f07c1090c50d4 * self.maxhealth;
        }
        
        var_45a893561f8996fc = level.field_upgrade_bundles[ "super_toxic_growth" ].var_2d5ecf2b9a7f8cf3 ?? 50;
        trigger.mdl_toxic_growth.health = int( trigger.mdl_toxic_growth.health - var_45a893561f8996fc );
        
        if ( isarray( trigger.mdl_toxic_growth.var_73df21921266bd70 ) )
        {
            foreach ( var_284c47bb174b2cdf in trigger.mdl_toxic_growth.var_73df21921266bd70 )
            {
                var_284c47bb174b2cdf.health = int( var_284c47bb174b2cdf.health - var_45a893561f8996fc );
            }
        }
        
        var_309d3d200b85f4ed = level.field_upgrade_bundles[ "super_toxic_growth" ].var_75b56a537d60ba33 ?? 0;
        
        if ( n_damage < var_309d3d200b85f4ed )
        {
            n_damage = var_309d3d200b85f4ed;
        }
        
        self dodamage( n_damage, v_origin, player, trigger.mdl_toxic_growth, "MOD_ELEMENTAL_TOXIC", trigger.mdl_toxic_growth.weapon, "torso_upper", undefined, 65536 );
        
        if ( level.field_upgrade_bundles[ "super_toxic_growth" ].var_84c0da5c787950be )
        {
            if ( !isdefined( player.var_f7e769e8027b444 ) || gettime() - player.var_f7e769e8027b444 > 1000 )
            {
                player.var_f7e769e8027b444 = gettime();
                player points::doscoreevent( #"super_toxic_growth_damage" );
            }
        }
        
        if ( !isalive( self ) )
        {
            if ( player utility::callsharedfunc( #"zombie", #"player_has_augment", #"toxic_growth_pollination" ) )
            {
                thread toxic_growth_explode( player, self, v_origin, level.zombie_augments[ #"toxic_growth_pollination" ].var_9bf45b0d66ee2586, level.zombie_augments[ #"toxic_growth_pollination" ].var_5f533c68641ac468, trigger.mdl_toxic_growth );
            }
        }
        
        wait 1;
        
        if ( trigger.mdl_toxic_growth.health <= 0 )
        {
            if ( isarray( trigger.mdl_toxic_growth.var_73df21921266bd70 ) )
            {
                foreach ( var_284c47bb174b2cdf in trigger.mdl_toxic_growth.var_73df21921266bd70 )
                {
                    var_284c47bb174b2cdf thread delete_toxic_growth();
                }
            }
            
            trigger.mdl_toxic_growth thread delete_toxic_growth();
            break;
        }
    }
}

// Namespace field_upgrades_toxic_growth
// Params 2, eflags: 0x44 variadic
// Checksum 0x2aa6b822, Offset: 0x34de
// Size: 0x15
function private function_3d9014a4ca5e10d2( ... )
{
    
}

// Namespace field_upgrades_toxic_growth
// Params 2
// Checksum 0x4a66c13c, Offset: 0x34fb
// Size: 0x147, Type: bool
function function_7dceb390b3a588c0( player, trigger )
{
    if ( !player utility::callsharedfunc( #"zombie", #"player_has_augment", #"toxic_growth_cordyception" ) )
    {
        return false;
    }
    
    if ( utility::issharedfuncdefined( #"zm", #"hash_8e5cbc74839b479b" ) )
    {
        if ( !level [[ utility::getsharedfunc( #"zm", #"hash_8e5cbc74839b479b" ) ]]( player, self ) )
        {
            return false;
        }
    }
    
    if ( !isdefined( trigger.mdl_toxic_growth ) )
    {
        return false;
    }
    
    if ( trigger.mdl_toxic_growth.var_4ae20f38c7bce776 )
    {
        return false;
    }
    
    if ( isalive( trigger.mdl_toxic_growth.var_d0f3f031717444b8 ) )
    {
        return false;
    }
    
    if ( self.var_eb92c31552620100 )
    {
        return false;
    }
    
    if ( self.disable_brain_rot || !val::get( "allow_brot" ) )
    {
        return false;
    }
    
    if ( self.magic_bullet_shield )
    {
        return false;
    }
    
    if ( self.b_disable_cordyception )
    {
        return false;
    }
    
    if ( !isdefined( self.aicategory ) || self.aicategory != "normal" && self.aicategory != "special" )
    {
        return false;
    }
    
    return true;
}

// Namespace field_upgrades_toxic_growth
// Params 2
// Checksum 0x5dd876c7, Offset: 0x364b
// Size: 0xe1, Type: bool
function function_2e2fa19772b96696( player, trigger )
{
    if ( !isdefined( trigger.mdl_toxic_growth ) )
    {
        return false;
    }
    
    if ( !player utility::callsharedfunc( #"zombie", #"player_has_augment", #"toxic_growth_zoochory" ) )
    {
        return false;
    }
    
    if ( utility::issharedfuncdefined( #"zm", #"hash_8e5cbc74839b479b" ) )
    {
        if ( !level [[ utility::getsharedfunc( #"zm", #"hash_8e5cbc74839b479b" ) ]]( player, self ) )
        {
            return false;
        }
    }
    
    if ( trigger.mdl_toxic_growth.var_ee7dc3d79eae1c50 )
    {
        return false;
    }
    
    if ( !isdefined( self.aicategory ) || self.aicategory != "normal" && self.aicategory != "special" )
    {
        return false;
    }
    
    return true;
}

// Namespace field_upgrades_toxic_growth
// Params 2
// Checksum 0x765c71c2, Offset: 0x3735
// Size: 0x4f
function toxic_growth_trigger_enter( ent, trigger )
{
    /#
        iprintlnbold( "<dev string:x19d>" + ent getentitynumber() + "<dev string:x1a5>" );
    #/
    
    if ( isplayer( ent ) )
    {
        ent function_f32da985dc1a6b21( trigger );
        return;
    }
    
    ent function_21b98f676d874b7a( trigger );
}

// Namespace field_upgrades_toxic_growth
// Params 1
// Checksum 0xfee3f593, Offset: 0x378c
// Size: 0x6a
function function_5e78c91f49586729( mdl_toxic_growth )
{
    self.var_343e94251a521741 endon( #"death" );
    
    if ( ai::is_doing_traversal( self ) || self.is_traversing )
    {
        self.var_343e94251a521741 moveto( mdl_toxic_growth.origin, 0.5 );
        self.var_343e94251a521741 waittill( #"movedone" );
    }
}

// Namespace field_upgrades_toxic_growth
// Params 1, eflags: 0x4
// Checksum 0x7204b3b1, Offset: 0x37fe
// Size: 0x129
function private end_charm_cordyception( mdl_toxic_growth )
{
    if ( self.var_282c85074c0691df )
    {
        utility::function_7c10ea82c1e305b8( #"toxic_growth_fx", #"disable_charmed" );
        b_kill_ai = 1;
        
        if ( isplayer( self.var_6ca4658d0dbdfa45 ) )
        {
            var_6ca4658d0dbdfa45 = self.var_6ca4658d0dbdfa45;
            self.var_6ca4658d0dbdfa45 = undefined;
        }
        
        self enableaimassist();
        val::reset( "brainrot", "ignoreme" );
    }
    else
    {
        utility::function_7c10ea82c1e305b8( #"toxic_growth_fx", #"disable" );
    }
    
    self.var_282c85074c0691df = undefined;
    self.ignore_enemy_count = undefined;
    self.var_afe5dff090911def = undefined;
    self.collide_with_ai = 1;
    val::reset( "toxic_growth", "collide_with_ai_allies" );
    
    if ( isdefined( self.var_343e94251a521741 ) )
    {
        self.var_343e94251a521741 delete();
    }
    
    if ( b_kill_ai && !self.magic_bullet_shield )
    {
        self kill( self.origin, var_6ca4658d0dbdfa45, mdl_toxic_growth, "MOD_ELEMENTAL_TOXIC", mdl_toxic_growth.weapon );
    }
}

// Namespace field_upgrades_toxic_growth
// Params 0, eflags: 0x4
// Checksum 0x67ecea23, Offset: 0x392f
// Size: 0x99
function private function_d40ddbd0f20e7bbb()
{
    self endon( #"death" );
    n_rotate_time = 0.5;
    
    while ( isdefined( self.var_343e94251a521741 ) )
    {
        if ( isdefined( self.enemy ) )
        {
            function_2d131f47b7fa8f37( self, self.enemy, 25, n_rotate_time );
        }
        else
        {
            a_nearby_players = utility::get_array_of_closest( self.origin, getplayersinradius( self.origin, 1000, undefined, undefined, undefined, self.team ) );
            function_2d131f47b7fa8f37( self, a_nearby_players[ 0 ], 25, n_rotate_time );
        }
        
        waitframe();
    }
}

// Namespace field_upgrades_toxic_growth
// Params 4, eflags: 0x4
// Checksum 0x4b92af66, Offset: 0x39d0
// Size: 0xdd
function private function_2d131f47b7fa8f37( ai, target_ent, desired_fov, n_time )
{
    if ( isdefined( ai ) && isdefined( ai.var_343e94251a521741 ) && isdefined( target_ent ) && !utility::within_fov( ai geteye(), ai.angles, target_ent.origin, cos( desired_fov ) ) )
    {
        vdir = target_ent.origin - ai.var_343e94251a521741.origin;
        yaw = vectortoyaw( vdir );
        v_rotate_to_angles = ( ai.angles[ 0 ], yaw, 0 );
        ai.var_343e94251a521741 rotateto( v_rotate_to_angles, n_time );
        wait n_time;
    }
}

// Namespace field_upgrades_toxic_growth
// Params 1, eflags: 0x4
// Checksum 0x45017aa5, Offset: 0x3ab5
// Size: 0x27
function private function_5e2740f6837b1cc9( params )
{
    if ( isdefined( self.var_343e94251a521741 ) )
    {
        self.var_343e94251a521741 delete();
    }
}

// Namespace field_upgrades_toxic_growth
// Params 2
// Checksum 0xf48c8a29, Offset: 0x3ae4
// Size: 0x4f
function toxic_growth_trigger_exit( ent, trigger )
{
    /#
        iprintlnbold( "<dev string:x19d>" + ent getentitynumber() + "<dev string:x1bb>" );
    #/
    
    if ( isplayer( ent ) )
    {
        ent function_b10015b0cdf68ef3( trigger );
        return;
    }
    
    ent function_f4fd17bc34aaad58( trigger );
}

// Namespace field_upgrades_toxic_growth
// Params 2
// Checksum 0x44a3c3df, Offset: 0x3b3b
// Size: 0x86
function toxic_growth_badplace( impactorigin, radius )
{
    if ( !bots_util::bot_bots_enabled_or_added() && !utility::level_supports_ai() )
    {
        return;
    }
    
    if ( isdefined( level.var_3d90777bfb7fc504 ) )
    {
        badplace = function_30c25bea1909556f( impactorigin, ( radius, radius, 125 ), ( 0, 0, 0 ), level.var_3d90777bfb7fc504 );
    }
    else
    {
        badplace = createnavbadplacebybounds( impactorigin, ( radius, radius, 125 ), ( 0, 0, 0 ) );
    }
    
    return badplace;
}

// Namespace field_upgrades_toxic_growth
// Params 1
// Checksum 0xd386a460, Offset: 0x3bca
// Size: 0x82
function get_toxic_growth_slow_percentage( ent )
{
    if ( ent.var_282c85074c0691df )
    {
        var_8f0939653663fe14 = 1;
    }
    else if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"toxic_growth_ankle_shredder" ) )
    {
        var_8f0939653663fe14 = level.zombie_augments[ #"toxic_growth_ankle_shredder" ].var_7475d140e9d040de ?? 0.4;
    }
    else
    {
        var_8f0939653663fe14 = 0.4;
    }
    
    return var_8f0939653663fe14;
}

// Namespace field_upgrades_toxic_growth
// Params 1, eflags: 0x4
// Checksum 0xed95800f, Offset: 0x3c55
// Size: 0x1a8
function private function_f4fd17bc34aaad58( trigger )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( self.var_2259f0a89be4759f )
    {
        self.var_2259f0a89be4759f = undefined;
        
        if ( self.var_595a3c94bf52f0ce == trigger.mdl_toxic_growth )
        {
            self.var_595a3c94bf52f0ce = undefined;
        }
        
        if ( isarray( trigger.mdl_toxic_growth.var_ba596b7dfc5c2597 ) && arraycontains( trigger.mdl_toxic_growth.var_ba596b7dfc5c2597, self ) )
        {
            trigger.mdl_toxic_growth.var_ba596b7dfc5c2597 = arrayremove( trigger.mdl_toxic_growth.var_ba596b7dfc5c2597, self );
        }
        
        if ( trigger.mdl_toxic_growth.iscrescent )
        {
            var_e8c4dabd5b94718a = level.zombie_augments[ #"toxic_growth_crescent" ].var_ed7802d0e09e7b68 ?? 3;
            utility::delaythreadendon( var_e8c4dabd5b94718a, [ "toxic_growth_entered", "death" ], &effect_slow::function_80a4bd13b5ba303a, "toxic_growth" );
            
            if ( !self.var_282c85074c0691df )
            {
                utility::delaythreadendon( var_e8c4dabd5b94718a, [ "toxic_growth_entered", "death" ], &utility::function_7c10ea82c1e305b8, #"toxic_growth_fx", #"disable" );
            }
        }
        else
        {
            if ( !self.var_282c85074c0691df )
            {
                utility::function_7c10ea82c1e305b8( #"toxic_growth_fx", #"disable" );
            }
            
            effect_slow::function_80a4bd13b5ba303a( "toxic_growth" );
        }
        
        self notify( "endon_toxic_growth_ai_damage" + string( self getentitynumber() ) );
    }
}

// Namespace field_upgrades_toxic_growth
// Params 2, eflags: 0x4
// Checksum 0xdcac381c, Offset: 0x3e05
// Size: 0x668
function private function_f104dd2ed4964dbe( player, trigger )
{
    mdl_toxic_growth = trigger.mdl_toxic_growth;
    mdl_toxic_growth.var_ee7dc3d79eae1c50 = 1;
    mdl_toxic_growth.var_d0f3f031717444b8 = self;
    mdl_toxic_growth.var_ba596b7dfc5c2597 = [];
    utility::callsharedfunc( #"zombie_utils", #"setmovespeed", "walk", "tg_zoo", 30 );
    self.mdl_toxic_growth_zoochory = mdl_toxic_growth;
    n_radius = level.zombie_augments[ #"toxic_growth_zoochory" ].var_fac2d1424da9ecbd ?? 50;
    var_1da31c9fedbb9f = level.zombie_augments[ #"toxic_growth_zoochory" ].var_2a15b67883e873dd ?? 0.2;
    var_8f0939653663fe14 = player get_toxic_growth_slow_percentage( self );
    
    if ( isdefined( mdl_toxic_growth.var_dcee11752ff222a4 ) )
    {
        e_mover = utility::spawn_tag_origin( mdl_toxic_growth.var_dcee11752ff222a4.origin, mdl_toxic_growth.var_dcee11752ff222a4.angles );
        mdl_toxic_growth.var_dcee11752ff222a4 linkto( e_mover, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    }
    else
    {
        mdl_toxic_growth thread delete_toxic_growth();
        return;
    }
    
    n_link_z_offset = 16;
    var_998630962d245881 = self.origin + ( 0, 0, n_link_z_offset );
    n_timeout = gettime() + 4000;
    
    while ( isalive( self ) && distance( e_mover.origin, var_998630962d245881 ) > 8 && gettime() < n_timeout )
    {
        vector_to_target = var_998630962d245881 - e_mover.origin;
        normal_vector = vectornormalize( vector_to_target );
        move_distance = 400 * level.framedurationseconds;
        move_vector = move_distance * normal_vector;
        move_to_point = e_mover.origin + move_vector;
        e_mover moveto( move_to_point, level.framedurationseconds );
        e_mover rotateto( self.angles, level.framedurationseconds );
        e_mover waittill( #"movedone" );
    }
    
    e_mover delete();
    
    if ( isalive( self ) )
    {
        mdl_toxic_growth.var_dcee11752ff222a4.origin = self.origin;
        mdl_toxic_growth.var_dcee11752ff222a4.angles = self.angles;
        mdl_toxic_growth utility::function_32b24db3127bff40( "base", "on" );
        mdl_toxic_growth.var_dcee11752ff222a4 linkto( self, "tag_origin", ( 0, 0, n_link_z_offset ), ( 0, 0, 0 ) );
    }
    
    while ( isalive( self ) && isdefined( mdl_toxic_growth ) && mdl_toxic_growth.health > 0 && mdl_toxic_growth.var_2943ca440c2e5191 > gettime() )
    {
        trigger.origin = mdl_toxic_growth.origin;
        trigger.angles = mdl_toxic_growth.angles;
        mdl_toxic_growth.var_ba596b7dfc5c2597 = utility::array_removedead_or_dying( mdl_toxic_growth.var_ba596b7dfc5c2597 );
        waitframe();
    }
    
    if ( isalive( self ) && isdefined( var_1da31c9fedbb9f ) )
    {
        zombie_health_bundle = level.gametypebundle.var_e039e3d3a8e46ee6 ?? "health_zombie_base";
        n_round = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
        base_zombie_maxhealth = namespace_9d8e359c3b1041e5::function_bb9b98eb7368a15a( zombie_health_bundle, n_round );
        n_damage = base_zombie_maxhealth * var_1da31c9fedbb9f;
        self dodamage( n_damage, self.origin, player, mdl_toxic_growth, "MOD_ELEMENTAL_TOXIC", mdl_toxic_growth.weapon, "torso_upper", undefined, 65536 );
    }
    
    if ( isdefined( mdl_toxic_growth ) && mdl_toxic_growth.health > 0 && mdl_toxic_growth.var_2943ca440c2e5191 > gettime() )
    {
        mdl_toxic_growth.var_dcee11752ff222a4 unlink();
        e_mover = utility::spawn_tag_origin( mdl_toxic_growth.var_dcee11752ff222a4.origin, mdl_toxic_growth.var_dcee11752ff222a4.angles );
        mdl_toxic_growth.var_dcee11752ff222a4 linkto( e_mover, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        e_mover moveto( self.origin, 0.5 );
        e_mover waittill( #"movedone" );
        e_mover delete();
        
        if ( isdefined( mdl_toxic_growth ) )
        {
            mdl_toxic_growth.var_ee7dc3d79eae1c50 = undefined;
            mdl_toxic_growth show();
            mdl_toxic_growth utility::function_32b24db3127bff40( "base", "on" );
            trigger.origin = mdl_toxic_growth.origin;
            trigger.angles = mdl_toxic_growth.angles;
        }
    }
    
    if ( isalive( self ) )
    {
        self.var_2259f0a89be4759f = undefined;
        self.var_595a3c94bf52f0ce = undefined;
        utility::callsharedfunc( #"zombie_utils", #"setmovespeed", undefined, "tg_zoo", 30 );
        
        if ( mdl_toxic_growth.iscrescent )
        {
            var_e8c4dabd5b94718a = level.zombie_augments[ #"toxic_growth_crescent" ].var_ed7802d0e09e7b68 ?? 3;
            utility::delaythreadendon( var_e8c4dabd5b94718a, [ "toxic_growth_entered", "death" ], &effect_slow::function_80a4bd13b5ba303a, "toxic_growth" );
            
            if ( !self.var_282c85074c0691df )
            {
                utility::delaythreadendon( var_e8c4dabd5b94718a, [ "toxic_growth_entered", "death" ], &utility::function_7c10ea82c1e305b8, #"toxic_growth_fx", #"disable" );
            }
        }
        else
        {
            if ( !self.var_282c85074c0691df )
            {
                utility::function_7c10ea82c1e305b8( #"toxic_growth_fx", #"disable" );
            }
            
            effect_slow::function_80a4bd13b5ba303a( "toxic_growth" );
        }
        
        self notify( "endon_toxic_growth_ai_damage" + string( self getentitynumber() ) );
    }
}

// Namespace field_upgrades_toxic_growth
// Params 2, eflags: 0x4
// Checksum 0xc89e636, Offset: 0x4475
// Size: 0x212
function private function_be100623c581e8af( count = 1, owningplayer )
{
    if ( utility::callsharedfunc( #"zombie", #"hash_bad01cbc996e3dba", self.origin ) )
    {
        spawn_options = common_item::items_initspawnoptions_spawnfromposition( self.origin, self.angles );
        spawn_options.var_4a4b419f66681601 = level.players;
        spawn_options.var_c580c0e8b49f1fcc = 1;
        var_c8c6933d8dfdadb2 = level.zombie_augments[ #"toxic_growth_plant_food" ].var_cd8ddaf98102287f;
        
        if ( isdefined( var_c8c6933d8dfdadb2 ) )
        {
            items = common_item::function_38cde6a6acb68ea6( var_c8c6933d8dfdadb2, count, spawn_options );
            
            if ( items && owningplayer && utility::issharedfuncdefined( #"zm", #"hash_95f8b65e45fc2ef4" ) )
            {
                foreach ( other_player in level.players )
                {
                    if ( other_player == owningplayer )
                    {
                        continue;
                    }
                    
                    if ( !level [[ utility::getsharedfunc( #"zm", #"hash_95f8b65e45fc2ef4" ) ]]( other_player, owningplayer ) )
                    {
                        if ( isarray( items ) )
                        {
                            foreach ( item in items )
                            {
                                item function_b566257a3c6783e8( other_player );
                            }
                            
                            continue;
                        }
                        
                        items function_b566257a3c6783e8( other_player );
                    }
                }
            }
        }
    }
}

// Namespace field_upgrades_toxic_growth
// Params 1, eflags: 0x4
// Checksum 0x1c62f5c, Offset: 0x468f
// Size: 0x2f
function private function_b566257a3c6783e8( player )
{
    if ( isent( self ) )
    {
        self hidefromplayer( player );
        return;
    }
    
    if ( self isscriptableinstance() )
    {
        self function_d6a7b7ef13a57f38( player );
    }
}

// Namespace field_upgrades_toxic_growth
// Params 1, eflags: 0x4
// Checksum 0x7b91493b, Offset: 0x46c6
// Size: 0xbb
function private eat_toxic_growth_plant_food( params )
{
    if ( !isdefined( params.bundle.ref ) || getxhash( params.bundle.ref ) != #"zm_sat_item_toxic_growth_plant_food" )
    {
        return;
    }
    
    n_health_increase = level.zombie_augments[ #"toxic_growth_plant_food" ].var_6bed59a8710b0169 ?? 50;
    utility::callsharedfunc( #"health", #"hash_291dc25cfb86af01", self, #"toxic_growth_plant_food", n_health_increase, self.var_68e0e97561171104.max_health_overcharge );
    playerhealth::updatedeathsdoor();
}

// Namespace field_upgrades_toxic_growth
// Params 1, eflags: 0x4
// Checksum 0xccc5c72d, Offset: 0x4789
// Size: 0x1f8
function private function_8d5505819cc6e1c2( params )
{
    if ( isplayer( params.eattacker.var_6ca4658d0dbdfa45 ) && val::get( "allow_give_point" ) && isdefined( self.kiastring ) )
    {
        kia_string = hashcat( self.kiastring, "_tgrowth" );
        player = params.eattacker.var_6ca4658d0dbdfa45;
        victim = self;
        player thread utility::callsharedfunc( #"player", #"doScoreEvent", kia_string, undefined, undefined, undefined, victim );
    }
    
    if ( !self.var_2259f0a89be4759f && !self.var_282c85074c0691df )
    {
        return;
    }
    
    player = params.eattacker;
    
    if ( isplayer( player ) && player utility::callsharedfunc( #"zombie", #"player_has_augment", #"toxic_growth_plant_food" ) )
    {
        var_4c331cb15673c026 = level.zombie_augments[ #"toxic_growth_plant_food" ].var_176056374fe91a9f ?? 10;
        
        if ( utility::percent_chance( var_4c331cb15673c026 ) )
        {
            thread function_be100623c581e8af( undefined, player );
        }
    }
    
    if ( isplayer( player ) && effect_slow::function_c1be3c9f2d0b92d2( "toxic_growth" ) && self.var_595a3c94bf52f0ce.owner != player )
    {
        sparams = { #count:1, #stats:"slow_assist", #ref:"super_toxic_growth", #field_upgrade:"toxic_growth", #player:self.var_595a3c94bf52f0ce.owner };
        self.var_595a3c94bf52f0ce.owner callback::callback( "on_field_upgrade_kill_track", sparams );
    }
}

// Namespace field_upgrades_toxic_growth
// Params 1, eflags: 0x4
// Checksum 0xe18a5c58, Offset: 0x4989
// Size: 0x11d
function private on_killed_medal( params )
{
    if ( isdefined( params.victim ) && params.victim effect_slow::function_c1be3c9f2d0b92d2( "toxic_growth" ) )
    {
        var_3859f269c2df7552 = params.victim function_3a4ac19ac8748ac2();
        
        foreach ( var_1e4624a03ea41715 in var_3859f269c2df7552 )
        {
            sparams = { #stats:"kills_while_slowed", #ref:"super_toxic_growth", #field_upgrade:"toxic_growth", #victim:params.victim, #player:var_1e4624a03ea41715 };
            var_1e4624a03ea41715 callback::callback( "on_field_upgrade_kill_track", sparams );
        }
    }
}

// Namespace field_upgrades_toxic_growth
// Params 4, eflags: 0x4
// Checksum 0xb094cb4e, Offset: 0x4aae
// Size: 0xe4
function private function_46b4c3e05957a762( victim, einflictor, smeansofdeath, sweapon )
{
    if ( utility::issharedfuncdefined( #"medal", #"track_rapid_kill", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"track_rapid_kill", "toxic_growth", sweapon );
    }
    
    victim.is_lethal_or_super_kill = 1;
    
    if ( isdefined( self.rapidkill_data ) )
    {
        if ( isdefined( self.rapidkill_data[ "toxic_growth" ] ) && self.rapidkill_data[ "toxic_growth" ].rapidkill_count == 10 )
        {
            namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_overgrowth" );
            utility::callsharedfunc( #"sound", #"play_scoreevent_vo", self, #"bc_super_toxic_growth_success" );
        }
    }
}

// Namespace field_upgrades_toxic_growth
// Params 0, eflags: 0x4
// Checksum 0xfb46466a, Offset: 0x4b9a
// Size: 0xaa
function private function_3a4ac19ac8748ac2()
{
    var_3859f269c2df7552 = [];
    
    foreach ( var_c6321cb8cd32b6a0 in self.status_effects[ "slow" ] )
    {
        if ( var_c6321cb8cd32b6a0.unique_id == "toxic_growth" )
        {
            var_3859f269c2df7552[ var_3859f269c2df7552.size ] = var_c6321cb8cd32b6a0.var_1e4624a03ea41715;
        }
    }
    
    return var_3859f269c2df7552;
}

// Namespace field_upgrades_toxic_growth
// Params 1, eflags: 0x4
// Checksum 0xdb43f665, Offset: 0x4c4d
// Size: 0x14
function private function_317b563828f85e00( params )
{
    return function_76e0df8a973d88c7( params );
}

// Namespace field_upgrades_toxic_growth
// Params 1, eflags: 0x4
// Checksum 0xd40922dd, Offset: 0x4c6a
// Size: 0x77, Type: bool
function private function_76e0df8a973d88c7( params )
{
    if ( params.bundle.ref == #"zm_sat_item_toxic_growth_plant_food" && utility::callsharedfunc( #"health", #"hash_bbb5964adc2eedfb" ) )
    {
        var_e835128c969f695 = utility::callsharedfunc( #"health", #"hash_5a1b27fe9a788ec4" );
        
        if ( var_e835128c969f695 )
        {
            return false;
        }
    }
    
    return true;
}

