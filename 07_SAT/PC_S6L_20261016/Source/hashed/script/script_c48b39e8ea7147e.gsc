// script_c48b39e8ea7147e  (hash_0c48b39e8ea7147e.gscc) (size: 615 Bytes / 0x267 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb0e3394b (2967681355)
// size ...... 615 (0x267)
// includes .. 1   (offset: 0x23f)
// strings ... 2   (offset: 0x247)
// dev strs .. 0   (offset: 0x267)
// exports ... 4   (offset: 0x14b)
// cseg ...... 0x8a + 0xc1 (0x14b)
// imports ... 3   (offset: 0x1eb)
// animtree1 . 0   (offset: 0x267)
// animtree2 . 0   (offset: 0x267)
#using scripts\common\callbacks;

#namespace specialty_fastoffhand;

// Namespace specialty_fastoffhand
// Params 0, eflags: 0x1
// Checksum 0xc611c826, Offset: 0xa8
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_fastoffhand
// Params 1
// Checksum 0x369a105f, Offset: 0xc8
// Size: 0x44
function registerspecialty( params )
{
    if ( isdefined( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_fastoffhand" );
    }
    
    level.var_ff0d4d8bcaeda64a[ "specialty_fastoffhand" ] = &function_5f3646eb13ddcac4;
}

// Namespace specialty_fastoffhand
// Params 0
// Checksum 0x10f24bc2, Offset: 0x114
// Size: 0x36
function function_5f3646eb13ddcac4()
{
    var_a37a2577bcf9e24d = level.var_918d3444c8676d26[ "specialty_combat_flow" ];
    
    if ( isdefined( self.perks[ "specialty_fastoffhand" ][ var_a37a2577bcf9e24d ] ) )
    {
        return var_a37a2577bcf9e24d;
    }
}

