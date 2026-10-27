// script_200c1cd00f9ab885  (hash_200c1cd00f9ab885.gscc) (size: 951 Bytes / 0x3b7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7947898b (2034731403)
// size ...... 951 (0x3b7)
// includes .. 8   (offset: 0x35b)
// strings ... 2   (offset: 0x39b)
// dev strs .. 0   (offset: 0x3b7)
// exports ... 4   (offset: 0x16b)
// cseg ...... 0x7d + 0xee (0x16b)
// imports ... 12  (offset: 0x20b)
// animtree1 . 0   (offset: 0x3b7)
// animtree2 . 0   (offset: 0x3b7)
#using script_1260535c202c8074;
#using script_15efdb5808058ab7;
#using script_193e3e231841082f;
#using script_3397bed1b741f042;
#using script_36d7680b337b15b;
#using script_51003dec974513a9;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\utility;

#namespace zombie_deathworm_asm;

// Namespace zombie_deathworm_asm
// Params 1
// Checksum 0x11d016c9, Offset: 0x9b
// Size: 0x27
function init_asm_precache( aitypescriptbundle )
{
    namespace_473bdc208d3e708a::init_beam_attack_precache( aitypescriptbundle );
    namespace_473bdc208d3e708a::init_burrow_precache( aitypescriptbundle );
    namespace_473bdc208d3e708a::init_mobile_spawner_precache( aitypescriptbundle );
}

// Namespace zombie_deathworm_asm
// Params 0, eflags: 0x4
// Checksum 0x82326d05, Offset: 0xca
// Size: 0x21
function private function_5dcf3bb8aa3149be()
{
    level.scr_anim[ self.animname ][ "spawn" ] = "spawn";
}

// Namespace zombie_deathworm_asm
// Params 3
// Checksum 0xaf42452, Offset: 0xf3
// Size: 0x78
function function_e87e7eda93105917( asmname, statename, params )
{
    if ( self.var_cc3703385f725b39 )
    {
        return;
    }
    
    self.var_cc3703385f725b39 = 1;
    zombie_init::zombie_init_ai_asm( &function_5dcf3bb8aa3149be );
    namespace_636cb8a8ba015294::init_snake_bite();
    namespace_6698c489bf4d184b::init_head_banger();
    namespace_473bdc208d3e708a::init_burrow();
    namespace_473bdc208d3e708a::init_mobile_spawner();
    namespace_473bdc208d3e708a::init_spittle();
    namespace_473bdc208d3e708a::init_beam_attack();
    utility::ent_flag_set( "zombie_asm_init_finished" );
}

