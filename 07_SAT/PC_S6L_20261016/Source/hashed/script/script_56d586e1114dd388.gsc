// script_56d586e1114dd388  (hash_56d586e1114dd388.gscc) (size: 16938 Bytes / 0x422a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1dcfc274 (500154996)
// size ...... 16938 (0x422a)
// includes .. 14  (offset: 0x3d96)
// strings ... 65  (offset: 0x3e06)
// dev strs .. 14  (offset: 0x4182)
// exports ... 32  (offset: 0x27ce)
// cseg ...... 0x422 + 0x23ac (0x27ce)
// imports ... 130 (offset: 0x2cce)
// animtree1 . 0   (offset: 0x422a)
// animtree2 . 0   (offset: 0x422a)
#using script_16ea1b94f0f381b3;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\metabone;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;

#namespace zombie_weyward_stinger;

// Namespace zombie_weyward_stinger
// Params 1, eflags: 0x4
// Checksum 0xcf4d2aa3, Offset: 0x440
// Size: 0x36
function private function_498159e8be1ea685( params )
{
    callback::get_template( self.animsetname ) callback::add( "killed_body_cloned", &play_death_fx );
    
    /#
        init_slam_devgui();
    #/
}

// Namespace zombie_weyward_stinger
// Params 1
// Checksum 0xa7314470, Offset: 0x47e
// Size: 0x16f
function function_3cf2f7937a6dab9b( taskid )
{
    assert( isdefined( self.zombieaisetting ) );
    zombie_init::function_5d23979c4c7c9a52( self.zombieaisetting );
    callback::add( "on_first_ai_init", &function_498159e8be1ea685 );
    callback::add( "on_zombie_ai_spawned", &function_a415b9401279a420 );
    zombie_utils::function_dfae6a5bd222c586( &function_b614d278d9251e7e );
    self.nocorpse = undefined;
    self.noragdoll = 1;
    self.script_noragdoll = 1;
    self.allowstrafe = 0;
    self.var_13518fb33ec73cc = 30;
    self.prevent_knockdown = 1;
    self function_10006c8216ad87fd( "focus_behaviors", "fsm", "no_focus" );
    self enableavoidance( 0, 0 );
    self enabletraversals( 0 );
    self function_66dc8b6ae969f66d( 1 );
    toggle_health_and_icon( 0, "stinger_spawn" );
    toggle_health_and_icon( 1, "stinger_spawn", 1.5 );
    val::set( "zombie_weyward_stinger_init", "high_net_lod", 1 );
    self function_43a971093c992365( 1 );
    self function_7f8988ce63c1623d( 0 );
    utility::delaycallendon( 3, "death", &function_7f8988ce63c1623d, 1 );
    self.var_e1adedc4a4a5146d = function_aafd9c2a00b86dba( self, "custom_default_on" );
    self.retract_playback_rate = 1;
    self.var_30b5e6fc9ca7628e = 0;
    self function_dc61b81ec6b63cc4( 1 );
    self.b_ignore_death_perception = 1;
    init_slam();
    thread function_772be7adaff22671();
    return anim.success;
}

