// script_699d3b456bfdd52f  (hash_699d3b456bfdd52f.gscc) (size: 13532 Bytes / 0x34dc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa407d682 (2751977090)
// size ...... 13532 (0x34dc)
// includes .. 2   (offset: 0x33bc)
// strings ... 19  (offset: 0x33cc)
// dev strs .. 1   (offset: 0x34d0)
// exports ... 38  (offset: 0x23b8)
// cseg ...... 0x1a0 + 0x2218 (0x23b8)
// imports ... 79  (offset: 0x29a8)
// animtree1 . 0   (offset: 0x34dc)
// animtree2 . 0   (offset: 0x34dc)
#using scripts\common\trace;
#using scripts\common\utility;

#namespace namespace_9e3a64b15429f7c9;

// Namespace namespace_9e3a64b15429f7c9
// Params 0
// Checksum 0x59d6604, Offset: 0x1be
// Size: 0x3ce
function input()
{
    closeai = undefined;
    closenode = undefined;
    spawnaimode = level.debug.spawnaimode;
    
    foreach ( ai in spawnaimode.placedais )
    {
        if ( distancesquared( ai.origin, level.debug.cursor_pos ) < 2304 )
        {
            closeai = ai;
            break;
        }
    }
    
    foreach ( enemy in spawnaimode.placedenemies )
    {
        if ( distancesquared( enemy.origin, level.debug.cursor_pos ) < 2304 )
        {
            closeai = enemy;
        }
    }
    
    if ( isdefined( closeai ) )
    {
        highlightent( closeai );
    }
    
    if ( !canpressuse() )
    {
        return;
    }
    
    if ( !isdefined( closeai ) )
    {
        if ( isdefined( spawnaimode.selectedent ) )
        {
        }
        else
        {
            unhighlightent();
        }
    }
    
    if ( isdefined( spawnaimode.highlightent ) && spawnaimode.placedenemies.size > 0 )
    {
        if ( level.player usebuttonpressed() )
        {
            remove_selected = undefined;
            
            if ( isdefined( spawnaimode.selectedent ) )
            {
                if ( spawnaimode.selectedent == spawnaimode.highlightent )
                {
                    remove_selected = spawnaimode.selectedent;
                }
            }
            
            if ( isdefined( remove_selected ) )
            {
                remove_selected( remove_selected );
            }
            else
            {
                add_selected( spawnaimode.highlightent );
            }
            
            delayusetime();
            return;
        }
    }
    
    if ( isdefined( spawnaimode.shownnodes ) )
    {
        for ( i = 0; i < spawnaimode.shownnodes.size ; i++ )
        {
            node = spawnaimode.shownnodes[ i ];
            
            if ( distancesquared( node.origin, level.debug.cursor_pos ) < 2304 )
            {
                closenode = node;
                closenode_index = i;
                break;
            }
        }
        
        if ( isdefined( closenode ) )
        {
            if ( closenode != spawnaimode.highlightednode )
            {
                closenode thread highlight_node();
            }
        }
        
        if ( !isdefined( closenode ) )
        {
            function_29d89223ccb156a8();
        }
    }
    
    if ( isdefined( closenode ) )
    {
        for ( button = 1; button <= 9 ; button++ )
        {
            if ( level.player buttonpressed( button ) )
            {
                closenode notify( #"hash_1e66a1d123fb866f" );
                closenode thread label_node( closenode_index, button );
                break;
            }
        }
        
        if ( level.player buttonpressed( "del" ) )
        {
            function_1956572bb60821ee( closenode_index );
        }
        else if ( level.player buttonpressed( "BUTTON_A" ) )
        {
            function_69bfed0e9f242145( closenode, closenode_index );
        }
        else if ( level.player buttonpressed( "BUTTON_Y" ) )
        {
            function_314def0fa30afa5b( closenode, closenode_index );
        }
    }
    
    /#
        if ( level.player buttonpressed( "<dev string:x24>" ) )
        {
            collect_data();
        }
    #/
}

// Namespace namespace_9e3a64b15429f7c9
// Params 1
// Checksum 0xbd482ffe, Offset: 0x594
// Size: 0x13e
function debug_cursor( usenavmesh )
{
    level.debug.cursor_pos = ( 0, 0, 0 );
    level notify( #"stop_debug_cursor" );
    level endon( #"stop_debug_cursor" );
    
    if ( !isdefined( usenavmesh ) )
    {
        usenavmesh = 0;
    }
    
    while ( true )
    {
        start = level.player geteye();
        forward = anglestoforward( level.player getplayerangles() );
        
        if ( usenavmesh )
        {
            end = start + forward * 1000;
        }
        else
        {
            end = start + forward * 10000;
        }
        
        trace = trace::_bullet_trace( start, end, 0 );
        
        if ( usenavmesh )
        {
            level.debug.cursor_pos = getclosestpointonnavmesh( trace[ "position" ] ) + ( 0, 0, -2 );
        }
        else
        {
            level.debug.cursor_pos = trace[ "position" ];
        }
        
        /#
            debugaxis( level.debug.cursor_pos, ( 0, 0, 0 ), 4, 1 );
        #/
        
        waitframe();
    }
}

// Namespace namespace_9e3a64b15429f7c9
// Params 0
// Checksum 0x46ed486a, Offset: 0x6da
// Size: 0x101
function take_weapons_away()
{
    storedweapons = spawnstruct();
    storedweapons.weapons = level.player getweaponslistall();
    storedweapons.clip_ammo = [];
    storedweapons.stock_ammo = [];
    
    foreach ( index, weapon in storedweapons.weapons )
    {
        storedweapons.clip_ammo[ index ] = level.player getweaponammoclip( weapon );
        storedweapons.stock_ammo[ index ] = level.player getweaponammostock( weapon );
    }
    
    level.player takeallweapons();
    return storedweapons;
}

// Namespace namespace_9e3a64b15429f7c9
// Params 1
// Checksum 0xea154aca, Offset: 0x7e4
// Size: 0x142
function give_weapons_back( storedweapons )
{
    switchweaponindex = -1;
    
    foreach ( index, weapon in storedweapons.weapons )
    {
        level.player giveweapon( weapon );
        
        if ( weapon.ismelee )
        {
            level.player assignweaponmeleeslot( weapon );
            continue;
        }
        
        if ( switchweaponindex < 0 )
        {
            switchweaponindex = index;
        }
        
        if ( isdefined( storedweapons.clip_ammo[ index ] ) )
        {
            level.player setweaponammoclip( weapon, storedweapons.clip_ammo[ index ] );
        }
        
        if ( isdefined( storedweapons.stock_ammo[ index ] ) )
        {
            level.player setweaponammostock( weapon, storedweapons.stock_ammo[ index ] );
        }
    }
    
    level.player switchtoweapon( storedweapons.weapons[ switchweaponindex ] );
}

// Namespace namespace_9e3a64b15429f7c9
// Params 0
// Checksum 0x86c95847, Offset: 0x92e
// Size: 0x24, Type: bool
function canpressuse()
{
    return gettime() > level.debug.spawnaimode.nextusepress;
}

// Namespace namespace_9e3a64b15429f7c9
// Params 0
// Checksum 0x6de4be1c, Offset: 0x95b
// Size: 0x28
function delayusetime()
{
    level.debug.spawnaimode.nextusepress = gettime() + 400;
}

// Namespace namespace_9e3a64b15429f7c9
// Params 0
// Checksum 0xac738c67, Offset: 0x98b
// Size: 0x116
function collect_data()
{
    spawnaimode = level.debug.spawnaimode;
    
    /#
        if ( isdefined( spawnaimode.selectedent ) && isdefined( spawnaimode.var_9fe4e55604203631 ) && spawnaimode.var_46e7946a3de55cfa.size > 0 )
        {
            set_index = function_2eb6c235019b030c( spawnaimode.selectedent );
            
            for ( nodeindex = 0; nodeindex < spawnaimode.shownnodes.size ; nodeindex++ )
            {
                if ( arraycontains( spawnaimode.var_9fe4e55604203631, nodeindex ) )
                {
                    function_23c0e7f2007be427( spawnaimode.selectedent, spawnaimode.shownnodes[ nodeindex ], set_index, spawnaimode.var_46e7946a3de55cfa[ nodeindex ].rank );
                    continue;
                }
                
                function_23c0e7f2007be427( spawnaimode.selectedent, spawnaimode.shownnodes[ nodeindex ], set_index, 10 );
            }
            
            function_17f24b8b293ae251();
        }
        
        remove_selected( spawnaimode.selectedent );
    #/
}

// Namespace namespace_9e3a64b15429f7c9
// Params 1
// Checksum 0x9fb9810a, Offset: 0xaa9
// Size: 0x202
function function_79c823f7276acce1( for_ally )
{
    ai_names = getaitypenames();
    
    if ( ai_names.size == 0 )
    {
        return;
    }
    
    allytypes = [];
    enemytypes = [];
    
    foreach ( aitype in ai_names )
    {
        scriptbundle = getaitypescriptbundle( aitype );
        
        if ( scriptbundle.unittype == "soldier" )
        {
            if ( scriptbundle.team == "allies" || issubstr( aitype, "ally" ) )
            {
                if ( !isstartstr( aitype, "actor" ) )
                {
                    aitype = strjoin( "_", "actor", aitype );
                }
                
                allytypes[ allytypes.size ] = aitype;
                continue;
            }
            
            if ( scriptbundle.team == "axis" || issubstr( aitype, "enemy" ) )
            {
                if ( !isstartstr( aitype, "actor" ) )
                {
                    aitype = strjoin( "_", "actor", aitype );
                }
                
                enemytypes[ enemytypes.size ] = aitype;
            }
        }
    }
    
    var_a4bedcecf6a51e56 = get_spawn_weights( allytypes );
    var_6ac826db9bff70d4 = get_spawn_weights( enemytypes );
    r = randomfloat( 1 );
    upto = 0;
    
    if ( for_ally )
    {
        for ( i = 0; i < allytypes.size ; i++ )
        {
            if ( upto + var_a4bedcecf6a51e56[ i ] >= r )
            {
                return allytypes[ i ];
            }
            
            upto += var_a4bedcecf6a51e56[ i ];
        }
        
        return;
    }
    
    for ( i = 0; i < enemytypes.size ; i++ )
    {
        if ( upto + var_6ac826db9bff70d4[ i ] >= r )
        {
            return enemytypes[ i ];
        }
        
        upto += var_6ac826db9bff70d4[ i ];
    }
}

// Namespace namespace_9e3a64b15429f7c9
// Params 1
// Checksum 0x7411ac24, Offset: 0xcb3
// Size: 0xc7
function get_spawn_weights( aitypes )
{
    weights = [];
    remaining_percent = 1;
    
    if ( aitypes.size == 1 )
    {
        return [ 1 ];
    }
    
    if ( aitypes[ 0 ] == "actor_rex_ally_sp_us_marine_ar" || aitypes[ 0 ] == "actor_rex_ally_sp_sk_marine_ar" )
    {
        weights[ weights.size ] = 0.7;
        remaining_percent -= 0.7;
    }
    else if ( aitypes[ 0 ] == "actor_rex_enemy_sp_tier1_nk_ar" )
    {
        weights[ weights.size ] = 0.5;
        remaining_percent -= 0.5;
    }
    
    remaining_size = aitypes.size - 1;
    percentage_split = remaining_percent / remaining_size;
    
    for ( i = 0; i < remaining_size ; i++ )
    {
        weights[ weights.size ] = percentage_split;
    }
    
    return weights;
}

// Namespace namespace_9e3a64b15429f7c9
// Params 3
// Checksum 0xf767e9c6, Offset: 0xd83
// Size: 0x56
function get_spawn_points( origin, maxradius, minradius )
{
    tacpoints = [];
    
    while ( tacpoints.size < 1 )
    {
        if ( maxradius > 2048 )
        {
            break;
        }
        
        tacpoints = function_a034a927128ada11( origin, maxradius, minradius );
        maxradius *= 2;
    }
    
    return tacpoints;
}

// Namespace namespace_9e3a64b15429f7c9
// Params 7
// Checksum 0x3ea424a8, Offset: 0xde2
// Size: 0x1c1
function function_8d951424b6e9c320( ai, origin, avgorigin, minimum_points, already_used_points, is_push, max_radius )
{
    currorigin = origin;
    tacpoints = [];
    push_dist = 50;
    
    while ( tacpoints.size < minimum_points && push_dist < 2048 )
    {
        newpoints = arraycombineunique( tacpoints, function_a034a927128ada11( currorigin, max_radius, 0 ) );
        
        foreach ( point in newpoints )
        {
            if ( point.groundpos == ai.origin || arraycontains( already_used_points, point ) )
            {
                newpoints = arrayremove( newpoints, point );
            }
            
            if ( is_push )
            {
                if ( distance( point.groundpos, avgorigin ) < distance( ai.origin, avgorigin ) )
                {
                    newpoints = arrayremove( newpoints, point );
                }
                
                continue;
            }
            
            if ( distance( point.groundpos, avgorigin ) > distance( ai.origin, avgorigin ) )
            {
                newpoints = arrayremove( newpoints, point );
            }
        }
        
        if ( is_push )
        {
            currorigin = get_pushed_origin( origin, avgorigin, push_dist );
        }
        else
        {
            currorigin = get_pushed_origin( origin, avgorigin, push_dist * -1 );
        }
        
        tacpoints = newpoints;
        push_dist += 10;
    }
    
    return tacpoints;
}

// Namespace namespace_9e3a64b15429f7c9
// Params 4
// Checksum 0x24fba39f, Offset: 0xfac
// Size: 0x61
function function_62301cb6c3432997( origin, maxradius, horizontalspacing, minimum_points )
{
    tacpoints = [];
    
    while ( tacpoints.size < minimum_points )
    {
        if ( maxradius > 2048 )
        {
            break;
        }
        
        tacpoints = function_83f92b0d77ecfcd3( origin, maxradius, horizontalspacing, 80 );
        maxradius *= 2;
    }
    
    return tacpoints;
}

// Namespace namespace_9e3a64b15429f7c9
// Params 3
// Checksum 0x1a351761, Offset: 0x1016
// Size: 0x59
function get_pushed_origin( originalorigin, averageorigin, push_dist )
{
    dir = vectornormalize2( originalorigin - averageorigin );
    spawnorigin = ( originalorigin[ 0 ] + dir[ 0 ] * push_dist, originalorigin[ 1 ] + dir[ 1 ] * push_dist, originalorigin[ 2 ] );
    return spawnorigin;
}

// Namespace namespace_9e3a64b15429f7c9
// Params 0
// Checksum 0xb8cc8db9, Offset: 0x1078
// Size: 0x4f
function function_7973bc6aa83754f0()
{
    spawnaimode = level.debug.spawnaimode;
    function_3a097fd56285cd51( spawnaimode.placedais );
    return function_f9298c1604f9e65f( spawnaimode.placedais, spawnaimode.ally_origin );
}

// Namespace namespace_9e3a64b15429f7c9
// Params 0
// Checksum 0xdb5996f5, Offset: 0x10d0
// Size: 0x4f
function function_d8a17f8e640afb34()
{
    spawnaimode = level.debug.spawnaimode;
    function_c24b9ee53603753d( spawnaimode.placedais );
    return function_f9298c1604f9e65f( spawnaimode.placedais, spawnaimode.ally_origin );
}

// Namespace namespace_9e3a64b15429f7c9
// Params 0
// Checksum 0x9fa59faa, Offset: 0x1128
// Size: 0x4f
function function_138c8ac9339e913a()
{
    spawnaimode = level.debug.spawnaimode;
    function_3a097fd56285cd51( spawnaimode.placedenemies );
    return function_f9298c1604f9e65f( spawnaimode.placedenemies, spawnaimode.enemy_origin );
}

// Namespace namespace_9e3a64b15429f7c9
// Params 0
// Checksum 0x5e3ff67, Offset: 0x1180
// Size: 0x4f
function function_d50ca80033c9a7f6()
{
    spawnaimode = level.debug.spawnaimode;
    function_c24b9ee53603753d( spawnaimode.placedenemies );
    return function_f9298c1604f9e65f( spawnaimode.placedenemies, spawnaimode.enemy_origin );
}

// Namespace namespace_9e3a64b15429f7c9
// Params 1
// Checksum 0xc481c5bf, Offset: 0x11d8
// Size: 0x147
function function_3a097fd56285cd51( soldiers )
{
    if ( !canpressuse() )
    {
        return;
    }
    
    angles = ( 0, 0, 0 );
    var_5a02e2a82c5bea52 = utility::function_11a2ebb045201379( soldiers );
    usedpoints = [];
    
    foreach ( placedai in soldiers )
    {
        spawnorigin = get_pushed_origin( placedai.origin, var_5a02e2a82c5bea52, 50 );
        spawntacpoints = function_8d951424b6e9c320( placedai, spawnorigin, var_5a02e2a82c5bea52, 1, usedpoints, 1, 50 );
        
        if ( spawntacpoints.size > 0 )
        {
            point = spawntacpoints[ 0 ];
            placedai forceteleport( point.groundpos, angles );
            placedai setgoalpos( point.groundpos, 32 );
            usedpoints[ usedpoints.size ] = point;
            continue;
        }
        
        iprintlnbold( "Can't move further" );
    }
    
    delayusetime();
}

// Namespace namespace_9e3a64b15429f7c9
// Params 1
// Checksum 0x973a4f9d, Offset: 0x1327
// Size: 0x168
function function_c24b9ee53603753d( soldiers )
{
    if ( !canpressuse() )
    {
        return;
    }
    
    angles = ( 0, 0, 0 );
    var_5a02e2a82c5bea52 = utility::function_11a2ebb045201379( soldiers );
    usedpoints = [];
    
    foreach ( placedai in soldiers )
    {
        if ( distance( var_5a02e2a82c5bea52, placedai.origin ) < 50 )
        {
            iprintlnbold( "Can't move closer" );
            return;
        }
        
        spawnorigin = get_pushed_origin( placedai.origin, var_5a02e2a82c5bea52, -50 );
        spawntacpoints = function_8d951424b6e9c320( placedai, spawnorigin, var_5a02e2a82c5bea52, 1, usedpoints, 0, 50 );
        
        if ( spawntacpoints.size > 0 )
        {
            point = spawntacpoints[ 0 ];
            placedai forceteleport( point.groundpos, angles );
            placedai setgoalpos( point.groundpos, 32 );
            usedpoints[ usedpoints.size ] = point;
            continue;
        }
        
        iprintlnbold( "Can't move closer" );
    }
    
    delayusetime();
}

// Namespace namespace_9e3a64b15429f7c9
// Params 0
// Checksum 0xbf104649, Offset: 0x1497
// Size: 0x19a
function function_340236c8a810352f()
{
    if ( !canpressuse() )
    {
        return;
    }
    
    spawnaimode = level.debug.spawnaimode;
    
    if ( !isdefined( spawnaimode ) || !isdefined( spawnaimode.placedais ) )
    {
        return;
    }
    
    angles = ( 0, 0, 0 );
    var_5a02e2a82c5bea52 = utility::function_11a2ebb045201379( spawnaimode.placedais );
    usedpoints = [];
    
    foreach ( placedenemy in spawnaimode.placedenemies )
    {
        spawnorigin = get_pushed_origin( placedenemy.origin, var_5a02e2a82c5bea52, 50 );
        spawntacpoints = function_8d951424b6e9c320( placedenemy, spawnorigin, var_5a02e2a82c5bea52, 1, usedpoints, 1, 50 );
        
        if ( spawntacpoints.size > 0 )
        {
            placedenemy forceteleport( spawntacpoints[ 0 ].groundpos, angles );
            placedenemy setgoalpos( spawntacpoints[ 0 ].groundpos, 32 );
            usedpoints[ usedpoints.size ] = spawntacpoints[ 0 ];
            continue;
        }
        
        iprintlnbold( "Not enough tacpoints found" );
    }
    
    delayusetime();
    return function_f9298c1604f9e65f( spawnaimode.placedenemies, spawnaimode.ally_origin );
}

// Namespace namespace_9e3a64b15429f7c9
// Params 0
// Checksum 0x2adedf7e, Offset: 0x163a
// Size: 0x199
function function_f2da74831e0f5a63()
{
    if ( !canpressuse() )
    {
        return;
    }
    
    spawnaimode = level.debug.spawnaimode;
    
    if ( !isdefined( spawnaimode ) || !isdefined( spawnaimode.placedais ) )
    {
        return;
    }
    
    angles = ( 0, 0, 0 );
    var_5a02e2a82c5bea52 = utility::function_11a2ebb045201379( spawnaimode.placedais );
    usedpoints = [];
    
    foreach ( placedenemy in spawnaimode.placedenemies )
    {
        spawnorigin = get_pushed_origin( placedenemy.origin, var_5a02e2a82c5bea52, -50 );
        spawntacpoints = function_8d951424b6e9c320( placedenemy, spawnorigin, var_5a02e2a82c5bea52, 1, usedpoints, 0, 50 );
        
        if ( spawntacpoints.size > 0 )
        {
            placedenemy forceteleport( spawntacpoints[ 0 ].groundpos, angles );
            placedenemy setgoalpos( spawntacpoints[ 0 ].groundpos, 32 );
            usedpoints[ usedpoints.size ] = spawntacpoints[ 0 ];
            continue;
        }
        
        iprintlnbold( "Not enough tacpoints found" );
    }
    
    delayusetime();
    return function_f9298c1604f9e65f( spawnaimode.placedenemies, spawnaimode.ally_origin );
}

// Namespace namespace_9e3a64b15429f7c9
// Params 2
// Checksum 0xe9fe7648, Offset: 0x17dc
// Size: 0xa8
function function_f9298c1604f9e65f( soliders, origin )
{
    origin_dists = [];
    
    foreach ( soldier in soliders )
    {
        origin_dists[ origin_dists.size ] = distance( soldier.origin, origin );
    }
    
    return utility::array_average( origin_dists );
}

// Namespace namespace_9e3a64b15429f7c9
// Params 1
// Checksum 0x8cf1c12b, Offset: 0x188d
// Size: 0x63
function highlightent( ent )
{
    if ( level.debug.spawnaimode.highlightent == ent )
    {
        return;
    }
    
    unhighlightent();
    ent hudoutlineenable( "outline_nodepth_orange" );
    level.debug.spawnaimode.highlightent = ent;
}

// Namespace namespace_9e3a64b15429f7c9
// Params 0
// Checksum 0x7e32931b, Offset: 0x18f8
// Size: 0xc9
function unhighlightent()
{
    if ( !isdefined( level.debug.spawnaimode.highlightent ) )
    {
        return;
    }
    
    level.debug.spawnaimode.highlightent hudoutlinedisable();
    
    if ( level.debug.spawnaimode.selectedent == level.debug.spawnaimode.highlightent )
    {
        level.debug.spawnaimode.selectedent hudoutlineenable( "outline_nodepth_cyan" );
    }
    
    level.debug.spawnaimode.highlightent = undefined;
}

// Namespace namespace_9e3a64b15429f7c9
// Params 1
// Checksum 0x3c308161, Offset: 0x19c9
// Size: 0x95
function add_selected( ent )
{
    remove_selected( level.debug.spawnaimode.selectedent );
    level.debug.spawnaimode.selectedent = ent;
    ent hudoutlineenable( "outline_nodepth_cyan" );
    ent notify( #"selected" );
    level.debug.spawnaimode.highlightent = undefined;
    ent thread function_370042f865b97674( ent getorigin() );
}

// Namespace namespace_9e3a64b15429f7c9
// Params 1
// Checksum 0xac73b949, Offset: 0x1a66
// Size: 0x5a
function remove_selected( ent )
{
    if ( !isdefined( ent ) )
    {
        return;
    }
    
    level.debug.spawnaimode.selectedent = undefined;
    ent hudoutlinedisable();
    ent notify( #"deselected" );
    function_c103522153e1ec47();
    function_29d89223ccb156a8();
    hide_nodes();
}

// Namespace namespace_9e3a64b15429f7c9
// Params 1
// Checksum 0x95b59e97, Offset: 0x1ac8
// Size: 0x322
function function_370042f865b97674( pos )
{
    self endon( #"deselected" );
    spawnaimode = level.debug.spawnaimode;
    spawnaimode.shownnodes = [];
    spawnaimode.occupiednodes = [];
    
    foreach ( ai in spawnaimode.placedais )
    {
        if ( isdefined( ai.covernode ) )
        {
            spawnaimode.occupiednodes[ spawnaimode.occupiednodes.size ] = ai.covernode;
            continue;
        }
        
        if ( isdefined( ai.prevcovernode ) )
        {
            spawnaimode.occupiednodes[ spawnaimode.occupiednodes.size ] = ai.prevcovernode;
        }
    }
    
    radius = 1024;
    nodes = getnodesinradius( pos, radius, 0 );
    
    foreach ( node in nodes )
    {
        if ( !isdefined( spawnaimode.occupiednodes ) || !arraycontains( spawnaimode.occupiednodes, node ) )
        {
            spawnaimode.shownnodes[ spawnaimode.shownnodes.size ] = node;
        }
    }
    
    /#
        while ( true )
        {
            foreach ( node in spawnaimode.shownnodes )
            {
                orientedbox( node.origin, ( 32, 32, 16 ), node.angles, ( 1, 1, 1 ), 1 );
                forward = vectornormalize( anglestoforward( node.angles ) );
                endpoint = ( node.origin[ 0 ] + forward[ 0 ] * 32, node.origin[ 1 ] + forward[ 1 ] * 32, node.origin[ 2 ] );
                line( node.origin, endpoint, ( 1, 1, 0 ), 1, 1 );
            }
            
            waitframe();
        }
    #/
}

// Namespace namespace_9e3a64b15429f7c9
// Params 0
// Checksum 0x2ebb694b, Offset: 0x1df2
// Size: 0x42
function hide_nodes()
{
    if ( !isdefined( level.debug.spawnaimode.shownnodes ) )
    {
        return;
    }
    
    level.debug.spawnaimode.shownnodes = undefined;
}

// Namespace namespace_9e3a64b15429f7c9
// Params 0
// Checksum 0x398b45f2, Offset: 0x1e3c
// Size: 0x72
function highlight_node()
{
    function_29d89223ccb156a8();
    self endon( #"unhighlighted" );
    level.debug.spawnaimode.highlightednode = self;
    
    /#
        while ( true )
        {
            orientedbox( self.origin, ( 32, 32, 16 ), self.angles, ( 1, 1, 0 ), 0 );
            waitframe();
        }
    #/
}

// Namespace namespace_9e3a64b15429f7c9
// Params 0
// Checksum 0x2993190a, Offset: 0x1eb6
// Size: 0x6a
function function_29d89223ccb156a8()
{
    if ( !isdefined( level.debug.spawnaimode.highlightednode ) )
    {
        return;
    }
    
    level.debug.spawnaimode.highlightednode notify( #"unhighlighted" );
    level.debug.spawnaimode.highlightednode = undefined;
}

// Namespace namespace_9e3a64b15429f7c9
// Params 2
// Checksum 0xd658d986, Offset: 0x1f28
// Size: 0xaa
function function_69bfed0e9f242145( node, nodeid )
{
    spawnaimode = level.debug.spawnaimode;
    
    if ( isdefined( spawnaimode.var_46e7946a3de55cfa[ nodeid ] ) )
    {
        curr_rank = spawnaimode.var_46e7946a3de55cfa[ nodeid ].rank;
        
        if ( curr_rank == 9 )
        {
            function_1956572bb60821ee( nodeid );
        }
        else
        {
            function_1956572bb60821ee( nodeid );
            node thread label_node( nodeid, curr_rank + 1 );
        }
    }
    else
    {
        node thread label_node( nodeid, 1 );
    }
    
    delayusetime();
}

// Namespace namespace_9e3a64b15429f7c9
// Params 2
// Checksum 0x68b1b9e5, Offset: 0x1fda
// Size: 0xaa
function function_314def0fa30afa5b( node, nodeid )
{
    spawnaimode = level.debug.spawnaimode;
    
    if ( isdefined( spawnaimode.var_46e7946a3de55cfa[ nodeid ] ) )
    {
        curr_rank = spawnaimode.var_46e7946a3de55cfa[ nodeid ].rank;
        
        if ( curr_rank == 1 )
        {
            function_1956572bb60821ee( nodeid );
        }
        else
        {
            function_1956572bb60821ee( nodeid );
            node thread label_node( nodeid, curr_rank - 1 );
        }
    }
    else
    {
        node thread label_node( nodeid, 9 );
    }
    
    delayusetime();
}

// Namespace namespace_9e3a64b15429f7c9
// Params 2
// Checksum 0x2fe8beeb, Offset: 0x208c
// Size: 0xfd
function label_node( nodeid, rank )
{
    self endon( #"hash_1e66a1d123fb866f" );
    spawnaimode = level.debug.spawnaimode;
    
    if ( !isdefined( spawnaimode.var_46e7946a3de55cfa ) )
    {
        spawnaimode.var_46e7946a3de55cfa = [];
    }
    
    if ( !isdefined( spawnaimode.var_46e7946a3de55cfa[ nodeid ] ) )
    {
        spawnaimode.var_46e7946a3de55cfa[ nodeid ] = {};
    }
    
    spawnaimode.var_46e7946a3de55cfa[ nodeid ].rank = rank;
    
    if ( !isdefined( spawnaimode.var_9fe4e55604203631 ) )
    {
        spawnaimode.var_9fe4e55604203631 = [];
    }
    
    if ( !arraycontains( spawnaimode.var_9fe4e55604203631, nodeid ) )
    {
        spawnaimode.var_9fe4e55604203631[ spawnaimode.var_9fe4e55604203631.size ] = nodeid;
    }
    
    /#
        while ( true )
        {
            print3d( self.origin, rank );
            waitframe();
        }
    #/
}

// Namespace namespace_9e3a64b15429f7c9
// Params 1
// Checksum 0xb348af36, Offset: 0x2191
// Size: 0x93
function function_1956572bb60821ee( nodeid )
{
    spawnaimode = level.debug.spawnaimode;
    
    if ( isdefined( spawnaimode.var_9fe4e55604203631 ) && arraycontains( spawnaimode.var_9fe4e55604203631, nodeid ) )
    {
        spawnaimode.shownnodes[ nodeid ] notify( #"hash_1e66a1d123fb866f" );
        spawnaimode.var_46e7946a3de55cfa[ nodeid ] = undefined;
        spawnaimode.var_9fe4e55604203631 = arrayremove( spawnaimode.var_9fe4e55604203631, nodeid );
    }
}

// Namespace namespace_9e3a64b15429f7c9
// Params 0
// Checksum 0x119b6135, Offset: 0x222c
// Size: 0xbf
function function_c103522153e1ec47()
{
    spawnaimode = level.debug.spawnaimode;
    
    if ( isdefined( spawnaimode.var_9fe4e55604203631 ) )
    {
        foreach ( node in spawnaimode.var_9fe4e55604203631 )
        {
            function_1956572bb60821ee( node );
        }
    }
    
    spawnaimode.var_46e7946a3de55cfa = undefined;
    spawnaimode.var_9fe4e55604203631 = undefined;
}

// Namespace namespace_9e3a64b15429f7c9
// Params 1
// Checksum 0xa6fd9749, Offset: 0x22f3
// Size: 0x34
function label_self( label )
{
    self endon( #"death" );
    
    /#
        while ( true )
        {
            print3d( self.origin, label );
            waitframe();
        }
    #/
}

/#

    // Namespace namespace_9e3a64b15429f7c9
    // Params 1
    // Checksum 0x6405e41f, Offset: 0x232f
    // Size: 0x89, Type: dev
    function function_ef0aa4a050bec677( target )
    {
        while ( !isdefined( target ) )
        {
            self function_fa32376aaa88a7a2( self.origin, 2048 );
            target = self.enemy;
            waitframe();
        }
        
        self endon( #"retarget" );
        self endon( #"death" );
        
        while ( true )
        {
            if ( isdefined( self ) && isdefined( target ) )
            {
                line( self.origin, target.origin, ( 1, 1, 0 ) );
            }
            
            waitframe();
        }
    }

#/
