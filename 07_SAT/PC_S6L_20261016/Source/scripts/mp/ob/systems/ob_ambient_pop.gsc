// scripts\mp\ob\systems\ob_ambient_pop.gsc  (hash_3e48ed23bd5dcb8f.gscc) (size: 4361 Bytes / 0x1109 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd9b48252 (3652485714)
// size ...... 4361 (0x1109)
// includes .. 6   (offset: 0xfa5)
// strings ... 10  (offset: 0xfd5)
// dev strs .. 13  (offset: 0x105d)
// exports ... 12  (offset: 0x901)
// cseg ...... 0x12f + 0x7d2 (0x901)
// imports ... 40  (offset: 0xae1)
// animtree1 . 0   (offset: 0x1109)
// animtree2 . 0   (offset: 0x1109)
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\hud_util;

#namespace ob_ambient_pop;

// Namespace ob_ambient_pop
// Params 0, eflags: 0x5
// Checksum 0xdf64d8fd, Offset: 0x14d
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ob_ambient_pop", #"ai_spawn_director", undefined, &function_fb9090288d4068af );
}

// Namespace ob_ambient_pop
// Params 0, eflags: 0x4
// Checksum 0xe31f1bf8, Offset: 0x176
// Size: 0xa3
function private function_fb9090288d4068af()
{
    if ( !aispawndirectorisenabled() )
    {
        return;
    }
    
    if ( !level.var_bb86f77304f193c4.var_5ee972fa2341f03f )
    {
        return;
    }
    
    /#
        level thread init_devgui();
    #/
    
    force_stage = getdvar( @"hash_8e319061a6442c81", "" );
    
    switch ( force_stage )
    {
        case #"hash_7a79227b6abedfe7":
        case #"hash_df2acf14444d46fe":
        case #"hash_df2ad114444d4a24":
        case #"hash_df2ad214444d4bb7":
        case #"hash_df2ad414444d4edd":
            set_ambient_stage( force_stage );
            return;
    }
    
    thread function_9dc705bc690cae2e();
}

/#

    // Namespace ob_ambient_pop
    // Params 0
    // Checksum 0x7225698a, Offset: 0x221
    // Size: 0xa4, Type: dev
    function init_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x3a>", "<dev string:x3c>" + "<dev string:x58>", &function_9b8e9d79542914a6 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x6a>", "<dev string:x3c>" + "<dev string:x6c>", &function_9b8e9d79542914a6 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x7e>", "<dev string:x3c>" + "<dev string:x80>", &function_9b8e9d79542914a6 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x92>", "<dev string:x3c>" + "<dev string:x94>", &function_9b8e9d79542914a6 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xa6>", "<dev string:x3c>" + "<dev string:xae>", &function_9b8e9d79542914a6 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace ob_ambient_pop
    // Params 1
    // Checksum 0x70572b91, Offset: 0x2cd
    // Size: 0x27, Type: dev
    function function_9b8e9d79542914a6( params )
    {
        stage = params[ 0 ];
        set_ambient_stage( stage );
    }

#/

// Namespace ob_ambient_pop
// Params 0
// Checksum 0x49a183e9, Offset: 0x2fc
// Size: 0x113
function function_9dc705bc690cae2e()
{
    pvp_delay = getdvarint( @"ob_pvp_delay", 0 );
    var_912506f104be98bc = getdvarfloat( @"hash_dbc5cf7f81c9c9aa", 0.15 );
    var_94c1967750a42abb = getdvarfloat( @"hash_a6fb7440646cafb7", 0.25 );
    var_bf6814be1554a22a = getdvarfloat( @"hash_3af3339ce8549a58", 0.25 );
    assert( var_912506f104be98bc + var_94c1967750a42abb + var_bf6814be1554a22a < 1, "<dev string:xc1>" );
    var_eacf89230de1a270 = pvp_delay * var_912506f104be98bc;
    var_25ab17462b418f1b = pvp_delay * var_94c1967750a42abb;
    var_391d8b83e1ed7f6e = pvp_delay * var_bf6814be1554a22a;
    var_d3c8a0d015c6a059 = pvp_delay - var_eacf89230de1a270 + var_25ab17462b418f1b + var_391d8b83e1ed7f6e;
    utility::flag_wait( "ob_systems_init_complete" );
    set_ambient_stage( "ob_ambient_stage1" );
    wait var_eacf89230de1a270;
    set_ambient_stage( "ob_ambient_stage2" );
    wait var_25ab17462b418f1b;
    set_ambient_stage( "ob_ambient_stage3" );
    wait var_391d8b83e1ed7f6e;
    set_ambient_stage( "ob_ambient_stage4" );
    wait var_d3c8a0d015c6a059;
    function_41a81b981dbf87e2();
}

