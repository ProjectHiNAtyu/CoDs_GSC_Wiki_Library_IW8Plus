// scripts\common\ai\aitypes\zombie_parasite\zombie_parasite_emergence_spawning.gsc  (hash_745fbeefab97b560.gscc) (size: 2308 Bytes / 0x904 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7e828837 (2122483767)
// size ...... 2308 (0x904)
// includes .. 7   (offset: 0x83c)
// strings ... 11  (offset: 0x874)
// dev strs .. 0   (offset: 0x904)
// exports ... 9   (offset: 0x490)
// cseg ...... 0x13e + 0x352 (0x490)
// imports ... 20  (offset: 0x5f8)
// animtree1 . 0   (offset: 0x904)
// animtree2 . 0   (offset: 0x904)
#using scripts\asm\asm_bb;
#using scripts\common\ai\aitypes\shared\zombie\zombie_emergence_spawning;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_parasite\zombie_parasite;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_parasite_emergence_spawning;

// Namespace zombie_parasite_emergence_spawning
// Params 0
// Checksum 0x78385b11, Offset: 0x15c
// Size: 0x42
function function_22e6cae78206d7e9()
{
    callback::get_template( self.animsetname ) callback::add( "spawned_from_emergence", &get_parasite_host_data );
    callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_killed", &should_disable_emergence_spawning );
}

// Namespace zombie_parasite_emergence_spawning
// Params 0
// Checksum 0xfcef3c99, Offset: 0x1a6
// Size: 0x17
function init_zombie_parasite_emergence_spawning()
{
    thread function_e66678915b8a0505();
    thread function_29e05703f3bbd119();
    thread add_husk_armor();
}

// Namespace zombie_parasite_emergence_spawning
// Params 0, eflags: 0x4
// Checksum 0x170eb2fa, Offset: 0x1c5
// Size: 0xd0
function private function_e66678915b8a0505()
{
    self endon( #"death" );
    self waittill( #"spawned_from_emergence_through_death" );
    var_85abed5b69bba891 = [ self.collide_with_ai, self.collide_with_ai_allies_smaller ];
    self.collide_with_ai = 0;
    self.collide_with_ai_allies_smaller = 0;
    val::set_array( "emergence_spawning", [ "disallow_knockdown", "postpone_stun" ], 1 );
    val::set_array( "emergence_spawning", [ "allow_brot", "show_healthbar" ], 0 );
    self waittill( #"reached_air_after_emergence_spawning" );
    self.collide_with_ai = var_85abed5b69bba891[ 0 ];
    self.collide_with_ai_allies_smaller = var_85abed5b69bba891[ 1 ];
    val::reset_all( "emergence_spawning" );
    asm_bb::bb_clearanimscripted();
}

// Namespace zombie_parasite_emergence_spawning
// Params 0, eflags: 0x4
// Checksum 0x8243c80a, Offset: 0x29d
// Size: 0x35
function private function_29e05703f3bbd119()
{
    self endon( #"death" );
    self waittill( #"spawned_from_emergence_through_death" );
    utility::waittill_any_timeout( 4, "unlink_spawned_ai" );
    self motionwarpcancel();
    self unlink();
}

// Namespace zombie_parasite_emergence_spawning
// Params 0, eflags: 0x4
// Checksum 0x5a81f9ab, Offset: 0x2da
// Size: 0x41
function private add_husk_armor()
{
    self endon( #"death" );
    self waittill( #"spawned_from_emergence_through_death" );
    zombie_utils::function_dfae6a5bd222c586( &function_568c10ce93809f4 );
    utility::waittill_any_timeout( 4, "remove_husk_armor" );
    zombie_utils::function_10c0c35c21e3ed9d( &function_568c10ce93809f4 );
}

// Namespace zombie_parasite_emergence_spawning
// Params 1, eflags: 0x4
// Checksum 0x4617da80, Offset: 0x323
// Size: 0x43
function private function_568c10ce93809f4( params )
{
    var_f26f94ad67acaf1a = 0.3;
    husk_armor = self.var_876c6234561db187 ?? var_f26f94ad67acaf1a;
    return params.idamage * husk_armor;
}

// Namespace zombie_parasite_emergence_spawning
// Params 1, eflags: 0x4
// Checksum 0x29d99bad, Offset: 0x36f
// Size: 0xbc
function private get_parasite_host_data( params )
{
    if ( isdefined( params.var_dc455978ffd98d95 ) )
    {
        disciple_parent_data = params.var_dc455978ffd98d95[ "disciple_parent" ];
        
        if ( isdefined( disciple_parent_data ) )
        {
            self [[ disciple_parent_data.var_b3e176999aae46d7 ]]( disciple_parent_data.disciple_parent, disciple_parent_data.var_9ad7cc5d07653ebc );
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

// Namespace zombie_parasite_emergence_spawning
// Params 1, eflags: 0x4
// Checksum 0xef424dd8, Offset: 0x433
// Size: 0x5d
function private should_disable_emergence_spawning( params )
{
    if ( isdefined( self.evolution.host ) )
    {
        callback::callback( "spawned_from_emergence", self.evolution );
    }
    
    if ( zombie_parasite::function_a3dd2b45bc71cd28( params.eattacker.currentprimaryweapon ) )
    {
        zombie_emergence_spawning::function_80623a2279a4d888();
    }
}

