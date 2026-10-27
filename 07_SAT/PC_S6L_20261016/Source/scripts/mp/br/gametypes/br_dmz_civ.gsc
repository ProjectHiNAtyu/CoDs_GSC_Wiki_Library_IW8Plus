// scripts\mp\br\gametypes\br_dmz_civ.gsc  (hash_1383ecc05d2fce34.gscc) (size: 17649 Bytes / 0x44f1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x175ffa97 (392166039)
// size ...... 17649 (0x44f1)
// includes .. 17  (offset: 0x40ad)
// strings ... 67  (offset: 0x4135)
// dev strs .. 1   (offset: 0x44e5)
// exports ... 35  (offset: 0x2d7d)
// cseg ...... 0x70b + 0x2672 (0x2d7d)
// imports ... 110 (offset: 0x32f5)
// animtree1 . 0   (offset: 0x44f1)
// animtree2 . 0   (offset: 0x44f1)
#using scripts\asm\asm_bb;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\agents\common_agent_damage;
#using scripts\mp\ai_fortress;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\br\gametypes\br_gametype_dmz;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\scriptable_door_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\mp_agent;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\poi;

#namespace br_dmz_civ;

// Namespace br_dmz_civ
// Params 0
// Checksum 0x9ea31d06, Offset: 0x729
// Size: 0xf9
function function_8ee74d8ed4a96082()
{
    utility::flag_init( "weapon_unholstered" );
    utility::flag_set( "weapon_unholstered" );
    
    if ( isdefined( level.var_856dcfa12d80fe53 ) )
    {
        return;
    }
    
    level.var_856dcfa12d80fe53 = 1;
    level.agent_funcs[ "civilian" ][ "on_damaged" ] = &function_10e5ffc0b475f38c;
    level.agent_funcs[ "civilian" ][ "on_damaged_finished" ] = &function_e6fd41fc23d0839a;
    level.var_6ef9566736ce222b = getdvarint( @"hash_7f7f3e4f27363c65", 4 );
    var_f85760d13e7214c6 = getdvarint( @"hash_a199ce36eba582c6", 1024 );
    level.var_9be1cbd761973b1 = var_f85760d13e7214c6 * var_f85760d13e7214c6;
    var_f87a72d13e988414 = getdvarint( @"hash_a1bce036ebcbf214", 3072 );
    level.var_9e12ebd763fe2ff = var_f87a72d13e988414 * var_f87a72d13e988414;
    function_a8c5e3a3e51d6d2a();
    ai_mp_controller::function_7f833bacb64445a6();
    spawncivs();
    
    /#
        level thread function_b70890b7a144bc2a();
        level thread function_103817145f950986();
    #/
}

// Namespace br_dmz_civ
// Params 0
// Checksum 0xe23a83ef, Offset: 0x82a
// Size: 0x29f
function function_a8c5e3a3e51d6d2a()
{
    level.var_df01312b97ae9bc = function_869b0d0f5b5f3010();
    level.var_7d7e9d690337ddfb = function_233a6615b0c94ea3( 0 );
    level.var_179d57645a265b9b = function_233a6615b0c94ea3( 1 );
    level.var_1a21747608df28bc = [];
    
    if ( getdvarint( @"hash_580b92e548153095", 1 ) == 1 )
    {
        level.var_1a21747608df28bc = function_c16e9c87af1f297a();
    }
    
    if ( poi::poi_issystemactive() )
    {
        poi::function_3fe3760adc2508e5( "civSpawnLocs" );
        
        foreach ( loc in level.var_df01312b97ae9bc )
        {
            poi::function_af949b3e1b544ec8( loc.script_poi, "civSpawnLocs", loc );
        }
        
        poi::function_3fe3760adc2508e5( "civInteractionSpawnLocs" );
        
        foreach ( loc in level.var_1a21747608df28bc )
        {
            poi::function_af949b3e1b544ec8( loc.script_poi, "civInteractionSpawnLocs", loc );
        }
        
        poi::function_3fe3760adc2508e5( "civFleeLocs_exterior" );
        
        foreach ( loc in level.var_7d7e9d690337ddfb )
        {
            poi::function_af949b3e1b544ec8( loc.script_poi, "civFleeLocs_exterior", loc );
        }
        
        poi::function_3fe3760adc2508e5( "civFleeLocs_interior" );
        
        foreach ( loc in level.var_179d57645a265b9b )
        {
            poi::function_af949b3e1b544ec8( loc.script_poi, "civFleeLocs_interior", loc );
        }
    }
}

