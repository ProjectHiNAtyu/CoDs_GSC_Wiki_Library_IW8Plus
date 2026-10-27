// script_316d17140a095a89  (hash_316d17140a095a89.gscc) (size: 31967 Bytes / 0x7cdf / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x77ff8015 (2013233173)
// size ...... 31967 (0x7cdf)
// includes .. 31  (offset: 0x769b)
// strings ... 78  (offset: 0x7793)
// dev strs .. 12  (offset: 0x7c37)
// exports ... 74  (offset: 0x4dcb)
// cseg ...... 0x7e1 + 0x45ea (0x4dcb)
// imports ... 243 (offset: 0x595b)
// animtree1 . 1   (offset: 0x7cd3)
// animtree2 . 0   (offset: 0x7cdf)
#using script_2913428424697f6c;
#using script_2b3f8b011222f912;
#using script_31ee2a173f3499b7;
#using script_4ce55cfc81c444ad;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_mimic\zombie_mimic_prop_spawn;
#using scripts\common\anim;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\loot\common_item;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\zm\systems\weapons\zm_damage;
#using scripts\mp\zm\zm_utility;
#using scripts\mp\zm\ztron\ztron_bonus_room;
#using scripts\mp\zm\ztron\ztron_camera;
#using scripts\mp\zm\ztron\ztron_debug;
#using scripts\mp\zm\ztron\ztron_enemy;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_score;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_tutorial;
#using scripts\mp\zm\ztron\ztron_utility;
#using scripts\mp\zm\ztron\ztron_vfx;
#using scripts\mp\zm\ztron\ztron_weapon;

#namespace namespace_71a8a7e5a5ce9ac;

