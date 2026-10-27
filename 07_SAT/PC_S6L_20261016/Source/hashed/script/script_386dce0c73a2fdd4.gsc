// script_386dce0c73a2fdd4  (hash_386dce0c73a2fdd4.gscc) (size: 1274 Bytes / 0x4fa / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb8c2070a (3099723530)
// size ...... 1274 (0x4fa)
// includes .. 1   (offset: 0x4a6)
// strings ... 5   (offset: 0x4ae)
// dev strs .. 1   (offset: 0x4ee)
// exports ... 7   (offset: 0x25a)
// cseg ...... 0xbd + 0x19d (0x25a)
// imports ... 10  (offset: 0x372)
// animtree1 . 0   (offset: 0x4fa)
// animtree2 . 0   (offset: 0x4fa)
#using scripts\common\callbacks;

#namespace namespace_e0174a7eeed30023;

// Namespace namespace_e0174a7eeed30023
// Params 0
// Checksum 0x5645b4f0, Offset: 0xdb
// Size: 0x62
function init_melee_global()
{
    callback::get_template( self.animsetname ) callback::add( "on_move_speed_changed", &melee_on_move_speed_changed );
    callback::get_template( self.animsetname ) callback::add( "on_is_moving_melee_changed", &function_e0d499c13803af86 );
    callback::get_template( self.animsetname ) callback::add( "on_is_crawling_changed", &melee_on_is_crawling_changed );
}

// Namespace namespace_e0174a7eeed30023
// Params 0
// Checksum 0x3e2276b, Offset: 0x145
// Size: 0x9
function function_a887d53ac5484b73()
{
    function_1a57e936d77691d2();
}

// Namespace namespace_e0174a7eeed30023
// Params 1, eflags: 0x4
// Checksum 0xdac1e83e, Offset: 0x156
// Size: 0x13
function private melee_on_move_speed_changed( params )
{
    function_1a57e936d77691d2();
}

// Namespace namespace_e0174a7eeed30023
// Params 1, eflags: 0x4
// Checksum 0x81f63fd5, Offset: 0x171
// Size: 0x13
function private function_e0d499c13803af86( params )
{
    function_1a57e936d77691d2();
}

// Namespace namespace_e0174a7eeed30023
// Params 1, eflags: 0x4
// Checksum 0xa04d499e, Offset: 0x18c
// Size: 0x13
function private melee_on_is_crawling_changed( params )
{
    function_1a57e936d77691d2();
}

// Namespace namespace_e0174a7eeed30023
// Params 0, eflags: 0x4
// Checksum 0xadcad4fb, Offset: 0x1a7
// Size: 0xb2
function private function_1a57e936d77691d2()
{
    animset = self.animsetname;
    
    if ( !( isdefined( level.variant_type_max[ self.animsetname ] ) && isdefined( level.variant_type_max[ self.animsetname ] ) ) )
    {
        animset = self findoverridearchetype( "default" );
    }
    
    featurearray = [];
    alias = self function_805ca5e408d630c0( animset, "melee", featurearray, 0 );
    assert( isdefined( alias ), "<dev string:x24>" + self._blackboard.movetype );
    
    if ( isdefined( alias ) )
    {
        self function_695b8e1b655c2796( "melee", alias );
    }
    
    return alias;
}

