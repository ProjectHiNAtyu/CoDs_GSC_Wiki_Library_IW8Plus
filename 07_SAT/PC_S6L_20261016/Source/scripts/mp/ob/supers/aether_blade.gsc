// scripts\mp\ob\supers\aether_blade.gsc  (hash_202ece2095bcf0a5.gscc) (size: 5065 Bytes / 0x13c9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1373b02c (326348844)
// size ...... 5065 (0x13c9)
// includes .. 5   (offset: 0x1305)
// strings ... 7   (offset: 0x132d)
// dev strs .. 5   (offset: 0x138d)
// exports ... 21  (offset: 0xac9)
// cseg ...... 0x1ad + 0x91c (0xac9)
// imports ... 43  (offset: 0xe11)
// animtree1 . 0   (offset: 0x13c9)
// animtree2 . 0   (offset: 0x13c9)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\equipment;
#using scripts\mp\supers;

#namespace aether_blade;

// Namespace aether_blade
// Params 0, eflags: 0x5
// Checksum 0xa22d7c8, Offset: 0x1cb
// Size: 0x18
function private autoexec main()
{
    level callback::add( #"register_super", &register );
}

// Namespace aether_blade
// Params 1, eflags: 0x4
// Checksum 0xf0ab74ee, Offset: 0x1eb
// Size: 0x54
function private register( params )
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_aether_blade" );
    assert( bundle, "<dev string:x24>" + "<dev string:x3a>" + "<dev string:x4d>" );
    supers_mp::function_48aaa60b2ce7b8a1( "super_aether_blade", &set, &unset );
}

