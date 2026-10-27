// scripts\mp\gametypes\trial.gsc  (hash_7eed363a9b249f1c.gscc) (size: 17467 Bytes / 0x443b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdc0fd736 (3692025654)
// size ...... 17467 (0x443b)
// includes .. 19  (offset: 0x3ab7)
// strings ... 121 (offset: 0x3b4f)
// dev strs .. 17  (offset: 0x433f)
// exports ... 21  (offset: 0x2adb)
// cseg ...... 0x839 + 0x22a2 (0x2adb)
// imports ... 101 (offset: 0x2e23)
// animtree1 . 0   (offset: 0x443b)
// animtree2 . 0   (offset: 0x443b)
#using scripts\common\utility;
#using scripts\common\vehicle_occupancy;
#using scripts\common\weapon;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\class;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\outline;
#using scripts\mp\compass;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\common;
#using scripts\mp\globallogic;
#using scripts\mp\menus;
#using scripts\mp\parachute;
#using scripts\mp\spawnlogic;
#using scripts\mp\trials\mp_trials_patches;
#using scripts\mp\trials\trial_enemy_sentry_turret;
#using scripts\mp\trials\trial_utility;

#namespace trial;

// Namespace trial
// Params 0
// Checksum 0x121816c5, Offset: 0x857
// Size: 0x720
function main()
{
    if ( getdvar( @"g_mapname" ) == "mp_background" )
    {
        return;
    }
    
    utility::flag_init( "strike_init_done" );
    trial_mission_data_init();
    trial_retrieve_persistent_values();
    mp_trials_patches::init_trial_patches();
    globallogic::init();
    globallogic::setupcallbacks();
    game_utility_mp::setcommonrulesfrommatchrulesdata();
    
    if ( getdvarint( @"bg_trial_mission_is_event" ) == 1 )
    {
        setdvar( @"hash_4d8ed5d95d54900a", 1 );
    }
    else
    {
        setdvar( @"lui_trial_ending", 1 );
    }
    
    setdvar( @"hash_84bca47b0009d424", 0 );
    
    /#
        setdvar( @"hash_3f36284b49b3d7a", 0 );
    #/
    
    allowed = [];
    allowed[ allowed.size ] = level.gametype;
    allowed[ allowed.size ] = "trial_variant_" + level.trial[ "variant" ];
    allowed[ allowed.size ] = "trial_mission_" + level.trial[ "missionScript" ];
    allowed[ allowed.size ] = "t_variant_" + level.trial[ "variant" ];
    allowed[ allowed.size ] = "t_mission_" + level.trial[ "missionScript" ];
    
    if ( trial_utility::trial_is_event() )
    {
        allowed[ allowed.size ] = "t_event";
    }
    
    switch ( level.trial[ "missionScript" ] )
    {
        case #"hash_5dfce04e1af9553":
        case #"hash_20d4a490009a1ff8":
            allowed[ allowed.size ] = "arm";
            break;
        default:
            break;
    }
    
    level.allowed_gametypes = allowed;
    gameobjects::main( allowed );
    setspecialloadout();
    common::updatecommongametypedvars();
    parachute::initparachutedvars();
    level.supportintel = 0;
    level.supportnuke = 0;
    level.disablespawncamera = 1;
    level.teambased = 1;
    level.challengesallowed = 0;
    level.getspawnpoint = &getspawnpoint;
    level.onplayerconnect = &onplayerconnect;
    level.bypassclasschoicefunc = &class::alwaysgamemodeclass;
    level.endgame = &trialendgame;
    
    if ( level.scripted_spawner_func.size )
    {
        level.starttime = 0;
        
        while ( !isdefined( level.struct_class_names ) )
        {
            waitframe();
        }
        
        foreach ( index, func in level.scripted_spawner_func )
        {
            [[ func ]]( 1, "cs" + index );
        }
        
        foreach ( struct in level.cs_object_container )
        {
            foreach ( object in struct.objects )
            {
                if ( isent( object ) && isdefined( object.struct.script_gameobjectname ) )
                {
                    var_92dee4d6f98f736 = 0;
                    
                    foreach ( name in allowed )
                    {
                        if ( object.struct.script_gameobjectname == name )
                        {
                            var_92dee4d6f98f736 = 1;
                        }
                    }
                    
                    if ( !var_92dee4d6f98f736 )
                    {
                        object delete();
                    }
                }
            }
        }
    }
    
    while ( !isdefined( level.trial_missionscript_init_funcs ) )
    {
        waitframe();
    }
    
    if ( isdefined( level.trial[ "triggeredTrialName" ] ) )
    {
        switch ( level.trial[ "missionScript" ] )
        {
            case #"hash_3303663b5c9c9d6c":
            case #"hash_fb5b5e6c07253005":
                thread [[ level.trial_missionscript_init_funcs[ "gun" ] ]]( level.trial[ "triggeredTrialName" ] );
                break;
            case #"hash_e9d9fcb8daba8602":
                thread [[ level.trial_missionscript_init_funcs[ "clear" ] ]]();
                break;
            case #"hash_6191aaef9f922f96":
                thread [[ level.trial_missionscript_init_funcs[ "sniper" ] ]]( level.trial[ "triggeredTrialName" ] );
                break;
            case #"hash_c2e89d8135aae861":
                thread [[ level.trial_missionscript_init_funcs[ "gunslinger" ] ]]();
                break;
            case #"hash_6d20826c437003d8":
                thread [[ level.trial_missionscript_init_funcs[ "tdm" ] ]]();
                break;
            default:
                break;
        }
    }
    else
    {
        switch ( level.trial[ "missionScript" ] )
        {
            case #"hash_3303663b5c9c9d6c":
            case #"hash_fb5b5e6c07253005":
                thread [[ level.trial_missionscript_init_funcs[ "gun" ] ]]();
                break;
            case #"hash_e9d9fcb8daba8602":
                thread [[ level.trial_missionscript_init_funcs[ "clear" ] ]]();
                break;
            case #"hash_6191aaef9f922f96":
                thread [[ level.trial_missionscript_init_funcs[ "sniper" ] ]]();
                break;
            case #"hash_9196025f8ae8e51e":
                thread [[ level.trial_missionscript_init_funcs[ "jugg" ] ]]();
                break;
            case #"hash_aae08c3a072df6bb":
                thread [[ level.trial_missionscript_init_funcs[ "lava" ] ]]();
                break;
            case #"hash_9cda66e2792cde2a":
                thread [[ level.trial_missionscript_init_funcs[ "pitcher" ] ]]();
                break;
            case #"hash_c2e89d8135aae861":
                thread [[ level.trial_missionscript_init_funcs[ "gunslinger" ] ]]();
                break;
            case #"hash_20d4a490009a1ff8":
                thread [[ level.trial_missionscript_init_funcs[ "race" ] ]]();
                break;
            case #"hash_5dfce04e1af9553":
                thread [[ level.trial_missionscript_init_funcs[ "arm_course" ] ]]();
                break;
            default:
                break;
        }
    }
    
    trial_enemy_sentry_turret::init();
    
    if ( level.trial[ "compassMaterialOverride" ] != "" )
    {
        waitframe();
        compass::setupminimap( level.trial[ "compassMaterialOverride" ] );
    }
    
    /#
        trial_debug_init();
    #/
}

