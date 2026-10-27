// script_55b30772fa27258  (hash_055b30772fa27258.gscc) (size: 26140 Bytes / 0x661c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9c42c48b (2621621387)
// size ...... 26140 (0x661c)
// includes .. 19  (offset: 0x6060)
// strings ... 85  (offset: 0x60f8)
// dev strs .. 0   (offset: 0x661c)
// exports ... 51  (offset: 0x3fa4)
// cseg ...... 0x6a6 + 0x38fe (0x3fa4)
// imports ... 198 (offset: 0x479c)
// animtree1 . 0   (offset: 0x661c)
// animtree2 . 0   (offset: 0x661c)
#using script_16ea1b94f0f381b3;
#using script_60cd1c57e94be8d7;
#using script_636bd827a012af12;
#using script_66878054d141dbc0;
#using script_6b10011ac07f7291;
#using scripts\common\scene;
#using scripts\common\snd\snd;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\coop;
#using scripts\mp\gametypes\ob;
#using scripts\mp\interaction;
#using scripts\mp\laststand;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_audio;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_vo;
#using scripts\mp\ob\systems\ob_item_select;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\snd\snd_ob;

#namespace namespace_4759598db99787a0;

// Namespace namespace_4759598db99787a0
// Params 0
// Checksum 0x846c1f53, Offset: 0x6c4
// Size: 0x91
function function_45df75d7cdcb6f3d()
{
    bases = getentarray( "mech_base", "script_noteworthy" );
    
    foreach ( base in bases )
    {
        base hide();
        base notsolid();
    }
}

