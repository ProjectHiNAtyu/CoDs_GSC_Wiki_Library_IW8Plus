// scripts\mp\zm\zm_utility.gsc  (hash_3ca070ee1ba8337c.gscc) (size: 32017 Bytes / 0x7d11 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x477bf2a4 (1199305380)
// size ...... 32017 (0x7d11)
// includes .. 31  (offset: 0x71d1)
// strings ... 113 (offset: 0x72c9)
// dev strs .. 10  (offset: 0x7c91)
// exports ... 65  (offset: 0x4c5d)
// cseg ...... 0x840 + 0x441d (0x4c5d)
// imports ... 214 (offset: 0x5685)
// animtree1 . 0   (offset: 0x7d11)
// animtree2 . 0   (offset: 0x7d11)
#using scripts\anim\utility;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\ammomods\ammo_mod;
#using scripts\mp\common\equipment\shock_stick;
#using scripts\mp\common\perks\perkpackage;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\content_manager;
#using scripts\mp\currency;
#using scripts\mp\doorbuy;
#using scripts\mp\electric_power_switch;
#using scripts\mp\equipment;
#using scripts\mp\laststand;
#using scripts\mp\loot\common_item_equipment;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\pack_a_punch;
#using scripts\mp\playerlogic;
#using scripts\mp\supers;
#using scripts\mp\zm\systems\zm_cleanup_mgr;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zone_manager;

#namespace zm_utility;

