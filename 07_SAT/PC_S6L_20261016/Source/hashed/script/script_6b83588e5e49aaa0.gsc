// script_6b83588e5e49aaa0  (hash_6b83588e5e49aaa0.gscc) (size: 5755 Bytes / 0x167b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x503732fb (1345794811)
// size ...... 5755 (0x167b)
// includes .. 11  (offset: 0x13f7)
// strings ... 38  (offset: 0x144f)
// dev strs .. 5   (offset: 0x163f)
// exports ... 11  (offset: 0xd37)
// cseg ...... 0x405 + 0x932 (0xd37)
// imports ... 43  (offset: 0xeef)
// animtree1 . 0   (offset: 0x167b)
// animtree2 . 0   (offset: 0x167b)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\equipment;
#using scripts\mp\loot\common_item;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_reward_bundle;

#namespace namespace_1bd1f3bc20420f65;

// Namespace namespace_1bd1f3bc20420f65
// Params 0, eflags: 0x5
// Checksum 0x4a6a5d2b, Offset: 0x423
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_firefly_vdm_ee", undefined, undefined, &post_main );
}

// Namespace namespace_1bd1f3bc20420f65
// Params 0
// Checksum 0x1e2c2c30, Offset: 0x444
// Size: 0x116
function post_main()
{
    if ( !getdvarint( @"hash_dfe5227c40e9c4e0", 0 ) && !getdvarint( @"hash_27d7efd0e2e51e81", 0 ) )
    {
        return;
    }
    
    level utility::flag_wait( "zm_sat_firefly_script_vdm_ee_cs_completed" );
    level utility::flag_wait( "begin_round_logic" );
    level thread init_vending_machines();
    scriptable::scriptable_adddamagedcallback( &hitbox_damaged );
    level callback::add( "on_round_start", &on_round_start );
    
    if ( game_utility::getgametype() == "zm_rb_daisy" )
    {
        level.var_b5eb6fbb656a34da = [ "zmloot_daisy_cans_01", "zmloot_daisy_cans_01_rad", "zmloot_daisy_cans_02", "zmloot_daisy_cans_02_rad", "zmloot_daisy_cans_03", "zmloot_daisy_cans_03_rad", "zmloot_daisy_cans_04", "zmloot_daisy_cans_04_rad" ];
    }
    else
    {
        level.var_b5eb6fbb656a34da = [ "zm_sat_firefly_vdm_food_sponge_cake_box_01", "zm_sat_firefly_vdm_food_bread_bag_01", "zm_sat_firefly_vdm_food_candy_bar_box_01", "zm_sat_firefly_vdm_food_candy_bar_box_03", "zm_sat_firefly_vdm_food_chips_large_bag_01", "zm_sat_firefly_vdm_food_chips_large_bag_02" ];
    }
    
    /#
        init_debug();
    #/
}