// Namespace br_dmz_civ
// Params 0
// Checksum 0x73984848, Offset: 0xad1
// Size: 0x40
function function_869b0d0f5b5f3010()
{
    spawnlocs = utility::getstructarray( "civilian_spawn_loc", "targetname" );
    spawnlocs = arraycombine( utility::getstructarray( "civilian_spawn_loc", "script_noteworthy" ), spawnlocs );
    spawnlocs = arrayrandomize( spawnlocs );
    return spawnlocs;
}

// Namespace br_dmz_civ
// Params 0
// Checksum 0x7af0b5b9, Offset: 0xb1a
// Size: 0x28
function function_c16e9c87af1f297a()
{
    spawnlocs = utility::getstructarray( "civilian_interaction_spawn_loc", "targetname" );
    spawnlocs = arrayrandomize( spawnlocs );
    return spawnlocs;
}

// Namespace br_dmz_civ
// Params 1
// Checksum 0x4c5df3d, Offset: 0xb4b
// Size: 0x11f
function function_233a6615b0c94ea3( interior )
{
    fleelocs = [];
    locs = utility::getstructarray( "civilian_flee_loc", "targetname" );
    var_7c7820e5a4403c33 = 5;
    currentframe = 0;
    
    foreach ( struct in locs )
    {
        if ( ai_fortress::function_f96df72675d7e8c6( struct.origin ) )
        {
            struct.infortress = 1;
        }
        
        isinterior = struct.script_noteworthy == "interior";
        
        if ( interior )
        {
            if ( isinterior )
            {
                fleelocs[ fleelocs.size ] = struct;
            }
        }
        else if ( !isinterior )
        {
            fleelocs[ fleelocs.size ] = struct;
        }
        
        currentframe++;
        
        if ( currentframe == var_7c7820e5a4403c33 )
        {
            currentframe = 0;
            waitframe();
        }
    }
    
    return fleelocs;
}

// Namespace br_dmz_civ
// Params 0
// Checksum 0xca5fea11, Offset: 0xc73
// Size: 0x3d5
function spawncivs()
{
    if ( !isdefined( level.var_966daa749de4aa65 ) )
    {
        level.var_966daa749de4aa65 = [];
    }
    
    if ( !poi::poi_issystemactive() )
    {
        foreach ( spawnloc in level.var_1a21747608df28bc )
        {
            ai = spawn_civilian( spawnloc, undefined, undefined, undefined, undefined, 1 );
            level.var_966daa749de4aa65[ level.var_966daa749de4aa65.size ] = ai;
        }
        
        foreach ( spawnloc in level.var_df01312b97ae9bc )
        {
            ai = spawn_civilian( spawnloc, undefined, undefined, undefined, undefined, 1 );
            level.var_966daa749de4aa65[ level.var_966daa749de4aa65.size ] = ai;
        }
        
        return;
    }
    
    foreach ( poiname, poi in level.poi )
    {
        foreach ( spawnloc in poi[ "civInteractionSpawnLocs" ] )
        {
            ai = spawn_civilian( spawnloc, undefined, poiname, undefined, undefined, 1 );
            level.var_966daa749de4aa65[ level.var_966daa749de4aa65.size ] = ai;
        }
    }
    
    var_db6605d2be9208cb = [];
    
    foreach ( poiname, poi in level.poi )
    {
        if ( arraycontains( level.var_e38f0af66eb58ff2, poiname ) || !isdefined( poi[ "civSpawnLocs" ] ) )
        {
            continue;
        }
        
        foreach ( spawnloc in poi[ "civSpawnLocs" ] )
        {
            var_db6605d2be9208cb[ var_db6605d2be9208cb.size ] = spawnloc;
        }
    }
    
    foreach ( spawnloc in arrayrandomize( var_db6605d2be9208cb ) )
    {
        ai = spawn_civilian( spawnloc, undefined, spawnloc.script_poi, undefined, undefined, 1 );
        level.var_966daa749de4aa65[ level.var_966daa749de4aa65.size ] = ai;
    }
}

