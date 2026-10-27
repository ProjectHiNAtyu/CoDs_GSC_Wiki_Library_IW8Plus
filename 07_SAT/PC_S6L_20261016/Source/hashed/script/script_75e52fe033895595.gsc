// script_75e52fe033895595  (hash_75e52fe033895595.gscc) (size: 46297 Bytes / 0xb4d9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7142279b (1900160923)
// size ...... 46297 (0xb4d9)
// includes .. 40  (offset: 0xa4bd)
// strings ... 178 (offset: 0xa5fd)
// dev strs .. 4   (offset: 0xb279)
// exports ... 68  (offset: 0x7555)
// cseg ...... 0x11d1 + 0x6384 (0x7555)
// imports ... 294 (offset: 0x7ff5)
// animtree1 . 1   (offset: 0xb2a9)
// animtree2 . 33  (offset: 0xb2c9)
#using script_599653855a4317f1;
#using script_5c65d346ac65390c;
#using scripts\anim\dialogue;
#using scripts\common\anim;
#using scripts\common\cap;
#using scripts\common\elevator;
#using scripts\common\script;
#using scripts\common\scriptable;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_paths;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\agents\common_agent_damage;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_fortress;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\anim;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_dmz_extract;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\dmz\gametypes\dmz_audio;
#using scripts\mp\dmz\gametypes\dmz_task_utils;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\activity_manager;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\rescue;
#using scripts\mp\hud_message;
#using scripts\mp\juggernaut;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outofbounds;
#using scripts\mp\poi;

#namespace namespace_87e5a35991b973ad;

// Namespace namespace_87e5a35991b973ad
// Params 1
// Checksum 0x1b53986d, Offset: 0x11ef
// Size: 0x139
function dmztask_getspawndata( data )
{
    level.hostageprops = spawnstruct();
    level.hostageprops.circleradius = getdvarint( @"scr_dmz_hostage_circle_radius", 300 );
    level.hostageprops.circlepadding = getdvarint( @"hash_1d6b7e1f5eab0397", 700 );
    level.hostageprops.bombtimer = getdvarfloat( @"scr_dmz_hostage_bomb_timer", 50 );
    level.hostageprops.disarmtime = getdvarfloat( @"hash_11c996694ec6bc7d", 3 );
    level.hostageprops.blockplayerdamage = getdvarint( @"hash_152094cca50e086", 1 );
    level.hostageprops.fortressrange = getdvarfloat( @"hash_4f66fa15a2fb52a5", 750 );
    initanims();
    level._effect[ "hostage_bomb_explosion" ] = loadfxasset( "vfx_iw8_mp_gamemode_search_bombsite_destroy" );
    scriptable::scriptable_addusedcallbackbypart( "dmz_hostage", &function_8c08a3b490c17a5c );
    activity_manager::function_f61a1f535aab4194( data, &function_337729b0af92543, function_1c864efef16c49da() );
}

/#

    // Namespace namespace_87e5a35991b973ad
    // Params 0
    // Checksum 0x7ef02aa4, Offset: 0x1330
    // Size: 0x16, Type: dev
    function function_746bdfc760ec9b18()
    {
        return utility::getstructarray( "<dev string:x24>", "<dev string:x32>" );
    }

#/

// Namespace namespace_87e5a35991b973ad
// Params 2
// Checksum 0x1d2c93a2, Offset: 0x134e
// Size: 0x181
function function_337729b0af92543( mission, node )
{
    task = dmz_task_utils::task_create( mission );
    task.funcs[ "onInit" ] = &function_43b993eacaa3b5d9;
    task.funcs[ "onPlayerJoined" ] = &function_104afe24050f8db;
    task.funcs[ "onPlayerRemoved" ] = &function_a4f4949986ba3cfa;
    task.funcs[ "onTeamAssigned" ] = &function_36ef053a1f11efe6;
    task.funcs[ "onTeamStart" ] = &function_9ec8962c0cc2104e;
    task.funcs[ "onCancel" ] = &function_df6b643c7a591ed9;
    task.ref = "dmz_hostage";
    task.refindex = br_contract_manager::getquesttableindex( task.ref );
    task.node = node;
    fort = ai_fortress::function_a342bb675c7cb16e( node.origin, "hostage_forts" );
    ai_fortress::function_d9f4f0632c1968e( fort, "hostage_door" );
    ai_fortress::function_a40880395f853edc( fort, 0, 1, 0, 0, undefined, undefined, undefined, undefined, 1, 0 );
    task.fort = fort;
    task.helinode = node.helinode;
    node.helinode.info = br_dmz_extract::function_bdfb03bd8abf37a1( node.helinode, 0 );
    return task;
}

// Namespace namespace_87e5a35991b973ad
// Params 0
// Checksum 0xabac3a16, Offset: 0x14d8
// Size: 0x16d
function function_43b993eacaa3b5d9()
{
    self.activity.origin = self.node.origin;
    self.node.inuse = 1;
    circlelocation = dmz_task_utils::function_c7ccd46fc59f189d( self.fort.origin, level.hostageprops.circleradius );
    dmz_task_utils::function_13fe84cb824c72a8( "Hostage_Dmz", [ circlelocation ], level.hostageprops.circleradius + level.hostageprops.circlepadding );
    self.curorigin = circlelocation;
    self.offset3d = ( 0, 0, 750 );
    dmz_task_utils::function_b3476f99a8e21fa2( self.curorigin + self.offset3d, "rescue" );
    objidpoolmanager::objective_set_play_intro( self.icon, 1 );
    objidpoolmanager::objective_set_play_outro( self.icon, 0 );
    self.door_opened = 0;
    self.activitykey = "hostage" + gettime();
    dmztask_lockdoors();
    function_318298d49322cf35();
    
    if ( !isdefined( self.hostage ) )
    {
        dmztask_cleanup();
        dmz_task_utils::task_ended();
        return;
    }
    
    function_be1cf3944aef242a();
    
    /#
        thread debughostage();
    #/
}

// Namespace namespace_87e5a35991b973ad
// Params 1
// Checksum 0x53eef4cc, Offset: 0x164d
// Size: 0x94
function function_104afe24050f8db( player )
{
    player.activitykey = self.activitykey;
    players = teams::getteamdata( player.team, "players" );
    
    if ( !isdefined( self.bombexploded ) )
    {
        self.instance enablescriptableplayeruse( player );
        return;
    }
    
    if ( isdefined( self.carryingplayer ) )
    {
        self.instance disablescriptableplayeruse( player );
        return;
    }
    
    self.instance enablescriptableplayeruse( player );
}

// Namespace namespace_87e5a35991b973ad
// Params 1
// Checksum 0xbe4f53ec, Offset: 0x16e9
// Size: 0x3f
function function_a4f4949986ba3cfa( player )
{
    player.activitykey = undefined;
    
    if ( self.carryingplayer == player )
    {
        drophostage( 1 );
    }
    
    self.instance disablescriptableplayeruse( player );
}

// Namespace namespace_87e5a35991b973ad
// Params 1
// Checksum 0xb3b7094e, Offset: 0x1730
// Size: 0x1ae
function function_36ef053a1f11efe6( teamname )
{
    dmz_task_utils::task_showsplashtoteam( "dmz_hostage_assigned", teamname );
    dmz_task_utils::function_18b83232055b1325( teamname );
    dmz_task_utils::function_44b2bf42bbc07d05( teamname );
    players = teams::getteamdata( teamname, "players" );
    self.instance setscriptablepartstate( "dmz_hostage", "usable", 0 );
    
    foreach ( player in level.players )
    {
        self.instance disablescriptableplayeruse( player );
    }
    
    foreach ( player in players )
    {
        self.instance enablescriptableplayeruse( player );
    }
    
    utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"hostage_rescue_assigned", teamname );
    dmz_audio::function_32ff837bc21a4833( teamname, "dmz_hostage_start", 1.5, "dmz_hostage_start_classic" );
    thread function_a77a72a914195a57( teamname );
    
    /#
        if ( getdvarint( @"scr_dmz_hostage_teleport", 0 ) == 1 )
        {
            function_b348f2db945fff04();
        }
    #/
}

// Namespace namespace_87e5a35991b973ad
// Params 1
// Checksum 0x4dfe7af2, Offset: 0x18e6
// Size: 0x48
function function_9ec8962c0cc2104e( teamname )
{
    utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"hostage_rescue_approach", teamname, 2 );
    dmz_audio::function_32ff837bc21a4833( teamname, "dmz_hostage_approach", 0 );
}

// Namespace namespace_87e5a35991b973ad
// Params 1
// Checksum 0x7dad40c7, Offset: 0x1936
// Size: 0x53
function function_df6b643c7a591ed9( teamname )
{
    self.failure = 1;
    dmztask_cleanup();
    
    if ( isdefined( self.carryingplayer ) )
    {
        thread drophostage( 1 );
    }
    
    dmz_audio::function_32ff837bc21a4833( teamname, "dmz_hostage_rescue_failed", 1, "dmz_hostage_rescue_failed_classic" );
    dmz_task_utils::task_ended();
}

// Namespace namespace_87e5a35991b973ad
// Params 0
// Checksum 0xcf6be57c, Offset: 0x1991
// Size: 0x19b
function dmztask_cleanup()
{
    if ( self.completed )
    {
        return;
    }
    
    self.completed = 1;
    
    if ( !self.skipcontract )
    {
        if ( isdefined( self.shownplayers ) )
        {
            foreach ( player in self.shownplayers )
            {
                objidpoolmanager::function_6ac40386d1cd0d9a( self.icon, player );
            }
        }
        
        dmz_task_utils::function_e23cad864e9e2023();
        dmz_task_utils::function_3ff46488beb193c7();
    }
    
    if ( isdefined( self.instance ) )
    {
        self.instance freescriptable();
    }
    
    if ( isdefined( self.heli ) && isdefined( self.heli.var_77f46a6090b89414 ) )
    {
        foreach ( player in self.heli.var_77f46a6090b89414 )
        {
            player br_dmz_extract::function_ef11b325984b4fa0();
        }
    }
    
    if ( !self.skipcontract )
    {
        dmz_task_utils::function_2f96219ec7ea4fe9( self.teams[ 0 ] );
    }
}

// Namespace namespace_87e5a35991b973ad
// Params 1
// Checksum 0xea18137e, Offset: 0x1b34
// Size: 0xcd
function function_18ab4afb1d91eacc( teamname )
{
    dmztask_cleanup();
    
    if ( !self.skipcontract )
    {
        if ( isdefined( teamname ) )
        {
            utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"hostage_rescue_hostage_exfil", teamname, 2 );
            dmz_task_utils::function_c64a66646904bc1( "dmz_hostage_exfilled", "hostage", self.activity.cashreward, teamname );
            dmz_task_utils::function_e533421ccebd7d79( teamname );
            dmz_audio::function_32ff837bc21a4833( teamname, "", 0 );
        }
        else if ( isdefined( self.teams[ 0 ] ) )
        {
            dmz_audio::function_32ff837bc21a4833( self.teams[ 0 ], "dmz_hostage_rescue_failed", 0, "dmz_hostage_rescue_failed_classic" );
        }
        
        dmz_task_utils::task_ended( teamname );
    }
}

// Namespace namespace_87e5a35991b973ad
// Params 0
// Checksum 0x56104b97, Offset: 0x1c09
// Size: 0x10d
function dmztask_lockdoors()
{
    foreach ( door in self.fort.lockeddoors )
    {
        door.task = self;
        door scriptabledoorclose();
        door.activitykey = self.activitykey;
        door.var_fd6a9fa1008c262 = 1;
        
        /#
            dmz_logging::addlogevent( "<dev string:x3d>", self.activity.name, undefined, undefined, undefined, undefined, self.activity.script_poi, door.origin );
        #/
    }
    
    ai_fortress::function_39b5f3f3ab7d820b( self.fort, undefined, &function_1007c638ae97eff9 );
}

