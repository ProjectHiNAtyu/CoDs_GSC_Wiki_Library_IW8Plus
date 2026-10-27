// script_3016732d4c7eef02  (hash_3016732d4c7eef02.gscc) (size: 8801 Bytes / 0x2261 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa69824ea (2794988778)
// size ...... 8801 (0x2261)
// includes .. 7   (offset: 0x2049)
// strings ... 30  (offset: 0x2081)
// dev strs .. 5   (offset: 0x2225)
// exports ... 24  (offset: 0x15c1)
// cseg ...... 0x3de + 0x11e3 (0x15c1)
// imports ... 58  (offset: 0x1981)
// animtree1 . 0   (offset: 0x2261)
// animtree2 . 0   (offset: 0x2261)
#using script_636bd827a012af12;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\gametypes\ob;
#using scripts\mp\objidpoolmanager;

#namespace ob_capture_zone;

// Namespace ob_capture_zone
// Params 0, eflags: 0x5
// Checksum 0xf7ec533a, Offset: 0x3fc
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"ob_capture_zone", undefined, undefined, &post_main );
}

/#

    // Namespace ob_capture_zone
    // Params 0
    // Checksum 0x518f05b9, Offset: 0x41d
    // Size: 0x5, Type: dev
    function function_e93869c5ce2936af()
    {
        
    }

#/

// Namespace ob_capture_zone
// Params 0
// Checksum 0x79f4985d, Offset: 0x42a
// Size: 0x7f
function post_main()
{
    level._effect[ "ob_capture_zone_ring_1" ] = loadfxasset( "vfx_sat_mp_ob_gem_cradle_memory_ring_1" );
    level._effect[ "ob_capture_zone_ring_2" ] = loadfxasset( "vfx_sat_mp_ob_gem_cradle_memory_ring_2" );
    level._effect[ "ob_capture_zone_ring_3" ] = loadfxasset( "vfx_sat_mp_ob_gem_cradle_memory_ring_3" );
    level._effect[ "ob_capture_zone_ring_4" ] = loadfxasset( "vfx_sat_mp_ob_gem_cradle_memory_ring_4" );
    level._effect[ "ob_capture_zone_ring_6" ] = loadfxasset( "vfx_sat_mp_ob_gem_cradle_memory_ring_6" );
}

