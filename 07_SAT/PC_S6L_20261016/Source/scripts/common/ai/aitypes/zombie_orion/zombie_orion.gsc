// scripts\common\ai\aitypes\zombie_orion\zombie_orion.gsc  (hash_1ef3a5c83ba56b2a.gscc) (size: 11696 Bytes / 0x2db0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xceade1d4 (3467502036)
// size ...... 11696 (0x2db0)
// includes .. 13  (offset: 0x2848)
// strings ... 74  (offset: 0x28b0)
// dev strs .. 9   (offset: 0x2d38)
// exports ... 37  (offset: 0x1678)
// cseg ...... 0x57a + 0x10fe (0x1678)
// imports ... 96  (offset: 0x1c40)
// animtree1 . 0   (offset: 0x2db0)
// animtree2 . 0   (offset: 0x2db0)
#using script_16ea1b94f0f381b3;
#using script_2cd07641bf71242a;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_melee;
#using scripts\common\ai\aitypes\shared\zombie\zombie_projectile_attack;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_orion\zombie_orion_audio;
#using scripts\common\ai\aitypes\zombie_orion\zombie_orion_lightning;
#using scripts\common\ai\aitypes\zombie_orion\zombie_orion_metabones;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_orion;

// Namespace zombie_orion
// Params 2
// Checksum 0x3c7107de, Offset: 0x598
// Size: 0x38
function precache( classname, aitypescriptbundle )
{
    zombie_projectile_attack::precache( aitypescriptbundle );
    zombie_orion_lightning::precache( aitypescriptbundle );
    utility::add_fx( "orion_weapon_dissolve_fx", "vfx_sat_gameplay_zm_ai_karkinos_trident_dst" );
}