// Namespace br_dmz_civ
// Params 8
// Checksum 0x2aa1df71, Offset: 0x1050
// Size: 0x1a8
function spawn_civilian( struct, path, poiname, initialcap, initialanimset, var_aa386c348a2d3e74, var_feff9991b2e5abeb, priorityoverride )
{
    ismale = 0;
    agenttype = ismale ? "civilian_mp_dmz_male" : "civilian_mp_dmz_female";
    budgettype = "civilian";
    
    if ( isdefined( var_feff9991b2e5abeb ) )
    {
        budgettype = var_feff9991b2e5abeb;
    }
    
    priority = "filler";
    
    if ( isdefined( priorityoverride ) )
    {
        priority = priorityoverride;
    }
    
    ai = ai_mp_controller::ai_mp_requestspawnagent( agenttype, getclosestpointonnavmesh( struct.origin ), struct.angles, priority, budgettype, undefined, "civs", "civilian", undefined, poiname );
    
    if ( !isdefined( ai ) )
    {
        return;
    }
    
    ai.ignoreme = 1;
    ai.health = 1;
    ai.maxhealth = 1;
    ai setcanusecover( 0 );
    ai.gender = ismale ? "male" : "female";
    
    if ( var_aa386c348a2d3e74 )
    {
        ai.goalradius = 1536;
        ai registerciv();
        return ai;
    }
    
    ai asm_bb::bb_setcivilianstate( "casual" );
    waitframe();
    ai thread bulletwhizbylistener();
    
    if ( isdefined( path ) )
    {
        ai forceteleport( path.origin, path.angles );
        ai setgoalpos( path.origin );
    }
    
    return ai;
}

