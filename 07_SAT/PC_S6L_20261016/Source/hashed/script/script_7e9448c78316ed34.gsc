// script_7e9448c78316ed34  (hash_7e9448c78316ed34.gscc) (size: 1168 Bytes / 0x490 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcb53e1fb (3411272187)
// size ...... 1168 (0x490)
// includes .. 1   (offset: 0x448)
// strings ... 4   (offset: 0x450)
// dev strs .. 1   (offset: 0x484)
// exports ... 7   (offset: 0x220)
// cseg ...... 0xa3 + 0x17d (0x220)
// imports ... 9   (offset: 0x338)
// animtree1 . 0   (offset: 0x490)
// animtree2 . 0   (offset: 0x490)
#using scripts\common\callbacks;

#namespace namespace_8af0ba1beb6dc587;

// Namespace namespace_8af0ba1beb6dc587
// Params 0
// Checksum 0xff873307, Offset: 0xc1
// Size: 0x42
function init_swipe_global()
{
    callback::get_template( self.animsetname ) callback::add( "on_move_speed_changed", &melee_on_move_speed_changed );
    callback::get_template( self.animsetname ) callback::add( "on_is_moving_melee_changed", &function_e0d499c13803af86 );
}

// Namespace namespace_8af0ba1beb6dc587
// Params 0
// Checksum 0x9930dbba, Offset: 0x10b
// Size: 0x9
function init_swipe()
{
    function_1a57e936d77691d2();
}

// Namespace namespace_8af0ba1beb6dc587
// Params 1, eflags: 0x4
// Checksum 0x54ad86e7, Offset: 0x11c
// Size: 0x13
function private melee_on_move_speed_changed( params )
{
    function_1a57e936d77691d2();
}

// Namespace namespace_8af0ba1beb6dc587
// Params 1, eflags: 0x4
// Checksum 0xf9a510c, Offset: 0x137
// Size: 0x13
function private function_e0d499c13803af86( params )
{
    function_1a57e936d77691d2();
}

// Namespace namespace_8af0ba1beb6dc587
// Params 1, eflags: 0x4
// Checksum 0x2e212747, Offset: 0x152
// Size: 0x13
function private melee_on_is_crawling_changed( params )
{
    function_1a57e936d77691d2();
}

// Namespace namespace_8af0ba1beb6dc587
// Params 0, eflags: 0x4
// Checksum 0xa874115f, Offset: 0x16d
// Size: 0xb2
function private function_1a57e936d77691d2()
{
    animset = self.animsetname;
    
    if ( !( isdefined( level.variant_type_max[ self.animsetname ] ) && isdefined( level.variant_type_max[ self.animsetname ] ) ) )
    {
        animset = self findoverridearchetype( "default" );
    }
    
    featurearray = [];
    alias = self function_805ca5e408d630c0( animset, "swipe", featurearray, 0 );
    assert( isdefined( alias ), "<dev string:x24>" + self._blackboard.movetype );
    
    if ( isdefined( alias ) )
    {
        self function_695b8e1b655c2796( "swipe", alias );
    }
    
    return alias;
}

