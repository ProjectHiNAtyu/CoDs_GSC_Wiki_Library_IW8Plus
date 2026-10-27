// scripts\common\ai\aitypes\zombie_mimic\zombie_mimic_medal.gsc  (hash_55dfdad73e551206.gscc) (size: 735 Bytes / 0x2df / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xad61dc9f (2908871839)
// size ...... 735 (0x2df)
// includes .. 2   (offset: 0x2b3)
// strings ... 2   (offset: 0x2c3)
// dev strs .. 0   (offset: 0x2df)
// exports ... 5   (offset: 0x13f)
// cseg ...... 0x79 + 0xc6 (0x13f)
// imports ... 6   (offset: 0x207)
// animtree1 . 0   (offset: 0x2df)
// animtree2 . 0   (offset: 0x2df)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;

#namespace zombie_mimic_medal;

// Namespace zombie_mimic_medal
// Params 0
// Checksum 0x2f8647, Offset: 0x97
// Size: 0x2
function function_57b2d1bc4e78117f()
{
    
}

// Namespace zombie_mimic_medal
// Params 0
// Checksum 0xec940cac, Offset: 0xa1
// Size: 0x13
function function_cb6aaffca1a53fd8()
{
    callback::add( "on_entity_revealed", &function_13122efd6e20aabc );
}

// Namespace zombie_mimic_medal
// Params 0
// Checksum 0x44897c27, Offset: 0xbc
// Size: 0x13
function function_eebb37610fa6d82f()
{
    callback::remove( "on_entity_revealed", &function_13122efd6e20aabc );
}

// Namespace zombie_mimic_medal
// Params 1, eflags: 0x4
// Checksum 0x65bcfd59, Offset: 0xd7
// Size: 0x68
function private function_13122efd6e20aabc( params )
{
    var_d43828c0548aa2ee = params.var_ea8a8c50c7c7f096[ 0 ];
    var_e67b929c9afaae3b = params.var_e67b929c9afaae3b;
    
    if ( isplayer( var_d43828c0548aa2ee ) && var_e67b929c9afaae3b === "damaged" )
    {
        var_d43828c0548aa2ee namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_prophunt" );
        function_eebb37610fa6d82f();
    }
}