// Namespace ob_ambient_pop
// Params 0
// Checksum 0x2822956a, Offset: 0x417
// Size: 0x195
function function_41a81b981dbf87e2()
{
    set_ambient_stage( "ob_ambient_endgame" );
    function_a25acb62ddab20e2( "ob_zombie_ambient", 1 );
    function_a25acb62ddab20e2( "ob_zombie_encounter_dense", 1 );
    function_a25acb62ddab20e2( "ob_merc_ambient_dynamic", 0 );
    zones = function_439821f7c1510694();
    
    foreach ( zone in zones )
    {
        if ( getdvarint( @"hash_466d098eed7d3d9f", 0 ) )
        {
            subzones = function_6978793539ff1cb4( zone.zoneindex );
            
            foreach ( subzone in subzones )
            {
                if ( !subzone.var_20d6d0656474ee79 )
                {
                    function_5866063fb64cf1a9( zone.zoneindex, subzone.subzoneindex, "ob_merc_ambient_dynamic", 0 );
                }
            }
            
            continue;
        }
        
        function_2a814d41ec6b9609( zone.zoneindex, "ob_merc_ambient_dynamic", 0 );
    }
    
    ai_spawn_director::function_ae3cb26bc2f24781( 0, 1 );
    ai_spawn_director::function_30967cc65fd6cba3( 1 );
}

// Namespace ob_ambient_pop
// Params 1
// Checksum 0x1d7107b0, Offset: 0x5b4
// Size: 0x2f
function set_ambient_stage( stage )
{
    level thread function_ee0f25c9b043712( stage );
    function_fe563686405f6897( stage );
    function_a25acb62ddab20e2( stage, 1 );
    function_76df1ff243dfb9f4();
}

// Namespace ob_ambient_pop
// Params 0, eflags: 0x4
// Checksum 0x5f884ee6, Offset: 0x5eb
// Size: 0x8e
function private function_76df1ff243dfb9f4()
{
    if ( getdvarint( @"hash_c2256bc76ef6417d", 0 ) )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        player thread function_28b850bde5cf7dc();
        waitframe();
    }
}

// Namespace ob_ambient_pop
// Params 0, eflags: 0x4
// Checksum 0xcaec8754, Offset: 0x681
// Size: 0xdd
function private function_28b850bde5cf7dc()
{
    self endon( #"death" );
    quittime = gettime() + utility::function_4b74c15943231980( 20 );
    
    while ( gettime() < quittime )
    {
        if ( !player::isaliveandnotinlaststand( self ) )
        {
            return;
        }
        
        if ( self isvehicleactive() )
        {
            wait 1;
            continue;
        }
        
        spawnpos = getclosestpointonnavmesh( self.origin );
        
        if ( isdefined( spawnpos ) && distancesquared( spawnpos, self.origin ) < squared( 250 ) )
        {
            requestid = ai_spawn_director::spawn_request( %"hash_3f4915457331c151", self.origin, 600, 1, 1, 0, 0 );
            
            if ( !isdefined( requestid ) )
            {
                wait 1;
                continue;
            }
            
            function_1a9d724a960fa19d( requestid, "ob_zombie_ambient", 1 );
            function_1a9d724a960fa19d( requestid, "ob_zombie_encounter_dense", 1 );
            return;
        }
        
        wait 1;
    }
}

// Namespace ob_ambient_pop
// Params 1, eflags: 0x4
// Checksum 0xffc68cb, Offset: 0x766
// Size: 0xe6
function private function_ee0f25c9b043712( stage )
{
    flash_postfx = undefined;
    main_postfx = undefined;
    
    switch ( stage )
    {
        case #"hash_df2ad414444d4edd":
            break;
        case #"hash_df2ad114444d4a24":
            flash_postfx = %"sat_cradle_ambient_stage_flash";
            break;
        case #"hash_df2ad214444d4bb7":
            flash_postfx = %"sat_cradle_ambient_stage_flash";
            main_postfx = %"sat_cradle_ambient_stage3";
            break;
        case #"hash_df2acf14444d46fe":
            main_postfx = %"sat_cradle_ambient_stage4";
            break;
        case #"hash_7a79227b6abedfe7":
            break;
        default:
            break;
    }
    
    if ( isdefined( flash_postfx ) )
    {
        pbgpostfxbundlestart( #"all", flash_postfx );
        wait 0.1;
    }
    
    if ( isdefined( main_postfx ) )
    {
        pbgpostfxbundlestart( #"all", main_postfx );
    }
}

// Namespace ob_ambient_pop
// Params 1, eflags: 0x4
// Checksum 0x1678ca4d, Offset: 0x854
// Size: 0xad
function private function_fe563686405f6897( stage )
{
    splash_name = undefined;
    
    switch ( stage )
    {
        case #"hash_df2ad414444d4edd":
            break;
        case #"hash_df2ad114444d4a24":
            splash_name = #"hash_b81b37c7780a53aa";
            break;
        case #"hash_df2ad214444d4bb7":
            splash_name = #"hash_b81b38c7780a555d";
            break;
        case #"hash_df2acf14444d46fe":
            splash_name = #"hash_b81b31c7780a4978";
            break;
        case #"hash_7a79227b6abedfe7":
            break;
        default:
            break;
    }
    
    if ( isdefined( splash_name ) )
    {
        hud_util::showsplashtoall( splash_name );
    }
}

