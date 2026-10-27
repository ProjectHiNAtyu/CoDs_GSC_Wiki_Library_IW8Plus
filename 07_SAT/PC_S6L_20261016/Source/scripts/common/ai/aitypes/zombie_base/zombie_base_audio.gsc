// scripts\common\ai\aitypes\zombie_base\zombie_base_audio.gsc  (hash_791efa6e26314cd5.gscc) (size: 7941 Bytes / 0x1f05 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7f0252a4 (2130858660)
// size ...... 7941 (0x1f05)
// includes .. 9   (offset: 0x1afd)
// strings ... 62  (offset: 0x1b45)
// dev strs .. 0   (offset: 0x1f05)
// exports ... 16  (offset: 0x1155)
// cseg ...... 0x4f3 + 0xc62 (0x1155)
// imports ... 59  (offset: 0x13d5)
// animtree1 . 0   (offset: 0x1f05)
// animtree2 . 0   (offset: 0x1f05)
#using scripts\asm\asm_bb;
#using scripts\common\ai\aitypes\shared\zombie\zombie_vox;
#using scripts\common\ai\aitypes\zombie_base\zombie_base_dismemberment;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\audio_utility;

#namespace zombie_base_audio;

// Namespace zombie_base_audio
// Params 0
// Checksum 0x7f213ead, Offset: 0x511
// Size: 0x37f
function init_zombie_base_audio_global()
{
    if ( utility::flag( "zombie_base_audio" ) )
    {
        return;
    }
    
    utility::flag_set( "zombie_base_audio" );
    zombie_vox::register_vox_state( "spawn", "spawn", "vox_ai_zombie_spawn", 2, 500 );
    zombie_vox::register_vox_state( "ambient_normal", "ambient_normal", "vox_ai_zombie_ambient", 1, 2500 );
    zombie_vox::register_vox_state( "ambient_crawl", "ambient_crawl", "vox_ai_zombie_crawl", 1, 2500 );
    zombie_vox::register_vox_state( "ambient_sprint", "ambient_sprint", "vox_ai_zombie_sprint", 1, 3000 );
    zombie_vox::register_vox_state( "ambient_investigate", "ambient_investigate", "vox_ai_zombie_investigate", 1, 2500 );
    zombie_vox::register_vox_state( "ambient_redzone", "ambient_redzone", "vox_ai_zombie_ambient_redzone", 1, 2500 );
    zombie_vox::register_vox_state( "ambient_lowgrav", "ambient_lowgrav", "vox_ai_zombie_ambient_lowgrav", 1, 2500 );
    zombie_vox::register_vox_state( "anim_redzone", "anim_redzone", "vox_ai_zombie_idle_to_aware", 1, 2500 );
    zombie_vox::register_vox_state( "zombie_pain_start", "pain", "vox_ai_zombie_pain", 2, 200 );
    zombie_vox::register_vox_state( "pain_electric_vox", "pain_electric", "vox_ai_zombie_pain_electric", 3, 1500 );
    zombie_vox::register_vox_state( "melee_vox", "attack", "vox_ai_zombie_attack", 2, 300 );
    zombie_vox::register_vox_state( "toss_vox", "throw", "vox_ai_zombie_attack", 2, 300 );
    zombie_vox::register_vox_state( "behind_vox", "behind", "vox_ai_zombie_behind", 3, 2600 );
    zombie_vox::register_vox_state( "zombie_transform", "transform", "vox_ai_zombie_transform", 3, 1500 );
    zombie_vox::function_3e1f4a0d10aabdeb( "zombie_base_abom_crawler", "ambient_normal", "ambient_normal", "vox_ai_abom_crawl_ambient", 1, 1500 );
    zombie_vox::function_3e1f4a0d10aabdeb( "zombie_base_abom_crawler", "ambient_crawl", "ambient_normal", "vox_ai_abom_crawl_ambient", 1, 1500 );
    zombie_vox::function_3e1f4a0d10aabdeb( "zombie_base_abom_crawler", "ambient_sprint", "ambient_normal", "vox_ai_abom_crawl_ambient", 1, 1500 );
    zombie_vox::function_3e1f4a0d10aabdeb( "zombie_base_abom_crawler", "ambient_investigate", "ambient_normal", "vox_ai_abom_crawl_ambient", 1, 1500 );
    zombie_vox::function_3e1f4a0d10aabdeb( "zombie_base_abom_crawler", "ambient_redzone", "ambient_normal", "vox_ai_abom_crawl_ambient", 1, 1500 );
    level callback::add( #"player_connect", &function_e5163a9e84ebf8dd, self.basearchetype );
    level callback::add( #"player_spawned", &function_e430de4ec76f3d35, self.basearchetype );
    level.var_1489e624e989670 = throttle::throttle_initialize( "zombie_behind_vo_throttle", 1, undefined, 5 );
    
    foreach ( player in level.players )
    {
        player thread function_e5163a9e84ebf8dd( undefined, self.basearchetype );
    }
    
    level thread manage_ambient_cap();
    callback::get_template( self.animsetname ) callback::add( "killed_body_cloned", &function_7920cd06bcb55c15 );
    callback::get_template( self.animsetname ) callback::add( "shocked", &function_51175f48624a6788 );
    callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_damaged", &function_2be843e3414ac34d );
    thread function_5b9514e060bb4725();
}

// Namespace zombie_base_audio
// Params 0
// Checksum 0xa579b369, Offset: 0x898
// Size: 0x2b
function init_zombie_base_audio()
{
    thread play_zombie_ambient_repeating();
    zombie_vox::register_play_vox_fn( &play_zombie_vo );
    utility::delaycall( 1, &setentitysoundcontext, "gender", "zombie" );
}

// Namespace zombie_base_audio
// Params 0
// Checksum 0x2e57bd13, Offset: 0x8cb
// Size: 0x1b
function function_5b9514e060bb4725()
{
    level endon( #"game_ended" );
    waittillframeend();
    thread audio_utility::snd_transient_load( "zm_ai_zombie_base" );
}

// Namespace zombie_base_audio
// Params 6, eflags: 0x4
// Checksum 0x86f5a951, Offset: 0x8ee
// Size: 0xa3
function private play_zombie_vo( event, zombie, scriptable_state, alias, priority, var_9a3bc44f9b1e1618 )
{
    if ( !zombie val::get( "allow_vo" ) )
    {
        return;
    }
    
    switch ( event )
    {
        case #"hash_17116e75dd0568d1":
        case #"hash_b694a70b9092bed1":
            zombie zombie_vox::function_bb5be6a2c88bc5f4( utility::function_4b74c15943231980( 1.5 ), 1 );
            break;
        default:
            break;
    }
    
    zombie_vox::function_e7828eef0e4316d6( zombie, scriptable_state, alias, priority, var_9a3bc44f9b1e1618 );
}

// Namespace zombie_base_audio
// Params 1, eflags: 0x4
// Checksum 0x7ce8900a, Offset: 0x999
// Size: 0x10e
function private function_7920cd06bcb55c15( params )
{
    if ( !isdefined( params.body ) )
    {
        return;
    }
    
    if ( self.var_b387b5c15ccd406 )
    {
        return;
    }
    
    if ( isdefined( self ) )
    {
        if ( self isscriptable() )
        {
            utility::function_7c10ea82c1e305b8( "sound_vo", "off" );
        }
        
        if ( !val::get( "allow_vo" ) )
        {
            return;
        }
        
        var_41fd1f667b65256d = zombie_vox::function_60b4e7f5dcc09735();
        
        if ( function_9ab89894f4bcc56c( var_41fd1f667b65256d ) )
        {
            self stopsoundchannel( var_41fd1f667b65256d );
        }
    }
    
    var_6c792fb6dfa2db61 = "death";
    
    if ( isdefined( self.var_f7d02d1022565946 ) )
    {
        var_6c792fb6dfa2db61 = self.var_f7d02d1022565946;
    }
    
    if ( isdefined( self ) && self.subclass == "zombie_base_abom_crawler" )
    {
        level thread play_zombie_vo( "abom_crawl_death", params.body, "abom_crawl_death", "vox_ai_abom_crawl_death", 4 );
        return;
    }
    
    if ( !params.var_b387b5c15ccd406 )
    {
        level thread play_zombie_vo( var_6c792fb6dfa2db61, params.body, var_6c792fb6dfa2db61, "vox_ai_zombie_death", 4 );
    }
}

// Namespace zombie_base_audio
// Params 1, eflags: 0x4
// Checksum 0xb9cd25ce, Offset: 0xaaf
// Size: 0x4b
function private function_2be843e3414ac34d( params )
{
    if ( !val::get( "allow_vo" ) )
    {
        return;
    }
    
    if ( gettime() < self.var_c192ef94a97cd79e )
    {
        return;
    }
    
    self.var_c192ef94a97cd79e = gettime() + 1000;
    zombie_vox::function_5ac4bed4a907abf5( "zombie_pain_start" );
}

// Namespace zombie_base_audio
// Params 1, eflags: 0x4
// Checksum 0xd3e6bfa, Offset: 0xb02
// Size: 0x18
function private function_51175f48624a6788( params )
{
    zombie_vox::function_5ac4bed4a907abf5( "pain_electric_vox" );
}

// Namespace zombie_base_audio
// Params 0
// Checksum 0x81503375, Offset: 0xb22
// Size: 0x143
function play_zombie_ambient_repeating()
{
    var_fd16a9c5c5ac1ab1 = 3;
    self endon( #"death" );
    utility::flag_wait( "scriptables_ready" );
    waitframe();
    
    if ( !isdefined( level.var_15379cdf516d01bd ) )
    {
        level.var_15379cdf516d01bd = throttle::throttle_initialize( "play_zombie_ambient_repeating", 20 );
    }
    
    wait randomfloatrange( 0.2, 0.85 );
    zombie_vox::function_5ac4bed4a907abf5( "spawn" );
    waitframe();
    utility::ent_flag_waitopen_any( "playing_vo" );
    var_44bb78e47c206b2b = 0;
    
    while ( true )
    {
        throttle::throttle_wait_in_queue( level.var_15379cdf516d01bd, self );
        
        if ( self.subclass == "zombie_base_abom_crawler" )
        {
            if ( self.movemode == "stop" )
            {
                wait 1;
                continue;
            }
        }
        
        if ( !val::get( "play_ambient_vo" ) )
        {
            wait 1;
            continue;
        }
        
        if ( isdefined( level.var_7538460147be1e93 ) )
        {
            level.var_7538460147be1e93++;
            
            if ( level.var_7538460147be1e93 < var_fd16a9c5c5ac1ab1 )
            {
                var_44bb78e47c206b2b = 1;
                var_71ab6a9a43dcf7e6 = get_ambient_notify();
                zombie_vox::function_5ac4bed4a907abf5( var_71ab6a9a43dcf7e6 );
                waitframe();
                utility::ent_flag_waitopen_any( "playing_vo" );
            }
        }
        
        if ( var_44bb78e47c206b2b )
        {
            var_44bb78e47c206b2b = 0;
            wait randomfloatrange( 0.3, 1 );
            continue;
        }
        
        wait 0.1;
    }
}

// Namespace zombie_base_audio
// Params 0, eflags: 0x4
// Checksum 0x37bbb945, Offset: 0xc6d
// Size: 0xe4
function private get_ambient_notify()
{
    if ( self._blackboard.var_ea5eb773cb969ee1 )
    {
        return "ambient_redzone";
    }
    
    if ( utility::ent_flag( "in_low_grav" ) )
    {
        return "ambient_lowgrav";
    }
    
    if ( isdefined( self.enemy ) )
    {
        if ( zombie_base_dismemberment::is_crawling() )
        {
            return "ambient_crawl";
        }
        else if ( asm_bb::bb_movetyperequested( "run" ) || asm_bb::bb_movetyperequested( "sprint" ) || asm_bb::bb_movetyperequested( "super_sprint" ) )
        {
            return "ambient_sprint";
        }
        else if ( asm_bb::bb_movetyperequested( "wander_agitated" ) )
        {
            return "ambient_redzone";
        }
        else if ( asm_bb::bb_movetyperequested( "investigate" ) )
        {
            return "ambient_investigate";
        }
    }
    else if ( asm_bb::bb_movetyperequested( "wander_agitated" ) )
    {
        return "ambient_redzone";
    }
    else if ( asm_bb::bb_movetyperequested( "investigate" ) )
    {
        return "ambient_investigate";
    }
    
    return "ambient_normal";
}

// Namespace zombie_base_audio
// Params 0, eflags: 0x4
// Checksum 0x261454b4, Offset: 0xd5a
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

// Namespace zombie_base_audio
// Params 2, eflags: 0x4
// Checksum 0x710c0d0b, Offset: 0xd92
// Size: 0x27
function private function_e5163a9e84ebf8dd( params, archetype )
{
    if ( !isbot( self ) )
    {
        thread function_57e9892c9249c859( archetype );
    }
}

// Namespace zombie_base_audio
// Params 2, eflags: 0x4
// Checksum 0x34fe13eb, Offset: 0xdc1
// Size: 0x27
function private function_e430de4ec76f3d35( params, archetype )
{
    if ( !isbot( self ) )
    {
        thread function_57e9892c9249c859( archetype );
    }
}

// Namespace zombie_base_audio
// Params 1, eflags: 0xc
// Checksum 0xf9c590e8, Offset: 0xdf0
// Size: 0x1ad
function private function_57e9892c9249c859( archetype )
{
    self notify( #"hash_116d1404d861a91b" );
    self endon( #"hash_116d1404d861a91b" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"death" );
    
    while ( true )
    {
        wait 0.5;
        throttle::throttle_wait_in_queue( level.var_1489e624e989670, self );
        var_6756cbca40e7210a = 250;
        ai_array = getaiarrayinradius( self.origin, var_6756cbca40e7210a );
        
        if ( isdefined( ai_array ) )
        {
            foreach ( ai in ai_array )
            {
                if ( !( isdefined( ai ) && isdefined( ai.basearchetype ) ) || ai.basearchetype != archetype )
                {
                    continue;
                }
                
                if ( ai.var_647e0dd4847547fb )
                {
                    continue;
                }
                
                if ( ai.enemy != self || !isplayer( ai.enemy ) )
                {
                    continue;
                }
                
                var_e2aad1c3ea9c1c0b = function_fd19cdf98bd90a07( ai );
                
                if ( isdefined( var_e2aad1c3ea9c1c0b ) )
                {
                    ai zombie_vox::function_5ac4bed4a907abf5( var_e2aad1c3ea9c1c0b );
                    
                    if ( var_e2aad1c3ea9c1c0b == "behind_vox" )
                    {
                        ai thread zombie_behind_vox_cooldown( 5 );
                    }
                    else
                    {
                        ai thread zombie_behind_vox_cooldown( 2.5 );
                    }
                    
                    wait 0.3;
                }
            }
        }
    }
}

// Namespace zombie_base_audio
// Params 1, eflags: 0x4
// Checksum 0xd7b97578, Offset: 0xfa5
// Size: 0x177
function private function_fd19cdf98bd90a07( zombie )
{
    var_add4d5eb56b95a1a = 150;
    
    if ( zombie asm_bb::bb_movetyperequested( "walk" ) )
    {
        var_add4d5eb56b95a1a = 175;
    }
    else if ( zombie asm_bb::bb_movetyperequested( "run" ) )
    {
        var_add4d5eb56b95a1a = 200;
    }
    else if ( zombie asm_bb::bb_movetyperequested( "sprint" ) )
    {
        var_add4d5eb56b95a1a = 225;
    }
    else if ( zombie asm_bb::bb_movetyperequested( "super_sprint" ) )
    {
        var_add4d5eb56b95a1a = 250;
    }
    
    var_2925bbbf7daa6903 = distance2dsquared( self.origin, zombie.origin );
    var_f93ee538c1b1b99a = abs( self.origin[ 2 ] - zombie.origin[ 2 ] ) < 140;
    is_behind_close = var_2925bbbf7daa6903 < var_add4d5eb56b95a1a * var_add4d5eb56b95a1a;
    is_front_close = var_2925bbbf7daa6903 < 30625;
    is_front_too_close = var_2925bbbf7daa6903 > 10000;
    assert( isplayer( zombie.enemy ) );
    
    if ( is_behind_close && var_f93ee538c1b1b99a && !math::within_fov_2d( zombie.enemy.origin, zombie.enemy.angles, zombie.origin, cos( 95 ) ) )
    {
        return "behind_vox";
    }
    
    if ( is_front_close && !is_front_too_close )
    {
        return "melee_vox";
    }
}

// Namespace zombie_base_audio
// Params 1, eflags: 0x4
// Checksum 0xebec594, Offset: 0x1125
// Size: 0x30
function private zombie_behind_vox_cooldown( waittime )
{
    self endon( #"death" );
    self.var_647e0dd4847547fb = 1;
    wait waittime;
    self.var_647e0dd4847547fb = 0;
}

