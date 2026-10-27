// scripts\mp\perk_machines.gsc  (hash_4b576523c81e6ee3.gscc) (size: 28957 Bytes / 0x711d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x96bc878a (2528937866)
// size ...... 28957 (0x711d)
// includes .. 11  (offset: 0x6aa1)
// strings ... 72  (offset: 0x6af9)
// dev strs .. 10  (offset: 0x7091)
// exports ... 60  (offset: 0x48e5)
// cseg ...... 0x59a + 0x434b (0x48e5)
// imports ... 192 (offset: 0x5245)
// animtree1 . 0   (offset: 0x711d)
// animtree2 . 0   (offset: 0x711d)
#using script_42657fd846518574;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\common\utility\lui_game_event_aggregator;
#using scripts\mp\content_manager;
#using scripts\mp\currency;
#using scripts\mp\interaction;
#using scripts\mp\purchasemenu;

#namespace perk_machines;

// Namespace perk_machines
// Params 0, eflags: 0x5
// Checksum 0x70c1dc1b, Offset: 0x5b8
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_93f3e00e12ac2c44", undefined, &__init__, undefined );
}

// Namespace perk_machines
// Params 0
// Checksum 0x190dee02, Offset: 0x5d9
// Size: 0x3c
function __init__()
{
    level thread init_perk_machines();
    level._effect[ "spawn_hide" ] = loadfxasset( "vfx_t10_gameplay_zm_wunderfizz_spawn" );
    level._effect[ "spawn_hide_trail" ] = loadfxasset( "vfx_t10_gameplay_zm_wunderfizz_spawn_trail" );
}

