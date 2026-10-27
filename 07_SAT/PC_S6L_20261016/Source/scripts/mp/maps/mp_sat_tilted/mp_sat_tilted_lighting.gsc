// scripts\mp\maps\mp_sat_tilted\mp_sat_tilted_lighting.gsc  (hash_01caec33966b9b38.gscc) (size: 10162 Bytes / 0x27b2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x170d815b (386761051)
// size ...... 10162 (0x27b2)
// includes .. 2   (offset: 0x252e)
// strings ... 40  (offset: 0x253e)
// dev strs .. 0   (offset: 0x27b2)
// exports ... 26  (offset: 0x1b7e)
// cseg ...... 0x35c + 0x1822 (0x1b7e)
// imports ... 37  (offset: 0x1f8e)
// animtree1 . 0   (offset: 0x27b2)
// animtree2 . 0   (offset: 0x27b2)
#using scripts\common\lighting;
#using scripts\common\utility;

#namespace mp_sat_tilted_lighting;

// Namespace mp_sat_tilted_lighting
// Params 0
// Checksum 0x27a72d8c, Offset: 0x37a
// Size: 0x25f
function main()
{
    level.var_bf57e97b7b97342e = [ "we_bootup_sequence_floor_lights_01", "we_bootup_sequence_arc_lights_01", "we_bootup_sequence_floor_lights_02", "we_bootup_sequence_arc_lights_02", "we_bootup_sequence_floor_lights_03", "we_bootup_sequence_floor_lights_04", "we_bootup_sequence_floor_lights_red" ];
    level.a_lights = getentarray( "light", #code_classname );
    
    foreach ( light in level.a_lights )
    {
        light.n_base_intensity = light getlightintensity();
        
        if ( light.n_base_intensity == 0 )
        {
            light.n_base_intensity = 1;
        }
        
        light.n_intensity_clear = light.script_clear_intensity ?? 1;
        light.var_395f854ee68164ae = light.script_intensity ?? 2;
        light.var_395f844ee681627b = light.script_intensity2 ?? 3;
        light.var_6d850159b33e7ca6 = light.script_intensity2 ?? 5;
    }
    
    function_5eb662be4b1962c5();
    level thread function_e4c01cac3cf74f8();
    level thread doomsday_clock_init();
    level.var_98b60b10461d5e5d = getentarray( "light_nuke_top", #targetname );
    level.var_ce0bdb645d71f477 = getentarray( "light_nuke_middle", #targetname );
    level.var_6bf65126cd4aa555 = getentarray( "light_nuke_bottom", #targetname );
    level.var_53f86973e92e4f01 = arraycombine( level.var_98b60b10461d5e5d, level.var_ce0bdb645d71f477, level.var_6bf65126cd4aa555 );
    level.var_273734706020ddf9 = getentarray( "light_archie_head", #targetname );
    level.var_147e3f1fac4824d3 = getentarray( "light_flasher_cap_red", #script_noteworthy );
    level.var_acace9c8aefc03a7 = getentitylessscriptablearray( "light_flasher_cap_red", #script_noteworthy );
    level thread function_12a9a43bf2abdbe();
}

// Namespace mp_sat_tilted_lighting
// Params 0
// Checksum 0xc1afb9ef, Offset: 0x5e1
// Size: 0x45
function function_eefaa8a1b597a4b3()
{
    level endon( #"game_ended" );
    function_8f8813a40839970a( 3 );
    level thread function_638ee2e57a5e3616();
    level thread function_5934a9e3f4f55417();
    level thread function_d04ba4338241c261();
    level waittill( #"hash_af8b3180d8a99f6a" );
    function_8f8813a40839970a( 3 );
}

// Namespace mp_sat_tilted_lighting
// Params 1, eflags: 0x4
// Checksum 0x471f36e4, Offset: 0x62e
// Size: 0x104
function private function_8f8813a40839970a( var_8f87a41867448e34 )
{
    level endon( #"game_ended" );
    
    for ( i = 0; i < var_8f87a41867448e34 ; i++ )
    {
        for ( h = 0; h < level.var_bf57e97b7b97342e.size ; h++ )
        {
            deactivateworldevent( level.var_bf57e97b7b97342e[ h ] + "_up", 1 );
        }
        
        deactivateworldevent( "we_bootup_sequence_bumper_lights" + "_down", 1 );
        deactivateworldevent( "we_bootup_sequence_nuke_signs" + "_down", 1 );
        wait 0.2;
        
        for ( h = 0; h < level.var_bf57e97b7b97342e.size ; h++ )
        {
            activateworldevent( level.var_bf57e97b7b97342e[ h ] + "_up", 1 );
        }
        
        activateworldevent( "we_bootup_sequence_bumper_lights" + "_down", 1 );
        activateworldevent( "we_bootup_sequence_nuke_signs" + "_down", 1 );
        wait 0.2;
    }
    
    deactivateworldevent( "we_bootup_sequence_nuke_signs" + "_down", 1 );
}

// Namespace mp_sat_tilted_lighting
// Params 0, eflags: 0x4
// Checksum 0x49930dbd, Offset: 0x73a
// Size: 0xc1
function private function_638ee2e57a5e3616()
{
    level endon( #"game_ended" );
    
    for ( h = 0; h < level.var_bf57e97b7b97342e.size ; h++ )
    {
        level thread toggle_world_event( level.var_bf57e97b7b97342e[ h ] + "_down", 0.8 );
        wait 0.3;
    }
    
    wait 1.5;
    level notify( #"hash_521865896bef2be5" );
    wait 0.5;
    
    for ( h = level.var_bf57e97b7b97342e.size - 1; h > 0 ; h-- )
    {
        level thread toggle_world_event( level.var_bf57e97b7b97342e[ h ] + "_up", 0.8 );
        wait 0.3;
    }
    
    wait 0.8;
    level notify( #"hash_af8b3180d8a99f6a" );
}

// Namespace mp_sat_tilted_lighting
// Params 2, eflags: 0x4
// Checksum 0x4efef3e0, Offset: 0x803
// Size: 0x32
function private toggle_world_event( str_we, n_time_on )
{
    level endon( #"game_ended" );
    activateworldevent( str_we );
    wait n_time_on;
    deactivateworldevent( str_we );
}

// Namespace mp_sat_tilted_lighting
// Params 0, eflags: 0x4
// Checksum 0x56181932, Offset: 0x83d
// Size: 0x85
function private function_5934a9e3f4f55417()
{
    level endon( #"game_ended" );
    deactivateworldevent( "we_bootup_sequence_bumper_lights" + "_down", 1 );
    wait 1.5;
    activateworldevent( "we_bootup_sequence_bumper_lights" + "_down" );
    wait 0.8;
    deactivateworldevent( "we_bootup_sequence_bumper_lights" + "_down" );
    level waittill( #"hash_521865896bef2be5" );
    wait 1.5;
    activateworldevent( "we_bootup_sequence_bumper_lights" + "_up" );
    wait 0.8;
    deactivateworldevent( "we_bootup_sequence_bumper_lights" + "_up" );
}

// Namespace mp_sat_tilted_lighting
// Params 0, eflags: 0x4
// Checksum 0x465cc341, Offset: 0x8ca
// Size: 0x7c
function private function_d04ba4338241c261()
{
    level endon( #"game_ended" );
    deactivateworldevent( "we_bootup_sequence_nuke_signs" + "_down", 1 );
    wait 3;
    activateworldevent( "we_bootup_sequence_nuke_signs" + "_down" );
    wait 0.8;
    deactivateworldevent( "we_bootup_sequence_nuke_signs" + "_down" );
    level waittill( #"hash_521865896bef2be5" );
    activateworldevent( "we_bootup_sequence_nuke_signs" + "_up" );
    wait 0.8;
    deactivateworldevent( "we_bootup_sequence_nuke_signs" + "_up" );
}

// Namespace mp_sat_tilted_lighting
// Params 0
// Checksum 0x71511c61, Offset: 0x94e
// Size: 0x98
function function_ee8db67cf0cce54c()
{
    level endon( #"game_ended" );
    function_869d396414612b1c( "--." );
    wait 0.5;
    function_869d396414612b1c( "-" );
    wait 0.5;
    function_869d396414612b1c( "..-." );
    wait 0.5;
    function_869d396414612b1c( "---" );
    wait 0.72;
    function_869d396414612b1c( "-." );
    wait 0.5;
    function_869d396414612b1c( "..-" );
    wait 0.5;
    function_869d396414612b1c( "-.-" );
    wait 0.5;
    function_869d396414612b1c( "." );
}

// Namespace mp_sat_tilted_lighting
// Params 1, eflags: 0x4
// Checksum 0x53d19e1, Offset: 0x9ee
// Size: 0xee
function private function_869d396414612b1c( str_sequence )
{
    level endon( #"game_ended" );
    
    for ( i = 0; i < str_sequence.size ; i++ )
    {
        function_f10754a921506267( level.var_acace9c8aefc03a7, level.var_acace9c8aefc03a7[ i ].var_395f854ee68164ae );
        function_1bf98f235681cd55( level.var_147e3f1fac4824d3, level.var_147e3f1fac4824d3[ i ].var_395f854ee68164ae );
        
        switch ( str_sequence[ i ] )
        {
            case #"hash_311003bc01bd2598":
                wait 0.74;
                break;
            case #"hash_311006bc01bd2a51":
                wait 0.24;
                break;
            default:
                break;
        }
        
        function_f10754a921506267( level.var_acace9c8aefc03a7, 1 );
        function_1bf98f235681cd55( level.var_147e3f1fac4824d3, 1 );
        wait 0.24;
    }
}

// Namespace mp_sat_tilted_lighting
// Params 2, eflags: 0x4
// Checksum 0x9cbdba9a, Offset: 0xae4
// Size: 0xab
function private function_f10754a921506267( var_85fcf44f9e99698a, n_value )
{
    foreach ( scr_light in var_85fcf44f9e99698a )
    {
        if ( n_value === 1 )
        {
            scr_light setscriptablepartstate( "base", "light_inactive" );
            continue;
        }
        
        scr_light setscriptablepartstate( "base", "light_active" );
    }
}

// Namespace mp_sat_tilted_lighting
// Params 0
// Checksum 0x533a29f8, Offset: 0xb97
// Size: 0x2a9
function function_621ab01934993bfd()
{
    level endon( #"game_ended" );
    
    /#
        if ( level.var_a1e68565e802c3cf )
        {
            return;
        }
    #/
    
    wait 7;
    function_1bf98f235681cd55( level.var_6bf65126cd4aa555, level.var_6bf65126cd4aa555[ 0 ].var_395f844ee681627b );
    wait 0.2;
    function_1bf98f235681cd55( level.var_6bf65126cd4aa555, level.var_6bf65126cd4aa555[ 0 ].var_395f854ee68164ae );
    function_1bf98f235681cd55( level.var_ce0bdb645d71f477, level.var_ce0bdb645d71f477[ 0 ].var_395f844ee681627b );
    wait 0.2;
    function_1bf98f235681cd55( level.var_6bf65126cd4aa555, level.var_6bf65126cd4aa555[ 0 ].var_395f854ee68164ae );
    function_1bf98f235681cd55( level.var_ce0bdb645d71f477, level.var_ce0bdb645d71f477[ 0 ].var_395f854ee68164ae );
    function_1bf98f235681cd55( level.var_98b60b10461d5e5d, level.var_98b60b10461d5e5d[ 0 ].var_395f854ee68164ae );
    wait 0.2;
    function_1bf98f235681cd55( level.var_6bf65126cd4aa555, 1 );
    function_1bf98f235681cd55( level.var_ce0bdb645d71f477, 1 );
    function_1bf98f235681cd55( level.var_98b60b10461d5e5d, 1 );
    wait 0.2;
    function_1bf98f235681cd55( level.var_6bf65126cd4aa555, level.var_6bf65126cd4aa555[ 0 ].var_395f854ee68164ae );
    function_1bf98f235681cd55( level.var_ce0bdb645d71f477, level.var_ce0bdb645d71f477[ 0 ].var_395f854ee68164ae );
    function_1bf98f235681cd55( level.var_98b60b10461d5e5d, level.var_98b60b10461d5e5d[ 0 ].var_395f854ee68164ae );
    wait 0.2;
    function_1bf98f235681cd55( level.var_6bf65126cd4aa555, 1 );
    function_1bf98f235681cd55( level.var_ce0bdb645d71f477, 1 );
    function_1bf98f235681cd55( level.var_98b60b10461d5e5d, 1 );
    wait 0.2;
    function_1bf98f235681cd55( level.var_6bf65126cd4aa555, level.var_6bf65126cd4aa555[ 0 ].var_395f854ee68164ae );
    function_1bf98f235681cd55( level.var_ce0bdb645d71f477, level.var_ce0bdb645d71f477[ 0 ].var_395f854ee68164ae );
    function_1bf98f235681cd55( level.var_98b60b10461d5e5d, level.var_98b60b10461d5e5d[ 0 ].var_395f854ee68164ae );
    wait 0.2;
    function_1bf98f235681cd55( level.var_6bf65126cd4aa555, 1 );
    function_1bf98f235681cd55( level.var_ce0bdb645d71f477, 1 );
    function_1bf98f235681cd55( level.var_98b60b10461d5e5d, 1 );
}

// Namespace mp_sat_tilted_lighting
// Params 2, eflags: 0x4
// Checksum 0x31b9f221, Offset: 0xe48
// Size: 0x93
function private function_1bf98f235681cd55( a_lights, n_value )
{
    foreach ( light in a_lights )
    {
        light setlightintensity( light.n_base_intensity * n_value );
    }
}

// Namespace mp_sat_tilted_lighting
// Params 1
// Checksum 0xe8d9550c, Offset: 0xee3
// Size: 0x2ce
function function_c83267584553ecc( var_94df53508b7a5a75 )
{
    if ( var_94df53508b7a5a75 )
    {
        level.var_a1e68565e802c3cf = 1;
        
        foreach ( var_1e84fddec1775872 in level.var_6bf65126cd4aa555 )
        {
            var_1e84fddec1775872 thread lighting::function_a6b7ccf4c5f2d94a( 0.5, var_1e84fddec1775872.n_base_intensity * var_1e84fddec1775872.var_395f854ee68164ae );
        }
        
        foreach ( var_9cd45cf2f81a4250 in level.var_ce0bdb645d71f477 )
        {
            var_9cd45cf2f81a4250 thread lighting::function_a6b7ccf4c5f2d94a( 0.5, var_9cd45cf2f81a4250.n_base_intensity * var_9cd45cf2f81a4250.var_395f854ee68164ae );
        }
        
        foreach ( e_top_light in level.var_98b60b10461d5e5d )
        {
            e_top_light thread lighting::function_a6b7ccf4c5f2d94a( 0.5, e_top_light.n_base_intensity * e_top_light.var_395f854ee68164ae );
        }
        
        return;
    }
    
    level.var_a1e68565e802c3cf = 0;
    
    foreach ( var_1e84fddec1775872 in level.var_6bf65126cd4aa555 )
    {
        var_1e84fddec1775872 thread lighting::function_a6b7ccf4c5f2d94a( 0.4, 0 );
    }
    
    foreach ( e_top_light in level.var_98b60b10461d5e5d )
    {
        e_top_light thread lighting::function_a6b7ccf4c5f2d94a( 0.4, 0 );
    }
}

// Namespace mp_sat_tilted_lighting
// Params 0, eflags: 0x4
// Checksum 0xff644585, Offset: 0x11b9
// Size: 0x74
function private function_12a9a43bf2abdbe()
{
    var_a96c4703d4ba5084 = getentarray( "light_track_triangle_dir", #targetname );
    var_72f5d035cd40419 = getentarray( "light_track_triangle_src", #targetname );
    level.var_a96c4703d4ba5084 = sortbydistance( var_a96c4703d4ba5084, ( -1024, 0, 0 ) );
    level.var_72f5d035cd40419 = sortbydistance( var_72f5d035cd40419, ( -1024, 0, 0 ) );
}

// Namespace mp_sat_tilted_lighting
// Params 0, eflags: 0x4
// Checksum 0x60fb10e7, Offset: 0x1235
// Size: 0xc3
function private function_163a3c3d2b99c13b()
{
    level endon( #"game_ended" );
    
    for ( i = 0; i < level.var_a96c4703d4ba5084.size ; i++ )
    {
        light = level.var_a96c4703d4ba5084[ i ];
        var_330ce41c77078610 = level.var_72f5d035cd40419[ i ];
        light setlightintensity( light.n_base_intensity * light.var_395f854ee68164ae );
        var_330ce41c77078610 setlightintensity( var_330ce41c77078610.n_base_intensity * var_330ce41c77078610.var_395f854ee68164ae );
        wait 0.18;
        light setlightintensity( light.n_base_intensity );
        var_330ce41c77078610 setlightintensity( var_330ce41c77078610.n_base_intensity );
    }
}

// Namespace mp_sat_tilted_lighting
// Params 0
// Checksum 0x6aef17c5, Offset: 0x1300
// Size: 0x34
function function_906efdae673be431()
{
    level endon( #"game_ended" );
    
    for ( i = 0; i < 6 ; i++ )
    {
        level thread function_163a3c3d2b99c13b();
        wait 1;
    }
}

// Namespace mp_sat_tilted_lighting
// Params 0, eflags: 0x4
// Checksum 0x11f0a402, Offset: 0x133c
// Size: 0x119
function private function_e4c01cac3cf74f8()
{
    level endon( #"game_ended" );
    utility::flag_wait( "scriptables_ready" );
    var_5038d4bb7a0c52e1 = getnoentvolumearray( "trigger_lgt_increase_intensity", #script_noteworthy );
    
    foreach ( var_72d7b0ac5704580d in var_5038d4bb7a0c52e1 )
    {
        var_9afbfe36eb5b2452 = getentitylessscriptablearray( var_72d7b0ac5704580d.targetname, #target )[ 0 ];
        var_72d7b0ac5704580d.var_9afbfe36eb5b2452 = var_9afbfe36eb5b2452;
        var_a417530be4519022 = getentarray( var_72d7b0ac5704580d.target, #targetname );
        
        if ( isdefined( var_a417530be4519022 ) && var_a417530be4519022.size > 0 )
        {
            var_72d7b0ac5704580d.var_a417530be4519022 = var_a417530be4519022;
            var_72d7b0ac5704580d thread function_447e3b775ac01c1();
        }
    }
}

// Namespace mp_sat_tilted_lighting
// Params 0, eflags: 0x4
// Checksum 0xb275b2c5, Offset: 0x145d
// Size: 0x242
function private function_447e3b775ac01c1()
{
    level endon( #"game_ended" );
    var_810fd43c9089dd00 = 0;
    
    while ( true )
    {
        self waittill( #"trigger", ent );
        
        if ( isplayer( ent ) && !var_810fd43c9089dd00 )
        {
            var_810fd43c9089dd00 = 1;
            
            foreach ( var_e086a4d5d62b1ccd in self.var_a417530be4519022 )
            {
                var_e086a4d5d62b1ccd setlightintensity( var_e086a4d5d62b1ccd.n_base_intensity * var_e086a4d5d62b1ccd.var_6d850159b33e7ca6 );
            }
            
            if ( isdefined( self.var_9afbfe36eb5b2452 ) )
            {
                self.var_9afbfe36eb5b2452 setscriptablepartstate( "light_anim", "light_occupied" );
            }
            
            while ( var_810fd43c9089dd00 )
            {
                var_d533005d2a3ed1b2 = 0;
                
                foreach ( e_player in level.players )
                {
                    if ( isalive( e_player ) && e_player istouching( self ) )
                    {
                        var_d533005d2a3ed1b2 = 1;
                        break;
                    }
                }
                
                var_810fd43c9089dd00 = var_d533005d2a3ed1b2;
                wait 0.1;
            }
            
            foreach ( var_e086a4d5d62b1ccd in self.var_a417530be4519022 )
            {
                var_e086a4d5d62b1ccd setlightintensity( var_e086a4d5d62b1ccd.n_base_intensity );
            }
            
            if ( isdefined( self.var_9afbfe36eb5b2452 ) )
            {
                self.var_9afbfe36eb5b2452 setscriptablepartstate( "light_anim", "idle" );
            }
        }
    }
}

// Namespace mp_sat_tilted_lighting
// Params 0, eflags: 0x4
// Checksum 0xd827ac7, Offset: 0x16a7
// Size: 0xcf
function private function_5eb662be4b1962c5()
{
    a_triggers = getentarray( "launcher", #targetname );
    
    foreach ( trigger in a_triggers )
    {
        var_a417530be4519022 = getentarray( trigger.script_fxid, #targetname );
        
        if ( isdefined( var_a417530be4519022 ) && var_a417530be4519022.size > 0 )
        {
            trigger.var_a417530be4519022 = var_a417530be4519022;
            trigger thread function_1c8c3210b26b4ae0();
        }
    }
}

// Namespace mp_sat_tilted_lighting
// Params 0, eflags: 0x4
// Checksum 0xa0b1adcf, Offset: 0x177e
// Size: 0xb6
function private function_1c8c3210b26b4ae0()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"launcher_launch" );
        
        foreach ( var_e086a4d5d62b1ccd in self.var_a417530be4519022 )
        {
            var_e086a4d5d62b1ccd notify( #"anim_start" );
            var_e086a4d5d62b1ccd notify( #"hash_d04ebaa9a4e368fd" );
            var_e086a4d5d62b1ccd thread bumper_light_anim();
        }
    }
}

// Namespace mp_sat_tilted_lighting
// Params 0, eflags: 0x4
// Checksum 0x3367ad20, Offset: 0x183c
// Size: 0x10e
function private bumper_light_anim()
{
    level endon( #"game_ended" );
    self endon( #"anim_start" );
    self setlightintensity( self.n_base_intensity * self.var_395f854ee68164ae );
    wait 0.1;
    self setlightintensity( self.n_base_intensity * self.n_intensity_clear );
    wait 0.08;
    self setlightintensity( self.n_base_intensity * self.var_395f854ee68164ae );
    wait 0.1;
    self setlightintensity( self.n_base_intensity * self.n_intensity_clear );
    wait 0.08;
    self setlightintensity( self.n_base_intensity * self.var_395f854ee68164ae );
    wait 0.1;
    self setlightintensity( self.n_base_intensity * self.n_intensity_clear );
    wait 0.08;
    lighting::function_a6b7ccf4c5f2d94a( 0.7, self.n_base_intensity * self.var_395f844ee681627b );
    wait 0.2;
    lighting::function_a6b7ccf4c5f2d94a( 0.7, self.n_base_intensity );
}

// Namespace mp_sat_tilted_lighting
// Params 1
// Checksum 0x79eaca73, Offset: 0x1952
// Size: 0x1b
function archie_blink( params )
{
    level thread function_ae9dbcfa2fa9492d( int( params[ 0 ] ) );
}

// Namespace mp_sat_tilted_lighting
// Params 1
// Checksum 0x10a1bc83, Offset: 0x1975
// Size: 0xb0
function function_ae9dbcfa2fa9492d( n_seconds_count )
{
    level endon( #"game_ended" );
    level notify( #"hash_678cf06d93b2a431" );
    level endon( #"hash_678cf06d93b2a431" );
    var_c67653c479848c73 = self.var_273734706020ddf9[ 0 ];
    i = 0;
    
    while ( i < n_seconds_count )
    {
        var_c67653c479848c73 thread lighting::function_a6b7ccf4c5f2d94a( 0.2, var_c67653c479848c73.n_base_intensity * var_c67653c479848c73.var_395f854ee68164ae );
        wait 0.2;
        var_c67653c479848c73 thread lighting::function_a6b7ccf4c5f2d94a( 0.1, var_c67653c479848c73.n_base_intensity );
        wait 0.1;
        i += 0.3;
    }
}

// Namespace mp_sat_tilted_lighting
// Params 0, eflags: 0x4
// Checksum 0x4dafa8ce, Offset: 0x1a2d
// Size: 0x6c
function private doomsday_clock_init()
{
    level endon( #"game_ended" );
    utility::flag_wait( "scriptables_ready" );
    level.var_4feedd37b9a96e8 = [ getentitylessscriptablearray( "doomsday_1", #targetname )[ 0 ], getentitylessscriptablearray( "doomsday_2", #targetname )[ 0 ], getentitylessscriptablearray( "doomsday_3", #targetname )[ 0 ] ];
}

// Namespace mp_sat_tilted_lighting
// Params 0
// Checksum 0x15dd227, Offset: 0x1aa1
// Size: 0xdd
function function_eda7d6b7f7f9b838()
{
    level endon( #"game_ended" );
    wait 3.5;
    
    for ( i = level.var_4feedd37b9a96e8.size - 1; i >= 0 ; i-- )
    {
        level.var_4feedd37b9a96e8[ i ] setscriptablepartstate( "base", "toggle" );
        wait 1;
    }
    
    wait 0.2;
    
    foreach ( var_30303b97b375ab03 in level.var_4feedd37b9a96e8 )
    {
        var_30303b97b375ab03 setscriptablepartstate( "base", "base" );
    }
}

