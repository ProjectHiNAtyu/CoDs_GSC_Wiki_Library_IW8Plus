// script_7752aa9d906ccefa  (hash_7752aa9d906ccefa.gscc) (size: 1069 Bytes / 0x42d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2586036 (39346230)
// size ...... 1069 (0x42d)
// includes .. 3   (offset: 0x3e1)
// strings ... 3   (offset: 0x3f9)
// dev strs .. 0   (offset: 0x42d)
// exports ... 6   (offset: 0x1f5)
// cseg ...... 0xa7 + 0x14e (0x1f5)
// imports ... 9   (offset: 0x2e5)
// animtree1 . 0   (offset: 0x42d)
// animtree2 . 0   (offset: 0x42d)
#using scripts\common\callbacks;
#using scripts\common\values;
#using scripts\mp\flags;

#namespace specialty_outline_enemy_equipment;

// Namespace specialty_outline_enemy_equipment
// Params 0, eflags: 0x1
// Checksum 0x8e29d008, Offset: 0xc5
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_outline_enemy_equipment
// Params 1
// Checksum 0x810ecdfd, Offset: 0xe5
// Size: 0x38
function registerspecialty( params )
{
    if ( params.var_bf34439fc0ca3cec )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_outline_enemy_equipment", &function_4c5846c153330fb4, &function_a6f44e7809bd22e3 );
    }
}

// Namespace specialty_outline_enemy_equipment
// Params 0
// Checksum 0x187c7530, Offset: 0x125
// Size: 0x29
function function_4c5846c153330fb4()
{
    self.var_401cb01f1e1120e2 = self.var_9842326056fd7207.var_401cb01f1e1120e2 ?? 0;
    thread function_4a342e89bcc98548();
}

// Namespace specialty_outline_enemy_equipment
// Params 0
// Checksum 0xf82e4f2c, Offset: 0x156
// Size: 0x6a
function function_4a342e89bcc98548()
{
    self notify( #"hash_e7988b106b418513" );
    self endon( #"hash_e7988b106b418513" );
    self endon( #"hash_e0df567eeb438d50" );
    self endon( #"disconnect" );
    flags::gameflagwait( "prematch_done" );
    dist = self.var_401cb01f1e1120e2;
    
    if ( self )
    {
        val::set( "specialty_outline_enemy_equipment", "entity_mark_equipment", dist );
    }
}

// Namespace specialty_outline_enemy_equipment
// Params 0
// Checksum 0x6227a408, Offset: 0x1c8
// Size: 0x2d
function function_a6f44e7809bd22e3()
{
    if ( val::get( "entity_mark_equipment" ) )
    {
        val::reset( "specialty_outline_enemy_equipment", "entity_mark_equipment" );
    }
    
    self notify( #"hash_e0df567eeb438d50" );
}

