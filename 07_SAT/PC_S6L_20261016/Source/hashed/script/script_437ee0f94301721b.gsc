// script_437ee0f94301721b  (hash_437ee0f94301721b.gscc) (size: 1869 Bytes / 0x74d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4f72bad3 (1332918995)
// size ...... 1869 (0x74d)
// includes .. 4   (offset: 0x6b9)
// strings ... 9   (offset: 0x6d9)
// dev strs .. 0   (offset: 0x74d)
// exports ... 11  (offset: 0x359)
// cseg ...... 0xe3 + 0x276 (0x359)
// imports ... 15  (offset: 0x511)
// animtree1 . 0   (offset: 0x74d)
// animtree2 . 0   (offset: 0x74d)
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace zombie_uranus_asm;

// Namespace zombie_uranus_asm
// Params 3
// Checksum 0x9db75166, Offset: 0x101
// Size: 0x5f
function function_554d03240b1eff2a( asmname, statename, params )
{
    if ( self.var_cc3703385f725b39 )
    {
        return;
    }
    
    self.var_cc3703385f725b39 = 1;
    zombie_init::zombie_init_ai_asm( &function_cfbb84b3d7bc65b8 );
    callback::add( "on_ai_init", &on_ai_init );
    utility::ent_flag_set( "zombie_asm_init_finished" );
}

// Namespace zombie_uranus_asm
// Params 0, eflags: 0x4
// Checksum 0x82be133, Offset: 0x168
// Size: 0x2
function private function_cfbb84b3d7bc65b8()
{
    
}

// Namespace zombie_uranus_asm
// Params 1, eflags: 0x4
// Checksum 0xe6f92b55, Offset: 0x172
// Size: 0xc
function private on_ai_init( params )
{
    
}

// Namespace zombie_uranus_asm
// Params 1
// Checksum 0x7d378d9e, Offset: 0x186
// Size: 0x42
function get_anim_length( statename )
{
    animid = asm::asm_getanim( self.asmname, statename );
    animation = asm::asm_getxanim( statename, animid );
    return getanimlength( animation );
}

// Namespace zombie_uranus_asm
// Params 0
// Checksum 0xebd263d9, Offset: 0x1d1
// Size: 0x16
function start_pain()
{
    self asmsetstate( self.asmname, "pain_intro" );
}

// Namespace zombie_uranus_asm
// Params 0
// Checksum 0x99318f0b, Offset: 0x1ef
// Size: 0x17
function end_pain()
{
    asm::asm_fireevent( self.asmname, "exit_pain" );
}

// Namespace zombie_uranus_asm
// Params 0
// Checksum 0x3ad7d81e, Offset: 0x20e
// Size: 0x16
function death()
{
    self asmsetstate( self.asmname, "death_generic" );
}

// Namespace zombie_uranus_asm
// Params 1
// Checksum 0x91c52f6c, Offset: 0x22c
// Size: 0xdb
function set_phase( phase )
{
    featurearray = [];
    featurearray[ "fight_phase" ] = phase;
    states = [ "pain_intro", "pain_loop", "pain_outro" ];
    
    foreach ( state in states )
    {
        alias = self function_805ca5e408d630c0( self.asmname, state, featurearray, 0 );
        
        if ( isdefined( alias ) )
        {
            self function_695b8e1b655c2796( state, alias );
        }
    }
}

// Namespace zombie_uranus_asm
// Params 2
// Checksum 0x8f92aac1, Offset: 0x30f
// Size: 0x22
function function_2f75d2599080596a( asmname, params )
{
    self function_786bb6aa1b76c7ee( "in_pain", 1 );
}

// Namespace zombie_uranus_asm
// Params 2
// Checksum 0xfd5e55d7, Offset: 0x339
// Size: 0x20
function function_71bddc779b65611f( asmname, params )
{
    self function_f2df0257c63f229( "in_pain" );
}

