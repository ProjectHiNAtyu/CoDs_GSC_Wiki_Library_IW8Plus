// script_17124ef387302ed9  (hash_17124ef387302ed9.gscc) (size: 2692 Bytes / 0xa84 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x460e8113 (1175355667)
// size ...... 2692 (0xa84)
// includes .. 9   (offset: 0x95c)
// strings ... 15  (offset: 0x9a4)
// dev strs .. 0   (offset: 0xa84)
// exports ... 9   (offset: 0x4f8)
// cseg ...... 0x129 + 0x3cf (0x4f8)
// imports ... 25  (offset: 0x660)
// animtree1 . 0   (offset: 0xa84)
// animtree2 . 0   (offset: 0xa84)
#using script_2cd07641bf71242a;
#using script_33781ab60ef13663;
#using script_51a093502a988075;
#using scripts\asm\asm;
#using scripts\asm\shared\variant_asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace zombie_ghoul_asm;

// Namespace zombie_ghoul_asm
// Params 0, eflags: 0x4
// Checksum 0x86101529, Offset: 0x147
// Size: 0x98
function private function_ae4f5cd736d03eba()
{
    namespace_18052412ffe544da::function_1b99bf5d23c4ac37();
    namespace_7e2991bc3f84c62a::function_b53ccf032ed6922f( 1 );
    function_d79921de481ce6f4();
    callback::get_template( self.animsetname ) callback::add( "on_is_moving_melee_changed", &on_is_moving_melee_changed );
    callback::get_template( self.animsetname ) callback::add( "on_turned", &on_is_moving_melee_changed );
    callback::get_template( self.animsetname ) callback::add( "on_brainrot_end", &on_is_moving_melee_changed );
    level.scr_anim[ self.animname ][ "portal_jump_up" ] = "portal_jump_up";
}

// Namespace zombie_ghoul_asm
// Params 3
// Checksum 0x256255b3, Offset: 0x1e7
// Size: 0xf7
function function_cffea90c0041bae7( asmname, statename, params )
{
    if ( self.var_cc3703385f725b39 )
    {
        return;
    }
    
    self.var_cc3703385f725b39 = 1;
    zombie_init::zombie_init_ai_asm( &function_ae4f5cd736d03eba );
    namespace_18052412ffe544da::init_zombie_ghoul_move();
    zombie_traverse_asm::init_zombie_traverse_asm();
    self.asm.footsteps = spawnstruct();
    self.asm.footsteps.foot = "invalid";
    self.asm.footsteps.time = 0;
    self.asm.customdata = spawnstruct();
    asm::asm_setmoveplaybackrate( 1 );
    namespace_ef0cd975820ec3b::function_1e9b4a2fe400d128( "melee" );
    callback::add( "on_ai_init", &on_ai_init );
    utility::ent_flag_set( "zombie_asm_init_finished" );
}

// Namespace zombie_ghoul_asm
// Params 1, eflags: 0x4
// Checksum 0xc1d9d587, Offset: 0x2e6
// Size: 0x2f
function private on_ai_init( params )
{
    zombie_utils::function_a8ce00e0448cb6f0( "sprint", "aitype_default", 0 );
    callback::remove( "on_ai_init", &on_ai_init );
}

// Namespace zombie_ghoul_asm
// Params 1
// Checksum 0xdf718255, Offset: 0x31d
// Size: 0x18
function on_is_moving_melee_changed( params )
{
    namespace_ef0cd975820ec3b::function_1e9b4a2fe400d128( "melee" );
}

// Namespace zombie_ghoul_asm
// Params 0
// Checksum 0x5d5af6a3, Offset: 0x33d
// Size: 0x73
function function_d79921de481ce6f4()
{
    namespace_ef0cd975820ec3b::register_anim_variant( "melee", &function_a51510d63b8a632, &function_3301a5711e996c8 );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "melee", function_774051f9d32fd993( 0, undefined ) );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "melee", function_774051f9d32fd993( 1, "sprint" ) );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "melee", function_774051f9d32fd993( 1, "brainrot" ) );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "melee", function_774051f9d32fd993( 1, undefined ) );
}

// Namespace zombie_ghoul_asm
// Params 2, eflags: 0x4
// Checksum 0x36294b7b, Offset: 0x3b8
// Size: 0x43
function private function_774051f9d32fd993( is_moving_melee, var_a0ba2bd8aec21d38 )
{
    struct = spawnstruct();
    struct.is_moving_melee = is_moving_melee;
    struct.var_a0ba2bd8aec21d38 = var_a0ba2bd8aec21d38;
    return struct;
}

// Namespace zombie_ghoul_asm
// Params 1, eflags: 0x4
// Checksum 0x97f9c0b1, Offset: 0x404
// Size: 0xd2
function private function_a51510d63b8a632( struct )
{
    alias = "";
    
    if ( isdefined( struct.is_moving_melee ) )
    {
        alias += self.is_moving_melee ? "move" : "static";
        
        if ( istrue( self.is_moving_melee ) != struct.is_moving_melee )
        {
            return;
        }
    }
    
    if ( isdefined( struct.var_a0ba2bd8aec21d38 ) )
    {
        alias += "_" + struct.var_a0ba2bd8aec21d38;
        
        if ( zombie_utils::function_bf1464d09f4e4b40() )
        {
            if ( struct.var_a0ba2bd8aec21d38 == "brainrot" )
            {
                return alias;
            }
            else
            {
                return;
            }
        }
        
        if ( self._blackboard.movetype != struct.var_a0ba2bd8aec21d38 )
        {
            return;
        }
    }
    
    return alias;
}

// Namespace zombie_ghoul_asm
// Params 1, eflags: 0x4
// Checksum 0x69ad4f0a, Offset: 0x4df
// Size: 0x19
function private function_3301a5711e996c8( alias )
{
    self function_695b8e1b655c2796( "melee", alias );
}

