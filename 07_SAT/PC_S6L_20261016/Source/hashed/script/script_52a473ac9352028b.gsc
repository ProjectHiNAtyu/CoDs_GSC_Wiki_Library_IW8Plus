// script_52a473ac9352028b  (hash_52a473ac9352028b.gscc) (size: 22306 Bytes / 0x5722 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb52685ff (3039200767)
// size ...... 22306 (0x5722)
// includes .. 17  (offset: 0x509e)
// strings ... 41  (offset: 0x5126)
// dev strs .. 69  (offset: 0x5386)
// exports ... 48  (offset: 0x343e)
// cseg ...... 0x27a + 0x31c4 (0x343e)
// imports ... 171 (offset: 0x3bbe)
// animtree1 . 0   (offset: 0x5722)
// animtree2 . 0   (offset: 0x5722)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\emote;
#using scripts\mp\final_killcam;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\operator;
#using scripts\mp\playerlogic;
#using scripts\mp\scene;
#using scripts\mp\weapons;

#namespace winners_circle;

/#

    // Namespace winners_circle
    // Params 0
    // Checksum 0x64deab0c, Offset: 0x298
    // Size: 0x10b, Type: dev
    function get_debug_defaults()
    {
        defaults = spawnstruct();
        project = getprojectname();
        
        if ( project == "<dev string:x24>" )
        {
            defaults.default_rifle = "<dev string:x28>";
            defaults.default_shotgun = "<dev string:x3f>";
            defaults.default_launcher = "<dev string:x56>";
            defaults.default_pistol = "<dev string:x6c>";
            defaults.var_dac25cb7956cdef7 = "<dev string:x82>";
            defaults.var_1586c6f7611b1514 = "<dev string:x9b>";
        }
        else if ( project == "<dev string:xb4>" )
        {
            defaults.default_rifle = "<dev string:xb8>";
            defaults.default_shotgun = "<dev string:xc8>";
            defaults.default_launcher = "<dev string:xd8>";
            defaults.default_pistol = "<dev string:xe8>";
            defaults.var_dac25cb7956cdef7 = "<dev string:xf8>";
            defaults.var_1586c6f7611b1514 = "<dev string:x112>";
        }
        
        return defaults;
    }

#/

