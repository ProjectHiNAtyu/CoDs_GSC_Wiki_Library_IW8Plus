// scripts\mp\calloutmarkerping_mp.gsc  (hash_235ccfcbdde6f11c.gscc) (size: 4375 Bytes / 0x1117 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf4f3f29c (4109628060)
// size ...... 4375 (0x1117)
// includes .. 7   (offset: 0x10bb)
// strings ... 3   (offset: 0x10f3)
// dev strs .. 0   (offset: 0x1117)
// exports ... 9   (offset: 0xb17)
// cseg ...... 0x91 + 0xa86 (0xb17)
// imports ... 34  (offset: 0xc7f)
// animtree1 . 0   (offset: 0x1117)
// animtree2 . 0   (offset: 0x1117)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\utility\disconnect_event_aggregator;
#using scripts\mp\common\utility\teams;
#using scripts\mp\loot;
#using scripts\mp\loot\common_item;

#namespace calloutmarkerping_mp;

// Namespace calloutmarkerping_mp
// Params 0
// Checksum 0xb5f629bb, Offset: 0xaf
// Size: 0xdd
function calloutmarkerping_init()
{
    level.calloutmarkerpingmp = spawnstruct();
    calloutmarkerping::initcommon();
    disconnect_event_aggregator::registerondisconnecteventcallback( &calloutmarkerping::onplayerdisconnect );
    utility::registersharedfunc( #"ping", #"calloutmarkerping_watchitemtakenfromcontainer", &calloutmarkerping_watchitemtakenfromcontainer );
    utility::registersharedfunc( #"ping", #"hash_93794a5055a44ce1", &function_a7fccce33a9049e5 );
    utility::registersharedfunc( #"container", #"getindexforlootidincontainer", &loot_mp::getindexforlootidincontainer );
    utility::registersharedfunc( #"container", #"getloadoutdoublebackpacklootid", &loot_mp::getloadoutdoublebackpacklootid );
    utility::registersharedfunc( #"container", #"getlootidatcontainerindex", &loot_mp::getlootidatcontainerindex );
    
    if ( common_item::items_isenabled() )
    {
        function_cde74eef5312bb55();
        callback::add( #"player_item_pickup", &function_5f8e3badae581f );
    }
}

// Namespace calloutmarkerping_mp
// Params 1, eflags: 0x4
// Checksum 0xba896093, Offset: 0x194
// Size: 0x1d
function private function_a7fccce33a9049e5( b_allow )
{
    self function_82b9ec717813e1f2( b_allow ? 1 : 0 );
}

// Namespace calloutmarkerping_mp
// Params 3
// Checksum 0x1a51a29, Offset: 0x1b9
// Size: 0x21a
function calloutmarkerping_watchitemtakenfromcontainer( player, container, lootid )
{
    if ( !( isdefined( player ) && isdefined( container ) && isdefined( lootid ) ) )
    {
        return;
    }
    
    player endon( #"death_or_disconnect" );
    container endon( #"death" );
    containerindex = undefined;
    loadoutcontents = undefined;
    
    while ( true )
    {
        if ( !( isdefined( container ) && isdefined( container.contents ) ) )
        {
            return;
        }
        
        if ( utility::issharedfuncdefined( #"container", #"iscontainerempty" ) && [[ utility::getsharedfunc( #"container", #"iscontainerempty" ) ]]( container ) )
        {
            return;
        }
        
        if ( !isdefined( container.opener ) )
        {
            waitframe();
            continue;
        }
        
        if ( !isdefined( containerindex ) && utility::issharedfuncdefined( #"container", #"getindexforlootidincontainer" ) )
        {
            [ containerindex, loadoutcontents ] = [[ utility::getsharedfunc( #"container", #"getindexforlootidincontainer" ) ]]( container, lootid );
        }
        
        if ( !( isdefined( containerindex ) && isdefined( loadoutcontents ) ) )
        {
            return;
        }
        
        newlootid = undefined;
        
        if ( loadoutcontents )
        {
            if ( containerindex == 100 )
            {
                newlootid = container.var_64df982caf48609c;
            }
            else if ( utility::issharedfuncdefined( #"container", #"getloadoutdoublebackpacklootid" ) )
            {
                newlootid = [[ utility::getsharedfunc( #"container", #"getloadoutdoublebackpacklootid" ) ]]( container, containerindex, 0 );
            }
            
            if ( !newlootid || newlootid != lootid )
            {
                return;
            }
        }
        else
        {
            if ( containerindex == 100 )
            {
                newlootid = container.weaponslotcontents;
            }
            else if ( utility::issharedfuncdefined( #"container", #"getlootidatcontainerindex" ) )
            {
                newlootid = [[ utility::getsharedfunc( #"container", #"getlootidatcontainerindex" ) ]]( container.opener, containerindex, container, 0 );
            }
            
            if ( !newlootid || newlootid != lootid )
            {
                return;
            }
        }
        
        waitframe();
    }
}

// Namespace calloutmarkerping_mp
// Params 2
// Checksum 0x836fd181, Offset: 0x3db
// Size: 0x172, Type: bool
function function_fa511c27ff3cfada( scriptable, var_b6811878882a0b65 )
{
    assert( isplayer( self ) );
    player = self;
    
    if ( !isdefined( scriptable ) )
    {
        return false;
    }
    
    friendlyplayers = teams::getfriendlyplayers( player.team, 1 );
    
    foreach ( friendlyplayer in friendlyplayers )
    {
        if ( friendlyplayer != player )
        {
            if ( friendlyplayer function_333d9cb29c9abb4f( scriptable.index ) )
            {
                if ( isdefined( var_b6811878882a0b65 ) )
                {
                    container = scriptable;
                    pingindex = friendlyplayer calloutmarkerping::function_880706287a0f41fe();
                    
                    if ( isdefined( pingindex ) )
                    {
                        var_6675b0888e2dbc2 = friendlyplayer function_689a4266a29aac13( pingindex );
                        
                        if ( var_6675b0888e2dbc2 == function_1bf3a084cfe14025( 13 ) )
                        {
                            pingedcontainer = friendlyplayer calloutmarkerping_getent( pingindex );
                            
                            if ( isdefined( pingedcontainer ) && pingedcontainer.index == container.index )
                            {
                                pingedlootid = friendlyplayer function_d3e0d9364e4846b8( pingindex );
                                
                                if ( pingedlootid == var_b6811878882a0b65 )
                                {
                                    return true;
                                }
                            }
                        }
                    }
                    
                    continue;
                }
                
                return true;
            }
        }
    }
    
    return false;
}

// Namespace calloutmarkerping_mp
// Params 1
// Checksum 0xe94609c8, Offset: 0x556
// Size: 0x149, Type: bool
function function_577661f056cb61e9( enemy )
{
    assert( isplayer( self ) );
    player = self;
    
    if ( !isdefined( enemy ) )
    {
        return false;
    }
    
    friendlyplayers = teams::getfriendlyplayers( player.team, 1 );
    
    foreach ( friendlyplayer in friendlyplayers )
    {
        if ( !isdefined( friendlyplayer ) )
        {
            continue;
        }
        
        if ( friendlyplayer == player )
        {
            continue;
        }
        
        enemyentnum = enemy getentitynumber();
        
        if ( !( isdefined( player.var_c45b5553c36a0755 ) && isdefined( player.var_c45b5553c36a0755[ enemyentnum ] ) ) )
        {
            continue;
        }
        
        var_85eb0bab6e5e3c26 = player.var_c45b5553c36a0755[ enemyentnum ];
        recentlytimeout = 5000;
        var_2c4ae9d10c251733 = gettime() - var_85eb0bab6e5e3c26;
        recentlypinged = var_2c4ae9d10c251733 <= recentlytimeout;
        
        if ( recentlypinged )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace calloutmarkerping_mp
// Params 2, eflags: 0x4
// Checksum 0xe86918d, Offset: 0x6a8
// Size: 0x7b
function private function_36b6908e87f6c920( calloutmarkerpingitem, requestkey )
{
    if ( !isdefined( calloutmarkerpingitem ) )
    {
        return;
    }
    
    var_a97b8d3e222e361c = getscriptbundle( "calloutmarkerpingitem:" + calloutmarkerpingitem );
    
    if ( !isdefined( var_a97b8d3e222e361c ) )
    {
        return;
    }
    
    assert( isdefined( level.calloutmarkerpingmp.var_64ac9bfacfcb711a ) );
    level.calloutmarkerpingmp.var_64ac9bfacfcb711a[ var_a97b8d3e222e361c.lootid ] = requestkey;
}

// Namespace calloutmarkerping_mp
// Params 0, eflags: 0x4
// Checksum 0x61a53a71, Offset: 0x72b
// Size: 0x159
function private function_cde74eef5312bb55()
{
    assert( isdefined( level.calloutmarkerpingmp ) );
    level.calloutmarkerpingmp.var_64ac9bfacfcb711a = [];
    var_8debd17a9da7ae1 = calloutmarkerping::function_685616faafc106cd();
    
    if ( !isdefined( var_8debd17a9da7ae1 ) )
    {
        return;
    }
    
    var_57910eb575beaaab = getscriptbundle( "calloutmarkerpingitems:" + var_8debd17a9da7ae1.calloutmarkerpingitems );
    
    if ( !isdefined( var_57910eb575beaaab ) )
    {
        return;
    }
    
    function_36b6908e87f6c920( var_57910eb575beaaab.emptycash, 0 );
    function_36b6908e87f6c920( var_57910eb575beaaab.emptygasmask, 1 );
    function_36b6908e87f6c920( var_57910eb575beaaab.emptyarmor, 2 );
    function_36b6908e87f6c920( var_57910eb575beaaab.emptykillstreak, 3 );
    function_36b6908e87f6c920( var_57910eb575beaaab.emptyfieldupgrade, 4 );
    function_36b6908e87f6c920( var_57910eb575beaaab.var_64490dffa2c88d63, 5 );
    function_36b6908e87f6c920( var_57910eb575beaaab.var_d7031d78cc44d5a7, 5 );
    function_36b6908e87f6c920( var_57910eb575beaaab.var_2f432242e1514334, 6 );
    function_36b6908e87f6c920( var_57910eb575beaaab.var_9cc7c5e5f1f7adce, 6 );
    function_36b6908e87f6c920( var_57910eb575beaaab.var_d56e67dd45ffe1bc, 6 );
    function_36b6908e87f6c920( var_57910eb575beaaab.var_3ee503b04728444e, 6 );
    function_36b6908e87f6c920( var_57910eb575beaaab.var_c51a675bb2f700ca, 6 );
}

// Namespace calloutmarkerping_mp
// Params 1, eflags: 0x4
// Checksum 0xa38a1a70, Offset: 0x88c
// Size: 0x28b
function private function_5f8e3badae581f( params )
{
    player = self;
    pingindex = player calloutmarkerping::function_880706287a0f41fe();
    
    if ( !isdefined( pingindex ) )
    {
        return;
    }
    
    var_6675b0888e2dbc2 = player function_689a4266a29aac13( pingindex );
    
    if ( var_6675b0888e2dbc2 != function_1bf3a084cfe14025( 10 ) && var_6675b0888e2dbc2 != function_1bf3a084cfe14025( 11 ) )
    {
        return;
    }
    
    requestedlootid = player function_d3e0d9364e4846b8( pingindex );
    
    if ( !isdefined( requestedlootid ) )
    {
        return;
    }
    
    requestsatisfied = 0;
    requesttype = level.calloutmarkerpingmp.var_64ac9bfacfcb711a[ requestedlootid ] ?? "";
    
    switch ( requesttype )
    {
        case 0:
            requestsatisfied = params.itembundle.lootitemtype == %"hash_6754da5a318d7a1d" ? 1 : 0;
            break;
        case 1:
            requestsatisfied = params.itembundle.lootitemtype == %"hash_2d7efac821edc1b" ? 1 : 0;
            break;
        case 2:
            requestsatisfied = params.itembundle.lootitemtype == %"hash_5eca0c3c047abb55" ? 1 : 0;
            break;
        case 3:
            requestsatisfied = params.itembundle.lootitemtype == %"hash_140b948763b4c980" ? 1 : 0;
            break;
        case 4:
            requestsatisfied = params.itembundle.lootitemtype == %"hash_4e37a32ae2542f2d" ? 1 : 0;
            break;
        case 5:
            requestsatisfied = params.itembundle.lootitemtype == %"hash_14c22a546ee33476" ? 1 : 0;
            break;
        case 6:
            requestsatisfied = params.itembundle.lootitemtype == %"hash_74fad6536b0590a0" ? 1 : 0;
            break;
        default:
            pickuplootid = common_item::function_6d301ac91c3cd13d( params.item );
            requestsatisfied = pickuplootid == requestedlootid ? 1 : 0;
            break;
    }
    
    if ( requestsatisfied )
    {
        player calloutmarkerping::function_7c0ee9d4b604e6d6( pingindex );
    }
}

