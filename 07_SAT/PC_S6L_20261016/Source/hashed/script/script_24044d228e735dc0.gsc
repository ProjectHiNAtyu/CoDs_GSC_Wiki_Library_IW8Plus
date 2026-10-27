// script_24044d228e735dc0  (hash_24044d228e735dc0.gscc) (size: 19062 Bytes / 0x4a76 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6c2be9e2 (1814817250)
// size ...... 19062 (0x4a76)
// includes .. 21  (offset: 0x46b2)
// strings ... 51  (offset: 0x475a)
// dev strs .. 1   (offset: 0x4a6a)
// exports ... 49  (offset: 0x2d86)
// cseg ...... 0x42a + 0x295c (0x2d86)
// imports ... 141 (offset: 0x352e)
// animtree1 . 0   (offset: 0x4a76)
// animtree2 . 0   (offset: 0x4a76)
#using script_180a3d9c63ac0435;
#using script_38390664ae794177;
#using script_4ce55cfc81c444ad;
#using script_5cf687c0317fe818;
#using scripts\anim\shared;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_melee;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\mp_agent_damage;
#using scripts\mp\zm\ztron\ztron_debug;
#using scripts\mp\zm\ztron\ztron_enemy;
#using scripts\mp\zm\ztron\ztron_enemy_ai;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace ztron_papaback;

// Namespace ztron_papaback
// Params 2
// Checksum 0xc99c2c27, Offset: 0x448
// Size: 0x15
function precache( classname, aitypescriptbundle )
{
    
}

// Namespace ztron_papaback
// Params 1, eflags: 0x4
// Checksum 0x1f058ce9, Offset: 0x465
// Size: 0x1a
function private function_cfbb84b3d7bc65b8( params )
{
    zombie_melee::init_zombie_melee_global();
    namespace_245308063ee5298c::function_a4788d12c4ff81ef();
}

// Namespace ztron_papaback
// Params 1
// Checksum 0x4b7d17e2, Offset: 0x487
// Size: 0x6b
function function_c94fe648ad5b0806( taskid )
{
    assert( isdefined( self.zombieaisetting ) );
    zombie_init::function_5d23979c4c7c9a52( self.zombieaisetting );
    callback::add( "on_first_ai_init", &function_cfbb84b3d7bc65b8 );
    zombie_melee::init_zombie_melee();
    zombie_melee::function_2cc3729a3cdeadbf( "walk", 85 );
    zombie_melee::function_2cc3729a3cdeadbf( "sprint", 175 );
    return anim.success;
}

// Namespace ztron_papaback
// Params 3
// Checksum 0xc4e9dccf, Offset: 0x4fb
// Size: 0x23f, Type: bool
function function_dcbe8e8348b8ee0a( asmname, statename, params )
{
    if ( self.ignoreall )
    {
        return false;
    }
    
    if ( self.var_b08bd953529081c8 )
    {
        self.var_b08bd953529081c8 = 0;
        return isdefined( self.specialattack );
    }
    
    if ( self.gatheritems || self.var_9f4fae59ff4e962a )
    {
        return false;
    }
    
    if ( isdefined( self.specialattack ) )
    {
        return true;
    }
    
    if ( !isdefined( self.enemy ) )
    {
        return false;
    }
    
    time = gettime();
    
    if ( time < self.var_efb5487ff27de9aa )
    {
        return false;
    }
    
    if ( randomint( 100 ) > getdvarint( @"hash_edd0b2f190ebd858", 90 ) )
    {
        self.var_efb5487ff27de9aa = time + self.var_432560390d1610f8;
        return false;
    }
    
    totalweight = self.var_82aec136c1f15915 + self.var_421016727bb9d576 + self.var_7ab9bf674d09ca62 + self.var_d1adaf357e2de3fe;
    
    if ( self.ztron.raygununlocked )
    {
        totalweight += self.var_b6a628b8647c0e79;
    }
    
    result = randomint( totalweight );
    
    if ( result < self.var_82aec136c1f15915 )
    {
        self.specialattack = "boostAttack";
    }
    else if ( result < self.var_82aec136c1f15915 + self.var_421016727bb9d576 )
    {
        self.specialattack = "jumpAttack";
    }
    else if ( result < self.var_82aec136c1f15915 + self.var_421016727bb9d576 + self.var_7ab9bf674d09ca62 )
    {
        self.specialattack = "throwAttack";
    }
    else if ( result < self.var_82aec136c1f15915 + self.var_421016727bb9d576 + self.var_7ab9bf674d09ca62 + self.var_d1adaf357e2de3fe )
    {
        self.specialattack = "pipeAttack";
    }
    else
    {
        self.specialattack = "shootAttack";
    }
    
    /#
        if ( self.var_28ab931e2c6aab98 && !self.ztron.var_efb305d154bbb2e8 )
        {
            self.specialattack = "<dev string:x24>";
        }
    #/
    
    return true;
}

// Namespace ztron_papaback
// Params 3
// Checksum 0xed630918, Offset: 0x743
// Size: 0x2d, Type: bool
function function_b547dc4b9295af7e( asmname, statename, params )
{
    return self.specialattack == "boostAttack";
}

// Namespace ztron_papaback
// Params 3
// Checksum 0xe66ebdc6, Offset: 0x779
// Size: 0x4e
function function_eb5961ff44ff1757( asmname, statename, params )
{
    if ( function_b547dc4b9295af7e() )
    {
        if ( !self.var_fedfe8d9224df1c7 )
        {
            thread papabackboost();
        }
        
        return anim.running;
    }
    
    return anim.success;
}

