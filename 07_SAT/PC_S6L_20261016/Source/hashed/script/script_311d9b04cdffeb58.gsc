// script_311d9b04cdffeb58  (hash_311d9b04cdffeb58.gscc) (size: 3476 Bytes / 0xd94 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9ebc0119 (2663121177)
// size ...... 3476 (0xd94)
// includes .. 3   (offset: 0xc60)
// strings ... 18  (offset: 0xc78)
// dev strs .. 4   (offset: 0xd5c)
// exports ... 13  (offset: 0x6b4)
// cseg ...... 0x1d4 + 0x4e0 (0x6b4)
// imports ... 31  (offset: 0x8bc)
// animtree1 . 0   (offset: 0xd94)
// animtree2 . 0   (offset: 0xd94)
#using scripts\common\ai\aitypes\zombie_karkinos\zombie_karkinos;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace namespace_1dae79e17ca61fd8;

// Namespace namespace_1dae79e17ca61fd8
// Params 0
// Checksum 0xe4b92856, Offset: 0x1f2
// Size: 0x62
function function_74083a13eaa941a1()
{
    callback::get_template( self.animsetname ) callback::add( "on_move_speed_changed", &melee_on_move_speed_changed );
    callback::get_template( self.animsetname ) callback::add( "on_is_moving_melee_changed", &function_e0d499c13803af86 );
    callback::get_template( self.animsetname ) callback::add( "on_is_melee_started", &melee_on_is_melee_started );
}

// Namespace namespace_1dae79e17ca61fd8
// Params 0
// Checksum 0x455843b7, Offset: 0x25c
// Size: 0x30
function init_zombie_karkinos_melee()
{
    self.var_acb8d8861a8e5fde = [ "ai_sat_zm_karkinos_claw_add_melee_01", "ai_sat_zm_karkinos_claw_add_melee_02", "ai_sat_zm_karkinos_trident_add_melee_01", "ai_sat_zm_karkinos_trident_add_melee_02" ];
}

// Namespace namespace_1dae79e17ca61fd8
// Params 0
// Checksum 0xcaa77b6e, Offset: 0x294
// Size: 0x22
function function_4c4c0ef5ad3027ad()
{
    if ( !self.allowstrafe )
    {
        self function_68f2f6fd8a4ffcae( 1, 5 );
    }
    
    return self.allowstrafe;
}

// Namespace namespace_1dae79e17ca61fd8
// Params 0
// Checksum 0x8b0f41ce, Offset: 0x2bf
// Size: 0x88
function function_36f521f25f8bf07c()
{
    anim_index = function_1a3513c397565091() ? randomintrange( 0, 2 ) : randomintrange( 2, 4 );
    anim_name = self.var_acb8d8861a8e5fde[ anim_index ];
    xanim = function_b9b2c118602e27a6( anim_name, self );
    function_8350caf521f6d070( xanim );
    self.var_c8cf90daee0f67a3 = self.var_b91c2f2b850e8d5a;
    self function_68f2f6fd8a4ffcae( 0, 4 );
    self function_68f2f6fd8a4ffcae( 1, anim_index + 1 );
    thread function_21f297f069b39a61();
}

// Namespace namespace_1dae79e17ca61fd8
// Params 1
// Checksum 0x9333791b, Offset: 0x34f
// Size: 0xd6
function function_8350caf521f6d070( xanim )
{
    melee_hit_notetracks = getnotetracktimes( xanim, "hit" );
    melee_end_notetracks = getnotetracktimes( xanim, "end" );
    anim_length = getanimlength( xanim );
    assert( melee_hit_notetracks.size > 0, "<dev string:x24>" );
    assert( melee_end_notetracks.size > 0, "<dev string:x5a>" );
    var_47f2af791ff7864 = melee_hit_notetracks[ 0 ] * anim_length;
    melee_end_wait_time = melee_end_notetracks[ 0 ] * anim_length;
    assert( var_47f2af791ff7864 > -1, "<dev string:x24>" );
    assert( melee_end_wait_time > -1, "<dev string:x5a>" );
    thread utility::delay_notify( var_47f2af791ff7864, "hit_melee", "death" );
    thread utility::delay_notify( melee_end_wait_time, "bmeleeended", "death" );
}

