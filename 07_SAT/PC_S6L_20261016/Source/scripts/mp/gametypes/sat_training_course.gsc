// scripts\mp\gametypes\sat_training_course.gsc  (hash_18d7039086efdb01.gscc) (size: 52822 Bytes / 0xce56 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xceb762f3 (3468124915)
// size ...... 52822 (0xce56)
// includes .. 36  (offset: 0xc30a)
// strings ... 145 (offset: 0xc42a)
// dev strs .. 3   (offset: 0xce32)
// exports ... 78  (offset: 0x88ce)
// cseg ...... 0xc4c + 0x7c82 (0x88ce)
// imports ... 322 (offset: 0x94fe)
// animtree1 . 0   (offset: 0xce56)
// animtree2 . 0   (offset: 0xce56)
#using script_16ea1b94f0f381b3;
#using script_3cb3908b3094b567;
#using script_409e412fa44b6c91;
#using script_6bfbb3133de71bd5;
#using scripts\anim\battlechatter;
#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\scene;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\challenges;
#using scripts\mp\common\equipment\support_box;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\perks\perkpackage;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\equipment;
#using scripts\mp\execution;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\meatshield;
#using scripts\mp\mp_dialogue;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outofbounds;
#using scripts\mp\playerlogic;
#using scripts\mp\supers;
#using scripts\mp\training_course_stations;
#using scripts\mp\training_course_utils;

#namespace sat_training_course;