// Namespace winners_circle
// Params 0, eflags: 0x1
// Checksum 0x28b63bc4, Offset: 0x3ab
// Size: 0x153
function autoexec main()
{
    if ( level.gametypebundle.winnerscircletype != #"hash_1dc2d22a8a4f0439" )
    {
        return;
    }
    
    if ( !isdefined( level.winners_circle ) )
    {
        level.winners_circle = spawnstruct();
    }
    
    level.winners_circle.init = &init_winners_circle;
    level.winners_circle.hint = &function_ab03adf6704a6f36;
    level.winners_circle.start = &start_winners_circle;
    level.winners_circle.end = &end;
    utility::flag_set( "winners_circle_initialized" );
    callback::add( #"player_death", &on_player_death );
    
    if ( level.gamemodebundle.var_2fc669d4ccb1f63e )
    {
        callback::add( #"elimination_assist", &on_player_elimination_assist );
    }
    
    while ( !game[ "flags" ] )
    {
        waitframe();
    }
    
    flags::gameflaginit( "winners_circle_finalized", 0 );
    utility::registersharedfunc( #"winners_circle", #"hash_4f3082ac2c8b6511", &function_1f47b22a06c332a4 );
    
    /#
        setdevdvarifuninitialized( @"hash_22600991c9c4fc67", "<dev string:x12c>" );
        setdevdvarifuninitialized( @"scr_debug_start_winners_circle", 0 );
        level thread dev_winners_circle();
    #/
}

// Namespace winners_circle
// Params 0, eflags: 0x4
// Checksum 0x44893351, Offset: 0x506
// Size: 0xf
function private function_1f47b22a06c332a4()
{
    level flags::gameflagset( "winners_circle_finalized" );
}

// Namespace winners_circle
// Params 1
// Checksum 0xe4d513d0, Offset: 0x51d
// Size: 0x7b
function function_ab03adf6704a6f36( durationms )
{
    if ( !isdefined( level.gametypebundle.winnerscircle ) || level.gametypebundle.winnerscircle == %"" )
    {
        return;
    }
    
    winnerscirclebundle = getscriptbundle( level.gametypebundle.winnerscircle );
    
    if ( !isdefined( winnerscirclebundle ) )
    {
        return;
    }
    
    function_1d2cf869357d3083( winnerscirclebundle, durationms );
}

// Namespace winners_circle
// Params 2, eflags: 0x4
// Checksum 0xcc81969e, Offset: 0x5a0
// Size: 0xdf
function private function_1d2cf869357d3083( winnerscirclebundle, durationms = 30000 )
{
    foreach ( sceneref in [ winnerscirclebundle.scene, winnerscirclebundle.sceneduo, winnerscirclebundle.scenequad ] )
    {
        if ( !sceneref )
        {
            continue;
        }
        
        hintroot = { #script_scenescriptbundle:sceneref };
        hintroot scene::function_c411ae921fa2bd3c( 0, durationms );
    }
}

// Namespace winners_circle
// Params 1
// Checksum 0xbf46ee80, Offset: 0x687
// Size: 0x1bf, Type: bool
function function_9f055e496c344f9b( winner )
{
    if ( isdefined( level.topplayers ) && level.topplayers.size > 0 )
    {
        return true;
    }
    
    bundle = getscriptbundle( level.gametypebundle.winnerscircle );
    
    if ( bundle.var_e59b95412f4b8179 == #"hash_6e0370101af249d4" )
    {
        assert( level.teambased, "<dev string:x12d>" + "<dev string:x13d>" );
        
        if ( isdefined( winner ) && winner != "tie" )
        {
            if ( !teams::function_b00ab7e503f33379( winner, "players" ) )
            {
                return false;
            }
            
            winningteamplayers = teams::getteamdata( winner, "players" );
            
            if ( isdefined( winningteamplayers ) )
            {
                level.topplayers = arraysort( winningteamplayers, undefined, &compare_player_score );
            }
        }
        else
        {
            alliesscore = getteamscore( "allies" );
            axisscore = getteamscore( "axis" );
            
            if ( alliesscore == axisscore )
            {
                level.topplayers = arraysort( level.players, undefined, &compare_player_score );
            }
            else
            {
                winningteam = alliesscore >= axisscore ? "allies" : "axis";
                winningteamplayers = teams::getteamdata( winningteam, "players" );
                
                if ( isdefined( winningteamplayers ) )
                {
                    level.topplayers = arraysort( winningteamplayers, undefined, &compare_player_score );
                }
            }
        }
    }
    else if ( bundle.var_e59b95412f4b8179 == #"top_scores" || bundle.var_e59b95412f4b8179 == #"all_players_in_squad" )
    {
        level.topplayers = level.placement[ "all" ];
    }
    
    return true;
}

// Namespace winners_circle
// Params 0
// Checksum 0xcb5716e0, Offset: 0x84f
// Size: 0x6f, Type: bool
function function_ede1c1983085636c()
{
    if ( self.connectedpostgame )
    {
        return true;
    }
    
    if ( !isdefined( self.timeplayed ) || self.timeplayed[ "total" ] < 1 || self.pers[ "participation" ] < 1 )
    {
        return true;
    }
    
    if ( !self.pers[ "hasDoneAnyCombat" ] )
    {
        return true;
    }
    
    return !isdefined( level.placement );
}

// Namespace winners_circle
// Params 1, eflags: 0x4
// Checksum 0x62d0b273, Offset: 0x8c7
// Size: 0x231, Type: bool
function private init_winners_circle( winner )
{
    disablewinnerscircle = getdvarint( @"hash_a86ae0a461e6f355" ) || level.no_winners_circle;
    
    if ( !!disablewinnerscircle )
    {
        println( "<dev string:x12d>" + "<dev string:x17d>" + "<dev string:x199>" );
        return false;
    }
    
    mapinfo = getactivemapinfobundle();
    
    if ( !!mapinfo.disablewinnerscircle )
    {
        println( "<dev string:x12d>" + "<dev string:x17d>" + "<dev string:x1e3>" + mapinfo.mapname );
        return false;
    }
    
    if ( !( isdefined( level.gametypebundle.winnerscircle ) && level.gametypebundle.winnerscircle != %"" ) )
    {
        println( "<dev string:x12d>" + "<dev string:x17d>" + "<dev string:x212>" );
        return false;
    }
    
    winnerscirclebundle = getscriptbundle( level.gametypebundle.winnerscircle );
    
    if ( !isdefined( winnerscirclebundle ) )
    {
        println( "<dev string:x12d>" + "<dev string:x17d>" + "<dev string:x23a>" + getxhashsourcename( level.gametypebundle.winnerscircle ) + "<dev string:x260>" );
        return false;
    }
    
    if ( !( winnerscirclebundle.var_4311c295be6fc160 > 0 ) )
    {
        println( "<dev string:x12d>" + "<dev string:x17d>" + "<dev string:x26c>" );
        return false;
    }
    
    if ( !function_9f055e496c344f9b( winner ) )
    {
        return false;
    }
    
    if ( !( isdefined( level.topplayers ) && level.topplayers.size > 0 ) )
    {
        println( "<dev string:x12d>" + "<dev string:x17d>" + "<dev string:x2a5>" );
        return false;
    }
    
    if ( !!level.nukeinfo.detonated )
    {
        println( "<dev string:x12d>" + "<dev string:x17d>" + "<dev string:x2b7>" );
        return false;
    }
    
    if ( isdefined( winnerscirclebundle.postfxbundle ) )
    {
        pbgpostfxbundlestart( #"all", winnerscirclebundle.postfxbundle );
    }
    
    function_1d2cf869357d3083( winnerscirclebundle );
    level.mvparray = [];
    return true;
}

// Namespace winners_circle
// Params 1
// Checksum 0xcb74a129, Offset: 0xb01
// Size: 0x53d
function start_winners_circle( winner )
{
    winnerscirclebundle = getscriptbundle( level.gametypebundle.winnerscircle );
    level notify( #"winners_circle_start" );
    
    if ( !isdefined( winner ) )
    {
        winner = self;
    }
    
    level.winners_circle.running = 1;
    level callback::callback( #"hash_b233ef33659b25b5" );
    cleanupequipment();
    cleanupgamemodes();
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player playerlogic::respawn_asspectator( ( 0, 0, 0 ), ( 0, 0, 0 ) );
        player gamelogic_mp::freezeplayerforroundend();
        player player_utility::function_dbe5a52a6654a982();
        player player_utility::function_9d378d725bb4831e( "broshot::startBroshot()" );
        player playlocalsound( "uin_winnerscircle_enter" );
        
        if ( isdefined( winnerscirclebundle.var_49bdf28ee8e84e1d ) )
        {
            player setsoundsubmix( winnerscirclebundle.var_49bdf28ee8e84e1d, 0.5 );
        }
        
        player function_46adb77d568554c4( 1 );
    }
    
    removeallcorpses();
    var_67acf27ef25fbd91 = int( min( winnerscirclebundle.var_4311c295be6fc160, level.topplayers.size ) );
    
    for ( i = 0; i < winnerscirclebundle.var_4311c295be6fc160 ; i++ )
    {
        podiumplayer = undefined;
        
        if ( i < var_67acf27ef25fbd91 )
        {
            podiumplayer = level.topplayers[ i ];
        }
        
        if ( !isdefined( podiumplayer ) )
        {
            break;
        }
        
        if ( !isdefined( podiumplayer.loadoutarchetype ) )
        {
            continue;
        }
        
        level.mvparray[ i ] = podiumplayer function_a22ba6123487778d();
        podiumplayer.var_ac59c6f71b1d8c9b = 1;
        waitframe();
    }
    
    createprops();
    var_d3dda4e17fb2c0d9 = { #script_scenescriptbundle:function_998d5168ffe921e( winnerscirclebundle ) };
    level.winners_circle.var_880618a360818ee4 = var_d3dda4e17fb2c0d9 scene::function_c411ae921fa2bd3c( 0, 30000 );
    
    /#
        forceplayercount = getdvarint( @"hash_5b6dd91b900da0fb", 0 );
        
        if ( forceplayercount > 0 )
        {
            for ( i = 1; i < max( winnerscirclebundle.var_4311c295be6fc160, forceplayercount ) ; i++ )
            {
                if ( forceplayercount < i + 1 )
                {
                    level.mvparray[ i ] = undefined;
                    continue;
                }
                
                if ( !isdefined( level.mvparray[ i ] ) )
                {
                    level.mvparray[ i ] = structcopy( level.mvparray[ i - 1 ] );
                }
            }
        }
    #/
    
    foreach ( player in level.players )
    {
        player setsolid( 0 );
        player dontinterpolate();
        
        if ( isbot( player ) || isai( player ) )
        {
            continue;
        }
        
        player visionsetnakedforplayer( "", 0 );
    }
    
    seasonalwinnerscircle = utility::callsharedfunc( #"seasonalevents", #"hash_b798047a7a76866f" );
    
    if ( isdefined( seasonalwinnerscircle ) )
    {
        setsuncolorandintensity( 0 );
        player_utility::_visionsetnaked( "mp_t10_winners_circle", 0 );
    }
    
    assert( !final_killcam::anyplayersinkillcam() );
    assert( !level.showingfinalkillcam );
    level thread onplayerconnect();
    
    if ( level.winners_circle.var_880618a360818ee4 >= 0 )
    {
        for ( pollcount = 0; pollcount < 20 ; pollcount++ )
        {
            if ( function_d56db8b35cc9ce12( level.winners_circle.var_880618a360818ee4 ) )
            {
                break;
            }
            
            wait 0.1;
        }
    }
    
    var_e928656a8951fae4 = getdvarfloat( @"hash_1ffdc4808a287434", 5 );
    var_c2e33419f64fbf0a = winnerscirclebundle.var_57749f252e323540;
    
    if ( var_e928656a8951fae4 >= 8 )
    {
        setomnvar( "ui_winners_circle_play_emote", 0 );
        thread playscene( [ "intro_walk_in", "idle", "outro" ], 1, 1 );
        wait var_c2e33419f64fbf0a;
        setomnvar( "ui_winners_circle_play_emote", 1 );
    }
    else
    {
        setomnvar( "ui_winners_circle_play_emote", 0 );
        thread playscene( [ "intro_walk_in", "idle" ], 1, 0 );
        introduration = function_8e2674f1644a7a0e( 0 );
        adjustedtime = introduration + var_e928656a8951fae4;
        wait var_c2e33419f64fbf0a;
        setomnvar( "ui_winners_circle_play_emote", 1 );
        wait adjustedtime - var_c2e33419f64fbf0a;
        function_88d8680887e23b1f();
        thread playscene( [ "outro" ], 0, 1 );
    }
    
    /#
        level.forcing_winners_circle = 0;
    #/
}

// Namespace winners_circle
// Params 0
// Checksum 0x4e350dd4, Offset: 0x1046
// Size: 0xb2
function function_a22ba6123487778d()
{
    podiumplayer = self;
    
    if ( !isdefined( podiumplayer.operatorcustomization ) )
    {
        podiumplayer operator::createoperatorcustomization();
    }
    
    arrayentry = spawnstruct();
    arrayentry.operatorref = podiumplayer.operatorcustomization.operatorref;
    arrayentry.skinref = podiumplayer.operatorcustomization.skinref;
    arrayentry.weaponname = getdisplayweapon( podiumplayer );
    arrayentry.xuid = podiumplayer getxuid();
    arrayentry.clientnum = podiumplayer getplayerclientnum();
    return arrayentry;
}

// Namespace winners_circle
// Params 0
// Checksum 0x88f30874, Offset: 0x1101
// Size: 0x85
function function_33328428535ade85()
{
    wait 0.5;
    
    foreach ( player in level.players )
    {
        game_utility::fadetoblackforplayer( player, 0, 0, 1 );
    }
}

// Namespace winners_circle
// Params 0, eflags: 0x4
// Checksum 0xc011cf8a, Offset: 0x118e
// Size: 0x30
function private createprops()
{
    level.winners_circle.props = [];
    level callback::callback( #"add_prop", {} );
    function_8f3febc2684a6f0d();
}

// Namespace winners_circle
// Params 0, eflags: 0x4
// Checksum 0x40480bdc, Offset: 0x11c6
// Size: 0xa1
function private removeprops()
{
    foreach ( entry in level.winners_circle.props )
    {
        entry.propent delete();
    }
    
    level.winners_circle.props = [];
}

// Namespace winners_circle
// Params 5
// Checksum 0x8eb69aaa, Offset: 0x126f
// Size: 0x186
function function_cc56989917277586( dvar, model, position, angles, scale )
{
    anchorent = utility::getstruct( "camera_winners_circle_sat" );
    
    if ( getdvarint( dvar, 0 ) == 1 )
    {
        if ( anchorent )
        {
            entry = { #scale:scale, #angles:anchorent.angles + angles, #position:anchorent.origin + position, #model:model };
            
            if ( !isdefined( level.winners_circle.props ) )
            {
                level.winners_circle.props = [];
            }
            
            level.winners_circle.props[ level.winners_circle.props.size ] = entry;
            return;
        }
        
        entry = { #scale:scale, #angles:angles, #position:position, #model:model };
        
        if ( !isdefined( level.winners_circle.props ) )
        {
            level.winners_circle.props = [];
        }
        
        level.winners_circle.props[ level.winners_circle.props.size ] = entry;
    }
}

// Namespace winners_circle
// Params 0, eflags: 0x4
// Checksum 0xaa332ae6, Offset: 0x13fd
// Size: 0xf4
function private function_8f3febc2684a6f0d()
{
    foreach ( entry in level.winners_circle.props )
    {
        propent = spawn( "script_model", entry.position );
        
        if ( entry.scale != 1 )
        {
            propent setscale( entry.scale );
        }
        
        propent setmodel( entry.model );
        propent.angles = entry.angles;
        entry.propent = propent;
    }
}

// Namespace winners_circle
// Params 1, eflags: 0x4
// Checksum 0x40a2a28e, Offset: 0x14f9
// Size: 0x56
function private function_998d5168ffe921e( bundle )
{
    if ( level.mvparray.size == 2 )
    {
        return bundle.sceneduo;
    }
    
    if ( level.mvparray.size == 4 )
    {
        return bundle.scenequad;
    }
    
    return bundle.scene;
}

// Namespace winners_circle
// Params 3
// Checksum 0x6f2bea85, Offset: 0x1557
// Size: 0x20a
function playscene( shotnames, doinitialization, var_9ca876016eb9ac82 )
{
    seasonalwinnerscircle = utility::callsharedfunc( #"seasonalevents", #"hash_b798047a7a76866f" );
    var_b2ca89ebb838e17f = seasonalwinnerscircle.align_ent ?? {};
    sceneroot = structcopy( var_b2ca89ebb838e17f, 1 );
    level.winners_circle.sceneroot = sceneroot;
    
    if ( isdefined( sceneroot ) )
    {
        winnerscircledata = seasonalwinnerscircle.bundledata.winnerscircledata;
        
        if ( isdefined( winnerscircledata ) )
        {
            sceneroot.script_scenescriptbundle = function_998d5168ffe921e( getscriptbundle( winnerscircledata.winnerscircle ) );
        }
        else
        {
            sceneroot.script_scenescriptbundle = function_998d5168ffe921e( getscriptbundle( level.gametypebundle.winnerscircle ) );
        }
        
        /#
            function_dcb7869500d17fd9();
        #/
        
        if ( doinitialization )
        {
            scenecharacters = sceneroot scene::function_48ea223b2dfda0();
            
            foreach ( index, entry in level.mvparray )
            {
                entry.characterindex = scenecharacters[ index ].characterindex;
            }
            
            scene::function_e96a757b2bdad619( -1, level.mvparray );
            function_d3ec1a849e5412aa();
            thread function_33328428535ade85();
        }
        
        sceneroot scene::play( undefined, shotnames, sceneroot.script_scenescriptbundle );
    }
    
    if ( var_9ca876016eb9ac82 )
    {
        level callback::callback( #"hash_1beecfc58b54378c" );
        level flags::gameflagset( "winners_circle_finalized" );
        level notify( #"winners_circle_end" );
    }
}

// Namespace winners_circle
// Params 1
// Checksum 0x943e6fd8, Offset: 0x1769
// Size: 0x27
function function_8e2674f1644a7a0e( shotindex )
{
    return level.winners_circle.sceneroot scene::function_b3c7b792a7a154fa( shotindex );
}

// Namespace winners_circle
// Params 0
// Checksum 0x9a46a4e, Offset: 0x1799
// Size: 0x1c
function function_88d8680887e23b1f()
{
    level.winners_circle.sceneroot scene::stop();
}

// Namespace winners_circle
// Params 0
// Checksum 0x83a70418, Offset: 0x17bd
// Size: 0x99
function cleanupequipment()
{
    self notify( #"bro_shot_start" );
    weapons::deleteallgrenades();
    dropped_weapons = getweaponarray();
    
    if ( isdefined( dropped_weapons ) )
    {
        foreach ( droppeditem in dropped_weapons )
        {
            droppeditem delete();
        }
    }
}

// Namespace winners_circle
// Params 0
// Checksum 0xa75a2850, Offset: 0x185e
// Size: 0x778
function cleanupgamemodes()
{
    if ( isdefined( level.teamflags ) )
    {
        if ( isdefined( level.teamflags[ game[ "attackers" ] ] ) && isdefined( level.teamflags[ game[ "attackers" ] ].visuals ) )
        {
            for ( index = 0; index < level.teamflags[ game[ "attackers" ] ].visuals.size ; index++ )
            {
                level.teamflags[ game[ "attackers" ] ].visuals[ index ] hide();
            }
        }
        
        if ( isdefined( level.teamflags[ game[ "defenders" ] ] ) && isdefined( level.teamflags[ game[ "defenders" ] ].visuals ) )
        {
            for ( index = 0; index < level.teamflags[ game[ "defenders" ] ].visuals.size ; index++ )
            {
                level.teamflags[ game[ "defenders" ] ].visuals[ index ] hide();
            }
        }
    }
    
    if ( ( game_utility::getgametype() == "dom" || game_utility::getgametype() == "siege" ) && isdefined( level.objectives ) )
    {
        foreach ( flag in level.objectives )
        {
            if ( isdefined( flag ) )
            {
                flag.scriptable setscriptablepartstate( "flag", "off" );
                flag.scriptable setscriptablepartstate( "pulse", "off" );
            }
        }
    }
    
    if ( game_utility::getgametype() == "grind" && isdefined( level.objectives ) )
    {
        foreach ( zone in level.objectives )
        {
            if ( isdefined( zone ) && isdefined( zone.scriptable ) )
            {
                zone.scriptable setscriptablepartstate( "flag", "off" );
                zone.scriptable setscriptablepartstate( "pulse", "off" );
            }
        }
    }
    
    if ( ( game_utility::getgametype() == "sr" || game_utility::getgametype() == "dd" | game_utility::getgametype() == "sd" ) && isdefined( level.objectives ) )
    {
        foreach ( bombzone in level.objectives )
        {
            if ( isdefined( bombzone ) && isdefined( bombzone.visuals ) )
            {
                for ( i = 0; i < bombzone.visuals.size ; i++ )
                {
                    if ( isdefined( bombzone.visuals[ i ] ) )
                    {
                        bombzone.visuals[ i ] hide();
                    }
                }
            }
        }
    }
    
    if ( game_utility::getgametype() == "front" && isdefined( level.zones ) )
    {
        foreach ( zone in level.zones )
        {
            if ( isdefined( zone ) && isdefined( zone.visuals ) )
            {
                for ( i = 0; i < zone.visuals.size ; i++ )
                {
                    zone.visuals[ i ] hide();
                }
            }
        }
    }
    
    if ( level.dogtagsenabled )
    {
        if ( isdefined( level.dogtags ) )
        {
            foreach ( tag in level.dogtags )
            {
                if ( isdefined( tag ) && isdefined( tag.visuals ) )
                {
                    for ( i = 0; i < tag.visuals.size ; i++ )
                    {
                        tag.visuals[ i ] hide();
                    }
                }
            }
        }
    }
    
    if ( isdefined( level.balls ) )
    {
        foreach ( ball in level.balls )
        {
            ball.visuals[ 0 ] setscriptablepartstate( "uplink_drone_hide", "hide", 0 );
        }
    }
    
    if ( ( game_utility::getgametype() == "koth" || game_utility::getgametype() == "grnd" ) && isdefined( level.zones ) )
    {
        foreach ( zone in level.zones )
        {
            if ( isdefined( zone ) && isdefined( zone.useobj ) && isdefined( zone.useobj.chevrons ) )
            {
                foreach ( chevron in zone.useobj.chevrons )
                {
                    for ( i = 0; i < chevron.numchevrons ; i++ )
                    {
                        chevron setscriptablepartstate( "chevron_" + i + ( level.gametypebundle.var_45b9f58d54501ba6 ?? "" ), "off" );
                    }
                }
            }
        }
    }
}

// Namespace winners_circle
// Params 1
// Checksum 0x714139bc, Offset: 0x1fde
// Size: 0x103, Type: bool
function function_43fef757978b336b( weaponobj )
{
    if ( !isdefined( weaponobj ) )
    {
        return false;
    }
    
    iskillstreakweaponfunc = level.sharedfuncs[ #"killstreak" ][ #"iskillstreakweapon" ];
    
    if ( isdefined( iskillstreakweaponfunc ) && self [[ iskillstreakweaponfunc ]]( weaponobj.basename ) )
    {
        return false;
    }
    
    weaponroot = weapon::function_170e300815e9c1a2( weaponobj );
    weaponclassdata = weapon::function_c37ac3c4f987e506( weaponroot, #"classdata" );
    
    if ( isdefined( weaponclassdata ) )
    {
        classallowed = getscriptbundlefieldvalue( hashcat( %"hash_231e89190f5116c0", weaponclassdata ), #"hash_6e2a2b96411583cf" );
        
        if ( !classallowed )
        {
            return false;
        }
    }
    
    isbulletweaponfunc = level.sharedfuncs[ #"weapons" ][ #"isbulletweapon" ];
    
    if ( isdefined( isbulletweaponfunc ) )
    {
        isbulletweapon = self [[ isbulletweaponfunc ]]( weaponobj );
        
        if ( !isbulletweapon )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace winners_circle
// Params 1
// Checksum 0x7f281099, Offset: 0x20ea
// Size: 0x29
function on_player_death( params )
{
    function_54746be585bd6d4e( params.attacker, params.objweapon );
}

// Namespace winners_circle
// Params 1
// Checksum 0x5007d3d8, Offset: 0x211b
// Size: 0x1f
function on_player_elimination_assist( params )
{
    function_54746be585bd6d4e( self, params.attackerweaponobj );
}

// Namespace winners_circle
// Params 2, eflags: 0x4
// Checksum 0xb4cfeff7, Offset: 0x2142
// Size: 0xd8
function private function_54746be585bd6d4e( attacker, uniqueweapon )
{
    if ( !isdefined( uniqueweapon ) )
    {
        return;
    }
    
    if ( level.var_7da35fa2727d3296[ uniqueweapon.basenamehash ] )
    {
        return;
    }
    
    var_d1251b9f4f46a29f = function_cd1055ce34a1d236( uniqueweapon, #"attachmentsonly" );
    
    if ( attacker.var_c39cf144494d7cb[ var_d1251b9f4f46a29f ] || function_43fef757978b336b( uniqueweapon ) )
    {
        if ( !isdefined( attacker.var_c39cf144494d7cb[ var_d1251b9f4f46a29f ] ) )
        {
            attacker.var_c39cf144494d7cb[ var_d1251b9f4f46a29f ] = { #elims:0, #weaponobj:uniqueweapon };
        }
        
        attacker.var_c39cf144494d7cb[ var_d1251b9f4f46a29f ].elims++;
        return;
    }
    
    level.var_7da35fa2727d3296[ uniqueweapon.basenamehash ] = 1;
}

// Namespace winners_circle
// Params 0, eflags: 0x4
// Checksum 0x348f2c34, Offset: 0x2222
// Size: 0x57
function private function_51f2f64aadfa31cc()
{
    gamemodebundle = getgamemodescriptbundle();
    
    if ( isdefined( gamemodebundle ) && isdefined( gamemodebundle.weaponlist ) )
    {
        weaponlistbundle = getscriptbundle( gamemodebundle.weaponlist );
        return weapon::weaponassetnamemap( weaponlistbundle.defaultprimaryweapon );
    }
    
    return "none";
}

// Namespace winners_circle
// Params 1
// Checksum 0xa7e81284, Offset: 0x2282
// Size: 0x102
function getdisplayweapon( player )
{
    displayweapon = weapon_utility::function_d2c8356dc369d9ce( function_51f2f64aadfa31cc() );
    maxelims = 0;
    
    if ( !isdefined( player.var_c39cf144494d7cb ) )
    {
        player.var_c39cf144494d7cb = [];
    }
    
    foreach ( weapondata in player.var_c39cf144494d7cb )
    {
        if ( !isdefined( weapondata.elims ) )
        {
            continue;
        }
        
        if ( !isdefined( displayweapon ) || weapondata.elims > maxelims )
        {
            displayweapon = weapondata.weaponobj;
            maxelims = weapondata.elims;
        }
    }
    
    return displayweapon;
}

// Namespace winners_circle
// Params 0
// Checksum 0x280c57e5, Offset: 0x238d
// Size: 0x1e5
function end()
{
    winnerscirclebundle = getscriptbundle( level.gametypebundle.winnerscircle );
    level.winners_circle.running = undefined;
    level.winners_circle.sceneroot scene::cleanup( 1 );
    
    if ( isdefined( winnerscirclebundle.postfxbundle ) )
    {
        pbgpostfxbundleend( #"all", winnerscirclebundle.postfxbundle );
    }
    
    foreach ( player in level.players )
    {
        player function_46adb77d568554c4( 0 );
    }
    
    removeprops();
    
    if ( getdvarint( @"hash_d2b1ee37dc8b03d1", 0 ) == 0 && level.var_6ee986c6c0f5d22c )
    {
        cament = spawn( "script_model", function_7faf58aa7593224b().origin );
        cament setmodel( "tag_origin" );
        cament.angles = function_7faf58aa7593224b().angles;
        
        foreach ( player in level.players )
        {
            player cameralinkto( cament, "tag_origin" );
        }
    }
    
    self notify( #"winners_circle_done" );
}

// Namespace winners_circle
// Params 2
// Checksum 0x587fb20a, Offset: 0x257a
// Size: 0x2c, Type: bool
function compare_player_score( left, right )
{
    return left.score >= right.score;
}

// Namespace winners_circle
// Params 0
// Checksum 0x9cbdd33f, Offset: 0x25af
// Size: 0x3d
function onplayerconnect()
{
    self endon( #"winners_circle_done" );
    
    for ( ;; )
    {
        level waittill( #"connected", player );
        
        if ( !isai( player ) )
        {
            thread startlatejoinpodium( player );
        }
    }
}

// Namespace winners_circle
// Params 1
// Checksum 0x305e0df0, Offset: 0x25f4
// Size: 0x64
function startlatejoinpodium( player )
{
    player endon( #"disconnect" );
    wait 0.25;
    assert( !final_killcam::anyplayersinkillcam() );
    assert( !level.showingfinalkillcam );
    clientindex = player getentitynumber();
    scene::function_e96a757b2bdad619( clientindex, level.mvparray );
}

// Namespace winners_circle
// Params 0
// Checksum 0xa2ef225b, Offset: 0x2660
// Size: 0x9e
function function_d3ec1a849e5412aa()
{
    topplayers = level.topplayers;
    var_c1a29f3b4d79f4f3 = getscriptbundle( level.gametypebundle.winnerscircle ).var_4311c295be6fc160;
    
    for ( i = 0; i < var_c1a29f3b4d79f4f3 ; i++ )
    {
        if ( !isdefined( topplayers[ i ] ) || isbot( topplayers[ i ] ) || !arraycontains( level.players, topplayers[ i ] ) )
        {
            continue;
        }
        
        topplayers[ i ] thread function_fbd68bef9d885c24( i );
    }
    
    /#
        function_b41935d434bf0228();
    #/
}

// Namespace winners_circle
// Params 1
// Checksum 0x114d1d1, Offset: 0x2706
// Size: 0x86
function function_fbd68bef9d885c24( podiumplayerindex )
{
    self endon( #"winners_circle_done" );
    
    while ( true )
    {
        self waittill( #"luinotifyserver", message, slotindex );
        
        if ( message == "try_emote3p" )
        {
            emoteref = emote::function_d97161a916a220af( slotindex );
            emoteindex = emote::function_205b1d52b38d3b0e( emoteref );
            thread emote::function_e517ecb74bbd6b77( level.players, podiumplayerindex, emoteindex );
            waitframe();
        }
    }
}

// Namespace winners_circle
// Params 1
// Checksum 0x4239ee61, Offset: 0x2794
// Size: 0x9a
function function_46adb77d568554c4( toggle )
{
    if ( getdvarint( @"hash_a61ef81e13915aa9", 0 ) != 0 )
    {
        return;
    }
    
    player = self;
    winnerscirclebundle = getscriptbundle( level.gametypebundle.winnerscircle );
    hwconfig = player isconsoleplayer() ? winnerscirclebundle.var_52667d502c288f98 : winnerscirclebundle.var_2b23c19a8882cad4;
    
    if ( !isdefined( hwconfig ) )
    {
        return;
    }
    
    if ( toggle )
    {
        player function_a565dafac620d68e( hwconfig );
        return;
    }
    
    player function_72cf2eee8e035013( hwconfig );
}

// Namespace winners_circle
// Params 0
// Checksum 0x963f9371, Offset: 0x2836
// Size: 0x6d
function function_7faf58aa7593224b()
{
    if ( isdefined( level.respawndata[ "axis" ] ) )
    {
        return level.respawndata[ "axis" ];
    }
    
    specpoint = spawnstruct();
    specpoint.origin = ( 0, 0, 1000 );
    specpoint.angles = ( 0, 0, 0 );
    return specpoint;
}

/#

    // Namespace winners_circle
    // Params 0, eflags: 0x4
    // Checksum 0xad58be2e, Offset: 0x28ab
    // Size: 0x39, Type: dev
    function private force_init()
    {
        level.forcing_winners_circle = 1;
        setomnvar( "<dev string:x2c7>", 1 );
        setdevdvar( @"scr_devchangetimelimit", 0 );
        function_acf5911e39c5e22b();
        return init_winners_circle();
    }

    // Namespace winners_circle
    // Params 0
    // Checksum 0x63bda8f9, Offset: 0x28ec
    // Size: 0x1b3, Type: dev
    function function_dcb7869500d17fd9()
    {
        foreach ( index, entry in level.mvparray )
        {
            skinref = getdvar( hashcat( @"hash_c4abf422b398a1b8", index ) );
            weaponname = getdvar( hashcat( @"hash_200fa138f42e6ffb", index ) );
            weapon = undefined;
            
            if ( isstring( weaponname ) && weaponname != "<dev string:x12c>" )
            {
                weapon = weapon_utility::function_d2c8356dc369d9ce( weaponname );
            }
            
            if ( isstring( skinref ) && skinref.size > 0 )
            {
                entry.skinref = getxhashasset( skinref );
                entry.operatorref = operator::function_30f20ce375c4ee40( skinref );
                
                /#
                    foreach ( player in level.players )
                    {
                        player setoperatorcustomization( entry.operatorref, entry.skinref );
                    }
                #/
            }
            
            if ( isdefined( weapon ) )
            {
                entry.weaponname = weapon;
            }
        }
    }

    // Namespace winners_circle
    // Params 1
    // Checksum 0xa492b63, Offset: 0x2aa7
    // Size: 0x88, Type: dev
    function function_ff279ad09f39cc3c( params )
    {
        if ( isdefined( level.players[ 0 ] ) )
        {
            debugteamindex = level.players[ 0 ].team == "<dev string:x2df>" ? 2 : 1;
            var_3d1317b9c7bf8107 = params[ 0 ];
            
            if ( var_3d1317b9c7bf8107 == "<dev string:x2e6>" )
            {
                debugteamindex = debugteamindex == 2 ? 1 : 2;
            }
            
            setdvar( @"scr_debug_start_winners_circle", debugteamindex );
        }
    }

    // Namespace winners_circle
    // Params 1
    // Checksum 0x975c160e, Offset: 0x2b37
    // Size: 0x10e, Type: dev
    function function_cc3bb7c5db8381be( params )
    {
        weaponstr = params[ 0 ];
        playerstr = params[ 1 ];
        playerindex = playerstr[ playerstr.size - 1 ];
        debugdefaults = get_debug_defaults();
        debugweaponname = undefined;
        
        switch ( weaponstr )
        {
            case #"hash_719417cb1de832b6":
                debugweaponname = debugdefaults.default_pistol;
                break;
            case #"hash_ba39cac9c099d4f1":
                debugweaponname = debugdefaults.default_launcher;
                break;
            case #"hash_23209741b93850b5":
                debugweaponname = debugdefaults.default_shotgun;
                break;
            case #"hash_8cdaf2e4ecfe5b51":
                debugweaponname = debugdefaults.default_rifle;
                break;
            default:
                debugweaponname = function_51f2f64aadfa31cc();
                break;
        }
        
        if ( isdefined( debugweaponname ) )
        {
            dvarhash = hashcat( @"hash_200fa138f42e6ffb", playerindex );
            setdvar( dvarhash, debugweaponname );
        }
    }

    // Namespace winners_circle
    // Params 1
    // Checksum 0x4d328a5, Offset: 0x2c4d
    // Size: 0xa3, Type: dev
    function function_1fccafd19593b50a( params )
    {
        genderstr = params[ 0 ];
        playerstr = params[ 1 ];
        playerindex = playerstr[ playerstr.size - 1 ];
        debugdefaults = get_debug_defaults();
        var_aeb6ace577295169 = genderstr == "<dev string:x30c>" ? debugdefaults.var_dac25cb7956cdef7 : debugdefaults.var_1586c6f7611b1514;
        
        if ( isdefined( var_aeb6ace577295169 ) )
        {
            dvarhash = hashcat( @"hash_c4abf422b398a1b8", playerindex );
            setdvar( dvarhash, var_aeb6ace577295169 );
        }
    }

    // Namespace winners_circle
    // Params 1
    // Checksum 0x708b58f8, Offset: 0x2cf8
    // Size: 0x88, Type: dev
    function function_675e9b1ade30f0fc( params )
    {
        self notify( #"hash_6c90ae7404876bb1" );
        self endon( #"hash_6c90ae7404876bb1" );
        playerstr = params[ 0 ];
        playerindex = int( playerstr[ playerstr.size - 1 ] );
        
        while ( true )
        {
            characterent = level.client_characters[ playerindex ];
            
            if ( isdefined( characterent ) )
            {
                setdvar( @"hash_305a7db16a11dd02", characterent getentitynumber() );
                break;
            }
            
            waitframe();
        }
    }

    // Namespace winners_circle
    // Params 0
    // Checksum 0xc679db3b, Offset: 0x2d88
    // Size: 0x80, Type: dev
    function function_7f9220b51357e847()
    {
        for ( i = 0; i < 4 ; i++ )
        {
            setdvar( hashcat( @"hash_200fa138f42e6ffb", i ), "<dev string:x12c>" );
            setdvar( hashcat( @"hash_c4abf422b398a1b8", i ), "<dev string:x12c>" );
        }
        
        setdvar( @"hash_5b6dd91b900da0fb", 0 );
        setdvar( @"hash_dcb59bce5f45ed92", 0 );
        setdvar( @"hash_305a7db16a11dd02", -1 );
    }

    // Namespace winners_circle
    // Params 0
    // Checksum 0x61cd4b65, Offset: 0x2e10
    // Size: 0x56, Type: dev
    function function_a1bbbef823c2e5df()
    {
        winnerscirclebundle = getscriptbundle( level.gametypebundle.winnerscircle );
        
        if ( isdefined( winnerscirclebundle ) && isdefined( winnerscirclebundle.var_4311c295be6fc160 ) )
        {
            setdvar( @"hash_5b6dd91b900da0fb", winnerscirclebundle.var_4311c295be6fc160 );
        }
    }

    // Namespace winners_circle
    // Params 0
    // Checksum 0x1d528841, Offset: 0x2e6e
    // Size: 0x17f, Type: dev
    function function_b41935d434bf0228()
    {
        if ( !isdefined( level.gamemodebundle.emote_list ) )
        {
            return;
        }
        
        var_897a73128ee1f2ee = getscriptbundle( level.gamemodebundle.emote_list );
        var_f5ccc84c495d0e43 = getdvarint( @"hash_dcb59bce5f45ed92", 0 );
        
        if ( isdefined( var_897a73128ee1f2ee.var_414c5ef2f3fb4926 ) )
        {
            foreach ( playerindex, entry in level.mvparray )
            {
                var_d36a328cb2ba61c8 = getdvar( hashcat( @"hash_8d0e2fc834e9f41", playerindex ) );
                
                if ( isdefined( var_d36a328cb2ba61c8 ) && var_d36a328cb2ba61c8.size > 0 )
                {
                    var_59d24730c2e1b92d = emote::function_205b1d52b38d3b0e( var_d36a328cb2ba61c8 );
                    thread emote::function_e517ecb74bbd6b77( level.players, playerindex, var_59d24730c2e1b92d );
                    continue;
                }
                
                if ( var_f5ccc84c495d0e43 )
                {
                    validemote = 0;
                    var_ac2f0100c6b74a69 = -1;
                    
                    while ( !validemote )
                    {
                        var_ac2f0100c6b74a69 = randomintrange( 0, var_897a73128ee1f2ee.var_414c5ef2f3fb4926.size );
                        validemote = emote::function_8aae11cc20c2103f( var_ac2f0100c6b74a69 );
                    }
                    
                    thread emote::function_e517ecb74bbd6b77( level.players, playerindex, var_ac2f0100c6b74a69 );
                }
            }
        }
    }

    // Namespace winners_circle
    // Params 0
    // Checksum 0xe44a193, Offset: 0x2ff5
    // Size: 0x16e, Type: dev
    function dev_setup_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x311>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x32b>", "<dev string:x332>", &function_ff279ad09f39cc3c );
        devgui::function_cd4e263c1f3018ae( "<dev string:x34e>", "<dev string:x356>", &function_ff279ad09f39cc3c );
        devgui::add_devgui_func( "<dev string:x373>", "<dev string:x385>", &function_a1bbbef823c2e5df );
        devgui::add_devgui_func( "<dev string:x3a6>", "<dev string:x3b2>", &function_7f9220b51357e847 );
        devgui::function_eaac4ba4b3caf621( "<dev string:x3cd>", @"hash_dcb59bce5f45ed92" );
        devgui::function_77df7fe7dd273e10();
        
        for ( i = 0; i < 4 ; i++ )
        {
            devgui::function_9082edeb5db93280( "<dev string:x3db>" + i + 1 + "<dev string:x405>" );
            devgui::function_cd4e263c1f3018ae( "<dev string:x407>", "<dev string:x413>" + i, &function_cc3bb7c5db8381be );
            devgui::function_cd4e263c1f3018ae( "<dev string:x43c>", "<dev string:x449>" + i, &function_cc3bb7c5db8381be );
            devgui::function_cd4e263c1f3018ae( "<dev string:x473>", "<dev string:x482>" + i, &function_cc3bb7c5db8381be );
            devgui::function_cd4e263c1f3018ae( "<dev string:x4ae>", "<dev string:x4bc>" + i, &function_cc3bb7c5db8381be );
            devgui::function_cd4e263c1f3018ae( "<dev string:x4e7>", "<dev string:x4f2>" + i, &function_1fccafd19593b50a );
            devgui::function_cd4e263c1f3018ae( "<dev string:x51a>", "<dev string:x527>" + i, &function_1fccafd19593b50a );
            devgui::function_cd4e263c1f3018ae( "<dev string:x551>", "<dev string:x55d>" + i, &function_675e9b1ade30f0fc );
            devgui::function_77df7fe7dd273e10();
        }
    }

    // Namespace winners_circle
    // Params 0
    // Checksum 0x9d754fce, Offset: 0x316b
    // Size: 0xa5, Type: dev
    function function_acf5911e39c5e22b()
    {
        if ( level.teambased )
        {
            winningteam = level.winners_circle.debug_winner;
            
            if ( teams::getteamdata( winningteam, "<dev string:x57f>" ) > 0 )
            {
                level.topplayers = arraysort( teams::getteamdata( winningteam, "<dev string:x589>" ), undefined, &compare_player_score );
            }
            else
            {
                level.topplayers = [];
                level.topplayers[ 0 ] = level.players[ 0 ];
            }
            
            return;
        }
        
        level.topplayers = arraysort( level.players, undefined, &compare_player_score );
    }

    // Namespace winners_circle
    // Params 0
    // Checksum 0x250daab8, Offset: 0x3218
    // Size: 0x226, Type: dev
    function dev_winners_circle()
    {
        dev_setup_devgui();
        
        while ( true )
        {
            if ( getdvar( @"hash_22600991c9c4fc67", "<dev string:x12c>" ) != "<dev string:x12c>" )
            {
                iprintlnbold( "<dev string:x591>" );
                setdevdvar( @"hash_22600991c9c4fc67", "<dev string:x12c>" );
                level.doing_winners_circle = scene::init();
                
                if ( level.doing_winners_circle )
                {
                    setomnvarforallclients( "<dev string:x5a3>", 6 );
                    wait 0.1;
                    start_winners_circle();
                }
            }
            
            var_532eb6cad0468859 = getdvarint( @"scr_debug_start_winners_circle" );
            
            if ( var_532eb6cad0468859 )
            {
                iprintlnbold( "<dev string:x5b3>" );
                setdevdvar( @"scr_debug_start_winners_circle", 0 );
                setomnvar( "<dev string:x5c0>", var_532eb6cad0468859 );
                level.winners_circle.debug_winner = var_532eb6cad0468859 == 2 ? "<dev string:x2df>" : "<dev string:x5e0>";
                setomnvar( "<dev string:x5e5>", teams::getteamindex( level.winners_circle.debug_winner ) );
                setomnvarforallclients( "<dev string:x5f5>", 1 );
                
                foreach ( player in level.players )
                {
                    if ( player.team == level.winners_circle.debug_winner )
                    {
                        player setclientomnvar( "<dev string:x5ff>", game[ "<dev string:x612>" ][ "<dev string:x61c>" ] );
                        continue;
                    }
                    
                    player setclientomnvar( "<dev string:x5ff>", game[ "<dev string:x612>" ][ "<dev string:x624>" ] );
                }
                
                level.doing_winners_circle = force_init();
                
                if ( level.doing_winners_circle )
                {
                    setomnvarforallclients( "<dev string:x5a3>", 0 );
                    waitframe();
                    setomnvarforallclients( "<dev string:x5a3>", 6 );
                    wait 0.1;
                    start_winners_circle();
                }
            }
            
            wait 0.05;
        }
    }

#/
