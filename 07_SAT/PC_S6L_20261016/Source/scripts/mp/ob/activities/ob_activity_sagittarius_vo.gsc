// scripts\mp\ob\activities\ob_activity_sagittarius_vo.gsc  (hash_7eec43ec23035126.gscc) (size: 6683 Bytes / 0x1a1b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xaa3bc5a0 (2856043936)
// size ...... 6683 (0x1a1b)
// includes .. 3   (offset: 0x17d3)
// strings ... 46  (offset: 0x17eb)
// dev strs .. 0   (offset: 0x1a1b)
// exports ... 19  (offset: 0x102b)
// cseg ...... 0x3e2 + 0xc49 (0x102b)
// imports ... 39  (offset: 0x1323)
// animtree1 . 0   (offset: 0x1a1b)
// animtree2 . 0   (offset: 0x1a1b)
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\overlord;

#namespace ob_activity_sagittarius_vo;

// Namespace ob_activity_sagittarius_vo
// Params 1
// Checksum 0xafa00019, Offset: 0x400
// Size: 0x22
function function_3a6b015435485777( vo_events )
{
    return { #current_index:0, #vo_events:vo_events };
}

// Namespace ob_activity_sagittarius_vo
// Params 3
// Checksum 0x1babc2f9, Offset: 0x42b
// Size: 0x9e
function function_b3c7509b373055bc( vo_struct, players, delay )
{
    chosenevent = vo_struct.vo_events[ vo_struct.current_index ];
    vo_struct.current_index++;
    
    if ( vo_struct.current_index == vo_struct.vo_events.size )
    {
        vo_struct.vo_events = arrayrandomize( vo_struct.vo_events );
        vo_struct.current_index = 0;
    }
    
    overlord::playevent( chosenevent, players, delay, 0, 1 );
}

// Namespace ob_activity_sagittarius_vo
// Params 6
// Checksum 0xf8211b46, Offset: 0x4d1
// Size: 0x76
function function_f19b17747f2036c4( var_f846f108eb9c140d, min_wait_time, max_wait_time, mission_struct_endon_flag, var_cd7e11dc688992d4, var_64bb57aa2d6e8b35 )
{
    var_cd7e11dc688992d4 endon( mission_struct_endon_flag );
    nag_vo_struct = function_3a6b015435485777( var_f846f108eb9c140d );
    
    while ( true )
    {
        wait randomfloatrange( min_wait_time, max_wait_time );
        function_b3c7509b373055bc( nag_vo_struct, var_64bb57aa2d6e8b35.players );
    }
}

// Namespace ob_activity_sagittarius_vo
// Params 3
// Checksum 0xf5d3962d, Offset: 0x54f
// Size: 0x10a
function function_69bfa840c2e7f264( boss_agent, var_cd7e11dc688992d4, var_64bb57aa2d6e8b35 )
{
    boss_agent endon( #"death" );
    boss_agent waittill( #"hash_1466dc16c6fac9d9" );
    childthread bossspotted( var_cd7e11dc688992d4, boss_agent, var_64bb57aa2d6e8b35 );
    overlord::playconversation( "wheres_the_sniper", var_64bb57aa2d6e8b35.players );
    overlord::playevent( "were_targets_out_here", var_64bb57aa2d6e8b35.players, undefined, 0, 0 );
    var_cd7e11dc688992d4 utility::ent_flag_wait( "hologram_scanned" );
    overlord::playevent( "priya_first_trace", var_64bb57aa2d6e8b35.players, undefined, 0, 0 );
    thread function_c20f0de530b322a7( var_cd7e11dc688992d4, var_64bb57aa2d6e8b35 );
    childthread overlord::playconversation( "im_the_one_youre_looking_for", var_64bb57aa2d6e8b35.players, 8 );
    childthread function_faf1c93b82438d5( var_cd7e11dc688992d4, boss_agent, var_64bb57aa2d6e8b35 );
    childthread function_de201adab67e8a8e( var_cd7e11dc688992d4, boss_agent, var_64bb57aa2d6e8b35 );
    childthread function_c4207508491de5cf( var_cd7e11dc688992d4, var_64bb57aa2d6e8b35 );
    childthread function_d938710d55524d6e( var_cd7e11dc688992d4, var_64bb57aa2d6e8b35, boss_agent );
    childthread function_39a0e215431e2484( boss_agent, var_64bb57aa2d6e8b35 );
    childthread function_1d0fcc54090fae6c( boss_agent, var_64bb57aa2d6e8b35 );
    childthread function_b79d01dfa450e80f( var_cd7e11dc688992d4, var_64bb57aa2d6e8b35, boss_agent );
}

// Namespace ob_activity_sagittarius_vo
// Params 2, eflags: 0x4
// Checksum 0x9eeed440, Offset: 0x661
// Size: 0x65
function private function_c20f0de530b322a7( var_cd7e11dc688992d4, var_64bb57aa2d6e8b35 )
{
    var_cd7e11dc688992d4 utility::ent_flag_clear( "hologram_scanned" );
    var_cd7e11dc688992d4 utility::ent_flag_wait( "hologram_scanned" );
    overlord::playevent( "priya_located_1", var_64bb57aa2d6e8b35.players, undefined, 0, 0 );
    thread overlord::playconversation( "priya_kagan_calls", var_64bb57aa2d6e8b35.players, 7, 0 );
}

// Namespace ob_activity_sagittarius_vo
// Params 3, eflags: 0x4
// Checksum 0x62618b58, Offset: 0x6ce
// Size: 0x3f
function private function_b79d01dfa450e80f( var_cd7e11dc688992d4, var_64bb57aa2d6e8b35, boss_agent )
{
    while ( true )
    {
        childthread function_568401631cc288ca( var_cd7e11dc688992d4, var_64bb57aa2d6e8b35, boss_agent );
        var_cd7e11dc688992d4 waittill( #"hash_125fb82cce5e15d8" );
    }
}

// Namespace ob_activity_sagittarius_vo
// Params 3, eflags: 0x4
// Checksum 0x81b858e, Offset: 0x715
// Size: 0xbf
function private function_568401631cc288ca( var_cd7e11dc688992d4, var_64bb57aa2d6e8b35, boss_agent )
{
    var_cd7e11dc688992d4 endon( #"hash_125fb82cce5e15d8" );
    var_cd7e11dc688992d4 waittill( #"hash_5242863dc17b5295" );
    childthread function_6e9b40557361d197( var_cd7e11dc688992d4, var_64bb57aa2d6e8b35 );
    
    foreach ( player in var_64bb57aa2d6e8b35.players )
    {
        childthread function_3e60d6567204b21a( player, boss_agent );
    }
}

// Namespace ob_activity_sagittarius_vo
// Params 2, eflags: 0x4
// Checksum 0xac79b8c7, Offset: 0x7dc
// Size: 0x73
function private function_39a0e215431e2484( boss_agent, var_64bb57aa2d6e8b35 )
{
    while ( true )
    {
        boss_agent waittill( #"damage", amount );
        
        if ( boss_agent.health / boss_agent.maxhealth < 0.35 )
        {
            thread overlord::playconversation( "priya_to_the_death", var_64bb57aa2d6e8b35.players, undefined, 0 );
            break;
        }
    }
}

// Namespace ob_activity_sagittarius_vo
// Params 2, eflags: 0x4
// Checksum 0x86e07ab7, Offset: 0x857
// Size: 0x96
function private function_1d0fcc54090fae6c( boss_agent, var_64bb57aa2d6e8b35 )
{
    wounded_vo_struct = function_3a6b015435485777( [ "priya_wounded_1", "priya_wounded_2", "priya_wounded_3" ] );
    
    while ( true )
    {
        boss_agent waittill( #"damage", amount );
        random_float = randomfloatrange( 0, 1 );
        
        if ( random_float <= 0.15 )
        {
            function_b3c7509b373055bc( wounded_vo_struct, var_64bb57aa2d6e8b35.players );
        }
        
        wait 10;
    }
}

// Namespace ob_activity_sagittarius_vo
// Params 2, eflags: 0x4
// Checksum 0x1ee13cb5, Offset: 0x8f5
// Size: 0xa5
function private function_3e60d6567204b21a( player, boss_agent )
{
    player endon( #"death_or_disconnect" );
    player endon( #"left_squad" );
    vo_struct = function_3a6b015435485777( [ "priya_signal_1", "priya_signal_2" ] );
    distance_sqrt = 25000000;
    
    while ( true )
    {
        if ( distancesquared( player.origin, boss_agent.origin ) >= distance_sqrt )
        {
            function_b3c7509b373055bc( vo_struct, [ player ] );
            wait randomfloatrange( 12, 20 );
        }
        
        waitframe();
    }
}

// Namespace ob_activity_sagittarius_vo
// Params 2, eflags: 0x4
// Checksum 0xf9190ac1, Offset: 0x9a2
// Size: 0x8c
function private function_6e9b40557361d197( var_cd7e11dc688992d4, var_64bb57aa2d6e8b35 )
{
    nags_vo_struct = function_3a6b015435485777( [ "priya_taunt_1", "priya_taunt_2", "priya_taunt_3", "priya_taunt_4", "priya_taunt_5", "priya_taunt_6", "priya_taunt_7" ] );
    
    while ( true )
    {
        wait randomfloatrange( 20, 25 );
        function_b3c7509b373055bc( nags_vo_struct, var_64bb57aa2d6e8b35.players );
    }
}

// Namespace ob_activity_sagittarius_vo
// Params 2, eflags: 0x4
// Checksum 0xd9f4479f, Offset: 0xa36
// Size: 0x91
function private function_c4207508491de5cf( var_cd7e11dc688992d4, var_64bb57aa2d6e8b35 )
{
    cloak_vo_struct = function_3a6b015435485777( [ "priya_cloaked_2", "priya_cloaked_3", "priya_cloaked_4", "priya_cloaked_5", "priya_cloaked_6", "priya_cloaked_7", "priya_cloaked_8" ] );
    
    while ( true )
    {
        var_cd7e11dc688992d4 waittill( #"hash_c6d72151e1bb9ed0" );
        function_b3c7509b373055bc( cloak_vo_struct, var_64bb57aa2d6e8b35.players );
    }
}

// Namespace ob_activity_sagittarius_vo
// Params 3, eflags: 0x4
// Checksum 0xa74452b0, Offset: 0xacf
// Size: 0xd3
function private function_d938710d55524d6e( var_cd7e11dc688992d4, var_64bb57aa2d6e8b35, boss_agent )
{
    uncloak_vo_struct = function_3a6b015435485777( [ "priya_uncloak_1", "priya_uncloak_2", "priya_uncloak_3" ] );
    var_c2ced779fb92ed37 = function_3a6b015435485777( [ "priya_spotted_1", "priya_spotted_3", "priya_spotted_4", "priya_spotted_5", "priya_spotted_6", "priya_spotted_7", "priya_spotted_8" ] );
    
    while ( true )
    {
        var_cd7e11dc688992d4 waittill( #"hash_5bc666f4704dcb89" );
        function_b3c7509b373055bc( uncloak_vo_struct, var_64bb57aa2d6e8b35.players );
        childthread function_cd4ad9dcf8607a1a( var_cd7e11dc688992d4, boss_agent, var_64bb57aa2d6e8b35, var_c2ced779fb92ed37 );
    }
}

// Namespace ob_activity_sagittarius_vo
// Params 4, eflags: 0x4
// Checksum 0xec220dd7, Offset: 0xbaa
// Size: 0x141
function private function_cd4ad9dcf8607a1a( var_cd7e11dc688992d4, boss_agent, var_64bb57aa2d6e8b35, vo_struct )
{
    var_cd7e11dc688992d4 endon( #"hash_c6d72151e1bb9ed0" );
    var_cd7e11dc688992d4 endon( #"hash_5bc666f4704dcb89" );
    fov = cos( 35 );
    var_4297a96308301442 = 0;
    
    while ( true )
    {
        player_within_fov = 0;
        
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            if ( withinfov2d( player.origin, player getplayerangles(), boss_agent.origin, fov ) && sighttracepassed( player geteye(), boss_agent geteye(), 1, boss_agent, player ) )
            {
                function_b3c7509b373055bc( vo_struct, [ player ], var_4297a96308301442 );
                player_within_fov = 1;
                break;
            }
        }
        
        if ( player_within_fov )
        {
            break;
        }
        
        waitframe();
    }
}

// Namespace ob_activity_sagittarius_vo
// Params 3, eflags: 0x4
// Checksum 0xa044622f, Offset: 0xcf3
// Size: 0x1ed
function private bossspotted( var_cd7e11dc688992d4, boss_agent, var_64bb57aa2d6e8b35 )
{
    distance_sqrt = 2250000;
    priya_first_echo_unit = 0;
    
    while ( !isdefined( var_cd7e11dc688992d4.decoy ) )
    {
        waitframe();
    }
    
    while ( true )
    {
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            distancemin = distancesquared( player.origin, var_cd7e11dc688992d4.decoy.origin ) <= distance_sqrt;
            
            if ( isdefined( var_cd7e11dc688992d4.decoy ) )
            {
                ignoreents = arraycombine( var_64bb57aa2d6e8b35.players, [ var_cd7e11dc688992d4.decoy ] );
            }
            
            canseetarget = trace::ray_trace_passed( var_cd7e11dc688992d4.decoy.origin + ( 0, 0, 60 ), player geteye(), ignoreents );
            
            if ( distancemin && canseetarget )
            {
                thread overlord::playconversation( "priya_first_echo_unit", var_64bb57aa2d6e8b35.players );
                priya_first_echo_unit = 1;
                var_cd7e11dc688992d4 notify( #"decoy_spotted" );
                wait 3;
                var_cd7e11dc688992d4 utility::ent_flag_set( "echo_unit_spotted" );
                break;
            }
        }
        
        if ( priya_first_echo_unit )
        {
            break;
        }
        
        wait 1;
    }
    
    var_cd7e11dc688992d4 waittill( #"hash_43d681b55f223ff7", holoorigin );
    overlord::playconversation( "priya_echo_unit_2", var_64bb57aa2d6e8b35.players, 2 );
}

// Namespace ob_activity_sagittarius_vo
// Params 3, eflags: 0x4
// Checksum 0xb89d2477, Offset: 0xee8
// Size: 0x46
function private function_de201adab67e8a8e( var_cd7e11dc688992d4, boss_agent, var_64bb57aa2d6e8b35 )
{
    var_cd7e11dc688992d4 waittill( #"cradle_spawn" );
    wait 2;
    overlord::playconversation( "more_friggin_monsters", var_64bb57aa2d6e8b35.players );
}

// Namespace ob_activity_sagittarius_vo
// Params 3, eflags: 0x4
// Checksum 0xdeaf41ec, Offset: 0xf36
// Size: 0x49
function private function_faf1c93b82438d5( var_cd7e11dc688992d4, boss_agent, var_64bb57aa2d6e8b35 )
{
    boss_agent waittill( #"boss_shooting" );
    wait 1;
    overlord::playevent( "priya_that_rifle", var_64bb57aa2d6e8b35.players, undefined, 0, 0 );
}

// Namespace ob_activity_sagittarius_vo
// Params 3
// Checksum 0xdac7046b, Offset: 0xf87
// Size: 0xa4
function function_860e2822ee021a99( var_bf75ec0e958132f4, bossposition, players )
{
    if ( !( isdefined( var_bf75ec0e958132f4 ) && isdefined( bossposition ) ) )
    {
        return;
    }
    
    directionvector = bossposition - var_bf75ec0e958132f4;
    directionvector = vectornormalize( directionvector );
    vo_event = undefined;
    
    if ( abs( directionvector[ 0 ] ) > abs( directionvector[ 1 ] ) )
    {
        vo_event = directionvector[ 0 ] > 0 ? "priya_move_west" : "priya_move_east";
    }
    else
    {
        vo_event = directionvector[ 1 ] > 0 ? "priya_move_north" : "priya_move_south";
    }
    
    overlord::playevent( vo_event, players, 0.5, 0 );
}

