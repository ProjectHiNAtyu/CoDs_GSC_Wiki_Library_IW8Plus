// scripts\mp\menus.gsc  (hash_498b9015fc4a2548.gscc) (size: 24119 Bytes / 0x5e37 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x74e1137f (1960907647)
// size ...... 24119 (0x5e37)
// includes .. 26  (offset: 0x54bf)
// strings ... 109 (offset: 0x558f)
// dev strs .. 16  (offset: 0x5d5f)
// exports ... 45  (offset: 0x38bb)
// cseg ...... 0x945 + 0x2f76 (0x38bb)
// imports ... 165 (offset: 0x3fc3)
// animtree1 . 0   (offset: 0x5e37)
// animtree2 . 0   (offset: 0x5e37)
#using script_23eca243497ca70a;
#using script_7cab86232cdd30ba;
#using scripts\common\callbacks;
#using scripts\common\progression_utility;
#using scripts\common\script;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\mp\bounty;
#using scripts\mp\class;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\join_team_aggregator;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\lui_game_event_aggregator;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\prestige_challenge_utility;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gamescore;
#using scripts\mp\hud_message;
#using scripts\mp\playerlogic;
#using scripts\mp\spectating;
#using scripts\mp\squads;
#using scripts\mp\teams;

#namespace menus;

