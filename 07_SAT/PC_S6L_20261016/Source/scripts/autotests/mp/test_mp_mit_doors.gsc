// scripts\autotests\mp\test_mp_mit_doors.gsc  (hash_6eedbfca3ef1dd1e.gscc) (size: 5821 Bytes / 0x16bd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x761179f6 (1980856822)
// size ...... 5821 (0x16bd)
// includes .. 5   (offset: 0x1501)
// strings ... 29  (offset: 0x1529)
// dev strs .. 0   (offset: 0x16bd)
// exports ... 11  (offset: 0xe29)
// cseg ...... 0x338 + 0xaf1 (0xe29)
// imports ... 39  (offset: 0xfe1)
// animtree1 . 0   (offset: 0x16bd)
// animtree2 . 0   (offset: 0x16bd)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility_player;
#using scripts\autotests\mp\autotests_utility_mit;
#using scripts\common\bots\bots_util;
#using scripts\mp\bots\bots_util;

#namespace test_mp_mit_doors;

// Namespace test_mp_mit_doors/testautomation
// Params 0, eflags: 0x20
// Checksum 0x6cfb1ebc, Offset: 0x356
// Size: 0x18
function event_handler[testautomation] main()
{
    autotests_utility_mit::function_45effcfcc139e74a( "scripts/autotests/mp/test_mp_mit_doors.gsc", &start_test, &parameterize );
}

