// script_45dbfb1869cdd1bd  (hash_45dbfb1869cdd1bd.gscc) (size: 11484 Bytes / 0x2cdc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x81706597 (2171626903)
// size ...... 11484 (0x2cdc)
// includes .. 10  (offset: 0x2ba8)
// strings ... 15  (offset: 0x2bf8)
// dev strs .. 3   (offset: 0x2cb8)
// exports ... 21  (offset: 0x1d68)
// cseg ...... 0x140 + 0x1c28 (0x1d68)
// imports ... 95  (offset: 0x20b0)
// animtree1 . 0   (offset: 0x2cdc)
// animtree2 . 0   (offset: 0x2cdc)
#using scripts\common\callbacks;
#using scripts\common\objective_marker_bundle_helper;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outofbounds;

#namespace collectibles;

// Namespace collectibles
// Params 0
// Checksum 0xfdf77e72, Offset: 0x15e
// Size: 0x293
function initialize()
{
    if ( is_initialized() )
    {
        return;
    }
    
    level.collectiblesettings = game_utility_mp::function_4b7180ed8c2e9742( #"collectiblesettings" );
    
    if ( !level.collectiblesettings )
    {
        /#
            logstring( "<dev string:x24>" );
        #/
        
        return;
    }
    
    /#
        foreach ( player in level.players )
        {
            player thread function_490f3f817e8891e7();
        }
    #/
    
    if ( isdefined( level.collectiblesettings.var_2fd5c58d0c9eb6e ) )
    {
        level.collectiblesettings.var_a2252c4dc1aa3d27 = loadfxasset( level.collectiblesettings.var_2fd5c58d0c9eb6e );
    }
    
    level.collectiblestates = level.collectiblesettings.collectiblestates;
    level.var_30bdacd8f962e346 = [];
    
    foreach ( entry in level.collectiblestates )
    {
        entry.objective_marker_bundle = getscriptbundle( entry.collectibleobjectivemarker );
        assert( isdefined( entry.objective_marker_bundle ), "<dev string:x63>" );
        level.var_30bdacd8f962e346[ level.var_30bdacd8f962e346.size ] = entry;
    }
    
    level.var_2df58d5d9e559c3a = 1;
    level.dropsettings = level.collectiblesettings.var_89590c3749323ab6;
    level.droptable = level.collectiblesettings.var_606422063791a49;
    initializematchrules();
    callback::add( #"player_death", &drop_collectible );
    callback::add( #"player_disconnect", &on_player_disconnect );
    callback::add( #"player_spawned", &on_player_spawned );
    callback::add( #"player_laststand_bleedout", &drop_collectible );
    scriptable::scriptable_addautousecallback( &function_134fa03e177911ad );
    
    /#
        thread function_e380a8b0f7c840f7();
    #/
}

/#

    // Namespace collectibles
    // Params 0, eflags: 0x4
    // Checksum 0x9d1f944f, Offset: 0x3f9
    // Size: 0x67, Type: dev
    function private function_e380a8b0f7c840f7()
    {
        setdevdvar( @"hash_a36d68ee99ba8cf1", 0 );
        
        while ( true )
        {
            dropamount = getdvarint( @"hash_a36d68ee99ba8cf1", 0 );
            
            if ( dropamount > 0 )
            {
                setdevdvar( @"hash_a36d68ee99ba8cf1", dropamount );
                level.var_a357393ed9ac1d2e = 1;
                level.var_275123773408c917 = dropamount;
            }
            
            waitframe();
        }
    }

#/

// Namespace collectibles
// Params 0, eflags: 0x4
// Checksum 0xa803df05, Offset: 0x468
// Size: 0x47
function private initializematchrules()
{
    level.var_e7cd2941049099ff = getmatchrulesdata( "collectibleData", "maximumCollectibleAmount" );
    level.var_a357393ed9ac1d2e = getmatchrulesdata( "collectibleData", "collectiblePercentageDrop" );
    level.var_2b573b265cd0ff16 = getmatchrulesdata( "collectibleData", "maximumCollectibleDropAmount" );
}

// Namespace collectibles
// Params 1
// Checksum 0xbeb34513, Offset: 0x4b7
// Size: 0x15
function function_f446332abac7cf0b( collectible )
{
    thread cleanup_collectible( collectible );
}

// Namespace collectibles
// Params 0
// Checksum 0xb5cbe064, Offset: 0x4d4
// Size: 0xc, Type: bool
function is_initialized()
{
    return isdefined( level.collectiblesettings );
}

// Namespace collectibles
// Params 1, eflags: 0x4
// Checksum 0xc14449f7, Offset: 0x4e9
// Size: 0x15e, Type: bool
function private should_drop_collectible( death_data )
{
    if ( death_data.victim.switching_teams )
    {
        return false;
    }
    
    if ( level.collectiblesettings.var_7734a6c56af4b2ae )
    {
        if ( death_data.victim == death_data.attacker && death_data.victim.collectible_amount != 0 )
        {
            return true;
        }
    }
    
    if ( death_data.victim == death_data.attacker )
    {
        return false;
    }
    
    if ( level.teambased && death_data.victim.team == death_data.attacker.team )
    {
        return false;
    }
    
    if ( isdefined( death_data.attacker ) && !isdefined( death_data.attacker.team ) && ( death_data.attacker.classname == "trigger_hurt" || death_data.attacker.classname == "worldspawn" ) )
    {
        return false;
    }
    
    if ( teams::getteamdata( death_data.victim.team, "noRespawns" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace collectibles
// Params 1, eflags: 0x4
// Checksum 0x15693287, Offset: 0x650
// Size: 0x4d
function private on_player_spawned( params )
{
    if ( isplayer( params.player ) )
    {
        if ( !isdefined( params.player.collectible_amount ) )
        {
            params.player.collectible_amount = 0;
        }
    }
}

// Namespace collectibles
// Params 2
// Checksum 0xa69c4356, Offset: 0x6a5
// Size: 0x306
function drop_collectible( death_data, var_e0c0b81b0bd2ad21 )
{
    if ( !should_drop_collectible( death_data ) )
    {
        return;
    }
    
    var_46063ece3767f60b = ( death_data.victim.origin[ 0 ], death_data.victim.origin[ 1 ], death_data.victim.origin[ 2 ] + 32 );
    death_angles = death_data.victim getplayerangles( 1 );
    victim = death_data.victim;
    attacker = death_data.attacker;
    var_413d3e7a01d5cb63 = level.collectiblesettings.var_349c1451a75d5f41;
    var_8a412b88e6547fd6 = 1;
    collectible_amount = 1;
    
    if ( var_e0c0b81b0bd2ad21 > 0 || victim.collectible_amount > 0 )
    {
        if ( !isdefined( var_e0c0b81b0bd2ad21 ) && victim.collectible_amount > 0 )
        {
            var_e0c0b81b0bd2ad21 = victim.collectible_amount;
        }
        
        var_40e41020c42e267a = level.var_a357393ed9ac1d2e;
        
        if ( isdefined( level.var_d6796e1f607dbae4 ) )
        {
            var_40e41020c42e267a = level.var_d6796e1f607dbae4;
        }
        
        if ( death_data.meansofdeath == "MOD_DISCONNECTED" )
        {
            var_40e41020c42e267a = 1;
        }
        
        /#
            if ( level.var_275123773408c917 > 0 )
            {
                var_9afaa0c09341a192 = level.var_275123773408c917;
            }
        #/
        
        var_9afaa0c09341a192 = int( ceil( var_e0c0b81b0bd2ad21 * var_40e41020c42e267a ) );
        
        if ( var_9afaa0c09341a192 > level.var_a508e8e6aba000e4 )
        {
            var_9afaa0c09341a192 = level.var_a508e8e6aba000e4;
        }
        else if ( var_9afaa0c09341a192 > level.var_2b573b265cd0ff16 && level.var_2b573b265cd0ff16 > 0 )
        {
            var_9afaa0c09341a192 = level.var_2b573b265cd0ff16;
        }
        
        var_e0c0b81b0bd2ad21 -= var_9afaa0c09341a192;
        
        if ( victim.collectible_amount > 0 )
        {
            victim.collectible_amount = var_e0c0b81b0bd2ad21;
        }
        
        death_data.victim.collectible_dropped = var_9afaa0c09341a192;
        var_9afaa0c09341a192 += level.var_2df58d5d9e559c3a;
        
        if ( var_9afaa0c09341a192 > var_413d3e7a01d5cb63 )
        {
            if ( var_9afaa0c09341a192 % level.collectiblesettings.var_349c1451a75d5f41 != 0 )
            {
                var_dd41251da92f86c8 = int( var_9afaa0c09341a192 % level.collectiblesettings.var_349c1451a75d5f41 );
                var_9afaa0c09341a192 -= var_dd41251da92f86c8;
                var_9afaa0c09341a192 = int( var_9afaa0c09341a192 );
                function_124a177b5e127263( var_46063ece3767f60b, death_angles, victim, attacker, var_dd41251da92f86c8 );
            }
            
            collectible_amount = int( var_9afaa0c09341a192 / level.collectiblesettings.var_349c1451a75d5f41 );
            var_8a412b88e6547fd6 = level.collectiblesettings.var_349c1451a75d5f41;
        }
        else
        {
            var_8a412b88e6547fd6 = var_9afaa0c09341a192;
            collectible_amount = level.var_2df58d5d9e559c3a;
        }
    }
    
    for ( collectiblecount = var_8a412b88e6547fd6; collectiblecount > 0 ; collectiblecount-- )
    {
        function_124a177b5e127263( var_46063ece3767f60b, death_angles, victim, attacker, collectible_amount );
    }
    
    return var_e0c0b81b0bd2ad21;
}

// Namespace collectibles
// Params 6, eflags: 0x4
// Checksum 0x3740518c, Offset: 0x9b4
// Size: 0x43a
function private function_124a177b5e127263( var_46063ece3767f60b, death_angles, victim, attacker, var_f55202e58c76bbda, var_420b8740fe343c79 )
{
    collectible = { #collectible_amount:var_f55202e58c76bbda };
    start_position = var_46063ece3767f60b;
    angles = death_angles;
    
    if ( ( isdefined( level.callbacks[ #"hash_fa13fb8d394a27" ] ) || isdefined( level.callbacks[ #"hash_fa13fb8d394a27" ] ) ) && isdefined( victim ) )
    {
        return_params = level callback::response( 7, #"hash_fa13fb8d394a27", { #angles:angles, #start_position:start_position, #player:victim } );
        start_position = return_params.start_position;
        end_position = return_params.end_position;
        angles = return_params.angles;
    }
    else
    {
        randomangle = ( 0, randomfloat( 360 ), 0 );
        randomdir = anglestoforward( randomangle );
        randomdst = randomfloatrange( 30, 50 );
        goal_position = start_position + randomdst * randomdir;
        start_position = playerphysicstrace( start_position, goal_position );
        end_position = utility::drop_to_ground( start_position, 0 );
    }
    
    var_77dcf432047cb49c = [ #"teamselect", victim.team == "axis" ? 1 : 2 ];
    gravity_arc_payload = calcscriptablepayloadgravityarc( start_position, end_position );
    collectible.scriptable = spawnscriptable( level.collectiblesettings.scriptable, start_position, angles, undefined, var_77dcf432047cb49c, gravity_arc_payload );
    collectible.scriptable.collectible = collectible;
    collectible.owner = victim;
    collectible.attacker = attacker;
    collectible.index = gettime();
    collectible.origin = start_position;
    collectible.curorigin = collectible.origin;
    collectible.interactteam = "any";
    
    if ( victim.team == "allies" )
    {
        bundle_name = level.collectiblesettings.alliesobjectivemarker;
        
        if ( isdefined( bundle_name ) )
        {
            collectible.objective_id = objective_marker_bundle_helper::function_d98e9d627f2d8c28( bundle_name, 1 );
        }
    }
    else
    {
        bundle_name = level.collectiblesettings.axisobjectivemarker;
        
        if ( isdefined( bundle_name ) )
        {
            collectible.objective_id = objective_marker_bundle_helper::function_d98e9d627f2d8c28( bundle_name, 1 );
        }
    }
    
    if ( level.var_30bdacd8f962e346.size > 0 )
    {
        set_collectible_state( collectible );
    }
    
    wait 0.05;
    
    if ( isdefined( collectible.objective_id ) )
    {
        objidpoolmanager::update_objective_position( collectible.objective_id, end_position );
    }
    
    if ( !isdefined( level.collectibles ) )
    {
        level.collectibles = [];
    }
    
    level.collectibles[ collectible.index ] = collectible;
    
    if ( isdefined( victim ) )
    {
        if ( !isdefined( victim.collectibles ) )
        {
            victim.collectibles = [];
        }
        
        victim.collectibles[ collectible.index ] = collectible;
    }
    
    start_blink_time = !outofbounds::ispointinoutofbounds( end_position ) ? level.collectiblesettings.lifetimeseconds : 5;
    
    if ( level.collectiblesettings.lifetimeseconds != -1 )
    {
        thread function_a02e3a786a2f0666( collectible, start_blink_time );
    }
    
    level notify( #"hash_89391d390b578c05", collectible );
    var_b19ce51dfc12b7f8 = { #collectible:collectible, #collectible_amount:collectible.collectible_amount, #player:collectible.owner, #spawn_origin:end_position };
    callback::callback( #"collectible_on_spawned", var_b19ce51dfc12b7f8 );
}

// Namespace collectibles
// Params 1, eflags: 0x4
// Checksum 0x9bfec3a1, Offset: 0xdf6
// Size: 0x164
function private set_collectible_state( collectible )
{
    if ( collectible.collectible_amount <= 0 )
    {
        return;
    }
    
    statestruct = undefined;
    
    foreach ( var_553d0337b1359de5 in level.var_30bdacd8f962e346 )
    {
        if ( collectible.collectible_amount >= var_553d0337b1359de5.var_2f4aea2c0063bca0 && collectible.collectible_amount <= var_553d0337b1359de5.var_afbabc574c1ce4b2 )
        {
            statestruct = var_553d0337b1359de5;
            break;
        }
    }
    
    assert( isdefined( statestruct ), "<dev string:xa7>" );
    
    if ( !isdefined( collectible.objective_id ) && isdefined( statestruct.objective_marker_bundle ) )
    {
        collectible.objective_id = request_objective_id( statestruct.objective_marker_bundle );
    }
    
    collectible.scriptable setscriptablepartstate( statestruct.var_2e697d8e699e2612, statestruct.var_6d73660aae6be610 );
    collectible.scriptable setscriptablepartstate( "visibility", "show" );
}

// Namespace collectibles
// Params 1, eflags: 0x4
// Checksum 0x4b33ab67, Offset: 0xf62
// Size: 0xef
function private cleanup_collectible( collectible )
{
    collectible notify( #"cleanup_collectible" );
    waitframe();
    
    if ( isdefined( collectible.objective_id ) )
    {
        return_objective_id( collectible.objective_id );
        collectible.objective_id = undefined;
    }
    
    if ( isdefined( collectible.scriptable ) )
    {
        collectible.scriptable freescriptable();
    }
    
    if ( isdefined( collectible.owner ) && isdefined( collectible.owner.collectibles[ collectible.index ] ) )
    {
        collectible.owner.collectibles[ collectible.index ] = undefined;
    }
    
    if ( isdefined( collectible ) && isdefined( level.collectibles[ collectible.index ] ) )
    {
        level.collectibles[ collectible.index ] = undefined;
    }
}

// Namespace collectibles
// Params 2, eflags: 0x4
// Checksum 0xc77e811e, Offset: 0x1059
// Size: 0x117
function private function_a02e3a786a2f0666( collectible, wait_time_sec )
{
    collectible notify( #"hash_e8d18d80d30fb3af" );
    level endon( #"game_ended" );
    collectible endon( #"cleanup_collectible" );
    collectible endon( #"hash_e8d18d80d30fb3af" );
    wait_time_sec = int( wait_time_sec );
    
    if ( wait_time_sec > 10 )
    {
        wait wait_time_sec - 10;
        wait_time_sec = 10;
    }
    
    if ( wait_time_sec > 5 )
    {
        collectible.scriptable setscriptablepartstate( #"slow_blink", #"enable", 1 );
        wait wait_time_sec - 5;
        collectible.scriptable setscriptablepartstate( #"slow_blink", #"disable", 1 );
        wait_time_sec = 5;
    }
    
    if ( wait_time_sec > 0 )
    {
        collectible.scriptable setscriptablepartstate( #"fast_blink", #"enable", 1 );
        wait wait_time_sec;
        collectible.scriptable setscriptablepartstate( #"fast_blink", #"disable", 1 );
    }
    
    thread cleanup_collectible( collectible );
}

// Namespace collectibles
// Params 6, eflags: 0x4
// Checksum 0x56172ed3, Offset: 0x1178
// Size: 0x1f8
function private function_134fa03e177911ad( instance, part, state, player, is_auto_use, var_fda8287cd15b107f )
{
    if ( level.gameended )
    {
        return;
    }
    
    if ( getdvarint( @"hash_3cb8bd34a0cf7cea", 0 ) == 1 )
    {
        return;
    }
    
    if ( !( part == #"usability" && state == #"hash_47251da8b29ed9aa" ) || instance.collectible.is_collected )
    {
        return;
    }
    
    if ( !isplayer( player ) || !player::isreallyalive( player ) )
    {
        return;
    }
    
    if ( isdefined( level.canusecollectible ) && ![[ level.canusecollectible ]]( player ) )
    {
        return;
    }
    
    if ( level.var_e7cd2941049099ff > 0 )
    {
        if ( player.collectible_amount + instance.collectible.collectible_amount > level.var_e7cd2941049099ff )
        {
            if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
            {
                player [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( level.collectiblesettings.var_410be59e320679b2 );
                return;
            }
        }
    }
    
    collectible = instance.collectible;
    collectible.is_collected = 1;
    
    if ( collectible.owner.team == player.team )
    {
        function_716023d1906c266d( collectible, player );
    }
    else
    {
        function_b0e63d4f194c1726( collectible, player );
    }
    
    if ( isdefined( level.collectiblesettings.var_a2252c4dc1aa3d27 ) )
    {
        playfx( level.collectiblesettings.var_a2252c4dc1aa3d27, collectible.curorigin );
    }
    
    cleanup_collectible( collectible );
}

// Namespace collectibles
// Params 2, eflags: 0x4
// Checksum 0x5f5fee91, Offset: 0x1378
// Size: 0x10f
function private function_716023d1906c266d( collectible, player )
{
    if ( collectible.owner == player )
    {
        if ( isdefined( level.collectiblesettings.var_cc5368caf768e19b ) )
        {
            player thread points::doscoreevent( level.collectiblesettings.var_cc5368caf768e19b );
        }
    }
    else if ( isdefined( level.collectiblesettings.var_24dfed9aefaba297 ) )
    {
        player thread points::doscoreevent( level.collectiblesettings.var_24dfed9aefaba297 );
    }
    
    if ( isdefined( collectible.attacker ) )
    {
        if ( isdefined( level.collectiblesettings.var_d0e316c79509cf59 ) )
        {
            collectible.attacker thread points::doscoreevent( level.collectiblesettings.var_d0e316c79509cf59 );
        }
    }
    
    var_b19ce51dfc12b7f8 = { #collectible:collectible, #player:player };
    callback::callback( #"hash_64d5ef3aec7665f8", var_b19ce51dfc12b7f8 );
}

// Namespace collectibles
// Params 2, eflags: 0x4
// Checksum 0xc8b86c4f, Offset: 0x148f
// Size: 0xe3
function private function_b0e63d4f194c1726( collectible, player )
{
    if ( isdefined( level.collectiblesettings.var_63d0fdfe54a77f98 ) )
    {
        player thread points::doscoreevent( level.collectiblesettings.var_63d0fdfe54a77f98 );
    }
    
    if ( isdefined( collectible.attacker ) && collectible.attacker != player )
    {
        if ( isdefined( level.collectiblesettings.var_c556e54b8b506aa2 ) )
        {
            collectible.attacker thread points::doscoreevent( level.collectiblesettings.var_c556e54b8b506aa2 );
        }
    }
    
    thread function_6190a1d34a1b5601( player );
    var_b19ce51dfc12b7f8 = { #collectible:collectible, #player:player };
    callback::callback( #"hash_163ce3e6ccfcab8d", var_b19ce51dfc12b7f8 );
}

// Namespace collectibles
// Params 1, eflags: 0x4
// Checksum 0x49ade899, Offset: 0x157a
// Size: 0x147
function private function_6190a1d34a1b5601( player )
{
    player notify( #"hash_32d772a884552a12" );
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    player endon( #"hash_32d772a884552a12" );
    
    if ( !isdefined( level.collectiblesettings.var_397ba4d13a49ee6 ) )
    {
        return;
    }
    
    if ( !isdefined( player.collectibles_picked_up ) )
    {
        player.collectibles_picked_up = 0;
    }
    
    player.collectibles_picked_up++;
    
    if ( level.scoreeventglobals.var_f6e3d8ceb292ae49 )
    {
        wait level.collectiblesettings.var_77a5d11447623041;
        
        if ( player.collectibles_picked_up >= level.collectiblesettings.var_ff1e8dfee7f4ed57 )
        {
            player thread points::doscoreevent( level.collectiblesettings.var_397ba4d13a49ee6 );
        }
    }
    else
    {
        if ( player.collectibles_picked_up == level.collectiblesettings.var_ff1e8dfee7f4ed57 )
        {
            player thread points::doscoreevent( level.collectiblesettings.var_397ba4d13a49ee6 );
        }
        
        wait level.collectiblesettings.var_77a5d11447623041;
    }
    
    player.collectibles_picked_up = undefined;
}

// Namespace collectibles
// Params 1
// Checksum 0x9eb07503, Offset: 0x16c9
// Size: 0x4fd
function request_objective_id( objective_marker_bundle )
{
    objective_id = objidpoolmanager::requestobjectiveid();
    objective_marker_bundle_helper::function_aded78d14325f551();
    generalsettings = objective_marker_bundle.generalsettings;
    minimapsettings = objective_marker_bundle.minimapsettings;
    tacmapsettings = objective_marker_bundle.tacmapsettings;
    compasssettings = objective_marker_bundle.compasssettings;
    hudsettings = objective_marker_bundle.hudsettings;
    minimapsettings = objective_marker_bundle.minimapsettings;
    tacmapsettings = objective_marker_bundle.tacmapsettings;
    compasssettings = objective_marker_bundle.compasssettings;
    hudsettings = objective_marker_bundle.hudsettings;
    objective_setpulsate( objective_id, hudsettings.shouldpulsate );
    objective_setshowprogress( objective_id, hudsettings.showprogressbar );
    objective_setplayintro( objective_id, hudsettings.var_f779b90197fe825b );
    objective_setplayoutro( objective_id, hudsettings.var_b211cd4ac71330ce );
    objective_setshowdistance( objective_id, hudsettings.showdistance );
    objective_setzoffset( objective_id, hudsettings.zoffset );
    
    if ( isdefined( hudsettings.var_ee7bc8b53cebd37e ) && hudsettings.var_1e1ecace3b3c2a63 > 0 && hudsettings.var_ee7bc8b53cebd37e > 0 )
    {
        function_ac9886e0e2860e18( objective_id, hudsettings.var_1e1ecace3b3c2a63, hudsettings.var_ee7bc8b53cebd37e );
    }
    
    if ( isdefined( hudsettings.hudtext.label ) && hudsettings.hudtext.label != &"" )
    {
        objective_setlabel( objective_id, hudsettings.hudtext.label );
    }
    
    if ( isdefined( hudsettings.hudtext.friendlylabel ) && hudsettings.hudtext.friendlylabel != &"" )
    {
        objective_setfriendlylabel( objective_id, hudsettings.hudtext.friendlylabel );
    }
    
    if ( isdefined( hudsettings.hudtext.enemylabel ) && hudsettings.hudtext.enemylabel != &"" )
    {
        objective_setenemylabel( objective_id, hudsettings.hudtext.enemylabel );
    }
    
    if ( isdefined( hudsettings.hudtext.neutrallabel ) && hudsettings.hudtext.neutrallabel != &"" )
    {
        objective_setneutrallabel( objective_id, hudsettings.hudtext.neutrallabel );
    }
    
    if ( isdefined( hudsettings.hudtext.description ) && hudsettings.hudtext.description != &"" )
    {
        objective_setdescription( objective_id, hudsettings.hudtext.description );
    }
    
    objective_icon( objective_id, generalsettings.var_7aed872ac463b234 );
    objective_state( objective_id, generalsettings.state );
    objective_setisoptional( objective_id, generalsettings.isoptional );
    objective_setownerteam( objective_id, generalsettings.ownerteam );
    backgroundoption = level.var_fdb512e0da2d2fc7.backgroundoptions[ generalsettings.background ];
    objective_setbackground( objective_id, backgroundoption );
    
    if ( isdefined( generalsettings.var_dc10495f590deded ) )
    {
        var_dc10495f590deded = ( 0, 0, 0 );
        var_dc01b6bac8d24e0 = generalsettings.var_dc10495f590deded;
        var_21f669501225774f = strtok( var_dc01b6bac8d24e0, " " );
        
        if ( var_21f669501225774f.size == 4 )
        {
            var_dc10495f590deded = ( float( var_21f669501225774f[ 0 ] ) * 255, float( var_21f669501225774f[ 1 ] ) * 255, float( var_21f669501225774f[ 2 ] ) * 255 );
        }
        
        objective_settint( objective_id, int( var_dc10495f590deded[ 0 ] ), int( var_dc10495f590deded[ 1 ] ), int( var_dc10495f590deded[ 2 ] ) );
    }
    
    objective_setminimapiconsize( objective_id, minimapsettings.minimapsize );
    function_2b8e3d3ae2a6414a( objective_id, minimapsettings.hideonminimap );
    function_44a344c68a68f28d( objective_id, minimapsettings.hideonminimapwhenclipped );
    function_8af0b8f18059cd2( objective_id, minimapsettings.playrevealaniminminimap );
    objective_setrotateonminimap( objective_id, minimapsettings.var_173d6b2a5b0c211f );
    function_59c2c5d8363fbea0( objective_id, tacmapsettings.var_9c62f4aa15e546c5 );
    function_d8515d9148d4388( objective_id, tacmapsettings.var_9b9011be55d95bfd );
    function_382097d8732a0c41( objective_id, tacmapsettings.playrevealanimintacmap );
    objective_sethideelevation( objective_id, tacmapsettings.hideelevation );
    objective_setshowoncompass( objective_id, compasssettings.showoncompass );
    return objective_id;
}

// Namespace collectibles
// Params 1
// Checksum 0x3b1f151, Offset: 0x1bcf
// Size: 0x15
function return_objective_id( objective_id )
{
    objidpoolmanager::returnobjectiveid( objective_id );
}

// Namespace collectibles
// Params 1, eflags: 0x4
// Checksum 0x68d27f08, Offset: 0x1bec
// Size: 0x10d
function private on_player_disconnect( params )
{
    if ( level.collectiblesettings.var_19e2880ebc77874a )
    {
        deathdata = spawnstruct();
        deathdata.victim = self;
        deathdata.attacker = undefined;
        deathdata.meansofdeath = "MOD_DISCONNECTED";
        deathdata.weaponfullstring = "none";
        deathdata.victim drop_collectible( deathdata, deathdata.victim.collectible_amount );
        return;
    }
    
    foreach ( collectible in self.collectibles )
    {
        thread cleanup_collectible( collectible );
    }
}

/#

    // Namespace collectibles
    // Params 0, eflags: 0x4
    // Checksum 0xab6128e4, Offset: 0x1d01
    // Size: 0x67, Type: dev
    function private function_490f3f817e8891e7()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            var_b066a616e995b32e = getdvarint( @"scr_spawn_collectible", 0 );
            
            if ( var_b066a616e995b32e > 0 )
            {
                function_124a177b5e127263( self.origin, self.angles, self, self, var_b066a616e995b32e );
            }
            
            waitframe();
            setdvar( @"scr_spawn_collectible", 0 );
        }
    }

#/
