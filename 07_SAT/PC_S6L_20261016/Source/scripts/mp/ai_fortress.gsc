// scripts\mp\ai_fortress.gsc  (hash_4948cdf739393d2d.gscc) (size: 54176 Bytes / 0xd3a0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1988ecc8 (428403912)
// size ...... 54176 (0xd3a0)
// includes .. 17  (offset: 0xc854)
// strings ... 143 (offset: 0xc8dc)
// dev strs .. 12  (offset: 0xd310)
// exports ... 99  (offset: 0x9a1c)
// cseg ...... 0xccd + 0x8d4f (0x9a1c)
// imports ... 227 (offset: 0xa994)
// animtree1 . 0   (offset: 0xd3a0)
// animtree2 . 0   (offset: 0xd3a0)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\ai_loot;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_strongholds;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\flags;
#using scripts\mp\locksandkeys;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_database;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\poi;

#namespace ai_fortress;

// Namespace ai_fortress
// Params 0
// Checksum 0xd1585ccd, Offset: 0xceb
// Size: 0x6cc
function fortress_init()
{
    level endon( #"game_ended" );
    
    if ( getdvarint( @"scr_fortress_enabled", 1 ) != 1 )
    {
        return;
    }
    
    setdvar( @"scr_fortress_debug", 0 );
    
    while ( !isdefined( level.struct_class_names ) )
    {
        waitframe();
    }
    
    while ( !utility::flag_exist( "create_script_initialized" ) )
    {
        if ( !utility::flag_exist( "poi_initialized" ) )
        {
            waitframe();
            continue;
        }
        
        break;
    }
    
    while ( !utility::flag_exist( "poi_initialized" ) )
    {
        utility::flag_wait( "create_script_initialized" );
    }
    
    utility::registersharedfunc( #"insideoutside", #"hash_52dba1b85cf38a4", &function_aa6a893e932e7e72 );
    waitframe();
    
    if ( !level.var_1395680c28bfd693 )
    {
        level.var_1395680c28bfd693 = "fortress_scriptable_props";
    }
    
    level.lockedvolumes = [];
    level.var_13f258417276805a = [];
    level.fortressstruct = spawnstruct();
    level.fortressstruct.var_db1aefa5b9c86d7e = [];
    function_834f23887347e96c();
    function_b87abf909b8645fe();
    function_25705913cbce22ba();
    flags::gameflaginit( "fortresses_spawned", 0 );
    
    if ( utility::issharedfuncdefined( #"fortress", #"acknowledge" ) )
    {
        [[ utility::getsharedfunc( #"fortress", #"acknowledge" ) ]]();
    }
    else
    {
        function_2bf958ce8acd32b0();
    }
    
    function_fb0496a23c311eba();
    
    if ( !isdefined( level.aibudgets ) )
    {
        level.aibudgets = spawnstruct();
    }
    
    if ( !isdefined( level.aibudgets.fortresses ) )
    {
        level.aibudgets.fortresses = [];
    }
    
    level.fortressstruct.var_cc840119c283f99c[ "small" ] = getdvarint( @"hash_44c6b04f31cd85c2", 4 );
    level.fortressstruct.var_cc840119c283f99c[ "medium" ] = getdvarint( @"hash_153cef3a49bced1c", 7 );
    level.fortressstruct.var_cc840119c283f99c[ "large" ] = getdvarint( @"hash_b5a2dce30d58a61e", 9 );
    level.fortressstruct.var_cc840119c283f99c[ "hero" ] = getdvarint( @"hash_489d69be23c1889f", 20 );
    level.fortressstruct.var_cc840119c283f99c[ "hero_epic" ] = getdvarint( @"hash_d951db3ddbc5f88d", 20 );
    level.fortressstruct.var_cc840119c283f99c[ "hero_disabled" ] = getdvarint( @"hash_489d69be23c1889f", 7 );
    level.fortressstruct.var_f7f64677aa3274ad[ "small" ] = getdvarint( @"hash_d058080352ecc66b", 1 );
    level.fortressstruct.var_f7f64677aa3274ad[ "medium" ] = getdvarint( @"hash_bdf93d46f026ff4b", 2 );
    level.fortressstruct.var_f7f64677aa3274ad[ "large" ] = getdvarint( @"hash_8318724c082ee73", 2 );
    level.fortressstruct.var_f7f64677aa3274ad[ "hero" ] = getdvarint( @"hash_8318724c082ee73", 2 );
    level.fortressstruct.var_f7f64677aa3274ad[ "hero_epic" ] = getdvarint( @"hash_8318724c082ee73", 2 );
    level.fortressstruct.var_f7f64677aa3274ad[ "hero_disabled" ] = getdvarint( @"hash_8318724c082ee73", 1 );
    level.fortressstruct.var_965a551489d6fcd5[ "small" ] = getmatchrulesdata( "fortressData", "numRiotshieldSmall" ) ?? 1;
    level.fortressstruct.var_965a551489d6fcd5[ "medium" ] = getmatchrulesdata( "fortressData", "numRiotshieldMedium" ) ?? 2;
    level.fortressstruct.var_965a551489d6fcd5[ "large" ] = getmatchrulesdata( "fortressData", "numRiotshieldLarge" ) ?? 2;
    level.fortressstruct.var_965a551489d6fcd5[ "hero" ] = getmatchrulesdata( "fortressData", "numRiotshieldHero" ) ?? 2;
    level.fortressstruct.var_965a551489d6fcd5[ "hero_epic" ] = getmatchrulesdata( "fortressData", "numRiotshieldHeroEpic" ) ?? 3;
    level.fortressstruct.var_965a551489d6fcd5[ "hero_disabled" ] = 0;
    level.var_83060e4064407d85 = getmatchrulesdata( "fortressData", "spawnTraps" ) ?? 1;
    setdvar( @"hash_9d95d1671eeaf942", 0 );
    level.fortressagentcallbacks = spawnstruct();
    level.fortressagentcallbacks.var_66ed919d586cec20 = &function_be2642b94f737075;
    level.fortressagentcallbacks.ondeath = &function_4487a94e9ab1367;
    
    if ( isdefined( level.var_c4303b727f0cc395 ) )
    {
        [[ level.var_c4303b727f0cc395 ]]();
    }
    
    foreach ( fortress in level.fortressstruct.chosenfortresses )
    {
        function_d9f4f0632c1968e( fortress );
    }
    
    foreach ( fortress in level.fortressstruct.reservedfortresses )
    {
        function_d9f4f0632c1968e( fortress );
    }
    
    level.fortressstruct.gatheredvolumes = 1;
    ai_mp_controller::function_7f833bacb64445a6();
    
    if ( utility::issharedfuncdefined( #"fortress", #"spawn" ) )
    {
        [[ utility::getsharedfunc( #"fortress", #"spawn" ) ]]();
    }
    else
    {
        function_863bcb5459ab457d();
    }
    
    flags::gameflagset( "fortresses_spawned" );
    level thread function_8a52ff7b928bd67b();
    level.fortressstruct.var_6dc29464d93d3edd = 1;
    flags::gameflaginit( "fortress_init", 1 );
    callback::add( #"on_spawn_agent", &onspawnagent );
    
    /#
        level thread function_65bb1a4a5da15a56();
        level thread function_6ea41bc157949f11();
    #/
}

// Namespace ai_fortress
// Params 1, eflags: 0x4
// Checksum 0x61b50ce5, Offset: 0x13bf
// Size: 0x56
function private onspawnagent( params )
{
    agent = self;
    
    if ( !flags::gameflag( "prematch_done" ) && !isdefined( agent.insidegoalvolume ) )
    {
        agent.insidegoalvolume = function_aa6a893e932e7e72( agent.origin );
    }
}

// Namespace ai_fortress
// Params 0
// Checksum 0x628e2261, Offset: 0x141d
// Size: 0x1b3
function function_863bcb5459ab457d()
{
    foreach ( fortress in level.fortressstruct.chosenfortresses )
    {
        if ( fortress.isactive )
        {
            continue;
        }
        
        if ( isdefined( fortress.poiname ) && isdefined( fortress.subarea.subareaname ) && isdefined( level.poi[ fortress.poiname ][ "subAreas" ][ fortress.subarea.subareaname ].tuning ) )
        {
            fortress.tieroverride = level.poi[ fortress.poiname ][ "subAreas" ][ fortress.subarea.subareaname ].tuning.difficultyrating;
        }
        
        fortress.script_poi = poi::poi_findpoioriginisin( fortress.origin );
        
        if ( !utility::callsharedfunc( #"poi", #"isactive", fortress.origin, fortress.script_poi ) )
        {
            continue;
        }
        
        if ( !function_c4cc2f9a17167e1b( fortress ) )
        {
            fortress_lockdown( fortress );
        }
    }
    
    function_c75d278f58491fe6();
}

// Namespace ai_fortress
// Params 1
// Checksum 0x6cee8c9c, Offset: 0x15d8
// Size: 0xb6
function function_3e50d47832ee4d97( fortress )
{
    if ( !isdefined( level.aibudgets.fortresses ) )
    {
        level.aibudgets.fortresses = [];
    }
    
    index = level.aibudgets.fortresses.size;
    level.aibudgets.fortresses[ index ] = spawnstruct();
    level.aibudgets.fortresses[ index ].totalagents = 0;
    fortress.budgetstruct = level.aibudgets.fortresses[ index ];
}

// Namespace ai_fortress
// Params 0
// Checksum 0xdb140ddf, Offset: 0x1696
// Size: 0x44c
function function_b87abf909b8645fe()
{
    potentialfortress = utility::getstructarray( "outpost", "targetname" );
    var_24b793d53a88c25e = utility::getstructarray( "fortress", "targetname" );
    potentialfortress = arraycombine( potentialfortress, var_24b793d53a88c25e );
    var_1f188729b140132e = [];
    
    foreach ( fortress in potentialfortress )
    {
        if ( isnavmeshloaded() )
        {
            navpoint = getclosestpointonnavmesh( fortress.origin );
        }
        else
        {
            navpoint = fortress.origin;
        }
        
        onnavmesh = distance2dsquared( navpoint, fortress.origin ) < 1048576;
        
        if ( level.mapname == "mp_rex_dmz_freshstart" && !onnavmesh )
        {
            continue;
        }
        
        assert( onnavmesh, "<dev string:x24>" + fortress.origin + "<dev string:x31>" );
        
        if ( distance2dsquared( navpoint, fortress.origin ) < 1048576 )
        {
            fortress.flags = strtok( tolower( fortress.script_noteworthy ), "|" );
            
            foreach ( flag in fortress.flags )
            {
                if ( issubstr( flag, "hero" ) )
                {
                    if ( arraycontains( fortress.flags, "notacmap" ) )
                    {
                        fortress.var_36b98792086e5abc = 1;
                        fortress.fortresssize = "medium";
                    }
                    else
                    {
                        fortress.ishero = 1;
                        fortress.fortresssize = "hero";
                    }
                    
                    function_a33ba50e0733f6fe( fortress );
                    continue;
                }
                
                if ( issubstr( flag, "small" ) )
                {
                    fortress.fortresssize = "small";
                    continue;
                }
                
                if ( issubstr( flag, "medium" ) )
                {
                    fortress.fortresssize = "medium";
                    continue;
                }
                
                if ( issubstr( flag, "large" ) )
                {
                    fortress.fortresssize = "large";
                    continue;
                }
                
                if ( flag == "hostage" )
                {
                    fortress.hostagefortress = 1;
                }
            }
            
            if ( !isdefined( fortress.fortresssize ) )
            {
                println( "<dev string:x4a>" + fortress.origin );
                fortress.fortresssize = "small";
            }
            
            if ( !isdefined( fortress.target ) )
            {
                fortress.invalidfortress = 1;
            }
            
            if ( !isdefined( fortress.area ) )
            {
                fortress.areaname = utility::callsharedfunc( #"poi", #"area_findoriginisin", fortress.origin, undefined, 1 );
            }
            
            if ( !isdefined( fortress.poiname ) )
            {
                fortress.poiname = utility::callsharedfunc( #"poi", #"hash_79b3b95992c86428", fortress.origin, 1 );
            }
            
            if ( !isdefined( fortress.poiname ) )
            {
                fortress.subarea = utility::callsharedfunc( #"poi", #"hash_8dbb0d45f903ae1c", fortress.origin, fortress.areaname, undefined, 1 );
            }
            
            fortress.noteworthy = function_bc6ca17f884fb790( fortress );
            var_1f188729b140132e[ var_1f188729b140132e.size ] = fortress;
        }
    }
    
    level.fortressstruct.var_1f188729b140132e = var_1f188729b140132e;
    level.fortressstruct.var_a9ebedf0eab50c7 = [];
}

// Namespace ai_fortress
// Params 1
// Checksum 0xbcc6b6d5, Offset: 0x1aea
// Size: 0x9a
function function_fa4b28e564486a6a( target )
{
    foreach ( fortress in level.fortressstruct.var_1f188729b140132e )
    {
        if ( fortress.target == target )
        {
            return fortress;
        }
    }
}

// Namespace ai_fortress
// Params 0
// Checksum 0xed0cb128, Offset: 0x1b8d
// Size: 0x222
function function_2bf958ce8acd32b0()
{
    level.fortressstruct.chosenfortresses = [];
    level.fortressstruct.unusedfortresses = [];
    level.fortressstruct.reservedfortresses = [];
    level.fortressstruct.var_1f188729b140132e = arrayrandomize( level.fortressstruct.var_1f188729b140132e );
    var_f7551e333b6feae2 = 3;
    level.fortressstruct.unusedfortresses = level.fortressstruct.var_1f188729b140132e;
    fortresslistall = function_1cd7d9f75ac6271f() ?? [];
    fortresslistmain = function_a4cb275d513c0521() ?? [];
    
    foreach ( target in fortresslistall )
    {
        fortress = function_fa4b28e564486a6a( target );
        
        if ( isdefined( fortress ) )
        {
            if ( fortress.hostagefortress && !arraycontains( fortresslistmain, target ) )
            {
                level.fortressstruct.reservedfortresses[ level.fortressstruct.reservedfortresses.size ] = fortress;
                level.fortressstruct.unusedfortresses = arrayremove( level.fortressstruct.unusedfortresses, fortress );
                continue;
            }
            
            fortress.fortresstype = "mainFortress";
            level.fortressstruct.chosenfortresses[ level.fortressstruct.chosenfortresses.size ] = fortress;
            level.fortressstruct.unusedfortresses = arrayremove( level.fortressstruct.unusedfortresses, fortress );
        }
    }
}

// Namespace ai_fortress
// Params 1
// Checksum 0x55ca7fac, Offset: 0x1db7
// Size: 0x155
function function_5750ae701598bca0( corenode )
{
    corenode.guardnodes = [];
    corenode.patrolpaths = [];
    corenode.lockeddoors = [];
    corenode.var_c6ae840b3c497571 = [];
    corenode.lockeddoors_interior = [];
    corenode.firebarrels = [];
    corenode.gaspuddles = [];
    corenode.propflags = [];
    corenode.props = [];
    corenode.hostagenodes = [];
    corenode.var_b88b2430b2749438 = [];
    corenode.var_ae809545725a5038 = [];
    corenode.fortressvolumes = [];
    corenode.var_8e2bf9f56174615d = [];
    corenode.var_8e2bf9f56174615d[ "default" ] = [];
    corenode.var_8e2bf9f56174615d[ "hostage" ] = [];
    corenode.spawnzones = [];
    corenode.spawnzones[ "high" ] = [];
    corenode.spawnzones[ "medium" ] = [];
    corenode.spawnzones[ "low" ] = [];
    corenode.allzones = [];
    corenode.var_f09146bdfc65287d = [];
    corenode.var_72a8bdabe181c6f9 = [];
}

// Namespace ai_fortress
// Params 2
// Checksum 0x3693f32f, Offset: 0x1f14
// Size: 0x76e
function function_2a92b0d526c70806( corenode, keynameoverride )
{
    if ( corenode.invalidfortress )
    {
        return;
    }
    
    fortressnodes = arraycombine( utility::getstructarray( corenode.target, "targetname" ), getentarray( corenode.target, #targetname ), getnoentvolumearray( corenode.target, #targetname ) );
    function_5750ae701598bca0( corenode );
    corenode.defenselevel = function_77dda672e0ff3625();
    subarea = utility::callsharedfunc( #"poi", #"hash_8dbb0d45f903ae1c", corenode.origin );
    corenode.subarea = subarea;
    corenode.script_poi = poi::poi_findpoioriginisin( corenode.origin );
    corenode.var_5f15528aa0b89a = undefined;
    
    if ( !( isdefined( corenode.ishero ) && isdefined( corenode.var_36b98792086e5abc ) ) )
    {
        if ( issubstr( corenode.script_noteworthy, "hero" ) )
        {
            if ( issubstr( corenode.script_noteworthy, "noTacMap" ) )
            {
                corenode.var_36b98792086e5abc = 1;
            }
            else
            {
                corenode.ishero = 1;
            }
        }
    }
    
    function_4e403ddb91a1c58( corenode, fortressnodes, keynameoverride );
    var_331696182a56dd15 = 256;
    var_c300a493217bee56 = squared( var_331696182a56dd15 );
    strongholdpackages = [];
    var_61e2a31dd8cd0b28 = [];
    strongholdselectors = utility::getstructarray( "agent_strongholdselector", "script_agent_noteworthy" );
    strongholdselectors = sortbydistancecullbyradius( strongholdselectors, corenode.origin, var_331696182a56dd15 );
    
    if ( isdefined( strongholdselectors[ 0 ] ) )
    {
        closestselector = strongholdselectors[ 0 ];
        corenode.var_8e2bf9f56174615d[ "default" ][ corenode.var_8e2bf9f56174615d[ "default" ].size ] = closestselector;
        selectornodes = utility::getstructarray( closestselector.target, "targetname" );
        
        foreach ( node in selectornodes )
        {
            if ( node.script_agent_noteworthy == "agent_strongholdpackage" )
            {
                strongholdpackages[ strongholdpackages.size ] = node;
                continue;
            }
            
            if ( node.script_noteworthy == "hostage_strongholdselector" )
            {
                corenode.var_8e2bf9f56174615d[ "hostage" ][ corenode.var_8e2bf9f56174615d[ "hostage" ].size ] = node;
            }
        }
        
        foreach ( package in strongholdpackages )
        {
            if ( isdefined( package ) && isdefined( closestselector ) )
            {
                if ( package.disabled == "0" || !isdefined( package.disabled ) )
                {
                    if ( isdefined( level.var_6c32e5d8baac049b ) && isdefined( package.groupid ) && tolower( level.var_6c32e5d8baac049b ) != tolower( package.groupid ) )
                    {
                        continue;
                    }
                    
                    if ( isdefined( package.script_required ) && int( package.script_required ) == 1 )
                    {
                        if ( !isdefined( var_61e2a31dd8cd0b28 ) )
                        {
                            var_61e2a31dd8cd0b28 = [];
                        }
                        
                        var_61e2a31dd8cd0b28[ var_61e2a31dd8cd0b28.size ] = package;
                        strongholdpackages = arrayremove( strongholdpackages, package );
                    }
                    
                    continue;
                }
                
                strongholdpackages = arrayremove( strongholdpackages, package );
            }
        }
    }
    else
    {
        strongholdpackages = utility::getstructarray( "agent_strongholdpackage", "script_agent_noteworthy" );
        strongholdpackages = sortbydistance( strongholdpackages, corenode.origin );
        
        foreach ( package in strongholdpackages )
        {
            if ( isdefined( package ) )
            {
                if ( package.disabled == "0" || !isdefined( package.disabled ) )
                {
                    var_796124f3a5e4fa2e = distance2dsquared( corenode.origin, package.origin );
                    
                    if ( var_796124f3a5e4fa2e < var_c300a493217bee56 )
                    {
                        if ( !isdefined( var_61e2a31dd8cd0b28 ) )
                        {
                            var_61e2a31dd8cd0b28 = [];
                        }
                        
                        var_61e2a31dd8cd0b28[ var_61e2a31dd8cd0b28.size ] = package;
                        strongholdpackages = [];
                        break;
                    }
                    
                    strongholdpackages = [];
                    break;
                }
            }
        }
    }
    
    if ( isdefined( strongholdpackages[ 0 ] ) )
    {
        if ( isdefined( level.var_6c32e5d8baac049b ) )
        {
            strongholdpackages = arrayrandomize( strongholdpackages );
            
            foreach ( package in strongholdpackages )
            {
                if ( isdefined( level.var_6c32e5d8baac049b ) && isdefined( package.groupid ) && tolower( level.var_6c32e5d8baac049b ) != tolower( package.groupid ) )
                {
                    continue;
                }
                
                activepackages = arraycombine( var_61e2a31dd8cd0b28 ?? [], [ package ] );
                break;
            }
        }
        else
        {
            randompackage = utility::array_random( strongholdpackages );
            activepackages = arraycombine( var_61e2a31dd8cd0b28 ?? [], [ randompackage ] );
        }
    }
    else
    {
        activepackages = var_61e2a31dd8cd0b28;
    }
    
    var_1a7561fa8432c34d = [];
    
    foreach ( package in activepackages )
    {
        var_293bed0afc63f909 = utility::getstructarray( package.target, "targetname" );
        var_1a7561fa8432c34d = arraycombine( var_1a7561fa8432c34d, var_293bed0afc63f909 );
    }
    
    function_4e403ddb91a1c58( corenode, var_1a7561fa8432c34d, keynameoverride );
    
    if ( !isdefined( corenode.fortressvolumes ) || corenode.fortressvolumes.size == 0 )
    {
        corenode.fortressvolumes = level.var_8ea6e2a4c9dc0cf6;
        vol = function_47c86977a18df38b( corenode.fortressvolumes, corenode.origin );
        
        if ( isdefined( vol.targetname ) )
        {
            corenode.fortressvolumes = arraycombine( getentarray( vol.targetname, #targetname ), getnoentvolumearray( vol.targetname, #targetname ) );
            return;
        }
        
        corenode.fortressvolumes = [ vol ];
    }
}

// Namespace ai_fortress
// Params 3
// Checksum 0xcf3df114, Offset: 0x268a
// Size: 0x62c
function function_4e403ddb91a1c58( corenode, targetarray, keynameoverride )
{
    var_9e9a236b162bc567 = [];
    
    if ( !isarray( targetarray ) )
    {
        targetarray = [ targetarray ];
    }
    
    foreach ( node in targetarray )
    {
        if ( isdefined( node.script_agent_noteworthy ) )
        {
            if ( node.script_agent_noteworthy == "agent_strongholdselector" || node.script_agent_noteworthy == "agent_strongholdpackage" )
            {
                continue;
            }
        }
        
        script_noteworthy = tolower( node.script_noteworthy );
        
        if ( !isdefined( node.angles ) )
        {
            node.angles = ( 0, 0, 0 );
        }
        
        if ( issubstr( node.script_noteworthy, "flag" ) || issubstr( node.script_noteworthy, "banner" ) )
        {
            corenode.propflags[ corenode.propflags.size ] = node;
            continue;
        }
        
        if ( node.script_agent_noteworthy == "agent_spawnnode_guard" )
        {
            corenode.guardnodes[ corenode.guardnodes.size ] = node;
            continue;
        }
        else if ( issubstr( script_noteworthy, "spawnzone" ) )
        {
            struct = spawnstruct();
            struct.volume = node;
            struct.guardnodes = [];
            struct.agenttarget = 0;
            
            if ( issubstr( script_noteworthy, "high" ) )
            {
                corenode.spawnzones[ "high" ][ corenode.spawnzones[ "high" ].size ] = struct;
            }
            else if ( issubstr( script_noteworthy, "medium" ) )
            {
                corenode.spawnzones[ "medium" ][ corenode.spawnzones[ "medium" ].size ] = struct;
            }
            else if ( issubstr( script_noteworthy, "low" ) )
            {
                corenode.spawnzones[ "low" ][ corenode.spawnzones[ "low" ].size ] = struct;
            }
            
            continue;
        }
        
        switch ( script_noteworthy )
        {
            case #"hash_b7da16f051f10de8":
                break;
            case #"hash_2f55af2a3f68d894":
                pathstruct = ai_mp_controller::function_ad7994ce0f8a6d54( node );
                corenode.patrolpaths[ corenode.patrolpaths.size ] = pathstruct;
                break;
            case #"hash_cd0ffa281c8e3a8":
                shouldlock = undefined;
                
                if ( isdefined( node.var_6f5274b58684eec8 ) )
                {
                    shouldlock = istrue( int( node.var_6f5274b58684eec8 ) );
                }
                
                keyname = "fortress";
                
                if ( isdefined( keynameoverride ) )
                {
                    keyname = keynameoverride;
                }
                else if ( isdefined( node.script_keynameoverride ) )
                {
                    keyname = node.script_keynameoverride;
                }
                
                var_66c59db8aa0c38e5 = undefined;
                
                if ( !node.var_45492c22e66aac80 )
                {
                    var_66c59db8aa0c38e5 = corenode.script_noteworthy;
                }
                
                corenode.lockeddoors = locksandkeys::function_f4d67875159a0119( node, corenode.lockeddoors, keyname, 0, shouldlock, var_66c59db8aa0c38e5 );
                break;
            case #"hash_82d4ca2cd6f8385e":
                if ( isdefined( node.script_keynameoverride ) )
                {
                    keyname = node.script_keynameoverride;
                }
                else
                {
                    break;
                }
                
                doors = locksandkeys::function_f4d67875159a0119( node, [], keyname, 0 );
                
                foreach ( door in doors )
                {
                    door.var_e582bbdce07db643 = 1;
                }
                
                corenode.lockeddoors = arraycombine( doors, corenode.lockeddoors );
                break;
            case #"hash_5f38efa839d14045":
                corenode.var_f09146bdfc65287d[ corenode.var_f09146bdfc65287d.size ] = node;
                break;
            case #"hash_a0a74a8a22d1d16":
                keyname = "stuck";
                corenode.var_c6ae840b3c497571 = locksandkeys::function_f4d67875159a0119( node, corenode.var_c6ae840b3c497571, keyname, 0 );
                break;
            case #"hash_800a6d0437386f09":
                corenode.laddercovers[ corenode.laddercovers.size ] = node;
                break;
            case #"hash_32d78286d133011e":
                corenode.fortressvolumes[ corenode.fortressvolumes.size ] = node;
                break;
            case #"hash_44424dd83e5be405":
                corenode.firebarrels[ corenode.firebarrels.size ] = node;
                break;
            case #"hash_a84e8c7c29718ade":
                corenode.gaspuddles[ corenode.gaspuddles.size ] = node;
                break;
            case #"hash_8756bee9b861200":
                break;
            case #"hash_d33f462c9ac49ccb":
                corenode.var_5f15528aa0b89a = node;
                break;
            case #"hash_ade45bf37140e568":
                corenode.hostagenodes[ corenode.hostagenodes.size ] = node;
                break;
            case #"hash_ae3be6cce12c848e":
                corenode.var_ae809545725a5038[ corenode.var_ae809545725a5038.size ] = node;
                break;
            default:
                corenode.props[ corenode.props.size ] = node;
                break;
        }
    }
}

// Namespace ai_fortress
// Params 0
// Checksum 0x22af7d11, Offset: 0x2cbe
// Size: 0x85
function function_fb0496a23c311eba()
{
    foreach ( var_7de89c0bc99310a3 in level.fortressstruct.unusedfortresses )
    {
        function_4eae7a70e05936af( var_7de89c0bc99310a3 );
    }
}

// Namespace ai_fortress
// Params 1
// Checksum 0x86d332e3, Offset: 0x2d4b
// Size: 0x4ba
function function_4eae7a70e05936af( corenode )
{
    if ( corenode.invalidfortress )
    {
        return;
    }
    
    var_331696182a56dd15 = 512;
    var_c300a493217bee56 = squared( var_331696182a56dd15 );
    strongholdpackages = [];
    strongholdselectors = utility::getstructarray( "agent_strongholdselector", "script_agent_noteworthy" );
    strongholdselectors = sortbydistancecullbyradius( strongholdselectors, corenode.origin, var_331696182a56dd15 );
    
    if ( isdefined( strongholdselectors[ 0 ] ) )
    {
        closestselector = strongholdselectors[ 0 ];
    }
    
    if ( isdefined( closestselector ) )
    {
        selectornodes = utility::getstructarray( closestselector.target, "targetname" );
        
        foreach ( node in selectornodes )
        {
            if ( node.script_agent_noteworthy == "agent_strongholdpackage" )
            {
                strongholdpackages[ strongholdpackages.size ] = node;
            }
        }
    }
    else
    {
        potentialpackages = utility::getstructarray( "agent_strongholdpackage", "script_agent_noteworthy" );
        potentialpackages = sortbydistance( potentialpackages, corenode.origin );
        
        foreach ( package in potentialpackages )
        {
            if ( isdefined( package ) )
            {
                if ( package.disabled == "0" || !isdefined( package.disabled ) )
                {
                    var_796124f3a5e4fa2e = distance2dsquared( corenode.origin, package.origin );
                    
                    if ( var_796124f3a5e4fa2e < var_c300a493217bee56 )
                    {
                        if ( !isdefined( strongholdpackages ) )
                        {
                            strongholdpackages = [];
                        }
                        
                        strongholdpackages[ strongholdpackages.size ] = package;
                    }
                }
            }
        }
    }
    
    var_1a7561fa8432c34d = [];
    
    foreach ( package in strongholdpackages )
    {
        var_293bed0afc63f909 = utility::getstructarray( package.target, "targetname" );
        var_1a7561fa8432c34d = arraycombine( var_1a7561fa8432c34d, var_293bed0afc63f909 );
    }
    
    var_aba1f0c16799dd78 = [];
    
    foreach ( node in var_1a7561fa8432c34d )
    {
        if ( !node.script_agent_noteworthy )
        {
            continue;
        }
        
        if ( node.script_agent_noteworthy == "agent_spawnnode_guard" )
        {
            var_aba1f0c16799dd78[ var_aba1f0c16799dd78.size ] = node;
        }
    }
    
    if ( !isdefined( corenode.fortressvolumes ) || corenode.fortressvolumes.size == 0 )
    {
        corenode.fortressvolumes = [];
        vol = function_47c86977a18df38b( level.var_8ea6e2a4c9dc0cf6, corenode.origin );
        
        if ( isdefined( vol.targetname ) )
        {
            corenode.fortressvolumes = arraycombine( getentarray( vol.targetname, #targetname ), getnoentvolumearray( vol.targetname, #targetname ) );
        }
        else
        {
            corenode.fortressvolumes = [ vol ];
        }
    }
    
    foreach ( node in var_aba1f0c16799dd78 )
    {
        if ( function_b503355797d23e54( node.origin, corenode ) )
        {
            if ( !isdefined( corenode.spawnclosetnodes ) )
            {
                corenode.spawnclosetnodes = [];
            }
            
            corenode.spawnclosetnodes[ corenode.spawnclosetnodes.size ] = node;
        }
    }
}

// Namespace ai_fortress
// Params 0
// Checksum 0xb8025f9, Offset: 0x320d
// Size: 0x136
function function_dfa24e61d67c313d()
{
    var_c26a5fcf7c11be6a = getdvarint( @"hash_fc146a67ce24927c", 3 );
    
    if ( var_c26a5fcf7c11be6a <= 0 )
    {
        return;
    }
    
    var_c749eb918e1b9a2f = getdvarint( @"hash_a12a51b8c9c5fafb", 8 );
    var_39a030cd5dde889a = 0;
    
    foreach ( var_7de89c0bc99310a3 in level.fortressstruct.unusedfortresses )
    {
        var_7de89c0bc99310a3.var_becf1c8f802be0c3 = arrayrandomize( var_7de89c0bc99310a3.var_becf1c8f802be0c3 );
        
        for ( i = 0; i < var_c26a5fcf7c11be6a ; i++ )
        {
            if ( isdefined( var_7de89c0bc99310a3.var_becf1c8f802be0c3[ i ] ) )
            {
                glassradiusdamage( var_7de89c0bc99310a3.var_becf1c8f802be0c3[ i ].origin, 100, 64, 0 );
                var_39a030cd5dde889a++;
            }
            
            if ( var_39a030cd5dde889a == var_c749eb918e1b9a2f )
            {
                waitframe();
                var_39a030cd5dde889a = 0;
            }
        }
    }
}

// Namespace ai_fortress
// Params 0
// Checksum 0xd32bf61b, Offset: 0x334b
// Size: 0x48
function function_25705913cbce22ba()
{
    if ( !isdefined( level.var_8ea6e2a4c9dc0cf6 ) )
    {
        level.var_8ea6e2a4c9dc0cf6 = arraycombine( getentarray( "fortress_volume", #script_noteworthy ), getnoentvolumearray( "fortress_volume", #script_noteworthy ) );
        function_d2fd34fa19849398();
    }
}

// Namespace ai_fortress
// Params 4
// Checksum 0xcbb454fa, Offset: 0x339b
// Size: 0x13e
function function_76e09768ae83f2cf( origin, poiname, subarea, var_a877681a49f04afe )
{
    spawnpackages = [];
    var_b50b3e2b0c620359 = [];
    
    if ( isdefined( subarea ) && subarea.subareaname != "orphan" )
    {
        var_b50b3e2b0c620359 = subarea.spawnpackage_optional;
    }
    
    if ( var_a877681a49f04afe )
    {
        if ( poi::poi_issystemactive() )
        {
            var_b50b3e2b0c620359 = arraycombine( var_b50b3e2b0c620359, level.poi[ poiname ][ "subAreas" ][ "orphan" ].spawnpackage_optional );
        }
    }
    
    foreach ( package in var_b50b3e2b0c620359 )
    {
        if ( !package.spawned && distance2dsquared( origin, package.origin ) < 4000000 )
        {
            spawnpackages[ spawnpackages.size ] = package;
        }
    }
    
    return sortbydistance( spawnpackages, origin );
}

// Namespace ai_fortress
// Params 4
// Checksum 0x34e62c9a, Offset: 0x34e2
// Size: 0x42
function function_997810f29cc3f923( origin, var_79131c08459a1ca8, var_37b0e5827b3bef94, poiname )
{
    sorted = function_2ca05298e27ede3a( origin, var_79131c08459a1ca8, var_37b0e5827b3bef94, poiname );
    return sorted[ 0 ];
}

// Namespace ai_fortress
// Params 4
// Checksum 0x97925b3b, Offset: 0x352d
// Size: 0x118
function function_2ca05298e27ede3a( origin, var_79131c08459a1ca8, var_37b0e5827b3bef94, poiname )
{
    if ( var_79131c08459a1ca8 )
    {
        var_1f188729b140132e = level.fortressstruct.unusedfortresses;
    }
    else
    {
        var_1f188729b140132e = level.fortressstruct.var_1f188729b140132e;
    }
    
    var_28b9e8b22d6b8d58 = [];
    
    if ( var_37b0e5827b3bef94 )
    {
        if ( !isdefined( poiname ) )
        {
            poiname = poi::poi_findpoioriginisin( origin );
        }
        
        foreach ( fortress in var_1f188729b140132e )
        {
            if ( fortress.script_poi == poiname )
            {
                var_28b9e8b22d6b8d58[ var_28b9e8b22d6b8d58.size ] = fortress;
            }
        }
        
        if ( var_28b9e8b22d6b8d58.size > 0 )
        {
            var_1f188729b140132e = var_28b9e8b22d6b8d58;
        }
    }
    
    var_1f188729b140132e = sortbydistance( var_1f188729b140132e, origin );
    return var_1f188729b140132e;
}

// Namespace ai_fortress
// Params 3
// Checksum 0xe29f1f0e, Offset: 0x364e
// Size: 0xeb
function function_a342bb675c7cb16e( origin, poolname, var_79131c08459a1ca8 )
{
    fortresspool = function_65dc0e2ce675b239( poolname );
    
    if ( !isdefined( fortresspool ) )
    {
        return;
    }
    
    fortressnodes = [];
    
    foreach ( target in function_65dc0e2ce675b239( poolname ) )
    {
        fortress = function_fa4b28e564486a6a( target );
        
        if ( isdefined( fortress ) )
        {
            if ( var_79131c08459a1ca8 )
            {
                continue;
            }
            
            fortressnodes[ fortressnodes.size ] = fortress;
        }
    }
    
    if ( fortressnodes.size < 1 )
    {
        return;
    }
    
    fortressnodes = sortbydistance( fortressnodes, origin );
    return fortressnodes[ 0 ];
}

// Namespace ai_fortress
// Params 1
// Checksum 0x968a8a44, Offset: 0x3742
// Size: 0x67
function function_61241fa0070d0658( fortress )
{
    if ( !isdefined( level.var_489f1cb45676268c ) )
    {
        level.var_489f1cb45676268c = 0;
    }
    
    name = "fortressUniqueName" + level.var_489f1cb45676268c;
    fortress.uniquename = name;
    namespace_287664c3b016b734::register( fortress.uniquename );
    level.var_489f1cb45676268c++;
}

// Namespace ai_fortress
// Params 1
// Checksum 0x422897ca, Offset: 0x37b1
// Size: 0x76
function function_cc571b4d616709f5( fortress )
{
    if ( issubstr( tolower( fortress.script_noteworthy ), "compound" ) && !issubstr( tolower( fortress.script_noteworthy ), "notacmap" ) )
    {
        return 1;
    }
    
    var_734b56cd2b18dfbe = utility::callsharedfunc( #"fortress", #"hash_7dbf01364d7c67b2", fortress );
    
    if ( var_734b56cd2b18dfbe )
    {
        return var_734b56cd2b18dfbe;
    }
    
    return 0;
}

// Namespace ai_fortress
// Params 2
// Checksum 0xb7f3649d, Offset: 0x3830
// Size: 0xcd
function function_a8dca32afe1a2ca7( var_4391cb6d0c1e5c03, zone )
{
    if ( zone.spawned )
    {
        return;
    }
    
    zone.spawned = 1;
    zone.guardnodes = arrayrandomize( zone.guardnodes );
    var_3ee1bdead9dcfea1 = utility::array_slice( zone.guardnodes, 0, zone.agenttarget );
    var_4391cb6d0c1e5c03.var_8d0b746f2a2942e4 = arraycombine( var_4391cb6d0c1e5c03.var_8d0b746f2a2942e4, var_3ee1bdead9dcfea1 );
    
    /#
        if ( zone.guardnodes.size < zone.agenttarget )
        {
            println( "<dev string:xb1>" + zone.origin + "<dev string:xeb>" );
        }
    #/
}

// Namespace ai_fortress
// Params 2
// Checksum 0xedaea8c2, Offset: 0x3905
// Size: 0x547
function fortress_spawnagents( fortress, insideignore )
{
    function_c2398b37d07b2740( fortress );
    function_61241fa0070d0658( fortress );
    var_c8a785b883026c5f = fortress.ishero || issubstr( fortress.script_noteworthy, "compound" );
    
    if ( fortress.var_fdb073af515f95a9 || var_c8a785b883026c5f || !fortress.var_9baca00f8f7d859a )
    {
        var_785fce9d323e44b1 = arraycombine( fortress.guardnodes, fortress.patrolpaths );
        var_785fce9d323e44b1 = arrayrandomize( var_785fce9d323e44b1 );
        
        foreach ( node in var_785fce9d323e44b1 )
        {
            if ( fortress.subarea.livingagents.size > fortress.subarea.tuning.var_ee14ca6e8181bd86 )
            {
                break;
            }
            
            if ( node.script_agent_noteworthy == "agent_spawnnode_guard" )
            {
                function_f31d7ff082c1bb0e( node, issubstr( node.script_noteworthy, "stationary" ), fortress );
                continue;
            }
            
            fortressagent_spawnpatrol( node, fortress );
        }
    }
    else
    {
        fortress.spawnzones[ "high" ] = arrayrandomize( fortress.spawnzones[ "high" ] );
        fortress.spawnzones[ "medium" ] = arrayrandomize( fortress.spawnzones[ "medium" ] );
        fortress.spawnzones[ "low" ] = arrayrandomize( fortress.spawnzones[ "low" ] );
        var_4391cb6d0c1e5c03 = spawnstruct();
        var_4391cb6d0c1e5c03.var_8d0b746f2a2942e4 = [];
        
        foreach ( zone in fortress.allzones )
        {
            function_a8dca32afe1a2ca7( var_4391cb6d0c1e5c03, zone );
        }
        
        var_6ed4079c6e33c93 = level.fortressstruct.var_965a551489d6fcd5[ fortress.fortresssize ];
        var_8d0b746f2a2942e4 = arrayrandomize( var_4391cb6d0c1e5c03.var_8d0b746f2a2942e4 );
        
        foreach ( node in var_8d0b746f2a2942e4 )
        {
            if ( var_6ed4079c6e33c93 > 0 && function_b503355797d23e54( node.origin, fortress ) )
            {
                node.script_noteworthy = "guard_riotshield";
                var_6ed4079c6e33c93--;
            }
            
            agent = function_f31d7ff082c1bb0e( node, issubstr( node.script_noteworthy, "stationary" ), fortress );
            
            if ( isdefined( agent ) )
            {
                if ( insideignore && function_b503355797d23e54( node.origin, fortress ) )
                {
                    function_8a04999d523cf31( agent );
                }
            }
        }
    }
    
    foreach ( door in fortress.lockeddoors )
    {
        if ( isdefined( door.keyname ) && door.keyname != "fortress" && door.var_e582bbdce07db643 )
        {
            if ( !arraycontains( fortress.var_72a8bdabe181c6f9, door.keyname ) )
            {
                keyspawn = utility::array_random( fortress.var_f09146bdfc65287d );
                
                if ( isdefined( keyspawn ) )
                {
                    spawnoptions = common_item::function_bc5ff2958b71a708( keyspawn.origin, keyspawn.angles );
                    spawnoptions.var_fd47e835523b473f = 1;
                    scriptable = common_item::items_spawnitemfromscriptable( door.keyname, 1, spawnoptions );
                    fortress.var_f09146bdfc65287d = arrayremove( fortress.var_f09146bdfc65287d, keyspawn );
                    fortress.var_72a8bdabe181c6f9 = arraycombineunique( fortress.var_72a8bdabe181c6f9, [ door.keyname ] );
                }
            }
        }
    }
    
    fortress utility::ent_flag_set( "spawned_agents" );
}

// Namespace ai_fortress
// Params 2
// Checksum 0xff1bfa59, Offset: 0x3e54
// Size: 0x71
function function_be2642b94f737075( agent, dormancyid )
{
    agent.agentstruct.dormancyid = dormancyid;
    
    if ( issubstr( agent.agent_type, "riotshield" ) && !agent.agentstruct.fortress.unlocked )
    {
        function_219125326672d385( agent );
    }
}

// Namespace ai_fortress
// Params 1
// Checksum 0x10a85d71, Offset: 0x3ecd
// Size: 0x2d
function fortress_agentpostdormancy( agent )
{
    if ( issubstr( agent.agent_type, "riotshield" ) )
    {
        agent thread function_8a2e50e624b6a234( agent );
    }
}

// Namespace ai_fortress
// Params 2
// Checksum 0x33dad987, Offset: 0x3f02
// Size: 0xdf
function function_4487a94e9ab1367( agent, killer )
{
    if ( isagent( agent ) )
    {
        agentstruct = agent.agentstruct;
        
        if ( isdefined( agentstruct.fortress ) )
        {
            if ( isplayer( killer ) && isdefined( agentstruct.fortress.contributingplayers ) && !arraycontains( agentstruct.fortress.contributingplayers, killer ) )
            {
                agentstruct.fortress.contributingplayers[ agentstruct.fortress.contributingplayers.size ] = killer;
            }
        }
        
        return;
    }
    
    if ( isint( agent ) )
    {
        agent_utils::function_e1d61d098684f944( agent, undefined );
        agent_utils::function_50bb14a8f7b54037( agent, "fortress_agentPostDormancy", &fortress_agentpostdormancy );
    }
}

// Namespace ai_fortress
// Params 1
// Checksum 0xd48ae2cf, Offset: 0x3fe9
// Size: 0x96d
function function_c2398b37d07b2740( fortress )
{
    if ( fortress.allzones.size <= 0 )
    {
        return;
    }
    
    fortress.var_9baca00f8f7d859a = 1;
    
    foreach ( zone in fortress.allzones )
    {
        zone.tier = function_8e0d46e398131991( zone.volume );
        zone.origin = zone.volume.origin;
    }
    
    foreach ( guardnode in fortress.guardnodes )
    {
        zoneassigned = 0;
        
        foreach ( zone in fortress.allzones )
        {
            if ( ispointinvolume( guardnode.origin, zone.volume ) )
            {
                guardnode.var_c939b08c1c2d5df = zone.tier;
                zone.guardnodes[ zone.guardnodes.size ] = guardnode;
                zoneassigned = 1;
                break;
            }
        }
        
        if ( zoneassigned )
        {
            continue;
        }
        
        closestzone = undefined;
        closestdist = undefined;
        
        foreach ( zone in fortress.allzones )
        {
            dist = distance2dsquared( guardnode.origin, zone.volume.origin );
            
            if ( !isdefined( closestzone ) )
            {
                closestzone = zone;
                closestdist = dist;
                continue;
            }
            
            if ( dist < closestdist )
            {
                closestzone = zone;
                closestdist = dist;
            }
        }
        
        guardnode.var_c939b08c1c2d5df = closestzone.tier;
        closestzone.guardnodes[ closestzone.guardnodes.size ] = guardnode;
    }
    
    foreach ( zone in fortress.allzones )
    {
        zone.volume delete();
    }
    
    fortress.spawnzones[ "high" ] = arrayrandomize( fortress.spawnzones[ "high" ] );
    fortress.spawnzones[ "medium" ] = arrayrandomize( fortress.spawnzones[ "medium" ] );
    fortress.spawnzones[ "low" ] = arrayrandomize( fortress.spawnzones[ "low" ] );
    
    if ( isdefined( fortress.var_59142a37e7a89a2a ) )
    {
        var_14c4a44c13b56edc = fortress.var_59142a37e7a89a2a;
    }
    else
    {
        var_14c4a44c13b56edc = level.fortressstruct.var_cc840119c283f99c[ fortress.fortresssize ];
    }
    
    var_48a103b484390f7a = var_14c4a44c13b56edc / fortress.allzones.size;
    totaladjusted = 0;
    
    foreach ( spawnzone in fortress.spawnzones[ "high" ] )
    {
        spawnzone.agenttarget = var_48a103b484390f7a + 1;
        totaladjusted++;
    }
    
    foreach ( spawnzone in fortress.spawnzones[ "low" ] )
    {
        spawnzone.agenttarget = var_48a103b484390f7a - 1;
        totaladjusted--;
    }
    
    if ( totaladjusted > 0 )
    {
        foreach ( spawnzone in fortress.spawnzones[ "medium" ] )
        {
            if ( totaladjusted > 0 )
            {
                spawnzone.agenttarget = var_48a103b484390f7a - 0.5;
                totaladjusted -= 0.5;
                continue;
            }
            
            spawnzone.agenttarget = var_48a103b484390f7a;
        }
    }
    
    lowesthigh = undefined;
    var_40ac6f6ebd9873d4 = 0;
    
    foreach ( spawnzone in fortress.spawnzones[ "high" ] )
    {
        spawnzone.agenttarget = int( ceil( spawnzone.agenttarget ) );
        var_40ac6f6ebd9873d4 += spawnzone.agenttarget;
        
        if ( !isdefined( lowesthigh ) || spawnzone.agenttarget < lowesthigh )
        {
            lowesthigh = spawnzone.agenttarget;
        }
    }
    
    foreach ( spawnzone in fortress.spawnzones[ "low" ] )
    {
        spawnzone.agenttarget = int( floor( spawnzone.agenttarget ) );
        
        if ( spawnzone.agenttarget <= 0 )
        {
            spawnzone.agenttarget = 1;
        }
        
        var_40ac6f6ebd9873d4 += spawnzone.agenttarget;
    }
    
    highestmedium = undefined;
    
    foreach ( spawnzone in fortress.spawnzones[ "medium" ] )
    {
        potentialmedium = int( ceil( spawnzone.agenttarget ) );
        
        if ( potentialmedium < lowesthigh )
        {
            spawnzone.agenttarget = potentialmedium;
        }
        else
        {
            spawnzone.agenttarget = int( spawnzone.agenttarget );
        }
        
        if ( !isdefined( highestmedium ) || spawnzone.agenttarget > highestmedium )
        {
            highestmedium = spawnzone.agenttarget;
        }
        
        var_40ac6f6ebd9873d4 += spawnzone.agenttarget;
    }
    
    if ( var_40ac6f6ebd9873d4 > var_14c4a44c13b56edc )
    {
        foreach ( spawnzone in fortress.spawnzones[ "high" ] )
        {
            if ( spawnzone.agenttarget - 1 > highestmedium )
            {
                spawnzone.agenttarget -= 1;
                var_40ac6f6ebd9873d4--;
            }
            
            if ( var_40ac6f6ebd9873d4 <= var_14c4a44c13b56edc )
            {
                return;
            }
        }
    }
}

// Namespace ai_fortress
// Params 1
// Checksum 0xac96f54a, Offset: 0x495e
// Size: 0x66
function function_8e0d46e398131991( volume )
{
    if ( issubstr( volume.script_noteworthy, "tier3" ) )
    {
        return 3;
    }
    
    if ( issubstr( volume.script_noteworthy, "tier2" ) )
    {
        return 2;
    }
    
    if ( issubstr( volume.script_noteworthy, "tier1" ) )
    {
        return 1;
    }
    
    return -1;
}

// Namespace ai_fortress
// Params 1
// Checksum 0x4c72cfaf, Offset: 0x49cc
// Size: 0x4a
function function_8a04999d523cf31( agent )
{
    if ( !isdefined( agent ) )
    {
        return;
    }
    
    if ( isagent( agent ) )
    {
        agent.ignoreall = 1;
        return;
    }
    
    if ( isint( agent ) )
    {
        agent_utils::function_3d1ccb7ed2f7c332( agent, "fortressAgent_setIgnoreAgentPostSpawn", &fortressagent_setignoreagentpostspawn );
    }
}

// Namespace ai_fortress
// Params 0
// Checksum 0x33b1371b, Offset: 0x4a1e
// Size: 0x1d
function fortressagent_setignoreagentpostspawn()
{
    agent = self;
    agent.ignoreall = 1;
}

// Namespace ai_fortress
// Params 3
// Checksum 0x79be80f, Offset: 0x4a43
// Size: 0x1f6
function function_f31d7ff082c1bb0e( node, isstationary, fortress )
{
    node.var_e9dd8ef46fd3005b = 1;
    priority = "medium";
    
    if ( function_c4cc2f9a17167e1b( fortress ) )
    {
        priority = "high";
    }
    
    if ( !isdefined( node.script_tier ) && fortress.tieroverride )
    {
        node.script_tier = fortress.tieroverride;
    }
    
    if ( node.var_c939b08c1c2d5df > 0 )
    {
        node.script_tier = node.var_c939b08c1c2d5df;
    }
    
    if ( fortress.nationalityoverride )
    {
        node.script_nationality_override = fortress.nationalityoverride;
    }
    
    groupname = ai_mp_controller::function_8d299531f8485be9( node );
    
    if ( level.var_15fb757c9b81d8c4 )
    {
        allowlw = ai_mp_controller::function_194ab657916a88db( undefined, node.origin );
        var_599d450bd1f7dd3b = ai_mp_controller::function_29dc8dd695322183( fortress, fortress.var_2edd2e78a94cd514, node.origin, allowlw );
    }
    
    agent = ai_mp_controller::spawnguard( node, undefined, priority, fortress.uniquename, undefined, undefined, var_599d450bd1f7dd3b );
    
    if ( !isdefined( agent ) )
    {
        return;
    }
    
    if ( level.var_8532cd02459840d2 )
    {
        level thread debug::drawsphere( node.origin, 128, 500, ( 0, 1, 0 ) );
    }
    
    fortress.budgetstruct.totalagents++;
    function_9d353b87a0ea9ced( agent, fortress, node );
    
    if ( !isint( agent ) && node.script_noteworthy == "guard_riotshield" )
    {
        agent.agentstruct.fortress = fortress;
        agent thread function_8a2e50e624b6a234( agent );
    }
    
    return agent;
}

// Namespace ai_fortress
// Params 2
// Checksum 0x8c19fd3e, Offset: 0x4c42
// Size: 0x269
function fortressagent_spawnpatrol( pathstruct, fortress )
{
    if ( !isdefined( pathstruct.path[ 0 ] ) )
    {
        return;
    }
    
    if ( !isdefined( pathstruct.script_poi ) )
    {
        pathstruct.script_poi = fortress.script_poi;
    }
    
    nationalityoverride = fortress.nationalityoverride;
    
    if ( !isdefined( nationalityoverride ) )
    {
        nationalityoverride = level.var_9e5e5355ebbee37a;
    }
    
    if ( !isdefined( pathstruct.path[ 0 ].script_nationality_override ) || isdefined( pathstruct.path[ 0 ].script_nationality_override ) && issubstr( pathstruct.path[ 0 ].script_nationality_override, "<nationality" ) )
    {
        pathstruct.path[ 0 ].script_nationality_override = nationalityoverride;
    }
    
    if ( level.var_15fb757c9b81d8c4 )
    {
        allowlw = ai_mp_controller::function_194ab657916a88db( undefined, pathstruct.path[ 0 ].origin );
        var_599d450bd1f7dd3b = ai_mp_controller::function_29dc8dd695322183( fortress, fortress.var_9d6446c266195ec7, pathstruct.path[ 0 ].origin, allowlw, 1 );
    }
    
    agents = ai_mp_controller::spawnpatrol( pathstruct, level.fortressstruct.var_962c97feafeead0d, level.fortressstruct.var_a5af60fbe5a82e8b, fortress, "medium", fortress.uniquename, undefined, undefined, var_599d450bd1f7dd3b );
    
    if ( !isdefined( agents ) )
    {
        return agents;
    }
    
    if ( fortress.uniquename )
    {
        foreach ( agent in agents )
        {
            function_9d353b87a0ea9ced( agent, fortress, pathstruct.path[ 0 ] );
        }
    }
    
    fortress.budgetstruct.totalagents += agents.size;
}

// Namespace ai_fortress
// Params 3
// Checksum 0x77ebcf65, Offset: 0x4eb3
// Size: 0x17d
function function_9d353b87a0ea9ced( agent, fortress, node )
{
    agentstruct = spawnstruct();
    agentstruct.fortress = fortress;
    agentstruct.var_66ed919d586cec20 = &function_be2642b94f737075;
    agentstruct.ondeath = &function_4487a94e9ab1367;
    
    if ( isint( agent ) )
    {
        agentstruct.dormancyid = agent;
    }
    
    agent_utils::function_e1d61d098684f944( agent, agentstruct );
    
    if ( isdefined( node.var_ef5c1d36f4119efa ) )
    {
        var_ef5c1d36f4119efa = strtok( node.var_ef5c1d36f4119efa, "," );
        
        if ( !isarray( var_ef5c1d36f4119efa ) )
        {
            var_ef5c1d36f4119efa = [ var_ef5c1d36f4119efa ];
        }
        
        foreach ( lootitem in var_ef5c1d36f4119efa )
        {
            if ( locksandkeys::function_9bc16d6d18aa192a( lootitem ) )
            {
                ai_loot::function_452f7cba22550779( agent, lootitem );
                fortress.var_72a8bdabe181c6f9 = arraycombineunique( fortress.var_72a8bdabe181c6f9, [ lootitem ] );
                continue;
            }
            
            ai_loot::function_452f7cba22550779( agent, lootitem );
        }
    }
    
    agent_utils::function_3d1ccb7ed2f7c332( agent, "fortress_agentPostDormancy", &fortress_agentpostdormancy );
}

// Namespace ai_fortress
// Params 1
// Checksum 0xbe58036b, Offset: 0x5038
// Size: 0x15
function fortress_lockdown( fortress )
{
    function_a40880395f853edc( fortress );
}

// Namespace ai_fortress
// Params 1
// Checksum 0x49a24c3b, Offset: 0x5055
// Size: 0x106
function function_a33ba50e0733f6fe( fortress )
{
    fortress.script_noteworthy = tolower( fortress.script_noteworthy );
    
    if ( !isdefined( fortress.script_poi ) && poi::poi_issystemactive() )
    {
        fortress.script_poi = poi::poi_findpoioriginisin( fortress.origin, 1 );
    }
    else
    {
        fortress.script_poi = "none";
    }
    
    if ( utility::issharedfuncdefined( #"fortress", #"hash_4b38df225761e067" ) )
    {
        fortress = utility::callsharedfunc( #"fortress", #"hash_4b38df225761e067", fortress );
    }
    
    if ( !isdefined( fortress.name ) || issubstr( fortress.name, "main_node" ) )
    {
        fortress.name = "unnamed";
    }
    
    level.fortressstruct.var_db1aefa5b9c86d7e[ fortress.script_noteworthy ] = fortress;
}

// Namespace ai_fortress
// Params 2
// Checksum 0x1968c052, Offset: 0x5163
// Size: 0x9f
function function_d9f4f0632c1968e( fortress, keynameoverride )
{
    if ( !isdefined( fortress.fortresstype ) )
    {
        fortress.fortresstype = "nonMainFortress";
        
        if ( !isdefined( level.fortressstruct.var_a9ebedf0eab50c7 ) )
        {
            level.fortressstruct.var_a9ebedf0eab50c7 = [];
        }
        
        level.fortressstruct.var_a9ebedf0eab50c7[ level.fortressstruct.var_a9ebedf0eab50c7.size ] = fortress;
    }
    
    function_2a92b0d526c70806( fortress, keynameoverride );
    function_3e50d47832ee4d97( fortress );
}

// Namespace ai_fortress
// Params 11
// Checksum 0x728407ff, Offset: 0x520a
// Size: 0x274
function function_a40880395f853edc( fortress, lockdoors, var_3855f7510eb00a94, var_ca0dc6322bae4f04, spawnagents, keynameoverride, var_82b0e6e112291fdf, var_1a2088c589064e62, spawntraps, var_338cc4d19cab0569, trackclearing )
{
    level.fortressstruct.unusedfortresses = arrayremove( level.fortressstruct.unusedfortresses, fortress );
    
    if ( !arraycontains( level.fortressstruct.chosenfortresses, fortress ) )
    {
        level.fortressstruct.chosenfortresses[ level.fortressstruct.chosenfortresses.size ] = fortress;
    }
    
    fortress.isactive = 1;
    
    if ( level.var_15fb757c9b81d8c4 )
    {
        subname = fortress.subarea.subareaname ?? fortress.script_poi ?? "none";
        managedgroupname = fortress.fortresstype + "|" + fortress.areaname + "|" + subname;
        fortress.var_2edd2e78a94cd514 = "guards|" + managedgroupname;
        fortress.var_9d6446c266195ec7 = "patrols|" + managedgroupname;
    }
    
    if ( !isdefined( lockdoors ) || lockdoors )
    {
        function_39b5f3f3ab7d820b( fortress, keynameoverride, var_82b0e6e112291fdf );
    }
    
    function_cf5ef24f85e09a66( fortress );
    
    if ( !br_strongholds::function_15f893a51b7d6d7c() )
    {
        if ( !issubstr( fortress.script_noteworthy, "noTacMap" ) && ( !isdefined( var_ca0dc6322bae4f04 ) || var_ca0dc6322bae4f04 ) )
        {
            function_79d9eca9e180767a( fortress );
        }
        
        if ( !isdefined( spawnagents ) || spawnagents )
        {
            if ( isfunction( var_1a2088c589064e62 ) )
            {
                [[ var_1a2088c589064e62 ]]( fortress );
            }
            else
            {
                thread fortress_spawnagents( fortress, undefined );
            }
        }
    }
    
    if ( level.var_83060e4064407d85 && ( !isdefined( spawntraps ) || spawntraps ) )
    {
        function_b1546ff296521ffb( fortress );
        function_a9e180e55eb44b65( fortress );
        thread function_dbacfbf9f6b9e570( fortress );
    }
    
    if ( ( !isdefined( trackclearing ) || trackclearing ) && fortress.uniquename )
    {
        thread fortress_trackclearing( fortress );
    }
    
    function_fefc18d15b49ee39( fortress, var_338cc4d19cab0569 );
    thread function_c0155c35315a1021( fortress );
}

// Namespace ai_fortress
// Params 1
// Checksum 0x2c30abbe, Offset: 0x5486
// Size: 0x2f
function function_276efad9cd97ee6f( fortress )
{
    fortress.partiallyactive = 1;
    function_a40880395f853edc( fortress, 0, undefined, 1, 1, undefined, undefined, undefined, undefined, undefined, undefined );
}

// Namespace ai_fortress
// Params 8
// Checksum 0xaa2fa3f, Offset: 0x54bd
// Size: 0xb8
function function_b11f7255b6708613( origin, lockdoors, var_3855f7510eb00a94, var_ca0dc6322bae4f04, spawnagents, keynameoverride, var_82b0e6e112291fdf, var_1a2088c589064e62 )
{
    fortress = function_997810f29cc3f923( origin );
    
    if ( !isdefined( fortress ) || fortress.invalidfortress )
    {
        return;
    }
    
    function_d9f4f0632c1968e( fortress );
    
    if ( !isdefined( lockdoors ) )
    {
        lockdoors = 1;
    }
    
    if ( !isdefined( var_3855f7510eb00a94 ) )
    {
        var_3855f7510eb00a94 = 1;
    }
    
    if ( !isdefined( var_ca0dc6322bae4f04 ) )
    {
        var_ca0dc6322bae4f04 = 1;
    }
    
    if ( !isdefined( spawnagents ) )
    {
        spawnagents = 1;
    }
    
    function_a40880395f853edc( fortress, lockdoors, var_3855f7510eb00a94, var_ca0dc6322bae4f04, spawnagents, keynameoverride, var_82b0e6e112291fdf, var_1a2088c589064e62, undefined, undefined, 0 );
}

// Namespace ai_fortress
// Params 9
// Checksum 0x8f4da10a, Offset: 0x557d
// Size: 0xc2
function function_e71f78419c88477e( origin, poolname, lockdoors, var_3855f7510eb00a94, var_ca0dc6322bae4f04, spawnagents, keynameoverride, var_82b0e6e112291fdf, var_1a2088c589064e62 )
{
    fortress = function_a342bb675c7cb16e( origin, poolname );
    
    if ( !isdefined( fortress ) || fortress.invalidfortress )
    {
        return;
    }
    
    function_d9f4f0632c1968e( fortress );
    
    if ( !isdefined( lockdoors ) )
    {
        lockdoors = 1;
    }
    
    if ( !isdefined( var_3855f7510eb00a94 ) )
    {
        var_3855f7510eb00a94 = 1;
    }
    
    if ( !isdefined( var_ca0dc6322bae4f04 ) )
    {
        var_ca0dc6322bae4f04 = 1;
    }
    
    if ( !isdefined( spawnagents ) )
    {
        spawnagents = 1;
    }
    
    function_a40880395f853edc( fortress, lockdoors, var_3855f7510eb00a94, var_ca0dc6322bae4f04, spawnagents, keynameoverride, var_82b0e6e112291fdf, var_1a2088c589064e62, undefined, undefined, 0 );
}

// Namespace ai_fortress
// Params 2
// Checksum 0xc75123de, Offset: 0x5647
// Size: 0xc8
function function_bcf3ec24f76d8ca0( fortress, keyname )
{
    foreach ( door in fortress.lockeddoors )
    {
        if ( door.script_noteworthy == "lockme" || door.node.script_noteworthy == "lockMe" )
        {
            door.keyname = keyname;
        }
    }
}

// Namespace ai_fortress
// Params 3
// Checksum 0xf41ab84, Offset: 0x5717
// Size: 0x198
function fortress_lockdoors( fortress, var_48aa31f0038f1538, forcelock = 0 )
{
    foreach ( door in fortress.lockeddoors )
    {
        if ( function_c4cc2f9a17167e1b() || door.keyname != "fortress" )
        {
            if ( door.shouldlock || forcelock )
            {
                locksandkeys::lockscriptabledoor( door );
            }
            
            door.fortress = fortress;
            
            if ( isdefined( var_48aa31f0038f1538 ) )
            {
                door.var_de79f5d2971427a8 = var_48aa31f0038f1538;
                continue;
            }
            
            if ( !isdefined( door.var_de79f5d2971427a8 ) )
            {
                door.var_de79f5d2971427a8 = &function_af2a187f419e7b2f;
            }
        }
    }
    
    foreach ( door in fortress.var_c6ae840b3c497571 )
    {
        locksandkeys::lockscriptabledoor( door );
        door.fortress = fortress;
    }
}

// Namespace ai_fortress
// Params 1
// Checksum 0xb8e30fd4, Offset: 0x58b7
// Size: 0x87
function function_e4c2e0626ef7819a( fortress )
{
    foreach ( door in fortress.lockeddoors )
    {
        locksandkeys::unlockscriptabledoor( door );
    }
}

// Namespace ai_fortress
// Params 4
// Checksum 0xdad68df7, Offset: 0x5946
// Size: 0x4a
function function_39b5f3f3ab7d820b( fortress, keyname, var_82b0e6e112291fdf, forcelock = 0 )
{
    if ( isdefined( keyname ) )
    {
        function_bcf3ec24f76d8ca0( fortress, keyname );
    }
    
    fortress_lockdoors( fortress, var_82b0e6e112291fdf, forcelock );
}

// Namespace ai_fortress
// Params 1
// Checksum 0x1754f7be, Offset: 0x5998
// Size: 0xd6
function function_216b657de5c2cf33( var_48aa31f0038f1538 )
{
    if ( !level.var_dae6f5205e9624f7 )
    {
        return;
    }
    
    fortress = self;
    
    foreach ( door in fortress.lockeddoors_interior )
    {
        locksandkeys::lockscriptabledoor( door );
        door.fortress = fortress;
        
        if ( isdefined( var_48aa31f0038f1538 ) )
        {
            door.var_de79f5d2971427a8 = var_48aa31f0038f1538;
            continue;
        }
        
        door.var_de79f5d2971427a8 = &function_cbb62c6f3589edf;
    }
}

// Namespace ai_fortress
// Params 2
// Checksum 0xa8e65258, Offset: 0x5a76
// Size: 0x689
function function_79d9eca9e180767a( fortress, teamplayers )
{
    if ( level.br_strongholds )
    {
        if ( level.var_d3a332406b780208 && isdefined( level.fortressstruct.var_2605c4a80c1ae66 ) && arraycontains( level.fortressstruct.var_2605c4a80c1ae66, fortress ) )
        {
            var_aebd0acd31690008 = "ui_map_icon_loot_cache";
            fortress.var_3fe94b69c43ce3d5 = objidpoolmanager::requestobjectiveid( 99 );
            objidpoolmanager::objective_add_objective( fortress.var_3fe94b69c43ce3d5, "active", fortress.origin + ( 0, -350, 0 ), var_aebd0acd31690008 );
            objidpoolmanager::update_objective_setbackground( fortress.var_3fe94b69c43ce3d5, 8 );
            objidpoolmanager::function_c34959a44b376957( fortress.var_3fe94b69c43ce3d5, 14 );
            objidpoolmanager::function_586b631e7bbb592a( fortress.var_3fe94b69c43ce3d5, 1 );
            objidpoolmanager::objective_showdistance( fortress.var_3fe94b69c43ce3d5, 1 );
            objective_setlabel( fortress.var_3fe94b69c43ce3d5, &"mp_br_ingame/abandonedcache" );
            
            if ( getdvarint( @"bruselegacyiconcolors", 1 ) == 0 )
            {
                objective_settint( fortress.var_3fe94b69c43ce3d5, 114, 226, 112, 1 );
            }
            
            return;
        }
        
        fortress br_contract_manager::createquestobjicon( fortress.var_cdddf79dec017a2e, "active", fortress.origin + ( 0, -350, 0 ) );
        objidpoolmanager::update_objective_setbackground( fortress.objectiveiconid, 1 );
        objidpoolmanager::function_586b631e7bbb592a( fortress.objectiveiconid, 1 );
        objidpoolmanager::objective_showdistance( fortress.objectiveiconid, 1 );
        
        if ( fortress.isblacksite && isdefined( teamplayers ) )
        {
            objidpoolmanager::objective_playermask_hidefromallplayers( fortress.objectiveiconid );
            objidpoolmanager::update_objective_objectiveid( fortress.objectiveiconid, 18 );
            objective_setlabel( fortress.objectiveiconid, &"mp_br_ingame/black_site" );
        }
        else
        {
            objidpoolmanager::objective_playermask_showtoallplayers( fortress.objectiveiconid );
            objidpoolmanager::update_objective_objectiveid( fortress.objectiveiconid, 17 );
            objective_setlabel( fortress.objectiveiconid, &"mp_br_ingame/fortress" );
        }
        
        if ( getdvarint( @"bruselegacyiconcolors", 1 ) == 0 )
        {
            objective_settint( fortress.objectiveiconid, 114, 226, 112, 1 );
        }
        
        thread function_739073660e3ae00a( fortress );
        return;
    }
    
    offset = ( 0, 0, 0 );
    scriptable = undefined;
    tacorigin = fortress.origin;
    
    if ( isdefined( fortress.var_5f15528aa0b89a ) )
    {
        tacorigin = fortress.var_5f15528aa0b89a.origin;
    }
    
    if ( !isdefined( fortress.script_noteworthy ) || !issubstr( tolower( fortress.script_noteworthy ), "notacmap" ) )
    {
        if ( function_c4cc2f9a17167e1b( fortress ) )
        {
            if ( isdefined( fortress.name ) && fortress.name != "unnamed" )
            {
                scriptable = spawnscriptable( "fortress_hero_tacmap_location_" + fortress.name, tacorigin + offset );
                
                if ( fortress.partiallyactive )
                {
                    scriptable setscriptablepartstate( "fortress_hero_tacmap_location", "disabled" );
                }
                else if ( fortress.fortresssize == "hero_epic" )
                {
                    scriptable setscriptablepartstate( "fortress_hero_tacmap_location", "epic" );
                }
            }
            else
            {
                scriptable = spawnscriptable( "fortress_tacmap_location_scriptable", tacorigin + offset );
            }
        }
        else if ( issubstr( fortress.script_noteworthy, "medical" ) )
        {
            switch ( fortress.fortresssize )
            {
                case #"hash_4bf33d595d8f4894":
                    scriptable = spawnscriptable( "fortress_tacmap_location_scriptable_medical", tacorigin + offset );
                    break;
                case #"hash_c71b112fe04823d6":
                    scriptable = spawnscriptable( "fortress_tacmap_location_scriptable_medical", tacorigin + offset );
                    break;
                case #"hash_5971965ed985a26c":
                    scriptable = spawnscriptable( "fortress_tacmap_location_scriptable_medical", tacorigin + offset );
                    break;
                default:
                    scriptable = spawnscriptable( "fortress_tacmap_location_scriptable", tacorigin + offset );
                    break;
            }
        }
        else if ( issubstr( fortress.script_noteworthy, "compound" ) )
        {
            scriptable = spawnscriptable( "fortress_tacmap_location_scriptable_compound", tacorigin + offset );
        }
        else if ( issubstr( fortress.script_noteworthy, "police" ) )
        {
            switch ( fortress.fortresssize )
            {
                case #"hash_4bf33d595d8f4894":
                    scriptable = spawnscriptable( "fortress_tacmap_location_scriptable_police", tacorigin + offset );
                    break;
                case #"hash_c71b112fe04823d6":
                    scriptable = spawnscriptable( "fortress_tacmap_location_scriptable_police", tacorigin + offset );
                    break;
                case #"hash_5971965ed985a26c":
                    scriptable = spawnscriptable( "fortress_tacmap_location_scriptable_police", tacorigin + offset );
                    break;
                default:
                    scriptable = spawnscriptable( "fortress_tacmap_location_scriptable", tacorigin + offset );
                    break;
            }
        }
        else if ( issubstr( fortress.script_noteworthy, "firestation" ) )
        {
            switch ( fortress.fortresssize )
            {
                case #"hash_4bf33d595d8f4894":
                    scriptable = spawnscriptable( "fortress_tacmap_location_scriptable_firestation", tacorigin + offset );
                    break;
                case #"hash_c71b112fe04823d6":
                    scriptable = spawnscriptable( "fortress_tacmap_location_scriptable_firestation", tacorigin + offset );
                    break;
                case #"hash_5971965ed985a26c":
                    scriptable = spawnscriptable( "fortress_tacmap_location_scriptable_firestation", tacorigin + offset );
                    break;
                default:
                    scriptable = spawnscriptable( "fortress_tacmap_location_scriptable", tacorigin + offset );
                    break;
            }
        }
        else if ( issubstr( fortress.script_noteworthy, "mamistory" ) )
        {
            scriptable = spawnscriptable( "fortress_tacmap_location_scriptable_mamistory", tacorigin + offset );
        }
        else if ( issubstr( fortress.script_noteworthy, "cluster" ) )
        {
        }
        else
        {
            scriptable = spawnscriptable( "fortress_tacmap_location_scriptable", tacorigin + offset );
        }
    }
    
    if ( scriptable && fortress.fortressvolumes.size )
    {
        if ( level.gamemodebundle.var_fb64d8e570987612 )
        {
            scriptable.var_42ad2e0f6b95770c = arraycombineunique( scriptable.var_42ad2e0f6b95770c ?? [], fortress.fortressvolumes );
        }
    }
    
    fortress.tacmapscriptable = scriptable;
}

// Namespace ai_fortress
// Params 1
// Checksum 0x61404d0d, Offset: 0x6107
// Size: 0x26
function function_d5d56b78a89307f4( fortress )
{
    fortress.tacmapscriptable setscriptablepartstate( "fortress_tacmap_location_scriptable", "hidden" );
}

// Namespace ai_fortress
// Params 0
// Checksum 0x16dbee55, Offset: 0x6135
// Size: 0x4b
function function_d744396943e61a4d()
{
    fortress = self;
    fortress br_contract_manager::deletequestobjicon();
    
    if ( isdefined( fortress.var_c4d00148c2fde9ec ) )
    {
        objidpoolmanager::objective_playermask_hidefromallplayers( fortress.var_c4d00148c2fde9ec );
        objidpoolmanager::returnobjectiveid( fortress.var_c4d00148c2fde9ec );
    }
}

// Namespace ai_fortress
// Params 1
// Checksum 0x8def6e61, Offset: 0x6188
// Size: 0x68
function function_739073660e3ae00a( fortress )
{
    function_6afabfde369e039c( fortress, 0 );
    var_9060a615f7c95162 = getdvarint( @"hash_5633ae4f34076c54", 0 );
    
    if ( fortress.fortresssize == "large" && var_9060a615f7c95162 )
    {
        flags::gameflagwait( "br_ready_to_jump" );
        br_contract_manager::showquestobjicontoall( fortress.objectiveiconid );
    }
}

// Namespace ai_fortress
// Params 2
// Checksum 0xa4b157bc, Offset: 0x61f8
// Size: 0xf5
function function_6afabfde369e039c( fortress, active )
{
    if ( isdefined( fortress.task ) && isdefined( fortress.task.holdpoint ) && fortress.task.holdpoint.tempdisabled )
    {
        objidpoolmanager::update_objective_icon( fortress.objectiveiconid, fortress.var_cdddf79dec017a2e );
        return;
    }
    
    if ( active )
    {
        objidpoolmanager::update_objective_icon( fortress.objectiveiconid, fortress.var_700aac3a76dcef08 );
        return;
    }
    
    objidpoolmanager::update_objective_icon( fortress.objectiveiconid, fortress.var_cdddf79dec017a2e );
    objidpoolmanager::objective_playermask_showtoallplayers( fortress.objectiveiconid );
    
    if ( isdefined( fortress.var_c4d00148c2fde9ec ) )
    {
        objidpoolmanager::objective_playermask_hidefromallplayers( fortress.var_c4d00148c2fde9ec );
    }
}

// Namespace ai_fortress
// Params 1
// Checksum 0xbdb5dea8, Offset: 0x62f5
// Size: 0x29
function function_5b84b41b9159ad3f( fortress )
{
    objidpoolmanager::update_objective_icon( fortress.objectiveiconid, fortress.var_5e3abf6f08b50be3 );
}

// Namespace ai_fortress
// Params 3
// Checksum 0x68ec39ef, Offset: 0x6326
// Size: 0x297
function function_5c4950ffd6422e84( fortress, captured, player )
{
    if ( captured )
    {
        if ( level.var_4a5de2a2eae8e2b0 && isdefined( fortress.var_c4d00148c2fde9ec ) )
        {
            objidpoolmanager::objective_playermask_hidefromallplayers( fortress.var_c4d00148c2fde9ec );
            objidpoolmanager::objective_playermask_showtoallplayers( fortress.objectiveiconid );
            
            foreach ( teammember in teams::getteamdata( player.team, "players" ) )
            {
                objidpoolmanager::objective_playermask_addshowplayer( fortress.var_c4d00148c2fde9ec, teammember );
                objidpoolmanager::objective_playermask_hidefrom( fortress.objectiveiconid, teammember );
            }
        }
        else
        {
            fortress.var_c4d00148c2fde9ec = objidpoolmanager::requestobjectiveid( 1 );
            
            if ( fortress.var_c4d00148c2fde9ec == -1 )
            {
                assert( fortress.var_c4d00148c2fde9ec != -1, "<dev string:x11c>" );
                return;
            }
            
            objidpoolmanager::objective_add_objective( fortress.var_c4d00148c2fde9ec, "active", fortress.origin + ( 0, -350, 0 ), fortress.var_174c0b26e92d1d58 );
            objidpoolmanager::function_586b631e7bbb592a( fortress.var_c4d00148c2fde9ec, 1 );
            objidpoolmanager::objective_showdistance( fortress.var_c4d00148c2fde9ec, 1 );
            objidpoolmanager::objective_playermask_hidefromallplayers( fortress.var_c4d00148c2fde9ec );
            objidpoolmanager::update_objective_icon( fortress.objectiveiconid, fortress.var_5e3abf6f08b50be3 );
            objidpoolmanager::objective_playermask_showtoallplayers( fortress.objectiveiconid );
            
            foreach ( teammember in teams::getteamdata( player.team, "players" ) )
            {
                objidpoolmanager::objective_playermask_addshowplayer( fortress.var_c4d00148c2fde9ec, teammember );
                objidpoolmanager::objective_playermask_hidefrom( fortress.objectiveiconid, teammember );
            }
        }
        
        return;
    }
    
    function_5b84b41b9159ad3f( fortress );
}

// Namespace ai_fortress
// Params 2
// Checksum 0xa9497565, Offset: 0x65c5
// Size: 0x3d
function function_e3a02b21079aef7b( fortress, player )
{
    objidpoolmanager::objective_playermask_hidefrom( fortress.objectiveiconid, player );
    objidpoolmanager::objective_playermask_addshowplayer( fortress.var_c4d00148c2fde9ec, player );
}

// Namespace ai_fortress
// Params 2
// Checksum 0xb910f3f8, Offset: 0x660a
// Size: 0x63
function function_c723a1684d8f42e( fortress, player )
{
    if ( !isdefined( fortress ) )
    {
        return;
    }
    
    if ( isdefined( fortress.var_c4d00148c2fde9ec ) )
    {
        objidpoolmanager::objective_playermask_hidefrom( fortress.var_c4d00148c2fde9ec, player );
    }
    
    if ( isdefined( fortress.objectiveiconid ) )
    {
        objidpoolmanager::objective_playermask_addshowplayer( fortress.objectiveiconid, player );
    }
}

// Namespace ai_fortress
// Params 2
// Checksum 0x72010d4a, Offset: 0x6675
// Size: 0x3d
function function_17a15917ce6217a( fortress, player )
{
    objidpoolmanager::objective_playermask_hidefrom( fortress.var_c4d00148c2fde9ec, player );
    objidpoolmanager::objective_playermask_hidefrom( fortress.objectiveiconid, player );
}

// Namespace ai_fortress
// Params 1
// Checksum 0x14130da2, Offset: 0x66ba
// Size: 0x1ae
function function_cf5ef24f85e09a66( fortress )
{
    foreach ( node in fortress.props )
    {
        if ( isdefined( node.script_noteworthy ) && node.script_noteworthy != "<custom" )
        {
            scriptable = spawnscriptable( level.var_1395680c28bfd693, node.origin, node.angles );
            
            if ( scriptable getscriptableparthasstate( "scriptable_prop", node.script_noteworthy ) )
            {
                scriptable setscriptablepartstate( "scriptable_prop", node.script_noteworthy );
            }
        }
    }
    
    if ( isdefined( fortress.propflags ) )
    {
        foreach ( node in fortress.propflags )
        {
            scriptable = spawnscriptable( "fortress_scriptable_flags", node.origin, node.angles );
            scriptable setscriptablepartstate( "scriptable_flag", node.script_noteworthy );
        }
    }
}

// Namespace ai_fortress
// Params 0
// Checksum 0xdbe26254, Offset: 0x6870
// Size: 0x3, Type: bool
function function_77dda672e0ff3625()
{
    return false;
}

// Namespace ai_fortress
// Params 3
// Checksum 0xf8fce056, Offset: 0x687c
// Size: 0xb5
function function_ba6fd9c61c79fe85( agent, fortress, origin )
{
    agent.goalradius = 10;
    agent setgoalpos( getclosestpointonnavmesh( origin + ( 10000, 0, 0 ) ) );
    waitframe();
    
    if ( isdefined( fortress.inside_goalvolume ) )
    {
        if ( ispointinvolume( origin, fortress.inside_goalvolume ) )
        {
            agent setgoalvolume( fortress.inside_goalvolume );
        }
        
        return;
    }
    
    if ( isdefined( fortress.outside_goalvolume ) )
    {
        if ( ispointinvolume( origin, fortress.outside_goalvolume ) )
        {
            agent setgoalvolume( fortress.outside_goalvolume );
        }
    }
}

// Namespace ai_fortress
// Params 2
// Checksum 0xc9f50c91, Offset: 0x6939
// Size: 0xb9
function function_af2a187f419e7b2f( door, player )
{
    if ( isdefined( door.fortress ) && !door.fortress.unlocked )
    {
        door.fortress.unlocked = 1;
        callback::callback( #"player_unlock_door", { #player:player, #door:door } );
        
        if ( isdefined( door.var_1e332e7db94be59b ) )
        {
            self thread [[ door.var_1e332e7db94be59b ]]( player );
        }
        
        wait randomfloatrange( 5, 9 );
        level thread function_54731d740af47e29( door.fortress );
    }
}

// Namespace ai_fortress
// Params 2
// Checksum 0x13d83c1b, Offset: 0x69fa
// Size: 0x56
function function_cbb62c6f3589edf( door, player )
{
    if ( isdefined( door.fortress ) && !door.fortress.unlocked )
    {
        door.fortress.unlocked = 1;
    }
}

// Namespace ai_fortress
// Params 1
// Checksum 0xb4355594, Offset: 0x6a58
// Size: 0x15, Type: bool
function function_f96df72675d7e8c6( origin )
{
    return isdefined( function_386da8b7d1afe346( origin ) );
}

// Namespace ai_fortress
// Params 1
// Checksum 0xbbc85d98, Offset: 0x6a76
// Size: 0x148
function function_aa6a893e932e7e72( origin )
{
    if ( !isdefined( level.var_8ea6e2a4c9dc0cf6 ) )
    {
        return;
    }
    
    if ( !isvector( origin ) )
    {
        return;
    }
    
    tempvolumes = sortbydistance( level.var_8ea6e2a4c9dc0cf6, origin );
    potentialvolume = undefined;
    var_d1a65e0faa108d2c = 3;
    var_264ac7761daaa74a = 0;
    
    foreach ( volume in tempvolumes )
    {
        if ( potentialvolume )
        {
            var_264ac7761daaa74a++;
        }
        
        if ( ispointinvolume( origin, volume ) )
        {
            if ( volume.targetname )
            {
                linkednode = utility::getstruct( volume.targetname, "target" );
                
                if ( !potentialvolume && issubstr( linkednode.script_noteworthy, "cluster" ) )
                {
                    potentialvolume = volume;
                }
                else
                {
                    return volume;
                }
            }
            else
            {
                return volume;
            }
        }
        
        if ( potentialvolume && var_264ac7761daaa74a >= var_d1a65e0faa108d2c )
        {
            return potentialvolume;
        }
    }
}

// Namespace ai_fortress
// Params 0
// Checksum 0x7bb81e98, Offset: 0x6bc7
// Size: 0x168
function function_d2fd34fa19849398()
{
    foreach ( volume in level.var_8ea6e2a4c9dc0cf6 )
    {
        if ( !isdefined( volume.targetname ) )
        {
            continue;
        }
        
        linkednode = utility::getstruct( volume.targetname, "target" );
        
        if ( linkednode.script_noteworthy )
        {
            if ( issubstr( linkednode.script_noteworthy, "|compound" ) || issubstr( linkednode.script_noteworthy, "compound|" ) || issubstr( linkednode.script_noteworthy, "|checkpoint" ) || issubstr( linkednode.script_noteworthy, "checkpoint|" ) || issubstr( linkednode.script_noteworthy, "|outside" ) || issubstr( linkednode.script_noteworthy, "outside|" ) || issubstr( linkednode.script_noteworthy, "hunttower" ) )
            {
                volume.var_feaf3a15592bdcb2 = 1;
            }
        }
    }
}

// Namespace ai_fortress
// Params 2
// Checksum 0xe35964ca, Offset: 0x6d37
// Size: 0xe8, Type: bool
function function_a38917c33bb50ae3( origin, var_ac8ce162f4b38f08 = 3 )
{
    tempvolumes = sortbydistance( level.var_8ea6e2a4c9dc0cf6, origin );
    
    foreach ( index, volume in tempvolumes )
    {
        if ( !isdefined( volume.targetname ) )
        {
            if ( ispointinvolume( origin, volume ) )
            {
                return true;
            }
            
            continue;
        }
        
        if ( volume.var_feaf3a15592bdcb2 )
        {
            continue;
        }
        
        if ( index >= var_ac8ce162f4b38f08 )
        {
            return false;
        }
        
        if ( ispointinvolume( origin, volume ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace ai_fortress
// Params 1
// Checksum 0xd0ef5634, Offset: 0x6e28
// Size: 0xb1, Type: bool
function function_5428359c3c1916ac( origin )
{
    if ( isdefined( level.lockedvolumes ) && level.lockedvolumes.size > 0 )
    {
        foreach ( volume in level.lockedvolumes )
        {
            if ( !isdefined( volume ) )
            {
                continue;
            }
            
            if ( ispointinvolume( origin, volume ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace ai_fortress
// Params 2
// Checksum 0xc2854fde, Offset: 0x6ee2
// Size: 0x169, Type: bool
function function_fd527fe79c5d43e8( origin, ignoreheight )
{
    if ( isdefined( level.fortressstruct ) )
    {
        foreach ( fortress in level.fortressstruct.chosenfortresses )
        {
            foreach ( volume in fortress.fortressvolumes )
            {
                if ( game_utility::getgametype() == "aladdin" && !isdefined( volume ) )
                {
                    continue;
                }
                
                if ( ignoreheight )
                {
                    var_fd59b1097c9c1d9f = ( origin[ 0 ], origin[ 1 ], volume.origin[ 2 ] );
                    
                    if ( ispointinvolume( var_fd59b1097c9c1d9f, volume ) )
                    {
                        return true;
                    }
                    
                    continue;
                }
                
                if ( ispointinvolume( origin, volume ) )
                {
                    return true;
                }
            }
        }
    }
    
    return false;
}

// Namespace ai_fortress
// Params 1
// Checksum 0x78b1ea79, Offset: 0x7054
// Size: 0xa7, Type: bool
function function_f45832ffece5dbb( origin )
{
    if ( isdefined( level.var_13f258417276805a ) && level.var_13f258417276805a.size > 0 )
    {
        foreach ( volume in level.var_13f258417276805a )
        {
            if ( ispointinvolume( origin, volume ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace ai_fortress
// Params 1
// Checksum 0x81d2dd84, Offset: 0x7104
// Size: 0xbb
function function_386da8b7d1afe346( origin )
{
    if ( !( isdefined( level.fortressstruct ) && isdefined( level.fortressstruct.chosenfortresses ) ) )
    {
        return;
    }
    
    foreach ( fortress in level.fortressstruct.chosenfortresses )
    {
        if ( function_b503355797d23e54( origin, fortress ) )
        {
            return fortress;
        }
    }
}

// Namespace ai_fortress
// Params 2
// Checksum 0xf2e72100, Offset: 0x71c8
// Size: 0xea, Type: bool
function function_b503355797d23e54( origin, fortress )
{
    if ( !( isdefined( fortress ) && isdefined( fortress.fortressvolumes ) ) || fortress.fortressvolumes.size == 0 )
    {
        return false;
    }
    
    if ( !isdefined( fortress.fortressvolumes ) || fortress.fortressvolumes.size == 0 )
    {
        return false;
    }
    
    foreach ( volume in fortress.fortressvolumes )
    {
        if ( isdefined( volume ) && ispointinvolume( origin, volume ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace ai_fortress
// Params 0
// Checksum 0x5480c361, Offset: 0x72bb
// Size: 0x20
function function_227fd362aaa3252c()
{
    if ( !fortress_issystemactive() )
    {
        return;
    }
    
    return level.fortressstruct.chosenfortresses;
}

// Namespace ai_fortress
// Params 1
// Checksum 0xa9355dd1, Offset: 0x72e4
// Size: 0xa5
function function_772c336fece80a53( name )
{
    if ( !fortress_issystemactive() )
    {
        return;
    }
    
    foreach ( fortress in level.fortressstruct.chosenfortresses )
    {
        if ( name == fortress.script_noteworthy )
        {
            return fortress;
        }
    }
}

// Namespace ai_fortress
// Params 0
// Checksum 0x1a82374a, Offset: 0x7392
// Size: 0xe
function function_44762f8a5f59d806()
{
    return utility::array_random( function_227fd362aaa3252c() );
}

// Namespace ai_fortress
// Params 0
// Checksum 0xbc90ff, Offset: 0x73a9
// Size: 0xc, Type: bool
function fortress_issystemactive()
{
    return isdefined( level.fortressstruct );
}

// Namespace ai_fortress
// Params 1
// Checksum 0x59db51c7, Offset: 0x73be
// Size: 0x3a, Type: bool
function function_1d4c7c521dd6fe83( fortress )
{
    return !fortress.unlocked && !isdefined( fortress.ishero ) && !isdefined( fortress.var_36b98792086e5abc );
}

// Namespace ai_fortress
// Params 1
// Checksum 0xb3b1b3ed, Offset: 0x7401
// Size: 0x124
function function_b1546ff296521ffb( fortress )
{
    tripwires = getentitylessscriptablearray( "scriptable_dmz_tripwire", #classname );
    tripwires = arrayrandomize( tripwires );
    
    foreach ( tripwire in tripwires )
    {
        if ( !isdefined( tripwire.target ) )
        {
            continue;
        }
        
        var_16ba410437a14cd3 = tripwire.origin + anglestoforward( tripwire.angles ) * 45;
        
        if ( function_b503355797d23e54( var_16ba410437a14cd3, fortress ) )
        {
            if ( !isdefined( fortress.tripwires ) )
            {
                fortress.tripwires = [];
            }
            
            fortress.tripwires[ fortress.tripwires.size ] = tripwire;
            tripwire.inactivefortress = 1;
        }
    }
}

// Namespace ai_fortress
// Params 1
// Checksum 0x6bd48427, Offset: 0x752d
// Size: 0x1dc
function function_a9e180e55eb44b65( fortress )
{
    if ( !isdefined( fortress.tripwires ) )
    {
        return;
    }
    
    mintraps = 0;
    maxtraps = 0;
    
    if ( isdefined( fortress.var_455a44201e409a8b ) )
    {
        mintraps = fortress.var_455a44201e409a8b - 1;
        maxtraps = fortress.var_455a44201e409a8b;
    }
    else
    {
        switch ( fortress.fortresssize )
        {
            case #"hash_5971965ed985a26c":
                mintraps = 1;
                maxtraps = 2;
                break;
            case #"hash_c71b112fe04823d6":
                mintraps = 2;
                maxtraps = 3;
                break;
            case #"hash_4bf33d595d8f4894":
                mintraps = 2;
                maxtraps = 4;
                break;
            case #"hash_b0cb9e547c45dab9":
                mintraps = 3;
                maxtraps = 6;
                break;
            case #"hash_d243059de5613193":
                mintraps = 6;
                maxtraps = 8;
                break;
            case #"hash_102d658881a66d2a":
                mintraps = 0;
                maxtraps = 1;
                break;
        }
    }
    
    var_9d319f61ff9900ba = randomintrange( mintraps, maxtraps );
    fortress.tripwires = arrayrandomize( fortress.tripwires );
    
    foreach ( index, tripwire in fortress.tripwires )
    {
        if ( index < var_9d319f61ff9900ba )
        {
            if ( isdefined( level.var_c0402a9389a09e35 ) )
            {
                [[ level.var_c0402a9389a09e35 ]]( tripwire );
            }
            
            continue;
        }
        
        if ( isdefined( level.var_4e09347566c3e902 ) )
        {
            [[ level.var_4e09347566c3e902 ]]( tripwire );
        }
    }
}

// Namespace ai_fortress
// Params 1
// Checksum 0xcf97f11, Offset: 0x7711
// Size: 0x1f6
function function_dbacfbf9f6b9e570( fortress )
{
    if ( !isdefined( level.firetraps ) )
    {
        return;
    }
    
    var_4e750a5f7f526e0f = 0;
    
    foreach ( barrel in fortress.firebarrels )
    {
        if ( var_4e750a5f7f526e0f >= 5 )
        {
            break;
        }
        
        if ( !isdefined( level.firetraps.traps[ "fireBarrel" ].spawnfunction ) )
        {
            break;
        }
        
        barrelscriptable = [[ level.firetraps.traps[ "fireBarrel" ].spawnfunction ]]( barrel );
        
        if ( isdefined( barrelscriptable ) )
        {
            barrelscriptable.fortress = fortress;
            var_4e750a5f7f526e0f++;
        }
    }
    
    foreach ( gaspuddle in fortress.gaspuddles )
    {
        if ( !isdefined( level.firetraps.traps[ "fireBarrel" ].spawnfunction ) )
        {
            break;
        }
        
        gaspuddlescriptable = [[ level.firetraps.traps[ "gasPuddle" ].spawnfunction ]]( gaspuddle );
        
        if ( isdefined( gaspuddlescriptable ) )
        {
            gaspuddlescriptable.fortress = fortress;
        }
    }
}

// Namespace ai_fortress
// Params 1
// Checksum 0x7f6110e3, Offset: 0x790f
// Size: 0x91
function fortress_trackclearing( fortress )
{
    level endon( #"game_ended" );
    fortress.contributingplayers = [];
    fortress utility::ent_flag_wait( "spawned_agents" );
    fortress.cleared = 0;
    
    while ( !fortress.cleared )
    {
        fortress.var_852cf2e2a116519 = function_7c7f41d3fd5028a5( fortress.uniquename );
        
        if ( fortress.var_852cf2e2a116519 == 0 )
        {
            fortress.cleared = 1;
        }
        
        wait 1;
    }
}

// Namespace ai_fortress
// Params 2
// Checksum 0xf8c6a165, Offset: 0x79a8
// Size: 0x122
function function_fefc18d15b49ee39( fortress, var_338cc4d19cab0569 )
{
    foreach ( volume in fortress.fortressvolumes )
    {
        level.lockedvolumes[ level.lockedvolumes.size ] = volume;
    }
    
    if ( var_338cc4d19cab0569 )
    {
        foreach ( volume in fortress.fortressvolumes )
        {
            level.var_13f258417276805a[ level.var_13f258417276805a.size ] = volume;
        }
    }
}

// Namespace ai_fortress
// Params 0
// Checksum 0x3f5aa28f, Offset: 0x7ad2
// Size: 0x37a
function function_c75d278f58491fe6()
{
    var_ae472884afadc17a = getdvarint( @"hash_f2a7d1ed476ed0e1", 4 );
    arraykeys = getarraykeys( level.fortressstruct.var_db1aefa5b9c86d7e );
    arraykeys = arrayrandomize( arraykeys );
    
    foreach ( key in arraykeys )
    {
        if ( level.fortressstruct.var_db1aefa5b9c86d7e[ key ].name != "unnamed" )
        {
            level.fortressstruct.var_db1aefa5b9c86d7e[ key ].fortresssize = "hero_epic";
            var_ae472884afadc17a--;
        }
        
        if ( var_ae472884afadc17a <= 0 )
        {
            break;
        }
    }
    
    foreach ( var_9ab17f0e9feabe69 in level.fortressstruct.var_db1aefa5b9c86d7e )
    {
        if ( var_9ab17f0e9feabe69.isactive )
        {
            continue;
        }
        
        if ( var_9ab17f0e9feabe69.name == "unnamed" )
        {
            continue;
        }
        
        if ( !level.var_9f2170873bfef08d )
        {
            ispoiactive = utility::callsharedfunc( #"poi", #"isactive", var_9ab17f0e9feabe69.origin, var_9ab17f0e9feabe69.script_poi );
            
            if ( !ispoiactive )
            {
                continue;
            }
        }
        
        function_d9f4f0632c1968e( var_9ab17f0e9feabe69 );
        
        if ( !level.var_9f2170873bfef08d )
        {
            if ( isdefined( var_9ab17f0e9feabe69.poiname ) && isdefined( var_9ab17f0e9feabe69.subarea.subareaname ) && isdefined( level.poi[ var_9ab17f0e9feabe69.poiname ][ "subAreas" ][ var_9ab17f0e9feabe69.subarea.subareaname ].tuning ) )
            {
                var_9ab17f0e9feabe69.tieroverride = level.poi[ var_9ab17f0e9feabe69.poiname ][ "subAreas" ][ var_9ab17f0e9feabe69.subarea.subareaname ].tuning.difficultyrating;
            }
        }
        
        if ( getdvarint( @"hash_90f8afdf2703a2ff", 0 ) > 0 )
        {
            level.fortressstruct.chosenfortresses = level.fortressstruct.var_db1aefa5b9c86d7e;
        }
        
        if ( !arraycontains( level.fortressstruct.chosenfortresses, var_9ab17f0e9feabe69 ) )
        {
            var_9ab17f0e9feabe69.fortresssize = "hero_disabled";
            level thread function_276efad9cd97ee6f( var_9ab17f0e9feabe69 );
            continue;
        }
        
        level thread function_a40880395f853edc( var_9ab17f0e9feabe69, 1, 1, 1, 1, undefined, undefined, undefined, 1, 0, 1 );
        
        if ( var_9ab17f0e9feabe69.fortresssize == "hero_epic" )
        {
            function_6463efa3fcc13599( var_9ab17f0e9feabe69.origin );
        }
    }
}

// Namespace ai_fortress
// Params 1
// Checksum 0x6e4187ea, Offset: 0x7e54
// Size: 0x26, Type: bool
function function_c4cc2f9a17167e1b( fortress )
{
    return fortress.ishero || fortress.var_36b98792086e5abc;
}

// Namespace ai_fortress
// Params 1
// Checksum 0xbfbacd1f, Offset: 0x7e83
// Size: 0x36
function function_bc6ca17f884fb790( fortress )
{
    isnoteworthy = 0;
    
    if ( issubstr( fortress.script_noteworthy, "police" ) )
    {
        isnoteworthy = 1;
    }
    
    return isnoteworthy;
}

// Namespace ai_fortress
// Params 0
// Checksum 0xe596de22, Offset: 0x7ec2
// Size: 0x166
function function_8a52ff7b928bd67b()
{
    while ( !flags::gameflagexists( "prematch_done" ) || flags::gameflagexists( "prematch_done" ) && !flags::gameflag( "prematch_done" ) )
    {
        waitframe();
    }
    
    var_7ddcb55e9c189cff = [];
    
    foreach ( fortressnode in level.fortressstruct.unusedfortresses )
    {
        closestvolume = function_47c86977a18df38b( level.var_8ea6e2a4c9dc0cf6, fortressnode.origin );
        
        if ( distance2dsquared( closestvolume.origin, fortressnode.origin ) > 2359296 )
        {
            println( "<dev string:x142>" + fortressnode.origin );
            continue;
        }
        
        volumes = [ closestvolume ];
        
        if ( isdefined( closestvolume.targetname ) )
        {
            volumes = getentarray( closestvolume.targetname, #targetname );
        }
        
        var_7ddcb55e9c189cff = arraycombine( var_7ddcb55e9c189cff, volumes );
    }
    
    utility::array_delete( var_7ddcb55e9c189cff );
}

// Namespace ai_fortress
// Params 1
// Checksum 0x8dbf11b6, Offset: 0x8030
// Size: 0xcc
function function_249e166848acc7a2( fortress )
{
    if ( getdvarint( @"hash_a13f3213c557f5fd", 1 ) == 0 )
    {
        return;
    }
    
    foreach ( volume in fortress.fortressvolumes )
    {
        volume.name = fortress.name;
        volume.script_poi = fortress.script_poi;
        level thread function_836b5dc2da6a5037( volume, fortress );
    }
}

// Namespace ai_fortress
// Params 2
// Checksum 0x33f01803, Offset: 0x8104
// Size: 0x1eb
function function_836b5dc2da6a5037( volume, fortress )
{
    volume.var_92d07dbcc2b0b73e = [];
    volume.playersplashlist = [];
    
    while ( true )
    {
        wait 1;
        
        if ( !isdefined( volume.script_poi ) )
        {
            playerstocheck = level.players;
        }
        else
        {
            playerstocheck = level.poi[ volume.script_poi ][ "players" ];
        }
        
        if ( !isdefined( playerstocheck ) || playerstocheck.size == 0 )
        {
            continue;
        }
        
        foreach ( player in playerstocheck )
        {
            if ( !isdefined( player.origin ) )
            {
                continue;
            }
            
            if ( distance2dsquared( volume.origin, player.origin ) < 25000000 )
            {
                playerid = player getentitynumber();
                
                if ( ispointinvolume( player.origin, volume ) )
                {
                    if ( isdefined( volume.onplayerenter ) && !isdefined( volume.var_92d07dbcc2b0b73e[ playerid ] ) )
                    {
                        volume thread [[ volume.onplayerenter ]]( player );
                    }
                    
                    if ( function_aaff6d83d6c91f4( playerid, volume ) )
                    {
                        player thread function_25d02ce5088e5a64( player, fortress.splashname );
                    }
                    
                    continue;
                }
                
                if ( isdefined( volume.onplayerexit ) && isdefined( volume.var_92d07dbcc2b0b73e[ playerid ] ) )
                {
                    volume thread [[ volume.onplayerexit ]]( player );
                }
                
                volume.var_92d07dbcc2b0b73e[ playerid ] = undefined;
            }
        }
    }
}

// Namespace ai_fortress
// Params 2
// Checksum 0x78fce46, Offset: 0x82f7
// Size: 0xbd
function function_aaff6d83d6c91f4( playerid, volume )
{
    time = gettime();
    
    if ( volume.var_92d07dbcc2b0b73e[ playerid ] )
    {
        volume.playersplashlist[ playerid ] = time;
        return 0;
    }
    else
    {
        volume.var_92d07dbcc2b0b73e[ playerid ] = 1;
    }
    
    var_a05e2f2ef2d50ed2 = 45000;
    
    if ( isdefined( volume.playersplashlist[ playerid ] ) )
    {
        if ( volume.playersplashlist[ playerid ] + var_a05e2f2ef2d50ed2 < time )
        {
            volume.playersplashlist[ playerid ] = time;
            return 1;
        }
        
        return 0;
    }
    
    volume.playersplashlist[ playerid ] = time;
    return 1;
}

// Namespace ai_fortress
// Params 2
// Checksum 0x66be5b0c, Offset: 0x83bc
// Size: 0x78
function function_25d02ce5088e5a64( player, splashname )
{
    if ( !( isdefined( player ) && isdefined( splashname ) ) )
    {
        return;
    }
    
    playerarray = [ player ];
    player thread utility::callsharedfunc( #"splash", #"hash_1cdff8916d495428", splashname, playerarray );
    thread utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"denied_area_enter", playerarray );
}

// Namespace ai_fortress
// Params 0
// Checksum 0xc28ded5d, Offset: 0x843c
// Size: 0x8f7
function function_834f23887347e96c()
{
    level.fortressstruct.var_e7f5e44895b34df7 = [];
    level.fortressstruct.var_e7f5e44895b34df7[ "valuables" ] = [];
    level.fortressstruct.var_e7f5e44895b34df7[ "rare" ] = [];
    level.fortressstruct.var_e7f5e44895b34df7[ "epic" ] = [];
    level.fortressstruct.var_6a6bb07203e05edf = [];
    level.fortressstruct.var_6a6bb07203e05edf[ "valuables" ] = 60;
    level.fortressstruct.var_6a6bb07203e05edf[ "rare" ] = 35;
    level.fortressstruct.var_6a6bb07203e05edf[ "epic" ] = 5;
    level.fortressstruct.var_b3c91b5ad9433b7d = [];
    level.fortressstruct.var_b3c91b5ad9433b7d[ "valuables" ] = "consumable";
    level.fortressstruct.var_b3c91b5ad9433b7d[ "rare" ] = "weapon";
    level.fortressstruct.var_b3c91b5ad9433b7d[ "epic" ] = "weapon";
    level.fortressstruct.var_e7f5e44895b34df7[ "valuables" ][ level.fortressstruct.var_e7f5e44895b34df7[ "valuables" ].size ] = "brloot_plunder_cash_epic_1";
    level.fortressstruct.var_e7f5e44895b34df7[ "valuables" ][ level.fortressstruct.var_e7f5e44895b34df7[ "valuables" ].size ] = "brloot_plunder_cash_epic_2";
    level.fortressstruct.var_e7f5e44895b34df7[ "valuables" ][ level.fortressstruct.var_e7f5e44895b34df7[ "valuables" ].size ] = "brloot_plunder_cash_legendary_1";
    level.fortressstruct.var_e7f5e44895b34df7[ "valuables" ][ level.fortressstruct.var_e7f5e44895b34df7[ "valuables" ].size ] = "brloot_plate_carrier_3";
    level.fortressstruct.var_e7f5e44895b34df7[ "valuables" ][ level.fortressstruct.var_e7f5e44895b34df7[ "valuables" ].size ] = "brloot_killstreak_clusterstrike";
    level.fortressstruct.var_e7f5e44895b34df7[ "valuables" ][ level.fortressstruct.var_e7f5e44895b34df7[ "valuables" ].size ] = "brloot_killstreak_precision_airstrike";
    level.fortressstruct.var_e7f5e44895b34df7[ "valuables" ][ level.fortressstruct.var_e7f5e44895b34df7[ "valuables" ].size ] = "brloot_killstreak_uav";
    level.fortressstruct.var_e7f5e44895b34df7[ "valuables" ][ level.fortressstruct.var_e7f5e44895b34df7[ "valuables" ].size ] = "brloot_valuable_goldbar";
    level.fortressstruct.var_e7f5e44895b34df7[ "rare" ][ level.fortressstruct.var_e7f5e44895b34df7[ "rare" ].size ] = "brloot_weapon_br_msecho_epic";
    level.fortressstruct.var_e7f5e44895b34df7[ "rare" ][ level.fortressstruct.var_e7f5e44895b34df7[ "rare" ].size ] = "brloot_weapon_la_rpapa7_epic";
    level.fortressstruct.var_e7f5e44895b34df7[ "rare" ][ level.fortressstruct.var_e7f5e44895b34df7[ "rare" ].size ] = "brloot_weapon_dm_pgolf1_epic";
    level.fortressstruct.var_e7f5e44895b34df7[ "rare" ][ level.fortressstruct.var_e7f5e44895b34df7[ "rare" ].size ] = "brloot_weapon_dm_la700_epic";
    level.fortressstruct.var_e7f5e44895b34df7[ "rare" ][ level.fortressstruct.var_e7f5e44895b34df7[ "rare" ].size ] = "brloot_weapon_br_soscar14_epic";
    level.fortressstruct.var_e7f5e44895b34df7[ "rare" ][ level.fortressstruct.var_e7f5e44895b34df7[ "rare" ].size ] = "brloot_weapon_sh_charlie725_epic";
    level.fortressstruct.var_e7f5e44895b34df7[ "rare" ][ level.fortressstruct.var_e7f5e44895b34df7[ "rare" ].size ] = "brloot_weapon_sh_mviktor_epic";
    level.fortressstruct.var_e7f5e44895b34df7[ "rare" ][ level.fortressstruct.var_e7f5e44895b34df7[ "rare" ].size ] = "brloot_weapon_pi_golf17_epic";
    level.fortressstruct.var_e7f5e44895b34df7[ "rare" ][ level.fortressstruct.var_e7f5e44895b34df7[ "rare" ].size ] = "brloot_weapon_lm_ahotel_epic";
    level.fortressstruct.var_e7f5e44895b34df7[ "rare" ][ level.fortressstruct.var_e7f5e44895b34df7[ "rare" ].size ] = "brloot_weapon_lm_kilo21_epic";
    level.fortressstruct.var_e7f5e44895b34df7[ "rare" ][ level.fortressstruct.var_e7f5e44895b34df7[ "rare" ].size ] = "brloot_weapon_ar_mike4_epic";
    level.fortressstruct.var_e7f5e44895b34df7[ "rare" ][ level.fortressstruct.var_e7f5e44895b34df7[ "rare" ].size ] = "brloot_weapon_ar_kilo53_epic";
    level.fortressstruct.var_e7f5e44895b34df7[ "rare" ][ level.fortressstruct.var_e7f5e44895b34df7[ "rare" ].size ] = "brloot_weapon_sm_papa90_epic";
    level.fortressstruct.var_e7f5e44895b34df7[ "epic" ][ level.fortressstruct.var_e7f5e44895b34df7[ "epic" ].size ] = "brloot_weapon_ar_golf3_lege";
    level.fortressstruct.var_e7f5e44895b34df7[ "epic" ][ level.fortressstruct.var_e7f5e44895b34df7[ "epic" ].size ] = "brloot_weapon_br_msecho_lege";
    level.fortressstruct.var_e7f5e44895b34df7[ "epic" ][ level.fortressstruct.var_e7f5e44895b34df7[ "epic" ].size ] = "brloot_weapon_dm_mike14_lege";
    level.fortressstruct.var_e7f5e44895b34df7[ "epic" ][ level.fortressstruct.var_e7f5e44895b34df7[ "epic" ].size ] = "brloot_weapon_dm_sa700_lege";
    level.fortressstruct.var_e7f5e44895b34df7[ "epic" ][ level.fortressstruct.var_e7f5e44895b34df7[ "epic" ].size ] = "brloot_weapon_dm_scromeo_lege";
    level.fortressstruct.var_e7f5e44895b34df7[ "epic" ][ level.fortressstruct.var_e7f5e44895b34df7[ "epic" ].size ] = "brloot_weapon_sh_mbravo_lege";
    level.fortressstruct.var_e7f5e44895b34df7[ "epic" ][ level.fortressstruct.var_e7f5e44895b34df7[ "epic" ].size ] = "brloot_weapon_pi_decho_lege";
    level.fortressstruct.var_e7f5e44895b34df7[ "epic" ][ level.fortressstruct.var_e7f5e44895b34df7[ "epic" ].size ] = "brloot_weapon_lm_foxtrot_lege";
    level.fortressstruct.var_e7f5e44895b34df7[ "epic" ][ level.fortressstruct.var_e7f5e44895b34df7[ "epic" ].size ] = "brloot_weapon_lm_rkilo_lege";
    level.fortressstruct.var_e7f5e44895b34df7[ "epic" ][ level.fortressstruct.var_e7f5e44895b34df7[ "epic" ].size ] = "brloot_weapon_ar_kilo53_lege";
    level.fortressstruct.var_e7f5e44895b34df7[ "epic" ][ level.fortressstruct.var_e7f5e44895b34df7[ "epic" ].size ] = "brloot_weapon_ar_augolf_epic";
    level.fortressstruct.var_e7f5e44895b34df7[ "epic" ][ level.fortressstruct.var_e7f5e44895b34df7[ "epic" ].size ] = "brloot_weapon_ar_akilo_lege";
    level.fortressstruct.var_e7f5e44895b34df7[ "epic" ][ level.fortressstruct.var_e7f5e44895b34df7[ "epic" ].size ] = "brloot_weapon_sm_victor_lege";
}

// Namespace ai_fortress
// Params 0
// Checksum 0xa5c826fd, Offset: 0x8d3b
// Size: 0x19d
function function_459a5e99cca4ad92()
{
    totaltickets = 0;
    
    foreach ( categorytickets in level.fortressstruct.var_6a6bb07203e05edf )
    {
        totaltickets += categorytickets;
    }
    
    roll = randomint( totaltickets );
    var_7468dae6c2b387f9 = 0;
    var_222c040335b4137f = undefined;
    
    foreach ( category, categorytickets in level.fortressstruct.var_6a6bb07203e05edf )
    {
        var_7468dae6c2b387f9 += categorytickets;
        
        if ( roll <= var_7468dae6c2b387f9 )
        {
            var_222c040335b4137f = category;
            break;
        }
    }
    
    if ( !isdefined( var_222c040335b4137f ) )
    {
        return [ undefined, undefined ];
    }
    
    item = utility::array_random( level.fortressstruct.var_e7f5e44895b34df7[ var_222c040335b4137f ] );
    itemtable = level.fortressstruct.var_b3c91b5ad9433b7d[ var_222c040335b4137f ];
    return [ item, itemtable ];
}

// Namespace ai_fortress
// Params 1
// Checksum 0xd628c06e, Offset: 0x8ee1
// Size: 0x1d9
function function_6463efa3fcc13599( fortressorigin )
{
    var_46567b05dbd1dabe = getlootscriptablearrayinradius( "br_loot_cache_lege", undefined, fortressorigin, 2048 );
    var_1b6220c458c3aad1 = getentitylessscriptablearray( "dmz_crate_wood", undefined, fortressorigin, 2048 );
    cachearray = arraycombine( var_46567b05dbd1dabe, var_1b6220c458c3aad1 );
    
    foreach ( cache in cachearray )
    {
        if ( cache.var_2a54a0d09c47a115 )
        {
            continue;
        }
        
        items = getscriptablelootcachecontents( cache );
        cache.containertype = 3;
        common_cache::function_a09e7cf5bad99b64( cache, items );
        [ lootitem, itemtable ] = function_459a5e99cca4ad92();
        
        if ( !isdefined( lootitem ) )
        {
            return;
        }
        
        if ( itemtable == "weapon" )
        {
            count = 1;
        }
        else if ( level.var_bfa750d9db209a4b )
        {
            count = "";
            
            if ( isdefined( level.br_pickups.counts[ lootitem ] ) )
            {
                count = level.br_pickups.counts[ lootitem ];
            }
        }
        else
        {
            count = tablelookup( level.brloottablename, 1, lootitem, 4 );
            
            if ( count == "" )
            {
                count = tablelookup( level.brloottablename, 1, lootitem, 4 );
            }
        }
        
        itembundlename = common_item_database::function_ca9ca606e66b5911( lootitem );
        common_cache::cache_additem( cache, itembundlename, count );
    }
}

// Namespace ai_fortress
// Params 1
// Checksum 0xf253e21, Offset: 0x90c2
// Size: 0xab
function function_8a2e50e624b6a234( agent )
{
    agent endon( #"death" );
    
    while ( !isdefined( agent.agentstruct.fortress ) )
    {
        waitframe();
    }
    
    fortress = agent.agentstruct.fortress;
    
    if ( fortress.unlocked )
    {
        return;
    }
    
    agent.var_ee914ad666562200 = 1;
    
    if ( !isdefined( fortress.riotshieldagents ) )
    {
        fortress.riotshieldagents = [];
    }
    
    fortress.riotshieldagents[ fortress.riotshieldagents.size ] = agent;
}

// Namespace ai_fortress
// Params 1
// Checksum 0xf66727fe, Offset: 0x9175
// Size: 0x51
function function_219125326672d385( agent )
{
    agent.agentstruct.fortress.riotshieldagents = arrayremove( agent.agentstruct.fortress.riotshieldagents, agent );
}

// Namespace ai_fortress
// Params 1
// Checksum 0xfbae9b8f, Offset: 0x91ce
// Size: 0xbe
function function_54731d740af47e29( fortress )
{
    if ( !isdefined( fortress.riotshieldagents ) || fortress.riotshieldagents.size <= 0 )
    {
        return;
    }
    
    foreach ( agent in fortress.riotshieldagents )
    {
        if ( isagent( agent ) && isalive( agent ) )
        {
            agent thread function_970208393faa30b( agent );
        }
    }
}

// Namespace ai_fortress
// Params 3
// Checksum 0x7cf82cd9, Offset: 0x9294
// Size: 0x5b
function function_970208393faa30b( agent, delaymin, delaymax )
{
    agent endon( #"death" );
    
    if ( !isdefined( delaymin ) )
    {
        delaymin = 2;
    }
    
    if ( !isdefined( delaymax ) )
    {
        delaymax = 8;
    }
    
    wait randomintrange( delaymin, delaymax );
    
    if ( isalive( agent ) )
    {
        agent.var_ee914ad666562200 = 0;
    }
}

// Namespace ai_fortress
// Params 3
// Checksum 0x457670f1, Offset: 0x92f7
// Size: 0x2a, Type: bool
function function_68e153fcac60daff( origin1, origin2, tolerance )
{
    return distancesquared( origin1, origin2 ) <= tolerance * tolerance;
}

// Namespace ai_fortress
// Params 1
// Checksum 0x83ef7d15, Offset: 0x932a
// Size: 0x29f
function function_c0155c35315a1021( fortress )
{
    if ( !isdefined( fortress ) )
    {
        return;
    }
    
    level endon( #"game_ended" );
    areaname = fortress.subarea.areaname;
    var_35900358b608a5a1 = [];
    var_6709d91deef45851 = [];
    cooldowntime = 60000;
    
    while ( true )
    {
        if ( isdefined( level.areas[ areaname ][ "players" ] ) )
        {
            foreach ( player in level.areas[ areaname ][ "players" ] )
            {
                if ( !isdefined( player ) )
                {
                    continue;
                }
                
                var_6aae07e96f2ec785 = player getentitynumber();
                
                if ( function_b503355797d23e54( player.origin, fortress ) )
                {
                    if ( !var_35900358b608a5a1[ var_6aae07e96f2ec785 ] )
                    {
                        setplayerobscured( player, 1 );
                        var_35900358b608a5a1[ var_6aae07e96f2ec785 ] = 1;
                        player thread utility::callsharedfunc( #"music_intensity", #"boost_intensity", { #timeout:180, #self_notify:"leave_fortress", #name:"fortress" } );
                        player.var_e7fae2aee1504843 = fortress.script_noteworthy;
                        callback::callback( #"on_player_enters_location", { #type:"fortress", #locationname:player.var_e7fae2aee1504843, #player:player } );
                        
                        if ( !var_6709d91deef45851[ var_6aae07e96f2ec785 ] || gettime() - var_6709d91deef45851[ var_6aae07e96f2ec785 ] > cooldowntime )
                        {
                            var_6709d91deef45851[ var_6aae07e96f2ec785 ] = gettime();
                            
                            if ( fortress.splashname )
                            {
                                function_53953f18d6231cd4( player, fortress.splashname, fortress.poiname );
                            }
                            
                            if ( isdefined( fortress.var_d55503182782806 ) )
                            {
                                [[ fortress.var_d55503182782806 ]]( player, fortress );
                            }
                        }
                    }
                }
                else if ( var_35900358b608a5a1[ var_6aae07e96f2ec785 ] )
                {
                    var_35900358b608a5a1[ var_6aae07e96f2ec785 ] = 0;
                    player.var_e7fae2aee1504843 = undefined;
                    setplayerobscured( player, 0 );
                }
                
                if ( isdefined( var_35900358b608a5a1[ var_6aae07e96f2ec785 ] ) && !var_35900358b608a5a1[ var_6aae07e96f2ec785 ] && var_6709d91deef45851[ var_6aae07e96f2ec785 ] )
                {
                    player notify( #"leave_fortress" );
                    var_35900358b608a5a1 = arrayremove( var_35900358b608a5a1, var_35900358b608a5a1[ var_6aae07e96f2ec785 ] );
                }
            }
        }
        
        wait 1;
    }
}

// Namespace ai_fortress
// Params 3
// Checksum 0x864329a1, Offset: 0x95d1
// Size: 0x44
function function_53953f18d6231cd4( player, splashname, poiname )
{
    player thread utility::callsharedfunc( #"splash", #"hash_1cdff8916d495428", splashname, [ player ], poiname );
}

/#

    // Namespace ai_fortress
    // Params 0
    // Checksum 0x95e0e483, Offset: 0x961d
    // Size: 0x2c3, Type: dev
    function function_65bb1a4a5da15a56()
    {
        hotzones = function_e2a061fcb85d84b5();
        
        while ( true )
        {
            if ( getdvarint( @"scr_fortress_debug", 0 ) == 1 )
            {
                foreach ( fortress in level.fortressstruct.var_1f188729b140132e )
                {
                    color = ( 0, 0, 1 );
                    
                    if ( fortress.invalidfortress )
                    {
                        color = ( 1, 0, 0 );
                    }
                    else if ( arraycontains( level.fortressstruct.chosenfortresses, fortress ) )
                    {
                        color = ( 0, 1, 0 );
                    }
                    
                    thread debug::drawsphere( fortress.origin, 256, 1, color );
                    print3d( fortress.origin, fortress.script_noteworthy, ( 1, 1, 1 ), 1, 3, 10 );
                }
                
                foreach ( hotzone in hotzones )
                {
                    hotzone_info = function_4e52a812b6d1d965( hotzone );
                    adjustmidpoint = ( hotzone_info.midpoint[ 0 ], hotzone_info.midpoint[ 1 ], hotzone_info.midpoint[ 2 ] * 1.5 );
                    print3d( adjustmidpoint, getxhashsourcename( hotzone_info.name ), ( 0, 0, 1 ), 1, 3, 10 );
                }
                
                foreach ( fortress in level.fortressstruct.var_a9ebedf0eab50c7 )
                {
                    thread debug::drawsphere( fortress.origin, 512, 1, ( 0, 1, 1 ) );
                }
            }
            
            wait 1;
        }
    }

    // Namespace ai_fortress
    // Params 0
    // Checksum 0xa9f9641b, Offset: 0x98e8
    // Size: 0x134, Type: dev
    function function_6ea41bc157949f11()
    {
        while ( true )
        {
            value = getdvarint( @"hash_9d95d1671eeaf942", 0 );
            
            if ( value == 1 )
            {
                if ( function_f96df72675d7e8c6( level.players[ 0 ].origin ) )
                {
                    printtoscreen2d( 350, 100, "<dev string:x193>", ( 0, 0, 1 ), 2 );
                }
                else if ( function_5428359c3c1916ac( level.players[ 0 ].origin ) )
                {
                    printtoscreen2d( 350, 100, "<dev string:x19f>", ( 0, 0, 1 ), 2 );
                }
                else
                {
                    printtoscreen2d( 350, 100, "<dev string:x1b0>", ( 0, 0, 1 ), 2 );
                }
            }
            
            if ( value == 2 )
            {
                if ( function_a38917c33bb50ae3( level.players[ 0 ].origin, 1000 ) )
                {
                    printtoscreen2d( 350, 100, "<dev string:x1c0>", ( 0, 0, 1 ), 2 );
                }
                else
                {
                    printtoscreen2d( 350, 100, "<dev string:x1c7>", ( 0, 0, 1 ), 2 );
                }
            }
            
            waitframe();
        }
    }

#/
