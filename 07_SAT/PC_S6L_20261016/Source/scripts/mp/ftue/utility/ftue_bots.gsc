// scripts\mp\ftue\utility\ftue_bots.gsc  (hash_4f2ec5e36fe18c11.gscc) (size: 11988 Bytes / 0x2ed4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdd9b0201 (3717923329)
// size ...... 11988 (0x2ed4)
// includes .. 11  (offset: 0x2d0c)
// strings ... 23  (offset: 0x2d64)
// dev strs .. 0   (offset: 0x2ed4)
// exports ... 33  (offset: 0x1b34)
// cseg ...... 0x269 + 0x18cb (0x1b34)
// imports ... 101 (offset: 0x205c)
// animtree1 . 0   (offset: 0x2ed4)
// animtree2 . 0   (offset: 0x2ed4)
#using script_d74ae0b4aa21186;
#using scripts\common\bots\bots_util;
#using scripts\common\weapon;
#using scripts\mp\bots\bots;
#using scripts\mp\bots\bots_loadout;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\execution;
#using scripts\mp\ftue\utility\ftue_player;
#using scripts\mp\ftue\utility\ftue_vehicles;
#using scripts\mp\operator;
#using scripts\mp\outline;

#namespace ftue_bots;

// Namespace ftue_bots
// Params 1
// Checksum 0xb4432f90, Offset: 0x287
// Size: 0x133
function ftue_bots_spawnbots( bots )
{
    if ( !isdefined( bots ) )
    {
        return;
    }
    
    var_676d913aca1e5be8 = [];
    var_8729ea12d6c466ea = [];
    var_f791bfbb4c7c9e86 = [];
    
    foreach ( bot in bots )
    {
        switch ( bot.spawnpriority )
        {
            case #"hash_7e89154a96f625d":
                var_676d913aca1e5be8[ var_676d913aca1e5be8.size ] = bot;
                break;
            case #"hash_2881ce6c1efb40c5":
                var_8729ea12d6c466ea[ var_8729ea12d6c466ea.size ] = bot;
                break;
            case #"hash_2f27546c22430661":
                var_f791bfbb4c7c9e86[ var_f791bfbb4c7c9e86.size ] = bot;
                break;
            default:
                var_8729ea12d6c466ea[ var_8729ea12d6c466ea.size ] = bot;
                break;
        }
    }
    
    function_2f2439637f8ae24d( var_676d913aca1e5be8, "high_priority_bots_spawned" );
    thread function_2f2439637f8ae24d( var_8729ea12d6c466ea, "mid_priority_bots_spawned" );
    thread function_2616d41fcb034219( var_f791bfbb4c7c9e86, "low_priority_bots_spawned" );
}

// Namespace ftue_bots
// Params 2, eflags: 0x4
// Checksum 0x95b4037b, Offset: 0x3c2
// Size: 0x9b
function private function_2f2439637f8ae24d( bots, notifyflag )
{
    if ( !isdefined( bots[ 0 ] ) )
    {
        return;
    }
    
    foreach ( bot in bots )
    {
        function_451681e1065b7612( bot );
    }
    
    if ( isdefined( notifyflag ) )
    {
        level notify( notifyflag );
    }
}

