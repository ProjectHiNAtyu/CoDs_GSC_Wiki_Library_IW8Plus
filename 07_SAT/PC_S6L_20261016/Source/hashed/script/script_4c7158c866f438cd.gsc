// script_4c7158c866f438cd  (hash_4c7158c866f438cd.gscc) (size: 874 Bytes / 0x36a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x90e2692c (2430757164)
// size ...... 874 (0x36a)
// includes .. 1   (offset: 0x356)
// strings ... 1   (offset: 0x35e)
// dev strs .. 0   (offset: 0x36a)
// exports ... 6   (offset: 0x166)
// cseg ...... 0x70 + 0xf6 (0x166)
// imports ... 9   (offset: 0x256)
// animtree1 . 0   (offset: 0x36a)
// animtree2 . 0   (offset: 0x36a)
#using scripts\common\callbacks;

#namespace specialty_zero_waste;

// Namespace specialty_zero_waste
// Params 0, eflags: 0x1
// Checksum 0xc3a7ec77, Offset: 0x8e
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &register_specialty );
}

// Namespace specialty_zero_waste
// Params 1
// Checksum 0x152990af, Offset: 0xae
// Size: 0x38
function register_specialty( params )
{
    if ( params.var_bf34439fc0ca3cec )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_zero_waste", &set_zero_waste, &function_936f41b7a52e03f3 );
    }
}

// Namespace specialty_zero_waste
// Params 0
// Checksum 0x7fabcb6b, Offset: 0xee
// Size: 0x17
function set_zero_waste()
{
    callback::add( #"hash_474490f7ce8b74d0", &function_35b2898e1a1259c4 );
}

// Namespace specialty_zero_waste
// Params 0
// Checksum 0xdd43a4b7, Offset: 0x10d
// Size: 0x17
function function_936f41b7a52e03f3()
{
    callback::remove( #"hash_474490f7ce8b74d0", &function_35b2898e1a1259c4 );
}

// Namespace specialty_zero_waste
// Params 1, eflags: 0x4
// Checksum 0xd4f57a93, Offset: 0x12c
// Size: 0x3a
function private function_35b2898e1a1259c4( params )
{
    var_ddf24b010015c8af = randomintrange( 0, 2 );
    
    if ( var_ddf24b010015c8af == 1 )
    {
        self function_b6cee937ad0428d1( params.objweapon, 1 );
    }
}

