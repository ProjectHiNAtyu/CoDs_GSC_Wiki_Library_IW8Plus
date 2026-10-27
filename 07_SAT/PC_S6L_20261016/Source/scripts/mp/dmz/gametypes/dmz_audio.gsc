// scripts\mp\dmz\gametypes\dmz_audio.gsc  (hash_486c4bb8f592ed72.gscc) (size: 8878 Bytes / 0x22ae / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x64479b26 (1682414374)
// size ...... 8878 (0x22ae)
// includes .. 5   (offset: 0x206e)
// strings ... 13  (offset: 0x2096)
// dev strs .. 26  (offset: 0x2172)
// exports ... 23  (offset: 0x15aa)
// cseg ...... 0xee + 0x14bc (0x15aa)
// imports ... 50  (offset: 0x1942)
// animtree1 . 0   (offset: 0x22ae)
// animtree2 . 0   (offset: 0x22ae)
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\br\gametypes\br_dmz_radiation;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\player;

#namespace dmz_audio;

// Namespace dmz_audio
// Params 1, eflags: 0x4
// Checksum 0x48bbd787, Offset: 0x10c
// Size: 0x3d
function private function_65031d7364ea58d9( music )
{
    musicstate = audio_utility::function_d4d265f3dcd0a13c( music );
    
    if ( musicstate == "" && music != "" )
    {
        musicstate = music;
    }
    
    return musicstate;
}

// Namespace dmz_audio
// Params 1
// Checksum 0xaf7882f0, Offset: 0x152
// Size: 0x32
function function_80442290b97957a5( music_pack_state )
{
    var_845a3ad27c199c21 = undefined;
    
    if ( !isdefined( music_pack_state ) )
    {
        return;
    }
    
    if ( music_pack_state == 1 )
    {
        var_845a3ad27c199c21 = "_classic";
    }
    
    return var_845a3ad27c199c21;
}

// Namespace dmz_audio
// Params 4
// Checksum 0xe513c626, Offset: 0x18d
// Size: 0xb0
function function_1219191cbcd38758( players, music, delaytime, music_pack_state )
{
    if ( !isdefined( music ) )
    {
        return;
    }
    
    if ( !isdefined( music_pack_state ) )
    {
        music_pack_state = music;
    }
    
    if ( br_dmz_radiation::function_ab7a4adeb9f8baa3() )
    {
        return;
    }
    
    assert( isarray( players ), "<dev string:x24>" );
    assert( isstring( music ), "<dev string:x57>" );
    
    if ( !isdefined( delaytime ) )
    {
        delaytime = 0;
    }
    
    musicstate = function_65031d7364ea58d9( music );
    var_845a3ad27c199c21 = function_65031d7364ea58d9( music_pack_state );
    level utility::delaythread( delaytime, &audio_utility::function_6a0ed3b9fb942369, players, musicstate, undefined, undefined, var_845a3ad27c199c21 );
}

// Namespace dmz_audio
// Params 4
// Checksum 0x76c7adb7, Offset: 0x245
// Size: 0xaf
function function_32ff837bc21a4833( teamname, music, delaytime, music_pack_state )
{
    if ( !isdefined( music ) )
    {
        return;
    }
    
    if ( br_dmz_radiation::function_ab7a4adeb9f8baa3() )
    {
        return;
    }
    
    if ( !isdefined( music_pack_state ) )
    {
        music_pack_state = music;
    }
    
    assert( isstring( music ), "<dev string:x88>" );
    assert( isstring( teamname ), "<dev string:xb6>" );
    
    if ( !isdefined( delaytime ) )
    {
        delaytime = 0;
    }
    
    musicstate = function_65031d7364ea58d9( music );
    var_845a3ad27c199c21 = function_65031d7364ea58d9( music_pack_state );
    level utility::delaythread( delaytime, &audio_utility::function_bbf712dc44d33e6c, teamname, musicstate, undefined, var_845a3ad27c199c21 );
}

// Namespace dmz_audio
// Params 2
// Checksum 0xe6b89e2e, Offset: 0x2fc
// Size: 0x9b
function function_4236692bdfcce4c0( teams, music )
{
    assert( isarray( teams ), "<dev string:xe7>" );
    
    foreach ( team in teams )
    {
        function_32ff837bc21a4833( music, team );
    }
}

