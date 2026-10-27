// script_4cf6e8a5c419dee5  (hash_4cf6e8a5c419dee5.gscc) (size: 19492 Bytes / 0x4c24 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7f00d7f0 (2130761712)
// size ...... 19492 (0x4c24)
// includes .. 21  (offset: 0x464c)
// strings ... 81  (offset: 0x46f4)
// dev strs .. 4   (offset: 0x4bd0)
// exports ... 41  (offset: 0x2d4c)
// cseg ...... 0x68e + 0x26be (0x2d4c)
// imports ... 156 (offset: 0x33b4)
// animtree1 . 1   (offset: 0x4c08)
// animtree2 . 1   (offset: 0x4c14)
#using script_599653855a4317f1;
#using scripts\common\script;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_fortress;
#using scripts\mp\ai_reinforcements;
#using scripts\mp\anim;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\common\utility\infilexfil;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\dmz\gametypes\dmz_audio;
#using scripts\mp\dmz\gametypes\dmz_task_utils;
#using scripts\mp\gametypes\activity_manager;
#using scripts\mp\loot\common_cache;
#using scripts\mp\objidpoolmanager;

#namespace namespace_5ab652de57e3c043;

// Namespace namespace_5ab652de57e3c043
// Params 1
// Checksum 0xa68850af, Offset: 0x6ac
// Size: 0x1f1
function dmztask_getspawndata( data )
{
    level.trapprops = spawnstruct();
    level.trapprops.capturetime = getdvarint( @"scr_dmz_trap_capture_time", 120 );
    level.trapprops.captureradius = getdvarint( @"scr_dmz_trap_capture_radius", 800 );
    level.trapprops.captureheight = getdvarint( @"hash_1ec4d1950e884a45", 800 );
    level.trapprops.usenodes = getdvarint( @"hash_f4b9219b332581a2", 1 );
    scriptable::scriptable_addusedcallbackbypart( "dmz_secret_stash", &function_451e44cc047dec42 );
    script_model_anims();
    
    while ( !isdefined( level.fortressstruct ) || !level.fortressstruct.gatheredvolumes )
    {
        waitframe();
    }
    
    var_ada4f2b59df5e793 = [];
    possiblenodes = utility::getstructarray( "dmz_secret_stash", "script_noteworthy" );
    
    if ( !level.trapprops.usenodes )
    {
        possiblenodes = getunusedlootcachepoints();
    }
    
    foreach ( node in possiblenodes )
    {
        fortress = ai_fortress::function_386da8b7d1afe346( node.origin );
        
        if ( isdefined( fortress ) && !ai_fortress::function_c4cc2f9a17167e1b( fortress ) )
        {
            node.fortress = fortress;
            var_ada4f2b59df5e793[ var_ada4f2b59df5e793.size ] = node;
        }
    }
    
    /#
        thread function_8db3a73579062e2e();
    #/
    
    activity_manager::function_f61a1f535aab4194( data, &function_425a8608b1fd116a, var_ada4f2b59df5e793 );
}

#using_animtree( "script_model" );

// Namespace namespace_5ab652de57e3c043
// Params 0
// Checksum 0x14b6e3b2, Offset: 0x8a5
// Size: 0x6d
function script_model_anims()
{
    level.scr_animtree[ "gun_safe_drill_player" ] = #animtree;
    level.scr_anim[ "gun_safe_drill_player" ][ "gun_safe_enter" ] = %iw9_dmz_stashdrill_enter_stand_sdr;
    level.scr_eventanim[ "gun_safe_drill_player" ][ "gun_safe_enter" ] = %"gun_safe_enter";
    level.scr_viewmodelanim[ "gun_safe_drill_player" ][ "gun_safe_enter" ] = "iw9_dmz_stashdrill_enter_stand_sdr";
}

// Namespace namespace_5ab652de57e3c043
// Params 1
// Checksum 0xd25018fc, Offset: 0x91a
// Size: 0x117
function function_50fd298722b0c994( isallowed )
{
    if ( !isallowed )
    {
        val::set( "drilling", "allow_jump", 0 );
        val::set( "drilling", "gesture", 0 );
        val::set( "drilling", "melee", 0 );
        val::set( "drilling", "mantle", 0 );
        val::set( "drilling", "offhand_weapons", 0 );
        val::set( "drilling", "allow_movement", 0 );
        val::set( "drilling", "sprint", 0 );
        val::set( "drilling", "fire", 0 );
        val::set( "drilling", "reload", 0 );
        val::set( "drilling", "weapon_pickup", 0 );
        val::set( "drilling", "weapon_switch", 0 );
        val::set( "drilling", "offhand_weapons", 0 );
        val::set( "drilling", "supers", 0 );
        self function_60e112d2e106b00a();
        return;
    }
    
    val::reset_all( "drilling" );
    self function_7d73d6786e51ae1f();
}

