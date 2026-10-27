// script_11135abf83b49078  (hash_11135abf83b49078.gscc) (size: 22235 Bytes / 0x56db / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf0f5c2b5 (4042638005)
// size ...... 22235 (0x56db)
// includes .. 11  (offset: 0x541b)
// strings ... 27  (offset: 0x5473)
// dev strs .. 18  (offset: 0x5603)
// exports ... 51  (offset: 0x39ef)
// cseg ...... 0x206 + 0x37e9 (0x39ef)
// imports ... 135 (offset: 0x41e7)
// animtree1 . 0   (offset: 0x56db)
// animtree2 . 0   (offset: 0x56db)
#using script_16ea1b94f0f381b3;
#using script_46e6a605b00ce67c;
#using script_5cda26b07ee216bf;
#using script_6de1b9fbdf8db6bb;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_weyward_bomb_attack;

// Namespace zombie_weyward_bomb_attack
// Params 1
// Checksum 0x5ea9c4e6, Offset: 0x224
// Size: 0x6d
function precache( aitypescriptbundle )
{
    settings = zombie_utils::function_a225e7aa4a243fb2( aitypescriptbundle );
    
    if ( !isdefined( settings ) )
    {
        return;
    }
    
    utility::add_fx( "weyward_bomb_damaged_impact_fx", settings.var_c59d9e593755fc88 );
    utility::add_fx( "weyward_bomb_explode_fx", settings.var_bd4d13aeb2e9c059 );
    utility::add_fx( "weyward_bomb_explode_emp_fx", settings.var_3ae533014ba204f5 );
}

/#

    // Namespace zombie_weyward_bomb_attack
    // Params 0
    // Checksum 0x232c79d1, Offset: 0x299
    // Size: 0xc, Type: dev
    function function_56ab258fe2a3cce3()
    {
        init_bomb_attack_devgui();
    }

#/

// Namespace zombie_weyward_bomb_attack
// Params 0
// Checksum 0xe1cdfed0, Offset: 0x2ad
// Size: 0x3e9
function init_zombie_weyward_bomb_attack()
{
    self.bomb_attack_active = 0;
    self.bomb_last_attack_time = 0;
    self.bomb_projectile = undefined;
    self.bomb_projectiles = [];
    self.bomb_active_count = 0;
    self.bomb_attack_target = undefined;
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    self.var_4d76aa6108c4d1d2 = settings.var_621d8f47bd29261a ?? 12;
    self.bomb_speed = settings.bombspeed ?? 160;
    self.var_57337cb6095c351d = settings.var_e3f08b1a079cf30b ?? 240;
    self.var_174ca7feb8617c45 = settings.var_f609e31e2455b773 ?? 0.1;
    self.var_95fa92da38b854e4 = settings.var_cb9d37b40ffcca9d ?? 0.2;
    self.var_b5e9f872c083744e = settings.var_3ce65f5de508e70d ?? 1.5;
    self.bomb_health = settings.bombhealth ?? 5000;
    self.var_ea06d6275179d953 = settings.var_fdcbcd956cac5552 ?? 500;
    self.bomb_cooldown_s = settings.bombcooldowns ?? 20;
    self.bomb_yaw = settings.bombyaw ?? 45;
    self.var_36b553e34a8b16f2 = settings.var_578b57661a40d2b5 ?? 2.5;
    self.var_f9d7e3faad4ea401 = settings.var_be8ece6792e303e9 ?? 200;
    self.var_84d0db36839c456a = settings.var_8ec52cb5f5bf12b1 ?? 1.25;
    self.var_ef6ab62ba4f42d67 = settings.var_282255b7ab12f384 ?? 4;
    self.var_fc0bf852e19ab29a = settings.var_3620bec5823c77de ?? 5;
    self.var_7d15a46c000f1df0 = settings.var_51730ac850a39b34 ?? 200;
    self.var_34dae70a981d0ba3 = settings.var_b25314408b108617 ?? 250;
    self.var_dfe787d378520a8d = settings.var_cb90986d8c188058 ?? 2;
    self.var_9bf3b5807ec9d019 = settings.var_ab0280a494f7d3ad ?? 120;
    self.var_96d8f07fbf680e42 = settings.var_eb40f3a5801ba196 ?? 30;
    self.var_e63dd0310c59e5d1 = settings.var_aba17a351e1f92ab ?? 180;
    self.bomb_explosion_damage = settings.var_346fd9a01ee833ac ?? 80;
    self.bomb_explosion_radius = settings.bombexplosionradius ?? 200;
    self.var_94b9c4d4b97bee45 = settings.var_8969f2d4a748567c ?? 10;
    self.var_27361acf169d1dbc = settings.var_4ea11c1a68d8e398 ?? 5;
    self.var_cf37fe9c1e94f08d = settings.var_ea75c0222e865d7b ?? 10;
    self.var_6b8cd8519ad9ae2c = settings.var_b4526894dd58074c ?? 60;
    self.var_c52b88ee46294294 = settings.var_fab7e35e939695ec ?? 120;
    self.var_2dd37e6a67b02254 = settings.var_de90b24a57e32463 ?? 300;
    self.var_698bd458cb217313 = settings.var_9e907532f9ef4b5b ?? 8;
    self.var_9759bc8bf4a77945 = settings.var_c8f0946988620e0d ?? 0.35;
    self.var_defd4243f03167a7 = settings.var_4183ab1a4c4fb18d ?? 12;
    self.var_1aa6e3f2fc788d29 = settings.var_b4ea1671217e485b ?? 0.25;
    self.bomb_enabled = settings.var_2c67c9b7caf3107 ?? 1;
    self.var_864f7da030e1538 = settings.var_a00a391554096090 ?? 0;
    thread listen_for_bomb_attack();
}

// Namespace zombie_weyward_bomb_attack
// Params 2
// Checksum 0xe9db6718, Offset: 0x69e
// Size: 0x225
function function_6323a829b45cc5bb( taskid, params )
{
    assert( isalive( self ) && isai( self ) );
    
    if ( !isalive( self ) || !isai( self ) )
    {
        return anim.failure;
    }
    
    if ( zombie_stun::is_stunned() )
    {
        return anim.failure;
    }
    
    if ( !getdvarint( @"hash_bbb1226e8969efdf", self.bomb_enabled ) )
    {
        if ( namespace_c57c4bda2cd4484a::function_4a278f68fa44b37( "bomb" ) )
        {
            namespace_c57c4bda2cd4484a::function_e150aff9299e8439();
        }
        
        return anim.failure;
    }
    
    if ( namespace_77f0670c8a2e733c::function_37f4de727b08b964() )
    {
        return anim.running;
    }
    
    if ( !zombie_weyward_shadow_soul::function_56db8ae62fa6ec66( 2 ) )
    {
        if ( namespace_c57c4bda2cd4484a::function_4a278f68fa44b37( "bomb" ) )
        {
            namespace_c57c4bda2cd4484a::function_e150aff9299e8439();
        }
        
        return anim.failure;
    }
    
    if ( self.bomb_attack_active )
    {
        if ( namespace_c57c4bda2cd4484a::function_4a278f68fa44b37( "bomb" ) )
        {
            namespace_c57c4bda2cd4484a::function_e150aff9299e8439();
        }
        
        return anim.failure;
    }
    
    if ( namespace_c57c4bda2cd4484a::function_4a278f68fa44b37( "bomb" ) )
    {
        var_54536d6f9c8a4837 = namespace_c57c4bda2cd4484a::function_3ff492a8c06c648e();
        
        if ( !namespace_c57c4bda2cd4484a::function_3719f5ec7b5bd679() )
        {
            namespace_c57c4bda2cd4484a::function_f24771760c767129();
            return anim.failure;
        }
        
        if ( !namespace_c57c4bda2cd4484a::function_8c043ec24462c79() )
        {
            return anim.failure;
        }
        
        forward_dir = anglestoforward( ( 0, self.angles[ 1 ], 0 ) );
        to_target_dir = vectornormalize2( var_54536d6f9c8a4837.origin - self.origin );
        
        if ( vectordot( forward_dir, to_target_dir ) <= 0.4 )
        {
            namespace_c57c4bda2cd4484a::function_e70c18ec4d85221f();
            return anim.failure;
        }
        
        self.bomb_attack_target = var_54536d6f9c8a4837;
        namespace_77f0670c8a2e733c::function_d7144ac95cf9f789();
        return anim.running;
    }
    
    if ( !function_4f2c6329204468cf() )
    {
        return anim.failure;
    }
    
    if ( !isalive( self.enemy ) )
    {
        return anim.failure;
    }
    
    if ( !function_a6ac544aaddd509d( self.enemy ) )
    {
        return anim.failure;
    }
    
    namespace_77f0670c8a2e733c::function_d7144ac95cf9f789();
    return anim.running;
}

