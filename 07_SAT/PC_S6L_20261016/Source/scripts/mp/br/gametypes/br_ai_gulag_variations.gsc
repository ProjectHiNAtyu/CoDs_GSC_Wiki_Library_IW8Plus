// scripts\mp\br\gametypes\br_ai_gulag_variations.gsc  (hash_46c4d4ae215f6f1e.gscc) (size: 19213 Bytes / 0x4b0d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc10f6907 (3239012615)
// size ...... 19213 (0x4b0d)
// includes .. 16  (offset: 0x4721)
// strings ... 56  (offset: 0x47a1)
// dev strs .. 0   (offset: 0x4b0d)
// exports ... 40  (offset: 0x3071)
// cseg ...... 0x54b + 0x2b26 (0x3071)
// imports ... 133 (offset: 0x36b1)
// animtree1 . 0   (offset: 0x4b0d)
// animtree2 . 0   (offset: 0x4b0d)
#using script_68bfedf2ed730bd;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\common\cap;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\br\gametypes\br_ai_gulag;
#using scripts\mp\br\gametypes\br_bosses_mi8jugg;
#using scripts\mp\br\gametypes\br_twotwo_gulag;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\shellshock_utility;
#using scripts\mp\hud_message;
#using scripts\mp\mp_agent;

#namespace br_ai_gulag_variations;

// Namespace br_ai_gulag_variations
// Params 0
// Checksum 0xffb5d902, Offset: 0x569
// Size: 0xf4
function function_aad3de341555b28e()
{
    if ( !level.var_56c3cc3dc37f1728.var_e4e46cc4a1abab24 )
    {
        return;
    }
    
    function_500458f7449da500();
    variationtypes = function_ce10b6586bef9089();
    level.var_56c3cc3dc37f1728.arena_variations = [];
    
    foreach ( variation in variationtypes )
    {
        level.var_56c3cc3dc37f1728.arena_variations[ variation.variationtype ] = variation;
    }
    
    level.var_56c3cc3dc37f1728.patroltier = getdvarint( @"hash_c2aeee6f21d5d332", 4 );
}

// Namespace br_ai_gulag_variations
// Params 0
// Checksum 0xe4b20a89, Offset: 0x665
// Size: 0x28
function function_500458f7449da500()
{
    game[ "dialog" ][ "gulag_jailer_incoming" ] = "fght_jalr_gutw";
    game[ "dialog" ][ "gulag_jailer_arrived" ] = "fght_jalr_guji";
}

// Namespace br_ai_gulag_variations
// Params 0
// Checksum 0x841cf785, Offset: 0x695
// Size: 0xd9
function function_ce10b6586bef9089()
{
    variationtypes = [];
    variationtypes[ variationtypes.size ] = "stationary_guards";
    variationtypes[ variationtypes.size ] = "mixed_combat";
    variationtypes[ variationtypes.size ] = "combat_rush";
    variationtypes[ variationtypes.size ] = "patrol_guards";
    variationtypes[ variationtypes.size ] = "jailer_guard";
    var_e21b8889e9da8c0e = [];
    
    foreach ( variation in variationtypes )
    {
        variationinfo = function_68325691d754a05a( variation );
        
        if ( isdefined( variationinfo ) )
        {
            var_e21b8889e9da8c0e[ var_e21b8889e9da8c0e.size ] = variationinfo;
        }
    }
    
    return var_e21b8889e9da8c0e;
}

// Namespace br_ai_gulag_variations
// Params 1
// Checksum 0x22d12f66, Offset: 0x777
// Size: 0x225
function function_68325691d754a05a( variationtype )
{
    if ( isdefined( variationtype ) )
    {
        var_f014540f9e398cf8 = function_9dd5c26eb5722347( variationtype );
        variationweight = getdvarfloat( hashcat( @"hash_ff06b06505b0fffc", variationtype ), var_f014540f9e398cf8 );
        
        if ( getdvar( @"hash_865217224dbe397", "" ) == variationtype || variationweight > 0 )
        {
            variationinfo = spawnstruct();
            variationinfo.weight = variationweight;
            variationinfo.variationtype = variationtype;
            
            switch ( variationtype )
            {
                case #"hash_bb9a6dbe0d657692":
                    variationinfo.validatefunc = &function_e90b761564f1b7c;
                    variationinfo.initfunc = &function_3c962515d99f3b24;
                    variationinfo.var_f2badf70a8cab58 = &function_4cc71dd19084d500;
                    return variationinfo;
                case #"hash_c6c45a9602fd8ae1":
                    variationinfo.validatefunc = &function_b1e1a973375c58b3;
                    variationinfo.initfunc = &function_3130d2ee90af5a5b;
                    variationinfo.var_f2badf70a8cab58 = &function_15bd9ad32047c7f7;
                    return variationinfo;
                case #"hash_810f49d16cc7964c":
                    variationinfo.validatefunc = &function_129a5d33a5b0d20e;
                    variationinfo.initfunc = &function_728c10a55f678406;
                    variationinfo.var_f2badf70a8cab58 = &function_c403ea8625db26ca;
                    return variationinfo;
                case #"hash_53a8ebfb578e35d6":
                    variationinfo.validatefunc = &function_525c182dac9a030;
                    variationinfo.initfunc = &function_dbb7fdf2ef3a6b78;
                    variationinfo.var_f2badf70a8cab58 = &function_2847dba60ac1e8fc;
                    return variationinfo;
                case #"hash_3f6c88fccde37f5c":
                    variationinfo.validatefunc = &function_a969ce0dc8ea5ef0;
                    variationinfo.initfunc = &function_911b6ffcb845a238;
                    variationinfo.var_f2badf70a8cab58 = &function_10e6b1c8c8dd6edc;
                    return variationinfo;
                default:
                    variationinfo.validatefunc = &function_e90b761564f1b7c;
                    variationinfo.initfunc = &function_3c962515d99f3b24;
                    variationinfo.var_f2badf70a8cab58 = &function_4cc71dd19084d500;
                    return variationinfo;
            }
        }
    }
}