// Namespace zombie_orion
// Params 1, eflags: 0x4
// Checksum 0xb05b445b, Offset: 0x5d8
// Size: 0x2e0
function private function_caae7d151750f60e( params )
{
    zombie_melee::init_zombie_melee_global();
    zombie_projectile_attack::init_global();
    zombie_orion_lightning::init_global();
    zombie_orion_audio::function_2c3f6be64e59326();
    callback::get_template( self.animsetname ) callback::add( "pre_killed_body_cloned", &pre_play_death_fx );
    callback::get_template( self.animsetname ) callback::add( "killed_body_cloned", &play_death_fx );
    callback::get_template( self.animsetname ) callback::add( "on_turned", &on_zombie_turned );
    callback::get_template( self.animsetname ) callback::add( "on_brainrot_end", &function_16751232a9e10970 );
    callback::get_template( self.animsetname ) callback::add( "shocked", &function_ce4fe5b7b95b73f6 );
    callback::get_template( self.animsetname ) callback::add( "shocked_end", &function_f8cbef2738adcd18 );
    callback::get_template( self.animsetname ) callback::add( "poisoned", &function_91e753b101229a2 );
    callback::get_template( self.animsetname ) callback::add( "poisoned_end", &function_8c2a60ae74d8ce34 );
    callback::get_template( self.animsetname ) callback::add( "wraith_burned", &function_9a92f215ba32b261 );
    callback::get_template( self.animsetname ) callback::add( "wraith_burned_end", &function_c9afe0de75edf987 );
    callback::get_template( self.animsetname ) callback::add( "burned", &function_2080c9a8a657bc17 );
    callback::get_template( self.animsetname ) callback::add( "burned_end", &function_ef6cb4c9a207699d );
    callback::get_template( self.animsetname ) callback::add( "napalm_burned", &function_2b8879e19ccaeef3 );
    callback::get_template( self.animsetname ) callback::add( "napalm_burned_thermite", &function_aa4be0297708a8fa );
    callback::get_template( self.animsetname ) callback::add( "napalm_burned_end", &function_8b959aabb4069e99 );
    callback::get_template( self.animsetname ) callback::add( #"long_teleport", &function_aa62e405eca3c0f5 );
    callback::get_template( self.animsetname ) callback::add( #"hash_87f46f8c460bcb41", &function_fc3061f284ef097a );
    callback::get_template( self.animsetname ) callback::add( #"traverse_teleport_anim_start", &on_traverse_teleport_anim_start );
    callback::get_template( self.animsetname ) callback::add( #"traverse_teleport_anim_end", &function_c5607a00bfd97ebe );
    callback::get_template( self.animsetname ) callback::add( #"traverse_teleport_hide_entity", &function_43cf23ab021b25b1 );
    callback::get_template( self.animsetname ) callback::add( #"traverse_teleport_show_entity", &function_7f7a815d3e454aea );
}

// Namespace zombie_orion
// Params 1
// Checksum 0xc8b87472, Offset: 0x8c0
// Size: 0x11d
function function_4692ae2e620caedb( taskid )
{
    assert( isdefined( self.zombieaisetting ) );
    val::set( "spawn_reveal", "show_healthbar", 0 );
    val::set( "spawn_reveal", "damage", 0 );
    val::set( "spawn_reveal", "death", 0 );
    val::set( "spawn_reveal", "disallow_knockdown", 1 );
    val::set( "spawn_reveal", "disallow_stun", 1 );
    val::set( "spawn_reveal", "stunned", 0 );
    val::set( "spawn_reveal", "pain", 0 );
    val::set( "spawn_reveal", "special_pain", 0 );
    zombie_init::function_5d23979c4c7c9a52( self.zombieaisetting );
    callback::add( "on_first_ai_init", &function_caae7d151750f60e );
    thread init_scriptable();
    thread spawn_anim();
    zombie_melee::init_zombie_melee();
    zombie_projectile_attack::init();
    zombie_orion_lightning::init();
    zombie_orion_audio::init_zombie_orion_audio();
    self.var_8f42fb436afef718 = &zombie_traverse_asm::function_f91a43bc37888ed3;
    self.var_b8a25dd1082321c8 = 70;
    return anim.success;
}

// Namespace zombie_orion
// Params 0, eflags: 0x4
// Checksum 0xa1de04ff, Offset: 0x9e6
// Size: 0x44
function private init_scriptable()
{
    self endon( #"death" );
    utility::flag_wait( "scriptables_ready" );
    utility::waittill_any_timeout( level.framedurationseconds, "post_spawn" );
    zombie_orion_metabones::init();
    thread spawn_reveal();
    zombie_orion_audio::function_cddf28584bd7f1ed();
}

// Namespace zombie_orion
// Params 0, eflags: 0x4
// Checksum 0xb1a2eeab, Offset: 0xa32
// Size: 0x55
function private spawn_anim()
{
    self endon( #"death" );
    waitframe();
    
    if ( !self.spawn_fast && utility::callsharedfunc( #"ai", #"hash_eeabeb442ca0054", "spawn" ) )
    {
        thread namespace_9d8e359c3b1041e5::animscripted_sharedfunc( "spawn", "spawn", undefined, undefined, "spawn_animating" );
    }
}

// Namespace zombie_orion
// Params 0, eflags: 0xc
// Checksum 0xed38eaf4, Offset: 0xa8f
// Size: 0x229
function private spawn_reveal()
{
    self notify( #"hash_9cdf3270a0c017d1" );
    self endon( #"hash_9cdf3270a0c017d1" );
    self endon( #"death" );
    self clearpath();
    self setbtgoalstationary( 0 );
    self function_786bb6aa1b76c7ee( "in_spawn_reveal", 1 );
    
    if ( !self.disable_spawn_vfx )
    {
        if ( self.spawn_fast )
        {
            utility::function_32b24db3127bff40( "spawn_reveal", "spawn_reveal_fast" );
        }
        else
        {
            utility::function_32b24db3127bff40( "spawn_reveal", "spawn_reveal" );
        }
    }
    else
    {
        utility::function_32b24db3127bff40( "spawn_reveal", "spawn_reveal_audio_only" );
    }
    
    if ( utility::ent_flag( "stealth_enabled" ) )
    {
        self.stealth_enabled = 0;
    }
    
    println( "<dev string:x24>" + self.subclass + "<dev string:x45>" + self getentitynumber() + "<dev string:x51>" + self.origin + "<dev string:x67>" );
    wait self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_22bba71bf2a15d46;
    self attach( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.weaponmodel, self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_e61c743d6f896e1d );
    self function_70576dbab4f88e19( "orion_weapon_type", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_696a31606b221a2e );
    var_ccff365714afac79 = self.spawn_fast ? 0.6 : 2;
    wait var_ccff365714afac79 - self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_22bba71bf2a15d46;
    self function_f2df0257c63f229( "in_spawn_reveal" );
    utility::function_32b24db3127bff40( "spawn_reveal", "off" );
    
    if ( utility::ent_flag( "stealth_enabled" ) )
    {
        self.stealth_enabled = 1;
    }
    
    println( "<dev string:x69>" + self.subclass + "<dev string:x45>" + self getentitynumber() + "<dev string:x51>" + self.origin + "<dev string:x67>" );
    val::reset_all( "spawn_reveal" );
}

// Namespace zombie_orion
// Params 1, eflags: 0x4
// Checksum 0x78c6b998, Offset: 0xcc0
// Size: 0x1e
function private function_aa62e405eca3c0f5( params )
{
    self setscriptablepartstate( "spawn_reveal", "spawn_reveal_traverse_teleport", 1 );
}

// Namespace zombie_orion
// Params 1, eflags: 0x4
// Checksum 0xdd235606, Offset: 0xce6
// Size: 0x15
function private pre_play_death_fx( params )
{
    zombie_orion_metabones::destroy_armor( 1 );
}

// Namespace zombie_orion
// Params 1, eflags: 0x4
// Checksum 0x1b8a88a6, Offset: 0xd03
// Size: 0x84
function private function_df2050ee6102e780( delay )
{
    self endon( #"death" );
    wait delay;
    
    if ( isdefined( self ) )
    {
        fx_origin = self gettagorigin( "tag_origin" );
        var_577a467b53726b45 = self gettagangles( "tag_origin" );
        fx_forward = anglestoforward( var_577a467b53726b45 );
        fx_up = anglestoup( var_577a467b53726b45 );
        playfx( utility::getfx( "orion_weapon_dissolve_fx" ), fx_origin, fx_forward, fx_up );
        self delete();
    }
}

// Namespace zombie_orion
// Params 1, eflags: 0x4
// Checksum 0xa6c93978, Offset: 0xd8f
// Size: 0x226
function private play_death_fx( params )
{
    if ( params.objweapon.ismelee && isplayer( params.eattacker ) && self && self getaiblackboarddynamic( "is_lightning_charged" ) == 1 )
    {
        params.eattacker namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_duelist" );
    }
    
    body = zombie_utils::function_4e99fb1239980783( params );
    
    if ( body )
    {
        foreach ( part, state in self.var_ee4496185273b139 )
        {
            body setscriptablepartstate( part, state );
        }
        
        body utility::function_7c10ea82c1e305b8( "base", "base_off" );
        body utility::function_7c10ea82c1e305b8( "death", "dead" );
        
        if ( utility::ent_flag( "dark_aether_bubble" ) )
        {
            body utility::function_32b24db3127bff40( "dark_aether_field_bubble", "dissolve" );
            body thread dark_aether_bubble_timer();
        }
        
        if ( utility::ent_flag( "burned" ) )
        {
            body utility::function_32b24db3127bff40( "burned", "burned_on" );
            body thread function_fc12a24729ef4e67();
        }
        else if ( utility::ent_flag( "napalm_burned" ) )
        {
            body utility::function_32b24db3127bff40( "napalm_burned", "napalm_burned_on" );
            body thread function_a67c6606a684a2dd();
        }
        else if ( utility::ent_flag( "locust_ww_burned" ) )
        {
            body utility::function_32b24db3127bff40( "burned_locust_ww", "burned_dead" );
        }
        else if ( utility::ent_flag( "locust_ww_burned_pap" ) )
        {
            body utility::function_32b24db3127bff40( "burned_locust_ww_pap", "burned_dead" );
        }
        else if ( utility::ent_flag( "frost_killed" ) )
        {
            body utility::function_32b24db3127bff40( "cryofreeze", "cryofreeze_dead" );
            body thread function_5b40e89eaf051664();
        }
        
        wait 5;
        
        if ( body )
        {
            body delete();
        }
    }
}

// Namespace zombie_orion
// Params 0, eflags: 0x4
// Checksum 0xbe8858f9, Offset: 0xfbd
// Size: 0x25
function private dark_aether_bubble_timer()
{
    self endon( #"corpse_deleted" );
    wait 3;
    utility::function_32b24db3127bff40( "dark_aether_field_bubble", "dark_aether_field_bubble_off" );
}

// Namespace zombie_orion
// Params 0, eflags: 0x4
// Checksum 0x183e49ac, Offset: 0xfea
// Size: 0x25
function private function_5b40e89eaf051664()
{
    self endon( #"corpse_deleted" );
    wait 4;
    utility::function_32b24db3127bff40( "cryofreeze", "cryofreeze_off" );
}

// Namespace zombie_orion
// Params 0, eflags: 0x4
// Checksum 0x9f26f587, Offset: 0x1017
// Size: 0x25
function private function_fc12a24729ef4e67()
{
    self endon( #"corpse_deleted" );
    wait 3;
    utility::function_7c10ea82c1e305b8( "burned", "burned_off" );
}

// Namespace zombie_orion
// Params 0, eflags: 0x4
// Checksum 0xe3341a01, Offset: 0x1044
// Size: 0x25
function private function_a67c6606a684a2dd()
{
    self endon( #"corpse_deleted" );
    wait 3;
    utility::function_7c10ea82c1e305b8( "napalm_burned", "napalm_burned_off" );
}

// Namespace zombie_orion
// Params 1, eflags: 0x4
// Checksum 0xa2a4cdd0, Offset: 0x1071
// Size: 0x42
function private function_fc3061f284ef097a( params )
{
    mover = params.mover;
    
    if ( isdefined( self.var_41a3841fc2dd4012 ) )
    {
        self.var_41a3841fc2dd4012 utility::scriptable_setparententity( mover );
    }
}

// Namespace zombie_orion
// Params 1, eflags: 0x4
// Checksum 0x7fd5ac78, Offset: 0x10bb
// Size: 0x11e
function private on_traverse_teleport_anim_start( params )
{
    val::set( "traverse_teleport", "damage", 0 );
    val::set( "traverse_teleport", "disallow_knockdown", 1 );
    val::set( "traverse_teleport", "disallow_stun", 1 );
    val::set( "traverse_teleport", "stunned", 0 );
    val::set( "traverse_teleport", "pain", 0 );
    val::set( "traverse_teleport", "special_pain", 0 );
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    
    if ( settings.var_742f0fd8db8d6cc9 && settings.var_2f6f606546b00d83 )
    {
        if ( !isdefined( self.var_41a3841fc2dd4012 ) )
        {
            self.var_41a3841fc2dd4012 = spawnscriptable( settings.var_742f0fd8db8d6cc9, self.origin + ( 0, 0, 0 ) );
        }
        
        if ( self.var_41a3841fc2dd4012 getscriptablehaspart( "traversal_intro" ) )
        {
            self.var_41a3841fc2dd4012 setscriptablepartstate( "traversal_intro", "on" );
        }
    }
}

// Namespace zombie_orion
// Params 1, eflags: 0x4
// Checksum 0x58af2af6, Offset: 0x11e1
// Size: 0x59
function private function_c5607a00bfd97ebe( params )
{
    val::reset_all( "traverse_teleport" );
    
    if ( !self.teleport_revealed )
    {
        self show();
        utility::function_7c10ea82c1e305b8( "spawn_reveal", "spawn_reveal_traverse_teleport" );
    }
    
    self.teleport_revealed = undefined;
    
    if ( self.var_41a3841fc2dd4012 )
    {
        thread cleanup_lightning_ball();
    }
}

// Namespace zombie_orion
// Params 1, eflags: 0x4
// Checksum 0x66401780, Offset: 0x1242
// Size: 0xbc
function private function_43cf23ab021b25b1( params )
{
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    
    if ( settings.var_742f0fd8db8d6cc9 && settings.var_2f6f606546b00d83 )
    {
        if ( !isdefined( self.var_41a3841fc2dd4012 ) )
        {
            self.var_41a3841fc2dd4012 = spawnscriptable( settings.var_742f0fd8db8d6cc9, self.origin + ( 0, 0, 0 ) );
        }
        
        if ( self.var_41a3841fc2dd4012 getscriptablehaspart( settings.var_2f6f606546b00d83 ) )
        {
            self.var_41a3841fc2dd4012 setscriptablepartstate( settings.var_2f6f606546b00d83, "on" );
        }
    }
}

// Namespace zombie_orion
// Params 1, eflags: 0x4
// Checksum 0x36b13c76, Offset: 0x1306
// Size: 0x3b
function private function_7f7a815d3e454aea( params )
{
    utility::function_7c10ea82c1e305b8( "spawn_reveal", "spawn_reveal_traverse_teleport" );
    self.teleport_revealed = 1;
    
    if ( self.var_41a3841fc2dd4012 )
    {
        thread cleanup_lightning_ball();
    }
}

// Namespace zombie_orion
// Params 0, eflags: 0x4
// Checksum 0x3fb49dae, Offset: 0x1349
// Size: 0x7c
function private cleanup_lightning_ball()
{
    level endon( #"game_ended" );
    var_41a3841fc2dd4012 = self.var_41a3841fc2dd4012;
    part_name = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_2f6f606546b00d83;
    var_41a3841fc2dd4012 utility::scriptable_clearparententity();
    self.var_41a3841fc2dd4012 = undefined;
    wait 0.2;
    
    if ( var_41a3841fc2dd4012 )
    {
        var_41a3841fc2dd4012 setscriptablepartstate( part_name, "off" );
        var_41a3841fc2dd4012 freescriptable();
    }
}

// Namespace zombie_orion
// Params 1, eflags: 0x4
// Checksum 0x8fcca883, Offset: 0x13cd
// Size: 0x1d
function private on_zombie_turned( var_75e7c1be4fd022be )
{
    utility::function_32b24db3127bff40( "brainrot", "brainrot_on" );
}

// Namespace zombie_orion
// Params 1, eflags: 0x4
// Checksum 0x4d733894, Offset: 0x13f2
// Size: 0x1d
function private function_16751232a9e10970( params )
{
    utility::function_7c10ea82c1e305b8( "brainrot", "brainrot_off" );
}

// Namespace zombie_orion
// Params 1, eflags: 0x4
// Checksum 0x959b5e5d, Offset: 0x1417
// Size: 0x1d
function private function_ce4fe5b7b95b73f6( s_shock_effect )
{
    utility::function_32b24db3127bff40( "shocked", "shocked_on" );
}

// Namespace zombie_orion
// Params 1, eflags: 0x4
// Checksum 0x20af9ed, Offset: 0x143c
// Size: 0x1d
function private function_f8cbef2738adcd18( s_shock_effect )
{
    utility::function_7c10ea82c1e305b8( "shocked", "shocked_off" );
}

// Namespace zombie_orion
// Params 1, eflags: 0x4
// Checksum 0xf225dac1, Offset: 0x1461
// Size: 0x1d
function private function_91e753b101229a2( s_burn_effect )
{
    utility::function_32b24db3127bff40( "poisoned", "poisoned_on" );
}

// Namespace zombie_orion
// Params 1, eflags: 0x4
// Checksum 0xcf65b8c1, Offset: 0x1486
// Size: 0x29
function private function_8c2a60ae74d8ce34( s_burn_effect )
{
    utility::ent_flag_clear( "poisoned" );
    utility::function_7c10ea82c1e305b8( "poisoned", "poisoned_off" );
}

// Namespace zombie_orion
// Params 1, eflags: 0x4
// Checksum 0x9570902, Offset: 0x14b7
// Size: 0x1d
function private function_9a92f215ba32b261( s_burn_effect )
{
    utility::function_32b24db3127bff40( "wraith_burned", "wraith_burned_on" );
}

// Namespace zombie_orion
// Params 1, eflags: 0x4
// Checksum 0xb5f856a9, Offset: 0x14dc
// Size: 0x29
function private function_c9afe0de75edf987( s_burn_effect )
{
    utility::ent_flag_clear( "wraith_burned" );
    utility::function_7c10ea82c1e305b8( "wraith_burned", "wraith_burned_off" );
}

// Namespace zombie_orion
// Params 1, eflags: 0x4
// Checksum 0x443f55f8, Offset: 0x150d
// Size: 0x3f
function private function_2080c9a8a657bc17( s_burn_effect )
{
    var_7dddc60e0205506b = s_burn_effect.var_7dddc60e0205506b ?? "";
    utility::function_32b24db3127bff40( "burned" + var_7dddc60e0205506b, "burned_on" );
}

// Namespace zombie_orion
// Params 1, eflags: 0x4
// Checksum 0xb63aae39, Offset: 0x1554
// Size: 0x3f
function private function_ef6cb4c9a207699d( s_burn_effect )
{
    var_7dddc60e0205506b = s_burn_effect.var_7dddc60e0205506b ?? "";
    utility::function_7c10ea82c1e305b8( "burned" + var_7dddc60e0205506b, "burned_off" );
}

// Namespace zombie_orion
// Params 1, eflags: 0x4
// Checksum 0xbde9f543, Offset: 0x159b
// Size: 0x1d
function private function_2b8879e19ccaeef3( s_burn_effect )
{
    utility::function_32b24db3127bff40( "napalm_burned", "napalm_burned_on" );
}

// Namespace zombie_orion
// Params 1, eflags: 0x4
// Checksum 0xdb0058e3, Offset: 0x15c0
// Size: 0x1d
function private function_aa4be0297708a8fa( s_burn_effect )
{
    utility::function_32b24db3127bff40( "napalm_burned", "napalm_burned_on_thermite" );
}

// Namespace zombie_orion
// Params 1, eflags: 0x4
// Checksum 0xc4d7f225, Offset: 0x15e5
// Size: 0x1d
function private function_8b959aabb4069e99( s_burn_effect )
{
    utility::function_7c10ea82c1e305b8( "napalm_burned", "napalm_burned_off" );
}

/#

    // Namespace zombie_orion
    // Params 0
    // Checksum 0x76b4ad60, Offset: 0x160a
    // Size: 0x2e, Type: dev
    function init_orion_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x88>" );
        devgui::add_devgui_func( "<dev string:x9d>", "<dev string:xb2>", &toggle_debug_display );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_orion
    // Params 0, eflags: 0x4
    // Checksum 0x5ba37094, Offset: 0x1640
    // Size: 0x16, Type: dev
    function private function_bf2a4eb30c919078()
    {
        return getdvarint( @"orion_debug_display", 0 ) > 0;
    }

    // Namespace zombie_orion
    // Params 0, eflags: 0x4
    // Checksum 0x83a263ac, Offset: 0x165e
    // Size: 0x1a, Type: dev
    function private toggle_debug_display()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:xc7>", @"orion_debug_display" );
    }

#/
