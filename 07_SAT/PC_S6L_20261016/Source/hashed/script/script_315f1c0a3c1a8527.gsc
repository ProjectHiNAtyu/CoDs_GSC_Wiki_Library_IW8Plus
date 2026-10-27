// script_315f1c0a3c1a8527  (hash_315f1c0a3c1a8527.gscc) (size: 2516 Bytes / 0x9d4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x27497bc0 (659127232)
// size ...... 2516 (0x9d4)
// includes .. 3   (offset: 0x8c0)
// strings ... 18  (offset: 0x8d8)
// dev strs .. 0   (offset: 0x9d4)
// exports ... 10  (offset: 0x4d4)
// cseg ...... 0x180 + 0x354 (0x4d4)
// imports ... 21  (offset: 0x664)
// animtree1 . 0   (offset: 0x9d4)
// animtree2 . 0   (offset: 0x9d4)
#using scripts\common\ai\aitypes\shared\zombie\zombie_vox;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace zombie_diana_audio;

// Namespace zombie_diana_audio
// Params 0
// Checksum 0x76fc0152, Offset: 0x19e
// Size: 0xa0
function function_d18a8e4e982c57a4()
{
    if ( utility::flag( "diana_audio" ) )
    {
        return;
    }
    
    utility::flag_set( "diana_audio" );
    zombie_vox::register_vox_state( "ambient", "ambient", "vox_ai_diana_ambient", 1, 3500 );
    zombie_vox::register_vox_state( "arrival", "arrival", "vox_ai_diana_arrival", 3 );
    zombie_vox::register_vox_state( "depart", "depart", "vox_ai_diana_depart", 3 );
    zombie_vox::register_vox_state( "pain", "pain", "vox_ai_diana_pain", 3 );
    zombie_vox::register_vox_state( "projectile_attack", "projectile_attack", "vox_ai_diana_roar", 3 );
    level thread manage_ambient_cap();
}

// Namespace zombie_diana_audio
// Params 0
// Checksum 0x232b678, Offset: 0x246
// Size: 0x26
function init_zombie_diana_audio()
{
    thread play_zombie_ambient_repeating();
    zombie_vox::register_play_vox_fn( &play_zombie_vo );
    callback::add( "killed_body_cloned", &function_7920cd06bcb55c15 );
}

// Namespace zombie_diana_audio
// Params 6, eflags: 0x4
// Checksum 0x75757bd, Offset: 0x274
// Size: 0x47
function private play_zombie_vo( event, zombie, scriptable_state, alias, priority, var_9a3bc44f9b1e1618 )
{
    zombie_vox::function_e7828eef0e4316d6( zombie, scriptable_state, alias, priority, var_9a3bc44f9b1e1618 );
}

// Namespace zombie_diana_audio
// Params 1, eflags: 0x4
// Checksum 0xb577ff1b, Offset: 0x2c3
// Size: 0x62
function private function_7920cd06bcb55c15( params )
{
    assert( isdefined( params.body ) );
    
    if ( isdefined( self ) && self isscriptable() )
    {
        self setscriptablepartstate( "sound_vo", "off" );
    }
    
    level thread play_zombie_vo( "death", params.body, "death", "vox_ai_diana_death", 4 );
}

// Namespace zombie_diana_audio
// Params 0
// Checksum 0x3e8a15b7, Offset: 0x32d
// Size: 0xfe
function play_zombie_ambient_repeating()
{
    var_fd16a9c5c5ac1ab1 = 3;
    self notify( #"hash_b4b9e5da26c7a7ca" );
    self endon( #"hash_b4b9e5da26c7a7ca" );
    self endon( #"hash_4ad5af914cce06a3" );
    self endon( #"death" );
    utility::flag_wait( "scriptables_ready" );
    waitframe();
    var_71ab6a9a43dcf7e6 = undefined;
    
    while ( true )
    {
        params = get_ambient_params();
        var_71ab6a9a43dcf7e6 = params.var_a2ca231ce4d6b000;
        var_520303cc736f6f2d = params.var_d92936facdeb4848;
        
        if ( utility::percent_chance( params.var_dc8cb35f39318c8e ) )
        {
            var_71ab6a9a43dcf7e6 = "ambient";
        }
        else
        {
            var_71ab6a9a43dcf7e6 = undefined;
        }
        
        if ( isdefined( level.var_7538460147be1e93 ) )
        {
            level.var_7538460147be1e93++;
            
            if ( level.var_7538460147be1e93 < var_fd16a9c5c5ac1ab1 )
            {
                var_44bb78e47c206b2b = 1;
                zombie_vox::function_5ac4bed4a907abf5( var_71ab6a9a43dcf7e6 );
                waitframe();
                utility::ent_flag_waitopen_any( "playing_vo" );
            }
        }
        
        wait var_520303cc736f6f2d;
    }
}

// Namespace zombie_diana_audio
// Params 0, eflags: 0x4
// Checksum 0x3cf6c6f3, Offset: 0x433
// Size: 0x41
function private get_ambient_params()
{
    params = spawnstruct();
    params.var_a2ca231ce4d6b000 = "ambient";
    params.var_dc8cb35f39318c8e = 80;
    params.var_d92936facdeb4848 = 5;
    return params;
}

// Namespace zombie_diana_audio
// Params 0, eflags: 0x4
// Checksum 0x36832a74, Offset: 0x47d
// Size: 0x30
function private manage_ambient_cap()
{
    level endon( #"game_ended" );
    level.var_7538460147be1e93 = 0;
    
    while ( true )
    {
        level.var_7538460147be1e93 = 0;
        wait 0.1;
    }
}

// Namespace zombie_diana_audio
// Params 0, eflags: 0x4
// Checksum 0x45c6d2dc, Offset: 0x4b5
// Size: 0xe
function private function_db115bc2080982ff()
{
    self notify( #"hash_4ad5af914cce06a3" );
}

// Namespace zombie_diana_audio
// Params 0, eflags: 0x4
// Checksum 0x9ee7799b, Offset: 0x4cb
// Size: 0x9
function private function_10d5fe00818f9b80()
{
    thread play_zombie_ambient_repeating();
}

