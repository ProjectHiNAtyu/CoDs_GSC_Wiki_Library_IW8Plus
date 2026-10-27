// script_689b4e6de3cb80e2  (hash_689b4e6de3cb80e2.gscc) (size: 622 Bytes / 0x26e)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe80b2e06 (3893046790)
// size ...... 622 (0x26e)
// includes .. 1   (offset: 0x242)
// strings ... 3   (offset: 0x24a)
// dev strs .. 0   (offset: 0x26e)
// exports ... 4   (offset: 0x112)
// cseg ...... 0x83 + 0x8f (0x112)
// imports ... 5   (offset: 0x1b2)
// animtree1 . 0   (offset: 0x26e)
// animtree2 . 0   (offset: 0x26e)
#using script_e92a9717969a5cd;

#namespace namespace_4306fdf641484f1f;

// Namespace namespace_4306fdf641484f1f
// Params 0
// Checksum 0x5779eda5, Offset: 0xa1
// Size: 0x28, Type: bool
function function_5f7c21d0e76269df()
{
    if ( !europa_asm::is_playing() )
    {
        return false;
    }
    
    currentstate = europa_asm::get_current_asm_state();
    return currentstate == "loop";
}

// Namespace namespace_4306fdf641484f1f
// Params 0
// Checksum 0x6b58791, Offset: 0xd2
// Size: 0xe
function exit_loop()
{
    europa_asm::fire_event( "exit_loop" );
}

// Namespace namespace_4306fdf641484f1f
// Params 1
// Checksum 0x7e705b80, Offset: 0xe8
// Size: 0x29
function play( cap_path )
{
    if ( europa_asm::is_playing() )
    {
        europa_asm::exit_cap();
    }
    
    return europa_asm::play_cap( "europa_simple_loop", cap_path );
}

