// scripts\mp\pack_a_punch.gsc  (hash_4f24ca7a470a5fa8.gscc) (size: 43009 Bytes / 0xa801 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8f7ad363 (2407191395)
// size ...... 43009 (0xa801)
// includes .. 23  (offset: 0x9f59)
// strings ... 93  (offset: 0xa011)
// dev strs .. 40  (offset: 0xa609)
// exports ... 82  (offset: 0x6c19)
// cseg ...... 0x692 + 0x6587 (0x6c19)
// imports ... 302 (offset: 0x78e9)
// animtree1 . 0   (offset: 0xa801)
// animtree2 . 0   (offset: 0xa801)
#using script_16ea1b94f0f381b3;
#using script_7e08b9bf9ee84ae1;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\throttle;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\ammomods\ammo_mod;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\gameplay_telemetry_utils;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\lui_game_event_aggregator;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\content_manager;
#using scripts\mp\currency;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\purchasemenu;

#namespace pack_a_punch;

// Namespace pack_a_punch
// Params 1
// Checksum 0x50a92845, Offset: 0x6b0
// Size: 0x284
function function_1df7c43f96254346( var_b6377f00348c4d99 )
{
    /#
        level thread setup_pap_devgui();
    #/
    
    level.var_db52bcfd04d45a7a = [];
    level.var_b6377f00348c4d99 = [];
    level.var_ad35b2865cace986 = [];
    content_manager::function_3209da123476142f( "pack_a_punch", &on_spawn_pap );
    content_manager::register_disable_toggle( "pack_a_punch", &content_manager::function_5d04e50a29a2142c, &function_a00fc65c9ba3e3b3, &function_e090b79ea7d29598 );
    level.pap_menu = namespace_52f9490ffe6dceba::register();
    level callback::add( #"player_connect", &pap_on_player_connect );
    
    /#
        callback::add( #"player_spawned", &on_player_spawned_debug );
    #/
    
    callback::add( #"player_weapon_change", &pap_on_weapon_change );
    level.var_4d2c203472cac121 = [ "", "_pack", "_pack", "_pack" ];
    level.var_db70b79e350d72e0 = 1;
    
    if ( !level.gamemodebundle.var_c214fc63695cd685 )
    {
        level thread init_pap_postmain();
    }
    else
    {
        callback::add( "ob_content_process_create_script", &init_pap_postmain );
    }
    
    level.var_eda995bb839c4aa = 3;
    level thread setup_pap_weapons( var_b6377f00348c4d99 );
    utility::registersharedfunc( #"zombie", #"get_pap_level", &get_pap_level );
    utility::registersharedfunc( #"pack_a_punch", #"hash_1d402cf8c2699623", &can_pap );
    utility::registersharedfunc( #"pack_a_punch", #"get_pap_level", &get_pap_level );
    utility::registersharedfunc( #"pack_a_punch", #"pap_weapon", &pap_weapon );
    utility::registersharedfunc( #"pack_a_punch", #"hash_4fb89d74adceafac", &function_3f3b9cdbb4843e45 );
    utility::registersharedfunc( #"pack_a_punch", #"hash_902a07dfe723b1db", &function_e190a315803e2870 );
    utility::registersharedfunc( #"pack_a_punch", #"hash_c458b63cb3f275f4", &function_893799cfb3f4d2d7 );
    utility::registersharedfunc( #"pack_a_punch", #"hash_7f95018b0780f0f1", &function_7582541a5928214a );
    
    if ( game_utility::getgametype() != "zm_rb_rh_mod" )
    {
        level.throttle_pap_disable_camo = throttle::throttle_initialize( "pap_disable_camo" );
    }
    
    level callback::add( "ob_content_process_create_script", &function_982ce43baec61a4e );
    level callback::add( #"player_connect", &function_e28510c62be79452 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_6d3ed6f5b0d27e3", &function_116eb69b8a2b16f );
}

// Namespace pack_a_punch
// Params 1
// Checksum 0x36837fb8, Offset: 0x93c
// Size: 0xf3
function function_982ce43baec61a4e( params )
{
    if ( isdefined( level.var_37ee95c5464d47be ) )
    {
        a_s_paps = [];
        var_aa72fc23f7515d32 = utility::getstructarray( "content_struct", "variantname" );
        
        foreach ( struct in var_aa72fc23f7515d32 )
        {
            if ( struct.content_key == "pap_spawn" )
            {
                a_s_paps[ a_s_paps.size ] = struct;
            }
        }
        
        a_s_paps = [[ level.var_37ee95c5464d47be ]]( "pap", a_s_paps, &function_734fe1b5065e79e );
        level.var_db52bcfd04d45a7a = arraycombineunique( level.var_db52bcfd04d45a7a, a_s_paps );
    }
}

// Namespace pack_a_punch
// Params 1, eflags: 0x4
// Checksum 0xdb51492c, Offset: 0xa37
// Size: 0x15
function private function_734fe1b5065e79e( s_pap_spawn )
{
    s_pap_spawn init_pap_machine();
}

// Namespace pack_a_punch
// Params 1
// Checksum 0xbc4e07f, Offset: 0xa54
// Size: 0x16
function pap_on_player_connect( params )
{
    self.var_66c0acd81fb4e585 = [];
}

/#

    // Namespace pack_a_punch
    // Params 1
    // Checksum 0x998cbd39, Offset: 0xa72
    // Size: 0x1b6, Type: dev
    function on_player_spawned_debug( params )
    {
        self endon( #"disconnect" );
        wait 3;
        
        if ( level.var_db70b79e350d72e0 )
        {
            devgui::function_9082edeb5db93280( "<dev string:x24>" + self.name + "<dev string:x48>" );
            
            foreach ( s_pap in level.var_db52bcfd04d45a7a )
            {
                devgui::function_cd4e263c1f3018ae( s_pap.name, "<dev string:x4a>" + s_pap.name + "<dev string:x5b>" + self.name, &function_b6ee554704106fdc );
            }
            
            devgui::function_77df7fe7dd273e10();
            devgui::function_9082edeb5db93280( "<dev string:x5d>" + self.name + "<dev string:x48>" );
            
            foreach ( s_pap in level.var_db52bcfd04d45a7a )
            {
                devgui::function_cd4e263c1f3018ae( s_pap.name, "<dev string:x86>" + s_pap.name + "<dev string:x5b>" + self.name, &function_956f26a22960ee7d );
            }
            
            devgui::function_77df7fe7dd273e10();
        }
    }

#/

// Namespace pack_a_punch
// Params 0
// Checksum 0x21d850c0, Offset: 0xc30
// Size: 0x1a4
function init_pap_items()
{
    level.var_f77ef06e8d43541e = [];
    s_pap_bundle = get_pap_bundle();
    level.var_f77ef06e8d43541e[ "hintstring_only" ] = spawnstruct();
    level.var_f77ef06e8d43541e[ "hintstring_only" ].var_559189061c13ab07 = s_pap_bundle.var_b68a93a60d51f01e;
    level.var_f77ef06e8d43541e[ "hintstring_only" ].var_c15749ce10b9a440 = s_pap_bundle.var_fd1992ca3d85e228;
    level.var_f77ef06e8d43541e[ "hintstring_only" ].var_d7ab3d8d018854a2 = s_pap_bundle.var_27aada297da8abd9;
    level.var_f77ef06e8d43541e[ "hintstring_only" ].var_a003b6aa4ffbf96d = s_pap_bundle.var_b156f81c1c553108;
    level.var_f77ef06e8d43541e[ "hintstring_only" ].var_536ce3d06c70676 = s_pap_bundle.var_65974778ebd3a6;
    level.var_f77ef06e8d43541e[ "hintstring_only" ].var_6f38c318f5f97e77 = s_pap_bundle.var_6f1bb288296debc8;
    level.var_f77ef06e8d43541e[ "hintstring_only" ].var_9c1bb3b0a73a1fcc = s_pap_bundle.var_217398a8839bc369;
    level.var_f77ef06e8d43541e[ "hintstring_only" ].var_38660cab607b147e = s_pap_bundle.tiericonlist;
    level.var_f77ef06e8d43541e[ "hintstring_only" ].str_pap_disabled = s_pap_bundle.var_349929c48692e697;
    level.var_f77ef06e8d43541e[ "hintstring_only" ].var_118b4c97063b3506 = s_pap_bundle.var_2aabfe65e36e970f;
}

// Namespace pack_a_punch
// Params 1
// Checksum 0x7f078eca, Offset: 0xddc
// Size: 0x48
function function_870d519a9b809a9c( v_pos )
{
    if ( isdefined( level.var_2616e52fe1bd99e6 ) )
    {
        s_pap_menu = [[ level.var_2616e52fe1bd99e6 ]]( v_pos );
    }
    else
    {
        s_pap_menu = purchasemenu::get_purchasemenu( #"pap" );
    }
    
    return s_pap_menu;
}

/#

    // Namespace pack_a_punch
    // Params 0
    // Checksum 0x314c894f, Offset: 0xe2d
    // Size: 0xc7, Type: dev
    function setup_pap_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x9c>" );
        devgui::add_devgui_func( "<dev string:xb0>", "<dev string:xc0>", &function_e8d1716e8437b56d, 1 );
        devgui::add_devgui_func( "<dev string:xd0>", "<dev string:xe4>", &enable_pap_machines );
        devgui::add_devgui_func( "<dev string:xf8>", "<dev string:x10b>", &function_1c08bba9b3cd9d4d );
        devgui::add_devgui_func( "<dev string:x11e>", "<dev string:x133>", &function_12f9865b7e3d3e7e );
        devgui::add_devgui_func( "<dev string:x148>", "<dev string:x168>", &function_b4959cc3374fde66 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x188>" );
        devgui::add_devgui_func( "<dev string:xf8>", "<dev string:x10b>", &function_1c08bba9b3cd9d4d );
        devgui::add_devgui_func( "<dev string:x11e>", "<dev string:x133>", &function_12f9865b7e3d3e7e );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace pack_a_punch
    // Params 1, eflags: 0x4
    // Checksum 0xd49cf3c, Offset: 0xefc
    // Size: 0x13f, Type: dev
    function private function_b6ee554704106fdc( params )
    {
        s_pap = undefined;
        
        foreach ( s_pap in level.var_db52bcfd04d45a7a )
        {
            if ( s_pap.name == params[ 0 ] )
            {
                foreach ( player in level.players )
                {
                    if ( player.name == params[ 1 ] )
                    {
                        player.b_close_pap = undefined;
                        s_pap.var_370acb837a3a86c3.interact on_use_pap_machine( player );
                        return;
                    }
                }
            }
        }
    }

    // Namespace pack_a_punch
    // Params 1, eflags: 0x4
    // Checksum 0xf3d99cde, Offset: 0x1043
    // Size: 0x133, Type: dev
    function private function_956f26a22960ee7d( params )
    {
        s_pap = undefined;
        
        foreach ( s_pap in level.var_db52bcfd04d45a7a )
        {
            if ( s_pap.name == params[ 0 ] )
            {
                foreach ( player in level.players )
                {
                    if ( player.name == params[ 1 ] )
                    {
                        if ( isdefined( player.var_c51700b82e11cef3 ) )
                        {
                            player.b_close_pap = 1;
                        }
                        
                        return;
                    }
                }
            }
        }
    }

    // Namespace pack_a_punch
    // Params 0, eflags: 0x4
    // Checksum 0x3c4c6da9, Offset: 0x117e
    // Size: 0xaf, Type: dev
    function private function_1c08bba9b3cd9d4d()
    {
        foreach ( player in level.players )
        {
            currentweapon = player getcurrentweapon();
            
            if ( player can_pap( currentweapon ) )
            {
                n_current_weapon_lvl = player get_pap_level( currentweapon );
                player pap_weapon( currentweapon, n_current_weapon_lvl );
            }
        }
    }

    // Namespace pack_a_punch
    // Params 0, eflags: 0x4
    // Checksum 0x79c8d4ff, Offset: 0x1235
    // Size: 0x84, Type: dev
    function private function_12f9865b7e3d3e7e()
    {
        foreach ( player in level.players )
        {
            player unpap_weapon( player getcurrentweapon() );
        }
    }

    // Namespace pack_a_punch
    // Params 0, eflags: 0x4
    // Checksum 0xfae38785, Offset: 0x12c1
    // Size: 0x7e, Type: dev
    function private enable_pap_machines()
    {
        foreach ( s_pap_info in level.var_db52bcfd04d45a7a )
        {
            s_pap_info function_6070a52035419b87();
        }
    }

    // Namespace pack_a_punch
    // Params 0, eflags: 0x4
    // Checksum 0x6efce947, Offset: 0x1347
    // Size: 0xc, Type: dev
    function private function_b4959cc3374fde66()
    {
        function_116eb69b8a2b16f();
    }

#/

// Namespace pack_a_punch
// Params 1
// Checksum 0xe8f40054, Offset: 0x135b
// Size: 0x47
function function_116eb69b8a2b16f( params )
{
    if ( level.var_eda995bb839c4aa )
    {
        level.var_eda995bb839c4aa = minint( level.var_eda995bb839c4aa + 1, 4 );
        iprintlnbold( "Max Pack A Punch Level increased to: " + level.var_eda995bb839c4aa );
    }
}

// Namespace pack_a_punch
// Params 1
// Checksum 0x34b0a95d, Offset: 0x13aa
// Size: 0x1ad
function init_pap_postmain( params )
{
    level endon( #"game_ended" );
    waittillframeend();
    init_pap_items();
    init_pap_camos();
    var_62638af37653ded7 = utility::getstructarray( "content_destination", "variantname" );
    
    foreach ( destination in var_62638af37653ded7 )
    {
        level thread function_92b3fe44ac60bbc( destination );
    }
    
    var_5058770639c1bf70 = utility::getstructarray( "pack_a_punch_machine", "script_noteworthy" );
    var_aab86f205f6cf491 = [];
    
    foreach ( i, s_pap_info in var_5058770639c1bf70 )
    {
        if ( s_pap_info content_manager::function_e0f0562adcd2c071() )
        {
            s_pap_info.var_93e4a0a8514ca47e = s_pap_info.targetname ?? "Pap Location " + i;
            s_pap_info thread init_pap_machine();
            var_aab86f205f6cf491[ var_aab86f205f6cf491.size ] = s_pap_info;
        }
    }
    
    level.var_db52bcfd04d45a7a = arraycombineunique( level.var_db52bcfd04d45a7a, var_aab86f205f6cf491 );
    lui_game_event_aggregator::registeronluieventcallback( &weapon_upgrade_purchase );
    level notify( #"init_pap_postMain_end" );
}

// Namespace pack_a_punch
// Params 1
// Checksum 0x9380258b, Offset: 0x155f
// Size: 0x135
function function_92b3fe44ac60bbc( destination )
{
    if ( !( level.gametypebundle.var_a35e03a805c3c094 ?? 1 ) )
    {
        return;
    }
    
    foreach ( location in destination.locations )
    {
        var_804a2a8ecc0273af = location.instances[ "pack_a_punch" ];
        
        if ( isdefined( var_804a2a8ecc0273af ) )
        {
            foreach ( instance in var_804a2a8ecc0273af.versions )
            {
                content_manager::function_67e4b7678fb21e11( instance );
            }
        }
    }
}

// Namespace pack_a_punch
// Params 1, eflags: 0x4
// Checksum 0x9cee5248, Offset: 0x169c
// Size: 0x100
function private on_spawn_pap( instance )
{
    level.var_db52bcfd04d45a7a = arraycombineunique( level.var_db52bcfd04d45a7a, instance.var_1d6cddfc47031bff[ "pap_spawn" ] );
    var_aab86f205f6cf491 = [];
    
    foreach ( s_pap_info in level.var_db52bcfd04d45a7a )
    {
        if ( s_pap_info content_manager::function_e0f0562adcd2c071() )
        {
            s_pap_info.var_93e4a0a8514ca47e = instance.location.destination.targetname;
            s_pap_info init_pap_machine( instance );
            var_aab86f205f6cf491[ var_aab86f205f6cf491.size ] = s_pap_info;
        }
    }
    
    level.var_db52bcfd04d45a7a = var_aab86f205f6cf491;
}

// Namespace pack_a_punch
// Params 1
// Checksum 0x5da8fce4, Offset: 0x17a4
// Size: 0xc2
function setup_pap_weapons( var_b6377f00348c4d99 )
{
    if ( isdefined( level.weaponmetadata ) )
    {
        var_b6377f00348c4d99 = [];
        
        foreach ( var_2e08e94c9cb1747c, var_fe68cd50dcda7fdc in level.weaponmetadata )
        {
            if ( var_fe68cd50dcda7fdc.canpap )
            {
                var_b6377f00348c4d99[ var_2e08e94c9cb1747c ] = var_2e08e94c9cb1747c;
            }
        }
    }
    
    /#
        if ( !isdefined( var_b6377f00348c4d99 ) )
        {
            assertmsg( "<dev string:x1a4>" );
        }
    #/
    
    level.var_b6377f00348c4d99 = var_b6377f00348c4d99;
}

// Namespace pack_a_punch
// Params 0
// Checksum 0xd407fd1c, Offset: 0x186e
// Size: 0xc9
function get_pap_bundle()
{
    var_cd16a2e74383ea61 = getactivemapinfobundle();
    var_866ddf4c549b5c32 = var_cd16a2e74383ea61.packapunchbundle ?? level.gametypebundle.packapunchbundle ?? level.gamemodebundle.packapunchbundle;
    assert( isdefined( var_866ddf4c549b5c32 ), "<dev string:x1ca>" );
    
    if ( isstring( self.script_modelname ) )
    {
        str_bundle_name_test = "packapunch:" + self.script_modelname;
        bundle = getscriptbundle( str_bundle_name_test );
        
        if ( isdefined( bundle ) )
        {
            return bundle;
        }
    }
    
    str_bundle_name = level.var_9afe2a15c55fcc5 ?? var_866ddf4c549b5c32;
    return getscriptbundle( "packapunch:" + str_bundle_name );
}

// Namespace pack_a_punch
// Params 0
// Checksum 0xf6315ea5, Offset: 0x1940
// Size: 0x28
function init_pap_camos()
{
    s_bundle = get_pap_bundle();
    level.var_2932bfd7dda0f235 = s_bundle.camolist;
}

// Namespace pack_a_punch
// Params 0
// Checksum 0xbb807042, Offset: 0x1970
// Size: 0x3c, Type: bool
function function_77ac7320712129ac()
{
    s_bundle = get_pap_bundle();
    
    if ( isdefined( s_bundle.scriptable ) && s_bundle.scriptable != "" )
    {
        return true;
    }
    
    return false;
}

// Namespace pack_a_punch
// Params 1
// Checksum 0x6afae0f6, Offset: 0x19b5
// Size: 0x436
function init_pap_machine( instance )
{
    if ( isdefined( self.var_370acb837a3a86c3 ) )
    {
        return;
    }
    
    s_bundle = get_pap_bundle();
    self.var_b3c2c35b436aed93 = s_bundle.model;
    
    if ( !isdefined( self.radius ) )
    {
        self.radius = 64;
    }
    
    if ( !isdefined( level.var_540858830fb2a139 ) )
    {
        level.var_540858830fb2a139 = 0;
    }
    
    self.name = self.targetname ?? "PAP_" + level.var_540858830fb2a139;
    level.var_540858830fb2a139++;
    
    if ( !isdefined( level.var_db52bcfd04d45a7a ) )
    {
        level.var_db52bcfd04d45a7a = [];
    }
    
    level.var_db52bcfd04d45a7a = arraycombineunique( level.var_db52bcfd04d45a7a, [ self ] );
    
    if ( function_77ac7320712129ac() )
    {
        str_scriptable = get_pap_bundle().scriptable;
        self.var_370acb837a3a86c3 = spawnscriptable( str_scriptable, self.origin, self.angles );
        self.var_370acb837a3a86c3.interact = interaction::register_scriptable_interact( self.var_370acb837a3a86c3, &on_use_pap_machine );
        self.var_370acb837a3a86c3.s_pap = self;
        self.var_370acb837a3a86c3.s_pap_menu = function_870d519a9b809a9c( self.var_370acb837a3a86c3.origin );
        thread function_d9ce48cca2ff225b();
        
        if ( !s_bundle.var_a366177ce1079a41 )
        {
            self.var_370acb837a3a86c3.interact interaction::set_interact_hint_callback( &pap_per_player_hint );
        }
    }
    else
    {
        self.var_370acb837a3a86c3 = content_manager::spawn_script_model( self, self.var_b3c2c35b436aed93, 1, 1 );
        assert( self.var_370acb837a3a86c3 isscriptable(), "<dev string:x236>" );
        self.var_370acb837a3a86c3.s_pap_menu = function_870d519a9b809a9c( self.var_370acb837a3a86c3.origin );
        self.var_370acb837a3a86c3.n_nav_obstacle = createnavobstaclebyent( self.var_370acb837a3a86c3 );
    }
    
    utility::callsharedfunc( #"scriptable", #"hash_10d5e3bb8a551724", self.var_370acb837a3a86c3, "minimap_icon", 0 );
    
    if ( !function_77ac7320712129ac() )
    {
        if ( s_bundle.var_a366177ce1079a41 )
        {
            self.var_370acb837a3a86c3.interact = interaction::register_interact( self.var_370acb837a3a86c3, self.radius, &on_use_pap_machine, undefined, undefined, undefined, undefined, "HINT_BUTTON" );
            self.var_370acb837a3a86c3.interact interaction::function_3d5329c553924b3();
            self.var_370acb837a3a86c3.interact interaction::set_interact_hint_callback( &pap_menu_per_player_hint );
        }
        else
        {
            self.var_370acb837a3a86c3.interact = interaction::register_interact( self.var_370acb837a3a86c3, self.radius, &on_use_pap_machine, undefined, undefined, undefined, undefined, "HINT_BUTTON" );
            self.var_370acb837a3a86c3.interact interaction::set_interact_hint_callback( &pap_per_player_hint );
        }
        
        self.var_370acb837a3a86c3.interact setusefov( 130 );
        self.var_370acb837a3a86c3.interact.var_9f9432741e058419 = self;
        
        if ( self.var_370acb837a3a86c3.interact tagexists( "tag_hint" ) )
        {
            self.var_370acb837a3a86c3.interact sethinttag( "tag_hint" );
        }
        
        self.var_370acb837a3a86c3.interact.s_pap = self;
    }
    
    if ( self.script_start )
    {
        function_6070a52035419b87( 1 );
    }
    else
    {
        disable_pap( 1 );
        thread function_6bef4f03bfe01f85();
    }
    
    self.var_370acb837a3a86c3 utility::callsharedfunc( #"zombie", #"hash_896b88a46f6a4c15", "pap" );
    level notify( #"hash_3c00bc13d8b0818d" );
}

// Namespace pack_a_punch
// Params 0
// Checksum 0x313e0505, Offset: 0x1df3
// Size: 0x7c
function function_d9ce48cca2ff225b()
{
    if ( isdefined( self.var_370acb837a3a86c3.s_pap_menu.str_region_color ) )
    {
        b_success = self.var_370acb837a3a86c3 utility::function_7c10ea82c1e305b8( "region_color", "off" );
        waitframe();
        b_success = self.var_370acb837a3a86c3 utility::function_7c10ea82c1e305b8( "region_color", self.var_370acb837a3a86c3.s_pap_menu.str_region_color );
    }
}

// Namespace pack_a_punch
// Params 1
// Checksum 0xdb67da87, Offset: 0x1e77
// Size: 0xd9
function function_8f1fa83e850e19db( weapon )
{
    var_2e08e94c9cb1747c = weapon.var_1616e6fbba9a722d;
    var_730c764888e73db3 = level.weaponmetadata[ var_2e08e94c9cb1747c ].var_a0f67da9669fe547;
    
    foreach ( override in var_730c764888e73db3 )
    {
        if ( override.var_26bf283b8c9a61c2 && weapon hasattachment( override.var_26bf283b8c9a61c2 ) )
        {
            return override.var_26bf283b8c9a61c2;
        }
    }
}

// Namespace pack_a_punch
// Params 2
// Checksum 0x2c1d1b75, Offset: 0x1f59
// Size: 0x62d
function pap_per_player_hint( usable, player )
{
    if ( player.interactions_disabled || player.var_73e2de392faa52c6 )
    {
        return { #string:usable.var_ac57fe7fccb8aaf6 ?? &"", #type:"HINT_NOBUTTON" };
    }
    
    w_current = player getcurrentweapon();
    var_951c89546ec50477 = player get_pap_level( w_current );
    s_pap_menu = function_870d519a9b809a9c( usable.origin );
    
    if ( isdefined( s_pap_menu ) )
    {
        item = purchasemenu::create_item_struct( s_pap_menu.ref, var_951c89546ec50477 + 1 );
        
        if ( isdefined( item ) )
        {
            cost = item.cost;
            currency = item.currency;
            
            if ( isdefined( player.perks[ "specialty_exfil_pap_percent_reward" ] ) )
            {
                cost = int( item.cost * level.perkbundles[ "specialty_exfil_pap_percent_reward" ].var_9c085df7f7b6b417 );
            }
            
            if ( isdefined( level.get_pap_cost_override ) && isdefined( item.cost ) )
            {
                cost = [[ level.get_pap_cost_override ]]( item );
            }
        }
    }
    
    hintstring_obj = { #icon:level.var_f77ef06e8d43541e[ "hintstring_only" ].var_38660cab607b147e[ var_951c89546ec50477 ].interactionicon, #description:level.var_f77ef06e8d43541e[ "hintstring_only" ].var_d7ab3d8d018854a2, #buttoncallout:level.var_f77ef06e8d43541e[ "hintstring_only" ].var_6f38c318f5f97e77, #title:level.var_f77ef06e8d43541e[ "hintstring_only" ].var_559189061c13ab07[ var_951c89546ec50477 ].var_6308f26ec9e9dd19, #type:"HINT_BUTTON", #string:&"" };
    
    if ( var_951c89546ec50477 == level.var_eda995bb839c4aa )
    {
        hintstring_obj.title = level.var_f77ef06e8d43541e[ "hintstring_only" ].var_c15749ce10b9a440;
        hintstring_obj.icon = level.var_f77ef06e8d43541e[ "hintstring_only" ].var_38660cab607b147e[ var_951c89546ec50477 - 1 ].interactionicon;
        hintstring_obj.aux_text = level.var_f77ef06e8d43541e[ "hintstring_only" ].var_118b4c97063b3506;
        hintstring_obj.interactable = 0;
    }
    
    if ( isfunction( usable.var_30d174d0f64b3709 ) )
    {
        hintstring_obj = [[ usable.var_30d174d0f64b3709 ]]( usable, player, hintstring_obj, cost );
    }
    
    if ( isfunction( usable.hint_override ) )
    {
        return [[ usable.hint_override ]]( usable, player, hintstring_obj, cost );
    }
    
    if ( isdefined( cost ) && !hintstring_obj.var_2947462488e8ec80 )
    {
        hintstring_obj.var_776a268784e089af = level.var_f77ef06e8d43541e[ "hintstring_only" ].var_a003b6aa4ffbf96d;
        hintstring_obj.icon_text_value = cost;
    }
    
    if ( isdefined( usable.var_9f9432741e058419.script_power ) && !utility::flag( usable.var_9f9432741e058419.script_power ) )
    {
        hintstring_obj.aux_text = &"SHARED_HINTSTRINGS/NEED_POWER_RED";
        hintstring_obj.interactable = 0;
        return hintstring_obj;
    }
    
    if ( utility::issharedfuncdefined( #"pack_a_punch", #"hash_7faee5bb45d67f5" ) && var_951c89546ec50477 >= 1 )
    {
        return player utility::callsharedfunc( #"pack_a_punch", #"hash_7faee5bb45d67f5" );
    }
    
    if ( !player can_pap( w_current ) )
    {
        hintstring_obj.interactable = 0;
        
        if ( var_951c89546ec50477 != level.var_eda995bb839c4aa )
        {
            hintstring_obj.aux_text = level.var_f77ef06e8d43541e[ "hintstring_only" ].str_pap_disabled;
        }
        else
        {
            hintstring_obj.var_776a268784e089af = undefined;
            hintstring_obj.icon_text_value = undefined;
        }
        
        return hintstring_obj;
    }
    
    if ( isdefined( s_pap_menu ) )
    {
        if ( !isdefined( item ) )
        {
            hintstring_obj.aux_text = level.var_f77ef06e8d43541e[ "hintstring_only" ].var_118b4c97063b3506;
            hintstring_obj.interactable = 0;
            return hintstring_obj;
        }
    }
    else
    {
        hintstring_obj.aux_text = level.var_f77ef06e8d43541e[ "hintstring_only" ].var_118b4c97063b3506;
        hintstring_obj.interactable = 0;
        return hintstring_obj;
    }
    
    if ( !isdefined( hintstring_obj.var_2947462488e8ec80 ) )
    {
        hintstring_obj.var_2947462488e8ec80 = self.var_64959b130d778640 && arraycontains( self.var_64959b130d778640, w_current );
    }
    
    if ( !player currency::can_afford( currency, cost ) && !hintstring_obj.var_2947462488e8ec80 )
    {
        hintstring_obj.aux_text = level.var_f77ef06e8d43541e[ "hintstring_only" ].var_9c1bb3b0a73a1fcc;
        hintstring_obj.var_776a268784e089af = level.var_f77ef06e8d43541e[ "hintstring_only" ].var_536ce3d06c70676;
        hintstring_obj.interactable = 0;
    }
    else
    {
        hintstring_obj.aux_text = w_current.displayname;
        base_attachment = function_8f1fa83e850e19db( w_current );
        
        if ( base_attachment )
        {
            attachment_display_name = w_current function_8ef5e488f792a67c( base_attachment );
            
            if ( attachment_display_name )
            {
                hintstring_obj.aux_text = attachment_display_name;
            }
        }
    }
    
    if ( var_951c89546ec50477 < 0 || var_951c89546ec50477 >= level.var_eda995bb839c4aa )
    {
        hintstring_obj.aux_text = level.var_f77ef06e8d43541e[ "hintstring_only" ].var_118b4c97063b3506;
        hintstring_obj.interactable = 0;
    }
    
    return hintstring_obj;
}

// Namespace pack_a_punch
// Params 2
// Checksum 0x57e99df6, Offset: 0x258f
// Size: 0xa3
function pap_menu_per_player_hint( usable, player )
{
    if ( isdefined( player ) && isdefined( usable ) )
    {
        if ( player.interactions_disabled || player.var_73e2de392faa52c6 )
        {
            return { #string:&"", #type:"HINT_NOICON" };
        }
        
        return { #string:&"shared_hintstrings/pap_use", #type:"HINT_BUTTON" };
    }
    
    return { #string:&"", #type:"HINT_NOICON" };
}

// Namespace pack_a_punch
// Params 0
// Checksum 0xae7762d5, Offset: 0x263b
// Size: 0x26
function function_6bef4f03bfe01f85()
{
    if ( isdefined( self.script_power ) )
    {
        utility::flag_wait( self.script_power );
    }
    
    thread function_6070a52035419b87();
}

// Namespace pack_a_punch
// Params 2
// Checksum 0x60e2b9ce, Offset: 0x2669
// Size: 0xd7
function disable_pap( b_immediate, to_disabled = 0 )
{
    if ( isdefined( self.var_370acb837a3a86c3 ) )
    {
        if ( function_77ac7320712129ac() )
        {
            self.var_370acb837a3a86c3 utility::function_7c10ea82c1e305b8( "usable", "off" );
            self.var_370acb837a3a86c3 utility::function_7c10ea82c1e305b8( "audio_ambient", "off" );
        }
        
        if ( to_disabled )
        {
            self.var_370acb837a3a86c3 utility::function_7c10ea82c1e305b8( "minimap_icon", "disabled" );
            self.var_370acb837a3a86c3 utility::function_7c10ea82c1e305b8( "base", "disabled" );
            self.var_370acb837a3a86c3 utility::function_7c10ea82c1e305b8( "music", "off" );
        }
        
        disable_interact();
        self.var_1c9754ecd2f9d888 = undefined;
        self notify( #"disable_pap" );
    }
}

// Namespace pack_a_punch
// Params 1
// Checksum 0x8af04677, Offset: 0x2748
// Size: 0xc3
function function_6070a52035419b87( b_immediate )
{
    if ( isdefined( self.var_370acb837a3a86c3 ) )
    {
        self.var_1c9754ecd2f9d888 = 1;
        
        if ( b_immediate )
        {
            self.var_370acb837a3a86c3 utility::function_7c10ea82c1e305b8( "base", "pap_idle" );
            function_de48127d5b3b7e8c();
        }
        else
        {
            var_a6a35d3f2253bf4a = 4.1;
            self.var_370acb837a3a86c3 utility::function_7c10ea82c1e305b8( "base", "pap_activate" );
            utility::delaythread( var_a6a35d3f2253bf4a, &function_de48127d5b3b7e8c );
        }
        
        self.var_370acb837a3a86c3 utility::function_7c10ea82c1e305b8( "minimap_icon", "active" );
        
        if ( game_utility::getgametype() != "zm_rb_rh_mod" )
        {
            thread function_6aaacfe23a7627fa();
        }
        
        level utility::flag_set( "pap_unlocked" );
    }
}

// Namespace pack_a_punch
// Params 4
// Checksum 0x92bf78e0, Offset: 0x2813
// Size: 0x81
function function_d38459448f4fef64( var_2b0c20cebe23ba0b, str_tag, var_d1f47820ce3cbf47 = ( 0, 0, 0 ), v_angles_offset = ( 0, 0, 0 ) )
{
    if ( isent( self ) )
    {
        if ( isdefined( str_tag ) )
        {
            self linkto( var_2b0c20cebe23ba0b, str_tag, var_d1f47820ce3cbf47, v_angles_offset );
        }
        else
        {
            self linkto( var_2b0c20cebe23ba0b );
        }
        
        return;
    }
    
    self scriptablesetparententity( var_2b0c20cebe23ba0b, var_d1f47820ce3cbf47, v_angles_offset );
}

// Namespace pack_a_punch
// Params 1
// Checksum 0x6e0d2d88, Offset: 0x289c
// Size: 0x55, Type: bool
function can_use_pap_machine( player )
{
    if ( !isplayer( player ) )
    {
        return false;
    }
    
    weapon = player getcurrentweapon();
    
    if ( !isdefined( level.var_b6377f00348c4d99[ weapon.var_1616e6fbba9a722d ] ) && !ammo_mod::function_7bbc1db07694f31d( weapon ) )
    {
        return false;
    }
    
    return true;
}

// Namespace pack_a_punch
// Params 1
// Checksum 0x75926b7f, Offset: 0x28fa
// Size: 0xd7
function on_use_pap_machine( player )
{
    if ( isfunction( self.use_override ) )
    {
        return [[ self.use_override ]]( self, player );
    }
    
    if ( isdefined( self.var_9f9432741e058419.script_power ) && !utility::flag( self.var_9f9432741e058419.script_power ) )
    {
        return;
    }
    
    if ( !can_use_pap_machine( player ) )
    {
        player playsoundtoplayer( "ui_zm_core_purchase_deny", player );
        return;
    }
    
    if ( player.interactions_disabled || player.var_73e2de392faa52c6 )
    {
        return;
    }
    
    self.s_pap.var_37f3a4cd8252c9f0 = player;
    player.var_c51700b82e11cef3 = self.s_pap;
    player thread function_415cb2a19b5c8bda( self.s_pap );
}

// Namespace pack_a_punch
// Params 0
// Checksum 0x802fb710, Offset: 0x29d9
// Size: 0xc2
function function_de48127d5b3b7e8c()
{
    if ( function_77ac7320712129ac() )
    {
        self.var_370acb837a3a86c3 utility::function_7c10ea82c1e305b8( "usable", "on" );
        
        foreach ( player in level.players )
        {
            self.var_370acb837a3a86c3 enablescriptableplayeruse( player );
        }
        
        return;
    }
    
    self.var_370acb837a3a86c3.interact setusableenabled( 1 );
}

// Namespace pack_a_punch
// Params 0
// Checksum 0x55cb3fbd, Offset: 0x2aa3
// Size: 0xc1
function disable_interact()
{
    if ( function_77ac7320712129ac() )
    {
        self.var_370acb837a3a86c3 utility::function_7c10ea82c1e305b8( "usable", "off" );
        
        foreach ( player in level.players )
        {
            self.var_370acb837a3a86c3 disablescriptableplayeruse( player );
        }
        
        return;
    }
    
    self.var_370acb837a3a86c3.interact setusableenabled( 0 );
}

// Namespace pack_a_punch
// Params 2
// Checksum 0xd328258f, Offset: 0x2b6c
// Size: 0x1f2
function weapon_upgrade_purchase( channel, var_1923b2b3afc076ba )
{
    if ( isdefined( var_1923b2b3afc076ba ) )
    {
        if ( channel == "pap_weaponupgrade_purchase" )
        {
            s_pap_menu = function_870d519a9b809a9c( self.origin );
            
            if ( !isdefined( s_pap_menu ) )
            {
                return;
            }
            
            currentweapon = self getcurrentweapon();
            n_weapon_level = get_pap_level( currentweapon );
            item = purchasemenu::create_item_struct( s_pap_menu.ref, var_1923b2b3afc076ba );
            
            if ( !isdefined( item ) || n_weapon_level != item.tier - 1 )
            {
                purchasemenu::function_93f934ea2f1c06f8( 4 );
                return;
            }
            
            if ( !self.var_64959b130d778640 || !arraycontains( self.var_64959b130d778640, currentweapon ) )
            {
                if ( !function_57721cf7bdb87284( var_1923b2b3afc076ba ) )
                {
                    purchasemenu::function_93f934ea2f1c06f8( 3 );
                    return;
                }
            }
            
            if ( can_pap( currentweapon ) )
            {
                pap_weapon_purchase( self.var_c51700b82e11cef3, n_weapon_level, currentweapon, item );
            }
            
            return;
        }
        
        if ( channel == "pap_ammomod_purchase" )
        {
            s_pap_menu = function_870d519a9b809a9c( self.origin );
            
            if ( !isdefined( s_pap_menu ) )
            {
                return;
            }
            
            currentweapon = self getcurrentweapon();
            n_mod_name = get_mod_name( currentweapon );
            item = purchasemenu::create_item_struct( s_pap_menu.ref, var_1923b2b3afc076ba );
            
            if ( !isdefined( item ) || n_mod_name == item.itemref )
            {
                purchasemenu::function_93f934ea2f1c06f8( 4 );
                return;
            }
            
            if ( !self.var_64959b130d778640 || !arraycontains( self.var_64959b130d778640, currentweapon ) )
            {
                if ( !function_57721cf7bdb87284( var_1923b2b3afc076ba ) )
                {
                    purchasemenu::function_93f934ea2f1c06f8( 3 );
                    return;
                }
            }
            
            if ( ammo_mod::function_7bbc1db07694f31d( currentweapon ) )
            {
                ammo_mod_purchase( self.var_c51700b82e11cef3, currentweapon, item );
            }
            
            return;
        }
        
        if ( purchasemenu::function_bc886ba2b8da88c( #"pap", channel ) )
        {
            self.b_close_pap = 1;
        }
    }
}

// Namespace pack_a_punch
// Params 1
// Checksum 0xe3cba02d, Offset: 0x2d66
// Size: 0x34
function get_mod_id( weapon )
{
    if ( !isplayer( self ) )
    {
        return int( 0 );
    }
    
    if ( ammo_mod::has_ammo_mod( weapon ) )
    {
        return ammo_mod::get_ammo_mod_id( weapon );
    }
    
    return int( 0 );
}

// Namespace pack_a_punch
// Params 1
// Checksum 0x2d351978, Offset: 0x2da3
// Size: 0x34
function get_mod_name( weapon )
{
    if ( !isplayer( self ) )
    {
        return "";
    }
    
    if ( ammo_mod::has_ammo_mod( weapon ) )
    {
        return ammo_mod::get_ammo_mod_name( weapon );
    }
    
    return "";
}

// Namespace pack_a_punch
// Params 1
// Checksum 0xcaf12f9f, Offset: 0x2de0
// Size: 0xce
function get_pap_level( weapon )
{
    if ( !isplayer( self ) || !( isdefined( self.var_66c0acd81fb4e585 ) && isdefined( weapon ) ) )
    {
        return int( 0 );
    }
    
    weapon = weapon getnoaltweapon();
    
    foreach ( var_480c050a98e37ea in self.var_66c0acd81fb4e585 )
    {
        if ( weapon == var_480c050a98e37ea.weapon )
        {
            return ( var_480c050a98e37ea.var_6694135a711872c9 ?? 0 );
        }
    }
    
    return int( 0 );
}

// Namespace pack_a_punch
// Params 1
// Checksum 0xff49ca9c, Offset: 0x2eb7
// Size: 0x30, Type: bool
function get_supports_pap( weaponobj )
{
    if ( !( isdefined( weaponobj ) && isdefined( level.var_b6377f00348c4d99[ weaponobj.var_1616e6fbba9a722d ] ) ) )
    {
        return false;
    }
    
    return true;
}

// Namespace pack_a_punch
// Params 1, eflags: 0x4
// Checksum 0xcf733d2, Offset: 0x2ef0
// Size: 0x26
function private pap_on_weapon_change( params )
{
    if ( !isnullweapon( params.weapon ) )
    {
        function_7582541a5928214a();
    }
}

// Namespace pack_a_punch
// Params 1
// Checksum 0xaca6df8d, Offset: 0x2f1e
// Size: 0xaa
function function_7582541a5928214a( weapon = self getcurrentweapon() )
{
    var_951c89546ec50477 = get_pap_level( weapon );
    var_7f4d06182d00c2f7 = get_supports_pap( weapon );
    weapslot = gameplay_telemetry_utils::function_87e071d9cdce86a7( weapon.basename );
    var_33bc680c9604894b = weapslot ? "ui_" + weapslot + "_weapon_pap_level_zm" : "undefined";
    
    if ( hasomnvar( var_33bc680c9604894b ) )
    {
        self setclientomnvar( var_33bc680c9604894b, var_951c89546ec50477 );
    }
    
    self setclientomnvar( "ui_pap_current_level", var_951c89546ec50477 );
    self setclientomnvar( "ui_current_weapon_supports_pap", var_7f4d06182d00c2f7 );
}

// Namespace pack_a_punch
// Params 3
// Checksum 0x2139c316, Offset: 0x2fd0
// Size: 0x11c
function ammo_mod_purchase( s_pap, currentweapon, item )
{
    if ( isdefined( s_pap.var_370acb837a3a86c3 ) )
    {
        s_pap.var_370acb837a3a86c3 utility::function_7c10ea82c1e305b8( "base", "pap_activate" );
    }
    
    self playsoundtoplayer( #"ui_zm_core_purchase_success", self );
    s_pap_menu = function_870d519a9b809a9c( self.origin );
    cost = 0;
    currency = #"essence";
    
    if ( isdefined( item ) )
    {
        cost = item.cost;
        currency = item.currency;
    }
    
    if ( isdefined( level.get_pap_cost_override ) && isdefined( item.cost ) )
    {
        cost = [[ level.get_pap_cost_override ]]( item );
    }
    
    ammo_mod::add_ammo_mod_to_weapon( currentweapon, item.itemref );
    currency::attempt_purchase( currency, cost, 1, undefined, #"ammomod" );
    purchasemenu::function_93f934ea2f1c06f8( 1 );
    level notify( #"pap_machine_activated" );
}

// Namespace pack_a_punch
// Params 4
// Checksum 0x8b0da9b6, Offset: 0x30f4
// Size: 0x1b1
function function_3f3b9cdbb4843e45( weapon, var_6694135a711872c9, var_e8d5225c13e8b53d, var_3248d20086ef13a0 )
{
    if ( !isplayer( self ) || !isdefined( self.var_66c0acd81fb4e585 ) )
    {
        return;
    }
    
    if ( !isdefined( var_e8d5225c13e8b53d ) )
    {
        var_e8d5225c13e8b53d = 1;
    }
    
    var_a765dd406c061c2c = 0;
    weapon = weapon getnoaltweapon();
    pap_weapons = self.var_66c0acd81fb4e585;
    
    for ( i = 0; i < pap_weapons.size ; i++ )
    {
        if ( var_3248d20086ef13a0 == pap_weapons[ i ].weapon )
        {
            self.var_66c0acd81fb4e585[ i ] = undefined;
            self.var_66c0acd81fb4e585[ i ] = undefined;
            
            if ( isint( i ) )
            {
                function_cdc669dbc8ea2101( self.var_66c0acd81fb4e585 );
            }
        }
    }
    
    foreach ( var_480c050a98e37ea in self.var_66c0acd81fb4e585 )
    {
        if ( weapon == var_480c050a98e37ea.weapon )
        {
            var_480c050a98e37ea.var_6694135a711872c9 = var_6694135a711872c9;
            var_a765dd406c061c2c = 1;
        }
    }
    
    if ( !var_a765dd406c061c2c && isdefined( var_6694135a711872c9 ) )
    {
        var_480c050a98e37ea = spawnstruct();
        var_480c050a98e37ea.weapon = weapon;
        var_480c050a98e37ea.var_6694135a711872c9 = var_6694135a711872c9;
        self.var_66c0acd81fb4e585[ self.var_66c0acd81fb4e585.size ] = var_480c050a98e37ea;
    }
    
    if ( var_e8d5225c13e8b53d )
    {
        function_7582541a5928214a( weapon );
    }
}

// Namespace pack_a_punch
// Params 1
// Checksum 0xf35e4976, Offset: 0x32ad
// Size: 0x2bc
function function_415cb2a19b5c8bda( s_pap )
{
    self endon( #"death_or_disconnect" );
    self endon( #"end_open_pap_menu" );
    s_pap_menu = function_870d519a9b809a9c( self.origin );
    var_ace96956a0e378c = s_pap get_pap_bundle().var_a366177ce1079a41;
    
    if ( var_ace96956a0e378c )
    {
        /#
            iprintlnbold( self.name + "<dev string:x26f>" + s_pap.name + "<dev string:x277>" );
        #/
        
        w_current = self getcurrentweapon();
        n_weapon_level = get_pap_level( w_current );
        var_7f4d06182d00c2f7 = get_supports_pap( w_current );
        n_mod_id = get_mod_id( w_current );
        s_menu_ref = s_pap_menu.ref;
        n_menu_id = s_pap_menu.id ?? -1;
        self setclientomnvar( "ui_pap_current_level", n_weapon_level );
        self setclientomnvar( "ui_current_weapon_supports_pap", var_7f4d06182d00c2f7 );
        self setclientomnvar( "ui_pap_current_ammomod", n_mod_id );
        self setclientomnvar( "ui_purchasemenu_id", n_menu_id );
        waitframe();
        
        if ( !level.pap_menu namespace_52f9490ffe6dceba::is_open( self ) )
        {
            level.pap_menu namespace_52f9490ffe6dceba::open( self );
            self playsoundtoplayer( #"hash_891339aef7b6d00", self );
            s_pap.var_370acb837a3a86c3.interact disableplayeruse( self );
            function_6770f49cdd28a5bb( 1 );
        }
        
        thread close_pap_menu( s_pap );
        thread purchasemenu::menu_close_notify( s_pap_menu, &on_menu_close );
        return;
    }
    
    currentweapon = self getcurrentweapon();
    n_weapon_level = get_pap_level( currentweapon );
    s_pap_menu = function_870d519a9b809a9c( self.origin );
    item = purchasemenu::create_item_struct( s_pap_menu.ref, n_weapon_level + 1 );
    
    if ( utility::issharedfuncdefined( #"pack_a_punch", #"hash_baf6f0ce286ac975" ) && n_weapon_level >= 1 )
    {
        utility::callsharedfunc( #"pack_a_punch", #"hash_baf6f0ce286ac975", currentweapon );
        return;
    }
    
    if ( !isdefined( item ) )
    {
        return;
    }
    
    if ( !self.var_64959b130d778640 || !arraycontains( self.var_64959b130d778640, currentweapon ) )
    {
        if ( !function_57721cf7bdb87284( n_weapon_level + 1 ) || self ismeleeing() )
        {
            self playsoundtoplayer( #"ui_zm_core_purchase_deny", self );
            return;
        }
    }
    
    if ( can_pap( currentweapon ) )
    {
        thread function_9bf445abb0dbf942( s_pap.var_370acb837a3a86c3.interact );
        pap_weapon_purchase( self.var_c51700b82e11cef3, n_weapon_level, currentweapon, item );
    }
}

// Namespace pack_a_punch
// Params 1, eflags: 0xc
// Checksum 0xde4267ad, Offset: 0x3571
// Size: 0x55
function private function_9bf445abb0dbf942( interact )
{
    self notify( #"hash_cbfbb44b73d1d46c" );
    self endon( #"hash_cbfbb44b73d1d46c" );
    self endon( #"disconnect" );
    self.var_73e2de392faa52c6 = 1;
    
    if ( level.var_d73c5ded92f4f4bd )
    {
        return;
    }
    
    wait 1;
    self.var_73e2de392faa52c6 = undefined;
}

// Namespace pack_a_punch
// Params 1
// Checksum 0x3d3f7a2a, Offset: 0x35ce
// Size: 0x1a
function on_menu_close( player )
{
    player.b_close_pap = 1;
}

// Namespace pack_a_punch
// Params 4
// Checksum 0x770f371, Offset: 0x35f0
// Size: 0x343
function pap_weapon_purchase( s_pap, n_current_weapon_lvl, currentweapon, item )
{
    s_pap_menu = function_870d519a9b809a9c( self.origin );
    var_9f9d02833d988898 = n_current_weapon_lvl + 1;
    
    if ( utility::issharedfuncdefined( #"pack_a_punch", #"pap_fx_override" ) )
    {
        s_pap utility::callsharedfunc( #"pack_a_punch", #"pap_fx_override", var_9f9d02833d988898 );
    }
    else
    {
        b_success = s_pap.var_370acb837a3a86c3 utility::function_7c10ea82c1e305b8( "base", "pap_activate_" + var_9f9d02833d988898 );
        
        if ( b_success )
        {
            s_pap thread function_308c980ec9aa44c5( "pap_activate_" + var_9f9d02833d988898 );
        }
        else
        {
            s_pap.var_370acb837a3a86c3 utility::function_7c10ea82c1e305b8( "base", "pap_activate" );
            s_pap thread function_308c980ec9aa44c5( "pap_activate" );
        }
    }
    
    if ( isdefined( level.var_7a6dcd660419a868 ) )
    {
        if ( ![[ level.var_7a6dcd660419a868 ]]( self ) )
        {
            self playsoundtoplayer( #"ui_zm_core_purchase_success", self );
        }
    }
    else
    {
        self playsoundtoplayer( #"ui_zm_core_purchase_success", self );
    }
    
    if ( utility::issharedfuncdefined( #"pack_a_punch", #"on_papped" ) )
    {
        utility::callsharedfunc( #"pack_a_punch", #"on_papped", currentweapon );
    }
    
    if ( var_9f9d02833d988898 == 2 && utility::issharedfuncdefined( #"pack_a_punch", #"on_pap_2" ) )
    {
        utility::callsharedfunc( #"pack_a_punch", #"on_pap_2", currentweapon );
    }
    
    cost = 0;
    currency = #"essence";
    
    if ( isdefined( item ) )
    {
        cost = item.cost;
        currency = item.currency;
    }
    
    if ( isdefined( level.get_pap_cost_override ) && isdefined( item.cost ) )
    {
        cost = [[ level.get_pap_cost_override ]]( item );
    }
    
    if ( isdefined( self.perks[ "specialty_exfil_pap_percent_reward" ] ) )
    {
        cost = int( cost * level.perkbundles[ "specialty_exfil_pap_percent_reward" ].var_9c085df7f7b6b417 );
    }
    
    if ( self.var_64959b130d778640 && arraycontains( self.var_64959b130d778640, currentweapon ) )
    {
        cost = 0;
    }
    
    rarity = namespace_9d8e359c3b1041e5::getplayerweaponraritysharedfunc( currentweapon );
    params = { #rarity:rarity, #model:s_pap.model, #currency:currency, #var_951c89546ec50477:n_current_weapon_lvl + 1, #cost:cost, #weapon:currentweapon };
    callback::callback( "on_pap_machine_purchase", params );
    
    if ( level.gametypebundle.var_2a42ba6a1a4e260d )
    {
        function_893799cfb3f4d2d7( currentweapon, n_current_weapon_lvl, cost, currency, s_pap );
        return;
    }
    
    pap_weapon( currentweapon, n_current_weapon_lvl, cost, undefined, currency );
    currency::attempt_purchase( currency, cost, 1, undefined, #"packapunch" );
    purchasemenu::function_93f934ea2f1c06f8( 1 );
    level notify( #"pap_machine_activated" );
}

// Namespace pack_a_punch
// Params 1
// Checksum 0xccf70418, Offset: 0x393b
// Size: 0x44
function function_308c980ec9aa44c5( var_5dd7cde84550a460 )
{
    self.var_370acb837a3a86c3 endon( #"death" );
    
    while ( self.var_370acb837a3a86c3 utility::function_9f2c41c1dcc8c94( "base", var_5dd7cde84550a460 ) )
    {
        waitframe();
    }
    
    thread function_d9ce48cca2ff225b();
}

// Namespace pack_a_punch
// Params 1
// Checksum 0xc4386724, Offset: 0x3987
// Size: 0xa1, Type: bool
function function_949fcb7c7623b4e9( camo_name )
{
    if ( isarray( level.var_2932bfd7dda0f235 ) )
    {
        foreach ( var_8daf34a5e590e184 in level.var_2932bfd7dda0f235 )
        {
            if ( var_8daf34a5e590e184.camo == camo_name )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace pack_a_punch
// Params 2
// Checksum 0x370ad875, Offset: 0x3a31
// Size: 0x142
function function_63b663ca62bdf70d( currentweapon, var_cc34afaf334d9b28 )
{
    if ( isplayer( self ) && !self function_13c842a7e0d8ff64() )
    {
        return getweaponcamoname( currentweapon );
    }
    
    var_8daf34a5e590e184 = undefined;
    base_weapon_name = currentweapon.basename;
    pap_camo_index = var_cc34afaf334d9b28 - 1;
    
    if ( isarray( level.var_ad35b2865cace986 ) && arraycontains( level.var_ad35b2865cace986, base_weapon_name ) )
    {
        var_8daf34a5e590e184 = undefined;
    }
    else if ( isarray( level.var_2932bfd7dda0f235 ) && isdefined( level.var_2932bfd7dda0f235[ pap_camo_index ] ) && pap_camo_index < level.var_2932bfd7dda0f235.size )
    {
        var_8daf34a5e590e184 = level.var_2932bfd7dda0f235[ pap_camo_index ].camo;
    }
    
    if ( isplayer( self ) && pap_camo_index >= 0 && pap_camo_index < 3 )
    {
        var_61a84ccddca5f129 = self getplayerdata( level.loadoutsgroup, "papCamos", pap_camo_index );
    }
    
    var_9f8790959d9c19da = common_item::function_105527001e21028d( var_61a84ccddca5f129 );
    var_8daf34a5e590e184 = var_9f8790959d9c19da ?? var_8daf34a5e590e184;
    
    if ( !isdefined( var_8daf34a5e590e184 ) || self.b_disable_pap_camo )
    {
        return getweaponcamoname( currentweapon );
    }
    
    return var_8daf34a5e590e184;
}

// Namespace pack_a_punch
// Params 1
// Checksum 0x82b66f8b, Offset: 0x3b7c
// Size: 0x1d
function function_e28510c62be79452( params )
{
    ui::lui_registercallback( "pap_camo_toggled_notify", &function_3d7a13f74ad07c52 );
}

// Namespace pack_a_punch
// Params 1
// Checksum 0x2772f345, Offset: 0x3ba1
// Size: 0x1c8
function function_3d7a13f74ad07c52( enabled )
{
    self endon( #"death_or_disconnect" );
    waittillframeend();
    
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( self function_13c842a7e0d8ff64() )
    {
        weaponslist = self getweaponslistall();
        
        for ( idx = 0; idx < weaponslist.size ; idx++ )
        {
            current_weapon = weaponslist[ idx ];
            var_578502a4a747467a = current_weapon === self.var_cc1262e66dbb1c79;
            var_3248d20086ef13a0 = self.last_weapon;
            var_619aa3791b99968c = self getcurrentweapon();
            var_f10156963415c69 = inventory_utility::iscurrentweapon( current_weapon );
            n_current_weapon_lvl = get_pap_level( current_weapon );
            camo = function_63b663ca62bdf70d( current_weapon, n_current_weapon_lvl );
            
            if ( isdefined( camo ) && ( can_pap( current_weapon ) || n_current_weapon_lvl >= 3 ) && n_current_weapon_lvl != 0 )
            {
                function_f433964dfd4900bf( current_weapon, n_current_weapon_lvl, var_578502a4a747467a, var_f10156963415c69, camo );
            }
        }
        
        return;
    }
    
    weaponslist = self getweaponslistall();
    
    for ( idx = 0; idx < weaponslist.size ; idx++ )
    {
        current_weapon = weaponslist[ idx ];
        var_578502a4a747467a = current_weapon === self.var_cc1262e66dbb1c79;
        var_3248d20086ef13a0 = self.last_weapon;
        var_619aa3791b99968c = self getcurrentweapon();
        var_f10156963415c69 = inventory_utility::iscurrentweapon( current_weapon );
        
        if ( isdefined( self.var_60c2ab39157e81d2 ) )
        {
            original_weapon_camo = self.var_60c2ab39157e81d2[ current_weapon.var_1616e6fbba9a722d ];
            n_current_weapon_lvl = get_pap_level( current_weapon );
            
            if ( n_current_weapon_lvl != 0 )
            {
                if ( can_pap( current_weapon ) || n_current_weapon_lvl >= 3 )
                {
                    if ( isdefined( original_weapon_camo ) )
                    {
                        function_f433964dfd4900bf( current_weapon, n_current_weapon_lvl, var_578502a4a747467a, var_f10156963415c69, original_weapon_camo );
                        continue;
                    }
                    
                    function_f433964dfd4900bf( current_weapon, n_current_weapon_lvl, var_578502a4a747467a, var_f10156963415c69, "camo_none" );
                }
            }
        }
    }
}

// Namespace pack_a_punch
// Params 5
// Checksum 0xa45cd603, Offset: 0x3d71
// Size: 0x196
function function_f433964dfd4900bf( current_weapon, n_current_weapon_lvl, var_578502a4a747467a, var_f10156963415c69, camo )
{
    copy_weapon = current_weapon getnoaltweapon();
    w_take_ammo_mod = utility::callsharedfunc( #"ammo_mod", #"hash_cf1012c4d313de70", copy_weapon );
    new_weapon = function_e190a315803e2870( copy_weapon, n_current_weapon_lvl, w_take_ammo_mod, camo );
    alt_weapon = undefined;
    
    if ( self isalternatemode( current_weapon ) )
    {
        alt_weapon = new_weapon getaltweapon();
    }
    
    current_clip_alt = 0;
    
    if ( weapon::isakimbo( current_weapon ) )
    {
        current_clip_alt = self getweaponammoclip( current_weapon, "left" );
    }
    
    var_8d3454d1b5219ce = self getweaponammoclip( current_weapon );
    current_ammo = self getweaponammostock( current_weapon );
    self takeweapon( current_weapon );
    
    if ( isdefined( alt_weapon ) )
    {
        self giveweapon( alt_weapon );
    }
    else
    {
        self giveweapon( new_weapon );
    }
    
    if ( var_578502a4a747467a )
    {
        weapon::function_b4c9549dee5d0fc5( new_weapon );
    }
    
    if ( var_f10156963415c69 )
    {
        if ( isdefined( alt_weapon ) )
        {
            self switchtoweaponimmediate( alt_weapon );
        }
        else
        {
            self switchtoweaponimmediate( new_weapon );
        }
    }
    
    self setweaponammoclip( new_weapon, var_8d3454d1b5219ce );
    self setweaponammostock( new_weapon, current_ammo );
    
    if ( weapon::isakimbo( new_weapon ) )
    {
        self setweaponammoclip( new_weapon, current_clip_alt, "left" );
    }
    
    function_3f3b9cdbb4843e45( new_weapon, n_current_weapon_lvl, 1, copy_weapon );
    callback::callback( #"hash_eee96f780807d870", { #objweapon:new_weapon, #var_39044599845b54cf:current_weapon, #player:self } );
}

// Namespace pack_a_punch
// Params 0
// Checksum 0xeed5d8ef, Offset: 0x3f0f
// Size: 0x27f
function function_6aaacfe23a7627fa()
{
    if ( !isdefined( self.var_370acb837a3a86c3 ) )
    {
        return;
    }
    
    self endon( #"disable_pap" );
    self.var_370acb837a3a86c3 endon( #"death" );
    
    if ( self.var_370acb837a3a86c3.var_e9bf98a002472909 && self.var_370acb837a3a86c3.var_e9bf98a002472909 >= level.framedurationseconds )
    {
        wait self.var_370acb837a3a86c3.var_e9bf98a002472909;
    }
    
    var_21b48bdc25c831c1 = 56;
    var_e7d3b195989ad581 = self.var_370acb837a3a86c3.var_e7d3b195989ad581 ?? var_21b48bdc25c831c1;
    
    while ( true )
    {
        throttle::throttle_wait_in_queue( level.throttle_pap_disable_camo, self );
        a_players = getplayersinradius( self.var_370acb837a3a86c3.origin, var_e7d3b195989ad581 );
        
        if ( a_players.size == 0 )
        {
            throttle::throttle_wait_in_queue( level.throttle_pap_disable_camo, self );
            continue;
        }
        
        var_606925a1c0d8ce7e = 0;
        
        foreach ( player in a_players )
        {
            if ( ( player ismeleeing() || player.var_23c08b8d00196b63 ) && !player.var_2bbc37a986db6306 && utility::within_fov( player.origin, player.angles, self.var_370acb837a3a86c3.origin, cos( 70 ) ) )
            {
                player thread pap_melee_cooldown();
                
                if ( player.b_disable_pap_camo )
                {
                    player.b_disable_pap_camo = undefined;
                    
                    /#
                        iprintlnbold( "<dev string:x284>" + player.name );
                    #/
                }
                else
                {
                    player.b_disable_pap_camo = 1;
                    
                    /#
                        iprintlnbold( "<dev string:x2a9>" + player.name );
                    #/
                }
                
                var_606925a1c0d8ce7e = 1;
            }
        }
        
        if ( var_606925a1c0d8ce7e )
        {
            self.var_370acb837a3a86c3 utility::function_7c10ea82c1e305b8( "base", "pap_static" );
            wait 0.5;
            self.var_370acb837a3a86c3 utility::function_7c10ea82c1e305b8( "base", "pap_activate" );
        }
    }
}

// Namespace pack_a_punch
// Params 0
// Checksum 0xfa29eb34, Offset: 0x4196
// Size: 0x26
function pap_melee_cooldown()
{
    self endon( #"disconnect" );
    self.var_2bbc37a986db6306 = 1;
    wait 3;
    self.var_2bbc37a986db6306 = undefined;
}

// Namespace pack_a_punch
// Params 8
// Checksum 0x65c0bd83, Offset: 0x41c4
// Size: 0x3ad
function pap_weapon( currentweapon, n_current_weapon_lvl, cost, var_2809c6a34787ebe0, currency, b_switch_to_weapon = 1, var_87f37c51560a803f = 0, var_d47837dc0e073e58 )
{
    var_482e9999b75ed3d8 = istrue( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_z_mod", #"z_mod_pack_mule" ) );
    var_579b0337ef215f84 = var_d47837dc0e073e58 ?? n_current_weapon_lvl + 1;
    var_578502a4a747467a = currentweapon === self.var_cc1262e66dbb1c79;
    var_39044599845b54cf = currentweapon getnoaltweapon();
    w_take_ammo_mod = utility::callsharedfunc( #"ammo_mod", #"hash_cf1012c4d313de70", var_39044599845b54cf );
    var_101633ed971732ba = function_e190a315803e2870( var_39044599845b54cf, var_579b0337ef215f84, w_take_ammo_mod );
    w_new_alt = undefined;
    
    if ( var_39044599845b54cf != currentweapon )
    {
        w_new_alt = var_101633ed971732ba getaltweapon();
    }
    
    if ( n_current_weapon_lvl == 0 || var_2809c6a34787ebe0 )
    {
        if ( !isdefined( self.var_60c2ab39157e81d2 ) )
        {
            self.var_60c2ab39157e81d2 = [];
        }
        
        self.var_60c2ab39157e81d2[ var_101633ed971732ba.var_1616e6fbba9a722d ] = var_39044599845b54cf.camo;
    }
    
    level notify( #"hash_b2701c15341273e2", self, var_579b0337ef215f84, var_101633ed971732ba );
    var_d702d6a51a192000 = 0;
    
    if ( getdvarint( @"hash_c4ccc540649a56f0", 0 ) && var_39044599845b54cf.hasalternate )
    {
        var_70cd9fbc24f5fe43 = var_39044599845b54cf getaltweapon();
        var_d702d6a51a192000 = self getweaponammoclip( var_70cd9fbc24f5fe43 );
    }
    
    params = spawnstruct();
    params.var_101633ed971732ba = var_101633ed971732ba;
    params.var_39044599845b54cf = var_39044599845b54cf;
    params.w_new_alt = w_new_alt;
    params.var_951c89546ec50477 = n_current_weapon_lvl + 1;
    params.cost = cost;
    params.currency = currency;
    params.player = self;
    
    if ( !var_87f37c51560a803f )
    {
        callback::callback( "zm_packed_weapon_non_augment", params );
    }
    
    callback::callback( "zm_packed_weapon", params );
    self takeweapon( var_39044599845b54cf );
    self giveweapon( var_101633ed971732ba );
    item_weapon::function_f9f12ddfa1766b72();
    
    if ( b_switch_to_weapon )
    {
        self switchtoweapon( w_new_alt ?? var_101633ed971732ba );
    }
    
    max_stock_ammo = utility::get_max_stock_ammo( var_101633ed971732ba, var_482e9999b75ed3d8 );
    self setweaponammostock( var_101633ed971732ba, max_stock_ammo );
    
    if ( var_101633ed971732ba.hasalternate && !item_weapon::function_dc8d4a742844a795( var_101633ed971732ba ) )
    {
        var_5c8932c2b1aa9ca4 = 1;
        var_b6f3bc7f628fdf40 = var_101633ed971732ba getaltweapon();
        
        if ( getdvarint( @"hash_c4ccc540649a56f0", 0 ) )
        {
            if ( var_b6f3bc7f628fdf40.underbarrel == "jup_ub_flame_01" )
            {
                if ( var_b6f3bc7f628fdf40.underbarrel == "jup_ub_flame_01" )
                {
                    self setweaponammoclip( var_b6f3bc7f628fdf40, var_d702d6a51a192000 );
                    var_5c8932c2b1aa9ca4 = 0;
                }
            }
        }
        
        if ( var_5c8932c2b1aa9ca4 )
        {
            max_stock_ammo = utility::get_max_stock_ammo( var_b6f3bc7f628fdf40, var_482e9999b75ed3d8 );
            self setweaponammostock( var_b6f3bc7f628fdf40, max_stock_ammo );
            var_83e55048826dcd05 = self getweaponammoclip( var_b6f3bc7f628fdf40 );
            var_b11feea92c35d08e = weaponclipsize( var_b6f3bc7f628fdf40 );
            
            if ( var_83e55048826dcd05 < var_b11feea92c35d08e )
            {
                self setweaponammoclip( var_b6f3bc7f628fdf40, var_b11feea92c35d08e );
            }
        }
    }
    else
    {
        var_83e55048826dcd05 = self getweaponammoclip( var_101633ed971732ba );
        var_b11feea92c35d08e = weaponclipsize( var_101633ed971732ba );
        
        if ( var_83e55048826dcd05 < var_b11feea92c35d08e )
        {
            self setweaponammoclip( var_101633ed971732ba, var_b11feea92c35d08e );
        }
    }
    
    function_3f3b9cdbb4843e45( var_101633ed971732ba, var_579b0337ef215f84, 1, var_39044599845b54cf );
    self notify( #"weapon_level_changed" );
    self setclientomnvar( "ui_pap_current_level", var_579b0337ef215f84 );
    
    if ( var_578502a4a747467a )
    {
        weapon::function_b4c9549dee5d0fc5( var_101633ed971732ba );
    }
    
    return var_101633ed971732ba;
}

// Namespace pack_a_punch
// Params 4
// Checksum 0xac779456, Offset: 0x457a
// Size: 0x207
function function_e190a315803e2870( currentweapon, n_current_weapon_lvl, var_71723ddad1d54416, default_camo = undefined )
{
    camo = function_63b663ca62bdf70d( currentweapon, n_current_weapon_lvl );
    
    if ( isdefined( default_camo ) )
    {
        camo = default_camo;
    }
    
    reticle = function_4af0b444e167186d( currentweapon );
    
    if ( isstring( reticle ) && issubstr( reticle, "scope" ) )
    {
        reticle = int( removesubstr( reticle, "scope" ) );
        
        if ( reticle == 0 )
        {
            reticle = undefined;
        }
    }
    else
    {
        reticle = undefined;
    }
    
    variantid = getweaponvariantindex( currentweapon );
    
    if ( isdefined( currentweapon.charmscriptbundle ) )
    {
        cosmeticattachment = loot::function_f54ecb89dfab8e8c( loot::getlootidfromref( currentweapon.charmscriptbundle.charmref ) );
    }
    else
    {
        cosmeticattachment = "charm_none";
    }
    
    reticle = function_4af0b444e167186d( currentweapon, 1 );
    stickers = [ currentweapon.stickerslot0, currentweapon.stickerslot1, currentweapon.stickerslot2, currentweapon.stickerslot3, currentweapon.var_73762c7cb8b2063 ?? "sticker_none" ];
    currentattachments = currentweapon.attachments;
    var_dc2a0fdff22e6e99 = currentweapon.attachmentvarindices;
    [ newattachments, var_2dc06c159ce14538 ] = add_pap_attachments( currentweapon, currentattachments, var_dc2a0fdff22e6e99, n_current_weapon_lvl );
    var_f581dedba4f25efb = weapon::function_2374da6f1b4fad4e( currentweapon.basename, variantid );
    var_101633ed971732ba = weapon::buildweapon( currentweapon.basename, newattachments, camo, reticle, variantid, var_2dc06c159ce14538, cosmeticattachment, stickers, undefined, undefined, undefined, var_f581dedba4f25efb );
    
    if ( var_71723ddad1d54416 )
    {
        ammo_mod::add_ammo_mod_to_weapon( var_101633ed971732ba, var_71723ddad1d54416 );
    }
    
    return var_101633ed971732ba;
}

// Namespace pack_a_punch
// Params 4
// Checksum 0xa3e33a76, Offset: 0x478a
// Size: 0x48a
function add_pap_attachments( weapon, attachments, var_f1614eef81f0bdd2, var_616cad0c6eb8a263 )
{
    var_2e08e94c9cb1747c = weapon.var_1616e6fbba9a722d;
    
    if ( isdefined( level.weaponmetadata[ var_2e08e94c9cb1747c ] ) )
    {
        var_e491cc4ce8526125 = level.weaponmetadata[ var_2e08e94c9cb1747c ].var_6c2dc03affad7ce0;
        var_e9ca9da4b737395 = level.weaponmetadata[ var_2e08e94c9cb1747c ].var_6ec5e9b28d8ba1f4;
        var_8416de761caf3df = level.weaponmetadata[ var_2e08e94c9cb1747c ].var_c5e9a849426045ca;
        var_730c764888e73db3 = level.weaponmetadata[ var_2e08e94c9cb1747c ].var_a0f67da9669fe547;
        
        if ( var_730c764888e73db3 )
        {
            var_741c85c94fd2396d = 0;
            var_50c3eef1c08e5bc1 = 0;
            
            foreach ( override in var_730c764888e73db3 )
            {
                if ( var_741c85c94fd2396d && var_50c3eef1c08e5bc1 )
                {
                    break;
                }
                
                if ( override.var_26bf283b8c9a61c2 )
                {
                    var_8ccd06ae5f32a211 = 0;
                    
                    if ( weapon hasattachment( override.var_26bf283b8c9a61c2 ) )
                    {
                        var_8ccd06ae5f32a211 = 1;
                    }
                    
                    if ( isdefined( weapon.attachmentblueprints ) )
                    {
                        foreach ( s_attachment in weapon.attachmentblueprints )
                        {
                            if ( s_attachment.attachmentdata == override.var_26bf283b8c9a61c2 )
                            {
                                var_8ccd06ae5f32a211 = 1;
                                break;
                            }
                        }
                    }
                    
                    if ( var_8ccd06ae5f32a211 )
                    {
                        if ( !var_741c85c94fd2396d && override.var_8187f1380726e98f )
                        {
                            var_741c85c94fd2396d = 1;
                            var_e9ca9da4b737395 = override.var_8187f1380726e98f;
                        }
                        
                        if ( !var_50c3eef1c08e5bc1 && override.var_d89ee8f086c17999 )
                        {
                            var_50c3eef1c08e5bc1 = 1;
                            var_8416de761caf3df = override.var_d89ee8f086c17999;
                        }
                    }
                }
            }
        }
        
        assert( isdefined( var_e491cc4ce8526125 ), "<dev string:x2cf>" + getxhashsourcename( var_2e08e94c9cb1747c ) );
        newattachments = [];
        var_2dc06c159ce14538 = [];
        
        if ( isdefined( var_e9ca9da4b737395 ) && !arraycontains( attachments, var_e9ca9da4b737395 ) && weapon canuseattachment( var_e9ca9da4b737395 ) )
        {
            attachments = arrayremove( attachments, var_e491cc4ce8526125 );
            attachments[ attachments.size ] = var_e9ca9da4b737395;
            var_f1614eef81f0bdd2[ var_e491cc4ce8526125 ] = undefined;
            var_f1614eef81f0bdd2[ var_e9ca9da4b737395 ] = 0;
        }
        
        if ( var_616cad0c6eb8a263 > 1 && isdefined( var_e9ca9da4b737395 ) )
        {
            var_20528574c46057c6 = var_e9ca9da4b737395 + var_616cad0c6eb8a263;
            
            if ( var_616cad0c6eb8a263 > 3 && var_20528574c46057c6 != var_8416de761caf3df )
            {
                var_20528574c46057c6 = var_8416de761caf3df;
            }
            
            if ( weapon canuseattachment( var_20528574c46057c6 ) )
            {
                attachments = arrayremove( attachments, var_e9ca9da4b737395 );
                attachments = arrayremove( attachments, var_e9ca9da4b737395 + var_616cad0c6eb8a263 - 1 );
                var_f1614eef81f0bdd2[ var_e9ca9da4b737395 ] = undefined;
                var_f1614eef81f0bdd2[ var_e9ca9da4b737395 + var_616cad0c6eb8a263 - 1 ] = undefined;
                var_f1614eef81f0bdd2[ var_20528574c46057c6 ] = 0;
                
                if ( !arraycontains( attachments, var_20528574c46057c6 ) )
                {
                    attachments[ attachments.size ] = var_20528574c46057c6;
                }
            }
        }
        
        assert( attachments.size == var_f1614eef81f0bdd2.size, "<dev string:x326>" + getxhashsourcename( var_2e08e94c9cb1747c ) + "<dev string:x339>" );
        
        foreach ( attachment in attachments )
        {
            newattachments[ newattachments.size ] = attachment;
            
            if ( isnumber( var_f1614eef81f0bdd2[ attachment ] ) )
            {
                var_2dc06c159ce14538[ attachment ] = var_f1614eef81f0bdd2[ attachment ];
                continue;
            }
            
            var_2dc06c159ce14538[ attachment ] = 0;
        }
    }
    
    if ( !isdefined( newattachments ) )
    {
        newattachments = attachments;
    }
    
    if ( !isdefined( var_2dc06c159ce14538 ) )
    {
        var_2dc06c159ce14538 = var_f1614eef81f0bdd2;
    }
    
    params = { #var_616cad0c6eb8a263:var_616cad0c6eb8a263, #var_f1614eef81f0bdd2:var_2dc06c159ce14538, #attachments:newattachments, #weapon:weapon };
    callback::callback( "on_add_pap_attachments", params );
    return [ params.attachments, params.var_f1614eef81f0bdd2 ];
}

// Namespace pack_a_punch
// Params 1
// Checksum 0x6e29ce0d, Offset: 0x4c1d
// Size: 0x30d
function unpap_weapon( weapon )
{
    new_weapon = undefined;
    
    if ( isdefined( weapon.var_1616e6fbba9a722d ) && isdefined( level.weaponmetadata[ weapon.var_1616e6fbba9a722d ] ) && isdefined( level.weaponmetadata[ weapon.var_1616e6fbba9a722d ].var_6ec5e9b28d8ba1f4 ) )
    {
        var_4b45a744ceea6ed = level.weaponmetadata[ weapon.var_1616e6fbba9a722d ].var_6ec5e9b28d8ba1f4;
        
        if ( weapon hasattachment( var_4b45a744ceea6ed ) )
        {
            new_weapon = weapon withoutattachment( var_4b45a744ceea6ed );
        }
        
        if ( new_weapon )
        {
            var_730c764888e73db3 = level.weaponmetadata[ weapon.var_1616e6fbba9a722d ].var_a0f67da9669fe547;
            
            foreach ( override in var_730c764888e73db3 )
            {
                if ( new_weapon hasattachment( override.var_8187f1380726e98f ) )
                {
                    new_weapon = new_weapon withoutattachment( override.var_8187f1380726e98f );
                }
                
                if ( new_weapon hasattachment( override.var_d89ee8f086c17999 ) )
                {
                    new_weapon = new_weapon withoutattachment( override.var_d89ee8f086c17999 );
                }
            }
        }
    }
    
    if ( isdefined( level.var_2932bfd7dda0f235 ) && isdefined( weapon.camo ) && weapon.camo != "none" )
    {
        foreach ( var_2c4803e5652396e3 in level.var_2932bfd7dda0f235 )
        {
            if ( weapon.camo == var_2c4803e5652396e3.camo )
            {
                if ( isdefined( new_weapon ) )
                {
                    new_weapon = new_weapon function_9c6bf5d30861db6();
                }
                else
                {
                    new_weapon = weapon function_9c6bf5d30861db6();
                }
                
                break;
            }
        }
    }
    
    if ( isdefined( self.var_60c2ab39157e81d2 ) )
    {
        original_weapon_camo = self.var_60c2ab39157e81d2[ weapon.var_1616e6fbba9a722d ];
        
        if ( isdefined( original_weapon_camo ) )
        {
            if ( isdefined( new_weapon ) )
            {
                new_weapon = new_weapon withcamo( original_weapon_camo );
            }
            else
            {
                new_weapon = weapon withcamo( original_weapon_camo );
            }
            
            self.var_60c2ab39157e81d2[ weapon.var_1616e6fbba9a722d ] = undefined;
        }
    }
    
    if ( isdefined( new_weapon ) )
    {
        self takeweapon( weapon );
        self giveweapon( new_weapon );
        self switchtoweapon( new_weapon );
        function_3f3b9cdbb4843e45( new_weapon, undefined );
        self notify( #"weapon_level_changed" );
        self setclientomnvar( "ui_pap_current_level", 0 );
        self setclientomnvar( "ui_current_weapon_supports_pap", get_supports_pap( new_weapon ) );
    }
}

// Namespace pack_a_punch
// Params 1
// Checksum 0xc8a6009d, Offset: 0x4f32
// Size: 0x5b, Type: bool
function can_pap( weapon = self getcurrentweapon() )
{
    if ( !isdefined( level.var_b6377f00348c4d99[ weapon.var_1616e6fbba9a722d ] ) )
    {
        return false;
    }
    
    n_weapon_level = get_pap_level( weapon );
    
    if ( n_weapon_level < level.var_eda995bb839c4aa )
    {
        return true;
    }
    
    return false;
}

// Namespace pack_a_punch
// Params 1
// Checksum 0x55570146, Offset: 0x4f96
// Size: 0xeb
function function_57721cf7bdb87284( var_1923b2b3afc076ba )
{
    s_pap_menu = function_870d519a9b809a9c( self.origin );
    item = purchasemenu::create_item_struct( s_pap_menu.ref, var_1923b2b3afc076ba );
    cost = 0;
    currency = #"essence";
    
    if ( isdefined( item ) )
    {
        cost = item.cost;
        currency = item.currency;
        
        if ( isdefined( self.perks[ "specialty_exfil_pap_percent_reward" ] ) )
        {
            cost = int( cost * level.perkbundles[ "specialty_exfil_pap_percent_reward" ].var_9c085df7f7b6b417 );
        }
        
        if ( isdefined( level.get_pap_cost_override ) && isdefined( item.cost ) )
        {
            cost = [[ level.get_pap_cost_override ]]( item );
        }
    }
    
    return currency::can_afford( currency, cost );
}

// Namespace pack_a_punch
// Params 1
// Checksum 0xd634a558, Offset: 0x508a
// Size: 0x1f9
function close_pap_menu( s_pap )
{
    self notify( #"opened_pap_menu" );
    self endon( #"opened_pap_menu" );
    self endon( #"disconnect" );
    s_pap_menu = function_870d519a9b809a9c( self.origin );
    var_75385495715741fb = s_pap.var_370acb837a3a86c3;
    wait 0.75;
    n_start_distance = distance2d( var_75385495715741fb.origin, self.origin );
    v_start = self.origin;
    var_601acba772a0ea36 = utility::function_7c45b71b8e0d3cff();
    s_machine_moving_platform = var_75385495715741fb utility::function_7c45b71b8e0d3cff();
    var_9afcd039f263a45e = isdefined( var_601acba772a0ea36 ) && isdefined( s_machine_moving_platform );
    
    if ( var_9afcd039f263a45e )
    {
        n_start_distance += 5;
    }
    
    while ( isdefined( var_75385495715741fb ) && isalive( self ) && !self.inlaststand && !weapon::iskillstreakweapon( self getcurrentweapon() ) )
    {
        if ( !isdefined( var_75385495715741fb ) || self stancebuttonpressed() || level.b_zm_game_over )
        {
            break;
        }
        
        if ( !( distance2d( var_75385495715741fb.origin, self.origin ) <= n_start_distance || distance2d( self.origin, var_75385495715741fb.origin ) < 64 ) )
        {
            break;
        }
        
        if ( self.b_close_pap )
        {
            break;
        }
        
        waitframe();
    }
    
    if ( isdefined( self ) )
    {
        self.b_close_pap = undefined;
        purchasemenu::function_93f934ea2f1c06f8( 2 );
        level.pap_menu namespace_52f9490ffe6dceba::close( self );
        self setclientomnvar( "ui_purchasemenu_id", 0 );
        function_6770f49cdd28a5bb( 0 );
        s_pap.var_370acb837a3a86c3.interact enableplayeruse( self );
        self.var_c51700b82e11cef3 = undefined;
        self notify( #"end_open_pap_menu" );
        self notify( s_pap_menu.var_8a64e37068076a47 );
    }
}

// Namespace pack_a_punch
// Params 1, eflags: 0x4
// Checksum 0xfe8f3f6, Offset: 0x528b
// Size: 0xb0
function private function_6770f49cdd28a5bb( var_e4b5e1d1b9b19c57 )
{
    if ( var_e4b5e1d1b9b19c57 )
    {
        val::set( "using_pap", "melee", 0 );
        val::set( "using_pap", "killstreaks", 0 );
        val::set( "using_pap", "crate_use", 0 );
        val::set( "using_pap", "equipment_primary", 0 );
        val::set( "using_pap", "equipment_secondary", 0 );
        val::set( "using_pap", "offhand_weapons", 0 );
        val::set( "using_pap", "offhand_throwback", 0 );
        val::set( "using_pap", "weapon_switch", 0 );
        return;
    }
    
    val::reset_all( "using_pap" );
}

// Namespace pack_a_punch
// Params 1
// Checksum 0x11b815ab, Offset: 0x5343
// Size: 0x33
function set_pap_use_override( use_override_func )
{
    assert( isfunction( use_override_func ), "<dev string:x399>" );
    
    if ( isfunction( use_override_func ) )
    {
        self.use_override = use_override_func;
    }
}

// Namespace pack_a_punch
// Params 1
// Checksum 0x9032b177, Offset: 0x537e
// Size: 0x33
function function_c00f9f14d26781c5( hint_override_func )
{
    assert( isfunction( hint_override_func ), "<dev string:x3d6>" );
    
    if ( isfunction( hint_override_func ) )
    {
        self.hint_override = hint_override_func;
    }
}

// Namespace pack_a_punch
// Params 0
// Checksum 0x372ebb17, Offset: 0x53b9
// Size: 0xc
function function_c8997f1d47129d5e()
{
    self.use_override = undefined;
}

// Namespace pack_a_punch
// Params 0
// Checksum 0x3697f5af, Offset: 0x53cd
// Size: 0xc
function function_3da6eb222b1048c0()
{
    self.hint_override = undefined;
}

// Namespace pack_a_punch
// Params 1, eflags: 0x4
// Checksum 0xf5fc26b, Offset: 0x53e1
// Size: 0x228
function private function_69508e4a920d4a18( currentweapon )
{
    if ( currentweapon.basename == "sat_me_nashira_mp" )
    {
        return ( 15, 0, 0 );
    }
    else if ( currentweapon.basename == "sat_me_elnath_mp" )
    {
        return ( 0, -15, 0 );
    }
    else if ( currentweapon.basename == "sat_ww_locust_zm" )
    {
        return ( 0, -7, 3 );
    }
    else if ( currentweapon.basename == "sat_ww_mantis_zm" )
    {
        return ( 0, 3, 0 );
    }
    else if ( currentweapon.basename == "sat_ww_hornet_zm" )
    {
        return ( 4, 2, -2 );
    }
    else if ( currentweapon.basename == "sat_ww_ruby_zm" )
    {
        return ( 0, 5, 0 );
    }
    else if ( currentweapon.basename == "sat_sh_akita_mp" )
    {
        return ( 0, -7, 6 );
    }
    else if ( issubstr( currentweapon.basename, "sat_sh" ) )
    {
        return ( 0, 1, 3 );
    }
    else if ( issubstr( currentweapon.basename, "sat_sn" ) )
    {
        return ( 0, 2, 2 );
    }
    else if ( issubstr( currentweapon.basename, "sat_sm" ) )
    {
        return ( 0, -4, 5 );
    }
    else if ( issubstr( currentweapon.basename, "sat_lm" ) )
    {
        return ( 0, 2, 2 );
    }
    else if ( issubstr( currentweapon.basename, "sat_dm" ) )
    {
        return ( 0, 4, 2 );
    }
    else if ( issubstr( currentweapon.basename, "sat_la" ) )
    {
        return ( 2, -1, 2 );
    }
    else if ( currentweapon.ismelee )
    {
        return ( 0, 0, 0 );
    }
    
    return ( 0, -7, 2 );
}

// Namespace pack_a_punch
// Params 6
// Checksum 0x41bfc8ef, Offset: 0x5612
// Size: 0xb3d
function function_893799cfb3f4d2d7( currentweapon, n_current_weapon_lvl, cost, currency, s_pap, roll_ammomod )
{
    self.is_crafting = 0;
    map_name = game_utility::getmapname();
    
    if ( map_name && issubstr( map_name, "scarab" ) && s_pap.classname != "script_vehicle" && s_pap.name != "br_pap" )
    {
        var_feda55b52a08695d = 1;
        spawn_origin = s_pap.var_370acb837a3a86c3.origin + ( 0, 0, 30 );
        
        if ( currentweapon.ismelee )
        {
            var_d8248accea207499 = ( -90, 0, 0 );
        }
        else
        {
            var_d8248accea207499 = ( 0, 0, 0 );
        }
        
        spawn_angles = s_pap.var_370acb837a3a86c3.angles + var_d8248accea207499;
        stored_origin = s_pap.var_370acb837a3a86c3.origin + ( 0, 0, 30 );
    }
    else if ( map_name && issubstr( map_name, "firefly" ) || s_pap.classname == "script_vehicle" )
    {
        n_firefly_pap = 1;
        v_pivot = function_69508e4a920d4a18( currentweapon );
        forward_offset = -140 + v_pivot[ 0 ];
        var_6a892f8fbe7f8267 = 0 + v_pivot[ 1 ];
        up_offset = 30 + v_pivot[ 2 ];
        
        if ( currentweapon.ismelee )
        {
            var_d8248accea207499 = ( -90, -90, 0 );
        }
        else
        {
            var_d8248accea207499 = ( 0, -90, 0 );
        }
        
        spawn_origin = s_pap.var_370acb837a3a86c3.origin + anglestoforward( s_pap.var_370acb837a3a86c3.angles ) * forward_offset + anglestoup( s_pap.var_370acb837a3a86c3.angles ) * up_offset + anglestoleft( s_pap.var_370acb837a3a86c3.angles ) * var_6a892f8fbe7f8267;
        spawn_angles = s_pap.var_370acb837a3a86c3.angles + var_d8248accea207499;
    }
    else
    {
        v_pivot = function_69508e4a920d4a18( currentweapon );
        forward_offset = 25 + v_pivot[ 0 ];
        var_6a892f8fbe7f8267 = 0 + v_pivot[ 1 ];
        up_offset = 35 + v_pivot[ 2 ];
        
        if ( currentweapon.basename == "sat_ww_locust_zm" )
        {
            var_d8248accea207499 = ( -90, 0, 90 );
        }
        else if ( currentweapon.basename == "sat_ww_hornet_zm" )
        {
            var_d8248accea207499 = ( 0, 90, 0 );
        }
        else if ( currentweapon.ismelee )
        {
            var_d8248accea207499 = ( -90, -90, 0 );
        }
        else
        {
            var_d8248accea207499 = ( 0, -90, 0 );
        }
        
        spawn_origin = s_pap.var_370acb837a3a86c3.origin + anglestoforward( s_pap.var_370acb837a3a86c3.angles ) * forward_offset + anglestoup( s_pap.var_370acb837a3a86c3.angles ) * up_offset + anglestoleft( s_pap.var_370acb837a3a86c3.angles ) * var_6a892f8fbe7f8267;
        spawn_angles = s_pap.var_370acb837a3a86c3.angles + var_d8248accea207499;
        stored_origin = s_pap.var_370acb837a3a86c3.origin + anglestoup( s_pap.var_370acb837a3a86c3.angles ) * up_offset;
    }
    
    spawnoptions = common_item::function_bc5ff2958b71a708( spawn_origin, spawn_angles );
    spawnoptions.spawnpositionindex = 1;
    spawnoptions.weapon = currentweapon;
    spawnoptions.cleanupdisabled = 1;
    spawnoptions.var_8d4f327170228364 = 1;
    currency::attempt_purchase( currency, cost, 1, undefined, #"packapunch" );
    var_5ea3ce34914078d1 = function_6fc306d1b8b4d844( currentweapon );
    var_8a61d4195b4b6e64 = item_weapon::function_53da2af5697709f8( currentweapon, var_5ea3ce34914078d1, spawnoptions );
    var_8a61d4195b4b6e64 setscriptablepartstate( "obloot_custom_weapon", "custom_pap_visible" );
    
    foreach ( player in level.players )
    {
        var_8a61d4195b4b6e64 disablescriptableplayeruse( player );
        
        if ( s_pap.var_370acb837a3a86c3.interact )
        {
            s_pap.var_370acb837a3a86c3.interact disableplayeruse( player );
        }
    }
    
    var_578502a4a747467a = currentweapon == self.var_cc1262e66dbb1c79;
    rarity = namespace_9d8e359c3b1041e5::getplayerweaponraritysharedfunc( currentweapon );
    item_weapon::items_weapon_removeweapon( { #var_5156a93210ad2807:1, #dontdrop:1, #weapon:currentweapon } );
    
    if ( var_578502a4a747467a )
    {
        weaponname = "sat_me_knife_mp";
        forcedweapon = weapon_utility::function_d2c8356dc369d9ce( weaponname );
        item_weapon::function_35910aac16378fec( forcedweapon );
        weapon::function_b4c9549dee5d0fc5( forcedweapon );
        item_weapon::function_40e1cbd0e1f47d1a( forcedweapon, 0 );
        self switchtoweaponimmediate( forcedweapon );
        
        if ( !callback::exists( #"item_weapon_drop", &function_87efecd5ba828402 ) )
        {
            callback::add( #"item_weapon_drop", &function_87efecd5ba828402 );
        }
    }
    
    var_8a61d4195b4b6e64 utility::scriptable_clearparententity();
    
    if ( n_firefly_pap )
    {
        var_8a61d4195b4b6e64.origin = spawn_origin;
    }
    else
    {
        var_8a61d4195b4b6e64.origin = spawn_origin;
    }
    
    var_97da397cfdcf8617 = utility::spawn_model( "tag_origin", var_8a61d4195b4b6e64.origin, spawn_angles );
    var_8a61d4195b4b6e64 utility::scriptable_setparententity( var_97da397cfdcf8617 );
    
    if ( n_firefly_pap )
    {
        var_97da397cfdcf8617 linkto( s_pap.var_370acb837a3a86c3 );
    }
    
    var_97da397cfdcf8617.starting_origin = var_8a61d4195b4b6e64.origin;
    
    if ( utility::issharedfuncdefined( #"zombie", #"hash_7a41dc50abbdc8bf" ) )
    {
        utility::callsharedfunc( #"zombie", #"hash_7a41dc50abbdc8bf", { #allow_movement:1, #craft_reason:"pack_a_punch" } );
    }
    
    if ( !weapon::iswonderweapon( currentweapon ) )
    {
        ammo_mod = ammo_mod::get_ammo_mod_name( currentweapon );
        
        if ( utility::issharedfuncdefined( #"ammo_mod", #"get_random_ammo_mod" ) )
        {
            ammo_mod = utility::callsharedfunc( #"ammo_mod", #"get_random_ammo_mod" );
        }
    }
    
    thread function_b84baa5b38c7abfe();
    var_31f56b908617236a = 0;
    var_d888d5792755fef2 = level.var_eda995bb839c4aa;
    var_de5b4a5fcf1aedd3 = int( min( var_5ea3ce34914078d1.paplv + 1, var_d888d5792755fef2 ) );
    new_weapon = function_e190a315803e2870( var_8a61d4195b4b6e64.weaponobj, var_de5b4a5fcf1aedd3, ammo_mod );
    level notify( #"hash_b2701c15341273e2", self, var_de5b4a5fcf1aedd3, new_weapon );
    var_427f4fd9c51e4d78 = spawn_origin;
    
    if ( var_feda55b52a08695d )
    {
        var_97da397cfdcf8617 moveto( s_pap.var_370acb837a3a86c3.origin + ( 0, 0, -30 ), 1.5 );
    }
    else if ( !n_firefly_pap )
    {
        var_97da397cfdcf8617 moveto( var_427f4fd9c51e4d78 + anglestoforward( s_pap.var_370acb837a3a86c3.angles ) * -20, 1.5 );
        wait 2;
    }
    
    var_8a61d4195b4b6e64 utility::scriptable_clearparententity();
    var_8a61d4195b4b6e64 freescriptable();
    spawnoptions = common_item::function_bc5ff2958b71a708( var_97da397cfdcf8617.origin, s_pap.var_370acb837a3a86c3.angles + ( 90, 0, 0 ) );
    spawnoptions.spawnpositionindex = 1;
    spawnoptions.weapon = new_weapon;
    spawnoptions.var_8d4f327170228364 = 1;
    function_3f3b9cdbb4843e45( new_weapon, var_de5b4a5fcf1aedd3, 0 );
    var_513eb23487d6b42a = function_6fc306d1b8b4d844( new_weapon );
    var_513eb23487d6b42a.ammoclipright = var_5ea3ce34914078d1.ammoclipright;
    var_513eb23487d6b42a.ammoclipleft = var_5ea3ce34914078d1.ammoclipleft;
    var_513eb23487d6b42a.ammoclipalt = var_5ea3ce34914078d1.ammoclipalt;
    var_513eb23487d6b42a.ammostock = var_5ea3ce34914078d1.ammostock;
    var_513eb23487d6b42a.weaponammocount = var_5ea3ce34914078d1.weaponammocount;
    var_513eb23487d6b42a.rarity = var_5ea3ce34914078d1.rarity;
    var_513eb23487d6b42a.count = 1;
    weapon_item_new = item_weapon::function_53da2af5697709f8( new_weapon, var_513eb23487d6b42a, spawnoptions );
    weapon_item_new setscriptablepartstate( "obloot_custom_weapon", "custom_pap_visible" );
    weapon_item_new utility::scriptable_clearparententity();
    weapon_item_new utility::scriptable_setparententity( var_97da397cfdcf8617 );
    
    foreach ( player in level.players )
    {
        weapon_item_new disablescriptableplayeruse( player );
    }
    
    params = spawnstruct();
    params.var_101633ed971732ba = new_weapon;
    params.var_39044599845b54cf = currentweapon;
    params.w_new_alt = new_weapon getaltweapon();
    params.var_951c89546ec50477 = n_current_weapon_lvl + 1;
    params.cost = cost;
    params.currency = currency;
    params.player = self;
    params.rarity = rarity;
    callback::callback( "zm_packed_weapon", params );
    wait 1;
    
    if ( !n_firefly_pap )
    {
        var_97da397cfdcf8617 moveto( var_97da397cfdcf8617.starting_origin, 1.5 );
        wait 2;
    }
    
    weapon_item_new enablescriptableplayeruse( self );
    weapon_item_new.pap_owner = s_pap;
    
    if ( !isdefined( level.var_fded626a6e027575 ) )
    {
        level.var_fded626a6e027575 = 1;
    }
    
    if ( !level callback::exists( #"item_weapon_picked_up", &function_fc8ec85501be6cb8 ) )
    {
        level callback::add( #"item_weapon_picked_up", &function_fc8ec85501be6cb8 );
    }
    
    weapon_item_new.var_97da397cfdcf8617 = var_97da397cfdcf8617;
    weapon_item_new.var_578502a4a747467a = var_578502a4a747467a;
    weapon_item_new.var_31f56b908617236a = var_31f56b908617236a;
    weapon_item_new.weapon_info_old = var_5ea3ce34914078d1;
    
    if ( n_firefly_pap )
    {
        stored_origin = weapon_item_new.origin;
    }
    
    wait 1;
    
    if ( var_97da397cfdcf8617 )
    {
        var_97da397cfdcf8617 thread function_75f82c9d73b66090( var_97da397cfdcf8617, weapon_item_new, stored_origin, n_firefly_pap );
    }
}

// Namespace pack_a_punch
// Params 1
// Checksum 0x66d4ea22, Offset: 0x6157
// Size: 0x51
function function_87efecd5ba828402( params )
{
    dropped_weapon = params.instance;
    
    if ( dropped_weapon )
    {
        common_item::function_869d7676e359a627( dropped_weapon );
    }
    
    params.player callback::remove( #"item_weapon_drop", &function_87efecd5ba828402 );
}

// Namespace pack_a_punch
// Params 1
// Checksum 0xee89d70c, Offset: 0x61b0
// Size: 0xcd
function get_pap_weapon_pivot( currentweapon )
{
    if ( currentweapon.basename == "sat_me_nashira_mp" )
    {
        return ( 15, 0, 0 );
    }
    
    if ( currentweapon.basename == "sat_me_elnath_mp" )
    {
        return ( 0, -15, 0 );
    }
    
    if ( currentweapon.basename == "sat_ww_locust_zm" )
    {
        return ( -10, 0, 3 );
    }
    
    if ( currentweapon.basename == "sat_ww_hornet_zm" )
    {
        return ( -4, 0, -3 );
    }
    
    if ( currentweapon.ismelee )
    {
        return ( 0, 0, 0 );
    }
    
    return ( 0, -7, 0 );
}

// Namespace pack_a_punch
// Params 0, eflags: 0x4
// Checksum 0x923cb5f0, Offset: 0x6285
// Size: 0x57
function private function_b84baa5b38c7abfe()
{
    self endon( #"death_or_disconnect" );
    wait 2.5;
    
    if ( utility::issharedfuncdefined( #"zombie", #"hash_b02bf237a5e905cd" ) )
    {
        utility::callsharedfunc( #"zombie", #"hash_b02bf237a5e905cd", { #craft_reason:"pack_a_punch" } );
    }
}

// Namespace pack_a_punch
// Params 1, eflags: 0x4
// Checksum 0x61c4d912, Offset: 0x62e4
// Size: 0x1dd
function private function_fc8ec85501be6cb8( params )
{
    if ( !isdefined( params.newweaponobj ) || !isdefined( params.item.pap_owner ) )
    {
        return 0;
    }
    
    weapon = params.newweaponobj;
    var_482e9999b75ed3d8 = istrue( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_z_mod", #"z_mod_pack_mule" ) );
    max_stock_ammo = utility::get_max_stock_ammo( weapon, var_482e9999b75ed3d8 );
    self setweaponammostock( weapon, max_stock_ammo );
    var_83e55048826dcd05 = self getweaponammoclip( weapon );
    var_b11feea92c35d08e = weaponclipsize( weapon );
    
    if ( var_83e55048826dcd05 < var_b11feea92c35d08e )
    {
        self setweaponammoclip( weapon, weaponclipsize( weapon ) );
    }
    
    if ( weapon::isakimbo( weapon ) )
    {
        if ( !isdefined( lefthandquantity ) )
        {
            lefthandquantity = weaponclipsize( weapon );
        }
        
        self setweaponammoclip( weapon, lefthandquantity, "left" );
    }
    
    if ( weapon.hasalternate && !weapon::function_33e74163843b348e( weapon ) )
    {
        weaponaltobj = weapon getaltweapon();
        max_stock_ammo = utility::get_max_stock_ammo( weaponaltobj, var_482e9999b75ed3d8 );
        self setweaponammostock( weaponaltobj, max_stock_ammo );
        var_83e55048826dcd05 = self getweaponammoclip( weaponaltobj );
        var_b11feea92c35d08e = weaponclipsize( weaponaltobj );
        
        if ( var_83e55048826dcd05 < var_b11feea92c35d08e )
        {
            self setweaponammoclip( weaponaltobj, weaponclipsize( weaponaltobj ) );
        }
    }
    
    pap_lvl = get_pap_level( weapon );
    function_3f3b9cdbb4843e45( weapon, pap_lvl );
    self notify( #"weapon_level_changed" );
    
    if ( params.item.var_578502a4a747467a )
    {
        weapon::function_b4c9549dee5d0fc5( weapon );
    }
    
    params.var_101633ed971732ba = weapon;
    callback::callback( "zm_packed_weapon_non_augment", params );
    function_a5e8f6198a244194( params.item );
}

// Namespace pack_a_punch
// Params 4, eflags: 0x4
// Checksum 0xaf90eb8, Offset: 0x64c9
// Size: 0x76
function private function_75f82c9d73b66090( var_f8b8161c0a2a98ca, weapon_obj, stored_origin, n_firefly_pap = undefined )
{
    var_f8b8161c0a2a98ca endon( #"death" );
    wait 10;
    
    if ( var_f8b8161c0a2a98ca && weapon_obj )
    {
        level thread function_a5e8f6198a244194( weapon_obj, stored_origin, 1 );
        return;
    }
    
    if ( n_firefly_pap )
    {
        level thread function_a5e8f6198a244194( weapon_obj, weapon_obj.origin, 1 );
    }
}

// Namespace pack_a_punch
// Params 3, eflags: 0x4
// Checksum 0x4b9ab4ba, Offset: 0x6547
// Size: 0x123
function private function_a5e8f6198a244194( instance_struct, stored_origin, var_c9dc7a6277a2c658 )
{
    foreach ( player in level.players )
    {
        if ( instance_struct.pap_owner.var_370acb837a3a86c3.interact )
        {
            instance_struct.pap_owner.var_370acb837a3a86c3.interact enableplayeruse( player );
        }
        
        player.var_73e2de392faa52c6 = undefined;
    }
    
    if ( isdefined( stored_origin ) )
    {
        level thread function_190e6557a9c5a1d3( stored_origin );
    }
    
    if ( var_c9dc7a6277a2c658 && instance_struct )
    {
        common_item::function_869d7676e359a627( instance_struct );
    }
    
    if ( instance_struct.var_97da397cfdcf8617 )
    {
        instance_struct.var_97da397cfdcf8617 delete();
    }
}

// Namespace pack_a_punch
// Params 1
// Checksum 0x24e3fdd5, Offset: 0x6672
// Size: 0x6e
function function_190e6557a9c5a1d3( stored_origin )
{
    if ( !isdefined( stored_origin ) )
    {
        return;
    }
    
    if ( level._effect[ #"gun_disappear" ] )
    {
        playfx( level._effect[ #"gun_disappear" ], stored_origin );
        playsoundatpos( stored_origin, "evt_zm_sat_pap_weapon_poof" );
        wait 0.5;
        function_10392a0d3005a35c( level._effect[ #"gun_disappear" ] );
    }
}

// Namespace pack_a_punch
// Params 1, eflags: 0x4
// Checksum 0x7279f887, Offset: 0x66e8
// Size: 0x116
function private function_6fc306d1b8b4d844( currentweapon )
{
    rarity = namespace_9d8e359c3b1041e5::getplayerweaponraritysharedfunc( currentweapon );
    var_c126ac2e6a22d987 = get_pap_level( currentweapon );
    ammomod = item_weapon::function_ef9c1a22435b14b9( currentweapon );
    ammoclipright = self getweaponammoclip( currentweapon );
    ammoclipleft = self getweaponammoclip( currentweapon, "left" );
    ammoclipalt = item_weapon::function_dc8d4a742844a795( currentweapon ) ? 0 : self getweaponammoclip( currentweapon getaltweapon() );
    ammostock = self getweaponammostock( currentweapon );
    weaponammocount = self getweaponammoclip( currentweapon );
    weaponinfostruct = { #weaponammocount:weaponammocount, #ammostock:ammostock, #ammoclipalt:ammoclipalt, #ammoclipleft:ammoclipleft, #ammoclipright:ammoclipright, #ammomod:ammomod, #paplv:var_c126ac2e6a22d987, #rarity:rarity };
    return weaponinfostruct;
}

// Namespace pack_a_punch
// Params 1
// Checksum 0x286c31e4, Offset: 0x6807
// Size: 0x42
function function_a00fc65c9ba3e3b3( s_feature )
{
    s_pap = s_feature;
    s_pap disable_pap( 1, 1 );
    s_pap.var_370acb837a3a86c3.interact setusableenabled( 0 );
}

// Namespace pack_a_punch
// Params 1
// Checksum 0xe581f256, Offset: 0x6851
// Size: 0x3f
function function_e090b79ea7d29598( s_feature )
{
    s_pap = s_feature;
    s_pap function_6070a52035419b87();
    s_pap.var_370acb837a3a86c3.interact setusableenabled( 1 );
}

/#

    // Namespace pack_a_punch
    // Params 0, eflags: 0x4
    // Checksum 0x416b8667, Offset: 0x6898
    // Size: 0x381, Type: dev
    function private function_e8d1716e8437b56d()
    {
        var_344c87cda146b92c = ( 0, 0, 4 );
        n_text_size = 0.25;
        
        while ( true )
        {
            foreach ( s_pap in level.var_db52bcfd04d45a7a )
            {
                if ( !isdefined( s_pap.var_370acb837a3a86c3 ) )
                {
                    continue;
                }
                
                if ( !isdefined( s_pap.s_destination ) )
                {
                    if ( isdefined( s_pap.var_93e4a0a8514ca47e ) )
                    {
                        s_pap.s_destination = utility::getstruct( s_pap.var_93e4a0a8514ca47e, "<dev string:x414>" );
                    }
                    else
                    {
                        s_pap.var_93e4a0a8514ca47e = s_pap.name;
                        s_pap.s_destination = s_pap;
                    }
                }
                
                v_position = s_pap.var_370acb837a3a86c3.origin;
                utility::draw_circle( v_position, 100, ( 0, 0, 1 ), 1, 0, 1 );
                
                if ( isdefined( s_pap.s_destination.origin ) )
                {
                    line( v_position, s_pap.s_destination.origin, ( 0, 1, 0 ) );
                    print3d( s_pap.s_destination.origin, "<dev string:x41f>" + s_pap.var_93e4a0a8514ca47e, ( 0, 1, 0 ), 1, 0.25 );
                }
                
                print3d( v_position - var_344c87cda146b92c * 1, "<dev string:x431>" + s_pap.name, ( 0, 1, 0 ), 1, 0.25 );
                print3d( v_position - var_344c87cda146b92c * 2, "<dev string:x43c>" + ( s_pap.script_power ?? "<dev string:x449>" ), ( 0, 1, 0 ), 1, 0.25 );
                print3d( v_position - var_344c87cda146b92c * 3, "<dev string:x44a>" + ( s_pap.var_1c9754ecd2f9d888 ? "<dev string:x45a>" : "<dev string:x45e>" ), ( 0, 1, 0 ), 1, 0.25 );
                print3d( v_position - var_344c87cda146b92c * 4, "<dev string:x461>" + s_pap.var_93e4a0a8514ca47e, ( 0, 1, 0 ), 1, 0.25 );
                
                foreach ( player in level.players )
                {
                    if ( isdefined( player.var_c51700b82e11cef3 ) )
                    {
                        print3d( player.origin, player.name + "<dev string:x46f>" + player.var_c51700b82e11cef3.name, ( 0, 1, 0 ), 1, 0.25 );
                    }
                }
            }
            
            waitframe();
        }
    }

#/
