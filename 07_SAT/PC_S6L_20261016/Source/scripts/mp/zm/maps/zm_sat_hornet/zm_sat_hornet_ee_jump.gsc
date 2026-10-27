// scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_ee_jump.gsc  (hash_1462ea00c464fd65.gscc) (size: 15000 Bytes / 0x3a98 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x89ad6045 (2309840965)
// size ...... 15000 (0x3a98)
// includes .. 11  (offset: 0x37e8)
// strings ... 35  (offset: 0x3840)
// dev strs .. 7   (offset: 0x3a44)
// exports ... 37  (offset: 0x24cc)
// cseg ...... 0x2d9 + 0x21f3 (0x24cc)
// imports ... 112 (offset: 0x2a94)
// animtree1 . 0   (offset: 0x3a98)
// animtree2 . 0   (offset: 0x3a98)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\loot\common_item;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_ee_jump_cs;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_ee_rocker;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;

#namespace zm_sat_hornet_ee_jump;

// Namespace zm_sat_hornet_ee_jump
// Params 0, eflags: 0x5
// Checksum 0x5a64030d, Offset: 0x2f7
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"zm_sat_hornet_ee_jump", undefined, &function_7cf8dacb278a2665, &postmain_init );
}

// Namespace zm_sat_hornet_ee_jump
// Params 0, eflags: 0x4
// Checksum 0x71be5930, Offset: 0x31c
// Size: 0x2
function private function_7cf8dacb278a2665()
{
    
}