// Namespace br_ai_gulag_variations
// Params 1
// Checksum 0xa27b0cb2, Offset: 0x9a4
// Size: 0x74
function function_9dd5c26eb5722347( variationtype )
{
    if ( !isdefined( variationtype ) )
    {
        return 0;
    }
    
    switch ( variationtype )
    {
        case #"hash_bb9a6dbe0d657692":
            return 0;
        case #"hash_c6c45a9602fd8ae1":
            return 0;
        case #"hash_810f49d16cc7964c":
            return 0;
        case #"hash_53a8ebfb578e35d6":
            return 0;
        case #"hash_3f6c88fccde37f5c":
            return 1;
        default:
            return 0;
    }
}

// Namespace br_ai_gulag_variations
// Params 1
// Checksum 0x70f9f26f, Offset: 0xa20
// Size: 0x198
function function_baddb8c4549731db( arena )
{
    if ( isdefined( level.var_56c3cc3dc37f1728.arena_variations ) )
    {
        var_7b36d08d747edae6 = [];
        
        foreach ( variation in level.var_56c3cc3dc37f1728.arena_variations )
        {
            if ( isdefined( variation.validatefunc ) && [[ variation.validatefunc ]]( arena ) )
            {
                var_7b36d08d747edae6[ var_7b36d08d747edae6.size ] = variation.variationtype;
            }
        }
        
        variationoverride = getdvar( @"hash_865217224dbe397", "" );
        chosenvariation = "stationary_guards";
        
        if ( variationoverride == "" )
        {
            chosenvariation = function_cdab412aafbeffe0( var_7b36d08d747edae6 );
        }
        else if ( isdefined( level.var_56c3cc3dc37f1728.arena_variations[ variationoverride ] ) )
        {
            chosenvariation = variationoverride;
        }
        else
        {
            function_4d32ed524d5b0893( "Invalid Variation Type given for override. Using default variation." );
        }
        
        ranvariation = level.var_56c3cc3dc37f1728.arena_variations[ chosenvariation ];
        
        if ( isdefined( ranvariation.initfunc ) )
        {
            arena.currentvariation = ranvariation;
            [[ ranvariation.initfunc ]]( arena );
        }
    }
}

// Namespace br_ai_gulag_variations
// Params 1
// Checksum 0xe2be369a, Offset: 0xbc0
// Size: 0x15c
function function_cdab412aafbeffe0( validtypes )
{
    weightedsum = 0;
    accumulatedweights = [];
    
    foreach ( validtype in validtypes )
    {
        variationinfo = level.var_56c3cc3dc37f1728.arena_variations[ validtype ];
        assert( isdefined( variationinfo ) );
        variationweight = variationinfo.weight;
        weightedsum += variationweight;
        accumulatedweights[ validtype ] = weightedsum;
    }
    
    randchoice = randomfloat( weightedsum );
    
    foreach ( validtype in validtypes )
    {
        if ( accumulatedweights[ validtype ] >= randchoice )
        {
            return validtype;
        }
    }
    
    return "stationary_guards";
}

// Namespace br_ai_gulag_variations
// Params 1, eflags: 0x4
// Checksum 0x288036fd, Offset: 0xd25
// Size: 0x2b
function private function_4d32ed524d5b0893( message )
{
    if ( getdvarint( @"hash_ac25b65055b213b3", 1 ) )
    {
        logstring( "AI GULAG VARIATIONS: " + message );
    }
}

// Namespace br_ai_gulag_variations
// Params 1
// Checksum 0x10fe9781, Offset: 0xd58
// Size: 0xe, Type: bool
function function_e90b761564f1b7c( arena )
{
    return true;
}

// Namespace br_ai_gulag_variations
// Params 1
// Checksum 0x806d7e9b, Offset: 0xd6f
// Size: 0x88
function function_3c962515d99f3b24( arena )
{
    foreach ( aispawn in arena.ai_structs )
    {
        thread function_dfc54bbe7f44f8a2( arena, aispawn );
    }
}

// Namespace br_ai_gulag_variations
// Params 5
// Checksum 0x8c4ccae4, Offset: 0xdff
// Size: 0x149
function function_dfc54bbe7f44f8a2( arena, aispawn, basetype, tiernum, nationality )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( basetype ) )
    {
        basetype = "smg";
    }
    
    aitype = ai_mp_controller::function_f7aef6871cda828( basetype, tiernum, nationality );
    spawnlocation = aispawn.origin;
    
    if ( !getdvarint( @"hash_b3d7a9483362813e", 0 ) )
    {
        spawnlocation = getclosestpointonnavmesh( aispawn.origin );
    }
    
    agent = ai_mp_controller::ai_mp_requestspawnagent( aitype, spawnlocation, aispawn.angles, "absolute", "gulag", undefined, undefined, undefined, undefined, undefined, 1 );
    
    if ( isagent( agent ) )
    {
        agent thread br_ai_gulag::function_a0664a9707714ecd( arena );
        
        if ( getdvarint( @"hash_b3d7a9483362813e", 0 ) )
        {
            agent forceteleport( spawnlocation, aispawn.angles );
            agent setgoalpos( agent.origin, 32 );
            agent clearpath();
            agent.fixednode = 1;
            agent thread ai_behavior::behavior_GuardStationary( agent, 1, agent.origin );
            return;
        }
        
        agent thread ai_behavior::behavior_GuardStationary( agent );
    }
}

