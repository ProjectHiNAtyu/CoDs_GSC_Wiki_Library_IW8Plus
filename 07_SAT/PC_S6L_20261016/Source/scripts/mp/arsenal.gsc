// scripts\mp\arsenal.gsc  (hash_46fecad419c065b2.gscc) (size: 22407 Bytes / 0x5787 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1e099667 (503944807)
// size ...... 22407 (0x5787)
// includes .. 18  (offset: 0x5187)
// strings ... 68  (offset: 0x5217)
// dev strs .. 33  (offset: 0x55e7)
// exports ... 50  (offset: 0x3637)
// cseg ...... 0x596 + 0x30a1 (0x3637)
// imports ... 162 (offset: 0x3e07)
// animtree1 . 0   (offset: 0x5787)
// animtree2 . 0   (offset: 0x5787)
#using script_4519eff181e91bd3;
#using scripts\anim\dialogue;
#using scripts\common\ai\aitypes\shared\zombie\zombie_damage;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\ammomods\ammo_mod;
#using scripts\mp\armor;
#using scripts\mp\common\utility\lui_game_event_aggregator;
#using scripts\mp\content_manager;
#using scripts\mp\currency;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\overlord;
#using scripts\mp\player_banter;
#using scripts\mp\purchasemenu;

#namespace arsenal;

