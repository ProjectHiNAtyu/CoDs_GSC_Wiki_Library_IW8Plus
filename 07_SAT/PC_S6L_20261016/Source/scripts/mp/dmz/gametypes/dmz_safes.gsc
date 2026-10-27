// scripts\mp\dmz\gametypes\dmz_safes.gsc  (hash_5999909e6e379c3a.gscc) (size: 14492 Bytes / 0x389c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xce115fb5 (3457245109)
// size ...... 14492 (0x389c)
// includes .. 28  (offset: 0x3404)
// strings ... 57  (offset: 0x34e4)
// dev strs .. 5   (offset: 0x3830)
// exports ... 20  (offset: 0x21fc)
// cseg ...... 0x48e + 0x1d6e (0x21fc)
// imports ... 125 (offset: 0x251c)
// animtree1 . 1   (offset: 0x3870)
// animtree2 . 2   (offset: 0x387c)
#using script_599653855a4317f1;
#using scripts\common\callbacks;
#using scripts\common\script;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_fortress;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\ai_reinforcements;
#using scripts\mp\anim;
#using scripts\mp\br\gametypes\br_dmz_extract;
#using scripts\mp\br\gametypes\br_dmz_radiation;
#using scripts\mp\br\gametypes\br_gametype_dmz;
#using scripts\mp\br\gametypes\br_instance_inventory;
#using scripts\mp\common\utility\infilexfil;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\dmz\gametypes\dmz_audio;
#using scripts\mp\flags;
#using scripts\mp\gameobjects;
#using scripts\mp\hud_message;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item_database;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\poi;

#namespace dmz_safes;

// Namespace dmz_safes
// Params 0
// Checksum 0xf2503a9f, Offset: 0x4ac
// Size: 0x417
function initsafes()
{
    scriptable::scriptable_addusedcallbackbypart( "safe", &function_b64bb003b8330715 );
    script_model_anims();
    level.safeprops = spawnstruct();
    level.safeprops.enablesafes = getdvarint( @"scr_dmz_safe_enabled", 1 );
    level.safeprops.var_af8aaff88ef89a1b = getdvarint( @"hash_4ae9be8b66f04d02", 0 );
    level.safeprops.var_6803a28acbb52a49 = getdvarint( @"hash_20ad09d3184793f8", 2 );
    level.safeprops.capturetime = getdvarint( @"scr_dmz_safe_capture_time", 75 );
    level.safeprops.captureradius = getdvarint( @"scr_dmz_safe_capture_radius", 800 );
    level.safeprops.revealradius = getdvarint( @"hash_e5c47808565489f1", 24000 );
    level.safeprops.revealradiussq = level.safeprops.revealradius * level.safeprops.revealradius;
    level.safeprops.revealmin = getdvarint( @"hash_d0b1d795f6610eb5", 4 );
    level.safeprops.revealmax = getdvarint( @"hash_d0d4c195f687260b", 5 );
    level.safeprops.hideicons = getdvarint( @"hash_d8c8e09d145b3aa", 1 );
    level.safeprops.enabledefenders = getdvarint( @"hash_fe63eef908e3ebd7", 0 );
    
    if ( !level.safeprops.enablesafes )
    {
        return;
    }
    
    while ( !( isdefined( level.struct_class_names ) && isdefined( level.aibudgets ) ) || function_7c7f41d3fd5028a5( "everybody" ) <= 0 )
    {
        waitframe();
    }
    
    flags::function_2f3408423ccc9b2e( "radiation_initialized" );
    safelocations = utility::getstructarray( "dmz_safe", "script_noteworthy" );
    validlocations = [];
    
    foreach ( safelocation in safelocations )
    {
        fortress = ai_fortress::function_386da8b7d1afe346( safelocation.origin );
        
        if ( !isdefined( fortress ) && poi::poi_ispoiactive( safelocation.script_poi ) && !br_dmz_radiation::radiation_isinradiation( safelocation.origin ) )
        {
            if ( !isdefined( validlocations[ safelocation.script_poi ] ) )
            {
                validlocations[ safelocation.script_poi ] = [];
            }
            
            validlocations[ safelocation.script_poi ][ validlocations[ safelocation.script_poi ].size ] = safelocation;
        }
    }
    
    level.safes = [];
    
    foreach ( arr in validlocations )
    {
        numtospawn = min( randomintrange( level.safeprops.var_af8aaff88ef89a1b, level.safeprops.var_6803a28acbb52a49 + 1 ), arr.size );
        locs = arrayrandomize( arr );
        
        for ( nodeidx = 0; nodeidx < numtospawn ; nodeidx++ )
        {
            function_7bc9699baa708b2c( locs[ nodeidx ] );
        }
    }
    
    /#
        thread debug_safes();
    #/
}

