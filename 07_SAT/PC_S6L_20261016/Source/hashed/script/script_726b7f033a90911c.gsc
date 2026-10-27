// script_726b7f033a90911c  (hash_726b7f033a90911c.gscc) (size: 3993 Bytes / 0xf99 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x562db265 (1445835365)
// size ...... 3993 (0xf99)
// includes .. 7   (offset: 0xecd)
// strings ... 7   (offset: 0xf05)
// dev strs .. 4   (offset: 0xf69)
// exports ... 15  (offset: 0x87d)
// cseg ...... 0x10f + 0x76e (0x87d)
// imports ... 33  (offset: 0xad5)
// animtree1 . 0   (offset: 0xf99)
// animtree2 . 0   (offset: 0xf99)
#using script_4fb7a9021a570c8a;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\utility;

#namespace zombie_diana_summon_agni_zombies;

/#

    // Namespace zombie_diana_summon_agni_zombies
    // Params 0
    // Checksum 0x11c60b16, Offset: 0x12d
    // Size: 0xd, Type: dev
    function function_eb57bf24aadaee1d()
    {
        level thread summon_agni_zombies_devgui();
    }

#/

// Namespace zombie_diana_summon_agni_zombies
// Params 0
// Checksum 0xb313a636, Offset: 0x142
// Size: 0x36
function init_diana_summon_agni_zombies()
{
    set_summon_agni_zombies_cooldown( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_e48f85c73bff7252 );
    function_9c7d278fe17b7c00( 1 );
    thread function_649c10fc016e7906();
}

// Namespace zombie_diana_summon_agni_zombies
// Params 1
// Checksum 0x776f4afe, Offset: 0x180
// Size: 0x17
function set_summon_agni_zombies_cooldown( cooldownseconds )
{
    self.var_e48f85c73bff7252 = cooldownseconds;
}

// Namespace zombie_diana_summon_agni_zombies
// Params 1
// Checksum 0x7ee0ce5f, Offset: 0x19f
// Size: 0x17
function function_9c7d278fe17b7c00( var_71cb53db24d1a0d9 )
{
    self.var_8ef0695e15c92a76 = var_71cb53db24d1a0d9;
}

// Namespace zombie_diana_summon_agni_zombies
// Params 1
// Checksum 0xcb90d4bd, Offset: 0x1be
// Size: 0x17
function function_b15050bc8a54fed1( var_83d788a6e69d663a )
{
    self.var_c1583df14aa1c037 = var_83d788a6e69d663a;
}

// Namespace zombie_diana_summon_agni_zombies
// Params 1
// Checksum 0x7cc0ff2c, Offset: 0x1dd
// Size: 0x17
function function_8b9e1d59323dcf9e( var_e2a2c78801af5e2 )
{
    self.var_8c2d83ce57ab7765 = var_e2a2c78801af5e2;
}