// Namespace arsenal
// Params 0
// Checksum 0xb8798db7, Offset: 0x5b4
// Size: 0xe5
function init_arsenal()
{
    /#
        level thread setup_arsenal_devgui();
    #/
    
    level.var_52e94a468e66d601 = [];
    content_manager::function_3209da123476142f( "arsenal", &on_spawn_arsenal );
    callback::add( #"player_spawned", &on_player_spawned );
    callback::add( #"player_death", &on_player_killed );
    level.arsenal_menu = ZMArsenalMenu::register();
    level.arsenal_menu.var_9f580747e43b5ccc = function_253e2c5a80b10f62();
    level.var_48e2b36291b57f44 = 4;
    utility::registersharedfunc( #"arsenal", #"disable_arsenal", &disable_arsenal );
    utility::registersharedfunc( #"arsenal", #"enable_arsenal", &enable_arsenal );
    content_manager::register_disable_toggle( "arsenal", &content_manager::function_5d04e50a29a2142c, &function_66ae88df813c61b, &function_885bbb1069e6ba30 );
    level thread init_arsenal_postmain();
}

// Namespace arsenal
// Params 1
// Checksum 0x8e2ca096, Offset: 0x6a1
// Size: 0x1b7
function on_player_spawned( params )
{
    level utility::flag_set( "init_arsenal_animation" );
    
    /#
        self endon( #"disconnect" );
        wait 3;
        devgui::function_9082edeb5db93280( "<dev string:x24>" + self.name + "<dev string:x47>" );
        
        foreach ( s_arsenal in level.var_52e94a468e66d601 )
        {
            devgui::function_cd4e263c1f3018ae( s_arsenal.name, "<dev string:x49>" + s_arsenal.name + "<dev string:x5e>" + self.name, &function_2563e140939b24a7 );
        }
        
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x60>" + self.name + "<dev string:x47>" );
        
        foreach ( s_arsenal in level.var_52e94a468e66d601 )
        {
            devgui::function_cd4e263c1f3018ae( s_arsenal.name, "<dev string:x88>" + s_arsenal.name + "<dev string:x5e>" + self.name, &function_fe5ec4be5eff554e );
        }
        
        devgui::function_77df7fe7dd273e10();
    #/
}

// Namespace arsenal
// Params 1, eflags: 0x4
// Checksum 0xa872049c, Offset: 0x860
// Size: 0x30
function private on_player_killed( deathdata )
{
    if ( level.arsenal_menu ZMArsenalMenu::is_open( self ) )
    {
        level.arsenal_menu ZMArsenalMenu::close( self );
    }
}

/#

    // Namespace arsenal
    // Params 0
    // Checksum 0x70da0a55, Offset: 0x898
    // Size: 0x5c, Type: dev
    function setup_arsenal_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:xa2>" );
        devgui::add_devgui_func( "<dev string:xb1>", "<dev string:xc5>", &function_ee23975dc86a65e4, 1 );
        devgui::add_devgui_func( "<dev string:xd9>", "<dev string:xf1>", &function_fca7ffafce5a4fa7 );
        devgui::add_devgui_func( "<dev string:x109>", "<dev string:x120>", &function_70f00d07928d63b8 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace arsenal
    // Params 1, eflags: 0x4
    // Checksum 0x95fedb07, Offset: 0x8fc
    // Size: 0x13f, Type: dev
    function private function_2563e140939b24a7( params )
    {
        s_arsenal = undefined;
        
        foreach ( s_arsenal in level.var_52e94a468e66d601 )
        {
            if ( s_arsenal.name == params[ 0 ] )
            {
                foreach ( player in level.players )
                {
                    if ( player.name == params[ 1 ] )
                    {
                        player.b_close_arsenal = undefined;
                        s_arsenal.mdl_arsenal.interact on_use_arsenal( player );
                        return;
                    }
                }
            }
        }
    }

    // Namespace arsenal
    // Params 1, eflags: 0x4
    // Checksum 0x10d1a567, Offset: 0xa43
    // Size: 0x133, Type: dev
    function private function_fe5ec4be5eff554e( params )
    {
        s_arsenal = undefined;
        
        foreach ( s_arsenal in level.var_52e94a468e66d601 )
        {
            if ( s_arsenal.name == params[ 0 ] )
            {
                foreach ( player in level.players )
                {
                    if ( player.name == params[ 1 ] )
                    {
                        if ( isdefined( player.s_arsenal_machine ) )
                        {
                            player.b_close_arsenal = 1;
                        }
                        
                        return;
                    }
                }
            }
        }
    }

    // Namespace arsenal
    // Params 0, eflags: 0x4
    // Checksum 0x26c72a93, Offset: 0xb7e
    // Size: 0x75, Type: dev
    function private function_70f00d07928d63b8()
    {
        foreach ( player in level.players )
        {
        }
    }

    // Namespace arsenal
    // Params 0, eflags: 0x4
    // Checksum 0x7add8603, Offset: 0xbfb
    // Size: 0x7e, Type: dev
    function private function_fca7ffafce5a4fa7()
    {
        foreach ( s_arsenal_info in level.var_52e94a468e66d601 )
        {
            s_arsenal_info enable_arsenal();
        }
    }

#/

// Namespace arsenal
// Params 0
// Checksum 0x88ab2c24, Offset: 0xc81
// Size: 0xae
function init_arsenal_postmain()
{
    level endon( #"game_ended" );
    waittillframeend();
    wait 1;
    var_62638af37653ded7 = utility::getstructarray( "content_destination", "variantname" );
    
    foreach ( destination in var_62638af37653ded7 )
    {
        level thread function_6878dd3a690a54eb( destination );
    }
    
    lui_game_event_aggregator::registeronluieventcallback( &arsenal_menu_purchase );
}

// Namespace arsenal
// Params 1
// Checksum 0x19445cb9, Offset: 0xd37
// Size: 0x118
function function_6878dd3a690a54eb( destination )
{
    foreach ( location in destination.locations )
    {
        arsenal_instance = location.instances[ "arsenal" ];
        
        if ( isdefined( arsenal_instance ) )
        {
            foreach ( instance in arsenal_instance.versions )
            {
                content_manager::function_67e4b7678fb21e11( instance );
            }
        }
    }
}

// Namespace arsenal
// Params 1, eflags: 0x4
// Checksum 0x34f8c178, Offset: 0xe57
// Size: 0x10d
function private on_spawn_arsenal( instance )
{
    level.var_52e94a468e66d601 = arraycombine( level.var_52e94a468e66d601, instance.var_1d6cddfc47031bff[ "arsenal_spawn" ] );
    var_7b60dba2a92a7c40 = [];
    
    foreach ( s_arsenal_info in level.var_52e94a468e66d601 )
    {
        if ( s_arsenal_info content_manager::function_e0f0562adcd2c071() )
        {
            s_arsenal_info.var_93e4a0a8514ca47e = instance.location.destination.targetname;
            s_arsenal_info init_arsenal_machine( instance );
            var_7b60dba2a92a7c40[ var_7b60dba2a92a7c40.size ] = s_arsenal_info;
        }
    }
    
    level.var_52e94a468e66d601 = var_7b60dba2a92a7c40;
    level utility::flag_set( "arsenal_ready" );
}

// Namespace arsenal
// Params 1
// Checksum 0xa08accd, Offset: 0xf6c
// Size: 0x2db
function init_arsenal_machine( instance )
{
    self.var_36b33d34317dbcc0 = level.gamemodebundle.arsenalmodel ?? "t10_zm_weapon_machine_fxanim";
    
    if ( !isdefined( self.radius ) )
    {
        self.radius = 82;
    }
    
    if ( !isdefined( level.var_dd87f84422cade8a ) )
    {
        level.var_dd87f84422cade8a = 0;
    }
    
    self.name = self.targetname ?? "ARSENAL_" + level.var_dd87f84422cade8a;
    level.var_dd87f84422cade8a++;
    self.var_36b33d34317dbcc0 = get_machine_model_override( self.var_36b33d34317dbcc0 );
    self.mdl_arsenal = content_manager::spawn_script_model( self, self.var_36b33d34317dbcc0, 1, 1 );
    var_818bf2e54a2c76cf = utility::callsharedfunc( #"arsenal", #"hash_713b8231d6897f0c", self );
    
    if ( var_818bf2e54a2c76cf )
    {
        vo_src = spawn( "script_origin", self.mdl_arsenal.origin + ( 0, 0, 60 ) );
        vo_src linkto( self.mdl_arsenal );
        self.mdl_arsenal.vo_src = vo_src;
    }
    
    assert( self.mdl_arsenal isscriptable(), "<dev string:x137>" );
    utility::callsharedfunc( #"scriptable", #"hash_10d5e3bb8a551724", self.mdl_arsenal, "icon" );
    forward = anglestoforward( self.mdl_arsenal.angles );
    forward = vectornormalize( forward );
    forward *= 25;
    arsenal_interact_pos = self.mdl_arsenal.origin + forward;
    arsenal_interact_pos = ( arsenal_interact_pos[ 0 ], arsenal_interact_pos[ 1 ], arsenal_interact_pos[ 2 ] + 30 );
    scriptable_use = spawnscriptable( "t10_zm_arsenal_scriptable_use", arsenal_interact_pos, self.mdl_arsenal.angles );
    self.mdl_arsenal.interact = interaction::register_scriptable_interact( scriptable_use, &on_use_arsenal, undefined, undefined, &arsenal_per_player_hint );
    self.mdl_arsenal.interact interaction::function_3d5329c553924b3();
    self.mdl_arsenal.interact.s_arsenal = self;
    level utility::flag_wait( "init_arsenal_animation" );
    
    if ( self.script_start )
    {
        enable_arsenal( 1 );
    }
    else
    {
        disable_arsenal( 1 );
        thread function_4d8feee6604bd4fc();
    }
    
    callback::callback( #"hash_4748a46076e129e0" );
    self.mdl_arsenal utility::callsharedfunc( #"zombie", #"hash_896b88a46f6a4c15", "arsenal" );
}

// Namespace arsenal
// Params 0
// Checksum 0x1a062ace, Offset: 0x124f
// Size: 0x28
function function_4d8feee6604bd4fc()
{
    if ( isdefined( self.script_power ) )
    {
        utility::flag_wait( self.script_power );
    }
    
    enable_arsenal( 1 );
}

// Namespace arsenal
// Params 2
// Checksum 0xfd4c25d6, Offset: 0x127f
// Size: 0x229
function disable_arsenal( b_immediate, to_disabled = 0 )
{
    if ( isdefined( self.mdl_arsenal ) && self.mdl_arsenal isscriptable() )
    {
        self.mdl_arsenal.interact function_b89fcbc846cfa117( 0 );
        self.mdl_arsenal utility::function_7c10ea82c1e305b8( "anim", "power_off" );
        
        if ( to_disabled )
        {
            self.mdl_arsenal utility::function_7c10ea82c1e305b8( "audio_oneshots", "disabled" );
            self.mdl_arsenal utility::function_7c10ea82c1e305b8( "icon", "disabled" );
            self.mdl_arsenal utility::function_7c10ea82c1e305b8( "base", "arsenal_static" );
            
            foreach ( player in level.players )
            {
                if ( !level.arsenal_menu ZMArsenalMenu::is_open( player ) )
                {
                    continue;
                }
                
                if ( player.s_arsenal_machine != self )
                {
                    continue;
                }
                
                player.b_close_arsenal = 1;
            }
            
            self.mdl_arsenal dialogue::stop_dialogue( 1, 1 );
            self.mdl_arsenal.vo_disabled = 1;
        }
        
        self.var_5929513b9515fde7 = undefined;
        
        if ( self.mdl_arsenal isscriptable() )
        {
            if ( b_immediate )
            {
            }
        }
        
        var_ce9abe55c6bc6c75 = level.gamemodebundle.arsenalmodel ?? %"t10_zm_weapon_machine_off_fxanim";
        var_ce9abe55c6bc6c75 = get_machine_model_override( var_ce9abe55c6bc6c75 );
        
        if ( level.zm_mode_modifiers.var_e07d21157dd37afb && self.mdl_arsenal.b_forced_off_model )
        {
            return;
        }
        
        self.mdl_arsenal setmodel( var_ce9abe55c6bc6c75 );
    }
}

// Namespace arsenal
// Params 1
// Checksum 0x474a0d5d, Offset: 0x14b0
// Size: 0x14a
function enable_arsenal( b_immediate )
{
    if ( level.zm_mode_modifiers.var_e07d21157dd37afb )
    {
        return;
    }
    
    if ( isdefined( self.mdl_arsenal ) )
    {
        self.var_5929513b9515fde7 = 1;
        
        if ( self.mdl_arsenal isscriptable() )
        {
            self.mdl_arsenal setscriptablepartstate( "anim", "power_on" );
            
            if ( b_immediate )
            {
                self.mdl_arsenal setscriptablepartstate( "base", "arsenal_idle" );
                self.mdl_arsenal.interact function_b89fcbc846cfa117( 1 );
            }
            else
            {
                var_a6a35d3f2253bf4a = 4.1;
                self.mdl_arsenal setscriptablepartstate( "base", "arsenal_activate" );
                self.mdl_arsenal.interact utility::delaythread( var_a6a35d3f2253bf4a, &function_b89fcbc846cfa117, 1 );
            }
        }
        
        var_9abbb2e5c783ad39 = level.gamemodebundle.arsenalmodel ?? %"t10_zm_weapon_machine_fxanim";
        var_9abbb2e5c783ad39 = get_machine_model_override( var_9abbb2e5c783ad39 );
        self.mdl_arsenal setmodel( var_9abbb2e5c783ad39 );
        self.mdl_arsenal.vo_disabled = undefined;
        level thread function_9fa990dd730b5d11( self );
    }
}

// Namespace arsenal
// Params 1, eflags: 0x4
// Checksum 0xc15acea5, Offset: 0x1602
// Size: 0xe8
function private get_machine_model_override( model_name )
{
    mapinfo = getactivemapinfobundle();
    var_d2e325ed1ceba400 = mapinfo.var_4a98227bf6f428ba;
    
    if ( isarray( var_d2e325ed1ceba400 ) )
    {
        foreach ( var_232bf4cbe3e7f0ce in var_d2e325ed1ceba400 )
        {
            if ( var_232bf4cbe3e7f0ce.var_5d4a55e1eb574935 == model_name )
            {
                return var_232bf4cbe3e7f0ce.override;
            }
            
            if ( getxhashasset( var_232bf4cbe3e7f0ce.var_5d4a55e1eb574935 ) == model_name )
            {
                return getxhashasset( var_232bf4cbe3e7f0ce.override );
            }
        }
    }
    
    return model_name;
}

// Namespace arsenal
// Params 1
// Checksum 0xa5dcbcdf, Offset: 0x16f3
// Size: 0x3d
function function_b89fcbc846cfa117( var_6de6d054ee51a598 )
{
    var_6de6d054ee51a598 = var_6de6d054ee51a598 ?? 1;
    
    if ( var_6de6d054ee51a598 )
    {
        self setscriptablepartstate( "arsenal_use", "arsenal_on" );
        return;
    }
    
    self setscriptablepartstate( "arsenal_use", "arsenal_off" );
}

// Namespace arsenal
// Params 2
// Checksum 0x3c72839c, Offset: 0x1738
// Size: 0x151
function arsenal_per_player_hint( usable, player )
{
    if ( isdefined( player ) && isdefined( usable ) )
    {
        if ( isdefined( usable ) && isdefined( usable.s_arsenal ) )
        {
            obj = { #icon:"ui_icon_zm_ping_arsenal", #description:&"SHARED_HINTSTRINGS/ARSENAL_DESC", #title:&"SHARED_HINTSTRINGS/ARSENAL_TITLE", #buttoncallout:&"SHARED_HINTSTRINGS/ARSENAL_BUTTON_CALLOUT", #type:"HINT_BUTTON" };
            arsenal = usable.s_arsenal;
            
            if ( arsenal.var_5929513b9515fde7 )
            {
                if ( player.interactions_disabled || player.arsenal_disabled )
                {
                    return { #string:&"", #type:"HINT_NOICON" };
                }
                
                return obj;
            }
            else
            {
                obj.aux_text = usable.var_24bf1c43b9cd2254 ?? &"SHARED_HINTSTRINGS/NEED_POWER_RED";
                obj.interactable = 0;
                return obj;
            }
        }
    }
    
    return { #string:&"", #type:"HINT_BUTTON" };
}

// Namespace arsenal
// Params 1
// Checksum 0xa57e0a4d, Offset: 0x1892
// Size: 0x3a, Type: bool
function can_use_arsenal( player )
{
    if ( !isplayer( player ) )
    {
        return false;
    }
    
    if ( player.interactions_disabled )
    {
        return false;
    }
    
    if ( player.arsenal_disabled )
    {
        return false;
    }
    
    return true;
}

// Namespace arsenal
// Params 1
// Checksum 0x5cc8eea6, Offset: 0x18d5
// Size: 0x89
function on_use_arsenal( player )
{
    if ( !can_use_arsenal( player ) )
    {
        return;
    }
    
    self.s_arsenal.var_37f3a4cd8252c9f0 = player;
    player.s_arsenal_machine = self.s_arsenal;
    player thread function_e2011e06deabac27( self.s_arsenal );
    
    /#
        iprintlnbold( player.name + "<dev string:x174>" + self.s_arsenal.name + "<dev string:x17c>" );
    #/
}

// Namespace arsenal
// Params 0
// Checksum 0x765e4e85, Offset: 0x1966
// Size: 0xa
function function_de48127d5b3b7e8c()
{
    self setusableenabled( 1 );
}

// Namespace arsenal
// Params 2
// Checksum 0x3b4e015c, Offset: 0x1978
// Size: 0x3ac
function arsenal_menu_purchase( channel, var_1923b2b3afc076ba )
{
    if ( !isdefined( var_1923b2b3afc076ba ) )
    {
        return;
    }
    
    if ( channel == "arsenal_armor_purchase" )
    {
        var_9c657aff3a2d52cf = purchasemenu::get_purchasemenu( #"arsenal" );
        
        if ( !isdefined( var_9c657aff3a2d52cf ) )
        {
            return;
        }
        
        item = purchasemenu::create_item_struct( #"arsenal", var_1923b2b3afc076ba );
        response = craft_armor_tier( item );
        
        if ( response == 1 )
        {
            if ( isdefined( item.var_9281c8f5b1f3b37a ) )
            {
                self playsoundtoplayer( item.var_9281c8f5b1f3b37a, self );
            }
            
            if ( isdefined( self.s_arsenal_machine ) )
            {
                self.s_arsenal_machine.mdl_arsenal setscriptablepartstate( "anim", "armor_upgrade" );
            }
        }
        else if ( response == 3 )
        {
            if ( isdefined( item.var_ac7c10eb14c9d6e0 ) )
            {
                self playsoundtoplayer( item.var_ac7c10eb14c9d6e0, self );
            }
        }
        
        purchasemenu::function_93f934ea2f1c06f8( response );
        return;
    }
    
    if ( channel == "arsenal_tierupgrade_purchase" )
    {
        var_9c657aff3a2d52cf = purchasemenu::get_purchasemenu( #"arsenal" );
        
        if ( !isdefined( var_9c657aff3a2d52cf ) )
        {
            return;
        }
        
        item = purchasemenu::create_item_struct( #"arsenal", var_1923b2b3afc076ba );
        response = 0;
        
        if ( item.itemref == "random_attachments" )
        {
            response = craft_random_attachments( item );
        }
        else
        {
            response = craft_weapon_tier( item );
        }
        
        if ( response == 1 )
        {
            if ( isdefined( item.var_9281c8f5b1f3b37a ) )
            {
                self playsoundtoplayer( item.var_9281c8f5b1f3b37a, self );
            }
            
            if ( isdefined( self.s_arsenal_machine ) )
            {
                self.s_arsenal_machine thread function_90b871379c4f5215( item.tier, self );
                self.s_arsenal_machine.mdl_arsenal setscriptablepartstate( "anim", "weapon_upgrade" );
                
                if ( isdefined( item.tier ) )
                {
                    self.s_arsenal_machine.mdl_arsenal setscriptablepartstate( "audio_purchase", "weapon_rarity_" + string( item.tier ) );
                }
                else
                {
                    self.s_arsenal_machine.mdl_arsenal setscriptablepartstate( "audio_purchase", "weapon_rarity" );
                }
            }
        }
        else if ( response == 3 )
        {
            if ( isdefined( item.var_ac7c10eb14c9d6e0 ) )
            {
                self playsoundtoplayer( item.var_ac7c10eb14c9d6e0, self );
            }
        }
        
        purchasemenu::function_93f934ea2f1c06f8( response );
        return;
    }
    
    if ( channel == "arsenal_ammomod_purchase" )
    {
        var_9c657aff3a2d52cf = purchasemenu::get_purchasemenu( #"arsenal" );
        
        if ( !isdefined( var_9c657aff3a2d52cf ) )
        {
            return;
        }
        
        item = purchasemenu::create_item_struct( #"arsenal", var_1923b2b3afc076ba );
        response = function_32d584fb532aa7b8( item );
        
        if ( response == 1 )
        {
            if ( isdefined( item.var_9281c8f5b1f3b37a ) )
            {
                self playsoundtoplayer( item.var_9281c8f5b1f3b37a, self );
            }
            
            if ( isdefined( self.s_arsenal_machine ) )
            {
                self.s_arsenal_machine thread function_abdd49edc3f4a20( item.itemref );
                self.s_arsenal_machine.mdl_arsenal setscriptablepartstate( "anim", "weapon_upgrade" );
                self.s_arsenal_machine.mdl_arsenal setscriptablepartstate( "audio_purchase", "ammomod" );
            }
        }
        else if ( response == 3 )
        {
            if ( isdefined( item.var_ac7c10eb14c9d6e0 ) )
            {
                self playsoundtoplayer( item.var_ac7c10eb14c9d6e0, self );
            }
        }
        
        purchasemenu::function_93f934ea2f1c06f8( response );
        return;
    }
    
    if ( purchasemenu::function_bc886ba2b8da88c( #"arsenal", channel ) )
    {
        self.b_close_arsenal = 1;
    }
}

// Namespace arsenal
// Params 1
// Checksum 0x2bc82cf8, Offset: 0x1d2c
// Size: 0x33, Type: bool
function function_293fce87b27c1f3f( weapon )
{
    if ( weapon::isfistweapon( weapon ) || weapon::iskillstreakweapon( weapon ) || weapon::iswonderweapon( weapon ) )
    {
        return false;
    }
    
    return true;
}

// Namespace arsenal
// Params 1
// Checksum 0xa1cf7aad, Offset: 0x1d68
// Size: 0x34
function get_mod_name( weapon )
{
    if ( !isplayer( self ) )
    {
        return "";
    }
    
    if ( ammo_mod::has_ammo_mod( weapon ) )
    {
        return ammo_mod::get_ammo_mod_name( weapon );
    }
    
    return "";
}

// Namespace arsenal
// Params 2
// Checksum 0x6b5398c0, Offset: 0x1da5
// Size: 0x2f, Type: bool
function upgrade_rarity( weapon, newtier )
{
    if ( isdefined( weapon ) && isdefined( newtier ) )
    {
        item_weapon::function_40e1cbd0e1f47d1a( weapon, newtier );
        return true;
    }
    
    return false;
}

// Namespace arsenal
// Params 1
// Checksum 0xffd06d73, Offset: 0x1ddd
// Size: 0x10b
function function_32d584fb532aa7b8( item )
{
    if ( !currency::can_afford( item.currency, item.cost ) )
    {
        return 3;
    }
    
    currentweapon = self getcurrentweapon();
    n_mod_name = get_mod_name( currentweapon );
    
    if ( n_mod_name == item.itemref )
    {
        return 4;
    }
    
    if ( ammo_mod::function_7bbc1db07694f31d( currentweapon ) )
    {
        ammo_mod::add_ammo_mod_to_weapon( currentweapon, item.itemref );
    }
    else
    {
        return 4;
    }
    
    params = spawnstruct();
    params.item = item.itemref;
    params.currency = item.currency;
    params.cost = item.cost;
    callback::callback( "arsenal_craft_ammo_mod", params );
    currency::function_b5fe1e05c892a7f3( item.currency, item.cost );
    return 1;
}

// Namespace arsenal
// Params 1
// Checksum 0x6be6686b, Offset: 0x1ef1
// Size: 0x286
function craft_weapon_tier( item )
{
    cost = item.cost;
    currentweapon = self getcurrentweapon();
    
    if ( !function_293fce87b27c1f3f( currentweapon ) )
    {
        return 4;
    }
    
    rarity = item_weapon::function_fb81bd2fe070faa6( currentweapon );
    differencerarity = item.tier - rarity;
    higherrarity = differencerarity >= 1;
    tab_struct = purchasemenu::get_purchasemenu_tab( #"arsenal", item.var_b487b5b7ae379493 );
    
    if ( isdefined( tab_struct ) )
    {
        foreach ( tabitem in tab_struct.items )
        {
            var_30f37d57a23dc69f = purchasemenu::create_item_struct( #"arsenal", tabitem.globalindex );
            
            if ( isdefined( var_30f37d57a23dc69f ) && isdefined( var_30f37d57a23dc69f.cost ) && var_30f37d57a23dc69f.tier > 0 && var_30f37d57a23dc69f.tier < item.tier && var_30f37d57a23dc69f.tier > rarity )
            {
                cost += var_30f37d57a23dc69f.cost;
            }
        }
    }
    
    if ( !currency::can_afford( item.currency, cost ) )
    {
        return 3;
    }
    
    if ( item.tier > 0 && rarity < item.tier && higherrarity && rarity + 1 <= level.var_48e2b36291b57f44 )
    {
        upgrade_rarity( currentweapon, item.tier );
    }
    else
    {
        return 4;
    }
    
    params = spawnstruct();
    params.weapon = currentweapon;
    params.rarity = item.tier;
    params.currency = item.currency;
    params.cost = cost;
    callback::callback( "arsenal_craft_weapon_tier", params );
    currency::function_b5fe1e05c892a7f3( item.currency, cost );
    return 1;
}

// Namespace arsenal
// Params 1
// Checksum 0xd1e8c540, Offset: 0x2180
// Size: 0x83
function craft_random_attachments( item )
{
    if ( !currency::can_afford( item.currency, item.cost ) )
    {
        return 3;
    }
    
    currentweapon = self getcurrentweapon();
    
    if ( weapon::isfistweapon( currentweapon ) )
    {
        return 3;
    }
    
    var_dc910a00f7de4467 = 0;
    
    if ( var_dc910a00f7de4467 )
    {
    }
    else
    {
        return 4;
    }
    
    currency::function_b5fe1e05c892a7f3( item.currency, item.cost );
    return 1;
}

// Namespace arsenal
// Params 1
// Checksum 0xcf9dca41, Offset: 0x220c
// Size: 0x12b
function function_e2011e06deabac27( s_arsenal )
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_998509a8a21d9e78" );
    var_9c657aff3a2d52cf = purchasemenu::get_purchasemenu( #"arsenal" );
    
    if ( !isdefined( var_9c657aff3a2d52cf ) )
    {
        return;
    }
    
    s_arsenal utility::ent_flag_set( "arsenal_in_use" );
    w_current = self getcurrentweapon();
    n_rarity = item_weapon::function_fb81bd2fe070faa6( w_current );
    n_menu_id = var_9c657aff3a2d52cf.id ?? -1;
    
    if ( n_rarity > 4 )
    {
        n_rarity = 4;
    }
    
    self setclientomnvar( "ui_purchasemenu_id", n_menu_id );
    waitframe();
    
    if ( !level.arsenal_menu ZMArsenalMenu::is_open( self ) )
    {
        level.arsenal_menu ZMArsenalMenu::open( self );
        s_arsenal.mdl_arsenal.interact disableplayeruse( self );
        
        if ( isdefined( var_9c657aff3a2d52cf.soundopenmenu ) )
        {
            self playsoundtoplayer( var_9c657aff3a2d52cf.soundopenmenu, self );
        }
        
        function_7686e6a2465f5326( 1 );
    }
    
    thread function_e9f7ccaf77c4b343( s_arsenal );
    thread purchasemenu::menu_close_notify( var_9c657aff3a2d52cf, &on_menu_close );
}

// Namespace arsenal
// Params 1
// Checksum 0xbe3549e1, Offset: 0x233f
// Size: 0x35
function function_57721cf7bdb87284( var_1923b2b3afc076ba )
{
    cost = 0;
    currency = #"essence";
    return currency::can_afford( currency, cost );
}

// Namespace arsenal
// Params 1
// Checksum 0xa50f39d2, Offset: 0x237d
// Size: 0x1a
function on_menu_close( player )
{
    player.b_close_arsenal = 1;
}

// Namespace arsenal
// Params 1
// Checksum 0x6cb0f430, Offset: 0x239f
// Size: 0x1f8
function function_e9f7ccaf77c4b343( s_arsenal )
{
    self notify( #"hash_fa2810a1f5205d55" );
    self endon( #"hash_fa2810a1f5205d55" );
    self endon( #"disconnect" );
    var_9c657aff3a2d52cf = purchasemenu::get_purchasemenu( #"arsenal" );
    
    if ( !( isdefined( var_9c657aff3a2d52cf ) && isdefined( level.arsenal_menu ) ) )
    {
        return;
    }
    
    var_75385495715741fb = s_arsenal.mdl_arsenal;
    wait 0.75;
    n_start_distance = distance2d( var_75385495715741fb.origin, self.origin );
    v_start = self.origin;
    self.b_close_arsenal = undefined;
    
    while ( isdefined( var_75385495715741fb ) && isalive( self ) && !self.inlaststand && ( distance2d( var_75385495715741fb.origin, self.origin ) <= n_start_distance || distance2d( self.origin, var_75385495715741fb.origin ) < 82 ) )
    {
        if ( !isdefined( var_75385495715741fb ) || self stancebuttonpressed() || level.b_zm_game_over )
        {
            break;
        }
        
        if ( self.b_close_arsenal )
        {
            break;
        }
        
        waitframe();
    }
    
    if ( isdefined( self ) )
    {
        self.b_close_arsenal = undefined;
        purchasemenu::function_93f934ea2f1c06f8( 2 );
        
        if ( isdefined( self ) )
        {
            level.arsenal_menu ZMArsenalMenu::close( self );
            self setclientomnvar( "ui_purchasemenu_id", 0 );
            s_arsenal.mdl_arsenal.interact enableplayeruse( self );
            function_7686e6a2465f5326( 0 );
            
            if ( isdefined( var_9c657aff3a2d52cf.soundclosemenu ) )
            {
                self playsoundtoplayer( var_9c657aff3a2d52cf.soundclosemenu, self );
            }
            
            self.s_arsenal_machine = undefined;
            self notify( #"hash_998509a8a21d9e78" );
            self notify( var_9c657aff3a2d52cf.var_8a64e37068076a47 );
            s_arsenal utility::ent_flag_clear( "arsenal_in_use" );
        }
    }
}

// Namespace arsenal
// Params 1
// Checksum 0x37f595e6, Offset: 0x259f
// Size: 0xc6
function craft_armor_tier( item )
{
    if ( !currency::can_afford( item.currency, item.cost ) )
    {
        return 3;
    }
    
    var_fb9dbc5e38c0b372 = item.itemref == "armor_repair";
    
    if ( var_fb9dbc5e38c0b372 )
    {
        if ( !armor::has_full_armor() )
        {
            armor::repair_armor( self.maxarmorhealth );
        }
        else
        {
            return 4;
        }
    }
    else if ( self.platecarrierlevel == item.tier - 1 )
    {
        function_fdbe2cad6d8bb7e7( item.tier );
    }
    else
    {
        return 4;
    }
    
    currency::function_b5fe1e05c892a7f3( item.currency, item.cost );
    return 1;
}

// Namespace arsenal
// Params 1
// Checksum 0x6ad96c4e, Offset: 0x266e
// Size: 0x4c
function function_fdbe2cad6d8bb7e7( platecarrierlevel )
{
    self.platecarrierlevel = platecarrierlevel;
    self.maxarmorhealth = platecarrierlevel * level.var_1bfbe247e8d32b1b;
    armor::setarmorhealth( platecarrierlevel * level.var_1bfbe247e8d32b1b );
    self setclientomnvar( "ui_armor_current_level", platecarrierlevel );
}

// Namespace arsenal
// Params 1, eflags: 0x4
// Checksum 0x4d520dd2, Offset: 0x26c2
// Size: 0xaf
function private function_7686e6a2465f5326( var_80079f9fb5f78d48 )
{
    if ( var_80079f9fb5f78d48 )
    {
        if ( isplayer( self ) )
        {
            val::set( "using_arsenal", "melee", 0 );
            val::set( "using_arsenal", "killstreaks", 0 );
            val::set( "using_arsenal", "crate_use", 0 );
            val::set( "using_arsenal", "offhand_weapons", 0 );
            val::set( "using_arsenal", "offhand_throwback", 0 );
            val::set( "using_arsenal", "weapon_switch", 0 );
            val::set( "using_arsenal", "ignore_afk", 1 );
        }
        
        return;
    }
    
    if ( isplayer( self ) )
    {
        val::reset_all( "using_arsenal" );
    }
}

// Namespace arsenal
// Params 1, eflags: 0x4
// Checksum 0xf6aaa225, Offset: 0x2779
// Size: 0x16c
function private function_9fa990dd730b5d11( s_arsenal )
{
    s_arsenal.mdl_arsenal endon( #"death" );
    
    while ( true )
    {
        var_9f790ced36c30130 = function_4b7cd037ddeb755d( s_arsenal );
        
        if ( !var_9f790ced36c30130.size )
        {
            var_a21f9b61147c35b6 = "dx_zm_aiam_arsm_asgt_adsattractnotodo";
        }
        else
        {
            var_5f9c1217611b623e = randomint( 100 );
            
            if ( arraycontains( var_9f790ced36c30130, "rarity" ) && var_5f9c1217611b623e < 33 )
            {
                var_a21f9b61147c35b6 = "dx_zm_aiam_arsm_asgt_adsattractrareupgrd";
            }
            else if ( arraycontains( var_9f790ced36c30130, "ammomod" ) && var_5f9c1217611b623e >= 33 && var_5f9c1217611b623e < 66 )
            {
                var_a21f9b61147c35b6 = "dx_zm_aiam_arsm_asgt_adsattractammomod";
            }
            else
            {
                var_a21f9b61147c35b6 = "dx_zm_aiam_arsm_asgt_adsattractgeneric";
            }
        }
        
        vo_player = s_arsenal.mdl_arsenal;
        
        if ( isdefined( s_arsenal.mdl_arsenal.vo_src ) )
        {
            vo_player = s_arsenal.mdl_arsenal.vo_src;
        }
        
        s_arsenal.b_playing_vo = 1;
        var_e934769ee0b05edc = vo_player dialogue::say( var_a21f9b61147c35b6, undefined, undefined, 1 );
        s_arsenal.b_playing_vo = undefined;
        
        if ( var_e934769ee0b05edc )
        {
            n_cooldown_remaining = 300;
            
            while ( n_cooldown_remaining > 0 )
            {
                wait 1;
                n_cooldown_remaining--;
                
                while ( s_arsenal utility::ent_flag( "arsenal_in_use" ) )
                {
                    wait 1;
                }
            }
            
            continue;
        }
        
        wait 1;
    }
}

// Namespace arsenal
// Params 1, eflags: 0x4
// Checksum 0xc96b03c8, Offset: 0x28ed
// Size: 0xff
function private function_4b7cd037ddeb755d( s_arsenal )
{
    while ( true )
    {
        s_arsenal utility::ent_flag_waitopen_any( "arsenal_in_use" );
        
        if ( s_arsenal.b_playing_vo )
        {
            wait 1;
            continue;
        }
        
        if ( overlord::function_dce0a14273dfa0a8() || player_banter::is_player_banter_vo_active() )
        {
            wait 1;
            continue;
        }
        
        a_players_in_range = getplayersinradius( s_arsenal.origin, 250, 100 );
        
        if ( !a_players_in_range.size )
        {
            wait 0.5;
            continue;
        }
        
        var_fce8eb1003cc21d0 = [];
        
        foreach ( player in a_players_in_range )
        {
            var_fce8eb1003cc21d0 = function_cfc0519a43616bb2( player, var_fce8eb1003cc21d0, s_arsenal );
        }
        
        return var_fce8eb1003cc21d0;
    }
}

// Namespace arsenal
// Params 3, eflags: 0x4
// Checksum 0x4c8d6550, Offset: 0x29f4
// Size: 0xa1
function private function_cfc0519a43616bb2( player, var_fce8eb1003cc21d0, s_arsenal )
{
    n_salvage = player currency::get_currency_amount( #"salvage" );
    w_current = player getcurrentweapon();
    
    if ( level.arsenal_menu.var_9f580747e43b5ccc > n_salvage )
    {
        return [ "generic" ];
    }
    
    if ( !player ammo_mod::has_ammo_mod( w_current ) )
    {
        var_fce8eb1003cc21d0[ var_fce8eb1003cc21d0.size ] = "ammomod";
    }
    
    if ( function_6e3115093b40f528( player, w_current, n_salvage ) )
    {
        var_fce8eb1003cc21d0[ var_fce8eb1003cc21d0.size ] = "rarity";
    }
    
    return var_fce8eb1003cc21d0;
}

// Namespace arsenal
// Params 3, eflags: 0x4
// Checksum 0xb43248ff, Offset: 0x2a9e
// Size: 0x1a0
function private function_6e3115093b40f528( player, w_current, n_salvage )
{
    str_current_rarity = player zombie_damage::function_af20e81da38c49bc( w_current );
    
    switch ( str_current_rarity )
    {
        case #"hash_1393412d7401c646":
            var_6d07eb6a1d0719d0 = 1;
            break;
        case #"hash_883ff07272b4f9c":
            var_6d07eb6a1d0719d0 = 2;
            break;
        case #"hash_778bb52ecd08072d":
            var_6d07eb6a1d0719d0 = 3;
            break;
        case #"hash_598a30e44f53045f":
            var_6d07eb6a1d0719d0 = 4;
            break;
        case #"hash_35bb3bd014c77f4b":
            if ( level.var_48e2b36291b57f44 > 4 )
            {
                var_6d07eb6a1d0719d0 = 5;
                break;
            }
            else
            {
                return 0;
            }
        case #"hash_2ac407c1cd5943a9":
            return 0;
        default:
            break;
    }
    
    if ( !isdefined( var_6d07eb6a1d0719d0 ) )
    {
        return;
    }
    
    rarity_options = function_9c297dbedc01b9b8( #"hash_2a699cbbf39ea43b" );
    
    foreach ( item in rarity_options )
    {
        info = getscriptbundle( item.asset );
        
        if ( var_6d07eb6a1d0719d0 === info.tier )
        {
            if ( info.cost <= n_salvage )
            {
                return 1;
            }
            
            return 0;
        }
    }
}

// Namespace arsenal
// Params 0, eflags: 0x4
// Checksum 0xa1a98aa6, Offset: 0x2c46
// Size: 0xe6
function private function_253e2c5a80b10f62()
{
    ammomod_options = function_9c297dbedc01b9b8( #"arsenal_ammomods" );
    n_min_cost = undefined;
    
    if ( isdefined( ammomod_options ) )
    {
        foreach ( item in ammomod_options )
        {
            info = getscriptbundle( item.asset );
            
            if ( isdefined( info.cost ) && ( !isdefined( n_min_cost ) || info.cost < n_min_cost ) )
            {
                n_min_cost = info.cost;
            }
        }
    }
    
    return n_min_cost;
}

// Namespace arsenal
// Params 1, eflags: 0x4
// Checksum 0xa25f0881, Offset: 0x2d35
// Size: 0xb4
function private function_9c297dbedc01b9b8( var_e03070ac2a262aab )
{
    arsenal_menu = purchasemenu::get_purchasemenu( #"arsenal" );
    
    foreach ( tab in arsenal_menu.var_256445803195385a )
    {
        if ( tab.ref === var_e03070ac2a262aab )
        {
            return tab.items;
        }
    }
}

// Namespace arsenal
// Params 2, eflags: 0x4
// Checksum 0xe6512c1c, Offset: 0x2df1
// Size: 0x123
function private function_90b871379c4f5215( n_rarity_tier, player )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( !function_d3c0a229b8b6f989() )
    {
        playsoundatpos( self.origin + ( 0, 0, 60 ), "mus_zm_core_asrenal_purchase_bugle" );
        return;
    }
    
    w_current = player getcurrentweapon();
    
    if ( w_current.ismelee )
    {
        str_alias_type = "melee";
    }
    else
    {
        str_alias_type = "upgrade";
    }
    
    switch ( n_rarity_tier )
    {
        case 1:
            str_alias_suffix = "uncommon";
            break;
        case 2:
            str_alias_suffix = "rare";
            break;
        case 3:
            str_alias_suffix = "epic";
            break;
        case 4:
            str_alias_suffix = "legend";
            break;
        case 5:
            str_alias_suffix = "ultra";
            break;
        default:
            break;
    }
    
    function_9cd33632fe66439d( "dx_zm_aiam_arsm_asgt_ads" + str_alias_type + str_alias_suffix );
}

// Namespace arsenal
// Params 1, eflags: 0x4
// Checksum 0xfe6b405e, Offset: 0x2f1c
// Size: 0x88
function private function_abdd49edc3f4a20( str_ammomod )
{
    if ( !function_d3c0a229b8b6f989() )
    {
        playsoundatpos( self.origin + ( 0, 0, 60 ), "mus_zm_core_asrenal_purchase_bugle" );
        return;
    }
    
    if ( !isdefined( str_ammomod ) || randomint( 100 ) < 50 )
    {
        var_9db120803f4a380f = "generic";
    }
    else if ( str_ammomod == "shadowvortex" )
    {
        var_9db120803f4a380f = "shadowrend";
    }
    else
    {
        var_9db120803f4a380f = str_ammomod;
    }
    
    function_9cd33632fe66439d( "dx_zm_aiam_arsm_asgt_adsammo" + var_9db120803f4a380f );
}

// Namespace arsenal
// Params 0, eflags: 0x4
// Checksum 0xdc954860, Offset: 0x2fac
// Size: 0x22, Type: bool
function private function_d3c0a229b8b6f989()
{
    if ( self.b_playing_vo )
    {
        return false;
    }
    
    if ( self.var_997a281d7cff1eaa > 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace arsenal
// Params 1, eflags: 0xc
// Checksum 0xc9b11ee4, Offset: 0x2fd7
// Size: 0x75
function private function_583e0f852d421517( s_arsenal )
{
    self notify( #"hash_7feee1a2877db42c" );
    self endon( #"hash_7feee1a2877db42c" );
    s_arsenal.var_997a281d7cff1eaa = 180;
    
    while ( s_arsenal.var_997a281d7cff1eaa > 0 )
    {
        wait 1;
        s_arsenal.var_997a281d7cff1eaa--;
        
        while ( s_arsenal utility::ent_flag( "arsenal_in_use" ) )
        {
            wait 1;
        }
    }
    
    s_arsenal.var_997a281d7cff1eaa = undefined;
}

// Namespace arsenal
// Params 1, eflags: 0x4
// Checksum 0x981bf4bf, Offset: 0x3054
// Size: 0x8e
function private function_9cd33632fe66439d( var_a21f9b61147c35b6 )
{
    vo_player = self.mdl_arsenal;
    
    if ( isdefined( self.mdl_arsenal.vo_src ) )
    {
        vo_player = self.mdl_arsenal.vo_src;
    }
    
    self.b_playing_vo = 1;
    var_e934769ee0b05edc = vo_player dialogue::say( var_a21f9b61147c35b6, undefined, undefined, 1, 1.1 );
    self.b_playing_vo = undefined;
    
    if ( var_e934769ee0b05edc )
    {
        level thread function_583e0f852d421517( self );
    }
    
    return var_e934769ee0b05edc;
}

// Namespace arsenal
// Params 1
// Checksum 0x12da337a, Offset: 0x30eb
// Size: 0x7d
function function_66ae88df813c61b( s_feature )
{
    s_arsenal = s_feature;
    s_arsenal disable_arsenal( 1, 1 );
    
    if ( s_arsenal.mdl_arsenal.interact )
    {
        s_arsenal.mdl_arsenal.interact setscriptablepartstate( "arsenal_use", "arsenal_off" );
        s_arsenal.mdl_arsenal.interact function_7653c765b6c7b815();
    }
}

// Namespace arsenal
// Params 1
// Checksum 0xed50b245, Offset: 0x3170
// Size: 0x92
function function_885bbb1069e6ba30( s_feature )
{
    if ( level.zm_mode_modifiers.var_e07d21157dd37afb )
    {
        return;
    }
    
    s_arsenal = s_feature;
    s_arsenal enable_arsenal( 1 );
    
    if ( s_arsenal.mdl_arsenal.interact )
    {
        s_arsenal.mdl_arsenal.interact setscriptablepartstate( "arsenal_use", "arsenal_on" );
        s_arsenal.mdl_arsenal.interact function_e203bba36cfb19d0();
    }
}

/#

    // Namespace arsenal
    // Params 0, eflags: 0x4
    // Checksum 0x32684f99, Offset: 0x320a
    // Size: 0x42d, Type: dev
    function private function_ee23975dc86a65e4()
    {
        var_344c87cda146b92c = ( 0, 0, 4 );
        n_text_size = 0.25;
        
        while ( true )
        {
            foreach ( s_arsenal in level.var_52e94a468e66d601 )
            {
                if ( !isdefined( s_arsenal.mdl_arsenal ) )
                {
                    continue;
                }
                
                if ( !isdefined( s_arsenal.s_destination ) )
                {
                    s_arsenal.s_destination = utility::getstruct( s_arsenal.var_93e4a0a8514ca47e, "<dev string:x18d>" );
                }
                
                var_d876b0c0fe4d6eba = "<dev string:x198>";
                
                if ( s_arsenal.mdl_arsenal.interact tagexists( "<dev string:x1a3>" ) )
                {
                    v_position = s_arsenal.mdl_arsenal.interact gettagorigin( "<dev string:x1a3>" );
                    var_d876b0c0fe4d6eba = "<dev string:x1a3>";
                }
                else
                {
                    v_position = s_arsenal.mdl_arsenal.interact.origin;
                }
                
                utility::draw_circle( v_position, s_arsenal.mdl_arsenal.interact.interact_use_range, ( 0, 0, 1 ), 1, 0, 1 );
                line( v_position, s_arsenal.s_destination.origin, ( 0, 1, 0 ) );
                print3d( s_arsenal.s_destination.origin, "<dev string:x1ac>" + s_arsenal.var_93e4a0a8514ca47e, ( 0, 1, 0 ), 1, 0.25 );
                print3d( v_position - var_344c87cda146b92c * 1, "<dev string:x1c2>" + s_arsenal.name, ( 0, 1, 0 ), 1, 0.25 );
                print3d( v_position - var_344c87cda146b92c * 2, "<dev string:x1d1>" + ( s_arsenal.script_power ?? "<dev string:x1de>" ), ( 0, 1, 0 ), 1, 0.25 );
                print3d( v_position - var_344c87cda146b92c * 3, "<dev string:x1df>" + ( s_arsenal.var_5929513b9515fde7 ? "<dev string:x1ef>" : "<dev string:x1f3>" ), ( 0, 1, 0 ), 1, 0.25 );
                print3d( v_position - var_344c87cda146b92c * 4, "<dev string:x1f6>" + s_arsenal.var_93e4a0a8514ca47e, ( 0, 1, 0 ), 1, 0.25 );
                
                if ( s_arsenal.mdl_arsenal.interact.var_c3520c71cf883b16 )
                {
                    var_b7fb3f7044fdbed2 = "<dev string:x204>";
                    var_d876b0c0fe4d6eba = "<dev string:x1de>";
                }
                else
                {
                    var_b7fb3f7044fdbed2 = "<dev string:x20c>";
                    var_d876b0c0fe4d6eba = "<dev string:x213>" + var_d876b0c0fe4d6eba + "<dev string:x21a>";
                }
                
                print3d( v_position - var_344c87cda146b92c * 5, "<dev string:x21c>" + var_b7fb3f7044fdbed2 + var_d876b0c0fe4d6eba, ( 0, 1, 0 ), 1, 0.25 );
                
                foreach ( player in level.players )
                {
                    if ( isdefined( player.s_arsenal_machine ) )
                    {
                        print3d( player.origin, player.name + "<dev string:x22e>" + player.s_arsenal_machine.name, ( 0, 1, 0 ), 1, 0.25 );
                    }
                }
            }
            
            waitframe();
        }
    }

#/