// Namespace dmz_safes
// Params 2
// Checksum 0x7fd37cb3, Offset: 0x8cb
// Size: 0x365
function function_7bc9699baa708b2c( node, forcedlootid )
{
    if ( !isdefined( node ) )
    {
        return;
    }
    
    /#
        dmz_logging::addlogevent( "<dev string:x24>", "<dev string:x35>", undefined, "<dev string:x41>", undefined, undefined, node.script_poi, node.origin );
    #/
    
    var_72911a7432604ae1 = "dmz_safe";
    
    if ( isdefined( level.var_1d7793fe9e9bbaac ) )
    {
        var_72911a7432604ae1 = [[ level.var_1d7793fe9e9bbaac ]]( node );
    }
    
    safe = spawnscriptable( var_72911a7432604ae1, node.origin, node.angles );
    safe.var_5a4d5180ea13e4ed = 1;
    safe.curorigin = safe.origin;
    safe.offset3d = ( 0, 0, 15 );
    safe gameobjects::requestid( 1, 0, undefined, 1 );
    objid = safe.objidnum;
    objidpoolmanager::update_objective_icon( objid, "ui_map_icon_safe" );
    objidpoolmanager::update_objective_setbackground( objid, 1 );
    objidpoolmanager::update_objective_setzoffset( objid, 15 );
    objidpoolmanager::update_objective_position( objid, safe.origin + ( 0, 0, 15 ) );
    objidpoolmanager::objective_pin_global( objid, 1 );
    objidpoolmanager::function_586b631e7bbb592a( objid, 1 );
    objidpoolmanager::objective_set_play_intro( objid, 0 );
    
    if ( level.safeprops.hideicons )
    {
        objidpoolmanager::function_eb808b97701a4793( objid );
    }
    else
    {
        objidpoolmanager::function_6dfdf7da8037a1ee( objid );
    }
    
    objidpoolmanager::function_daf59ee8ea2cb071( objid );
    safe.node = node;
    node.safe = safe;
    safe setscriptablepartstate( "safe", "usable_not_open" );
    
    if ( isdefined( forcedlootid ) )
    {
        items = getscriptablelootcachecontents( safe );
        common_cache::function_a09e7cf5bad99b64( safe, items );
        itembundlename = common_item_database::function_db2360bc1c33f6f9( forcedlootid );
        
        if ( isdefined( itembundlename ) )
        {
            common_cache::cache_additem( safe, itembundlename, 1 );
        }
        
        safe.contents = arrayrandomize( safe.contents );
    }
    
    /#
        dmz_logging::addlogevent( "<dev string:x4a>", "<dev string:x35>", undefined, "<dev string:x57>", undefined, undefined, node.script_poi, node.origin );
    #/
    
    safe.trigger = spawn( "trigger_radius", safe.node.origin, 0, int( level.safeprops.captureradius ), int( level.safeprops.captureradius ) );
    safe.trigger utility::trigger_off();
    safe.capturetime = level.safeprops.capturetime;
    safe.revealedteams = [];
    
    if ( level.safeprops.enabledefenders )
    {
        safe function_2e1b492595a096dd( 2 );
    }
    
    safe thread function_7f2498e71b0e60fd( safe.trigger, level.safeprops.captureradius );
    level.safes[ level.safes.size ] = safe;
    safe.onclosedcallback = &function_9cb5799511a36d6a;
    return safe;
}

