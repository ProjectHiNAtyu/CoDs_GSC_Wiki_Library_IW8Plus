// scripts\mp\zm\ztron\ztron_enemy.gsc  (hash_318bf1750f5608d0.gscc) (size: 12183 Bytes / 0x2f97 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x28cb0e6 (42774758)
// size ...... 12183 (0x2f97)
// includes .. 20  (offset: 0x2e2f)
// strings ... 13  (offset: 0x2ecf)
// dev strs .. 3   (offset: 0x2f73)
// exports ... 30  (offset: 0x1fc3)
// cseg ...... 0x143 + 0x1e80 (0x1fc3)
// imports ... 83  (offset: 0x2473)
// animtree1 . 0   (offset: 0x2f97)
// animtree2 . 0   (offset: 0x2f97)
#using script_2498b7c75f1dee2d;
#using script_54a05cbb2455bc6f;
#using scripts\common\ai\aitypes\shared\zombie\zombie_damage;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\zombie_base\zombie_base_dismemberment;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\game_utility;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\ammomods\ammo_mod;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\zm_utility;
#using scripts\mp\zm\ztron\ztron_dev;
#using scripts\mp\zm\ztron\ztron_enemy_ai;
#using scripts\mp\zm\ztron\ztron_main;
#using scripts\mp\zm\ztron\ztron_meta_progression;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_utility;
#using scripts\mp\zm\ztron\ztron_weapon;

#namespace ztron_enemy;

