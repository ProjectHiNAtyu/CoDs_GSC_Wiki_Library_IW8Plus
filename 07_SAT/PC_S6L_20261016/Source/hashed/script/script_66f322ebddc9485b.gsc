// script_66f322ebddc9485b  (hash_66f322ebddc9485b.gscc) (size: 2459 Bytes / 0x99b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe533914a (3845361994)
// size ...... 2459 (0x99b)
// includes .. 5   (offset: 0x8c3)
// strings ... 10  (offset: 0x8eb)
// dev strs .. 2   (offset: 0x983)
// exports ... 10  (offset: 0x45f)
// cseg ...... 0x105 + 0x35a (0x45f)
// imports ... 24  (offset: 0x5ef)
// animtree1 . 0   (offset: 0x99b)
// animtree2 . 0   (offset: 0x99b)
#using script_60cc31ea91d0ad55;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\shared\zombie\zombie_wander;
#using scripts\common\callbacks;

#namespace namespace_4de6ef4948d8552c;

// Namespace namespace_4de6ef4948d8552c
// Params 0
// Checksum 0x1f430714, Offset: 0x123
// Size: 0x62
function function_8bc82ab7848e6db()
{
    callback::get_template( self.animsetname ) callback::add( "on_move_speed_changed", &function_826d4d7d3ddd05a3 );
    callback::get_template( self.animsetname ) callback::add( "on_is_moving_melee_changed", &function_f66695cdf2c14061 );
    callback::get_template( self.animsetname ) callback::add( "on_is_crawling_changed", &move_on_is_crawling_changed );
}

// Namespace namespace_4de6ef4948d8552c
// Params 0
// Checksum 0x96cc4ec2, Offset: 0x18d
// Size: 0x25
function init_zombie_base_move()
{
    namespace_56081b33e0a40eac::function_d9c6262c2bdb331c();
    thread zombie_wander::wander_listener();
    thread function_10435f60f28074e6();
    thread lowg_listener();
    thread is_underwater_listener();
}

// Namespace namespace_4de6ef4948d8552c
// Params 1, eflags: 0x4
// Checksum 0x5bb9717e, Offset: 0x1ba
// Size: 0x58
function private function_826d4d7d3ddd05a3( params )
{
    var_4dd9c210b998e030 = function_565827781d82d7c1();
    
    /#
        record3dtext( "<dev string:x24>" + var_4dd9c210b998e030, self.origin + ( 0, 0, 48 ), ( 1, 0, 0 ), "<dev string:x39>", self );
    #/
}

// Namespace namespace_4de6ef4948d8552c
// Params 1, eflags: 0x4
// Checksum 0xd4fccaa1, Offset: 0x21a
// Size: 0x13
function private function_f66695cdf2c14061( params )
{
    function_565827781d82d7c1();
}

// Namespace namespace_4de6ef4948d8552c
// Params 1, eflags: 0x4
// Checksum 0xdc3a446f, Offset: 0x235
// Size: 0x2a
function private move_on_is_crawling_changed( params )
{
    if ( asm::asm_currentstatehasflag( self.asmname, "move" ) )
    {
        namespace_56081b33e0a40eac::function_ad9fd4f4fff4cdcd();
    }
}

// Namespace namespace_4de6ef4948d8552c
// Params 0, eflags: 0x4
// Checksum 0x2183c710, Offset: 0x267
// Size: 0xb2
function private function_565827781d82d7c1()
{
    animset = self.animsetname;
    
    if ( !( isdefined( level.variant_type_max[ self.animsetname ] ) && isdefined( level.variant_type_max[ self.animsetname ] ) ) )
    {
        animset = self findoverridearchetype( "default" );
    }
    
    featurearray = [];
    alias = self function_805ca5e408d630c0( animset, "move_loop", featurearray, 1 );
    self function_695b8e1b655c2796( "move", alias );
    
    if ( asm::asm_currentstatehasflag( self.asmname, "move" ) )
    {
        asm::asm_fireevent_internal( self.asmname, "loop_reroll_anim" );
    }
    
    return alias;
}

// Namespace namespace_4de6ef4948d8552c
// Params 0, eflags: 0x4
// Checksum 0x4410bfba, Offset: 0x322
// Size: 0x6a
function private function_10435f60f28074e6()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"investigate_start" );
        
        if ( zombie_utils::get_zombie_round_difficulty() <= 20 )
        {
            move_speed = "investigate";
            zombie_utils::function_a8ce00e0448cb6f0( move_speed, "investigate", 23 );
            self waittill( #"investigate_end" );
            zombie_utils::function_a8ce00e0448cb6f0( undefined, "investigate" );
        }
    }
}

// Namespace namespace_4de6ef4948d8552c
// Params 0, eflags: 0x4
// Checksum 0x49fd923, Offset: 0x394
// Size: 0x5d
function private lowg_listener()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"hash_65b20bec77a97f2a" );
        function_565827781d82d7c1();
        
        if ( asm::asm_currentstatehasflag( self.asmname, "move" ) )
        {
            self animmode( "normal" );
            self motionwarpcancel();
            self orientmode( "face motion" );
        }
    }
}

// Namespace namespace_4de6ef4948d8552c
// Params 0, eflags: 0x4
// Checksum 0xc661e36f, Offset: 0x3f9
// Size: 0x66
function private is_underwater_listener()
{
    self endon( #"death", #"hash_380b82d19d8f6233" );
    
    while ( true )
    {
        self waittill( #"hash_df8719ff4ed91a8c" );
        function_565827781d82d7c1();
        
        if ( asm::asm_currentstatehasflag( self.asmname, "move" ) )
        {
            self animmode( "normal" );
            self motionwarpcancel();
            self orientmode( "face motion" );
        }
    }
}