// Namespace dmz_audio
// Params 6
// Checksum 0x59ac2026, Offset: 0x39f
// Size: 0xc3
function function_216c2a864f98c136( teamname, var_fe6c867545324e40, radius, music, delaytime, music_pack_state )
{
    if ( !isdefined( music ) )
    {
        return;
    }
    
    if ( !isdefined( music_pack_state ) )
    {
        music_pack_state = music;
    }
    
    if ( br_dmz_radiation::function_ab7a4adeb9f8baa3() )
    {
        return;
    }
    
    assert( isnumber( radius ), "<dev string:x116>" );
    assert( isstring( music ), "<dev string:x154>" );
    assert( isstring( teamname ), "<dev string:x191>" );
    
    if ( !isdefined( delaytime ) )
    {
        delaytime = 0;
    }
    
    musicstate = function_65031d7364ea58d9( music );
    level utility::delaythread( delaytime, &audio_utility::function_1012cb0220d80268, var_fe6c867545324e40, radius, musicstate, teamname, music_pack_state );
}

// Namespace dmz_audio
// Params 5
// Checksum 0x2b978567, Offset: 0x46a
// Size: 0x16c
function function_ffc133facd17db2e( music_target, players, music, delay, music_pack_state )
{
    assert( isent( music_target ) || isstruct( music_target ), "<dev string:x1d1>" );
    assert( isarray( music_target.musicplayers ), "<dev string:x209>" );
    assert( isarray( players ), "<dev string:x241>" );
    players = arrayremove( players, music_target.musicplayers );
    
    if ( isarray( players ) && players.size > 0 )
    {
        var_845a3ad27c199c21 = undefined;
        
        if ( isdefined( music_pack_state ) )
        {
            var_845a3ad27c199c21 = music + function_80442290b97957a5( music_pack_state );
        }
        
        function_1219191cbcd38758( players, music, delay, var_845a3ad27c199c21 );
        
        foreach ( player in players )
        {
            if ( isplayer( player ) )
            {
                playerentnum = player getentitynumber();
                music_target.musicplayers[ playerentnum ] = player;
                player.var_3a50dbe4335453df = 1;
            }
        }
    }
}

// Namespace dmz_audio
// Params 4
// Checksum 0x925c5df, Offset: 0x5de
// Size: 0x12b
function function_41ffc559a3cd26b4( music_target, players, music, delay )
{
    assert( isent( music_target ) || isstruct( music_target ), "<dev string:x274>" );
    assert( isarray( music_target.musicplayers ), "<dev string:x2ac>" );
    assert( isarray( players ), "<dev string:x2e4>" );
    
    if ( isarray( players ) && players.size > 0 )
    {
        function_1219191cbcd38758( players, music, delay );
        
        foreach ( player in players )
        {
            if ( isplayer( player ) )
            {
                playerentnum = player getentitynumber();
                music_target.musicplayers[ playerentnum ] = undefined;
                player.var_3a50dbe4335453df = undefined;
            }
        }
    }
}

// Namespace dmz_audio
// Params 7
// Checksum 0x105f5b8a, Offset: 0x711
// Size: 0x9f
function function_3b49ff0e58710772( music_target, var_fe6c867545324e40, radius, team, music, delay, music_pack_state )
{
    assert( isent( music_target ) || isstruct( music_target ), "<dev string:x317>" );
    assert( isarray( music_target.musicplayers ), "<dev string:x35b>" );
    players = audio_utility::function_82af6589c060fd56( var_fe6c867545324e40, radius, team );
    function_ffc133facd17db2e( music_target, players, music, delay, music_pack_state );
}

// Namespace dmz_audio
// Params 4
// Checksum 0x3023d751, Offset: 0x7b8
// Size: 0x143
function function_2f9b8fd2e5bd3e08( players, music, delaytime, music_pack_state )
{
    if ( !isdefined( music ) )
    {
        return;
    }
    
    if ( br_dmz_radiation::function_ab7a4adeb9f8baa3() )
    {
        return;
    }
    
    assert( isstring( music ), "<dev string:x39f>" );
    
    if ( !isdefined( delaytime ) )
    {
        delaytime = 0;
    }
    
    musicstate = function_65031d7364ea58d9( music );
    var_a24caf795f0078ab = [];
    
    foreach ( player in players )
    {
        if ( isplayer( player ) )
        {
            isplayingmusic = player.var_3a50dbe4335453df || player.var_646195396fad84ff;
            
            if ( !isplayingmusic )
            {
                var_a24caf795f0078ab[ var_a24caf795f0078ab.size ] = player;
            }
        }
    }
    
    var_845a3ad27c199c21 = undefined;
    
    if ( isdefined( music_pack_state ) )
    {
        var_845a3ad27c199c21 = music + function_80442290b97957a5( music_pack_state );
    }
    
    function_1219191cbcd38758( var_a24caf795f0078ab, music, delaytime, var_845a3ad27c199c21 );
}

