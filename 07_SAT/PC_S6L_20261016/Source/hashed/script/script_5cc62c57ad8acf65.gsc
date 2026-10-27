// script_5cc62c57ad8acf65  (hash_5cc62c57ad8acf65.gscc) (size: 4513 Bytes / 0x11a1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2d925fc2 (764567490)
// size ...... 4513 (0x11a1)
// includes .. 10  (offset: 0xfa1)
// strings ... 25  (offset: 0xff1)
// dev strs .. 0   (offset: 0x11a1)
// exports ... 16  (offset: 0x8a1)
// cseg ...... 0x1c3 + 0x6de (0x8a1)
// imports ... 38  (offset: 0xb21)
// animtree1 . 0   (offset: 0x11a1)
// animtree2 . 0   (offset: 0x11a1)
#using script_1bfe8e965532ee8a;
#using script_2cd07641bf71242a;
#using script_33781ab60ef13663;
#using scripts\asm\asm;
#using scripts\asm\shared\variant_asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\shared\zombie\zombie_wander;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace zombie_mimic_asm;

// Namespace zombie_mimic_asm
// Params 0, eflags: 0x4
// Checksum 0x86f39e51, Offset: 0x1e1
// Size: 0x151
function private function_cfbb84b3d7bc65b8()
{
    function_a0e3f6f7797bd838();
    function_41d92e3a00d4cc79();
    namespace_7e2991bc3f84c62a::function_b53ccf032ed6922f( 1 );
    callback::get_template( self.animsetname ) callback::add( "on_is_moving_melee_changed", &on_is_moving_melee_changed );
    callback::get_template( self.animsetname ) callback::add( "on_move_speed_changed", &on_move_speed_changed );
    level.scr_anim[ self.animname ][ "spawn" ] = "spawn";
    level.scr_anim[ self.animname ][ "spawn_fast" ] = "spawn_fast";
    level.scr_anim[ self.animname ][ "emerge" ] = "emerge";
    level.scr_anim[ self.animname ][ "emerge_sprint" ] = "emerge_sprint";
    level.scr_anim[ self.animname ][ "emerge_attack" ] = "emerge_attack";
    level.scr_anim[ self.animname ][ "emerge_attack_hit" ] = "emerge_attack_hit";
    level.scr_anim[ self.animname ][ "emerge_attack_miss" ] = "emerge_attack_miss";
    level.scr_anim[ self.animname ][ "portal_jump_up" ] = "portal_jump_up";
}

// Namespace zombie_mimic_asm
// Params 3
// Checksum 0x6b9c3ee6, Offset: 0x33a
// Size: 0x114
function function_8b0cbc74310f3dab( asmname, statename, params )
{
    if ( self.var_cc3703385f725b39 )
    {
        return;
    }
    
    self.var_cc3703385f725b39 = 1;
    
    if ( utility::ent_flag( "zombie_asm_init_finished" ) )
    {
        return;
    }
    
    zombie_init::zombie_init_ai_asm( &function_cfbb84b3d7bc65b8 );
    self.asm.footsteps = spawnstruct();
    self.asm.footsteps.foot = "invalid";
    self.asm.footsteps.time = 0;
    self.asm.customdata = spawnstruct();
    asm::asm_setmoveplaybackrate( 1 );
    thread zombie_wander::wander_listener();
    thread lowg_listener();
    namespace_ef0cd975820ec3b::function_1e9b4a2fe400d128( "melee" );
    zombie_traverse_asm::init_zombie_traverse_asm();
    namespace_ad26fae8b8e8dfb9::init_ranged_attack_asm();
    callback::add( "on_ai_init", &on_ai_init );
    utility::ent_flag_set( "zombie_asm_init_finished" );
}

// Namespace zombie_mimic_asm
// Params 1, eflags: 0x4
// Checksum 0xdb9e0260, Offset: 0x456
// Size: 0x2f
function private on_ai_init( params )
{
    zombie_utils::function_a8ce00e0448cb6f0( "run", "aitype_default", 0 );
    callback::remove( "on_ai_init", &on_ai_init );
}

// Namespace zombie_mimic_asm
// Params 0, eflags: 0x4
// Checksum 0x926ea891, Offset: 0x48d
// Size: 0x2f
function private lowg_listener()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"hash_65b20bec77a97f2a" );
        namespace_ef0cd975820ec3b::function_1e9b4a2fe400d128( "move" );
    }
}

// Namespace zombie_mimic_asm
// Params 1
// Checksum 0x14a314f7, Offset: 0x4c4
// Size: 0x24
function on_move_speed_changed( params )
{
    namespace_ef0cd975820ec3b::function_1e9b4a2fe400d128( "melee" );
    namespace_ef0cd975820ec3b::function_1e9b4a2fe400d128( "move" );
}

