// script_72c82d786b54f0bd  (hash_72c82d786b54f0bd.gscc) (size: 1220 Bytes / 0x4c4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdcb331f8 (3702731256)
// size ...... 1220 (0x4c4)
// includes .. 6   (offset: 0x494)
// strings ... 0   (offset: 0x4c4)
// dev strs .. 0   (offset: 0x4c4)
// exports ... 3   (offset: 0x244)
// cseg ...... 0x58 + 0x1ec (0x244)
// imports ... 16  (offset: 0x2bc)
// animtree1 . 0   (offset: 0x4c4)
// animtree2 . 0   (offset: 0x4c4)
#using script_112673e9f8209cf8;
#using script_7cfee4b69f710eed;
#using scripts\asm\asm;
#using scripts\asm\asm_mp;
#using scripts\common\ai;
#using scripts\mp\agents\agent_init;

#namespace aitype_mp;

// Namespace aitype_mp/aitype_main
// Params 3, eflags: 0x20
// Checksum 0x393b0c43, Offset: 0x76
// Size: 0x17b
function event_handler[aitype_main] main( aitype, selectedcharacter, weaponstruct )
{
    self.noragdoll = 0;
    aitypescriptbundle = getaitypescriptbundle( aitype );
    assert( isdefined( aitypescriptbundle ) );
    aitype::main( aitype, aitypescriptbundle, selectedcharacter, weaponstruct );
    self.health = aitypescriptbundle.health;
    self.maxhealth = aitypescriptbundle.health;
    
    if ( isdefined( self.weapon ) && self.weapon.basenamehash != %"none" )
    {
        self giveweapon( self.weapon );
        self setspawnweapon( self.weapon );
        self.bulletsinclip = weaponclipsize( self.weapon );
        self.primaryweapon = self.weapon;
    }
    
    assert( isscriptedagent( self ) );
    assert( isdefined( self.behaviortreeasset ) );
    assert( isdefined( self.asmasset ) );
    self.defaultasm = self.asmasset;
    self.a = spawnstruct();
    asm::asm_init_blackboard();
    bt_util::bt_init();
    self function_9dd2ab67d1a87a77( 0 );
    asm_mp::asm_init( self.asmasset, self.animsetname );
    ai::ai_init();
    self function_9dd2ab67d1a87a77( 1 );
}

// Namespace aitype_mp/aitype_precache
// Params 2, eflags: 0x20
// Checksum 0x643dac3a, Offset: 0x1f9
// Size: 0x4b
function event_handler[aitype_precache] precache( aitype, weaponstruct )
{
    aitypescriptbundle = getaitypescriptbundle( aitype );
    assert( isdefined( aitypescriptbundle ) );
    aitype::precache( aitype, aitypescriptbundle, weaponstruct );
    agent_init::agent_init();
    bt_util::init();
}

