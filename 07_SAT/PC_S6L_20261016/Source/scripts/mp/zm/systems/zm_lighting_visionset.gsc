// scripts\mp\zm\systems\zm_lighting_visionset.gsc  (hash_0c94500ac9b4b76c.gscc) (size: 5429 Bytes / 0x1535 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xaab56d5e (2864016734)
// size ...... 5429 (0x1535)
// includes .. 7   (offset: 0x1481)
// strings ... 8   (offset: 0x14b9)
// dev strs .. 2   (offset: 0x1519)
// exports ... 19  (offset: 0xcb9)
// cseg ...... 0x123 + 0xb96 (0xcb9)
// imports ... 38  (offset: 0xfb1)
// animtree1 . 0   (offset: 0x1535)
// animtree2 . 0   (offset: 0x1535)
#using scripts\common\callbacks;
#using scripts\common\lighting_pbg;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\mp\common\utility\vision_utility;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\zm_utility;

#namespace zm_lighting_visionset;

// Namespace zm_lighting_visionset
// Params 0
// Checksum 0x77220b77, Offset: 0x141
// Size: 0x96
function init_zm_visionset()
{
    level thread lighting_pbg::init_lighting_pbg();
    level callback::add( "on_round_ai_spawn_started", &on_round_ai_spawn_started );
    level callback::add( "on_round_end", &zm_lighting_on_round_end );
    level callback::add( "on_exfil_start", &on_exfil_start );
    level callback::add( "special_round_start", &on_special_round_start );
    level callback::add( #"player_spawned", &on_player_spawned );
    level callback::add( #"player_connect", &on_player_connect );
    scene::function_85b13b837056bc8b( &function_a581f21cc70f417a );
    scene::function_53de0775d8452750( &function_34910d77f4a9196f );
}

// Namespace zm_lighting_visionset
// Params 0, eflags: 0x4
// Checksum 0xe29c44b4, Offset: 0x1df
// Size: 0x18
function private function_a581f21cc70f417a()
{
    if ( zm_round_spawning::is_special_round( zm_utility::get_round_number() ) )
    {
        zm_lighting_on_round_end();
    }
}

// Namespace zm_lighting_visionset
// Params 0, eflags: 0x4
// Checksum 0x15e94631, Offset: 0x1ff
// Size: 0x24
function private function_34910d77f4a9196f()
{
    if ( zm_round_spawning::is_special_round( zm_utility::get_round_number() ) )
    {
        on_special_round_start( { #isspecialround:1 } );
    }
}

// Namespace zm_lighting_visionset
// Params 0, eflags: 0x4
// Checksum 0xcca26cb4, Offset: 0x22b
// Size: 0x24
function private function_43c584d0ce9052b3()
{
    if ( !isdefined( level.zm_lighting_setting ) )
    {
        level.zm_lighting_setting = spawnstruct();
    }
    
    return level.zm_lighting_setting;
}

// Namespace zm_lighting_visionset
// Params 1, eflags: 0x4
// Checksum 0xfd38e631, Offset: 0x258
// Size: 0x100
function private on_player_connect( params )
{
    if ( level utility::flag( "begin_round_logic" ) && level.gametypebundle.var_dc9908e56ab8c95d && zm_utility::get_round_number() > 1 )
    {
        if ( !zm_round_spawning::is_special_round( zm_utility::get_round_number() ) )
        {
            return;
        }
        
        while ( level.var_5d46e902ab3adc1d )
        {
            waitframe();
        }
        
        root = function_43c584d0ce9052b3();
        
        foreach ( info in root.var_2f782dd2cca16291 )
        {
            if ( info.var_7e4e710386ab5934 )
            {
                level thread change_lighting( info, 1, 1, self );
                return;
            }
        }
    }
}

// Namespace zm_lighting_visionset
// Params 1, eflags: 0x4
// Checksum 0xdfe580cb, Offset: 0x360
// Size: 0x7e
function private on_player_spawned( params )
{
    waitframe();
    root = function_43c584d0ce9052b3();
    
    if ( !isdefined( root.var_2f782dd2cca16291 ) )
    {
        level thread setup_lighting_round_info();
        info = get_lighting_info( 1 );
        
        if ( isdefined( info.visionname ) )
        {
            root.var_33d2f2def1daabf5 = info.visionname;
            thread function_759cd6cb8465d4ed();
            return;
        }
    }
    
    thread function_759cd6cb8465d4ed();
}

// Namespace zm_lighting_visionset
// Params 1, eflags: 0x4
// Checksum 0x756afb0b, Offset: 0x3e6
// Size: 0xa8
function private on_round_ai_spawn_started( params )
{
    if ( params.isspecialround )
    {
        return;
    }
    
    root = function_43c584d0ce9052b3();
    assert( isdefined( root.var_2f782dd2cca16291 ), "<dev string:x24>" );
    info = get_lighting_info( params.roundnumber );
    assert( isdefined( info ), "<dev string:x40>" + params.roundnumber );
    level thread change_lighting( info );
    
    if ( isdefined( info.visionname ) )
    {
        function_8a1c176ef3292439( info.visionname );
    }
}

// Namespace zm_lighting_visionset
// Params 1, eflags: 0x4
// Checksum 0x2a796d67, Offset: 0x496
// Size: 0x22
function private on_exfil_start( params )
{
    if ( zm_round_spawning::is_special_round( zm_utility::get_round_number() ) )
    {
        zm_lighting_on_round_end();
    }
}

// Namespace zm_lighting_visionset
// Params 1, eflags: 0x4
// Checksum 0x2ece7481, Offset: 0x4c0
// Size: 0x44
function private on_special_round_start( params )
{
    if ( utility::flag( "exfil_start" ) )
    {
        return;
    }
    
    if ( !params.isspecialround )
    {
        return;
    }
    
    wait 2;
    
    if ( utility::flag( "disable_special_round_visionset" ) )
    {
        return;
    }
    
    set_special_round_visionset();
}

// Namespace zm_lighting_visionset
// Params 0
// Checksum 0xd12f1816, Offset: 0x50c
// Size: 0xe0
function set_special_round_visionset()
{
    root = function_43c584d0ce9052b3();
    level.var_4159545922f4388a = 1;
    
    foreach ( info in root.var_2f782dd2cca16291 )
    {
        if ( info.var_7e4e710386ab5934 )
        {
            level thread change_lighting( info );
            
            if ( isdefined( info.visionname ) )
            {
                root.var_5bb967adcf18b892 = root.var_33d2f2def1daabf5;
                function_8a1c176ef3292439( info.visionname );
            }
            
            return;
        }
    }
}

// Namespace zm_lighting_visionset
// Params 0
// Checksum 0x62ada090, Offset: 0x5f4
// Size: 0x100
function function_48532c8b58f4b0b3()
{
    root = function_43c584d0ce9052b3();
    
    if ( isdefined( root.var_5bb967adcf18b892 ) )
    {
        function_8a1c176ef3292439( root.var_5bb967adcf18b892 );
        root.var_5bb967adcf18b892 = undefined;
    }
    
    if ( isdefined( root.n_round_bank ) && root.n_round_bank != 1 )
    {
        lighting_pbg::function_eaa082ab7b0c93a8( 1, 2 );
        root.n_round_bank = undefined;
        waitframe();
    }
    
    if ( level.var_4159545922f4388a == 1 )
    {
        level.var_4159545922f4388a = undefined;
        round_number = zm_utility::get_round_number();
        var_f6656e38778331b8 = round_number + 1;
        info = get_lighting_info( var_f6656e38778331b8 );
        assert( isdefined( info ), "<dev string:x40>" + var_f6656e38778331b8 );
        level thread change_lighting( info );
        
        if ( isdefined( info.visionname ) )
        {
            function_8a1c176ef3292439( info.visionname );
        }
    }
}

// Namespace zm_lighting_visionset
// Params 1
// Checksum 0xfe018e3d, Offset: 0x6fc
// Size: 0x13
function zm_lighting_on_round_end( params )
{
    function_48532c8b58f4b0b3();
}

// Namespace zm_lighting_visionset
// Params 0, eflags: 0x4
// Checksum 0x83a9aba9, Offset: 0x717
// Size: 0x19a
function private setup_lighting_round_info()
{
    root = function_43c584d0ce9052b3();
    
    if ( isdefined( root.var_2f782dd2cca16291 ) )
    {
        return;
    }
    
    var_8593f17418a81b6e = "zmroundspawning:zm_t10_base_round_spawning";
    
    if ( isdefined( level.var_fc24bbdd34d2b120 ) )
    {
        var_8593f17418a81b6e = level.var_fc24bbdd34d2b120;
    }
    
    spawnbundle = getscriptbundle( var_8593f17418a81b6e );
    
    if ( isdefined( spawnbundle.var_bd442424cc6d5543 ) )
    {
        root.var_2f782dd2cca16291 = [];
        
        foreach ( v in spawnbundle.var_bd442424cc6d5543 )
        {
            lightinginfo = spawnstruct();
            lightinginfo.var_7e4e710386ab5934 = v.var_7e4e710386ab5934;
            lightinginfo.startroundnumber = v.startroundnumber;
            lightinginfo.endroundnumber = v.endroundnumber;
            lightinginfo.var_23c1489d66967130 = v.var_23c1489d66967130;
            lightinginfo.var_756ca0d63c9bc9df = v.var_756ca0d63c9bc9df;
            lightinginfo.visionname = v.visionname;
            root.var_2f782dd2cca16291[ root.var_2f782dd2cca16291.size ] = lightinginfo;
        }
    }
}

// Namespace zm_lighting_visionset
// Params 1, eflags: 0x4
// Checksum 0x700dd7b1, Offset: 0x8b9
// Size: 0x100
function private get_lighting_info( var_8d885b4aed0bef01 )
{
    root = function_43c584d0ce9052b3();
    
    foreach ( info in root.var_2f782dd2cca16291 )
    {
        if ( !isdefined( info.startroundnumber ) && !isdefined( info.endroundnumber ) )
        {
            continue;
        }
        
        checked_start = 1;
        
        if ( var_8d885b4aed0bef01 < info.startroundnumber )
        {
            checked_start = 0;
        }
        
        checked_end = 1;
        
        if ( var_8d885b4aed0bef01 > info.endroundnumber )
        {
            checked_end = 0;
        }
        
        if ( checked_start && checked_end )
        {
            return info;
        }
    }
}

// Namespace zm_lighting_visionset
// Params 4, eflags: 0x4
// Checksum 0x745ffe09, Offset: 0x9c2
// Size: 0xad
function private change_lighting( lighting_info, var_bc527b4c577a7ca5, var_9fb5b7c24eca382e, player )
{
    level notify( #"hash_cbb6b769347facee" );
    level endon( #"game_ended" );
    level endon( #"hash_cbb6b769347facee" );
    fade_in_dur = var_bc527b4c577a7ca5 ? 0 : 2;
    color_dur = var_9fb5b7c24eca382e ? 0 : 2;
    total_dur = fade_in_dur + color_dur;
    bank_num = lighting_info.var_756ca0d63c9bc9df ?? 1;
    function_ad915db840c90fb3( 1023, bank_num, total_dur, undefined, player );
}

// Namespace zm_lighting_visionset
// Params 2
// Checksum 0xbcf4c890, Offset: 0xa77
// Size: 0x2c
function function_1fb92966f89cb47e( e_player, str_vision )
{
    e_player.var_88b00b064d77306 = str_vision;
    e_player thread function_759cd6cb8465d4ed();
}

// Namespace zm_lighting_visionset
// Params 1, eflags: 0x4
// Checksum 0x4cbc34f5, Offset: 0xaab
// Size: 0xc0
function private function_8a1c176ef3292439( var_11dece3359042a3b )
{
    root = function_43c584d0ce9052b3();
    
    if ( isdefined( var_11dece3359042a3b ) )
    {
        root.var_33d2f2def1daabf5 = var_11dece3359042a3b;
    }
    
    foreach ( p in level.players )
    {
        if ( !isplayer( p ) || isbot( p ) )
        {
            continue;
        }
        
        p thread function_759cd6cb8465d4ed();
    }
}

// Namespace zm_lighting_visionset
// Params 0, eflags: 0x4
// Checksum 0x4a962e8e, Offset: 0xb73
// Size: 0x146
function private function_759cd6cb8465d4ed()
{
    if ( !isplayer( self ) || isbot( self ) )
    {
        return;
    }
    
    root = function_43c584d0ce9052b3();
    
    if ( !isdefined( root.var_33d2f2def1daabf5 ) )
    {
        return;
    }
    
    self endon( #"death" );
    level endon( #"game_ended" );
    var_b6ac89558b4397e2 = root.var_33d2f2def1daabf5;
    
    if ( isdefined( self.var_88b00b064d77306 ) )
    {
        var_b6ac89558b4397e2 = self.var_88b00b064d77306;
    }
    
    if ( self.var_8467e9d8eada45f0 == var_b6ac89558b4397e2 )
    {
        return;
    }
    
    if ( isdefined( self.activevisionsetlist ) )
    {
        foreach ( visionname, visionsetcount in self.activevisionsetlist )
        {
            if ( visionname == self.var_8467e9d8eada45f0 && visionsetcount > 0 )
            {
                vision_utility::function_6cb9d8e0202ee81( visionname );
                waitframe();
            }
        }
    }
    
    self.var_8467e9d8eada45f0 = var_b6ac89558b4397e2;
    vision_utility::function_89d3efe42060754c( var_b6ac89558b4397e2, level.framedurationseconds );
}

