// scripts\mp\zm\systems\zm_store_chompy.gsc  (hash_27ada916a0c173d1.gscc) (size: 9889 Bytes / 0x26a1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x50271e63 (1344740963)
// size ...... 9889 (0x26a1)
// includes .. 13  (offset: 0x234d)
// strings ... 48  (offset: 0x23b5)
// dev strs .. 4   (offset: 0x266d)
// exports ... 25  (offset: 0x17a9)
// cseg ...... 0x37a + 0x142f (0x17a9)
// imports ... 65  (offset: 0x1b91)
// animtree1 . 0   (offset: 0x26a1)
// animtree2 . 0   (offset: 0x26a1)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\powerups;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\currency;
#using scripts\mp\interaction;
#using scripts\mp\laststand;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\pack_a_punch;
#using scripts\mp\zm\systems\zone_manager;

#namespace zm_store_chompy;

// Namespace zm_store_chompy
// Params 0, eflags: 0x5
// Checksum 0x956b033d, Offset: 0x398
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_store_chompy", undefined, undefined, &post_init );
}

// Namespace zm_store_chompy
// Params 0
// Checksum 0x4dd67388, Offset: 0x3b9
// Size: 0x86
function post_init()
{
    if ( !getdvarint( @"hash_1a200a5b437d0133", 0 ) )
    {
        return;
    }
    
    level utility::flag_wait( "begin_round_logic" );
    level.var_68cc3148fd0b846 = utility::getstructarray( "loot_buddy_chompy", "targetname" );
    
    if ( !isdefined( level.var_68cc3148fd0b846 ) )
    {
        return;
    }
    
    function_2e7b34fd682fca9b();
    setup_store_chompy();
    level callback::add( "zm_exfil_started", &on_exfil_start );
    level callback::add( "on_round_start", &on_round_start );
    
    /#
        init_store_chompy_devgui();
    #/
}