// Namespace zombie_weyward_bomb_attack
// Params 0
// Checksum 0xf5cb8d0c, Offset: 0x8cc
// Size: 0x27
function cancel_bomb_attack()
{
    if ( !self.bomb_attack_active && !namespace_77f0670c8a2e733c::function_37f4de727b08b964() )
    {
        return;
    }
    
    self notify( #"bBombEnded" );
}

// Namespace zombie_weyward_bomb_attack
// Params 0, eflags: 0x4
// Checksum 0x4cc920a4, Offset: 0x8fb
// Size: 0x112
function private listen_for_bomb_attack()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"hash_9fe5ac4981ea08c2" );
        var_6d459758e3503c2e = self.bomb_attack_target;
        actual_target = get_bomb_target( var_6d459758e3503c2e );
        self.bomb_attack_target = undefined;
        self.bomb_last_attack_time = gettime();
        
        if ( var_6d459758e3503c2e )
        {
            namespace_c57c4bda2cd4484a::function_169e0fd0d1155118( "bomb", actual_target );
            namespace_c57c4bda2cd4484a::function_f24771760c767129();
        }
        else
        {
            namespace_c57c4bda2cd4484a::function_5d712bb2b5876699( actual_target );
        }
        
        if ( actual_target )
        {
            self orientmode( "face angle", angleclamp180( vectortoyaw( actual_target.origin - self.origin ) ) );
        }
        
        msg = utility::waittill_any_in_array_or_timeout( [ "spawn_bomb", "bBombEnded" ], 1.1 );
        
        if ( msg == "spawn_bomb" || msg == "timeout" )
        {
            thread function_6320ceb18d650ad9( var_6d459758e3503c2e );
            thread launch_bomb_attack( var_6d459758e3503c2e );
            self waittill( #"bBombEnded" );
        }
    }
}

// Namespace zombie_weyward_bomb_attack
// Params 1, eflags: 0x4
// Checksum 0x9c3b7ba9, Offset: 0xa15
// Size: 0x92
function private function_6320ceb18d650ad9( var_6d459758e3503c2e )
{
    self endon( #"death" );
    self endon( #"bBombEnded" );
    self endon( #"throw_bomb" );
    
    while ( true )
    {
        if ( var_6d459758e3503c2e || isalive( self.enemy ) )
        {
            self orientmode( "face angle", angleclamp180( vectortoyaw( ( var_6d459758e3503c2e ? var_6d459758e3503c2e.origin : self.enemy.origin ) - self.origin ) ) );
        }
        
        waitframe();
    }
}

// Namespace zombie_weyward_bomb_attack
// Params 1, eflags: 0x4
// Checksum 0x62245d64, Offset: 0xaaf
// Size: 0x21
function private get_bomb_target( var_6d459758e3503c2e )
{
    if ( isalive( var_6d459758e3503c2e ) )
    {
        return var_6d459758e3503c2e;
    }
    
    return self.enemy;
}

// Namespace zombie_weyward_bomb_attack
// Params 1, eflags: 0x4
// Checksum 0x2238dc9a, Offset: 0xad9
// Size: 0x4f
function private function_9ff8654d8daa6ae0( target )
{
    if ( !isalive( target ) )
    {
        return 0;
    }
    
    if ( self.enemy === target )
    {
        return 1;
    }
    
    var_107b1c9625393a81 = self.var_2407eeb13e7a18;
    
    if ( !var_107b1c9625393a81 )
    {
        return 1;
    }
    
    return arraycontains( var_107b1c9625393a81, target );
}

// Namespace zombie_weyward_bomb_attack
// Params 1, eflags: 0x4
// Checksum 0xe81f2f84, Offset: 0xb31
// Size: 0x44
function private function_3b4642d3f0510a94( carrier )
{
    var_107b1c9625393a81 = self.var_2407eeb13e7a18;
    
    if ( !isdefined( var_107b1c9625393a81 ) || !var_107b1c9625393a81.size )
    {
        return;
    }
    
    return utility::function_4325398d215ecda5( carrier.origin, var_107b1c9625393a81 );
}

// Namespace zombie_weyward_bomb_attack
// Params 3, eflags: 0x4
// Checksum 0x46566b71, Offset: 0xb7e
// Size: 0x8a
function private function_c003023bcaad1b56( bomb, carrier, var_6d459758e3503c2e )
{
    primary_target = get_bomb_target( var_6d459758e3503c2e );
    
    if ( function_9ff8654d8daa6ae0( primary_target ) )
    {
        bomb.var_5b55e8871882ed73 = undefined;
        return primary_target;
    }
    
    if ( function_9ff8654d8daa6ae0( bomb.var_5b55e8871882ed73 ) )
    {
        return bomb.var_5b55e8871882ed73;
    }
    
    bomb.var_5b55e8871882ed73 = function_3b4642d3f0510a94( carrier );
    return bomb.var_5b55e8871882ed73;
}

// Namespace zombie_weyward_bomb_attack
// Params 1, eflags: 0x4
// Checksum 0x14a8f727, Offset: 0xc11
// Size: 0x5f, Type: bool
function private function_a6ac544aaddd509d( target )
{
    max_yaw = getdvarfloat( @"hash_8edf34590f515d14", self.bomb_yaw );
    return abs( angleclamp180( vectortoyaw( target.origin - self.origin ) - self.angles[ 1 ] ) ) <= max_yaw;
}

// Namespace zombie_weyward_bomb_attack
// Params 0, eflags: 0x4
// Checksum 0x7e4e5c7d, Offset: 0xc79
// Size: 0x9f
function private function_915e0e68dcc6a110()
{
    alive_targets = [];
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) && !player.ignoreme )
        {
            alive_targets[ alive_targets.size ] = player;
        }
    }
    
    return alive_targets;
}

