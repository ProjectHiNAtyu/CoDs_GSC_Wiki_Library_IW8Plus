// scripts\common\ai\aitypes\zombie_abom\zombie_abom_audio.gsc  (hash_25faf487ae3aa165.gscc) (size: 4498 Bytes / 0x1192 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd2ac96a2 (3534526114)
// size ...... 4498 (0x1192)
// includes .. 4   (offset: 0xef2)
// strings ... 39  (offset: 0xf12)
// dev strs .. 0   (offset: 0x1192)
// exports ... 11  (offset: 0xa0e)
// cseg ...... 0x384 + 0x68a (0xa0e)
// imports ... 26  (offset: 0xbc6)
// animtree1 . 0   (offset: 0x1192)
// animtree2 . 0   (offset: 0x1192)
#using scripts\asm\asm_bb;
#using scripts\common\ai\aitypes\shared\zombie\zombie_vox;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace zombie_abom_audio;

// Namespace zombie_abom_audio
// Params 0
// Checksum 0xeb7d8f8d, Offset: 0x3a2
// Size: 0x194
function init_zombie_abom_audio_global()
{
    if ( utility::flag( "abom_audio" ) )
    {
        return;
    }
    
    utility::flag_set( "abom_audio" );
    zombie_vox::register_vox_state( "ambient_unaware", "ambient_unaware", "vox_ai_abom_ambient_unaware", 1 );
    zombie_vox::register_vox_state( "ambient_aware", "ambient_aware", "vox_ai_abom_ambient_aware", 1 );
    zombie_vox::register_vox_state( "roar_start", "roar_start", "vox_ai_abom_roar_start", 3 );
    zombie_vox::register_vox_state( "roar_loop", "roar_loop", "vox_ai_abom_roar_loop", 3 );
    zombie_vox::register_vox_state( "roar_end", "roar_end", "vox_ai_abom_roar_end", 3 );
    zombie_vox::register_vox_state( "pain", "pain", "vox_ai_abom_pain", 3 );
    zombie_vox::register_vox_state( "quick_roar", "quick_roar", "vox_ai_abom_quick_roar", 3 );
    zombie_vox::register_vox_state( "breath_inhale", "breath_inhale", "vox_ai_abom_unaware_inhale", 1, 2225 );
    zombie_vox::register_vox_state( "breath_exhale", "breath_exhale", "vox_ai_abom_unaware_exhale", 1, 2225 );
    zombie_vox::function_3e1f4a0d10aabdeb( "zombie_abom_mega", "breath_inhale", "breath_inhale", "vox_ai_abom_mega_unaware_inhale", 3 );
    zombie_vox::function_3e1f4a0d10aabdeb( "zombie_abom_mega", "breath_exhale", "breath_exhale", "vox_ai_abom_mega_unaware_exhale", 3 );
    zombie_vox::function_3e1f4a0d10aabdeb( "zombie_abom_mega", "roar_start", "roar_start", "vox_ai_abom_mega_roar_start", 3 );
    zombie_vox::function_3e1f4a0d10aabdeb( "zombie_abom_mega", "roar_loop", "roar_loop", "vox_ai_abom_mega_roar_loop", 3 );
    zombie_vox::function_3e1f4a0d10aabdeb( "zombie_abom_mega", "roar_end", "roar_end", "vox_ai_abom_mega_roar_end", 3 );
    level thread manage_ambient_cap();
}

// Namespace zombie_abom_audio
// Params 0
// Checksum 0x9c9d95d0, Offset: 0x53e
// Size: 0x26
function init_zombie_abom_audio()
{
    thread play_zombie_ambient_repeating();
    zombie_vox::register_play_vox_fn( &play_zombie_vo );
    callback::add( "killed_body_cloned", &function_7920cd06bcb55c15 );
}