// Namespace ob_capture_zone
// Params 10
// Checksum 0x5ec0dba, Offset: 0x4b1
// Size: 0x1d8
function function_40df18d63bc4331a( targetname, activity_instance, var_2688c698eb70c9f8 = "", max_time = 45, two_player_rate = 1.5, three_player_rate = 2, four_player_rate = 2.5, decay_rate = 0, var_550ccf9ec55bc775 = 1, additional_data )
{
    capture_zone = utility::getstruct( targetname );
    capture_zone.id = targetname;
    capture_zone.activity_instance = activity_instance;
    capture_zone.zone_chevrons = getentitylessscriptablearray( targetname + "_chevron", #targetname );
    capture_zone.activity_instance = activity_instance;
    capture_zone.var_2688c698eb70c9f8 = var_2688c698eb70c9f8;
    capture_zone.max_time = max_time;
    capture_zone.two_player_rate = two_player_rate;
    capture_zone.three_player_rate = three_player_rate;
    capture_zone.four_player_rate = four_player_rate;
    capture_zone.decay_rate = decay_rate;
    capture_zone.var_550ccf9ec55bc775 = var_550ccf9ec55bc775;
    capture_zone.additional_data = additional_data;
    capture_zone.complete = 0;
    capture_zone.current_checkpoint = 0;
    
    if ( !isdefined( capture_zone.activity_instance.capture_zone_array ) )
    {
        capture_zone.activity_instance.capture_zone_array = [];
    }
    
    capture_zone.activity_instance.capture_zone_array[ targetname ] = capture_zone;
    return capture_zone;
}

// Namespace ob_capture_zone
// Params 2
// Checksum 0xd5bed5dd, Offset: 0x692
// Size: 0x10f
function function_bafcb5a390b6ed72( capture_zone, var_258835623f5073b6 = 1 )
{
    capture_zone.trigger = getent( capture_zone.targetname + "_trigger", #targetname );
    capture_zone.obj_struct = utility::getstruct( capture_zone.targetname + "_obj_struct", "targetname" );
    
    if ( isdefined( capture_zone.obj_struct ) )
    {
        position = capture_zone.obj_struct.origin;
    }
    else
    {
        position = capture_zone.origin;
    }
    
    capture_zone.obj_id = capture_zone.activity_instance ob_story_mission_utils::function_b9cb179f9577f32a( position, 72, undefined, "sat_ob_objectivemarker_location" );
    function_2b8e3d3ae2a6414a( capture_zone.obj_id, 0 );
    
    if ( !var_258835623f5073b6 )
    {
        objective_state( capture_zone.obj_id, "active" );
    }
    
    capture_zone activate_capture_zone( var_258835623f5073b6 );
    return capture_zone;
}

// Namespace ob_capture_zone
// Params 4
// Checksum 0xd3835b9, Offset: 0x7aa
// Size: 0x11a
function function_7d67c057ae88b5a0( capture_zone, radius, create_chevrons = 0, num_chevrons = 16 )
{
    if ( create_chevrons )
    {
        capture_zone.var_55bcb1f81e429cb1 = 1;
        segment_degrees = 360 / num_chevrons;
        
        for ( i = 0; i < num_chevrons ; i++ )
        {
            local_offset = anglestoforward( ( 0, segment_degrees * i, 0 ) ) * radius;
            chevron_org = coordtransform( local_offset, capture_zone.origin, capture_zone.angles );
            chevron_ang = vectortoangles( chevron_org - capture_zone.origin );
            capture_zone.zone_chevrons[ i ] = spawnscriptable( "ob_sat_capture_zone_chevron", chevron_org, chevron_ang );
        }
    }
    
    capture_zone.trigger = spawn( "trigger_radius", capture_zone.origin, 0, radius, 90 );
    capture_zone activate_capture_zone();
    return capture_zone;
}

// Namespace ob_capture_zone
// Params 2
// Checksum 0x74c5c1e, Offset: 0x8cd
// Size: 0x23
function function_732739bf2b9ef79f( var_fe97645ffe102f4a, func )
{
    self.callbacks[ var_fe97645ffe102f4a ] = func;
}

// Namespace ob_capture_zone
// Params 1, eflags: 0x4
// Checksum 0xb1122c14, Offset: 0x8f8
// Size: 0x19f
function private activate_capture_zone( var_258835623f5073b6 = 1 )
{
    capture_zone = self;
    
    if ( isdefined( self.callbacks[ "CALLBACK_CAPTURE_ZONE_ACTIVATED" ] ) )
    {
        thread [[ self.callbacks[ "CALLBACK_CAPTURE_ZONE_ACTIVATED" ] ]]( capture_zone );
    }
    
    capture_zone notify( #"capture_zone_activated" );
    angles = capture_zone.angles ?? ( 0, 0, 0 );
    
    switch ( capture_zone.additional_data.var_8f04646f7f1bd1da )
    {
        case #"hash_b9a18181311c0791":
            var_8f04646f7f1bd1da = "ob_capture_zone_ring_1";
            break;
        case #"hash_6d4404422918560b":
            var_8f04646f7f1bd1da = "ob_capture_zone_ring_2";
            break;
        case #"hash_f6a38a837f36c75b":
            var_8f04646f7f1bd1da = "ob_capture_zone_ring_3";
            break;
        case #"hash_6ae773aedd055e9d":
            var_8f04646f7f1bd1da = "ob_capture_zone_ring_4";
            break;
        case #"hash_15a4573715c07d30":
            var_8f04646f7f1bd1da = "ob_capture_zone_ring_6";
            break;
        case #"hash_db653a4972b3c13b":
            var_8f04646f7f1bd1da = undefined;
            break;
        default:
            var_8f04646f7f1bd1da = "ob_capture_zone_ring_1";
            break;
    }
    
    if ( isdefined( var_8f04646f7f1bd1da ) )
    {
        capture_zone.circle_fx = spawnfx( utility::getfx( var_8f04646f7f1bd1da ), capture_zone.origin, anglestoforward( angles ) );
        triggerfx( capture_zone.circle_fx );
    }
    
    capture_zone function_88497170828e1e94();
    capture_zone function_b5b76a59416495ed( "inactive" );
    capture_zone init_progress_monitor( var_258835623f5073b6 );
    capture_zone capture_zone_complete();
}

// Namespace ob_capture_zone
// Params 0
// Checksum 0x5f26337f, Offset: 0xa9f
// Size: 0x93
function function_88497170828e1e94()
{
    capture_zone = self;
    
    /#
    #/
    
    capture_zone.trigger.containsplayer = 0;
    capture_zone.trigger.containsai = 0;
    capture_zone.trigger.var_b8018d01fccc3ef4 = 0;
    capture_zone.trigger.var_478087fb2bac01e9 = 0;
    trigger::makeenterexittrigger( capture_zone.trigger, &function_d3b361955b10cb10, &function_4b8f8eaedd86802e, undefined, undefined, &function_2841add19d6d2d17, capture_zone );
}

// Namespace ob_capture_zone
// Params 1, eflags: 0x4
// Checksum 0x23b51aab, Offset: 0xb3a
// Size: 0x256
function private init_progress_monitor( var_258835623f5073b6 = 1 )
{
    capture_zone = self;
    var_ae5c66723a9a7b74 = capture_zone.max_time / capture_zone.var_550ccf9ec55bc775;
    var_c7d7f0e01d1dd97e = 0;
    
    if ( var_258835623f5073b6 )
    {
        objidpoolmanager::objective_show_progress( capture_zone.obj_id, 1 );
    }
    
    for ( i = 1; i <= capture_zone.var_550ccf9ec55bc775 ; i++ )
    {
        current_checkpoint_progress = 0;
        
        while ( current_checkpoint_progress < var_ae5c66723a9a7b74 )
        {
            if ( capture_zone.trigger.containsplayer || current_checkpoint_progress > 0 )
            {
                capture_zone are_players_alive();
                current_checkpoint_progress += capture_zone.capture_rate;
                current_checkpoint_progress = max( current_checkpoint_progress, 0 );
                var_c7d7f0e01d1dd97e += capture_zone.capture_rate;
                var_c7d7f0e01d1dd97e = max( var_c7d7f0e01d1dd97e, ( i - 1 ) * var_ae5c66723a9a7b74 );
                var_62e46f7d044c1a4f = var_c7d7f0e01d1dd97e / capture_zone.max_time;
                var_62e46f7d044c1a4f = max( var_62e46f7d044c1a4f, 0 );
                capture_zone.var_62e46f7d044c1a4f = var_62e46f7d044c1a4f;
                
                if ( isdefined( capture_zone.obj_id ) && var_62e46f7d044c1a4f <= 1 )
                {
                    objidpoolmanager::objective_set_progress( capture_zone.obj_id, var_62e46f7d044c1a4f );
                }
            }
            
            wait 1;
        }
        
        capture_zone function_eee50a3b05e8ed7();
        capture_zone progress_checkpoint_reached( i );
        
        /#
            iprintlnbold( toupper( getsubstr( capture_zone.id, 4 ) ) + "<dev string:x24>" + floor( var_62e46f7d044c1a4f * 100 ) );
        #/
        
        if ( capture_zone.additional_data.var_2c303adb6cfb3b2c )
        {
            return_notify = capture_zone utility::waittill_any_return( "capture_zone_checkpoint_wave_paused", "capture_zone_checkpoint_complete" );
            
            if ( return_notify == "capture_zone_checkpoint_wave_paused" )
            {
                /#
                    iprintlnbold( toupper( getsubstr( capture_zone.id, 4 ) ) + "<dev string:x3d>" + floor( var_62e46f7d044c1a4f * 100 ) );
                #/
                
                capture_zone waittill( #"capture_zone_checkpoint_complete" );
                
                /#
                    iprintlnbold( toupper( getsubstr( capture_zone.id, 4 ) ) + "<dev string:x54>" + floor( var_62e46f7d044c1a4f * 100 ) );
                #/
            }
        }
    }
    
    /#
        iprintlnbold( "<dev string:x6c>" );
    #/
}

/#

    // Namespace ob_capture_zone
    // Params 0
    // Checksum 0xc825ff0a, Offset: 0xd98
    // Size: 0x5, Type: dev
    function function_f80cdeba3f957ab3()
    {
        
    }

#/

// Namespace ob_capture_zone
// Params 1, eflags: 0x4
// Checksum 0x8faacf9d, Offset: 0xda5
// Size: 0x95
function private function_b5b76a59416495ed( state )
{
    if ( !ob::nightmare() )
    {
        return;
    }
    
    foreach ( chevron in self.zone_chevrons )
    {
        chevron setscriptablepartstate( "chevron", state );
    }
}

/#

    // Namespace ob_capture_zone
    // Params 0
    // Checksum 0xe5d8fbf0, Offset: 0xe42
    // Size: 0x5, Type: dev
    function function_cf6d2f8817ec0211()
    {
        
    }

#/

// Namespace ob_capture_zone
// Params 3
// Checksum 0xd41a028, Offset: 0xe4f
// Size: 0x11c
function function_d3b361955b10cb10( ent, trigger, capture_zone )
{
    capture_zone endon( #"capture_zone_completed" );
    
    if ( !utility::ent_flag( "flag_capture_zone_begin" ) )
    {
        utility::ent_flag_set( "flag_capture_zone_begin" );
    }
    
    if ( isplayer( ent ) )
    {
        trigger.var_b8018d01fccc3ef4 += 1;
        trigger.containsplayer = 1;
        
        if ( isdefined( capture_zone.obj_id ) )
        {
            objidpoolmanager::objective_pin_player( capture_zone.obj_id, ent );
        }
        
        if ( isdefined( capture_zone.callbacks[ "CALLBACK_CAPTURE_ZONE_PLAYER_ENTER" ] ) )
        {
            thread [[ capture_zone.callbacks[ "CALLBACK_CAPTURE_ZONE_PLAYER_ENTER" ] ]]( capture_zone, ent );
        }
        
        if ( capture_zone.var_62e46f7d044c1a4f > 0.1 )
        {
            ent.var_84b04a32e5935354 = 1;
        }
        
        return;
    }
    
    if ( isai( ent ) )
    {
        trigger.var_478087fb2bac01e9 += 1;
        trigger.containsai = 1;
    }
}

// Namespace ob_capture_zone
// Params 3
// Checksum 0x821176f, Offset: 0xf73
// Size: 0x13c
function function_4b8f8eaedd86802e( ent, trigger, capture_zone )
{
    capture_zone endon( #"capture_zone_completed" );
    
    if ( isplayer( ent ) )
    {
        assert( trigger.var_b8018d01fccc3ef4 > 0, "<dev string:x84>" );
        trigger.var_b8018d01fccc3ef4 = maxint( trigger.var_b8018d01fccc3ef4 - 1, 0 );
        
        if ( trigger.var_b8018d01fccc3ef4 == 0 )
        {
            trigger.containsplayer = 0;
        }
        
        if ( isdefined( capture_zone.obj_id ) )
        {
            obj_id = capture_zone.obj_id;
            objidpoolmanager::objective_unpin_player( obj_id, ent );
        }
        
        if ( isdefined( capture_zone.callbacks[ "CALLBACK_CAPTURE_ZONE_PLAYER_EXIT" ] ) )
        {
            thread [[ capture_zone.callbacks[ "CALLBACK_CAPTURE_ZONE_PLAYER_EXIT" ] ]]( capture_zone, ent );
        }
        
        ent.var_84b04a32e5935354 = 1;
        return;
    }
    
    if ( isai( ent ) )
    {
        trigger.var_478087fb2bac01e9 = maxint( trigger.var_478087fb2bac01e9 - 1, 0 );
        
        if ( trigger.var_478087fb2bac01e9 == 0 )
        {
            trigger.containsai = 0;
        }
    }
}

// Namespace ob_capture_zone
// Params 3
// Checksum 0x5c25db1b, Offset: 0x10b7
// Size: 0x38
function function_2841add19d6d2d17( ent, trigger, payload )
{
    if ( getdvarint( @"hash_a2a6638e18d4743" ) != 1 )
    {
        return isai( ent );
    }
}

// Namespace ob_capture_zone
// Params 0
// Checksum 0x2c18ac32, Offset: 0x10f7
// Size: 0x40
function function_1ac279ee14cc852b()
{
    self endon( #"capture_zone_complete" );
    
    /#
        while ( !self.complete )
        {
            drawtrigger( self.trigger, ( 1, 0, 1 ), 0, 1 );
            waitframe();
        }
    #/
}

/#

    // Namespace ob_capture_zone
    // Params 0
    // Checksum 0x4c3b4abf, Offset: 0x113f
    // Size: 0x5, Type: dev
    function function_dc31c7f7a5335303()
    {
        
    }

#/

// Namespace ob_capture_zone
// Params 2, eflags: 0x4
// Checksum 0xf54cfb09, Offset: 0x114c
// Size: 0xe4
function private function_29304789bb435639( num_players_in_trigger, var_68039f2806a8d16b )
{
    capture_zone = self;
    
    switch ( num_players_in_trigger )
    {
        case 1:
            capture_zone.capture_rate = 1;
            break;
        case 2:
            capture_zone.capture_rate = capture_zone.two_player_rate;
            break;
        case 3:
            capture_zone.capture_rate = capture_zone.three_player_rate;
            break;
        case 4:
            capture_zone.capture_rate = capture_zone.four_player_rate;
            break;
        default:
            capture_zone.capture_rate = capture_zone.decay_rate * -1;
            break;
    }
}

// Namespace ob_capture_zone
// Params 0
// Checksum 0x7967c82a, Offset: 0x1238
// Size: 0x152
function capture_zone_complete()
{
    capture_zone = self;
    capture_zone notify( #"capture_zone_completed" );
    capture_zone.complete = 1;
    capture_zone function_b5b76a59416495ed( "off" );
    
    if ( isdefined( capture_zone.trigger ) )
    {
        capture_zone.trigger delete();
    }
    
    if ( isdefined( capture_zone.circle_fx ) )
    {
        capture_zone.circle_fx delete();
    }
    
    if ( capture_zone.var_55bcb1f81e429cb1 )
    {
        foreach ( chevron in capture_zone.zone_chevrons )
        {
            chevron freescriptable();
        }
    }
    
    if ( isdefined( capture_zone.obj_id ) )
    {
        capture_zone.activity_instance ob_story_mission_utils::objective_marker_clear( capture_zone.obj_id );
    }
    
    if ( isdefined( capture_zone.callbacks[ "CALLBACK_CAPTURE_ZONE_COMPLETE" ] ) )
    {
        thread [[ capture_zone.callbacks[ "CALLBACK_CAPTURE_ZONE_COMPLETE" ] ]]( capture_zone );
    }
}

// Namespace ob_capture_zone
// Params 1, eflags: 0x4
// Checksum 0x75ee1e79, Offset: 0x1392
// Size: 0x53
function private progress_checkpoint_reached( checkpoint_num )
{
    capture_zone = self;
    capture_zone.current_checkpoint = checkpoint_num;
    
    if ( isdefined( capture_zone.callbacks[ "CALLBACK_CAPTURE_ZONE_PROGRESS_CHECKPOINT_REACHED" ] ) )
    {
        thread [[ capture_zone.callbacks[ "CALLBACK_CAPTURE_ZONE_PROGRESS_CHECKPOINT_REACHED" ] ]]( capture_zone, checkpoint_num );
    }
}

// Namespace ob_capture_zone
// Params 0, eflags: 0x4
// Checksum 0x92945aa5, Offset: 0x13ed
// Size: 0x122
function private are_players_alive()
{
    capture_zone = self;
    result = 0;
    var_82fde09fae5c48da = 0;
    
    foreach ( ent in capture_zone.trigger.triggerenterents )
    {
        if ( isplayer( ent ) && ent player::isreallyalive() )
        {
            if ( ent.inlaststand )
            {
                ent.var_84b04a32e5935354 = 1;
                continue;
            }
            
            var_82fde09fae5c48da++;
            result = 1;
        }
    }
    
    function_29304789bb435639( var_82fde09fae5c48da );
    
    if ( result )
    {
        capture_zone.var_8327890ff4f1a28 = 1;
        capture_zone function_b5b76a59416495ed( "active" );
        return;
    }
    
    capture_zone.var_8327890ff4f1a28 = 0;
    capture_zone function_b5b76a59416495ed( "inactive" );
}

// Namespace ob_capture_zone
// Params 0
// Checksum 0x6a7f1a95, Offset: 0x1517
// Size: 0xaa
function function_eee50a3b05e8ed7()
{
    capture_zone = self;
    
    foreach ( player in level.players )
    {
        if ( !arraycontains( capture_zone.trigger.triggerenterents, player ) )
        {
            player.var_84b04a32e5935354 = 1;
        }
    }
}