// Namespace zombie_diana_summon_agni_zombies
// Params 0, eflags: 0xc
// Checksum 0x82553fe8, Offset: 0x1fc
// Size: 0x176
function private function_649c10fc016e7906()
{
    self notify( #"hash_d4ec8952b3b58f0e" );
    self endon( #"hash_d4ec8952b3b58f0e" );
    self endon( #"death" );
    var_d938ff4d7f6235da = 300;
    
    while ( true )
    {
        self waittill( #"summon_agni_zombies_start" );
        self function_786bb6aa1b76c7ee( "in_idle_waiting_for_action", 1 );
        waitmsg = utility::waittill_any_in_array_or_timeout( [ "armor_break_start", "hibernation_start", "idle_loop_end" ], 2 );
        
        if ( waitmsg == "idle_loop_end" )
        {
            var_3fd0915daa4ef8fa = self.origin;
            var_e69f37b703879dec = self.angles;
            function_5775a284a23d38ff( var_3fd0915daa4ef8fa, var_e69f37b703879dec );
            self.var_fbd2b9707b5bd16f = 1;
            asm::function_7256f5ba459c840b( "summon_agni_zombies_in" );
            self function_786bb6aa1b76c7ee( "in_idle_waiting_for_action", 0 );
            thread function_c67c59f51a489cc1();
            self waittill( #"summon_agnis_end" );
            self forceteleport( var_3fd0915daa4ef8fa, var_e69f37b703879dec, var_d938ff4d7f6235da );
            self.var_fbd2b9707b5bd16f = undefined;
            self.var_8ad388b7caa4eff9 = gettime();
            
            if ( self.var_f9e48b7ff2c39654.size + 1 > 6 )
            {
                self.var_f9e48b7ff2c39654[ self.var_f9e48b7ff2c39654.size - 1 ] = undefined;
            }
            
            self.var_f9e48b7ff2c39654 = arraycombine( [ "summon_agni_zombies" ], self.var_f9e48b7ff2c39654 );
            continue;
        }
        
        self function_786bb6aa1b76c7ee( "in_idle_waiting_for_action", 0 );
    }
}

// Namespace zombie_diana_summon_agni_zombies
// Params 2, eflags: 0x4
// Checksum 0x5dcdb055, Offset: 0x37a
// Size: 0x21
function private function_5775a284a23d38ff( var_3fd0915daa4ef8fa, var_e69f37b703879dec )
{
    self settraversalattributes( var_3fd0915daa4ef8fa, var_3fd0915daa4ef8fa, var_e69f37b703879dec, var_3fd0915daa4ef8fa );
}

// Namespace zombie_diana_summon_agni_zombies
// Params 0, eflags: 0x4
// Checksum 0xb0066bf6, Offset: 0x3a3
// Size: 0x6a
function private function_c67c59f51a489cc1()
{
    self endon( #"death" );
    self endon( #"summon_agnis_end" );
    
    while ( true )
    {
        self waittill( #"hash_a5efc48ebe85691" );
        level callback::callback( "on_hornet_boss_summon_scorched_zombies_vo", { #diana:self } );
        function_b29b30e6870c3542();
        
        if ( self.var_b14209598a0140ab )
        {
            self notify( #"necrotic_projectile_start", 1, 1 );
        }
    }
}

// Namespace zombie_diana_summon_agni_zombies
// Params 0, eflags: 0x4
// Checksum 0xa9ec63d3, Offset: 0x415
// Size: 0x2a9
function private function_b29b30e6870c3542()
{
    if ( !self.var_6e49f7b694f29bf1 || self.var_6e49f7b694f29bf1.size == 0 )
    {
        randompoint = utility::getrandompointincircle( self.var_4827856486127f11.tetherpoint, self.var_4827856486127f11.tetherradius );
        navpoint = getclosestpointonnavmesh( randompoint );
        
        if ( !navpoint )
        {
            navpoint = utility::drop_to_ground( self.var_4827856486127f11.tetherpoint );
        }
        
        zombie_diana_targeting::set_diana_target( { #origin:navpoint } );
        return;
    }
    
    var_1444d9d7b2e519af = 30 + ( self.var_8c2d83ce57ab7765 ?? 0 );
    
    if ( !self.InAssaultRounds && randomfloat( 100 ) > var_1444d9d7b2e519af )
    {
        randompoint = utility::getrandompointincircle( self.var_4827856486127f11.tetherpoint, self.var_4827856486127f11.tetherradius );
        navpoint = getclosestpointonnavmesh( randompoint );
        
        if ( !navpoint )
        {
            navpoint = utility::drop_to_ground( self.var_4827856486127f11.tetherpoint );
        }
        
        zombie_diana_targeting::set_diana_target( { #origin:navpoint } );
        return;
    }
    
    if ( zombie_diana_targeting::get_burst_damage_target() )
    {
        self.var_5852d1bf7680339e = zombie_diana_targeting::get_burst_damage_target();
        zombie_diana_targeting::set_diana_target( zombie_diana_targeting::get_burst_damage_target() );
        return;
    }
    
    if ( zombie_diana_targeting::get_armor_breaker_target() && self.var_5852d1bf7680339e != zombie_diana_targeting::get_armor_breaker_target() )
    {
        self.var_5852d1bf7680339e = zombie_diana_targeting::get_armor_breaker_target();
        zombie_diana_targeting::set_diana_target( zombie_diana_targeting::get_armor_breaker_target() );
        return;
    }
    
    foreach ( losplayer in self.var_6e49f7b694f29bf1 )
    {
        if ( losplayer == zombie_diana_targeting::function_f84be701d1a07953() && self.var_5852d1bf7680339e != zombie_diana_targeting::function_f84be701d1a07953() )
        {
            self.var_5852d1bf7680339e = zombie_diana_targeting::function_f84be701d1a07953();
            zombie_diana_targeting::set_diana_target( zombie_diana_targeting::function_f84be701d1a07953() );
            return;
        }
        
        if ( losplayer.var_f468cf5c9e75db1 && self.var_5852d1bf7680339e != losplayer )
        {
            self.var_5852d1bf7680339e = losplayer;
            zombie_diana_targeting::set_diana_target( losplayer );
            return;
        }
    }
    
    targetplayer = utility::array_random( self.var_6e49f7b694f29bf1 );
    self.var_5852d1bf7680339e = targetplayer;
    zombie_diana_targeting::set_diana_target( targetplayer );
}

// Namespace zombie_diana_summon_agni_zombies
// Params 2
// Checksum 0x536daa85, Offset: 0x6c6
// Size: 0x61
function function_53270f5108d8c335( taskid, params )
{
    var_5a3ff4704ef9d45c = gettime() - ( self.var_8ad388b7caa4eff9 ?? 0 );
    cooldownscore = clamp( math::remap( var_5a3ff4704ef9d45c, 0, utility::function_4b74c15943231980( self.var_e48f85c73bff7252 ), 0, 1 ), 0, 1 );
    return cooldownscore;
}

// Namespace zombie_diana_summon_agni_zombies
// Params 2
// Checksum 0x931f1307, Offset: 0x730
// Size: 0xbf
function function_5ba912c8446fe909( taskid, params )
{
    var_7d979e5b8205c3a7 = 0;
    
    foreach ( var_2bdea747682d42f1 in self.var_f9e48b7ff2c39654 )
    {
        if ( var_2bdea747682d42f1 == "summon_agni_zombies" )
        {
            var_7d979e5b8205c3a7++;
        }
    }
    
    var_9a48b1aac439ed1d = clamp( math::remap( var_7d979e5b8205c3a7, 3, 0, 0, 1 ), 0, 1 );
    return var_9a48b1aac439ed1d;
}

/#

    // Namespace zombie_diana_summon_agni_zombies
    // Params 0
    // Checksum 0xa52a3dff, Offset: 0x7f8
    // Size: 0x2e, Type: dev
    function summon_agni_zombies_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x3b>", "<dev string:x52>", &do_summon_agni_zombies );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_diana_summon_agni_zombies
    // Params 1
    // Checksum 0x490f2f4d, Offset: 0x82e
    // Size: 0x4f, Type: dev
    function do_summon_agni_zombies( params )
    {
        diana = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x69>" );
        
        if ( isdefined( diana ) )
        {
            diana notify( #"summon_agni_zombies_start" );
        }
    }

#/