// Namespace namespace_4759598db99787a0
// Params 2
// Checksum 0x55078487, Offset: 0x75d
// Size: 0xc8
function handle_mech_base( var_1aa87fdc5abd09cb, linktoent )
{
    base_bits = getentarray( var_1aa87fdc5abd09cb.target, "targetname" );
    
    foreach ( bit in base_bits )
    {
        bit show();
        bit solid();
        bit linkto( linktoent );
    }
    
    self waittill( #"death" );
    utility::array_delete( base_bits );
}

// Namespace namespace_4759598db99787a0
// Params 2
// Checksum 0xd4728109, Offset: 0x82d
// Size: 0x1b8
function get_hellstorm_spawn_pos( var_cbaab2ed6edf8fc7, forwardvector )
{
    player = self;
    spawncenterpos = ( 0, 0, 0 );
    
    if ( isdefined( level.mechs[ 0 ] ) )
    {
        spawncenterpos = level.mechs[ 0 ].origin;
    }
    else
    {
        guys = getaiarray();
        
        if ( guys.size == 0 )
        {
            spawncenterpos = player.origin + anglestoforward( player.angles ) * 512;
        }
        else
        {
            foreach ( guy in guys )
            {
                spawncenterpos += guy.origin;
            }
            
            spawncenterpos /= guys.size;
        }
    }
    
    forwardvector = vectornormalize2( spawncenterpos - player.origin );
    heightent = namespace_9d8e359c3b1041e5::getkillstreakairstrikeheightentsharedfunc();
    heightoffset = isdefined( heightent ) ? heightent.origin[ 2 ] + 7000 : 10000;
    missileoffset = spawncenterpos + ( 0, 0, heightoffset );
    var_cbaab2ed6edf8fc7 += 3000;
    startpos = missileoffset - forwardvector * var_cbaab2ed6edf8fc7;
    targetpos = spawncenterpos + ( 0, 0, int( heightoffset * 0.5 ) );
    return [ startpos, targetpos ];
}

// Namespace namespace_4759598db99787a0
// Params 0
// Checksum 0xdbccbdc7, Offset: 0x9ee
// Size: 0x1a2
function preplaced_care_packages()
{
    case_struct = utility::getstruct( "ability_struct_boss", "targetname" );
    
    if ( isdefined( case_struct ) )
    {
        thread ob_item_select::function_95f9ecc2af4693f6( case_struct.origin, "super_active_camo", "super_survival_life_drain", #"default" );
    }
    
    utility::registersharedfunc( #"hellstorm_missile", #"getcustomstartandtargetposition", &get_hellstorm_spawn_pos );
    
    if ( !utility::issharedfuncdefined( #"dawg", #"hash_70fa1fdad51f3de7" ) )
    {
        utility::registersharedfunc( #"dawg", #"hash_70fa1fdad51f3de7", &post_spawn_dawg );
    }
    
    level thread function_43b3df9f8d922932();
    locs = utility::getstructarray( "preplaced_care_package", "targetname" );
    i = 0;
    
    if ( locs.size > 0 )
    {
        foreach ( loc in locs )
        {
            owner = level.players[ i ];
            crate = ob_story_mission_utils::function_53ca684fc4aa8af3( owner, loc.origin, %"hash_1f9d4339f18de3bd", 1, 1, 0, 1 );
            crate hudoutlineenable( "outline_depth_purple" );
            i++;
            
            if ( i >= level.players.size )
            {
                i = 0;
            }
        }
    }
}

// Namespace namespace_4759598db99787a0
// Params 0
// Checksum 0xbbb7974e, Offset: 0xb98
// Size: 0x152
function function_e001ffa85988a1d()
{
    self.dmg_pct = [];
    self.dmg_pct[ "hellstorm" ] = [ 0, "ALL" ];
    self.dmg_pct[ "valkyrie" ] = [ 0.5, "MOD_EXPLOSIVE" ];
    self.dmg_pct[ "_la_" ] = [ 0.25, "ALL" ];
    self.dmg_pc[ "warmachine" ] = [ 0.125, "MOD_GRENADE" ];
    self.dmg_pct[ "c4" ] = [ 0.15, "MOD_EXPLOSIVE" ];
    self.dmg_pct[ "default_exp" ] = [ [ 0.5, "MOD_SPECIAL_KILL" ], [ 0.125, "MOD_EXPLOSIVE" ], [ 0.125, "MOD_GRENADE" ], [ 0.1, "MOD_GRENADE_SPLASH" ], [ 0.125, "MOD_PROJECTILE" ], [ 0.1, "MOD_PROJECTILE_SPLASH" ] ];
}

// Namespace namespace_4759598db99787a0
// Params 1
// Checksum 0x9830a16a, Offset: 0xcf2
// Size: 0x404
function function_3dd28a8806ca671c( player )
{
    dawg_chance = 0.2;
    self_revive_chance = 0.15;
    var_2524163f2901595b = 0.2;
    ar_chance = 0.15;
    var_24a1cba3b3b582f2 = 0.5;
    killstreaks = [ %"hash_60f1f213ae016f4d", %"hash_2b306e9e970d1ee", %"hash_60f1f213ae016f4d", %"hash_2b306e9e970d1ee", %"hash_1f9d4339f18de3bd" ];
    grenades = [ [ %"hash_408896eb553a943", %"hash_408896eb553a943", %"hash_408896eb553a943" ], [ %"itemspawnentry:ob_sat_item_semtex", %"itemspawnentry:ob_sat_item_semtex", %"itemspawnentry:ob_sat_item_semtex" ], [ %"hash_73a788088dd890a9", %"hash_73a788088dd890a9", %"hash_73a788088dd890a9" ], [ %"hash_5b1b1d795bff9ea4", %"hash_5b1b1d795bff9ea4", %"hash_5b1b1d795bff9ea4" ] ];
    bullet_weapons = [ [ %"hash_118b43ac86066420" ], [ %"hash_31db596db2877bef" ], [ %"hash_7c295908634509a0" ], [ %"hash_76bc8d3110cf0ac0" ], [ %"hash_1fd2164334010e2e" ] ];
    i = randomint( grenades.size );
    
    do
    {
        crate_spawns = grenades[ i ];
        i = i == grenades.size - 1 ? 0 : i + 1;
    }
    while ( crate_spawns[ 0 ] == level.var_aa57605ac9ef3be2 );
    
    var_3b9083fbf404d968 = 0;
    
    foreach ( weap in player.primaryweapons )
    {
        if ( issubstr( weap.basename, "_ar_" ) || issubstr( weap.basename, "_ar_" ) || issubstr( weap.basename, "_dm_" ) || issubstr( weap.basename, "_sm_" ) || issubstr( weap.basename, "_lm_" ) )
        {
            var_3b9083fbf404d968 = 1;
            break;
        }
    }
    
    chance = var_3b9083fbf404d968 == 1 ? ar_chance : var_24a1cba3b3b582f2;
    
    if ( randomfloat( 1 ) < chance )
    {
        crate_spawns = utility::array_random( bullet_weapons );
    }
    
    high_need = level.players.size == 1 && player laststand::function_7072b516e6cffb7c() <= 0;
    chance = high_need ? var_2524163f2901595b : self_revive_chance;
    
    if ( randomfloat( 1 ) < chance )
    {
        crate_spawns = [ %"hash_35298bd2d2aff71f" ];
    }
    
    if ( level.players.size == 1 )
    {
        if ( randomfloat( 1 ) < dawg_chance )
        {
            crate_spawns = [ %"hash_39b0b8cd58bae2a0" ];
        }
    }
    
    i = randomint( killstreaks.size );
    
    do
    {
        crate_spawns[ crate_spawns.size ] = killstreaks[ i ];
        i = i == killstreaks.size - 1 ? 0 : i + 1;
    }
    while ( crate_spawns[ crate_spawns.size ] == level.last_spawned_weapon );
    
    level.var_aa57605ac9ef3be2 = crate_spawns[ 0 ];
    level.last_spawned_weapon = crate_spawns[ crate_spawns.size ];
    return crate_spawns;
}

// Namespace namespace_4759598db99787a0
// Params 1
// Checksum 0xee01f293, Offset: 0x10ff
// Size: 0x37c
function drop_supply_crate( crates_wanted )
{
    if ( !isdefined( level.var_e933362795125403 ) )
    {
        level.var_e933362795125403 = [];
    }
    
    if ( !isdefined( level.boss_crates ) )
    {
        level.boss_crates = [];
    }
    
    crates_left = [];
    
    foreach ( crate in level.boss_crates )
    {
        if ( isdefined( crate ) )
        {
            crates_left[ crates_left.size ] = crate;
        }
    }
    
    level.boss_crates = crates_left;
    var_364f19f9d42dce27 = crates_wanted;
    var_4b0ae0b3bf4d7f48 = 3;
    
    if ( level.players.size > 2 )
    {
        var_4b0ae0b3bf4d7f48 = 4;
    }
    
    if ( !isdefined( var_364f19f9d42dce27 ) )
    {
        var_364f19f9d42dce27 = var_4b0ae0b3bf4d7f48 - level.boss_crates.size;
    }
    
    locs = utility::getstructarray( "boss_supply_drop", "targetname" );
    
    if ( level.players.size > 1 )
    {
        locs = arraycombine( locs, utility::getstructarray( "boss_supply_drop_MP", "targetname" ) );
    }
    
    if ( locs.size > 0 )
    {
        owner_idx = 0;
        
        for ( i = 0; i < var_364f19f9d42dce27 ; i++ )
        {
            if ( owner_idx >= level.players.size )
            {
                owner_idx = 0;
            }
            
            owner = level.players[ owner_idx ];
            var_f1d9ad602eff4890 = randomint( locs.size );
            var_4b5633bb09f45692 = var_f1d9ad602eff4890;
            var_8343f78d74b92f97 = undefined;
            
            do
            {
                loc = locs[ var_f1d9ad602eff4890 ];
                var_57cd06008bb5f7f7 = 1;
                
                foreach ( var_e264babd83487310 in level.var_e933362795125403 )
                {
                    if ( loc != var_e264babd83487310 )
                    {
                        var_8343f78d74b92f97 = loc;
                    }
                    
                    if ( loc == var_e264babd83487310 || distance2dsquared( loc.origin, var_e264babd83487310.origin ) <= 1000000 )
                    {
                        var_57cd06008bb5f7f7 = 0;
                        break;
                    }
                }
                
                if ( !var_57cd06008bb5f7f7 )
                {
                    var_f1d9ad602eff4890++;
                    
                    if ( var_f1d9ad602eff4890 >= locs.size )
                    {
                        var_f1d9ad602eff4890 = 0;
                    }
                }
                
                if ( var_f1d9ad602eff4890 == var_4b5633bb09f45692 )
                {
                    var_57cd06008bb5f7f7 = 1;
                    
                    if ( isdefined( var_8343f78d74b92f97 ) )
                    {
                        loc = var_8343f78d74b92f97;
                        continue;
                    }
                    
                    loc = locs[ var_4b5633bb09f45692 ];
                }
            }
            while ( !var_57cd06008bb5f7f7 && var_4b5633bb09f45692 != var_f1d9ad602eff4890 );
            
            level.var_e933362795125403 = arraycombine( level.var_e933362795125403, [ loc ] );
            position = loc.origin + ( 0, 0, 1000 );
            spawnpoint = position;
            crate = ob_story_mission_utils::function_53ca684fc4aa8af3( owner, spawnpoint, undefined, 1, 1, 0, 1, &function_3dd28a8806ca671c );
            level notify( #"supply_drop" );
            crate hudoutlineenable( "outline_depth_purple" );
            wait randomfloatrange( 2, 5 );
            crate thread function_9a40f18fadd2f5d0( loc );
            level.boss_crates[ level.boss_crates.size ] = crate;
            owner_idx++;
        }
    }
}

// Namespace namespace_4759598db99787a0
// Params 1
// Checksum 0x4a9c59a7, Offset: 0x1483
// Size: 0x3d
function function_9a40f18fadd2f5d0( crate_loc )
{
    self waittill( #"death" );
    level.var_e933362795125403 = arrayremove( level.var_e933362795125403, crate_loc );
    wait 60;
    drop_supply_crate( 1 );
}

// Namespace namespace_4759598db99787a0
// Params 1
// Checksum 0xb7d5a671, Offset: 0x14c8
// Size: 0x27
function unpause_minions( timer )
{
    level endon( #"pause_minions" );
    wait timer;
    utility::flag_clear( "pause_minions" );
}

// Namespace namespace_4759598db99787a0
// Params 2
// Checksum 0x1dd2365b, Offset: 0x14f7
// Size: 0x6a
function mech_death_func( activity, force_kill_flag )
{
    self waittill( #"death" );
    other_mech = self.other_mech;
    activity ob_story_mission_utils::objective_marker_clear( self.var_8029d4363972e15 );
    level notify( #"mech_death" );
    wait 10;
    
    if ( isalive( other_mech ) )
    {
        other_mech sat_libra_mech_turret::enable_mortar();
    }
}

// Namespace namespace_4759598db99787a0
// Params 2
// Checksum 0x66a736db, Offset: 0x1569
// Size: 0x5c
function function_d2c2b06ddeb71db5( requestid, userdata )
{
    if ( utility::flag( userdata ) || utility::flag( "pause_minions" ) || isdefined( level.mechs[ 0 ] ) && level.mechs[ 0 ] utility::ent_flag( "disabled" ) )
    {
        return 1;
    }
}

// Namespace namespace_4759598db99787a0
// Params 4
// Checksum 0x901a6112, Offset: 0x15cd
// Size: 0xbc
function function_e5fb51e234237279( angle_step, height_offset, rotate_time, end_flag )
{
    if ( isdefined( end_flag ) )
    {
        level endon( end_flag );
    }
    
    ease_time = rotate_time / 3;
    
    while ( !utility::flag( end_flag ) )
    {
        self rotateto( self.angles + angle_step, rotate_time, 0, 0 );
        
        if ( isdefined( height_offset ) )
        {
            self moveto( self.origin + height_offset, rotate_time, ease_time, ease_time );
        }
        
        wait rotate_time;
        self rotateto( self.angles + angle_step, rotate_time, 0, 0 );
        
        if ( isdefined( height_offset ) )
        {
            self moveto( self.origin - height_offset, rotate_time, ease_time, ease_time );
        }
        
        wait rotate_time;
    }
}

// Namespace namespace_4759598db99787a0
// Params 0
// Checksum 0xfc56550c, Offset: 0x1691
// Size: 0x8a
function temp_valkyrie_pickups()
{
    ents = getentarray( "temp_valkyrie_pickup", "targetname" );
    
    foreach ( ent in ents )
    {
        ent delete();
    }
}

// Namespace namespace_4759598db99787a0
// Params 0
// Checksum 0xa4bff4d9, Offset: 0x1723
// Size: 0x9
function debug_killstreak_cheats()
{
    temp_valkyrie_pickups();
}

// Namespace namespace_4759598db99787a0
// Params 5
// Checksum 0x566d80d9, Offset: 0x1734
// Size: 0xf1
function function_4108c0bf68d1800c( var_75d3f386e5049e75, var_a5d2c8c32ea3ac76, hint_text, var_b906b12f841fbf6 = 0, z_offset = 0 )
{
    if ( isent( var_75d3f386e5049e75 ) || isstruct( var_75d3f386e5049e75 ) )
    {
        struct = var_75d3f386e5049e75;
    }
    else
    {
        struct = utility::getstruct( var_75d3f386e5049e75, "targetname" );
    }
    
    offset = ( 0, 0, z_offset );
    interact = interaction::register_interact( struct.origin + offset, 64, &killstreak_interact, hint_text );
    interact setusableenabled( 1 );
    interact setuseholdduration( "duration_medium" );
    interact setuserange( 48 );
    interact.var_a5d2c8c32ea3ac76 = var_a5d2c8c32ea3ac76;
    interact.var_b906b12f841fbf6 = var_b906b12f841fbf6;
    interact.ent = struct;
}

// Namespace namespace_4759598db99787a0
// Params 1
// Checksum 0x1936e74a, Offset: 0x182d
// Size: 0x4a
function killstreak_interact( player )
{
    self makeunusable();
    player killstreaks::awardkillstreak( self.var_a5d2c8c32ea3ac76 );
    
    if ( self.var_b906b12f841fbf6 )
    {
        self.ent delete();
        return;
    }
    
    wait 3;
    self makeusable();
}

// Namespace namespace_4759598db99787a0
// Params 8
// Checksum 0x8af6ea6b, Offset: 0x187f
// Size: 0x36e
function function_f70ed84fe274b1b6( start_pos, base, activity, complete_flag, difficulty, var_51255efc04786ca0, var_927bf72ba354f366, swap_model )
{
    self endon( #"disabled" );
    var_5aef8dd3d94f48e1 = 0.9;
    
    if ( isdefined( base ) )
    {
        base hide();
    }
    
    mech = self;
    mech.base = base;
    mech.ignoreall = 1;
    mech function_e001ffa85988a1d();
    
    if ( level.players.size > 2 )
    {
        mech.mortar_delay = 3;
    }
    
    thread mp_sat_ob_libra_vo::function_67e8df158fe9ce29();
    function_f98eda081cedaeff();
    mech val::set( "mech", "death", 0 );
    mech sat_libra_mech_turret::function_dcdb69dc09717b57( 1 );
    mech thread function_b54604fbe86a0ef9( activity, complete_flag, var_51255efc04786ca0, swap_model );
    thread function_ee4e51185e3ec85c();
    mech thread sat_libra_mech_turret::showhealthbar();
    mech sat_libra_mech_turret::set_health_threshold_notify( var_5aef8dd3d94f48e1, "stop_spin" );
    mech sat_libra_mech_turret::mech_invulnerable( 1 );
    mech function_4b819102971da534();
    mech sat_libra_mech_turret::mech_invulnerable( 0 );
    mech notify( #"landed" );
    level notify( #"new_mech_started" );
    thread mp_sat_ob_libra_vo::function_f1436a95780d3552();
    spin_speeds = [ 1, 2, 3 ];
    
    /#
        if ( getdvarint( @"hash_5d83c5e65867f90e" ) )
        {
            mech thread sat_libra_mech_turret::mech_disabled();
            wait 0.1;
            level notify( #"hash_42bf2389a88d055f" );
        }
    #/
    
    if ( !getdvarint( @"hash_5d83c5e65867f90e" ) )
    {
        mech thread sat_libra_mech_turret::repulsoron();
        first_spin = 360;
        
        /#
            if ( getdvarint( @"hash_996b1afb6b81eeb1", 0 ) )
            {
                first_spin = undefined;
            }
        #/
        
        can_lock_on = level.players.size > 1;
        waitframe();
        mech thread sat_libra_mech_turret::spinattack( min( spin_speeds[ difficulty ] * 3, 4 ), first_spin, can_lock_on );
        mech libra_audio::mech_init();
        
        if ( mech.health / mech.maxhealth > var_5aef8dd3d94f48e1 )
        {
            utility::waittill_any_timeout( 10, "spin_complete", "stop_spin" );
        }
        
        mech notify( #"hash_5588a9fdca62f361" );
        mech sat_libra_mech_turret::mech_invulnerable( 1 );
        mech sat_libra_mech_turret::set_health_threshold_notify( 0.5, "next_stage" );
        new_start_pos = function_30dac490ca1c11f8();
        mech function_a6c278e91eb2eac( new_start_pos );
        mech thread function_ad270acf70cb66b9();
        mech sat_libra_mech_turret::mech_invulnerable( 0 );
        level notify( #"hash_42bf2389a88d055f" );
        
        if ( level.players.size > 2 )
        {
            mech utility::delaythread( 10, &sat_libra_mech_turret::enable_mortar );
        }
        
        mech waittill( #"next_stage" );
        mech sat_libra_mech_turret::mech_invulnerable( 1 );
        mech sat_libra_mech_turret::set_health_threshold_notify( undefined, undefined );
        return_pos = mech.origin;
        mech function_4b819102971da534();
        level notify( #"mech_in_middle" );
        mech sat_libra_mech_turret::mech_invulnerable( 0 );
        can_lock_on = level.players.size > 1;
        mech thread sat_libra_mech_turret::spinattack( spin_speeds[ difficulty ], undefined, can_lock_on );
        mech thread libra_audio::mech_beam();
        mech utility::delaythread( 5, &sat_libra_mech_turret::enable_mortar );
        pct = 1;
    }
}

// Namespace namespace_4759598db99787a0
// Params 4
// Checksum 0xcf84bf22, Offset: 0x1bf5
// Size: 0x295
function function_b54604fbe86a0ef9( activity, complete_flag, var_51255efc04786ca0, swap_model )
{
    mech = self;
    
    if ( isdefined( var_51255efc04786ca0 ) )
    {
        var_51255efc04786ca0 thread scene::pre_stream( undefined, undefined, -1, var_51255efc04786ca0.script_noteworthy );
    }
    
    mech waittill( #"disabled" );
    mech thread libra_audio::mech_disabled();
    level notify( #"hash_7e2e909f4802e5e9" );
    utility::flag_clear( "mech_rotating" );
    mech sat_libra_mech_turret::repulsoroff();
    use_flag = complete_flag + "_use";
    use_pos = mech gettagorigin( "tag_barrel" );
    finisher_ent = utility::spawn_script_origin( use_pos );
    finisher_ent linkto( mech, "tag_barrel", ( 0, 0, 16 ), ( 0, 0, 0 ) );
    objidpoolmanager::update_objective_onentity( mech.var_8029d4363972e15, finisher_ent );
    objidpoolmanager::update_objective_setzoffset( mech.var_8029d4363972e15, 16 );
    level.var_6fe05155beb36355++;
    ob_story_mission_utils::function_315d79883d962ba7( level.var_6fe05155beb36355, 3 );
    mech.interact = interaction::register_interact( finisher_ent, 200, &finish_mech, &"sat_ob_story_missions/interact_commandeer", undefined, undefined, undefined, "HINT_BUTTON" );
    mech.interact sethintdisplayrange( 400 );
    mech.interact sethintdisplayfov( 360 );
    mech.interact setusefov( 60 );
    level notify( #"finish_mech" );
    level waittill( #"finished_mech" );
    utility::flag_set( use_flag );
    
    if ( isdefined( var_51255efc04786ca0 ) )
    {
        mech sat_libra_mech_turret::mech_die();
        ob_story_mission_utils::function_f20a9fe6c594f5b3( 1 );
        utility::array_call( level.floaters, &hide );
        level thread snd_ob::function_70013396bb42f6cc( level.players, "scene_sat_cin_libra_boss_phase_trans_01" );
        level coop::combat_cleanup( 0, 0 );
        var_51255efc04786ca0 scene::play( undefined, undefined, var_51255efc04786ca0.script_noteworthy );
        level thread snd_ob::function_52bc8194809997e8( level.players, "scene_sat_cin_libra_boss_phase_trans_01" );
        ob_story_mission_utils::function_f20a9fe6c594f5b3( 0 );
        
        if ( isdefined( swap_model ) )
        {
            model = getent( "mech_control_room_destruction", "targetname" );
            
            if ( isdefined( model ) )
            {
                model setmodel( swap_model );
            }
        }
        
        utility::array_call( level.floaters, &show );
    }
    else
    {
        mech thread utility::delaythread( 10, &sat_libra_mech_turret::mech_die );
    }
    
    utility::flag_set( complete_flag );
    finisher_ent delete();
}

// Namespace namespace_4759598db99787a0
// Params 1
// Checksum 0xb9de394c, Offset: 0x1e92
// Size: 0x18
function finish_mech( player )
{
    level notify( #"finished_mech" );
}

// Namespace namespace_4759598db99787a0
// Params 0
// Checksum 0x4c7c71f3, Offset: 0x1eb2
// Size: 0x73
function function_4b819102971da534()
{
    self notify( #"jump_to_center" );
    thread libra_audio::function_4b819102971da534();
    self.var_e59e24fbb46d7d5e = 1;
    utility::flag_clear( "mech_rotating" );
    mechspot = utility::getstruct( "mech_center", "targetname" );
    self setgoalpos( self.origin );
    sat_libra_mech_turret::function_3cc8731d810f2b1a( mechspot.origin );
    self.var_e59e24fbb46d7d5e = 0;
}

// Namespace namespace_4759598db99787a0
// Params 1
// Checksum 0x746451c5, Offset: 0x1f2d
// Size: 0x91
function function_a6c278e91eb2eac( var_67454c388e4d006a )
{
    targ_origin = var_67454c388e4d006a.origin;
    
    if ( self.var_e59e24fbb46d7d5e )
    {
        return;
    }
    
    self.var_e59e24fbb46d7d5e = 1;
    thread libra_audio::function_a6c278e91eb2eac();
    utility::flag_clear( "mech_rotating" );
    self notify( #"stop_walking" );
    self setgoalpos( self.origin );
    sat_libra_mech_turret::function_be370ee8d86e6772( targ_origin );
    utility::flag_set( "mech_rotating" );
    self.var_e59e24fbb46d7d5e = 0;
    thread function_e86547dfffa718d1( var_67454c388e4d006a );
}

// Namespace namespace_4759598db99787a0
// Params 2
// Checksum 0x6d2b04f2, Offset: 0x1fc6
// Size: 0x11d
function function_e86547dfffa718d1( start_struct, direction )
{
    self notify( #"hash_355c1c5d3183722b" );
    self endon( #"hash_355c1c5d3183722b" );
    self endon( #"stop_walking" );
    self endon( #"death" );
    self endon( #"jump_to_center" );
    target_player = self.mechtarget;
    
    if ( !isdefined( target_player ) )
    {
        [ target_player ] = sortbydistance( level.players, self.origin );
    }
    
    if ( !isdefined( direction ) )
    {
        ccw = function_2cdb8dc94cb3cf27( target_player );
        self.var_2666ca801f908f54 = ccw;
        direction = ccw;
    }
    
    if ( !isdefined( start_struct ) )
    {
        var_15c271c632374380 = vectornormalize( target_player.origin - self.origin );
        start_struct = function_d072262753c68c4e( var_15c271c632374380 );
    }
    
    path = function_2cdf7d05d7d53bd6( start_struct, direction );
    self setgoalpath( path );
    self waittill( #"goal" );
    thread function_e86547dfffa718d1();
}

// Namespace namespace_4759598db99787a0
// Params 1
// Checksum 0x9c06e941, Offset: 0x20eb
// Size: 0xca, Type: bool
function function_2cdb8dc94cb3cf27( target_player )
{
    center = utility::getstruct( "mech_center", "targetname" );
    
    if ( isdefined( target_player ) && isdefined( target_player.origin ) )
    {
        targ_vec = vectornormalize( target_player.origin - self.origin );
        center_vec = vectornormalize( center.origin - self.origin );
        center_vec = ( center_vec[ 0 ], center_vec[ 1 ], 0 );
        var_4fdd7403f3db291 = vectortoangles( center_vec );
        right_vec = anglestoright( var_4fdd7403f3db291 );
        player_to_right = vectordot( right_vec, targ_vec );
        
        if ( player_to_right > 0 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_4759598db99787a0
// Params 2
// Checksum 0x2c08f712, Offset: 0x21be
// Size: 0x94
function function_2cdf7d05d7d53bd6( start_node, counter_clockwise = 1 )
{
    path = [ start_node ];
    
    for ( next_node = utility::getstruct( start_node.target, "targetname" ); next_node != start_node && path.size < 16 ; next_node = utility::getstruct( next_node.target, "targetname" ) )
    {
        path[ path.size ] = next_node;
    }
    
    if ( !counter_clockwise )
    {
        path = arrayreverse( path );
    }
    
    return path;
}

// Namespace namespace_4759598db99787a0
// Params 2
// Checksum 0xa86ad6ce, Offset: 0x225b
// Size: 0xd5
function function_f0b83a2a1383da24( center_org, end_flag )
{
    utility::flag_wait( "mech_rotating" );
    
    while ( !utility::flag( end_flag ) )
    {
        center_org thread function_e5fb51e234237279( ( 0, level.rotate_dir * 90, 0 ), ( 0, 0, 120 ), 60, "stop_mech_rotation" );
        level utility::waittill_any( "mech_rotating", "change_directions" );
        center_org moveto( center_org.origin, 0.1 );
        center_org rotateto( center_org.angles, 0.1 );
        
        if ( !utility::flag( "mech_rotating" ) )
        {
            utility::flag_set( "stop_mech_rotation" );
            utility::flag_wait( "mech_rotating" );
            utility::flag_clear( "stop_mech_rotation" );
        }
        
        wait 0.1;
    }
}

// Namespace namespace_4759598db99787a0
// Params 0
// Checksum 0x46d31519, Offset: 0x2338
// Size: 0xba
function init_destructible_cover()
{
    ents = getentarray( "dst_hull_front_panel", "script_noteworthy" );
    ents = arraycombine( getentarray( "dst_hull_back_panel", "script_noteworthy" ), ents );
    
    foreach ( ent in ents )
    {
        ent.health = 500;
        ent setcandamage( 1 );
        ent thread function_5cf7cdf07986a3a8();
    }
}

// Namespace namespace_4759598db99787a0
// Params 0
// Checksum 0x10409388, Offset: 0x23fa
// Size: 0x13a
function function_5cf7cdf07986a3a8()
{
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, damagetype, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        
        if ( damagetype == "MOD_EXPLOSIVE" || damagetype == "MOD_PROJECTILE" || damagetype == "MOD_PROJECTILE_SPLASH" || damagetype == "MOD_GRENADE_SPLASH" )
        {
            self.health -= damage;
        }
        
        if ( self.health <= 0 )
        {
            var_4e150d63f7211cdc = utility::getstruct( self.target, "targetname" );
            playfx( level._effect[ "boss_panel_destruction" ], var_4e150d63f7211cdc.origin );
            self delete();
        }
    }
}

// Namespace namespace_4759598db99787a0
// Params 0
// Checksum 0xc892960a, Offset: 0x253c
// Size: 0x37c
function function_ad270acf70cb66b9()
{
    self notify( #"hash_810766fe06fc0973" );
    self endon( #"hash_810766fe06fc0973" );
    self endon( #"death" );
    self endon( #"jump_to_center" );
    far_dist = squared( 2000 );
    buffer_time = utility::function_4b74c15943231980( 10 );
    var_3c1a6cc7fedd92e8 = utility::function_4b74c15943231980( 10 );
    in_front_dot = cos( 22 );
    
    if ( !isdefined( level.rotate_dir ) )
    {
        level.rotate_dir = 1;
    }
    
    if ( level.mech_jump_spots.size < 1 )
    {
        return;
    }
    
    jumptime = undefined;
    var_1f572417ab57178a = gettime();
    
    while ( true )
    {
        var_1454decc673539de = undefined;
        curtime = gettime();
        
        if ( isdefined( self.mechtarget ) && curtime >= var_1f572417ab57178a )
        {
            if ( distance2dsquared( self.mechtarget.origin, self.origin ) > squared( 1000 ) )
            {
                center = utility::getstruct( "mech_center", "targetname" );
                targ_vec = vectornormalize( self.mechtarget.origin - self.origin );
                center_vec = center.origin - self.origin;
                center_vec = ( center_vec[ 0 ], center_vec[ 1 ], 0 );
                center_vec = vectornormalize( center_vec );
                var_4fdd7403f3db291 = vectortoangles( center_vec );
                targ_vec = vectornormalize( self.mechtarget.origin - self.origin );
                facing_player_fwd = vectordot( center_vec, targ_vec );
                
                if ( facing_player_fwd < in_front_dot )
                {
                    right_vec = anglestoright( var_4fdd7403f3db291 );
                    player_to_right = vectordot( right_vec, targ_vec );
                    
                    if ( player_to_right > 0 )
                    {
                        var_2666ca801f908f54 = 1;
                        var_15c271c632374380 = right_vec;
                    }
                    else
                    {
                        var_2666ca801f908f54 = 0;
                        var_15c271c632374380 = anglestoleft( var_4fdd7403f3db291 );
                    }
                    
                    if ( self.var_2666ca801f908f54 != var_2666ca801f908f54 )
                    {
                        self.var_2666ca801f908f54 = var_2666ca801f908f54;
                        level notify( #"change_directions" );
                        var_1f572417ab57178a = curtime + var_3c1a6cc7fedd92e8;
                        start_node = function_d072262753c68c4e( var_15c271c632374380 );
                        thread function_e86547dfffa718d1( start_node, var_2666ca801f908f54 );
                    }
                }
            }
        }
        
        foreach ( player in level.players )
        {
            if ( isalive( player ) )
            {
                if ( player utility::isusingremote() )
                {
                    waitframe();
                    
                    if ( isdefined( jumptime ) )
                    {
                        jumptime = curtime + buffer_time;
                    }
                    
                    continue;
                }
                
                dist2 = distance2dsquared( self.origin, player.origin );
                
                if ( dist2 < far_dist )
                {
                    var_1454decc673539de = player;
                    break;
                }
            }
        }
        
        if ( !isdefined( var_1454decc673539de ) )
        {
            if ( !isdefined( jumptime ) )
            {
                jumptime = curtime + buffer_time;
            }
            
            if ( curtime >= jumptime )
            {
                var_862b4b715b2cf41 = function_30dac490ca1c11f8();
                function_a6c278e91eb2eac( var_862b4b715b2cf41 );
                jumptime = undefined;
                var_1f572417ab57178a = curtime + var_3c1a6cc7fedd92e8;
            }
        }
        else
        {
            jumptime = undefined;
        }
        
        wait 0.2;
    }
}

// Namespace namespace_4759598db99787a0
// Params 1
// Checksum 0x24e3dc8e, Offset: 0x28c0
// Size: 0xdc
function function_d072262753c68c4e( preferred_vec )
{
    nodes = utility::getstructarray( "mech_path", "script_noteworthy" );
    nodes = sortbydistance( nodes, self.origin );
    
    foreach ( node in nodes )
    {
        node_vec = vectornormalize( node.origin - self.origin );
        facing = vectordot( node_vec, preferred_vec );
        
        if ( facing )
        {
            return node;
        }
    }
}

// Namespace namespace_4759598db99787a0
// Params 1
// Checksum 0x34212c54, Offset: 0x29a5
// Size: 0x2cc
function function_30dac490ca1c11f8( mech_number )
{
    if ( !isdefined( level.mech_jump_spots ) )
    {
        level.mech_jump_spots = [];
        structs = utility::getstructarray( "mech_path", "script_noteworthy" );
        
        foreach ( struct in structs )
        {
            if ( struct.script_parameters == "mech_jump_spot" )
            {
                level.mech_jump_spots[ level.mech_jump_spots.size ] = struct;
            }
        }
    }
    
    level.mech_jump_spots = function_628bac9faa9d1e86( level.mech_jump_spots, self.origin, 1 );
    var_862b4b715b2cf41 = undefined;
    closest_spot = undefined;
    var_4aab1759def536c8 = undefined;
    
    foreach ( spot in level.mech_jump_spots )
    {
        alive_players = function_46f9072493651dc9( level.players );
        alive_players = function_628bac9faa9d1e86( alive_players, spot.origin );
        var_e0af82a51db11137 = distance2dsquared( spot.origin, self.origin );
        
        foreach ( player in alive_players )
        {
            var_2a5260d58ba8f19c = distance2dsquared( spot.origin, player.origin );
            
            if ( var_e0af82a51db11137 > squared( 1000 ) && var_2a5260d58ba8f19c <= squared( 1000 ) )
            {
                var_862b4b715b2cf41 = spot;
                break;
            }
            
            if ( var_e0af82a51db11137 > squared( 1000 ) && ( !isdefined( var_4aab1759def536c8 ) || var_2a5260d58ba8f19c < var_4aab1759def536c8 ) )
            {
                closest_spot = spot;
                var_4aab1759def536c8 = var_2a5260d58ba8f19c;
            }
        }
        
        if ( isdefined( var_862b4b715b2cf41 ) )
        {
            break;
        }
    }
    
    if ( !isdefined( var_862b4b715b2cf41 ) )
    {
        if ( isdefined( closest_spot ) )
        {
            var_862b4b715b2cf41 = closest_spot;
        }
        else
        {
            var_862b4b715b2cf41 = level.mech_jump_spots[ 0 ];
        }
    }
    
    return var_862b4b715b2cf41;
}

// Namespace namespace_4759598db99787a0
// Params 0
// Checksum 0xd6287459, Offset: 0x2c7a
// Size: 0x133
function function_ee4e51185e3ec85c()
{
    level notify( #"boss_remote_watcher" );
    level endon( #"boss_remote_watcher" );
    
    while ( true )
    {
        foreach ( idx, player in level.players )
        {
            if ( player utility::isusingremote() )
            {
                player val::set( "boss_remote", "ignoreme", 1 );
                
                if ( level.players.size == 1 )
                {
                    player.var_174539c022ebeb2a = "player" + string( idx );
                    createnavrepulsor( player.var_174539c022ebeb2a, -1, player, 100, 1, "all" );
                }
                
                continue;
            }
            
            player val::reset_all( "boss_remote" );
            
            if ( isdefined( player.var_174539c022ebeb2a ) )
            {
                destroynavrepulsor( player.var_174539c022ebeb2a );
                player.var_174539c022ebeb2a = undefined;
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_4759598db99787a0
// Params 0
// Checksum 0x828284bd, Offset: 0x2db5
// Size: 0xd2
function function_12cfdd9aff763010()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, damagetype, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        
        if ( !isplayer( attacker ) )
        {
            damage *= 10;
            self dodamage( damage, origin, attacker, inflictor, damagetype, objweapon, point );
        }
    }
}

// Namespace namespace_4759598db99787a0
// Params 1
// Checksum 0xfe7cf292, Offset: 0x2e8f
// Size: 0x9a
function arena_teleport_trigger( targetname = "boss_teleport_trig" )
{
    level endon( #"hash_75fca2b07f009805" );
    level.boss_teleport_spots = utility::getstructarray( "boss_teleport_spot", "targetname" );
    trig = getent( targetname, #targetname );
    
    if ( isdefined( trig ) )
    {
        while ( true )
        {
            trig waittill( #"trigger", player );
            
            if ( isalive( player ) && isplayer( player ) )
            {
                player thread player_teleport_boss_battle();
            }
        }
    }
}

// Namespace namespace_4759598db99787a0
// Params 0
// Checksum 0xf7100266, Offset: 0x2f31
// Size: 0x6d
function player_teleport_boss_battle()
{
    self notify( #"hash_ffcf6132a9557bd7" );
    self endon( #"hash_ffcf6132a9557bd7" );
    self endon( #"death_or_disconnect" );
    player = self;
    level thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "heavy", 1, undefined, player );
    coop::teleport_player( player, utility::array_random( level.boss_teleport_spots ), 1 );
    player playsoundtoplayer( "evt_libra_boss_escape_plr_reset", player );
}

// Namespace namespace_4759598db99787a0
// Params 0
// Checksum 0xf7b5e74a, Offset: 0x2fa6
// Size: 0xb4
function function_9fa25b5bd728adde()
{
    wait 5;
    mech = self;
    
    if ( !isdefined( level.mech_obj_ent ) )
    {
        var_f06c3d8143b76949 = mech gettagorigin( "tag_turret_animate" );
        
        /#
            sphere( var_f06c3d8143b76949, 200, ( 1, 0, 0 ), 0, 5000 );
        #/
        
        mech.var_5af7b2900d5f8d01 = utility::spawn_script_origin( var_f06c3d8143b76949 );
        mech.var_5af7b2900d5f8d01 linkto( mech, "tag_turret_animate", ( 0, 0, 36 ), ( 0, 0, 0 ) );
        objidpoolmanager::update_objective_onentity( mech.var_8029d4363972e15, mech.var_5af7b2900d5f8d01 );
    }
}

// Namespace namespace_4759598db99787a0
// Params 2
// Checksum 0x5a447c79, Offset: 0x3062
// Size: 0x4d
function mech_obj_marker( entity, zoffset )
{
    obj_id = namespace_d7fa4530141146a5::function_de87bf7072515cd3( "sat_ob_objectivemarker_boss" );
    objidpoolmanager::update_objective_setzoffset( obj_id, zoffset );
    objidpoolmanager::objective_set_play_intro( obj_id, 1 );
    objidpoolmanager::update_objective_onentity( obj_id, entity );
    return obj_id;
}

// Namespace namespace_4759598db99787a0
// Params 0
// Checksum 0x6692b8d0, Offset: 0x30b8
// Size: 0x49
function function_f98eda081cedaeff()
{
    if ( isdefined( level.hellstorm_hack ) )
    {
        return;
    }
    
    level.hellstorm_hack = 1;
    level.hellstorm_dmg_radius = squared( 500 );
    utility::registersharedfunc( #"hellstorm_missile", #"explode", &function_7d91b8b94ce52d79 );
}

// Namespace namespace_4759598db99787a0
// Params 1
// Checksum 0x9840e2d7, Offset: 0x3109
// Size: 0xc5
function function_7d91b8b94ce52d79( var_b7b609abde6844aa )
{
    foreach ( mech in level.mechs )
    {
        if ( distancesquared( mech.origin, var_b7b609abde6844aa ) <= level.hellstorm_dmg_radius )
        {
            mech dodamage( mech.maxhealth * 0.5, var_b7b609abde6844aa, level.players[ 0 ], undefined, "MOD_SPECIAL_KILL" );
        }
    }
}

// Namespace namespace_4759598db99787a0
// Params 0, eflags: 0x4
// Checksum 0xe521e97, Offset: 0x31d6
// Size: 0xf
function private post_spawn_dawg()
{
    self function_78a8bbd6805e6296( "custom_default_off", 1 );
}

// Namespace namespace_4759598db99787a0
// Params 0, eflags: 0x4
// Checksum 0x2ed3018d, Offset: 0x31ed
// Size: 0x143
function private function_43b3df9f8d922932()
{
    if ( level.var_c6d8c0bfbbd2006b )
    {
        return;
    }
    
    volumes = getentarray( "bad_place_vol_dawg", "targetname" );
    
    foreach ( vol in volumes )
    {
        vol.var_f308f9c25228e209 = function_aafd9c2a00b86dba( vol, "custom_default_off" );
    }
    
    level.var_c6d8c0bfbbd2006b = 1;
    level utility::flag_wait( "stage3_done_use" );
    
    foreach ( vol in volumes )
    {
        if ( vol.var_f308f9c25228e209 )
        {
            destroynavobstacle( vol.var_f308f9c25228e209 );
            vol delete();
        }
    }
}

// Namespace namespace_4759598db99787a0
// Params 0
// Checksum 0x9772ca9b, Offset: 0x3338
// Size: 0x5b
function init_boss_ffs()
{
    level utility::flag_wait( "scriptables_ready" );
    ffs = utility::getstructarray( "boss_ff_base", "targetname" );
    utility::array_thread( ffs, &handle_boss_ff );
    utility::flag_wait( "show_ffs" );
    
    if ( !utility::flag( "skip_boss_ff_fx" ) )
    {
        thread mp_sat_ob_libra_vo::boss_forcefields_activate();
    }
}

// Namespace namespace_4759598db99787a0
// Params 0, eflags: 0x4
// Checksum 0x962fa751, Offset: 0x339b
// Size: 0x37f
function private handle_boss_ff()
{
    models = utility::getstructarray( self.target, "targetname" );
    parts = getentarray( self.target, "targetname" );
    
    foreach ( part in parts )
    {
        if ( part.script_noteworthy == "boss_ff_clip" )
        {
            part connectpaths();
        }
        
        part notsolid();
        part hide();
    }
    
    utility::flag_wait( "show_ffs" );
    
    if ( !utility::flag( "skip_boss_ff_fx" ) )
    {
        wait randomfloatrange( 0, 7 );
    }
    
    ff = undefined;
    
    foreach ( part in parts )
    {
        if ( part.script_noteworthy == "boss_ff" )
        {
            ff_clip = part;
            continue;
        }
        
        if ( part.script_noteworthy == "boss_ff_scriptable" )
        {
            continue;
        }
        
        if ( part.script_noteworthy == "boss_ff_clip" )
        {
            part show();
            part solid();
            part disconnectpaths();
            continue;
        }
        
        part thread do_spawn_fx();
        
        if ( !utility::flag( "skip_boss_ff_fx" ) )
        {
            wait 1;
        }
    }
    
    foreach ( struct in models )
    {
        part = spawn( "script_model", struct.origin );
        part.angles = struct.angles;
        part hide();
        part setmodel( struct.script_noteworthy );
        part thread do_spawn_fx();
        parts[ parts.size ] = part;
    }
    
    if ( !utility::flag( "skip_boss_ff_fx" ) )
    {
        wait randomfloatrange( 1.5, 2.5 );
    }
    
    if ( isdefined( ff_clip ) )
    {
        ff_clip show();
        ff_clip solid();
        ff_clip.var_dd51eb58519b3df = snd::play( "amb_force_field_lp", ff_clip.origin );
        thread snd::play( "amb_force_field_switch_on", ff_clip.origin );
    }
    
    ff = spawnscriptable( self.script_noteworthy, self.origin, self.angles );
    ff setscriptablepartstate( #"main", #"hash_c6fd06e2fbbc83ea" );
    utility::flag_wait( "stage3_done" );
    
    if ( isdefined( ff.var_dd51eb58519b3df ) )
    {
        snd::stop( ff.var_dd51eb58519b3df );
        ff.var_dd51eb58519b3df = undefined;
    }
    
    utility::array_delete( parts );
}

// Namespace namespace_4759598db99787a0
// Params 0
// Checksum 0xb57f0e64, Offset: 0x3722
// Size: 0x11e
function do_spawn_fx()
{
    final_pos = self.origin;
    fx_tag = undefined;
    
    if ( !utility::flag( "skip_boss_ff_fx" ) )
    {
        sprout_time = randomfloatrange( 0.2, 0.22 );
        fx_tag = spawn( "script_model", self.origin, 0, 1 );
        fx_tag.angles = vectortoangles( anglestoup( self.angles ) );
        fx_tag setmodel( "tag_origin" );
        waitframe();
        wait randomfloatrange( 0.2, 0.8 );
        playfxontag( utility::getfx( "vfx_sat_levels_mp_ob_libra_cradle_sphere_valve_release_1" ), fx_tag, "tag_origin" );
        wait 0.182564;
        self.origin -= anglestoup( self.angles ) * 112;
    }
    
    self show();
    self solid();
    
    if ( !utility::flag( "skip_boss_ff_fx" ) )
    {
        self moveto( final_pos, sprout_time );
        stopfxontag( utility::getfx( "vfx_sat_levels_mp_ob_libra_cradle_sphere_valve_release_1" ), fx_tag, "tag_origin" );
        wait 5;
        fx_tag delete();
    }
}

// Namespace namespace_4759598db99787a0
// Params 0
// Checksum 0x297fb5d6, Offset: 0x3848
// Size: 0x13a
function init_cradle_crates()
{
    level utility::flag_wait( "scriptables_ready" );
    spots = utility::getstructarray( "boss_cradle_crate_pos", "targetname" );
    
    if ( !isdefined( crates ) )
    {
        crates = [];
    }
    
    foreach ( spot in spots )
    {
        if ( !isdefined( spot.angles ) )
        {
            spot.angles = ( 0, 0, 0 );
        }
        
        crate = spawnscriptable( "sat_storage_lift_bot_crate", spot.origin, spot.angles );
        crate function_7653c765b6c7b815();
        crate setscriptablepartstate( #"cradle_shipment_crate", #"visible" );
        crates[ crates.size ] = crate;
    }
    
    utility::flag_wait( "enable_boss_cradle_crates" );
    thread mp_sat_ob_libra_vo::boss_cradle_bombs_explode();
    utility::array_thread( crates, &handle_cradle_crate );
}

// Namespace namespace_4759598db99787a0
// Params 0
// Checksum 0xfbd8ba53, Offset: 0x398a
// Size: 0xa9
function handle_cradle_crate()
{
    crate = self;
    wait randomfloatrange( 0.1, 5.9562 );
    crate setscriptablepartstate( #"cradle_shipment_crate", #"unusable_trap_sprung" );
    crate_org = crate.origin;
    snd::play( [ 0.1, "eqp_bomb_beep_mock_test_01", 0 ], crate_org );
    wait 2.5;
    playfx( utility::getfx( "boss_cradle_bomb_explode" ), crate.origin );
    snd::play( "exp_cradle_crate", crate_org );
    crate thread function_8eee4c197d16ef2c();
}

// Namespace namespace_4759598db99787a0
// Params 0
// Checksum 0xf3f65c49, Offset: 0x3a3b
// Size: 0xad
function function_8eee4c197d16ef2c()
{
    var_250c778d5d10419a = 165;
    crate = self;
    crate_org = crate.origin;
    playfx( utility::getfx( "boss_cradle_bomb_cloud" ), crate.origin - ( 0, 0, 4 ) );
    crate freescriptable();
    trigger = spawn( "trigger_radius", crate_org, 0, var_250c778d5d10419a, 120 );
    
    /#
    #/
    
    while ( true )
    {
        trigger waittill( #"trigger", player );
        thread futz_player( player );
    }
    
    trigger delete();
}

// Namespace namespace_4759598db99787a0
// Params 1
// Checksum 0x4869716d, Offset: 0x3af0
// Size: 0x6d
function futz_player( player )
{
    cradle_duration = 3;
    
    if ( !isdefined( player.var_fab69ddee1af6edf ) )
    {
        player.var_fab69ddee1af6edf = 1;
        cradled_players = [ player ];
        level thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "heavy", cradle_duration, undefined, cradled_players, undefined, undefined, 1 );
        wait cradle_duration;
        player.var_fab69ddee1af6edf = undefined;
    }
}

// Namespace namespace_4759598db99787a0
// Params 9
// Checksum 0x49678a50, Offset: 0x3b65
// Size: 0x2c0
function function_95ebb5b311234fc8( start_pos, base, activity, complete_flag, difficulty, var_51255efc04786ca0, var_927bf72ba354f366, swap_model, perimeter_mech )
{
    self endon( #"disabled" );
    var_5aef8dd3d94f48e1 = 0.9;
    
    if ( isdefined( base ) )
    {
        base hide();
    }
    
    mech = self;
    mech.base = base;
    mech.ignoreall = 1;
    mech function_e001ffa85988a1d();
    
    if ( level.players.size > 2 )
    {
        mech.mortar_delay = 3;
    }
    
    function_f98eda081cedaeff();
    mech val::set( "mech", "death", 0 );
    thread function_ee4e51185e3ec85c();
    mech thread sat_libra_mech_turret::showhealthbar();
    mech utility::ent_flag_set( "boss_bar_initialized" );
    mech function_4b819102971da534();
    mech notify( #"landed" );
    level notify( #"new_mech_started" );
    spin_speeds = [ 1, 2, 3 ];
    
    if ( !getdvarint( @"hash_5d83c5e65867f90e" ) )
    {
        mech thread sat_libra_mech_turret::repulsoron();
        first_spin = 360;
        
        /#
            if ( getdvarint( @"hash_996b1afb6b81eeb1", 0 ) )
            {
                first_spin = undefined;
            }
        #/
        
        can_lock_on = level.players.size > 1;
        
        if ( ob::nightmare() )
        {
            can_lock_on = 0;
        }
        
        waitframe();
        mech thread sat_libra_mech_turret::spinattack( min( spin_speeds[ difficulty ] * 3, 4 ), first_spin, can_lock_on );
        mech libra_audio::mech_init();
        
        if ( mech.health / mech.maxhealth > var_5aef8dd3d94f48e1 )
        {
            utility::waittill_any_timeout( 10, "spin_complete", "stop_spin" );
        }
        
        mech notify( #"hash_5588a9fdca62f361" );
        mech.mech_number = 2;
        
        if ( !mech.var_769b5f956f24d26b.disabled )
        {
            mech.var_769b5f956f24d26b.turreton = 1;
        }
        
        if ( !mech.var_cc68585d473df8c2.disabled )
        {
            mech.var_cc68585d473df8c2.turreton = 1;
        }
        
        mech.mortarenabled = mech.var_cbbaa03e3d35a64c;
        mech.var_cbbaa03e3d35a64c = undefined;
        mech thread sat_libra_mech_turret::rotatehead();
        mech sat_libra_mech_turret::enable_left_arm();
        mech sat_libra_mech_turret::enable_right_arm();
        mech utility::flag_set( "mech_rotating" );
    }
}

// Namespace namespace_4759598db99787a0
// Params 0
// Checksum 0xb6e31603, Offset: 0x3e2d
// Size: 0x13d
function function_9f96e43783063faa()
{
    mech = self;
    mech endon( #"death" );
    return_pos = mech.origin;
    mech function_4b819102971da534();
    level notify( #"mech_in_middle" );
    mech sat_libra_mech_turret::mech_invulnerable( 0 );
    mech thread sat_libra_mech_turret::repulsoron();
    mech thread sat_libra_mech_turret::spinattack( 3, undefined, 1 );
    mech thread libra_audio::mech_beam();
    utility::waittill_any_timeout( 10, "spin_complete", "stop_spin" );
    mech notify( #"hash_5588a9fdca62f361" );
    
    if ( !mech.var_769b5f956f24d26b.disabled )
    {
        mech.var_769b5f956f24d26b.turreton = 1;
    }
    
    if ( !mech.var_cc68585d473df8c2.disabled )
    {
        mech.var_cc68585d473df8c2.turreton = 1;
    }
    
    mech.mortarenabled = mech.var_cbbaa03e3d35a64c;
    mech.var_cbbaa03e3d35a64c = undefined;
    mech thread sat_libra_mech_turret::rotatehead();
    mech sat_libra_mech_turret::enable_left_arm();
    mech sat_libra_mech_turret::enable_right_arm();
    mech utility::flag_set( "mech_rotating" );
}

// Namespace namespace_4759598db99787a0
// Params 0
// Checksum 0x4edb2f0b, Offset: 0x3f72
// Size: 0x32
function function_249fb430a585902()
{
    mech = self;
    new_start_pos = function_30dac490ca1c11f8();
    mech function_a6c278e91eb2eac( new_start_pos );
    mech thread function_ad270acf70cb66b9();
}

