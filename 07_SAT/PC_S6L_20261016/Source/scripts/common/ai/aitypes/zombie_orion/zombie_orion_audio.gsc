// scripts\common\ai\aitypes\zombie_orion\zombie_orion_audio.gsc  (hash_19a8f6f5754115cf.gscc) (size: 6943 Bytes / 0x1b1f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1f2c101f (522981407)
// size ...... 6943 (0x1b1f)
// includes .. 5   (offset: 0x1713)
// strings ... 60  (offset: 0x173b)
// dev strs .. 0   (offset: 0x1b1f)
// exports ... 17  (offset: 0xff7)
// cseg ...... 0x62a + 0x9cd (0xff7)
// imports ... 35  (offset: 0x129f)
// animtree1 . 0   (offset: 0x1b1f)
// animtree2 . 0   (offset: 0x1b1f)
#using scripts\asm\asm_bb;
#using scripts\common\ai\aitypes\shared\zombie\zombie_vox;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_orion_audio;

// Namespace zombie_orion_audio
// Params 0
// Checksum 0x5b49e0a4, Offset: 0x648
// Size: 0x2c2
function function_2c3f6be64e59326()
{
    if ( utility::flag( "orion_audio" ) )
    {
        return;
    }
    
    utility::flag_set( "orion_audio" );
    zombie_vox::register_vox_state( "vox_death", "vox_death", "dx_zm_oria_aior_orin_aiordeath", 3, 7000 );
    zombie_vox::register_vox_state( "vox_lightning_charge", "vox_lightning_charge", "dx_zm_oria_aior_orin_aiorlncu", 2, 6000 );
    zombie_vox::register_vox_state( "vox_lightning_slam", "vox_lightning_slam", "dx_zm_oria_aior_orin_aiorlnsm", 2, 3600 );
    zombie_vox::register_vox_state( "vox_ranged_attack", "vox_ranged_attack", "dx_zm_oria_aior_orin_aiorlnsw", 2, 1000 );
    zombie_vox::register_vox_state( "vox_armor_break", "vox_armor_break", "dx_zm_oria_aior_orin_aiorambk", 2, 4600 );
    zombie_vox::register_vox_state( "vox_melee_swing", "vox_melee_swing", "dx_zm_oria_aior_orin_aiorknsw", 1, 3000 );
    zombie_vox::register_vox_state( "vox_pain", "vox_pain", "dx_zm_oria_aior_orin_aiorpain", 3, 900 );
    zombie_vox::function_3e1f4a0d10aabdeb( "zombie_orion_hvt_mq", "vox_death", "vox_death", "dx_zm_opsa_aips_orps_aiordeath", 3, 7000 );
    zombie_vox::function_3e1f4a0d10aabdeb( "zombie_orion_hvt_mq", "vox_lightning_charge", "vox_lightning_charge", "dx_zm_opsa_aips_orps_aiorlncu", 3, 5100 );
    zombie_vox::function_3e1f4a0d10aabdeb( "zombie_orion_hvt_mq", "vox_lightning_slam", "vox_lightning_slam", "dx_zm_opsa_aips_orps_aiorlnsm", 2, 1800 );
    zombie_vox::function_3e1f4a0d10aabdeb( "zombie_orion_hvt_mq", "vox_ranged_attack", "vox_ranged_attack", "dx_zm_opsa_aips_orps_aiorlnsw", 2, 2000 );
    zombie_vox::function_3e1f4a0d10aabdeb( "zombie_orion_hvt_mq", "vox_armor_break", "vox_armor_break", "dx_zm_opsa_aips_orps_aiorambk", 3, 3500 );
    zombie_vox::function_3e1f4a0d10aabdeb( "zombie_orion_hvt_mq", "vox_melee_swing", "vox_melee_swing", "dx_zm_opsa_aips_orps_aiorknsw", 1, 1250 );
    zombie_vox::function_3e1f4a0d10aabdeb( "zombie_orion_hvt_mq", "vox_pain", "vox_pain", "dx_zm_opsa_aips_orps_aiorpain", 3, 1600 );
    zombie_vox::function_3e1f4a0d10aabdeb( "zombie_orion_hvt_sq", "vox_death", "vox_death", "dx_zm_otka_aitk_ortk_aiordeath", 3, 3000 );
    zombie_vox::function_3e1f4a0d10aabdeb( "zombie_orion_hvt_sq", "vox_lightning_charge", "vox_lightning_charge", "dx_zm_otka_aitk_ortk_aiorlncu", 2, 3200 );
    zombie_vox::function_3e1f4a0d10aabdeb( "zombie_orion_hvt_sq", "vox_lightning_slam", "vox_lightning_slam", "dx_zm_otka_aitk_ortk_aiorlnsm", 2, 1400 );
    zombie_vox::function_3e1f4a0d10aabdeb( "zombie_orion_hvt_sq", "vox_ranged_attack", "vox_ranged_attack", "dx_zm_otka_aitk_ortk_aiorlnsw", 2, 1500 );
    zombie_vox::function_3e1f4a0d10aabdeb( "zombie_orion_hvt_sq", "vox_armor_break", "vox_armor_break", "dx_zm_otka_aitk_ortk_aiorambk", 2, 2500 );
    zombie_vox::function_3e1f4a0d10aabdeb( "zombie_orion_hvt_sq", "vox_melee_swing", "vox_melee_swing", "dx_zm_otka_aitk_ortk_aiorknsw", 1, 900 );
    zombie_vox::function_3e1f4a0d10aabdeb( "zombie_orion_hvt_sq", "vox_pain", "vox_pain", "dx_zm_otka_aitk_ortk_aiorpain", 3, 900 );
    callback::get_template( self.animsetname ) callback::add( "killed_body_cloned", &function_7920cd06bcb55c15 );
    level thread manage_ambient_cap();
}

