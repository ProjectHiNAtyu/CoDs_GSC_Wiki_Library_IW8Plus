// script_6592742921d4bd1c  (hash_6592742921d4bd1c.gscc) (size: 17233 Bytes / 0x4351 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc69a562 (208250210)
// size ...... 17233 (0x4351)
// includes .. 17  (offset: 0x3ed1)
// strings ... 66  (offset: 0x3f59)
// dev strs .. 0   (offset: 0x4351)
// exports ... 37  (offset: 0x2995)
// cseg ...... 0x768 + 0x222d (0x2995)
// imports ... 125 (offset: 0x2f5d)
// animtree1 . 0   (offset: 0x4351)
// animtree2 . 0   (offset: 0x4351)
#using script_35efc59124dbb5db;
#using scripts\common\ai\aitypes\shared\zombie\zombie_cannonball;
#using scripts\common\ai\subclass_to_aitype_map;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\damage;
#using scripts\mp\electric_power_switch;
#using scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis;
#using scripts\mp\zm\systems\time_travel;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\zm_utility;

#namespace free_the_machine;

// Namespace free_the_machine
// Params 0
// Checksum 0xdfc7cee8, Offset: 0x786
// Size: 0x81
function init()
{
    utility::flag_init( #"hash_efc6bdef9b97fdc5" );
    function_fff8803f7fcc8087();
    data = { #var_7abdd9805d692624:0, #var_aad587c7e2c0ab0c:15, #var_3dcfee587d9412a7:0, #var_9f9432741e058419:setup_pap_machine() };
    level.mantis_pap_quest.var_1e5d963acb8a335e = data;
    setup_pap_machine_fight();
    utility::flag_set( #"hash_efc6bdef9b97fdc5" );
}

// Namespace free_the_machine
// Params 2
// Checksum 0x7ac29076, Offset: 0x80f
// Size: 0x5b
function execute( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    utility::flag_wait( #"hash_efc6bdef9b97fdc5" );
    level callback::add( "on_zombie_ai_killed", &function_b0ff1f884422adca );
    thread init_pap_machine_fight();
    utility::flag_wait_any( "papq_fight_done", "open_sesame" );
}

// Namespace free_the_machine
// Params 2
// Checksum 0x65138cc5, Offset: 0x872
// Size: 0xa2
function cleanup( skipped, save_restored )
{
    thread electric_power_switch::function_2d462dbfcc76b0db( 1 );
    thread zm_quest::cleanup_zombies_manually( 0, undefined, level.mantis_pap_quest.var_1e5d963acb8a335e.var_8d76a36eab2546bd.origin, 1200, 1, 1, 1 );
    namespace_a7211835085600d5::clear_objective_marks( #"mantis_pap_quest" );
    level val::reset( #"mantis_pap_quest", "task_logic_activate" );
    level zm_quest::update_round_cap( 5 );
    
    if ( save_restored )
    {
        return;
    }
    
    thread function_e9dafee5a9a5089c();
    function_700c24f8b93da0b6();
    free_pap_machine();
}

// Namespace free_the_machine
// Params 0, eflags: 0x4
// Checksum 0x2488ba0b, Offset: 0x91c
// Size: 0xe3
function private function_fff8803f7fcc8087()
{
    level._effect[ "vfx_sat_levels_zm_mantis_temporal_storm" ] = loadfxasset( "vfx_sat_levels_zm_mantis_temporal_storm" );
    level._effect[ "vfx_sat_levels_zm_mantis_temporal_storm_despawn" ] = loadfxasset( "vfx_sat_levels_zm_mantis_temporal_storm_despawn" );
    level._effect[ "vfx_sat_levels_zm_mantis_temporal_storm_knot_impact" ] = loadfxasset( "vfx_sat_levels_zm_mantis_temporal_storm_knot_impact" );
    level._effect[ "vfx_sat_levels_zm_mantis_temporal_storm_beam" ] = loadfxasset( "vfx_sat_levels_zm_mantis_temporal_storm_beam" );
    level._effect[ "vfx_sat_levels_zm_mantis_temporal_storm_knot_pulse" ] = loadfxasset( "vfx_sat_levels_zm_mantis_temporal_storm_knot_pulse" );
    level._effect[ "vfx_sat_levels_zm_mantis_temporal_storm_beam_zombie" ] = loadfxasset( "vfx_sat_levels_zm_mantis_temporal_storm_beam_zombie" );
    level._effect[ "vfx_sat_zm_mantis_papq_pap_ascend" ] = loadfxasset( "vfx_sat_zm_mantis_papq_pap_ascend" );
    level._effect[ "vfx_sat_zm_mantis_papq_pap_assemble" ] = loadfxasset( "vfx_sat_zm_mantis_papq_pap_assemble" );
    level._effect[ "vfx_sat_levels_zm_mantis_pap_machine_lands" ] = loadfxasset( "vfx_sat_levels_zm_mantis_pap_machine_lands" );
}

// Namespace free_the_machine
// Params 0, eflags: 0x4
// Checksum 0x35fa768a, Offset: 0xa07
// Size: 0x22
function private setup_pap_machine()
{
    function_979b1db26b3ca8f5();
    var_9f9432741e058419 = level.var_db52bcfd04d45a7a[ 0 ];
    return var_9f9432741e058419;
}

// Namespace free_the_machine
// Params 0, eflags: 0x4
// Checksum 0xbd363868, Offset: 0xa32
// Size: 0xc6
function private setup_pap_machine_fight()
{
    if ( zm_save::function_fcccc3d2a616b1c7() )
    {
        zm_save::function_1f44a48caae2acbf();
        
        if ( zm_quest::is_quest_complete( #"mantis_pap_quest" ) )
        {
            return;
        }
    }
    
    quest_data = level.mantis_pap_quest.var_1e5d963acb8a335e;
    var_9f9432741e058419 = quest_data.var_9f9432741e058419;
    var_9f9432741e058419.var_370acb837a3a86c3.origin += ( 0, 0, -300 );
    quest_data.pap_machine_fragments = function_187af229b6893149( var_9f9432741e058419 );
    quest_data.var_8d76a36eab2546bd = function_7dbfaf58607edfc5();
    function_eb31fb7ec12b761d();
    ascend_pap_machine();
}

// Namespace free_the_machine
// Params 1, eflags: 0x4
// Checksum 0x4f919627, Offset: 0xb00
// Size: 0xdd
function private function_187af229b6893149( var_9f9432741e058419 )
{
    pap_machine_fragments = [];
    
    foreach ( model in [ "sat_zm_pap_clean_panel", "sat_zm_pap_clean_top_gears", "sat_zm_pap_clean_bottom_gears", "sat_zm_pap_clean_body" ] )
    {
        fragment = utility::spawn_model( model, var_9f9432741e058419.origin, var_9f9432741e058419.angles );
        time_travel::register_timetravel_entity( fragment );
        pap_machine_fragments[ pap_machine_fragments.size ] = fragment;
    }
    
    return pap_machine_fragments;
}

// Namespace free_the_machine
// Params 0
// Checksum 0x9103ce3c, Offset: 0xbe6
// Size: 0x1e
function function_979b1db26b3ca8f5()
{
    if ( level.var_db52bcfd04d45a7a.size == 0 )
    {
        level waittill( #"hash_3c00bc13d8b0818d" );
    }
}

// Namespace free_the_machine
// Params 0, eflags: 0x4
// Checksum 0xbde32b89, Offset: 0xc0c
// Size: 0x7d
function private function_7dbfaf58607edfc5()
{
    var_12c88f1e8c5a4992 = utility::getstruct( "zm_sat_mantis_papq_storm", "targetname" );
    var_8d76a36eab2546bd = spawnfx( utility::getfx( "vfx_sat_levels_zm_mantis_temporal_storm" ), var_12c88f1e8c5a4992.origin, anglestoforward( var_12c88f1e8c5a4992.angles ) );
    var_8d76a36eab2546bd.node = var_12c88f1e8c5a4992;
    time_travel::register_timetravel_entity( var_8d76a36eab2546bd );
    var_8d76a36eab2546bd callback::add( "timetravel_entity_done", &function_eb31fb7ec12b761d );
    return var_8d76a36eab2546bd;
}

// Namespace free_the_machine
// Params 1, eflags: 0x4
// Checksum 0x73b4ece6, Offset: 0xc92
// Size: 0x3c
function private function_eb31fb7ec12b761d( params )
{
    var_8d76a36eab2546bd = level.mantis_pap_quest.var_1e5d963acb8a335e.var_8d76a36eab2546bd;
    triggerfx( var_8d76a36eab2546bd );
}

// Namespace free_the_machine
// Params 0, eflags: 0x4
// Checksum 0x33bf3b4c, Offset: 0xcd6
// Size: 0xb9
function private function_e9dafee5a9a5089c()
{
    var_8d76a36eab2546bd = level.mantis_pap_quest.var_1e5d963acb8a335e.var_8d76a36eab2546bd;
    var_2f433106230d5977 = utility::spawn_model( "tag_origin", var_8d76a36eab2546bd.origin );
    waitframe();
    playfxontag( utility::getfx( "vfx_sat_levels_zm_mantis_temporal_storm" ), var_2f433106230d5977, "tag_origin" );
    waitframe();
    stopfxontag( utility::getfx( "vfx_sat_levels_zm_mantis_temporal_storm" ), var_2f433106230d5977, "tag_origin" );
    playfx( utility::getfx( "vfx_sat_levels_zm_mantis_temporal_storm_despawn" ), var_8d76a36eab2546bd.origin );
    playsoundatpos( var_8d76a36eab2546bd.origin, "evt_temporal_storm_despawn" );
    var_8d76a36eab2546bd delete();
    var_2f433106230d5977 delete();
}

// Namespace free_the_machine
// Params 1, eflags: 0x4
// Checksum 0x70f0cd97, Offset: 0xd97
// Size: 0x131
function private function_8bf361d1bd324adb( var_8d76a36eab2546bd )
{
    var_8aa6ddf83738d4d9 = utility::getstructarray( "zm_sat_mantis_papq_storm_knot", "targetname" );
    var_46ce226951425b83 = [];
    
    foreach ( var_6c344b95777da9c7 in var_8aa6ddf83738d4d9 )
    {
        knot = utility::spawn_model( "sat_zm_mantis_papq_knot", var_8d76a36eab2546bd.origin, var_6c344b95777da9c7.angles );
        knot setscriptablepartstate( "body", "spawn" );
        knot.node = var_6c344b95777da9c7;
        knot.orbit_offset = var_6c344b95777da9c7.origin - var_8d76a36eab2546bd.node.origin;
        knot.orbit_speed = 15;
        time_travel::register_timetravel_entity( knot );
        var_46ce226951425b83[ var_46ce226951425b83.size ] = knot;
    }
    
    return var_46ce226951425b83;
}

// Namespace free_the_machine
// Params 0, eflags: 0x4
// Checksum 0x17f40d7e, Offset: 0xed1
// Size: 0x13e
function private function_700c24f8b93da0b6()
{
    var_46ce226951425b83 = level.mantis_pap_quest.var_1e5d963acb8a335e.var_46ce226951425b83;
    
    foreach ( var_aefb555866741102 in var_46ce226951425b83 )
    {
        if ( isdefined( var_aefb555866741102.beam ) )
        {
            var_aefb555866741102.beam delete();
        }
        
        if ( isdefined( var_aefb555866741102.zombie_beams ) )
        {
            foreach ( beam in var_aefb555866741102.zombie_beams )
            {
                beam delete();
            }
        }
        
        var_aefb555866741102 delete();
    }
}

// Namespace free_the_machine
// Params 0, eflags: 0x4
// Checksum 0x8d571e0e, Offset: 0x1017
// Size: 0x3d
function private init_pap_machine_fight()
{
    level endon( #"papq_end" );
    quest_data = level.mantis_pap_quest.var_1e5d963acb8a335e;
    function_825b088cf71f1f22();
    function_f70484cecd0a1df9( quest_data );
}

// Namespace free_the_machine
// Params 0, eflags: 0x4
// Checksum 0x4d3e35ca, Offset: 0x105c
// Size: 0x1a9
function private function_825b088cf71f1f22()
{
    var_8d76a36eab2546bd = level.mantis_pap_quest.var_1e5d963acb8a335e.var_8d76a36eab2546bd;
    var_9f9432741e058419 = level.mantis_pap_quest.var_1e5d963acb8a335e.var_9f9432741e058419;
    
    if ( !level zm_sat_mantis::function_80daf2f20b4e6e6d() && isdefined( var_8d76a36eab2546bd ) )
    {
        objective_mark = namespace_a7211835085600d5::add_objective_mark( #"mantis_pap_quest", var_8d76a36eab2546bd, "papq_fight", 100, 0 );
    }
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) || !isdefined( var_9f9432741e058419.var_370acb837a3a86c3 ) )
            {
                continue;
            }
            
            if ( distance2d( player.origin, var_9f9432741e058419.var_370acb837a3a86c3.origin ) <= 1200 )
            {
                if ( isdefined( objective_mark ) )
                {
                    zm_quest::complete_objective_waypoints( objective_mark );
                }
                
                playsoundatpos( var_9f9432741e058419.var_370acb837a3a86c3.origin, "dx_zm_ffet_esdt_ltwn_ffesdtsgn" );
                playsoundatpos( var_9f9432741e058419.var_370acb837a3a86c3.origin, "dx_zm_ffet_esdt_dtwn_ffesdtsgn" );
                var_9f9432741e058419.var_370acb837a3a86c3 playloopsound( "mus_mantis_underscore_pap" );
                return;
            }
        }
        
        wait 1;
    }
}

// Namespace free_the_machine
// Params 0, eflags: 0x4
// Checksum 0xe92e434d, Offset: 0x120d
// Size: 0x148
function private ascend_pap_machine()
{
    quest_data = level.mantis_pap_quest.var_1e5d963acb8a335e;
    var_9f9432741e058419 = quest_data.var_9f9432741e058419;
    pap_machine_fragments = quest_data.pap_machine_fragments;
    var_8d76a36eab2546bd = level.mantis_pap_quest.var_1e5d963acb8a335e.var_8d76a36eab2546bd;
    var_9f9432741e058419.var_370acb837a3a86c3 setscriptablepartstate( "minimap_icon", "idle" );
    playfx( utility::getfx( "vfx_sat_zm_mantis_papq_pap_ascend" ), var_9f9432741e058419.origin );
    
    foreach ( fragment in pap_machine_fragments )
    {
        fragment function_a82ad42c0dcf465d( 250, 4.5, 2 );
        fragment moveto( var_8d76a36eab2546bd.origin, 4.5, 2 );
        fragment thread function_dbde4441d5dd52a();
        wait 0.2;
    }
}

// Namespace free_the_machine
// Params 0, eflags: 0x4
// Checksum 0x3cc5ca81, Offset: 0x135d
// Size: 0x3d
function private function_dbde4441d5dd52a()
{
    level endon( #"papq_end" );
    self waittill( #"movedone" );
    
    while ( true )
    {
        function_a82ad42c0dcf465d( 150, 5, 0, 0 );
        self waittill( #"rotatedone" );
    }
}

// Namespace free_the_machine
// Params 1, eflags: 0x4
// Checksum 0x113c00ec, Offset: 0x13a2
// Size: 0x17d
function private function_f70484cecd0a1df9( quest_data )
{
    var_8d76a36eab2546bd = quest_data.var_8d76a36eab2546bd;
    var_46ce226951425b83 = function_8bf361d1bd324adb( var_8d76a36eab2546bd );
    quest_data.var_46ce226951425b83 = var_46ce226951425b83;
    
    for ( i = 0; i < var_46ce226951425b83.size ; i++ )
    {
        knot = var_46ce226951425b83[ i ];
        knot.beam_offset = vectornormalize( knot.node.origin - var_8d76a36eab2546bd.node.origin ) * 85;
        knot.beam = function_f5f8abcd7522eee2( utility::getfx( "vfx_sat_levels_zm_mantis_temporal_storm_beam" ), var_8d76a36eab2546bd.origin + knot.beam_offset, knot.origin );
        knot setscriptablepartstate( "body", "spawn" );
        knot thread damage::monitordamage( getdvarint( @"hash_d37b2335f30a90f", 200 ), "hithealth", &function_11fc03df4121898d, &function_cdd24ec41f303fc2 );
        damage_utility::register_damageable_entity( knot, zm_utility::get_zombie_team() );
        knot thread function_73f96b4ccb85146a( quest_data );
        knot thread function_55ce2482f767917b( quest_data );
        
        if ( !level zm_sat_mantis::function_80daf2f20b4e6e6d() && isdefined( knot ) )
        {
            knot.objective_mark = namespace_a7211835085600d5::add_objective_mark( #"mantis_pap_quest", knot, "papq_fight", 100, 0 );
        }
        
        wait 0.1;
    }
}

// Namespace free_the_machine
// Params 1, eflags: 0x4
// Checksum 0x73bbbd64, Offset: 0x1527
// Size: 0x78
function private function_73f96b4ccb85146a( quest_data )
{
    level endon( #"papq_end" );
    self endon( #"hash_32bf64017c828e1c" );
    var_8d76a36eab2546bd = quest_data.var_8d76a36eab2546bd;
    
    while ( isdefined( self.beam ) )
    {
        self.beam function_13a61377e568d700( var_8d76a36eab2546bd.origin + self.beam_offset, self.origin );
        waitframe();
    }
}

// Namespace free_the_machine
// Params 1, eflags: 0x4
// Checksum 0xed5c4f59, Offset: 0x15a7
// Size: 0xcb
function private function_55ce2482f767917b( quest_data )
{
    level endon( #"papq_end" );
    self endon( #"hash_c1562de35331dc9a" );
    var_8d76a36eab2546bd = quest_data.var_8d76a36eab2546bd;
    time = randomfloat( quest_data.var_aad587c7e2c0ab0c );
    
    while ( true )
    {
        curve_pos = math::function_8e0d0a2392b676f2( time, 15, 5, 10, 2, 3, 5 );
        target_position = var_8d76a36eab2546bd.origin + self.orbit_offset + curve_pos;
        self.origin = target_position;
        time += level.framedurationseconds * quest_data.var_aad587c7e2c0ab0c;
        wait level.framedurationseconds;
    }
}

// Namespace free_the_machine
// Params 4, eflags: 0x4
// Checksum 0x24d98f3e, Offset: 0x167a
// Size: 0x86
function private function_a82ad42c0dcf465d( rotation_degrees, var_4dfec929b4a0bad4, rotation_time_acc = 0, rotation_time_dec = 0 )
{
    pitch = ( randomint( 2 ) == 0 ? 1 : -1 ) * rotation_degrees;
    yaw = ( randomint( 2 ) == 0 ? 1 : -1 ) * rotation_degrees;
    self rotateby( ( pitch, yaw, 0 ), var_4dfec929b4a0bad4, rotation_time_acc, rotation_time_dec );
}

// Namespace free_the_machine
// Params 1, eflags: 0x4
// Checksum 0x751e117, Offset: 0x1708
// Size: 0x52
function private function_cdd24ec41f303fc2( data )
{
    if ( level.mantis_pap_quest.var_1e5d963acb8a335e.var_7abdd9805d692624 )
    {
        return 0;
    }
    
    playfx( utility::getfx( "vfx_sat_levels_zm_mantis_temporal_storm_knot_impact" ), self.origin );
    return data.damage;
}

// Namespace free_the_machine
// Params 1, eflags: 0x4
// Checksum 0x6e7603f3, Offset: 0x1763
// Size: 0x1d7
function private function_11fc03df4121898d( params )
{
    level endon( #"papq_end" );
    self endon( #"hash_32bf64017c828e1c" );
    data = level.mantis_pap_quest.var_1e5d963acb8a335e;
    is_first_knot = data.var_3dcfee587d9412a7 == 0;
    namespace_a7211835085600d5::clear_objective_marks( #"mantis_pap_quest" );
    lock_knots( self );
    
    if ( is_first_knot )
    {
        params.attacker thread function_cada59450a849aef();
    }
    
    thread cannonball_zombies( getdvarint( @"hash_5964fab32d307bc3", 4 ) );
    function_15ee4021447d3702();
    damage::monitordamageend();
    damage_utility::function_b84e11c8ca9801fe( self, zm_utility::get_zombie_team() );
    self setscriptablepartstate( "body", "destroyed" );
    wait 0.5;
    self.beam delete();
    
    if ( isdefined( self.zombie_beams ) )
    {
        foreach ( beam in self.zombie_beams )
        {
            beam delete();
        }
    }
    
    free_knots();
    
    if ( is_first_knot )
    {
        thread function_b6a441fa38cafe67( self.origin );
    }
    
    data.var_3dcfee587d9412a7++;
    
    if ( data.var_3dcfee587d9412a7 == data.var_46ce226951425b83.size )
    {
        params.attacker thread function_4490584d75d52fef( self.origin );
        utility::flag_set( "papq_fight_done" );
    }
    
    self notify( #"hash_32bf64017c828e1c" );
}

// Namespace free_the_machine
// Params 1, eflags: 0x4
// Checksum 0xf66d8961, Offset: 0x1942
// Size: 0x165
function private lock_knots( disrupted_knot )
{
    quest_data = level.mantis_pap_quest.var_1e5d963acb8a335e;
    quest_data.var_7abdd9805d692624 = 1;
    quest_data.var_aad587c7e2c0ab0c = 30;
    
    foreach ( knot in quest_data.var_46ce226951425b83 )
    {
        if ( knot getscriptablepartstate( "body" ) == "destroyed" )
        {
            continue;
        }
        
        knot setscriptablepartstate( "body", "locked" );
        knot notify( #"hash_c1562de35331dc9a" );
        waitframe();
        
        if ( knot != disrupted_knot )
        {
            playfx( utility::getfx( "vfx_sat_levels_zm_mantis_temporal_storm_knot_impact" ), knot.origin );
            knot playsoundonmovingent( "evt_temporal_storm_lock_knots" );
            knot.orbit_offset = disrupted_knot.orbit_offset;
            knot moveby( disrupted_knot.origin - knot.origin, 0.1 );
            wait 0.1;
            knot thread function_55ce2482f767917b( quest_data );
        }
    }
}

// Namespace free_the_machine
// Params 0, eflags: 0x4
// Checksum 0x4cc3e386, Offset: 0x1aaf
// Size: 0x1a3
function private free_knots()
{
    quest_data = level.mantis_pap_quest.var_1e5d963acb8a335e;
    quest_data.var_7abdd9805d692624 = 0;
    quest_data.var_aad587c7e2c0ab0c = 15;
    
    foreach ( knot in quest_data.var_46ce226951425b83 )
    {
        if ( knot getscriptablepartstate( "body" ) == "destroyed" )
        {
            continue;
        }
        
        knot setscriptablepartstate( "body", "healthy" );
        knot notify( #"hash_c1562de35331dc9a" );
        waitframe();
        knot playsoundonmovingent( "evt_temporal_storm_free_knots" );
        knot.orbit_offset = knot.node.origin - quest_data.var_8d76a36eab2546bd.node.origin;
        knot moveby( knot.node.origin - knot.origin, 0.1 );
        wait 0.1;
        knot thread function_55ce2482f767917b( quest_data );
        
        if ( !level zm_sat_mantis::function_80daf2f20b4e6e6d() && isdefined( knot ) )
        {
            knot.objective_mark = namespace_a7211835085600d5::add_objective_mark( #"mantis_pap_quest", knot, "papq_fight", 100, 0 );
        }
    }
}

// Namespace free_the_machine
// Params 1, eflags: 0x4
// Checksum 0xa067737b, Offset: 0x1c5a
// Size: 0x2ec
function private cannonball_zombies( amount )
{
    level endon( #"papq_end" );
    quest_data = level.mantis_pap_quest.var_1e5d963acb8a335e;
    utility::flag_set( "papq_cannonball_zombies_active" );
    
    for ( i = amount; i > 0 ; i-- )
    {
        if ( utility::flag( "timetravel_ongoing" ) )
        {
            level waittill( #"timetravel_done" );
        }
        
        playfx( utility::getfx( "vfx_sat_levels_zm_mantis_temporal_storm_knot_pulse" ), self.origin );
        playsoundatpos( self.origin, "evt_temporal_storm_knot_pulse_spawn_zombie" );
        zombie_aitype = undefined;
        current_timeline = level.timetravel.timeline.name;
        
        if ( current_timeline != "past" )
        {
            zombie_aitype = function_b3988325430ce242( "zombie_base" );
        }
        else
        {
            zombie_aitype = subclass_to_aitype_map::function_427ae77ce1056e01( "zombie_base", "stam_zm_sat_mantis_past" );
        }
        
        zombie = zm_quest::spawn_zombies_at_location( zombie_aitype, self.origin, 1, 0, undefined, 1, undefined, 1 )[ 0 ];
        zombie val::set( #"mantis_pap_quest", "damage", 0 );
        zombie val::set( #"mantis_pap_quest", "allow_brot", 0 );
        waitframe();
        
        if ( !isdefined( zombie ) )
        {
            amount++;
            continue;
        }
        
        zombie.b_ignore_mary_paris = 1;
        zombie.var_aefb555866741102 = self;
        zombie thread function_b2c8080802968641( self );
        time_travel::register_timetravel_entity( zombie );
        zombie utility::function_7c10ea82c1e305b8( "base", "base_purple_eyes" );
        zombie setorigin( self.origin );
        target_position = quest_data.var_9f9432741e058419.origin + anglestoforward( quest_data.var_9f9432741e058419.angles ) * 600;
        target_position = utility::getrandompointincircle( target_position, 120 );
        launch_direction = target_position - self.origin;
        beam_target = zombie function_a18b43656e601486();
        beam = function_f5f8abcd7522eee2( utility::getfx( "vfx_sat_levels_zm_mantis_temporal_storm_beam_zombie" ), zombie gettagorigin( beam_target, 1 ) ?? zombie.origin, self.origin );
        
        if ( !isdefined( self.zombie_beams ) )
        {
            self.zombie_beams = [];
        }
        
        self.zombie_beams[ self.zombie_beams.size ] = beam;
        zombie.beam = beam;
        zombie thread function_6cb208e0d80a9c4e( self );
        zombie thread zombie_cannonball::cannonball_ai( launch_direction, 600, zombie_cannonball::adv_settings( 1, 40, 0, 300 ), "roll_forward" );
        wait 1;
        zombie val::set( #"mantis_pap_quest", "damage", 1 );
    }
    
    utility::flag_clear( "papq_cannonball_zombies_active" );
}

// Namespace free_the_machine
// Params 0, eflags: 0x4
// Checksum 0x2fc3e0e5, Offset: 0x1f4e
// Size: 0x37
function private function_a18b43656e601486()
{
    if ( isdefined( self.model ) )
    {
        return ( modelhastag( self.model, "j_spineupper" ) ? "j_spineupper" : "tag_origin" );
    }
    
    return "tag_origin";
}

// Namespace free_the_machine
// Params 1, eflags: 0x4
// Checksum 0x1eb35b57, Offset: 0x1f8e
// Size: 0x99
function private function_6cb208e0d80a9c4e( var_aefb555866741102 )
{
    level endon( #"papq_end" );
    self endon( #"death" );
    
    while ( isdefined( self.beam ) )
    {
        beam_target = function_a18b43656e601486();
        
        if ( !isdefined( beam_target ) && isdefined( self.beam ) )
        {
            self.beam delete();
            return;
        }
        
        self.beam function_13a61377e568d700( self gettagorigin( beam_target, 1 ) ?? self.origin, var_aefb555866741102.origin );
        waitframe();
    }
}

// Namespace free_the_machine
// Params 1, eflags: 0x4
// Checksum 0x75ee4fc9, Offset: 0x202f
// Size: 0x5c
function private function_b2c8080802968641( var_aefb555866741102 )
{
    level endon( #"papq_end" );
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        if ( distancesquared( self.origin, var_aefb555866741102.origin ) > squared( 1200 ) )
        {
            self kill( undefined, var_aefb555866741102 );
            return;
        }
        
        wait 1;
    }
}

// Namespace free_the_machine
// Params 0, eflags: 0x4
// Checksum 0xf240c66c, Offset: 0x2093
// Size: 0x134
function private function_15ee4021447d3702()
{
    self.var_f109c8ae1b7b81e0 = 0;
    
    while ( isdefined( self ) && self.var_f109c8ae1b7b81e0 < getdvarint( @"hash_5964fab32d307bc3", 4 ) )
    {
        wait 1;
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        remaining_zombies = 0;
        near_zombies = getaiarrayinradius( self.origin, 1300, "team_two_hundred" );
        
        foreach ( zombie in near_zombies )
        {
            if ( isdefined( zombie.var_aefb555866741102 ) )
            {
                remaining_zombies++;
            }
        }
        
        if ( remaining_zombies == 0 && self.var_f109c8ae1b7b81e0 < getdvarint( @"hash_5964fab32d307bc3", 4 ) && !utility::flag( "papq_cannonball_zombies_active" ) )
        {
            thread cannonball_zombies( getdvarint( @"hash_5964fab32d307bc3", 4 ) - self.var_f109c8ae1b7b81e0 );
        }
    }
}

// Namespace free_the_machine
// Params 1, eflags: 0x4
// Checksum 0xf8cd84c3, Offset: 0x21cf
// Size: 0x87
function private function_b0ff1f884422adca( params )
{
    if ( !isdefined( self.var_aefb555866741102 ) )
    {
        return;
    }
    
    namespace_a7211835085600d5::clear_objective_marks( #"mantis_pap_quest" );
    
    if ( isdefined( self.beam ) )
    {
        self.beam delete();
    }
    
    if ( params.eattacker != self.var_aefb555866741102 )
    {
        self.var_aefb555866741102.var_f109c8ae1b7b81e0++;
        return;
    }
    
    self.var_aefb555866741102 thread cannonball_zombies( 1 );
}

// Namespace free_the_machine
// Params 0, eflags: 0x4
// Checksum 0xb1762134, Offset: 0x225e
// Size: 0x4fe
function private free_pap_machine()
{
    level notify( #"papq_end" );
    data = level.mantis_pap_quest.var_1e5d963acb8a335e;
    pap_machine_struct = data.var_9f9432741e058419;
    var_9f9432741e058419 = pap_machine_struct.var_370acb837a3a86c3;
    pap_machine_fragments = data.pap_machine_fragments;
    var_12c88f1e8c5a4992 = utility::getstruct( "zm_sat_mantis_papq_storm", "targetname" );
    var_8aa6ddf83738d4d9 = utility::getstructarray( "zm_sat_mantis_papq_storm_knot", "targetname" );
    
    for ( i = 0; i < pap_machine_fragments.size ; i++ )
    {
        target_offset = vectornormalize( var_8aa6ddf83738d4d9[ i ].origin - var_12c88f1e8c5a4992.origin ) * 120;
        pap_machine_fragments[ i ] moveby( target_offset, 0.8, 0.1, 0.5 );
    }
    
    wait 1.2;
    playsoundatpos( pap_machine_struct.origin + ( 0, 0, 100 ), "evt_quest_pap_flying_down" );
    
    for ( i = 0; i < pap_machine_fragments.size ; i++ )
    {
        fragment = pap_machine_fragments[ i ];
        decc_time = i == pap_machine_fragments.size - 1 ? 1 : 0;
        fragment moveby( pap_machine_struct.origin + ( 0, 0, 100 ) / 2 - fragment.origin, 4, 0, 2 );
        fragment rotateto( pap_machine_struct.angles + ( -65, 0, 0 ), 2, 1, decc_time );
    }
    
    wait 2;
    
    foreach ( fragment in pap_machine_fragments )
    {
        fragment rotateto( pap_machine_struct.angles, 2, 0, 1 );
    }
    
    wait 2;
    playsoundatpos( pap_machine_struct.origin + ( 0, 0, 100 ), "evt_quest_pap_assemble" );
    
    if ( !var_9f9432741e058419 )
    {
        return;
    }
    
    var_9f9432741e058419 teleportentity( pap_machine_fragments[ 0 ].origin, pap_machine_struct.angles );
    var_9f9432741e058419 setscriptablepartstate( "minimap_icon", "active" );
    
    foreach ( fragment in pap_machine_fragments )
    {
        fragment delete();
    }
    
    waitframe();
    playfxontag( utility::getfx( "vfx_sat_zm_mantis_papq_pap_assemble" ), var_9f9432741e058419, "tag_origin" );
    wait 0.3;
    
    if ( !var_9f9432741e058419 )
    {
        return;
    }
    
    var_9f9432741e058419 moveby( pap_machine_struct.origin + ( 0, 0, 150 ) - var_9f9432741e058419.origin, 2, 1, 1 );
    wait 2;
    
    if ( !var_9f9432741e058419 )
    {
        return;
    }
    
    var_9f9432741e058419 moveby( pap_machine_struct.origin - var_9f9432741e058419.origin, 0.1 );
    wait 0.1;
    playfx( utility::getfx( "vfx_sat_levels_zm_mantis_pap_machine_lands" ), pap_machine_struct.origin, anglestoforward( pap_machine_struct.angles ) );
    playsoundatpos( var_9f9432741e058419.origin, "evt_quest_pap_move_land" );
    var_9f9432741e058419 stoploopsound( "mus_mantis_underscore_pap" );
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"hash_f65352c5c3ebcf80" );
    players_in_radius = getplayersinradius( pap_machine_struct.origin, 150, 800 );
    
    foreach ( player in players_in_radius )
    {
        direction = anglestoforward( pap_machine_struct.angles );
        player setorigin( getclosestpointonnavmesh( player.origin + direction * 50 + ( 0, 0, 20 ) ), 0 );
    }
    
    namespace_a7211835085600d5::function_e524e3a82390272( pap_machine_struct.origin, 150 );
    zm_utility::function_1d82e63812f9640a( pap_machine_struct.origin, 400, 1 );
    show_pap_machine_collision();
}

// Namespace free_the_machine
// Params 0
// Checksum 0x2894e375, Offset: 0x2764
// Size: 0xbf
function show_pap_machine_collision()
{
    var_f2109b375eb10ff5 = utility::getent_or_struct_array( "pap_collision", "script_noteworthy" );
    
    if ( !isdefined( var_f2109b375eb10ff5 ) || var_f2109b375eb10ff5.size <= 0 )
    {
        iprintlnbold( "WARNING: No pap_collision entities found in show_pap_machine_collision." );
        return;
    }
    
    foreach ( pap_machine_collision_ent in var_f2109b375eb10ff5 )
    {
        if ( !isdefined( pap_machine_collision_ent ) )
        {
            continue;
        }
        
        pap_machine_collision_ent disconnectpaths();
        pap_machine_collision_ent solid();
        pap_machine_collision_ent show();
    }
}

// Namespace free_the_machine
// Params 0, eflags: 0x4
// Checksum 0x66746e26, Offset: 0x282b
// Size: 0x28
function private function_cada59450a849aef()
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    wait 1;
    zm_vo::function_8c1a12974bd11f01( #"hash_19bacff8f9d68592", #"hash_5212ed7ec42f115a" );
}

// Namespace free_the_machine
// Params 1, eflags: 0x4
// Checksum 0x528bdf32, Offset: 0x285b
// Size: 0x72
function private function_b6a441fa38cafe67( location )
{
    utility::flag_waitopen_all_array( [ "mantis_vo_twins_banter_active", "end_of_round_vo_playing" ] );
    utility::flag_set( "mantis_vo_twins_banter_active" );
    twins_banter = randomint( 2 );
    
    if ( twins_banter == 0 )
    {
        playsoundatpos( location, "dx_zm_mpwp_mapp_lvtw_mpp2ntkn1st" );
    }
    else
    {
        playsoundatpos( location, "dx_zm_mpwp_mapp_detw_mpp2ntkn1st" );
    }
    
    utility::flag_clear( "mantis_vo_twins_banter_active" );
}

// Namespace free_the_machine
// Params 1, eflags: 0x4
// Checksum 0xb04b3f7b, Offset: 0x28d5
// Size: 0xc0
function private function_4490584d75d52fef( location )
{
    wait 2;
    
    if ( isplayer( self ) )
    {
        zm_vo::function_8c1a12974bd11f01( #"hash_5dc84c538a9da0b6", #"bc_flavor_player_positive" );
    }
    
    wait 4;
    utility::flag_waitopen_all_array( [ "mantis_vo_twins_banter_active", "end_of_round_vo_playing" ] );
    utility::flag_set( "mantis_vo_twins_banter_active" );
    twins_banter = randomint( 2 );
    
    if ( twins_banter == 0 )
    {
        playsoundatpos( location, "dx_zm_mpwp_mapp_lvtw_mpp2acppra1ln1" );
        wait 3;
        playsoundatpos( location, "dx_zm_mpwp_mapp_detw_mpp2acppra1ln2" );
        wait 2;
    }
    else
    {
        playsoundatpos( location, "dx_zm_mpwp_mapp_detw_mpp2acppra2ln1" );
        wait 6.5;
        playsoundatpos( location, "dx_zm_mpwp_mapp_lvtw_mpp2acppra2ln2" );
        wait 4;
    }
    
    utility::flag_clear( "mantis_vo_twins_banter_active" );
}