// Namespace namespace_1dae79e17ca61fd8
// Params 0
// Checksum 0xf30523b7, Offset: 0x42d
// Size: 0x3e
function function_21f297f069b39a61()
{
    self endon( #"death" );
    self waittill( #"bmeleeended" );
    self function_68f2f6fd8a4ffcae( 1, 5 );
    zombie_karkinos::function_264ec315793f2e97();
    self.var_c8cf90daee0f67a3 = self.var_ddacc0ca93a16eb6;
}

// Namespace namespace_1dae79e17ca61fd8
// Params 1, eflags: 0x4
// Checksum 0x86b37ff2, Offset: 0x473
// Size: 0x13
function private melee_on_move_speed_changed( params )
{
    function_1a57e936d77691d2();
}

// Namespace namespace_1dae79e17ca61fd8
// Params 1, eflags: 0x4
// Checksum 0xdd84a819, Offset: 0x48e
// Size: 0x13
function private function_e0d499c13803af86( params )
{
    function_1a57e936d77691d2();
}

// Namespace namespace_1dae79e17ca61fd8
// Params 1, eflags: 0x4
// Checksum 0x9bc1a059, Offset: 0x4a9
// Size: 0x3b
function private melee_on_is_melee_started( params )
{
    function_1a57e936d77691d2();
    
    if ( getdvarint( @"hash_57a5417ddcf8537f", 0 ) == 1 )
    {
        zombie_karkinos::disable_claw_shield( 0, "melee_attack" );
        thread function_be9b1aa7d547123a();
    }
}

// Namespace namespace_1dae79e17ca61fd8
// Params 0, eflags: 0xc
// Checksum 0xacda2480, Offset: 0x4ec
// Size: 0x3f
function private function_be9b1aa7d547123a()
{
    self notify( #"hash_fb4d5c49165c2d73" );
    self endon( #"hash_fb4d5c49165c2d73" );
    self endon( #"death" );
    self waittill( #"bmeleeended" );
    zombie_karkinos::function_5d9dd6b1a00c39bd( "melee_attack" );
}

// Namespace namespace_1dae79e17ca61fd8
// Params 0, eflags: 0x4
// Checksum 0xf271fd5e, Offset: 0x533
// Size: 0x127
function private function_1a57e936d77691d2()
{
    animset = self.animsetname;
    
    if ( !isdefined( level.variant_type_max[ self.animsetname ] ) )
    {
        animset = self findoverridearchetype( "default" );
    }
    
    featurearray = [];
    featurearray[ "movetype" ] = self._blackboard.movetype;
    featurearray[ "is_moving_melee" ] = self.is_moving_melee;
    close = function_1a3513c397565091();
    featurearray[ "is_close_range" ] = close;
    alias = self function_805ca5e408d630c0( animset, "melee", featurearray, 0 );
    assert( isdefined( alias ), "<dev string:x90>" + self._blackboard.movetype );
    
    if ( isdefined( alias ) )
    {
        self function_695b8e1b655c2796( "melee", alias );
    }
    
    /#
        if ( getdvarint( @"hash_59958a0aeb2c19ac", 0 ) == 1 )
        {
            if ( !issubstr( alias, "<dev string:xbe>" ) )
            {
                sphere( self.origin, 50, ( 0, 0, 1 ), 0, 60 );
            }
        }
    #/
    
    return alias;
}

// Namespace namespace_1dae79e17ca61fd8
// Params 0
// Checksum 0x44e56c33, Offset: 0x663
// Size: 0x50
function function_1a3513c397565091()
{
    if ( !self.enemy || !isalive( self.enemy ) )
    {
        return;
    }
    
    return distancesquared( self.origin, self.enemy.origin ) <= squared( self.claw_melee_range );
}