// Namespace dmz_audio
// Params 6
// Checksum 0x75d2da00, Offset: 0x903
// Size: 0x94
function function_7cdcb48a384ae13( team_name, var_fe6c867545324e40, radius, music, delaytime, music_pack_state )
{
    if ( !isdefined( music ) )
    {
        return;
    }
    
    if ( br_dmz_radiation::function_ab7a4adeb9f8baa3() )
    {
        return;
    }
    
    assert( isnumber( radius ), "<dev string:x3df>" );
    assert( isstring( team_name ), "<dev string:x424>" );
    players = audio_utility::function_82af6589c060fd56( var_fe6c867545324e40, radius, team_name );
    function_2f9b8fd2e5bd3e08( players, music, delaytime, music_pack_state );
}

// Namespace dmz_audio
// Params 1
// Checksum 0xbc882680, Offset: 0x99f
// Size: 0xa4
function function_9d4682c6dd3a8ee0( array )
{
    newarray = [];
    
    foreach ( member in array )
    {
        is_really_alive = player::isreallyalive( member );
        
        if ( !is_really_alive )
        {
            continue;
        }
        
        newarray[ newarray.size ] = member;
    }
    
    return newarray;
}

// Namespace dmz_audio
// Params 4
// Checksum 0x47be5543, Offset: 0xa4c
// Size: 0x62
function function_21f1963303667d2b( players, origin, radius, team )
{
    playersinside = audio_utility::function_82af6589c060fd56( origin, radius, team );
    playersoutside = arrayremove( players, playersinside );
    playersliving = function_9d4682c6dd3a8ee0( playersoutside );
    return playersliving;
}

// Namespace dmz_audio
// Params 1
// Checksum 0xac21e8d5, Offset: 0xab7
// Size: 0x33
function function_2338173da78baaa2( players )
{
    playersliving = function_9d4682c6dd3a8ee0( players );
    playersdead = arrayremove( players, playersliving );
    return playersdead;
}

// Namespace dmz_audio
// Params 4
// Checksum 0xa41f63e1, Offset: 0xaf3
// Size: 0x84
function function_175b00a2b3f9a649( players, origin, radius, team )
{
    playersinside = audio_utility::function_82af6589c060fd56( origin, radius, team );
    playersoutside = arrayremove( players, playersinside );
    playersliving = function_9d4682c6dd3a8ee0( playersinside );
    playersdead = arrayremove( playersinside, playersliving );
    var_badccd633becf510 = arraycombine( playersoutside, playersdead );
    return var_badccd633becf510;
}

// Namespace dmz_audio
// Params 3
// Checksum 0xfa1351e, Offset: 0xb80
// Size: 0x19f
function function_d8888de6d347bd96( agent, alertmillisec = 12000, idlemillisec = 30000 )
{
    if ( !isdefined( agent ) )
    {
        return;
    }
    
    state = undefined;
    
    if ( isnumber( agent.health ) && agent.health <= 0 )
    {
        state = "dead";
        return state;
    }
    
    var_39b310971bc4dc3c = agent.lastenemysighttime ?? 0;
    
    if ( isarray( agent.attackerdata ) )
    {
        foreach ( attackerdata in agent.attackerdata )
        {
            if ( isnumber( attackerdata.lasttimedamaged ) && attackerdata.lasttimedamaged > var_39b310971bc4dc3c )
            {
                var_39b310971bc4dc3c = attackerdata.lasttimedamaged;
            }
        }
    }
    
    if ( var_39b310971bc4dc3c == 0 )
    {
        state = "idle";
    }
    else
    {
        now = gettime();
        var_a49d8cb8f3c98aef = now - var_39b310971bc4dc3c;
        
        if ( var_a49d8cb8f3c98aef >= idlemillisec )
        {
            state = "idle";
        }
        else if ( var_a49d8cb8f3c98aef >= alertmillisec )
        {
            state = "alert";
        }
        else if ( var_a49d8cb8f3c98aef < alertmillisec )
        {
            state = "combat";
        }
    }
    
    return state;
}

