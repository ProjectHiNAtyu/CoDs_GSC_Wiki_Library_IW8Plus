// scripts\common\ai\aitypes\zombie_base_abom_crawler\zombie_base_abom_crawler.gsc  (hash_511491b35470111c.gscc) (size: 4046 Bytes / 0xfce / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x55bb1530 (1438324016)
// size ...... 4046 (0xfce)
// includes .. 5   (offset: 0xe5a)
// strings ... 26  (offset: 0xe82)
// dev strs .. 0   (offset: 0xfce)
// exports ... 11  (offset: 0x8da)
// cseg ...... 0x2e2 + 0x5f8 (0x8da)
// imports ... 33  (offset: 0xa92)
// animtree1 . 0   (offset: 0xfce)
// animtree2 . 0   (offset: 0xfce)
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_vox;
#using scripts\common\ai\aitypes\zombie_base\zombie_base_dismemberment;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace zombie_base_abom_crawler;

// Namespace zombie_base_abom_crawler
// Params 2
// Checksum 0x940bf7a6, Offset: 0x300
// Size: 0x95
function precache( classname, aitypescriptbundle )
{
    if ( utility::flag( "init_zombie_base_abom_crawler" ) )
    {
        return;
    }
    
    utility::flag_set( "init_zombie_base_abom_crawler" );
    callback::add( "on_zombie_base_abom_crawler_spawned", &on_zombie_base_abom_crawler_spawned );
    callback::add( "on_zombie_base_abom_crawler_hvt_spawned", &on_zombie_base_abom_crawler_spawned );
    callback::add( "on_zombie_base_abom_crawler_nest_spawned", &on_zombie_base_abom_crawler_spawned );
    level._effect[ "zombie_base_abom_crawler_explode" ] = loadfxasset( "vfx_jup_ob_gameplay_zm_ai_megabomb_crawler_explo" );
    level._effect[ "zombie_base_abom_crawler_aoe" ] = loadfxasset( "vfx_jup_ob_gameplay_zm_ai_megabomb_crawler_aoe" );
}

// Namespace zombie_base_abom_crawler
// Params 1, eflags: 0x4
// Checksum 0x441c3a6f, Offset: 0x39d
// Size: 0x5a
function private on_zombie_base_abom_crawler_spawned( params )
{
    utility::thread_on_notify( "bmeleestarted", &function_6940a032b0e5224f );
    utility::thread_on_notify( "explode_death", &function_9bef1162c24d3d4a );
    callback::add( "on_zombie_ai_damaged", &function_9e6aada58ec4db50 );
    self.var_f9d9fa071693601c = 1;
    namespace_b76ff2659823e89d::function_7c84cd973f7925ea( 1 );
    thread wander_listener();
}

// Namespace zombie_base_abom_crawler
// Params 1, eflags: 0x4
// Checksum 0x7f01f0d2, Offset: 0x3ff
// Size: 0x66
function private function_9e6aada58ec4db50( dmg_struct )
{
    if ( dmg_struct.smeansofdeath == "MOD_EXPLOSIVE" || dmg_struct.smeansofdeath == "MOD_EXPLOSIVE_BULLET" || dmg_struct.smeansofdeath == "MOD_GRENADE_SPLASH" || dmg_struct.smeansofdeath == "MOD_PROJECTILE_SPLASH" )
    {
        function_9bef1162c24d3d4a();
    }
}

