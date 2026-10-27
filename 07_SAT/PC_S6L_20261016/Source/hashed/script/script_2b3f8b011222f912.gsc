// script_2b3f8b011222f912  (hash_2b3f8b011222f912.gscc) (size: 26987 Bytes / 0x696b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6410fc49 (1678834761)
// size ...... 26987 (0x696b)
// includes .. 27  (offset: 0x6153)
// strings ... 131 (offset: 0x622b)
// dev strs .. 0   (offset: 0x696b)
// exports ... 66  (offset: 0x3d4b)
// cseg ...... 0xb00 + 0x324b (0x3d4b)
// imports ... 198 (offset: 0x479b)
// animtree1 . 0   (offset: 0x696b)
// animtree2 . 0   (offset: 0x696b)
#using script_35a342a0af11a9c1;
#using script_aa3bac81ad4fc8e;
#using script_cc7edad3d14d7bf;
#using scripts\asm\asm;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_base\zombie_base_dismemberment;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\common\utility\player;
#using scripts\mp\zm\spawners\agent_spawner;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_debug;
#using scripts\mp\zm\ztron\ztron_enemy;
#using scripts\mp\zm\ztron\ztron_enemy_ai;
#using scripts\mp\zm\ztron\ztron_main;
#using scripts\mp\zm\ztron\ztron_meta_progression;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;
#using scripts\mp\zm\ztron\ztron_vfx;

#namespace ztron_ai_zombie;

// Namespace ztron_ai_zombie
// Params 0, eflags: 0x5
// Checksum 0x9e930e96, Offset: 0xb1e
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"ztron_ai_zombie", undefined, &pre_main, undefined );
}

// Namespace ztron_ai_zombie
// Params 0
// Checksum 0xb64db43d, Offset: 0xb3f
// Size: 0x2
function pre_main()
{
    
}

// Namespace ztron_ai_zombie
// Params 0
// Checksum 0x1823a138, Offset: 0xb49
// Size: 0x493
function init()
{
    init_ai_zombie_global();
    ztron_enemy::function_6126d573e5775143( "zombie_base", "basic_zombie", &function_719fc9881a7b7e18, &ztron_enemy_ai::function_9a34c1b86e0eec7c, &ztron_enemy_ai::function_6f58a8788ecd236d, undefined, undefined, undefined, undefined, undefined, 0 );
    ztron_enemy::function_6126d573e5775143( "zombie_base_armored_light", "light_armored_zombie", &function_9d029599b8e986e8, &ztron_enemy_ai::function_9a34c1b86e0eec7c, &ztron_enemy_ai::function_6f58a8788ecd236d, 6, 9, 0, 3, 8, 15 );
    ztron_enemy::function_6126d573e5775143( "zombie_base", "barreler_zombie", &function_61f506a80d58beb9, &ztron_enemy_ai::function_9a34c1b86e0eec7c, &ztron_enemy_ai::function_6f58a8788ecd236d, 9, 5, 0, 1, 8, 20 );
    ztron_enemy::function_6126d573e5775143( "zombie_shade", "ravager", &function_d304f51698597e03, &ztron_enemy_ai::function_9a34c1b86e0eec7c, &ztron_enemy_ai::function_6f58a8788ecd236d, 13, 5, 0, 3, 8, 30 );
    ztron_enemy::function_6126d573e5775143( "zombie_base", "riser_zombie", &function_b5a5e290ccc1050b, &ztron_enemy_ai::function_9a34c1b86e0eec7c, &ztron_enemy_ai::function_6f58a8788ecd236d, 17, 9, 0, 3, 8, 10 );
    ztron_enemy::function_6126d573e5775143( "zombie_hellhound", "hellhound", &function_a6732c4a2e1eb721, &ztron_enemy_ai::function_9a34c1b86e0eec7c, &ztron_enemy_ai::function_6f58a8788ecd236d, 21, 2, 0, 3, 8, 30 );
    ztron_enemy::function_6126d573e5775143( "zombie_vermin", "vermin", &function_70fb9f7c269184c1, &ztron_enemy_ai::function_9a34c1b86e0eec7c, &ztron_enemy_ai::function_6f58a8788ecd236d, 25, 3, 0, 7, 15, 10 );
    def = ztron_enemy::function_6126d573e5775143( "zombie_disciple", "disciple", &function_568540eec156b4c9, &ztron_enemy_ai::function_9a34c1b86e0eec7c, &ztron_enemy_ai::function_6f58a8788ecd236d, 29, 2 );
    def.var_6a1cedaf05dbaf69 = 5;
    ztron_enemy::function_6126d573e5775143( "zombie_parasite", "parasite", &function_76148e3ec1fa3f4f, &ztron_enemy_ai::function_9a34c1b86e0eec7c, &ztron_enemy_ai::function_6f58a8788ecd236d, 33, 3, 0, 4, 12 );
    ztron_enemy::function_6126d573e5775143( "zombie_ghoul", "ghoul", &function_52a5c0ecad004327, &ztron_enemy_ai::function_9a34c1b86e0eec7c, &ztron_enemy_ai::function_6f58a8788ecd236d, 37, 3, 0, 1, 3 );
    ztron_enemy::function_6126d573e5775143( "zombie_base_armored_heavy", "heavy_armored_zombie", &function_44f5ef46e7529089, &ztron_enemy_ai::function_9a34c1b86e0eec7c, &ztron_enemy_ai::function_6f58a8788ecd236d, 41, 3, 0, 8, 15 );
    ztron_enemy::function_6126d573e5775143( "zombie_amalgam", "amalgam", &function_75278ef669dc60a4, &ztron_enemy_ai::function_9a34c1b86e0eec7c, &ztron_enemy_ai::function_6f58a8788ecd236d, 45, 1, 0, 1, 3 );
    ztron_enemy::function_6126d573e5775143( "zombie_mangler", "mangler", &function_13c7e11f982c69fe, &ztron_enemy_ai::function_9a34c1b86e0eec7c, &ztron_enemy_ai::function_6f58a8788ecd236d, 49, 1, 0, 1, 4 );
    def = ztron_enemy::function_6126d573e5775143( "zombie_mimic", "mimic", &function_44da85f13c2baf7b, &ztron_enemy_ai::function_9a34c1b86e0eec7c, &ztron_enemy_ai::function_6f58a8788ecd236d, 53, 1, 0, 1, 4 );
    def.maxaicount = 4;
    def.var_2a315804ad341a0d = 1;
    ztron_enemy::function_6126d573e5775143( "zombie_mannequin", "mannequin", &function_b686fd366ef21a0e, &function_454eac4b00457e0c, &ztron_enemy_ai::function_6f58a8788ecd236d, 57, 1, 0, 4, 10 );
    ztron_enemy::function_6126d573e5775143( "zombie_base", "pole_zombie", &function_a2f230d3a9211d64, &function_27cf5d6bb45a1ece, &function_de98384230be1da7, 61, 1, 0, 3, 7, 300 );
    def = ztron_enemy::function_6126d573e5775143( "zombie_disciple_skoll", "elder_disciple", &function_1e29a102529eed3d, &ztron_enemy_ai::function_9a34c1b86e0eec7c, &ztron_enemy_ai::function_6f58a8788ecd236d, 65, 1 );
    def.var_6a1cedaf05dbaf69 = 5;
    ztron_enemy::function_6126d573e5775143( "zombie_base_toxic", "toxic", &function_a879c86daded2e1d, &ztron_enemy_ai::function_9a34c1b86e0eec7c, &ztron_enemy_ai::function_6f58a8788ecd236d, 69, 3, 0, 4, 10 );
    def = ztron_enemy::function_6126d573e5775143( "zombie_abom", "abomination", &function_bc328031d27ead01, &ztron_enemy_ai::function_9a34c1b86e0eec7c, &ztron_enemy_ai::function_6f58a8788ecd236d, 73, 1, 1, undefined, undefined, 300 );
    def.var_6a1cedaf05dbaf69 = 3;
    def.maxaicount = 3;
    def.var_2a315804ad341a0d = 0;
    def.var_9c9bebd72fa2dbe9 = 6;
    def = ztron_enemy::function_6126d573e5775143( "zombie_mangler_hvt", "mangler_hvt", &function_80f7573034231728, &ztron_enemy_ai::function_9a34c1b86e0eec7c, &ztron_enemy_ai::function_c0e03abd31b91d3c, 77, 1, 1, undefined, undefined, 300 );
    def.var_6a1cedaf05dbaf69 = 3;
    ztron_enemy::function_6126d573e5775143( "zombie_base_abom_crawler", "abom_crawler", &function_34f9ccd15b0e5283, &ztron_enemy_ai::function_9a34c1b86e0eec7c, &ztron_enemy_ai::function_6f58a8788ecd236d, -1, -1 );
    ztron_enemy::function_6126d573e5775143( "zombie_abom_mega", "mega_abom", &function_d123b38f04c5363, &ztron_enemy_ai::function_9a34c1b86e0eec7c, &ztron_enemy_ai::function_6f58a8788ecd236d, -1, -1, 1 );
    ztron_enemy::function_6126d573e5775143( "zombie_triton", "golem", &function_d95a9e71efacd0c4, &tritonthink, &ztron_enemy_ai::function_c0e03abd31b91d3c, -1, -1, 1 );
    ztron_enemy::function_6126d573e5775143( "zombie_phobos", "Z-Rex", &function_279d06bc2fe85be1, &phobosthink, &ztron_enemy_ai::function_c0e03abd31b91d3c, -1, -1, 1 );
    ztron_enemy::function_6126d573e5775143( "zombie_callisto", "zursa", &function_8f6de6178e8b2b67, &ztron_enemy_ai::function_9a34c1b86e0eec7c, &ztron_enemy_ai::function_c0e03abd31b91d3c, -1, -1, 1 );
    level thread function_ca2fd8a06fde081a();
}

