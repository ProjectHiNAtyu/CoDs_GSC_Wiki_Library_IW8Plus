// scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_ee_turret.gsc  (hash_7bd7b80526d849fb.gscc) (size: 9108 Bytes / 0x2394 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6dab4633 (1839941171)
// size ...... 9108 (0x2394)
// includes .. 15  (offset: 0x209c)
// strings ... 43  (offset: 0x2114)
// dev strs .. 1   (offset: 0x2388)
// exports ... 20  (offset: 0x1230)
// cseg ...... 0x397 + 0xe99 (0x1230)
// imports ... 96  (offset: 0x1550)
// animtree1 . 0   (offset: 0x2394)
// animtree2 . 0   (offset: 0x2394)
#using scripts\common\ai\aitypes\shared\zombie\zombie_damage;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_spawn;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\common\weapons\lightning_chain;
#using scripts\mp\loot\common_item;
#using scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_ee_turret_cs;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;
#using scripts\vehicle\pluto\pluto_shared;

#namespace zm_sat_ruby_ee_turret;

// Namespace zm_sat_ruby_ee_turret
// Params 0, eflags: 0x5
// Checksum 0x7c37c86c, Offset: 0x3b5
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"hash_a2ebcc318a0a3073", #"zm_quest", &function_dd8ace13231bc6e8, &function_2dd013ce82e7b719 );
}

