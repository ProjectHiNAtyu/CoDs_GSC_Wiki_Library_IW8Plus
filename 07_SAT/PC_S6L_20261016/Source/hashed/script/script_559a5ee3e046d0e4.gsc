// script_559a5ee3e046d0e4  (hash_559a5ee3e046d0e4.gscc) (size: 6968 Bytes / 0x1b38 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x68a3dc49 (1755569225)
// size ...... 6968 (0x1b38)
// includes .. 8   (offset: 0x1a90)
// strings ... 5   (offset: 0x1ad0)
// dev strs .. 3   (offset: 0x1b14)
// exports ... 18  (offset: 0x1170)
// cseg ...... 0xc1 + 0x10af (0x1170)
// imports ... 54  (offset: 0x1440)
// animtree1 . 0   (offset: 0x1b38)
// animtree2 . 0   (offset: 0x1b38)
#using script_470e026708163cc1;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\bots\bots_gametype_br_super;
#using scripts\mp\bots\bots_util;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\utility\lui_game_event_aggregator;
#using scripts\mp\common\utility\teams;

#namespace namespace_626c96a2fc3e681b;

// Namespace namespace_626c96a2fc3e681b
// Params 0
// Checksum 0xb4100995, Offset: 0xdf
// Size: 0x58
function function_b2fbe53036657d2b()
{
    if ( !isbrgamemode() || !bots_gametype_br_super::function_3130ca8d103182cd() )
    {
        return;
    }
    
    level callback::add( #"on_ping", &function_77914ea87f612d0c );
    level callback::add( #"on_ping_removed", &function_bc28666bbd11425b );
    level callback::add( #"player_spawned", &function_298be95460aacc3 );
}

// Namespace namespace_626c96a2fc3e681b
// Params 1, eflags: 0x4
// Checksum 0x522dac, Offset: 0x13f
// Size: 0x116
function private function_77914ea87f612d0c( params )
{
    pingowner = params.player;
    
    if ( self != pingowner )
    {
        return;
    }
    
    target = params.obj;
    
    if ( !target )
    {
        return;
    }
    
    pingindex = params.pingindex;
    assert( isdefined( pingindex ) );
    var_6675b0888e2dbc2 = pingowner function_689a4266a29aac13( pingindex );
    
    if ( !calloutmarkerping::function_b658b8c35408496a( var_6675b0888e2dbc2 ) )
    {
        return;
    }
    
    if ( !isdefined( target.var_2d1f0d5bbb9eda76 ) )
    {
        target.var_2d1f0d5bbb9eda76 = [];
    }
    
    if ( !isdefined( target.var_2d1f0d5bbb9eda76[ pingowner.team ] ) )
    {
        target.var_2d1f0d5bbb9eda76[ pingowner.team ] = 0;
    }
    
    target.var_2d1f0d5bbb9eda76[ pingowner.team ]++;
    
    if ( !isdefined( pingowner.var_311eaa786e16d9e ) )
    {
        pingowner.var_311eaa786e16d9e = [];
    }
    
    pingowner.var_311eaa786e16d9e[ pingindex ] = target;
}

// Namespace namespace_626c96a2fc3e681b
// Params 1, eflags: 0x4
// Checksum 0x82c7ee8f, Offset: 0x25d
// Size: 0xdc
function private function_bc28666bbd11425b( params )
{
    pingowner = self;
    
    if ( !pingowner.var_311eaa786e16d9e.size )
    {
        return;
    }
    
    pingindex = params.pingindex;
    assert( isdefined( pingindex ) );
    target = pingowner.var_311eaa786e16d9e[ pingindex ];
    pingowner.var_311eaa786e16d9e[ pingindex ] = undefined;
    
    if ( !target )
    {
        return;
    }
    
    if ( target.var_2d1f0d5bbb9eda76[ pingowner.team ] )
    {
        target.var_2d1f0d5bbb9eda76[ pingowner.team ]--;
        
        if ( target.var_2d1f0d5bbb9eda76[ pingowner.team ] == 0 )
        {
            target.var_2d1f0d5bbb9eda76[ pingowner.team ] = undefined;
        }
    }
}

// Namespace namespace_626c96a2fc3e681b
// Params 1, eflags: 0xc
// Checksum 0x34392ab7, Offset: 0x341
// Size: 0x109
function private function_298be95460aacc3( unused )
{
    self notify( #"hash_ac40b4419b19a80b" );
    self endon( #"hash_ac40b4419b19a80b" );
    assert( isdefined( level.var_d4909c0acc55763c.var_84fb98f75e8f60a5 ) );
    
    if ( !isbot( self ) && !isautopilot( self ) )
    {
        return;
    }
    
    self endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        self waittill( #"hash_c985c642647230e0", targetentnum );
        
        if ( self.var_4fc317a6e881f998 > gettime() - level.var_d4909c0acc55763c.var_84fb98f75e8f60a5 )
        {
            continue;
        }
        
        target = getentbynum( targetentnum );
        
        if ( target && !target.var_2d1f0d5bbb9eda76[ self.team ] )
        {
            pingindex = function_b2bafe27aa071e25( targetentnum );
            
            if ( isdefined( pingindex ) )
            {
                self.var_4fc317a6e881f998 = gettime();
            }
        }
    }
}

// Namespace namespace_626c96a2fc3e681b
// Params 0
// Checksum 0xa58ab46b, Offset: 0x452
// Size: 0x57
function function_e8cce0f7a7bcff7f()
{
    if ( !function_17352077c55402f5() )
    {
        return;
    }
    
    assert( !isbrgamemode() || bots_gametype_br_super::function_3130ca8d103182cd(), "<dev string:x24>" );
    function_82776659f6a1f5be();
    level callback::add( #"on_ping", &function_dd3156cb54f90157 );
    lui_game_event_aggregator::registeronluieventcallback( &namespace_4ac629b285195f94::function_6ed0777d84d35de2, "loot_ping_request" );
}

// Namespace namespace_626c96a2fc3e681b
// Params 0, eflags: 0x4
// Checksum 0x4cafd43f, Offset: 0x4b1
// Size: 0x53, Type: bool
function private function_17352077c55402f5()
{
    if ( level.gametypebundle.var_fd3a1a6b45be175c )
    {
        var_975dd3de61a9aaf9 = level.gametypebundle.var_fd3a1a6b45be175c[ #"hash_1b433cadb8f2a54a" ];
        
        if ( var_975dd3de61a9aaf9.var_2aacb3783039eb11 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_626c96a2fc3e681b
// Params 0, eflags: 0x4
// Checksum 0xd1a542b1, Offset: 0x50d
// Size: 0x3ff
function private function_82776659f6a1f5be()
{
    assert( isdefined( level.var_d4909c0acc55763c ) );
    var_b3ec47f3e360f28f = [ { #var_a1202e1894c2ac35:1, #var_4926875387b9afac:#"navigation", #assetname:calloutmarkerping_asset_name( function_1bf3a084cfe14025( 8 ) ) }, { #var_a1202e1894c2ac35:1, #var_4926875387b9afac:#"danger", #assetname:calloutmarkerping_asset_name( function_1bf3a084cfe14025( 4 ) ) }, { #var_d49c46509d65795a:&function_f18779f23694e7ee, #var_4926875387b9afac:#"enemy", #assetname:calloutmarkerping_asset_name( function_1bf3a084cfe14025( 5 ) ) }, { #var_d49c46509d65795a:&function_2666e6bb892d7b73, #var_4926875387b9afac:#"loot", #assetname:%"loot" } ];
    var_627a5a2fa7f07781 = [ { #var_1f59b6b94efae4ad:1, #var_1279137a54ffa783:#"goto" }, { #var_1f59b6b94efae4ad:2, #var_1279137a54ffa783:#"combat" }, { #var_1f59b6b94efae4ad:3, #var_1279137a54ffa783:#"pickup" } ];
    var_4f4f53e48b00c9d0 = [];
    var_a174b112dc854c52 = [];
    var_3413a5260f041e34 = [];
    
    for ( i = 0; i < var_b3ec47f3e360f28f.size ; i++ )
    {
        var_d26fbc67bd64e3c6 = var_b3ec47f3e360f28f[ i ];
        var_4926875387b9afac = var_d26fbc67bd64e3c6.var_4926875387b9afac;
        
        foreach ( var_1713b4abff885503 in level.var_d4909c0acc55763c.var_b6f3fee5853a5965 )
        {
            if ( getxhash( var_1713b4abff885503.pingtype ) == var_4926875387b9afac )
            {
                var_1279137a54ffa783 = getxhash( var_1713b4abff885503.var_1f59b6b94efae4ad );
                
                foreach ( var_14be4e9b23c3f308 in var_627a5a2fa7f07781 )
                {
                    if ( var_14be4e9b23c3f308.var_1279137a54ffa783 == var_1279137a54ffa783 )
                    {
                        assetname = var_d26fbc67bd64e3c6.assetname;
                        var_4f4f53e48b00c9d0[ assetname ] = { #var_2b7b22938092bf44:var_1713b4abff885503.score, #var_1f59b6b94efae4ad:var_14be4e9b23c3f308.var_1f59b6b94efae4ad };
                        
                        if ( var_d26fbc67bd64e3c6.var_a1202e1894c2ac35 )
                        {
                            var_7799ecb140297e5c = var_1713b4abff885503.var_7799ecb140297e5c;
                            
                            if ( var_7799ecb140297e5c > 0 )
                            {
                                var_a174b112dc854c52[ assetname ] = { #var_7799ecb140297e5c:var_7799ecb140297e5c };
                            }
                        }
                        
                        var_d49c46509d65795a = var_d26fbc67bd64e3c6.var_d49c46509d65795a;
                        
                        if ( isdefined( var_d49c46509d65795a ) )
                        {
                            data = { #var_d49c46509d65795a:var_d49c46509d65795a, #assetname:assetname };
                            var_3413a5260f041e34[ var_3413a5260f041e34.size ] = data;
                        }
                        
                        break;
                    }
                }
                
                break;
            }
        }
    }
    
    level.var_e953ca10fcae0350 = { #var_4f4f53e48b00c9d0:var_4f4f53e48b00c9d0 };
    
    if ( var_a174b112dc854c52.size > 0 && var_3413a5260f041e34.size > 0 )
    {
        level.var_e953ca10fcae0350.var_a174b112dc854c52 = var_a174b112dc854c52;
        level.var_e953ca10fcae0350.var_3413a5260f041e34 = var_3413a5260f041e34;
    }
}

// Namespace namespace_626c96a2fc3e681b
// Params 2, eflags: 0x4
// Checksum 0xd7dc6e24, Offset: 0x914
// Size: 0x5e
function private function_f18779f23694e7ee( origin, radius )
{
    players = getplayersinradius( origin, radius, undefined, undefined, teams::getteamdata( self.team, "alivePlayers" ) );
    
    if ( players.size <= 1 )
    {
        return players[ 0 ];
    }
    
    closestplayer = function_47c86977a18df38b( players, origin );
    return closestplayer;
}

// Namespace namespace_626c96a2fc3e681b
// Params 2, eflags: 0x4
// Checksum 0xcd9d3939, Offset: 0x97b
// Size: 0x43
function private function_2666e6bb892d7b73( origin, radius )
{
    loots = getlootscriptablearrayinradius( undefined, undefined, origin, radius );
    
    if ( loots.size <= 1 )
    {
        return loots[ 0 ];
    }
    
    loots = sortbydistance( loots, origin );
    return loots[ 0 ];
}

// Namespace namespace_626c96a2fc3e681b
// Params 1, eflags: 0x4
// Checksum 0xb04147bd, Offset: 0x9c7
// Size: 0x2ca
function private function_dd3156cb54f90157( params )
{
    pingowner = params.player;
    
    if ( self != pingowner )
    {
        return;
    }
    
    if ( isbot( self ) || isautopilot( self ) )
    {
        return;
    }
    
    pingindex = params.pingindex;
    assert( isdefined( pingindex ) );
    var_6675b0888e2dbc2 = pingowner function_689a4266a29aac13( pingindex );
    pingassetname = calloutmarkerping_asset_name( var_6675b0888e2dbc2 );
    var_9d93f120aa052575 = level.var_e953ca10fcae0350.var_4f4f53e48b00c9d0[ pingassetname ];
    
    if ( !isdefined( var_9d93f120aa052575 ) )
    {
        return;
    }
    
    var_2c5304a639ab82e9 = function_c8f7a9f5370361df( var_6675b0888e2dbc2 );
    
    if ( var_2c5304a639ab82e9 < 0 )
    {
        return;
    }
    
    pingorigin = pingowner calloutmarkerping_getorigin( pingindex );
    
    if ( !isdefined( pingorigin ) )
    {
        return;
    }
    
    pingdata = { #targetobj:params.obj, #targetpos:pingorigin, #pingassetname:pingassetname, #pingindex:pingindex, #pingowner:pingowner };
    var_16e130db3adab12c = level.var_e953ca10fcae0350.var_a174b112dc854c52[ pingassetname ];
    
    if ( var_16e130db3adab12c )
    {
        maxradius = var_16e130db3adab12c.var_7799ecb140297e5c;
        var_4f7ca3d1910be367 = level.var_e953ca10fcae0350.var_3413a5260f041e34;
        
        for ( i = 0; i < var_4f7ca3d1910be367.size ; i++ )
        {
            var_f4a365605218965e = var_4f7ca3d1910be367[ i ];
            targetobj = pingowner [[ var_f4a365605218965e.var_d49c46509d65795a ]]( pingorigin, maxradius );
            
            if ( targetobj )
            {
                var_9d93f120aa052575 = level.var_e953ca10fcae0350.var_4f4f53e48b00c9d0[ var_f4a365605218965e.assetname ];
                assert( isdefined( var_9d93f120aa052575 ) );
                pingdata.pingassetname = var_f4a365605218965e.assetname;
                pingdata.targetobj = targetobj;
                pingdata.targetpos = targetobj.origin;
                break;
            }
        }
    }
    
    aliveteammembers = teams::getteamdata( pingowner.team, "alivePlayers" );
    
    foreach ( player in aliveteammembers )
    {
        if ( !isbot( player ) )
        {
            continue;
        }
        
        player thread function_dbfc44ff7cc3fec8( pingdata, var_9d93f120aa052575 );
    }
}

// Namespace namespace_626c96a2fc3e681b
// Params 2, eflags: 0xc
// Checksum 0xba4d7c58, Offset: 0xc99
// Size: 0x56
function private function_dbfc44ff7cc3fec8( pingdata, var_9d93f120aa052575 )
{
    self notify( #"hash_bb7f3bc705f591c3" );
    self endon( #"hash_bb7f3bc705f591c3" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    function_3b467177d047e0ca( pingdata, var_9d93f120aa052575 );
    function_f829b62a04f9c88c();
}

// Namespace namespace_626c96a2fc3e681b
// Params 2, eflags: 0x4
// Checksum 0xe6f9025e, Offset: 0xcf7
// Size: 0x199
function private function_3b467177d047e0ca( pingdata, var_9d93f120aa052575 )
{
    self endon( #"hash_e9413e369f9f8414" );
    var_3940c22883d23889 = var_9d93f120aa052575.var_1f59b6b94efae4ad;
    targetobj = pingdata.targetobj;
    targetpos = pingdata.targetpos;
    self._blackboard.var_1e3997f580b222b9 = var_3940c22883d23889;
    self._blackboard.var_7a4f5db94c41d2f4 = var_9d93f120aa052575.var_2b7b22938092bf44;
    self._blackboard.var_a41a196274f307d9 = 1;
    self._blackboard.var_515c0d8a94ebc348 = 0;
    self._blackboard.var_7a1e6d2e941477cf = bots_util_mp::function_1882f18076610076( targetpos );
    self._blackboard.var_ad7c6da883ba5158 = isent( targetobj ) ? targetobj : undefined;
    self._blackboard.var_d0245d5f530be090 = targetobj.classname == "scriptable" ? targetobj : undefined;
    
    if ( var_3940c22883d23889 == 2 )
    {
        targetobj endon( #"death_or_disconnect" );
    }
    else
    {
        pingdata.pingowner endon( "predictiveCalloutClear_" + pingdata.pingindex );
    }
    
    childthread function_686efde4505c1634( pingdata.pingassetname, targetpos );
    wait level.var_d4909c0acc55763c.var_cd50d147e77bcf3a;
    self notify( #"hash_e9413e369f9f8414" );
}

// Namespace namespace_626c96a2fc3e681b
// Params 2, eflags: 0x4
// Checksum 0x392cc96e, Offset: 0xe98
// Size: 0x1d1
function private function_686efde4505c1634( pingassetname, var_4635510ba5a50bf7 )
{
    self waittill( #"hash_6552aac32bd68727" );
    var_78b84313f97c347a = getdvarint( @"hash_5f2bc2ee8e9274bb", 0 );
    
    switch ( self._blackboard.var_1e3997f580b222b9 )
    {
        case 1:
            var_c58dca9cdee981fd = undefined;
            
            if ( var_78b84313f97c347a )
            {
                assert( isdefined( var_4635510ba5a50bf7 ) );
                
                if ( isdefined( var_4635510ba5a50bf7 ) )
                {
                    targetpos = var_4635510ba5a50bf7 + utility::randomvectorrangeflat( 1, 5 );
                    var_c58dca9cdee981fd = calloutmarkerping::function_a3f0d6526c09f579( pingassetname, targetpos );
                }
            }
            
            childthread function_7bc39564aa74eee3( var_c58dca9cdee981fd );
            break;
        case 2:
            if ( var_78b84313f97c347a )
            {
                assert( isdefined( self._blackboard.var_ad7c6da883ba5158 ) );
                
                if ( isdefined( self._blackboard.var_ad7c6da883ba5158 ) )
                {
                    enemyentnum = self._blackboard.var_ad7c6da883ba5158 getentitynumber();
                    function_b2bafe27aa071e25( enemyentnum, pingassetname );
                }
            }
            
            break;
        case 3:
            if ( var_78b84313f97c347a )
            {
                assert( isdefined( self._blackboard.var_d0245d5f530be090 ) );
                
                if ( isdefined( self._blackboard.var_d0245d5f530be090 ) )
                {
                    scriptableindex = self._blackboard.var_d0245d5f530be090 getscriptableindex();
                    calloutmarkerping::function_920a63c06abdefe8( scriptableindex );
                }
            }
            
            break;
        default:
            assertmsg( "<dev string:x90>" + self._blackboard.var_1e3997f580b222b9 + "<dev string:xa8>" );
            break;
    }
}

// Namespace namespace_626c96a2fc3e681b
// Params 1, eflags: 0x4
// Checksum 0xddb89fcd, Offset: 0x1071
// Size: 0x33
function private function_7bc39564aa74eee3( var_c58dca9cdee981fd )
{
    if ( isdefined( var_c58dca9cdee981fd ) )
    {
        self endon( "predictiveCalloutClear_" + var_c58dca9cdee981fd );
    }
    
    self waittill( #"bot_go_to_behavior_done" );
    thread function_ba95400bebf57110( var_c58dca9cdee981fd );
}

// Namespace namespace_626c96a2fc3e681b
// Params 1, eflags: 0x4
// Checksum 0x4e4ec45c, Offset: 0x10ac
// Size: 0x27
function private function_ba95400bebf57110( var_c58dca9cdee981fd )
{
    if ( isdefined( var_c58dca9cdee981fd ) )
    {
        calloutmarkerping::function_7c0ee9d4b604e6d6( var_c58dca9cdee981fd );
    }
    
    self notify( #"hash_e9413e369f9f8414" );
}

// Namespace namespace_626c96a2fc3e681b
// Params 0, eflags: 0x4
// Checksum 0x3a6f00cf, Offset: 0x10db
// Size: 0x3d
function private function_f829b62a04f9c88c()
{
    self._blackboard.var_1e3997f580b222b9 = 0;
    self._blackboard.var_ad7c6da883ba5158 = undefined;
    self._blackboard.var_d0245d5f530be090 = undefined;
}

// Namespace namespace_626c96a2fc3e681b
// Params 2, eflags: 0x4
// Checksum 0xeffeca2d, Offset: 0x1120
// Size: 0x4f
function private function_b2bafe27aa071e25( enemyentnum, var_1a1693d867b8b00b = function_1bf3a084cfe14025( 5 ) )
{
    pingindex = calloutmarkerping::createcallout( var_1a1693d867b8b00b, undefined, enemyentnum );
    
    if ( isdefined( pingindex ) )
    {
        calloutmarkerping::function_f1e90ace095a0aa( "calloutmarkerping_added", pingindex );
    }
    
    return pingindex;
}