// Namespace br_ai_gulag_variations
// Params 2
// Checksum 0xee96e5f9, Offset: 0xf50
// Size: 0x15
function function_4cc71dd19084d500( arena, var_7e2eadbf67d6ed9b )
{
    
}

// Namespace br_ai_gulag_variations
// Params 1
// Checksum 0x45f8d923, Offset: 0xf6d
// Size: 0xe, Type: bool
function function_b1e1a973375c58b3( arena )
{
    return true;
}

// Namespace br_ai_gulag_variations
// Params 1
// Checksum 0xca6e1ea2, Offset: 0xf84
// Size: 0x111
function function_3130d2ee90af5a5b( arena )
{
    foreach ( aispawn in arena.ai_structs )
    {
        if ( isstartstr( aispawn.script_noteworthy, "gulag_ai_enemy_armory" ) )
        {
            thread function_92b1752501355651( arena, aispawn, undefined, 2 );
            continue;
        }
        
        if ( isstartstr( aispawn.script_noteworthy, "gulag_ai_enemy_meeting" ) )
        {
            thread function_dfc54bbe7f44f8a2( arena, aispawn, undefined, 2 );
            continue;
        }
        
        if ( isstartstr( aispawn.script_noteworthy, "gulag_ai_enemy_economy" ) )
        {
            thread function_92b1752501355651( arena, aispawn );
            continue;
        }
        
        if ( isstartstr( aispawn.script_noteworthy, "gulag_ai_enemy_bar" ) )
        {
            thread function_dfc54bbe7f44f8a2( arena, aispawn );
        }
    }
}

// Namespace br_ai_gulag_variations
// Params 2
// Checksum 0xf88ee765, Offset: 0x109d
// Size: 0x15
function function_15bd9ad32047c7f7( arena, var_7e2eadbf67d6ed9b )
{
    
}

// Namespace br_ai_gulag_variations
// Params 1
// Checksum 0xde42f0ec, Offset: 0x10ba
// Size: 0xe, Type: bool
function function_129a5d33a5b0d20e( arena )
{
    return true;
}

// Namespace br_ai_gulag_variations
// Params 1
// Checksum 0xaececcc3, Offset: 0x10d1
// Size: 0x88
function function_728c10a55f678406( arena )
{
    foreach ( aispawn in arena.ai_structs )
    {
        thread function_92b1752501355651( arena, aispawn );
    }
}

// Namespace br_ai_gulag_variations
// Params 5
// Checksum 0x8a10c1a8, Offset: 0x1161
// Size: 0xf3
function function_92b1752501355651( arena, aispawn, basetype, tiernum, nationality )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( basetype ) )
    {
        basetype = "smg";
    }
    
    aitype = ai_mp_controller::function_f7aef6871cda828( basetype, tiernum, nationality );
    spawnlocation = getclosestpointonnavmesh( aispawn.origin );
    agent = ai_mp_controller::ai_mp_requestspawnagent( aitype, spawnlocation, aispawn.angles, "absolute", "gulag", undefined, undefined, undefined, undefined, undefined, 1 );
    
    if ( isagent( agent ) )
    {
        agent thread br_ai_gulag::function_a0664a9707714ecd( arena );
        arena waittill( #"hash_691033fc1a60c497" );
        reinforceorigin = arena.fightspawns[ 0 ].origin;
        agent thread ai_behavior::behavior_combatRushOrigin( agent, reinforceorigin );
    }
}

// Namespace br_ai_gulag_variations
// Params 2
// Checksum 0x8acb4f72, Offset: 0x125c
// Size: 0x15
function function_c403ea8625db26ca( arena, var_7e2eadbf67d6ed9b )
{
    
}

// Namespace br_ai_gulag_variations
// Params 1
// Checksum 0x4b5579d9, Offset: 0x1279
// Size: 0xe, Type: bool
function function_525c182dac9a030( arena )
{
    return true;
}

// Namespace br_ai_gulag_variations
// Params 1
// Checksum 0x15e402a2, Offset: 0x1290
// Size: 0x21f
function function_dbb7fdf2ef3a6b78( arena )
{
    var_bf422c755c49f4b0 = getdvarint( @"hash_f8fe15aaf2f77c90", 3 );
    
    if ( var_bf422c755c49f4b0 <= 0 )
    {
        return;
    }
    
    respawncooldown = getdvarfloat( @"br_ai_gulag_respawn_cooldown", 8 );
    var_2e5acf82cd1ad404 = 0;
    spawnstructs = arrayrandomize( arena.ai_structs );
    basetype = undefined;
    
    if ( namespace_a974e4dd85555bc2::function_64591ecc14010927( arena ) && level.var_56c3cc3dc37f1728.patroltier == 4 )
    {
        basetype = "jugg";
        
        if ( !isdefined( level.bosses ) )
        {
            level.bosses = [];
            br_bosses_mi8jugg::mi8jugg_register();
            
            foreach ( boss in level.bosses )
            {
                if ( getdvarint( hashcat( @"scr_", boss.name, "_disabled" ), 0 ) > 0 )
                {
                    boss.disabled = 1;
                    continue;
                }
                
                if ( isdefined( boss.initfunc ) )
                {
                    [[ boss.initfunc ]]( boss );
                }
            }
        }
    }
    
    foreach ( aispawn in spawnstructs )
    {
        thread function_8c880ef50ebc82b6( arena, aispawn, basetype, level.var_56c3cc3dc37f1728.patroltier, undefined, respawncooldown );
        var_2e5acf82cd1ad404++;
        
        if ( var_2e5acf82cd1ad404 >= var_bf422c755c49f4b0 )
        {
            break;
        }
    }
}

