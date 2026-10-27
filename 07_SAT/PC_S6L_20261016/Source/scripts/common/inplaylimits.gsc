// scripts\common\inplaylimits.gsc  (hash_7ad3b2ff8dae166f.gscc) (size: 14432 Bytes / 0x3860 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x65ac4df0 (1705790960)
// size ...... 14432 (0x3860)
// includes .. 2   (offset: 0x3670)
// strings ... 27  (offset: 0x3680)
// dev strs .. 11  (offset: 0x37dc)
// exports ... 24  (offset: 0x2c3c)
// cseg ...... 0x23f + 0x29fd (0x2c3c)
// imports ... 51  (offset: 0x2ffc)
// animtree1 . 0   (offset: 0x3860)
// animtree2 . 0   (offset: 0x3860)
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace inplaylimits;

// Namespace inplaylimits
// Params 0, eflags: 0x1
// Checksum 0x99bfa2fd, Offset: 0x25d
// Size: 0xee
function autoexec main()
{
    if ( getdvarint( @"hash_f2118dfbe39b015d", 0 ) )
    {
        return;
    }
    
    level.in_play_limits = spawnstruct();
    level.in_play_limits.init = &in_play_limits_init;
    level.in_play_limits.var_e46d8978833c534c = &function_ff36b77968221dc0;
    level.in_play_limits.next_id = 1;
    
    /#
        level.in_play_limits.log_durations = getdvarint( @"hash_922a9e8d416818b5", 0 );
    #/
    
    level callback::add( #"killstreak_can_trigger", &_killstreak_can_trigger );
    level callback::add( #"killstreak_finish_use", &function_94fb249f9b7598d1 );
    level callback::add( #"killstreak_trigger_failed", &function_94fb249f9b7598d1 );
    utility::registersharedfunc( #"game", #"hash_377b9525d18c0e38", &function_d23059a40dbb9855 );
}

// Namespace inplaylimits
// Params 0
// Checksum 0x29d00435, Offset: 0x353
// Size: 0xd5
function in_play_limits_init()
{
    if ( getdvarint( @"hash_f2118dfbe39b015d", 0 ) )
    {
        return;
    }
    
    var_11fbc68e4a5f90cf = undefined;
    
    if ( isdefined( level.gametypebundle ) && isdefined( level.gametypebundle.var_479404a77e9942ef ) )
    {
        var_11fbc68e4a5f90cf = getscriptbundle( level.gametypebundle.var_479404a77e9942ef );
    }
    else if ( isdefined( level.gamemodebundle.var_479404a77e9942ef ) )
    {
        var_11fbc68e4a5f90cf = getscriptbundle( level.gamemodebundle.var_479404a77e9942ef );
    }
    
    if ( !isdefined( var_11fbc68e4a5f90cf ) )
    {
        return;
    }
    
    level.inplaylimits = { #match:{}, #teams:[], #rules:[] };
    setup_in_play_limits_rules( var_11fbc68e4a5f90cf );
    level.in_play_limits_in_use = 1;
}

// Namespace inplaylimits
// Params 1
// Checksum 0x83f63b47, Offset: 0x430
// Size: 0x321
function setup_in_play_limits_rules( bundle )
{
    var_11fbc68e4a5f90cf = bundle;
    level.inplaylimits.rules = [];
    
    foreach ( rulegroup in var_11fbc68e4a5f90cf.var_98ea9f9174133c07 )
    {
        foreach ( rule in rulegroup.rulelist )
        {
            assert( !isdefined( level.inplaylimits.rules[ rule.name ] ), "<dev string:x24>" );
            
            switch ( rule.type )
            {
                case #"hash_3208dd912671caa7":
                case #"hash_4af11b8034b04aea":
                    level.inplaylimits.rules[ rule.name ] = rule;
                    
                    if ( isdefined( rule.var_8a51ebbf0748ba6b.permatch ) && isdefined( rule.var_8a51ebbf0748ba6b.perteam ) )
                    {
                        assert( rule.var_8a51ebbf0748ba6b.perteam <= rule.var_8a51ebbf0748ba6b.permatch, "<dev string:x47>" );
                    }
                    
                    if ( isdefined( rule.var_8a51ebbf0748ba6b.permatch ) && isdefined( rule.var_8a51ebbf0748ba6b.perplayer ) )
                    {
                        assert( rule.var_8a51ebbf0748ba6b.perplayer <= rule.var_8a51ebbf0748ba6b.permatch, "<dev string:x87>" );
                    }
                    
                    if ( isdefined( rule.var_8a51ebbf0748ba6b.perteam ) && isdefined( rule.var_8a51ebbf0748ba6b.perplayer ) )
                    {
                        assert( rule.var_8a51ebbf0748ba6b.perplayer <= rule.var_8a51ebbf0748ba6b.perteam, "<dev string:xc9>" );
                    }
                    
                    break;
                case #"hash_9e24f8275769ef4a":
                case #"hash_e823a7a2c9126414":
                    level.inplaylimits.rules[ rule.name ] = rule;
                    break;
                default:
                    assertmsg( "<dev string:x10a>" );
                    break;
            }
        }
    }
}

// Namespace inplaylimits
// Params 1
// Checksum 0xd064f321, Offset: 0x759
// Size: 0xe7
function function_ff36b77968221dc0( bundle )
{
    if ( !level.in_play_limits_in_use )
    {
        return;
    }
    
    if ( isdefined( bundle.inplaylimits ) )
    {
        foreach ( rule in bundle.inplaylimits )
        {
            if ( !isdefined( rule.name ) )
            {
                continue;
            }
            
            assert( isdefined( level.inplaylimits.rules[ rule.name ] ), "<dev string:x12b>" + rule.name );
        }
    }
}

// Namespace inplaylimits
// Params 1
// Checksum 0x26476ce1, Offset: 0x848
// Size: 0x129
function get_limit_per_player( bundle )
{
    limit = undefined;
    
    foreach ( rulegroup in bundle.inplaylimits )
    {
        rule = level.inplaylimits.rules[ rulegroup.name ];
        
        if ( !rule || rule.type != #"hash_4af11b8034b04aea" && rule.type != #"hash_3208dd912671caa7" )
        {
            continue;
        }
        
        if ( !isdefined( limit ) || rule.var_8a51ebbf0748ba6b.perplayer < limit )
        {
            limit = rule.var_8a51ebbf0748ba6b.perplayer;
        }
    }
    
    return limit;
}

// Namespace inplaylimits
// Params 1, eflags: 0x4
// Checksum 0x6efd4c96, Offset: 0x97a
// Size: 0x1a4
function private _killstreak_can_trigger( params )
{
    if ( !level.in_play_limits_in_use || getdvarint( @"hash_f2118dfbe39b015d", 0 ) )
    {
        params.var_1b38ed24a6c4e157 = 1;
        return;
    }
    
    player = params.player;
    var_ae5b65a22d75a42f = params.bundle.inplaylimits;
    instance = { #location:params.location, #endtime:gettime() + ( params.bundle.var_ce39e27ec067b60 ?? 0 ) * 1000, #team:player.team, #player:player };
    
    if ( !params.checkonly )
    {
        instance.var_b35866e4fc1f1f4a = level.in_play_limits.next_id;
        level.in_play_limits.next_id++;
        
        /#
            if ( level.in_play_limits.log_durations )
            {
                instance.starttime = gettime();
            }
        #/
        
        params.var_1b38ed24a6c4e157 = function_2195952a32dcb846( player, var_ae5b65a22d75a42f, params.bundle, instance, params );
        params.var_a5f86abee0af9c2f = instance.var_b35866e4fc1f1f4a;
        return;
    }
    
    params.var_1b38ed24a6c4e157 = function_2195952a32dcb846( player, var_ae5b65a22d75a42f, params.bundle, instance, params );
}

// Namespace inplaylimits
// Params 5, eflags: 0x4
// Checksum 0xe6b0b308, Offset: 0xb26
// Size: 0x182, Type: bool
function private function_2195952a32dcb846( player, var_ae5b65a22d75a42f, bundle, instance, params )
{
    if ( !isdefined( var_ae5b65a22d75a42f ) )
    {
        return true;
    }
    
    if ( !isdefined( player.inplaylimits ) )
    {
        player.inplaylimits = { #counts:[] };
    }
    
    if ( !isdefined( level.inplaylimits.teams[ player.team ] ) )
    {
        level.inplaylimits.teams[ player.team ] = { #counts:[] };
    }
    
    if ( !isdefined( level.inplaylimits.match ) )
    {
        level.inplaylimits.match = { #counts:[] };
    }
    
    [ var_9e5110ba055bcc89, var_60feeb68095b79b5 ] = function_28ec9454a87705ba( player, var_ae5b65a22d75a42f, bundle, instance, params );
    player function_d23059a40dbb9855( var_ae5b65a22d75a42f[ 0 ].name, var_ae5b65a22d75a42f.size, bundle.killstreakref, params.out_errormessage, params.var_a1fa775112b92e7, params.checkonly, var_9e5110ba055bcc89, var_60feeb68095b79b5 );
    
    if ( !var_9e5110ba055bcc89 )
    {
        return false;
    }
    
    if ( !params.checkonly )
    {
        function_d42bcddfb4ddff7c( player, var_ae5b65a22d75a42f, instance );
    }
    
    return true;
}

// Namespace inplaylimits
// Params 5, eflags: 0x4
// Checksum 0xd86ab2b6, Offset: 0xcb1
// Size: 0x522
function private function_28ec9454a87705ba( player, var_ae5b65a22d75a42f, bundle, instance, params )
{
    foreach ( ruleref in var_ae5b65a22d75a42f )
    {
        var_1e90838cbfb13eca = ruleref.name;
        
        if ( !isdefined( var_1e90838cbfb13eca ) )
        {
            continue;
        }
        
        rule = level.inplaylimits.rules[ var_1e90838cbfb13eca ];
        
        switch ( rule.type )
        {
            case #"hash_4af11b8034b04aea":
                if ( !isdefined( player.inplaylimits.counts[ var_1e90838cbfb13eca ] ) )
                {
                    player.inplaylimits.counts[ var_1e90838cbfb13eca ] = {};
                }
                
                if ( !isdefined( level.inplaylimits.teams[ player.team ].counts[ var_1e90838cbfb13eca ] ) )
                {
                    level.inplaylimits.teams[ player.team ].counts[ var_1e90838cbfb13eca ] = {};
                }
                
                if ( !isdefined( level.inplaylimits.match.counts[ var_1e90838cbfb13eca ] ) )
                {
                    level.inplaylimits.match.counts[ var_1e90838cbfb13eca ] = {};
                }
                
                playercount = player.inplaylimits.counts[ var_1e90838cbfb13eca ];
                teamcount = level.inplaylimits.teams[ player.team ].counts[ var_1e90838cbfb13eca ];
                matchcount = level.inplaylimits.match.counts[ var_1e90838cbfb13eca ];
                
                if ( !function_21e90fcabedd7246( rule.var_8a51ebbf0748ba6b, bundle, playercount, teamcount, matchcount, params ) )
                {
                    return [ 0, #"hash_4af11b8034b04aea" ];
                }
                
                break;
            case #"hash_3208dd912671caa7":
                if ( !isdefined( level.inplaylimits.instances ) )
                {
                    level.inplaylimits.instances = [];
                }
                
                if ( !isdefined( level.inplaylimits.instances[ var_1e90838cbfb13eca ] ) )
                {
                    level.inplaylimits.instances[ var_1e90838cbfb13eca ] = [];
                }
                
                instances = level.inplaylimits.instances[ var_1e90838cbfb13eca ];
                err = _check_limits( rule.var_8a51ebbf0748ba6b, bundle, instances, instance );
                
                if ( isdefined( err ) )
                {
                    if ( isdefined( err.message ) )
                    {
                        params.out_errormessage = getscriptbundle( err.message ).message;
                        params.var_a1fa775112b92e7 = int( ( err.nexttime - gettime() ) / 1000 );
                        
                        if ( params.var_a1fa775112b92e7 < 0 )
                        {
                            params.var_a1fa775112b92e7 = 0;
                        }
                    }
                    
                    return [ 0, #"hash_3208dd912671caa7" ];
                }
                
                break;
            case #"hash_9e24f8275769ef4a":
                if ( utility::issharedfuncdefined( #"player", #"hash_ab1b6d347d2c1b81" ) )
                {
                    var_a03205153e43b998 = player [[ utility::getsharedfunc( #"player", #"hash_ab1b6d347d2c1b81" ) ]]();
                    
                    if ( !isdefined( rule.var_631bca71ee8707b7.var_254501460d768e4 ) && var_a03205153e43b998 )
                    {
                        function_970cd9be164dc03a( %"killstreaks/cannot_be_used_aether" );
                        params.out_errormessage = %"killstreaks/cannot_be_used_aether";
                        return [ 0, #"hash_9e24f8275769ef4a" ];
                    }
                }
                
                break;
            case #"hash_e823a7a2c9126414":
                if ( utility::issharedfuncdefined( #"player", #"hash_bb3e9af3250b07c3" ) )
                {
                    var_bf167cec63a078f2 = player [[ utility::getsharedfunc( #"player", #"hash_bb3e9af3250b07c3" ) ]]();
                    
                    if ( !isdefined( rule.var_8632113d4ffcc465.var_2ee888d0bdc27ce6 ) && var_bf167cec63a078f2 )
                    {
                        function_970cd9be164dc03a( %"hash_409a84980fad1e81" );
                        params.out_errormessage = %"hash_409a84980fad1e81";
                        return [ 0, #"hash_e823a7a2c9126414" ];
                    }
                }
                
                break;
        }
    }
    
    return [ 1, #"success" ];
}

// Namespace inplaylimits
// Params 3, eflags: 0x4
// Checksum 0x129853f6, Offset: 0x11dc
// Size: 0x2f4
function private function_d42bcddfb4ddff7c( player, var_ae5b65a22d75a42f, instance )
{
    foreach ( ruleref in var_ae5b65a22d75a42f )
    {
        var_1e90838cbfb13eca = ruleref.name;
        
        if ( !isdefined( var_1e90838cbfb13eca ) )
        {
            continue;
        }
        
        rule = level.inplaylimits.rules[ var_1e90838cbfb13eca ];
        
        if ( rule.type == #"hash_4af11b8034b04aea" )
        {
            if ( !isdefined( player.inplaylimits.counts[ var_1e90838cbfb13eca ] ) )
            {
                player.inplaylimits.counts[ var_1e90838cbfb13eca ] = {};
            }
            
            if ( !isdefined( level.inplaylimits.teams[ player.team ].counts[ var_1e90838cbfb13eca ] ) )
            {
                level.inplaylimits.teams[ player.team ].counts[ var_1e90838cbfb13eca ] = {};
            }
            
            if ( !isdefined( level.inplaylimits.match.counts[ var_1e90838cbfb13eca ] ) )
            {
                level.inplaylimits.match.counts[ var_1e90838cbfb13eca ] = {};
            }
            
            playercount = player.inplaylimits.counts[ var_1e90838cbfb13eca ];
            teamcount = level.inplaylimits.teams[ player.team ].counts[ var_1e90838cbfb13eca ];
            matchcount = level.inplaylimits.match.counts[ var_1e90838cbfb13eca ];
            function_ebccfb7bf30f5efa( rule.var_8a51ebbf0748ba6b, playercount, teamcount, matchcount );
            continue;
        }
        
        if ( rule.type == #"hash_3208dd912671caa7" )
        {
            if ( !isdefined( level.inplaylimits.instances ) )
            {
                level.inplaylimits.instances = [];
            }
            
            if ( !isdefined( level.inplaylimits.instances[ var_1e90838cbfb13eca ] ) )
            {
                level.inplaylimits.instances[ var_1e90838cbfb13eca ] = [];
            }
            
            level.inplaylimits.instances[ var_1e90838cbfb13eca ][ level.inplaylimits.instances[ var_1e90838cbfb13eca ].size ] = instance;
        }
    }
}

// Namespace inplaylimits
// Params 1, eflags: 0x4
// Checksum 0x394547fb, Offset: 0x14d8
// Size: 0x13b
function private function_94fb249f9b7598d1( params )
{
    if ( !level.in_play_limits_in_use || getdvarint( @"hash_f2118dfbe39b015d", 0 ) )
    {
        return;
    }
    
    if ( params.streakinfo.var_dba2ed457f8ace3e )
    {
        thread function_2640fa548d7b1777( params );
        return;
    }
    
    if ( !isdefined( params.var_1b38ed24a6c4e157 ) || params.var_1b38ed24a6c4e157 )
    {
        streakinfo = params.streakinfo;
        owner = streakinfo.owner ?? params.player;
        team = streakinfo.team ?? owner.team;
        bundle = level.streakglobals.streakbundles[ streakinfo.streakname ] ?? params.bundle;
        var_b35866e4fc1f1f4a = streakinfo.var_b35866e4fc1f1f4a ?? params.var_a5f86abee0af9c2f;
        _deregister_deployable( owner, team, bundle.inplaylimits, var_b35866e4fc1f1f4a );
    }
}

// Namespace inplaylimits
// Params 1, eflags: 0x4
// Checksum 0x5a2326da, Offset: 0x161b
// Size: 0x3c5
function private function_2640fa548d7b1777( params )
{
    level endon( #"game_ended" );
    streakinfo = params.streakinfo;
    player = streakinfo.owner ?? params.player;
    var_b35866e4fc1f1f4a = streakinfo.var_b35866e4fc1f1f4a ?? params.var_a5f86abee0af9c2f;
    
    if ( !isdefined( level.inplaylimits.crateinstances ) )
    {
        level.inplaylimits.crateinstances = [];
    }
    
    level.inplaylimits.crateinstances[ var_b35866e4fc1f1f4a ] = { #var_b35866e4fc1f1f4a:var_b35866e4fc1f1f4a, #streakinfo:streakinfo };
    
    if ( !streakinfo.dropresult )
    {
        for ( i = 0; i < 30 ; i++ )
        {
            waitframe();
            
            if ( streakinfo.dropresult )
            {
                break;
            }
        }
    }
    
    result = streakinfo.dropresult;
    
    if ( result && player )
    {
        if ( result.crates && result.crates.size > 0 )
        {
            foreach ( instancearr in level.inplaylimits.instances )
            {
                foreach ( inst in instancearr )
                {
                    if ( inst.var_b35866e4fc1f1f4a == var_b35866e4fc1f1f4a )
                    {
                        instance = inst;
                        break;
                    }
                }
            }
            
            if ( instance )
            {
                longestendtime = 0;
                crates = result.crates;
                
                foreach ( crate in crates )
                {
                    if ( crate.timeouttimestamp && crate.timeouttimestamp > longestendtime )
                    {
                        longestendtime = crate.timeouttimestamp;
                    }
                }
                
                if ( longestendtime > 0 )
                {
                    instance.endtime = longestendtime;
                }
            }
            
            while ( crates.size > 0 )
            {
                arrsize = crates.size;
                
                for ( i = 0; arrsize > 0 && i < arrsize ; i++ )
                {
                    if ( !crates[ i ] || crates[ i ].isdestroyed )
                    {
                        crates = arrayremove( crates, crates[ i ] );
                        arrsize = crates.size ?? 0;
                        i--;
                    }
                }
                
                waitframe();
            }
        }
    }
    
    params.streakinfo.var_dba2ed457f8ace3e = undefined;
    
    if ( level.inplaylimits.crateinstances[ var_b35866e4fc1f1f4a ] )
    {
        level.inplaylimits.crateinstances[ var_b35866e4fc1f1f4a ] = undefined;
    }
    
    function_94fb249f9b7598d1( params );
}

// Namespace inplaylimits
// Params 4, eflags: 0x4
// Checksum 0x5ff70b1d, Offset: 0x19e8
// Size: 0x2a8
function private _deregister_deployable( player, playersteam, var_ae5b65a22d75a42f, var_b35866e4fc1f1f4a )
{
    if ( isdefined( var_ae5b65a22d75a42f ) )
    {
        foreach ( ruleref in var_ae5b65a22d75a42f )
        {
            var_1e90838cbfb13eca = ruleref.name;
            
            if ( !isdefined( var_1e90838cbfb13eca ) )
            {
                continue;
            }
            
            rule = level.inplaylimits.rules[ var_1e90838cbfb13eca ];
            
            if ( rule.type == #"hash_4af11b8034b04aea" )
            {
                playercount = player.inplaylimits.counts[ var_1e90838cbfb13eca ];
                teamcount = level.inplaylimits.teams[ playersteam ].counts[ var_1e90838cbfb13eca ];
                matchcount = level.inplaylimits.match.counts[ var_1e90838cbfb13eca ];
                
                if ( isdefined( rule.var_8a51ebbf0748ba6b ) )
                {
                    function_5d322461c46fcf1d( rule.var_8a51ebbf0748ba6b, playercount, teamcount, matchcount );
                }
                
                continue;
            }
            
            if ( rule.type == #"hash_3208dd912671caa7" )
            {
                if ( !isdefined( level.inplaylimits.instances[ var_1e90838cbfb13eca ] ) )
                {
                    level.inplaylimits.instances[ var_1e90838cbfb13eca ] = [];
                }
                
                instances = level.inplaylimits.instances[ var_1e90838cbfb13eca ];
                idx = function_28ad53a392bb67f5( instances, var_b35866e4fc1f1f4a );
                
                if ( isdefined( idx ) )
                {
                    /#
                        if ( level.in_play_limits.log_durations )
                        {
                            instance = instances[ idx ];
                            duration = ( gettime() - instance.starttime ) / 1000;
                            iprintln( "<dev string:x14d>" + var_1e90838cbfb13eca + "<dev string:x15d>" + duration );
                        }
                    #/
                    
                    level.inplaylimits.instances[ var_1e90838cbfb13eca ][ idx ] = undefined;
                    
                    if ( isint( idx ) )
                    {
                        function_cdc669dbc8ea2101( level.inplaylimits.instances[ var_1e90838cbfb13eca ] );
                    }
                }
            }
        }
    }
}

// Namespace inplaylimits
// Params 2, eflags: 0x4
// Checksum 0x6fcf434, Offset: 0x1c98
// Size: 0x52
function private function_28ad53a392bb67f5( instances, var_b35866e4fc1f1f4a )
{
    for ( i = 0; i < instances.size ; i++ )
    {
        instance = instances[ i ];
        
        if ( instance.var_b35866e4fc1f1f4a === var_b35866e4fc1f1f4a )
        {
            return i;
        }
    }
}

// Namespace inplaylimits
// Params 4, eflags: 0x4
// Checksum 0x6a40e60d, Offset: 0x1cf3
// Size: 0x6a, Type: bool
function private function_25512c6b26ec0239( limit, countval, var_d1b65d2fee03740c, params )
{
    if ( countval >= limit )
    {
        if ( var_d1b65d2fee03740c )
        {
            var_67425a0e6f77eb94 = getscriptbundle( var_d1b65d2fee03740c ).message;
            function_970cd9be164dc03a( var_67425a0e6f77eb94 );
            params.out_errormessage = var_67425a0e6f77eb94;
        }
        
        return false;
    }
    
    return true;
}

// Namespace inplaylimits
// Params 6, eflags: 0x4
// Checksum 0xc9b915bf, Offset: 0x1d66
// Size: 0xc6, Type: bool
function private function_21e90fcabedd7246( var_8a51ebbf0748ba6b, bundle, playercount, teamcount, matchcount, params )
{
    if ( !function_25512c6b26ec0239( var_8a51ebbf0748ba6b.perplayer, playercount.count, bundle.var_43fb090f08d11c53, params ) || !function_25512c6b26ec0239( var_8a51ebbf0748ba6b.perteam, teamcount.count, bundle.var_dc7520f979ba50cf, params ) || !function_25512c6b26ec0239( var_8a51ebbf0748ba6b.permatch, matchcount.count, bundle.var_f1809fdcda3c10a7, params ) )
    {
        return false;
    }
    
    return true;
}

// Namespace inplaylimits
// Params 4, eflags: 0x4
// Checksum 0xd51f72b8, Offset: 0x1e35
// Size: 0x326
function private _check_limits( limits, bundle, instances, new_instance )
{
    playerinstances = 0;
    teaminstances = 0;
    matchinstances = 0;
    radiusinstances = 0;
    radius2 = squared( limits.radius ?? 0 );
    var_de28e379cb3cbb7 = undefined;
    nextteamtime = undefined;
    nextmatchtime = undefined;
    var_a02b1a34afe1ab3c = undefined;
    ret = { #message:undefined, #nexttime:0 };
    
    foreach ( instance in instances )
    {
        if ( limits.perplayer )
        {
            if ( instance.player === new_instance.player )
            {
                playerinstances++;
                var_de28e379cb3cbb7 = _safe_min_time( var_de28e379cb3cbb7, instance.endtime );
                
                if ( playerinstances >= limits.perplayer )
                {
                    ret.nexttime = var_de28e379cb3cbb7;
                    ret.message = bundle.var_43fb090f08d11c53;
                    return ret;
                }
            }
        }
        
        if ( limits.perteam )
        {
            if ( instance.team === new_instance.team )
            {
                teaminstances++;
                nextteamtime = _safe_min_time( nextteamtime, instance.endtime );
                
                if ( teaminstances >= limits.perteam )
                {
                    ret.nexttime = nextteamtime;
                    ret.message = bundle.var_dc7520f979ba50cf;
                    return ret;
                }
            }
        }
        
        if ( limits.permatch )
        {
            matchinstances++;
            nextmatchtime = _safe_min_time( nextmatchtime, instance.endtime );
            
            if ( matchinstances >= limits.permatch )
            {
                ret.nexttime = nextmatchtime;
                ret.message = bundle.var_f1809fdcda3c10a7;
                return ret;
            }
        }
        
        if ( limits.perradius && isdefined( instance.location ) && isdefined( new_instance.location ) && radius2 > 0 )
        {
            distance2 = distancesquared( instance.location, new_instance.location );
            
            if ( distance2 <= radius2 )
            {
                radiusinstances++;
                var_a02b1a34afe1ab3c = _safe_min_time( var_a02b1a34afe1ab3c, instance.endtime );
                
                if ( radiusinstances >= limits.perradius )
                {
                    ret.nexttime = var_a02b1a34afe1ab3c;
                    ret.message = bundle.var_fc7f6d005a492c56;
                    return ret;
                }
            }
        }
    }
}

// Namespace inplaylimits
// Params 2, eflags: 0x4
// Checksum 0x2e3fdd15, Offset: 0x2164
// Size: 0x42
function private _safe_min_time( a, b )
{
    if ( isdefined( a ) && isdefined( b ) )
    {
        return min( a, b );
    }
    
    var_7237854e3be197ca = a;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    return b;
}

// Namespace inplaylimits
// Params 2, eflags: 0x4
// Checksum 0x9d3a744f, Offset: 0x21af
// Size: 0x57
function private function_970cd9be164dc03a( var_67425a0e6f77eb94, optionalparam )
{
    if ( !isdefined( var_67425a0e6f77eb94 ) )
    {
        return;
    }
    
    if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
    {
        self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( var_67425a0e6f77eb94, optionalparam );
    }
}

// Namespace inplaylimits
// Params 4, eflags: 0x4
// Checksum 0xee5be489, Offset: 0x220e
// Size: 0x110
function private function_ebccfb7bf30f5efa( var_8a51ebbf0748ba6b, playercount, teamcount, matchcount )
{
    var_10b43cab49cfb4d0 = isdefined( playercount.count ) ? playercount.count + 1 : 1;
    var_6c0937b16016d364 = isdefined( teamcount.count ) ? teamcount.count + 1 : 1;
    var_87b3096f068df94c = isdefined( matchcount.count ) ? matchcount.count + 1 : 1;
    playercount.count = isdefined( var_8a51ebbf0748ba6b.perplayer ) ? var_10b43cab49cfb4d0 : undefined;
    teamcount.count = isdefined( var_8a51ebbf0748ba6b.perteam ) ? var_6c0937b16016d364 : undefined;
    matchcount.count = isdefined( var_8a51ebbf0748ba6b.permatch ) ? var_87b3096f068df94c : undefined;
}

// Namespace inplaylimits
// Params 4, eflags: 0x4
// Checksum 0x7fafc695, Offset: 0x2326
// Size: 0x16e
function private function_5d322461c46fcf1d( var_8a51ebbf0748ba6b, playercount, teamcount, matchcount )
{
    if ( isdefined( var_8a51ebbf0748ba6b.perplayer ) && isdefined( playercount.count ) )
    {
        assert( playercount.count > 0, "<dev string:x164>" );
        playercount.count -= 1;
        
        if ( playercount.count == 0 )
        {
            playercount.count = undefined;
        }
    }
    
    if ( isdefined( var_8a51ebbf0748ba6b.perteam ) && isdefined( teamcount.count ) )
    {
        assert( teamcount.count > 0, "<dev string:x1a4>" );
        teamcount.count -= 1;
        
        if ( teamcount.count == 0 )
        {
            teamcount.count = undefined;
        }
    }
    
    if ( isdefined( var_8a51ebbf0748ba6b.permatch ) && isdefined( matchcount.count ) )
    {
        assert( matchcount.count > 0, "<dev string:x1e2>" );
        matchcount.count -= 1;
        
        if ( matchcount.count == 0 )
        {
            matchcount.count = undefined;
        }
    }
}

// Namespace inplaylimits
// Params 1, eflags: 0x4
// Checksum 0x15092d7, Offset: 0x249c
// Size: 0x171
function private function_99ed80197a6691b( var_1e90838cbfb13eca )
{
    if ( getdvarint( @"hash_8aba3b1a71317207", 0 ) )
    {
        return;
    }
    
    if ( level.inplaylimits.instances[ var_1e90838cbfb13eca ] )
    {
        foreach ( instance in level.inplaylimits.instances[ var_1e90838cbfb13eca ] )
        {
            if ( isdefined( instance ) && !function_ac3df33fdf29bc45( instance ) )
            {
                msg = "inPlayLimitsId [ " + ( instance.var_b35866e4fc1f1f4a ?? "-1" ) + " ] - playerXUID [ " + ( instance.player getxuid() ?? "unknown" ) + " ] - an instance of " + ( getscriptbundlefieldvalue( instance.id, #"hash_fac9242d98a23ee8" ) ?? "unknown" ) + " was not properly deregistered!";
                assertmsg( msg );
                level.inplaylimits.instances[ var_1e90838cbfb13eca ] = arrayremove( level.inplaylimits.instances[ var_1e90838cbfb13eca ], instance );
            }
        }
    }
}

// Namespace inplaylimits
// Params 1, eflags: 0x4
// Checksum 0x64550cc7, Offset: 0x2615
// Size: 0x3cc
function private function_ac3df33fdf29bc45( instance )
{
    if ( level.inplaylimits.crateinstances[ instance.var_b35866e4fc1f1f4a ] )
    {
        if ( level.inplaylimits.crateinstances[ instance.var_b35866e4fc1f1f4a ].streakinfo.dropresult.crates )
        {
            longestendtime = 0;
            
            foreach ( crate in level.inplaylimits.crateinstances[ instance.var_b35866e4fc1f1f4a ].streakinfo.dropresult.crates )
            {
                if ( crate.timeouttimestamp && crate.timeouttimestamp > longestendtime )
                {
                    longestendtime = crate.timeouttimestamp;
                }
            }
            
            return ( longestendtime > 0 && longestendtime > gettime() );
        }
        
        return 1;
    }
    
    if ( level.activekillstreaks )
    {
        foreach ( var_b971a01f5c15b1e in level.activekillstreaks )
        {
            if ( var_b971a01f5c15b1e.streakinfo.var_b35866e4fc1f1f4a == instance.var_b35866e4fc1f1f4a )
            {
                return ( instance.endtime && instance.endtime > gettime() );
            }
        }
    }
    
    if ( getscriptbundlefieldvalue( instance.id, #"spawnweapon" ) || getscriptbundlefieldvalue( instance.id, #"hash_26f518f2347e6745" ) )
    {
        killstreakref = getscriptbundlefieldvalue( instance.id, #"hash_fac9242d98a23ee8" );
        
        foreach ( key in [ "Killstreak_Air", "Killstreak_Ground", "Killstreak_Static" ] )
        {
            if ( level.activesentients[ key ] )
            {
                foreach ( sentient in level.activesentients[ key ] )
                {
                    if ( sentient.streakname == killstreakref && sentient.owner == instance.player )
                    {
                        return 1;
                    }
                }
            }
        }
        
        return;
    }
    
    if ( instance.endtime && instance.endtime > gettime() )
    {
        return 1;
    }
}

// Namespace inplaylimits
// Params 8
// Checksum 0x2aee67ef, Offset: 0x29e9
// Size: 0x253
function function_d23059a40dbb9855( var_2155599205e5bcdc, var_8fe54cb7bbffdd06, killstreakref, errormessage, var_6595cc22fb547b90, var_8e6d1753acc6d438, var_9e5110ba055bcc89, var_60feeb68095b79b5 )
{
    player = self;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    eventparams = [];
    eventparams[ eventparams.size ] = "killstreak_name";
    eventparams[ eventparams.size ] = killstreakref ?? "";
    eventparams[ eventparams.size ] = "player_ads_state";
    eventparams[ eventparams.size ] = player playerads() ?? 0;
    eventparams[ eventparams.size ] = "notification_state";
    eventparams[ eventparams.size ] = var_60feeb68095b79b5 ?? #"";
    eventparams[ eventparams.size ] = "did_pass_rules";
    eventparams[ eventparams.size ] = var_9e5110ba055bcc89 ?? -1;
    eventparams[ eventparams.size ] = "first_rules_name";
    eventparams[ eventparams.size ] = var_2155599205e5bcdc ?? "";
    eventparams[ eventparams.size ] = "rules_name_size";
    eventparams[ eventparams.size ] = var_8fe54cb7bbffdd06 ?? -1;
    eventparams[ eventparams.size ] = "player_team";
    eventparams[ eventparams.size ] = player.team;
    eventparams[ eventparams.size ] = "error_message";
    var_2fe7bb158c5bc8b4 = ( errormessage ?? "none" ) + "";
    var_dea50b2211c233fe = isstring( var_2fe7bb158c5bc8b4 ) ? var_2fe7bb158c5bc8b4 : "none";
    eventparams[ eventparams.size ] = var_dea50b2211c233fe;
    eventparams[ eventparams.size ] = "error_message_param";
    eventparams[ eventparams.size ] = var_6595cc22fb547b90 ?? -1;
    eventparams[ eventparams.size ] = "is_check_only";
    eventparams[ eventparams.size ] = var_8e6d1753acc6d438 ?? -1;
    eventparams[ eventparams.size ] = "game_time";
    eventparams[ eventparams.size ] = int( gettime() / 1000 );
    eventparams[ eventparams.size ] = "map_name";
    eventparams[ eventparams.size ] = level.mapname ?? "";
    eventparams[ eventparams.size ] = "playlist_id";
    eventparams[ eventparams.size ] = getplaylistid() ?? 0;
    eventparams[ eventparams.size ] = "playlist_name";
    eventparams[ eventparams.size ] = getplaylistname() ?? "";
    eventparams[ eventparams.size ] = "circle_index";
    eventparams[ eventparams.size ] = level.br_circle.circleindex ?? -1;
    player dlog_recordplayerevent( "dlog_event_scr_in_play_limits", eventparams );
}

