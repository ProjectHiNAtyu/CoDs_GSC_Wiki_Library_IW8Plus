// script_26a390d7e02d3f8d  (hash_26a390d7e02d3f8d.gscc) (size: 17852 Bytes / 0x45bc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc2958686 (3264579206)
// size ...... 17852 (0x45bc)
// includes .. 23  (offset: 0x41d4)
// strings ... 55  (offset: 0x428c)
// dev strs .. 0   (offset: 0x45bc)
// exports ... 27  (offset: 0x2d48)
// cseg ...... 0x477 + 0x28d1 (0x2d48)
// imports ... 134 (offset: 0x3180)
// animtree1 . 0   (offset: 0x45bc)
// animtree2 . 0   (offset: 0x45bc)
#using scripts\anim\battlechatter;
#using scripts\asm\asm;
#using scripts\asm\cap;
#using scripts\common\cap;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\agents\common_agent_damage;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\br\gametypes\br_analytics;
#using scripts\mp\br\gametypes\br_gulag;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_spawnrespawn;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\pickups_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\damagefeedback;
#using scripts\mp\hud_message;
#using scripts\mp\pickups_scriptable;

#namespace namespace_13234c7eaab1a112;

// Namespace namespace_13234c7eaab1a112
// Params 0
// Checksum 0x4d1abf72, Offset: 0x495
// Size: 0x3d4
function function_3d61b8ff8e6c7694()
{
    if ( !getdvarint( @"hash_4a544835c8ae64f3", 0 ) )
    {
        return;
    }
    
    if ( !level.usegulag )
    {
        return;
    }
    
    var_8c9e2ca59f15de8d = spawnstruct();
    var_8c9e2ca59f15de8d.primaryweapon = getdvar( @"hash_c15ab5c0d62f602c", "ar" );
    var_8c9e2ca59f15de8d.tier = getdvarint( @"hash_d3274d9a629743fe", 1 );
    var_8c9e2ca59f15de8d.totalhealth = getdvarint( @"hash_e5060acbd5afa93e", 300 );
    var_8c9e2ca59f15de8d.damagedefault = getdvarint( @"hash_c010d711979f5114", 15 );
    var_8c9e2ca59f15de8d.damagestunned = getdvarint( @"hash_373c93b98e7d3c92", 30 );
    var_8c9e2ca59f15de8d.thresholdstun = getdvarint( @"hash_2ca665603bf97065", 1 );
    var_8c9e2ca59f15de8d.var_9d5cc290a191b9b8 = getdvarint( @"hash_9cf27803596fff40", 1 );
    var_8c9e2ca59f15de8d.var_907b1fe942a431b5 = getdvarint( @"hash_dafa44a595367d1d", 2 );
    var_8c9e2ca59f15de8d.var_a174cd187f9e70de = getdvarfloat( @"hash_65e3ecba47524376", 2 );
    var_8c9e2ca59f15de8d.var_a151df187f7850bc = getdvarfloat( @"hash_6606deba47786c64", 2.5 );
    var_8c9e2ca59f15de8d.spawnmin = getdvarint( @"hash_a3586cc38781ff97", 3 );
    var_8c9e2ca59f15de8d.spawnmax = getdvarint( @"hash_a37b7ac387a86619", 4 );
    level.var_8c9e2ca59f15de8d = var_8c9e2ca59f15de8d;
    
    while ( !isdefined( level.struct_class_names ) )
    {
        waitframe();
    }
    
    foreach ( arena in level.gulag.arenas )
    {
        arena.var_c9e56ab2f8740201 = [];
        arenastructs = utility::getstructarray( arena.target, "targetname" );
        
        foreach ( arenastruct in arenastructs )
        {
            if ( arenastruct.script_noteworthy == "gulag_twotwo_catwalk_ai_spawn" )
            {
                if ( isdefined( arenastruct.target ) )
                {
                    arenastruct.patrolstart = utility::getstruct( arenastruct.target, "targetname" );
                    
                    if ( isdefined( arenastruct.patrolstart ) )
                    {
                        arenastruct.patrolpath = ai_mp_controller::function_ad7994ce0f8a6d54( arenastruct.patrolstart );
                    }
                }
                
                arena.var_c9e56ab2f8740201[ arena.var_c9e56ab2f8740201.size ] = arenastruct;
            }
        }
    }
    
    level waittill( #"prematch_done" );
    scriptable::scriptable_addusedcallbackbypart( "loot_key_spectator_gulag", &gulag_gulagbreak );
    function_887c0549fe3566f8();
    
    foreach ( arena in level.gulag.arenas )
    {
        function_cae662342b5ff714( arena );
    }
}

// Namespace namespace_13234c7eaab1a112
// Params 0
// Checksum 0x8c4ed860, Offset: 0x871
// Size: 0x1c
function function_887c0549fe3566f8()
{
    category = "gulag_catwalk";
    ai_mp_controller::aibudget_registercategory( category );
}

// Namespace namespace_13234c7eaab1a112
// Params 1
// Checksum 0x3157712, Offset: 0x895
// Size: 0x128
function function_cae662342b5ff714( arena )
{
    if ( isdefined( arena.secondchancekey ) )
    {
        arena.secondchancekey pickups::deletescriptableinstance( 1 );
    }
    
    tospawn = randomintrange( level.var_8c9e2ca59f15de8d.spawnmin, level.var_8c9e2ca59f15de8d.spawnmax + 1 );
    arena.gulagbreakparticipants = [];
    arena.var_78a207647831d03d = [];
    
    if ( !isdefined( arena.riotsstarted ) )
    {
        arena.riotsstarted = 0;
    }
    
    if ( !isdefined( arena.riotscompleted ) )
    {
        arena.riotscompleted = 0;
    }
    
    arena.var_c9e56ab2f8740201 = arrayrandomize( arena.var_c9e56ab2f8740201 );
    
    for ( i = 0; i < tospawn ; i++ )
    {
        function_9063f180444d0b61( arena, arena.var_c9e56ab2f8740201[ i ], level.var_8c9e2ca59f15de8d.primaryweapon, level.var_8c9e2ca59f15de8d.tier );
    }
}

// Namespace namespace_13234c7eaab1a112
// Params 5
// Checksum 0x2f7c3e77, Offset: 0x9c5
// Size: 0x35a
function function_9063f180444d0b61( arena, aispawn, basetype, tiernum, nationality )
{
    aitype = "enemy_mp_baton_base";
    
    if ( getdvarint( @"hash_13bdd9641f2e3308", 0 ) )
    {
        if ( !isdefined( basetype ) )
        {
            basetype = "smg";
        }
        
        aitype = ai_mp_controller::function_f7aef6871cda828( basetype, tiernum, nationality );
    }
    
    spawnlocation = aispawn.origin;
    
    if ( !getdvarint( @"hash_b3d7a9483362813e", 0 ) )
    {
        spawnlocation = getclosestpointonnavmesh( aispawn.origin + ( 0, 0, 30 ) );
    }
    
    agent = ai_mp_controller::ai_mp_requestspawnagent( aitype, spawnlocation, aispawn.angles, "absolute", "gulag_catwalk", undefined, undefined, undefined, undefined, undefined, 1, undefined, 0 );
    
    if ( isagent( agent ) )
    {
        agent function_d4505ef9413cb117( arena );
        agent.arena = arena;
        agent.callbackdamaged = &function_21fdd17333f0f170;
        agent.fnshouldplaypainanim = &function_adbc04956cf34302;
        agent.handledamagefeedback = &gulag_handledamagefeedback;
        agent.health = level.var_8c9e2ca59f15de8d.totalhealth;
        agent.maxhealth = level.var_8c9e2ca59f15de8d.totalhealth;
        agent.meleechargedistvsplayer = 120;
        agent.pathenemyfightdist = 0;
        agent.var_31c747f020f83f04 = 1;
        agent.var_297e68441c7f36 = 90;
        agent.var_d9508f3fef648a65 = 70;
        agent.var_65e6ddbb9daa53a3 = 60;
        agent.var_5c9888255a843c4a = 0;
        agent.rockhits = 0;
        agent.var_24de888ecb99bad3 = 0;
        agent.var_9b859331e791ef3d = 0;
        agent.ballowexecutions = 0;
        agent.isattackingplayer = 0;
        agent.disablerunpain = 1;
        agent setsightconfigtemplateoverride( "default" );
        agent notify( #"hash_ff8e6ae7e0d93375" );
        agent attach( "misc_wm_baton", "tag_accessory_right" );
        
        if ( getdvarint( @"hash_b3d7a9483362813e", 0 ) )
        {
            agent forceteleport( spawnlocation, aispawn.angles );
            agent setgoalpos( agent.origin, 16 );
            agent clearpath();
            agent.fixednode = 1;
            agent thread ai_behavior::behavior_GuardStationary( agent, 1, agent.origin );
        }
        else if ( getdvarint( @"hash_1bed526f1079e5da", 0 ) && isdefined( aispawn.patrolpath ) )
        {
            agent.pacifist = 1;
            agent aisetdesiredspeed( 80 );
            level thread function_aa5e07e3d2121b1a( agent, aispawn.patrolpath, undefined, 64 );
            agent utility::demeanor_override( "patrol" );
            agent thread gulag_nearbyplayer();
            agent thread function_96f04216162c62eb();
            agent thread function_60cece02722fe130();
        }
        else
        {
            level thread ai_behavior::behavior_GuardStationary( agent );
        }
        
        agent setplayerghost( 1 );
        agent setperk( "specialty_gpsjammer", 1 );
        agent thread function_9a40e5aa821afa31( arena );
    }
}

// Namespace namespace_13234c7eaab1a112
// Params 1
// Checksum 0x620103b8, Offset: 0xd27
// Size: 0x41
function function_d4505ef9413cb117( arena )
{
    if ( !isdefined( arena.var_4ad956b47b5ebac7 ) )
    {
        arena.var_4ad956b47b5ebac7 = [];
    }
    
    arena.var_4ad956b47b5ebac7[ arena.var_4ad956b47b5ebac7.size ] = self;
}

// Namespace namespace_13234c7eaab1a112
// Params 1
// Checksum 0xf185438c, Offset: 0xd70
// Size: 0x1cc
function function_9a40e5aa821afa31( arena )
{
    level endon( #"game_ended" );
    self waittill( #"death", killer );
    
    if ( isdefined( arena.var_4ad956b47b5ebac7 ) )
    {
        arena.var_4ad956b47b5ebac7 = arrayremove( arena.var_4ad956b47b5ebac7, self );
        
        if ( isagent( self ) )
        {
            if ( isalive( self ) )
            {
                self.nocorpse = 1;
                self kill();
            }
        }
        
        if ( !isdefined( arena.var_cd7dbc60a7d04ff7 ) )
        {
            arena.var_cd7dbc60a7d04ff7 = [];
        }
        
        body = self getcorpseentity();
        
        if ( isdefined( body ) )
        {
            arena.var_cd7dbc60a7d04ff7[ arena.var_cd7dbc60a7d04ff7.size ] = body;
        }
        
        if ( isplayer( killer ) )
        {
            arena thread function_c37071ef1d5d7f35();
            
            if ( arena.var_4ad956b47b5ebac7.size <= 0 )
            {
                if ( !isdefined( arena.secondchancekey ) )
                {
                    dropstruct = pickups::function_f71dd588dc4f6288();
                    br_pickups::function_d5e08ebbca145e65( dropstruct, arena, killer );
                }
            }
        }
        
        if ( !isdefined( arena.riotinprogress ) )
        {
            arena.riotinprogress = 1;
            arena.riotsstarted += 1;
            
            foreach ( jailedplayer in arena.jailedplayers )
            {
                jailedplayer thread hud_message::showsplash( "br_gulag_prison_riot_in_progress" );
            }
        }
    }
}

// Namespace namespace_13234c7eaab1a112
// Params 6
// Checksum 0x129ac63, Offset: 0xf44
// Size: 0x1e4
function gulag_gulagbreak( instance, part, state, player, bautouse, usestring )
{
    level endon( #"game_ended" );
    arena = player.arena;
    
    if ( isdefined( arena.secondchancekey ) )
    {
        arena.secondchancekey pickups::deletescriptableinstance( 1 );
        player thread pickups::playerplaypickupanim();
    }
    
    if ( isdefined( player ) )
    {
        player points::doscoreevent( #"hash_7f475510f9f5698d" );
    }
    
    wait 1.17;
    
    foreach ( participant in arena.gulagbreakparticipants )
    {
        if ( isdefined( participant ) )
        {
            participant points::doscoreevent( #"hash_dd106359bca2b84" );
        }
    }
    
    torespawn = arraycombine( arena.jailedplayers, arena.arenaplayers );
    arena thread function_9b45c31648e60d65();
    arena thread function_fd716ae1eabcbeb();
    level notify( #"gulag_break" );
    
    if ( isdefined( arena ) )
    {
        if ( isdefined( arena.riotscompleted ) )
        {
            arena.riotscompleted += 1;
        }
    }
    
    br_analytics::function_97aaf58ee5152114( arena.id, level.br_circle.circleindex, 1, arena.gulagbreakparticipants.size, 0, torespawn.size );
    arena thread function_c084f7d72e782568( 5 );
}

// Namespace namespace_13234c7eaab1a112
// Params 0
// Checksum 0x705f158e, Offset: 0x1130
// Size: 0xff
function function_fd716ae1eabcbeb()
{
    level endon( #"game_ended" );
    self endon( #"fight_over" );
    self endon( #"matchended" );
    
    if ( self.fightover )
    {
        return;
    }
    
    foreach ( player in self.arenaplayers )
    {
        player setclientomnvar( "ui_br_gulag_lethal_delay", 0 );
        player val::reset_all( "watchLethalDelayPlayer" );
        
        if ( !isbot( player ) && isplayer( player ) )
        {
            player notifyonplayercommandremove( "lethal_attempt_gulag", "+frag" );
            player notifyonplayercommandremove( "lethal_attempt_gulag", "+smoke" );
        }
        
        player thread gulagbreak_playerrespawn( 1 );
    }
}

// Namespace namespace_13234c7eaab1a112
// Params 0
// Checksum 0x63850553, Offset: 0x1237
// Size: 0x9c
function function_9b45c31648e60d65()
{
    foreach ( player in self.jailedplayers )
    {
        if ( !player isinexecutionvictim() )
        {
            if ( player br_spawnrespawn::playeriscinematiclayeron() )
            {
                player stopcinematicforplayer( 1, 1 );
            }
            
            player thread gulagbreak_playerrespawn( 0 );
        }
    }
}

// Namespace namespace_13234c7eaab1a112
// Params 1
// Checksum 0xb14e0b96, Offset: 0x12db
// Size: 0xbb
function gulagbreak_playerrespawn( var_24f4b52d788a7b10 )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    isingulag = isalive( self ) && isdefined( level.gulag ) && !level.gulag.shutdown && br_public::isplayerinorgoingtogulag();
    
    if ( var_24f4b52d788a7b10 )
    {
        if ( br_spawnrespawn::playeriscinematiclayeron() )
        {
            br_spawnrespawn::function_24b79e9319c6f02f();
        }
    }
    
    player::_freezecontrols( 1, 0, "gulagBreak" );
    thread hud_message::showsplash( "br_gulagbreak_active" );
    
    if ( isingulag )
    {
        br_gulag::gulagvictory( self.arena, self, 1, 0, undefined, undefined, undefined, undefined, undefined, 1 );
        return;
    }
    
    thread br_gulag::playergulagautowin( "gulagbreak_playerRespawn", undefined, undefined, 1, 0, undefined, 1 );
}

// Namespace namespace_13234c7eaab1a112
// Params 13
// Checksum 0xa90aa6cd, Offset: 0x139e
// Size: 0x560
function function_21fdd17333f0f170( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon )
{
    if ( isdefined( eattacker ) && arraycontains( self.arena.arenaplayers, eattacker ) )
    {
        return;
    }
    
    if ( isdefined( self.arena ) && !arraycontains( self.arena.gulagbreakparticipants, eattacker ) )
    {
        self.arena.gulagbreakparticipants[ self.arena.gulagbreakparticipants.size ] = eattacker;
    }
    
    if ( isplayer( eattacker ) )
    {
        if ( isdefined( self.arena ) )
        {
            if ( isdefined( self.arena.var_78a207647831d03d ) && !arraycontains( self.arena.var_78a207647831d03d, self ) )
            {
                self.arena.var_78a207647831d03d[ self.arena.var_78a207647831d03d.size ] = self;
                
                if ( isdefined( self.arena.var_3afe96a52c3f4adc ) )
                {
                    self.arena.var_3afe96a52c3f4adc += 1;
                }
                else
                {
                    self.arena.var_3afe96a52c3f4adc = 1;
                }
            }
        }
    }
    
    alreadyflashed = isdefined( self.flashendtime );
    
    if ( smeansofdeath == "MOD_IMPACT" )
    {
        if ( distance2dsquared( einflictor.origin, eattacker.origin ) < 640000 )
        {
            if ( partname == #"hash_d0d8c4c438e2238a" || partname == #"j_head" )
            {
                /#
                    thread debug_utility::drawsphere( vpoint, 2, 1, ( 0, 1, 0 ) );
                #/
                
                idamage = level.var_8c9e2ca59f15de8d.damagestunned;
                self.var_5c9888255a843c4a++;
                
                if ( !alreadyflashed && isdefined( self.var_5c9888255a843c4a ) && self.var_5c9888255a843c4a >= level.var_8c9e2ca59f15de8d.thresholdstun )
                {
                    self.var_85101615c9005691 = eattacker;
                    function_796d2abd64f389c6( 1 );
                    stunduration = randomfloatrange( level.var_8c9e2ca59f15de8d.var_a174cd187f9e70de, level.var_8c9e2ca59f15de8d.var_a151df187f7850bc );
                    
                    if ( self.asmname != self.defaultasm )
                    {
                        asm_cap::cap_exit_pain();
                    }
                    
                    self shellshock( "flashbang_mp", stunduration );
                    
                    if ( !isdefined( self.flashendtime ) )
                    {
                        self.flashendtime = int( stunduration * 1000 );
                        asm::asm_setstate( "pain_flashed_transition" );
                    }
                    
                    self.var_5c9888255a843c4a = 0;
                    self.var_35cd6cd3e241bd5c = 1;
                    thread function_85c63b55c1e2ba1e();
                    battlechatter::function_b63bed8df8e4202a( "guard_damage_reaction_head", "react_multi", 0, 0, 3 );
                }
            }
            else
            {
                /#
                    thread debug_utility::drawsphere( vpoint, 2, 1, ( 1, 0, 0 ) );
                #/
                
                self.rockhits++;
                
                if ( self.rockhits >= level.var_8c9e2ca59f15de8d.var_9d5cc290a191b9b8 )
                {
                    self.rockhits = 0;
                    
                    if ( !self.var_9b859331e791ef3d )
                    {
                        self.shouldpain = 1;
                        jailerfacing = vectornormalize( anglestoforward( self.angles ) );
                        attackvector = vectornormalize( vdir );
                        dotproduct = vectordot( attackvector, jailerfacing );
                        
                        if ( dotproduct > 0.35 )
                        {
                            /#
                                thread debug_utility::drawsphere( vpoint, 4, 1, ( 1, 0, 0 ) );
                            #/
                            
                            battlechatter::function_b63bed8df8e4202a( "guard_damage_reaction_body", "react_unaware", 0, 0, 4 );
                        }
                        else
                        {
                            /#
                                thread debug_utility::drawsphere( vpoint, 4, 1, ( 0, 1, 0 ) );
                            #/
                            
                            battlechatter::function_b63bed8df8e4202a( "guard_damage_reaction_body", "react_aware", 0, 0, 4 );
                        }
                    }
                }
            }
            
            self.var_85101615c9005691 = eattacker;
            function_796d2abd64f389c6( 1 );
        }
    }
    else if ( smeansofdeath == "MOD_MELEE" )
    {
        if ( !self.var_9b859331e791ef3d )
        {
            if ( !alreadyflashed )
            {
                self.shouldpain = 1;
                battlechatter::function_b63bed8df8e4202a( "guard_melee_reaction", "react_aware", 0, 0, 3 );
            }
            
            self.var_85101615c9005691 = eattacker;
            function_796d2abd64f389c6( 1 );
        }
        
        if ( self.flashendtime > 0 )
        {
            idamage = level.var_8c9e2ca59f15de8d.damagestunned;
        }
        else
        {
            idamage = level.var_8c9e2ca59f15de8d.damagedefault;
        }
    }
    
    if ( idamage > self.health )
    {
        self detach( "misc_wm_baton", "tag_accessory_right" );
    }
    
    common_agent_damage::common_callbacksoldieragentdamaged( einflictor, eattacker, int( idamage ), idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon, 0 );
}

// Namespace namespace_13234c7eaab1a112
// Params 0
// Checksum 0x55de0f48, Offset: 0x1906
// Size: 0x29
function function_85c63b55c1e2ba1e()
{
    self endon( #"death" );
    
    while ( isdefined( self.flashendtime ) )
    {
        waitframe();
    }
    
    self.var_35cd6cd3e241bd5c = 0;
}

// Namespace namespace_13234c7eaab1a112
// Params 0
// Checksum 0x3b04fb14, Offset: 0x1937
// Size: 0xbe, Type: bool
function function_adbc04956cf34302()
{
    var_f3fbcee0b6d1c3a2 = 64;
    
    if ( self.shouldpain )
    {
        self.shouldpain = 0;
        return true;
    }
    
    if ( self.a.disablepain )
    {
        return false;
    }
    
    if ( self.allowpain == 0 )
    {
        return false;
    }
    
    if ( self.var_28a81dd923b494fe )
    {
        return false;
    }
    
    if ( isdefined( self.pathgoalpos ) && self pathdisttogoal( 1 ) < var_f3fbcee0b6d1c3a2 )
    {
        return false;
    }
    
    if ( isdefined( self.damageweapon ) )
    {
        basename = getweaponbasename( self.damageweapon );
        isfist = issubstr( basename, "fists" );
        
        if ( isfist )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace namespace_13234c7eaab1a112
// Params 0
// Checksum 0x51ee15ec, Offset: 0x19fe
// Size: 0xa3
function function_c37071ef1d5d7f35()
{
    level notify( #"hash_d140ffd52a2be6a0" );
    level endon( #"hash_d140ffd52a2be6a0" );
    level endon( #"gulag_break" );
    
    while ( true )
    {
        players = arrayremove( self.jailedplayers, self.arenaplayers );
        
        if ( players.size <= 0 )
        {
            thread function_c084f7d72e782568( 5 );
            br_analytics::function_97aaf58ee5152114( self.id, level.br_circle.circleindex, 0, self.gulagbreakparticipants.size, self.var_4ad956b47b5ebac7.size, 0 );
            break;
        }
        
        wait 1;
    }
}

// Namespace namespace_13234c7eaab1a112
// Params 1
// Checksum 0x33ffe365, Offset: 0x1aa9
// Size: 0x16a
function function_c084f7d72e782568( delay )
{
    level endon( #"game_ended" );
    
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    if ( isdefined( self.var_4ad956b47b5ebac7 ) )
    {
        foreach ( agent in self.var_4ad956b47b5ebac7 )
        {
            if ( isagent( agent ) )
            {
                if ( isalive( agent ) )
                {
                    agent.nocorpse = 1;
                    agent kill();
                }
                
                body = agent getcorpseentity();
                
                if ( isdefined( body ) )
                {
                    body delete();
                }
            }
        }
    }
    
    if ( isdefined( self.var_cd7dbc60a7d04ff7 ) )
    {
        foreach ( body in self.var_cd7dbc60a7d04ff7 )
        {
            if ( isdefined( body ) )
            {
                body delete();
            }
        }
    }
    
    function_cae662342b5ff714( self );
}

// Namespace namespace_13234c7eaab1a112
// Params 11
// Checksum 0xf7598af1, Offset: 0x1c1b
// Size: 0x200
function gulag_handledamagefeedback( einflictor, eattacker, victim, idamage, smeansofdeath, objweapon, shitloc, idflags, lightarmordamage, heavyarmordamage, iskillstreakweapon )
{
    if ( isdefined( eattacker ) && isdefined( eattacker.owner ) )
    {
        damager = eattacker.owner;
    }
    else
    {
        damager = eattacker;
    }
    
    if ( isdefined( damager ) && damager != victim && idamage + lightarmordamage + heavyarmordamage > 0 && shitloc != "shield" )
    {
        waskilled = !victim player::isreallyalive() || isagent( victim ) && idamage >= victim.health;
        headshot = damage_utility::isheadshot( shitloc, smeansofdeath, eattacker );
        suppressaudio = smeansofdeath == "MOD_MELEE";
        victimentnum = "" + victim getentitynumber();
        
        if ( waskilled && isdefined( victim.body ) )
        {
            var_7656f3d3e828e750 = victim.body getentitynumber();
        }
        else
        {
            var_7656f3d3e828e750 = victim getentitynumber();
        }
        
        if ( isdefined( self.var_f07309312a7687ee ) && [[ self.var_f07309312a7687ee ]]() )
        {
            damager damagefeedback::updatedamagefeedback( "hitarmorheavybreak", waskilled, headshot, undefined, suppressaudio, undefined, var_7656f3d3e828e750, undefined );
            return;
        }
        
        if ( idamage >= level.var_8c9e2ca59f15de8d.damagestunned )
        {
            damager damagefeedback::updatedamagefeedback( "standard", waskilled, headshot, undefined, suppressaudio, undefined, var_7656f3d3e828e750, undefined );
            return;
        }
        
        if ( idamage >= level.var_8c9e2ca59f15de8d.damagedefault )
        {
            damager damagefeedback::updatedamagefeedback( "hitarmorheavy", waskilled, headshot, undefined, suppressaudio, undefined, var_7656f3d3e828e750, undefined );
        }
    }
}

// Namespace namespace_13234c7eaab1a112
// Params 1
// Checksum 0x6f710173, Offset: 0x1e23
// Size: 0x1ac
function function_796d2abd64f389c6( aggressive )
{
    self.pacifist = !aggressive;
    self.var_ee914ad666562200 = !aggressive;
    
    if ( aggressive )
    {
        /#
            var_e18f729dde01a3d3 = getdvarint( @"hash_b511af5ef96f1167", 0 );
            
            if ( var_e18f729dde01a3d3 > 0 )
            {
                return;
            }
        #/
        
        self setlookatenabled( 1 );
        self.var_9b859331e791ef3d = 1;
        self.isattackingplayer = 1;
        self.goalradius = 8000;
        utility::demeanor_override( "cqb" );
        self.allowstrafe = 0;
        
        if ( isdefined( self.var_85101615c9005691 ) )
        {
            player = self.var_85101615c9005691;
            self.favoriteenemy = player;
            self setlookatentity( player );
            
            if ( !isdefined( player.var_75194777bc5f8323 ) )
            {
                player.var_75194777bc5f8323 = [];
            }
            
            player.var_75194777bc5f8323[ player.var_75194777bc5f8323.size ] = self;
        }
        
        return;
    }
    
    self.var_9b859331e791ef3d = 0;
    self.isattackingplayer = 0;
    self.favoriteenemy = undefined;
    self setlookatentity();
    self aisetdesiredspeed( 80 );
    self.goalradius = 64;
    utility::demeanor_override( "patrol" );
    player = self.var_85101615c9005691;
    
    if ( isdefined( player ) && isdefined( player.var_75194777bc5f8323 ) )
    {
        player.var_75194777bc5f8323 = arrayremove( player.var_75194777bc5f8323, self );
        self.var_85101615c9005691 = undefined;
    }
    
    if ( self.var_24de888ecb99bad3 >= level.var_8c9e2ca59f15de8d.var_907b1fe942a431b5 )
    {
        self.var_24de888ecb99bad3 = 0;
    }
}

// Namespace namespace_13234c7eaab1a112
// Params 0
// Checksum 0x184fdef4, Offset: 0x1fd7
// Size: 0x108
function function_96f04216162c62eb()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        if ( self.var_9b859331e791ef3d )
        {
            /#
                var_e18f729dde01a3d3 = getdvarint( @"hash_b511af5ef96f1167", 0 );
                
                if ( var_e18f729dde01a3d3 > 0 )
                {
                    function_796d2abd64f389c6( 0 );
                }
            #/
            
            var_822bfd7eace3cf70 = self.var_85101615c9005691;
            targetinlaststand = player::isinlaststand( var_822bfd7eace3cf70 );
            var_e6c4d6df894002fa = var_822bfd7eace3cf70 isinexecutionvictim() && !self isinexecutionattack();
            var_2c18350aa602df8b = arraycontains( self.arena.arenaplayers, var_822bfd7eace3cf70 );
            
            if ( !isalive( var_822bfd7eace3cf70 ) || targetinlaststand || var_e6c4d6df894002fa || var_2c18350aa602df8b || distance2dsquared( self.origin, var_822bfd7eace3cf70.origin ) > 640000 )
            {
                function_796d2abd64f389c6( 0 );
            }
        }
        
        wait 0.1;
    }
}

// Namespace namespace_13234c7eaab1a112
// Params 0
// Checksum 0xefc471a8, Offset: 0x20e7
// Size: 0xf6
function function_60cece02722fe130()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self.var_8fd87b6cb441b4da = 0;
    
    while ( true )
    {
        self waittill( #"object_whizby", org, player );
        
        if ( !self.var_9b859331e791ef3d && isdefined( player ) )
        {
            self.var_24de888ecb99bad3++;
            
            if ( !self.var_8fd87b6cb441b4da )
            {
                if ( self.var_24de888ecb99bad3 >= level.var_8c9e2ca59f15de8d.var_907b1fe942a431b5 && distance2dsquared( self.origin, player.origin ) < 640000 )
                {
                    self.var_85101615c9005691 = player;
                    function_796d2abd64f389c6( 1 );
                    function_f3f791121b151603( player );
                }
                else
                {
                    self.var_8fd87b6cb441b4da = 1;
                    thread function_3770969b6c521914( player );
                }
            }
        }
        
        wait 0.1;
    }
}

// Namespace namespace_13234c7eaab1a112
// Params 1
// Checksum 0x2ae26b0b, Offset: 0x21e5
// Size: 0x108
function function_3770969b6c521914( player )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    capname = "cap_jailer_warnoff";
    capanimset = "cap_jailer_warnoff";
    self setlookatenabled( 1 );
    self setlookatentity( player );
    self.var_ee11fe2277414a1a = player;
    self function_5fc6208ae437947b( player );
    cap::cap_start( capname, capanimset );
    self waittill( #"cap_exit_completed" );
    self function_5fc6208ae437947b();
    self setlookatentity();
    self.var_ee11fe2277414a1a = undefined;
    
    if ( self.var_24de888ecb99bad3 >= level.var_8c9e2ca59f15de8d.var_907b1fe942a431b5 && distance2dsquared( self.origin, player.origin ) < 640000 )
    {
        self.var_85101615c9005691 = player;
        self asmsetstate( self.asmname, "patrol_idle" );
        function_796d2abd64f389c6( 1 );
    }
    
    self.var_8fd87b6cb441b4da = 0;
}

// Namespace namespace_13234c7eaab1a112
// Params 1
// Checksum 0xe8ea3b5f, Offset: 0x22f5
// Size: 0x108
function function_f3f791121b151603( player )
{
    if ( self.asmname == self.defaultasm )
    {
        self.var_dd6868ae78a8de98 = player.origin;
        self.var_6002aa8166897fd7 = "med";
        battlechatter::function_b63bed8df8e4202a( "guard_player_spotted", "warn_spotted", 0, 0, 3 );
        animindex = self asmgetanim( self.asmname, "patrol_move_react_aim" );
        reactanim = asm::asm_getxanim( "patrol_move_react_aim", animindex );
        animtime = getanimlength( reactanim );
        self motionwarpcancel();
        self animmode( "zonly_physics" );
        self orientmode( "face enemy" );
        self function_5fc6208ae437947b( player );
        self aisetanim( "patrol_move_react_aim", animindex, 1 );
        wait animtime;
        
        if ( self.asmname == self.defaultasm )
        {
            self function_5fc6208ae437947b();
            self asmsetstate( self.asmname, "patrol_move" );
        }
    }
}

// Namespace namespace_13234c7eaab1a112
// Params 1
// Checksum 0xd1cd4fa4, Offset: 0x2405
// Size: 0xd4
function function_db3b87cdc5422f76( alias )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    sequence = [];
    
    switch ( alias )
    {
        case #"hash_9afce1b0ecac4374":
            sequence = [ "warn_getBack" ];
            break;
        case #"hash_5812880e67a2c623":
            sequence = [ "warn_getBackNow" ];
            break;
        case #"hash_3ea1f1426c9b770d":
            sequence = [ "warn_getOut" ];
            break;
        case #"hash_f67d317d2f97f09c":
            sequence = [ "warn_curse" ];
            break;
        case #"hash_6f85aaf2e7841904":
            sequence = [ "warn_curse" ];
            break;
    }
    
    battlechatter::function_b63bed8df8e4202a( "guard_player_warning", sequence, 0, 0, 1 );
}

// Namespace namespace_13234c7eaab1a112
// Params 0
// Checksum 0x893891cf, Offset: 0x24e1
// Size: 0x1d9
function function_2a1cb2a8899ed1a()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    wait 2.7;
    sequence = [];
    
    if ( utility::percent_chance( 25 ) )
    {
        if ( utility::percent_chance( 25 ) )
        {
            sequence = [ "warn_getBack", 1, "warn_getOut", 0.4, "warn_curse" ];
        }
        else
        {
            sequence = [ "warn_getBack", 1, "warn_getOut" ];
        }
    }
    else if ( utility::percent_chance( 25 ) )
    {
        if ( utility::percent_chance( 25 ) )
        {
            sequence = [ "warn_getBackNow", 1, "warn_getOut", 0.4, "warn_curse" ];
        }
        else
        {
            sequence = [ "warn_getBackNow", 1, "warn_getOut" ];
        }
    }
    else if ( utility::percent_chance( 25 ) )
    {
        if ( utility::percent_chance( 25 ) )
        {
            sequence = [ "warn_getOut", 1, "warn_getBack", 0.4, "warn_curse" ];
        }
        else
        {
            sequence = [ "warn_getOut", 1, "warn_getBack" ];
        }
    }
    else if ( utility::percent_chance( 25 ) )
    {
        sequence = [ "warn_getOut", 1, "warn_getBackNow", 0.4, "warn_curse" ];
    }
    else
    {
        sequence = [ "warn_getOut", 1, "warn_getBackNow" ];
    }
    
    battlechatter::function_b63bed8df8e4202a( "guard_player_warning", sequence, 0, 0, 1 );
}

// Namespace namespace_13234c7eaab1a112
// Params 0
// Checksum 0x660c7b50, Offset: 0x26c2
// Size: 0x328
function gulag_nearbyplayer()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    shouldattack = 0;
    
    while ( true )
    {
        if ( self.var_9b859331e791ef3d )
        {
            self.isattackingplayer = 1;
            wait 0.1;
            continue;
        }
        
        assert( isdefined( self.arena ) );
        playersnearby = function_7091969e35988c39( self.arena, self.origin, 180 );
        
        if ( playersnearby.size > 0 )
        {
            playersnearby = sortbydistance( playersnearby, self.origin );
            
            foreach ( player in playersnearby )
            {
                if ( player.ignoreme || player::isinlaststand( player ) || player isinexecutionvictim() )
                {
                    continue;
                }
                
                var_ed25b30576bdea13 = distance2d( self.origin, player.origin ) <= 80;
                
                if ( ( self cansee( player ) || var_ed25b30576bdea13 ) && !shouldattack )
                {
                    if ( player.var_75194777bc5f8323.size > 0 )
                    {
                        shouldattack = 1;
                        self.isattackingplayer = shouldattack;
                        self.var_85101615c9005691 = player;
                        function_f3f791121b151603( player );
                        battlechatter::function_b63bed8df8e4202a( "guard_warn_attack", "warn_attack", 0, 0, 3 );
                        function_796d2abd64f389c6( 1 );
                        break;
                    }
                    
                    if ( self.var_a74ebb57cc2b4b2c )
                    {
                        shouldattack = 1;
                        self.isattackingplayer = shouldattack;
                        self.var_85101615c9005691 = player;
                        battlechatter::function_b63bed8df8e4202a( "guard_warn_attack", "warn_attack", 0, 0, 3 );
                        function_796d2abd64f389c6( 1 );
                        break;
                    }
                    
                    if ( var_ed25b30576bdea13 )
                    {
                        self.var_a74ebb57cc2b4b2c = 1;
                        self.pausepatrol = 1;
                        self setgoalpos( self.origin );
                        
                        if ( !self.var_9b859331e791ef3d )
                        {
                            capname = "cap_jailer_warnoff";
                            capanimset = "cap_jailer_warnoff";
                            self setlookatenabled( 1 );
                            self setlookatentity( player );
                            self.var_ee11fe2277414a1a = player;
                            self function_5fc6208ae437947b( player );
                            thread function_2a1cb2a8899ed1a();
                            cap::cap_start( capname, capanimset );
                            self waittill( #"cap_exit_completed" );
                            self function_5fc6208ae437947b();
                            self setlookatentity();
                            self.var_ee11fe2277414a1a = undefined;
                        }
                        
                        break;
                    }
                }
            }
        }
        else
        {
            self.pausepatrol = 0;
            self.var_a74ebb57cc2b4b2c = 0;
            shouldattack = 0;
            self.isattackingplayer = shouldattack;
        }
        
        if ( !shouldattack && !self.isattackingplayer && self.var_24de888ecb99bad3 < level.var_8c9e2ca59f15de8d.var_907b1fe942a431b5 )
        {
            function_796d2abd64f389c6( 0 );
            self.var_db127a8516cea29d = undefined;
        }
        
        wait 0.1;
    }
}

// Namespace namespace_13234c7eaab1a112
// Params 5
// Checksum 0xa592221b, Offset: 0x29f2
// Size: 0x28c
function function_aa5e07e3d2121b1a( agent, pathstruct, startindex, goalradiusoverride, idletimeoverride )
{
    if ( !isdefined( agent ) )
    {
        return;
    }
    
    level endon( #"game_ended" );
    var_a4c60ebde94bc5ca = 0;
    behaviorpackage = ai_behavior::function_342e7d77531fb6e3( agent );
    
    if ( !isdefined( behaviorpackage ) || behaviorpackage.behavior != "patrol" )
    {
        ai_behavior::function_275a3085a93cd3ad( agent, [ agent ], pathstruct );
    }
    
    if ( isagent( agent ) )
    {
        agent endon( #"death" );
        var_a4c60ebde94bc5ca = 1;
    }
    
    if ( !var_a4c60ebde94bc5ca )
    {
        return;
    }
    
    path = pathstruct.path;
    pathstruct.claimed = 1;
    index = 1;
    forwarddirection = 1;
    
    if ( isdefined( startindex ) )
    {
        index = startindex;
        index = int( min( index, path.size - 1 ) );
        index = int( max( index, 0 ) );
    }
    
    ai_behavior::function_1035cc9dfcff38d0();
    wait 1;
    
    while ( true )
    {
        shouldpatrol = !agent.isattackingplayer && !agent.pausepatrol;
        
        if ( shouldpatrol )
        {
            if ( isvector( path[ index ] ) )
            {
                point = path[ index ];
            }
            else
            {
                point = path[ index ].origin;
            }
            
            random_x = randomfloatrange( 10, 11 ) * ( utility::cointoss() ? 1 : -1 );
            random_y = randomfloatrange( 10, 11 ) * ( utility::cointoss() ? 1 : -1 );
            point = ( point[ 0 ] + random_x, point[ 1 ] + random_y, point[ 2 ] );
            agent ai_behavior::_setgoalpos( point, 32 );
            wait randomfloatrange( 1.5, 2.5 );
            waitframe();
            agent waittill( #"goal" );
        }
        
        if ( agent.var_3d17d83febcd8fbf )
        {
            wait 0.5;
        }
        else
        {
            wait idletimeoverride ?? 5;
        }
        
        shouldpatrol = !agent.isattackingplayer && !agent.pausepatrol;
        
        if ( shouldpatrol )
        {
            if ( forwarddirection )
            {
                index++;
            }
            else
            {
                index--;
            }
            
            if ( !isdefined( path[ index ] ) )
            {
                if ( !pathstruct.pingpongpath )
                {
                    index = 0;
                    continue;
                }
                
                if ( forwarddirection )
                {
                    index = path.size - 2;
                    forwarddirection = 0;
                    continue;
                }
                
                index = 1;
                forwarddirection = 1;
            }
        }
    }
}

// Namespace namespace_13234c7eaab1a112
// Params 3
// Checksum 0x99efa88e, Offset: 0x2c86
// Size: 0xc1
function function_7091969e35988c39( arena, pos, radius )
{
    players = [];
    
    foreach ( player in arena.jailedplayers )
    {
        if ( isdefined( player ) )
        {
            if ( distance2d( pos, player.origin ) <= radius )
            {
                players[ players.size ] = player;
            }
        }
    }
    
    return players;
}

