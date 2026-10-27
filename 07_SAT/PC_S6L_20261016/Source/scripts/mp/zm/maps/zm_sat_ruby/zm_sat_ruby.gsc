// scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby.gsc  (hash_412143443a9357e1.gscc) (size: 13186 Bytes / 0x3382 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2fa6b40f (799454223)
// size ...... 13186 (0x3382)
// includes .. 22  (offset: 0x2d96)
// strings ... 98  (offset: 0x2e46)
// dev strs .. 1   (offset: 0x3376)
// exports ... 24  (offset: 0x1e2a)
// cseg ...... 0x82a + 0x1600 (0x1e2a)
// imports ... 95  (offset: 0x21ea)
// animtree1 . 0   (offset: 0x3382)
// animtree2 . 0   (offset: 0x3382)
#using script_282b563937b497ea;
#using script_3d250c1a364843aa;
#using scripts\anim\dialogue;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\compass;
#using scripts\mp\interaction;
#using scripts\mp\load;
#using scripts\mp\magicbox;
#using scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_ee_clocks;
#using scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_fx;
#using scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_lighting;
#using scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_meteor_shower;
#using scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_rb;
#using scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_script_game_over_scenes_cs;
#using scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_script_museum_interacts_cs;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\systems\zone_manager;

#namespace zm_sat_ruby;

