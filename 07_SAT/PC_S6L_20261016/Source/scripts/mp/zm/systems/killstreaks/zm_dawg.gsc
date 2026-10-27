// scripts\mp\zm\systems\killstreaks\zm_dawg.gsc  (hash_4d83c3cced6c831e.gscc) (size: 6031 Bytes / 0x178f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xca5f027e (3395224190)
// size ...... 6031 (0x178f)
// includes .. 9   (offset: 0x1653)
// strings ... 17  (offset: 0x169b)
// dev strs .. 0   (offset: 0x178f)
// exports ... 20  (offset: 0xc7b)
// cseg ...... 0x184 + 0xaf7 (0xc7b)
// imports ... 58  (offset: 0xf9b)
// animtree1 . 0   (offset: 0x178f)
// animtree2 . 0   (offset: 0x178f)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\zombie_base\zombie_base_dismemberment;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\zm\systems\zone_manager;

#namespace zm_dawg;

// Namespace zm_dawg
// Params 0, eflags: 0x1
// Checksum 0x278646bc, Offset: 0x1a2
// Size: 0x131
function autoexec main()
{
    utility::registersharedfunc( #"dawg", #"hash_763484c87294246c", &function_dd12de314c28a2eb );
    utility::registersharedfunc( #"dawg", #"spawn_dawg", &zm_spawn_dawg );
    utility::registersharedfunc( #"dawg", #"hash_68c0b8ef4583cbb9", &function_2bb013938b68a9d1 );
    utility::registersharedfunc( #"dawg", #"hash_5443535d3275b9e5", &get_airspace_contents );
    utility::registersharedfunc( #"dawg", #"dawg_crate_drop", &dawg_crate_drop );
    utility::registersharedfunc( #"dawg", #"hash_145e09e77210f5b0", &function_8d970c15fa865681 );
    utility::registersharedfunc( #"dawg", #"dawg_turret_can_see", &function_bcd59dee1ccdee70 );
    utility::registersharedfunc( #"dawg", #"hash_28d193e27816d942", &function_5b2b90f46c3e4683 );
    utility::registersharedfunc( #"dawg", #"teleport_dawg", &teleport_dawg );
    level._effect[ "portal_spawn" ] = loadfxasset( "vfx_t10_gameplay_zm_trials_machine_spawn" );
    level thread register_on_kill_medal();
}

// Namespace zm_dawg
// Params 1
// Checksum 0x82c65b47, Offset: 0x2db
// Size: 0x15
function function_5b2b90f46c3e4683( streak_info )
{
    thread function_d3978434519fd4be( streak_info );
}

// Namespace zm_dawg
// Params 0, eflags: 0x4
// Checksum 0x62e149ba, Offset: 0x2f8
// Size: 0x2a
function private zm_spawn_dawg()
{
    val::set( "dawg", "ignoreme", 1 );
    self.aisettings.var_48e1c5af483f698d = 0;
}

// Namespace zm_dawg
// Params 1, eflags: 0x4
// Checksum 0x877e4a85, Offset: 0x32a
// Size: 0x29
function private function_dd12de314c28a2eb( pos )
{
    zone_struct = zone_manager::function_90e5c3e2272b0130( pos );
    return function_c12335ae844fbab8( zone_struct, [] );
}

// Namespace zm_dawg
// Params 1, eflags: 0x4
// Checksum 0x5dd9075d, Offset: 0x35c
// Size: 0x35
function private function_8d970c15fa865681( pos )
{
    zone_struct = zone_manager::function_90e5c3e2272b0130( pos );
    return function_c12335ae844fbab8( zone_struct, level.var_796be4543cb83fec ?? [] );
}

// Namespace zm_dawg
// Params 2, eflags: 0x4
// Checksum 0x3aa9c3f7, Offset: 0x39a
// Size: 0x57, Type: bool
function private function_c12335ae844fbab8( zone_struct, var_fc86c060a1ba65fb )
{
    if ( !zone_struct || !zone_struct.is_enabled )
    {
        return false;
    }
    
    if ( function_d47ce61953ccdf2( zone_struct, level.var_82608d37301e46de ?? [] ) )
    {
        return false;
    }
    
    if ( function_d47ce61953ccdf2( zone_struct, var_fc86c060a1ba65fb ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_dawg
// Params 2, eflags: 0x4
// Checksum 0xf3fd8bf4, Offset: 0x3fa
// Size: 0x62, Type: bool
function private function_d47ce61953ccdf2( zone_struct, blocked_zones )
{
    if ( !blocked_zones.size )
    {
        return false;
    }
    
    return zone_struct.script_zone_name && arraycontains( blocked_zones, zone_struct.script_zone_name ) || zone_struct.zone_name && arraycontains( blocked_zones, zone_struct.zone_name );
}

// Namespace zm_dawg
// Params 0, eflags: 0x4
// Checksum 0xc8696e2b, Offset: 0x465
// Size: 0x12
function private function_1f588ad2ad63f1e2()
{
    if ( namespace_b76ff2659823e89d::is_crawling() )
    {
        return function_2bb013938b68a9d1();
    }
}

// Namespace zm_dawg
// Params 0
// Checksum 0x396f887e, Offset: 0x480
// Size: 0x28
function function_2bb013938b68a9d1()
{
    if ( isdefined( self ) )
    {
        if ( namespace_b76ff2659823e89d::is_crawling() )
        {
            hit_loc = self.origin;
            return hit_loc;
        }
    }
}

// Namespace zm_dawg
// Params 0
// Checksum 0xdb9d77ab, Offset: 0x4b1
// Size: 0x18
function get_airspace_contents()
{
    return trace::create_contents( 0, 1, 1, 1, 1, 1, 1, 0, 0, 0 );
}

// Namespace zm_dawg
// Params 6
// Checksum 0x58f2a3d, Offset: 0x4d2
// Size: 0x48
function dawg_crate_drop( bundle, vehiclename, owner, position, angles, streakinfo )
{
    thread function_f2ca36ca480161c2( bundle, vehiclename, owner, position, angles, streakinfo );
}

// Namespace zm_dawg
// Params 6
// Checksum 0x95ce7df6, Offset: 0x522
// Size: 0x110
function function_f2ca36ca480161c2( bundle, vehiclename, owner, position, angles, streakinfo )
{
    start_pos = position * ( 1, 1, 0 ) + ( 0, 0, airdrop::getscriptedhelidropheight( undefined, owner ) );
    portalscriptable = spawnscriptable( "sat_zm_spawn_portal", start_pos + ( 0, 0, 50 ) );
    portalscriptable setscriptablepartstate( "portal", "on" );
    wait 2;
    playfx( level._effect[ "portal_spawn" ], start_pos );
    wait 2;
    
    if ( isdefined( owner ) )
    {
        crate = airdrop::dropcrate( owner, owner.team, "dawg", start_pos, angles, position, undefined, undefined, undefined, streakinfo );
        crate thread function_d5bc2a14de5d5c5c();
    }
    
    portalscriptable setscriptablepartstate( "portal", "off" );
    wait 4;
    portalscriptable freescriptable();
}

// Namespace zm_dawg
// Params 0, eflags: 0x4
// Checksum 0x1c1fa8af, Offset: 0x63a
// Size: 0x1eb
function private function_d5bc2a14de5d5c5c()
{
    self endon( #"death" );
    self endon( #"crate_dropped" );
    
    while ( true )
    {
        wait 0.1;
        a_zombies = getaiarrayinradius( self.origin, 50, level.var_ece703e3d116381c );
        
        foreach ( zombie in a_zombies )
        {
            if ( !isalive( zombie ) || !zombie val::get( "damage" ) || !zombie istouching( self ) )
            {
                continue;
            }
            
            if ( zombie.magic_bullet_shield || zombie.damageshield || !zombie val::get( "death" ) )
            {
                continue;
            }
            
            if ( zombie.aicategory == "normal" )
            {
                zombie.forceannihilate = 1;
                zombie kill( self.origin, self.owner, self, "MOD_CRUSH" );
                continue;
            }
            
            if ( !isdefined( zombie.var_5abf183c3f38efb9 ) || utility::time_has_passed( zombie.var_5abf183c3f38efb9, 1 ) )
            {
                if ( zombie.health <= 1000 )
                {
                    zombie.forceannihilate = 1;
                }
                else
                {
                    zombie zombie_knockdown::function_6fc167d4a3590991( self.origin, 240, 30 );
                }
                
                zombie.var_5abf183c3f38efb9 = gettime();
                zombie dodamage( 1000, self.origin, self.owner, self, "MOD_CRUSH", "<explicitweaponnone>" );
            }
        }
    }
}

// Namespace zm_dawg
// Params 1, eflags: 0x4
// Checksum 0x8504b5ed, Offset: 0x82d
// Size: 0x4f
function private function_bcd59dee1ccdee70( target )
{
    b_is_last_zombie = utility::callsharedfunc( #"zombie", #"hash_55b419086029b9a2", target );
    
    if ( b_is_last_zombie && !target.ignore_enemy_count )
    {
        return 0;
    }
    
    return 1;
}

// Namespace zm_dawg
// Params 0, eflags: 0x4
// Checksum 0xbc81d9c9, Offset: 0x884
// Size: 0xd6
function private register_on_kill_medal()
{
    level utility::flag_wait( "StartGameTypeCallbackFinished" );
    
    if ( utility::issharedfuncdefined( #"medal", #"register_on_kill_medal_callback", 0 ) )
    {
        bundle = level.streakglobals.streakbundles[ "dawg" ];
        turretweaponname = bundle.var_6d133d06db83adf1 ?? "sat_dawg_turret_zm";
        missileturretweaponname = bundle.var_29bd0ff3ab031c0f ?? "sat_dawg_missile_turret_zm";
        
        if ( isdefined( turretweaponname ) )
        {
            utility::callsharedfunc( #"medal", #"register_on_kill_medal_callback", turretweaponname, &on_killed_medal );
        }
        
        if ( isdefined( missileturretweaponname ) )
        {
            utility::callsharedfunc( #"medal", #"register_on_kill_medal_callback", missileturretweaponname, &on_killed_medal );
        }
    }
}

// Namespace zm_dawg
// Params 4, eflags: 0x4
// Checksum 0x5c0d682a, Offset: 0x962
// Size: 0xef
function private on_killed_medal( victim, einflictor, smeansofdeath, sweapon )
{
    if ( utility::issharedfuncdefined( #"medal", #"track_rapid_kill", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"track_rapid_kill", "dawg", sweapon );
    }
    
    if ( isdefined( self.rapidkill_data ) )
    {
        if ( isdefined( self.rapidkill_data[ "dawg" ] ) && self.rapidkill_data[ "dawg" ].rapidkill_count === 10 )
        {
            namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_mans_best_friend" );
        }
    }
    
    if ( utility::issharedfuncdefined( #"medal", #"track_scorestreak_kill", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"track_scorestreak_kill", "dawg", victim );
    }
}

// Namespace zm_dawg
// Params 1
// Checksum 0x94a6c73e, Offset: 0xa59
// Size: 0xca
function function_d3978434519fd4be( streak_info )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"cancel_all_killstreak_deployments" );
    streak_info endon( #"killstreak_finished_with_deploy_weapon" );
    streak_info endon( #"killstreak_failed_use" );
    streak_info endon( #"deploy_finished" );
    
    while ( true )
    {
        if ( isdefined( level.var_7a5a3a48204781da ) && isdefined( streak_info.mpstreaksysteminfo ) && isdefined( streak_info.var_9384480e6997afd7 ) )
        {
            if ( !self [[ level.var_7a5a3a48204781da ]]( streak_info.mpstreaksysteminfo, streak_info.var_9384480e6997afd7 ) )
            {
                self setclientomnvar( "ui_turret_placement", 0 );
                killstreakdeploy::streakdeploy_cancelalldeployments();
                return;
            }
        }
        
        wait 0.5;
    }
}

// Namespace zm_dawg
// Params 2, eflags: 0x4
// Checksum 0xc8eb61a4, Offset: 0xb2b
// Size: 0x124, Type: bool
function private teleport_dawg( player, b_check_distance = 0 )
{
    if ( zone_manager::function_90e5c3e2272b0130( self.origin ) == player zone_manager::function_90e5c3e2272b0130( player.origin ) )
    {
        return false;
    }
    
    if ( b_check_distance && distancesquared( self.origin, player.origin ) <= 5760000 )
    {
        return false;
    }
    
    teleport_dir = anglestoforward( ( 0, player getplayerangles()[ 1 ], 0 ) );
    teleport_target = getclosestpointonnavmesh( player.origin + teleport_dir * 200, player );
    
    if ( !b_check_distance || !isdefined( teleport_target ) || !zone_manager::function_65305a611c6226d9( teleport_target ) )
    {
        teleport_target = getclosestpointonnavmesh( player.origin, player );
    }
    
    path_pts = self findpath( teleport_target, player getorigin() );
    
    if ( isdefined( teleport_target ) && isdefined( path_pts ) && zone_manager::function_65305a611c6226d9( teleport_target ) )
    {
        self setorigin( teleport_target );
        thread function_512171a4edec443d( self.origin );
        return true;
    }
    
    return false;
}

// Namespace zm_dawg
// Params 1, eflags: 0x4
// Checksum 0x83e4b338, Offset: 0xc58
// Size: 0x23
function private function_512171a4edec443d( origin )
{
    waitframe();
    playfx( level._effect[ "portal_spawn" ], origin );
}