// Namespace zombie_abom_audio
// Params 6, eflags: 0x4
// Checksum 0xa5b0d148, Offset: 0x56c
// Size: 0xb8
function private play_zombie_vo( event, zombie, scriptable_state, alias, priority, var_9a3bc44f9b1e1618 )
{
    switch ( event )
    {
        case #"hash_a6ff7cd9f24bf577":
            if ( zombie isscriptable() )
            {
                zombie setscriptablepartstate( "sound_vo", "roar_loop" );
                zombie notify( #"hash_5ecce2eb6bdf4968" );
                zombie function_db115bc2080982ff();
            }
            
            return;
        case #"hash_9c129a1f158d2d10":
            zombie function_10d5fe00818f9b80();
            break;
        default:
            break;
    }
    
    zombie_vox::function_e7828eef0e4316d6( zombie, scriptable_state, alias, priority, var_9a3bc44f9b1e1618 );
}

// Namespace zombie_abom_audio
// Params 1, eflags: 0x4
// Checksum 0xb8839230, Offset: 0x62c
// Size: 0xa4
function private function_7920cd06bcb55c15( params )
{
    assert( isdefined( params.body ) );
    
    if ( isdefined( self ) && self isscriptable() )
    {
        self setscriptablepartstate( "sound_vo", "off" );
    }
    
    if ( isdefined( self ) && issubstr( self.subclass, "mega" ) )
    {
        level thread play_zombie_vo( "death", params.body, "death", "vox_ai_abom_mega_death", 4 );
        return;
    }
    
    level thread play_zombie_vo( "death", params.body, "death", "vox_ai_abom_death", 4 );
}

// Namespace zombie_abom_audio
// Params 0
// Checksum 0x1d45c1da, Offset: 0x6d8
// Size: 0x138
function play_zombie_ambient_repeating()
{
    var_fd16a9c5c5ac1ab1 = 3;
    self notify( #"hash_b4b9e5da26c7a7ca" );
    self endon( #"hash_b4b9e5da26c7a7ca" );
    self endon( #"hash_4ad5af914cce06a3" );
    self endon( #"death" );
    utility::flag_wait( "scriptables_ready" );
    waitframe();
    var_44bb78e47c206b2b = 0;
    var_a50f94f03edff6b3 = 0;
    var_71ab6a9a43dcf7e6 = undefined;
    var_4c32391f3ad61ce9 = 1;
    
    while ( true )
    {
        params = function_d58d7d8c08edf7e7();
        
        if ( params.var_a2ca231ce4d6b000 == "ambient_aware" )
        {
            wait 1;
            continue;
        }
        
        if ( !var_4c32391f3ad61ce9 )
        {
            if ( utility::percent_chance( params.var_dc8cb35f39318c8e ) || var_a50f94f03edff6b3 >= 5 )
            {
                var_a50f94f03edff6b3 = 0;
                var_71ab6a9a43dcf7e6 = "breath_exhale";
            }
            else
            {
                var_a50f94f03edff6b3++;
                var_71ab6a9a43dcf7e6 = "breath_exhale";
            }
            
            var_4c32391f3ad61ce9 = 1;
        }
        else
        {
            var_71ab6a9a43dcf7e6 = "breath_inhale";
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

// Namespace zombie_abom_audio
// Params 0, eflags: 0x4
// Checksum 0x1955a5cf, Offset: 0x818
// Size: 0xcf
function private get_ambient_params()
{
    params = spawnstruct();
    params.var_a2ca231ce4d6b000 = "ambient_unaware";
    params.var_b62f076d0acbb721 = "slow";
    params.var_dc8cb35f39318c8e = 80;
    
    if ( isdefined( self.enemy ) )
    {
        params.var_a2ca231ce4d6b000 = "ambient_aware";
        
        if ( asm_bb::bb_movetyperequested( "run" ) || asm_bb::bb_movetyperequested( "sprint" ) || asm_bb::bb_movetyperequested( "super_sprint" ) )
        {
            params.var_b62f076d0acbb721 = "fast";
            params.var_dc8cb35f39318c8e = 100;
        }
        else
        {
            params.var_b62f076d0acbb721 = "slow";
            params.var_dc8cb35f39318c8e = 80;
        }
    }
    
    return params;
}

// Namespace zombie_abom_audio
// Params 0, eflags: 0x4
// Checksum 0xecff1d15, Offset: 0x8f0
// Size: 0xbe
function private function_d58d7d8c08edf7e7()
{
    params = spawnstruct();
    params.var_a2ca231ce4d6b000 = "ambient_unaware";
    params.var_dc8cb35f39318c8e = 100;
    
    if ( isdefined( self.enemy ) )
    {
        params.var_a2ca231ce4d6b000 = "ambient_aware";
        
        if ( asm_bb::bb_movetyperequested( "run" ) || asm_bb::bb_movetyperequested( "sprint" ) || asm_bb::bb_movetyperequested( "super_sprint" ) )
        {
            params.var_b62f076d0acbb721 = "fast";
            params.var_dc8cb35f39318c8e = 100;
        }
        else
        {
            params.var_b62f076d0acbb721 = "slow";
            params.var_dc8cb35f39318c8e = 80;
        }
    }
    
    return params;
}

// Namespace zombie_abom_audio
// Params 0, eflags: 0x4
// Checksum 0xf43f6e6a, Offset: 0x9b7
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

// Namespace zombie_abom_audio
// Params 0, eflags: 0x4
// Checksum 0x877a96c2, Offset: 0x9ef
// Size: 0xe
function private function_db115bc2080982ff()
{
    self notify( #"hash_4ad5af914cce06a3" );
}

// Namespace zombie_abom_audio
// Params 0, eflags: 0x4
// Checksum 0x1812474d, Offset: 0xa05
// Size: 0x9
function private function_10d5fe00818f9b80()
{
    thread play_zombie_ambient_repeating();
}