// Namespace dmz_audio
// Params 3
// Checksum 0x5a533642, Offset: 0xd28
// Size: 0x135
function function_e69583bff28ed75( vehicle, alertmillisec = 12000, idlemillisec = 30000 )
{
    state = undefined;
    
    if ( isdefined( vehicle ) && isstring( vehicle.currentstate ) )
    {
        state = vehicle.currentstate;
    }
    
    if ( !isdefined( vehicle.var_e9b46b866c1fd162 ) )
    {
        vehicle.var_e9b46b866c1fd162 = 0;
    }
    
    if ( isstring( state ) && ( state == "attack" || state == "combat" ) )
    {
        vehicle.var_e9b46b866c1fd162 = gettime();
    }
    
    if ( isnumber( vehicle.var_e9b46b866c1fd162 ) )
    {
        if ( vehicle.var_e9b46b866c1fd162 == 0 )
        {
            state = "idle";
        }
        else
        {
            now = gettime();
            elapsedcombattime = now - vehicle.var_e9b46b866c1fd162;
            
            if ( elapsedcombattime >= idlemillisec )
            {
                state = "idle";
            }
            else if ( elapsedcombattime >= alertmillisec )
            {
                state = "alert";
            }
            else if ( elapsedcombattime < alertmillisec )
            {
                state = "combat";
            }
        }
    }
    
    return state;
}

// Namespace dmz_audio
// Params 3
// Checksum 0x2b7ccf47, Offset: 0xe66
// Size: 0x8c
function function_6b2f004cc0c9ff80( ent, alertmillisec, idlemillisec )
{
    state = "???";
    
    if ( isdefined( ent ) && isstring( ent.classname ) )
    {
        if ( isagent( ent ) )
        {
            state = function_d8888de6d347bd96( ent, alertmillisec, idlemillisec );
        }
        else if ( ent.classname == "script_vehicle" )
        {
            state = function_e69583bff28ed75( ent );
        }
    }
    
    if ( !isdefined( state ) )
    {
        state = "???";
    }
    
    return state;
}