// Namespace zm_sat_ruby
// Params 0
// Checksum 0xb068011a, Offset: 0x848
// Size: 0x35b
function main()
{
    zm_sat_ruby_art::main();
    zm_sat_ruby_fx::main();
    zm_sat_ruby_lighting::main();
    namespace_c0b4f2882c9d100f::function_55319be40b828f47( #"game_over", #"hash_3e1754ce616f9085" );
    namespace_c0b4f2882c9d100f::function_55319be40b828f47( #"full_ammo", #"hash_18ba0618b6270c3a" );
    namespace_c0b4f2882c9d100f::function_55319be40b828f47( #"double_points", #"hash_18c3fd18b62f5174" );
    namespace_c0b4f2882c9d100f::function_55319be40b828f47( #"insta_kill", #"hash_18d4e018b63d9360" );
    namespace_c0b4f2882c9d100f::function_55319be40b828f47( #"fire_sale", #"hash_18cae818b6354c73" );
    namespace_c0b4f2882c9d100f::function_55319be40b828f47( #"full_armor", #"hash_18b9e918b626daf3" );
    namespace_c0b4f2882c9d100f::function_55319be40b828f47( #"nuke", #"hash_18e5e018b64c0693" );
    namespace_c0b4f2882c9d100f::function_55319be40b828f47( #"bonus_points_team", #"hash_18bcf118b6291e62" );
    namespace_c0b4f2882c9d100f::function_55319be40b828f47( #"full_power", #"hash_18cae918b6354e26" );
    namespace_c0b4f2882c9d100f::function_55319be40b828f47( #"free_perk", #"hash_18f3f118b65860d2" );
    namespace_c0b4f2882c9d100f::function_55319be40b828f47( #"eternal_perk", #"hash_8ffa54e0c42a52da" );
    magicbox::function_193ed9e2a7303c24( #"bunny_sound_ruby" );
    namespace_c0b4f2882c9d100f::function_8464c50734af5965();
    load::main();
    zm_sat_ruby_script_game_over_scenes_cs::main();
    
    if ( game_utility::function_21211f3255f8ea58() )
    {
        level thread function_9047b1a8249cec19();
    }
    
    if ( game_utility::getgametype() == "zm_rb_battle" )
    {
        level thread function_f7afc330c6f48a25();
    }
    
    compass::setupminimap( "compass_map_zm_sat_ruby" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    level.ttlos_suppressasserts = 1;
    level.vending_machines_powered_on_at_start = 0;
    level thread init_powered_zones();
    level thread init_museum_interacts();
    level thread zm_sat_ruby_rb::init();
    level thread namespace_8a6b6b859e6fcad::init();
    level thread zm_sat_ruby_meteor_shower::init();
    level thread zm_sat_ruby_rb::handle_dynamic_traversal();
    level thread function_d3a141d18bd0eceb();
    level thread function_9841adcaec4a01e2();
    callback::add( "on_zombie_ai_spawned", &function_e22751f52eed7c7c );
    callback::add( "zone_changed", &on_zone_changed );
    level thread function_18d7a0868d0f3dc0();
    utility::registersharedfunc( #"hash_f2451a0850e06732", #"hash_f2451a0850e06732", &function_7d67609e47cc44e5 );
    level.var_7a5a3a48204781da = &function_8119d87ac1486f12;
    level.var_4798e0076da78416 = [ "hellstorm_missile", "chopper_door_gunner", "toma_strike" ];
    level.var_82608d37301e46de = [ "zone_mainhall", "zone_planetarium", "zone_orrery", "zone_telescope", "zone_orrery_airlock", "zone_mainhall_left", "zone_planetarium_hallway_01", "zone_planetarium_hallway_02", "zone_planetarium_hallway_03", "zone_orrery_close_to_mainhall", "zone_orrery_upper_floor", "zone_orrery_close_to_courtyard", "zone_telescope_close_to_pathway", "zone_orrery_lower", "zone_sunken_garage", "zone_sunken_shops_mercantile", "zone_sunken_brothel_shops", "zone_sunken_shops_interior", "zone_sunken_sheriff_interior" ];
    level thread function_75dd99bb99513a9();
    getent( "ruby_ee_rocket", #targetname ) hide();
}

// Namespace zm_sat_ruby
// Params 0
// Checksum 0x425ac646, Offset: 0xbab
// Size: 0x2c1
function function_75dd99bb99513a9()
{
    if ( zm_save::function_1dda3554974a999e() )
    {
        var_19f3efffa816a9ab = getent( "broken_museum_building_top", #targetname );
        
        if ( var_19f3efffa816a9ab )
        {
            var_19f3efffa816a9ab delete();
        }
        
        return;
    }
    
    if ( getdvarint( @"hash_568824da69e7989", 0 ) )
    {
        return;
    }
    
    level utility::flag_wait( "begin_round_logic" );
    s_meteor = utility::getstruct( "meteor_strike" );
    b_meteor_strike = 0;
    
    while ( !b_meteor_strike )
    {
        foreach ( player in level.players )
        {
            if ( distance2dsquared( player.origin, s_meteor.origin ) <= squared( 2200 ) )
            {
                b_meteor_strike = 1;
            }
        }
        
        wait 0.1;
    }
    
    meteor = spawnscriptable( %"ruby_meteor_impact", ( -465.2, 8.9, 1144.1 ), ( 0, 94, 0 ) );
    meteor setscriptablepartstate( "vfx", "meteor" );
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"meteor_event" );
    wait 5;
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) )
        {
            player earthquakeforplayer( 0.4, 3, player.origin, 2000 );
            player playrumblelooponentity( "ground_pound_land" );
        }
    }
    
    var_19f3efffa816a9ab = getent( "broken_museum_building_top", #targetname );
    
    if ( var_19f3efffa816a9ab )
    {
        var_19f3efffa816a9ab delete();
    }
    
    wait 3;
    meteor freescriptable();
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) )
        {
            player stoprumble( "ground_pound_land" );
        }
    }
}

// Namespace zm_sat_ruby
// Params 3
// Checksum 0x4f63ba35, Offset: 0xe74
// Size: 0x139
function function_7d67609e47cc44e5( valid_locations, var_499f1feeb9d67e34, var_5d0e2752401d5c18 )
{
    foreach ( location in var_499f1feeb9d67e34 )
    {
        if ( location.script_location == "zone_temple" )
        {
            var_499f1feeb9d67e34 = arrayremove( var_499f1feeb9d67e34, location );
            break;
        }
    }
    
    foreach ( location in var_5d0e2752401d5c18 )
    {
        if ( location.script_location == "zone_temple" )
        {
            var_5d0e2752401d5c18 = arrayremove( var_5d0e2752401d5c18, location );
            break;
        }
    }
    
    return [ valid_locations, var_499f1feeb9d67e34, var_5d0e2752401d5c18 ];
}

// Namespace zm_sat_ruby
// Params 0
// Checksum 0xb6afa9c8, Offset: 0xfb6
// Size: 0x2
function init_powered_zones()
{
    
}

// Namespace zm_sat_ruby
// Params 0
// Checksum 0x3aa194a9, Offset: 0xfc0
// Size: 0x140
function init_museum_interacts()
{
    level thread zm_sat_ruby_script_museum_interacts_cs::main();
    level utility::flag_wait( "zm_sat_ruby_script_museum_interacts_cs_completed" );
    level utility::flag_wait( "scriptables_ready" );
    var_32a3107e997acd94 = utility::getstructarray( "ruby_museum_interact", "targetname" );
    
    foreach ( s_museum_interact in var_32a3107e997acd94 )
    {
        museum_interact = spawnscriptable( "ruby_scriptable_museum_interact", s_museum_interact.origin, s_museum_interact.angles );
        museum_interact.exhibit_name = s_museum_interact.script_noteworthy;
        museum_interact.var_212148f87f1b2748 = s_museum_interact.alias1;
        museum_interact.var_21214bf87f1b2de1 = s_museum_interact.alias2;
        museum_interact = interaction::register_scriptable_interact( museum_interact, &on_museum_exhibit_interact );
        s_museum_interact.interact = museum_interact;
        museum_interact interaction::set_interact_hint_callback( &museum_exhibit_interact_hint );
    }
}

// Namespace zm_sat_ruby
// Params 1, eflags: 0x4
// Checksum 0xcf033a92, Offset: 0x1108
// Size: 0x127
function private on_museum_exhibit_interact( player )
{
    self setscriptablepartstate( "base", "off" );
    params = spawnstruct();
    params.interact = self;
    params.exhibit_name = self.exhibit_name;
    level callback::callback( "museum_exhibit_interact", params );
    
    if ( !self.exhibit_name )
    {
        self setscriptablepartstate( "audio", "static" );
    }
    else if ( self.exhibit_name != "vo_twins" && !self.var_6769eb6aa44f1537 )
    {
        self setscriptablepartstate( "audio", "activate" );
        narrator_ent = utility::spawn_model( "tag_origin", self.origin );
        
        if ( isdefined( self.var_212148f87f1b2748 ) )
        {
            narrator_ent dialogue::say( self.var_212148f87f1b2748, 1 );
        }
        
        if ( isdefined( self.var_21214bf87f1b2de1 ) )
        {
            narrator_ent dialogue::say( self.var_21214bf87f1b2de1, 1 );
        }
        
        narrator_ent delete();
    }
    
    wait 5;
    self setscriptablepartstate( "base", "small" );
}

// Namespace zm_sat_ruby
// Params 2, eflags: 0x4
// Checksum 0x196f9ec9, Offset: 0x1237
// Size: 0x89
function private museum_exhibit_interact_hint( usable, player )
{
    if ( zm_quest::function_b0a5181ebe7bb905() && !player.interactions_disabled )
    {
        return { #var_26bbd300351fde34:0, #string:&"zm_sat_ruby/platform_button", #type:"HINT_BUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_ruby
// Params 0
// Checksum 0x4145f617, Offset: 0x12c8
// Size: 0xa8
function function_9841adcaec4a01e2()
{
    level utility::flag_init( "l_g_active" );
    level endon( #"game_ended" );
    
    /#
    #/
    
    grav_scale = 0.25;
    low_g_def = utility::getstruct( "low_g_center", "targetname" );
    level.var_31b35d5776e26551 = function_bddc4b01d91e703e( low_g_def.origin, low_g_def.radius, low_g_def.height );
    level.var_31b35d5776e26551 function_9e6dce8f55a09ff0( 1, grav_scale );
    level utility::flag_wait( "power_on" );
    function_7b0eb6e2b5731d0c( level.var_31b35d5776e26551, 1 );
}

// Namespace zm_sat_ruby
// Params 2
// Checksum 0x1ccb11d7, Offset: 0x1378
// Size: 0xd2
function function_7b0eb6e2b5731d0c( volume, setstate )
{
    if ( utility::flag( "l_g_active" ) == setstate )
    {
        return;
    }
    
    if ( !isdefined( volume ) || !isdefined( setstate ) || !( setstate == 0 || setstate == 1 ) )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    if ( !utility::flag( "l_g_active" ) && ( setstate == 1 || getdvarint( @"hash_9708199d6a4e4bd4" ) ) )
    {
        level utility::flag_set( "l_g_active" );
        volume function_76a9233685c24f79( 1 );
        volume forcenetfieldhighlod( 1 );
        
        if ( getdvarint( @"hash_9708199d6a4e4bd4" ) )
        {
            return;
        }
        
        return;
    }
    
    level utility::flag_clear( "l_g_active" );
    volume function_76a9233685c24f79( 0 );
    volume forcenetfieldhighlod( 0 );
}

// Namespace zm_sat_ruby
// Params 0
// Checksum 0x2a4e8956, Offset: 0x1452
// Size: 0x24e
function function_620114dd2340ecc4()
{
    self notify( #"hash_3d0c5cf66ec44a1a" );
    self endon( #"hash_3d0c5cf66ec44a1a" );
    level endon( #"game_ended" );
    utility::flag_wait( "scriptables_ready" );
    var_646c703284cdb287 = utility::getstruct( "step4_perfusion_mars_interact", "targetname" );
    var_21a4d0c3cdc24f54 = getent( "ruby_boss_uranus_panel_script_model", #targetname );
    
    while ( true )
    {
        if ( utility::flag( "stop_mars_gravity_cycle_low_g_on" ) || utility::flag( "stop_mars_gravity_cycle_low_g_off" ) )
        {
            break;
        }
        
        playsoundatpos( var_646c703284cdb287.origin + ( 0, 0, 50 ), "evt_low_grav_alarm" );
        level utility::waittill_notify_or_timeout( "stop_mars_gravity_cycle", 3.5 );
        
        if ( utility::flag( "stop_mars_gravity_cycle_low_g_on" ) || utility::flag( "stop_mars_gravity_cycle_low_g_off" ) )
        {
            break;
        }
        
        if ( utility::flag( "l_g_active" ) )
        {
            var_22ec78bd3e26f7df = 40;
            random_modifier = 10;
            
            if ( !utility::flag( "ruby_boss_triggered" ) )
            {
                playsoundatpos( var_646c703284cdb287.origin + ( 0, 0, 50 ), "evt_low_grav_off" );
                var_21a4d0c3cdc24f54 setscriptablepartstate( "gravity", "off" );
                var_21a4d0c3cdc24f54 setscriptablepartstate( "anim", "closed" );
            }
        }
        else
        {
            var_22ec78bd3e26f7df = 70;
            random_modifier = 10;
            
            if ( !utility::flag( "ruby_boss_triggered" ) )
            {
                playsoundatpos( var_646c703284cdb287.origin + ( 0, 0, 50 ), "evt_low_grav_start" );
                var_21a4d0c3cdc24f54 setscriptablepartstate( "gravity", "on" );
                var_21a4d0c3cdc24f54 setscriptablepartstate( "anim", "open" );
            }
        }
        
        function_7b0eb6e2b5731d0c( level.var_31b35d5776e26551, !utility::flag( "l_g_active" ) );
        level utility::waittill_notify_or_timeout( "stop_mars_gravity_cycle", var_22ec78bd3e26f7df + randomint( random_modifier ) );
    }
    
    if ( utility::flag( "stop_mars_gravity_cycle_low_g_on" ) )
    {
        function_7b0eb6e2b5731d0c( level.var_31b35d5776e26551, 1 );
    }
    else if ( utility::flag( "stop_mars_gravity_cycle_low_g_off" ) )
    {
        function_7b0eb6e2b5731d0c( level.var_31b35d5776e26551, 0 );
    }
    
    level utility::flag_clear( "stop_mars_gravity_cycle_low_g_on" );
    level utility::flag_clear( "stop_mars_gravity_cycle_low_g_off" );
}

// Namespace zm_sat_ruby
// Params 1
// Checksum 0x17bfb198, Offset: 0x16a8
// Size: 0x3a
function function_198c9c1c95647900( low_g_on )
{
    if ( low_g_on )
    {
        level utility::flag_set( "stop_mars_gravity_cycle_low_g_on" );
    }
    else
    {
        level utility::flag_set( "stop_mars_gravity_cycle_low_g_off" );
    }
    
    level notify( #"stop_mars_gravity_cycle" );
}

// Namespace zm_sat_ruby
// Params 0
// Checksum 0x6ada80a4, Offset: 0x16ea
// Size: 0xfb
function function_9047b1a8249cec19()
{
    level utility::flag_set( "survival_map_setup_finished" );
    level utility::flag_wait( "begin_round_logic" );
    a_s_fasttravel_triggers = utility::getstructarray( "zm_fasttravel", "targetname" );
    
    foreach ( fasttravel in a_s_fasttravel_triggers )
    {
        if ( fasttravel.script_parameters == "orrery" )
        {
            fasttravel.var_2efb9165f56da06d = 0;
        }
    }
    
    level thread zm_sat_ruby_ee_clocks::function_913768573ef1a0c4();
    level callback::add( #"hash_8e2728470d1fa87a", &function_4b0d9da35e54b6a5 );
    level callback::add( #"item_spawn_allowed", &function_4b0d9da35e54b6a5 );
    function_620114dd2340ecc4();
}

// Namespace zm_sat_ruby
// Params 1
// Checksum 0x6babe97a, Offset: 0x17ed
// Size: 0xdf, Type: bool
function function_4b0d9da35e54b6a5( params )
{
    mapinfo = getactivemapinfobundle();
    
    if ( !isdefined( mapinfo.var_3280159b3d3f3a35 ) )
    {
        return false;
    }
    
    foreach ( itemref in mapinfo.var_3280159b3d3f3a35 )
    {
        itembundle = getscriptbundle( itemref.itemspawnentry );
        
        if ( itembundle.ref == params.itembundle.ref )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace zm_sat_ruby
// Params 1
// Checksum 0x11378e2e, Offset: 0x18d5
// Size: 0x3f
function function_e22751f52eed7c7c( params )
{
    if ( self.aicategory == "special" || self.subclass == "zombie_base" )
    {
        thread zombie_zone_watcher();
    }
    
    thread function_996195ca6bd8fe58();
}

// Namespace zm_sat_ruby
// Params 0
// Checksum 0x72d7dbb6, Offset: 0x191c
// Size: 0x11b
function zombie_zone_watcher()
{
    self endon( #"death" );
    var_8c4fe62d01999d1e = undefined;
    
    while ( !isdefined( var_8c4fe62d01999d1e ) )
    {
        var_8c4fe62d01999d1e = zone_manager::get_current_zone();
        waitframe();
    }
    
    if ( var_8c4fe62d01999d1e.zone_name == "zone_temple" || var_8c4fe62d01999d1e.zone_name == "zone_temple_center" || var_8c4fe62d01999d1e.zone_name == "zone_temple_displays" || var_8c4fe62d01999d1e.zone_name == "zone_temple_left" || var_8c4fe62d01999d1e.zone_name == "zone_temple_left_middle" || var_8c4fe62d01999d1e.zone_name == "zone_temple_left_upper" || var_8c4fe62d01999d1e.zone_name == "zone_temple_middle_lower" || var_8c4fe62d01999d1e.zone_name == "zone_temple_right" || var_8c4fe62d01999d1e.zone_name == "zone_temple_right_middle" || var_8c4fe62d01999d1e.zone_name == "zone_temple_to_shrine" || var_8c4fe62d01999d1e.zone_name == "zone_temple_tech" )
    {
        thread function_fce81d147946fd6e();
    }
}

// Namespace zm_sat_ruby
// Params 0
// Checksum 0x5ac41f5e, Offset: 0x1a3f
// Size: 0x42
function function_fce81d147946fd6e()
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( self function_86ed482450424a47() < 1 )
        {
            utility::ent_flag_set( "in_low_grav" );
        }
        else
        {
            utility::ent_flag_clear( "in_low_grav" );
        }
        
        wait 1;
    }
}

// Namespace zm_sat_ruby
// Params 0
// Checksum 0x9c05d217, Offset: 0x1a89
// Size: 0x97
function function_996195ca6bd8fe58()
{
    self endon( #"death" );
    var_9923c2ff9d1096fb = utility::getstruct( "mars_stairs_bottom" ).origin[ 2 ];
    var_9e33fff145c25623 = utility::getstruct( "mars_stairs_top" ).origin[ 2 ];
    
    while ( self.origin[ 2 ] > var_9923c2ff9d1096fb && self.origin[ 2 ] < var_9e33fff145c25623 )
    {
        self.var_a13bed1ac47e1b2c = 1;
        wait 0.5;
    }
    
    self.var_a13bed1ac47e1b2c = 0;
}

// Namespace zm_sat_ruby
// Params 0
// Checksum 0x3c8c92ff, Offset: 0x1b28
// Size: 0x35
function function_d3a141d18bd0eceb()
{
    level.var_eafbf349af925860 = getent( "step3_orrey_clip", "script_noteworthy" );
    level.var_eafbf349af925860 notsolid();
    level.var_eafbf349af925860 connectpaths();
}

// Namespace zm_sat_ruby
// Params 1
// Checksum 0x87da95ed, Offset: 0x1b65
// Size: 0xe4
function on_zone_changed( params )
{
    if ( isdefined( params.zone_struct ) )
    {
        if ( isstartstr( params.zone_struct.script_zone_name, "zone_temple" ) && !self.is_on_mars )
        {
            self.is_on_mars = 1;
        }
        else if ( !isstartstr( params.zone_struct.script_zone_name, "zone_temple" ) && self.is_on_mars )
        {
            self.is_on_mars = undefined;
        }
        
        if ( utility::flag( "ruby_mq_s3_orrery_defend_success" ) )
        {
            function_1b3de6ab79deb1b7( self );
        }
        
        if ( arraycontains( level.var_82608d37301e46de, params.zone_struct.script_zone_name ) )
        {
            self.var_b43d27527f482c08 = 1;
            return;
        }
        
        self.var_b43d27527f482c08 = undefined;
    }
}

// Namespace zm_sat_ruby
// Params 1
// Checksum 0x8f3605d6, Offset: 0x1c51
// Size: 0x5a
function function_1b3de6ab79deb1b7( player )
{
    if ( level.var_18cae6c63b0f0662 && player.is_on_mars || !level.var_18cae6c63b0f0662 && !player.is_on_mars )
    {
        zm_quest::function_1a1a1e0bd84ac45e( player );
        return;
    }
    
    zm_quest::function_38cacc34ddb8431c( player );
}

// Namespace zm_sat_ruby
// Params 2, eflags: 0x4
// Checksum 0xe38f8730, Offset: 0x1cb3
// Size: 0x46
function private function_8119d87ac1486f12( streakitem, slotnumber )
{
    if ( isdefined( self.var_b43d27527f482c08 ) && arraycontains( level.var_4798e0076da78416, streakitem.streakname ) )
    {
        return 0;
    }
    
    return 1;
}

// Namespace zm_sat_ruby
// Params 0
// Checksum 0x7e7574c7, Offset: 0x1d01
// Size: 0xb3
function function_f7afc330c6f48a25()
{
    level utility::flag_wait( "begin_round_logic" );
    a_s_fasttravel_triggers = utility::getstructarray( "zm_fasttravel", "targetname" );
    
    foreach ( fasttravel in a_s_fasttravel_triggers )
    {
        if ( fasttravel.script_parameters == "orrery" )
        {
            fasttravel.var_2efb9165f56da06d = 0;
        }
    }
}

// Namespace zm_sat_ruby
// Params 0, eflags: 0x4
// Checksum 0x8428fcc8, Offset: 0x1dbc
// Size: 0x6e
function private function_18d7a0868d0f3dc0()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "zm_init_done" );
    level utility::flag_wait( "begin_round_logic" );
    level.var_4c33e1cd56ccc717 = getent( "rh_col_coffin", #targetname );
    
    if ( !isdefined( level.var_4c33e1cd56ccc717 ) )
    {
        return;
    }
    
    level.var_4c33e1cd56ccc717 connectpaths();
    level.var_4c33e1cd56ccc717 notsolid();
}

