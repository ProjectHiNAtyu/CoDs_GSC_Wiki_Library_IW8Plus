// scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_scenes.gsc  (hash_3baaedef64f29ab7.gscc) (size: 14339 Bytes / 0x3803 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x80763ecc (2155232972)
// size ...... 14339 (0x3803)
// includes .. 9   (offset: 0x325f)
// strings ... 90  (offset: 0x32a7)
// dev strs .. 2   (offset: 0x37eb)
// exports ... 39  (offset: 0x22ab)
// cseg ...... 0x90e + 0x199d (0x22ab)
// imports ... 72  (offset: 0x28c3)
// animtree1 . 0   (offset: 0x3803)
// animtree2 . 0   (offset: 0x3803)
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\hud_util;
#using scripts\common\save;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\coop;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_util;
#using scripts\mp\mp_agent;

#namespace namespace_60d9b3cbf41663fe;

/#

    // Namespace namespace_60d9b3cbf41663fe
    // Params 0
    // Checksum 0x94aac8ba, Offset: 0x92c
    // Size: 0x5, Type: dev
    function function_2483b121e333ef42()
    {
        
    }

#/

// Namespace namespace_60d9b3cbf41663fe
// Params 0
// Checksum 0x11e94cf8, Offset: 0x939
// Size: 0x28
function function_4b3fd3d4202ec8f8()
{
    coop::play_cinematic( "sat_gemini_intro_antechamber", { #timeout:55, #flag:"flag_gemini_intro_igc_complete" } );
}

/#

    // Namespace namespace_60d9b3cbf41663fe
    // Params 0
    // Checksum 0xf649cc0, Offset: 0x969
    // Size: 0x5, Type: dev
    function function_fceaec8de110530e()
    {
        
    }

    // Namespace namespace_60d9b3cbf41663fe
    // Params 0
    // Checksum 0xa45b2a00, Offset: 0x976
    // Size: 0x5, Type: dev
    function function_feef0debc2d0f945()
    {
        
    }

#/

// Namespace namespace_60d9b3cbf41663fe
// Params 0
// Checksum 0xf66dfc5f, Offset: 0x983
// Size: 0xb5
function function_b4dbb2fd9f18d56f()
{
    level endon( #"OB_GEMINI_CABIN_BARRAGE_COMPLETE" );
    activity_instance = self;
    animnode = utility::getstruct( "sat_cin_gem_cabin_interior", "targetname" );
    animnode thread scene::play( undefined, "moment1" );
    waitframe();
    alex_ent = animnode scene::get_entity( "alex_mem" );
    level notify( #"highvis_reload_outline", level.players[ 0 ].team, [ alex_ent ] );
    utility::flag_wait( "OB_GEMINI_CABIN_MEMORYCAPTURE_COMPLETE" );
    utility::flag_wait( "flag_transit_fx_complete" );
    animnode scene::stop();
    animnode scene::cleanup();
    function_b4dbb3fd9f18d7a2();
}

// Namespace namespace_60d9b3cbf41663fe
// Params 0
// Checksum 0x705113ce, Offset: 0xa40
// Size: 0x84
function function_b4dbb3fd9f18d7a2()
{
    level endon( #"OB_GEMINI_CABIN_BARRAGE_COMPLETE" );
    activity_instance = self;
    animnode = utility::getstruct( "sat_cin_gem_cabin_interior", "targetname" );
    animnode thread scene::play( undefined, "moment2" );
    waitframe();
    alex_ent = animnode scene::get_entity( "alex_color" );
    level notify( #"highvis_reload_outline", level.players[ 0 ].team, [ alex_ent ] );
}

// Namespace namespace_60d9b3cbf41663fe
// Params 1
// Checksum 0xf98fb2ed, Offset: 0xacc
// Size: 0x3a
function function_e69924b8c42425bd( memory_name )
{
    animnode = utility::getstruct( "sat_cin_gem_cabin_capture_point_monitors_" + memory_name, "targetname" );
    animnode thread scene::play( undefined, "idle_start" );
}

// Namespace namespace_60d9b3cbf41663fe
// Params 1
// Checksum 0x3e5caf15, Offset: 0xb0e
// Size: 0x3d
function function_5896811a3fcd56ae( memory_name )
{
    animnode = utility::getstruct( "sat_cin_gem_cabin_capture_point_monitors_" + memory_name, "targetname" );
    animnode scene::stop();
    animnode scene::cleanup();
}

// Namespace namespace_60d9b3cbf41663fe
// Params 2
// Checksum 0x1990230e, Offset: 0xb53
// Size: 0x2a6
function function_ebedec484bba1d7e( memory_name, shot_num )
{
    shot_name = "shot_" + shot_num;
    scene_name = "sat_cin_gem_cabin_capture_point_" + memory_name;
    animnode = utility::getstruct( scene_name, "targetname" );
    
    if ( isdefined( animnode ) )
    {
        animnode scene::stop();
        animnode scene::cleanup();
        animnode thread scene::play( undefined, shot_name );
        
        if ( shot_num == 1 )
        {
            function_72f9fa7b28c29621( animnode );
        }
        
        if ( shot_num == 2 )
        {
            function_72f9fa7b28c29621( animnode );
            
            if ( memory_name == "memory01" )
            {
                var_57b3fa4eb64deb8c = utility::getstruct( "sat_cin_gem_cabin_capture_point_monitors_memory01", "targetname" );
                var_57b3fa4eb64deb8c scene::play( undefined, "path_2" );
                var_57b3fa4eb64deb8c thread scene::play( undefined, "idle_end_3" );
            }
        }
        
        if ( shot_num == 3 )
        {
            function_72f9fa7b28c29621( animnode );
            
            if ( memory_name == "memory04" )
            {
                utility::exploder( "vfx_cabin_chimney_fire" );
                wait 3.5;
            }
            else
            {
                wait 11;
            }
            
            wait 2;
            function_f9584ca9e9ff1987();
            
            if ( utility::flag( "OB_GEMINI_CABIN_MEMORYCAPTURE_COMPLETE" ) )
            {
                thread function_90d639e056bfd892();
            }
            
            var_24de0c4121762f28 = 1;
            
            while ( var_24de0c4121762f28 <= 3 )
            {
                var_5f81aced2f5d2e51 = utility::getstruct( "cabin_center_struct", "targetname" );
                earthquake( randomfloatrange( 0.1, 0.175 ), randomfloatrange( 0.4, 0.5 ), var_5f81aced2f5d2e51.origin, 300 );
                playrumbleonposition( "artillery_rumble_light", var_5f81aced2f5d2e51.origin );
                isleft = randomint( 2 );
                
                if ( isleft )
                {
                    random_num_left = randomintrange( 1, 10 );
                    var_8e0d193026f2ec25 = "e_cabin_exit_screen_l" + random_num_left;
                }
                else
                {
                    random_num_right = randomintrange( 1, 8 );
                    var_8e0d193026f2ec25 = "e_cabin_exit_screen_r" + random_num_right;
                }
                
                current_state = function_781f3df044bf48f2( var_8e0d193026f2ec25, "targetname" );
                
                if ( isdefined( current_state ) )
                {
                    if ( current_state == "kagan" )
                    {
                        function_d988510d954aa7d6( var_8e0d193026f2ec25, "targetname", memory_name );
                        memory_id = int( memory_name[ 7 ] );
                        save::mission_get_data().var_a3ca35c5620cd80c[ memory_id ][ save::mission_get_data().var_a3ca35c5620cd80c[ memory_id ].size ] = var_8e0d193026f2ec25;
                        var_24de0c4121762f28 += 1;
                    }
                }
                
                wait randomfloatrange( 0.25, 0.5 );
            }
            
            wait 5;
            function_72f9fa7b28c29621( animnode );
            animnode scene::stop();
            animnode scene::cleanup();
        }
    }
}

// Namespace namespace_60d9b3cbf41663fe
// Params 0
// Checksum 0xb8ae779e, Offset: 0xe01
// Size: 0xbc
function function_ae926e8ad8d5062()
{
    level utility::flag_wait( "flag_cabin_barrage_flood_begin" );
    a_screens = get_monitor_screens( "sn_cabin_exit_screen", "script_noteworthy" );
    
    foreach ( screen in a_screens )
    {
        if ( screen getscriptableparthasstate( "screen", "kagan" ) )
        {
            screen setscriptablepartstate( "screen", "kagan" );
        }
        
        wait 0.2;
    }
}

// Namespace namespace_60d9b3cbf41663fe
// Params 0
// Checksum 0xfb00f1d, Offset: 0xec5
// Size: 0xa0
function function_f9584ca9e9ff1987()
{
    animnode_interior = utility::getstruct( "sat_cin_gem_cabin_interior", "targetname" );
    e_amason = animnode_interior.scenedata.sceneroot scene::get_entity( "alex_mem" );
    
    if ( isdefined( e_amason ) )
    {
        e_amason hide();
        waitframe();
        
        if ( isdefined( e_amason ) )
        {
            e_amason show();
        }
        
        wait 0.5;
        
        if ( isdefined( e_amason ) )
        {
            e_amason hide();
        }
        
        waitframe();
        
        if ( isdefined( e_amason ) )
        {
            e_amason show();
        }
        
        waitframe();
        
        if ( isdefined( e_amason ) )
        {
            e_amason hide();
        }
        
        waitframe();
        
        if ( isdefined( e_amason ) )
        {
            e_amason show();
        }
    }
}

// Namespace namespace_60d9b3cbf41663fe
// Params 1
// Checksum 0x70138494, Offset: 0xf6d
// Size: 0x127
function function_72f9fa7b28c29621( animnode )
{
    waitframe();
    
    if ( isdefined( animnode ) )
    {
        e_child_mason = animnode.scenedata.sceneroot scene::get_entity( "david" );
        e_alex_mason = animnode.scenedata.sceneroot scene::get_entity( "alex" );
        
        if ( isdefined( e_child_mason ) )
        {
            var_f1bc84eec0475064 = e_child_mason gettagorigin( "J_SpineUpper" );
            
            if ( isdefined( e_alex_mason ) )
            {
                alex_mason_pos = e_alex_mason gettagorigin( "J_SpineUpper" );
                memory_fx_pos = ( ( var_f1bc84eec0475064[ 0 ] + alex_mason_pos[ 0 ] ) / 2, ( var_f1bc84eec0475064[ 1 ] + alex_mason_pos[ 1 ] ) / 2, ( var_f1bc84eec0475064[ 2 ] + alex_mason_pos[ 2 ] ) / 2 );
            }
            else
            {
                memory_fx_pos = var_f1bc84eec0475064;
            }
        }
        else
        {
            memory_fx_pos = animnode.origin;
        }
        
        playfx( level._effect[ "memory_cradle_dissipate_1" ], memory_fx_pos );
        level notify( #"highvis_reload_outline", level.players[ 0 ].team, [ e_child_mason, e_alex_mason ] );
    }
}

// Namespace namespace_60d9b3cbf41663fe
// Params 0
// Checksum 0x791a88a, Offset: 0x109c
// Size: 0x8c
function function_90d639e056bfd892()
{
    animnode = utility::getstruct( "sat_cin_gem_cabin_interior", "targetname" );
    e_amason = animnode.scenedata.sceneroot scene::get_entity( "alex_mem" );
    
    if ( isdefined( e_amason ) )
    {
        var_afb881460a65a72d = e_amason gettagorigin( "J_SpineUpper" );
        waitframe();
        playfx( level._effect[ "conceal_mist_1" ], var_afb881460a65a72d );
        wait 0.5;
    }
    
    utility::flag_set( "flag_transit_fx_complete" );
}

// Namespace namespace_60d9b3cbf41663fe
// Params 0
// Checksum 0x6082e23e, Offset: 0x1130
// Size: 0x87
function function_726ff0a78381177c()
{
    animnode = utility::getstruct( "sat_cin_gem_cabin_capture_point_memory04", "targetname" );
    
    if ( isdefined( animnode ) )
    {
        animnode thread scene::play( undefined, "shot_3" );
        createnavrepulsor( "sat_cin_gem_cabin_capture_point_memory04" + "_repulsor", 0, animnode.origin, 50 );
        
        if ( !isdefined( level.cabin_repulsors ) )
        {
            level.cabin_repulsors = [];
        }
        
        level.cabin_repulsors[ level.cabin_repulsors.size ] = "sat_cin_gem_cabin_capture_point_memory04" + "_repulsor";
    }
}

// Namespace namespace_60d9b3cbf41663fe
// Params 0
// Checksum 0x8b3e1335, Offset: 0x11bf
// Size: 0xae
function function_3c2213f6d95e7249()
{
    memory_num = 1;
    
    while ( memory_num <= 3 )
    {
        scene_name = "sat_cin_gem_cabin_capture_point_memory0" + memory_num;
        animnode = utility::getstruct( scene_name, "targetname" );
        
        if ( isdefined( animnode ) )
        {
            animnode thread scene::play( undefined, "shot_3" );
            createnavrepulsor( scene_name + "_repulsor", 0, animnode.origin, 50 );
            
            if ( !isdefined( level.cabin_repulsors ) )
            {
                level.cabin_repulsors = [];
            }
            
            level.cabin_repulsors[ level.cabin_repulsors.size ] = scene_name + "_repulsor";
        }
        
        memory_num += 1;
    }
}

// Namespace namespace_60d9b3cbf41663fe
// Params 0
// Checksum 0xc6b9f12c, Offset: 0x1275
// Size: 0x6c
function function_ec29754525c1de62()
{
    save::mission_get_data().var_a3ca35c5620cd80c[ 1 ] = [];
    save::mission_get_data().var_a3ca35c5620cd80c[ 2 ] = [];
    save::mission_get_data().var_a3ca35c5620cd80c[ 3 ] = [];
    save::mission_get_data().var_a3ca35c5620cd80c[ 4 ] = [];
    function_d988510d954aa7d6( "sn_cabin_exit_screen", "script_noteworthy", "kagan" );
}

// Namespace namespace_60d9b3cbf41663fe
// Params 0
// Checksum 0xafbc2b89, Offset: 0x12e9
// Size: 0xea
function function_21c9e40d5c20c5da()
{
    save::mission_get_data().var_a3ca35c5620cd80c[ 1 ] = [];
    save::mission_get_data().var_a3ca35c5620cd80c[ 2 ] = [];
    save::mission_get_data().var_a3ca35c5620cd80c[ 3 ] = [];
    function_d988510d954aa7d6( "sn_cabin_exit_screen", "script_noteworthy", "kagan" );
    
    foreach ( monitor_targetname in save::mission_get_data().var_a3ca35c5620cd80c[ 4 ] )
    {
        if ( isdefined( monitor_targetname ) )
        {
            function_d988510d954aa7d6( monitor_targetname, "targetname", "memory04" );
        }
    }
}

// Namespace namespace_60d9b3cbf41663fe
// Params 0
// Checksum 0xa3e40d46, Offset: 0x13db
// Size: 0x144
function function_6babdc48cee69335()
{
    function_d988510d954aa7d6( "sn_cabin_exit_screen", "script_noteworthy", "kagan" );
    var_6d54ce75a99dcf54 = [ 1, 2, 3, 4 ];
    
    foreach ( memory_id in var_6d54ce75a99dcf54 )
    {
        foreach ( monitor_targetname in save::mission_get_data().var_a3ca35c5620cd80c[ memory_id ] )
        {
            if ( isdefined( monitor_targetname ) )
            {
                memory_name = "memory0" + memory_id;
                function_d988510d954aa7d6( monitor_targetname, "targetname", memory_name );
            }
        }
    }
}

// Namespace namespace_60d9b3cbf41663fe
// Params 0
// Checksum 0x65c850f6, Offset: 0x1527
// Size: 0x2
function function_a974af795d487a10()
{
    
}

// Namespace namespace_60d9b3cbf41663fe
// Params 0
// Checksum 0xe25e4915, Offset: 0x1531
// Size: 0xdf
function function_e176d21ff78c394e()
{
    level utility::flag_wait( "OB_GEMINI_CABIN_BARRAGE_COMPLETE" );
    var_2f5da18ca77fd591 = [ "sat_cin_gem_cabin_interior", "sat_cin_gem_cabin_capture_point_memory01", "sat_cin_gem_cabin_capture_point_memory02", "sat_cin_gem_cabin_capture_point_memory03", "sat_cin_gem_cabin_capture_point_memory04" ];
    
    foreach ( scene_name in var_2f5da18ca77fd591 )
    {
        animnode = utility::getstruct( scene_name, "targetname" );
        
        if ( isdefined( animnode ) )
        {
            animnode scene::stop();
            animnode scene::cleanup();
        }
    }
}

/#

    // Namespace namespace_60d9b3cbf41663fe
    // Params 0
    // Checksum 0xb8a589, Offset: 0x1618
    // Size: 0x5, Type: dev
    function function_d478e7dd31b2c66c()
    {
        
    }

#/

// Namespace namespace_60d9b3cbf41663fe
// Params 0
// Checksum 0xe714f0ab, Offset: 0x1625
// Size: 0x40
function function_faa67b2e7f82331a()
{
    thread function_be46e087ed9e17ec( "sat_cin_gem_zmb_sdlr_takedown01", "e_prison_zmb_sdlr_takedown_zombie01", "e_prison_zmb_sdlr_takedown_zombie02" );
    thread function_be46e087ed9e17ec( "sat_cin_gem_zmb_sdlr_takedown01_3", "e_prison_zmb_sdlr_takedown_3_zombie01", "e_prison_zmb_sdlr_takedown_3_zombie02" );
    thread function_be46e087ed9e17ec( "sat_cin_gem_zmb_sdlr_takedown01_4", "e_prison_zmb_sdlr_takedown_4_zombie01", undefined );
}

// Namespace namespace_60d9b3cbf41663fe
// Params 3
// Checksum 0x803126fd, Offset: 0x166d
// Size: 0x189
function function_be46e087ed9e17ec( targetname, var_9426a039d066ed12, var_26fcb6d7b61e1475 )
{
    animated_zombies = [];
    
    if ( isdefined( var_9426a039d066ed12 ) )
    {
        zombie01 = ai_zombie_spawn( "zombie01", var_9426a039d066ed12, "sat_spawner_zombie_base_sm_friend" );
        zombie01.ignoreme = 1;
        animated_zombies[ animated_zombies.size ] = zombie01;
    }
    
    if ( isdefined( var_26fcb6d7b61e1475 ) )
    {
        zombie02 = ai_zombie_spawn( "zombie02", var_26fcb6d7b61e1475, "sat_spawner_zombie_base_sm_friend" );
        zombie02.ignoreme = 1;
        animated_zombies[ animated_zombies.size ] = zombie02;
    }
    
    if ( animated_zombies.size == 0 )
    {
        return;
    }
    
    animnode = utility::getstruct( targetname, "targetname" );
    animnode scene::set_notify_note( animnode, "grunt_fire", "grunt_soldier" );
    animnode scene::set_notify_note( animnode, "weapon_unlink", "grunt_soldier" );
    animnode childthread function_197b363286de2722( "grunt_fire", "weapon_unlink" );
    animnode scene::play( animated_zombies );
    
    foreach ( zombie in animated_zombies )
    {
        zombie.allowdeath = 1;
        zombie.ignoreme = 0;
        function_93472d1aa865b3d( zombie );
    }
}

// Namespace namespace_60d9b3cbf41663fe
// Params 2
// Checksum 0x6f8f53eb, Offset: 0x17fe
// Size: 0xad
function function_197b363286de2722( fire_notify, unlink_notify )
{
    animnode = self;
    animnode waittill( fire_notify );
    
    for ( prop_weapon = undefined; !isdefined( prop_weapon ) ; prop_weapon = animnode scene::get_entity( "prop_wpn" ) )
    {
    }
    
    fire_rate = randomintrange( 6, 12 );
    i = 0;
    
    while ( i <= fire_rate )
    {
        playfxontag( level._effect[ "vfx_sat_core_weapons_muz_ar" ], prop_weapon, "tag_flash" );
        i++;
        wait randomfloatrange( 0, 0.6 );
    }
    
    animnode waittill( unlink_notify );
    prop_weapon unlink();
}

// Namespace namespace_60d9b3cbf41663fe
// Params 0
// Checksum 0x313f4aee, Offset: 0x18b3
// Size: 0xa5
function function_d2d62306b039f4e8()
{
    foreach ( player in level.players )
    {
        player thread hud_util::fade_out( 0, "white" );
        level utility::flag_wait( "flag_gemini_cabin_exit_igc_complete" );
        player thread hud_util::fade_in( 1, "white" );
    }
}

// Namespace namespace_60d9b3cbf41663fe
// Params 1
// Checksum 0x5cb28728, Offset: 0x1960
// Size: 0x92
function function_d90053228ff20554( var_39ae44a13ef5cd04 = 0.3 )
{
    foreach ( player in level.players )
    {
        player thread function_47cc67625e9a5c55( var_39ae44a13ef5cd04 );
    }
}

// Namespace namespace_60d9b3cbf41663fe
// Params 1, eflags: 0x4
// Checksum 0x60208b59, Offset: 0x19fa
// Size: 0x8f
function private function_47cc67625e9a5c55( var_39ae44a13ef5cd04 )
{
    self allowmovement( 0 );
    self setdemeanorviewmodel( "relaxed", "sat_ges_demeanor_relaxed_gundown_gem" );
    wait var_39ae44a13ef5cd04;
    self allowmovement( 1 );
    self setdemeanorviewmodel( "normal" );
    currentweapon = self getcurrentweapon();
    
    if ( !isdefined( currentweapon ) || isnullweapon( currentweapon ) )
    {
        if ( isdefined( self.primaryweapons[ 0 ] ) )
        {
            inventory_utility::_switchtoweaponimmediate( self.primaryweapons[ 0 ] );
            return;
        }
        
        inventory_utility::_switchtoweaponimmediate( self.var_cc1262e66dbb1c79 );
    }
}

// Namespace namespace_60d9b3cbf41663fe
// Params 1
// Checksum 0x34d76a4, Offset: 0x1a91
// Size: 0xb4
function function_93472d1aa865b3d( var_ea616919227739f )
{
    s_underground_breakable_barrier_01 = utility::getstruct( "s_underground_breakable_barrier_01", "targetname" );
    var_3f29c07af2f6e5e1 = utility::getstructarray( "s_underground_breakable_barrier_01_att_point", "targetname" );
    var_bb4c566ae5fb39a5 = getent( "v_minecarts_soldiers_center", #targetname );
    var_ea616919227739f.attractor = var_ea616919227739f zombie_attractor_manager::function_7eb1aaa8bc7cc15( s_underground_breakable_barrier_01, 1, 2500, 1, undefined, undefined, 0, undefined, 1 );
    zombie_attractor_manager::set_attractor_slots( var_ea616919227739f.attractor, var_3f29c07af2f6e5e1 );
    utility::flag_wait( "flag_underground_barrier_01_opened" );
    var_ea616919227739f zombie_attractor_manager::function_dcfb4c31f1d97cd2( s_underground_breakable_barrier_01 );
    var_ea616919227739f function_dd3b2de3b28ea995( 0, var_bb4c566ae5fb39a5 );
}

// Namespace namespace_60d9b3cbf41663fe
// Params 1
// Checksum 0x4a43074a, Offset: 0x1b4d
// Size: 0x302
function function_48d06e75c2be0143( var_ddbf287e41d23aa3 )
{
    door_left = getent( "e_underground_cart_door_l", #targetname );
    door_right = getent( "e_underground_cart_door_r", #targetname );
    door_clip = getentarray( "e_underground_cart_door_clip", #targetname );
    door_clip_outer = getentarray( "e_underground_cart_door_clip_outer", #targetname );
    zombie01 = ai_zombie_spawn( "zombie01", "slot_1", "sat_spawner_zombie_base_sm_friend" );
    zombie02 = ai_zombie_spawn( "zombie02", "slot_2", "sat_spawner_zombie_base_sm_friend" );
    zombie03 = ai_zombie_spawn( "zombie03", "slot_3", "sat_spawner_zombie_base_sm_friend" );
    zombie04 = ai_zombie_spawn( "zombie04", "slot_4", "sat_spawner_zombie_base_sm_friend" );
    door_left.animname = "door_left";
    door_right.animname = "door_right";
    var_7b4b8530ea8bd61e = [ zombie01, zombie02, zombie03, zombie04, door_left, door_right ];
    animnode = utility::getstruct( "sat_cin_gem_prison_horde_takedown_barricade", "targetname" );
    animnode thread scene::play( var_7b4b8530ea8bd61e, "loop" );
    
    if ( isdefined( door_clip.size > 0 ) )
    {
        foreach ( clip in door_clip )
        {
            clip disconnectpaths();
        }
    }
    
    if ( door_clip_outer.size > 0 )
    {
        foreach ( clip in door_clip_outer )
        {
            clip disconnectpaths();
        }
    }
    
    utility::flag_wait_all( "flag_underground_completed", "flag_prison_underground_soldiers_defeated" );
    level thread function_3a7e75d644a65801( door_clip, 5 );
    level thread function_3a7e75d644a65801( door_clip_outer, 9 );
    wait var_ddbf287e41d23aa3;
    utility::flag_set( "flag_underground_barrier_01_opened" );
    animnode scene::play( var_7b4b8530ea8bd61e, "exit" );
    
    if ( isdefined( zombie01 ) )
    {
        zombie01.allowdeath = 1;
    }
    
    if ( isdefined( zombie02 ) )
    {
        zombie02.allowdeath = 1;
    }
    
    if ( isdefined( zombie03 ) )
    {
        zombie03.allowdeath = 1;
    }
    
    if ( isdefined( zombie04 ) )
    {
        zombie04.allowdeath = 1;
    }
    
    utility::flag_set( "flag_underground_barrier_01_scene_complete" );
}

// Namespace namespace_60d9b3cbf41663fe
// Params 2
// Checksum 0x90a9bff5, Offset: 0x1e57
// Size: 0x97
function function_3a7e75d644a65801( door_clip_array, n_delay )
{
    wait n_delay;
    
    if ( door_clip_array.size > 0 )
    {
        foreach ( clip in door_clip_array )
        {
            clip connectpaths();
            clip delete();
        }
    }
}

/#

    // Namespace namespace_60d9b3cbf41663fe
    // Params 0
    // Checksum 0x8f99a47c, Offset: 0x1ef6
    // Size: 0x5, Type: dev
    function function_5532680730d3b31c()
    {
        
    }

#/

// Namespace namespace_60d9b3cbf41663fe
// Params 0
// Checksum 0x7a4fea9, Offset: 0x1f03
// Size: 0x40
function function_851e601bc3ae7892()
{
    coop::play_cinematic( "sat_gemini_exfil", { #fadeendshader:"black", #countdown:0, #timeout:13, #flag:"flag_gemini_exfil_igc_complete" } );
}

/#

    // Namespace namespace_60d9b3cbf41663fe
    // Params 0
    // Checksum 0x40058935, Offset: 0x1f4b
    // Size: 0x5, Type: dev
    function function_aeae71492a407d74()
    {
        
    }

#/

// Namespace namespace_60d9b3cbf41663fe
// Params 3
// Checksum 0x23619a69, Offset: 0x1f58
// Size: 0x56
function function_cb9480378a489439( var_1861bb0ab1c8aef6, struct_angles, scene_bundle )
{
    animnode = spawnstruct();
    animnode.origin = var_1861bb0ab1c8aef6;
    animnode.angles = struct_angles;
    animnode scene::set_scriptbundle( scene_bundle );
    return animnode;
}

// Namespace namespace_60d9b3cbf41663fe
// Params 3
// Checksum 0x3c0845a7, Offset: 0x1fb7
// Size: 0xee
function ai_zombie_spawn( anim_name, spawn_struct_name, aitype )
{
    if ( isdefined( spawn_struct_name ) )
    {
        spawn_struct = utility::getstruct( spawn_struct_name, "targetname" );
    }
    else
    {
        spawn_struct = spawnstruct();
        spawn_struct.origin = ( 0, 0, 0 );
    }
    
    if ( isdefined( spawn_struct ) )
    {
        var_ea616919227739f = mp_agent::spawnnewagentaitype( aitype, spawn_struct.origin, spawn_struct.angles, level.players[ 0 ].team );
        
        if ( isdefined( var_ea616919227739f ) )
        {
            var_ea616919227739f gemini_util::function_376f4cf6d212ef9b();
            var_ea616919227739f.allowdeath = 0;
            var_ea616919227739f.animname = anim_name;
        }
        else
        {
            println( "<dev string:x24>" );
        }
    }
    else
    {
        println( "<dev string:x5c>" );
    }
    
    return var_ea616919227739f;
}

// Namespace namespace_60d9b3cbf41663fe
// Params 2
// Checksum 0x2174a5fe, Offset: 0x20ae
// Size: 0x95
function get_monitor_screens( kvp_name, var_6e5d7c646cbe3c61 )
{
    if ( var_6e5d7c646cbe3c61 == "targetname" )
    {
        var_a631634dbbb93ca5 = getscriptablearray( kvp_name, #targetname );
        var_4e210c59337060c = getentitylessscriptablearray( kvp_name, #targetname );
        a_screens = arraycombine( var_a631634dbbb93ca5, var_4e210c59337060c );
    }
    else
    {
        var_a631634dbbb93ca5 = getscriptablearray( kvp_name, #script_noteworthy );
        var_4e210c59337060c = getentitylessscriptablearray( kvp_name, #script_noteworthy );
        a_screens = arraycombine( var_a631634dbbb93ca5, var_4e210c59337060c );
    }
    
    return a_screens;
}

// Namespace namespace_60d9b3cbf41663fe
// Params 3
// Checksum 0x61cdce67, Offset: 0x214c
// Size: 0xb8
function function_d988510d954aa7d6( kvp_name, var_6e5d7c646cbe3c61, bink_state )
{
    a_screens = get_monitor_screens( kvp_name, var_6e5d7c646cbe3c61 );
    
    foreach ( screen in a_screens )
    {
        if ( screen getscriptableparthasstate( "screen", bink_state ) )
        {
            screen setscriptablepartstate( "screen", bink_state );
        }
    }
}

// Namespace namespace_60d9b3cbf41663fe
// Params 2
// Checksum 0xe5e6db45, Offset: 0x220c
// Size: 0x9f
function function_781f3df044bf48f2( kvp_name, var_6e5d7c646cbe3c61 )
{
    a_screens = get_monitor_screens( kvp_name, var_6e5d7c646cbe3c61 );
    
    foreach ( screen in a_screens )
    {
        return screen getscriptablepartstate( "screen", 1 );
    }
}

