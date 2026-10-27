// scripts\common\ai\aitypes\zombie_mangler\zombie_mangler.gsc  (hash_328f165f5d9173c4.gscc) (size: 8817 Bytes / 0x2271 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd45a54db (3562689755)
// size ...... 8817 (0x2271)
// includes .. 13  (offset: 0x1e01)
// strings ... 68  (offset: 0x1e69)
// dev strs .. 0   (offset: 0x2271)
// exports ... 27  (offset: 0x1129)
// cseg ...... 0x510 + 0xc19 (0x1129)
// imports ... 69  (offset: 0x1561)
// animtree1 . 0   (offset: 0x2271)
// animtree2 . 0   (offset: 0x2271)
#using script_1f827eec11f3e4ef;
#using script_2b848668600efa30;
#using script_5b7daaca1fd43817;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_melee;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_mangler\zombie_mangler_audio;
#using scripts\common\ai\aitypes\zombie_mangler\zombie_mangler_berserk;
#using scripts\common\ai\aitypes\zombie_mangler\zombie_mangler_ranged_attack;
#using scripts\common\callbacks;
#using scripts\common\metabone;
#using scripts\common\utility;

#namespace zombie_mangler;

// Namespace zombie_mangler
// Params 2
// Checksum 0x1767bf1e, Offset: 0x52e
// Size: 0x46
function precache( classname, aitypescriptbundle )
{
    settings = zombie_utils::function_a225e7aa4a243fb2( aitypescriptbundle );
    
    if ( isdefined( settings ) )
    {
        utility::add_fx( "mangler_weakpoint_impact_fx", settings.weakpointvfxpath );
    }
}

// Namespace zombie_mangler
// Params 1, eflags: 0x4
// Checksum 0xdfad7c1f, Offset: 0x57c
// Size: 0x261
function private function_cfbb84b3d7bc65b8( params )
{
    namespace_77941ede83766656::init_zombie_mangler_audio_global();
    level.scr_anim[ self.animname ][ "spawn" ] = "spawn";
    zombie_melee::init_zombie_melee_global();
    namespace_5327d50d93090f10::function_34a612cca324de27();
    namespace_aef48b18f1c4d84c::function_20fe09ffbe284aa();
    namespace_3d3dd05aed5a95f5::function_721fd881a662eeaa();
    namespace_3cb33073a34a0c5::function_29a289a7493e0b07();
    callback::get_template( self.animsetname ) callback::add( "on_turned", &on_zombie_turned );
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
    callback::get_template( self.animsetname ) callback::add( "pre_killed_body_cloned", &pre_play_death_fx );
    callback::get_template( self.animsetname ) callback::add( "killed_body_cloned", &play_death_fx );
    callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_damaged", &mangler_damage_callback );
    callback::get_template( self.animsetname ) callback::add( "spawn_animscripted", &on_spawn_animscripted );
    callback::callback( "on_zombie_mangler_first_init" );
}

// Namespace zombie_mangler
// Params 1
// Checksum 0xa1e93c42, Offset: 0x7e5
// Size: 0x12b
function function_db80dea3cf0c80de( taskid )
{
    assert( isdefined( self.zombieaisetting ) );
    zombie_init::function_5d23979c4c7c9a52( self.zombieaisetting );
    assert( isdefined( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb ) );
    callback::add( "on_first_ai_init", &function_cfbb84b3d7bc65b8 );
    callback::add( "on_zombie_ai_killed", &function_38785cc99319d6a4 );
    zombie_melee::init_zombie_melee();
    
    if ( !self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.isdeathmangler || !self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_4addb01d4538b29a )
    {
        namespace_aef48b18f1c4d84c::init_mangler_ranged_attack();
    }
    
    self.gun_arm_destroyed = 0;
    namespace_ac69c03f7b7eefc2::init_mangler_berserk();
    zombie_melee::function_2cc3729a3cdeadbf( "walk", 85 );
    zombie_melee::function_2cc3729a3cdeadbf( "sprint", 175 );
    namespace_77941ede83766656::init_zombie_mangler_audio();
    thread initscriptable();
    self.spawn_vfx = undefined;
    self function_786bb6aa1b76c7ee( "unreachable_roar_cooldown", 10000 );
    self enabletraversals( 1, "zombie", "climb" );
    return anim.success;
}

