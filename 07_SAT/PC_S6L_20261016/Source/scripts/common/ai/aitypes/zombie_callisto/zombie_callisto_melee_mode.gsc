// scripts\common\ai\aitypes\zombie_callisto\zombie_callisto_melee_mode.gsc  (hash_6684597b534dd23d.gscc) (size: 4081 Bytes / 0xff1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd12bc660 (3509306976)
// size ...... 4081 (0xff1)
// includes .. 7   (offset: 0xe65)
// strings ... 11  (offset: 0xe9d)
// dev strs .. 14  (offset: 0xf41)
// exports ... 12  (offset: 0x8b9)
// cseg ...... 0x133 + 0x786 (0x8b9)
// imports ... 33  (offset: 0xa99)
// animtree1 . 0   (offset: 0xff1)
// animtree2 . 0   (offset: 0xff1)
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\status_effects\effect_stun;
#using scripts\common\status_effects\status_effects;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_callisto_melee_mode;

/#

    // Namespace zombie_callisto_melee_mode
    // Params 0
    // Checksum 0x87c580ef, Offset: 0x151
    // Size: 0xc, Type: dev
    function function_3aa66d7f880a42de()
    {
        function_bc68201769ff4631();
    }

#/

// Namespace zombie_callisto_melee_mode
// Params 0
// Checksum 0xa9d1cfd8, Offset: 0x165
// Size: 0xaf
function function_e70a98b820ac4d10()
{
    callback::add( "on_zombie_ai_damaged", &function_146f22b83839e922 );
    self function_786bb6aa1b76c7ee( "zombeesattack_canattack", 0 );
    thread function_1cdd341519290474();
    self.in_melee_mode = 1;
    self.var_654652758acbc7c8 = 0;
    self.var_46d8fc4a40fdb46e = 0;
    self.var_a94e0f1896aa9b59 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_7aac957d3813f747;
    self.var_91298084315218bb = int( utility::function_4b74c15943231980( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_fd5cd5edb1101460 ) );
    self function_786bb6aa1b76c7ee( "charge_cooldown", self.var_91298084315218bb );
}