// Namespace zombie_orion_audio
// Params 1, eflags: 0x4
// Checksum 0xb549d062, Offset: 0x912
// Size: 0x34
function private function_f8b2073dae4134f5( params )
{
    if ( function_7c0252ad2fc6112e() )
    {
        return;
    }
    
    function_6d7ba232b9c2b856();
    zombie_vox::function_e7828eef0e4316d6( self, "dx_zm_akrk_krns_kark_akberg", "dx_zm_akrk_krns_kark_akberg", 3, 4000 );
}

// Namespace zombie_orion_audio
// Params 1, eflags: 0x4
// Checksum 0xea5b0979, Offset: 0x94e
// Size: 0x46
function private function_bcd86e56903664bd( params )
{
    if ( function_7c0252ad2fc6112e() )
    {
        return;
    }
    
    self endon( #"death" );
    wait 1.5;
    function_6d7ba232b9c2b856();
    zombie_vox::function_e7828eef0e4316d6( self, "dx_zm_akrk_krns_kark_akacclshrn", "dx_zm_akrk_krns_kark_akacclshrn", 3, 2500 );
}

// Namespace zombie_orion_audio
// Params 1, eflags: 0x4
// Checksum 0xc271be4c, Offset: 0x99c
// Size: 0x23
function private function_91072996680f6bc3( params )
{
    zombie_vox::function_e7828eef0e4316d6( self, "dx_zm_akrk_krns_kark_akclbr", "dx_zm_akrk_krns_kark_akclbr", 3, 1000 );
}

// Namespace zombie_orion_audio
// Params 1, eflags: 0x4
// Checksum 0x95f4817d, Offset: 0x9c7
// Size: 0x51, Type: bool
function private function_7c0252ad2fc6112e( var_f4b6d1cabea0bba1 = "all" )
{
    if ( !isdefined( self.var_afdda79864c090c1 ) || !isdefined( self.var_afdda79864c090c1[ var_f4b6d1cabea0bba1 ] ) || gettime() > self.var_afdda79864c090c1[ var_f4b6d1cabea0bba1 ] )
    {
        return false;
    }
    
    return true;
}

// Namespace zombie_orion_audio
// Params 2, eflags: 0x4
// Checksum 0x570e60f1, Offset: 0xa21
// Size: 0x55
function private function_6d7ba232b9c2b856( var_f4b6d1cabea0bba1 = "all", var_f3f58290156b52c = 20000 )
{
    if ( !isdefined( self.var_afdda79864c090c1 ) )
    {
        self.var_afdda79864c090c1 = [];
    }
    
    self.var_afdda79864c090c1[ var_f4b6d1cabea0bba1 ] = gettime() + var_f3f58290156b52c;
}

// Namespace zombie_orion_audio
// Params 1
// Checksum 0xa284ea11, Offset: 0xa7e
// Size: 0xb4
function function_cddf28584bd7f1ed( params )
{
    if ( !function_7c0252ad2fc6112e() && !level function_7c0252ad2fc6112e( "spawn" ) )
    {
        function_6d7ba232b9c2b856();
        level function_6d7ba232b9c2b856( "spawn", 15000 );
        
        if ( self.subclass == "zombie_orion_hvt_mq" )
        {
            zombie_vox::function_e7828eef0e4316d6( self, "vox_spawn", "dx_zm_opsa_aips_orps_aiorsp", 3, 3600 );
        }
        else if ( self.subclass == "zombie_orion_hvt_sq" )
        {
            zombie_vox::function_e7828eef0e4316d6( self, "vox_spawn", "dx_zm_otka_aitk_ortk_aiorsp", 3, 4500 );
        }
        else
        {
            zombie_vox::function_e7828eef0e4316d6( self, "vox_spawn", "dx_zm_oria_aior_orin_aiorsp", 3, 6600 );
        }
    }
    
    thread function_e3e7d15cbf5a38c4();
}

// Namespace zombie_orion_audio
// Params 0
// Checksum 0xdc44ccab, Offset: 0xb3a
// Size: 0xda
function function_e3e7d15cbf5a38c4()
{
    self endon( #"death" );
    
    while ( true )
    {
        wait randomintrange( 10, 20 );
        
        if ( utility::percent_chance( 60 ) && self.enemy && !function_7c0252ad2fc6112e() && !function_7c0252ad2fc6112e( "combat" ) )
        {
            function_6d7ba232b9c2b856();
            function_6d7ba232b9c2b856( "combat", 10000 );
            
            if ( self.subclass == "zombie_orion_hvt_mq" )
            {
                level thread zombie_vox::function_e7828eef0e4316d6( self, "vox_enter_combat", "dx_zm_opsa_aips_orps_aiorencb", 3, 2100 );
                continue;
            }
            
            if ( self.subclass == "zombie_orion_hvt_sq" )
            {
                level thread zombie_vox::function_e7828eef0e4316d6( self, "vox_enter_combat", "dx_zm_otka_aitk_ortk_aiorencb", 3, 4400 );
                continue;
            }
            
            level thread zombie_vox::function_e7828eef0e4316d6( self, "vox_enter_combat", "dx_zm_oria_aior_orin_aiorencb", 3, 4000 );
        }
    }
}

// Namespace zombie_orion_audio
// Params 1
// Checksum 0x5889c513, Offset: 0xc1c
// Size: 0x1d
function function_19dd7cef4bf083c2( params )
{
    if ( !isdefined( params.event ) )
    {
        return;
    }
}

// Namespace zombie_orion_audio
// Params 0
// Checksum 0x8d013f7, Offset: 0xc41
// Size: 0x1c
function init_zombie_orion_audio()
{
    thread play_zombie_ambient_repeating();
    thread function_715f70042ac404fc();
    zombie_vox::register_play_vox_fn( &play_zombie_vo );
}

// Namespace zombie_orion_audio
// Params 0, eflags: 0x4
// Checksum 0x79ff06e1, Offset: 0xc65
// Size: 0x3
function private function_715f70042ac404fc()
{
    waitframe();
}

// Namespace zombie_orion_audio
// Params 6, eflags: 0x4
// Checksum 0xcb906231, Offset: 0xc70
// Size: 0x84
function private play_zombie_vo( event, zombie, scriptable_state, alias, priority, var_9a3bc44f9b1e1618 )
{
    switch ( event )
    {
        case #"hash_b7fdf49b050ebc74":
            if ( zombie function_7c0252ad2fc6112e() )
            {
                return;
            }
            
            zombie function_6d7ba232b9c2b856();
            break;
        default:
            break;
    }
    
    zombie_vox::function_e7828eef0e4316d6( zombie, scriptable_state, alias, priority, var_9a3bc44f9b1e1618 );
}

// Namespace zombie_orion_audio
// Params 1, eflags: 0x4
// Checksum 0x4505d0bc, Offset: 0xcfc
// Size: 0xaa
function private function_7920cd06bcb55c15( params )
{
    assert( isdefined( params.body ) );
    
    if ( self.subclass == "zombie_orion_hvt_mq" )
    {
        level thread play_zombie_vo( "death", params.body, undefined, "dx_zm_opsa_aips_orps_aiordeath", 4 );
        return;
    }
    
    if ( self.subclass == "zombie_orion_hvt_sq" )
    {
        level thread play_zombie_vo( "death", params.body, undefined, "dx_zm_otka_aitk_ortk_aiordeath", 4 );
        return;
    }
    
    level thread play_zombie_vo( "death", params.body, undefined, "dx_zm_oria_aior_orin_aiordeath", 4 );
}

// Namespace zombie_orion_audio
// Params 0
// Checksum 0x858846b7, Offset: 0xdae
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

// Namespace zombie_orion_audio
// Params 0, eflags: 0x4
// Checksum 0xa68725a1, Offset: 0xee5
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

// Namespace zombie_orion_audio
// Params 0, eflags: 0x4
// Checksum 0x86e93c4e, Offset: 0xfc7
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