// Namespace perk_machines
// Params 0
// Checksum 0xc4982e4b, Offset: 0x61d
// Size: 0x22c
function init_perk_machines()
{
    level endon( #"game_ended" );
    level.a_s_perk_machines = [];
    level.perk_machine_registry = [];
    
    /#
        if ( isofflinetoolrun( 31 ) )
        {
            return;
        }
    #/
    
    level utility::flag_wait_all( "StartGameTypeCallbackFinished", "zombie_perks_init_complete", "content_manager_initialized" );
    content_manager::function_3209da123476142f( "perk_machine", &on_spawn_perk_machine );
    content_manager::function_3209da123476142f( "perk_machine_choice", &on_spawn_perk_machine_choice );
    content_manager::function_3209da123476142f( "perk_machine_random", &on_spawn_perk_machine_random );
    function_de4fee835703d390();
    level.perk_machine_menu = ZMPerkChoiceMenu::register();
    level.perk_machine_func = [];
    
    if ( level.gametypebundle.var_5fca731c160ce025 )
    {
        level.perk_machine_func[ "on_use" ] = &function_ba8b5ac52040eeb6;
        level.perk_machine_func[ "think" ] = &function_c75df733a8141c97;
        level.perk_machine_func[ "per_player_hint" ] = &function_8c4b28ece5745836;
        level.perk_machine_func[ "on_use_choice" ] = &function_1ec7efcd9bdee1b8;
        level.perk_machine_func[ "think_choice" ] = &function_29138c19b4ba9199;
        level.perk_machine_func[ "per_player_hint_choice" ] = &function_fe6d0c77f6ce6ac1;
    }
    else
    {
        level.perk_machine_func[ "on_use" ] = &on_use_perk_machine;
        level.perk_machine_func[ "think" ] = &function_8eaa7adaaea867ff;
        level.perk_machine_func[ "per_player_hint" ] = &function_ffa5a121a0d1e3ae;
        level.perk_machine_func[ "on_use_choice" ] = &function_1ec7efcd9bdee1b8;
        level.perk_machine_func[ "think_choice" ] = &function_29138c19b4ba9199;
        level.perk_machine_func[ "per_player_hint_choice" ] = &function_fe6d0c77f6ce6ac1;
    }
    
    callback::add( #"player_death", &on_player_killed );
    content_manager::register_disable_toggle( "perk_machine", &content_manager::function_5d04e50a29a2142c, &function_d3eec0146d52a887, &function_a1dc6d11cde4448c );
    content_manager::register_disable_toggle( "perk_machine_choice", &content_manager::function_5d04e50a29a2142c, &function_348be3ca276a0691, &function_a847ef469f32c5da );
    
    if ( !level.gamemodebundle.var_c214fc63695cd685 )
    {
        level thread init_perk_machine_postmain();
        return;
    }
    
    callback::add( "ob_content_process_create_script", &init_perk_machine_postmain );
}

// Namespace perk_machines
// Params 0
// Checksum 0xdde7f886, Offset: 0x851
// Size: 0x11
function get_wunderfizz_menu()
{
    return purchasemenu::get_purchasemenu( #"wunderfizz" );
}

// Namespace perk_machines
// Params 0
// Checksum 0x1d0743c6, Offset: 0x86b
// Size: 0xfa
function function_de4fee835703d390()
{
    level._custom_perks[ "specialty_choice" ] = spawnstruct();
    level._custom_perks[ "specialty_choice" ].cost = currency::get_perk_machine_cost( "specialty_choice" ) ?? 300;
    level._custom_perks[ "specialty_choice" ].str_currency = currency::get_perk_machine_currency( "specialty_choice" ) ?? #"essence";
    level._custom_perks[ "specialty_choice" ].icon = "ui_icon_zm_ping_wunderfizz";
    level._custom_perks[ "specialty_choice" ].hint_string = &"shared_hintstrings/perk_machine_wunderfizz_use";
    level._custom_perks[ "specialty_choice" ].hint_name = &"SHARED_HINTSTRINGS/PERK_MACHINE_WUNDERFIZZ_NAME";
    level._custom_perks[ "specialty_choice" ].buy_description = &"SHARED_HINTSTRINGS/PERK_MACHINE_WUNDERFIZZ_DESC";
}

// Namespace perk_machines
// Params 1
// Checksum 0xbf5be053, Offset: 0x96d
// Size: 0xbe
function init_perk_machine_postmain( params )
{
    level endon( #"game_ended" );
    waittillframeend();
    lui_game_event_aggregator::registeronluieventcallback( &perk_choice_purchase );
    var_62638af37653ded7 = utility::getstructarray( "content_destination", "variantname" );
    
    foreach ( destination in var_62638af37653ded7 )
    {
        level thread function_80a4d6696ba91733( destination );
    }
    
    utility::flag_set( "perk_machines_ready" );
}

// Namespace perk_machines
// Params 0
// Checksum 0x1f57c058, Offset: 0xa33
// Size: 0x57, Type: bool
function is_perk_machine_power_on()
{
    model = self;
    
    if ( isstruct( self ) && self.mdl_perk_machine )
    {
        model = self.mdl_perk_machine;
    }
    
    return model utility::function_9f2c41c1dcc8c94( "base", "power_activate" ) || model utility::function_9f2c41c1dcc8c94( "base", "power_on" );
}

// Namespace perk_machines
// Params 2
// Checksum 0xc03dd26f, Offset: 0xa93
// Size: 0x26e
function function_80a4d6696ba91733( destination, str_currency )
{
    foreach ( location in destination.locations )
    {
        perk_machine_instance = location.instances[ "perk_machine" ];
        
        if ( isdefined( perk_machine_instance ) )
        {
            foreach ( instance in perk_machine_instance.versions )
            {
                content_manager::function_67e4b7678fb21e11( instance );
            }
        }
        
        perk_machine_random_instance = location.instances[ "perk_machine_random" ];
        
        if ( isdefined( perk_machine_random_instance ) )
        {
            foreach ( instance in perk_machine_random_instance.versions )
            {
                content_manager::function_67e4b7678fb21e11( instance );
            }
        }
        
        if ( !( level.gametypebundle.disablewunderfizz ?? 0 ) )
        {
            perk_machine_choice_instance = location.instances[ "perk_machine_choice" ];
            
            if ( isdefined( perk_machine_choice_instance ) )
            {
                foreach ( instance in perk_machine_choice_instance.versions )
                {
                    instance.script_currency = str_currency;
                    content_manager::function_67e4b7678fb21e11( instance );
                }
            }
        }
    }
}

// Namespace perk_machines
// Params 1
// Checksum 0xbb243344, Offset: 0xd09
// Size: 0x31
function function_1dd836bc3f4db1e6( perk_name )
{
    if ( !isdefined( level.var_c3cbab2bb12b1b8 ) )
    {
        level.var_c3cbab2bb12b1b8 = [];
    }
    
    level.var_c3cbab2bb12b1b8[ perk_name ] = 1;
}

// Namespace perk_machines
// Params 0
// Checksum 0x680e7659, Offset: 0xd42
// Size: 0xb9
function function_f967ad2b3108404()
{
    foreach ( var_f3fa6f2a4457f81d in level.a_s_perk_machines )
    {
        if ( level.var_c3cbab2bb12b1b8[ var_f3fa6f2a4457f81d.script_noteworthy ] )
        {
            if ( var_f3fa6f2a4457f81d.mdl_perk_machine.iswebbed )
            {
                var_f3fa6f2a4457f81d.mdl_perk_machine.iswebbed = 0;
            }
        }
    }
}

// Namespace perk_machines
// Params 0
// Checksum 0x46fa533a, Offset: 0xe03
// Size: 0xe8
function function_7a835cab177fc315()
{
    foreach ( var_f3fa6f2a4457f81d in level.a_s_perk_machines )
    {
        if ( level.var_c3cbab2bb12b1b8[ var_f3fa6f2a4457f81d.script_noteworthy ] )
        {
            if ( isent( var_f3fa6f2a4457f81d.mdl_perk_machine ) )
            {
                var_f3fa6f2a4457f81d.mdl_perk_machine.interact delete();
                var_f3fa6f2a4457f81d.mdl_perk_machine delete();
                continue;
            }
            
            if ( isdefined( var_f3fa6f2a4457f81d.mdl_perk_machine ) )
            {
                var_f3fa6f2a4457f81d.mdl_perk_machine freescriptable();
            }
        }
    }
}

// Namespace perk_machines
// Params 1
// Checksum 0xd1feaa8a, Offset: 0xef3
// Size: 0x546
function function_9a3e81eb8357ad32( instance )
{
    if ( !arraycontains( level.a_s_perk_machines, self ) )
    {
        level.a_s_perk_machines[ level.a_s_perk_machines.size ] = self;
    }
    
    function_d9402931471ce4d6( self.script_noteworthy );
    
    if ( utility::issharedfuncdefined( #"perk_machine", #"hash_dce0d2ce4dd5c816" ) )
    {
        var_66071b7285da1614 = utility::callsharedfunc( #"perk_machine", #"hash_dce0d2ce4dd5c816", instance );
        
        if ( var_66071b7285da1614 )
        {
            return;
        }
    }
    
    perk = self.script_noteworthy ?? "talent_juggernog";
    
    /#
        if ( !isdefined( self.script_noteworthy ) )
        {
            println( "<dev string:x24>" + self.origin + "<dev string:x68>" );
        }
    #/
    
    if ( !utility::flag_exist( perk + "init_complete" ) )
    {
        println( "<dev string:x7c>" + perk + "<dev string:x95>" + self.origin + "<dev string:xb5>" );
        return;
    }
    
    level utility::flag_wait( perk + "init_complete" );
    assert( isdefined( level._custom_perks[ perk ] ), "<dev string:xce>" + perk + "<dev string:xd4>" );
    self.str_scriptable = level._custom_perks[ perk ].str_scriptable ?? "t10_zm_machine_juggernog";
    var_c20ad9047b941cf4 = level._custom_perks[ perk ].str_override_model ?? self.str_scriptable;
    mapinfo = getactivemapinfobundle();
    var_d2e325ed1ceba400 = mapinfo.var_4a98227bf6f428ba;
    
    if ( isarray( var_d2e325ed1ceba400 ) )
    {
        foreach ( var_232bf4cbe3e7f0ce in var_d2e325ed1ceba400 )
        {
            if ( var_232bf4cbe3e7f0ce.var_5d4a55e1eb574935 == var_c20ad9047b941cf4 )
            {
                self.str_scriptable = var_232bf4cbe3e7f0ce.override;
                var_c20ad9047b941cf4 = var_232bf4cbe3e7f0ce.override;
            }
        }
    }
    
    if ( var_c20ad9047b941cf4 != self.str_scriptable )
    {
        self.mdl_perk_machine = content_manager::spawn_script_model( self, var_c20ad9047b941cf4, 1, 1 );
    }
    else
    {
        self.mdl_perk_machine = spawnscriptable( var_c20ad9047b941cf4, self.origin, self.angles );
    }
    
    utility::callsharedfunc( #"scriptable", #"hash_10d5e3bb8a551724", self.mdl_perk_machine, "icon" );
    
    if ( !isdefined( self.script_currency ) )
    {
        self.script_currency = currency::get_perk_machine_currency( perk );
    }
    
    self.radius = level._custom_perks[ perk ].machine_radius ?? 64;
    
    if ( !isdefined( self.script_cost ) )
    {
        self.script_cost = level._custom_perks[ perk ].cost;
    }
    
    if ( isent( self.mdl_perk_machine ) )
    {
        self.mdl_perk_machine.interact = interaction::register_interact( self.mdl_perk_machine, self.radius, level.perk_machine_func[ "on_use" ], undefined, undefined, undefined, undefined, "HINT_BUTTON" );
        self.mdl_perk_machine.interact setusefov( 130 );
        self.mdl_perk_machine.interact interaction::set_interact_hint_callback( level.perk_machine_func[ "per_player_hint" ] );
        
        if ( self.mdl_perk_machine tagexists( "tag_hint" ) )
        {
            self.mdl_perk_machine sethinttag( "tag_hint" );
        }
    }
    else
    {
        self.mdl_perk_machine.interact = interaction::register_scriptable_interact( self.mdl_perk_machine, level.perk_machine_func[ "on_use" ] );
        self.mdl_perk_machine.interact interaction::set_interact_hint_callback( level.perk_machine_func[ "per_player_hint" ] );
    }
    
    self.mdl_perk_machine perk_machine_power_off( self.mdl_perk_machine.interact );
    
    if ( self.mdl_perk_machine isscriptableinstance() && self.mdl_perk_machine getscriptablehaspart( "use" ) )
    {
        self.mdl_perk_machine setscriptablepartstate( "use", "default" );
    }
    
    self.mdl_perk_machine.interact.s_perk_machine = self;
    self.mdl_perk_machine thread [[ level.perk_machine_func[ "think" ] ]]( perk, self.mdl_perk_machine.interact );
    self.mdl_perk_machine thread function_91eb8bd11a034ed2( perk );
    
    if ( utility::issharedfuncdefined( #"perk_machine", #"hash_5e022045e830ce8b" ) )
    {
        utility::callsharedfunc( #"perk_machine", #"hash_5e022045e830ce8b", instance );
    }
}

// Namespace perk_machines
// Params 1, eflags: 0x4
// Checksum 0xbd6f3f59, Offset: 0x1441
// Size: 0x2f
function private function_d9402931471ce4d6( perk_machine_id )
{
    if ( !is_perk_machine_registered( perk_machine_id ) )
    {
        level.perk_machine_registry[ level.perk_machine_registry.size ] = perk_machine_id;
    }
}

// Namespace perk_machines
// Params 1, eflags: 0x4
// Checksum 0xcd709f90, Offset: 0x1478
// Size: 0x1b
function private is_perk_machine_registered( perk_machine_id )
{
    return arraycontains( level.perk_machine_registry, perk_machine_id );
}

// Namespace perk_machines
// Params 1, eflags: 0x4
// Checksum 0x81acb11, Offset: 0x149c
// Size: 0xb1
function private on_spawn_perk_machine( instance )
{
    level endon( #"game_ended" );
    spawn_points = instance.var_1d6cddfc47031bff[ "perk_machine_spawn" ];
    
    foreach ( point in spawn_points )
    {
        if ( point content_manager::function_e0f0562adcd2c071() )
        {
            point thread function_9a3e81eb8357ad32( instance );
        }
    }
}

// Namespace perk_machines
// Params 1, eflags: 0x4
// Checksum 0xe2111565, Offset: 0x1555
// Size: 0xae
function private on_spawn_perk_machine_choice( instance )
{
    spawn_points = instance.var_1d6cddfc47031bff[ "perk_machine_choice_spawn" ];
    
    if ( isarray( spawn_points ) )
    {
        foreach ( point in spawn_points )
        {
            if ( point content_manager::function_e0f0562adcd2c071() )
            {
                point thread function_e3d3bfcc06c89350( instance );
            }
        }
    }
}

// Namespace perk_machines
// Params 1, eflags: 0x4
// Checksum 0x8c2850e1, Offset: 0x160b
// Size: 0x266
function private on_spawn_perk_machine_random( instance )
{
    spawn_point_groups = instance.var_1d6cddfc47031bff[ "perk_machine_random_group" ];
    variant_id = getdvar( @"hash_662dda9fa4eae3ed", "variant_default" );
    
    if ( isarray( spawn_point_groups ) )
    {
        var_1d889a48d1b26017 = utility::callsharedfunc( #"zombie", #"get_persistent_random_seed" ) ?? randomint( 10 );
        spawn_point_groups = utility::function_40662075b6c8798c( spawn_point_groups, var_1d889a48d1b26017 );
        
        foreach ( spawn_point_group in spawn_point_groups )
        {
            if ( spawn_point_group.script_noteworthy != variant_id )
            {
                continue;
            }
            
            spawn_points = spawn_point_group.var_1d6cddfc47031bff[ "perk_machine_spawn" ];
            spawn_points = utility::function_40662075b6c8798c( spawn_points, var_1d889a48d1b26017 );
            selected_spawn_point = undefined;
            
            foreach ( spawn_point in spawn_points )
            {
                if ( !is_perk_machine_registered( spawn_point.script_noteworthy ) )
                {
                    selected_spawn_point = spawn_point;
                    break;
                }
            }
            
            if ( isdefined( selected_spawn_point ) )
            {
                perk = selected_spawn_point.script_noteworthy;
                instance_id = selected_spawn_point.target;
                world_event = perk + "_" + instance_id;
                level callback::add( perk + "_power_on", &function_bcaaaf3833f2909f, { #event:world_event } );
                level callback::add( perk + "_power_off", &function_743c2971f61a5ef6, { #event:world_event } );
                selected_spawn_point thread function_9a3e81eb8357ad32( instance );
                continue;
            }
            
            println( "<dev string:xe8>" + spawn_point_group.targetname + "<dev string:x11e>" );
        }
    }
}

// Namespace perk_machines
// Params 2, eflags: 0x4
// Checksum 0xbb522f88, Offset: 0x1879
// Size: 0x25
function private function_bcaaaf3833f2909f( params, additional_params )
{
    activateworldevent( additional_params.event );
}

// Namespace perk_machines
// Params 2, eflags: 0x4
// Checksum 0xde057b7b, Offset: 0x18a6
// Size: 0x25
function private function_743c2971f61a5ef6( params, additional_params )
{
    deactivateworldevent( additional_params.event );
}

// Namespace perk_machines
// Params 1, eflags: 0x4
// Checksum 0x1c888dc1, Offset: 0x18d3
// Size: 0x30
function private on_player_killed( deathdata )
{
    if ( level.perk_machine_menu ZMPerkChoiceMenu::is_open( self ) )
    {
        level.perk_machine_menu ZMPerkChoiceMenu::close( self );
    }
}

// Namespace perk_machines
// Params 3, eflags: 0x4
// Checksum 0x36465000, Offset: 0x190b
// Size: 0x2d1
function private function_2fd536fafa95f30d( usable, player, var_96fca1d2fdab32bc )
{
    perk = usable.script_notify;
    str_key = usable.script_notify ?? "talent_juggernog";
    
    if ( utility::issharedfuncdefined( #"perk_machine", #"hash_dfdcc3fdc88af90c" ) )
    {
        var_4c22addfe5b4f20e = utility::callsharedfunc( #"perk_machine", #"hash_dfdcc3fdc88af90c", usable );
    }
    
    if ( !isdefined( var_4c22addfe5b4f20e ) )
    {
        var_4c22addfe5b4f20e = player zombie_perks::function_77331fd62580dd0a();
    }
    
    perk_root = level._custom_perks[ str_key ];
    
    if ( var_96fca1d2fdab32bc )
    {
        var_4c22addfe5b4f20e = 0;
    }
    
    if ( var_4c22addfe5b4f20e == 0 )
    {
        hint_data = { #buttoncallout:&"SHARED_HINTSTRINGS/PERK_MACHINE_BUY", #icon:perk_root.icon, #description:perk_root.buy_description, #title:perk_root.hint_name, #type:"HINT_BUTTON" };
    }
    else
    {
        hint_data = { #icon_text_value:var_4c22addfe5b4f20e, #var_776a268784e089af:&"SHARED_HINTSTRINGS/COST_ESSENCE", #buttoncallout:&"SHARED_HINTSTRINGS/PERK_MACHINE_BUY", #icon:perk_root.icon, #description:perk_root.buy_description, #title:perk_root.hint_name, #type:"HINT_BUTTON" };
    }
    
    if ( player zombie_perks::has_perk( level._custom_perks[ perk ].str_perk_root ) )
    {
        hint_data.aux_text = &"SHARED_HINTSTRINGS/EQUIPPED";
        hint_data.var_776a268784e089af = "";
        hint_data.interactable = 0;
    }
    else if ( !player currency::can_afford( currency::get_perk_machine_currency( perk ), var_4c22addfe5b4f20e ) )
    {
        hint_data.aux_text = &"SHARED_HINTSTRINGS/NOT_ENOUGH_ESSENCE";
        hint_data.var_776a268784e089af = &"SHARED_HINTSTRINGS/COST_ESSENCE_NOT_ENOUGH";
        hint_data.interactable = 0;
    }
    
    if ( utility::issharedfuncdefined( #"perk_machine", #"hash_e863dfdfdb696446" ) && var_96fca1d2fdab32bc )
    {
        hint_data = player utility::callsharedfunc( #"perk_machine", #"hash_e863dfdfdb696446", usable, perk_root, var_4c22addfe5b4f20e, hint_data );
    }
    
    if ( utility::issharedfuncdefined( #"perk_machine", #"hash_41ac71b59679409c" ) )
    {
        hint_data = player utility::callsharedfunc( #"perk_machine", #"hash_41ac71b59679409c", usable, perk_root, var_4c22addfe5b4f20e, hint_data );
    }
    
    return hint_data;
}

// Namespace perk_machines
// Params 2, eflags: 0x4
// Checksum 0xa5cf5f2f, Offset: 0x1be5
// Size: 0x285
function private function_ffa5a121a0d1e3ae( usable, player )
{
    if ( isdefined( player ) && isdefined( usable ) )
    {
        perk = usable.script_notify;
        
        if ( usable isscriptableinstance() && usable getscriptablepartstate( "base" ) == "power_off" )
        {
            var_cce73ae069e33fd1 = function_2fd536fafa95f30d( usable, player );
            var_cce73ae069e33fd1.aux_text = &"SHARED_HINTSTRINGS/NEED_POWER_RED";
            var_cce73ae069e33fd1.var_776a268784e089af = &"SHARED_HINTSTRINGS/COST_ESSENCE";
            var_cce73ae069e33fd1.interactable = 0;
            return var_cce73ae069e33fd1;
        }
        else if ( level.var_c139731c583cae6b || !player val::get( "allow_zm_perks" ) )
        {
            return { #string:&"", #type:"HINT_NOBUTTON" };
        }
        else
        {
            if ( utility::issharedfuncdefined( #"perk_machine", #"hash_f568dbf855a46cf1" ) )
            {
                s_perk_machine = usable.s_perk_machine;
                [ is_locked, hint_string, not_enough_string ] = utility::callsharedfunc( #"perk_machine", #"hash_f568dbf855a46cf1", s_perk_machine );
                
                if ( is_locked )
                {
                    locked_cost = s_perk_machine.locked_cost;
                    var_cce73ae069e33fd1 = function_2fd536fafa95f30d( usable, player );
                    var_cce73ae069e33fd1.buttoncallout = hint_string;
                    var_cce73ae069e33fd1.icon_text_value = locked_cost;
                    
                    if ( !player currency::can_afford( s_perk_machine.script_currency ?? #"essence", locked_cost ) )
                    {
                        var_cce73ae069e33fd1.aux_text = not_enough_string;
                        var_cce73ae069e33fd1.interactable = 0;
                    }
                    
                    return var_cce73ae069e33fd1;
                }
            }
            
            if ( player.interactions_disabled )
            {
                return { #string:&"", #type:"HINT_NOBUTTON" };
            }
            else if ( player function_a0b979ff30c7a327() || player zombie_perks::function_cda78d45986a51a0() )
            {
                return { #string:&"", #type:"HINT_NOBUTTON" };
            }
            else
            {
                return function_2fd536fafa95f30d( usable, player );
            }
        }
    }
    
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace perk_machines
// Params 1
// Checksum 0x6a3a391b, Offset: 0x1e73
// Size: 0x3f6
function on_use_perk_machine( player )
{
    perk = self.script_notify;
    assert( isdefined( level._custom_perks[ perk ] ), "<dev string:xce>" + perk + "<dev string:xd4>" );
    
    if ( utility::issharedfuncdefined( #"perk_machine", #"hash_ced2467441048b3e" ) )
    {
        s_perk_machine = self.s_perk_machine;
        
        if ( s_perk_machine.is_locked )
        {
            player utility::callsharedfunc( #"perk_machine", #"hash_ced2467441048b3e", s_perk_machine );
            return;
        }
    }
    
    if ( utility::issharedfuncdefined( #"perk_machine", #"hash_dfdcc3fdc88af90c" ) )
    {
        var_4c22addfe5b4f20e = utility::callsharedfunc( #"perk_machine", #"hash_dfdcc3fdc88af90c", self );
    }
    
    if ( !isdefined( var_4c22addfe5b4f20e ) )
    {
        var_4c22addfe5b4f20e = player zombie_perks::function_77331fd62580dd0a();
    }
    
    s_perk_machine = self.s_perk_machine;
    mdl_perk_machine = s_perk_machine.mdl_perk_machine;
    
    if ( isdefined( player ) && isdefined( s_perk_machine.script_currency ) )
    {
        if ( mdl_perk_machine getscriptablepartstate( "base" ) == "power_off" )
        {
            return;
        }
        
        if ( player zombie_perks::has_perk( level._custom_perks[ perk ].str_perk_root ) && !level.var_3ae3959c37a85611 )
        {
            return;
        }
        
        if ( level.var_c139731c583cae6b || !player val::get( "allow_zm_perks" ) )
        {
            return;
        }
        
        if ( player.interactions_disabled || self.insertingarmorplate )
        {
            return;
        }
        
        if ( player function_a0b979ff30c7a327() || player zombie_perks::function_cda78d45986a51a0() )
        {
            return;
        }
        
        if ( !player currency::attempt_purchase( s_perk_machine.script_currency, var_4c22addfe5b4f20e, 1, undefined, #"perk", perk ) )
        {
            return;
        }
        
        if ( mdl_perk_machine getscriptablehaspart( "use" ) )
        {
            if ( mdl_perk_machine getscriptablepartstate( "use" ) == "default" )
            {
                mdl_perk_machine setscriptablepartstate( "use", "purchase" );
            }
        }
        
        var_566a02e0b85fd2e7 = level.gametypebundle.var_d2a7b8fafa40d741;
        
        if ( var_566a02e0b85fd2e7 > 0 )
        {
            if ( !isdefined( player.total_purchased_perks ) )
            {
                player.total_purchased_perks = 0;
            }
            
            if ( !isdefined( player.perkspurchased ) )
            {
                player.perkspurchased = [];
            }
            
            if ( !isdefined( level.var_af8e5ce115d7696f ) )
            {
                level.var_af8e5ce115d7696f = 0;
            }
            
            player.total_purchased_perks++;
            
            if ( !level.var_3ae3959c37a85611 )
            {
                player.perkspurchased[ perk ] = 1;
            }
            
            level.var_af8e5ce115d7696f++;
            level notify( #"perk_purchased" );
            var_433e572e6391fd13 = var_566a02e0b85fd2e7 + level.players.size;
            
            if ( level.var_af8e5ce115d7696f >= var_433e572e6391fd13 )
            {
                level.var_865fa84b8f7cc220 = 1;
            }
        }
        
        if ( level.var_3ae3959c37a85611 )
        {
            perk = player zombie_perks::function_ab9b4123275d6153( undefined, undefined, undefined, 1 );
        }
        else
        {
            gesture = level._custom_perks[ perk ].perk_bottle_weapon;
            
            if ( gesture )
            {
                player thread zombie_perks::function_13cc8b1c31dda8c4( gesture );
            }
        }
        
        thread function_368e07c2085556b( perk );
        params = spawnstruct();
        params.perk_machine = self;
        player callback::callback( "zm_perk_machine_used", params );
        var_ee514e517141b531 = spawnstruct();
        var_ee514e517141b531.perkref = perk;
        var_ee514e517141b531.cost = var_4c22addfe5b4f20e;
        var_ee514e517141b531.currency = s_perk_machine.script_currency;
        var_ee514e517141b531.source = #"perk_machine";
        player callback::callback( "zm_perk_purchased", var_ee514e517141b531 );
        
        if ( !level.var_3ae3959c37a85611 )
        {
            player zombie_perks::give_perk( perk, 1, 1 );
        }
    }
}

// Namespace perk_machines
// Params 2
// Checksum 0x34e12baf, Offset: 0x2271
// Size: 0x196
function function_8eaa7adaaea867ff( str_key, interact )
{
    assert( isdefined( str_key ), "<dev string:x164>" );
    str_endon = str_key + "_power_thread_end";
    level endon( str_endon );
    self endon( str_endon );
    level endon( #"game_ended" );
    self endon( #"death" );
    str_notify = str_key + "_power_on";
    var_bb3cfcbf65750e32 = "power_on";
    b_first_powered_on = 0;
    is_zone_powered = isdefined( self.s_perk_machine.script_int ) ? 1 : 0;
    
    while ( true )
    {
        if ( self isscriptableinstance() )
        {
            self setscriptablepartstate( "base", "power_off" );
        }
        
        self.script_notify = str_key;
        self.var_5b8bb3ac47a2aaea = 1;
        b_start_on = function_21fb1c4d928c8794( str_key );
        
        if ( !b_first_powered_on && b_start_on )
        {
            waitframe();
        }
        else if ( is_zone_powered )
        {
            level utility::flag_wait( var_bb3cfcbf65750e32 + self.s_perk_machine.script_int );
        }
        else
        {
            level utility::flag_wait( var_bb3cfcbf65750e32 );
        }
        
        perk_machine_power_on( str_key, interact );
        level notify( str_notify );
        b_first_powered_on = 1;
        
        if ( is_zone_powered )
        {
            level utility::flag_waitopen( var_bb3cfcbf65750e32 + self.s_perk_machine.script_int );
        }
        else
        {
            if ( !level utility::flag_exist( var_bb3cfcbf65750e32 ) )
            {
                return;
            }
            
            if ( b_start_on )
            {
                return;
            }
            
            level utility::flag_waitopen( var_bb3cfcbf65750e32 );
        }
        
        perk_machine_power_off( interact );
    }
}

// Namespace perk_machines
// Params 1
// Checksum 0xc55f076a, Offset: 0x240f
// Size: 0x3c, Type: bool
function function_21fb1c4d928c8794( perk )
{
    if ( level.vending_machines_powered_on_at_start )
    {
        return true;
    }
    
    if ( isdefined( level.var_1d3d915cc555bf38 ) && level.var_1d3d915cc555bf38[ perk ] )
    {
        return true;
    }
    
    return false;
}

// Namespace perk_machines
// Params 2
// Checksum 0xd7132940, Offset: 0x2454
// Size: 0x196
function perk_machine_power_off( interact, to_disabled = 0 )
{
    if ( !self )
    {
        return;
    }
    
    if ( isdefined( self.jingle_trigger ) )
    {
        self.jingle_trigger function_bdb3cd9488bdadd2();
    }
    
    if ( self isscriptableinstance() )
    {
        self setscriptablepartstate( "base", "power_off" );
        
        if ( to_disabled )
        {
            self setscriptablepartstate( "icon", "disabled" );
            
            if ( isent( self ) && isdefined( level._custom_perks[ self.s_perk_machine.script_noteworthy ].str_override_model ) )
            {
                self setmodel( level._custom_perks[ self.s_perk_machine.script_noteworthy ].str_override_model );
            }
            
            foreach ( player in level.players )
            {
                if ( !level.perk_machine_menu ZMPerkChoiceMenu::is_open( player ) )
                {
                    continue;
                }
                
                if ( player.var_262ef59f258dc9c != self.s_perk_machine )
                {
                    continue;
                }
                
                player.var_56d43599c6ebfc4e = 1;
            }
        }
    }
    
    level callback::callback( self.script_noteworthy + "_power_off" );
}

// Namespace perk_machines
// Params 3
// Checksum 0xe6161fc5, Offset: 0x25f2
// Size: 0xb1
function perk_machine_power_on( str_key, interact, to_active = 0 )
{
    if ( !self )
    {
        return;
    }
    
    thread function_5b5d259380f19b29( str_key );
    
    if ( self isscriptableinstance() )
    {
        self setscriptablepartstate( "base", "power_activate" );
        
        if ( to_active )
        {
            self setscriptablepartstate( "icon", "active" );
        }
    }
    
    if ( isent( self ) && isdefined( level._custom_perks[ str_key ].var_1d1a3ad5cd2c2ea2 ) )
    {
        self setmodel( level._custom_perks[ str_key ].var_1d1a3ad5cd2c2ea2 );
    }
    
    level callback::callback( str_key + "_power_on" );
}

// Namespace perk_machines
// Params 1
// Checksum 0xe6f674b8, Offset: 0x26ab
// Size: 0x39
function function_9ecd411b3667e542( interact )
{
    if ( isdefined( self.jingle_trigger ) )
    {
        self.jingle_trigger function_bdb3cd9488bdadd2();
    }
    
    self setscriptablepartstate( "base", "power_off" );
}

// Namespace perk_machines
// Params 2
// Checksum 0x10b8f770, Offset: 0x26ec
// Size: 0x30
function function_ebf0534612bd6968( str_key, interact )
{
    thread function_5b5d259380f19b29( str_key, 1 );
    self setscriptablepartstate( "base", "power_activate" );
}

// Namespace perk_machines
// Params 2
// Checksum 0x8ff9acbc, Offset: 0x2724
// Size: 0x131
function function_fe6d0c77f6ce6ac1( usable, player )
{
    if ( isdefined( player ) && isdefined( usable ) )
    {
        if ( usable getscriptablepartstate( "base" ) == "power_off" )
        {
            var_cce73ae069e33fd1 = function_2fd536fafa95f30d( usable, player );
            var_cce73ae069e33fd1.aux_text = usable.var_4256b14b47d5e763 ?? &"SHARED_HINTSTRINGS/NEED_POWER_RED";
            var_cce73ae069e33fd1.var_776a268784e089af = &"SHARED_HINTSTRINGS/COST_ESSENCE";
            var_cce73ae069e33fd1.interactable = 0;
            return var_cce73ae069e33fd1;
        }
        else if ( player function_a0b979ff30c7a327() || player zombie_perks::function_cda78d45986a51a0() )
        {
            return { #string:&"", #type:"HINT_NOBUTTON" };
        }
        else if ( player.interactions_disabled )
        {
            return { #string:&"", #type:"HINT_NOICON" };
        }
        else
        {
            return function_2fd536fafa95f30d( usable, player, 1 );
        }
    }
    
    return { #string:&"", #type:"HINT_NOICON" };
}

// Namespace perk_machines
// Params 1
// Checksum 0xc21f05f6, Offset: 0x285e
// Size: 0x8b
function function_91eb8bd11a034ed2( perk )
{
    offsetvec = vectornormalize( anglestoforward( self.angles ) ) * 50;
    trigger = spawn( "noent_volume_trigger_rotatable_radius", self.origin + offsetvec, 0, 34, 64 );
    
    if ( isdefined( perk ) )
    {
        trigger.script_noteworthy = perk;
        trigger.targetname = "lc_trigger";
    }
    
    trigger.var_aba7994c4f6613b7 = self;
    trigger thread function_12b40ebf49fa016f();
}

// Namespace perk_machines
// Params 0
// Checksum 0x7f2cb99d, Offset: 0x28f1
// Size: 0x11e
function function_12b40ebf49fa016f()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"trigger", player );
        
        if ( !isdefined( self.var_aba7994c4f6613b7 ) )
        {
            break;
        }
        
        if ( self.var_aba7994c4f6613b7.disable_change )
        {
            wait 0.1;
            continue;
        }
        
        if ( !isdefined( player.inlaststand ) )
        {
            player.inlaststand = 0;
        }
        
        if ( isplayer( player ) && player getstance() == "prone" && !player.inlaststand )
        {
            params = spawnstruct();
            params.scoreevent = #"loose_change";
            player callback::callback( "zombie_score_event", params );
            
            if ( self.var_aba7994c4f6613b7 getscriptablehaspart( "sparechange" ) )
            {
                self.var_aba7994c4f6613b7 setscriptablepartstate( "sparechange", "activate" );
            }
            
            player playrumbleonentity( "damage_light" );
            break;
        }
        
        wait 0.1;
    }
    
    self delete();
}

// Namespace perk_machines
// Params 2
// Checksum 0xa712664a, Offset: 0x2a17
// Size: 0xd8
function function_5b5d259380f19b29( str_perk_key, b_israndom = 0 )
{
    if ( !self )
    {
        return;
    }
    
    trigger = spawn( "noent_volume_trigger_radius", self.origin - 400, 0, 1500, 800 );
    trigger.perk_machine = self;
    trigger.str_perk_key = str_perk_key;
    trigger.b_israndom = b_israndom;
    trigger.watcheractive = 0;
    self.jingle_trigger = trigger;
    
    if ( utility::issharedfuncdefined( #"game", #"makeenterexittrigger" ) )
    {
        [[ utility::getsharedfunc( #"game", #"makeenterexittrigger" ) ]]( trigger, &function_649a2bdbddbbbd58, &function_d3a78ff7491224f6, undefined, undefined, &function_534b782ad8a9c04f );
    }
}

// Namespace perk_machines
// Params 2, eflags: 0x4
// Checksum 0xa20e29a, Offset: 0x2af7
// Size: 0x61
function private function_649a2bdbddbbbd58( player, trigger )
{
    waitframe();
    
    if ( isdefined( trigger ) )
    {
        if ( !trigger.watcheractive )
        {
            trigger.watcheractive = 1;
            trigger.perk_machine thread function_14f9586eb59f5550( trigger.str_perk_key, trigger.b_israndom );
        }
    }
}

// Namespace perk_machines
// Params 2, eflags: 0x4
// Checksum 0x3f35b153, Offset: 0x2b60
// Size: 0x8a
function private function_d3a78ff7491224f6( player, trigger )
{
    waitframe();
    
    if ( isdefined( trigger ) )
    {
        if ( trigger.triggerenterents.size <= 0 )
        {
            trigger.watcheractive = 0;
            
            if ( trigger.perk_machine )
            {
                trigger.perk_machine notify( #"hash_fd1062382b3d7c69" );
                
                if ( trigger.perk_machine isscriptableinstance() )
                {
                    trigger.perk_machine setscriptablepartstate( "music", "off" );
                }
            }
        }
    }
}

// Namespace perk_machines
// Params 2, eflags: 0x4
// Checksum 0x13d37788, Offset: 0x2bf2
// Size: 0x24, Type: bool
function private function_534b782ad8a9c04f( enteringentity, trigger )
{
    return !isplayer( enteringentity ) || !isdefined( trigger );
}

// Namespace perk_machines
// Params 0, eflags: 0x4
// Checksum 0x5b35c938, Offset: 0x2c1f
// Size: 0x44
function private function_bdb3cd9488bdadd2()
{
    self.perk_machine notify( #"hash_fd1062382b3d7c69" );
    
    if ( self.perk_machine isscriptableinstance() )
    {
        self.perk_machine setscriptablepartstate( "music", "off" );
    }
    
    self delete();
}

// Namespace perk_machines
// Params 2
// Checksum 0x529dca13, Offset: 0x2c6b
// Size: 0x127
function function_14f9586eb59f5550( str_perk_key, b_israndom = 0 )
{
    self endon( #"death" );
    self endon( #"hash_fd1062382b3d7c69" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !self isscriptableinstance() )
    {
        return;
    }
    
    if ( self getscriptablepartstate( "music" ) != "off" )
    {
        wait 40;
    }
    
    while ( self.jingle_trigger.triggerenterents.size > 0 )
    {
        wait randomintrange( 60, 120 );
        
        if ( self getscriptablehaspart( "music" ) )
        {
            if ( self getscriptablepartstate( "music" ) == "off" )
            {
                if ( b_israndom )
                {
                    var_942b17d16bdf297e = utility::array_random( level.var_d942db4d2fbe72cd );
                    self setscriptablepartstate( "music", var_942b17d16bdf297e + "_jingle", 0 );
                }
                else
                {
                    var_1f3afc36a9ae9d10 = str_perk_key;
                    
                    if ( level.var_3ae3959c37a85611 )
                    {
                        var_1f3afc36a9ae9d10 = "random_relic";
                    }
                    
                    self setscriptablepartstate( "music", var_1f3afc36a9ae9d10 + "_jingle", 0 );
                }
                
                while ( self getscriptablepartstate( "music" ) != "off" )
                {
                    wait 2;
                }
                
                wait 40;
            }
        }
    }
}

// Namespace perk_machines
// Params 1
// Checksum 0x796e3d73, Offset: 0x2d9a
// Size: 0x6d
function function_368e07c2085556b( str_perk_key )
{
    self endon( #"death" );
    
    if ( self getscriptablehaspart( "music" ) )
    {
        if ( self getscriptablepartstate( "music" ) == "off" )
        {
            var_632711b586478f43 = str_perk_key;
            
            if ( level.var_3ae3959c37a85611 )
            {
                var_632711b586478f43 = "random_relic";
            }
            
            self setscriptablepartstate( "music", var_632711b586478f43 + "_stinger", 0 );
        }
    }
}

// Namespace perk_machines
// Params 1
// Checksum 0x9c82da23, Offset: 0x2e0f
// Size: 0x687
function function_e3d3bfcc06c89350( instance )
{
    if ( getdvarint( @"hash_74cacae425805743", 0 ) > 0 )
    {
        return;
    }
    
    if ( !arraycontains( level.a_s_perk_machines, self ) )
    {
        level.a_s_perk_machines[ level.a_s_perk_machines.size ] = self;
    }
    
    self.is_wunderfizz = 1;
    utility::flag_wait( "StartGameTypeCallbackFinished" );
    
    if ( isdefined( self.target2 ) )
    {
        self.clip = getent( self.target2, #targetname );
        
        if ( isdefined( self.clip ) )
        {
            self.clip notsolid();
            self.clip connectpaths();
        }
    }
    
    perkbundle = level.perkbundles[ "specialty_wunderfizz" ];
    
    if ( level.gametypebundle.var_c0e626638c3cdd4c )
    {
        if ( utility::issharedfuncdefined( #"zombie", #"hash_1374768dfa684874" ) )
        {
            level utility::callsharedfunc( #"zombie", #"hash_1374768dfa684874" );
        }
        
        var_b0003e956eebc03f = level.var_6781718da4f78d1c.roundnumber;
        
        if ( var_b0003e956eebc03f < level.gametypebundle.var_7910192e66e7774c )
        {
            while ( level.var_6781718da4f78d1c.roundnumber < level.gametypebundle.var_7910192e66e7774c && !level.var_865fa84b8f7cc220 )
            {
                level utility::waittill_any( "on_round_end", "perk_purchased" );
            }
            
            wait 4;
        }
        
        function_f967ad2b3108404();
        playsoundatpos( self.origin + ( 0, 0, 80 ), #"hash_20cef78b954d2d34" );
        playfx( level._effect[ "spawn_hide" ], self.origin, self.angles );
        playfx( level._effect[ "spawn_hide_trail" ], self.origin, self.angles );
        wait 2;
    }
    
    function_7a835cab177fc315();
    self.str_scriptable = "t10_zm_machine_wunderfizz";
    var_c20ad9047b941cf4 = perkbundle.var_1677a2204cef6d98 ?? self.str_scriptable;
    self.mdl_perk_machine = spawnscriptable( var_c20ad9047b941cf4, self.origin, self.angles );
    
    if ( level.gametypebundle.var_c0e626638c3cdd4c )
    {
        a_players = getplayersinradius( self.mdl_perk_machine.origin, 50 );
        
        foreach ( player in a_players )
        {
            player thread function_9dd19eb4dd4bf00a( self.mdl_perk_machine );
        }
        
        foreach ( player in level.players )
        {
            player prestreamasset( "model", getxhashasset( self.mdl_perk_machine.model ), 1000 );
        }
    }
    
    if ( isdefined( self.clip ) )
    {
        self.clip solid();
        self.clip disconnectpaths();
    }
    
    utility::callsharedfunc( #"scriptable", #"hash_10d5e3bb8a551724", self.mdl_perk_machine, "icon" );
    self.script_currency = instance.script_currency ?? #"essence";
    
    if ( !isdefined( self.radius ) )
    {
        self.radius = 64;
    }
    
    self.script_cost = level._custom_perks[ "specialty_choice" ].cost;
    
    if ( isent( self.mdl_perk_machine ) )
    {
        self.mdl_perk_machine.interact = interaction::register_interact( self.mdl_perk_machine, self.radius, &function_1ec7efcd9bdee1b8, undefined, undefined, undefined, undefined, "HINT_BUTTON" );
        self.mdl_perk_machine.interact setusefov( 130 );
        self.mdl_perk_machine.interact interaction::set_interact_hint_callback( &function_fe6d0c77f6ce6ac1 );
    }
    else
    {
        self.mdl_perk_machine.interact = interaction::register_scriptable_interact( self.mdl_perk_machine, level.perk_machine_func[ "on_use_choice" ] );
        self.mdl_perk_machine.interact interaction::set_interact_hint_callback( level.perk_machine_func[ "per_player_hint_choice" ] );
    }
    
    if ( !isdefined( level.gametypebundle.var_c0e626638c3cdd4c ) )
    {
        self.mdl_perk_machine function_9ecd411b3667e542( self.mdl_perk_machine.interact );
    }
    
    if ( self.mdl_perk_machine getscriptablehaspart( "use" ) )
    {
        self.mdl_perk_machine setscriptablepartstate( "use", "default" );
    }
    
    self.mdl_perk_machine.interact.s_perk_machine = self;
    self.mdl_perk_machine thread [[ level.perk_machine_func[ "think_choice" ] ]]( self.mdl_perk_machine.interact );
    self.mdl_perk_machine thread function_91eb8bd11a034ed2();
    
    if ( level.gametypebundle.var_c0e626638c3cdd4c )
    {
        foreach ( player in level.players )
        {
            player prestreamclear( "model" );
        }
    }
}

// Namespace perk_machines
// Params 1
// Checksum 0x690a76d1, Offset: 0x349e
// Size: 0x16c
function function_29138c19b4ba9199( interact )
{
    str_key = "specialty_choice";
    str_endon = str_key + "_power_thread_end";
    level endon( str_endon );
    self endon( str_endon );
    str_notify = str_key + "_power_on";
    var_bb3cfcbf65750e32 = "power_on";
    b_first_powered_on = 0;
    is_zone_powered = isdefined( self.s_perk_machine.script_int ) ? 1 : 0;
    
    while ( true )
    {
        self setscriptablepartstate( "base", "power_off" );
        self.script_notify = str_key;
        self.var_5b8bb3ac47a2aaea = 1;
        b_start_on = function_21fb1c4d928c8794( str_key );
        
        if ( !b_first_powered_on && b_start_on )
        {
            waitframe();
        }
        else if ( is_zone_powered )
        {
            level utility::flag_wait( var_bb3cfcbf65750e32 + self.s_perk_machine.script_int );
        }
        else
        {
            level utility::flag_wait( var_bb3cfcbf65750e32 );
        }
        
        function_ebf0534612bd6968( str_key, interact );
        level notify( str_notify );
        b_first_powered_on = 1;
        
        if ( is_zone_powered )
        {
            level utility::flag_waitopen( var_bb3cfcbf65750e32 + self.s_perk_machine.script_int );
        }
        else
        {
            if ( !level utility::flag_exist( var_bb3cfcbf65750e32 ) )
            {
                return;
            }
            
            level utility::flag_waitopen( var_bb3cfcbf65750e32 );
        }
        
        if ( b_start_on )
        {
            return;
        }
        
        function_9ecd411b3667e542( interact );
    }
}

// Namespace perk_machines
// Params 1
// Checksum 0x55d5c8cb, Offset: 0x3612
// Size: 0x250
function function_1ec7efcd9bdee1b8( player )
{
    if ( isdefined( player ) && player.interactions_disabled )
    {
        return;
    }
    
    if ( player function_a0b979ff30c7a327() || player zombie_perks::function_cda78d45986a51a0() )
    {
        return;
    }
    
    if ( self.s_perk_machine.mdl_perk_machine getscriptablepartstate( "base" ) == "power_off" )
    {
        return;
    }
    
    if ( level.var_c139731c583cae6b || !player val::get( "allow_zm_perks" ) )
    {
        return;
    }
    
    if ( level.var_3ae3959c37a85611 )
    {
        var_4c22addfe5b4f20e = player zombie_perks::function_77331fd62580dd0a();
        
        if ( !player currency::attempt_purchase( self.s_perk_machine.script_currency, var_4c22addfe5b4f20e, 1, undefined, #"perk" ) )
        {
            return;
        }
        
        perk = player zombie_perks::function_ab9b4123275d6153( undefined, undefined, undefined, 1 );
        var_ee514e517141b531 = spawnstruct();
        var_ee514e517141b531.perkref = perk;
        var_ee514e517141b531.cost = var_4c22addfe5b4f20e;
        var_ee514e517141b531.currency = #"essence";
        var_ee514e517141b531.source = #"wunderfizz";
        player callback::callback( "zm_perk_purchased", var_ee514e517141b531 );
        return;
    }
    
    if ( level.var_6891dd100da9df37 )
    {
        level.var_ea5fb2ecb092a34e = 1;
        var_4c22addfe5b4f20e = player zombie_perks::function_77331fd62580dd0a();
        
        if ( !player currency::attempt_purchase( self.s_perk_machine.script_currency, var_4c22addfe5b4f20e, 1, undefined, #"perk" ) )
        {
            return;
        }
        
        perk = player zombie_perks::function_ab9b4123275d6153( undefined, 1, undefined, 1 );
        var_ee514e517141b531 = spawnstruct();
        var_ee514e517141b531.perkref = perk;
        var_ee514e517141b531.cost = var_4c22addfe5b4f20e;
        var_ee514e517141b531.currency = #"essence";
        var_ee514e517141b531.source = #"wunderfizz";
        player callback::callback( "zm_perk_purchased", var_ee514e517141b531 );
        level.var_ea5fb2ecb092a34e = 0;
        return;
    }
    
    self.s_perk_machine.var_37f3a4cd8252c9f0 = player;
    player.var_262ef59f258dc9c = self.s_perk_machine;
    player thread function_ce7ae9afc9981f9f( self.s_perk_machine );
}

// Namespace perk_machines
// Params 2
// Checksum 0x30c41ccc, Offset: 0x386a
// Size: 0x39a
function perk_choice_purchase( channel, var_1923b2b3afc076ba )
{
    if ( isdefined( var_1923b2b3afc076ba ) )
    {
        if ( channel == "perk_choice_purchase" )
        {
            var_9c657aff3a2d52cf = get_wunderfizz_menu();
            
            if ( !isdefined( var_9c657aff3a2d52cf ) )
            {
                return;
            }
            
            valid_perks = zombie_perks::get_perks_str_array();
            active_perks = zombie_perks::get_active_perks_str_array();
            
            if ( isarray( active_perks ) )
            {
                valid_perks = arrayremove( valid_perks, active_perks );
            }
            
            item = purchasemenu::create_item_struct( #"wunderfizz", var_1923b2b3afc076ba );
            
            if ( !isdefined( item.itemref ) || !arraycontains( valid_perks, item.itemref ) )
            {
                return;
            }
            
            var_4c22addfe5b4f20e = zombie_perks::function_77331fd62580dd0a();
            
            if ( !function_279e25f1d0974cbc( var_1923b2b3afc076ba, self ) )
            {
                if ( isdefined( item.var_ac7c10eb14c9d6e0 ) )
                {
                    self playsoundtoplayer( item.var_ac7c10eb14c9d6e0, self );
                }
                
                purchasemenu::function_93f934ea2f1c06f8( 3 );
                return;
            }
            
            var_566a02e0b85fd2e7 = level.gametypebundle.var_d2a7b8fafa40d741;
            
            if ( var_566a02e0b85fd2e7 > 0 )
            {
                if ( !isdefined( self.total_purchased_perks ) )
                {
                    self.total_purchased_perks = 0;
                }
                
                if ( !isdefined( self.perkspurchased ) )
                {
                    self.perkspurchased = [];
                }
                
                if ( !isdefined( level.var_af8e5ce115d7696f ) )
                {
                    level.var_af8e5ce115d7696f = 0;
                }
                
                self.total_purchased_perks++;
                self.perkspurchased[ item.itemref ] = 1;
                level.var_af8e5ce115d7696f++;
                level notify( #"perk_purchased" );
                var_433e572e6391fd13 = var_566a02e0b85fd2e7 + level.players.size;
                
                if ( level.var_af8e5ce115d7696f >= var_433e572e6391fd13 )
                {
                    level.var_865fa84b8f7cc220 = 1;
                }
            }
            
            if ( !self isgestureplaying() )
            {
                gesture = level._custom_perks[ item.itemref ].perk_bottle_weapon;
                
                if ( isdefined( gesture ) )
                {
                    thread zombie_perks::function_13cc8b1c31dda8c4( gesture );
                    b_playing_gesture = 1;
                }
            }
            
            if ( isdefined( item.var_9281c8f5b1f3b37a ) )
            {
                self playsoundtoplayer( item.var_9281c8f5b1f3b37a, self );
            }
            
            params = spawnstruct();
            params.perk_machine = self.var_262ef59f258dc9c.mdl_perk_machine;
            params.perk = item.itemref;
            callback::callback( "zm_perk_machine_used", params );
            zombie_perks::give_perk( item.itemref, 1, b_playing_gesture );
            var_ee514e517141b531 = spawnstruct();
            var_ee514e517141b531.perkref = item.itemref;
            var_ee514e517141b531.cost = var_4c22addfe5b4f20e;
            var_ee514e517141b531.currency = item.currency ?? #"essence";
            var_ee514e517141b531.source = #"wunderfizz";
            callback::callback( "zm_perk_purchased", var_ee514e517141b531 );
            
            if ( isdefined( self.var_262ef59f258dc9c ) )
            {
                if ( isdefined( self.var_262ef59f258dc9c.mdl_perk_machine ) )
                {
                    self.var_262ef59f258dc9c.mdl_perk_machine thread function_368e07c2085556b( item.itemref );
                }
            }
            
            purchasemenu::function_93f934ea2f1c06f8( 1 );
            self notify( #"wunderfizz_purchase" );
            return;
        }
        
        if ( purchasemenu::function_bc886ba2b8da88c( #"wunderfizz", channel ) )
        {
            self.var_56d43599c6ebfc4e = 1;
        }
    }
}

// Namespace perk_machines
// Params 2
// Checksum 0xefc6095d, Offset: 0x3c0c
// Size: 0x93
function function_279e25f1d0974cbc( var_1923b2b3afc076ba, player )
{
    cost = 0;
    currency = #"essence";
    item = purchasemenu::create_item_struct( #"wunderfizz", var_1923b2b3afc076ba );
    
    if ( isdefined( player ) && isdefined( item ) )
    {
        cost = player zombie_perks::function_77331fd62580dd0a();
        currency = item.currency;
    }
    
    return currency::attempt_purchase( currency, cost, 1, undefined, #"perk", item.itemref );
}

// Namespace perk_machines
// Params 1
// Checksum 0x92ace40e, Offset: 0x3ca8
// Size: 0xe2
function function_ce7ae9afc9981f9f( s_perk_machine )
{
    self endon( #"death_or_disconnect" );
    self endon( #"end_open_perk_choice_menu" );
    var_9c657aff3a2d52cf = get_wunderfizz_menu();
    
    if ( !isdefined( var_9c657aff3a2d52cf ) )
    {
        return;
    }
    
    n_menu_id = var_9c657aff3a2d52cf.id ?? -1;
    self setclientomnvar( "ui_purchasemenu_id", n_menu_id );
    waitframe();
    
    if ( !level.perk_machine_menu ZMPerkChoiceMenu::is_open( self ) )
    {
        level.perk_machine_menu ZMPerkChoiceMenu::open( self );
        
        if ( isdefined( var_9c657aff3a2d52cf.soundopenmenu ) )
        {
            self playsoundtoplayer( var_9c657aff3a2d52cf.soundopenmenu, self );
        }
    }
    
    s_perk_machine.mdl_perk_machine disablescriptablepartplayeruse( "base", self );
    thread function_dcf4f06c84df1d43( s_perk_machine );
    thread function_7e2798fdda2c3a5d( s_perk_machine );
    thread purchasemenu::menu_close_notify( var_9c657aff3a2d52cf, &on_menu_close );
}

// Namespace perk_machines
// Params 1
// Checksum 0x11f5b08f, Offset: 0x3d92
// Size: 0x1a
function on_menu_close( player )
{
    player.b_close_arsenal = 1;
}

// Namespace perk_machines
// Params 1
// Checksum 0x9c76c011, Offset: 0x3db4
// Size: 0x1cd
function function_dcf4f06c84df1d43( s_perk_machine )
{
    self notify( #"hash_84f90b89c699ffd9" );
    self endon( #"hash_84f90b89c699ffd9" );
    self endon( #"disconnect" );
    var_9c657aff3a2d52cf = get_wunderfizz_menu();
    
    if ( !( isdefined( var_9c657aff3a2d52cf ) && isdefined( level.perk_machine_menu ) ) )
    {
        return;
    }
    
    var_75385495715741fb = s_perk_machine.mdl_perk_machine;
    wait 0.75;
    n_start_distance = distance2d( var_75385495715741fb.origin, self.origin );
    v_start = self.origin;
    self.var_56d43599c6ebfc4e = undefined;
    
    while ( isdefined( var_75385495715741fb ) && isalive( self ) && !self.inlaststand && ( distance2d( var_75385495715741fb.origin, self.origin ) <= n_start_distance || distance2d( self.origin, var_75385495715741fb.origin ) < 32 ) )
    {
        if ( !isdefined( var_75385495715741fb ) || self stancebuttonpressed() || self.var_56d43599c6ebfc4e || level.b_zm_game_over )
        {
            break;
        }
        
        waitframe();
    }
    
    if ( isdefined( self ) )
    {
        self.var_56d43599c6ebfc4e = undefined;
        purchasemenu::function_93f934ea2f1c06f8( 2 );
        level.perk_machine_menu ZMPerkChoiceMenu::close( self );
        self setclientomnvar( "ui_purchasemenu_id", 0 );
        
        if ( isdefined( var_9c657aff3a2d52cf.soundclosemenu ) )
        {
            self playsoundtoplayer( var_9c657aff3a2d52cf.soundclosemenu, self );
        }
        
        s_perk_machine.mdl_perk_machine enablescriptablepartplayeruse( "base", self );
        self.s_perk_machine = undefined;
        self notify( #"end_open_perk_choice_menu" );
        self notify( var_9c657aff3a2d52cf.var_8a64e37068076a47 );
    }
}

// Namespace perk_machines
// Params 1
// Checksum 0xfc494d4c, Offset: 0x3f89
// Size: 0x9c
function function_7e2798fdda2c3a5d( s_perk_machine )
{
    self notify( #"hash_73285af1841ea116" );
    self endon( #"hash_73285af1841ea116" );
    self endon( #"end_open_perk_choice_menu" );
    self endon( #"disconnect" );
    mdl_perk_machine = s_perk_machine.mdl_perk_machine;
    
    while ( true )
    {
        self waittill( #"wunderfizz_purchase" );
        
        if ( mdl_perk_machine getscriptablehaspart( "use" ) )
        {
            if ( mdl_perk_machine getscriptablepartstate( "use" ) == "default" )
            {
                mdl_perk_machine setscriptablepartstate( "use", "purchase" );
            }
        }
        
        waitframe();
    }
}

// Namespace perk_machines
// Params 2
// Checksum 0xfb4df8aa, Offset: 0x402d
// Size: 0xe2
function function_c75df733a8141c97( str_key, interact )
{
    assert( isdefined( str_key ), "<dev string:x164>" );
    str_endon = str_key + "_power_thread_end";
    level endon( str_endon );
    self endon( str_endon );
    str_notify = str_key + "_power_on";
    var_bb3cfcbf65750e32 = "power_on";
    
    while ( true )
    {
        self setscriptablepartstate( "base", "power_off" );
        self.script_notify = str_key;
        self.var_5b8bb3ac47a2aaea = 1;
        perk_machine_power_on( str_key, interact );
        level notify( str_notify );
        b_first_powered_on = 1;
        utility::flag_wait( "on_cooldown" + self.script_notify );
        perk_machine_power_off( interact );
        utility::flag_waitopen( "on_cooldown" + self.script_notify );
    }
}

// Namespace perk_machines
// Params 1
// Checksum 0x2a16a17f, Offset: 0x4117
// Size: 0x21d
function function_ba8b5ac52040eeb6( player )
{
    perk = self.script_notify;
    assert( isdefined( level._custom_perks[ perk ] ), "<dev string:xce>" + perk + "<dev string:xd4>" );
    s_perk_machine = self.s_perk_machine;
    
    if ( isdefined( player ) && isdefined( s_perk_machine.script_currency ) )
    {
        if ( player zombie_perks::has_perk( level._custom_perks[ perk ].str_perk_root ) )
        {
            return;
        }
        
        if ( level.var_c139731c583cae6b || !player val::get( "allow_zm_perks" ) )
        {
            return;
        }
        
        if ( player.interactions_disabled )
        {
            return;
        }
        
        if ( player function_a0b979ff30c7a327() || player zombie_perks::function_cda78d45986a51a0() )
        {
            return;
        }
        
        mdl_perk_machine = s_perk_machine.mdl_perk_machine;
        
        if ( mdl_perk_machine getscriptablehaspart( "use" ) )
        {
            if ( mdl_perk_machine getscriptablepartstate( "use" ) == "default" )
            {
                mdl_perk_machine setscriptablepartstate( "use", "purchase" );
            }
        }
        
        gesture = level._custom_perks[ perk ].perk_bottle_weapon;
        player thread zombie_perks::function_13cc8b1c31dda8c4( gesture );
        thread function_368e07c2085556b( perk );
        params = spawnstruct();
        params.perk_machine = self;
        player callback::callback( "zm_perk_machine_used", params );
        var_ee514e517141b531 = spawnstruct();
        var_ee514e517141b531.perkref = perk;
        var_ee514e517141b531.cost = player zombie_perks::function_77331fd62580dd0a();
        var_ee514e517141b531.currency = s_perk_machine.script_currency;
        var_ee514e517141b531.source = #"perk_machine";
        player callback::callback( "zm_perk_purchased", var_ee514e517141b531 );
        player zombie_perks::give_perk( perk, 1 );
        utility::flag_set( "on_cooldown" + perk );
        level waittill( #"between_round_over" );
        utility::flag_clear( "on_cooldown" + perk );
    }
}

// Namespace perk_machines
// Params 2, eflags: 0x4
// Checksum 0x1984db62, Offset: 0x433c
// Size: 0x1bd
function private function_8c4b28ece5745836( usable, player )
{
    if ( isdefined( player ) && isdefined( usable ) )
    {
        perk = usable.script_notify;
        str_key = usable.script_notify ?? "talent_juggernog";
        
        if ( usable getscriptablepartstate( "base" ) == "power_off" )
        {
            return { #string:&"", #type:"HINT_NOICON" };
        }
        else if ( level.var_c139731c583cae6b || !player val::get( "allow_zm_perks" ) )
        {
            return { #string:&"", #type:"HINT_NOBUTTON" };
        }
        else if ( player.interactions_disabled )
        {
            return { #string:&"", #type:"HINT_NOBUTTON" };
        }
        else if ( player function_a0b979ff30c7a327() || player zombie_perks::function_cda78d45986a51a0() )
        {
            return { #string:&"", #type:"HINT_NOBUTTON" };
        }
        else if ( player zombie_perks::has_perk( level._custom_perks[ perk ].str_perk_root ) )
        {
            return { #string:&"", #type:"HINT_NOBUTTON" };
        }
        else
        {
            var_cce73ae069e33fd1 = function_2fd536fafa95f30d( usable, player );
            return var_cce73ae069e33fd1;
        }
    }
    
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace perk_machines
// Params 0, eflags: 0x4
// Checksum 0x808edece, Offset: 0x4502
// Size: 0x5e, Type: bool
function private function_a0b979ff30c7a327()
{
    player = self;
    
    if ( level.gametypebundle.perklimit > 0 && isdefined( player.var_468836e5e67e15b4 ) && player.var_468836e5e67e15b4 >= level.gametypebundle.perklimit )
    {
        return true;
    }
    
    return false;
}

// Namespace perk_machines
// Params 1
// Checksum 0xc5c5a065, Offset: 0x4569
// Size: 0x6e
function function_9dd19eb4dd4bf00a( var_75385495715741fb )
{
    var_75385495715741fb endon( #"death_or_disconnect" );
    
    if ( isalive( self ) )
    {
        forwardangle = anglestoforward( var_75385495715741fb.angles );
        
        if ( isdefined( forwardangle ) )
        {
            forwardvec = vectornormalize( forwardangle );
            
            if ( isdefined( forwardvec ) )
            {
                self setorigin( self.origin + forwardvec * 64, 0 );
            }
        }
    }
}

// Namespace perk_machines
// Params 1
// Checksum 0xcc4dbefe, Offset: 0x45df
// Size: 0xbd
function function_d3aeaf67dc73b19d( perk_machine_list )
{
    foreach ( s_perk_machine in perk_machine_list )
    {
        if ( isdefined( s_perk_machine.script_index ) )
        {
            continue;
        }
        
        if ( isdefined( s_perk_machine.mdl_perk_machine ) )
        {
            s_perk_machine.mdl_perk_machine perk_machine_power_off( s_perk_machine.mdl_perk_machine.interact );
        }
    }
}

// Namespace perk_machines
// Params 1
// Checksum 0xb721cdd2, Offset: 0x46a4
// Size: 0xc5
function function_d6cea36a990e9559( perk_machine_list )
{
    foreach ( s_perk_machine in perk_machine_list )
    {
        if ( isdefined( s_perk_machine.script_index ) )
        {
            continue;
        }
        
        if ( isdefined( s_perk_machine.mdl_perk_machine ) )
        {
            perk = s_perk_machine.script_noteworthy ?? "talent_juggernog";
            s_perk_machine.mdl_perk_machine perk_machine_power_on();
        }
    }
}

// Namespace perk_machines
// Params 1
// Checksum 0x9e4aaedd, Offset: 0x4771
// Size: 0x55
function function_d3eec0146d52a887( s_feature )
{
    perk_machine = s_feature.mdl_perk_machine;
    perk_machine.disable_change = 1;
    perk_machine perk_machine_power_off( undefined, 1 );
    perk_machine function_7653c765b6c7b815();
    
    if ( isent( perk_machine ) )
    {
        perk_machine setusableenabled( 0 );
    }
}

// Namespace perk_machines
// Params 1
// Checksum 0xcd209186, Offset: 0x47ce
// Size: 0x5e
function function_a1dc6d11cde4448c( s_feature )
{
    perk_machine = s_feature.mdl_perk_machine;
    perk_machine.disable_change = undefined;
    perk_machine perk_machine_power_on( s_feature.script_noteworthy, undefined, 1 );
    perk_machine function_e203bba36cfb19d0();
    
    if ( isent( perk_machine ) )
    {
        perk_machine setusableenabled( 1 );
    }
}

// Namespace perk_machines
// Params 1
// Checksum 0xbac38449, Offset: 0x4834
// Size: 0x55
function function_348be3ca276a0691( s_feature )
{
    perk_machine = s_feature.mdl_perk_machine;
    perk_machine.disable_change = 1;
    perk_machine perk_machine_power_off( undefined, 1 );
    perk_machine function_7653c765b6c7b815();
    
    if ( isent( perk_machine ) )
    {
        perk_machine setusableenabled( 0 );
    }
}

// Namespace perk_machines
// Params 1
// Checksum 0x63c271cc, Offset: 0x4891
// Size: 0x54
function function_a847ef469f32c5da( s_feature )
{
    perk_machine = s_feature.mdl_perk_machine;
    perk_machine.disable_change = undefined;
    perk_machine perk_machine_power_on( undefined, undefined, 1 );
    perk_machine function_e203bba36cfb19d0();
    
    if ( isent( perk_machine ) )
    {
        perk_machine setusableenabled( 1 );
    }
}