// Namespace zombie_callisto_melee_mode
// Params 0
// Checksum 0x844169e5, Offset: 0x21c
// Size: 0x76
function function_44b558b496502ed()
{
    callback::callback( #"hash_2696b38f8e549a5c" );
    callback::remove( "on_zombie_ai_damaged", &function_146f22b83839e922 );
    self.in_melee_mode = undefined;
    
    if ( self.var_c2c4733342e35fa9 > 0 && !self.var_ea0339471f98d3c7 )
    {
        self function_786bb6aa1b76c7ee( "zombeesattack_canattack", 1 );
    }
    
    self function_786bb6aa1b76c7ee( "charge_cooldown", self.charge_cooldown );
    self notify( #"hash_69787bc2f1e8b7f2" );
}

// Namespace zombie_callisto_melee_mode
// Params 0, eflags: 0x4
// Checksum 0x8e6291e3, Offset: 0x29a
// Size: 0x10f
function private function_1cdd341519290474()
{
    self endon( #"death" );
    self endon( #"hash_69787bc2f1e8b7f2" );
    self.var_45ab3eb74ece1e17 = 0;
    
    while ( true )
    {
        self waittill( #"track_charge_end" );
        hit_result = self getaiblackboarddynamic( "charge_hit_result" );
        
        if ( hit_result == "hit" )
        {
            self.var_45ab3eb74ece1e17 = 0;
            continue;
        }
        
        self.var_45ab3eb74ece1e17++;
        
        if ( self.var_45ab3eb74ece1e17 >= self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_5ba474ae4d6712f4 )
        {
            effect_stun::stun( "callisto_melee_mode_stun", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_5bf58ffd20169f0d );
            self.var_45ab3eb74ece1e17 = 0;
            self.var_654652758acbc7c8 = 0;
            self.var_46d8fc4a40fdb46e = 0;
            thread stun_grace_period( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_5bf58ffd20169f0d, self.var_a94e0f1896aa9b59 );
        }
    }
}

// Namespace zombie_callisto_melee_mode
// Params 1, eflags: 0x4
// Checksum 0x5da2619d, Offset: 0x3b1
// Size: 0x1e8
function private function_146f22b83839e922( params )
{
    if ( isplayer( params.eattacker ) )
    {
        if ( !isdefined( self.var_f7f195338c58076c ) )
        {
            self.var_f7f195338c58076c = self.maxhealth * self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_9abe54275c807afa / 100;
        }
        
        var_acc7f1c7b82b3d7a = isdefined( params.sweapon.basename ) && issubstr( params.sweapon.basename, "ballisticknife" );
        
        if ( isdefined( params.smeansofdeath ) && !utility::ismeleedamage( params.smeansofdeath ) && !var_acc7f1c7b82b3d7a )
        {
            function_44b558b496502ed();
        }
        
        self.var_46d8fc4a40fdb46e++;
        
        if ( status_effects::function_fa35fc2723e956eb( "stun", "callisto_melee_mode_stun" ) && self.var_46d8fc4a40fdb46e >= self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_66aef49856e2181c )
        {
            effect_stun::function_cf15e13610c1177( "callisto_melee_mode_stun" );
            self notify( #"melee_mode_stun_end" );
        }
        
        self.var_654652758acbc7c8 += params.idamage;
        
        if ( self.var_654652758acbc7c8 >= self.var_f7f195338c58076c )
        {
            effect_stun::stun( "callisto_melee_mode_stun", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_c90f113c51f1f39b, self.eattacker );
            self.var_45ab3eb74ece1e17 = 0;
            self.var_654652758acbc7c8 = 0;
            self.var_46d8fc4a40fdb46e = 0;
            thread stun_grace_period( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_c90f113c51f1f39b, self.var_a94e0f1896aa9b59 );
        }
    }
}

// Namespace zombie_callisto_melee_mode
// Params 2, eflags: 0xc
// Checksum 0xbff14138, Offset: 0x5a1
// Size: 0x6e
function private stun_grace_period( expectedstunduration, graceperiodduration )
{
    self notify( #"hash_fd10a62f5959588d" );
    self endon( #"hash_fd10a62f5959588d" );
    self endon( #"death" );
    utility::waittill_notify_or_timeout( "melee_mode_stun_end", expectedstunduration );
    val::set( "melee_mode_grace_period", "disallow_stun", 1 );
    wait graceperiodduration;
    val::reset( "melee_mode_grace_period", "disallow_stun" );
}

/#

    // Namespace zombie_callisto_melee_mode
    // Params 0
    // Checksum 0x9ebda6c5, Offset: 0x617
    // Size: 0x5a, Type: dev
    function function_bc68201769ff4631()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x3e>", "<dev string:x4f>", &function_98c0ee873e18d808 );
        devgui::add_devgui_func( "<dev string:x63>", "<dev string:x72>", &function_39adbc08a8bad271 );
        devgui::add_devgui_func( "<dev string:x86>", "<dev string:x99>", &function_4ce83d6a3e0a8239 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_callisto_melee_mode
    // Params 0, eflags: 0x4
    // Checksum 0xfc5b9082, Offset: 0x679
    // Size: 0x41, Type: dev
    function private function_98c0ee873e18d808()
    {
        callisto = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:xb5>" );
        
        if ( isdefined( callisto ) )
        {
            callisto function_e70a98b820ac4d10();
        }
    }

    // Namespace zombie_callisto_melee_mode
    // Params 0, eflags: 0x4
    // Checksum 0xf2c2daff, Offset: 0x6c2
    // Size: 0x41, Type: dev
    function private function_39adbc08a8bad271()
    {
        callisto = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:xb5>" );
        
        if ( isdefined( callisto ) )
        {
            callisto function_44b558b496502ed();
        }
    }

    // Namespace zombie_callisto_melee_mode
    // Params 0, eflags: 0x4
    // Checksum 0x647e62d4, Offset: 0x70b
    // Size: 0x79, Type: dev
    function private function_4ce83d6a3e0a8239()
    {
        callisto = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:xb5>" );
        
        if ( isdefined( callisto ) )
        {
            if ( !callisto.var_30ada447e0010138 )
            {
                callisto.var_30ada447e0010138 = 1;
                callisto thread function_f05af7fdfcd7c48f();
                return;
            }
            
            callisto.var_30ada447e0010138 = undefined;
            callisto notify( #"hash_1f14fdf70d805ed8" );
        }
    }

    // Namespace zombie_callisto_melee_mode
    // Params 0, eflags: 0x4
    // Checksum 0xa7d3b52e, Offset: 0x78c
    // Size: 0x12d, Type: dev
    function private function_f05af7fdfcd7c48f()
    {
        self endon( #"death" );
        self endon( #"hash_1f14fdf70d805ed8" );
        
        while ( true )
        {
            if ( isdefined( self.in_melee_mode ) )
            {
                print3d( self.origin + ( 0, 0, 100 ), "<dev string:xc9>" + ( self.in_melee_mode ? "<dev string:xd6>" : "<dev string:xdb>" ) );
            }
            
            if ( isdefined( self.var_45ab3eb74ece1e17 ) )
            {
                print3d( self.origin + ( 0, 0, 80 ), "<dev string:xe1>" + self.var_45ab3eb74ece1e17 );
            }
            
            if ( isdefined( self.var_f7f195338c58076c ) && isdefined( self.var_654652758acbc7c8 ) )
            {
                print3d( self.origin + ( 0, 0, 60 ), "<dev string:xf6>" + self.var_f7f195338c58076c - self.var_654652758acbc7c8 );
            }
            
            if ( isdefined( self.var_46d8fc4a40fdb46e ) )
            {
                print3d( self.origin + ( 0, 0, 40 ), "<dev string:x10a>" + self.var_46d8fc4a40fdb46e );
            }
            
            waitframe();
        }
    }

#/