// Namespace sat_training_course
// Params 0
// Checksum 0xfb63afd, Offset: 0xc6a
// Size: 0x7ad
function trainingcourse_init()
{
    /#
        if ( getdvarint( @"hash_cc23353bb35352e", 0 ) == 1 )
        {
            setdevdvar( @"scr_devchangetimelimit", 0 );
        }
    #/
    
    setdvar( @"scr_game_matchstarttime", 0 );
    setdvar( @"scr_game_forceuav", 1 );
    out_of_bounds_time = 2;
    
    /#
        setdvar( @"scr_outofboundstime", out_of_bounds_time );
    #/
    
    level.outofboundstime = out_of_bounds_time;
    setdvar( @"hash_7bdf6d033065ef17", 0 );
    setdvarifuninitialized( @"hash_5bb18d4eb7794e87", 1 );
    setdvarifuninitialized( @"hash_a8d60dcb66f59524", 0 );
    setdvarifuninitialized( @"hash_82feb18c2130951a", 1 );
    setdvarifuninitialized( @"hash_fb237c32ec4de2b9", 1 );
    setdvarifuninitialized( @"hash_49befb9786f9fda", 0 );
    setdvarifuninitialized( @"hash_8e70563bddaf0da", 1 );
    setdvarifuninitialized( @"hash_49ee092bdec92e4e", 1 );
    setdvarifuninitialized( @"hash_cac037f7cbcd9ab4", 1 );
    setdvarifuninitialized( @"hash_8d82e300c99f95b0", 1 );
    setdvarifuninitialized( @"hash_a414be2abcef64ba", 1 );
    setdvar( @"hash_4528e47c441d9c0a", 1 );
    level._effect[ "vfx_muzzle_flash" ] = loadfxasset( "vfx_t10_core_weapons_muz_ar_able18" );
    level._effect[ "vfx_sat_gameplay_flare_traincourse" ] = loadfxasset( "vfx_sat_gameplay_flare_traincourse" );
    level.onplayerconnect = &onplayerconnect;
    level.onplayerdisconnect = &onplayerdisconnect;
    level.modespawnclient = &onplayerrespawn;
    level.endgame = &function_9cc26a2c4cf82d07;
    level.var_5cda5e5f3aa0d6cb = &getwinningteam;
    level.var_bf9f86692b45ce4 = &function_bf9f86692b45ce4;
    level.var_6a8434dc97e87103 = 1;
    function_3160c3f47051cdc3();
    callback::add( #"hash_57a74c8771bf7e7", &function_5e1ae482077473ff );
    level.flag_model = "t10_decor_gunfight_flag_01";
    level.var_c03063b5f4fc2dde = [];
    level.var_2e61ab2b37d9ba6f = [];
    level.world_target_array = [];
    level.bot_pool = [];
    level.var_e104d2f44c811043 = 0;
    level.var_f5062c36d13e920c = 1;
    level.var_b3e7a6423912e4b7 = function_753a55cf69adc665();
    
    /#
        setdvar( @"scr_disable_forfeit", 1 );
    #/
    
    utility::registersharedfunc( #"gametype", #"hash_e5435a50cbd76321", &utility::always_true );
    utility::registersharedfunc( #"killstreak", #"hash_8d28ad2c7f7f7cac", &training_course_utils::killstreak_begin );
    utility::registersharedfunc( #"killstreak", #"hash_f9b3918b698c1d60", &training_course_utils::function_1268491e58be495a );
    utility::registersharedfunc( #"killstreak", #"hash_ce704e5491be04ff", &training_course_utils::function_5fec3b2add1b94e0 );
    utility::registersharedfunc( #"support_box", #"supportboxused", &supportbox_used );
    utility::registersharedfunc( #"support_box", #"supportboxdeleted", &supportbox_deleted );
    utility::registersharedfunc( #"killstreak", #"hash_d5feedce982670dd", &namespace_512cbd6ffc19387::function_e8d6f6d526d3e9d2 );
    utility::registersharedfunc( #"dart_mark_zero", #"disabletargetmarker", &namespace_512cbd6ffc19387::function_e8d6f6d526d3e9d2 );
    
    if ( getdvarint( @"hash_a66238671043ea83", 0 ) )
    {
        utility::registersharedfunc( #"sentry_gun", #"onplaced", &function_fb12393bf40719fa );
        utility::registersharedfunc( #"sentry_gun", #"monitordamage", &function_1ab097e94d229d75 );
    }
    
    callback::add( #"reload_start", &training_course_utils::function_aa4c8736e7957afd );
    
    if ( level.npc_enabled )
    {
        level thread cp01_tent_a_centered_cs::main();
    }
    
    level.super_equipment = !training_course_utils::function_f0999c39797a8308() ? "super_black_hat" : "super_ammo_drop";
    level.var_714c7ea0347def6a = [];
    level.var_67361f68db6dcf34 = [];
    intro_world_event = [];
    intro_world_event[ "instance_1" ] = "Intro_cinematic";
    intro_world_event[ "instance_2" ] = "Intro_cinematic_02";
    intro_world_event[ "instance_3" ] = "Intro_cinematic_03";
    intro_world_event[ "instance_4" ] = "Intro_cinematic_04";
    intro_world_event[ "instance_5" ] = "Intro_cinematic_05";
    intro_world_event[ "instance_6" ] = "Intro_cinematic_06";
    intro_world_event[ "instance_7" ] = "Intro_cinematic_07";
    intro_world_event[ "instance_8" ] = "Intro_cinematic_08";
    intro_world_event[ "instance_9" ] = "Intro_cinematic_09";
    outro_world_event = [];
    outro_world_event[ "instance_1" ] = "Outro_cinematic";
    outro_world_event[ "instance_2" ] = "Outro_cinematic_02";
    outro_world_event[ "instance_3" ] = "Outro_cinematic_03";
    outro_world_event[ "instance_4" ] = "Outro_cinematic_04";
    outro_world_event[ "instance_5" ] = "Outro_cinematic_05";
    outro_world_event[ "instance_6" ] = "Outro_cinematic_06";
    outro_world_event[ "instance_7" ] = "Outro_cinematic_07";
    outro_world_event[ "instance_8" ] = "Outro_cinematic_08";
    outro_world_event[ "instance_9" ] = "Outro_cinematic_09";
    var_afb33f4119b4b3fa = 0;
    var_975b946eeefcaa34 = [];
    
    do
    {
        instance_array = utility::getent_or_struct_array( "instance_" + var_afb33f4119b4b3fa + 1, "script_noteworthy" );
        
        if ( instance_array.size == 0 )
        {
            break;
        }
        
        var_975b946eeefcaa34[ var_975b946eeefcaa34.size ] = instance_array;
        var_afb33f4119b4b3fa++;
    }
    while ( instance_array.size > 0 );
    
    for ( i = 0; i < var_975b946eeefcaa34.size ; i++ )
    {
        instance_array = var_975b946eeefcaa34[ i ];
        var_d664bae99cba4e14 = [];
        
        foreach ( ent in instance_array )
        {
            if ( isdefined( ent.targetname ) && ent.targetname.size > 0 )
            {
                var_d664bae99cba4e14[ ent.targetname ] = ent;
            }
        }
        
        level.var_714c7ea0347def6a[ level.var_714c7ea0347def6a.size ] = var_d664bae99cba4e14;
    }
    
    for ( i = 0; i < var_afb33f4119b4b3fa ; i++ )
    {
        training_course_stations::function_5bda2610dad9e6e9( "meatshield", i, ( -30873.3, -53757.9, 440 ), ( 0, 0, 0 ), ( 1028, 1030, 404 ), ( 164, 1368, 166 ) );
        training_course_stations::function_5bda2610dad9e6e9( "meatshield", i, ( -30288.7, -54181.6, 432.507 ), ( 0, 74, 0 ), ( 1686, 1226, 168 ), ( 94, 748, 192 ) );
        training_course_stations::function_5bda2610dad9e6e9( "meatshield", i, ( -29985, -53306.5, 240.018 ), ( 0, 256, 0 ), ( 1116, 1924, 248 ), ( 254, 952, 424 ) );
        training_course_stations::function_5bda2610dad9e6e9( "meatshield", i, ( -30736.2, -53972.5, 471.119 ), ( 0, 0, 0 ), ( 232, 172, 32 ), ( 300, 182, 104 ) );
        level.var_67361f68db6dcf34[ i ] = 0;
    }
    
    if ( getdvarint( @"hash_a963f82cc98375e8", 1 ) == 1 )
    {
        level.var_5bbfdd7562b793 = &training_afkcheck;
    }
    
    /#
        if ( getdvarint( @"hash_cc23353bb35352e", 0 ) )
        {
            if ( isdefined( level.world_target_array ) && level.world_target_array.size > 0 )
            {
                thread training_course_utils::function_7464143c7de6c610( level.world_target_array[ 0 ] );
            }
        }
    #/
    
    battlechatter::init_battlechatter();
    mp_dialogue::main();
}

// Namespace sat_training_course
// Params 0, eflags: 0x4
// Checksum 0x89913bc2, Offset: 0x141f
// Size: 0x217
function private function_3160c3f47051cdc3()
{
    level.var_f04c44c2cc365ae6 = ( -1043, -1095, 480 );
    level.var_4c27a30d5434547b = 300;
    level.var_9a263f6a24a22e91 = 300;
    level.standing_target_model = "t10_machinery_shooting_target";
    level.fixed_target_model = "ee_military_shooting_range_target_clay_circle";
    level.var_3db0c01d529ca46 = 1;
    level.target_arm_model = "";
    level.target_up_anim_time = 0.3;
    level.var_34ba9885cebac8c8 = 0.2;
    level.var_c05a861787a4b39d = "amb_emt_t10_training_course_target_up";
    level.var_985afc1a619bdf7c = "amb_emt_t10_training_course_target_down";
    level.var_8487ce72cc048693 = "uin_t10_training_course_target_success";
    level.var_4304404996b50194 = "uin_t10_training_course_target_fail";
    level.loadout_array = [];
    level.loadout_array[ "primary" ] = "sat_ar_hawk_mp";
    level.loadout_array[ "primary_attachments" ] = "";
    level.loadout_array[ "secondary" ] = "sat_pi_timir_mp";
    level.loadout_array[ "secondary_attachments" ] = "";
    level.loadout_array[ "melee" ] = "sat_me_shockbaton_mp";
    level.loadout_array[ "lethal" ] = "equip_dart_mark_zero";
    level.loadout_array[ "tactical_mp" ] = "equip_sensor_grenade";
    level.loadout_array[ "tactical_br" ] = "equip_concussion";
    level.loadout_array[ "super_mp" ] = "super_black_hat";
    level.loadout_array[ "super_mp" ] = "super_ammo_drop";
    level.br_tactical_equipment = "equip_concussion";
    level.melee_weapon_name = "sat_me_shockbaton_mp";
    level.npc_enabled = getdvarint( @"hash_49befb9786f9fda" );
    level.var_9b65db225ac25b95 = getdvarint( @"hash_5bb18d4eb7794e87" );
    level.player_operator = %"sat_ind_pl_violet";
    level.player_operator_skin = %"sat_ind_pl_violet_proto_skin";
    level.var_37f10e1572a7803b = getdvarint( @"hash_8e70563bddaf0da" );
}

// Namespace sat_training_course
// Params 0, eflags: 0x4
// Checksum 0xd5a0c953, Offset: 0x163e
// Size: 0x90
function private function_753a55cf69adc665()
{
    order_array = [];
    
    if ( getdvarint( @"hash_fb237c32ec4de2b9" ) )
    {
        order_array[ order_array.size ] = 0;
        order_array[ order_array.size ] = 1;
    }
    
    if ( getdvarint( @"hash_cac037f7cbcd9ab4" ) )
    {
        order_array[ order_array.size ] = 2;
    }
    
    if ( getdvarint( @"hash_49ee092bdec92e4e" ) )
    {
        order_array[ order_array.size ] = 3;
    }
    
    if ( getdvarint( @"hash_82feb18c2130951a" ) )
    {
        order_array[ order_array.size ] = 4;
    }
    
    if ( getdvarint( @"hash_8e70563bddaf0da" ) )
    {
        order_array[ order_array.size ] = 5;
    }
    
    return order_array;
}

// Namespace sat_training_course
// Params 0, eflags: 0x4
// Checksum 0x852d8e17, Offset: 0x16d7
// Size: 0x10
function private shouldspawnbots()
{
    return getdvarint( @"online_is_devmapping", 0 );
}

// Namespace sat_training_course
// Params 1, eflags: 0x4
// Checksum 0x3c93cb51, Offset: 0x16f0
// Size: 0x61
function private function_92dd64e788a3774e( player )
{
    player endon( #"disconnect" );
    
    while ( true )
    {
        player waittill( #"luinotifyserver", msg, value );
        
        if ( msg == "versus_done" )
        {
            player utility::ent_flag_set( "loading_over" );
            break;
        }
    }
}

// Namespace sat_training_course
// Params 1, eflags: 0x4
// Checksum 0xaa34eb49, Offset: 0x1759
// Size: 0x5d6
function private onplayerconnect( player )
{
    player endon( #"disconnect" );
    
    if ( !isbot( player ) )
    {
        thread function_92dd64e788a3774e( player );
        thread training_course_utils::function_95583a45b8caaba9( player );
    }
    
    player waittill( #"spawned" );
    
    if ( isbot( player ) )
    {
        if ( training_course_utils::function_f0999c39797a8308() )
        {
            player.sessionuimemberindex = 1;
        }
        
        botplayerconnect( player );
        return;
    }
    
    player function_a565dafac620d68e( %"hw_cer_trainingcourse" );
    teams::removeplayerfromteam( player, player.team );
    teams::addplayertoteam( player, "allies" );
    player.disablepingvo = 1;
    player.var_968376be0223dc14 = 1;
    player.skin_on_respawn = training_course_utils::function_224cad2522f7a2c2();
    
    for ( i = 0; i < level.var_67361f68db6dcf34.size ; i++ )
    {
        if ( level.var_67361f68db6dcf34[ i ] == 0 )
        {
            player.map_instance_index = i;
            level.var_67361f68db6dcf34[ i ] = 1;
            break;
        }
    }
    
    assert( isdefined( player.map_instance_index ), "<dev string:x24>" );
    player.training_course_completed = 0;
    player.var_c9f47db434eca171 = 0;
    player.training_course_completed_vo_played = 0;
    player.tutorial_dictionary = [];
    player.registered_triggers = [];
    player.var_80e907d847fdb68c = [];
    [ player.first_spawn_origin, player.first_spawn_angles ] = training_course_utils::function_52ff81cfdbb3f234( ( 2533, 649, 184 ), ( 0, -135, 0 ), player.map_instance_index );
    player utility::player_prestream_camera( player.first_spawn_origin );
    player.var_bb4f4ac000751f63 = 0;
    marker = gameobjects::createobjidobject( ( 0, 0, 0 ), "neutral", ( 0, 0, 0 ), undefined, "any", 1, "icon_medium" );
    objidpoolmanager::update_objective_icon( marker.objidnum, "sat_ui_icon_waypoint_training_objective" );
    objidpoolmanager::update_objective_setbackground( marker.objidnum, training_course_utils::function_fb000aeabac687eb() );
    objidpoolmanager::function_373aaf492aabde6f( marker.objidnum, 0, 0, 0, 1 );
    objidpoolmanager::function_de3fb937d4f45f38( marker.objidnum, 150, 75 );
    objidpoolmanager::objective_set_play_intro( marker.objidnum, 0 );
    objidpoolmanager::objective_set_play_outro( marker.objidnum, 0 );
    training_course_utils::hideobjectivemarker( marker );
    player.global_objective_marker = marker;
    walljump_marker = gameobjects::createobjidobject( ( 0, 0, 0 ), "neutral", ( 0, 0, 0 ), undefined, "any", 1, "icon_medium" );
    objidpoolmanager::update_objective_icon( walljump_marker.objidnum, "sat_ui_icon_waypoint_training_walljump" );
    objidpoolmanager::update_objective_setbackground( walljump_marker.objidnum, training_course_utils::function_fb000aeabac687eb() );
    objidpoolmanager::function_373aaf492aabde6f( walljump_marker.objidnum, 0, 0, 0, 1 );
    objidpoolmanager::function_de3fb937d4f45f38( walljump_marker.objidnum, 150, 75 );
    objidpoolmanager::objective_set_play_intro( walljump_marker.objidnum, 0 );
    objidpoolmanager::objective_set_play_outro( walljump_marker.objidnum, 0 );
    training_course_utils::hideobjectivemarker( walljump_marker );
    player.walljump_marker = walljump_marker;
    createtutorials( player );
    player utility::ent_flag_set( "training_course_tutorials_created" );
    training_course_stations::function_89df6b3aced6d8cd( player );
    training_course_stations::function_89df6b3aced6d8cd( player );
    
    if ( shouldspawnbots() )
    {
        thread function_3dd874a3e7acaa50( player.map_instance_index );
    }
    
    thread training_course_utils::luinotifylistener( player );
    player utility::ent_flag_wait( "player_active" );
    
    /#
        thread training_course_stations::function_833acbbe64353915();
        thread training_course_stations::function_893ed490f765fc47();
        
        if ( getdvarint( @"hash_cc23353bb35352e", 0 ) == 1 )
        {
            thread training_course_utils::function_347c90461fb33c06( player );
        }
    #/
    
    thread training_course_stations::function_fb78e7c7ad8e2157( player );
    [ npc_origin, npc_angles ] = training_course_utils::function_52ff81cfdbb3f234( ( -30411, -57290, 272 ), ( 0, 50, 0 ), player.map_instance_index );
    
    if ( level.npc_enabled )
    {
        player.npc_agent = namespace_512cbd6ffc19387::spawnnpc( player, npc_origin, npc_angles );
    }
    else
    {
        player.npc_agent = spawn( "script_origin", npc_origin );
        player.npc_agent.angles = npc_angles;
    }
    
    player.npc_agent.vo_audience = player;
    player.script_animname = "Player 1";
    setglobalsoundcontext( "gametype", "training_course" );
    
    if ( level.npc_enabled )
    {
        if ( training_course_utils::function_1c1d2c09775c2bea() )
        {
            thread namespace_9d8e359c3b1041e5::fadetoblackforplayersharedfunc( player, 1, 0 );
            player utility::ent_flag_wait( "loading_over" );
            thread training_course_utils::function_61061c166ccecf71( player, player.npc_agent, training_course_utils::function_7b785364ecb1775c( player.map_instance_index ) );
        }
        else
        {
            training_course_utils::function_acd7b230b1df93c1( player.map_instance_index ) thread training_course_utils::function_904e69c6ea7095f1( player.npc_agent, 0 );
        }
    }
    
    player utility::ent_flag_wait( "loading_over" );
    thread training_course_utils::function_e79357e1bec9adad( player.npc_agent, [ "dx_mp_mptc_mptcstartln1_smta", "dx_mp_mptc_mptcstartln2_smta", "dx_mp_mptc_mptcstartln3_smta" ], 0, 2, 0.5 );
}

// Namespace sat_training_course
// Params 1, eflags: 0x4
// Checksum 0x608fe9e3, Offset: 0x1d37
// Size: 0x4e, Type: bool
function private function_5e1ae482077473ff( params )
{
    if ( training_course_utils::function_faa438d8de9a4dc9( self ) || training_course_stations::function_abaed5b5b01f5e28( self.current_tutorial ) || self.var_a7207ed3c6b7e0b6 || self.var_c9f47db434eca171 )
    {
        playerlogic::playerhasmoved();
        return true;
    }
    
    return false;
}

// Namespace sat_training_course
// Params 0, eflags: 0x4
// Checksum 0xc8d9feb2, Offset: 0x1d8e
// Size: 0x173
function private training_afkcheck()
{
    if ( mp_afk::dontconsiderafk() )
    {
        mp_afk::function_a710eba86b2e3782( self, "default", 0, 0 );
        return;
    }
    
    if ( !isdefined( self.pers[ "timePlayedOnFirstSpawn" ] ) )
    {
        return;
    }
    
    afkstate = 0;
    afkmaxtime = level.afkthresholds.var_f21903a24e3d5816;
    var_2c85c490d93da8ef = level.var_4dd914bb587df856;
    afkreason = "default";
    
    if ( self iscommandinputstale() && self.sessionstate == "playing" )
    {
        afkstate = 2;
        afkreason = "training_afkCheck() TRUE, IsCommandInputStale() - " + self.name;
        mp_afk::function_a710eba86b2e3782( self, afkreason, afkstate, level.afkthresholds.var_66603405b103d2da );
        return;
    }
    
    if ( self iscommandinputrepetitive() )
    {
        afkstate = 2;
        afkreason = "training_afkCheck() TRUE, IsCommandInputRepetitive() - " + self.name;
        mp_afk::function_a710eba86b2e3782( self, afkreason, afkstate, level.afkthresholds.var_66603405b103d2da );
        return;
    }
    
    lastdisttrackingpassedtime = self.pers[ "distTrackingPassedOrResetTime" ] ?? 0;
    timesincelastpasseddistcheck = mp_afk::function_a10af3f5e26c28da() - lastdisttrackingpassedtime;
    afkstate = mp_afk::function_3a77ec8a437459f( timesincelastpasseddistcheck, afkmaxtime, var_2c85c490d93da8ef );
    
    if ( afkstate == 2 )
    {
        afkreason = "training_afkCheck() TRUE, getAFKCheckState() " + timesincelastpasseddistcheck;
    }
    
    mp_afk::function_a710eba86b2e3782( self, afkreason, afkstate, level.afkthresholds.var_66603405b103d2da );
}

// Namespace sat_training_course
// Params 1, eflags: 0x4
// Checksum 0x5178cc17, Offset: 0x1f09
// Size: 0x211
function private botplayerconnect( bot )
{
    if ( !isbot( bot ) )
    {
        return;
    }
    
    if ( !isdefined( level.bot_pool[ level.var_e104d2f44c811043 ] ) )
    {
        level.bot_pool[ level.var_e104d2f44c811043 ] = [];
    }
    
    current_pool_size = level.bot_pool[ level.var_e104d2f44c811043 ].size;
    level.bot_pool[ level.var_e104d2f44c811043 ][ current_pool_size ] = bot;
    current_pool_size = level.bot_pool[ level.var_e104d2f44c811043 ].size;
    
    switch ( current_pool_size - 1 )
    {
        case 0:
            bot.first_spawn_origin = training_course_utils::function_d58310d0f1d16d43( level.var_f04c44c2cc365ae6, level.var_e104d2f44c811043 );
            bot.skin_on_respawn = training_course_utils::function_224cad2522f7a2c2();
            break;
        case 1:
            bot.first_spawn_origin = training_course_utils::function_d58310d0f1d16d43( ( -1043, -1095, 480 ), level.var_e104d2f44c811043 );
            bot.skin_on_respawn = %"sat_usa_training_course_bot_base_skin";
            bot.purpose = "meatshield";
            break;
        case 2:
            bot.first_spawn_origin = training_course_utils::function_d58310d0f1d16d43( ( -1043, -1095, 480 ), level.var_e104d2f44c811043 );
            bot.skin_on_respawn = %"sat_usa_training_course_bot_base_skin";
            bot.purpose = "execution";
            break;
        default:
            break;
    }
    
    bot.map_instance_index = level.var_e104d2f44c811043;
    bot.first_spawn_angles = ( 0, 90, 0 );
    bot playerhide();
    training_course_utils::function_f84dc38c3e66bb65( bot );
    var_d7a03fd5431c6962 = function_ba1324c1fe3aa6c6();
    
    if ( var_d7a03fd5431c6962 != 0 && current_pool_size % var_d7a03fd5431c6962 == 0 )
    {
        level.var_e104d2f44c811043++;
    }
}

// Namespace sat_training_course
// Params 1, eflags: 0x4
// Checksum 0x39514389, Offset: 0x2122
// Size: 0x4de
function private onplayerdisconnect( player )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( isbot( player ) )
    {
        return;
    }
    
    player training_course_utils::function_ae1b81443a485a25( 0, 1 );
    namespace_512cbd6ffc19387::function_c06c98d7da9ead59( player );
    player function_72cf2eee8e035013( %"hw_cer_trainingcourse" );
    
    foreach ( tutorial in player.tutorial_dictionary )
    {
        training_course_stations::deletetutorial( player, tutorial, 1 );
    }
    
    all_agents = getaiarray();
    
    if ( !gamelogic_mp::function_45db3a140da5f4b1( player ) && all_agents && all_agents.size > 0 )
    {
        foreach ( agent in all_agents )
        {
            namespace_512cbd6ffc19387::despawnagent( agent );
        }
    }
    
    player.tutorial_dictionary = undefined;
    player.var_80e907d847fdb68c = undefined;
    
    foreach ( trigger in player.registered_triggers )
    {
        if ( isdefined( trigger ) )
        {
            trigger delete();
        }
    }
    
    player.registered_triggers = undefined;
    
    if ( isdefined( player.global_objective_marker ) )
    {
        objidpoolmanager::returnobjectiveid( player.global_objective_marker.objidnum );
        player.global_objective_marker = undefined;
    }
    
    if ( isdefined( player.walljump_marker ) )
    {
        objidpoolmanager::returnobjectiveid( player.walljump_marker.objidnum );
        player.walljump_marker = undefined;
    }
    
    if ( isdefined( player.leave_training_course_interactable ) )
    {
        player.leave_training_course_interactable delete();
        player.leave_training_course_interactable = undefined;
    }
    
    if ( isdefined( player.npc_agent ) )
    {
        if ( isdefined( player.npc_agent.var_31a461ef76afc85b ) && isdefined( player.map_instance_index ) )
        {
            training_course_utils::function_b6d7c2e57831f94d( player.npc_agent.var_31a461ef76afc85b, player.map_instance_index );
        }
        
        if ( isdefined( player.npc_agent.wheelchair ) )
        {
            player.npc_agent.wheelchair delete();
        }
        
        if ( isdefined( player.npc_agent.var_5c11ace5ae14ad8 ) )
        {
            player.npc_agent.var_5c11ace5ae14ad8 delete();
        }
        
        player.npc_agent delete();
        player.npc_agent = undefined;
    }
    
    if ( isdefined( player.map_instance_index ) )
    {
        level.var_67361f68db6dcf34[ player.map_instance_index ] = 0;
        bots = training_course_utils::function_8658dfb45f6b84c8( player.map_instance_index );
        
        foreach ( bot in bots )
        {
            if ( isdefined( bot ) )
            {
                bot setorigin( bot.first_spawn_origin );
                training_course_utils::function_f84dc38c3e66bb65( bot );
                bot playerhide();
            }
        }
        
        ent_map_array = level.var_714c7ea0347def6a[ player.map_instance_index ];
        
        if ( isdefined( ent_map_array[ "scene_struct_array" ] ) )
        {
            foreach ( scene_struct in ent_map_array[ "scene_struct_array" ] )
            {
                scene_struct scene::cleanup( 1 );
            }
        }
    }
}

// Namespace sat_training_course
// Params 3, eflags: 0x4
// Checksum 0x8d4187b5, Offset: 0x2608
// Size: 0x17d
function private function_9cc26a2c4cf82d07( winner, endreasontext, nukedetonated )
{
    winner = getwinningteam( winner );
    
    foreach ( player in level.players )
    {
        player training_course_utils::function_ae1b81443a485a25( 0, 1 );
    }
    
    if ( !game_utility_mp::matchmakinggame() )
    {
        var_c146bd9b0929cc58 = undefined;
        
        foreach ( player in level.players )
        {
            if ( !isbot( player ) )
            {
                var_c146bd9b0929cc58 = player;
                break;
            }
        }
        
        if ( isdefined( var_c146bd9b0929cc58 ) && training_course_utils::function_d39dfc7ac04716ef( var_c146bd9b0929cc58 ) )
        {
            training_course_utils::function_816ecee4d7db0c68( var_c146bd9b0929cc58, training_course_utils::function_d18dd74017e9db87( var_c146bd9b0929cc58.map_instance_index ), 0 );
            level notify( #"exitlevel_called" );
            exitlevel( 0 );
            return;
        }
    }
    
    gamelogic_mp::endgame_regularmp( winner, endreasontext, undefined, undefined, undefined );
}

// Namespace sat_training_course
// Params 1, eflags: 0x4
// Checksum 0x22d1d89c, Offset: 0x278d
// Size: 0xf8
function private getwinningteam( current_winner )
{
    if ( !game_utility_mp::matchmakinggame() && isdefined( level.players[ 0 ].tutorial_dictionary ) )
    {
        var_4e0fc2dbd25cba8b = 1;
        
        foreach ( tutorial in level.players[ 0 ].tutorial_dictionary )
        {
            if ( !training_course_stations::function_faefa119842f585b( tutorial ) )
            {
                var_4e0fc2dbd25cba8b = 0;
                break;
            }
        }
        
        if ( var_4e0fc2dbd25cba8b && isdefined( level.players[ 0 ] ) )
        {
            current_winner = level.players[ 0 ].team;
        }
    }
    
    return current_winner;
}

// Namespace sat_training_course
// Params 1, eflags: 0x4
// Checksum 0xc567c613, Offset: 0x288e
// Size: 0x18
function private function_ff3e3429587d5f3b( value )
{
    utility::ent_flag_set( "training_course_hud_ready" );
}

// Namespace sat_training_course
// Params 1, eflags: 0x4
// Checksum 0x91e6fb72, Offset: 0x28ae
// Size: 0xef
function private function_3dd874a3e7acaa50( map_instance_index )
{
    level endon( #"game_ended" );
    
    if ( level.var_9b65db225ac25b95 )
    {
        preview_bot_position = training_course_utils::function_d58310d0f1d16d43( level.var_f04c44c2cc365ae6, map_instance_index );
        training_course_utils::spawnbot( preview_bot_position, ( 0, 0, 0 ), "allies", "" );
    }
    
    if ( getdvarint( @"hash_82feb18c2130951a" ) )
    {
        meatshield_bot_position = training_course_utils::function_d58310d0f1d16d43( ( -1043, -1095, 480 ), map_instance_index );
        training_course_utils::spawnbot( meatshield_bot_position, ( 0, 0, 0 ), "axis", "meatshield" );
        execution_bot_position = training_course_utils::function_d58310d0f1d16d43( ( -1043, -1095, 480 ), map_instance_index );
        training_course_utils::spawnbot( execution_bot_position, ( 0, 0, 0 ), "axis", "execution" );
    }
}

// Namespace sat_training_course
// Params 0, eflags: 0x4
// Checksum 0x4d615150, Offset: 0x29a5
// Size: 0x37
function private function_ba1324c1fe3aa6c6()
{
    var_6912e11add540d80 = 0;
    
    if ( level.var_9b65db225ac25b95 )
    {
        var_6912e11add540d80++;
    }
    
    if ( getdvarint( @"hash_82feb18c2130951a" ) )
    {
        var_6912e11add540d80 += 2;
    }
    
    return var_6912e11add540d80;
}

// Namespace sat_training_course
// Params 1, eflags: 0x4
// Checksum 0xbbcc08f8, Offset: 0x29e5
// Size: 0x5e0
function private createtutorials( player )
{
    if ( getdvarint( @"hash_fb237c32ec4de2b9" ) )
    {
        basic_movement_tutorial = training_course_stations::createtutorial( player, "basic_movement", 0, 2, 0, &function_c0b7d169e34f2418, &function_453ce916fba291a1, undefined, undefined, &function_36f64d6bee634a9, undefined, undefined, undefined, ( 2461, 510, 184 ), ( 0, -123, 0 ), 1, 1, 2, ( 2429, 479, 184 ), 0.5, 0.5, 0.3 );
        basic_movement_tutorial.var_47eb83743fd1597 = [ "dx_mp_mptc_mptcstation1start_smta" ];
        basic_movement_tutorial.var_8c2623b27b71c6bd = [ "dx_mp_mptc_mptcobjfailed_smta" ];
        basic_movement_tutorial.var_366e9014d86d580a = [ "dx_mp_mptc_mptcobjgenscs_smta" ];
        basic_movement_tutorial.var_6caae9f87149260b = [ "dx_mp_mptc_mptcobjgenscs_smta" ];
        basic_equipment_tutorial = training_course_stations::createtutorial( player, "basic_equipment", 1, 2, 0, &function_1399331f1092d5fd, &function_436c4b277d74899c, undefined, &function_ac3d22891fdad690, &function_c986e0685a1ba96, undefined, undefined, undefined, ( 1127, -743, 192 ), ( 0, 15, 0 ), 1, 1, 2, ( 1181, -723, 192 ), 0.7, 0.7, 0.3 );
        basic_equipment_tutorial.var_47eb83743fd1597 = [ "dx_mp_mptc_mptcstation2start_smta" ];
        basic_equipment_tutorial.var_8c2623b27b71c6bd = [ "dx_mp_mptc_mptcobjfailed_smta" ];
        basic_equipment_tutorial.var_366e9014d86d580a = [ "dx_mp_mptc_mptcobjgenscs_smta" ];
        basic_equipment_tutorial.var_6caae9f87149260b = [ "dx_mp_mptc_mptcobjgenscs_smta" ];
        basic_equipment_tutorial.var_85a7b95bc3de3767 = &function_3ac947bc433d7e3c;
    }
    
    if ( getdvarint( @"hash_cac037f7cbcd9ab4" ) )
    {
        advanced_movement_tutorial = training_course_stations::createtutorial( player, "advanced_movement", 2, 2, 1, &function_6a5f62ce088d2268, &function_a7c669b3762337b1, undefined, undefined, &function_c8fc42ecd7aa6c99, &function_fd8d0430d14eb45e, &function_bc21359b5f91f4d9, &function_33bb5547073b6108, ( 1355, -299, 192 ), ( 0, 170, 0 ), 1, 1, 2, ( 1052, -297, 192 ), 0.5, 0.5, 0.3 );
        advanced_movement_tutorial.var_47eb83743fd1597 = [ "dx_mp_mptc_mptcstation3start_smta" ];
        advanced_movement_tutorial.var_8c2623b27b71c6bd = [ "dx_mp_mptc_mptcobjfailed_smta" ];
        advanced_movement_tutorial.var_366e9014d86d580a = [ "dx_mp_mptc_mptcobjgenscs_smta" ];
        advanced_movement_tutorial.var_6caae9f87149260b = [ "dx_mp_mptc_mptcobjgenscs_smta" ];
    }
    
    if ( getdvarint( @"hash_8e70563bddaf0da" ) )
    {
        emote_tutorial = training_course_stations::createtutorial( player, "emote", 5, 2, 0, &function_a76af4aa2bc4b71f, &function_6573c78f12412c4a, undefined, undefined, &function_2bea643b5dba5bdc, undefined, undefined, undefined, ( -984, -1195, 256 ), ( 0, 10, 0 ), 1, 1, 2, ( -964, -1189, 256 ), 0.5, 0.5, 0.3 );
        emote_tutorial.var_47eb83743fd1597 = [ "dx_mp_mptc_mptcstation6start_smta" ];
        training_course_stations::function_bfa865dfd7b9bfd6( player, emote_tutorial, 1 );
    }
    
    if ( getdvarint( @"hash_49ee092bdec92e4e" ) )
    {
        omnisprint_tutorial = training_course_stations::createtutorial( player, "omnisprint", 3, 2, 1, &function_3b9c0f927794c87e, &function_8a06fe6b22498dfb, undefined, &function_f29dca2569af28dd, &function_3d90c6080a706c4b, &function_dd501c559d7a599c, &function_d15857606b573383, &function_eb0c268de30341c2, ( -1294, -406, 192 ), ( 0, 190, 0 ), 1, 1, 2, ( -1435, -414, 192 ), 0.5, 0.5, 0.3 );
        omnisprint_tutorial.var_47eb83743fd1597 = [ "dx_mp_mptc_mptcstation4start_smta" ];
        omnisprint_tutorial.var_8c2623b27b71c6bd = [ "dx_mp_mptc_mptcobjfailed_smta" ];
        omnisprint_tutorial.var_366e9014d86d580a = [ "dx_mp_mptc_mptcobjgenscs_smta" ];
        omnisprint_tutorial.var_6caae9f87149260b = [ "dx_mp_mptc_mptcobjgenscs_smta" ];
    }
    
    if ( getdvarint( @"meatshield_enabled" ) == 1 && getdvarint( @"hash_82feb18c2130951a" ) )
    {
        meatshield_tutorial = training_course_stations::createtutorial( player, "meatshield", 4, 2, 1, &function_eb3ea60bb4e2122d, &function_eef95cf422ee90cc, &function_7b0997d222bd6ed4, undefined, &function_543c2f2f36cba326, &function_ba41b7a10219ef3b, &function_7d1d9a69f497ce3e, &function_13e58d96d5b1042f, ( -1810, -1344, 256 ), ( 0, 350, 0 ), 1, 1, 2, ( -1832, -1212, 256 ), 0.5, 0.5, 0 );
        meatshield_tutorial.var_47eb83743fd1597 = [ "dx_mp_mptc_mptcstation5start_smta" ];
        meatshield_tutorial.var_8c2623b27b71c6bd = [ "dx_mp_mptc_mptcobjfailed_smta" ];
        meatshield_tutorial.var_366e9014d86d580a = [ "dx_mp_mptc_mptcobjgenscs_smta" ];
        meatshield_tutorial.var_6caae9f87149260b = [ "dx_mp_mptc_mptcobjgenscs_smta" ];
        meatshield_tutorial.var_e7e7977f1d016e4c = getdvarfloat( @"hash_a414be2abcef64ba", 1 );
    }
    
    tutorial_array = [];
    
    foreach ( tutorial in player.tutorial_dictionary )
    {
        tutorial_array[ tutorial_array.size ] = tutorial;
    }
    
    player.var_80e907d847fdb68c = arraysort( tutorial_array, undefined, &training_course_utils::function_c25960b107824fa7 );
    
    /#
        training_course_utils::initdevgui( player.tutorial_dictionary );
    #/
}

// Namespace sat_training_course
// Params 1, eflags: 0x4
// Checksum 0xa4b6c469, Offset: 0x2fcd
// Size: 0x28e
function private onplayerrespawn( reviverespawn )
{
    player = self;
    thread training_course_utils::giveloadoutonspawn( player );
    var_b138c7c63944889f = !isbot( player ) || training_course_stations::function_abaed5b5b01f5e28( player.current_tutorial );
    
    if ( var_b138c7c63944889f && training_course_stations::function_cbcead310c3cf8bd( player.current_tutorial ) )
    {
        wait player.current_tutorial.respawn_delay;
        
        if ( player.current_tutorial.fail_state == 1 )
        {
            thread training_course_stations::exittutorial( player, player.current_tutorial, 1, &function_bf9f86692b45ce4 );
        }
        else
        {
            is_fail_state_spectate = player.current_tutorial.fail_state == 0;
            thread training_course_stations::restarttutorial( isbot( player ) ? player.spectating_player : player, player.current_tutorial, is_fail_state_spectate, player.current_tutorial.fail_state == 2 || isbot( player ), 1, !is_fail_state_spectate && !isbot( player ) ? &function_bf9f86692b45ce4 : undefined );
            
            if ( isbot( player ) )
            {
                player playerlogic::spawnplayer( undefined, 0 );
            }
        }
        
        player.current_tutorial.fail_state = -1;
    }
    else
    {
        player playerlogic::spawnplayer( undefined, 0 );
        
        if ( !player.var_dc692e41504a9076 )
        {
            thread function_ddbdcc7435c44319( player, player.first_spawn_origin, player.first_spawn_angles );
            player.var_dc692e41504a9076 = 1;
        }
        else if ( isbot( player ) )
        {
            player setorigin( player.first_spawn_origin );
            training_course_utils::function_f84dc38c3e66bb65( player );
            player playerhide();
        }
        else if ( player.current_tutorial )
        {
            player setorigin( player.current_tutorial.respawn_position );
            player setplayerangles( player.current_tutorial.respawn_angles );
        }
        
        if ( isdefined( player.skin_on_respawn ) )
        {
            training_course_utils::setplayerviewmodel( player, level.player_operator, player.skin_on_respawn );
        }
        
        if ( !isbot( player ) )
        {
            namespace_512cbd6ffc19387::function_c06c98d7da9ead59( player );
        }
    }
    
    if ( !isbot( player ) )
    {
        thread training_course_stations::function_fb78e7c7ad8e2157( player );
    }
    
    player function_16332a7775f10aa9();
    player player::function_e4f77222086e66b( 1 );
}

// Namespace sat_training_course
// Params 3, eflags: 0x4
// Checksum 0xd77b9d85, Offset: 0x3263
// Size: 0x5a
function private function_ddbdcc7435c44319( player, origin, angles )
{
    player endon( #"death_or_disconnect" );
    wait 0.5;
    player setorigin( origin );
    player setplayerangles( angles );
    
    if ( isbot( player ) )
    {
        training_course_utils::function_f84dc38c3e66bb65( player );
        player playerhide();
    }
}

// Namespace sat_training_course
// Params 2, eflags: 0x4
// Checksum 0xa69ae24c, Offset: 0x32c5
// Size: 0x75
function private function_bf9f86692b45ce4( player, tutorial )
{
    assert( isdefined( tutorial ), "<dev string:x51>" );
    player playerlogic::spawnplayer( undefined, 0 );
    player player::function_e4f77222086e66b( 1 );
    player freezecontrols( 1 );
    training_course_utils::function_3f46a4fd28a17454( player, tutorial );
    player setorigin( tutorial.respawn_position );
    player setplayerangles( tutorial.respawn_angles );
}

// Namespace sat_training_course
// Params 3, eflags: 0x4
// Checksum 0xcaeed69b, Offset: 0x3342
// Size: 0x9b
function private trainingcourse_watchforplayerdeath( player, tutorial, var_b0168b4849ac579b )
{
    player notify( #"section_ended" );
    player endon( #"tutorial_changed" );
    player endon( #"section_ended" );
    player endon( #"disconnect" );
    player waittill( #"death", attacker );
    var_e1f0ee5f702d4e4f = isdefined( attacker ) && ( isagent( attacker ) || isbot( attacker ) );
    player training_course_stations::failtutorial( player, tutorial, var_e1f0ee5f702d4e4f, var_b0168b4849ac579b );
}

// Namespace sat_training_course
// Params 2, eflags: 0x4
// Checksum 0x14f17a7e, Offset: 0x33e5
// Size: 0x30
function private function_275e97f81427089d( tutorial, player )
{
    return training_course_stations::function_abaed5b5b01f5e28( tutorial ) ? player.spectating_player : player;
}

// Namespace sat_training_course
// Params 2, eflags: 0x4
// Checksum 0x4612e32c, Offset: 0x341e
// Size: 0x5a
function private function_3b9c0f927794c87e( player, tutorial )
{
    namespace_512cbd6ffc19387::function_bdd8b3c85cece6b4( player.map_instance_index, "omnisprint_target" );
    namespace_512cbd6ffc19387::function_bdd8b3c85cece6b4( player.map_instance_index, "prone_target" );
    tutorial.instance = player.map_instance_index;
}

// Namespace sat_training_course
// Params 2, eflags: 0x4
// Checksum 0x20806c25, Offset: 0x3480
// Size: 0xb6
function private function_8a06fe6b22498dfb( player, tutorial )
{
    training_course_utils::hideobjectivemarker( training_course_utils::function_49422e31150c2fc9( player ) );
    training_course_utils::function_c58312077098c9c8( player );
    
    foreach ( enemy in tutorial.enemy_array )
    {
        namespace_512cbd6ffc19387::despawnagent( enemy );
        enemy = undefined;
    }
    
    tutorial.enemy_array = undefined;
}

// Namespace sat_training_course
// Params 2, eflags: 0x4
// Checksum 0x72029501, Offset: 0x353e
// Size: 0x42
function private function_f29dca2569af28dd( player, tutorial )
{
    player allowmovement( 1 );
    player allowstand( 1 );
    player allowcrouch( 1 );
    player allowjump( 1 );
    player allowfire( 1 );
}

// Namespace sat_training_course
// Params 2, eflags: 0x4
// Checksum 0x6af1f052, Offset: 0x3588
// Size: 0x5aa
function private function_3d90c6080a706c4b( player, tutorial )
{
    player endon( #"tutorial_changed" );
    player endon( #"disconnect" );
    wait 0.5;
    training_course_utils::function_7107038b2232bbb2( player, training_course_utils::function_49422e31150c2fc9( player ), training_course_utils::function_d58310d0f1d16d43( ( -2264, -645, 191 ), player.map_instance_index ), undefined, "uin_t10_training_course_objective_success" );
    wait 0.7;
    training_course_utils::function_a6e8c085165e0898( player, &"t10_training_course/sprint_right", 0 );
    training_course_utils::function_5310120afb8b29a0( player, &training_course_utils::issprinting, &training_course_utils::function_cd38eb9937fdb136, 0.8 );
    training_course_utils::function_5e3e773127f754db( player );
    wait 0.7;
    training_course_utils::function_a6e8c085165e0898( player, &"t10_training_course/sprint_left", 0 );
    training_course_utils::function_5310120afb8b29a0( player, &training_course_utils::issprinting, &training_course_utils::function_e7096335df6c927d, 0.8 );
    training_course_utils::function_5e3e773127f754db( player );
    wait 0.7;
    training_course_utils::function_a6e8c085165e0898( player, &"t10_training_course/sprint_backward", 0 );
    training_course_utils::function_5310120afb8b29a0( player, &training_course_utils::issprinting, &training_course_utils::function_a6e3df72999a3b25, 0.8 );
    training_course_utils::function_5e3e773127f754db( player );
    training_course_utils::function_7107038b2232bbb2( player, training_course_utils::function_49422e31150c2fc9( player ), training_course_utils::function_d58310d0f1d16d43( ( -2264, -645, 191 ), player.map_instance_index ), undefined, "uin_t10_training_course_objective_success" );
    wait 0.7;
    training_course_utils::function_ac53a17fd5b74658( player, &"sat_training_course/dive_slide_hint" );
    
    if ( player usinggamepad() )
    {
        training_course_utils::function_a6e8c085165e0898( player, &"sat_training_course/slide_all_gamepad", 0 );
    }
    else
    {
        training_course_utils::function_a6e8c085165e0898( player, &"sat_training_course/slide_all_kbm", 0 );
    }
    
    training_course_utils::function_5310120afb8b29a0( player, &training_course_utils::function_a35365e18eb01e84, undefined );
    training_course_utils::function_5e3e773127f754db( player );
    wait 0.7;
    training_course_utils::function_7107038b2232bbb2( player, training_course_utils::function_49422e31150c2fc9( player ), training_course_utils::function_d58310d0f1d16d43( ( -2194, -887, 191 ), player.map_instance_index ), undefined, "uin_t10_training_course_objective_success" );
    training_course_utils::function_a6e8c085165e0898( player, &"sat_training_course/slide_shoot", 2 );
    training_course_utils::function_ac53a17fd5b74658( player, &"t10_training_course/dive_slide_shoot_hint" );
    tutorial.enemy_array = [];
    var_edb2501e70048169 = [ [ ( -2481, -1005, 192 ), ( 0, 20, 0 ) ], [ ( -2379, -1199, 192 ), ( 0, 100, 0 ) ], [ ( -2137, -1245, 191 ), ( 0, 100, 0 ) ] ];
    function_ff231d4a96017d3c( player, var_edb2501e70048169, &training_course_utils::function_b3c46dc14c991111, tutorial, 0 );
    section_num_bots = tutorial.enemy_array.size;
    var_704e34edf90ba234 = 1;
    
    while ( tutorial.enemy_array.size > section_num_bots - var_704e34edf90ba234 )
    {
        waitframe();
    }
    
    foreach ( enemy in tutorial.enemy_array )
    {
        namespace_512cbd6ffc19387::despawnagent( enemy );
        enemy = undefined;
    }
    
    tutorial.enemy_array = [];
    training_course_utils::function_c58312077098c9c8( player, 1 );
    training_course_utils::function_55099ffa73b4eff1( player );
    wait 0.7;
    training_course_utils::function_7107038b2232bbb2( player, training_course_utils::function_49422e31150c2fc9( player ), training_course_utils::function_d58310d0f1d16d43( ( -2264, -645, 191 ), player.map_instance_index ), undefined, "uin_t10_training_course_objective_success" );
    
    if ( getdvarint( @"hash_8d82e300c99f95b0" ) )
    {
        if ( player usinggamepad() )
        {
            training_course_utils::function_a6e8c085165e0898( player, &"sat_training_course/dive_all_gamepad", 0 );
        }
        else
        {
            training_course_utils::function_a6e8c085165e0898( player, &"sat_training_course/dive_all_kbm", 0 );
        }
        
        training_course_utils::function_5310120afb8b29a0( player, &training_course_utils::isdiving, undefined );
        training_course_utils::function_5e3e773127f754db( player );
        wait 0.7;
    }
    
    training_course_utils::function_55099ffa73b4eff1( player );
    player playlocalsound( "uin_t10_training_course_objective_success" );
    wait 0.7;
    training_course_utils::function_7107038b2232bbb2( player, training_course_utils::function_49422e31150c2fc9( player ), training_course_utils::function_d58310d0f1d16d43( ( -2480, -1044, 192 ), player.map_instance_index ), undefined, "uin_t10_training_course_objective_success" );
    player setvelocity( ( 0, 0, 0 ) );
    player allowjump( 0 );
    wait 1;
    player allowstand( 0 );
    player allowcrouch( 0 );
    player setstance( "prone", 1, 1 );
    training_course_utils::function_a6e8c085165e0898( player, &"sat_training_course/omnimovement_prone_kills", 0 );
    training_course_utils::function_ac53a17fd5b74658( player, &"sat_training_course/omnimovement_prone_kills_hints" );
    var_9dcf6cb07bead0d2 = [ [ ( -2552, -682, 191 ), ( 0, 330, 0 ) ], [ ( -2324, -1425, 192 ), ( 0, 180, 0 ) ], [ ( -1927, -999, 256 ), ( 0, 200, 0 ) ] ];
    function_ff231d4a96017d3c( player, var_9dcf6cb07bead0d2, &training_course_utils::function_47a8618216dcc012, tutorial );
    
    while ( tutorial.enemy_array.size > 0 )
    {
        waitframe();
    }
    
    training_course_utils::function_c58312077098c9c8( player, 1 );
    training_course_utils::function_5e3e773127f754db( player );
    training_course_utils::function_55099ffa73b4eff1( player );
    wait 0.7;
    thread training_course_stations::completetutorial( player, tutorial );
}

// Namespace sat_training_course
// Params 2, eflags: 0x4
// Checksum 0xb1f40a45, Offset: 0x3b3a
// Size: 0x10e
function private function_dd501c559d7a599c( bot, tutorial )
{
    bot.var_74936259d5c25c68 = 1;
    marker = gameobjects::createobjidobject( ( 0, 0, 0 ), "neutral", ( 0, 0, 0 ), undefined, "any", 1, "icon_medium" );
    objidpoolmanager::update_objective_icon( marker.objidnum, "sat_ui_icon_waypoint_training_objective" );
    objidpoolmanager::update_objective_setbackground( marker.objidnum, training_course_utils::function_fb000aeabac687eb() );
    objidpoolmanager::function_373aaf492aabde6f( marker.objidnum, 0, 0, 0, 1 );
    objidpoolmanager::function_de3fb937d4f45f38( marker.objidnum, 150, 75 );
    objidpoolmanager::objective_set_play_intro( marker.objidnum, 0 );
    objidpoolmanager::objective_set_play_outro( marker.objidnum, 0 );
    training_course_utils::hideobjectivemarker( marker );
    bot.global_objective_marker = marker;
    tutorial.objective_marker = training_course_utils::function_49422e31150c2fc9( bot );
}

// Namespace sat_training_course
// Params 2, eflags: 0x4
// Checksum 0xcc91fcaa, Offset: 0x3c50
// Size: 0x81
function private function_eb0c268de30341c2( bot, tutorial )
{
    bot.var_74936259d5c25c68 = 0;
    bot botclearscriptgoal();
    bot allowstand( 1 );
    bot allowcrouch( 1 );
    bot allowmovement( 1 );
    bot allowjump( 1 );
    bot allowfire( 1 );
    
    if ( tutorial.objective_marker )
    {
        training_course_utils::hideobjectivemarker( tutorial.objective_marker );
        tutorial.objective_marker = undefined;
    }
}

// Namespace sat_training_course
// Params 2, eflags: 0x4
// Checksum 0xed62c620, Offset: 0x3cd9
// Size: 0x652
function private function_d15857606b573383( bot, tutorial )
{
    bot endon( #"tutorial_changed" );
    bot endon( #"death_or_disconnect" );
    bot botsetflag( "disable_movement", 0 );
    bot botsetflag( "disable_rotation", 0 );
    bot botsetflag( "disable_avoidance", 0 );
    bot botclearscriptgoal();
    bot botsetscriptgoal( training_course_utils::function_d58310d0f1d16d43( ( -2264, -645, 191 ), tutorial.instance ), 15, "critical", -160 );
    bot waittill( #"goal" );
    bot botclearscriptgoal();
    wait 0.5;
    bot botsetflag( "disable_rotation", 1 );
    bot botsetscriptmove( 90, 2, 1 );
    bot botpressbutton( "sprint", 2 );
    wait 2.5;
    bot botsetscriptmove( -90, 2, 1 );
    bot botpressbutton( "sprint", 2 );
    wait 2.5;
    bot botsetscriptmove( 0, 2, 1 );
    wait 0.5;
    bot botpressbutton( "sprint", 2 );
    bot botsetflag( "disable_rotation", 0 );
    waitframe();
    bot botsetscriptgoal( training_course_utils::function_d58310d0f1d16d43( ( -2264, -645, 191 ), tutorial.instance ), 15, "critical", 180 );
    bot waittill( #"goal" );
    bot botclearscriptgoal();
    bot botsetscriptmove( -90, 2, 1 );
    bot botpressbutton( "sprint", 2 );
    wait 0.5;
    bot botpressbutton( "slide", 0.3 );
    wait 1;
    bot botclearscriptgoal();
    bot botsetscriptgoal( training_course_utils::function_d58310d0f1d16d43( ( -2135, -687, 191 ), tutorial.instance ), 30, "critical", -115 );
    bot waittill( #"goal" );
    bot botclearscriptgoal();
    
    while ( true )
    {
        childthread training_course_utils::function_fd6bf4c76734b916( bot, tutorial.enemy_array[ 0 ] );
        wait 0.5;
        looking_angle = vectortoangles( tutorial.enemy_array[ 0 ].origin - bot.origin );
        bot botsetscriptmove( looking_angle[ 1 ], 1.5, 1 );
        bot botpressbutton( "sprint", 2 );
        wait 0.8;
        bot botpressbutton( "slide", 0.5 );
        wait 0.1;
        bot botpressbutton( "attack", 0.75 );
        wait 1;
        all_enemies_dead = 1;
        
        foreach ( enemy in tutorial.enemy_array )
        {
            if ( isalive( enemy ) )
            {
                all_enemies_dead = 0;
                break;
            }
        }
        
        if ( all_enemies_dead )
        {
            break;
        }
        
        bot notify( #"stop_looking" );
        bot botclearscriptgoal();
        bot botsetscriptgoal( training_course_utils::function_d58310d0f1d16d43( ( -2135, -687, 191 ), tutorial.instance ), 30, "critical", -115 );
        bot waittill( #"goal" );
        bot botclearscriptgoal();
    }
    
    bot botsetscriptgoal( training_course_utils::function_d58310d0f1d16d43( ( -2264, -645, 191 ), tutorial.instance ), 15, "critical", 180 );
    bot waittill( #"goal" );
    bot botclearscriptgoal();
    bot botsetscriptmove( -90, 2, 1 );
    bot botpressbutton( "sprint", 2 );
    wait 0.5;
    bot botpressbutton( "dtp", 0.5 );
    wait 1.5;
    bot botclearscriptgoal();
    bot botsetscriptgoal( training_course_utils::function_d58310d0f1d16d43( ( -2480, -1044, 192 ), tutorial.instance ), 30, "critical", -115 );
    bot waittill( #"goal" );
    bot botclearscriptgoal();
    wait 0.7;
    
    while ( true )
    {
        closest_visible_enemy = undefined;
        current_closest_distance = undefined;
        
        foreach ( enemy in tutorial.enemy_array )
        {
            if ( !isalive( enemy ) || enemy.var_a6537bd86d98c4c3 )
            {
                continue;
            }
            
            trace = trace::ray_trace( bot geteye(), enemy geteye(), [ bot, tutorial.meatshield_bot ], undefined );
            
            if ( trace[ "entity" ] != enemy )
            {
                continue;
            }
            
            var_3c5820f8b063463d = distancesquared( bot.origin, enemy.origin );
            
            if ( !isdefined( current_closest_distance ) || var_3c5820f8b063463d < current_closest_distance )
            {
                closest_visible_enemy = enemy;
                current_closest_distance = var_3c5820f8b063463d;
            }
        }
        
        if ( !isdefined( closest_visible_enemy ) )
        {
            waitframe();
            continue;
        }
        
        bot botsetflag( "disable_rotation", 0 );
        childthread training_course_utils::function_fd6bf4c76734b916( bot, closest_visible_enemy );
        wait 0.5;
        bot botpressbutton( "ads", 9999 );
        thread training_course_utils::function_bf3e729263fcc10( bot, closest_visible_enemy, 0.5 );
        closest_visible_enemy waittill( #"death" );
        wait 0.3;
        bot botclearbutton( "ads" );
        all_enemies_dead = 1;
        
        foreach ( enemy in tutorial.enemy_array )
        {
            if ( isalive( enemy ) )
            {
                all_enemies_dead = 0;
                break;
            }
        }
        
        if ( all_enemies_dead )
        {
            break;
        }
    }
    
    wait 0.7;
}

// Namespace sat_training_course
// Params 2, eflags: 0x4
// Checksum 0x56e98511, Offset: 0x4333
// Size: 0x20b
function private function_eb3ea60bb4e2122d( player, tutorial )
{
    bots = training_course_utils::function_8658dfb45f6b84c8( player.map_instance_index );
    assert( isdefined( bots ), "<dev string:x7a>" );
    tutorial.execution_ref = "sat_mp_execution_000_knife_default";
    tutorial.instance = player.map_instance_index;
    tutorial.meatshield_bot = undefined;
    tutorial.execution_bot = undefined;
    propweapon = execution::execution_getpropweaponbyref( tutorial.execution_ref );
    player giveweapon( propweapon, 1 );
    player giveexecution( tutorial.execution_ref, propweapon );
    
    while ( !isdefined( tutorial.meatshield_bot ) && !isdefined( tutorial.execution_bot ) )
    {
        wait 0.2;
        
        foreach ( bot in bots )
        {
            outofbounds::enableoobimmunity( bot );
            bot setinfiniteammo( 1 );
            bot botsetflag( "force_sprint", 0 );
            bot botsetflag( "disable_automatic_sprint", 1 );
            bot.health = bot.maxhealth;
            
            if ( bot.purpose == "meatshield" )
            {
                bot.is_meatshield_bot = 1;
                tutorial.meatshield_bot = bot;
                continue;
            }
            
            if ( bot.purpose == "execution" )
            {
                bot.is_execution_bot = 1;
                tutorial.execution_bot = bot;
            }
        }
    }
    
    tutorial.enemy_array = [];
    tutorial.var_52d61057297d7e25 = 0;
}

// Namespace sat_training_course
// Params 2, eflags: 0x4
// Checksum 0x4a15a129, Offset: 0x4546
// Size: 0x1c6
function private function_eef95cf422ee90cc( player, tutorial )
{
    if ( player ismeatshieldactive() || player ismeatshieldattacker() )
    {
        player meatshield::function_db06fbfec0ffa2eb();
    }
    
    training_course_utils::function_c58312077098c9c8( player );
    bots = training_course_utils::function_8658dfb45f6b84c8( player.map_instance_index );
    
    foreach ( bot in bots )
    {
        if ( isalive( bot ) )
        {
            bot setorigin( training_course_utils::function_d58310d0f1d16d43( ( -1043, -1095, 480 ), player.map_instance_index ) );
            training_course_utils::function_f84dc38c3e66bb65( bot );
            bot playerhide();
        }
        
        bot.is_dead = undefined;
        bot = undefined;
    }
    
    foreach ( enemy in tutorial.enemy_array )
    {
        namespace_512cbd6ffc19387::despawnagent( enemy );
        enemy = undefined;
    }
    
    tutorial.enemy_array = undefined;
    propweapon = execution::execution_getpropweaponbyref( tutorial.execution_ref );
    player takeweapon( propweapon );
    player enableexecutionattack();
    tutorial.var_52d61057297d7e25 = undefined;
}

// Namespace sat_training_course
// Params 2, eflags: 0x4
// Checksum 0x336783b1, Offset: 0x4714
// Size: 0xa2
function private function_7b0997d222bd6ed4( player, tutorial )
{
    foreach ( enemy in tutorial.enemy_array )
    {
        if ( isalive( enemy ) )
        {
            enemy enabletraversals( 0 );
            enemy utility::set_movement_speed( 0 );
        }
    }
}

// Namespace sat_training_course
// Params 2, eflags: 0x4
// Checksum 0xd5be6fda, Offset: 0x47be
// Size: 0x963
function private function_543c2f2f36cba326( player, tutorial )
{
    player endon( #"tutorial_changed" );
    player endon( #"death_or_disconnect" );
    thread trainingcourse_watchforplayerdeath( player, tutorial );
    training_course_utils::function_a6e8c085165e0898( player, &"sat_training_course/execution_aproach", 2 );
    
    while ( true )
    {
        tutorial.execution_bot playershow();
        tutorial.execution_bot setorigin( training_course_utils::function_d58310d0f1d16d43( ( -1694, -1355, 256 ), player.map_instance_index ) );
        tutorial.execution_bot setplayerangles( training_course_utils::function_2e52e3ebd7fff7bd( ( 0, 0, 0 ), player.map_instance_index ) );
        message = tutorial.execution_bot utility::waittill_any_return( "death", "execution_begin_victim" );
        tutorial.var_52d61057297d7e25 = 1;
        wait 5;
        
        if ( message == "execution_begin_victim" )
        {
            break;
        }
    }
    
    training_course_utils::function_5e3e773127f754db( player );
    training_course_utils::function_a6e8c085165e0898( player, &"sat_training_course/meatshield_panel", 2 );
    
    while ( true )
    {
        tutorial.meatshield_bot playershow();
        tutorial.meatshield_bot setorigin( training_course_utils::function_d58310d0f1d16d43( ( -1542, -1317, 256 ), player.map_instance_index ) );
        tutorial.meatshield_bot setplayerangles( training_course_utils::function_2e52e3ebd7fff7bd( ( 0, 0, 0 ), player.map_instance_index ) );
        message = tutorial.meatshield_bot utility::waittill_any_return( "death", "meatshield_victim_grabbed" );
        tutorial.var_52d61057297d7e25 = 1;
        
        if ( message == "meatshield_victim_grabbed" )
        {
            break;
        }
        
        wait 3;
    }
    
    enemy_spawn_infos = [ [ ( -1236, -1292, 256 ), 100, 125 ], [ ( -1172, -1206, 256 ), 100, 100 ], [ ( -1263, -1173, 256 ), 100, 125 ] ];
    thread trainingcourse_watchforplayerdeath( player, tutorial, enemy_spawn_infos.size > 1 );
    thread function_aeafa117a848bcfe( tutorial, player, tutorial.meatshield_bot );
    training_course_utils::function_5e3e773127f754db( player );
    training_course_utils::function_a6e8c085165e0898( player, &"sat_training_course/meatshield_sequence_pt_1", 2 );
    tutorial notify( #"meatshield_initiated" );
    
    if ( enemy_spawn_infos.size > 1 && !isbot( player ) )
    {
        training_course_utils::function_98702f770499bea1( function_275e97f81427089d( tutorial, player ), 0, enemy_spawn_infos.size );
    }
    
    var_6b11c4561a62886c = training_course_utils::function_3f5c1e59764b640d( [ [ %"hash_4d3a5e1f86f42cff", %"hash_560effefc7b7f545" ] ] );
    var_1bfb4983b04de4d0 = 9999;
    tutorial.var_52d61057297d7e25 = 0;
    
    foreach ( enemy_spawn_info in enemy_spawn_infos )
    {
        spawn_point = training_course_utils::function_d58310d0f1d16d43( enemy_spawn_info[ 0 ], player.map_instance_index );
        movement_delay = enemy_spawn_info[ 1 ];
        speed = !training_course_stations::function_abaed5b5b01f5e28( tutorial ) ? enemy_spawn_info[ 2 ] : 70;
        angles = vectortoangles( player.origin - spawn_point );
        enemy = namespace_512cbd6ffc19387::spawnagent( spawn_point, angles, 100, training_course_utils::function_3e92b89fd90af5ab( player ), 1 );
        enemy.favoriteenemy = player;
        thread function_67f98dc0911f51c9( player, enemy, movement_delay, speed );
        var_5d742401d8f13aaa = tutorial.var_a5fd41050e0ceb34 == 0 ? randomfloatrange( 2, 4 ) : 10;
        thread function_8fb8aa45f72b2af( player, enemy, var_5d742401d8f13aaa, 0.3, 0.6 );
        tutorial.enemy_array[ tutorial.enemy_array.size ] = enemy;
        thread function_5f9c8959f158543d( player, enemy, tutorial, enemy_spawn_infos.size );
        
        if ( var_5d742401d8f13aaa < var_1bfb4983b04de4d0 )
        {
            var_1bfb4983b04de4d0 = var_5d742401d8f13aaa;
        }
    }
    
    thread function_e130e0f4e6610f2( player, tutorial, var_1bfb4983b04de4d0 );
    childthread function_b7e85cbe2b2017cb( tutorial.meatshield_bot );
    
    while ( tutorial.meatshield_bot ismeatshieldvictim() || tutorial.meatshield_bot isinexecutionvictim() )
    {
        waitframe();
    }
    
    foreach ( enemy in tutorial.enemy_array )
    {
        if ( isalive( enemy ) )
        {
            namespace_512cbd6ffc19387::function_b3d358f2f43b564c( enemy, 1 );
            training_course_utils::function_c58312077098c9c8( player );
            thread training_course_stations::restarttutorial( player, tutorial, 0, 1, 0, undefined );
        }
    }
    
    training_course_utils::function_c58312077098c9c8( player );
    training_course_utils::function_5e3e773127f754db( player );
    wait 2;
    training_course_utils::function_a6e8c085165e0898( player, &"sat_training_course/meatshield_panel", 2 );
    
    while ( !isalive( tutorial.meatshield_bot ) )
    {
        waitframe();
    }
    
    while ( true )
    {
        tutorial.meatshield_bot playershow();
        tutorial.meatshield_bot setorigin( training_course_utils::function_d58310d0f1d16d43( ( -1088, -1220, 256 ), player.map_instance_index ) );
        tutorial.meatshield_bot setplayerangles( training_course_utils::function_2e52e3ebd7fff7bd( ( 0, 0, 0 ), player.map_instance_index ) );
        message = tutorial.meatshield_bot utility::waittill_any_return( "death", "meatshield_victim_grabbed" );
        tutorial.var_52d61057297d7e25 = 1;
        
        if ( message == "meatshield_victim_grabbed" )
        {
            break;
        }
        
        wait 3;
    }
    
    player disableexecutionattack();
    thread trainingcourse_watchforplayerdeath( player, tutorial, enemy_spawn_infos.size > 1 );
    thread function_aeafa117a848bcfe( tutorial, player, tutorial.meatshield_bot );
    
    while ( !player ismeatshieldattacker() )
    {
        waitframe();
    }
    
    training_course_utils::function_a6e8c085165e0898( player, &"sat_training_course/meatshield_sequence_pt_2", 2 );
    tutorial notify( #"meatshield_initiated" );
    tutorial.enemy_array = [];
    tutorial.var_52d61057297d7e25 = 0;
    var_95826500596f4354 = [ [ ( -905, -1119, 256 ), ( 0, -180, 0 ) ], [ ( -866, -1258, 256 ), ( 0, -180, 0 ) ], [ ( -857, -1182, 256 ), ( 0, -180, 0 ) ] ];
    
    if ( var_95826500596f4354.size > 1 && !isbot( player ) )
    {
        training_course_utils::function_98702f770499bea1( function_275e97f81427089d( tutorial, player ), 0, var_95826500596f4354.size );
    }
    
    foreach ( finisher_spawn_info in var_95826500596f4354 )
    {
        spawn_point = training_course_utils::function_d58310d0f1d16d43( finisher_spawn_info[ 0 ], player.map_instance_index );
        [ agent_origin, agent_angles ] = training_course_utils::function_52ff81cfdbb3f234( finisher_spawn_info[ 0 ], finisher_spawn_info[ 1 ], player.map_instance_index );
        enemy = namespace_512cbd6ffc19387::spawnagent( agent_origin, agent_angles, 100, training_course_utils::function_3e92b89fd90af5ab( player ), 1 );
        enemy.favoriteenemy = player;
        enemy.var_a6537bd86d98c4c3 = 1;
        namespace_512cbd6ffc19387::function_b3d358f2f43b564c( enemy, 1 );
        tutorial.enemy_array[ tutorial.enemy_array.size ] = enemy;
        thread function_5f9c8959f158543d( player, enemy, tutorial, var_95826500596f4354.size );
    }
    
    childthread function_b7e85cbe2b2017cb( tutorial.meatshield_bot );
    
    while ( tutorial.meatshield_bot ismeatshieldvictim() || tutorial.meatshield_bot isinexecutionvictim() )
    {
        waitframe();
    }
    
    wait 3;
    
    foreach ( enemy in tutorial.enemy_array )
    {
        if ( isalive( enemy ) )
        {
            namespace_512cbd6ffc19387::function_b3d358f2f43b564c( enemy, 1 );
            thread training_course_stations::restarttutorial( player, tutorial, 0, 1, 0, undefined );
        }
    }
    
    training_course_utils::function_5e3e773127f754db( player );
    thread training_course_stations::completetutorial( player, tutorial );
}

// Namespace sat_training_course
// Params 1, eflags: 0x4
// Checksum 0x932546b4, Offset: 0x5129
// Size: 0x35
function private function_b7e85cbe2b2017cb( bot )
{
    bot endon( #"disconnect" );
    bot waittill( #"death" );
    bot.is_dead = 1;
}

// Namespace sat_training_course
// Params 2, eflags: 0x4
// Checksum 0xdaf8f9b6, Offset: 0x5166
// Size: 0xc9
function private function_b0481593100b7378( player, meatshield_bot )
{
    player endon( #"tutorial_changed" );
    player endon( #"death_or_disconnect" );
    meatshield_bot endon( #"death_or_disconnect" );
    childthread training_course_utils::function_fd6bf4c76734b916( meatshield_bot, player );
    fire_time = weaponfiretime( meatshield_bot getcurrentweapon() );
    wait 2;
    cos_fov_angle = cos( 35 );
    
    while ( true )
    {
        if ( training_course_utils::function_7517ebd4fc6719f0( meatshield_bot, player, cos_fov_angle ) )
        {
            meatshield_bot botpressbutton( "attack" );
            wait fire_time;
            continue;
        }
        
        meatshield_bot botsetscriptgoal( player.origin, 32, "critical" );
        meatshield_bot utility::waittill_any_return( "goal", "entity_in_view" );
        meatshield_bot botclearscriptgoal();
    }
}

// Namespace sat_training_course
// Params 4, eflags: 0x4
// Checksum 0x303b9aff, Offset: 0x5237
// Size: 0x95
function private function_5f9c8959f158543d( player, enemy, tutorial, var_3585171bd7e4c1a )
{
    player endon( #"tutorial_changed" );
    player endon( #"disconnect" );
    enemy waittill( #"death" );
    tutorial.var_52d61057297d7e25++;
    tutorial.enemy_array = arrayremove( tutorial.enemy_array, enemy );
    training_course_utils::function_baee265bb13dd11e( function_275e97f81427089d( tutorial, player ), tutorial.var_52d61057297d7e25, var_3585171bd7e4c1a );
}

// Namespace sat_training_course
// Params 3, eflags: 0x4
// Checksum 0xf2a3e36a, Offset: 0x52d4
// Size: 0xbc
function private function_aeafa117a848bcfe( tutorial, player, bot )
{
    player endon( #"tutorial_changed" );
    tutorial endon( #"meatshield_initiated" );
    player endon( #"disconnect" );
    
    while ( true )
    {
        bot waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath );
        
        if ( attacker == player && utility::isbulletdamage( meansofdeath ) || !isalive( bot ) )
        {
            player playlocalsound( "uin_t10_training_course_target_fail" );
            break;
        }
    }
}

// Namespace sat_training_course
// Params 4, eflags: 0x4
// Checksum 0x7b847e26, Offset: 0x5398
// Size: 0x6f
function private function_67f98dc0911f51c9( player, enemy, seconds, speed )
{
    player endon( #"tutorial_changed" );
    player endon( #"death_or_disconnect" );
    enemy endon( #"death" );
    wait seconds;
    enemy enabletraversals( 1 );
    enemy utility::set_movement_speed( speed );
    enemy setgoalentity( player, 500 );
}

// Namespace sat_training_course
// Params 5, eflags: 0x4
// Checksum 0xdb984ac3, Offset: 0x540f
// Size: 0x117
function private function_8fb8aa45f72b2af( player, enemy, initial_delay, fire_rate_min, fire_rate_max )
{
    player endon( #"tutorial_changed" );
    player endon( #"death_or_disconnect" );
    enemy endon( #"death" );
    wait initial_delay;
    
    while ( true )
    {
        trace = trace::ray_trace( enemy geteye(), player geteye(), enemy, undefined );
        player_forward = vectornormalize( anglestoforward( player.angles ) );
        enemy_forward = vectornormalize( anglestoforward( enemy.angles ) );
        dot_product = vectordot( player_forward, enemy_forward );
        should_damage_player = dot_product > -0.1 && isdefined( trace[ "entity" ] );
        namespace_512cbd6ffc19387::function_bc2d17578622fd93( enemy, player, should_damage_player );
        
        if ( isdefined( trace[ "entity" ] ) )
        {
            enemy notify( #"shoot_player" );
        }
        
        wait randomfloatrange( fire_rate_min, fire_rate_max );
    }
}

// Namespace sat_training_course
// Params 3, eflags: 0x4
// Checksum 0xad759bae, Offset: 0x552e
// Size: 0x11a
function private function_e130e0f4e6610f2( player, tutorial, initial_wait_time )
{
    player endon( #"tutorial_changed" );
    player endon( #"death_or_disconnect" );
    wait initial_wait_time;
    
    do
    {
        var_8be15f16f56ed326 = undefined;
        
        foreach ( enemy in tutorial.enemy_array )
        {
            if ( isalive( enemy ) )
            {
                var_8be15f16f56ed326 = enemy;
                break;
            }
        }
        
        if ( !isdefined( var_8be15f16f56ed326 ) )
        {
            break;
        }
        
        var_8be15f16f56ed326 utility::waittill_any( "shoot_player", "death" );
        player dodamage( 40, player.origin, var_8be15f16f56ed326, undefined, "MOD_RIFLE_BULLET", var_8be15f16f56ed326.primaryweapon );
        wait randomfloatrange( 1, 2 );
    }
    while ( true );
}

// Namespace sat_training_course
// Params 2, eflags: 0x4
// Checksum 0xc8b15d36, Offset: 0x5650
// Size: 0x2c
function private function_ba41b7a10219ef3b( bot, tutorial )
{
    bot setinfiniteammo( 1 );
    bot.takedamage = 1;
}

// Namespace sat_training_course
// Params 2, eflags: 0x4
// Checksum 0x8c2317c2, Offset: 0x5684
// Size: 0x65
function private function_13e58d96d5b1042f( bot, tutorial )
{
    bot meatshield::function_db06fbfec0ffa2eb();
    bot setinfiniteammo( 0 );
    bot botclearscriptgoal();
    bot botclearbutton( "ads" );
    bot enableexecutionattack();
    bot botsetflag( "disable_rotation", 1 );
    bot botsetflag( "disable_movement", 1 );
    training_course_utils::function_c58312077098c9c8( bot );
}

// Namespace sat_training_course
// Params 2, eflags: 0x4
// Checksum 0x97f6039, Offset: 0x56f1
// Size: 0x58f
function private function_7d1d9a69f497ce3e( bot, tutorial )
{
    bot endon( #"tutorial_changed" );
    bot endon( #"death_or_disconnect" );
    bot.agent_damage_callback = &namespace_512cbd6ffc19387::function_2d459ce49ce8b45e;
    wait 1;
    bot botsetflag( "disable_movement", 0 );
    bot botsetflag( "disable_rotation", 0 );
    bot botsetflag( "disable_avoidance", 1 );
    direction_vector = vectornormalize( tutorial.execution_bot.origin - bot.origin );
    offset_scaler = 15;
    bot botsetscriptgoal( tutorial.execution_bot.origin - direction_vector * offset_scaler, 32, "critical" );
    bot waittill( #"goal" );
    bot botsetflag( "disable_rotation", 1 );
    bot botsetflag( "disable_movement", 1 );
    bot botsetflag( "disable_avoidance", 0 );
    bot botclearscriptgoal();
    wait 1;
    propweapon = execution::execution_getpropweaponbyref( tutorial.execution_ref );
    bot giveweapon( propweapon, 0, 0, 0, 1 );
    bot giveexecution( tutorial.execution_ref, propweapon );
    bot botpressbutton( "melee", 5 );
    tutorial.execution_bot notify( #"execution_begin_victim" );
    wait 6;
    bot botsetflag( "disable_movement", 0 );
    bot botsetflag( "disable_rotation", 0 );
    bot botsetflag( "disable_avoidance", 1 );
    direction_vector = vectornormalize( tutorial.meatshield_bot.origin - bot.origin );
    offset_scaler = 15;
    bot botsetscriptgoal( tutorial.meatshield_bot.origin - direction_vector * offset_scaler, 32, "critical" );
    bot waittill( #"goal" );
    bot botsetflag( "disable_rotation", 1 );
    bot botsetflag( "disable_movement", 1 );
    bot botsetflag( "disable_avoidance", 0 );
    bot botclearscriptgoal();
    bot botpressbutton( "melee" );
    waitframe();
    bot botpressbutton( "melee" );
    wait 0.35;
    tutorial.meatshield_bot startmeatshield( bot );
    wait 1;
    
    while ( true )
    {
        closest_visible_enemy = undefined;
        current_closest_distance = undefined;
        
        foreach ( enemy in tutorial.enemy_array )
        {
            if ( !isalive( enemy ) || enemy.var_a6537bd86d98c4c3 )
            {
                continue;
            }
            
            trace = trace::ray_trace( bot geteye(), enemy geteye(), [ bot, tutorial.meatshield_bot ], undefined );
            
            if ( trace[ "entity" ] != enemy )
            {
                continue;
            }
            
            var_3c5820f8b063463d = distancesquared( bot.origin, enemy.origin );
            
            if ( !isdefined( current_closest_distance ) || var_3c5820f8b063463d < current_closest_distance )
            {
                closest_visible_enemy = enemy;
                current_closest_distance = var_3c5820f8b063463d;
            }
        }
        
        if ( !isdefined( closest_visible_enemy ) )
        {
            waitframe();
            continue;
        }
        
        bot botsetflag( "disable_rotation", 0 );
        childthread training_course_utils::function_fd6bf4c76734b916( bot, closest_visible_enemy );
        wait 0.5;
        bot botpressbutton( "ads", 9999 );
        thread training_course_utils::function_bf3e729263fcc10( bot, closest_visible_enemy, 0.5 );
        closest_visible_enemy waittill( #"death" );
        wait 0.3;
        bot botclearbutton( "ads" );
        all_enemies_dead = 1;
        
        foreach ( enemy in tutorial.enemy_array )
        {
            if ( isalive( enemy ) )
            {
                all_enemies_dead = 0;
                break;
            }
        }
        
        if ( all_enemies_dead )
        {
            break;
        }
    }
    
    wait 0.1;
    bot botpressbutton( "melee" );
    bot botsetflag( "disable_rotation", 0 );
    bot botsetflag( "disable_movement", 0 );
    
    while ( !isalive( tutorial.meatshield_bot ) )
    {
        waitframe();
    }
    
    bot botclearscriptgoal();
    wait 0.5;
    bot botsetscriptgoal( training_course_utils::function_d58310d0f1d16d43( ( -1116, -1224, 256 ), tutorial.instance ), 15, "critical", 30 );
    bot waittill( #"goal" );
    bot botclearscriptgoal();
    wait 0.5;
    tutorial.meatshield_bot startmeatshield( bot );
    waitframe();
    bot botlookatpoint( training_course_utils::function_d58310d0f1d16d43( ( -857, -1182, 286 ), tutorial.instance ), 10, "script_forced" );
    wait 2;
    bot botpressbutton( "lethal", 2 );
    bot botlookatpoint( training_course_utils::function_d58310d0f1d16d43( ( -857, -1182, 286 ), tutorial.instance ), 10, "script_forced" );
}

// Namespace sat_training_course
// Params 2, eflags: 0x4
// Checksum 0x4d947b7f, Offset: 0x5c88
// Size: 0xc2
function private function_6a5f62ce088d2268( player, tutorial )
{
    tutorial.objective_marker = training_course_utils::function_49422e31150c2fc9( player );
    player.walljump_trigger = spawn( "trigger_box", ( 0, 0, 0 ), 0, ( 75, 75, 75 ), ( 75, 75, 75 ) );
    tutorial.instance = player.map_instance_index;
    
    /#
        sphere( training_course_utils::function_d58310d0f1d16d43( ( 940, -299, 360 ) ), 100, ( 0, 0, 250 ), 0, 20 );
    #/
    
    trigger::makeenterexittrigger( player.walljump_trigger, undefined, &training_course_utils::function_95a092e082485aa3 );
}

// Namespace sat_training_course
// Params 2, eflags: 0x4
// Checksum 0x7836b718, Offset: 0x5d52
// Size: 0xaf
function private function_a7c669b3762337b1( player, tutorial )
{
    training_course_utils::hideobjectivemarker( tutorial.objective_marker );
    training_course_utils::hideobjectivemarker( player.walljump_marker );
    training_course_utils::function_5e3e773127f754db( player );
    tutorial.objective_marker notify( #"end" );
    tutorial.objective_marker = undefined;
    player.walljump_trigger delete();
    
    if ( player.walljump_trigger )
    {
        player.walljump_trigger delete();
    }
    
    if ( player.vfxstruct )
    {
        player.vfxstruct delete();
    }
}

// Namespace sat_training_course
// Params 2, eflags: 0x4
// Checksum 0x9626bd2b, Offset: 0x5e09
// Size: 0x28c
function private function_c8fc42ecd7aa6c99( player, tutorial )
{
    player endon( #"tutorial_changed" );
    player endon( #"disconnect" );
    wait 0.5;
    walljump_data = [ [ ( 796, -373, 395 ), ( 1096, -190, 261 ) ], [ ( 841, -386, 395 ), ( 989, -649, 248 ) ], [ ( -627, 161, 340 ), ( -363, 311, 259 ) ], [ ( 805, -897, 193 ), ( 502, -960, 319 ) ] ];
    training_course_utils::function_5affed654bd85d67( player, tutorial.objective_marker, training_course_utils::function_d58310d0f1d16d43( walljump_data[ 0 ][ 0 ], player.map_instance_index ), training_course_utils::function_d58310d0f1d16d43( walljump_data[ 0 ][ 1 ], player.map_instance_index ), player.walljump_trigger, undefined, "uin_t10_training_course_objective_success", undefined, "vfx_sat_gameplay_flare_traincourse" );
    training_course_utils::function_5affed654bd85d67( player, tutorial.objective_marker, training_course_utils::function_d58310d0f1d16d43( walljump_data[ 3 ][ 0 ], player.map_instance_index ), training_course_utils::function_d58310d0f1d16d43( walljump_data[ 3 ][ 1 ], player.map_instance_index ), player.walljump_trigger, undefined, "uin_t10_training_course_objective_success", undefined, "vfx_sat_gameplay_flare_traincourse" );
    training_course_utils::function_5affed654bd85d67( player, tutorial.objective_marker, training_course_utils::function_d58310d0f1d16d43( walljump_data[ 1 ][ 0 ], player.map_instance_index ), training_course_utils::function_d58310d0f1d16d43( walljump_data[ 1 ][ 1 ], player.map_instance_index ), player.walljump_trigger, undefined, "uin_t10_training_course_objective_success", undefined, "vfx_sat_gameplay_flare_traincourse" );
    training_course_utils::function_5affed654bd85d67( player, tutorial.objective_marker, training_course_utils::function_d58310d0f1d16d43( walljump_data[ 2 ][ 0 ], player.map_instance_index ), training_course_utils::function_d58310d0f1d16d43( walljump_data[ 2 ][ 1 ], player.map_instance_index ), player.walljump_trigger, undefined, "uin_t10_training_course_objective_success", undefined, "vfx_sat_gameplay_flare_traincourse" );
    training_course_utils::function_7107038b2232bbb2( player, tutorial.objective_marker, training_course_utils::function_d58310d0f1d16d43( ( -1295, -408, 192 ), player.map_instance_index ), undefined, "uin_t10_training_course_objective_success" );
    wait 0.7;
    thread training_course_stations::completetutorial( player, tutorial );
}

// Namespace sat_training_course
// Params 2, eflags: 0x4
// Checksum 0xc006e8c5, Offset: 0x609d
// Size: 0x304
function private function_fd8d0430d14eb45e( bot, tutorial )
{
    marker = gameobjects::createobjidobject( ( 0, 0, 0 ), "neutral", ( 0, 0, 0 ), undefined, "any", 1, "icon_medium" );
    objidpoolmanager::update_objective_icon( marker.objidnum, "sat_ui_icon_waypoint_training_objective" );
    objidpoolmanager::update_objective_setbackground( marker.objidnum, training_course_utils::function_fb000aeabac687eb() );
    objidpoolmanager::function_373aaf492aabde6f( marker.objidnum, 0, 0, 0, 1 );
    objidpoolmanager::function_de3fb937d4f45f38( marker.objidnum, 150, 75 );
    objidpoolmanager::objective_set_play_intro( marker.objidnum, 0 );
    objidpoolmanager::objective_set_play_outro( marker.objidnum, 0 );
    training_course_utils::hideobjectivemarker( marker );
    bot.global_objective_marker = marker;
    walljump_marker = gameobjects::createobjidobject( ( 0, 0, 0 ), "neutral", ( 0, 0, 0 ), undefined, "any", 1, "icon_medium" );
    objidpoolmanager::update_objective_icon( walljump_marker.objidnum, "sat_ui_icon_waypoint_training_walljump" );
    objidpoolmanager::update_objective_setbackground( walljump_marker.objidnum, training_course_utils::function_fb000aeabac687eb() );
    objidpoolmanager::function_373aaf492aabde6f( walljump_marker.objidnum, 0, 0, 0, 1 );
    objidpoolmanager::function_de3fb937d4f45f38( walljump_marker.objidnum, 150, 75 );
    objidpoolmanager::objective_set_play_intro( walljump_marker.objidnum, 0 );
    objidpoolmanager::objective_set_play_outro( walljump_marker.objidnum, 0 );
    training_course_utils::hideobjectivemarker( walljump_marker );
    bot.walljump_marker = walljump_marker;
    tutorial.objective_marker = training_course_utils::function_49422e31150c2fc9( bot );
    bot.walljump_trigger = spawn( "trigger_box", ( 0, 0, 0 ), 0, ( 75, 75, 75 ), ( 75, 75, 75 ) );
    trigger::makeenterexittrigger( bot.walljump_trigger, undefined, &training_course_utils::function_95a092e082485aa3 );
    bot.takedamage = 0;
    glassradiusdamage( training_course_utils::function_d58310d0f1d16d43( ( 940, -299, 360 ), tutorial.instance ), 45, 45, 100 );
    glassradiusdamage( training_course_utils::function_d58310d0f1d16d43( ( 911, -399, 360 ), tutorial.instance ), 45, 45, 100 );
    glassradiusdamage( training_course_utils::function_d58310d0f1d16d43( ( -392, 224, 404 ), tutorial.instance ), 100, 100, 100 );
    glassradiusdamage( training_course_utils::function_d58310d0f1d16d43( ( -1225, -367, 235 ), tutorial.instance ), 45, 45, 100 );
    glassradiusdamage( training_course_utils::function_d58310d0f1d16d43( ( 460, -148, 380 ), tutorial.instance ), 45, 45, 100 );
}

// Namespace sat_training_course
// Params 2, eflags: 0x4
// Checksum 0x97dc8a9b, Offset: 0x63a9
// Size: 0x9e
function private function_33bb5547073b6108( bot, tutorial )
{
    bot botclearscriptgoal();
    
    if ( tutorial.objective_marker )
    {
        training_course_utils::hideobjectivemarker( tutorial.objective_marker );
        tutorial.objective_marker = undefined;
    }
    
    if ( bot.walljump_marker )
    {
        training_course_utils::hideobjectivemarker( bot.walljump_marker );
        bot.walljump_marker = undefined;
    }
    
    if ( bot.walljump_trigger )
    {
        bot.walljump_trigger delete();
    }
    
    bot.takedamage = 1;
}

// Namespace sat_training_course
// Params 2, eflags: 0x4
// Checksum 0xf42589e7, Offset: 0x644f
// Size: 0x489
function private function_bc21359b5f91f4d9( bot, tutorial )
{
    bot endon( #"tutorial_changed" );
    bot endon( #"death_or_disconnect" );
    wait 1;
    bot botclearscriptgoal();
    bot botsetscriptgoal( bot.origin, 15, "critical", 160 );
    bot waittill( #"goal" );
    bot botclearscriptgoal();
    bot botsetflag( "disable_movement", 0 );
    bot botsetflag( "disable_rotation", 0 );
    bot botsetflag( "disable_avoidance", 0 );
    bot botsetscriptmove( 180, 0.4, 1 );
    wait 0.4;
    bot botsetscriptmove( 140, 1.75, 1 );
    wait 1.25;
    bot botpressbutton( "jump" );
    wait 0.25;
    bot botpressbutton( "jump" );
    wait 0.5;
    bot botsetscriptmove( 180, 0.7, 1 );
    wait 0.7;
    bot botsetscriptgoal( training_course_utils::function_d58310d0f1d16d43( ( 430, -890, 256 ), tutorial.instance ), 30, "critical", 0 );
    bot waittill( #"goal" );
    bot botclearscriptgoal();
    bot botsetscriptmove( -50, 1, 1 );
    wait 0.5;
    bot botpressbutton( "jump" );
    wait 0.15;
    bot botpressbutton( "jump" );
    wait 1;
    bot botsetscriptgoal( training_course_utils::function_d58310d0f1d16d43( ( 966, -750, 192 ), tutorial.instance ), 30, "critical", 110 );
    bot waittill( #"goal" );
    bot botclearscriptgoal();
    bot botsetscriptmove( 80, 0.6, 1 );
    bot botpressbutton( "sprint", 2 );
    wait 0.3;
    bot botpressbutton( "jump" );
    wait 0.25;
    bot botpressbutton( "jump" );
    bot botsetscriptgoal( bot.origin, 30, "critical", 110 );
    bot botsetscriptmove( 110, 0.9, 1 );
    wait 1;
    bot botsetscriptmove( 120, 0.5, 1 );
    wait 0.5;
    bot botsetscriptgoal( training_course_utils::function_d58310d0f1d16d43( ( 892, -280, 320 ), tutorial.instance ), 20, "critical", 0 );
    bot waittill( #"goal" );
    bot botclearscriptgoal();
    bot botsetscriptmove( 0, 1, 1 );
    wait 1;
    bot botsetscriptgoal( training_course_utils::function_d58310d0f1d16d43( ( 415, -24, 224 ), tutorial.instance ), 20, "critical", 93 );
    bot waittill( #"goal" );
    bot botclearscriptgoal();
    bot botsetscriptgoal( training_course_utils::function_d58310d0f1d16d43( ( 383, 277, 224 ), tutorial.instance ), 20, "critical", 150 );
    bot waittill( #"goal" );
    bot botclearscriptgoal();
    bot botsetscriptgoal( training_course_utils::function_d58310d0f1d16d43( ( -133, 425, 224 ), tutorial.instance ), 20, "critical", -150 );
    bot waittill( #"goal" );
    bot botclearscriptgoal();
    bot botsetscriptgoal( training_course_utils::function_d58310d0f1d16d43( ( -300, 235, 224 ), tutorial.instance ), 20, "critical", 147 );
    bot waittill( #"goal" );
    bot botclearscriptgoal();
    bot botsetscriptmove( 147, 2, 1 );
    bot botpressbutton( "sprint" );
    wait 0.1;
    bot botpressbutton( "jump" );
    wait 0.25;
    bot botpressbutton( "jump" );
    wait 1;
    bot botsetscriptgoal( training_course_utils::function_d58310d0f1d16d43( ( -723, 12, 320 ), tutorial.instance ), 30, "critical", -170 );
    bot waittill( #"goal" );
    bot botclearscriptgoal();
    bot botsetscriptmove( -142, 1, 1 );
    bot botpressbutton( "sprint" );
    wait 0.2;
    bot botpressbutton( "jump" );
    wait 0.9;
    bot botsetscriptgoal( training_course_utils::function_d58310d0f1d16d43( ( -1279, -392, 192 ), tutorial.instance ), 30, "critical", -175 );
    bot waittill( #"goal" );
    bot botclearscriptgoal();
}

// Namespace sat_training_course
// Params 2, eflags: 0x4
// Checksum 0x1f53e081, Offset: 0x68e0
// Size: 0xc2
function private function_c0b7d169e34f2418( player, tutorial )
{
    tutorial.objective_marker = training_course_utils::function_49422e31150c2fc9( player );
    
    foreach ( weap in player.primaryweapons )
    {
        if ( weaponclass( weap ) == "pistol" && !weapon::isbackuppistol( weap ) )
        {
            player switchtoweaponimmediate( weap );
            break;
        }
    }
}

// Namespace sat_training_course
// Params 2, eflags: 0x4
// Checksum 0x9bafee13, Offset: 0x69aa
// Size: 0xc4
function private function_453ce916fba291a1( player, tutorial )
{
    training_course_utils::hideobjectivemarker( tutorial.objective_marker );
    tutorial.objective_marker = undefined;
    training_course_utils::function_c58312077098c9c8( player );
    
    foreach ( enemy in tutorial.enemy_array )
    {
        namespace_512cbd6ffc19387::despawnagent( enemy );
        enemy = undefined;
    }
    
    tutorial.enemy_array = undefined;
}

// Namespace sat_training_course
// Params 2, eflags: 0x4
// Checksum 0x5fe4e91, Offset: 0x6a76
// Size: 0x666
function private function_36f64d6bee634a9( player, tutorial )
{
    player endon( #"tutorial_changed" );
    player endon( #"disconnect" );
    childthread training_course_utils::function_2943c40f56fbdcdb( player );
    wait 0.5;
    training_course_utils::function_ac53a17fd5b74658( player, &"t10_training_course/sprint" );
    training_course_utils::function_7107038b2232bbb2( player, tutorial.objective_marker, training_course_utils::function_d58310d0f1d16d43( ( 1439, -944, 192 ), player.map_instance_index ), undefined, "uin_t10_training_course_objective_success" );
    training_course_utils::function_5e3e773127f754db( player );
    wait 0.7;
    training_course_utils::function_a6e8c085165e0898( player, &"sat_training_course/shoot_hip_fire", 1 );
    training_course_utils::function_ac53a17fd5b74658( player, &"t10_training_course/reload_hint" );
    tutorial.enemy_array = [];
    var_dc6253e420bee492 = [ [ ( 1232, -987, 192 ), ( 0, 10, 0 ) ], [ ( 1086, -803, 192 ), ( 0, -10, 0 ) ] ];
    function_ff231d4a96017d3c( player, var_dc6253e420bee492, &training_course_utils::function_d77cbbfc99789ed, tutorial );
    
    while ( tutorial.enemy_array.size > 0 )
    {
        waitframe();
    }
    
    training_course_utils::function_c58312077098c9c8( player, 1 );
    training_course_utils::function_5e3e773127f754db( player );
    training_course_utils::function_55099ffa73b4eff1( player );
    player playlocalsound( "uin_t10_training_course_objective_success" );
    wait 0.7;
    training_course_utils::function_a6e8c085165e0898( player, &"t10_training_course/swap_weapon", 0 );
    training_course_utils::function_ac53a17fd5b74658( player, &"sat_training_course/swap_weapon_hint" );
    player waittill( #"weapon_change" );
    training_course_utils::function_5e3e773127f754db( player );
    training_course_utils::function_55099ffa73b4eff1( player );
    player playlocalsound( "uin_t10_training_course_objective_success" );
    wait 0.7;
    training_course_utils::function_a6e8c085165e0898( player, &"sat_training_course/shoot_ads_fire", 1 );
    training_course_utils::function_ac53a17fd5b74658( player, &"sat_training_course/ads_hint" );
    var_1d2d28316c8796ef = [ [ ( 958, -963, 271 ), ( 0, 0, 0 ) ], [ ( 954, -793, 192 ), ( 0, 0, 0 ) ], [ ( 551, -851, 255 ), ( 0, 0, 0 ) ] ];
    function_ff231d4a96017d3c( player, var_1d2d28316c8796ef, &training_course_utils::function_d492e313412afcee, tutorial );
    
    while ( tutorial.enemy_array.size > 0 )
    {
        waitframe();
    }
    
    training_course_utils::function_c58312077098c9c8( player, 1 );
    training_course_utils::function_5e3e773127f754db( player );
    training_course_utils::function_55099ffa73b4eff1( player );
    player playlocalsound( "uin_t10_training_course_objective_success" );
    wait 0.7;
    training_course_utils::function_7107038b2232bbb2( player, tutorial.objective_marker, training_course_utils::function_d58310d0f1d16d43( ( 1074, -956, 192 ), player.map_instance_index ), undefined, "uin_t10_training_course_objective_success" );
    wait 0.7;
    training_course_utils::function_a6e8c085165e0898( player, &"sat_training_course/crouch", 0 );
    training_course_utils::function_ac53a17fd5b74658( player, &"sat_training_course/crouch_hint" );
    var_ef439897d7fe363f = [ [ ( 877, -609, 192 ), ( 0, -50, 0 ) ], [ ( 798, -616, 280 ), ( 0, -50, 0 ) ], [ ( 1074, -628, 192 ), ( 0, -50, 0 ) ] ];
    function_ff231d4a96017d3c( player, var_ef439897d7fe363f, &training_course_utils::function_68c70ac70582a0ba, tutorial );
    
    while ( tutorial.enemy_array.size > 0 )
    {
        waitframe();
    }
    
    training_course_utils::function_c58312077098c9c8( player, 1 );
    training_course_utils::function_5e3e773127f754db( player );
    training_course_utils::function_55099ffa73b4eff1( player );
    player playlocalsound( "uin_t10_training_course_objective_success" );
    wait 0.7;
    
    if ( player usinggamepad() )
    {
        training_course_utils::function_a6e8c085165e0898( player, &"sat_training_course/prone_shoot_gamepad", 2 );
    }
    else
    {
        training_course_utils::function_a6e8c085165e0898( player, &"sat_training_course/prone_shoot_kbm", 2 );
    }
    
    training_course_utils::function_ac53a17fd5b74658( player, &"sat_training_course/prone_hint" );
    var_a95d65877aa2e2d7 = [ [ ( 863, -632, 192 ), ( 0, -50, 0 ) ], [ ( 569, -381, 320 ), ( 0, -50, 0 ) ], [ ( 550, -560, 256 ), ( 0, -30, 0 ) ] ];
    function_ff231d4a96017d3c( player, var_a95d65877aa2e2d7, &training_course_utils::function_47a8618216dcc012, tutorial );
    
    while ( tutorial.enemy_array.size > 0 )
    {
        waitframe();
    }
    
    training_course_utils::function_c58312077098c9c8( player, 1 );
    training_course_utils::function_5e3e773127f754db( player );
    training_course_utils::function_55099ffa73b4eff1( player );
    player playlocalsound( "uin_t10_training_course_objective_success" );
    wait 0.5;
    training_course_utils::function_5e3e773127f754db( player );
    training_course_utils::function_55099ffa73b4eff1( player );
    player playlocalsound( "uin_t10_training_course_objective_success" );
    wait 1;
    wait 0.7;
    training_course_utils::function_a6e8c085165e0898( player, &"sat_training_course/swap_melee_weapon", 0 );
    training_course_utils::function_ac53a17fd5b74658( player, &"sat_training_course/melee_weapon_hint" );
    
    while ( true )
    {
        player waittill( #"weapon_change", weapon );
        
        if ( weapon_utility::isknifeonly( weapon.basename ) )
        {
            break;
        }
    }
    
    training_course_utils::function_5e3e773127f754db( player );
    training_course_utils::function_55099ffa73b4eff1( player );
    player playlocalsound( "uin_t10_training_course_objective_success" );
    wait 0.7;
    training_course_utils::function_a6e8c085165e0898( player, &"sat_training_course/basic_movement_melee_target", 2 );
    training_course_utils::function_ac53a17fd5b74658( player, &"t10_training_course/cycle_weapons_hint" );
    var_18d3b2aaafe89af1 = [ [ ( 1081, -881, 192 ), ( 0, 90, 0 ) ] ];
    function_ff231d4a96017d3c( player, var_18d3b2aaafe89af1, &training_course_utils::function_44f847700d0d15e8, tutorial );
    
    while ( tutorial.enemy_array.size > 0 )
    {
        waitframe();
    }
    
    training_course_utils::function_5e3e773127f754db( player );
    training_course_utils::function_55099ffa73b4eff1( player );
    wait 0.7;
    thread training_course_stations::completetutorial( player, tutorial );
}

// Namespace sat_training_course
// Params 5, eflags: 0x4
// Checksum 0x999ff3e7, Offset: 0x70e4
// Size: 0x17c
function private function_ff231d4a96017d3c( player, bot_array, var_866744e27c70eb1c, tutorial, has_counter = 1 )
{
    if ( has_counter && !isbot( player ) )
    {
        training_course_utils::function_98702f770499bea1( function_275e97f81427089d( tutorial, player ), 0, bot_array.size );
    }
    
    if ( !( bot_array && var_866744e27c70eb1c && tutorial ) )
    {
        return;
    }
    
    foreach ( agent_info in bot_array )
    {
        [ agent_origin, agent_angles ] = training_course_utils::function_52ff81cfdbb3f234( agent_info[ 0 ], agent_info[ 1 ], player.map_instance_index );
        agent = namespace_512cbd6ffc19387::spawnagent( agent_origin, agent_angles, 50, training_course_utils::function_3e92b89fd90af5ab( player ), 1 );
        agent.favoriteenemy = player;
        agent.damage_validation_func = var_866744e27c70eb1c;
        tutorial.enemy_array[ tutorial.enemy_array.size ] = agent;
        thread function_ae849778a0fd4b66( player, agent, tutorial, bot_array.size, has_counter );
    }
}

// Namespace sat_training_course
// Params 5, eflags: 0x4
// Checksum 0xdd0dc224, Offset: 0x7268
// Size: 0xb1
function private function_ae849778a0fd4b66( player, enemy, tutorial, var_3585171bd7e4c1a, has_counter = 1 )
{
    player endon( #"tutorial_changed" );
    player endon( #"disconnect" );
    enemy waittill( #"death" );
    tutorial.enemy_array = arrayremove( tutorial.enemy_array, enemy );
    dead_bot_count = var_3585171bd7e4c1a - tutorial.enemy_array.size;
    
    if ( has_counter )
    {
        training_course_utils::function_baee265bb13dd11e( function_275e97f81427089d( tutorial, player ), dead_bot_count, var_3585171bd7e4c1a );
    }
}

// Namespace sat_training_course
// Params 2, eflags: 0x4
// Checksum 0xebdfa3a7, Offset: 0x7321
// Size: 0x3a
function private function_1399331f1092d5fd( player, tutorial )
{
    tutorial.equipment_state = "";
    tutorial.objective_marker = training_course_utils::function_49422e31150c2fc9( player );
}

// Namespace sat_training_course
// Params 2, eflags: 0x4
// Checksum 0xb0bd59ce, Offset: 0x7363
// Size: 0x39
function private function_ac3d22891fdad690( player, tutorial )
{
    if ( player.killstreak )
    {
        player.killstreak notify( #"killstreakexit" );
    }
}

// Namespace sat_training_course
// Params 2, eflags: 0x4
// Checksum 0x57fac970, Offset: 0x73a4
// Size: 0x1ba
function private function_436c4b277d74899c( player, tutorial )
{
    player killstreaks::clearkillstreaks();
    player equipment_mp::setequipmentslotammo( "primary", 0 );
    player equipment_mp::setequipmentslotammo( "secondary", 0 );
    player supers_mp::clearsuper();
    player equipment_mp::takeequipment( "super" );
    training_course_utils::hideobjectivemarker( training_course_utils::function_49422e31150c2fc9( player ) );
    
    foreach ( enemy in tutorial.enemy_array )
    {
        namespace_512cbd6ffc19387::despawnagent( enemy );
        enemy = undefined;
    }
    
    tutorial.enemy_array = undefined;
    
    if ( tutorial.sentry_turret )
    {
        tutorial.sentry_turret utility::callsharedfunc( #"mini_sentry", #"destroy" );
    }
    
    if ( player.support_box )
    {
        player.support_box thread support_box::supportbox_destroy( 0 );
    }
    
    if ( player.turret )
    {
        player.turret notify( #"kill_turret", 1, 0 );
        player.turret = undefined;
    }
    
    player notify( #"equip_deploy_cancel" );
    player val::set( "deploy", "crate_use", 1 );
    training_course_utils::hideobjectivemarker( tutorial.objective_marker );
    tutorial.objective_marker = undefined;
    tutorial.equipment_state = undefined;
}

// Namespace sat_training_course
// Params 2, eflags: 0x4
// Checksum 0xc65f652, Offset: 0x7566
// Size: 0xe7
function private function_3ac947bc433d7e3c( player, tutorial )
{
    player equipment_mp::setequipmentslotammo( "primary", 0 );
    player equipment_mp::setequipmentslotammo( "secondary", 0 );
    player supers_mp::clearsuper();
    player equipment_mp::takeequipment( "super" );
    player val::set( "deploy", "crate_use", 0 );
    
    if ( tutorial.equipment_state == "super" )
    {
        player val::set( "deploy", "crate_use", 1 );
        player perkpackage::perkpackage_giveimmediate( level.super_equipment );
        return;
    }
    
    if ( tutorial.equipment_state == "lethal" )
    {
        player equipment_mp::setequipmentslotammo( "primary", 1 );
        return;
    }
    
    if ( tutorial.equipment_state == "tactical" )
    {
        player equipment_mp::setequipmentslotammo( "secondary", 1 );
    }
}

// Namespace sat_training_course
// Params 2, eflags: 0x4
// Checksum 0xba84da56, Offset: 0x7655
// Size: 0x641
function private function_c986e0685a1ba96( player, tutorial )
{
    player endon( #"tutorial_changed" );
    player endon( #"disconnect" );
    wait 0.5;
    tutorial.equipment_state = "tactical";
    tutorial.enemy_array = [];
    ismpmode = !training_course_utils::function_f0999c39797a8308();
    
    if ( ismpmode )
    {
        if ( player.pers[ "sharedGamerProfiles" ][ "BumperPingEnabled" ] )
        {
            training_course_utils::function_a6e8c085165e0898( player, &"sat_training_course/tactical_objective_bumper_ping", 2 );
        }
        else
        {
            training_course_utils::function_a6e8c085165e0898( player, &"sat_training_course/tactical_objective", 2 );
        }
        
        training_course_utils::function_ac53a17fd5b74658( player, &"sat_training_course/tactical_equipment_hint" );
    }
    else
    {
        training_course_utils::function_a6e8c085165e0898( player, &"sat_training_course/tactical_objective_br", 2 );
        training_course_utils::function_ac53a17fd5b74658( player, &"sat_training_course/tactical_equipment_hint_br" );
    }
    
    var_c8706d47054f26b7 = [ [ ( 1293, -526, 192 ), ( 0, 270, 0 ) ], [ ( 1403, -584, 192 ), ( 0, 270, 0 ) ] ];
    training_course_utils::function_98702f770499bea1( function_275e97f81427089d( tutorial, player ), 0, var_c8706d47054f26b7.size );
    function_ff231d4a96017d3c( player, var_c8706d47054f26b7, ismpmode ? &function_3b6f37acb7d85fbb : &function_8ead094a1b2ffbf3, tutorial, 1 );
    
    foreach ( enemy in tutorial.enemy_array )
    {
        if ( ismpmode )
        {
            thread function_2194fa68cfdc92bd( player, enemy );
            continue;
        }
        
        enemy.allowpain = 1;
    }
    
    player equipment_mp::setequipmentslotammo( "secondary", 1 );
    player equipment_mp::setequipmentslotammo( "primary", 0 );
    thread training_course_utils::function_28b3ec81efa51820( player, "secondary", 3.5 );
    
    while ( tutorial.enemy_array.size > 0 )
    {
        waitframe();
    }
    
    player notify( #"targets_dead" );
    player equipment_mp::setequipmentslotammo( "secondary", 0 );
    training_course_utils::function_c58312077098c9c8( player, 1 );
    training_course_utils::function_5e3e773127f754db( player );
    
    if ( training_course_utils::function_33427acbfd53222( player ) )
    {
        training_course_utils::function_55099ffa73b4eff1( player );
    }
    
    wait 1.5;
    training_course_utils::function_7107038b2232bbb2( player, tutorial.objective_marker, training_course_utils::function_d58310d0f1d16d43( ( 1315, -291, 192 ), player.map_instance_index ), undefined, "uin_t10_training_course_objective_success" );
    wait 1.5;
    tutorial.equipment_state = "lethal";
    player equipment_mp::setequipmentslotammo( "secondary", 0 );
    player equipment_mp::setequipmentslotammo( "primary", 1 );
    training_course_utils::function_a6e8c085165e0898( player, &"sat_training_course/lethal_objective", 2 );
    
    if ( ismpmode )
    {
        training_course_utils::function_ac53a17fd5b74658( player, &"t10_training_course/equipment_hint" );
    }
    
    var_a600227a636380ac = [ [ ( 754, -285, 192 ), ( 0, 0, 0 ) ], [ ( 755, -362, 192 ), ( 0, 0, 0 ) ] ];
    training_course_utils::function_98702f770499bea1( function_275e97f81427089d( tutorial, player ), 0, var_c8706d47054f26b7.size );
    function_ff231d4a96017d3c( player, var_a600227a636380ac, &isexplosivedamage, tutorial, 1 );
    thread training_course_utils::function_28b3ec81efa51820( player, "primary", 3.5 );
    
    while ( tutorial.enemy_array.size > 0 )
    {
        waitframe();
    }
    
    player notify( #"targets_dead" );
    player equipment_mp::setequipmentslotammo( "primary", 0 );
    training_course_utils::function_c58312077098c9c8( player, 1 );
    training_course_utils::function_5e3e773127f754db( player );
    
    if ( training_course_utils::function_33427acbfd53222( player ) )
    {
        training_course_utils::function_55099ffa73b4eff1( player );
    }
    
    player playlocalsound( "uin_t10_training_course_objective_success" );
    wait 1.5;
    
    if ( level.superglobals.staticsuperdata[ level.super_equipment ] )
    {
        tutorial.equipment_state = "super";
        
        if ( level.super_equipment == "super_black_hat" )
        {
            function_121e065ede45fe1b( player, tutorial );
        }
        else if ( level.super_equipment == "super_ammo_drop" )
        {
            function_6a3fd1d87fc96163( player, tutorial );
        }
        
        player supers_mp::clearsuper();
        player equipment_mp::takeequipment( "super" );
    }
    
    wait 1.5;
    
    if ( ismpmode || getdvarint( @"hash_a66238671043ea83", 0 ) )
    {
        training_course_utils::function_7107038b2232bbb2( player, tutorial.objective_marker, training_course_utils::function_d58310d0f1d16d43( ( 1232, -279, 192 ), player.map_instance_index ), undefined, "uin_t10_training_course_objective_success" );
        
        if ( !ismpmode )
        {
            player allowmovement( 0 );
        }
        
        wait 1.5;
        tutorial.equipment_state = "killstreak";
        function_e67b0367766f83cd( player, tutorial, ismpmode ? "rcxd" : "sentry_gun", ismpmode ? undefined : &function_eb87c423ef5985ba, ismpmode ? [ [ ( -30, -150, 224 ), ( 0, 0, 0 ) ] ] : [ [ ( 754, -285, 192 ), ( 0, 0, 0 ) ], [ ( 755, -362, 192 ), ( 0, 0, 0 ) ] ], ismpmode ? &function_ea91c864e6fa597b : &function_520705495475392f, ismpmode ? &"sat_training_course/activate_killstreak_objective" : &"sat_training_course/activate_killstreak_objective_br", ismpmode ? &"t10_training_course/killstreak_objective" : undefined, ismpmode ? &"sat_training_course/scorestreak_hint" : undefined, ismpmode ? &"t10_training_course/scorestreaks_hint" : undefined );
    }
    
    thread training_course_stations::completetutorial( player, tutorial );
}

// Namespace sat_training_course
// Params 2, eflags: 0x4
// Checksum 0x36766869, Offset: 0x7c9e
// Size: 0x336
function private function_121e065ede45fe1b( player, tutorial )
{
    if ( player usinggamepad() )
    {
        training_course_utils::function_a6e8c085165e0898( player, &"sat_training_course/field_upgrade_controller", 0 );
    }
    else
    {
        training_course_utils::function_a6e8c085165e0898( player, &"sat_training_course/field_upgrade_kbm", 0 );
    }
    
    if ( !training_course_utils::function_f0999c39797a8308() )
    {
        training_course_utils::function_ac53a17fd5b74658( player, &"sat_training_course/field_upgrade_hint" );
    }
    
    player perkpackage::perkpackage_giveimmediate( level.super_equipment );
    super_enemy = [ [ ( -1296, 594, 432 ), ( 0, 180, 0 ) ] ];
    hackable_agent_origin = training_course_utils::function_d58310d0f1d16d43( super_enemy[ 0 ][ 0 ], player.map_instance_index );
    var_fb3e4be54b46b262 = training_course_utils::function_2e52e3ebd7fff7bd( super_enemy[ 0 ][ 1 ], player.map_instance_index );
    hackable_agent = namespace_512cbd6ffc19387::spawnagent( hackable_agent_origin, var_fb3e4be54b46b262, 50, training_course_utils::function_3e92b89fd90af5ab( player ), 0 );
    hackable_agent perk::giveperk( "specialty_hack_immunity" );
    hackable_agent.ignoreme = 0;
    hackable_agent.turret_damage_only = 1;
    namespace_512cbd6ffc19387::function_b3d358f2f43b564c( hackable_agent, 1 );
    tutorial.enemy_array[ tutorial.enemy_array.size ] = hackable_agent;
    var_d07fb9dde1d81405 = training_course_utils::function_8658dfb45f6b84c8( player.map_instance_index )[ 0 ];
    tutorial.sentry_turret = utility::callsharedfunc( #"mini_sentry", #"spawn_directly", var_d07fb9dde1d81405, "sat_mini_sentry_mp", training_course_utils::function_d58310d0f1d16d43( ( 779, -317, 202 ), player.map_instance_index ), ( 0, 0, 0 ), training_course_utils::function_3e92b89fd90af5ab( player ), 0 );
    var_49fda05320fa9bdb = 1;
    
    while ( var_49fda05320fa9bdb )
    {
        allmines = weapon::function_3aafcaf7ff6dea9e();
        
        foreach ( mine in allmines )
        {
            if ( mine.owner == var_d07fb9dde1d81405 )
            {
                tutorial.sentry_turret = mine;
                tutorial.sentry_turret notify( #"hash_132222844eaf7009" );
                var_49fda05320fa9bdb = 0;
                break;
            }
        }
        
        waitframe();
    }
    
    outline::outlineenableforall( tutorial.sentry_turret, "outline_nodepth_red", "level_script" );
    tutorial.sentry_turret waittill( #"turret_hacked" );
    wait 1.5;
    tutorial.sentry_turret utility::callsharedfunc( #"mini_sentry", #"destroy" );
    training_course_utils::function_5e3e773127f754db( player );
    
    if ( training_course_utils::function_33427acbfd53222( player ) )
    {
        training_course_utils::function_55099ffa73b4eff1( player );
    }
    
    tutorial.enemy_array = [];
    namespace_512cbd6ffc19387::despawnagent( hackable_agent );
    player playlocalsound( "uin_t10_training_course_objective_success" );
}

// Namespace sat_training_course
// Params 2, eflags: 0x4
// Checksum 0xbd8f7793, Offset: 0x7fdc
// Size: 0xe6
function private function_6a3fd1d87fc96163( player, tutorial )
{
    tutorial.equipment_state = "super";
    
    if ( player usinggamepad() )
    {
        training_course_utils::function_a6e8c085165e0898( player, &"t10_training_course/field_upgrade_gamepad", 0 );
    }
    else
    {
        training_course_utils::function_a6e8c085165e0898( player, &"t10_training_course/field_upgrade_kbm", 0 );
    }
    
    training_course_utils::function_ac53a17fd5b74658( player, &"sat_training_course/field_upgrade_hint_br" );
    player perkpackage::perkpackage_giveimmediate( level.super_equipment );
    player waittill( #"grenade_fire", grenade );
    player supers_mp::clearsuper();
    player equipment_mp::takeequipment( "super" );
    wait 1.5;
    player equipment_mp::setequipmentslotammo( "secondary", 0 );
    player equipment_mp::setequipmentslotammo( "primary", 0 );
    training_course_utils::function_5e3e773127f754db( player );
    player playlocalsound( "uin_t10_training_course_objective_success" );
}

// Namespace sat_training_course
// Params 2, eflags: 0x4
// Checksum 0xbb5ab0ca, Offset: 0x80ca
// Size: 0x23
function private supportbox_used( player, grenade )
{
    player.support_box = grenade;
}

// Namespace sat_training_course
// Params 2, eflags: 0x4
// Checksum 0xe1048c33, Offset: 0x80f5
// Size: 0x20
function private supportbox_deleted( player, grenade )
{
    player.support_box = undefined;
}

// Namespace sat_training_course
// Params 2, eflags: 0x4
// Checksum 0x2354dd56, Offset: 0x811d
// Size: 0x8d
function private function_fb12393bf40719fa( turret, marker )
{
    turret endon( #"death" );
    turret.owner endon( #"tutorial_changed" );
    turret.owner endon( #"disconnect" );
    turret.owner.turret = turret;
    turret waittill( #"hash_db521cf8a268eb0a" );
    turret setcandamage( 0 );
    turret.useownerobj setusableenabled( 0 );
}

// Namespace sat_training_course
// Params 1, eflags: 0x4
// Checksum 0xe9538f9f, Offset: 0x81b2
// Size: 0xc
function private function_1ab097e94d229d75( turret )
{
    
}

// Namespace sat_training_course
// Params 10, eflags: 0x4
// Checksum 0x6e9d3d03, Offset: 0x81c6
// Size: 0x216
function private function_e67b0367766f83cd( player, tutorial, killstreak, on_activated_logic, var_9955c8e47741aec, agent_damage_validation_func, var_f43f637480ebcfa9, var_5c1bdda59670aac6, activate_hint_string, using_hint_string )
{
    do
    {
        if ( var_f43f637480ebcfa9 )
        {
            training_course_utils::function_a6e8c085165e0898( player, var_f43f637480ebcfa9, 0 );
        }
        
        if ( activate_hint_string )
        {
            training_course_utils::function_ac53a17fd5b74658( player, activate_hint_string );
        }
        
        player killstreaks::awardkillstreak( killstreak );
        player waittill( #"streak_activated", streak_name );
        
        if ( !player.killstreak )
        {
            player.killstreak = player.vehicle ?? player.turret;
        }
        
        childthread training_course_utils::function_740cfce5f00967a5( player );
        function_ff231d4a96017d3c( player, var_9955c8e47741aec, agent_damage_validation_func, tutorial, 0 );
        thread function_b9bbd3611eaaf5af( player, tutorial );
        
        if ( on_activated_logic )
        {
            childthread [[ on_activated_logic ]]( player, tutorial );
        }
        
        if ( var_f43f637480ebcfa9 )
        {
            training_course_utils::function_5e3e773127f754db( player );
        }
        
        if ( activate_hint_string )
        {
            training_course_utils::function_55099ffa73b4eff1( player );
        }
        
        if ( var_5c1bdda59670aac6 )
        {
            training_course_utils::function_a6e8c085165e0898( player, var_5c1bdda59670aac6, 0 );
        }
        
        if ( using_hint_string )
        {
            training_course_utils::function_ac53a17fd5b74658( player, using_hint_string );
        }
        
        msg = player utility::waittill_any_return( "killstreak_death", "target_dead" );
        
        if ( msg == "target_dead" )
        {
            if ( var_5c1bdda59670aac6 )
            {
                training_course_utils::function_5e3e773127f754db( player );
            }
            
            if ( using_hint_string )
            {
                training_course_utils::function_55099ffa73b4eff1( player );
            }
            
            break;
        }
        
        foreach ( agent in tutorial.enemy_array )
        {
            agent kill();
        }
        
        wait 2;
    }
    while ( true );
    
    wait 1.5;
    player playlocalsound( "uin_t10_training_course_objective_success" );
}

// Namespace sat_training_course
// Params 2, eflags: 0x4
// Checksum 0xf6302efb, Offset: 0x83e4
// Size: 0x51
function private function_b9bbd3611eaaf5af( player, tutorial )
{
    player endon( #"tutorial_changed" );
    player endon( #"disconnect" );
    
    while ( tutorial.enemy_array.size > 0 )
    {
        waitframe();
    }
    
    player notify( #"target_dead" );
}

// Namespace sat_training_course
// Params 2, eflags: 0x4
// Checksum 0xe5e9fdda, Offset: 0x843d
// Size: 0xc1
function private function_eb87c423ef5985ba( player, tutorial )
{
    player allowmovement( 1 );
    
    if ( player.turret )
    {
        foreach ( enemy in tutorial.enemy_array )
        {
            player.turret settargetentity( enemy );
            enemy waittill( #"death" );
            wait 1;
        }
    }
}

// Namespace sat_training_course
// Params 2, eflags: 0x4
// Checksum 0x5af961d3, Offset: 0x8506
// Size: 0x64
function private function_2194fa68cfdc92bd( player, enemy )
{
    player endon( #"tutorial_changed" );
    player endon( #"disconnect" );
    enemy.var_3b6f37acb7d85fbb = 0;
    
    while ( true )
    {
        if ( enemy.var_1f4aa153cbdc3919 )
        {
            break;
        }
        
        waitframe();
    }
    
    enemy.var_3b6f37acb7d85fbb = 1;
}

// Namespace sat_training_course
// Params 3, eflags: 0x4
// Checksum 0xd930734c, Offset: 0x8572
// Size: 0x42, Type: bool
function private function_ea91c864e6fa597b( attacker, smeansofdeath, weapon )
{
    return isdefined( weapon ) && weapon.basename == "rcxd_sat" && damage_effects::function_ae27c589e09c3181( smeansofdeath );
}

// Namespace sat_training_course
// Params 3, eflags: 0x4
// Checksum 0xdf252bdd, Offset: 0x85bd
// Size: 0x41, Type: bool
function private function_520705495475392f( attacker, smeansofdeath, weapon )
{
    return smeansofdeath == "MOD_RIFLE_BULLET" && attacker && attacker.classname == "misc_turret";
}

// Namespace sat_training_course
// Params 3, eflags: 0x4
// Checksum 0x67fb04, Offset: 0x8607
// Size: 0x26, Type: bool
function private isexplosivedamage( attacker, smeansofdeath, weapon )
{
    return smeansofdeath == "MOD_EXPLOSIVE";
}

// Namespace sat_training_course
// Params 3, eflags: 0x4
// Checksum 0x36fdc3ae, Offset: 0x8636
// Size: 0x27
function private function_3b6f37acb7d85fbb( attacker, smeansofdeath, weapon )
{
    return self.var_3b6f37acb7d85fbb;
}

// Namespace sat_training_course
// Params 3, eflags: 0x4
// Checksum 0x1bb1951, Offset: 0x8666
// Size: 0x2e, Type: bool
function private function_8ead094a1b2ffbf3( attacker, smeansofdeath, weapon )
{
    return utility::isstunned() || utility::isflashed();
}

// Namespace sat_training_course
// Params 2, eflags: 0x4
// Checksum 0x7cf74f65, Offset: 0x869d
// Size: 0x15
function private function_a76af4aa2bc4b71f( player, tutorial )
{
    
}

// Namespace sat_training_course
// Params 2, eflags: 0x4
// Checksum 0x4feb06ef, Offset: 0x86ba
// Size: 0x15
function private function_6573c78f12412c4a( player, tutorial )
{
    
}

// Namespace sat_training_course
// Params 0, eflags: 0x4
// Checksum 0x242adb49, Offset: 0x86d7
// Size: 0xab
function private function_759b1273ca979ce8()
{
    if ( !challenges::challengesenabledforplayer() )
    {
        return;
    }
    
    gamemode = challenges::getchallengegamemode();
    gametype = challenges::function_9edd00e9e48c0821();
    aeeventname = #"cer_training_emote_complete";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = gametype;
    self function_2e45314624fdfdb8( self, aeeventid, eventparams );
}

// Namespace sat_training_course
// Params 2, eflags: 0x4
// Checksum 0xd49a170a, Offset: 0x878a
// Size: 0x144
function private function_2bea643b5dba5bdc( player, tutorial )
{
    player endon( #"tutorial_changed" );
    player endon( #"disconnect" );
    wait 0.5;
    
    if ( player usinggamepad() )
    {
        training_course_utils::function_a6e8c085165e0898( player, &"sat_training_course/emote_objective_gamepad", 0 );
    }
    else
    {
        training_course_utils::function_a6e8c085165e0898( player, &"sat_training_course/emote_objective_kbm", 0 );
    }
    
    while ( !player isemoteactive() )
    {
        waitframe();
    }
    
    training_course_utils::function_5e3e773127f754db( player );
    
    while ( player isemoteactive() )
    {
        waitframe();
    }
    
    if ( player usinggamepad() )
    {
        training_course_utils::function_a6e8c085165e0898( player, &"sat_training_course/inspect_objective_gamepad", 0 );
    }
    else
    {
        training_course_utils::function_a6e8c085165e0898( player, &"sat_training_course/inspect_objective_kbm", 0 );
    }
    
    while ( !player function_985124b0e1e74f2e() )
    {
        waitframe();
    }
    
    training_course_utils::function_5e3e773127f754db( player );
    
    while ( player function_985124b0e1e74f2e() )
    {
        waitframe();
    }
    
    if ( player usinggamepad() )
    {
        training_course_utils::function_a6e8c085165e0898( player, &"sat_training_course/spray_tutorial_gamepad", 0 );
    }
    else
    {
        training_course_utils::function_a6e8c085165e0898( player, &"sat_training_course/spray_tutorial_kbm", 0 );
    }
    
    player waittill( #"used_spray" );
    training_course_utils::function_5e3e773127f754db( player );
    
    if ( false )
    {
        training_course_stations::function_bfa865dfd7b9bfd6( player, tutorial, 1 );
    }
    
    thread training_course_stations::completetutorial( player, tutorial );
}