// Namespace trial
// Params 2
// Checksum 0x34215ed7, Offset: 0xf7f
// Size: 0x9c
function trialendgame( winner, endreasontext )
{
    level notify( #"exitlevel_called" );
    processlobbydata();
    
    if ( isdefined( level.trial_dlog_func ) )
    {
        [[ level.trial_dlog_func ]]();
    }
    
    if ( getomnvar( "ui_trial_reward_tier" ) >= 1 )
    {
        setomnvar( "ui_trial_reward_received", 1 );
        setomnvar( "ui_trial_failed", 0 );
        
        if ( getdvarint( @"bg_trial_mission_is_event" ) != 1 )
        {
            wait 0.1;
            level.player openmenu( "RoundEndTeamHud" );
            wait 3;
        }
    }
    
    exitlevel( 0 );
}

// Namespace trial
// Params 2
// Checksum 0x82f3267e, Offset: 0x1023
// Size: 0x85
function function_c419b4e8e61b9280( mission_table, zone )
{
    var_26766893c256e824 = undefined;
    
    if ( isdefined( mission_table ) && isdefined( zone ) )
    {
        missions = mission_table.items;
        
        for ( i = 0; i < missions.size ; i++ )
        {
            if ( missions[ i ].zone == zone )
            {
                var_26766893c256e824 = missions[ i ].id;
                break;
            }
        }
    }
    
    return var_26766893c256e824;
}

// Namespace trial
// Params 2
// Checksum 0x796ad892, Offset: 0x10b1
// Size: 0x7b
function function_c8e3f9da90e5a76b( mission_table, var_26766893c256e824 )
{
    mission = undefined;
    
    if ( isdefined( mission_table ) && isdefined( var_26766893c256e824 ) )
    {
        missions = mission_table.items;
        
        for ( i = 0; i < missions.size ; i++ )
        {
            if ( missions[ i ].id == var_26766893c256e824 )
            {
                mission = missions[ i ];
                break;
            }
        }
    }
    
    return mission;
}

// Namespace trial
// Params 0
// Checksum 0x666f4c26, Offset: 0x1135
// Size: 0x316
function trial_mission_data_init()
{
    mission_table = trial_utility::trial_fetch_mission_table();
    assert( isdefined( mission_table ) );
    missionid = getdvarint( @"bg_trial_mission_id", 0 );
    
    if ( missionid == 0 )
    {
        fallbackid = function_c419b4e8e61b9280( mission_table, getdvar( @"g_mapname" ) );
        
        if ( isdefined( fallbackid ) )
        {
            println( "<dev string:x24>" + fallbackid + "<dev string:x5b>" + getdvar( @"g_mapname" ) );
            missionid = fallbackid;
        }
        else
        {
            assertmsg( "<dev string:x7b>" + getdvar( @"g_mapname" ) + "<dev string:xe6>" );
            return;
        }
    }
    
    trial_mission = function_c8e3f9da90e5a76b( mission_table, missionid );
    assert( isdefined( trial_mission ) );
    level.trial[ "missionID" ] = int( missionid );
    level.trial[ "zone" ] = trial_mission.zone;
    level.trial[ "missionScript" ] = trial_mission.missionScript;
    level.trial[ "variant" ] = trial_mission.variant;
    level.trial[ "team" ] = trial_mission.team;
    level.trial[ "scoreType" ] = trial_mission.scoretype;
    level.trial[ "tier1" ] = trial_mission.tier1;
    level.trial[ "tier2" ] = trial_mission.tier2;
    level.trial[ "tier3" ] = trial_mission.tier3;
    level.trial[ "attempts" ] = trial_mission.attempts;
    level.trial[ "compassMaterialOverride" ] = trial_mission.compassMaterialOverride;
    level.trial[ "playerDataId" ] = trial_mission.playerdataid;
    
    if ( level.trial[ "zone" ] != getdvar( @"g_mapname" ) )
    {
        assertmsg( "<dev string:x102>" + getdvar( @"g_mapname" ) + "<dev string:x112>" + level.trial[ "<dev string:x12d>" ] + "<dev string:x137>" + level.trial[ "<dev string:x143>" ] + "<dev string:x148>" );
    }
    
    setomnvar( "ui_trial_mission_score_is_time", level.trial[ "scoreType" ] == "time" );
    setomnvar( "ui_trial_mission_id", level.trial[ "missionID" ] );
    setomnvar( "ui_trial_mission_player_data_id", level.trial[ "playerDataId" ] );
    setomnvar( "ui_trial_tier_1_requirement", level.trial[ "tier1" ] );
    setomnvar( "ui_trial_tier_2_requirement", level.trial[ "tier2" ] );
    setomnvar( "ui_trial_tier_3_requirement", level.trial[ "tier3" ] );
}

// Namespace trial
// Params 1
// Checksum 0x49b649d, Offset: 0x1453
// Size: 0x310
function function_e1c13cfab19ea20c( missionid )
{
    mission_table = trial_utility::trial_fetch_mission_table();
    assert( tableexists( mission_table ) );
    
    if ( missionid == 0 )
    {
        fallbackid = function_c419b4e8e61b9280( mission_table, getdvar( @"g_mapname" ) );
        
        if ( fallbackid != "" )
        {
            println( "<dev string:x24>" + fallbackid + "<dev string:x5b>" + getdvar( @"g_mapname" ) );
            missionid = fallbackid;
        }
        else
        {
            assertmsg( "<dev string:x7b>" + getdvar( @"g_mapname" ) + "<dev string:xe6>" );
            return;
        }
    }
    
    trial_mission = function_c8e3f9da90e5a76b( mission_table, missionid );
    assert( isdefined( trial_mission ) );
    level.trial[ "missionID" ] = int( missionid );
    level.trial[ "zone" ] = trial_mission.zone;
    level.trial[ "missionScript" ] = trial_mission.missionScript;
    level.trial[ "variant" ] = trial_mission.variant;
    level.trial[ "team" ] = trial_mission.team;
    level.trial[ "scoreType" ] = trial_mission.scoretype;
    level.trial[ "tier1" ] = trial_mission.tier1;
    level.trial[ "tier2" ] = trial_mission.tier2;
    level.trial[ "tier3" ] = trial_mission.tier3;
    level.trial[ "attempts" ] = trial_mission.attempts;
    level.trial[ "compassMaterialOverride" ] = trial_mission.compassMaterialOverride;
    level.trial[ "playerDataId" ] = trial_mission.playerdataid;
    
    if ( level.trial[ "zone" ] != getdvar( @"g_mapname" ) )
    {
        assertmsg( "<dev string:x102>" + getdvar( @"g_mapname" ) + "<dev string:x112>" + level.trial[ "<dev string:x12d>" ] + "<dev string:x137>" + level.trial[ "<dev string:x143>" ] + "<dev string:x148>" );
    }
    
    setomnvar( "ui_trial_mission_score_is_time", level.trial[ "scoreType" ] == "time" );
    setomnvar( "ui_trial_mission_id", level.trial[ "missionID" ] );
    setomnvar( "ui_trial_mission_player_data_id", level.trial[ "playerDataId" ] );
    setomnvar( "ui_trial_tier_1_requirement", level.trial[ "tier1" ] );
    setomnvar( "ui_trial_tier_2_requirement", level.trial[ "tier2" ] );
    setomnvar( "ui_trial_tier_3_requirement", level.trial[ "tier3" ] );
}

// Namespace trial
// Params 0
// Checksum 0x1986fc9a, Offset: 0x176b
// Size: 0xc7
function getspawnpoint()
{
    while ( level.trial_spawn_wait )
    {
        waitframe();
    }
    
    spawnpointname = "mp_trial_spawn";
    spawnpoints = spawnlogic::getspawnpointarray( spawnpointname );
    assert( spawnpoints.size );
    spawnpoint = spawnlogic::getspawnpoint_startspawn( spawnpoints );
    
    if ( isdefined( level.trial_spawn_vehicle ) )
    {
        seat = vehicle_occupancy::function_495d488c998ad412( level.trial_spawn_vehicle );
        data = spawnstruct();
        data.useonspawn = 1;
        data.enterstartwaitmsg = "spawned_player";
        thread vehicle_occupancy::enter( level.trial_spawn_vehicle, seat, self, data );
        self.spawningintovehicle = 1;
    }
    
    return spawnpoint;
}

// Namespace trial
// Params 1
// Checksum 0x26d47a40, Offset: 0x183b
// Size: 0x1d8
function onplayerconnect( player )
{
    if ( utility::is_trial( "tdm" ) )
    {
        if ( isbot( player ) )
        {
            return;
        }
    }
    
    player thread menus::addtoteam( level.trial[ "team" ] );
    level.teamdata[ "allies" ][ "soundInfix" ] = "uk";
    level.teamdata[ "axis" ][ "soundInfix" ] = "ru";
    player class::function_e84a99f0f4904c66();
    player setclientomnvar( "ui_total_fade", 1 );
    
    if ( isdefined( level.trial_map_loadout ) )
    {
        player.pers[ "gamemodeLoadout" ] = level.trial_map_loadout;
    }
    else
    {
        player.pers[ "gamemodeLoadout" ] = level.trial_loadout[ "axis" ];
    }
    
    if ( level.trial_infinite_reserve_ammo )
    {
        player thread infinite_reserve_ammo();
    }
    
    thread trial_weapon_spawn();
    level waittill( #"player_spawned" );
    
    if ( level.players.size > 1 )
    {
        println( "<dev string:x14a>" );
        exitlevel( 0 );
    }
    
    level.player br::playerexecutionsdisable();
    wait 1;
    thread game_utility::fadetoblackforplayer( player, 0, 0.5 );
    
    if ( game[ "trial" ][ "tries_remaining" ] < level.trial[ "attempts" ] )
    {
        player dialog::leaderdialogonplayer( "trial_retry" );
    }
    else if ( getdvar( @"g_mapname" ) == getdvar( @"old_mapname", "" ) )
    {
        player dialog::leaderdialogonplayer( "trial_intro_short" );
    }
    else
    {
        player dialog::leaderdialogonplayer( "trial_intro" );
    }
    
    setdvar( @"old_mapname", getdvar( @"g_mapname" ) );
    thread trial_restart_watcher();
}

// Namespace trial
// Params 0
// Checksum 0xafedb0c7, Offset: 0x1a1b
// Size: 0x431
function setspecialloadout()
{
    level.trial_loadout[ "axis" ][ "loadoutPrimary" ] = level.defaultfist.var_1616e6fbba9a722d;
    level.trial_loadout[ "axis" ][ "loadoutPrimaryAttachment" ] = "none";
    level.trial_loadout[ "axis" ][ "loadoutPrimaryAttachment2" ] = "none";
    level.trial_loadout[ "axis" ][ "loadoutPrimaryCamo" ] = "none";
    level.trial_loadout[ "axis" ][ "loadoutPrimaryReticle" ] = "none";
    level.trial_loadout[ "axis" ][ "loadoutSecondary" ] = "none";
    level.trial_loadout[ "axis" ][ "loadoutSecondaryAttachment" ] = "none";
    level.trial_loadout[ "axis" ][ "loadoutSecondaryAttachment2" ] = "none";
    level.trial_loadout[ "axis" ][ "loadoutSecondaryCamo" ] = "none";
    level.trial_loadout[ "axis" ][ "loadoutSecondaryReticle" ] = "none";
    level.trial_loadout[ "axis" ][ "loadoutEquipment" ] = "specialty_null";
    level.trial_loadout[ "axis" ][ "loadoutOffhand" ] = "none";
    level.trial_loadout[ "axis" ][ "loadoutStreakType" ] = "assault";
    level.trial_loadout[ "axis" ][ "loadoutKillstreak1" ] = "none";
    level.trial_loadout[ "axis" ][ "loadoutKillstreak2" ] = "none";
    level.trial_loadout[ "axis" ][ "loadoutKillstreak3" ] = "none";
    level.trial_loadout[ "axis" ][ "loadoutPerks" ] = [];
    level.trial_loadout[ "axis" ][ "loadoutGesture" ] = "playerData";
    var_e32a83c85c97e75b = getent( "trial_starting_weapon", #script_noteworthy );
    var_1d35d4dd6b81c59a = getent( "trial_starting_weapon_2", #script_noteworthy );
    
    if ( isdefined( var_e32a83c85c97e75b ) )
    {
        weap_tokens = strtok( var_e32a83c85c97e75b.script_parameters, "+" );
        weap_rootname = weap_tokens[ 0 ];
        weap_attachments = arrayremove( weap_tokens, weap_rootname );
        level.trial_loadout[ "axis" ][ "loadoutPrimary" ] = weap_rootname;
        
        foreach ( i, attachment in weap_attachments )
        {
            if ( !i )
            {
                level.trial_loadout[ "axis" ][ "loadoutPrimaryAttachment" ] = attachment;
                continue;
            }
            
            key = "loadoutPrimaryAttachment" + i + 1;
            level.trial_loadout[ "axis" ][ key ] = attachment;
        }
    }
    
    if ( isdefined( var_1d35d4dd6b81c59a ) )
    {
        weap_tokens = strtok( var_1d35d4dd6b81c59a.script_parameters, "+" );
        weap_rootname = weap_tokens[ 0 ];
        weap_attachments = arrayremove( weap_tokens, weap_rootname );
        level.trial_loadout[ "axis" ][ "loadoutSecondary" ] = weap_rootname;
        
        foreach ( i, attachment in weap_attachments )
        {
            if ( !i )
            {
                level.trial_loadout[ "axis" ][ "loadoutSecondaryAttachment" ] = attachment;
                continue;
            }
            
            key = "loadoutSecondaryAttachment" + i + 1;
            level.trial_loadout[ "axis" ][ key ] = attachment;
        }
    }
    
    level.trial_loadout[ "allies" ] = level.trial_loadout[ "axis" ];
}

// Namespace trial
// Params 0
// Checksum 0xbbbdc0d3, Offset: 0x1e54
// Size: 0x3e
function infinite_reserve_ammo()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"reload_ammo_added" );
        self givemaxammo( self.currentprimaryweapon );
    }
}

// Namespace trial
// Params 0
// Checksum 0xc133d915, Offset: 0x1e9a
// Size: 0x1de
function trial_weapon_spawn()
{
    level.trial_weapons = getentarray( "trial_weapon", #targetname );
    level.trial_akimbo_props = getentarray( "trial_weapon_akimbo_prop", #targetname );
    
    while ( !isdefined( level.weaponmapdata ) )
    {
        waitframe();
    }
    
    waitframe();
    
    foreach ( weapon in level.trial_weapons )
    {
        weapon thread weapon_think();
    }
    
    /#
        challengeid = function_c8e3f9da90e5a76b( trial_utility::trial_fetch_mission_table(), level.trial[ "<dev string:x12d>" ] ).challengeid;
        
        if ( !isdefined( challengeid ) )
        {
            println( "<dev string:x180>" );
            return;
        }
        
        println( "<dev string:x1f9>" );
        println( "<dev string:x254>" );
        print( challengeid );
        
        foreach ( weap in level.trial_weapons )
        {
            if ( isdefined( weap.spawned_weapon ) )
            {
                str = getsubstr( weap.spawned_weapon.classname, 7 );
                print( "<dev string:x255>" + str );
            }
        }
        
        println( "<dev string:x254>" );
    #/
}

// Namespace trial
// Params 0
// Checksum 0x231516b4, Offset: 0x2080
// Size: 0x3a1
function weapon_think()
{
    level.player endon( #"death" );
    weap_tokens = strtok( self.script_parameters, "+" );
    weap_rootname = weap_tokens[ 0 ];
    weap_attachments = arrayremove( weap_tokens, weap_rootname );
    hasnvg = utility::function_2a082dafe6f4bd5b();
    basename = weapon::weaponassetnamemap( weap_rootname );
    weapobj = makeweapon( basename );
    attachmentsvalid = [];
    has_akimbo = 0;
    
    foreach ( a in weap_attachments )
    {
        if ( weapobj canuseattachment( a ) )
        {
            if ( a == "akimbo" )
            {
                has_akimbo = 1;
            }
            
            attachmentsvalid[ attachmentsvalid.size ] = a;
            continue;
        }
        
        assertmsg( "<dev string:x257>" + a + "<dev string:x26c>" + basename );
    }
    
    weap_attachments = attachmentsvalid;
    built_weapon = weapon::buildweapon( weap_rootname, weap_attachments, "camo_none", "none", -1, undefined, undefined, undefined, hasnvg );
    weapon_name = getcompleteweaponname( built_weapon );
    
    if ( has_akimbo )
    {
        thread weapon_akimbo_prop_think( weapon_name );
    }
    
    while ( !isdefined( level.player.primaryinventory[ 0 ] ) )
    {
        waitframe();
    }
    
    while ( true )
    {
        var_4174ab6f8479eabb = 0;
        var_4174aa6f8479e888 = 0;
        
        if ( isdefined( level.player.primaryinventory[ 0 ] ) )
        {
            var_4174ab6f8479eabb = weapon_name == getcompleteweaponname( level.player.primaryinventory[ 0 ] );
        }
        
        if ( isdefined( level.player.primaryinventory[ 1 ] ) )
        {
            var_4174aa6f8479e888 = weapon_name == getcompleteweaponname( level.player.primaryinventory[ 1 ] );
        }
        
        if ( !isdefined( self.spawned_weapon ) && !var_4174ab6f8479eabb && !var_4174aa6f8479e888 )
        {
            self.spawned_weapon = spawn( "weapon_" + weapon_name, self.origin, 17 );
            self.spawned_weapon.angles = self.angles;
            clip_ammo = weaponclipsize( built_weapon );
            reserve_ammo = weaponmaxammo( built_weapon );
            
            if ( isdefined( self.script_noteworthy ) )
            {
                if ( self.script_noteworthy == "outline" )
                {
                    outline::outlineenableforplayer( self.spawned_weapon, level.player, "outline_trial_item", "level_script" );
                }
                else if ( self.script_noteworthy == "osp" )
                {
                    outline::outlineenableforplayer( self.spawned_weapon, level.player, "outlinefill_nodepth_cyan", "level_script" );
                    reserve_ammo = 0;
                }
            }
            
            if ( has_akimbo )
            {
                clip_ammo = 0;
            }
            
            if ( level.player_limitedammo )
            {
                reserve_ammo = level.enemiestotal - clip_ammo;
            }
            
            self.spawned_weapon itemweaponsetammo( clip_ammo, reserve_ammo );
        }
        
        level.player waittill( #"weapon_dropped", droppedent, objweapon );
        
        if ( isdefined( droppedent ) && isdefined( objweapon ) && getcompleteweaponname( objweapon ) == weapon_name )
        {
            droppedent delete();
        }
    }
}

// Namespace trial
// Params 1
// Checksum 0xfa01c229, Offset: 0x2429
// Size: 0x181
function weapon_akimbo_prop_think( weapon_name )
{
    foreach ( prop in level.trial_akimbo_props )
    {
        if ( prop.script_parameters == self.script_parameters )
        {
            self.akimbo_prop = prop;
        }
    }
    
    while ( isdefined( self.akimbo_prop ) )
    {
        while ( !isdefined( self.spawned_weapon ) )
        {
            waitframe();
        }
        
        self.akimbo_prop.spawned_prop = spawn( "weapon_" + weapon_name, self.akimbo_prop.origin, 17 );
        self.akimbo_prop.spawned_prop.angles = self.akimbo_prop.angles;
        self.akimbo_prop.spawned_prop sethintinoperable( 1 );
        
        while ( isdefined( self.spawned_weapon ) )
        {
            waitframe();
        }
        
        if ( isdefined( self.akimbo_prop.spawned_prop ) )
        {
            self.akimbo_prop.spawned_prop delete();
        }
    }
}

// Namespace trial
// Params 0
// Checksum 0xc800f339, Offset: 0x25b2
// Size: 0x149
function trial_end_score_dialogue()
{
    var_a6f8b12ed311ed2f = undefined;
    var_a6f8b22ed311ef62 = undefined;
    var_a6f8b32ed311f195 = undefined;
    main_score = getomnvar( "ui_trial_main_score" );
    main_time = getomnvar( "ui_trial_main_time" );
    
    if ( main_score != -1 )
    {
        var_a6f8b12ed311ed2f = main_score >= getomnvar( "ui_trial_tier_1_requirement" );
        var_a6f8b22ed311ef62 = main_score >= getomnvar( "ui_trial_tier_2_requirement" );
        var_a6f8b32ed311f195 = main_score >= getomnvar( "ui_trial_tier_3_requirement" );
    }
    else if ( main_time != -1 )
    {
        var_a6f8b12ed311ed2f = main_time <= getomnvar( "ui_trial_tier_1_requirement" );
        var_a6f8b22ed311ef62 = main_time <= getomnvar( "ui_trial_tier_2_requirement" );
        var_a6f8b32ed311f195 = main_time <= getomnvar( "ui_trial_tier_3_requirement" );
    }
    
    if ( level.trial_fail_alt )
    {
        level.trial_fail_alt = 0;
        dialog = "trial_end_tier_0_alt";
    }
    else if ( var_a6f8b32ed311f195 )
    {
        dialog = "trial_end_tier_3";
    }
    else if ( var_a6f8b22ed311ef62 )
    {
        dialog = "trial_end_tier_2";
    }
    else if ( var_a6f8b12ed311ed2f )
    {
        dialog = "trial_end_tier_1";
    }
    else
    {
        dialog = "trial_end_tier_0";
    }
    
    level.player dialog::leaderdialogonplayer( dialog );
    trial_utility::trial_ui_waittill_retry();
    
    if ( !level.trial_restarting )
    {
        level.player dialog::leaderdialogonplayer( "trial_retry" );
    }
}

// Namespace trial
// Params 0
// Checksum 0x46ee943d, Offset: 0x2703
// Size: 0xd3
function trial_retrieve_persistent_values()
{
    if ( !isdefined( game[ "trial" ] ) )
    {
        game[ "trial" ] = [];
    }
    
    if ( !isdefined( game[ "trial" ][ "best_score" ] ) )
    {
        game[ "trial" ][ "best_score" ] = -1;
    }
    
    if ( !isdefined( game[ "trial" ][ "best_time" ] ) )
    {
        game[ "trial" ][ "best_time" ] = -1;
    }
    
    if ( !isdefined( game[ "trial" ][ "tries_remaining" ] ) )
    {
        game[ "trial" ][ "tries_remaining" ] = level.trial[ "attempts" ];
    }
    
    setomnvar( "ui_trial_best_score", int( game[ "trial" ][ "best_score" ] ) );
    setomnvar( "ui_trial_best_time", int( game[ "trial" ][ "best_time" ] ) );
    setomnvar( "ui_trial_tries_remaining", int( game[ "trial" ][ "tries_remaining" ] ) );
}

// Namespace trial
// Params 0
// Checksum 0x2542284, Offset: 0x27de
// Size: 0x4a
function trial_restart_watcher()
{
    while ( true )
    {
        level.player waittill( #"luinotifyserver", msg );
        
        if ( msg == "trial_restart" )
        {
            if ( !level.isinrewardflow )
            {
                trial_utility::trial_restart();
            }
        }
    }
}

// Namespace trial
// Params 0
// Checksum 0x34dc7097, Offset: 0x2830
// Size: 0x45
function processlobbydata()
{
    processlobbydataforclient( level.player );
    
    if ( game_utility_mp::matchmakinggame() && !game_utility_mp::privatematch() )
    {
        setclientmatchdata( "isPublicMatch", 1 );
    }
    else
    {
        setclientmatchdata( "isPublicMatch", 0 );
    }
    
    sendclientmatchdata();
}

// Namespace trial
// Params 1
// Checksum 0xc04ad65b, Offset: 0x287d
// Size: 0x1f8
function processlobbydataforclient( player )
{
    if ( player.processlobbydataforclient )
    {
        return;
    }
    
    player.processlobbydataforclient = 1;
    
    if ( isdefined( player ) && !isdefined( player.clientmatchdataid ) )
    {
        player.clientmatchdataid = level.currentclientmatchdataid;
        level.currentclientmatchdataid++;
    }
    
    playername = player.name;
    setclientmatchdata( "players", player.clientmatchdataid, "clanTag", player getclantag() );
    setclientmatchdata( "players", player.clientmatchdataid, "xuidHigh", player getxuidhigh() );
    setclientmatchdata( "players", player.clientmatchdataid, "xuidLow", player getxuidlow() );
    setclientmatchdata( "players", player.clientmatchdataid, "isBot", isbot( player ) );
    setclientmatchdata( "players", player.clientmatchdataid, "uniqueClientId", player.clientid );
    setclientmatchdata( "players", player.clientmatchdataid, "username", playername );
    
    if ( player function_787b88bd6601ec4a() )
    {
        setclientmatchdata( "players", player.clientmatchdataid, "platform", "ps4" );
    }
    else if ( player function_71b99fed77af9be5() )
    {
        setclientmatchdata( "players", player.clientmatchdataid, "platform", "xb3" );
    }
    else if ( player ispcplayer() )
    {
        setclientmatchdata( "players", player.clientmatchdataid, "platform", "bnet" );
    }
    else
    {
        setclientmatchdata( "players", player.clientmatchdataid, "platform", "none" );
    }
    
    player setplayerdata( "common", "round", "clientMatchIndex", player.clientmatchdataid );
}

/#

    // Namespace trial
    // Params 0
    // Checksum 0xe194b5d6, Offset: 0x2a7d
    // Size: 0xc, Type: dev
    function trial_debug_init()
    {
        thread function_7e765aa1ba054f45();
    }

    // Namespace trial
    // Params 0
    // Checksum 0xac393f53, Offset: 0x2a91
    // Size: 0x4a, Type: dev
    function function_7e765aa1ba054f45()
    {
        setdevdvarifuninitialized( @"trial_force_tier", -1 );
        
        while ( true )
        {
            force_tier = getdvarint( @"trial_force_tier", -1 );
            
            if ( force_tier != -1 )
            {
                trial_utility::trial_force_tier( force_tier );
            }
            
            waitframe();
        }
    }

#/
