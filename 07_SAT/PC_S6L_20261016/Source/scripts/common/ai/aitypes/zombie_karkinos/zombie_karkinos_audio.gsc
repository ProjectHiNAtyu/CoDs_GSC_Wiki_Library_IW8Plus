// scripts\common\ai\aitypes\zombie_karkinos\zombie_karkinos_audio.gsc  (hash_7c406493b8bff729.gscc) (size: 5941 Bytes / 0x1735 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6035bb2c (1614134060)
// size ...... 5941 (0x1735)
// includes .. 5   (offset: 0x1441)
// strings ... 48  (offset: 0x1469)
// dev strs .. 0   (offset: 0x1735)
// exports ... 17  (offset: 0xc85)
// cseg ...... 0x3de + 0x8a7 (0xc85)
// imports ... 41  (offset: 0xf2d)
// animtree1 . 0   (offset: 0x1735)
// animtree2 . 0   (offset: 0x1735)
#using scripts\asm\asm_bb;
#using scripts\common\ai\aitypes\shared\zombie\zombie_vox;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_karkinos_audio;

// Namespace zombie_karkinos_audio
// Params 0
// Checksum 0x3f8a8ed0, Offset: 0x3fc
// Size: 0x26a
function function_f77bfc70f00f34af()
{
    if ( utility::flag( "karkinos_audio" ) )
    {
        return;
    }
    
    utility::flag_set( "karkinos_audio" );
    zombie_vox::register_vox_state( "vox_pain", "dx_zm_akrk_krns_kark_akclbr", "dx_zm_akrk_krns_kark_akclbr", 3, 900 );
    zombie_vox::register_vox_state( "vox_melee", "dx_zm_akrk_krns_kark_akthpn", "dx_zm_akrk_krns_kark_akthpn", 1, 900 );
    zombie_vox::register_vox_state( "vox_roar", "dx_zm_akrk_krns_kark_akchfw", "dx_zm_akrk_krns_kark_akchfw", 2, 2000 );
    zombie_vox::register_vox_state( "vox_exit_run", "dx_zm_akrk_krns_kark_akhmsl", "dx_zm_akrk_krns_kark_akhmsl", 2, 1000 );
    zombie_vox::register_vox_state( "vox_exit_sprint", "dx_zm_akrk_krns_kark_akhmsl", "dx_zm_akrk_krns_kark_akhmsl", 2, 1000 );
    zombie_vox::register_vox_state( "vox_exit_walk", "dx_zm_akrk_krns_kark_akhmsl", "dx_zm_akrk_krns_kark_akhmsl", 2, 1000 );
    zombie_vox::register_vox_state( "charge_intro", "dx_zm_akrk_krns_kark_akrshmro", "dx_zm_akrk_krns_kark_akrshmro", 2, 2000 );
    zombie_vox::register_vox_state( "charge_start", "dx_zm_akrk_krns_kark_akchfw", "dx_zm_akrk_krns_kark_akchfw", 1, 2000 );
    zombie_vox::register_vox_state( "charge_takeoff", "dx_zm_akrk_krns_kark_akhmsl", "dx_zm_akrk_krns_kark_akhmsl", 1, 1000 );
    zombie_vox::register_vox_state( "slam_impact", "dx_zm_akrk_krns_kark_akthtr", "dx_zm_akrk_krns_kark_akthtr", 1, 800 );
    zombie_vox::register_vox_state( "slam_reset", "dx_zm_akrk_krns_kark_akthpn", "dx_zm_akrk_krns_kark_akthpn", 1, 900 );
    zombie_vox::register_vox_state( "trident_stab", "dx_zm_akrk_krns_kark_akthpn", "dx_zm_akrk_krns_kark_akthpn", 1, 900 );
    zombie_vox::register_vox_state( "trident_swing", "dx_zm_akrk_krns_kark_akthpn", "dx_zm_akrk_krns_kark_akthpn", 1, 900 );
    zombie_vox::register_vox_state( "trident_throw", "dx_zm_akrk_krns_kark_akthtr", "dx_zm_akrk_krns_kark_akthtr", 2, 800 );
    zombie_vox::register_vox_state( "trident_pullback", "dx_zm_akrk_krns_kark_akthpn", "dx_zm_akrk_krns_kark_akthpn", 1, 900 );
    callback::get_template( self.animsetname ) callback::add( "killed_body_cloned", &function_7920cd06bcb55c15 );
    callback::get_template( self.animsetname ) callback::add( #"hash_50f7ad9b02c9f421", &function_bcd86e56903664bd );
    callback::get_template( self.animsetname ) callback::add( #"hash_805e7303a0ba39b1", &function_91072996680f6bc3 );
    callback::get_template( self.animsetname ) callback::add( #"hash_b05c7cceb18ef6b1", &function_f8b2073dae4134f5 );
    callback::get_template( self.animsetname ) callback::add( #"hash_e8d22dc3a3e6f70c", &function_b34ad4c51b8f3af );
    level thread manage_ambient_cap();
}

// Namespace zombie_karkinos_audio
// Params 1, eflags: 0x4
// Checksum 0x93e600c6, Offset: 0x66e
// Size: 0x34
function private function_f8b2073dae4134f5( params )
{
    if ( function_c7d4cf0bd0c880a5() )
    {
        return;
    }
    
    function_6b64f07272c0222d();
    zombie_vox::function_e7828eef0e4316d6( self, "dx_zm_akrk_krns_kark_akberg", "dx_zm_akrk_krns_kark_akberg", 3, 4000 );
}

// Namespace zombie_karkinos_audio
// Params 1, eflags: 0x4
// Checksum 0xccf4d9dd, Offset: 0x6aa
// Size: 0x46
function private function_bcd86e56903664bd( params )
{
    if ( function_c7d4cf0bd0c880a5() )
    {
        return;
    }
    
    self endon( #"death" );
    wait 1.5;
    function_6b64f07272c0222d();
    zombie_vox::function_e7828eef0e4316d6( self, "dx_zm_akrk_krns_kark_akacclshrn", "dx_zm_akrk_krns_kark_akacclshrn", 3, 2500 );
}

// Namespace zombie_karkinos_audio
// Params 1, eflags: 0x4
// Checksum 0x582d5ec1, Offset: 0x6f8
// Size: 0x23
function private function_91072996680f6bc3( params )
{
    zombie_vox::function_e7828eef0e4316d6( self, "dx_zm_akrk_krns_kark_akclbr", "dx_zm_akrk_krns_kark_akclbr", 3, 1000 );
}

// Namespace zombie_karkinos_audio
// Params 1, eflags: 0x4
// Checksum 0x9fc80282, Offset: 0x723
// Size: 0x51, Type: bool
function private function_c7d4cf0bd0c880a5( var_f4b6d1cabea0bba1 = "all" )
{
    if ( !isdefined( self.var_2ad6aa1ef34d0fb6 ) || !isdefined( self.var_2ad6aa1ef34d0fb6[ var_f4b6d1cabea0bba1 ] ) || gettime() > self.var_2ad6aa1ef34d0fb6[ var_f4b6d1cabea0bba1 ] )
    {
        return false;
    }
    
    return true;
}

// Namespace zombie_karkinos_audio
// Params 2, eflags: 0x4
// Checksum 0x92ac6c72, Offset: 0x77d
// Size: 0x55
function private function_6b64f07272c0222d( var_f4b6d1cabea0bba1 = "all", var_f3f58290156b52c = 20000 )
{
    if ( !isdefined( self.var_2ad6aa1ef34d0fb6 ) )
    {
        self.var_2ad6aa1ef34d0fb6 = [];
    }
    
    self.var_2ad6aa1ef34d0fb6[ var_f4b6d1cabea0bba1 ] = gettime() + var_f3f58290156b52c;
}

// Namespace zombie_karkinos_audio
// Params 1
// Checksum 0x8feb81dd, Offset: 0x7da
// Size: 0x5c
function function_6002bb87417d96f4( params )
{
    if ( !function_c7d4cf0bd0c880a5() && !level function_c7d4cf0bd0c880a5( "spawn" ) )
    {
        function_6b64f07272c0222d();
        level function_6b64f07272c0222d( "spawn", 15000 );
        zombie_vox::function_e7828eef0e4316d6( self, "dx_zm_akrk_krns_kark_akspw", "dx_zm_akrk_krns_kark_akspw", 3, 3000 );
    }
    
    thread function_432dc4f08ed5f3eb();
}

// Namespace zombie_karkinos_audio
// Params 0
// Checksum 0xa86778ee, Offset: 0x83e
// Size: 0x80
function function_432dc4f08ed5f3eb()
{
    self endon( #"death" );
    
    while ( true )
    {
        wait randomintrange( 10, 20 );
        
        if ( utility::percent_chance( 60 ) && self.enemy && !function_c7d4cf0bd0c880a5() && !function_c7d4cf0bd0c880a5( "combat" ) )
        {
            function_6b64f07272c0222d();
            function_6b64f07272c0222d( "combat", 10000 );
            level thread zombie_vox::function_e7828eef0e4316d6( self, "dx_zm_akrk_krns_kark_akencm", "dx_zm_akrk_krns_kark_akencm", 1, 2000 );
        }
    }
}

// Namespace zombie_karkinos_audio
// Params 1
// Checksum 0xaf57b2fa, Offset: 0x8c6
// Size: 0x1d
function function_b34ad4c51b8f3af( params )
{
    if ( !isdefined( params.event ) )
    {
        return;
    }
}

// Namespace zombie_karkinos_audio
// Params 0
// Checksum 0xbe4a6932, Offset: 0x8eb
// Size: 0x1c
function init_zombie_karkinos_audio()
{
    thread play_zombie_ambient_repeating();
    thread function_715f70042ac404fc();
    zombie_vox::register_play_vox_fn( &play_zombie_vo );
}

// Namespace zombie_karkinos_audio
// Params 0, eflags: 0x4
// Checksum 0x4280a536, Offset: 0x90f
// Size: 0x33
function private function_715f70042ac404fc()
{
    utility::flag_wait( "scriptables_ready" );
    utility::waittill_any_timeout( level.framedurationseconds, "post_spawn" );
    self setscriptablepartstate( "ambient_audio", "on" );
}

// Namespace zombie_karkinos_audio
// Params 6, eflags: 0x4
// Checksum 0x7e9655ed, Offset: 0x94a
// Size: 0xa2
function private play_zombie_vo( event, zombie, scriptable_state, alias, priority, var_9a3bc44f9b1e1618 )
{
    zombie callback::callback( #"hash_e8d22dc3a3e6f70c", { #event:event } );
    
    switch ( event )
    {
        case #"hash_b7fdf49b050ebc74":
            if ( zombie function_c7d4cf0bd0c880a5() )
            {
                return;
            }
            
            zombie function_6b64f07272c0222d();
            break;
        default:
            break;
    }
    
    zombie_vox::function_e7828eef0e4316d6( zombie, scriptable_state, alias, priority, var_9a3bc44f9b1e1618 );
}

// Namespace zombie_karkinos_audio
// Params 1, eflags: 0x4
// Checksum 0xacd07dde, Offset: 0x9f4
// Size: 0x40
function private function_7920cd06bcb55c15( params )
{
    assert( isdefined( params.body ) );
    level thread play_zombie_vo( "death", params.body, undefined, "dx_zm_akrk_krns_kark_akdt", 4 );
}

// Namespace zombie_karkinos_audio
// Params 0
// Checksum 0xa8c6b0f4, Offset: 0xa3c
// Size: 0x12f
function play_zombie_ambient_repeating()
{
    var_fd16a9c5c5ac1ab1 = 3;
    self endon( #"death" );
    utility::flag_wait( "scriptables_ready" );
    waitframe();
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
                zombie_vox::function_5ac4bed4a907abf5( var_71ab6a9a43dcf7e6 );
                waitframe();
                utility::ent_flag_waitopen_any( "playing_vo" );
            }
        }
        
        waitframe();
    }
}

// Namespace zombie_karkinos_audio
// Params 0, eflags: 0x4
// Checksum 0x3cdbc52c, Offset: 0xb73
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

// Namespace zombie_karkinos_audio
// Params 0, eflags: 0x4
// Checksum 0x1cb5dcc3, Offset: 0xc55
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

