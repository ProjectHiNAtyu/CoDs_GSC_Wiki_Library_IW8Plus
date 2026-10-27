// scripts\mp\common\field_upgrades\field_upgrades_wiley_fox.gsc  (hash_58a7afb94c0d7832.gscc) (size: 27521 Bytes / 0x6b81 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3d0e0e3a (1024331322)
// size ...... 27521 (0x6b81)
// includes .. 21  (offset: 0x64c1)
// strings ... 73  (offset: 0x6569)
// dev strs .. 10  (offset: 0x6b09)
// exports ... 54  (offset: 0x4711)
// cseg ...... 0x6f4 + 0x401d (0x4711)
// imports ... 168 (offset: 0x4f81)
// animtree1 . 0   (offset: 0x6b81)
// animtree2 . 0   (offset: 0x6b81)
#using script_16ea1b94f0f381b3;
#using scripts\asm\shared\mp\utility;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_traverse;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\status_effects\effect_burn;
#using scripts\common\status_effects\effect_slow;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vortex;
#using scripts\mp\common\equipment\molotov;
#using scripts\mp\common\field_upgrades\field_upgrades;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\content_manager;
#using scripts\mp\supers;
#using scripts\mp\weapons;

#namespace field_upgrades_wiley_fox;

// Namespace field_upgrades_wiley_fox
// Params 0, eflags: 0x5
// Checksum 0xd7ff824, Offset: 0x712
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"wiley_fox", undefined, undefined, &init );
}