// Namespace ztron_papaback
// Params 0, eflags: 0xc
// Checksum 0xe4c87826, Offset: 0x7d0
// Size: 0xb2
function private papabackboost()
{
    self notify( #"hash_2266cf5806e35162" );
    self endon( #"hash_2266cf5806e35162" );
    self endon( #"death" );
    self function_786bb6aa1b76c7ee( "special_attack", 1 );
    self.boostorg.origin = self.origin;
    self.boostorg.angles = self.angles;
    self.boostattacks = randomintrange( 4, 7 );
    self.var_fedfe8d9224df1c7 = 1;
    ztron_dialog::function_927bb94feca983e8( getxhash( "bubble_message_papaback" ) );
    thread function_67fa6944b277df20( self.boostorg, self.boostattacks );
}

// Namespace ztron_papaback
// Params 2, eflags: 0x4
// Checksum 0x652c8287, Offset: 0x88a
// Size: 0x32e
function private function_67fa6944b277df20( boostorg, var_1c92e1e8e7469e6f = 1 )
{
    if ( !isdefined( self.enemy ) )
    {
        return;
    }
    
    self endon( #"death" );
    ang = vectortoangles( self.enemy.origin - self.origin );
    boostorg rotateto( ( 0, ang[ 1 ], 0 ), 0.2 );
    namespace_4f6b9f859d8abc98::papabackshield( 1, 0 );
    playfxontag( utility::getfx( self.boostfx ), self.fxmodel, "tag_origin" );
    wait 1;
    self linkto( self.boostorg );
    
    while ( var_1c92e1e8e7469e6f > 0 && isdefined( self.enemy ) )
    {
        var_1c92e1e8e7469e6f--;
        targetorigin = self.enemy.origin;
        ang = vectortoangles( targetorigin - self.origin );
        boostorg rotateto( ( 0, ang[ 1 ], 0 ), 0.2 );
        boostorg waittill( #"rotatedone" );
        wait 0.5;
        playrumbleonposition( "grenade_rumble", self.origin );
        dist = distance( targetorigin, self.origin ) + 256;
        forward = anglestoforward( boostorg.angles );
        targetspot = boostorg.origin + forward * dist;
        trace = trace::ray_trace( boostorg.origin + ( 0, 0, 64 ), targetspot + ( 0, 0, 64 ), [ self ], trace::create_solid_ai_contents( 1 ) );
        
        if ( trace[ "hittype" ] != "hittype_none" )
        {
            targetspot = trace[ "position" ] + forward * -64;
        }
        
        targetspot = ztron_util::function_3fe38741460a4a49( targetspot, 80 );
        
        if ( var_1c92e1e8e7469e6f == 0 )
        {
            targetspot = getclosestpointonnavmesh( targetspot );
        }
        
        dist = distance( boostorg.origin, targetspot );
        slidespeed = var_1c92e1e8e7469e6f > 0 ? 1000 : 1800;
        traveltime = clamp( dist / slidespeed, 0.1, 1.6 );
        boostorg thread function_c93b15aab5177d4c( self.enemy );
        ztron_sound::ztron_playsound( "papaback_boost_attack_OS", undefined, self );
        boostorg moveto( targetspot, traveltime );
        boostorg utility::waittill_any_timeout( traveltime + 2, "movedone" );
        boostorg notify( #"hash_5ca0a2786efd72b2" );
    }
    
    stopfxontag( utility::getfx( self.boostfx ), self.fxmodel, "tag_origin" );
    self.var_fedfe8d9224df1c7 = undefined;
    self unlink();
    namespace_4f6b9f859d8abc98::papabackshield( 0 );
    self.var_a4d2e235ef544e1e = gettime() + self.var_ef738a1b9d2df5ec;
    self.var_efb5487ff27de9aa = gettime() + self.var_432560390d1610f8 + randomint( self.var_432560390d1610f8 );
    self.specialattack = undefined;
    self function_786bb6aa1b76c7ee( "special_attack", 0 );
}

// Namespace ztron_papaback
// Params 1, eflags: 0x4
// Checksum 0x94db55d3, Offset: 0xbc0
// Size: 0x8c
function private function_c93b15aab5177d4c( target )
{
    if ( !isdefined( target ) )
    {
        return;
    }
    
    self endon( #"death", #"hash_5ca0a2786efd72b2" );
    target endon( #"death", #"disconnect" );
    
    while ( isdefined( target ) )
    {
        ang = vectortoangles( target.origin - self.origin );
        self rotateto( ( 0, ang[ 1 ], 0 ), 0.5 );
        self waittill( #"rotatedone" );
    }
}

// Namespace ztron_papaback
// Params 3
// Checksum 0x33a2f436, Offset: 0xc54
// Size: 0x2d, Type: bool
function function_cbc86771617a250b( asmname, statename, params )
{
    return self.specialattack == "jumpAttack";
}

// Namespace ztron_papaback
// Params 3
// Checksum 0x322f2f86, Offset: 0xc8a
// Size: 0x4e
function function_a8374033ecc71fec( asmname, statename, params )
{
    if ( function_cbc86771617a250b() )
    {
        if ( !self.jumpingattack )
        {
            thread function_5b3b4394ebea48a5();
        }
        
        return anim.running;
    }
    
    return anim.success;
}

// Namespace ztron_papaback
// Params 0, eflags: 0xc
// Checksum 0x6f136476, Offset: 0xce1
// Size: 0xb3
function private function_5b3b4394ebea48a5()
{
    self notify( #"hash_4d731d409729d451" );
    self endon( #"hash_4d731d409729d451" );
    self endon( #"death" );
    self function_786bb6aa1b76c7ee( "special_attack", 1 );
    self.boostorg.origin = self.origin;
    self.boostorg.angles = self.angles;
    self.boostattacks = randomintrange( 2, 4 );
    self.jumpingattack = 1;
    ztron_dialog::function_927bb94feca983e8( getxhash( "bubble_message_papaback" ) );
    waitframe();
    thread function_6f484f614b7348d7( self.boostorg, self.boostattacks );
}

// Namespace ztron_papaback
// Params 0, eflags: 0x4
// Checksum 0x67c261bf, Offset: 0xd9c
// Size: 0x110, Type: bool
function private function_f3b054d4d83cca6b()
{
    foreach ( papaback in level.ztron.papabacks )
    {
        if ( papaback.var_41f3634dadf29a0a )
        {
            return false;
        }
    }
    
    targetplatform = ztron_arena_silverback_arena::function_2ced03c47701383();
    var_312747fcf367afca = ztron_arena_silverback_arena::get_current_rotation_device();
    fuse = ztron_arena_silverback_arena::get_current_fuse();
    
    if ( isdefined( targetplatform ) && isdefined( var_312747fcf367afca ) && isdefined( fuse ) )
    {
        if ( fuse.ismoving || var_312747fcf367afca.ismoving )
        {
            return false;
        }
        
        if ( targetplatform.rotdone || targetplatform.var_3549aec585a41b8a )
        {
            return false;
        }
        
        return true;
    }
    
    return false;
}

// Namespace ztron_papaback
// Params 2, eflags: 0xc
// Checksum 0xc10eced2, Offset: 0xeb5
// Size: 0x33e
function private function_6f484f614b7348d7( boostorg, var_1c92e1e8e7469e6f = 1 )
{
    self notify( #"hash_abb801e3da0a5f3a" );
    self endon( #"hash_abb801e3da0a5f3a" );
    self endon( #"death" );
    var_557a6127cdab9873 = 0;
    namespace_4f6b9f859d8abc98::papabackshield( 1, 0 );
    self linkto( boostorg );
    waitframe();
    
    if ( self.rotationjump && function_f3b054d4d83cca6b() )
    {
        var_557a6127cdab9873 = randomint( 100 ) < 90;
    }
    
    /#
        if ( self.var_28ab931e2c6aab98 && !self.ztron.var_efb305d154bbb2e8 )
        {
            var_557a6127cdab9873 = 1;
        }
    #/
    
    if ( var_557a6127cdab9873 )
    {
        targetdevice = ztron_arena_silverback_arena::get_current_rotation_device();
        
        if ( targetdevice )
        {
            self.var_41f3634dadf29a0a = 1;
            targetpos = targetdevice.origin + ( -64, 0, 0 );
            markerpos = ztron_util::function_3fe38741460a4a49( targetdevice.origin );
            function_e0fb9c0058ee761c( boostorg, targetpos, 0, markerpos );
            wait 0.5;
            ang = vectortoangles( targetdevice.origin - self.origin );
            boostorg rotateto( ( 0, ang[ 1 ], 0 ), 0.5 );
            boostorg waittill( #"rotatedone" );
            rotationdevice = utility::spawn_model( "sat_zm_ztron_props_treasure_chest_small_02", targetdevice.origin + ( 0, 0, 2 ), targetdevice.angles ?? ( 0, 0, 0 ) );
            rotationdevice.targetdevice = targetdevice;
            rotationdevice thread function_fc810408347e52a2( self );
            wait 1;
            self.var_41f3634dadf29a0a = undefined;
        }
    }
    else
    {
        while ( var_1c92e1e8e7469e6f > 0 )
        {
            var_1c92e1e8e7469e6f--;
            targetpos = undefined;
            self.favoriteenemy = level.players.size > 0 ? level.players[ randomint( level.players.size ) ] : undefined;
            
            if ( isdefined( self.favoriteenemy ) && !isdefined( self.favoriteenemy.ztron.vehicle ) )
            {
                targetpos = self.favoriteenemy.origin;
            }
            else
            {
                targetpos = level.ztron.active_arena.safespots[ randomint( level.ztron.active_arena.safespots.size ) ].origin;
            }
            
            function_e0fb9c0058ee761c( boostorg, targetpos, 1 );
            thread function_6e287fbf4615ea9c( level.players.size + 1 );
            wait 1;
        }
    }
    
    self.jumpingattack = undefined;
    self unlink();
    namespace_4f6b9f859d8abc98::papabackshield( 0 );
    self.var_bd41719172c8ad13 = gettime() + self.var_41faafa177988527;
    self.var_efb5487ff27de9aa = gettime() + self.var_432560390d1610f8 + randomint( self.var_432560390d1610f8 );
    self.specialattack = undefined;
    self function_786bb6aa1b76c7ee( "special_attack", 0 );
}

// Namespace ztron_papaback
// Params 4, eflags: 0x4
// Checksum 0x4b9b7043, Offset: 0x11fb
// Size: 0x1e7
function private function_e0fb9c0058ee761c( boostorg, targetpos, grabparasites = 0, markerpos = undefined )
{
    self endon( #"death" );
    boostorg endon( #"death" );
    playfxontag( utility::getfx( "ztron_papaback_launch" ), self.fxmodel, "tag_origin" );
    playrumbleonposition( "zm_cannon_rumble", self.origin );
    markerorg = utility::spawn_model( "tag_origin", markerpos ?? targetpos );
    markerorg thread ztron_util::function_f7544bfa701db406( self );
    playfxontag( utility::getfx( "heavyZombie_land_hintMarker" ), markerorg, "tag_origin" );
    height = 500;
    timems = height / 1000 * 3000;
    boostorg.angles = self.angles;
    boostorg.origin = self.origin;
    boostorg thread function_c93b15aab5177d4c( self.favoriteenemy );
    
    if ( grabparasites )
    {
        thread function_37df85696b699e5a( boostorg, utility::function_6f5d2e1f1ff70482( timems / 2 ) );
    }
    
    ztron_sound::ztron_playsound( "papaback_jump_attack_OS", self.origin );
    boostorg function_1f0d8d844b8497c0( targetpos, timems, height );
    stopfxontag( utility::getfx( "heavyZombie_land_hintMarker" ), markerorg, "tag_origin" );
    markerorg delete();
    boostorg notify( #"hash_5ca0a2786efd72b2" );
    playfxontag( utility::getfx( "ztron_papaback_land" ), self.fxmodel, "tag_origin" );
    ztron_sound::ztron_playsound( "papaback_jump_attack_land_OS", self.origin );
    physicsexplosionsphere( self.origin, 200, 128, 2 );
    earthquake( 0.6, 0.75, self.origin, 200 );
}

// Namespace ztron_papaback
// Params 3
// Checksum 0x1af5309c, Offset: 0x13ea
// Size: 0xd0
function function_1f0d8d844b8497c0( targetpos, timems, height )
{
    self endon( #"death" );
    framecount = timems / 50;
    framefrac = 1 / framecount;
    frac = 0;
    targetpos = ztron_util::function_3fe38741460a4a49( targetpos );
    var_9273bee737c9de2a = utility::function_6f5d2e1f1ff70482( 50 );
    
    while ( frac < 1 )
    {
        neworigin = math::get_point_on_parabola( self.origin, targetpos, height, frac );
        self moveto( neworigin, var_9273bee737c9de2a );
        frac += framefrac;
        wait var_9273bee737c9de2a;
    }
    
    self moveto( targetpos, var_9273bee737c9de2a );
    self waittill( #"movedone" );
    self notify( #"move_completed" );
}

// Namespace ztron_papaback
// Params 2, eflags: 0x4
// Checksum 0xcc3414a7, Offset: 0x14c2
// Size: 0x19d
function private function_37df85696b699e5a( org, waittime )
{
    self endon( #"death" );
    org endon( #"death" );
    wait waittime;
    
    if ( !isdefined( org.parasites ) )
    {
        org.parasites = [];
    }
    
    parasitedef = ztron_enemy::function_96eea0d09d5640d1( "parasite" );
    
    for ( i = 0; i < level.players.size + 1 ; i++ )
    {
        targetplayer = level.players.size > 0 ? level.players[ randomint( level.players.size ) ] : undefined;
        enemy = ztron_enemy::function_acee91c445fafd29( parasitedef, org.origin, targetplayer, undefined, 1, 1 );
        enemy linkto( org );
        org.parasites[ org.parasites.size ] = enemy;
        org thread function_e35f34b2b812f1aa( enemy );
    }
    
    org waittill( #"move_completed" );
    
    foreach ( enemy in org.parasites )
    {
        if ( isdefined( enemy ) )
        {
            enemy unlink();
        }
    }
    
    org.parasites = [];
}

// Namespace ztron_papaback
// Params 1, eflags: 0x4
// Checksum 0xdfc05587, Offset: 0x1667
// Size: 0x3e
function private function_e35f34b2b812f1aa( enemy )
{
    self endon( #"death" );
    enemy waittill( #"death" );
    self.parasites = arrayremove( self.parasites, enemy );
}

// Namespace ztron_papaback
// Params 3
// Checksum 0xf3dd5d06, Offset: 0x16ad
// Size: 0x2d, Type: bool
function function_5cc5589ab2cfef81( asmname, statename, params )
{
    return self.specialattack == "throwAttack";
}

// Namespace ztron_papaback
// Params 3
// Checksum 0xc262a459, Offset: 0x16e3
// Size: 0x4e
function function_f28164b93d39aac8( asmname, statename, params )
{
    if ( function_5cc5589ab2cfef81() )
    {
        if ( !self.throwing )
        {
            thread function_fb4a1e20efb813f7();
        }
        
        return anim.running;
    }
    
    return anim.success;
}

// Namespace ztron_papaback
// Params 0, eflags: 0xc
// Checksum 0x64e48b4b, Offset: 0x173a
// Size: 0x26c
function private function_fb4a1e20efb813f7()
{
    self notify( #"hash_56eae1f6308221f3" );
    self endon( #"hash_56eae1f6308221f3" );
    self endon( #"death" );
    self.throwing = 1;
    bananamodel = "ee_food_fruit_banana_big_01";
    self.boostorg.origin = self.origin;
    self.boostorg.angles = self.angles;
    waitframe();
    self linkto( self.boostorg );
    waitframe();
    targetorg = undefined;
    self.favoriteenemy = level.players.size > 0 ? level.players[ randomint( level.players.size ) ] : undefined;
    
    if ( isdefined( self.favoriteenemy ) )
    {
        targetorg = self.favoriteenemy.origin;
    }
    else
    {
        targetorg = level.ztron.active_arena.safespots[ randomint( level.ztron.active_arena.safespots.size ) ].origin;
    }
    
    ang = vectortoangles( targetorg - self.origin );
    self.boostorg rotateto( ( 0, ang[ 1 ], 0 ), 0.5 );
    self.boostorg waittill( #"rotatedone" );
    self unlink();
    waitframe();
    self function_786bb6aa1b76c7ee( "throw", 1 );
    
    if ( level.ztron.var_dd451b5b7fad08ef.size <= 6 )
    {
        banana = utility::spawn_model( bananamodel, self.origin + ( 0, 0, 15 ) );
        
        if ( isdefined( banana ) )
        {
            banana enablelinkto();
            banana linkto( self, "j_wrist_ri" );
            banana thread function_d704f75b523ef77d( self, 1 );
        }
    }
    
    self waittill( #"banana_attack_done" );
    self.var_88ae5f3724191df9 = gettime() + self.var_4a67ce1a0cfcf16b;
    self.var_efb5487ff27de9aa = gettime() + self.var_432560390d1610f8 + randomint( self.var_432560390d1610f8 );
    self.specialattack = undefined;
    self.throwing = undefined;
    self function_786bb6aa1b76c7ee( "throw", 0 );
}

// Namespace ztron_papaback
// Params 3, eflags: 0x4
// Checksum 0xabcd5d04, Offset: 0x19ae
// Size: 0x2d5
function private function_d704f75b523ef77d( papaback, offhand, angles )
{
    level.ztron.var_dd451b5b7fad08ef[ level.ztron.var_dd451b5b7fad08ef.size ] = self;
    
    if ( offhand && isdefined( papaback.favoriteenemy ) )
    {
        targetvelocity = papaback.favoriteenemy getvelocity();
        targetpoint = papaback.favoriteenemy.origin + targetvelocity * 1.5;
        papaback utility::waittill_any_timeout( 2, "fire_banana", "death" );
        self unlink();
        waitframe();
        height = 120;
        timems = height / 1000 * 6000;
        thread function_1f0d8d844b8497c0( targetpoint, timems, height );
    }
    else
    {
        vel = 256;
        
        if ( !isdefined( angles ) )
        {
            angles = papaback.angles;
        }
        
        forward = anglestoforward( angles );
        targetpoint = papaback.origin + 128 * forward + ( randomfloatrange( -64, 64 ), randomfloatrange( -64, 64 ), 128 );
        dir = vectornormalize( targetpoint - papaback.origin );
        bananathrow = dir * vel;
        self solid();
        self physicslaunchserver( self.origin, bananathrow );
    }
    
    ztron_sound::ztron_playsound( "papaback_banana_attack_OS", undefined, self );
    wait 0.2;
    playfxontag( utility::getfx( "ztron_explosive_warning_light" ), self, "tag_origin" );
    wait 3;
    stopfxontag( utility::getfx( "ztron_explosive_warning_light" ), self, "tag_origin" );
    ztron_sound::ztron_playsound( "papaback_banana_explosion_OS", self.origin );
    waitframe();
    trigger = spawn( "trigger_radius", self.origin, 0, 128, 64 );
    trigger.fxent = utility::spawn_model( "tag_origin", trigger.origin );
    trigger.fxent thread ztron_util::function_f7544bfa701db406( trigger );
    level.ztron.var_dd451b5b7fad08ef = arrayremove( level.ztron.var_dd451b5b7fad08ef, self );
    thread ztron_util::deletemedelay( 0.1 );
    
    if ( isdefined( trigger ) )
    {
        playfxontag( utility::getfx( "ztron_papaback_banana_explo" ), trigger.fxent, "tag_origin" );
        trigger thread function_8b0d8dc5b892e984();
        
        /#
            trigger thread function_c437554e6f0c8787();
        #/
        
        trigger thread ztron_util::deletemedelay( 5.1 );
        wait 5;
        killfxontag( utility::getfx( "ztron_papaback_banana_explo" ), trigger.fxent, "tag_origin" );
    }
}

/#

    // Namespace ztron_papaback
    // Params 0
    // Checksum 0x2fa45ef4, Offset: 0x1c8b
    // Size: 0x45, Type: dev
    function function_c437554e6f0c8787()
    {
        self endon( #"death" );
        
        while ( true )
        {
            level thread ztron_debug::drawcylinder( self.origin, 128, 64, level.framedurationseconds, ( 1, 0, 0 ) );
            waitframe();
        }
    }

#/

// Namespace ztron_papaback
// Params 0
// Checksum 0x435cfc47, Offset: 0x1cd8
// Size: 0x7b
function function_8b0d8dc5b892e984()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"trigger", ent );
        
        if ( isplayer( ent ) )
        {
            if ( !isdefined( ent.var_2cf12cccb82a2df0 ) || gettime() > ent.var_2cf12cccb82a2df0 )
            {
                ent thread ztron_enemy_ai::function_bc65bed6aed12009( 5 );
                ent.var_2cf12cccb82a2df0 = gettime() + 1000;
            }
        }
    }
}

// Namespace ztron_papaback
// Params 1
// Checksum 0xe749df89, Offset: 0x1d5b
// Size: 0xa5
function function_fc810408347e52a2( papaback )
{
    self endon( #"death" );
    self setcandamage( 1 );
    self.health = 1000 + level.players.size * 2000;
    self.maxhealth = 1000 + level.players.size * 2000;
    self solid();
    self enableaimassist();
    self disconnectpaths();
    self.var_d62ad5bfd64ba592 = "tag_origin";
    self.var_63c94fe1b2260b34 = 1;
    self.var_36dfdbd7ab796f0f = 4;
    self.var_818c06f9a89fb0ba = 2;
    thread function_5c5ef1629e732cf();
    thread function_5366aab91d2bf684();
}

// Namespace ztron_papaback
// Params 0
// Checksum 0x1e5d2eaa, Offset: 0x1e08
// Size: 0x7e
function function_5c5ef1629e732cf()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, dir, point, meansofdeath );
        
        if ( isdefined( attacker ) && damage >= 0 )
        {
            mp_agent_damage::function_eb8ba16055d6da7c( attacker, self, "none", meansofdeath, undefined, damage, point, undefined, undefined, 0, 0 );
        }
    }
}

// Namespace ztron_papaback
// Params 0
// Checksum 0x7c330c7e, Offset: 0x1e8e
// Size: 0xa1
function function_2ffe28ca4b3af3f5()
{
    self notify( #"hash_ae82606fd3af7dfc" );
    self endon( #"hash_ae82606fd3af7dfc" );
    self endon( #"death" );
    
    while ( true )
    {
        targetplatform = ztron_arena_silverback_arena::function_2ced03c47701383();
        
        if ( !isdefined( targetplatform ) )
        {
            break;
        }
        
        msg = targetplatform utility::waittill_any_timeout( 0.1, "rotatedoen" );
        
        if ( msg == "timeout" && targetplatform.rotdone )
        {
            break;
        }
    }
    
    wait 0.5;
    self dodamage( self.maxhealth, self.origin );
}

// Namespace ztron_papaback
// Params 0
// Checksum 0xe5b4cec1, Offset: 0x1f37
// Size: 0x6f
function function_5366aab91d2bf684()
{
    self notify( #"hash_186ad8725e8e4b6a" );
    self endon( #"hash_186ad8725e8e4b6a" );
    thread function_2ffe28ca4b3af3f5();
    self waittill( #"death" );
    self setcandamage( 0 );
    playfx( utility::getfx( "ztron_explode_red_barrel" ), self.origin );
    ztron_sound::ztron_playsound( "device_banana_explo", self.origin );
    thread ztron_util::deletemedelay( 0.1 );
}

// Namespace ztron_papaback
// Params 1
// Checksum 0xbb6de31b, Offset: 0x1fae
// Size: 0x86
function function_6e287fbf4615ea9c( numattack )
{
    self endon( #"death" );
    bananaangles = self.angles;
    increment = ( 0, 360 / ( numattack + 1 ), 80 );
    
    while ( numattack )
    {
        banana = utility::spawn_model( "ee_food_fruit_banana_big_01", self.origin );
        
        if ( isdefined( banana ) )
        {
            banana thread function_d704f75b523ef77d( self, undefined, bananaangles );
            bananaangles += increment;
        }
        
        numattack--;
    }
}

// Namespace ztron_papaback
// Params 3
// Checksum 0x23aba6f9, Offset: 0x203c
// Size: 0x2d, Type: bool
function function_a31a91e983819253( asmname, statename, params )
{
    return self.specialattack == "pipeAttack";
}

// Namespace ztron_papaback
// Params 3
// Checksum 0xb5ed9b31, Offset: 0x2072
// Size: 0x4e
function function_9a720369a72966a4( asmname, statename, params )
{
    if ( function_a31a91e983819253() )
    {
        if ( !self.throwingpipe )
        {
            thread function_714836095a464851();
        }
        
        return anim.running;
    }
    
    return anim.success;
}

// Namespace ztron_papaback
// Params 0, eflags: 0x4
// Checksum 0x9c823728, Offset: 0x20c9
// Size: 0x175
function private function_714836095a464851()
{
    self endon( #"death" );
    self.throwingpipe = 1;
    self function_786bb6aa1b76c7ee( "throw", 1 );
    smokingpipe = utility::spawn_model( "ztron_c_rus_simianaut_smokingpipe", self.origin + ( 0, 0, 15 ) );
    
    if ( isdefined( smokingpipe ) )
    {
        orgfx = utility::spawn_model( "tag_origin", smokingpipe.origin, smokingpipe.angles );
        orgfx linkto( smokingpipe );
        orgfx thread ztron_util::function_f7544bfa701db406( smokingpipe );
        self.smokingpipe = smokingpipe;
        smokingpipe.fxmodel = orgfx;
        smokingpipe enablelinkto();
        smokingpipe linkto( self, "j_wrist_ri" );
        smokingpipe thread function_eb178a332099b9bc( self );
    }
    
    ztron_sound::ztron_playsound( "papaback_pipe_attack_LP", undefined, smokingpipe );
    self waittill( #"banana_attack_done" );
    self function_786bb6aa1b76c7ee( "throw", 0 );
    self setbtgoalstationary( 1 );
    utility::waittill_any_timeout( 2.5, "pipe_boomerang_done" );
    ztron_sound::ztron_stoploopsound( "papaback_pipe_attack_LP", smokingpipe );
    self clearbtgoal( 1 );
    self.var_b21f63aa5c4e7a2b = gettime() + self.var_2f91579ea953823f;
    self.var_efb5487ff27de9aa = gettime() + self.var_432560390d1610f8 + randomint( self.var_432560390d1610f8 );
    self.specialattack = undefined;
    self.throwingpipe = undefined;
}

// Namespace ztron_papaback
// Params 1, eflags: 0x4
// Checksum 0x5f2d2b12, Offset: 0x2246
// Size: 0x10d
function private function_eb178a332099b9bc( papaback )
{
    papaback endon( #"death" );
    papaback utility::waittill_any_timeout( 2, "fire_banana", "death" );
    self unlink();
    playfxontag( utility::getfx( papaback.boostfx ), self.fxmodel, "tag_origin" );
    waitframe();
    self notsolid();
    trigger = spawn( "trigger_radius", self.origin, 0, 32, 32 );
    
    if ( isdefined( trigger ) )
    {
        trigger.owner = papaback;
        trigger enablelinkto();
        trigger linkto( self );
        trigger thread function_ad71d3632dce589( papaback );
    }
    
    function_41bcce94bf6617ed( papaback );
    papaback notify( #"pipe_boomerang_done" );
    trigger delete();
    stopfxontag( utility::getfx( papaback.boostfx ), self.fxmodel, "tag_origin" );
    thread ztron_util::deletemedelay( 0.1 );
    wait 0.1;
    papaback.smokingpipe = undefined;
}

// Namespace ztron_papaback
// Params 1
// Checksum 0x3e67bdb4, Offset: 0x235b
// Size: 0x97
function function_ad71d3632dce589( papaback )
{
    papaback endon( #"death" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"trigger", ent );
        
        if ( isplayer( ent ) )
        {
            ent dodamage( ent.health, self.origin, self.owner, self.owner );
        }
        
        if ( isai( ent ) )
        {
            ent zombie_knockdown::function_6fc167d4a3590991( self.origin );
        }
    }
}

// Namespace ztron_papaback
// Params 2, eflags: 0x4
// Checksum 0xf55d03b5, Offset: 0x23fa
// Size: 0x12a
function private function_41bcce94bf6617ed( papaback, timems = 2000 )
{
    self endon( #"death" );
    papaback endon( #"death" );
    framecount = timems / 50;
    framefrac = 1 / framecount;
    frac = 0;
    var_28dbfb632fde2236 = utility::function_6f5d2e1f1ff70482( 50 );
    dist = randomintrange( 200, 400 );
    r = randomintrange( int( dist / 2 ), dist );
    
    while ( frac < 1 )
    {
        neworigin = function_ca6bd65ce9dc648c( papaback.origin, papaback.angles, dist, r, frac );
        self moveto( neworigin, var_28dbfb632fde2236 );
        self rotateto( self.angles + ( 0, 90, 0 ), var_28dbfb632fde2236 );
        frac += framefrac;
        wait var_28dbfb632fde2236;
    }
    
    self moveto( papaback gettagorigin( "j_wrist_ri" ), var_28dbfb632fde2236 );
    self waittill( #"movedone" );
}

// Namespace ztron_papaback
// Params 5, eflags: 0x4
// Checksum 0x6d18550d, Offset: 0x252c
// Size: 0xab
function private function_ca6bd65ce9dc648c( origin, angles, dist, r, frac )
{
    t = frac * 180;
    var_61b21206194adae6 = dist * pow( sin( t ), 2 );
    var_8dca6228556a2a93 = dist * dist / r * pow( sin( t ) * -1, 3 ) * cos( t );
    offsetorigin = ( var_61b21206194adae6, var_8dca6228556a2a93, origin[ 2 ] + 32 );
    neworigin = coordtransform( offsetorigin, origin, angles );
    return neworigin;
}

// Namespace ztron_papaback
// Params 3
// Checksum 0x89564ab7, Offset: 0x25e0
// Size: 0x2d, Type: bool
function function_3331ccc5293e1eaa( asmname, statename, params )
{
    return self.specialattack == "shootAttack";
}

// Namespace ztron_papaback
// Params 3
// Checksum 0x72bd50cb, Offset: 0x2616
// Size: 0x4e
function function_8a4301fbfd40670b( asmname, statename, params )
{
    if ( function_3331ccc5293e1eaa() )
    {
        if ( !self.raygunshooting )
        {
            thread function_6f92a7ff9437215c();
        }
        
        return anim.running;
    }
    
    return anim.success;
}

// Namespace ztron_papaback
// Params 0
// Checksum 0xe0158d4a, Offset: 0x266d
// Size: 0x122
function function_6f92a7ff9437215c()
{
    self endon( #"death" );
    targetplayer = sortbydistance( level.players, self.origin, 1 )[ 0 ];
    
    if ( distance( targetplayer.origin, self.origin ) < 172 )
    {
        self.specialattack = undefined;
        return;
    }
    
    self.raygunshooting = 1;
    self.weapon = self.raygunweap;
    self function_786bb6aa1b76c7ee( "shoot_fire", 1 );
    shared::forceuseweapon( self.weapon, "primary" );
    self waittill( #"shoot_done" );
    shared::detachweapon( self.weapon );
    self.weapon = nullweapon();
    self.var_270ad82a180377e6 = gettime() + self.var_92e1101ef3a515a8;
    self.var_efb5487ff27de9aa = gettime() + self.var_432560390d1610f8 + randomint( self.var_432560390d1610f8 );
    self.specialattack = undefined;
    self.raygunshooting = undefined;
    self function_786bb6aa1b76c7ee( "shoot_fire", 0 );
}

// Namespace ztron_papaback
// Params 3
// Checksum 0xc813efd4, Offset: 0x2797
// Size: 0x28, Type: bool
function function_adbdc32de4c000f4( asmname, statename, params )
{
    return istrue( self.gatheritems );
}

// Namespace ztron_papaback
// Params 3
// Checksum 0x276d4b67, Offset: 0x27c8
// Size: 0x4e
function function_d70e90507121abe0( asmname, statename, params )
{
    if ( function_adbdc32de4c000f4() )
    {
        if ( !self.gathering )
        {
            thread function_e4528a2c51228e66();
        }
        
        return anim.running;
    }
    
    return anim.success;
}

// Namespace ztron_papaback
// Params 0, eflags: 0x4
// Checksum 0xee611919, Offset: 0x281f
// Size: 0x2eb
function private function_e4528a2c51228e66()
{
    if ( self.stfu )
    {
        return;
    }
    
    self endon( #"death" );
    thread function_b4b58982a66b1358();
    self.gathering = 1;
    currenttarget = undefined;
    
    if ( level.ztron.itemdef.spawneditems.size > 0 )
    {
        ztron_dialog::function_7e3f6329d9afcdc1( getxhash( "textbubble_papaback_3" ) );
    }
    
    if ( self.stfu )
    {
        return;
    }
    
    while ( level.ztron.itemdef.spawneditems.size > 0 )
    {
        currenttarget = undefined;
        pickups = sortbydistance( level.ztron.itemdef.spawneditems, self.origin );
        
        foreach ( pickup in pickups )
        {
            if ( pickup.papabackignore || pickup.inuse )
            {
                continue;
            }
            
            currenttarget = pickup;
            break;
        }
        
        if ( !isdefined( currenttarget ) )
        {
            self notify( #"gather_completed" );
            level notify( #"gather_completed" );
            self.ignoreall = 0;
            self.goto_position = undefined;
            self.gatheritems = undefined;
            return;
        }
        
        pos = ztron_util::function_3fe38741460a4a49( currenttarget.origin );
        function_c2dcc40c67205012( pos );
        
        /#
            if ( getdvarint( @"hash_c9938cd1dfa0e8b8", 0 ) != 0 )
            {
                thread function_81843e1da85d6ab2( currenttarget.origin );
            }
        #/
        
        if ( isdefined( currenttarget ) && !currenttarget.pickedup )
        {
            lastorigin = self.origin;
            msg = utility::waittill_any_timeout( 5, "near_goal" );
            
            if ( msg == "near_goal" )
            {
                if ( isdefined( currenttarget ) )
                {
                    level thread ztron_item::clearitem( currenttarget );
                    continue;
                }
            }
            
            if ( msg == "timeout" || isdefined( self.goto_position ) && distancesquared( self.goto_position, self.origin ) > squared( 12 ) && distancesquared( lastorigin, self.origin ) < squared( 8 ) )
            {
                if ( isdefined( currenttarget ) )
                {
                    currenttarget.papabackignore = 1;
                }
            }
        }
    }
    
    self notify( #"gather_completed" );
    level notify( #"gather_completed" );
    self.ignoreall = 0;
    self.goto_position = undefined;
    self.gathering = undefined;
}

// Namespace ztron_papaback
// Params 0, eflags: 0xc
// Checksum 0xc5120bb5, Offset: 0x2b12
// Size: 0x3e
function private function_b4b58982a66b1358()
{
    self notify( #"hash_8d85097d8e2356a4" );
    self endon( #"hash_8d85097d8e2356a4" );
    self endon( #"death", #"gather_completed" );
    wait 10;
    papabacksetspeed( "sprint" );
}

// Namespace ztron_papaback
// Params 3
// Checksum 0x4750a7ff, Offset: 0x2b58
// Size: 0x46
function function_8f8d0aa7fe89b950( asmname, statename, params )
{
    self.nexttaunt = gettime() + self.tauntcooldown + randomint( 6000 );
    asm::asm_setstate( asmname );
}

// Namespace ztron_papaback
// Params 1
// Checksum 0x5e2c6736, Offset: 0x2ba6
// Size: 0xad
function papabacksetspeed( rate = "run" )
{
    if ( rate == "next" )
    {
        switch ( self.var_361a087ab08adc1c )
        {
            case #"hash_bdea5e7441323370":
                rate = "run";
            case #"hash_9710f96c58beeaaa":
                rate = "sprint";
            case #"hash_eb06fed69a41dab5":
                rate = "super_sprint";
            default:
                break;
        }
    }
    
    self.var_11d7d50fb07ef00b = self.var_361a087ab08adc1c;
    self.var_361a087ab08adc1c = rate;
    zombie_utils::function_a8ce00e0448cb6f0( self.var_361a087ab08adc1c, "ztron", 4 );
}

// Namespace ztron_papaback
// Params 1
// Checksum 0x37c767ef, Offset: 0x2c5b
// Size: 0x3c
function function_c2dcc40c67205012( position )
{
    self.goto_position = getclosestpointonnavmesh( position );
    
    if ( !isdefined( self.goto_position ) )
    {
        self.goto_position = position;
    }
    
    /#
        thread function_df51d11c1f29dbcb();
    #/
}

/#

    // Namespace ztron_papaback
    // Params 0, eflags: 0x4
    // Checksum 0x3ccbf2c8, Offset: 0x2c9f
    // Size: 0x52, Type: dev
    function private function_df51d11c1f29dbcb()
    {
        self endon( #"death" );
        self endon( #"gather_completed" );
        
        while ( isdefined( self.goto_position ) )
        {
            utility::draw_circle( self.goto_position, 20, ( 0, 1, 0 ), 0.8 );
            waitframe();
        }
    }

    // Namespace ztron_papaback
    // Params 1, eflags: 0x4
    // Checksum 0xf41bdfb4, Offset: 0x2cf9
    // Size: 0x8d, Type: dev
    function private function_81843e1da85d6ab2( origin )
    {
        self endon( #"death" );
        self endon( #"gather_completed" );
        
        while ( self.gatheritems )
        {
            utility::draw_circle( origin + ( 0, 0, 20 ), 30, ( 1, 0, 0 ), 0.6 );
            line( self.origin + ( 0, 0, 20 ), origin + ( 0, 0, 20 ) );
        }
    }

#/
