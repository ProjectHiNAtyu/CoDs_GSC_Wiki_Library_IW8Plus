// scripts\mp\zm\systems\zm_fasttravel_core.gsc  (hash_26dac680b1c3e48f.gscc) (size: 37681 Bytes / 0x9331 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1ee930ee (518598894)
// size ...... 37681 (0x9331)
// includes .. 23  (offset: 0x89f9)
// strings ... 112 (offset: 0x8ab1)
// dev strs .. 22  (offset: 0x91f9)
// exports ... 60  (offset: 0x5fd1)
// cseg ...... 0x94d + 0x5684 (0x5fd1)
// imports ... 269 (offset: 0x6931)
// animtree1 . 1   (offset: 0x9311)
// animtree2 . 1   (offset: 0x9321)
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\anim_scene;
#using scripts\mp\common\killstreaks\rcxd_shared;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\vision_utility;
#using scripts\mp\compass;
#using scripts\mp\currency;
#using scripts\mp\interaction;
#using scripts\mp\laststand;
#using scripts\mp\playerlogic;
#using scripts\mp\supers;
#using scripts\mp\zm\zm_player;

#namespace zm_fasttravel_core;

// Namespace zm_fasttravel_core
// Params 0, eflags: 0x5
// Checksum 0xc569d0c2, Offset: 0x96b
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"zm_fasttravel_core", undefined, &pre_init, &post_init );
}

// Namespace zm_fasttravel_core
// Params 0
// Checksum 0xc6864219, Offset: 0x990
// Size: 0xf1
function pre_init()
{
    level._effect[ "vfx_player_screen_distortion" ] = loadfxasset( "vfx_jup_ob_gameplay_zm_screen_elec_shock_bot" );
    level._effect[ "wormhole_vfx" ] = loadfxasset( "vfx_t10_gameplay_zm_aether_tear_portal_tunnel_1p" );
    setdvarifuninitialized( @"hash_f6d3570dc7b0b026", 0 );
    
    if ( !isdefined( level.s_zm_fasttravel ) )
    {
        level.s_zm_fasttravel = spawnstruct();
    }
    
    var_44f969436b2b81ed = getscriptbundlenames( "fasttravelsettings" );
    
    foreach ( bundle in var_44f969436b2b81ed )
    {
        fasttravel_setting = getscriptbundle( bundle );
        function_ba5d24026e364b24( fasttravel_setting );
    }
}

// Namespace zm_fasttravel_core
// Params 1
// Checksum 0x14249919, Offset: 0xa89
// Size: 0x7cd
function function_ba5d24026e364b24( fasttravel_setting )
{
    level.s_zm_fasttravel.var_c791990671337c74 = fasttravel_setting.var_c791990671337c74 ?? "zm_t10_teleport_vortex";
    level.s_zm_fasttravel.var_47f8d98ac9667b45 = fasttravel_setting.var_47f8d98ac9667b45;
    
    if ( !isdefined( level.s_zm_fasttravel.var_747103a5509e874c ) )
    {
        level.s_zm_fasttravel.var_747103a5509e874c = [];
    }
    
    foreach ( data in fasttravel_setting.fasttraveldata )
    {
        if ( isdefined( data.var_c49c4bfc1121c983 ) )
        {
            if ( !isdefined( level.s_zm_fasttravel.var_747103a5509e874c[ data.var_c49c4bfc1121c983 ] ) )
            {
                level.s_zm_fasttravel.var_747103a5509e874c[ data.var_c49c4bfc1121c983 ] = spawnstruct();
            }
            
            level.s_zm_fasttravel.var_747103a5509e874c[ data.var_c49c4bfc1121c983 ].var_1fce01ccc07be12f = data.var_1fce01ccc07be12f ?? "teleport_portal_zm";
            level.s_zm_fasttravel.var_747103a5509e874c[ data.var_c49c4bfc1121c983 ].var_41e055c4d98dd1d4 = data.var_41e055c4d98dd1d4;
            level.s_zm_fasttravel.var_747103a5509e874c[ data.var_c49c4bfc1121c983 ].var_ece53a0a154aa1c0 = data.var_ece53a0a154aa1c0;
            level.s_zm_fasttravel.var_747103a5509e874c[ data.var_c49c4bfc1121c983 ].fasttravelscriptmodel = data.fasttravelscriptmodel;
            level.s_zm_fasttravel.var_747103a5509e874c[ data.var_c49c4bfc1121c983 ].var_b7568d275536ca27 = data.var_b7568d275536ca27;
            level.s_zm_fasttravel.var_747103a5509e874c[ data.var_c49c4bfc1121c983 ].var_9f44ae350ab4d0cf = data.var_9f44ae350ab4d0cf;
            level.s_zm_fasttravel.var_747103a5509e874c[ data.var_c49c4bfc1121c983 ].var_89e6bfcfcd52824b = data.var_89e6bfcfcd52824b;
            level.s_zm_fasttravel.var_747103a5509e874c[ data.var_c49c4bfc1121c983 ].fasttravelcost = data.fasttravelcost;
            level.s_zm_fasttravel.var_747103a5509e874c[ data.var_c49c4bfc1121c983 ].var_59e9b2b8ad6d622 = data.var_59e9b2b8ad6d622;
            level.s_zm_fasttravel.var_747103a5509e874c[ data.var_c49c4bfc1121c983 ].var_c0ffafd2c238ef34 = data.var_c0ffafd2c238ef34;
            level.s_zm_fasttravel.var_747103a5509e874c[ data.var_c49c4bfc1121c983 ].var_bd653cb01ecd139b = data.var_bd653cb01ecd139b;
            level.s_zm_fasttravel.var_747103a5509e874c[ data.var_c49c4bfc1121c983 ].movementtype = data.movementtype;
            level.s_zm_fasttravel.var_747103a5509e874c[ data.var_c49c4bfc1121c983 ].var_640e35bf8be5b49a = data.var_640e35bf8be5b49a;
            level.s_zm_fasttravel.var_747103a5509e874c[ data.var_c49c4bfc1121c983 ].var_d9b1e3cf08b49316 = data.var_d9b1e3cf08b49316;
            level.s_zm_fasttravel.var_747103a5509e874c[ data.var_c49c4bfc1121c983 ].var_bccf8165f6807498 = data.var_bccf8165f6807498;
            level.s_zm_fasttravel.var_747103a5509e874c[ data.var_c49c4bfc1121c983 ].var_3f6b7fdf376d0525 = data.var_3f6b7fdf376d0525;
            level.s_zm_fasttravel.var_747103a5509e874c[ data.var_c49c4bfc1121c983 ].var_f649b85b3c82c2b4 = data.var_f649b85b3c82c2b4;
            level.s_zm_fasttravel.var_747103a5509e874c[ data.var_c49c4bfc1121c983 ].var_c9e0266e3e37dd50 = data.var_c9e0266e3e37dd50;
            level.s_zm_fasttravel.var_747103a5509e874c[ data.var_c49c4bfc1121c983 ].var_b452528a75fd2760 = data.var_b452528a75fd2760;
            level.s_zm_fasttravel.var_747103a5509e874c[ data.var_c49c4bfc1121c983 ].var_4d5acd79acb24ee7 = data.var_4d5acd79acb24ee7;
            level.s_zm_fasttravel.var_747103a5509e874c[ data.var_c49c4bfc1121c983 ].var_18ff8610dff995be = data.var_18ff8610dff995be;
            level.s_zm_fasttravel.var_747103a5509e874c[ data.var_c49c4bfc1121c983 ].var_f3daaa968410ca37 = data.var_f3daaa968410ca37;
            level.s_zm_fasttravel.var_747103a5509e874c[ data.var_c49c4bfc1121c983 ].var_7356d0194dc2471 = data.var_7356d0194dc2471;
            level.s_zm_fasttravel.var_747103a5509e874c[ data.var_c49c4bfc1121c983 ].var_15654c6de710f0ff = data.var_15654c6de710f0ff;
            level.s_zm_fasttravel.var_747103a5509e874c[ data.var_c49c4bfc1121c983 ].var_e1384f95bb621eee = data.var_e1384f95bb621eee;
            level.s_zm_fasttravel.var_747103a5509e874c[ data.var_c49c4bfc1121c983 ].var_95238e4bbec40d59 = data.var_95238e4bbec40d59;
            level.s_zm_fasttravel.var_747103a5509e874c[ data.var_c49c4bfc1121c983 ].var_d77bf4f1b12dba66 = data.var_d77bf4f1b12dba66;
            
            if ( isdefined( data.var_1afb147aa86f0464 ) )
            {
                level._effect[ "fasttravel_player_appear_vfx_" + data.var_c49c4bfc1121c983 ] = loadfxasset( data.var_1afb147aa86f0464 );
                level.s_zm_fasttravel.var_747103a5509e874c[ data.var_c49c4bfc1121c983 ].var_1afb147aa86f0464 = "fasttravel_player_appear_vfx_" + data.var_c49c4bfc1121c983;
            }
            
            if ( isdefined( data.var_5aec7d4e4108ebf6 ) )
            {
                level._effect[ "fasttravel_player_disappear_vfx_" + data.var_c49c4bfc1121c983 ] = loadfxasset( data.var_5aec7d4e4108ebf6 );
                level.s_zm_fasttravel.var_747103a5509e874c[ data.var_c49c4bfc1121c983 ].var_5aec7d4e4108ebf6 = "fasttravel_player_disappear_vfx_" + data.var_c49c4bfc1121c983;
            }
        }
    }
}

