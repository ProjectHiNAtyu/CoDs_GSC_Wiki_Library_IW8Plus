// script_4478f81b31480314  (hash_4478f81b31480314.gscc) (size: 15021 Bytes / 0x3aad / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe77fb890 (3883907216)
// size ...... 15021 (0x3aad)
// includes .. 8   (offset: 0x362d)
// strings ... 54  (offset: 0x366d)
// dev strs .. 8   (offset: 0x3a3d)
// exports ... 37  (offset: 0x2685)
// cseg ...... 0x4d0 + 0x21b5 (0x2685)
// imports ... 79  (offset: 0x2c4d)
// animtree1 . 0   (offset: 0x3aad)
// animtree2 . 0   (offset: 0x3aad)
#using script_aa3bac81ad4fc8e;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\content_manager;
#using scripts\mp\interaction;

#namespace bgb_machine;

// Namespace bgb_machine
// Params 0, eflags: 0x5
// Checksum 0x6e04de9e, Offset: 0x4ee
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"bgb_machine", undefined, &__init__, &__main__ );
}

// Namespace bgb_machine
// Params 0, eflags: 0x4
// Checksum 0x7412d4e, Offset: 0x513
// Size: 0xb9
function private __init__()
{
    if ( getdvarint( @"hash_294f374ff45e6632" ) || getmatchrulesdata( "zmData", "disableBGB" ) )
    {
        return;
    }
    
    callback::add( #"player_spawned", &on_player_spawned );
    
    /#
        callback::add( #"player_spawned", &on_player_spawned_dev );
    #/
    
    scriptable::scriptable_addnotifycallback( "gumball_available", &scriptable_notify );
    scriptable::scriptable_addnotifycallback( "ready_for_present", &scriptable_notify );
    scriptable::scriptable_addnotifycallback( "gumball_closed_to_initial", &function_f44f6d2718717e85 );
    content_manager::function_3209da123476142f( "bgb", &on_spawn_bgb );
    content_manager::register_disable_toggle( "bgb", &content_manager::function_5d04e50a29a2142c, &on_bgb_disabled, &function_95b01af0a0c71fd );
    level thread init_bgb_postmain();
}

// Namespace bgb_machine
// Params 0, eflags: 0x4
// Checksum 0x7b4eeb0f, Offset: 0x5d4
// Size: 0x126
function private __main__()
{
    level.var_e0910c7bd4aab6fc = [];
    
    if ( getdvarint( @"hash_294f374ff45e6632" ) || getmatchrulesdata( "zmData", "disableBGB" ) )
    {
        return;
    }
    
    var_71d3d4fbec2146fa = level.gametypebundle.var_43039613a0bed209 ?? level.gamemodebundle.var_43039613a0bed209;
    level.var_acc09d0960bca0cc = getscriptbundlefieldvalue( var_71d3d4fbec2146fa, #"hash_5c5ba525d09831d4" );
    level.var_e8ab6fe908f0124d = getscriptbundlefieldvalue( var_71d3d4fbec2146fa, #"hash_7b938b34a83d758a" );
    level.var_c5ba997d23c10a7f = getscriptbundlefieldvalue( var_71d3d4fbec2146fa, #"hash_548a8dc5691beeb4" );
    level.var_7d97f961e8f522d8 = getscriptbundlefieldvalue( var_71d3d4fbec2146fa, #"hash_1526eca7ef444d1f" );
    level.var_d02bb732d5e022a1 = getscriptbundlefieldvalue( var_71d3d4fbec2146fa, #"hash_e8bce26f13bc228b" );
    level.var_8fa1adc73c6dd067 = getscriptbundlefieldvalue( var_71d3d4fbec2146fa, #"hash_2fbb85fe6224020a" );
    level.var_4947e9c773e6417d = getscriptbundlefieldvalue( var_71d3d4fbec2146fa, #"hash_44a7be166df4eb15" );
    
    if ( !isdefined( level.var_ce60e7e0143b25c8 ) )
    {
        level.var_ce60e7e0143b25c8 = &function_125a6162339940bb;
    }
}

// Namespace bgb_machine
// Params 0
// Checksum 0x930c67e9, Offset: 0x702
// Size: 0x17
function function_5805a592897cb161()
{
    callback::remove( #"player_spawned", &on_player_spawned_dev );
}

// Namespace bgb_machine
// Params 1, eflags: 0x4
// Checksum 0x806a1b5, Offset: 0x721
// Size: 0x23
function private on_player_spawned( params )
{
    if ( !isdefined( self.bgb_cooldown ) )
    {
        self.bgb_cooldown = -1;
    }
}

// Namespace bgb_machine
// Params 1, eflags: 0x4
// Checksum 0xbff5bfa7, Offset: 0x74c
// Size: 0x16
function private on_player_spawned_dev( params )
{
    /#
        thread setup_devgui();
    #/
}

// Namespace bgb_machine
// Params 1, eflags: 0x4
// Checksum 0x830cab8c, Offset: 0x76a
// Size: 0xb1
function private on_spawn_bgb( instance )
{
    spawn_points = instance.var_1d6cddfc47031bff[ "bgb_spawn" ];
    
    foreach ( point in spawn_points )
    {
        if ( point content_manager::function_e0f0562adcd2c071() )
        {
            point function_9a3e81eb8357ad32( instance );
        }
    }
    
    level notify( #"bgb_machines_spawned" );
}

// Namespace bgb_machine
// Params 4
// Checksum 0xd03727f0, Offset: 0x823
// Size: 0x2c
function scriptable_notify( param, param1, param2, param3 )
{
    param notify( param1 );
}

// Namespace bgb_machine
// Params 4
// Checksum 0xba705892, Offset: 0x857
// Size: 0x44
function function_f44f6d2718717e85( param, param1, param2, param3 )
{
    param notify( param1 );
    param.bgb_machine_open = 0;
    param.bgb_machine_user = undefined;
}

// Namespace bgb_machine
// Params 0
// Checksum 0xf78df780, Offset: 0x8a3
// Size: 0xa2
function init_bgb_postmain()
{
    level endon( #"game_ended" );
    waittillframeend();
    wait 1;
    var_62638af37653ded7 = utility::getstructarray( "content_destination", "variantname" );
    
    foreach ( destination in var_62638af37653ded7 )
    {
        level thread function_87db80cae32e52f6( destination );
    }
}

// Namespace bgb_machine
// Params 2
// Checksum 0x96f94bc0, Offset: 0x94d
// Size: 0x121
function function_87db80cae32e52f6( destination, str_currency )
{
    foreach ( location in destination.locations )
    {
        bgb_instance = location.instances[ "bgb" ];
        
        if ( isdefined( bgb_instance ) )
        {
            foreach ( instance in bgb_instance.versions )
            {
                content_manager::function_67e4b7678fb21e11( instance );
            }
        }
    }
}

/#

    // Namespace bgb_machine
    // Params 0, eflags: 0x4
    // Checksum 0x64b326c4, Offset: 0xa76
    // Size: 0xe8, Type: dev
    function private setup_devgui()
    {
        self endon( #"disconnect" );
        wait 2;
        str_player_name = self.name;
        keys = getarraykeys( level.bgb );
        
        foreach ( key in keys )
        {
            devgui::function_9082edeb5db93280( "<dev string:x24>" + str_player_name + "<dev string:x2c>" );
            devgui::function_cd4e263c1f3018ae( "<dev string:x36>" + key, "<dev string:x4e>" + key + "<dev string:x67>" + str_player_name, &function_68434093887d0923 );
            devgui::function_77df7fe7dd273e10();
        }
    }

    // Namespace bgb_machine
    // Params 0, eflags: 0x4
    // Checksum 0x15cda056, Offset: 0xb66
    // Size: 0xa4, Type: dev
    function private function_fececb89b4284d71()
    {
        for ( ;; )
        {
            force_give = getdvar( "<dev string:x69>" );
            
            if ( getdvarint( "<dev string:x87>" ) || "<dev string:xa7>" != force_give )
            {
                for ( i = 0; i < level.players.size ; i++ )
                {
                    level.players[ i ].var_71280c614e54bce2 = 0;
                }
                
                setdvar( "<dev string:x87>", 0 );
            }
            
            if ( "<dev string:xa7>" != force_give )
            {
                level.var_d979bbf830bdd905 = force_give;
                setdvar( "<dev string:x69>", "<dev string:xa7>" );
            }
            
            wait 0.5;
        }
    }

    // Namespace bgb_machine
    // Params 1
    // Checksum 0x52ac40da, Offset: 0xc12
    // Size: 0x29, Type: dev
    function function_68434093887d0923( a_params )
    {
        var_66cc4d3d21a0ce0d = a_params[ 0 ];
        level.var_b188c2928a9d17e7 = var_66cc4d3d21a0ce0d;
    }

#/

// Namespace bgb_machine
// Params 2
// Checksum 0xbaf12ea9, Offset: 0xc43
// Size: 0x188
function function_9a3e81eb8357ad32( instance, bgb_machine_scriptable = "t10_zm_gobblegum_machine" )
{
    if ( getdvarint( @"hash_294f374ff45e6632" ) || getmatchrulesdata( "zmData", "disableBGB" ) )
    {
        return;
    }
    
    if ( !arraycontains( level.var_e0910c7bd4aab6fc, self ) )
    {
        level.var_e0910c7bd4aab6fc[ level.var_e0910c7bd4aab6fc.size ] = self;
    }
    
    self.str_scriptable = bgb_machine_scriptable;
    self.mdl_bgb_machine = spawnscriptable( self.str_scriptable, self.origin, self.angles );
    utility::callsharedfunc( #"scriptable", #"hash_10d5e3bb8a551724", self.mdl_bgb_machine, "icon" );
    self.script_currency = #"essence";
    self.script_cost = 100;
    self.mdl_bgb_machine.interact = interaction::register_scriptable_interact( self.mdl_bgb_machine, &on_use_bgb_machine );
    self.mdl_bgb_machine.interact interaction::set_interact_hint_callback( &function_9c5101ff52fa4cef );
    self.mdl_bgb_machine setscriptablepartstate( "base", "initial" );
    self.mdl_bgb_machine.interact.s_bgb_machine = self;
    self.mdl_bgb_machine utility::callsharedfunc( #"zombie", #"hash_896b88a46f6a4c15", "bgb" );
}

// Namespace bgb_machine
// Params 1
// Checksum 0x52c7421e, Offset: 0xdd3
// Size: 0x243
function on_use_bgb_machine( player )
{
    if ( player.interactions_disabled || player.bgb_machine_disabled )
    {
        return;
    }
    
    if ( player.var_cde87e02d2e3970f.size == 0 )
    {
        return;
    }
    
    if ( player isswitchingweapon() || player ismantling() || player isthrowinggrenade() || player israisingweapon() || player ismeleeing() || player isgestureplaying() )
    {
        return;
    }
    
    if ( player.var_fd68d41f12eb9022 )
    {
        return;
    }
    
    if ( !isdefined( player bgb::function_c0286238eba807() ) )
    {
        return;
    }
    
    s_bgb_machine = self.s_bgb_machine;
    
    if ( isdefined( self.bgb_machine_user ) && player != self.bgb_machine_user || self.disable_use )
    {
        return;
    }
    
    str_current_state = self getscriptablepartstate( "base" );
    
    switch ( str_current_state )
    {
        case #"hash_b14f86766516d0c3":
            if ( player.var_71280c614e54bce2 >= level.var_acc09d0960bca0cc || level.var_10c8ad612d031d9 && player.bgb_cooldown > 0 )
            {
                self setscriptablepartstate( "negative_audio", "on" );
                return;
            }
            
            function_714b45076a2319e( player );
            break;
        case #"hash_3123f5a774aade9":
        case #"hash_1cb1e2c607f60618":
        case #"hash_2c277b088a153dec":
        case #"hash_4a67267e2cab032a":
        case #"hash_62b3109944be5630":
        case #"hash_7754b375c159604f":
        case #"hash_977761f42424beeb":
        case #"hash_9d5aa1842bca8131":
        case #"hash_a9a609492901edac":
        case #"hash_c767ca05cc91d57f":
        case #"hash_d415588a0add6a44":
        case #"hash_d747fa3ff1b78b29":
        case #"hash_f99e07b8cbd667d7":
        case #"hash_fc7191c2a71973cb":
            if ( player bgb::function_494d09a33a97fefb( self.selected_bgb ) )
            {
                self setscriptablepartstate( "negative_audio", "on" );
                return;
            }
            
            function_55dd890484239b( player );
            break;
        case #"hash_1863e327e9ec881a":
            function_55dd890484239b( player );
            break;
    }
}

// Namespace bgb_machine
// Params 1, eflags: 0x4
// Checksum 0xbf37c7b9, Offset: 0x101e
// Size: 0x27
function private function_714b45076a2319e( player )
{
    utility::callsharedfunc( #"bgb_machine", #"hash_aafc637a8f249873", player );
}

// Namespace bgb_machine
// Params 1, eflags: 0x4
// Checksum 0x577b6b16, Offset: 0x104d
// Size: 0x160
function private function_6f595807679236a( player )
{
    var_f14f3d4ce5bae7cb = 0;
    var_4fb7ce6091228633 = 0;
    var_8cf5ff9f29be37c4 = 0;
    
    if ( self.var_8c58cdcaa8138341 )
    {
        if ( isdefined( level.bgb[ self.selected_bgb ] ) )
        {
            var_4fb7ce6091228633 = level.bgb[ self.selected_bgb ].item_index;
        }
        
        self notify( #"user_grabbed_bgb" );
        player notify( #"user_grabbed_bgb" );
        player bgb::function_4818e19472b65502( self.selected_bgb );
        var_f14f3d4ce5bae7cb = 1;
        player thread bgb::function_a5d37b16547199e4( self.selected_bgb, 0 );
        
        if ( isdefined( level.var_965e84f77f31a256 ) )
        {
            player thread [[ level.var_965e84f77f31a256 ]]( self );
        }
        else
        {
            player thread function_3822cb875c743205( self );
        }
        
        set_bgb_machine_state( "close" );
    }
    else
    {
        self notify( #"user_grabbed_bgb" );
        player notify( #"user_grabbed_bgb" );
        var_f14f3d4ce5bae7cb = 1;
        player thread bgb::function_a5d37b16547199e4( "mr_peeks", 0 );
        var_8cf5ff9f29be37c4 = 1;
        set_bgb_machine_state( "close" );
    }
    
    self.var_871b76b970146df8 = 0;
    wait 3;
    set_bgb_machine_state( "initial" );
    self.bgb_machine_open = 0;
    self.bgb_machine_user = undefined;
    self notify( #"bgb_machine_accessed" );
}

// Namespace bgb_machine
// Params 1, eflags: 0x4
// Checksum 0xe21380f5, Offset: 0x11b5
// Size: 0x14a
function private function_55dd890484239b( player )
{
    var_f14f3d4ce5bae7cb = 0;
    var_4fb7ce6091228633 = 0;
    var_8cf5ff9f29be37c4 = 0;
    
    if ( self.var_8c58cdcaa8138341 )
    {
        if ( isdefined( level.bgb[ self.selected_bgb ] ) )
        {
            var_4fb7ce6091228633 = level.bgb[ self.selected_bgb ].item_index;
        }
        
        self notify( #"user_grabbed_bgb" );
        player notify( #"user_grabbed_bgb" );
        player.allow_instant_bgb_pack_switching = 0;
        player notify( #"hash_3dad25c07d2f05d4" );
        var_f14f3d4ce5bae7cb = 1;
        player thread bgb::function_a5d37b16547199e4( self.selected_bgb, 0 );
        set_bgb_machine_state( "close" );
    }
    else
    {
        self notify( #"user_grabbed_bgb" );
        player notify( #"user_grabbed_bgb" );
        var_f14f3d4ce5bae7cb = 1;
        player thread bgb::function_a5d37b16547199e4( "mr_peeks", 1 );
        var_8cf5ff9f29be37c4 = 1;
        set_bgb_machine_state( "close" );
    }
    
    if ( isdefined( self ) )
    {
        self.var_871b76b970146df8 = 0;
    }
    
    wait 3;
    
    if ( isdefined( self ) )
    {
        set_bgb_machine_state( "initial" );
        self.bgb_machine_open = 0;
        self.bgb_machine_user = undefined;
        self notify( #"bgb_machine_accessed" );
    }
}

// Namespace bgb_machine
// Params 2, eflags: 0x4
// Checksum 0x2e10a9fd, Offset: 0x1307
// Size: 0x71a
function private function_9c5101ff52fa4cef( usable, player )
{
    bgb = usable.selected_bgb;
    
    if ( player.interactions_disabled || usable.disable_use || player.bgb_machine_disabled || player.var_fd68d41f12eb9022 )
    {
        return { #string:&"", #type:"HINT_NOICON" };
    }
    
    if ( player.var_cde87e02d2e3970f.size == 0 )
    {
        obj = { #interactable:0, #icon:level.var_4947e9c773e6417d, #aux_text:&"CP_ZMB/BGB_MACHINE_EMPTY", #description:&"CP_ZMB/BGB_MACHINE_AVAILABLE_FREE", #title:&"CP_ZMB/BGB_MACHINE_MAIN_TITLE", #type:"HINT_BUTTON" };
        return obj;
    }
    
    if ( player ismantling() || player isthrowinggrenade() || player ismeleeing() || player isgestureplaying() )
    {
        return { #string:&"", #type:"HINT_NOICON" };
    }
    
    if ( isdefined( usable.bgb_machine_user ) && player != usable.bgb_machine_user )
    {
        obj = { #interactable:0, #icon:level.var_4947e9c773e6417d, #aux_text:&"CP_ZMB/BGB_MACHINE_IN_USE", #description:&"CP_ZMB/BGB_MACHINE_AVAILABLE_FREE", #title:&"CP_ZMB/BGB_MACHINE_MAIN_TITLE", #type:"HINT_BUTTON" };
        return obj;
    }
    
    if ( usable.var_871b76b970146df8 )
    {
        if ( !usable.var_8c58cdcaa8138341 )
        {
            bgb = level.gobblegums[ getxhash( "mr_peeks" ) ];
            obj = { #icon:bgb.icon, #description:bgb.machineprompt, #title:bgb.name, #buttoncallout:&"CP_ZMB/BGB_MACHINE_TAKE", #params:bgb.machineprompt, #string:bgb.machineprompt, #type:"HINT_BUTTON" };
            return obj;
        }
        else if ( player bgb::function_494d09a33a97fefb( bgb ) )
        {
            if ( isdefined( player.var_48081f882523254d[ bgb ] ) )
            {
                var_1a5ca312de3c35df = player.var_48081f882523254d[ bgb ].var_842e3f6ee3ebdb08;
                var_8746e07bf52b6830 = player.var_48081f882523254d[ bgb ].var_d2ccdc3b4353d23b;
                var_a69066f372ada233 = var_1a5ca312de3c35df - var_8746e07bf52b6830;
            }
            else
            {
                var_a69066f372ada233 = 99;
            }
            
            bgb = level.gobblegums[ getxhash( bgb ) ];
            
            if ( isdefined( bgb ) )
            {
                obj = { #var_8ecfcc016840d7d6:var_a69066f372ada233, #show_amount:1, #interactable:0, #icon:bgb.icon, #aux_text:&"CP_ZMB/BGB_MACHINE_DUPE", #description:bgb.machineprompt, #title:bgb.name, #type:"HINT_BUTTON" };
            }
            else
            {
                obj = { #interactable:0, #icon:level.var_4947e9c773e6417d, #aux_text:&"CP_ZMB/BGB_MACHINE_DUPE", #description:&"CP_ZMB/BGB_MACHINE_AVAILABLE_FREE", #title:&"CP_ZMB/BGB_MACHINE_MAIN_TITLE", #type:"HINT_BUTTON" };
            }
            
            return obj;
        }
        else
        {
            if ( isdefined( player.var_48081f882523254d[ bgb ] ) )
            {
                var_1a5ca312de3c35df = player.var_48081f882523254d[ bgb ].var_842e3f6ee3ebdb08;
                var_8746e07bf52b6830 = player.var_48081f882523254d[ bgb ].var_d2ccdc3b4353d23b;
                var_a69066f372ada233 = var_1a5ca312de3c35df - var_8746e07bf52b6830;
            }
            else
            {
                var_a69066f372ada233 = 99;
            }
            
            bgb = level.gobblegums[ getxhash( bgb ) ];
            obj = { #var_8ecfcc016840d7d6:var_a69066f372ada233, #show_amount:1, #icon:bgb.icon, #description:bgb.machineprompt, #title:bgb.name, #buttoncallout:&"CP_ZMB/BGB_MACHINE_TAKE", #params:bgb.machineprompt, #string:bgb.machineprompt, #type:"HINT_BUTTON" };
            return obj;
        }
        
        return;
    }
    
    if ( player.var_71280c614e54bce2 < level.var_acc09d0960bca0cc && ( !level.var_10c8ad612d031d9 || player.bgb_cooldown <= 0 ) )
    {
        if ( isdefined( player bgb::function_c0286238eba807() ) )
        {
            obj = { #icon:level.var_4947e9c773e6417d, #buttoncallout:&"SHARED_HINTSTRINGS/USE", #description:&"CP_ZMB/BGB_MACHINE_AVAILABLE_FREE", #title:&"CP_ZMB/BGB_MACHINE_MAIN_TITLE", #params:[ function_390979b4e3f992d5( player ) ], #string:&"CP_ZMB/BGB_MACHINE_AVAILABLE_FREE", #type:"HINT_BUTTON" };
            return obj;
        }
        else
        {
            obj = { #interactable:0, #icon:level.var_4947e9c773e6417d, #aux_text:&"CP_ZMB/BGB_MACHINE_FULL", #description:&"CP_ZMB/BGB_MACHINE_AVAILABLE_FREE", #title:&"CP_ZMB/BGB_MACHINE_MAIN_TITLE", #type:"HINT_BUTTON" };
            return obj;
        }
        
        return;
    }
    
    if ( player.bgb_cooldown == -1 )
    {
        return { #string:&"", #type:"HINT_NOICON" };
    }
    
    time_left = player.bgb_cooldown;
    obj = { #interactable:0, #icon_text_value:time_left, #var_776a268784e089af:&"CP_ZMB/BGB_MACHINE_COOLDOWN_TIME", #icon:level.var_4947e9c773e6417d, #aux_text:&"CP_ZMB/BGB_MACHINE_COOLDOWN", #description:&"CP_ZMB/BGB_MACHINE_AVAILABLE_FREE", #title:&"CP_ZMB/BGB_MACHINE_MAIN_TITLE", #type:"HINT_BUTTON" };
    return obj;
}

// Namespace bgb_machine
// Params 2
// Checksum 0x6054fb8d, Offset: 0x1a29
// Size: 0x31
function function_390979b4e3f992d5( player, base_cost )
{
    utility::callsharedfunc( #"bgb_machine", #"hash_de9e76cf8acd3fb6", player, base_cost );
}

// Namespace bgb_machine
// Params 1
// Checksum 0x336eeebf, Offset: 0x1a62
// Size: 0x1e9, Type: bool
function function_7a24f6084a281eac( player )
{
    if ( !player.var_3435b1427f82ce41.size )
    {
        player.var_3435b1427f82ce41 = arrayrandomize( player.var_cde87e02d2e3970f );
        
        foreach ( bgb in player.var_b02f6e7abbbc8a84 )
        {
            player.var_3435b1427f82ce41 = arrayremove( player.var_3435b1427f82ce41, bgb );
        }
        
        if ( getdvarint( @"hash_a7dd6191064a0709", 1 ) && !isdefined( player.var_7cf09ee6d08a8b07 ) )
        {
            player.var_7cf09ee6d08a8b07 = 1;
            
            if ( player.var_cde87e02d2e3970f.size > 3 )
            {
                for ( x = 0; x < 3 ; x++ )
                {
                    if ( player.var_3435b1427f82ce41.size > 1 )
                    {
                        player.var_3435b1427f82ce41 = arrayremove( player.var_3435b1427f82ce41, player.var_cde87e02d2e3970f[ x ] );
                    }
                }
            }
        }
    }
    
    if ( !player.var_3435b1427f82ce41.size )
    {
        self.selected_bgb = undefined;
        return false;
    }
    
    self.selected_bgb = player.var_3435b1427f82ce41[ 0 ];
    
    if ( isdefined( level.var_b188c2928a9d17e7 ) )
    {
        self.selected_bgb = level.var_b188c2928a9d17e7;
        level.var_b188c2928a9d17e7 = undefined;
    }
    else
    {
        player.var_3435b1427f82ce41[ 0 ] = undefined;
        function_cdc669dbc8ea2101( player.var_3435b1427f82ce41 );
    }
    
    return player bgb::function_e2d5ed5687ea5bc2( self.selected_bgb );
}

// Namespace bgb_machine
// Params 0
// Checksum 0x14d44fa9, Offset: 0x1c54
// Size: 0xe
function function_64152131be4eef88()
{
    self endon( #"zbarrier_state_change" );
}

// Namespace bgb_machine
// Params 0
// Checksum 0x14491b0c, Offset: 0x1c6a
// Size: 0x12
function bgb_machine_initial()
{
    self setscriptablepartstate( "base", "initial" );
}

// Namespace bgb_machine
// Params 0
// Checksum 0x7ad26585, Offset: 0x1c84
// Size: 0x6ea
function function_63033d42fc9d6e91()
{
    self endon( #"zbarrier_state_change", #"death" );
    self.disable_use = 1;
    bgb = self.selected_bgb;
    
    if ( !isdefined( level.bgb[ bgb ] ) )
    {
        self.var_8c58cdcaa8138341 = 0;
    }
    
    state = "opening";
    
    if ( !self.var_8c58cdcaa8138341 )
    {
        self setscriptablepartstate( "base", "present_white" );
    }
    else
    {
        switch ( level.bgb[ bgb ].rarity )
        {
            case #"hash_c81e81c97be2c6a8":
                switch ( level.bgb[ bgb ].var_882452eafdaa1626 )
                {
                    case #"hash_d9a7b65f9477385c":
                        self setscriptablepartstate( "base", "present_purple_swirl" );
                        break;
                    case #"hash_a77aa76e7d308f7f":
                        self setscriptablepartstate( "base", "present_purple_speck" );
                        break;
                    case #"hash_4f89286e3448ad44":
                    case #"hash_d80a36cf43c842b8":
                        self setscriptablepartstate( "base", "present_purple" );
                        break;
                    default:
                        self setscriptablepartstate( "base", "present_purple" );
                        break;
                }
                
                break;
            case #"hash_9f79c9fc1aa660aa":
                switch ( level.bgb[ bgb ].var_882452eafdaa1626 )
                {
                    case #"hash_d9a7b65f9477385c":
                        self setscriptablepartstate( "base", "present_orange_swirl" );
                        break;
                    case #"hash_a77aa76e7d308f7f":
                        self setscriptablepartstate( "base", "present_orange_speck" );
                        break;
                    case #"hash_4f89286e3448ad44":
                    case #"hash_d80a36cf43c842b8":
                        self setscriptablepartstate( "base", "present_orange" );
                        break;
                    default:
                        self setscriptablepartstate( "base", "present_orange" );
                        break;
                }
                
                break;
            case #"hash_ca3e413b1500d035":
                switch ( level.bgb[ bgb ].var_882452eafdaa1626 )
                {
                    case #"hash_d9a7b65f9477385c":
                        self setscriptablepartstate( "base", "present_red_swirl" );
                        break;
                    case #"hash_a77aa76e7d308f7f":
                        self setscriptablepartstate( "base", "present_red_speck" );
                        break;
                    case #"hash_4f89286e3448ad44":
                    case #"hash_d80a36cf43c842b8":
                        self setscriptablepartstate( "base", "present_red" );
                        break;
                    default:
                        self setscriptablepartstate( "base", "present_red" );
                        break;
                }
                
                break;
            case #"hash_b8ce55e0f7e8f868":
                self setscriptablepartstate( "base", "present_whimsical" );
                break;
            default:
                switch ( level.bgb[ bgb ].var_882452eafdaa1626 )
                {
                    case #"hash_d9a7b65f9477385c":
                        self setscriptablepartstate( "base", "present_blue_swirl" );
                        break;
                    case #"hash_a77aa76e7d308f7f":
                        self setscriptablepartstate( "base", "present_blue_speck" );
                        break;
                    case #"hash_4f89286e3448ad44":
                    case #"hash_d80a36cf43c842b8":
                        self setscriptablepartstate( "base", "present_blue" );
                        break;
                    default:
                        self setscriptablepartstate( "base", "present_blue" );
                        break;
                }
                
                break;
        }
    }
    
    self waittill( #"gumball_available" );
    self.disable_use = undefined;
    wait 5.5;
    self.var_871b76b970146df8 = 0;
    
    if ( !self.var_8c58cdcaa8138341 )
    {
        self setscriptablepartstate( "base", "close_to_initial_white" );
        return;
    }
    
    switch ( level.bgb[ bgb ].rarity )
    {
        case #"hash_c81e81c97be2c6a8":
            switch ( level.bgb[ bgb ].var_882452eafdaa1626 )
            {
                case #"hash_d9a7b65f9477385c":
                    self setscriptablepartstate( "base", "close_to_initial_purple_swirl" );
                    break;
                case #"hash_a77aa76e7d308f7f":
                    self setscriptablepartstate( "base", "close_to_initial_purple_speck" );
                    break;
                case #"hash_4f89286e3448ad44":
                case #"hash_d80a36cf43c842b8":
                    self setscriptablepartstate( "base", "close_to_initial_purple" );
                    break;
                default:
                    self setscriptablepartstate( "base", "close_to_initial_purple" );
                    break;
            }
            
            break;
        case #"hash_9f79c9fc1aa660aa":
            switch ( level.bgb[ bgb ].var_882452eafdaa1626 )
            {
                case #"hash_d9a7b65f9477385c":
                    self setscriptablepartstate( "base", "close_to_initial_orange_swirl" );
                    break;
                case #"hash_a77aa76e7d308f7f":
                    self setscriptablepartstate( "base", "close_to_initial_orange_speck" );
                    break;
                case #"hash_4f89286e3448ad44":
                case #"hash_d80a36cf43c842b8":
                    self setscriptablepartstate( "base", "close_to_initial_orange" );
                    break;
                default:
                    self setscriptablepartstate( "base", "close_to_initial_orange" );
                    break;
            }
            
            break;
        case #"hash_ca3e413b1500d035":
            switch ( level.bgb[ bgb ].var_882452eafdaa1626 )
            {
                case #"hash_d9a7b65f9477385c":
                    self setscriptablepartstate( "base", "close_to_initial_red_swirl" );
                    break;
                case #"hash_a77aa76e7d308f7f":
                    self setscriptablepartstate( "base", "close_to_initial_red_speck" );
                    break;
                case #"hash_4f89286e3448ad44":
                case #"hash_d80a36cf43c842b8":
                    self setscriptablepartstate( "base", "close_to_initial_red" );
                    break;
                default:
                    self setscriptablepartstate( "base", "close_to_initial_red" );
                    break;
            }
            
            break;
        case #"hash_b8ce55e0f7e8f868":
            self setscriptablepartstate( "base", "close_to_initial_whimsical" );
            break;
        default:
            switch ( level.bgb[ bgb ].var_882452eafdaa1626 )
            {
                case #"hash_d9a7b65f9477385c":
                    self setscriptablepartstate( "base", "close_to_initial_blue_swirl" );
                    break;
                case #"hash_a77aa76e7d308f7f":
                    self setscriptablepartstate( "base", "close_to_initial_blue_speck" );
                    break;
                case #"hash_4f89286e3448ad44":
                case #"hash_d80a36cf43c842b8":
                    self setscriptablepartstate( "base", "close_to_initial_blue" );
                    break;
                default:
                    self setscriptablepartstate( "base", "close_to_initial_blue" );
                    break;
            }
            
            break;
    }
}

// Namespace bgb_machine
// Params 0
// Checksum 0x4676a1f1, Offset: 0x2376
// Size: 0x2a
function function_36bdfdbc5c7ec1e5()
{
    self endon( #"zbarrier_state_change" );
    self setscriptablepartstate( "base", "close" );
    self notify( #"closed" );
}

// Namespace bgb_machine
// Params 0
// Checksum 0xf0bd434c, Offset: 0x23a8
// Size: 0x2a
function function_977da7c1f984abe8()
{
    self endon( #"zbarrier_state_change" );
    self setscriptablepartstate( "base", "close_to_initial" );
    self notify( #"closed" );
}

// Namespace bgb_machine
// Params 0
// Checksum 0x26954d99, Offset: 0x23da
// Size: 0x2f, Type: bool
function is_bgb_machine_active()
{
    curr_state = get_bgb_machine_state();
    
    if ( curr_state == "open" || curr_state == "close" )
    {
        return true;
    }
    
    return false;
}

// Namespace bgb_machine
// Params 0
// Checksum 0x19af9077, Offset: 0x2412
// Size: 0xb
function get_bgb_machine_state()
{
    return self.state;
}

// Namespace bgb_machine
// Params 1
// Checksum 0x1f3ff66e, Offset: 0x2426
// Size: 0x27
function set_bgb_machine_state( state )
{
    self notify( #"zbarrier_state_change" );
    self [[ level.var_ce60e7e0143b25c8 ]]( state );
}

// Namespace bgb_machine
// Params 1
// Checksum 0x9b929c55, Offset: 0x2455
// Size: 0xff
function function_125a6162339940bb( state )
{
    switch ( state )
    {
        case #"hash_af80d61e7df698bb":
            thread function_64152131be4eef88();
            self.state = "away";
            break;
        case #"hash_b14f86766516d0c3":
            thread bgb_machine_initial();
            self.disable_use = undefined;
            self.state = "initial";
            break;
        case #"hash_d747fa3ff1b78b29":
            thread function_63033d42fc9d6e91();
            self.state = "open";
            break;
        case #"hash_a140edb8b517af03":
            thread function_36bdfdbc5c7ec1e5();
            self.state = "close";
            break;
        case #"hash_dba20d385d8cc1f2":
            thread function_977da7c1f984abe8();
            self.state = "close_to_initial";
            break;
        default:
            if ( isdefined( level.var_c4208348ddc14c9a ) )
            {
                self [[ level.var_c4208348ddc14c9a ]]( state );
            }
            
            break;
    }
}

// Namespace bgb_machine
// Params 1
// Checksum 0x34d86c3d, Offset: 0x255c
// Size: 0xc
function function_3822cb875c743205( var_75385495715741fb )
{
    
}

// Namespace bgb_machine
// Params 0, eflags: 0x4
// Checksum 0x1be1be3b, Offset: 0x2570
// Size: 0x10, Type: bool
function private get_cooldown_time()
{
    return level.var_df8540d653dfeb87 ?? 10;
}

// Namespace bgb_machine
// Params 0
// Checksum 0xaaab8b80, Offset: 0x2589
// Size: 0x6b
function cooldown_timer()
{
    self endon( #"disconnect" );
    self endon( #"hash_ebc09e8558d2c7d7" );
    var_f3f58290156b52c = get_cooldown_time();
    self.bgb_cooldown = var_f3f58290156b52c;
    
    while ( self.bgb_cooldown >= 0 )
    {
        wait 1;
        self.bgb_cooldown--;
    }
    
    self.bgb_cooldown = -1;
    waitframe();
    self.var_71280c614e54bce2 = 0;
}

// Namespace bgb_machine
// Params 1
// Checksum 0x98aee156, Offset: 0x25fc
// Size: 0x42
function on_bgb_disabled( s_feature )
{
    bgb_machine = s_feature.mdl_bgb_machine;
    bgb_machine setscriptablepartstate( "audio_jingle", "off" );
    bgb_machine.disable_use = 1;
}

// Namespace bgb_machine
// Params 1
// Checksum 0xfb0b553b, Offset: 0x2646
// Size: 0x3f
function function_95b01af0a0c71fd( s_feature )
{
    bgb_machine = s_feature.mdl_bgb_machine;
    bgb_machine setscriptablepartstate( "audio_jingle", "wait" );
    bgb_machine.disable_use = undefined;
}

