// scripts\common\ai\aitypes\zombie_base\zombie_base.gsc  (hash_6c6974c848745a10.gscc) (size: 8897 Bytes / 0x22c1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x869acaf7 (2258291447)
// size ...... 8897 (0x22c1)
// includes .. 11  (offset: 0x1e11)
// strings ... 71  (offset: 0x1e69)
// dev strs .. 0   (offset: 0x22c1)
// exports ... 30  (offset: 0x1109)
// cseg ...... 0x52a + 0xbdf (0x1109)
// imports ... 64  (offset: 0x15b9)
// animtree1 . 0   (offset: 0x22c1)
// animtree2 . 0   (offset: 0x22c1)
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_liveragdoll;
#using scripts\common\ai\aitypes\shared\zombie\zombie_melee;
#using scripts\common\ai\aitypes\shared\zombie\zombie_ranged_attack;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_base\zombie_base_audio;
#using scripts\common\ai\aitypes\zombie_base\zombie_base_dismemberment;
#using scripts\common\ai\aitypes\zombie_base\zombie_base_emergence_spawning;
#using scripts\common\ai\aitypes\zombie_base\zombie_base_knockdown;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace zombie_base;

// Namespace zombie_base
// Params 2
// Checksum 0x1d6d6bfa, Offset: 0x548
// Size: 0x1e
function precache( classname, aitypescriptbundle )
{
    namespace_b76ff2659823e89d::init_zombie_base_dismemberment_precache( aitypescriptbundle );
}

// Namespace zombie_base
// Params 1, eflags: 0x4
// Checksum 0x8936d6dc, Offset: 0x56e
// Size: 0x21b
function private function_cfbb84b3d7bc65b8( params )
{
    profilestart();
    zombie_base_audio::init_zombie_base_audio_global();
    zombie_base_knockdown::init_knockdown_global();
    zombie_melee::init_zombie_melee_global();
    zombie_base_emergence_spawning::function_5424383cc2c5d969();
    namespace_b76ff2659823e89d::init_zombie_base_dismemberment_global();
    callback::get_template( self.animsetname ) callback::add( "on_turned", &on_zombie_turned );
    callback::get_template( self.animsetname ) callback::add( "on_brainrot_end", &function_4825acc21bc395f5 );
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
    callback::get_template( self.animsetname ) callback::add( "killed_body_cloned", &play_death_fx );
    callback::get_template( self.animsetname ) callback::add( "on_is_crawling_changed", &function_7ec194cbceaf9c99 );
    
    /#
        namespace_b76ff2659823e89d::setup_dismemberment_devgui();
    #/
    
    profilestop();
}

// Namespace zombie_base
// Params 1
// Checksum 0x3dae257e, Offset: 0x791
// Size: 0xfa
function function_5e925bf657d963a( taskid )
{
    assert( isdefined( self.zombieaisetting ) );
    zombie_init::function_5d23979c4c7c9a52( self.zombieaisetting );
    callback::add( "on_first_ai_init", &function_cfbb84b3d7bc65b8 );
    zombie_melee::function_2cc3729a3cdeadbf( "walk", 100 );
    zombie_melee::function_2cc3729a3cdeadbf( "run", 120 );
    self.notetrackposecrawlfunc = &function_7186be5cf87ef975;
    self.notetrackposestandfunc = &function_cc06873f393aa09e;
    self.var_21c11d8e9e1fb544 = &function_4459aff437da9adc;
    self.var_8ec107c571aa0b8d = &function_3ce47ab9321777a3;
    self enabletraversals( 1, "zombie", "zombie_base", "climb" );
    zombie_melee::init_zombie_melee();
    zombie_base_audio::init_zombie_base_audio();
    namespace_96f746e657c877bf::init_zombie_ranged_attack();
    namespace_b76ff2659823e89d::init_zombie_base_dismemberment();
    zombie_base_knockdown::function_578cd83f268c0cc3();
    
    if ( self._blackboard.var_a7ac06c0829177ee )
    {
        zombie_base_emergence_spawning::init_zombie_base_emergence_spawning();
    }
    
    thread initscriptable();
    return anim.success;
}