// Namespace dmz_safes
// Params 2, eflags: 0x4
// Checksum 0x720169bd, Offset: 0xc39
// Size: 0x47
function private function_9cb5799511a36d6a( container, player )
{
    if ( !( isdefined( container ) && isdefined( player ) ) )
    {
        return;
    }
    
    if ( container getscriptableparthasstate( "safe", "open_usable" ) )
    {
        container setscriptablepartstate( "safe", "open_usable" );
    }
}

// Namespace dmz_safes
// Params 1, eflags: 0x4
// Checksum 0xb6d8e1a9, Offset: 0xc88
// Size: 0x30
function private function_31989a54ae845c73( teamname )
{
    if ( self.unlocked )
    {
        return;
    }
    
    self notify( #"safe_unlocked" );
    self.unlocked = 1;
}

// Namespace dmz_safes
// Params 6, eflags: 0x4
// Checksum 0xae66ce67, Offset: 0xcc0
// Size: 0x2e0
function private function_b64bb003b8330715( instance, part, state, player, bautouse, usestring )
{
    if ( !isdefined( player.team ) )
    {
        return;
    }
    
    if ( isdefined( instance.overrideusecallback ) )
    {
        self [[ instance.overrideusecallback ]]( instance, part, state, player, bautouse, usestring );
        return;
    }
    
    if ( !safe_canuse( player ) )
    {
        player hud_message::showerrormessage( level.br_pickups.var_9d247aba85e39454 );
        return;
    }
    
    if ( state == "usable_not_open" )
    {
        if ( function_d252c42754bf9d99( instance, part, state, player ) )
        {
            instance.teams = [ player.team ];
            instance.trigger utility::trigger_on();
            br_dmz_extract::function_83a0b4b45262d77c( player.team, "dmz_mission_safe_opening" );
            dmz_audio::function_32ff837bc21a4833( player.team, "dmz_trap_drill", 0.5, "dmz_trap_drill_classic" );
            objidpoolmanager::update_objective_state( instance.objidnum, "current" );
            objidpoolmanager::objective_show_progress( instance.objidnum, 1 );
            objidpoolmanager::objective_teammask_addtomask( instance.objidnum, player.team );
            instance thread function_e3c86bdf8c768930();
            wait 1;
            br_gametype_dmz::showdmzsplash( "dmz_safe_defend_started", teams::getteamdata( player.team, "players" ), instance.node.script_poi );
        }
        else
        {
            instance setscriptablepartstate( part, "usable_not_open" );
        }
        
        return;
    }
    
    if ( state == "open_usable" )
    {
        if ( instance getscriptableparthasstate( "safe", "unusable" ) )
        {
            instance setscriptablepartstate( "safe", "unusable" );
        }
        
        if ( !isdefined( instance.contents ) )
        {
            script::demoforcesre( "Removed br_lootcache function getContentsWithAdditionalUpgradeItems here." );
            items = getscriptablelootcachecontents( instance );
            itembundles = [];
            
            foreach ( item in items )
            {
                itembundlename = common_item_database::function_ca9ca606e66b5911( item );
                itembundles[ itembundles.size ] = itembundlename;
            }
            
            instance.containertype = 4;
            common_cache::function_a09e7cf5bad99b64( instance, itembundles, 1 );
            instance function_31989a54ae845c73( player.team );
        }
        
        common_cache::function_60ce579fa7d3b6da( instance, part, state, player, bautouse, usestring );
    }
}

// Namespace dmz_safes
// Params 4
// Checksum 0x24959e03, Offset: 0xfa8
// Size: 0x62, Type: bool
function function_d252c42754bf9d99( safe, part, state, player )
{
    safe setscriptablepartstate( part, "unusable" );
    safe.successfuluse = 0;
    safe thread function_d369e14e462e6113( player );
    safe function_f2cbcef06349c1f6( player, part );
    return istrue( safe.successfuluse );
}

// Namespace dmz_safes
// Params 1, eflags: 0x4
// Checksum 0xe63e01ff, Offset: 0x1013
// Size: 0x209
function private function_2e1b492595a096dd( var_1a81764900af82ee )
{
    self.agents = [];
    aitype = ai_mp_controller::function_b86341658788836c( undefined, undefined, undefined, "short_range", undefined, 2 );
    forwarddist = anglestoforward( self.angles ) * 80;
    origin = getclosestpointonnavmesh( self.origin + forwarddist );
    agent = ai_mp_controller::ai_mp_requestspawnagent( aitype, origin, self.angles, "high", "mission", "safeInitialGuards", undefined, undefined, undefined, self.node.script_poi, 0, undefined, 1 );
    
    if ( isdefined( agent ) )
    {
        self.agents[ 0 ] = agent;
        thread ai_behavior::behavior_GuardStationary( agent, 0 );
    }
    
    for ( i = 0; i < var_1a81764900af82ee ; i++ )
    {
        aitype = ai_mp_controller::function_b86341658788836c( undefined, undefined, undefined, "short_range" );
        var_48897c2c41f79f8 = randomfloatrange( 144, 360 );
        forward = anglestoforward( self.angles ) * var_48897c2c41f79f8;
        right = vectorcross( ( 0, 0, 1 ), forward );
        facingangle = axistoangles( forward, right, ( 0, 0, 1 ) );
        rotationangle = i / var_1a81764900af82ee * 360 + randomfloatrange( -30, 30 ) % 360;
        offset = rotatepointaroundvector( ( 0, 0, 1 ), forward, rotationangle );
        origin = getclosestpointonnavmesh( self.origin + offset );
        agent = ai_mp_controller::ai_mp_requestspawnagent( aitype, origin, facingangle, "high", "mission", "safe", undefined, undefined, undefined, self.node.script_poi, 0, undefined, 0 );
        
        if ( isdefined( agent ) )
        {
            self.agents[ self.agents.size ] = agent;
            thread ai_behavior::behavior_GuardStationary( agent );
        }
    }
}

// Namespace dmz_safes
// Params 0, eflags: 0x4
// Checksum 0xefe44341, Offset: 0x1224
// Size: 0x308
function private function_e3c86bdf8c768930()
{
    level endon( #"game_ended" );
    self endon( #"safe_unlocked" );
    self.progress = 0;
    var_1eda12d2d7580054 = 0;
    var_34b5ad0f0ab2605f = undefined;
    intervalindex = 0;
    alertradius = 512;
    helicalled = 0;
    shownplayers = [];
    
    while ( true )
    {
        if ( isdefined( self.trigger ) && !self.trigger.trigger_off )
        {
            if ( !isdefined( var_34b5ad0f0ab2605f ) )
            {
                var_34b5ad0f0ab2605f = [ 0, self.capturetime / 4, self.capturetime / 2, self.capturetime / 100 * 75 ];
            }
            
            if ( self.nearbyplayers.size > 0 )
            {
                self.progress = min( self.capturetime, self.progress + level.framedurationseconds );
            }
            else
            {
                self.progress = max( 0, self.progress - level.framedurationseconds * 0.5 );
            }
            
            progress = self.progress / self.capturetime;
            shownplayers = function_1cb2f2a03dcd9bbb( self.nearbyplayers, shownplayers, progress );
            objidpoolmanager::objective_set_progress( self.objidnum, progress );
            
            if ( self.progress >= self.capturetime )
            {
                function_ad822ac4e07d48bd();
                
                if ( isdefined( level.var_ad822ac4e07d48bd ) )
                {
                    self [[ level.var_ad822ac4e07d48bd ]]();
                }
            }
            else if ( level.safeprops.enabledefenders && self.nearbyplayers.size > 0 && isdefined( var_34b5ad0f0ab2605f[ intervalindex ] ) && self.progress >= var_34b5ad0f0ab2605f[ intervalindex ] )
            {
                intervalindex++;
                alertradius += 768;
                
                if ( alertradius > 2816 )
                {
                    alertradius = 2816;
                }
                
                agents = ai_reinforcements::function_d0a9530035c6dc35( self.origin, alertradius, undefined, 3, undefined, 64, 128 );
                
                if ( isdefined( agents ) )
                {
                    self.agents = arraycombine( self.agents, agents );
                    var_1eda12d2d7580054 += agents.size;
                }
                
                if ( !helicalled && intervalindex == 1 && var_1eda12d2d7580054 < 4 )
                {
                    heliagents = ai_reinforcements::reinforce_requestreinforcements( 5, self.origin, "high", "mission", "safeReinforcements", undefined, undefined, 1, self.node.script_poi, "Helicopter", 32, 64 );
                    
                    if ( isdefined( heliagents ) && heliagents.size > 0 )
                    {
                        helicalled = 1;
                        self.agents = arraycombine( self.agents, heliagents );
                    }
                }
            }
            else if ( self.nearbyplayers.size == 0 && intervalindex > 0 )
            {
                intervalindex = 0;
                alertradius = 512;
            }
        }
        
        waitframe();
    }
}

// Namespace dmz_safes
// Params 3, eflags: 0x4
// Checksum 0x4a05f917, Offset: 0x1534
// Size: 0x180
function private function_1cb2f2a03dcd9bbb( nearbyplayers, shownplayers, progress )
{
    allplayers = arraycombine( nearbyplayers, shownplayers );
    var_153d7595b0bea5fd = shownplayers;
    
    foreach ( player in allplayers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( isdefined( player.team ) && !arraycontains( self.teams, player.team ) )
        {
            self.teams[ self.teams.size ] = player.team;
        }
        
        if ( !arraycontains( shownplayers, player ) && arraycontains( nearbyplayers, player ) )
        {
            if ( objidpoolmanager::function_72efeaceb614613a( self.objidnum, player, 1, 2, &"mp_dmz_missions/opening_safe" ) )
            {
                objidpoolmanager::objective_playermask_addshowplayer( self.objidnum, player );
                var_153d7595b0bea5fd[ var_153d7595b0bea5fd.size ] = player;
            }
            
            continue;
        }
        
        if ( arraycontains( shownplayers, player ) && !arraycontains( nearbyplayers, player ) )
        {
            objidpoolmanager::function_6ac40386d1cd0d9a( self.objidnum, player );
            var_153d7595b0bea5fd = arrayremove( var_153d7595b0bea5fd, player );
        }
    }
    
    return var_153d7595b0bea5fd;
}

// Namespace dmz_safes
// Params 0, eflags: 0x4
// Checksum 0xf6879d12, Offset: 0x16bd
// Size: 0x1f8
function private function_ad822ac4e07d48bd()
{
    self.trigger delete();
    
    foreach ( team in self.teams )
    {
        foreach ( player in teams::getteamdata( team, "players" ) )
        {
            objidpoolmanager::objective_unpin_player( self.objidnum, player );
            objidpoolmanager::function_6ac40386d1cd0d9a( self.objidnum, player );
            
            if ( !isdefined( player.var_24ec7841475d2d88 ) )
            {
                player.var_24ec7841475d2d88 = 0;
            }
            
            player.var_24ec7841475d2d88++;
            player points::doscoreevent( #"dmz_safe_opened" );
        }
        
        br_gametype_dmz::showdmzsplash( "dmz_safe_defend_unlocked", teams::getteamdata( team, "players" ) );
        br_dmz_extract::function_83a0b4b45262d77c( team, "dmz_mission_safe_unlocked" );
        callback::callback( "team_engaged_activity", { #poi:self.node.script_poi, #iscompletion:1, #activityref:"safe", #team:team } );
        dmz_audio::function_32ff837bc21a4833( team, "", 1.5 );
    }
    
    self.opened = 1;
    gameobjects::releaseid();
    self setscriptablepartstate( "safe", "opening" );
}

// Namespace dmz_safes
// Params 2, eflags: 0x4
// Checksum 0xf05a9597, Offset: 0x18bd
// Size: 0xd7
function private function_7f2498e71b0e60fd( trigger, radius )
{
    level endon( #"game_ended" );
    self endon( #"safe_unlocked" );
    self.nearbyplayers = [];
    
    while ( true )
    {
        trigger waittill( #"trigger", player );
        
        if ( !isplayer( player ) || arraycontains( self.nearbyplayers, player ) )
        {
            continue;
        }
        
        if ( !arraycontains( self.teams, player.team ) )
        {
            self.teams[ self.teams.size ] = player.team;
        }
        
        self.nearbyplayers[ self.nearbyplayers.size ] = player;
        thread function_200af3825af2d750( trigger, player, radius );
    }
}

// Namespace dmz_safes
// Params 3, eflags: 0x4
// Checksum 0xb8115dfc, Offset: 0x199c
// Size: 0x7d
function private function_200af3825af2d750( trigger, player, radius )
{
    while ( isalive( player ) && isdefined( self.trigger ) && distance( trigger.origin, player.origin ) < radius * 1.2 )
    {
        wait 0.2;
    }
    
    self.nearbyplayers = arrayremove( self.nearbyplayers, player );
}

#using_animtree( "script_model" );

// Namespace dmz_safes
// Params 0
// Checksum 0xdaf7ec56, Offset: 0x1a21
// Size: 0xc6
function script_model_anims()
{
    level.scr_animtree[ "safe_drill_player" ] = #animtree;
    level.scr_anim[ "safe_drill_player" ][ "safedrill_enter" ] = %iw9_dmz_safedrill_enter_sdr;
    level.scr_eventanim[ "safe_drill_player" ][ "safedrill_enter" ] = %"safedrill_enter";
    level.scr_viewmodelanim[ "safe_drill_player" ][ "safedrill_enter" ] = "iw9_dmz_safedrill_enter_sdr";
    level.scr_anim[ "safe_drill_player" ][ "safedrill_exit" ] = %iw9_dmz_safedrill_exit_sdr;
    level.scr_eventanim[ "safe_drill_player" ][ "safedrill_exit" ] = %"safedrill_exit";
    level.scr_viewmodelanim[ "safe_drill_player" ][ "safedrill_exit" ] = "iw9_dmz_safedrill_exit_sdr";
}

// Namespace dmz_safes
// Params 2
// Checksum 0x1bd720b0, Offset: 0x1aef
// Size: 0x148
function function_c0786622eaa1eac1( isallowed, key = "drilling" )
{
    if ( !isallowed )
    {
        val::set( key, "allow_jump", 0 );
        val::set( key, "gesture", 0 );
        val::set( key, "melee", 0 );
        val::set( key, "mantle", 0 );
        val::set( key, "offhand_weapons", 0 );
        val::set( key, "allow_movement", 0 );
        val::set( key, "sprint", 0 );
        val::set( key, "fire", 0 );
        val::set( key, "reload", 0 );
        val::set( key, "weapon_pickup", 0 );
        val::set( key, "weapon_switch", 0 );
        val::set( key, "offhand_weapons", 0 );
        val::set( key, "execution_victim", 0 );
        val::set( key, "vehicle_use", 0 );
        val::set( key, "supers", 0 );
        val::set( key, "allow_toggle_third_person", 0 );
        self setclientomnvar( "ui_br_inventory_disabled", 1 );
        self function_60e112d2e106b00a();
        return;
    }
    
    val::reset_all( key );
    self setclientomnvar( "ui_br_inventory_disabled", 0 );
    self function_7d73d6786e51ae1f();
}

// Namespace dmz_safes
// Params 2
// Checksum 0xc3233198, Offset: 0x1c3f
// Size: 0x305
function function_f2cbcef06349c1f6( player, part )
{
    player endon( #"death_or_disconnect" );
    player endon( #"enter_live_ragdoll" );
    player endon( #"interact_interrupt" );
    player function_c0786622eaa1eac1( 0 );
    linkedparent = self.linkedparent;
    goalpos = self.origin + rotatevector( ( 50.586, -6.262, 0 ), self.angles );
    forward = ( 0, 0, 0 ) - anglestoforward( self.angles );
    up = ( 0, 0, 1 );
    right = vectorcross( forward, up );
    goalangles = axistoangles( forward, right, up );
    
    if ( !isdefined( linkedparent ) )
    {
        player.linktoent = player utility::spawn_tag_origin( player.origin, player.playerviewangles );
        player playerlinktodelta( player.linktoent, "tag_origin", 1, 0, 0, 30, 30, 0, 1 );
        player setstance( "stand" );
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
    }
    else
    {
        player setstance( "stand" );
        player inventory_utility::givegunlessweapon();
    }
    
    player setorigin( goalpos );
    player setplayerangles( goalangles );
    player thread infilexfil::infil_player_rig_updated( "safe_drill_player", player.origin, player.angles );
    player.player_rig showonlytoplayer( player );
    
    if ( isdefined( linkedparent ) )
    {
        player.player_rig linkto( linkedparent );
    }
    
    self setscriptablepartstate( part, "unusable_intro_drilling" );
    anim_mp::anim_player_solo( player, player.player_rig, "safedrill_enter" );
    
    if ( player::isreallyalive( player ) )
    {
        anim_mp::anim_player_solo( player, player.player_rig, "safedrill_exit" );
    }
    
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
            player function_c0786622eaa1eac1( 1 );
        }
    }
    
    self.successfuluse = 1;
}

// Namespace dmz_safes
// Params 1
// Checksum 0x1b7e1583, Offset: 0x1f4c
// Size: 0x8e
function function_d369e14e462e6113( player )
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
    player function_c0786622eaa1eac1( 1 );
}

// Namespace dmz_safes
// Params 2
// Checksum 0x899461ac, Offset: 0x1fe2
// Size: 0x185
function function_e9840b595c7ed453( team, origin )
{
    wait 4;
    poi = poi::function_c14b808f44505866( origin, 0, 0, 1 );
    br_gametype_dmz::showdmzsplash( "dmz_safes_revealed", teams::getteamdata( team, "players" ), poi );
    sorted = sortbydistance( level.safes, origin );
    numrevealed = 0;
    var_56b03e68224b204f = br_instance_inventory::function_f27d28bab3135f68( team, 21 );
    var_1538b34f610516cf = randomintrange( level.safeprops.revealmin, level.safeprops.revealmax + 1 ) + var_56b03e68224b204f;
    
    foreach ( safe in sorted )
    {
        if ( !safe.opened && !arraycontains( safe.revealedteams, team ) )
        {
            objidpoolmanager::objective_teammask_addtomask( safe.objidnum, team );
            safe.revealedteams[ safe.revealedteams.size ] = team;
            numrevealed++;
            
            if ( numrevealed >= var_1538b34f610516cf )
            {
                break;
            }
        }
    }
}

// Namespace dmz_safes
// Params 1, eflags: 0x4
// Checksum 0x20e66c04, Offset: 0x216f
// Size: 0x25, Type: bool
function private safe_canuse( player )
{
    if ( isdefined( player ) && player.carryinghostage )
    {
        return false;
    }
    
    return true;
}

/#

    // Namespace dmz_safes
    // Params 0, eflags: 0x4
    // Checksum 0x96c138ce, Offset: 0x219d
    // Size: 0x5f, Type: dev
    function private debug_safes()
    {
        while ( true )
        {
            if ( getdvarint( @"scr_reveal_safes", 0 ) )
            {
                setdvar( @"scr_reveal_safes", 0 );
                thread function_e9840b595c7ed453( level.players[ 0 ].team, level.players[ 0 ].origin );
            }
            
            waitframe();
        }
    }

#/