// Namespace zm_utility
// Params 0, eflags: 0x1
// Checksum 0xbd9ad5ea, Offset: 0x85e
// Size: 0x5c
function autoexec function_1501231b903aad49()
{
    utility::registersharedfunc( #"zm_utility", #"hash_664f6f3563adae69", &function_922d522db5f1ceda );
    utility::registersharedfunc( #"zm_utility", #"force_revive_player", &force_revive_player );
    utility::registersharedfunc( #"zm_utility", #"hash_aa5e3e963ec5ea62", &teleport_player );
}

// Namespace zm_utility
// Params 0
// Checksum 0x17f684ad, Offset: 0x8c2
// Size: 0x25
function get_zombie_team()
{
    if ( !isdefined( level.var_ece703e3d116381c ) )
    {
        level.var_ece703e3d116381c = "team_two_hundred";
    }
    
    return level.var_ece703e3d116381c;
}

// Namespace zm_utility
// Params 0
// Checksum 0x1385ba56, Offset: 0x8f0
// Size: 0x9e
function get_active_zombies()
{
    zombies = getaiarray( get_zombie_team() );
    var_4c6516944983d5d8 = [];
    
    foreach ( zombie in zombies )
    {
        if ( is_active_zombie( zombie ) )
        {
            var_4c6516944983d5d8[ var_4c6516944983d5d8.size ] = zombie;
        }
    }
    
    return var_4c6516944983d5d8;
}

// Namespace zm_utility
// Params 0
// Checksum 0xe7b769a3, Offset: 0x997
// Size: 0x9a
function get_active_zombies_count()
{
    zombies = getaiarray( get_zombie_team() );
    var_6a22e4e713e41f90 = 0;
    
    foreach ( zombie in zombies )
    {
        if ( is_active_zombie( zombie ) )
        {
            var_6a22e4e713e41f90++;
        }
    }
    
    return var_6a22e4e713e41f90;
}

// Namespace zm_utility
// Params 1
// Checksum 0x67ea55b1, Offset: 0xa3a
// Size: 0xc9
function function_205b7482cb035d0e( var_c60105d2445aa45f )
{
    assert( isdefined( var_c60105d2445aa45f ), "<dev string:x24>" );
    zombies = getaiarray( get_zombie_team() );
    active_zombies_of_type = [];
    
    foreach ( zombie in zombies )
    {
        if ( is_active_zombie( zombie ) )
        {
            if ( zombie.subclass == var_c60105d2445aa45f )
            {
                active_zombies_of_type[ active_zombies_of_type.size ] = zombie;
            }
        }
    }
    
    return active_zombies_of_type;
}

// Namespace zm_utility
// Params 1
// Checksum 0x6907f101, Offset: 0xb0c
// Size: 0x5d, Type: bool
function is_active_zombie( zombie )
{
    return !zombie utility::ent_flag( "scene_active" ) && isalive( zombie ) && !zombie utility::doinglongdeath() && !zombie utility::ent_flag( "death_engaged" ) && !zombie._blackboard.var_903cd88c07cfc16b;
}

// Namespace zm_utility
// Params 2
// Checksum 0x161e79be, Offset: 0xb72
// Size: 0x86
function function_2453a16ad4a092f8( var_e22515fa4eb37b17 = 0, var_53b9cbd8aea1973e )
{
    max_active_zombies = var_53b9cbd8aea1973e ?? level.var_a009ab14ee0d3223.var_63a0ca44b877a390;
    active_zombies_count = get_active_zombies_count();
    var_df6cc62701a843ad = active_zombies_count - max_active_zombies;
    free_count = getfreeagentcount();
    var_2147d6bd4119fbe0 = var_e22515fa4eb37b17 - free_count;
    var_df6cc62701a843ad = maxint( var_df6cc62701a843ad, var_2147d6bd4119fbe0 );
    return var_df6cc62701a843ad;
}

// Namespace zm_utility
// Params 1
// Checksum 0xf744e039, Offset: 0xc01
// Size: 0x27, Type: bool
function is_player_valid_target( player )
{
    return isalive( player ) && player.sessionstate != "spectator";
}

// Namespace zm_utility
// Params 0
// Checksum 0x3311d99d, Offset: 0xc31
// Size: 0x1d
function get_round_number()
{
    if ( isdefined( level.zm_get_round_number ) )
    {
        return [[ level.zm_get_round_number ]]();
    }
    
    return 1;
}

// Namespace zm_utility
// Params 1
// Checksum 0x96216bd9, Offset: 0xc57
// Size: 0x70
function function_1588b24fa1d03f3b( movespeed )
{
    movespeednumber = 0;
    
    switch ( movespeed )
    {
        case #"hash_bdea5e7441323370":
            movespeednumber = 0;
            break;
        case #"hash_9710f96c58beeaaa":
            movespeednumber = 1;
            break;
        case #"hash_eb06fed69a41dab5":
            movespeednumber = 2;
            break;
        case #"hash_941b91394072b0c1":
            movespeednumber = 3;
            break;
    }
    
    return movespeednumber;
}

// Namespace zm_utility
// Params 1
// Checksum 0xb81fcf82, Offset: 0xcd0
// Size: 0x7f
function function_3aa660fdfe227adb( movespeed )
{
    movespeedname = "walk";
    
    if ( movespeed >= 1 && movespeed <= 35 )
    {
        movespeedname = "walk";
    }
    else if ( movespeed >= 36 && movespeed <= 70 )
    {
        movespeedname = "run";
    }
    else if ( movespeed >= 71 && movespeed <= 236 )
    {
        movespeedname = "sprint";
    }
    else if ( movespeed >= 237 )
    {
        movespeedname = "super_sprint";
    }
    
    return movespeedname;
}

// Namespace zm_utility
// Params 0
// Checksum 0x5a6f11b6, Offset: 0xd58
// Size: 0x153
function util_kill_all_zombies()
{
    zombies = getaiarray( get_zombie_team() );
    
    foreach ( zombie in zombies )
    {
        if ( !isalive( zombie ) || zombie utility::ent_flag( "scene_active" ) || !zombie val::get( "death" ) )
        {
            continue;
        }
        
        if ( zombie.var_698cf8d8d4a8cbb9 )
        {
            zombie val::reset( "fog_zombie_shield", "damageshield" );
            zombie.nocorpse = 1;
            zombie.death_source = "zm_fog";
        }
        
        if ( zombie val::get( "damageshield_allow_delete" ) )
        {
            zombie utility::callsharedfunc( #"ai", #"hash_c649178f35fe47cf" );
        }
        
        if ( zombie.magic_bullet_shield || zombie.damageshield )
        {
            continue;
        }
        
        zombie.death_source = "zm_utility_kill_all_zombies";
        zombie kill();
        waitframe();
    }
}

// Namespace zm_utility
// Params 1
// Checksum 0x7b8f56bb, Offset: 0xeb3
// Size: 0x56
function function_1bd2eda42461fad1( round )
{
    if ( round > 999 )
    {
        level thread function_3fe383361d9c293c();
        round = 999;
        return;
    }
    
    setomnvar( "ui_round_num", round );
    
    if ( zm_round_spawning::is_special_round( round ) )
    {
        setomnvar( "ui_is_special_round", 1 );
        return;
    }
    
    setomnvar( "ui_is_special_round", 0 );
}

// Namespace zm_utility
// Params 0, eflags: 0x4
// Checksum 0x9638a5ac, Offset: 0xf11
// Size: 0x27
function private function_3fe383361d9c293c()
{
    level endon( #"game_ended" );
    setomnvar( "ui_round_num", 0 );
    waitframe();
    setomnvar( "ui_round_num", 999 );
}

// Namespace zm_utility
// Params 1
// Checksum 0xcbf6832f, Offset: 0xf40
// Size: 0x18
function function_3558e91cc9f432c1( round )
{
    setomnvar( "ui_round_cap", round );
}

// Namespace zm_utility
// Params 9
// Checksum 0x465ec0d7, Offset: 0xf60
// Size: 0x3d7, Type: bool
function function_71d7c0e7375ef487( var_5da531956c557870, a_ai_types, excluders, b_allow_despawn = 1, var_f91d560f10f09779, use_distance_threshold, distance_threshold_radius, process, sparams )
{
    assert( isint( var_5da531956c557870 ) && var_5da531956c557870 > 0, "<dev string:x39>" );
    now = gettime();
    
    if ( level.var_21a155c9f2141948 == now )
    {
        return false;
    }
    
    level.var_21a155c9f2141948 = now;
    
    if ( !isdefined( a_ai_types ) || a_ai_types.size < 1 )
    {
        return false;
    }
    
    var_ee0e7a7788a0daa4 = function_b2a68488b81704f5( 1, get_zombie_team() );
    var_a8ed9dcd9413dc0a = undefined;
    
    if ( !isarray( excluders ) || excluders.size <= 0 )
    {
        excluders = [];
    }
    else
    {
        var_ee0e7a7788a0daa4 = arrayremove( var_ee0e7a7788a0daa4, excluders );
    }
    
    despawn_count = 0;
    max_agents = getmaxagents();
    assert( var_5da531956c557870 <= max_agents, "<dev string:x7e>" + var_5da531956c557870 + "<dev string:x8e>" );
    
    if ( b_allow_despawn )
    {
        var_a4dde51d51153d2c = var_f91d560f10f09779 ?? 0.5;
    }
    
    for ( var_81a672f382a47d80 = 0; var_81a672f382a47d80 < var_5da531956c557870 ; var_81a672f382a47d80++ )
    {
        if ( isdefined( process ) && level.var_147ae5306edffb63 == gettime() )
        {
            var_81a672f382a47d80--;
            waitframe();
            continue;
        }
        
        if ( var_ee0e7a7788a0daa4.size > 0 )
        {
            for ( i = var_ee0e7a7788a0daa4.size - 1; i >= 0 ; i-- )
            {
                zombie = var_ee0e7a7788a0daa4[ i ];
                
                if ( !isalive( zombie ) || zombie.health < 1 || zombie utility::ent_flag( "scene_active" ) || zombie.b_ignore_cleanup || zombie._blackboard.var_903cd88c07cfc16b )
                {
                    continue;
                }
                
                if ( !arraycontains( a_ai_types, zombie.aicategory ) && !arraycontains( a_ai_types, zombie.subclass ) )
                {
                    continue;
                }
                
                foreach ( excluder in excluders )
                {
                    if ( zombie == excluder )
                    {
                        excluded = 1;
                        break;
                    }
                }
                
                if ( excluded )
                {
                    continue;
                }
                
                if ( use_distance_threshold )
                {
                    nearby_players = player_utility::script_getplayersinradius( zombie.origin, distance_threshold_radius );
                    var_a8ed9dcd9413dc0a = nearby_players.size > 0 ? undefined : zombie;
                    
                    if ( isdefined( var_a8ed9dcd9413dc0a ) )
                    {
                        break;
                    }
                    
                    continue;
                }
                
                var_a8ed9dcd9413dc0a = zombie;
                break;
            }
        }
        
        if ( isdefined( var_a8ed9dcd9413dc0a ) )
        {
            var_a8ed9dcd9413dc0a zm_cleanup_manager::function_dd62e2042418b7e5();
            despawned = 0;
            
            if ( isdefined( var_a4dde51d51153d2c ) && agent_utility::getnumactiveagents() + despawn_count < max_agents && getplayerinfluenceatposition( var_a8ed9dcd9413dc0a.origin ) >= var_a4dde51d51153d2c )
            {
                despawned = var_a8ed9dcd9413dc0a zombie_utils::try_despawn_zombie();
                
                if ( despawned )
                {
                    despawn_count++;
                }
            }
            
            if ( !despawned )
            {
                var_a8ed9dcd9413dc0a.death_source = "zm_utility_recycle_furthest_zombie";
                var_a8ed9dcd9413dc0a kill();
            }
            
            if ( isdefined( process ) )
            {
                zombie = [[ process ]]( sparams );
                
                if ( isdefined( zombie ) && isdefined( sparams ) )
                {
                    if ( !isdefined( sparams.new_zombies_spawned ) )
                    {
                        sparams.new_zombies_spawned = [];
                    }
                    
                    sparams.new_zombies_spawned[ sparams.new_zombies_spawned.size ] = zombie;
                }
            }
            
            if ( var_81a672f382a47d80 < var_5da531956c557870 - 1 )
            {
                waitframe();
            }
            
            continue;
        }
        
        return false;
    }
    
    return true;
}

// Namespace zm_utility
// Params 8
// Checksum 0xe15320e0, Offset: 0x1340
// Size: 0xba, Type: bool
function function_922d522db5f1ceda( var_f6ea54cdc54d753, a_ai_types, excluders, var_53b9cbd8aea1973e, b_allow_despawn, var_f91d560f10f09779, use_distance_threshold, distance_threshold_radius )
{
    assert( isint( var_f6ea54cdc54d753 ) && var_f6ea54cdc54d753 > 0, "<dev string:x39>" );
    
    if ( level.var_21a155c9f2141948 == gettime() )
    {
        return false;
    }
    
    var_50e48382a36fbea8 = function_2453a16ad4a092f8( var_f6ea54cdc54d753, var_53b9cbd8aea1973e );
    
    if ( var_50e48382a36fbea8 > 0 )
    {
        b_recycled = function_71d7c0e7375ef487( var_50e48382a36fbea8, a_ai_types, excluders, b_allow_despawn, var_f91d560f10f09779, use_distance_threshold, distance_threshold_radius );
        
        if ( b_recycled == 0 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace zm_utility
// Params 10
// Checksum 0x438a0fd, Offset: 0x1403
// Size: 0x13d
function function_5f46b6e741572ed0( var_e22515fa4eb37b17, a_ai_types, spawn_function, sparams, excluders, var_53b9cbd8aea1973e, b_allow_despawn, var_f91d560f10f09779, use_distance_threshold, distance_threshold_radius )
{
    assert( isint( var_e22515fa4eb37b17 ) && var_e22515fa4eb37b17 > 0, "<dev string:x39>" );
    sparams.new_zombies_spawned = [];
    
    while ( var_e22515fa4eb37b17 > 0 )
    {
        var_df6cc62701a843ad = function_2453a16ad4a092f8( var_e22515fa4eb37b17, var_53b9cbd8aea1973e );
        
        if ( var_df6cc62701a843ad > 0 )
        {
            function_922d522db5f1ceda( 1, a_ai_types, excluders, b_allow_despawn, var_f91d560f10f09779, use_distance_threshold, distance_threshold_radius );
            waitframe();
            continue;
        }
        
        if ( level.var_147ae5306edffb63 != gettime() )
        {
            if ( var_df6cc62701a843ad == 0 )
            {
                if ( function_71d7c0e7375ef487( 1, a_ai_types, excluders, b_allow_despawn, var_f91d560f10f09779, use_distance_threshold, distance_threshold_radius, spawn_function, sparams ) )
                {
                    var_e22515fa4eb37b17--;
                }
            }
            else
            {
                zombie = [[ spawn_function ]]( sparams );
                
                if ( isdefined( zombie ) )
                {
                    sparams.new_zombies_spawned[ sparams.new_zombies_spawned.size ] = zombie;
                    var_e22515fa4eb37b17--;
                    
                    if ( var_e22515fa4eb37b17 == 0 )
                    {
                        break;
                    }
                }
            }
        }
        
        waitframe();
    }
    
    return sparams.new_zombies_spawned;
}

// Namespace zm_utility
// Params 9
// Checksum 0x8b60341c, Offset: 0x1549
// Size: 0xa2
function function_9f6754719bfeaeb1( a_ai_types, spawn_function, sparams, excluders, var_53b9cbd8aea1973e, b_allow_despawn, var_f91d560f10f09779, use_distance_threshold, distance_threshold_radius )
{
    new_zombies_spawned = function_5f46b6e741572ed0( 1, a_ai_types, spawn_function, sparams, excluders, var_53b9cbd8aea1973e, b_allow_despawn, var_f91d560f10f09779, use_distance_threshold, distance_threshold_radius );
    
    /#
        if ( new_zombies_spawned.size == 0 )
        {
            println( "<dev string:xc9>" );
        }
        else if ( new_zombies_spawned.size > 1 )
        {
            println( "<dev string:x113>" );
        }
    #/
    
    return new_zombies_spawned[ 0 ];
}

// Namespace zm_utility
// Params 1
// Checksum 0xa5ca576d, Offset: 0x15f4
// Size: 0x110
function killstreak_assigntargetmarkers( user )
{
    enemies = getaiarray( get_zombie_team() );
    friendlies = getaiarray( self.team );
    
    foreach ( player in level.players )
    {
        if ( level.teambased && player.team != self.team )
        {
            continue;
        }
        
        friendlies[ friendlies.size ] = player;
    }
    
    groupsstruct = spawnstruct();
    groupsstruct.enemytargetmarkergroup = enemies;
    groupsstruct.friendlytargetmarkergroup = friendlies;
    groupsstruct.var_d164bd71a2690aba = enemies;
    return groupsstruct;
}

// Namespace zm_utility
// Params 0
// Checksum 0x16a8366b, Offset: 0x170d
// Size: 0xd8
function open_sesame()
{
    iprintlnbold( "OPEN SESAME!" );
    electric_power_switch::function_2d462dbfcc76b0db( 1 );
    
    foreach ( player in level.players )
    {
        player currency::add_currency_amount( #"essence", 10000 );
        player currency::add_currency_amount( #"salvage", 2500 );
        player currency::add_currency_amount( #"rare_salvage", 2500 );
    }
    
    doorbuy::open_all_doorbuys();
    level utility::flag_set( "open_sesame" );
}

// Namespace zm_utility
// Params 1
// Checksum 0xb2fb83b2, Offset: 0x17ed
// Size: 0x62
function function_1c9c2fe2e9936f90( timeout )
{
    self endon( #"death" );
    ent = spawnstruct();
    childthread function_2496dbcbbf5d937f( ent );
    ent childthread utility::timeout_struct( timeout );
    ent waittill( #"returned", timeout_or_ent );
    ent notify( #"die" );
    return timeout_or_ent;
}

// Namespace zm_utility
// Params 1, eflags: 0x4
// Checksum 0xff94c3c6, Offset: 0x1858
// Size: 0x41
function private function_2496dbcbbf5d937f( ent )
{
    ent endon( #"die" );
    self waittill( #"trigger", ent_triggered );
    ent notify( #"returned", ent_triggered );
}

// Namespace zm_utility
// Params 3
// Checksum 0x446a6ec6, Offset: 0x18a1
// Size: 0x85, Type: bool
function is_player_facing( v_origin, n_distance = 2000, var_6b553f8d178bee38 = 60 )
{
    assert( isplayer( self ), "<dev string:x184>" );
    
    if ( n_distance > 0 && distancesquared( self.origin, v_origin ) > squared( n_distance ) )
    {
        return false;
    }
    
    if ( utility::within_fov( self geteye(), self getplayerangles(), v_origin, cos( var_6b553f8d178bee38 ) ) )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_utility
// Params 3
// Checksum 0x10479795, Offset: 0x192f
// Size: 0xa4
function function_157b74f7b9e1ef04( v_origin, n_distance = 2000, var_6b553f8d178bee38 = 60 )
{
    for ( i = 0; i < level.players.size ; i++ )
    {
        player = level.players[ i ];
        
        while ( isdefined( player.origin ) && isdefined( player.angles ) && player is_player_facing( v_origin, n_distance, var_6b553f8d178bee38 ) )
        {
            i = 0;
            wait 0.5;
        }
    }
}

// Namespace zm_utility
// Params 1
// Checksum 0xdbfad0d0, Offset: 0x19db
// Size: 0x19
function function_ba69bfe327f773ea( n_rarity )
{
    self setclientomnvar( "ui_current_weapon_tier", n_rarity );
}

// Namespace zm_utility
// Params 8
// Checksum 0x2f282188, Offset: 0x19fc
// Size: 0x2fe
function function_92275a9d3969d91d( exclude_primary = 0, exclude_secondary = 0, exclude_tertiary = 0, exclude_lethal_equipment = 0, exclude_tactical_equipment = 0, exclude_fists = 0, exclude_third_weapon = 0, var_9d7bf4d023909cad )
{
    assert( isplayer( self ), "<dev string:x1a9>" );
    player = self;
    player utility::ent_flag_set( "taking_zombie_loadout" );
    var_bbbda94bff1fab15 = [];
    
    if ( !exclude_primary )
    {
        primary_weapon = player item_weapon::function_e7484276ad85f220( #"primary_0" );
        
        if ( isdefined( primary_weapon ) && ( !exclude_fists || exclude_fists && primary_weapon != level.defaultfist ) )
        {
            var_bbbda94bff1fab15[ var_bbbda94bff1fab15.size ] = primary_weapon;
        }
    }
    
    if ( !exclude_secondary )
    {
        secondary_weapon = player item_weapon::function_e7484276ad85f220( #"primary_1" );
        
        if ( isdefined( secondary_weapon ) && ( !exclude_fists || exclude_fists && secondary_weapon != level.defaultfist ) )
        {
            var_bbbda94bff1fab15[ var_bbbda94bff1fab15.size ] = secondary_weapon;
        }
    }
    
    if ( !exclude_third_weapon && player zombie_perks::has_perk( "specialty_z_mod" ) )
    {
        third_weapon = player.var_3bf72dcd2775aa78;
        
        if ( isdefined( third_weapon ) && ( !exclude_fists || exclude_fists && third_weapon != level.defaultfist ) )
        {
            var_bbbda94bff1fab15[ var_bbbda94bff1fab15.size ] = third_weapon;
        }
    }
    
    if ( !exclude_tertiary )
    {
        if ( isdefined( player.var_cc1262e66dbb1c79 ) )
        {
            var_bbbda94bff1fab15[ var_bbbda94bff1fab15.size ] = player.var_cc1262e66dbb1c79;
        }
    }
    
    var_59de2a13c311d37f = var_bbbda94bff1fab15.size;
    
    if ( var_9d7bf4d023909cad && isarray( var_9d7bf4d023909cad ) )
    {
        for ( i = 0; i < var_59de2a13c311d37f ; i++ )
        {
            if ( var_bbbda94bff1fab15[ i ].basename )
            {
                if ( arraycontains( var_9d7bf4d023909cad, var_bbbda94bff1fab15[ i ].basename ) )
                {
                    var_bbbda94bff1fab15[ i ] = undefined;
                }
            }
        }
    }
    
    foreach ( weapon in var_bbbda94bff1fab15 )
    {
        if ( weapon )
        {
            player takeweapon( weapon );
        }
    }
    
    if ( !exclude_lethal_equipment )
    {
        equipment = player item_equipment::function_ba3a484954eaadec( "primary" );
        player equipment_mp::takeequipment( "primary" );
    }
    
    if ( !exclude_tactical_equipment )
    {
        equipment = player item_equipment::function_ba3a484954eaadec( "secondary" );
        player equipment_mp::takeequipment( "secondary" );
    }
    
    player utility::ent_flag_clear( "taking_zombie_loadout" );
}

// Namespace zm_utility
// Params 1
// Checksum 0x599584a0, Offset: 0x1d02
// Size: 0x6ab
function function_d47920bb0d5fa327( save_source = "UNKNOWN" )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    player = self;
    player utility::ent_flag( "saving_zombie_loadout" );
    player endon( #"death" );
    player.old_weapon_obj = player getcurrentweapon();
    var_3df86f0b126863ab = [];
    var_3df86f0b126863ab[ "save_source" ] = save_source;
    var_3df86f0b126863ab[ "primary" ] = [];
    var_3df86f0b126863ab[ "primary" ][ "weapon" ] = player item_weapon::function_e7484276ad85f220( #"primary_0" );
    
    if ( isdefined( var_3df86f0b126863ab[ "primary" ][ "weapon" ] ) )
    {
        altweapon = var_3df86f0b126863ab[ "primary" ][ "weapon" ] getaltweapon();
        var_3df86f0b126863ab[ "primary" ][ "clip_left" ] = self getweaponammoclip( var_3df86f0b126863ab[ "primary" ][ "weapon" ], "left" );
        var_3df86f0b126863ab[ "primary" ][ "clip_right" ] = self getweaponammoclip( var_3df86f0b126863ab[ "primary" ][ "weapon" ], "right" );
        var_3df86f0b126863ab[ "primary" ][ "stock" ] = self getweaponammostock( var_3df86f0b126863ab[ "primary" ][ "weapon" ] );
        var_3df86f0b126863ab[ "primary" ][ "pap_level" ] = pack_a_punch::get_pap_level( var_3df86f0b126863ab[ "primary" ][ "weapon" ] );
        var_3df86f0b126863ab[ "primary" ][ "rarity" ] = item_weapon::function_fb81bd2fe070faa6( var_3df86f0b126863ab[ "primary" ][ "weapon" ] );
        var_3df86f0b126863ab[ "primary" ][ "ammo_mod" ] = ammo_mod::get_ammo_mod_name( var_3df86f0b126863ab[ "primary" ][ "weapon" ] );
        var_3df86f0b126863ab[ "primary" ][ "alt_clip" ] = self getweaponammoclip( altweapon );
        var_3df86f0b126863ab[ "primary" ][ "alt_stock" ] = self getweaponammostock( altweapon );
        var_3df86f0b126863ab[ "primary" ][ "is_in_alt_mode" ] = self isalternatemode( var_3df86f0b126863ab[ "primary" ][ "weapon" ] );
    }
    
    var_3df86f0b126863ab[ "secondary" ] = [];
    var_3df86f0b126863ab[ "secondary" ][ "weapon" ] = player item_weapon::function_e7484276ad85f220( #"primary_1" );
    
    if ( isdefined( var_3df86f0b126863ab[ "secondary" ][ "weapon" ] ) )
    {
        altweapon = var_3df86f0b126863ab[ "secondary" ][ "weapon" ] getaltweapon();
        var_3df86f0b126863ab[ "secondary" ][ "clip_left" ] = self getweaponammoclip( var_3df86f0b126863ab[ "secondary" ][ "weapon" ], "left" );
        var_3df86f0b126863ab[ "secondary" ][ "clip_right" ] = self getweaponammoclip( var_3df86f0b126863ab[ "secondary" ][ "weapon" ], "right" );
        var_3df86f0b126863ab[ "secondary" ][ "stock" ] = self getweaponammostock( var_3df86f0b126863ab[ "secondary" ][ "weapon" ] );
        var_3df86f0b126863ab[ "secondary" ][ "pap_level" ] = pack_a_punch::get_pap_level( var_3df86f0b126863ab[ "secondary" ][ "weapon" ] );
        var_3df86f0b126863ab[ "secondary" ][ "rarity" ] = item_weapon::function_fb81bd2fe070faa6( var_3df86f0b126863ab[ "secondary" ][ "weapon" ] );
        var_3df86f0b126863ab[ "secondary" ][ "ammo_mod" ] = ammo_mod::get_ammo_mod_name( var_3df86f0b126863ab[ "secondary" ][ "weapon" ] );
        var_3df86f0b126863ab[ "secondary" ][ "alt_clip" ] = self getweaponammoclip( altweapon );
        var_3df86f0b126863ab[ "secondary" ][ "alt_stock" ] = self getweaponammostock( altweapon );
        var_3df86f0b126863ab[ "secondary" ][ "is_in_alt_mode" ] = self isalternatemode( var_3df86f0b126863ab[ "secondary" ][ "weapon" ] );
    }
    
    var_3df86f0b126863ab[ "third_weapon" ] = [];
    
    if ( isdefined( player.var_3bf72dcd2775aa78 ) && player zombie_perks::has_perk( "specialty_z_mod" ) && player hasweapon( player.var_3bf72dcd2775aa78 ) )
    {
        var_3df86f0b126863ab[ "third_weapon" ][ "weapon" ] = player.var_3bf72dcd2775aa78;
        altweapon = var_3df86f0b126863ab[ "third_weapon" ][ "weapon" ] getaltweapon();
        var_3df86f0b126863ab[ "third_weapon" ][ "clip_left" ] = self getweaponammoclip( var_3df86f0b126863ab[ "third_weapon" ][ "weapon" ], "left" );
        var_3df86f0b126863ab[ "third_weapon" ][ "clip_right" ] = self getweaponammoclip( var_3df86f0b126863ab[ "third_weapon" ][ "weapon" ], "right" );
        var_3df86f0b126863ab[ "third_weapon" ][ "stock" ] = self getweaponammostock( var_3df86f0b126863ab[ "third_weapon" ][ "weapon" ] );
        var_3df86f0b126863ab[ "third_weapon" ][ "pap_level" ] = pack_a_punch::get_pap_level( var_3df86f0b126863ab[ "third_weapon" ][ "weapon" ] );
        var_3df86f0b126863ab[ "third_weapon" ][ "rarity" ] = item_weapon::function_fb81bd2fe070faa6( var_3df86f0b126863ab[ "third_weapon" ][ "weapon" ] );
        var_3df86f0b126863ab[ "third_weapon" ][ "ammo_mod" ] = ammo_mod::get_ammo_mod_name( var_3df86f0b126863ab[ "third_weapon" ][ "weapon" ] );
        var_3df86f0b126863ab[ "third_weapon" ][ "alt_clip" ] = self getweaponammoclip( altweapon );
        var_3df86f0b126863ab[ "third_weapon" ][ "alt_stock" ] = self getweaponammostock( altweapon );
        var_3df86f0b126863ab[ "third_weapon" ][ "is_in_alt_mode" ] = self isalternatemode( var_3df86f0b126863ab[ "third_weapon" ][ "weapon" ] );
    }
    
    var_3df86f0b126863ab[ "tertiary" ] = [];
    var_3df86f0b126863ab[ "tertiary" ][ "weapon" ] = player.var_cc1262e66dbb1c79;
    
    if ( isdefined( var_3df86f0b126863ab[ "tertiary" ][ "weapon" ] ) )
    {
        altweapon = var_3df86f0b126863ab[ "tertiary" ][ "weapon" ] getaltweapon();
        var_3df86f0b126863ab[ "tertiary" ][ "clip_right" ] = self getweaponammoclip( var_3df86f0b126863ab[ "tertiary" ][ "weapon" ], "right" );
        var_3df86f0b126863ab[ "tertiary" ][ "stock" ] = self getweaponammostock( var_3df86f0b126863ab[ "tertiary" ][ "weapon" ] );
        var_3df86f0b126863ab[ "tertiary" ][ "pap_level" ] = pack_a_punch::get_pap_level( var_3df86f0b126863ab[ "tertiary" ][ "weapon" ] );
        var_3df86f0b126863ab[ "tertiary" ][ "rarity" ] = item_weapon::function_fb81bd2fe070faa6( var_3df86f0b126863ab[ "tertiary" ][ "weapon" ] );
        var_3df86f0b126863ab[ "tertiary" ][ "ammo_mod" ] = ammo_mod::get_ammo_mod_name( var_3df86f0b126863ab[ "tertiary" ][ "weapon" ] );
        var_3df86f0b126863ab[ "tertiary" ][ "alt_clip" ] = self getweaponammoclip( altweapon );
        var_3df86f0b126863ab[ "tertiary" ][ "alt_stock" ] = self getweaponammostock( altweapon );
        var_3df86f0b126863ab[ "tertiary" ][ "is_in_alt_mode" ] = self isalternatemode( var_3df86f0b126863ab[ "tertiary" ][ "weapon" ] );
    }
    
    var_3df86f0b126863ab[ "equip_primary" ] = [];
    var_3df86f0b126863ab[ "equip_primary" ][ "weapon" ] = player item_equipment::function_ba3a484954eaadec( "primary" );
    var_3df86f0b126863ab[ "equip_secondary" ] = [];
    var_3df86f0b126863ab[ "equip_secondary" ][ "weapon" ] = player item_equipment::function_ba3a484954eaadec( "secondary" );
    var_3df86f0b126863ab[ "super" ] = [];
    var_3df86f0b126863ab[ "super" ][ "ref" ] = player supers_mp::getcurrentsuperref();
    var_3df86f0b126863ab[ "super" ][ "points" ] = player supers_mp::getcurrentsuperbasepoints();
    var_3df86f0b126863ab[ "super" ][ "extra_points" ] = player.overclockcharge ?? 0;
    player.a_saved_weapons = var_3df86f0b126863ab;
    player utility::ent_flag_clear( "saving_zombie_loadout" );
}

// Namespace zm_utility
// Params 7
// Checksum 0x87728c19, Offset: 0x23b5
// Size: 0x8f6
function function_663d59490abc834f( var_20231d0ef435c90e, b_skip_super = 0, b_skip_lethal_equipment = 0, b_skip_tactical_equipment = 0, var_d1967ab318474405 = 0, b_skip_tertiary_weapon = 0, var_34c9dcb053df0fd4 = 0 )
{
    player = self;
    player utility::ent_flag_waitopen_all_array( [ "saving_zombie_loadout", "taking_zombie_loadout" ] );
    
    if ( !player )
    {
        return;
    }
    
    if ( !isdefined( player.a_saved_weapons ) )
    {
        assert( isdefined( player.a_saved_weapons ), "<dev string:x1d4>" );
        return;
    }
    
    a_saved_weapons = player.a_saved_weapons;
    
    if ( !isdefined( var_20231d0ef435c90e ) )
    {
        var_20231d0ef435c90e = player.old_weapon_obj;
    }
    
    player function_92275a9d3969d91d( undefined, undefined, b_skip_tertiary_weapon, b_skip_lethal_equipment, b_skip_tactical_equipment, undefined, var_d1967ab318474405 );
    
    if ( isdefined( a_saved_weapons[ "primary" ][ "weapon" ] ) )
    {
        var_f5014f8d49ac38 = a_saved_weapons[ "primary" ];
        weapon = var_f5014f8d49ac38[ "weapon" ];
        var_347c97b7b60df1ea = 1;
        
        if ( isweapon( weapon ) && weapon::iswonderweapon( weapon ) && var_34c9dcb053df0fd4 && isdefined( level.var_16044f6f91277648 ) )
        {
            var_347c97b7b60df1ea = [[ level.var_16044f6f91277648 ]]();
        }
        
        if ( isweapon( weapon ) && var_347c97b7b60df1ea )
        {
            is_in_alt_mode = var_f5014f8d49ac38[ "is_in_alt_mode" ];
            altweapon = weapon getaltweapon();
            var_5d8cc93233d1451a = weapon;
            
            if ( is_in_alt_mode && !isnullweapon( altweapon ) )
            {
                var_5d8cc93233d1451a = altweapon;
            }
            
            player giveweapon( var_5d8cc93233d1451a, undefined, 0, -1, 1 );
            player assignweaponprimaryslot( weapon );
            player.primaryweaponobj = weapon;
            player setweaponammoclip( weapon, var_f5014f8d49ac38[ "clip_left" ], "left" );
            player setweaponammoclip( weapon, var_f5014f8d49ac38[ "clip_right" ], "right" );
            player setweaponammostock( weapon, var_f5014f8d49ac38[ "stock" ] );
            
            if ( !isnullweapon( altweapon ) )
            {
                player setweaponammoclip( altweapon, var_f5014f8d49ac38[ "alt_clip" ] );
                player setweaponammostock( altweapon, var_f5014f8d49ac38[ "alt_stock" ] );
            }
            
            should_update_hud = weapon == var_20231d0ef435c90e;
            
            if ( var_f5014f8d49ac38[ "pap_level" ] > 0 )
            {
                player pack_a_punch::function_3f3b9cdbb4843e45( weapon, var_f5014f8d49ac38[ "pap_level" ], should_update_hud );
            }
            
            player item_weapon::function_40e1cbd0e1f47d1a( weapon, var_f5014f8d49ac38[ "rarity" ], should_update_hud );
            
            if ( var_f5014f8d49ac38[ "ammo_mod" ] )
            {
                player ammo_mod::add_ammo_mod_to_weapon( weapon, var_f5014f8d49ac38[ "ammo_mod" ], should_update_hud );
            }
        }
    }
    
    if ( isdefined( a_saved_weapons[ "secondary" ][ "weapon" ] ) )
    {
        var_f5014f8d49ac38 = a_saved_weapons[ "secondary" ];
        weapon = var_f5014f8d49ac38[ "weapon" ];
        var_347c97b7b60df1ea = 1;
        
        if ( isweapon( weapon ) && weapon::iswonderweapon( weapon ) && var_34c9dcb053df0fd4 && isdefined( level.var_16044f6f91277648 ) )
        {
            var_347c97b7b60df1ea = [[ level.var_16044f6f91277648 ]]();
        }
        
        if ( isweapon( weapon ) && var_347c97b7b60df1ea )
        {
            is_in_alt_mode = var_f5014f8d49ac38[ "is_in_alt_mode" ];
            altweapon = weapon getaltweapon();
            var_5d8cc93233d1451a = weapon;
            
            if ( is_in_alt_mode && !isnullweapon( altweapon ) )
            {
                var_5d8cc93233d1451a = altweapon;
            }
            
            player giveweapon( var_5d8cc93233d1451a, undefined, 0, -1, 1 );
            player assignweaponprimaryslot( weapon );
            player.secondaryweaponobj = weapon;
            player setweaponammoclip( weapon, var_f5014f8d49ac38[ "clip_left" ], "left" );
            player setweaponammoclip( weapon, var_f5014f8d49ac38[ "clip_right" ], "right" );
            player setweaponammostock( weapon, var_f5014f8d49ac38[ "stock" ] );
            
            if ( !isnullweapon( altweapon ) )
            {
                player setweaponammoclip( altweapon, var_f5014f8d49ac38[ "alt_clip" ] );
                player setweaponammostock( altweapon, var_f5014f8d49ac38[ "alt_stock" ] );
            }
            
            should_update_hud = weapon == var_20231d0ef435c90e;
            
            if ( var_f5014f8d49ac38[ "pap_level" ] > 0 )
            {
                player pack_a_punch::function_3f3b9cdbb4843e45( weapon, var_f5014f8d49ac38[ "pap_level" ], should_update_hud );
            }
            
            player item_weapon::function_40e1cbd0e1f47d1a( weapon, var_f5014f8d49ac38[ "rarity" ], should_update_hud );
            
            if ( var_f5014f8d49ac38[ "ammo_mod" ] )
            {
                player ammo_mod::add_ammo_mod_to_weapon( weapon, var_f5014f8d49ac38[ "ammo_mod" ], should_update_hud );
            }
        }
    }
    
    if ( !var_d1967ab318474405 && player zombie_perks::has_perk( "specialty_z_mod" ) )
    {
        if ( isdefined( a_saved_weapons[ "third_weapon" ][ "weapon" ] ) )
        {
            var_f5014f8d49ac38 = a_saved_weapons[ "third_weapon" ];
            weapon = var_f5014f8d49ac38[ "weapon" ];
            var_347c97b7b60df1ea = 1;
            
            if ( isweapon( weapon ) && weapon::iswonderweapon( weapon ) && var_34c9dcb053df0fd4 && isdefined( level.var_16044f6f91277648 ) )
            {
                var_347c97b7b60df1ea = [[ level.var_16044f6f91277648 ]]();
            }
            
            if ( isweapon( weapon ) && var_347c97b7b60df1ea )
            {
                is_in_alt_mode = var_f5014f8d49ac38[ "is_in_alt_mode" ];
                altweapon = weapon getaltweapon();
                var_5d8cc93233d1451a = weapon;
                
                if ( is_in_alt_mode && !isnullweapon( altweapon ) )
                {
                    var_5d8cc93233d1451a = altweapon;
                }
                
                player giveweapon( var_5d8cc93233d1451a, undefined, 0, -1, 1 );
                player assignweaponprimaryslot( weapon );
                player.var_3bf72dcd2775aa78 = weapon;
                player setweaponammoclip( weapon, var_f5014f8d49ac38[ "clip_left" ], "left" );
                player setweaponammoclip( weapon, var_f5014f8d49ac38[ "clip_right" ], "right" );
                player setweaponammostock( weapon, var_f5014f8d49ac38[ "stock" ] );
                
                if ( !isnullweapon( altweapon ) )
                {
                    player setweaponammoclip( altweapon, var_f5014f8d49ac38[ "alt_clip" ] );
                    player setweaponammostock( altweapon, var_f5014f8d49ac38[ "alt_stock" ] );
                }
                
                should_update_hud = weapon == var_20231d0ef435c90e;
                
                if ( var_f5014f8d49ac38[ "pap_level" ] > 0 )
                {
                    player pack_a_punch::function_3f3b9cdbb4843e45( weapon, var_f5014f8d49ac38[ "pap_level" ], should_update_hud );
                }
                
                player item_weapon::function_40e1cbd0e1f47d1a( weapon, var_f5014f8d49ac38[ "rarity" ], should_update_hud );
                
                if ( var_f5014f8d49ac38[ "ammo_mod" ] )
                {
                    player ammo_mod::add_ammo_mod_to_weapon( weapon, var_f5014f8d49ac38[ "ammo_mod" ], should_update_hud );
                }
                
                player.var_1dbdf5cd10dc5432 = item_weapon::function_1464d1c9177c4934( weapon );
            }
        }
    }
    
    if ( !b_skip_tertiary_weapon && isdefined( a_saved_weapons[ "tertiary" ][ "weapon" ] ) )
    {
        var_f5014f8d49ac38 = a_saved_weapons[ "tertiary" ];
        weapon = a_saved_weapons[ "tertiary" ][ "weapon" ];
        var_347c97b7b60df1ea = 1;
        
        if ( isweapon( weapon ) && weapon::iswonderweapon( weapon ) && var_34c9dcb053df0fd4 && isdefined( level.var_16044f6f91277648 ) )
        {
            var_347c97b7b60df1ea = [[ level.var_16044f6f91277648 ]]();
        }
        
        if ( isweapon( weapon ) && !isnullweapon( weapon ) && var_347c97b7b60df1ea )
        {
            is_in_alt_mode = var_f5014f8d49ac38[ "is_in_alt_mode" ];
            altweapon = weapon getaltweapon();
            var_5d8cc93233d1451a = weapon;
            
            if ( is_in_alt_mode && !isnullweapon( altweapon ) )
            {
                var_5d8cc93233d1451a = altweapon;
            }
            
            player giveweapon( var_5d8cc93233d1451a, undefined, 0, -1, 1 );
            player assignweaponmeleeslot( weapon );
            player.var_cc1262e66dbb1c79 = weapon;
            player setweaponammoclip( weapon, var_f5014f8d49ac38[ "clip_right" ] );
            player setweaponammostock( weapon, var_f5014f8d49ac38[ "stock" ] );
            
            if ( !isnullweapon( altweapon ) )
            {
                player setweaponammoclip( altweapon, var_f5014f8d49ac38[ "alt_clip" ] );
                player setweaponammostock( altweapon, var_f5014f8d49ac38[ "alt_stock" ] );
            }
            
            should_update_hud = weapon == var_20231d0ef435c90e;
            
            if ( var_f5014f8d49ac38[ "pap_level" ] > 0 )
            {
                player pack_a_punch::function_3f3b9cdbb4843e45( weapon, var_f5014f8d49ac38[ "pap_level" ], should_update_hud );
            }
            
            player item_weapon::function_40e1cbd0e1f47d1a( weapon, var_f5014f8d49ac38[ "rarity" ], should_update_hud );
            
            if ( var_f5014f8d49ac38[ "ammo_mod" ] )
            {
                player ammo_mod::add_ammo_mod_to_weapon( weapon, var_f5014f8d49ac38[ "ammo_mod" ], should_update_hud );
            }
        }
    }
    
    if ( !b_skip_lethal_equipment && isdefined( a_saved_weapons[ "equip_primary" ][ "weapon" ] ) )
    {
        equipment = a_saved_weapons[ "equip_primary" ][ "weapon" ];
        item = getscriptbundle( equipment.name );
        player equipment_mp::giveequipment( item.ref, "primary" );
        player equipment_mp::setequipmentammo( item.ref, equipment.count );
    }
    
    if ( !b_skip_tactical_equipment && isdefined( a_saved_weapons[ "equip_secondary" ][ "weapon" ] ) )
    {
        equipment = a_saved_weapons[ "equip_secondary" ][ "weapon" ];
        item = getscriptbundle( equipment.name );
        player equipment_mp::giveequipment( item.ref, "secondary" );
        player equipment_mp::setequipmentammo( item.ref, equipment.count );
    }
    
    if ( !b_skip_super )
    {
        if ( isdefined( a_saved_weapons[ "super" ][ "ref" ] ) )
        {
            player supers_mp::clearsuper();
            player perkpackage::perkpackage_giveimmediate( a_saved_weapons[ "super" ][ "ref" ], undefined, undefined, undefined, 0 );
            points = a_saved_weapons[ "super" ][ "points" ];
            
            if ( isdefined( points ) )
            {
                player supers_mp::setsuperbasepoints( points );
            }
            
            if ( isdefined( player.overclockcharge ) && isdefined( player.perks[ "specialty_overcharge_field_upgrade" ] ) )
            {
                extra_points = a_saved_weapons[ "super" ][ "extra_points" ];
                
                if ( extra_points > 0 )
                {
                    player supers_mp::givesuperpoints( extra_points, undefined, 1 );
                }
            }
        }
        else
        {
            player supers_mp::clearsuper();
        }
    }
    
    if ( !isdefined( var_20231d0ef435c90e ) )
    {
        [ var_20231d0ef435c90e ] = self getweaponslistprimaries();
    }
    
    player switchtoweaponimmediate( var_20231d0ef435c90e );
    player.a_saved_weapons = undefined;
}

// Namespace zm_utility
// Params 7
// Checksum 0x405db285, Offset: 0x2cb3
// Size: 0x172
function teleport_player( v_origin, v_angles, str_id, b_keep_ui = 0, wait_duration = 1, fade_in_duration = 0.5, fade_out_duration = 0.5 )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    set_player_frozen_vars( 1, str_id );
    
    if ( fade_in_duration >= 0 )
    {
        if ( b_keep_ui )
        {
            game_utility::fadetoblackforplayerkeepui( self, 1, fade_in_duration );
        }
        else
        {
            game_utility::fadetoblackforplayer( self, 1, fade_in_duration );
        }
    }
    
    wait wait_duration;
    val::set( "teleport_player_ignores", "ignore_afk", 1 );
    
    if ( !self.var_c6d48777fc700ed8 )
    {
        self dontinterpolate();
        self setorigin( v_origin );
        self setplayerangles( v_angles );
    }
    
    self notify( #"afk_tracking_resume" );
    utility::delaythreadendon( level.framedurationseconds, "disconnect", &val::reset_all, "teleport_player_ignores" );
    
    if ( fade_out_duration >= 0 )
    {
        if ( b_keep_ui )
        {
            level thread game_utility::fadetoblackforplayerkeepui( self, 0, fade_out_duration );
        }
        else
        {
            level thread game_utility::fadetoblackforplayer( self, 0, fade_out_duration );
        }
        
        utility::delaythreadendon( fade_out_duration, "disconnect", &set_player_frozen_vars, 0, str_id );
    }
    else
    {
        set_player_frozen_vars( 0, str_id );
    }
    
    callback::callback( "player_on_teleport" );
}

// Namespace zm_utility
// Params 3
// Checksum 0x66d94a4d, Offset: 0x2e2d
// Size: 0xe4
function set_player_frozen_vars( var_94d1ab5da995e573, str_id, var_8bf4281d159987c4 = 1 )
{
    if ( var_94d1ab5da995e573 )
    {
        if ( player::isinlaststand( self ) || self.ismutantinjection || self.dark_flare_active )
        {
            val::set( str_id, "fire", 0 );
        }
        else
        {
            val::set( str_id, "weapon", 0 );
        }
        
        val::set( str_id, "allow_movement", 0 );
        val::set( str_id, "ignoreme", 1 );
        val::set( str_id, "freezecontrols", 1 );
        val::set( str_id, "killstreaks", 0 );
        
        if ( var_8bf4281d159987c4 )
        {
            val::set( str_id, "health_regen", 0 );
        }
        
        self.b_ignore_playable_area_check = 1;
        return;
    }
    
    self.b_ignore_playable_area_check = 0;
    val::reset_all( str_id );
}

// Namespace zm_utility
// Params 0
// Checksum 0x6b7060d2, Offset: 0x2f19
// Size: 0x48
function play_repair_animation()
{
    self endon( #"hash_be0e54b9b2c97ce2" );
    inventory_utility::givegunlessweapon();
    
    if ( isplayer( self ) )
    {
        val::set( "play_repair_animation", "allow_movement", 0 );
        self.is_crafting = 1;
        thread utility::function_72b6372d2d8c997( "jup_war_ges_wrench_02", 1 );
    }
}

// Namespace zm_utility
// Params 0
// Checksum 0x456df151, Offset: 0x2f69
// Size: 0x3e
function function_3b267d5d8f911307()
{
    self notify( #"hash_be0e54b9b2c97ce2" );
    inventory_utility::takegunlessweapon();
    
    if ( isplayer( self ) )
    {
        val::reset_all( "play_repair_animation" );
        self takeweapon( "jup_war_ges_wrench_02" );
        self.is_crafting = undefined;
    }
}

// Namespace zm_utility
// Params 5
// Checksum 0x57cf46d9, Offset: 0x2faf
// Size: 0x2b3
function white_screen_flash( wait_time, fade_in_time, n_target_alpha, fade_out_time = 0.5, var_49c01b80bd6371ab )
{
    self notify( #"hash_a71f322fc70ec58c" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_a71f322fc70ec58c" );
    
    if ( !isdefined( wait_time ) )
    {
        wait_time = 1;
    }
    
    if ( !isdefined( fade_in_time ) )
    {
        fade_in_time = 0.18;
    }
    
    if ( !isdefined( self.white_screen_overlay ) )
    {
        self.white_screen_overlay = newclienthudelem( self );
        self.white_screen_overlay.x = 0;
        self.white_screen_overlay.y = 0;
        inverted_flash = self.pers[ "sharedGamerProfiles" ][ "invertedFlashEnabled" ];
        
        if ( inverted_flash )
        {
            self.white_screen_overlay setshader( "black", 640, 480 );
        }
        else
        {
            self.white_screen_overlay setshader( "white", 640, 480 );
        }
        
        self.white_screen_overlay.alignx = "left";
        self.white_screen_overlay.aligny = "top";
        self.white_screen_overlay.sort = 1;
        self.white_screen_overlay.horzalign = "fullscreen";
        self.white_screen_overlay.vertalign = "fullscreen";
        self.white_screen_overlay.alpha = 0;
        self.white_screen_overlay.foreground = 1;
        self.white_screen_overlay.archived = 0;
        self.white_screen_overlay.scramblerdisabled = 1;
    }
    
    if ( var_49c01b80bd6371ab )
    {
        val::set( "zm_util_white_screen", "show_hud", 0 );
    }
    
    var_24c3037417857a23 = fade_in_time;
    
    if ( !isdefined( n_target_alpha ) )
    {
        n_target_alpha = 1;
    }
    
    self.white_screen_overlay fadeovertime( var_24c3037417857a23 );
    self.white_screen_overlay.alpha = n_target_alpha;
    wait wait_time;
    
    if ( self && var_49c01b80bd6371ab )
    {
        val::reset( "zm_util_white_screen", "show_hud" );
    }
    
    if ( !isdefined( self ) || !isdefined( self.white_screen_overlay ) )
    {
        return;
    }
    
    var_24c3037417857a23 = fade_out_time;
    self.white_screen_overlay fadeovertime( var_24c3037417857a23 );
    self.white_screen_overlay.alpha = 0;
    wait var_24c3037417857a23;
    
    if ( isdefined( self.white_screen_overlay ) )
    {
        self.white_screen_overlay destroy();
    }
}

// Namespace zm_utility
// Params 1
// Checksum 0x1119a657, Offset: 0x326a
// Size: 0x1e1
function function_6fca5749e8c5007a( var_c6969b9fb8f1cf23 )
{
    interact = var_c6969b9fb8f1cf23.interact;
    
    if ( !isdefined( interact.myparent ) )
    {
        interact.myparent = var_c6969b9fb8f1cf23;
    }
    
    var_c6969b9fb8f1cf23.var_69e627af243988c = &function_4a3b25f8a29f99dd;
    interact.var_83ed92f76a8975ea = self [[ var_c6969b9fb8f1cf23.var_aadb7535959da099 ]]( var_c6969b9fb8f1cf23 );
    
    if ( !interact.var_83ed92f76a8975ea.var_71dcc241ec928818 )
    {
        thread function_4a3b25f8a29f99dd( interact );
        return;
    }
    
    var_c5d8db5557c29078 = interact.var_83ed92f76a8975ea.var_269248f5af0b05f5 ?? 0;
    self setclientomnvar( "ui_zm_doorbuy_can_afford_only_half_buy", var_c5d8db5557c29078 );
    
    if ( self.b_interact_watching || interact.var_cb043f8d1b046284 || !function_963cf8e82e514f4e( interact ) || interact function_95cbc76fde6cf35c() )
    {
        return;
    }
    
    use_ent = self getplayeruseentity( 1 );
    
    if ( use_ent != interact )
    {
        thread function_4a3b25f8a29f99dd( interact );
        return;
    }
    
    if ( isdefined( interact.interact_hint_callback ) )
    {
        interact.var_cb043f8d1b046284 = 1;
        hintstring = level [[ interact.interact_hint_callback ]]( interact, self );
        interact.var_cb043f8d1b046284 = undefined;
        
        if ( !hintstring.interactable )
        {
            return;
        }
    }
    
    self.b_interact_watching = 1;
    interact.var_d8e3b07237845727 = arraycombine( [ &function_b27a193891ebe0b0 ], interact.var_d8e3b07237845727 );
    self setclientomnvar( "ui_zm_doorbuy_is_doorbuy", 1 );
    thread function_90b78bdfc193403d( interact );
    thread function_60f13efd81d5db11( interact );
    thread function_648dbcda7860f66a( var_c6969b9fb8f1cf23 );
    self notifyonplayercommand( "try_alternate_interact_kbm", "+reload" );
    self notifyonplayercommand( "try_alternate_interact_gpad", "-usereload" );
}

// Namespace zm_utility
// Params 1, eflags: 0x4
// Checksum 0x213c5d12, Offset: 0x3453
// Size: 0x13
function private function_b27a193891ebe0b0( player )
{
    thread function_9fd54532e7eb27e1();
}

// Namespace zm_utility
// Params 0, eflags: 0x4
// Checksum 0x34dfb386, Offset: 0x346e
// Size: 0x4d
function private function_9fd54532e7eb27e1()
{
    delay = self.var_83ed92f76a8975ea.var_8c429812367b06d9 ?? 1;
    
    if ( !isdefined( delay ) || delay <= 0 )
    {
        return;
    }
    
    self.var_16925bc91537f335 = 0;
    wait delay;
    self.var_16925bc91537f335 = undefined;
}

// Namespace zm_utility
// Params 0, eflags: 0x4
// Checksum 0xe393bda0, Offset: 0x34c3
// Size: 0x1a, Type: bool
function private function_95cbc76fde6cf35c()
{
    return isdefined( self.var_16925bc91537f335 ) && !self.var_16925bc91537f335;
}

// Namespace zm_utility
// Params 2
// Checksum 0xa25723ac, Offset: 0x34e6
// Size: 0x7b
function function_88e4b637acad25e8( var_c6969b9fb8f1cf23, var_80e49e533bb80aa0 )
{
    interact = var_c6969b9fb8f1cf23.interact;
    
    if ( !isdefined( interact.myparent ) )
    {
        interact.myparent = var_c6969b9fb8f1cf23;
    }
    
    var_c6969b9fb8f1cf23.var_aadb7535959da099 = &function_3eff39726a95991d;
    
    if ( isdefined( var_80e49e533bb80aa0 ) )
    {
        var_c6969b9fb8f1cf23.var_aadb7535959da099 = self [[ var_80e49e533bb80aa0 ]]( var_c6969b9fb8f1cf23 );
    }
    
    function_6fca5749e8c5007a( var_c6969b9fb8f1cf23 );
}

// Namespace zm_utility
// Params 1, eflags: 0x4
// Checksum 0x35e5ace1, Offset: 0x3569
// Size: 0xdf
function private function_3eff39726a95991d( var_c6969b9fb8f1cf23 )
{
    interact = var_c6969b9fb8f1cf23.interact;
    var_83ed92f76a8975ea = spawnstruct();
    currency = var_c6969b9fb8f1cf23.script_currency ?? #"essence";
    var_83ed92f76a8975ea.var_71dcc241ec928818 = !var_c6969b9fb8f1cf23.var_6f1622c6d6cc8ac2 && currency::can_afford( currency, int( var_c6969b9fb8f1cf23.script_cost / 2 ) );
    
    if ( !var_83ed92f76a8975ea.var_71dcc241ec928818 )
    {
        return var_83ed92f76a8975ea;
    }
    
    var_83ed92f76a8975ea.var_269248f5af0b05f5 = !currency::can_afford( currency, int( var_c6969b9fb8f1cf23.script_cost ) );
    
    if ( !isdefined( var_83ed92f76a8975ea.var_b5410045d7e4b8c4 ) )
    {
        var_83ed92f76a8975ea.var_b5410045d7e4b8c4 = &function_740216cda394ee77;
    }
    
    return var_83ed92f76a8975ea;
}

// Namespace zm_utility
// Params 1, eflags: 0xc
// Checksum 0x229dcdb, Offset: 0x3651
// Size: 0xcb
function private function_4a3b25f8a29f99dd( interact )
{
    self notify( #"hash_5685d0accbf8c84e" );
    self endon( #"hash_5685d0accbf8c84e" );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    self.b_interact_watching = 0;
    
    if ( isdefined( interact ) && isarray( interact.var_d8e3b07237845727 ) )
    {
        arrayremove( interact.var_d8e3b07237845727, &function_b27a193891ebe0b0 );
    }
    
    self setclientomnvar( "ui_zm_doorbuy_can_afford_only_half_buy", 0 );
    self setclientomnvar( "ui_zm_doorbuy_is_doorbuy", 0 );
    
    if ( !isbot( self ) )
    {
        self notifyonplayercommandremove( "try_alternate_interact_kbm", "+reload" );
        self notifyonplayercommandremove( "try_alternate_interact_gpad", "-usereload" );
    }
    
    self notify( #"hash_ff8ba9941b273618" );
    self notify( #"hash_fcd971810dc9c4c" );
    self notify( #"hash_38f0c4ecfe32d7df" );
}

// Namespace zm_utility
// Params 1, eflags: 0x4
// Checksum 0x1d27aeb0, Offset: 0x3724
// Size: 0x9d
function private function_963cf8e82e514f4e( struct_interact )
{
    if ( isdefined( struct_interact ) && isdefined( struct_interact.classname ) && issubstr( struct_interact.classname, "trigger_use_touch" ) )
    {
        if ( self istouching( struct_interact ) )
        {
            return 1;
        }
        else
        {
            thread function_4a3b25f8a29f99dd( struct_interact );
            return 0;
        }
        
        return;
    }
    
    if ( isdefined( struct_interact ) && distancesquared( self.origin, struct_interact.origin ) <= squared( struct_interact.interact_use_range + 16 ) )
    {
        return 1;
    }
    
    thread function_4a3b25f8a29f99dd( struct_interact );
    return 0;
}

// Namespace zm_utility
// Params 1, eflags: 0x4
// Checksum 0x7a567e7c, Offset: 0x37c9
// Size: 0x46
function private function_90b78bdfc193403d( interact )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_ff8ba9941b273618" );
    
    while ( isdefined( interact ) )
    {
        wait 0.1;
    }
    
    thread function_4a3b25f8a29f99dd();
}

// Namespace zm_utility
// Params 1, eflags: 0x4
// Checksum 0x828c6092, Offset: 0x3817
// Size: 0x44
function private function_60f13efd81d5db11( interact )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_fcd971810dc9c4c" );
    
    while ( function_963cf8e82e514f4e( interact ) )
    {
        wait 0.1;
    }
}

// Namespace zm_utility
// Params 1, eflags: 0x4
// Checksum 0x19095a96, Offset: 0x3863
// Size: 0x10f
function private function_648dbcda7860f66a( var_c6969b9fb8f1cf23 )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_38f0c4ecfe32d7df" );
    interact = var_c6969b9fb8f1cf23.interact;
    
    while ( true )
    {
        notifies = [ "try_alternate_interact_kbm", "try_alternate_interact_gpad" ];
        event = utility::waittill_any_in_array_return( notifies );
        var_d6856a1d46421edc = 0;
        
        if ( event == "try_alternate_interact_kbm" && !self usinggamepad() )
        {
            var_d6856a1d46421edc = 1;
        }
        
        if ( event == "try_alternate_interact_gpad" && self usinggamepad() )
        {
            var_d6856a1d46421edc = 1;
        }
        
        if ( isdefined( interact ) && isdefined( interact.var_83ed92f76a8975ea.var_b5410045d7e4b8c4 ) && var_d6856a1d46421edc && !interact function_95cbc76fde6cf35c() )
        {
            interact thread [[ interact.var_83ed92f76a8975ea.var_b5410045d7e4b8c4 ]]( self, var_d6856a1d46421edc );
        }
        
        wait 0.2;
    }
}

// Namespace zm_utility
// Params 2, eflags: 0x4
// Checksum 0x56fece06, Offset: 0x397a
// Size: 0x196
function private function_740216cda394ee77( player, var_4f0e7120eb49ca49 )
{
    var_c6969b9fb8f1cf23 = self.myparent;
    var_c6969b9fb8f1cf23.var_8a2163db64e3827d = var_c6969b9fb8f1cf23.script_cost;
    n_half_cost = int( var_c6969b9fb8f1cf23.script_cost / 2 );
    str_currency = var_c6969b9fb8f1cf23.script_currency ?? #"essence";
    
    if ( !player currency::can_afford( str_currency, n_half_cost ) || var_c6969b9fb8f1cf23.var_6f1622c6d6cc8ac2 )
    {
        player playsoundtoplayer( "ui_zm_core_door_purchase_deny", player );
        return;
    }
    
    var_87a61a281906b856 = player currency::get_currency_amount( str_currency );
    
    if ( var_87a61a281906b856 > 0 )
    {
        var_c6969b9fb8f1cf23.script_cost -= n_half_cost;
        var_c6969b9fb8f1cf23.var_6f1622c6d6cc8ac2 = 1;
        var_c6969b9fb8f1cf23.var_82715ba80990f81e = player;
        player currency::function_b5fe1e05c892a7f3( str_currency, n_half_cost );
        player playsoundtoplayer( "ui_zm_core_door_purchase_partial", player );
        var_779c2c832b8369c1 = var_c6969b9fb8f1cf23.f_notify;
        
        if ( isfunction( var_779c2c832b8369c1 ) )
        {
            var_c6969b9fb8f1cf23 thread [[ var_779c2c832b8369c1 ]]( player, 1 );
        }
        
        params = spawnstruct();
        params.cost = n_half_cost;
        params.currency = str_currency;
        params.var_1861bb0ab1c8aef6 = var_c6969b9fb8f1cf23.origin;
        player callback::callback( "interact_contributed", params );
        player thread function_4a3b25f8a29f99dd( self );
        return;
    }
}

// Namespace zm_utility
// Params 5
// Checksum 0xd1497efb, Offset: 0x3b18
// Size: 0x206
function function_5bbd540197e3fd( n_stun_time = 100, var_e3d09e0a75f7ca46 = 0.1, var_e3f3b00a761e3994 = 0.5, b_double_effect = 1, var_110cc40fad107c09 = 0 )
{
    self endon( #"death" );
    self.nuked = 1;
    self.no_powerups = 1;
    self.var_a13bed1ac47e1b2c = 1;
    self.full_gib = 1;
    self.var_65522105f3bdca37 = 1;
    
    if ( n_stun_time )
    {
        thread zombie_stun::stun_ai( n_stun_time );
    }
    
    if ( !isdefined( level._effect[ "zombie_impact" ] ) )
    {
        level._effect[ "zombie_impact" ] = loadfxasset( "vfx_t10_levels_zm_quartz_machine_amp_impact" );
    }
    
    if ( !isdefined( level._effect[ "zombie_impact_blood" ] ) )
    {
        level._effect[ "zombie_impact_blood" ] = loadfxasset( "vfx_t10_levels_zm_quartz_machine_amp_impact_blood" );
    }
    
    var_d8c7a0fac844e6b = utility::getfx( "zombie_impact" );
    var_b0a812f37b404b6e = utility::getfx( "zombie_impact_blood" );
    
    if ( b_double_effect )
    {
        if ( isalive( self ) && self tagexists( "j_spine4" ) )
        {
            self.pap_stun_fx = playfxontag( var_d8c7a0fac844e6b, self, "j_spine4" );
        }
        
        wait randomfloatrange( var_e3d09e0a75f7ca46, var_e3f3b00a761e3994 );
    }
    
    if ( isalive( self ) && self tagexists( "j_spine4" ) )
    {
        self.pap_stun_fx = stopfxontag( var_d8c7a0fac844e6b, self, "j_spine4" );
        self.pap_death_fx = playfxontag( var_b0a812f37b404b6e, self, "j_spine4" );
    }
    
    wait randomfloatrange( 0.1, 0.25 );
    
    if ( isalive( self ) )
    {
        if ( var_110cc40fad107c09 && !self.ignore_enemy_count )
        {
            zm_cleanup_manager::function_dd62e2042418b7e5();
        }
        
        if ( self.magic_bullet_shield || val::get( "damageshield" ) )
        {
            ai::stop_magic_bullet_shield();
        }
        
        self kill();
    }
}

// Namespace zm_utility
// Params 8
// Checksum 0xa05849fb, Offset: 0x3d26
// Size: 0x20d
function function_1d82e63812f9640a( origin_or_ent, n_radius, var_f55170cfcc61bc4f = 1, var_5838405cfc936093 = "damage_heavy", var_907e91687498d736 = 0.5, var_32b5f0bc77155033, var_ba94bb1f499445dc = "damage_light", var_c4076bd4c6f8f8c1 = 0.2 )
{
    level endon( #"game_ended" );
    assert( isvector( origin_or_ent ) || isent( origin_or_ent ), "<dev string:x226>" );
    
    if ( isent( origin_or_ent ) )
    {
        var_dac75f4116c98678 = origin_or_ent.origin;
        origin_or_ent endon( #"end_rumble" );
    }
    else
    {
        var_dac75f4116c98678 = origin_or_ent;
    }
    
    a_players = getplayersinradius( var_dac75f4116c98678, n_radius );
    
    foreach ( player in a_players )
    {
        player playrumbleonentity( var_5838405cfc936093 );
        player earthquakeforplayer( var_907e91687498d736, var_f55170cfcc61bc4f, var_dac75f4116c98678, n_radius );
    }
    
    if ( isdefined( var_32b5f0bc77155033 ) )
    {
        a_players = getplayersinradius( var_dac75f4116c98678, var_32b5f0bc77155033 );
        
        foreach ( player in a_players )
        {
            if ( distance2dsquared( player.origin, var_dac75f4116c98678 ) > squared( n_radius ) )
            {
                player playrumbleonentity( var_ba94bb1f499445dc );
                player earthquakeforplayer( var_c4076bd4c6f8f8c1, var_f55170cfcc61bc4f, var_dac75f4116c98678, var_32b5f0bc77155033 );
            }
        }
    }
    
    wait var_f55170cfcc61bc4f;
}

// Namespace zm_utility
// Params 0
// Checksum 0x16da23ea, Offset: 0x3f3b
// Size: 0x1fc
function function_9b91e8ba219b49ba()
{
    var_62638af37653ded7 = utility::getstructarray( "teddtask", "script_noteworthy" );
    
    foreach ( destination in var_62638af37653ded7 )
    {
        function_f78ef2b017ee16c2( destination );
    }
    
    var_62638af37653ded7 = utility::getstructarray( "teddtask_killzone", "script_noteworthy" );
    
    foreach ( destination in var_62638af37653ded7 )
    {
        function_f78ef2b017ee16c2( destination );
    }
    
    var_62638af37653ded7 = utility::getstructarray( "teddtask_holdzone", "script_noteworthy" );
    
    foreach ( destination in var_62638af37653ded7 )
    {
        function_f78ef2b017ee16c2( destination );
    }
    
    var_62638af37653ded7 = utility::getstructarray( "teddtask_holdzone_and_killzone", "script_noteworthy" );
    
    foreach ( destination in var_62638af37653ded7 )
    {
        function_f78ef2b017ee16c2( destination );
    }
}

// Namespace zm_utility
// Params 1
// Checksum 0xfa86544c, Offset: 0x413f
// Size: 0x9e
function function_f78ef2b017ee16c2( instance )
{
    a_cols = function_3627db2cb6b33dfe( instance.script_location );
    
    foreach ( col in a_cols )
    {
        col notsolid();
        col connectpaths();
    }
}

// Namespace zm_utility
// Params 1
// Checksum 0x672f3aac, Offset: 0x41e5
// Size: 0xbc
function function_3627db2cb6b33dfe( script_loc )
{
    a_cols = [];
    var_5d90897eaecbeed3 = getentarray( "task_col", #targetname );
    
    if ( isdefined( var_5d90897eaecbeed3 ) )
    {
        foreach ( task_col in var_5d90897eaecbeed3 )
        {
            if ( task_col.script_location == script_loc )
            {
                a_cols[ a_cols.size ] = task_col;
            }
        }
    }
    
    return a_cols;
}

// Namespace zm_utility
// Params 2
// Checksum 0x17fdf11a, Offset: 0x42aa
// Size: 0x38
function function_4c161e50ce2233e6( var_c0f0e681f6ab932d, weight )
{
    n_nav_obstacle = createnavbadplacebyent( self, weight );
    utility::waittill_any_in_array( var_c0f0e681f6ab932d );
    destroynavobstacle( n_nav_obstacle );
}

// Namespace zm_utility
// Params 0
// Checksum 0xb8b69ebd, Offset: 0x42ea
// Size: 0x94, Type: bool
function function_87c7047a00d0f447()
{
    if ( utility::ent_flag( "napalm_burned" ) )
    {
        return true;
    }
    
    if ( utility::ent_flag( "cryofreeze_active" ) )
    {
        return true;
    }
    
    if ( utility::ent_flag( "deadwire_stun_kill" ) || utility::ent_flag( "deadwire_stunned" ) )
    {
        return true;
    }
    
    if ( self.shadow_vortex_killed )
    {
        return true;
    }
    
    if ( self.killed_by_shatterblast )
    {
        return true;
    }
    
    if ( self.var_bd22ba6c600a23a3 )
    {
        return true;
    }
    
    if ( utility::ent_flag( "fw_damage" ) )
    {
        return true;
    }
    
    if ( utility::ent_flag( "lightray_damage" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_utility
// Params 0
// Checksum 0x8bbe244c, Offset: 0x4387
// Size: 0x20
function is_killed_by_augment()
{
    if ( self.var_6b1845284e358d3e )
    {
        return 1;
    }
    
    if ( self.var_c13640c265c43c23 )
    {
        return 1;
    }
}

// Namespace zm_utility
// Params 1
// Checksum 0xa505bd9c, Offset: 0x43af
// Size: 0xaf, Type: bool
function is_weapon_field_upgrade( sweapon )
{
    if ( sweapon.var_1616e6fbba9a722d == %"energy_mine" )
    {
        return true;
    }
    
    if ( sweapon.var_1616e6fbba9a722d == %"toxic_growth" )
    {
        return true;
    }
    
    if ( sweapon.var_1616e6fbba9a722d == %"mary_paris" )
    {
        return true;
    }
    
    if ( sweapon.var_1616e6fbba9a722d == %"dark_flare" )
    {
        return true;
    }
    
    if ( sweapon.var_1616e6fbba9a722d == %"frost_blast" )
    {
        return true;
    }
    
    if ( sweapon.var_1616e6fbba9a722d == %"tesla_storm" )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_utility
// Params 1
// Checksum 0x89e32a46, Offset: 0x4467
// Size: 0x224
function setup_quest_ai( params )
{
    assert( isai( self ) );
    assert( isalive( self ) );
    
    if ( !isdefined( params ) )
    {
        params = spawnstruct();
    }
    
    self setscriptablepartstate( "base", params.var_245ab3f42c3e1f06 ?? "base_purple_eyes", 0 );
    val::set( "zm_quest", "ignore_cleanup", params.b_ignore_cleanup ?? 1 );
    self.b_cleanup_no_respawn = params.b_cleanup_no_respawn ?? 1;
    self.var_15598d8e493afe88 = params.var_15598d8e493afe88 ?? 1;
    self.var_825b17c932865df = params.var_825b17c932865df ?? 1;
    self.ignore_enemy_count = params.ignore_enemy_count ?? 1;
    self.var_50c96a5c56dab386 = params.var_50c96a5c56dab386;
    self.no_powerups = params.no_powerups ?? 1;
    
    if ( !self.var_50c96a5c56dab386 )
    {
        self.var_a13bed1ac47e1b2c = params.var_a13bed1ac47e1b2c ?? 1;
    }
    
    if ( !isdefined( params.n_round_difficulty ) )
    {
        params.n_round_difficulty = get_round_number();
    }
    
    zombie_utils::set_zombie_round_difficulty( params.n_round_difficulty );
    
    if ( !isdefined( params.str_move_speed ) )
    {
        params.str_move_speed = zm_round_spawning::function_6211dbc10409aa10( params.n_round_difficulty );
    }
    
    zombie_utils::function_a8ce00e0448cb6f0( params.str_move_speed, "zm_quest", 6 );
    
    if ( !params.kiastring )
    {
        if ( self.aicategory == "elite" )
        {
            self.kiastring = #"zombie_kia_mission_kill_elite";
        }
        else if ( self.aicategory == "special" )
        {
            self.kiastring = #"zombie_kia_mission_kill_special";
        }
        else
        {
            self.kiastring = #"zombie_kia_mission_kill";
        }
        
        return;
    }
    
    self.kiastring = params.kiastring;
}

// Namespace zm_utility
// Params 2
// Checksum 0x91c401cd, Offset: 0x4693
// Size: 0xb6
function function_549e7bc8f78816f2( var_566be53f7c461bc8, var_96b98a5c6cd91b06 = getarraykeys( level.contentmanager.toggle_type ) )
{
    foreach ( feature_type in var_96b98a5c6cd91b06 )
    {
        content_manager::function_150b588eee953686( feature_type, &function_6b031707d6ac6bc7, { #var_566be53f7c461bc8:var_566be53f7c461bc8 } );
    }
}

// Namespace zm_utility
// Params 2
// Checksum 0x91c401cd, Offset: 0x4751
// Size: 0xb6
function function_81ecff068420355d( var_566be53f7c461bc8, var_96b98a5c6cd91b06 = getarraykeys( level.contentmanager.toggle_type ) )
{
    foreach ( feature_type in var_96b98a5c6cd91b06 )
    {
        content_manager::function_d87b461e00238279( feature_type, &function_6b031707d6ac6bc7, { #var_566be53f7c461bc8:var_566be53f7c461bc8 } );
    }
}

// Namespace zm_utility
// Params 1, eflags: 0x4
// Checksum 0x46200094, Offset: 0x480f
// Size: 0xc4, Type: bool
function private function_6b031707d6ac6bc7( sparams )
{
    var_87886397e909c08b = sparams.var_566be53f7c461bc8;
    
    if ( !isdefined( self.zone_name ) )
    {
        feature_zone = zone_manager::function_90e5c3e2272b0130( self.origin );
        zone_name = feature_zone.zone_name;
        
        if ( !isdefined( zone_name ) )
        {
            tacpoint = ai::function_20e2b5e7fcba9f36( self.origin, 256, 0, 128 );
            zone_name = tacpoint.var_6f9c4e415e80942f;
        }
        
        self.zone_name = zone_name;
    }
    
    generalized_zone_name = function_fbb7d4c98261e273( self.zone_name );
    
    if ( arraycontains( var_87886397e909c08b, generalized_zone_name ) )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_utility
// Params 2
// Checksum 0xf1ac961a, Offset: 0x48dc
// Size: 0x86
function function_fbb7d4c98261e273( zone_name, var_1cb5ff2f8f06b8bf = 3 )
{
    var_93d84a67723d6fe6 = strtok( zone_name, "_" );
    
    if ( var_93d84a67723d6fe6.size > var_1cb5ff2f8f06b8bf )
    {
        generalized_zone_name = "";
        
        for ( i = 0; i < var_1cb5ff2f8f06b8bf ; i++ )
        {
            generalized_zone_name += var_93d84a67723d6fe6[ i ];
            
            if ( i < var_1cb5ff2f8f06b8bf - 1 )
            {
                generalized_zone_name += "_";
            }
        }
        
        return generalized_zone_name;
    }
    
    return zone_name;
}

// Namespace zm_utility
// Params 1
// Checksum 0xf312577b, Offset: 0x496b
// Size: 0xe9
function function_81b8d5704842d1ea( duration )
{
    self endon( #"death_or_disconnect" );
    
    if ( !isplayer( self ) || self.inlaststand )
    {
        return;
    }
    
    gestureref = "vm_ges_shockstick_react";
    curweapon = self getcurrentweapon();
    
    if ( weapon::isfistweapon( curweapon ) )
    {
        gestureref = "vm_ges_shockstick_react_fists";
    }
    
    while ( !self isgestureplaying( gestureref ) )
    {
        self forceplaygestureviewmodel( gestureref );
        waitframe();
    }
    
    shock_stick::function_904e61c3aefb61c2( 1 );
    self setscriptablepartstate( "shockStickVfx", "vfx_start", 0 );
    shock_stick::function_ef03efbecb279b8a( 1 );
    self setmovespeedscale( 0.8 );
    self setempjammed( 1 );
    wait duration;
    shock_stick::function_904e61c3aefb61c2( 0 );
    self stopgestureviewmodel( gestureref );
    self setscriptablepartstate( "shockStickVfx", "off", 0 );
    shock_stick::function_ef03efbecb279b8a( 0 );
    self setmovespeedscale( 1 );
    self setempjammed( 0 );
}

// Namespace zm_utility
// Params 1
// Checksum 0xa4395c9c, Offset: 0x4a5c
// Size: 0x9d
function function_814e28ebc00f977d( str_name )
{
    if ( !isdefined( self.fist_utility ) )
    {
        self.fist_utility = [];
    }
    
    var_d7cea369c5fc90c3 = 0;
    
    if ( !self hasweapon( level.defaultfist ) )
    {
        inventory_utility::_giveweapon( level.defaultfist );
        var_d7cea369c5fc90c3 = 1;
    }
    
    self.fist_utility[ str_name ] = { #gave_fist:var_d7cea369c5fc90c3, #prior_weap:self getcurrentweapon() };
    
    if ( self getcurrentweapon() != level.defaultfist )
    {
        self switchtoweapon( level.defaultfist );
    }
}

// Namespace zm_utility
// Params 1
// Checksum 0xa24cc211, Offset: 0x4b01
// Size: 0xc4
function take_fist( str_name )
{
    if ( !isdefined( self.fist_utility[ str_name ] ) )
    {
        return;
    }
    
    data = self.fist_utility[ str_name ];
    
    if ( data.gave_fist )
    {
        inventory_utility::_takeweapon( level.defaultfist );
    }
    
    if ( isdefined( data.prior_weap ) && self hasweapon( data.prior_weap ) )
    {
        if ( data.prior_weap != level.defaultfist )
        {
            self switchtoweapon( data.prior_weap );
        }
    }
    else if ( val::get( "weapon" ) )
    {
        inventory_utility::forcevalidweapon();
    }
    
    self.fist_utility[ str_name ] = undefined;
}

// Namespace zm_utility
// Params 3
// Checksum 0x44e466b0, Offset: 0x4bcd
// Size: 0x90
function force_revive_player( var_f59112f841c0e3b3 = "last_stand_revived", reviver = self, restore_perks )
{
    self.var_287f29fa987acd1c = restore_perks;
    
    if ( !isalive( self ) || self.sessionstate == "spectator" )
    {
        self.var_14955bc056bab547 = 1;
        thread playerlogic::spawnclient();
        utility::waittill_any_timeout( 3, "spawned_player" );
        return;
    }
    
    if ( player::isinlaststand( self ) )
    {
        laststand::exit( var_f59112f841c0e3b3, reviver );
    }
}