// Namespace zm_sat_ruby_ee_turret
// Params 0, eflags: 0x4
// Checksum 0x1bd1804e, Offset: 0x3e2
// Size: 0xb0
function private function_dd8ace13231bc6e8()
{
    if ( !getdvarint( @"hash_3a9ff30b9c2ea1f1", 0 ) || !getmatchrulesdata( "zmData", "sideContentEnabled" ) )
    {
        return;
    }
    
    level.var_fa86d6be519d387c = zm_quest::get_quest( #"hash_a2ebcc318a0a3073" );
    zm_quest::register_quest_step( #"hash_a2ebcc318a0a3073", #"make_path", &setup_make_path, &make_path_complete );
    zm_quest::register_quest_step( #"hash_a2ebcc318a0a3073", #"pickup_barrel", &setup_pickup_barrel, &pickup_barrel_complete );
    zm_quest::register_quest_step( #"hash_a2ebcc318a0a3073", #"repair_turret", &setup_build_turret, &build_turret_complete );
    zm_sat_ruby_ee_turret_cs::main();
}

// Namespace zm_sat_ruby_ee_turret
// Params 0, eflags: 0x4
// Checksum 0xd2e3ef6b, Offset: 0x49a
// Size: 0x65
function private function_2dd013ce82e7b719()
{
    e_path_clip = getent( "ee_ruby_rock_path_clip", #targetname );
    e_path_clip notsolid();
    
    if ( !getdvarint( @"hash_3a9ff30b9c2ea1f1", 0 ) || !getmatchrulesdata( "zmData", "sideContentEnabled" ) )
    {
        return;
    }
    
    zm_save::function_1f44a48caae2acbf();
    level thread zm_quest::start_quest( #"hash_a2ebcc318a0a3073" );
}

// Namespace zm_sat_ruby_ee_turret
// Params 2, eflags: 0x4
// Checksum 0x708cbb09, Offset: 0x507
// Size: 0x51
function private setup_make_path( b_skipped, b_save_restored )
{
    level utility::flag_wait( "begin_round_logic" );
    level utility::flag_wait( "scriptables_ready" );
    
    /#
        if ( getdvarint( @"ruby_turret_debug", 0 ) )
        {
            build_turret_complete();
        }
    #/
    
    function_ee3b563f49823bb3();
}

// Namespace zm_sat_ruby_ee_turret
// Params 0, eflags: 0x4
// Checksum 0x5f75f9bd, Offset: 0x560
// Size: 0x147
function private function_ee3b563f49823bb3()
{
    var_f004548ba7fd3b91 = getent( "ee_ruby_rock_start", #targetname );
    var_34e522a66e946a91 = getent( "ee_ruby_rock_link", #targetname );
    var_34e522a66e946a91 linkto( var_f004548ba7fd3b91 );
    var_f004548ba7fd3b91 bobbing( ( 0, 0, 1 ), 5, 5 );
    var_f004548ba7fd3b91 setcandamage( 1 );
    
    while ( true )
    {
        var_f004548ba7fd3b91 waittill( #"damage", idamage, eattacker, vdir, vpoint, smeansofdeath, modelname, attachtagname, partname, dflags, objweapon );
        
        if ( isplayer( eattacker ) && ( zombie_damage::is_explosive_damage( smeansofdeath ) || smeansofdeath == "MOD_GRENADE" ) && idamage > 25 )
        {
            str_name = objweapon.basename;
            
            if ( str_name && ( issubstr( str_name, "raygun" ) || issubstr( str_name, "molotov" ) ) )
            {
                continue;
            }
            
            break;
        }
    }
}

// Namespace zm_sat_ruby_ee_turret
// Params 0, eflags: 0x4
// Checksum 0x110b9e20, Offset: 0x6af
// Size: 0x166
function private function_213ef1b5174652b8()
{
    var_f004548ba7fd3b91 = getent( "ee_ruby_rock_start", #targetname );
    var_f004548ba7fd3b91 bobbing( ( 0, 0, 0 ), 1, 1 );
    var_34e522a66e946a91 = getent( "ee_ruby_rock_link", #targetname );
    var_34e522a66e946a91 unlink();
    s_away = utility::getstruct( "ee_ruby_rock_away" );
    var_34e522a66e946a91 moveto( s_away.origin, 16 );
    var_34e522a66e946a91 rotateto( s_away.angles, 8.2, 0.1, 8 );
    var_f78511be97bccc3f = utility::getstruct( "ee_ruby_rock_path" );
    var_f004548ba7fd3b91 moveto( var_f78511be97bccc3f.origin, 5, 0.1, 4.8 );
    var_f004548ba7fd3b91 rotateto( var_f78511be97bccc3f.angles, 5.2, 0.1, 5 );
    wait 5.2;
    e_path_clip = getent( "ee_ruby_rock_path_clip", #targetname );
    e_path_clip solid();
    e_path_clip linkto( var_f004548ba7fd3b91 );
    var_f004548ba7fd3b91 bobbing( anglestoup( var_f004548ba7fd3b91.angles ), 3, 7 );
    var_34e522a66e946a91 waittill( #"rotatedone" );
    var_34e522a66e946a91 bobbing( anglestoup( var_34e522a66e946a91.angles ), 5, 8 );
}

// Namespace zm_sat_ruby_ee_turret
// Params 2, eflags: 0x4
// Checksum 0x3a16d92e, Offset: 0x81d
// Size: 0x4d
function private make_path_complete( b_skipped, b_save_restored )
{
    level thread function_213ef1b5174652b8();
    
    if ( b_skipped || b_save_restored )
    {
        e_path_clip = getent( "ee_ruby_rock_path_clip", #targetname );
        e_path_clip solid();
    }
}

// Namespace zm_sat_ruby_ee_turret
// Params 2, eflags: 0x4
// Checksum 0x2ca335b2, Offset: 0x872
// Size: 0x47
function private setup_pickup_barrel( b_skipped, b_save_restored )
{
    level thread function_660074fc26e56f55();
    
    if ( b_skipped && !level utility::flag( "ee_path_item_spawned" ) )
    {
        spawn_turret_item();
    }
    
    level utility::flag_wait( "ee_path_item_picked_up" );
}

// Namespace zm_sat_ruby_ee_turret
// Params 0, eflags: 0x4
// Checksum 0x3ae0f18b, Offset: 0x8c1
// Size: 0x138
function private function_660074fc26e56f55()
{
    trigger = getnoentvolumearray( "ee_ruby_rock_path_trigger", #targetname )[ 0 ];
    var_f78511be97bccc3f = utility::getstruct( "ee_ruby_rock_path_start" );
    a_path_points = [];
    
    while ( var_f78511be97bccc3f.target )
    {
        a_path_points[ a_path_points.size ] = var_f78511be97bccc3f.origin;
        var_f78511be97bccc3f = utility::getstruct( var_f78511be97bccc3f.target );
    }
    
    a_path_points[ a_path_points.size ] = var_f78511be97bccc3f.origin;
    
    while ( true )
    {
        trigger waittill( #"trigger", player );
        
        if ( isplayer( player ) && !player.var_f6742b0008b02246 )
        {
            player.var_f6742b0008b02246 = 1;
            player val::set( "ee_ruby_rock_path", "ignore_playable_area_check", 1 );
            player val::set( "ee_ruby_rock_path", "killstreaks", 0 );
            player val::set( "ee_ruby_rock_path", "weapon", 0 );
            player zm_quest::disable_specific_player_bgb( 1 );
            player thread function_ef0417f858311e7b( a_path_points );
            
            if ( !level utility::flag( "ee_path_item_spawned" ) )
            {
                spawn_turret_item();
            }
        }
    }
}

// Namespace zm_sat_ruby_ee_turret
// Params 1, eflags: 0x4
// Checksum 0x4c3cfa4a, Offset: 0xa01
// Size: 0x1e1
function private function_ef0417f858311e7b( a_path_points )
{
    self endon( #"death_or_disconnect" );
    e_mover = utility::spawn_model( "tag_origin", self.origin, self.angles );
    musicbank_utility::function_fc6bd251f203728e();
    self.musicbankparams[ "cooldownEndTimes" ] = [];
    level musicbank_utility::function_5aca66c390aa347d( self, #"hash_ce18df08d0861bba" );
    var_15598453bb30f76e = self getcamerathirdperson();
    
    if ( var_15598453bb30f76e )
    {
        self setcamerathirdperson( 0 );
        self setclientomnvar( "ui_toggle_third_person", 0 );
    }
    
    val::set( "ruby_ee_space", "allow_toggle_third_person", 0 );
    self playerlinkto( e_mover, "tag_origin", 1, 45, 45, 45, 10 );
    self capturnrate( 18, 18 );
    s_start = utility::getstruct( "ee_ruby_rock_path_start" );
    e_mover rotateto( s_start.angles, 1 );
    a_path_points = arraycombine( [ self.origin ], a_path_points );
    e_mover thread utility::function_2159dd4196ff4b81( a_path_points, 47.5, 0, 0, 0, 1 );
    var_4b4e6b999024cf0d = utility::getstruct( "ee_ruby_rock_path_end" );
    e_mover utility::delaycall( 32.5, &rotateto, var_4b4e6b999024cf0d.angles + ( -15, 0, 0 ), 10 );
    e_mover waittill( #"stop_curve" );
    self unlink( 1 );
    e_mover delete();
    self knockback( ( 0, 0, -1 ), 666 );
    self capturnrate( 999, 999 );
    val::reset( "ruby_ee_space", "allow_toggle_third_person" );
    
    if ( var_15598453bb30f76e )
    {
        self setcamerathirdperson( 1 );
        self setclientomnvar( "ui_toggle_third_person", 1 );
    }
    
    self.var_f6742b0008b02246 = undefined;
    zm_quest::disable_specific_player_bgb( 0 );
    val::reset_all( "ee_ruby_rock_path" );
}

// Namespace zm_sat_ruby_ee_turret
// Params 0, eflags: 0x4
// Checksum 0xade39556, Offset: 0xbea
// Size: 0xd4
function private spawn_turret_item()
{
    level utility::flag_set( "ee_path_item_spawned" );
    var_c5fb7b9c0ca383b7 = utility::getstruct( "ee_ruby_path_item" );
    spawnoptions = common_item::function_bc5ff2958b71a708( var_c5fb7b9c0ca383b7.origin, var_c5fb7b9c0ca383b7.angles );
    spawnoptions.var_fd47e835523b473f = 1;
    spawnoptions.dropradiusscale = 0;
    spawnoptions.critical = 1;
    level.var_fa86d6be519d387c.var_d5a2309951a61519 = common_item::function_61c2c0251e742ffd( %"hash_4cd553126f3209b7", 1, spawnoptions );
    level.var_fa86d6be519d387c.var_d5a2309951a61519 setscriptablepartstate( "zmloot_quest_firefly_pluto_mg_part", "bobbing_no_collision" );
    level callback::add( #"player_item_pickup", &function_b86685df79c29a4a );
}

// Namespace zm_sat_ruby_ee_turret
// Params 1, eflags: 0x4
// Checksum 0x3224235f, Offset: 0xcc6
// Size: 0x51
function private function_b86685df79c29a4a( params )
{
    if ( params.item == level.var_fa86d6be519d387c.var_d5a2309951a61519 )
    {
        level utility::flag_set( "ee_path_item_picked_up" );
        level callback::remove( #"player_item_pickup", &function_b86685df79c29a4a );
    }
}

// Namespace zm_sat_ruby_ee_turret
// Params 2, eflags: 0x4
// Checksum 0xd201803e, Offset: 0xd1f
// Size: 0x5c
function private pickup_barrel_complete( b_skipped, b_save_restored )
{
    level utility::flag_set( "ee_path_item_picked_up" );
    
    if ( ( b_skipped || b_save_restored ) && level.var_fa86d6be519d387c.var_d5a2309951a61519 )
    {
        level.var_fa86d6be519d387c.var_d5a2309951a61519 freescriptable();
    }
}

// Namespace zm_sat_ruby_ee_turret
// Params 2, eflags: 0x4
// Checksum 0x62e92dc, Offset: 0xd83
// Size: 0x35
function private setup_build_turret( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    setup_build_turret_interact();
    level utility::flag_wait( "ruby_ee_spawn_turret" );
}

// Namespace zm_sat_ruby_ee_turret
// Params 0, eflags: 0x4
// Checksum 0x8898607e, Offset: 0xdc0
// Size: 0x6c
function private setup_build_turret_interact()
{
    var_e3317567061a2182 = utility::getstruct( "ee_ruby_turret" );
    interact = zm_quest::function_91f9590e98d57ff6( var_e3317567061a2182.origin + ( 0, 0, 16 ), &build_turret_callback );
    interact setscriptablepartstate( "base", "hidden" );
    level utility::flag_wait( "ruby_ee_spawn_turret" );
    interact freescriptable();
}

// Namespace zm_sat_ruby_ee_turret
// Params 1, eflags: 0x4
// Checksum 0x218b314e, Offset: 0xe34
// Size: 0xd0
function private build_turret_callback( player )
{
    player playrumblelooponentity( "low_highfreq" );
    params = { #save_progress:1, #saved_use_object:self, #hud_description:&"hash_7ce37613092acab7", #use_object:self, #hold_time:5, #craft_reason:#"hash_d7b4bb5f9df45654" };
    result = player zm_quest::function_e4eb2d1c1bd8fc4e( params );
    
    if ( result )
    {
        level utility::flag_set( "ruby_ee_spawn_turret" );
        
        if ( self.var_d8e3b07237845727 )
        {
            self.var_d8e3b07237845727 = arrayremove( self.var_d8e3b07237845727, &build_turret_callback );
        }
    }
    
    if ( player )
    {
        player stoprumble( "low_highfreq" );
    }
}

// Namespace zm_sat_ruby_ee_turret
// Params 0, eflags: 0x4
// Checksum 0x12292b07, Offset: 0xf0c
// Size: 0xc9
function private function_915539c58be93a3e()
{
    var_e3317567061a2182 = utility::getstruct( "ee_ruby_turret" );
    spawndata = { #targetname:"veh_sat_zm_ee_ruby_turret", #angles:var_e3317567061a2182.angles, #origin:var_e3317567061a2182.origin };
    spawndata vehicle_spawn::set_flag( 12 );
    faildata = spawnstruct();
    turret = vehicle::spawn( "veh_sat_zm_ee_ruby_turret", spawndata, faildata );
    level.wonder_veh = turret;
    turret setcandamage( 0 );
    turret setscriptablepartstate( "turret_fx", "turret_fx_on" );
    turret setscriptablepartstate( "single", "vehicle_use" );
    turret thread function_3847cbd0e2d48fa();
}

// Namespace zm_sat_ruby_ee_turret
// Params 2, eflags: 0x4
// Checksum 0x16d4a676, Offset: 0xfdd
// Size: 0x74
function private build_turret_complete( b_skipped, b_save_restored )
{
    pluto_veh::function_978dcc37106478e( %"hash_7d9d7a9c4a0829f" );
    function_915539c58be93a3e();
    e_tessie = getent( "ruby_crashed_turret", #targetname );
    e_tessie connectpaths();
    var_e31b595076222716 = getent( "ruby_crashed_turret", #targetname );
    var_e31b595076222716 delete();
}

// Namespace zm_sat_ruby_ee_turret
// Params 0, eflags: 0x4
// Checksum 0x4f7e1428, Offset: 0x1059
// Size: 0x1d7
function private function_3847cbd0e2d48fa()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"missile_fire", projectile, objweapon );
        v_loc = self gettagorigin( "tag_gunner_flash1" );
        a_ai = getaiarrayinradius( v_loc, 64, level.var_ece703e3d116381c );
        
        if ( a_ai.size && self.occupants && self.occupants.size )
        {
            player = self.occupants[ "gunner" ];
            v_eye = player utility::get_player_camera_origin();
            trace = trace::ray_trace_ents( v_eye, v_loc, a_ai );
            
            if ( trace[ "entity" ] )
            {
                /#
                    iprintlnbold( "<dev string:x24>" );
                #/
                
                projectile.var_e76eebdb259e385b = 1;
                player.var_40619328d00ca2e0 = 1;
                player.var_6a8018c50244433a = undefined;
                player.var_9f9a21aa61089e2e = 0;
                player.var_35ff0d14f2a02cd = 1;
                var_ff9dff6d5982ce27 = structcopy( level.var_3bcb3c1cbfd1e8fd );
                var_ff9dff6d5982ce27.weapon = objweapon;
                var_ff9dff6d5982ce27.attacker = player;
                var_ff9dff6d5982ce27.lc_id = string( player getentitynumber() ) + gettime();
                var_ff9dff6d5982ce27.source_enemy = trace[ "entity" ];
                var_ff9dff6d5982ce27.arc_origin = trace[ "position" ];
                var_ff9dff6d5982ce27.inflictor = level.wonder_veh;
                var_ff9dff6d5982ce27.use_inflictor = 1;
                trace[ "entity" ] thread lightning_chain::arc_damage( trace[ "entity" ], player, var_ff9dff6d5982ce27 );
                projectile detonate();
            }
        }
    }
}