// Namespace dmz_audio
// Params 1
// Checksum 0x225088c8, Offset: 0xefb
// Size: 0xde
function function_64cd034bf13ce6ad( ent )
{
    enemy = undefined;
    
    if ( isdefined( ent ) && isstring( ent.classname ) )
    {
        if ( isagent( ent ) )
        {
            enemy = ent.enemy;
        }
        else if ( ent.classname == "script_vehicle" )
        {
            if ( ent vehicle::get_ref() == "dmz_boss_chopper" && utility::issharedfuncdefined( #"hash_37cac6252dfd9aa0", #"chopper_getcurrenttargetplayer" ) )
            {
                enemy = level [[ utility::getsharedfunc( #"hash_37cac6252dfd9aa0", #"chopper_getcurrenttargetplayer" ) ]]( ent );
            }
            else if ( ent vehicle::get_ref() == "pac_sentry" )
            {
                enemy = ent.var_d60900a636f6f4c1;
            }
            else
            {
                enemy = ent.enemy;
            }
        }
    }
    
    return enemy;
}

// Namespace dmz_audio
// Params 5
// Checksum 0x5d84c6a5, Offset: 0xfe2
// Size: 0x40c
function function_867bb9baf47763bc( bossinstance, musicstatearray, alertmillisec, idlemillisec, music_pack_state )
{
    level endon( #"game_ended" );
    bossinstance notify( #"hash_d43e879fe9d7f02b" );
    bossinstance endon( #"hash_d43e879fe9d7f02b" );
    assert( isnumber( level.var_fe7fd84db447fe0b ), "<dev string:x46c>" );
    assert( isnumber( level.var_3c1f70b9e3e0dc10 ), "<dev string:x4b2>" );
    assert( isstruct( bossinstance ), "<dev string:x4f9>" );
    assert( isarray( musicstatearray ), "<dev string:x530>" );
    
    if ( !isarray( bossinstance.musicplayers ) )
    {
        bossinstance.musicplayers = [];
    }
    
    bossinstance.var_4ef10bc9f3b5040f = alertmillisec;
    bossinstance.var_20724260a310a4e9 = idlemillisec;
    state = "idle";
    enemy = undefined;
    state_last = "idle";
    enemy_last = undefined;
    killer = undefined;
    var_845a3ad27c199c21 = undefined;
    
    while ( !bossinstance.killed )
    {
        boss = bossinstance.boss ?? bossinstance.agent;
        state = function_6b2f004cc0c9ff80( boss, alertmillisec, idlemillisec );
        enemy = function_64cd034bf13ce6ad( boss );
        hasnewstate = isstring( state ) && state != state_last;
        hasnewenemy = isdefined( enemy ) && isdefined( enemy_last ) && enemy != enemy_last || isdefined( enemy ) && !isdefined( enemy_last );
        assert( isarray( bossinstance.musicplayers ), "<dev string:x56a>" );
        
        if ( hasnewstate || hasnewenemy )
        {
            if ( state == "dead" )
            {
                break;
            }
            
            mpair = musicstatearray[ state ];
            
            if ( isarray( mpair ) && isstring( mpair[ 0 ] ) )
            {
                music = mpair[ 0 ];
                delay = mpair[ 1 ];
                var_5f5b0ba1dbdfac92 = isplayer( enemy ) && !arraycontains( bossinstance.musicplayers, enemy );
                
                if ( state == "combat" && var_5f5b0ba1dbdfac92 )
                {
                    function_3b49ff0e58710772( bossinstance, enemy, level.var_fe7fd84db447fe0b, enemy.team, music, delay, music_pack_state );
                }
                else if ( state == "idle" && bossinstance.musicplayers.size > 0 )
                {
                    function_41ffc559a3cd26b4( bossinstance, bossinstance.musicplayers, music, delay );
                }
            }
        }
        
        if ( bossinstance.musicplayers.size > 0 )
        {
            mpair = musicstatearray[ "idle" ];
            is_boss_valid = isent( boss ) && isvector( boss.origin );
            var_d9147a1561c7007c = undefined;
            
            if ( is_boss_valid )
            {
                var_d9147a1561c7007c = function_21f1963303667d2b( bossinstance.musicplayers, boss.origin, level.var_3c1f70b9e3e0dc10 );
            }
            
            if ( isarray( var_d9147a1561c7007c ) && var_d9147a1561c7007c.size > 0 && isarray( mpair ) && isstring( mpair[ 0 ] ) )
            {
                music = mpair[ 0 ];
                delay = mpair[ 1 ];
                function_41ffc559a3cd26b4( bossinstance, var_d9147a1561c7007c, music, delay );
            }
            
            playersdead = function_2338173da78baaa2( bossinstance.musicplayers );
            
            if ( isarray( playersdead ) && playersdead.size > 0 )
            {
                music = "dmz_activity_lose";
                delay = 0;
                function_41ffc559a3cd26b4( bossinstance, playersdead, music, delay );
            }
        }
        
        state_last = state;
        enemy_last = enemy;
        waitcount = randomintrange( 1, 5 );
        waittime = waitcount * 0.05;
        
        if ( isent( boss ) )
        {
            boss utility::waittill_any_timeout( waittime, "death" );
            continue;
        }
        
        wait waittime;
    }
}

// Namespace dmz_audio
// Params 6
// Checksum 0x7dcadb3, Offset: 0x13f6
// Size: 0x108
function function_7c1fc4d7d77d702b( bossinstance, killer, killer_music, killer_music_delay, loser_music, loser_music_delay )
{
    assert( isstruct( bossinstance ), "<dev string:x5a1>" );
    assert( isent( killer ), "<dev string:x5d7>" );
    bossinstance notify( #"hash_d43e879fe9d7f02b" );
    
    if ( isarray( bossinstance.musicplayers ) && bossinstance.musicplayers.size > 0 )
    {
        killer_distance = level.var_fe7fd84db447fe0b * 2;
        killing_team_players = audio_utility::function_82af6589c060fd56( killer, killer_distance, killer.team );
        function_41ffc559a3cd26b4( bossinstance, killing_team_players, killer_music, killer_music_delay );
        
        if ( isdefined( loser_music ) )
        {
            if ( !isdefined( loser_music ) )
            {
                loser_music = "dmz_activity_lose";
            }
            
            if ( !isdefined( loser_music_delay ) )
            {
                loser_music_delay = 3;
            }
            
            function_41ffc559a3cd26b4( bossinstance, bossinstance.musicplayers, loser_music, loser_music_delay );
        }
    }
}

// Namespace dmz_audio
// Params 3
// Checksum 0xb9ef8d20, Offset: 0x1506
// Size: 0xa4
function function_116c1f3773532359( bossinstance, music, music_delay )
{
    assert( isstruct( bossinstance ), "<dev string:x5a1>" );
    bossinstance notify( #"hash_d43e879fe9d7f02b" );
    
    if ( isarray( bossinstance.musicplayers ) && bossinstance.musicplayers.size > 0 )
    {
        musicdistance = level.var_fe7fd84db447fe0b * 2;
        players = audio_utility::function_82af6589c060fd56( bossinstance.boss, musicdistance );
        function_41ffc559a3cd26b4( bossinstance, players, music, music_delay );
    }
}

