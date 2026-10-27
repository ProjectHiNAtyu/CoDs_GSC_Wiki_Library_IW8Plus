// scripts\mp\br\gametypes\br_dmz_radiation.gsc  (hash_5f2318e436282ba1.gscc) (size: 22589 Bytes / 0x583d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xced4f6bc (3470063292)
// size ...... 22589 (0x583d)
// includes .. 23  (offset: 0x53e9)
// strings ... 62  (offset: 0x54a1)
// dev strs .. 4   (offset: 0x580d)
// exports ... 62  (offset: 0x370d)
// cseg ...... 0x5cf + 0x313e (0x370d)
// imports ... 156 (offset: 0x40bd)
// animtree1 . 0   (offset: 0x583d)
// animtree2 . 0   (offset: 0x583d)
#using scripts\common\bots\bots_util;
#using scripts\common\callbacks;
#using scripts\common\gasmask;
#using scripts\common\math;
#using scripts\common\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\agents\common_agent_damage;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_loot;
#using scripts\mp\armor;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_gametype_dmz;
#using scripts\mp\common\equipment\iodine_pills;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\player;
#using scripts\mp\dmz\gametypes\dmz_ai;
#using scripts\mp\dmz\modified_values;
#using scripts\mp\flags;
#using scripts\mp\juggernaut;
#using scripts\mp\loot\common_item_gasmask;

#namespace br_dmz_radiation;