// Namespace test_mp_mit_doors
// Params 2, eflags: 0x4
// Checksum 0xadd5b70, Offset: 0x376
// Size: 0x46d
function private function_f4c6ecf86a985532( player, var_53446d7694b6f11a )
{
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "Valid Door ID?|id_valid", var_53446d7694b6f11a, "scripts/autotests/mp/test_mp_mit_doors.gsc", 23 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    door = level.mit_lookup[ var_53446d7694b6f11a ];
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "Door found?|door_found", door, "scripts/autotests/mp/test_mp_mit_doors.gsc", 26 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    autotests::set_current_asset_name( var_53446d7694b6f11a );
    doorinfo = function_b5e62c5c6f60111d( door );
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "Can generate test positions?|positions_valid", doorinfo, "scripts/autotests/mp/test_mp_mit_doors.gsc", 31 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    autotests_utility_mit::function_51e9e46c136ac9c3( player, "before_door_pos", "Test start position (before door)", doorinfo.beforedoorpos );
    autotests_utility_mit::function_51e9e46c136ac9c3( player, "door_mid_point", "Door center point", doorinfo.midpoint );
    autotests_utility_mit::function_51e9e46c136ac9c3( player, "after_door_pos", "Test goal position (after door)", doorinfo.afterdoorpos );
    autotests_utility_mit::function_fc203072b5b37c65( player, "door_origin_x", door.origin[ 0 ] * 1 );
    autotests_utility_mit::function_fc203072b5b37c65( player, "door_origin_y", door.origin[ 1 ] * 1 );
    autotests_utility_mit::function_fc203072b5b37c65( player, "door_origin_z", door.origin[ 2 ] * 1 );
    door scriptabledoorclose();
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Door closed for pass 1?|door_closed_fwd", function_2d7f01a561c759d4( door ), "scripts/autotests/mp/test_mp_mit_doors.gsc", 42 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    player autotests_utility_player::set_player_position( doorinfo.beforedoorpos );
    player botsetpathingstyle( "scripted" );
    player botsetscriptgoal( doorinfo.afterdoorpos, 32, "tactical" );
    player botsetshorttermgoal( 1 );
    player.var_3319c5a920a1a07d = 0;
    player thread function_272144fdbf662b47( doorinfo );
    results = player bots_util::bot_waittill_goal_or_fail( 4.5 );
    player notify( #"hash_96f10f18612f8d5e" );
    autotests_utility_mit::function_fc203072b5b37c65( player, "bot_path_result_fwd", results );
    autotests_utility_mit::function_fc203072b5b37c65( player, "did_cross_fwd", player.var_3319c5a920a1a07d );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Reached goal (forward)|goal_fwd", results, "goal", "scripts/autotests/mp/test_mp_mit_doors.gsc", 57 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Crossed through door (forward)?|cross_fwd", player.var_3319c5a920a1a07d, "scripts/autotests/mp/test_mp_mit_doors.gsc", 58 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    door scriptabledoorclose();
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Door closed for pass 2?|door_closed_rev", function_2d7f01a561c759d4( door ), "scripts/autotests/mp/test_mp_mit_doors.gsc", 62 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    player autotests_utility_player::set_player_position( doorinfo.afterdoorpos );
    player botsetpathingstyle( "scripted" );
    player botsetscriptgoal( doorinfo.beforedoorpos, 32, "tactical" );
    player botsetshorttermgoal( 1 );
    player.var_3319c5a920a1a07d = 0;
    player thread function_272144fdbf662b47( doorinfo );
    results = player bots_util::bot_waittill_goal_or_fail( 4.5 );
    player notify( #"hash_96f10f18612f8d5e" );
    autotests_utility_mit::function_fc203072b5b37c65( player, "bot_path_result_rev", results );
    autotests_utility_mit::function_fc203072b5b37c65( player, "did_cross_rev", player.var_3319c5a920a1a07d );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Reached goal (reverse)|goal_rev", results, "goal", "scripts/autotests/mp/test_mp_mit_doors.gsc", 77 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Crossed through door (reverse)?|cross_rev", player.var_3319c5a920a1a07d, "scripts/autotests/mp/test_mp_mit_doors.gsc", 78 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    door scriptabledoorclose();
}

// Namespace test_mp_mit_doors
// Params 1, eflags: 0x4
// Checksum 0xc48512b0, Offset: 0x7eb
// Size: 0xa1
function private function_272144fdbf662b47( doorinfo )
{
    self endon( #"hash_96f10f18612f8d5e" );
    var_70195448bdbc410c = doorinfo.door.origin;
    var_bd6776c6c10617d5 = var_70195448bdbc410c + anglestoforward( doorinfo.originangle ) * 64;
    
    for ( lastpos = self.origin; true ; lastpos = self.origin )
    {
        waitframe();
        
        if ( function_57b388b15cd6d2a5( lastpos, self.origin, var_70195448bdbc410c, var_bd6776c6c10617d5 ) )
        {
            self.var_3319c5a920a1a07d = 1;
        }
    }
}

// Namespace test_mp_mit_doors
// Params 1, eflags: 0x4
// Checksum 0xabd02e47, Offset: 0x894
// Size: 0x28
function private function_2d7f01a561c759d4( door )
{
    if ( door scriptabledoorisclosed() )
    {
        return 1;
    }
    
    door scriptabledoorclose();
    wait 1;
    return door scriptabledoorisclosed();
}

// Namespace test_mp_mit_doors
// Params 1, eflags: 0x4
// Checksum 0xddedba7a, Offset: 0x8c5
// Size: 0x160
function private function_b5e62c5c6f60111d( door )
{
    distances = [ 100, 70, 50 ];
    doormidpoint = door function_50ddcb729a6c2820();
    
    foreach ( dis in distances )
    {
        beforedoorpos = bots_util_mp::function_1882f18076610076( doormidpoint + anglestoforward( door.angles + ( 0, -90, 0 ) ) * dis );
        afterdoorpos = bots_util_mp::function_1882f18076610076( doormidpoint + anglestoforward( door.angles + ( 0, 90, 0 ) ) * dis );
        
        if ( distance( beforedoorpos, afterdoorpos ) <= 2 * dis * 1.25 )
        {
            return { #midpoint:doormidpoint, #afterdoorpos:afterdoorpos, #beforedoorpos:beforedoorpos, #originangle:door.angles, #door:door };
        }
    }
}

// Namespace test_mp_mit_doors
// Params 4, eflags: 0x4
// Checksum 0xa0a309de, Offset: 0xa2e
// Size: 0x206, Type: bool
function private function_57b388b15cd6d2a5( p1, p2, q1, q2 )
{
    pxmax = p1[ 0 ] > p2[ 0 ] ? p1[ 0 ] : p2[ 0 ];
    pxmin = p1[ 0 ] > p2[ 0 ] ? p2[ 0 ] : p1[ 0 ];
    var_c0656b4974739ad = p1[ 1 ] > p2[ 1 ] ? p1[ 1 ] : p2[ 1 ];
    var_be340b49720c193 = p1[ 1 ] > p2[ 1 ] ? p2[ 1 ] : p1[ 1 ];
    qxmax = q1[ 0 ] > q2[ 0 ] ? q1[ 0 ] : q2[ 0 ];
    qxmin = q1[ 0 ] > q2[ 0 ] ? q2[ 0 ] : q1[ 0 ];
    var_6750351558997656 = q1[ 1 ] > q2[ 1 ] ? q1[ 1 ] : q2[ 1 ];
    var_672d471558735634 = q1[ 1 ] > q2[ 1 ] ? q2[ 1 ] : q1[ 1 ];
    
    if ( pxmax < qxmin || qxmax < pxmin || var_c0656b4974739ad < var_672d471558735634 || var_6750351558997656 < var_be340b49720c193 )
    {
        return false;
    }
    
    res1 = ( p1[ 0 ] - p2[ 0 ] ) * ( q1[ 1 ] - p2[ 1 ] ) - ( p1[ 1 ] - p2[ 1 ] ) * ( q1[ 0 ] - p2[ 0 ] );
    res2 = ( p1[ 0 ] - p2[ 0 ] ) * ( q2[ 1 ] - p2[ 1 ] ) - ( p1[ 1 ] - p2[ 1 ] ) * ( q2[ 0 ] - p2[ 0 ] );
    res3 = ( q1[ 0 ] - q2[ 0 ] ) * ( p1[ 1 ] - q2[ 1 ] ) - ( q1[ 1 ] - q2[ 1 ] ) * ( p1[ 0 ] - q2[ 0 ] );
    res4 = ( q1[ 0 ] - q2[ 0 ] ) * ( p2[ 1 ] - q2[ 1 ] ) - ( q1[ 1 ] - q2[ 1 ] ) * ( p2[ 0 ] - q2[ 0 ] );
    return res1 * res2 <= 0 && res3 * res4 <= 0;
}

// Namespace test_mp_mit_doors
// Params 2, eflags: 0x4
// Checksum 0x70bb6d99, Offset: 0xc3d
// Size: 0x16d
function private function_ddbc6442c74c8911( minbounds, maxbounds )
{
    var_c00f525c21927ad0 = [];
    doors = getentitylessscriptablearray( undefined, undefined, undefined, undefined, "door" );
    
    foreach ( door in doors )
    {
        if ( !door scriptableisdoor() || door function_4f79c45e0fd47b7f() )
        {
            continue;
        }
        
        state = door getscriptablepartstate( "door", 1 );
        
        if ( state != "closed" )
        {
            continue;
        }
        
        doormidpoint = door function_50ddcb729a6c2820();
        
        if ( isdefined( minbounds ) && isdefined( maxbounds ) )
        {
            if ( doormidpoint[ 0 ] < minbounds[ 0 ] || doormidpoint[ 0 ] > maxbounds[ 0 ] || doormidpoint[ 1 ] < minbounds[ 1 ] || doormidpoint[ 1 ] > maxbounds[ 1 ] )
            {
                continue;
            }
        }
        
        if ( !ispointonnavmesh( doormidpoint ) )
        {
            continue;
        }
        
        id = autotests_utility_mit::function_dc2e211727d1d124( doormidpoint );
        
        if ( door.targetname )
        {
            id = door.targetname;
        }
        
        var_c00f525c21927ad0[ id ] = door;
    }
    
    return var_c00f525c21927ad0;
}

// Namespace test_mp_mit_doors
// Params 0, eflags: 0x4
// Checksum 0x1adafd2c, Offset: 0xdb3
// Size: 0x3b
function private get_config()
{
    return { #sourcefile:"scripts/autotests/mp/test_mp_mit_doors.gsc", #var_6b7f0911cb91054a:"door_event", #var_db86da194d47f8f2:&function_f4c6ecf86a985532, #var_4182163638fd37ed:&function_ddbc6442c74c8911 };
}

// Namespace test_mp_mit_doors
// Params 1, eflags: 0x4
// Checksum 0xfc2dad33, Offset: 0xdf7
// Size: 0x1a
function private parameterize( test_setup )
{
    return autotests_utility_mit::function_b7fe9eed6b7b2a72( test_setup, get_config() );
}

// Namespace test_mp_mit_doors
// Params 0
// Checksum 0xfe47ce3f, Offset: 0xe1a
// Size: 0xf
function start_test()
{
    autotests_utility_mit::function_a10f1915e22ab0d4( get_config() );
}

