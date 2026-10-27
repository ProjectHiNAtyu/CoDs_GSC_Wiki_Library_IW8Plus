// script_12d12dfba5c3f0a3  (hash_12d12dfba5c3f0a3.gscc) (size: 11789 Bytes / 0x2e0d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x39278f0c (958893836)
// size ...... 11789 (0x2e0d)
// includes .. 19  (offset: 0x2b3d)
// strings ... 36  (offset: 0x2bd5)
// dev strs .. 4   (offset: 0x2ddd)
// exports ... 33  (offset: 0x19fd)
// cseg ...... 0x302 + 0x16fb (0x19fd)
// imports ... 105 (offset: 0x1f25)
// animtree1 . 0   (offset: 0x2e0d)
// animtree2 . 0   (offset: 0x2e0d)
#using script_31ee2a173f3499b7;
#using script_4ce55cfc81c444ad;
#using script_54a05cbb2455bc6f;
#using script_87170f8cc7bd7f6;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_bonus_room;
#using scripts\mp\zm\ztron\ztron_camera;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_slayer;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace ztron_bonus_room_fate;

// Namespace ztron_bonus_room_fate
// Params 0, eflags: 0x5
// Checksum 0xc437a011, Offset: 0x320
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"ztron_bonus_room_fate", undefined, undefined, &init );
}

// Namespace ztron_bonus_room_fate
// Params 0
// Checksum 0x82697a1d, Offset: 0x341
// Size: 0x13
function init()
{
    thread initfate();
    
    /#
        function_3eb74ef492f967ef();
    #/
}

// Namespace ztron_bonus_room_fate
// Params 0
// Checksum 0xab476e09, Offset: 0x35c
// Size: 0x9e
function initfate()
{
    level utility::flag_wait( "ztron_bonus_room_initialized" );
    var_a8d8980c65b4b0de = ztron_bonus_room::function_98dedbfc79dc3572( "fate" );
    
    if ( var_a8d8980c65b4b0de.size > 0 )
    {
        foreach ( room in var_a8d8980c65b4b0de )
        {
            room function_1ce8c160c5e81dff();
        }
    }
}