// Namespace br_ai_gulag_variations
// Params 2
// Checksum 0x7ec2e2f8, Offset: 0x14b7
// Size: 0x15
function function_2847dba60ac1e8fc( arena, var_7e2eadbf67d6ed9b )
{
    
}

// Namespace br_ai_gulag_variations
// Params 6
// Checksum 0xd6705444, Offset: 0x14d4
// Size: 0x25d
function function_8c880ef50ebc82b6( arena, aispawn, basetype, tiernum, nationality, respawncooldown )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( basetype ) )
    {
        basetype = "smg";
    }
    
    agent = undefined;
    spawnlocation = aispawn.origin;
    spawnlocation = getgroundposition( spawnlocation, 12 );
    
    if ( basetype == "jugg" )
    {
        aispawn.origin = spawnlocation;
        agent = br_bosses_mi8jugg::mi8jugg_spawn( aispawn, "gulag" );
        weapon = weapon::buildweapon( "iw9_sm_aviktor", [ "thermal01", "none", "none", "none", "silencer01_sm", "laserirsmg" ], "camo_none", "none" );
        agent agent_utils::overrideagentsettings( undefined, undefined, weapon );
    }
    else
    {
        aitype = ai_mp_controller::function_f7aef6871cda828( basetype, tiernum, nationality );
        agent = ai_mp_controller::ai_mp_requestspawnagent( aitype, spawnlocation, aispawn.angles, "absolute", "gulag", undefined, undefined, undefined, undefined, undefined, 1 );
    }
    
    if ( !isdefined( agent ) )
    {
        function_4d32ed524d5b0893( "Agent failed to spawn in arena: " + arena.gulagindex );
        return;
    }
    
    agent.baseaccuracy = getdvarfloat( @"hash_3ec2e682b32338fe", 0.6 );
    agent.accuracy = agent.baseaccuracy;
    agent.maxsightdistsqrd = getdvarfloat( @"hash_1f2b18095c07fd11", 31360000 );
    
    if ( isagent( agent ) )
    {
        agent br_ai_gulag::function_a0664a9707714ecd( arena );
        agent.respawncooldown = respawncooldown;
        
        if ( isdefined( arena.pathstructs ) && arena.pathstructs.size > 0 )
        {
            pathstruct = arena.pathstructs[ randomint( arena.pathstructs.size ) ];
            startindex = function_604b993e8ddf4ade( spawnlocation, pathstruct.path );
            level thread ai_behavior::behavior_patrol( [ agent ], pathstruct, startindex );
            return;
        }
        
        level thread ai_behavior::behavior_GuardStationary( agent );
    }
}

// Namespace br_ai_gulag_variations
// Params 1
// Checksum 0xa8b3eaeb, Offset: 0x1739
// Size: 0xe, Type: bool
function function_a969ce0dc8ea5ef0( arena )
{
    return true;
}

// Namespace br_ai_gulag_variations
// Params 1
// Checksum 0x15a7cb, Offset: 0x1750
// Size: 0x16c
function function_911b6ffcb845a238( arena )
{
    if ( !isdefined( level.bosses ) && namespace_a974e4dd85555bc2::function_64591ecc14010927( arena ) && level.var_56c3cc3dc37f1728.patroltier == 4 )
    {
        level.bosses = [];
        br_bosses_mi8jugg::mi8jugg_register();
        
        foreach ( boss in level.bosses )
        {
            if ( getdvarint( hashcat( @"scr_", boss.name, "_disabled" ), 0 ) > 0 )
            {
                boss.disabled = 1;
                continue;
            }
            
            if ( isdefined( boss.initfunc ) )
            {
                [[ boss.initfunc ]]( boss );
            }
        }
    }
    
    aispawn = undefined;
    
    if ( getdvarint( @"br_ai_gulag_jailer_intro", 0 ) )
    {
        aispawn = arena.var_4e3e5e6103cb2a74;
    }
    else
    {
        [ aispawn ] = arrayrandomize( arena.ai_structs );
    }
    
    thread function_11af515ec084ceca( arena, aispawn );
}

// Namespace br_ai_gulag_variations
// Params 1
// Checksum 0x3da8f8be, Offset: 0x18c4
// Size: 0xe7
function function_4102fae9d117c220( jailer )
{
    result = [ -1, -1, -1, -1 ];
    index = 0;
    
    foreach ( player in jailer.gulagarena.arenaplayers )
    {
        if ( index == 4 )
        {
            break;
        }
        
        if ( isdefined( player ) )
        {
            result[ index ] = float( player getentitynumber() );
            index++;
        }
    }
    
    return result;
}