// Namespace zombie_weyward_bomb_attack
// Params 1, eflags: 0x4
// Checksum 0xc4012db0, Offset: 0xd21
// Size: 0xde
function private function_dd2945c0ba0e5311( var_6d459758e3503c2e )
{
    alive_targets = function_915e0e68dcc6a110();
    primary_target = get_bomb_target( var_6d459758e3503c2e );
    secondary_target = undefined;
    
    foreach ( player in alive_targets )
    {
        if ( !( player === primary_target ) )
        {
            secondary_target = player;
            break;
        }
    }
    
    if ( !isdefined( secondary_target ) )
    {
        secondary_target = primary_target;
    }
    
    return { #sharetarget:primary_target === secondary_target, #secondarytarget:secondary_target, #primarytarget:primary_target };
}

// Namespace zombie_weyward_bomb_attack
// Params 1, eflags: 0x4
// Checksum 0xa85d576d, Offset: 0xe08
// Size: 0x68
function private get_bomb_spawn_origin( hand_tag_name = undefined )
{
    base_spawn_origin = self.origin + ( 0, 0, 300 );
    
    if ( hand_tag_name )
    {
        tag_origin = self gettagorigin( hand_tag_name, 0, 0, 0 );
        
        if ( isvector( tag_origin ) )
        {
            return ( tag_origin[ 0 ], tag_origin[ 1 ], base_spawn_origin[ 2 ] );
        }
    }
    
    return base_spawn_origin;
}

// Namespace zombie_weyward_bomb_attack
// Params 0, eflags: 0x4
// Checksum 0x9ae6c27a, Offset: 0xe79
// Size: 0x48, Type: bool
function private function_4f2c6329204468cf()
{
    cooldown_ms = getdvarfloat( @"hash_83c6e9c12db05b8e", self.bomb_cooldown_s ) * 1000;
    return self.bomb_last_attack_time == 0 || gettime() - self.bomb_last_attack_time >= cooldown_ms;
}

// Namespace zombie_weyward_bomb_attack
// Params 0, eflags: 0x4
// Checksum 0x14d3ff15, Offset: 0xeca
// Size: 0x1c
function private get_empowerment_level()
{
    return ( self.var_bfec04d50947b318.size ?? 0 ) >= 1 ? 4 : 0;
}

// Namespace zombie_weyward_bomb_attack
// Params 0, eflags: 0x4
// Checksum 0xc10b65ff, Offset: 0xeef
// Size: 0x61
function private get_emp_damage_bonus()
{
    emp = get_empowerment_level();
    bonus_tier = getdvarfloat( @"hash_9dfd5f50dcef54b7", self.var_94b9c4d4b97bee45 );
    bonus = 0;
    
    if ( emp >= 3 )
    {
        bonus += bonus_tier;
    }
    
    if ( emp >= 4 )
    {
        bonus += bonus_tier;
    }
    
    return int( bonus );
}

// Namespace zombie_weyward_bomb_attack
// Params 1, eflags: 0x4
// Checksum 0x275cd420, Offset: 0xf59
// Size: 0x4d
function private register_active_bomb( bomb )
{
    self.bomb_projectiles[ self.bomb_projectiles.size ] = bomb;
    self.bomb_active_count = self.bomb_projectiles.size;
    
    if ( !isdefined( self.bomb_projectile ) )
    {
        self.bomb_projectile = bomb;
    }
}

// Namespace zombie_weyward_bomb_attack
// Params 1, eflags: 0x4
// Checksum 0x92785e3e, Offset: 0xfae
// Size: 0xd3
function private function_1cad4d9ecec246dc( bomb )
{
    remaining_bombs = [];
    
    foreach ( active_bomb in self.bomb_projectiles )
    {
        if ( isalive( active_bomb ) && !( active_bomb === bomb ) )
        {
            remaining_bombs[ remaining_bombs.size ] = active_bomb;
        }
    }
    
    self.bomb_projectiles = remaining_bombs;
    self.bomb_active_count = remaining_bombs.size;
    self.bomb_projectile = undefined;
    
    if ( remaining_bombs.size )
    {
        self.bomb_projectile = remaining_bombs[ 0 ];
    }
}

// Namespace zombie_weyward_bomb_attack
// Params 1, eflags: 0x4
// Checksum 0x309a47ce, Offset: 0x1089
// Size: 0x405
function private spawn_bomb_projectile( spawn_pos )
{
    bomb = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( function_b3988325430ce242( "zombie_wither_bomb" ), spawn_pos, ( 0, 0, 0 ), self.team );
    
    while ( !bomb )
    {
        zombies = arrayrandomize( getaiarray( "team_two_hundred" ) );
        
        foreach ( zombie in zombies )
        {
            if ( !isalive( zombie ) || issubstr( zombie.subclass, "zombie_weyward" ) || issubstr( zombie.subclass, "zombie_wither" ) || issubstr( zombie.subclass, "hvt" ) )
            {
                continue;
            }
            
            zombie.nocorpse = 1;
            zombie kill();
            waitframe();
            waitframe();
            break;
        }
        
        bomb = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( function_b3988325430ce242( "zombie_wither_bomb" ), spawn_pos, ( 0, 0, 0 ), self.team );
        
        if ( bomb )
        {
            break;
        }
        
        waitframe();
    }
    
    max_health = getdvarfloat( @"hash_745922987ce05ab3", self.bomb_health );
    health_min = getdvarfloat( @"hash_9c9af98fa32d9c45", self.var_ea06d6275179d953 );
    scaled_health = max( health_min, max_health * level.players.size / 4 );
    bomb.health = int( scaled_health );
    bomb.maxhealth = int( scaled_health );
    bomb utility::function_7c10ea82c1e305b8( "spawn", "on" );
    bomb val::set( "bomb_spawn", "show_healthbar", 0 );
    bomb callback::add( "on_zombie_ai_damaged", &function_b420b2889cf91e0c );
    callback::callback( "on_summoned_by_weyward", { #ent:bomb } );
    carrier = utility::spawn_tag_origin( spawn_pos, self.angles );
    bomb.bomb_start_time = gettime();
    bomb.bomb_velocity = ( 0, 0, 0 );
    bomb.bomb_orbiting = 0;
    bomb.var_4505f320b5979ab8 = randomint( 2 ) == 0;
    bomb.var_38fe5035432805a2 = 0;
    bomb.var_3b0de3b07d309162 = undefined;
    bomb.bomb_carrier = carrier;
    bomb.var_b5850e953dad7c3d = spawn_pos;
    bomb.var_5d1913cd72eb6315 = ( 0, 0, 0 );
    bomb.var_f6a680bb6b2a59e4 = spawn_pos;
    bomb.var_bc2f36d2c05b2942 = spawn_pos;
    bomb.var_8c9a05522d20651b = gettime();
    bomb.var_b41482b47b412931 = 0;
    bomb.var_5226690a64aff34a = 0;
    bomb.var_645610e5a816e66f = 0;
    bomb.var_b740ca4c85393673 = 0;
    bomb.var_aa66654bc2e8345 = undefined;
    bomb.var_ca553453d5bdfb45 = 0;
    bomb.var_bcdca5c4020b23e7 = 0;
    bomb.var_1f19a019e5ca746b = 0;
    bomb.bomb_partner = undefined;
    bomb.var_5b55e8871882ed73 = undefined;
    bomb linkto( carrier, "tag_origin" );
    bomb thread utility::delete_on_death( carrier );
    register_active_bomb( bomb );
    thread function_89e3ded9a6fe3643( bomb );
    
    /#
        if ( debug_bomb() )
        {
            println( "<dev string:x24>" + spawn_pos + "<dev string:x40>" + bomb.health );
        }
    #/
    
    return { #carrier:carrier, #bomb:bomb };
}

// Namespace zombie_weyward_bomb_attack
// Params 1, eflags: 0x4
// Checksum 0xd4d6e1e, Offset: 0x1497
// Size: 0xcd
function private abort_bomb_attack( spawned_bombs )
{
    self.bomb_attack_active = 0;
    self.bomb_projectile = undefined;
    
    foreach ( spawn_data in spawned_bombs )
    {
        if ( isalive( spawn_data.bomb ) )
        {
            spawn_data.bomb.forceannihilate = 1;
            spawn_data.bomb kill( self.origin, self );
        }
    }
}

// Namespace zombie_weyward_bomb_attack
// Params 4, eflags: 0x4
// Checksum 0xb2e33818, Offset: 0x156c
// Size: 0x20b
function private function_dcafad19f19db128( first_bomb, first_carrier, second_bomb, second_carrier )
{
    var_136be7bfa5b142c4 = ( first_carrier.origin + second_carrier.origin ) * 0.5;
    var_c29b1759244ddb76 = gettime();
    first_offset = first_carrier.origin - var_136be7bfa5b142c4;
    first_offset = ( first_offset[ 0 ], first_offset[ 1 ], 0 );
    
    if ( length2dsquared( first_offset ) <= 0.1 )
    {
        var_218760862c56bbba = 0;
        var_7b4fa4fd155dd404 = 180;
    }
    else
    {
        var_218760862c56bbba = vectortoangles( first_offset )[ 1 ];
        var_7b4fa4fd155dd404 = var_218760862c56bbba + 180;
    }
    
    first_bomb.bomb_partner = second_bomb;
    second_bomb.bomb_partner = first_bomb;
    first_bomb.var_b5850e953dad7c3d = var_136be7bfa5b142c4;
    second_bomb.var_b5850e953dad7c3d = var_136be7bfa5b142c4;
    first_bomb.var_5d1913cd72eb6315 = ( 0, 0, 0 );
    second_bomb.var_5d1913cd72eb6315 = ( 0, 0, 0 );
    first_bomb.var_8c9a05522d20651b = var_c29b1759244ddb76;
    second_bomb.var_8c9a05522d20651b = var_c29b1759244ddb76;
    first_bomb.var_bc2f36d2c05b2942 = first_carrier.origin;
    second_bomb.var_bc2f36d2c05b2942 = second_carrier.origin;
    first_bomb.var_f6a680bb6b2a59e4 = first_carrier.origin;
    second_bomb.var_f6a680bb6b2a59e4 = second_carrier.origin;
    first_bomb.var_b41482b47b412931 = 0;
    second_bomb.var_b41482b47b412931 = 0;
    first_bomb.var_1f19a019e5ca746b = 1;
    second_bomb.var_1f19a019e5ca746b = 1;
    first_bomb.var_ca553453d5bdfb45 = 1;
    second_bomb.var_ca553453d5bdfb45 = 0;
    first_bomb.var_bcdca5c4020b23e7 = var_218760862c56bbba;
    second_bomb.var_bcdca5c4020b23e7 = var_7b4fa4fd155dd404;
}

// Namespace zombie_weyward_bomb_attack
// Params 1, eflags: 0x4
// Checksum 0x43c0fb2, Offset: 0x177f
// Size: 0x32c
function private launch_bomb_attack( var_6d459758e3503c2e )
{
    self.bomb_attack_active = 1;
    self.bomb_projectile = undefined;
    self.bomb_projectiles = [];
    self.bomb_active_count = 0;
    spawned_bombs = [];
    double_bomb_enabled = getdvarint( @"hash_305eb188dcc499b7", self.var_864f7da030e1538 );
    
    if ( double_bomb_enabled )
    {
        spawn_tags = [];
        spawn_tags[ 0 ] = "j_wrist_le";
        spawn_tags[ 1 ] = "j_wrist_ri";
        
        foreach ( spawn_tag in spawn_tags )
        {
            spawn_data = spawn_bomb_projectile( get_bomb_spawn_origin( spawn_tag ) );
            
            if ( isdefined( spawn_data ) )
            {
                spawned_bombs[ spawned_bombs.size ] = spawn_data;
            }
        }
    }
    else
    {
        spawn_data = spawn_bomb_projectile( get_bomb_spawn_origin() );
        
        if ( isdefined( spawn_data ) )
        {
            spawned_bombs[ spawned_bombs.size ] = spawn_data;
        }
    }
    
    if ( !spawned_bombs.size )
    {
        self.bomb_attack_active = 0;
        return;
    }
    
    msg = utility::waittill_any_in_array_or_timeout( [ "throw_bomb", "bBombEnded", "death" ], 5 );
    
    if ( msg == "throw_bomb" || msg == "timeout" )
    {
        if ( !self.bomb_attack_active )
        {
            return;
        }
        
        target_info = function_dd2945c0ba0e5311( var_6d459758e3503c2e );
        target = target_info.primarytarget;
        
        if ( !isalive( self ) || !isalive( target ) || msg != "timeout" && msg != "throw_bomb" )
        {
            abort_bomb_attack( spawned_bombs );
            return;
        }
        
        if ( spawned_bombs.size >= 2 && target_info.sharetarget && isalive( spawned_bombs[ 0 ].bomb ) && isalive( spawned_bombs[ 1 ].bomb ) )
        {
            function_dcafad19f19db128( spawned_bombs[ 0 ].bomb, spawned_bombs[ 0 ].carrier, spawned_bombs[ 1 ].bomb, spawned_bombs[ 1 ].carrier );
        }
        
        for ( i = 0; i < spawned_bombs.size ; i++ )
        {
            bomb = spawned_bombs[ i ].bomb;
            
            if ( !isalive( bomb ) )
            {
                continue;
            }
            
            carrier = spawned_bombs[ i ].carrier;
            bomb_target = target_info.primarytarget;
            
            if ( i == 1 && !target_info.sharetarget )
            {
                bomb_target = target_info.secondarytarget;
            }
            
            thread function_4f7a9c2f9bd317b0( bomb );
            thread function_8820eec5ccbe60ed( bomb, carrier, bomb_target );
            thread function_ff4a1a2550ff1fa1( bomb, carrier, bomb_target );
        }
        
        return;
    }
    
    abort_bomb_attack( spawned_bombs );
}

// Namespace zombie_weyward_bomb_attack
// Params 1, eflags: 0x4
// Checksum 0x66b69d42, Offset: 0x1ab3
// Size: 0x58
function private function_b420b2889cf91e0c( params )
{
    if ( !isdefined( params.vpoint ) || !isdefined( params.vdir ) )
    {
        return;
    }
    
    playfx( utility::getfx( "weyward_bomb_damaged_impact_fx" ), params.vpoint, vectortoangles( params.vdir ) );
}

// Namespace zombie_weyward_bomb_attack
// Params 3, eflags: 0x4
// Checksum 0xda22c2ec, Offset: 0x1b13
// Size: 0x133
function private function_87e3d1d029000a8c( bomb, carrier, target )
{
    var_9bcca5ebe8576b01 = carrier.origin - target.origin;
    var_9bcca5ebe8576b01 = ( var_9bcca5ebe8576b01[ 0 ], var_9bcca5ebe8576b01[ 1 ], 0 );
    
    if ( length2dsquared( var_9bcca5ebe8576b01 ) <= 0.1 )
    {
        var_9bcca5ebe8576b01 = ( 1, 0, 0 );
    }
    
    clockwise_tangent = vectornormalize( ( var_9bcca5ebe8576b01[ 1 ], var_9bcca5ebe8576b01[ 0 ] * -1, 0 ) );
    counter_clockwise_tangent = vectornormalize( ( var_9bcca5ebe8576b01[ 1 ] * -1, var_9bcca5ebe8576b01[ 0 ], 0 ) );
    current_speed = length( bomb.bomb_velocity );
    
    if ( current_speed > 0.1 )
    {
        current_dir = vectornormalize( bomb.bomb_velocity );
        bomb.var_4505f320b5979ab8 = vectordot( current_dir, clockwise_tangent ) >= vectordot( current_dir, counter_clockwise_tangent );
        bomb.var_3b0de3b07d309162 = current_dir;
    }
    else
    {
        bomb.var_3b0de3b07d309162 = clockwise_tangent;
    }
    
    bomb.bomb_orbiting = 1;
    bomb.var_38fe5035432805a2 = gettime();
}

// Namespace zombie_weyward_bomb_attack
// Params 3, eflags: 0x4
// Checksum 0xb810ddf3, Offset: 0x1c4e
// Size: 0x7a
function private function_3481beea2325efe( bomb, pair_radius, current_time )
{
    var_c29b1759244ddb76 = bomb.var_8c9a05522d20651b ?? bomb.bomb_start_time;
    pair_angle = bomb.var_bcdca5c4020b23e7 + ( current_time - var_c29b1759244ddb76 ) / 1000 * 180;
    return ( cos( pair_angle ) * pair_radius, sin( pair_angle ) * pair_radius, 0 );
}

// Namespace zombie_weyward_bomb_attack
// Params 2, eflags: 0x4
// Checksum 0x5297f676, Offset: 0x1cd1
// Size: 0x12a
function private function_f1819b12165ab92b( pair_leader, target )
{
    var_9bcca5ebe8576b01 = pair_leader.var_b5850e953dad7c3d - target.origin;
    var_9bcca5ebe8576b01 = ( var_9bcca5ebe8576b01[ 0 ], var_9bcca5ebe8576b01[ 1 ], 0 );
    
    if ( length2dsquared( var_9bcca5ebe8576b01 ) <= 0.1 )
    {
        var_9bcca5ebe8576b01 = ( 1, 0, 0 );
    }
    
    clockwise_tangent = vectornormalize( ( var_9bcca5ebe8576b01[ 1 ], var_9bcca5ebe8576b01[ 0 ] * -1, 0 ) );
    counter_clockwise_tangent = vectornormalize( ( var_9bcca5ebe8576b01[ 1 ] * -1, var_9bcca5ebe8576b01[ 0 ], 0 ) );
    current_speed = length( pair_leader.var_5d1913cd72eb6315 );
    
    if ( current_speed > 0.1 )
    {
        current_dir = vectornormalize( pair_leader.var_5d1913cd72eb6315 );
        pair_leader.var_645610e5a816e66f = vectordot( current_dir, clockwise_tangent ) >= vectordot( current_dir, counter_clockwise_tangent );
        pair_leader.var_aa66654bc2e8345 = current_dir;
    }
    else
    {
        pair_leader.var_aa66654bc2e8345 = clockwise_tangent;
    }
    
    pair_leader.var_5226690a64aff34a = 1;
    pair_leader.var_b740ca4c85393673 = gettime();
}

// Namespace zombie_weyward_bomb_attack
// Params 7, eflags: 0x4
// Checksum 0x8969704d, Offset: 0x1e03
// Size: 0x36a
function private function_25dd1ab6d8f25ed( pair_leader, target, speed, orbit_radius, var_ab4d2d6667f449f9, dt, current_time )
{
    pair_center = pair_leader.var_b5850e953dad7c3d;
    dir_to_target = target.origin - pair_center;
    dir_to_target = ( dir_to_target[ 0 ], dir_to_target[ 1 ], 0 );
    dist_to_target = length( dir_to_target );
    current_speed = length( pair_leader.var_5d1913cd72eb6315 );
    
    if ( !pair_leader.var_5226690a64aff34a )
    {
        passing_target = dist_to_target <= orbit_radius * 1.5 && current_speed > 0.1 && vectordot( pair_leader.var_5d1913cd72eb6315, dir_to_target ) <= 0;
        
        if ( dist_to_target <= orbit_radius || passing_target )
        {
            function_f1819b12165ab92b( pair_leader, target );
        }
    }
    
    if ( pair_leader.var_5226690a64aff34a && dist_to_target > var_ab4d2d6667f449f9 )
    {
        pair_leader.var_5226690a64aff34a = 0;
        pair_leader.var_b740ca4c85393673 = 0;
        pair_leader.var_aa66654bc2e8345 = undefined;
    }
    
    if ( pair_leader.var_5226690a64aff34a )
    {
        var_9bcca5ebe8576b01 = pair_center - target.origin;
        var_9bcca5ebe8576b01 = ( var_9bcca5ebe8576b01[ 0 ], var_9bcca5ebe8576b01[ 1 ], 0 );
        radial_dist = length( var_9bcca5ebe8576b01 );
        radial_dir = radial_dist > 0.1 ? vectornormalize( var_9bcca5ebe8576b01 ) : ( 1, 0, 0 );
        tangent_dir = pair_leader.var_645610e5a816e66f ? ( radial_dir[ 1 ], radial_dir[ 0 ] * -1, 0 ) : ( radial_dir[ 1 ] * -1, radial_dir[ 0 ], 0 );
        radius_error = ( radial_dist - orbit_radius ) / max( orbit_radius, 1 );
        orbit_dir = vectornormalize( tangent_dir - radial_dir * clamp( radius_error, -0.75, 0.75 ) );
        blend_t = clamp( ( current_time - pair_leader.var_b740ca4c85393673 ) / 500, 0, 1 );
        entry_dir = pair_leader.var_aa66654bc2e8345 ?? orbit_dir;
        desired_dir = vectornormalize( lerp( entry_dir, orbit_dir, blend_t ) );
        current_dir = current_speed > 0.1 ? vectornormalize( pair_leader.var_5d1913cd72eb6315 ) : desired_dir;
        steer_t = clamp( dt * 6, 0, 1 );
        var_6cc8092f0f494598 = vectornormalize( lerp( current_dir, desired_dir, steer_t ) );
        pair_leader.var_5d1913cd72eb6315 = var_6cc8092f0f494598 * speed;
    }
    else if ( dist_to_target > 0.1 )
    {
        desired_dir = vectornormalize( dir_to_target );
        current_dir = current_speed > 0.1 ? vectornormalize( pair_leader.var_5d1913cd72eb6315 ) : desired_dir;
        steer_t = clamp( dt * 2, 0, 1 );
        var_6cc8092f0f494598 = vectornormalize( lerp( current_dir, desired_dir, steer_t ) );
        pair_leader.var_5d1913cd72eb6315 = var_6cc8092f0f494598 * speed;
    }
    else
    {
        pair_leader.var_5d1913cd72eb6315 = ( 0, 0, 0 );
    }
    
    pair_leader.var_b5850e953dad7c3d = pair_center + pair_leader.var_5d1913cd72eb6315 * dt;
}

// Namespace zombie_weyward_bomb_attack
// Params 4, eflags: 0x4
// Checksum 0xc42a7a02, Offset: 0x2175
// Size: 0x4b
function private function_a45b357a6a028240( bomb, pair_leader, pair_radius, current_time )
{
    pair_offset = function_3481beea2325efe( bomb, pair_radius, current_time );
    return pair_leader.var_b5850e953dad7c3d + pair_offset;
}

// Namespace zombie_weyward_bomb_attack
// Params 3, eflags: 0x4
// Checksum 0x8501acde, Offset: 0x21c9
// Size: 0x73
function private function_5b96c3914baa7a60( pair_leader, pair_radius, current_time )
{
    pair_leader.var_bc2f36d2c05b2942 = function_a45b357a6a028240( pair_leader, pair_leader, pair_radius, current_time );
    
    if ( isalive( pair_leader.bomb_partner ) )
    {
        pair_leader.bomb_partner.var_bc2f36d2c05b2942 = function_a45b357a6a028240( pair_leader.bomb_partner, pair_leader, pair_radius, current_time );
    }
}

// Namespace zombie_weyward_bomb_attack
// Params 4, eflags: 0x4
// Checksum 0x3c9452, Offset: 0x2244
// Size: 0xb1
function private function_c12d038f1afdc666( bomb, carrier, var_633ddc8103eace6, dt )
{
    prev_anchor_pos = bomb.var_f6a680bb6b2a59e4 ?? var_633ddc8103eace6;
    move_delta = var_633ddc8103eace6 - prev_anchor_pos;
    move_delta = ( move_delta[ 0 ], move_delta[ 1 ], 0 );
    bomb.var_f6a680bb6b2a59e4 = var_633ddc8103eace6;
    
    if ( length( move_delta ) <= 0.1 )
    {
        bomb.bomb_velocity = ( 0, 0, 0 );
        return var_633ddc8103eace6;
    }
    
    bomb.bomb_velocity = move_delta / max( dt, 0.001 );
    return var_633ddc8103eace6;
}

// Namespace zombie_weyward_bomb_attack
// Params 5, eflags: 0x4
// Checksum 0x38c6017d, Offset: 0x22fe
// Size: 0xbe
function private function_126881e74bcba163( bomb, carrier, var_633ddc8103eace6, current_time, dt )
{
    new_pos = function_c12d038f1afdc666( bomb, carrier, var_633ddc8103eace6, dt );
    var_48aa9c0805e5977b = function_d152b8b6ab519faa( bomb, current_time );
    bob = function_fc5a8e7a49fde49e( bomb, current_time );
    carrier.origin = new_pos + var_48aa9c0805e5977b * dt + bob * dt;
    
    if ( length( bomb.bomb_velocity ) > 0.1 )
    {
        carrier.angles = ( 0, vectortoangles( bomb.bomb_velocity )[ 1 ], 0 );
    }
}

// Namespace zombie_weyward_bomb_attack
// Params 1, eflags: 0x4
// Checksum 0xb25074ff, Offset: 0x23c4
// Size: 0x63
function private function_9c67258fcc4c1d0e( bomb )
{
    bomb.var_1f19a019e5ca746b = 0;
    bomb.var_ca553453d5bdfb45 = 0;
    bomb.bomb_partner = undefined;
    bomb.var_b41482b47b412931 = 0;
    bomb.var_bc2f36d2c05b2942 = bomb.var_f6a680bb6b2a59e4 ?? bomb.origin;
}

// Namespace zombie_weyward_bomb_attack
// Params 3, eflags: 0x4
// Checksum 0x71087d43, Offset: 0x242f
// Size: 0x9ae
function private function_8820eec5ccbe60ed( bomb, carrier, var_6d459758e3503c2e )
{
    self endon( #"death" );
    bomb endon( #"death" );
    emp_level = get_empowerment_level();
    lifetime_ms = getdvarfloat( @"hash_fc2f2ea07b261e84", self.var_4d76aa6108c4d1d2 ) * 1000;
    speed = getdvarfloat( @"hash_e80140732e10b8fc", emp_level >= 1 ? self.var_57337cb6095c351d : self.bomb_speed );
    homing = getdvarfloat( @"hash_651a0ebc8c7353f7", emp_level >= 1 ? self.var_95fa92da38b854e4 : self.var_174ca7feb8617c45 );
    orbit_radius = max( getdvarfloat( @"hash_e4e8d8f75993d29a", self.var_c52b88ee46294294 ), 1 );
    var_ab4d2d6667f449f9 = max( getdvarfloat( @"hash_43e41f634ab5b52a", self.var_2dd37e6a67b02254 ), orbit_radius + 1 );
    var_b6cd119d239a4d77 = 500;
    var_def04cc17812b267 = 6;
    start_time = gettime();
    var_48ee71281f56f926 = start_time;
    trace_contents = trace::create_contents( 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0 );
    
    while ( isalive( bomb ) )
    {
        current_time = gettime();
        dt = clamp( ( current_time - var_48ee71281f56f926 ) / 1000, 0, 0.1 );
        var_48ee71281f56f926 = current_time;
        
        if ( dt <= 0 )
        {
            waitframe();
            continue;
        }
        
        if ( current_time - start_time >= lifetime_ms )
        {
            function_4268ec65442d96f4( bomb, carrier );
            return;
        }
        
        if ( bomb.var_1f19a019e5ca746b && !bomb.var_ca553453d5bdfb45 )
        {
            if ( !isalive( bomb.bomb_partner ) )
            {
                function_9c67258fcc4c1d0e( bomb );
            }
            
            waitframe();
            continue;
        }
        
        var_751d76a6a505a10c = 0;
        target = function_c003023bcaad1b56( bomb, carrier, var_6d459758e3503c2e );
        
        if ( isdefined( target ) )
        {
            var_751d76a6a505a10c = bomb.var_1f19a019e5ca746b && isalive( bomb.bomb_partner );
            
            if ( var_751d76a6a505a10c )
            {
                pair_leader = bomb;
                pair_follower = bomb.bomb_partner;
                pair_radius = max( orbit_radius * 0.6, 120 );
                
                if ( !pair_leader.var_b41482b47b412931 )
                {
                    function_dcafad19f19db128( pair_leader, carrier, pair_follower, pair_follower.bomb_carrier );
                    pair_leader.var_8c9a05522d20651b = current_time;
                    pair_follower.var_8c9a05522d20651b = current_time;
                    pair_leader.var_b41482b47b412931 = 1;
                    pair_follower.var_b41482b47b412931 = 1;
                    function_5b96c3914baa7a60( pair_leader, pair_radius, current_time );
                }
                else
                {
                    function_25dd1ab6d8f25ed( pair_leader, target, speed, orbit_radius, var_ab4d2d6667f449f9, dt, current_time );
                    function_5b96c3914baa7a60( pair_leader, pair_radius, current_time );
                }
                
                var_633ddc8103eace6 = pair_leader.var_bc2f36d2c05b2942;
                follower_anchor_pos = pair_follower.var_bc2f36d2c05b2942;
                target_pos = target.origin;
                bomb.bomb_orbiting = 0;
                bomb.var_38fe5035432805a2 = 0;
                bomb.var_3b0de3b07d309162 = undefined;
            }
            else
            {
                if ( bomb.var_1f19a019e5ca746b )
                {
                    function_9c67258fcc4c1d0e( bomb );
                }
                
                target_pos = target.origin;
            }
        }
        else
        {
            if ( bomb.var_1f19a019e5ca746b )
            {
                if ( isalive( bomb.bomb_partner ) )
                {
                    function_9c67258fcc4c1d0e( bomb.bomb_partner );
                }
                
                function_9c67258fcc4c1d0e( bomb );
            }
            
            current_speed = length( bomb.bomb_velocity );
            drift_dir = current_speed > 0.1 ? vectornormalize( bomb.bomb_velocity ) : ( 1, 0, 0 );
            target_pos = carrier.origin + drift_dir * 500;
        }
        
        dir_to_target = target_pos - carrier.origin;
        dir_to_target = ( dir_to_target[ 0 ], dir_to_target[ 1 ], 0 );
        dist_to_target = length( dir_to_target );
        current_speed = length( bomb.bomb_velocity );
        
        if ( isdefined( target ) && !var_751d76a6a505a10c && !bomb.bomb_orbiting )
        {
            passing_target = dist_to_target <= orbit_radius * 1.5 && current_speed > 0.1 && vectordot( bomb.bomb_velocity, dir_to_target ) <= 0;
            
            if ( dist_to_target <= orbit_radius || passing_target )
            {
                function_87e3d1d029000a8c( bomb, carrier, target );
            }
        }
        
        if ( bomb.bomb_orbiting && isdefined( target ) && !var_751d76a6a505a10c )
        {
            if ( dist_to_target > var_ab4d2d6667f449f9 )
            {
                bomb.bomb_orbiting = 0;
                bomb.var_38fe5035432805a2 = 0;
                bomb.var_3b0de3b07d309162 = undefined;
            }
        }
        
        new_pos = undefined;
        
        if ( var_751d76a6a505a10c )
        {
            trace_result = trace::ray_trace( carrier.origin, var_633ddc8103eace6, undefined, trace_contents );
            
            if ( trace_result[ "fraction" ] < 1 )
            {
                function_9c67258fcc4c1d0e( pair_follower );
                function_4268ec65442d96f4( bomb, carrier );
                return;
            }
            
            follower_trace_result = trace::ray_trace( pair_follower.bomb_carrier.origin, follower_anchor_pos, undefined, trace_contents );
            
            if ( follower_trace_result[ "fraction" ] < 1 )
            {
                function_9c67258fcc4c1d0e( bomb );
                function_4268ec65442d96f4( pair_follower, pair_follower.bomb_carrier );
                var_751d76a6a505a10c = 0;
                target_pos = target.origin;
            }
            else
            {
                function_126881e74bcba163( bomb, carrier, var_633ddc8103eace6, current_time, dt );
                function_126881e74bcba163( pair_follower, pair_follower.bomb_carrier, follower_anchor_pos, current_time, dt );
                waitframe();
                continue;
            }
        }
        else if ( bomb.bomb_orbiting && isdefined( target ) && !var_751d76a6a505a10c )
        {
            var_9bcca5ebe8576b01 = carrier.origin - target.origin;
            var_9bcca5ebe8576b01 = ( var_9bcca5ebe8576b01[ 0 ], var_9bcca5ebe8576b01[ 1 ], 0 );
            radial_dist = length( var_9bcca5ebe8576b01 );
            radial_dir = radial_dist > 0.1 ? vectornormalize( var_9bcca5ebe8576b01 ) : ( 1, 0, 0 );
            tangent_dir = bomb.var_4505f320b5979ab8 ? ( radial_dir[ 1 ], radial_dir[ 0 ] * -1, 0 ) : ( radial_dir[ 1 ] * -1, radial_dir[ 0 ], 0 );
            radius_error = ( radial_dist - orbit_radius ) / max( orbit_radius, 1 );
            orbit_dir = vectornormalize( tangent_dir - radial_dir * clamp( radius_error, -0.75, 0.75 ) );
            blend_t = clamp( ( current_time - bomb.var_38fe5035432805a2 ) / var_b6cd119d239a4d77, 0, 1 );
            entry_dir = bomb.var_3b0de3b07d309162 ?? orbit_dir;
            desired_dir = vectornormalize( lerp( entry_dir, orbit_dir, blend_t ) );
            current_dir = current_speed > 0.1 ? vectornormalize( bomb.bomb_velocity ) : desired_dir;
            steer_t = clamp( dt * var_def04cc17812b267, 0, 1 );
            var_6cc8092f0f494598 = vectornormalize( lerp( current_dir, desired_dir, steer_t ) );
            bomb.bomb_velocity = var_6cc8092f0f494598 * speed;
        }
        else if ( dist_to_target > 0.1 )
        {
            desired_dir = vectornormalize( dir_to_target );
            current_dir = current_speed > 0.1 ? vectornormalize( bomb.bomb_velocity ) : desired_dir;
            steer_t = clamp( homing * dt * 2, 0, 1 );
            var_6cc8092f0f494598 = vectornormalize( lerp( current_dir, desired_dir, steer_t ) );
            bomb.bomb_velocity = var_6cc8092f0f494598 * speed;
        }
        
        if ( !isdefined( new_pos ) )
        {
            new_pos = carrier.origin + bomb.bomb_velocity * dt;
        }
        
        trace_result = trace::ray_trace( carrier.origin, new_pos, undefined, trace_contents );
        
        if ( trace_result[ "fraction" ] < 1 )
        {
            function_4268ec65442d96f4( bomb, carrier );
            return;
        }
        
        var_48aa9c0805e5977b = function_d152b8b6ab519faa( bomb, current_time );
        bob = function_fc5a8e7a49fde49e( bomb, current_time );
        organic_offset = var_48aa9c0805e5977b * dt + bob * dt;
        carrier.origin = new_pos + organic_offset;
        
        if ( length( bomb.bomb_velocity ) > 0.1 )
        {
            carrier.angles = ( 0, vectortoangles( bomb.bomb_velocity )[ 1 ], 0 );
        }
        
        /#
            if ( debug_bomb() )
            {
                remaining_s = ( lifetime_ms - current_time - start_time ) / 1000;
                line( carrier.origin, target_pos, ( 1, 0.4, 0 ) );
                sphere( carrier.origin, 25, ( 1, 0.4, 0 ) );
                print3d( carrier.origin + ( 0, 0, 50 ), "<dev string:x46>" + int( remaining_s ) + "<dev string:x4c>" + bomb.health, ( 1, 0.5, 0 ), 1, 0.5 );
            }
        #/
        
        waitframe();
    }
}

// Namespace zombie_weyward_bomb_attack
// Params 3, eflags: 0x4
// Checksum 0x90c322cb, Offset: 0x2de5
// Size: 0x25b
function private function_ff4a1a2550ff1fa1( bomb, carrier, var_6d459758e3503c2e )
{
    self endon( #"death" );
    bomb endon( #"death" );
    emit_interval = getdvarfloat( @"hash_d1cb0b6eeb267434", self.var_36b553e34a8b16f2 );
    var_5a1b31e3007578c = getdvarfloat( @"hash_dc4f33bd18609ed0", self.var_f9d7e3faad4ea401 );
    var_208efdb0ab485efd = max( getdvarfloat( @"hash_b98204ead3dc1c93", self.var_84d0db36839c456a ), 0.01 );
    var_76b1dfebd39c5f02 = getdvarint( @"hash_513a8f4234f58691", get_empowerment_level() >= 2 ? self.var_fc0bf852e19ab29a : self.var_ef6ab62ba4f42d67 );
    emit_radius = getdvarfloat( @"hash_7c880c518e1fc2d1", self.var_34dae70a981d0ba3 );
    
    if ( var_76b1dfebd39c5f02 <= 0 )
    {
        return;
    }
    
    bomb.var_1f02b0c7c2ac0374 = undefined;
    
    while ( true )
    {
        var_fff4cb9244f92112 = emit_interval;
        target = function_c003023bcaad1b56( bomb, carrier, var_6d459758e3503c2e );
        
        if ( isalive( target ) && carrier.origin && target.origin && var_5a1b31e3007578c > 0 && distance2dsquared( carrier.origin, target.origin ) <= squared( var_5a1b31e3007578c ) )
        {
            var_fff4cb9244f92112 = var_208efdb0ab485efd;
        }
        
        wait var_fff4cb9244f92112;
        
        if ( !isalive( bomb ) )
        {
            return;
        }
        
        start_yaw = randomfloat( 360 );
        add_yaw = 360 / var_76b1dfebd39c5f02;
        
        for ( i = 0; i < var_76b1dfebd39c5f02 ; i++ )
        {
            landing_angle = start_yaw + add_yaw * i;
            landing_pos = carrier.origin + ( cos( landing_angle ) * emit_radius, sin( landing_angle ) * emit_radius, -300 );
            bomb function_bbe7558469dbd83e( self, carrier.origin, landing_pos );
        }
        
        bomb.var_1f02b0c7c2ac0374 = start_yaw + add_yaw / 2;
        
        /#
            if ( debug_bomb() )
            {
                println( "<dev string:x53>" + var_76b1dfebd39c5f02 + "<dev string:x6b>" );
            }
        #/
    }
}

// Namespace zombie_weyward_bomb_attack
// Params 3, eflags: 0x4
// Checksum 0x2f294870, Offset: 0x3048
// Size: 0x108
function private function_bbe7558469dbd83e( owner, start_pos, target_pos )
{
    skull_speed = getdvarfloat( @"hash_26b3b1384b252f9e", owner.var_7d15a46c000f1df0 );
    var_ee6433c31961982d = target_pos - start_pos;
    
    if ( length2dsquared( var_ee6433c31961982d ) == 0 )
    {
        /#
            iprintln( "<dev string:x7b>" );
        #/
        
        return;
    }
    
    gravity = 800;
    time = length( ( var_ee6433c31961982d[ 0 ], var_ee6433c31961982d[ 1 ], 0 ) ) / skull_speed;
    launch_speed_z = ( 0.5 * gravity * squared( time ) + var_ee6433c31961982d[ 2 ] ) / time;
    var_ee6433c31961982d = vectornormalize( ( var_ee6433c31961982d[ 0 ], var_ee6433c31961982d[ 1 ], 0 ) );
    utility::function_7c10ea82c1e305b8( "flash", "on" );
    var_dcee11752ff222a4 = magicgrenademanual( self.grenadeweapon, start_pos, ( var_ee6433c31961982d[ 0 ] * skull_speed, var_ee6433c31961982d[ 1 ] * skull_speed, launch_speed_z ), 10, owner );
    owner thread function_eb208e98aaf0744e( var_dcee11752ff222a4 );
}

// Namespace zombie_weyward_bomb_attack
// Params 4, eflags: 0x4
// Checksum 0xe3682d74, Offset: 0x3158
// Size: 0x161
function private function_121878fa916990f6( center, radius, var_8f98d87abe348e13, min_dmg )
{
    if ( radius <= 0 || var_8f98d87abe348e13 <= 0 )
    {
        return;
    }
    
    radiussq = squared( radius );
    
    foreach ( target in getplayersinradius( center, radius ) )
    {
        if ( target === self || !isalive( target ) || target.team === self.team )
        {
            continue;
        }
        
        if ( !isplayer( target ) )
        {
            continue;
        }
        
        frac = clamp( distancesquared( center, target.origin ) / radiussq, 0, 1 );
        dmg = int( var_8f98d87abe348e13 - ( var_8f98d87abe348e13 - min_dmg ) * frac );
        dmg = min( dmg, target.health - 1 );
        
        if ( dmg >= target.health )
        {
            continue;
        }
        
        target dodamage( dmg, center, self, self );
    }
}

// Namespace zombie_weyward_bomb_attack
// Params 1, eflags: 0x4
// Checksum 0x7280598b, Offset: 0x32c1
// Size: 0x138
function private function_eb208e98aaf0744e( grenade )
{
    self endon( #"death" );
    grenade endon( #"delay_death" );
    grenade childthread delay_endon( "death" );
    grenade waittill( #"explode", position, normal );
    normal = isvector( normal ) ? normal : ( 0, 0, 1 );
    emp_level = get_empowerment_level();
    splash_radius = getdvarfloat( @"hash_7c64211416779537", emp_level >= 1 ? self.var_e63dd0310c59e5d1 : self.var_9bf3b5807ec9d019 );
    explode_damage = getdvarfloat( @"hash_db1ac14810f60a0", self.var_96d8f07fbf680e42 ) + get_emp_damage_bonus();
    
    if ( explode_damage > 0 )
    {
        function_121878fa916990f6( position, splash_radius, explode_damage, explode_damage );
    }
    
    explode_vfx = utility::getfx( emp_level >= 1 ? "weyward_bomb_explode_emp_fx" : "weyward_bomb_explode_fx" );
    
    if ( explode_vfx )
    {
        playfx( explode_vfx, position, undefined, normal );
    }
    
    playworldsound( position, #"hash_99b9a0d15a4960e4" );
}

// Namespace zombie_weyward_bomb_attack
// Params 1, eflags: 0x4
// Checksum 0xd2c9c85b, Offset: 0x3401
// Size: 0x1e
function private delay_endon( string )
{
    self waittill( string );
    waitframe();
    self notify( "delay_" + string );
}

// Namespace zombie_weyward_bomb_attack
// Params 2, eflags: 0x4
// Checksum 0xa4d6b065, Offset: 0x3427
// Size: 0xcf
function private function_ed40b3d7c3c5d128( pool_pos, pool_radius )
{
    self endon( #"death" );
    duration_s = getdvarfloat( @"hash_e370b41a0773a10e", self.var_27361acf169d1dbc );
    tick_damage = getdvarfloat( @"hash_3fbebf7ad39eb09f", self.var_cf37fe9c1e94f08d );
    start_time = gettime();
    last_tick = gettime();
    tick_ms = 1000;
    
    while ( gettime() - start_time < duration_s * 1000 )
    {
        if ( gettime() - last_tick >= tick_ms )
        {
            last_tick = gettime();
            function_121878fa916990f6( pool_pos, pool_radius, int( tick_damage ), int( tick_damage ) );
        }
        
        wait 0.1;
    }
}

// Namespace zombie_weyward_bomb_attack
// Params 2, eflags: 0x4
// Checksum 0xeca26071, Offset: 0x34fe
// Size: 0x192
function private function_4268ec65442d96f4( bomb, carrier )
{
    if ( !isalive( bomb ) )
    {
        return;
    }
    
    var_ed8bab9657750de2 = carrier.origin;
    explosion_damage = getdvarfloat( @"hash_3baf984ef7203ee4", self.bomb_explosion_damage ) + get_emp_damage_bonus();
    explosion_radius = getdvarfloat( @"hash_588b2680714b9877", self.bomb_explosion_radius );
    skull_count = getdvarint( @"hash_5efca4605fce5b53", self.var_dfe787d378520a8d );
    function_121878fa916990f6( var_ed8bab9657750de2, explosion_radius, int( explosion_damage ), int( explosion_damage * 0.5 ) );
    playworldsound( var_ed8bab9657750de2, #"hash_495a243f11a56093" );
    start_yaw = bomb.var_1f02b0c7c2ac0374 ?? randomfloat( 360 );
    add_yaw = 360 / max( 1, skull_count );
    
    for ( i = 0; i < skull_count ; i++ )
    {
        landing_angle = start_yaw + add_yaw * i;
        landing_pos = var_ed8bab9657750de2 + ( cos( landing_angle ) * explosion_radius, sin( landing_angle ) * explosion_radius, -300 );
        bomb function_bbe7558469dbd83e( self, var_ed8bab9657750de2, landing_pos );
    }
    
    /#
        if ( debug_bomb() )
        {
            println( "<dev string:xb4>" + var_ed8bab9657750de2 + "<dev string:xd0>" + explosion_damage );
        }
    #/
    
    bomb.forceannihilate = 1;
    bomb kill( var_ed8bab9657750de2, self );
}

// Namespace zombie_weyward_bomb_attack
// Params 1, eflags: 0x4
// Checksum 0xf33d3ebc, Offset: 0x3698
// Size: 0xa8
function private function_89e3ded9a6fe3643( bomb )
{
    self endon( #"death" );
    bomb waittill( #"death" );
    
    if ( isalive( bomb.bomb_partner ) )
    {
        function_9c67258fcc4c1d0e( bomb.bomb_partner );
    }
    
    function_1cad4d9ecec246dc( bomb );
    
    if ( self.bomb_active_count <= 0 )
    {
        self.bomb_attack_active = 0;
        self.bomb_projectile = undefined;
        self.bomb_last_attack_time = gettime();
    }
    
    /#
        if ( debug_bomb() )
        {
            println( "<dev string:xd7>" + self.bomb_active_count + "<dev string:xf9>" );
        }
    #/
}

// Namespace zombie_weyward_bomb_attack
// Params 1, eflags: 0x4
// Checksum 0x867ac074, Offset: 0x3748
// Size: 0x45
function private function_4f7a9c2f9bd317b0( bomb )
{
    bomb endon( #"death" );
    self waittill( #"death" );
    bomb.forceannihilate = 1;
    bomb kill( self.origin, self );
}

// Namespace zombie_weyward_bomb_attack
// Params 2, eflags: 0x4
// Checksum 0x5aba378c, Offset: 0x3795
// Size: 0xa7
function private function_d152b8b6ab519faa( bomb, current_time )
{
    wobble_amp = getdvarfloat( @"hash_5c4fb5de92349dad", self.var_698bd458cb217313 );
    wobble_freq = getdvarfloat( @"hash_f72a4217fc359fb", self.var_9759bc8bf4a77945 );
    time_s = ( current_time - bomb.bomb_start_time ) / 1000;
    phase = time_s * wobble_freq * 360;
    return ( sin( phase ) * wobble_amp, cos( phase * 1.3 ) * wobble_amp * 0.7, 0 );
}

// Namespace zombie_weyward_bomb_attack
// Params 2, eflags: 0x4
// Checksum 0xd08fb370, Offset: 0x3845
// Size: 0x93
function private function_fc5a8e7a49fde49e( bomb, current_time )
{
    bob_amp = getdvarfloat( @"hash_2f175257401dc6e1", self.var_defd4243f03167a7 );
    bob_freq = getdvarfloat( @"hash_ccfaccc48136d39f", self.var_1aa6e3f2fc788d29 );
    time_s = ( current_time - bomb.bomb_start_time ) / 1000;
    phase = time_s * bob_freq * 360;
    return ( 0, 0, sin( phase ) * bob_amp );
}

/#

    // Namespace zombie_weyward_bomb_attack
    // Params 0, eflags: 0x4
    // Checksum 0xe0670bf5, Offset: 0x38e1
    // Size: 0x44, Type: dev
    function private init_bomb_attack_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x113>" );
        devgui::add_devgui_func( "<dev string:x138>", "<dev string:x14a>", &function_69c17ba5bd52218a );
        devgui::add_devgui_func( "<dev string:x164>", "<dev string:x176>", &devgui_toggle_debug );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_weyward_bomb_attack
    // Params 1, eflags: 0x4
    // Checksum 0xdf549024, Offset: 0x392d
    // Size: 0x78, Type: dev
    function private function_69c17ba5bd52218a( params )
    {
        weyward = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x190>" );
        
        if ( !isdefined( weyward ) || !isalive( level.players[ 0 ] ) )
        {
            return;
        }
        
        weyward.bomb_attack_target = level.players[ 0 ];
        weyward namespace_77f0670c8a2e733c::function_d7144ac95cf9f789();
    }

    // Namespace zombie_weyward_bomb_attack
    // Params 1, eflags: 0x4
    // Checksum 0x2b4a4fd1, Offset: 0x39ad
    // Size: 0x24, Type: dev
    function private devgui_toggle_debug( params )
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x19f>", @"hash_d167afc3500ce0f5" );
    }

    // Namespace zombie_weyward_bomb_attack
    // Params 0, eflags: 0x4
    // Checksum 0x9a8c9759, Offset: 0x39d9
    // Size: 0x16, Type: dev
    function private debug_bomb()
    {
        return getdvarint( @"hash_d167afc3500ce0f5", 0 ) > 0;
    }

#/
