// scripts\mp\ob\skills\skill_decoy.gsc  (hash_6952da2bb4fdbc69.gscc) (size: 6362 Bytes / 0x18da / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe695ce85 (3868577413)
// size ...... 6362 (0x18da)
// includes .. 11  (offset: 0x17c6)
// strings ... 8   (offset: 0x181e)
// dev strs .. 7   (offset: 0x1882)
// exports ... 19  (offset: 0xdb6)
// cseg ...... 0xd7 + 0xcdf (0xdb6)
// imports ... 62  (offset: 0x10ae)
// animtree1 . 0   (offset: 0x18da)
// animtree2 . 0   (offset: 0x18da)
#using script_16ea1b94f0f381b3;
#using script_2fe74ee229c972c3;
#using scripts\common\ai\ai_utility;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\callbacks;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\common\supers\combat_hologram;
#using scripts\mp\common\utility\entity;
#using scripts\mp\common\utility\player_utility;

#namespace skill_decoy;

// Namespace skill_decoy
// Params 0, eflags: 0x1
// Checksum 0x64cddcc2, Offset: 0xf5
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"decoy", &init );
}

// Namespace skill_decoy
// Params 0
// Checksum 0x8403a714, Offset: 0x114
// Size: 0xcf
function init()
{
    utility::registersharedfunc( #"decoy", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"decoy", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
    
    /#
        namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_3f0701e5a66d7a2f", &function_a70e5c6e079bdca );
    #/
    
    if ( !level.superglobals.staticsuperdata[ "super_combat_hologram" ] )
    {
        var_c92f46c7f0b54a99 = level.skillbundles[ #"decoy" ][ 0 ].var_8bb92b5924373628;
        level.superglobals.staticsuperdata[ "super_combat_hologram" ] = { #bundle:getscriptbundle( var_c92f46c7f0b54a99 ) };
        combat_hologram::combatholo_init();
    }
}

// Namespace skill_decoy
// Params 1, eflags: 0x4
// Checksum 0x9ffe1f6f, Offset: 0x1eb
// Size: 0x38, Type: bool
function private on_give_skill( skill_bundle )
{
    self.var_5b5ae3cde81df1e5 = { #bundle:skill_bundle };
    callback::add( #"player_damaged", &on_player_damaged );
    return true;
}

// Namespace skill_decoy
// Params 1, eflags: 0x4
// Checksum 0x98be7cf9, Offset: 0x22c
// Size: 0x4e
function private function_c51f1692ecb73bfe( skill_bundle )
{
    self notify( #"kill_decoy" );
    
    if ( callback::exists( #"player_damaged", &on_player_damaged ) )
    {
        callback::remove( #"player_damaged", &on_player_damaged );
    }
    
    self.var_5b5ae3cde81df1e5 = undefined;
}

// Namespace skill_decoy
// Params 1, eflags: 0x4
// Checksum 0x7a12f92a, Offset: 0x282
// Size: 0xf8
function private on_player_damaged( params )
{
    if ( !params.healthdamage )
    {
        return;
    }
    
    if ( self.health <= 0 )
    {
        return;
    }
    
    if ( params.smeansofdeath == "MOD_FALLING" )
    {
        return;
    }
    
    if ( self isswimming() || vehicle::is_in_vehicle() || self isonascender() || self isparachuting() || self isskydiving() || self isonladder() )
    {
        return;
    }
    
    bundle = self.var_5b5ae3cde81df1e5.bundle;
    
    if ( self.health <= bundle.var_da79b931e5c94b4f )
    {
        spawn_decoy( self.origin + ( 0, 0, bundle.var_4783bc260b545e0 ), ( 0, 0, 0 ), bundle );
        callback::remove( #"player_damaged", &on_player_damaged );
        thread function_a17a36460bf2f81a();
    }
}

// Namespace skill_decoy
// Params 3, eflags: 0x4
// Checksum 0x435f7593, Offset: 0x382
// Size: 0x92
function private spawn_decoy( origin, speed, bundle )
{
    var_c5142e0d1342bef0 = magicgrenademanual( bundle.decoydevice, origin, speed, 0, self );
    var_c5142e0d1342bef0.var_71ef7a5805150f86 = bundle.decoyduration;
    var_c5142e0d1342bef0.invulnerable = 1;
    var_c5142e0d1342bef0.var_12274c4091af22bf = bundle.var_785c14b6416cea78;
    var_c5142e0d1342bef0.health = 1;
    var_c5142e0d1342bef0 thread monitor_decoy( bundle );
}

// Namespace skill_decoy
// Params 0, eflags: 0x4
// Checksum 0xc0f77691, Offset: 0x41c
// Size: 0x46
function private function_a17a36460bf2f81a()
{
    self endon( #"death", #"disconnect", #"kill_decoy" );
    utility::waittill_any( "healed", "last_stand_enter" );
    callback::add( #"player_damaged", &on_player_damaged );
}

// Namespace skill_decoy
// Params 1, eflags: 0x4
// Checksum 0xc5b091d1, Offset: 0x46a
// Size: 0x214
function private monitor_decoy( bundle )
{
    self endon( #"death" );
    self waittill( #"combatholo_activated" );
    
    if ( bundle.var_b84b99084a5f11f2 )
    {
        self.attractor = zombie_attractor_manager::add_attractor( self, bundle.var_a00579ab5cf66344 ?? 0, bundle.var_b84b99084a5f11f2, 1, undefined, &function_a92d75a1117625fc, 0, undefined, 0 );
        var_b165e434e60be77b = ( bundle.var_f50044fc601e578c ?? 0, bundle.var_f50045fc601e59bf ?? 0, bundle.var_f50046fc601e5bf2 ?? 0 );
        box_half_size = ( bundle.var_369639853499ed43 ?? 0, bundle.var_8956dc592d188af6 ?? 0, bundle.var_2ff68f463bd2eae9 ?? 0 );
        zombie_attractor_manager::function_a2aab3762aaa055f( self.attractor, self.origin + var_b165e434e60be77b, box_half_size, self.angles );
        
        /#
            if ( getdvarint( @"hash_672db1f0420780ba", 0 ) )
            {
                debug_radius_effect( self.origin, bundle.var_b84b99084a5f11f2, "<dev string:x24>" );
            }
        #/
    }
    
    if ( bundle.var_3b6aab83da5adfde )
    {
        thread function_5b389b3749d04c47( bundle.var_3b6aab83da5adfde, bundle.var_785c14b6416cea78 );
        
        /#
            if ( getdvarint( @"hash_d42456d09e1efd9a", 0 ) )
            {
                debug_radius_effect( self.origin, bundle.var_3b6aab83da5adfde, "<dev string:x2b>" );
            }
        #/
    }
    
    if ( bundle.var_745027c38f7e0216 )
    {
        self.var_e4951b26b66770ee = self.origin + ( 0, 0, bundle.var_ca98dcfe1ba73d0c ?? 0 );
        thread function_a0eff8c840c22ea7( bundle.var_745027c38f7e0216 );
        
        /#
            if ( getdvarint( @"hash_3d0df2fc25708c32", 0 ) )
            {
                debug_radius_effect( self.origin, bundle.var_745027c38f7e0216, "<dev string:x31>" );
            }
        #/
    }
    
    thread function_93553c0d5ae12ecd();
}

// Namespace skill_decoy
// Params 0, eflags: 0x4
// Checksum 0x9e150def, Offset: 0x686
// Size: 0x140
function private function_93553c0d5ae12ecd()
{
    self waittill( #"death" );
    
    if ( self.attractor )
    {
        zombie_attractor_manager::remove_attractor( self.attractor );
    }
    
    if ( self.soldiers_affected )
    {
        foreach ( soldier_ai in self.soldiers_affected )
        {
            soldier_ai function_dc58039caafaf70a();
        }
    }
    
    if ( self.turrets_affected )
    {
        foreach ( turret in self.turrets_affected )
        {
            turret.force_target = undefined;
            turret.decoy_target = undefined;
        }
    }
}

// Namespace skill_decoy
// Params 2, eflags: 0x4
// Checksum 0x640a0699, Offset: 0x7ce
// Size: 0x32
function private function_a92d75a1117625fc( attractor, ai )
{
    return ai function_e3d3424d7d443cfe( attractor.source.var_12274c4091af22bf );
}

// Namespace skill_decoy
// Params 3, eflags: 0x4
// Checksum 0x18251e2d, Offset: 0x809
// Size: 0x129
function private function_c1b5ecf0005bad59( throttle, ai, var_46629f9a8025bc14 )
{
    self endon( #"death" );
    assert( ai.type == "<dev string:x2b>" );
    throttle::throttle_wait_in_queue( throttle, ai );
    
    if ( !isalive( ai ) )
    {
        self.soldiers_affected = arrayremove( self.soldiers_affected, ai );
        return;
    }
    
    friendly = player_utility::isfriendly( ai.team ?? ai.agentteam, self.owner );
    
    if ( friendly && ai.decoy_target )
    {
        ai function_dc58039caafaf70a();
        self.soldiers_affected = arrayremove( self.soldiers_affected, ai );
    }
    
    if ( !friendly && !ai.decoy_target && ai cansee( self, 1000 ) )
    {
        ai setentitytarget( self );
        ai.decoy_target = self;
        self.soldiers_affected[ self.soldiers_affected.size ] = ai;
    }
}

// Namespace skill_decoy
// Params 3, eflags: 0x4
// Checksum 0xa7941dd8, Offset: 0x93a
// Size: 0x53, Type: bool
function private can_attract_soldier( ai, throttle, var_46629f9a8025bc14 )
{
    if ( ai.type != "human" )
    {
        return false;
    }
    
    if ( !ai function_e3d3424d7d443cfe( var_46629f9a8025bc14 ) )
    {
        return false;
    }
    
    if ( throttle::function_311421fabea78894( throttle, ai ) )
    {
        return false;
    }
    
    return true;
}

// Namespace skill_decoy
// Params 2, eflags: 0xc
// Checksum 0xaf8a0a3, Offset: 0x996
// Size: 0xfd
function private function_5b389b3749d04c47( radius, var_46629f9a8025bc14 )
{
    self notify( #"hash_4a8e8b21842cb4d4" );
    self endon( #"hash_4a8e8b21842cb4d4" );
    self endon( #"death" );
    self.soldiers_affected = [];
    var_caa53c8aa5c9e55e = throttle::throttle_initialize( "skill_decoy", 3 );
    
    while ( true )
    {
        ai_array = getaiarrayinradius( self.origin, radius );
        
        foreach ( ai in ai_array )
        {
            if ( can_attract_soldier( ai, var_caa53c8aa5c9e55e, var_46629f9a8025bc14 ) )
            {
                thread function_c1b5ecf0005bad59( var_caa53c8aa5c9e55e, ai, var_46629f9a8025bc14 );
            }
        }
        
        waitframe();
    }
}

// Namespace skill_decoy
// Params 1, eflags: 0xc
// Checksum 0x5d82f8cc, Offset: 0xa9b
// Size: 0x16b
function private function_a0eff8c840c22ea7( radius )
{
    self notify( #"hash_b59d592a209d105f" );
    self endon( #"hash_b59d592a209d105f" );
    self endon( #"death" );
    self.turrets_affected = [];
    turret_mask = createentitytypemask( [ "etype_turret", "etype_vehicle" ] );
    
    while ( true )
    {
        turrets_array = getentitiesinradiusfrompartitiongrid( self.origin, radius, turret_mask );
        
        foreach ( turret in turrets_array )
        {
            if ( !turret.decoy_target && !player_utility::isfriendly( turret.team, self.owner ) && ( entity::isturret( turret ) || turret.dawg || turret function_a7378c4908103226() ) )
            {
                turret.force_target = self;
                turret.decoy_target = self;
                self.turrets_affected[ self.turrets_affected.size ] = turret;
            }
        }
        
        waitframe();
    }
}

// Namespace skill_decoy
// Params 0, eflags: 0x4
// Checksum 0x7ad1258e, Offset: 0xc0e
// Size: 0x12
function private function_dc58039caafaf70a()
{
    self clearentitytarget();
    self.decoy_target = undefined;
}

// Namespace skill_decoy
// Params 1, eflags: 0x4
// Checksum 0x874e8442, Offset: 0xc28
// Size: 0x32, Type: bool
function private function_e3d3424d7d443cfe( var_46629f9a8025bc14 )
{
    tier_number = ai_utility::get_power_tier();
    assert( isdefined( tier_number ), "<dev string:x39>" );
    return var_46629f9a8025bc14 >= tier_number;
}

/#

    // Namespace skill_decoy
    // Params 3, eflags: 0x4
    // Checksum 0x28c876bd, Offset: 0xc63
    // Size: 0x74, Type: dev
    function private debug_radius_effect( origin, radius, type )
    {
        text = type + "<dev string:xa2>" + string( radius );
        printtoscreen2d( 500, 350, text, ( 1, 1, 1 ), 2, 300 );
        sphere( origin, radius, ( 0, 1, 0 ), 0, 300 );
    }

    // Namespace skill_decoy
    // Params 1, eflags: 0x4
    // Checksum 0x4a3cf138, Offset: 0xcdf
    // Size: 0xd7, Type: dev
    function private function_a70e5c6e079bdca( params )
    {
        if ( level.players.size > 1 )
        {
            printtoscreen2d( 500, 350, "<dev string:xb2>", ( 1, 0, 0 ), 2, 300 );
            return;
        }
        
        player = level.players[ 0 ];
        bundle = player.var_5b5ae3cde81df1e5.bundle;
        
        if ( bundle )
        {
            forward = anglestoforward( player getplayerangles() ) * 1000;
            pos = player geteye();
            player spawn_decoy( pos, forward, bundle );
            return;
        }
        
        printtoscreen2d( 500, 350, "<dev string:xed>", ( 1, 0, 0 ), 2, 300 );
    }

#/
