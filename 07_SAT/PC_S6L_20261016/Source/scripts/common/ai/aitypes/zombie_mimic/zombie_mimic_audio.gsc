// scripts\common\ai\aitypes\zombie_mimic\zombie_mimic_audio.gsc  (hash_2b2668e14790af3f.gscc) (size: 4244 Bytes / 0x1094 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbe44ed7b (3192188283)
// size ...... 4244 (0x1094)
// includes .. 4   (offset: 0xe44)
// strings ... 38  (offset: 0xe64)
// dev strs .. 0   (offset: 0x1094)
// exports ... 11  (offset: 0x95c)
// cseg ...... 0x392 + 0x5ca (0x95c)
// imports ... 26  (offset: 0xb14)
// animtree1 . 0   (offset: 0x1094)
// animtree2 . 0   (offset: 0x1094)
#using scripts\common\ai\aitypes\shared\zombie\zombie_vox;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_mimic_audio;

// Namespace zombie_mimic_audio
// Params 0
// Checksum 0x5cd053bf, Offset: 0x3b0
// Size: 0x1d5
function init_zombie_mimic_audio_global()
{
    if ( utility::flag( "mimic_audio" ) )
    {
        return;
    }
    
    utility::flag_set( "mimic_audio" );
    zombie_vox::register_vox_state( "vox_amb_slow", "vox_amb_slow", "vox_ai_mimic_ambient_slow", 1 );
    zombie_vox::register_vox_state( "vox_amb_fast", "vox_amb_fast", "vox_ai_mimic_ambient_fast", 1 );
    zombie_vox::register_vox_state( "vox_scream", "vox_scream", "vox_ai_mimic_ambient_scream", 2 );
    zombie_vox::register_vox_state( "vox_pushback_scream", "vox_scream", "vox_ai_mimic_ambient_scream", 3 );
    zombie_vox::register_vox_state( "vox_scream_long", "vox_scream_long", "vox_ai_mimic_ambient_scream_long", 2 );
    zombie_vox::register_vox_state( "vox_melee", "vox_melee", "vox_ai_mimic_attack_melee", 2 );
    zombie_vox::register_vox_state( "vox_tentacle_out", "vox_tentacle_out", "vox_ai_mimic_attack_tentacle_out", 3 );
    zombie_vox::register_vox_state( "vox_tentacle_in", "vox_tentacle_in", "vox_ai_mimic_attack_tentacle_in", 3 );
    zombie_vox::register_vox_state( "vox_spit", "vox_spit", "vox_ai_mimic_attack_spit_start", 3 );
    zombie_vox::register_vox_state( "vox_spit_tail", "vox_spit_tail", "vox_ai_mimic_attack_spit_tail", 3 );
    zombie_vox::register_vox_state( "vox_appear", "vox_appear", "vox_ai_mimic_appear", 3 );
    zombie_vox::register_vox_state( "pain_electric_vox", "pain_electric", "vox_ai_mimic_pain_electric", 3 );
    zombie_vox::register_vox_state( "electric_attack", "electric_attack", "vox_ai_mimic_attack_electric", 3 );
    zombie_vox::register_vox_state( "vox_death", "vox_death", "vox_ai_mimic_death", 4 );
    level thread manage_ambient_cap();
    callback::get_template( self.animsetname ) callback::add( "killed_body_cloned", &function_7920cd06bcb55c15 );
    callback::get_template( self.animsetname ) callback::add( "on_entity_revealed", &on_entity_revealed_audio );
    callback::get_template( self.animsetname ) callback::add( "on_entity_hidden_in_prop", &function_27d7a8919230994f );
}

// Namespace zombie_mimic_audio
// Params 0
// Checksum 0x4bfb94e5, Offset: 0x58d
// Size: 0x10
function init_zombie_mimic_audio()
{
    thread play_zombie_ambient_repeating();
    thread function_766ba59e03e10e0b();
}

// Namespace zombie_mimic_audio
// Params 0, eflags: 0x4
// Checksum 0x86f5e104, Offset: 0x5a5
// Size: 0xf0
function private function_766ba59e03e10e0b()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        notifies = [ "vox_scream_long", "vox_melee", "vox_tentacle_out", "vox_spit", "vox_appear", "vox_tentacle_in" ];
        event = utility::waittill_any_in_array_return( notifies );
        
        switch ( event )
        {
            case #"hash_61c966d3596089cd":
            case #"hash_a7b8c1e16ee6914e":
            case #"hash_bab03b3033b60dc5":
            case #"hash_c43a5c8334deed2e":
            case #"hash_d7d7d13d52c04cdd":
                thread function_6c82a921b18943a4( 1.75 );
                break;
            case #"hash_3790fac69eee7c05":
            default:
                thread function_6c82a921b18943a4( 1 );
                break;
        }
    }
}

