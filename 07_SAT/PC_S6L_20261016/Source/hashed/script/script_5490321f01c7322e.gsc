// script_5490321f01c7322e  (hash_5490321f01c7322e.gscc) (size: 448 Bytes / 0x1c0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x748c9de2 (1955372514)
// size ...... 448 (0x1c0)
// includes .. 1   (offset: 0x1ac)
// strings ... 1   (offset: 0x1b4)
// dev strs .. 0   (offset: 0x1c0)
// exports ... 3   (offset: 0xe0)
// cseg ...... 0x63 + 0x7d (0xe0)
// imports ... 3   (offset: 0x158)
// animtree1 . 0   (offset: 0x1c0)
// animtree2 . 0   (offset: 0x1c0)
#using scripts\asm\asm;

#namespace zombie_bite_asm;

// Namespace zombie_bite_asm
// Params 1
// Checksum 0x8c351e9, Offset: 0x81
// Size: 0x25
function register_bite_state( state_name )
{
    assert( isstring( state_name ) );
    self.var_c653b313b080a68e = state_name;
}

// Namespace zombie_bite_asm
// Params 0
// Checksum 0x653a0611, Offset: 0xae
// Size: 0x32
function request_bite_asm_state()
{
    if ( self.bite_state_requested )
    {
        return;
    }
    
    self.bite_state_requested = 1;
    asm::function_7256f5ba459c840b( self.var_c653b313b080a68e ?? "bite_in" );
}