// Namespace zm_fasttravel_core
// Params 1
// Checksum 0x92600870, Offset: 0x125e
// Size: 0x350
function initialize_data( data )
{
    self.var_1fce01ccc07be12f = data.var_1fce01ccc07be12f;
    self.var_ece53a0a154aa1c0 = data.var_ece53a0a154aa1c0;
    self.var_41e055c4d98dd1d4 = data.var_41e055c4d98dd1d4;
    self.fasttravelscriptmodel = data.fasttravelscriptmodel;
    self.var_b7568d275536ca27 = data.var_b7568d275536ca27;
    self.var_9f44ae350ab4d0cf = data.var_9f44ae350ab4d0cf;
    self.var_89e6bfcfcd52824b = data.var_89e6bfcfcd52824b;
    self.fasttravelcost = data.fasttravelcost;
    self.var_59e9b2b8ad6d622 = data.var_59e9b2b8ad6d622;
    self.var_c0ffafd2c238ef34 = data.var_c0ffafd2c238ef34;
    self.var_bd653cb01ecd139b = data.var_bd653cb01ecd139b;
    self.movementtype = data.movementtype;
    self.var_640e35bf8be5b49a = data.var_640e35bf8be5b49a;
    self.var_d9b1e3cf08b49316 = data.var_d9b1e3cf08b49316;
    self.var_bccf8165f6807498 = data.var_bccf8165f6807498;
    self.var_3f6b7fdf376d0525 = data.var_3f6b7fdf376d0525;
    self.var_f649b85b3c82c2b4 = data.var_f649b85b3c82c2b4;
    self.var_c9e0266e3e37dd50 = data.var_c9e0266e3e37dd50;
    self.var_b452528a75fd2760 = data.var_b452528a75fd2760;
    self.var_4d5acd79acb24ee7 = data.var_4d5acd79acb24ee7;
    self.var_18ff8610dff995be = data.var_18ff8610dff995be;
    self.var_f3daaa968410ca37 = data.var_f3daaa968410ca37;
    self.var_7356d0194dc2471 = data.var_7356d0194dc2471;
    self.var_15654c6de710f0ff = data.var_15654c6de710f0ff;
    self.var_e1384f95bb621eee = data.var_e1384f95bb621eee;
    self.var_95238e4bbec40d59 = data.var_95238e4bbec40d59;
    self.var_d77bf4f1b12dba66 = data.var_d77bf4f1b12dba66;
    
    if ( isdefined( data.var_1afb147aa86f0464 ) )
    {
        self.var_1afb147aa86f0464 = data.var_1afb147aa86f0464;
    }
    
    if ( isdefined( data.var_5aec7d4e4108ebf6 ) )
    {
        self.var_5aec7d4e4108ebf6 = data.var_5aec7d4e4108ebf6;
    }
    
    if ( isdefined( self.var_3f6b7fdf376d0525 ) )
    {
        self.fasttravel_icon = self.var_3f6b7fdf376d0525;
    }
    else
    {
        switch ( self.var_f649b85b3c82c2b4 )
        {
            case #"hash_ac88f2abecd948cb":
                self.fasttravel_icon = "ui_icon_zm_ping_fast_travel_teleportation_and_portals";
                break;
            case #"hash_1fbc3e994f05f643":
                self.fasttravel_icon = "ui_icon_zm_ping_all_other_fast_travel";
                break;
        }
    }
    
    if ( isdefined( self.var_b452528a75fd2760 ) )
    {
        self.fasttravel_button_callout = self.var_b452528a75fd2760;
        return;
    }
    
    switch ( self.var_c9e0266e3e37dd50 )
    {
        case #"hash_ffb946c98b551ab":
            self.fasttravel_button_callout = &"SHARED_HINTSTRINGS/HINT_BUY";
            break;
        case #"hash_51d0616cbaf8c934":
            self.fasttravel_button_callout = &"SHARED_HINTSTRINGS/FASTTRAVEL_BUTTON_CALLOUT_AETHER_ELEVATOR";
            break;
    }
}

// Namespace zm_fasttravel_core
// Params 0
// Checksum 0x4c0678c, Offset: 0x15b6
// Size: 0x116
function post_init()
{
    level utility::flag_wait( "scriptables_ready" );
    
    if ( !level.gametypebundle.var_809dd58f8a112f22 )
    {
        return;
    }
    
    val::group_register( "anti_grav_launcher_flying", [ "usability", "weapon_switch", "supers", "gesture", "killstreaks", "offhand_weapons", "offhand_primary_weapons", "offhand_secondary_weapons", "allow_movement", "allow_jump", "crouch", "prone", "damage", "fire", "show_hud", "melee" ] );
    a_s_fasttravel_triggers = utility::getstructarray( "zm_fasttravel", "targetname" );
    
    if ( a_s_fasttravel_triggers.size == 0 )
    {
        return;
    }
    
    level._fasttravel[ "override_player_can_use_fasttravel" ] = &can_use_fasttravel;
    utility::array_thread( a_s_fasttravel_triggers, &init_fasttravel_trigger );
    
    /#
        init_fasttravel_debug();
    #/
}