// Namespace ztron_ai_zombie
// Params 0
// Checksum 0x8f036dbe, Offset: 0xfe4
// Size: 0x1e5
function init_ai_zombie_global()
{
    burnbundle = spawnstruct();
    burnbundle.var_c3f25b11c2247a29 = 40;
    burnbundle.var_78880e1476d45684 = 50;
    burnbundle.var_7ceb375188b38c13 = 30;
    burnbundle.var_29dd3c8b7a515774 = 0.2;
    burnbundle.var_17b6db336154419b = 3;
    burnbundle.flamemaxduration = 3.5;
    burnbundle.nonavobstacle = 1;
    burnbundle.friendlyfireexception = 1;
    level.var_3e74032bbe4a375f = burnbundle;
    level.var_15ce4166f92c5163 = 1;
    level.var_7035193e00b67ef0 = 1;
    ztron_sound::function_4ac735395b173fe( "heavyZombie_land", "zmb_ai_land_heavy" );
    ztron_sound::function_4ac735395b173fe( "device_banana_explo", "evt_ztron_hazard_redbarrel_explosion" );
    ztron_sound::function_4ac735395b173fe( "papaback_boost_attack_OS", "zmb_ztron_ai_silverback_boost" );
    ztron_sound::function_4ac735395b173fe( "papaback_jump_attack_OS", "zmb_ztron_ai_silverback_jump_takeoff" );
    ztron_sound::function_4ac735395b173fe( "papaback_jump_attack_land_OS", "zmb_ztron_ai_silverback_jump_land" );
    ztron_sound::function_4ac735395b173fe( "papaback_banana_attack_OS", "zmb_ztron_ai_silverback_banana_start" );
    ztron_sound::function_4ac735395b173fe( "papaback_banana_explosion_OS", "zmb_ztron_ai_silverback_banana_explo" );
    ztron_sound::function_4ac735395b173fe( "papaback_pipe_attack_LP", "zmb_ztron_ai_silverback_pipe_thrown_lp", 1 );
    level callback::add( "on_zombie_phobos_spawn_empowered", &function_5164e6fac07fa9d );
    level callback::add( "on_zombie_phobos_spawn_roared", &function_5164e6fac07fa9d );
    level callback::add( "on_zombie_phobos_spawn_parasite", &function_5164e6fac07fa9d );
    level callback::add( "on_disciple_summon_spawned", &function_5164e6fac07fa9d );
    level callback::add( "setup_revealed_ai", &function_5164e6fac07fa9d );
    level callback::add( "on_abom_crawler_spawned", &function_5164e6fac07fa9d );
    utility::registersharedfunc( #"zombie_phobos", #"manage_legs", &function_6cee3d514db310ab );
    utility::registersharedfunc( #"disciple", #"hash_ddbc0720466b1c3e", &function_7d204eebc1d38ce3 );
    thread function_e59bb5afd20ecbc5();
}

// Namespace ztron_ai_zombie
// Params 0
// Checksum 0x1216c30, Offset: 0x11d1
// Size: 0x38
function function_e59bb5afd20ecbc5()
{
    wait 1;
    function_da5d03c98bdf2ecb();
    level callback::remove( "disciple_check_passive_spawn_location", #"all" );
    level callback::remove( "on_entity_hidden_in_prop", #"all" );
}

// Namespace ztron_ai_zombie
// Params 0
// Checksum 0xfa291590, Offset: 0x1211
// Size: 0x27
function function_da5d03c98bdf2ecb()
{
    utility::add_fx( "amalgam_death_ground_fx", "vfx_t10_gameplay_zm_ai_zai_amalgam_death_ch_ztron" );
    level.var_b9bef0125ff74d0 = utility::getfx( "ztron_hazard_electric_trap_active" );
}

// Namespace ztron_ai_zombie
// Params 4
// Checksum 0x1edaa69a, Offset: 0x1240
// Size: 0xf8
function function_8c6501764cf8eda3( pointvalue, forcespeed, antikite = 1, initmelee = 1 )
{
    ztron_enemy_ai::function_3ae4286f85e2ef9e();
    
    if ( initmelee )
    {
        ztron_enemy_ai::function_4e106850bd9eef1a();
    }
    
    self.pointvalue = pointvalue;
    self.oldgrenadeweapon = self.grenadeweapon;
    self.grenadeweapon = level.weaponnone;
    agent_utils::function_e6724888010b2003();
    
    if ( isdefined( forcespeed ) )
    {
        self.var_361a087ab08adc1c = level.ztron.var_a593aa94dc733518 ?? forcespeed;
        self.forcespeed = 1;
    }
    
    if ( self.ztron.var_ae555ddb6e30a0b0 && ztron_main::function_4da200e9b8d58a3c() == 1 && antikite )
    {
        thread function_70318318601711cb();
    }
    
    thread function_246e9a1e58dcf9c();
    self setperk( "specialty_radarblip", 1 );
}

// Namespace ztron_ai_zombie
// Params 0
// Checksum 0xe1e11829, Offset: 0x1340
// Size: 0x46
function function_719fc9881a7b7e18()
{
    self.ztron.var_ae555ddb6e30a0b0 = 1;
    function_8c6501764cf8eda3( 100 );
    val::set( "zombie_init", "allow_unreachable_attack", 0 );
    self notify( #"hash_380b82d19d8f6233" );
    thread function_9381bb283619f81f();
}

// Namespace ztron_ai_zombie
// Params 1
// Checksum 0xc7d0c19f, Offset: 0x138e
// Size: 0x55
function zombie_sethealth( newhealth )
{
    var_2ca5e6af223d12de = namespace_4f98d1d7dc3196d::function_de5c10056990b7da( "diseaseInflictor" );
    newhealth = int( newhealth * ( 1 - 0.04 * var_2ca5e6af223d12de ) );
    ai::set_ai_max_health( newhealth );
    self.health = self.maxhealth;
}

// Namespace ztron_ai_zombie
// Params 0
// Checksum 0xa340bbdd, Offset: 0x13eb
// Size: 0x1fe
function function_b5a5e290ccc1050b()
{
    function_8c6501764cf8eda3( 100 );
    self.spawnloc = undefined;
    val::set( "zombie_init", "allow_unreachable_attack", 0 );
    
    if ( isdefined( level.ztron.var_cbfc78346d18c0a0 ) )
    {
        self.spawnloc = [[ level.ztron.var_cbfc78346d18c0a0 ]]();
    }
    
    if ( !isdefined( self.spawnloc ) && ztron_main::function_4da200e9b8d58a3c() == 1 && isdefined( level.ztron.active_arena.safespots ) )
    {
        closetplayer = ztron_player_utility::function_55e798aacb02a82f( self.origin );
        targetloc = level.ztron.active_arena.safespots[ randomint( level.ztron.active_arena.safespots.size ) ].origin;
        
        if ( isdefined( closetplayer ) && isdefined( closetplayer.origin ) )
        {
            targetloc = ztron_util::function_78a5b128a3e32460( closetplayer.origin, 256, 128 );
        }
        
        targetloc = ztron_util::function_3fe38741460a4a49( targetloc, 80 );
        targetang = ( 0, randomint( 360 ), 0 );
    }
    
    if ( !isdefined( self.spawnloc ) )
    {
        self.spawnloc = spawnstruct();
        self.spawnloc.origin = targetloc ?? self.origin;
        self.spawnloc.angles = targetang ?? self.angles;
        self.var_ad3261b44a7138d2 = 1;
    }
    
    if ( !isdefined( self.spawnloc.script_animation ) )
    {
        self.spawnloc.script_animation = "spawn";
    }
    
    thread agent_spawner::function_ce10e453e7f7bb8e( self.spawnloc );
}

// Namespace ztron_ai_zombie
// Params 0
// Checksum 0x9f403207, Offset: 0x15f1
// Size: 0x17
function function_d304f51698597e03()
{
    function_8c6501764cf8eda3( 100, undefined, 0, 0 );
    zombie_sethealth( 65 );
}

// Namespace ztron_ai_zombie
// Params 0
// Checksum 0xf7fe6dbb, Offset: 0x1610
// Size: 0xd
function function_34f9ccd15b0e5283()
{
    function_8c6501764cf8eda3( 100, undefined, 0 );
}

// Namespace ztron_ai_zombie
// Params 0
// Checksum 0x4bfaa429, Offset: 0x1625
// Size: 0x78
function function_d123b38f04c5363()
{
    ztron_enemy_ai::function_3ae4286f85e2ef9e();
    ztron_enemy_ai::function_40fd300070feec7c( 1000 );
    zombie_sethealth( getdvarint( @"hash_a7a093199b59d7ad", 50000 ) + ( level.players.size - 1 ) * 6000 + level.ztron.game_laps * getdvarint( @"hash_a7a093199b59d7ad", 50000 ) );
    self.var_cef5832c47f5e009 = 1;
    self.var_ef590d4074c114 = 5000;
}

// Namespace ztron_ai_zombie
// Params 0
// Checksum 0x9760054, Offset: 0x16a5
// Size: 0xcc
function function_75278ef669dc60a4()
{
    function_8c6501764cf8eda3( 350, undefined, 0 );
    ztron_enemy_ai::function_4e106850bd9eef1a( level.ztron.var_2a2d12c87e88af98, level.ztron.var_3172b140ef7aaae3, level.ztron.var_3bb2add1378575fa, level.ztron.var_7026573ca277eb95 );
    self.disallow_knockdown = 1;
    zombie_sethealth( self.maxhealth + 5000 );
    thread function_c9a4cf2708e442b6();
    self.ztron.elite = 1;
    self.aicategory = "elite";
    self.var_8da6b6c99fa544f5 = 1;
    self.var_ec1bfc54caa257ab = 1;
    self.var_840153567385cc6b = 1;
}

// Namespace ztron_ai_zombie
// Params 0
// Checksum 0x1ac27634, Offset: 0x1779
// Size: 0x1e
function function_9d029599b8e986e8()
{
    function_8c6501764cf8eda3( 100 );
    zombie_sethealth( self.maxhealth + 250 );
}

// Namespace ztron_ai_zombie
// Params 0
// Checksum 0x9aa2cfab, Offset: 0x179f
// Size: 0x79
function function_1a1b3e0a6c77355c()
{
    self endon( #"death" );
    self.var_361a087ab08adc1c = "walk";
    self.forcespeed = 1;
    utility::waittill_any_timeout( 25, "damage" );
    thread function_70318318601711cb( 20 );
    self.var_361a087ab08adc1c = "sprint";
    self.forcespeed = undefined;
    zombie_utils::function_a8ce00e0448cb6f0( self.var_361a087ab08adc1c, "ztron", 4 );
    self notify( #"speed_change" );
}

// Namespace ztron_ai_zombie
// Params 0
// Checksum 0x86c07c40, Offset: 0x1820
// Size: 0xc1
function function_21d7949c9c945c54()
{
    if ( ztron_main::function_4da200e9b8d58a3c() == 1 )
    {
        var_4d64a5b861c8840 = level.ztron.active_arena.safespots[ randomint( level.ztron.active_arena.safespots.size ) ];
    }
    else if ( ztron_main::function_4da200e9b8d58a3c() == 5 )
    {
        var_4d64a5b861c8840 = level.ztron.slayer.active_arena.safespots[ randomint( level.ztron.slayer.active_arena.safespots.size ) ];
    }
    
    return var_4d64a5b861c8840;
}

// Namespace ztron_ai_zombie
// Params 0
// Checksum 0x71d7544, Offset: 0x18ea
// Size: 0x17f
function function_c9a4cf2708e442b6()
{
    self endon( #"death" );
    
    if ( self.var_ec53a18db3e4e78c )
    {
        var_4d64a5b861c8840 = self.var_ec53a18db3e4e78c;
    }
    else
    {
        var_4d64a5b861c8840 = function_21d7949c9c945c54();
        
        if ( !isdefined( var_4d64a5b861c8840 ) )
        {
            return;
        }
        
        var_4d64a5b861c8840 = var_4d64a5b861c8840.origin;
    }
    
    droploc = var_4d64a5b861c8840 + ( 0, 0, 1400 );
    org = utility::spawn_model( "tag_origin", droploc );
    self.origin = org.origin;
    org thread ztron_util::function_f7544bfa701db406( self );
    org2 = utility::spawn_model( "tag_origin", var_4d64a5b861c8840 );
    org2 thread ztron_util::function_f7544bfa701db406( self );
    playfxontag( utility::getfx( "heavyZombie_land_hintMarker" ), org2, "tag_origin" );
    self linkto( org );
    playfxontag( utility::getfx( "heavyZombie_trail" ), org, "tag_origin" );
    org moveto( var_4d64a5b861c8840, 1 );
    org waittill( #"movedone" );
    ztron_sound::ztron_playsound( "heavyZombie_land" );
    playfx( utility::getfx( "heavyZombie_land" ), self.origin );
    stopfxontag( utility::getfx( "heavyZombie_land_hintMarker" ), org2, "tag_origin" );
    stopfxontag( utility::getfx( "heavyZombie_trail" ), org, "tag_origin" );
    org2 delete();
    self unlink();
    waitframe();
    org delete();
    self.disallow_knockdown = 0;
}

// Namespace ztron_ai_zombie
// Params 0
// Checksum 0xc3a71028, Offset: 0x1a71
// Size: 0x45
function function_44f5ef46e7529089()
{
    function_8c6501764cf8eda3( 150, "walk", 0 );
    ztron_enemy_ai::function_4e106850bd9eef1a();
    zombie_sethealth( self.maxhealth + 700 );
    self.disallow_knockdown = 1;
    thread function_1a1b3e0a6c77355c();
    thread function_c9a4cf2708e442b6();
}

// Namespace ztron_ai_zombie
// Params 0
// Checksum 0x267b3310, Offset: 0x1abe
// Size: 0xbb
function function_61f506a80d58beb9()
{
    function_8c6501764cf8eda3( 100 );
    barrel = ztron_hazard_barrel::hazard_spawn_barrel( "decor_barrels_gameplay_flammable_ztron", undefined, self.origin, self.angles, 0 );
    
    if ( isdefined( barrel ) )
    {
        barrel notsolid();
        barrel enablelinkto();
        self enablelinkto();
        barrel disableaimassist();
        barrel.carried = 1;
        barrel setcandamage( 1 );
        barrel.health = 99999;
        barrel linkto( self, "j_head", ( 4, 0, 0 ), ( 90, 0, 0 ) );
        barrel thread function_1871b28f38c68b14( self );
        barrel thread ztron_util::deletemedelay( 120 );
    }
}

// Namespace ztron_ai_zombie
// Params 0
// Checksum 0xdab38d11, Offset: 0x1b81
// Size: 0x7e
function function_52018cfc40c361aa()
{
    self endon( #"death" );
    self waittill( #"damage" );
    self.ignoreall = 0;
    
    if ( isdefined( self.attractor ) )
    {
        zombie_attractor_manager::function_dcfb4c31f1d97cd2( self.attractor );
    }
    
    self notify( #"attractor_removed" );
    killfxontag( level.var_b9bef0125ff74d0, self, "tag_origin" );
    thread ztron_enemy_ai::function_9a34c1b86e0eec7c();
    self notify( #"killpole" );
    waitframe();
    self setcandamage( 1 );
}

// Namespace ztron_ai_zombie
// Params 1
// Checksum 0x4ad236ca, Offset: 0x1c07
// Size: 0x15b
function function_9aad68ea71bc2d83( var_7a06e59d2455af31 = 1 )
{
    self endon( #"death", #"killpole" );
    org = utility::spawn_model( "tag_origin", self.origin, self.angles );
    org thread ztron_util::function_36239518d8da65f0( self, "death" );
    org thread ztron_util::function_36239518d8da65f0( self, "killpole" );
    self motionwarpcancel();
    self linkto( org );
    self setcandamage( 0 );
    org moveto( self.origin + ( 0, 0, -128 ), 2 );
    org thread ztron_util::orgspinout();
    org utility::waittill_any_timeout( 3.1, "movedone" );
    
    if ( var_7a06e59d2455af31 )
    {
        polestruct = spawnstruct();
        var_f9cd5cbcdb7bf574 = ztron_hazard_electric_pole::function_5af93e037365b05e( polestruct, undefined, org.origin, org.angles );
        
        if ( isdefined( var_f9cd5cbcdb7bf574 ) )
        {
            var_f9cd5cbcdb7bf574 moveto( var_f9cd5cbcdb7bf574.origin + ( 0, 0, 128 ), 3 );
        }
    }
    
    self.noragdoll = 1;
    self setcandamage( 1 );
    killfxontag( level.var_b9bef0125ff74d0, self, "tag_origin" );
    thread ztron_util::function_ea0a0be5c5468c48( 0.1, undefined, undefined );
}

// Namespace ztron_ai_zombie
// Params 0
// Checksum 0x7e230f65, Offset: 0x1d6a
// Size: 0x1b9
function function_27cf5d6bb45a1ece()
{
    self notify( #"hash_c43bf14dd0d09df1" );
    self endon( #"hash_c43bf14dd0d09df1" );
    self endon( #"death", #"killpole" );
    thread function_52018cfc40c361aa();
    self.ignoreall = 1;
    wait 0.1;
    self.var_361a087ab08adc1c = "sprint";
    self.forcespeed = 1;
    zombie_utils::function_a8ce00e0448cb6f0( self.var_361a087ab08adc1c, "ztron", 4 );
    self notify( #"speed_change" );
    var_2ff9bebe06d34fed = level.ztron.active_arena.lootspots[ randomint( level.ztron.active_arena.lootspots.size ) ];
    targetloc = ztron_util::function_78a5b128a3e32460( var_2ff9bebe06d34fed.origin, 300, 48 );
    ztron_enemy_ai::function_83baeab9d0850baa( targetloc, 1, 1, -1 );
    reachedgoal = 0;
    begintime = gettime();
    
    while ( gettime() - begintime < 10000 )
    {
        if ( distancesquared( self.origin, targetloc ) < self.goalradius * self.goalradius )
        {
            reachedgoal = 1;
            break;
        }
        
        wait 1;
    }
    
    if ( !reachedgoal && !function_32d9d392d80b0a9c() )
    {
        begintime = gettime();
        
        while ( gettime() - begintime < 10000 )
        {
            if ( distancesquared( self.origin, targetloc ) < self.goalradius * self.goalradius )
            {
                break;
            }
            
            wait 1;
        }
    }
    
    thread function_9aad68ea71bc2d83( function_32d9d392d80b0a9c() );
}

// Namespace ztron_ai_zombie
// Params 0, eflags: 0x4
// Checksum 0xd70affec, Offset: 0x1f2b
// Size: 0xb9, Type: bool
function private function_32d9d392d80b0a9c()
{
    arena = level.ztron.active_arena;
    
    if ( !arena || !arena.safevolumes.size )
    {
        return true;
    }
    
    foreach ( safevolume in arena.safevolumes )
    {
        if ( self istouching( safevolume ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace ztron_ai_zombie
// Params 0
// Checksum 0xdd47ced4, Offset: 0x1fed
// Size: 0x4b
function function_b9bef0125ff74d0()
{
    self notify( #"hash_82365a388c69b4e2" );
    self endon( #"hash_82365a388c69b4e2" );
    self endon( #"death", #"killpole" );
    wait 0.25;
    ztron_vfx::function_a2884eba34f8ea6b( level.var_b9bef0125ff74d0, self, "tag_origin" );
}

// Namespace ztron_ai_zombie
// Params 0
// Checksum 0x977d11a2, Offset: 0x2040
// Size: 0x2f
function function_a2f230d3a9211d64()
{
    profilestart();
    function_8c6501764cf8eda3( 100, "sprint" );
    self.goalradius = 20;
    self setmodel( "c_sat_zmb_cosmo_zombie_spacesuit_male_2" );
    thread function_b9bef0125ff74d0();
    profilestop();
}

// Namespace ztron_ai_zombie
// Params 1
// Checksum 0x7fe68e02, Offset: 0x2077
// Size: 0x65
function function_de98384230be1da7( chance )
{
    if ( ztron_main::function_4da200e9b8d58a3c() != 1 || level.ztron.roundnumber < 5 )
    {
        return 0;
    }
    
    if ( ztron_hazard_electric_pole::function_52058b3337155884() >= level.ztron.active_arena.var_bbc024c10c8d4b9e )
    {
        return 0;
    }
    
    return ztron_enemy_ai::function_6f58a8788ecd236d( chance );
}

// Namespace ztron_ai_zombie
// Params 0
// Checksum 0xbb468b65, Offset: 0x20e5
// Size: 0xb3
function function_13c7e11f982c69fe()
{
    function_8c6501764cf8eda3( 350, "run", 0 );
    ztron_enemy_ai::function_4e106850bd9eef1a( level.ztron.var_2a2d12c87e88af98, level.ztron.var_3172b140ef7aaae3, level.ztron.var_3bb2add1378575fa, level.ztron.var_7026573ca277eb95 );
    zombie_sethealth( self.maxhealth + 5000 );
    self.ztron.elite = 1;
    self.aicategory = "elite";
    self.var_895476d327fa9e31 = 1;
    self.var_840153567385cc6b = 1;
}

// Namespace ztron_ai_zombie
// Params 0
// Checksum 0x295781f5, Offset: 0x21a0
// Size: 0x63
function function_80f7573034231728()
{
    ztron_enemy_ai::function_3ae4286f85e2ef9e();
    ztron_enemy_ai::function_40fd300070feec7c( 1000 );
    zombie_sethealth( self.maxhealth + 15000 + ( level.players.size - 1 ) * 5000 + level.ztron.game_laps * 15000 );
    thread function_c9a4cf2708e442b6();
    self.var_895476d327fa9e31 = 1;
}

// Namespace ztron_ai_zombie
// Params 0
// Checksum 0x90f66715, Offset: 0x220b
// Size: 0x36
function function_a6732c4a2e1eb721()
{
    function_8c6501764cf8eda3( 100, "sprint" );
    zombie_sethealth( 65 );
    self.nooneshot = 1;
    val::set( "zombie_init", "allow_unreachable_attack", 0 );
}

// Namespace ztron_ai_zombie
// Params 0
// Checksum 0xc39875eb, Offset: 0x2249
// Size: 0xf0
function function_70fb9f7c269184c1()
{
    self.no_burn = 1;
    function_8c6501764cf8eda3( 100, "sprint", 0, 0 );
    zombie_sethealth( 65 );
    self._blackboard.var_cedd501bdb70cc3f = 100;
    val::set( "zombie_init", "allow_unreachable_attack", 0 );
    self.nooneshot = 1;
    
    if ( ztron_main::function_4da200e9b8d58a3c() == 1 )
    {
        if ( level.ztron.active_arena.var_13e779d5bde58881.size > 0 )
        {
            self.spawnloc = level.ztron.active_arena.var_13e779d5bde58881[ randomint( level.ztron.active_arena.var_13e779d5bde58881.size ) ];
        }
    }
    
    if ( isdefined( self.oldgrenadeweapon ) )
    {
        self.grenadeweapon = self.oldgrenadeweapon;
    }
}

// Namespace ztron_ai_zombie
// Params 0
// Checksum 0x50aa3e04, Offset: 0x2341
// Size: 0xf5
function function_568540eec156b4c9()
{
    self.ztron.move_tries = 16;
    function_8c6501764cf8eda3( 350, "walk", 0 );
    zombie_sethealth( self.maxhealth + 5000 );
    self.ztron.elite = 1;
    self.no_burn = 1;
    self.aicategory = "elite";
    self.var_840153567385cc6b = 1;
    self.var_cef5832c47f5e009 = 1;
    utility::function_32b24db3127bff40( "spawn_reveal_ztron", "spawn_reveal" );
    self notify( #"hash_5840d907b9454cb" );
    thread ztron_util::function_c8250171b708089c( level, "ztron_round_spawning", 45 );
    
    if ( ztron_main::function_4da200e9b8d58a3c() == 1 )
    {
        gotospot = level.ztron.active_arena.center.origin;
        thread function_98d0b158b44cada7( gotospot );
    }
}

// Namespace ztron_ai_zombie
// Params 0
// Checksum 0xdcc5d773, Offset: 0x243e
// Size: 0x3, Type: bool
function function_7d204eebc1d38ce3()
{
    return false;
}

// Namespace ztron_ai_zombie
// Params 0
// Checksum 0x8a31203c, Offset: 0x244a
// Size: 0xe4
function function_1e29a102529eed3d()
{
    self.ztron.move_tries = 16;
    function_8c6501764cf8eda3( 350, "walk", 0 );
    zombie_sethealth( self.maxhealth + 5000 );
    self.no_burn = 1;
    self.ztron.elite = 1;
    self.aicategory = "elite";
    self.var_840153567385cc6b = 1;
    self.var_cef5832c47f5e009 = 1;
    self notify( #"hash_5840d907b9454cb" );
    thread ztron_util::function_c8250171b708089c( level, "ztron_round_spawning", 45 );
    
    if ( ztron_main::function_4da200e9b8d58a3c() == 1 )
    {
        gotospot = level.ztron.active_arena.center.origin;
        thread function_98d0b158b44cada7( gotospot );
    }
}

// Namespace ztron_ai_zombie
// Params 2
// Checksum 0x612af7a8, Offset: 0x2536
// Size: 0x4e
function function_98d0b158b44cada7( goalpos, radius = 32 )
{
    self endon( #"death" );
    self setgoalpos( goalpos, radius );
    set_forcegoal();
    self waittill( #"goal" );
    unset_forcegoal();
}

// Namespace ztron_ai_zombie
// Params 0
// Checksum 0x1dd48b01, Offset: 0x258c
// Size: 0x72
function set_forcegoal()
{
    if ( isdefined( self.set_forcedgoal ) )
    {
        return;
    }
    
    self.oldfightdist = self.pathenemyfightdist;
    self.oldmaxdist = self.pathenemylookahead;
    self.oldmaxsight = self.maxsightdistsqrd;
    self.pathenemyfightdist = 8;
    self.pathenemylookahead = 8;
    self.maxsightdistsqrd = 1;
    self.set_forcedgoal = 1;
}

// Namespace ztron_ai_zombie
// Params 0
// Checksum 0xb17397cf, Offset: 0x2606
// Size: 0x6f
function unset_forcegoal()
{
    if ( !isdefined( self.set_forcedgoal ) )
    {
        return;
    }
    
    self.pathenemyfightdist = self.oldfightdist;
    self.pathenemylookahead = self.oldmaxdist;
    self.maxsightdistsqrd = self.oldmaxsight;
    self.set_forcedgoal = undefined;
    self.oldfightdist = undefined;
    self.oldmaxdist = undefined;
    self.oldmaxsight = undefined;
}

// Namespace ztron_ai_zombie
// Params 0
// Checksum 0x95c244ff, Offset: 0x267d
// Size: 0xd9
function function_bc328031d27ead01()
{
    ztron_enemy_ai::function_3ae4286f85e2ef9e();
    ztron_enemy_ai::function_40fd300070feec7c( 500 );
    zombie_sethealth( self.maxhealth + 15000 + ( level.players.size - 1 ) * 5000 + level.ztron.game_laps * 15000 );
    self.var_cef5832c47f5e009 = 1;
    thread ztron_util::function_c8250171b708089c( level, "ztron_round_spawning", 45, undefined, undefined, undefined, 0 );
    var_4d64a5b861c8840 = function_21d7949c9c945c54();
    
    if ( isdefined( var_4d64a5b861c8840 ) )
    {
        org = utility::spawn_model( "tag_origin", var_4d64a5b861c8840.origin - ( 0, 0, 256 ) );
    }
    
    if ( isdefined( org ) )
    {
        org thread ztron_util::function_f7544bfa701db406( self );
        thread function_6623ec890b434622( org, var_4d64a5b861c8840.origin );
    }
}

// Namespace ztron_ai_zombie
// Params 2
// Checksum 0xfc01c31d, Offset: 0x275e
// Size: 0x8e
function function_6623ec890b434622( org, targetorigin )
{
    self endon( #"death" );
    self.origin = org.origin;
    self linkto( org );
    wait 1;
    playfx( utility::getfx( "lightning_spawn" ), targetorigin );
    org moveto( targetorigin + ( 0, 0, 24 ), 3 );
    wait 3;
    ztron_sound::ztron_playsound( "heavyZombie_land" );
    wait 0.5;
    self unlink();
    waitframe();
    org delete();
}

// Namespace ztron_ai_zombie
// Params 0
// Checksum 0xbe9965dd, Offset: 0x27f4
// Size: 0x9f
function function_52a5c0ecad004327()
{
    self.no_burn = 1;
    function_8c6501764cf8eda3( 350, undefined, 0 );
    ztron_enemy_ai::function_4e106850bd9eef1a( level.ztron.var_2a2d12c87e88af98, level.ztron.var_3172b140ef7aaae3, level.ztron.var_3bb2add1378575fa, level.ztron.var_7026573ca277eb95 );
    zombie_sethealth( self.maxhealth + 2000 );
    
    if ( isdefined( self.oldgrenadeweapon ) )
    {
        self.grenadeweapon = self.oldgrenadeweapon;
    }
}

// Namespace ztron_ai_zombie
// Params 0
// Checksum 0xe4dee31f, Offset: 0x289b
// Size: 0xa7
function function_8f6de6178e8b2b67()
{
    ztron_enemy_ai::function_3ae4286f85e2ef9e();
    ztron_enemy_ai::function_40fd300070feec7c( 1000 );
    zombie_sethealth( 25000 + level.players.size * 6000 + level.ztron.game_laps * 25000 );
    
    for ( var_4d54160378fa19cf = 0; var_4d54160378fa19cf < 2 ; var_4d54160378fa19cf++ )
    {
        if ( isdefined( self.var_49d756f6c3af84e9[ var_4d54160378fa19cf ] ) )
        {
            self.var_49d756f6c3af84e9[ var_4d54160378fa19cf ].var_cef5832c47f5e009 = 1;
        }
    }
    
    if ( isdefined( self.oldgrenadeweapon ) )
    {
        self.grenadeweapon = self.oldgrenadeweapon;
    }
}

// Namespace ztron_ai_zombie
// Params 0
// Checksum 0xf42ae509, Offset: 0x294a
// Size: 0xb9
function function_76148e3ec1fa3f4f()
{
    self.no_burn = 1;
    self.var_6820d1249495110a = 1;
    self.ztron.move_tries = 16;
    function_8c6501764cf8eda3( 100, undefined, 0 );
    self.nooneshot = 1;
    
    if ( isdefined( self.oldgrenadeweapon ) )
    {
        self.grenadeweapon = self.oldgrenadeweapon;
    }
    
    val::set( "ztron_ai_zombie", "dont_evolve", 1 );
    self function_786bb6aa1b76c7ee( "default_float_height", 40 );
    self._blackboard.var_fc25cdb6c8f6b8bf = 200;
    self._blackboard.var_d075c035f7081d2a = 400;
    zombie_sethealth( 30 );
}

// Namespace ztron_ai_zombie
// Params 0
// Checksum 0x96b7e27d, Offset: 0x2a0b
// Size: 0xaa
function function_44da85f13c2baf7b()
{
    self.ztron.elite = 1;
    function_8c6501764cf8eda3( 500, undefined, 0 );
    ztron_enemy_ai::function_4e106850bd9eef1a( level.ztron.var_2a2d12c87e88af98, level.ztron.var_3172b140ef7aaae3, level.ztron.var_3bb2add1378575fa, level.ztron.var_7026573ca277eb95 );
    zombie_sethealth( self.maxhealth + 5000 );
    
    if ( isdefined( self.oldgrenadeweapon ) )
    {
        self.grenadeweapon = self.oldgrenadeweapon;
    }
}

// Namespace ztron_ai_zombie
// Params 0
// Checksum 0x4662b804, Offset: 0x2abd
// Size: 0x22
function function_a879c86daded2e1d()
{
    function_8c6501764cf8eda3( 100, "sprint", 0 );
    utility::function_32b24db3127bff40( "phobos_empowered", "off_tube" );
}

// Namespace ztron_ai_zombie
// Params 0
// Checksum 0x953c1b5c, Offset: 0x2ae7
// Size: 0x8b
function function_d95a9e71efacd0c4()
{
    ztron_enemy_ai::function_3ae4286f85e2ef9e();
    ztron_enemy_ai::function_40fd300070feec7c( 1000 );
    zombie_sethealth( getdvarint( @"hash_a8c056f08349c820", 35000 ) + ( level.players.size - 1 ) * 6000 + level.ztron.game_laps * getdvarint( @"hash_a8c056f08349c820", 35000 ) );
    self.var_818c06f9a89fb0ba = 1;
    
    if ( isdefined( self.oldgrenadeweapon ) )
    {
        self.grenadeweapon = self.oldgrenadeweapon;
    }
}

// Namespace ztron_ai_zombie
// Params 0
// Checksum 0x378045dc, Offset: 0x2b7a
// Size: 0x54
function tritonthink()
{
    self endon( #"death" );
    thread ztron_enemy_ai::function_9a34c1b86e0eec7c();
    
    while ( true )
    {
        if ( self getaiblackboarddynamic( "goingToSpawnPoint" ) == 1 && self.favoriteenemy )
        {
            self clearbtgoal( 2 );
            self function_786bb6aa1b76c7ee( "goingToSpawnPoint", 0 );
        }
        
        wait 0.5;
    }
}

// Namespace ztron_ai_zombie
// Params 0
// Checksum 0x74a1b4d7, Offset: 0x2bd6
// Size: 0xb2
function function_279d06bc2fe85be1()
{
    ztron_enemy_ai::function_3ae4286f85e2ef9e();
    ztron_enemy_ai::function_40fd300070feec7c( 1000 );
    zombie_sethealth( getdvarint( @"hash_7a129a8de6271633", 50000 ) + ( level.players.size - 1 ) * 6000 + level.ztron.game_laps * getdvarint( @"hash_7a129a8de6271633", 50000 ) );
    self.var_361a087ab08adc1c = "walk";
    self.var_183395a55b9ebcf4 = &function_8de0e1e9a95f0421;
    self.disableenraged = 1;
    self.var_818c06f9a89fb0ba = 3;
    
    if ( isdefined( self.oldgrenadeweapon ) )
    {
        self.grenadeweapon = self.oldgrenadeweapon;
    }
}

// Namespace ztron_ai_zombie
// Params 0
// Checksum 0x6b760196, Offset: 0x2c90
// Size: 0x1c
function phobosthink()
{
    self endon( #"death" );
    thread ztron_enemy_ai::function_9a34c1b86e0eec7c();
    thread function_a014cec5c4b3f788();
}

// Namespace ztron_ai_zombie
// Params 0, eflags: 0xc
// Checksum 0xae9fbdb1, Offset: 0x2cb4
// Size: 0x29d
function private function_a014cec5c4b3f788()
{
    self notify( #"hash_f7ed49dbbe1b282" );
    self endon( #"hash_f7ed49dbbe1b282" );
    self endon( #"death" );
    
    while ( true )
    {
        var_da1faae412a5ef53 = -64;
        isstuck = undefined;
        
        if ( isdefined( level.ztron.slayer.active_arena.center ) )
        {
            var_da1faae412a5ef53 = level.ztron.slayer.active_arena.center.origin[ 2 ] - 16;
        }
        
        if ( isdefined( self.var_4d74cede8cfcdb6 ) && distance( self.var_4d74cede8cfcdb6, self.origin ) < 16 )
        {
            if ( !isdefined( self.blockedtime ) )
            {
                self.blockedtime = gettime();
            }
            
            if ( gettime() - self.blockedtime > 8000 )
            {
                isstuck = 1;
                self.blockedtime = undefined;
            }
        }
        else
        {
            self.var_4d74cede8cfcdb6 = self.origin;
            self.blockedtime = undefined;
        }
        
        if ( self.origin[ 2 ] < var_da1faae412a5ef53 || isstuck )
        {
            self motionwarpcancel();
            org = utility::spawn_model( "tag_origin", self.origin );
            self linkto( org );
            org thread ztron_util::function_f7544bfa701db406( self );
            framecount = 30;
            framefrac = 1 / framecount;
            frac = 0;
            targetpos = level.ztron.slayer.active_arena.bossspawns[ randomint( level.ztron.slayer.active_arena.bossspawns.size ) ].origin + ( 0, 0, 64 );
            var_9273bee737c9de2a = utility::function_6f5d2e1f1ff70482( 50 );
            
            while ( frac < 1 )
            {
                neworigin = math::get_point_on_parabola( self.origin, targetpos, 500, frac );
                org moveto( neworigin, var_9273bee737c9de2a );
                frac += framefrac;
                wait var_9273bee737c9de2a;
            }
            
            org moveto( targetpos, var_9273bee737c9de2a );
            org waittill( #"movedone" );
            wait 0.1;
            self unlink();
            waitframe();
            org delete();
        }
        
        wait 1;
    }
}

// Namespace ztron_ai_zombie
// Params 0
// Checksum 0xf8fbdca0, Offset: 0x2f59
// Size: 0xb
function function_8de0e1e9a95f0421()
{
    return function_b3988325430ce242( "zombie_base" );
}

// Namespace ztron_ai_zombie
// Params 0
// Checksum 0x832ccc6, Offset: 0x2f6d
// Size: 0xd5
function function_6cee3d514db310ab()
{
    tag_le = "j_ball_le";
    tag_ri = "j_ball_ri";
    var_f8eceb9cf09ff85f = self gettagorigin( tag_le ) - ( 0, 0, 10 );
    var_4ba4cc6f00f750bd = self gettagorigin( tag_ri ) - ( 0, 0, 10 );
    self.var_3f696ebfb0ffe19b[ 0 ].owner = self;
    self.var_3f696ebfb0ffe19b[ 0 ] utility::scriptable_setparententity( self, var_f8eceb9cf09ff85f - self.origin );
    self.var_3f696ebfb0ffe19b[ 1 ].owner = self;
    self.var_3f696ebfb0ffe19b[ 1 ] utility::scriptable_setparententity( self, var_4ba4cc6f00f750bd - self.origin );
    thread phobosdeathwatcher();
}

// Namespace ztron_ai_zombie
// Params 0
// Checksum 0xc7a781b3, Offset: 0x304a
// Size: 0xe0
function phobosdeathwatcher()
{
    level endon( #"ztron_game_is_over" );
    leg_le = self.var_3f696ebfb0ffe19b[ 0 ];
    leg_ri = self.var_3f696ebfb0ffe19b[ 1 ];
    self waittill( #"death" );
    
    if ( isdefined( leg_le ) && leg_le getscriptableparthasstate( "health", "no_damage" ) )
    {
        leg_le setscriptablepartstate( "collision", "no_collision" );
        leg_le setscriptablepartstate( "health", "no_damage" );
    }
    
    if ( isdefined( leg_ri ) && leg_ri getscriptableparthasstate( "health", "no_damage" ) )
    {
        leg_ri setscriptablepartstate( "collision", "no_collision" );
        leg_ri setscriptablepartstate( "health", "no_damage" );
    }
    
    wait 0.1;
    
    if ( isdefined( leg_le ) )
    {
        leg_le freescriptable();
    }
    
    if ( isdefined( leg_ri ) )
    {
        leg_ri freescriptable();
    }
}

// Namespace ztron_ai_zombie
// Params 1
// Checksum 0xc1f1e64d, Offset: 0x3132
// Size: 0xca
function function_5164e6fac07fa9d( params )
{
    if ( isdefined( params.zombie ) )
    {
        zombie = params.zombie;
        zombie.ztron = spawnstruct();
        zombie function_8c6501764cf8eda3( 100 );
        zombie thread ztron_enemy_ai::function_9a34c1b86e0eec7c();
        zombie.agent_damage_callback = &ztron_enemy::function_2d459ce49ce8b45e;
        
        if ( zombie.subclass == "zombie_mimic" )
        {
            zombie_sethealth( self.maxhealth + 2000 );
        }
        
        zombie thread ztron_util::function_c8250171b708089c( level, "ztron_round_spawning", 20 );
        
        if ( level.ztron.var_91517987ca332e2a )
        {
            level.ztron.var_91517987ca332e2a++;
        }
    }
}

// Namespace ztron_ai_zombie
// Params 0
// Checksum 0xd651f148, Offset: 0x3204
// Size: 0x62
function function_b686fd366ef21a0e()
{
    function_8c6501764cf8eda3( undefined, "sprint", 0 );
    self.nogib = 1;
    self.lifecount = 2;
    self.var_d8f82e76c2931622 = 1;
    val::set_allow_death( 0 );
    val::set( "mannequin", "allow_dismember", 0 );
    thread function_fff4efe19eff4bee();
    zombie_sethealth( 150 );
    thread ztron_enemy_ai::function_9a34c1b86e0eec7c();
}

// Namespace ztron_ai_zombie
// Params 0
// Checksum 0x44b224ff, Offset: 0x326e
// Size: 0x5a
function function_fff4efe19eff4bee()
{
    level endon( #"ztron_game_is_over" );
    self endon( #"death" );
    utility::waittill_any_ents( level, "round_over", self, "lifespan_approached" );
    
    if ( self.aifrozen )
    {
        asm::unfreeze_ai();
    }
    
    self setcandamage( 1 );
    val::set_allow_death( 1 );
    thread ztron_util::function_ea0a0be5c5468c48( 1 );
}

// Namespace ztron_ai_zombie
// Params 0
// Checksum 0x20ae58da, Offset: 0x32d0
// Size: 0x21e
function function_454eac4b00457e0c()
{
    level endon( #"ztron_game_is_over", #"round_over" );
    self endon( #"death" );
    
    if ( level.ztron.mannequinchallenge )
    {
        self setcandamage( 0 );
        wait 0.1;
        asm::freeze_ai();
        self function_e8726d980fa12944();
        
        while ( !self getcandamage() )
        {
            wait 0.5;
            
            foreach ( player in level.players )
            {
                var_bae30b509595858b = 62500;
                
                if ( distance2dsquared( self.origin, player.origin ) < var_bae30b509595858b || level.ztron.var_cd7b5b2d9403d4fe )
                {
                    asm::unfreeze_ai();
                    self visiblesolid();
                    self setcandamage( 1 );
                    break;
                }
            }
        }
    }
    
    utility::ent_flag_set( "mannequin_awake" );
    thread function_636129cdbd4b12d7();
    
    while ( true )
    {
        self waittill( #"damage", idamage, attacker );
        
        if ( idamage > self.health )
        {
            if ( self.lifecount <= 0 )
            {
                self notify( #"lifespan_approached" );
                return;
            }
            
            self setcandamage( 0 );
            utility::ent_flag_clear( "mannequin_awake" );
            function_194810b88f672f29( 1 );
            asm::freeze_ai();
            self function_7f8988ce63c1623d( 0 );
            wait 3;
            asm::unfreeze_ai();
            self function_7f8988ce63c1623d( 1 );
            function_194810b88f672f29( 1 );
            self.health = self.maxhealth;
            utility::ent_flag_set( "mannequin_awake" );
            self setcandamage( 1 );
            self.lifecount--;
            self.nogib = self.lifecount > 0;
        }
    }
}

// Namespace ztron_ai_zombie
// Params 1
// Checksum 0xc8e4b3aa, Offset: 0x34f6
// Size: 0x38
function function_194810b88f672f29( time )
{
    zombie_stun::stun_ai( time );
    self setscriptablepartstate( "dark_aether_field_bubble", "dark_aether_field_bubble_on" );
    wait time;
    self setscriptablepartstate( "dark_aether_field_bubble", "dark_aether_field_bubble_off" );
}

// Namespace ztron_ai_zombie
// Params 0
// Checksum 0x4866c0, Offset: 0x3536
// Size: 0x9c
function function_636129cdbd4b12d7()
{
    level endon( #"ztron_game_is_over", #"round_over" );
    self endon( #"death" );
    fx = utility::getfx( "nova_juice_me_aura_fx" );
    waitframe();
    
    if ( utility::ent_flag( "mannequin_awake" ) )
    {
        ztron_vfx::function_a2884eba34f8ea6b( fx, self, "j_spine4" );
    }
    
    while ( true )
    {
        self waittill( #"mannequin_awake" );
        
        if ( utility::ent_flag( "mannequin_awake" ) )
        {
            ztron_vfx::function_a2884eba34f8ea6b( fx, self, "j_spine4" );
            continue;
        }
        
        ztron_vfx::aistopfxontag( fx, self, "j_spine4" );
    }
}

// Namespace ztron_ai_zombie
// Params 0
// Checksum 0x217e795d, Offset: 0x35da
// Size: 0x186
function function_246e9a1e58dcf9c()
{
    if ( self.ztron.boss )
    {
        return;
    }
    
    self endon( #"death", #"hash_5840d907b9454cb" );
    lastspot = self.origin;
    maxtries = self.ztron.move_tries ?? 8;
    tries = maxtries;
    var_ea18a0c17230293d = 576;
    
    while ( true )
    {
        wait 1;
        
        if ( self.team == "allies" )
        {
            continue;
        }
        
        if ( !isdefined( self.favoriteenemy ) )
        {
            continue;
        }
        
        if ( self.ignoreall )
        {
            continue;
        }
        
        if ( !self getcandamage() )
        {
            continue;
        }
        
        if ( !isalive( self.favoriteenemy ) || player::isinlaststand( self.favoriteenemy ) )
        {
            continue;
        }
        
        if ( isplayer( self.favoriteenemy ) && self.favoriteenemy bgb::is_enabled( "idle_eyes" ) || self.favoriteenemy.aether_shroud_active )
        {
            continue;
        }
        
        if ( distancesquared( lastspot, self.origin ) < var_ea18a0c17230293d )
        {
            tries--;
            
            if ( tries <= 0 )
            {
                ztron_debug::debugmsg( "---------------- KILLING STUCK ZOMBIE: " + self.origin );
                ztron_util::function_ea0a0be5c5468c48( 0.1 );
            }
            
            continue;
        }
        
        lastspot = self.origin;
        tries = maxtries;
    }
}

// Namespace ztron_ai_zombie
// Params 0
// Checksum 0x5e3d05a6, Offset: 0x3768
// Size: 0x53
function function_9381bb283619f81f()
{
    self notify( #"hash_504016c6c6b7c007" );
    self endon( #"hash_504016c6c6b7c007" );
    level endon( #"ztron_game_is_over" );
    self endon( #"death" );
    
    while ( true )
    {
        if ( namespace_b76ff2659823e89d::is_crawling() )
        {
            thread ztron_util::function_ea0a0be5c5468c48( 8 );
            return;
        }
        
        wait 0.1;
    }
}

// Namespace ztron_ai_zombie
// Params 1
// Checksum 0xfa3bea36, Offset: 0x37c3
// Size: 0x111
function function_ca2fd8a06fde081a( alertat )
{
    self notify( #"hash_1696b1f16fe9e788" );
    self endon( #"hash_1696b1f16fe9e788" );
    level endon( #"ztron_game_is_over" );
    
    while ( true )
    {
        if ( isdefined( level.ztron.active_arena ) && ztron_main::function_4da200e9b8d58a3c() == 1 )
        {
            if ( level.ztron.var_316dc0679575bf4d >= 15 )
            {
                ztron_debug::debugmsg( "Issuing a KITE DETECTION notification" );
                
                foreach ( ai in level.ztron.zombies )
                {
                    ai notify( #"kiting_detected" );
                }
                
                wait 10;
            }
        }
        
        wait 0.5;
    }
}

// Namespace ztron_ai_zombie
// Params 1
// Checksum 0xa8496466, Offset: 0x38dc
// Size: 0x319
function function_70318318601711cb( var_ee943c85cb2f67d = 45 )
{
    self notify( #"hash_4d5a8cb722d67f47" );
    self endon( #"hash_4d5a8cb722d67f47" );
    level endon( #"ztron_game_is_over", #"ztron_game_reset" );
    
    if ( getdvarint( @"hash_3875f4b763dc6224", 1 ) == 0 )
    {
        return;
    }
    
    if ( ztron_main::function_4da200e9b8d58a3c() != 1 )
    {
        return;
    }
    
    self endon( #"death" );
    msg = utility::waittill_any_timeout( var_ee943c85cb2f67d, "kiting_detected" );
    
    if ( isdefined( self.lastdamagedtime ) && gettime() - self.lastdamagedtime <= 2000 )
    {
        thread function_70318318601711cb( 15 );
    }
    
    if ( !self.var_41a10996703cecb2 )
    {
        self.var_41a10996703cecb2 = 1;
        level.ztron.var_316dc0679575bf4d++;
        thread function_91957a6751e630bf();
    }
    
    if ( msg == "kiting_detected" )
    {
        wait randomfloat( 8 );
    }
    
    self.forcespeed = undefined;
    nextspeed = ztron_enemy_ai::function_301ea1a231b88fb2( self.var_361a087ab08adc1c );
    
    if ( level.ztron.var_371903e5801e0e08 && nextspeed == "super_sprint" )
    {
        return;
    }
    
    if ( nextspeed != self.var_361a087ab08adc1c && !self._blackboard.isunderwater )
    {
        ztron_enemy_ai::function_dac12bb77573fab( nextspeed );
    }
    
    if ( self.var_361a087ab08adc1c != "super_sprint" )
    {
        thread function_70318318601711cb( 10 );
    }
    
    if ( !self.ztron.boss )
    {
        thread ztron_util::function_ea0a0be5c5468c48( randomintrange( 25, 45 ) );
    }
    
    val::set( "antiKiteBoost", "collide_with_ai_allies", 0 );
    val::set( "antiKiteBoost", "script_pushable_by_ai", 0 );
    val::set( "antiKiteBoost", "script_pushable", 0 );
    val::set( "antiKiteBoost", "ignore_ai_collision", 1 );
    targetloc = ztron_arena::function_8c2aa5e7037af31c().origin;
    level thread ztron_debug::draw_circle( targetloc, 24, ( 1, 0, 0 ), undefined, undefined, 4 );
    
    if ( isdefined( targetloc ) )
    {
        thread ztron_enemy_ai::function_83baeab9d0850baa( targetloc, 1, 1, 4 );
    }
    else
    {
        thread ztron_enemy_ai::function_83baeab9d0850baa( self.ztron.original_origin, 1, 1, 4 );
    }
    
    utility::waittill_any_timeout( 8, "goal" );
    
    if ( self.var_361a087ab08adc1c == "super_sprint" )
    {
        nextspeed = ztron_enemy_ai::function_d1f9246886709b7f( self.var_361a087ab08adc1c );
        
        if ( nextspeed != self.var_361a087ab08adc1c && !self._blackboard.isunderwater )
        {
            ztron_enemy_ai::function_dac12bb77573fab( self.var_361a087ab08adc1c );
        }
    }
    
    self clearenemy();
    self.favoriteenemy = undefined;
    ztron_enemy_ai::function_29bbc6846013b71b();
    
    if ( isdefined( self.favoriteenemy ) )
    {
        self getenemyinfo( self.favoriteenemy );
    }
    
    val::reset_all( "antiKiteBoost" );
    thread function_70318318601711cb( 20 );
}

// Namespace ztron_ai_zombie
// Params 0
// Checksum 0xf9a51ab4, Offset: 0x3bfd
// Size: 0x6d
function function_91957a6751e630bf()
{
    self notify( #"hash_34c9d8365d4527f" );
    self endon( #"hash_34c9d8365d4527f" );
    self waittill( #"death" );
    level.ztron.var_316dc0679575bf4d = int( clamp( level.ztron.var_316dc0679575bf4d - 1, 0, level.ztron.var_316dc0679575bf4d ) );
}

// Namespace ztron_ai_zombie
// Params 1
// Checksum 0x398866dd, Offset: 0x3c72
// Size: 0x7d
function function_1871b28f38c68b14( carrier )
{
    self endon( #"death" );
    carrier waittill( #"death" );
    self unlink();
    self solid();
    impulse = ( anglestoforward( self.angles ) + ( 0, 0, 5 ) ) * 3;
    self physicslaunchserver( self.origin, impulse );
    self enableaimassist();
    thread ztron_hazard_barrel::function_e589d3e643949b6( 1, self );
}

// Namespace ztron_ai_zombie
// Params 1
// Checksum 0x684b488b, Offset: 0x3cf7
// Size: 0x53, Type: bool
function function_555a3760f7f13d53( ent )
{
    if ( !isagent( ent ) )
    {
        return false;
    }
    
    return ent.subclass == "zombie_base" || ent.subclass == "zombie_base_armored_light" || ent.subclass == "zombie_base_armored_heavy";
}