// Namespace br_dmz_civ
// Params 2
// Checksum 0x4527ba5b, Offset: 0x1201
// Size: 0x9e
function function_230a89fbf887866b( agent, spawnorigin )
{
    agent endon( #"death" );
    interval = 0.05;
    
    while ( true )
    {
        thread debug::drawsphere( agent.origin, 32, interval, ( 1, 0, 0 ) );
        thread debug::drawsphere( spawnorigin, 32, interval, ( 0, 1, 0 ) );
        thread debug_utility::drawline( spawnorigin, agent.origin, interval, ( 0, 0, 1 ) );
        wait interval;
    }
}

/#

    // Namespace br_dmz_civ
    // Params 4
    // Checksum 0xf3d25201, Offset: 0x12a7
    // Size: 0x102, Type: dev
    function function_cd69f502765a21aa( text, offset, tag, duration )
    {
        self endon( #"death" );
        self notify( #"hash_b4df5f17d949a8b6" );
        self endon( #"hash_b4df5f17d949a8b6" );
        endtime = undefined;
        
        if ( isdefined( duration ) )
        {
            endtime = gettime() + duration * 1000;
        }
        
        if ( isdefined( tag ) && self tagexists( tag ) )
        {
            while ( !isdefined( endtime ) || gettime() < endtime )
            {
                print3d( self gettagorigin( tag ) + offset, text, ( 1, 1, 1 ), 1, 0.5, 1, 1 );
                waitframe();
            }
            
            return;
        }
        
        while ( !isdefined( endtime ) || gettime() < endtime )
        {
            print3d( self.origin + offset, text, ( 1, 1, 1 ), 1, 0.5, 1, 1 );
            waitframe();
        }
    }

#/

// Namespace br_dmz_civ
// Params 0
// Checksum 0xad31aa67, Offset: 0x13b1
// Size: 0x2f1
function civ_saydialogue()
{
    self endon( #"death" );
    self notify( #"civ_saydialogue" );
    self endon( #"civ_saydialogue" );
    
    if ( !isdefined( level.var_a3ff2d7980468cd1 ) )
    {
        aliases = [ "dx_vom_cvm1_civ_ambush_civ_10", "dx_vom_cvm1_civ_ambush_civ_20", "dx_vom_cvm1_civ_ambush_civ_30", "dx_vom_cvm1_intro_clearance_150", "dx_vom_cvm2_alley_triage_40", "dx_vom_cvm1_alley_triage_50", "dx_vom_cvm2_alley_triage_60", "dx_vom_cvm1_poppies_start_fields_120", "dx_vom_cvm1_poppies_start_fields_300", "dx_vom_aqm2_2nd_floor_hallway_22", "dx_vom_aqm3_2nd_floor_hallway_23", "dx_vom_aqm2_2nd_floor_hallway_24", "dx_vom_cvm2_reception_bulletproof_90", "dx_vom_cvm1_reception_bulletproof_100", "dx_vom_cvm2_reception_bulletproof_103", "dx_vom_cvm2_breach_offices_140", "dx_vom_cvm1_alley_moving_120", "dx_vom_cvm1_market_rations_20", "dx_vom_cvm1_infil_thief_20", "dx_vom_cvm1_infil_thief_110" ];
        level.var_a3ff2d7980468cd1 = utility::create_deck( aliases, 1, 1 );
        aliases = [ "dx_vom_ucm4_right_underground_rescue_40", "dx_vom_rcm2_entrance_civs_30", "dx_vom_rcm3_entrance_civs_40" ];
        level.var_e44d263f87396aa0 = utility::create_deck( aliases, 0, 0 );
    }
    
    wait randomfloatrange( 0.5, 2 );
    
    if ( gettime() < self.var_c7f8e6e90f3956b7 )
    {
        return;
    }
    
    normal_alias = 0;
    
    if ( utility::percent_chance( 75 ) && self pathdisttogoal() > 512 )
    {
        alias = level.var_e44d263f87396aa0 utility::deck_draw();
        thread civ_stopsoundsifnotmoving();
    }
    else
    {
        alias = level.var_a3ff2d7980468cd1 utility::deck_draw();
        normal_alias = 1;
    }
    
    self playsound( alias, undefined, self );
    sound_length = lookupsoundlength( alias, 1 );
    self.var_c7f8e6e90f3956b7 = gettime() + sound_length + 3000;
    other_civs = getaiarrayinradius( self.origin, 300, "team_five" );
    
    foreach ( civ in other_civs )
    {
        if ( utility::percent_chance( 30 ) )
        {
            civ.var_c7f8e6e90f3956b7 = self.var_c7f8e6e90f3956b7;
        }
    }
    
    if ( !normal_alias )
    {
        return;
    }
    
    wait sound_length / 1000;
    wait randomfloatrange( 0.5, 2 );
    
    if ( self pathdisttogoal() < 512 )
    {
        return;
    }
    
    alias = level.var_e44d263f87396aa0 utility::deck_draw();
    thread civ_stopsoundsifnotmoving();
    self playsound( alias, undefined, self );
    sound_length = lookupsoundlength( alias, 1 );
    self.var_c7f8e6e90f3956b7 = gettime() + sound_length + 3000;
}

// Namespace br_dmz_civ
// Params 14
// Checksum 0xd106e419, Offset: 0x16aa
// Size: 0xb8
function function_10e5ffc0b475f38c( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon, poisedamage )
{
    if ( !common_agent_damage::function_e156111d9c0dfc5( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon ) )
    {
        return;
    }
    
    mp_agent::default_on_damage( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon, poisedamage );
}

// Namespace br_dmz_civ
// Params 15
// Checksum 0x70bc28c2, Offset: 0x176a
// Size: 0xab
function function_e6fd41fc23d0839a( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, stun_fraction, modelindex, partname, poisedamage, armorhit )
{
    self stopsounds();
    thread delaytest( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, stun_fraction, modelindex, partname, poisedamage, armorhit );
}

// Namespace br_dmz_civ
// Params 15
// Checksum 0x687ce38a, Offset: 0x181d
// Size: 0xb2
function delaytest( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, stun_fraction, modelindex, partname, poisedamage, armorhit )
{
    self endon( #"death" );
    waitframe();
    mp_agent::default_on_damage_finished( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, stun_fraction, modelindex, partname, poisedamage, armorhit );
}

// Namespace br_dmz_civ
// Params 0
// Checksum 0xd147d5f8, Offset: 0x18d7
// Size: 0x89
function civ_stopsoundsifnotmoving()
{
    self endon( #"death" );
    self notify( #"stopsoundsifnotmoving" );
    self endon( #"stopsoundsifnotmoving" );
    
    while ( true )
    {
        wait 0.2;
        
        if ( !self codemoverequested() )
        {
            alias = level.var_a3ff2d7980468cd1 utility::deck_draw();
            self playsound( alias, undefined, self );
            sound_length = lookupsoundlength( alias, 1 );
            self.var_c7f8e6e90f3956b7 = gettime() + sound_length + 3000;
            return;
        }
    }
}

// Namespace br_dmz_civ
// Params 0
// Checksum 0x9f3a5b9e, Offset: 0x1968
// Size: 0x1c
function deregisterondeath()
{
    self waittill( #"death" );
    [[ level.var_1edd1dbbcea4cc76 ]]( self );
}

// Namespace br_dmz_civ
// Params 0
// Checksum 0x2268e5f7, Offset: 0x198c
// Size: 0x25c
function doorwatcher()
{
    self endon( #"death" );
    self endon( #"goal" );
    contents = trace::create_solid_ai_contents( 1 );
    
    while ( true )
    {
        nearbydoors = scriptable_door_utility::scriptable_door_get_in_radius( self.origin, 60, 20 );
        
        foreach ( door in nearbydoors )
        {
            doorfwd = anglestoforward( door.angles );
            doorcenter = door.origin + doorfwd * 30 + ( 0, 0, 40 );
            var_843dc29dcc28310c = door.origin + doorfwd * 30;
            agentfwd = anglestoforward( self.angles );
            
            if ( isdefined( door.var_a00478e6dcbd933f ) && gettime() < door.var_a00478e6dcbd933f + 1000 )
            {
                continue;
            }
            
            handletrace = trace::ray_trace( self geteye(), doorcenter, self, contents );
            
            if ( handletrace[ "fraction" ] < 0.7 )
            {
                continue;
            }
            
            if ( vectordot( agentfwd, vectornormalize( var_843dc29dcc28310c - self.origin ) ) < 0.6 )
            {
                continue;
            }
            
            right = anglestoright( door.angles );
            normal = vectornormalize( self.origin - door.origin );
            dot = vectordot( right, normal );
            isbashleft = dot > 0;
            
            if ( isbashleft )
            {
                bashstate = "bash_left_90";
            }
            else
            {
                bashstate = "bash_right_90";
            }
            
            currentstate = door getscriptablepartstate( "door" );
            
            if ( currentstate != bashstate )
            {
                door setscriptablepartstate( "door", bashstate, 0 );
                door.var_a00478e6dcbd933f = gettime();
            }
        }
        
        waitframe();
    }
}

// Namespace br_dmz_civ
// Params 0
// Checksum 0x8cf95bd8, Offset: 0x1bf0
// Size: 0xc9
function bulletwhizbylistener()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"bulletwhizby", attacker, dist, position );
        
        if ( self.ishostage )
        {
            continue;
        }
        
        event = spawnstruct();
        event.entitytype = "civilian";
        event.originator = attacker;
        event.position = position ?? self.origin;
        event.time = gettime();
        event.type = "gunshot";
        self [[ level.var_6461a0eaf888fce3 ]]( event );
    }
}

// Namespace br_dmz_civ
// Params 0
// Checksum 0xbf8180a8, Offset: 0x1cc1
// Size: 0xdd
function fleefromplayerproximity()
{
    self endon( #"death" );
    self notify( #"fleefromplayerproximity" );
    self endon( #"fleefromplayerproximity" );
    var_bce65070a65b5dd3 = getdvarint( @"scr_dmz_civ_player_flee_dist", 768 );
    var_e7b117887b6510e3 = var_bce65070a65b5dd3 * var_bce65070a65b5dd3;
    
    while ( true )
    {
        if ( !self.ishostage )
        {
            closestplayer = [[ level.var_13537220240cf46f ]]( self.origin );
            
            if ( isdefined( closestplayer ) )
            {
                playerdistsq = distancesquared( closestplayer.origin, self.origin );
                
                if ( playerdistsq < var_e7b117887b6510e3 )
                {
                    self.fleefromorigin = closestplayer.origin;
                    break;
                }
            }
        }
        
        wait 0.25;
    }
    
    self.attitude = "panicked";
}

// Namespace br_dmz_civ
// Params 0
// Checksum 0x3598607f, Offset: 0x1da6
// Size: 0x9f
function function_d0a296fd5bead32c()
{
    level ai_mp_controller::function_2b1cc53b284373( &function_cb1e210656c57de0 );
    level.var_9aa3ad1fbf73f62a = getdvarint( @"hash_1ed01a3ac2e46a7c", 3 );
    level.var_4dc2141ecbbc2490 = getdvarint( @"hash_4e05813ba09e44e2", 5 );
    level.var_eb76c4203daf76f2 = getdvarint( @"hash_4c5a379275261110", 10 );
    level.var_af26deabfaaa9fce = getdvarint( @"hash_50c71a1b6ecf22c7", 15 );
    level.var_2f4845ac57b1fb34 = getdvarint( @"hash_9e35a31c63222311", 10 );
    level.var_fa1bef50aea82dc6 = getdvarint( @"hash_f4083999d389ca6b", 3 );
}

// Namespace br_dmz_civ
// Params 1
// Checksum 0xfd3df424, Offset: 0x1e4d
// Size: 0xdb
function function_cb1e210656c57de0( params )
{
    agent = self;
    killer = params.eattacker;
    
    if ( agent.unittype == "civilian" && isdefined( killer ) && agent.category != "mission" )
    {
        player = undefined;
        
        if ( isplayer( killer ) )
        {
            player = killer;
        }
        else if ( isdefined( killer.owners[ 0 ] ) && killer vehicle::is_vehicle() )
        {
            player = killer.owners[ 0 ];
        }
        
        if ( isdefined( player ) )
        {
            if ( !isdefined( player.civiliankillcount ) )
            {
                player.civiliankillcount = 0;
            }
            
            player.civiliankillcount++;
            player function_14261fadba57de();
        }
    }
}

// Namespace br_dmz_civ
// Params 0
// Checksum 0x7b7c1fee, Offset: 0x1f30
// Size: 0x3c2
function function_14261fadba57de()
{
    allteammates = teams::getsquadmates( self.team, self.sessionsquadid, 1 );
    otherteammates = arrayremove( allteammates, self );
    
    if ( self.civiliankillcount == 1 )
    {
        utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"player_civ_kill_frst_warning", allteammates );
        return;
    }
    
    if ( self.civiliankillcount == 2 )
    {
        utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"player_civ_kill_second_warning", allteammates );
        return;
    }
    
    if ( self.civiliankillcount == level.var_9aa3ad1fbf73f62a )
    {
        utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"player_civ_kill_third_warning", [ self ] );
        utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"squad_civ_bounty", otherteammates );
        level function_76b4d35172451ae8( self );
        self.objpingdelay = level.var_af26deabfaaa9fce;
        function_a83286b579f01bc9();
        showassassinationtargethud( self, 3 );
        level thread function_5d4eadf1a6889f29( self );
        
        foreach ( team in level.teamnamelist )
        {
            if ( team != self.team )
            {
                br_gametype_dmz::showdmzsplash( "dmz_civ_bounty_them", teams::getteamdata( team, "players" ) );
                continue;
            }
            
            br_gametype_dmz::showdmzsplash( "dmz_civ_bounty_us", teams::getteamdata( team, "players" ) );
        }
        
        return;
    }
    
    if ( self.civiliankillcount == level.var_4dc2141ecbbc2490 )
    {
        self.objpingdelay = level.var_2f4845ac57b1fb34;
        showassassinationtargethud( self, 4 );
        self iprintlnbold( "WARNING: Your bounty has increased!" );
        
        foreach ( team in level.teamnamelist )
        {
            if ( team != self.team )
            {
                br_gametype_dmz::showdmzsplash( "dmz_civ_bounty_them_inc", teams::getteamdata( team, "players" ) );
                continue;
            }
            
            br_gametype_dmz::showdmzsplash( "dmz_civ_bounty_us_inc", teams::getteamdata( team, "players" ) );
        }
        
        return;
    }
    
    if ( self.civiliankillcount == level.var_eb76c4203daf76f2 )
    {
        self.objpingdelay = level.var_fa1bef50aea82dc6;
        showassassinationtargethud( self, 5 );
        self iprintlnbold( "WARNING: Maximum bounty has been placed on you!" );
        
        foreach ( team in level.teamnamelist )
        {
            if ( team != self.team )
            {
                br_gametype_dmz::showdmzsplash( "dmz_civ_bounty_them_inc", teams::getteamdata( team, "players" ) );
                continue;
            }
            
            br_gametype_dmz::showdmzsplash( "dmz_civ_bounty_us_inc", teams::getteamdata( team, "players" ) );
        }
    }
}

// Namespace br_dmz_civ
// Params 0
// Checksum 0x113adcfe, Offset: 0x22fa
// Size: 0x12f
function function_a83286b579f01bc9()
{
    self.objidbounty = objidpoolmanager::requestobjectiveid( 99 );
    objid = self.objidbounty;
    objective_setlabel( objid, "MP_INGAME_ONLY/OBJ_TARGET_CAPS" );
    objidpoolmanager::update_objective_setzoffset( objid, 90 );
    objidpoolmanager::update_objective_icon( objid, "ui_map_icon_bounty" );
    objective_setplayintro( objid, 0 );
    objidpoolmanager::objective_playermask_hidefromall( objid );
    objidpoolmanager::update_objective_setbackground( objid, 2 );
    objidpoolmanager::update_objective_position( objid, self.origin + ( 0, 0, 100 ) );
    objidpoolmanager::update_objective_state( objid, "current" );
    objidpoolmanager::update_objective_onentity( objid, self );
    
    foreach ( team in level.teamnamelist )
    {
        if ( team != self.team )
        {
            objidpoolmanager::objective_teammask_addtomask( objid, team );
        }
    }
    
    thread updatetargetlocation();
}

// Namespace br_dmz_civ
// Params 0
// Checksum 0x3760cf6e, Offset: 0x2431
// Size: 0x92
function updatetargetlocation()
{
    level endon( #"game_ended" );
    self endon( #"trigger_removed" );
    objective_setpings( self.objidbounty, 1 );
    
    for ( ;; )
    {
        if ( isdefined( self ) && isdefined( self.origin ) )
        {
            objidpoolmanager::update_objective_position( self.objidbounty, self.origin + ( 0, 0, 100 ) );
            objective_ping( self.objidbounty );
        }
        else
        {
            break;
        }
        
        wait self.objpingdelay;
    }
    
    /#
        level iprintlnbold( "<dev string:x24>" );
    #/
}

// Namespace br_dmz_civ
// Params 1
// Checksum 0x9205841b, Offset: 0x24cb
// Size: 0x29
function function_c3f0b6f648713ba8( dialog )
{
    if ( soundexists( dialog ) )
    {
        self queuedialogforplayer( #"queue1", dialog, dialog, 2 );
    }
}

// Namespace br_dmz_civ
// Params 1
// Checksum 0x19e7f76c, Offset: 0x24fc
// Size: 0x125
function function_76b4d35172451ae8( bountytarget )
{
    foreach ( entry in level.teamnamelist )
    {
        if ( bountytarget.team == entry )
        {
            foreach ( player in teams::getteamdata( entry, "players" ) )
            {
                if ( player != bountytarget )
                {
                    player queuedialogforplayer( #"queue1", "dx_bra_uktl_mission_mission_ass_hunted", "dx_bra_uktl_mission_mission_ass_hunted", 2 );
                }
            }
            
            break;
        }
    }
}

// Namespace br_dmz_civ
// Params 1
// Checksum 0xa16f702, Offset: 0x2629
// Size: 0x12b
function function_5d4eadf1a6889f29( bountytarget )
{
    foreach ( entry in level.teamnamelist )
    {
        if ( isdefined( bountytarget.team ) && bountytarget.team != entry )
        {
            foreach ( player in teams::getteamdata( entry, "players" ) )
            {
                player queuedialogforplayer( #"queue1", "dx_mpa_uktl_enmy_kills_multi_civs_bounty", "dx_mpa_uktl_enmy_kills_multi_civs_bounty", 2 );
            }
        }
    }
}

// Namespace br_dmz_civ
// Params 2
// Checksum 0xb91c6ed8, Offset: 0x275c
// Size: 0x68
function updateassassinationdataomnvar( targetplayer, threatlevel )
{
    if ( self.aq_targethudenabled )
    {
        entitynumber = targetplayer getentitynumber();
    }
    else
    {
        entitynumber = -1;
    }
    
    entitynumber = targetplayer getentitynumber();
    entitynumber += 1;
    value = threatlevel << 8 | entitynumber;
    self setclientomnvar( "ui_br_assassination_target", value );
}

// Namespace br_dmz_civ
// Params 1
// Checksum 0xc24e7467, Offset: 0x27cc
// Size: 0xa2
function updateassassinationthreatlevel( targetteam )
{
    foreach ( player in teams::getteamdata( self.targetteam, "players" ) )
    {
        player updateassassinationdataomnvar( self.targetplayer, self.threat_level );
    }
}

// Namespace br_dmz_civ
// Params 2
// Checksum 0xa838a6b4, Offset: 0x2876
// Size: 0x2a
function showassassinationtargethud( targetplayer, threatlevel )
{
    self.aq_targethudenabled = 1;
    updateassassinationdataomnvar( targetplayer, threatlevel );
}

// Namespace br_dmz_civ
// Params 0
// Checksum 0x6c226075, Offset: 0x28a8
// Size: 0x18
function hideassassinationtargethud()
{
    self.aq_targethudenabled = 0;
    self setclientomnvar( "ui_br_assassination_target", 0 );
}

// Namespace br_dmz_civ
// Params 1
// Checksum 0x4b6253fd, Offset: 0x28c8
// Size: 0x16a
function function_6f64a163b89abc3d( victim )
{
    attacker = self;
    
    if ( isdefined( attacker ) && isdefined( attacker.team ) && !isagent( attacker ) && attacker.team != victim.team )
    {
        level thread br_public::brleaderdialogteam( "mission_enemy_down", attacker.team, 1 );
        
        if ( isdefined( level.dmzmissioncomplete ) )
        {
            level [[ level.dmzmissioncomplete ]]( attacker.team );
        }
        
        br_gametype_dmz::showdmzsplash( "dmz_civ_bounty_complete", teams::getteamdata( attacker.team, "players" ) );
        
        foreach ( player in teams::getteamdata( attacker.team, "players" ) )
        {
            player br_plunder::playerplunderpickup( getdvarint( @"hash_4f221c528dddee47", 100 ), undefined, 1 );
        }
        
        victim setclientomnvar( "ui_br_assassination_target", 0 );
        objidpoolmanager::returnobjectiveid( victim.objidbounty );
    }
}

// Namespace br_dmz_civ
// Params 2
// Checksum 0xe193132f, Offset: 0x2a3a
// Size: 0x6c
function function_59d4a807a04cd7c5( isinterior, poiname )
{
    if ( !poi::poi_issystemactive() )
    {
        if ( isinterior )
        {
            return level.var_179d57645a265b9b;
        }
        else
        {
            return level.var_7d7e9d690337ddfb;
        }
        
        return;
    }
    
    if ( isinterior )
    {
        return level.poi[ poiname ][ "civFleeLocs_interior" ];
    }
    
    return level.poi[ poiname ][ "civFleeLocs_exterior" ];
}

/#

    // Namespace br_dmz_civ
    // Params 0
    // Checksum 0x405db6ce, Offset: 0x2aae
    // Size: 0x201, Type: dev
    function function_b70890b7a144bc2a()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_25b9c49d3620ac52", 0 ) == 1 )
            {
                foreach ( loc in level.var_7d7e9d690337ddfb )
                {
                    color = ( 0, 1, 0 );
                    
                    if ( loc.inuse )
                    {
                        color = ( 1, 0, 0 );
                    }
                    else if ( loc.infortress )
                    {
                        color = ( 0, 0, 1 );
                    }
                    
                    thread debug::drawline( loc.origin, loc.origin + ( 0, 0, 200 ), 1, color );
                }
                
                foreach ( loc in level.var_179d57645a265b9b )
                {
                    color = ( 1, 1, 0 );
                    
                    if ( loc.inuse )
                    {
                        color = ( 1, 0, 0 );
                    }
                    else if ( loc.infortress )
                    {
                        color = ( 0, 0, 1 );
                    }
                    
                    thread debug::drawline( loc.origin, loc.origin + ( 0, 0, 100 ), 1, color );
                }
            }
            
            wait 1;
        }
    }

    // Namespace br_dmz_civ
    // Params 0
    // Checksum 0x418d537f, Offset: 0x2cb7
    // Size: 0xc6, Type: dev
    function function_103817145f950986()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_4d802ef072f687fb", 0 ) == 1 )
            {
                foreach ( civ in level.var_966daa749de4aa65 )
                {
                    if ( isalive( civ ) )
                    {
                        thread debug::drawsphere( civ.origin, 64, 1, ( 1, 1, 1 ) );
                    }
                }
            }
            
            wait 1;
        }
    }

#/
