// scripts\mp\calloutmarkerping.gsc  (hash_2042d7a32b3a452e.gscc) (size: 66986 Bytes / 0x105aa / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x34af7c79 (883915897)
// size ...... 66986 (0x105aa)
// includes .. 19  (offset: 0xf676)
// strings ... 229 (offset: 0xf70e)
// dev strs .. 33  (offset: 0x103b6)
// exports ... 136 (offset: 0xb5c6)
// cseg ...... 0x1c3b + 0x998b (0xb5c6)
// imports ... 316 (offset: 0xcb06)
// animtree1 . 0   (offset: 0x105aa)
// animtree2 . 0   (offset: 0x105aa)
#using scripts\common\callbacks;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_roads;
#using scripts\common\weapon;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\equipment;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_database;

#namespace calloutmarkerping;

// Namespace calloutmarkerping
// Params 0
// Checksum 0xa0a1f65d, Offset: 0x1c59
// Size: 0x77
function initcommon()
{
    cachescriptbundlesettings();
    
    if ( level.calloutmarkerping.var_3b6cf60231451814 )
    {
        level callback::add( #"player_connect", &ping_duration_option_init );
    }
    
    if ( getdvarint( @"hash_d3174ac55ae9bad2" ) )
    {
        level thread refreshpaths();
    }
    
    level thread function_15b4a8021dd45caf();
    
    if ( level.gamemodebundle.var_997e23cc9233062d )
    {
        scriptable::scriptable_addusedcallback( &function_2f14ede369dce7cd );
    }
}

// Namespace calloutmarkerping
// Params 6, eflags: 0x4
// Checksum 0x9c523260, Offset: 0x1cd8
// Size: 0x85
function private function_2f14ede369dce7cd( instance, part, state, player, bautouse, usestring )
{
    instance function_608710c894185549( player, 1 );
    
    if ( isent( instance.entity ) && instance.entity vehicle::is_vehicle() )
    {
        player notify( "forced_kill_callout_" + instance.entity getentitynumber() );
    }
}

// Namespace calloutmarkerping
// Params 0
// Checksum 0x516f4bc, Offset: 0x1d65
// Size: 0xa0
function function_685616faafc106cd()
{
    var_776f96068ea148ad = level.gametypebundle.calloutmarkerpingsettings ?? undefined;
    
    if ( !isdefined( var_776f96068ea148ad ) )
    {
        gamemodebundle = level.gamemodebundle ?? getgamemodescriptbundle();
        var_776f96068ea148ad = gamemodebundle.calloutmarkerpingsettings ?? undefined;
        
        if ( !isdefined( var_776f96068ea148ad ) )
        {
            projectscriptbundle = level.projectbundle ?? getprojectscriptbundle();
            var_776f96068ea148ad = projectscriptbundle.calloutmarkerpingsettings ?? undefined;
        }
        
        return getscriptbundle( "calloutmarkerpingsettings:" + var_776f96068ea148ad );
    }
    
    return getscriptbundle( var_776f96068ea148ad );
}

// Namespace calloutmarkerping
// Params 0
// Checksum 0xc7330fca, Offset: 0x1e0d
// Size: 0x2c7
function cachescriptbundlesettings()
{
    var_8debd17a9da7ae1 = function_685616faafc106cd();
    
    if ( !isdefined( var_8debd17a9da7ae1 ) )
    {
        return;
    }
    
    assert( !isdefined( level.calloutmarkerping ) );
    level.calloutmarkerping = spawnstruct();
    level.calloutmarkerping.lootidpings = var_8debd17a9da7ae1.lootidpings;
    level.calloutmarkerping.var_d25db4d8e1c32bad = var_8debd17a9da7ae1.var_d25db4d8e1c32bad;
    level.calloutmarkerping.var_3b6cf60231451814 = var_8debd17a9da7ae1.var_3b6cf60231451814;
    level.calloutmarkerping.var_b41266c97bfb092c = var_8debd17a9da7ae1.var_b41266c97bfb092c;
    level.calloutmarkerping.var_8014802dd81e900c = var_8debd17a9da7ae1.var_8014802dd81e900c;
    level.calloutmarkerping.var_a322e0a48564c075 = var_8debd17a9da7ae1.var_a322e0a48564c075;
    level.calloutmarkerping.var_8a44dad9113d5972 = var_8debd17a9da7ae1.var_8a44dad9113d5972;
    level.calloutmarkerping.var_67d542069cffe312 = var_8debd17a9da7ae1.var_67d542069cffe312;
    level.calloutmarkerping.var_7dad33dc75610e40 = var_8debd17a9da7ae1.var_7dad33dc75610e40;
    level.calloutmarkerping.var_1a5688f73c38cd17 = var_8debd17a9da7ae1.var_1a5688f73c38cd17;
    level.calloutmarkerping.var_43cb811f8da2ebf = var_8debd17a9da7ae1.var_43cb811f8da2ebf;
    level.calloutmarkerping.var_6813a49858513c99 = var_8debd17a9da7ae1.var_6813a49858513c99;
    level.calloutmarkerping.var_46e3e5c01e080e76 = var_8debd17a9da7ae1.var_46e3e5c01e080e76;
    level.calloutmarkerping.var_1b35316c6e7faf23 = var_8debd17a9da7ae1.var_1b35316c6e7faf23;
    level.calloutmarkerping.var_a6b600bf191f7c69 = var_8debd17a9da7ae1.var_a6b600bf191f7c69;
    level.calloutmarkerping.var_99f5e69420e0dc29 = var_8debd17a9da7ae1.var_99f5e69420e0dc29;
    level.calloutmarkerping.var_f62f563b629e03d5 = var_8debd17a9da7ae1.var_f62f563b629e03d5;
    level.calloutmarkerping.var_1ff8f50c47a4263e = var_8debd17a9da7ae1.var_1ff8f50c47a4263e;
    level.calloutmarkerping.var_5ab46aa76d3b8fae = var_8debd17a9da7ae1.var_5ab46aa76d3b8fae;
    level.calloutmarkerping.var_2b6fe1fe666bb60d = var_8debd17a9da7ae1.var_2b6fe1fe666bb60d;
    level.calloutmarkerping.var_a13bd047242d1632 = var_8debd17a9da7ae1.var_a13bd047242d1632;
}

// Namespace calloutmarkerping
// Params 4, eflags: 0x4
// Checksum 0x888eab6b, Offset: 0x20dc
// Size: 0x15b
function private function_40df08cd2d68aaf2( pingindex, targetingenemy, playvo, nozoffset )
{
    player = self;
    player function_7c0ee9d4b604e6d6( pingindex );
    
    if ( !isdefined( targetingenemy.origin ) )
    {
        return;
    }
    
    if ( nozoffset )
    {
        dangerpos = targetingenemy.origin;
    }
    else
    {
        dangerzoffset = level.calloutmarkerping.var_b41266c97bfb092c;
        dangerpos = targetingenemy.origin + ( 0, 0, dangerzoffset );
    }
    
    var_2d515e25c568f2b3 = function_1bf3a084cfe14025( 4 );
    newpingindex = player function_a3f0d6526c09f579( var_2d515e25c568f2b3, dangerpos );
    
    if ( isdefined( newpingindex ) )
    {
        if ( playvo )
        {
            if ( isenemy( targetingenemy, self ) && ( isplayer( targetingenemy ) || isbot( targetingenemy ) ) )
            {
                if ( !player::isreallyalive( targetingenemy ) )
                {
                    if ( utility::issharedfuncdefined( #"sound", #"trysaylocalsound" ) )
                    {
                        level thread [[ utility::getsharedfunc( #"sound", #"trysaylocalsound" ) ]]( player, #"ping_enemy_killed" );
                    }
                }
            }
        }
        
        player thread predicted_timeout( newpingindex );
        predicted_log( "Decay to Danger | oldPingIndex: " + pingindex + " | newPingIndex: " + newpingindex );
    }
}

// Namespace calloutmarkerping
// Params 1, eflags: 0x4
// Checksum 0xec55694c, Offset: 0x223f
// Size: 0x38
function private predicted_log( message )
{
    /#
        if ( getdvarint( @"hash_8e929bf8a335ac41", 0 ) )
        {
            logstring( "<dev string:x24>" + message + "<dev string:x40>" + gettime() );
        }
    #/
}

// Namespace calloutmarkerping
// Params 1
// Checksum 0xafc2e5b5, Offset: 0x227f
// Size: 0x15, Type: bool
function function_b658b8c35408496a( var_6675b0888e2dbc2 )
{
    return var_6675b0888e2dbc2 == function_1bf3a084cfe14025( 5 );
}

// Namespace calloutmarkerping
// Params 1, eflags: 0x4
// Checksum 0xc7de5394, Offset: 0x229d
// Size: 0x22, Type: bool
function private function_e017734603d9cc3a( var_6675b0888e2dbc2 )
{
    return var_6675b0888e2dbc2 == function_1bf3a084cfe14025( 17 ) || var_6675b0888e2dbc2 == function_1bf3a084cfe14025( 18 );
}

// Namespace calloutmarkerping
// Params 1, eflags: 0x4
// Checksum 0x97c557a4, Offset: 0x22c8
// Size: 0x15, Type: bool
function private function_2c54e299556d3115( var_6675b0888e2dbc2 )
{
    return var_6675b0888e2dbc2 == function_1bf3a084cfe14025( 19 );
}

// Namespace calloutmarkerping
// Params 1, eflags: 0x4
// Checksum 0xf9c14fc5, Offset: 0x22e6
// Size: 0x15, Type: bool
function private function_6fb215412d4f2585( var_6675b0888e2dbc2 )
{
    return var_6675b0888e2dbc2 == function_1bf3a084cfe14025( 4 );
}

// Namespace calloutmarkerping
// Params 3, eflags: 0x4
// Checksum 0xff3fdede, Offset: 0x2304
// Size: 0x70, Type: bool
function private function_b3c77a671d251a32( player, var_6675b0888e2dbc2, calloutentity )
{
    if ( isdefined( calloutentity ) && calloutentity vehicle::is_vehicle() )
    {
        if ( isvehicleoccupiedbyenemy( calloutentity, player.team ) )
        {
            return false;
        }
    }
    
    if ( function_b658b8c35408496a( var_6675b0888e2dbc2 ) || function_6fb215412d4f2585( var_6675b0888e2dbc2 ) )
    {
        return false;
    }
    
    if ( function_5914ffcc17ccd58( var_6675b0888e2dbc2 ) == 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace calloutmarkerping
// Params 2, eflags: 0x4
// Checksum 0x3dfcd0e4, Offset: 0x237d
// Size: 0x220
function private function_d58ed16421335680( pingindex, calloutentity )
{
    player = self;
    var_6675b0888e2dbc2 = player function_689a4266a29aac13( pingindex );
    assert( function_4838d0aa6e70099f( var_6675b0888e2dbc2 ) );
    waittime = function_5914ffcc17ccd58( var_6675b0888e2dbc2 );
    
    if ( isbrgamemode() && level.calloutmarkerping.var_3b6cf60231451814 && waittime != 0 )
    {
        if ( function_b3c77a671d251a32( player, var_6675b0888e2dbc2, calloutentity ) && player.var_1f7dfa10230afa88 )
        {
            squad = teams::getsquadmates( player.team, player.sessionsquadid );
            
            foreach ( squadmate in squad )
            {
                if ( squadmate.customPingDurationEnabled == 2 )
                {
                    waittime = 0;
                    break;
                }
                
                if ( squadmate.customPingDurationEnabled && squadmate.var_6793010c02e4ac69 > waittime )
                {
                    waittime = squadmate.var_6793010c02e4ac69;
                }
            }
        }
    }
    
    if ( function_4095a4f8e53eb368( var_6675b0888e2dbc2 ) )
    {
        if ( isdefined( calloutentity ) && isenemy( calloutentity, player ) && level.calloutmarkerping.var_a322e0a48564c075 )
        {
            if ( isagent( calloutentity ) )
            {
                waittime = level.calloutmarkerping.var_1a5688f73c38cd17;
            }
            else if ( game_utility::function_d3f8957534dc62af() )
            {
                waittime = level.calloutmarkerping.var_6813a49858513c99;
            }
            else if ( isdefined( level.lootleaders ) && game_utility::getgametype() == "kingslayer" && arraycontains( level.lootleaders, calloutentity ) )
            {
                waittime = level.calloutmarkerping.var_43cb811f8da2ebf;
            }
        }
    }
    
    return waittime;
}

// Namespace calloutmarkerping
// Params 1, eflags: 0x4
// Checksum 0xf614675f, Offset: 0x25a6
// Size: 0xb0
function private ping_duration_option_init( params )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( isbrgamemode() && isdefined( self ) )
    {
        utility::function_e16c621f95fe3acf( &function_e4ea1bcca7f7128b, [ "customPingDurationEnabled", "pingDurationOption" ] );
        self.customPingDurationEnabled = self.pers[ "sharedGamerProfiles" ][ "customPingDurationEnabled" ];
        
        if ( self.customPingDurationEnabled == 2 )
        {
            self.var_6793010c02e4ac69 = 0;
        }
        else
        {
            self.var_6793010c02e4ac69 = self.pers[ "sharedGamerProfiles" ][ "pingDurationOption" ];
        }
    }
    
    function_b24e57ff9f4f52ad( self );
}

// Namespace calloutmarkerping
// Params 1, eflags: 0x4
// Checksum 0xd331b187, Offset: 0x265e
// Size: 0x128
function private function_b24e57ff9f4f52ad( player )
{
    squad = teams::getsquadmates( player.team, player.sessionsquadid );
    var_7fc08c66a25906d9 = 0;
    
    foreach ( teammate in squad )
    {
        if ( teammate.customPingDurationEnabled )
        {
            var_7fc08c66a25906d9 = 1;
            break;
        }
    }
    
    foreach ( teammate in squad )
    {
        teammate.var_1f7dfa10230afa88 = var_7fc08c66a25906d9;
    }
}

// Namespace calloutmarkerping
// Params 1, eflags: 0x4
// Checksum 0x75673368, Offset: 0x278e
// Size: 0x84
function private function_e4ea1bcca7f7128b( unused )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self.customPingDurationEnabled = self.pers[ "sharedGamerProfiles" ][ "customPingDurationEnabled" ];
    
    if ( self.customPingDurationEnabled == 2 )
    {
        self.var_6793010c02e4ac69 = 0;
    }
    else
    {
        self.var_6793010c02e4ac69 = self.pers[ "sharedGamerProfiles" ][ "pingDurationOption" ];
    }
    
    function_b24e57ff9f4f52ad( self );
}

// Namespace calloutmarkerping
// Params 1, eflags: 0x4
// Checksum 0x78cc1dd, Offset: 0x281a
// Size: 0x61
function private function_f883cb443d88eff5( pingcategory )
{
    player = self;
    
    if ( isdefined( player ) )
    {
        for ( pingindex = 0; pingindex < 10 ; pingindex++ )
        {
            isowner = player isowner( pingindex );
            
            if ( isowner && pingcategory == player function_402743018eee4a97( pingindex ) )
            {
                return pingindex;
            }
        }
    }
}

// Namespace calloutmarkerping
// Params 0
// Checksum 0x9bf8e626, Offset: 0x2883
// Size: 0x4d
function function_880706287a0f41fe()
{
    player = self;
    pingindex = undefined;
    
    if ( player function_1743167cf709c188( 4 ) )
    {
        pingindex = player function_f883cb443d88eff5( 4 );
    }
    else if ( player function_1743167cf709c188( 5 ) )
    {
        pingindex = player function_f883cb443d88eff5( 5 );
    }
    
    return pingindex;
}

// Namespace calloutmarkerping
// Params 1
// Checksum 0xc16a3013, Offset: 0x28d9
// Size: 0x44f
function predicted_timeout( pingindex )
{
    if ( !isdefined( pingindex ) )
    {
        return;
    }
    
    player = self;
    assert( player isowner( pingindex ) );
    player notify( "predictiveCalloutResetTimeout_" + pingindex );
    var_6675b0888e2dbc2 = player function_689a4266a29aac13( pingindex );
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    player endon( "predictiveCalloutResetTimeout_" + pingindex );
    player endon( "predictiveCalloutClear_" + pingindex );
    targetingenemy = undefined;
    var_ad1de3c0aad4c4ef = 0;
    calloutentity = player calloutmarkerping_getent( pingindex );
    
    if ( function_4095a4f8e53eb368( var_6675b0888e2dbc2 ) )
    {
        if ( isdefined( calloutentity ) )
        {
            var_ad1de3c0aad4c4ef = level.calloutmarkerping.var_a322e0a48564c075;
            
            if ( var_ad1de3c0aad4c4ef && isenemy( calloutentity, player ) )
            {
                targetingenemy = calloutentity;
            }
            
            if ( calloutentity vehicle::is_vehicle() )
            {
                player thread function_7ed535eadcb02974( pingindex, calloutentity );
            }
            else if ( function_b658b8c35408496a( var_6675b0888e2dbc2 ) && level.calloutmarkerping.var_8a44dad9113d5972 )
            {
                player thread function_f6f35d6a067ae17d( pingindex, calloutentity );
            }
            else if ( isplunderextract( calloutentity ) )
            {
                player thread function_56ba20e4a3880f55( pingindex, calloutentity );
            }
            
            player thread function_cf0846e552a84a6d( pingindex, calloutentity );
        }
    }
    else if ( function_4c1b7cae739d9840( var_6675b0888e2dbc2 ) )
    {
        player thread function_29ccf2e3d1394014( pingindex, calloutentity );
        
        if ( function_503aec6cae121b5e( var_6675b0888e2dbc2 ) )
        {
            buystationorigin = utility::function_e153375527829ec3( calloutentity.origin, "undefined", "CalloutMarkerPing: " + ": calloutEntity is undefined" );
            var_dd297b7c25f0210e = "buystation_kill_callout_" + buystationorigin;
            player thread function_3c501da3379eca0a( player, pingindex, undefined, [ var_dd297b7c25f0210e ], undefined );
            
            if ( !player isspectatingplayer() )
            {
                player thread function_5eb1d042d1816e5( pingindex );
            }
        }
        
        if ( level.gamemodebundle.var_fb64d8e570987612 && calloutentity.var_42ad2e0f6b95770c.size )
        {
            player thread function_9fd0d821f6f15ec5( calloutentity, pingindex );
        }
    }
    else if ( function_be8ce2357ee35e38( var_6675b0888e2dbc2 ) )
    {
        objectivekey = player function_18dfd51995213633( pingindex );
        
        if ( function_1e0f93cb4c76c4e5( objectivekey ) )
        {
            player thread function_29ccf2e3d1394014( pingindex, calloutentity );
        }
        
        player thread function_cc9f870e186699b2( pingindex, objectivekey );
    }
    else if ( var_6675b0888e2dbc2 == function_1bf3a084cfe14025( 6 ) )
    {
        gscobjectiveid = self calloutmarkerping_getgscobjectiveindex( pingindex );
        assert( isint( gscobjectiveid ) );
        
        if ( gscobjectiveid == -1 )
        {
            assertmsg( "<dev string:x4a>" + "<dev string:x5e>" );
            function_7c0ee9d4b604e6d6( pingindex );
        }
        else
        {
            player thread function_8a4d6dcfa97e09b9( pingindex, gscobjectiveid );
            player thread function_cc9f870e186699b2( pingindex, gscobjectiveid );
        }
    }
    else if ( function_9bd60fbf1b0a82e7( var_6675b0888e2dbc2 ) )
    {
        player thread function_29ccf2e3d1394014( pingindex, calloutentity );
        player thread function_22590e3bb8fc520f( pingindex );
    }
    else if ( function_d929a855518b925a( var_6675b0888e2dbc2 ) )
    {
        if ( level.calloutmarkerping.var_1ff8f50c47a4263e )
        {
            player thread navigationcancelproximity( pingindex );
        }
    }
    
    waittime = player function_d58ed16421335680( pingindex, calloutentity );
    
    if ( isbrgamemode() && level.calloutmarkerping.var_3b6cf60231451814 && !level.brgametype.issolos && player.var_1f7dfa10230afa88 )
    {
        thread function_e71b2929741ec776( pingindex, waittime, player, calloutentity );
    }
    
    if ( level.gamemodebundle.var_11f97ce1a2b39433 )
    {
        player thread function_5caad5f73686f102( pingindex );
    }
    
    predicted_log( "Setup Timeout | wait: " + waittime + " | pingIndex: " + pingindex + " | assetNCSIndex: " + var_6675b0888e2dbc2 );
    
    if ( !isdefined( waittime ) || waittime == 0 || isdefined( calloutentity ) && calloutentity.var_e4e66074b6c12aa5 )
    {
        return;
    }
    
    player thread watchplayerdeathordisconnect( pingindex );
    wait waittime;
    
    if ( isdefined( player ) && isalive( targetingenemy ) && function_b658b8c35408496a( var_6675b0888e2dbc2 ) && var_ad1de3c0aad4c4ef )
    {
        player thread function_40df08cd2d68aaf2( pingindex, targetingenemy );
        return;
    }
    
    predicted_log( "Ping Timeout | pingIndex: " + pingindex + " | assetNCSIndex: " + var_6675b0888e2dbc2 );
    
    if ( isdefined( calloutentity ) && isdefined( calloutentity.var_488526e1eed488ac[ player getentitynumber() ] ) )
    {
        calloutentity.var_488526e1eed488ac[ player getentitynumber() ] = undefined;
    }
    
    player function_7c0ee9d4b604e6d6( pingindex );
}

// Namespace calloutmarkerping
// Params 0, eflags: 0x4
// Checksum 0xd70531c7, Offset: 0x2d30
// Size: 0x4f, Type: bool
function private function_1db6157b09195dcd()
{
    player = self;
    
    for ( pingindex = 0; pingindex < 10 ; pingindex++ )
    {
        isowner = player isowner( pingindex );
        
        if ( isowner && player calloutmarkerping_getactive( pingindex ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace calloutmarkerping
// Params 0, eflags: 0x4
// Checksum 0x54ed3e1, Offset: 0x2d88
// Size: 0x79
function private function_46034140259fdc19()
{
    pingowner = self;
    level endon( #"game_ended" );
    pingowner endon( #"disconnect" );
    
    while ( true )
    {
        pingowner waittill( #"luinotifyserver", notification, var_8ac4d9c5c89dd24e, arg1 );
        
        if ( !( isdefined( notification ) && isdefined( var_8ac4d9c5c89dd24e ) ) )
        {
            continue;
        }
        
        pingowner function_f1e90ace095a0aa( notification, var_8ac4d9c5c89dd24e, arg1 );
    }
}

// Namespace calloutmarkerping/event_876defc840161939
// Params 3, eflags: 0x20
// Checksum 0x8f529b9d, Offset: 0x2e09
// Size: 0x29d
function event_handler[event_876defc840161939] function_f1e90ace095a0aa( notification, var_8ac4d9c5c89dd24e, arg1 )
{
    assert( isdefined( notification ) );
    pingowner = self;
    
    switch ( notification )
    {
        case #"hash_bf30d88fa3f51a24":
            pingowner function_d0c9cf62476247c8( var_8ac4d9c5c89dd24e );
            break;
        case #"hash_8848543b86c481ce":
            pingowner function_476f9fd6a624bef2( var_8ac4d9c5c89dd24e, arg1, 0 );
            break;
        case #"hash_48958d4f7bdc5cca":
            pingowner function_476f9fd6a624bef2( var_8ac4d9c5c89dd24e, arg1, 1 );
            break;
        case #"hash_58db4293949d3d7e":
            var_7b4457d1f275202d = getentbynum( arg1 );
            assert( isplayer( var_7b4457d1f275202d ) );
            pingowner function_a26ec6bad4d47bc2( var_8ac4d9c5c89dd24e, var_7b4457d1f275202d );
            break;
        case #"hash_40d28501f6704035":
            var_7b4457d1f275202d = getentbynum( arg1 );
            assert( isplayer( var_7b4457d1f275202d ) );
            pingowner function_d02507dfb75e6e90( var_8ac4d9c5c89dd24e, var_7b4457d1f275202d );
            break;
        case #"hash_11ea00e1a93830a7":
            pingowner function_d45334eb63d913e( var_8ac4d9c5c89dd24e );
            break;
        case #"hash_5c8ca9abdd242c53":
            pingowner function_177516fd2f972d05();
            break;
        case #"hash_3bb96ecec88eb830":
            pingowner function_177516fd2f972d05();
            pingowner function_effed1f0a3864f36();
            break;
        case #"hash_f17ec76eaa0b19da":
            pingowner function_6502d098804c6a1a( var_8ac4d9c5c89dd24e );
            break;
        case #"hash_7235872539b9e722":
            function_8bab7aa83d4f2b9d( pingowner, var_8ac4d9c5c89dd24e );
            break;
        case #"hash_5086fa44856f3427":
            pingowner [[ utility::getsharedfunc( #"hash_fb082228bd250cbc", #"hash_904145ff10aa8bea" ) ]]();
            break;
        case #"hash_3fe3f4975cc1fe19":
            if ( [[ utility::getsharedfunc( #"teamassim", #"iswaitingforassimresponse" ) ]]( pingowner ) )
            {
                [[ utility::getsharedfunc( #"teamassim", #"resolveassimrequest" ) ]]( pingowner, var_8ac4d9c5c89dd24e );
            }
            
            break;
        case #"hash_fa91676024244175":
            pingowner.var_e41f884506713f4c = var_8ac4d9c5c89dd24e;
            break;
        default:
            return;
    }
    
    logmessage = "Notification ( " + notification + " )" + ( isdefined( var_8ac4d9c5c89dd24e ) ? " | arg0: " + var_8ac4d9c5c89dd24e : "" ) + ( isdefined( arg1 ) ? " | arg1: " + arg1 : "" );
    predicted_log( logmessage );
    pingowner utility::callsharedfunc( #"hash_bd51c0eb64757b15", #"hash_8e3aa0d7f8e95e22", notification, var_8ac4d9c5c89dd24e, arg1 );
    pingowner notify( #"hash_4c899cfd503a471b", notification, var_8ac4d9c5c89dd24e, arg1 );
}

// Namespace calloutmarkerping
// Params 0
// Checksum 0x3e5d7327, Offset: 0x30ae
// Size: 0x4e
function initplayer()
{
    player = self;
    
    if ( !isdefined( player.calloutmarkerpingvohandlerpool ) )
    {
        player.calloutmarkerpingvohandlerpool = [];
    }
    
    if ( !isdefined( player.calloutmarkerpingids ) )
    {
        player.calloutmarkerpingids = [];
    }
    
    player thread function_46034140259fdc19();
}

// Namespace calloutmarkerping
// Params 1
// Checksum 0xfce06595, Offset: 0x3104
// Size: 0x5b, Type: bool
function isboss( ent )
{
    if ( isdefined( ent.bossinstance ) )
    {
        ent = ent.bossinstance;
    }
    
    if ( !isdefined( ent ) )
    {
        return false;
    }
    
    if ( !isdefined( ent.bossname ) )
    {
        return false;
    }
    
    if ( ent.bossname == "" )
    {
        return false;
    }
    
    return true;
}

// Namespace calloutmarkerping
// Params 2, eflags: 0x4
// Checksum 0xcabb4943, Offset: 0x3168
// Size: 0x8c, Type: bool
function private isenemy( ent, player )
{
    if ( !isent( ent ) )
    {
        return false;
    }
    
    if ( !isplayer( ent ) && !isagent( ent ) )
    {
        return false;
    }
    
    if ( !isdefined( ent.team ) )
    {
        return false;
    }
    
    if ( ent.team == "neutral" || ent.team == "civilian" )
    {
        return false;
    }
    
    return ent.team != player.team;
}

// Namespace calloutmarkerping
// Params 2, eflags: 0x4
// Checksum 0x4c92754, Offset: 0x31fd
// Size: 0x71
function private function_7103870fdc5cd43b( ent, player )
{
    if ( !( isdefined( ent ) && isdefined( player ) ) )
    {
        return;
    }
    
    if ( !isdefined( player.var_c45b5553c36a0755 ) )
    {
        player.var_c45b5553c36a0755 = [];
    }
    
    player.var_c45b5553c36a0755[ ent getentitynumber() ] = gettime();
    ent.var_72e7e9c4c9473c04[ player.team ] = gettime();
}

// Namespace calloutmarkerping
// Params 1, eflags: 0x4
// Checksum 0xd526577c, Offset: 0x3276
// Size: 0x6c
function private isplunderextract( ent )
{
    if ( !isdefined( ent ) )
    {
        return 0;
    }
    
    if ( !isdefined( ent.model ) )
    {
        return 0;
    }
    
    if ( !isent( ent ) )
    {
        return issubstr( ent.type, "brloot_plunder_extraction" );
    }
    
    return ent.model == "military_skyhook_far_plunder" || ent.model == "military_skyhook_far";
}

// Namespace calloutmarkerping
// Params 1, eflags: 0x4
// Checksum 0x2a29ae05, Offset: 0x32eb
// Size: 0xbe, Type: bool
function private isdropcrate( ent )
{
    if ( !isdefined( ent ) )
    {
        return false;
    }
    
    if ( !isent( ent ) )
    {
        return false;
    }
    
    if ( !isdefined( ent.cratetype ) )
    {
        return false;
    }
    
    if ( ent.isdropcrate )
    {
        return true;
    }
    
    return ent.cratetype == "battle_royale_chopper_loot" || ent.cratetype == "battle_royale_c130_loot" || ent.cratetype == "killstreak" || ent.cratetype == "battle_royale_juggernaut" || ent.cratetype == "juggernaut" || ent.cratetype == "manual_turret";
}

// Namespace calloutmarkerping
// Params 1, eflags: 0x4
// Checksum 0xb8ab5e72, Offset: 0x33b2
// Size: 0x1d, Type: bool
function private issoundveil( ent )
{
    return ent.equipmentref == "sound_veil_mp";
}

// Namespace calloutmarkerping
// Params 1, eflags: 0x4
// Checksum 0xcec34747, Offset: 0x33d8
// Size: 0x1d, Type: bool
function private issonarpulse( ent )
{
    return ent.equipmentref == "sonar_pulse_mp";
}

// Namespace calloutmarkerping
// Params 1, eflags: 0x4
// Checksum 0x7a3faa30, Offset: 0x33fe
// Size: 0x1d, Type: bool
function private isredeploydronebeacon( ent )
{
    return ent.equipmentref == "equip_redeploy_drone_beacon";
}

// Namespace calloutmarkerping
// Params 1, eflags: 0x4
// Checksum 0xe2ab8ccd, Offset: 0x3424
// Size: 0x1d, Type: bool
function private isdeconstation( ent )
{
    return ent.equipmentref == "equip_decon_station";
}

// Namespace calloutmarkerping
// Params 1, eflags: 0x4
// Checksum 0x7dbb0a59, Offset: 0x344a
// Size: 0x22, Type: bool
function private isairdrop( ent )
{
    return isdefined( ent.streakinfo.airdroptype );
}

// Namespace calloutmarkerping
// Params 1, eflags: 0x4
// Checksum 0xc65eab1, Offset: 0x3475
// Size: 0x30, Type: bool
function private isweaponent( ent )
{
    return isdefined( ent.classname ) && isstartstr( ent.classname, "weapon" );
}

// Namespace calloutmarkerping
// Params 1, eflags: 0x4
// Checksum 0xdf3c8676, Offset: 0x34ae
// Size: 0x39, Type: bool
function private iskiosk( ent )
{
    if ( !isdefined( ent ) )
    {
        return false;
    }
    
    if ( !ent getscriptableisloot() )
    {
        return false;
    }
    
    if ( ent.type != "br_plunder_box" )
    {
        return false;
    }
    
    return true;
}

// Namespace calloutmarkerping
// Params 1, eflags: 0x4
// Checksum 0xbe63c320, Offset: 0x34f0
// Size: 0x88, Type: bool
function private isequipment( ent )
{
    if ( isagent( ent ) )
    {
        return false;
    }
    
    if ( !isdefined( ent ) )
    {
        return false;
    }
    
    if ( !isent( ent ) )
    {
        return false;
    }
    
    return issubstr( ent.classname, "grenade" ) || issubstr( ent.classname, "c4_" ) || issubstr( ent.classname, "proximity_explosive_" ) || issubstr( ent.classname, "claymore_" );
}

// Namespace calloutmarkerping
// Params 2, eflags: 0x4
// Checksum 0x7eba133f, Offset: 0x3581
// Size: 0x5d, Type: bool
function private function_f49f4b43ae52ee8d( player, tacmaptrace )
{
    if ( player iscodcaster() || player isspectatingplayer() )
    {
        return false;
    }
    
    if ( !isalive( player ) )
    {
        return false;
    }
    
    if ( player.mapmarkermodeenabled && !isdefined( tacmaptrace ) )
    {
        return false;
    }
    
    if ( player utility::isusingremote() )
    {
        return false;
    }
    
    return true;
}

// Namespace calloutmarkerping
// Params 1
// Checksum 0xaec18cb8, Offset: 0x35e7
// Size: 0x92
function function_b50aafc2ba9127f4( lootid )
{
    if ( isdefined( level.var_2400b422ed778f5 ) )
    {
        return [[ level.var_2400b422ed778f5 ]]( lootid );
    }
    
    lootinfo = getlootiteminfofromid( lootid );
    itemsb = "calloutmarkerpingitem:" + lootinfo.itemref;
    calloutmarkerpingitem = getscriptbundle( itemsb );
    
    if ( isdefined( calloutmarkerpingitem.var_5eda534db5470a3a ) )
    {
        return calloutmarkerpingitem.var_5eda534db5470a3a;
    }
    
    logprint( "CalloutMarkerPing: " + "Could not get request VO for loot ID " + lootid );
}

// Namespace calloutmarkerping
// Params 1, eflags: 0x4
// Checksum 0x402acf3a, Offset: 0x3682
// Size: 0x1a0
function private function_36506c9de0ac7a6d( lootid )
{
    lootidtype = loot::function_52cf8374c44a4ff5( lootid );
    
    if ( lootidtype == "calloutmarkerpingitem" )
    {
        return function_b50aafc2ba9127f4( lootid );
    }
    
    if ( level.var_bfa750d9db209a4b )
    {
        var_a8ab57ac69f09ee5 = level.br_pickups.pingalias[ lootid ];
        
        if ( var_a8ab57ac69f09ee5 )
        {
            return getxhashasset( var_a8ab57ac69f09ee5 );
        }
        else if ( lootidtype == #"weapon" )
        {
            weaponname = level.br_pickups.var_cf921d0c5390e142[ lootid ];
            return function_9e0228b5d7c1a88a( weaponname );
        }
    }
    else if ( isdefined( level.brloottablename ) )
    {
        var_c818577095e7c5c8 = tablelookuprownum( level.brloottablename, 5, lootid );
        
        if ( var_c818577095e7c5c8 >= 0 )
        {
            var_a8ab57ac69f09ee5 = tablelookupbyrow( level.brloottablename, var_c818577095e7c5c8, 29 );
            
            if ( var_a8ab57ac69f09ee5 )
            {
                return var_a8ab57ac69f09ee5;
            }
            else if ( lootidtype == "weapon" )
            {
                weaponname = tablelookupbyrow( level.brloottablename, var_c818577095e7c5c8, 1 );
                return function_9e0228b5d7c1a88a( weaponname );
            }
        }
        else if ( utility::issharedfuncdefined( #"game", #"hash_35447656b103dd34" ) )
        {
            itembundlename = [[ utility::getsharedfunc( #"game", #"hash_35447656b103dd34" ) ]]( lootid );
            
            if ( isdefined( itembundlename ) )
            {
                itembundle = getscriptbundle( itembundlename );
                
                if ( isdefined( itembundle.pingvo ) )
                {
                    return itembundle.pingvo;
                }
            }
        }
    }
    
    return %"ping_loot_generic";
}

// Namespace calloutmarkerping
// Params 1, eflags: 0x4
// Checksum 0x250d7d5b, Offset: 0x382a
// Size: 0x27c
function private function_984a819d2008ee95( lootid )
{
    baseweaponname = "";
    
    if ( utility::issharedfuncdefined( #"game", #"hash_35447656b103dd34" ) )
    {
        baseweaponname = "";
        itembundlename = [[ utility::getsharedfunc( #"game", #"hash_35447656b103dd34" ) ]]( lootid );
        
        if ( isdefined( itembundlename ) )
        {
            itembundle = getscriptbundle( itembundlename );
            
            if ( isdefined( itembundle.baseweapon ) )
            {
                baseweaponname = itembundle.baseweapon;
            }
        }
    }
    else if ( level.var_bfa750d9db209a4b )
    {
        if ( isdefined( level.br_pickups.var_cf921d0c5390e142[ lootid ] ) )
        {
            itemname = level.br_pickups.var_cf921d0c5390e142[ lootid ];
            
            if ( isdefined( itemname ) && isdefined( level.br_lootiteminfo[ itemname ].baseweapon ) )
            {
                baseweaponname = level.br_lootiteminfo[ itemname ].baseweapon;
            }
        }
    }
    else
    {
        assert( isdefined( level.brloottablename ) );
        baseweaponname = tablelookup( level.brloottablename, 5, lootid, 8 );
    }
    
    weaponclasstoken = weapon::getweaponclasstoken( baseweaponname );
    
    if ( isdefined( weaponclasstoken ) )
    {
        switch ( weaponclasstoken )
        {
            case #"hash_fa18d2f6bd57925a":
                return %"ping_inv_have_weapon_assaultrifle";
            case #"hash_fa50b9f6bd82f79d":
                return %"ping_inv_have_weapon_smg";
            case #"hash_fa27b9f6bd62a3f2":
                return %"ping_inv_have_weapon_lmg";
            case #"hash_fa50b4f6bd82efbe":
                return %"ping_inv_have_weapon_shotgun";
            case #"hash_fa50b6f6bd82f2e4":
                return %"ping_inv_have_weapon_sniper";
            case #"hash_fa0ed9f6bd4f4e9a":
                return %"ping_inv_have_weapon_dmr";
            case #"hash_fa4dbdf6bd80bf52":
                return %"ping_inv_have_weapon_pistol";
            case #"hash_fa27bdf6bd62aa3e":
                return %"ping_inv_have_weapon_launcher";
            case #"hash_fa24ddf6bd609e07":
                if ( issubstr( baseweaponname, "riotshield" ) )
                {
                    return %"ping_inv_have_weapon_riotshield";
                }
                else
                {
                    return %"ping_inv_have_weapon_melee";
                }
            default:
                logprint( "CalloutMarkerPing: " + "Could not get request VO for loot ID " + lootid );
                return;
        }
        
        return;
    }
    
    logprint( "CalloutMarkerPing: " + "Could not get request VO for loot ID " + lootid );
    return;
}

// Namespace calloutmarkerping
// Params 0, eflags: 0x4
// Checksum 0x61098755, Offset: 0x3aae
// Size: 0x19e
function private refreshpaths()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        waittillframeend();
        wait 1;
        var_e1ea1b27af2caeb = function_abf2f3dce5638822();
        
        foreach ( pathid in var_e1ea1b27af2caeb )
        {
            [ start, end ] = function_a52f75d036c4e888( pathid );
            [ roadnetworkpath, var_d7b6c197f2d4e41c, var_d58a35ed9c9274df ] = vehicle_roads::function_3fd54488ab0c7c72( start, end );
            indices = [];
            
            foreach ( node in roadnetworkpath )
            {
                indices = arraycombine( [ node.index ], indices );
            }
            
            function_ceed0247c13c5396( pathid, indices, var_d58a35ed9c9274df.index ?? -1, end );
        }
    }
}

// Namespace calloutmarkerping
// Params 1, eflags: 0x4
// Checksum 0xd69d22c8, Offset: 0x3c54
// Size: 0x3a7
function private function_16bbb1c6e3844dc7( lootid )
{
    lootidtype = loot::function_52cf8374c44a4ff5( lootid );
    
    if ( lootidtype == "calloutmarkerpingitem" )
    {
        return function_b50aafc2ba9127f4( lootid );
    }
    
    itemdeftype = "";
    
    if ( utility::issharedfuncdefined( #"game", #"hash_35447656b103dd34" ) )
    {
        itembundlename = [[ utility::getsharedfunc( #"game", #"hash_35447656b103dd34" ) ]]( lootid );
        
        if ( isdefined( itembundlename ) )
        {
            itembundle = getscriptbundle( itembundlename );
            
            if ( isdefined( itembundle ) )
            {
                itemdeftype = getxhash( utility::callsharedfunc( #"game", #"hash_dca65b23d72fe65f", itembundle ) );
            }
        }
    }
    else if ( level.var_bfa750d9db209a4b )
    {
        if ( isdefined( level.br_pickups.var_cf921d0c5390e142[ lootid ] ) )
        {
            itemname = level.br_pickups.var_cf921d0c5390e142[ lootid ];
            
            if ( isdefined( itemname ) && isdefined( level.br_pickups.br_itemtype[ itemname ] ) )
            {
                itemdeftype = level.br_pickups.br_itemtype[ itemname ];
            }
        }
    }
    else
    {
        assert( isdefined( level.brloottablename ) );
        itemdeftype = getxhash( tablelookup( level.brloottablename, 5, lootid, 2 ) );
    }
    
    switch ( itemdeftype )
    {
        case #"weapon":
            return function_984a819d2008ee95( lootid );
        case #"lethal":
            return %"ping_inv_have_equipment_lethal_generic";
        case #"tactical":
            return %"ping_inv_have_equipment_tactical_generic";
        case #"revive":
            return %"ping_inv_have_medical";
        case #"plunder":
        case #"currency":
            return %"ping_inv_have_cash";
        case #"killstreak":
            return %"ping_inv_have_killstreak_generic";
        case #"super":
            return %"ping_inv_have_fieldupgrade_generic";
        case #"key":
            return %"ping_inv_have_key";
        case #"keycard":
            return %"ping_inv_have_keycard";
        case #"dogtag":
            return %"ping_inv_have_player_dogtag";
        case #"valuable":
            return %"ping_inv_have_valuable";
        case #"armor":
            return %"ping_inv_have_armor";
        case #"gasmask":
            return %"ping_loot_gasmask";
        default:
            scriptablename = loot::getScriptableFromLootID( lootid ) ?? "";
            
            switch ( scriptablename )
            {
                case #"hash_55798564991651ac":
                    return %"ping_inv_have_armor";
                case #"hash_1cd9ffa488237604":
                    return %"ping_inv_need_smallcal";
                case #"hash_672892a4af1e94cc":
                    return %"ping_inv_need_midcal";
                case #"hash_f1734c15f85881ca":
                    return %"ping_inv_need_highcal";
                case #"hash_57e5eda4a702c559":
                    return %"ping_inv_need_shells";
                case #"hash_755a9bafcd63b343":
                    return %"ping_inv_need_launcher";
                case #"hash_1b71e2c3430cd301":
                case #"hash_2d1a1b811aed6b26":
                case #"hash_d01e387e6d238502":
                    return %"ping_loot_gasmask";
                default:
                    logprint( "CalloutMarkerPing: " + "Could not get request VO for loot ID " + lootid );
                    return;
            }
            
            break;
    }
}

// Namespace calloutmarkerping
// Params 1, eflags: 0x4
// Checksum 0x6ebc2f70, Offset: 0x4003
// Size: 0x2a5
function private function_a0cd63d5613ba487( lootid )
{
    lootidtype = loot::function_52cf8374c44a4ff5( lootid );
    
    if ( lootidtype == "calloutmarkerpingitem" )
    {
        return function_b50aafc2ba9127f4( lootid );
    }
    
    itemdeftype = "";
    
    if ( utility::issharedfuncdefined( #"game", #"hash_35447656b103dd34" ) )
    {
        itembundlename = [[ utility::getsharedfunc( #"game", #"hash_35447656b103dd34" ) ]]( lootid );
        
        if ( isdefined( itembundlename ) )
        {
            itembundle = getscriptbundle( itembundlename );
            
            if ( isdefined( itembundle ) )
            {
                itemdeftype = getxhash( utility::callsharedfunc( #"game", #"hash_dca65b23d72fe65f", itembundle ) );
            }
        }
    }
    else if ( level.var_bfa750d9db209a4b )
    {
        if ( isdefined( level.br_pickups.var_cf921d0c5390e142[ lootid ] ) )
        {
            itemname = level.br_pickups.var_cf921d0c5390e142[ lootid ];
            
            if ( isdefined( itemname ) && isdefined( level.br_pickups.br_itemtype[ itemname ] ) )
            {
                itemdeftype = level.br_pickups.br_itemtype[ itemname ];
            }
        }
    }
    else
    {
        assert( isdefined( level.brloottablename ) );
        itemdeftype = tablelookup( level.brloottablename, 5, lootid, 2 );
    }
    
    switch ( itemdeftype )
    {
        case #"hash_59b8e9d05b31ff9":
        case #"plunder":
            return %"ping_inv_need_cash";
        case #"armor":
            return %"ping_inv_need_armor";
        case #"gasmask":
            return %"ping_request_gas_mask";
        case #"killstreak":
            return %"ping_need_killstreak";
        case #"super":
            return %"ping_need_fieldupgrade";
        default:
            scriptablename = loot::getScriptableFromLootID( lootid ) ?? "";
            
            switch ( scriptablename )
            {
                case %"brloot_ammo_919":
                    return %"ping_inv_need_smallcal";
                case %"brloot_ammo_762":
                    return %"ping_inv_need_midcal";
                case %"brloot_ammo_50cal":
                    return %"ping_inv_need_highcal";
                case %"brloot_ammo_12g":
                    return %"ping_inv_need_shells";
                case %"brloot_ammo_rocket":
                    return %"ping_inv_need_launcher";
                default:
                    return function_16bbb1c6e3844dc7( lootid );
            }
            
            break;
    }
}

// Namespace calloutmarkerping
// Params 2, eflags: 0x4
// Checksum 0xf7e67e68, Offset: 0x42b0
// Size: 0x57
function private function_34c0394dcf3b3adf( var_6675b0888e2dbc2, lootid )
{
    if ( function_9bd60fbf1b0a82e7( var_6675b0888e2dbc2 ) )
    {
        return function_36506c9de0ac7a6d( lootid );
    }
    
    if ( var_6675b0888e2dbc2 == function_1bf3a084cfe14025( 10 ) )
    {
        return function_a0cd63d5613ba487( lootid );
    }
    
    if ( var_6675b0888e2dbc2 == function_1bf3a084cfe14025( 11 ) )
    {
        return function_16bbb1c6e3844dc7( lootid );
    }
}

// Namespace calloutmarkerping
// Params 1, eflags: 0x4
// Checksum 0x441c792e, Offset: 0x430f
// Size: 0x159
function private function_1220e16172b72e42( var_6675b0888e2dbc2 )
{
    player = self;
    assert( isplayer( player ) );
    var_6431f032630be006 = undefined;
    
    if ( var_6675b0888e2dbc2 == function_1bf3a084cfe14025( 10 ) || var_6675b0888e2dbc2 == function_1bf3a084cfe14025( 11 ) )
    {
        var_6431f032630be006 = spawnstruct();
        var_6431f032630be006.object = player;
        var_6431f032630be006.entindex = player getentitynumber();
    }
    else if ( var_6675b0888e2dbc2 == function_1bf3a084cfe14025( 12 ) )
    {
        kiosk = player.br_kiosk ?? player.common_kiosk ?? player.var_d98abf47f4c28e28;
        
        if ( level.var_dbdd35c475d50ae3 && !isdefined( kiosk ) )
        {
            return;
        }
        
        assert( kiosk );
        var_6431f032630be006 = spawnstruct();
        var_6431f032630be006.object = kiosk;
        var_6431f032630be006.scriptableindex = kiosk.index;
    }
    else if ( var_6675b0888e2dbc2 == function_1bf3a084cfe14025( 13 ) )
    {
        if ( isdefined( player.var_50f741a14f09a6 ) )
        {
            var_6431f032630be006 = spawnstruct();
            var_6431f032630be006.object = player.var_50f741a14f09a6;
            var_6431f032630be006.scriptableindex = player.var_50f741a14f09a6.index;
        }
    }
    
    return var_6431f032630be006;
}

// Namespace calloutmarkerping
// Params 2, eflags: 0x4
// Checksum 0x4a03d32e, Offset: 0x4471
// Size: 0x48
function private function_bde9be8e0aa63506( var_6675b0888e2dbc2, object )
{
    player = self;
    assert( isplayer( player ) );
    
    if ( function_9bd60fbf1b0a82e7( var_6675b0888e2dbc2 ) )
    {
        object function_608710c894185549( player, 1, 1 );
        waitframe();
    }
}

// Namespace calloutmarkerping
// Params 3, eflags: 0x4
// Checksum 0x63eb146e, Offset: 0x44c1
// Size: 0x77
function private function_c787e8bb878f134f( object, player, lootid )
{
    pingindex = player function_880706287a0f41fe();
    
    if ( isdefined( pingindex ) )
    {
        pingobject = player calloutmarkerping_getent( pingindex );
        
        if ( object == pingobject )
        {
            if ( isdefined( lootid ) )
            {
                pinglootid = player function_d3e0d9364e4846b8( pingindex );
                
                if ( lootid == pinglootid )
                {
                    return pingindex;
                }
                
                return;
            }
            
            return pingindex;
        }
    }
}

// Namespace calloutmarkerping
// Params 3, eflags: 0x4
// Checksum 0x7f8c6951, Offset: 0x4541
// Size: 0xf0
function private function_99bb86ac4bae26cf( object, team, lootid )
{
    assert( isdefined( level.teamdata[ team ] ) );
    assert( isdefined( level.teamdata[ team ][ "<dev string:xc2>" ] ) );
    teammembers = level.teamdata[ team ][ "players" ];
    
    foreach ( member in teammembers )
    {
        pingindex = function_c787e8bb878f134f( object, member, lootid );
        
        if ( isdefined( pingindex ) )
        {
            return pingindex;
        }
    }
}

// Namespace calloutmarkerping
// Params 0
// Checksum 0x4889f240, Offset: 0x463a
// Size: 0xee
function function_d34345aa1f30ebba()
{
    player = self;
    openkiosk = player.br_kiosk;
    var_ad99377850931956 = player.common_kiosk;
    opencontainer = player.var_50f741a14f09a6;
    
    if ( isdefined( openkiosk ) && isdefined( function_99bb86ac4bae26cf( openkiosk, player.team ) ) )
    {
        player setclientomnvar( "ui_show_lootid_item_pings", 1 );
        return;
    }
    
    if ( isdefined( var_ad99377850931956 ) && isdefined( function_99bb86ac4bae26cf( var_ad99377850931956, player.team ) ) )
    {
        player setclientomnvar( "ui_show_lootid_item_pings", 1 );
        return;
    }
    
    if ( isdefined( opencontainer ) && isdefined( function_99bb86ac4bae26cf( opencontainer, player.team ) ) && isdefined( opencontainer.var_488526e1eed488ac ) )
    {
        player setclientomnvar( "ui_show_lootid_item_pings", 1 );
        return;
    }
    
    player setclientomnvar( "ui_show_lootid_item_pings", 0 );
}

// Namespace calloutmarkerping
// Params 1, eflags: 0x4
// Checksum 0xe4670c7a, Offset: 0x4730
// Size: 0xca
function private function_c9183cb1c2e26e82( team )
{
    assert( isdefined( level.teamdata[ team ] ) );
    assert( isdefined( level.teamdata[ team ][ "<dev string:xc2>" ] ) );
    teammembers = level.teamdata[ team ][ "players" ];
    
    foreach ( member in teammembers )
    {
        member function_d34345aa1f30ebba();
    }
}

// Namespace calloutmarkerping
// Params 3, eflags: 0x4
// Checksum 0x626ddc30, Offset: 0x4802
// Size: 0x112, Type: bool
function private function_b867b66ac753e84e( pingobject, var_6675b0888e2dbc2, pinglootid )
{
    player = self;
    oldpingindex = player function_880706287a0f41fe();
    
    if ( isdefined( oldpingindex ) )
    {
        oldobject = player calloutmarkerping_getent( oldpingindex );
        var_4b255c4317c0f78d = player function_689a4266a29aac13( oldpingindex );
        oldlootid = player function_d3e0d9364e4846b8( oldpingindex );
        var_b6510e19d0e338cf = var_6675b0888e2dbc2 == function_1bf3a084cfe14025( 10 ) || var_6675b0888e2dbc2 == function_1bf3a084cfe14025( 11 );
        
        if ( !var_b6510e19d0e338cf || level.calloutmarkerping.var_d25db4d8e1c32bad )
        {
            player function_7c0ee9d4b604e6d6( oldpingindex );
        }
        
        var_1a6e28b886a6cc0d = pingobject == oldobject && var_6675b0888e2dbc2 == var_4b255c4317c0f78d && pinglootid == oldlootid;
        
        if ( var_1a6e28b886a6cc0d && ( !var_b6510e19d0e338cf || level.calloutmarkerping.var_d25db4d8e1c32bad ) )
        {
            player playteamsoundfx( "uin_ping_cancel", oldpingindex );
            return true;
        }
    }
    
    return false;
}

// Namespace calloutmarkerping
// Params 2
// Checksum 0xf1b2c28e, Offset: 0x491d
// Size: 0x1f6
function function_4bf4d6b965e2853d( var_6675b0888e2dbc2, lootid )
{
    player = self;
    
    if ( !function_f49f4b43ae52ee8d( player ) )
    {
        return;
    }
    
    var_19755e90b7c652e5 = player function_1220e16172b72e42( var_6675b0888e2dbc2 );
    
    if ( isdefined( var_19755e90b7c652e5 ) )
    {
        if ( function_b867b66ac753e84e( var_19755e90b7c652e5.object, var_6675b0888e2dbc2, lootid ) )
        {
            function_c9183cb1c2e26e82( player.team );
            return;
        }
        
        function_bde9be8e0aa63506( var_6675b0888e2dbc2, var_19755e90b7c652e5.object );
        pingindex = player createcallout( var_6675b0888e2dbc2, undefined, var_19755e90b7c652e5.entindex, var_19755e90b7c652e5.scriptableindex, undefined, lootid );
        
        if ( isdefined( pingindex ) )
        {
            if ( isdefined( var_19755e90b7c652e5.object.containertype ) )
            {
                if ( !isdefined( var_19755e90b7c652e5.object.var_488526e1eed488ac ) )
                {
                    var_19755e90b7c652e5.object.var_488526e1eed488ac = [];
                }
                
                entnum = player getentitynumber();
                
                if ( !isdefined( var_19755e90b7c652e5.object.var_488526e1eed488ac[ entnum ] ) )
                {
                    var_19755e90b7c652e5.object.var_488526e1eed488ac[ entnum ] = spawnstruct();
                }
                
                var_19755e90b7c652e5.object.var_488526e1eed488ac[ entnum ].pingowner = player;
                var_19755e90b7c652e5.object.var_488526e1eed488ac[ entnum ].pingindex = pingindex;
                var_19755e90b7c652e5.object.var_488526e1eed488ac[ entnum ].lootid = lootid;
            }
            
            player thread function_87cc85e0414a9636( var_6675b0888e2dbc2, lootid );
            function_c9183cb1c2e26e82( player.team );
            player playteamsoundfx( "uin_ping_item", pingindex );
            player dlog_add( pingindex );
            player thread predicted_timeout( pingindex );
        }
    }
}

// Namespace calloutmarkerping
// Params 2, eflags: 0x4
// Checksum 0x97037af1, Offset: 0x4b1b
// Size: 0x83
function private function_87cc85e0414a9636( var_6675b0888e2dbc2, lootid )
{
    player = self;
    wait level.calloutmarkerping.var_f62f563b629e03d5;
    voalias = function_34c0394dcf3b3adf( var_6675b0888e2dbc2, lootid );
    
    if ( isdefined( voalias ) && isdefined( player ) )
    {
        var_e3e63375d4550930 = player function_1743167cf709c188( 4 ) || player function_1743167cf709c188( 5 );
        
        if ( var_e3e63375d4550930 )
        {
            player play( voalias, var_6675b0888e2dbc2 );
        }
    }
}

// Namespace calloutmarkerping
// Params 1, eflags: 0x4
// Checksum 0xf2eff49d, Offset: 0x4ba6
// Size: 0x80
function private function_cd837c1b9212eced( pingindex )
{
    player = self;
    
    if ( isalive( player ) )
    {
        return;
    }
    
    var_6675b0888e2dbc2 = player function_689a4266a29aac13( pingindex );
    
    if ( !function_4c1b7cae739d9840( var_6675b0888e2dbc2 ) )
    {
        return;
    }
    
    instance = player calloutmarkerping_getent( pingindex );
    
    if ( !iskiosk( instance ) )
    {
        return;
    }
    
    player notify( #"buybackrequested" );
    player playteamsoundfx( %"ping_buystation_request_revive", pingindex, 1 );
}

// Namespace calloutmarkerping
// Params 1
// Checksum 0xf66c0474, Offset: 0x4c2e
// Size: 0x1e6
function function_df7a1fc92c2b5b29( pingindex )
{
    if ( !isdefined( pingindex ) )
    {
        assertmsg( "<dev string:x4a>" + "<dev string:xca>" );
        return;
    }
    
    player = self;
    var_25d80124122c8304 = player calloutmarkerping_getent( pingindex );
    var_6675b0888e2dbc2 = player function_689a4266a29aac13( pingindex );
    
    if ( !function_4838d0aa6e70099f( var_6675b0888e2dbc2 ) )
    {
        println( "<dev string:x4a>" + "<dev string:xf0>" );
        return;
    }
    
    if ( player.bcdisabled )
    {
        return;
    }
    
    if ( isdefined( level.var_97d7c13d242bcb15 ) )
    {
        var_233f996bf5979ff6 = player [[ level.var_97d7c13d242bcb15 ]]( var_25d80124122c8304, pingindex );
        
        if ( isstring( var_233f996bf5979ff6 ) && var_233f996bf5979ff6 != "" || isxhash( var_233f996bf5979ff6 ) && var_233f996bf5979ff6 != #"" || isxhashasset( var_233f996bf5979ff6 ) && var_233f996bf5979ff6 != %"" )
        {
            var_d6f8a22c7d24e6b6 = var_233f996bf5979ff6;
        }
    }
    
    if ( !isdefined( var_d6f8a22c7d24e6b6 ) || var_d6f8a22c7d24e6b6 === "" || var_d6f8a22c7d24e6b6 === #"" || var_d6f8a22c7d24e6b6 === %"" )
    {
        if ( function_4c1b7cae739d9840( var_6675b0888e2dbc2 ) )
        {
            var_d6f8a22c7d24e6b6 = player function_cf37792ae7575350( pingindex, var_25d80124122c8304 );
            
            if ( !isdefined( var_d6f8a22c7d24e6b6 ) )
            {
                return;
            }
        }
        else if ( function_4095a4f8e53eb368( var_6675b0888e2dbc2 ) )
        {
            assert( isent( var_25d80124122c8304 ) );
            var_d6f8a22c7d24e6b6 = player function_f8e6b1f67cef1518( var_6675b0888e2dbc2, var_25d80124122c8304 );
        }
        else if ( function_d929a855518b925a( var_6675b0888e2dbc2 ) )
        {
            if ( isbrgamemode() && isdefined( player.br_infil_type ) )
            {
                var_d6f8a22c7d24e6b6 = %"ping_location_landing";
            }
        }
        else if ( var_6675b0888e2dbc2 == function_1bf3a084cfe14025( 6 ) )
        {
            var_d6f8a22c7d24e6b6 = player function_d69c38de3f2499cd( pingindex );
        }
    }
    
    if ( var_d6f8a22c7d24e6b6 === #"hash_fe627f96d984fd11" )
    {
        return;
    }
    
    if ( !isdefined( var_d6f8a22c7d24e6b6 ) )
    {
        var_d6f8a22c7d24e6b6 = function_402ca439bbef017b( var_6675b0888e2dbc2 );
    }
    
    player play( var_d6f8a22c7d24e6b6, var_6675b0888e2dbc2, var_25d80124122c8304 );
}

// Namespace calloutmarkerping
// Params 1, eflags: 0x4
// Checksum 0x7cf15e8d, Offset: 0x4e1c
// Size: 0x155
function private function_97907d2c28d5c064( pingindex )
{
    player = self;
    var_6675b0888e2dbc2 = player function_689a4266a29aac13( pingindex );
    
    if ( !utility::issharedfuncdefined( #"challenges", #"hash_2c6a95afa7a255c8" ) )
    {
        return;
    }
    
    if ( function_4c1b7cae739d9840( var_6675b0888e2dbc2 ) )
    {
        self [[ utility::getsharedfunc( #"challenges", #"hash_2c6a95afa7a255c8" ) ]]( "object" );
        return;
    }
    
    if ( function_4095a4f8e53eb368( var_6675b0888e2dbc2 ) )
    {
        ent = self calloutmarkerping_getent( pingindex );
        
        if ( isdefined( ent ) )
        {
            if ( isenemy( ent, self ) )
            {
                self [[ utility::getsharedfunc( #"challenges", #"hash_2c6a95afa7a255c8" ) ]]( "enemy" );
                function_7103870fdc5cd43b( ent, self );
            }
            else if ( !isplayer( ent ) )
            {
                self [[ utility::getsharedfunc( #"challenges", #"hash_2c6a95afa7a255c8" ) ]]( "object" );
            }
        }
        
        return;
    }
    
    if ( function_6fb215412d4f2585( var_6675b0888e2dbc2 ) )
    {
        self [[ utility::getsharedfunc( #"challenges", #"hash_2c6a95afa7a255c8" ) ]]( "danger" );
        return;
    }
    
    if ( function_312dddfe3b19adcc( var_6675b0888e2dbc2 ) )
    {
        self [[ utility::getsharedfunc( #"challenges", #"hash_2c6a95afa7a255c8" ) ]]( "object" );
    }
}

// Namespace calloutmarkerping
// Params 2, eflags: 0x4
// Checksum 0x87af62b8, Offset: 0x4f79
// Size: 0xb92
function private function_f8e6b1f67cef1518( var_6675b0888e2dbc2, var_36711133cee70e30 )
{
    var_8c953eb201608663 = self;
    
    if ( isent( var_36711133cee70e30 ) )
    {
        ent = var_36711133cee70e30;
    }
    else
    {
        assertmsg( "<dev string:x4a>" + "<dev string:x151>" );
        return "";
    }
    
    isfriendly = ent vehicle::is_vehicle() ? !isvehicleoccupiedbyenemy( ent, var_8c953eb201608663.team ) : ent.team == var_8c953eb201608663.team;
    var_f53426fb0b0e62b8 = function_402ca439bbef017b( var_6675b0888e2dbc2 );
    var_b68cc6b6c43d68a3 = function_c1a045746563b625( var_6675b0888e2dbc2 );
    
    if ( isdefined( var_f53426fb0b0e62b8 ) && isdefined( var_b68cc6b6c43d68a3 ) )
    {
        return ( isfriendly ? var_f53426fb0b0e62b8 : var_b68cc6b6c43d68a3 );
    }
    else if ( isplayer( ent ) && ent == var_8c953eb201608663 && ent ismeatshieldvictim() )
    {
        return %"ping_meatshield_callforhelp";
    }
    else if ( isplayer( ent ) && isfriendly )
    {
        return %"ping_request_revive";
    }
    else if ( isdefined( ent.juggcontext ) || ent.isjuggernaut )
    {
        if ( isdmzgamemode() )
        {
            if ( isdefined( ent.bosstype ) )
            {
                return %"ping_boss_generic";
            }
            else
            {
                return %"ping_enemy_infantry";
            }
        }
    }
    else if ( ent.animname == "fulton" )
    {
        return %"ping_fulton";
    }
    else if ( ent.equipmentref == "super_door_barricade" )
    {
        if ( isfriendly )
        {
            return %"ping_fieldupgrade_generic";
        }
        else
        {
            return %"ping_fieldupgrade_generic_hostile";
        }
    }
    else if ( isdefined( ent.streakname ) )
    {
        killstreakvo = function_fb5a59465c473c39( ent, var_8c953eb201608663 );
        
        if ( isdefined( killstreakvo ) )
        {
            return killstreakvo;
        }
    }
    else if ( issoundveil( ent ) )
    {
        if ( isfriendly )
        {
            return %"ping_fieldupgrade_soundveil";
        }
        else
        {
            return %"ping_fieldupgrade_soundveil_hostile";
        }
    }
    else if ( issonarpulse( ent ) )
    {
        if ( isfriendly )
        {
            return %"ping_fieldupgrade_sonarpulse";
        }
        else
        {
            return %"ping_fieldupgrade_sonarpulse_hostile";
        }
    }
    else if ( isredeploydronebeacon( ent ) )
    {
        if ( isfriendly )
        {
            return %"ping_fieldupgrade_redeploydronebeacon";
        }
        else
        {
            return %"ping_fieldupgrade_redeploydronebeacon_hostile";
        }
    }
    else if ( isdeconstation( ent ) )
    {
        if ( isfriendly )
        {
            return %"ping_inv_have_decontaminationstation";
        }
    }
    else if ( isairdrop( ent ) )
    {
        airdroptype = ent.streakinfo.airdroptype;
        
        switch ( airdroptype )
        {
            case #"hash_2289ec11d77bce8f":
            case #"hash_56979e0566996b2e":
                airdroptype = "carepackage";
                break;
            case #"hash_4ad475e6e15635bd":
                airdroptype = "juggernaut_box";
                break;
            case #"hash_b597e9a707180461":
                airdroptype = "loadoutdrop";
                break;
        }
        
        pingtype = "killstreak";
        
        if ( airdroptype == "loadoutdrop" )
        {
            pingtype = "fieldupgrade";
        }
        
        var_9b30052f13c0367f = undefined;
        
        if ( level.teambased )
        {
            if ( isdefined( ent.team ) && self.team != ent.team )
            {
                var_9b30052f13c0367f = "hostile";
            }
        }
        else if ( isdefined( ent.owner ) && self != ent.owner )
        {
            var_9b30052f13c0367f = "hostile";
        }
        
        calloutalias = "ping_" + pingtype + "_" + airdroptype;
        
        if ( isdefined( var_9b30052f13c0367f ) )
        {
            calloutalias = calloutalias + "_" + var_9b30052f13c0367f;
        }
        
        return getxhashasset( calloutalias );
    }
    else if ( isweaponent( ent ) )
    {
        if ( ent.iscustomweapon )
        {
            return %"ping_loot_weapon_custom";
        }
        
        weaponname = strtok( ent.classname, "+" )[ 0 ];
        return function_9e0228b5d7c1a88a( weaponname );
    }
    else if ( ent.cratetype == "loadout_drop_cp" )
    {
        return %"ping_fieldupgrade_loadoutdrop";
    }
    else if ( isequipment( ent ) )
    {
        if ( level.gamemodebundle.var_a2838344dfe550ea )
        {
            if ( isfriendly )
            {
                return #"hash_fe627f96d984fd11";
            }
        }
        
        bundle = equipment_mp::function_c90a9aa89b223dd7( ent.equipmentref );
        
        if ( isfriendly )
        {
            if ( isdefined( bundle.var_cd7dc5886393bee3 ) )
            {
                return battlechatter_mp::function_694f04feb7ef7c08( bundle.var_cd7dc5886393bee3 );
            }
        }
        else if ( isdefined( bundle.var_e895b2713a4c6b3 ) )
        {
            return battlechatter_mp::function_694f04feb7ef7c08( bundle.var_e895b2713a4c6b3 );
        }
        
        if ( ent.var_ba2e8824e2e859e7 )
        {
            return %"ping_fieldupgrade_trophy_hostile";
        }
        
        prefix = %"ping_equipment_";
        weaponrootname = "";
        
        if ( isdefined( ent.weapon_object ) )
        {
            weaponrootname = getweaponrootstring( ent.weapon_object );
        }
        else if ( isdefined( ent.sourcegrenade ) && isdefined( ent.sourcegrenade.weapon_object ) )
        {
            weaponrootname = getweaponrootstring( ent.sourcegrenade.weapon_object );
        }
        
        var_8c430f2cf618f84f = "";
        
        if ( equipment_mp::isequipmentlethal( ent.equipmentref ) )
        {
            var_8c430f2cf618f84f = "lethal_generic";
        }
        else if ( equipment_mp::isequipmenttactical( ent.equipmentref ) )
        {
            var_8c430f2cf618f84f = "tactical_generic";
        }
        
        switch ( weaponrootname )
        {
            case #"hash_7fd9546fa84e64a5":
                var_8c430f2cf618f84f = "tactical_generic";
                break;
            case #"hash_d9108a0595d7d0b9":
                var_8c430f2cf618f84f = "buster";
                break;
            case #"hash_fa1e80f6bd5b8e72":
                var_8c430f2cf618f84f = "c4";
                break;
            case #"hash_36b7174a04de8799":
                var_8c430f2cf618f84f = "claymore";
                break;
            case #"hash_333525cef39d0c66":
                var_8c430f2cf618f84f = "decoy";
                break;
            case #"hash_8059d93d3568c07":
                var_8c430f2cf618f84f = "gas";
                break;
            case #"hash_f7d2b3d20ecdcc2c":
                var_8c430f2cf618f84f = "tactical_generic";
                break;
            case #"hash_9d57562863499a06":
                var_8c430f2cf618f84f = "proxmine";
                break;
            case #"hash_11a03a12f93f62b2":
                var_8c430f2cf618f84f = "shockstick";
                break;
            case #"hash_a0319e349a692b8f":
                var_8c430f2cf618f84f = "thermite";
                break;
            case #"hash_e1f6f84e4cd950eb":
                var_8c430f2cf618f84f = "smoke";
                break;
            case #"hash_17c70dc48424ba92":
                var_8c430f2cf618f84f = "breacher_drone";
                break;
            case #"hash_5f29cda9550e6a3a":
                var_8c430f2cf618f84f = "butterfly_mine";
                break;
            case #"hash_a68928468343f517":
                if ( isfriendly )
                {
                    return %"ping_fieldupgrade_tacinsert";
                }
                else
                {
                    return %"ping_fieldupgrade_tacinsert_hostile";
                }
                
                break;
        }
        
        if ( var_8c430f2cf618f84f == "" )
        {
            /#
                iprintlnbold( "<dev string:x179>" );
            #/
            
            return #"hash_fe627f96d984fd11";
        }
        
        if ( isfriendly )
        {
            return hashcat( prefix, var_8c430f2cf618f84f );
        }
        else
        {
            return hashcat( prefix, var_8c430f2cf618f84f, "_hostile" );
        }
    }
    else if ( ent.model == "military_ammo_restock_location" || ent.model == "military_ammo_restock_location_solid" )
    {
        return %"ping_ammo_depot";
    }
    else if ( ent.model == "military_armor_station_01_open_full" )
    {
        return %"ping_fieldupgrade_armorbox";
    }
    else if ( issubstr( ent.model, "offhand_wm_container_gas_tank" ) )
    {
        return %"ping_equipment_lethal_generic";
    }
    else if ( issubstr( ent.model, "train_" ) )
    {
        return %"ping_location_go";
    }
    else if ( issubstr( ent.model, "cuniform" ) )
    {
        return %"ping_killstreak_counteruav";
    }
    else if ( ent.model == "military_dmz_sam_site_turret_rig" )
    {
        if ( isfriendly )
        {
            return %"ping_samsite_friendly";
        }
        else
        {
            return %"ping_samsite_hostile";
        }
    }
    else if ( isdmzgamemode() && isdefined( ent.subcategory ) && ent.subcategory == "elimTarget" )
    {
        return %"ping_elimtarget";
    }
    else if ( isdmzgamemode() && ent.ishostage )
    {
        return %"ping_hostage";
    }
    else if ( isdmzgamemode() && isboss( ent ) )
    {
        if ( isdefined( ent.bossinstance ) )
        {
            ent = ent.bossinstance;
        }
        
        if ( ent.bossname == "chemist" )
        {
            return %"ping_boss_chemist";
        }
        else if ( ent.bossname == "pyro" )
        {
            return %"ping_boss_pyro";
        }
        else if ( ent.bossname == "trapper" )
        {
            return %"ping_boss_trap";
        }
        
        return %"ping_boss_generic";
    }
    else if ( ent utility::callsharedfunc( #"wolf", #"iswolf" ) )
    {
        return %"hash_4955df57510d7f3e";
    }
    else if ( isenemy( ent, self ) )
    {
        enemyweapon = ent getcurrentweapon();
        
        if ( isplayer( ent ) )
        {
            if ( ent.inlaststand )
            {
                return %"ping_enemy_downed";
            }
            else if ( !player::isreallyalive( ent ) )
            {
                return %"ping_enemy_killed";
            }
        }
        
        if ( weapon_utility::isriotshield( enemyweapon ) )
        {
            return %"ping_enemy_riotshield";
        }
        else if ( isweapon( enemyweapon ) && !isnullweapon( enemyweapon ) && weaponclass( enemyweapon ) == "sniper" )
        {
            return %"ping_enemy_sniper";
        }
        else if ( ent.basearchetype == "rusher" )
        {
            return %"ping_rusher";
        }
        
        if ( isdmzgamemode() && isdefined( ent.tier ) )
        {
            tier = ent.tier;
            elitestatus = ent.elite;
            
            switch ( tier )
            {
                case 1:
                    return ( istrue( elitestatus ) ? %"ping_enemy_tier1e" : %"ping_enemy_tier1" );
                case 2:
                    return ( istrue( elitestatus ) ? %"ping_enemy_tier2e" : %"ping_enemy_tier2" );
                case 3:
                    return ( istrue( elitestatus ) ? %"ping_enemy_tier3e" : %"ping_enemy_tier3" );
                default:
                    return %"ping_enemy_infantry";
            }
        }
    }
    else if ( issubstr( ent.model, "mortar" ) )
    {
        return %"ping_enemy_mortar";
    }
    else if ( issubstr( ent.model, "oxygen" ) )
    {
        return %"ping_loot_oxygentank";
    }
    else if ( issubstr( ent.model, "turret" ) )
    {
        return %"ping_enemy_mountedturret";
    }
    else if ( issubstr( ent.model, "gas_cutter" ) )
    {
        return %"ping_loot_buzzsaw";
    }
    
    return %"ping_enemy_infantry";
}

// Namespace calloutmarkerping
// Params 2, eflags: 0x4
// Checksum 0x733f0ed4, Offset: 0x5b14
// Size: 0x78c
function private function_cf37792ae7575350( var_6675b0888e2dbc2, var_25d80124122c8304 )
{
    if ( !isdefined( var_25d80124122c8304 ) )
    {
        return;
    }
    
    player = self;
    var_d6f8a22c7d24e6b6 = "";
    scriptableinstance = var_25d80124122c8304;
    
    if ( scriptableinstance.type && level.var_1aff81a7080bac1b[ scriptableinstance.type ] )
    {
        return level.var_1aff81a7080bac1b[ scriptableinstance.type ];
    }
    else if ( isdefined( scriptableinstance.type ) && common_item_database::function_9eeb5b816d2c20c0( scriptableinstance.type ) )
    {
        bundlename = common_item::function_33a2c00e46263d99( scriptableinstance );
        
        if ( isdefined( bundlename ) )
        {
            pingvo = getscriptbundlefieldvalue( bundlename, #"pingvo" );
            
            if ( isdefined( pingvo ) )
            {
                return pingvo;
            }
        }
    }
    
    calloutvo = function_402ca439bbef017b( var_6675b0888e2dbc2 );
    var_a088e588c4703d47 = function_c1a045746563b625( var_6675b0888e2dbc2 );
    
    if ( isdefined( calloutvo ) && isdefined( var_a088e588c4703d47 ) )
    {
        return calloutvo;
    }
    else if ( scriptableinstance scriptableisdoor() )
    {
        if ( scriptableinstance scriptabledoorisclosed() )
        {
            return;
        }
        else
        {
            var_d6f8a22c7d24e6b6 = %"ping_location_looted";
        }
    }
    else if ( isdefined( scriptableinstance.customweaponname ) && scriptableinstance.customweaponname != "" )
    {
        var_d6f8a22c7d24e6b6 = %"ping_loot_weapon_custom";
    }
    else if ( isdefined( scriptableinstance.entity ) )
    {
        if ( isdropcrate( scriptableinstance.entity ) )
        {
            if ( scriptableinstance.entity.cratetype == "killstreak" )
            {
                if ( !isdefined( scriptableinstance.entity.team ) || scriptableinstance.entity.team == player.team )
                {
                    var_d6f8a22c7d24e6b6 = %"ping_killstreak_airdrop_generic";
                }
                else
                {
                    var_d6f8a22c7d24e6b6 = %"ping_killstreak_airdrop_generic_hostile";
                }
            }
            else if ( scriptableinstance.entity.cratetype == "battle_royale_cash_crate" )
            {
                var_d6f8a22c7d24e6b6 = %"ping_loot_cash";
            }
            else if ( scriptableinstance.entity.cratetype == "battle_royale_elite_chopper" )
            {
                var_d6f8a22c7d24e6b6 = #"ping_objective_capture_package";
            }
            else if ( !isdefined( scriptableinstance.entity.team ) || scriptableinstance.entity.team == player.team )
            {
                var_d6f8a22c7d24e6b6 = %"ping_fieldupgrade_loadoutdrop";
            }
            else
            {
                var_d6f8a22c7d24e6b6 = %"ping_fieldupgrade_loadoutdrop_hostile";
            }
        }
        else if ( scriptableinstance.entity.isjuggernaut )
        {
            if ( !isdefined( scriptableinstance.entity.team ) || scriptableinstance.entity.team == player.team )
            {
                var_d6f8a22c7d24e6b6 = %"ping_killstreak_juggernaut_box";
            }
            else
            {
                var_d6f8a22c7d24e6b6 = %"ping_killstreak_juggernaut_box_hostile";
            }
        }
        else if ( isplunderextract( var_25d80124122c8304 ) || var_25d80124122c8304.type == "dmz_exfil_site" )
        {
            var_d6f8a22c7d24e6b6 = %"ping_exfil_lz";
        }
        else if ( var_25d80124122c8304.type == "dmz_exfil_site" )
        {
            var_d6f8a22c7d24e6b6 = %"ping_fulton";
        }
        else if ( isdefined( scriptableinstance.entity.model ) && ( scriptableinstance.entity.model == "military_ammo_restock_location" || scriptableinstance.entity.model == "military_ammo_restock_location_solid" || scriptableinstance.entity.model == "military_ammo_restock_location_solid_mp" ) )
        {
            var_d6f8a22c7d24e6b6 = %"ping_ammo_depot";
        }
        else if ( isdefined( scriptableinstance.model ) && ( scriptableinstance.model == "veh9_mil_air_drone_redeploy_relocate" || scriptableinstance.model == "veh9_mil_air_drone_redeploy_relocate_hack" ) )
        {
            var_d6f8a22c7d24e6b6 = %"ping_redeploy_drone";
        }
        else if ( scriptableinstance.entity.vehiclename == "cargo_train" )
        {
            var_d6f8a22c7d24e6b6 = %"ping_vehicle_generic_neutral";
        }
        else if ( scriptableinstance.entity.vehiclename == "veh_jup_nuclear_locomotive" )
        {
            var_d6f8a22c7d24e6b6 = #"ping_vehicle_generic_neutral";
        }
        else if ( scriptableinstance.entity.cameratype == "tacCam" )
        {
            if ( scriptableinstance.entity.team == player.team )
            {
                var_d6f8a22c7d24e6b6 = %"ping_fieldupgrade_taccamera";
            }
            else
            {
                var_d6f8a22c7d24e6b6 = %"ping_fieldupgrade_taccamera_hostile";
            }
        }
        else if ( scriptableinstance.type == "veh9_mil_air_cargo_plane_airdrop_dmz" )
        {
            var_d6f8a22c7d24e6b6 = %"ping_vehicle_generic_neutral";
        }
        else if ( scriptableinstance.entity.var_7d0a5f845212e69e )
        {
            return;
        }
        else
        {
            var_d6f8a22c7d24e6b6 = %"ping_location_go";
        }
    }
    else if ( isdefined( var_25d80124122c8304.type ) && ( var_25d80124122c8304.type == "dmz_gas_station" || var_25d80124122c8304.type == "dmz_gas_station_marine" ) )
    {
        return;
    }
    else if ( utility::issharedfuncdefined( #"pickups", #"hash_4201931139e54d1f" ) && isdefined( scriptableinstance.type ) && [[ utility::getsharedfunc( #"pickups", #"hash_4201931139e54d1f" ) ]]( scriptableinstance.type ) )
    {
        if ( utility::issharedfuncdefined( #"dogtag", #"getdogtagdata" ) )
        {
            dogtagdata = utility::callsharedfunc( #"dogtag", #"getdogtagdata", scriptableinstance.additionaldata.var_80a55ae41f929b49 );
            
            if ( self.team == dogtagdata.victimteam )
            {
                var_d6f8a22c7d24e6b6 = %"ping_rh_dogtags";
            }
            else
            {
                var_d6f8a22c7d24e6b6 = %"ping_loot_generic";
            }
        }
        else
        {
            var_d6f8a22c7d24e6b6 = %"ping_loot_generic";
        }
    }
    else if ( scriptableinstance.type == "map2map_tacmap_location_scriptable" )
    {
        var_d6f8a22c7d24e6b6 = %"ping_location_go";
    }
    else if ( scriptableinstance.isredeploydrone )
    {
        var_d6f8a22c7d24e6b6 = %"ping_location_go";
    }
    else if ( scriptableinstance.type == "scriptable_uav_tower" || scriptableinstance.type == "scriptable_uav_tower_short" )
    {
        var_d6f8a22c7d24e6b6 = %"ping_uavtower_neutral";
    }
    else if ( scriptableinstance.type == "dmz_samsite_icon" )
    {
        var_d6f8a22c7d24e6b6 = %"ping_location_go";
    }
    else if ( scriptableinstance.type == "military_ammo_restock_noent" )
    {
        var_d6f8a22c7d24e6b6 = %"ping_ammo_depot";
    }
    else if ( scriptableinstance.type == "ob_aethernest_cyst_scriptable" )
    {
        var_d6f8a22c7d24e6b6 = #"ping_objective_destroy_generic";
    }
    else if ( isdefined( scriptableinstance.type ) && issubstr( scriptableinstance.type, "ascender" ) )
    {
        var_d6f8a22c7d24e6b6 = %"ping_location_go";
    }
    else
    {
        var_d6f8a22c7d24e6b6 = %"ping_loot_generic";
    }
    
    return var_d6f8a22c7d24e6b6;
}

// Namespace calloutmarkerping
// Params 2
// Checksum 0x3c4c33bc, Offset: 0x62a9
// Size: 0x39
function function_572853cf60de7300( scriptabletype, alias )
{
    if ( !isdefined( level.var_1aff81a7080bac1b ) )
    {
        level.var_1aff81a7080bac1b = [];
    }
    
    level.var_1aff81a7080bac1b[ scriptabletype ] = alias;
}

// Namespace calloutmarkerping
// Params 2, eflags: 0x4
// Checksum 0x631970ae, Offset: 0x62ea
// Size: 0x7c7
function private function_fb5a59465c473c39( ent, player )
{
    if ( !isdefined( ent.streakname ) )
    {
        return;
    }
    
    bundle = killstreak_utility::function_f943c0602acdc2af( ent.streakname );
    
    if ( ent.team == player.team )
    {
        if ( level.gamemodebundle.var_a2838344dfe550ea )
        {
            return #"hash_fe627f96d984fd11";
        }
        
        if ( bundle.var_baead250692b8865 )
        {
            return bundle.var_baead250692b8865;
        }
    }
    else
    {
        if ( isdefined( bundle.var_30341cf01d51741a ) )
        {
            return battlechatter_mp::function_694f04feb7ef7c08( bundle.var_30341cf01d51741a );
        }
        
        if ( bundle.var_cdff6ba074266d47 )
        {
            return bundle.var_cdff6ba074266d47;
        }
    }
    
    switch ( ent.streakname )
    {
        case #"hash_413c38e72fe8b5bf":
            if ( ent.team == player.team )
            {
                return %"ping_killstreak_gunship";
            }
            else
            {
                return %"ping_killstreak_gunship_hostile";
            }
        case #"hash_349713b5ad494dda":
        case #"hash_363a333139801cbd":
            if ( ent.team == player.team )
            {
                return %"ping_killstreak_choppergunner";
            }
            else
            {
                return %"ping_killstreak_choppergunner_hostile";
            }
        case #"hash_568092dc521d2e1d":
        case #"hash_28d0236400e33fd0":
            if ( ent.team == player.team )
            {
                return %"ping_killstreak_cruisemissile";
            }
            else
            {
                return %"ping_killstreak_cruisemissile_hostile";
            }
        case #"hash_b161e185f1b8e117":
            if ( ent.team == player.team )
            {
                return %"ping_killstreak_autodrone";
            }
            else
            {
                return %"ping_killstreak_autodrone_hostile";
            }
        case #"hash_887ad77192b9c4fb":
        case #"hash_ab85bf242018f2e9":
        case #"hash_691f39dddd9116b8":
        case #"hash_20e14e0071e34db":
            if ( ent.team == player.team )
            {
                return %"ping_killstreak_airsupport_generic";
            }
            else
            {
                return %"ping_killstreak_airsupport_generic_hostile";
            }
        case #"hash_cf0ef5bef19a311b":
            if ( ent.team == player.team )
            {
                return %"ping_killstreak_mobilesentry";
            }
            else
            {
                return %"ping_killstreak_mobilesentry_hostile";
            }
        case #"hash_2289ec11d77bce8f":
            if ( ent.team == player.team )
            {
                return %"ping_killstreak_emergencyairdrop";
            }
            else
            {
                return %"ping_killstreak_emergencyairdrop_hostile";
            }
        case #"hash_56979e0566996b2e":
        case #"hash_e477c24ee18bb2f6":
        case #"hash_de9cf1c4a4d2521d":
        case #"hash_4ad475e6e15635bd":
        case #"hash_cd0a0403551fc411":
            if ( ent.team == player.team )
            {
                return %"ping_killstreak_airdrop_generic";
            }
            else
            {
                return %"ping_killstreak_airdrop_generic_hostile";
            }
        case #"hash_4d5aa76e8707f47b":
            if ( ent.team == player.team )
            {
                return %"ping_killstreak_sentrygun";
            }
            else
            {
                return %"ping_killstreak_sentrygun_hostile";
            }
        case #"hash_bf2f9adbd2b41d5":
            if ( ent.team == player.team )
            {
                return %"ping_killstreak_vtol";
            }
            else
            {
                return %"ping_killstreak_vtol_hostile";
            }
        case #"hash_2cb2b7f44f2f6237":
        case #"hash_8c766d6477287bb6":
        case #"hash_b4ac3581c343a029":
        case #"hash_42fd64e842a4c3d7":
        case #"hash_4220be38a5f150b8":
        case #"hash_e6bea339d3cbd3e8":
            if ( ent.team == player.team )
            {
                return %"ping_killstreak_airstrike_generic";
            }
            else
            {
                return %"ping_killstreak_airstrike_generic_hostile";
            }
        case #"hash_e171e5b86ef0a4cc":
            if ( ent.team == player.team )
            {
                return %"ping_killstreak_advuav";
            }
            else
            {
                return %"ping_killstreak_advuav_hostile";
            }
        case #"hash_634b246c3da5c56f":
        case #"hash_e51f2e3d5cdd8ed8":
            if ( ent.team == player.team )
            {
                return %"ping_killstreak_uav";
            }
            else
            {
                return %"ping_killstreak_uav_hostile";
            }
        case #"hash_10e585c25e7e9f60":
        case #"hash_27002778019fb447":
        case #"hash_566a2018a7c11f4a":
            if ( ent.team == player.team )
            {
                return %"ping_killstreak_counteruav";
            }
            else
            {
                return %"ping_killstreak_counteruav_hostile";
            }
        case #"hash_4d35eb58f9d545f0":
            if ( ent.team == player.team )
            {
                return %"ping_killstreak_clustermine";
            }
            else
            {
                return %"ping_killstreak_clustermine_hostile";
            }
        case #"hash_9e36e3bd3a9dd00d":
            if ( ent.team == player.team )
            {
                return %"ping_killstreak_bombdrone";
            }
            else
            {
                return %"ping_killstreak_bombdrone_hostile";
            }
        case #"hash_8ef5b52c9e784884":
        case #"hash_e40585107590f016":
            if ( ent.team == player.team )
            {
                return %"ping_fieldupgrade_recondrone";
            }
            else
            {
                return %"ping_fieldupgrade_recondrone_hostile";
            }
        case #"hash_6362d6aae3e5a62e":
            if ( ent.team == player.team )
            {
                return %"ping_killstreak_drone_swarm";
            }
            else
            {
                return %"ping_killstreak_drone_swarm_hostile";
            }
        case #"hash_19dd9a3a4147e09e":
            if ( ent.team == player.team )
            {
                return %"ping_killstreak_lrad";
            }
            else
            {
                return %"ping_killstreak_lrad_hostile";
            }
        case #"hash_b571a6187bf67f9e":
            if ( ent.team == player.team )
            {
                return %"ping_killstreak_missile_turret";
            }
            else
            {
                return %"ping_killstreak_missile_turret_hostile";
            }
        case #"hash_ab5712e297cd430e":
            if ( ent.team == player.team )
            {
                return %"ping_killstreak_remoteturret";
            }
            else
            {
                return %"ping_killstreak_remoteturret_hostile";
            }
        case #"hash_7a687f6a4d685110":
            if ( ent.team == player.team )
            {
                return %"ping_killstreak_switchblade_drone";
            }
            else
            {
                return %"ping_killstreak_switchblade_drone_hostile";
            }
        case #"hash_59aa7e461fc04a44":
        case #"hash_55af30c2f519570a":
        case #"hash_4d2e080857f4ddbe":
        case #"hash_3188799009d92bfe":
            if ( ent.team == player.team )
            {
                return %"ping_killstreak_generic";
            }
            else
            {
                return %"ping_killstreak_generic_hostile";
            }
        case #"hash_11368ff3af541278":
            if ( ent.team == player.team )
            {
                return %"ping_killstreak_airstrike_generic";
            }
            else
            {
                return %"ping_killstreak_airstrike_generic_hostile";
            }
        default:
            assertmsg( "<dev string:x4a>" + "<dev string:x1a0>" + ent.streakname );
            break;
    }
}

// Namespace calloutmarkerping
// Params 1, eflags: 0x4
// Checksum 0x85f630c3, Offset: 0x6aba
// Size: 0x68b
function private function_d69c38de3f2499cd( pingindex )
{
    player = self;
    
    if ( !isbrgamemode() && game_utility::getgametype() != "ob" )
    {
        return %"ping_location_go";
    }
    
    playerobjectiveindex = player calloutmarkerping_getgscobjectiveindex( pingindex );
    assert( isint( playerobjectiveindex ) );
    
    if ( isdefined( level.questinfo.quests[ "vip" ].instances ) )
    {
        foreach ( teamstruct in level.questinfo.quests[ "vip" ].instances )
        {
            var_bcf4cc501b0f86ee = teamstruct.objectiveiconid;
            
            if ( !isdefined( var_bcf4cc501b0f86ee ) )
            {
                continue;
            }
            
            if ( var_bcf4cc501b0f86ee == playerobjectiveindex )
            {
                return %"ping_enemy_infantry";
            }
        }
    }
    
    if ( isdefined( level.pleaforhelp.plearequests ) )
    {
        foreach ( request in level.pleaforhelp.plearequests )
        {
            if ( request.objid != playerobjectiveindex )
            {
                continue;
            }
            
            return %"ping_request_revive_confirm";
        }
    }
    
    var_67ca9956940b0e25 = objective_geticon( playerobjectiveindex );
    
    if ( isdefined( var_67ca9956940b0e25 ) )
    {
        switch ( var_67ca9956940b0e25 )
        {
            case #"hash_1075324f0436e1a1":
                return %"ping_loadout";
            case #"hash_cee0c70275feca19":
                return %"ping_loot_killstreak_carepackage";
            case #"hash_4cbfef445e35dd14":
                return %"ping_loot_cash";
            case #"hash_4abd0ee7bbd5963a":
                return %"ping_buystation";
            case #"hash_12d67c7796befcfc":
                return %"ping_cache";
            case #"hash_d4a79fe5867b0334":
                return %"ping_contract_initial_generic";
            case #"hash_90ee989288818d54":
                return %"ping_objective_destroy_generic";
            case #"hash_f128412207d3dff":
            case #"hash_ef52726f863e918c":
                return %"ping_objective_defend_generic";
            case #"hash_e72b710c86eed3e4":
                return %"ping_objective_spotted_device";
            case #"hash_c810e4c79ffe58":
                return %"ping_boss_generic";
            case #"hash_512b4048208f0ea9":
                return %"ping_stash";
            case #"hash_52e64b07a8b95f29":
                return %"ping_cargo_lz";
            case #"hash_fa801fd3fbd9ee68":
            case #"hash_fa8021d3fbd9f18e":
            case #"hash_fa8022d3fbd9f321":
            case #"hash_fa8024d3fbd9f647":
                return %"ping_loot_generic";
            case #"hash_a6aad43a264df73e":
                return %"ping_area_denial";
            case #"hash_9a83299fed6cd67c":
            case #"hash_9a832a9fed6cd80f":
            case #"hash_9a832c9fed6cdb35":
                return %"ping_location_go";
            case #"hash_83e85ba1660c3e37":
            case #"hash_9fd5b4d0b29537a3":
            case #"hash_a564203327b04cfa":
                return %"ping_killstreak_generic";
            default:
                break;
        }
    }
    
    var_71c9ca189a11eb61 = undefined;
    
    if ( player function_5c766d1d0140b86( "ui_br_objective_index" ) )
    {
        var_71c9ca189a11eb61 = player getclientomnvar( "ui_br_objective_index" );
    }
    
    if ( isdefined( var_71c9ca189a11eb61 ) && var_71c9ca189a11eb61 != 0 )
    {
        questref = tablelookup( "mp/brmissions.csv", 0, var_71c9ca189a11eb61, 1 );
        queststring = tablelookup( "mp/brmissions.csv", 0, var_71c9ca189a11eb61, 18 );
        var_34ef49eae9d8dacb = %"ping_contract_initial_generic";
        
        if ( queststring )
        {
            assert( isstring( queststring ) );
            
            switch ( queststring )
            {
                case #"hash_96e641d7fe5b1cf1":
                case #"hash_d43a3732d39e4a11":
                case #"hash_de61e484b9734ea1":
                    return %"ping_contract_initial_bounty";
                case #"hash_96815ed47cc355cf":
                    return %"hash_5c9169b641a2dfb1";
                case #"hash_cc7c1c701864c7bf":
                case #"hash_d0eb8b9de6742b83":
                    return %"hash_5c9169b641a2dfb1";
                case #"hash_5c57b61aa79410db":
                    return %"ping_cache";
                case #"hash_d0eb63c46c25ef55":
                    return %"ping_contract_initial_secureintel";
                case #"hash_7b0c576c4a7e4890":
                    return %"ping_contract_initial_mostwanted";
                case #"hash_bf5597954aaed3d7":
                    return %"ping_contract_initial_recon";
                case #"hash_d22bc78737d8a069":
                    if ( isdefined( questref ) && questref == "elite_safecracker" )
                    {
                        return #"ping_objective_capture_generic";
                    }
                    
                    return var_34ef49eae9d8dacb;
                case #"hash_f4a9126c03d3385b":
                    if ( isdefined( questref ) && questref == "dmz_domination" )
                    {
                        return %"ping_uploadstation";
                    }
                    
                    return %"ping_target_area";
                case #"hash_75b6db03edb1e84e":
                    return %"ping_contract_initial_elimination";
                case #"hash_194f31f722d1fa09":
                case #"hash_82ea0e6e4f123b62":
                    return %"ping_contract_initial_trap";
                case #"hash_e0b82e0f064c17d6":
                    if ( var_71c9ca189a11eb61 == 46 )
                    {
                        return %"ping_hostage";
                    }
                    
                    return %"ping_hostage_lz";
                case #"hash_e91729d4ef79ca26":
                    return %"ping_contract_initial_geigersearch";
                case #"hash_37bb23543c319104":
                    return %"ping_elimtarget";
                case #"hash_1e754eb11fa62651":
                case #"hash_9db32d30f2603c35":
                    return %"ping_contract_initial_cargo";
                case #"hash_cf3abe09f0094696":
                    return %"ping_location_go";
                case #"hash_4f0e37558d043245":
                    if ( isdefined( questref ) && questref == "zombienest_eliminate" )
                    {
                        return #"ping_enemy_infantry";
                    }
                    
                    break;
                default:
                    break;
            }
        }
    }
    
    return %"ping_location_go";
}

// Namespace calloutmarkerping
// Params 1, eflags: 0x4
// Checksum 0x87184b34, Offset: 0x714e
// Size: 0x2c7
function private function_9e0228b5d7c1a88a( weaponname )
{
    if ( isdefined( level.br_pickups.var_e2015499439c7b35 ) )
    {
        if ( isdefined( level.br_pickups.var_e2015499439c7b35[ weaponname ] ) )
        {
            return level.br_pickups.var_e2015499439c7b35[ weaponname ];
        }
    }
    
    if ( isdefined( level.br_lootiteminfo[ weaponname ] ) && isdefined( level.br_lootiteminfo[ weaponname ].fullweaponobj ) )
    {
        weaponname = level.br_lootiteminfo[ weaponname ].fullweaponobj.basename;
    }
    
    if ( isdefined( weaponname ) && ( issubstr( weaponname, "iw9_dm_la700" ) || issubstr( weaponname, "iw9_dm_xmike2010" ) ) )
    {
        weaponname = weaponname == "iw9_dm_la700" ? "iw9_sn_la700" : "iw9_sn_xmike2010";
    }
    
    if ( issubstr( weaponname, "_me_riotshield" ) )
    {
        return %"ping_loot_weapon_riotshield";
    }
    
    if ( issubstr( weaponname, "_me_" ) || isendstr( weaponname, "_me" ) )
    {
        return %"ping_loot_weapon_melee";
    }
    
    if ( issubstr( weaponname, "_pi_" ) || isendstr( weaponname, "_pi" ) )
    {
        return %"ping_loot_weapon_pistol";
    }
    
    if ( issubstr( weaponname, "_sh_" ) || isendstr( weaponname, "_sh" ) )
    {
        return %"ping_loot_weapon_shotgun";
    }
    
    if ( issubstr( weaponname, "_sm_" ) || isendstr( weaponname, "_sm" ) )
    {
        return %"ping_loot_weapon_smg";
    }
    
    if ( issubstr( weaponname, "_ar_" ) || isendstr( weaponname, "_ar" ) )
    {
        return %"ping_loot_weapon_assaultrifle";
    }
    
    if ( issubstr( weaponname, "_lm_" ) || isendstr( weaponname, "_lm" ) )
    {
        return %"ping_loot_weapon_lmg";
    }
    
    if ( !issubstr( weaponname, "crossbow" ) && ( issubstr( weaponname, "_dm_" ) || isendstr( weaponname, "_dm" ) ) )
    {
        return %"ping_loot_weapon_dmr";
    }
    
    if ( !issubstr( weaponname, "crossbow" ) && ( issubstr( weaponname, "_sn_" ) || isendstr( weaponname, "_sn" ) ) )
    {
        return %"ping_loot_weapon_sniper";
    }
    
    if ( issubstr( weaponname, "_la_" ) || isendstr( weaponname, "_la" ) )
    {
        return %"ping_loot_weapon_launcher";
    }
    
    if ( issubstr( weaponname, "_br_" ) || isendstr( weaponname, "_br" ) )
    {
        return %"ping_loot_equipment_battlerifle";
    }
    
    return %"ping_loot_generic";
}

// Namespace calloutmarkerping
// Params 1, eflags: 0x4
// Checksum 0x9e1e5d1, Offset: 0x741d
// Size: 0x123
function private function_3646a31d44c6cb4c( pingindex )
{
    player = self;
    var_71c9ca189a11eb61 = undefined;
    
    if ( player function_5c766d1d0140b86( "ui_br_objective_index" ) )
    {
        var_71c9ca189a11eb61 = player getclientomnvar( "ui_br_objective_index" );
    }
    
    if ( isdefined( var_71c9ca189a11eb61 ) && var_71c9ca189a11eb61 != 0 )
    {
        queststring = tablelookup( "mp/brmissions.csv", 0, var_71c9ca189a11eb61, 18 );
        
        if ( queststring )
        {
            assert( isstring( queststring ) );
            
            switch ( queststring )
            {
                case #"hash_f4a9126c03d3385b":
                    return %"ping_uploadstation_confirm";
                case #"hash_e0b82e0f064c17d6":
                    return %"ping_hostage";
                default:
                    return %"ping_response_copy";
            }
        }
    }
    
    playerobjectiveindex = player calloutmarkerping_getgscobjectiveindex( pingindex );
    var_67ca9956940b0e25 = objective_geticon( playerobjectiveindex );
    
    if ( isdefined( var_67ca9956940b0e25 ) )
    {
        switch ( var_67ca9956940b0e25 )
        {
            case #"hash_1075324f0436e1a1":
                return %"ping_loadout_confirm";
            default:
                break;
        }
    }
    
    return %"ping_response_copy";
}

// Namespace calloutmarkerping
// Params 3, eflags: 0x4
// Checksum 0xd955878, Offset: 0x7549
// Size: 0x122
function private function_2b98fcf98aa0a430( pingindex, var_5839667339c20dd2, var_49b59c3e1ea1c6fc )
{
    player = self;
    var_6675b0888e2dbc2 = player function_689a4266a29aac13( pingindex );
    
    if ( isdefined( var_5839667339c20dd2.type ) )
    {
        scriptabletype = var_5839667339c20dd2.type;
    }
    else
    {
        assertmsg( "<dev string:x4a>" + "<dev string:x1d4>" + var_6675b0888e2dbc2 );
        return "";
    }
    
    if ( utility::issharedfuncdefined( #"game", #"hash_2d6603ce4710caa8" ) )
    {
        itembundlename = [[ utility::getsharedfunc( #"game", #"hash_2d6603ce4710caa8" ) ]]( scriptabletype );
        
        if ( isdefined( itembundlename ) )
        {
            itembundle = getscriptbundle( itembundlename );
            
            if ( isdefined( itembundle.var_c048a47fe4e742cd ) )
            {
                return itembundle.var_c048a47fe4e742cd;
            }
        }
    }
    
    voalias = function_85fa008040445d0a( var_6675b0888e2dbc2 );
    assert( isdefined( voalias ), "<dev string:x4a>" + "<dev string:x21e>" + pingindex + "<dev string:x231>" );
    return voalias;
}

// Namespace calloutmarkerping
// Params 2
// Checksum 0x2ca05aea, Offset: 0x7674
// Size: 0x22
function function_a3f0d6526c09f579( var_1a1693d867b8b00b, origin )
{
    return createcallout( var_1a1693d867b8b00b, origin, undefined, undefined, undefined, undefined );
}

// Namespace calloutmarkerping
// Params 1
// Checksum 0xfc7948e8, Offset: 0x769f
// Size: 0x19
function function_81aa43aad6e47820( entnum )
{
    return createcallout( undefined, undefined, entnum, undefined, undefined, undefined );
}

// Namespace calloutmarkerping
// Params 1
// Checksum 0x3ab9488f, Offset: 0x76c1
// Size: 0x19
function function_920a63c06abdefe8( scriptableindex )
{
    return createcallout( undefined, undefined, undefined, scriptableindex, undefined, undefined );
}

// Namespace calloutmarkerping
// Params 2
// Checksum 0xf7f7b0a8, Offset: 0x76e3
// Size: 0x28
function function_5d7b7302e94b97c2( objectiveindex, origin )
{
    return createcallout( function_1bf3a084cfe14025( 6 ), origin, undefined, undefined, objectiveindex, undefined );
}

// Namespace calloutmarkerping
// Params 6
// Checksum 0xe35c1be8, Offset: 0x7714
// Size: 0xe6
function createcallout( var_1a1693d867b8b00b, origin, entnum, scriptableindex, objectiveindex, lootid )
{
    player = self;
    var_d105e16681803e78 = player function_5b559ee032d5a74d( var_1a1693d867b8b00b, origin, entnum, scriptableindex, objectiveindex, lootid );
    
    if ( isdefined( var_d105e16681803e78 ) )
    {
        oldowner = getentbynum( var_d105e16681803e78.var_764a44544adc0986 );
        
        if ( isplayer( oldowner ) )
        {
            predicted_log( "Remove Callout ID Notify ( reallocated ) | pingIndex: " + var_d105e16681803e78.pingindex );
            oldowner callback::callback( #"on_ping_removed", { #pingindex:var_d105e16681803e78.pingindex } );
            oldowner notify( "predictiveCalloutClear_" + var_d105e16681803e78.pingindex );
        }
        
        return var_d105e16681803e78.pingindex;
    }
}

// Namespace calloutmarkerping
// Params 1
// Checksum 0xd77fbdae, Offset: 0x7803
// Size: 0xc7
function function_7c0ee9d4b604e6d6( pingindex )
{
    player = self;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( !player isowner( pingindex ) )
    {
        predicted_log( "Remove Callout ( failed due to owner mismatch ) | pingIndex: " + pingindex );
    }
    else
    {
        predicted_log( "Remove Callout | pingIndex: " + pingindex );
        var_6675b0888e2dbc2 = player function_689a4266a29aac13( pingindex );
        
        if ( function_4838d0aa6e70099f( var_6675b0888e2dbc2 ) )
        {
            player function_ebd71b44b1839e3a( pingindex );
            
            if ( function_312dddfe3b19adcc( var_6675b0888e2dbc2 ) )
            {
                player function_c9183cb1c2e26e82( player.team );
            }
        }
    }
    
    predicted_log( "Remove Callout ID Notify ( removed ) | pingIndex: " + pingindex );
    player callback::callback( #"on_ping_removed", { #pingindex:pingindex } );
    player notify( "predictiveCalloutClear_" + pingindex );
}

// Namespace calloutmarkerping
// Params 5
// Checksum 0xc0a50757, Offset: 0x78d2
// Size: 0x122
function function_3c501da3379eca0a( player, pingindex, endonnotifies, waittillnotifies, waittilltimeout )
{
    entity = self;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    player endon( #"disconnect" );
    player endon( "predictiveCalloutClear_" + pingindex );
    
    if ( isdefined( endonnotifies ) )
    {
        foreach ( endonnotify in endonnotifies )
        {
            entity endon( endonnotify );
        }
    }
    
    predicted_log( "Remove Callout On Notify Or Timeout | pingIndex: " + pingindex );
    
    if ( isdefined( waittilltimeout ) && isdefined( waittillnotifies ) )
    {
        entity utility::waittill_any_in_array_or_timeout( waittillnotifies, waittilltimeout );
    }
    else if ( isdefined( waittilltimeout ) )
    {
        wait waittilltimeout;
    }
    else if ( isdefined( waittillnotifies ) )
    {
        entity utility::waittill_any_in_array( waittillnotifies );
    }
    
    player function_7c0ee9d4b604e6d6( pingindex );
}

// Namespace calloutmarkerping
// Params 3
// Checksum 0x28ed05ac, Offset: 0x79fc
// Size: 0x117
function function_608710c894185549( player, var_f9cbeef79559c7a4, var_a59bd411b381cf9e )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isdefined( player ) )
    {
        var_617b809b7b307e57 = self function_da3bdbe814b866ea( player, var_f9cbeef79559c7a4 ?? 0, var_a59bd411b381cf9e ?? 0 );
    }
    else
    {
        var_617b809b7b307e57 = self function_da3bdbe814b866ea();
    }
    
    if ( isdefined( var_617b809b7b307e57 ) )
    {
        foreach ( var_f3ce059302e00a86 in var_617b809b7b307e57 )
        {
            player = getentbynum( var_f3ce059302e00a86.pingowner );
            
            if ( isplayer( player ) )
            {
                player callback::callback( #"on_ping_removed", { #pingindex:var_f3ce059302e00a86.pingindex } );
                player notify( "predictiveCalloutClear_" + var_f3ce059302e00a86.pingindex );
            }
        }
    }
}

// Namespace calloutmarkerping
// Params 1
// Checksum 0xd6c1e246, Offset: 0x7b1b
// Size: 0xe9
function function_73084f64fa34a5a8( objid )
{
    var_617b809b7b307e57 = function_4fa2e841f13f049b( objid );
    
    if ( isdefined( var_617b809b7b307e57 ) )
    {
        foreach ( var_f3ce059302e00a86 in var_617b809b7b307e57 )
        {
            player = getentbynum( var_f3ce059302e00a86.pingowner );
            
            if ( isplayer( player ) )
            {
                player callback::callback( #"on_ping_removed", { #pingindex:var_f3ce059302e00a86.pingindex } );
                player notify( "predictiveCalloutClear_" + var_f3ce059302e00a86.pingindex );
            }
        }
    }
}

// Namespace calloutmarkerping
// Params 2, eflags: 0x4
// Checksum 0xb76f3284, Offset: 0x7c0c
// Size: 0xa4
function private function_8a4d6dcfa97e09b9( pingindex, gscobjectiveid )
{
    assert( isplayer( self ), "<dev string:x4a>" + "<dev string:x256>" );
    self endon( #"disconnect" );
    self endon( "predictiveCalloutClear_" + pingindex );
    
    while ( true )
    {
        level waittill( #"objective_statechanged", var_e293588b3799f980 );
        
        if ( function_8ce0bcb0b252dd8c( self, var_e293588b3799f980 ) && isdefined( var_e293588b3799f980 ) && var_e293588b3799f980 == gscobjectiveid )
        {
            predicted_log( "Objective started progress | pingIndex: " + pingindex + " | gscObjID: " + gscobjectiveid );
            break;
        }
    }
    
    function_7c0ee9d4b604e6d6( pingindex );
}

// Namespace calloutmarkerping
// Params 2, eflags: 0x4
// Checksum 0xa39f57d8, Offset: 0x7cb8
// Size: 0xb6
function private function_cc9f870e186699b2( pingindex, objective )
{
    assert( isplayer( self ), "<dev string:x4a>" + "<dev string:x291>" );
    self endon( #"disconnect" );
    self endon( "predictiveCalloutClear_" + pingindex );
    
    while ( true )
    {
        results = level utility::waittill_any_return_params( "Objective_Delete", "Objective2_Removed" );
        assert( results.size > 0 );
        deletedobjective = results[ 0 ];
        
        if ( deletedobjective == objective )
        {
            predicted_log( results[ "message" ] + " | pingIndex: " + pingindex + " | objective: " + objective );
            break;
        }
    }
    
    function_7c0ee9d4b604e6d6( pingindex );
}

// Namespace calloutmarkerping
// Params 2, eflags: 0x4
// Checksum 0x9b2842bc, Offset: 0x7d76
// Size: 0x1fd
function private function_cf0846e552a84a6d( pingindex, ent )
{
    assert( isplayer( self ), "<dev string:x4a>" + "<dev string:x2c6>" );
    self endon( #"disconnect" );
    self endon( "predictiveCalloutClear_" + pingindex );
    predicted_log( "Watch Entity Death or Enemy Disconnect | pingIndex: " + pingindex );
    
    if ( !isdefined( ent ) )
    {
        assertmsg( "<dev string:x4a>" + "<dev string:x30e>" );
    }
    
    if ( !isent( ent ) )
    {
        ent utility::waittill_any( "death", "pickup", "explode" );
        return;
    }
    
    if ( isplayer( ent ) )
    {
        var_6675b0888e2dbc2 = self function_689a4266a29aac13( pingindex );
        
        if ( var_6675b0888e2dbc2 == function_1bf3a084cfe14025( 16 ) )
        {
            ent utility::waittill_any_return( "death", "disconnect", "meatshield_victim_stop" );
            function_7c0ee9d4b604e6d6( pingindex );
        }
        else if ( var_6675b0888e2dbc2 == function_1bf3a084cfe14025( 15 ) )
        {
            ent utility::waittill_any_return( "death", "disconnect", "last_stand_exit" );
            function_7c0ee9d4b604e6d6( pingindex );
        }
        else
        {
            val = ent utility::waittill_any_return( "death", "disconnect" );
            
            if ( isdefined( level.gamemodebundle ) && !level.gamemodebundle.var_f4e48b424f63dbea || val == "disconnect" )
            {
                function_7c0ee9d4b604e6d6( pingindex );
            }
            else
            {
                thread function_40df08cd2d68aaf2( pingindex, ent, 1 );
            }
        }
        
        return;
    }
    
    if ( isagent( ent ) )
    {
        ent waittill( #"death" );
        
        if ( isdefined( level.gamemodebundle ) && !level.gamemodebundle.var_f4e48b424f63dbea )
        {
            function_7c0ee9d4b604e6d6( pingindex );
        }
        else
        {
            thread function_40df08cd2d68aaf2( pingindex, ent, 1 );
        }
        
        return;
    }
    
    if ( !ent.isdestroyed )
    {
        ent utility::waittill_any( "death", "pickup", "explode" );
    }
    
    function_7c0ee9d4b604e6d6( pingindex );
}

// Namespace calloutmarkerping
// Params 2, eflags: 0x4
// Checksum 0x4e0d6ead, Offset: 0x7f7b
// Size: 0x157
function private function_9fd0d821f6f15ec5( scriptable, pingindex )
{
    self endon( #"disconnect" );
    self endon( "predictiveCalloutClear_" + pingindex );
    volumes = scriptable.var_42ad2e0f6b95770c;
    
    foreach ( volume in volumes )
    {
        if ( ispointinvolume( self.origin, volume ) )
        {
            return;
        }
    }
    
    while ( true )
    {
        if ( !self || !self.origin )
        {
            return;
        }
        
        foreach ( volume in volumes )
        {
            if ( ispointinvolume( self.origin, volume ) )
            {
                function_7c0ee9d4b604e6d6( pingindex );
                return;
            }
        }
        
        wait 1;
    }
}

// Namespace calloutmarkerping
// Params 1, eflags: 0x4
// Checksum 0x1fbffbc3, Offset: 0x80da
// Size: 0x105
function private function_5caad5f73686f102( pingindex )
{
    self endon( #"disconnect" );
    self endon( "predictiveCalloutClear_" + pingindex );
    pingorigin = self calloutmarkerping_getorigin( pingindex );
    
    if ( !isdefined( pingorigin ) )
    {
        return;
    }
    
    var_c3967be0166f0514 = distance( self.origin, pingorigin );
    wait level.gamemodebundle.var_fc7a5012513e5ea4 ?? 30;
    
    while ( true )
    {
        if ( !self || !self.origin )
        {
            return;
        }
        
        pingorigin = self calloutmarkerping_getorigin( pingindex );
        
        if ( !isdefined( pingorigin ) )
        {
            return;
        }
        
        newdistance = distance( self.origin, pingorigin );
        
        if ( newdistance - var_c3967be0166f0514 > ( level.gamemodebundle.var_c70e0a3d16c70890 ?? 3000 ) )
        {
            break;
        }
        
        var_c3967be0166f0514 = min( var_c3967be0166f0514, newdistance );
        wait level.gamemodebundle.var_ad30d3a72d6235de ?? 10;
    }
    
    function_7c0ee9d4b604e6d6( pingindex );
}

// Namespace calloutmarkerping
// Params 1, eflags: 0x4
// Checksum 0x509d1d7d, Offset: 0x81e7
// Size: 0xf4
function private function_22590e3bb8fc520f( pingindex )
{
    player = self;
    assert( isplayer( player ), "<dev string:x4a>" + "<dev string:x36e>" );
    player endon( #"disconnect" );
    player endon( "predictiveCalloutClear_" + pingindex );
    var_6675b0888e2dbc2 = player function_689a4266a29aac13( pingindex );
    
    if ( var_6675b0888e2dbc2 == function_1bf3a084cfe14025( 13 ) )
    {
        if ( getdvarint( @"hash_6f618729986d661", 1 ) && utility::ismp() && utility::issharedfuncdefined( #"ping", #"calloutmarkerping_watchitemtakenfromcontainer" ) )
        {
            predicted_log( "Watch For Container Item Taken | pingIndex: " + pingindex );
            lootid = player function_d3e0d9364e4846b8( pingindex );
            [[ utility::getsharedfunc( #"ping", #"calloutmarkerping_watchitemtakenfromcontainer" ) ]]( player, player.var_50f741a14f09a6, lootid );
            player function_7c0ee9d4b604e6d6( pingindex );
        }
    }
}

// Namespace calloutmarkerping
// Params 1, eflags: 0x4
// Checksum 0xccbc79c0, Offset: 0x82e3
// Size: 0x5b
function private watchplayerdeathordisconnect( pingindex )
{
    player = self;
    assert( isplayer( player ), "<dev string:x4a>" + "<dev string:x36e>" );
    player endon( "predictiveCalloutClear_" + pingindex );
    predicted_log( "Watch Player Death or Disconnect | pingIndex: " + pingindex );
    player waittill( #"death_or_disconnect" );
}

// Namespace calloutmarkerping
// Params 4, eflags: 0x4
// Checksum 0x9be2be90, Offset: 0x8346
// Size: 0x142
function private function_e71b2929741ec776( pingindex, pingduration, pingowner, calloutentity )
{
    assert( pingowner isowner( pingindex ), "<dev string:x4a>" + "<dev string:x3ac>" );
    level endon( #"game_ended" );
    pingowner endon( #"disconnect" );
    pingowner endon( "predictiveCalloutClear_" + pingindex );
    var_6675b0888e2dbc2 = pingowner function_689a4266a29aac13( pingindex );
    
    if ( !function_b3c77a671d251a32( pingowner, var_6675b0888e2dbc2, calloutentity ) )
    {
        return;
    }
    
    squad = teams::getsquadmates( pingowner.team, pingowner.sessionsquadid );
    
    foreach ( teammate in squad )
    {
        if ( teammate.customPingDurationEnabled && teammate.var_6793010c02e4ac69 != pingduration )
        {
            thread function_75fc53e05e9bacf9( pingindex, pingowner, teammate );
        }
    }
}

// Namespace calloutmarkerping
// Params 3, eflags: 0x4
// Checksum 0xa3f636c0, Offset: 0x8490
// Size: 0x91
function private function_75fc53e05e9bacf9( pingindex, pingowner, player )
{
    assert( isdefined( pingowner ), "<dev string:x4a>" + "<dev string:x3fd>" );
    assert( isdefined( player ), "<dev string:x4a>" + "<dev string:x44d>" );
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    pingowner endon( #"disconnect" );
    pingowner endon( "predictiveCalloutClear_" + pingindex );
    wait player.var_6793010c02e4ac69;
    pingowner calloutmarkerping_hide( pingindex, player );
}

// Namespace calloutmarkerping
// Params 1, eflags: 0x4
// Checksum 0x345ef4c, Offset: 0x8529
// Size: 0x6e
function private function_5eb1d042d1816e5( pingindex )
{
    player = self;
    assert( isplayer( self ), "<dev string:x4a>" + "<dev string:x4aa>" );
    self endon( #"disconnect" );
    self endon( "predictiveCalloutClear_" + pingindex );
    predicted_log( "Watch Player Enter Spectate | pingIndex: " + pingindex );
    player waittill( #"br_spectatorInitialized" );
    function_7c0ee9d4b604e6d6( pingindex );
}

// Namespace calloutmarkerping
// Params 2, eflags: 0x4
// Checksum 0x309d9961, Offset: 0x859f
// Size: 0x19d
function private function_29ccf2e3d1394014( pingindex, scriptableinstance )
{
    assert( isplayer( self ), "<dev string:x4a>" + "<dev string:x4e4>" );
    self endon( #"disconnect" );
    self endon( "predictiveCalloutClear_" + pingindex );
    predicted_log( "Watch Scriptable Death | pingIndex: " + pingindex );
    
    if ( !isdefined( scriptableinstance ) )
    {
        assertmsg( "<dev string:x4a>" + "<dev string:x51a>" );
    }
    else if ( scriptableinstance.type == "equip_fulton_mp" )
    {
        ent = scriptableinstance.entity;
        
        if ( !isdefined( ent ) )
        {
            assertmsg( "<dev string:x4a>" + "<dev string:x57d>" );
            return;
        }
        
        ent utility::waittill_any( "death", "fulton_takeoff" );
    }
    else
    {
        var_f5e6eb6864d9f8b9 = utility::function_e153375527829ec3( scriptableinstance.origin, "undefined", "CalloutMarkerPing: " + ": scriptableInstance.entity.script_noteworthy is undefined" );
        
        if ( isdefined( scriptableinstance.entity ) && isdefined( scriptableinstance.entity.script_noteworthy ) )
        {
            forced_kill_callout_id = scriptableinstance.entity.script_noteworthy;
        }
        else
        {
            forced_kill_callout_id = var_f5e6eb6864d9f8b9;
        }
        
        level utility::waittill_any( "lootcache_opened_kill_callout" + var_f5e6eb6864d9f8b9, "dropbag_kill_callout_" + var_f5e6eb6864d9f8b9, "tablethide_kill_callout_" + var_f5e6eb6864d9f8b9, "carriable_kill_callout_" + var_f5e6eb6864d9f8b9, "buystation_kill_callout_" + var_f5e6eb6864d9f8b9, "redeploy_drone_kill_callout_" + var_f5e6eb6864d9f8b9, "forced_kill_callout_" + forced_kill_callout_id );
    }
    
    predicted_log( "Watch scriptable death ( removed ) | pingIndex: " + pingindex );
    function_7c0ee9d4b604e6d6( pingindex );
}

// Namespace calloutmarkerping
// Params 2, eflags: 0x4
// Checksum 0x67b352d, Offset: 0x8744
// Size: 0x133
function private function_f6f35d6a067ae17d( pingindex, ent )
{
    if ( !isent( ent ) || !isdefined( level.calloutmarkerping.var_67d542069cffe312 ) )
    {
        return;
    }
    
    player = self;
    assert( isplayer( player ), "<dev string:x4a>" + "<dev string:x5b7>" );
    
    if ( !level.teambased )
    {
        outline = outline::outlineenableforplayer( ent, player, level.calloutmarkerping.var_67d542069cffe312, "perk" );
    }
    else if ( squad_utility::shouldmodesetsquads() )
    {
        outline = outline::outlineenableforsquad( ent, player.team, player.sessionsquadid, level.calloutmarkerping.var_67d542069cffe312, "perk" );
    }
    else
    {
        outline = outline::outlineenableforteam( ent, player.team, level.calloutmarkerping.var_67d542069cffe312, "perk" );
    }
    
    player utility::waittill_any( "disconnect", "predictiveCalloutResetTimeout_" + pingindex, "predictiveCalloutClear_" + pingindex );
    outline::outlinedisable( outline, ent );
}

// Namespace calloutmarkerping
// Params 2, eflags: 0x4
// Checksum 0xa13d3c0, Offset: 0x887f
// Size: 0xa2
function private function_56ba20e4a3880f55( pingindex, plunderrepository )
{
    player = self;
    plunderrepository.ispinged = 1;
    br_plunder::plunder_updateanchoredwidgetforplayers( plunderrepository, teams::getfriendlyplayers( plunderrepository.team ) );
    plunderrepository thread function_3c501da3379eca0a( player, pingindex, undefined, [ "plunder_repository_used" ], undefined );
    player utility::waittill_any( "disconnect", "predictiveCalloutClear_" + pingindex );
    
    if ( isdefined( plunderrepository ) )
    {
        plunderrepository.ispinged = undefined;
        br_plunder::plunder_updateanchoredwidgetforplayers( plunderrepository, teams::getfriendlyplayers( plunderrepository.team ) );
    }
}

// Namespace calloutmarkerping
// Params 1
// Checksum 0x5c10aee9, Offset: 0x8929
// Size: 0x1d
function onplayerdisconnect( player )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player function_5a33bcee47519dd6();
}

// Namespace calloutmarkerping
// Params 0
// Checksum 0xfbaecab3, Offset: 0x894e
// Size: 0x50
function function_5a33bcee47519dd6()
{
    player = self;
    
    if ( isdefined( player ) )
    {
        for ( pingindex = 0; pingindex < 10 ; pingindex++ )
        {
            isowner = player isowner( pingindex );
            
            if ( isowner )
            {
                player function_7c0ee9d4b604e6d6( pingindex );
            }
        }
    }
}

// Namespace calloutmarkerping
// Params 0, eflags: 0x4
// Checksum 0xda162f11, Offset: 0x89a6
// Size: 0x7b
function private function_6600f789bf67d116()
{
    player = self;
    
    if ( isdefined( player ) )
    {
        assert( utility::issharedfuncdefined( #"game", #"getsquadmates" ) );
        playersquad = [[ utility::getsharedfunc( #"game", #"getsquadmates" ) ]]( player.team, player.sessionsquadid, 0 );
        player function_ea6c1cfc8cd997d0( player, playersquad );
    }
}

// Namespace calloutmarkerping
// Params 1
// Checksum 0x801811a1, Offset: 0x8a29
// Size: 0xa3
function function_e2222b6148ff1148( var_161ebf5f1f5d2368 )
{
    var_22ccb27faf250166 = 0;
    
    foreach ( player in level.players )
    {
        player function_5a33bcee47519dd6();
        
        if ( var_161ebf5f1f5d2368 )
        {
            var_22ccb27faf250166++;
            
            if ( var_22ccb27faf250166 % 10 == 0 )
            {
                waitframe();
            }
        }
    }
}

// Namespace calloutmarkerping
// Params 1, eflags: 0x4
// Checksum 0x9cf314e7, Offset: 0x8ad4
// Size: 0x52, Type: bool
function private function_332348019c1847cf( var_8ab57faf0a8b11f9 )
{
    player = self;
    assert( isdefined( player.calloutmarkerpingvohandlerpool ) );
    assert( isstring( var_8ab57faf0a8b11f9 ) );
    
    if ( !isdefined( player.calloutmarkerpingvohandlerpool[ var_8ab57faf0a8b11f9 ] ) )
    {
        return false;
    }
    
    return true;
}

// Namespace calloutmarkerping
// Params 3, eflags: 0x4
// Checksum 0xec960c69, Offset: 0x8b2f
// Size: 0xe8, Type: bool
function private function_a9288aca7c7d1d9b( currtime, var_8ab57faf0a8b11f9, var_8fc4a78287456db9 )
{
    player = self;
    assert( isdefined( player.calloutmarkerpingvohandlerpool ) );
    assert( isdefined( currtime ) );
    assert( isstring( var_8ab57faf0a8b11f9 ) );
    assert( isdefined( var_8fc4a78287456db9 ) );
    var_416395e8e5bf40cf = player.calloutmarkerpingvohandlerpool.size;
    
    if ( var_416395e8e5bf40cf > 10 )
    {
        return false;
    }
    
    sounddebouncelength = var_8fc4a78287456db9 + 500;
    var_7408fac87099eb8 = sounddebouncelength + currtime;
    assert( var_7408fac87099eb8 >= currtime );
    var_3e5f04ccd8254c40 = spawnstruct();
    var_3e5f04ccd8254c40.sounddebouncetimestamp = var_7408fac87099eb8;
    var_3e5f04ccd8254c40.cancelled = 0;
    player.calloutmarkerpingvohandlerpool[ var_8ab57faf0a8b11f9 ] = var_3e5f04ccd8254c40;
    return true;
}

// Namespace calloutmarkerping
// Params 3, eflags: 0x4
// Checksum 0xec90d14e, Offset: 0x8c20
// Size: 0x1b5
function private function_80318e181679da87( var_6675b0888e2dbc2, voalias, var_8fc4a78287456db9 )
{
    player = self;
    
    if ( !isplayer( player ) )
    {
        return 0;
    }
    
    if ( level.disablepingvo )
    {
        return 0;
    }
    
    if ( player.disablepingvo || !level.calloutmarkerping.var_46e3e5c01e080e76 )
    {
        return 0;
    }
    
    currtime = gettime();
    var_8ab57faf0a8b11f9 = "pingAsset" + ( var_6675b0888e2dbc2 ?? "Default" );
    assert( isstring( var_8ab57faf0a8b11f9 ) );
    var_5e6e3a93411ab516 = player function_332348019c1847cf( var_8ab57faf0a8b11f9 );
    
    if ( var_5e6e3a93411ab516 )
    {
        sounddebouncetimestamp = player.calloutmarkerpingvohandlerpool[ var_8ab57faf0a8b11f9 ].sounddebouncetimestamp;
        assert( isdefined( sounddebouncetimestamp ) );
        
        if ( currtime >= sounddebouncetimestamp )
        {
            var_3003417a84baf3b7 = player function_a9288aca7c7d1d9b( currtime, var_8ab57faf0a8b11f9, var_8fc4a78287456db9 );
            return istrue( var_3003417a84baf3b7 );
        }
        
        if ( ( voalias === #"ping_response_cancel" || voalias === %"ping_response_cancel" ) && player.calloutmarkerpingvohandlerpool[ var_8ab57faf0a8b11f9 ].cancelled == 0 )
        {
            player.calloutmarkerpingvohandlerpool[ var_8ab57faf0a8b11f9 ].cancelled = 1;
            return 1;
        }
        
        return 0;
    }
    
    if ( function_a9288aca7c7d1d9b( currtime, var_8ab57faf0a8b11f9, var_8fc4a78287456db9 ) )
    {
        if ( voalias === #"ping_response_cancel" || voalias === %"ping_response_cancel" )
        {
            player.calloutmarkerpingvohandlerpool[ var_8ab57faf0a8b11f9 ].cancelled = 1;
        }
        
        return 1;
    }
    
    return 0;
}

// Namespace calloutmarkerping
// Params 0, eflags: 0x4
// Checksum 0x779adf3c, Offset: 0x8ddd
// Size: 0x13f
function private function_15b4a8021dd45caf()
{
    level endon( #"game_ended" );
    assert( -1 );
    
    while ( true )
    {
        wait 10;
        currenttime = gettime();
        
        for ( currentplayerindex = 0; currentplayerindex < level.players.size ; currentplayerindex++ )
        {
            player = level.players[ currentplayerindex ];
            
            if ( !( isdefined( player ) && isdefined( player.calloutmarkerpingvohandlerpool ) ) )
            {
                continue;
            }
            
            foreach ( key, valuestruct in player.calloutmarkerpingvohandlerpool )
            {
                assert( isstring( key ) );
                assert( isdefined( valuestruct ) );
                assert( isdefined( valuestruct.sounddebouncetimestamp ) );
                
                if ( currenttime > valuestruct.sounddebouncetimestamp )
                {
                    player.calloutmarkerpingvohandlerpool[ key ] = undefined;
                }
            }
        }
    }
}

// Namespace calloutmarkerping
// Params 3, eflags: 0x4
// Checksum 0x36717abf, Offset: 0x8f24
// Size: 0x2cb
function private playteamsoundfx( alias, pingindex, var_de5624f4f93dc8f5 )
{
    player = self;
    
    if ( !isplayer( player ) || !isdefined( alias ) )
    {
        return;
    }
    
    if ( !var_de5624f4f93dc8f5 && !soundexists( alias ) )
    {
        assertmsg( "<dev string:x4a>" + "<dev string:x5f4>" + alias );
    }
    
    pingent = undefined;
    pingorigin = undefined;
    
    if ( isdefined( pingindex ) )
    {
        pingent = player calloutmarkerping_getent( pingindex );
        pingorigin = player calloutmarkerping_getorigin( pingindex );
    }
    
    assert( utility::issharedfuncdefined( #"game", #"getsquadmates" ) );
    playersquad = [[ utility::getsharedfunc( #"game", #"getsquadmates" ) ]]( player.team, player.sessionsquadid, 1 );
    var_3a8bc18ac294bab5 = [];
    
    foreach ( teammate in playersquad )
    {
        if ( player.gulagarena && teammate.gulagarena || !player.gulagarena && !teammate.gulagarena || player == teammate )
        {
            var_3a8bc18ac294bab5[ var_3a8bc18ac294bab5.size ] = teammate;
        }
    }
    
    if ( var_de5624f4f93dc8f5 )
    {
        conversationstart( alias, player, var_3a8bc18ac294bab5 );
        return;
    }
    
    foreach ( teammate in var_3a8bc18ac294bab5 )
    {
        if ( player isspectatingplayer() )
        {
            var_c2115836b33512e6 = teammate;
        }
        else if ( isdefined( pingent ) )
        {
            var_c2115836b33512e6 = spawn( "script_origin", pingent.origin );
            var_c2115836b33512e6.targetname = "calloutMarkerPing_PlayTeamSoundFX";
            var_c2115836b33512e6.istempsfxent = 1;
        }
        else if ( isdefined( pingorigin ) )
        {
            var_c2115836b33512e6 = spawn( "script_origin", pingorigin );
            var_c2115836b33512e6.targetname = "calloutMarkerPing_PlayTeamSoundFX";
            var_c2115836b33512e6.istempsfxent = 1;
        }
        else
        {
            var_c2115836b33512e6 = player;
        }
        
        var_c2115836b33512e6 playsoundtoplayer( alias, teammate );
        
        if ( isdefined( var_c2115836b33512e6.istempsfxent ) )
        {
            var_c2115836b33512e6 delete();
        }
    }
}

// Namespace calloutmarkerping
// Params 3, eflags: 0x4
// Checksum 0x6e6628d3, Offset: 0x91f7
// Size: 0x1aa
function private play( voalias, var_6675b0888e2dbc2, targetent )
{
    voowner = self;
    
    if ( !isplayer( voowner ) )
    {
        return;
    }
    
    if ( !isdefined( voalias ) || isxhash( voalias ) || voalias === %"" || voalias === "" || !isdefined( function_43b5ed5a14a56573( #"hash_acb759f30fd016ec", voalias ) ) )
    {
        assertmsg( "<dev string:x4a>" + "<dev string:x619>" + ( var_6675b0888e2dbc2 ?? "<dev string:x64f>" ) + "<dev string:x659>" + ( isdefined( voalias ) ? getxhashsourcename( voalias ) : "<dev string:x64f>" ) );
        return;
    }
    
    var_8c2afede4c2ab247 = 2000;
    canplayvo = voowner function_80318e181679da87( var_6675b0888e2dbc2, voalias, var_8c2afede4c2ab247 );
    
    if ( canplayvo )
    {
        logprint( "calloutmarkerping::play - PlaySoundEvent()" );
        logprint( "self         = " + voowner.name );
        logprint( "sessionstate = " + voowner.sessionstate );
        logprint( "targetEnt    = " + isdefined( targetent ) );
        
        /#
            logprint( "<dev string:x669>" + getxhashsourcename( voalias ) );
        #/
        
        if ( isdefined( targetent ) )
        {
            logprint( "tEntclassname = " + targetent.classname );
            logprint( "tEntOrigin    = " + targetent.origin );
            
            if ( isent( targetent ) && isplayer( targetent ) )
            {
                logprint( "tEntSessionstate = " + targetent.sessionstate );
            }
        }
        
        if ( isent( targetent ) )
        {
            voowner playsoundevent( voalias, targetent );
            return;
        }
        
        voowner playsoundevent( voalias );
    }
}

// Namespace calloutmarkerping
// Params 1, eflags: 0x4
// Checksum 0x690f18ab, Offset: 0x93a9
// Size: 0x1a7
function private navigationcancelproximity( pingindex )
{
    self endon( #"disconnect" );
    self endon( "predictiveCalloutClear_" + pingindex );
    self notify( #"hash_30725d54809b4233" );
    self endon( #"hash_30725d54809b4233" );
    var_fcad0850ce2558a2 = self calloutmarkerping_getorigin( pingindex );
    
    while ( true )
    {
        assert( isdefined( self ) && isdefined( self.origin ) && isdefined( var_fcad0850ce2558a2 ) );
        wait level.calloutmarkerping.var_a13bd047242d1632;
        
        if ( level.calloutmarkerping.var_5ab46aa76d3b8fae )
        {
            distancesq = level.calloutmarkerping.var_2b6fe1fe666bb60d;
            playersquad = teams::getfriendlyplayers( self.team, 1 );
            
            foreach ( teammate in playersquad )
            {
                teammatedistancesq = distancesquared( teammate.origin, var_fcad0850ce2558a2 );
                
                if ( teammatedistancesq < distancesq )
                {
                    distancesq = teammatedistancesq;
                }
            }
        }
        else
        {
            distancesq = distancesquared( self.origin, var_fcad0850ce2558a2 );
        }
        
        if ( distancesq < level.calloutmarkerping.var_2b6fe1fe666bb60d )
        {
            playteamsoundfx( "uin_ping_cancel", pingindex );
            function_7c0ee9d4b604e6d6( pingindex );
            return;
        }
    }
}

// Namespace calloutmarkerping
// Params 3, eflags: 0x4
// Checksum 0x49bdd6b3, Offset: 0x9558
// Size: 0x89
function private function_663cea5889e99d33( pingindex, var_6675b0888e2dbc2, var_49b59c3e1ea1c6fc )
{
    player = self;
    player playteamsoundfx( "uin_ping_cancel", pingindex );
    wait level.calloutmarkerping.var_99f5e69420e0dc29;
    
    if ( isdefined( player ) )
    {
        if ( isplayer( var_49b59c3e1ea1c6fc ) )
        {
            var_49b59c3e1ea1c6fc play( %"ping_response_cancel", var_6675b0888e2dbc2 );
            return;
        }
        
        player play( %"ping_response_cancel", var_6675b0888e2dbc2 );
    }
}

// Namespace calloutmarkerping
// Params 2
// Checksum 0x7d5c591f, Offset: 0x95e9
// Size: 0x40
function function_28eae04dcb53cf6b( pingindex, var_49b59c3e1ea1c6fc )
{
    pingowner = self;
    var_6675b0888e2dbc2 = pingowner function_689a4266a29aac13( pingindex );
    pingowner function_663cea5889e99d33( pingindex, var_6675b0888e2dbc2, var_49b59c3e1ea1c6fc );
}

// Namespace calloutmarkerping
// Params 2, eflags: 0xc
// Checksum 0x479882c6, Offset: 0x9631
// Size: 0x1d4
function private function_d10c13a769210655( pingindex, var_49b59c3e1ea1c6fc )
{
    self notify( #"hash_d740197011fec0fa" );
    self endon( #"hash_d740197011fec0fa" );
    pingowner = self;
    var_6675b0888e2dbc2 = pingowner function_689a4266a29aac13( pingindex );
    voalias = undefined;
    
    if ( function_4c1b7cae739d9840( var_6675b0888e2dbc2 ) )
    {
        var_25d80124122c8304 = pingowner calloutmarkerping_getent( pingindex );
        voalias = pingowner function_2b98fcf98aa0a430( pingindex, var_25d80124122c8304, var_49b59c3e1ea1c6fc );
    }
    else if ( function_4095a4f8e53eb368( var_6675b0888e2dbc2 ) )
    {
        ent = pingowner calloutmarkerping_getent( pingindex );
        
        if ( isent( ent ) )
        {
            if ( ent.subcategory == "elimTarget" )
            {
                voalias = %"ping_elimtarget_confirm";
            }
            else if ( isenemy( ent, pingowner ) )
            {
                voalias = %"ping_enemy_confirm";
            }
            else if ( issubstr( ent.model, "oxygen" ) )
            {
                voalias = %"ping_loot_confirm_oxygentank";
            }
            else if ( issubstr( ent.model, "gas_cutter" ) )
            {
                voalias = %"ping_loot_confirm_buzzsaw";
            }
            else if ( ent.var_24dfe30364488f30 )
            {
                voalias = %"ping_exfil_heli_confirm";
            }
        }
    }
    else if ( function_d929a855518b925a( var_6675b0888e2dbc2 ) )
    {
        if ( isbrgamemode() && isdefined( pingowner.br_infil_type ) )
        {
            voalias = %"ping_location_landing_confirm";
        }
    }
    else if ( var_6675b0888e2dbc2 == function_1bf3a084cfe14025( 6 ) )
    {
        voalias = pingowner function_3646a31d44c6cb4c( pingindex );
    }
    
    if ( !isdefined( voalias ) )
    {
        voalias = function_85fa008040445d0a( var_6675b0888e2dbc2 );
    }
    
    wait level.calloutmarkerping.var_a6b600bf191f7c69;
    
    if ( isplayer( var_49b59c3e1ea1c6fc ) )
    {
        var_49b59c3e1ea1c6fc play( voalias, var_6675b0888e2dbc2 );
        return;
    }
    
    if ( isdefined( pingowner ) )
    {
        pingowner play( voalias, var_6675b0888e2dbc2 );
    }
}

// Namespace calloutmarkerping
// Params 1, eflags: 0xc
// Checksum 0x7054660e, Offset: 0x980d
// Size: 0x6e
function private function_498993d2ef305f85( pingindex )
{
    self notify( #"hash_e4063f20287a6664" );
    self endon( #"hash_e4063f20287a6664" );
    player = self;
    player endon( #"hash_2f4aa91016243eda" );
    player endon( "predictiveCalloutClear_" + pingindex );
    wait level.calloutmarkerping.var_1b35316c6e7faf23;
    
    if ( isdefined( player ) )
    {
        player function_df7a1fc92c2b5b29( pingindex );
    }
}

// Namespace calloutmarkerping
// Params 2, eflags: 0x4
// Checksum 0x88634675, Offset: 0x9883
// Size: 0x1e6
function private function_7ed535eadcb02974( pingindex, calloutvehicleentity )
{
    self endon( #"disconnect" );
    self endon( "predictiveCalloutClear_" + pingindex );
    assert( isplayer( self ) );
    assert( isent( calloutvehicleentity ) && calloutvehicleentity vehicle::is_vehicle() );
    var_5978e11d48261aa4 = calloutvehicleentity getentitynumber();
    var_c10b7272d2bcc5c = "forced_kill_callout_" + var_5978e11d48261aa4;
    tick = 0.25;
    var_86263f9c4c75933d = 0;
    pingownerteam = self.team;
    var_d63eaed5cf083a4c = isvehicleoccupiedbyenemy( calloutvehicleentity, pingownerteam );
    
    while ( true )
    {
        var_bdbcac67c0f0bc0c = function_dd96b6ae4be5ae38( pingindex, calloutvehicleentity, pingownerteam );
        
        if ( var_bdbcac67c0f0bc0c )
        {
            function_7c0ee9d4b604e6d6( pingindex );
            return;
        }
        
        isvehicleoccupiedbyenemy = isvehicleoccupiedbyenemy( calloutvehicleentity, pingownerteam );
        var_4081b8b1191c67e2 = 0;
        
        if ( utility::issharedfuncdefined( #"teams", #"hash_37e3c17230e1ac5f" ) )
        {
            var_4081b8b1191c67e2 = utility::callsharedfunc( #"teams", #"hash_37e3c17230e1ac5f", calloutvehicleentity.vehicleteam );
        }
        
        if ( isvehicleoccupiedbyenemy && !var_4081b8b1191c67e2 )
        {
            if ( !var_d63eaed5cf083a4c )
            {
                function_7c0ee9d4b604e6d6( pingindex );
            }
            
            var_86263f9c4c75933d += tick;
            
            if ( var_86263f9c4c75933d >= level.calloutmarkerping.var_7dad33dc75610e40 )
            {
                vehicleowner = calloutvehicleentity getvehicleowner();
                
                if ( function_fdd3752869f6c712( calloutvehicleentity ) )
                {
                    thread function_40df08cd2d68aaf2( pingindex, calloutvehicleentity, undefined, 1 );
                    return;
                }
                
                if ( isdefined( vehicleowner ) )
                {
                    thread function_40df08cd2d68aaf2( pingindex, vehicleowner );
                    return;
                }
                
                function_7c0ee9d4b604e6d6( pingindex );
                return;
            }
        }
        
        message = function_4f44dd3a8b94d7c3( tick, var_c10b7272d2bcc5c );
        
        if ( message == var_c10b7272d2bcc5c )
        {
            function_7c0ee9d4b604e6d6( pingindex );
            return;
        }
    }
}

// Namespace calloutmarkerping
// Params 2
// Checksum 0x5ed697, Offset: 0x9a71
// Size: 0x66
function function_4f44dd3a8b94d7c3( timeout, string1 )
{
    ent = spawnstruct();
    
    if ( isdefined( string1 ) )
    {
        childthread utility::waittill_string_no_endon_death( string1, ent );
    }
    
    ent childthread utility::timeout_struct( timeout );
    ent waittill( #"returned", msg );
    ent notify( #"die" );
    return msg;
}

// Namespace calloutmarkerping
// Params 3, eflags: 0x4
// Checksum 0x475c4ec6, Offset: 0x9ae0
// Size: 0x105, Type: bool
function private function_dd96b6ae4be5ae38( pingindex, calloutvehicleentity, pingownerteam )
{
    pingowner = self;
    var_703c8ada3ba8b088 = 0;
    playersquad = [[ utility::getsharedfunc( #"game", #"getsquadmates" ) ]]( pingownerteam, pingowner.sessionsquadid, 1 );
    
    foreach ( player in playersquad )
    {
        if ( player vehicle::is_in_vehicle() && player.vehicle == calloutvehicleentity )
        {
            pingowner calloutmarkerping_hide( pingindex, player );
            var_703c8ada3ba8b088++;
        }
    }
    
    if ( var_703c8ada3ba8b088 == playersquad.size )
    {
        return true;
    }
    
    return false;
}

// Namespace calloutmarkerping
// Params 2, eflags: 0x4
// Checksum 0x45214074, Offset: 0x9bee
// Size: 0xa7, Type: bool
function private isvehicleoccupiedbyenemy( calloutvehicleentity, pingownerteam )
{
    var_6ca6947b3230b57a = isdefined( calloutvehicleentity.ownerteam ) && calloutvehicleentity.ownerteam != pingownerteam || isdefined( calloutvehicleentity.vehicleteam ) && calloutvehicleentity.vehicleteam != pingownerteam;
    isvehicleoccupied = isdefined( calloutvehicleentity.isempty ) && calloutvehicleentity.isempty == 0 || isdefined( calloutvehicleentity.vehicleteam );
    
    if ( isvehicleoccupied && var_6ca6947b3230b57a )
    {
        return true;
    }
    
    return false;
}

// Namespace calloutmarkerping
// Params 1, eflags: 0x4
// Checksum 0xd9afb295, Offset: 0x9c9e
// Size: 0x18, Type: bool
function private function_fdd3752869f6c712( calloutvehicleentity )
{
    return istrue( calloutvehicleentity.var_4b70483c15214db8 );
}

// Namespace calloutmarkerping
// Params 4, eflags: 0x4
// Checksum 0xd4933397, Offset: 0x9cbf
// Size: 0x219
function private function_e347a0ed35abfcdc( pingindex, var_6f4b7f4ba67dcb01, cancelreason, var_45d67c382f4bf4f6 )
{
    pingowner = self;
    
    if ( !isdefined( pingowner.var_9f31be02d87c5511 ) )
    {
        return;
    }
    
    var_3a53cbced80b5015 = pingowner.var_9f31be02d87c5511[ pingindex ];
    
    if ( !( isdefined( var_3a53cbced80b5015 ) && isdefined( var_3a53cbced80b5015.var_6675b0888e2dbc2 ) ) )
    {
        return;
    }
    
    var_6675b0888e2dbc2 = var_3a53cbced80b5015.var_6675b0888e2dbc2;
    
    if ( !isdefined( pingowner.var_e86c729ae2db47a0[ var_6675b0888e2dbc2 ] ) )
    {
        return;
    }
    
    pingassetname = calloutmarkerping_asset_name( var_6675b0888e2dbc2 );
    var_fd4506565b0c1f34 = pingowner.var_e86c729ae2db47a0[ var_6675b0888e2dbc2 ];
    
    if ( var_45d67c382f4bf4f6 )
    {
        var_3a53cbced80b5015.var_3135f161a43e4955++;
    }
    
    pingorigin = var_3a53cbced80b5015.pingorigin ?? ( 0, 0, 0 );
    pingowner dlog_recordplayerevent( "dlog_event_br_ping_usage", [ "ping_asset_id_name", pingassetname, "ping_asset_id_count", var_fd4506565b0c1f34, "tac_map_active", istrue( pingowner istacmapactive() ), "canceled", var_6f4b7f4ba67dcb01, "cancel_reason", cancelreason, "player_x", float( pingowner.origin[ 0 ] ), "player_y", float( pingowner.origin[ 1 ] ), "player_z", float( pingowner.origin[ 2 ] ), "ping_x", float( pingorigin[ 0 ] ), "ping_y", float( pingorigin[ 1 ] ), "ping_z", float( pingorigin[ 2 ] ), "acknowledged", var_45d67c382f4bf4f6, "acknowledged_count", var_3a53cbced80b5015.var_3135f161a43e4955 ] );
}

// Namespace calloutmarkerping
// Params 1, eflags: 0x4
// Checksum 0x11647d29, Offset: 0x9ee0
// Size: 0x155
function private dlog_add( pingindex )
{
    assert( pingindex >= 0 && pingindex < 10, "<dev string:x4a>" + "<dev string:x677>" + pingindex );
    
    if ( pingindex < 0 || pingindex >= 10 )
    {
        return;
    }
    
    pingowner = self;
    
    if ( !isdefined( pingowner.var_9f31be02d87c5511 ) )
    {
        pingowner.var_9f31be02d87c5511 = [];
    }
    
    var_3a53cbced80b5015 = pingowner.var_9f31be02d87c5511[ pingindex ];
    
    if ( !isdefined( var_3a53cbced80b5015 ) )
    {
        pingowner.var_9f31be02d87c5511[ pingindex ] = spawnstruct();
        var_3a53cbced80b5015 = pingowner.var_9f31be02d87c5511[ pingindex ];
        var_3a53cbced80b5015.var_3135f161a43e4955 = 0;
        var_3a53cbced80b5015.var_6675b0888e2dbc2 = pingowner function_689a4266a29aac13( pingindex );
        var_3a53cbced80b5015.pingorigin = pingowner calloutmarkerping_getorigin( pingindex );
    }
    
    var_6675b0888e2dbc2 = var_3a53cbced80b5015.var_6675b0888e2dbc2;
    
    if ( !isdefined( pingowner.var_e86c729ae2db47a0 ) )
    {
        pingowner.var_e86c729ae2db47a0 = [];
    }
    
    pingowner.var_e86c729ae2db47a0[ var_6675b0888e2dbc2 ] = isdefined( pingowner.var_e86c729ae2db47a0[ var_6675b0888e2dbc2 ] ) ? pingowner.var_e86c729ae2db47a0[ var_6675b0888e2dbc2 ] + 1 : 1;
    pingowner function_e347a0ed35abfcdc( pingindex, 0, "", 0 );
}

// Namespace calloutmarkerping
// Params 0, eflags: 0x4
// Checksum 0x7b3b2ec3, Offset: 0xa03d
// Size: 0x63
function private dlog_clearall()
{
    pingowner = self;
    
    if ( isdefined( pingowner ) )
    {
        for ( pingindex = 0; pingindex < 10 ; pingindex++ )
        {
            isowner = pingowner isowner( pingindex );
            
            if ( isowner && pingowner calloutmarkerping_getactive( pingindex ) )
            {
                pingowner function_e347a0ed35abfcdc( pingindex, 1, "clear_all", 0 );
            }
        }
    }
}

// Namespace calloutmarkerping
// Params 0, eflags: 0x4
// Checksum 0x19cc5441, Offset: 0xa0a8
// Size: 0x12d
function private function_26d38a8e75b416b2()
{
    player = self;
    
    if ( isdefined( player ) )
    {
        assert( utility::issharedfuncdefined( #"game", #"getsquadmates" ) );
        playersquad = [[ utility::getsharedfunc( #"game", #"getsquadmates" ) ]]( player.team, player.sessionsquadid, 1 );
        
        foreach ( pingowner in playersquad )
        {
            if ( pingowner != player )
            {
                for ( pingindex = 0; pingindex < 10 ; pingindex++ )
                {
                    isowner = pingowner isowner( pingindex );
                    
                    if ( isowner && pingowner calloutmarkerping_getactive( pingindex ) )
                    {
                        player function_e347a0ed35abfcdc( pingindex, 1, "clear_squadmates", 0 );
                    }
                }
            }
        }
    }
}

// Namespace calloutmarkerping
// Params 1
// Checksum 0x5958082, Offset: 0xa1dd
// Size: 0x45, Type: bool
function isowner( pingindex )
{
    player = self;
    clientnum = player getentitynumber();
    owner = player function_46d39460fb86d466( pingindex );
    
    if ( clientnum == owner )
    {
        return true;
    }
    
    return false;
}

// Namespace calloutmarkerping
// Params 3, eflags: 0x4
// Checksum 0xb1ced57a, Offset: 0xa22b
// Size: 0xb4
function private function_476f9fd6a624bef2( pingindex, var_6675b0888e2dbc2, issilent )
{
    assert( pingindex >= 0 && pingindex < 10 );
    
    if ( pingindex < 0 || pingindex >= 10 )
    {
        return;
    }
    
    assert( isdefined( var_6675b0888e2dbc2 ) );
    pingowner = self;
    pingowner function_e347a0ed35abfcdc( pingindex, 1, "clear_single", 0 );
    function_af615455b694483b( pingowner, pingindex );
    pingowner callback::callback( #"on_ping_removed", { #pingindex:pingindex } );
    pingowner notify( "predictiveCalloutClear_" + pingindex );
    
    if ( !issilent )
    {
        pingowner thread function_663cea5889e99d33( undefined, var_6675b0888e2dbc2 );
    }
}

// Namespace calloutmarkerping
// Params 2, eflags: 0x4
// Checksum 0x9b681fc0, Offset: 0xa2e7
// Size: 0xed
function private function_a26ec6bad4d47bc2( pingindex, var_fd2ae37400699499 )
{
    assert( pingindex >= 0 && pingindex < 10 );
    
    if ( pingindex < 0 || pingindex >= 10 )
    {
        return;
    }
    
    pingowner = self;
    assert( pingowner isowner( pingindex ) );
    assert( isplayer( var_fd2ae37400699499 ) );
    pingowner function_e347a0ed35abfcdc( pingindex, 0, "", 1 );
    pingowner thread function_d10c13a769210655( pingindex, var_fd2ae37400699499 );
    target = pingowner calloutmarkerping_getent( pingindex );
    
    if ( isdefined( target ) )
    {
        targetstruct = spawnstruct();
        targetstruct.target = target;
        pingowner callback::callback( "on_tacmap_ping_scriptable_or_ent", targetstruct );
    }
    
    predicted_log( "Refreshing ping timeout. Ping: " + pingindex + " Client: " + pingowner getentitynumber() );
    pingowner thread predicted_timeout( pingindex );
}

// Namespace calloutmarkerping
// Params 2, eflags: 0x4
// Checksum 0x8b3c91db, Offset: 0xa3dc
// Size: 0x72
function private function_d02507dfb75e6e90( pingindex, var_fd2ae37400699499 )
{
    assert( pingindex >= 0 && pingindex < 10 );
    
    if ( pingindex < 0 || pingindex >= 10 )
    {
        return;
    }
    
    pingowner = self;
    assert( pingowner isowner( pingindex ) );
    assert( isplayer( var_fd2ae37400699499 ) );
    pingowner thread function_28eae04dcb53cf6b( pingindex, var_fd2ae37400699499 );
}

// Namespace calloutmarkerping
// Params 1, eflags: 0x4
// Checksum 0x5bf5fb16, Offset: 0xa456
// Size: 0x26c
function private function_d0c9cf62476247c8( pingindex )
{
    assert( pingindex >= 0 && pingindex < 10 );
    
    if ( pingindex < 0 || pingindex >= 10 )
    {
        return;
    }
    
    pingowner = self;
    assert( pingowner isowner( pingindex ) );
    
    if ( function_26978d5b055bd644( pingowner, pingindex ) )
    {
        return;
    }
    
    target = function_5cfadc3e9a9a9056( pingowner, pingindex );
    pingowner callback::callback( #"on_ping", { #obj:target, #pingindex:pingindex, #player:pingowner } );
    
    if ( isdefined( target ) )
    {
        target callback::callback( #"on_ping", { #obj:target, #pingindex:pingindex, #player:pingowner } );
        
        if ( isenemy( target, pingowner ) )
        {
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( pingowner ) ) )
            {
                if ( isdefined( pingowner.leaderboarddata[ "enemyPlayersPinged" ] ) )
                {
                    pingowner.leaderboarddata[ "enemyPlayersPinged" ] = pingowner.leaderboarddata[ "enemyPlayersPinged" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "enemyPlayersPinged" ] ) )
                {
                    [[ level.leaderboardfunc[ "enemyPlayersPinged" ] ]]( pingowner, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x69c>" );
                
                if ( isdefined( pingowner.pers[ "enemyPlayersPinged" ] ) )
                {
                    pingowner.pers[ "enemyPlayersPinged" ] = pingowner.pers[ "enemyPlayersPinged" ] + 1;
                }
            }
        }
    }
    
    pingowner dlog_add( pingindex );
    function_3ea6f23e8ce78512( pingowner, pingindex );
    pingowner function_cd837c1b9212eced( pingindex );
    pingowner thread function_498993d2ef305f85( pingindex );
    pingowner function_97907d2c28d5c064( pingindex );
    var_6675b0888e2dbc2 = pingowner function_689a4266a29aac13( pingindex );
    
    if ( var_6675b0888e2dbc2 == function_1bf3a084cfe14025( 6 ) )
    {
        objindex = self calloutmarkerping_getgscobjectiveindex( pingindex );
        
        if ( objindex != -1 )
        {
            objective_setplayintro( objindex, 0 );
        }
    }
    
    if ( getdvarint( @"hash_d3174ac55ae9bad2" ) )
    {
        function_8c044a617ba406b3( pingindex );
    }
    
    pingowner thread predicted_timeout( pingindex );
    predicted_log( "HandleNotify (Added) | pingIndex: " + pingindex );
}

// Namespace calloutmarkerping
// Params 1, eflags: 0x4
// Checksum 0x49532425, Offset: 0xa6ca
// Size: 0x44
function private function_8c044a617ba406b3( pingindex )
{
    dest = self calloutmarkerping_getorigin( pingindex );
    
    if ( !isdefined( dest ) )
    {
        return;
    }
    
    origin = self.origin;
    self function_9df55ae07d30bb07( pingindex, origin, dest );
}

// Namespace calloutmarkerping
// Params 2, eflags: 0x4
// Checksum 0xbe63642a, Offset: 0xa716
// Size: 0x101
function private function_8bab7aa83d4f2b9d( pingowner, var_6675b0888e2dbc2 )
{
    if ( !utility::issharedfuncdefined( #"teamassim", #"isenabled" ) || !utility::issharedfuncdefined( #"teamassim", #"resolveassimrequest" ) || !utility::issharedfuncdefined( #"teamassim", #"requestnearbyteamchange" ) || !utility::issharedfuncdefined( #"teamassim", #"iswaitingforassimresponse" ) )
    {
        return;
    }
    
    if ( ![[ utility::getsharedfunc( #"teamassim", #"isenabled" ) ]]() )
    {
        return;
    }
    
    if ( function_e017734603d9cc3a( var_6675b0888e2dbc2 ) )
    {
        [[ utility::getsharedfunc( #"teamassim", #"requestnearbyteamchange" ) ]]( pingowner, var_6675b0888e2dbc2 == function_1bf3a084cfe14025( 17 ) );
    }
    
    if ( function_2c54e299556d3115( var_6675b0888e2dbc2 ) )
    {
        [[ utility::getsharedfunc( #"teamassim", #"requestleaveteam" ) ]]( pingowner );
    }
}

// Namespace calloutmarkerping
// Params 1, eflags: 0x4
// Checksum 0x7115ba12, Offset: 0xa81f
// Size: 0x86
function private function_d45334eb63d913e( pingindex )
{
    assert( pingindex >= 0 && pingindex < 10 );
    
    if ( pingindex < 0 || pingindex >= 10 )
    {
        return;
    }
    
    pingowner = self;
    assert( pingowner isowner( pingindex ) );
    pingowner playteamsoundfx( "uin_ping_enemy", pingindex );
    predicted_log( "Refreshing Timeout | pingIndex: " + pingindex + " | owner: " + pingowner getentitynumber() );
    pingowner thread predicted_timeout( pingindex );
}

// Namespace calloutmarkerping
// Params 0, eflags: 0x4
// Checksum 0xa684889f, Offset: 0xa8ad
// Size: 0x61
function private function_177516fd2f972d05()
{
    pingowner = self;
    isanypingactive = pingowner function_1db6157b09195dcd();
    
    if ( isanypingactive )
    {
        pingowner dlog_clearall();
        pingowner playteamsoundfx( "uin_ping_cancel" );
        function_52fcff0fa4ffaecf( pingowner );
        pingowner play( %"ping_response_cancel" );
    }
    
    pingowner function_5a33bcee47519dd6();
}

// Namespace calloutmarkerping
// Params 0, eflags: 0x4
// Checksum 0x7bbfa463, Offset: 0xa916
// Size: 0x21
function private function_effed1f0a3864f36()
{
    pingowner = self;
    pingowner function_26d38a8e75b416b2();
    pingowner function_6600f789bf67d116();
}

// Namespace calloutmarkerping
// Params 1
// Checksum 0x61559326, Offset: 0xa93f
// Size: 0x75
function function_b4611f55ab7cb258( var_f17ef1d848c7b476 )
{
    bitsused = 32;
    
    if ( bitsused > 32 )
    {
        return;
    }
    
    pingdata = spawnstruct();
    lootidmask = 67108863;
    pingdata.lootid = var_f17ef1d848c7b476 & lootidmask;
    var_f17ef1d848c7b476 >>= 26;
    var_960d33e78f5e3706 = 63;
    pingdata.var_6675b0888e2dbc2 = var_f17ef1d848c7b476 & var_960d33e78f5e3706;
    return pingdata;
}

// Namespace calloutmarkerping
// Params 1, eflags: 0x4
// Checksum 0x8609e54, Offset: 0xa9bd
// Size: 0x14d
function private function_6502d098804c6a1a( var_f17ef1d848c7b476 )
{
    if ( !level.calloutmarkerping.lootidpings )
    {
        return;
    }
    
    player = self;
    pingdata = function_b4611f55ab7cb258( var_f17ef1d848c7b476 );
    assert( isdefined( pingdata ) );
    var_19755e90b7c652e5 = player function_1220e16172b72e42( pingdata.var_6675b0888e2dbc2 );
    
    if ( !isdefined( var_19755e90b7c652e5 ) )
    {
        return;
    }
    
    var_e020c8ffd0c49e9e = function_99bb86ac4bae26cf( var_19755e90b7c652e5.object, player.team, pingdata.lootid );
    
    if ( isdefined( var_e020c8ffd0c49e9e ) )
    {
        playernum = player getentitynumber();
        var_c027fbad674838c3 = player function_46d39460fb86d466( var_e020c8ffd0c49e9e );
        var_53af2fb15a090253 = playernum != var_c027fbad674838c3;
    }
    
    if ( isdefined( var_e020c8ffd0c49e9e ) && var_53af2fb15a090253 )
    {
        var_860d9dd43615ccd5 = getentbynum( var_c027fbad674838c3 );
        var_9c07f25832510057 = var_860d9dd43615ccd5 function_6cadf227bac5e2e2( player, var_e020c8ffd0c49e9e );
        
        if ( isdefined( var_9c07f25832510057 ) )
        {
            if ( var_9c07f25832510057 )
            {
                var_860d9dd43615ccd5 function_a26ec6bad4d47bc2( var_e020c8ffd0c49e9e, player );
            }
            else
            {
                var_860d9dd43615ccd5 function_d02507dfb75e6e90( var_e020c8ffd0c49e9e, player );
            }
        }
        
        return;
    }
    
    player thread function_4bf4d6b965e2853d( pingdata.var_6675b0888e2dbc2, pingdata.lootid );
}

// Namespace calloutmarkerping
// Params 1
// Checksum 0x195b0117, Offset: 0xab12
// Size: 0x26
function function_6052d1ed5729bcfc( target )
{
    target.var_d26c6dba74c8a179 = [];
    target.var_58cc57d664322d1d = [];
}

// Namespace calloutmarkerping
// Params 4
// Checksum 0x41d7462a, Offset: 0xab40
// Size: 0x1e9
function function_9bd4bf4f8fe74b16( oldtarget, newtarget, var_bb35753da9c53e68, var_e64a95729b64767f )
{
    assert( isdefined( oldtarget ) && isdefined( newtarget ) );
    
    if ( !isdefined( var_e64a95729b64767f ) )
    {
        var_e64a95729b64767f = ( 0, 0, 0 );
    }
    
    index = undefined;
    
    if ( isent( newtarget ) && newtarget isscriptable() || !isnumber( newtarget ) && newtarget isscriptableinstance() )
    {
        index = newtarget.index;
        
        if ( !index )
        {
            index = newtarget getscriptableindex();
        }
        
        oldtarget.var_3ef12453ab182d7b = 1;
    }
    else if ( isent( newtarget ) )
    {
        index = newtarget getentitynumber();
        oldtarget.var_3ef12453ab182d7b = 0;
    }
    else if ( var_bb35753da9c53e68 == 6 )
    {
        index = newtarget;
    }
    
    assert( isdefined( index ) );
    oldtarget.var_ed60d13f0c7685b6 = var_e64a95729b64767f;
    oldtarget.var_ac252e251029d01f = index;
    oldtarget.var_23c6b54dfc7fd7dd = var_bb35753da9c53e68;
    
    if ( isdefined( oldtarget.var_58cc57d664322d1d ) )
    {
        foreach ( entnumber, pingindex in oldtarget.var_58cc57d664322d1d )
        {
            pingowner = undefined;
            
            if ( isdefined( oldtarget.var_d26c6dba74c8a179 ) )
            {
                pingowner = oldtarget.var_d26c6dba74c8a179[ entnumber ];
            }
            
            var_6675b0888e2dbc2 = pingowner function_689a4266a29aac13( pingindex );
            
            if ( !isdefined( pingowner ) || !function_4838d0aa6e70099f( var_6675b0888e2dbc2 ) )
            {
                continue;
            }
            
            function_36b0433d790035cc( pingowner, pingindex, oldtarget );
        }
    }
}

// Namespace calloutmarkerping
// Params 1
// Checksum 0xdf664aef, Offset: 0xad31
// Size: 0x38
function function_ab4e5514677fba94( target )
{
    target.var_ed60d13f0c7685b6 = undefined;
    target.var_ac252e251029d01f = undefined;
    target.var_23c6b54dfc7fd7dd = undefined;
    target.var_3ef12453ab182d7b = undefined;
}

// Namespace calloutmarkerping
// Params 2
// Checksum 0x22600de0, Offset: 0xad71
// Size: 0xd8
function function_ea6c1cfc8cd997d0( player, var_bde93b870aa42ced )
{
    if ( !( isdefined( player ) && isdefined( var_bde93b870aa42ced ) ) )
    {
        return;
    }
    
    foreach ( pingowner in var_bde93b870aa42ced )
    {
        if ( pingowner != player )
        {
            for ( pingindex = 0; pingindex < 10 ; pingindex++ )
            {
                isowner = pingowner isowner( pingindex );
                
                if ( isowner && pingowner calloutmarkerping_getactive( pingindex ) )
                {
                    pingowner calloutmarkerping_hide( pingindex, player );
                }
            }
        }
    }
}

// Namespace calloutmarkerping
// Params 2
// Checksum 0x25fbd646, Offset: 0xae51
// Size: 0xd8
function function_c9bd983008573e40( player, var_594f895c46df539c )
{
    if ( !( isdefined( player ) && isdefined( var_594f895c46df539c ) ) )
    {
        return;
    }
    
    foreach ( pingowner in var_594f895c46df539c )
    {
        if ( pingowner != player )
        {
            for ( pingindex = 0; pingindex < 10 ; pingindex++ )
            {
                isowner = pingowner isowner( pingindex );
                
                if ( isowner && pingowner calloutmarkerping_getactive( pingindex ) )
                {
                    pingowner calloutmarkerping_show( pingindex, player );
                }
            }
        }
    }
}

// Namespace calloutmarkerping
// Params 1
// Checksum 0x443bd66b, Offset: 0xaf31
// Size: 0x9f
function function_68803d9075ebe67( pingidx )
{
    foreach ( player in level.teamdata[ self.team ][ "players" ] )
    {
        if ( player == self )
        {
            continue;
        }
        
        self calloutmarkerping_hide( pingidx, player );
    }
}

// Namespace calloutmarkerping
// Params 2, eflags: 0x4
// Checksum 0x6fa609e1, Offset: 0xafd8
// Size: 0xa7, Type: bool
function private function_26978d5b055bd644( pingowner, pingindex )
{
    target = function_5cfadc3e9a9a9056( pingowner, pingindex );
    
    if ( isdefined( target ) && function_36b0433d790035cc( pingowner, pingindex, target ) )
    {
        return true;
    }
    
    var_6675b0888e2dbc2 = pingowner function_689a4266a29aac13( pingindex );
    
    if ( function_b658b8c35408496a( var_6675b0888e2dbc2 ) && !level.calloutmarkerping.var_8014802dd81e900c )
    {
        pingowner thread function_40df08cd2d68aaf2( pingindex, target, 1 );
        return true;
    }
    
    if ( utility::callsharedfunc( #"gametype", #"hash_b58c7095634d1249", pingowner, pingindex ) )
    {
        return true;
    }
    
    return false;
}

// Namespace calloutmarkerping
// Params 3, eflags: 0x4
// Checksum 0x8cd6d908, Offset: 0xb088
// Size: 0x169, Type: bool
function private function_36b0433d790035cc( pingowner, pingindex, oldtarget )
{
    if ( isdefined( oldtarget ) && isdefined( oldtarget.var_ed60d13f0c7685b6 ) && isdefined( oldtarget.var_ac252e251029d01f ) )
    {
        pingowner function_7c0ee9d4b604e6d6( pingindex );
        
        if ( oldtarget.var_23c6b54dfc7fd7dd == 6 )
        {
            newpingindex = pingowner function_5d7b7302e94b97c2( oldtarget.var_ac252e251029d01f, oldtarget.var_ed60d13f0c7685b6 );
        }
        else
        {
            istargetscriptable = oldtarget.var_3ef12453ab182d7b ?? isent( oldtarget ) && oldtarget isscriptable() || !isent( oldtarget ) && !isnumber( oldtarget ) && oldtarget isscriptableinstance();
            scriptableindex = istargetscriptable ? oldtarget.var_ac252e251029d01f : undefined;
            entindex = !istargetscriptable ? oldtarget.var_ac252e251029d01f : undefined;
            var_3504396cc501f196 = isdefined( oldtarget.var_23c6b54dfc7fd7dd ) ? function_1bf3a084cfe14025( oldtarget.var_23c6b54dfc7fd7dd ) : pingowner function_689a4266a29aac13( pingindex );
            newpingindex = pingowner createcallout( var_3504396cc501f196, oldtarget.var_ed60d13f0c7685b6, entindex, scriptableindex );
        }
        
        function_3ea6f23e8ce78512( pingowner, newpingindex );
        return isdefined( newpingindex );
    }
    
    return false;
}

// Namespace calloutmarkerping
// Params 2, eflags: 0x4
// Checksum 0x2bc726af, Offset: 0xb1fa
// Size: 0x9d
function private function_3ea6f23e8ce78512( pingowner, pingindex )
{
    target = function_5cfadc3e9a9a9056( pingowner, pingindex );
    
    if ( isdefined( target.var_d26c6dba74c8a179 ) && isdefined( target.var_58cc57d664322d1d ) )
    {
        if ( !isdefined( pingowner.recordedpings ) )
        {
            pingowner.recordedpings = [];
        }
        
        pingowner.recordedpings[ pingindex ] = target;
        target.var_d26c6dba74c8a179[ pingowner getentitynumber() ] = pingowner;
        target.var_58cc57d664322d1d[ pingowner getentitynumber() ] = pingindex;
    }
}

// Namespace calloutmarkerping
// Params 1, eflags: 0x4
// Checksum 0xc1af839f, Offset: 0xb29f
// Size: 0x54
function private function_52fcff0fa4ffaecf( pingowner )
{
    for ( pingindex = 0; pingindex < 10 ; pingindex++ )
    {
        isowner = pingowner isowner( pingindex );
        
        if ( isowner && pingowner calloutmarkerping_getactive( pingindex ) )
        {
            function_af615455b694483b( pingowner, pingindex );
        }
    }
}

// Namespace calloutmarkerping
// Params 2, eflags: 0x4
// Checksum 0x5d23837, Offset: 0xb2fb
// Size: 0x97
function private function_af615455b694483b( pingowner, pingindex )
{
    target = undefined;
    
    if ( isdefined( pingowner.recordedpings ) )
    {
        target = pingowner.recordedpings[ pingindex ];
        pingowner.recordedpings[ pingindex ] = undefined;
    }
    
    if ( isdefined( target ) && isdefined( target.var_d26c6dba74c8a179 ) && isdefined( target.var_58cc57d664322d1d ) )
    {
        target.var_d26c6dba74c8a179[ pingowner getentitynumber() ] = undefined;
        target.var_58cc57d664322d1d[ pingowner getentitynumber() ] = undefined;
    }
}

// Namespace calloutmarkerping
// Params 2
// Checksum 0x29a290dc, Offset: 0xb39a
// Size: 0x78
function function_5cfadc3e9a9a9056( pingowner, pingindex )
{
    target = pingowner calloutmarkerping_getent( pingindex );
    
    if ( isdefined( target ) && isdefined( target.entity ) )
    {
        target = target.entity;
    }
    
    targetstruct = spawnstruct();
    targetstruct.target = target;
    pingowner callback::callback( "on_tacmap_ping_scriptable_or_ent", targetstruct );
    return target;
}

// Namespace calloutmarkerping
// Params 2, eflags: 0x4
// Checksum 0xf74e8303, Offset: 0xb41b
// Size: 0x106, Type: bool
function private function_8ce0bcb0b252dd8c( player, objid )
{
    if ( !function_8a5e0620417279c8() )
    {
        return true;
    }
    
    if ( !isdefined( level.objectives ) )
    {
        return true;
    }
    
    currentobjective = undefined;
    
    foreach ( objective in level.objectives )
    {
        if ( objective.objidnum == objid )
        {
            currentobjective = objective;
            break;
        }
    }
    
    if ( !isdefined( currentobjective ) )
    {
        return true;
    }
    
    return isdefined( currentobjective.touchlist[ player.team ] ) && currentobjective.touchlist[ player.team ].size > 0;
}

// Namespace calloutmarkerping
// Params 0, eflags: 0x4
// Checksum 0xecdd72fc, Offset: 0xb52a
// Size: 0x9b, Type: bool
function private function_8a5e0620417279c8()
{
    if ( !isdefined( level.gametype ) )
    {
        return false;
    }
    
    gametype = level.gametype;
    return gametype == "dom" || gametype == "koth" || gametype == "hc_koth" || gametype == "lp_koth" || gametype == "cdl_koth" || gametype == "koth_horde" || gametype == "koth_jugg" || gametype == "grnd" || gametype == "gwai" || gametype == "hq";
}