// Namespace ztron_bonus_room_fate
// Params 0
// Checksum 0xc356a1f8, Offset: 0x402
// Size: 0x1a5
function function_1ce8c160c5e81dff()
{
    self.roomtrigger = ztron_util::function_95ca81ff822c3de4( "room_of_fate_shaft_trigger", #targetname );
    self.roomtrigger triggerdisable();
    self.notimeout = 1;
    self.enemyspawns = utility::getstructarray( self.name + "_enemy_spawn", "targetname" );
    self.enemytriggers = ztron_util::function_2d9de5c7b97db39( self.name + "_enemy_trigger", #targetname );
    self.roomblocker = utility::getstruct( self.name + "_blocker_top", "targetname" );
    self.fpcardslots = utility::getstructarray( "bonus_" + self.name + "_pickup_fpcard", "targetname" );
    self.bosstrigger = ztron_util::function_95ca81ff822c3de4( self.name + "_boss_trigger", #targetname );
    self.var_aa82eadeb4a43cfa = utility::getstructarray( "bonus_" + self.name + "_player_bosspoint", "targetname" );
    self.var_d16ba431d9e4a651 = ztron_util::function_95ca81ff822c3de4( self.name + "_blocker_top_clip", #targetname );
    self.slayermarts = utility::getstructarray( "bonus_" + self.name + "_slayerMart", "targetname" );
    self.var_2c482fe40c873005 = utility::getstructarray( "bonus_" + self.name + "_coinChest", "targetname" );
    self.setupcallback = &function_f37eee65c6002c36;
}

// Namespace ztron_bonus_room_fate
// Params 1
// Checksum 0x1fe66aa2, Offset: 0x5af
// Size: 0x164
function function_f37eee65c6002c36( room )
{
    level.ztron.var_a700dfcc9277d4e9 = 1;
    level.ztron.var_bcfb9c8ab89ea6e6 = &ztron_ui::function_e8ba2d9576176792;
    level.var_8972cc8b6869f399 = 1;
    level.ztron.var_d1004540ba0cd3ff = 0;
    level callback::add( "on_zombie_ai_killed", &function_7658ea667d0df3c );
    ztron_ui::function_8a888030d7860092( 1 );
    level thread function_39983643ac3bb113( room );
    room.roomtrigger triggerdisable();
    
    if ( room.var_d16ba431d9e4a651 )
    {
        room.var_d16ba431d9e4a651 solid();
    }
    
    foreach ( coinchest in room.var_2c482fe40c873005 )
    {
        level thread room_shadow_vault::function_fb961359a846b86a( coinchest, 13, 4 );
    }
    
    room thread spawnenemies();
    room thread function_f32b228161675787();
    room thread fategameplay();
    room thread function_d703ceea9769be94();
    room thread function_1d9c7c0c25c28421();
    ztron_camera::function_a33f5a3220dee73e( 1 );
}

// Namespace ztron_bonus_room_fate
// Params 1
// Checksum 0xccaa312e, Offset: 0x71b
// Size: 0x97
function function_1d9c7c0c25c28421( timeout = 600 )
{
    self notify( #"hash_c0e019e31c38261c" );
    self endon( #"hash_c0e019e31c38261c" );
    level endon( #"bonus_room_expired" );
    level endon( #"bonus_room_exit_taken" );
    ztron_ui::function_f41315c660256627( timeout * 1000 );
    msg = utility::waittill_any_timeout( timeout, "enter_room_of_fate" );
    ztron_ui::function_ce7fbecb1ea8d56f();
    
    if ( msg == "enter_room_of_fate" )
    {
        level waittill( #"fateexited" );
    }
    
    self notify( #"room_done" );
}

// Namespace ztron_bonus_room_fate
// Params 1
// Checksum 0x4b63c6fa, Offset: 0x7ba
// Size: 0x74
function function_7658ea667d0df3c( params )
{
    if ( self.var_71c2b26838e90f44.name == "zursa" )
    {
        level notify( #"hash_e937c19bfb7cb725" );
        return;
    }
    
    if ( self.var_71c2b26838e90f44.name == "mangler_hvt" )
    {
        level.ztron.var_d1004540ba0cd3ff = 1;
        level thread function_2d101172f3c2510e( self, params );
    }
}

// Namespace ztron_bonus_room_fate
// Params 2, eflags: 0xc
// Checksum 0xdab6aab4, Offset: 0x836
// Size: 0x97
function private function_2d101172f3c2510e( ai, params )
{
    self notify( #"hash_595c442962fc5299" );
    self endon( #"hash_595c442962fc5299" );
    level endon( #"ztron_game_is_over" );
    killer = params.eattacker;
    
    if ( isplayer( killer ) )
    {
        killer ztron_dialog::function_7e3f6329d9afcdc1( #"hash_1350bdc96d8737ca", 0, 0 );
    }
    
    waitframe();
    displayent = ai getcorpseentity();
    
    if ( displayent )
    {
        displayent ztron_dialog::function_7e3f6329d9afcdc1( #"hash_d13785f719a16f72", 0, 0 );
    }
}

// Namespace ztron_bonus_room_fate
// Params 0
// Checksum 0xe6e9d796, Offset: 0x8d5
// Size: 0x7d
function function_d703ceea9769be94()
{
    self notify( #"hash_bb14b2561fab9073" );
    self endon( #"hash_bb14b2561fab9073" );
    level endon( #"bonus_room_expired" );
    level endon( #"bonus_room_exit_taken" );
    self endon( #"enter_room_of_fate" );
    self endon( #"room_done" );
    function_71edd835144a0ffb();
    level waittill( #"hash_e937c19bfb7cb725" );
    wait 3;
    function_f71252ba964e318();
    self.roomtrigger triggerenable();
    function_ac73ae393553f2b();
}

// Namespace ztron_bonus_room_fate
// Params 1, eflags: 0xc
// Checksum 0x6e996b61, Offset: 0x95a
// Size: 0x13a
function private function_39983643ac3bb113( room )
{
    self notify( #"hash_ffa96a0f19cf885" );
    self endon( #"hash_ffa96a0f19cf885" );
    result = level utility::waittill_any_return( "bonus_room_expired", "ztron_game_is_over", "bonus_room_exit_taken", "deactivate_bonus_room" );
    level notify( #"slayermart_cleanup" );
    level.ztron.var_bcfb9c8ab89ea6e6 = undefined;
    level.ztron.var_a700dfcc9277d4e9 = undefined;
    ztron_ui::function_8a888030d7860092( -1 );
    
    if ( isdefined( room.roomtrigger ) )
    {
        room.roomtrigger triggerdisable();
    }
    
    room function_be6b36b0156d61d8();
    level callback::remove( "on_zombie_ai_killed", &function_7658ea667d0df3c );
    room function_dac02ddd2ab8a1b9();
    
    if ( level.ztron.var_371903e5801e0e08 )
    {
        level.ztron.var_bdbf6cf2011e0b2d = ztron_arena::function_973956bb5a6e60f7( "lava_cave" ).id;
        level.ztron.var_a58d52a0faa75a57[ level.ztron.var_a58d52a0faa75a57.size ] = 0;
    }
    
    ztron_camera::function_a33f5a3220dee73e( 0 );
}

// Namespace ztron_bonus_room_fate
// Params 2, eflags: 0xc
// Checksum 0x4225e859, Offset: 0xa9c
// Size: 0x108
function private function_c7f6c537e713045f( triggerplayer, origin )
{
    self notify( #"hash_95f6ef086ea2212d" );
    self endon( #"hash_95f6ef086ea2212d" );
    self endon( #"disconnect" );
    player = self;
    var_4f958026b93b4d8f = player === triggerplayer;
    
    if ( !var_4f958026b93b4d8f )
    {
        if ( !isalive( player ) || player.ztron.var_2c44544a01cc415e )
        {
            player ztron_player_utility::playerrespawnnow();
        }
        
        player ztron_camera::function_9fbc0b40b3c0f437( 1 );
        player ztron_util::teleport_player( origin, player.angles );
        wait 0.1;
        player ztron_camera::function_9fbc0b40b3c0f437( 0 );
    }
    
    player thread ztron_player_utility::function_985a085be4ea0ba4( 0 );
    player val::set( "ztron_bonus_room_fate", "allow_movement", 0 );
    cameradown = 44;
    player ztron_camera::function_94c683cd71e7ae65( cameradown );
    velocity = player getvelocity();
    player setvelocity( ( 0, 0, velocity[ 2 ] ) );
}

// Namespace ztron_bonus_room_fate
// Params 0, eflags: 0xc
// Checksum 0xe6f8266e, Offset: 0xbac
// Size: 0x2cf
function private fategameplay()
{
    self notify( #"hash_2487a23009c9df52" );
    self endon( #"hash_2487a23009c9df52" );
    level endon( #"bonus_room_expired" );
    level endon( #"bonus_room_exit_taken" );
    level notify( #"the_long_climb" );
    triggerplayer = self.roomtrigger function_dce8dfe3798b2bdd();
    self.roomtrigger triggerdisable();
    function_dac02ddd2ab8a1b9();
    self notify( #"enter_room_of_fate" );
    level.ztron.var_db337c72253293a4 = 1;
    
    foreach ( player in level.players )
    {
        player notify( #"ztron_player_dump_vehicle" );
        player notify( #"force_close_store" );
    }
    
    waitframe();
    level.ztron.disable_boosting = 1;
    level.ztron.var_a700dfcc9277d4e9 = undefined;
    
    foreach ( player in level.players )
    {
        player ztron_camera::function_9d8dc9576769d96b( undefined, 1 );
        player thread function_c7f6c537e713045f( triggerplayer, self.roomtrigger.origin );
    }
    
    ztron_ui::function_8a888030d7860092( -1 );
    wait 4;
    
    foreach ( player in level.players )
    {
        player val::reset_all( "ztron_bonus_room_fate" );
        player ztron_camera::function_94c683cd71e7ae65( 0 );
    }
    
    level notify( #"slayermart_cleanup" );
    level.ztron.disable_boosting = undefined;
    level thread ztron_fate::roomoffate();
    level waittill( #"fateexited" );
    self.blockfadeout = 1;
    self.var_15fa3a91a0532c84 = 1;
    self.neverallow = 1;
    level.ztron.var_451384c8c5191473 = 0;
    level.var_8972cc8b6869f399 = 0;
}

// Namespace ztron_bonus_room_fate
// Params 0, eflags: 0xc
// Checksum 0xa3ee47b1, Offset: 0xe83
// Size: 0xcc
function private spawnenemies()
{
    self notify( #"hash_e98a4128f73c59ea" );
    self endon( #"hash_e98a4128f73c59ea" );
    level endon( #"bonus_room_expired" );
    level endon( #"bonus_room_exit_taken" );
    self endon( #"enter_room_of_fate" );
    thread setupenemies();
    thread function_fc77ee2a6b4ef9cc();
    thread function_ee1cadaa36d2fcfa();
    
    foreach ( enemyspot in self.enemyspawns )
    {
        thread ztron_bonus_room::function_bd3a5142e2a2e9d6( enemyspot );
    }
}

// Namespace ztron_bonus_room_fate
// Params 0, eflags: 0xc
// Checksum 0xa1098965, Offset: 0xf57
// Size: 0x116
function private function_f32b228161675787()
{
    self notify( #"hash_3257e8579800990f" );
    self endon( #"hash_3257e8579800990f" );
    level endon( #"bonus_room_expired" );
    level endon( #"bonus_room_exit_taken" );
    self endon( #"enter_room_of_fate" );
    slots = arrayrandomize( self.fpcardslots );
    slots = utility::array_slice( slots, 0, level.players.size );
    ztron_item::function_6607be6e510e8f54( slots );
    
    if ( !level.ztron.var_95d8c7a469393957 )
    {
        foreach ( slayermart in self.slayermarts )
        {
            level thread ztron_slayer::slayer_arena_slayermart( slayermart, ( 0, 0, 0 ), 0, 0, 600 );
        }
    }
}

// Namespace ztron_bonus_room_fate
// Params 0, eflags: 0x4
// Checksum 0xd507e477, Offset: 0x1075
// Size: 0x33
function private setupenemies()
{
    level callback::add( "on_zombie_ai_spawned", &function_376056eb96b08d23 );
    level waittill( #"deactivate_bonus_room" );
    level callback::remove( "on_zombie_ai_spawned", &function_376056eb96b08d23 );
}

// Namespace ztron_bonus_room_fate
// Params 1, eflags: 0x4
// Checksum 0x95eda008, Offset: 0x10b0
// Size: 0xad
function private function_376056eb96b08d23( params )
{
    if ( !self.ztron.boss && self.var_361a087ab08adc1c != "sprint" )
    {
        thread function_38dcc47e0ef5d7c7();
    }
    
    if ( self.var_71c2b26838e90f44.name == "mangler_hvt" )
    {
        thread function_89ad0244db5b4f73();
    }
    
    if ( self.var_71c2b26838e90f44.name == "zursa" )
    {
        ztron_ui::function_37aad40e39a9fdfe( "slayer_boss_coming_zursa", "zursa" );
        ztron_util::function_40ad6a6cc144aa3f( level.ztron.dialogues[ "DOA_Slayer_Boss_Zursa" ] );
    }
}

// Namespace ztron_bonus_room_fate
// Params 0, eflags: 0xc
// Checksum 0xceaabf2f, Offset: 0x1165
// Size: 0x64
function private function_89ad0244db5b4f73()
{
    self notify( #"hash_d089c74b15bac615" );
    self endon( #"hash_d089c74b15bac615" );
    self endon( #"death" );
    ztron_dialog::function_7e3f6329d9afcdc1( #"tribute_enemy_spawn" );
    
    for ( var_13c479e116ba3f4c = 3; var_13c479e116ba3f4c > 0 ; var_13c479e116ba3f4c-- )
    {
        wait 5;
        ztron_dialog::function_927bb94feca983e8( #"hash_888b85325555591b" );
    }
}

// Namespace ztron_bonus_room_fate
// Params 0, eflags: 0x4
// Checksum 0xa41d88cd, Offset: 0x11d1
// Size: 0x4e
function private function_38dcc47e0ef5d7c7()
{
    callback::add( "on_zombie_ai_damaged", &function_63f693dae488b6c1 );
    
    while ( true )
    {
        self waittill( #"speed_change" );
        
        if ( self.var_361a087ab08adc1c == "sprint" )
        {
            break;
        }
    }
    
    callback::remove( "on_zombie_ai_damaged", &function_63f693dae488b6c1 );
}

// Namespace ztron_bonus_room_fate
// Params 1, eflags: 0x4
// Checksum 0x5a0dde65, Offset: 0x1227
// Size: 0xa0
function private function_63f693dae488b6c1( sparams )
{
    victim = self;
    attacker = ztron_util::function_da4039e4c338f818( sparams.eattacker );
    
    if ( victim.var_361a087ab08adc1c != "sprint" )
    {
        if ( !isdefined( victim.favoriteenemy ) && isdefined( attacker ) )
        {
            victim getenemyinfo( attacker );
        }
        
        victim.var_361a087ab08adc1c = "sprint";
        victim zombie_utils::function_a8ce00e0448cb6f0( victim.var_361a087ab08adc1c, "ztron", 4 );
        victim notify( #"speed_change" );
    }
}

// Namespace ztron_bonus_room_fate
// Params 0, eflags: 0x4
// Checksum 0x99d9e4b2, Offset: 0x12cf
// Size: 0x25
function private function_ee1cadaa36d2fcfa()
{
    if ( isdefined( self.bosstrigger ) )
    {
        self.bosstrigger thread function_8929bba4efa13cea( self, &function_33be51047e97d07 );
    }
}

// Namespace ztron_bonus_room_fate
// Params 2, eflags: 0xc
// Checksum 0x48ec4765, Offset: 0x12fc
// Size: 0x13c
function private function_33be51047e97d07( room, targetplayer )
{
    self notify( #"hash_e69fcb06d6622e1b" );
    self endon( #"hash_e69fcb06d6622e1b" );
    level endon( #"bonus_room_expired" );
    
    foreach ( player in level.players )
    {
        if ( player == targetplayer )
        {
            continue;
        }
        
        if ( !isalive( player ) || player.ztron.var_2c44544a01cc415e )
        {
            player ztron_player_utility::playerrespawnnow();
        }
        
        var_ed654236e66f99c4 = room.var_aa82eadeb4a43cfa;
        
        if ( var_ed654236e66f99c4 && var_ed654236e66f99c4.size > 0 )
        {
            var_b27b3c1324e4be5d = var_ed654236e66f99c4[ player.sessionuimemberindex % var_ed654236e66f99c4.size ];
            player ztron_util::teleport_player( var_b27b3c1324e4be5d.origin, player.angles );
        }
    }
}

// Namespace ztron_bonus_room_fate
// Params 0, eflags: 0x4
// Checksum 0xeefeead5, Offset: 0x1440
// Size: 0x7c
function private function_fc77ee2a6b4ef9cc()
{
    foreach ( var_a03f3ef026355506 in self.enemytriggers )
    {
        var_a03f3ef026355506 thread function_8929bba4efa13cea( self );
    }
}

// Namespace ztron_bonus_room_fate
// Params 2, eflags: 0xc
// Checksum 0x30cc1c48, Offset: 0x14c4
// Size: 0x141
function private function_8929bba4efa13cea( room, triggercallback )
{
    self notify( #"hash_6ee7cc39d2ddd90c" );
    self endon( #"hash_6ee7cc39d2ddd90c" );
    level endon( #"bonus_room_expired" );
    targetplayer = undefined;
    
    while ( true )
    {
        self waittill( #"trigger", ent );
        
        if ( isent( ent ) && self function_b0b72d20769d0233() )
        {
            if ( isplayer( ent ) )
            {
                targetplayer = ent;
                break;
            }
            
            if ( ent vehicle::is_vehicle() )
            {
                targetplayer = ent.owner;
                break;
            }
        }
    }
    
    enemyspots = utility::getstructarray( self.target, "targetname" );
    
    foreach ( enemyspot in enemyspots )
    {
        room thread function_93876584a0960be4( enemyspot, targetplayer );
    }
    
    if ( isdefined( triggercallback ) )
    {
        self thread [[ triggercallback ]]( room, targetplayer );
    }
}

// Namespace ztron_bonus_room_fate
// Params 2, eflags: 0x4
// Checksum 0xc528c3c1, Offset: 0x160d
// Size: 0x37
function private function_93876584a0960be4( enemyspot, targetplayer )
{
    enemyspot.targetplayer = targetplayer;
    ztron_bonus_room::function_bd3a5142e2a2e9d6( enemyspot );
    enemyspot.targetplayer = undefined;
}

// Namespace ztron_bonus_room_fate
// Params 0, eflags: 0x4
// Checksum 0x3f64662d, Offset: 0x164c
// Size: 0x58
function private function_dce8dfe3798b2bdd()
{
    while ( true )
    {
        self waittill( #"trigger", ent );
        
        if ( isent( ent ) && self function_b0b72d20769d0233() )
        {
            if ( isplayer( ent ) )
            {
                return ent;
            }
            
            if ( ent vehicle::is_vehicle() )
            {
                return ent.owner;
            }
        }
    }
}

// Namespace ztron_bonus_room_fate
// Params 0, eflags: 0x4
// Checksum 0x8bd09cfa, Offset: 0x16ac
// Size: 0x29
function private function_dac02ddd2ab8a1b9()
{
    if ( isdefined( self.var_700be64cf9b1d665 ) )
    {
        objidpoolmanager::returnobjectiveid( self.var_700be64cf9b1d665 );
        self.var_700be64cf9b1d665 = undefined;
    }
}

// Namespace ztron_bonus_room_fate
// Params 0, eflags: 0x4
// Checksum 0x89089907, Offset: 0x16dd
// Size: 0x9a
function private function_ac73ae393553f2b()
{
    objectiveindex = objidpoolmanager::requestobjectiveid();
    
    if ( objectiveindex != -1 )
    {
        objectoffset = ( 0, 0, 200 );
        objidpoolmanager::objective_add_objective( objectiveindex, "current", self.roomtrigger.origin + objectoffset, "ui_hud_ztron_icon_round_exit" );
        objidpoolmanager::update_objective_setbackground( objectiveindex, 1 );
        objidpoolmanager::objective_set_play_intro( objectiveindex, 1 );
        objidpoolmanager::objective_set_play_outro( objectiveindex, 0 );
        objidpoolmanager::objective_playermask_showtoall( objectiveindex );
        objidpoolmanager::objective_showdistance( objectiveindex, 0 );
    }
    
    self.var_700be64cf9b1d665 = objectiveindex;
}

// Namespace ztron_bonus_room_fate
// Params 0, eflags: 0x4
// Checksum 0x1463e9e6, Offset: 0x177f
// Size: 0x7d
function private function_71edd835144a0ffb()
{
    if ( !isdefined( self.roomblocker.scriptable ) )
    {
        self.roomblocker.scriptable = spawnscriptable( "ztron_room_of_fate_blocker", self.roomblocker.origin, self.roomblocker.angles );
    }
    
    self.roomblocker.scriptable setscriptablepartstate( "ztron_room_of_fate_blocker", "show" );
}

// Namespace ztron_bonus_room_fate
// Params 0, eflags: 0x4
// Checksum 0x112f15f3, Offset: 0x1804
// Size: 0x55
function private function_f71252ba964e318()
{
    if ( isdefined( self.roomblocker.scriptable ) )
    {
        self.roomblocker.scriptable setscriptablepartstate( "ztron_room_of_fate_blocker", "fade_out" );
    }
    
    if ( self.var_d16ba431d9e4a651 )
    {
        self.var_d16ba431d9e4a651 notsolid();
    }
}

// Namespace ztron_bonus_room_fate
// Params 0, eflags: 0x4
// Checksum 0xbf972b05, Offset: 0x1861
// Size: 0x44
function private function_be6b36b0156d61d8()
{
    if ( isdefined( self.roomblocker.scriptable ) )
    {
        self.roomblocker.scriptable freescriptable();
        self.roomblocker.scriptable = undefined;
    }
}

/#

    // Namespace ztron_bonus_room_fate
    // Params 0
    // Checksum 0x5b37d725, Offset: 0x18ad
    // Size: 0x2e, Type: dev
    function function_3eb74ef492f967ef()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x32>", "<dev string:x4e>", &function_63e812123973763e );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace ztron_bonus_room_fate
    // Params 0
    // Checksum 0xeefe920b, Offset: 0x18e3
    // Size: 0x11a, Type: dev
    function function_63e812123973763e()
    {
        if ( !isdefined( level.ztron.var_8a9067aa4cd65369 ) )
        {
            return;
        }
        
        room = level.ztron.var_8a9067aa4cd65369;
        
        if ( room.type != "<dev string:x70>" )
        {
            return;
        }
        
        if ( !isdefined( room.roomtrigger ) )
        {
            return;
        }
        
        foreach ( player in level.players )
        {
            if ( isdefined( player ) )
            {
                player ztron_util::teleport_player( room.roomtrigger.origin + ( 80, 80, 160 ), player.angles );
            }
        }
        
        level notify( #"hash_e937c19bfb7cb725" );
    }

#/
