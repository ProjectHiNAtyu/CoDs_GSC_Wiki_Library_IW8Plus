// script_747a3e7e01d497c7  (hash_747a3e7e01d497c7.gscc) (size: 1548 Bytes / 0x60c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb13f8179 (2973729145)
// size ...... 1548 (0x60c)
// includes .. 3   (offset: 0x570)
// strings ... 9   (offset: 0x588)
// dev strs .. 0   (offset: 0x60c)
// exports ... 7   (offset: 0x2d4)
// cseg ...... 0xbd + 0x217 (0x2d4)
// imports ... 13  (offset: 0x3ec)
// animtree1 . 0   (offset: 0x60c)
// animtree2 . 0   (offset: 0x60c)
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\utility;

#namespace zombie_aeon_asm;

// Namespace zombie_aeon_asm
// Params 0, eflags: 0x4
// Checksum 0x9f7182d0, Offset: 0xdb
// Size: 0x2
function private function_34ebc247476ce26c()
{
    
}

// Namespace zombie_aeon_asm
// Params 3
// Checksum 0x4bba46e2, Offset: 0xe5
// Size: 0x65
function function_f9f0b5eb64f494bd( asmname, statename, params )
{
    if ( self.var_cc3703385f725b39 )
    {
        return;
    }
    
    self.var_cc3703385f725b39 = 1;
    zombie_init::zombie_init_ai_asm( &function_34ebc247476ce26c );
    self function_695b8e1b655c2796( "idle", "default" );
    thread function_a4adfa3da22dd68b();
    utility::ent_flag_set( "zombie_asm_init_finished" );
}

// Namespace zombie_aeon_asm
// Params 1
// Checksum 0x4ce84225, Offset: 0x152
// Size: 0x25
function function_a31680b57c8f7950( aeon )
{
    if ( !isalive( aeon ) )
    {
        return;
    }
    
    aeon asm::function_7256f5ba459c840b( "shoot_in" );
}

// Namespace zombie_aeon_asm
// Params 2
// Checksum 0x67c4309f, Offset: 0x17f
// Size: 0xdd
function function_69ff524cca32dbff( aeon, source_origin )
{
    if ( !isalive( aeon ) )
    {
        return;
    }
    
    if ( !source_origin )
    {
        aeon function_695b8e1b655c2796( "pain", "left" );
    }
    else
    {
        var_ac141042c7697499 = angleclamp180( vectortoyaw( source_origin - aeon.origin ) - aeon.angles[ 1 ] );
        alias = undefined;
        
        if ( abs( var_ac141042c7697499 ) < 45 )
        {
            alias = "front";
        }
        else if ( abs( var_ac141042c7697499 ) > 135 )
        {
            alias = "back";
        }
        else if ( var_ac141042c7697499 < 0 )
        {
            alias = "left";
        }
        else if ( var_ac141042c7697499 > 0 )
        {
            alias = "right";
        }
        
        aeon function_695b8e1b655c2796( "pain", alias );
    }
    
    aeon asm::asm_setstate( "pain" );
}

// Namespace zombie_aeon_asm
// Params 2
// Checksum 0x7abac8f6, Offset: 0x264
// Size: 0x52
function update_idle_anim( aeon, alias = "default" )
{
    aeon function_695b8e1b655c2796( "idle", alias );
    
    if ( aeon asm::asm_getcurrentstate( aeon.asmname ) == "idle" )
    {
        self restartanim( 0 );
    }
}

// Namespace zombie_aeon_asm
// Params 0, eflags: 0x4
// Checksum 0xd2e89ed7, Offset: 0x2be
// Size: 0x16
function private function_a4adfa3da22dd68b()
{
    self endon( #"death" );
    waitframe();
    self restartanim( 0 );
}

