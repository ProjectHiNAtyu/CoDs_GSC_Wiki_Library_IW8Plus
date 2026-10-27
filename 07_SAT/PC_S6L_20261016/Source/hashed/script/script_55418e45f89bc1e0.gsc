// script_55418e45f89bc1e0  (hash_55418e45f89bc1e0.gscc) (size: 511 Bytes / 0x1ff / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x73f340db (1945321691)
// size ...... 511 (0x1ff)
// includes .. 2   (offset: 0x1d7)
// strings ... 2   (offset: 0x1e7)
// dev strs .. 0   (offset: 0x1ff)
// exports ... 3   (offset: 0xef)
// cseg ...... 0x86 + 0x69 (0xef)
// imports ... 4   (offset: 0x167)
// animtree1 . 0   (offset: 0x1ff)
// animtree2 . 0   (offset: 0x1ff)
#using scripts\asm\asm;
#using scripts\common\callbacks;

#namespace namespace_9f5c84ee2daca21b;

// Namespace namespace_9f5c84ee2daca21b
// Params 0
// Checksum 0xa674b2e0, Offset: 0xa4
// Size: 0x22
function init_idle_global()
{
    callback::get_template( self.animsetname ) callback::add( "on_is_crawling_changed", &idle_on_is_crawling_changed );
}

// Namespace namespace_9f5c84ee2daca21b
// Params 1, eflags: 0x4
// Checksum 0x46a0ab31, Offset: 0xce
// Size: 0x21
function private idle_on_is_crawling_changed( params )
{
    asm::asm_fireevent_internal( self.asmname, "loop_reroll_anim" );
}