// Namespace ftue_bots
// Params 2, eflags: 0x4
// Checksum 0x5c3f5dc4, Offset: 0x465
// Size: 0xc5
function private function_2616d41fcb034219( bots, notifyflag )
{
    if ( !isdefined( bots[ 0 ] ) )
    {
        return;
    }
    
    level waittill( #"mid_priority_bots_spawned" );
    
    foreach ( bot in bots )
    {
        while ( level.players.size >= level.maxclients )
        {
            wait 5;
        }
        
        function_451681e1065b7612( bot );
    }
    
    if ( isdefined( notifyflag ) )
    {
        level notify( notifyflag );
    }
}

// Namespace ftue_bots
// Params 1
// Checksum 0xe90b5168, Offset: 0x532
// Size: 0xb4
function function_451681e1065b7612( bot )
{
    bot.botentity = function_b39cb5d858a58b2e( bot );
    
    while ( !( isdefined( bot.botentity ) && isdefined( bot.botentity.sessionstate ) ) || bot.botentity.sessionstate == "spectator" || bot.botentity.sessionstate == "intermission" )
    {
        waitframe();
    }
    
    bot thread ftue_bots_placebotonspawnpoint();
    level.ftuedata.botsinfo.spawnedbots++;
    return bot;
}

// Namespace ftue_bots
// Params 1, eflags: 0x4
// Checksum 0x20b51033, Offset: 0x5ef
// Size: 0x168
function private function_b39cb5d858a58b2e( spawndata )
{
    assert( isdefined( spawndata.name ) );
    assert( isdefined( spawndata.team ) );
    assert( isdefined( spawndata.operatorref ) );
    assert( isdefined( spawndata.personality ) );
    bot = addbot( spawndata.name );
    connecting = spawnstruct();
    connecting.ready = 0;
    connecting.abort = 0;
    connecting.difficulty = spawndata.personality;
    
    if ( spawndata.team == "ally" )
    {
        spawndata.team = level.player.team;
    }
    
    bot bots_loadout::bot_set_loadout_class();
    bot bots::spawn_bot_latent( spawndata.team, undefined, connecting );
    waitframe();
    bot operator::createoperatorcustomization( spawndata.operatorref[ 0 ], spawndata.operatorref[ 1 ] );
    bot.sessionsquadid += level.ftuedata.botsinfo.spawnedbots + 1;
    return bot;
}

// Namespace ftue_bots
// Params 0, eflags: 0x4
// Checksum 0xae0a915e, Offset: 0x760
// Size: 0x194
function private ftue_bots_placebotonspawnpoint()
{
    while ( distance( self.botentity.origin, level.ftuedata.botsinfo.inactiveposition ) > 200 )
    {
        self.botentity setorigin( level.ftuedata.botsinfo.inactiveposition );
        waitframe();
    }
    
    self.botentity function_68fd705b84420ca5();
    
    while ( !self.botentity isonground() )
    {
        waitframe();
    }
    
    self.botentity ftue_player::function_41490cf7c642d2dd( self.spawnposition, self.spawnrotation );
    
    if ( !self.entranceonspawn )
    {
        self.botentity player_utility::function_dbe5a52a6654a982();
        self.botentity player_utility::function_9d378d725bb4831e( "ftue_bots::ftue_bots_placeBotOnSpawnPoint()" );
        self.botentity botsetflag( "disable_all_ai", 1 );
        self.botentity botsetflag( "god_mode", 1 );
    }
    
    self.botentity.armorhealth = 0;
    self.botentity takeallweapons();
    startingweapon = weapon::buildweapon( self.weapon, undefined, undefined, undefined, -1, undefined, undefined, undefined, 0 );
    self.botentity giveweapon( startingweapon );
    self.botentity switchtoweapon( startingweapon );
    self.botentity allowreload( 0 );
    self.botentity ftue_player::function_f89d8d905f739aa7();
}

// Namespace ftue_bots
// Params 0
// Checksum 0x931e299b, Offset: 0x8fc
// Size: 0x60
function function_68fd705b84420ca5()
{
    assert( isbot( self ) );
    self botsetflag( "disable_movement", 1 );
    self botsetflag( "disable_attack", 1 );
    self allowslide( 0 );
    self.repositionenabled = 0;
    self.var_5d46d2b471e1522a = 0;
    self.var_bdf1e5e6d9a325ee = 0;
    self.var_fa0b8a2a0cfa3673 = 0;
    mind::function_8a6d2c7bff38fe07( 0 );
}

// Namespace ftue_bots
// Params 2
// Checksum 0xeeb93ad2, Offset: 0x964
// Size: 0x352
function ftue_bots_botmakeentrance( botstruct, style )
{
    if ( !isbot( botstruct.botentity ) )
    {
        return;
    }
    
    botstruct.botentity botsetflag( "disable_all_ai", 0 );
    botstruct.botentity botsetflag( "god_mode", 0 );
    botstruct.botentity playershow();
    botstruct.botentity player_utility::function_4688d689820ff1ed( "ftue_bots::ftue_bots_botMakeEntrance()" );
    
    if ( getdvarint( @"ftue_bots_direct_spawn", 0 ) == 1 )
    {
        botstruct.botentity ftue_player::function_41490cf7c642d2dd( botstruct.destpositions[ "DEFAULT" ][ 0 ] );
        botstruct.botentity function_d4f87a47d7c484ed( botstruct.destpositions[ "DEFAULT" ][ 1 ] );
        botstruct function_ba44e945e60d2be6();
    }
    else if ( isdefined( style ) )
    {
        switch ( style )
        {
            case #"hash_20cd76d83c2f7487":
                if ( isdefined( botstruct.destpositions[ "DEFAULT" ] ) )
                {
                    botstruct function_8342ae7e10b8cd76( "DEFAULT", undefined, &function_ba44e945e60d2be6, botstruct );
                }
                
                break;
            case #"hash_718f4c8bdaf008f8":
                if ( isdefined( botstruct.destpositions[ "DEFAULT" ] ) )
                {
                    botstruct function_8342ae7e10b8cd76( "DEFAULT", undefined, &function_ba44e945e60d2be6, botstruct );
                    wait 0.5;
                    botstruct.botentity function_eb6fe1576dac4d2d( botstruct.shoottarget );
                }
                
                break;
            case #"hash_4580af3edd21d3af":
                if ( isdefined( botstruct.parachutespawnposition ) && isdefined( botstruct.destpositions[ "DEFAULT" ] ) )
                {
                    botstruct.botentity function_38b1e65d4ed5865b( botstruct.parachutespawnposition, botstruct.destpositions[ "DEFAULT" ][ 0 ], botstruct.destpositions[ "DEFAULT" ][ 1 ], &function_ba44e945e60d2be6, botstruct );
                }
                
                break;
            default:
                botstruct.botentity ftue_player::function_41490cf7c642d2dd( botstruct.destpositions[ "DEFAULT" ][ 0 ] );
                botstruct.botentity function_d4f87a47d7c484ed( botstruct.destpositions[ "DEFAULT" ][ 1 ] );
                botstruct function_ba44e945e60d2be6();
                break;
        }
    }
    else
    {
        botstruct.botentity ftue_player::function_41490cf7c642d2dd( botstruct.destpositions[ "DEFAULT" ][ 0 ] );
        botstruct.botentity function_d4f87a47d7c484ed( botstruct.destpositions[ "DEFAULT" ][ 1 ] );
        botstruct function_ba44e945e60d2be6();
    }
    
    if ( botstruct.disableoutline )
    {
        return;
    }
    
    if ( isdefined( level.ftuedata.botsinfo.outlinedelay ) )
    {
        wait level.ftuedata.botsinfo.outlinedelay;
    }
    
    botstruct.botentity outline::hudoutline_add_channel_internal( "ftue_enemies", 10, "outlinefill_nodepth_orange" );
    botstruct.botentity outline::hudoutline_enable_internal( level.player, "ftue_enemies" );
}

// Namespace ftue_bots
// Params 0, eflags: 0x4
// Checksum 0x7d96e2c2, Offset: 0xcbe
// Size: 0x53
function private function_ba44e945e60d2be6()
{
    self.botentity setcandamage( 1 );
    
    if ( self.shootenabled )
    {
        self.botentity function_eb6fe1576dac4d2d( self.shoottarget );
    }
    
    if ( self.repositionenabled )
    {
        self.botentity function_cd9ecf8448850ea6();
    }
}

// Namespace ftue_bots
// Params 5
// Checksum 0x3a48c940, Offset: 0xd19
// Size: 0x62
function ftue_bots_movetoposition( position, targetlookat, var_9b9af96080795781, callback, var_65df747f706dce60 )
{
    assert( isbot( self ) );
    
    if ( isdefined( self.repositionenabled ) )
    {
        self.repositionenabled = 0;
    }
    
    thread function_612808a62c22e42b( position, targetlookat, var_9b9af96080795781, callback, var_65df747f706dce60 );
}

// Namespace ftue_bots
// Params 5, eflags: 0x4
// Checksum 0x345b22b9, Offset: 0xd83
// Size: 0x107, Type: bool
function private function_612808a62c22e42b( position, targetlookat, var_9b9af96080795781, callback, var_65df747f706dce60 )
{
    self notify( #"hash_fb56620550c35705" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_fb56620550c35705" );
    targetposition = getclosestpointonnavmesh( position );
    function_a20327fe19f3d132( 0 );
    
    if ( isdefined( targetlookat ) )
    {
        function_d4f87a47d7c484ed( targetlookat );
    }
    else if ( !self.repositionenabled )
    {
        self.var_5d46d2b471e1522a = 0;
    }
    
    self botclearscriptgoal();
    self botsetpathingstyle( "scripted" );
    self botsetscriptgoal( targetposition, 20, "objective" );
    result = bots_util::bot_waittill_goal_or_fail();
    
    if ( result != "script_goal_changed" )
    {
        function_a20327fe19f3d132( 1 );
    }
    
    if ( isdefined( var_9b9af96080795781 ) )
    {
        function_d4f87a47d7c484ed( var_9b9af96080795781 );
    }
    
    if ( isdefined( callback ) )
    {
        if ( isdefined( var_65df747f706dce60 ) )
        {
            var_65df747f706dce60 thread [[ callback ]]();
        }
        else
        {
            self thread [[ callback ]]();
        }
    }
    
    return true;
}

// Namespace ftue_bots
// Params 5
// Checksum 0x46d89213, Offset: 0xe93
// Size: 0x62
function function_bd1861389f0e47bb( position, speed, var_9b9af96080795781, callback, var_65df747f706dce60 )
{
    assert( isbot( self ) );
    
    if ( isdefined( self.repositionenabled ) )
    {
        self.repositionenabled = 0;
    }
    
    thread function_3ed7bcba76130515( position, speed, var_9b9af96080795781, callback, var_65df747f706dce60 );
}

// Namespace ftue_bots
// Params 5, eflags: 0x4
// Checksum 0xd1b8501a, Offset: 0xefd
// Size: 0x130, Type: bool
function private function_3ed7bcba76130515( position, speed, var_9b9af96080795781, callback, var_65df747f706dce60 )
{
    self notify( #"hash_fb56620550c35705" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_fb56620550c35705" );
    targetposition = getclosestpointonnavmesh( position );
    function_a20327fe19f3d132( 0 );
    path = [];
    path = self findpath( self.origin, targetposition );
    self botclearscriptgoal();
    
    for ( i = 0; i < path.size ; i++ )
    {
        while ( distance2d( self.origin, path[ i ] ) > 20 )
        {
            direction = vectortoyaw( path[ i ] - self.origin );
            self botsetscriptmove( direction, 0.1, speed );
            wait 0.1;
        }
    }
    
    self botclearscriptgoal();
    function_a20327fe19f3d132( 1 );
    
    if ( isdefined( var_9b9af96080795781 ) )
    {
        function_d4f87a47d7c484ed( var_9b9af96080795781 );
    }
    
    if ( isdefined( callback ) )
    {
        if ( isdefined( var_65df747f706dce60 ) )
        {
            var_65df747f706dce60 thread [[ callback ]]();
        }
        else
        {
            self thread [[ callback ]]();
        }
    }
    
    return true;
}

// Namespace ftue_bots
// Params 4
// Checksum 0x4408296f, Offset: 0x1036
// Size: 0x50
function function_8342ae7e10b8cd76( destinationid, speed, callback, var_65df747f706dce60 )
{
    assert( isbot( self.botentity ) && isdefined( destinationid ) );
    thread function_6b812b0f71b6bf7a( destinationid, speed, callback, var_65df747f706dce60 );
}

// Namespace ftue_bots
// Params 4, eflags: 0x4
// Checksum 0x41d295f8, Offset: 0x108e
// Size: 0xe5
function private function_6b812b0f71b6bf7a( destinationid, speed, callback, var_65df747f706dce60 )
{
    movement = undefined;
    
    if ( isdefined( speed ) )
    {
        movement = self.botentity function_3ed7bcba76130515( self.destpositions[ destinationid ][ 0 ], speed, self.destpositions[ destinationid ][ 1 ] );
    }
    else
    {
        movement = self.botentity function_612808a62c22e42b( self.destpositions[ destinationid ][ 0 ], undefined, self.destpositions[ destinationid ][ 1 ] );
    }
    
    if ( !movement )
    {
        return;
    }
    
    self.botentity function_6619a5dbedc72f72( self.destpositions[ destinationid ][ 2 ] );
    
    if ( isdefined( callback ) )
    {
        if ( isdefined( var_65df747f706dce60 ) )
        {
            var_65df747f706dce60 thread [[ callback ]]();
            return;
        }
        
        self.botentity thread [[ callback ]]();
    }
}

// Namespace ftue_bots
// Params 5
// Checksum 0x8ea9021, Offset: 0x117b
// Size: 0x7f
function function_38b1e65d4ed5865b( var_b828e2205a101755, targetdestination, targetlookat, callback, var_65df747f706dce60 )
{
    assert( isbot( self ) || isdefined( var_b828e2205a101755 ) || isdefined( targetdestination ) || isdefined( targetlookat ) );
    self setorigin( var_b828e2205a101755 );
    function_a20327fe19f3d132( 0 );
    waitframe();
    
    while ( self isonground() == 0 )
    {
        waitframe();
    }
    
    wait 1;
    function_8342ae7e10b8cd76( 0, callback, var_65df747f706dce60 );
}

// Namespace ftue_bots
// Params 0
// Checksum 0x8fd884ae, Offset: 0x1202
// Size: 0x16
function function_cd9ecf8448850ea6()
{
    assert( isbot( self ) );
    thread function_56bf657e3352a9aa();
}

// Namespace ftue_bots
// Params 0, eflags: 0x4
// Checksum 0x80e94ec7, Offset: 0x1220
// Size: 0x9c
function private function_56bf657e3352a9aa()
{
    self notify( #"hash_fde577a9f47d7a4f" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_fde577a9f47d7a4f" );
    self.repositionenabled = 1;
    
    while ( self.repositionenabled )
    {
        wait 5 + randomfloat( 5 );
        middlepos = self.origin + ( level.player.origin - self.origin ) / 2;
        newpos = getrandomnavpoint( middlepos, 800 );
        function_612808a62c22e42b( newpos );
    }
}

// Namespace ftue_bots
// Params 1
// Checksum 0xede0361, Offset: 0x12c4
// Size: 0x1c
function function_6619a5dbedc72f72( stance )
{
    if ( isbot( self ) )
    {
        self botsetstance( stance );
    }
}

// Namespace ftue_bots
// Params 1
// Checksum 0x55bd338b, Offset: 0x12e8
// Size: 0x21
function function_a20327fe19f3d132( value )
{
    if ( isbot( self ) )
    {
        self botsetflag( "disable_movement", value );
    }
}

// Namespace ftue_bots
// Params 2
// Checksum 0x79f73870, Offset: 0x1311
// Size: 0x2c
function function_d4f87a47d7c484ed( target, time )
{
    assert( isbot( self ) );
    thread function_bafcaa2ec5c1644b( target, time );
}

// Namespace ftue_bots
// Params 2, eflags: 0x4
// Checksum 0x91118428, Offset: 0x1345
// Size: 0x1ac
function private function_bafcaa2ec5c1644b( target, time )
{
    self notify( #"new_look_at_target" );
    self endon( #"death_or_disconnect" );
    self endon( #"new_look_at_target" );
    
    if ( !isdefined( time ) )
    {
        time = 0.2;
    }
    
    self.var_5d46d2b471e1522a = 1;
    
    while ( self.var_5d46d2b471e1522a )
    {
        if ( !isdefined( target ) )
        {
            break;
        }
        
        if ( isstring( target ) )
        {
            switch ( target )
            {
                case #"hash_1119adae802dcc40":
                    if ( !isalive( level.player ) )
                    {
                        return;
                    }
                    
                    var_da54bd13bd398ae = level.player geteye() + ( randomfloat( 0 ), randomfloat( 0 ), randomfloat( 0 ) );
                    self botlookatpoint( var_da54bd13bd398ae, time, "script_forced" );
                    break;
                case #"hash_46f2e5a2ee89ad68":
                    if ( !isalive( level.ftuedata.allybots[ #"allybot_1" ].botentity ) )
                    {
                        return;
                    }
                    
                    var_da54bd13bd398ae = level.ftuedata.allybots[ #"allybot_1" ].botentity geteye() + ( randomfloat( 0 ), randomfloat( 0 ), randomfloat( 0 ) );
                    self botlookatpoint( var_da54bd13bd398ae, time, "script_forced" );
                    break;
            }
        }
        else if ( isvector( target ) )
        {
            self botlookatpoint( target, time, "script_forced" );
        }
        else if ( isent( target ) )
        {
            if ( !isalive( target ) )
            {
                return;
            }
            
            self botlookatpoint( target.origin, time, "script_forced" );
        }
        
        wait time;
    }
}

// Namespace ftue_bots
// Params 1
// Checksum 0xc5a30e29, Offset: 0x14f9
// Size: 0x22
function function_eb6fe1576dac4d2d( target )
{
    assert( isbot( self ) );
    thread function_9b03875151a2168b( target );
}

// Namespace ftue_bots
// Params 1, eflags: 0x4
// Checksum 0xc34122ea, Offset: 0x1523
// Size: 0x1b2
function private function_9b03875151a2168b( target )
{
    self notify( #"hash_3ee5d9821d90790a" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_3ee5d9821d90790a" );
    thread function_bafcaa2ec5c1644b( target );
    wait 1;
    self.var_bdf1e5e6d9a325ee = 1;
    
    while ( self.var_bdf1e5e6d9a325ee )
    {
        if ( isstring( target ) )
        {
            switch ( target )
            {
                case #"hash_1119adae802dcc40":
                    if ( !isalive( level.player ) )
                    {
                        function_d5f02df1ab458e1b( "attack" );
                        return 1;
                    }
                    
                    if ( level.player sightconetrace( self geteye(), self ) < 0 )
                    {
                        wait 1;
                        continue;
                    }
                    
                    break;
                case #"hash_46f2e5a2ee89ad68":
                    if ( !isalive( level.ftuedata.allybots[ #"allybot_1" ].botentity ) )
                    {
                        function_d5f02df1ab458e1b( "attack" );
                        return 1;
                    }
                    
                    if ( level.ftuedata.allybots[ #"allybot_1" ].botentity sightconetrace( self geteye(), self ) < 0 )
                    {
                        wait 1;
                        continue;
                    }
                    
                    break;
            }
        }
        else if ( isent( target ) )
        {
            if ( !isalive( target ) )
            {
                function_d5f02df1ab458e1b( "attack" );
                return 1;
            }
            
            if ( target sightconetrace( self geteye(), self ) < 0 )
            {
                wait 1;
                continue;
            }
        }
        else
        {
            return;
        }
        
        shoottime = 0.5 + randomfloat( 2 );
        thread function_c33b4bed76e2434d( "attack", shoottime );
        wait shoottime + 1 + randomfloat( 2 );
    }
}

// Namespace ftue_bots
// Params 1
// Checksum 0x5efa725, Offset: 0x16dd
// Size: 0x29
function function_c421bf5788432550( enemies )
{
    assert( isbot( self ) && isdefined( enemies ) );
    thread function_e1c7c781015ae258( enemies );
}

// Namespace ftue_bots
// Params 1, eflags: 0x4
// Checksum 0x7259140c, Offset: 0x170e
// Size: 0x11d
function private function_e1c7c781015ae258( enemies )
{
    self notify( #"hash_f197a4c869249ab9" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_f197a4c869249ab9" );
    self.var_fa0b8a2a0cfa3673 = 1;
    
    while ( self.var_fa0b8a2a0cfa3673 )
    {
        targetenemy = undefined;
        
        foreach ( enemy in enemies )
        {
            enemybot = level.ftuedata.enemybots[ getxhash( enemy ) ].botentity;
            
            if ( !isalive( enemybot ) )
            {
                continue;
            }
            
            targetenemy = enemybot;
        }
        
        if ( !isdefined( targetenemy ) )
        {
            return 1;
        }
        
        function_eb6fe1576dac4d2d( targetenemy );
        wait 3 + randomfloat( 3 );
    }
}

// Namespace ftue_bots
// Params 4
// Checksum 0x66dd017f, Offset: 0x1833
// Size: 0x49
function function_857b920d685fb871( targetoperator, approachspeed, executionid, callback )
{
    assert( isbot( self ) || !isdefined( targetoperator ) );
    thread function_40a127909069eb17( targetoperator, approachspeed, executionid, callback );
}

// Namespace ftue_bots
// Params 4, eflags: 0x4
// Checksum 0x39fdd22a, Offset: 0x1884
// Size: 0xf5
function private function_40a127909069eb17( targetoperator, approachspeed, executionid, callback )
{
    self endon( #"death_or_disconnect" );
    
    if ( isdefined( executionid ) )
    {
        execution::_giveexecution( executionid );
    }
    
    self.var_5d46d2b471e1522a = 0;
    var_7c3f0f5b6acfd32c = vectornormalize( anglestoforward( targetoperator getplayerangles() ) );
    var_9e6dbd60c58139ab = targetoperator.origin - var_7c3f0f5b6acfd32c * 30;
    
    if ( distance2d( self.origin, var_9e6dbd60c58139ab ) > 20 )
    {
        if ( !isdefined( approachspeed ) )
        {
            approachspeed = 1;
        }
        
        function_3ed7bcba76130515( var_9e6dbd60c58139ab, approachspeed );
    }
    
    self botlookatpoint( targetoperator geteye(), 1 );
    self enableexecutionattack();
    
    while ( !self isinexecutionattack() )
    {
        function_c33b4bed76e2434d( "melee", 3 );
        wait 3;
    }
    
    while ( self isinexecutionattack() )
    {
        waitframe();
    }
    
    if ( isdefined( callback ) )
    {
        self thread [[ callback ]]();
    }
}

// Namespace ftue_bots
// Params 3
// Checksum 0x5492fe11, Offset: 0x1981
// Size: 0x44
function function_cfa27b5899fe0eec( var_99811609371f0d7b, attackposition, callback )
{
    assert( isbot( self ) || !( isdefined( var_99811609371f0d7b ) && isdefined( attackposition ) ) );
    thread function_5adbc19afef6738c( var_99811609371f0d7b, attackposition, callback );
}

// Namespace ftue_bots
// Params 3, eflags: 0x4
// Checksum 0x81ce17f6, Offset: 0x19cd
// Size: 0x10b
function private function_5adbc19afef6738c( var_99811609371f0d7b, attackposition, callback )
{
    self endon( #"death_or_disconnect" );
    previousequipment = self getcurrentweapon();
    self takeallweapons();
    missilelauncher = weapon::buildweapon( "iw9_la_rpapa7", undefined, undefined, undefined, -1, undefined, undefined, undefined, 0 );
    self giveweapon( missilelauncher );
    self givemaxammo( missilelauncher );
    self switchtoweapon( missilelauncher );
    
    if ( distance2d( self.origin, attackposition ) > 20 )
    {
        function_612808a62c22e42b( attackposition );
    }
    
    function_d4f87a47d7c484ed( var_99811609371f0d7b, 4 );
    wait 0.5;
    function_c33b4bed76e2434d( "ads", 4 );
    wait 0.5;
    var_99811609371f0d7b ftue_vehicles::function_92f94cce3bbb7327( callback );
    function_c33b4bed76e2434d( "attack", 2 );
    wait 1.5;
    
    if ( isalive( var_99811609371f0d7b ) > 0 )
    {
        var_99811609371f0d7b ftue_vehicles::function_6b72156a7d62a1db( callback );
    }
    
    self takeallweapons();
    self giveweapon( previousequipment );
    self givemaxammo( previousequipment );
    self switchtoweapon( previousequipment );
}

// Namespace ftue_bots
// Params 2
// Checksum 0xed9c0d68, Offset: 0x1ae0
// Size: 0x2b
function function_c33b4bed76e2434d( var_3087ad3c13f4075e, time )
{
    assert( isbot( self ) );
    self botpressbutton( var_3087ad3c13f4075e, time );
}

// Namespace ftue_bots
// Params 1
// Checksum 0xed9c0d35, Offset: 0x1b13
// Size: 0x21
function function_d5f02df1ab458e1b( var_3087ad3c13f4075e )
{
    assert( isbot( self ) );
    self botclearbutton( var_3087ad3c13f4075e );
}