// Namespace zm_fasttravel_core
// Params 0
// Checksum 0xa56717d5, Offset: 0x16d4
// Size: 0x3b1
function init_fasttravel_trigger()
{
    level endon( #"game_ended" );
    
    if ( !isdefined( level.s_zm_fasttravel.var_747103a5509e874c[ self.script_noteworthy ] ) )
    {
        assertmsg( "<dev string:x24>" + self.script_noteworthy + "<dev string:x4e>" );
        return;
    }
    
    level.s_zm_fasttravel.var_747103a5509e874c[ self.script_noteworthy ].script_struct = self;
    initialize_data( level.s_zm_fasttravel.var_747103a5509e874c[ self.script_noteworthy ] );
    
    if ( self.var_89e6bfcfcd52824b )
    {
        return;
    }
    
    switch ( self.movementtype )
    {
        case #"hash_b6eaac392bc793a6":
            init_launch_path();
            break;
        case #"hash_5952de3cf0e24426":
            break;
    }
    
    waitframe();
    
    if ( !isdefined( self.angles ) )
    {
        self.angles = ( 0, 0, 0 );
    }
    
    if ( self.var_9f44ae350ab4d0cf )
    {
        if ( isdefined( self.fasttravelscriptmodel ) )
        {
            self.fasttravel_scr = utility::spawn_model( self.fasttravelscriptmodel, self.origin, self.angles );
        }
        else if ( isdefined( self.var_1fce01ccc07be12f ) )
        {
            z_offset = self.var_41e055c4d98dd1d4;
            self.fasttravel_scr = spawnscriptable( self.var_1fce01ccc07be12f, self.origin + ( 0, 0, z_offset ), self.angles );
        }
    }
    
    if ( !self.var_f3daaa968410ca37 && !level.s_zm_fasttravel.var_747103a5509e874c[ self.var_b7568d275536ca27 ].var_89e6bfcfcd52824b )
    {
        interact_loc = self.origin + anglestoforward( self.angles ) * self.var_18ff8610dff995be;
        self.interact = interaction::register_interact( interact_loc, 96, &function_868501bd7c06243d );
        self.interact interaction::set_interact_hint_callback( &setup_fasttravel_hintstring );
        self.interact.var_7899dd4d8ac31d1a = self;
        self.interact.var_7899dd4d8ac31d1a.var_2efb9165f56da06d = 1;
    }
    
    if ( isdefined( self.var_59e9b2b8ad6d622 ) )
    {
        level utility::flag_wait( self.var_59e9b2b8ad6d622 );
    }
    
    if ( isdefined( self.fasttravel_scr ) )
    {
        if ( isdefined( self.var_ece53a0a154aa1c0 ) )
        {
            self.fasttravel_scr setscriptablepartstate( "base", self.var_ece53a0a154aa1c0 );
        }
        else
        {
            self.fasttravel_scr setscriptablepartstate( "base", "idle" );
        }
        
        utility::callsharedfunc( #"scriptable", #"hash_10d5e3bb8a551724", self.fasttravel_scr, "icon" );
    }
    
    if ( isdefined( self.interact ) || level.s_zm_fasttravel.var_747103a5509e874c[ self.var_b7568d275536ca27 ].var_89e6bfcfcd52824b )
    {
        return;
    }
    
    interact_loc = self.origin + anglestoforward( self.angles ) * self.var_18ff8610dff995be;
    self.interact = interaction::register_interact( interact_loc, 96, &function_868501bd7c06243d );
    self.interact interaction::set_interact_hint_callback( &setup_fasttravel_hintstring );
    self.interact.var_7899dd4d8ac31d1a = self;
    self.interact.var_7899dd4d8ac31d1a.var_2efb9165f56da06d = 1;
}

// Namespace zm_fasttravel_core
// Params 0
// Checksum 0x7acd3a6a, Offset: 0x1a8d
// Size: 0xec
function init_launch_path()
{
    var_8ff7a48b3fec2539 = utility::getstructarray( self.target, "targetname" );
    
    foreach ( sub in var_8ff7a48b3fec2539 )
    {
        if ( sub.script_noteworthy == "start" )
        {
            self.launch_start = sub;
            continue;
        }
        
        if ( sub.script_noteworthy == "handle" )
        {
            self.launch_handle = sub;
            continue;
        }
        
        if ( sub.script_noteworthy == "end" )
        {
            self.launch_end = sub;
        }
    }
}

// Namespace zm_fasttravel_core
// Params 2
// Checksum 0x853bb5a1, Offset: 0x1b81
// Size: 0x5cf
function setup_fasttravel_hintstring( usable, player )
{
    fasttravel_title = usable.var_7899dd4d8ac31d1a.var_640e35bf8be5b49a;
    fasttravel_description = usable.var_7899dd4d8ac31d1a.var_d9b1e3cf08b49316;
    fasttravel_icon = usable.var_7899dd4d8ac31d1a.fasttravel_icon;
    fasttravel_button = usable.var_7899dd4d8ac31d1a.fasttravel_button_callout;
    
    if ( isdefined( usable.fasttravel_interact_hint_callback ) )
    {
        result = [[ usable.fasttravel_interact_hint_callback ]]( usable, player );
        
        if ( isdefined( result ) )
        {
            return result;
        }
    }
    
    if ( isdefined( player ) && player.interactions_disabled || player isemoteactive() || level.disable_fasttravel || player isparachuting() || player.var_c51fe993f3dc78d9 || usable.var_7899dd4d8ac31d1a.b_disable_hint )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( usable.var_7899dd4d8ac31d1a.fasttravelcost == 0 )
    {
        var_776a268784e089af = &"";
        icon_text_value = undefined;
    }
    else
    {
        var_776a268784e089af = &"SHARED_HINTSTRINGS/COST_ESSENCE";
        icon_text_value = usable.var_7899dd4d8ac31d1a.fasttravelcost;
    }
    
    if ( !usable.var_7899dd4d8ac31d1a.var_2efb9165f56da06d || usable.var_e26932b14b792eb3 || isdefined( usable.var_7899dd4d8ac31d1a.var_59e9b2b8ad6d622 ) && !utility::flag( usable.var_7899dd4d8ac31d1a.var_59e9b2b8ad6d622 ) )
    {
        if ( usable.var_e26932b14b792eb3 )
        {
            aux_text = usable.var_7899dd4d8ac31d1a.var_d77bf4f1b12dba66;
        }
        else if ( isdefined( usable.var_7899dd4d8ac31d1a.var_59e9b2b8ad6d622 ) && !utility::flag( usable.var_7899dd4d8ac31d1a.var_59e9b2b8ad6d622 ) )
        {
            aux_text = usable.var_7899dd4d8ac31d1a.var_4d5acd79acb24ee7;
        }
        
        if ( !isdefined( aux_text ) )
        {
            aux_text = usable.var_7899dd4d8ac31d1a.var_7356d0194dc2471;
        }
        
        return { #interactable:0, #aux_text:aux_text, #buttoncallout:fasttravel_button, #icon_text_value:icon_text_value, #var_776a268784e089af:var_776a268784e089af, #icon:fasttravel_icon, #description:fasttravel_description, #title:fasttravel_title, #string:&"", #type:"HINT_BUTTON" };
    }
    
    if ( isarray( usable.var_b8b1708ca1ae7d42 ) && usable.var_b8b1708ca1ae7d42.size != 0 )
    {
        foreach ( info in usable.var_b8b1708ca1ae7d42 )
        {
            if ( info.player == player )
            {
                find = info;
                break;
            }
        }
        
        if ( find && find.current_cooldown_time >= 0 && usable.var_7899dd4d8ac31d1a.var_95238e4bbec40d59 )
        {
            var_776a268784e089af = usable.var_7899dd4d8ac31d1a.var_e1384f95bb621eee;
            icon_text_value = find.current_cooldown_time;
        }
        else
        {
            var_776a268784e089af = &"SHARED_HINTSTRINGS/COST_ESSENCE";
            icon_text_value = usable.var_7899dd4d8ac31d1a.fasttravelcost;
        }
        
        return { #interactable:0, #aux_text:usable.var_7899dd4d8ac31d1a.var_15654c6de710f0ff, #buttoncallout:fasttravel_button, #icon_text_value:find.current_cooldown_time, #var_776a268784e089af:usable.var_7899dd4d8ac31d1a.var_e1384f95bb621eee, #icon:fasttravel_icon, #description:fasttravel_description, #title:fasttravel_title, #string:&"", #type:"HINT_BUTTON" };
    }
    
    if ( usable.var_7899dd4d8ac31d1a.fasttravelcost != 0 )
    {
        aux_text = &"";
        b_interactable = 1;
        
        if ( !player currency::can_afford( #"essence", usable.var_7899dd4d8ac31d1a.fasttravelcost ) )
        {
            aux_text = &"SHARED_HINTSTRINGS/NOT_ENOUGH_ESSENCE";
            b_interactable = 0;
        }
    }
    
    return { #interactable:b_interactable, #aux_text:aux_text, #buttoncallout:fasttravel_button, #icon_text_value:icon_text_value, #var_776a268784e089af:var_776a268784e089af, #icon:fasttravel_icon, #description:fasttravel_description, #title:fasttravel_title, #string:&"", #type:"HINT_BUTTON" };
}

// Namespace zm_fasttravel_core
// Params 2
// Checksum 0x5f54d00e, Offset: 0x2159
// Size: 0x137, Type: bool
function can_use_fasttravel( player, interact )
{
    if ( player.var_d1c4c78b9fb7d153 || level.disable_fasttravel )
    {
        return false;
    }
    
    if ( isarray( interact.var_b8b1708ca1ae7d42 ) )
    {
        foreach ( info in interact.var_b8b1708ca1ae7d42 )
        {
            if ( info.player == player )
            {
                return false;
            }
        }
    }
    
    if ( isdefined( interact.var_5434f2cd988956b ) && arraycontains( interact.var_5434f2cd988956b, player ) )
    {
        return false;
    }
    
    if ( !interact.var_7899dd4d8ac31d1a.var_2efb9165f56da06d )
    {
        return false;
    }
    
    if ( player isemoteactive() )
    {
        return false;
    }
    
    if ( !player utility::callsharedfunc( #"bgb", #"hash_e47d9b7a1bc28040" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_fasttravel_core
// Params 1, eflags: 0x4
// Checksum 0x5d906e6d, Offset: 0x2299
// Size: 0x2df
function private function_868501bd7c06243d( player )
{
    level endon( #"game_ended" );
    
    if ( isdefined( player ) && player.interactions_disabled || player isparachuting() )
    {
        return;
    }
    
    if ( !self.var_7899dd4d8ac31d1a.var_2efb9165f56da06d )
    {
        return;
    }
    
    if ( isdefined( self.var_7899dd4d8ac31d1a.var_59e9b2b8ad6d622 ) )
    {
        if ( !utility::flag( self.var_7899dd4d8ac31d1a.var_59e9b2b8ad6d622 ) )
        {
            return;
        }
    }
    
    if ( isdefined( level._fasttravel[ "override_player_can_use_fasttravel" ] ) && ![[ level._fasttravel[ "override_player_can_use_fasttravel" ] ]]( player, self ) )
    {
        return;
    }
    
    if ( isdefined( player ) && isdefined( self.var_7899dd4d8ac31d1a.script_cost ) && self.var_7899dd4d8ac31d1a.script_cost != 0 )
    {
        if ( !player currency::attempt_purchase( #"essence", self.var_7899dd4d8ac31d1a.script_cost, 1, 0, #"fast_travel" ) )
        {
            /#
                iprintlnbold( "<dev string:x74>" );
            #/
            
            return;
        }
    }
    
    if ( isdefined( self.var_7899dd4d8ac31d1a.var_bd653cb01ecd139b ) )
    {
        params = spawnstruct();
        params.var_7899dd4d8ac31d1a = self.var_7899dd4d8ac31d1a;
        params.player = player;
        level notify( self.var_7899dd4d8ac31d1a.var_bd653cb01ecd139b, params );
    }
    
    player.var_d1c4c78b9fb7d153 = 1;
    str_destination_loc = self.var_7899dd4d8ac31d1a.var_57c31258748ae730;
    
    if ( !isdefined( str_destination_loc ) )
    {
        str_destination_loc = self.var_7899dd4d8ac31d1a.var_b7568d275536ca27;
    }
    
    s_destination = get_destination_struct( str_destination_loc );
    self.var_7899dd4d8ac31d1a.var_5a5626a7d4b2feb = player;
    player thread play_fasttravel_player_appear_vfx( self.var_7899dd4d8ac31d1a );
    
    switch ( self.var_7899dd4d8ac31d1a.movementtype )
    {
        case #"hash_1fbc3e994f05f643":
            level thread function_cbb08198e7c84adf( s_destination, player );
            break;
        case #"hash_d7fc0178c265d3dd":
            level thread function_cbb08198e7c84adf( s_destination, player, 1, 0, 1 );
            break;
        case #"hash_5952de3cf0e24426":
            level thread fasttravel_slide_path( player, s_destination );
            break;
        case #"hash_b6eaac392bc793a6":
            function_16444ae45d87d6b8();
            level thread function_86757a559fc064f6( player, self.var_7899dd4d8ac31d1a );
            break;
        case #"hash_962e81eaa0189796":
            level thread aether_elevator_use( player, s_destination );
            break;
    }
    
    if ( isent( self ) )
    {
        self playsoundevent( %"sndevent_teleportation_begin_3d", player );
    }
    
    player thread fasttravel_cooldown_timer( self );
}

// Namespace zm_fasttravel_core
// Params 2
// Checksum 0xddec5239, Offset: 0x2580
// Size: 0x9f
function play_fasttravel_player_appear_vfx( var_7899dd4d8ac31d1a, player )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( isdefined( var_7899dd4d8ac31d1a.var_5aec7d4e4108ebf6 ) )
    {
        playfx( level._effect[ var_7899dd4d8ac31d1a.var_5aec7d4e4108ebf6 ], self.origin );
    }
    
    self waittill( #"fasttravel_over" );
    waitframe();
    
    if ( isdefined( var_7899dd4d8ac31d1a.var_1afb147aa86f0464 ) )
    {
        playfx( level._effect[ var_7899dd4d8ac31d1a.var_1afb147aa86f0464 ], self.origin );
    }
}

#using_animtree( "script_model" );

// Namespace zm_fasttravel_core
// Params 0, eflags: 0x4
// Checksum 0x19b0a32, Offset: 0x2627
// Size: 0x73
function private function_16444ae45d87d6b8()
{
    level.scr_animtree[ "player" ] = #animtree;
    level.scr_anim[ "player" ][ "player_flying_midair" ][ 0 ] = %t10_mp_cannon_fly;
    level.scr_eventanim[ "player" ][ "player_flying_midair" ][ 0 ] = %"t10_mp_cannon_fly";
    level.scr_viewmodelanim[ "player" ][ "player_flying_midair" ][ 0 ] = "t10_vm_cannon_fly";
}

// Namespace zm_fasttravel_core
// Params 2, eflags: 0x4
// Checksum 0x180e97bf, Offset: 0x26a2
// Size: 0x25f
function private function_86757a559fc064f6( player, start_struct )
{
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    
    if ( !player utility::ent_flag( "flying_midair" ) )
    {
        player canceloffhands();
        player stopanimscriptsceneevent();
        player stopgestureviewmodel();
        
        if ( player isviewmodelanimplaying() )
        {
            player stopviewmodelanim();
        }
        
        player utility::ent_flag_set( "flying_midair" );
        assert( isdefined( start_struct.launch_start ) && isdefined( start_struct.launch_handle ) && isdefined( start_struct.launch_end ), "<dev string:x87>" );
        start_pos = start_struct.launch_start.origin;
        start_angles = start_struct.launch_start.angles ?? start_struct.angles;
        player.linktoent = player utility::spawn_tag_origin( player.origin, player getplayerangles( 0 ) );
        player playerlinktodelta( player.linktoent, "tag_origin", 1, 0, 0, 30, 30, 1, 1 );
        player.linktoent moveto( start_pos, 0.3, 0.1, 0.1 );
        player.linktoent rotateto( start_angles, 0.3, 0.1, 0.1 );
        player.var_68a0b94c11b03d1c = player getcurrentweapon();
        player childthread inventory_utility::givegunlessweapon();
        wait 0.3;
        
        if ( player )
        {
            player unlink();
            player.linktoent delete();
            player.linktoent = undefined;
            player setorigin( start_pos );
            player setplayerangles( start_angles );
            waitframe();
        }
        
        while ( player && player inventory_utility::isanymonitoredweaponswitchinprogress() )
        {
            waitframe();
        }
        
        if ( player )
        {
            actorplayer = anim_scene::anim_scene_create_actor( player, "player", 1, 0 );
            actorplayer.angles = self.angles;
            player create_player_rig( actorplayer );
            player thread function_ae28a0894a359cf2( actorplayer );
            start_struct thread function_4ff4c4e50376d767( player, actorplayer );
            player playsoundtoplayer( "evt_zm_fast_travel_launch_plr", player );
            player playsoundtoplayer( "evt_zm_fast_travel_fly_wind_plr", player );
        }
    }
}

// Namespace zm_fasttravel_core
// Params 1, eflags: 0x4
// Checksum 0xb22ba4ea, Offset: 0x2909
// Size: 0xde
function private function_ae28a0894a359cf2( actorplayer )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    scene_node = spawnstruct();
    scene_node.origin = self.origin;
    scene_node.angles = self.angles;
    scene_node thread anim_scene::anim_scene_loop( [ actorplayer ], "player_flying_midair", 0, 0 );
    utility::ent_flag_waitopen_any( "flying_midair" );
    scene_node anim_scene::anim_scene_stop();
    self stopanimscriptsceneevent();
    utility::ent_flag_clear( "animating" );
    val::reset_all( "anim_scene" );
    actorplayer.player_rig delete();
    
    while ( self isviewmodelanimplaying() )
    {
        waitframe();
    }
    
    thread inventory_utility::takegunlessweapon( self.var_68a0b94c11b03d1c );
    self.var_68a0b94c11b03d1c = undefined;
}

// Namespace zm_fasttravel_core
// Params 1, eflags: 0x4
// Checksum 0x2dc12f05, Offset: 0x29ef
// Size: 0x198
function private create_player_rig( actorplayer )
{
    self endon( #"death" );
    
    if ( !utility::ent_flag_exist( "animating" ) )
    {
        utility::ent_flag_init( "animating" );
    }
    
    utility::ent_flag_set( "animating" );
    dir = vectornormalize( anglestoforward( self.angles ) );
    arm_spawn_loc = dir * -5 + self.origin;
    actorplayer.player_rig = spawn( "script_arms", arm_spawn_loc + ( 0, 0, -5 ), 0, 0, self );
    actorplayer.player_rig.animname = actorplayer.animname;
    actorplayer.player_rig useanimtree( #animtree );
    actorplayer.player_rig.entity = self;
    
    if ( !isdefined( actorplayer.angles ) )
    {
        actorplayer.angles = ( 0, 0, 0 );
    }
    
    player_ang = actorplayer.angles;
    self setplayerangles( ( 0, player_ang[ 1 ], player_ang[ 2 ] ) );
    actorplayer.player_rig.angles = actorplayer.angles;
    self playerlinktodelta( actorplayer.player_rig, "tag_player", 0, 25, 25, 20, 20, 1, 1 );
    actorplayer.player_rig hide();
    actorplayer.player_rig showonlytoplayer( self );
}

// Namespace zm_fasttravel_core
// Params 2, eflags: 0x4
// Checksum 0xbfe645d4, Offset: 0x2b8f
// Size: 0x111
function private function_4ff4c4e50376d767( player, actorplayer )
{
    level endon( #"game_ended" );
    player endon( #"death" );
    pathname = self.targetname;
    s_start = self.launch_start;
    s_handle = self.launch_handle;
    var_4b4e6b999024cf0d = self.launch_end;
    player prestream_minimap( var_4b4e6b999024cf0d );
    curve_link = utility::spawn_tag_origin( player.origin, player.angles );
    actorplayer.player_rig linkto( curve_link );
    thread function_48b006834e47b7ce( player, curve_link, vectornormalize( var_4b4e6b999024cf0d.origin - s_start.origin ) );
    curve_link function_4eb04911ab250a19( s_start.origin, var_4b4e6b999024cf0d.origin, s_handle.origin, 2, 18 );
}

// Namespace zm_fasttravel_core
// Params 3
// Checksum 0x8359306d, Offset: 0x2ca8
// Size: 0x151
function function_48b006834e47b7ce( player, var_80f0a38c04a5950c, v_dir )
{
    level endon( #"game_ended" );
    player endon( #"death" );
    var_80f0a38c04a5950c waittill( #"on_bezier_curve" );
    player setshowcontrail( 1 );
    player thread function_5c4e72bad6e4c01d();
    var_80f0a38c04a5950c waittill( #"off_bezier_curve" );
    var_80f0a38c04a5950c delete();
    player notify( #"hash_9cd906c92066876" );
    player setshowcontrail( 0 );
    player utility::ent_flag_clear( "flying_midair" );
    player val::group_reset( "anti_grav_launcher_flying" );
    player val::set( "anti_grav_launcher_flying", "ignore_playable_area_check", 0 );
    player.var_d1c4c78b9fb7d153 = 0;
    self.interact.var_e26932b14b792eb3 = 0;
    linked_interact = function_b5c1ee3b3d3127b6();
    
    if ( linked_interact )
    {
        linked_interact.var_e26932b14b792eb3 = 0;
    }
    
    level thread function_82b678a1a54e9e1( player );
    player function_ec230bd50bdba27c( 1 );
    player knockback( ( v_dir[ 0 ], v_dir[ 1 ], -1 ), 500 );
    player stoprumble( "damage_light" );
    waitframe();
    
    if ( isalive( player ) )
    {
        player thread function_8366bb88e62833de();
        player utility::delaycallendon( 1, "death_or_disconnect", &function_ec230bd50bdba27c, 0 );
    }
}

// Namespace zm_fasttravel_core
// Params 0
// Checksum 0x22cc31f0, Offset: 0x2e01
// Size: 0x33
function function_b5c1ee3b3d3127b6()
{
    return level.s_zm_fasttravel.var_747103a5509e874c[ self.var_b7568d275536ca27 ].script_struct.interact;
}

// Namespace zm_fasttravel_core
// Params 5, eflags: 0x4
// Checksum 0x68d85a0f, Offset: 0x2e3d
// Size: 0x266
function private function_4eb04911ab250a19( start_pos, end_pos, control_pos, time, fly_speed )
{
    self endon( #"death" );
    accel_frac = 0.45;
    decel_frac = 0;
    b_draw_path = 0;
    
    if ( !isdefined( b_draw_path ) )
    {
        b_draw_path = 0;
    }
    
    start_point = start_pos;
    end_point = end_pos;
    control_point = control_pos;
    t = 0;
    move_start = gettime();
    fly_speed /= 100;
    decel_start_time = 1 - decel_frac;
    self notify( #"on_bezier_curve" );
    
    while ( true )
    {
        if ( !isdefined( self ) )
        {
            return;
        }
        
        t = ( gettime() - move_start ) / 1000 / time;
        
        if ( t < accel_frac )
        {
            accel_pct = t / accel_frac;
            var_e22e6b1aba4f620e = easepower( accel_pct, 2, 1, 1 );
            var_e22e6b1aba4f620e = clamp( var_e22e6b1aba4f620e, 0, 1 );
        }
        else if ( t > decel_start_time )
        {
            decel_pct = ( t - decel_start_time ) / decel_frac;
            var_e22e6b1aba4f620e = 1 - easesine( decel_pct, 1, 0 );
            var_e22e6b1aba4f620e = clamp( var_e22e6b1aba4f620e, 0, 1 );
        }
        else
        {
            var_e22e6b1aba4f620e = 1;
        }
        
        t += var_e22e6b1aba4f620e * fly_speed;
        
        if ( t <= 1 )
        {
            /#
                oldpos = self.origin;
            #/
            
            op1 = pow( 1 - t, 2 );
            op2 = 2 * ( 1 - t ) * t;
            op3 = pow( t, 2 );
            xdest = op1 * start_point[ 0 ] + op2 * control_point[ 0 ] + op3 * end_point[ 0 ];
            ydest = op1 * start_point[ 1 ] + op2 * control_point[ 1 ] + op3 * end_point[ 1 ];
            zdest = op1 * start_point[ 2 ] + op2 * control_point[ 2 ] + op3 * end_point[ 2 ];
            self.origin = ( xdest, ydest, zdest );
            
            /#
                if ( b_draw_path )
                {
                    thread utility::draw_line_for_time( self.origin, oldpos, 1, 1, 1, time * 10 );
                }
            #/
        }
        else
        {
            break;
        }
        
        waitframe();
    }
    
    self notify( #"off_bezier_curve" );
}

// Namespace zm_fasttravel_core
// Params 0, eflags: 0x4
// Checksum 0xa27256e4, Offset: 0x30ab
// Size: 0xa9
function private function_5c4e72bad6e4c01d()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_9cd906c92066876" );
    start_time = gettime();
    
    while ( gettime() - start_time <= 300 )
    {
        self earthquakeforplayer( 0.6, 0.1, self.origin, 600 );
        self playrumbleonentity( "damage_heavy" );
        wait 0.1;
    }
    
    while ( true )
    {
        self earthquakeforplayer( 0.15, 0.1, self.origin, 600 );
        self playrumbleonentity( "damage_light" );
        wait 0.1;
    }
}

// Namespace zm_fasttravel_core
// Params 0, eflags: 0x4
// Checksum 0xe3cf6e5b, Offset: 0x315c
// Size: 0x6b
function private function_8366bb88e62833de()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    time = 0.8;
    
    while ( time >= 0 )
    {
        self earthquakeforplayer( 0.6, 0.1, self.origin, 64 );
        self playrumbleonentity( "damage_heavy" );
        time -= 0.1;
        wait 0.1;
    }
}

// Namespace zm_fasttravel_core
// Params 1, eflags: 0x4
// Checksum 0x1d0ba2fe, Offset: 0x31cf
// Size: 0xd2
function private function_82b678a1a54e9e1( player )
{
    a_ai = getaiarrayinradius( player.origin, 128 );
    
    foreach ( ai in a_ai )
    {
        if ( isalive( ai ) )
        {
            v_dir = ai.origin - player.origin;
            ai zombie_knockdown::function_6fc167d4a3590991( player.origin, 999 );
            waitframe();
        }
    }
}

// Namespace zm_fasttravel_core
// Params 2, eflags: 0x4
// Checksum 0x9e3eefef, Offset: 0x32a9
// Size: 0x56d
function private aether_elevator_use( player, s_destination )
{
    level endon( #"game_ended" );
    
    if ( player )
    {
        player endon( #"death_or_disconnect" );
    }
    
    if ( isdefined( self.var_7899dd4d8ac31d1a.b_offline ) )
    {
        return;
    }
    
    player utility::ent_flag_set( "fasttravel_start" );
    params = { #delay:0, #player:player };
    callback::callback( "callback_play_ae_vo", params );
    player thread fasttravel_cooldown_timer( self );
    player function_12b11b69ea8587b8( 1 );
    player set_player_vars( 1 );
    player val::set( "fasttravel", "weapon", 0 );
    player val::set( "fasttravel", "crouch", 0 );
    player val::set( "fasttravel", "prone", 0 );
    player val::set( "aether_elevator_tp", "allow_toggle_third_person", 0 );
    player prestream_minimap( s_destination );
    
    if ( !isdefined( self.var_7899dd4d8ac31d1a.angles ) )
    {
        self.var_7899dd4d8ac31d1a.angles = ( 0, 0, 0 );
    }
    
    v_fx_loc = player geteye();
    var_9b0535a434f74a2c = player getplayerangles();
    player playrumbleonentity( "damage_heavy" );
    playfx( level._effect[ "aether_orb_spawn" ], v_fx_loc, anglestoforward( var_9b0535a434f74a2c ) );
    var_2b0c20cebe23ba0b = utility::spawn_model( "tag_origin", player.origin, player.angles );
    ae_scriptable = spawnscriptable( "aether_elevator_audio", ( 0, 0, 0 ), ( 0, 0, 0 ), var_2b0c20cebe23ba0b );
    playfxontag( level._effect[ "aether_orb" ], var_2b0c20cebe23ba0b, "tag_origin" );
    playfxontagforclients( level._effect[ "aether_orb_cam" ], player, "tag_eye", player );
    player playerhide();
    player playerlinkto( var_2b0c20cebe23ba0b, "tag_origin", 1, 0, 0, 0, 0 );
    var_c430e398f22f2648 = 64 * vectornormalize( self.var_7899dd4d8ac31d1a.origin - s_destination.origin )[ 2 ];
    n_dir = 1;
    
    if ( var_c430e398f22f2648 < 0 )
    {
        n_dir = -1;
    }
    
    var_59d2cbb102282176 = self.var_7899dd4d8ac31d1a.angles + ( var_c430e398f22f2648, 180, 0 );
    var_b2c9720e09f44e38 = self.var_7899dd4d8ac31d1a.origin + ( 0, 0, 32 * n_dir * -1 );
    var_2b0c20cebe23ba0b moveto( var_b2c9720e09f44e38, 0.4 );
    var_2b0c20cebe23ba0b rotateto( var_59d2cbb102282176, 0.4 );
    wait 0.4;
    v_destination = s_destination.origin + ( 0, 0, 24 * n_dir );
    move_height = abs( v_destination[ 2 ] - var_b2c9720e09f44e38[ 2 ] );
    n_move_time = move_height / 1400;
    n_rotate_time = n_move_time * 0.85;
    n_current_yaw = angleclamp( var_2b0c20cebe23ba0b.angles[ 1 ] );
    n_goal_yaw = angleclamp( s_destination.angles[ 1 ] );
    n_yaw_delta = 180 - abs( abs( n_goal_yaw - n_current_yaw ) - 180 );
    n_delta_mod = mod( var_59d2cbb102282176[ 1 ] - var_9b0535a434f74a2c[ 1 ] + 180, 360 ) - 180;
    
    if ( n_delta_mod <= 0 )
    {
        n_yaw_delta *= -1;
    }
    
    var_2b0c20cebe23ba0b moveto( v_destination, n_move_time );
    var_2b0c20cebe23ba0b rotateby( ( 0, n_yaw_delta, 0 ), n_rotate_time + 0.5 );
    var_919ccbfcfa4b4c4e = n_move_time - n_rotate_time + 0.125;
    s_landing = player function_2723774980bb17c4( s_destination );
    var_2b0c20cebe23ba0b utility::delaycall( n_rotate_time, &rotateto, s_landing.angles, var_919ccbfcfa4b4c4e, var_919ccbfcfa4b4c4e - 0.1 );
    wait n_move_time;
    var_2b0c20cebe23ba0b moveto( s_landing.origin, 0.5, 0.49, 0.01 );
    ae_scriptable setscriptablepartstate( "audio", "finish_lift" );
    wait 0.5;
    player playrumbleonentity( "damage_heavy" );
    killfxontag( level._effect[ "aether_orb" ], var_2b0c20cebe23ba0b, "tag_origin" );
    killfxontag( level._effect[ "aether_orb_cam" ], player, "tag_eye" );
    ae_scriptable setscriptablepartstate( "audio", "complete" );
    playfx( level._effect[ "aether_orb_despawn" ], var_2b0c20cebe23ba0b.origin, anglestoforward( var_2b0c20cebe23ba0b.angles ) );
    ae_scriptable freescriptable();
    var_2b0c20cebe23ba0b delete();
    player playershow();
    playfxontagforclients( level._effect[ "scrnfx_aether_elevator_use" ], player, "tag_origin", player );
    player thread function_ba4ce85983a03719( 0.5 );
    player set_player_vars( 0 );
    player function_12b11b69ea8587b8( 0 );
    player val::reset( "aether_elevator_tp", "allow_toggle_third_person" );
    player.var_d1c4c78b9fb7d153 = 0;
    player thread function_502febb2303a3d2f( 2 );
    player utility::ent_flag_clear( "fasttravel_start" );
}

// Namespace zm_fasttravel_core
// Params 1, eflags: 0x4
// Checksum 0x1170fed8, Offset: 0x381e
// Size: 0x30
function private function_502febb2303a3d2f( n_delay )
{
    self endon( #"death_or_disconnect" );
    self.var_c51fe993f3dc78d9 = 1;
    wait n_delay;
    self.var_c51fe993f3dc78d9 = undefined;
}

// Namespace zm_fasttravel_core
// Params 1, eflags: 0x4
// Checksum 0xce419778, Offset: 0x3856
// Size: 0x3c
function private function_ba4ce85983a03719( n_dur )
{
    self endon( #"death" );
    vision_utility::function_89d3efe42060754c( "zm_t10_garnet_vfx_cam_church", level.framedurationseconds );
    wait n_dur;
    vision_utility::function_6cb9d8e0202ee81( "zm_t10_garnet_vfx_cam_church" );
}

// Namespace zm_fasttravel_core
// Params 1
// Checksum 0x49fd699f, Offset: 0x389a
// Size: 0x53
function get_destination_struct( var_93e4a0a8514ca47e )
{
    self endon( #"death" );
    
    if ( isdefined( level.s_zm_fasttravel.var_747103a5509e874c[ var_93e4a0a8514ca47e ] ) )
    {
        return level.s_zm_fasttravel.var_747103a5509e874c[ var_93e4a0a8514ca47e ].script_struct;
    }
}

// Namespace zm_fasttravel_core
// Params 1
// Checksum 0xb9ece5c2, Offset: 0x38f6
// Size: 0x26f
function fasttravel_cooldown_timer( portal )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    /#
        if ( getdvarint( @"hash_16b2d2ed36077e93", 0 ) )
        {
            return;
        }
    #/
    
    if ( isdefined( portal.var_7899dd4d8ac31d1a.var_c0ffafd2c238ef34 ) )
    {
        var_590dfece3371b32a = { #current_cooldown_time:portal.var_7899dd4d8ac31d1a.var_c0ffafd2c238ef34, #player:self };
        
        if ( !isdefined( portal.var_b8b1708ca1ae7d42 ) )
        {
            portal.var_b8b1708ca1ae7d42 = [];
        }
        
        portal.var_b8b1708ca1ae7d42[ portal.var_b8b1708ca1ae7d42.size ] = var_590dfece3371b32a;
        
        if ( portal.var_7899dd4d8ac31d1a.var_95238e4bbec40d59 )
        {
            find = undefined;
            
            foreach ( info in portal.var_b8b1708ca1ae7d42 )
            {
                if ( info.player == self )
                {
                    find = info;
                    break;
                }
            }
            
            time_remaining = find.current_cooldown_time;
            interval_sec = 1;
            
            while ( time_remaining > 0 )
            {
                find.current_cooldown_time = int( time_remaining );
                wait interval_sec;
                time_remaining -= interval_sec;
            }
        }
        else
        {
            wait portal.var_7899dd4d8ac31d1a.var_c0ffafd2c238ef34;
        }
        
        if ( isdefined( self ) )
        {
            find = undefined;
            
            foreach ( info in portal.var_b8b1708ca1ae7d42 )
            {
                if ( info.player == self )
                {
                    find = info;
                    break;
                }
            }
            
            if ( find )
            {
                portal.var_b8b1708ca1ae7d42 = arrayremove( portal.var_b8b1708ca1ae7d42, find );
            }
        }
    }
}

// Namespace zm_fasttravel_core
// Params 6
// Checksum 0xb5cdc2e8, Offset: 0x3b6d
// Size: 0x2e6
function function_cbb08198e7c84adf( s_destination, player, var_c3c20b69d17492d4, var_7e095e6dcc29d2af, n_fade_to_black, var_adea237f67b03c1d )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    
    if ( !isdefined( s_destination ) )
    {
        return;
    }
    
    sub_locations = utility::getstructarray( s_destination.target, "targetname" );
    
    foreach ( pos in sub_locations )
    {
        if ( pos.script_noteworthy == "player_position" )
        {
            if ( !isdefined( s_destination.player_spawn_locations ) )
            {
                s_destination.player_spawn_locations = [];
            }
            
            s_destination.player_spawn_locations[ s_destination.player_spawn_locations.size ] = pos;
        }
    }
    
    assert( isarray( s_destination.player_spawn_locations ) && s_destination.player_spawn_locations.size >= 4, "<dev string:xe0>" );
    
    if ( player isonascender() )
    {
        player dropoffascender();
    }
    
    if ( player isemoteactive() )
    {
        player stopemote();
    }
    
    waitframe();
    params = spawnstruct();
    params.player = player;
    params.s_destination = s_destination;
    callback::callback( "on_player_warp", params );
    player notify( #"fasttravel_start" );
    player set_player_vars( 1 );
    player utility::flag_set( "is_in_fasttravel" );
    wait 0.2;
    player prestream_minimap( s_destination );
    var_6787895101874fb4 = 0;
    
    if ( s_destination.player_spawn_locations.size > 0 )
    {
        players = level.players;
        
        for ( i = 0; i < players.size ; i++ )
        {
            if ( isalive( players[ i ] ) )
            {
                spawnindex = i;
                
                if ( spawnindex >= s_destination.player_spawn_locations.size )
                {
                    spawnindex = s_destination.player_spawn_locations.size - 1;
                }
                
                players[ i ] setadditionalstreamposuntilcleared( s_destination.player_spawn_locations[ spawnindex ].origin, 1 );
            }
            
            if ( player == players[ i ] )
            {
                var_6787895101874fb4 = i;
            }
        }
    }
    
    if ( isalive( player ) )
    {
        player fasttravel_rail_go( undefined, undefined, undefined, "player_do_fasttravel", s_destination.player_spawn_locations[ var_6787895101874fb4 ], undefined, undefined, 1, 1, 1, undefined, 1, var_7e095e6dcc29d2af, n_fade_to_black, s_destination.targetname == "fasttravel_trigger", var_adea237f67b03c1d );
    }
}

// Namespace zm_fasttravel_core
// Params 16
// Checksum 0xe20d1b36, Offset: 0x3e5b
// Size: 0x31d
function fasttravel_rail_go( var_540dd627d48c6795, var_906cd768d627bb71, var_cb789841c580cc57, str_notify, var_1f01174057453f91, s_unitrigger_loc, var_caddf87ffbc2c3b4, var_98420eb1da9a06da, b_teleport_bots, b_wait_stance, var_25050c377765cf27, var_6261749628b3ece2, var_7e095e6dcc29d2af, n_fade_to_black, var_ef18bc26df951f8a = 0, var_adea237f67b03c1d )
{
    level endon( #"end_game" );
    self endon( #"disconnect" );
    
    if ( !isdefined( var_98420eb1da9a06da ) )
    {
        var_98420eb1da9a06da = 0;
    }
    
    if ( !isdefined( b_teleport_bots ) )
    {
        b_teleport_bots = 1;
    }
    
    if ( !isdefined( b_wait_stance ) )
    {
        b_wait_stance = 1;
    }
    
    if ( !isdefined( var_25050c377765cf27 ) )
    {
        var_25050c377765cf27 = 0;
    }
    
    if ( !isdefined( var_6261749628b3ece2 ) )
    {
        var_6261749628b3ece2 = 0;
    }
    
    if ( !isdefined( n_fade_to_black ) )
    {
        n_fade_to_black = 0.3;
    }
    
    self.var_d1c4c78b9fb7d153 = 1;
    stopfxontagforclients( level._effect[ "vfx_player_screen_distortion" ], self, "j_head", self );
    killfxontag( level._effect[ "vfx_player_screen_distortion" ], self, "j_head" );
    game_utility::fadetoblackforplayerkeepui( self, 1, n_fade_to_black );
    function_12b11b69ea8587b8( 1 );
    
    if ( isdefined( s_unitrigger_loc ) )
    {
        var_caddf87ffbc2c3b4 = s_unitrigger_loc.script_string;
        self.var_caddf87ffbc2c3b4 = var_caddf87ffbc2c3b4;
        var_7cfa6a30ee8ff7ba = s_unitrigger_loc.var_d2e6bd92229b88eb;
    }
    
    if ( !var_98420eb1da9a06da )
    {
        while ( level.var_ab803d030f39c652[ var_caddf87ffbc2c3b4 ] == 1 )
        {
            waitframe();
        }
        
        level thread function_ceedc64a79eab33a( var_caddf87ffbc2c3b4 );
    }
    
    thread fasttravel_teleport_vortex( var_1f01174057453f91, var_6261749628b3ece2, var_7e095e6dcc29d2af, b_wait_stance, n_fade_to_black );
    
    if ( var_adea237f67b03c1d )
    {
        utility::waittill_notify_and_time( "fasttravel_over", var_adea237f67b03c1d );
    }
    else
    {
        self waittill( #"fasttravel_over" );
    }
    
    a_ai = getaiarrayinradius( self.origin, 256 );
    
    foreach ( zombie in a_ai )
    {
        if ( zombie.aicategory == "normal" )
        {
            zombie zombie_knockdown::function_6fc167d4a3590991( self.origin );
        }
    }
    
    level thread game_utility::fadetoblackforplayerkeepui( self, 0, n_fade_to_black );
    function_12b11b69ea8587b8( 0 );
    set_player_vars( 0 );
    utility::flag_clear( "is_in_fasttravel" );
    utility::ent_flag_set( "fasttravel_done" );
    
    if ( isdefined( str_notify ) )
    {
        level notify( str_notify );
    }
    
    self.var_caddf87ffbc2c3b4 = undefined;
    self notify( #"fasttravel_finished", s_unitrigger_loc );
    params = spawnstruct();
    params.var_ef18bc26df951f8a = var_ef18bc26df951f8a;
    callback::callback( "fasttravel_finished", params );
    utility::ent_flag_clear( "fasttravel_done" );
    self clearadditionalstreampos();
    compass::player_set_minimap_stream_hints( "zm_fasttravel", 0 );
    callback::callback( "update_mtx_scriptable" );
}

// Namespace zm_fasttravel_core
// Params 1
// Checksum 0x1219ab74, Offset: 0x4180
// Size: 0xda
function set_player_vars( var_94d1ab5da995e573 )
{
    if ( var_94d1ab5da995e573 )
    {
        val::set( "fasttravel", "fire", 0 );
        val::set( "fasttravel", "offhand_weapons", 0 );
        val::set( "fasttravel", "allow_movement", 0 );
        val::set( "fasttravel", "ignoreme", 1 );
        val::set( "fasttravel", "freezecontrols", 1 );
        val::set( "fasttravel", "show_hud", 0 );
        val::set( "fasttravel", "killstreaks", 0 );
        val::set( "fasttravel", "ignore_playable_area_check", 1 );
        val::set( "fasttravel", "damage", 0 );
        
        if ( utility::ent_flag( "field_upgrade_in_use" ) )
        {
            supers_mp::superusefinished();
        }
        
        return;
    }
    
    val::reset_all( "fasttravel" );
}

// Namespace zm_fasttravel_core
// Params 2, eflags: 0x4
// Checksum 0xc129693d, Offset: 0x4262
// Size: 0x245
function private function_446161f9f459cdc( n_fade_to_black, var_7e095e6dcc29d2af )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self.zm_fasttravel_players_watching = player::get_players_watching( 1 );
    thread function_8256429a0a737647();
    
    foreach ( player in self.zm_fasttravel_players_watching )
    {
        if ( isdefined( player ) )
        {
            level thread game_utility::fadetoblackforplayerkeepui( player, 1, n_fade_to_black );
        }
    }
    
    if ( var_7e095e6dcc29d2af )
    {
        foreach ( player in self.zm_fasttravel_players_watching )
        {
            player thread start_vortex_fx_for_player( 1 );
        }
    }
    
    self waittill( #"fasttravel_over" );
    
    if ( var_7e095e6dcc29d2af )
    {
        foreach ( player in self.zm_fasttravel_players_watching )
        {
            player thread function_3583c74a3e6c1365( 1 );
        }
    }
    
    foreach ( player in self.zm_fasttravel_players_watching )
    {
        if ( isdefined( player ) )
        {
            level thread game_utility::fadetoblackforplayerkeepui( player, 0, n_fade_to_black );
        }
    }
    
    self.zm_fasttravel_players_watching = undefined;
}

// Namespace zm_fasttravel_core
// Params 0, eflags: 0x4
// Checksum 0x7a493993, Offset: 0x44af
// Size: 0x13c
function private function_8256429a0a737647()
{
    level endon( #"end_game" );
    self endon( #"disconnect" );
    self endon( #"fasttravel_over" );
    
    foreach ( player in level.players )
    {
        if ( player == self )
        {
            continue;
        }
        
        if ( arraycontains( self.zm_fasttravel_players_watching, player ) )
        {
            continue;
        }
        
        if ( !isdefined( other_players ) )
        {
            other_players = [];
        }
        
        other_players[ other_players.size ] = player;
    }
    
    foreach ( other_player in other_players )
    {
        childthread monitor_spectating_player( other_player );
    }
}

// Namespace zm_fasttravel_core
// Params 1, eflags: 0x4
// Checksum 0xdd6f094, Offset: 0x45f3
// Size: 0x78
function private monitor_spectating_player( other_player )
{
    while ( true )
    {
        other_player waittill( #"spectating_cycle" );
        waittillframeend();
        
        if ( !isdefined( other_player ) )
        {
            continue;
        }
        
        spectated_player = other_player getspectatingplayer();
        
        if ( spectated_player == self )
        {
            if ( isarray( self.zm_fasttravel_players_watching ) )
            {
                self.zm_fasttravel_players_watching[ self.zm_fasttravel_players_watching.size ] = other_player;
                other_player start_vortex_fx_for_player( 1 );
            }
        }
    }
}

// Namespace zm_fasttravel_core
// Params 1
// Checksum 0x93c4176c, Offset: 0x4673
// Size: 0x39
function function_ceedc64a79eab33a( var_caddf87ffbc2c3b4 )
{
    level endon( #"end_game" );
    level.var_ab803d030f39c652[ var_caddf87ffbc2c3b4 ] = 1;
    wait 0.1;
    level.var_ab803d030f39c652[ var_caddf87ffbc2c3b4 ] = undefined;
}

// Namespace zm_fasttravel_core
// Params 5
// Checksum 0xec590ad6, Offset: 0x46b4
// Size: 0x190
function fasttravel_teleport_vortex( var_1f01174057453f91, var_6261749628b3ece2, var_7e095e6dcc29d2af, b_wait_stance, n_fade_to_black = 0.3 )
{
    level endon( #"end_game" );
    self endon( #"disconnect" );
    
    if ( !isdefined( var_6261749628b3ece2 ) )
    {
        var_6261749628b3ece2 = 0;
    }
    
    if ( !isdefined( var_7e095e6dcc29d2af ) )
    {
        var_7e095e6dcc29d2af = 1;
    }
    
    thread function_446161f9f459cdc( n_fade_to_black, var_7e095e6dcc29d2af );
    a_start_origin = self.origin;
    var_ce3a9be1e12996df = utility::getstructarray( "teleport_room", "targetname" );
    var_6081543fe6b042eb = function_c10a103f92f5a219( self );
    var_fceab85dd87c805f = var_ce3a9be1e12996df[ var_6081543fe6b042eb ];
    vortex_teleport_player( a_start_origin, var_fceab85dd87c805f );
    
    if ( !player::isinlaststand( self ) && isalive( self ) )
    {
        self setstance( "stand", 1 );
        
        if ( b_wait_stance && getdvarint( @"hash_f6d3570dc7b0b026", 0 ) )
        {
            wait 1;
        }
    }
    
    if ( var_7e095e6dcc29d2af )
    {
        function_60628df0e15b562b( undefined );
    }
    else
    {
        wait 0.5;
    }
    
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( isdefined( self.e_teleport_origin ) )
    {
        self unlink();
        self.e_teleport_origin delete();
        self.e_teleport_origin = undefined;
    }
    
    if ( isdefined( var_1f01174057453f91 ) )
    {
        if ( isarray( var_1f01174057453f91 ) )
        {
            s_dest_loc = function_8447a68108cb9cba( var_1f01174057453f91 );
        }
        else
        {
            s_dest_loc = var_1f01174057453f91;
        }
        
        teleport_player_to_dest( s_dest_loc );
    }
    
    waitframe();
    self notify( #"fasttravel_over", "vortex" );
}

// Namespace zm_fasttravel_core
// Params 1
// Checksum 0x74d01bd3, Offset: 0x484c
// Size: 0x5a
function function_60628df0e15b562b( s_vortex )
{
    self endon( #"disconnect" );
    self playrumblelooponentity( "damage_heavy" );
    vortex_fx_proxy = start_vortex_fx_for_player( 0 );
    wait 5;
    function_3583c74a3e6c1365( 0, vortex_fx_proxy );
    self stoprumble( "damage_heavy" );
    val::reset_all( "fasttravel" );
}

// Namespace zm_fasttravel_core
// Params 1, eflags: 0x4
// Checksum 0xab1d7af0, Offset: 0x48ae
// Size: 0x18d
function private start_vortex_fx_for_player( var_d9ad04bcc91200cb )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( getdvarint( @"hash_f6d3570dc7b0b026", 0 ) )
    {
        if ( var_d9ad04bcc91200cb )
        {
            self function_912074a2fa665101();
            game_utility::fadetoblackforplayerkeepui( self, 0, 0.1 );
        }
        else
        {
            forward_angles = anglestoforward( self getplayerangles() );
            vortex_fx_proxy = utility::spawn_model( "tag_origin", self geteye(), vectortoangles( forward_angles ) );
            vortex_fx_proxy thread function_a7a1fb0bc94096b9( self );
            waitframe();
            playfxontagforclients( level._effect[ "wormhole_vfx" ], vortex_fx_proxy, "tag_origin", self );
            self playsoundevent( %"sndevent_teleportation_player_2d" );
            game_utility::fadetoblackforplayerkeepui( self, 0, 0.1 );
            return vortex_fx_proxy;
        }
        
        return;
    }
    
    self setclientomnvar( "ui_zm_bink_overlay_state", 1 );
    
    if ( !isdefined( level.s_zm_fasttravel.var_c791990671337c74 ) )
    {
        level.s_zm_fasttravel.var_c791990671337c74 = "Blue";
    }
    
    switch ( level.s_zm_fasttravel.var_c791990671337c74 )
    {
        case #"hash_aaa3b5f44a61520d":
            var_376f12f2f7c5b5e5 = "zm_t10_teleport_vortex";
            break;
        case #"hash_85f42f6cd65b851c":
            var_376f12f2f7c5b5e5 = "zm_t10_teleport_vortex_red";
            break;
    }
    
    if ( isdefined( level.s_zm_fasttravel.var_47f8d98ac9667b45 ) )
    {
        var_376f12f2f7c5b5e5 = level.s_zm_fasttravel.var_47f8d98ac9667b45;
    }
    
    self function_73788e9f76af4fad( var_376f12f2f7c5b5e5 );
    self playsoundevent( %"sndevent_teleportation_player_2d" );
}

// Namespace zm_fasttravel_core
// Params 2, eflags: 0x4
// Checksum 0xfebccb33, Offset: 0x4a43
// Size: 0x96
function private function_3583c74a3e6c1365( var_d9ad04bcc91200cb, vortex_fx_proxy )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( getdvarint( @"hash_f6d3570dc7b0b026", 0 ) )
    {
        if ( var_d9ad04bcc91200cb )
        {
            game_utility::fadetoblackforplayerkeepui( self, 1, 0.1 );
            self function_48ee055540a7f69d();
        }
        else
        {
            game_utility::fadetoblackforplayerkeepui( self, 1, 0.1 );
            
            if ( isdefined( vortex_fx_proxy ) )
            {
                killfxontag( level._effect[ "wormhole_vfx" ], vortex_fx_proxy, "tag_origin" );
                vortex_fx_proxy delete();
            }
        }
        
        return;
    }
    
    self stopcinematicforplayer();
    self setclientomnvar( "ui_zm_bink_overlay_state", 0 );
}

// Namespace zm_fasttravel_core
// Params 1
// Checksum 0xab5fe046, Offset: 0x4ae1
// Size: 0x3c
function function_a7a1fb0bc94096b9( player )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        self.origin = player geteye();
        waitframe();
    }
}

// Namespace zm_fasttravel_core
// Params 2
// Checksum 0xa57216f3, Offset: 0x4b25
// Size: 0xc5
function vortex_teleport_player( a_start_origin, var_fceab85dd87c805f )
{
    if ( !namespace_af5a2e4a7277c1d::function_f37cfdf04b932a03( self, 0, 1 ) )
    {
        return;
    }
    
    if ( isdefined( self ) )
    {
        val::set( "vortex_teleport_player_ignores", "ignore_afk", 1 );
        self dontinterpolate();
        self setorigin( var_fceab85dd87c805f.origin );
        
        if ( !isdefined( var_fceab85dd87c805f.angles ) )
        {
            var_fceab85dd87c805f.angles = ( 0, 0, 0 );
        }
        
        self setplayerangles( var_fceab85dd87c805f.angles );
        childthread vortex_link_player( var_fceab85dd87c805f );
        self notify( #"afk_tracking_resume" );
        utility::delaythreadendon( level.framedurationseconds, "disconnect", &val::reset_all, "vortex_teleport_player_ignores" );
        wait 0.1;
    }
}

// Namespace zm_fasttravel_core
// Params 1
// Checksum 0xec6d0cb4, Offset: 0x4bf2
// Size: 0x71
function vortex_link_player( var_fceab85dd87c805f )
{
    waitframe();
    self.e_teleport_origin = spawn( "script_origin", var_fceab85dd87c805f.origin );
    self.e_teleport_origin.angles = var_fceab85dd87c805f.angles;
    self.e_teleport_origin.targetname = "vortex_link_player";
    self playerlinktoabsolute( self.e_teleport_origin );
}

// Namespace zm_fasttravel_core
// Params 2
// Checksum 0x180e8b54, Offset: 0x4c6b
// Size: 0x248
function fasttravel_slide_path( player, s_destination )
{
    player endon( #"death" );
    player.var_2b0c20cebe23ba0b = utility::spawn_model( "tag_origin", player.origin + ( 0, 0, -16 ), player.angles );
    player playerlinkto( player.var_2b0c20cebe23ba0b, undefined, 0, 45, 45, 45, 15 );
    player.s_dest = player function_2723774980bb17c4( s_destination );
    player set_player_fasttravel( 1 );
    player prestream_minimap( s_destination );
    s_start = utility::getstruct( "slide_start", "targetname" );
    player.var_2b0c20cebe23ba0b moveto( s_start.origin, 0.5 );
    player.var_2b0c20cebe23ba0b waittill( #"movedone" );
    var_7b97f011bb3a6659 = utility::getstruct( s_start.target, "targetname" );
    
    while ( true )
    {
        if ( var_7b97f011bb3a6659.script_noteworthy == "slow" )
        {
            n_speed = 300;
        }
        else
        {
            n_speed = 400;
        }
        
        var_b6081b1b6ba5e8b5 = distance( player.var_2b0c20cebe23ba0b.origin, var_7b97f011bb3a6659.origin );
        n_time = var_b6081b1b6ba5e8b5 / n_speed;
        player.var_2b0c20cebe23ba0b moveto( var_7b97f011bb3a6659.origin, n_time );
        player.var_2b0c20cebe23ba0b rotateto( var_7b97f011bb3a6659.angles, n_time );
        
        if ( n_time > 0.1 )
        {
            wait n_time - 0.05;
        }
        else
        {
            wait n_time;
        }
        
        if ( var_7b97f011bb3a6659.script_noteworthy == "stand" )
        {
            player val::reset_all( "fasttravel" );
            player setstance( "stand" );
        }
        
        if ( isdefined( var_7b97f011bb3a6659.target ) )
        {
            var_7b97f011bb3a6659 = utility::getstruct( var_7b97f011bb3a6659.target, "targetname" );
            continue;
        }
        
        break;
    }
    
    level notify( #"fasttravel_reached" );
    player set_player_fasttravel( 0 );
}

// Namespace zm_fasttravel_core
// Params 1
// Checksum 0xbdb8d049, Offset: 0x4ebb
// Size: 0x1be
function set_player_fasttravel( var_b0e144194be51c26 )
{
    self endon( #"death" );
    
    if ( var_b0e144194be51c26 )
    {
        function_93375cbf6cc2384e( self, 1 );
        utility::ent_flag_set( "player_on_rail" );
        function_12b11b69ea8587b8( 1 );
        val::set( "zm_fasttravel_tp", "allow_toggle_third_person", 0 );
        pbgpostfxbundlestart( self, "cer_zm_speed_blur" );
        self setscriptablepartstate( "fasttravel", "camera_on" );
        return;
    }
    
    self playrumbleonentity( "damage_heavy" );
    var_b6081b1b6ba5e8b5 = distance( self.var_2b0c20cebe23ba0b.origin, self.s_dest.origin );
    n_time = var_b6081b1b6ba5e8b5 / 500;
    self.var_2b0c20cebe23ba0b moveto( self.s_dest.origin, n_time );
    self.var_2b0c20cebe23ba0b rotateto( self.s_dest.angles, n_time );
    self.var_2b0c20cebe23ba0b waittill( #"movedone" );
    self.var_2b0c20cebe23ba0b delete();
    utility::ent_flag_clear( "player_on_rail" );
    wait 0.1;
    self setstance( "stand", 1 );
    self playrumbleonentity( "damage_heavy" );
    self earthquakeforplayer( 0.4, 1, self.origin, 64 );
    function_93375cbf6cc2384e( self, 0 );
    pbgpostfxbundleend( self, "cer_zm_speed_blur" );
    self setscriptablepartstate( "fasttravel", "camera_out" );
    wait 0.5;
    self setscriptablepartstate( "fasttravel", "camera_off" );
    function_12b11b69ea8587b8( 0 );
    val::reset( "zm_fasttravel_tp", "allow_toggle_third_person" );
}

// Namespace zm_fasttravel_core
// Params 1
// Checksum 0xd2152138, Offset: 0x5081
// Size: 0xaf
function function_12b11b69ea8587b8( toggle )
{
    if ( toggle )
    {
        if ( isdvardefined( @"killswitch_third_person_transitions" ) )
        {
            self.var_cd3d60349b92ea3a = getdvarint( @"killswitch_third_person_transitions" );
            setdvar( @"killswitch_third_person_transitions", 0 );
        }
        
        if ( self getcamerathirdperson() )
        {
            self.is_third_person = 1;
            self setcamerathirdperson( 0 );
        }
        
        return;
    }
    
    if ( isdefined( self.var_cd3d60349b92ea3a ) )
    {
        setdvar( @"killswitch_third_person_transitions", self.var_cd3d60349b92ea3a );
        self.var_cd3d60349b92ea3a = undefined;
    }
    
    if ( self.is_third_person )
    {
        self.is_third_person = undefined;
        self setcamerathirdperson( 1 );
    }
}

// Namespace zm_fasttravel_core
// Params 2
// Checksum 0xe0bfd0a2, Offset: 0x5138
// Size: 0xec
function function_93375cbf6cc2384e( var_fd0ebdff544e4e7c, var_94d1ab5da995e573 )
{
    if ( var_94d1ab5da995e573 )
    {
        val::set( "fasttravel", "crouch", 0 );
        val::set( "fasttravel", "stand", 0 );
        self setstance( "prone" );
        val::set( "fasttravel", "damage", 0 );
        val::set( "fasttravel", "killstreaks", 0 );
        val::set( "fasttravel", "allow_movement", 0 );
        val::set( "fasttravel", "offhand_weapons", 0 );
        val::set( "fasttravel", "show_hud", 0 );
        val::set( "fasttravel", "ignoreme", 1 );
        
        if ( player::isinlaststand( self ) || self.ismutantinjection )
        {
            val::set( "fasttravel", "fire", 0 );
        }
        
        return;
    }
    
    self.var_d1c4c78b9fb7d153 = 0;
}

// Namespace zm_fasttravel_core
// Params 1
// Checksum 0xd6948239, Offset: 0x522c
// Size: 0x5e
function function_2723774980bb17c4( s_destination )
{
    var_ad8b274417815b62 = utility::getstructarray( s_destination.target, "targetname" );
    self.n_index = self getentitynumber();
    
    if ( isdefined( var_ad8b274417815b62[ self.n_index ] ) )
    {
        return var_ad8b274417815b62[ self.n_index ];
    }
    
    return var_ad8b274417815b62[ 0 ];
}

// Namespace zm_fasttravel_core
// Params 0
// Checksum 0xc4bf65b5, Offset: 0x5292
// Size: 0x86
function function_c560ad0dc6d30911()
{
    self endon( #"death" );
    v_forward = vectornormalize( anglestoforward( self.s_dest.angles ) ) * 40;
    self pushplayervector( v_forward );
    self earthquakeforplayer( 0.2, 0.5, self.origin, 64 );
    self playrumbleonentity( "damage_heavy" );
    wait 1;
    self pushplayervector( ( 0, 0, 0 ) );
    self.s_dest = undefined;
}

// Namespace zm_fasttravel_core
// Params 1
// Checksum 0x5b6f9417, Offset: 0x5320
// Size: 0xd8
function function_8447a68108cb9cba( a_s_dest_locs )
{
    n_index = function_c10a103f92f5a219( self );
    var_95276aa22b5cd0a4 = level.players;
    
    if ( function_9cb40b4b8e64abde( a_s_dest_locs[ n_index ], var_95276aa22b5cd0a4 ) )
    {
        return a_s_dest_locs[ n_index ];
    }
    
    foreach ( s_dest_loc in a_s_dest_locs )
    {
        if ( s_dest_loc == a_s_dest_locs[ n_index ] )
        {
            continue;
        }
        
        if ( function_9cb40b4b8e64abde( s_dest_loc, var_95276aa22b5cd0a4 ) )
        {
            return s_dest_loc;
        }
    }
    
    /#
        iprintln( "<dev string:x10f>" );
    #/
    
    return a_s_dest_locs[ n_index ];
}

// Namespace zm_fasttravel_core
// Params 1
// Checksum 0x82effd18, Offset: 0x5401
// Size: 0x43
function function_c10a103f92f5a219( e_player )
{
    for ( i = 0; i < level.players.size ; i++ )
    {
        if ( e_player == level.players[ i ] )
        {
            return i;
        }
    }
}

// Namespace zm_fasttravel_core
// Params 2
// Checksum 0x36a4b015, Offset: 0x544c
// Size: 0x116
function function_9cb40b4b8e64abde( s_dest_loc, var_95276aa22b5cd0a4 )
{
    n_safe_distance_squared = 1024;
    var_e7200ea279acc768 = 1;
    assert( isdefined( s_dest_loc ), "<dev string:x140>" );
    
    foreach ( e_player in var_95276aa22b5cd0a4 )
    {
        if ( e_player.var_d1c4c78b9fb7d153 )
        {
            continue;
        }
        
        if ( abs( s_dest_loc.origin[ 2 ] - e_player.origin[ 2 ] ) > 60 )
        {
            continue;
        }
        
        if ( distance2dsquared( s_dest_loc.origin, e_player.origin ) > n_safe_distance_squared )
        {
            continue;
        }
        
        var_e7200ea279acc768 = 0;
        break;
    }
    
    return var_e7200ea279acc768;
}

// Namespace zm_fasttravel_core
// Params 2
// Checksum 0xf85c41f0, Offset: 0x556b
// Size: 0x11a
function teleport_player_to_dest( s_dest_loc, b_set_angles = 1 )
{
    if ( !( self.spectating || self isspectatinganyone() || self.team == "spectator" || self.sessionstate == "spectator" ) )
    {
        val::set( "teleport_player_to_dest_ignores", "ignore_afk", 1 );
        self dontinterpolate();
        self setorigin( s_dest_loc.origin );
        self setvelocity( ( 0, 0, 0 ) );
        self notify( #"afk_tracking_resume" );
        utility::delaythreadendon( level.framedurationseconds, "disconnect", &val::reset_all, "teleport_player_to_dest_ignores" );
    }
    
    /#
        if ( b_set_angles && !isdefined( s_dest_loc.angles ) )
        {
        }
    #/
    
    if ( b_set_angles && isdefined( s_dest_loc.angles ) )
    {
        self setplayerangles( s_dest_loc.angles );
    }
    
    self playsoundevent( %"sndevent_teleportation_end_3d" );
    self.var_d1c4c78b9fb7d153 = 0;
}

// Namespace zm_fasttravel_core
// Params 0
// Checksum 0xe94af378, Offset: 0x568d
// Size: 0x4af
function function_8649f9a98d2d9ce3()
{
    level endon( #"game_ended" );
    
    foreach ( player in level.players )
    {
        if ( player.bgivensentry )
        {
            player val::group_reset( "sentry" );
            player val::set( "sentry", "interactions", 1 );
            player notify( #"equip_deploy_cancel" );
        }
    }
    
    foreach ( player in level.players )
    {
        current_weapon = player getcurrentweapon();
        
        if ( isdefined( current_weapon.basename ) && issubstr( current_weapon.basename, "laser_large_ir" ) )
        {
            player takeweapon( current_weapon );
            oldweaponobj = player inventory::getlastweapon();
            
            if ( oldweaponobj == level.var_f8ac15ada97a702a )
            {
                oldweaponobj = player inventory::getfirstprimaryweapon();
            }
            
            success = player inventory_utility::domonitoredweaponswitch( oldweaponobj, 1 );
        }
    }
    
    while ( true )
    {
        var_e05ba689016d78fb = 0;
        
        foreach ( player in level.players )
        {
            if ( player.isdeploying )
            {
                var_e05ba689016d78fb = 1;
                break;
            }
        }
        
        if ( var_e05ba689016d78fb )
        {
            wait 0.5;
            continue;
        }
        
        break;
    }
    
    while ( true )
    {
        var_7710a12fe7d5e0f1 = 0;
        
        foreach ( player in level.players )
        {
            if ( player.var_8ff71ee2591d99a9 )
            {
                var_7710a12fe7d5e0f1 = 1;
                break;
            }
        }
        
        if ( var_7710a12fe7d5e0f1 )
        {
            wait 0.5;
            continue;
        }
        
        break;
    }
    
    if ( isarray( level.rcxds ) )
    {
        foreach ( rcxd in level.rcxds )
        {
            rcxd thread rcxd_shared::rcxd_explode();
        }
    }
    
    level notify( #"hellstorm_missile_early_quit" );
    
    if ( isdefined( level.chopper_gunner ) )
    {
        level.chopper_gunner notify( #"hash_fb44cd088f1f78d7" );
        level.chopper_gunner waittill( #"hash_7c47126b3ee960da" );
    }
    
    foreach ( player in level.players )
    {
        if ( player killstreak_utility::is_using_killstreak( 1 ) )
        {
            player notify( #"cutscene_cleanup" );
            continue;
        }
        
        if ( player vehicle::is_in_vehicle() )
        {
            vehicle = player vehicle::get_vehicle();
            vehicle_occupancy::exit( vehicle, vehicle_occupancy::get_occupant_seat( vehicle, player ), player );
        }
        
        if ( !isalive( player ) || player.sessionstate == "spectator" )
        {
            player.var_14955bc056bab547 = 1;
            player thread playerlogic::spawnclient();
        }
        
        if ( player::isinlaststand( player ) )
        {
            player thread laststand::function_75e6bc3d39e1f2bb( player, "last_stand_revived" );
        }
    }
    
    wait 1;
}

// Namespace zm_fasttravel_core
// Params 1
// Checksum 0x616290d9, Offset: 0x5b44
// Size: 0x6c
function prestream_minimap( s_destination )
{
    if ( !isdefined( s_destination.var_601871979f3bd42 ) )
    {
        minimap_floor = compass::get_minimap_floor_at_location( s_destination.origin, 1 );
        
        if ( isdefined( minimap_floor ) )
        {
            s_destination.var_601871979f3bd42 = compass::function_63f039f18edc23e1( minimap_floor );
        }
    }
    
    compass::player_set_minimap_stream_hints( "zm_fasttravel", s_destination.var_601871979f3bd42 );
}

// Namespace zm_fasttravel_core
// Params 4
// Checksum 0xf3293c01, Offset: 0x5bb8
// Size: 0x154
function function_298f7e021b71004( str_scriptnoteworthy, var_94d1ab5da995e573 = 0, var_81a7a23cdba06275 = 0, b_disable_hint = 0 )
{
    if ( !isdefined( level.s_zm_fasttravel.var_747103a5509e874c[ str_scriptnoteworthy ] ) )
    {
        return;
    }
    
    var_7899dd4d8ac31d1a = level.s_zm_fasttravel.var_747103a5509e874c[ str_scriptnoteworthy ].script_struct;
    
    if ( !isdefined( var_7899dd4d8ac31d1a ) )
    {
        return;
    }
    
    if ( isdefined( level.s_zm_fasttravel.var_747103a5509e874c[ str_scriptnoteworthy ].var_59e9b2b8ad6d622 ) )
    {
        var_7899dd4d8ac31d1a.var_2efb9165f56da06d = !var_94d1ab5da995e573;
        var_7899dd4d8ac31d1a.b_disable_hint = b_disable_hint;
    }
    
    if ( !isdefined( var_7899dd4d8ac31d1a.fasttravel_scr ) )
    {
        return;
    }
    
    if ( var_94d1ab5da995e573 )
    {
        if ( var_81a7a23cdba06275 )
        {
            var_7899dd4d8ac31d1a.fasttravel_scr setscriptablepartstate( "base", "shut_down" );
        }
        
        return;
    }
    
    if ( isdefined( var_7899dd4d8ac31d1a.var_ece53a0a154aa1c0 ) )
    {
        var_7899dd4d8ac31d1a.fasttravel_scr setscriptablepartstate( "base", var_7899dd4d8ac31d1a.var_ece53a0a154aa1c0 );
        return;
    }
    
    var_7899dd4d8ac31d1a.fasttravel_scr setscriptablepartstate( "base", "idle" );
}

/#

    // Namespace zm_fasttravel_core
    // Params 0
    // Checksum 0x1144d293, Offset: 0x5d14
    // Size: 0x141, Type: dev
    function init_fasttravel_debug()
    {
        devgui::function_9082edeb5db93280( "<dev string:x172>" );
        devgui::add_devgui_func( "<dev string:x181>", "<dev string:x195>", &function_b41a6c21c3e120d1 );
        devgui::add_devgui_func( "<dev string:x1a9>", "<dev string:x1a9>", &debug_teleport_fx );
        devgui::add_devgui_func( "<dev string:x1bb>", "<dev string:x1e0>", &function_8649f9a98d2d9ce3 );
        a_s_fasttravel_triggers = utility::getstructarray( "<dev string:x205>", "<dev string:x213>" );
        
        if ( a_s_fasttravel_triggers.size != 0 )
        {
            foreach ( var_7899dd4d8ac31d1a in a_s_fasttravel_triggers )
            {
                devgui::function_cd4e263c1f3018ae( "<dev string:x21e>" + var_7899dd4d8ac31d1a.script_noteworthy, "<dev string:x233>" + var_7899dd4d8ac31d1a.script_noteworthy, &function_37b57d78dc992385 );
                devgui::function_cd4e263c1f3018ae( "<dev string:x267>" + var_7899dd4d8ac31d1a.script_noteworthy, "<dev string:x27b>" + var_7899dd4d8ac31d1a.script_noteworthy, &function_fabf8ad46ecc7d79 );
            }
        }
        
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_fasttravel_core
    // Params 1
    // Checksum 0xe2fd083d, Offset: 0x5e5d
    // Size: 0x2d, Type: dev
    function function_37b57d78dc992385( params )
    {
        str_scriptnoteworthy = params[ 0 ];
        function_298f7e021b71004( str_scriptnoteworthy, 1, 1, 1 );
    }

    // Namespace zm_fasttravel_core
    // Params 1
    // Checksum 0x2db7a248, Offset: 0x5e92
    // Size: 0x27, Type: dev
    function function_fabf8ad46ecc7d79( params )
    {
        str_scriptnoteworthy = params[ 0 ];
        function_298f7e021b71004( str_scriptnoteworthy );
    }

    // Namespace zm_fasttravel_core
    // Params 0
    // Checksum 0xfddbac5b, Offset: 0x5ec1
    // Size: 0x48, Type: dev
    function function_b41a6c21c3e120d1()
    {
        game_utility::fadetoblackforplayerkeepui( level.players[ 0 ], 1, 0.3 );
        level.players[ 0 ] function_60628df0e15b562b();
        game_utility::fadetoblackforplayerkeepui( level.players[ 0 ], 0, 0.3 );
    }

    // Namespace zm_fasttravel_core
    // Params 0
    // Checksum 0x4f436339, Offset: 0x5f11
    // Size: 0xc0, Type: dev
    function debug_teleport_fx()
    {
        var_b78fc84ceb590f1d = utility::getstruct( "<dev string:x2ae>", "<dev string:x213>" );
        forward_angles = anglestoforward( level.players[ 0 ] getplayerangles() );
        vortex_fx_proxy = utility::spawn_model( "<dev string:x2b7>", level.players[ 0 ] geteye(), vectortoangles( forward_angles ) );
        waitframe();
        level.players[ 0 ] cameralinkto( vortex_fx_proxy, "<dev string:x2b7>" );
        playfxontagforclients( level._effect[ "<dev string:x2c2>" ], vortex_fx_proxy, "<dev string:x2b7>", level.players[ 0 ] );
        wait 5;
        level.players[ 0 ] cameraunlink();
        vortex_fx_proxy delete();
    }

#/