// Namespace aether_blade
// Params 0, eflags: 0x4
// Checksum 0x8eb67698, Offset: 0x247
// Size: 0x43
function private set()
{
    assert( !callback::exists( #"equip_aether_blade_used", &super_aether_blade_used ) );
    callback::add( #"equip_aether_blade_used", &super_aether_blade_used );
    self.super_aether_blade_data = function_de62e7138314247c();
}

// Namespace aether_blade
// Params 0, eflags: 0x4
// Checksum 0x83e864d5, Offset: 0x292
// Size: 0x21
function private unset()
{
    self.super_aether_blade_data = undefined;
    callback::remove( #"equip_aether_blade_used", &super_aether_blade_used );
}

// Namespace aether_blade
// Params 0, eflags: 0x4
// Checksum 0xba668680, Offset: 0x2bb
// Size: 0x32
function private function_d9d38c58cccb89c5()
{
    combo_score_data = function_1ebccdda7fd1058f();
    thread function_c2a3af33f5e2f86d( combo_score_data );
    callback::remove( #"equip_aether_blade_return", &aether_blade_returned );
}

// Namespace aether_blade
// Params 0, eflags: 0x4
// Checksum 0xfb768291, Offset: 0x2f5
// Size: 0x133
function private function_de62e7138314247c()
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_aether_blade" );
    self.super_aether_blade_data = { #var_7869b8f19eae1bd8:bundle.var_57e49bbebaeb654e, #var_2a276bbca0f7329a:bundle.var_bb167bc0d329d871 ?? 0, #var_d532e397ecea6843:bundle.pointsneeded, #var_52e0f7882f700cce:bundle.var_606d18368c1a1476, #var_513a22e3367743cf:[], #var_931c06311b7c1257:utility::function_b720276ae54a4d70( bundle.var_657096c9e7ac7f54, "Restore Points Amount not defined for Aether Blade Ability" ) ?? 0, #var_906537541843b659:utility::function_b720276ae54a4d70( bundle.var_d00ebb55379c5bf9, "Hits To Restore Points not defined for Aether Blade Ability" ), #var_eceb3bc6e72d8ee:utility::function_b720276ae54a4d70( bundle.var_c332c74765167f78, "Combo Score Event Delay not defined for Aether Blade Ability" ), #var_b32bf8295bb25f6c:utility::function_b720276ae54a4d70( bundle.var_1f861a192a071ec6, "Combo Score Event Name not defined for Aether Blade Ability" ), #var_a3ecd2e8e9747aa9:utility::function_b720276ae54a4d70( bundle.var_9c1e814cc32b048a, "Hits To Combo not defined for Aether Blade Ability" ), #combo_count:0 };
    return self.super_aether_blade_data;
}

// Namespace aether_blade
// Params 0, eflags: 0x4
// Checksum 0x2caab49d, Offset: 0x431
// Size: 0x65
function private function_1ebccdda7fd1058f()
{
    score_data = { #delay:self.super_aether_blade_data.var_eceb3bc6e72d8ee, #name:self.super_aether_blade_data.var_b32bf8295bb25f6c, #combo_count:self.super_aether_blade_data.combo_count };
    return score_data;
}

// Namespace aether_blade
// Params 1, eflags: 0x4
// Checksum 0xf881fd27, Offset: 0x49f
// Size: 0x71
function private function_466742dcc8b37406( var_425eb565f5fdf9c4 )
{
    assert( var_425eb565f5fdf9c4, "<dev string:x8d>" );
    
    if ( !isdefined( self.super_aether_blade_data.var_513a22e3367743cf ) )
    {
        self.super_aether_blade_data.var_513a22e3367743cf = [];
    }
    
    self.super_aether_blade_data.var_513a22e3367743cf[ self.super_aether_blade_data.var_513a22e3367743cf.size ] = var_425eb565f5fdf9c4;
}

// Namespace aether_blade
// Params 1, eflags: 0x4
// Checksum 0xf39f7fa4, Offset: 0x518
// Size: 0x9d
function private function_9e35702d496499aa( var_425eb565f5fdf9c4 )
{
    foreach ( active_blade in self.super_aether_blade_data.var_513a22e3367743cf )
    {
        if ( active_blade == var_425eb565f5fdf9c4 )
        {
            return active_blade;
        }
    }
    
    assertmsg( "<dev string:xa9>" );
}

// Namespace aether_blade
// Params 0, eflags: 0x4
// Checksum 0x3639bdac, Offset: 0x5bd
// Size: 0x1a, Type: bool
function private function_d7c64bb345d1904d()
{
    return self.super_aether_blade_data.var_513a22e3367743cf.size ?? 0;
}

// Namespace aether_blade
// Params 0, eflags: 0x4
// Checksum 0x1502abc, Offset: 0x5e0
// Size: 0xa, Type: bool
function private function_cbb4a9bd8c209979()
{
    return function_d7c64bb345d1904d() > 0;
}

// Namespace aether_blade
// Params 1, eflags: 0x4
// Checksum 0x8b4f58b1, Offset: 0x5f3
// Size: 0x4a
function private function_e4b06fe73fc6f8e1( config )
{
    assert( config && self.super_aether_blade_data );
    
    if ( self.super_aether_blade_data.var_7869b8f19eae1bd8 )
    {
        config.var_6786de64b82133b6 = &function_a6060b03d607bc56;
    }
}

// Namespace aether_blade
// Params 1, eflags: 0x4
// Checksum 0x85bc213b, Offset: 0x645
// Size: 0x6b
function private super_aether_blade_used( params )
{
    if ( !params.issuper )
    {
        return;
    }
    
    if ( !function_cbb4a9bd8c209979() )
    {
        callback::add( #"equip_aether_blade_return", &aether_blade_returned );
    }
    
    function_466742dcc8b37406( params.var_425eb565f5fdf9c4 );
    function_e4b06fe73fc6f8e1( params.config );
    self notify( #"hash_6b58b33fc24a9933" );
}

// Namespace aether_blade
// Params 1, eflags: 0x4
// Checksum 0xb07c1213, Offset: 0x6b8
// Size: 0x55
function private aether_blade_returned( params )
{
    if ( !params.issuper )
    {
        return;
    }
    
    blade_data = function_9e35702d496499aa( params.var_425eb565f5fdf9c4 );
    function_af41027c208a6098( blade_data );
    aether_blade_end( params, blade_data );
    function_522f95852b0af53( blade_data );
}

// Namespace aether_blade
// Params 2, eflags: 0x4
// Checksum 0x433ea5ca, Offset: 0x715
// Size: 0x7c
function private aether_blade_end( params, blade_data = undefined )
{
    blade_data = blade_data ?? function_9e35702d496499aa( params.var_425eb565f5fdf9c4 );
    function_8e3313062fd34530( blade_data );
    self.super_aether_blade_data.var_513a22e3367743cf = arrayremove( self.super_aether_blade_data.var_513a22e3367743cf, blade_data );
    
    if ( !function_cbb4a9bd8c209979() )
    {
        function_d9d38c58cccb89c5();
    }
}

// Namespace aether_blade
// Params 1, eflags: 0x4
// Checksum 0x49911ed0, Offset: 0x799
// Size: 0x50
function private function_8e3313062fd34530( blade_data )
{
    var_a3ecd2e8e9747aa9 = self.super_aether_blade_data.var_a3ecd2e8e9747aa9;
    
    if ( blade_data.hit_count >= var_a3ecd2e8e9747aa9 )
    {
        self.super_aether_blade_data.combo_count++;
    }
}

// Namespace aether_blade
// Params 1, eflags: 0x4
// Checksum 0x35ac8c1d, Offset: 0x7f1
// Size: 0x87
function private function_af41027c208a6098( blade_data )
{
    var_906537541843b659 = self.super_aether_blade_data.var_906537541843b659;
    
    if ( blade_data.hit_count >= var_906537541843b659 )
    {
        var_1edd6e746347b91a = self.super_aether_blade_data.var_931c06311b7c1257;
        current_points = supers_mp::getcurrentsuperbasepoints( #"tactical" );
        supers_mp::setsuperbasepoints( current_points + var_1edd6e746347b91a, 0, #"tactical" );
    }
}

// Namespace aether_blade
// Params 1, eflags: 0x4
// Checksum 0x217f849e, Offset: 0x880
// Size: 0x131
function private function_522f95852b0af53( blade_data )
{
    if ( !self.super_aether_blade_data.var_52e0f7882f700cce || blade_data.hit_count != 0 )
    {
        return;
    }
    
    super_info = supers_mp::getcurrentsuper( #"tactical" );
    current_points = super_info.basepoints;
    var_d532e397ecea6843 = self.super_aether_blade_data.var_d532e397ecea6843;
    recharge_points = var_d532e397ecea6843 * self.super_aether_blade_data.var_2a276bbca0f7329a;
    var_2aa9f11aef068dda = current_points + recharge_points;
    ref = equipment_mp::getcurrentequipment( "secondary" );
    max_ammo = equipment_mp::getequipmentmaxammo( ref );
    
    for ( curr_ammo = equipment_mp::getequipmentammo( ref ); curr_ammo != max_ammo && var_2aa9f11aef068dda > 0 ; curr_ammo = equipment_mp::getequipmentammo( ref ) )
    {
        points = clamp( var_2aa9f11aef068dda, 0, var_d532e397ecea6843 );
        supers_mp::setsuperbasepoints( points, 0, #"tactical" );
        var_2aa9f11aef068dda -= points;
    }
}

// Namespace aether_blade
// Params 1, eflags: 0x4
// Checksum 0x4dbe37a6, Offset: 0x9b9
// Size: 0x99
function private function_c2a3af33f5e2f86d( score_data )
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_6b58b33fc24a9933" );
    
    if ( !score_data.name )
    {
        return;
    }
    
    if ( score_data.delay )
    {
        wait score_data.delay;
    }
    
    for ( i = 0; i < score_data.combo_count ; i++ )
    {
        points::doscoreevent( score_data.name );
    }
    
    self.super_aether_blade_data.combo_count = 0;
}

// Namespace aether_blade
// Params 1, eflags: 0x4
// Checksum 0x7feb8bc1, Offset: 0xa5a
// Size: 0x6e, Type: bool
function private function_a6060b03d607bc56( final_hit_count )
{
    assert( self.super_aether_blade_data );
    super_slot = supers_mp::getsuperslot( "super_aether_blade" );
    var_53b44cbc4f37a9 = supers_mp::getcurrentsuperpoints( super_slot ) + self.super_aether_blade_data.var_931c06311b7c1257;
    return final_hit_count == 0 || var_53b44cbc4f37a9 >= supers_mp::getsuperpointsneeded( undefined, super_slot );
}