// Namespace namespace_5ab652de57e3c043
// Params 1
// Checksum 0xfaedd4b7, Offset: 0xa39
// Size: 0x2f8
function function_d77877bb0e9cad9b( player )
{
    player endon( #"death_or_disconnect" );
    player endon( #"enter_live_ragdoll" );
    player endon( #"interact_interrupt" );
    player function_50fd298722b0c994( 0 );
    playerviewangles = player getplayerangles();
    player.linktoent = player utility::spawn_tag_origin( player.origin, player.playerviewangles );
    player playerlinktodelta( player.linktoent, "tag_origin", 1, 0, 0, 30, 30, 0, 1 );
    goalpos = self.origin + rotatevector( ( 0, 41.127, 0 ), self.angles + ( 0, -90, 0 ) );
    forward = ( 0, 0, 0 ) - anglestoforward( self.angles );
    up = ( 0, 0, 1 );
    right = vectorcross( forward, up );
    goalangles = axistoangles( forward, right, up ) + ( 0, 0, 0 );
    movetotime = 0.5;
    player.linktoent moveto( goalpos, movetotime, 0.1, 0.1 );
    player.linktoent rotateto( goalangles, movetotime, 0.1, 0.1 );
    player setstance( "stand" );
    var_a0892d74cbac4dc7 = gettime();
    player inventory_utility::givegunlessweapon();
    var_1cf22deb50656964 = gettime();
    var_ed2a546b70aa8095 = movetotime - ( var_1cf22deb50656964 - var_a0892d74cbac4dc7 ) / 1000;
    waittime = max( 0, var_ed2a546b70aa8095 );
    wait waittime;
    player setorigin( goalpos );
    player setplayerangles( goalangles );
    player thread infilexfil::infil_player_rig_updated( "gun_safe_drill_player", player.origin, player.angles );
    player.player_rig showonlytoplayer( player );
    animstruct = spawnstruct();
    animstruct.origin = self.origin;
    animstruct.angles = self.angles + ( 0, 90, 0 );
    self setscriptablepartstate( "dmz_secret_stash", "drill_enter" );
    animstruct anim_mp::anim_player_solo( player, player.player_rig, "gun_safe_enter" );
    
    if ( player::isreallyalive( player ) )
    {
        player notify( #"interact_finished" );
    }
    
    waitframe();
    
    if ( level.gameended )
    {
        return;
    }
    
    if ( isdefined( player ) )
    {
        player notify( #"remove_rig" );
        
        if ( player::isreallyalive( player ) )
        {
            player function_50fd298722b0c994( 1 );
        }
    }
    
    self.successfuluse = 1;
}

// Namespace namespace_5ab652de57e3c043
// Params 1
// Checksum 0xc0692dd1, Offset: 0xd39
// Size: 0x8e
function dmztask_watchplayerdeathordisconnect( player )
{
    player endon( #"interact_finished" );
    player utility::waittill_any( "death_or_disconnect", "enter_live_ragdoll", "last_stand_enter" );
    player notify( #"interact_interrupt" );
    player stopanimscriptsceneevent();
    
    if ( isdefined( player.linktoent ) )
    {
        player unlink();
        player.linktoent delete();
        player.linktoent = undefined;
    }
    
    player notify( #"remove_rig" );
    player function_50fd298722b0c994( 1 );
}

// Namespace namespace_5ab652de57e3c043
// Params 6, eflags: 0x4
// Checksum 0xf30a970b, Offset: 0xdcf
// Size: 0x172
function private function_451e44cc047dec42( instance, part, state, player, bautouse, usestring )
{
    if ( !isdefined( player.team ) )
    {
        return;
    }
    
    if ( part == "dmz_secret_stash" && state == "usable" )
    {
        instance setscriptablepartstate( "dmz_secret_stash", "unusable" );
        instance.successfuluse = 0;
        instance thread dmztask_watchplayerdeathordisconnect( player );
        instance function_d77877bb0e9cad9b( player );
        
        if ( instance.successfuluse )
        {
            instance.task thread function_3b589b026890bb44( player.team );
        }
        else
        {
            instance setscriptablepartstate( "dmz_secret_stash", "usable" );
        }
        
        return;
    }
    
    if ( part == "dmz_secret_stash" && ( state == #"closed_usable" || state == "partially_open_usable" ) )
    {
        if ( !isdefined( instance.contents ) )
        {
            script::demoforcesre( "Removed br_lootcache function getContentsWithAdditionalUpgradeItems here." );
            instance.containertype = 5;
            items = getscriptablelootcachecontents( instance );
            common_cache::function_a09e7cf5bad99b64( instance, items, undefined, player );
            script::demoforcesre( "Removed br_lootcache function ensureCashValueInLootContents here." );
            common_cache::function_60ce579fa7d3b6da( instance, part, state, player, bautouse, usestring );
            return;
        }
        
        common_cache::function_60ce579fa7d3b6da( instance, part, state, player, bautouse, usestring );
    }
}

/#

    // Namespace namespace_5ab652de57e3c043
    // Params 0
    // Checksum 0xb8aa994a, Offset: 0xf49
    // Size: 0x16, Type: dev
    function function_746bdfc760ec9b18()
    {
        return utility::getstructarray( "<dev string:x24>", "<dev string:x35>" );
    }

#/

// Namespace namespace_5ab652de57e3c043
// Params 2
// Checksum 0x923e9d9f, Offset: 0xf67
// Size: 0x108
function function_425a8608b1fd116a( activity, node )
{
    task = dmz_task_utils::task_create( activity );
    task.funcs[ "onInit" ] = &function_3819ce4a29765ef5;
    task.funcs[ "onPlayerJoined" ] = &function_aacc86809e911b87;
    task.funcs[ "onPlayerRemoved" ] = &function_5f715d2d6f0778ae;
    task.funcs[ "onTeamAssigned" ] = &function_726aca930d20daca;
    task.funcs[ "onTeamStart" ] = &function_ab98daba7bd08e1a;
    task.funcs[ "onCancel" ] = &function_9aec0160eef2320d;
    task.ref = "dmz_fortress_search";
    task.refindex = br_contract_manager::getquesttableindex( task.ref );
    task.node = node;
    task.fortress = node.fortress;
    return task;
}

// Namespace namespace_5ab652de57e3c043
// Params 0
// Checksum 0xe9d8a6cd, Offset: 0x1078
// Size: 0x18b
function function_3819ce4a29765ef5()
{
    self.activity.origin = self.node.origin;
    self.capturetime = level.trapprops.capturetime;
    function_66a3bf6d5ef41988();
    self.entrances = function_38a879cc5c114bc2( self.fortress );
    self.activitykey = "trap" + gettime();
    
    foreach ( door in self.entrances )
    {
        door.activitykey = self.activitykey;
        door.activitytype = "trap";
    }
    
    self.var_acfbbce74758f7b7 = 0;
    self.curorigin = self.cache.origin;
    self.offset3d = ( 0, 0, 85 );
    dmz_task_utils::function_b3476f99a8e21fa2( self.curorigin + self.offset3d, "trap" );
    objidpoolmanager::objective_set_play_intro( self.icon, 1 );
    objidpoolmanager::objective_set_play_outro( self.icon, 0 );
}

// Namespace namespace_5ab652de57e3c043
// Params 1
// Checksum 0xbd0a092b, Offset: 0x120b
// Size: 0x31
function function_aacc86809e911b87( player )
{
    self.cache enablescriptableplayeruse( player );
    player.activitykey = self.activitykey;
}

// Namespace namespace_5ab652de57e3c043
// Params 1
// Checksum 0x7f3fd795, Offset: 0x1244
// Size: 0x34
function function_5f715d2d6f0778ae( player )
{
    if ( !self.traptriggered )
    {
        self.cache disablescriptableplayeruse( player );
    }
    
    player.activitykey = undefined;
}

// Namespace namespace_5ab652de57e3c043
// Params 1
// Checksum 0xaba6bfa3, Offset: 0x1280
// Size: 0x176
function function_726aca930d20daca( teamname )
{
    if ( self.cache getscriptablepartstate( "dmz_secret_stash" ) == "unusable" )
    {
        self.cache setscriptablepartstate( "dmz_secret_stash", "usable" );
    }
    
    dmz_task_utils::task_showsplashtoteam( "dmz_trap_assigned", teamname );
    
    foreach ( player in level.players )
    {
        self.cache disablescriptableplayeruse( player );
    }
    
    var_e86dd9eafd0f1ec3 = teams::getteamdata( teamname, "players" );
    
    foreach ( player in var_e86dd9eafd0f1ec3 )
    {
        self.cache enablescriptableplayeruse( player );
    }
    
    dmz_task_utils::function_44b2bf42bbc07d05( teamname );
    function_162d42e425db564c( teamname );
    self.cashreward = dmz_task_utils::function_f15515a374b8ebf2( teamname );
}

// Namespace namespace_5ab652de57e3c043
// Params 1, eflags: 0x4
// Checksum 0xa3d2d271, Offset: 0x13fe
// Size: 0x4d
function private function_162d42e425db564c( teamname )
{
    dmz_audio::function_32ff837bc21a4833( teamname, "dmz_trap_start", 1.5, "dmz_trap_start_classic" );
    utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"trap_assigned", teamname, 2.5 );
}

// Namespace namespace_5ab652de57e3c043
// Params 1
// Checksum 0xaa0893e4, Offset: 0x1453
// Size: 0x48
function function_ab98daba7bd08e1a( teamname )
{
    dmz_audio::function_32ff837bc21a4833( teamname, "dmz_trap_approach", 0, "dmz_trap_approach_classic" );
    utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"trap_near", teamname );
}

// Namespace namespace_5ab652de57e3c043
// Params 1
// Checksum 0x6e34e98f, Offset: 0x14a3
// Size: 0xc2
function function_9aec0160eef2320d( teamname )
{
    players = teams::getteamdata( teamname, "players" );
    
    foreach ( player in players )
    {
        if ( !self.traptriggered )
        {
            self.cache disablescriptableplayeruse( player );
        }
    }
    
    dmz_audio::function_32ff837bc21a4833( teamname, undefined, undefined );
    dmztask_cleanup();
    dmz_task_utils::task_ended();
}

// Namespace namespace_5ab652de57e3c043
// Params 0
// Checksum 0x7d2c865e, Offset: 0x156d
// Size: 0x4b
function dmztask_cleanup()
{
    self.complete = 1;
    
    if ( !self.traptriggered )
    {
        self.cache.trigger delete();
        dmz_task_utils::function_3ff46488beb193c7();
    }
    
    dmz_task_utils::function_2f96219ec7ea4fe9( self.teams[ 0 ] );
}

// Namespace namespace_5ab652de57e3c043
// Params 1
// Checksum 0xae759364, Offset: 0x15c0
// Size: 0x111
function function_1a5bf3eacefaa718( teamname )
{
    if ( isdefined( self.cache.trigger ) )
    {
        self.cache.trigger delete();
    }
    
    dmz_task_utils::function_3ff46488beb193c7();
    
    if ( !self.complete )
    {
        dmztask_cleanup();
        
        foreach ( team in self.teams )
        {
            dmz_task_utils::function_c64a66646904bc1( "dmz_survive_unlocked", "trap", self.activity.cashreward, team );
            dmz_audio::function_32ff837bc21a4833( team, "", 1.5 );
        }
        
        dmz_task_utils::task_ended( self.teams[ 0 ] );
    }
}

// Namespace namespace_5ab652de57e3c043
// Params 0, eflags: 0x4
// Checksum 0xc5ca071f, Offset: 0x16d9
// Size: 0x15c
function private function_66a3bf6d5ef41988()
{
    origin = self.node.origin;
    angles = self.node.angles;
    
    if ( !level.trapprops.usenodes )
    {
        angles += ( 0, 90, 0 );
    }
    
    cache = spawnscriptable( "dmz_secret_stash", origin, angles );
    
    /#
        dmz_logging::addlogevent( "<dev string:x47>", self.activity.name, undefined, "<dev string:x24>", undefined, undefined, self.activity.script_poi, origin );
    #/
    
    cache.task = self;
    self.cache = cache;
    trigger = spawn( "trigger_radius", self.cache.origin, 0, level.trapprops.captureradius, level.trapprops.captureheight );
    trigger utility::trigger_off();
    self.cache.trigger = trigger;
    thread dmztask_watchtrigger( trigger, level.trapprops.captureradius );
}

// Namespace namespace_5ab652de57e3c043
// Params 1, eflags: 0x4
// Checksum 0x9ce6443e, Offset: 0x183d
// Size: 0x3b8
function private function_3b589b026890bb44( teamname )
{
    self.var_acfbbce74758f7b7 = teams::getteamdata( teamname, "players" ).size;
    self.cache.trigger utility::trigger_on();
    
    if ( !self.cache.ignorefortress )
    {
        dmz_task_utils::function_844c661c74b52ce3( "dmz_trap" );
        self.fortress.tacmapscriptable setscriptablepartstate( "fortress_tacmap_location_scriptable", "attacked", 0 );
        objective_setshowprogress( self.icon, 1 );
        thread function_55e1b6dd263e8cd4( self.entrances );
        thread function_45a18cd8d6e613c2( self.entrances );
        groupname = "no_group";
        var_c1b346067aeb7938 = getdvarint( @"hash_dc6efd2d90a799e4", 6 );
        var_e3bcbd1fac3a1c9c = getdvarint( @"hash_d9950352be0cdcd0", 8 );
        var_c6f1111a5e4efeb7 = getdvarint( @"hash_eafc74f33b34f9e7", 6 );
        var_af07be47c76d1fbb = getdvarint( @"hash_fc93bfbca571ee92", 1 );
        var_955417b0f658c4f1 = getdvarint( @"hash_a9568da46c605fce", 1 );
        var_6fc7cc4b942e69c4 = getdvarint( @"hash_5c3cc2a96e90e73f", 1 );
        thread function_f878c15b4b7f297( self.cache.origin, var_c1b346067aeb7938, groupname, var_af07be47c76d1fbb );
        thread function_42f838a7c2d01137( self.cache.origin, var_e3bcbd1fac3a1c9c, groupname, var_955417b0f658c4f1 );
        thread function_d814bbbc3791ddde( self.cache.origin, var_c6f1111a5e4efeb7, groupname, var_6fc7cc4b942e69c4 );
    }
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) )
        {
            self.cache enablescriptableplayeruse( player );
        }
    }
    
    self.traptriggered = 1;
    thread dmztask_playsound( self.cache.origin, teamname );
    dmz_task_utils::function_864f8eee2e38c55a( "dmz_global_trap_start", teamname );
    dmz_audio::function_32ff837bc21a4833( teamname, "dmz_trap_drill", 1.5, "dmz_trap_drill_classic" );
    self.agents = [];
    self.shownplayers = [];
    self.progress = 0;
    
    while ( true )
    {
        if ( isdefined( self.cache.trigger ) && !self.cache.trigger.trigger_off )
        {
            if ( self.nearbyplayers.size > 0 )
            {
                progressbefore = self.progress;
                self.progress = min( self.capturetime, self.progress + level.framedurationseconds );
            }
            
            progress = self.progress / self.capturetime;
            
            if ( self.progress >= self.capturetime )
            {
                function_935227f29a717369();
                return;
            }
            else if ( !self.cache.ignorefortress )
            {
                self.shownplayers = function_ec6036aef78df06( self.nearbyplayers, self.shownplayers );
                objidpoolmanager::objective_set_progress( self.icon, progress );
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_5ab652de57e3c043
// Params 0
// Checksum 0x3e5e7b2c, Offset: 0x1bfd
// Size: 0x16a
function function_935227f29a717369()
{
    self notify( #"cache_unlocked" );
    self.cache setscriptablepartstate( "dmz_secret_stash", "opening" );
    
    if ( !self.cache.ignorefortress )
    {
        foreach ( player in self.shownplayers )
        {
            if ( isdefined( player ) )
            {
                objidpoolmanager::function_6ac40386d1cd0d9a( self.icon, player );
            }
        }
        
        objidpoolmanager::objective_playermask_hidefromall( self.icon );
        objective_setshowprogress( self.icon, 0 );
        var_538dbfbe5d7a73c6 = arraycombineunique( teams::getteamdata( self.teams[ 0 ], "players" ), self.nearbyplayers );
        utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"trap_unlocked", var_538dbfbe5d7a73c6 );
        self.fortress.tacmapscriptable setscriptablepartstate( "fortress_tacmap_location_scriptable", "visible", 0 );
        function_1a5bf3eacefaa718( self.teams[ 0 ] );
    }
}

// Namespace namespace_5ab652de57e3c043
// Params 2
// Checksum 0x9819c012, Offset: 0x1d6f
// Size: 0x188
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
            if ( objidpoolmanager::function_72efeaceb614613a( self.icon, player, 2, 2, &"mp_dmz_missions/stash_drill_progress_title" ) )
            {
                objidpoolmanager::objective_pin_player( self.icon, player );
                objidpoolmanager::objective_playermask_addshowplayer( self.icon, player );
                var_153d7595b0bea5fd[ var_153d7595b0bea5fd.size ] = player;
            }
            
            continue;
        }
        
        if ( arraycontains( shownplayers, player ) && !arraycontains( nearbyplayers, player ) )
        {
            if ( self.teams[ 0 ] != player.team || self.complete )
            {
                objidpoolmanager::objective_playermask_hidefrom( self.icon, player );
            }
            
            objidpoolmanager::objective_unpin_player( self.icon, player );
            objidpoolmanager::function_6ac40386d1cd0d9a( self.icon, player );
            var_153d7595b0bea5fd = arrayremove( var_153d7595b0bea5fd, player );
        }
    }
    
    return var_153d7595b0bea5fd;
}

// Namespace namespace_5ab652de57e3c043
// Params 2, eflags: 0x4
// Checksum 0x8bd91dcc, Offset: 0x1f00
// Size: 0x51
function private dmztask_playsound( location, teamname )
{
    wait randomintrange( 2, 4 );
    playsoundatpos( location, "mp_dmz_alrm_trap" );
    wait 3;
    utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"trap_start_unlock", teamname );
}

// Namespace namespace_5ab652de57e3c043
// Params 1, eflags: 0x4
// Checksum 0x7e988bdb, Offset: 0x1f59
// Size: 0x9d
function private function_55e1b6dd263e8cd4( nodes )
{
    wait 45;
    
    for ( i = 0; i < 2 ; i++ )
    {
        foreach ( node in nodes )
        {
            thread function_1c1d2ec4d381b3af( node );
        }
        
        wait 30;
    }
}

// Namespace namespace_5ab652de57e3c043
// Params 1
// Checksum 0xaa9d1245, Offset: 0x1ffe
// Size: 0x59
function function_1c1d2ec4d381b3af( node )
{
    wait randomfloatrange( 0, 2 );
    magicgrenademanual( "smoke_grenade_mp", node.outerorigin, ( 0, 0, -10 ), 0.5 );
    thread utility::play_sound_in_space( "smoke_grenade_expl_trans", node.outerorigin );
}

// Namespace namespace_5ab652de57e3c043
// Params 1, eflags: 0x4
// Checksum 0x7740c945, Offset: 0x205f
// Size: 0x7c
function private function_45a18cd8d6e613c2( doors )
{
    foreach ( door in doors )
    {
        door scriptabledoorunlock();
    }
}

// Namespace namespace_5ab652de57e3c043
// Params 4, eflags: 0x4
// Checksum 0x11bc76dd, Offset: 0x20e3
// Size: 0xde
function private function_f878c15b4b7f297( location, numagents, groupname, spawnboss )
{
    level endon( #"game_ended" );
    agents = [];
    agentpackage = ai_reinforcements::function_c6a741f41aaede19( numagents, level.spawnset[ "guard" ], 1 );
    agentpackage.reinforcementtype = "Helicopter";
    
    while ( !isdefined( agents ) || agents.size == 0 )
    {
        agents = ai_reinforcements::reinforce_requestreinforcements( numagents, location, "high", "mission", "trapWave1", groupname, undefined, 1, self.node.script_poi, undefined, undefined, undefined, agentpackage );
        
        if ( isdefined( agents ) && agents.size != 0 )
        {
            break;
        }
        
        wait 1;
    }
    
    self.var_529464ef996d020f = agents;
}

// Namespace namespace_5ab652de57e3c043
// Params 1
// Checksum 0x895cf981, Offset: 0x21c9
// Size: 0x78
function dmztask_setupsecondwaveagent( agent )
{
    weapon = weapon::buildweapon( "iw9_ar_mike4_mp", [ "laserbox_hip04", "none", "none", "none", "silencer01_ar", "none" ], "camo_none", "none" );
    agent agent_utils::overrideagentsettings( undefined, undefined, weapon, "smoke_grenade_mp", 5 );
}

// Namespace namespace_5ab652de57e3c043
// Params 4, eflags: 0x4
// Checksum 0xc41601d0, Offset: 0x2249
// Size: 0x16c
function private function_42f838a7c2d01137( location, numagents, groupname, spawnboss )
{
    level endon( #"game_ended" );
    wait 15;
    agents = [];
    agentpackage = ai_reinforcements::function_c6a741f41aaede19( numagents, level.spawnset[ "guard" ], 2 );
    agentpackage.reinforcementtype = "Helicopter";
    
    while ( !isdefined( agents ) || agents.size == 0 )
    {
        agents = ai_reinforcements::reinforce_requestreinforcements( numagents, location, "high", "mission", "trapWave2", groupname, undefined, 0, self.node.script_poi, undefined, undefined, undefined, agentpackage );
        
        if ( isdefined( agents ) && agents.size != 0 )
        {
            break;
        }
        
        wait 1;
    }
    
    self.var_cacd0510ab1ee442 = agents;
    
    foreach ( agent in agents )
    {
        agent_utils::function_3d1ccb7ed2f7c332( agent, "dmzTask_setupSecondWaveAgent", &dmztask_setupsecondwaveagent );
        
        if ( isagent( agent ) )
        {
            dmztask_setupsecondwaveagent( agent );
        }
    }
}

// Namespace namespace_5ab652de57e3c043
// Params 1
// Checksum 0x4418fc7c, Offset: 0x23bd
// Size: 0x78
function dmztask_setupthirdwaveagent( agent )
{
    weapon = weapon::buildweapon( "iw9_ar_mike4_mp", [ "laserbox_hip04", "none", "none", "none", "silencer01_ar", "none" ], "camo_none", "none" );
    agent agent_utils::overrideagentsettings( undefined, undefined, weapon, "smoke_grenade_mp", 5 );
}

// Namespace namespace_5ab652de57e3c043
// Params 4, eflags: 0x4
// Checksum 0x5bcee1d9, Offset: 0x243d
// Size: 0x16c
function private function_d814bbbc3791ddde( location, numagents, groupname, spawnboss )
{
    level endon( #"game_ended" );
    wait 35;
    agents = [];
    agentpackage = ai_reinforcements::function_c6a741f41aaede19( numagents, level.spawnset[ "guard" ], 3 );
    agentpackage.reinforcementtype = "Helicopter";
    
    while ( !isdefined( agents ) || agents.size == 0 )
    {
        agents = ai_reinforcements::reinforce_requestreinforcements( numagents, location, "high", "mission", "trapWave3", groupname, undefined, 0, self.node.script_poi, undefined, undefined, undefined, agentpackage );
        
        if ( isdefined( agents ) && agents.size != 0 )
        {
            break;
        }
        
        wait 1;
    }
    
    self.var_fff34a29787e12b5 = agents;
    
    foreach ( agent in agents )
    {
        agent_utils::function_3d1ccb7ed2f7c332( agent, "dmzTask_setupThirdWaveAgent", &dmztask_setupthirdwaveagent );
        
        if ( isagent( agent ) )
        {
            dmztask_setupthirdwaveagent( agent );
        }
    }
}

// Namespace namespace_5ab652de57e3c043
// Params 3, eflags: 0x4
// Checksum 0x88d3cf1c, Offset: 0x25b1
// Size: 0x113
function private function_20c569fa1dd171c7( agents, location, spawnboss )
{
    spawnboss = !isdefined( spawnboss ) || spawnboss;
    
    foreach ( agent in agents )
    {
        if ( !isdefined( agent ) )
        {
            continue;
        }
        
        if ( spawnboss )
        {
            if ( isagent( agent ) )
            {
                dmztask_overrideboss( agent );
            }
            
            agent_utils::function_3d1ccb7ed2f7c332( agent, "dmzTask_overrideBoss", &dmztask_overrideboss );
            spawnboss = 0;
        }
        else
        {
            if ( isagent( agent ) )
            {
                dmztask_overridereinforcementagent( agent );
            }
            
            agent_utils::function_3d1ccb7ed2f7c332( agent, "dmzTask_overrideReinforcementAgent", &dmztask_overridereinforcementagent );
        }
        
        thread ai_behavior::behavior_combatRushOrigin( agent, location );
        self.agents[ self.agents.size ] = agent;
    }
}

// Namespace namespace_5ab652de57e3c043
// Params 2, eflags: 0x4
// Checksum 0xfedc74b6, Offset: 0x26cc
// Size: 0xeb, Type: bool
function private function_85e3720368b4a105( a, b )
{
    amindist = 1000000;
    bmindist = 1000000;
    
    foreach ( player in level.players )
    {
        amindist = min( amindist, distance( player.origin, a.origin ) );
        bmindist = min( bmindist, distance( player.origin, b.origin ) );
    }
    
    return amindist > bmindist;
}

// Namespace namespace_5ab652de57e3c043
// Params 3, eflags: 0x4
// Checksum 0x26cb78a9, Offset: 0x27c0
// Size: 0x52
function private function_b834e0d4e71f6809( location, spawnnum, var_a7da2694cd2ed1ed )
{
    angle = spawnnum / var_a7da2694cd2ed1ed * 360;
    return ( location[ 0 ] + cos( angle ) * 25, location[ 1 ] + sin( angle ) * 25, location[ 2 ] );
}

// Namespace namespace_5ab652de57e3c043
// Params 1, eflags: 0x4
// Checksum 0xeb409cc4, Offset: 0x281b
// Size: 0xa1
function private function_38a879cc5c114bc2( fortress )
{
    locations = [];
    
    foreach ( node in fortress.lockeddoors )
    {
        if ( !node.doubledoor )
        {
            locations[ locations.size ] = node;
        }
    }
    
    return locations;
}

// Namespace namespace_5ab652de57e3c043
// Params 1
// Checksum 0xfa4f6e64, Offset: 0x28c5
// Size: 0x93
function dmztask_overridereinforcementagent( agent )
{
    weapon = utility::array_random( [ "brloot_weapon_sm_uzulu_epic", "brloot_weapon_ar_mike4_rare" ] );
    agent agent_utils::overrideagentsettings( "body_mp_eastern_nikto_2_1", "head_mp_eastern_nikto_3_1", level.br_lootiteminfo[ weapon ].fullweaponobj, "smoke_grenade_mp" );
    
    if ( randomfloat( 1 ) > 0.3 )
    {
        agent.shoulddropweapon = 0;
    }
    
    if ( randomfloat( 1 ) > 0 )
    {
        agent.dropbackpack = 0;
    }
}

// Namespace namespace_5ab652de57e3c043
// Params 1
// Checksum 0xc0fc1d14, Offset: 0x2960
// Size: 0x86
function dmztask_overrideboss( agent )
{
    weapon = utility::array_random( [ "brloot_weapon_sm_uzulu_epic", "brloot_weapon_ar_mike4_rare" ] );
    agent agent_utils::overrideagentsettings( undefined, undefined, level.br_lootiteminfo[ weapon ].fullweaponobj );
    
    if ( randomfloat( 1 ) > 0.3 )
    {
        agent.shoulddropweapon = 0;
    }
    
    if ( randomfloat( 1 ) > 0 )
    {
        agent.dropbackpack = 0;
    }
}

// Namespace namespace_5ab652de57e3c043
// Params 2
// Checksum 0xf4740742, Offset: 0x29ee
// Size: 0xe1
function dmztask_watchtrigger( trigger, radius )
{
    level endon( #"game_ended" );
    self endon( #"cache_unlocked" );
    self.nearbyplayers = [];
    self.capturingteams = [];
    
    while ( true )
    {
        trigger waittill( #"trigger", player );
        
        if ( !isplayer( player ) || arraycontains( self.nearbyplayers, player ) )
        {
            continue;
        }
        
        if ( !arraycontains( self.capturingteams, player.team ) )
        {
            self.capturingteams[ self.capturingteams.size ] = player.team;
        }
        
        self.nearbyplayers[ self.nearbyplayers.size ] = player;
        thread function_e2d1dbaa4958de61( trigger, player, radius );
    }
}

// Namespace namespace_5ab652de57e3c043
// Params 3
// Checksum 0xc7c35edf, Offset: 0x2ad7
// Size: 0x84
function function_e2d1dbaa4958de61( trigger, player, radius )
{
    while ( isalive( player ) && isdefined( self.cache.trigger ) && distance( trigger.origin, player.origin ) < radius + 100 )
    {
        wait 0.2;
    }
    
    self.nearbyplayers = arrayremove( self.nearbyplayers, player );
}

// Namespace namespace_5ab652de57e3c043
// Params 2
// Checksum 0x209ce7c, Offset: 0x2b63
// Size: 0x9d
function play_spotrep_capture_sfx( progress, team )
{
    if ( !isdefined( self.lastsfxplayedtime ) )
    {
        self.lastsfxplayedtime = gettime();
    }
    
    if ( self.lastsfxplayedtime + 995 < gettime() )
    {
        self.lastsfxplayedtime = gettime();
        var_8eb35fb703d61a67 = "";
        progress = int( floor( progress * 10 ) );
        
        if ( getprojectname() == "T10" )
        {
            var_8eb35fb703d61a67 = "uin_cer_cappoint_tick_0" + progress;
        }
        else
        {
            var_8eb35fb703d61a67 = "mp_dom_capturing_tick_0" + progress;
        }
        
        self playsoundtoteam( var_8eb35fb703d61a67, team );
    }
}

/#

    // Namespace namespace_5ab652de57e3c043
    // Params 0
    // Checksum 0x6a5685a1, Offset: 0x2c08
    // Size: 0x144, Type: dev
    function function_8db3a73579062e2e()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_3f7460cd0a96699d", 0 ) )
            {
                setdvar( @"hash_3f7460cd0a96699d", 0 );
                player = level.players[ 0 ];
                node = spawnstruct();
                node.origin = player.origin + anglestoforward( player.angles ) * 100;
                node.angles = player.angles;
                task = spawnstruct();
                task.node = node;
                task.activity = spawnstruct();
                task.activity.cashreward = 50;
                task function_66a3bf6d5ef41988();
                task.cache.ignorefortress = 1;
                task.capturetime = level.trapprops.capturetime;
                task.cache setscriptablepartstate( "<dev string:x24>", "<dev string:x58>" );
                task.cache enablescriptableplayeruse( player );
            }
            
            waitframe();
        }
    }

#/