// Namespace menus
// Params 0
// Checksum 0x740a272, Offset: 0x963
// Size: 0x2cd
function init()
{
    if ( !isdefined( game[ "gamestarted" ] ) )
    {
        game[ "menu_team" ] = "team_marinesopfor";
        
        if ( level.multiteambased )
        {
            game[ "menu_team" ] = "team_mt_options";
        }
        
        game[ "menu_class" ] = "class";
        game[ "menu_class_allies" ] = "class_marines";
        game[ "menu_class_axis" ] = "class_opfor";
        game[ "menu_changeclass_allies" ] = "changeclass_marines";
        game[ "menu_changeclass_axis" ] = "changeclass_opfor";
        
        if ( level.multiteambased )
        {
            for ( i = 0; i < level.teamnamelist.size ; i++ )
            {
                str_menu_class = "menu_class_" + level.teamnamelist[ i ];
                str_menu_changeclass = "menu_changeclass_" + level.teamnamelist[ i ];
                game[ str_menu_class ] = game[ "menu_class_allies" ];
                game[ str_menu_changeclass ] = "changeclass_marines";
            }
        }
        
        game[ "menu_changeclass" ] = "changeclass";
        game[ "menu_controls" ] = "ingame_controls";
        
        if ( level.splitscreen )
        {
            if ( level.multiteambased )
            {
                for ( i = 0; i < level.teamnamelist.size ; i++ )
                {
                    str_menu_class = "menu_class_" + level.teamnamelist[ i ];
                    str_menu_changeclass = "menu_changeclass_" + level.teamnamelist[ i ];
                    game[ str_menu_class ] += "_splitscreen";
                    game[ str_menu_changeclass ] += "_splitscreen";
                }
            }
            
            game[ "menu_team" ] = game[ "menu_team" ] + "_splitscreen";
            game[ "menu_class_allies" ] = game[ "menu_class_allies" ] + "_splitscreen";
            game[ "menu_class_axis" ] = game[ "menu_class_axis" ] + "_splitscreen";
            game[ "menu_changeclass_allies" ] = game[ "menu_changeclass_allies" ] + "_splitscreen";
            game[ "menu_changeclass_axis" ] = game[ "menu_changeclass_axis" ] + "_splitscreen";
            game[ "menu_controls" ] = game[ "menu_controls" ] + "_splitscreen";
            game[ "menu_changeclass_defaults_splitscreen" ] = "changeclass_splitscreen_defaults";
            game[ "menu_changeclass_custom_splitscreen" ] = "changeclass_splitscreen_custom";
        }
        
        precachestring( &"mp/host_ended_game" );
        precachestring( &"mp/host_endgame_response" );
    }
    
    level lui_game_event_aggregator::registeronluieventcallback( &onleavegamecallback );
    level lui_game_event_aggregator::registeronluieventcallback( &onteamchangecallback );
    level ui::lui_registercallback( "class_edit", &onclasseditcallback );
    level ui::lui_registercallback( "class_select", &onclasschoicecallback );
    level ui::lui_registercallback( "class_preview", &function_81f7c0c1a6714dc );
    level ui::lui_registercallback( "loadout_select_info", &function_3274fdbb6ca42733 );
    level.var_ea995225fc620c59 = getdvarint( @"hash_6cb6994f3a89112c", 0 );
    callback::add( #"round_ended", &onroundended );
    level thread setintrocamnetworkmodel();
}

// Namespace menus
// Params 1
// Checksum 0x827ff812, Offset: 0xc38
// Size: 0x97
function onroundended( data )
{
    if ( isdefined( level.players ) )
    {
        foreach ( player in level.players )
        {
            player setclientomnvar( "ui_open_menu_from_script", -1 );
        }
    }
}

// Namespace menus
// Params 2
// Checksum 0xf3ede837, Offset: 0xcd7
// Size: 0x50
function onteamchangecallback( channel, teamselected )
{
    if ( !isbrgamemode() )
    {
        if ( channel != "team_select" )
        {
            return;
        }
        
        if ( game_utility_mp::matchmakinggame() )
        {
            if ( getdvarint( @"hash_c1d902763d019b7a", 0 ) == 0 )
            {
                return;
            }
        }
        
        handleteamchange( channel, teamselected );
    }
}

// Namespace menus
// Params 0
// Checksum 0xb235f1e, Offset: 0xd2f
// Size: 0x5b
function function_7536ab2605ea29b0()
{
    level waittill( #"prematch_started" );
    
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( level.matchcancelled )
    {
        return;
    }
    
    println( "<dev string:x24>" + self.name + "<dev string:x66>" );
    self setclientomnvar( "ui_open_menu_from_script", 2 );
    level.var_aa33632a0e7d701 = 1;
}

// Namespace menus
// Params 0
// Checksum 0xd78fe74, Offset: 0xd92
// Size: 0x1c
function setintrocamnetworkmodel()
{
    setintrocameraactive( 1 );
    level waittill( #"prematch_over" );
    setintrocameraactive( 0 );
}

// Namespace menus
// Params 1
// Checksum 0x1ae07bdf, Offset: 0xdb6
// Size: 0x11, Type: bool
function isloadoutindexdefault( index )
{
    return index >= 100;
}

// Namespace menus
// Params 1
// Checksum 0x6253594f, Offset: 0xdd0
// Size: 0xef
function getclasschoice( menuindex )
{
    menuindex++;
    newclasschoice = undefined;
    
    if ( menuindex > 100 )
    {
        classindex = menuindex - 100;
        classtitle = "default";
        
        if ( getcodegate( #"hash_d8bf19b3daff8a30" ) )
        {
            if ( prestige_challenge_utility::function_ba46581a84b1edac() )
            {
                classtitle = prestige_challenge_utility::function_9bdd875e7b63531e();
            }
        }
        
        newclasschoice = classtitle + classindex;
    }
    else if ( function_4949886586a105b3( self ) )
    {
        newclasschoice = "custom" + menuindex;
    }
    else
    {
        script::function_789a02669a1a12e9( @"hash_a423522f752bd1f6", "getClassChoice: fallback to 'default1' since the player seems to have pressed back at the loadout select (ie selects no class)" );
        newclasschoice = "default1";
        
        if ( getcodegate( #"hash_d8bf19b3daff8a30" ) )
        {
            if ( prestige_challenge_utility::function_ba46581a84b1edac() )
            {
                newclasschoice = prestige_challenge_utility::function_615e6a7465344cf5();
            }
        }
    }
    
    if ( !isdefined( level.classmap[ newclasschoice ] ) )
    {
        utility::error( "Class index is undefined in the class map for: " + newclasschoice + "." );
        newclasschoice = "default1";
    }
    
    return newclasschoice;
}

// Namespace menus
// Params 2
// Checksum 0x43de0051, Offset: 0xec8
// Size: 0x1f7
function executeclasschange( newclass, var_4b1ca0a7be8baa2d )
{
    if ( isbot( self ) || istestclient( self ) )
    {
        self.pers[ "class" ] = newclass;
        self.class = newclass;
    }
    else
    {
        script::function_789a02669a1a12e9( @"hash_a423522f752bd1f6", "executeClassChange: newClass is " + ( newclass ?? "<undefined>" ) + ", currentClassHasChanged is " + ( var_4b1ca0a7be8baa2d ?? "<undefined>" ) + ", self.pers[ 'class' ] is " + ( self.pers[ "class" ] ?? "<undefined>" ) );
        newclasschoice = getclasschoice( newclass );
        
        if ( !isdefined( self.pers[ "class" ] ) || newclasschoice != self.pers[ "class" ] || var_4b1ca0a7be8baa2d )
        {
            self.pers[ "class" ] = newclasschoice;
            self.class = newclasschoice;
            class::preloadandqueueclass( newclasschoice );
        }
        
        var_d5ef6760c0f7a3fc = 1;
        
        if ( isbrgamemode() && !gamelogic_mp::function_a054d2386f2ced38() )
        {
            var_d5ef6760c0f7a3fc = 0;
        }
        
        error = spawnstruct();
        
        if ( class::shouldallowinstantclassswap( error ) && var_d5ef6760c0f7a3fc )
        {
            script::function_789a02669a1a12e9( @"hash_a423522f752bd1f6", "executeClassChange: swapLoadout" );
            thread class::swaploadout();
        }
        else
        {
            var_4624f31771ddd028 = isbrgamemode() && self getclientomnvar( "ui_open_loadout_bag" );
            
            if ( isalive( self ) && !var_4624f31771ddd028 && isdefined( error.string ) )
            {
                hud_message::showerrormessage( error.string, error.param );
            }
            
            if ( newclass < 100 )
            {
                self setclientomnvar( "ui_loadout_changed", class::getclassindex( self.pers[ "class" ] ) );
            }
        }
    }
    
    thread utility::callsharedfunc( #"gametype", #"hash_e0509a91e608241" );
}

// Namespace menus
// Params 1
// Checksum 0xc0304f9f, Offset: 0x10c7
// Size: 0x5a
function setnextroundclass( newclass )
{
    newclasschoice = newclass;
    
    if ( !isbot( self ) )
    {
        if ( isalive( self ) )
        {
            self iprintlnbold( game[ "strings" ][ "revive_class" ] );
        }
        
        newclasschoice = getclasschoice( newclass );
    }
    
    self.pers[ "next_round_class" ] = newclasschoice;
}

// Namespace menus
// Params 0, eflags: 0x4
// Checksum 0xade53ed7, Offset: 0x1129
// Size: 0x46, Type: bool
function private function_3ec4c86c571d158c()
{
    if ( level.gametypebundle.var_3ec4c86c571d158c )
    {
        var_ee7e4762f16f61fd = getdvarint( @"party_maxplayers", 0 );
        
        if ( var_ee7e4762f16f61fd == 1 && function_7a3d4348b3110c54() )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace menus
// Params 2
// Checksum 0x4375461, Offset: 0x1178
// Size: 0x70
function onleavegamecallback( channel, val )
{
    if ( channel != "end_game" )
    {
        return;
    }
    
    if ( !function_3ec4c86c571d158c() )
    {
        if ( game_utility_mp::matchmakinggame() )
        {
            return;
        }
        
        if ( isdedicatedserver() && !function_425b03c0a43ac143( self ) )
        {
            return;
        }
    }
    
    if ( isdefined( level.var_d5a94b280b9c9c35 ) )
    {
        level thread [[ level.var_d5a94b280b9c9c35 ]]( val );
        return;
    }
    
    level thread gamelogic_mp::forceend( val );
}

// Namespace menus
// Params 1
// Checksum 0x60e1cdb9, Offset: 0x11f0
// Size: 0x44
function onclasseditcallback( newclass )
{
    self endon( #"disconnect" );
    waittillframeend();
    callback::callback( #"menu_class_edit", { #class:getclasschoice( newclass ) } );
    handleclassedit( newclass );
}

// Namespace menus
// Params 2
// Checksum 0xdc05614f, Offset: 0x123c
// Size: 0x2d
function function_81f7c0c1a6714dc( newclass, var_f3e2877dc0bfb8b7 )
{
    executeclasschange( newclass, istrue( var_f3e2877dc0bfb8b7 ) );
    self notify( #"hash_ecf6bb3a3f3d7cd8" );
}

// Namespace menus
// Params 1
// Checksum 0x55ed5d63, Offset: 0x1271
// Size: 0x59
function function_3274fdbb6ca42733( var_ac44cea19ed560e2 )
{
    var_611cbeb426d97c63 = 65280;
    loadoutstate = ( var_ac44cea19ed560e2 & var_611cbeb426d97c63 ) >> 8;
    
    if ( loadoutstate == 4 )
    {
        var_3d52437b11beade6 = 255;
        classindex = var_ac44cea19ed560e2 & var_3d52437b11beade6;
        self.infilclass = classindex;
    }
}

// Namespace menus
// Params 3
// Checksum 0xef6ee09, Offset: 0x12d2
// Size: 0x268
function onclasschoicecallback( newclass, var_f3e2877dc0bfb8b7, fromedit )
{
    script::function_789a02669a1a12e9( @"hash_a423522f752bd1f6", "onClassChoiceCallback: newClass is " + ( newclass ?? "<undefined>" ) + ", currentClassChanged is " + ( var_f3e2877dc0bfb8b7 ?? "<undefined>" ) + ", fromEdit is " + ( fromedit ?? "<undefined>" ) );
    self notify( #"loadout_class_selected", newclass );
    self.selectedclass = 1;
    self notify( #"loadout_selected" );
    
    if ( !isbot( self ) && level.projectbundle.var_786bc1b37b3f67fa && issubstr( getclasschoice( newclass ), "custom" ) )
    {
        self.var_44212c4c1b32eae3 = 1;
    }
    
    if ( level.systemlink && getdvarint( @"xblive_competitionmatch" ) && self iscodcaster() )
    {
        self setclientomnvar( "ui_open_menu_from_script", -1 );
        return;
    }
    
    if ( self.waitingtoselectclass )
    {
        script::function_789a02669a1a12e9( @"hash_a423522f752bd1f6", "onClassChoiceCallback: waitingToSelectClass" );
        
        if ( isdefined( self.revive_chosenclass ) )
        {
            setnextroundclass( newclass );
        }
        
        if ( level.var_ea995225fc620c59 )
        {
            self.waitingtoselectclass = 0;
            self setclientomnvar( "ui_open_menu_from_script", 4 );
            self.var_6672fdc3e42374c = 1;
            return;
        }
        
        self setclientomnvar( "ui_open_menu_from_script", -1 );
        return;
    }
    
    if ( !fromedit )
    {
        self setclientomnvar( "ui_open_menu_from_script", -1 );
    }
    
    if ( !game_utility_mp::allowclasschoice() || game_utility_mp::showfakeloadout() )
    {
        script::function_789a02669a1a12e9( @"hash_a423522f752bd1f6", "onClassChoiceCallback: classChoice not allowed" );
        return;
    }
    
    if ( isdefined( self.revive_chosenclass ) && isdefined( self.instantclassswapallowed ) && !class::shouldallowinstantclassswap() )
    {
        script::function_789a02669a1a12e9( @"hash_a423522f752bd1f6", "onClassChoiceCallback: instant swap not allowed" );
        setnextroundclass( newclass );
        return;
    }
    
    if ( string( newclass ) != "callback" )
    {
        script::function_789a02669a1a12e9( @"hash_a423522f752bd1f6", "onClassChoiceCallback: executeClassChange" );
        executeclasschange( newclass, istrue( var_f3e2877dc0bfb8b7 ) );
        
        if ( self.var_6672fdc3e42374c )
        {
            self setclientomnvar( "ui_open_menu_from_script", -1 );
            self.var_6672fdc3e42374c = 0;
            return;
        }
        
        return;
    }
    
    script::function_789a02669a1a12e9( @"hash_a423522f752bd1f6", "onClassChoiceCallback: callback" );
    menuclass( "callback" );
}

// Namespace menus
// Params 2
// Checksum 0xb4d975a6, Offset: 0x1542
// Size: 0x257
function handleteamchange( channel, teamselected )
{
    var_68a20840dc0b8c67 = 0;
    
    if ( teamselected >= 3 )
    {
        var_68a20840dc0b8c67 = 1;
    }
    
    if ( var_68a20840dc0b8c67 )
    {
        self setclientomnvar( "ui_spectator_selected", 1 );
        self.spectating_actively = 1;
    }
    else
    {
        self setclientomnvar( "ui_spectator_selected", -1 );
        self.spectating_actively = 0;
    }
    
    wascodcaster = self iscodcaster();
    wasspectator = !wascodcaster && isdefined( self.team ) && ( self.team == "spectator" || self.team == "codcaster" );
    needrespawn = wascodcaster && teamselected == 3 || wasspectator && ( teamselected == 4 || teamselected == 5 );
    
    if ( teamselected == 4 || teamselected == 5 )
    {
        teamselected = 3;
        self setcodcaster( 1 );
    }
    else
    {
        self setcodcaster( 0 );
    }
    
    if ( teamselected == 0 )
    {
        teamselected = "axis";
    }
    else if ( teamselected == 1 )
    {
        teamselected = "allies";
    }
    else if ( teamselected == 2 )
    {
        teamselected = "random";
    }
    else if ( teamselected == 4 )
    {
        teamselected = "codcaster";
    }
    else
    {
        teamselected = "spectator";
    }
    
    if ( !needrespawn && isdefined( self.pers[ "team" ] ) && teamselected == self.pers[ "team" ] )
    {
        return;
    }
    
    if ( isdefined( self.operatorcustomization ) )
    {
        self.operatorcustomization.rebuild = 1;
    }
    
    thread logteamselection( teamselected );
    
    if ( teamselected != "spectator" )
    {
        self.pers[ "playerChoseSpectatorTeam" ] = undefined;
    }
    else
    {
        self.pers[ "playerChoseSpectatorTeam" ] = 1;
    }
    
    if ( teamselected == "axis" )
    {
        thread setteam( "axis" );
        return;
    }
    
    if ( teamselected == "allies" )
    {
        thread setteam( "allies" );
        return;
    }
    
    if ( teamselected == "random" )
    {
        thread autoassign();
        return;
    }
    
    if ( teamselected == "codcaster" )
    {
        thread function_c01531e8bc7f1011( needrespawn );
        return;
    }
    
    if ( teamselected == "spectator" )
    {
        thread setspectator( needrespawn );
    }
}

// Namespace menus
// Params 1
// Checksum 0x6ae65c79, Offset: 0x17a1
// Size: 0x7c
function handleclassedit( newclass )
{
    classname = getclasschoice( newclass );
    var_b55c73a0684a7273 = class::loadout_editcachedclassstruct( classname );
    var_87870224f8b3012b = class::loadout_editglobalclassstruct();
    anydifference = var_b55c73a0684a7273 || var_87870224f8b3012b;
    
    if ( classname == self.pers[ "class" ] && anydifference )
    {
        onclasschoicecallback( newclass, 1, 1 );
    }
}

// Namespace menus
// Params 1
// Checksum 0xfd056dcd, Offset: 0x1825
// Size: 0x138, Type: bool
function function_bd14454c0aa0d123( var_22a8aed6a84f7003 )
{
    for ( teamindex = level.teamnamelist.size - 1; teamindex >= 0 ; teamindex-- )
    {
        candidate = level.teamnamelist[ teamindex ];
        teamplayers = teams::getteamdata( candidate, "players" );
        hashuman = 0;
        
        foreach ( player in teamplayers )
        {
            if ( !isbot( player ) )
            {
                hashuman = 1;
                break;
            }
        }
        
        count = teamplayers.size;
        
        if ( var_22a8aed6a84f7003 )
        {
            count += teams::getteamdata( candidate, "UnlockedUIBotCount" );
        }
        
        if ( !hashuman && ( level.maxteamsize == 0 || count < level.maxteamsize ) )
        {
            thread setteam( candidate );
            return true;
        }
    }
    
    return false;
}

// Namespace menus
// Params 1
// Checksum 0x1ec96624, Offset: 0x1966
// Size: 0x3c3
function autoassign( firstconnect )
{
    forceteam = getdvar( @"scr_force_team", "" );
    
    if ( team_utility::isgameplayteam( forceteam ) )
    {
        setsessionteam( forceteam );
        thread setteam( forceteam, firstconnect );
        return;
    }
    
    if ( getdvarint( @"hash_3f36284b49b3d7a", 0 ) != 0 )
    {
        thread setteam( "allies", firstconnect );
        return;
    }
    
    var_22a8aed6a84f7003 = level.maxteamsize > 0 && isdefined( level.uibotmanager );
    
    if ( isbot( self ) && isdefined( self.bot_team ) && self.bot_team != "autoassign" )
    {
        thread setteam( self.bot_team, firstconnect );
        
        if ( var_22a8aed6a84f7003 )
        {
            function_27e4e9b975bb3782( self.bot_team );
        }
        
        return;
    }
    
    if ( self iscodcaster() )
    {
        thread function_c01531e8bc7f1011();
        return;
    }
    
    if ( self.sessionteam == "spectator" )
    {
        thread setspectator();
        return;
    }
    
    if ( isdefined( level.gametypebundle ) && level.gametypebundle.teammaxfill )
    {
        println( "<dev string:x81>" );
        var_bddda35c27ad4d32 = isbot( self ) && getdvarint( @"hash_d356a7876f773136", 0 ) != 0;
        
        if ( var_bddda35c27ad4d32 && function_bd14454c0aa0d123( var_22a8aed6a84f7003 ) )
        {
            return;
        }
        
        for ( teamindex = 0; teamindex < level.teamnamelist.size ; teamindex++ )
        {
            entry = level.teamnamelist[ teamindex ];
            
            if ( var_22a8aed6a84f7003 )
            {
                function_27e4e9b975bb3782( entry );
            }
            
            count = teams::getteamdata( entry, "teamCount" );
            
            if ( var_22a8aed6a84f7003 )
            {
                count += teams::getteamdata( entry, "UnlockedUIBotCount" );
            }
            
            if ( level.maxteamsize == 0 || count < level.maxteamsize )
            {
                thread setteam( entry, firstconnect );
                break;
            }
        }
        
        /#
            if ( !isdefined( self.team ) )
            {
                assertmsg( "<dev string:xa6>" );
                kick( self getentitynumber() );
            }
        #/
        
        return;
    }
    
    lowestcount = 0;
    lowestteams = [];
    
    foreach ( entry in level.teamnamelist )
    {
        count = teams::getteamdata( entry, "teamCount" );
        
        if ( self.team == entry )
        {
            count--;
        }
        
        if ( !lowestteams.size || count < lowestcount )
        {
            lowestcount = count;
            lowestteams = [];
            lowestteams[ lowestteams.size ] = entry;
            continue;
        }
        
        if ( count == lowestcount )
        {
            lowestteams[ lowestteams.size ] = entry;
        }
    }
    
    if ( lowestteams.size == 1 )
    {
        if ( self.team != lowestteams[ 0 ] )
        {
            thread setteam( lowestteams[ 0 ], firstconnect );
        }
        
        return;
    }
    
    if ( level.teambased )
    {
        bestteam = gamescore::gethighestscoringteam();
        
        if ( arraycontains( lowestteams, bestteam ) )
        {
            lowestteams = arrayremove( lowestteams, bestteam );
        }
    }
    
    if ( isdefined( self.team ) && arraycontains( lowestteams, self.team ) )
    {
        lowestteams = arrayremove( lowestteams, self.team );
    }
    
    if ( lowestteams.size > 0 )
    {
        randidx = randomint( lowestteams.size );
        
        if ( level.autoassignlowteamconsistent )
        {
            randidx = 0;
        }
        
        thread setteam( lowestteams[ randidx ], firstconnect );
    }
}

// Namespace menus
// Params 1
// Checksum 0xe10549e1, Offset: 0x1d31
// Size: 0x99
function function_27e4e9b975bb3782( team )
{
    var_bd764260911c2bb4 = teams::getteamdata( team, "teamCount" );
    var_2f69ae2bd3e7a898 = teams::getteamdata( team, "UnlockedUIBotCount" );
    counttotal = var_bd764260911c2bb4;
    
    if ( !recycle_manager::isenabled() )
    {
        counttotal += var_2f69ae2bd3e7a898;
    }
    
    if ( counttotal > level.maxteamsize )
    {
        assertmsg( "<dev string:x108>" + level.maxteamsize + "<dev string:x14b>" + team + "<dev string:x152>" + var_bd764260911c2bb4 + "<dev string:x161>" + var_2f69ae2bd3e7a898 );
    }
}

// Namespace menus
// Params 2
// Checksum 0x7645d9e, Offset: 0x1dd2
// Size: 0x3e1
function setteam( selection, firstconnect )
{
    self endon( #"disconnect" );
    
    if ( !isai( self ) && level.teambased && !teams::getjointeampermissions( selection ) && !game_utility_mp::lobbyteamselectenabled() )
    {
        return;
    }
    
    if ( level.ingraceperiod && !self.hasdonecombat )
    {
        self.hasspawned = 0;
        self.pers[ "lives" ] = game_utility_mp::getgametypenumlives();
    }
    
    if ( self.sessionstate == "playing" )
    {
        self.switching_teams = 1;
        self.joining_team = selection;
        self.leaving_team = self.pers[ "team" ];
        
        if ( game_utility::getgametype() == "arena" )
        {
            self.switching_teams_arena = 1;
        }
    }
    else if ( firstconnect && isdefined( level.forceteamassignmentoverride ) )
    {
        params = { #firstconnect:firstconnect, #selectedteam:selection };
        selection = self [[ level.forceteamassignmentoverride ]]( params );
    }
    
    if ( game[ "isLaunchChunk" ] && isbot( self ) == 0 )
    {
        selection = "allies";
    }
    
    addtoteam( selection, firstconnect );
    thread squads::setsquad( selection );
    
    if ( player::isragdollzerog() )
    {
        self lockdeathcamera( 1 );
    }
    
    if ( self.sessionstate == "playing" )
    {
        self suicide();
        player::updatesessionstate( "spectator" );
    }
    
    if ( game_utility_mp::allowclasschoice() || game_utility_mp::showfakeloadout() && !isai( self ) )
    {
        if ( getdvarint( @"hash_206a763969420ce0", 0 ) == 1 && isbrgamemode() && game_utility::getgametype() != "dmz" && game_utility::getgametype() != "plunder" && game_utility::getgametype() != "sandbox" )
        {
            classchoicefunc = isdefined( level.allowclasschoicefunc ) && self [[ level.allowclasschoicefunc ]]();
            script::demoforcesre( "setTeam() " + self.name + " ui_open_menu_from_script = UI_MENU_LOADOUT_MENU, allowClassChoiceFunc = " + classchoicefunc );
        }
        
        if ( !self.var_5db90938270d789c && !self.var_c7ad15df404c5ded && getdvarint( @"hash_89556297eaab6b6a", 0 ) == 0 )
        {
            self setclientomnvar( "ui_open_menu_from_script", 2 );
            level.var_aa33632a0e7d701 = 1;
        }
    }
    
    if ( level.gametypebundle.var_a9d5efb23dfeefe )
    {
        if ( getdvarint( @"hash_c11db9baa9e5bc9b", 0 ) == 0 )
        {
            thread function_7536ab2605ea29b0();
        }
    }
    
    if ( isdefined( level.onplayerconnectstream ) )
    {
        self thread [[ level.onplayerconnectstream ]]();
    }
    
    if ( !self.var_5db90938270d789c )
    {
        waitforclassselect();
    }
    
    if ( isdefined( level.team_pose ) && !flags::gameflag( "prematch_done" ) && getdvarint( @"hash_c11db9baa9e5bc9b", 0 ) == 0 )
    {
        function_a68e16099eeedfe6( selection );
    }
    
    endrespawnnotify();
    
    if ( self.sessionstate == "spectator" || playerisstreaming() )
    {
        if ( game_utility_mp::getgamestate( self ) == "postgame" )
        {
            return;
        }
        
        if ( game_utility_mp::getgamestate( self ) == "playing" && !player::isinkillcam() )
        {
            if ( self.waitingtospawnamortize || self.spawninginprogress || isalive( self ) )
            {
                return;
            }
            
            if ( isfunction( level.var_b3e0b38145c782a3 ) && [[ level.var_b3e0b38145c782a3 ]]( self ) )
            {
                return;
            }
            
            self.var_c99cd485dda40b28 = 1;
            thread playerlogic::spawnclient();
        }
        
        thread spectating::setspectatepermissions();
    }
    
    self notify( #"hash_18d39249f0d87711" );
}

// Namespace menus
// Params 1
// Checksum 0x83c9b82f, Offset: 0x21bb
// Size: 0xc9
function function_a68e16099eeedfe6( selection )
{
    if ( level.var_aa33632a0e7d701 && !self.selectedclass )
    {
        self waittill( #"loadout_selected" );
    }
    else if ( !isdefined( level.var_aa33632a0e7d701 ) && !self.selectedclass )
    {
        function_e7a3d53071e8c03c();
    }
    
    var_95ad852de1da3c79 = [[ level.team_pose.init ]]( selection );
    
    if ( var_95ad852de1da3c79 )
    {
        self setclientomnvar( "ui_open_menu_from_script", 5 );
        self [[ level.team_pose.start ]]();
        self waittill( #"team_pose_done" );
        self [[ level.team_pose.end ]]();
    }
}

// Namespace menus
// Params 0
// Checksum 0x7da4255c, Offset: 0x228c
// Size: 0x50
function function_e7a3d53071e8c03c()
{
    self endon( #"loading_over" );
    
    while ( true )
    {
        self waittill( #"luinotifyserver", result, value );
        
        if ( result == "versus_done" )
        {
            self notify( #"loading_over" );
        }
    }
}

// Namespace menus
// Params 0
// Checksum 0x4ffca487, Offset: 0x22e4
// Size: 0x1c, Type: bool
function playerisstreaming()
{
    return isdefined( level.playerisstreaming ) && self [[ level.playerisstreaming ]]();
}

// Namespace menus
// Params 0
// Checksum 0xc85e3270, Offset: 0x2309
// Size: 0x12, Type: bool
function function_d97fa73d1f9ddc03()
{
    return getdvarint( @"hash_a9194b992d1058d6", 0 ) != 0;
}

// Namespace menus
// Params 1
// Checksum 0x365db6d, Offset: 0x2324
// Size: 0xe8
function setspectator( needrespawn )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !needrespawn && isdefined( self.pers[ "team" ] ) && self.pers[ "team" ] == "spectator" )
    {
        return;
    }
    
    if ( isalive( self ) )
    {
        assert( isdefined( self.pers[ "<dev string:x1b6>" ] ) );
        self.switching_teams = 1;
        self.joining_team = "spectator";
        self.leaving_team = self.pers[ "team" ];
        
        if ( self.sessionstate == "playing" )
        {
            self suicide();
        }
    }
    
    self notify( #"hash_39d42ba422f7792f" );
    addtoteam( "spectator" );
    self.pers[ "class" ] = undefined;
    self.class = undefined;
    thread playerlogic::spawnspectator();
}

// Namespace menus
// Params 1
// Checksum 0xb20028bb, Offset: 0x2414
// Size: 0xcf
function function_c01531e8bc7f1011( needrespawn )
{
    if ( !needrespawn && isdefined( self.pers[ "team" ] ) && self.pers[ "team" ] == "codcaster" )
    {
        return;
    }
    
    if ( isalive( self ) )
    {
        assert( isdefined( self.pers[ "<dev string:x1b6>" ] ) );
        self.switching_teams = 1;
        self.joining_team = "codcaster";
        self.leaving_team = self.pers[ "team" ];
        self suicide();
    }
    
    self notify( #"hash_39d42ba422f7792f" );
    addtoteam( "codcaster" );
    self.pers[ "class" ] = undefined;
    self.class = undefined;
    thread playerlogic::spawnspectator();
}

// Namespace menus
// Params 1
// Checksum 0x295925d1, Offset: 0x24eb
// Size: 0x165, Type: bool
function function_4949886586a105b3( player )
{
    if ( !isdefined( player ) )
    {
        return false;
    }
    
    if ( isdefined( level.gamemodebundle ) && ( level.gamemodebundle.var_c386aac081c162f0 || level.gamemodebundle.var_da979d1ac3c9eb4 ) )
    {
        return true;
    }
    
    if ( level.gametypebundle.var_6840f6b673877445 )
    {
        return true;
    }
    
    if ( getdvarint( @"hash_6fbfdde9fc5d2964", 0 ) != 0 )
    {
        return true;
    }
    
    /#
        if ( getdvarint( @"unlockallitems" ) != 0 )
        {
            return true;
        }
    #/
    
    if ( game_utility_mp::privatematch() )
    {
        return true;
    }
    
    if ( level.systemlink )
    {
        return true;
    }
    
    if ( level.leagueplaymatch && getdvarint( @"hash_48d877b577f2565b", 1 ) != 0 )
    {
        return true;
    }
    
    if ( !isdefined( self.pers[ "rankXpEarnedThisMatch" ] ) )
    {
        self.pers[ "rankXpEarnedThisMatch" ] = 0;
    }
    
    var_f3929f37bca5f7eb = player_progression_achievements::function_ad429e448c443545();
    unverified_rank = progression_utility::getrankforxp( var_f3929f37bca5f7eb + self.pers[ "rankXpEarnedThisMatch" ] );
    best_rank = int( max( unverified_rank, progression_utility::getrank() ) );
    
    if ( best_rank >= 3 )
    {
        return true;
    }
    
    if ( player_progression_achievements::getprestige() >= 1 )
    {
        return true;
    }
    
    return false;
}

// Namespace menus
// Params 0
// Checksum 0x6ea52509, Offset: 0x2659
// Size: 0x441
function waitforclassselect()
{
    playerlogic::function_164bad72d3d50876( "menus::waitForClassSelect" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self.waitingtoselectclass = 1;
    
    if ( flags::gameflag( "prematch_done" ) && level.usespawnselection && !self.hasspawned )
    {
        self setclientomnvar( "ui_hide_objectives", 1 );
        self setclientomnvar( "ui_in_spawn_camera", 1 );
    }
    
    for ( ;; )
    {
        var_5a0dbed50631c1b1 = isbrgamemode() && game_utility_mp::allowclasschoice() && ( !flags::gameflag( "prematch_done" ) || level.skipprematch );
        var_1acb25f2e4ebf65f = game_utility_mp::function_470832bd123bba03( self.team ) && !flags::gameflag( "loadout_started" ) && !isdefined( level.bypassclasschoicefunc );
        var_7f0e1c65796bd96c = game_utility_mp::teamhasinfil( self.team ) && !flags::gameflag( "infil_started" ) && !isdefined( level.bypassclasschoicefunc );
        var_a2b3dcf858c75797 = game_utility_mp::islifelimited() && !isdefined( level.bypassclasschoicefunc ) && team_utility::isgameplayteam( self.team );
        var_cc37d68a03792304 = function_b8d426cb0b593d1();
        
        if ( var_cc37d68a03792304 >= 0 )
        {
            if ( istestclient( self ) )
            {
                newclass = "default1";
            }
            else if ( isbot( self ) )
            {
                newclass = "callback";
            }
            else
            {
                newclass = var_cc37d68a03792304;
            }
        }
        else if ( var_5a0dbed50631c1b1 || var_7f0e1c65796bd96c || var_1acb25f2e4ebf65f || var_a2b3dcf858c75797 )
        {
            if ( istestclient( self ) )
            {
                newclass = "default1";
            }
            else if ( !isai( self ) )
            {
                var_4949886586a105b3 = function_4949886586a105b3( self );
                
                if ( var_4949886586a105b3 && !game_utility_mp::function_f24635ef11e449d1() || getdvarint( @"hash_89556297eaab6b6a", 0 ) )
                {
                    newclass = self getplayerdata( level.var_6f9b00680ed002d8, "favoriteLoadoutIndex" );
                }
                else
                {
                    newclass = 100;
                }
            }
            else if ( isdefined( self.class ) && self.class != "" )
            {
                newclass = self.class;
            }
            else
            {
                newclass = "callback";
            }
        }
        else if ( game_utility_mp::allowclasschoice() || game_utility_mp::showfakeloadout() && !isai( self ) )
        {
            if ( level.gametypebundle.var_a9d5efb23dfeefe && ( !isdefined( self.pers[ "class" ] ) || self.pers[ "class" ] == "" ) )
            {
                bypassclasschoice();
            }
            
            if ( !self iscodcaster() && getdvarint( @"hash_e32ebdbb97a1ec4e", 0 ) == 0 && self.team != "spectator" && game_utility::getgametype() != "arm" && game_utility::getgametype() != "conflict" )
            {
                lower_message::setlowermessageomnvar( "must_select_loadout_to_spawn" );
            }
            
            var_bbb6554fbc33f949 = getdvarint( @"hash_d831c84920a830ff", 0 );
            
            if ( var_bbb6554fbc33f949 > 0 )
            {
                thread loadout_class_selected_timeout( var_bbb6554fbc33f949 );
            }
            
            self waittill( #"loadout_class_selected", newclass );
        }
        else
        {
            bypassclasschoice();
            break;
        }
        
        if ( self.team == "spectator" )
        {
            waitframe();
            continue;
        }
        
        if ( ( game_utility_mp::isjuggermoshgamemode() || game_utility_mp::ismutationgamemodezombie() ) && !isbot( self ) && !isloadoutindexdefault( newclass ) )
        {
            newclass = 100;
        }
        
        if ( string( newclass ) != "callback" )
        {
            if ( isbot( self ) || istestclient( self ) )
            {
                self.pers[ "class" ] = newclass;
                self.class = newclass;
            }
            else
            {
                newclass = newclass;
                self.pers[ "class" ] = getclasschoice( newclass );
                self.class = getclasschoice( newclass );
            }
            
            lower_message::setlowermessageomnvar( "clear_lower_msg" );
            self.waitingtoselectclass = 0;
        }
        else
        {
            self.waitingtoselectclass = 0;
            menuclass( "callback" );
        }
        
        break;
    }
}

// Namespace menus
// Params 0
// Checksum 0xdac4d8ff, Offset: 0x2aa2
// Size: 0x4a
function function_b8d426cb0b593d1()
{
    var_cc37d68a03792304 = level.var_996fc22e6a2c14a2 ?? level.gametypebundle.var_f710b427044b6ec9 ?? level.gamemodebundle.var_f710b427044b6ec9 ?? -1;
    return var_cc37d68a03792304;
}

// Namespace menus
// Params 1
// Checksum 0x47629d4e, Offset: 0x2af5
// Size: 0x36
function loadout_class_selected_timeout( var_bbb6554fbc33f949 )
{
    self endon( #"disconnect" );
    self endon( #"loadout_class_selected" );
    wait var_bbb6554fbc33f949;
    thread onclasschoicecallback( randomintrange( 100, 110 ) );
}

// Namespace menus
// Params 1
// Checksum 0xf99074de, Offset: 0x2b33
// Size: 0x1b9
function beginclasschoice( forcenewchoice )
{
    team = self.pers[ "team" ];
    assert( team == "<dev string:x1bb>" || team == "<dev string:x1c0>" || issubstr( team, "<dev string:x1c7>" ) );
    
    if ( game_utility_mp::allowclasschoice() || game_utility_mp::showfakeloadout() && !isai( self ) )
    {
        if ( getdvarint( @"hash_206a763969420ce0", 0 ) == 1 && isbrgamemode() && game_utility::getgametype() != "dmz" && game_utility::getgametype() != "plunder" && game_utility::getgametype() != "sandbox" )
        {
            classchoicefunc = isdefined( level.allowclasschoicefunc ) && self [[ level.allowclasschoicefunc ]]();
            script::demoforcesre( "beginClassChoice() " + self.name + " ui_open_menu_from_script = UI_MENU_LOADOUT_MENU, allowClassChoiceFunc = " + classchoicefunc );
        }
        
        if ( !self.var_c7ad15df404c5ded )
        {
            self setclientomnvar( "ui_open_menu_from_script", 2 );
        }
        
        if ( !self iscodcaster() )
        {
            waitforclassselect();
        }
        
        endrespawnnotify();
        
        if ( self.sessionstate == "spectator" )
        {
            if ( game_utility_mp::getgamestate( self ) == "postgame" )
            {
                return;
            }
            
            if ( game_utility_mp::getgamestate( self ) == "playing" && !player::isinkillcam() )
            {
                if ( isdefined( self.waitingtospawnamortize ) && self.waitingtospawnamortize )
                {
                    return;
                }
                
                thread playerlogic::spawnclient();
            }
            
            thread spectating::setspectatepermissions();
        }
        
        self.connecttime = gettime();
        self notify( #"hash_18d39249f0d87711" );
        return;
    }
    
    thread bypassclasschoice();
}

// Namespace menus
// Params 0
// Checksum 0xa6ec38b0, Offset: 0x2cf4
// Size: 0xef
function bypassclasschoice()
{
    self.selectedclass = 1;
    self.waitingtoselectclass = 0;
    self notify( #"loadout_selected" );
    
    if ( ispresstofirstspawnmode() && level.enforceantiboosting && !isbot( self ) )
    {
        lower_message::setlowermessageomnvar( "press_to_spawn" );
        self notifyonplayercommand( "pressToSpawn", "+usereload" );
        self notifyonplayercommand( "pressToSpawn", "+activate" );
        thread waitthensetspawnomnvar();
        self waittill( #"pressToSpawn" );
    }
    
    if ( isdefined( level.bypassclasschoicefunc ) )
    {
        class_choice = self [[ level.bypassclasschoicefunc ]]();
        self.class = class_choice;
        self.pers[ "class" ] = class_choice;
        return;
    }
    
    if ( isbot( self ) )
    {
        self.class = "callback";
        return;
    }
    
    self.class = "class0";
}

// Namespace menus
// Params 0
// Checksum 0x1bbc6fe5, Offset: 0x2deb
// Size: 0x65, Type: bool
function ispresstofirstspawnmode()
{
    if ( getdvarint( @"scr_game_press_to_spawn", 0 ) == 0 )
    {
        return false;
    }
    
    if ( game_utility::isinfectedgametype() || game_utility::function_36ce69a7be195555() )
    {
        return true;
    }
    else if ( game_utility::getgametype() == "dm" && level.aonrules )
    {
        return true;
    }
    else if ( game_utility::getgametype() == "gun" )
    {
        return true;
    }
    
    return false;
}

// Namespace menus
// Params 0
// Checksum 0x12e33d08, Offset: 0x2e59
// Size: 0x22
function waitthensetspawnomnvar()
{
    self endon( #"pressToSpawn" );
    wait 1;
    
    if ( isdefined( self ) )
    {
        lower_message::setlowermessageomnvar( "press_to_spawn" );
    }
}

// Namespace menus
// Params 0
// Checksum 0xd3d05dbb, Offset: 0x2e83
// Size: 0xf
function beginteamchoice()
{
    self setclientomnvar( "ui_open_menu_from_script", 1 );
}

// Namespace menus
// Params 0
// Checksum 0xcc9646b7, Offset: 0x2e9a
// Size: 0x9e
function menuspectator()
{
    if ( self.pers[ "team" ] == "spectator" )
    {
        return;
    }
    
    if ( isalive( self ) )
    {
        assert( isdefined( self.pers[ "<dev string:x1b6>" ] ) );
        self.switching_teams = 1;
        self.joining_team = "spectator";
        self.leaving_team = self.pers[ "team" ];
        self suicide();
    }
    
    addtoteam( "spectator" );
    self.pers[ "class" ] = undefined;
    self.class = undefined;
    thread playerlogic::spawnspectator();
}

// Namespace menus
// Params 1
// Checksum 0x7636b32f, Offset: 0x2f40
// Size: 0x2cd
function menuclass( response )
{
    assert( isdefined( self.pers[ "<dev string:x1b6>" ] ) );
    team = self.pers[ "team" ];
    assert( team == "<dev string:x1c0>" || team == "<dev string:x1bb>" || issubstr( team, "<dev string:x1c7>" ) );
    class = class::getclasschoice( response );
    primary = class::getweaponchoice( response );
    
    if ( class == "restricted" )
    {
        beginclasschoice();
        return;
    }
    
    if ( self.pers[ "class" ] == class && self.pers[ "primary" ] == primary )
    {
        return;
    }
    
    if ( self.sessionstate == "playing" )
    {
        if ( isdefined( self.pers[ "lastClass" ] ) && isdefined( self.pers[ "class" ] ) )
        {
            self.pers[ "lastClass" ] = self.pers[ "class" ];
            self.lastclass = self.pers[ "lastClass" ];
        }
        
        self.pers[ "class" ] = class;
        self.class = class;
        self.pers[ "primary" ] = primary;
        
        if ( game_utility_mp::getgamestate( self ) == "postgame" )
        {
            return;
        }
        
        if ( level.ingraceperiod && !self.hasdonecombat )
        {
            class::setclass( self.pers[ "class" ] );
            self.tag_stowed_back = undefined;
            self.tag_stowed_hip = undefined;
            class::giveloadout( self.pers[ "team" ], self.pers[ "class" ] );
        }
        else
        {
            self iprintlnbold( game[ "strings" ][ "change_class" ] );
        }
    }
    else
    {
        if ( isdefined( self.pers[ "lastClass" ] ) && isdefined( self.pers[ "class" ] ) )
        {
            self.pers[ "lastClass" ] = self.pers[ "class" ];
            self.lastclass = self.pers[ "lastClass" ];
        }
        
        self.pers[ "class" ] = class;
        self.class = class;
        self.pers[ "primary" ] = primary;
        
        if ( game_utility_mp::getgamestate( self ) == "postgame" )
        {
            return;
        }
        
        if ( game_utility_mp::getgamestate( self ) == "playing" && !player::isinkillcam() && !isbrgamemode() )
        {
            thread playerlogic::spawnclient();
        }
    }
    
    thread spectating::setspectatepermissions();
}

// Namespace menus
// Params 4
// Checksum 0x6865e242, Offset: 0x3215
// Size: 0x30a
function addtoteam( team, firstconnect, var_581cd0d7fa68b640, var_dd84696e59b11415 )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isdefined( self.team ) )
    {
        playerlogic::removefromteamcount();
        
        if ( var_581cd0d7fa68b640 )
        {
            playerlogic::decrementalivecount( self.team, undefined, "addToTeam" );
        }
        
        squads::leavesquad( self.team, self.sessionsquadid );
    }
    
    if ( isdefined( self.pers[ "team" ] ) && self.pers[ "team" ] != "" && self.pers[ "team" ] != "spectator" && self.pers[ "team" ] != "codcaster" )
    {
        self.pers[ "last_team" ] = self.pers[ "team" ];
    }
    
    self.changedteams = isdefined( self.pers[ "last_team" ] ) && self.pers[ "last_team" ] != team;
    
    if ( !level.teambased )
    {
        if ( isbot( self ) && team != "allies" && team != "axis" )
        {
            faketeam = utility::cointoss() ? "allies" : "axis";
            self.pers[ "team" ] = faketeam;
            self.team = faketeam;
        }
        else
        {
            self.pers[ "team" ] = team;
            self.team = team;
        }
    }
    else
    {
        self.pers[ "team" ] = team;
        self.team = team;
    }
    
    isbotplayer = isbot( self ) || istestclient( self );
    
    if ( isbotplayer || game_utility_mp::function_de2aaa741c2234e7() )
    {
        setsessionteam( team );
    }
    else if ( !game_utility_mp::denysystemicteamchoice() )
    {
        if ( game_utility_mp::matchmakinggame() && !var_dd84696e59b11415 )
        {
            if ( !game_utility_mp::allowteamassignment() )
            {
                if ( level.gametypebundle.var_f5242bb1aa8222f8 )
                {
                    setsessionteam( team );
                }
            }
        }
        else if ( !function_697873d10bd047e4() )
        {
            setsessionteam( team );
        }
    }
    else if ( getdvarint( @"hash_c11db9baa9e5bc9b", 0 ) > 0 )
    {
        if ( !level.matchmakingmatch )
        {
            setsessionteam( team );
        }
    }
    
    if ( game_utility_mp::getgamestate( self ) != "postgame" )
    {
        playerlogic::addtoteamcount( istrue( var_581cd0d7fa68b640 ) );
    }
    
    game_utility_mp::updateobjectivetext();
    
    if ( firstconnect )
    {
        waittillframeend();
    }
    
    if ( team == "spectator" || team == "codcaster" )
    {
        self notify( #"joined_spectators" );
        teams::onjoinedspectators( self );
        spectating::onjoinedspectators( self );
        bounty::onplayerjoinedspectators( self );
    }
    else
    {
        self notify( #"joined_team" );
    }
    
    join_team_aggregator::onplayerjointeam( self );
    level notify( #"add_to_team", self );
}

// Namespace menus
// Params 1
// Checksum 0x47154711, Offset: 0x3527
// Size: 0x2f
function setsessionteam( teamset )
{
    if ( level.teambased )
    {
        self.sessionteam = teamset;
        return;
    }
    
    setemptysessionteam( teamset );
}

// Namespace menus
// Params 1
// Checksum 0x9f53b504, Offset: 0x355e
// Size: 0x52
function setemptysessionteam( teamset )
{
    if ( teamset == "spectator" )
    {
        self.sessionteam = "spectator";
        return;
    }
    
    if ( teamset == "codcaster" )
    {
        self.sessionteam = "codcaster";
        return;
    }
    
    self.sessionteam = "none";
}

// Namespace menus
// Params 0
// Checksum 0x162a2b85, Offset: 0x35b8
// Size: 0x18
function endrespawnnotify()
{
    self.waitingtospawn = 0;
    self notify( #"hash_39d42ba422f7792f" );
}

// Namespace menus
// Params 1
// Checksum 0xff7cb7b9, Offset: 0x35d8
// Size: 0x43
function logteamselection( teamselection )
{
    if ( getdvarint( @"scr_playtest", 0 ) == 0 )
    {
        return;
    }
    
    if ( teamselection != "random" )
    {
        iprintlnbold( string( self.name ) + " did not select auto-assign" );
    }
}

// Namespace menus
// Params 0
// Checksum 0xee7e12b8, Offset: 0x3623
// Size: 0x298
function debugprintsquads()
{
    stepy = 25;
    
    while ( true )
    {
        if ( isdefined( level.squaddata ) )
        {
            startx = 800;
            starty = 25;
            linecount = 1;
            
            /#
                printtoscreen2d( startx + 250, starty, "<dev string:x1cd>", ( 1, 1, 1 ), 1 );
            #/
            
            foreach ( team, squadarray in level.squaddata )
            {
                linecount = 1;
                
                /#
                    printtoscreen2d( startx, starty + stepy * linecount, "<dev string:x1d8>" + team, ( 1, 1, 1 ), 1 );
                #/
                
                linecount++;
                
                foreach ( squad in squadarray )
                {
                    color = ( 1, 1, 1 );
                    
                    if ( isdefined( squad.activemission ) )
                    {
                        color = ( 1, 1, 0 );
                    }
                    
                    /#
                        printtoscreen2d( startx + 25, starty + stepy * linecount, "<dev string:x1df>" + squad.index, color, 1 );
                    #/
                    
                    linecount++;
                    
                    foreach ( player in squad.players )
                    {
                        color = ( 1, 1, 1 );
                        
                        if ( player.squadassignedfromlobby )
                        {
                            color = ( 0, 1, 0 );
                        }
                        
                        /#
                            printtoscreen2d( startx + 50, starty + stepy * linecount, player.name, color, 1 );
                        #/
                        
                        linecount++;
                    }
                }
                
                startx += 200;
            }
        }
        
        waitframe();
    }
}

