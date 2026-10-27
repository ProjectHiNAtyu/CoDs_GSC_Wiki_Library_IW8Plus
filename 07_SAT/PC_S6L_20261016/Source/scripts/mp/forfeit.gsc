// scripts\mp\forfeit.gsc  (hash_77639abe4c11dbcf.gscc) (size: 7453 Bytes / 0x1d1d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa26ad21a (2724909594)
// size ...... 7453 (0x1d1d)
// includes .. 6   (offset: 0x1b9d)
// strings ... 17  (offset: 0x1bcd)
// dev strs .. 3   (offset: 0x1cf9)
// exports ... 23  (offset: 0x11b9)
// cseg ...... 0x1d1 + 0xfe8 (0x11b9)
// imports ... 51  (offset: 0x1551)
// animtree1 . 0   (offset: 0x1d1d)
// animtree2 . 0   (offset: 0x1d1d)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\dev;

#namespace forfeit;

// Namespace forfeit
// Params 1
// Checksum 0x108f393b, Offset: 0x1ef
// Size: 0x102
function init( var_cd5820d7b0306214 )
{
    /#
        level thread function_73e4c1c2fa628bca();
    #/
    
    forfeitstruct = function_415a7fc2027b3f30( 1 );
    level.var_cd5820d7b0306214 = var_cd5820d7b0306214;
    
    foreach ( player in level.players )
    {
        player thread function_430342f467b24bc2( var_cd5820d7b0306214 );
    }
    
    callback::add( #"player_disconnect", &onplayerdisconnect );
    callback::add( #"player_connect", &onplayerconnect );
    callback::add( #"player_spawned", &onspawnplayer );
    callback::add( #"round_ended", &onroundended );
}

// Namespace forfeit
// Params 1
// Checksum 0x3ffd38fc, Offset: 0x2f9
// Size: 0xfa
function onplayerdisconnect( params )
{
    var_179a6cedd1b8b790 = function_c9e5799d0d8b30d8();
    
    if ( isdefined( var_179a6cedd1b8b790[ self.team ] ) )
    {
        if ( arraycontains( var_179a6cedd1b8b790[ self.team ].acceptedplayers, self ) )
        {
            var_179a6cedd1b8b790[ self.team ].acceptedplayers = arrayremove( var_179a6cedd1b8b790[ self.team ].acceptedplayers, self );
        }
        
        if ( arraycontains( var_179a6cedd1b8b790[ self.team ].players, self ) )
        {
            var_179a6cedd1b8b790[ self.team ].players = arrayremove( var_179a6cedd1b8b790[ self.team ].players, self );
        }
        
        var_179a6cedd1b8b790[ self.team ].var_310c994aad723dff = level.var_179a6cedd1b8b790[ self.team ].players;
    }
}

// Namespace forfeit
// Params 1
// Checksum 0xe631cc1, Offset: 0x3fb
// Size: 0x1c
function onplayerconnect( params )
{
    thread function_430342f467b24bc2( level.var_cd5820d7b0306214 );
}

// Namespace forfeit
// Params 1
// Checksum 0xc8138de9, Offset: 0x41f
// Size: 0x63
function onspawnplayer( params )
{
    var_179a6cedd1b8b790 = function_c9e5799d0d8b30d8();
    
    if ( isdefined( var_179a6cedd1b8b790[ self.team ] ) )
    {
        if ( var_179a6cedd1b8b790[ self.team ].votetimer > 0 )
        {
            self setclientomnvar( "ui_is_team_currently_voting", 1 );
            return;
        }
        
        self setclientomnvar( "ui_is_team_currently_voting", 0 );
    }
}

// Namespace forfeit
// Params 1
// Checksum 0x29b9128f, Offset: 0x48a
// Size: 0xb3
function function_430342f467b24bc2( var_cd5820d7b0306214 )
{
    level endon( #"hash_46bfecf0ec889820" );
    level endon( #"hash_d31863ea978adee" );
    level endon( #"forfeit_disable" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"luinotifyserver", result, index, value );
        
        if ( result == var_cd5820d7b0306214 && !isdefined( function_c9e5799d0d8b30d8()[ self.team ] ) )
        {
            playeractivator = self;
            function_a30de8b35dea91d9( playeractivator );
            playeractivator setclientomnvar( "ui_has_already_started_a_vote", 1 );
            break;
        }
    }
}

// Namespace forfeit
// Params 1
// Checksum 0x56ec1b1f, Offset: 0x545
// Size: 0x181
function function_a30de8b35dea91d9( playeractivator )
{
    var_eeb5d57866a9cc1e = teams::getteamdata( playeractivator.team, "players" );
    var_179a6cedd1b8b790 = function_c9e5799d0d8b30d8();
    var_179a6cedd1b8b790[ playeractivator.team ] = { #votetimer:level.gametypebundle.var_a4e59e057abacb8a ?? 15, #forfeitsuccess:0, #acceptedplayers:[], #var_310c994aad723dff:var_eeb5d57866a9cc1e.size, #players:var_eeb5d57866a9cc1e };
    utility::array_thread( var_eeb5d57866a9cc1e, &function_13b1ed876d10520, playeractivator );
    function_a8348e0da243181f( playeractivator );
    
    foreach ( player in var_179a6cedd1b8b790[ playeractivator.team ].players )
    {
        function_2a06e01a94795292( player );
        player notify( #"hash_2d4bde50812f715c" );
    }
    
    level thread function_5ea4d34ec8efac84( playeractivator.team );
    level thread function_6293439477269a34( var_179a6cedd1b8b790[ playeractivator.team ].votetimer, playeractivator.team );
}

// Namespace forfeit
// Params 1, eflags: 0x4
// Checksum 0xb0dd9253, Offset: 0x6ce
// Size: 0x16b
function private function_13b1ed876d10520( playeractivator )
{
    self endon( #"disconnect" );
    self.var_8e7c7ec69a013857 = 1;
    activatingteam = playeractivator.team;
    var_179a6cedd1b8b790 = function_c9e5799d0d8b30d8();
    votetimer = var_179a6cedd1b8b790[ activatingteam ].votetimer;
    thread function_4cfcb93168ca1ac5( votetimer );
    
    while ( votetimer >= 0 && isdefined( var_179a6cedd1b8b790[ activatingteam ] ) )
    {
        if ( self.forfeitaccepted || playeractivator == self || var_179a6cedd1b8b790[ activatingteam ].acceptedplayers.size >= var_179a6cedd1b8b790[ activatingteam ].var_310c994aad723dff )
        {
            var_179a6cedd1b8b790[ activatingteam ].acceptedplayers = arraycombineunique( var_179a6cedd1b8b790[ activatingteam ].acceptedplayers, [ self ] );
            
            if ( var_179a6cedd1b8b790[ activatingteam ].acceptedplayers.size >= var_179a6cedd1b8b790[ activatingteam ].var_310c994aad723dff )
            {
                var_179a6cedd1b8b790[ activatingteam ].forfeitsuccess = 1;
                var_179a6cedd1b8b790[ activatingteam ] notify( #"forfeit_opt_in_done" );
            }
            
            break;
        }
        else if ( self.forfeitdeclined )
        {
            var_179a6cedd1b8b790[ activatingteam ].forfeitsuccess = 0;
            var_179a6cedd1b8b790[ activatingteam ] notify( #"forfeit_opt_in_done" );
            break;
        }
        
        waitframe();
        votetimer -= level.framedurationseconds;
    }
    
    self notify( #"forfeit_opt_in_done" );
}

// Namespace forfeit
// Params 1, eflags: 0x4
// Checksum 0x3e8b1753, Offset: 0x841
// Size: 0x122
function private function_4cfcb93168ca1ac5( votetimer )
{
    self endon( #"disconnect" );
    
    if ( !self usinggamepad() )
    {
        self notifyonplayercommand( "forfeit_vote_accept", "accept_vote" );
    }
    
    if ( getdvarint( @"hash_2bc388151cb3eaf6", 0 ) )
    {
        player::function_ba055eee4438741e( "forfeit_vote_accept", "actionslot 2", &function_5f2bb1590a2b5b5a, undefined, undefined, 1.5, &function_5da0b76f2cdc82bb, "gamepad_only" );
    }
    else
    {
        self notifyonplayercommand( "forfeit_vote_accept", "-actionslot 2" );
    }
    
    val::set( "forfeit", "prone", 0 );
    msg = utility::waittill_any_timeout_no_endon_death( votetimer, "forfeit_vote_accept", "forfeit_opt_in_done" );
    
    if ( msg == "forfeit_vote_accept" )
    {
        self.forfeitaccepted = 1;
        self playlocalsound( #"hash_27de9a10f2ebd146" );
    }
    else
    {
        self.forfeitdeclined = 1;
    }
    
    if ( !getdvarint( @"hash_2bc388151cb3eaf6", 0 ) )
    {
        self notifyonplayercommandremove( "forfeit_vote_accept", "-actionslot 2" );
    }
    
    self notifyonplayercommandremove( "forfeit_vote_accept", "accept_vote" );
    val::reset( "forfeit", "prone" );
}

// Namespace forfeit
// Params 3
// Checksum 0xff105685, Offset: 0x96b
// Size: 0x31
function function_5da0b76f2cdc82bb( var_c1fa5c1e922e62d6, progress, iscomplete )
{
    self setclientomnvar( "forfeit_vote_fill", progress / 1500 );
}

// Namespace forfeit
// Params 1
// Checksum 0x2de0e55b, Offset: 0x9a4
// Size: 0x66
function function_5f2bb1590a2b5b5a( params )
{
    level endon( #"hash_46bfecf0ec889820" );
    level endon( #"hash_d31863ea978adee" );
    self endon( #"disconnect" );
    self playlocalsound( #"hash_27de9a10f2ebd146" );
    self notify( #"forfeit_vote_accept_release" );
    self.forfeitaccepted = 1;
    self setclientomnvar( "forfeit_vote_fill", 1 );
}

// Namespace forfeit
// Params 1
// Checksum 0xb204675d, Offset: 0xa12
// Size: 0x11a
function function_a8348e0da243181f( playeractivator )
{
    var_179a6cedd1b8b790 = function_c9e5799d0d8b30d8();
    
    foreach ( player in var_179a6cedd1b8b790[ playeractivator.team ].players )
    {
        player setclientomnvar( "ui_is_team_currently_voting", 1 );
        player setclientomnvar( "forfeit_vote_time", var_179a6cedd1b8b790[ playeractivator.team ].votetimer );
        player setclientomnvar( "forfeit_vote_min_accepted_player", var_179a6cedd1b8b790[ playeractivator.team ].var_310c994aad723dff );
        player setclientomnvar( "forfeit_vote_initiator", playeractivator getentitynumber() );
        player setclientomnvar( "forfeit_vote_player_vote_result", 0 );
        player setclientomnvar( "forfeit_vote_team_vote_result", 0 );
    }
}

// Namespace forfeit
// Params 2, eflags: 0x4
// Checksum 0x9dfa268f, Offset: 0xb34
// Size: 0xb1
function private function_5ea4d34ec8efac84( activatingteam, votetimer )
{
    level endon( #"hash_46bfecf0ec889820" );
    level endon( #"hash_d31863ea978adee" );
    var_179a6cedd1b8b790 = function_c9e5799d0d8b30d8();
    var_179a6cedd1b8b790[ activatingteam ] endon( #"forfeit_opt_in_done" );
    votetimer = var_179a6cedd1b8b790[ activatingteam ].votetimer;
    var_9604129ac35311b = 1;
    
    while ( votetimer >= 0 )
    {
        function_d62c719ab3e7b487( activatingteam, votetimer, var_9604129ac35311b == 1 );
        
        if ( var_9604129ac35311b == 1 )
        {
            var_9604129ac35311b = 0;
        }
        
        wait 0.5;
        votetimer -= 0.5;
        var_9604129ac35311b += 0.5;
    }
}

// Namespace forfeit
// Params 3, eflags: 0x4
// Checksum 0x6ae0fd91, Offset: 0xbed
// Size: 0x135
function private function_d62c719ab3e7b487( activatingteam, votetimer, var_9ef64a95e0065805 )
{
    var_179a6cedd1b8b790 = function_415a7fc2027b3f30().var_179a6cedd1b8b790;
    
    foreach ( player in var_179a6cedd1b8b790[ activatingteam ].players )
    {
        if ( isdefined( player ) )
        {
            var_585d75a1d75f340f = max( var_179a6cedd1b8b790[ activatingteam ].var_310c994aad723dff - var_179a6cedd1b8b790[ activatingteam ].acceptedplayers.size, 0 );
            player setclientomnvar( "forfeit_vote_min_accepted_player", var_585d75a1d75f340f );
            
            if ( arraycontains( var_179a6cedd1b8b790[ activatingteam ].acceptedplayers, player ) )
            {
                player setclientomnvar( "forfeit_vote_player_vote_result", 1 );
            }
            
            if ( var_9ef64a95e0065805 )
            {
                player playlocalsound( #"hash_f326a0cf1090ba43" );
            }
            
            player setclientomnvar( "forfeit_vote_time", votetimer );
        }
    }
}

// Namespace forfeit
// Params 1
// Checksum 0x1f24273b, Offset: 0xd2a
// Size: 0x127
function function_26b8b4c5145631e2( team )
{
    var_179a6cedd1b8b790 = function_415a7fc2027b3f30().var_179a6cedd1b8b790;
    forfeitsuccess = var_179a6cedd1b8b790[ team ].forfeitsuccess;
    vote_result_sound = forfeitsuccess ? #"hash_ed2acbdc3a80a541" : #"hash_c415924615c42636";
    
    foreach ( player in var_179a6cedd1b8b790[ team ].players )
    {
        player setclientomnvar( "forfeit_vote_team_vote_result", forfeitsuccess ? 1 : -1 );
        thread function_801668abc974652( player );
        player playlocalsound( vote_result_sound );
        
        if ( isdefined( player ) )
        {
            player.var_8e7c7ec69a013857 = undefined;
            player.forfeitaccepted = undefined;
            player.forfeitdeclined = undefined;
        }
    }
}

// Namespace forfeit
// Params 1
// Checksum 0xd074d717, Offset: 0xe59
// Size: 0x19
function function_801668abc974652( player )
{
    player setclientomnvar( "ui_is_team_currently_voting", 0 );
}

// Namespace forfeit
// Params 2
// Checksum 0xb7167200, Offset: 0xe7a
// Size: 0x6b
function function_6293439477269a34( votetimer, activatingteam )
{
    function_18478fd8aab2f6c2( votetimer, activatingteam );
    function_26b8b4c5145631e2( activatingteam );
    var_179a6cedd1b8b790 = function_c9e5799d0d8b30d8();
    
    if ( var_179a6cedd1b8b790[ activatingteam ].forfeitsuccess )
    {
        if ( isdefined( level.var_4aa00295f34bae97 ) )
        {
            [[ level.var_4aa00295f34bae97 ]]( activatingteam );
        }
    }
    
    var_179a6cedd1b8b790[ activatingteam ] = undefined;
}

// Namespace forfeit
// Params 1, eflags: 0x4
// Checksum 0x8d2f27f2, Offset: 0xeed
// Size: 0x30
function private function_2a06e01a94795292( player )
{
    if ( isdefined( player ) )
    {
        player setclientomnvar( "ui_is_team_currently_voting", 1 );
        player playlocalsound( #"hash_55e276943e528f6" );
    }
}

// Namespace forfeit
// Params 0, eflags: 0x4
// Checksum 0x4944a30a, Offset: 0xf25
// Size: 0x12
function private function_c9e5799d0d8b30d8()
{
    return function_415a7fc2027b3f30().var_179a6cedd1b8b790;
}

// Namespace forfeit
// Params 1, eflags: 0x4
// Checksum 0x98005414, Offset: 0xf40
// Size: 0x44
function private function_415a7fc2027b3f30( forceinit )
{
    if ( forceinit || !isdefined( game[ "forfeit" ] ) )
    {
        game[ "forfeit" ] = spawnstruct();
        game[ "forfeit" ].var_179a6cedd1b8b790 = [];
    }
    
    return game[ "forfeit" ];
}

// Namespace forfeit
// Params 2, eflags: 0x4
// Checksum 0xb81fe61d, Offset: 0xf8d
// Size: 0x43
function private function_18478fd8aab2f6c2( votetimer, activatingteam )
{
    level endon( #"hash_46bfecf0ec889820" );
    level endon( #"hash_d31863ea978adee" );
    function_c9e5799d0d8b30d8()[ activatingteam ] utility::waittill_any_timeout_no_endon_death( votetimer, "forfeit_opt_in_done" );
}

// Namespace forfeit
// Params 1, eflags: 0x4
// Checksum 0x559c0954, Offset: 0xfd8
// Size: 0x26
function private onroundended( params )
{
    if ( params.lastround )
    {
        level notify( #"hash_46bfecf0ec889820" );
    }
}

/#

    // Namespace forfeit
    // Params 0
    // Checksum 0x214bb853, Offset: 0x1006
    // Size: 0x1b3, Type: dev
    function function_73e4c1c2fa628bca()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_f076f413905ac465", 0 ) == 1 )
            {
                host = dev_mp::devfindhost();
                
                if ( !isdefined( host ) )
                {
                    return;
                }
                
                team = host.team;
                teammates = teams::getteamdata( team, "<dev string:x24>" );
                
                foreach ( player in teammates )
                {
                    if ( isbot( player ) && !player.startedvote )
                    {
                        player notify( #"luinotifyserver", "<dev string:x2c>", undefined, player );
                        player.startedvote = 1;
                        break;
                    }
                }
                
                setdvar( @"hash_f076f413905ac465", 0 );
            }
            
            if ( getdvarint( @"hash_9b3e2afe0d004880", 0 ) == 1 )
            {
                foreach ( player in level.players )
                {
                    player setclientomnvar( "<dev string:x3f>", 0 );
                }
                
                setdvar( @"hash_9b3e2afe0d004880", 0 );
            }
            
            waitframe();
        }
    }

#/