// Namespace br_dmz_radiation
// Params 0, eflags: 0x5
// Checksum 0xbcb79126, Offset: 0x5ed
// Size: 0x369
function private autoexec radiation_init()
{
    callback::add( #"on_spawn_agent", &onspawnagent );
    
    if ( !getmatchrulesdata( "commonOption", "radiationEnabled" ) )
    {
        return;
    }
    
    utility::flag_init( "radiation_spawned" );
    utility::flag_wait( "radiation_supported" );
    level.radiation = { #listeningplayers:[], #damageindex:0, #var_dd87f4e36eca43e4:[ 40, 75 ], #expansionseconds:getmatchrulesdata( "commonOption", "radiationExpansionSeconds" ), #finalradius:getmatchrulesdata( "commonOption", "radiationFinalRadius" ), #startradius:getmatchrulesdata( "commonOption", "radiationStartRadius" ), #spreadingticktime:getmatchrulesdata( "commonOption", "radiationSpreadingTickTime" ), #startticktime:getmatchrulesdata( "commonOption", "radiationStartTickTime" ), #spreadingdamage:getmatchrulesdata( "commonOption", "radiationSpreadingDamage" ), #startdamage:getmatchrulesdata( "commonOption", "radiationStartDamage" ), #damagesarmor:getmatchrulesdata( "commonOption", "radiationDamagesArmor" ), #forceorigin:getmatchrulesdata( "commonOption", "radiationForceOrigin" ), #blockedbyiodine:getmatchrulesdata( "commonOption", "radiationBlockedByIodine" ), #spawnsatstart:getmatchrulesdata( "commonOption", "radiationSpawnsAtStart" ), #var_897dae3075ed501f:getmatchrulesdata( "commonOption", "radiationQuestCircleTemplateID" ) };
    
    if ( bots_util::function_deef484b5b3a3977() )
    {
        function_6875a600074dfc7b();
    }
    
    if ( level.radiation.forceorigin )
    {
        level.radiation.forceoriginx = getmatchrulesdata( "commonOption", "radiationForceOriginX" );
        level.radiation.forceoriginy = getmatchrulesdata( "commonOption", "radiationForceOriginY" );
    }
    else
    {
        level.radiation.startingoriginradius = getmatchrulesdata( "commonOption", "radiationStartingOriginRadius" );
        level.radiation.startingoriginmaxoffset = getmatchrulesdata( "commonOption", "radiationStartingOriginMaxOffset" );
        level.radiation.mindistancefrommaporigin = getmatchrulesdata( "commonOption", "radiationMinDistanceFromMapOrigin" );
        level.radiation.mindistancefrompoi = getmatchrulesdata( "commonOption", "radiationMinDistanceFromPOI" );
        level.radiation.mindistancefromspawn = getmatchrulesdata( "commonOption", "radiationMinDistanceFromSpawn" );
        level.radiation.mindistancefromfallout = getmatchrulesdata( "commonOption", "radiationMinDistanceFromFallout" );
    }
    
    utility::registersharedfunc( #"radiation", #"radiation_isinit", &radiation_isinit );
    utility::registersharedfunc( #"radiation", #"radiation_signeddistancefromradiationcircle", &radiation_signeddistancefromradiationcircle );
    utility::registersharedfunc( #"radiation", #"radiation_isinradiation", &radiation_isinradiation );
    utility::registersharedfunc( #"radiation", #"hash_4a15807eba7b42d9", &function_bc37e528e1300e88 );
    
    if ( level.radiation.spawnsatstart )
    {
        radiation_spawn();
    }
    
    /#
        level.radiation thread radiation_initdebug();
    #/
}

// Namespace br_dmz_radiation
// Params 0
// Checksum 0x62ce670c, Offset: 0x95e
// Size: 0xe
function function_8be2ee7db18bcf4d()
{
    utility::flag_set( "radiation_supported" );
}

// Namespace br_dmz_radiation
// Params 1
// Checksum 0x47a327a2, Offset: 0x974
// Size: 0x78
function onspawnagent( params )
{
    agent = self;
    
    if ( function_ab7a4adeb9f8baa3() )
    {
        return;
    }
    
    var_89d90dc302b215d = function_5a5a89bee8ebb158( agent );
    
    if ( var_89d90dc302b215d )
    {
        return;
    }
    
    if ( agent.radiationattachment == "Gas Mask" )
    {
        function_8976f4d93db5c4a9( agent );
        return;
    }
    
    if ( agent.radiationattachment == "Hazmat Suit" )
    {
        function_40c2c20ef0875d32( agent );
    }
}

// Namespace br_dmz_radiation
// Params 2
// Checksum 0xf6b6ca06, Offset: 0x9f4
// Size: 0x290, Type: bool
function function_5a5a89bee8ebb158( agent, destination )
{
    if ( !radiation_isinit() )
    {
        return false;
    }
    
    if ( agent dmz_ai::function_fb0f68f6b97f7f6c() )
    {
        return false;
    }
    
    if ( agent dmz_ai::isfriendly() )
    {
        return false;
    }
    
    for ( var_b3b2833ed023f830 = distancesquared( agent.origin, level.var_cbe4d28d28ae892a ?? ( 0, 0, -50000 ) ); var_b3b2833ed023f830 < 1024 ; var_b3b2833ed023f830 = distancesquared( agent.origin, level.var_cbe4d28d28ae892a ) )
    {
        waitframe();
    }
    
    var_b8605031f568fe03 = function_d86e95e1a0959d75( agent.origin );
    
    if ( destination )
    {
        var_ea17af6826cc69a = function_d86e95e1a0959d75( destination );
    }
    
    isboss = tolower( agent.category ) == "bosses" && !isdefined( agent.tier );
    var_51aa9ce23ff99a2f = utility::callsharedfunc( #"customradiation", #"get_volumeintensity", agent );
    var_4212e83ddb8a179e = utility::callsharedfunc( #"customradiation", #"hash_1a3f261a82100726", destination );
    var_7d6b68aed34843b = var_51aa9ce23ff99a2f && var_51aa9ce23ff99a2f != "fallout_radiation_warn";
    var_ffa55c75c93e80d2 = var_4212e83ddb8a179e && var_4212e83ddb8a179e != "fallout_radiation_warn";
    
    if ( var_7d6b68aed34843b || var_ffa55c75c93e80d2 )
    {
        if ( isboss )
        {
            function_8976f4d93db5c4a9( agent );
        }
        else if ( var_51aa9ce23ff99a2f == "fallout_radiation_med" || var_4212e83ddb8a179e == "fallout_radiation_med" )
        {
            function_40c2c20ef0875d32( agent );
        }
        else
        {
            function_8976f4d93db5c4a9( agent );
        }
    }
    else if ( var_b8605031f568fe03 < level.radiation.radius + 2200 )
    {
        if ( isboss )
        {
            function_8976f4d93db5c4a9( agent );
        }
        else
        {
            function_40c2c20ef0875d32( agent );
        }
        
        return true;
    }
    else if ( var_b8605031f568fe03 < level.radiation.radius + 3500 )
    {
        function_8976f4d93db5c4a9( agent );
        return true;
    }
    else if ( var_ea17af6826cc69a )
    {
        if ( var_ea17af6826cc69a < level.radiation.radius + 2200 )
        {
            if ( isboss )
            {
                function_8976f4d93db5c4a9( agent );
            }
            else
            {
                function_40c2c20ef0875d32( agent );
            }
            
            return true;
        }
        else if ( var_ea17af6826cc69a < level.radiation.radius + 3500 )
        {
            function_8976f4d93db5c4a9( agent );
            return true;
        }
    }
    
    return false;
}

// Namespace br_dmz_radiation
// Params 2
// Checksum 0xbc322178, Offset: 0xc8d
// Size: 0xab
function function_8976f4d93db5c4a9( agent, attachgasmask = 1 )
{
    if ( agent.var_1e2afba6dedb6c52 )
    {
        return;
    }
    
    agent.radimmune = 1;
    agent.var_1e2afba6dedb6c52 = 1;
    
    if ( agent.tier != 3 && attachgasmask )
    {
        agent.var_1b1e8e95a7a7d01b = 1;
        agent attach( "hat_child_hadir_gas_mask_wm_br", "j_head" );
    }
    
    ai_loot::function_452f7cba22550779( agent, %"hash_711f627a1b1ff5d7", 108, 1, &function_e494fe865ae6a339 );
    agent.var_6252beaf62201a30 = &function_fb24d8e1ce402dfd;
}

// Namespace br_dmz_radiation
// Params 1
// Checksum 0x324a7159, Offset: 0xd40
// Size: 0xe0, Type: bool
function function_e494fe865ae6a339( lootitem )
{
    if ( self.attackerdata && self.attackerdata.size > 0 )
    {
        foreach ( attacker in self.attackerdata )
        {
            if ( attacker.shitloc == "head" || attacker.shitloc == "helmet" )
            {
                lootitem.count *= 0.15;
            }
        }
    }
    
    return true;
}

// Namespace br_dmz_radiation
// Params 2
// Checksum 0x24a4201c, Offset: 0xe29
// Size: 0x63
function function_fb24d8e1ce402dfd( agent, attacker )
{
    if ( agent.var_1b1e8e95a7a7d01b )
    {
        agent detach( "hat_child_hadir_gas_mask_wm_br", "j_head" );
        agent.var_1b1e8e95a7a7d01b = undefined;
        agent.radimmune = 0;
        agent.var_1e2afba6dedb6c52 = 0;
    }
    
    common_agent_damage::function_3384dd53b83c8bf( agent, attacker );
}

// Namespace br_dmz_radiation
// Params 1
// Checksum 0xfbf9d6dd, Offset: 0xe94
// Size: 0xb1, Type: bool
function function_23a851159c5fcbb2( path )
{
    if ( !radiation_isinit() )
    {
        return false;
    }
    
    foreach ( loc in path )
    {
        if ( function_d86e95e1a0959d75( loc.origin ) < level.radiation.radius + 256 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_dmz_radiation
// Params 1
// Checksum 0x5e7b4d6b, Offset: 0xf4e
// Size: 0x1f0
function function_40c2c20ef0875d32( agent )
{
    if ( !agent.tier )
    {
        agent.radimmune = 1;
        return;
    }
    
    if ( agent.hatmodel && !agent.var_ce2f8b4ca895561 )
    {
        agent detach( agent.hatmodel, "" );
    }
    
    switch ( agent.tier )
    {
        case 1:
            body = "rex_body_ai_enemy_dmz_hazmat_1_1_conversion";
            break;
        case 2:
            body = "rex_body_ai_enemy_dmz_hazmat_2_1_conversion";
            break;
        case 3:
            body = "rex_body_ai_enemy_dmz_hazmat_3_1_conversion";
            break;
    }
    
    agent agent_utils::overrideagentsettings( body, "rex_head_sc_m_zimo_lod1" );
    agent.var_ce2f8b4ca895561 = 1;
    agent.radimmune = 1;
    agent setclothtype( #"poncho" );
    agent setgeartype( #"scubagr" );
    agent.var_6252beaf62201a30 = &function_382cd4e3d5bedf11;
    roll = randomintrange( 0, 100 );
    
    if ( roll < 14 )
    {
        if ( agent.subclass == "tier1" )
        {
            ai_loot::function_452f7cba22550779( agent, %"hash_711f627a1b1ff5d7", 108, 1, &function_e494fe865ae6a339 );
        }
        else if ( agent.subclass == "tier2" )
        {
            ai_loot::function_452f7cba22550779( agent, %"hash_399b757e4deba84f", 216, 1, &function_e494fe865ae6a339 );
        }
        
        return;
    }
    
    if ( roll < 34 )
    {
        ai_loot::function_452f7cba22550779( agent, %"hash_470d89d8f6b9ab0b", 1, 1 );
        return;
    }
    
    if ( roll < 38 )
    {
        if ( agent.subclass == "tier3" )
        {
            ai_loot::function_452f7cba22550779( agent, %"hash_35bf5d5dcf88a2bb", 332, 1, &function_e494fe865ae6a339 );
        }
    }
}

// Namespace br_dmz_radiation
// Params 2
// Checksum 0xb5b76e85, Offset: 0x1146
// Size: 0x2c
function function_382cd4e3d5bedf11( agent, attacker )
{
    agent.radimmune = 0;
    common_agent_damage::function_3384dd53b83c8bf( agent, attacker );
}

// Namespace br_dmz_radiation
// Params 0
// Checksum 0x7ff6c63f, Offset: 0x117a
// Size: 0x80
function radiation_spawn()
{
    level.radiation radiation_spawnwarhead();
    level.radiation thread function_3c6014fd6277185b();
    level.radiation thread function_cde3b285746148d8();
    level.radiation thread function_3be2e50aa17afad2();
    level.radiation thread function_465ed25e4ed4d376();
    level.radiation thread function_11967c9b76e71765();
    level.radiation thread function_a641d94acbb354ee();
    flags::gameflaginit( "radiation_initialized", 1 );
}

// Namespace br_dmz_radiation
// Params 0, eflags: 0x4
// Checksum 0x9580a42d, Offset: 0x1202
// Size: 0xea
function private radiation_spawnwarhead()
{
    origin = function_8e0aef1441a5d5d8();
    
    if ( !isdefined( level.radiation.brcircle ) )
    {
        level.radiation.brcircle = spawnbrcircle( origin[ 0 ], origin[ 1 ], level.radiation.startradius );
        level.radiation game_utility::questcircle_create( level.radiation.var_897dae3075ed501f, origin, level.radiation.startradius );
        level.radiation game_utility::questcircle_showtoall();
    }
    else
    {
        level.radiation game_utility::questcircle_move( origin );
    }
    
    radiation_setorigin( origin );
    radiation_setradius( level.radiation.startradius );
    utility::flag_set( "radiation_spawned" );
}

// Namespace br_dmz_radiation
// Params 0, eflags: 0x4
// Checksum 0x43cc8c1e, Offset: 0x12f4
// Size: 0x869
function private function_8e0aef1441a5d5d8()
{
    if ( level.radiation.forceorigin )
    {
        return ( level.radiation.forceoriginx, level.radiation.forceoriginy, 0 );
    }
    
    utility::flag_wait( "dmz_infil_init" );
    
    while ( !isnavmeshloaded() || !isdefined( level.poi_origins ) || level.poi_origins.size <= 0 )
    {
        waitframe();
    }
    
    waitframe();
    
    if ( level.dmzinfils.pools )
    {
        points = [];
        
        foreach ( pool in level.dmzinfils.pools )
        {
            points = arraycombine( points, pool.structs );
        }
        
        averagestart = function_1d522599bbf4333f( points );
    }
    else
    {
        points = [ ( 0, 0, 0 ) ];
        averagestart = ( 0, 0, 0 );
    }
    
    var_f8fbbd73e4d4ebe2 = [];
    furthestorigin = undefined;
    
    if ( !isdefined( level.radiationspawns ) )
    {
        level.radiationspawns = utility::getstructarray( "radiation_spawn" );
    }
    
    if ( isdefined( level.var_25ac25c810adce64 ) )
    {
        foreach ( loc in level.var_25ac25c810adce64 )
        {
            valid = 1;
            
            foreach ( start in points )
            {
                if ( distance2d( start.origin, loc ) < level.radiation.mindistancefromspawn )
                {
                    valid = 0;
                    break;
                }
            }
            
            if ( valid )
            {
                var_f8fbbd73e4d4ebe2[ var_f8fbbd73e4d4ebe2.size ] = loc;
            }
        }
    }
    else if ( level.radiationspawns.size )
    {
        var_315b87b35930fd4d = utility::getsharedfunc( #"mission_manager", #"hash_3548616af55c1d4a" );
        avoidpois = [];
        
        if ( var_315b87b35930fd4d )
        {
            flags::function_2f3408423ccc9b2e( "prematch_started" );
            storymissions = [];
            
            foreach ( player in level.players )
            {
                storymissions = arraycombineunique( storymissions, [ [[ var_315b87b35930fd4d ]]( player.team ) ] );
            }
            
            avoidpois = [];
            
            foreach ( var_863394c87ed09eab in storymissions )
            {
                poiorigin = level.poi_origins[ getscriptbundlefieldvalue( var_863394c87ed09eab.ref, #"hash_fe1fc108118ec4d0" ) ];
                
                if ( poiorigin )
                {
                    avoidpois[ avoidpois.size ] = poiorigin;
                }
            }
        }
        
        level.radiationspawns = arrayrandomize( level.radiationspawns );
        
        for ( i = 0; i < 40 ; i++ )
        {
            radiationspawn = level.radiationspawns[ i % level.radiationspawns.size ];
            
            if ( !radiationspawn.origin || !radiationspawn.radius )
            {
                assertmsg( "<dev string:x24>" + ( radiationspawn.origin ?? "<dev string:x57>" ) );
                continue;
            }
            
            if ( radiationspawn.radius < level.radiation.startradius )
            {
                assertmsg( "<dev string:x61>" + radiationspawn.radius + "<dev string:x92>" + radiationspawn.origin );
                continue;
            }
            
            angle = randomfloatrange( 0, 360 );
            radius = ( radiationspawn.radius - level.radiation.startradius ) * squared( randomfloat( 1 ) );
            raworigin = radiationspawn.origin + ( cos( angle ) * radius, sin( angle ) * radius, 0 );
            raworigin = getclosestpointonnavmesh( raworigin );
            var_bc204f463eeab1c7 = function_2dbc6a29da40df6b( raworigin, points );
            var_3982c4c391ff06ab = function_2dbc6a29da40df6b( raworigin, avoidpois );
            
            if ( var_bc204f463eeab1c7 > level.radiation.mindistancefromspawn && ( !var_3982c4c391ff06ab || var_3982c4c391ff06ab > level.radiation.mindistancefrompoi + radius ) )
            {
                var_f8fbbd73e4d4ebe2[ var_f8fbbd73e4d4ebe2.size ] = raworigin;
            }
        }
    }
    else
    {
        poiorigins = [];
        
        foreach ( poi, origin in level.poi_origins )
        {
            if ( !issubstr( poi, "suburb" ) )
            {
                poiorigins[ poiorigins.size ] = origin;
            }
        }
        
        var_6cce41bf07175629 = undefined;
        
        for ( i = 0; i < 40 ; i++ )
        {
            angle = randomfloatrange( 0, 360 );
            raworigin = ( cos( angle ) * level.radiation.startingoriginradius, sin( angle ) * level.radiation.startingoriginradius, 0 ) + averagestart;
            raworigin += ( randomfloat( level.radiation.startingoriginmaxoffset ), randomfloat( level.radiation.startingoriginmaxoffset ), 0 );
            raworigin = getclosestpointonnavmesh( raworigin );
            var_1ea871b1c9e3c3a3 = function_2dbc6a29da40df6b( raworigin, poiorigins );
            var_bc204f463eeab1c7 = function_2dbc6a29da40df6b( raworigin, points );
            var_c29e1550fd1d715d = function_2dbc6a29da40df6b( raworigin, level.var_aa29c08593a0f0b1 ?? [] );
            var_f0474c4bbfeda9e0 = distance2d( ( 0, 0, 0 ), raworigin );
            
            if ( var_f0474c4bbfeda9e0 > level.radiation.mindistancefrommaporigin && var_bc204f463eeab1c7 > level.radiation.mindistancefromspawn && var_1ea871b1c9e3c3a3 > level.radiation.mindistancefrompoi && var_c29e1550fd1d715d > level.radiation.mindistancefromfallout )
            {
                var_f8fbbd73e4d4ebe2[ var_f8fbbd73e4d4ebe2.size ] = raworigin;
            }
            
            if ( isdefined( var_bc204f463eeab1c7 ) && ( !isdefined( var_6cce41bf07175629 ) || var_bc204f463eeab1c7 > var_6cce41bf07175629 ) )
            {
                var_6cce41bf07175629 = var_1ea871b1c9e3c3a3;
                furthestorigin = raworigin;
            }
        }
    }
    
    origin = undefined;
    
    if ( var_f8fbbd73e4d4ebe2.size > 0 )
    {
        origin = utility::array_random( var_f8fbbd73e4d4ebe2 );
    }
    else if ( isdefined( furthestorigin ) )
    {
        origin = furthestorigin;
    }
    else
    {
        angle = randomfloatrange( 0, 360 );
        origin = ( cos( angle ) * 5000, sin( angle ) * 5000, 0 );
    }
    
    return origin;
}

// Namespace br_dmz_radiation
// Params 0
// Checksum 0x522cd54, Offset: 0x1b66
// Size: 0x23
function function_335346e7f7b6fbbb()
{
    if ( !radiation_isinit() )
    {
        return;
    }
    
    level.radiation.forcefleeing = 1;
}

// Namespace br_dmz_radiation
// Params 0
// Checksum 0xefd24c85, Offset: 0x1b91
// Size: 0x185
function radiation_startspread()
{
    if ( !radiation_isinit() )
    {
        return;
    }
    
    level notify( #"dmz_radiation_started" );
    br_gametype_dmz::showdmzsplash( "dmz_radiation_spreading", level.players );
    setomnvar( "ui_dmz_radiation_spreading", 1 );
    level function_dbc797328684c90a( level.radiation.origin, level.radiation.finalradius, level.radiation.expansionseconds );
    function_ef8f7b438c7461cf();
    level.radiation.spreading = 1;
    timer = 600;
    
    if ( isdefined( level.var_465909675164e0aa ) )
    {
        radspeed = radiation_getspeed();
        var_276282b8b26372d7 = distance2d( level.var_465909675164e0aa.origin, level.radiation.origin ) - level.radiation.startradius;
        timer = var_276282b8b26372d7 / radspeed;
    }
    
    wait 2;
    level.var_9e5d1779e30d44c1 = gettime() + int( ( timer - 2 ) * 1000 );
    setomnvar( "ui_hardpoint_timer", level.var_9e5d1779e30d44c1 );
    utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"radiation_start_spread", level.players );
    level thread function_24c46b568fe7d265();
    wait timer;
    level notify( #"hash_4f7f7eca38bdee5a" );
}

// Namespace br_dmz_radiation
// Params 0, eflags: 0x4
// Checksum 0x51c2440d, Offset: 0x1d1e
// Size: 0xdc
function private function_24c46b568fe7d265()
{
    level endon( #"game_ended" );
    
    if ( game_utility::getgametype() == "ob" )
    {
        return;
    }
    
    wait 1.5;
    distthreshold = 23622;
    
    foreach ( player in level.players )
    {
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        playerdist = radiation_signeddistancefromradiationcircle( player.origin );
        
        if ( playerdist > distthreshold )
        {
            continue;
        }
        
        player thread function_8b9c07c05a440f59();
    }
}

// Namespace br_dmz_radiation
// Params 0
// Checksum 0x6058587e, Offset: 0x1e02
// Size: 0xa9
function function_8b9c07c05a440f59()
{
    player = self;
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    player endon( #"successful_exfil" );
    
    if ( player.musicpack == 1 )
    {
        radiationmusicstate = audio_utility::function_d4d265f3dcd0a13c( "br_ring_final_classic" );
        player setplayermusicstate( radiationmusicstate );
    }
    else
    {
        radiationmusicstate = audio_utility::function_d4d265f3dcd0a13c( "br_ring_final" );
        player setplayermusicstate( radiationmusicstate );
    }
    
    wait 90;
    
    if ( !player.var_646195396fad84ff && !player.extracted )
    {
        player setplayermusicstate( "" );
    }
}

// Namespace br_dmz_radiation
// Params 0
// Checksum 0xf29e0992, Offset: 0x1eb3
// Size: 0x23, Type: bool
function function_ab7a4adeb9f8baa3()
{
    return isdefined( level.radiation ) && level.radiation.spreading;
}

// Namespace br_dmz_radiation
// Params 0, eflags: 0x4
// Checksum 0xa671ddb3, Offset: 0x1edf
// Size: 0x1e
function private function_cde3b285746148d8()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        function_f0d736907f5e44b8();
        waitframe();
    }
}

// Namespace br_dmz_radiation
// Params 0, eflags: 0x4
// Checksum 0xe009c11a, Offset: 0x1f05
// Size: 0x2e
function private function_3c6014fd6277185b()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        function_36f8099d609ce1d3();
        function_f9cb4b99c68f31c5();
        function_6bebc8bf0ec57c19();
        wait 1;
    }
}

// Namespace br_dmz_radiation
// Params 0, eflags: 0x4
// Checksum 0x32cb263f, Offset: 0x1f3b
// Size: 0x40
function private function_a641d94acbb354ee()
{
    wait max( 180, level.timelimit - 180 );
    utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"radiation_winds_picking_up", level.players );
}

// Namespace br_dmz_radiation
// Params 0, eflags: 0x4
// Checksum 0x291bf1b7, Offset: 0x1f83
// Size: 0x181
function private function_6bebc8bf0ec57c19()
{
    if ( level.radiation.spreading )
    {
        return;
    }
    
    foreach ( player in level.radiation.listeningplayers )
    {
        if ( isdefined( player ) && isdefined( player.origin ) && function_a66a5ec0f619cbba( player.origin ) )
        {
            level.radiation.listeningplayers = arrayremove( level.radiation.listeningplayers, player );
            
            if ( gasmask::hasgasmask( player ) )
            {
                utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"radiation_approach_with_gas_mask", [ player ] );
            }
            else
            {
                utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"radiation_approach", [ player ] );
            }
            
            continue;
        }
        
        if ( !isdefined( player ) )
        {
            level.radiation.listeningplayers = arrayremove( level.radiation.listeningplayers, player );
        }
    }
}

// Namespace br_dmz_radiation
// Params 0, eflags: 0x4
// Checksum 0x22fd00bc, Offset: 0x210c
// Size: 0xa4
function private function_465ed25e4ed4d376()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( level.supportsai )
        {
            if ( isdefined( level.agentarray ) )
            {
                randomizedagents = arrayrandomize( level.agentarray );
                
                for ( i = 0; i < randomizedagents.size ; i++ )
                {
                    if ( i % 3 == 0 )
                    {
                        waitframe();
                    }
                    
                    agent = randomizedagents[ i ];
                    
                    if ( isalive( agent ) && radiation_isinradiation( agent.origin ) )
                    {
                        function_98febf950b8582b8( agent );
                    }
                }
            }
        }
        
        wait 1;
    }
}

// Namespace br_dmz_radiation
// Params 1
// Checksum 0xcd944838, Offset: 0x21b8
// Size: 0x9b
function function_98febf950b8582b8( agent )
{
    if ( agent.radimmune )
    {
        return;
    }
    
    damage = function_3ee8db822cb18aa();
    damagemultiplier = isdefined( agent.maxhealth ) ? agent.maxhealth * 0.01 : 1;
    agent dodamage( int( damage * damagemultiplier ), agent.origin, undefined, undefined, "MOD_TRIGGER_HURT", "rex_radiation_dmz", "torso_upper" );
    
    if ( !isalive( agent ) )
    {
        return;
    }
    
    function_ee572babb6cb354e( agent );
}

// Namespace br_dmz_radiation
// Params 0, eflags: 0x4
// Checksum 0x52d7e01f, Offset: 0x225b
// Size: 0xe4
function private function_11967c9b76e71765()
{
    thread geiger_init();
    
    while ( true )
    {
        damage = function_bdbdb2f64b8803ab();
        
        if ( !isdefined( damage ) )
        {
            return;
        }
        
        foreach ( player in level.players )
        {
            if ( isdefined( player ) )
            {
                if ( isdefined( player.origin ) && !player.plotarmor && radiation_isinradiation( player.origin ) )
                {
                    function_a851f40f8d82fe9a( player, damage );
                }
            }
        }
        
        wait function_8b7c9b4f3b580f42();
    }
}

// Namespace br_dmz_radiation
// Params 3
// Checksum 0x678f6f3c, Offset: 0x2347
// Size: 0x133
function function_a851f40f8d82fe9a( player, damage, skipgasmask )
{
    if ( iodine_pills::function_4ac5fefa68717ddd( player ) )
    {
        if ( level.radiation.blockedbyiodine )
        {
            damage = 0;
        }
        else
        {
            damage = player iodine_pills::function_46beb04b73f111a7( damage );
        }
    }
    
    damage = player modified_values::function_14d05d73e63e1f9e( 4, damage );
    
    if ( !skipgasmask && damage > 0 )
    {
        if ( !gasmask::hasgasmask( player ) && level.gamemodebundle.var_afaa166e46be5868 )
        {
            player item_gasmask::function_219547e563ff9527();
        }
        else
        {
            player gasmask::processdamage( damage );
            return;
        }
    }
    
    if ( !gasmask::hasgasmask( player ) && damage > 0 )
    {
        if ( player killstreak::isjuggernaut() )
        {
            damage = juggernaut::function_9d3c45be0af60321( damage );
        }
        
        player dodamage( damage, player.origin, player, undefined, "MOD_TRIGGER_HURT", "rex_radiation_dmz", undefined, undefined, 4194304 );
        
        if ( level.radiation.damagesarmor )
        {
            player armor::damagearmor( damage );
        }
        
        if ( utility::cointoss() && !player isswimming() )
        {
            player thread br_circle::tryplaycoughaudio();
        }
    }
}

// Namespace br_dmz_radiation
// Params 0
// Checksum 0xc3f943dd, Offset: 0x2482
// Size: 0x6e
function function_bdbdb2f64b8803ab()
{
    damage = 0;
    
    if ( level.radiation.damageindex == 0 )
    {
        damage = level.radiation.startdamage;
    }
    else
    {
        damage = level.radiation.spreadingdamage;
    }
    
    return damage + ( level.radiation.bonusdamage ?? 0 );
}

// Namespace br_dmz_radiation
// Params 1
// Checksum 0x4f767e1b, Offset: 0x24f9
// Size: 0x70
function function_e034ee44652b7424( damage )
{
    if ( !radiation_isinit() )
    {
        return;
    }
    
    if ( !isdefined( level.radiation.bonusdamage ) )
    {
        level.radiation.bonusdamage = 0;
    }
    
    level.radiation.bonusdamage += int( damage );
}

// Namespace br_dmz_radiation
// Params 0
// Checksum 0x4c983fbe, Offset: 0x2571
// Size: 0x29
function function_3ee8db822cb18aa()
{
    return level.radiation.var_dd87f4e36eca43e4[ level.radiation.damageindex ];
}

// Namespace br_dmz_radiation
// Params 0
// Checksum 0x2f27a160, Offset: 0x25a3
// Size: 0x45
function function_8b7c9b4f3b580f42()
{
    if ( level.radiation.damageindex == 0 )
    {
        return level.radiation.startticktime;
    }
    
    return level.radiation.spreadingticktime;
}

// Namespace br_dmz_radiation
// Params 0, eflags: 0x4
// Checksum 0xdf31849e, Offset: 0x25f0
// Size: 0x36
function private function_ef8f7b438c7461cf()
{
    level.radiation.damageindex = int( min( level.radiation.damageindex + 1, 1 ) );
}

// Namespace br_dmz_radiation
// Params 3
// Checksum 0xae658541, Offset: 0x262e
// Size: 0xe5
function function_dbc797328684c90a( goalorigin, goalradius, var_10ee0d9c7ea1bf71 )
{
    level.radiation.goalorigin = goalorigin;
    level.radiation.goalradius = goalradius;
    level.radiation.var_10ee0d9c7ea1bf71 = var_10ee0d9c7ea1bf71;
    level.radiation.startorigin = level.radiation.origin;
    level.radiation.startradius = level.radiation.radius;
    level.radiation.var_db54a59dbb2fd9c6 = 0;
    level.radiation.brcircle brcirclemoveto( goalorigin[ 0 ], goalorigin[ 1 ], goalradius, var_10ee0d9c7ea1bf71 );
}

// Namespace br_dmz_radiation
// Params 1
// Checksum 0xa48c22d9, Offset: 0x271b
// Size: 0x7a
function function_65d76fea2064eed3( pos )
{
    topos = distance2d( pos, level.radiation.startorigin );
    circlespeed = ( level.radiation.finalradius - level.radiation.origin ) / level.radiation.expansionseconds;
    return topos / circlespeed;
}

// Namespace br_dmz_radiation
// Params 0
// Checksum 0x5cb3f901, Offset: 0x279e
// Size: 0x3d
function radiation_getspeed()
{
    return ( level.radiation.finalradius - level.radiation.startradius ) / level.radiation.expansionseconds;
}

// Namespace br_dmz_radiation
// Params 0, eflags: 0x4
// Checksum 0x39ed5c4b, Offset: 0x27e4
// Size: 0x185
function private function_f0d736907f5e44b8()
{
    if ( !( isdefined( level.radiation.var_10ee0d9c7ea1bf71 ) && isdefined( level.radiation.var_db54a59dbb2fd9c6 ) ) || level.radiation.var_db54a59dbb2fd9c6 > level.radiation.var_10ee0d9c7ea1bf71 )
    {
        return;
    }
    
    var_2a3e3cd9e468e753 = level.radiation.var_db54a59dbb2fd9c6 / level.radiation.var_10ee0d9c7ea1bf71;
    
    if ( isdefined( level.radiation.goalorigin ) && isdefined( level.radiation.startorigin ) )
    {
        radiation_setorigin( vectorlerp( level.radiation.startorigin, level.radiation.goalorigin, var_2a3e3cd9e468e753 ) );
    }
    
    if ( isdefined( level.radiation.goalradius ) && isdefined( level.radiation.startradius ) )
    {
        radiation_setradius( math::lerp( level.radiation.startradius, level.radiation.goalradius, var_2a3e3cd9e468e753 ) );
    }
    
    level.radiation.var_db54a59dbb2fd9c6 += level.framedurationseconds;
}

// Namespace br_dmz_radiation
// Params 0, eflags: 0x4
// Checksum 0x4c380766, Offset: 0x2971
// Size: 0xdb
function private function_3be2e50aa17afad2()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( level.supportsai && ( level.radiation.spreading || level.radiation.forcefleeing ) )
        {
            randomagents = arrayrandomize( level.agentarray );
            
            for ( i = 0; i < randomagents.size ; i++ )
            {
                if ( i % 3 == 0 )
                {
                    waitframe();
                }
                
                agent = randomagents[ i ];
                
                if ( isdefined( agent.origin ) && isalive( agent ) && function_683a362ee7b1f144( agent.origin ) )
                {
                    function_ee572babb6cb354e( agent );
                }
            }
            
            wait 5;
            continue;
        }
        
        wait 5;
    }
}

// Namespace br_dmz_radiation
// Params 1, eflags: 0x4
// Checksum 0x930b696a, Offset: 0x2a54
// Size: 0xb2
function private function_ee572babb6cb354e( agent )
{
    var_7f2f00fe8d082f79 = function_3827aacd82c97450( agent.origin ) * 2000;
    fleepoint = agent.origin - ( var_7f2f00fe8d082f79[ 0 ], var_7f2f00fe8d082f79[ 1 ], 0 );
    var_ac64b3fac8362235 = getclosestpointonnavmesh( fleepoint );
    
    if ( length( fleepoint - var_ac64b3fac8362235 ) > 1000 )
    {
        if ( agent_utility::iscivilian( agent ) )
        {
            agent function_2bb28ccf461c72ce( "systemic", 0 );
        }
        
        return;
    }
    
    if ( agent_utility::iscivilian( agent ) )
    {
        agent function_2bb28ccf461c72ce( "script", 1 );
    }
    
    thread ai_behavior::behavior_combatRushOrigin( agent, var_ac64b3fac8362235, undefined, undefined, undefined, undefined, undefined, undefined, &utility::empty_init_func );
}

// Namespace br_dmz_radiation
// Params 0, eflags: 0x4
// Checksum 0x338803c4, Offset: 0x2b0e
// Size: 0x136
function private function_36f8099d609ce1d3()
{
    foreach ( player in level.players )
    {
        if ( !player || !player.origin )
        {
            continue;
        }
        
        var_dbfe2491a02c8fe3 = player.var_cca8507a7e7d424c;
        player.var_cca8507a7e7d424c = radiation_isinradiation( player.origin );
        
        if ( player.var_cca8507a7e7d424c && !var_dbfe2491a02c8fe3 )
        {
            pbgpostfxbundlestart( player, "rex_dmz_tumen_fallout", 1 );
            playfxontagforclients( utility::getfx( "radiation_player" ), player, "tag_eye", player );
            continue;
        }
        
        if ( !player.var_cca8507a7e7d424c && var_dbfe2491a02c8fe3 )
        {
            pbgpostfxbundleend( player, "rex_dmz_tumen_fallout", 1 );
            stopfxontag( utility::getfx( "radiation_player" ), player, "tag_eye" );
        }
    }
}

// Namespace br_dmz_radiation
// Params 0, eflags: 0x4
// Checksum 0xf31fe94d, Offset: 0x2c4c
// Size: 0xd0
function private function_f9cb4b99c68f31c5()
{
    foreach ( player in level.players )
    {
        if ( isdefined( player ) && isdefined( player.origin ) && gasmask::hasgasmask( player ) && !player.gasmaskswapinprogress )
        {
            if ( player.var_cca8507a7e7d424c )
            {
                player item_gasmask::gasmaskon( "radiation" );
                continue;
            }
            
            player item_gasmask::gasmaskoff( "radiation" );
        }
    }
}

// Namespace br_dmz_radiation
// Params 1
// Checksum 0x672b6600, Offset: 0x2d24
// Size: 0x49
function radiation_onplayerspawn( player )
{
    if ( radiation_isinit() )
    {
        level.radiation.listeningplayers[ level.radiation.listeningplayers.size ] = player;
        player thread function_edc05123ca39b2be();
    }
}

// Namespace br_dmz_radiation
// Params 0, eflags: 0x4
// Checksum 0x33b67ccb, Offset: 0x2d75
// Size: 0x72
function private function_edc05123ca39b2be()
{
    self endon( #"disconnect" );
    
    while ( true )
    {
        if ( self.extracted )
        {
            return;
        }
        
        if ( radiation_isinit() && player::isreallyalive( self ) )
        {
            var_d115d616d41feef5 = function_518cd2f925cd2215( self.origin );
            
            if ( isdefined( var_d115d616d41feef5 ) )
            {
                self playlocalsound( "dmz_geiger_counter_tick" );
                wait var_d115d616d41feef5;
            }
            else
            {
                wait 1;
            }
            
            continue;
        }
        
        wait 1;
    }
}

// Namespace br_dmz_radiation
// Params 1, eflags: 0x4
// Checksum 0x49259c64, Offset: 0x2def
// Size: 0xc9
function private function_518cd2f925cd2215( testorigin )
{
    var_dbc1c8b8cc0d9fad = function_d86e95e1a0959d75( testorigin );
    
    if ( var_dbc1c8b8cc0d9fad < level.radiation.var_ce359c80cfe647dd )
    {
        return randomfloatrange( 0.05, 0.2 );
    }
    
    if ( var_dbc1c8b8cc0d9fad < level.radiation.var_5cc3a61b59ba287e )
    {
        return randomfloatrange( 0.1, 0.25 );
    }
    
    if ( var_dbc1c8b8cc0d9fad < level.radiation.var_1a274f0c46c2a72e )
    {
        return randomfloatrange( 0.15, 0.45 );
    }
    
    if ( var_dbc1c8b8cc0d9fad < level.radiation.var_eeb1c776c812ff51 )
    {
        return randomfloatrange( 0.3, 1.2 );
    }
}

// Namespace br_dmz_radiation
// Params 0
// Checksum 0xf6109c54, Offset: 0x2ec1
// Size: 0x81
function geiger_init()
{
    foreach ( player in level.players )
    {
        if ( isdefined( player ) )
        {
            player thread function_edc05123ca39b2be();
        }
    }
}

// Namespace br_dmz_radiation
// Params 2, eflags: 0x4
// Checksum 0x9500109a, Offset: 0x2f4a
// Size: 0xef
function private function_2dbc6a29da40df6b( origin, nodes )
{
    if ( !isdefined( origin ) )
    {
        return;
    }
    
    mindist = undefined;
    
    foreach ( node in nodes )
    {
        dist = undefined;
        
        if ( isvector( node ) )
        {
            dist = distance2d( node, origin );
        }
        else if ( isdefined( node.origin ) )
        {
            dist = distance2d( node.origin, origin );
        }
        
        if ( isdefined( dist ) && ( !isdefined( mindist ) || dist < mindist ) )
        {
            mindist = dist;
        }
    }
    
    return mindist;
}

// Namespace br_dmz_radiation
// Params 0
// Checksum 0xd5b2fcc7, Offset: 0x3042
// Size: 0x1f
function radiation_getorigin()
{
    if ( radiation_isinit() )
    {
        return level.radiation.origin;
    }
}

// Namespace br_dmz_radiation
// Params 0
// Checksum 0xd5b2fcc7, Offset: 0x3069
// Size: 0x1f
function radiation_getradius()
{
    if ( radiation_isinit() )
    {
        return level.radiation.radius;
    }
}

// Namespace br_dmz_radiation
// Params 1, eflags: 0x4
// Checksum 0x7637d1e0, Offset: 0x3090
// Size: 0x44
function private radiation_setorigin( origin )
{
    level.radiation game_utility::questcircle_move( origin );
    level.radiation.origin = origin;
    
    if ( bots_util::function_deef484b5b3a3977() )
    {
        function_43b6dfcc9da279b5( origin );
    }
}

// Namespace br_dmz_radiation
// Params 1, eflags: 0x4
// Checksum 0xa358d686, Offset: 0x30dc
// Size: 0x1d9
function private radiation_setradius( radius )
{
    level.radiation game_utility::function_d46d8731ed9d281( radius );
    level.radiation.radius = radius;
    level.radiation.var_730f7c98d9d8639c = level.radiation.radius * 0.9;
    level.radiation.var_26ae2b38064f957f = level.radiation.radius * 0.75;
    level.radiation.var_8387e7e2027b1414 = level.radiation.radius * 0.9;
    level.radiation.var_6a7f799b4609193f = level.radiation.radius * 1.25;
    level.radiation.var_eeb1c776c812ff51 = level.radiation.radius * 1.4;
    level.radiation.var_1a274f0c46c2a72e = level.radiation.radius * 1.15;
    level.radiation.var_5cc3a61b59ba287e = level.radiation.radius * 1;
    level.radiation.var_ce359c80cfe647dd = level.radiation.radius * 0.3;
    level.radiation.var_67b539d1853b7804 = level.radiation.radius * 1.3;
    
    if ( bots_util::function_deef484b5b3a3977() )
    {
        function_c8f10ccbb44850a9( radius );
    }
}

// Namespace br_dmz_radiation
// Params 1, eflags: 0x4
// Checksum 0x65b66739, Offset: 0x32bd
// Size: 0x50, Type: bool
function private function_683a362ee7b1f144( testorigin )
{
    var_8e5bfcdfcdd99c48 = function_d86e95e1a0959d75( testorigin );
    return var_8e5bfcdfcdd99c48 < level.radiation.var_6a7f799b4609193f && var_8e5bfcdfcdd99c48 > level.radiation.var_8387e7e2027b1414;
}

// Namespace br_dmz_radiation
// Params 1
// Checksum 0x562b54ea, Offset: 0x3316
// Size: 0x32, Type: bool
function radiation_isinradiation( testorigin )
{
    return radiation_isinit() && function_d86e95e1a0959d75( testorigin ) < level.radiation.radius;
}

// Namespace br_dmz_radiation
// Params 1, eflags: 0x4
// Checksum 0x646d13dc, Offset: 0x3351
// Size: 0x28, Type: bool
function private function_f5ac3b7fc04ec78b( testorigin )
{
    return function_d86e95e1a0959d75( testorigin ) < level.radiation.var_730f7c98d9d8639c;
}

// Namespace br_dmz_radiation
// Params 1, eflags: 0x4
// Checksum 0x49ebd6fd, Offset: 0x3382
// Size: 0x28, Type: bool
function private function_88d11da785d1901c( testorigin )
{
    return function_d86e95e1a0959d75( testorigin ) < level.radiation.var_26ae2b38064f957f;
}

// Namespace br_dmz_radiation
// Params 1, eflags: 0x4
// Checksum 0x9d0006f3, Offset: 0x33b3
// Size: 0x28, Type: bool
function private function_a66a5ec0f619cbba( testorigin )
{
    return function_d86e95e1a0959d75( testorigin ) < level.radiation.var_67b539d1853b7804;
}

// Namespace br_dmz_radiation
// Params 1
// Checksum 0xa059dca2, Offset: 0x33e4
// Size: 0x3b
function function_704454416dce7454( testorigin )
{
    if ( radiation_isinit() )
    {
        return ( function_d86e95e1a0959d75( testorigin ) < level.radiation.radius + 1500 );
    }
    
    return 0;
}

// Namespace br_dmz_radiation
// Params 1
// Checksum 0x5c9d47a7, Offset: 0x3427
// Size: 0x25
function function_d86e95e1a0959d75( testorigin )
{
    return distance2d( testorigin, level.radiation.origin );
}

// Namespace br_dmz_radiation
// Params 1
// Checksum 0x7639dca7, Offset: 0x3455
// Size: 0x39
function radiation_signeddistancefromradiationcircle( origin )
{
    return distance2d( origin, level.radiation.origin ) - level.radiation.radius;
}

// Namespace br_dmz_radiation
// Params 1, eflags: 0x4
// Checksum 0xaa15b9e6, Offset: 0x3497
// Size: 0x26
function private function_3827aacd82c97450( origin )
{
    return vectornormalize( level.radiation.origin - origin );
}

// Namespace br_dmz_radiation
// Params 1, eflags: 0x4
// Checksum 0x6f45bbbd, Offset: 0x34c6
// Size: 0x15d
function private function_1d522599bbf4333f( points )
{
    minx = undefined;
    maxx = undefined;
    miny = undefined;
    maxy = undefined;
    
    foreach ( point in points )
    {
        if ( !isdefined( minx ) || point.origin[ 0 ] < minx )
        {
            minx = point.origin[ 0 ];
        }
        
        if ( !isdefined( maxx ) || point.origin[ 0 ] > maxx )
        {
            maxx = point.origin[ 0 ];
        }
        
        if ( !isdefined( miny ) || point.origin[ 1 ] < miny )
        {
            miny = point.origin[ 1 ];
        }
        
        if ( !isdefined( maxy ) || point.origin[ 1 ] > maxy )
        {
            maxy = point.origin[ 1 ];
        }
    }
    
    return ( ( minx + maxx ) / 2, ( miny + maxy ) / 2, 0 );
}

// Namespace br_dmz_radiation
// Params 1
// Checksum 0x1646e734, Offset: 0x362c
// Size: 0x38, Type: bool
function function_bc37e528e1300e88( origin )
{
    if ( radiation_isinit() )
    {
        return radiation_isinradiation( origin );
    }
    else if ( isdefined( level.br_circle ) )
    {
        return br_circle::function_6bf5d4e680297398( origin );
    }
    
    return false;
}

// Namespace br_dmz_radiation
// Params 0
// Checksum 0x725c37ab, Offset: 0x366d
// Size: 0x16, Type: bool
function radiation_isinit()
{
    return isdefined( level.radiation.origin );
}

/#

    // Namespace br_dmz_radiation
    // Params 0, eflags: 0x4
    // Checksum 0xed969863, Offset: 0x368c
    // Size: 0x81, Type: dev
    function private radiation_initdebug()
    {
        level endon( #"game_ended" );
        setdevdvarifuninitialized( @"hash_f16cecac3eb08047", 0 );
        
        while ( true )
        {
            waitframe();
            
            if ( getdvarint( @"hash_bf14650f22fd02ae", 0 ) != 0 )
            {
                setdvar( @"hash_bf14650f22fd02ae", 0 );
                radiation_spawnwarhead();
            }
            
            if ( getdvarint( @"hash_f16cecac3eb08047", 0 ) != 0 )
            {
                break;
            }
        }
        
        if ( !radiation_isinit() )
        {
            radiation_spawn();
        }
        
        level thread radiation_startspread();
    }

#/