// Namespace ztron_enemy
// Params 0
// Checksum 0x1c343da9, Offset: 0x161
// Size: 0x5a
function init()
{
    level.ztron.enemytypes = [];
    utility::registersharedfunc( #"zombie", #"health_scaling_get_subclass_health", &namespace_775af9b7afedb6d1::get_subclass_health );
    ztron_enemy_ai::init();
    level callback::add( #"on_ai_killed", &function_9238338f068b6568 );
    level thread function_8fd958e0a4986d81();
}

// Namespace ztron_enemy
// Params 0
// Checksum 0xee730a21, Offset: 0x1c3
// Size: 0x202
function function_8fd958e0a4986d81()
{
    self notify( #"hash_434d55ca3b086bdc" );
    self endon( #"hash_434d55ca3b086bdc" );
    level endon( #"ztron_game_is_over" );
    
    while ( true )
    {
        level.ztron.zombies = getaiarray( zm_utility::get_zombie_team() );
        
        foreach ( ally in level.players )
        {
            if ( !isdefined( ally.ztron ) )
            {
                continue;
            }
            
            ally.ztron.load = 0;
        }
        
        foreach ( zombie in level.ztron.zombies )
        {
            foreach ( ally in level.players )
            {
                if ( !isdefined( ally.ztron ) )
                {
                    continue;
                }
                
                if ( zombie.enemy === ally )
                {
                    ally.ztron.load++;
                    break;
                }
            }
        }
        
        waitframe();
    }
}

// Namespace ztron_enemy
// Params 0
// Checksum 0x13bf498e, Offset: 0x3cd
// Size: 0xe4
function reset_globals()
{
    level.ztron.enemypoi = [];
    level.ztron.var_6fdc39ee25e5365e = [];
    level.ztron.var_a593aa94dc733518 = undefined;
    level.ztron.zombie_base_speed = 0;
    
    if ( level.ztron.var_95d8c7a469393957 )
    {
        level.ztron.zombie_base_speed = 50;
    }
    
    level.ztron.var_f1569c16a29ffcbf = 90;
    level.ztron.kitedetector = 0;
    level.ztron.basic_zombie_def = function_96eea0d09d5640d1( "basic_zombie" );
    function_16b9e1ff92e4fb4( level.ztron.basic_zombie_def );
}

// Namespace ztron_enemy
// Params 0
// Checksum 0xe494f316, Offset: 0x4b9
// Size: 0x21
function main()
{
    self notify( #"hash_edf3de87b334ae8f" );
    self endon( #"hash_edf3de87b334ae8f" );
    reset_globals();
}

// Namespace ztron_enemy
// Params 1
// Checksum 0xb0cc2451, Offset: 0x4e2
// Size: 0x13
function function_9238338f068b6568( params )
{
    game_utility_common::removefromcharactersarray();
}

// Namespace ztron_enemy
// Params 1
// Checksum 0x1485eb1d, Offset: 0x4fd
// Size: 0x54
function function_16b9e1ff92e4fb4( enemydef )
{
    if ( !arraycontains( level.ztron.var_6fdc39ee25e5365e, enemydef ) )
    {
        level.ztron.var_6fdc39ee25e5365e[ level.ztron.var_6fdc39ee25e5365e.size ] = enemydef;
    }
}

// Namespace ztron_enemy
// Params 1
// Checksum 0x15691eff, Offset: 0x559
// Size: 0x59, Type: bool
function function_13596b7af6f5a4b5( enemydef )
{
    if ( arraycontains( level.ztron.var_6fdc39ee25e5365e, enemydef ) )
    {
        level.ztron.var_6fdc39ee25e5365e = arrayremove( level.ztron.var_6fdc39ee25e5365e, enemydef );
        return true;
    }
    
    return false;
}

// Namespace ztron_enemy
// Params 11
// Checksum 0x8198aee1, Offset: 0x5bb
// Size: 0x23a
function function_6126d573e5775143( subclass, name, init, think, canspawn, unlockround = 0, chance = 100, boss = 0, grpmin, grpmax, cooldownsec = 60 )
{
    enemydef = spawnstruct();
    enemydef.subclass = subclass;
    enemydef.name = name;
    enemydef.spawn_chance = chance;
    enemydef.original_chance = chance;
    enemydef.unlockround = unlockround;
    enemydef.hintshown = 0;
    
    if ( !isdefined( init ) )
    {
        init = &ztron_enemy_ai::function_3ae4286f85e2ef9e;
    }
    
    if ( !isdefined( think ) )
    {
        think = &ztron_enemy_ai::function_9a34c1b86e0eec7c;
    }
    
    if ( !isdefined( canspawn ) )
    {
        canspawn = &ztron_enemy_ai::function_6f58a8788ecd236d;
    }
    
    enemydef.initfunc = init;
    enemydef.thinkFunc = think;
    enemydef.var_819742026172c51 = canspawn;
    enemydef.boss = boss;
    enemydef.grpmin = grpmin;
    enemydef.grpmax = grpmax;
    enemydef.cooldownms = cooldownsec * 1000;
    enemydef.var_768612c84c1769ce = int( enemydef.cooldownms * 0.15 );
    enemydef.var_de74cae86cad2e9b = 0;
    
    if ( enemydef.var_768612c84c1769ce <= 0 )
    {
        enemydef.var_768612c84c1769ce = 1000;
    }
    
    enemydef.var_c741bb4a0e1a028f = 0;
    level.ztron.enemytypes[ level.ztron.enemytypes.size ] = enemydef;
    
    /#
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::function_cd4e263c1f3018ae( enemydef.name, "<dev string:x30>" + enemydef.name, &debug_spawnai );
        devgui::function_77df7fe7dd273e10();
    #/
    
    return enemydef;
}

// Namespace ztron_enemy
// Params 2
// Checksum 0x30571e3d, Offset: 0x7fe
// Size: 0x46
function function_5c6c05b8c9688841( defname, chance = 10 )
{
    enemy_def = function_96eea0d09d5640d1( defname );
    
    if ( isdefined( enemy_def ) )
    {
        enemy_def.chance = chance;
    }
}

// Namespace ztron_enemy
// Params 2
// Checksum 0x81783c65, Offset: 0x84c
// Size: 0x130
function function_be8fbd1178946a9( roundnumber, reset = 0 )
{
    if ( reset )
    {
        level.ztron.var_6fdc39ee25e5365e = [];
    }
    
    foreach ( entry in level.ztron.enemytypes )
    {
        if ( entry.unlockround == -1 )
        {
            continue;
        }
        
        if ( entry.unlockround <= roundnumber )
        {
            enemydef = function_96eea0d09d5640d1( entry.name );
            
            if ( !isdefined( level.ztron.var_fa3d366b636efdb1 ) || !arraycontains( level.ztron.var_fa3d366b636efdb1, enemydef ) )
            {
                function_16b9e1ff92e4fb4( enemydef );
            }
        }
    }
}

// Namespace ztron_enemy
// Params 1
// Checksum 0x9d254144, Offset: 0x984
// Size: 0xcd
function function_15d12af6ebc93bf0( roundnumber )
{
    foreach ( entry in level.ztron.enemytypes )
    {
        if ( entry.unlockround > roundnumber || entry.unlockround == -1 )
        {
            enemydef = function_96eea0d09d5640d1( entry.name );
            function_13596b7af6f5a4b5( enemydef );
        }
    }
}

// Namespace ztron_enemy
// Params 1
// Checksum 0x400fc3da, Offset: 0xa59
// Size: 0x81
function function_c432c192a10985ad( enemyname )
{
    if ( !isdefined( level.ztron.var_fa3d366b636efdb1 ) )
    {
        level.ztron.var_fa3d366b636efdb1 = [];
    }
    
    enemydef = function_96eea0d09d5640d1( enemyname );
    
    if ( function_13596b7af6f5a4b5( enemydef ) )
    {
        level.ztron.var_fa3d366b636efdb1[ level.ztron.var_fa3d366b636efdb1.size ] = enemydef;
    }
}

// Namespace ztron_enemy
// Params 1
// Checksum 0x861f8a9, Offset: 0xae2
// Size: 0x81
function function_103f4348c83c32ce( enemyname )
{
    enemydef = function_96eea0d09d5640d1( enemyname );
    
    if ( isdefined( level.ztron.var_fa3d366b636efdb1 ) && arraycontains( level.ztron.var_fa3d366b636efdb1, enemydef ) )
    {
        level.ztron.var_fa3d366b636efdb1 = arrayremove( level.ztron.var_fa3d366b636efdb1, enemydef );
    }
}

// Namespace ztron_enemy
// Params 0
// Checksum 0xb77b4c59, Offset: 0xb6b
// Size: 0x17
function function_2f739d85a1ff88c0()
{
    level.ztron.var_fa3d366b636efdb1 = [];
}

/#

    // Namespace ztron_enemy
    // Params 1
    // Checksum 0xab123edf, Offset: 0xb8a
    // Size: 0x6d, Type: dev
    function debug_spawnai( params )
    {
        enemyname = params[ 0 ];
        enemydef = function_96eea0d09d5640d1( enemyname );
        function_77e1bf43b991b4a( enemydef, 1, level.players[ 0 ].origin, 0, undefined, undefined, undefined, level.ztron.active_arena, undefined, undefined, 1, 1 );
    }

#/

// Namespace ztron_enemy
// Params 1
// Checksum 0x44a56d3e, Offset: 0xbff
// Size: 0x9a
function function_96eea0d09d5640d1( name )
{
    foreach ( def in level.ztron.enemytypes )
    {
        if ( def.name === name )
        {
            return def;
        }
    }
}

// Namespace ztron_enemy
// Params 10
// Checksum 0xd84c704d, Offset: 0xca1
// Size: 0x15d
function function_4fc9fecf51ad535( var_71c2b26838e90f44, count = 10, targetpoint, radius = 0, var_55a3da08bd6a9a23, enemy, noteent, arena, groupid, var_94e75dccfe9c1c17 )
{
    queueitem = spawnstruct();
    queueitem.var_71c2b26838e90f44 = var_71c2b26838e90f44;
    queueitem.targetpoint = targetpoint;
    queueitem.radius = radius;
    queueitem.count = count;
    queueitem.enemy = enemy;
    queueitem.notifyent = noteent;
    queueitem.groupid = groupid;
    
    if ( var_94e75dccfe9c1c17 != -1 )
    {
        queueitem.var_ec438927b354793 = ( var_94e75dccfe9c1c17 ?? gettime() ) + 3000;
    }
    
    queueitem.arena = arena;
    
    if ( !isdefined( arena ) && !isdefined( level.ztron.current_bonus_room ) && ztron_main::function_4da200e9b8d58a3c() == 1 )
    {
        queueitem.arena = level.ztron.active_arena;
    }
    
    return queueitem;
}

// Namespace ztron_enemy
// Params 13
// Checksum 0x8b6e6179, Offset: 0xe07
// Size: 0x11b
function function_77e1bf43b991b4a( var_71c2b26838e90f44, count = 10, targetpoint, radius = 0, var_55a3da08bd6a9a23, enemy, noteent, arena, groupid, var_94e75dccfe9c1c17, var_4ab1eeb47f326f98 = 0, var_4d9f7c49b149f28d = 0, var_ae273b54cc493f32 = 0 )
{
    queueitem = function_4fc9fecf51ad535( var_71c2b26838e90f44, count, targetpoint, radius, var_55a3da08bd6a9a23, enemy, noteent, arena, groupid, var_94e75dccfe9c1c17 );
    ai = spawnai( queueitem, targetpoint, var_4ab1eeb47f326f98, var_4d9f7c49b149f28d );
    
    if ( !isdefined( ai ) && var_ae273b54cc493f32 )
    {
        queueitem = function_4fc9fecf51ad535( level.ztron.basic_zombie_def, count, targetpoint, radius, var_55a3da08bd6a9a23, enemy, noteent, arena, groupid, var_94e75dccfe9c1c17 );
        ai = spawnai( queueitem, targetpoint, var_4ab1eeb47f326f98, var_4d9f7c49b149f28d );
    }
    
    return ai;
}

// Namespace ztron_enemy
// Params 4
// Checksum 0xef5f5564, Offset: 0xf2b
// Size: 0x8c
function spawnai( spawnparams, spawnloc, var_4ab1eeb47f326f98 = 0, var_4d9f7c49b149f28d = 0 )
{
    ai = function_acee91c445fafd29( spawnparams.var_71c2b26838e90f44, spawnloc, spawnparams.enemy, undefined, var_4ab1eeb47f326f98, var_4d9f7c49b149f28d );
    
    if ( isdefined( ai ) )
    {
        /#
            ztron_dev::function_e8706d29bfd056a0( spawnparams.var_71c2b26838e90f44.name );
        #/
    }
    
    return ai;
}

// Namespace ztron_enemy
// Params 4
// Checksum 0x4c945ffa, Offset: 0xfc0
// Size: 0x15e
function function_565c759a8777bc7d( var_71c2b26838e90f44, spawn_spot, enemy, target )
{
    if ( !isdefined( self.ztron ) )
    {
        self.ztron = spawnstruct();
    }
    
    self.ztron.var_71c2b26838e90f44 = var_71c2b26838e90f44;
    self.ztron.spawnspot = spawn_spot;
    self.target = target;
    
    if ( isdefined( enemy ) && !enemy.ignoreme && !ztron_player_utility::function_baf22e7b5779b533( enemy ) )
    {
        if ( issentient( enemy ) )
        {
            self.favoriteenemy = enemy;
        }
        
        self getenemyinfo( enemy );
    }
    
    self.agent_damage_callback = &function_2d459ce49ce8b45e;
    initfunc = var_71c2b26838e90f44.initfunc;
    
    if ( !isdefined( initfunc ) )
    {
        initfunc = &ztron_enemy_ai::function_3ae4286f85e2ef9e;
    }
    
    self [[ initfunc ]]();
    self.ztron_initialized = 1;
    
    if ( isdefined( self.spawnloc ) )
    {
        if ( isai( self ) )
        {
            self forceteleport( self.spawnloc.origin, self.spawnloc.angles );
        }
    }
    
    if ( isdefined( var_71c2b26838e90f44.thinkFunc ) )
    {
        self thread [[ var_71c2b26838e90f44.thinkFunc ]]();
    }
    
    thread endgamewatcher();
}

// Namespace ztron_enemy
// Params 0
// Checksum 0xdd332619, Offset: 0x1126
// Size: 0x2e
function endgamewatcher()
{
    self endon( #"death" );
    level utility::flag_wait( "ztron_game_is_over" );
    self setlookatpos( ( 0, 0, 0 ) );
}

// Namespace ztron_enemy
// Params 7
// Checksum 0xb8b3a7f7, Offset: 0x115c
// Size: 0x1aa
function function_acee91c445fafd29( var_71c2b26838e90f44, spawn_spot, enemy, target, var_4ab1eeb47f326f98 = 0, var_4d9f7c49b149f28d = 0, var_ec53a18db3e4e78c = 0 )
{
    if ( !isdefined( var_71c2b26838e90f44 ) )
    {
        assertmsg( "<dev string:x3f>" );
        return;
    }
    
    if ( !var_4ab1eeb47f326f98 )
    {
        if ( !ztron_enemy_ai::function_89146abeaa5fc021( var_71c2b26838e90f44 ) )
        {
            return;
        }
    }
    
    if ( var_71c2b26838e90f44.spawn_chance < 100 && !var_4d9f7c49b149f28d )
    {
        chance = var_71c2b26838e90f44.spawn_chance;
        
        if ( [[ var_71c2b26838e90f44.var_819742026172c51 ]]( chance ) == 0 )
        {
            return;
        }
        
        if ( var_71c2b26838e90f44.cooldownms > 0 && ztron_enemy_ai::function_8e7da9909f1b2e92( var_71c2b26838e90f44 ) )
        {
            return;
        }
    }
    
    angles = ( 0, 0, 0 );
    
    if ( isdefined( enemy ) )
    {
        angles = vectortoangles( enemy.origin - spawn_spot );
    }
    
    ai = agent_manager::spawn_agent( var_71c2b26838e90f44.subclass, spawn_spot, angles, zm_utility::get_zombie_team() );
    
    if ( isdefined( ai ) )
    {
        if ( var_71c2b26838e90f44.cooldownms )
        {
            var_71c2b26838e90f44.var_c741bb4a0e1a028f = gettime() + var_71c2b26838e90f44.cooldownms + randomintrange( 0, var_71c2b26838e90f44.var_768612c84c1769ce );
        }
        
        ai.var_71c2b26838e90f44 = var_71c2b26838e90f44;
        
        if ( var_ec53a18db3e4e78c )
        {
            ai.var_ec53a18db3e4e78c = spawn_spot;
        }
        
        ai function_565c759a8777bc7d( var_71c2b26838e90f44, spawn_spot, enemy, target );
    }
    
    return ai;
}

// Namespace ztron_enemy
// Params 2, eflags: 0x4
// Checksum 0xf2741363, Offset: 0x130f
// Size: 0x90, Type: bool
function private is_explosive_damage( smeansofdeath, weapon )
{
    if ( smeansofdeath == "MOD_EXPLOSIVE" || smeansofdeath == "MOD_EXPLOSIVE_BULLET" || smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_PROJECTILE_SPLASH" )
    {
        return true;
    }
    
    if ( isdefined( weapon ) )
    {
        if ( weapon.basenamehash == %"sat_la_ztronpable3_mp" )
        {
            return true;
        }
        
        if ( weapon.basenamehash == %"sat_la_ztronwarmachine_mp" )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace ztron_enemy
// Params 14
// Checksum 0x6919aa68, Offset: 0x13a8
// Size: 0x927
function function_2d459ce49ce8b45e( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon, poisedamage )
{
    time = gettime();
    playerattacker = ztron_util::function_da4039e4c338f818( eattacker );
    idamage = eattacker.meleedamage ?? idamage;
    
    if ( isdefined( objweapon ) && issubstr( objweapon.basename, "fated_chicken" ) )
    {
        if ( eattacker ztron_fate::function_c93d5c389d532c34( 3, 4 ) || eattacker.ztron.upgradeMask & 549755813888 )
        {
            idamage = int( idamage * 1.35 );
        }
    }
    
    if ( isplayer( eattacker ) && sweapon.basenamehash != %"none" )
    {
        if ( sweapon.basenamehash == %"energy_mine" && !self.ztron.boss && self.ztron.var_ae555ddb6e30a0b0 )
        {
            self.forceannihilate = 1;
            idamage = self.health;
        }
        
        if ( sweapon.basenamehash == %"mary_paris_zm" && !self.ztron.boss && self.ztron.var_ae555ddb6e30a0b0 )
        {
            idamage = self.health;
        }
        
        if ( sweapon.basenamehash == %"dark_flare_zm" && !self.ztron.boss && self.ztron.var_ae555ddb6e30a0b0 )
        {
            self.forceannihilate = 1;
            idamage = self.health;
        }
        
        if ( sweapon.basenamehash == %"sat_remote_robot_arm_gun_mp_ztron" )
        {
            if ( !self.ztron.boss )
            {
                idamage = 250;
                
                if ( self.ztron.var_ae555ddb6e30a0b0 )
                {
                    roll = randomint( 100 );
                    
                    if ( roll < 25 )
                    {
                        self.forceannihilate = 1;
                        idamage = self.health;
                    }
                    else if ( roll < 75 )
                    {
                        if ( !zombie_knockdown::function_19d6107cb6bdff5c() )
                        {
                            zombie_knockdown::function_6fc167d4a3590991( vpoint, 500, 40 );
                        }
                        
                        ztron_weapon::function_eefebf1b1fc7b2ce( self, idamage );
                        ztron_weapon::weapon_dismember_legs( self, eattacker );
                        thread ztron_util::function_ea0a0be5c5468c48( randomint( 8 ) + 1 );
                    }
                }
            }
            else
            {
                idamage = 125;
            }
        }
        else if ( sweapon.basenamehash == %"sat_la_mutant_injection_cannon_mp" )
        {
            idamage = 1000;
        }
        else
        {
            if ( !eattacker ztron_fate::hasfate( 1 ) )
            {
                if ( eattacker.ztron.upgradeMask & 8388608 && is_explosive_damage( smeansofdeath, sweapon ) )
                {
                    idamage = int( idamage * 1.25 );
                }
            }
            
            if ( sweapon.basenamehash == %"sat_lm_ztronlmg_mp" )
            {
                if ( eattacker.ztron.upgradeMask & 16777216 )
                {
                    idamage = int( idamage * 1.15 );
                }
                
                if ( eattacker.ztron.upgradeMask & 33554432 )
                {
                    idamage = int( idamage * 1.15 );
                }
            }
            
            if ( eattacker.ztron.upgradeMask & 131072 )
            {
                idamage = int( idamage * 1.25 );
            }
            
            if ( eattacker ztron_fate::function_c93d5c389d532c34( 1, 2 ) && sweapon.basenamehash == %"sat_lm_ztrondeathmachine_mp" )
            {
                idamage = int( idamage * 1.3 );
            }
            
            if ( eattacker.ztron.upgradeMask & 34359738368 && sweapon.basenamehash == %"sat_lm_ztrondeathmachine_mp" )
            {
                idamage = int( idamage * 1.3 );
            }
            
            idamage = int( idamage * ( 1 + 0.05 * namespace_4f98d1d7dc3196d::function_996793ae2b9b6a3c( eattacker, "deadshot" ) ) );
        }
    }
    
    damage_multiplier = 1;
    
    if ( isdefined( eattacker.damage_multiplier ) )
    {
        damage_multiplier = eattacker.damage_multiplier;
    }
    
    if ( isdefined( einflictor.damage_multiplier ) )
    {
        damage_multiplier = einflictor.damage_multiplier;
    }
    
    if ( damage_multiplier != 1 )
    {
        idamage = int( idamage * damage_multiplier );
    }
    
    if ( idamage >= self.health )
    {
        var_4cad834b06fa1d32 = self.forceannihilate;
    }
    
    if ( isdefined( playerattacker ) )
    {
        if ( isdefined( playerattacker.ztron.var_6665afa32a182ee0 ) )
        {
            if ( time < playerattacker.ztron.var_6665afa32a182ee0 )
            {
                var_4cad834b06fa1d32 = 1;
                
                if ( self.lifecount )
                {
                    self.lifecount = 0;
                }
            }
            else
            {
                playerattacker.ztron.var_6665afa32a182ee0 = undefined;
            }
        }
        
        if ( self.teamshifted || self.team == playerattacker.team )
        {
            return 0;
        }
    }
    
    dmg_struct = zombie_damage::build_damage_struct( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon );
    element = zombie_damage::get_element( dmg_struct.objweapon, dmg_struct.eattacker, dmg_struct.smeansofdeath );
    
    if ( smeansofdeath == "MOD_RIFLE_BULLET" && isdefined( element ) && !self.elementalweakness[ element ] )
    {
        element = "none";
    }
    
    dmg_struct.displaynumber = 1;
    zombie_damage::check_damaged_armor( dmg_struct );
    zombie_damage::try_damage_metabone( dmg_struct );
    zombie_damage::function_1f965cbbc7f5d5e7( dmg_struct );
    function_639314bda2a9f068( dmg_struct );
    function_5a809bd8d74f9fa0( dmg_struct );
    function_a0c9f833dce0bf81( dmg_struct );
    
    if ( eattacker.var_184c25daff35740e )
    {
        dmg_struct.idamage = 0;
        dmg_struct.displaynumber = 0;
    }
    
    if ( element != "none" )
    {
        dmg_struct.idamage = int( dmg_struct.idamage * 1.5 );
    }
    
    completeweaponname = getcompleteweaponname( sweapon );
    
    if ( ( function_ec5e321fe43d2fc( sweapon ) || var_4cad834b06fa1d32 ) && !self.ztron.boss )
    {
        dmg_struct.idamage = int( self.maxhealth + 187 );
        self.forceannihilate = 1;
    }
    else if ( isdefined( level.ztron.specialimpact[ completeweaponname ] ) )
    {
        adddamage = level [[ level.ztron.specialimpact[ completeweaponname ] ]]( self, dmg_struct.idamage, eattacker, vdir, vpoint, smeansofdeath, sweapon );
        
        if ( isdefined( adddamage ) )
        {
            dmg_struct.idamage += int( adddamage );
        }
    }
    
    dmg_struct.idamage = dmg_struct.idamage >= self.health ? self.health : dmg_struct.idamage;
    displayplayer = playerattacker;
    
    if ( !isdefined( displayplayer ) )
    {
        if ( isplayer( self.target ) )
        {
            displayplayer = self.target;
        }
        
        if ( !isdefined( displayplayer ) )
        {
            displayplayer = ztron_player_utility::function_55e798aacb02a82f( self.origin );
        }
    }
    
    if ( isdefined( displayplayer ) && displayplayer isconnected() && dmg_struct.displaynumber && !self.var_a436a6789de5017c )
    {
        var_82f3e5d16cf998d7 = vpoint;
        
        if ( !isdefined( vpoint ) || distancesquared( self.origin, vpoint ) > squared( 128 ) )
        {
            var_82f3e5d16cf998d7 = self.origin + ( 0, 0, 32 );
        }
        
        ztron_util::function_eb8ba16055d6da7c( displayplayer, self, shitloc, smeansofdeath, sweapon, dmg_struct.idamage, var_82f3e5d16cf998d7, undefined, element, 0, dmg_struct.var_4f9d5587bf9a2b1e, undefined, level.var_de79f65048631206[ element ] );
    }
    
    if ( isplayer( playerattacker ) && level.gametypebundle.var_451ef421f1fcc5ad )
    {
        ammo_mod::default_ai_response( dmg_struct );
    }
    
    callback::callback( "on_zombie_ai_damaged", dmg_struct );
    self.lastattacker = eattacker;
    self.lastdamagedtime = time;
    return int( dmg_struct.idamage );
}

// Namespace ztron_enemy
// Params 1
// Checksum 0x53288294, Offset: 0x1cd8
// Size: 0x44
function function_a0c9f833dce0bf81( dmg_struct )
{
    if ( self.ztron.boss && dmg_struct.idamage > 1000 )
    {
        dmg_struct.idamage = 1000;
    }
}

// Namespace ztron_enemy
// Params 1
// Checksum 0xa20db2eb, Offset: 0x1d24
// Size: 0xb2
function function_639314bda2a9f068( dmg_struct )
{
    if ( self.ztron.boss && ( !isdefined( dmg_struct.eattacker ) || dmg_struct.eattacker vehicle::ishelicopter() ) )
    {
        dmg_struct.idamage = 0;
        dmg_struct.displaynumber = 0;
    }
    
    if ( !self.nogib && isdefined( dmg_struct.eattacker ) && dmg_struct.eattacker vehicle::ishelicopter() && dmg_struct.smeansofdeath == "MOD_CRUSH" )
    {
        namespace_b76ff2659823e89d::function_6c318bca7bb326e7( 1 );
    }
}

// Namespace ztron_enemy
// Params 1
// Checksum 0x53415c40, Offset: 0x1dde
// Size: 0x77
function function_5a809bd8d74f9fa0( dmg_struct )
{
    if ( self.ztron.boss && ( !isdefined( dmg_struct.eattacker ) || dmg_struct.eattacker vehicle::is_tank() ) && dmg_struct.smeansofdeath == "MOD_CRUSH" )
    {
        dmg_struct.idamage = 0;
        dmg_struct.displaynumber = 0;
    }
}

// Namespace ztron_enemy
// Params 1
// Checksum 0x39f6957e, Offset: 0x1e5d
// Size: 0x106
function function_72a544a5053399fb( enemyref )
{
    if ( isdefined( level.ztron.var_70fb254606790691 ) && isdefined( level.ztron.var_70fb254606790691[ enemyref ] ) )
    {
        return level.ztron.var_70fb254606790691[ enemyref ];
    }
    
    foreach ( def in level.ztron.slayer.var_59862ae09b8060ab )
    {
        if ( def.enemyref == enemyref && isdefined( def.tipref ) )
        {
            return def.tipref;
        }
    }
}

// Namespace ztron_enemy
// Params 2
// Checksum 0x70c8efa8, Offset: 0x1f6b
// Size: 0x58
function function_35cd7cda9fbadf39( enemyref, tipref )
{
    if ( !isdefined( level.ztron.var_70fb254606790691 ) )
    {
        level.ztron.var_70fb254606790691 = [];
    }
    
    level.ztron.var_70fb254606790691[ enemyref ] = tipref;
}

