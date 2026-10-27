// script_26bf705f44166c60  (hash_26bf705f44166c60.gscc) (size: 629 Bytes / 0x275 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1092ef7b (278065019)
// size ...... 629 (0x275)
// includes .. 2   (offset: 0x249)
// strings ... 2   (offset: 0x259)
// dev strs .. 0   (offset: 0x275)
// exports ... 4   (offset: 0x119)
// cseg ...... 0x81 + 0x98 (0x119)
// imports ... 5   (offset: 0x1b9)
// animtree1 . 0   (offset: 0x275)
// animtree2 . 0   (offset: 0x275)
#using scripts\common\ai\aitypes\zombie_base\zombie_base_dismemberment;
#using scripts\common\callbacks;

#namespace namespace_cea28acaed2cadc3;

// Namespace namespace_cea28acaed2cadc3
// Params 0
// Checksum 0xdaad50b6, Offset: 0x9f
// Size: 0x22
function init_traverse_global()
{
    callback::get_template( self.animsetname ) callback::add( "on_is_crawling_changed", &traverse_on_is_crawling_changed );
}

// Namespace namespace_cea28acaed2cadc3
// Params 0
// Checksum 0x33348142, Offset: 0xc9
// Size: 0x22
function function_4e89ce88f65464e3()
{
    self.var_6528526395085bc = [];
    self.var_6528526395085bc[ "is_crawling" ] = namespace_b76ff2659823e89d::is_crawling();
}

// Namespace namespace_cea28acaed2cadc3
// Params 1, eflags: 0x4
// Checksum 0x23faca7f, Offset: 0xf3
// Size: 0x26
function private traverse_on_is_crawling_changed( params )
{
    self.var_6528526395085bc[ "is_crawling" ] = int( namespace_b76ff2659823e89d::is_crawling() );
}