// Namespace br_ai_gulag_variations
// Params 2
// Checksum 0x3153a86a, Offset: 0x19b4
// Size: 0x777
function function_11af515ec084ceca( arena, aispawn )
{
    level endon( #"game_ended" );
    arena endon( #"matchended" );
    arena endon( #"fight_over" );
    spawnlocation = aispawn.origin;
    spawnlocation = getgroundposition( spawnlocation, 12 );
    aispawn.origin = spawnlocation;
    tiernum = level.var_56c3cc3dc37f1728.patroltier;
    jailerdelaytime = getdvarfloat( @"hash_28fc993237fc1087", 30 );
    var_8cc38e7658d9cf7 = max( 0, getdvarfloat( @"hash_c75fae28e8a2210e", 6 ) );
    delaytime = max( 0, jailerdelaytime - var_8cc38e7658d9cf7 );
    wait delaytime;
    
    if ( namespace_a974e4dd85555bc2::function_64591ecc14010927( arena ) && isarray( arena.arenaplayers ) )
    {
        foreach ( player in arena.arenaplayers )
        {
            player namespace_a974e4dd85555bc2::function_61271384688bce9d( "gulag_jailer_incoming", arena );
        }
    }
    
    wait var_8cc38e7658d9cf7;
    
    if ( tiernum == 4 )
    {
        agent = br_bosses_mi8jugg::mi8jugg_spawn( aispawn, "gulag" );
    }
    else
    {
        basetype = "shotgun";
        aitype = ai_mp_controller::function_f7aef6871cda828( basetype, tiernum );
        agent = ai_mp_controller::ai_mp_requestspawnagent( aitype, spawnlocation, aispawn.angles, "absolute", "gulag", undefined, undefined, undefined, undefined, undefined, 1 );
    }
    
    if ( !isdefined( agent ) )
    {
        function_4d32ed524d5b0893( "Agent failed to spawn in arena: " + arena.gulagindex );
        return;
    }
    
    weapon = undefined;
    weaponchoice = getdvar( @"br_ai_gulag_jailer_weapon", "" );
    
    switch ( weaponchoice )
    {
        case #"hash_900cb96c552c5e8e":
            weapon = weapon::buildweapon( "iw9_sm_aviktor", [ "thermal01", "none", "none", "none", "silencer01_sm", "none" ], "camo_none", "none" );
            break;
        case #"hash_40a94c5d9e4e265b":
            weapon = level.defaultfist;
            break;
        case #"hash_23209741b93850b5":
            weapon = weapon::buildweapon( "iw9_sh_charlie725_mp", [ "none", "none", "none", "none", "none", "none" ], "camo_none", "none" );
            break;
        default:
            break;
    }
    
    body = undefined;
    head = undefined;
    helmet = undefined;
    
    if ( tiernum < 4 )
    {
        body = "body_sp_opforce_shadow_company_elite_3_1";
        head = "head_sp_opforce_shadow_company_elite_3_1";
        helmet = getdvarint( @"br_ai_gulag_jailer_helmet", 10 );
    }
    else
    {
        helmet = getdvarint( @"br_ai_gulag_jailer_helmet", 1500 );
    }
    
    armor = getdvarint( @"br_ai_gulag_jailer_armor", 3400 );
    agent mp_agent::set_agent_health( getdvarint( @"br_ai_gulag_jailer_health", 100 ) );
    grenade_type = getdvarint( @"hash_617969f5d3fa5bb5", "frag_grenade_mp" );
    grenadeammo = getdvarint( @"br_ai_gulag_jailer_grenadeammo", 0 );
    agent agent_utils::overrideagentsettings( body, head, weapon, grenade_type, grenadeammo, armor, helmet, 1 );
    agent.sweepscalar = getdvarfloat( @"hash_727c76a293d85e6f", 4 );
    agent.maxsightdistsqrd = getdvarfloat( @"hash_fa26f07d026720be", 12250000 );
    agent.var_9e34089b647899c5 = getdvarfloat( @"hash_57f1a5678a01b7eb", 12250000 );
    agent.var_48606c36b3a4ea54 = getdvarint( @"hash_8b0d1bd49a4054b5", 0 );
    agent setcanusecover( 0 );
    agent.goalradius = getdvarint( @"br_ai_gulag_jailer_goalradius", 3200 );
    agent.script_goalradius = agent.goalradius;
    agent.ballowexecutions = getdvarint( @"hash_52d3883d39c08659", 1 );
    agent.minpaindamage = getdvarint( @"hash_289b813a732c2672", 450 );
    agent.var_c21cefdb0d231840 = getdvarint( @"hash_61ec5d7484718bc9", 500 );
    agent.var_1db1f2ef9c7f9036 = getdvarint( @"hash_a0b1e91f87faf171", 768 );
    agent.var_aaf12cbad4692c1b = getdvarint( @"hash_f2334aa4fa920550", 512 );
    agent.var_47627bac27bc94ff = getdvarint( @"hash_95a0623d74d35620", 128 );
    agent.var_e5d5b423587e876 = getdvarint( @"hash_cb0a08edcac4931d", 128 );
    agent.var_26823048bfe293fe = getdvarint( @"hash_34a27361609efe2f", 1000 );
    agent.var_26a62248c00aefec = getdvarint( @"hash_347f81616078d541", 500 );
    var_91ef7fa4f73e51b3 = 8;
    activetime = getdvarfloat( @"hash_8be34599dfa102b8", 30 ) + getdvarfloat( @"scr_br_fc_overtime", 30 ) - getdvarfloat( @"hash_28fc993237fc1087", 25 ) + var_91ef7fa4f73e51b3;
    function_adfcc6fee9cef36f( &function_4102fae9d117c220 );
    agent registerjailer( "default", activetime );
    agent.gulagjailer = 1;
    agent.gulagarena = arena;
    agent.var_f69f85c46fadaebf = agent.armorhealth + agent.maxhealth;
    agent.sweeptime = getdvarint( @"hash_2e956fd207e71d5a", 5 );
    level.var_f72c8182909c4d = &function_8f6491802bd50b43;
    agent function_8833ce3ea79b6c10();
    jailerdeaths = [];
    jailerdeaths[ jailerdeaths.size ] = "wz_gulag_jailer_death_a";
    jailerdeaths[ jailerdeaths.size ] = "wz_gulag_jailer_death_b";
    jailerdeaths[ jailerdeaths.size ] = "wz_gulag_jailer_death_c";
    jailerdeaths[ jailerdeaths.size ] = "wz_gulag_jailer_death_d";
    agent.deathstate = "animscripted";
    agent.deathalias = utility::array_random( jailerdeaths );
    
    if ( isagent( agent ) )
    {
        agent br_twotwo_gulag::function_be39d853131d1b85( arena );
        
        if ( level.var_56c3cc3dc37f1728.var_b5e323037b34ba3 )
        {
            agent.nocorpse = 1;
        }
        
        arena notify( #"jailer_spawned" );
        agent.ignoreall = 1;
        agent playloopsound( "mus_jugg_01_hp" );
        agent setclothtype( #"nylon" );
        agent setgeartype( #"scubagr" );
        agent function_95acf9b1527598e7( arena );
        level thread function_8a07e6a1ab3735b6( agent, arena );
        agent.ignoreall = 0;
    }
}

// Namespace br_ai_gulag_variations
// Params 1
// Checksum 0x672f1c72, Offset: 0x2133
// Size: 0xc
function function_10e6b1c8c8dd6edc( arena )
{
    
}

// Namespace br_ai_gulag_variations
// Params 0
// Checksum 0x3afdd099, Offset: 0x2147
// Size: 0xc3
function function_8833ce3ea79b6c10()
{
    if ( !getdvarint( @"hash_3019c51aaa25b462", 0 ) )
    {
        return;
    }
    
    arena = self.gulagarena;
    gulagplayers = arraycombine( arena.arenaplayers, arena.jailedplayers );
    
    foreach ( player in gulagplayers )
    {
        player setclientomnvar( "ui_br_twotwo_gulag_jailer_health", 100 );
    }
}

// Namespace br_ai_gulag_variations
// Params 1
// Checksum 0xf0887c3d, Offset: 0x2212
// Size: 0x11f
function function_8f6491802bd50b43( idamage )
{
    if ( isdefined( self.var_f69f85c46fadaebf ) && idamage >= 0 && getdvarint( @"hash_3019c51aaa25b462", 0 ) )
    {
        var_b7c0e854f48ff0c = self.health + self.armorhealth;
        var_74aa63b08970b86 = int( ceil( var_b7c0e854f48ff0c / self.var_f69f85c46fadaebf * 100 ) );
        arena = self.gulagarena;
        gulagplayers = arraycombine( arena.arenaplayers, arena.jailedplayers );
        
        foreach ( player in gulagplayers )
        {
            player setclientomnvar( "ui_br_twotwo_gulag_jailer_health", var_74aa63b08970b86 );
        }
    }
}

// Namespace br_ai_gulag_variations
// Params 1
// Checksum 0xb20d4871, Offset: 0x2339
// Size: 0x324
function function_95acf9b1527598e7( arena )
{
    jailerentrances = [];
    jailerentrances[ jailerentrances.size ] = "wz_gulag_jailer_enter_a";
    jailerentrances[ jailerentrances.size ] = "wz_gulag_jailer_enter_b";
    jailerentrances[ jailerentrances.size ] = "wz_gulag_jailer_enter_c";
    jailerentrances[ jailerentrances.size ] = "wz_gulag_jailer_enter_d";
    var_369c2e48b2f8e208 = [];
    var_369c2e48b2f8e208[ var_369c2e48b2f8e208.size ] = "wz_gulag_jailer_enter_doors_a";
    var_369c2e48b2f8e208[ var_369c2e48b2f8e208.size ] = "wz_gulag_jailer_enter_doors_b";
    var_369c2e48b2f8e208[ var_369c2e48b2f8e208.size ] = "wz_gulag_jailer_enter_doors_c";
    var_369c2e48b2f8e208[ var_369c2e48b2f8e208.size ] = "wz_gulag_jailer_enter_doors_d";
    var_959ae214d55006a5 = randomint( 4 );
    self.animationarchetype = "juggernaut";
    startpos = arena.var_4e3e5e6103cb2a74.origin;
    startangles = arena.var_4e3e5e6103cb2a74.angles;
    animindex = asm::asm_lookupanimfromalias( "animscripted", jailerentrances[ var_959ae214d55006a5 ] );
    xanim = asm::asm_getxanim( "animscripted", animindex );
    animstartpos = getstartorigin( startpos, startangles, xanim );
    animstartangles = getstartangles( startpos, startangles, xanim );
    self forceteleport( animstartpos, animstartangles );
    asm_bb::bb_setanimscripted();
    self asmsetstate( self.asmname, "animscripted" );
    self dontinterpolate();
    
    foreach ( player in arena.arenaplayers )
    {
        player utility::delaycall( 0.1, &setplayermusicstate, "mx_mp_br_gulag_juggernaut" );
        player utility::delaythread( 2.3, &hud_message::showsplash, "br_twotwo_gulag_jailer_spawn" );
        
        if ( level.var_56c3cc3dc37f1728.var_55e4d43596a9b8c9 )
        {
            player utility::delaythread( 3.5, &namespace_a974e4dd85555bc2::function_61271384688bce9d, "gulag_jailer_arrived", arena );
        }
    }
    
    arena.var_f88eeac59b4b55d8 scriptmodelplayanimdeltamotionfrompos( var_369c2e48b2f8e208[ var_959ae214d55006a5 ], arena.var_4e3e5e6103cb2a74.origin, arena.var_4e3e5e6103cb2a74.angles );
    self aisetanim( "animscripted", animindex );
    self animmode( "noclip" );
    anim_length = getanimlength( xanim );
    wait anim_length;
    thread function_597adf6957e85890( arena );
    wellanim = function_d70c630c58948ce1( arena );
    animindex = asm::asm_lookupanimfromalias( "animscripted", "wz_gulag_jailer_well_walk_forward" );
    xanim = asm::asm_getxanim( "animscripted", animindex );
    animstartpos = getstartorigin( startpos, startangles, xanim );
    animstartangles = getstartangles( startpos, startangles, xanim );
    self forceteleport( animstartpos + ( 0, 0, 8 ), animstartangles );
    self dontinterpolate();
    self aisetanim( "animscripted", animindex );
    self animmode( "noclip" );
    anim_length = getanimlength( xanim );
    wait anim_length;
    asm_bb::bb_clearanimscripted();
}

// Namespace br_ai_gulag_variations
// Params 1
// Checksum 0x3fad7e99, Offset: 0x2665
// Size: 0x23c
function function_597adf6957e85890( arena )
{
    var_92f18e9194cfd75d = 160;
    var_760eed8a102c2f28 = 10;
    var_f2c7164799a69f48 = 75;
    impulse_scaler = 600;
    center_impulse_scaler = 1100;
    var_87d6d93c1d9c27e4 = [];
    
    foreach ( player in arena.arenaplayers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        var_e61907eb40198968 = distance2d( player.origin, arena.var_4e3e5e6103cb2a74.origin );
        var_7f34207fd5e8f028 = abs( player.origin[ 2 ] - arena.var_4e3e5e6103cb2a74.origin[ 2 ] );
        
        if ( var_e61907eb40198968 < var_92f18e9194cfd75d && var_7f34207fd5e8f028 <= var_760eed8a102c2f28 )
        {
            var_87d6d93c1d9c27e4[ var_87d6d93c1d9c27e4.size ] = player;
        }
    }
    
    foreach ( player in var_87d6d93c1d9c27e4 )
    {
        impulsevec = undefined;
        var_e61907eb40198968 = distance2d( player.origin, arena.var_4e3e5e6103cb2a74.origin );
        impulsevec = vectornormalize( player.origin - arena.var_4e3e5e6103cb2a74.origin ) * ( var_e61907eb40198968 < var_f2c7164799a69f48 ? center_impulse_scaler : impulse_scaler );
        player setvelocity( impulsevec );
    }
    
    shellshock_utility_cpmp::shellshock_artilleryearthquake( arena.var_4e3e5e6103cb2a74.origin, undefined, 3.5, var_92f18e9194cfd75d );
}

// Namespace br_ai_gulag_variations
// Params 1
// Checksum 0x6b5c14c1, Offset: 0x28a9
// Size: 0xc
function function_d70c630c58948ce1( arena )
{
    
}

// Namespace br_ai_gulag_variations
// Params 2
// Checksum 0x206f23c2, Offset: 0x28bd
// Size: 0x66
function function_8a07e6a1ab3735b6( agent, arena )
{
    agent endon( #"death" );
    ai_behavior::function_1035cc9dfcff38d0();
    wait 1;
    agent.meleechargedistvsplayer = 100;
    agent.meleechargedist = 100;
    
    if ( getdvarint( @"hash_8bf4874031af778a", 0 ) )
    {
        function_f4f36c9a461893f7( agent, arena );
    }
}

// Namespace br_ai_gulag_variations
// Params 2
// Checksum 0xf8057f82, Offset: 0x292b
// Size: 0x291
function function_f153a229b69dc8ff( agent, arena )
{
    var_8b22f0caa8139cd = getdvarint( @"hash_8d0b6a1b71c97774", 100 );
    cooldowntimesweep = getdvarint( @"hash_2be23112df934cb6", 8 );
    sweepdebug = getdvarint( @"hash_f31e28c193ae06a", 0 );
    var_75979d9fbbdafe39 = getdvarint( @"hash_47d84e982292419c", 1 );
    
    while ( true )
    {
        while ( !agent.baimedataimtarget )
        {
            waitframe();
        }
        
        if ( var_75979d9fbbdafe39 )
        {
            agent thread cap::cap_start( "cap_jugg_sweep", "cap_jugg_sweep" );
            agent waittill( #"cap_exit_completed" );
            continue;
        }
        
        shootfrompos = agent getshootfrompos();
        targetposstruct = agent getshootpos( shootfrompos );
        initialtargetpos = undefined;
        
        if ( isdefined( targetposstruct ) )
        {
            initialtargetpos = targetposstruct.shootpos;
        }
        else
        {
            initialtargetpos = agent lastknownpos( agent.enemy );
        }
        
        forwardvec = vectornormalize( initialtargetpos - shootfrompos );
        agent.dontmelee = 1;
        agent setbtgoalpos( 3, agent.origin );
        fakegoalorigin = forwardvec * 100 + shootfrompos;
        fakegoalent = utility::spawn_script_origin( fakegoalorigin );
        
        if ( sweepdebug )
        {
            thread debug::drawsphere( fakegoalent.origin, 25, 5, ( 0, 1, 0 ) );
        }
        
        level thread function_4e8ec01071ec7ed3( fakegoalent, agent );
        agent setentitytarget( fakegoalent );
        waitframe();
        forwardangles = vectortoangles( forwardvec );
        forwardyaw = forwardangles[ 1 ] + var_8b22f0caa8139cd;
        translationvec = anglestoforward( ( 0, forwardyaw, 0 ) ) * distance2d( fakegoalorigin, shootfrompos );
        finaltargetpos = fakegoalorigin + translationvec;
        
        if ( sweepdebug )
        {
            thread debug::drawsphere( finaltargetpos, 25, 5, ( 0, 1, 1 ) );
        }
        
        fakegoalent moveto( finaltargetpos, agent.sweeptime );
        wait agent.sweeptime;
        agent forcereloading();
        agent.bulletsinclip = 0;
        agent.dontevershoot = 1;
        agent clearentitytarget();
        fakegoalent delete();
        agent setgoalpos( agent.origin, 10000 );
        agent.dontmelee = 0;
        wait cooldowntimesweep;
        agent.dontevershoot = 0;
    }
}

// Namespace br_ai_gulag_variations
// Params 2
// Checksum 0x78bc0496, Offset: 0x2bc4
// Size: 0x37
function function_4e8ec01071ec7ed3( fakegoalent, agent )
{
    fakegoalent endon( #"death" );
    agent waittill( #"death" );
    fakegoalent delete();
}

// Namespace br_ai_gulag_variations
// Params 2
// Checksum 0xb1e05f0e, Offset: 0x2c03
// Size: 0x319
function function_f4f36c9a461893f7( agent, arena )
{
    var_149f3dc6f868c3d8 = getdvarfloat( @"hash_15ec5f864d15e41d", 0.5 );
    var_1246f25767b6fe1b = getdvarfloat( @"hash_e54d8527ee6a429a", 0.4 );
    var_f6c53f7d652f5f44 = getdvarfloat( @"hash_1a17d98123e7f319", 0.1 );
    thinkinginterval = getdvarfloat( @"hash_ecaa9bfa3f51c620", 10 );
    
    while ( true )
    {
        utilityscores = [];
        var_f4120c3b2f8da039 = 0;
        var_8f60ee073098ebe7 = 0;
        var_f31916cc6d41b253 = [];
        currentaliveplayers = [];
        
        foreach ( player in arena.arenaplayers )
        {
            if ( isalive( player ) )
            {
                var_ead1f259a606fadb = arraycontains( arena.var_efd329dcea50284d, player );
                playerid = player getentitynumber();
                currentaliveplayers[ currentaliveplayers.size ] = player;
                
                if ( var_ead1f259a606fadb )
                {
                    var_f4120c3b2f8da039++;
                }
                else
                {
                    var_f4120c3b2f8da039--;
                }
                
                if ( isdefined( player.var_78480a5a6128b940 ) )
                {
                    if ( !isdefined( player.var_a281a519e718fddc ) )
                    {
                        player.var_a281a519e718fddc = 0;
                    }
                    
                    var_f31916cc6d41b253[ playerid ] = player.var_78480a5a6128b940 - player.var_a281a519e718fddc;
                    var_8f60ee073098ebe7 += var_f31916cc6d41b253[ playerid ];
                    player.var_a281a519e718fddc = player.var_78480a5a6128b940;
                }
            }
        }
        
        currentaliveplayers = sortbydistance( currentaliveplayers, agent.origin );
        var_1b428e97644cb928 = -1;
        var_bcdfa7811ffdcd45 = undefined;
        
        for ( index = 0; index < currentaliveplayers.size ; index++ )
        {
            player = currentaliveplayers[ index ];
            playerid = player getentitynumber();
            utilityscores[ playerid ] = 0;
            
            if ( !arena.var_e55af00897688334 )
            {
                var_ead1f259a606fadb = arraycontains( arena.var_efd329dcea50284d, player );
                
                if ( var_ead1f259a606fadb && var_f4120c3b2f8da039 > 0 )
                {
                    utilityscores[ playerid ] += var_149f3dc6f868c3d8;
                }
                else if ( !var_ead1f259a606fadb && var_f4120c3b2f8da039 < 0 )
                {
                    utilityscores[ playerid ] += var_149f3dc6f868c3d8;
                }
            }
            
            if ( isdefined( var_f31916cc6d41b253[ playerid ] ) && var_8f60ee073098ebe7 > 0 )
            {
                var_9a1d07d87066f4a9 = var_f31916cc6d41b253[ playerid ] / var_8f60ee073098ebe7 * var_1246f25767b6fe1b;
                utilityscores[ playerid ] += var_9a1d07d87066f4a9;
            }
            
            var_9f2ef86d493528a3 = ( currentaliveplayers.size - index ) / currentaliveplayers.size * var_f6c53f7d652f5f44;
            utilityscores[ playerid ] += var_9f2ef86d493528a3;
            
            if ( utilityscores[ playerid ] > var_1b428e97644cb928 )
            {
                var_1b428e97644cb928 = utilityscores[ playerid ];
                var_bcdfa7811ffdcd45 = player;
            }
        }
        
        if ( isdefined( var_bcdfa7811ffdcd45 ) )
        {
            agent.favoriteenemy = var_bcdfa7811ffdcd45;
            agent setgoalentity( var_bcdfa7811ffdcd45 );
        }
        
        wait thinkinginterval;
    }
}

// Namespace br_ai_gulag_variations
// Params 2
// Checksum 0x6f62e7c3, Offset: 0x2f24
// Size: 0xda
function function_604b993e8ddf4ade( origin, path )
{
    if ( !isdefined( path ) || path.size < 1 )
    {
        return;
    }
    
    index = undefined;
    dist = undefined;
    
    foreach ( i, node in path )
    {
        newdist = distancesquared( node.origin, origin );
        
        if ( !isdefined( dist ) || newdist < dist )
        {
            dist = newdist;
            index = i;
        }
    }
    
    return index;
}

// Namespace br_ai_gulag_variations
// Params 3
// Checksum 0x99083094, Offset: 0x3007
// Size: 0x6a
function function_b9dd411bdf61a609( arena, aispawn, basetype )
{
    level endon( #"game_ended" );
    respawncooldown = self.respawncooldown;
    
    if ( isdefined( respawncooldown ) )
    {
        wait respawncooldown;
    }
    
    level thread function_8c880ef50ebc82b6( arena, aispawn, basetype, level.var_56c3cc3dc37f1728.patroltier, undefined, respawncooldown );
}