// Namespace zombie_weyward_stinger
// Params 1, eflags: 0x4
// Checksum 0x1bad91ec, Offset: 0x5f6
// Size: 0xa67
function private function_b614d278d9251e7e( params )
{
    var_fa73e4e06a81b041 = 0.8;
    var_cee395575559ddb9 = 3;
    var_66f4771e76a64f91 = 0.6;
    var_c5e0225cba147a92 = 0.8;
    var_d572e4d281047f87 = getdvarfloat( @"hash_94075972f5f6b3ee", 1 );
    var_91cfcc98a64c39a2 = getdvarfloat( @"hash_5916a23daf02ed15", 0.75 );
    var_b631402aa8a16af1 = getdvarfloat( @"hash_514c5538cf96596e", 1 );
    var_f8365038e8bfe78a = getdvarfloat( @"hash_49c50ed78513bafd", 1 );
    var_a49aaaef48e2de2b = getdvarfloat( @"hash_fdd46bdcb209dd33", 1.25 );
    var_f0edd71928ca1b53 = getdvarfloat( @"hash_a2a12c2ce2dc300f", 1.25 );
    var_4a0cd941a5b615d1 = getdvarfloat( @"hash_3dcc1421964e38a4", 1 );
    var_23861e4bdfd87d52 = getdvarfloat( @"hash_6eddb2db8816e90b", 1 );
    var_5ed48d2a95f6cd41 = getdvarfloat( @"hash_12e072680b6b0074", 1 );
    var_a3793f5fff89354d = getdvarfloat( @"hash_4e53cc711234ec60", 1 );
    var_aae5e4d2b6570d56 = getdvarfloat( @"hash_6993290bb10c3cdf", 1.5 );
    var_3f56cee67435a21e = getdvarfloat( @"hash_601ba2c837559fb7", 1 );
    var_1b8b28636737013e = getdvarfloat( @"hash_75796915dd64df2b", 1 );
    var_b614da05a3be6674 = getdvarfloat( @"hash_226d0d9e4a594b4f", 1 );
    var_34c2c73f8deec447 = getdvarfloat( @"hash_338a39113d1610cb", 1 );
    var_3eb6b6a42968b839 = getdvarfloat( @"hash_df79382d2e270573", 1 );
    var_807588323e023bd7 = getdvarfloat( @"hash_b7ed0a8b3485a063", 1 );
    var_522a1d4abc62ce0f = getdvarfloat( @"hash_6dfc008fda240afb", 1 );
    var_eea9c218978c30f4 = getdvarfloat( @"hash_31bb50d1e6f3fb4c", 1 );
    var_b82b77be4fcfee13 = getdvarfloat( @"hash_d15e83076b227cd3", 1 );
    var_9e7bf7adf451bc2d = getdvarfloat( @"hash_67a19d321dff5e97", 1 );
    var_2557bd56e76450f8 = getdvarfloat( @"hash_fd8135d9b3f62d2c", 1 );
    var_68e86b21c8631912 = getdvarfloat( @"hash_dcae17070b24f130", 1 );
    var_29e58edec3b15252 = getdvarfloat( @"hash_9a804e2f16c85710", 1 );
    var_566f0c1cb686681a = getdvarfloat( @"hash_4a9ca93cf9910814", 1 );
    var_a431e097af9691a3 = getdvarfloat( @"hash_af171e21cd117cdf", 1 );
    var_c17444b1160dee5e = getdvarfloat( @"hash_c583ed9da9bf39f4", 1 );
    var_ca89c2ac79d513bd = getdvarfloat( @"hash_c6cd3d2269d9d57", 1 );
    var_83e7914eb22dcac7 = getdvarfloat( @"hash_1b7fc80b5b715173", 1 );
    var_2067935b2ea13ba = getdvarfloat( @"hash_48f2d4bb3dcf11dc", 1 );
    var_3b1f952caa88011e = getdvarfloat( @"hash_44b9b6b44c842486", 1 );
    var_49066afb05046adf = getdvarfloat( @"hash_111cfc842b86367b", 1.15 );
    damage = params.idamage;
    weakspotdata = metabone::get_metabone_metadata( params.metabonename, "Types_Weakspot" );
    armordata = metabone::get_metabone_metadata( params.metabonename, "Types_Armor" );
    is_wonder = weapon::iswonderweapon( params.sweapon );
    
    if ( utility::issharedfuncdefined( #"zombie", #"get_pap_level" ) && isdefined( params.sweapon ) && isplayer( params.eattacker ) )
    {
        paplevel = params.eattacker namespace_9d8e359c3b1041e5::function_1d4087075103b248( params.sweapon );
        
        if ( paplevel >= var_cee395575559ddb9 )
        {
            damage *= var_fa73e4e06a81b041;
        }
        
        if ( paplevel >= 4 )
        {
            damage *= var_66f4771e76a64f91;
        }
    }
    
    if ( utility::issharedfuncdefined( #"zombie", #"GetPlayerWeaponRarity" ) && isdefined( params.sweapon ) && isplayer( params.eattacker ) )
    {
        rarity = params.eattacker namespace_9d8e359c3b1041e5::getplayerweaponraritysharedfunc( params.sweapon );
        
        if ( rarity == 5 && !is_wonder )
        {
            damage *= var_c5e0225cba147a92;
        }
    }
    
    if ( is_wonder )
    {
        damage *= var_d572e4d281047f87;
        is_scarab_ww = issubstr( params.sweapon.basename, "sat_ww_scarab" );
        
        if ( is_scarab_ww )
        {
            damage *= var_91cfcc98a64c39a2;
            
            if ( armordata )
            {
                damage *= var_b631402aa8a16af1;
            }
            else if ( weakspotdata )
            {
                damage *= var_f8365038e8bfe78a;
            }
        }
        
        is_base_raygun = issubstr( params.sweapon.basename, "raygun" ) && !issubstr( params.sweapon.basename, "raygunmark2" );
        
        if ( is_base_raygun )
        {
            damage *= var_a49aaaef48e2de2b;
        }
        
        var_6afa0b0478dd143c = isdefined( params.sweapon.basename ) && issubstr( params.sweapon.basename, "raygunmark2" );
        
        if ( var_6afa0b0478dd143c )
        {
            damage *= var_f0edd71928ca1b53;
        }
    }
    
    if ( arraycontains( [ "mg" ], params.sweapon.classname ) )
    {
        damage *= var_a3793f5fff89354d;
    }
    else if ( arraycontains( [ "rifle" ], params.sweapon.classname ) )
    {
        damage *= var_5ed48d2a95f6cd41;
        isrhino = issubstr( params.sweapon.basename, "remote_robot_arm_gun" );
        
        if ( isrhino )
        {
            damage *= var_29e58edec3b15252;
        }
    }
    else if ( arraycontains( [ "sniper" ], params.sweapon.classname ) )
    {
        damage *= var_aae5e4d2b6570d56;
    }
    else if ( arraycontains( [ "smg" ], params.sweapon.classname ) )
    {
        damage *= var_3f56cee67435a21e;
        var_a0793264c690be57 = issubstr( params.sweapon.attachments, "akimbo_sm" );
        
        if ( var_a0793264c690be57 )
        {
            damage *= var_1b8b28636737013e;
        }
    }
    else if ( arraycontains( [ "rocketlauncher" ], params.sweapon.classname ) )
    {
        damage *= var_4a0cd941a5b615d1;
        var_7a37c47ccd17a049 = issubstr( params.sweapon.basename, "ks_m202" );
        
        if ( var_7a37c47ccd17a049 )
        {
            damage *= var_68e86b21c8631912;
        }
        
        ismanglercannon = issubstr( params.sweapon.basename, "mangler_cannon" );
        
        if ( ismanglercannon )
        {
            damage *= var_2557bd56e76450f8;
        }
        
        var_7fdedb034882a3ec = issubstr( params.sweapon.basename, "zm_dinj" );
        
        if ( var_7fdedb034882a3ec )
        {
            damage *= var_9e7bf7adf451bc2d;
        }
    }
    else if ( arraycontains( [ "grenade" ], params.sweapon.classname ) )
    {
        damage *= var_2067935b2ea13ba;
    }
    else if ( arraycontains( [ "turret" ], params.sweapon.classname ) )
    {
        damage *= var_b82b77be4fcfee13;
    }
    else if ( arraycontains( [ "spread" ], params.sweapon.classname ) )
    {
        damage *= var_23861e4bdfd87d52;
    }
    
    if ( params.smeansofdeath == "MOD_MELEE" || params.sweapon.ismelee )
    {
        damage *= getdvarfloat( @"hash_bbb2abe1a3014b6d", var_b614da05a3be6674 );
    }
    
    if ( issubstr( params.sweapon.basename, "ks_smartgun" ) )
    {
        damage *= var_566f0c1cb686681a;
    }
    
    if ( issubstr( params.sweapon.basename, "warmachine" ) )
    {
        damage *= var_807588323e023bd7;
    }
    else if ( issubstr( params.sweapon.basename, "deathmachine" ) )
    {
        damage *= var_522a1d4abc62ce0f;
    }
    else if ( issubstr( params.sweapon.basename, "handcannon" ) )
    {
        damage *= var_eea9c218978c30f4;
    }
    
    if ( issubstr( params.sweapon.basename, "rcxd" ) )
    {
        damage *= var_34c2c73f8deec447;
    }
    
    if ( issubstr( params.sweapon.basename, "remote_turret" ) )
    {
        damage *= var_3eb6b6a42968b839;
    }
    
    if ( issubstr( params.sweapon.basename, "dark_flare" ) )
    {
        damage *= var_a431e097af9691a3;
    }
    
    if ( issubstr( params.sweapon.basename, "energy_mine" ) )
    {
        damage *= var_c17444b1160dee5e;
    }
    
    if ( issubstr( params.sweapon.basename, "tesla_storm" ) )
    {
        damage *= var_ca89c2ac79d513bd;
    }
    
    if ( issubstr( params.sweapon.basename, "wiley_fox_zm" ) )
    {
        damage *= var_83e7914eb22dcac7;
    }
    
    if ( issubstr( params.sweapon.basename, "blackhole_bomb" ) )
    {
        damage *= var_3b1f952caa88011e;
    }
    
    if ( self.empowered && params.biscritical )
    {
        damage *= var_49066afb05046adf;
    }
    
    return int( damage );
}

// Namespace zombie_weyward_stinger
// Params 1, eflags: 0x4
// Checksum 0x6955088f, Offset: 0x1066
// Size: 0x6e
function private function_a415b9401279a420( params )
{
    self endon( #"death" );
    utility::waittill_any_timeout( level.framedurationseconds, "post_spawn" );
    ai::set_ai_max_health( int( self.maxhealth * level.s_scarab_boss.var_74e6b568b8bac135 ) );
    self.health = self.maxhealth;
    function_207a49d4d497b14a();
}

// Namespace zombie_weyward_stinger
// Params 0, eflags: 0x4
// Checksum 0xa55edbd8, Offset: 0x10dc
// Size: 0x13e
function private function_207a49d4d497b14a()
{
    knockback_radius = getdvarfloat( @"hash_e452695bffc039d5", 200 );
    
    if ( knockback_radius <= 0 )
    {
        return;
    }
    
    targets = getplayersandaiarrayinradius( self.origin, knockback_radius );
    
    foreach ( target in targets )
    {
        if ( target == self || !isalive( target ) )
        {
            continue;
        }
        
        if ( isplayer( target ) )
        {
            if ( target.team == self.team )
            {
                continue;
            }
            
            function_cc9f789658cc0d4d( target, self.origin, 1 );
            continue;
        }
        
        if ( isai( target ) && target.team === self.team && target.aicategory === "normal" )
        {
            target zombie_knockdown::function_6fc167d4a3590991( self.origin );
        }
    }
}

// Namespace zombie_weyward_stinger
// Params 0
// Checksum 0x55750fc1, Offset: 0x1222
// Size: 0x47
function get_death_anim_length()
{
    animindex = asm::asm_lookupanimfromalias( "death", "death" );
    xanim = asm::asm_getxanim( "death", animindex );
    animlength = getanimlength( xanim );
    return animlength;
}

// Namespace zombie_weyward_stinger
// Params 0
// Checksum 0x4da71873, Offset: 0x1272
// Size: 0x47
function get_retract_anim_length()
{
    animindex = asm::asm_lookupanimfromalias( "retract_intro", "0" );
    xanim = asm::asm_getxanim( "retract_intro", animindex );
    animlength = getanimlength( xanim );
    return animlength;
}

// Namespace zombie_weyward_stinger
// Params 1, eflags: 0x4
// Checksum 0xb9cda51a, Offset: 0x12c2
// Size: 0x96
function private play_death_fx( params )
{
    if ( self.var_e1adedc4a4a5146d )
    {
        destroynavobstacle( self.var_e1adedc4a4a5146d );
    }
    
    var_82a2c08adb268702 = 0.5;
    
    if ( isdefined( params.body ) )
    {
        params.body utility::function_7c10ea82c1e305b8( "death", "on" );
        params.body setcorpseforceremovetimer( var_82a2c08adb268702 );
        wait var_82a2c08adb268702;
        
        if ( isdefined( params.body ) )
        {
            params.body delete();
        }
    }
}

// Namespace zombie_weyward_stinger
// Params 0, eflags: 0x4
// Checksum 0x666ca308, Offset: 0x1360
// Size: 0x1d
function private init_slam()
{
    self.slam_cooldown_end = 0;
    self.var_1ca24f7b7ffaf88f = 0;
    thread sting_loop();
}

// Namespace zombie_weyward_stinger
// Params 0, eflags: 0x4
// Checksum 0xc477e4b3, Offset: 0x1385
// Size: 0x1e2
function private sting_loop()
{
    self endon( #"death" );
    waitframe();
    
    while ( true )
    {
        if ( asm_bb::bb_isanimscripted() || utility::ent_flag( "in_retract" ) )
        {
            waitframe();
            continue;
        }
        
        if ( self getaiblackboarddynamic( "in_wipe_attack_charge" ) > 0 )
        {
            waitframe();
            continue;
        }
        
        if ( gettime() < self.slam_cooldown_end )
        {
            waitframe();
            continue;
        }
        
        sting_range = getdvarfloat( @"hash_f7374a826663813e", 320 );
        
        if ( !self.var_3a6d16d8f8d2db33 )
        {
            var_77752db708129f6f = sting_range * 2.5;
            a_nearby_players = getplayersinradius( self.origin, var_77752db708129f6f );
            var_95ea2e1b79f04ba4 = [];
            
            foreach ( player in a_nearby_players )
            {
                if ( is_player_detectable( player ) )
                {
                    var_95ea2e1b79f04ba4[ var_95ea2e1b79f04ba4.size ] = player;
                }
            }
            
            var_49605f8a1c83819f = utility::get_array_of_closest( self.origin, var_95ea2e1b79f04ba4 )[ 0 ];
            
            if ( isdefined( var_49605f8a1c83819f ) )
            {
                sting_orient( var_49605f8a1c83819f );
            }
        }
        
        target = function_bb8747343be689b8( sting_range );
        
        if ( !isdefined( target ) )
        {
            waitframe();
            continue;
        }
        
        sting_orient( target );
        target_yaw = vectortoangles( target.origin - self.origin )[ 1 ];
        yaw_diff = abs( angleclamp180( target_yaw - self.angles[ 1 ] ) );
        
        if ( yaw_diff > 90 )
        {
            waitframe();
            continue;
        }
        
        thread do_sting( target );
        waitframe();
    }
}

// Namespace zombie_weyward_stinger
// Params 1, eflags: 0x4
// Checksum 0x1d960f5b, Offset: 0x156f
// Size: 0x8c, Type: bool
function private is_player_detectable( player )
{
    return isalive( player ) && !player.inlaststand && !player.ignoreme && !player.notarget && !player.aether_shroud_active && player getthreatbiasgroup() != "ignored_by_zombies" && player.sessionstate == "playing" && player.sessionstate != "spectator";
}

// Namespace zombie_weyward_stinger
// Params 1, eflags: 0x4
// Checksum 0xd77a0c51, Offset: 0x1604
// Size: 0x83
function private do_sting( target )
{
    self endon( #"death" );
    
    if ( !isalive( target ) )
    {
        return;
    }
    
    self.var_3a6d16d8f8d2db33 = 1;
    asm::function_7256f5ba459c840b( "slam" );
    thread sting_damage();
    thread function_3f79e45e9af9653d( target );
    cooldown_s = getdvarfloat( @"hash_58cde7d06fb63a66", 5 );
    self.slam_cooldown_end = gettime() + cooldown_s * 1000;
    self.var_3a6d16d8f8d2db33 = undefined;
}

// Namespace zombie_weyward_stinger
// Params 1, eflags: 0x4
// Checksum 0x5d49950c, Offset: 0x168f
// Size: 0x53
function private function_3f79e45e9af9653d( target )
{
    self endon( #"death" );
    self endon( #"sting_start" );
    self endon( #"wipe_attack_begin" );
    
    while ( isalive( target ) )
    {
        if ( !is_player_detectable( target ) )
        {
            return;
        }
        
        sting_orient( target );
        waitframe();
    }
}

// Namespace zombie_weyward_stinger
// Params 1, eflags: 0x4
// Checksum 0xcf816949, Offset: 0x16ea
// Size: 0x12c
function private function_bb8747343be689b8( range )
{
    if ( !isalive( self.enemy ) )
    {
        return;
    }
    
    predicted_pos = function_3c81a6f0731c35a4( self.enemy );
    in_range = distancesquared( self.origin, predicted_pos ) <= squared( range );
    
    /#
        if ( debug_slam() )
        {
            range_color = in_range ? ( 1, 0, 0 ) : ( 0, 1, 0 );
            sphere( self.origin, range, range_color );
            line( self.enemy.origin, predicted_pos, ( 1, 1, 0 ) );
            sphere( predicted_pos, 8, ( 1, 1, 0 ) );
            print3d( predicted_pos + ( 0, 0, 20 ), "<dev string:x24>" + int( distance( self.origin, predicted_pos ) ) + "<dev string:x2e>" + int( range ), range_color );
        }
    #/
    
    if ( !in_range )
    {
        return;
    }
    
    return self.enemy;
}

// Namespace zombie_weyward_stinger
// Params 1, eflags: 0x4
// Checksum 0x21d2d38, Offset: 0x181f
// Size: 0x332
function private sting_orient( target )
{
    if ( !isalive( target ) )
    {
        decel = getdvarfloat( @"hash_6eb3aa188c1db6e8", 3000 ) * level.framedurationseconds;
        
        if ( abs( self.var_1ca24f7b7ffaf88f ) <= decel )
        {
            self.var_1ca24f7b7ffaf88f = 0;
        }
        else if ( self.var_1ca24f7b7ffaf88f > 0 )
        {
            self.var_1ca24f7b7ffaf88f -= decel;
        }
        else
        {
            self.var_1ca24f7b7ffaf88f += decel;
        }
        
        self.angles = ( self.angles[ 0 ], self.angles[ 1 ] + self.var_1ca24f7b7ffaf88f * level.framedurationseconds, self.angles[ 2 ] );
        return;
    }
    
    dir_to_target = vectornormalize2( target.origin - self.origin );
    target_yaw = vectortoangles( dir_to_target )[ 1 ];
    yaw_diff = angleclamp180( target_yaw - self.angles[ 1 ] );
    accel = getdvarfloat( @"hash_eab3b23f1608f7dd", 3000 ) * level.framedurationseconds;
    decel = getdvarfloat( @"hash_6eb3aa188c1db6e8", 3000 ) * level.framedurationseconds;
    max_speed = getdvarfloat( @"hash_cf17a05be0fe07d7", 8000 );
    stopping_angle = self.var_1ca24f7b7ffaf88f * self.var_1ca24f7b7ffaf88f / 2 * getdvarfloat( @"hash_6eb3aa188c1db6e8", 3000 );
    should_brake = abs( yaw_diff ) <= stopping_angle && self.var_1ca24f7b7ffaf88f * yaw_diff >= 0;
    
    if ( should_brake )
    {
        if ( abs( self.var_1ca24f7b7ffaf88f ) <= decel )
        {
            self.var_1ca24f7b7ffaf88f = 0;
        }
        else if ( self.var_1ca24f7b7ffaf88f > 0 )
        {
            self.var_1ca24f7b7ffaf88f -= decel;
        }
        else
        {
            self.var_1ca24f7b7ffaf88f += decel;
        }
    }
    else if ( yaw_diff > 0 )
    {
        self.var_1ca24f7b7ffaf88f = min( self.var_1ca24f7b7ffaf88f + accel, max_speed );
    }
    else
    {
        self.var_1ca24f7b7ffaf88f = max( self.var_1ca24f7b7ffaf88f - accel, max_speed * -1 );
    }
    
    new_yaw = self.angles[ 1 ] + self.var_1ca24f7b7ffaf88f * level.framedurationseconds;
    var_858a207e9e859736 = angleclamp180( target_yaw - new_yaw );
    
    if ( var_858a207e9e859736 * yaw_diff < 0 && abs( yaw_diff ) < abs( self.var_1ca24f7b7ffaf88f * level.framedurationseconds ) )
    {
        new_yaw = target_yaw;
        self.var_1ca24f7b7ffaf88f = 0;
    }
    
    self.angles = ( self.angles[ 0 ], new_yaw, self.angles[ 2 ] );
    self forceteleport( self.origin, self.angles );
}

// Namespace zombie_weyward_stinger
// Params 1, eflags: 0x4
// Checksum 0x914183ce, Offset: 0x1b59
// Size: 0xb5
function private function_3c81a6f0731c35a4( target )
{
    var_6532959275db392a = getdvarfloat( @"hash_2c9aa787c0e3fb28", 320 ) * 1.25;
    distance_to_target = distance( self.origin, target.origin );
    prediction_time = math::remap( distance_to_target, getdvarfloat( @"hash_2c9aa787c0e3fb28", 320 ), var_6532959275db392a, getdvarfloat( @"hash_ab9e4aa30af47a3f", 0.25 ), getdvarfloat( @"hash_ab7b58a30ace5151", 1 ) );
    var_df9adb69b75ff5f3 = target getvelocity();
    return target.origin + var_df9adb69b75ff5f3 * prediction_time;
}

// Namespace zombie_weyward_stinger
// Params 0, eflags: 0x4
// Checksum 0x59b10e42, Offset: 0x1c17
// Size: 0x22
function private sting_damage()
{
    self endon( #"death" );
    self waittill( #"sting_start" );
    thread sting_damage_loop();
}

// Namespace zombie_weyward_stinger
// Params 0, eflags: 0x4
// Checksum 0x9bca6429, Offset: 0x1c41
// Size: 0x3b1
function private sting_damage_loop()
{
    self endon( #"death" );
    self endon( #"sting_end" );
    damaged_targets = [];
    damage_radius = getdvarfloat( @"hash_9034e851d1ac47f5", 75 );
    damage_radius_sq = squared( damage_radius );
    slam_damage = getdvarfloat( @"hash_3b9b25cf1b535ee2", 120 );
    
    if ( self.empowered )
    {
        slam_damage *= getdvarfloat( @"hash_f55b35ca1d502308", 1.35 );
    }
    
    height_margin = getdvarfloat( @"hash_59559eeea71d01fb", 20 );
    push_cooldown = getdvarfloat( @"hash_a30ede6da98504e8", 0.75 );
    
    while ( true )
    {
        slam_origin = self gettagorigin( "j_tail_11", 0, 0, 0 );
        
        if ( !isdefined( slam_origin ) )
        {
            slam_origin = self.origin;
        }
        
        ground_z = self.origin[ 2 ] - height_margin;
        top_z = max( slam_origin[ 2 ], self.origin[ 2 ] ) + height_margin;
        half_height = ( top_z - ground_z ) * 0.5;
        column_mid = ( slam_origin[ 0 ], slam_origin[ 1 ], ground_z + half_height );
        broad_radius = damage_radius + half_height;
        potential_targets = getplayersandaiarrayinradius( column_mid, broad_radius );
        
        foreach ( target in potential_targets )
        {
            if ( target == self )
            {
                continue;
            }
            
            if ( distance2dsquared( target.origin, slam_origin ) > damage_radius_sq )
            {
                continue;
            }
            
            if ( target.origin[ 2 ] < ground_z || target.origin[ 2 ] > top_z )
            {
                continue;
            }
            
            is_enemy_player = isplayer( target ) && target.team != self.team;
            
            if ( !target.var_1f6bb197e1cf23a0 || utility::time_has_passed( target.var_1f6bb197e1cf23a0, push_cooldown ) )
            {
                target.var_1f6bb197e1cf23a0 = gettime();
                
                if ( is_enemy_player )
                {
                    function_cc9f789658cc0d4d( target, self.origin );
                }
                else if ( isai( target ) & target.team === self.team && target.aicategory === "normal" )
                {
                    target zombie_knockdown::function_6fc167d4a3590991( self.origin );
                }
            }
            
            if ( is_enemy_player && !damaged_targets[ target getentitynumber() ] )
            {
                damaged_targets[ target getentitynumber() ] = 1;
                target dodamage( slam_damage, slam_origin, self, self, "MOD_MELEE" );
            }
        }
        
        /#
            if ( debug_slam() )
            {
                ground_pos = ( slam_origin[ 0 ], slam_origin[ 1 ], ground_z );
                top_pos = ( slam_origin[ 0 ], slam_origin[ 1 ], top_z );
                line( ground_pos, top_pos, ( 1, 0.5, 0 ) );
                sphere( ground_pos, damage_radius, ( 1, 0.5, 0 ) );
                sphere( top_pos, damage_radius, ( 1, 0.5, 0 ) );
                print3d( slam_origin + ( 0, 0, 30 ), "<dev string:x32>", ( 1, 0.5, 0 ) );
            }
        #/
        
        waitframe();
    }
}

// Namespace zombie_weyward_stinger
// Params 3, eflags: 0x4
// Checksum 0x3898e115, Offset: 0x1ffa
// Size: 0xbd
function private function_cc9f789658cc0d4d( player, from_origin, var_2eb73c75c99bba5f )
{
    if ( player.inlaststand )
    {
        return;
    }
    
    if ( var_2eb73c75c99bba5f )
    {
        var_8207c73267ff8baf = getdvarfloat( @"hash_81f7d6d93671727e", 250 );
    }
    else
    {
        var_8207c73267ff8baf = getdvarfloat( @"hash_36171dae1ec136c2", 450 );
    }
    
    var_c51215b779b5fe59 = vectornormalize2( player.origin - from_origin );
    to_player_perp = anglestoright( vectortoangles( var_c51215b779b5fe59 ) );
    knockback_dir = rotatepointaroundvector( to_player_perp, var_c51215b779b5fe59, getdvarfloat( @"hash_f2a6ca8c23ae05c3", 30 ) );
    player knockback( knockback_dir, var_8207c73267ff8baf, 1 );
}

// Namespace zombie_weyward_stinger
// Params 0, eflags: 0x4
// Checksum 0xd2fd827d, Offset: 0x20bf
// Size: 0x104
function private function_772be7adaff22671()
{
    self endon( #"death" );
    childthread function_b70a11697639a541();
    
    while ( true )
    {
        self waittill( #"hash_6bcd0cd607684237" );
        utility::ent_flag_set( "in_retract" );
        
        if ( self.var_e1adedc4a4a5146d )
        {
            destroynavobstacle( self.var_e1adedc4a4a5146d );
            self.var_e1adedc4a4a5146d = undefined;
        }
        
        if ( self.stinger_owner.wipe_attack_active )
        {
            utility::function_7c10ea82c1e305b8( "wipe_attack", "off" );
        }
        
        childthread function_abd0e71da44ffc99();
        toggle_health_and_icon( 0, "stinger_retract_healthbar" );
        self waittill( #"hash_84a29acd648a7372" );
        utility::ent_flag_clear( "in_retract" );
        function_207a49d4d497b14a();
        toggle_health_and_icon( 1, "stinger_retract_healthbar" );
        asm::function_d82cb83c9c260d49( 1 );
        self.retract_playback_rate = 1;
        self.var_30b5e6fc9ca7628e = 0;
        
        if ( !self.var_e1adedc4a4a5146d )
        {
            self.var_e1adedc4a4a5146d = function_aafd9c2a00b86dba( self, "custom_default_on" );
        }
    }
}

// Namespace zombie_weyward_stinger
// Params 3, eflags: 0x4
// Checksum 0xbd72b6cd, Offset: 0x21cb
// Size: 0xb9
function private toggle_health_and_icon( enabled, str_id = "stinger", delay_enable = 0 )
{
    self notify( #"endon_stinger_toggle_health_and_icon" );
    
    if ( enabled )
    {
        utility::delaythreadendon( delay_enable, [ "endon_stinger_toggle_health_and_icon", "death" ], &val::reset, str_id, "show_healthbar" );
        utility::delaythreadendon( delay_enable, [ "endon_stinger_toggle_health_and_icon", "death" ], &utility::function_7c10ea82c1e305b8, "objective", "on" );
        return;
    }
    
    val::set( str_id, "show_healthbar", 0 );
    utility::function_7c10ea82c1e305b8( "objective", "off" );
}

// Namespace zombie_weyward_stinger
// Params 0, eflags: 0x4
// Checksum 0x27a9264c, Offset: 0x228c
// Size: 0xc3
function private function_eaca57831d877042()
{
    if ( !isalive( self.stinger_owner ) )
    {
        return 1;
    }
    
    near_dist_sq = squared( getdvarfloat( @"hash_b7e908a2b26bd5b", 200 ) );
    var_68683cd0fec692e1 = squared( getdvarfloat( @"hash_9716106dff59c352", 1000 ) );
    rate_min = getdvarfloat( @"hash_2a10a1ca64b26908", 1 );
    rate_max = getdvarfloat( @"hash_2a3397ca64d89ac2", 3 );
    dist_sq = clamp( distancesquared( self.origin, self.stinger_owner.origin ), near_dist_sq, var_68683cd0fec692e1 );
    return math::remap( dist_sq, near_dist_sq, var_68683cd0fec692e1, rate_max, rate_min );
}

// Namespace zombie_weyward_stinger
// Params 0
// Checksum 0xa19fa41e, Offset: 0x2358
// Size: 0x2e
function start_stinger_retract()
{
    self.retract_playback_rate = function_eaca57831d877042();
    asm::function_d82cb83c9c260d49( self.retract_playback_rate );
    self function_786bb6aa1b76c7ee( "in_stinger_retract", 1 );
}

// Namespace zombie_weyward_stinger
// Params 0, eflags: 0x4
// Checksum 0x23950f7f, Offset: 0x238e
// Size: 0x52
function private function_abd0e71da44ffc99()
{
    self waittill( #"hash_4c41e7dd3cd7b4ec" );
    asm::function_d82cb83c9c260d49( 1 );
    self.retract_playback_rate = 1;
    val::set( "stinger_retract", "hide", 1 );
    self waittill( #"hash_6c75bedd4e631b61" );
    val::reset_all( "stinger_retract" );
}

// Namespace zombie_weyward_stinger
// Params 0, eflags: 0x4
// Checksum 0x55bc1afc, Offset: 0x23e8
// Size: 0x200
function private function_b70a11697639a541()
{
    while ( true )
    {
        wait 0.1;
        
        if ( self getaiblackboarddynamic( "in_wipe_attack_charge" ) )
        {
            waitframe();
            continue;
        }
        
        if ( utility::ent_flag( "in_retract" ) )
        {
            /#
                if ( getdvarint( @"hash_b9958e3d9eac7ddc", 0 ) )
                {
                    continue;
                }
            #/
            
            if ( !isalive( self.stinger_owner ) )
            {
                self function_f2df0257c63f229( "in_stinger_retract" );
                continue;
            }
            
            owner_attacking = self.stinger_owner utility::ent_flag( "in_charge" ) || self.stinger_owner utility::ent_flag( "in_dash" );
            
            if ( self.var_30b5e6fc9ca7628e && owner_attacking && !function_7896a9bcae1d6a80() )
            {
                waitframe();
                continue;
            }
            
            self.var_30b5e6fc9ca7628e = 0;
            var_a7d5c6b941d26ec = getdvarfloat( @"hash_9751b881666bc7e5", 500 );
            
            if ( self.stinger_owner utility::ent_flag( "in_charge" ) )
            {
                var_a7d5c6b941d26ec *= 2;
            }
            
            if ( distance( self.origin, self.stinger_owner.origin ) > var_a7d5c6b941d26ec )
            {
                self function_f2df0257c63f229( "in_stinger_retract" );
            }
            
            continue;
        }
        
        /#
            if ( getdvarint( @"hash_b9958e3d9eac7ddc", 0 ) )
            {
                start_stinger_retract();
                continue;
            }
        #/
        
        if ( self.stinger_owner.wipe_attack_active )
        {
            waitframe();
            continue;
        }
        
        owner_attacking = isalive( self.stinger_owner ) && ( self.stinger_owner utility::ent_flag( "in_charge" ) || self.stinger_owner utility::ent_flag( "in_dash" ) );
        
        if ( owner_attacking )
        {
            waitframe();
            continue;
        }
        
        if ( isalive( self.stinger_owner ) && distance( self.origin, self.stinger_owner.origin ) <= getdvarfloat( @"hash_d2c6ae458b32e139", 500 ) )
        {
            start_stinger_retract();
        }
    }
}

// Namespace zombie_weyward_stinger
// Params 0, eflags: 0x4
// Checksum 0x91ae3147, Offset: 0x25f0
// Size: 0x83, Type: bool
function private function_7896a9bcae1d6a80()
{
    owner_velocity = self.stinger_owner getvelocity();
    to_stinger = self.origin - self.stinger_owner.origin;
    var_54c8b28c07e49694 = squared( getdvarfloat( @"hash_4724801c89bafdbd", 50 ) );
    
    if ( lengthsquared( to_stinger ) < var_54c8b28c07e49694 )
    {
        return false;
    }
    
    if ( lengthsquared( owner_velocity ) <= 0 )
    {
        return false;
    }
    
    return vectordot( owner_velocity, to_stinger ) < 0;
}

/#

    // Namespace zombie_weyward_stinger
    // Params 0, eflags: 0x4
    // Checksum 0xc5193839, Offset: 0x267c
    // Size: 0x5a, Type: dev
    function private init_slam_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x38>" );
        devgui::add_devgui_func( "<dev string:x59>", "<dev string:x64>", &force_slam );
        devgui::add_devgui_func( "<dev string:x7f>", "<dev string:x8a>", &toggle_slam_debug );
        devgui::add_devgui_func( "<dev string:xac>", "<dev string:xbb>", &toggle_retract );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_weyward_stinger
    // Params 1, eflags: 0x4
    // Checksum 0x8279f23d, Offset: 0x26de
    // Size: 0x7a, Type: dev
    function private force_slam( params )
    {
        stinger = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:xda>" );
        
        if ( isdefined( stinger ) )
        {
            stinger.slam_cooldown_end = 0;
            stinger sting_orient( level.players[ 0 ] );
            stinger asm::function_7256f5ba459c840b( "<dev string:xf1>" );
            stinger thread sting_damage();
        }
    }

    // Namespace zombie_weyward_stinger
    // Params 1, eflags: 0x4
    // Checksum 0x5968118f, Offset: 0x2760
    // Size: 0x24, Type: dev
    function private toggle_slam_debug( params )
    {
        devgui::function_3f8a26ec96988e80( "<dev string:xf6>", @"hash_59c2a4ccdbc797ba" );
    }

    // Namespace zombie_weyward_stinger
    // Params 1, eflags: 0x4
    // Checksum 0x4d8c2cbd, Offset: 0x278c
    // Size: 0x24, Type: dev
    function private toggle_retract( params )
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x111>", @"hash_b9958e3d9eac7ddc" );
    }

    // Namespace zombie_weyward_stinger
    // Params 0, eflags: 0x4
    // Checksum 0x67da77b7, Offset: 0x27b8
    // Size: 0x16, Type: dev
    function private debug_slam()
    {
        return getdvarint( @"hash_59c2a4ccdbc797ba", 0 ) > 0;
    }

#/
