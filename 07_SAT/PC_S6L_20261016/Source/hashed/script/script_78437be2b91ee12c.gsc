// script_78437be2b91ee12c  (hash_78437be2b91ee12c.gscc) (size: 37911 Bytes / 0x9417 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6392654f (1670538575)
// size ...... 37911 (0x9417)
// includes .. 19  (offset: 0x8b5b)
// strings ... 95  (offset: 0x8bf3)
// dev strs .. 37  (offset: 0x91bf)
// exports ... 96  (offset: 0x6153)
// cseg ...... 0x80b + 0x5948 (0x6153)
// imports ... 207 (offset: 0x7053)
// animtree1 . 1   (offset: 0x93cb)
// animtree2 . 4   (offset: 0x93d7)
#using script_4197d8df5d4e11be;
#using scripts\common\anim;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\powerups;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\br\gametypes\br_moving_platforms_util;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\powerups\br_powerups;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\flags;
#using scripts\mp\loot\common_cache;
#using scripts\mp\magicbox;
#using scripts\mp\outofbounds;

#namespace namespace_b1e70b44ac1fcc2b;

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0, eflags: 0x1
// Checksum 0x4613fa43, Offset: 0x829
// Size: 0x2f
function autoexec main()
{
    if ( !getdvarint( @"hash_17c6562ad2dfb8f6", 0 ) )
    {
        cleanup();
        return;
    }
    
    /#
        level thread debug_init();
    #/
    
    level thread init();
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0, eflags: 0x4
// Checksum 0x627d3a2b, Offset: 0x860
// Size: 0x126
function private init()
{
    level endon( #"game_ended" );
    level.ghost_train = spawnstruct();
    level utility::flag_wait( "scriptables_ready" );
    calloutmarkerping::function_572853cf60de7300( "mp_saw_manticore_s6_ghost_train_engine", %"ping_location_go" );
    calloutmarkerping::function_572853cf60de7300( "mp_saw_manticore_s6_ghost_train_car_boxcar_closed", %"ping_location_go" );
    calloutmarkerping::function_572853cf60de7300( "mp_saw_manticore_s6_ghost_train_car_boxcar_open", %"ping_location_go" );
    calloutmarkerping::function_572853cf60de7300( "mp_saw_manticore_s6_ghost_train_car_flatbed", %"ping_location_go" );
    calloutmarkerping::function_572853cf60de7300( "mp_saw_manticore_s6_ghost_train_cover_1", %"ping_location_go" );
    calloutmarkerping::function_572853cf60de7300( "mp_saw_manticore_s6_ghost_train_cover_2", %"ping_location_go" );
    calloutmarkerping::function_572853cf60de7300( "mp_saw_manticore_s6_ghost_train_signal", %"ping_location_go" );
    calloutmarkerping::function_572853cf60de7300( "mp_saw_manticore_s6_ghost_train_switch", %"ping_location_go" );
    init_dvars();
    init_models();
    init_paths();
    ammobox_init();
    buystation_init();
    caches_init();
    horn_init();
    magicbox_init();
    switches_init();
    zombie_hand_init();
    level thread move_think();
    level thread path_manager();
}

#using_animtree( "manticore_s6_ghost_train" );

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0, eflags: 0x4
// Checksum 0x761bdfd6, Offset: 0x98e
// Size: 0x26f
function private init_dvars()
{
    level.ghost_train.anim_ent = spawn( "script_model", ( 0, 0, 0 ) );
    level.ghost_train.anim_ent setmodel( "manticore_s6_train_xcomp_base" );
    level.ghost_train.anim_ent useanimtree( #animtree );
    level.ghost_train.anim_ent.animname = "ghost_train";
    level.ghost_train.max_speed = getdvarfloat( @"hash_9bc2961ac9be837b", 0.5 );
    level.ghost_train.var_5950ad72c654d5c1 = getdvarfloat( @"hash_8e10a68e5c91ab30", 0.002 );
    level.ghost_train.decel_rate = getdvarfloat( @"hash_382c6d7478b062e3", 0.002 );
    level.ghost_train.var_c0dbe0ab09309c24 = getdvarint( @"hash_127ce7358761a7af", 2 );
    level.ghost_train.var_c0feeeab095702a6 = getdvarint( @"hash_1259d535873b3861", 4 );
    level.ghost_train.idle_timer = getdvarint( @"hash_7dadeec9c9fbdbd7", 50 );
    level.ghost_train.stop_distance_sq = squared( getdvarint( @"hash_356a181f97c2a87b", 300 ) );
    level.ghost_train.var_65433790e4c537b6 = getdvarfloat( @"hash_98ae5d277d935e47", 0.5 );
    level.ghost_train.var_2a286eb807a21cb6 = getdvarfloat( @"hash_50ae0b9e6b3a7d39", 1 );
    level.ghost_train.horn_starting_time = getdvarfloat( @"scr_ghost_train_horn_starting_time", 3 );
    stop_time = level.ghost_train.max_speed / level.ghost_train.decel_rate / 1 / level.framedurationseconds;
    var_89c8bf13c73e573f = getdvarfloat( @"hash_50e966d2c1ac13aa", 3 );
    level.ghost_train.var_d2a821c9c1c4a188 = stop_time - var_89c8bf13c73e573f;
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0, eflags: 0x4
// Checksum 0x6dfa0df, Offset: 0xc05
// Size: 0xa11
function private init_models()
{
    level.ghost_train.models = [];
    level.ghost_train.models[ level.ghost_train.models.size ] = getent( "ghost_engine", "script_noteworthy" );
    
    for ( i = 1; i < 8 ; i++ )
    {
        index = i;
        
        if ( index < 10 )
        {
            index = "0" + i;
        }
        
        level.ghost_train.models[ level.ghost_train.models.size ] = getent( "ghost_car_" + index, "script_noteworthy" );
    }
    
    for ( i = 0; i < level.ghost_train.models.size ; i++ )
    {
        if ( i >= 9 )
        {
            tag = "train_car_" + i + 1;
        }
        else
        {
            tag = "train_car_0" + i + 1;
        }
        
        if ( i == 0 )
        {
            scriptable = spawnscriptable( "mp_saw_manticore_s6_ghost_train_engine", level.ghost_train.models[ i ].origin );
        }
        else
        {
            switch ( level.ghost_train.models[ i ].model )
            {
                case #"hash_552093b43b2a51e3":
                    scriptable = spawnscriptable( "mp_saw_manticore_s6_ghost_train_car_boxcar_closed", level.ghost_train.models[ i ].origin );
                    break;
                case #"hash_3aa6f664794f0c63":
                    scriptable = spawnscriptable( "mp_saw_manticore_s6_ghost_train_car_boxcar_open", level.ghost_train.models[ i ].origin );
                    break;
                case #"hash_37cfb246944bc25":
                    scriptable = spawnscriptable( "mp_saw_manticore_s6_ghost_train_car_flatbed", level.ghost_train.models[ i ].origin );
                    break;
                default:
                    assertmsg( "<dev string:x24>" );
                    break;
            }
        }
        
        scriptable.angles = level.ghost_train.models[ i ].angles;
        scriptable scriptablesetparententity( level.ghost_train.models[ i ] );
        level.ghost_train.models[ i ].scriptable = scriptable;
        clip = getent( level.ghost_train.models[ i ].script_noteworthy + "_clip", "script_noteworthy" );
        clip linkto( level.ghost_train.models[ i ] );
        clip forcenetfieldhighlod( 1 );
        clip setmoverantilagged( 1 );
        clip setmoveroptimized( 1 );
        clip.var_87038cec80bd2c66 = 0;
        clip.override_unresolved_collision = &function_c9260241e1012979;
        clip.var_514172427acb20c1 = &function_a0329a8e4ab6a209;
        
        if ( level.ghost_train.models[ i ].model == "manticore_s6_train_flatbed_ghost" )
        {
            clip.var_5e10b6723398bb44 = 22;
        }
        else
        {
            clip.var_5e10b6723398bb44 = -50;
        }
        
        level.ghost_train.models[ i ].clip = clip;
        level.ghost_train.models[ i ].tag = tag;
        level.ghost_train.models[ i ] hide();
        
        /#
            level.ghost_train.models[ i ].debug_color = ( 1, 0, 0 );
        #/
    }
    
    lights = getentarray( "ghost_train_light", "targetname" );
    
    foreach ( light in lights )
    {
        light linkto( level.ghost_train.models[ 0 ], "tag_origin", light.origin - level.ghost_train.models[ 0 ].origin, light.angles - level.ghost_train.models[ 0 ].angles );
    }
    
    level.ghost_train.cover = [];
    cover = getent( "ghost_train_items_01", "script_noteworthy" );
    origin = cover.origin;
    angles = cover.angles;
    cover delete();
    cover = spawnscriptable( "mp_saw_manticore_s6_ghost_train_cover_1", origin );
    cover.angles = angles;
    car = function_b21056d585c710d( level.ghost_train.models, cover.origin );
    cover scriptablesetparententity( car, cover.origin - car.origin, cover.angles - car.angles );
    level.ghost_train.cover[ level.ghost_train.cover.size ] = cover;
    cover = getent( "ghost_train_items_02", "script_noteworthy" );
    origin = cover.origin;
    angles = cover.angles;
    cover delete();
    cover = spawnscriptable( "mp_saw_manticore_s6_ghost_train_cover_2", origin );
    cover.angles = angles;
    car = function_b21056d585c710d( level.ghost_train.models, cover.origin );
    cover scriptablesetparententity( car, cover.origin - car.origin, cover.angles - car.angles );
    level.ghost_train.cover[ level.ghost_train.cover.size ] = cover;
    cover = getent( "ghost_train_items_03", "script_noteworthy" );
    origin = cover.origin;
    angles = cover.angles;
    cover delete();
    cover = spawnscriptable( "mp_saw_manticore_s6_ghost_train_cover_1", origin );
    cover.angles = angles;
    car = function_b21056d585c710d( level.ghost_train.models, cover.origin );
    cover scriptablesetparententity( car, cover.origin - car.origin, cover.angles - car.angles );
    level.ghost_train.cover[ level.ghost_train.cover.size ] = cover;
    level.ghost_train.cover_clip = [];
    level.ghost_train.cover_clip[ level.ghost_train.cover_clip.size ] = getent( "ghost_car_03_items_clip", "script_noteworthy" );
    level.ghost_train.cover_clip[ level.ghost_train.cover_clip.size ] = getent( "ghost_car_04_items_clip", "script_noteworthy" );
    level.ghost_train.cover_clip[ level.ghost_train.cover_clip.size ] = getent( "ghost_car_06_items_clip", "script_noteworthy" );
    
    foreach ( clip in level.ghost_train.cover_clip )
    {
        clip forcenetfieldhighlod( 1 );
        clip setmoverantilagged( 1 );
        clip setmoveroptimized( 1 );
        car = function_b21056d585c710d( level.ghost_train.models, clip.origin );
        clip linkto( car );
        clip notsolid();
        clip.var_87038cec80bd2c66 = 0;
    }
    
    level.ghost_train.triggers = getentarray( "ghost_train_trigger", "targetname" );
    
    foreach ( trigger in level.ghost_train.triggers )
    {
        car = function_b21056d585c710d( level.ghost_train.models, trigger.origin );
        trigger enablelinkto();
        trigger linkto( car );
    }
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0, eflags: 0x4
// Checksum 0x6fd78928, Offset: 0x161e
// Size: 0xa8
function private function_591e959c2455b152()
{
    level.ghost_train.force_trigger_exit = undefined;
    
    foreach ( trigger in level.ghost_train.triggers )
    {
        trigger::makeenterexittrigger( trigger, &ghost_train_trigger_enter, &ghost_train_trigger_exit, undefined, undefined, undefined, undefined, 1 );
    }
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0, eflags: 0x4
// Checksum 0xff74a638, Offset: 0x16ce
// Size: 0x9d
function private function_39ff534792d4c1f7()
{
    level.ghost_train.force_trigger_exit = 1;
    
    foreach ( trigger in level.ghost_train.triggers )
    {
        trigger::cleanup_enter_exit_trigger( trigger, 1 );
    }
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 2, eflags: 0x4
// Checksum 0xa64fa818, Offset: 0x1773
// Size: 0xff
function private ghost_train_trigger_enter( ent, trigger )
{
    if ( !flags::gameflag( "br_ready_to_jump" ) )
    {
        return;
    }
    
    if ( ent.iszombie )
    {
        return;
    }
    
    if ( isplayer( ent ) && !ent player::isreallyalive() )
    {
        return;
    }
    
    if ( !isdefined( ent.in_ghost_train ) )
    {
        ent.in_ghost_train = 0;
    }
    
    ent.in_ghost_train++;
    
    if ( isplayer( ent ) )
    {
        ent function_a78466127e2418f5();
        return;
    }
    
    foreach ( player in vehicle_occupancy::get_all_occupants( ent ) )
    {
        player function_a78466127e2418f5();
    }
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 2, eflags: 0x4
// Checksum 0xaa6b67cc, Offset: 0x187a
// Size: 0xf3
function private ghost_train_trigger_exit( ent, trigger )
{
    if ( !flags::gameflag( "br_ready_to_jump" ) )
    {
        return;
    }
    
    if ( ent.iszombie )
    {
        return;
    }
    
    if ( isplayer( ent ) && !ent player::isreallyalive() )
    {
        return;
    }
    
    ent.in_ghost_train--;
    
    if ( !ent.in_ghost_train )
    {
        if ( isplayer( ent ) )
        {
            ent thread function_a22ce73c1440809c();
            return;
        }
        
        foreach ( player in vehicle_occupancy::get_all_occupants( ent ) )
        {
            player thread function_a22ce73c1440809c();
        }
    }
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0, eflags: 0x4
// Checksum 0x1e46745a, Offset: 0x1975
// Size: 0xdb
function private function_a78466127e2418f5()
{
    self.var_7d3a7700e8272b44 = 1;
    thread function_427388fd6bd54455();
    level notify( #"uav_update" );
    
    if ( self.ghost_train_trigger_powerup )
    {
        return;
    }
    
    ref = utility::array_random( [ "double_points", "loot_master", "zombie_legs", "zombie_vision" ] );
    source = spawnstruct();
    source.var_ab9d16e865163dda = "ghost_train_trigger";
    thread function_b6eaffda71fd9689();
    powerups::powerup_activate( ref, source );
    root = powerups::get_powerups_root();
    
    if ( root.ftue_enabled && !self.var_aba5734958a86143[ ref ] )
    {
        self.var_aba5734958a86143[ ref ] = 1;
        thread br_powerups::ftue_play( ref );
    }
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0, eflags: 0xc
// Checksum 0x2b627853, Offset: 0x1a58
// Size: 0x53
function private function_427388fd6bd54455()
{
    self notify( #"hash_b90975b915030f42" );
    self endon( #"hash_b90975b915030f42" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self waittill( #"death" );
    self.var_7d3a7700e8272b44 = 0;
    self.in_ghost_train = 0;
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0, eflags: 0x4
// Checksum 0xf99c3693, Offset: 0x1ab3
// Size: 0x3d
function private function_b6eaffda71fd9689()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self.ghost_train_trigger_powerup = 1;
    utility::waittill_any_timeout( 30, "death" );
    self.ghost_train_trigger_powerup = undefined;
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0, eflags: 0x4
// Checksum 0x7bc660cc, Offset: 0x1af8
// Size: 0x18
function private function_a22ce73c1440809c()
{
    self.var_7d3a7700e8272b44 = undefined;
    level notify( #"uav_update" );
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 2, eflags: 0x4
// Checksum 0x88c38507, Offset: 0x1b18
// Size: 0x3d
function private function_c9260241e1012979( player, ballowsuicide )
{
    player thread function_d3e69f3c60c2a8e0();
    player kill( self.origin, self.owner, self, "MOD_CRUSH" );
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 2, eflags: 0x4
// Checksum 0x3113e42e, Offset: 0x1b5d
// Size: 0x10a
function private function_a0329a8e4ab6a209( otherent, impulse )
{
    if ( !isdefined( level.ghost_train.physical_first_frame ) )
    {
        return;
    }
    
    self.dontspawnhusk = 1;
    data = spawnstruct();
    data.inflictor = otherent;
    data.objweapon = undefined;
    data.meansofdeath = "MOD_CRUSH";
    data.attacker = otherent.owner;
    
    foreach ( player in vehicle_occupancy::get_all_occupants( self ) )
    {
        player thread function_d3e69f3c60c2a8e0();
    }
    
    thread vehicle::explode( data, 1 );
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0, eflags: 0x4
// Checksum 0xbac4b77f, Offset: 0x1c6f
// Size: 0x22
function private function_d3e69f3c60c2a8e0()
{
    level endon( #"game_ended" );
    self waittill( #"death" );
    thread namespace_8feb0d461816c715::perform_jump_scare();
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0, eflags: 0x4
// Checksum 0x91055553, Offset: 0x1c99
// Size: 0x7e
function private init_paths()
{
    level.scr_anim[ "ghost_train" ][ "manticore_s6_train_rail_long_fwd" ] = %manticore_s6_train_rail_long_fwd;
    level.scr_anim[ "ghost_train" ][ "manticore_s6_train_rail_long_bckwd" ] = %manticore_s6_train_rail_long_bckwd;
    level.scr_anim[ "ghost_train" ][ "manticore_s6_train_rail_short_fwd" ] = %manticore_s6_train_rail_short_fwd;
    level.scr_anim[ "ghost_train" ][ "manticore_s6_train_rail_short_bckwd" ] = %manticore_s6_train_rail_short_bckwd;
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0, eflags: 0x4
// Checksum 0xfaef555b, Offset: 0x1d1f
// Size: 0x15f
function private move_think()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        foreach ( model in level.ghost_train.models )
        {
            if ( level.ghost_train.var_b4a2ac2812cf870e )
            {
                model.origin = level.ghost_train.anim_ent gettagorigin( model.tag );
            }
            else
            {
                model moveto( model.origin + 2 * ( level.ghost_train.anim_ent gettagorigin( model.tag ) - model.origin ), 2 * level.framedurationseconds );
            }
            
            model.angles = level.ghost_train.anim_ent gettagangles( model.tag );
        }
        
        wait level.framedurationseconds;
    }
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0, eflags: 0x4
// Checksum 0x21dff517, Offset: 0x1e86
// Size: 0x24d
function private path_manager()
{
    level endon( #"game_ended" );
    level.ghost_train.paths = [ "manticore_s6_train_rail_long_fwd", "manticore_s6_train_rail_long_bckwd", "manticore_s6_train_rail_short_fwd", "manticore_s6_train_rail_short_bckwd" ];
    path = utility::array_random( level.ghost_train.paths );
    
    while ( true )
    {
        while ( path == level.ghost_train.path )
        {
            path = utility::array_random( level.ghost_train.paths );
            waitframe();
        }
        
        level.ghost_train.path = path;
        
        /#
            if ( isdefined( level.ghost_train.debug_go_path ) )
            {
                level.ghost_train.path = level.ghost_train.debug_go_path;
                level.ghost_train.debug_go_path = undefined;
            }
        #/
        
        if ( issubstr( level.ghost_train.path, "_long_" ) )
        {
            level.ghost_train.var_feb75335101deb4f = level.ghost_train.stops_long_path;
            level.ghost_train.movement_modifier = level.ghost_train.var_2a286eb807a21cb6;
        }
        else
        {
            level.ghost_train.var_feb75335101deb4f = level.ghost_train.stops_short_path;
            level.ghost_train.movement_modifier = level.ghost_train.var_65433790e4c537b6;
        }
        
        function_a329ee0f1598f362();
        cooldown = randomintrange( level.ghost_train.var_c0dbe0ab09309c24, level.ghost_train.var_c0feeeab095702a6 );
        
        /#
            if ( isdefined( level.ghost_train.debug_go_path ) )
            {
                cooldown = level.framedurationseconds;
            }
        #/
        
        wait cooldown;
        level.ghost_train.var_b4a2ac2812cf870e = 1;
    }
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0, eflags: 0xc
// Checksum 0x6388a114, Offset: 0x20db
// Size: 0x1b8
function private function_a329ee0f1598f362()
{
    self notify( #"hash_e0e5842ac4cf8812" );
    self endon( #"hash_e0e5842ac4cf8812" );
    level endon( #"game_ended" );
    
    /#
        level endon( #"debug_go_path" );
    #/
    
    level notify( #"hash_fbd4161e4b0c10b5" );
    function_39ff534792d4c1f7();
    train_fx( "ghost" );
    ghost_state( 1 );
    anime = level.scr_anim[ "ghost_train" ][ level.ghost_train.path ];
    level.ghost_train.anim_ent thread animation::anim_single_solo( level.ghost_train.anim_ent, level.ghost_train.path );
    level.ghost_train.speed = level.ghost_train.max_speed * level.ghost_train.movement_modifier;
    level.ghost_train.anim_ent setanimrate( level.scr_anim[ "ghost_train" ][ level.ghost_train.path ], level.ghost_train.speed );
    wait 1;
    level.ghost_train.var_b4a2ac2812cf870e = 0;
    train_fx( "moving" );
    level thread function_d15aef54a43b3d15();
    level thread function_ef69fb1d0032fd9e();
    
    while ( level.ghost_train.anim_ent getanimtime( anime ) < 0.98 )
    {
        wait level.framedurationseconds;
    }
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0, eflags: 0x4
// Checksum 0x7577c4ed, Offset: 0x229b
// Size: 0xc5
function private function_d15aef54a43b3d15()
{
    i = 0;
    
    while ( i < level.ghost_train.models.size )
    {
        if ( !outofbounds::ispointinoutofbounds( level.ghost_train.models[ i ].origin ) )
        {
            level.ghost_train.models[ i ].scriptable setscriptablepartstate( "icon", "ghost" );
            
            /#
                level.ghost_train.models[ i ].debug_color = ( 0, 1, 0 );
            #/
            
            i++;
            continue;
        }
        
        waitframe();
    }
    
    level thread function_9bc1d4c9a547c41c();
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0, eflags: 0x4
// Checksum 0x56648893, Offset: 0x2368
// Size: 0xe3
function private function_9bc1d4c9a547c41c()
{
    i = 0;
    
    while ( i < level.ghost_train.models.size )
    {
        if ( outofbounds::ispointinoutofbounds( level.ghost_train.models[ i ].origin ) )
        {
            level.ghost_train.models[ i ].scriptable calloutmarkerping::function_608710c894185549();
            level.ghost_train.models[ i ].scriptable setscriptablepartstate( "icon", "hide" );
            
            /#
                level.ghost_train.models[ i ].debug_color = ( 1, 0, 0 );
            #/
            
            i++;
            continue;
        }
        
        waitframe();
    }
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0, eflags: 0x4
// Checksum 0xe9e28d50, Offset: 0x2453
// Size: 0x295
function private start()
{
    level endon( #"game_ended" );
    level notify( #"hash_fbd4161e4b0c10b5" );
    level endon( #"hash_fbd4161e4b0c10b5" );
    horn_starting();
    function_a4c865b88770031f();
    ghost_state();
    train_fx( "ghost" );
    wait 1.5;
    train_fx( "start" );
    waitframe();
    train_fx( "accel" );
    
    foreach ( model in level.ghost_train.models )
    {
        if ( isdefined( model.clip.navobstacle ) )
        {
            destroynavobstacle( model.clip.navobstacle );
            model.clip.navobstacle = undefined;
        }
    }
    
    while ( level.ghost_train.speed < level.ghost_train.max_speed * level.ghost_train.movement_modifier )
    {
        level.ghost_train.speed += level.ghost_train.var_5950ad72c654d5c1 * level.ghost_train.movement_modifier;
        
        if ( level.ghost_train.speed > level.ghost_train.max_speed * level.ghost_train.movement_modifier )
        {
            level.ghost_train.speed = level.ghost_train.max_speed * level.ghost_train.movement_modifier;
        }
        
        level.ghost_train.anim_ent setanimrate( level.scr_anim[ "ghost_train" ][ level.ghost_train.path ], level.ghost_train.speed );
        wait level.framedurationseconds;
    }
    
    train_fx( "moving" );
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0, eflags: 0x4
// Checksum 0xcc150639, Offset: 0x26f0
// Size: 0x27a
function private stop()
{
    level endon( #"game_ended" );
    level notify( #"hash_fbd4161e4b0c10b5" );
    level endon( #"hash_fbd4161e4b0c10b5" );
    level thread horn_stopping();
    
    foreach ( model in level.ghost_train.models )
    {
        model.clip.navobstacle = createnavobstaclebyent( model.clip );
    }
    
    train_fx( "decel" );
    
    while ( level.ghost_train.speed > 0 )
    {
        level.ghost_train.speed -= level.ghost_train.decel_rate * level.ghost_train.movement_modifier;
        
        if ( level.ghost_train.speed < 0 )
        {
            level.ghost_train.speed = 0;
        }
        
        level.ghost_train.anim_ent setanimrate( level.scr_anim[ "ghost_train" ][ level.ghost_train.path ], level.ghost_train.speed );
        wait level.framedurationseconds;
        
        foreach ( model in level.ghost_train.models )
        {
            updatenavobstaclebyent( model.clip );
        }
    }
    
    train_fx( "stop" );
    waitframe();
    physical_state();
    train_fx( "physical" );
    wait 1.5;
    train_fx( "idle" );
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0, eflags: 0x4
// Checksum 0xbeca58cc, Offset: 0x2972
// Size: 0x16
function private idle()
{
    wait level.ghost_train.idle_timer;
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 1, eflags: 0x4
// Checksum 0x861f3dd5, Offset: 0x2990
// Size: 0x123
function private train_fx( state )
{
    foreach ( model in level.ghost_train.models )
    {
        model.scriptable setscriptablepartstate( "fx", state );
    }
    
    foreach ( cover in level.ghost_train.cover )
    {
        cover setscriptablepartstate( "fx", state );
    }
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0, eflags: 0x4
// Checksum 0x8544872, Offset: 0x2abb
// Size: 0x2a4
function private function_ef69fb1d0032fd9e()
{
    level endon( #"game_ended" );
    level.ghost_train.var_feb75335101deb4f = function_628bac9faa9d1e86( level.ghost_train.var_feb75335101deb4f, level.ghost_train.models[ 0 ].origin );
    
    for ( i = 0; i < level.ghost_train.var_feb75335101deb4f.size ; i++ )
    {
        while ( true )
        {
            /#
                if ( getdvarint( @"hash_b3237bd1e6f7819f" ) )
                {
                    line( level.ghost_train.models[ 0 ].origin, level.ghost_train.var_feb75335101deb4f[ i ].origin, ( 1, 1, 1 ), 1, 0, 1 );
                }
            #/
            
            if ( distance2dsquared( level.ghost_train.models[ 0 ].origin, level.ghost_train.var_feb75335101deb4f[ i ].origin ) < level.ghost_train.stop_distance_sq )
            {
                if ( level.ghost_train.var_feb75335101deb4f[ i ].signal getscriptablepartstate( "light" ) == "red" )
                {
                    f_near = squared( 9000 );
                    s_near = undefined;
                    
                    foreach ( s in level.ghost_train.switches )
                    {
                        distance_sq = distance2dsquared( s.interact.origin, level.ghost_train.models[ 0 ].origin );
                        
                        if ( distance_sq < f_near )
                        {
                            f_near = distance_sq;
                            s_near = s;
                        }
                    }
                    
                    s_near.interact setscriptablepartstate( "interact", "unusable" );
                    stop();
                    idle();
                    s_near switch_toggle();
                    level thread start();
                }
                
                break;
            }
            
            waitframe();
        }
    }
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0
// Checksum 0xd1bccea1, Offset: 0x2d67
// Size: 0x2
function function_f3c8141c3939999f()
{
    
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0, eflags: 0x4
// Checksum 0x68e4ad7a, Offset: 0x2d71
// Size: 0xdd
function private physical_state()
{
    /#
        level.ghost_train.state = 1;
    #/
    
    level thread function_da5f3ec061e1425();
    
    foreach ( model in level.ghost_train.models )
    {
        model.clip solid();
        model.scriptable setscriptablepartstate( "icon", "physical" );
    }
    
    function_939ac151fb46a0eb();
    function_39ff534792d4c1f7();
    level thread function_14f648ce3af49a1d();
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0, eflags: 0x4
// Checksum 0x50641c07, Offset: 0x2e56
// Size: 0x79
function private function_14f648ce3af49a1d()
{
    level.ghost_train.models[ 0 ] function_1935e448f648cbb4( 630, 170, 0, 40 );
    
    for ( i = 1; i < level.ghost_train.models.size ; i++ )
    {
        level.ghost_train.models[ i ] function_1935e448f648cbb4( 600, 170, 0, 40 );
    }
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 4, eflags: 0x4
// Checksum 0x88e40ba0, Offset: 0x2ed7
// Size: 0x432
function private function_1935e448f648cbb4( length, width, forward_offset, up_offset )
{
    forward = anglestoforward( self.angles );
    right = anglestoright( self.angles );
    up = anglestoup( self.angles );
    half_length = length / 2;
    var_7f34180df115288 = width / 2;
    half_height = up_offset;
    half_forward = forward * half_length;
    half_right = right * var_7f34180df115288;
    half_up = up * half_height;
    center = self.origin + forward * forward_offset;
    radius = length / 2;
    players = getplayersinradius( center, radius );
    
    /#
        if ( getdvarint( @"hash_b3237bd1e6f7819f" ) )
        {
            forward_right_up = center + half_forward + half_right + half_up;
            forward_right_down = center + half_forward + half_right - half_up;
            back_right_up = center - half_forward + half_right + half_up;
            back_right_down = center - half_forward + half_right - half_up;
            back_left_up = center - half_forward - half_right + half_up;
            back_left_down = center - half_forward - half_right - half_up;
            forward_left_up = center + half_forward - half_right + half_up;
            forward_left_down = center + half_forward - half_right - half_up;
            debug::line( forward_right_up, forward_right_down, "<dev string:x3d>", level.ghost_train.idle_timer );
            debug::line( forward_right_up, forward_left_up, "<dev string:x3d>", level.ghost_train.idle_timer );
            debug::line( forward_right_up, back_right_up, "<dev string:x3d>", level.ghost_train.idle_timer );
            debug::line( forward_right_down, forward_left_down, "<dev string:x3d>", level.ghost_train.idle_timer );
            debug::line( forward_right_down, back_right_down, "<dev string:x3d>", level.ghost_train.idle_timer );
            debug::line( back_right_up, back_right_down, "<dev string:x3d>", level.ghost_train.idle_timer );
            debug::line( back_right_up, back_left_up, "<dev string:x3d>", level.ghost_train.idle_timer );
            debug::line( back_right_down, back_left_down, "<dev string:x3d>", level.ghost_train.idle_timer );
            debug::line( back_left_up, back_left_down, "<dev string:x3d>", level.ghost_train.idle_timer );
            debug::line( back_left_up, forward_left_up, "<dev string:x3d>", level.ghost_train.idle_timer );
            debug::line( back_left_down, forward_left_down, "<dev string:x3d>", level.ghost_train.idle_timer );
            debug::line( forward_left_up, forward_left_down, "<dev string:x3d>", level.ghost_train.idle_timer );
        }
    #/
    
    foreach ( player in players )
    {
        if ( !isalive( player ) )
        {
            continue;
        }
        
        kill = 1;
        offset = player.origin - center;
        
        if ( abs( vectordot( offset, forward ) ) > half_length )
        {
            kill = 0;
        }
        
        if ( abs( vectordot( offset, right ) ) > var_7f34180df115288 )
        {
            kill = 0;
        }
        
        if ( abs( vectordot( offset, up ) ) > half_height )
        {
            kill = 0;
        }
        
        if ( kill )
        {
            self.clip function_c9260241e1012979( player, 1 );
        }
    }
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0, eflags: 0x4
// Checksum 0xf786a8e3, Offset: 0x3311
// Size: 0x44
function private function_da5f3ec061e1425()
{
    level endon( #"game_ended" );
    level.ghost_train.physical_first_frame = 1;
    wait level.framedurationseconds * 3;
    level.ghost_train.physical_first_frame = undefined;
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0, eflags: 0x4
// Checksum 0x3463c416, Offset: 0x335d
// Size: 0x4b
function private function_939ac151fb46a0eb()
{
    ammobox_show();
    buystation_show();
    caches_show();
    cover_show();
    magicbox_show();
    
    if ( issubstr( level.ghost_train.path, "_short_" ) )
    {
        zombie_hand_show();
    }
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0, eflags: 0x4
// Checksum 0x669bbb3e, Offset: 0x33b0
// Size: 0x83
function private cover_show()
{
    foreach ( clip in level.ghost_train.cover_clip )
    {
        clip solid();
    }
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0
// Checksum 0xf9530689, Offset: 0x343b
// Size: 0x2
function function_4470c75d60370907()
{
    
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 1, eflags: 0x4
// Checksum 0x546194e6, Offset: 0x3445
// Size: 0xf8
function private ghost_state( b_hide_icon )
{
    /#
        level.ghost_train.state = 0;
    #/
    
    foreach ( model in level.ghost_train.models )
    {
        model.clip notsolid();
        
        if ( b_hide_icon )
        {
            model.scriptable setscriptablepartstate( "icon", "hide" );
            continue;
        }
        
        model.scriptable setscriptablepartstate( "icon", "ghost" );
    }
    
    function_e4b1ca4917612a25();
    function_591e959c2455b152();
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0, eflags: 0x4
// Checksum 0xcf8837e6, Offset: 0x3545
// Size: 0x33
function private function_e4b1ca4917612a25()
{
    function_193b57dcf0d862f3();
    ammobox_hide();
    buystation_hide();
    caches_hide();
    cover_hide();
    magicbox_hide();
    zombie_hand_hide();
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0, eflags: 0x4
// Checksum 0x2f2edd63, Offset: 0x3580
// Size: 0x93a
function private function_193b57dcf0d862f3()
{
    loot = [];
    
    foreach ( model in level.ghost_train.models )
    {
        a_scr = getentitylessscriptablearray( undefined, undefined, model.origin, 500 );
        
        foreach ( var_b3053b25c717315a in a_scr )
        {
            if ( ( issubstr( var_b3053b25c717315a.type, "loot" ) || issubstr( var_b3053b25c717315a.type, "powerup" ) || issubstr( var_b3053b25c717315a.type, "grappling_hook" ) ) && !issubstr( var_b3053b25c717315a.type, "cache" ) )
            {
                loot = arraycombineunique( loot, [ var_b3053b25c717315a ] );
            }
        }
    }
    
    train_loot = [];
    
    foreach ( var_b3053b25c717315a in loot )
    {
        if ( !isdefined( var_b3053b25c717315a ) )
        {
            continue;
        }
        
        foreach ( cache in level.ghost_train.caches )
        {
            if ( distancesquared( var_b3053b25c717315a.origin, cache.origin + anglestoup( cache.angles ) * 15 ) < squared( 30 ) )
            {
                train_loot = arraycombineunique( train_loot, [ var_b3053b25c717315a ] );
            }
        }
        
        if ( distancesquared( var_b3053b25c717315a.origin, level.ghost_train.buystation.origin + anglestoforward( level.ghost_train.buystation.angles ) * 5 + anglestoup( level.ghost_train.buystation.angles ) * 30 ) < squared( 80 ) )
        {
            train_loot = arraycombineunique( train_loot, [ var_b3053b25c717315a ] );
            continue;
        }
        
        s_platform_info = var_b3053b25c717315a utility::function_7c45b71b8e0d3cff();
        
        if ( !isdefined( s_platform_info ) )
        {
            continue;
        }
        
        if ( isdefined( s_platform_info ) && !isdefined( s_platform_info.groundent ) )
        {
            continue;
        }
        
        b_on_train = 0;
        
        foreach ( model in level.ghost_train.models )
        {
            if ( s_platform_info.groundent == model.clip )
            {
                up = anglestoup( s_platform_info.groundent.angles );
                surface = s_platform_info.groundent.origin + up * s_platform_info.groundent.var_5e10b6723398bb44;
                dot = vectordot( up, vectornormalize( surface - var_b3053b25c717315a.origin ) );
                
                if ( dot < 0 )
                {
                    b_on_train = 1;
                    break;
                }
            }
        }
        
        foreach ( clip in level.ghost_train.cover_clip )
        {
            if ( s_platform_info.groundent == clip )
            {
                b_on_train = 1;
            }
        }
        
        if ( s_platform_info.groundent == level.ghost_train.ammobox || s_platform_info.groundent == level.ghost_train.magicbox )
        {
            b_on_train = 1;
        }
        
        if ( b_on_train )
        {
            train_loot = arraycombineunique( train_loot, [ var_b3053b25c717315a ] );
        }
    }
    
    foreach ( var_b3053b25c717315a in train_loot )
    {
        var_b3053b25c717315a freescriptable();
    }
    
    items = [];
    
    foreach ( model in level.ghost_train.models )
    {
        items = arraycombine( items, model.clip getlinkedchildren() );
    }
    
    foreach ( clip in level.ghost_train.cover_clip )
    {
        items = arraycombine( items, clip getlinkedchildren() );
    }
    
    items = arraycombine( items, level.ghost_train.ammobox getlinkedchildren() );
    items = arraycombine( items, level.ghost_train.magicbox getlinkedchildren() );
    deployables = [];
    deployables = arraycombine( deployables, getscriptablearrayinradius( undefined, undefined, level.ghost_train.buystation.origin, 100 ) );
    
    foreach ( cache in level.ghost_train.caches )
    {
        deployables = arraycombine( deployables, getscriptablearrayinradius( undefined, undefined, cache.origin, 100 ) );
    }
    
    foreach ( item in deployables )
    {
        parent = item getlinkedparent();
        car = function_b21056d585c710d( level.ghost_train.models, item.origin );
        
        if ( parent == car )
        {
            items = arraycombineunique( items, [ item ] );
        }
    }
    
    foreach ( item in items )
    {
        if ( isdefined( item.deletefunc ) )
        {
            item [[ item.deletefunc ]]();
            continue;
        }
        
        item delete();
    }
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0, eflags: 0x4
// Checksum 0xeb427308, Offset: 0x3ec2
// Size: 0x104
function private cover_hide()
{
    foreach ( cover in level.ghost_train.cover )
    {
        cover calloutmarkerping::function_608710c894185549();
    }
    
    foreach ( clip in level.ghost_train.cover_clip )
    {
        clip notsolid();
    }
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0
// Checksum 0x41dbf9d1, Offset: 0x3fce
// Size: 0x2
function function_db853b8ac4b1bfff()
{
    
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0, eflags: 0x4
// Checksum 0x8bd9bb71, Offset: 0x3fd8
// Size: 0x129
function private ammobox_init()
{
    parent = level.ghost_train.models[ 6 ];
    ammobox = spawn( "script_model", parent.origin );
    ammobox.angles = parent.angles;
    ammobox setmodel( "military_ammo_restock_location_solid_mp" );
    ammobox.origin += anglestoforward( parent.angles ) * -30;
    ammobox.origin += anglestoright( parent.angles ) * 0;
    ammobox.origin += anglestoup( parent.angles ) * 55;
    ammobox linkto( parent, "tag_origin", ammobox.origin - parent.origin, ( 0, -90, 0 ) );
    level.ghost_train.ammobox = ammobox;
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0, eflags: 0x4
// Checksum 0xc8264175, Offset: 0x4109
// Size: 0x1a
function private ammobox_show()
{
    level.ghost_train.ammobox show();
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0, eflags: 0x4
// Checksum 0x270061fe, Offset: 0x412b
// Size: 0x37
function private ammobox_hide()
{
    level.ghost_train.ammobox calloutmarkerping::function_608710c894185549();
    level.ghost_train.ammobox hide( undefined, 1 );
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0
// Checksum 0xb07b671e, Offset: 0x416a
// Size: 0x2
function function_f2a18fe3f385de84()
{
    
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 3, eflags: 0x4
// Checksum 0xc809ccf4, Offset: 0x4174
// Size: 0x171
function private buystation_init( origin, angles, traincar )
{
    utility::flag_wait( "buy_stations_spawned" );
    parent = level.ghost_train.models[ 2 ];
    struct = spawnstruct();
    struct.origin = parent.origin;
    struct.origin += anglestoforward( parent.angles ) * -90;
    struct.origin += anglestoright( parent.angles ) * 0;
    struct.origin += anglestoup( parent.angles ) * 55;
    struct.angles = parent.angles + ( 0, 0, 0 );
    buystation = br_moving_platforms_util::function_bcd8bb47c82370fb( struct );
    buystation scriptablesetparententity( parent, buystation.origin - parent.origin, buystation.angles - parent.angles );
    level.ghost_train.buystation = buystation;
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0, eflags: 0x4
// Checksum 0x728b8a09, Offset: 0x42ed
// Size: 0x66
function private buystation_show()
{
    level.ghost_train.buystation setscriptablepartstate( "br_plunder_box", "opening" );
    level.ghost_train.buystation setscriptablepartstate( "objective", "active" );
    level.ghost_train.buystation.visible = 1;
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0, eflags: 0x4
// Checksum 0x75f2afe2, Offset: 0x435b
// Size: 0x7f
function private buystation_hide()
{
    level.ghost_train.buystation calloutmarkerping::function_608710c894185549();
    level.ghost_train.buystation setscriptablepartstate( "br_plunder_box", "hidden" );
    level.ghost_train.buystation setscriptablepartstate( "objective", "none" );
    level.ghost_train.buystation.visible = 0;
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0
// Checksum 0x4600324c, Offset: 0x43e2
// Size: 0x2
function function_e8cf80a4b8634899()
{
    
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0, eflags: 0x4
// Checksum 0x75182470, Offset: 0x43ec
// Size: 0x1c9
function private caches_init()
{
    cache_locations = [];
    cache_locations = function_1a10095ecf1ea8a7( cache_locations, 1, 1, 1, 1 );
    cache_locations = function_1a10095ecf1ea8a7( cache_locations, 1, 1, -1, 0 );
    cache_locations = function_1a10095ecf1ea8a7( cache_locations, 1, -1, 1, 0 );
    cache_locations = function_1a10095ecf1ea8a7( cache_locations, 1, -1, -1, 1 );
    cache_locations = function_1a10095ecf1ea8a7( cache_locations, 7, 1, 1, 0 );
    cache_locations = function_1a10095ecf1ea8a7( cache_locations, 7, 1, -1, 1 );
    cache_locations = function_1a10095ecf1ea8a7( cache_locations, 7, -1, 1, 1 );
    cache_locations = function_1a10095ecf1ea8a7( cache_locations, 7, -1, -1, 0 );
    level.ghost_train.caches = [];
    
    foreach ( s in cache_locations )
    {
        cache = common_cache::function_cc09d3a70f175d1d( s.type, s.parent.origin + s.origin_offset, undefined, undefined, level.commonitem.var_f4a0cd0e44af4832 );
        cache scriptablesetparententity( s.parent, s.origin_offset, s.angles_offset );
        cache.var_a3b7393208a540bc = 40;
        level.ghost_train.caches[ level.ghost_train.caches.size ] = cache;
    }
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 5, eflags: 0x4
// Checksum 0xd2649c04, Offset: 0x45bd
// Size: 0x206
function private function_1a10095ecf1ea8a7( cache_locations, car_index, dir_forward, dir_right, b_legendary )
{
    s = spawnstruct();
    s.parent = level.ghost_train.models[ car_index ];
    
    switch ( s.parent.model )
    {
        case #"hash_3aa6f664794f0c63":
        case #"hash_552093b43b2a51e3":
            forward = 160 * dir_forward;
            right = 60 * dir_right;
            up = 40;
            break;
        case #"hash_37cfb246944bc25":
            forward = 160 * dir_forward;
            right = 60 * dir_right;
            up = 55;
            break;
        default:
            assertmsg( "<dev string:x41>" );
            break;
    }
    
    s.origin_offset = ( 0, 0, 0 );
    s.origin_offset += anglestoforward( s.parent.angles ) * forward;
    s.origin_offset += anglestoright( s.parent.angles ) * right;
    s.origin_offset += anglestoup( s.parent.angles ) * up;
    s.angles_offset = ( 0, 90 + -90 * dir_right, 0 );
    s.type = "wz_sat_item_loot_cache";
    
    if ( b_legendary )
    {
        s.type += "_lege";
    }
    
    cache_locations[ cache_locations.size ] = s;
    return cache_locations;
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0, eflags: 0x4
// Checksum 0x76363ca6, Offset: 0x47cc
// Size: 0x8d
function private caches_show()
{
    foreach ( cache in level.ghost_train.caches )
    {
        cache setscriptablepartstate( "body", "closed_usable" );
    }
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0, eflags: 0x4
// Checksum 0x7ef66816, Offset: 0x4861
// Size: 0x108
function private caches_hide()
{
    foreach ( cache in level.ghost_train.caches )
    {
        cache.contents = undefined;
        var_f67995529827f79 = common_cache::function_73fc13f2febd3a2( cache.type );
        
        if ( isdefined( var_f67995529827f79.spawnlist ) && isdefined( var_f67995529827f79.spawncount ) )
        {
            common_cache::function_a136b84fc5c0dfab( cache, var_f67995529827f79.spawnlist, var_f67995529827f79.spawncount, 1 );
        }
        
        cache calloutmarkerping::function_608710c894185549();
        cache setscriptablepartstate( "body", "hidden" );
        cache notify( #"closed" );
    }
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0
// Checksum 0xa1001d3d, Offset: 0x4971
// Size: 0x2
function function_228c681c9efb8cc4()
{
    
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0, eflags: 0x4
// Checksum 0x408873a1, Offset: 0x497b
// Size: 0xb2
function private zombie_hand_init()
{
    engine = level.ghost_train.models[ 0 ];
    origin = engine.origin;
    origin += anglestoforward( engine.angles ) * 312;
    origin += anglestoright( engine.angles ) * -6;
    origin += ( 0, 0, 32 );
    level.ghost_train.zombie_hand_tag = spawn( "script_model", origin );
    level.ghost_train.zombie_hand_tag linkto( engine );
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0, eflags: 0x4
// Checksum 0xb885b1bf, Offset: 0x4a35
// Size: 0x3b
function private zombie_hand_show()
{
    if ( isdefined( level.floating_island.relic_sword_locked_door_research_center_zombie_hand ) )
    {
        level.floating_island.relic_sword_locked_door_research_center_zombie_hand setscriptablepartstate( "brloot_zombie_hand", "visible" );
    }
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0, eflags: 0x4
// Checksum 0x479f3e32, Offset: 0x4a78
// Size: 0x55
function private zombie_hand_hide()
{
    if ( isdefined( level.floating_island.relic_sword_locked_door_research_center_zombie_hand ) )
    {
        level.floating_island.relic_sword_locked_door_research_center_zombie_hand calloutmarkerping::function_608710c894185549();
        level.floating_island.relic_sword_locked_door_research_center_zombie_hand setscriptablepartstate( "brloot_zombie_hand", "hidden" );
    }
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0
// Checksum 0x37824224, Offset: 0x4ad5
// Size: 0x2
function function_ef8b5c045283f4e7()
{
    
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0, eflags: 0x4
// Checksum 0x6c6ddbe3, Offset: 0x4adf
// Size: 0xb3
function private horn_init()
{
    engine = level.ghost_train.models[ 0 ];
    origin = engine.origin;
    origin += anglestoforward( engine.angles ) * 190;
    origin += ( 0, 0, 182 );
    level.ghost_train.horn = spawnscriptable( "mp_saw_manticore_s6_ghost_train_horn", origin );
    offset = origin - engine.origin;
    level.ghost_train.horn scriptablesetparententity( engine, offset );
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0, eflags: 0x4
// Checksum 0x93e6089e, Offset: 0x4b9a
// Size: 0xd3
function private horn_starting()
{
    level endon( #"game_ending" );
    level endon( #"hash_fbd4161e4b0c10b5" );
    
    /#
        level.ghost_train.var_246db701e0100c7f = ( 0, 1, 0 );
    #/
    
    level.ghost_train.horn setscriptablepartstate( "ghost_train_horn", "idle" );
    waitframe();
    level.ghost_train.horn setscriptablepartstate( "ghost_train_horn", "starting" );
    
    if ( level.ghost_train.horn_starting_time > 0 )
    {
        wait level.ghost_train.horn_starting_time;
    }
    
    /#
        level.ghost_train.var_246db701e0100c7f = ( 0, 0, 0 );
    #/
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0, eflags: 0x4
// Checksum 0x93e6089e, Offset: 0x4c75
// Size: 0xd3
function private horn_stopping()
{
    level endon( #"game_ending" );
    level endon( #"hash_fbd4161e4b0c10b5" );
    
    /#
        level.ghost_train.var_246db701e0100c7f = ( 1, 0, 0 );
    #/
    
    if ( level.ghost_train.var_d2a821c9c1c4a188 > 0 )
    {
        wait level.ghost_train.var_d2a821c9c1c4a188;
    }
    
    level.ghost_train.horn setscriptablepartstate( "ghost_train_horn", "idle" );
    waitframe();
    level.ghost_train.horn setscriptablepartstate( "ghost_train_horn", "stopping" );
    
    /#
        level.ghost_train.var_246db701e0100c7f = ( 0, 0, 0 );
    #/
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0
// Checksum 0xced52ae5, Offset: 0x4d50
// Size: 0x2
function function_751edb4a8a570e08()
{
    
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0, eflags: 0x4
// Checksum 0xa4f0837b, Offset: 0x4d5a
// Size: 0x2b9
function private magicbox_init()
{
    level endon( #"game_ended" );
    
    while ( !level.var_1bbb5557537e2c0c.size )
    {
        waitframe();
    }
    
    s_ghost_train_magicbox = undefined;
    
    foreach ( magicbox in level.var_1bbb5557537e2c0c )
    {
        if ( isdefined( magicbox.targetname ) && magicbox.targetname == "ghost_train_magicbox" )
        {
            s_ghost_train_magicbox = magicbox;
        }
    }
    
    s_ghost_train_magicbox.var_f14b2b4820b635e7 = 1;
    s_ghost_train_magicbox.var_dc41a51effa51e7f = ( 0, 90, 0 );
    s_ghost_train_magicbox.round_number_override = 2;
    s_ghost_train_magicbox.script_cost = 0;
    magicbox = s_ghost_train_magicbox.mdl_magicbox;
    parent = level.ghost_train.models[ 4 ];
    origin = parent.origin;
    origin += anglestoforward( parent.angles ) * 0;
    origin += anglestoright( parent.angles ) * 30;
    origin += anglestoup( parent.angles ) * 70;
    magicbox.origin = origin;
    offset = magicbox.origin - parent.origin;
    magicbox.angles = parent.angles;
    magicbox.angles += ( 0, -90, 0 );
    magicbox.angles += ( 0, 90, 0 );
    angles_offset = magicbox.angles - parent.angles;
    magicbox linkto( parent, "tag_origin", offset, angles_offset );
    magicbox setscriptablepartstate( "icon", "active" );
    magicbox.interact setusableenabled( 1 );
    magicbox hide();
    level.var_c7164a558fe3d921 = &function_b1fe6abf09a0a33d;
    magicbox::function_6f00dd035f2d8f9a( 1, 0 );
    callback::add( #"player_connect", &function_f12ea6020e068330 );
    level.ghost_train.magicbox = magicbox;
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 1, eflags: 0x4
// Checksum 0x94aba257, Offset: 0x501b
// Size: 0x21
function private function_f12ea6020e068330( params )
{
    self.currency[ #"essence" ] = 0;
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0
// Checksum 0xd5d30c97, Offset: 0x5044
// Size: 0x3, Type: bool
function function_b1fe6abf09a0a33d()
{
    return false;
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0, eflags: 0x4
// Checksum 0xbb244aad, Offset: 0x5050
// Size: 0x80
function private magicbox_show()
{
    level.ghost_train.magicbox show();
    level.ghost_train.magicbox setscriptablepartstate( "base", "closed" );
    level.ghost_train.magicbox setscriptablepartstate( "beam", "on" );
    level.ghost_train.magicbox setscriptablepartstate( "model_and_collision", "default" );
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0, eflags: 0x4
// Checksum 0x8cd3c727, Offset: 0x50d8
// Size: 0x7b
function private magicbox_hide()
{
    level.ghost_train.magicbox calloutmarkerping::function_608710c894185549();
    level.ghost_train.magicbox hide( undefined, 1 );
    level.ghost_train.magicbox setscriptablepartstate( "beam", "off" );
    level.ghost_train.magicbox setscriptablepartstate( "model_and_collision", "hide" );
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0, eflags: 0x4
// Checksum 0xf4b347f0, Offset: 0x515b
// Size: 0x37
function private function_a4c865b88770031f()
{
    level endon( #"game_ended" );
    
    while ( level.ghost_train.magicbox getscriptablepartstate( "base" ) != "closed" )
    {
        waitframe();
    }
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0
// Checksum 0xbb37729, Offset: 0x519a
// Size: 0x2
function function_972647dcd1bc9dc0()
{
    
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0, eflags: 0x4
// Checksum 0x7c47ce2d, Offset: 0x51a4
// Size: 0x2fb
function private switches_init()
{
    level.ghost_train.switches = [];
    a_s_signals = utility::getstructarray( "mp_saw_manticore_s6_ghost_train_signal", "targetname" );
    a_s_stops = utility::getstructarray( "mp_saw_manticore_s6_ghost_train_stop", "targetname" );
    var_6e4687c3fdd89e2c = utility::getstructarray( "mp_saw_manticore_s6_ghost_train_switch", "targetname" );
    
    foreach ( s_switch in var_6e4687c3fdd89e2c )
    {
        s = spawnstruct();
        interact = spawnscriptable( "mp_saw_manticore_s6_ghost_train_switch", s_switch.origin );
        interact.angles = s_switch.angles;
        interact.struct = s;
        s.interact = interact;
        lever = spawn( "script_model", s_switch.origin + anglestoright( s_switch.angles ) * 2.3 );
        lever.angles = s_switch.angles;
        lever setmodel( "mp_saw_manticore_s6_ghost_train_lever" );
        lever.rotation_go = lever.angles;
        lever.rotation_stop = combineangles( lever.angles, ( 30, 0, 0 ) );
        s.lever = lever;
        s_signal = function_b21056d585c710d( a_s_signals, s_switch.origin );
        signal = spawnscriptable( "mp_saw_manticore_s6_ghost_train_signal", s_signal.origin );
        signal.angles = s_signal.angles;
        s.signal = signal;
        stop = function_b21056d585c710d( a_s_stops, s_switch.origin );
        stop.signal = signal;
        s.stop = stop;
        s.state = 1;
        level.ghost_train.switches[ level.ghost_train.switches.size ] = s;
    }
    
    scriptable::scriptable_addusedcallback( &switch_used );
    level.ghost_train.stops_long_path = utility::getstructarray( "ghost_train_stop_path_long", "script_noteworthy" );
    level.ghost_train.stops_short_path = utility::getstructarray( "ghost_train_stop_path_short", "script_noteworthy" );
    level thread function_19ddd151025f3540();
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0
// Checksum 0xbdef077e, Offset: 0x54a7
// Size: 0xae
function function_19ddd151025f3540()
{
    level endon( #"game_ended" );
    flags::function_2f3408423ccc9b2e( "infil_animatic_complete" );
    
    foreach ( s in level.ghost_train.switches )
    {
        s.interact setscriptablepartstate( "interact", "usable" );
    }
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 6
// Checksum 0xa6e85155, Offset: 0x555d
// Size: 0x60
function switch_used( instance, part, state, player, bautouse, usestring )
{
    if ( instance.type != "mp_saw_manticore_s6_ghost_train_switch" )
    {
        return;
    }
    
    instance.struct thread switch_toggle();
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0
// Checksum 0xa58d4a11, Offset: 0x55c5
// Size: 0x11a
function switch_toggle()
{
    level endon( #"game_ended" );
    self.state = !self.state;
    self.interact setscriptablepartstate( "interact", "unusable" );
    self.interact setscriptablepartstate( "fx", "on" );
    
    if ( self.state )
    {
        rotation = self.lever.rotation_go;
        light = "green";
    }
    else
    {
        rotation = self.lever.rotation_stop;
        light = "red";
    }
    
    self.lever rotateto( rotation, 1, 0.2, 0.2 );
    wait 0.5;
    self.signal setscriptablepartstate( "light", light );
    wait 0.5;
    self.interact setscriptablepartstate( "interact", "usable" );
    self.interact setscriptablepartstate( "fx", "off" );
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0
// Checksum 0x49a93af0, Offset: 0x56e7
// Size: 0x2
function function_64fd49663f171bce()
{
    
}

// Namespace namespace_b1e70b44ac1fcc2b
// Params 0
// Checksum 0x6657f8f2, Offset: 0x56f1
// Size: 0x2
function cleanup()
{
    
}

/#

    // Namespace namespace_b1e70b44ac1fcc2b
    // Params 0
    // Checksum 0xe9e81fff, Offset: 0x56fb
    // Size: 0x5, Type: dev
    function function_b967f2f55dce6301()
    {
        
    }

    // Namespace namespace_b1e70b44ac1fcc2b
    // Params 0
    // Checksum 0x51cac991, Offset: 0x5708
    // Size: 0x44, Type: dev
    function debug_init()
    {
        level waittill( #"player_spawned" );
        level thread function_6c025e2cb9e2dd26();
        level.ghost_train.state = 0;
        utility::function_95db22f620602461( @"hash_b3237bd1e6f7819f", &function_b4ea20392e5f9731 );
    }

    // Namespace namespace_b1e70b44ac1fcc2b
    // Params 0
    // Checksum 0x9f14508c, Offset: 0x5754
    // Size: 0x122, Type: dev
    function function_6c025e2cb9e2dd26()
    {
        devgui::function_9082edeb5db93280( "<dev string:x5e>" );
        devgui::add_devgui_func( "<dev string:x6e>", "<dev string:x74>", &debug_start );
        devgui::add_devgui_func( "<dev string:x93>", "<dev string:x98>", &debug_stop );
        devgui::function_cd4e263c1f3018ae( "<dev string:xb6>", "<dev string:xd7>" + "<dev string:xb6>", &debug_go_path );
        devgui::function_cd4e263c1f3018ae( "<dev string:xe6>", "<dev string:xd7>" + "<dev string:xe6>", &debug_go_path );
        devgui::function_cd4e263c1f3018ae( "<dev string:x109>", "<dev string:xd7>" + "<dev string:x109>", &debug_go_path );
        devgui::function_cd4e263c1f3018ae( "<dev string:x12b>", "<dev string:xd7>" + "<dev string:x12b>", &debug_go_path );
        devgui::add_devgui_func( "<dev string:x14f>", "<dev string:x15c>", &debug_ghost_train );
        devgui::add_devgui_func( "<dev string:x17b>", "<dev string:x188>", &debug_toggle_state );
        devgui::add_devgui_func( "<dev string:x1ad>", "<dev string:x1be>", &function_a3410e18b2fd537c );
        devgui::add_devgui_func( "<dev string:x1ee>", "<dev string:x201>", &function_10cd0ced15da2fa2 );
        devgui::add_devgui_func( "<dev string:x233>", "<dev string:x249>", &function_f4995d99a318df85 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_b1e70b44ac1fcc2b
    // Params 0
    // Checksum 0x729e5b4d, Offset: 0x587e
    // Size: 0xd, Type: dev
    function debug_start()
    {
        level thread start();
    }

    // Namespace namespace_b1e70b44ac1fcc2b
    // Params 0
    // Checksum 0x233eab75, Offset: 0x5893
    // Size: 0xd, Type: dev
    function debug_stop()
    {
        level thread stop();
    }

    // Namespace namespace_b1e70b44ac1fcc2b
    // Params 1
    // Checksum 0x1c0d6869, Offset: 0x58a8
    // Size: 0x32, Type: dev
    function debug_go_path( params )
    {
        level.ghost_train.debug_go_path = params[ 0 ];
        level notify( #"debug_go_path" );
    }

    // Namespace namespace_b1e70b44ac1fcc2b
    // Params 0
    // Checksum 0xb1177477, Offset: 0x58e2
    // Size: 0x5a, Type: dev
    function debug_ghost_train()
    {
        if ( !getdvarint( @"hash_b3237bd1e6f7819f" ) )
        {
            iprintlnbold( "<dev string:x27e>" );
            setdvar( @"hash_b3237bd1e6f7819f", 1 );
            function_6ad3feef124b2718();
            return;
        }
        
        iprintlnbold( "<dev string:x294>" );
        setdvar( @"hash_b3237bd1e6f7819f", 0 );
        function_3b3df5c53b2128d2();
    }

    // Namespace namespace_b1e70b44ac1fcc2b
    // Params 0
    // Checksum 0xf9a695b5, Offset: 0x5944
    // Size: 0xd, Type: dev
    function function_b4ea20392e5f9731()
    {
        level thread function_6ad3feef124b2718();
    }

    // Namespace namespace_b1e70b44ac1fcc2b
    // Params 0
    // Checksum 0x3b2dd143, Offset: 0x5959
    // Size: 0x71, Type: dev
    function function_6ad3feef124b2718()
    {
        level endon( #"game_ended" );
        level endon( #"hash_d7a0de1d1c3de347" );
        
        while ( !level.ghost_train.models.size )
        {
            waitframe();
        }
        
        level thread function_2e79056ee170edd8();
        level thread function_8db17c4159f58129();
        level thread function_ff8c99dcb206febe();
        level thread function_23832ea62ef924fa();
        level thread debug_ghost_train_horn();
        level thread debug_ghost_train_magicbox();
        level thread function_370f7f7579fb1105();
    }

    // Namespace namespace_b1e70b44ac1fcc2b
    // Params 0
    // Checksum 0xeccffbbe, Offset: 0x59d2
    // Size: 0x2c, Type: dev
    function function_2e79056ee170edd8()
    {
        debug::sphere( level.ghost_train.ammobox, 50, "<dev string:x2ab>", undefined, "<dev string:x2b0>" );
    }

    // Namespace namespace_b1e70b44ac1fcc2b
    // Params 0
    // Checksum 0x87e0d3ca, Offset: 0x5a06
    // Size: 0x2c, Type: dev
    function function_8db17c4159f58129()
    {
        debug::sphere( level.ghost_train.buystation, 50, "<dev string:x2c6>", undefined, "<dev string:x2b0>" );
    }

    // Namespace namespace_b1e70b44ac1fcc2b
    // Params 0
    // Checksum 0xe3f2a4c, Offset: 0x5a3a
    // Size: 0x7c, Type: dev
    function function_ff8c99dcb206febe()
    {
        level.ghost_train.models[ 0 ] thread function_ea93efc5bc1c3439( 630, 170, 0, 40 );
        
        for ( i = 1; i < level.ghost_train.models.size ; i++ )
        {
            level.ghost_train.models[ i ] thread function_ea93efc5bc1c3439( 600, 170, 0, 40 );
        }
    }

    // Namespace namespace_b1e70b44ac1fcc2b
    // Params 4
    // Checksum 0x5448626a, Offset: 0x5abe
    // Size: 0x184, Type: dev
    function function_ea93efc5bc1c3439( length, width, forward_offset, z_offset )
    {
        level endon( #"hash_d7a0de1d1c3de347" );
        halflength = length / 2;
        halfwidth = width / 2;
        
        while ( true )
        {
            forward = anglestoforward( self.angles );
            right = anglestoright( self.angles );
            up = anglestoup( self.angles );
            var_6cd632bf7b88480b = self.origin + forward * halflength + right * halfwidth + forward * forward_offset + up * z_offset;
            backright = self.origin - forward * halflength + right * halfwidth + forward * forward_offset + up * z_offset;
            backleft = self.origin - forward * halflength - right * halfwidth + forward * forward_offset + up * z_offset;
            var_3cbff5da9bc64a36 = self.origin + forward * halflength - right * halfwidth + forward * forward_offset + up * z_offset;
            line( var_6cd632bf7b88480b, backright, self.debug_color );
            line( backright, backleft, self.debug_color );
            line( backleft, var_3cbff5da9bc64a36, self.debug_color );
            line( var_3cbff5da9bc64a36, var_6cd632bf7b88480b, self.debug_color );
            waitframe();
        }
    }

    // Namespace namespace_b1e70b44ac1fcc2b
    // Params 0
    // Checksum 0xfcb5651a, Offset: 0x5c4a
    // Size: 0x11d, Type: dev
    function function_23832ea62ef924fa()
    {
        level endon( #"hash_d7a0de1d1c3de347" );
        
        while ( true )
        {
            foreach ( cache in level.ghost_train.caches )
            {
                color = ( 1, 1, 1 );
                
                if ( issubstr( cache.type, "<dev string:x2ce>" ) )
                {
                    color = ( 1, 0.5, 0 );
                }
                
                sphere( cache.origin, 10, color, 0, 1 );
                line( cache.origin, cache.origin + anglestoright( cache.angles ) * -50, color, 1, 0, 1 );
            }
            
            waitframe();
        }
    }

    // Namespace namespace_b1e70b44ac1fcc2b
    // Params 0
    // Checksum 0x3180409e, Offset: 0x5d6f
    // Size: 0x75, Type: dev
    function debug_ghost_train_horn()
    {
        level endon( #"hash_46804069395627f6" );
        level.ghost_train.var_246db701e0100c7f = ( 0, 0, 0 );
        
        while ( true )
        {
            sphere( level.ghost_train.horn.origin, 10, level.ghost_train.var_246db701e0100c7f, 0, 1 );
            waitframe();
        }
    }

    // Namespace namespace_b1e70b44ac1fcc2b
    // Params 0
    // Checksum 0xeeb8d705, Offset: 0x5dec
    // Size: 0x2c, Type: dev
    function debug_ghost_train_magicbox()
    {
        debug::sphere( level.ghost_train.magicbox, 50, "<dev string:x2d4>", undefined, "<dev string:x2b0>" );
    }

    // Namespace namespace_b1e70b44ac1fcc2b
    // Params 0
    // Checksum 0xaba37e1b, Offset: 0x5e20
    // Size: 0xfd, Type: dev
    function function_370f7f7579fb1105()
    {
        level endon( #"game_ended" );
        level endon( #"hash_d7a0de1d1c3de347" );
        
        while ( true )
        {
            foreach ( stop in level.ghost_train.var_feb75335101deb4f )
            {
                if ( stop.signal getscriptablepartstate( "<dev string:x2db>" ) == "<dev string:x2e1>" )
                {
                    color = ( 0, 1, 0 );
                }
                else
                {
                    color = ( 1, 0, 0 );
                }
                
                sphere( stop.origin, 50, color, 0, 1 );
            }
            
            waitframe();
        }
    }

    // Namespace namespace_b1e70b44ac1fcc2b
    // Params 0
    // Checksum 0x41daf692, Offset: 0x5f25
    // Size: 0x11, Type: dev
    function function_3b3df5c53b2128d2()
    {
        level notify( #"hash_d7a0de1d1c3de347" );
    }

    // Namespace namespace_b1e70b44ac1fcc2b
    // Params 0
    // Checksum 0x893e5a70, Offset: 0x5f3e
    // Size: 0x59, Type: dev
    function debug_toggle_state()
    {
        if ( !level.ghost_train.state )
        {
            iprintlnbold( "<dev string:x2e7>" );
            physical_state();
            train_fx( "<dev string:x303>" );
            return;
        }
        
        iprintlnbold( "<dev string:x30c>" );
        ghost_state();
        train_fx( "<dev string:x325>" );
    }

    // Namespace namespace_b1e70b44ac1fcc2b
    // Params 0
    // Checksum 0x147a397d, Offset: 0x5f9f
    // Size: 0x92, Type: dev
    function function_a3410e18b2fd537c()
    {
        foreach ( struct in level.ghost_train.switches )
        {
            level thread switch_used( struct.interact );
        }
    }

    // Namespace namespace_b1e70b44ac1fcc2b
    // Params 0
    // Checksum 0xbf6de50e, Offset: 0x6039
    // Size: 0xff, Type: dev
    function function_10cd0ced15da2fa2()
    {
        f_best = -1;
        scr_best = -1;
        
        foreach ( struct in level.ghost_train.switches )
        {
            dot = vectordot( anglestoforward( level.player getplayerangles() ), vectornormalize( struct.interact.origin - level.player geteye() ) );
            
            if ( dot > f_best )
            {
                f_best = dot;
                scr_best = struct.interact;
            }
        }
        
        level thread switch_used( scr_best );
    }

    // Namespace namespace_b1e70b44ac1fcc2b
    // Params 0
    // Checksum 0xcebe985b, Offset: 0x6140
    // Size: 0x13, Type: dev
    function function_f4995d99a318df85()
    {
        level.var_a28a6b70b096f4e5 = "<dev string:x32b>";
    }

#/
