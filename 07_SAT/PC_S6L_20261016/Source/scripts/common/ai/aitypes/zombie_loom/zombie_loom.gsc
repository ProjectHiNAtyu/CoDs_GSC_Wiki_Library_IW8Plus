// scripts\common\ai\aitypes\zombie_loom\zombie_loom.gsc  (hash_156e34b26920050c.gscc) (size: 8701 Bytes / 0x21fd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x32f2a95f (854763871)
// size ...... 8701 (0x21fd)
// includes .. 15  (offset: 0x1e75)
// strings ... 52  (offset: 0x1eed)
// dev strs .. 0   (offset: 0x21fd)
// exports ... 31  (offset: 0x1055)
// cseg ...... 0x395 + 0xcc0 (0x1055)
// imports ... 74  (offset: 0x152d)
// animtree1 . 0   (offset: 0x21fd)
// animtree2 . 0   (offset: 0x21fd)
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_melee;
#using scripts\common\ai\aitypes\shared\zombie\zombie_ranged_attack;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_loom\zombie_loom_cocoon;
#using scripts\common\ai\aitypes\zombie_loom\zombie_loom_medal;
#using scripts\common\ai\aitypes\zombie_loom\zombie_loom_ride;
#using scripts\common\ai\aitypes\zombie_loom\zombie_loom_teleport;
#using scripts\common\ai\aitypes\zombie_loom\zombie_loom_web;
#using scripts\common\ai\aitypes\zombie_loom\zombie_loom_web_attack;
#using scripts\common\ai\aitypes\zombie_loom\zombie_loom_web_content;
#using scripts\common\ai\aitypes\zombie_loom\zombie_loom_web_door;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_loom;

// Namespace zombie_loom
// Params 2
// Checksum 0xba73c32b, Offset: 0x3b3
// Size: 0x3b
function precache( classname, aitypescriptbundle )
{
    settings = zombie_utils::function_a225e7aa4a243fb2( aitypescriptbundle );
    zombie_loom_web_attack::precache( aitypescriptbundle );
    zombie_loom_cocoon::precache( aitypescriptbundle );
}

