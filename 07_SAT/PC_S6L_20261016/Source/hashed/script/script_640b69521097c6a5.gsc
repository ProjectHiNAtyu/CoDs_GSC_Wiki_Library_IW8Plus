// script_640b69521097c6a5  (hash_640b69521097c6a5.gscc) (size: 2212 Bytes / 0x8a4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x11d68095 (299270293)
// size ...... 2212 (0x8a4)
// includes .. 10  (offset: 0x7b0)
// strings ... 12  (offset: 0x800)
// dev strs .. 0   (offset: 0x8a4)
// exports ... 8   (offset: 0x400)
// cseg ...... 0x10f + 0x2f1 (0x400)
// imports ... 21  (offset: 0x540)
// animtree1 . 0   (offset: 0x8a4)
// animtree2 . 0   (offset: 0x8a4)
#using script_22800c62e91a8956;
#using script_5d3960c405a24eb9;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\shared\zombie\zombie_wander;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_weyward_asm;

// Namespace zombie_weyward_asm
// Params 0, eflags: 0x4
// Checksum 0xebc2bec, Offset: 0x12d
// Size: 0x47
function private function_77638f66bcdde2b6()
{
    level.scr_anim[ self.animname ][ "spawn" ] = "spawn";
    level.scr_anim[ self.animname ][ "teleport" ] = "teleport";
    namespace_b76e7e4c1d057ec1::function_c0467b6eefab8cac();
}

// Namespace zombie_weyward_asm
// Params 3
// Checksum 0x26180b52, Offset: 0x17c
// Size: 0x6d
function function_dc3675a1bcb7673f( asmname, statename, params )
{
    if ( self.var_cc3703385f725b39 )
    {
        return;
    }
    
    self.var_cc3703385f725b39 = 1;
    zombie_init::zombie_init_ai_asm( &function_77638f66bcdde2b6 );
    thread zombie_wander::wander_listener();
    callback::add( "on_ai_init", &on_ai_init );
    namespace_b76e7e4c1d057ec1::function_a887d53ac5484b73();
    utility::ent_flag_set( "zombie_asm_init_finished" );
}

// Namespace zombie_weyward_asm
// Params 1, eflags: 0x4
// Checksum 0x5b81d893, Offset: 0x1f1
// Size: 0x2f
function private on_ai_init( params )
{
    zombie_utils::function_a8ce00e0448cb6f0( "run", "aitype_default", 0 );
    callback::remove( "on_ai_init", &on_ai_init );
}

// Namespace zombie_weyward_asm
// Params 2
// Checksum 0x6c1f4365, Offset: 0x228
// Size: 0xbc
function function_69ff524cca32dbff( weyward, source_origin )
{
    if ( !isalive( weyward ) )
    {
        return;
    }
    
    if ( weyward getaiblackboarddynamic( "in_real_death" ) || weyward getaiblackboarddynamic( "in_fake_death" ) )
    {
        return;
    }
    
    if ( weyward zombie_stun::is_stunned() )
    {
        return;
    }
    
    if ( !weyward val::get( "special_pain" ) )
    {
        return;
    }
    
    if ( weyward utility::ent_flag( "disable_special_pain" ) )
    {
        return;
    }
    
    if ( isdefined( weyward.var_80521f0adf3a76b9 ) && !utility::time_has_passed( weyward.var_80521f0adf3a76b9, 10 ) )
    {
        return;
    }
    
    weyward asm::function_7256f5ba459c840b( "full_pain" );
    weyward.var_80521f0adf3a76b9 = gettime();
    weyward zombie_weyward_metabones::function_995b6dfb3ab95f0c();
}

// Namespace zombie_weyward_asm
// Params 2
// Checksum 0x7f6d2f0, Offset: 0x2ec
// Size: 0xa5
function function_ba47976c06174596( weyward, is_left )
{
    if ( !isalive( weyward ) )
    {
        return;
    }
    
    if ( weyward getaiblackboarddynamic( "in_real_death" ) || weyward getaiblackboarddynamic( "in_fake_death" ) )
    {
        return;
    }
    
    if ( !weyward val::get( "pain" ) )
    {
        return;
    }
    
    if ( isdefined( weyward.var_73073e5c8c13a868 ) && !utility::time_has_passed( weyward.var_73073e5c8c13a868, 8 ) )
    {
        return;
    }
    
    weyward function_68f2f6fd8a4ffcae( 0, is_left ? 1 : 2 );
    weyward.var_73073e5c8c13a868 = gettime();
    weyward thread function_f7ecf3395c3f601a();
}

// Namespace zombie_weyward_asm
// Params 0, eflags: 0xc
// Checksum 0xab2946fc, Offset: 0x399
// Size: 0x31
function private function_f7ecf3395c3f601a()
{
    self notify( #"hash_e46fdc6e183bc6ce" );
    self endon( #"hash_e46fdc6e183bc6ce" );
    self endon( #"death" );
    wait 3;
    self function_68f2f6fd8a4ffcae( 0, 0 );
}

/#

    // Namespace zombie_weyward_asm
    // Params 2
    // Checksum 0x1326009f, Offset: 0x3d2
    // Size: 0x2e, Type: dev
    function function_f8aee546f5ed4cfb( source, target_state )
    {
        self.var_1255ebc938b150f7 = source;
        self.var_89d59e0ee13dba2b = target_state;
    }

#/