// Namespace zm_store_chompy
// Params 0, eflags: 0x4
// Checksum 0x294432ec, Offset: 0x447
// Size: 0x3a1
function private function_2e7b34fd682fca9b()
{
    level.var_3ad4db72d45d0cfb = [ "self_revive", "rarity_upgrade", "pap_upgrade", "perk" ];
    level.var_def3ae4df91df01a = [];
    level.var_def3ae4df91df01a[ 1 ] = %"itemspawnentry:zm_t10_item_aether_crystal";
    level.var_def3ae4df91df01a[ 2 ] = %"itemspawnentry:zm_t10_item_aether_crystal_2";
    level.var_def3ae4df91df01a[ 3 ] = %"itemspawnentry:zm_t10_item_aether_crystal_3";
    level.var_a90df52f7134ce0 = [];
    level.var_a90df52f7134ce0[ 1 ] = %"itemspawnentry:zm_t10_item_aether_tool";
    level.var_a90df52f7134ce0[ 2 ] = %"itemspawnentry:zm_t10_item_aether_tool_2";
    level.var_a90df52f7134ce0[ 3 ] = %"itemspawnentry:zm_t10_item_aether_tool_3";
    level.var_a90df52f7134ce0[ 4 ] = %"itemspawnentry:zm_t10_item_aether_tool_4";
    level.var_bb0fe744fe894e26 = [ { #var_827e6c420604dd2:%"itemspawnentry:zm_t10_item_perk_juggernog", #perk_ref:"specialty_juggernog" }, { #var_827e6c420604dd2:%"itemspawnentry:zm_t10_item_perk_quickrevive", #perk_ref:"specialty_quickrevive" }, { #var_827e6c420604dd2:%"itemspawnentry:zm_t10_item_perk_speedcola", #perk_ref:"specialty_speedcola" }, { #var_827e6c420604dd2:%"itemspawnentry:zm_t10_item_perk_staminup", #perk_ref:"specialty_staminup" }, { #var_827e6c420604dd2:%"itemspawnentry:zm_t10_item_perk_deadshot", #perk_ref:"specialty_deadshot" }, { #var_827e6c420604dd2:%"itemspawnentry:zm_t10_item_perk_death_perception", #perk_ref:"specialty_death_perception" }, { #var_827e6c420604dd2:%"itemspawnentry:zm_t10_item_perk_elementalpop", #perk_ref:"specialty_elemental_pop" }, { #var_827e6c420604dd2:%"hash_35bfcd79fa72f41a", #perk_ref:"specialty_phd_flopper" }, { #var_827e6c420604dd2:%"itemspawnentry:zm_t10_item_perk_vulture_aid", #perk_ref:"specialty_vulture_aid" }, { #var_827e6c420604dd2:%"hash_342cb8b7ada6857d", #perk_ref:"specialty_m_mod" }, { #var_827e6c420604dd2:%"itemspawnentry:zm_t10_item_perk_d_mod", #perk_ref:"specialty_d_mod" }, { #var_827e6c420604dd2:%"hash_52bfc7ae674793a6", #perk_ref:"specialty_w_mod" }, { #var_827e6c420604dd2:%"hash_721257799165b90c", #perk_ref:"specialty_y_mod" } ];
    level.var_2599e0f829182764 = [ { #var_827e6c420604dd2:%"hash_5057440ef5f9d5aa", #type:"killstreak" }, { #var_827e6c420604dd2:%"hash_310827daa6e32831", #type:"killstreak" }, { #powerup_ref:"nuke", #type:"powerup" }, { #powerup_ref:"insta_kill", #type:"powerup" }, { #powerup_ref:"full_power", #type:"powerup" }, { #powerup_ref:"full_armor", #type:"powerup" } ];
}

// Namespace zm_store_chompy
// Params 0, eflags: 0x4
// Checksum 0xae7f6330, Offset: 0x7f0
// Size: 0x1ab
function private setup_store_chompy()
{
    level.a_store_chompy = [];
    
    foreach ( chompy_struct in level.var_68cc3148fd0b846 )
    {
        if ( getdvarint( @"hash_4d0a6f6852a2b04e", 0 ) )
        {
            chompy = spawnscriptable( "zm_sat_loot_chompy_orange", chompy_struct.origin, chompy_struct.angles );
        }
        else
        {
            chompy = spawnscriptable( "zm_sat_loot_chompy", chompy_struct.origin, chompy_struct.angles );
        }
        
        chompy.zone = chompy_struct.script_noteworthy;
        createnavobstaclebybounds( chompy.origin, ( 16, 16, 80 ), chompy.angles );
        level.a_store_chompy[ level.a_store_chompy.size ] = chompy;
        utility::callsharedfunc( #"scriptable", #"hash_10d5e3bb8a551724", chompy, "icon" );
        chompy.activated = 0;
        chompy.b_on_cooldown = 0;
        
        if ( utility::issharedfuncdefined( #"zombie", #"is_chompy_activated" ) )
        {
            if ( utility::callsharedfunc( #"zombie", #"is_chompy_activated", chompy ) )
            {
                chompy activate_chompy();
            }
        }
    }
}

// Namespace zm_store_chompy
// Params 0
// Checksum 0x5a04cecc, Offset: 0x9a3
// Size: 0x97
function activate_chompy()
{
    self setscriptablepartstate( "anim", "idle" );
    self setscriptablepartstate( "simple_fx", "activated_fx" );
    self setscriptablepartstate( "use_part", "on" );
    self setscriptablepartstate( "health", "ignore_damage" );
    self.activated = 1;
    self.b_on_cooldown = 0;
    self.b_is_open = 0;
    self.var_7aad9a95e00b08bd = 0;
    
    if ( !isdefined( self.interact ) )
    {
        self.interact = interaction::register_scriptable_interact( self, &on_purchase, &on_purchase, undefined, &store_hint_callback );
    }
}

// Namespace zm_store_chompy
// Params 0
// Checksum 0x4057084f, Offset: 0xa42
// Size: 0x5d
function deactivate_chompy()
{
    waitframe();
    self setscriptablepartstate( "use_part", "off" );
    self setscriptablepartstate( "simple_fx", "idle" );
    self setscriptablepartstate( "anim", "close" );
    self notify( #"deactivated" );
    self.activated = 0;
    self.b_on_cooldown = 0;
    self.b_is_open = 0;
}

// Namespace zm_store_chompy
// Params 0, eflags: 0x4
// Checksum 0x9308fb06, Offset: 0xaa7
// Size: 0x2a
function private try_open()
{
    if ( !self.b_is_open )
    {
        self setscriptablepartstate( "anim", "open" );
        self.b_is_open = 1;
    }
}

// Namespace zm_store_chompy
// Params 0, eflags: 0x4
// Checksum 0xf5d46903, Offset: 0xad9
// Size: 0x28
function private try_close()
{
    if ( self.b_is_open )
    {
        self setscriptablepartstate( "anim", "close" );
        self.b_is_open = 0;
    }
}

// Namespace zm_store_chompy
// Params 0, eflags: 0xc
// Checksum 0xc6e14bfb, Offset: 0xb09
// Size: 0x68
function private function_4e30a2150f126b22()
{
    self notify( #"hash_15cf0d90a52d5c56" );
    self endon( #"hash_15cf0d90a52d5c56" );
    level endon( #"game_ended" );
    self endon( #"deactivated" );
    
    while ( true )
    {
        self.var_7aad9a95e00b08bd = 0;
        waitframe();
        
        if ( self.var_7aad9a95e00b08bd <= 0 && !self.b_on_cooldown )
        {
            try_close();
        }
    }
}

// Namespace zm_store_chompy
// Params 1
// Checksum 0x47a2a39b, Offset: 0xb79
// Size: 0xa8
function on_round_start( params )
{
    foreach ( chompy in level.a_store_chompy )
    {
        if ( !chompy.activated )
        {
            if ( zone_manager::function_65305a611c6226d9( chompy.origin ) )
            {
                chompy activate_chompy();
            }
        }
    }
}

// Namespace zm_store_chompy
// Params 1
// Checksum 0x10968df, Offset: 0xc29
// Size: 0x93
function on_exfil_start( params )
{
    foreach ( chompy in level.a_store_chompy )
    {
        if ( chompy.activated )
        {
            chompy deactivate_chompy();
        }
    }
}

// Namespace zm_store_chompy
// Params 2, eflags: 0x4
// Checksum 0x75a0a57b, Offset: 0xcc4
// Size: 0x153
function private store_hint_callback( interact, player )
{
    if ( !interact.activated || interact.b_on_cooldown )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    var_bcfe0ed5ba4c9e74 = getdvarint( @"hash_7eca1e67f54ad5b7", 30000 );
    var_1d0ee4635dfe5650 = player currency::can_afford( #"essence", var_bcfe0ed5ba4c9e74 );
    
    if ( var_1d0ee4635dfe5650 )
    {
        interact.var_7aad9a95e00b08bd++;
        interact try_open();
        interact thread function_4e30a2150f126b22();
    }
    
    hint_data = { #interactable:var_1d0ee4635dfe5650, #icon_text_value:var_bcfe0ed5ba4c9e74, #var_776a268784e089af:&"SHARED_HINTSTRINGS/COST_ESSENCE", #icon:"sat_ui_icon_zm_loot_devouring_creature", #buttoncallout:&"hash_2794d593fb878c76", #description:&"hash_6d6c16a64dfeda31", #title:&"shared_hintstrings/buddy_chompy_title", #type:"HINT_BUTTON" };
    
    if ( !var_1d0ee4635dfe5650 )
    {
        hint_data.var_776a268784e089af = &"SHARED_HINTSTRINGS/COST_ESSENCE_NOT_ENOUGH";
    }
    
    return hint_data;
}

// Namespace zm_store_chompy
// Params 1, eflags: 0x4
// Checksum 0xd9d8667c, Offset: 0xe20
// Size: 0x116
function private on_purchase( player )
{
    if ( self.b_on_cooldown || !self.activated )
    {
        return;
    }
    
    var_bcfe0ed5ba4c9e74 = getdvarint( @"hash_7eca1e67f54ad5b7", 30000 );
    
    if ( !player currency::attempt_purchase( #"essence", var_bcfe0ed5ba4c9e74, 0, 0, "store_chompy" ) )
    {
        return;
    }
    
    var_1344b6c6ccd6e526 = function_9cbfc16a88ea71ba( player );
    params = { #cost:var_bcfe0ed5ba4c9e74, #currency:#"essence", #var_1344b6c6ccd6e526:var_1344b6c6ccd6e526, #player:player };
    player callback::callback( #"store_chompy_purchase", params );
    
    if ( !isdefined( var_1344b6c6ccd6e526 ) )
    {
        /#
            iprintlnbold( "<dev string:x24>" );
        #/
        
        return;
    }
    
    if ( var_1344b6c6ccd6e526.type == "powerup" )
    {
        thread function_d7b30ba9d5c6c0da( var_1344b6c6ccd6e526.powerup_ref );
        return;
    }
    
    thread function_ab54733b54dc58dd( var_1344b6c6ccd6e526.var_827e6c420604dd2 );
}

// Namespace zm_store_chompy
// Params 0, eflags: 0x4
// Checksum 0xd6c56082, Offset: 0xf3e
// Size: 0x87
function private function_f6c19ad3f3501f82()
{
    if ( !isdefined( level.zm_relics ) )
    {
        return 0;
    }
    
    relic_bundle = level.zm_relics[ %"relic:sat_zm_firefly_eta_relic" ];
    
    if ( !isdefined( relic_bundle ) )
    {
        return 0;
    }
    
    if ( !utility::issharedfuncdefined( #"relics", #"hash_9264c89cf44e24ee" ) )
    {
        return 0;
    }
    
    var_aaefeb9f5f446b00 = utility::callsharedfunc( #"relics", #"hash_9264c89cf44e24ee", relic_bundle.modifiertype );
    return var_aaefeb9f5f446b00;
}

// Namespace zm_store_chompy
// Params 1, eflags: 0x4
// Checksum 0x5b9b3437, Offset: 0xfce
// Size: 0x156
function private function_9cbfc16a88ea71ba( player )
{
    if ( !function_f6c19ad3f3501f82() && !player laststand::hasselfrevivetoken() && player laststand::function_ed4da7e5751eed47() )
    {
        return { #var_827e6c420604dd2:%"hash_428e5b0816d1da5f", #type:"item" };
    }
    
    var_af3c1b79dd6e23e1 = [];
    
    foreach ( str_type in level.var_3ad4db72d45d0cfb )
    {
        if ( str_type == "self_revive" )
        {
            continue;
        }
        
        if ( !function_f7eb67c70ec3d825( player, str_type ) )
        {
            continue;
        }
        
        var_af3c1b79dd6e23e1[ var_af3c1b79dd6e23e1.size ] = str_type;
    }
    
    if ( var_af3c1b79dd6e23e1.size )
    {
        str_selected = var_af3c1b79dd6e23e1[ randomint( var_af3c1b79dd6e23e1.size ) ];
        var_827e6c420604dd2 = function_3698938df41822a3( player, str_selected );
        
        if ( isdefined( var_827e6c420604dd2 ) )
        {
            return { #var_827e6c420604dd2:var_827e6c420604dd2, #type:"item" };
        }
    }
    
    return level.var_2599e0f829182764[ randomint( level.var_2599e0f829182764.size ) ];
}

// Namespace zm_store_chompy
// Params 2, eflags: 0x4
// Checksum 0xdfb3d1ea, Offset: 0x112d
// Size: 0xf0
function private function_f7eb67c70ec3d825( player, str_type )
{
    switch ( str_type )
    {
        case #"hash_4e20f52fe10f267d":
            weapon = player getcurrentweapon();
            
            if ( !isdefined( weapon ) || weapon == level.weaponnone )
            {
                return 0;
            }
            
            rarity = player item_weapon::function_fb81bd2fe070faa6( weapon );
            return isdefined( level.var_a90df52f7134ce0[ rarity + 1 ] );
        case #"hash_502c8e1e1f3efad9":
            weapon = player getcurrentweapon();
            
            if ( !isdefined( weapon ) || weapon == level.weaponnone )
            {
                return 0;
            }
            
            var_951c89546ec50477 = player pack_a_punch::get_pap_level( weapon );
            return isdefined( level.var_def3ae4df91df01a[ var_951c89546ec50477 + 1 ] );
        case #"hash_ab671284a3fc4e3d":
            return !player zombie_perks::function_cda78d45986a51a0();
        default:
            return 1;
    }
}

// Namespace zm_store_chompy
// Params 2, eflags: 0x4
// Checksum 0x5aa33c1d, Offset: 0x1225
// Size: 0xb9
function private function_3698938df41822a3( player, str_type )
{
    switch ( str_type )
    {
        case #"hash_4e20f52fe10f267d":
            weapon = player getcurrentweapon();
            rarity = player item_weapon::function_fb81bd2fe070faa6( weapon );
            return level.var_a90df52f7134ce0[ rarity + 1 ];
        case #"hash_502c8e1e1f3efad9":
            weapon = player getcurrentweapon();
            var_951c89546ec50477 = player pack_a_punch::get_pap_level( weapon );
            return level.var_def3ae4df91df01a[ var_951c89546ec50477 + 1 ];
        case #"hash_ab671284a3fc4e3d":
            return function_28e7eb17efb4db3( player );
        default:
            return;
    }
}

// Namespace zm_store_chompy
// Params 1, eflags: 0x4
// Checksum 0xf726e36, Offset: 0x12e6
// Size: 0xcb
function private function_28e7eb17efb4db3( player )
{
    var_7e7633b9ed7c6725 = [];
    
    foreach ( var_331ad6bec3fc00bc in level.var_bb0fe744fe894e26 )
    {
        if ( !player zombie_perks::has_perk( var_331ad6bec3fc00bc.perk_ref ) )
        {
            var_7e7633b9ed7c6725[ var_7e7633b9ed7c6725.size ] = var_331ad6bec3fc00bc;
        }
    }
    
    if ( !var_7e7633b9ed7c6725.size )
    {
        return;
    }
    
    s_selected = var_7e7633b9ed7c6725[ randomint( var_7e7633b9ed7c6725.size ) ];
    return s_selected.var_827e6c420604dd2;
}

// Namespace zm_store_chompy
// Params 0, eflags: 0x4
// Checksum 0x13a29a1b, Offset: 0x13ba
// Size: 0xf9
function private get_store_drop_point()
{
    v_forward = anglestoforward( self.angles );
    v_forward = vectornormalize( ( v_forward[ 0 ], v_forward[ 1 ], 0 ) );
    var_fd828251e1d71fb6 = utility::function_5918594658d3ffba( self.origin, 100, -256, 64 );
    
    if ( !isdefined( var_fd828251e1d71fb6 ) )
    {
        var_fd828251e1d71fb6 = self.origin;
    }
    
    v_drop_search_origin = var_fd828251e1d71fb6 + v_forward * 50;
    v_drop_point = function_1cac9022ed70b162( v_drop_search_origin, var_fd828251e1d71fb6 );
    
    if ( isdefined( v_drop_point ) )
    {
        return v_drop_point;
    }
    
    for ( var_38628366cb59b29a = 0; var_38628366cb59b29a < 8 ; var_38628366cb59b29a++ )
    {
        v_drop_candidate = utility::function_7afe366c29a77c34( v_drop_search_origin, 16 );
        v_drop_candidate = function_1cac9022ed70b162( v_drop_candidate, var_fd828251e1d71fb6 );
        
        if ( isdefined( v_drop_candidate ) )
        {
            return v_drop_candidate;
        }
    }
    
    v_drop_point = function_1cac9022ed70b162( var_fd828251e1d71fb6, var_fd828251e1d71fb6 );
    
    if ( isdefined( v_drop_point ) )
    {
        return v_drop_point;
    }
    
    return utility::drop_to_ground( v_drop_search_origin + ( 0, 0, 100 ), 100, -256 );
}

// Namespace zm_store_chompy
// Params 2, eflags: 0x4
// Checksum 0x2b3c6870, Offset: 0x14bc
// Size: 0x56
function private function_1cac9022ed70b162( v_drop_point, var_fd828251e1d71fb6 )
{
    if ( !isdefined( v_drop_point ) )
    {
        return;
    }
    
    v_navmesh_drop_point = getclosestpointonnavmesh( v_drop_point );
    
    if ( !isdefined( v_navmesh_drop_point ) )
    {
        return;
    }
    
    if ( !zone_manager::function_65305a611c6226d9( v_navmesh_drop_point ) )
    {
        return;
    }
    
    if ( v_navmesh_drop_point[ 2 ] > var_fd828251e1d71fb6[ 2 ] + 64 )
    {
        return;
    }
    
    return v_navmesh_drop_point;
}

// Namespace zm_store_chompy
// Params 1, eflags: 0x4
// Checksum 0x5b4a6602, Offset: 0x151b
// Size: 0xf5
function private function_ab54733b54dc58dd( var_827e6c420604dd2 )
{
    level endon( #"game_ended" );
    self endon( #"deactivated" );
    self.b_on_cooldown = 1;
    item_bundle = getscriptbundle( var_827e6c420604dd2 );
    assert( isdefined( item_bundle ), "<dev string:x49>" );
    
    if ( !isdefined( item_bundle ) )
    {
        self.b_on_cooldown = 0;
        return;
    }
    
    drop_point = get_store_drop_point();
    self setscriptablepartstate( "anim", "spit" );
    wait 0.7;
    common_item::function_47324f290423b2d1( item_bundle, self.origin + ( 0, 0, 40 ), drop_point );
    self setscriptablepartstate( "anim", "close" );
    self setscriptablepartstate( "simple_fx", "idle" );
    self.b_is_open = 0;
    wait 3;
    self setscriptablepartstate( "simple_fx", "activated_fx" );
    self.b_on_cooldown = 0;
}

// Namespace zm_store_chompy
// Params 1, eflags: 0x4
// Checksum 0x825f219b, Offset: 0x1618
// Size: 0xb0
function private function_d7b30ba9d5c6c0da( str_powerup_ref )
{
    level endon( #"game_ended" );
    self endon( #"deactivated" );
    self.b_on_cooldown = 1;
    drop_point = get_store_drop_point();
    self setscriptablepartstate( "anim", "spit" );
    wait 0.7;
    powerups::force_powerup_drop( str_powerup_ref, drop_point, "store_chompy" );
    self setscriptablepartstate( "anim", "close" );
    self setscriptablepartstate( "simple_fx", "idle" );
    self.b_is_open = 0;
    wait 3;
    self setscriptablepartstate( "simple_fx", "activated_fx" );
    self.b_on_cooldown = 0;
}

/#

    // Namespace zm_store_chompy
    // Params 0, eflags: 0x4
    // Checksum 0x3f1d0696, Offset: 0x16d0
    // Size: 0x2e, Type: dev
    function private init_store_chompy_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x6a>" );
        devgui::add_devgui_func( "<dev string:x87>", "<dev string:x87>", &function_ae6b2d0436493572 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_store_chompy
    // Params 0
    // Checksum 0x799c503c, Offset: 0x1706
    // Size: 0xa3, Type: dev
    function function_ae6b2d0436493572()
    {
        foreach ( chompy in level.a_store_chompy )
        {
            if ( chompy.activated )
            {
                continue;
            }
            
            if ( zone_manager::function_65305a611c6226d9( chompy.origin ) )
            {
                chompy activate_chompy();
            }
        }
    }

#/