// Namespace field_upgrades_wiley_fox
// Params 0
// Checksum 0xebd87691, Offset: 0x733
// Size: 0x308
function init()
{
    superbundle = field_upgrades::function_1fcc83f10e7752e5( "super_wiley_fox" );
    
    if ( !isdefined( superbundle ) )
    {
        return;
    }
    
    level.wiley_fox = {};
    level._effect[ "vfx_t10_gameplay_zm_weapons_fld_dark_flare_shadow_ball_explo_sm" ] = loadfxasset( "vfx_t10_gameplay_zm_weapons_fld_dark_flare_shadow_ball_explo_sm" );
    level._effect[ "vfx_sat_gameplay_zm_weapons_fld_wf_wild_fire_zmb_imp" ] = loadfxasset( "vfx_sat_gameplay_zm_weapons_fld_wf_wild_fire_zmb_imp" );
    level._effect[ "vfx_sat_gameplay_zm_weapons_fld_wf_wild_fire_ball_trail" ] = loadfxasset( "vfx_sat_gameplay_zm_weapons_fld_wf_wild_fire_ball_trail" );
    level._effect[ "vfx_sat_gameplay_zm_weapons_fld_wf_wild_fire_ball_explo" ] = loadfxasset( "vfx_sat_gameplay_zm_weapons_fld_wf_wild_fire_ball_explo" );
    level._effect[ "vfx_sat_gameplay_zm_weapons_fld_wf_wild_fire_tornado_disperse" ] = loadfxasset( "vfx_sat_gameplay_zm_weapons_fld_wf_wild_fire_tornado_disperse" );
    level._effect[ "vfx_sat_gameplay_zm_weapons_fld_wf_wild_fire_ball_despawn" ] = loadfxasset( "vfx_sat_gameplay_zm_weapons_fld_wf_wild_fire_ball_despawn" );
    level._effect[ "vfx_sat_gameplay_zm_weapons_fld_wf_wild_fire_flashover_ground_ch01" ] = loadfxasset( "vfx_sat_gameplay_zm_weapons_fld_wf_wild_fire_flashover_ground_ch01" );
    level._effect[ "vfx_sat_gameplay_zm_weapons_fld_wf_wild_fire_circle_base_ground_ch01" ] = loadfxasset( "vfx_sat_gameplay_zm_weapons_fld_wf_wild_fire_circle_base_ground_ch01" );
    utility::flag_wait( "supers_initialized" );
    supers_mp::function_48aaa60b2ce7b8a1( "super_wiley_fox", &set_wiley_fox, &unset_wiley_fox, &begin_use_wiley_fox, &function_9b8c221e82091f98, undefined, &set_wiley_fox );
    
    /#
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_command( "<dev string:x3a>", "<dev string:x49>" );
        devgui::add_devgui_command( "<dev string:x74>", "<dev string:x86>" );
        devgui::function_77df7fe7dd273e10();
    #/
    
    sweapon = function_cd9c9a91097d6b7a();
    
    if ( utility::issharedfuncdefined( #"medal", #"register_on_kill_medal_callback", 0 ) && isweapon( sweapon ) && !isnullweapon( sweapon ) )
    {
        utility::callsharedfunc( #"medal", #"register_on_kill_medal_callback", sweapon.basename, &on_killed_medal );
    }
    
    if ( utility::issharedfuncdefined( #"medal", #"register_on_kill_medal_callback", 0 ) )
    {
        if ( isdefined( level.field_upgrade_bundles[ "super_wiley_fox" ] ) )
        {
            wileyfoxweapon = level.field_upgrade_bundles[ "super_wiley_fox" ].offhandweapon;
            
            if ( isdefined( wileyfoxweapon ) )
            {
                utility::callsharedfunc( #"medal", #"register_on_kill_medal_callback", wileyfoxweapon, &function_46b4c3e05957a762 );
            }
            
            var_8ac0f54f118c9b95 = level.zombie_augments[ #"wiley_fox_freeradical" ].var_56671611da19f6ab ?? %"sat_molotov_zm_wileyfox";
            
            if ( isweapon( var_8ac0f54f118c9b95 ) && !isnullweapon( var_8ac0f54f118c9b95 ) )
            {
                utility::callsharedfunc( #"medal", #"register_on_kill_medal_callback", var_8ac0f54f118c9b95, &function_46b4c3e05957a762 );
            }
        }
    }
    
    level.wiley_fox.throttle = throttle::throttle_initialize( "super_wiley_fox", 2 );
    level.wiley_fox.objweapon = sweapon;
    
    if ( !isdefined( level.wiley_fox.var_28079045bda30435 ) )
    {
        level.wiley_fox.var_28079045bda30435 = [];
    }
}

// Namespace field_upgrades_wiley_fox
// Params 0
// Checksum 0x3272f5ec, Offset: 0xa43
// Size: 0x8b
function function_8d49fd253faf38ee()
{
    foreach ( player in level.players )
    {
        if ( player utility::ent_flag( "wiley_fox_active" ) )
        {
            player function_9b8c221e82091f98();
        }
    }
}

// Namespace field_upgrades_wiley_fox
// Params 1, eflags: 0x4
// Checksum 0xff43fbf6, Offset: 0xad6
// Size: 0xc
function private on_zombie_ai_damaged( params )
{
    
}

// Namespace field_upgrades_wiley_fox
// Params 0
// Checksum 0x2b0afdfa, Offset: 0xaea
// Size: 0x8e4
function set_wiley_fox()
{
    self.wiley_fox_settings = spawnstruct();
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"wiley_fox_firestorm" ) )
    {
        self.wiley_fox_settings.firestorm_active = 1;
        self.wiley_fox_settings.firestorm_spawn_dist = level.zombie_augments[ #"wiley_fox_firestorm" ].var_c96a95fc32528ba5 ?? 24;
        self.wiley_fox_settings.firestorm_move_dist = level.zombie_augments[ #"wiley_fox_firestorm" ].var_b8383cbda7e9ef57 ?? 100;
        self.wiley_fox_settings.var_98f880cbf937d77b = level.zombie_augments[ #"wiley_fox_firestorm" ].var_f25dde19f82fbbe6 ?? 0.4;
        self.wiley_fox_settings.firestorm_pull_radius = level.zombie_augments[ #"wiley_fox_firestorm" ].var_c57e3f1953efc03f ?? 90;
        self.wiley_fox_settings.firestorm_damage_radius = level.zombie_augments[ #"wiley_fox_firestorm" ].var_f0c7caf77e2ecf5 ?? 48;
        self.wiley_fox_settings.firestorm_damage = level.zombie_augments[ #"wiley_fox_firestorm" ].var_efe62fef6b7026a7 ?? 0.4;
        self.wiley_fox_settings.var_c332123c5efa9fb4 = level.zombie_augments[ #"wiley_fox_firestorm" ].var_15d2612db67a94dc ?? 48;
        self.wiley_fox_settings.var_14ebcef9c3a6ee7f = level.zombie_augments[ #"wiley_fox_firestorm" ].var_2971043f17d215a5 ?? 0.5;
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"wiley_fox_freeradical" ) )
    {
        self.wiley_fox_settings.var_b9de534c4a81bff0 = 1;
        self.wiley_fox_settings.var_423820613d22be44 = level.zombie_augments[ #"wiley_fox_freeradical" ].var_558cd18214a44390 ?? 0.2;
        self.wiley_fox_settings.var_6379ae92bc2440d7 = level.zombie_augments[ #"wiley_fox_freeradical" ].var_54ede2ee93d7a3 ?? 32;
        self.wiley_fox_settings.var_88c04b3deb711ebd = level.zombie_augments[ #"wiley_fox_freeradical" ].var_8d4215a13189f49 ?? 3;
        self.wiley_fox_settings.var_332c841f44578cc2 = level.zombie_augments[ #"wiley_fox_freeradical" ].var_213cf9bf1ba9d63e ?? 5;
        self.wiley_fox_settings.var_4617b44113056db = level.zombie_augments[ #"wiley_fox_freeradical" ].var_7de33b87995abe17 ?? 2;
        self.wiley_fox_settings.var_38ed291b29c47875 = level.zombie_augments[ #"wiley_fox_freeradical" ].var_56671611da19f6ab ?? %"sat_molotov_zm_wileyfox";
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"wiley_fox_fireball" ) )
    {
        self.wiley_fox_settings.fireball_active = 1;
        self.wiley_fox_settings.var_8ba032eda7c0ca98 = level.zombie_augments[ #"wiley_fox_fireball" ].var_64f4cfdade7b61ff ?? 1;
        self.wiley_fox_settings.fireball_damage_percent = level.zombie_augments[ #"wiley_fox_fireball" ].var_2156771241445406 ?? 0.5;
        self.wiley_fox_settings.fireball_fire_rate = level.zombie_augments[ #"wiley_fox_fireball" ].var_de1de3409eb1b39e ?? 0.5;
        self.wiley_fox_settings.fireball_range = level.zombie_augments[ #"wiley_fox_fireball" ].var_ed968622dc45b2ad ?? 2000;
        self.wiley_fox_settings.fireball_radius = level.zombie_augments[ #"wiley_fox_fireball" ].var_87d11b3b87126b4e ?? 5;
        self.wiley_fox_settings.fireball_up_offset = level.zombie_augments[ #"wiley_fox_fireball" ].var_435fe595d1117a3f ?? 0.5;
        self.wiley_fox_settings.fireball_horizontal_offset = level.zombie_augments[ #"wiley_fox_fireball" ].var_61b66704783b8482 ?? 0.5;
        self.wiley_fox_settings.fireball_forward_offset = level.zombie_augments[ #"wiley_fox_fireball" ].var_34753bf4907a539 ?? 0.5;
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"wiley_fox_flashover" ) )
    {
        self.wiley_fox_settings.flashover_active = 1;
        self.wiley_fox_settings.flashover_radius = level.zombie_augments[ #"wiley_fox_flashover" ].var_b78307be95f9eb79 ?? 256;
        self.wiley_fox_settings.flashover_damage = level.zombie_augments[ #"wiley_fox_flashover" ].var_2aad6127ec1dc19a ?? 0.75;
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"wiley_fox_oxidizer" ) )
    {
        base_duration = field_upgrades::function_5f728868b18ef0c0( "super_wiley_fox", #"hash_50e0747334dae395" );
        
        if ( !isdefined( base_duration ) )
        {
            base_duration = 8;
        }
        
        self.var_87e9b1896b9a4e5f = base_duration;
        extend_scale = level.zombie_augments[ #"wiley_fox_oxidizer" ].var_68f58cf538cabf53 ?? 1;
        self.super.staticdata.usetime = base_duration * ( 1 + extend_scale );
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"wiley_fox_backdraft" ) )
    {
        backdraftduration = level.zombie_augments[ #"wiley_fox_backdraft" ].var_cf32f87b6ca8bdf1 ?? 0;
        self.wiley_fox_settings.backdraftactive = 1;
        self.wiley_fox_settings.backdraftduration = backdraftduration;
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"wiley_fox_moltencore" ) )
    {
        self.wiley_fox_settings.var_b201a05210ce396f = level.zombie_augments[ #"wiley_fox_moltencore" ].var_27ea3d17d5fe2352 ?? 0.4;
        self.wiley_fox_settings.var_7e3a77604eaa1c50 = level.zombie_augments[ #"wiley_fox_moltencore" ].var_7ee1e0905576fd31 ?? 90;
        self.wiley_fox_settings.var_a22df49682088cc9 = level.zombie_augments[ #"wiley_fox_moltencore" ].var_c11032716f4d7bf4 ?? 0.2;
        self.wiley_fox_settings.var_fdbd6f4aab55499e = level.zombie_augments[ #"wiley_fox_moltencore" ].var_cee3b7875e449aa7 ?? 120;
        self.wiley_fox_settings.var_49668c5a2d9216d0 = 1;
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"wiley_fox_heatsurge" ) )
    {
        self.wiley_fox_settings.var_c5ff28c44013ef20 = level.zombie_augments[ #"wiley_fox_heatsurge" ].var_3426f8fca4a2779 ?? 0.25;
        self.wiley_fox_settings.var_183442260d21f100 = 1;
    }
}

// Namespace field_upgrades_wiley_fox
// Params 0
// Checksum 0xd36ed0cb, Offset: 0x13d6
// Size: 0x36
function unset_wiley_fox()
{
    if ( isdefined( self.var_87e9b1896b9a4e5f ) )
    {
        self.super.staticdata.usetime = self.var_87e9b1896b9a4e5f;
    }
}

// Namespace field_upgrades_wiley_fox
// Params 0
// Checksum 0x622a17a5, Offset: 0x1414
// Size: 0xea, Type: bool
function begin_use_wiley_fox()
{
    if ( isdefined( level.field_upgrade_bundles[ "super_wiley_fox" ] ) )
    {
        wileyfoxweapon = level.field_upgrade_bundles[ "super_wiley_fox" ].offhandweapon;
        deploysuccess = field_upgrades::field_upgrade_play_gesture( wileyfoxweapon, "super_wiley_fox" );
        
        if ( deploysuccess )
        {
            currentweapon = self getcurrentweapon();
            
            if ( !currentweapon.isdualwield )
            {
                self setscriptablepartstate( "wand_fx", "wand_on_wiley_fox", 0 );
            }
            
            if ( !callback::exists( #"hash_9741c7ee14b21924", &interrupt_wiley_fox ) )
            {
                callback::add( #"hash_9741c7ee14b21924", &interrupt_wiley_fox );
            }
            
            n_radius = field_upgrades::function_5f728868b18ef0c0( "super_wiley_fox", "wileyFoxRadius" );
            utility::function_7c10ea82c1e305b8( "wiley_fox_fx", "super_fx_on" );
            thread wiley_fox_active( n_radius );
            return true;
        }
    }
    
    return false;
}

// Namespace field_upgrades_wiley_fox
// Params 2
// Checksum 0x854b220f, Offset: 0x1507
// Size: 0xd2, Type: bool
function function_9b8c221e82091f98( fromdeath, attacker )
{
    if ( isdefined( self.var_e5996377e9a13e32[ "wiley_fox_speed_boost" + self.name ] ) )
    {
        weapons::function_986fc44dada307f4( "wiley_fox_speed_boost" + self.name );
        weapons::updatemovespeedscale();
    }
    
    callback::remove( #"hash_9741c7ee14b21924", &interrupt_wiley_fox );
    level callback::remove( #"on_ai_killed", &on_ai_killed );
    callback::callback( "field_upgrade_ended", { #ref:"super_wiley_fox" } );
    utility::ent_flag_clear( "field_upgrade_in_use" );
    utility::ent_flag_clear( "wiley_fox_active" );
    utility::function_7c10ea82c1e305b8( "wiley_fox_fx", "super_fx_off" );
    self.wiley_fox_settings.active = undefined;
    return false;
}

// Namespace field_upgrades_wiley_fox
// Params 1
// Checksum 0x526fe8fe, Offset: 0x15e2
// Size: 0x2e7
function wiley_fox_active( n_radius )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    utility::ent_flag_init( "field_upgrade_in_use" );
    utility::ent_flag_set( "field_upgrade_in_use" );
    utility::ent_flag_init( "wiley_fox_active" );
    utility::ent_flag_set( "wiley_fox_active" );
    self.wiley_fox_settings.active = 1;
    n_speed_multiplier = field_upgrades::function_5f728868b18ef0c0( "super_wiley_fox", "wileyFoxSpeedMultiplier" );
    n_tick_time = field_upgrades::function_5f728868b18ef0c0( "super_wiley_fox", "wileyFoxTickRate" );
    var_dc58879cfee40e71 = self.super.staticdata.usetime;
    
    if ( !isdefined( var_dc58879cfee40e71 ) )
    {
        var_dc58879cfee40e71 = 15;
    }
    
    if ( self.wiley_fox_settings.backdraftactive )
    {
        backdraft_activate( n_radius );
    }
    
    if ( self.wiley_fox_settings.var_183442260d21f100 )
    {
        n_speed_multiplier = self.wiley_fox_settings.var_c5ff28c44013ef20;
    }
    
    if ( self.wiley_fox_settings.fireball_active )
    {
        thread fireball_activate();
    }
    
    thread apply_effects_source( var_dc58879cfee40e71 );
    weapons::function_4512b7715789e4cf( "wiley_fox_speed_boost" + self.name, 1 + n_speed_multiplier );
    weapons::updatemovespeedscale();
    
    if ( self.wiley_fox_settings.firestorm_active )
    {
        thread firestorm_activate( var_dc58879cfee40e71 );
    }
    
    if ( self.wiley_fox_settings.var_b9de534c4a81bff0 )
    {
        thread function_d7e680878fc01ca7();
    }
    
    level callback::add( #"on_ai_killed", &on_ai_killed );
    flashover_interval = 2;
    
    while ( var_dc58879cfee40e71 > 0 && self.wiley_fox_settings.active )
    {
        flashover_interval++;
        vel = self getvelocity();
        
        if ( self.wiley_fox_settings.flashover_active && flashover_interval % 3 == 0 )
        {
            self playsoundonmovingent( #"hash_d0421fb104afa16d" );
            playfx( utility::getfx( "vfx_sat_gameplay_zm_weapons_fld_wf_wild_fire_flashover_ground_ch01" ), self gettagorigin( "tag_origin" ) + vel / 4 );
            damage_enemies_in_range( self.wiley_fox_settings.flashover_radius, 1 );
            function_e0e077f2371c96e1( self.wiley_fox_settings.flashover_radius );
        }
        else
        {
            self playsoundonmovingent( #"hash_d0421fb104afa16d" );
            playfx( utility::getfx( "vfx_sat_gameplay_zm_weapons_fld_wf_wild_fire_circle_base_ground_ch01" ), self gettagorigin( "tag_origin" ) + vel / 4 );
            damage_enemies_in_range( n_radius );
            function_e0e077f2371c96e1( n_radius );
        }
        
        var_dc58879cfee40e71 -= n_tick_time;
        wait n_tick_time;
        waitframe();
    }
    
    self.flashover_kill_count = undefined;
    self.wiley_fox_settings.active = undefined;
}

// Namespace field_upgrades_wiley_fox
// Params 1
// Checksum 0xbffca88d, Offset: 0x18d1
// Size: 0x4f
function interrupt_wiley_fox( params )
{
    self.wiley_fox_settings.active = undefined;
    
    if ( isdefined( self.super.usepercent ) )
    {
        self.super.usepercent = 0;
    }
}

// Namespace field_upgrades_wiley_fox
// Params 1
// Checksum 0x39596a58, Offset: 0x1928
// Size: 0x157
function fireball_movement( fireball_central )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    while ( self.wiley_fox_settings.active )
    {
        forward_offset = self.wiley_fox_settings.fireball_forward_offset ?? 30;
        up_offset = self.wiley_fox_settings.fireball_up_offset ?? 10;
        horizontal_offset = self.wiley_fox_settings.fireball_horizontal_offset ?? 10;
        self_forward = vectornormalize( anglestoforward( self getplayerangles() ) ) * forward_offset;
        self_up = vectornormalize( anglestoup( self getplayerangles() ) ) * up_offset;
        
        if ( horizontal_offset < 0 )
        {
            self_horizontal = vectornormalize( anglestoleft( self getplayerangles() ) ) * abs( horizontal_offset );
        }
        else
        {
            self_horizontal = vectornormalize( anglestoright( self getplayerangles() ) ) * horizontal_offset;
        }
        
        target_pos = self geteye() + self_forward + self_up + self_horizontal;
        
        if ( isdefined( fireball_central ) )
        {
            fireball_central.origin = target_pos;
            fireball_central.angles = self getplayerangles();
        }
        else
        {
            break;
        }
        
        waitframe();
    }
}

// Namespace field_upgrades_wiley_fox
// Params 0
// Checksum 0x6db7172, Offset: 0x1a87
// Size: 0xf5
function fireball_activate()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    fireball_central = content_manager::spawn_script_model( self, "tag_origin_wiley_fox_fireball", 0, 1 );
    thread fireball_movement( fireball_central );
    fireball_central utility::function_7c10ea82c1e305b8( "particle", "particle" );
    fire_rate = self.wiley_fox_settings.fireball_fire_rate ?? 0.5;
    
    while ( self.wiley_fox_settings.active )
    {
        self.var_30c79d03889fb04d = 0;
        self.var_30c79d03889fb04d = self attackbuttonpressed();
        
        if ( self.var_30c79d03889fb04d )
        {
            thread fire_fireball( fireball_central );
            wait fire_rate;
        }
        
        waitframe();
    }
    
    fireball_central utility::function_7c10ea82c1e305b8( "particle", "off" );
    playfx( utility::getfx( "vfx_sat_gameplay_zm_weapons_fld_wf_wild_fire_ball_despawn" ), fireball_central.origin );
    fireball_central delete();
}

// Namespace field_upgrades_wiley_fox
// Params 1
// Checksum 0x39dc4d0c, Offset: 0x1b84
// Size: 0x146
function fire_fireball( fireball_central )
{
    speed_scale = self.wiley_fox_settings.var_8ba032eda7c0ca98 ?? 1;
    dist = self.wiley_fox_settings.fireball_range ?? 2000;
    vel = dist / speed_scale;
    adjust_pos = function_9e4c92b84cbd01d1( dist );
    targetdir = vectornormalize( adjust_pos - fireball_central.origin );
    startpos = fireball_central.origin;
    
    if ( distance( startpos, adjust_pos ) < 30 )
    {
        new_fireball = content_manager::spawn_script_model( self, "tag_origin_wiley_fox_fireball", 0, 1 );
        new_fireball.origin = adjust_pos;
        thread function_44e3dcbcd1d7fad3( new_fireball );
        return;
    }
    
    endpos = startpos + targetdir * dist;
    adjust_dist = distance( startpos, endpos );
    adjust_time = adjust_dist / vel;
    new_fireball = magicgrenademanual( "wiley_fox_fireball", fireball_central.origin, targetdir * vel, 10, self );
    new_fireball.dest = endpos;
    thread fireball_watcher( new_fireball, adjust_time );
}

// Namespace field_upgrades_wiley_fox
// Params 2
// Checksum 0x43ae8bec, Offset: 0x1cd2
// Size: 0x117
function fireball_watcher( fireball, duration )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    radius = self.wiley_fox_settings.fireball_radius ?? 5;
    start_time = gettime();
    current_time = 0;
    contents = physics_createcontents( [ "physicscontents_characterproxy", "physicscontents_trigger" ] );
    
    while ( current_time < duration )
    {
        current_time = utility::function_6f5d2e1f1ff70482( gettime() - start_time );
        
        if ( isdefined( fireball ) )
        {
            potential_enemies = undefined;
            potential_enemies = physics_querypoint( fireball.origin, radius, contents, undefined, "physicsquery_all" );
            var_21ede1a2688a75fc = fireball_damage( fireball, potential_enemies );
            
            if ( var_21ede1a2688a75fc )
            {
                break;
            }
        }
        
        waitframe();
    }
    
    function_e0e077f2371c96e1( radius );
    
    if ( fireball )
    {
        fireball utility::function_7c10ea82c1e305b8( "particle", "off" );
        fireball delete();
    }
}

// Namespace field_upgrades_wiley_fox
// Params 1
// Checksum 0xcc368fa2, Offset: 0x1df1
// Size: 0xc2
function function_44e3dcbcd1d7fad3( fireball )
{
    fireball playsound( "eqp_fug_wf_fireball_shoot" );
    radius = self.wiley_fox_settings.fireball_radius ?? 5;
    contents = physics_createcontents( [ "physicscontents_characterproxy", "physicscontents_trigger" ] );
    potential_enemies = undefined;
    potential_enemies = physics_querypoint( fireball.origin, radius, contents, undefined, "physicsquery_all" );
    fireball_damage( fireball, potential_enemies );
    playfx( utility::getfx( "vfx_sat_gameplay_zm_weapons_fld_wf_wild_fire_ball_explo" ), fireball.origin );
    fireball utility::function_7c10ea82c1e305b8( "particle", "off" );
    waitframe();
    fireball delete();
}

// Namespace field_upgrades_wiley_fox
// Params 2
// Checksum 0xe14d615e, Offset: 0x1ebb
// Size: 0x1b0
function fireball_damage( fireball, potential_enemies )
{
    if ( isdefined( potential_enemies ) && potential_enemies.size != 0 )
    {
        damage_per = self.wiley_fox_settings.fireball_damage_percent ?? 0.5;
        
        foreach ( potential_target in potential_enemies )
        {
            if ( isalive( potential_target[ "entity" ] ) && potential_target[ "entity" ].team != self.team )
            {
                zombie = potential_target[ "entity" ];
                
                if ( ( isagent( zombie ) || isplayer( zombie ) ) && isalive( zombie ) && zombie.team != self.team )
                {
                    round_difficulty = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
                    zombie_base_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
                    
                    if ( !isdefined( zombie_base_health ) )
                    {
                        zombie_base_health = 100;
                    }
                    
                    n_damage = int( zombie_base_health * damage_per );
                    sweapon = function_cd9c9a91097d6b7a();
                    zombie dodamage( n_damage, fireball.origin, self, self, "MOD_ELEMENTAL_FIRE", sweapon, undefined, undefined, 1610678272 );
                    zombie function_98437b644c347a29();
                    return 1;
                }
            }
        }
    }
}

// Namespace field_upgrades_wiley_fox
// Params 1
// Checksum 0x6f9b8e64, Offset: 0x2074
// Size: 0x94
function function_9e4c92b84cbd01d1( range )
{
    startpos = self geteye();
    endpos = startpos + anglestoforward( self getplayerangles() ) * range;
    contents = trace::create_contents( 1, 1, 1, 1, 1, 1 );
    ignorelist = [];
    hit = physics_raycast( startpos, endpos, contents, ignorelist, 0, "physicsquery_closest" );
    
    if ( isdefined( hit[ 0 ][ "position" ] ) )
    {
        return hit[ 0 ][ "position" ];
    }
    
    return endpos;
}

// Namespace field_upgrades_wiley_fox
// Params 0
// Checksum 0xcbf8868e, Offset: 0x2110
// Size: 0x2ef
function function_d7e680878fc01ca7()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self.wiley_fox_settings.active_pools = [];
    
    while ( self.wiley_fox_settings.active )
    {
        var_a67d207532dfb1ca = self.wiley_fox_settings.var_332c841f44578cc2;
        var_ded67bbe2bb04e5d = self.wiley_fox_settings.var_423820613d22be44;
        var_e8f739cd277d7116 = 1;
        
        if ( self.wiley_fox_settings.active_pools.size < self.wiley_fox_settings.var_88c04b3deb711ebd )
        {
            round_difficulty = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
            zombie_base_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
            
            if ( !isdefined( zombie_base_health ) )
            {
                zombie_base_health = 100;
            }
            
            damage = int( zombie_base_health * var_ded67bbe2bb04e5d );
            var_b7b609abde6844aa = self getcentroid();
            var_b7b609abde6844aa = utility::groundpos( var_b7b609abde6844aa );
            var_a2ed83ab36ec43c8 = spawn( "script_model", var_b7b609abde6844aa );
            var_a2ed83ab36ec43c8.owner = self;
            var_a2ed83ab36ec43c8.weapon_name = function_cd9c9a91097d6b7a().basename;
            var_a2ed83ab36ec43c8.prevent_knockdown = 1;
            var_a2ed83ab36ec43c8.var_d7594a5edcf54e30 = &function_d7594a5edcf54e30;
            burnbundle = spawnstruct();
            
            if ( burnbundle )
            {
                if ( !isdefined( level.var_4ed2b0d51126a35d ) )
                {
                    level.var_4ed2b0d51126a35d = makeweapon( self.wiley_fox_settings.var_38ed291b29c47875 );
                }
                
                if ( isdefined( level.var_4ed2b0d51126a35d ) )
                {
                    burnbundle.useweapon = level.var_4ed2b0d51126a35d;
                }
                
                burnbundle.var_35807474702938c6 = 1;
                burnbundle.var_c3f25b11c2247a29 = damage;
                burnbundle.var_78880e1476d45684 = damage;
                burnbundle.var_7ceb375188b38c13 = damage;
                burnbundle.var_b4261d601af6a28a = var_a67d207532dfb1ca;
                burnbundle.var_797382a688d68a64 = var_a67d207532dfb1ca;
                burnbundle.var_29dd3c8b7a515774 = var_e8f739cd277d7116;
                burnbundle.var_13727c7357581d8d = 0;
                burnbundle.var_61041a515545d346 = "_wfox";
                var_a2ed83ab36ec43c8.var_5b038f631de3ad97 = burnbundle;
                var_a2ed83ab36ec43c8.blueprintdefindex = 0;
                self.wiley_fox_settings.active_pools[ self.wiley_fox_settings.active_pools.size ] = var_a2ed83ab36ec43c8;
                thread molotov::molotov_simulate_impact( var_a2ed83ab36ec43c8, var_b7b609abde6844aa, ( 0, 0, 1 ), undefined, ( 0, 0, 100 ), gettime(), "wiley_fox_free_radical_pool" );
                thread function_aacdf0073bcc007a( var_a2ed83ab36ec43c8, var_a67d207532dfb1ca );
            }
        }
        
        wait self.wiley_fox_settings.var_4617b44113056db;
    }
}

// Namespace field_upgrades_wiley_fox
// Params 2
// Checksum 0x91939da0, Offset: 0x2407
// Size: 0x69
function function_aacdf0073bcc007a( var_a2ed83ab36ec43c8, var_a67d207532dfb1ca )
{
    wait var_a67d207532dfb1ca;
    
    if ( isdefined( var_a2ed83ab36ec43c8 ) )
    {
        if ( isdefined( self.wiley_fox_settings.active_pools ) )
        {
            self.wiley_fox_settings.active_pools = arrayremove( self.wiley_fox_settings.active_pools, var_a2ed83ab36ec43c8 );
        }
        
        var_a2ed83ab36ec43c8 delete();
    }
}

// Namespace field_upgrades_wiley_fox
// Params 0
// Checksum 0x8e5adcfa, Offset: 0x2478
// Size: 0x2
function function_d7594a5edcf54e30()
{
    
}

// Namespace field_upgrades_wiley_fox
// Params 1
// Checksum 0xcac717a7, Offset: 0x2482
// Size: 0x1bf
function firestorm_activate( var_dc58879cfee40e71 )
{
    firestorm_shell = content_manager::spawn_script_model( self, "tag_origin", 0, 1 );
    firestorm_shell.new_firestorm = content_manager::spawn_script_model( self, "tag_origin_firestorm", 0, 1 );
    angle = self getplayerangles();
    self_forward = vectornormalize( anglestoforward( ( 0, angle[ 1 ], angle[ 2 ] ) ) ) * self.wiley_fox_settings.firestorm_spawn_dist;
    start_pos = self gettagorigin( "j_head" ) + self_forward;
    total_dist = self.wiley_fox_settings.firestorm_move_dist;
    firestorm_shell.new_firestorm utility::function_7c10ea82c1e305b8( "particle", "particle" );
    start_pos = getclosestpointonnavmesh( start_pos );
    thread function_c255dac6ddfee73c( firestorm_shell, start_pos, vectornormalize( anglestoforward( self getplayerangles() ) ), total_dist, var_dc58879cfee40e71 );
    var_be3ddb862deb0056 = spawnstruct();
    var_be3ddb862deb0056.var_acefecea26e4c38d = firestorm_shell.new_firestorm.origin;
    var_be3ddb862deb0056.var_d2dd063ccc9340a7 = 24;
    var_be3ddb862deb0056.team = self.team;
    var_be3ddb862deb0056.var_1584d560f0aac804 = self.wiley_fox_settings.firestorm_pull_radius;
    var_be3ddb862deb0056.agents_pulled = [];
    var_be3ddb862deb0056.active = 1;
    var_be3ddb862deb0056.pull_kill_radius = self.wiley_fox_settings.var_c332123c5efa9fb4;
    firestorm_shell thread function_14040b20d128d23d( var_dc58879cfee40e71, var_be3ddb862deb0056 );
    thread firestorm_tornado( firestorm_shell, firestorm_shell.new_firestorm, var_be3ddb862deb0056 );
}

// Namespace field_upgrades_wiley_fox
// Params 5
// Checksum 0x4930ff9e, Offset: 0x2649
// Size: 0x67
function function_c255dac6ddfee73c( firestorm_shell, start_pos, rand_dir, total_dist, var_dc58879cfee40e71 )
{
    firestorm_shell moveto( start_pos, 1 );
    wait 1;
    firestorm_shell.can_damage = 1;
    firestorm_shell moveto( firestorm_shell.origin + rand_dir * total_dist, var_dc58879cfee40e71 - 1 );
}

// Namespace field_upgrades_wiley_fox
// Params 3
// Checksum 0x465aa899, Offset: 0x26b8
// Size: 0x3fe
function firestorm_tornado( firestorm_shell, new_firestorm, var_be3ddb862deb0056 )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    pull_distance_squared = var_be3ddb862deb0056.var_1584d560f0aac804 * var_be3ddb862deb0056.var_1584d560f0aac804;
    sweapon = "none";
    
    if ( isdefined( level.weaponmetadata[ %"wiley_fox" ] ) )
    {
        if ( !isdefined( level.weaponmetadata[ %"wiley_fox" ].weaponobj ) )
        {
            sweapon = makeweapon( level.weaponmetadata[ %"wiley_fox" ].weapon );
            level.weaponmetadata[ %"wiley_fox" ].weaponobj = sweapon;
        }
        else
        {
            sweapon = level.weaponmetadata[ %"wiley_fox" ].weaponobj;
        }
    }
    
    var_be3ddb862deb0056.var_ee589ae431c7ecdf = 1;
    round_difficulty = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
    zombie_base_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
    
    if ( !isdefined( zombie_base_health ) )
    {
        zombie_base_health = 100;
    }
    
    firestorm_shell thread function_5062749decad4e85( new_firestorm, var_be3ddb862deb0056 );
    
    while ( var_be3ddb862deb0056.active )
    {
        if ( !firestorm_shell.can_damage )
        {
            waitframe();
            continue;
        }
        
        var_be3ddb862deb0056.vortex_center = new_firestorm get_vortex_center( var_be3ddb862deb0056.var_d2dd063ccc9340a7 );
        var_3ae58588ddfc1990 = 0;
        affected_agents = getaiarrayinradius( var_be3ddb862deb0056.vortex_center, var_be3ddb862deb0056.var_1584d560f0aac804 );
        
        /#
        #/
        
        function_e0e077f2371c96e1( self.wiley_fox_settings.firestorm_damage_radius );
        
        foreach ( agent in affected_agents )
        {
            if ( !isalive( agent ) || agent.unittype != "zombie" )
            {
                continue;
            }
            
            if ( agent.team == self.team )
            {
                continue;
            }
            
            var_b96b03906adea51d = distancesquared( agent.origin, var_be3ddb862deb0056.vortex_center ) <= pull_distance_squared;
            
            if ( agent.unittype == "zombie" && agent.aicategory == "normal" )
            {
                if ( var_be3ddb862deb0056.var_ee589ae431c7ecdf )
                {
                    var_be3ddb862deb0056.var_ee589ae431c7ecdf = undefined;
                    var_be3ddb862deb0056 thread function_3be377f9adc4f40c( agent, var_b96b03906adea51d, self, sweapon );
                }
            }
            
            var_3ae58588ddfc1990++;
            
            if ( var_3ae58588ddfc1990 % 10 == 0 )
            {
                waitframe();
            }
            
            char_distance = distancesquared( var_be3ddb862deb0056.vortex_center, agent getcentroid() );
            
            if ( !self.wiley_fox_settings.active )
            {
                break;
            }
            
            max_dist = self.wiley_fox_settings.firestorm_damage_radius * self.wiley_fox_settings.firestorm_damage_radius;
            
            if ( char_distance <= max_dist && !agent.firestorm_death )
            {
                agent dodamage( zombie_base_health * self.wiley_fox_settings.firestorm_damage, var_be3ddb862deb0056.vortex_center, self, self, "MOD_ELEMENTAL_FIRE", sweapon, undefined, undefined, 1073807360 );
            }
        }
        
        if ( var_3ae58588ddfc1990 == 0 || var_3ae58588ddfc1990 % 10 > 0 )
        {
            waitframe();
        }
        
        wait self.wiley_fox_settings.var_14ebcef9c3a6ee7f;
        var_be3ddb862deb0056.var_ee589ae431c7ecdf = 1;
    }
}

// Namespace field_upgrades_wiley_fox
// Params 2, eflags: 0x4
// Checksum 0xaec55f54, Offset: 0x2abe
// Size: 0x40
function private function_5062749decad4e85( new_firestorm, var_be3ddb862deb0056 )
{
    while ( var_be3ddb862deb0056.active )
    {
        new_firestorm.origin = getclosestpointonnavmesh( self.origin );
        waitframe();
    }
}

// Namespace field_upgrades_wiley_fox
// Params 4, eflags: 0x4
// Checksum 0x8e000b62, Offset: 0x2b06
// Size: 0x69
function private function_3be377f9adc4f40c( zombie, is_pulled, player, sweapon )
{
    if ( !zombie.var_19238dbcc969affa || !zombie.var_5927d2279779cec0 || !zombie val::get( "allow_secondary_attack_damage" ) )
    {
        is_pulled = 0;
    }
    
    zombie thread function_8a0e4d915f64425c( self, is_pulled, player, sweapon );
}

// Namespace field_upgrades_wiley_fox
// Params 4
// Checksum 0x876b2dc0, Offset: 0x2b77
// Size: 0x22a
function function_8a0e4d915f64425c( var_be3ddb862deb0056, is_pulled, player, sweapon )
{
    assert( isagent( self ) );
    char_distance = distancesquared( var_be3ddb862deb0056.vortex_center, self getcentroid() );
    max_dist = var_be3ddb862deb0056.pull_kill_radius * var_be3ddb862deb0056.pull_kill_radius;
    var_ffe58be46bfdb0d4 = char_distance <= max_dist;
    
    /#
    #/
    
    if ( var_ffe58be46bfdb0d4 )
    {
        self.firestorm_death = 1;
        self.forceannihilate = 1;
        
        if ( isai( self ) && isdefined( self.subclass ) && self.subclass == "zombie_base" )
        {
            if ( utility::function_4c656524ecb504d6( "firestorm_tornado_spin" ) )
            {
                namespace_9d8e359c3b1041e5::animscripted_sharedfunc( "firestorm_tornado_spin", "firestorm_tornado_spin" );
            }
        }
        
        self dodamage( self.maxhealth, var_be3ddb862deb0056.vortex_center, player, player, "MOD_ELEMENTAL_FIRE", sweapon, undefined, undefined, 1073807360 );
        
        if ( !isalive( self ) )
        {
            return;
        }
    }
    
    if ( is_pulled )
    {
        pull_origin = var_be3ddb862deb0056.vortex_center;
        vortex_height = max( var_be3ddb862deb0056.vortex_center[ 2 ] - var_be3ddb862deb0056.var_acefecea26e4c38d[ 2 ], 0 );
        vortex_payload = { #mode:"blackhole", #height:vortex_height, #grenade:var_be3ddb862deb0056.grenade };
        is_new = vortex::set_vortex_state( "blackhole", var_be3ddb862deb0056, pull_origin, var_be3ddb862deb0056.pull_kill_radius, vortex_payload );
        
        if ( is_new )
        {
            var_be3ddb862deb0056.agents_pulled[ var_be3ddb862deb0056.agents_pulled.size ] = self;
            self.vortex_pull_owner = var_be3ddb862deb0056.owner;
        }
        
        return;
    }
    
    is_removed = function_c421bc7468f607df( var_be3ddb862deb0056 );
    
    if ( is_removed )
    {
        var_be3ddb862deb0056.agents_pulled = arrayremove( var_be3ddb862deb0056.agents_pulled, self );
    }
}

// Namespace field_upgrades_wiley_fox
// Params 1
// Checksum 0x67572e3d, Offset: 0x2da9
// Size: 0xa1
function function_1bc269f5f9a9ec39( vortex )
{
    v_dir = vectornormalize( vortex.vortex_center - self.origin );
    v_launch = v_dir * randomintrange( 2200, 2400 ) + ( 0, 0, randomintrange( 900, 1100 ) );
    var_471b16bf43cda71a = !zombie_traverse::is_traversing();
    var_24ed309d808c077a = self getcorpseentity();
    
    if ( var_471b16bf43cda71a && isdefined( var_24ed309d808c077a ) && !var_24ed309d808c077a isragdoll() )
    {
        var_24ed309d808c077a startragdollfromimpact( "torso_lower", v_launch * 1.2 );
    }
}

// Namespace field_upgrades_wiley_fox
// Params 1, eflags: 0x4
// Checksum 0xc4197176, Offset: 0x2e52
// Size: 0x27
function private function_c421bc7468f607df( var_be3ddb862deb0056 )
{
    is_removed = vortex::clear_vortex_state( "blackhole", var_be3ddb862deb0056 );
    return is_removed;
}

// Namespace field_upgrades_wiley_fox
// Params 1, eflags: 0x4
// Checksum 0xcfc9671d, Offset: 0x2e82
// Size: 0x26
function private get_vortex_center( var_d2dd063ccc9340a7 )
{
    return self.origin + var_d2dd063ccc9340a7 * anglestoup( self.angles );
}

// Namespace field_upgrades_wiley_fox
// Params 2
// Checksum 0xf9dc46df, Offset: 0x2eb1
// Size: 0xf9
function function_14040b20d128d23d( var_dc58879cfee40e71, var_be3ddb862deb0056 )
{
    wait var_dc58879cfee40e71;
    self.new_firestorm utility::function_7c10ea82c1e305b8( "particle", "off" );
    var_be3ddb862deb0056.active = undefined;
    
    foreach ( agent in var_be3ddb862deb0056.agents_pulled )
    {
        if ( isalive( agent ) )
        {
            agent function_c421bc7468f607df( var_be3ddb862deb0056 );
        }
    }
    
    playfx( utility::getfx( "vfx_sat_gameplay_zm_weapons_fld_wf_wild_fire_tornado_disperse" ), self.new_firestorm.origin );
    self.new_firestorm delete();
    self delete();
}

// Namespace field_upgrades_wiley_fox
// Params 1
// Checksum 0x2c857c69, Offset: 0x2fb2
// Size: 0x170
function backdraft_activate( radius )
{
    var_6f5c0bece5deb66e = getaiarrayinradius( self.origin, radius );
    str_enemy_team = self.team == "allies" ? "axis" : "allies";
    playfxontag( utility::getfx( "vfx_sat_gameplay_zm_weapons_fld_wf_wild_fire_zmb_imp" ), self, "j_spine4" );
    
    foreach ( ai in var_6f5c0bece5deb66e )
    {
        if ( isai( ai ) && isalive( ai ) )
        {
            if ( ai.team == self.team )
            {
                continue;
            }
            
            if ( ai.aicategory == "special" || ai.aicategory == "elite" && self.wiley_fox_settings.backdraftduration > 0 )
            {
                ai zombie_stun::stun_ai( self.wiley_fox_settings.backdraftduration );
                continue;
            }
            
            ai zombie_knockdown::function_6fc167d4a3590991( ai.origin );
        }
    }
}

// Namespace field_upgrades_wiley_fox
// Params 2
// Checksum 0x47d003de, Offset: 0x312a
// Size: 0x592
function damage_enemies_in_range( n_radius, flashover_boost )
{
    var_6f5c0bece5deb66e = getaiarrayinradius( self.origin, n_radius );
    a_enemies_sort = sortbydistance( var_6f5c0bece5deb66e, self.origin );
    str_enemy_team = self.team == "allies" ? "axis" : "allies";
    
    if ( !isdefined( level.superglobals.staticsuperdata[ "super_wiley_fox" ].var_882cdadff5226264 ) )
    {
        level.superglobals.staticsuperdata[ "super_wiley_fox" ].var_882cdadff5226264 = field_upgrades::function_5f728868b18ef0c0( "super_wiley_fox", "wileyFoxDamagePct" ) ?? 0;
    }
    
    if ( !isdefined( level.superglobals.staticsuperdata[ "super_wiley_fox" ].var_b53442ffcb1f64 ) )
    {
        level.superglobals.staticsuperdata[ "super_wiley_fox" ].var_b53442ffcb1f64 = field_upgrades::function_5f728868b18ef0c0( "super_wiley_fox", "wileyFoxBurnDamagePct" ) ?? 0;
    }
    
    if ( !isdefined( level.superglobals.staticsuperdata[ "super_wiley_fox" ].var_dec171824ae8d571 ) )
    {
        level.superglobals.staticsuperdata[ "super_wiley_fox" ].var_dec171824ae8d571 = field_upgrades::function_5f728868b18ef0c0( "super_wiley_fox", "wileyFoxBurnDuration" ) ?? 0;
    }
    
    if ( !isdefined( level.superglobals.staticsuperdata[ "super_wiley_fox" ].var_53f1d6dd88b74227 ) )
    {
        level.superglobals.staticsuperdata[ "super_wiley_fox" ].var_53f1d6dd88b74227 = field_upgrades::function_5f728868b18ef0c0( "super_wiley_fox", "wileyFoxBurnTickRate" ) ?? 0.5;
    }
    
    if ( !isdefined( level.superglobals.staticsuperdata[ "super_wiley_fox" ].enable_player_damage ) )
    {
        level.superglobals.staticsuperdata[ "super_wiley_fox" ].enable_player_damage = function_534812d4381a69a0();
    }
    
    if ( level.superglobals.staticsuperdata[ "super_wiley_fox" ].enable_player_damage )
    {
        enemyplayers = getplayersinradius( self.origin, n_radius, undefined, 0, undefined, str_enemy_team );
    }
    
    zombie_start_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", 1 );
    var_882cdadff5226264 = zombie_start_health * level.superglobals.staticsuperdata[ "super_wiley_fox" ].var_882cdadff5226264;
    
    if ( flashover_boost )
    {
        var_882cdadff5226264 = zombie_start_health * self.wiley_fox_settings.flashover_damage;
    }
    
    if ( self.wiley_fox_settings.var_49668c5a2d9216d0 && !flashover_boost )
    {
        var_c1465f4199b48a4f = zombie_start_health * self.wiley_fox_settings.var_b201a05210ce396f;
        var_311325d9a482e35 = zombie_start_health * self.wiley_fox_settings.var_a22df49682088cc9;
        
        foreach ( ai in a_enemies_sort )
        {
            if ( isai( ai ) && isalive( ai ) )
            {
                distsq = distancesquared( self.origin, ai.origin );
                
                if ( distsq <= self.wiley_fox_settings.var_7e3a77604eaa1c50 * self.wiley_fox_settings.var_7e3a77604eaa1c50 )
                {
                    ai thread wiley_fox_ai_damage( self, var_c1465f4199b48a4f );
                }
                else if ( distsq <= self.wiley_fox_settings.var_fdbd6f4aab55499e * self.wiley_fox_settings.var_fdbd6f4aab55499e )
                {
                    ai thread wiley_fox_ai_damage( self, var_311325d9a482e35 );
                }
                else
                {
                    ai thread wiley_fox_ai_damage( self, var_882cdadff5226264 );
                }
                
                var_254fa0af17b38aaf = randomfloat( 0.05 );
                wait var_254fa0af17b38aaf;
            }
        }
        
        return;
    }
    
    foreach ( ai in a_enemies_sort )
    {
        if ( isai( ai ) && isalive( ai ) )
        {
            ai thread wiley_fox_ai_damage( self, var_882cdadff5226264 );
        }
        
        var_254fa0af17b38aaf = randomfloat( 0.05 );
        wait var_254fa0af17b38aaf;
    }
    
    foreach ( player in enemyplayers )
    {
        if ( isalive( player ) )
        {
            player thread wiley_fox_player_damage( self, var_882cdadff5226264 );
        }
        
        var_254fa0af17b38aaf = randomfloat( 0.05 );
        wait var_254fa0af17b38aaf;
    }
}

// Namespace field_upgrades_wiley_fox
// Params 2
// Checksum 0x2dd62e92, Offset: 0x36c4
// Size: 0xc2
function wiley_fox_player_damage( var_bf9f263a78d8b28d, var_882cdadff5226264 )
{
    if ( !isdefined( level.superglobals.staticsuperdata[ "super_wiley_fox" ].var_cdab8d2d54b6d9b9 ) )
    {
        level.superglobals.staticsuperdata[ "super_wiley_fox" ].var_cdab8d2d54b6d9b9 = function_21d7bc4bd237d046().statuseffectduration ?? 3;
    }
    
    var_bf9f263a78d8b28d.var_5b038f631de3ad97 = function_b49b15d4ae1a3bf6();
    thread molotov::molotov_burn_for_time( level.superglobals.staticsuperdata[ "super_wiley_fox" ].var_cdab8d2d54b6d9b9, var_bf9f263a78d8b28d, var_bf9f263a78d8b28d, var_bf9f263a78d8b28d );
    var_bf9f263a78d8b28d.var_5b038f631de3ad97 = undefined;
}

// Namespace field_upgrades_wiley_fox
// Params 0, eflags: 0x4
// Checksum 0x64d33251, Offset: 0x378e
// Size: 0xc6
function private function_21d7bc4bd237d046()
{
    if ( !isdefined( level.superglobals.staticsuperdata[ "super_wiley_fox" ].var_da2631ec0430392e ) )
    {
        var_ca2a910061d22088 = function_7252f02e44c8d966();
        weaponmetadata = level.weaponmetadata[ var_ca2a910061d22088.var_1616e6fbba9a722d ];
        assert( isdefined( weaponmetadata ), "<dev string:xb5>" + var_ca2a910061d22088.basename + "<dev string:xf1>" );
        level.superglobals.staticsuperdata[ "super_wiley_fox" ].var_da2631ec0430392e = weaponmetadata;
    }
    
    return level.superglobals.staticsuperdata[ "super_wiley_fox" ].var_da2631ec0430392e;
}

// Namespace field_upgrades_wiley_fox
// Params 0, eflags: 0x4
// Checksum 0xb8f9745, Offset: 0x385d
// Size: 0x2a, Type: bool
function private function_534812d4381a69a0()
{
    if ( !isdefined( field_upgrades::function_5f728868b18ef0c0( "super_wiley_fox", "wileyFoxPlayerBurnWeapon" ) ) )
    {
        return false;
    }
    
    return istrue( function_21d7bc4bd237d046().var_b77a740e69bf0cc8 );
}

// Namespace field_upgrades_wiley_fox
// Params 0, eflags: 0x4
// Checksum 0xb2345a85, Offset: 0x3890
// Size: 0x170
function private function_b49b15d4ae1a3bf6()
{
    if ( !isdefined( level.superglobals.staticsuperdata[ "super_wiley_fox" ].var_9ab95a10d322d20e ) )
    {
        weaponmetadata = function_21d7bc4bd237d046();
        burn_damage = weaponmetadata.var_f4088615e20740d ?? 15;
        burn_tick_rate = weaponmetadata.statuseffecttick ?? 0.15;
        bundle = structcopy( molotov::molotov_get_bundle(), 0 );
        bundle.useweapon = function_7252f02e44c8d966().basename;
        bundle.var_35807474702938c6 = 0;
        bundle.means_of_death = "MOD_FIRE";
        bundle.var_c3f25b11c2247a29 = burn_damage;
        bundle.var_78880e1476d45684 = burn_damage;
        bundle.var_7ceb375188b38c13 = burn_damage;
        bundle.var_29dd3c8b7a515774 = burn_tick_rate;
        bundle.var_13727c7357581d8d = 1;
        bundle.var_61041a515545d346 = weaponmetadata.var_484d08002b62439 ?? "_wfox";
        level.superglobals.staticsuperdata[ "super_wiley_fox" ].var_9ab95a10d322d20e = bundle;
    }
    
    return level.superglobals.staticsuperdata[ "super_wiley_fox" ].var_9ab95a10d322d20e;
}

// Namespace field_upgrades_wiley_fox
// Params 2
// Checksum 0x8d2bf849, Offset: 0x3a09
// Size: 0x22f
function wiley_fox_ai_damage( var_bf9f263a78d8b28d, var_882cdadff5226264 )
{
    self endon( #"death" );
    
    if ( isdefined( var_882cdadff5226264 ) && isalive( var_bf9f263a78d8b28d ) )
    {
        sweapon = function_cd9c9a91097d6b7a();
        
        if ( utility::hastag( self.model, "j_spine4" ) )
        {
            playfxontag( utility::getfx( "vfx_sat_gameplay_zm_weapons_fld_wf_wild_fire_zmb_imp" ), self, "j_spine4" );
        }
        
        round_difficulty = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
        zombie_base_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
        
        if ( !isdefined( zombie_base_health ) )
        {
            zombie_base_health = 100;
        }
        
        var_e14399678731088d = level.superglobals.staticsuperdata[ "super_wiley_fox" ].var_b53442ffcb1f64;
        burn_damage = int( isdefined( zombie_base_health ) ? zombie_base_health * var_e14399678731088d : 5 );
        var_19e897f718fe3692 = level.superglobals.staticsuperdata[ "super_wiley_fox" ].var_dec171824ae8d571;
        burn_tick_rate = level.superglobals.staticsuperdata[ "super_wiley_fox" ].var_53f1d6dd88b74227;
        var_882cdadff5226264 = int( zombie_base_health * var_882cdadff5226264 / 100 );
        self dodamage( var_882cdadff5226264, self.origin, var_bf9f263a78d8b28d, var_bf9f263a78d8b28d, "MOD_ELEMENTAL_FIRE", sweapon, "torso_upper", undefined, 1073807360 );
        wait 0.5;
        thread effect_burn::burn( var_19e897f718fe3692, burn_damage, burn_tick_rate, var_bf9f263a78d8b28d, "wiley_fox", "_wfox", var_bf9f263a78d8b28d, "MOD_ELEMENTAL_FIRE", undefined, sweapon, 1, 1 );
        function_98437b644c347a29();
        slow_duration = field_upgrades::function_5f728868b18ef0c0( "super_wiley_fox", "wileyFoxSlowDuration" ) ?? 0.25;
        
        if ( self.aicategory == "normal" || self.aicategory == "special" )
        {
            thread wiley_fox_slow_ai( var_bf9f263a78d8b28d, slow_duration );
        }
        
        params = { #sweapon:sweapon, #eattacker:var_bf9f263a78d8b28d, #damage:var_882cdadff5226264 };
    }
}

// Namespace field_upgrades_wiley_fox
// Params 0
// Checksum 0x8e64b342, Offset: 0x3c40
// Size: 0xb3
function function_cd9c9a91097d6b7a()
{
    sweapon = "none";
    
    if ( isdefined( level.weaponmetadata[ %"wiley_fox" ] ) )
    {
        if ( !isdefined( level.weaponmetadata[ %"wiley_fox" ].weaponobj ) )
        {
            sweapon = makeweapon( level.weaponmetadata[ %"wiley_fox" ].weapon );
            level.weaponmetadata[ %"wiley_fox" ].weaponobj = sweapon;
        }
        else
        {
            sweapon = level.weaponmetadata[ %"wiley_fox" ].weaponobj;
        }
    }
    
    return sweapon;
}

// Namespace field_upgrades_wiley_fox
// Params 0, eflags: 0x4
// Checksum 0xc9b3a5da, Offset: 0x3cfc
// Size: 0x223
function private function_7252f02e44c8d966()
{
    if ( !isdefined( level.superglobals.staticsuperdata[ "super_wiley_fox" ].var_114684e021c8f65e ) )
    {
        level.superglobals.staticsuperdata[ "super_wiley_fox" ].var_114684e021c8f65e = field_upgrades::function_5f728868b18ef0c0( "super_wiley_fox", "wileyFoxPlayerBurnWeapon" );
    }
    
    weaponasset = level.superglobals.staticsuperdata[ "super_wiley_fox" ].var_114684e021c8f65e;
    assert( isdefined( weaponasset ), "<dev string:x145>" );
    
    if ( !isdefined( level.superglobals.staticsuperdata[ "super_wiley_fox" ].var_3ca2c9547718f978 ) )
    {
        weaponobj = makeweapon( weaponasset );
        level.var_1de668bdb367b433[ weaponobj.basenamehash ] = "equip_molotov";
        supers_mp::registersuperextraweapon( "super_wiley_fox", weaponobj.basename );
        
        if ( !isdefined( level.equipment.table[ "equip_molotov" ].damageweaponnames ) )
        {
            level.equipment.table[ "equip_molotov" ].damageweaponnames = [];
        }
        
        if ( !arraycontains( level.equipment.table[ "equip_molotov" ].damageweaponnames, weaponobj.basename ) )
        {
            level.equipment.table[ "equip_molotov" ].damageweaponnames[ level.equipment.table[ "equip_molotov" ].damageweaponnames.size ] = weaponobj.basename;
        }
        
        level.superglobals.staticsuperdata[ "super_wiley_fox" ].var_3ca2c9547718f978 = weaponobj;
    }
    
    return level.superglobals.staticsuperdata[ "super_wiley_fox" ].var_3ca2c9547718f978;
}

// Namespace field_upgrades_wiley_fox
// Params 2
// Checksum 0x3d9d6f5f, Offset: 0x3f28
// Size: 0x8e
function wiley_fox_slow_ai( attacker, duration )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( duration <= 0.1 )
    {
        return;
    }
    
    slow_pct = field_upgrades::function_5f728868b18ef0c0( "super_wiley_fox", "wileyFoxSlowPercent" ) ?? 0.1;
    
    if ( self.aisettings.var_3dae55586fee0a61 )
    {
        effect_slow::slow( "wiley_fox", slow_pct, duration, attacker, &function_3d9014a4ca5e10d2, undefined, "fire" );
    }
}

// Namespace field_upgrades_wiley_fox
// Params 2, eflags: 0x40 variadic
// Checksum 0x910965d3, Offset: 0x3fbe
// Size: 0x1c
function function_3d9014a4ca5e10d2( ... )
{
    if ( !isdefined( self ) )
    {
        return;
    }
}

// Namespace field_upgrades_wiley_fox
// Params 1
// Checksum 0xd5ee6cdb, Offset: 0x3fe2
// Size: 0x21
function apply_effects_source( var_dc58879cfee40e71 )
{
    self endon( #"death_or_disconnect" );
    thread wiley_fox_fov_change( var_dc58879cfee40e71 );
}

// Namespace field_upgrades_wiley_fox
// Params 1
// Checksum 0xdc024304, Offset: 0x400b
// Size: 0x5c
function wiley_fox_fov_change( var_dc58879cfee40e71 )
{
    if ( !isdefined( var_dc58879cfee40e71 ) )
    {
        return;
    }
    
    self endon( #"death_or_disconnect" );
    self notify( #"hash_6905fb37f08f5a8e" );
    self endon( #"hash_6905fb37f08f5a8e" );
    self lerpfovbypreset( "zombiedefault" );
    utility::waittill_any_timeout_no_endon_death( var_dc58879cfee40e71, "super_use_finished" );
    self lerpfovbypreset( "default_2seconds" );
}

// Namespace field_upgrades_wiley_fox
// Params 0
// Checksum 0x71c11f2b, Offset: 0x406f
// Size: 0xe
function remove_effects_source()
{
    self endon( #"disconnect" );
}

// Namespace field_upgrades_wiley_fox
// Params 1
// Checksum 0xf7b1b311, Offset: 0x4085
// Size: 0x6f
function on_ai_killed( sparams )
{
    if ( isplayer( sparams.eattacker ) )
    {
        player = sparams.eattacker;
        
        if ( player.wiley_fox_settings.active )
        {
            var_24ed309d808c077a = self getcorpseentity();
            
            if ( var_24ed309d808c077a )
            {
                var_24ed309d808c077a utility::ent_flag_set( "burned" );
            }
        }
    }
}

// Namespace field_upgrades_wiley_fox
// Params 1, eflags: 0x4
// Checksum 0x2a6c20f8, Offset: 0x40fc
// Size: 0x27, Type: bool
function private function_2d6835dc0475693a( augmentname )
{
    return istrue( utility::callsharedfunc( #"zombie", #"player_has_augment", augmentname ) );
}

// Namespace field_upgrades_wiley_fox
// Params 0
// Checksum 0x19e6e00e, Offset: 0x412c
// Size: 0x4e
function function_98437b644c347a29()
{
    if ( utility::ent_flag( "burned" ) )
    {
        return;
    }
    
    utility::ent_flag_set( "burned" );
    utility::function_32b24db3127bff40( "burned", "burned_on" );
    wait 2;
    utility::ent_flag_clear( "burned" );
    utility::function_32b24db3127bff40( "burned", "burned_off" );
}

// Namespace field_upgrades_wiley_fox
// Params 4, eflags: 0x4
// Checksum 0xeb2487cc, Offset: 0x4182
// Size: 0x149
function private on_killed_medal( victim, einflictor, smeansofdeath, sweapon )
{
    if ( utility::issharedfuncdefined( #"medal", #"track_rapid_kill", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"track_rapid_kill", "wiley_fox", sweapon );
    }
    
    victim.is_lethal_or_super_kill = 1;
    params = { #highest_multi_kills:1, #stats:"kills", #ref:"super_wiley_fox", #field_upgrade:"wiley_fox", #victim:victim, #player:self };
    callback::callback( "on_field_upgrade_kill_track", params );
    
    if ( isdefined( self.rapidkill_data ) )
    {
        if ( isdefined( self.rapidkill_data[ "wiley_fox" ] ) && self.rapidkill_data[ "wiley_fox" ].rapidkill_count == 10 )
        {
            namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_heatwave" );
            utility::callsharedfunc( #"sound", #"play_scoreevent_vo", self, #"bc_super_wiley_fox_success" );
        }
    }
}

// Namespace field_upgrades_wiley_fox
// Params 4, eflags: 0x4
// Checksum 0xb630bb46, Offset: 0x42d3
// Size: 0xe4
function private function_46b4c3e05957a762( victim, einflictor, smeansofdeath, sweapon )
{
    if ( utility::issharedfuncdefined( #"medal", #"track_rapid_kill", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"track_rapid_kill", "wiley_fox", sweapon );
    }
    
    victim.is_lethal_or_super_kill = 1;
    
    if ( isdefined( self.rapidkill_data ) )
    {
        if ( isdefined( self.rapidkill_data[ "wiley_fox" ] ) && self.rapidkill_data[ "wiley_fox" ].rapidkill_count == 10 )
        {
            namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_heatwave" );
            utility::callsharedfunc( #"sound", #"play_scoreevent_vo", self, #"bc_super_wiley_fox_success" );
        }
    }
}

// Namespace field_upgrades_wiley_fox
// Params 1
// Checksum 0x6c4cd663, Offset: 0x43bf
// Size: 0x175
function function_e0e077f2371c96e1( n_radius )
{
    var_c127d6dcc18f3fe5 = damage_utility::function_cf1c753aefa70ea1( self.team );
    
    if ( level.wiley_fox.var_28079045bda30435.size == 0 && var_c127d6dcc18f3fe5.size == 0 || !isalive( self ) )
    {
        return;
    }
    
    var_c127d6dcc18f3fe5 = arraycombine( var_c127d6dcc18f3fe5, level.wiley_fox.var_28079045bda30435 );
    var_c127d6dcc18f3fe5 = function_6a293b884c444a20( var_c127d6dcc18f3fe5, self.origin, n_radius );
    
    if ( var_c127d6dcc18f3fe5.size == 0 )
    {
        return;
    }
    
    foreach ( target in var_c127d6dcc18f3fe5 )
    {
        if ( isent( target ) )
        {
            target dodamage( 1, self.origin, self, self, "MOD_ELEMENTAL_FIRE", level.wiley_fox.objweapon, "none", undefined, 1 );
            continue;
        }
        
        if ( !isent( target ) && target isscriptableinstance() )
        {
            target scriptabledodamage( 1, self, self, target.origin, undefined, "MOD_ELEMENTAL_FIRE", level.wiley_fox.objweapon );
        }
    }
}

// Namespace field_upgrades_wiley_fox
// Params 1
// Checksum 0x94fa239e, Offset: 0x453c
// Size: 0xc9
function add_manual_target( object )
{
    if ( !isdefined( object ) || !( isent( object ) || object isscriptableinstance() ) )
    {
        assertmsg( "<dev string:x1b6>" );
        return;
    }
    
    if ( level.wiley_fox.var_28079045bda30435 && arraycontains( level.wiley_fox.var_28079045bda30435, object ) )
    {
        return;
    }
    
    object thread manual_target_watcher();
    
    if ( !isdefined( level.wiley_fox.var_28079045bda30435 ) )
    {
        level.wiley_fox.var_28079045bda30435 = [];
    }
    
    level.wiley_fox.var_28079045bda30435[ level.wiley_fox.var_28079045bda30435.size ] = object;
}

// Namespace field_upgrades_wiley_fox
// Params 1
// Checksum 0xc6d78e1e, Offset: 0x460d
// Size: 0x9d
function remove_manual_target( object )
{
    if ( !isdefined( object ) || !( isent( object ) || object isscriptableinstance() ) )
    {
        assertmsg( "<dev string:x1f8>" );
        return;
    }
    
    if ( !isdefined( level.wiley_fox ) || !arraycontains( level.wiley_fox.var_28079045bda30435, object ) )
    {
        return;
    }
    
    level.wiley_fox.var_28079045bda30435 = arrayremove( level.wiley_fox.var_28079045bda30435, object );
    object notify( #"hash_aced81f6177e422e" );
}

// Namespace field_upgrades_wiley_fox
// Params 0, eflags: 0x4
// Checksum 0x56b715c1, Offset: 0x46b2
// Size: 0x5f
function private manual_target_watcher()
{
    level endon( #"zm_game_over" );
    self endon( #"hash_aced81f6177e422e" );
    self waittill( #"death" );
    level.wiley_fox.var_28079045bda30435 = arrayremove( level.wiley_fox.var_28079045bda30435, self );
    self notify( #"hash_aced81f6177e422e" );
}