// Namespace zombie_mimic_asm
// Params 1
// Checksum 0x3db905f2, Offset: 0x4f0
// Size: 0x24
function on_is_moving_melee_changed( params )
{
    namespace_ef0cd975820ec3b::function_1e9b4a2fe400d128( "melee" );
    namespace_ef0cd975820ec3b::function_1e9b4a2fe400d128( "move" );
}

// Namespace zombie_mimic_asm
// Params 0
// Checksum 0x37c25dfc, Offset: 0x51c
// Size: 0x80
function function_41d92e3a00d4cc79()
{
    namespace_ef0cd975820ec3b::register_anim_variant( "move", &function_83979130715e100f, &function_bf404fd24aab4c49 );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "move", function_39ca1a41b0038b36( "walk" ), 2 );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "move", function_39ca1a41b0038b36( "run" ), 2 );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "move", function_39ca1a41b0038b36( "walk", 1 ), 2 );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "move", function_39ca1a41b0038b36( "run", 1 ), 2 );
}

// Namespace zombie_mimic_asm
// Params 2, eflags: 0x4
// Checksum 0x236c8aba, Offset: 0x5a4
// Size: 0x43
function private function_39ca1a41b0038b36( var_a0ba2bd8aec21d38, low_gravity )
{
    struct = spawnstruct();
    struct.var_a0ba2bd8aec21d38 = var_a0ba2bd8aec21d38;
    struct.low_gravity = low_gravity;
    return struct;
}

// Namespace zombie_mimic_asm
// Params 1, eflags: 0x4
// Checksum 0x38b52fa4, Offset: 0x5f0
// Size: 0x9d
function private function_83979130715e100f( struct )
{
    alias = "";
    
    if ( isdefined( struct.var_a0ba2bd8aec21d38 ) )
    {
        alias += struct.var_a0ba2bd8aec21d38;
        
        if ( self._blackboard.movetype != struct.var_a0ba2bd8aec21d38 )
        {
            return;
        }
    }
    
    gravity_scale = self function_86ed482450424a47();
    
    if ( struct.low_gravity )
    {
        alias += "_lowg";
        
        if ( gravity_scale >= 1 )
        {
            return;
        }
    }
    else if ( gravity_scale < 1 )
    {
        return;
    }
    
    return alias;
}

// Namespace zombie_mimic_asm
// Params 1, eflags: 0x4
// Checksum 0x6f58d98d, Offset: 0x696
// Size: 0x45
function private function_bf404fd24aab4c49( alias )
{
    self function_695b8e1b655c2796( "move", alias );
    
    if ( asm::asm_currentstatehasflag( self.asmname, "move" ) )
    {
        asm::asm_fireevent_internal( self.asmname, "loop_reroll_anim" );
    }
}

// Namespace zombie_mimic_asm
// Params 0
// Checksum 0xaafafd33, Offset: 0x6e3
// Size: 0x5e
function function_a0e3f6f7797bd838()
{
    namespace_ef0cd975820ec3b::register_anim_variant( "melee", &function_a51510d63b8a632, &function_3301a5711e996c8 );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "melee", function_774051f9d32fd993( 1, "walk" ) );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "melee", function_774051f9d32fd993( 1, "run" ) );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "melee", function_774051f9d32fd993( 0, undefined ) );
}

// Namespace zombie_mimic_asm
// Params 2, eflags: 0x4
// Checksum 0x93986deb, Offset: 0x749
// Size: 0x43
function private function_774051f9d32fd993( is_moving_melee, var_a0ba2bd8aec21d38 )
{
    struct = spawnstruct();
    struct.is_moving_melee = is_moving_melee;
    struct.var_a0ba2bd8aec21d38 = var_a0ba2bd8aec21d38;
    return struct;
}

// Namespace zombie_mimic_asm
// Params 1, eflags: 0x4
// Checksum 0x8be2f51a, Offset: 0x795
// Size: 0xae
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
        
        if ( self._blackboard.movetype != struct.var_a0ba2bd8aec21d38 )
        {
            return;
        }
    }
    
    return alias;
}

// Namespace zombie_mimic_asm
// Params 1, eflags: 0x4
// Checksum 0xcc1c699a, Offset: 0x84c
// Size: 0x19
function private function_3301a5711e996c8( alias )
{
    self function_695b8e1b655c2796( "melee", alias );
}

// Namespace zombie_mimic_asm
// Params 3, eflags: 0x4
// Checksum 0xab082eb7, Offset: 0x86d
// Size: 0x34
function private function_115bcc58ebc20fb3( asmname, statename, params )
{
    playfxontag( utility::getfx( "mimic_hide_fx" ), self, "j_spine4" );
}