// Namespace namespace_71a8a7e5a5ce9ac
// Params 0, eflags: 0x5
// Checksum 0xf5675ac7, Offset: 0x7ff
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_99ac3fefa2c1758b", undefined, undefined, &init );
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 0
// Checksum 0x4c521de2, Offset: 0x820
// Size: 0x1a
function init()
{
    thread initshooter();
    utility::add_fx( "ztron_rail_shooter_on_hit_vfx", "vfx_t10_gameplay_zm_punching_blood_camera" );
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 0
// Checksum 0x10144f6d, Offset: 0x842
// Size: 0xcb
function initshooter()
{
    level utility::flag_wait( "ztron_bonus_room_initialized" );
    var_a8d8980c65b4b0de = ztron_bonus_room::function_98dedbfc79dc3572( "rail_shooter" );
    
    if ( var_a8d8980c65b4b0de.size > 0 )
    {
        foreach ( room in var_a8d8980c65b4b0de )
        {
            room function_47585f072acb3fd4();
            room.setupcallback = &shootersetup;
        }
    }
    
    ztron_sound::function_4ac735395b173fe( "rail_shooter_cannon_fire_OS", "evt_rampart_cannon_fire" );
    
    /#
        level thread function_ac7ee3673d6e340d();
    #/
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 0
// Checksum 0xf5f9a497, Offset: 0x915
// Size: 0xd9
function function_47585f072acb3fd4()
{
    self.var_6210dc1f68bbfa57 = 0;
    self.playerspawnpoints = utility::getstructarray( "bonus_" + self.name + "_player_spawnpoint", "targetname" );
    self.var_294215aa7a72adcb = utility::getstruct( "bonus_" + self.name + "_rail", "targetname" );
    self.eggstructs = utility::getstructarray( "bonus_" + self.name + "_egg", "targetname" );
    self.chickenstructs = utility::getstructarray( "bonus_" + self.name + "_chicken", "targetname" );
    self.abortstructs = utility::getstructarray( "bonus_" + self.name + "_exit_target", "targetname" );
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 1
// Checksum 0x3081f547, Offset: 0x9f6
// Size: 0x268
function shootersetup( room )
{
    room thread shooterclean();
    room.var_1fbfe6996f3460d9 = 1;
    room.timeout = 999;
    level.ztron.var_98dff9cf623f94a3 = 800;
    level.var_ba362d5be96483cb = 1;
    level.ztron.disableads = 1;
    level.ztron.var_45536c77fdfa4ea7 = 0;
    level callback::add( "on_zombie_ai_spawned", &function_c66508b90dc7aa38 );
    level zombie_utils::function_dfae6a5bd222c586( &function_3f2d93e30b02b9f8 );
    utility::registersharedfunc( #"egg", #"spawnprize", &function_1c69df6c3fd6c1aa );
    utility::registersharedfunc( #"player", #"onrejoin", &function_dd1fa62b48800adb );
    level waittill( #"hash_9d2492f7742c7564" );
    room.enemyspawning = 0;
    room.currentnavobstacles = [];
    ztron_ui::function_8a888030d7860092( 0 );
    level ztron_ui::function_f5177e090dadd8f4( 2 );
    ztron_ui::function_2bea9afab8148cc7( 0 );
    
    foreach ( player in level.players )
    {
        if ( !level.ztron.var_95d8c7a469393957 )
        {
            player ztron_ui::function_f7e6c4641e827bf8( 1 );
        }
        
        player.ignoreme = 1;
        player.takedamage = 0;
    }
    
    room function_8e1bc631ba3f96a2();
    room function_c67d7e93723f96db();
    room function_a141073b9133017f();
    room eggssetup();
    room function_9fb16ae2c245be92();
    room chickensetup();
    room thread function_1afa4e6cbef6d2b0();
    room thread function_e9897b6f98035952( room.var_294215aa7a72adcb );
    function_1d12678b393b9ea9( 1 );
    level thread ztron_ui::function_6e791be3702fa2a8( "RAIL_SHOOTER_RELOAD_HINT", 0, 10, 1 );
    level.ztron.var_f6a33d41e2af442c = &function_1e776a27c92c8e9a;
    level.ztron.var_2e9bbb5f5a0cd240 = 0.5;
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 0
// Checksum 0x22dbd82f, Offset: 0xc66
// Size: 0xd1
function function_8e1bc631ba3f96a2()
{
    if ( !isdefined( level.players[ 0 ] ) )
    {
        return;
    }
    
    self.moveorg = utility::spawn_model( "tag_origin", level.players[ 0 ].origin, level.players[ 0 ].angles );
    
    foreach ( player in level.players )
    {
        player playerlinkto( self.moveorg );
    }
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 0
// Checksum 0x8b607eef, Offset: 0xd3f
// Size: 0x2a9
function shooterclean()
{
    level utility::waittill_any( "bonus_room_expired", "ztron_game_is_over", "bonus_room_exit_taken" );
    
    if ( isdefined( self.railattractor ) )
    {
        self.railattractor delete();
        self.railattractor = undefined;
    }
    
    if ( isdefined( self.moveorg ) )
    {
        foreach ( player in level.players )
        {
            player unlink();
        }
        
        self.moveorg delete();
        self.moveorg = undefined;
    }
    
    level.ztron.var_45536c77fdfa4ea7 = undefined;
    level.ztron.disableads = undefined;
    level.var_ba362d5be96483cb = 0;
    self.enemyspawning = 0;
    self.abortclosed = undefined;
    setomnvar( "ui_ztron_rail_shooter_lives", -1 );
    level callback::remove( "on_zombie_ai_spawned", &function_c66508b90dc7aa38 );
    level zombie_utils::function_10c0c35c21e3ed9d( &function_3f2d93e30b02b9f8 );
    utility::registersharedfunc( #"egg", #"spawnprize", undefined );
    utility::registersharedfunc( #"player", #"onrejoin", undefined );
    function_1d12678b393b9ea9( 0 );
    function_de0a56b5ec14699e();
    ztron_ui::function_8a888030d7860092( -1 );
    level ztron_ui::function_f5177e090dadd8f4( 0 );
    ztron_ui::function_2bea9afab8148cc7( 1 );
    
    foreach ( player in level.players )
    {
        player ztron_ui::function_f7e6c4641e827bf8( 0 );
        player.ignoreme = 0;
        player.takedamage = 1;
    }
    
    function_ceb3d99095ddd245();
    level.ztron.var_a593aa94dc733518 = undefined;
    level.ztron.var_98dff9cf623f94a3 = 256;
    level.ztron.var_f6a33d41e2af442c = undefined;
    level.ztron.var_2e9bbb5f5a0cd240 = undefined;
    
    /#
        level.ztron.var_8a9067aa4cd65369.var_d3060df21967839b = undefined;
    #/
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 0
// Checksum 0x11218c69, Offset: 0xff0
// Size: 0x29
function function_ceb3d99095ddd245()
{
    if ( isdefined( self.abortobjective ) )
    {
        objidpoolmanager::returnobjectiveid( self.abortobjective );
        self.abortobjective = undefined;
    }
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 0
// Checksum 0xc235105b, Offset: 0x1021
// Size: 0x7b
function function_a141073b9133017f()
{
    foreach ( abortstruct in self.abortstructs )
    {
        function_8df2fac9e9c2ac74( abortstruct );
    }
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 1
// Checksum 0x3aa0aa34, Offset: 0x10a4
// Size: 0x154
function function_8df2fac9e9c2ac74( abortstruct )
{
    aborttarget = utility::spawn_model( "sat_zm_ztron_props_barrier_wooden", abortstruct.origin, abortstruct.angles );
    aborttarget solid();
    aborttarget setcandamage( 1 );
    var_3f5cb59d11674f9f = undefined;
    
    if ( level.players.size > 1 && level.players.size - level.ztron.var_909f9ee392414e7.size > 1 )
    {
        aborttarget.maxhealth = 999999;
        var_3f5cb59d11674f9f = 0;
    }
    else
    {
        aborttarget.maxhealth = getdvarint( @"hash_24d5388d50a91741", 3200 );
        var_3f5cb59d11674f9f = 1;
    }
    
    abortobjective = spawnstruct();
    abortobjective.origin = aborttarget.origin + ( 64, 0, 0 );
    self.abortobjective = ztron_bonus_room::function_8366aa370d503825( abortobjective, 1, "ui_hud_ztron_icon_abort_exit", &"ztron_hud/abort" );
    thread function_6dcbc2bf0483ee8b( aborttarget, var_3f5cb59d11674f9f );
    aborttarget.health = aborttarget.maxhealth;
    aborttarget thread ztron_util::function_36239518d8da65f0( level, "bonus_room_expired" );
    aborttarget thread ztron_util::function_36239518d8da65f0( self, "bonus_room_abort_closed" );
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 2
// Checksum 0x32860cce, Offset: 0x1200
// Size: 0x236
function function_6dcbc2bf0483ee8b( aborttarget, var_3f5cb59d11674f9f )
{
    level endon( #"bonus_room_expired" );
    level endon( #"bonus_room_exit_taken" );
    self endon( #"bonus_room_abort_closed" );
    abortsuccess = 0;
    
    if ( var_3f5cb59d11674f9f )
    {
        aborttarget waittill( #"death", attacker );
        
        if ( isplayer( attacker ) )
        {
            abortsuccess = 1;
        }
    }
    else
    {
        aborttarget.abortplayers = [];
        aborttarget thread function_bd2e40dc47e75537( self );
        
        while ( aborttarget.abortplayers.size < 2 )
        {
            aborttarget waittill( #"damage", idamage, eattacker );
            
            if ( level.players.size < 2 && isplayer( eattacker ) )
            {
                break;
            }
            
            aborttarget.lastdamagetime = gettime();
            aborttarget.health = aborttarget.maxhealth;
            
            if ( isplayer( eattacker ) && !arraycontains( aborttarget.abortplayers, eattacker ) )
            {
                aborttarget.abortplayers = arraycombineunique( aborttarget.abortplayers, [ eattacker ] );
                text = &"ztron_hud/abort";
                
                if ( aborttarget.abortplayers.size == 1 )
                {
                    text = &"ztron_hud/abort_12";
                    leavingplayer = aborttarget.abortplayers[ 0 ];
                    leavingplayer ztron_ui::function_e5c28b773c483dbb( "MULTIPLAYER_LEAVE_RAIL_SHOOTER" );
                }
                else if ( aborttarget.abortplayers.size == 2 )
                {
                    text = &"ztron_hud/abort_22";
                }
                
                if ( isdefined( self.abortobjective ) )
                {
                    objidpoolmanager::update_objective_setfriendlylabel( self.abortobjective, text );
                    objidpoolmanager::update_objective_setneutrallabel( self.abortobjective, text );
                    objidpoolmanager::update_objective_setenemylabel( self.abortobjective, text );
                }
            }
        }
        
        abortsuccess = 1;
    }
    
    if ( abortsuccess )
    {
        playfx( utility::getfx( "ztron_shooter_abort_plank_death" ), aborttarget.origin );
        aborttarget delete();
        shooterend( 0, 0.5 );
    }
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 1, eflags: 0x4
// Checksum 0x530a094, Offset: 0x143e
// Size: 0xd8
function private function_bd2e40dc47e75537( room )
{
    level endon( #"bonus_room_expired", #"bonus_room_exit_taken" );
    self endon( #"death" );
    
    while ( true )
    {
        if ( self.abortplayers.size > 0 && isdefined( self.lastdamagetime ) && gettime() - self.lastdamagetime > 6000 )
        {
            self.abortplayers = [];
            text = &"ztron_hud/abort";
            
            if ( isdefined( room.abortobjective ) )
            {
                objidpoolmanager::update_objective_setfriendlylabel( room.abortobjective, text );
                objidpoolmanager::update_objective_setneutrallabel( room.abortobjective, text );
                objidpoolmanager::update_objective_setenemylabel( room.abortobjective, text );
            }
        }
        
        wait 0.1;
    }
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 3
// Checksum 0xfbe7950, Offset: 0x151e
// Size: 0x500
function function_e9897b6f98035952( railstruct, var_de24e4672b03e406 = 0, movingduration = 0 )
{
    self notify( #"hash_ebb640e3f539960c" );
    self endon( #"hash_ebb640e3f539960c" );
    level endon( #"bonus_room_expired", #"bonus_room_exit_taken" );
    level endon( #"ztron_game_is_over" );
    assert( railstruct.origin );
    
    if ( !isdefined( railstruct.angles ) )
    {
        railstruct.angles = ( 0, 0, 0 );
    }
    
    /#
        if ( level.ztron.var_8a9067aa4cd65369.var_d3060df21967839b )
        {
            var_de24e4672b03e406 = 0;
            movingduration = 0.2;
        }
    #/
    
    if ( var_de24e4672b03e406 > 0 )
    {
        wait var_de24e4672b03e406;
    }
    
    foreach ( player in level.players )
    {
        player.shootingcrosshair.var_26d4773974e1912f = 0;
        
        if ( movingduration > 0 )
        {
            player.ztron.scriptedcam moveto( railstruct.origin, movingduration );
            player.ztron.scriptedcam rotateto( railstruct.angles, movingduration );
            continue;
        }
        
        player.ztron.scriptedcam.origin = railstruct.origin;
        player.ztron.scriptedcam.angles = railstruct.angles;
    }
    
    if ( movingduration > 0 )
    {
        wait movingduration;
    }
    
    if ( isdefined( self.moveorg ) )
    {
        self.moveorg moveto( railstruct.origin + ( 0, 0, -256 ), 0.1 );
    }
    
    self.currentrail = railstruct;
    self.fovent = railstruct;
    function_d8490895303c8a1a();
    triggers = ztron_util::function_2d9de5c7b97db39( railstruct.targetname, "target" );
    
    foreach ( trigger in triggers )
    {
        if ( trigger.code_classname == "trigger_box" )
        {
            obid = createnavobstaclebyent( trigger );
            self.currentnavobstacles[ self.currentnavobstacles.size ] = obid;
        }
    }
    
    eventstructs = utility::getstructarray( railstruct.targetname, "target" );
    
    /#
        foreach ( event in eventstructs )
        {
            if ( event.targetname == "<dev string:x24>" + "<dev string:x2b>" + "<dev string:x38>" && level.ztron.var_8a9067aa4cd65369.var_ebd74f33daf1acfb )
            {
                level.ztron.var_8a9067aa4cd65369.var_d3060df21967839b = 0;
                continue;
            }
            
            if ( event.script_noteworthy == "<dev string:x3d>" && level.ztron.var_8a9067aa4cd65369.var_90841d00d86412a5 )
            {
                level.ztron.var_8a9067aa4cd65369.var_d3060df21967839b = 0;
            }
        }
    #/
    
    foreach ( event in eventstructs )
    {
        if ( !level.ztron.var_8a9067aa4cd65369.var_d3060df21967839b )
        {
            function_523b742a5483cb6b( event );
        }
    }
    
    thread function_7732c9f50224c7af();
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 0
// Checksum 0xd1fbb167, Offset: 0x1a26
// Size: 0x3f
function function_1afa4e6cbef6d2b0()
{
    level endon( #"bonus_room_expired", #"bonus_room_exit_taken" );
    self endon( #"room_done" );
    
    while ( true )
    {
        self waittill( #"hash_aee0b5014bd1cacc" );
        thread function_3423b68fe468b62f();
    }
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 0
// Checksum 0xdbb255d6, Offset: 0x1a6d
// Size: 0x19a
function function_d8490895303c8a1a()
{
    attractorpos = ztron_util::function_3fe38741460a4a49( self.currentrail.origin + anglestoforward( self.currentrail.angles ) * 30 ) + ( 0, 0, 5 );
    attractorpos = getclosestpointonnavmesh( attractorpos );
    
    if ( !isdefined( self.railattractor ) )
    {
        self.railattractor = utility::spawn_model( %"decor_barrels_gameplay_flammable_ztron", attractorpos );
        self.railattractor setcandamage( 1 );
        self.railattractor.health = 100000;
        self.railattractor solid();
        self.railattractor.playerattractor = 1;
        
        foreach ( player in level.players )
        {
            self.railattractor hidefromplayer( player );
        }
        
        self.railattractor attractorupdatestate( 1 );
        thread function_b7c91d8a11f6f25b();
        level.ztron.railattractor = self.railattractor;
        return;
    }
    
    self.railattractor.origin = attractorpos;
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 1
// Checksum 0x683c866, Offset: 0x1c0f
// Size: 0x3f
function attractorupdatestate( shouldattract )
{
    if ( shouldattract )
    {
        zombie_attractor_manager::add_attractor( self, 0, 1024, 1 );
        self.var_cc4e9ac3081b5705 = 1;
        return;
    }
    
    zombie_attractor_manager::remove_attractor( self );
    self.var_cc4e9ac3081b5705 = 0;
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 0
// Checksum 0x1633664a, Offset: 0x1c56
// Size: 0x28, Type: bool
function function_f81bbefeb591e9b1()
{
    return isdefined( self.shieldtrigger ) && self.shieldtrigger.activetime >= gettime();
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 0
// Checksum 0xe010ed7, Offset: 0x1c87
// Size: 0x169
function function_61da22ae3d4d40b6()
{
    level endon( #"bonus_room_expired", #"bonus_room_exit_taken" );
    self endon( #"death" );
    function_801e0530d10badf8();
    ztron_sound::ztron_playsound( "ztron_player_shield_start", undefined, self );
    
    if ( !isdefined( self.shieldtrigger ) )
    {
        self.shieldtrigger = spawn( "trigger_radius", self.origin, 1, 60, 72 );
        self.shieldtrigger.activetime = 0;
        self.shieldtrigger thread ztron_util::function_36239518d8da65f0( level, "bonus_room_expired" );
        self.shieldtrigger thread ztron_player_utility::shield_trigger_think( self );
    }
    else
    {
        self.shieldtrigger.origin = self.origin;
    }
    
    self.shieldfx = ztron_vfx::function_574a3236c59da7d8( "ztron_player_shield_short", self.origin );
    self.shieldfx thread ztron_util::function_f7544bfa701db406( self );
    var_f548a5c3215d81da = 1000;
    activetime = gettime() + var_f548a5c3215d81da;
    
    if ( self.shieldtrigger.activetime < activetime )
    {
        self.shieldtrigger.activetime = activetime;
    }
    
    ztron_sound::ztron_playsound( "ztron_player_shield_half", undefined, self );
    wait 1;
    ztron_sound::ztron_playsound( "ztron_player_shield_stop", undefined, self );
    function_801e0530d10badf8();
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 0
// Checksum 0x6cb7fc85, Offset: 0x1df8
// Size: 0x4b
function function_801e0530d10badf8()
{
    if ( isdefined( self.shieldtrigger ) )
    {
        self.shieldtrigger.activetime = 0;
    }
    
    if ( isdefined( self.shieldfx ) )
    {
        ztron_vfx::function_4abb26b271676888( self.shieldfx );
        self.shieldfx = undefined;
    }
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 0
// Checksum 0x394e07b, Offset: 0x1e4b
// Size: 0x2e7
function function_b7c91d8a11f6f25b()
{
    level endon( #"bonus_room_expired", #"bonus_room_exit_taken" );
    self endon( #"room_done" );
    attractor = self.railattractor;
    attractor.shootermaxhealth = 8;
    attractor.shooterhealth = attractor.shootermaxhealth;
    attractor.var_be4f500b14219ad8 = 0;
    setomnvar( "ui_ztron_rail_shooter_lives", attractor.shooterhealth );
    
    while ( attractor.shooterhealth > 0 )
    {
        attractor waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath );
        
        if ( attractor.health < 100000 )
        {
            attractor.health = 100000;
        }
        
        if ( !isai( attacker ) || attacker.nokill )
        {
            continue;
        }
        
        if ( attacker function_2462cd7340935051( self.fovent, 120 ) )
        {
            ztron_debug::debugmsg( "---------------- KILLING ZOMBIE OUTSIDE FOV: " + attacker.origin );
            attacker thread ztron_util::deletemedelay();
            continue;
        }
        
        attractor.var_be4f500b14219ad8 = 0;
        
        foreach ( player in level.players )
        {
            if ( player ztron_player_utility::function_afac1199d03801b2() )
            {
                attractor.var_be4f500b14219ad8 = 1;
                break;
            }
        }
        
        if ( isai( attacker ) && !function_f81bbefeb591e9b1() && isvaliddamage( meansofdeath ) )
        {
            if ( !attractor.var_be4f500b14219ad8 )
            {
                attractor.shooterhealth--;
                setomnvar( "ui_ztron_rail_shooter_lives", attractor.shooterhealth );
            }
            
            if ( attractor.shooterhealth > 0 )
            {
                attractor thread function_61da22ae3d4d40b6();
                
                foreach ( player in level.players )
                {
                    playfxontagforclients( utility::getfx( "ztron_rail_shooter_on_hit_vfx" ), player.ztron.scriptedcam, "tag_origin", player );
                }
            }
        }
    }
    
    shooterend( 0 );
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 2, eflags: 0x4
// Checksum 0xff8422d3, Offset: 0x213a
// Size: 0x75, Type: bool
function private function_2462cd7340935051( sourceent, fov )
{
    sourceentforward = vectornormalize2( anglestoforward( sourceent.angles ) );
    sourcetotarget = self.origin - sourceent.origin - sourceentforward * 30;
    sourcetotarget = vectornormalize2( sourcetotarget );
    return vectordot( sourceentforward, sourcetotarget ) < cos( fov / 2 );
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 1, eflags: 0x4
// Checksum 0x4e647f9d, Offset: 0x21b8
// Size: 0x20, Type: bool
function private isvaliddamage( meansofdeath )
{
    return meansofdeath == "MOD_MELEE" || meansofdeath == "MOD_PROJECTILE_SPLASH";
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 2, eflags: 0x4
// Checksum 0xe1371f25, Offset: 0x21e1
// Size: 0xa7
function private shooterend( win, waittime = 3 )
{
    if ( isdefined( self.railattractor ) )
    {
        self.railattractor delete();
        self.railattractor = undefined;
    }
    
    ztron_ui::function_e43f76fd8ed80050( win );
    wait waittime;
    
    if ( isdefined( self.exit ) )
    {
        if ( win )
        {
            self.exit notify( #"hash_5eb4fd194882f78f" );
        }
        else
        {
            self.exit notify( #"lost" );
        }
    }
    
    self notify( #"room_done" );
    setomnvar( "ui_ztron_rail_shooter_lives", -1 );
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 0, eflags: 0xc
// Checksum 0xb021241d, Offset: 0x2290
// Size: 0x126
function private function_3423b68fe468b62f()
{
    self notify( #"hash_997af2a84e25762e" );
    self endon( #"hash_997af2a84e25762e" );
    level endon( #"bonus_room_expired", #"bonus_room_exit_taken" );
    var_5ce4df652d7e8c6b = 0;
    var_10f4f4a7d3975a9a = 140;
    railstruct = self.currentrail;
    
    if ( isdefined( railstruct.script_parameters ) )
    {
        args = strtok( railstruct.script_parameters, ";" );
        var_5ce4df652d7e8c6b = float( args[ 0 ] );
        
        if ( args.size > 1 )
        {
            var_10f4f4a7d3975a9a = float( args[ 1 ] );
        }
    }
    
    if ( !isdefined( railstruct.target ) )
    {
        wait var_5ce4df652d7e8c6b;
        shooterend( 1 );
        return;
    }
    
    var_776c170482261e6 = utility::getstruct( railstruct.target, "targetname" );
    var_77c67da93e9cdf81 = distance( self.currentrail.origin, var_776c170482261e6.origin );
    var_fbe16c42d42040db = var_77c67da93e9cdf81 / var_10f4f4a7d3975a9a;
    thread function_e9897b6f98035952( var_776c170482261e6, var_5ce4df652d7e8c6b, var_fbe16c42d42040db );
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 1, eflags: 0x4
// Checksum 0xbd96417e, Offset: 0x23be
// Size: 0x256
function private function_523b742a5483cb6b( event )
{
    level endon( #"bonus_room_expired", #"bonus_room_exit_taken" );
    
    if ( event.targetname == "bonus_" + "rail_shooter" + "_enemy_spawn" )
    {
        thread ztron_bonus_room::function_bd3a5142e2a2e9d6( event, 1, 0.2, getdvarfloat( @"hash_359cff8946ee07f5", 1 ), getdvarfloat( @"hash_e5e8fa9b0f08c566", 0.8 ), 30 );
        
        if ( !self.abortclosed )
        {
            self notify( #"bonus_room_abort_closed" );
            self.abortclosed = 1;
            function_ceb3d99095ddd245();
        }
        
        return;
    }
    
    if ( event.targetname == "bonus_" + "rail_shooter" + "_egg" && self.railattractor.var_cc4e9ac3081b5705 )
    {
        self.railattractor attractorupdatestate( 0 );
        activateeggs( event );
        return;
    }
    
    if ( event.targetname == "bonus_" + "rail_shooter" + "_egg_enemy_spawn" )
    {
        thread function_15146526f7c5c6cf( event, "basic_zombie", 1, 1.6 );
        return;
    }
    
    if ( event.targetname == "bonus_" + "rail_shooter" + "_tutorial" )
    {
        thread function_1e03d805838998fa( event );
        return;
    }
    
    if ( event.script_noteworthy == "bonus_" + "rail_shooter" + "_giftbox_zombie" )
    {
        thread function_3fd6a55d2476e5e2( event );
        return;
    }
    
    if ( event.targetname == "bonus_" + "rail_shooter" + "_jump_scare" )
    {
        thread function_8521170b4fbb44d7( event );
        return;
    }
    
    if ( event.targetname == "bonus_" + "rail_shooter" + "_jump_scare_trigger" )
    {
        thread jumpscareevent( event );
        return;
    }
    
    if ( event.targetname == "bonus_" + "rail_shooter" + "_event_pickup" )
    {
        thread function_e57857c7c6ab607( event );
        return;
    }
    
    if ( event.targetname == "bonus_" + "rail_shooter" + "_gems_rain" )
    {
        thread function_aafa66f13d2466e8( event );
        return;
    }
    
    if ( event.script_noteworthy == "cannon_fire" )
    {
        cannonfireevent( event );
    }
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 0, eflags: 0xc
// Checksum 0x989b53ef, Offset: 0x261c
// Size: 0x1e5
function private function_7732c9f50224c7af()
{
    self notify( #"hash_908e0e27bbcadbf5" );
    self endon( #"hash_908e0e27bbcadbf5" );
    level endon( #"bonus_room_expired", #"bonus_room_exit_taken" );
    
    if ( self.activatedeggs.size > 0 )
    {
        var_55d02b58b67a7927 = gettime();
        
        while ( self.activatedeggs.size > 0 )
        {
            if ( gettime() > var_55d02b58b67a7927 + 45000 )
            {
                foreach ( egg in self.activatedeggs )
                {
                    egg namespace_4e36c859ad6a5d59::ztron_egg_delete();
                }
                
                self.activatedeggs = [];
            }
            
            self.activatedeggs = function_5713d46873b29625( self.activatedeggs );
            wait 0.1;
        }
        
        self notify( #"egg_cleared" );
        self.railattractor attractorupdatestate( 1 );
    }
    
    while ( self.enemyspawning || ztron_util::function_cdd411b0cc1f9d80().size > 0 )
    {
        wait 0.1;
    }
    
    self notify( #"hash_aee0b5014bd1cacc" );
    
    if ( self.currentnavobstacles.size > 0 )
    {
        foreach ( obid in self.currentnavobstacles )
        {
            destroynavobstacle( obid );
        }
        
        self.currentnavobstacles = [];
    }
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 1
// Checksum 0xa04ab13f, Offset: 0x2809
// Size: 0xe5
function function_1d12678b393b9ea9( shouldfreeze = 1 )
{
    foreach ( player in level.players )
    {
        player.ztron.blockboost = shouldfreeze;
        player.ztron.var_557a2e6d2ffa015c = shouldfreeze;
        player.var_b5bed2b7dafd7815 = shouldfreeze;
        player allowmovement( !shouldfreeze );
        player.ignoreme = shouldfreeze;
        player allowmelee( !shouldfreeze );
    }
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 0
// Checksum 0xa83dc74b, Offset: 0x28f6
// Size: 0x2ef
function function_c67d7e93723f96db()
{
    foreach ( player in level.players )
    {
        player lerpfovscalefactor( 0, 0 );
        player ztron_camera::function_79d64be315aa51c9( 4 );
        
        if ( !isdefined( player.ztron.scriptedcam ) )
        {
            player.ztron.scriptedcam = spawn( "script_model", player.origin );
            player.ztron.scriptedcam setmodel( "tag_origin" );
            player cameralinkto( player.ztron.scriptedcam, "tag_origin", 1, 1 );
        }
        
        player.ztron.scriptedcam.origin = player.origin + anglestoforward( player.angles ) * -1 * 100 + ( 0, 0, 50 );
        
        if ( !isdefined( player.shootingcrosshair ) )
        {
            player.shootingcrosshair = utility::spawn_model( "tag_origin", player.ztron.scriptedcam.origin + anglestoforward( player.ztron.scriptedcam.angles ) * 10, player.ztron.scriptedcam.angles );
        }
        
        player.shootingcrosshair notsolid();
        ui::lui_registercallback( "ui_crosshair_coordinate", &handlecoordinate );
        ui::lui_registercallback( "ui_recenter_crosshair", &recentercrosshair );
        player val::set( "topdowncamera", "ads", 0 );
        player ztron_weapon::giveweaponpack( %"hash_40e30fa230008d42" );
        player.ztron.weaponLevel = 0;
        player.ztron.weaponincrement = 0;
        player ztron_weapon::function_951f0c703dffc47( 0, 700 );
        setomnvar( "ztron_rail_shooter_crosshair_ent_" + player.sessionuimemberindex, player.shootingcrosshair getentitynumber() );
        player.angles = player.ztron.scriptedcam.angles;
        player thread function_6508a2757f847983();
        player thread function_b9e80015b9a39c5( self );
        player thread function_3fdcee38c88e3067();
        player thread disconnectedwatcher();
    }
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 0
// Checksum 0x3901517, Offset: 0x2bed
// Size: 0x3cf
function function_6508a2757f847983()
{
    level endon( #"bonus_room_expired" );
    level endon( #"bonus_room_exit_taken" );
    level endon( #"ztron_game_is_over" );
    self endon( #"disconnect" );
    self.shootingcrosshair.xoffset = 0;
    self.shootingcrosshair.yoffset = 0;
    self.shootingcrosshair.var_26d4773974e1912f = gettime();
    self.shootingcrosshair.usinggamepad = self usinggamepad();
    
    if ( !isdefined( self.shootingentity ) )
    {
        self.shootingentity = utility::spawn_model( "tag_origin", self.shootingcrosshair.origin, self.shootingcrosshair.angles );
    }
    
    self.shootingentity notsolid();
    var_a13b24e58d3effdb = getdvarint( @"hash_6bf8f8239af616ab", 1 );
    recentertime = getdvarint( @"hash_cd0afc5770d649d", 1500 );
    
    while ( isdefined( self.shootingcrosshair ) && isdefined( self.shootingentity ) && isdefined( self.ztron.scriptedcam ) )
    {
        worldpos = self function_7f2e1ce5e354ab94( ( self.shootingcrosshair.xoffset, self.shootingcrosshair.yoffset, 0 ), 90, 10 );
        
        if ( isdefined( worldpos ) )
        {
            self.shootingcrosshair.origin = worldpos;
        }
        
        dirvec = self.shootingcrosshair.origin - self.ztron.scriptedcam.origin;
        aimangles = vectortoangles( dirvec );
        aimforward = vectornormalize( anglestoforward( aimangles ) );
        self.shootingentity.angles = aimangles;
        self.shootingentity.origin = self.ztron.scriptedcam.origin + aimforward * 4;
        
        if ( var_a13b24e58d3effdb )
        {
            curtime = gettime();
            curangles = self getplayerangles();
            
            if ( self.shootingcrosshair.usinggamepad != self usinggamepad() )
            {
                if ( self usinggamepad() )
                {
                    self.shootingcrosshair.var_26d4773974e1912f = gettime();
                    self setclientomnvar( "ztron_rail_shooter_crosshair_recenter", 0 );
                }
                else
                {
                    self setplayerangles( ( 0, 0, 0 ) );
                    self setclientomnvar( "ztron_rail_shooter_crosshair_recenter", 2 );
                }
                
                self.shootingcrosshair.usinggamepad = self usinggamepad();
            }
            else if ( self usinggamepad() )
            {
                self.shootingcrosshair.usinggamepad = 1;
                
                if ( abs( self getrightstickx() ) > 0.05 || abs( self getrightsticky() ) > 0.05 || self attackbuttonpressed() )
                {
                    self.shootingcrosshair.var_26d4773974e1912f = gettime();
                    self setclientomnvar( "ztron_rail_shooter_crosshair_recenter", 0 );
                }
                
                if ( !self attackbuttonpressed() && curtime - self.shootingcrosshair.var_26d4773974e1912f > recentertime )
                {
                    self setclientomnvar( "ztron_rail_shooter_crosshair_recenter", 1 );
                    self.shootingcrosshair.var_26d4773974e1912f = gettime();
                }
                
                if ( abs( curangles[ 0 ] ) > 80 )
                {
                    self setplayerangles( ( 0, curangles[ 1 ], curangles[ 2 ] ) );
                }
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 1
// Checksum 0x27c6c553, Offset: 0x2fc4
// Size: 0x65
function handlecoordinate( value )
{
    if ( isdefined( self.shootingcrosshair ) )
    {
        yvalue = value % 10000;
        self.shootingcrosshair.yoffset = yvalue - 1000;
        self.shootingcrosshair.xoffset = ( value - yvalue ) / 10000 - 1000;
    }
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 1
// Checksum 0xbd135b42, Offset: 0x3031
// Size: 0x13
function recentercrosshair( value )
{
    function_c15f9c0199b79cde();
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 0
// Checksum 0x2c704cb4, Offset: 0x304c
// Size: 0x59
function function_c15f9c0199b79cde()
{
    viewangles = self getplayerangles();
    newangles = ( 0, viewangles[ 1 ], viewangles[ 2 ] );
    self setplayerangles( newangles );
    self.shootingcrosshair.yoffset = 0;
    self.shootingcrosshair.xoffset = 0;
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 1
// Checksum 0x48af17e9, Offset: 0x30ad
// Size: 0x1e1
function function_d8329b4fb0807fc9( room )
{
    level endon( #"bonus_room_expired" );
    level endon( #"bonus_room_exit_taken" );
    level endon( #"ztron_game_is_over" );
    self endon( #"disconnect" );
    
    /#
        while ( true )
        {
            if ( getdvarint( @"hash_570fe8c64f20bdbf", 0 ) )
            {
                dirvec = self.shootingcrosshair.origin - self.ztron.scriptedcam.origin;
                aimangles = vectortoangles( dirvec );
                aimforward = anglestoforward( aimangles );
                camstart = self.ztron.scriptedcam.origin + aimforward * 4;
                camend = camstart + aimforward * 10000;
                contents = trace::create_all_contents();
                trace = trace::ray_trace( camstart, camend, [ self, self.shootingcrosshair, self.shootingentity ], contents );
                hitpos = trace[ "<dev string:x49>" ] ?? camend;
                
                if ( distancesquared( camstart, hitpos ) < 64 )
                {
                    hitpos = camstart + aimforward * 16;
                }
                
                color = ( 1, 1, 0 );
                
                if ( isdefined( trace[ "<dev string:x52>" ] ) && trace[ "<dev string:x52>" ].playerattractor )
                {
                    color = ( 1, 0, 0 );
                }
                
                level thread ztron_debug::drawsphere( hitpos, 6, 0.1, color );
                level thread ztron_debug::drawline( camstart, hitpos, 0.1, ( 0, 1, 0 ) );
            }
            
            wait 0.1;
        }
    #/
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 1
// Checksum 0xe49e7589, Offset: 0x3296
// Size: 0x1d7
function function_b9e80015b9a39c5( room )
{
    level endon( #"bonus_room_expired" );
    level endon( #"bonus_room_exit_taken" );
    level endon( #"ztron_game_is_over" );
    self endon( #"disconnect" );
    
    /#
        if ( getdvarint( @"hash_570fe8c64f20bdbf", 0 ) )
        {
            thread function_d8329b4fb0807fc9( room );
        }
    #/
    
    while ( isdefined( self.shootingentity ) && isdefined( self.shootingcrosshair ) && isdefined( self.ztron.scriptedcam ) )
    {
        self waittill( #"weapon_fired", weaponobj );
        weapon = self getcurrentweapon();
        
        if ( weaponobj != weapon )
        {
            continue;
        }
        
        function_acab0a1adb7f3838();
        scriptmodelsetweapon( self.shootingentity, weapon );
        contents = trace::create_all_contents();
        tracestart = self.shootingentity.origin;
        traceend = self.shootingentity.origin + anglestoforward( self.shootingentity.angles ) * 10000;
        trace = trace::ray_trace( tracestart, traceend, [ self, self.shootingcrosshair, self.shootingentity ], contents );
        
        if ( isdefined( trace[ "position" ] ) && isdefined( trace[ "entity" ] ) && trace[ "entity" ].playerattractor )
        {
            tracestart = trace[ "position" ] + vectornormalize( anglestoforward( self.shootingentity.angles ) ) * 4;
        }
        
        magicbullet( weapon, tracestart, traceend, self, self.shootingentity );
    }
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 0
// Checksum 0xc4d1b3a4, Offset: 0x3475
// Size: 0x95
function function_3fdcee38c88e3067()
{
    level endon( #"bonus_room_expired" );
    level endon( #"bonus_room_exit_taken" );
    level endon( #"ztron_game_is_over" );
    self endon( #"disconnect" );
    
    while ( isdefined( self.shootingcrosshair ) && isdefined( self.ztron.scriptedcam ) )
    {
        if ( self isreloading() )
        {
            value = -1;
        }
        else
        {
            value = self getweaponammoclip( self getcurrentweapon() );
        }
        
        setomnvar( "ztron_rail_shooter_ammo_player_" + self.sessionuimemberindex, value );
        waitframe();
    }
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 0
// Checksum 0xdb4350f6, Offset: 0x3512
// Size: 0x64
function function_acab0a1adb7f3838()
{
    weapon = self getcurrentweapon();
    clipammo = self getweaponammoclip( weapon );
    stockammo = self getweaponammostock( weapon );
    currentammo = clipammo + stockammo;
    
    if ( currentammo < 100 )
    {
        maxstock = weaponmaxammo( weapon );
        self setweaponammostock( weapon, maxstock );
    }
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 0
// Checksum 0x1cf49457, Offset: 0x357e
// Size: 0x86
function function_de0a56b5ec14699e()
{
    foreach ( player in level.players )
    {
        player playercleanup( player.sessionuimemberindex );
    }
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 1
// Checksum 0xecb52c55, Offset: 0x360c
// Size: 0x91
function playercleanup( sessionidx )
{
    profilestart();
    
    if ( isdefined( self.shootingcrosshair ) )
    {
        self.shootingcrosshair delete();
    }
    
    if ( isdefined( self.shootingentity ) )
    {
        self.shootingentity delete();
    }
    
    if ( isdefined( self ) )
    {
        self lerpfovscalefactor( 1, 0 );
        self.ztron.var_dcf9ab22b803b383 = 0;
        self setclientomnvar( "ztron_rail_shooter_crosshair_recenter", 0 );
    }
    
    setomnvar( "ztron_rail_shooter_crosshair_ent_" + sessionidx, -1 );
    setomnvar( "ztron_rail_shooter_ammo_player_" + sessionidx, -2 );
    profilestop();
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 0
// Checksum 0x215599e5, Offset: 0x36a5
// Size: 0x45
function disconnectedwatcher()
{
    level endon( #"bonus_room_expired" );
    level endon( #"bonus_room_exit_taken" );
    sessionidx = self.sessionuimemberindex;
    self waittill( #"disconnect" );
    playercleanup( sessionidx );
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 1, eflags: 0x4
// Checksum 0x7c3c1764, Offset: 0x36f2
// Size: 0x1a
function private function_c66508b90dc7aa38( params )
{
    self.agent_damage_callback = &zm_damage::function_ddf5f982ca376898;
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 1
// Checksum 0x7caefc2f, Offset: 0x3714
// Size: 0x19e
function function_3f2d93e30b02b9f8( params )
{
    if ( params.smeansofdeath != "MOD_MELEE" )
    {
        switch ( params.shitloc )
        {
            case #"hash_8a1772f5f912c880":
            case #"hash_b107b5547c755d23":
                params.idamage *= 4;
                break;
            case #"hash_92bbfe494d03d772":
                params.idamage *= 5;
                break;
            case #"hash_1cbc508a2fe01b79":
            case #"hash_51d5d0b9add9cc5a":
            case #"hash_810a7426c8bac3ac":
            case #"hash_d42e71cd9f1e822f":
                params.idamage *= 0.8;
                break;
            case #"hash_5d5aac570f6fd382":
            case #"hash_7b36142458a6c2d5":
            case #"hash_a638fec9040cfcf4":
            case #"hash_a7980c387477e7bb":
                params.idamage *= 0.6;
                break;
            case #"hash_da51cc36a471058":
            case #"hash_168c74e879f0ba11":
            case #"hash_9536712388e65bce":
            case #"hash_da2f35145aa58933":
                params.idamage *= 0.4;
                break;
            default:
                break;
        }
    }
    
    return params.idamage;
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 0
// Checksum 0x47f850d4, Offset: 0x38bb
// Size: 0x168
function eggssetup()
{
    self.var_c4cd394168772e62 = [];
    self.activatedeggs = [];
    
    foreach ( egg in self.eggstructs )
    {
        bundlename = ztron_item::function_71e133b37011bee6( "ztron_egg" );
        params = spawnstruct();
        params.shootableprize = 1;
        params.hatchmanually = 1;
        params.var_8112c2cb42fc763c = 512;
        params.overridelifetime = 9999;
        eggitem = ztron_item::spawnitem( bundlename, egg.origin, 0, undefined, params );
        eggent = eggitem;
        eggent.maxhealth = 120;
        eggent.health = 120;
        eggent.curhealth = 120;
        eggent.target = egg.target;
        self.var_c4cd394168772e62[ self.var_c4cd394168772e62.size ] = eggitem;
    }
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 0, eflags: 0x4
// Checksum 0x1b0ad3d7, Offset: 0x3a2b
// Size: 0xc7
function private function_9fb16ae2c245be92()
{
    self.var_e5f9ec88d8c61c3f = utility::getstructarray( "bonus_" + self.name + "_tutorial", "targetname" );
    
    foreach ( crabstruct in self.var_e5f9ec88d8c61c3f )
    {
        crabstruct.crab = ztron_tutorial::function_b18e5953164335be( crabstruct );
        crabstruct.crab thread ztron_util::function_36239518d8da65f0( level, "bonus_room_expired" );
    }
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 1
// Checksum 0x3433fb82, Offset: 0x3afa
// Size: 0xd4
function activateeggs( eggstruct )
{
    foreach ( egg in self.var_c4cd394168772e62 )
    {
        if ( egg.target == eggstruct.target )
        {
            thread activateegg( egg );
            self.var_c4cd394168772e62 = arrayremove( self.var_c4cd394168772e62, egg );
            self.activatedeggs = arraycombineunique( self.activatedeggs, [ egg ] );
        }
    }
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 1
// Checksum 0x6e604eae, Offset: 0x3bd6
// Size: 0x1d
function activateegg( egg )
{
    egg thread namespace_4e36c859ad6a5d59::function_11b925d295f56c6( randomfloatrange( 20, 30 ) );
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 1
// Checksum 0x91b6de0d, Offset: 0x3bfb
// Size: 0x103
function function_1c69df6c3fd6c1aa( origin )
{
    var_ab11c629789b279a = common_item::items_selectfromlist( %"hash_77bc6b41bd96c606", 1 );
    
    foreach ( player in level.players )
    {
        params = spawnstruct();
        params.scale = 2;
        params.launchforce = ( randomintrange( -10, 10 ), randomintrange( -10, 10 ), 200 );
        notifyalert = "shooterEggPrize" + ztron_item::getitemuniqueid();
        player thread function_863b1ea6b2c7cb07( notifyalert );
        ztron_item::requestspawnitem( var_ab11c629789b279a[ 0 ], origin, undefined, undefined, params, notifyalert );
    }
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 1
// Checksum 0x9ad87a0e, Offset: 0x3d06
// Size: 0x29
function function_dd1fa62b48800adb( player )
{
    player lerpfovscalefactor( 0, 0 );
    player setplayerangles( ( 0, 0, 0 ) );
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 4
// Checksum 0xa609e613, Offset: 0x3d37
// Size: 0x1a3
function function_15146526f7c5c6cf( enemyspot, ainame, enemycount, interval )
{
    level endon( #"bonus_room_expired" );
    level endon( #"bonus_room_exit_taken" );
    self endon( #"egg_cleared" );
    aitypedef = ztron_enemy::function_96eea0d09d5640d1( ainame );
    
    if ( !isdefined( aitypedef ) )
    {
        return;
    }
    
    while ( true )
    {
        for ( i = 0; i < enemycount ; i++ )
        {
            pos = enemyspot.origin + anglestoforward( ( 0, randomfloat( 360 ), 0 ) ) * ( 10 + randomfloat( 20 ) );
            enemy = ztron_enemy::function_acee91c445fafd29( aitypedef, pos, enemyspot.targetplayer, undefined, 1, 1 );
            
            if ( !enemy.ztron.boss )
            {
                enemy thread ztron_util::function_ea0a0be5c5468c48( 30 );
            }
            
            basehealth = ( clamp( enemy.maxhealth - level.ztron.var_f1569c16a29ffcbf, 0, 35000 ) + 90 ) * getdvarfloat( @"hash_359cff8946ee07f5", 1 );
            overridehealth = basehealth + basehealth * ( level.players.size - 1 ) * getdvarfloat( @"hash_e5e8fa9b0f08c566", 0.8 );
            enemy ztron_ai_zombie::zombie_sethealth( overridehealth );
            enemy.var_361a087ab08adc1c = "run";
            enemy notify( #"kill_think" );
            wait 0.1;
        }
        
        wait interval;
    }
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 0
// Checksum 0x2b0e6aae, Offset: 0x3ee2
// Size: 0x7b
function chickensetup()
{
    foreach ( chicken in self.chickenstructs )
    {
        spawnchicken( chicken );
    }
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 1
// Checksum 0x272b715, Offset: 0x3f65
// Size: 0x10b
function spawnchicken( chicken )
{
    chickenent = utility::spawn_model( "ztron_chicken", chicken.origin, chicken.angles );
    var_8c496e6decf0bae = spawn( "script_model", chicken.origin );
    var_8c496e6decf0bae setmodel( "sat_zm_ztron_props_bird_cage" );
    var_8c496e6decf0bae setcandamage( 1 );
    var_8c496e6decf0bae solid();
    chickenent setcandamage( 0 );
    var_8c496e6decf0bae.maxhealth = 160;
    var_8c496e6decf0bae.health = var_8c496e6decf0bae.maxhealth;
    chickenent notsolid();
    var_8c496e6decf0bae thread function_1e58bc9d31148a4f();
    var_8c496e6decf0bae thread function_48429b792a90927d();
    var_8c496e6decf0bae thread ztron_util::function_36239518d8da65f0( level, "bonus_room_expired" );
    chickenent thread ztron_util::function_f7544bfa701db406( var_8c496e6decf0bae );
    chickenent thread chickendance();
    chickenent.var_8c496e6decf0bae = var_8c496e6decf0bae;
    
    if ( chicken.script_label == "rail_shooter_hint_2" )
    {
        chicken.var_4d080f710fb8349e = var_8c496e6decf0bae;
    }
}

#using_animtree( "script_model" );

// Namespace namespace_71a8a7e5a5ce9ac
// Params 0
// Checksum 0x7327c397, Offset: 0x4078
// Size: 0x61
function chickendance()
{
    self endon( #"death" );
    self useanimtree( #animtree );
    self.animname = "chicken";
    
    while ( isdefined( self ) )
    {
        animation::anim_single_solo( self, "dance" );
        waittime = getanimlength( level.scr_anim[ "chicken" ][ "dance" ] );
        wait waittime;
    }
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 0
// Checksum 0xdb55d9d5, Offset: 0x40e1
// Size: 0xef
function function_1e58bc9d31148a4f()
{
    level endon( #"bonus_room_expired" );
    level endon( #"bonus_room_exit_taken" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, dflags, objweapon );
        
        if ( isdefined( attacker ) && damage >= 0 )
        {
            var_3f23721405e49c19 = damage > self.maxhealth ? self.maxhealth : damage;
            ztron_util::function_eb8ba16055d6da7c( attacker, self, "none", meansofdeath, objweapon, var_3f23721405e49c19, point, undefined, undefined, 0, 0 );
        }
    }
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 0
// Checksum 0xf0cda8b5, Offset: 0x41d8
// Size: 0x4b
function function_48429b792a90927d()
{
    level endon( #"bonus_room_expired" );
    level endon( #"bonus_room_exit_taken" );
    self waittill( #"death", attacker );
    
    if ( isplayer( attacker ) )
    {
        function_bd7262065a47373b( attacker );
    }
    
    self delete();
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 1
// Checksum 0x3fd98a57, Offset: 0x422b
// Size: 0x2d
function function_bd7262065a47373b( attacker )
{
    attacker function_85a5d9b80154ec86( self.origin, 60 );
    attacker ztron_score::function_7febfbfc901efb42( 1000, self );
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 2, eflags: 0x4
// Checksum 0x793658bf, Offset: 0x4260
// Size: 0xbd, Type: bool
function private checkhint( spots, label )
{
    foreach ( spot in spots )
    {
        if ( spot.script_label == label )
        {
            if ( isdefined( spot.var_4d080f710fb8349e ) && spot.var_4d080f710fb8349e.health > 0 )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 1, eflags: 0x4
// Checksum 0xf06e1ed3, Offset: 0x4326
// Size: 0x1ae
function private function_1e03d805838998fa( eventstruct )
{
    level endon( #"bonus_room_expired" );
    level endon( #"bonus_room_exit_taken" );
    
    if ( !isdefined( eventstruct.crab ) )
    {
        return;
    }
    
    switch ( int( eventstruct.script_noteworthy ) )
    {
        case 1:
            if ( checkhint( self.hazards, "rail_shooter_hint_1" ) )
            {
                eventstruct.crab ztron_dialog::function_7e3f6329d9afcdc1( "crab_hint_droplight", 1 );
            }
            
            break;
        case 2:
            if ( checkhint( self.chickenstructs, "rail_shooter_hint_2" ) )
            {
                eventstruct.crab ztron_dialog::function_7e3f6329d9afcdc1( "crab_shooter_hint_chicken", 1 );
            }
            
            break;
        case 3:
            eventstruct.crab ztron_dialog::function_7e3f6329d9afcdc1( "crab_shooter_hint_egg", 1 );
            break;
        case 4:
            if ( checkhint( self.hazards, "rail_shooter_hint_4" ) )
            {
                eventstruct.crab ztron_dialog::function_7e3f6329d9afcdc1( "crab_shooter_hint_oil_trap", 1 );
            }
            
            break;
        case 5:
            eventstruct.crab ztron_dialog::function_7e3f6329d9afcdc1( "crab_shooter_hint_outra", 1 );
            break;
        case 6:
            eventstruct.crab ztron_dialog::function_7e3f6329d9afcdc1( "rail_shooter_welcome", 1 );
            break;
        default:
            break;
    }
    
    self waittill( #"hash_aee0b5014bd1cacc" );
    eventstruct.crab ztron_util::deletemedelay( 10 );
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 1, eflags: 0x4
// Checksum 0x12e262f0, Offset: 0x44dc
// Size: 0x142
function private function_3fd6a55d2476e5e2( event )
{
    level endon( #"bonus_room_expired" );
    level endon( #"bonus_room_exit_taken" );
    aitypedef = ztron_enemy::function_96eea0d09d5640d1( "basic_zombie" );
    targetposstruct = utility::getstruct( event.targetname, "target" );
    targetpos = getclosestpointonnavmesh( targetposstruct.origin );
    giftzombie = ztron_enemy::function_acee91c445fafd29( aitypedef, event.origin, undefined, undefined, 1, 1 );
    giftzombie.var_361a087ab08adc1c = "sprint";
    giftzombie setbtgoalpos( 3, targetpos );
    giftzombie thread function_8d70735949dc0a1c( targetpos );
    giftzombie callback::add( #"on_ai_killed", &function_cf672819d8e4e94b );
    var_dc08320ce4383f0c = spawn( "script_model", event.origin );
    var_dc08320ce4383f0c setscale( 0.75 );
    var_dc08320ce4383f0c setmodel( "sat_zm_ztron_props_christmas_gift_01" );
    var_dc08320ce4383f0c notsolid();
    var_dc08320ce4383f0c linkto( giftzombie, "j_spine4", ( 0, 10, 0 ), ( 90, 90, 0 ) );
    var_dc08320ce4383f0c thread ztron_util::function_f7544bfa701db406( giftzombie );
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 1
// Checksum 0x49f079b8, Offset: 0x4626
// Size: 0x5c
function function_8d70735949dc0a1c( targetpos )
{
    level endon( #"bonus_room_expired" );
    level endon( #"bonus_room_exit_taken" );
    self endon( #"death" );
    
    while ( true )
    {
        if ( distance( self.origin, targetpos ) < 16 )
        {
            self kill();
            break;
        }
        
        wait 0.1;
    }
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 1
// Checksum 0x9656bca7, Offset: 0x468a
// Size: 0x39
function function_cf672819d8e4e94b( params )
{
    if ( isplayer( params.eattacker ) )
    {
        params.eattacker function_85a5d9b80154ec86( self.origin );
    }
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 1
// Checksum 0xbf72e100, Offset: 0x46cb
// Size: 0x77
function function_8dd77aba50b688c3( itemname )
{
    isvalid = 1;
    type = getscriptbundlefieldvalue( itemname, #"genericstring" );
    
    if ( isdefined( type ) )
    {
        var_8f68bdf2157380d3 = ztron_item::function_230d60331b07b7da( type, #"hash_87300e1dbd3aa856" );
        
        if ( isdefined( var_8f68bdf2157380d3 ) )
        {
            params = spawnstruct();
            isvalid = [[ var_8f68bdf2157380d3 ]]( params );
        }
    }
    else
    {
        isvalid = 0;
    }
    
    return isvalid;
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 1
// Checksum 0xa87e1538, Offset: 0x474b
// Size: 0xdf
function function_bc1a79042a238b1c( itemname )
{
    if ( function_8dd77aba50b688c3( itemname ) )
    {
        return itemname;
    }
    
    itempool = [ %"hash_3fb48f7c7b8bf5dd", %"hash_11a8464cc7637313", %"itemspawnentry:ztron_item_extra_life" ];
    
    if ( arraycontains( itempool, itemname ) )
    {
        itempool = arrayremove( itempool, itemname );
        
        foreach ( otheritem in itempool )
        {
            if ( function_8dd77aba50b688c3( otheritem ) )
            {
                return otheritem;
            }
        }
    }
    
    return %"hash_71e67abf5be8f846";
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 2
// Checksum 0x79df675c, Offset: 0x4833
// Size: 0x120
function function_85a5d9b80154ec86( origin, var_ae74a4be74e49b9a = 30 )
{
    spawnoptions = ztron_item::function_41854e96b8bf4a06( origin );
    var_b11745f5583ad1df = randomint( 100 );
    
    if ( var_b11745f5583ad1df < var_ae74a4be74e49b9a )
    {
        itemnames = common_item::items_selectfromlist( %"hash_358e9e6c69f664b3", 1 );
    }
    else
    {
        itemnames = common_item::items_selectfromlist( %"hash_32c5e96f5f7bc1ca", 5 );
    }
    
    if ( itemnames )
    {
        foreach ( itemname in itemnames )
        {
            itemname = function_bc1a79042a238b1c( itemname );
            notifyalert = "shooterGiftItem" + ztron_item::getitemuniqueid();
            thread function_863b1ea6b2c7cb07( notifyalert );
            ztron_item::requestspawnitem( itemname, origin, 52, spawnoptions, undefined, notifyalert );
        }
    }
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 1
// Checksum 0x283da46c, Offset: 0x495b
// Size: 0x6e
function function_863b1ea6b2c7cb07( notifyalert )
{
    level endon( #"bonus_room_expired" );
    level endon( #"bonus_room_exit_taken" );
    level endon( #"ztron_game_is_over" );
    level waittill( notifyalert, iteminfo );
    item = iteminfo.entity;
    item.owner = self;
    item thread function_9a7bc3decdc1d49e( self );
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 1, eflags: 0xc
// Checksum 0x7cb3b757, Offset: 0x49d1
// Size: 0x40
function private function_9a7bc3decdc1d49e( player )
{
    self notify( #"hash_6627fc2c51d2189e" );
    self endon( #"hash_6627fc2c51d2189e" );
    self endon( #"death" );
    wait 1;
    
    if ( self )
    {
        thread ztron_item::function_5dce405b07e4f28c( player );
    }
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 1
// Checksum 0xddbdf41, Offset: 0x4a19
// Size: 0x8b
function function_8521170b4fbb44d7( event )
{
    if ( !isdefined( self.jump_scare_props ) )
    {
        self.jump_scare_props = [];
    }
    
    prop = utility::spawn_model( "decor_barrel_wood_ztron", event.origin, event.angles );
    prop.var_82209d06b3fad29d = [];
    prop.team = zm_utility::get_zombie_team();
    self.jump_scare_props = arraycombineunique( self.jump_scare_props, [ prop ] );
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 1
// Checksum 0x515b0602, Offset: 0x4aac
// Size: 0x35
function jumpscareevent( event )
{
    level thread namespace_a3764ff99ce0cd56::function_b8a2fee812bf9ede( self.jump_scare_props[ randomint( self.jump_scare_props.size ) ], level.players );
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 1
// Checksum 0x5783faaf, Offset: 0x4ae9
// Size: 0x1a
function function_e57857c7c6ab607( event )
{
    ztron_item::function_6607be6e510e8f54( [ event ] );
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 1
// Checksum 0x78f15f88, Offset: 0x4b0b
// Size: 0x91
function function_aafa66f13d2466e8( event )
{
    level endon( #"bonus_room_expired", #"bonus_room_exit_taken", #"ztron_game_is_over" );
    timeleft = gettime() + 10000;
    params = spawnstruct();
    params.scale = 1;
    params.shootable = 1;
    
    while ( timeleft > gettime() )
    {
        ztron_item::function_d0a061baefd87906( event.origin, 1, 100, undefined, params );
        wait 1;
    }
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 1, eflags: 0x4
// Checksum 0x4df88011, Offset: 0x4ba4
// Size: 0xec
function private function_1e776a27c92c8e9a( player )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    sessionuimemberindex = player.sessionuimemberindex;
    yoffset = sessionuimemberindex % 2 ? 30 : -30;
    zoffset = sessionuimemberindex < 2 ? 20 : -20;
    var_b7e295786fca3ba7 = anglestoright( player.ztron.scriptedcam.angles );
    upvector = anglestoup( player.ztron.scriptedcam.angles );
    offset = yoffset * var_b7e295786fca3ba7 + zoffset * upvector;
    return player.ztron.scriptedcam.origin + offset;
}

// Namespace namespace_71a8a7e5a5ce9ac
// Params 1
// Checksum 0x37aa08a7, Offset: 0x4c99
// Size: 0x23
function cannonfireevent( event )
{
    ztron_sound::ztron_playsound( "rail_shooter_cannon_fire_OS", event.origin );
}

/#

    // Namespace namespace_71a8a7e5a5ce9ac
    // Params 0
    // Checksum 0xbef43623, Offset: 0x4cc4
    // Size: 0x6d, Type: dev
    function function_ac7ee3673d6e340d()
    {
        categoryname = ztron_bonus_room::function_26fbf99313eff547( "<dev string:x2b>" );
        devgui::function_9082edeb5db93280( "<dev string:x59>" );
        devgui::add_devgui_func( "<dev string:x6d>" + categoryname + "<dev string:x7d>", "<dev string:x90>", &function_d1e3f303ccdac61c );
        devgui::add_devgui_func( "<dev string:x6d>" + categoryname + "<dev string:x9f>", "<dev string:xb4>", &function_90841d00d86412a5 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_71a8a7e5a5ce9ac
    // Params 0
    // Checksum 0x6ed653a7, Offset: 0x4d39
    // Size: 0x45, Type: dev
    function function_d1e3f303ccdac61c()
    {
        level.ztron.var_8a9067aa4cd65369.var_ebd74f33daf1acfb = 1;
        level.ztron.var_8a9067aa4cd65369.var_d3060df21967839b = 1;
    }

    // Namespace namespace_71a8a7e5a5ce9ac
    // Params 0
    // Checksum 0x9f99acd6, Offset: 0x4d86
    // Size: 0x45, Type: dev
    function function_90841d00d86412a5()
    {
        level.ztron.var_8a9067aa4cd65369.var_90841d00d86412a5 = 1;
        level.ztron.var_8a9067aa4cd65369.var_d3060df21967839b = 1;
    }

#/