// Namespace zm_sat_hornet_ee_jump
// Params 0, eflags: 0x4
// Checksum 0x34f59b7e, Offset: 0x326
// Size: 0xaa
function private postmain_init()
{
    if ( !getdvarint( @"enable_hornet_sq", 0 ) || !getdvarint( @"hash_5887a7cc08cc193e", 1 ) )
    {
        return;
    }
    
    zm_sat_hornet_ee_jump_cs::main();
    level utility::flag_wait( "zm_quest_initialized" );
    level.ee_jump = zm_quest::get_quest( #"hornet_ee_jump" );
    zm_quest::register_quest_step( #"hornet_ee_jump", #"hash_87017534a4d72f20", &setup_jump_step, &cleanup_jump_step );
    function_3228e1e8a3feee63();
    level zm_save::function_1f44a48caae2acbf();
    level.ee_jump thread zm_quest::start_quest( #"hornet_ee_jump" );
    
    /#
        register_cafe_devgui();
    #/
}

// Namespace zm_sat_hornet_ee_jump
// Params 2, eflags: 0x4
// Checksum 0xa6fbad, Offset: 0x3d8
// Size: 0x75
function private setup_jump_step( b_skipped, b_save_restored )
{
    level.ee_jump.var_51ceb27be5ad76da = level zm_quest::function_73720cdf21c3cfd7( #"hornet_ee_jump", #"hash_ceb71db41fce625c" ) ?? 0;
    level callback::add( "on_round_start", &on_round_start );
    level thread monitor_course_triggers();
    level thread function_81eb7bf43ec17c43();
    level waittill( #"hash_61053a94ee16dfd4" );
}

// Namespace zm_sat_hornet_ee_jump
// Params 2, eflags: 0x4
// Checksum 0x7853ee1b, Offset: 0x455
// Size: 0x15
function private cleanup_jump_step( b_skipped, b_save_restored )
{
    
}

// Namespace zm_sat_hornet_ee_jump
// Params 1, eflags: 0x4
// Checksum 0x2d2db92e, Offset: 0x472
// Size: 0x51
function private on_round_start( params )
{
    wait randomintrange( 20, 60 );
    
    if ( params.roundnumber >= 9 && params.roundnumber % 3 == 0 )
    {
        rock = zm_sat_hornet_ee_rocker::function_49a6f3d88d8f4381( "rkr_bt" );
    }
}

// Namespace zm_sat_hornet_ee_jump
// Params 0, eflags: 0x4
// Checksum 0x8e173ad3, Offset: 0x4cb
// Size: 0x3af
function private function_3228e1e8a3feee63()
{
    var_91bed5636f5f050d = getnoentvolumearray( "jp_secvol", "targetname" );
    level.ee_jump.section_volumes = arraysort( var_91bed5636f5f050d, undefined, &function_bdb8effb5902f6d9 );
    var_5366117d7fb19440 = utility::getstructarray( "jp_prp", "targetname" );
    level.ee_jump.section_props = [];
    
    for ( i = 0; i < 4 ; i++ )
    {
        level.ee_jump.section_props[ i ] = [];
    }
    
    foreach ( prop in var_5366117d7fb19440 )
    {
        switch ( prop.groupid )
        {
            case #"hash_b4f94489f5ad4399":
                level.ee_jump.section_props[ 0 ][ level.ee_jump.section_props[ 0 ].size ] = prop;
                break;
            case #"hash_b4f94189f5ad3ee0":
                level.ee_jump.section_props[ 1 ][ level.ee_jump.section_props[ 1 ].size ] = prop;
                break;
            case #"hash_b4f94289f5ad4073":
                level.ee_jump.section_props[ 2 ][ level.ee_jump.section_props[ 2 ].size ] = prop;
                break;
            case #"hash_b4f94789f5ad4852":
                level.ee_jump.section_props[ 3 ][ level.ee_jump.section_props[ 3 ].size ] = prop;
                break;
        }
    }
    
    var_29aaa1cca8867f54 = utility::getstructarray( "jp_kma", "targetname" );
    level.ee_jump.komainu = [];
    
    foreach ( struct in var_29aaa1cca8867f54 )
    {
        level.ee_jump.komainu[ level.ee_jump.komainu.size ] = struct;
    }
    
    level.ee_jump.end_komainu = utility::getstructarray( "jp_kma_end", "targetname" );
    level.ee_jump.n_active_rayguns = 0;
    
    foreach ( struct in level.ee_jump.end_komainu )
    {
        struct.var_6bca1ec7c00c2f9 = 0;
    }
    
    level.ee_jump.var_3bfd1ad32ac1f2be = utility::getstruct( "jp_return", "targetname" );
}

// Namespace zm_sat_hornet_ee_jump
// Params 2, eflags: 0x4
// Checksum 0x5178a658, Offset: 0x882
// Size: 0x34, Type: bool
function private function_bdb8effb5902f6d9( item1, item2 )
{
    return int( item1.script_noteworthy ) < int( item2.script_noteworthy );
}

// Namespace zm_sat_hornet_ee_jump
// Params 0, eflags: 0x4
// Checksum 0x4f543d8c, Offset: 0x8bf
// Size: 0x8b
function private monitor_course_triggers()
{
    level.ee_jump.sections_spawned = [];
    
    for ( i = 0; i < 4 ; i++ )
    {
        level.ee_jump.sections_spawned[ i ] = 0;
    }
    
    for ( i = 0; i < level.ee_jump.section_volumes.size ; i++ )
    {
        level.ee_jump.section_volumes[ i ] thread function_bd3d38c29d6abe22( i );
    }
}

// Namespace zm_sat_hornet_ee_jump
// Params 0, eflags: 0x4
// Checksum 0x87a37771, Offset: 0x952
// Size: 0x9b
function private function_81eb7bf43ec17c43()
{
    level endon( #"game_ended" );
    [ trigger ] = getnoentvolumearray( "jp_dis_plach", "targetname" );
    var_6b84daaef51f2c47 = getent( "rky_pc_bm", "targetname" );
    
    while ( true )
    {
        trigger waittill( #"trigger", ent );
        
        if ( isplayer( ent ) && isalive( ent ) && !isdefined( ent.var_f3375f58fe986a8d ) )
        {
            ent thread function_71a3b7ca24da7c56( var_6b84daaef51f2c47 );
        }
    }
}

// Namespace zm_sat_hornet_ee_jump
// Params 1, eflags: 0xc
// Checksum 0x319f25ca, Offset: 0x9f5
// Size: 0xf8
function private function_71a3b7ca24da7c56( var_6b84daaef51f2c47 )
{
    self notify( #"hash_bccbe76202531ed2" );
    self endon( #"hash_bccbe76202531ed2" );
    self endon( #"death_or_disconnect" );
    self endon( #"started_jumper" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        while ( !self isonground() )
        {
            wait 0.1;
        }
        
        ground_ent = self getgroundentity();
        
        if ( ground_ent && ground_ent == var_6b84daaef51f2c47 )
        {
            val::set( "jp_on_rock", "ignoreme", 1 );
            self.b_ignore_playable_area_check = 1;
            self.var_d850a8005d90a474 = 1;
            self.var_89ff21882a827bae = 1;
        }
        else if ( !isdefined( self.jump_timer_end ) )
        {
            val::reset( "jp_on_rock", "ignoreme" );
            self.b_ignore_playable_area_check = undefined;
            self.var_d850a8005d90a474 = undefined;
            self.var_89ff21882a827bae = undefined;
            return;
        }
        
        wait 4;
    }
}

// Namespace zm_sat_hornet_ee_jump
// Params 1, eflags: 0x4
// Checksum 0x771c472b, Offset: 0xaf5
// Size: 0x3eb
function private function_bd3d38c29d6abe22( n_index )
{
    level endon( #"game_ended" );
    n_last = level.ee_jump.section_volumes.size - 1;
    
    while ( true )
    {
        self waittill( #"trigger", player );
        
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        if ( !isdefined( player.jump_progress ) )
        {
            player.jump_progress = [];
        }
        
        n_expected = player.jump_progress.size;
        
        if ( n_index != n_expected )
        {
            continue;
        }
        
        player.jump_progress[ player.jump_progress.size ] = n_index;
        
        if ( n_index == 0 && !player.jump_checkpoint )
        {
            player notify( #"started_jumper" );
            player.jump_checkpoint = self;
            n_bonus = function_3d59e7b705eaf197( n_index );
            player.jump_timer_end = gettime() + n_bonus * 1000;
            player val::set( "jp_on_rock", "ignoreme", 1 );
            player.b_ignore_playable_area_check = 1;
            player.var_d850a8005d90a474 = 1;
            player.var_89ff21882a827bae = 1;
            player zm_quest::function_fba942a1cfd85f5d( 1, 0, #"hornet_ee_jump", #"course_time" );
            player zm_quest::function_fb3af5600f6a9441( 2, 0, #"hornet_ee_jump", #"course_time" );
            player zm_quest::function_612a9ad0db22c29c( n_bonus * 1000, 0, #"hornet_ee_jump", #"course_time" );
            player thread function_5ab3dea565de9356();
            player thread function_2111eb7c9f47e52();
            player thread function_a531a22d38de57fc();
            player thread function_114da2b9aa3bc85c();
            player thread function_a14371d1f33bd98a();
        }
        else
        {
            player.jump_checkpoint = self;
            n_bonus = function_3d59e7b705eaf197( n_index );
            player.jump_timer_end += n_bonus * 1000;
            n_remaining_ms = player.jump_timer_end - gettime();
            
            if ( n_remaining_ms < 0 )
            {
                n_remaining_ms = 0;
            }
            
            player zm_quest::function_612a9ad0db22c29c( n_remaining_ms, 0, #"hornet_ee_jump", #"course_time" );
            player playsoundtoplayer( "evt_success_stinger", player );
        }
        
        if ( n_index < level.ee_jump.komainu.size )
        {
            struct = level.ee_jump.komainu[ n_index ];
            level.ee_jump.komainu[ n_index ].sbl = spawnscriptable( %"zm_sat_hornet_komainu", struct.origin, struct.angles );
        }
        
        if ( n_index >= 1 )
        {
            var_b43e36c2fd90bef2 = n_index - 1;
            
            if ( var_b43e36c2fd90bef2 < level.ee_jump.komainu.size )
            {
                level.ee_jump.komainu[ var_b43e36c2fd90bef2 ].sbl utility::function_32b24db3127bff40( "base", "ready_alt" );
            }
        }
        
        if ( n_index == n_last )
        {
            player playsoundtoplayer( "evt_ee_complete_success_stinger", player );
            player zm_quest::function_fba942a1cfd85f5d( 0, 0, #"hornet_ee_jump", #"course_time" );
            player notify( #"hash_ae674e23055f2f53" );
            player function_769aafd3d9289772( 1 );
            level thread function_9fad22591b22801b( player );
            function_549e3b3bf26e0b43();
            continue;
        }
        
        if ( n_index < 4 && !level.ee_jump.sections_spawned[ n_index ] )
        {
            level.ee_jump.sections_spawned[ n_index ] = 1;
            thread function_d3f9ed2c46cafd18( n_index );
        }
    }
}

// Namespace zm_sat_hornet_ee_jump
// Params 1, eflags: 0x4
// Checksum 0x245b163, Offset: 0xee8
// Size: 0x83
function private function_769aafd3d9289772( b_delay_ignoreme )
{
    self.jump_progress = undefined;
    self.jump_checkpoint = undefined;
    self.jump_timer_end = undefined;
    self.b_ignore_playable_area_check = undefined;
    self.var_d850a8005d90a474 = undefined;
    self.var_89ff21882a827bae = undefined;
    self.var_f3375f58fe986a8d = undefined;
    
    if ( b_delay_ignoreme )
    {
        utility::delaythread( 13, &val::reset, "jp_on_rock", "ignoreme" );
        return;
    }
    
    val::reset( "jp_on_rock", "ignoreme" );
}

// Namespace zm_sat_hornet_ee_jump
// Params 0, eflags: 0x4
// Checksum 0xe31abca6, Offset: 0xf73
// Size: 0x101
function private function_5ab3dea565de9356()
{
    self endon( #"disconnect" );
    self endon( #"hash_ae674e23055f2f53" );
    level endon( #"hornet_mq_bossfight_fasttravel_started" );
    level endon( #"neigh_voting_passed" );
    self waittill( #"hash_cb4ba32be0443801" );
    self playsoundtoplayer( "evt_ee_fail_stinger", self );
    
    if ( !isdefined( self.var_c4c887cfbd9bba22 ) )
    {
        self.var_c4c887cfbd9bba22 = 1;
        thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( "hornet_hesd2_world_at_parkour_fail", #"bc_flavor_player_negative" );
    }
    
    zm_quest::function_fba942a1cfd85f5d( 0, 0, #"hornet_ee_jump", #"course_time" );
    var_3bfd1ad32ac1f2be = level.ee_jump.var_3bfd1ad32ac1f2be;
    self setorigin( var_3bfd1ad32ac1f2be.origin );
    
    if ( isdefined( var_3bfd1ad32ac1f2be.angles ) )
    {
        self setplayerangles( var_3bfd1ad32ac1f2be.angles );
    }
    
    wait 1;
    function_769aafd3d9289772();
    function_549e3b3bf26e0b43();
    self notify( #"hash_ae674e23055f2f53" );
}

// Namespace zm_sat_hornet_ee_jump
// Params 0, eflags: 0x4
// Checksum 0xb59d5904, Offset: 0x107c
// Size: 0x6d
function private function_2111eb7c9f47e52()
{
    self endon( #"disconnect" );
    self endon( #"hash_ae674e23055f2f53" );
    self endon( #"hash_cb4ba32be0443801" );
    level utility::waittill_any( "hornet_mq_bossfight_fasttravel_started", "neigh_voting_passed" );
    zm_quest::function_fba942a1cfd85f5d( 0, 0, #"hornet_ee_jump", #"course_time" );
    function_769aafd3d9289772();
    function_549e3b3bf26e0b43();
    self notify( #"hash_ae674e23055f2f53" );
}

// Namespace zm_sat_hornet_ee_jump
// Params 0, eflags: 0x4
// Checksum 0xce5dd80, Offset: 0x10f1
// Size: 0xa0
function private function_114da2b9aa3bc85c()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( #"hash_ae674e23055f2f53" );
    
    while ( isdefined( self.jump_timer_end ) )
    {
        n_remaining_ms = self.jump_timer_end - gettime();
        rounded_ms = int( n_remaining_ms / 1000 );
        
        if ( n_remaining_ms < 0 )
        {
            n_remaining_ms = 0;
            break;
        }
        
        zm_quest::function_612a9ad0db22c29c( rounded_ms * 1000, 0, #"hornet_ee_jump", #"course_time" );
        wait 1;
    }
    
    self notify( #"hash_cb4ba32be0443801" );
}

// Namespace zm_sat_hornet_ee_jump
// Params 0, eflags: 0x4
// Checksum 0x3255f10f, Offset: 0x1199
// Size: 0x7e
function private function_a14371d1f33bd98a()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( #"hash_ae674e23055f2f53" );
    
    while ( isdefined( self.jump_timer_end ) )
    {
        level waittill( #"hash_7bdf5ebd10ff8691" );
        wait 1;
        zm_quest::function_fba942a1cfd85f5d( 1, 0, #"hornet_ee_jump", #"course_time" );
        zm_quest::function_fb3af5600f6a9441( 2, 0, #"hornet_ee_jump", #"course_time" );
    }
}

// Namespace zm_sat_hornet_ee_jump
// Params 0, eflags: 0x4
// Checksum 0xb2dad12f, Offset: 0x121f
// Size: 0xb4
function private function_a531a22d38de57fc()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self endon( #"hash_ae674e23055f2f53" );
    
    while ( true )
    {
        while ( !self.var_d682d30b84057103 )
        {
            wait 0.1;
        }
        
        wait 0.25;
        self freezecontrols( 1 );
        
        if ( isdefined( self.jump_checkpoint ) )
        {
            self setorigin( self.jump_checkpoint.origin + ( 0, 0, 96 ) );
            self playsoundtoplayer( "evt_fail_stinger", self );
        }
        
        wait 0.1;
        self freezecontrols( 0 );
        
        while ( self.var_d682d30b84057103 )
        {
            wait 0.05;
        }
    }
}

// Namespace zm_sat_hornet_ee_jump
// Params 1, eflags: 0x4
// Checksum 0x4d005b85, Offset: 0x12db
// Size: 0xd1
function private function_d3f9ed2c46cafd18( n_index )
{
    level endon( #"game_ended" );
    level utility::flag_wait( "scriptables_ready" );
    a_structs = level.ee_jump.section_props[ n_index ];
    v_offset = ( 0, 0, -100 );
    
    foreach ( struct in a_structs )
    {
        level thread function_4758b35908ab9001( struct, v_offset );
        waitframe();
    }
}

// Namespace zm_sat_hornet_ee_jump
// Params 2, eflags: 0x4
// Checksum 0xfa17a0b9, Offset: 0x13b4
// Size: 0x1cf
function private function_4758b35908ab9001( struct, v_offset )
{
    if ( isdefined( struct.sbl ) )
    {
        return;
    }
    
    v_spawn_pos = struct.origin + v_offset;
    obstacle = spawnscriptable( %"hash_5896e4c5490ea260", v_spawn_pos, struct.angles );
    e_mover = utility::spawn_model( "tag_origin", v_spawn_pos, struct.angles );
    struct.sbl = obstacle;
    struct.e_mover = e_mover;
    e_mover endon( #"deleted" );
    
    if ( struct.script_noteworthy )
    {
        obstacle utility::function_32b24db3127bff40( "model", struct.script_noteworthy );
    }
    
    obstacle scriptablesetparententity( e_mover, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    e_mover thread utility::play_loop_sound_on_entity( "evt_trail_lp" );
    e_mover moveto( struct.origin, 3, 0, 3 );
    e_mover waittill( #"movedone" );
    e_mover utility::stop_loop_sound_on_entity( "evt_trail_lp" );
    
    if ( struct.script_label == "bobber" )
    {
        obstacle.e_mover = e_mover;
        
        if ( struct.target )
        {
            obstacle.init_wait = float( struct.target );
        }
        
        obstacle thread function_40015cef400623c();
        return;
    }
    
    if ( struct.script_label == "sinker" )
    {
        obstacle.e_mover = e_mover;
        obstacle thread function_7b0d29df990c0d4();
        return;
    }
    
    e_mover delete();
    struct.e_mover = undefined;
}

// Namespace zm_sat_hornet_ee_jump
// Params 0, eflags: 0x4
// Checksum 0x5a3641c6, Offset: 0x158b
// Size: 0xa7
function private function_40015cef400623c()
{
    level endon( #"game_ended" );
    self.e_mover endon( #"deleted" );
    e_mover = self.e_mover;
    
    if ( self.init_wait )
    {
        wait self.init_wait;
    }
    
    while ( true )
    {
        e_mover movez( -24, 2, 0.5, 0.5 );
        e_mover waittill( #"movedone" );
        wait 0.5;
        e_mover movez( 24, 2, 0.5, 0.5 );
        e_mover waittill( #"movedone" );
        wait 2.5;
    }
}

// Namespace zm_sat_hornet_ee_jump
// Params 0, eflags: 0x4
// Checksum 0x27060a51, Offset: 0x163a
// Size: 0x108
function private function_7b0d29df990c0d4()
{
    level endon( #"game_ended" );
    self.e_mover endon( #"deleted" );
    e_mover = self.e_mover;
    n_original_z = e_mover.origin[ 2 ];
    
    while ( true )
    {
        while ( !has_player_standing( e_mover, 1 ) )
        {
            wait 0.1;
        }
        
        while ( has_player_standing( e_mover, 0 ) )
        {
            var_8f9d7f48660f77ab = 2;
            e_mover movez( var_8f9d7f48660f77ab * -1, 0.1 );
            e_mover waittill( #"movedone" );
        }
        
        wait 1;
        
        if ( has_player_standing( e_mover, 0 ) )
        {
            continue;
        }
        
        var_c96e6b744625bd75 = n_original_z - e_mover.origin[ 2 ];
        
        if ( var_c96e6b744625bd75 > 0 )
        {
            var_8e794f28d369ae31 = var_c96e6b744625bd75 / 20;
            e_mover movez( var_c96e6b744625bd75, var_8e794f28d369ae31 );
            e_mover waittill( #"movedone" );
        }
    }
}

// Namespace zm_sat_hornet_ee_jump
// Params 2, eflags: 0x4
// Checksum 0xb5a94a5, Offset: 0x174a
// Size: 0x131, Type: bool
function private has_player_standing( e_mover, b_check_velocity )
{
    foreach ( player in level.players )
    {
        if ( !isalive( player ) )
        {
            continue;
        }
        
        if ( player.origin[ 2 ] <= e_mover.origin[ 2 ] )
        {
            continue;
        }
        
        n_dx = player.origin[ 0 ] - e_mover.origin[ 0 ];
        n_dy = player.origin[ 1 ] - e_mover.origin[ 1 ];
        
        if ( n_dx * n_dx + n_dy * n_dy > 1024 )
        {
            continue;
        }
        
        if ( b_check_velocity && length( player getvelocity() ) > 50 )
        {
            continue;
        }
        
        return true;
    }
    
    return false;
}

// Namespace zm_sat_hornet_ee_jump
// Params 1, eflags: 0x4
// Checksum 0x4101848, Offset: 0x1884
// Size: 0x61
function private function_3d59e7b705eaf197( n_index )
{
    switch ( n_index )
    {
        case 0:
            return 45;
        case 1:
            return 15;
        case 2:
            return 30;
        case 3:
            return 30;
        default:
            return 45;
    }
}

// Namespace zm_sat_hornet_ee_jump
// Params 0, eflags: 0x4
// Checksum 0x9b1fce86, Offset: 0x18ed
// Size: 0x96, Type: bool
function private function_d5a7106208ae90d9()
{
    foreach ( player in level.players )
    {
        if ( player.jump_progress && player.jump_progress.size > 0 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_sat_hornet_ee_jump
// Params 0, eflags: 0x4
// Checksum 0xb9a69393, Offset: 0x198c
// Size: 0x15b
function private function_549e3b3bf26e0b43()
{
    if ( function_d5a7106208ae90d9() )
    {
        return;
    }
    
    for ( i = 0; i < 4 ; i++ )
    {
        if ( !level.ee_jump.sections_spawned[ i ] )
        {
            continue;
        }
        
        foreach ( struct in level.ee_jump.section_props[ i ] )
        {
            level thread function_2743e62d1ee2024( struct );
        }
        
        foreach ( struct in level.ee_jump.komainu )
        {
            level thread function_2743e62d1ee2024( struct );
        }
        
        level.ee_jump.sections_spawned[ i ] = 0;
    }
}

// Namespace zm_sat_hornet_ee_jump
// Params 1, eflags: 0x4
// Checksum 0x7d2890ab, Offset: 0x1aef
// Size: 0x148
function private function_2743e62d1ee2024( struct )
{
    if ( !struct.sbl )
    {
        return;
    }
    
    if ( !struct.e_mover )
    {
        struct.e_mover = utility::spawn_model( "tag_origin", struct.origin, struct.angles );
        struct.sbl scriptablesetparententity( struct.e_mover, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    }
    
    struct.e_mover notify( #"deleted" );
    var_ed210d837d9345e3 = struct.origin + ( 0, 0, -100 );
    struct.e_mover moveto( var_ed210d837d9345e3, 3, 0, 3 );
    struct.e_mover waittill( #"movedone" );
    
    if ( struct.e_mover )
    {
        struct.e_mover delete();
        struct.e_mover = undefined;
    }
    
    if ( struct.sbl )
    {
        struct.sbl freescriptable();
        struct.sbl = undefined;
    }
}

// Namespace zm_sat_hornet_ee_jump
// Params 1, eflags: 0x4
// Checksum 0xa1dd1fa2, Offset: 0x1c3f
// Size: 0x24e
function private function_9fad22591b22801b( player )
{
    level endon( #"game_ended" );
    level utility::flag_wait( "scriptables_ready" );
    
    if ( level.ee_jump.var_51ceb27be5ad76da || player.var_aa3f10d09e80b5e4 )
    {
        return;
    }
    
    if ( !level.ee_jump.var_a3016c925337f6fd )
    {
        function_ce4be9913b657948();
    }
    
    var_e73d24757f27e192 = function_b3cc7b0fe58eed15();
    var_e73d24757f27e192.sbl setscriptablepartstate( "model", "base_nocoll" );
    
    if ( !isdefined( var_e73d24757f27e192 ) )
    {
        return;
    }
    
    var_207a8ff68eea786b = utility::getstruct( var_e73d24757f27e192.target, "targetname" );
    var_e73d24757f27e192.var_6bca1ec7c00c2f9 = 1;
    level.ee_jump.n_active_rayguns++;
    coverup = spawnscriptable( %"zm_sat_hornet_oth_trail", var_207a8ff68eea786b.origin, var_e73d24757f27e192.angles );
    coverup setscriptablepartstate( "impact", "gold" );
    coverup utility::delaycall( 1, &freescriptable );
    spawnoptions = common_item::function_bc5ff2958b71a708( var_207a8ff68eea786b.origin, var_207a8ff68eea786b.angles );
    var_e73d24757f27e192.raygun_item = common_item::function_57b88e025e5fb03e( %"hash_5ccd4ffef24f2106", undefined, spawnoptions );
    
    foreach ( other_player in level.players )
    {
        if ( other_player != player )
        {
            var_e73d24757f27e192.raygun_item disablescriptableplayeruse( other_player );
        }
    }
    
    player.var_aa3f10d09e80b5e4 = 1;
    playsoundatpos( var_207a8ff68eea786b.origin, "evt_success_stinger" );
    level utility::callsharedfunc( #"hash_7305513195fadf7e", #"hash_15800b43a7bb4ab8", #"hash_f9f817db9f222614", [ player ] );
    level thread function_a3ab653580f7e44c( var_e73d24757f27e192, player );
}

// Namespace zm_sat_hornet_ee_jump
// Params 0, eflags: 0x4
// Checksum 0xa5abd707, Offset: 0x1e95
// Size: 0x1bb
function private function_ce4be9913b657948()
{
    randomized_array = arrayrandomize( level.ee_jump.end_komainu );
    
    foreach ( struct in randomized_array )
    {
        v_spawn_pos = struct.origin + ( 0, 0, -100 );
        struct.sbl = spawnscriptable( %"zm_sat_hornet_komainu", v_spawn_pos, struct.angles );
        struct.e_mover = utility::spawn_model( "tag_origin", v_spawn_pos, struct.angles );
        struct.sbl scriptablesetparententity( struct.e_mover, ( 0, 0, 0 ), ( 0, 0, 0 ) );
        dirt_sbl = spawnscriptable( "zm_sat_hornet_oth_trail", struct.origin, struct.angles );
        dirt_sbl setscriptablepartstate( "visual", "dirt_big" );
        dirt_sbl utility::delaycall( 3, &freescriptable );
        struct.e_mover moveto( struct.origin, 3, 0, 3 );
        wait randomfloatrange( 0.5, 1 );
    }
    
    wait 3;
    level.ee_jump.var_a3016c925337f6fd = 1;
}

// Namespace zm_sat_hornet_ee_jump
// Params 0, eflags: 0x4
// Checksum 0xe36d3b04, Offset: 0x2058
// Size: 0xad
function private function_b3cc7b0fe58eed15()
{
    a_available = [];
    
    foreach ( struct in level.ee_jump.end_komainu )
    {
        if ( !struct.var_6bca1ec7c00c2f9 )
        {
            a_available[ a_available.size ] = struct;
        }
    }
    
    if ( !a_available.size )
    {
        return;
    }
    
    return utility::array_random( a_available );
}

// Namespace zm_sat_hornet_ee_jump
// Params 2, eflags: 0x4
// Checksum 0x6d3ef7a4, Offset: 0x210e
// Size: 0xa5
function private function_a3ab653580f7e44c( s_komainu, player )
{
    level endon( #"game_ended" );
    
    while ( isdefined( s_komainu.raygun_item ) )
    {
        wait 0.5;
    }
    
    if ( isalive( player ) )
    {
        player thread function_b05bbc8d0f905e0f();
    }
    
    level zm_quest::function_4eefe6de31f5ddab( #"hornet_ee_jump", #"hash_ceb71db41fce625c", 1 );
    s_komainu.raygun_item = undefined;
    level.ee_jump.n_active_rayguns--;
    
    if ( level.ee_jump.n_active_rayguns <= 0 )
    {
        function_cc3db834083825d2();
    }
}

// Namespace zm_sat_hornet_ee_jump
// Params 0, eflags: 0x4
// Checksum 0x7533c3e2, Offset: 0x21bb
// Size: 0x29
function private function_b05bbc8d0f905e0f()
{
    self endon( #"death_or_disconnect" );
    self forceweaponinspect();
    namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( "hornet_hesd2_world_at_parkour_success", #"bc_flavor_player_positive" );
}

// Namespace zm_sat_hornet_ee_jump
// Params 0, eflags: 0x4
// Checksum 0x21c45aec, Offset: 0x21ec
// Size: 0x213
function private function_cc3db834083825d2()
{
    level endon( #"game_ended" );
    
    foreach ( struct in level.ee_jump.end_komainu )
    {
        if ( isdefined( struct.e_mover ) )
        {
            var_ed210d837d9345e3 = struct.origin + ( 0, 0, -100 );
            struct.e_mover moveto( var_ed210d837d9345e3, 3, 0, 3 );
            dirt_sbl = spawnscriptable( "zm_sat_hornet_oth_trail", struct.origin, struct.angles );
            dirt_sbl setscriptablepartstate( "visual", "dirt_big" );
            dirt_sbl utility::delaycall( 3, &freescriptable );
        }
    }
    
    wait 3;
    
    foreach ( struct in level.ee_jump.end_komainu )
    {
        if ( isdefined( struct.sbl ) )
        {
            struct.sbl freescriptable();
            struct.sbl = undefined;
        }
        
        if ( isdefined( struct.e_mover ) )
        {
            struct.e_mover delete();
            struct.e_mover = undefined;
        }
        
        struct.var_6bca1ec7c00c2f9 = undefined;
    }
    
    level.ee_jump.var_a3016c925337f6fd = undefined;
    level.ee_jump.n_active_rayguns = 0;
}

/#

    // Namespace zm_sat_hornet_ee_jump
    // Params 0, eflags: 0x4
    // Checksum 0xc121b715, Offset: 0x2407
    // Size: 0x4c, Type: dev
    function private register_cafe_devgui()
    {
        zm_quest::function_bc99f123a684344f( #"hornet_ee_jump" );
        devgui::add_devgui_func( "<dev string:x24>", "<dev string:x37>", &function_d12df97140315719, 1 );
        devgui::add_devgui_func( "<dev string:x40>", "<dev string:x58>", &function_9da175a4e2e00bba, 1 );
        zm_quest::function_c1400a2f4670c23f();
    }

    // Namespace zm_sat_hornet_ee_jump
    // Params 0, eflags: 0x4
    // Checksum 0xf4c5279, Offset: 0x245b
    // Size: 0x51, Type: dev
    function private function_d12df97140315719()
    {
        level utility::flag_wait( "<dev string:x63>" );
        a_structs = utility::getstructarray( "<dev string:x75>", "<dev string:x7c>" );
        
        for ( i = 0; i < 4 ; i++ )
        {
            level thread function_d3f9ed2c46cafd18( i );
        }
    }

    // Namespace zm_sat_hornet_ee_jump
    // Params 0, eflags: 0x4
    // Checksum 0x218693c, Offset: 0x24b4
    // Size: 0x18, Type: dev
    function private function_9da175a4e2e00bba()
    {
        level thread function_9fad22591b22801b( level.players[ 0 ] );
    }

#/
