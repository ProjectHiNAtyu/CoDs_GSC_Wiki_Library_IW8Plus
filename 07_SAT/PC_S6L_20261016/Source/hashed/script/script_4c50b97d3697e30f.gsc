// script_4c50b97d3697e30f  (hash_4c50b97d3697e30f.gscc) (size: 5591 Bytes / 0x15d7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbeceab54 (3201215316)
// size ...... 5591 (0x15d7)
// includes .. 4   (offset: 0x12eb)
// strings ... 45  (offset: 0x130b)
// dev strs .. 0   (offset: 0x15d7)
// exports ... 12  (offset: 0xcc7)
// cseg ...... 0x45f + 0x868 (0xcc7)
// imports ... 36  (offset: 0xea7)
// animtree1 . 0   (offset: 0x15d7)
// animtree2 . 0   (offset: 0x15d7)
#using scripts\asm\asm_bb;
#using scripts\common\ai\aitypes\shared\zombie\zombie_vox;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace zombie_hellhound_audio;

// Namespace zombie_hellhound_audio
// Params 0
// Checksum 0x6df0e8b2, Offset: 0x47d
// Size: 0x2c1
function function_6f39238c8dd13230()
{
    if ( utility::flag( "hellhound_audio" ) )
    {
        return;
    }
    
    utility::flag_set( "hellhound_audio" );
    zombie_vox::register_vox_state( "ambient_unaware", "ambient_unaware", "vox_ai_hellhound_ambient_unaware", 1 );
    zombie_vox::register_vox_state( "ambient_aware", "ambient_aware", "vox_ai_hellhound_ambient_aware", 1 );
    zombie_vox::register_vox_state( "breath_inhale_slow", "breath_inhale_slow", "vox_ai_hellhound_breath_inhale_slow", 1 );
    zombie_vox::register_vox_state( "breath_inhale_fast", "breath_inhale_fast", "vox_ai_hellhound_breath_inhale_fast", 1 );
    zombie_vox::register_vox_state( "breath_exhale_slow", "breath_exhale_slow", "vox_ai_hellhound_breath_exhale_slow", 1 );
    zombie_vox::register_vox_state( "breath_exhale_fast", "breath_exhale_fast", "vox_ai_hellhound_breath_exhale_fast", 1 );
    zombie_vox::register_vox_state( "warning_close", "warning_close", "vox_ai_hellhound_warning_close", 2 );
    zombie_vox::register_vox_state( "zombie_pain_start", "pain", "vox_ai_hellhound_pain", 3 );
    zombie_vox::register_vox_state( "bite_vox", "attack", "vox_ai_hellhound_attack", 3 );
    zombie_vox::function_3e1f4a0d10aabdeb( "zombie_methone", "ambient_unaware", "ambient_unaware", "vox_ai_methone_ambient_unaware", 1 );
    zombie_vox::function_3e1f4a0d10aabdeb( "zombie_methone", "ambient_aware", "ambient_aware", "vox_ai_methone_ambient_aware", 1 );
    zombie_vox::function_3e1f4a0d10aabdeb( "zombie_methone", "breath_inhale_slow", "breath_inhale_slow", "vox_ai_methone_breath_inhale_slow", 1 );
    zombie_vox::function_3e1f4a0d10aabdeb( "zombie_methone", "breath_inhale_fast", "breath_inhale_fast", "vox_ai_methone_breath_inhale_fast", 1 );
    zombie_vox::function_3e1f4a0d10aabdeb( "zombie_methone", "breath_exhale_slow", "breath_exhale_slow", "vox_ai_methone_breath_exhale_slow", 1 );
    zombie_vox::function_3e1f4a0d10aabdeb( "zombie_methone", "breath_exhale_slow", "breath_exhale_slow", "vox_ai_methone_breath_exhale_slow", 1 );
    zombie_vox::function_3e1f4a0d10aabdeb( "zombie_methone", "breath_exhale_fast", "breath_exhale_fast", "vox_ai_methone_breath_exhale_fast", 1 );
    zombie_vox::function_3e1f4a0d10aabdeb( "zombie_methone", "warning_close", "warning_close", "vox_ai_methone_warning_close", 2 );
    zombie_vox::function_3e1f4a0d10aabdeb( "zombie_methone", "zombie_pain_start", "pain", "vox_ai_methone_pain", 3 );
    zombie_vox::function_3e1f4a0d10aabdeb( "zombie_methone", "bite_vox", "attack", "vox_ai_methone_attack", 3 );
    level callback::add( #"player_connect", &function_58eee4c1dae92c42, self.basearchetype );
    
    foreach ( player in level.players )
    {
        player thread function_58eee4c1dae92c42( undefined, self.basearchetype );
    }
    
    level thread manage_ambient_cap();
}

// Namespace zombie_hellhound_audio
// Params 0
// Checksum 0x1876788a, Offset: 0x746
// Size: 0x26
function init_zombie_hellhound_audio()
{
    thread play_zombie_ambient_repeating();
    zombie_vox::register_play_vox_fn( &play_zombie_vo );
    callback::add( "killed_body_cloned", &function_7920cd06bcb55c15 );
}

// Namespace zombie_hellhound_audio
// Params 6, eflags: 0x4
// Checksum 0xfd820f4b, Offset: 0x774
// Size: 0x85
function private play_zombie_vo( event, zombie, scriptable_state, alias, priority, var_9a3bc44f9b1e1618 )
{
    switch ( event )
    {
        case #"hash_c29acedba2860c6d":
            zombie zombie_vox::function_bb5be6a2c88bc5f4( utility::function_4b74c15943231980( 1.5 ), 1 );
            break;
        default:
            break;
    }
    
    zombie_vox::function_e7828eef0e4316d6( zombie, scriptable_state, alias, priority, var_9a3bc44f9b1e1618 );
}

// Namespace zombie_hellhound_audio
// Params 1, eflags: 0x4
// Checksum 0xd5ae054f, Offset: 0x801
// Size: 0x5c
function private function_7920cd06bcb55c15( params )
{
    assert( isdefined( params.body ) );
    
    if ( self isscriptable() )
    {
        self setscriptablepartstate( "sound_vo", "off" );
    }
    
    level thread play_zombie_vo( "death", params.body, "death", "vox_ai_hellhound_death", 4 );
}

// Namespace zombie_hellhound_audio
// Params 0
// Checksum 0x62985834, Offset: 0x865
// Size: 0x11b
function play_zombie_ambient_repeating()
{
    var_fd16a9c5c5ac1ab1 = 3;
    self endon( #"death" );
    utility::flag_wait( "scriptables_ready" );
    waitframe();
    var_44bb78e47c206b2b = 0;
    var_a50f94f03edff6b3 = 0;
    var_4c32391f3ad61ce9 = 1;
    
    while ( true )
    {
        params = get_ambient_params();
        
        if ( !var_4c32391f3ad61ce9 )
        {
            if ( utility::percent_chance( params.var_dc8cb35f39318c8e ) || var_a50f94f03edff6b3 >= 5 )
            {
                var_a50f94f03edff6b3 = 0;
                var_71ab6a9a43dcf7e6 = "breath_exhale_" + params.var_b62f076d0acbb721;
            }
            else
            {
                var_a50f94f03edff6b3++;
                var_71ab6a9a43dcf7e6 = "breath_exhale_" + params.var_b62f076d0acbb721;
            }
            
            var_4c32391f3ad61ce9 = 1;
        }
        else
        {
            var_71ab6a9a43dcf7e6 = "breath_inhale_" + params.var_b62f076d0acbb721;
            var_4c32391f3ad61ce9 = 0;
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
        
        waitframe();
    }
}

// Namespace zombie_hellhound_audio
// Params 0, eflags: 0x4
// Checksum 0x48be5aa4, Offset: 0x988
// Size: 0xcf
function private get_ambient_params()
{
    params = spawnstruct();
    params.var_a2ca231ce4d6b000 = "ambient_unaware";
    params.var_b62f076d0acbb721 = "slow";
    params.var_dc8cb35f39318c8e = 1;
    
    if ( isdefined( self.enemy ) )
    {
        params.var_a2ca231ce4d6b000 = "ambient_aware";
        
        if ( asm_bb::bb_movetyperequested( "run" ) || asm_bb::bb_movetyperequested( "sprint" ) || asm_bb::bb_movetyperequested( "super_sprint" ) )
        {
            params.var_b62f076d0acbb721 = "fast";
            params.var_dc8cb35f39318c8e = 1;
        }
        else
        {
            params.var_b62f076d0acbb721 = "slow";
            params.var_dc8cb35f39318c8e = 1;
        }
    }
    
    return params;
}

// Namespace zombie_hellhound_audio
// Params 0, eflags: 0x4
// Checksum 0x76b2ee60, Offset: 0xa60
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

// Namespace zombie_hellhound_audio
// Params 2, eflags: 0x4
// Checksum 0xc2c2ae2f, Offset: 0xa98
// Size: 0x1e
function private function_58eee4c1dae92c42( params, archetype )
{
    thread function_4cc5da5c07ca7685( archetype );
}

// Namespace zombie_hellhound_audio
// Params 1, eflags: 0x4
// Checksum 0xf980d837, Offset: 0xabe
// Size: 0x152
function private function_4cc5da5c07ca7685( archetype )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"death" );
    
    while ( true )
    {
        wait 0.5;
        ai_array = getaiarrayinradius( self.origin, 750 );
        
        if ( isdefined( ai_array ) )
        {
            foreach ( ai in ai_array )
            {
                if ( !( isdefined( ai ) && isdefined( ai.basearchetype ) ) || ai.basearchetype != archetype )
                {
                    continue;
                }
                
                if ( ai.var_af3f040e4e1fb6af )
                {
                    continue;
                }
                
                if ( ai.enemy != self || !isplayer( ai.enemy ) )
                {
                    continue;
                }
                
                if ( is_hellhound_close( ai ) )
                {
                    ai zombie_vox::function_5ac4bed4a907abf5( "warning_close" );
                    ai thread function_befda447b1e3f1dc();
                    wait 0.25;
                }
            }
        }
    }
}

// Namespace zombie_hellhound_audio
// Params 1, eflags: 0x4
// Checksum 0x2eefdf3b, Offset: 0xc18
// Size: 0x80
function private is_hellhound_close( zombie )
{
    dist = 750;
    distance = distance2dsquared( self.origin, zombie.origin );
    var_2cd76410b0a08569 = distance < dist * dist;
    is_too_close = distance < 40000;
    assert( isplayer( zombie.enemy ) );
    
    if ( is_too_close )
    {
        return 0;
    }
    
    return var_2cd76410b0a08569;
}

// Namespace zombie_hellhound_audio
// Params 0, eflags: 0x4
// Checksum 0x3662c3d9, Offset: 0xca1
// Size: 0x26
function private function_befda447b1e3f1dc()
{
    self endon( #"death" );
    self.var_af3f040e4e1fb6af = 1;
    wait 5;
    self.var_af3f040e4e1fb6af = 0;
}