// Namespace zombie_mimic_audio
// Params 1, eflags: 0x4
// Checksum 0xf6a8e00c, Offset: 0x69d
// Size: 0x67
function private function_7920cd06bcb55c15( params )
{
    assert( isdefined( params.body ) );
    
    if ( isdefined( self ) )
    {
        var_41fd1f667b65256d = zombie_vox::function_60b4e7f5dcc09735();
        
        if ( function_9ab89894f4bcc56c( var_41fd1f667b65256d ) )
        {
            self stopsoundchannel( var_41fd1f667b65256d );
        }
    }
    
    level thread zombie_vox::function_e7828eef0e4316d6( params.body, "vox_death", "vox_ai_mimic_death", 4 );
}

// Namespace zombie_mimic_audio
// Params 1, eflags: 0x4
// Checksum 0xde70cb95, Offset: 0x70c
// Size: 0x2b
function private on_entity_revealed_audio( params )
{
    thread play_zombie_ambient_repeating();
    
    if ( self isscriptable() )
    {
        self setscriptablepartstate( "sound_event", "emerge" );
    }
}

// Namespace zombie_mimic_audio
// Params 1, eflags: 0x4
// Checksum 0xa9b93c42, Offset: 0x73f
// Size: 0x30
function private function_27d7a8919230994f( params )
{
    self notify( #"hash_4ad5af914cce06a3" );
    
    if ( self isscriptable() )
    {
        self setscriptablepartstate( "sound_event", "hide" );
    }
}

// Namespace zombie_mimic_audio
// Params 1, eflags: 0x4
// Checksum 0xa11ab61b, Offset: 0x777
// Size: 0x46
function private function_6c82a921b18943a4( n_time )
{
    self notify( #"hash_4dd0846f049df62a" );
    self endon( #"hash_4dd0846f049df62a" );
    self endon( #"death" );
    self notify( #"hash_4ad5af914cce06a3" );
    wait n_time;
    thread play_zombie_ambient_repeating();
}

// Namespace zombie_mimic_audio
// Params 0
// Checksum 0x3152f666, Offset: 0x7c5
// Size: 0xf1
function play_zombie_ambient_repeating()
{
    var_fd16a9c5c5ac1ab1 = 3;
    self notify( #"hash_b4b9e5da26c7a7ca" );
    self endon( #"hash_b4b9e5da26c7a7ca" );
    self endon( #"hash_4ad5af914cce06a3" );
    self endon( #"death" );
    utility::flag_wait( "scriptables_ready" );
    waitframe();
    var_861a8884cf0a92d0 = 0;
    
    while ( true )
    {
        if ( !val::get( "play_ambient_vo" ) )
        {
            wait 1;
            continue;
        }
        
        params = get_ambient_params();
        var_71ab6a9a43dcf7e6 = params.var_a2ca231ce4d6b000;
        var_520303cc736f6f2d = params.var_d92936facdeb4848;
        
        if ( isdefined( level.var_7538460147be1e93 ) )
        {
            level.var_7538460147be1e93++;
            
            if ( level.var_7538460147be1e93 < var_fd16a9c5c5ac1ab1 )
            {
                zombie_vox::function_5ac4bed4a907abf5( var_71ab6a9a43dcf7e6 );
                waitframe();
                utility::ent_flag_waitopen_any( "playing_vo" );
            }
        }
        
        wait 0.1;
    }
}

// Namespace zombie_mimic_audio
// Params 0, eflags: 0x4
// Checksum 0xa3ddff1c, Offset: 0x8be
// Size: 0x65
function private get_ambient_params()
{
    params = spawnstruct();
    params.var_a2ca231ce4d6b000 = "vox_amb_slow";
    params.var_d92936facdeb4848 = 1.4;
    
    if ( isdefined( self.enemy ) )
    {
        params.var_a2ca231ce4d6b000 = "vox_amb_fast";
        params.var_d92936facdeb4848 = 0.7;
    }
    
    return params;
}

// Namespace zombie_mimic_audio
// Params 0, eflags: 0x4
// Checksum 0xd798b182, Offset: 0x92c
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