// Namespace namespace_87e5a35991b973ad
// Params 2
// Checksum 0xca2f839a, Offset: 0x1d1e
// Size: 0x4b
function function_1007c638ae97eff9( door, player )
{
    if ( isdefined( door.task ) )
    {
        if ( door.node.script_noteworthy == "lockMe" )
        {
            door thread function_ac12d70d53dad798();
        }
    }
}

// Namespace namespace_87e5a35991b973ad
// Params 0
// Checksum 0x3476630f, Offset: 0x1d71
// Size: 0x24
function function_ac12d70d53dad798()
{
    while ( self scriptabledoorisclosed() )
    {
        waitframe();
    }
    
    self.task.door_opened = 1;
}

// Namespace namespace_87e5a35991b973ad
// Params 1
// Checksum 0xaddfca8e, Offset: 0x1d9d
// Size: 0x83
function function_a77a72a914195a57( teamname )
{
    self endon( #"task_ended" );
    self endon( #"hash_8556e1de64342ce1" );
    
    while ( !self.door_opened )
    {
        waitframe();
    }
    
    self.hostage.invulnerable = undefined;
    utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"hostage_rescue_loud", teamname );
    self.state = "player_entered_building";
    thread function_20020bc336f5fabf( teamname );
}

// Namespace namespace_87e5a35991b973ad
// Params 1, eflags: 0x4
// Checksum 0xa1ccba80, Offset: 0x1e28
// Size: 0x337
function private function_20020bc336f5fabf( teamname )
{
    if ( self.aborttimer || isdefined( self.bombexploded ) && !self.bombexploded )
    {
        return;
    }
    
    self endon( #"task_ended" );
    self endon( #"hash_8556e1de64342ce1" );
    
    if ( self.var_932865855e26e3b4 )
    {
        return;
    }
    
    self.var_932865855e26e3b4 = 1;
    timer = level.hostageprops.bombtimer;
    dmz_audio::function_32ff837bc21a4833( teamname, "dmz_hostage_breach", 1, "dmz_hostage_breach_classic" );
    thread function_c8b15501849a4f19( timer );
    objidpoolmanager::objective_set_show_progress( self.icon, 1 );
    bombexploded = explode_bomb( timer );
    
    if ( isdefined( bombexploded ) )
    {
        self.bombexploded = bombexploded;
    }
    
    foreach ( player in self.shownplayers )
    {
        objidpoolmanager::function_6ac40386d1cd0d9a( self.icon, player );
        objidpoolmanager::objective_unpin_player( self.icon, player );
    }
    
    if ( self.bombexploded == 0 )
    {
        objidpoolmanager::objective_set_show_progress( self.icon, 0 );
    }
    
    if ( self.bombexploded )
    {
        self notify( #"bomb_exploded" );
        
        if ( isdefined( self.hostage ) && self.hostage.health > 0 )
        {
            self.hostage dodamage( 1000, self.hostage.origin );
        }
        
        effect = "hostage_bomb_explosion";
        explosionpos = self.c4.origin + ( 0, 0, 50 );
        explosioneffect = spawnfx( level._effect[ effect ], explosionpos );
        explosioneffect thread utility::delete_after_delay( 10 );
        triggerfx( explosioneffect );
        physicsexplosionsphere( explosionpos, 200, 100, 3 );
        playrumbleonposition( "grenade_rumble", self.c4.origin );
        earthquake( 0.25, 0.5, self.c4.origin, 500 );
        playsoundatpos( explosionpos, "exp_bombsite_lr" );
        radiusdamage( self.c4.origin + ( 0, 0, 50 ), 200, 500, 10, undefined, "MOD_EXPLOSIVE", "bomb_site_mp" );
        utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"hostage_rescue_exploded", self.teams[ 0 ], 2 );
    }
    
    if ( isdefined( self.c4 ) )
    {
        self.c4 delete();
    }
}

// Namespace namespace_87e5a35991b973ad
// Params 1
// Checksum 0xb0adc7e, Offset: 0x2167
// Size: 0x4c
function function_c8b15501849a4f19( timer )
{
    level endon( #"game_ended" );
    self endon( #"task_ended" );
    self endon( #"bomb_defused" );
    wait timer;
    self.instance setscriptablepartstate( "dmz_hostage", "unusable", 0 );
}

// Namespace namespace_87e5a35991b973ad
// Params 1
// Checksum 0x97a02e61, Offset: 0x21bb
// Size: 0x212, Type: bool
function explode_bomb( timer )
{
    level endon( #"game_ended" );
    self endon( #"task_ended" );
    self endon( #"bomb_defused" );
    self endon( #"hash_8556e1de64342ce1" );
    self.shownplayers = [];
    currenttime = gettime();
    offset = 1000 * level.hostageprops.disarmtime;
    bombendtime = int( currenttime + 1000 * timer + offset );
    var_f4f3f0356fef8102 = bombendtime - currenttime;
    thread function_5f5a4f76a8ab7073( bombendtime, offset );
    
    while ( var_f4f3f0356fef8102 > 0 )
    {
        currenttime = gettime();
        var_f4f3f0356fef8102 = bombendtime - currenttime;
        
        if ( var_f4f3f0356fef8102 < 0 )
        {
            break;
        }
        
        self.nearbyplayers = [];
        playersonteam = teams::getteamdata( self.teams[ 0 ], "players" );
        
        foreach ( player in playersonteam )
        {
            if ( distance2dsquared( player.origin, self.fort.origin ) < 1048576 )
            {
                self.nearbyplayers[ self.nearbyplayers.size ] = player;
            }
        }
        
        progress = ( var_f4f3f0356fef8102 - offset ) / timer * 1000;
        
        if ( progress > 0 )
        {
            self.shownplayers = function_ec6036aef78df06( self.nearbyplayers, self.shownplayers );
            objidpoolmanager::objective_set_progress( self.icon, progress );
        }
        else
        {
            objidpoolmanager::function_a55b645deb36be18( self.icon );
            self.objectivehidden = 1;
        }
        
        waitframe();
    }
    
    return true;
}

// Namespace namespace_87e5a35991b973ad
// Params 2
// Checksum 0x5e4c59a1, Offset: 0x23d6
// Size: 0x190
function function_5f5a4f76a8ab7073( bombendtime, offset )
{
    level endon( #"game_ended" );
    self endon( #"task_ended" );
    self endon( #"hash_8556e1de64342ce1" );
    self endon( #"bomb_exploded" );
    self endon( #"bomb_defused" );
    currenttime = gettime();
    var_f4f3f0356fef8102 = bombendtime - currenttime;
    
    while ( var_f4f3f0356fef8102 > 0 )
    {
        currenttime = gettime();
        var_f4f3f0356fef8102 = bombendtime - currenttime;
        
        if ( var_f4f3f0356fef8102 <= 0 + offset )
        {
            if ( var_f4f3f0356fef8102 <= 250 )
            {
                if ( soundexists( "hostage_warning_beep_05" ) )
                {
                    self.c4 playsound( "hostage_warning_beep_05" );
                }
            }
            else if ( var_f4f3f0356fef8102 <= 750 )
            {
                if ( soundexists( "hostage_warning_beep_04" ) )
                {
                    self.c4 playsound( "hostage_warning_beep_04" );
                }
            }
            else if ( var_f4f3f0356fef8102 <= 1500 )
            {
                if ( soundexists( "hostage_warning_beep_03" ) )
                {
                    self.c4 playsound( "hostage_warning_beep_03" );
                }
            }
            else if ( soundexists( "hostage_warning_beep_02" ) )
            {
                self.c4 playsound( "hostage_warning_beep_02" );
            }
            
            wait 0.25;
            continue;
        }
        
        if ( var_f4f3f0356fef8102 <= 10000 + offset )
        {
            if ( soundexists( "hostage_warning_beep_02" ) )
            {
                self.c4 playsound( "hostage_warning_beep_02" );
            }
            
            wait 0.5;
            continue;
        }
        
        if ( soundexists( "hostage_warning_beep_01" ) )
        {
            self.c4 playsound( "hostage_warning_beep_01" );
        }
        
        wait 1;
    }
}

// Namespace namespace_87e5a35991b973ad
// Params 2
// Checksum 0x109b7fa5, Offset: 0x256e
// Size: 0x14f
function function_ec6036aef78df06( nearbyplayers, shownplayers )
{
    allplayers = arraycombine( nearbyplayers, shownplayers );
    var_153d7595b0bea5fd = shownplayers;
    
    foreach ( player in allplayers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !arraycontains( shownplayers, player ) && arraycontains( nearbyplayers, player ) )
        {
            if ( objidpoolmanager::function_72efeaceb614613a( self.icon, player, 2, 2, &"mp_dmz_missions/hostage_bar_title" ) )
            {
                objidpoolmanager::objective_pin_player( self.icon, player );
                objidpoolmanager::objective_playermask_addshowplayer( self.icon, player );
                var_153d7595b0bea5fd[ var_153d7595b0bea5fd.size ] = player;
            }
            
            continue;
        }
        
        if ( arraycontains( shownplayers, player ) && !arraycontains( nearbyplayers, player ) )
        {
            objidpoolmanager::objective_unpin_player( self.icon, player );
            objidpoolmanager::function_6ac40386d1cd0d9a( self.icon, player );
            var_153d7595b0bea5fd = arrayremove( var_153d7595b0bea5fd, player );
        }
    }
    
    return var_153d7595b0bea5fd;
}

// Namespace namespace_87e5a35991b973ad
// Params 0, eflags: 0x4
// Checksum 0xbded7dc9, Offset: 0x26c6
// Size: 0x1dd
function private monitorhostage()
{
    self endon( #"task_ended" );
    self.hostage thread function_9989defe1f5947f4();
    
    while ( isdefined( self.hostage ) && self.hostage.health > 0 && !self.bombexploded )
    {
        waitframe();
    }
    
    if ( self.failure )
    {
        return;
    }
    
    self.failure = 1;
    
    if ( isdefined( self.hostageent ) )
    {
        self.hostageent delete();
    }
    
    if ( !self.skipcontract )
    {
        dmz_task_utils::function_c64a66646904bc1( "dmz_hostage_failure", "hostage", 0, self.teams[ 0 ] );
        
        if ( isdefined( self.teams[ 0 ] ) && !self.bombexploded )
        {
            utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"hostage_rescue_shot", self.teams[ 0 ], 1.5 );
        }
        
        if ( isdefined( self.shownplayers ) )
        {
            foreach ( player in self.shownplayers )
            {
                objidpoolmanager::function_6ac40386d1cd0d9a( self.icon, player );
                objidpoolmanager::objective_unpin_player( self.icon, player );
            }
        }
        
        objidpoolmanager::objective_playermask_hidefromall( self.icon );
        objidpoolmanager::objective_set_show_progress( self.icon, 0 );
        self.questcircles[ 0 ] game_utility::questcircle_hidefromall();
    }
    
    thread function_18ab4afb1d91eacc();
}

// Namespace namespace_87e5a35991b973ad
// Params 6, eflags: 0x4
// Checksum 0x8e908c13, Offset: 0x28ab
// Size: 0x81c
function private function_8c08a3b490c17a5c( instance, part, state, player, bautouse, usestring )
{
    if ( part != "dmz_hostage" )
    {
        return;
    }
    
    if ( !isdefined( instance.task ) )
    {
        return;
    }
    
    if ( !instance.task.skipcontract && ( !isdefined( instance.task.teams[ 0 ] ) || player.team != instance.task.teams[ 0 ] ) )
    {
        assertmsg( "<dev string:x47>" );
        return;
    }
    
    if ( state == "usable" && isdefined( instance.hostage ) )
    {
        if ( isdefined( instance.task.task_ended ) )
        {
            return;
        }
        
        instance setscriptablepartstate( "dmz_hostage", "unusable" );
        task = instance.task;
        task.c4 hide();
        bomb = task function_183e57e00b1d1dd0( player );
        thread dmz_task_utils::task_watchcancel( instance, task, player );
        buttontime = 0;
        
        while ( buttontime < level.hostageprops.disarmtime )
        {
            if ( !isdefined( instance ) || instance.cancel || task.failure || !player::isaliveandnotinlaststand( player ) )
            {
                if ( isdefined( player ) )
                {
                    player notifyonplayercommandremove( "cancel", "+weapnext" );
                }
                
                task function_915debdf87f515ac( player, bomb );
                task.c4 show();
                
                if ( !task.failure && isdefined( instance ) )
                {
                    instance setscriptablepartstate( "dmz_hostage", "usable" );
                    
                    foreach ( otherplayer in level.players )
                    {
                        instance disablescriptableplayeruse( otherplayer );
                    }
                    
                    teammates = teams::getteamdata( instance.task.teams[ 0 ], "players" );
                    
                    foreach ( teammate in teammates )
                    {
                        instance enablescriptableplayeruse( teammate );
                    }
                }
                
                return 0;
            }
            
            buttontime += level.framedurationseconds;
            waitframe();
        }
        
        if ( isdefined( player ) )
        {
            player notifyonplayercommandremove( "cancel", "+weapnext" );
        }
        
        if ( instance.task.failure )
        {
            instance.task function_915debdf87f515ac( player, bomb );
            
            if ( isdefined( task.c4 ) )
            {
                task.c4 delete();
            }
            
            return;
        }
        
        instance.task.state = "rescued";
        instance.hostage notify( #"play_dialog" );
        instance.task.bombexploded = 0;
        instance.task notify( #"bomb_defused" );
        
        if ( isdefined( instance.task.shownplayers ) )
        {
            foreach ( shownplayer in instance.task.shownplayers )
            {
                objidpoolmanager::function_6ac40386d1cd0d9a( instance.task.icon, shownplayer );
                objidpoolmanager::objective_unpin_player( instance.task.icon, player );
            }
        }
        
        objidpoolmanager::function_daf59ee8ea2cb071( instance.task.icon );
        instance.task function_915debdf87f515ac( player, bomb );
        
        if ( isdefined( task.c4 ) )
        {
            task.c4 delete();
        }
        
        if ( task.failure )
        {
            return;
        }
        
        player playsound( "mp_dmz_hostage_unzip" );
        instance.task.dropposition = instance.position;
        instance setscriptablepartstate( "dmz_hostage", "remaining" );
        
        foreach ( guy in level.players )
        {
            instance disablescriptableplayeruse( guy );
        }
        
        teammates = teams::getteamdata( instance.task.teams[ 0 ], "players" );
        
        foreach ( teammate in teammates )
        {
            instance enablescriptableplayeruse( teammate );
        }
        
        objidpoolmanager::update_objective_position( instance.task.icon, instance.task.hostage.origin + ( 0, 0, 30 ) );
        instance.task.questcircles[ 0 ] game_utility::questcircle_hidefromall();
        instance.task.questcircles[ 0 ] game_utility::questcircle_move( instance.task.helinode.origin );
        instance.task dmz_task_utils::task_showsplashtoteam( "dmz_hostage_success", instance.task.teams[ 0 ] );
        utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"hostage_rescue_win", instance.task.teams[ 0 ], 2 );
        instance.task thread function_442607e8d0062d3b();
        dmz_audio::function_32ff837bc21a4833( instance.task.teams[ 0 ], "dmz_hostage_rescue", 1, "dmz_hostage_rescue_classic" );
        return;
    }
    
    if ( state == "remaining" && isdefined( instance.hostage ) )
    {
        instance setscriptablepartstate( "dmz_hostage", "unusable" );
        instance.task pickuphostage( player, instance.hostage );
        return;
    }
    
    if ( state == "following" && isdefined( instance.hostage ) )
    {
        instance.task drophostage();
    }
}

#using_animtree( "script_model" );

// Namespace namespace_87e5a35991b973ad
// Params 0
// Checksum 0x8e0971bb, Offset: 0x30cf
// Size: 0x7f8
function initanims()
{
    level.scr_animtree[ "player_pickup_hostage" ] = #animtree;
    level.scr_anim[ "player_pickup_hostage" ][ "pickup_front_crouch" ] = %iw9_mp_hostage_pickup_crouch_8;
    level.scr_eventanim[ "player_pickup_hostage" ][ "pickup_front_crouch" ] = %"pickup_front_crouch";
    level.scr_anim[ "player_pickup_hostage" ][ "pickup_front_stand" ] = %iw9_mp_hostage_pickup_stand_8;
    level.scr_eventanim[ "player_pickup_hostage" ][ "pickup_front_stand" ] = %"pickup_front_stand";
    level.scr_anim[ "player_pickup_hostage" ][ "pickup_back_crouch" ] = %iw9_mp_hostage_pickup_crouch_2;
    level.scr_eventanim[ "player_pickup_hostage" ][ "pickup_back_crouch" ] = %"pickup_back_crouch";
    level.scr_anim[ "player_pickup_hostage" ][ "pickup_back_stand" ] = %iw9_mp_hostage_pickup_stand_2;
    level.scr_eventanim[ "player_pickup_hostage" ][ "pickup_back_stand" ] = %"pickup_back_stand";
    level.scr_anim[ "player_pickup_hostage" ][ "pickup_right_crouch" ] = %iw9_mp_hostage_pickup_crouch_6;
    level.scr_eventanim[ "player_pickup_hostage" ][ "pickup_right_crouch" ] = %"pickup_right_crouch";
    level.scr_anim[ "player_pickup_hostage" ][ "pickup_right_stand" ] = %iw9_mp_hostage_pickup_stand_6;
    level.scr_eventanim[ "player_pickup_hostage" ][ "pickup_right_stand" ] = %"pickup_right_stand";
    level.scr_anim[ "player_pickup_hostage" ][ "pickup_left_crouch" ] = %iw9_mp_hostage_pickup_crouch_4;
    level.scr_eventanim[ "player_pickup_hostage" ][ "pickup_left_crouch" ] = %"pickup_left_crouch";
    level.scr_anim[ "player_pickup_hostage" ][ "pickup_left_stand" ] = %iw9_mp_hostage_pickup_stand_4;
    level.scr_eventanim[ "player_pickup_hostage" ][ "pickup_left_stand" ] = %"pickup_left_stand";
    level.scr_anim[ "player_pickup_hostage" ][ "pickup_front_crouch_vm" ] = %iw9_mp_hostage_vm_pickup_crouch_8;
    level.scr_eventanim[ "player_pickup_hostage" ][ "pickup_front_crouch_vm" ] = %"pickup_front_crouch_vm";
    level.scr_anim[ "player_pickup_hostage" ][ "pickup_front_stand_vm" ] = %iw9_mp_hostage_vm_pickup_stand_8;
    level.scr_eventanim[ "player_pickup_hostage" ][ "pickup_front_stand_vm" ] = %"pickup_front_stand_vm";
    level.scr_anim[ "player_pickup_hostage" ][ "pickup_back_crouch_vm" ] = %iw9_mp_hostage_vm_pickup_crouch_2;
    level.scr_eventanim[ "player_pickup_hostage" ][ "pickup_back_crouch_vm" ] = %"pickup_back_crouch_vm";
    level.scr_anim[ "player_pickup_hostage" ][ "pickup_back_stand_vm" ] = %iw9_mp_hostage_vm_pickup_stand_2;
    level.scr_eventanim[ "player_pickup_hostage" ][ "pickup_back_stand_vm" ] = %"pickup_back_stand_vm";
    level.scr_anim[ "player_pickup_hostage" ][ "pickup_right_crouch_vm" ] = %iw9_mp_hostage_vm_pickup_crouch_6;
    level.scr_eventanim[ "player_pickup_hostage" ][ "pickup_right_crouch_vm" ] = %"pickup_right_crouch_vm";
    level.scr_anim[ "player_pickup_hostage" ][ "pickup_right_stand_vm" ] = %iw9_mp_hostage_vm_pickup_stand_6;
    level.scr_eventanim[ "player_pickup_hostage" ][ "pickup_right_stand_vm" ] = %"pickup_right_stand_vm";
    level.scr_anim[ "player_pickup_hostage" ][ "pickup_left_crouch_vm" ] = %iw9_mp_hostage_vm_pickup_crouch_4;
    level.scr_eventanim[ "player_pickup_hostage" ][ "pickup_left_crouch_vm" ] = %"pickup_left_crouch_vm";
    level.scr_anim[ "player_pickup_hostage" ][ "pickup_left_stand_vm" ] = %iw9_mp_hostage_vm_pickup_stand_4;
    level.scr_eventanim[ "player_pickup_hostage" ][ "pickup_left_stand_vm" ] = %"pickup_left_stand_vm";
    level.scr_animtree[ "hostage_pickup" ] = #animtree;
    level.scr_anim[ "hostage_pickup" ][ "pickup_front_crouch" ] = %iw9_mp_hostage_pickedup_crouch_8;
    level.scr_eventanim[ "hostage_pickup" ][ "pickup_front_crouch" ] = %"hostage_pickup_front_crouch";
    level.scr_anim[ "hostage_pickup" ][ "pickup_front_stand" ] = %iw9_mp_hostage_pickedup_stand_8;
    level.scr_eventanim[ "hostage_pickup" ][ "pickup_front_stand" ] = %"hostage_pickup_front_stand";
    level.scr_anim[ "hostage_pickup" ][ "pickup_back_crouch" ] = %iw9_mp_hostage_pickedup_crouch_2;
    level.scr_eventanim[ "hostage_pickup" ][ "pickup_back_crouch" ] = %"hostage_pickup_back_crouch";
    level.scr_anim[ "hostage_pickup" ][ "pickup_back_stand" ] = %iw9_mp_hostage_pickedup_stand_2;
    level.scr_eventanim[ "hostage_pickup" ][ "pickup_back_stand" ] = %"hostage_pickup_back_stand";
    level.scr_anim[ "hostage_pickup" ][ "pickup_right_crouch" ] = %iw9_mp_hostage_pickedup_crouch_6;
    level.scr_eventanim[ "hostage_pickup" ][ "pickup_right_crouch" ] = %"hostage_pickup_right_crouch";
    level.scr_anim[ "hostage_pickup" ][ "pickup_right_stand" ] = %iw9_mp_hostage_pickedup_stand_6;
    level.scr_eventanim[ "hostage_pickup" ][ "pickup_right_stand" ] = %"hostage_pickup_right_stand";
    level.scr_anim[ "hostage_pickup" ][ "pickup_left_crouch" ] = %iw9_mp_hostage_pickedup_crouch_4;
    level.scr_eventanim[ "hostage_pickup" ][ "pickup_left_crouch" ] = %"hostage_pickup_left_crouch";
    level.scr_anim[ "hostage_pickup" ][ "pickup_left_stand" ] = %iw9_mp_hostage_pickedup_stand_4;
    level.scr_eventanim[ "hostage_pickup" ][ "pickup_left_stand" ] = %"hostage_pickup_left_stand";
    level.scr_animtree[ "hostage_pickup_sm" ] = #animtree;
    level.scr_anim[ "hostage_pickup_sm" ][ "pickup_front_crouch_vm" ] = %iw9_mp_hostage_vm_pickedup_crouch_8;
    level.scr_eventanim[ "hostage_pickup_sm" ][ "pickup_front_crouch_vm" ] = %"hostage_pickup_front_crouch_vm";
    level.scr_anim[ "hostage_pickup_sm" ][ "pickup_front_stand_vm" ] = %iw9_mp_hostage_vm_pickedup_stand_8;
    level.scr_eventanim[ "hostage_pickup_sm" ][ "pickup_front_stand_vm" ] = %"hostage_pickup_front_stand_vm";
    level.scr_anim[ "hostage_pickup_sm" ][ "pickup_back_crouch_vm" ] = %iw9_mp_hostage_vm_pickedup_crouch_2;
    level.scr_eventanim[ "hostage_pickup_sm" ][ "pickup_back_crouch_vm" ] = %"hostage_pickup_back_crouch_vm";
    level.scr_anim[ "hostage_pickup_sm" ][ "pickup_back_stand_vm" ] = %iw9_mp_hostage_vm_pickedup_stand_2;
    level.scr_eventanim[ "hostage_pickup_sm" ][ "pickup_back_stand_vm" ] = %"hostage_pickup_back_stand_vm";
    level.scr_anim[ "hostage_pickup_sm" ][ "pickup_right_crouch_vm" ] = %iw9_mp_hostage_vm_pickedup_crouch_6;
    level.scr_eventanim[ "hostage_pickup_sm" ][ "pickup_right_crouch_vm" ] = %"hostage_pickup_right_crouch_vm";
    level.scr_anim[ "hostage_pickup_sm" ][ "pickup_right_stand_vm" ] = %iw9_mp_hostage_vm_pickedup_stand_6;
    level.scr_eventanim[ "hostage_pickup_sm" ][ "pickup_right_stand_vm" ] = %"hostage_pickup_right_stand_vm";
    level.scr_anim[ "hostage_pickup_sm" ][ "pickup_left_crouch_vm" ] = %iw9_mp_hostage_vm_pickedup_crouch_4;
    level.scr_eventanim[ "hostage_pickup_sm" ][ "pickup_left_crouch_vm" ] = %"hostage_pickup_left_crouch_vm";
    level.scr_anim[ "hostage_pickup_sm" ][ "pickup_left_stand_vm" ] = %iw9_mp_hostage_vm_pickedup_stand_4;
    level.scr_eventanim[ "hostage_pickup_sm" ][ "pickup_left_stand_vm" ] = %"hostage_pickup_left_stand_vm";
}

// Namespace namespace_87e5a35991b973ad
// Params 2
// Checksum 0xc60a3206, Offset: 0x38cf
// Size: 0x2ba
function pickuphostage( player, hostage )
{
    player endon( #"death_or_disconnect" );
    player endon( #"enter_live_ragdoll" );
    player endon( #"last_stand_enter" );
    level endon( #"game_ended" );
    self.hostage endon( #"death" );
    self endon( #"task_ended" );
    
    if ( !self.completed )
    {
        self.carryingplayer = player;
        thread function_5792ee7eb78e6fe2( player );
        player.carryinghostage = 1;
        hostage unlink();
        self.instance scriptableclearparententity();
        hostage function_175cde2852ec54e6( player );
        player notify( #"hostage_pickup_finished" );
    }
    
    if ( !self.completed )
    {
        hostage hide();
        hostage.origin += ( 0, 0, 100000 );
        hostage.invulnerable = 1;
        self.carryingplayer setcarryobject( function_ba0b4afc35e922ac( hostage.model ) );
        function_955ade66b8e7de35( self.carryingplayer );
        
        if ( !self.skipcontract )
        {
            players = teams::getteamdata( self.teams[ 0 ], "players" );
            
            foreach ( teammate in players )
            {
                self.questcircles[ 0 ] game_utility::questcircle_showtoplayer( teammate );
            }
            
            objidpoolmanager::update_objective_position( self.icon, self.helinode.origin );
        }
        
        self.instance setscriptablepartstate( "dmz_hostage", "following" );
        
        foreach ( otherplayer in level.players )
        {
            self.instance disablescriptableplayeruse( otherplayer );
        }
        
        self.instance enablescriptableplayeruse( self.carryingplayer );
        thread function_55bb69dad8ef89cc();
    }
}

// Namespace namespace_87e5a35991b973ad
// Params 1
// Checksum 0xa1f79df8, Offset: 0x3b91
// Size: 0x6b
function function_ba0b4afc35e922ac( model )
{
    if ( !isdefined( model ) )
    {
        return "hostage_rescue";
    }
    
    switch ( model )
    {
        case #"hash_e1b1040264d1aa90":
            return "hostage_civ_male_3_1";
        case #"hash_7c27bd492fe216bd":
            return "hostage_civ_male_3_2";
        case #"hash_2dc1b9fc9dd2ecc6":
            return "hostage_civ_male_3_3";
        default:
            return "hostage_rescue";
    }
}

// Namespace namespace_87e5a35991b973ad
// Params 5
// Checksum 0x1cb56cc6, Offset: 0x3c04
// Size: 0x163
function function_e4f8725d97b86233( animname, spawnpos, spawnang, bodymodel, headmodel )
{
    self.animname = animname;
    
    if ( !isdefined( spawnpos ) )
    {
        spawnpos = ( 0, 0, 0 );
    }
    
    if ( !isdefined( spawnang ) )
    {
        spawnang = ( 0, 0, 0 );
    }
    
    var_d9ba43512ce0b0aa = spawn( "script_model", spawnpos );
    var_d9ba43512ce0b0aa.angles = spawnang;
    var_d9ba43512ce0b0aa setmodel( bodymodel );
    var_d9ba43512ce0b0aa notsolid();
    self.var_d9ba43512ce0b0aa = var_d9ba43512ce0b0aa;
    self.var_d9ba43512ce0b0aa.animname = animname;
    self.var_d9ba43512ce0b0aa useanimtree( #animtree );
    self.var_d9ba43512ce0b0aa.updatedversion = 1;
    head = spawn( "script_model", spawnpos );
    head setmodel( headmodel );
    head notsolid();
    self.var_d9ba43512ce0b0aa.head = head;
    self notify( #"rig_created" );
    utility::waittill_any( "remove_rig", "player_free_spot" );
    
    if ( level.gameended )
    {
        return;
    }
    
    if ( isdefined( head ) )
    {
        head unlink();
        head delete();
    }
    
    if ( isdefined( var_d9ba43512ce0b0aa ) )
    {
        var_d9ba43512ce0b0aa delete();
    }
}

// Namespace namespace_87e5a35991b973ad
// Params 3
// Checksum 0x675b1f82, Offset: 0x3d6f
// Size: 0x13a
function create_player_rig_third( animname, spawnpos, spawnang )
{
    self.animname = animname;
    
    if ( !isdefined( spawnpos ) )
    {
        spawnpos = ( 0, 0, 0 );
    }
    
    if ( !isdefined( spawnang ) )
    {
        spawnang = ( 0, 0, 0 );
    }
    
    if ( isplayer( self ) )
    {
        self function_e19ccf4da1a61ba7( spawnpos );
    }
    
    player_rig_third = spawn( "script_arms", spawnpos, 0, 0, self );
    player_rig_third.angles = spawnang;
    player_rig_third.player = self;
    self.player_rig_third = player_rig_third;
    self.player_rig_third.animname = animname;
    self.player_rig_third useanimtree( #animtree );
    self.player_rig_third.updatedversion = 1;
    self playerlinktoabsolute( self.player_rig_third, "tag_player" );
    self notify( #"rig_created" );
    utility::waittill_any( "remove_rig", "player_free_spot" );
    
    if ( level.gameended )
    {
        return;
    }
    
    if ( isdefined( self ) )
    {
        self unlink();
        thread inventory_utility::takegunlessweapon();
    }
    
    if ( isdefined( player_rig_third ) )
    {
        player_rig_third delete();
    }
}

// Namespace namespace_87e5a35991b973ad
// Params 3
// Checksum 0x675b1f82, Offset: 0x3eb1
// Size: 0x13a
function create_player_rig_first( animname, spawnpos, spawnang )
{
    self.animname = animname;
    
    if ( !isdefined( spawnpos ) )
    {
        spawnpos = ( 0, 0, 0 );
    }
    
    if ( !isdefined( spawnang ) )
    {
        spawnang = ( 0, 0, 0 );
    }
    
    if ( isplayer( self ) )
    {
        self function_e19ccf4da1a61ba7( spawnpos );
    }
    
    player_rig_first = spawn( "script_arms", spawnpos, 0, 0, self );
    player_rig_first.angles = spawnang;
    player_rig_first.player = self;
    self.player_rig_first = player_rig_first;
    self.player_rig_first.animname = animname;
    self.player_rig_first useanimtree( #animtree );
    self.player_rig_first.updatedversion = 1;
    self playerlinktoabsolute( self.player_rig_first, "tag_player" );
    self notify( #"rig_created" );
    utility::waittill_any( "remove_rig", "player_free_spot" );
    
    if ( level.gameended )
    {
        return;
    }
    
    if ( isdefined( self ) )
    {
        self unlink();
        thread inventory_utility::takegunlessweapon();
    }
    
    if ( isdefined( player_rig_first ) )
    {
        player_rig_first delete();
    }
}

// Namespace namespace_87e5a35991b973ad
// Params 1
// Checksum 0x5d3ee92f, Offset: 0x3ff3
// Size: 0x83c
function function_175cde2852ec54e6( player )
{
    self.var_272223053fde7 = 1;
    player val::set( "carry", "vehicle_use", 0 );
    player val::set( "carry", "melee", 0 );
    player val::set( "carry", "weapon_switch", 0 );
    player val::set( "carry", "sprint", 0 );
    player val::set( "carry", "fire", 0 );
    player val::set( "carry", "reload", 0 );
    player val::set( "carry", "weapon_pickup", 0 );
    player val::set( "carry", "weapon_switch", 0 );
    player val::set( "carry", "allow_jump", 0 );
    player val::set( "carry", "gesture", 0 );
    player function_60e112d2e106b00a();
    player val::set( "move_disable", "allow_movement", 0 );
    
    if ( player.insertingarmorplate )
    {
        player notify( #"try_armor_cancel" );
        
        while ( isdefined( player.currentweapon ) && player.currentweapon.basename == "iw9_armor_plate_deploy_mp" )
        {
            waitframe();
        }
        
        waitframe();
    }
    
    stance = player getstance();
    
    if ( stance == "prone" )
    {
        player setstance( "crouch", 1, 1 );
        stance = "crouch";
    }
    
    player.switchweapon = player getcurrentweapon();
    fists = makeweapon( "iw9_gunless_mp" );
    player giveweapon( fists );
    player.var_1141aebc55cd55aa = fists;
    result = player inventory_utility::domonitoredweaponswitch( fists, 1, 1 );
    
    if ( !result )
    {
        player inventory_utility::domonitoredweaponswitch( fists, 1, 1 );
    }
    
    player val::reset_all( "move_disable" );
    tmporigin = ( self.origin[ 0 ], self.origin[ 1 ], player.origin[ 2 ] );
    directionvector = vectornormalize( player.origin - tmporigin );
    var_bc3404c69133b0b7 = vectordot( directionvector, anglestoforward( self.angles ) );
    var_bc6014c691643a4d = vectordot( directionvector, anglestoright( self.angles ) );
    self.origin = player.origin + anglestoforward( player.angles ) * 34.672;
    self.animstance = stance;
    self.animdir = undefined;
    anime = "pickup_back_stand";
    vmanime = "pickup_back_stand_vm";
    var_a21dce04dcaeb0eb = undefined;
    
    if ( var_bc3404c69133b0b7 >= 0.707 )
    {
        self.animdir = "front";
        anime = "pickup_front_" + stance;
        vmanime = "pickup_front_" + stance + "_vm";
        directiontoplayer = vectornormalize( player.origin - self.origin );
        var_a21dce04dcaeb0eb = script::vectortoanglessafe( directiontoplayer, anglestoup( self.angles ) );
        self.angles = var_a21dce04dcaeb0eb;
    }
    else if ( var_bc3404c69133b0b7 <= -0.707 )
    {
        self.animdir = "back";
        anime = "pickup_back_" + stance;
        vmanime = "pickup_back_" + stance + "_vm";
        var_23391d7249fd3 = vectornormalize( self.origin - player.origin );
        var_a21dce04dcaeb0eb = script::vectortoanglessafe( var_23391d7249fd3, anglestoup( self.angles ) );
        self.angles = var_a21dce04dcaeb0eb;
    }
    else if ( var_bc6014c691643a4d >= 0.707 )
    {
        self.animdir = "right";
        anime = "pickup_right_" + stance;
        vmanime = "pickup_right_" + stance + "_vm";
        var_23391d7249fd3 = vectorcross( vectornormalize( self.origin - player.origin ), anglestoup( self.angles ) );
        var_a21dce04dcaeb0eb = script::vectortoanglessafe( var_23391d7249fd3, anglestoup( self.angles ) );
        self.angles = var_a21dce04dcaeb0eb;
    }
    else if ( var_bc6014c691643a4d <= -0.707 )
    {
        self.animdir = "left";
        anime = "pickup_left_" + stance;
        vmanime = "pickup_left_" + stance + "_vm";
        directiontoplayer = vectorcross( vectornormalize( player.origin - self.origin ), anglestoup( self.angles ) );
        var_a21dce04dcaeb0eb = script::vectortoanglessafe( directiontoplayer, anglestoup( self.angles ) );
        self.angles = var_a21dce04dcaeb0eb;
    }
    
    if ( isdefined( var_a21dce04dcaeb0eb ) )
    {
        self orientmode( "face angle 3d", var_a21dce04dcaeb0eb );
    }
    
    player thread create_player_rig_third( "player_pickup_hostage", player.origin, player.angles );
    player.player_rig_third hide();
    player thread create_player_rig_first( "player_pickup_hostage", player.origin, player.angles );
    
    if ( player getcamerathirdperson() )
    {
        player.player_rig_first hide();
    }
    else
    {
        player.player_rig_first showonlytoplayer( player );
    }
    
    vmrig = spawnstruct();
    vmrig thread function_e4f8725d97b86233( "hostage_pickup_sm", self.origin, self.angles, self.model, self.headmodel );
    vmrig.var_d9ba43512ce0b0aa hide();
    vmrig.var_d9ba43512ce0b0aa showonlytoplayer( player );
    
    if ( isdefined( vmrig.var_d9ba43512ce0b0aa.head ) )
    {
        vmrig.var_d9ba43512ce0b0aa.head hide();
        vmrig.var_d9ba43512ce0b0aa.head showonlytoplayer( player );
        vmrig.var_d9ba43512ce0b0aa.head linkto( vmrig.var_d9ba43512ce0b0aa, "j_neck", ( -9, 1, 0 ), ( 0, 0, 0 ) );
    }
    
    self.vmrig = vmrig;
    player.hostagerig = vmrig;
    self hidefromplayer( player );
    self.animname = "hostage_pickup";
    self useanimtree( level.scr_animtree[ "hostage_pickup" ] );
    self._blackboard.bseqphase = "getting_picked_up";
    animstruct = spawnstruct();
    animstruct.origin = player.origin;
    animstruct.angles = player.angles;
    tempmovingplatform = player getmovingplatformparent();
    
    if ( isdefined( tempmovingplatform ) && killstreak_utility::function_1b5a5947da36bea( tempmovingplatform ) )
    {
        vmrig.var_d9ba43512ce0b0aa linkto( tempmovingplatform );
        player.player_rig_first linkto( tempmovingplatform );
        player playerlinkedoffsetenable();
    }
    
    animstruct thread anim_mp::anim_player_solo( player, player.player_rig_third, anime );
    animstruct thread animation::anim_single_solo( player.player_rig_first, vmanime );
    vmrig.var_d9ba43512ce0b0aa thread animation::anim_single_solo( vmrig.var_d9ba43512ce0b0aa, vmanime );
    wait getanimlength( level.scr_anim[ "player_pickup_hostage" ][ vmanime ] );
    tempmovingplatform = player getmovingplatformparent();
    
    if ( isdefined( tempmovingplatform ) && killstreak_utility::function_1b5a5947da36bea( tempmovingplatform ) )
    {
        vmrig.var_d9ba43512ce0b0aa unlink();
        player.player_rig_first unlink();
        player playerlinkedoffsetdisable();
    }
    
    player notify( #"remove_rig" );
    vmrig notify( #"remove_rig" );
    player.var_1141aebc55cd55aa = undefined;
    player.hostagerig = undefined;
    player takeweapon( fists );
    rescue::function_9ea322aa54e2016c( player );
    self.var_272223053fde7 = undefined;
}

// Namespace namespace_87e5a35991b973ad
// Params 1
// Checksum 0x69592e1f, Offset: 0x4837
// Size: 0xd6
function function_dc6bd8f197afb272( player )
{
    player endon( #"death_or_disconnect" );
    player endon( #"enter_live_ragdoll" );
    function_1c41a3669d6ae91( player );
    gunless = makeweapon( "iw9_gunless_mp" );
    player giveweapon( gunless );
    player inventory_utility::domonitoredweaponswitch( gunless );
    
    if ( isdefined( player.givenweapon ) )
    {
        player takeweapon( player.givenweapon );
        player.givenweapon = undefined;
        player inventory_utility::domonitoredweaponswitch( player.switchweapon );
    }
    else
    {
        player inventory_utility::domonitoredweaponswitch( player.switchweapon );
    }
    
    if ( isdefined( player.switchweapon ) )
    {
        player.switchweapon = undefined;
    }
    
    player takeweapon( gunless );
    player resetcarryobject();
}

// Namespace namespace_87e5a35991b973ad
// Params 1
// Checksum 0xde87344d, Offset: 0x4915
// Size: 0x7c8
function drophostage( forcedrop )
{
    droporigin = undefined;
    dropangles = undefined;
    dropstance = undefined;
    
    if ( !( isdefined( self.carryingplayer ) && isdefined( self.carryingplayer.origin ) && isdefined( self.carryingplayer.angles ) ) )
    {
        droporigin = self.carryorigin;
        dropangles = self.carryangles;
        dropstance = self.carrystance;
    }
    else
    {
        droporigin = self.carryingplayer.origin;
        dropangles = self.carryingplayer.angles;
        dropstance = self.carryingplayer getstance();
    }
    
    var_c6109a2bba6f37fd = undefined;
    var_a9081ea1cca27050 = undefined;
    watercontents = physics_createcontents( [ "physicscontents_water" ] );
    castresult = physics_getclosestpointtosphere( droporigin, 16, 0, watercontents, [], "physicsquery_any" );
    
    if ( castresult )
    {
        var_c6109a2bba6f37fd = 1;
    }
    
    contents = physics_createcontents( [ "physicscontents_playerclip", "physicscontents_glass" ] );
    caststart = droporigin;
    castdir = ( 0, 0, -1 );
    castdist = 60;
    castend = caststart + castdir * castdist;
    ignorelist = [ self.hostage, self.carryingplayer ];
    castresult = physics_capsulecast( caststart + ( 0, 0, 24 ), castend, 4, 40, ( 0, 0, 90 ), contents, ignorelist, "physicsquery_closest" );
    
    if ( !isdefined( castresult ) || castresult.size <= 0 )
    {
        function_3152ebeb45cce47a( forcedrop );
        return;
    }
    
    hitent = castresult[ 0 ][ "entity" ];
    
    if ( isdefined( hitent ) && hitent.var_c3fd56dc418429f )
    {
        var_a9081ea1cca27050 = 1;
    }
    
    if ( isdefined( hitent ) && !function_f705c7516e342867( hitent, droporigin ) || var_c6109a2bba6f37fd && !var_a9081ea1cca27050 )
    {
        function_3152ebeb45cce47a( forcedrop );
        return;
    }
    
    var_59f28bc546c68ddc = function_1fdf128eeb720cb( hitent );
    
    if ( !isdefined( var_59f28bc546c68ddc ) && elevator::is_moving_platform_elevator( self.carryingplayer getmovingplatformparent() ) )
    {
        var_59f28bc546c68ddc = self.carryingplayer getmovingplatformparent();
    }
    
    if ( isdefined( var_59f28bc546c68ddc ) )
    {
        self.hostage.origin = droporigin;
        self.hostage.angles = dropangles;
        self.hostage.animstance = dropstance;
        localoffset = coordtransformtranspose( droporigin, var_59f28bc546c68ddc.origin, var_59f28bc546c68ddc.angles );
        localangles = combineanglesinverted( dropangles, var_59f28bc546c68ddc.angles );
        
        if ( !isdefined( self.hostageent ) )
        {
            self.hostageent = spawn( "script_origin", droporigin );
        }
        
        self.hostageent.origin = droporigin;
        ismovingplatform = killstreak_utility::function_947e7b15331fd6e3( var_59f28bc546c68ddc );
        
        if ( ismovingplatform )
        {
            self.hostageent linkto( var_59f28bc546c68ddc );
        }
        else
        {
            self.hostageent linkto( var_59f28bc546c68ddc, "tag_origin", localoffset, localangles );
        }
        
        self.hostage linkto( self.hostageent );
        thread watchformovingentdeath( var_59f28bc546c68ddc );
    }
    else
    {
        self.hostage.origin = droporigin;
        self.hostage.angles = dropangles;
        self.hostage.animstance = dropstance;
    }
    
    self.hostage show();
    self.hostage.invulnerable = 0;
    function_8f0393098cddc44d( self.carryingplayer );
    animlength = undefined;
    
    if ( isdefined( self.hostage ) && self.hostage.var_272223053fde7 || !isdefined( self.carryingplayer ) )
    {
        self.var_272223053fde7 = undefined;
        
        if ( isdefined( self.carryingplayer ) && isdefined( self.carryingplayer.var_1141aebc55cd55aa ) )
        {
            self.carryingplayer takeweapon( self.carryingplayer.var_1141aebc55cd55aa );
        }
        
        waitframe();
    }
    
    self.hostage._blackboard.bseqphase = "getting_dropped";
    animlength = getanimlength( %iw9_mp_hostage_dropped_stand );
    
    if ( !self.failure )
    {
        self.instance setscriptablepartstate( "dmz_hostage", "unusable" );
    }
    
    if ( isdefined( animlength ) )
    {
        wait animlength;
    }
    
    if ( !self.failure )
    {
        self.instance setscriptablepartstate( "dmz_hostage", "remaining" );
        
        if ( self.skipcontract )
        {
            foreach ( player in level.players )
            {
                self.instance enablescriptableplayeruse( player );
            }
        }
        else
        {
            foreach ( player in level.players )
            {
                self.instance disablescriptableplayeruse( player );
            }
            
            teammates = teams::getteamdata( self.teams[ 0 ], "players" );
            
            foreach ( teammate in teammates )
            {
                self.instance enablescriptableplayeruse( teammate );
            }
        }
        
        self.hostage._blackboard.bseqphase = "dropped";
        self.instance.origin = self.hostage.origin;
        self.instance scriptablesetparententity( self.hostage, ( 0, 0, 15 ), ( 0, 0, 0 ) );
        
        if ( !self.skipcontract )
        {
            objidpoolmanager::update_objective_setzoffset( self.icon, 30 );
            objidpoolmanager::update_objective_onentity( self.icon, self.hostage );
            self.questcircles[ 0 ] game_utility::questcircle_hidefromall();
        }
        
        self.carryingplayer = undefined;
        
        if ( isent( var_59f28bc546c68ddc ) && var_59f28bc546c68ddc vehicle::is_vehicle() && var_59f28bc546c68ddc vehicle::get_ref() == %"hash_1dd941f8f4026e3" )
        {
            function_91f82f9795e46875( var_59f28bc546c68ddc );
        }
    }
}

// Namespace namespace_87e5a35991b973ad
// Params 0
// Checksum 0x3c2a7ce8, Offset: 0x50e5
// Size: 0x90
function function_f5c34e060eb3f73f()
{
    self.carryingplayer endon( #"hostage_pickup_finished" );
    thread function_5fe54d480e1ae093();
    
    while ( true )
    {
        self.instance.origin = self.hostage.origin;
        
        if ( !self.skipcontract )
        {
            objidpoolmanager::update_objective_position( self.objidnum, self.hostage.origin + ( 0, 0, 30 ) );
        }
        
        wait 0.05;
    }
}

// Namespace namespace_87e5a35991b973ad
// Params 0
// Checksum 0xcff462db, Offset: 0x517d
// Size: 0x3f
function function_5fe54d480e1ae093()
{
    level endon( #"disconnect" );
    self.carryingplayer waittill( #"hostage_pickup_finished" );
    self.hostageent unlink();
    self.hostage unlink();
}

// Namespace namespace_87e5a35991b973ad
// Params 1
// Checksum 0xe8cec29a, Offset: 0x51c4
// Size: 0x6a
function function_3152ebeb45cce47a( forcedrop )
{
    if ( forcedrop )
    {
        self.hostage show();
        self.hostage.invulnerable = 0;
        function_8f0393098cddc44d( self.carryingplayer );
        self.hostage kill();
        return;
    }
    
    self.carryingplayer hud_message::showerrormessage( "MP_DMZ_MISSIONS/HOSTAGE_PLACE_ERR" );
}

// Namespace namespace_87e5a35991b973ad
// Params 1
// Checksum 0x54af239, Offset: 0x5236
// Size: 0x16f
function function_8f0393098cddc44d( player )
{
    if ( player::isreallyalive( player ) && !player::isinlaststand( player ) )
    {
        player.playerstreakspeedscale = 0;
        
        if ( player common::function_8ff835bf23198a0( "playerStreakSpeedScale" ) )
        {
            player common::function_d85a92c557ea5a52( "playerStreakSpeedScale" );
            player common::function_65276d8c156b2ec9( 2 );
        }
        
        player setmovespeedscale( 1 );
        thread rescue::function_dc6bd8f197afb272( player );
        player skydive_setdeploymentstatus( 1 );
        player skydive_setbasejumpingstatus( 1 );
    }
    else
    {
        function_1c41a3669d6ae91( player );
        
        if ( isdefined( player.givenweapon ) )
        {
            player takeweapon( player.givenweapon );
            player.givenweapon = undefined;
        }
        
        if ( isdefined( player.switchweapon ) )
        {
            if ( player::isinlaststand( player ) )
            {
                player.laststandoldweaponobj = player.switchweapon;
            }
            
            player.switchweapon = undefined;
        }
        
        player resetcarryobject();
    }
    
    player.carryinghostage = 0;
    player stopanimscriptsceneevent();
    player notify( #"remove_rig" );
    
    if ( isdefined( self.hostage ) && isdefined( self.hostage.vmrig ) )
    {
        self.hostage.vmrig notify( #"remove_rig" );
    }
    
    if ( isdefined( player ) )
    {
        player notify( #"drop_hostage" );
    }
}

// Namespace namespace_87e5a35991b973ad
// Params 2
// Checksum 0xaf86032c, Offset: 0x53ad
// Size: 0x170, Type: bool
function function_f705c7516e342867( ent, origin )
{
    if ( isplayer( ent ) )
    {
        return false;
    }
    
    if ( ent getnonstick() )
    {
        return false;
    }
    
    if ( ent.mountmantlemodel )
    {
        return false;
    }
    
    if ( isdefined( ent.cover ) && ent.cover.equipmentref == "equip_tac_cover" )
    {
        return false;
    }
    
    if ( ent.classname == "misc_turret" )
    {
        return false;
    }
    
    if ( ent.classname == "script_vehicle" )
    {
        if ( isdefined( ent vehicle::get_ref() ) && ent vehicle::get_ref() == %"hash_3886456ee4e8c04a" )
        {
            return false;
        }
        
        if ( ent vehicle_occupancy::function_63c6c86801e0685c() )
        {
            foreach ( point in [ origin, origin + ( 0, 0, -10 ), origin + ( 0, 0, -20 ) ] )
            {
                if ( ent vehicle_occupancy::function_6b3a6137e14e34e2( point ) )
                {
                    return true;
                }
            }
            
            return false;
        }
        
        return true;
    }
    
    return true;
}

// Namespace namespace_87e5a35991b973ad
// Params 1
// Checksum 0x8a808e54, Offset: 0x5526
// Size: 0x2e
function function_1fdf128eeb720cb( hitent )
{
    if ( isdefined( hitent ) )
    {
        if ( killstreak_utility::function_947e7b15331fd6e3( hitent ) || hitent vehicle::is_vehicle() )
        {
            return hitent;
        }
        
        return 0;
    }
}

// Namespace namespace_87e5a35991b973ad
// Params 0
// Checksum 0x2023c4e9, Offset: 0x555d
// Size: 0x1f8
function function_55bb69dad8ef89cc()
{
    self.carryingplayer endon( #"drop_hostage" );
    
    while ( true )
    {
        if ( !isdefined( self.instance ) )
        {
            return;
        }
        
        if ( !isdefined( self.carryingplayer ) )
        {
            return;
        }
        
        start = self.carryingplayer geteye();
        ignore = [ self.carryingplayer ];
        
        if ( isdefined( self.heli ) )
        {
            ignore[ ignore.size ] = self.heli;
        }
        
        passed = trace::sphere_trace_passed( start, start + ( 0, 0, -25 ), 25, ignore );
        
        if ( self.carryingplayer isonground() && passed )
        {
            state = self.instance getscriptablepartstate( "dmz_hostage" );
            
            if ( isdefined( state ) && state != "following" )
            {
                self.instance setscriptablepartstate( "dmz_hostage", "following" );
                
                foreach ( player in level.players )
                {
                    self.instance disablescriptableplayeruse( player );
                }
                
                self.instance enablescriptableplayeruse( self.carryingplayer );
            }
            
            forward = 5 * anglestoforward( self.carryingplayer getplayerangles() );
            self.instance.origin = start + forward * 0.1;
        }
        else
        {
            self.instance setscriptablepartstate( "dmz_hostage", "unusable" );
        }
        
        waitframe();
    }
}

// Namespace namespace_87e5a35991b973ad
// Params 1
// Checksum 0x72ec0272, Offset: 0x575d
// Size: 0x8b
function function_7d949fe0e3b08e65( player )
{
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    player endon( #"enter_live_ragdoll" );
    player endon( #"drop_hostage" );
    self endon( #"task_ended" );
    
    while ( true )
    {
        self.carryorigin = player.origin;
        self.carryangles = player.angles;
        self.carrystance = player getstance();
        waitframe();
    }
}

// Namespace namespace_87e5a35991b973ad
// Params 1
// Checksum 0xb3a0bbff, Offset: 0x57f0
// Size: 0x73
function watchformovingentdeath( ent )
{
    self endon( #"hostage_pickup_finished" );
    self.hostage endon( #"death" );
    self notify( #"watchformovingentdeath" );
    self endon( #"watchformovingentdeath" );
    ent waittill( #"death" );
    self.hostage kill( self.hostage.origin );
}

// Namespace namespace_87e5a35991b973ad
// Params 1
// Checksum 0x4411efbe, Offset: 0x586b
// Size: 0x4e
function watchforplayerdeath( player )
{
    player endon( #"drop_hostage" );
    player utility::waittill_any( "death_or_disconnect", "enter_live_ragdoll", "last_stand_enter" );
    player stopanimscriptsceneevent();
    player notify( #"remove_rig" );
    thread drophostage( 1 );
}

// Namespace namespace_87e5a35991b973ad
// Params 1
// Checksum 0x45892cad, Offset: 0x58c1
// Size: 0x9c
function function_5f07030955e11e1d( player )
{
    player endon( #"death_or_disconnect" );
    player endon( #"enter_live_ragdoll" );
    player endon( #"drop_hostage" );
    self.hostage waittill( #"death" );
    player stopanimscriptsceneevent();
    player notify( #"remove_rig" );
    
    if ( isdefined( player.hostagerig ) )
    {
        player.hostagerig notify( #"remove_rig" );
        player.hostagerig = undefined;
    }
    
    function_8f0393098cddc44d( self.carryingplayer );
}

// Namespace namespace_87e5a35991b973ad
// Params 1
// Checksum 0x289b10f6, Offset: 0x5965
// Size: 0x41
function function_5792ee7eb78e6fe2( player )
{
    player endon( #"drop_hostage" );
    player endon( #"hostage_pickup_finished" );
    thread function_7d949fe0e3b08e65( player );
    thread function_5f07030955e11e1d( player );
    thread watchforplayerdeath( player );
}

// Namespace namespace_87e5a35991b973ad
// Params 1
// Checksum 0xb5aa3e61, Offset: 0x59ae
// Size: 0x221
function function_955ade66b8e7de35( player )
{
    player val::reset_all( "carry" );
    player val::set( "carry", "prone", 0 );
    player val::set( "carry", "slide", 0 );
    player val::set( "carry", "supersprint", 0 );
    player val::set( "carry", "mount_side", 0 );
    player val::set( "carry", "mount_top", 0 );
    player val::set( "carry", "mantle", 0 );
    player val::set( "carry", "equipment_secondary", 0 );
    player val::set( "carry", "equipment_primary", 0 );
    player val::set( "carry", "supers", 0 );
    player val::set( "carry", "melee", 0 );
    player val::set( "carry", "weapon_switch", 0 );
    player val::set( "carry", "swimming_underwater", 0 );
    player val::set( "carry", "dtp", 0 );
    player val::set( "carry", "ladder", 0 );
    player val::set( "carry", "weapon_pickup", 0 );
    player val::set( "carry", "weapon_switch_clip", 0 );
    player val::set( "carry", "killstreaks", 0 );
    player val::set( "carry", "execution_attack", 0 );
    player val::set( "carry", "vehicle_use", 0 );
    player val::set( "carry", "ascender_use", 0 );
    player val::set( "carry", "ads", 1 );
    player skydive_setdeploymentstatus( 0 );
    player skydive_setbasejumpingstatus( 0 );
    player.playerstreakspeedscale = -0.25;
    
    if ( !player common::function_8ff835bf23198a0( "playerStreakSpeedScale" ) )
    {
        player common::function_ac4bf3256b2545e3( "playerStreakSpeedScale", player.playerstreakspeedscale );
        player common::function_a6a0ecdb12c8e351( 2 );
    }
    
    player setmovespeedscale( 0.75 );
}

// Namespace namespace_87e5a35991b973ad
// Params 1
// Checksum 0x1ac0834b, Offset: 0x5bd7
// Size: 0x6b
function function_1c41a3669d6ae91( player )
{
    player val::reset_all( "carry" );
    player skydive_setdeploymentstatus( 1 );
    player skydive_setbasejumpingstatus( 1 );
    player.playerstreakspeedscale = 0;
    
    if ( player common::function_8ff835bf23198a0( "playerStreakSpeedScale" ) )
    {
        player common::function_d85a92c557ea5a52( "playerStreakSpeedScale" );
        player common::function_65276d8c156b2ec9( 2 );
    }
    
    player setmovespeedscale( 1 );
}

// Namespace namespace_87e5a35991b973ad
// Params 1, eflags: 0x4
// Checksum 0x3213a83e, Offset: 0x5c4a
// Size: 0x65
function private function_183e57e00b1d1dd0( player )
{
    self.defusingplayer = player;
    bomb = makeweapon( "briefcase_bomb_mp" );
    player inventory_utility::_giveweapon( bomb, undefined, undefined, 0 );
    player setweaponammostock( bomb, 0 );
    player setweaponammoclip( bomb, 0 );
    player thread gameobjects::switchtouseweapon( bomb, 1, 1 );
    player function_5531e6d8f26f905f( 0 );
    return bomb;
}

// Namespace namespace_87e5a35991b973ad
// Params 2, eflags: 0x4
// Checksum 0x13aa127b, Offset: 0x5cb8
// Size: 0x7e
function private function_915debdf87f515ac( player, bomb )
{
    lastweaponobj = player inventory::getlastweapon();
    
    if ( player killstreak::isjuggernaut() )
    {
        lastweaponobj = juggernaut::jugg_getminigunweapon();
    }
    else if ( !player hasweapon( lastweaponobj ) )
    {
        lastweaponobj = player inventory::getfirstprimaryweapon();
    }
    
    player inventory_utility::domonitoredweaponswitch( lastweaponobj, 0, 1 );
    player takeweapon( bomb );
    player function_5531e6d8f26f905f( 1 );
    self.defusingplayer = undefined;
}

// Namespace namespace_87e5a35991b973ad
// Params 1, eflags: 0x4
// Checksum 0x53f43f33, Offset: 0x5d3e
// Size: 0x124
function private function_5531e6d8f26f905f( isallowed )
{
    val::set( "hostage_holding_bomb", "allow_movement", isallowed );
    val::set( "hostage_holding_bomb", "script_weapon_switch", !isallowed );
    val::set( "hostage_holding_bomb", "sprint", isallowed );
    val::set( "hostage_holding_bomb", "fire", isallowed );
    val::set( "hostage_holding_bomb", "reload", isallowed );
    val::set( "hostage_holding_bomb", "weapon_pickup", isallowed );
    val::set( "hostage_holding_bomb", "weapon_switch", isallowed );
    val::set( "hostage_holding_bomb", "allow_jump", isallowed );
    val::set( "hostage_holding_bomb", "gesture", isallowed );
    self function_60e112d2e106b00a();
    
    if ( isallowed )
    {
        utility::waittill_any_timeout( 0.8, "bomb_allow_offhands" );
    }
    
    val::set( "hostage_holding_bomb", "melee", isallowed );
    val::set( "hostage_holding_bomb", "mantle", isallowed );
    val::set( "hostage_holding_bomb", "offhand_weapons", isallowed );
    
    if ( isallowed )
    {
        val::reset_all( "hostage_holding_bomb" );
        self function_7d73d6786e51ae1f();
    }
}

// Namespace namespace_87e5a35991b973ad
// Params 0
// Checksum 0x5364b81c, Offset: 0x5e6a
// Size: 0x327
function function_318298d49322cf35()
{
    spawnlocs = utility::getstructarray( self.node.target, "targetname" );
    spawnlocs = arrayrandomize( spawnlocs );
    self.hostage = undefined;
    
    foreach ( spawnloc in spawnlocs )
    {
        if ( spawnloc.script_noteworthy != "hostage" )
        {
            continue;
        }
        
        poiname = poi::poi_findpoioriginisin( spawnloc.origin );
        ai = ai_mp_controller::ai_mp_requestspawnagent( "civilian_mp_dmz_hostage", getclosestpointonnavmesh( spawnloc.origin ), spawnloc.angles, "absolute", "mission", undefined, "civs", "civilian", undefined, poiname, 1, undefined, 0 );
        
        if ( !isdefined( ai ) )
        {
            return;
        }
        
        ai.var_4f8a92ebabf37ee = 0;
        ai.ignoreme = 1;
        ai.health = 250;
        ai.maxhealth = 250;
        ai setcanusecover( 0 );
        ai function_2bb28ccf461c72ce( "script", 1 );
        ai.callbackdamaged = &hostagedamagecallback;
        ai cap::cap_start( "cap_hostage", "civilian_dmz_hostage" );
        ai.ishostage = 1;
        ai.task = self;
        self.hostage = ai;
        level.agent_funcs[ ai.agent_type ][ "on_damaged" ] = &ai_mp_controller::function_6cd3090858f1d8d9;
        ai.invulnerable = 1;
        break;
    }
    
    if ( !isdefined( self.hostage ) )
    {
        return;
    }
    
    self.instance = spawnscriptable( "dmz_hostage", self.hostage.origin, ( 0, 0, 0 ) );
    self.instance.hostage = self.hostage;
    self.hostage.instance = self.instance;
    self.instance.task = self;
    self.instance setscriptablepartstate( "dmz_hostage", "unusable", 0 );
    
    if ( !self.skipcontract )
    {
        bombspawnloc = self.hostage.origin + anglestoright( self.hostage.angles ) * -20;
        self.c4 = spawn( "script_model", bombspawnloc );
        self.c4 setmodel( "offhand_2h_wm_briefcase_bomb_v0" );
        self.c4.issuper = 0;
    }
    
    thread monitorhostage();
}

// Namespace namespace_87e5a35991b973ad
// Params 13
// Checksum 0xb14782e5, Offset: 0x6199
// Size: 0xdb
function hostagedamagecallback( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon )
{
    isplayerdamage = isdefined( eattacker ) && ( isplayer( eattacker ) || isplayer( eattacker.owner ) );
    
    if ( isplayerdamage && level.hostageprops.blockplayerdamage )
    {
        return;
    }
    
    common_agent_damage::common_callbacksoldieragentdamaged( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon, 0 );
}

/#

    // Namespace namespace_87e5a35991b973ad
    // Params 0, eflags: 0x4
    // Checksum 0x74d7b867, Offset: 0x627c
    // Size: 0x61, Type: dev
    function private function_b348f2db945fff04()
    {
        self.hostage.origin = level.players[ 0 ].origin;
        self.hostage.instance.origin = level.players[ 0 ].origin;
    }

#/

// Namespace namespace_87e5a35991b973ad
// Params 0, eflags: 0x4
// Checksum 0x64c09715, Offset: 0x62e5
// Size: 0x1bf
function private function_be1cf3944aef242a()
{
    spawnlocs = utility::getstructarray( self.fort.target, "targetname" );
    self.guards = [];
    
    if ( isdefined( self.hostage ) && isdefined( self.hostage.origin ) )
    {
        spawnlocs = sortbydistance( spawnlocs, self.hostage.origin );
    }
    
    for ( i = 0; i < spawnlocs.size ; i++ )
    {
        if ( self.guards.size >= 8 )
        {
            break;
        }
        
        spawnloc = spawnlocs[ i ];
        
        if ( !isdefined( spawnloc.script_noteworthy ) || !issubstr( spawnloc.script_noteworthy, "guard" ) )
        {
            continue;
        }
        
        aitype = ai_mp_controller::function_b86341658788836c( undefined, undefined, undefined, undefined, "ar", 3 );
        enemy = ai_mp_controller::ai_mp_requestspawnagent( aitype, spawnloc.origin, spawnloc.angles, "high", "mission", "hostageGuard", undefined, undefined, undefined, self.node.script_poi, 0, undefined, 0 );
        
        if ( isdefined( enemy ) )
        {
            function_db260b3aaa30882( enemy, 1 );
            enemy ai_behavior::function_4a3c03bb49dd5d76( enemy.origin, 16 );
            enemy.var_4f8a92ebabf37ee = 0;
            self.guards[ self.guards.size ] = enemy;
            
            if ( issubstr( aitype, "shotgun" ) )
            {
                if ( !isdefined( self.shotgun_guard ) )
                {
                    self.shotgun_guard = enemy;
                }
            }
            
            thread ai_behavior::behavior_GuardStationary( enemy );
        }
    }
}

// Namespace namespace_87e5a35991b973ad
// Params 2
// Checksum 0xb81f31b, Offset: 0x64ac
// Size: 0x6d
function function_db260b3aaa30882( agent, noweaponchange )
{
    grenade_type = utility::array_random( [ "concussion_grenade_mp", "smoke_grenade_mp", "flash_grenade_mp" ] );
    grenadeammo = getdvarint( @"hash_537fa443ce212a8a", 4 );
    agent agent_utils::overrideagentsettings( undefined, undefined, undefined, grenade_type, grenadeammo, undefined, undefined );
}

// Namespace namespace_87e5a35991b973ad
// Params 0
// Checksum 0x9b11e476, Offset: 0x6521
// Size: 0xd3
function function_9989defe1f5947f4()
{
    self.task endon( #"task_ended" );
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( !isdefined( self ) )
        {
            return;
        }
        
        state = self.task.state;
        
        if ( !isdefined( state ) )
        {
            state = "";
        }
        
        dialogprefix = level.var_938ecdea82f1c946 ?? "dmzc";
        alias = function_8686ded1413c5c40( state, dialogprefix );
        thread dialogue::play_dialogue_sound( alias );
        
        if ( state == "rescued" )
        {
            return;
        }
        
        length = lookupsoundlength( alias );
        utility::waittill_notify_or_timeout( "play_dialog", length / 1000 + 4 );
    }
}

// Namespace namespace_87e5a35991b973ad
// Params 2
// Checksum 0xe869c913, Offset: 0x65fc
// Size: 0xbf
function function_8686ded1413c5c40( state, prefix )
{
    nationality = level.var_5f7560a3d7dad26b ?? "cvm3";
    sufix = undefined;
    
    switch ( state )
    {
        case #"hash_56049e7ee0845631":
            sufix = "_creb";
            break;
        case #"hash_5548a62ed50ac006":
            sufix = "_crec";
            break;
        case #"hash_a152dd6f2d4b9918":
            sufix = "_cref";
            break;
        default:
            sufix = "_cire";
            break;
    }
    
    alias = "dx_br_" + prefix + "_hore_" + nationality + sufix;
    return alias;
}

// Namespace namespace_87e5a35991b973ad
// Params 0
// Checksum 0x82a13650, Offset: 0x66c4
// Size: 0x2fe
function function_442607e8d0062d3b()
{
    dmz_task_utils::function_844c661c74b52ce3( "dmz_hostage_transport" );
    utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"hostage_rescue_heli_incoming", self.teams[ 0 ], 5 );
    wait 5;
    
    if ( !self.failure )
    {
        path = namespace_258bbdad74becc8::function_649b43835fd02e64( self.helinode, self.helinode.origin );
        
        if ( !isdefined( path ) )
        {
            if ( !self.failure )
            {
                thread function_18ab4afb1d91eacc( self.teams[ 0 ] );
            }
            
            return;
        }
        
        ownerplayer = undefined;
        players = teams::getteamdata( self.teams[ 0 ], "players" );
        
        if ( !isdefined( players ) )
        {
            function_18ab4afb1d91eacc();
            return;
        }
        
        for ( i = 0; i < players.size && !isdefined( ownerplayer ) ; i++ )
        {
            ownerplayer = players[ i ];
        }
        
        if ( !isdefined( ownerplayer ) )
        {
            function_18ab4afb1d91eacc();
            return;
        }
        
        team = ownerplayer.team;
        self.heli = namespace_258bbdad74becc8::function_f99c7d4de23543cb( ownerplayer, path.origin, self.helinode.angles );
        thread namespace_258bbdad74becc8::function_4601be2c290ec75d( self.heli, self.helinode.origin );
        vehicle_occupancy::set_team( self.heli, team );
        self.heli.onStartRiding = &function_4932597c1780fd4a;
        self.heli.onEndRiding = &function_dc76c0f5443b3b0e;
        self.heli.task = self;
        self.heli.helinode = self.helinode;
        self.heli.minwaittimer = 1;
        self.heli.exfilhelicopter = 1;
        self.heli thread function_fe26332b6e6a9ccb( path );
    }
    else
    {
        return;
    }
    
    if ( !self.failure )
    {
        function_ee921bedd3148c4f();
    }
    
    if ( !isdefined( self.hostageheli ) )
    {
        return;
    }
    
    if ( !self.completed )
    {
        objidpoolmanager::update_objective_onentity( self.icon, self.hostageheli );
    }
    
    if ( !self.failure )
    {
        self.hostage.invulnerable = 1;
    }
    
    while ( !self.hostageheli.exfilpathstarted )
    {
        self.hostageheli waittill( #"hash_cb066c5579020915" );
    }
    
    thread function_30ddd294f2f9a4f5( self.hostageheli );
    
    if ( !self.failure )
    {
        thread function_18ab4afb1d91eacc( self.teams[ 0 ] );
    }
}

// Namespace namespace_87e5a35991b973ad
// Params 1
// Checksum 0x68ade773, Offset: 0x69ca
// Size: 0xf6
function function_91f82f9795e46875( heli )
{
    if ( heli.exfilhelicopter )
    {
        self.instance setscriptablepartstate( "dmz_hostage", "unusable" );
        
        if ( !isdefined( self.hostageent ) )
        {
            self.hostageent = spawn( "script_origin", self.hostage.origin );
        }
        
        self.hostageent.origin = self.hostage.origin;
        self.hostageent linkto( heli );
        self.hostage linkto( self.hostageent );
        self.hostage.invulnerable = 1;
        self.var_1abbea3134503216 = 1;
        self.hostageheli = heli;
        heli notify( #"hash_1a3c170be310be5a" );
        self notify( #"dmz_hostage_inside_heli" );
    }
}

// Namespace namespace_87e5a35991b973ad
// Params 1
// Checksum 0xf2ada04b, Offset: 0x6ac8
// Size: 0x147
function function_fe26332b6e6a9ccb( path )
{
    self endon( #"death" );
    vehicle_paths::vehicle_paths_helicopter( path );
    
    if ( !self.helinode.info.land )
    {
        self sethoverparams( 0, 0, 0 );
    }
    
    if ( !self.task.completed )
    {
        self.task utility::waittill_any( "dmz_hostage_inside_heli", "task_ended" );
    }
    
    if ( self.task.failure )
    {
        function_f95a60cad2fd737b();
    }
    
    self.exfilpathstarted = 1;
    self notify( #"hash_cb066c5579020915" );
    namespace_258bbdad74becc8::function_ade4ac55a191b81a( self );
    path = namespace_258bbdad74becc8::function_e49a3b32812fb5f4( self.helinode, self.helinode.origin, level.chopperexfil.heliheight );
    thread vehicle_paths::vehicle_paths_helicopter( path );
    wait 8;
    
    if ( !self.failure )
    {
        info = namespace_258bbdad74becc8::function_2656673ab5dbdb77( self.playersinside, 0, 1, 0, 0 );
        br_dmz_extract::exfilplayers( self.playersinside, info );
    }
    
    wait 15;
    thread namespace_258bbdad74becc8::function_a9fcff0fe86e7ff0();
}

// Namespace namespace_87e5a35991b973ad
// Params 1
// Checksum 0xbdad92bd, Offset: 0x6c17
// Size: 0x114
function function_4932597c1780fd4a( player )
{
    if ( !isdefined( self.playersinside[ player.guid ] ) )
    {
        self.playersinside[ player.guid ] = player;
        outofbounds::enableoobimmunity( player );
        
        if ( !self.task.var_6ba14ffe23370a0e )
        {
            self.task.var_6ba14ffe23370a0e = 1;
            utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"hostage_lower_heli", self.task.teams[ 0 ] );
        }
    }
    
    if ( self.task.var_1abbea3134503216 && isdefined( self.var_80c58b306173b9c3 ) )
    {
        if ( !isdefined( player.var_865e05e9fa3040f9 ) )
        {
            self.var_77f46a6090b89414[ self.var_77f46a6090b89414.size ] = player;
            player thread br_dmz_extract::playerexfiltimer( self.origin, self.var_80c58b306173b9c3, 2000 );
        }
    }
}

// Namespace namespace_87e5a35991b973ad
// Params 1
// Checksum 0xd30a735a, Offset: 0x6d33
// Size: 0x35
function function_dc76c0f5443b3b0e( player )
{
    self.playersinside[ player.guid ] = undefined;
    
    if ( outofbounds::isoobimmune( player ) )
    {
        outofbounds::disableoobimmunity( player );
    }
}

// Namespace namespace_87e5a35991b973ad
// Params 3
// Checksum 0x31f91324, Offset: 0x6d70
// Size: 0x169
function function_f8a93e78cc08032d( startnode, heliheight, reverse = 0 )
{
    var_5dcd37deb66bc6d3 = 10;
    contents = trace::create_contents( 0, 1, 1, 1, 1, 0, 1, 1, 0 );
    startpos = startnode.origin + ( 0, 0, heliheight + 600 );
    var_18397e93d9334888 = reverse ? startnode.angles[ 1 ] + 180 : startnode.angles[ 1 ];
    yaw = 0;
    
    while ( yaw < 360 )
    {
        var_18397e93d9334888 += yaw;
        testangles = ( 0, var_18397e93d9334888, 0 );
        approachstartpos = startpos;
        approachendpos = startpos + anglestoforward( testangles ) * 18000;
        approachtrace = trace::sphere_trace( approachstartpos, approachendpos, 100, undefined, contents, 1 );
        
        if ( approachtrace[ "fraction" ] == 1 )
        {
            /#
                line( approachstartpos, approachendpos, ( 0, 1, 0 ), 1, 0, 2000 );
            #/
            
            return approachendpos;
        }
        
        /#
            line( approachstartpos, approachendpos, ( 1, 0, 0 ), 1, 0, 2000 );
        #/
        
        if ( yaw % 3 == 0 )
        {
            waitframe();
        }
        
        yaw += var_5dcd37deb66bc6d3;
    }
}

// Namespace namespace_87e5a35991b973ad
// Params 0
// Checksum 0xe2678cb6, Offset: 0x6ee2
// Size: 0x2c
function function_ee921bedd3148c4f()
{
    self endon( #"task_ended" );
    
    while ( !isdefined( self.hostageheli ) )
    {
        self waittill( #"dmz_hostage_inside_heli" );
    }
}

// Namespace namespace_87e5a35991b973ad
// Params 0
// Checksum 0x60dba9e5, Offset: 0x6f16
// Size: 0x11c
function function_f7a8b714106e97d0()
{
    self.task endon( #"task_ended" );
    
    if ( !self.var_1abbea3134503216 )
    {
        self waittill( #"hash_1a3c170be310be5a" );
    }
    
    self.var_80c58b306173b9c3 = 5;
    
    foreach ( player in self.playersinside )
    {
        if ( !isdefined( player.var_865e05e9fa3040f9 ) )
        {
            self.var_77f46a6090b89414[ self.var_77f46a6090b89414.size ] = player;
            player thread br_dmz_extract::playerexfiltimer( self.origin, self.var_80c58b306173b9c3, 2000 );
        }
    }
    
    while ( self.var_80c58b306173b9c3 > 0 )
    {
        self.var_80c58b306173b9c3 -= 1;
        wait 1;
    }
}

// Namespace namespace_87e5a35991b973ad
// Params 0
// Checksum 0xd58e4b11, Offset: 0x703a
// Size: 0x126
function function_f95a60cad2fd737b()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    var_e1c40ae467d4d43f = [];
    
    while ( true )
    {
        wait 1;
        var_bd0c73bc205cd4ee = utility::playersincylinder( self.origin, 665, undefined, 500 );
        
        foreach ( player in var_bd0c73bc205cd4ee )
        {
            if ( !isdefined( var_e1c40ae467d4d43f[ player.guid ] ) )
            {
                var_e1c40ae467d4d43f[ player.guid ] = gettime();
            }
            
            if ( gettime() - var_e1c40ae467d4d43f[ player.guid ] > 5000 )
            {
                player hud_message::showerrormessage( %"mp_dmz_missions/hostage_heli_msg" );
                var_e1c40ae467d4d43f[ player.guid ] = gettime();
            }
        }
        
        if ( var_bd0c73bc205cd4ee.size == 0 )
        {
            break;
        }
    }
}

// Namespace namespace_87e5a35991b973ad
// Params 1
// Checksum 0xe8acdc89, Offset: 0x7168
// Size: 0x62
function function_30ddd294f2f9a4f5( heli )
{
    heli waittill( #"death" );
    
    if ( isalive( self.hostage ) && self.var_1abbea3134503216 )
    {
        self.hostage ai_mp_controller::killoffagent();
    }
    
    if ( isdefined( self.hostageent ) )
    {
        self.hostageent delete();
    }
}

// Namespace namespace_87e5a35991b973ad
// Params 0
// Checksum 0xdc6d65a3, Offset: 0x71d2
// Size: 0x336
function function_1c864efef16c49da()
{
    alllocations = arrayrandomize( utility::getstructarray( "hostage_setup", "targetname" ) );
    validlocations = [];
    helinodes = arrayrandomize( utility::getstructarray( "dmz_hostage_exfil", "script_noteworthy" ) );
    
    foreach ( loc in alllocations )
    {
        isvalid = 1;
        
        if ( !isdefined( loc.target ) )
        {
            continue;
        }
        
        spawnlocs = utility::getstructarray( loc.target, "targetname" );
        
        foreach ( spawnloc in spawnlocs )
        {
            if ( spawnloc.script_noteworthy == "hostage" )
            {
                pos = getclosestpointonnavmesh( spawnloc.origin );
                
                if ( distance( pos, spawnloc.origin ) > 100 )
                {
                    isvalid = 0;
                    break;
                }
            }
        }
        
        if ( !isvalid )
        {
            continue;
        }
        
        fortress = ai_fortress::function_a342bb675c7cb16e( loc.origin, "hostage_forts" );
        
        if ( !isdefined( fortress ) )
        {
            continue;
        }
        
        if ( distance2dsquared( fortress.origin, loc.origin ) > level.hostageprops.fortressrange * level.hostageprops.fortressrange || arraycontains( level.fortressstruct.chosenfortresses, fortress ) )
        {
            continue;
        }
        
        mindist = 12000;
        
        foreach ( heli in helinodes )
        {
            dist = distance( loc.origin, heli.origin );
            
            if ( !heli.chosen && dist < mindist )
            {
                mindist = dist;
                loc.helinode = heli;
            }
        }
        
        if ( isdefined( loc.helinode ) )
        {
            loc.helinode.chosen = 1;
        }
        else
        {
            isvalid = 0;
        }
        
        if ( isvalid )
        {
            validlocations[ validlocations.size ] = loc;
        }
    }
    
    return validlocations;
}

/#

    // Namespace namespace_87e5a35991b973ad
    // Params 0
    // Checksum 0xed87d0b3, Offset: 0x7511
    // Size: 0x44, Type: dev
    function debughostage()
    {
        while ( true )
        {
            if ( getdvarint( @"scr_drop_hostage", 0 ) )
            {
                setdvar( @"scr_drop_hostage", 0 );
                
                if ( isdefined( self.carryingplayer ) )
                {
                    drophostage( 1 );
                }
            }
            
            waitframe();
        }
    }

#/