// Namespace zombie_mangler
// Params 0
// Checksum 0x4da50c0, Offset: 0x919
// Size: 0x47
function initscriptable()
{
    self endon( #"death" );
    utility::flag_wait( "scriptables_ready" );
    waitframe();
    
    if ( self isscriptable() )
    {
        if ( self getscriptablepartstate( "base" ) != "base_on_noeyes" )
        {
            utility::function_32b24db3127bff40( "base", "base_on" );
        }
    }
}

// Namespace zombie_mangler
// Params 1
// Checksum 0x9e1d43df, Offset: 0x968
// Size: 0x4c
function mangler_damage_callback( params )
{
    if ( isdefined( params.metabonename ) && !metabone::is_metabone_destroyed( params.metabonename ) )
    {
        playfx( utility::getfx( "mangler_weakpoint_impact_fx" ), params.vpoint );
    }
}

// Namespace zombie_mangler
// Params 1, eflags: 0x4
// Checksum 0x1b9e2463, Offset: 0x9bc
// Size: 0x16f
function private pre_play_death_fx( params )
{
    self.var_ee4496185273b139 = [];
    utility::function_32b24db3127bff40( "base", "base_off" );
    
    if ( self.gun_arm_destroyed && self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_4d9464af93daa25c )
    {
        if ( utility::function_32b24db3127bff40( "j_weapon_spin", "destroyed_loot" ) )
        {
            self.var_ee4496185273b139[ "j_weapon_spin" ] = "destroyed_loot";
        }
    }
    else if ( utility::function_32b24db3127bff40( "j_weapon_spin", "destroyed" ) )
    {
        self.var_ee4496185273b139[ "j_weapon_spin" ] = "destroyed";
    }
    
    if ( utility::function_32b24db3127bff40( "armored_head", "destroyed" ) )
    {
        self.var_ee4496185273b139[ "armored_head" ] = "destroyed";
    }
    
    if ( utility::function_32b24db3127bff40( "armored_torso", "destroyed" ) )
    {
        self.var_ee4496185273b139[ "armored_torso" ] = "destroyed";
    }
    
    if ( utility::function_32b24db3127bff40( "armored_shoulder_left", "destroyed" ) )
    {
        self.var_ee4496185273b139[ "armored_shoulder_left" ] = "destroyed";
    }
    
    if ( utility::function_32b24db3127bff40( "armored_leg_right", "destroyed" ) )
    {
        self.var_ee4496185273b139[ "armored_leg_right" ] = "destroyed";
    }
    
    if ( utility::function_32b24db3127bff40( "armored_leg_left", "destroyed" ) )
    {
        self.var_ee4496185273b139[ "armored_leg_left" ] = "destroyed";
    }
}

// Namespace zombie_mangler
// Params 1, eflags: 0x4
// Checksum 0xb47ff61b, Offset: 0xb33
// Size: 0x1c0
function private play_death_fx( params )
{
    body = zombie_utils::function_4e99fb1239980783( params );
    
    if ( isdefined( body ) && self.forceannihilate )
    {
        body endon( #"corpse_deleted" );
        body callback::callback( "on_annihilated" );
        body utility::function_32b24db3127bff40( "death", "death_annihilate" );
        waitframe();
        body delete();
        return;
    }
    
    if ( isdefined( body ) )
    {
        if ( !self.var_af3927c5d7ace5c0 )
        {
            foreach ( part, state in self.var_ee4496185273b139 )
            {
                body setscriptablepartstate( part, state, 1 );
            }
            
            body thread function_58af8eb4056b25c3();
        }
        
        if ( utility::ent_flag( "dark_aether_bubble" ) )
        {
            body utility::function_32b24db3127bff40( "dark_aether_field_bubble", "dissolve" );
            body thread dark_aether_bubble_timer();
        }
        
        if ( utility::ent_flag( "dissolve_purple" ) )
        {
            body utility::function_32b24db3127bff40( "reveal_death_purple", "reveal_death_purple" );
            body thread function_190a8f11ccb740ee();
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
        
        body utility::function_32b24db3127bff40( "base", "base_off" );
    }
}

// Namespace zombie_mangler
// Params 0, eflags: 0x4
// Checksum 0xf6b0f12d, Offset: 0xcfb
// Size: 0x25
function private function_58af8eb4056b25c3()
{
    self endon( #"corpse_deleted" );
    wait 3;
    utility::function_7c10ea82c1e305b8( "j_weapon_spin", "dead" );
}

// Namespace zombie_mangler
// Params 0, eflags: 0x4
// Checksum 0x1164469e, Offset: 0xd28
// Size: 0x25
function private function_fc12a24729ef4e67()
{
    self endon( #"corpse_deleted" );
    wait 3;
    utility::function_7c10ea82c1e305b8( "burned", "burned_off" );
}

// Namespace zombie_mangler
// Params 0, eflags: 0x4
// Checksum 0x6d76a918, Offset: 0xd55
// Size: 0x25
function private function_a67c6606a684a2dd()
{
    self endon( #"corpse_deleted" );
    wait 3;
    utility::function_7c10ea82c1e305b8( "napalm_burned", "napalm_burned_off" );
}

// Namespace zombie_mangler
// Params 0, eflags: 0x4
// Checksum 0x30caebe0, Offset: 0xd82
// Size: 0x25
function private dark_aether_bubble_timer()
{
    self endon( #"corpse_deleted" );
    wait 3;
    utility::function_32b24db3127bff40( "dark_aether_field_bubble", "dark_aether_field_bubble_off" );
}

// Namespace zombie_mangler
// Params 0, eflags: 0x4
// Checksum 0x7557718d, Offset: 0xdaf
// Size: 0x1a
function private function_190a8f11ccb740ee()
{
    self endon( #"corpse_deleted" );
    wait 3;
    self delete();
}

// Namespace zombie_mangler
// Params 1, eflags: 0x4
// Checksum 0x1bd9ed44, Offset: 0xdd1
// Size: 0x1d
function private function_ce4fe5b7b95b73f6( s_shock_effect )
{
    utility::function_32b24db3127bff40( "shocked", "shocked_on" );
}

// Namespace zombie_mangler
// Params 1, eflags: 0x4
// Checksum 0x8c484af4, Offset: 0xdf6
// Size: 0x1d
function private function_f8cbef2738adcd18( s_shock_effect )
{
    utility::function_7c10ea82c1e305b8( "shocked", "shocked_off" );
}

// Namespace zombie_mangler
// Params 1, eflags: 0x4
// Checksum 0x7c6769d8, Offset: 0xe1b
// Size: 0x1d
function private function_91e753b101229a2( s_burn_effect )
{
    utility::function_32b24db3127bff40( "poisoned", "poisoned_on" );
}

// Namespace zombie_mangler
// Params 1, eflags: 0x4
// Checksum 0x41270bd8, Offset: 0xe40
// Size: 0x29
function private function_8c2a60ae74d8ce34( s_burn_effect )
{
    utility::ent_flag_clear( "poisoned" );
    utility::function_7c10ea82c1e305b8( "poisoned", "poisoned_off" );
}

// Namespace zombie_mangler
// Params 1, eflags: 0x4
// Checksum 0x8715ba1b, Offset: 0xe71
// Size: 0x1d
function private function_9a92f215ba32b261( s_burn_effect )
{
    utility::function_32b24db3127bff40( "wraith_burned", "wraith_burned_on" );
}

// Namespace zombie_mangler
// Params 1, eflags: 0x4
// Checksum 0x3bbae5b0, Offset: 0xe96
// Size: 0x29
function private function_c9afe0de75edf987( s_burn_effect )
{
    utility::ent_flag_clear( "wraith_burned" );
    utility::function_7c10ea82c1e305b8( "wraith_burned", "wraith_burned_off" );
}

// Namespace zombie_mangler
// Params 1, eflags: 0x4
// Checksum 0xca7de6e1, Offset: 0xec7
// Size: 0x3f
function private function_2080c9a8a657bc17( s_burn_effect )
{
    var_7dddc60e0205506b = s_burn_effect.var_7dddc60e0205506b ?? "";
    utility::function_32b24db3127bff40( "burned" + var_7dddc60e0205506b, "burned_on" );
}

// Namespace zombie_mangler
// Params 1, eflags: 0x4
// Checksum 0xd98bcdef, Offset: 0xf0e
// Size: 0x3f
function private function_ef6cb4c9a207699d( s_burn_effect )
{
    var_7dddc60e0205506b = s_burn_effect.var_7dddc60e0205506b ?? "";
    utility::function_32b24db3127bff40( "burned" + var_7dddc60e0205506b, "burned_off" );
}

// Namespace zombie_mangler
// Params 1, eflags: 0x4
// Checksum 0x33ab465a, Offset: 0xf55
// Size: 0x1d
function private function_2b8879e19ccaeef3( s_burn_effect )
{
    utility::function_32b24db3127bff40( "napalm_burned", "napalm_burned_on" );
}

// Namespace zombie_mangler
// Params 1, eflags: 0x4
// Checksum 0x5542ebfa, Offset: 0xf7a
// Size: 0x1d
function private function_aa4be0297708a8fa( s_burn_effect )
{
    utility::function_32b24db3127bff40( "napalm_burned", "napalm_burned_on_thermite" );
}

// Namespace zombie_mangler
// Params 1, eflags: 0x4
// Checksum 0x4a95413c, Offset: 0xf9f
// Size: 0x1d
function private function_8b959aabb4069e99( s_burn_effect )
{
    utility::function_7c10ea82c1e305b8( "napalm_burned", "napalm_burned_off" );
}

// Namespace zombie_mangler
// Params 1, eflags: 0x4
// Checksum 0x85289fc1, Offset: 0xfc4
// Size: 0x47
function private on_zombie_turned( var_75e7c1be4fd022be )
{
    utility::function_32b24db3127bff40( "brainrot", "brainrot_on" );
    
    if ( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_12443844aa67f9b4 )
    {
        namespace_ac69c03f7b7eefc2::function_dd6d54fa5b6feae8( 0, 1 );
    }
}

// Namespace zombie_mangler
// Params 1, eflags: 0x4
// Checksum 0x88378c34, Offset: 0x1013
// Size: 0xe7
function private on_spawn_animscripted( params )
{
    callback::callback( "mangler_spawned" );
    self endon( #"death" );
    var_64d690f37c925a83 = 0.75;
    var_5b4eb9d63ae97db = 0.5;
    var_7a91a06fb8802f47 = 2;
    self hide();
    asm::freeze_ai();
    waitframe();
    self.spawn_vfx = spawnscriptable( "scriptable_zombie_mangler_spawn", self.origin );
    self.spawn_vfx setscriptablepartstate( "mangler_spawn_vfx", "spawn_loop" );
    wait var_5b4eb9d63ae97db;
    self show();
    asm::unfreeze_ai();
    wait var_64d690f37c925a83;
    
    if ( isdefined( self.spawn_vfx ) )
    {
        self.spawn_vfx setscriptablepartstate( "mangler_spawn_vfx", "deactivate" );
    }
    
    wait var_7a91a06fb8802f47;
    
    if ( isdefined( self.spawn_vfx ) )
    {
        self.spawn_vfx freescriptable();
    }
}

// Namespace zombie_mangler
// Params 1, eflags: 0x4
// Checksum 0xefb92258, Offset: 0x1102
// Size: 0x27
function private function_38785cc99319d6a4( params )
{
    if ( isdefined( self.spawn_vfx ) )
    {
        self.spawn_vfx freescriptable();
    }
}

