// scripts\common\ai\aitypes\zombie_vermin\zombie_vermin_emergence_spawning.gsc  (hash_789003d7d335c6c0.gscc) (size: 2629 Bytes / 0xa45 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2765c070 (660979824)
// size ...... 2629 (0xa45)
// includes .. 7   (offset: 0x92d)
// strings ... 16  (offset: 0x965)
// dev strs .. 0   (offset: 0xa45)
// exports ... 10  (offset: 0x515)
// cseg ...... 0x18b + 0x38a (0x515)
// imports ... 22  (offset: 0x6a5)
// animtree1 . 0   (offset: 0xa45)
// animtree2 . 0   (offset: 0xa45)
#using scripts\asm\asm_bb;
#using scripts\common\ai\aitypes\shared\zombie\zombie_emergence_spawning;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_vermin\zombie_vermin;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_vermin_emergence_spawning;

// Namespace zombie_vermin_emergence_spawning
// Params 0
// Checksum 0x2f492dcf, Offset: 0x1a9
// Size: 0x42
function function_114652f806fd9dff()
{
    callback::get_template( self.animsetname ) callback::add( "spawned_from_emergence", &get_vermin_host_data );
    callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_killed", &should_disable_emergence_spawning );
}

// Namespace zombie_vermin_emergence_spawning
// Params 0
// Checksum 0xdd782fa1, Offset: 0x1f3
// Size: 0x1e
function init_zombie_vermin_emergence_spawning()
{
    thread function_57e88199beeb1e0f();
    thread function_29e05703f3bbd119();
    thread function_3057f145bcb13007();
    thread function_25f1c62b7294999b();
}

// Namespace zombie_vermin_emergence_spawning
// Params 0, eflags: 0x4
// Checksum 0xdea14b11, Offset: 0x219
// Size: 0x79
function private function_57e88199beeb1e0f()
{
    self endon( #"death" );
    utility::function_32b24db3127bff40( "emergence", "off" );
    self waittill( #"spawned_from_emergence_through_death" );
    utility::function_32b24db3127bff40( "emergence", "disable_torso_and_legs" );
    self waittill( #"add_leg_hitboxes" );
    utility::function_32b24db3127bff40( "emergence", "enable_legs" );
    self waittill( #"add_body_hitbox" );
    utility::function_32b24db3127bff40( "emergence", "enable_torso" );
}

// Namespace zombie_vermin_emergence_spawning
// Params 0, eflags: 0x4
// Checksum 0xda9e90f, Offset: 0x29a
// Size: 0x3c
function private function_29e05703f3bbd119()
{
    self endon( #"death" );
    self waittill( #"spawned_from_emergence_through_death" );
    level notify( #"spawned_from_emergence_through_death", self );
    utility::waittill_any_timeout( 4, "unlink_spawned_ai" );
    self unlink();
}

// Namespace zombie_vermin_emergence_spawning
// Params 0, eflags: 0x4
// Checksum 0xc190e7c, Offset: 0x2de
// Size: 0x64
function private function_3057f145bcb13007()
{
    self endon( #"death" );
    self waittill( #"spawned_from_emergence_through_death" );
    zombie_utils::function_dfae6a5bd222c586( &function_568c10ce93809f4 );
    val::set( "emergence_spawning", "show_healthbar", 0 );
    utility::waittill_any_timeout( 4, "remove_husk_armor" );
    zombie_utils::function_10c0c35c21e3ed9d( &function_568c10ce93809f4 );
    val::reset( "emergence_spawning", "show_healthbar" );
}

// Namespace zombie_vermin_emergence_spawning
// Params 1, eflags: 0x4
// Checksum 0x1d7d59da, Offset: 0x34a
// Size: 0x43
function private function_568c10ce93809f4( params )
{
    var_4663a86625125dc2 = 0.3;
    husk_armor = self.var_876c6234561db187 ?? var_4663a86625125dc2;
    return params.idamage * husk_armor;
}

// Namespace zombie_vermin_emergence_spawning
// Params 0, eflags: 0x4
// Checksum 0xf8be4478, Offset: 0x396
// Size: 0x83
function private function_25f1c62b7294999b()
{
    self endon( #"death" );
    self waittill( #"spawned_from_emergence_through_death" );
    self.forceannihilate = 1;
    val::set_array( "emergence_spawning", [ "disallow_knockdown", "postpone_stun" ], 1 );
    val::set( "emergence_spawning", "allow_brot", 0 );
    self waittill( #"reached_ground_after_emergence_spawning" );
    self.forceannihilate = 0;
    val::reset_all( "emergence_spawning" );
    asm_bb::bb_clearanimscripted();
}

// Namespace zombie_vermin_emergence_spawning
// Params 1, eflags: 0x4
// Checksum 0xcf386582, Offset: 0x421
// Size: 0xbb
function private get_vermin_host_data( params )
{
    if ( isdefined( params.var_dc455978ffd98d95 ) )
    {
        disciple_parent_data = params.var_dc455978ffd98d95[ "disciple_parent" ];
        
        if ( isdefined( disciple_parent_data ) )
        {
            [[ disciple_parent_data.var_b3e176999aae46d7 ]]( disciple_parent_data.disciple_parent, disciple_parent_data.var_9ad7cc5d07653ebc );
        }
        
        force_consecutive_spawn_data = params.var_dc455978ffd98d95[ "force_consecutive_spawn" ];
        
        if ( isdefined( force_consecutive_spawn_data ) )
        {
            if ( !isdefined( force_consecutive_spawn_data.var_704873fd9437ee43 ) )
            {
                force_consecutive_spawn_data.var_704873fd9437ee43 = spawnstruct();
            }
            
            self [[ force_consecutive_spawn_data.force_consecutive_spawn_func ]]( force_consecutive_spawn_data.var_704873fd9437ee43 );
        }
    }
}

// Namespace zombie_vermin_emergence_spawning
// Params 1, eflags: 0x4
// Checksum 0xa24451b0, Offset: 0x4e4
// Size: 0x31
function private should_disable_emergence_spawning( params )
{
    if ( zombie_vermin::function_a3dd2b45bc71cd28( params.eattacker.currentprimaryweapon ) )
    {
        zombie_emergence_spawning::function_80623a2279a4d888();
    }
}

