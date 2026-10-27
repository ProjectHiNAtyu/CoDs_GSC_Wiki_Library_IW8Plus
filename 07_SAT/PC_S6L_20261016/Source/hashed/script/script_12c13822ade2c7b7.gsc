// script_12c13822ade2c7b7  (hash_12c13822ade2c7b7.gscc) (size: 2728 Bytes / 0xaa8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe1b13b8c (3786488716)
// size ...... 2728 (0xaa8)
// includes .. 4   (offset: 0x9d8)
// strings ... 4   (offset: 0x9f8)
// dev strs .. 9   (offset: 0xa3c)
// exports ... 12  (offset: 0x578)
// cseg ...... 0xbc + 0x4bc (0x578)
// imports ... 21  (offset: 0x758)
// animtree1 . 0   (offset: 0xaa8)
// animtree2 . 0   (offset: 0xaa8)
#using script_540431b2a1470e90;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\devgui;
#using scripts\common\utility;

#namespace zombie_triton_lava_toss;

/#

    // Namespace zombie_triton_lava_toss
    // Params 0
    // Checksum 0xeff2dd2, Offset: 0xda
    // Size: 0xc, Type: dev
    function function_866c3345b46d0129()
    {
        function_dc4f24a8939a634f();
    }

#/

// Namespace zombie_triton_lava_toss
// Params 0
// Checksum 0xed7f68e4, Offset: 0xee
// Size: 0x9c
function function_832c001e69ef9a55()
{
    thread lava_toss_listener();
    self._blackboard.var_3c7d7ae944556d92 = int( self.var_d6894f01a36b4ff3.var_26c04115883926d8 * 1000 );
    self._blackboard.var_3c5a84e9442f3bd8 = int( self.var_d6894f01a36b4ff3.var_26e35715885f9ef2 * 1000 );
    self._blackboard.var_d751dec818290f98 = self.var_d6894f01a36b4ff3.var_9d909c03fc59c1b1;
    self function_786bb6aa1b76c7ee( "lavaTossRange", 500 );
}

// Namespace zombie_triton_lava_toss
// Params 1
// Checksum 0xa0e04798, Offset: 0x192
// Size: 0x19
function function_331d785131b9a5d7( range )
{
    self function_786bb6aa1b76c7ee( "lavaTossRange", range );
}

// Namespace zombie_triton_lava_toss
// Params 1
// Checksum 0xddcf45fa, Offset: 0x1b3
// Size: 0x17
function function_723c852530f4779b( cooldown )
{
    self.var_7660525b821efd53 = cooldown;
}

// Namespace zombie_triton_lava_toss
// Params 2
// Checksum 0x6ef5aa07, Offset: 0x1d2
// Size: 0x3d
function function_87492d9a03efc3e4( value, var_93d04200d1847d90 )
{
    self.var_e89cd6a4375bc9a8 = value;
    self function_786bb6aa1b76c7ee( "lava_Toss_chain_happening", value );
    self.var_efdfeba89675c6e4 = var_93d04200d1847d90 ?? 3;
}

// Namespace zombie_triton_lava_toss
// Params 1
// Checksum 0x333d3944, Offset: 0x217
// Size: 0x2c
function function_c27e62fd83d783a0( var_aff6dbd249be7f2d )
{
    assert( var_aff6dbd249be7f2d % 2 == 1, "<dev string:x24>" );
    self.var_75140e18c00d9bea = var_aff6dbd249be7f2d;
}

// Namespace zombie_triton_lava_toss
// Params 0, eflags: 0x4
// Checksum 0x3298070c, Offset: 0x24b
// Size: 0xe9
function private lava_toss_listener()
{
    self endon( #"death" );
    self.var_7660525b821efd53 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_7660525b821efd53;
    self.var_725d32aa8bd06bf5 = gettime() + utility::function_4b74c15943231980( self.var_7660525b821efd53 );
    self.var_e89cd6a4375bc9a8 = 0;
    self.var_a3f64e01ad31b283 = 0;
    function_c27e62fd83d783a0( 1 );
    function_87492d9a03efc3e4( 0, 0 );
    
    while ( true )
    {
        msg = utility::waittill_any_return( "ranged_attack_enemy_start", "armor_break_lava_toss" );
        assert( !self._blackboard.var_99f794dc99944d15, "<dev string:x5e>" );
        self.rangedattacktarget = self.enemy;
        var_7e46bfe69c8b823d = msg == "armor_break_lava_toss";
        namespace_7a57a365d91f07dc::function_d517660e6fe7222a( var_7e46bfe69c8b823d );
    }
}

// Namespace zombie_triton_lava_toss
// Params 2
// Checksum 0x3e599dd5, Offset: 0x33c
// Size: 0x135
function function_9c80254bc36365b0( taskid, params )
{
    if ( self.var_e89cd6a4375bc9a8 && gettime() > self.var_725d32aa8bd06bf5 )
    {
        if ( !self getaiblackboarddynamic( "lava_Toss_chain_happening" ) )
        {
            self function_786bb6aa1b76c7ee( "lava_Toss_chain_happening", 1 );
        }
        
        if ( self.var_a3f64e01ad31b283 <= self.var_efdfeba89675c6e4 )
        {
            self.var_a3f64e01ad31b283++;
            self._blackboard.var_8f2dbb63d0d0a2bd = -1;
            return anim.success;
        }
        else
        {
            self function_786bb6aa1b76c7ee( "lava_Toss_chain_happening", 0 );
            self.var_a3f64e01ad31b283 = 0;
            self.var_725d32aa8bd06bf5 = gettime() + utility::function_4b74c15943231980( self.var_7660525b821efd53 );
        }
    }
    else
    {
        if ( gettime() < self.var_725d32aa8bd06bf5 )
        {
            return anim.failure;
        }
        
        if ( isdefined( self.var_7660525b821efd53 ) )
        {
            self.var_725d32aa8bd06bf5 = gettime() + utility::function_4b74c15943231980( self.var_7660525b821efd53 );
            self._blackboard.var_8f2dbb63d0d0a2bd = -1;
        }
        
        return anim.success;
    }
    
    return anim.failure;
}

/#

    // Namespace zombie_triton_lava_toss
    // Params 0
    // Checksum 0xb785e3a7, Offset: 0x47a
    // Size: 0x48, Type: dev
    function function_dc4f24a8939a634f()
    {
        devgui::function_9082edeb5db93280( "<dev string:x94>" );
        devgui::add_devgui_func( "<dev string:xac>", "<dev string:xbd>", &toggle_lava_toss, 1 );
        devgui::add_devgui_func( "<dev string:xce>", "<dev string:xf2>", &function_93dcdb343a030b4b, 1 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_triton_lava_toss
    // Params 0, eflags: 0x4
    // Checksum 0x9062272, Offset: 0x4ca
    // Size: 0x8c, Type: dev
    function private toggle_lava_toss()
    {
        triton = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x120>" );
        
        while ( true )
        {
            if ( !isalive( triton ) )
            {
                return;
            }
            
            if ( isdefined( triton.enemy ) && !triton._blackboard.var_65f32caa86b87a2 )
            {
                self.rangedattacktarget = triton.enemy;
                triton namespace_7a57a365d91f07dc::function_d517660e6fe7222a();
            }
            
            waitframe();
        }
    }

    // Namespace zombie_triton_lava_toss
    // Params 0, eflags: 0x4
    // Checksum 0xd377e363, Offset: 0x55e
    // Size: 0x1a, Type: dev
    function private function_93dcdb343a030b4b()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x12e>", @"hash_685e011fd4073669" );
    }

#/
