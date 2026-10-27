// scripts\common\ai\aitypes\zombie_mangler\zombie_mangler_audio.gsc  (hash_7b4d605886e29339.gscc) (size: 4583 Bytes / 0x11e7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb6ded0b4 (3068055732)
// size ...... 4583 (0x11e7)
// includes .. 5   (offset: 0xf17)
// strings ... 46  (offset: 0xf3f)
// dev strs .. 0   (offset: 0x11e7)
// exports ... 8   (offset: 0xa5b)
// cseg ...... 0x3fd + 0x65e (0xa5b)
// imports ... 28  (offset: 0xb9b)
// animtree1 . 0   (offset: 0x11e7)
// animtree2 . 0   (offset: 0x11e7)
#using scripts\asm\asm_bb;
#using scripts\common\ai\aitypes\shared\zombie\zombie_vox;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_mangler_audio;

// Namespace zombie_mangler_audio
// Params 0
// Checksum 0x8da80f00, Offset: 0x41b
// Size: 0x210
function init_zombie_mangler_audio_global()
{
    if ( utility::flag( "mangler_audio" ) )
    {
        return;
    }
    
    utility::flag_set( "mangler_audio" );
    zombie_vox::register_vox_state( "breath_inhale", "breath_inhale", "dx_ob_mngl_mnge_mang_ailightbreathin", 1, 1000 );
    zombie_vox::register_vox_state( "breath_exhale", "breath_exhale", "dx_ob_mngl_mnge_mang_ailightbreathout", 1, 1000 );
    zombie_vox::register_vox_state( "breath_inhale_heavy", "breath_inhale_heavy", "dx_ob_mngl_mnge_mang_aihardbreathin", 1, 1000 );
    zombie_vox::register_vox_state( "breath_exhale_heavy", "breath_exhale_heavy", "dx_ob_mngl_mnge_mang_aihardbreathout", 1, 1000 );
    zombie_vox::register_vox_state( "vox_unaware", "vox_unaware", "dx_ob_mngl_mngc_mang_aiua", 3, 4000 );
    zombie_vox::register_vox_state( "vox_aware", "vox_aware", "dx_ob_mngl_mngc_mang_aiaw", 3, 4100 );
    zombie_vox::register_vox_state( "vox_taunt", "vox_taunt", "dx_ob_mngl_mngc_mang_aitn", 3, 3600 );
    zombie_vox::register_vox_state( "vox_berserk", "vox_berserk", "dx_ob_mngl_mnge_mang_airg", 2, 2700 );
    zombie_vox::register_vox_state( "vox_fake_roar", "vox_fake_roar", "dx_ob_mngl_mnge_mang_airg", 2, 2700 );
    zombie_vox::register_vox_state( "vox_calmdown", "vox_calmdown", "dx_ob_mngl_mnge_mang_aicd", 2, 1600 );
    zombie_vox::register_vox_state( "vox_laugh", "vox_laugh", "dx_ob_mngl_mnge_mang_aiml", 2, 2800 );
    zombie_vox::register_vox_state( "pain", "vox_pain", "dx_ob_mngl_mnge_mang_aipn", 3, 1700 );
    zombie_vox::register_vox_state( "vox_pain", "vox_pain", "dx_ob_mngl_mnge_mang_aipn", 3, 1700 );
    zombie_vox::register_vox_state( "vox_melee", "vox_melee", "dx_ob_mngl_mnge_mang_aims", 2, 1250 );
    zombie_vox::register_vox_state( "vox_shoot", "vox_shoot", "dx_ob_mngl_mnge_mang_aims", 2, 1250 );
    zombie_vox::register_vox_state( "vox_mantle", "vox_mantle", "dx_ob_mngl_mnge_mang_aimn", 2, 1000 );
    zombie_vox::register_vox_state( "vox_land", "vox_land", "dx_ob_mngl_mnge_mang_aild", 2, 850 );
    callback::get_template( self.animsetname ) callback::add( "killed_body_cloned", &function_7920cd06bcb55c15 );
    level thread manage_ambient_cap();
}

// Namespace zombie_mangler_audio
// Params 0
// Checksum 0xfe6ec2ec, Offset: 0x633
// Size: 0x3e
function init_zombie_mangler_audio()
{
    thread play_zombie_ambient_repeating();
    zombie_vox::register_play_vox_fn( &play_zombie_vo );
    utility::delaycallendon( 1, [ "death", "preventAmbientAudio" ], &setscriptablepartstate, "ambient_audio", "on" );
}

