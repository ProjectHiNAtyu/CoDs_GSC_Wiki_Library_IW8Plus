// scripts\common\ai\aitypes\zombie_callisto\zombie_callisto_audio.gsc  (hash_1942f44d7f6a65e1.gscc) (size: 2558 Bytes / 0x9fe / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x74a250f0 (1956794608)
// size ...... 2558 (0x9fe)
// includes .. 3   (offset: 0x896)
// strings ... 24  (offset: 0x8ae)
// dev strs .. 0   (offset: 0x9fe)
// exports ... 9   (offset: 0x54a)
// cseg ...... 0x232 + 0x318 (0x54a)
// imports ... 16  (offset: 0x6b2)
// animtree1 . 0   (offset: 0x9fe)
// animtree2 . 0   (offset: 0x9fe)
#using scripts\common\ai\aitypes\shared\zombie\zombie_vox;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace zombie_callisto_audio;

// Namespace zombie_callisto_audio
// Params 0
// Checksum 0xc3b3156f, Offset: 0x250
// Size: 0x118
function function_82e9556dc07c7882()
{
    if ( utility::flag( "callisto_audio" ) )
    {
        return;
    }
    
    utility::flag_set( "callisto_audio" );
    zombie_vox::register_vox_state( "ambient", "ambient", "vox_ai_cali_ambient", 1, 3000 );
    zombie_vox::register_vox_state( "ambient_grunt", "ambient_grunt", "vox_ai_cali_ambient_grunt", 1, 1300 );
    zombie_vox::register_vox_state( "charge_in_roar", "charge_in_roar", "vox_ai_cali_charge_in_roar", 3, 1600 );
    zombie_vox::register_vox_state( "charge_end", "charge_end", "vox_ai_cali_charge_end", 3, 1000 );
    zombie_vox::register_vox_state( "gut_throw_roar", "gut_throw_roar", "vox_ai_cali_gut_throw_roar", 3, 1600 );
    zombie_vox::register_vox_state( "pain", "pain", "vox_ai_cali_pain", 3, 1200 );
    zombie_vox::register_vox_state( "attack_bite", "attack_bite", "vox_ai_cali_attack_bite", 3, 2500 );
    zombie_vox::register_vox_state( "attack_claw", "attack_claw", "vox_ai_cali_attack_claw", 3, 2500 );
    zombie_vox::register_vox_state( "swarm_roar_start", "swarm_roar_start", "vox_ai_cali_swarm_roar_start", 3, 500 );
    level thread manage_ambient_cap();
}

// Namespace zombie_callisto_audio
// Params 0
// Checksum 0x4f7584ff, Offset: 0x370
// Size: 0x1a
function init_zombie_callisto_audio()
{
    thread play_zombie_ambient_repeating();
    callback::add( "killed_body_cloned", &function_7920cd06bcb55c15 );
}

// Namespace zombie_callisto_audio
// Params 1, eflags: 0x4
// Checksum 0x7323d1ed, Offset: 0x392
// Size: 0x3e
function private function_7920cd06bcb55c15( params )
{
    assert( isdefined( params.body ) );
    
    if ( isdefined( self ) && self isscriptable() )
    {
        self setscriptablepartstate( "sound_vo", "off" );
    }
}

// Namespace zombie_callisto_audio
// Params 0
// Checksum 0x63d9e5fb, Offset: 0x3d8
// Size: 0xc5
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
    
    while ( true )
    {
        params = get_ambient_params();
        
        if ( isdefined( level.var_7538460147be1e93 ) )
        {
            level.var_7538460147be1e93++;
            
            if ( level.var_7538460147be1e93 < var_fd16a9c5c5ac1ab1 )
            {
                var_44bb78e47c206b2b = 1;
                zombie_vox::function_5ac4bed4a907abf5( params.var_a2ca231ce4d6b000 );
                waitframe();
                utility::ent_flag_waitopen_any( "playing_vo" );
            }
        }
        
        waitframe();
    }
}

// Namespace zombie_callisto_audio
// Params 0, eflags: 0x4
// Checksum 0xe76153b5, Offset: 0x4a5
// Size: 0x45
function private get_ambient_params()
{
    params = spawnstruct();
    
    if ( randomint( 100 ) < 25 )
    {
        params.var_a2ca231ce4d6b000 = "ambient";
    }
    else
    {
        params.var_a2ca231ce4d6b000 = "ambient_grunt";
    }
    
    return params;
}

// Namespace zombie_callisto_audio
// Params 0, eflags: 0x4
// Checksum 0xe239e754, Offset: 0x4f3
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

// Namespace zombie_callisto_audio
// Params 0, eflags: 0x4
// Checksum 0x917c1ffc, Offset: 0x52b
// Size: 0xe
function private function_db115bc2080982ff()
{
    self notify( #"hash_4ad5af914cce06a3" );
}

// Namespace zombie_callisto_audio
// Params 0, eflags: 0x4
// Checksum 0xa371c6f7, Offset: 0x541
// Size: 0x9
function private function_10d5fe00818f9b80()
{
    thread play_zombie_ambient_repeating();
}