// Namespace zombie_base
// Params 0
// Checksum 0xca7d5853, Offset: 0x894
// Size: 0x73
function initscriptable()
{
    self endon( #"death" );
    self.fn_toggle_eye_glow = &function_a9ece37f18a4a257;
    utility::flag_wait( "scriptables_ready" );
    waitframe();
    
    if ( self isscriptable() )
    {
        if ( !utility::ent_flag_exist( "toggle_eye_glow" ) || utility::ent_flag( "toggle_eye_glow" ) )
        {
            if ( utility::function_9f2c41c1dcc8c94( "base", "base_off" ) )
            {
                utility::function_32b24db3127bff40( "base", "base_on" );
            }
        }
    }
}

// Namespace zombie_base
// Params 1, eflags: 0x4
// Checksum 0x3a1a3f55, Offset: 0x90f
// Size: 0x294
function private play_death_fx( params )
{
    body = zombie_utils::function_4e99fb1239980783( params );
    
    if ( isdefined( self ) )
    {
        utility::function_32b24db3127bff40( "base", "base_off" );
    }
    
    if ( isdefined( body ) )
    {
        body utility::function_32b24db3127bff40( "base", "base_off" );
        
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
        else if ( utility::ent_flag( "dissolve" ) )
        {
            body utility::function_32b24db3127bff40( "reveal_death_blue_glow", "reveal_death_blue_glow" );
        }
        else if ( utility::ent_flag( "plasma_death_pap" ) )
        {
            body utility::function_32b24db3127bff40( "reveal_death_red", "reveal_death_red" );
        }
        else if ( utility::ent_flag( "dissolve_purple" ) )
        {
            body utility::function_32b24db3127bff40( "reveal_death_purple", "reveal_death_purple" );
        }
        else if ( utility::ent_flag( "weap_mangler_killed" ) )
        {
            body utility::function_32b24db3127bff40( "weap_mangler_killed", "vfx_on" );
        }
        else if ( utility::ent_flag( "keep_trap_effect" ) )
        {
            body utility::function_32b24db3127bff40( "keep_trap_effect", "burned_on" );
        }
        else if ( utility::ent_flag( "glow_fade_away" ) )
        {
            body utility::function_32b24db3127bff40( "glow_fade_away", "on" );
            body utility::function_32b24db3127bff40( "reveal_death_blue_glow", "reveal_death_blue_glow" );
        }
        else if ( utility::ent_flag( "glow_fade_away_pap" ) )
        {
            body utility::function_32b24db3127bff40( "glow_fade_away_pap", "on" );
            body utility::function_32b24db3127bff40( "reveal_death_red_glow", "reveal_death_red_glow" );
        }
        else if ( utility::ent_flag( "dissolve_blue_burn" ) )
        {
            body utility::function_32b24db3127bff40( "reveal_death_blue_burn", "reveal_on" );
        }
        
        body thread watch_corpse_deleted();
    }
}

// Namespace zombie_base
// Params 0, eflags: 0x4
// Checksum 0xb1fc2468, Offset: 0xbab
// Size: 0x72
function private function_fc12a24729ef4e67()
{
    self endon( #"corpse_deleted" );
    wait 3;
    utility::function_7c10ea82c1e305b8( "burned", "burned_off" );
    var_80f3576404b5eba0 = 0;
    var_80f3576404b5eba0 = utility::function_7c10ea82c1e305b8( "burned", "burned_dead" );
    
    if ( var_80f3576404b5eba0 )
    {
        return;
    }
    
    utility::function_7c10ea82c1e305b8( "burned", "burned_dead" );
    wait 3;
    utility::function_7c10ea82c1e305b8( "burned", "burned_off" );
}

// Namespace zombie_base
// Params 0, eflags: 0x4
// Checksum 0x9cb7c4f6, Offset: 0xc25
// Size: 0x5e
function private function_a67c6606a684a2dd()
{
    self endon( #"corpse_deleted" );
    wait 3.7;
    var_80f3576404b5eba0 = utility::function_7c10ea82c1e305b8( "napalm_burned", "napalm_burned_dead" );
    
    if ( var_80f3576404b5eba0 )
    {
        return;
    }
    
    utility::function_7c10ea82c1e305b8( "napalm_burned", "napalm_burned_end" );
    wait 3;
    utility::function_7c10ea82c1e305b8( "napalm_burned", "napalm_burned_off" );
}

// Namespace zombie_base
// Params 0, eflags: 0x4
// Checksum 0xa1db0ec9, Offset: 0xc8b
// Size: 0x25
function private function_5b40e89eaf051664()
{
    self endon( #"corpse_deleted" );
    wait 5;
    utility::function_7c10ea82c1e305b8( "cryofreeze", "cryofreeze_off" );
}

// Namespace zombie_base
// Params 0, eflags: 0x4
// Checksum 0xe6becf53, Offset: 0xcb8
// Size: 0x25
function private dark_aether_bubble_timer()
{
    self endon( #"corpse_deleted" );
    wait 3;
    utility::function_32b24db3127bff40( "dark_aether_field_bubble", "dark_aether_field_bubble_off" );
}

// Namespace zombie_base
// Params 1, eflags: 0x4
// Checksum 0xcdadc9f7, Offset: 0xce5
// Size: 0x1d
function private function_ce4fe5b7b95b73f6( s_shock_effect )
{
    utility::function_32b24db3127bff40( "shocked", "shocked_on" );
}

// Namespace zombie_base
// Params 1, eflags: 0x4
// Checksum 0x5a3c6e47, Offset: 0xd0a
// Size: 0x1d
function private function_f8cbef2738adcd18( s_shock_effect )
{
    utility::function_7c10ea82c1e305b8( "shocked", "shocked_off" );
}

// Namespace zombie_base
// Params 1, eflags: 0x4
// Checksum 0xaa134d6b, Offset: 0xd2f
// Size: 0x1d
function private function_91e753b101229a2( s_burn_effect )
{
    utility::function_32b24db3127bff40( "poisoned", "poisoned_on" );
}

// Namespace zombie_base
// Params 1, eflags: 0x4
// Checksum 0x97532f6b, Offset: 0xd54
// Size: 0x29
function private function_8c2a60ae74d8ce34( s_burn_effect )
{
    utility::ent_flag_clear( "poisoned" );
    utility::function_7c10ea82c1e305b8( "poisoned", "poisoned_off" );
}

// Namespace zombie_base
// Params 1, eflags: 0x4
// Checksum 0x51619ea8, Offset: 0xd85
// Size: 0x1d
function private function_9a92f215ba32b261( s_burn_effect )
{
    utility::function_32b24db3127bff40( "wraith_burned", "wraith_burned_on" );
}

// Namespace zombie_base
// Params 1, eflags: 0x4
// Checksum 0xedcec103, Offset: 0xdaa
// Size: 0x29
function private function_c9afe0de75edf987( s_burn_effect )
{
    utility::ent_flag_clear( "wraith_burned" );
    utility::function_7c10ea82c1e305b8( "wraith_burned", "wraith_burned_off" );
}

// Namespace zombie_base
// Params 1, eflags: 0x4
// Checksum 0x1c09c252, Offset: 0xddb
// Size: 0x3f
function private function_2080c9a8a657bc17( s_burn_effect )
{
    var_7dddc60e0205506b = s_burn_effect.var_7dddc60e0205506b ?? "";
    utility::function_32b24db3127bff40( "burned" + var_7dddc60e0205506b, "burned_on" );
}

// Namespace zombie_base
// Params 1, eflags: 0x4
// Checksum 0xee0c3993, Offset: 0xe22
// Size: 0x3f
function private function_ef6cb4c9a207699d( s_burn_effect )
{
    var_7dddc60e0205506b = s_burn_effect.var_7dddc60e0205506b ?? "";
    utility::function_7c10ea82c1e305b8( "burned" + var_7dddc60e0205506b, "burned_off" );
}

// Namespace zombie_base
// Params 1, eflags: 0x4
// Checksum 0xe5df62e9, Offset: 0xe69
// Size: 0x1d
function private function_2b8879e19ccaeef3( s_burn_effect )
{
    utility::function_32b24db3127bff40( "napalm_burned", "napalm_burned_on" );
}

// Namespace zombie_base
// Params 1, eflags: 0x4
// Checksum 0x8336cf49, Offset: 0xe8e
// Size: 0x1d
function private function_aa4be0297708a8fa( s_burn_effect )
{
    utility::function_32b24db3127bff40( "napalm_burned", "napalm_burned_on_thermite" );
}

// Namespace zombie_base
// Params 1, eflags: 0x4
// Checksum 0xedcec103, Offset: 0xeb3
// Size: 0x29
function private function_8b959aabb4069e99( s_burn_effect )
{
    utility::ent_flag_clear( "napalm_burned" );
    utility::function_7c10ea82c1e305b8( "napalm_burned", "napalm_burned_off" );
}

// Namespace zombie_base
// Params 1, eflags: 0x4
// Checksum 0x7ee6e05b, Offset: 0xee4
// Size: 0xb6
function private on_zombie_turned( var_75e7c1be4fd022be )
{
    zombie_utils::function_a8ce00e0448cb6f0( "super_sprint", "turned", 26 );
    
    if ( self getscriptablehaspart( "base" ) )
    {
        if ( !isdefined( self.var_ea9548b6bb86b49 ) )
        {
            self.var_ea9548b6bb86b49 = self getscriptablepartstate( "base" );
        }
    }
    
    utility::function_32b24db3127bff40( "base", "base_off" );
    part = var_75e7c1be4fd022be.scriptable_payload.part ?? "brainrot";
    state = var_75e7c1be4fd022be.scriptable_payload.state ?? "brainrot_on";
    utility::function_32b24db3127bff40( part, state );
}

// Namespace zombie_base
// Params 1, eflags: 0x4
// Checksum 0x3db00ff0, Offset: 0xfa2
// Size: 0x38
function private function_4825acc21bc395f5( params )
{
    if ( isdefined( self.var_ea9548b6bb86b49 ) )
    {
        utility::function_32b24db3127bff40( "base", self.var_ea9548b6bb86b49 );
        self.var_ea9548b6bb86b49 = undefined;
    }
}

// Namespace zombie_base
// Params 0
// Checksum 0x29646681, Offset: 0xfe2
// Size: 0x1a, Type: bool
function function_3ce47ab9321777a3()
{
    if ( namespace_b76ff2659823e89d::is_crawling() )
    {
        return false;
    }
    
    if ( namespace_b76ff2659823e89d::is_head_dismembered() )
    {
        return false;
    }
    
    return true;
}

// Namespace zombie_base
// Params 0, eflags: 0x4
// Checksum 0x1c30353a, Offset: 0x1005
// Size: 0x2d
function private watch_corpse_deleted()
{
    level endon( #"game_ended" );
    self waittill( #"corpse_deleted", position );
    
    if ( isdefined( position ) )
    {
    }
}

// Namespace zombie_base
// Params 1, eflags: 0x4
// Checksum 0x1456132, Offset: 0x103a
// Size: 0x2c
function private function_7ec194cbceaf9c99( params )
{
    self._blackboard.var_cedd501bdb70cc3f = 65;
    self.var_f417c9b84e331083 = undefined;
}

// Namespace zombie_base
// Params 0
// Checksum 0x5e6288c1, Offset: 0x106e
// Size: 0x18
function function_7186be5cf87ef975()
{
    self._blackboard.var_6391b373c0f57a6d = 1;
}

// Namespace zombie_base
// Params 0
// Checksum 0x8e3261b4, Offset: 0x108e
// Size: 0x17
function function_cc06873f393aa09e()
{
    self._blackboard.var_6391b373c0f57a6d = 0;
}

// Namespace zombie_base
// Params 0
// Checksum 0xdc8062ae, Offset: 0x10ad
// Size: 0x12
function function_4459aff437da9adc()
{
    zombie_liveragdoll::function_6273f9e3a020d096( self.origin );
}

// Namespace zombie_base
// Params 0
// Checksum 0xa55f2958, Offset: 0x10c7
// Size: 0x42
function function_a9ece37f18a4a257()
{
    state = utility::ent_flag( "toggle_eye_glow" ) && !namespace_b76ff2659823e89d::is_head_dismembered() ? "base_on" : "base_off";
    utility::function_32b24db3127bff40( "base", state );
}