// Namespace namespace_1bd1f3bc20420f65
// Params 0
// Checksum 0xb452aa1f, Offset: 0x562
// Size: 0x1ad
function init_vending_machines()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "ee_vdm_models_spawned" );
    var_5a19f001737e07f7 = utility::getstructarray( "vdm_ee_machine", "script_noteworthy" );
    
    foreach ( loc in var_5a19f001737e07f7 )
    {
        mdl = function_47c86977a18df38b( level.var_a07e60759c20be4c, loc.origin );
        
        switch ( loc.script_label )
        {
            case #"hash_b70226fbf48bb9f8":
                if ( zm_quest::function_73720cdf21c3cfd7( #"loot_devouring_ee", #"hash_b9daa02fcf0d060c" ) == 1 )
                {
                    mdl setscriptablepartstate( "model", "destroyed" );
                    continue;
                }
                
                break;
            case #"hash_71ab6ace4e59faac":
                if ( zm_quest::function_73720cdf21c3cfd7( #"loot_devouring_ee", #"hash_eb527f0fae2429c8" ) == 1 )
                {
                    mdl setscriptablepartstate( "model", "destroyed" );
                    continue;
                }
                
                break;
        }
        
        mdl.my_owner = loc;
        
        if ( !isdefined( level.var_a07e60759c20be4c ) )
        {
            level.var_a07e60759c20be4c = [];
        }
        
        level.var_a07e60759c20be4c[ level.var_a07e60759c20be4c.size ] = mdl;
        
        if ( getdvarint( @"hash_3b49fb0009160ae1", 0 ) )
        {
            /#
                mdl thread drawsphere();
            #/
        }
    }
}

// Namespace namespace_1bd1f3bc20420f65
// Params 11
// Checksum 0xe3a374db, Offset: 0x717
// Size: 0x1f3
function hitbox_damaged( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( !isdefined( instance ) || !instance getscriptablehaspart( "vdm_health" ) )
    {
        return;
    }
    
    if ( instance getscriptablepartstate( "model" ) == "destroyed" )
    {
        return;
    }
    
    if ( !isplayer( eattacker ) )
    {
        return;
    }
    
    if ( eattacker.var_23c08b8d00196b63 || eattacker utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_m_mod", #"m_mod_panic_knife" ) )
    {
        instance thread drop_reward( "m_mod" );
        instance setscriptablepartstate( "model", "destroyed" );
        
        switch ( instance.my_owner.script_label )
        {
            case #"hash_b70226fbf48bb9f8":
                zm_quest::function_4eefe6de31f5ddab( #"loot_devouring_ee", #"hash_b9daa02fcf0d060c", 1 );
                break;
            case #"hash_71ab6ace4e59faac":
                zm_quest::function_4eefe6de31f5ddab( #"loot_devouring_ee", #"hash_eb527f0fae2429c8", 1 );
                break;
        }
        
        return;
    }
    
    if ( smeansofdeath != "MOD_MELEE" )
    {
        return;
    }
    
    if ( instance.var_8a252012b028c3c4 && !getdvarint( @"hash_e4bbea896cc65611", 0 ) )
    {
        return;
    }
    
    if ( eattacker getstance() != "prone" && eattacker getstance() != "crouch" )
    {
        return;
    }
    
    instance.var_8a252012b028c3c4 = 1;
    eattacker namespace_9d8e359c3b1041e5::updatehitmarker_sharedfunc( "standard", 0 );
    instance setscriptablepartstate( "audio", "drop_item" );
    instance thread drop_reward( "default" );
}

// Namespace namespace_1bd1f3bc20420f65
// Params 1
// Checksum 0x436c3046, Offset: 0x912
// Size: 0x98
function on_round_start( params )
{
    foreach ( vdm in level.var_a07e60759c20be4c )
    {
        if ( isdefined( vdm.var_8a252012b028c3c4 ) )
        {
            vdm.var_8a252012b028c3c4 = 0;
        }
    }
}

// Namespace namespace_1bd1f3bc20420f65
// Params 1
// Checksum 0xb07cb7ae, Offset: 0x9b2
// Size: 0x20a
function drop_reward( var_c9a582c111824eee )
{
    level endon( #"game_ended" );
    var_8c35aece39872854 = utility::getstructarray( "vdm_ee_drop_source", "script_noteworthy" );
    var_8e30e51dff04d2c3 = utility::getstructarray( "vdm_ee_drop_destination", "script_noteworthy" );
    var_c93ff0ba6fb5078d = utility::getstructarray( "vdm_ee_food_drop_source", "script_noteworthy" );
    s_drop_source = function_47c86977a18df38b( var_8c35aece39872854, self.origin );
    s_drop_destination = function_47c86977a18df38b( var_8e30e51dff04d2c3, self.origin );
    var_fe01cac6afa79420 = function_47c86977a18df38b( var_c93ff0ba6fb5078d, self.origin );
    var_4cb55e34b607c0c9 = randomint( 1000 );
    
    if ( var_4cb55e34b607c0c9 < 10 )
    {
        weap = equipment_mp::getweaponfromequipmentref( "equip_frag" );
        magicgrenademanual( weap.basename, s_drop_destination.origin, ( 0, 0, 0 ) );
        return;
    }
    
    if ( var_c9a582c111824eee == "default" )
    {
        var_4c331cb15673c026 = randomint( 100 );
        
        if ( var_4c331cb15673c026 < 30 )
        {
            str_food = utility::array_random( level.var_b5eb6fbb656a34da );
            food = spawnscriptable( str_food, var_fe01cac6afa79420.origin, var_fe01cac6afa79420.angles );
            food thread function_4114c06f455442b4();
            return;
        }
    }
    
    var_8b5270de14dff72e = zm_round_reward_bundle::function_8cbad2bff5b7cc1( "zm_round_reward_bundle_firefly_vdm_ee_rewards", var_c9a582c111824eee );
    
    for ( i = 0; i < var_8b5270de14dff72e.size ; i++ )
    {
        drop_point = var_8b5270de14dff72e.size > 1 ? getclosestpointonnavmesh( s_drop_destination.origin + ( randomfloatrange( -50, 50 ), randomfloatrange( -50, 50 ), 0 ) ) : s_drop_destination.origin;
        droppeditem = common_item::function_47324f290423b2d1( var_8b5270de14dff72e[ i ], s_drop_source.origin, drop_point );
    }
}

// Namespace namespace_1bd1f3bc20420f65
// Params 0
// Checksum 0xd4105be3, Offset: 0xbc4
// Size: 0x1c
function function_4114c06f455442b4()
{
    level endon( #"game_ended" );
    wait 60;
    
    if ( isdefined( self ) )
    {
        self freescriptable();
    }
}

/#

    // Namespace namespace_1bd1f3bc20420f65
    // Params 0
    // Checksum 0xf498da3a, Offset: 0xbe8
    // Size: 0x2e, Type: dev
    function init_debug()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x3d>", "<dev string:x55>", &function_887290043431f9a6 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_1bd1f3bc20420f65
    // Params 0, eflags: 0x4
    // Checksum 0x253c5ce8, Offset: 0xc1e
    // Size: 0xb3, Type: dev
    function private function_887290043431f9a6()
    {
        if ( !isdefined( level.var_a07e60759c20be4c ) || level.var_a07e60759c20be4c.size == 0 )
        {
            return;
        }
        
        foreach ( mdl in level.var_a07e60759c20be4c )
        {
            mdl setscriptablepartstate( "<dev string:x6d>", "<dev string:x73>" );
            mdl.var_8a252012b028c3c4 = 1;
        }
    }

    // Namespace namespace_1bd1f3bc20420f65
    // Params 0
    // Checksum 0xe2b3b1fc, Offset: 0xcd9
    // Size: 0x5e, Type: dev
    function drawsphere()
    {
        self notify( #"hash_115cbc2ff928e56b" );
        self endon( #"hash_115cbc2ff928e56b" );
        level endon( #"game_ended" );
        
        while ( true )
        {
            color = ( 1, 1, 1 );
            sphere( self.origin, 20, color, 0 );
            waitframe();
        }
    }

#/
