// scripts\mp\zm\systems\zm_rabbithole.gsc  (hash_30970d772ce45da1.gscc) (size: 8543 Bytes / 0x215f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xac8a1e0f (2894732815)
// size ...... 8543 (0x215f)
// includes .. 7   (offset: 0x1ec7)
// strings ... 43  (offset: 0x1eff)
// dev strs .. 0   (offset: 0x215f)
// exports ... 22  (offset: 0x145b)
// cseg ...... 0x413 + 0x1048 (0x145b)
// imports ... 58  (offset: 0x17cb)
// animtree1 . 0   (offset: 0x215f)
// animtree2 . 0   (offset: 0x215f)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\overlord;

#namespace zm_rabbithole;

// Namespace zm_rabbithole
// Params 0
// Checksum 0x448ff41f, Offset: 0x431
// Size: 0x1b
function function_5b9514e060bb4725()
{
    level endon( #"game_ended" );
    waittillframeend();
    audio_utility::snd_transient_load( "sat/zm_sat_rabbithole" );
}

// Namespace zm_rabbithole
// Params 1
// Checksum 0x114e785c, Offset: 0x454
// Size: 0xc8
function spawn_toybox( targetname )
{
    map_name = game_utility::getmapname();
    struct = utility::getstruct( targetname, "targetname" );
    
    if ( isdefined( struct ) )
    {
        model = spawn( "script_model", struct.origin );
        model.angles = struct.angles;
        
        if ( map_name && issubstr( map_name, "scarab" ) )
        {
            model setmodel( "reveal::sat_zm_toy_chest_rh_fxanim_wt" );
        }
        else
        {
            model setmodel( "wood::sat_zm_toy_chest_rh_fxanim" );
        }
        
        model utility::function_7c10ea82c1e305b8( "anim", "close_fast" );
        model utility::function_7c10ea82c1e305b8( "fx", "off" );
        return model;
    }
}

// Namespace zm_rabbithole
// Params 0
// Checksum 0x7ebc538e, Offset: 0x525
// Size: 0x59
function toybox_open()
{
    level endon( #"game_ended" );
    utility::function_7c10ea82c1e305b8( "anim", "open" );
    wait 0.75;
    utility::function_7c10ea82c1e305b8( "fx", "on" );
    wait 3.85;
    level thread overlord::playconversation( hashcat( #"hash_54a757e830bdc5c", randomintrange( 1, 5 ) ) );
}

// Namespace zm_rabbithole
// Params 2
// Checksum 0xc7df30fa, Offset: 0x586
// Size: 0x201
function toybox_give_reward( reward_item_name = undefined, var_678851079820a7da )
{
    var_7b598c38f81740e0 = function_71fffd152d6f61be( reward_item_name, var_678851079820a7da );
    playworldsound( var_7b598c38f81740e0.origin, #"hash_f3dc5e89d9d29de6" );
    wait 1;
    
    if ( isdefined( var_7b598c38f81740e0 ) )
    {
        var_7b598c38f81740e0 setscriptablepartstate( "dissolve", "on" );
        level thread lower_preview_item( var_7b598c38f81740e0 );
    }
    
    wait 1;
    
    if ( isdefined( self ) )
    {
        utility::function_7c10ea82c1e305b8( "fx", "off" );
    }
    
    wait 0.75;
    
    if ( isdefined( self ) )
    {
        utility::function_7c10ea82c1e305b8( "anim", "close" );
    }
    
    wait 2.25;
    
    if ( isdefined( self ) )
    {
        playworldsound( self.origin + ( 0, 0, 25 ), #"hash_1ab02da3859bc0e2" );
        thread utility::do_jitter( 1.5, 3, 0.3, 0.3, 1 );
    }
    
    wait 3;
    
    if ( isdefined( self ) )
    {
        utility::function_7c10ea82c1e305b8( "anim", "open" );
    }
    
    wait 0.8;
    
    if ( isdefined( self ) )
    {
        utility::function_7c10ea82c1e305b8( "fx", "on" );
    }
    
    wait 2;
    
    if ( isdefined( self ) )
    {
        spawnoptions = common_item::items_initspawnoptions_spawnfromposition( self.origin + ( 0, 0, 15 ) );
        common_item::function_577fe3f000fcb275( 0.1, 3, %"hash_36d1362492c2b6d", spawnoptions );
    }
    
    reward_model = function_14395f21cb8bcd9f();
    
    if ( isdefined( reward_model ) )
    {
        model = spawn_reward_model( reward_model );
    }
    
    playworldsound( model.origin, #"hash_2e2cb2adf82920fa" );
    toy_interact = interaction::register_interact( model.origin + ( 0, 0, 20 ), 78, &toy_interact_func, &toy_interact_hint );
    toy_interact.toy = model;
    
    if ( isdefined( self ) )
    {
        toy_interact.box = self;
    }
}

// Namespace zm_rabbithole
// Params 1, eflags: 0x4
// Checksum 0x6e45e367, Offset: 0x78f
// Size: 0x4f
function private lower_preview_item( var_7b598c38f81740e0 )
{
    if ( isdefined( var_7b598c38f81740e0 ) )
    {
        var_7b598c38f81740e0 moveto( var_7b598c38f81740e0.origin + ( 0, 0, -13 ), 2 );
    }
    
    var_7b598c38f81740e0 waittill( #"movedone" );
    
    if ( isdefined( var_7b598c38f81740e0 ) )
    {
        var_7b598c38f81740e0 delete();
    }
}

// Namespace zm_rabbithole
// Params 2, eflags: 0x4
// Checksum 0x672a862e, Offset: 0x7e6
// Size: 0xac
function private function_71fffd152d6f61be( item_name, angles = ( 0, 0, 0 ) )
{
    item_origin = self.origin + ( 0, 0, 12 );
    var_7b598c38f81740e0 = spawn( "script_model", item_origin );
    var_7b598c38f81740e0.angles = angles;
    var_118d756d54495b97 = "string";
    
    if ( isdefined( item_name ) )
    {
        var_118d756d54495b97 = item_name;
    }
    
    model_scale = get_model_scale( var_118d756d54495b97 );
    var_7b598c38f81740e0 setscale( model_scale );
    var_7b598c38f81740e0 setmodel( var_118d756d54495b97 );
    return var_7b598c38f81740e0;
}

// Namespace zm_rabbithole
// Params 1, eflags: 0x4
// Checksum 0x4ef47522, Offset: 0x89b
// Size: 0xb2
function private spawn_reward_model( model_name )
{
    reward_model = spawn( "script_model", self.origin );
    reward_model.angles = self.angles + get_model_angles( model_name );
    reward_model setmodel( model_name );
    reward_model setscriptablepartstate( "dissolve", "on" );
    reward_model moveto( self.origin + ( 0, 0, 20 ), 1.5 );
    reward_model waittill( #"movedone" );
    wait 0.1;
    reward_model function_616378d7e5b22efb( ( 0, 0, 1 ), 4, 3 );
    return reward_model;
}

// Namespace zm_rabbithole
// Params 1, eflags: 0x4
// Checksum 0xac23bcf1, Offset: 0x956
// Size: 0x43
function private get_model_scale( model_name )
{
    switch ( model_name )
    {
        case #"hash_dcfea6568c152aa4":
            return 8;
        case #"hash_f02b71ba2b34b0e3":
            return 4;
        default:
            return 1;
    }
}

// Namespace zm_rabbithole
// Params 1, eflags: 0x4
// Checksum 0x3dcf0f10, Offset: 0x9a1
// Size: 0xb1
function private get_model_angles( model_name )
{
    switch ( model_name )
    {
        case #"hash_5b349b36d9056c52":
            return ( 0, 90, 0 );
        case #"hash_2ac774280781065e":
            return ( 0, 90, 0 );
        case #"hash_155ad9dc4da9efea":
        case #"hash_8a0d36027f61e70e":
            return ( 0, 90, 0 );
        case #"hash_8e5d581d29fa458a":
            return ( 0, 90, 0 );
        case #"hash_810684f748f773ec":
            return ( 10, 0, 0 );
        default:
            return;
    }
}

// Namespace zm_rabbithole
// Params 1, eflags: 0x4
// Checksum 0xe3913030, Offset: 0xa5a
// Size: 0x52
function private spawn_reward_item( item_bundle )
{
    item_origin = self.origin + ( 0, 0, 24 );
    item = spawn( "item_drop", item_origin );
    item setmodel( "com_t10_icon_drop" );
    return item;
}

// Namespace zm_rabbithole
// Params 0, eflags: 0x4
// Checksum 0x57bce7e8, Offset: 0xab5
// Size: 0x8d
function private function_14395f21cb8bcd9f()
{
    mapname = level.mapname;
    
    switch ( mapname )
    {
        case #"hash_c22b93e5ab1ca835":
            return "ee_reveal::veh_sat_wc_truck_pluto_turret_small";
        case #"hash_a3b961ca8ff17958":
            return "ee_reveal::sat_zm_neptune_1_tiny";
        case #"hash_1957d230149ca5a8":
            return "ee_reveal::sat_zm_npc_sister_full";
        case #"hash_7df2a5f5c99cd50e":
            return "ee_reveal::sat_zm_triton_gtoy";
        case #"hash_775f1342bceb7a8":
            return "ee_reveal::sat_zm_phobos_tiny";
        case #"hash_9dcd979ffcf18d62":
            return "ee_reveal::sat_zm_npc_obsidian_tiny";
    }
}

// Namespace zm_rabbithole
// Params 0
// Checksum 0x180666cb, Offset: 0xb4a
// Size: 0xf0
function function_85eaee7552aadd2e()
{
    mapname = level.mapname;
    mapname = getxhash( mapname );
    
    if ( !level utility::flag( "exfil_rh_vo" ) )
    {
        level utility::flag_set( "exfil_rh_vo" );
        level thread overlord::playconversation( hashcat( #"hash_9a497399f76cde74", randomintrange( 1, 4 ) ), level.toy_collectors );
    }
    
    switch ( mapname )
    {
        case #"zm_sat_firefly":
            return #"hash_33247e43e074586c";
        case #"zm_sat_ruby":
            return #"hash_d8231004a6da13db";
        case #"zm_sat_mantis":
            return #"hash_40a87ea5e50a468b";
        case #"zm_sat_locust":
            return #"hash_58325bc2d2c7df55";
        case #"zm_sat_hornet":
            return #"hash_d9803c2cd329e3ab";
        case #"zm_sat_scarab":
            return #"hash_c4ee866a99e123b1";
    }
}

// Namespace zm_rabbithole
// Params 3
// Checksum 0x129b310, Offset: 0xc42
// Size: 0x2a7
function function_371e201f30908295( players, map, struct )
{
    level.toy_struct = struct.origin + anglestoup( struct.angles ) * 50 + anglestoforward( struct.angles ) * 10;
    
    if ( map == "zm_sat_firefly" )
    {
        level.scr_toy = utility::spawn_model( "veh_sat_wc_truck_pluto_turret_small", level.toy_struct, struct.angles );
    }
    else if ( map == "zm_sat_ruby" )
    {
        level.scr_toy = utility::spawn_model( "sat_zm_neptune_1_tiny", level.toy_struct, struct.angles + ( 0, 90, 0 ) );
    }
    else if ( map == "zm_sat_mantis" )
    {
        level.scr_toy = utility::spawn_model( "sat_zm_npc_sister_full", level.toy_struct, struct.angles + ( 0, 90, 0 ) );
    }
    else if ( map == "zm_sat_locust" )
    {
        level.scr_toy = utility::spawn_model( "sat_zm_triton_gtoy", level.toy_struct, struct.angles + ( 0, 90, 0 ) );
    }
    else if ( map == "zm_sat_hornet" )
    {
        level.scr_toy = utility::spawn_model( "sat_zm_phobos_tiny", level.toy_struct, struct.angles );
    }
    else if ( map == "zm_sat_scarab" )
    {
        level.scr_toy = utility::spawn_model( "sat_zm_npc_obsidian_tiny", level.toy_struct, struct.angles + ( 0, 90, 0 ) );
    }
    
    level.scr_toy thread bob_item( 1, 3 );
    
    foreach ( player in level.players )
    {
        if ( arraycontains( players, player ) )
        {
            if ( player.var_e8b776e9698cb857 )
            {
                level.scr_toy showtoplayer( player );
                level.toy_collectors[ level.toy_collectors.size ] = player;
            }
            
            continue;
        }
        
        level.scr_toy hidefromplayer( player );
    }
}

// Namespace zm_rabbithole
// Params 1
// Checksum 0xf3c6f714, Offset: 0xef1
// Size: 0xf4
function toy_interact_func( player )
{
    level utility::flag_set( "rh_to_pic" );
    
    foreach ( player in level.players )
    {
        if ( player.var_30a6c57505d1119b )
        {
            player.var_e8b776e9698cb857 = 1;
        }
    }
    
    level callback::add( "zm_exfil_started", &function_53fdd6fbf4ea0fa9 );
    playworldsound( self.toy.origin, #"hash_d8047720d352b10f" );
    self.toy delete();
    self.box thread function_c85e88c33f0131fb();
    self delete();
}

// Namespace zm_rabbithole
// Params 1
// Checksum 0x7c9677f1, Offset: 0xfed
// Size: 0xff
function function_53fdd6fbf4ea0fa9( params )
{
    level endon( #"game_ended" );
    players = params.a_exfil_players;
    map = level.mapname;
    struct = params.s_exfil.var_d867cc41c15a2fd1;
    wait 2;
    level.toy_collectors = [];
    function_371e201f30908295( players, map, struct );
    level waittill( #"exfil_escape_step_start" );
    var_8eed9ad62bdcb121 = level.toy_struct + anglestoforward( struct.angles ) * -7;
    wait 3;
    
    if ( level.scr_toy )
    {
        level.scr_toy notify( #"toy_exit" );
        level.scr_toy moveto( var_8eed9ad62bdcb121, 3 );
        wait 3;
        
        if ( isdefined( level.scr_toy ) )
        {
            level.scr_toy delete();
        }
    }
}

// Namespace zm_rabbithole
// Params 2
// Checksum 0x2c5b09f8, Offset: 0x10f4
// Size: 0x36
function toy_interact_hint( interact, player )
{
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_rabbithole
// Params 0
// Checksum 0x6c6ace43, Offset: 0x1133
// Size: 0x137
function function_c85e88c33f0131fb()
{
    self endon( #"death" );
    utility::function_7c10ea82c1e305b8( "fx", "off" );
    wait 1;
    utility::function_7c10ea82c1e305b8( "anim", "close" );
    wait 2.3;
    playworldsound( self.origin + ( 0, 0, 25 ), #"hash_e4901f268a047ef5" );
    raise_height = 50;
    var_5717e828fac0485a = 0.75;
    self moveto( self.origin + ( 0, 0, raise_height ), var_5717e828fac0485a, var_5717e828fac0485a * 0.5, 0 );
    wait var_5717e828fac0485a;
    utility::function_7c10ea82c1e305b8( "leaving", "on" );
    function_8e89e6d50a8269f2( 3 );
    utility::function_7c10ea82c1e305b8( "leaving", "off" );
    sky_height = 20000;
    sky_time = 5.5;
    target_origin = self.origin + ( 0, 0, sky_height );
    self moveto( target_origin, sky_time, sky_time * 0.25, sky_time * 0.25 );
    self waittill( #"movedone" );
    level thread function_1c6c02f0af873754();
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace zm_rabbithole
// Params 1, eflags: 0x4
// Checksum 0xbb07cc6a, Offset: 0x1272
// Size: 0x9f
function private function_8e89e6d50a8269f2( duration_seconds )
{
    self endon( #"death" );
    end_time = gettime() + duration_seconds * 1000;
    spin_step = 45;
    spin_wait = 0.05;
    saved_angles = self.angles;
    
    while ( gettime() < end_time )
    {
        self.angles += ( spin_step, 0, 0 );
        wait spin_wait;
    }
    
    self rotateto( saved_angles, 0.1 );
    self waittill( #"rotatedone" );
}

// Namespace zm_rabbithole
// Params 2
// Checksum 0x46bf142e, Offset: 0x1319
// Size: 0x9d
function bob_item( bobspeed, height )
{
    self endon( #"death" );
    self endon( #"toy_exit" );
    level endon( #"game_ended" );
    self movez( height, 0.1 );
    self waittill( #"movedone" );
    move_dir = 1;
    acceleration_const = bobspeed * 0.25;
    
    while ( isdefined( self ) )
    {
        self movez( height * move_dir, bobspeed, acceleration_const, acceleration_const );
        self waittill( #"movedone" );
        move_dir *= -1;
    }
}

// Namespace zm_rabbithole
// Params 0
// Checksum 0x6c2a6316, Offset: 0x13be
// Size: 0x6a
function function_1c6c02f0af873754()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "zm_init_done" );
    level utility::flag_wait( "begin_round_logic" );
    level.var_4c33e1cd56ccc717 = getent( "rh_col_coffin", "targetname" );
    
    if ( !isdefined( level.var_4c33e1cd56ccc717 ) )
    {
        return;
    }
    
    level.var_4c33e1cd56ccc717 connectpaths();
    level.var_4c33e1cd56ccc717 notsolid();
}

// Namespace zm_rabbithole
// Params 0
// Checksum 0xf9a2d0e0, Offset: 0x1430
// Size: 0x2b
function function_b422525417f4cda2()
{
    if ( isdefined( level.var_4c33e1cd56ccc717 ) )
    {
        level.var_4c33e1cd56ccc717 disconnectpaths();
        level.var_4c33e1cd56ccc717 solid();
    }
}

