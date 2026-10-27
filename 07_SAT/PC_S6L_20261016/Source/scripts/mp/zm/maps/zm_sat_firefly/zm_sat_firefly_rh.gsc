// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_rh.gsc  (hash_6ad0ed04ec67beb8.gscc) (size: 16291 Bytes / 0x3fa3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x855fb697 (2237642391)
// size ...... 16291 (0x3fa3)
// includes .. 12  (offset: 0x3a33)
// strings ... 71  (offset: 0x3a93)
// dev strs .. 16  (offset: 0x3ec3)
// exports ... 42  (offset: 0x23af)
// cseg ...... 0x5a8 + 0x1e07 (0x23af)
// imports ... 129 (offset: 0x2a3f)
// animtree1 . 0   (offset: 0x3fa3)
// animtree2 . 0   (offset: 0x3fa3)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\hud_util;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\interaction;
#using scripts\mp\overlord;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_rabbithole;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zone_manager;

#namespace zm_sat_firefly_rh;

// Namespace zm_sat_firefly_rh
// Params 0, eflags: 0x5
// Checksum 0xc6b5a392, Offset: 0x5c6
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"firefly_rh", #"zm_quest", undefined, &postmain_init );
}

// Namespace zm_sat_firefly_rh
// Params 0, eflags: 0x4
// Checksum 0xad637a44, Offset: 0x5ef
// Size: 0x169
function private postmain_init()
{
    level thread function_4f3f711eb132a9a5();
    level thread zm_rabbithole::function_1c6c02f0af873754();
    
    if ( !getdvarint( @"enable_rh", 0 ) )
    {
        return;
    }
    
    if ( level zm_quest::function_b0a5181ebe7bb905() )
    {
        return;
    }
    
    level callback::add( #"player_connect", &on_player_connect );
    
    if ( !getdvarint( @"hash_7ae1c9d5cf785e78", 0 ) )
    {
        level utility::flag_wait_or_timeout( "rh_validation_set", 120 );
    }
    
    if ( !level.rh_enabled && !getdvarint( @"hash_7ae1c9d5cf785e78", 0 ) )
    {
        return;
    }
    
    level.firefly_rh = zm_quest::get_quest( #"firefly_rh" );
    level utility::flag_wait( "zm_quest_initialized" );
    level utility::flag_wait( "super_ee_save_check" );
    level utility::flag_wait( "scriptables_ready" );
    
    if ( level.var_e8b776e9698cb857 )
    {
        level utility::flag_set( "rh_to_pic" );
        return;
    }
    
    level thread zm_rabbithole::function_5b9514e060bb4725();
    level._effect[ "zombie_impact" ] = loadfxasset( "vfx_t10_levels_zm_quartz_machine_amp_impact" );
    level._effect[ "zombie_impact_blood" ] = loadfxasset( "vfx_t10_levels_zm_quartz_machine_amp_impact_blood" );
    level._effect[ "rh_sisters_spawn" ] = loadfxasset( "vfx_sat_zm_two_sisters_spawn" );
    level thread spawn_sisters();
    level thread spawn_crystals();
    level thread spawn_asteroid();
    level callback::add( "zm_exfil_success", &on_exfil_success );
    
    /#
        level thread init_firefly_rh_debug();
    #/
}

/#

    // Namespace zm_sat_firefly_rh
    // Params 0, eflags: 0x4
    // Checksum 0x68278118, Offset: 0x760
    // Size: 0x5, Type: dev
    function private function_b72167b0aebcd512()
    {
        
    }

#/

// Namespace zm_sat_firefly_rh
// Params 1, eflags: 0x4
// Checksum 0xfff805dc, Offset: 0x76d
// Size: 0x39
function private on_player_connect( params )
{
    if ( zm_save::function_1dda3554974a999e() )
    {
        if ( self.var_e8b776e9698cb857 )
        {
            level.var_e8b776e9698cb857 = 1;
        }
    }
    
    level utility::flag_set( "super_ee_save_check" );
}

// Namespace zm_sat_firefly_rh
// Params 0
// Checksum 0xe2ae52fa, Offset: 0x7ae
// Size: 0x18f
function spawn_sisters()
{
    level endon( #"game_ended" );
    var_1fb0e131c89db725 = utility::getstructarray( "nail_item_1" );
    var_aeed8c2ff147e9bf = [ "sat_cin_zm_vig_fly_sisters_dance", "sat_cin_zm_vig_fly_sisters_chalk_both" ];
    
    foreach ( str_scene in var_aeed8c2ff147e9bf )
    {
        scene::add_scene_func( str_scene, &function_bdfe82a43bd1c0f9, "callback_play" );
    }
    
    s_scene = utility::array_random( var_1fb0e131c89db725 );
    str_scene = utility::array_random( var_aeed8c2ff147e9bf );
    str_shot = undefined;
    twins_spawn_fx = utility::getfx( "rh_sisters_spawn" );
    playfx( twins_spawn_fx, s_scene.origin );
    playworldsound( s_scene.origin + ( 0, 0, 50 ), #"hash_9ec6172ab2934e51" );
    s_scene.script_scenescriptbundle = str_scene;
    s_scene thread scene::play( undefined, str_shot );
    
    /#
        level thread utility::draw_circle( s_scene.origin, 48, ( 0, 1, 0 ), 1, 0, 999 );
    #/
    
    s_scene waittill( #"rh_thanga_foun" );
    wait 5;
    level thread function_cedcdf8845bf51c2();
}

// Namespace zm_sat_firefly_rh
// Params 0
// Checksum 0xc017fe9d, Offset: 0x945
// Size: 0x202
function function_bdfe82a43bd1c0f9()
{
    level endon( #"game_ended" );
    a_ents = scene::get_entities();
    
    foreach ( ent in a_ents )
    {
        ent.var_2fc3a5fb762afb6e = 1;
        ent setscriptablepartstate( "reveal", "reveal_in" );
    }
    
    if ( utility::flag( "rh_thanga_foun" ) )
    {
        return;
    }
    
    trigger = spawn( "trigger_radius", self.origin, 0, 200, 100 );
    
    while ( trigger )
    {
        trigger waittill( #"trigger", player );
        
        if ( isplayer( player ) )
        {
            break;
        }
    }
    
    trigger delete();
    self notify( #"rh_thanga_foun" );
    level utility::flag_set( "rh_thanga_foun" );
    
    foreach ( ent in a_ents )
    {
        ent setscriptablepartstate( "reveal", "reveal_out" );
    }
    
    wait 3;
    scene::stop();
    
    foreach ( ent in a_ents )
    {
        ent delete();
    }
}

// Namespace zm_sat_firefly_rh
// Params 0
// Checksum 0x6ed9642d, Offset: 0xb4f
// Size: 0x1e1
function function_cedcdf8845bf51c2()
{
    s_scene = utility::getstruct( "nail_item_2" );
    str_scene = "sat_cin_zm_vig_fly_sisters_standing";
    str_shot = "idle_holding_hands";
    twins_spawn_fx = utility::getfx( "rh_sisters_spawn" );
    playfx( twins_spawn_fx, s_scene.origin );
    playworldsound( s_scene.origin + ( 0, 0, 50 ), #"hash_9ec6172ab2934e51" );
    s_scene.script_scenescriptbundle = str_scene;
    s_scene thread scene::play( undefined, str_shot );
    
    /#
        level thread utility::draw_circle( s_scene.origin, 48, ( 0, 1, 0 ), 1, 0, 999 );
    #/
    
    level function_4c6fd75a278ee9b8();
    level utility::flag_wait( "rh_box_d" );
    a_ents = s_scene scene::get_entities();
    
    foreach ( ent in a_ents )
    {
        ent setscriptablepartstate( "reveal", "reveal_out" );
    }
    
    wait 3;
    scene::stop();
    
    foreach ( ent in a_ents )
    {
        ent delete();
    }
    
    level thread function_dc6a3d6c30c170f2();
}

// Namespace zm_sat_firefly_rh
// Params 0
// Checksum 0xb2e6cd41, Offset: 0xd38
// Size: 0x281
function function_dc6a3d6c30c170f2()
{
    level utility::flag_wait( "rh_box_beamed" );
    wait 1.25;
    s_scene = utility::getstruct( "nail_item_3" );
    str_scene = "sat_cin_zm_vig_fly_sisters_standing";
    str_shot = "idle_holding_hands";
    twins_spawn_fx = utility::getfx( "rh_sisters_spawn" );
    playfx( twins_spawn_fx, s_scene.origin );
    playworldsound( s_scene.origin + ( 0, 0, 50 ), #"hash_9ec6172ab2934e51" );
    s_scene.script_scenescriptbundle = str_scene;
    s_scene thread scene::play( undefined, str_shot );
    a_ents = s_scene scene::get_entities();
    
    foreach ( ent in a_ents )
    {
        ent.var_2fc3a5fb762afb6e = 1;
        ent utility::function_7c10ea82c1e305b8( "reveal", "invisible" );
        ent setscriptablepartstate( "reveal", "reveal_in" );
    }
    
    /#
        level thread utility::draw_circle( s_scene.origin, 48, ( 0, 1, 0 ), 1, 0, 999 );
    #/
    
    level utility::flag_wait( "rh_thanga_s_com" );
    a_ents = s_scene scene::get_entities();
    
    foreach ( ent in a_ents )
    {
        ent setscriptablepartstate( "reveal", "reveal_out" );
    }
    
    wait 3;
    s_scene scene::stop();
    
    foreach ( ent in a_ents )
    {
        ent delete();
    }
}

// Namespace zm_sat_firefly_rh
// Params 0
// Checksum 0x7b2dd6e1, Offset: 0xfc1
// Size: 0x56
function function_4c6fd75a278ee9b8()
{
    box = zm_rabbithole::spawn_toybox( "coffin_item_1" );
    box utility::function_7c10ea82c1e305b8( "firefly_fx", "on" );
    box thread function_9a79e35e636baacb();
    level thread function_9cac8836c8152ce9( box );
    level.var_76c45cae2094c966[ level.var_76c45cae2094c966.size ] = box;
}

// Namespace zm_sat_firefly_rh
// Params 0
// Checksum 0x90d730b, Offset: 0x101f
// Size: 0x30
function function_9a79e35e636baacb()
{
    level endon( #"game_ended" );
    self endon( #"war_hit" );
    
    while ( true )
    {
        self rotateyaw( 360, 1 );
        wait 1;
    }
}

// Namespace zm_sat_firefly_rh
// Params 1
// Checksum 0xbf1b356d, Offset: 0x1057
// Size: 0x56
function function_9cac8836c8152ce9( box )
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( box.var_3542eed684e39d18 == 1 )
        {
            box notify( #"war_hit" );
            box delete();
            level thread function_7ed949530dc90a38();
            break;
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_firefly_rh
// Params 0
// Checksum 0x30b77df5, Offset: 0x10b5
// Size: 0xdb
function function_7ed949530dc90a38()
{
    level endon( #"game_ended" );
    box = zm_rabbithole::spawn_toybox( "coffin_item_1" );
    box thread function_9a79e35e636baacb();
    box utility::function_7c10ea82c1e305b8( "firefly_fx", "on" );
    waitframe();
    var_4494b157bab23380 = utility::getstruct( "coffin_item_2" );
    var_4494b457bab23a19 = utility::getstruct( "coffin_item_3" );
    wait 0.1;
    box utility::function_8001268940441423( box.origin, var_4494b457bab23a19.origin, var_4494b157bab23380.origin, 1.2, 1, 1 );
    level utility::flag_set( "rh_box_d" );
    level.rh_box = box;
    utility::registersharedfunc( #"dark_flare", #"hash_d3bbf1093b70aec7", &function_feb08b8a4e60b000 );
}

// Namespace zm_sat_firefly_rh
// Params 1
// Checksum 0xa009bd44, Offset: 0x1198
// Size: 0x1a9
function function_feb08b8a4e60b000( potential_enemies )
{
    level endon( #"game_ended" );
    
    foreach ( enemy in potential_enemies )
    {
        if ( isdefined( enemy[ "entity" ] ) )
        {
            if ( issubstr( enemy[ "entity" ].model, "wood::sat_zm_toy_chest_rh_fxanim" ) && !level utility::flag( "rh_box_beamed" ) )
            {
                level utility::flag_set( "rh_box_beamed" );
                wait 1.25;
                
                /#
                    iprintlnbold( "<dev string:x24>" );
                #/
                
                enemy[ "entity" ] utility::function_7c10ea82c1e305b8( "firefly_fx", "ending" );
                var_4494b357bab237e6 = utility::getstruct( "coffin_item_4" );
                enemy[ "entity" ] moveto( var_4494b357bab237e6.origin, 2.7 );
                enemy[ "entity" ] waittill( #"movedone" );
                enemy[ "entity" ] notify( #"war_hit" );
                enemy[ "entity" ] rotateto( var_4494b357bab237e6.angles, 0.2 );
                enemy[ "entity" ] waittill( #"rotatedone" );
                level thread zm_rabbithole::function_b422525417f4cda2();
                enemy[ "entity" ] zm_rabbithole::toybox_open();
                level utility::flag_set( "rh_thanga_s_com" );
                level notify( #"rh_thanga_s_com" );
                break;
            }
        }
    }
}

/#

    // Namespace zm_sat_firefly_rh
    // Params 0, eflags: 0x4
    // Checksum 0x15ee2a26, Offset: 0x1349
    // Size: 0x5, Type: dev
    function private function_5ce64bf98b865f8c()
    {
        
    }

#/

// Namespace zm_sat_firefly_rh
// Params 0
// Checksum 0x346e01e2, Offset: 0x1356
// Size: 0xf9
function spawn_crystals()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "rh_thanga_s_com" );
    a_s_crystals = utility::getstructarray( "lh44_item" );
    a_s_crystals = arrayrandomize( a_s_crystals );
    var_3f6fd3f235ba7ea5 = utility::getstructarray( "lh44_item_anim" );
    level.var_52764d3bff130632 = utility::getstructarray( "cl16_item" );
    level.crystal_interacted = 0;
    
    for ( i = 1; i <= 3 ; i++ )
    {
        s_crystal = utility::array_random( a_s_crystals );
        var_20a60ee4509d97e0 = utility::spawn_model( "t10_zm_phase_crystal_floor_quest_01", s_crystal.origin, s_crystal.angles );
        var_20a60ee4509d97e0 thread function_2a8980844ba5be11( s_crystal, var_3f6fd3f235ba7ea5 );
        s_crystal thread function_f6d3acf86aca8610( var_20a60ee4509d97e0 );
        level.var_76c45cae2094c966[ level.var_76c45cae2094c966.size ] = var_20a60ee4509d97e0;
        a_s_crystals = arrayremove( a_s_crystals, s_crystal );
    }
}

// Namespace zm_sat_firefly_rh
// Params 2
// Checksum 0xd72e54a8, Offset: 0x1457
// Size: 0xb8
function function_2a8980844ba5be11( s_spawn_origin, var_2997ddf126d0c8e1 )
{
    foreach ( var_16af6624858ffa21 in var_2997ddf126d0c8e1 )
    {
        if ( s_spawn_origin.script_noteworthy == var_16af6624858ffa21.script_noteworthy )
        {
            self moveto( var_16af6624858ffa21.origin, 1.4, 0.25, 0.35 );
        }
    }
}

// Namespace zm_sat_firefly_rh
// Params 1
// Checksum 0x3e1b0414, Offset: 0x1517
// Size: 0x1a6
function function_f6d3acf86aca8610( var_d02ad6c664efd3e0 )
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( var_d02ad6c664efd3e0.var_3542eed684e39d18 == 1 )
        {
            var_d02ad6c664efd3e0 delete();
            var_20a60ee4509d97e0 = utility::spawn_model( "t10_zm_phase_crystal_floor_quest_01", self.origin, self.angles );
            
            foreach ( s_fall_loc in level.var_52764d3bff130632 )
            {
                if ( self.script_noteworthy == s_fall_loc.script_noteworthy )
                {
                    var_20a60ee4509d97e0 moveto( s_fall_loc.origin, 0.45 );
                    var_20a60ee4509d97e0 rotateto( s_fall_loc.angles, 0.45 );
                    var_20a60ee4509d97e0 waittill( #"movedone" );
                    var_20a60ee4509d97e0.scr_crystal_fx = spawnscriptable( "sat_firefly_rh_crystal", var_20a60ee4509d97e0.origin, var_20a60ee4509d97e0.angles );
                    var_20a60ee4509d97e0.interact = interaction::register_interact( var_20a60ee4509d97e0.origin + ( 0, 0, 25 ), 60, &spray_crystal, &function_1286743be7f758b6 );
                    var_20a60ee4509d97e0.interact.var_20a60ee4509d97e0 = var_20a60ee4509d97e0;
                    break;
                }
            }
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_firefly_rh
// Params 1
// Checksum 0x9bd072a4, Offset: 0x16c5
// Size: 0x103
function spray_crystal( player )
{
    level endon( #"game_ended" );
    
    if ( isdefined( player ) && player.interactions_disabled )
    {
        return;
    }
    
    if ( !player.var_1659ff9776cdbe24 )
    {
        return;
    }
    
    if ( self.var_20a60ee4509d97e0 utility::ent_flag( "interacted" ) )
    {
        return;
    }
    
    self.var_20a60ee4509d97e0 utility::ent_flag_set( "interacted" );
    self.var_20a60ee4509d97e0.scr_crystal_fx utility::function_7c10ea82c1e305b8( "spray effect", "on" );
    wait 2;
    self.var_20a60ee4509d97e0.scr_crystal_fx utility::function_7c10ea82c1e305b8( "beam", "on" );
    wait 4;
    self.var_20a60ee4509d97e0.scr_crystal_fx utility::function_7c10ea82c1e305b8( "death effect", "lrg" );
    level.crystal_interacted++;
    level thread function_ca35a1721aa52b9b();
    self.var_20a60ee4509d97e0 delete();
    self delete();
}

// Namespace zm_sat_firefly_rh
// Params 2
// Checksum 0xd26f80e9, Offset: 0x17d0
// Size: 0x36
function function_1286743be7f758b6( interact, player )
{
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_firefly_rh
// Params 0
// Checksum 0x9c0fe331, Offset: 0x180f
// Size: 0x1e
function function_ca35a1721aa52b9b()
{
    if ( level.crystal_interacted >= 3 )
    {
        level utility::flag_set( "rh_kal_don" );
    }
}

/#

    // Namespace zm_sat_firefly_rh
    // Params 0, eflags: 0x4
    // Checksum 0x31c35fb9, Offset: 0x1835
    // Size: 0x5, Type: dev
    function private function_95f3117eb4bd2f80()
    {
        
    }

#/

// Namespace zm_sat_firefly_rh
// Params 0, eflags: 0x4
// Checksum 0x7e162739, Offset: 0x1842
// Size: 0x6e
function private function_4f3f711eb132a9a5()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "zm_init_done" );
    level utility::flag_wait( "begin_round_logic" );
    level.rh_meteor_col = getent( "rh_col_rock", #targetname );
    
    if ( !isdefined( level.rh_meteor_col ) )
    {
        return;
    }
    
    level.rh_meteor_col connectpaths();
    level.rh_meteor_col notsolid();
}

// Namespace zm_sat_firefly_rh
// Params 0
// Checksum 0xc48c29e8, Offset: 0x18b8
// Size: 0x2f5
function spawn_asteroid()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "rh_kal_don" );
    
    foreach ( player in level.players )
    {
        player thread function_c473ef2ca3032767( 0.5, 1 );
    }
    
    level.var_53da962cd3dd49de = 1;
    level thread zm_quest::cleanup_zombies_manually( undefined, undefined, undefined, undefined, 1, 1, 1, undefined, 0, undefined, 1 );
    wait 2.5;
    var_cd334f10192877a1 = utility::getstruct( "mt_mo_1", "targetname" );
    var_e4e101ecc68462ee = utility::getstruct( "mt_mo_2", "targetname" );
    mover = utility::spawn_model( "tag_origin", var_cd334f10192877a1.origin, var_cd334f10192877a1.angles );
    level.rh_meteor = spawnscriptable( "sat_firefly_rh_meteor", var_cd334f10192877a1.origin, var_cd334f10192877a1.angles );
    level.rh_meteor scriptablesetparententity( mover );
    mover moveto( var_e4e101ecc68462ee.origin, 2.2 );
    mover waittill( #"movedone" );
    level.rh_meteor setscriptablepartstate( "meteor", "off" );
    level.rh_meteor setscriptablepartstate( "impact", "on" );
    earthquake( 0.7, 2.5, var_e4e101ecc68462ee.origin, 3500 );
    playrumbleonposition( "heavy_1s", var_e4e101ecc68462ee.origin );
    var_e4774bf49b693d97 = utility::spawn_model( "sat_zm_meteor_crystal_03", var_e4e101ecc68462ee.origin, var_e4e101ecc68462ee.angles );
    var_e4774bf49b693d97.interact = interaction::register_interact( var_e4774bf49b693d97.origin + ( 0, 0, 25 ), 60, &spray_rock, &function_a1400a3065ef296f );
    var_e4774bf49b693d97.interact.var_e4774bf49b693d97 = var_e4774bf49b693d97;
    
    if ( isdefined( level.rh_meteor_col ) )
    {
        level.rh_meteor_col disconnectpaths();
        level.rh_meteor_col solid();
    }
    
    wait 2;
    players_near_meteor = zone_manager::get_zone_occupants( zone_manager::function_90e5c3e2272b0130( var_e4e101ecc68462ee.origin ).zone_name );
    level thread overlord::playconversation( #"hash_70cf526498ac4e91", players_near_meteor );
    level thread overlord::playconversation( #"firefly_meteor", arrayremove( level.players, players_near_meteor ) );
    wait 30;
    level.var_53da962cd3dd49de = 0;
}

// Namespace zm_sat_firefly_rh
// Params 1
// Checksum 0x6c35aa1, Offset: 0x1bb5
// Size: 0x16c
function spray_rock( player )
{
    level endon( #"game_ended" );
    
    if ( isdefined( player ) && player.interactions_disabled )
    {
        return;
    }
    
    if ( !player.var_1659ff9776cdbe24 )
    {
        return;
    }
    
    if ( self.var_e4774bf49b693d97 utility::flag( "rh_interacted" ) )
    {
        return;
    }
    
    level utility::flag_set( "rh_interacted" );
    scr_crystal_fx = spawnscriptable( "sat_firefly_rh_crystal", self.var_e4774bf49b693d97.origin + ( 0, -23, 0 ), ( 0, 0, -90 ) );
    scr_crystal_fx utility::function_7c10ea82c1e305b8( "spray effect", "on" );
    wait 2;
    level waittill( #"on_round_end" );
    playworldsound( scr_crystal_fx.origin + ( 0, 0, 25 ), #"hash_d18f6a07c1cc0081" );
    scr_crystal_fx utility::function_7c10ea82c1e305b8( "death effect", "lrg" );
    var_e4e101ecc68462ee = utility::getstruct( "mt_mo_2", "targetname" );
    var_e4774bf49b693d97 = utility::spawn_model( "sat_zm_meteor_crystal_03_broken", var_e4e101ecc68462ee.origin, var_e4e101ecc68462ee.angles );
    level thread delete_meteor_fx();
    level thread spawn_quest_item();
    self.var_e4774bf49b693d97 delete();
    self delete();
}

// Namespace zm_sat_firefly_rh
// Params 2
// Checksum 0xfab2d596, Offset: 0x1d29
// Size: 0x36
function function_a1400a3065ef296f( interact, player )
{
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_firefly_rh
// Params 0
// Checksum 0x811d93cc, Offset: 0x1d68
// Size: 0xb7
function spawn_quest_item()
{
    s_item_loc = utility::getstruct( "mt_item", "targetname" );
    var_5407670c3d5c194d = spawn( "script_model", s_item_loc.origin );
    var_5407670c3d5c194d.angles = s_item_loc.angles;
    var_5407670c3d5c194d setscale( 8 );
    var_5407670c3d5c194d setmodel( "vfx_mgl_crystal_tempest_shard_02_blue_firefly_rh" );
    var_5407670c3d5c194d.interact = interaction::register_interact( s_item_loc.origin + ( 0, 0, 30 ), 80, &pick_up_item, &function_6f54b3e0c81c720b );
    var_5407670c3d5c194d.interact.var_5407670c3d5c194d = var_5407670c3d5c194d;
}

// Namespace zm_sat_firefly_rh
// Params 1
// Checksum 0xf3544e4b, Offset: 0x1e27
// Size: 0x81
function pick_up_item( player )
{
    level utility::flag_set( "rh_it_don" );
    level thread spawn_box_interact();
    level thread overlord::playconversation( hashcat( #"hash_ea699a55361cff50", randomintrange( 1, 4 ) ) );
    playworldsound( self.var_5407670c3d5c194d.origin + ( 0, 0, 25 ), #"hash_d8047720d352b10f" );
    self.var_5407670c3d5c194d delete();
    self delete();
}

// Namespace zm_sat_firefly_rh
// Params 0
// Checksum 0x80dce426, Offset: 0x1eb0
// Size: 0x13
function delete_meteor_fx()
{
    wait 3;
    level.rh_meteor freescriptable();
}

// Namespace zm_sat_firefly_rh
// Params 2
// Checksum 0x33241653, Offset: 0x1ecb
// Size: 0x36
function function_6f54b3e0c81c720b( interact, player )
{
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_firefly_rh
// Params 0
// Checksum 0x7f7466c5, Offset: 0x1f0a
// Size: 0x5c
function spawn_box_interact()
{
    pos = utility::getstruct( "coffin_item_4" );
    box_interact = interaction::register_interact( pos.origin + ( 0, 0, 25 ), 60, &box_interact_func, &box_interact_hint );
    box_interact.pos = pos;
}

// Namespace zm_sat_firefly_rh
// Params 1
// Checksum 0x1b92237e, Offset: 0x1f6e
// Size: 0x4d
function box_interact_func( player )
{
    if ( level utility::flag( "rh_it_don" ) )
    {
        self delete();
        level.rh_box zm_rabbithole::toybox_give_reward( "vfx_mgl_crystal_tempest_shard_02_blue_firefly_rh" );
        wait 1.25;
        level thread overlord::playconversation( #"hash_97a81112c825609a" );
    }
}

// Namespace zm_sat_firefly_rh
// Params 2
// Checksum 0xc3ed1bea, Offset: 0x1fc3
// Size: 0x36
function box_interact_hint( interact, player )
{
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_firefly_rh
// Params 1
// Checksum 0x7b0df4c8, Offset: 0x2002
// Size: 0x14d
function on_exfil_success( params )
{
    if ( level utility::flag( "rh_to_pic" ) )
    {
        level.var_e8b776e9698cb857 = 1;
        event_str = zm_rabbithole::function_85eaee7552aadd2e();
        
        foreach ( player in params.a_exfil_players )
        {
            if ( player.var_e8b776e9698cb857 )
            {
                level utility::callsharedfunc( #"hash_7305513195fadf7e", #"hash_65886d21168e150a", event_str, [ player ] );
                
                if ( player.var_4ad88eeba60b1ac && player.var_1bf107e8638f5574 && player.var_5388587ed7a9f314 && player.var_7fe31db612cd941a && player.var_27501a6cf23a6c06 )
                {
                    level utility::callsharedfunc( #"hash_7305513195fadf7e", #"hash_65886d21168e150a", #"hash_8f4de46115e0d713", [ player ] );
                }
            }
        }
    }
}

// Namespace zm_sat_firefly_rh
// Params 3, eflags: 0x4
// Checksum 0x48b75522, Offset: 0x2157
// Size: 0x4a
function private function_c473ef2ca3032767( fade_out_time, fade_in_time, var_280fc6a5f41ac78 = "white" )
{
    self playsoundtoplayer( "evt_mq_white_out", self );
    hud_util::fade_out( fade_out_time, var_280fc6a5f41ac78 );
    hud_util::fade_in( fade_in_time, var_280fc6a5f41ac78 );
}

/#

    // Namespace zm_sat_firefly_rh
    // Params 0
    // Checksum 0xdf2d0f7, Offset: 0x21a9
    // Size: 0x9c, Type: dev
    function init_firefly_rh_debug()
    {
        devgui::function_9082edeb5db93280( "<dev string:x2f>" );
        devgui::add_devgui_func( "<dev string:x4a>", "<dev string:x4a>", &function_9966ceb4aa685940 );
        devgui::add_devgui_func( "<dev string:x54>", "<dev string:x54>", &function_3bc8b9fa869e4c5c );
        devgui::add_devgui_func( "<dev string:x63>", "<dev string:x63>", &function_644882eacddd8fbd );
        devgui::add_devgui_func( "<dev string:x72>", "<dev string:x72>", &spawn_item );
        devgui::add_devgui_func( "<dev string:x7d>", "<dev string:x7d>", &test_box );
        devgui::add_devgui_func( "<dev string:x86>", "<dev string:x86>", &function_e1dc40ab50f65ca8 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_sat_firefly_rh
    // Params 0
    // Checksum 0x7ad4092e, Offset: 0x224d
    // Size: 0xc, Type: dev
    function function_9966ceb4aa685940()
    {
        function_cedcdf8845bf51c2();
    }

    // Namespace zm_sat_firefly_rh
    // Params 0
    // Checksum 0x7d0ca581, Offset: 0x2261
    // Size: 0x12, Type: dev
    function function_3bc8b9fa869e4c5c()
    {
        level utility::flag_set( "<dev string:x96>" );
    }

    // Namespace zm_sat_firefly_rh
    // Params 0
    // Checksum 0xbf47c988, Offset: 0x227b
    // Size: 0x12, Type: dev
    function function_644882eacddd8fbd()
    {
        level utility::flag_set( "<dev string:xa1>" );
    }

    // Namespace zm_sat_firefly_rh
    // Params 0
    // Checksum 0x8971fff3, Offset: 0x2295
    // Size: 0x6b, Type: dev
    function spawn_item()
    {
        s_item_loc = utility::getstruct( "<dev string:xb1>", "<dev string:xb9>" );
        var_5407670c3d5c194d = spawn( "<dev string:xc4>", s_item_loc.origin );
        var_5407670c3d5c194d.angles = s_item_loc.angles;
        var_5407670c3d5c194d setscale( 8 );
        var_5407670c3d5c194d setmodel( "<dev string:xd1>" );
    }

    // Namespace zm_sat_firefly_rh
    // Params 0
    // Checksum 0x9852a2a8, Offset: 0x2308
    // Size: 0x56, Type: dev
    function test_box()
    {
        box = zm_rabbithole::spawn_toybox( "<dev string:x102>" );
        level.players[ 0 ] setorigin( box.origin + ( 30, 0, 0 ) );
        wait 2;
        box zm_rabbithole::toybox_give_reward( "<dev string:xd1>" );
    }

    // Namespace zm_sat_firefly_rh
    // Params 0, eflags: 0x4
    // Checksum 0x789ba4fb, Offset: 0x2366
    // Size: 0x49, Type: dev
    function private function_e1dc40ab50f65ca8()
    {
        level utility::flag_set( "<dev string:x110>" );
        level thread zm_rabbithole::function_b422525417f4cda2();
        level.rh_box = zm_rabbithole::spawn_toybox( "<dev string:x102>" );
        level thread spawn_box_interact();
        wait 4;
        level.rh_box zm_rabbithole::toybox_open();
    }

#/