// Namespace zombie_base_abom_crawler
// Params 0, eflags: 0x4
// Checksum 0x3283d59e, Offset: 0x46d
// Size: 0x30
function private function_6940a032b0e5224f()
{
    self notify( #"hash_fc4289749ece4a8a" );
    utility::function_32b24db3127bff40( "explode", "charge" );
    utility::function_32b24db3127bff40( "audio_explode", "rise" );
}

// Namespace zombie_base_abom_crawler
// Params 0, eflags: 0x4
// Checksum 0x3e5b5c00, Offset: 0x4a5
// Size: 0x89
function private function_9bef1162c24d3d4a()
{
    self notify( #"hash_fc4289749ece4a8a" );
    playfx( level._effect[ "zombie_base_abom_crawler_explode" ], self.origin );
    playfx( level._effect[ "zombie_base_abom_crawler_aoe" ], self.origin );
    utility::function_32b24db3127bff40( "audio_explode", "explode" );
    thread abom_crawler_explosion( self.origin, self.team );
    wait 0.2;
    self.nocorpse = 1;
    self kill();
}

// Namespace zombie_base_abom_crawler
// Params 2, eflags: 0x4
// Checksum 0x4b77b8d1, Offset: 0x536
// Size: 0x1ba
function private abom_crawler_explosion( position, var_2679b99eaa47c55f )
{
    var_34ebc284ed1ce5f9 = utility::spawn_script_origin();
    time_interval = 0.5;
    total_time_limit = 3.5;
    var_7d43ccfa569e3184 = 150;
    var_af20df805aa22681 = 10;
    initial_damage = 20;
    var_99734d34b9b3181c = 0;
    
    while ( var_99734d34b9b3181c <= total_time_limit )
    {
        /#
            if ( abom_crawler_debug() )
            {
                sphere( position, var_7d43ccfa569e3184, ( 1, 0, 0 ) );
            }
        #/
        
        var_62014cf6653d5664 = physics_querypoint( position, var_7d43ccfa569e3184, physics_createcontents( [ "physicscontents_characterproxy" ] ), [ self ], "physicsquery_all" );
        
        foreach ( potential_target in var_62014cf6653d5664 )
        {
            target_ent = potential_target[ "entity" ];
            
            if ( !isalive( target_ent ) || target_ent.team == var_2679b99eaa47c55f )
            {
                continue;
            }
            
            if ( isai( potential_target ) )
            {
                if ( potential_target.type == "zombie" )
                {
                    potential_target zombie_stun::stun_ai( time_interval );
                }
            }
            
            damage = var_99734d34b9b3181c == 0 ? initial_damage : var_af20df805aa22681;
            target_ent dodamage( damage, position, var_34ebc284ed1ce5f9 );
        }
        
        wait time_interval;
        var_99734d34b9b3181c += time_interval;
    }
    
    var_34ebc284ed1ce5f9 delete();
}

// Namespace zombie_base_abom_crawler
// Params 0, eflags: 0x4
// Checksum 0x4b021a89, Offset: 0x6f8
// Size: 0x54
function private wander_listener()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"wander_start" );
        self._blackboard.var_b213ded5043dfa2b = self.origin;
        thread function_dbbb0503e1e0ba7d();
        self waittill( #"wander_end" );
    }
}

// Namespace zombie_base_abom_crawler
// Params 0, eflags: 0x4
// Checksum 0xac2d4c63, Offset: 0x754
// Size: 0xa5
function private function_dbbb0503e1e0ba7d()
{
    self endon( #"death" );
    self endon( #"wander_end" );
    var_bfe3e3c71649a5aa = 10;
    wait var_bfe3e3c71649a5aa;
    
    if ( isdefined( self.var_2058466b83c7a86 ) )
    {
        var_23f68221f1042c10 = distance2dsquared( self.var_2058466b83c7a86.origin, self.origin );
        give_up_dist_threshold = 1500;
        
        if ( var_23f68221f1042c10 > give_up_dist_threshold * give_up_dist_threshold )
        {
            self kill();
        }
        
        self._blackboard.var_b213ded5043dfa2b = self.var_2058466b83c7a86.origin;
    }
}

// Namespace zombie_base_abom_crawler
// Params 0, eflags: 0x4
// Checksum 0xd79b40e3, Offset: 0x801
// Size: 0xbb
function private function_601a5aaa12cf536()
{
    var_fd16a9c5c5ac1ab1 = 3;
    self endon( #"death" );
    self endon( #"hash_fc4289749ece4a8a" );
    wait randomfloatrange( 1, 3 );
    var_44bb78e47c206b2b = 0;
    
    while ( true )
    {
        if ( self.movemode == "stop" )
        {
            wait 1;
            continue;
        }
        
        if ( isdefined( level.var_7538460147be1e93 ) )
        {
            level.var_7538460147be1e93++;
            
            if ( level.var_7538460147be1e93 < var_fd16a9c5c5ac1ab1 )
            {
                var_44bb78e47c206b2b = 1;
                level thread zombie_vox::function_e7828eef0e4316d6( self, "ambient_normal", "vox_ai_abom_crawl_ambient", 1 );
            }
        }
        
        if ( var_44bb78e47c206b2b )
        {
            var_44bb78e47c206b2b = 0;
            wait randomfloatrange( 0.1, 0.3 );
            continue;
        }
        
        wait 0.1;
    }
}

/#

    // Namespace zombie_base_abom_crawler
    // Params 0, eflags: 0x4
    // Checksum 0x1b915908, Offset: 0x8c4
    // Size: 0x16, Type: dev
    function private abom_crawler_debug()
    {
        return getdvarint( @"abom_crawler_debug", 0 ) > 0;
    }

#/