// Namespace zombie_mangler_audio
// Params 6, eflags: 0x4
// Checksum 0x7d6a6d40, Offset: 0x679
// Size: 0x108
function private play_zombie_vo( event, zombie, scriptable_state, alias, priority, var_9a3bc44f9b1e1618 )
{
    switch ( event )
    {
        case #"hash_3790fac69eee7c05":
            zombie zombie_vox::function_bb5be6a2c88bc5f4( utility::function_4b74c15943231980( 1.5 ), 1 );
            break;
        case #"hash_807ed7a578f41af3":
            zombie zombie_vox::function_bb5be6a2c88bc5f4( utility::function_4b74c15943231980( 2 ), 1 );
            zombie zombie_vox::function_bb5be6a2c88bc5f4( utility::function_4b74c15943231980( 2 ), 2 );
            return;
        case #"hash_165cf835336dc9fa":
        case #"hash_29f73397d09a46eb":
        case #"hash_8f4226cc8eb98081":
            zombie zombie_vox::function_bb5be6a2c88bc5f4( utility::function_4b74c15943231980( 3 ), 1 );
            zombie zombie_vox::function_bb5be6a2c88bc5f4( utility::function_4b74c15943231980( 3 ), 2 );
            break;
        default:
            break;
    }
    
    zombie_vox::function_e7828eef0e4316d6( zombie, scriptable_state, alias, priority, var_9a3bc44f9b1e1618 );
}

// Namespace zombie_mangler_audio
// Params 1, eflags: 0x4
// Checksum 0x47dbe0c6, Offset: 0x789
// Size: 0x72
function private function_7920cd06bcb55c15( params )
{
    assert( isdefined( params.body ) );
    
    if ( isdefined( self ) && self isscriptable() )
    {
        self setscriptablepartstate( "ambient_audio", "off" );
        self setscriptablepartstate( "sound_vo", "off" );
    }
    
    level thread play_zombie_vo( "death", params.body, "death", "dx_ob_mngl_mnge_mang_aidt", 4 );
}

// Namespace zombie_mangler_audio
// Params 0
// Checksum 0x1cc3af90, Offset: 0x803
// Size: 0x13e
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
        if ( !val::get( "play_ambient_vo" ) )
        {
            wait 1;
            continue;
        }
        
        params = get_ambient_params();
        
        if ( !var_4c32391f3ad61ce9 )
        {
            if ( utility::percent_chance( params.var_dc8cb35f39318c8e ) || var_a50f94f03edff6b3 >= 15 )
            {
                var_a50f94f03edff6b3 = 0;
                var_71ab6a9a43dcf7e6 = params.var_a2ca231ce4d6b000;
            }
            else
            {
                var_a50f94f03edff6b3++;
                var_71ab6a9a43dcf7e6 = params.var_b58be3780347f93f ? "breath_exhale_heavy" : "breath_exhale";
            }
            
            var_4c32391f3ad61ce9 = 1;
        }
        else
        {
            var_71ab6a9a43dcf7e6 = params.var_b58be3780347f93f ? "breath_inhale_heavy" : "breath_inhale";
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

// Namespace zombie_mangler_audio
// Params 0, eflags: 0x4
// Checksum 0xfaeada64, Offset: 0x949
// Size: 0xd9
function private get_ambient_params()
{
    params = spawnstruct();
    params.var_a2ca231ce4d6b000 = "vox_unaware";
    params.var_b58be3780347f93f = 0;
    params.var_dc8cb35f39318c8e = 5;
    
    if ( isdefined( self.enemy ) )
    {
        var_419305557a246c4c = [ "vox_aware", "vox_taunt" ];
        params.var_a2ca231ce4d6b000 = var_419305557a246c4c[ randomintrange( 0, var_419305557a246c4c.size ) ];
        
        if ( asm_bb::bb_movetyperequested( "run" ) || asm_bb::bb_movetyperequested( "sprint" ) || asm_bb::bb_movetyperequested( "super_sprint" ) )
        {
            params.var_b58be3780347f93f = 1;
            params.var_dc8cb35f39318c8e = 5;
        }
        else
        {
            params.var_dc8cb35f39318c8e = 10;
        }
    }
    
    return params;
}

// Namespace zombie_mangler_audio
// Params 0, eflags: 0x4
// Checksum 0xda84c38b, Offset: 0xa2b
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