// Namespace zombie_loom
// Params 1, eflags: 0x4
// Checksum 0x7a58c6d9, Offset: 0x3f6
// Size: 0x2f8
function private function_4133657288716b4a( params )
{
    zombie_melee::init_zombie_melee_global();
    zombie_loom_web::function_a1e961123aed1e16();
    zombie_loom_web_attack::init_global();
    zombie_loom_teleport::init_global();
    zombie_loom_cocoon::init_global();
    zombie_loom_web_door::init_global();
    zombie_loom_web_content::init_global();
    zombie_loom_medal::function_b19f39e07ee0d40d();
    callback::get_template( self.animsetname ) callback::add( "zombie_melee", &function_e605ecdb27e1ea3c );
    callback::get_template( self.animsetname ) callback::add( "killed_body_cloned", &play_death_fx );
    callback::get_template( self.animsetname ) callback::add( "on_corpse_annihilated", &on_corpse_annihilated );
    callback::get_template( self.animsetname ) callback::add( "on_turned", &function_c43ae7844f78ed94 );
    callback::get_template( self.animsetname ) callback::add( "poisoned", &function_91e753b101229a2 );
    callback::get_template( self.animsetname ) callback::add( "poisoned_end", &function_8c2a60ae74d8ce34 );
    callback::get_template( self.animsetname ) callback::add( "wraith_burned", &function_9a92f215ba32b261 );
    callback::get_template( self.animsetname ) callback::add( "wraith_burned_end", &function_c9afe0de75edf987 );
    callback::get_template( self.animsetname ) callback::add( "burned", &function_2080c9a8a657bc17 );
    callback::get_template( self.animsetname ) callback::add( "burned_end", &function_ef6cb4c9a207699d );
    callback::get_template( self.animsetname ) callback::add( "napalm_burned", &function_2b8879e19ccaeef3 );
    callback::get_template( self.animsetname ) callback::add( "napalm_burned_thermite", &function_aa4be0297708a8fa );
    callback::get_template( self.animsetname ) callback::add( "napalm_burned_end", &function_8b959aabb4069e99 );
    callback::get_template( self.animsetname ) callback::add( "shocked", &function_ce4fe5b7b95b73f6 );
    callback::get_template( self.animsetname ) callback::add( "shocked_end", &function_f8cbef2738adcd18 );
    callback::get_template( self.animsetname ) callback::add( "on_zombie_gutthrow", &function_f1d841513494a362 );
    callback::get_template( self.animsetname ) callback::add( #"hash_87f46f8c460bcb41", &function_fc3061f284ef097a );
    callback::get_template( self.animsetname ) callback::add( #"traverse_teleport_anim_start", &on_traverse_teleport_anim_start );
    callback::get_template( self.animsetname ) callback::add( #"traverse_teleport_anim_end", &function_c5607a00bfd97ebe );
    callback::get_template( self.animsetname ) callback::add( #"traverse_teleport_hide_entity", &function_43cf23ab021b25b1 );
    callback::get_template( self.animsetname ) callback::add( #"traverse_teleport_show_entity", &function_7f7a815d3e454aea );
}

// Namespace zombie_loom
// Params 1
// Checksum 0x6fd8ee12, Offset: 0x6f6
// Size: 0xb8
function function_b1c0bc59875b871b( taskid )
{
    assert( isdefined( self.zombieaisetting ) );
    zombie_init::function_5d23979c4c7c9a52( self.zombieaisetting );
    assert( isdefined( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb ) );
    callback::add( "on_first_ai_init", &function_4133657288716b4a );
    self.fnshouldplaypainanim = &should_play_pain;
    zombie_melee::init_zombie_melee();
    namespace_96f746e657c877bf::init_zombie_ranged_attack();
    zombie_loom_web_attack::init();
    zombie_loom_web::init_zombie_loom_web();
    zombie_loom_teleport::init();
    zombie_loom_cocoon::init();
    zombie_loom_web_door::init();
    zombie_loom_web_content::init();
    zombie_loom_ride::init();
    thread initscriptable();
    return anim.success;
}

// Namespace zombie_loom
// Params 1
// Checksum 0x8b8cb41e, Offset: 0x7b7
// Size: 0x57, Type: bool
function function_a3dd2b45bc71cd28( weapon )
{
    if ( isdefined( weapon ) && function_ec5e321fe43d2fc( weapon ) )
    {
        return true;
    }
    
    if ( self.var_65522105f3bdca37 || isdefined( self.var_bd22ba6c600a23a3 ) || self.forceannihilate || self.var_48960fedb514aedd )
    {
        return true;
    }
    
    return false;
}

// Namespace zombie_loom
// Params 0, eflags: 0x4
// Checksum 0x3c43a25d, Offset: 0x817
// Size: 0x59
function private initscriptable()
{
    self endon( #"death" );
    utility::flag_wait( "scriptables_ready" );
    utility::waittill_any_timeout( level.framedurationseconds, "post_spawn" );
    
    if ( self isscriptable() )
    {
        utility::function_32b24db3127bff40( "base", "base_on" );
        utility::function_32b24db3127bff40( "eye_glow", "default" );
    }
}

// Namespace zombie_loom
// Params 1, eflags: 0x4
// Checksum 0x8a2a532f, Offset: 0x878
// Size: 0x22
function private function_e605ecdb27e1ea3c( params )
{
    if ( isdefined( params.var_2d2aab21299551f8 ) )
    {
        thread function_c97277d9dc4a067d();
    }
}

// Namespace zombie_loom
// Params 0, eflags: 0x4
// Checksum 0x9e42607e, Offset: 0x8a2
// Size: 0x3b
function private function_c97277d9dc4a067d()
{
    self endon( #"death" );
    utility::function_32b24db3127bff40( "bite", "bite" );
    wait 0.5;
    
    if ( isdefined( self ) )
    {
        utility::function_32b24db3127bff40( "bite", "off" );
    }
}

// Namespace zombie_loom
// Params 1, eflags: 0x4
// Checksum 0x823dc538, Offset: 0x8e5
// Size: 0x14b
function private play_death_fx( params )
{
    body = zombie_utils::function_4e99fb1239980783( params );
    utility::function_32b24db3127bff40( "base", "base_off" );
    
    if ( isdefined( body ) )
    {
        if ( self.forceannihilate )
        {
            body endon( #"corpse_deleted" );
            body callback::callback( "on_annihilated" );
            body utility::function_32b24db3127bff40( "death", "death_annihilate" );
            wait 0.08;
            body delete();
            return;
        }
        else
        {
            body utility::function_32b24db3127bff40( "death", "death" );
        }
        
        if ( isdefined( self ) )
        {
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
            else if ( utility::ent_flag( "dissolve_purple" ) )
            {
                body utility::function_32b24db3127bff40( "reveal_death_purple", "reveal_death_purple" );
            }
            
            body endon( #"corpse_deleted" );
            body waittill( #"death_explode" );
            body utility::function_32b24db3127bff40( "death", "death_annihilate" );
            waitframe();
            body delete();
        }
    }
}

// Namespace zombie_loom
// Params 1, eflags: 0x4
// Checksum 0xfe30bd22, Offset: 0xa38
// Size: 0xa0
function private on_corpse_annihilated( params )
{
    level endon( #"game_ended" );
    corpse = params.corpse;
    
    if ( isdefined( corpse ) )
    {
        if ( isdefined( params.annihilate_time ) )
        {
            wait_time = params.annihilate_time - level.framedurationseconds;
            
            if ( wait_time >= level.framedurationseconds )
            {
                wait wait_time;
            }
            else
            {
                waittillframeend();
            }
        }
        
        if ( isdefined( corpse ) )
        {
            corpse callback::callback( "on_annihilated" );
            corpse utility::function_32b24db3127bff40( "death", "death_annihilate" );
        }
    }
}

// Namespace zombie_loom
// Params 1, eflags: 0x4
// Checksum 0x683c261c, Offset: 0xae0
// Size: 0x1d
function private function_c43ae7844f78ed94( attacker )
{
    utility::function_32b24db3127bff40( "brainrot", "brainrot_on" );
}

// Namespace zombie_loom
// Params 1, eflags: 0x4
// Checksum 0x7f0b002f, Offset: 0xb05
// Size: 0x1d
function private function_91e753b101229a2( s_burn_effect )
{
    utility::function_32b24db3127bff40( "poisoned", "poisoned_on" );
}

// Namespace zombie_loom
// Params 1, eflags: 0x4
// Checksum 0x424b622f, Offset: 0xb2a
// Size: 0x29
function private function_8c2a60ae74d8ce34( s_burn_effect )
{
    utility::ent_flag_clear( "poisoned" );
    utility::function_7c10ea82c1e305b8( "poisoned", "poisoned_off" );
}

// Namespace zombie_loom
// Params 1, eflags: 0x4
// Checksum 0x8479d3ec, Offset: 0xb5b
// Size: 0x1d
function private function_9a92f215ba32b261( s_burn_effect )
{
    utility::function_32b24db3127bff40( "wraith_burned", "wraith_burned_on" );
}

// Namespace zombie_loom
// Params 1, eflags: 0x4
// Checksum 0x38d68c47, Offset: 0xb80
// Size: 0x29
function private function_c9afe0de75edf987( s_burn_effect )
{
    utility::ent_flag_clear( "wraith_burned" );
    utility::function_7c10ea82c1e305b8( "wraith_burned", "wraith_burned_off" );
}

// Namespace zombie_loom
// Params 1, eflags: 0x4
// Checksum 0xc9118f16, Offset: 0xbb1
// Size: 0x3f
function private function_2080c9a8a657bc17( s_burn_effect )
{
    var_7dddc60e0205506b = s_burn_effect.var_7dddc60e0205506b ?? "";
    utility::function_32b24db3127bff40( "burned" + var_7dddc60e0205506b, "burned_on" );
}

// Namespace zombie_loom
// Params 1, eflags: 0x4
// Checksum 0x3b1474d7, Offset: 0xbf8
// Size: 0x3f
function private function_ef6cb4c9a207699d( s_burn_effect )
{
    var_7dddc60e0205506b = s_burn_effect.var_7dddc60e0205506b ?? "";
    utility::function_7c10ea82c1e305b8( "burned" + var_7dddc60e0205506b, "burned_off" );
}

// Namespace zombie_loom
// Params 0, eflags: 0x4
// Checksum 0x12082f69, Offset: 0xc3f
// Size: 0x25
function private function_fc12a24729ef4e67()
{
    self endon( #"corpse_deleted" );
    wait 3;
    utility::function_7c10ea82c1e305b8( "burned", "burned_off" );
}

// Namespace zombie_loom
// Params 1, eflags: 0x4
// Checksum 0x30c72fad, Offset: 0xc6c
// Size: 0x1d
function private function_2b8879e19ccaeef3( s_burn_effect )
{
    utility::function_32b24db3127bff40( "napalm_burned", "napalm_burned_on" );
}

// Namespace zombie_loom
// Params 1, eflags: 0x4
// Checksum 0x562e820d, Offset: 0xc91
// Size: 0x1d
function private function_aa4be0297708a8fa( s_burn_effect )
{
    utility::function_32b24db3127bff40( "napalm_burned", "napalm_burned_on_thermite" );
}

// Namespace zombie_loom
// Params 1, eflags: 0x4
// Checksum 0x49f928cb, Offset: 0xcb6
// Size: 0x1d
function private function_8b959aabb4069e99( s_burn_effect )
{
    utility::function_7c10ea82c1e305b8( "napalm_burned", "napalm_burned_off" );
}

// Namespace zombie_loom
// Params 1, eflags: 0x4
// Checksum 0x18b584b3, Offset: 0xcdb
// Size: 0x1d
function private function_ce4fe5b7b95b73f6( s_shock_effect )
{
    utility::function_32b24db3127bff40( "shocked", "shocked_on" );
}

// Namespace zombie_loom
// Params 1, eflags: 0x4
// Checksum 0x8f242303, Offset: 0xd00
// Size: 0x1d
function private function_f8cbef2738adcd18( s_shock_effect )
{
    utility::function_7c10ea82c1e305b8( "shocked", "shocked_off" );
}

// Namespace zombie_loom
// Params 0, eflags: 0x4
// Checksum 0x49af89b2, Offset: 0xd25
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

// Namespace zombie_loom
// Params 1, eflags: 0x4
// Checksum 0x2f8a173e, Offset: 0xd8b
// Size: 0x42
function private function_fc3061f284ef097a( params )
{
    mover = params.mover;
    
    if ( isdefined( self.var_41a3841fc2dd4012 ) )
    {
        self.var_41a3841fc2dd4012 utility::scriptable_setparententity( mover );
    }
}

// Namespace zombie_loom
// Params 1, eflags: 0x4
// Checksum 0x35ee9e0d, Offset: 0xdd5
// Size: 0x77
function private on_traverse_teleport_anim_start( params )
{
    if ( self.traversestartnode )
    {
        utility::callsharedfunc( #"zombie", #"hash_f6e4eb2937988fb2", self.traversestartnode.origin );
    }
    
    self notify( #"traverse_teleport_anim_start" );
    val::set( "traverse_teleport", "damage", 0 );
    utility::delaythreadendon( 3, "traverse_teleport_anim_start", &function_c5607a00bfd97ebe, params );
}

// Namespace zombie_loom
// Params 1, eflags: 0x4
// Checksum 0x7c90bd10, Offset: 0xe54
// Size: 0x18
function private function_c5607a00bfd97ebe( params )
{
    val::reset_all( "traverse_teleport" );
}

// Namespace zombie_loom
// Params 1, eflags: 0x4
// Checksum 0x190698c5, Offset: 0xe74
// Size: 0xbf
function private function_43cf23ab021b25b1( params )
{
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    
    if ( settings.var_742f0fd8db8d6cc9 && settings.var_2f6f606546b00d83 )
    {
        if ( self.var_41a3841fc2dd4012 )
        {
            self.var_41a3841fc2dd4012 utility::scriptable_clearparententity();
            self.var_41a3841fc2dd4012 freescriptable();
        }
        
        self.var_41a3841fc2dd4012 = spawnscriptable( settings.var_742f0fd8db8d6cc9, self.origin + ( 0, 0, 20 ) );
        self.var_41a3841fc2dd4012 setscriptablepartstate( settings.var_2f6f606546b00d83, "on" );
    }
}

// Namespace zombie_loom
// Params 1, eflags: 0x4
// Checksum 0xfa1cb247, Offset: 0xf3b
// Size: 0x9d
function private function_7f7a815d3e454aea( params )
{
    level endon( #"game_ended" );
    
    if ( self.var_41a3841fc2dd4012 )
    {
        var_41a3841fc2dd4012 = self.var_41a3841fc2dd4012;
        settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
        part_name = settings.var_2f6f606546b00d83;
        var_41a3841fc2dd4012 utility::scriptable_clearparententity();
        self.var_41a3841fc2dd4012 = undefined;
        wait 0.2;
        
        if ( var_41a3841fc2dd4012 )
        {
            var_41a3841fc2dd4012 setscriptablepartstate( part_name, "off" );
            var_41a3841fc2dd4012 freescriptable();
        }
    }
}

// Namespace zombie_loom
// Params 1, eflags: 0x4
// Checksum 0x6bfea002, Offset: 0xfe0
// Size: 0x36
function private function_f1d841513494a362( params )
{
    if ( params.projectile )
    {
        params.projectile utility::function_32b24db3127bff40( "spit", "aerial" );
    }
}

// Namespace zombie_loom
// Params 0, eflags: 0x4
// Checksum 0x4b065ff1, Offset: 0x101e
// Size: 0x36, Type: bool
function private should_play_pain()
{
    if ( !self.allowpain )
    {
        return false;
    }
    
    if ( !self.last_dmg_struct.biscritical )
    {
        return false;
    }
    
    if ( self function_1b4c437a6367712b() )
    {
        return false;
    }
    
    return true;
}

