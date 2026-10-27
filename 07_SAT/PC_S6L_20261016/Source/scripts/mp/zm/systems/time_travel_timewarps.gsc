// scripts\mp\zm\systems\time_travel_timewarps.gsc  (hash_1c64a2d2dbfae714.gscc) (size: 8723 Bytes / 0x2213 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa165e95c (2707810652)
// size ...... 8723 (0x2213)
// includes .. 8   (offset: 0x203f)
// strings ... 26  (offset: 0x207f)
// dev strs .. 0   (offset: 0x2213)
// exports ... 21  (offset: 0x15ff)
// cseg ...... 0x21f + 0x13e0 (0x15ff)
// imports ... 58  (offset: 0x1947)
// animtree1 . 0   (offset: 0x2213)
// animtree2 . 0   (offset: 0x2213)
#using scripts\common\callbacks;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\currency;
#using scripts\mp\interaction;
#using scripts\mp\zm\systems\time_travel;
#using scripts\mp\zm\systems\zm_save;

#namespace namespace_24edb5d87524aa7f;

// Namespace namespace_24edb5d87524aa7f
// Params 0, eflags: 0x5
// Checksum 0x25c75a07, Offset: 0x23d
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"sat_timewarps", #"sat_timetravel", undefined, &init );
}

// Namespace namespace_24edb5d87524aa7f
// Params 0
// Checksum 0xcdedc70d, Offset: 0x266
// Size: 0x38f
function init()
{
    map_info_bundle = getactivemapinfobundle();
    timetravel_data = map_info_bundle.timetravel;
    
    if ( !map_info_bundle.timetravelenabled || !timetravel_data.timewarpsenabled || level.timetravel_disabled || level.var_9317e385dbcadec8 )
    {
        return;
    }
    
    level.timewarps = { #data:{ #active_cooldown:0, #cooldown:getdvarfloat( @"hash_2cd8051593e6964a", timetravel_data.timewarpcooldown ), #half_paid:0, #cost:getdvarint( @"hash_a76bba0bd306ca6", timetravel_data.timewarpcost ), #hint_icon:timetravel_data.var_efff42918a04a20d, #scriptable:timetravel_data.timewarpscriptable }, #instances:[], #nodes:[] };
    init_event_notify = getdvar( @"hash_cae386dc274b4c2e", timetravel_data.var_69993ef3301b08ec );
    var_3f5c266cffd2d448 = getdvar( @"hash_68e74fe9832218dd", timetravel_data.var_f73f9e76f1978e65 );
    var_1aae5b52322f3c9d = getdvar( @"hash_aa5de2f19d89c8a2", timetravel_data.var_287ae50f83f5952c );
    timewarp_nodes = utility::getstructarray( "timewarp", "targetname" );
    
    foreach ( node in timewarp_nodes )
    {
        if ( !isdefined( level.timewarps.nodes[ node.script_noteworthy ] ) )
        {
            level.timewarps.nodes[ node.script_noteworthy ] = [];
        }
        
        level.timewarps.nodes[ node.script_noteworthy ][ level.timewarps.nodes[ node.script_noteworthy ].size ] = node;
    }
    
    spawn_timewarps();
    utility::registersharedfunc( #"sat_timetravel", #"hash_c7aedc0f4fc1d71e", &function_1648acfd459e6d51 );
    utility::registersharedfunc( #"sat_timetravel", #"hash_a33e784c7bb751b3", &function_d8e84003f6104768 );
    scriptable::scriptable_addusedcallbackbypart( "base", &use );
    scriptable::scriptable_addnotifycallback( "timewarp_warping", &notify_warp );
    
    if ( isdefined( init_event_notify ) )
    {
        if ( zm_save::function_fcccc3d2a616b1c7() )
        {
            zm_save::function_1f44a48caae2acbf();
            
            if ( !utility::callsharedfunc( #"zombie", #"get_timewarps_initialized" ) )
            {
                level waittill( init_event_notify );
            }
        }
        else
        {
            level waittill( init_event_notify );
        }
    }
    
    level.timewarps.initialized = 1;
    activate();
    level callback::add( #"player_connect", &on_player_connect );
    level callback::add( "timetravel_enabled", &activate );
    level callback::add( "timetravel_disabled", &deactivate );
    level callback::add( var_3f5c266cffd2d448, &activate );
    level callback::add( var_1aae5b52322f3c9d, &deactivate );
}

// Namespace namespace_24edb5d87524aa7f
// Params 1, eflags: 0x4
// Checksum 0x3c27e6bf, Offset: 0x5fd
// Size: 0x1c
function private on_player_connect( params )
{
    if ( isbot( self ) )
    {
        return;
    }
    
    thread function_6af096b565033640();
}

// Namespace namespace_24edb5d87524aa7f
// Params 1
// Checksum 0x62fc5903, Offset: 0x621
// Size: 0x119
function activate( params )
{
    if ( !level.timetravel.enabled || level.timewarps.active && level.timewarps.data.active_cooldown > 0 )
    {
        return;
    }
    
    foreach ( timewarp in level.timewarps.instances )
    {
        timewarp.is_active = 1;
        timewarp setscriptablepartstate( "effects", "active" );
    }
    
    level.timewarps.active = 1;
    level notify( #"timewarp_active" );
}

// Namespace namespace_24edb5d87524aa7f
// Params 1
// Checksum 0x2aedd439, Offset: 0x742
// Size: 0xe4
function deactivate( params )
{
    foreach ( timewarp in level.timewarps.instances )
    {
        timewarp.is_active = 0;
        timewarp setscriptablepartstate( "effects", "inactive" );
    }
    
    level.timewarps.active = 0;
    level.timewarps.data.active_cooldown = 0;
    level notify( #"timewarp_inactive" );
}

// Namespace namespace_24edb5d87524aa7f
// Params 0
// Checksum 0x95422622, Offset: 0x82e
// Size: 0xe4
function function_d8e84003f6104768()
{
    foreach ( timewarp in level.timewarps.instances )
    {
        timewarp setscriptablepartstate( "base", "usable" );
        timewarp setscriptablepartstate( "icon", "active" );
        timewarp setscriptablepartstate( "effects", timewarp.is_active ? "active" : "inactive" );
        
        if ( isdefined( timewarp.clip ) )
        {
            timewarp.clip show();
        }
    }
}

// Namespace namespace_24edb5d87524aa7f
// Params 0
// Checksum 0xfd348af9, Offset: 0x91a
// Size: 0xd5
function function_1648acfd459e6d51()
{
    deactivate();
    
    foreach ( timewarp in level.timewarps.instances )
    {
        timewarp setscriptablepartstate( "base", "hide" );
        timewarp setscriptablepartstate( "effects", "hide" );
        timewarp setscriptablepartstate( "icon", "hide" );
        
        if ( isdefined( timewarp.clip ) )
        {
            timewarp.clip hide();
        }
    }
}

// Namespace namespace_24edb5d87524aa7f
// Params 1
// Checksum 0xec64b97f, Offset: 0x9f7
// Size: 0x94
function function_a2c1c84be2b355cb( style )
{
    foreach ( timewarp in level.timewarps.instances )
    {
        timewarp setscriptablepartstate( "style", style );
    }
}

// Namespace namespace_24edb5d87524aa7f
// Params 0, eflags: 0x4
// Checksum 0x4f34d353, Offset: 0xa93
// Size: 0xc8
function private cooldown()
{
    level endon( #"game_ended", #"timewarp_active", #"timewarp_inactive" );
    level.timewarps.data.active_cooldown = level.timewarps.data.cooldown;
    
    while ( level.timewarps.data.active_cooldown > 0 )
    {
        wait 1;
        level.timewarps.data.active_cooldown -= 1;
    }
    
    activate();
}

// Namespace namespace_24edb5d87524aa7f
// Params 0, eflags: 0x4
// Checksum 0xc86cc06d, Offset: 0xb63
// Size: 0x16f
function private spawn_timewarps()
{
    foreach ( node_group in level.timewarps.nodes )
    {
        selected_node = node_group[ randomint( node_group.size ) ];
        timewarp = spawnscriptable( level.timewarps.data.scriptable, selected_node.origin, selected_node.angles );
        timewarp interaction::set_interact_hint_callback( &interact_hint );
        timewarp.clip = getentarrayinradius( "ttm_clip", #script_noteworthy, timewarp.origin, 50 )[ 0 ];
        timewarp.parent_node = selected_node;
        
        if ( !isdefined( level.timewarps.instances ) )
        {
            level.timewarps.instances = [];
        }
        
        level.timewarps.instances[ level.timewarps.instances.size ] = timewarp;
    }
}

// Namespace namespace_24edb5d87524aa7f
// Params 6, eflags: 0x4
// Checksum 0xdd5f0e79, Offset: 0xcda
// Size: 0xe7
function private use( scriptable, part, state, player, bautouse, usestring )
{
    if ( scriptable.type != "sat_zm_timetravel_timewarp" || !scriptable.is_active || utility::flag( "timetravel_ongoing" ) || !player currency::attempt_purchase( #"essence", get_cost(), 1, 0, #"timewarp", scriptable ) )
    {
        return;
    }
    
    thread warp( scriptable, player );
    thread cooldown();
    level.timewarps.data.half_paid = 0;
    
    if ( !isdefined( level.var_cea2fe0ea477724a ) )
    {
        level.var_cea2fe0ea477724a = 0;
    }
    
    level.var_cea2fe0ea477724a++;
}

// Namespace namespace_24edb5d87524aa7f
// Params 2, eflags: 0x4
// Checksum 0x35a83364, Offset: 0xdc9
// Size: 0xe4
function private warp( scriptable, player )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    foreach ( timewarp in level.timewarps.instances )
    {
        timewarp.is_active = 0;
        timewarp setscriptablepartstate( "effects", "warping" );
    }
    
    time_travel::timetravel( undefined, { #activator:player, #time_travel_interact:scriptable } );
}

// Namespace namespace_24edb5d87524aa7f
// Params 0, eflags: 0x4
// Checksum 0xe5bd23b8, Offset: 0xeb5
// Size: 0x66
function private get_cost()
{
    return level.timewarps.data.half_paid ? int( level.timewarps.data.cost / 2 ) : level.timewarps.data.cost;
}

// Namespace namespace_24edb5d87524aa7f
// Params 0, eflags: 0x4
// Checksum 0x909eb109, Offset: 0xf24
// Size: 0xf3
function private function_6af096b565033640()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        self setclientomnvar( "ui_zm_doorbuy_can_afford_only_half_buy", 0 );
        self setclientomnvar( "ui_zm_doorbuy_is_doorbuy", 0 );
        var_26aa5c63dc34e455 = undefined;
        
        while ( !isdefined( var_26aa5c63dc34e455 ) )
        {
            foreach ( timewarp in level.timewarps.instances )
            {
                if ( function_ab1341636c83ce07( timewarp ) )
                {
                    var_26aa5c63dc34e455 = timewarp;
                    break;
                }
            }
            
            wait 0.1;
        }
        
        childthread function_377605d494cb2473( var_26aa5c63dc34e455 );
        function_6d7e5d93a5fb2c9c( var_26aa5c63dc34e455 );
    }
}

// Namespace namespace_24edb5d87524aa7f
// Params 1, eflags: 0x4
// Checksum 0xbf2fb173, Offset: 0x101f
// Size: 0xab, Type: bool
function private function_ab1341636c83ce07( timewarp )
{
    can_afford = currency::can_afford( #"essence", int( level.timewarps.data.cost / 2 ) );
    
    if ( !isdefined( timewarp ) || !timewarp.is_active || level.timewarps.data.half_paid || !can_afford )
    {
        return false;
    }
    
    return distancesquared( self.origin, timewarp.origin ) <= squared( 83 );
}

// Namespace namespace_24edb5d87524aa7f
// Params 1, eflags: 0x4
// Checksum 0xb6a07320, Offset: 0x10d3
// Size: 0x142
function private function_377605d494cb2473( timewarp )
{
    self endon( #"hash_1e28488d3a7b3d9e" );
    self allowreload( 0 );
    self notifyonplayercommand( "try_partial_timewarp_kbm", "+reload" );
    self notifyonplayercommand( "try_partial_timewarp_pad", "-usereload" );
    
    while ( true )
    {
        event = utility::waittill_any_in_array_return( [ "try_partial_timewarp_kbm", "try_partial_timewarp_pad" ] );
        is_valid_input = event == "try_partial_timewarp_kbm" && !self usinggamepad() || event == "try_partial_timewarp_pad" && self usinggamepad();
        
        if ( is_valid_input && timewarp.is_active && !level.timewarps.data.half_paid && level.var_a93ba697bc9fda85 )
        {
            if ( currency::attempt_purchase( #"essence", int( level.timewarps.data.cost / 2 ), 1, 0, #"timewarp" ) )
            {
                level.timewarps.data.half_paid = 1;
            }
        }
    }
}

// Namespace namespace_24edb5d87524aa7f
// Params 1, eflags: 0x4
// Checksum 0xa151d652, Offset: 0x121d
// Size: 0x69
function private function_6d7e5d93a5fb2c9c( timewarp )
{
    self.var_ab1341636c83ce07 = 1;
    
    while ( function_ab1341636c83ce07( timewarp ) )
    {
        wait 0.1;
    }
    
    self.var_ab1341636c83ce07 = 0;
    self notify( #"hash_1e28488d3a7b3d9e" );
    self allowreload( 1 );
    self notifyonplayercommandremove( "try_partial_timewarp_kbm", "+reload" );
    self notifyonplayercommandremove( "try_partial_timewarp_pad", "-usereload" );
}

// Namespace namespace_24edb5d87524aa7f
// Params 2, eflags: 0x4
// Checksum 0x422e53c5, Offset: 0x128e
// Size: 0x2f5
function private interact_hint( timewarp, player )
{
    if ( utility::flag( "timetravel_ongoing" ) )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    cost = get_cost();
    hint_data = { #interactable:timewarp.is_active ? 1 : 0, #icon_text_value:timewarp.is_active ? cost > 0 ? cost : undefined : int( level.timewarps.data.active_cooldown ), #var_776a268784e089af:timewarp.is_active ? cost > 0 ? &"SHARED_HINTSTRINGS/COST_ESSENCE" : undefined : level.timewarps.data.active_cooldown > 0 ? &"zm_sat_timetravel/timewarp_cooldown_time" : &"zm_sat_timetravel/timewarp_cooldown", #var_492f94db590aab17:0, #altbuttoncallout:cost > 0 ? &"SHARED_HINTSTRINGS/HINT_BUY_HALF" : undefined, #buttoncallout:cost > 0 ? &"SHARED_HINTSTRINGS/HINT_BUY" : &"SHARED_HINTSTRINGS/USE", #icon:"sat_ui_icon_zm_time_travel", #description:&"zm_sat_timetravel/timewarp_desc", #title:&"zm_sat_timetravel/timewarp_name", #type:"HINT_BUTTON" };
    
    if ( isdefined( player ) && isdefined( timewarp ) )
    {
        can_afford = 0;
        var_7bb9dd71c375c081 = 0;
        
        if ( timewarp.is_active )
        {
            can_afford = player currency::can_afford( #"essence", cost );
            var_7bb9dd71c375c081 = level.var_a93ba697bc9fda85 && cost > 1 && !level.timewarps.data.half_paid && player currency::can_afford( #"essence", cost / 2 );
            
            if ( var_7bb9dd71c375c081 && cost > 1 )
            {
                hint_data.altbuttoncallout = &"SHARED_HINTSTRINGS/HINT_BUY_HALF";
                hint_data.var_492f94db590aab17 = 1;
            }
            
            if ( !var_7bb9dd71c375c081 && !can_afford )
            {
                hint_data.var_776a268784e089af = &"SHARED_HINTSTRINGS/COST_ESSENCE_NOT_ENOUGH";
                hint_data.aux_text = &"SHARED_HINTSTRINGS/NOT_ENOUGH_ESSENCE";
                hint_data.interactable = 0;
            }
        }
        
        if ( player.var_ab1341636c83ce07 )
        {
            player setclientomnvar( "ui_zm_doorbuy_is_doorbuy", var_7bb9dd71c375c081 );
            player setclientomnvar( "ui_zm_doorbuy_can_afford_only_half_buy", var_7bb9dd71c375c081 && !can_afford );
        }
    }
    
    return hint_data;
}

// Namespace namespace_24edb5d87524aa7f
// Params 6, eflags: 0x4
// Checksum 0xc0731c06, Offset: 0x158c
// Size: 0x45
function private notify_warp( e_instance, str_part, str_state, e_player, b_auto_use, str_use_string )
{
    level notify( #"timewarp_warping" );
}

// Namespace namespace_24edb5d87524aa7f
// Params 1
// Checksum 0x98b91be3, Offset: 0x15d9
// Size: 0x25
function get_closest_timewarp( origin )
{
    return function_47c86977a18df38b( level.timewarps.instances, origin );
}

