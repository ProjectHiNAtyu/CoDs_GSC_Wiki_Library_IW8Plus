// scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_rb.gsc  (hash_53640cdf4c3c6c0c.gscc) (size: 20435 Bytes / 0x4fd3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x34b71fab (884416427)
// size ...... 20435 (0x4fd3)
// includes .. 17  (offset: 0x4a9b)
// strings ... 72  (offset: 0x4b23)
// dev strs .. 5   (offset: 0x4f97)
// exports ... 49  (offset: 0x31e7)
// cseg ...... 0x720 + 0x2ac7 (0x31e7)
// imports ... 138 (offset: 0x398f)
// animtree1 . 0   (offset: 0x4fd3)
// animtree2 . 0   (offset: 0x4fd3)
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\doorbuy;
#using scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_lighting;
#using scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_phone;
#using scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_quest_fork_ee;
#using scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_usurped_power;
#using scripts\mp\zm\spawners\agent_spawner;
#using scripts\mp\zm\spawners\zone_spawner;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_scarab_rb;

// Namespace zm_sat_scarab_rb
// Params 0
// Checksum 0x295f1295, Offset: 0x73e
// Size: 0x472
function init()
{
    level callback::add( "on_round_start", &on_round_start );
    level callback::add( "special_round_start", &on_special_round_start );
    level callback::add( "special_round_end", &on_special_round_end );
    level callback::add( "doorbuy_opened", &on_door_opened );
    level callback::add( "on_zombie_ai_killed", &function_702c650fe42c7f2a );
    level callback::add( "on_zombie_ai_killed", &function_fe190410f2fa2802 );
    level callback::add( #"game_ended", &on_game_ended );
    level callback::add( #"player_connect", &function_6dd3acc93fbb515e );
    level callback::add( #"player_disconnect", &function_762dcb6d5df2da6b );
    level callback::add( #"player_disconnect", &function_6c48546d2605cf48 );
    level callback::add( #"hash_5b8b82c2527d7aa2", &function_25385c89de250b55 );
    level callback::add( #"hash_347b41546632b85a", &function_272ebe68c945c463 );
    level utility::registersharedfunc( #"scarab_rain", #"hash_bd3ce90cea3f86b5", &function_7b12e1e25549d6e4 );
    level utility::registersharedfunc( #"scarab_rain", #"hash_efe074ec11372361", &function_f4ab1277de839732 );
    level._effect[ #"hash_5b258c3fd26f55c4" ] = loadfxasset( "vfx_sat_levels_zm_firefly_the_fog_despawn" );
    level._effect[ #"hash_5b5db66e0adb4b38" ] = loadfxasset( "vfx_sat_levels_zm_firefly_the_fog_despawn_callisto" );
    level.var_824b6ad533e38010 = &function_b434e4e4797c7417;
    level.var_cf1e7c54e92a83ff = 0;
    level.var_a5c5eceb906ed2cc = 0;
    
    if ( !isdefined( level.var_826c2033d912172c ) )
    {
        level.var_826c2033d912172c = [];
    }
    
    if ( !isdefined( level.var_ea59489f1916a390 ) )
    {
        level.var_ea59489f1916a390 = level.getspawnpoint;
    }
    
    level.getspawnpoint = &function_529cc4f7c5318b80;
    level.var_f94278b2fd45aaf3 = &restoreplayer;
    level.var_654073823a58b613 = &function_d540551039ceab39;
    
    foreach ( zone_name in [ "zone_safehouse_interior_upper_bedroom_1", "zone_safehouse_interior_upper_bedroom_2", "zone_safehouse_interior_lower", "zone_safehouse_interior_upper", "zone_safehouse_exterior" ] )
    {
        zone_spawner::function_3d210dfed7f384df( "zombie_loom", zone_name );
        zone_spawner::function_3d210dfed7f384df( "zombie_abom", zone_name );
    }
    
    level thread watch_player_zones();
    level thread function_73d1a26d8a9a0ae6( 0 );
    level.var_7f29a2c7fe5ec0ef = &function_3e3297b71b785f46;
    level.var_609a4c84665ec35 = &function_391057f2a7d79035;
    zm_sat_scarab_phone::init();
    
    /#
        setup_map_devgui();
    #/
    
    level utility::flag_wait( "scriptables_ready" );
    var_b75aab2674b75dbd = utility::getstructarray( "hotfix_rock", "targetname" );
    
    foreach ( rock in var_b75aab2674b75dbd )
    {
        spawnscriptable( rock.script_noteworthy, rock.origin, rock.angles, undefined, function_67b78af3c33ac9a8( rock.script_float ) );
    }
    
    var_11e67593d01bdef7 = utility::getstructarray( "hotfix_doorbuy_clip", "targetname" );
    
    foreach ( clip in var_11e67593d01bdef7 )
    {
        clip.var_ace3abd1d884f155 = spawnscriptable( "sat_zm_hotfix_doorbuy_clip", clip.origin, clip.angles );
        
        if ( clip.var_ace3abd1d884f155 )
        {
            clip thread function_bc0d21fc8fe5d52d();
        }
    }
    
    level thread function_beb133c98d86cc9c();
    level thread function_95fac61c9dfe5b5d();
}

// Namespace zm_sat_scarab_rb
// Params 0
// Checksum 0x8afe4eaf, Offset: 0xbb8
// Size: 0x52
function function_95fac61c9dfe5b5d()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "airdrop_init_crate_data" );
    
    if ( level.cratedropdata && isdefined( level.cratedropdata.heliheight ) )
    {
        level.cratedropdata.heliheight = undefined;
    }
}

// Namespace zm_sat_scarab_rb
// Params 0
// Checksum 0xdb5f0e30, Offset: 0xc12
// Size: 0x159
function function_beb133c98d86cc9c()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "doorbuy_init_complete" );
    
    foreach ( door in level.a_s_doorbuys )
    {
        if ( door.target2 == "doorbuy_door_5" )
        {
            foreach ( sub_door in door.doors )
            {
                if ( isdefined( sub_door ) && isdefined( sub_door.classname ) && sub_door.classname == "trigger_multiple" && isdefined( sub_door.minimap_scriptable ) )
                {
                    sub_door.minimap_scriptable freescriptable();
                }
            }
        }
    }
}

// Namespace zm_sat_scarab_rb
// Params 0
// Checksum 0x5fc60912, Offset: 0xd73
// Size: 0x3b
function function_bc0d21fc8fe5d52d()
{
    level endon( #"game_ended" );
    
    if ( !self.script_noteworthy )
    {
        return;
    }
    
    level utility::flag_wait( self.script_noteworthy );
    self.var_ace3abd1d884f155 freescriptable();
}

// Namespace zm_sat_scarab_rb
// Params 0, eflags: 0x4
// Checksum 0x77facd90, Offset: 0xdb6
// Size: 0x48
function private restoreplayer()
{
    self endon( #"death_or_disconnect" );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    if ( utility::ent_flag( "is_usurped_power_grabbed" ) )
    {
        zm_sat_scarab_usurped_power::restoreplayer();
        return;
    }
    
    if ( zm_sat_scarab_quest_fork_ee::function_d7c5362769797706( self getcurrentweapon() ) )
    {
        zm_sat_scarab_quest_fork_ee::function_72a8e3b2588248bb( undefined, 1 );
    }
}

// Namespace zm_sat_scarab_rb
// Params 0, eflags: 0x4
// Checksum 0x142056e, Offset: 0xe06
// Size: 0x1c7
function private function_529cc4f7c5318b80()
{
    if ( !self.hasspawned && !zm_save::function_fcccc3d2a616b1c7() && ( !utility::flag( "begin_round_logic" ) || !level.var_a4dcfacd7ce9e0f5 ) )
    {
        spawn_points = utility::getstructarray( "initial_spawn_points", "targetname" );
        var_ed5654f2cc053915 = [];
        var_777dd96d7b1fcabe = [];
        
        foreach ( spawn_point in spawn_points )
        {
            if ( spawn_point.script_label == "spawn_room_1" )
            {
                var_ed5654f2cc053915[ var_ed5654f2cc053915.size ] = spawn_point;
                continue;
            }
            
            if ( spawn_point.script_label == "spawn_room_2" )
            {
                var_777dd96d7b1fcabe[ var_777dd96d7b1fcabe.size ] = spawn_point;
            }
        }
        
        if ( var_ed5654f2cc053915.size > 0 && var_777dd96d7b1fcabe.size > 0 )
        {
            if ( !isdefined( level.var_75feb18bc1b1da09 ) )
            {
                if ( utility::cointoss() )
                {
                    level.var_75feb18bc1b1da09 = 0;
                }
                else
                {
                    level.var_75feb18bc1b1da09 = 1;
                }
            }
            
            var_c3b4c6f6a1669a38 = function_6f6c6617bcd265e0();
            var_53a8ae1e8831d59c = var_ed5654f2cc053915;
            var_e2723c2c6425b7c6 = var_777dd96d7b1fcabe;
            
            if ( var_c3b4c6f6a1669a38.room_index == 0 )
            {
                var_2a89d5e7d3f0b14b = var_53a8ae1e8831d59c;
            }
            else
            {
                var_2a89d5e7d3f0b14b = var_e2723c2c6425b7c6;
            }
            
            spawn_point = var_2a89d5e7d3f0b14b[ var_c3b4c6f6a1669a38.var_d97c1d887461ab3b % var_2a89d5e7d3f0b14b.size ];
            spawn_point.index = self getentitynumber();
            return spawn_point;
        }
    }
    
    return [[ level.var_ea59489f1916a390 ]]();
}

// Namespace zm_sat_scarab_rb
// Params 0, eflags: 0x4
// Checksum 0xb1515a24, Offset: 0xfd6
// Size: 0x71
function private function_6f6c6617bcd265e0()
{
    player_num = self getentitynumber();
    assignment = level.var_826c2033d912172c[ player_num ];
    
    if ( isdefined( assignment ) )
    {
        return assignment;
    }
    
    room_index = function_14b2923fbbd7c43f();
    assignment = { #var_d97c1d887461ab3b:function_41601bfaa8708bbe( room_index ), #room_index:room_index };
    level.var_826c2033d912172c[ player_num ] = assignment;
    return assignment;
}

// Namespace zm_sat_scarab_rb
// Params 0, eflags: 0x4
// Checksum 0x4b08614, Offset: 0x1050
// Size: 0x43
function private function_14b2923fbbd7c43f()
{
    var_eb0555b8707b22e2 = function_41601bfaa8708bbe( 0 );
    var_148cb9bf3fd49fcc = function_41601bfaa8708bbe( 1 );
    
    if ( var_eb0555b8707b22e2 < var_148cb9bf3fd49fcc )
    {
        return 0;
    }
    
    if ( var_148cb9bf3fd49fcc < var_eb0555b8707b22e2 )
    {
        return 1;
    }
    
    return level.var_75feb18bc1b1da09;
}

// Namespace zm_sat_scarab_rb
// Params 1, eflags: 0x4
// Checksum 0x7aacb2df, Offset: 0x109c
// Size: 0xa4
function private function_41601bfaa8708bbe( room_index )
{
    player_count = 0;
    
    foreach ( assignment in level.var_826c2033d912172c )
    {
        if ( isdefined( assignment ) && assignment.room_index == room_index )
        {
            player_count++;
        }
    }
    
    return player_count;
}

// Namespace zm_sat_scarab_rb
// Params 1, eflags: 0x4
// Checksum 0x290037c7, Offset: 0x1149
// Size: 0x1b
function private function_6c48546d2605cf48( params )
{
    level.var_826c2033d912172c[ self getentitynumber() ] = undefined;
}

// Namespace zm_sat_scarab_rb
// Params 0
// Checksum 0x5a9ba58, Offset: 0x116c
// Size: 0x2d
function function_3e3297b71b785f46()
{
    if ( level.var_cf1e7c54e92a83ff || level.var_a5c5eceb906ed2cc )
    {
        level.var_7f29a2c7fe5ec0ef = undefined;
        return 1;
    }
    
    return 1.5;
}

// Namespace zm_sat_scarab_rb
// Params 0
// Checksum 0x464fef8a, Offset: 0x11a2
// Size: 0x2cb
function function_d540551039ceab39()
{
    level endon( #"game_ended" );
    
    if ( function_2e2efdce3be6826b() )
    {
        var_876df33c4d1c4f08 = [ "zone_safehouse_interior_upper_bedroom_1", "zone_safehouse_interior_upper_bedroom_2", "zone_safehouse_interior_lower", "zone_safehouse_interior_upper", "zone_safehouse_exterior" ];
    }
    else
    {
        if ( !isdefined( level.var_9d6633638a1fd39d ) )
        {
            level.var_9d6633638a1fd39d = [];
        }
        
        if ( level.var_9d6633638a1fd39d.size == 0 )
        {
            all_zones = zone_manager::get_all_zones();
            
            foreach ( zone in all_zones )
            {
                if ( !function_95af7a773f7c57d1( zone.zone_name ) )
                {
                    if ( !isdefined( level.var_9d6633638a1fd39d ) )
                    {
                        level.var_9d6633638a1fd39d = [];
                    }
                    
                    level.var_9d6633638a1fd39d[ level.var_9d6633638a1fd39d.size ] = zone.zone_name;
                }
            }
        }
        
        var_876df33c4d1c4f08 = level.var_9d6633638a1fd39d;
    }
    
    var_28dfa6f197d4d46a = zone_manager::function_90e5c3e2272b0130( self.origin + ( 0, 0, 32 ) );
    
    if ( isdefined( var_28dfa6f197d4d46a ) )
    {
        str_ignore_zone = var_28dfa6f197d4d46a.zone_name;
    }
    
    var_d741aeceea421b0e = utility::getstructarray( "player_respawn_point", "targetname" );
    var_7d2a636b261c6545 = [];
    
    foreach ( var_1e4139ca72a33905 in var_d741aeceea421b0e )
    {
        var_8c4fe62d01999d1e = zone_manager::function_90e5c3e2272b0130( var_1e4139ca72a33905.origin );
        
        if ( isdefined( var_8c4fe62d01999d1e ) && isdefined( str_ignore_zone ) && !arraycontains( var_876df33c4d1c4f08, var_8c4fe62d01999d1e.zone_name ) )
        {
            continue;
        }
        
        if ( zone_manager::function_65305a611c6226d9( var_1e4139ca72a33905.origin ) )
        {
            var_7d2a636b261c6545[ var_7d2a636b261c6545.size ] = var_1e4139ca72a33905;
        }
    }
    
    var_a87104a582b02a9e = undefined;
    
    if ( var_7d2a636b261c6545.size > 0 )
    {
        var_ba4504ab9b6e7a9a = utility::array_random( var_7d2a636b261c6545 );
        var_aa9244ac3dd1149 = utility::getstructarray( var_ba4504ab9b6e7a9a.target, "targetname" );
        var_c4dbda4969a702ac = self getentitynumber();
        var_a87104a582b02a9e = var_aa9244ac3dd1149[ var_c4dbda4969a702ac ];
    }
    
    return var_a87104a582b02a9e;
}

// Namespace zm_sat_scarab_rb
// Params 1
// Checksum 0xa174c920, Offset: 0x1476
// Size: 0x254
function function_b434e4e4797c7417( var_bc661ad67960c4e3 )
{
    if ( !var_bc661ad67960c4e3 )
    {
        return;
    }
    
    if ( level.players.size > 1 )
    {
        foreach ( player in level.players )
        {
            if ( zm_utility::is_player_valid_target( player ) && !player.var_beca16e2387aa2d0 && !player.ignoreme )
            {
                aitype = function_b3988325430ce242( var_bc661ad67960c4e3 ) ?? var_bc661ad67960c4e3;
                zombie = zone_spawner::function_c5801414561a5dab( aitype, player, 1 );
                
                if ( zombie )
                {
                    player.var_beca16e2387aa2d0 = 1;
                    return zombie;
                }
            }
        }
        
        var_dc4fa75655c6106d = [];
        
        foreach ( player in level.players )
        {
            player.var_beca16e2387aa2d0 = 0;
            
            if ( zm_utility::is_player_valid_target( player ) && !player.ignoreme )
            {
                var_dc4fa75655c6106d[ var_dc4fa75655c6106d.size ] = player;
            }
        }
        
        if ( var_dc4fa75655c6106d.size == 0 )
        {
            return agent_spawner::spawn_agent( var_bc661ad67960c4e3, 1 );
        }
        
        randomplayerindex = randomint( var_dc4fa75655c6106d.size );
        var_95b86e61b2c6a7 = var_dc4fa75655c6106d[ randomplayerindex ];
        aitype = function_b3988325430ce242( var_bc661ad67960c4e3 ) ?? var_bc661ad67960c4e3;
        zombie = zone_spawner::function_c5801414561a5dab( aitype, var_95b86e61b2c6a7, 1 );
        
        if ( zombie )
        {
            var_95b86e61b2c6a7.var_beca16e2387aa2d0 = 1;
            return zombie;
        }
    }
    else
    {
        aitype = function_b3988325430ce242( var_bc661ad67960c4e3 ) ?? var_bc661ad67960c4e3;
        
        if ( level.mapinfobundle.var_b7bdaf6a2a733aaa && arraycontains( level.var_d24e66b3dd54be4a, aitype ) )
        {
            zombie = zone_spawner::spawn_single_dog( aitype );
        }
        else
        {
            zombie = agent_spawner::spawn_agent( aitype, 1 );
        }
    }
    
    return zombie;
}

// Namespace zm_sat_scarab_rb
// Params 1
// Checksum 0xaed16355, Offset: 0x16d3
// Size: 0x373
function on_door_opened( params )
{
    if ( params.door.targetname == "doorbuy_safehouse_bedroom_1" || params.door.targetname == "doorbuy_safehouse_bedroom_2" )
    {
        if ( level.players.size <= 1 )
        {
            if ( params.door.targetname == "doorbuy_safehouse_bedroom_1" && !level.var_cf1e7c54e92a83ff )
            {
                level.var_cf1e7c54e92a83ff = 1;
                level.var_a5c5eceb906ed2cc = 1;
                starting_doors = getentarray( "doorbuy_safehouse_bedroom_2", "targetname" );
                
                foreach ( door in starting_doors )
                {
                    foreach ( interact in door.var_fc824b622a52db8d )
                    {
                        if ( isent( interact ) && interact isusable() )
                        {
                            interact doorbuy::doorbuy_used( undefined, 0, 1 );
                            break;
                        }
                    }
                }
            }
            else if ( params.door.targetname == "doorbuy_safehouse_bedroom_2" && !level.var_a5c5eceb906ed2cc )
            {
                level.var_cf1e7c54e92a83ff = 1;
                level.var_a5c5eceb906ed2cc = 1;
                starting_doors = getentarray( "doorbuy_safehouse_bedroom_1", "targetname" );
                
                foreach ( door in starting_doors )
                {
                    foreach ( interact in door.var_fc824b622a52db8d )
                    {
                        if ( isent( interact ) && interact isusable() )
                        {
                            interact doorbuy::doorbuy_used( undefined, 0, 1 );
                            break;
                        }
                    }
                }
            }
        }
        
        if ( params.door.targetname == "doorbuy_safehouse_bedroom_1" )
        {
            level.var_cf1e7c54e92a83ff = 1;
        }
        else if ( params.door.targetname == "doorbuy_safehouse_bedroom_2" )
        {
            level.var_a5c5eceb906ed2cc = 1;
        }
        
        if ( level.var_cf1e7c54e92a83ff && level.var_a5c5eceb906ed2cc || level.var_a4dcfacd7ce9e0f5 )
        {
            level.var_824b6ad533e38010 = undefined;
        }
    }
}

// Namespace zm_sat_scarab_rb
// Params 1
// Checksum 0xc89385bc, Offset: 0x1a4e
// Size: 0xb2
function on_round_start( sparams )
{
    foreach ( player in level.players )
    {
        player.var_beca16e2387aa2d0 = 0;
    }
    
    if ( sparams.roundnumber >= 10 && isdefined( level.var_824b6ad533e38010 ) )
    {
        level.var_824b6ad533e38010 = undefined;
    }
}

// Namespace zm_sat_scarab_rb
// Params 0
// Checksum 0x51deb67d, Offset: 0x1b08
// Size: 0x8f, Type: bool
function function_64977c0d702cc59d()
{
    foreach ( player in level.players )
    {
        if ( !isalive( player ) )
        {
            continue;
        }
        
        if ( !function_44d92249f25f7170( player ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace zm_sat_scarab_rb
// Params 0
// Checksum 0xb9ffdad0, Offset: 0x1ba0
// Size: 0xaa
function function_41160421ad0382b()
{
    var_66565a6231a1994a = [];
    
    foreach ( player in level.players )
    {
        if ( !isalive( player ) )
        {
            continue;
        }
        
        if ( !function_44d92249f25f7170( player ) )
        {
            continue;
        }
        
        if ( !isdefined( var_66565a6231a1994a ) )
        {
            var_66565a6231a1994a = [];
        }
        
        var_66565a6231a1994a[ var_66565a6231a1994a.size ] = player;
    }
    
    return var_66565a6231a1994a;
}

// Namespace zm_sat_scarab_rb
// Params 1
// Checksum 0x3428e126, Offset: 0x1c53
// Size: 0xd4, Type: bool
function function_44d92249f25f7170( player )
{
    foreach ( zone_name in [ "zone_safehouse_interior_upper_bedroom_1", "zone_safehouse_interior_upper_bedroom_2", "zone_safehouse_interior_lower", "zone_safehouse_interior_upper", "zone_safehouse_exterior" ] )
    {
        if ( zone_manager::function_427ae6b3bc10b5ac( player.origin, zone_name ) )
        {
            player.b_in_safehouse = 1;
            return true;
        }
    }
    
    player.b_in_safehouse = undefined;
    return false;
}

// Namespace zm_sat_scarab_rb
// Params 1
// Checksum 0x58c1b645, Offset: 0x1d30
// Size: 0x159, Type: bool
function function_89f7c15f453225c1( var_8af4bb0185feb88 )
{
    foreach ( var_4cdafb4532dd9de4 in [ undefined, [ "zone_sw_temple_entrance", "zone_sw_temple_mainhall", "zone_sw_temple_sideroom_landing" ], [ "zone_nw_temple_entrance", "zone_nw_temple_interior_steps" ], [ "zone_ne_temple_exterior_steps", "zone_ne_temple_courtyard", "zone_ne_temple_westwing_exterior", "zone_ne_temple_eastwing_exterior" ], [ "zone_se_temple_entrance", "zone_se_temple_finalroom", "zone_se_temple_mainhall_north", "zone_se_temple_mainhall_south" ] ][ var_8af4bb0185feb88 ] )
    {
        zone_struct = zone_manager::get_zone_struct( var_4cdafb4532dd9de4 );
        navmesh_zone = zone_manager::function_ac62281be3d43322( self.origin );
        
        if ( navmesh_zone && navmesh_zone === zone_struct.zone_name )
        {
            return true;
        }
        
        if ( zone_manager::is_touching_zone( var_4cdafb4532dd9de4 ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_sat_scarab_rb
// Params 1, eflags: 0x4
// Checksum 0xb261c36a, Offset: 0x1e92
// Size: 0xaa, Type: bool
function private function_541c8f3425dc3b12( var_8af4bb0185feb88 )
{
    var_91bed5636f5f050d = getnoentvolumearray( "tmp_lock_barrier_" + var_8af4bb0185feb88, #targetname );
    
    foreach ( volume in var_91bed5636f5f050d )
    {
        if ( ispointinvolume( self.origin, volume ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_sat_scarab_rb
// Params 1, eflags: 0x4
// Checksum 0x60ab530f, Offset: 0x1f45
// Size: 0x56
function private function_6dd3acc93fbb515e( params )
{
    for ( var_8af4bb0185feb88 = 1; var_8af4bb0185feb88 < 5 ; var_8af4bb0185feb88++ )
    {
        e_doors = getent( "tmp_ld_barrier_" + var_8af4bb0185feb88, #targetname );
        
        if ( e_doors )
        {
            e_doors hidefromplayer( self, 1 );
        }
    }
}

// Namespace zm_sat_scarab_rb
// Params 1, eflags: 0x4
// Checksum 0x47e1fcc6, Offset: 0x1fa3
// Size: 0x54
function private function_762dcb6d5df2da6b( params )
{
    for ( var_8af4bb0185feb88 = 1; var_8af4bb0185feb88 < 5 ; var_8af4bb0185feb88++ )
    {
        e_doors = getent( "tmp_ld_barrier_" + var_8af4bb0185feb88, #targetname );
        
        if ( e_doors )
        {
            e_doors showtoplayer( self );
        }
    }
}

// Namespace zm_sat_scarab_rb
// Params 1, eflags: 0x4
// Checksum 0x6bee539, Offset: 0x1fff
// Size: 0x6f
function private function_73d1a26d8a9a0ae6( var_50ab463b6be98fa4 = 1 )
{
    for ( var_8af4bb0185feb88 = 1; var_8af4bb0185feb88 < 5 ; var_8af4bb0185feb88++ )
    {
        e_doors = getent( "tmp_ld_barrier_" + var_8af4bb0185feb88, #targetname );
        
        if ( !e_doors )
        {
            continue;
        }
        
        if ( var_50ab463b6be98fa4 )
        {
            e_doors solid();
            continue;
        }
        
        e_doors notsolid();
    }
}

// Namespace zm_sat_scarab_rb
// Params 4
// Checksum 0x75c9d36a, Offset: 0x2076
// Size: 0x264
function function_dba55b5c7bdfb0ed( var_8af4bb0185feb88, var_5d21dae3d611ba0d, str_end_flag, var_b62df22c92ce3ebe )
{
    doors = getent( "tmp_ld_barrier_" + var_8af4bb0185feb88, #targetname );
    level thread function_8d6d797952f5d8b2( doors, var_8af4bb0185feb88, str_end_flag );
    
    while ( true )
    {
        if ( !self [[ var_5d21dae3d611ba0d ]]( var_8af4bb0185feb88 ) )
        {
            break;
        }
        
        foreach ( player in level.players )
        {
            if ( !isalive( player ) || player.sessionstate != "playing" )
            {
                continue;
            }
            
            if ( player function_541c8f3425dc3b12( var_8af4bb0185feb88 ) )
            {
                continue;
            }
            
            if ( player function_89f7c15f453225c1( var_8af4bb0185feb88 ) )
            {
                if ( !player.var_3fc50054381a3946 )
                {
                    if ( !doors.var_fd8e20f1180e8184 )
                    {
                        doors solid();
                        doors.var_fd8e20f1180e8184 = 1;
                    }
                    
                    if ( !isdefined( level.var_cd93870ee4d04f72 ) )
                    {
                        level.var_cd93870ee4d04f72 = [];
                    }
                    
                    level.var_cd93870ee4d04f72[ var_8af4bb0185feb88 ] = 1;
                    level function_3192b44907a83439( doors, var_8af4bb0185feb88, player, var_b62df22c92ce3ebe );
                }
                
                continue;
            }
            
            if ( player.var_3fc50054381a3946 == var_8af4bb0185feb88 )
            {
                level function_112e752b30f6c444( doors, var_8af4bb0185feb88, player, var_b62df22c92ce3ebe );
            }
        }
        
        wait 0.25;
    }
    
    if ( level.var_cd93870ee4d04f72[ var_8af4bb0185feb88 ] )
    {
        level.var_cd93870ee4d04f72[ var_8af4bb0185feb88 ] = undefined;
    }
    
    foreach ( player in level.players )
    {
        if ( !player.var_3fc50054381a3946 )
        {
            continue;
        }
        
        level function_112e752b30f6c444( doors, var_8af4bb0185feb88, player, var_b62df22c92ce3ebe );
    }
    
    if ( doors.var_fd8e20f1180e8184 )
    {
        doors notsolid();
        doors.var_fd8e20f1180e8184 = undefined;
    }
}

// Namespace zm_sat_scarab_rb
// Params 4, eflags: 0x4
// Checksum 0x66d88c8c, Offset: 0x22e2
// Size: 0x7c
function private function_112e752b30f6c444( doors, var_8af4bb0185feb88, player, var_b62df22c92ce3ebe )
{
    profilestart();
    
    if ( doors )
    {
        doors hidefromplayer( player, 1 );
    }
    
    deactivateworldevent( "we_sat_scarab_temple_blocker" + var_8af4bb0185feb88, 1, player );
    player.var_3fc50054381a3946 = undefined;
    player.doorbuy_disabled = 0;
    
    if ( var_b62df22c92ce3ebe )
    {
        player val::reset( "ld_zone_spawns_off" + var_8af4bb0185feb88, "round_spawning_ignore_player" );
    }
    
    profilestop();
}

// Namespace zm_sat_scarab_rb
// Params 4, eflags: 0x4
// Checksum 0xea16328e, Offset: 0x2366
// Size: 0x90
function private function_3192b44907a83439( doors, var_8af4bb0185feb88, player, var_b62df22c92ce3ebe )
{
    profilestart();
    
    if ( doors )
    {
        doors showtoplayer( player );
    }
    
    activateworldevent( "we_sat_scarab_temple_blocker" + var_8af4bb0185feb88, 1, player );
    doors playsound( #"hash_66ec797d3ac86c4e" );
    player.var_3fc50054381a3946 = var_8af4bb0185feb88;
    player.doorbuy_disabled = 1;
    
    if ( var_b62df22c92ce3ebe )
    {
        player val::set( "ld_zone_spawns_off" + var_8af4bb0185feb88, "round_spawning_ignore_player", 1 );
    }
    
    profilestop();
}

// Namespace zm_sat_scarab_rb
// Params 3, eflags: 0x4
// Checksum 0xd91fe64f, Offset: 0x23fe
// Size: 0x14b
function private function_8d6d797952f5d8b2( e_barriers, var_8af4bb0185feb88, str_end_flag )
{
    a_triggers = getnoentvolumearray( "tmp_lock_barrier_" + var_8af4bb0185feb88, #targetname );
    
    foreach ( trigger in a_triggers )
    {
        trigger thread function_924357734b5a0fea( e_barriers, var_8af4bb0185feb88, str_end_flag );
    }
    
    level utility::flag_wait( str_end_flag );
    
    foreach ( player in level.players )
    {
        if ( !player.var_8dbac81d75843e47 )
        {
            continue;
        }
        
        player.var_8dbac81d75843e47[ var_8af4bb0185feb88 ] = undefined;
    }
}

// Namespace zm_sat_scarab_rb
// Params 3, eflags: 0x4
// Checksum 0x14e13697, Offset: 0x2551
// Size: 0xb9
function private function_924357734b5a0fea( e_barriers, var_8af4bb0185feb88, str_end_flag )
{
    level endon( str_end_flag );
    
    while ( self )
    {
        self waittill( #"trigger", ent );
        
        if ( isalive( ent ) && !ent.var_8dbac81d75843e47[ var_8af4bb0185feb88 ] && ent tagexists( "j_spine4" ) )
        {
            if ( isplayer( ent ) && ent.var_3fc50054381a3946 && ent.var_3fc50054381a3946 != var_8af4bb0185feb88 )
            {
                continue;
            }
            
            ent.var_8dbac81d75843e47[ var_8af4bb0185feb88 ] = 1;
            ent thread function_f99aa5144719ff33( e_barriers, var_8af4bb0185feb88, str_end_flag );
        }
    }
}

// Namespace zm_sat_scarab_rb
// Params 3, eflags: 0x4
// Checksum 0x78088574, Offset: 0x2612
// Size: 0x70
function private function_f99aa5144719ff33( e_barriers, var_8af4bb0185feb88, str_end_flag )
{
    self endon( #"death" );
    
    while ( !level utility::flag( str_end_flag ) )
    {
        wait 0.2;
        
        if ( !level utility::flag( str_end_flag ) && self istouching( e_barriers ) )
        {
            function_333a567043cb115c( e_barriers, var_8af4bb0185feb88, str_end_flag );
            self.var_8dbac81d75843e47[ var_8af4bb0185feb88 ] = undefined;
            return;
        }
    }
}

// Namespace zm_sat_scarab_rb
// Params 3, eflags: 0x4
// Checksum 0x5c8c8d42, Offset: 0x268a
// Size: 0x125
function private function_333a567043cb115c( e_barriers, var_8af4bb0185feb88, str_end_flag )
{
    do
    {
        waitframe();
    }
    while ( !level utility::flag( str_end_flag ) && self istouching( e_barriers ) );
    
    if ( self.aicategory == "elite" )
    {
        fx_id = level._effect[ #"hash_5b5db66e0adb4b38" ];
    }
    else
    {
        fx_id = level._effect[ #"hash_5b258c3fd26f55c4" ];
    }
    
    foreach ( player in level.players )
    {
        if ( player.var_3fc50054381a3946 == var_8af4bb0185feb88 && player != self )
        {
            playfxontagforclients( fx_id, self, "j_spine4", player );
            player playsoundtoplayer( "evt_zm_dissolve_death_dissolve", player, self );
        }
    }
}

// Namespace zm_sat_scarab_rb
// Params 0, eflags: 0x4
// Checksum 0xc9a0a47e, Offset: 0x27b7
// Size: 0xf5
function private cleanup_active_elites()
{
    zombies = getaiarray( zm_utility::get_zombie_team() );
    
    foreach ( zombie in zombies )
    {
        waitframe();
        
        if ( !isalive( zombie ) )
        {
            continue;
        }
        
        if ( zombie.aicategory != "elite" )
        {
            continue;
        }
        
        if ( zombie.subclass == "zombie_loom" || zombie.subclass == "zombie_abom" )
        {
            zombie utility::callsharedfunc( #"zombie", #"hash_6c2d9080e508d382", 1 );
            zombie ai::function_dd7b3233e5b07718( 1 );
        }
    }
}

// Namespace zm_sat_scarab_rb
// Params 0
// Checksum 0x557280cd, Offset: 0x28b4
// Size: 0x42, Type: bool
function function_391057f2a7d79035()
{
    var_b5aef5806a9f74c2 = function_64977c0d702cc59d();
    var_8d885b4aed0bef01 = zm_utility::get_round_number();
    b_high_round = var_8d885b4aed0bef01 >= 100;
    
    if ( var_b5aef5806a9f74c2 )
    {
        if ( !b_high_round )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace zm_sat_scarab_rb
// Params 0, eflags: 0x4
// Checksum 0x2b58937b, Offset: 0x28ff
// Size: 0x11b
function private watch_player_zones()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        wait 0.5;
        
        if ( !level.players.size )
        {
            continue;
        }
        
        var_b5aef5806a9f74c2 = function_64977c0d702cc59d();
        var_8d885b4aed0bef01 = zm_utility::get_round_number();
        b_high_round = var_8d885b4aed0bef01 >= 100;
        
        if ( var_b5aef5806a9f74c2 && !b_high_round )
        {
            cleanup_active_elites();
            continue;
        }
        
        if ( b_high_round )
        {
            foreach ( zone_name in [ "zone_safehouse_interior_upper_bedroom_1", "zone_safehouse_interior_upper_bedroom_2", "zone_safehouse_interior_lower", "zone_safehouse_interior_upper", "zone_safehouse_exterior" ] )
            {
                zone_spawner::function_f990c5bb03b55b2f( "zombie_loom", zone_name );
            }
            
            return;
        }
    }
}

// Namespace zm_sat_scarab_rb
// Params 0
// Checksum 0xef793346, Offset: 0x2a22
// Size: 0xd6, Type: bool
function function_2e2efdce3be6826b()
{
    level endon( #"death" );
    self endon( #"death" );
    
    if ( !self.origin )
    {
        return false;
    }
    
    foreach ( zone_name in [ "zone_safehouse_interior_upper_bedroom_1", "zone_safehouse_interior_upper_bedroom_2", "zone_safehouse_interior_lower", "zone_safehouse_interior_upper", "zone_safehouse_exterior" ] )
    {
        if ( zone_manager::function_427ae6b3bc10b5ac( self.origin, zone_name ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_sat_scarab_rb
// Params 1
// Checksum 0x5fc96c5, Offset: 0x2b01
// Size: 0x48
function function_95af7a773f7c57d1( zone_name )
{
    if ( !zone_name )
    {
        return 0;
    }
    
    return arraycontains( [ "zone_safehouse_interior_upper_bedroom_1", "zone_safehouse_interior_upper_bedroom_2", "zone_safehouse_interior_lower", "zone_safehouse_interior_upper", "zone_safehouse_exterior" ], zone_name );
}

// Namespace zm_sat_scarab_rb
// Params 1, eflags: 0x4
// Checksum 0xcefc9184, Offset: 0x2b52
// Size: 0x13
function private on_special_round_start( params )
{
    function_2a311bb411c253bc();
}

// Namespace zm_sat_scarab_rb
// Params 1, eflags: 0x4
// Checksum 0x395fcd4, Offset: 0x2b6d
// Size: 0x13
function private on_special_round_end( params )
{
    function_8c76b7030e848cf6();
}

// Namespace zm_sat_scarab_rb
// Params 1
// Checksum 0x21f3bff4, Offset: 0x2b88
// Size: 0xf2
function function_2a311bb411c253bc( b_skip_sun = 0 )
{
    level utility::flag_set( "its_raining" );
    function_9ddca84ef638a1d3();
    
    if ( !b_skip_sun && zm_round_spawning::is_special_round( zm_utility::get_round_number() ) )
    {
        zm_sat_scarab_lighting::function_2925eaea9ad5e8e5();
    }
    else if ( !b_skip_sun )
    {
        if ( !level utility::flag( "sst_made_nice_all" ) )
        {
            zm_sat_scarab_lighting::function_2925eaea9ad5e8e5();
        }
        else
        {
            zm_sat_scarab_lighting::function_99b7bfd228b00ff6();
        }
    }
    
    foreach ( player in level.players )
    {
        player function_7b12e1e25549d6e4();
    }
    
    activateworldevent( "we_vfx_zm_sat_scarab_special_round_rain" );
}

// Namespace zm_sat_scarab_rb
// Params 1
// Checksum 0x71c2e07b, Offset: 0x2c82
// Size: 0x122
function function_8c76b7030e848cf6( b_skip_sun = 0 )
{
    setglobalsoundcontext( "zm_scarab_rain", "", 1 );
    
    if ( !b_skip_sun && level utility::flag( "sst_made_nice_all" ) && !level utility::flag( "scarab_boss_fight_start" ) )
    {
        zm_sat_scarab_lighting::function_99b7bfd228b00ff6();
    }
    
    if ( level utility::flag( "sst_made_nice_all" ) && !level utility::flag( "enter_boss_fight_go" ) )
    {
        return;
    }
    
    level utility::flag_clear( "its_raining" );
    deactivateworldevent( "we_vfx_zm_sat_scarab_special_round_rain" );
    
    if ( !b_skip_sun && !level utility::flag( "sst_made_nice_all" ) )
    {
        zm_sat_scarab_lighting::function_9266f93608a1ec63();
    }
    
    foreach ( player in level.players )
    {
        player function_f4ab1277de839732();
    }
}

// Namespace zm_sat_scarab_rb
// Params 0
// Checksum 0x6e74e17f, Offset: 0x2dac
// Size: 0x36
function function_9ddca84ef638a1d3()
{
    if ( level utility::flag( "pretty_rain_active" ) )
    {
        setglobalsoundcontext( "zm_scarab_rain", "active_blessing", 1 );
        return;
    }
    
    setglobalsoundcontext( "zm_scarab_rain", "active", 1 );
}

// Namespace zm_sat_scarab_rb
// Params 1
// Checksum 0x25d85ee0, Offset: 0x2dea
// Size: 0xac
function function_25385c89de250b55( params )
{
    self endon( #"disconnect" );
    self endon( #"hash_347b41546632b85a" );
    
    if ( level utility::flag( "its_raining" ) )
    {
        function_f4ab1277de839732();
    }
    
    while ( !self.mutantinjectiontransformed )
    {
        waitframe();
    }
    
    waitframe();
    
    if ( level utility::flag( "its_raining" ) )
    {
        function_7b12e1e25549d6e4();
    }
    
    self waittill( #"mutantinjection_end" );
    
    if ( level utility::flag( "its_raining" ) )
    {
        function_f4ab1277de839732();
    }
    
    while ( self.mutantinjectiontransformed )
    {
        waitframe();
    }
    
    waitframe();
    
    if ( level utility::flag( "its_raining" ) )
    {
        function_7b12e1e25549d6e4();
    }
}

// Namespace zm_sat_scarab_rb
// Params 1
// Checksum 0x65138d70, Offset: 0x2e9e
// Size: 0x41
function function_272ebe68c945c463( var_1eaee829cd308d03 )
{
    self endon( #"disconnect" );
    
    if ( level utility::flag( "its_raining" ) )
    {
        self notify( #"hash_347b41546632b85a" );
        function_f4ab1277de839732();
        function_7b12e1e25549d6e4();
    }
}

// Namespace zm_sat_scarab_rb
// Params 0
// Checksum 0xafb8a9af, Offset: 0x2ee7
// Size: 0x5e
function function_7b12e1e25549d6e4()
{
    if ( utility::ent_flag( "WW_PLAYER_IN_A_P_SPACE" ) || self.var_ecdde94b952193a8 )
    {
        return;
    }
    
    if ( level utility::flag( "sst_made_nice_all" ) )
    {
        self setscriptablepartstate( "scarab_rain", "on_pretty", 0 );
    }
    else
    {
        self setscriptablepartstate( "scarab_rain", "on", 0 );
    }
    
    utility::ent_flag_set( "has_rain_fx" );
}

// Namespace zm_sat_scarab_rb
// Params 0
// Checksum 0x4a5dda2e, Offset: 0x2f4d
// Size: 0x2d
function function_f4ab1277de839732()
{
    if ( utility::ent_flag( "has_rain_fx" ) )
    {
        self setscriptablepartstate( "scarab_rain", "off", 0 );
        utility::ent_flag_clear( "has_rain_fx" );
    }
}

// Namespace zm_sat_scarab_rb
// Params 1
// Checksum 0x260a15cb, Offset: 0x2f82
// Size: 0x92
function on_game_ended( params )
{
    if ( !level.default_dvar )
    {
        return;
    }
    
    foreach ( dvar, value in level.default_dvar )
    {
        setdvar( dvar, value );
    }
}

// Namespace zm_sat_scarab_rb
// Params 1
// Checksum 0x31391b8a, Offset: 0x301c
// Size: 0xba
function function_702c650fe42c7f2a( params )
{
    trap_attacker = params.einflictor;
    
    if ( !isdefined( trap_attacker ) || trap_attacker.targetname != "trap_attacker" || trap_attacker.var_fcda7168a743663a != "stone_titan_trap" || !isdefined( trap_attacker.activator ) )
    {
        return;
    }
    
    player = trap_attacker.activator;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    player utility::delaythread( 1, &namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01, #"hash_69d4cca16aea06e4", #"bc_flavor_player_positive" );
    level callback::remove( "on_zombie_ai_killed", &function_702c650fe42c7f2a );
}

// Namespace zm_sat_scarab_rb
// Params 1
// Checksum 0xafc20d3c, Offset: 0x30de
// Size: 0xbd
function function_fe190410f2fa2802( params )
{
    is_grapple_kill = isdefined( params.objweapon ) && issubstr( params.objweapon.basename, "sat_grappling_hook_zm" );
    
    if ( !is_grapple_kill )
    {
        return;
    }
    
    if ( !isdefined( params.eattacker ) || !isplayer( params.eattacker ) || !isdefined( params.eattacker namespace_c0b4f2882c9d100f::function_470ff6ad4f437db1() ) )
    {
        return;
    }
    
    params.eattacker utility::delaythread( 1, &namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01, #"hash_fcc11b9cafd0af94" );
    level callback::remove( "on_zombie_ai_killed", &function_fe190410f2fa2802 );
}

/#

    // Namespace zm_sat_scarab_rb
    // Params 0
    // Checksum 0x9586e327, Offset: 0x31a3
    // Size: 0x44, Type: dev
    function setup_map_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x37>", "<dev string:x3f>", &function_2a311bb411c253bc );
        devgui::add_devgui_func( "<dev string:x4a>", "<dev string:x53>", &function_8c76b7030e848cf6 );
        devgui::function_77df7fe7dd273e10();
    }

#/
