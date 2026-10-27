// script_4d7113533e31281c  (hash_4d7113533e31281c.gscc) (size: 7336 Bytes / 0x1ca8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf1d3efd4 (4057198548)
// size ...... 7336 (0x1ca8)
// includes .. 12  (offset: 0x1a68)
// strings ... 29  (offset: 0x1ac8)
// dev strs .. 0   (offset: 0x1ca8)
// exports ... 16  (offset: 0x1040)
// cseg ...... 0x291 + 0xdaf (0x1040)
// imports ... 67  (offset: 0x12c0)
// animtree1 . 0   (offset: 0x1ca8)
// animtree2 . 0   (offset: 0x1ca8)
#using scripts\common\math;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\killstreaks\dawg_mp;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\zm\zm_utility;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_main;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_save;
#using scripts\mp\zm\ztron\ztron_sound;

#namespace ztron_item_dawg;

// Namespace ztron_item_dawg
// Params 0, eflags: 0x5
// Checksum 0x92a86088, Offset: 0x2af
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ztron_item_dawg", #"ztron_item", undefined, &init );
}

// Namespace ztron_item_dawg
// Params 0
// Checksum 0xb08ece0f, Offset: 0x2d8
// Size: 0x72
function init()
{
    ztron_item::function_5844a9c240f7dc8d( #"dawg", #"use", &function_a5d618474714c1eb );
    
    if ( !isdefined( level.var_44cdf5fee6853ac5 ) )
    {
        level.var_44cdf5fee6853ac5 = [];
    }
    
    level.var_44cdf5fee6853ac5[ level.var_44cdf5fee6853ac5.size ] = "sat_ztron_dawg_missile";
    ztron_sound::function_4ac735395b173fe( "dawg_impact_OS", "evt_ztron_pickup_sentry_land" );
    ztron_sound::function_4ac735395b173fe( "dawg_takeoff_OS", "evt_ztron_pickup_sentry_takeoff" );
}

// Namespace ztron_item_dawg
// Params 1
// Checksum 0x9fe6063d, Offset: 0x352
// Size: 0xf0
function function_a5d618474714c1eb( params )
{
    player = params.player;
    item_data = ztron_item::function_998f2b10462afbf4( params.bundle );
    storebought = params.scriptable.storebought ?? 0;
    var_4f41655560136ded = params.scriptable.var_4f41655560136ded ?? 0;
    spawn_pos = player.origin;
    duration_seconds = ztron_player_utility::function_10777122eee28fa8( item_data.duration );
    
    if ( storebought && !var_4f41655560136ded )
    {
        duration_seconds = params.scriptable.params.duration;
    }
    
    player spawn_dawg( spawn_pos, duration_seconds, 1, storebought );
}

// Namespace ztron_item_dawg
// Params 0, eflags: 0x4
// Checksum 0x61e2b20d, Offset: 0x44a
// Size: 0xb
function private function_42342434cd7a15ab()
{
    return self.lifetime_seconds;
}

// Namespace ztron_item_dawg
// Params 4
// Checksum 0xd6471bd3, Offset: 0x45e
// Size: 0x28d
function spawn_dawg( spawn_pos, lifetime_seconds, var_2b17124ad9f41cf2 = 1, storebought = 0 )
{
    var_447e72e2bf4be91 = spawn_pos + ( 0, 0, 3000 );
    dawg = dawg_mp::spawn_dawg( var_447e72e2bf4be91, ( 0, 0, 0 ) );
    
    if ( isdefined( dawg ) )
    {
        dawg.no_coatofarms = 1;
        dawg.nogib = 1;
        dawg.var_d89c9a083a4bef17 = 1;
        dawg.disallow_knockdown = 1;
        dawg.no_burn = 1;
        dawg val::set( "ztron_dawg", "damage", 0 );
        dawg val::set( "ztron_dawg", "death", 0 );
        dawg val::set( "ztron_dawg", "damageshield", 1 );
        dawg.turret val::set( "ztron_dawg", "damage", 0 );
        dawg.turret val::set( "ztron_dawg", "death", 0 );
        dawg.turret val::set( "ztron_dawg", "damageshield", 1 );
        dawg utility::callsharedfunc( #"ai", #"hash_d1ade7b3c059cba9", "ztron_dawg", 1 );
        player_trail_fx_name = "ztron_player_trail_" + self.ztron.color;
        dawg.player_trail_fx_name = player_trail_fx_name;
        dawg.lifetime_seconds = int( lifetime_seconds );
        
        if ( storebought )
        {
            save = spawnstruct();
            save.ref = "ztron_store_60min_dawg";
            save.entity = dawg;
            save.var_c93abd0f18db7640 = &function_42342434cd7a15ab;
            thread ztron_save::function_70c11aca4f83fcda( save );
        }
        
        if ( var_2b17124ad9f41cf2 )
        {
            dawg function_d30e5fdc666ead48( spawn_pos, 1 );
        }
        else
        {
            waitframe();
            playfxontag( utility::getfx( self.player_trail_fx_name ), self, "tag_origin" );
            dawg.origin = spawn_pos;
        }
        
        dawg.enemyselector = %"enemyselector_dawg_ztron";
        dawg thread function_aa2d1090c3470946( self, storebought );
        dawg thread function_40b6a2f651d24856();
        dawg thread function_d53c795e41502e35();
        dawg.no_hazards = 1;
        dawg function_7f8988ce63c1623d( 0 );
    }
    
    return dawg;
}

// Namespace ztron_item_dawg
// Params 0
// Checksum 0x5d6ce185, Offset: 0x6f4
// Size: 0x98
function function_d53c795e41502e35()
{
    self endon( #"death" );
    self.var_63c94fe1b2260b34 = 1;
    self.var_818c06f9a89fb0ba = 4;
    self.var_36dfdbd7ab796f0f = 5;
    self.using_fake_health = 1;
    self.var_cce7c67ea2da8902 = self.lifetime_seconds;
    self.var_d165d33ad4f00e17 = self.var_cce7c67ea2da8902;
    
    while ( self.var_cce7c67ea2da8902 >= 0 )
    {
        wait 1;
        self.var_cce7c67ea2da8902 = self.lifetime_seconds;
    }
    
    self.using_fake_health = 0;
    self.var_63c94fe1b2260b34 = 0;
}

// Namespace ztron_item_dawg
// Params 2
// Checksum 0xa2c1a948, Offset: 0x794
// Size: 0x98
function function_d30e5fdc666ead48( end_pos, duration_seconds )
{
    self endon( #"death" );
    self.mode = "inactive";
    dawg_move_to( end_pos, duration_seconds, 0, 1 );
    waitframe();
    playfx( utility::getfx( "turret_impact" ), end_pos );
    playfxontag( utility::getfx( self.player_trail_fx_name ), self, "tag_origin" );
    ztron_sound::ztron_playsound( "dawg_impact_OS", self.origin );
    self.mode = "attack";
    self notify( #"ztron_dawg_active" );
}

// Namespace ztron_item_dawg
// Params 1
// Checksum 0xb6d4d1c5, Offset: 0x834
// Size: 0x145
function function_d1b68932dcfa7066( despawn = 1 )
{
    ztron_sound::ztron_playsound( "dawg_takeoff_OS", self.origin );
    self.mode = "inactive";
    dawg_move_to( self.origin + ( 0, 0, 5000 ), 3 );
    
    if ( despawn )
    {
        val::set( "ztron_dawg", "damage", 1 );
        val::set( "ztron_dawg", "death", 1 );
        val::set( "ztron_dawg", "damageshield", 0 );
        
        if ( self.turret )
        {
            self.turret val::set( "ztron_dawg", "damage", 1 );
            self.turret val::set( "ztron_dawg", "death", 1 );
            self.turret val::set( "ztron_dawg", "damageshield", 0 );
        }
        
        self.var_4e066f8aa40be1ae = 1;
        self.var_c4e26a8fd03fdeea = 1;
        self hide();
        self kill();
        return;
    }
    
    if ( isdefined( self ) && isdefined( self.player_trail_fx_name ) )
    {
        stopfxontag( utility::getfx( self.player_trail_fx_name ), self, "tag_origin" );
    }
}

// Namespace ztron_item_dawg
// Params 4
// Checksum 0x186d94c, Offset: 0x981
// Size: 0xa9
function dawg_move_to( end_pos, duration_seconds, accelerate_seconds = 0, decelerate_seconds = 0 )
{
    self motionwarpcancel();
    mover = utility::spawn_tag_origin( self.origin, ( 0, 0, 0 ) );
    self linkto( mover, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    mover moveto( end_pos, duration_seconds, accelerate_seconds, decelerate_seconds );
    wait duration_seconds;
    mover unlink();
    mover delete();
}

// Namespace ztron_item_dawg
// Params 2, eflags: 0x4
// Checksum 0x3ea9bba9, Offset: 0xa32
// Size: 0x10a
function private function_aa2d1090c3470946( player, storebought = 0 )
{
    self endon( #"death" );
    
    if ( storebought == 0 )
    {
        thread function_2db8c1101e846fb2( player );
    }
    else
    {
        thread function_5c1a7f5562f72ff8( player );
    }
    
    while ( self.lifetime_seconds > 0 )
    {
        if ( storebought == 0 )
        {
            msg = player utility::waittill_any_timeout_no_endon_death( 1, "disconnect", "ztron_exit_taken", "ztron_teleporter_taken", "send_dawg_back" );
        }
        else
        {
            msg = player utility::waittill_any_timeout_no_endon_death( 1, "disconnect", "clear_active_item" );
        }
        
        if ( ztron_main::function_4da200e9b8d58a3c() == 1 || ztron_main::function_4da200e9b8d58a3c() == 5 )
        {
            self.lifetime_seconds--;
        }
        
        if ( msg != "timeout" )
        {
            break;
        }
    }
    
    flight_start_pos = self.origin;
    thread function_d1b68932dcfa7066();
    wait 0.2;
    
    if ( msg == "timeout" )
    {
        function_f2d40f311c030c71( flight_start_pos, 500, 20 );
    }
}

// Namespace ztron_item_dawg
// Params 1, eflags: 0xc
// Checksum 0x7d774b84, Offset: 0xb44
// Size: 0xa2
function private function_5c1a7f5562f72ff8( player )
{
    self notify( #"hash_1db227f33fcdeaf0" );
    self endon( #"hash_1db227f33fcdeaf0" );
    self endon( #"death" );
    
    while ( true )
    {
        level utility::waittill_any( "ztron_teleporter_taken", "ztron_slayerportal_taken", "arena_round_leaving", "slayer_event_finished", "arena_completed" );
        thread function_d1b68932dcfa7066( 0 );
        level utility::waittill_any( "round_begin", "ztron_slayer_active" );
        landposition = utility::callsharedfunc( #"player", #"hash_9bc79685259c8dd2" );
        thread function_d30e5fdc666ead48( landposition, 3 );
    }
}

// Namespace ztron_item_dawg
// Params 1, eflags: 0xc
// Checksum 0xcef744bf, Offset: 0xbee
// Size: 0x5c
function private function_2db8c1101e846fb2( player )
{
    self notify( #"hash_1b5b70d33b2b212f" );
    self endon( #"hash_1b5b70d33b2b212f" );
    self endon( #"death" );
    player endon( #"disconnect" );
    level utility::waittill_any( "bonus_room_completed", "slayer_event_finished" );
    player notify( #"send_dawg_back" );
}

// Namespace ztron_item_dawg
// Params 0, eflags: 0xc
// Checksum 0xd03c52de, Offset: 0xc52
// Size: 0x272
function private function_40b6a2f651d24856()
{
    self notify( #"hash_5e4cab582d05775e" );
    self endon( #"hash_5e4cab582d05775e" );
    self endon( #"death" );
    cooldown_seconds = 7;
    wait 2;
    
    while ( self.lifetime_seconds > 0 )
    {
        if ( self.mode == "inactive" )
        {
            self waittill( #"ztron_dawg_active" );
        }
        
        var_8e7fbd6783035d7d = 4 + randomint( 6 );
        var_255232a5c5895cf6 = getaiarrayinradius( self.origin, 1000, zm_utility::get_zombie_team() );
        var_255232a5c5895cf6 = arrayrandomize( var_255232a5c5895cf6 );
        target_array = [];
        
        foreach ( zombie in var_255232a5c5895cf6 )
        {
            if ( !isalive( zombie ) || !zombie getcandamage() )
            {
                continue;
            }
            
            turret_origin = self.turret function_6382f336b5e5cdca( 0 );
            turret_angles = self.turret getturretworldangles( 0 );
            turret_dir = anglestoforward( turret_angles );
            target_dir = zombie.origin - turret_origin;
            delta_angle = math::anglebetweenvectors( turret_dir, target_dir );
            
            if ( delta_angle >= 90 )
            {
                continue;
            }
            
            target_array[ target_array.size ] = zombie.origin;
            
            if ( target_array.size >= var_8e7fbd6783035d7d )
            {
                break;
            }
        }
        
        if ( target_array.size > 0 )
        {
            for ( var_783392678738da58 = 0; target_array.size < var_8e7fbd6783035d7d ; var_783392678738da58 = ( var_783392678738da58 + 1 ) % target_array.size )
            {
                target_array[ target_array.size ] = target_array[ var_783392678738da58 ];
            }
            
            foreach ( target in target_array )
            {
                thread _fire_missile_to_target( target );
                wait 0.3;
            }
            
            wait cooldown_seconds;
            continue;
        }
        
        wait 1;
    }
}

// Namespace ztron_item_dawg
// Params 3, eflags: 0xc
// Checksum 0x8b54d0ff, Offset: 0xecc
// Size: 0x9f
function private function_f2d40f311c030c71( center_position, max_radius, var_8e7fbd6783035d7d )
{
    self notify( #"hash_99b36aebd0c77515" );
    self endon( #"hash_99b36aebd0c77515" );
    angle_delta = 360 / var_8e7fbd6783035d7d;
    position_offset = ( max_radius, 0, 0 );
    
    for ( yaw_index = 0; yaw_index < var_8e7fbd6783035d7d ; yaw_index++ )
    {
        thread _fire_missile_to_target( center_position + position_offset * randomfloatrange( 0.5, 1 ) );
        position_offset = rotatepointaroundvector( ( 0, 0, 1 ), position_offset, angle_delta );
    }
}

// Namespace ztron_item_dawg
// Params 1, eflags: 0x4
// Checksum 0x13665cea, Offset: 0xf73
// Size: 0xcd
function private _fire_missile_to_target( position )
{
    if ( isdefined( self.owner ) )
    {
        fakefireweapon = makeweapon( "sat_ztron_dawg_missile" );
        var_eb1f96c921ef5095 = self.turret gettagorigin( "tag_gunner_flash1" );
        missile_dest = var_eb1f96c921ef5095 + ( position - var_eb1f96c921ef5095 ) * 0.5 + ( 0, 0, 800 );
        proj = weapon_utility::_magicbullet( fakefireweapon, var_eb1f96c921ef5095 + ( 0, 0, 30 ), missile_dest, self.owner );
        wait 0.7;
        
        if ( isdefined( proj ) )
        {
            offset = ( randomintrange( -50, 50 ), randomintrange( -50, 50 ), 0 );
            proj missile_settargetpos( position + offset );
        }
    }
}

