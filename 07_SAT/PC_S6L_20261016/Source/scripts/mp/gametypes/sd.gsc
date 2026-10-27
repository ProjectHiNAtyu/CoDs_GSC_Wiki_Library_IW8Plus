// scripts\mp\gametypes\sd.gsc  (hash_7188dbfe03e45511.gscc) (size: 42114 Bytes / 0xa482 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x622953c0 (1646875584)
// size ...... 42114 (0xa482)
// includes .. 40  (offset: 0x9846)
// strings ... 137 (offset: 0x9986)
// dev strs .. 14  (offset: 0xa3d2)
// exports ... 64  (offset: 0x67d6)
// cseg ...... 0xa0d + 0x5dc9 (0x67d6)
// imports ... 299 (offset: 0x71d6)
// animtree1 . 0   (offset: 0xa482)
// animtree2 . 0   (offset: 0xa482)
#using script_5acfd9b1af0b41bc;
#using scripts\common\callback_sequence;
#using scripts\common\callbacks;
#using scripts\common\game_utility;
#using scripts\common\gameplay_sound_fx;
#using scripts\common\utility;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\class;
#using scripts\mp\codcaster_utils;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\common\gameobjects\gameobjects_common;
#using scripts\mp\common\gameobjects\gameobjects_shared;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\dialog_utility;
#using scripts\mp\common\utility\dvars;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\events;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\obj_bombzone;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\matchdata;
#using scripts\mp\objectiveiconstates;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\persistence;
#using scripts\mp\playerlogic;
#using scripts\mp\potg_events;
#using scripts\mp\rank;
#using scripts\mp\spawnlogic;
#using scripts\mp\spectating;

#namespace sd;

// Namespace sd
// Params 0
// Checksum 0x1e119229, Offset: 0xa2b
// Size: 0x5ca
function main()
{
    if ( getdvar( @"g_mapname" ) == "mp_background" )
    {
        return;
    }
    
    globallogic::init();
    globallogic::setupcallbacks();
    level.initializematchrules = &initializematchrules;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    updategametypedvars();
    
    if ( isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        init_struct_bomb = { #manual_drop:1, #var_7f4958ce4e4277c3:#"hash_bb332da19f9944df", #capture_segment_count:1, #var_333d3689d793bcc7:0, #use_time_seconds:0, #var_c68e9f43ed9cc918:#"hash_a1360b18943e920", #var_d7c90dc73c1dcba8:( 0, 0, 0 ), #objective_icon_offset:( 0, 0, 0 ), #angles:( 0, 0, 0 ), #origin:( 0, 0, 0 ) };
        init_struct_bomb.var_c68e9f43ed9cc918 = #"hash_7118f9343873352b";
        init_struct_planting = { #manual_drop:1, #var_7f4958ce4e4277c3:#"hash_bb332da19f9944df", #capture_segment_count:1, #var_333d3689d793bcc7:0, #use_time_seconds:0, #var_c68e9f43ed9cc918:#"hash_a1360b18943e920", #var_d7c90dc73c1dcba8:( 0, 0, 0 ), #objective_icon_offset:( 0, 0, 0 ), #angles:( 0, 0, 0 ), #origin:( 0, 0, 0 ) };
        init_struct_planting.var_c68e9f43ed9cc918 = #"hash_7118f9343873352b";
        init_struct_planting.use_time_seconds = level.planttime;
        init_struct_defusing = { #manual_drop:1, #var_7f4958ce4e4277c3:#"hash_bb332da19f9944df", #capture_segment_count:1, #var_333d3689d793bcc7:0, #use_time_seconds:0, #var_c68e9f43ed9cc918:#"hash_a1360b18943e920", #var_d7c90dc73c1dcba8:( 0, 0, 0 ), #objective_icon_offset:( 0, 0, 0 ), #angles:( 0, 0, 0 ), #origin:( 0, 0, 0 ) };
        init_struct_defusing.var_c68e9f43ed9cc918 = #"hash_ce911e3bbe99421f";
        init_struct_defusing.use_time_seconds = level.defusetime;
        
        if ( !level.multibomb )
        {
            gameobjects_common::function_22117b1fd559026f( #"sdbomb", init_struct_bomb, &function_57fa74559eb4820d );
        }
        
        gameobjects_common::function_22117b1fd559026f( #"sdbombzone_planting", init_struct_planting, &function_2284a3946b80b6a5 );
        gameobjects_common::function_22117b1fd559026f( #"sdbombzone_defusing", init_struct_defusing, &function_6230b6aba2d3268b );
    }
    else
    {
        var_958812bec5c7f6ab = [];
        var_958812bec5c7f6ab[ var_958812bec5c7f6ab.size ] = game_utility_mp::getbasegametype();
        var_958812bec5c7f6ab[ var_958812bec5c7f6ab.size ] = "bombzone";
        var_958812bec5c7f6ab[ var_958812bec5c7f6ab.size ] = "bombzone_defusing";
        var_958812bec5c7f6ab[ var_958812bec5c7f6ab.size ] = "bombzone_planting";
        var_958812bec5c7f6ab[ var_958812bec5c7f6ab.size ] = "blocker";
        game_utility_mp::clean_up_entities( var_958812bec5c7f6ab );
    }
    
    callback::add( #"player_spawned", &onspawnplayer );
    callback::add( #"player_death", &onplayerkilled );
    callback::add( #"hash_244314ef9125e636", &function_a1cc25aa44ac1669 );
    callback::add( #"hash_89e109eb26a160ed", &function_f3a8689e0f98f3d7 );
    callback::add( #"hash_2a6553431436974f", &function_4c9dd25d05697cad );
    level.objectivebased = 1;
    level.teambased = 1;
    level.nobuddyspawns = 1;
    level.onstartgametype = &onstartgametype;
    level.getspawnpoint = &getspawnpoint;
    level.ondeadevent = &ondeadevent;
    level.ononeleftevent = &ononeleftevent;
    level.ontimelimit = &ontimelimit;
    level.onnormaldeath = &onnormaldeath;
    level.gamemodemaydropweapon = &game_utility_mp::isplayeroutsideofanybombsite;
    level.onobjectivecomplete = &onbombexploded;
    level.resetuiomnvargamemode = &obj_bombzone::resetuiomnvargamemode;
    level.onmaprestart = &onmaprestart;
    level.var_59abd25eeb5b2fed = &function_18b964d931602c7a;
    level.var_40cd999d911308e0 = &game_utility_mp::function_587ce2553bfdb756;
    level.var_e16ef107a3dd572b = &game_utility_mp::function_50204bc2d6eb5ee9;
    level.allowlatecomers = 0;
    level.bombsplanted = 0;
    level.aplanted = 0;
    level.bplanted = 0;
    level.cplanted = 0;
    setomnvar( "ui_bomb_timer_endtime_a", 0 );
    setomnvar( "ui_bomb_timer_endtime_b", 0 );
    setomnvar( "ui_bomb_timer_endtime_c", 0 );
    setomnvar( "ui_bomb_planted_a", 0 );
    setomnvar( "ui_bomb_planted_b", 0 );
    setomnvar( "ui_bomb_planted_c", 0 );
    setomnvar( "ui_bomb_interacting", 0 );
    setomnvar( "ui_num_dom_flags", 2 );
    level.nosuspensemusic = 1;
    
    if ( level.gametypebundle.var_cf3caeb3605d04c2 )
    {
        level.var_68d6dd209dfdc9 = 1;
    }
    
    if ( level.gametypebundle.threebombsites )
    {
        level.var_e81cb6d160fcc7a3 = 1;
    }
    
    /#
        setdevdvarifuninitialized( @"hash_3f3a15fb7e7c9b0", 0 );
        level thread obj_bombzone::function_cbff563b60d3e7cf();
        level thread obj_bombzone::function_b82862df868dcf76();
    #/
}

// Namespace sd
// Params 0, eflags: 0x4
// Checksum 0x8facfa, Offset: 0xffd
// Size: 0x144
function private initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
    setdynamicdvar( dvars::function_1165fde71640a2d1( "bombTimer" ), getmatchrulesdata( "bombData", "bombTimer" ) );
    setdynamicdvar( dvars::function_1165fde71640a2d1( "plantTime" ), getmatchrulesdata( "bombData", "plantTime" ) );
    setdynamicdvar( dvars::function_1165fde71640a2d1( "defuseTime" ), getmatchrulesdata( "bombData", "defuseTime" ) );
    setdynamicdvar( dvars::function_1165fde71640a2d1( "multiBomb" ), getmatchrulesdata( "bombData", "multiBomb" ) );
    setdynamicdvar( dvars::function_1165fde71640a2d1( "silentPlant" ), getmatchrulesdata( "bombData", "silentPlant" ) );
    setdynamicdvar( dvars::function_1165fde71640a2d1( "resetProgress" ), getmatchrulesdata( "bombData", "resetProgress" ) );
    setdynamicdvar( dvars::function_1165fde71640a2d1( "defendersCanSeeDroppedBomb" ), getmatchrulesdata( "bombData", "defendersCanSeeDroppedBomb" ) );
    setdynamicdvar( dvars::function_1165fde71640a2d1( "defendersCanSeePlantedBomb" ), getmatchrulesdata( "bombData", "defendersCanSeePlantedBomb" ) );
    setdynamicdvar( dvars::function_1165fde71640a2d1( "assignBombZoneChevrons" ), getmatchrulesdata( "bombData", "assignBombZoneChevrons" ) );
    setdynamicdvar( dvars::function_1165fde71640a2d1( "manualDropEnabled" ), getmatchrulesdata( "carryData", "manualDropEnabled" ) );
    setdynamicdvar( @"scr_sd_promode", 0 );
}

// Namespace sd
// Params 0, eflags: 0x4
// Checksum 0xfc3d17c3, Offset: 0x1149
// Size: 0x3f
function private waittooverridegraceperiod()
{
    if ( game_utility_mp::isteamreviveenabled() || game_utility_mp::islaststandenabled() )
    {
        game[ "dialog" ][ "gametype" ] = "gametype_sandrescue";
    }
    
    flags::gameflagwait( "prematch_done" );
    level.overrideingraceperiod = 1;
}

// Namespace sd
// Params 0, eflags: 0x4
// Checksum 0x22d522fe, Offset: 0x1190
// Size: 0x63d
function private onstartgametype()
{
    setomnvar( "ui_victory_condition_completed", 0 );
    var_110f46860f2c391c = getdvarint( @"hash_7dfc9d99d9c1ff2f", 0 );
    
    if ( var_110f46860f2c391c && game[ "gameStateRestore" ].enabled )
    {
        level.roundlimit = getmatchrulesdata( "commonOption", "roundLimit" );
        
        if ( game[ "roundsPlayed" ] >= level.roundlimit - 1 )
        {
            defending_team = game[ "defenders" ];
            attacking_team = game[ "attackers" ];
            
            if ( !isdefined( game[ "match_kills" ] ) )
            {
                game[ "match_kills" ][ defending_team ] = 0;
                game[ "match_kills" ][ attacking_team ] = 0;
            }
            
            if ( !isdefined( game[ "match_deaths" ] ) )
            {
                game[ "match_deaths" ][ defending_team ] = 0;
                game[ "match_deaths" ][ attacking_team ] = 0;
            }
            
            aheadteam = "allies";
            
            if ( game[ "match_kills" ][ defending_team ] == game[ "match_kills" ][ attacking_team ] )
            {
                if ( game[ "match_deaths" ][ defending_team ] == game[ "match_deaths" ][ attacking_team ] )
                {
                    randomidx = randomint( level.teamnamelist.size );
                    aheadteam = level.teamnamelist[ randomidx ];
                }
                else if ( game[ "match_deaths" ][ defending_team ] > game[ "match_deaths" ][ attacking_team ] )
                {
                    aheadteam = defending_team;
                }
                else
                {
                    aheadteam = attacking_team;
                }
            }
            else if ( game[ "match_kills" ][ defending_team ] > game[ "match_kills" ][ attacking_team ] )
            {
                aheadteam = defending_team;
            }
            else
            {
                aheadteam = attacking_team;
            }
            
            if ( aheadteam != game[ "defenders" ] )
            {
                game[ "switchedsides" ] = 1;
                level.switchedsides = 1;
            }
            else
            {
                level.switchedsides = undefined;
            }
        }
    }
    
    if ( !isdefined( game[ "switchedsides" ] ) )
    {
        game[ "switchedsides" ] = 0;
    }
    
    if ( game[ "switchedsides" ] )
    {
        oldattackers = game[ "attackers" ];
        olddefenders = game[ "defenders" ];
        game[ "attackers" ] = olddefenders;
        game[ "defenders" ] = oldattackers;
        
        if ( utility::issharedfuncdefined( #"hash_e8cc48aecfa87408", #"hash_b776eca92041054b" ) )
        {
            utility::callsharedfunc( #"hash_e8cc48aecfa87408", #"hash_b776eca92041054b" );
        }
    }
    
    level.var_7b282ffc18c488c[ game[ "attackers" ] ] = 0;
    level.var_7b282ffc18c488c[ game[ "defenders" ] ] = 0;
    setclientnamemode( "manual_change" );
    level._effect[ "bomb_explosion" ] = loadfxasset( level.gametypebundle.var_302226c389c82a9a ?? "vfx_iw9_dmz_bombsite_explo" );
    level._effect[ "vehicle_explosion" ] = loadfxasset( "vfx_core_explo_small_vehicle_new" );
    level._effect[ "building_explosion" ] = loadfxasset( "vfx_iw7_requests_mp_debug_warning" );
    game_utility_mp::setobjectivetext( game[ "attackers" ], &"objectives/sd_attacker" );
    game_utility_mp::setobjectivetext( game[ "defenders" ], &"objectives/sd_defender" );
    
    if ( level.splitscreen )
    {
        game_utility_mp::setobjectivescoretext( game[ "attackers" ], &"objectives/sd_attacker" );
        game_utility_mp::setobjectivescoretext( game[ "defenders" ], &"objectives/sd_defender" );
    }
    else
    {
        game_utility_mp::setobjectivescoretext( game[ "attackers" ], &"objectives/sd_attacker_score" );
        game_utility_mp::setobjectivescoretext( game[ "defenders" ], &"objectives/sd_defender_score" );
    }
    
    game_utility_mp::setobjectivehinttext( game[ "attackers" ], &"objectives/sd_attacker_hint" );
    game_utility_mp::setobjectivehinttext( game[ "defenders" ], &"objectives/sd_defender_hint" );
    initspawns();
    thread waittooverridegraceperiod();
    setspecialloadout();
    setomnvar( "ui_allies_no_respawn", 0 );
    setomnvar( "ui_axis_no_respawn", 0 );
    
    if ( isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        if ( istrue( level.game_objects.var_5f329cd264226f08 ) )
        {
            utility::flag_wait( "cs_gameobjects_constructed" );
        }
        else
        {
            utility::flag_wait( "gameobject_system_post_init" );
            function_bf70e8e73e6ea0dc();
            waitframe();
        }
        
        bomb_plant_weapon_ref = common::get_gametype_asset( #"bomb_plant_weapon" );
        bomb_defuse_weapon_ref = common::get_gametype_asset( #"bomb_defuse_weapon" );
        bombzone_scriptable_ref = common::get_gametype_asset( #"bombzone_scriptable" );
        
        foreach ( sd_bombzone_struct in level.var_a5888fa23974f461 )
        {
            var_e5e9b2d488ed113 = sd_bombzone_struct.planting;
            var_8bb4439dc05d7221 = sd_bombzone_struct.defusing;
            var_57e217cafb730cb = gameobjects_common::get_origin( var_e5e9b2d488ed113 );
            var_445bed1a80eddd45 = gameobjects_common::function_63e25df7cfbb206f( var_e5e9b2d488ed113 );
            bombzone_scriptable_spawn_origin = utility::drop_to_ground( var_57e217cafb730cb, 64, -1024 );
            var_e5e9b2d488ed113.scriptable = spawnscriptable( bombzone_scriptable_ref, bombzone_scriptable_spawn_origin, var_445bed1a80eddd45 );
            
            /#
                assert( var_e5e9b2d488ed113.scriptable getscriptablehaspart( #"explosion" ), "<dev string:x24>" );
                assert( var_e5e9b2d488ed113.scriptable getscriptableparthasstate( #"explosion", #"trigger" ), "<dev string:x53>" );
            #/
            
            var_8bb4439dc05d7221.objective_id = var_e5e9b2d488ed113.objective_id;
            var_8bb4439dc05d7221.scriptable = var_e5e9b2d488ed113.scriptable;
            bombzone::initialize_bombzone( var_e5e9b2d488ed113, var_8bb4439dc05d7221, level.sdbomb, bomb_plant_weapon_ref, bomb_defuse_weapon_ref );
        }
        
        level.var_a5888fa23974f461 = undefined;
        callback::add( #"hash_4b88ae7136a85bfd", &on_bomb_planted );
        callback::add( #"hash_e19a9f3d97f3e18f", &on_bomb_defused );
        callback::add( #"hash_3a1fe5e4df493585", &on_bomb_detonated );
        return;
    }
    
    thread bombs();
}

// Namespace sd
// Params 0, eflags: 0x4
// Checksum 0x3dc95d76, Offset: 0x17d5
// Size: 0xdd
function private initspawns()
{
    spawnlogic::function_6dbabb72223a4bca();
    spawnkey = spawnlogic::function_d5c160a4110b573e();
    
    if ( spawnlogic::function_5cf82e30c52a895d( spawnkey ) )
    {
        spawnlogic::function_3a25709674572ad6( #"start", #"primary_attackers", spawnkey, spawnlogic::function_61ba521db28762a7(), game[ "attackers" ] );
        spawnlogic::function_3a25709674572ad6( #"start", #"primary_defenders", spawnkey, spawnlogic::function_3a5e3efa19e5df47(), game[ "defenders" ] );
    }
    else if ( level.var_39c50be9fa888ea8 )
    {
    }
    else
    {
        spawnlogic::function_9bd2654564d3372d( #"start", #"start_attackers", "mp_sd_spawn_attacker", game[ "attackers" ], 1 );
        spawnlogic::function_9bd2654564d3372d( #"start", #"start_defenders", "mp_sd_spawn_defender", game[ "defenders" ], 1 );
    }
    
    spawnlogic::finalizemap();
}

// Namespace sd
// Params 0, eflags: 0x4
// Checksum 0xfa3184bf, Offset: 0x18ba
// Size: 0x32
function private getspawnpoint()
{
    spawnlogic::setactivespawnlogic( #"start" );
    return spawnlogic::getspawnpoint( self, self.pers[ "team" ], #"start", undefined );
}

// Namespace sd
// Params 1, eflags: 0x4
// Checksum 0x304b9b78, Offset: 0x18f5
// Size: 0x252
function private onspawnplayer( spawndata )
{
    hud_message::function_ef4318a0090caa0f( #"hide_match_hint" );
    
    if ( game_utility_common::isgameparticipant( self ) )
    {
        self.isplanting = 0;
        self.isdefusing = 0;
        self.isbombcarrier = 0;
        self.laststanding = 0;
    }
    
    self setclientomnvar( "ui_hud_carried_item_index", 0 );
    
    if ( level.multibomb && self.pers[ "team" ] == game[ "attackers" ] )
    {
        self setclientomnvar( "ui_hud_carried_item_count", 1 );
        self setclientomnvar( "ui_carrying_bomb", 1 );
    }
    else
    {
        self setclientomnvar( "ui_hud_carried_item_count", 0 );
        self setclientomnvar( "ui_carrying_bomb", 0 );
        
        if ( !isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
        {
            foreach ( bombzone in level.objectives )
            {
                bombzone.trigger disableplayeruse( self );
            }
        }
    }
    
    stats::setextrascore0( self.pers[ "plants" ] ?? 0, "plants" );
    stats::setextrascore1( self.pers[ "defuses" ] ?? 0, "defuses" );
    stats::setextrascore2( self.pers[ "extrascore2" ] ?? 0, "objectivekills" );
    
    if ( utility::issharedfuncdefined( #"hash_e8cc48aecfa87408", #"hash_c8be764db647145" ) )
    {
        utility::callsharedfunc( #"hash_e8cc48aecfa87408", #"hash_c8be764db647145" );
    }
    
    level notify( #"spawned_player" );
    
    if ( !isdefined( level.var_7b282ffc18c488c[ self.team ] ) )
    {
        level.var_7b282ffc18c488c[ self.team ] = 0;
    }
    
    level.var_7b282ffc18c488c[ self.team ] += 1;
    thread updatematchstatushintonspawn();
}

// Namespace sd
// Params 1, eflags: 0x4
// Checksum 0x43665ae8, Offset: 0x1b4f
// Size: 0x1e0
function private onplayerkilled( deathdata )
{
    attacker = deathdata.attacker;
    self setclientomnvar( "ui_hud_carried_item_count", 0 );
    self setclientomnvar( "ui_carrying_bomb", 0 );
    
    if ( !isdefined( level.generalkillcount ) )
    {
        codcasterclientmatchdata::function_8ecc753b54a5740f( 7, 1 );
        level.generalkillcount = 0;
    }
    
    if ( isdefined( attacker.team ) && attacker.team != self.team )
    {
        if ( level.generalkillcount == 0 )
        {
            attacker codcasterclientmatchdata::function_8ecc753b54a5740f( 4, 1 );
        }
        
        level.generalkillcount += 1;
        function_76669980c7140d84( attacker.team, 1 );
    }
    
    foreach ( bombzone in level.objectives )
    {
        if ( isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
        {
            var_3585c67984f0d918 = gameobjects_common::function_8a27a916a385b65c( bombzone, attacker );
            var_9b43c11c6592a807 = gameobjects_common::function_8a27a916a385b65c( bombzone, self );
        }
        
        if ( !isdefined( var_3585c67984f0d918 ) )
        {
            var_3585c67984f0d918 = attacker istouching( bombzone.trigger );
        }
        
        if ( !isdefined( var_9b43c11c6592a807 ) )
        {
            var_9b43c11c6592a807 = self istouching( bombzone.trigger );
        }
        
        if ( var_3585c67984f0d918 || var_9b43c11c6592a807 )
        {
            attacker stats::setextrascore2( attacker.pers[ "extrascore2" ] + 1 );
            break;
        }
    }
    
    thread checkallowspectating();
}

// Namespace sd
// Params 0, eflags: 0x4
// Checksum 0x3802c830, Offset: 0x1d37
// Size: 0x8c
function private checkallowspectating()
{
    waitframe();
    update = 0;
    
    if ( !teams::getteamdata( game[ "attackers" ], "aliveCount" ) )
    {
        level.spectateoverride[ game[ "attackers" ] ].allowenemyspectate = 1;
        update = 1;
    }
    
    if ( !teams::getteamdata( game[ "defenders" ], "aliveCount" ) )
    {
        level.spectateoverride[ game[ "defenders" ] ].allowenemyspectate = 1;
        update = 1;
    }
    
    if ( update )
    {
        spectating::updatespectatesettings();
    }
}

// Namespace sd
// Params 2, eflags: 0x4
// Checksum 0xff24a00e, Offset: 0x1dcb
// Size: 0x228
function private endgame( winningteam, endreasontext )
{
    setomnvarforallclients( "ui_objective_pinned_text_param", 0 );
    setomnvar( "ui_bomb_interacting", 0 );
    losingteam = winningteam == game[ "attackers" ] ? game[ "defenders" ] : game[ "attackers" ];
    
    if ( utility::issharedfuncdefined( #"hash_e8cc48aecfa87408", #"hash_1915d23d5da44ae9" ) )
    {
        utility::callsharedfunc( #"hash_e8cc48aecfa87408", #"hash_1915d23d5da44ae9", winningteam, losingteam );
    }
    
    level thread events::function_8a990b3daa34d46a( winningteam, losingteam );
    thread gamelogic_mp::endgame( winningteam, endreasontext );
    matchtimems = matchdata::function_47550968a937b67e( gettime() );
    
    if ( isdefined( level.sdbomb.carrier ) )
    {
        level.sdbomb.carrier dlog_recordplayerevent( "dlog_event_mp_objective_link_player", [ "key", "bomb", "is_linked", 0, "match_time_ms", matchtimems ] );
    }
    
    if ( !level.bombplanted )
    {
        dlog_recordevent( "dlog_event_mp_objective_status", [ "key", "bomb", "match_time_ms", matchtimems, "is_active", 0 ] );
    }
    
    foreach ( bombzone in level.objectives )
    {
        dlog_recordevent( "dlog_event_mp_objective_status", [ "key", bombzone.objectivekey, "match_time_ms", matchtimems, "is_active", 0 ] );
    }
    
    if ( flags::gameflagexists( "bombZones_ready" ) )
    {
        flags::gameflagclear( "bombZones_ready" );
    }
}

// Namespace sd
// Params 0, eflags: 0x4
// Checksum 0xc51f5a78, Offset: 0x1ffb
// Size: 0xa7
function private interruptbombplanting()
{
    foreach ( player in level.players )
    {
        if ( player.isplanting && isdefined( player.lastnonuseweapon ) )
        {
            player inventory_utility::_switchtoweaponimmediate( player.lastnonuseweapon );
            break;
        }
    }
}

// Namespace sd
// Params 1, eflags: 0x4
// Checksum 0x88232afd, Offset: 0x20aa
// Size: 0x1d9
function private ondeadevent( team )
{
    interruptbombplanting();
    
    if ( level.bombexploded > 0 || level.bombdefused )
    {
        return;
    }
    
    if ( team == "all" )
    {
        if ( level.bombplanted )
        {
            endgame( game[ "attackers" ], game[ "end_reason" ][ "mp_faction_eliminated" ] );
        }
        else
        {
            endgame( game[ "defenders" ], game[ "end_reason" ][ "mp_faction_eliminated" ] );
        }
    }
    else if ( team == game[ "attackers" ] )
    {
        if ( level.bombplanted )
        {
            dialog::statusdialog( "defend_enemydead_bomb", game[ "defenders" ], "status" );
            return;
        }
        else
        {
            dialog::statusdialog( "defend_enemydead_nobomb", game[ "defenders" ], "status" );
        }
        
        level thread endgame( game[ "defenders" ], game[ "end_reason" ][ "mp_faction_eliminated" ] );
    }
    else if ( team == game[ "defenders" ] )
    {
        dialog::statusdialog( "planting_enemy_dead", game[ "attackers" ], "status" );
        level thread endgame( game[ "attackers" ], game[ "end_reason" ][ "mp_faction_eliminated" ] );
        level.var_f49b7901d4911e49 = 1;
    }
    
    if ( isdefined( self.attacker ) && self != self.attacker )
    {
        var_48a2d9ab992de11e = 1;
        attackerteam = self.attacker.team;
        
        if ( team == "all" )
        {
            if ( level.bombplanted )
            {
                if ( attackerteam == game[ "defenders" ] )
                {
                    var_48a2d9ab992de11e = 0;
                }
            }
            else if ( attackerteam == game[ "attackers" ] )
            {
                var_48a2d9ab992de11e = 0;
            }
        }
        
        if ( var_48a2d9ab992de11e )
        {
            self.attacker thread points::doscoreevent( #"hash_e35b1029889d836c" );
        }
    }
}

// Namespace sd
// Params 1, eflags: 0x4
// Checksum 0x13a89576, Offset: 0x228b
// Size: 0x58
function private ononeleftevent( team )
{
    if ( level.bombexploded > 0 || level.bombdefused )
    {
        return;
    }
    
    lastplayer = game_utility_mp::getlastlivingplayer( team );
    
    if ( lastplayer )
    {
        lastplayer.laststanding = 1;
        lastplayer thread givelastonteamwarning();
    }
}

// Namespace sd
// Params 1, eflags: 0x4
// Checksum 0x484360a4, Offset: 0x22eb
// Size: 0x3be
function private function_a1cc25aa44ac1669( deathdata )
{
    attacker = deathdata.attacker;
    victim = deathdata.victim;
    killid = deathdata.lifeid;
    gaveaward = 0;
    
    if ( attacker.team == victim.team )
    {
        return;
    }
    
    if ( !isdefined( attacker.var_6d89c2f8dc182811 ) )
    {
        attacker.var_6d89c2f8dc182811 = 0;
    }
    
    attacker.var_6d89c2f8dc182811++;
    
    if ( attacker.var_6d89c2f8dc182811 == level.var_7b282ffc18c488c[ victim.team ] && attacker.var_6d89c2f8dc182811 >= 4 )
    {
        attacker thread points::doscoreevent( #"snd_ace" );
        attacker.var_7562b3a264775d5c = 1;
    }
    
    if ( victim.isplanting )
    {
        attacker thread events::function_1aa2f7550e20dc20();
        gaveaward = 1;
    }
    else if ( victim.isdefusing )
    {
        attacker thread events::function_7993ea01a4c8736b();
        gaveaward = 1;
    }
    
    livingenemies = game_utility_mp::getlivingplayers( victim.team );
    
    if ( livingenemies.size < 3 )
    {
        if ( !isdefined( attacker.jokerkillcount ) )
        {
            attacker.jokerkillcount = 0;
        }
        
        attacker.jokerkillcount++;
        
        if ( livingenemies.size == 0 && attacker.jokerkillcount == 3 )
        {
            attacker thread points::doscoreevent( #"mode_sd_control_joker" );
        }
    }
    
    if ( isdefined( level.sdbomb.carrier ) )
    {
        if ( isplayer( attacker ) && attacker.pers[ "team" ] != victim.pers[ "team" ] )
        {
            if ( attacker.pers[ "team" ] == level.sdbomb.carrier.team && attacker != level.sdbomb.carrier )
            {
                var_56aca49aacdd2f85 = distancesquared( level.sdbomb.carrier.origin, attacker.origin );
                
                if ( var_56aca49aacdd2f85 < 105625 )
                {
                    attacker thread rank::function_d2aa8986c506e985( #"defend" );
                    attacker events::function_20a5f572df6afd43();
                    
                    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
                    {
                        if ( isdefined( attacker.leaderboarddata[ "defends" ] ) )
                        {
                            attacker.leaderboarddata[ "defends" ] = attacker.leaderboarddata[ "defends" ] + 1;
                        }
                        
                        if ( isdefined( level.leaderboardfunc[ "defends" ] ) )
                        {
                            [[ level.leaderboardfunc[ "defends" ] ]]( attacker, 1 );
                        }
                        
                        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x87>" );
                        
                        if ( isdefined( attacker.pers[ "defends" ] ) )
                        {
                            attacker.pers[ "defends" ] = attacker.pers[ "defends" ] + 1;
                        }
                    }
                    
                    attacker persistence::statsetchild( "round", "defends", attacker.pers[ "defends" ] );
                    thread utility::trycall( level.matchdata_logvictimkillevent, killid, "defending" );
                    gaveaward = 1;
                }
            }
        }
    }
    
    if ( !gaveaward )
    {
        obj_bombzone::bombzone_awardgenericbombzonemedals( attacker, victim );
    }
}

// Namespace sd
// Params 6, eflags: 0x4
// Checksum 0x7868545e, Offset: 0x26b1
// Size: 0x30c
function private onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    common::oncommonnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon );
    
    if ( attacker.laststanding )
    {
        attacker thread points::function_aa3f27bc29d005fc( #"hash_4bc4aed7d23221b3" );
    }
    
    if ( attacker != victim )
    {
        events::function_f49e24ff9e0db53d( attacker, victim );
    }
    
    if ( victim.isplanting )
    {
        setomnvar( "ui_bomb_interacting", 0 );
        thread utility::trycall( level.matchdata_logvictimkillevent, lifeid, "planting" );
        
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
        {
            if ( isdefined( attacker.leaderboarddata[ "defends" ] ) )
            {
                attacker.leaderboarddata[ "defends" ] = attacker.leaderboarddata[ "defends" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "defends" ] ) )
            {
                [[ level.leaderboardfunc[ "defends" ] ]]( attacker, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x87>" );
            
            if ( isdefined( attacker.pers[ "defends" ] ) )
            {
                attacker.pers[ "defends" ] = attacker.pers[ "defends" ] + 1;
            }
        }
        
        attacker persistence::statsetchild( "round", "defends", attacker.pers[ "defends" ] );
        return;
    }
    
    if ( victim.isbombcarrier )
    {
        thread utility::trycall( level.matchdata_logvictimkillevent, lifeid, "carrying" );
        return;
    }
    
    if ( victim.isdefusing )
    {
        setomnvar( "ui_bomb_interacting", 0 );
        thread utility::trycall( level.matchdata_logvictimkillevent, lifeid, "defusing" );
        
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
        {
            if ( isdefined( attacker.leaderboarddata[ "defends" ] ) )
            {
                attacker.leaderboarddata[ "defends" ] = attacker.leaderboarddata[ "defends" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "defends" ] ) )
            {
                [[ level.leaderboardfunc[ "defends" ] ]]( attacker, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x87>" );
            
            if ( isdefined( attacker.pers[ "defends" ] ) )
            {
                attacker.pers[ "defends" ] = attacker.pers[ "defends" ] + 1;
            }
        }
        
        attacker persistence::statsetchild( "round", "defends", attacker.pers[ "defends" ] );
    }
}

// Namespace sd
// Params 0, eflags: 0x4
// Checksum 0x3367bff4, Offset: 0x29c5
// Size: 0xa7
function private givelastonteamwarning()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    player::waittillrecoveredhealth( 3 );
    level thread battlechatter_mp::trysaylocalsound( self, #"bc_status_inform_last_one" );
    otherteam = team_utility::getotherteam( self.pers[ "team" ] );
    level thread hud_util::teamplayercardsplash( "last_teammate_alive_callout", self, self.pers[ "team" ] );
    level thread hud_util::teamplayercardsplash( "last_enemy_alive_callout", self, otherteam );
    level notify( #"last_alive", self );
    codcaster_utils::function_3038b6eafc46c037( 3, self.team, self getentitynumber() );
}

// Namespace sd
// Params 0, eflags: 0x4
// Checksum 0x9d057cdd, Offset: 0x2a74
// Size: 0xef
function private ontimelimit()
{
    if ( level.bombexploded > 0 || level.bombdefused )
    {
        return;
    }
    
    endgame( game[ "defenders" ], game[ "end_reason" ][ "time_limit_reached" ] );
    
    if ( !isdefined( level.var_d95b674c4a3e8f05 ) )
    {
        codcasterclientmatchdata::function_d6aea11d2e9ba521();
        level.var_d95b674c4a3e8f05 = 1;
    }
    
    foreach ( player in level.players )
    {
        if ( isdefined( player.bombplantweapon ) )
        {
            player inventory_utility::_takeweapon( player.bombplantweapon );
            break;
        }
    }
}

// Namespace sd
// Params 0, eflags: 0x4
// Checksum 0xb9b5d57, Offset: 0x2b6b
// Size: 0xe5
function private updategametypedvars()
{
    common::updatecommongametypedvars();
    level.bombtimer = dvars::dvarfloatvalue( "bombtimer", 45, 1, 240 );
    level.planttime = dvars::dvarfloatvalue( "planttime", 5, 0, 20 );
    level.defusetime = dvars::dvarfloatvalue( "defusetime", 5, 0, 20 );
    level.multibomb = dvars::dvarintvalue( "multibomb", 0, 0, 1 );
    level.silentplant = dvars::dvarintvalue( "silentPlant", 0, 0, 1 );
    level.resetprogress = dvars::dvarintvalue( "resetProgress", 0, 0, 1 );
    level.defenderscanseedroppedbomb = dvars::dvarintvalue( "defendersCanSeeDroppedBomb", 0, 0, 1 );
    level.defenderscanseeplantedbomb = dvars::dvarintvalue( "defendersCanSeePlantedBomb", 0, 0, 1 );
    level.assignbombzonechevrons = dvars::dvarintvalue( "assignBombZoneChevrons", 0, 0, 1 );
}

// Namespace sd
// Params 1
// Checksum 0xacfb5778, Offset: 0x2c58
// Size: 0x27f
function removebombzonec( bombzones )
{
    czones = [];
    brushmodels = getentarray( "script_brushmodel", #classname );
    
    foreach ( brushmodel in brushmodels )
    {
        if ( brushmodel.script_gameobjectname == "bombzone" )
        {
            foreach ( bombzone in bombzones )
            {
                if ( distance( brushmodel.origin, bombzone.origin ) < 100 && issubstr( tolower( bombzone.script_label ), "c" ) )
                {
                    bombzone.relatedbrushmodel = brushmodel;
                    czones[ czones.size ] = bombzone;
                    break;
                }
            }
        }
    }
    
    foreach ( czone in czones )
    {
        czone.relatedbrushmodel delete();
        visuals = getentarray( czone.target, #targetname );
        
        foreach ( visual in visuals )
        {
            visual delete();
        }
        
        czone delete();
    }
    
    return function_5713d46873b29625( bombzones );
}

// Namespace sd
// Params 1, eflags: 0x4
// Checksum 0x6224276e, Offset: 0x2ee0
// Size: 0xb6
function private function_34266ad1954c614a( triggers )
{
    brushmodels = getentarray( "script_brushmodel", #classname );
    
    foreach ( brushmodel in brushmodels )
    {
        if ( brushmodel.script_gameobjectname == "bombzone" )
        {
            brushmodel.override_unresolved_collision = &override_unresolved_collision;
        }
    }
}

// Namespace sd
// Params 2, eflags: 0x4
// Checksum 0xf5fc06f3, Offset: 0x2f9e
// Size: 0x89
function private override_unresolved_collision( player, ballowsuicide )
{
    /#
        var_798e62c5664f570f = 400;
        var_798e61c5664f54dc = 400;
        var_7525734f0aabb4b9 = "<dev string:xad>";
        color = ( 1, 1, 1 );
        scale = 2;
        duration = 180;
        printtoscreen2d( var_798e62c5664f570f, var_798e61c5664f54dc, var_7525734f0aabb4b9, color, scale, duration );
        println( var_7525734f0aabb4b9 );
    #/
}

// Namespace sd
// Params 0, eflags: 0x4
// Checksum 0x487bab4, Offset: 0x302f
// Size: 0xf0
function private function_7cc23e5246ea1f3f()
{
    if ( isdefined( level.var_3b3162c1b490db9e ) )
    {
        var_e53e378d4e6d4bc6 = utility::getstruct( level.var_3b3162c1b490db9e.str_sd_bombzone_a, "script_noteworthy" );
        var_e53e368d4e6d4993 = utility::getstruct( level.var_3b3162c1b490db9e.str_sd_bombzone_b, "script_noteworthy" );
    }
    else
    {
        var_e53e378d4e6d4bc6 = utility::getstruct( "sd_bombzone_a", "script_noteworthy" );
        var_e53e368d4e6d4993 = utility::getstruct( "sd_bombzone_b", "script_noteworthy" );
    }
    
    if ( isdefined( var_e53e378d4e6d4bc6 ) && isdefined( var_e53e368d4e6d4993 ) )
    {
        return [ [ utility::drop_to_ground( var_e53e378d4e6d4bc6.origin, 10, -100 ), var_e53e378d4e6d4bc6.angles ], [ utility::drop_to_ground( var_e53e368d4e6d4993.origin, 10, -100 ), var_e53e368d4e6d4993.angles ] ];
    }
}

// Namespace sd
// Params 0, eflags: 0x4
// Checksum 0x4cd1a9c7, Offset: 0x3127
// Size: 0xa89
function private bombs()
{
    if ( isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        return;
    }
    
    obj_bombzone::bombzone_setupbombcase( "sd_bomb" );
    assert( isdefined( level.sdbomb ), "<dev string:xf6>" );
    level.sdbomb.onpickup = &onbombpickup;
    triggers = getentarray( "bombzone", #targetname );
    function_34266ad1954c614a( triggers );
    
    if ( level.var_68d6dd209dfdc9 && getdvarint( @"hash_9ca179b07212d909", 0 ) == 0 )
    {
        var_2081db848bf062a6 = getentarray( "custombombzone", #script_noteworthy );
    }
    
    if ( level.var_68d6dd209dfdc9 && triggers.size != 0 && var_2081db848bf062a6.size > 0 )
    {
        var_baeed255607abc4b = triggers;
        
        foreach ( custombombzone in var_2081db848bf062a6 )
        {
            closestdistance = 100000;
            closestbombsite = undefined;
            
            foreach ( bombsite in var_baeed255607abc4b )
            {
                var_6507eee21b664a6d = distance( custombombzone.origin, bombsite.origin );
                
                if ( var_6507eee21b664a6d < closestdistance )
                {
                    closestbombsite = bombsite;
                }
            }
            
            if ( !isdefined( closestbombsite ) )
            {
                assertmsg( "<dev string:x11e>" + bombsite.script_label + "<dev string:x129>" );
            }
            
            custombombzone.closestbomb = closestbombsite;
            closestbombsite.custombombzone = custombombzone;
            var_baeed255607abc4b = arrayremove( var_baeed255607abc4b, closestbombsite );
        }
    }
    
    if ( isdefined( level.gametype ) && level.gametype != "sd" && !level.var_e81cb6d160fcc7a3 )
    {
        triggers = removebombzonec( triggers );
    }
    
    level.scriptedtriggers = 0;
    
    if ( triggers.size == 0 )
    {
        level.scriptedtriggers = 1;
        var_3b0faf57274b9e3a = utility::getstruct( "sd_bombzone_a", "script_noteworthy" );
        
        if ( isdefined( var_3b0faf57274b9e3a ) )
        {
            trigger = spawn( "script_model", utility::drop_to_ground( var_3b0faf57274b9e3a.origin, 10, -100 ) );
            trigger setmodel( "sd_equipment_bombsite_crate" );
            trigger.angles = var_3b0faf57274b9e3a.angles;
            trigger.objectivekey = "_a";
            trigger.iconname = "_a";
            trigger.usetype = 1;
            trigger.isuseobject = 1;
            triggers[ triggers.size ] = trigger;
        }
        
        var_3b0fae57274b9c07 = utility::getstruct( "sd_bombzone_b", "script_noteworthy" );
        
        if ( isdefined( var_3b0fae57274b9c07 ) )
        {
            trigger = spawn( "script_model", utility::drop_to_ground( var_3b0fae57274b9c07.origin, 10, -100 ) );
            trigger setmodel( "sd_equipment_bombsite_crate" );
            trigger.angles = var_3b0fae57274b9c07.angles;
            trigger.objectivekey = "_b";
            trigger.iconname = "_b";
            trigger.usetype = 1;
            trigger.isuseobject = 1;
            triggers[ triggers.size ] = trigger;
        }
    }
    
    level.objectives = [];
    overrideorigins = undefined;
    
    if ( !level.scriptedtriggers )
    {
        overrideorigins = function_7cc23e5246ea1f3f();
    }
    
    foreach ( count, trigger in triggers )
    {
        if ( isdefined( overrideorigins ) )
        {
            trigger.origin = overrideorigins[ count ][ 0 ];
            trigger.angles = overrideorigins[ count ][ 1 ];
        }
        
        bombzone = obj_bombzone::setupobjective( trigger, 1, 1 );
        bombzone.onbeginuse = &onbeginuse;
        bombzone.onenduse = &onenduse;
        bombzone.onuse = &onuseplantobject;
        
        if ( isdefined( level.gametypebundle.var_2e6e4faa3390de4b ) )
        {
            bombzone.visuals[ 0 ] setmodel( level.gametypebundle.var_2e6e4faa3390de4b );
        }
        
        if ( isdefined( overrideorigins ) )
        {
            foreach ( visual in bombzone.visuals )
            {
                visual.origin = overrideorigins[ count ][ 0 ];
                visual.angles = overrideorigins[ count ][ 1 ];
            }
        }
        
        assert( !isdefined( level.objectives[ bombzone.objectivekey ] ), "<dev string:x15e>" + trigger.script_label + "<dev string:x190>" );
        level.objectives[ bombzone.objectivekey ] = bombzone;
    }
    
    if ( !flags::gameflag( "prematch_done" ) )
    {
        level utility::waittill_any( "prematch_done", "start_mode_setup" );
    }
    
    if ( getdvarint( @"scr_sd_scriptable_bomb", 0 ) == 1 )
    {
        if ( game[ "attackers" ] == "allies" )
        {
            level.sdbomb.visuals[ 0 ].scriptable setscriptablepartstate( "bomb", "neutralAllies" );
        }
        else
        {
            level.sdbomb.visuals[ 0 ].scriptable setscriptablepartstate( "bomb", "neutralAxis" );
        }
    }
    
    if ( level.var_68d6dd209dfdc9 )
    {
        level.sdbomb gameobjects::requestid( 1, 1, 3 );
    }
    else
    {
        level.sdbomb gameobjects::requestid( 1, 1, 2 );
    }
    
    level.sdbomb gameobjects::setobjectivestatusicons( "waypoint_bomb" );
    
    if ( level.defenderscanseedroppedbomb )
    {
        level.sdbomb gameobjects::setvisibleteam( "any" );
    }
    else
    {
        level.sdbomb gameobjects::setvisibleteam( "friendly" );
    }
    
    level.sdbombmodel = level.sdbomb.visuals[ 0 ];
    level.sdbombmodel obj_bombzone::setteaminhuddatafromteamname( game[ "attackers" ] );
    level.sdbombmodel setasgametypeobjective();
    level.sdbomb.var_42985c35338e9b77 = 1;
    objective_setspecialobjectivedisplay( level.sdbomb.objidnum, 1 );
    objidpoolmanager::objective_set_play_intro( level.sdbomb.objidnum, 0 );
    objidpoolmanager::objective_set_play_outro( level.sdbomb.objidnum, 0 );
    level.sdbomb objidpoolmanager::function_e4d6a71507372662( level.sdbomb.objidnum, 0 );
    objective_setownerteam( level.sdbomb.objidnum, "neutral" );
    
    if ( getdvarint( @"hash_94706b5dc31f719b" ) != 0 )
    {
        level.sdbomb gameobjects::function_a8c99f0b8d97b750( [ level.sdbomb.visuals[ 0 ] ], level.sdbomb.trigger, 1, 80, 0, &function_d43144c15f06af73 );
    }
    
    if ( !flags::gameflag( "prematch_done" ) )
    {
        wait 0.5;
    }
    
    foreach ( bombzone in level.objectives )
    {
        reservedobjid = obj_bombzone::getreservedobjid( bombzone.objectivekey );
        bombzone gameobjects::requestid( 1, 1, reservedobjid );
        bombzone gameobjects::setobjectivestatusicons( "waypoint_defend", "waypoint_target" );
        bombzone gameobjects::setvisibleteam( "any" );
        matchtimems = matchdata::function_47550968a937b67e( gettime() );
        dlog_recordevent( "dlog_event_mp_objective_status", [ "key", bombzone.objectivekey, "match_time_ms", matchtimems, "is_active", 1 ] );
        dlog_recordevent( "dlog_event_mp_objective_move", [ "pos_x", bombzone.curorigin[ 0 ], "pos_y", bombzone.curorigin[ 1 ], "key", bombzone.objectivekey, "match_time_ms", matchtimems ] );
        dlog_recordevent( "dlog_event_mp_objective_ownership_changed", [ "key", bombzone.objectivekey, "team", "neutral", "match_time_ms", matchtimems ] );
    }
    
    flags::gameflaginit( "bombZones_ready", 0 );
    flags::gameflagset( "bombZones_ready" );
    gameplay_sound_fx::function_e319dc8e16c85fcb( #"hash_33dedc49dd236684", level.players );
}

// Namespace sd
// Params 1, eflags: 0x4
// Checksum 0xc0636728, Offset: 0x3bb8
// Size: 0xbd
function private onbeginuse( player )
{
    obj_bombzone::bombzone_onbeginuse( player );
    
    if ( !gameobjects::isfriendlyteam( player.pers[ "team" ] ) )
    {
        if ( level.multibomb )
        {
            if ( self.objectivekey == "_a" )
            {
                level.objectives[ "_b" ] gameobjects::allowuse( "none" );
                level.objectives[ "_b" ] gameobjects::setvisibleteam( "friendly" );
                return;
            }
            
            level.objectives[ "_a" ] gameobjects::allowuse( "none" );
            level.objectives[ "_a" ] gameobjects::setvisibleteam( "friendly" );
        }
    }
}

// Namespace sd
// Params 3, eflags: 0x4
// Checksum 0x6410a485, Offset: 0x3c7d
// Size: 0xdf
function private onenduse( team, player, result )
{
    obj_bombzone::bombzone_onenduse( team, player, result );
    
    if ( isdefined( player ) && !gameobjects::isfriendlyteam( player.pers[ "team" ] ) )
    {
        if ( level.multibomb && !result )
        {
            if ( self.objectivekey == "_a" )
            {
                level.objectives[ "_b" ] gameobjects::allowuse( "enemy" );
                level.objectives[ "_b" ] gameobjects::setvisibleteam( "any" );
                return;
            }
            
            level.objectives[ "_a" ] gameobjects::allowuse( "enemy" );
            level.objectives[ "_a" ] gameobjects::setvisibleteam( "any" );
        }
    }
}

// Namespace sd
// Params 1, eflags: 0x4
// Checksum 0x562b74ca, Offset: 0x3d64
// Size: 0x11f
function private onuseplantobject( player )
{
    if ( !gameobjects::isfriendlyteam( player.pers[ "team" ] ) )
    {
        foreach ( zone in level.objectives )
        {
            if ( zone == self )
            {
                continue;
            }
            
            zone gameobjects::disableobject();
        }
    }
    
    level thread hud_message::updatematchstatushintforallplayers( player.team, #"search_and_destroy_defend_bomb", #"search_and_destroy_defuse_bomb" );
    obj_bombzone::bombzone_onuseplantobject( player );
    level callback::callback( #"music_event", { #event_type:#"bomb_planted" } );
    thread gameplay_sound_fx::function_28103d3430792dce( self.bombdefusetrig.origin, #"hash_41ca224ade01721b" );
}

// Namespace sd
// Params 0, eflags: 0x4
// Checksum 0x7bc01802, Offset: 0x3e8b
// Size: 0x4c
function private setspecialloadout()
{
    if ( isusingmatchrulesdata() && game_utility_mp::getmatchrulesdatawithteamandindex( "defaultClasses", game[ "attackers" ], 5, "class", "inUse" ) )
    {
        level.sd_loadout[ game[ "attackers" ] ] = game_utility_mp::getmatchrulesspecialclass( game[ "attackers" ], 5 );
    }
}

// Namespace sd
// Params 5, eflags: 0x4
// Checksum 0xe72b3f02, Offset: 0x3edf
// Size: 0x39
function private onbombexploded( objectivetype, bomblabel, player, team, extradata )
{
    onobjectivecomplete( team );
}

// Namespace sd
// Params 1, eflags: 0x4
// Checksum 0xf8bc7784, Offset: 0x3f20
// Size: 0xa8
function private onobjectivecomplete( winningteam )
{
    setomnvar( "ui_bomb_owner_team", 0 );
    
    if ( level.nukeinfo.incoming )
    {
        return;
    }
    
    if ( winningteam == game[ "attackers" ] )
    {
        setgameendtime( 0 );
        thread function_ab354d7179e44ff3( game[ "attackers" ], game[ "end_reason" ][ "target_destroyed" ], 3 );
    }
    else
    {
        setgameendtime( 0 );
        thread function_ab354d7179e44ff3( game[ "defenders" ], game[ "end_reason" ][ "bomb_defused" ], 1.5 );
    }
    
    codcasterclientmatchdata::function_d6aea11d2e9ba521();
    
    if ( flags::gameflagexists( "bombZones_ready" ) )
    {
        flags::gameflagclear( "bombZones_ready" );
    }
}

// Namespace sd
// Params 3, eflags: 0xc
// Checksum 0x4ca366b1, Offset: 0x3fd0
// Size: 0x4f
function private function_ab354d7179e44ff3( winningteam, endreasontext, waittime )
{
    self notify( #"hash_630ea3b0ef8386d4" );
    self endon( #"hash_630ea3b0ef8386d4" );
    level endon( #"game_ended" );
    wait waittime;
    endgame( winningteam, endreasontext );
}

// Namespace sd
// Params 0, eflags: 0x4
// Checksum 0x8e3dd597, Offset: 0x4027
// Size: 0x131
function private updatematchstatushintonspawn()
{
    if ( level.bombplanted )
    {
        if ( game[ "attackers" ] == self.team )
        {
            hud_message::function_ef4318a0090caa0f( #"search_and_destroy_defend_bomb" );
        }
        else
        {
            hud_message::function_ef4318a0090caa0f( #"search_and_destroy_defuse_bomb" );
        }
        
        return;
    }
    
    if ( isdefined( level.sdbomb ) )
    {
        if ( isdefined( level.sdbomb.carrier ) )
        {
            if ( level.sdbomb.carrier.team == self.team )
            {
                if ( level.sdbomb.carrier == self )
                {
                    hud_message::function_ef4318a0090caa0f( #"search_and_destroy_plant_bomb" );
                }
                else
                {
                    hud_message::function_ef4318a0090caa0f( #"hash_c1319d9ced8d09d3" );
                }
            }
            else
            {
                hud_message::function_ef4318a0090caa0f( #"search_and_destroy_defend_objectives" );
            }
        }
        else if ( game[ "attackers" ] == self.team )
        {
            hud_message::function_ef4318a0090caa0f( #"hash_4c0acc8706be34e3" );
        }
        else
        {
            hud_message::function_ef4318a0090caa0f( #"search_and_destroy_defend_objectives" );
        }
        
        return;
    }
    
    hud_message::function_ef4318a0090caa0f( #"hide_match_hint" );
}

// Namespace sd
// Params 1, eflags: 0x4
// Checksum 0xf6e68eb6, Offset: 0x4160
// Size: 0x87, Type: bool
function private function_18b964d931602c7a( point )
{
    if ( isdefined( level.sdbomb ) && gameobjects_shared::is_activated( level.sdbomb ) )
    {
        if ( isdefined( point ) )
        {
            sd_bomb_origin = gameobjects_shared::get_origin( level.sdbomb );
            
            if ( utility::ispointinsidecircle( point, sd_bomb_origin, 40 ) )
            {
                return false;
            }
        }
        else
        {
            sd_bomb_trigger = gameobjects_shared::get_trigger( level.sdbomb );
            
            if ( self istouching( sd_bomb_trigger ) )
            {
                return false;
            }
        }
    }
    
    return true;
}

// Namespace sd
// Params 0, eflags: 0x4
// Checksum 0x2da80d81, Offset: 0x41f0
// Size: 0x13
function private onmaprestart()
{
    level.generalkillcount = undefined;
    codcasterclientmatchdata::function_1340113cb5a43c2c();
}

// Namespace sd
// Params 2, eflags: 0x4
// Checksum 0x758087ce, Offset: 0x420b
// Size: 0x73
function private function_76669980c7140d84( team, increment )
{
    if ( !isdefined( team ) )
    {
        return;
    }
    
    if ( !isdefined( game[ "gameKillCounts" ] ) )
    {
        game[ "gameKillCounts" ] = [];
    }
    
    if ( !isdefined( game[ "gameKillCounts" ][ team ] ) )
    {
        game[ "gameKillCounts" ][ team ] = 0;
    }
    
    game[ "gameKillCounts" ][ team ] = game[ "gameKillCounts" ][ team ] + increment;
    codcaster_utils::function_eddb7bc4ce563395( game[ "gameKillCounts" ][ team ], team );
}

// Namespace sd
// Params 3, eflags: 0x4
// Checksum 0xd1e8a1d6, Offset: 0x4286
// Size: 0x51
function private onbombpickup( player, playervo, defused )
{
    level thread hud_message::updatematchstatushintforallplayers( player.team, #"hash_c1319d9ced8d09d3", undefined, player, #"search_and_destroy_plant_bomb" );
    obj_bombzone::onpickup( player, playervo, defused );
}

// Namespace sd
// Params 1, eflags: 0x4
// Checksum 0xa571f5a7, Offset: 0x42df
// Size: 0x4f
function private function_d43144c15f06af73( player )
{
    if ( !level.bombplanted )
    {
        level thread hud_message::updatematchstatushintforallplayers( player.team, #"hash_4c0acc8706be34e3" );
    }
    
    player setclientomnvar( "ui_hud_carried_item_count", 0 );
    player setclientomnvar( "ui_carrying_bomb", 0 );
}

// Namespace sd
// Params 0, eflags: 0x4
// Checksum 0x597f46fe, Offset: 0x4336
// Size: 0x594
function private function_bf70e8e73e6ea0dc()
{
    assert( isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ), "<dev string:x1b8>" );
    
    if ( !level.multibomb )
    {
        bomb_trigger = getent( "sd_bomb", #targetname );
        assert( isdefined( bomb_trigger ), "<dev string:x1d8>" );
        bomb_trigger.donotdelete = 1;
        var_24290c36e2cab388 = { #manual_drop:1, #var_7f4958ce4e4277c3:#"hash_bb332da19f9944df", #capture_segment_count:1, #var_333d3689d793bcc7:0, #use_time_seconds:0, #var_c68e9f43ed9cc918:#"hash_a1360b18943e920", #var_d7c90dc73c1dcba8:( 0, 0, 0 ), #objective_icon_offset:( 0, 0, 0 ), #angles:( 0, 0, 0 ), #origin:( 0, 0, 0 ) };
        var_24290c36e2cab388.origin = bomb_trigger.origin;
        var_24290c36e2cab388.angles = bomb_trigger.angles;
        var_24290c36e2cab388.var_c68e9f43ed9cc918 = #"hash_7118f9343873352b";
        gameobjects_common::initialize_game_object( bomb_trigger.targetname, var_24290c36e2cab388, bomb_trigger, &function_57fa74559eb4820d );
    }
    
    var_36006fc552cd2e9e = getentarray( "bombzone_planting", #targetname );
    assert( var_36006fc552cd2e9e.size == 2, "<dev string:x1f7>" );
    var_f5744fc661a226ed = getentarray( "bombzone_defusing", #targetname );
    assert( var_f5744fc661a226ed.size == 2, "<dev string:x247>" );
    var_b48d5c64f47d6fef = [];
    
    for ( i = 0; i < 2 ; i++ )
    {
        var_8db38b60bf942499 = var_36006fc552cd2e9e[ i ];
        var_19468a34305f522c = var_f5744fc661a226ed[ i ];
        var_8db38b60bf942499.donotdelete = 1;
        var_8db38b60bf942499.target = undefined;
        var_19468a34305f522c.donotdelete = 1;
        var_19468a34305f522c.target = undefined;
        
        if ( !isdefined( var_b48d5c64f47d6fef[ var_8db38b60bf942499.script_label ] ) )
        {
            var_b48d5c64f47d6fef[ var_8db38b60bf942499.script_label ] = {};
        }
        
        var_b48d5c64f47d6fef[ var_8db38b60bf942499.script_label ].var_8db38b60bf942499 = var_8db38b60bf942499;
        
        if ( !isdefined( var_b48d5c64f47d6fef[ var_19468a34305f522c.script_label ] ) )
        {
            var_b48d5c64f47d6fef[ var_19468a34305f522c.script_label ] = {};
        }
        
        var_b48d5c64f47d6fef[ var_19468a34305f522c.script_label ].var_19468a34305f522c = var_19468a34305f522c;
    }
    
    game_utility_mp::clean_up_entities();
    
    foreach ( bombzone_entities in var_b48d5c64f47d6fef )
    {
        var_8db38b60bf942499 = bombzone_entities.var_8db38b60bf942499;
        var_19468a34305f522c = bombzone_entities.var_19468a34305f522c;
        init_struct_planting = { #manual_drop:1, #var_7f4958ce4e4277c3:#"hash_bb332da19f9944df", #capture_segment_count:1, #var_333d3689d793bcc7:0, #use_time_seconds:0, #var_c68e9f43ed9cc918:#"hash_a1360b18943e920", #var_d7c90dc73c1dcba8:( 0, 0, 0 ), #objective_icon_offset:( 0, 0, 0 ), #angles:( 0, 0, 0 ), #origin:( 0, 0, 0 ) };
        init_struct_planting.origin = var_8db38b60bf942499.origin;
        init_struct_planting.angles = var_8db38b60bf942499.angles;
        init_struct_planting.var_c68e9f43ed9cc918 = #"hash_7118f9343873352b";
        init_struct_planting.use_time_seconds = level.planttime;
        init_struct_defusing = { #manual_drop:1, #var_7f4958ce4e4277c3:#"hash_bb332da19f9944df", #capture_segment_count:1, #var_333d3689d793bcc7:0, #use_time_seconds:0, #var_c68e9f43ed9cc918:#"hash_a1360b18943e920", #var_d7c90dc73c1dcba8:( 0, 0, 0 ), #objective_icon_offset:( 0, 0, 0 ), #angles:( 0, 0, 0 ), #origin:( 0, 0, 0 ) };
        init_struct_defusing.origin = var_19468a34305f522c.origin;
        init_struct_defusing.angles = var_19468a34305f522c.angles;
        init_struct_defusing.var_c68e9f43ed9cc918 = #"hash_ce911e3bbe99421f";
        init_struct_defusing.use_time_seconds = level.defusetime;
        gameobjects_common::initialize_game_object( var_8db38b60bf942499.targetname, init_struct_planting, var_8db38b60bf942499, &function_2284a3946b80b6a5 );
        gameobjects_common::initialize_game_object( var_19468a34305f522c.targetname, init_struct_defusing, var_19468a34305f522c, &function_6230b6aba2d3268b );
    }
}

// Namespace sd
// Params 1, eflags: 0x4
// Checksum 0x4a16e72d, Offset: 0x48d2
// Size: 0x1ea
function private function_57fa74559eb4820d( game_object )
{
    game_object_origin = gameobjects_shared::get_origin( game_object );
    
    if ( !istrue( level.game_objects.var_5f329cd264226f08 ) )
    {
        game_object_origin += ( 0, 0, 12 );
        gameobjects_common::function_d31ff650f04e754b( game_object, game_object_origin );
    }
    
    game_object.objective_id = objidpoolmanager::requestobjectiveid();
    objidpoolmanager::objective_teammask_addtomask( game_object.objective_id, game[ "attackers" ] );
    objidpoolmanager::update_objective_ownerteam( game_object.objective_id, game[ "attackers" ] );
    objidpoolmanager::update_objective_position( game_object.objective_id, game_object_origin );
    objidpoolmanager::update_objective_state( game_object.objective_id, "current" );
    objectiveiconstates::set_objective_icon_state( game_object.objective_id, #"bomb_neutral" );
    bomb_model_ref = common::get_gametype_asset( #"bomb_model" );
    game_object.visuals = spawn( "script_model", utility::drop_to_ground( game_object_origin, 64, -1024 ) );
    game_object.visuals.angles = gameobjects_common::function_63e25df7cfbb206f( game_object );
    game_object.visuals setmodel( bomb_model_ref );
    game_object.visuals setnonstick( 1 );
    game_object.visuals show();
    bombzone::initialize_bomb( game_object );
    level.sdbomb = game_object;
    level.sdbombmodel = game_object.visuals;
    game_object callback::function_dc654a4d4126a928( #"hash_249e26f937238db4", #"hash_6947ec89a1af6d69", &function_a18e13deea15aed5 );
    game_object callback::function_dc654a4d4126a928( #"hash_a21546ba725310a2", #"hash_6947ec89a1af6d69", &function_6b77081f85d6fc4f );
    gameobjects_shared::activate( game_object );
    flags::levelflaginit( "sd_bomb_constructed", 1 );
}

// Namespace sd
// Params 1, eflags: 0x4
// Checksum 0x32b8357, Offset: 0x4ac4
// Size: 0x1ea
function private function_a18e13deea15aed5( params )
{
    game_object = params.game_object;
    player = params.player;
    team_first_pickup = params.team_first_pickup;
    force_pickup = params.force_pickup;
    objidpoolmanager::update_objective_onentity( game_object.objective_id, player );
    objectiveiconstates::set_objective_icon_state( game_object.objective_id, #"bomb_carried" );
    game_object.visuals hide();
    player_vo_hash = team_first_pickup ? #"hash_490ec9092bec7857" : #"bomb_picked_up_player";
    var_18226a6ff5cba540 = team_first_pickup ? #"hash_b7bd5b486d0f88d" : #"bomb_picked_up_friendly";
    var_697973ab574ef2a5 = [];
    
    if ( dialog_utility::dialogueexists( player_vo_hash, player.team ) )
    {
        player dialog::leaderdialogonplayer( player_vo_hash, player.team );
        
        if ( !isdefined( var_697973ab574ef2a5 ) )
        {
            var_697973ab574ef2a5 = [];
        }
        
        var_697973ab574ef2a5[ var_697973ab574ef2a5.size ] = player;
    }
    
    dialog::statusdialog( var_18226a6ff5cba540, player.team, undefined, var_697973ab574ef2a5 );
    
    if ( !force_pickup )
    {
        player gameplay_sound_fx::function_6dac8db778849e61( #"bomb_picked_up", player.team );
        player gameplay_sound_fx::function_28103d3430792dce( player.origin, #"bomb_picked_up_foley" );
    }
    
    function_3cda55bdc90a74ff( player );
    codcaster_utils::function_3038b6eafc46c037( 1, player.team, player getentitynumber() );
    thread hud_message::updatematchstatushintforallplayers( player.team, #"hash_c1319d9ced8d09d3", undefined, player, #"search_and_destroy_plant_bomb" );
    thread hud_util::function_ddf9cb7f151d8d96( player, #"hash_ff1dc30d9c14913e", #"hash_f33e4e6c88032f03" );
}

// Namespace sd
// Params 1, eflags: 0x4
// Checksum 0xdf5ba392, Offset: 0x4cb6
// Size: 0x151
function private function_6b77081f85d6fc4f( params )
{
    game_object = params.game_object;
    player = params.player;
    game_object_origin = gameobjects_shared::get_origin( game_object );
    objidpoolmanager::update_objective_position( game_object.objective_id, game_object_origin );
    game_object.visuals.origin = utility::drop_to_ground( game_object_origin, 64, -1024 );
    game_object.visuals.angles = gameobjects_common::function_63e25df7cfbb206f( game_object );
    game_object.visuals show();
    
    if ( !level.bombplanted )
    {
        objectiveiconstates::set_objective_icon_state( game_object.objective_id, #"bomb_neutral" );
        dialog::statusdialog( #"bomb_dropped_friendly", player.team );
        player gameplay_sound_fx::function_6dac8db778849e61( #"bomb_dropped", player.team );
        player gameplay_sound_fx::function_28103d3430792dce( player.origin, #"bomb_dropped_foley" );
        level thread hud_message::updatematchstatushintforallplayers( player.team, #"hash_4c0acc8706be34e3" );
    }
    
    function_57fd7f11a20998a3( player );
}

// Namespace sd
// Params 1, eflags: 0x4
// Checksum 0xfba79be9, Offset: 0x4e0f
// Size: 0x20c
function private function_2284a3946b80b6a5( game_object )
{
    objective_key = gameobjects_shared::get_objective_key( game_object );
    game_object_origin = gameobjects_shared::get_origin( game_object );
    
    if ( !istrue( level.game_objects.var_5f329cd264226f08 ) )
    {
        game_object_origin += ( 0, 0, 24 );
        gameobjects_common::function_d31ff650f04e754b( game_object, game_object_origin );
    }
    
    game_object.objective_id = objidpoolmanager::requestobjectiveid();
    objidpoolmanager::objective_playermask_showtoall( game_object.objective_id );
    objidpoolmanager::update_objective_ownerteam( game_object.objective_id, game[ "defenders" ] );
    objidpoolmanager::update_objective_position( game_object.objective_id, game_object_origin );
    objidpoolmanager::update_objective_state( game_object.objective_id, "current" );
    objectiveiconstates::set_objective_icon_state( game_object.objective_id, hashcat( #"bombzone_neutral", objective_key ) );
    game_utility_mp::add_gametype_objective( game_object );
    game_object callback::function_dc654a4d4126a928( #"hash_358d33b2497e2ce3", #"hash_6947ec89a1af6d69", &function_5b1877fb41d9d205 );
    game_object callback::function_dc654a4d4126a928( #"hash_5d939c5f097361e9", #"hash_6947ec89a1af6d69", &function_7ced0570374b8e0f );
    game_object callback::function_dc654a4d4126a928( #"hash_3c955b1e6fcd76eb", #"hash_6947ec89a1af6d69", &function_acb2837487768549 );
    game_object callback::function_dc654a4d4126a928( #"hash_45277be78cb54c51", #"hash_6947ec89a1af6d69", &function_513bf848e8ce6ed1 );
    game_object callback::function_dc654a4d4126a928( #"hash_a1e02ee2cc2ad28e", #"hash_6947ec89a1af6d69", &function_b51c7e6a7c15fb4c );
    game_object callback::function_dc654a4d4126a928( #"hash_47fedf1df6eafa30", #"hash_6947ec89a1af6d69", &bombzone_on_use_update );
    gameobjects_shared::activate( game_object );
    
    if ( !isdefined( level.var_a5888fa23974f461 ) )
    {
        level.var_a5888fa23974f461 = [];
    }
    
    if ( !isdefined( level.var_a5888fa23974f461[ objective_key ] ) )
    {
        level.var_a5888fa23974f461[ objective_key ] = {};
    }
    
    level.var_a5888fa23974f461[ objective_key ].planting = game_object;
}

// Namespace sd
// Params 1, eflags: 0x4
// Checksum 0x2c987dfd, Offset: 0x5023
// Size: 0x16d
function private function_6230b6aba2d3268b( game_object )
{
    if ( !istrue( level.game_objects.var_5f329cd264226f08 ) )
    {
        game_object_origin = gameobjects_common::get_origin( game_object ) + ( 0, 0, 12 );
        gameobjects_common::function_d31ff650f04e754b( game_object, game_object_origin );
    }
    
    game_object callback::function_dc654a4d4126a928( #"hash_358d33b2497e2ce3", #"hash_6947ec89a1af6d69", &function_38cc93f75a092d1b );
    game_object callback::function_dc654a4d4126a928( #"hash_5d939c5f097361e9", #"hash_6947ec89a1af6d69", &function_e86653d061c26741 );
    game_object callback::function_dc654a4d4126a928( #"hash_3c955b1e6fcd76eb", #"hash_6947ec89a1af6d69", &function_d9224b8b535fa6c3 );
    game_object callback::function_dc654a4d4126a928( #"hash_45277be78cb54c51", #"hash_6947ec89a1af6d69", &function_513bf848e8ce6ed1 );
    game_object callback::function_dc654a4d4126a928( #"hash_a1e02ee2cc2ad28e", #"hash_6947ec89a1af6d69", &function_4255effe1af9f106 );
    game_object callback::function_dc654a4d4126a928( #"hash_47fedf1df6eafa30", #"hash_6947ec89a1af6d69", &bombzone_on_use_update );
    objective_key = gameobjects_shared::get_objective_key( game_object );
    
    if ( !isdefined( level.var_a5888fa23974f461 ) )
    {
        level.var_a5888fa23974f461 = [];
    }
    
    if ( !isdefined( level.var_a5888fa23974f461[ objective_key ] ) )
    {
        level.var_a5888fa23974f461[ objective_key ] = {};
    }
    
    level.var_a5888fa23974f461[ objective_key ].defusing = game_object;
}

// Namespace sd
// Params 1, eflags: 0x4
// Checksum 0xf8eee4ed, Offset: 0x5198
// Size: 0x7e
function private function_5b1877fb41d9d205( params )
{
    game_object = params.game_object;
    objective_key = gameobjects_shared::get_objective_key( game_object );
    objectiveiconstates::set_objective_icon_state( game_object.objective_id, hashcat( #"bombzone_planting", objective_key ) );
    omnvar_value = objective_key == "_a" ? 1 : 2;
    setomnvar( "ui_bomb_interacting", omnvar_value );
}

// Namespace sd
// Params 1, eflags: 0x4
// Checksum 0xa8f6a8f8, Offset: 0x521e
// Size: 0xa3
function private function_38cc93f75a092d1b( params )
{
    game_object = params.game_object;
    objective_key = gameobjects_shared::get_objective_key( game_object );
    objectiveiconstates::set_objective_icon_state( game_object.objective_id, hashcat( #"bombzone_defusing", objective_key ) );
    
    if ( isdefined( level.sdbomb ) )
    {
        level.sdbomb.visuals hide();
    }
    
    omnvar_value = objective_key == "_a" ? 3 : 4;
    setomnvar( "ui_bomb_interacting", omnvar_value );
}

// Namespace sd
// Params 1, eflags: 0x4
// Checksum 0xc49a9e71, Offset: 0x52c9
// Size: 0x6e
function private function_7ced0570374b8e0f( params )
{
    game_object = params.game_object;
    
    if ( !level.bombplanted )
    {
        objective_key = gameobjects_shared::get_objective_key( game_object );
        objectiveiconstates::set_objective_icon_state( game_object.objective_id, hashcat( #"bombzone_neutral", objective_key ) );
    }
    
    setomnvar( "ui_bomb_interacting", 0 );
}

// Namespace sd
// Params 1, eflags: 0x4
// Checksum 0x911e4723, Offset: 0x533f
// Size: 0xb6
function private function_e86653d061c26741( params )
{
    game_object = params.game_object;
    objective_key = gameobjects_shared::get_objective_key( game_object );
    
    if ( level.bombplanted )
    {
        objectiveiconstates::set_objective_icon_state( game_object.objective_id, hashcat( #"bombzone_planted", objective_key ) );
        
        if ( isdefined( level.sdbomb ) )
        {
            level.sdbomb.visuals show();
        }
    }
    else
    {
        objectiveiconstates::set_objective_icon_state( game_object.objective_id, hashcat( #"bombzone_neutral", objective_key ) );
    }
    
    setomnvar( "ui_bomb_interacting", 0 );
}

// Namespace sd
// Params 2, eflags: 0x4
// Checksum 0x7e58c154, Offset: 0x53fd
// Size: 0x6e
function private function_8240bb5a55fc47eb( game_object, player )
{
    objidpoolmanager::objective_pin_player( game_object.objective_id, player );
    objidpoolmanager::function_b3b969f2930890eb( 2, player );
    objidpoolmanager::objective_show_team_progress( game_object.objective_id, player.team );
    objidpoolmanager::objective_set_progress_team( game_object.objective_id, player.team );
}

// Namespace sd
// Params 1, eflags: 0x4
// Checksum 0xcf214ec7, Offset: 0x5473
// Size: 0xc9
function private function_acb2837487768549( params )
{
    game_object = params.game_object;
    player = params.player;
    function_8240bb5a55fc47eb( game_object, player );
    thread function_f0e197d74d28dbac( player, 1 );
    objective_key = gameobjects_shared::get_objective_key( game_object );
    announcer_vo_hash = dialog_utility::dialogueexists( hashcat( #"bomb_planting_friendly", objective_key ), player.team ) ? hashcat( #"bomb_planting_friendly", objective_key ) : #"bomb_planting_friendly";
    dialog::statusdialog( announcer_vo_hash, player.team );
    player setclientomnvar( "ui_objective_pinned_text_param", 1 );
}

// Namespace sd
// Params 1, eflags: 0x4
// Checksum 0x5f2c3d01, Offset: 0x5544
// Size: 0x9f
function private function_d9224b8b535fa6c3( params )
{
    game_object = params.game_object;
    player = params.player;
    function_8240bb5a55fc47eb( game_object, player );
    thread function_f0e197d74d28dbac( player, 0 );
    dialog::statusdialog( #"hash_d5b477857111e67b", player.team );
    codcaster_utils::function_3038b6eafc46c037( 2, player.team, player getentitynumber() );
    player setclientomnvar( "ui_objective_pinned_text_param", 2 );
    setomnvar( "ui_bomb_defuser", player getentitynumber() );
}

// Namespace sd
// Params 1, eflags: 0x4
// Checksum 0xac9bc8bb, Offset: 0x55eb
// Size: 0xbf
function private function_513bf848e8ce6ed1( params )
{
    game_object = params.game_object;
    player = params.player;
    player notify( #"hash_80198d66a370b252" );
    objidpoolmanager::objective_unpin_player( game_object.objective_id, player );
    objidpoolmanager::function_b3b969f2930890eb( 0, player );
    objidpoolmanager::objective_hide_team_progress( game_object.objective_id, player.team );
    objidpoolmanager::objective_set_progress( game_object.objective_id, 0 );
    objidpoolmanager::objective_set_progress_team( game_object.objective_id, undefined );
    player setclientomnvar( "ui_objective_pinned_text_param", 0 );
    setomnvar( "ui_bomb_defuser", -1 );
}

// Namespace sd
// Params 1, eflags: 0x4
// Checksum 0x72df8f0f, Offset: 0x56b2
// Size: 0x99
function private function_b51c7e6a7c15fb4c( params )
{
    instance_id = params.instance_id;
    
    foreach ( bombzone_game_object in game_utility_mp::get_gametype_objectives( instance_id ) )
    {
        gameobjects_common::deactivate( bombzone_game_object );
    }
}

// Namespace sd
// Params 1, eflags: 0x4
// Checksum 0x286699f9, Offset: 0x5753
// Size: 0x99
function private function_4255effe1af9f106( params )
{
    instance_id = params.instance_id;
    
    foreach ( bombzone_game_object in game_utility_mp::get_gametype_objectives( instance_id ) )
    {
        gameobjects_common::activate( bombzone_game_object );
    }
}

// Namespace sd
// Params 1, eflags: 0x4
// Checksum 0x810b27a1, Offset: 0x57f4
// Size: 0x4c
function private bombzone_on_use_update( params )
{
    game_object = params.game_object;
    progress = params.progress;
    objidpoolmanager::objective_set_progress( game_object.objective_id, progress );
}

// Namespace sd
// Params 1, eflags: 0x4
// Checksum 0xb631886f, Offset: 0x5848
// Size: 0x23
function private function_f3a8689e0f98f3d7( params )
{
    params.player setclientomnvar( "ui_current_weapon_is_bomb", 1 );
}

// Namespace sd
// Params 1, eflags: 0x4
// Checksum 0x403b7df0, Offset: 0x5873
// Size: 0x22
function private function_4c9dd25d05697cad( params )
{
    params.player setclientomnvar( "ui_current_weapon_is_bomb", 0 );
}

// Namespace sd
// Params 1, eflags: 0x4
// Checksum 0x27c80ea3, Offset: 0x589d
// Size: 0x35e
function private on_bomb_planted( params )
{
    var_1b55994025b9dc25 = params.var_1b55994025b9dc25;
    var_85c26a6c91c38374 = params.var_85c26a6c91c38374;
    bomb_game_object = params.bomb_game_object;
    player = params.player;
    instance_id = params.instance_id;
    level.var_89a304fc199d7919 = 1;
    setgameendtime( level.defuseendtime );
    
    if ( isdefined( bomb_game_object ) )
    {
        objidpoolmanager::function_7736d86e518e223( bomb_game_object.objective_id );
    }
    
    foreach ( bombzone_game_object in game_utility_mp::get_gametype_objectives( instance_id ) )
    {
        if ( bombzone_game_object != var_1b55994025b9dc25 )
        {
            objidpoolmanager::objective_playermask_hidefromall( bombzone_game_object.objective_id );
        }
    }
    
    bombzone_objective_key = gameobjects_shared::get_objective_key( var_1b55994025b9dc25 );
    
    if ( !game_utility_mp::inovertime() )
    {
        defuse_team_name = game_utility_mp::getotherteam( player.team )[ 0 ];
        var_d60b94f95821a1cf = dialog_utility::dialogueexists( hashcat( #"bomb_planted_enemy", bombzone_objective_key ), player.team ) ? hashcat( #"bomb_planted_enemy", bombzone_objective_key ) : #"bomb_planted_enemy";
        dialog::statusdialog( #"bomb_planted_friendly", player.team );
        dialog::statusdialog( var_d60b94f95821a1cf, defuse_team_name );
    }
    
    player thread points::doscoreevent( #"plant", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, { #extraparam:bombzone_objective_key } );
    thread hud_message::updatematchstatushintforallplayers( player.team, #"search_and_destroy_defend_bomb", #"search_and_destroy_defuse_bomb" );
    thread hud_util::teamplayercardsplash( #"hash_745f1aa363a4efbb", player );
    
    if ( utility::issharedfuncdefined( #"hash_e8cc48aecfa87408", #"hash_77dc22f3dc1f56a9" ) )
    {
        utility::callsharedfunc( #"hash_e8cc48aecfa87408", #"hash_77dc22f3dc1f56a9", player, level.var_1d973649a283005e[ "plant" ] );
    }
    
    thread function_2b6f174d3ccaba7a( var_85c26a6c91c38374, bomb_game_object );
    callback::callback( #"music_event", { #event_type:#"bomb_planted" } );
    
    if ( bombzone_objective_key == "_a" )
    {
        level.aplanted = 1;
        codcaster_utils::function_3038b6eafc46c037( 0, player.team, player getentitynumber(), 1 );
        setomnvar( "ui_bomb_planted_a", 1 );
    }
    else if ( bombzone_objective_key == "_b" )
    {
        level.bplanted = 1;
        codcaster_utils::function_3038b6eafc46c037( 0, player.team, player getentitynumber(), 2 );
        setomnvar( "ui_bomb_planted_b", 1 );
    }
    else
    {
        assertmsg( "<dev string:x298>" );
    }
    
    setomnvar( "ui_bomb_owner_team", int( player.team == "allies" ) + 1 );
    setomnvar( "ui_bomb_carrier", -1 );
}

// Namespace sd
// Params 1, eflags: 0x4
// Checksum 0x613d1cf3, Offset: 0x5c03
// Size: 0x3cb
function private on_bomb_defused( params )
{
    var_1b55994025b9dc25 = params.var_1b55994025b9dc25;
    player = params.player;
    var_85c26a6c91c38374 = params.var_85c26a6c91c38374;
    objidpoolmanager::objective_playermask_hidefromall( var_1b55994025b9dc25.objective_id );
    plant_team_name = game_utility_mp::getotherteam( player.team )[ 0 ];
    var_5be46a163abbfc85 = teams::getteamdata( plant_team_name, "aliveCount" ) > 0;
    var_3032705d9e45ee0a = !var_5be46a163abbfc85 && dialog_utility::dialogueexists( #"hash_c566b0cbb7d752e1", player.team );
    var_9f1b92e3a0030bc1 = !var_5be46a163abbfc85 && dialog_utility::dialogueexists( #"hash_fb3f81bd7d96e27a", plant_team_name );
    var_d60b94f95821a1cf = var_3032705d9e45ee0a ? #"hash_c566b0cbb7d752e1" : #"bomb_defused_friendly";
    var_91cad79b7807a2f2 = var_9f1b92e3a0030bc1 ? #"hash_fb3f81bd7d96e27a" : #"bomb_defused_enemy";
    dialog::statusdialog( var_d60b94f95821a1cf, player.team );
    dialog::statusdialog( var_91cad79b7807a2f2, plant_team_name );
    
    if ( utility::issharedfuncdefined( #"hash_e8cc48aecfa87408", #"hash_77dc22f3dc1f56a9" ) )
    {
        utility::callsharedfunc( #"hash_e8cc48aecfa87408", #"hash_77dc22f3dc1f56a9", player, level.var_1d973649a283005e[ "defuse" ] );
    }
    
    if ( utility::issharedfuncdefined( #"hash_e8cc48aecfa87408", #"hash_aa1d1eedba6d864a" ) )
    {
        utility::callsharedfunc( #"hash_e8cc48aecfa87408", #"hash_aa1d1eedba6d864a", plant_team_name, level.var_1d973649a283005e[ "defuse_loss" ] );
    }
    
    thread hud_util::function_ddf9cb7f151d8d96( player, #"hash_4b87faeddcbc224c", #"hash_e407d6e173bc61e1", #"hash_e407d6e173bc61e1" );
    waslastalive = 0;
    
    if ( game_utility_mp::getgametypenumlives() >= 1 )
    {
        liveplayers = game_utility_mp::getpotentiallivingplayers();
        
        if ( liveplayers.size == 1 && liveplayers[ 0 ] == player )
        {
            waslastalive = 1;
        }
    }
    
    enemiesnearby = 0;
    
    if ( !waslastalive )
    {
        playersnearby = getplayersinradius( player.origin, 600 );
        
        foreach ( nearbyplayer in playersnearby )
        {
            if ( nearbyplayer.team != player.team )
            {
                enemiesnearby = 1;
                break;
            }
        }
    }
    
    defusesite = defusesite.objectivekey ?? undefined;
    
    if ( player::isreallyalive( level.bombowner ) && level.bombowner.bombplantedtime + 3000 + level.defusetime * 1000 > gettime() )
    {
        player thread points::doscoreevent( #"ninja_defuse" );
        enemiesnearby = 1;
    }
    
    if ( waslastalive )
    {
        player thread points::doscoreevent( #"mode_sd_last_defuse", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, { #extraparam:var_85c26a6c91c38374 } );
    }
    else
    {
        player thread points::doscoreevent( #"mode_sd_defuse", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, { #extraparam:var_85c26a6c91c38374 } );
    }
    
    potg_events::bombdefused( player, waslastalive, enemiesnearby );
    onobjectivecomplete( player.team );
}

// Namespace sd
// Params 1, eflags: 0x4
// Checksum 0x5ee93e13, Offset: 0x5fd6
// Size: 0x1e3
function private on_bomb_detonated( params )
{
    var_1b55994025b9dc25 = params.var_1b55994025b9dc25;
    var_85c26a6c91c38374 = params.var_85c26a6c91c38374;
    bomb_game_object = params.bomb_game_object;
    player = params.player;
    plant_team_name = params.plant_team_name;
    objidpoolmanager::objective_playermask_hidefromall( var_1b55994025b9dc25.objective_id );
    var_1b55994025b9dc25.scriptable setscriptabledamageowner( player );
    var_1b55994025b9dc25.scriptable setscriptablepartstate( #"explosion", #"trigger" );
    
    if ( isdefined( bomb_game_object ) )
    {
        bomb_game_object.visuals hide();
    }
    
    var_5be46a163abbfc85 = teams::getteamdata( plant_team_name, "aliveCount" ) > 0;
    var_657583505a6398ee = !var_5be46a163abbfc85 && dialog_utility::dialogueexists( #"hash_f17e0031a4b14417", plant_team_name );
    var_91cad79b7807a2f2 = var_657583505a6398ee ? #"hash_f17e0031a4b14417" : #"bomb_detonated_friendly";
    dialog::statusdialog( var_91cad79b7807a2f2, plant_team_name );
    other_team_name = game_utility_mp::getotherteam( plant_team_name )[ 0 ];
    dialog::statusdialog( #"bomb_detonated_enemy", other_team_name );
    
    if ( isdefined( player ) )
    {
        player thread points::doscoreevent( #"mode_sd_detonate" );
        player thread rank::scoreeventpopup( #"detonate" );
    }
    
    if ( utility::issharedfuncdefined( #"hash_e8cc48aecfa87408", #"hash_aa1d1eedba6d864a" ) )
    {
        utility::callsharedfunc( #"hash_e8cc48aecfa87408", #"hash_aa1d1eedba6d864a", plant_team_name, level.var_1d973649a283005e[ "detonated" ] );
    }
    
    gameobjects_shared::deactivate( var_85c26a6c91c38374 );
    onobjectivecomplete( plant_team_name );
}

// Namespace sd
// Params 1, eflags: 0x4
// Checksum 0x2656f9a8, Offset: 0x61c1
// Size: 0x17
function private function_3cda55bdc90a74ff( player )
{
    function_7b50eed7410e0c50( player, 1 );
}

// Namespace sd
// Params 1, eflags: 0x4
// Checksum 0x326e1084, Offset: 0x61e0
// Size: 0x16
function private function_57fd7f11a20998a3( player )
{
    function_7b50eed7410e0c50( player, 0 );
}

// Namespace sd
// Params 2, eflags: 0x4
// Checksum 0x38284386, Offset: 0x61fe
// Size: 0x114
function private function_7b50eed7410e0c50( player, var_4b2b323f40370860 )
{
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    player notify( #"force_cancel_placement" );
    
    if ( !isdefined( level.sd_loadout[ player.team ] ) )
    {
        return;
    }
    
    do
    {
        waitframe();
    }
    while ( player ismantling() || !player isonground() );
    
    if ( var_4b2b323f40370860 )
    {
        player.pers[ "gamemodeLoadout" ] = level.sd_loadout[ player.team ];
        player.gamemode_chosenclass = player.class;
        player class::function_e84a99f0f4904c66();
    }
    else
    {
        player.pers[ "gamemodeLoadout" ] = undefined;
    }
    
    player playerlogic::spawnpoint_setspawnpoint( player.origin, player.angles );
    player notify( #"faux_spawn" );
    player.faux_spawn_stance = player getstance();
    player thread playerlogic::spawnplayer( 1 );
}

// Namespace sd
// Params 2, eflags: 0x4
// Checksum 0x6b54618d, Offset: 0x631a
// Size: 0x1cc
function private function_2b6f174d3ccaba7a( var_85c26a6c91c38374, bomb_game_object )
{
    assert( var_85c26a6c91c38374.bombplanted );
    level endon( #"game_ended" );
    instance_id = gameobjects_common::get_instance_id( var_85c26a6c91c38374 );
    attacker_team_name = game_utility_mp::get_attacker_team( instance_id );
    objidpoolmanager::update_objective_ownerteam( var_85c26a6c91c38374.objective_id, attacker_team_name );
    bombzone_objective_key = gameobjects_shared::get_objective_key( var_85c26a6c91c38374 );
    var_2b61658b2c4fc2fe = hashcat( #"bombzone_planted", bombzone_objective_key );
    objectiveiconstates::set_objective_icon_state( var_85c26a6c91c38374.objective_id, var_2b61658b2c4fc2fe );
    bomb_timer_ms = int( level.bombtimer * 1000 );
    bomb_timer_start_ms = gettime();
    var_a7102818c851a2ef = bomb_timer_start_ms + bomb_timer_ms;
    setomnvar( "ui_bomb_timer_endtime" + bombzone_objective_key, var_a7102818c851a2ef );
    
    if ( isdefined( bomb_game_object ) )
    {
        bomb_game_object waittill( #"bomb_dropped" );
        var_bf678213e34db2dc = gameobjects_shared::get_origin( bomb_game_object );
        objidpoolmanager::update_objective_position( var_85c26a6c91c38374.objective_id, var_bf678213e34db2dc );
    }
    else
    {
        var_475858cee1383103 = gameobjects_shared::get_origin( var_85c26a6c91c38374 );
        objidpoolmanager::update_objective_position( var_85c26a6c91c38374.objective_id, var_475858cee1383103 );
    }
    
    objidpoolmanager::objective_show_progress( var_85c26a6c91c38374.objective_id, 1 );
    objidpoolmanager::objective_set_progress_team( var_85c26a6c91c38374.objective_id, attacker_team_name );
    
    while ( var_85c26a6c91c38374.bombplanted )
    {
        time_passed_ms = gettime() - bomb_timer_start_ms;
        time_passed_ratio = min( time_passed_ms / bomb_timer_ms, 1 );
        objidpoolmanager::objective_set_progress( var_85c26a6c91c38374.objective_id, time_passed_ratio );
        waitframe();
    }
}

// Namespace sd
// Params 2, eflags: 0xc
// Checksum 0x20f32468, Offset: 0x64ee
// Size: 0x2e8
function private function_f0e197d74d28dbac( player, var_faa32a47da5c0140 )
{
    self notify( #"hash_1e6abfe2ad0a55f3" );
    self endon( #"hash_1e6abfe2ad0a55f3" );
    player endon( #"death_or_disconnect" );
    player endon( #"bombzone_stop_use" );
    player endon( #"hash_80198d66a370b252" );
    
    if ( var_faa32a47da5c0140 )
    {
        if ( !player getscriptablehaspart( #"sd_bomb_screen_planting" ) )
        {
            return;
        }
        
        wait 0.7;
        player setscriptablepartstate( #"sd_bomb_screen_planting", #"start" );
        wait 1.18;
        player setscriptablepartstate( #"sd_bomb_screen_planting", #"press_1" );
        wait 0.2;
        player setscriptablepartstate( #"sd_bomb_screen_planting", #"press_2" );
        wait 0.5;
        player setscriptablepartstate( #"sd_bomb_screen_planting", #"press_3" );
        wait 0.35;
        player setscriptablepartstate( #"sd_bomb_screen_planting", #"press_4" );
        wait 0.4;
        player setscriptablepartstate( #"sd_bomb_screen_planting", #"press_5" );
        wait 0.4;
        player setscriptablepartstate( #"sd_bomb_screen_planting", #"press_6" );
        wait 0.35;
        player setscriptablepartstate( #"sd_bomb_screen_planting", #"press_7" );
        wait 0.3;
        player setscriptablepartstate( #"sd_bomb_screen_planting", #"press_8" );
        wait 0.35;
        player setscriptablepartstate( #"sd_bomb_screen_planting", #"press_9" );
        return;
    }
    
    if ( !player getscriptablehaspart( #"sd_bomb_screen_defusing" ) )
    {
        return;
    }
    
    player setscriptablepartstate( #"sd_bomb_screen_defusing", #"start" );
    wait 0.4;
    player setscriptablepartstate( #"sd_bomb_screen_defusing", #"press_1" );
    wait 0.2;
    player setscriptablepartstate( #"sd_bomb_screen_defusing", #"press_2" );
    wait 0.5;
    player setscriptablepartstate( #"sd_bomb_screen_defusing", #"press_3" );
    wait 0.35;
    player setscriptablepartstate( #"sd_bomb_screen_defusing", #"press_4" );
    wait 0.4;
    player setscriptablepartstate( #"sd_bomb_screen_defusing", #"press_5" );
    wait 0.4;
    player setscriptablepartstate( #"sd_bomb_screen_defusing", #"press_6" );
    wait 0.35;
    player setscriptablepartstate( #"sd_bomb_screen_defusing", #"press_7" );
    wait 0.3;
    player setscriptablepartstate( #"sd_bomb_screen_defusing", #"press_8" );
    wait 0.35;
    player setscriptablepartstate( #"sd_bomb_screen_defusing", #"press_9" );
}

