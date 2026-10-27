// scripts\mp\gestures.gsc  (hash_562c77a4eda834c6.gscc) (size: 13336 Bytes / 0x3418 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x262687d (40003709)
// size ...... 13336 (0x3418)
// includes .. 9   (offset: 0x30e8)
// strings ... 43  (offset: 0x3130)
// dev strs .. 9   (offset: 0x33a8)
// exports ... 32  (offset: 0x217c)
// cseg ...... 0x3d1 + 0x1dab (0x217c)
// imports ... 80  (offset: 0x267c)
// animtree1 . 0   (offset: 0x3418)
// animtree2 . 0   (offset: 0x3418)
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\flags;
#using scripts\mp\objidpoolmanager;

#namespace gestures;

// Namespace gestures
// Params 0
// Checksum 0x4119d46d, Offset: 0x3ef
// Size: 0x17d
function init()
{
    level.gestureinfo = [];
    level.var_2afa493163abea1f = [];
    val::register( "gesture", 1, 0, "$self", &set_allow_gesture, "$value" );
    var_a0fb12c19893e55d = undefined;
    
    if ( isdefined( level.projectbundle.gesturelist ) )
    {
        var_a0fb12c19893e55d = getscriptbundle( level.projectbundle.gesturelist );
        gesturelist = var_a0fb12c19893e55d.list;
        
        foreach ( gesture in gesturelist )
        {
            gesturelootid = gesture.lootid;
            gesturebundlename = gesture.gesturebundle;
            gesturebundle = getscriptbundle( gesturebundlename );
            gesturedata = gesturebundle.gesturedata;
            level.var_2afa493163abea1f[ gesturelootid ] = gesturedata;
            level.gestureinfo[ gesturebundlename ] = gesturedata;
        }
        
        level.rockpaperscissors = [ "ges_plyr_gesture043", "ges_plyr_gesture114", "ges_plyr_gesture115" ];
    }
}

// Namespace gestures
// Params 1
// Checksum 0xcebf80e7, Offset: 0x574
// Size: 0x52
function getgesturedata( ref )
{
    if ( isbot( self ) && ref == "devilhorns_mp" )
    {
        ref = %"hash_372de418a385c1b7";
    }
    
    if ( !isxhashasset( ref ) )
    {
        ref = hashcat( %"hash_65abe1ecf0506c25", ref );
    }
    
    return level.gestureinfo[ ref ];
}

// Namespace gestures
// Params 1
// Checksum 0xe2140310, Offset: 0x5cf
// Size: 0x29
function function_b55e95515bddae9b( lootid )
{
    if ( isint( lootid ) )
    {
        lootid = string( lootid );
    }
    
    return level.var_2afa493163abea1f[ lootid ];
}

// Namespace gestures
// Params 1, eflags: 0x4
// Checksum 0xfecfaec0, Offset: 0x601
// Size: 0x68
function private set_allow_gesture( b_value = 0 )
{
    if ( b_value )
    {
        if ( utility::is_player_gamepad_enabled() )
        {
            self setactionslot( 1, "taunt" );
        }
        else
        {
            self setactionslot( 7, "taunt" );
        }
        
        return;
    }
    
    if ( utility::is_player_gamepad_enabled() )
    {
        self setactionslot( 1, "" );
        return;
    }
    
    self setactionslot( 7, "" );
}

// Namespace gestures
// Params 0
// Checksum 0xc94c7a4d, Offset: 0x671
// Size: 0x83
function cleargesture()
{
    self notify( #"cleargesture" );
    
    if ( isdefined( self.gestureweapon ) && self.gestureweapon != "none" )
    {
        if ( utility::is_player_gamepad_enabled() )
        {
            self setactionslot( 1, "" );
        }
        else
        {
            self setactionslot( 7, "" );
        }
        
        if ( self hasweapon( self.gestureweapon ) )
        {
            inventory_utility::_takeweapon( self.gestureweapon );
        }
        
        self.gestureweapon = "none";
    }
}

// Namespace gestures
// Params 1
// Checksum 0xe984ec11, Offset: 0x6fc
// Size: 0x115
function givegesture( gestureweapon )
{
    assert( gestureweapon != "<dev string:x24>", "<dev string:x29>" );
    assert( !isdefined( self.gestureweapon ) || self.gestureweapon == "<dev string:x24>", "<dev string:x56>" );
    
    if ( utility::is_player_gamepad_enabled() )
    {
        self setactionslot( 1, "taunt" );
    }
    else
    {
        self setactionslot( 7, "taunt" );
    }
    
    inventory_utility::_giveweapon( gestureweapon );
    self assignweaponoffhandtaunt( gestureweapon );
    self.gestureweapon = gestureweapon;
    
    if ( !game_utility_mp::lpcfeaturegated() )
    {
        switch ( gestureweapon )
        {
            case #"hash_e3d706263fb4a279":
                thread gesture_rockpaperscissorsthink();
                gestureweapon = gesture_pickrockpaperscissors();
                break;
            case #"hash_e3da89263fb7af49":
                newgesture = utility::cointoss() ? "ges_plyr_gesture050" : "ges_plyr_gesture052";
                thread gesture_coinflipthink( newgesture );
                gestureweapon = newgesture;
                break;
        }
        
        if ( !self isconsoleplayer() )
        {
            thread monitorgamepadswitch();
        }
        
        thread gesture_manage3rdperson();
    }
}

// Namespace gestures
// Params 0
// Checksum 0x15add05a, Offset: 0x819
// Size: 0x9e
function monitorgamepadswitch()
{
    self endon( #"cleargesture" );
    self endon( #"disconnect" );
    var_501cdc4d0c3a6ba5 = utility::is_player_gamepad_enabled();
    
    while ( true )
    {
        if ( self.disabledgesture > 0 )
        {
            waitframe();
            continue;
        }
        
        var_85b0e3f48fa5d341 = utility::is_player_gamepad_enabled();
        
        if ( var_85b0e3f48fa5d341 != var_501cdc4d0c3a6ba5 )
        {
            if ( var_501cdc4d0c3a6ba5 )
            {
                self setactionslot( 1, "" );
                self setactionslot( 7, "taunt" );
            }
            else
            {
                self setactionslot( 1, "taunt" );
                self setactionslot( 7, "" );
            }
        }
        
        var_501cdc4d0c3a6ba5 = var_85b0e3f48fa5d341;
        waitframe();
    }
}

// Namespace gestures
// Params 0
// Checksum 0x7feed0e7, Offset: 0x8bf
// Size: 0x2f
function gesture_manage3rdperson()
{
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"offhand_pullback", objweapon );
    }
}

// Namespace gestures
// Params 0
// Checksum 0xb8ba5197, Offset: 0x8f6
// Size: 0x1b
function gesture_pickrockpaperscissors()
{
    return level.rockpaperscissors[ randomintrange( 0, level.rockpaperscissors.size ) ];
}

// Namespace gestures
// Params 0
// Checksum 0xdd278723, Offset: 0x91a
// Size: 0xdd
function gesture_rockpaperscissorsthink()
{
    self endon( #"cleargesture" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self notify( #"hash_12cc7dfa9795094c" );
    self endon( #"hash_12cc7dfa9795094c" );
    
    while ( true )
    {
        self waittill( #"hash_b2c43788a6b6b402" );
        canplay = undefined;
        
        if ( flags::gameflag( "prematch_done" ) && getdvarint( @"scr_test_rps", 0 ) == 0 )
        {
            self [[ level.showerrormessagefunc ]]( "MP_INGAME_ONLY/RPS_TOO_LATE" );
            canplay = 0;
        }
        else
        {
            self [[ level.showerrormessagefunc ]]( "MP_INGAME_ONLY/RPS_START" );
            canplay = 1;
        }
        
        self waittill( #"offhand_fired" );
        
        if ( canplay )
        {
            thread gesture_playrockpaperscissors();
        }
        
        self waittill( #"offhand_end" );
        thread gesture_resetrockpaperscissorsgesture();
    }
}

// Namespace gestures
// Params 0
// Checksum 0x132ede10, Offset: 0x9ff
// Size: 0x15
function gesture_resetrockpaperscissorsgesture()
{
    cleargesture();
    givegesture( "ges_plyr_gesture043" );
}

// Namespace gestures
// Params 0
// Checksum 0x30142f26, Offset: 0xa1c
// Size: 0x133
function gesture_playrockpaperscissors()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self endon( #"hash_d41b607650e4456b" );
    self notify( #"hash_c9987c154f738310" );
    self endon( #"hash_c9987c154f738310" );
    opponent = gesture_getrockpaperscissorsplayers();
    
    if ( isdefined( opponent ) )
    {
        winner = gesture_determinerockpaperscissorswinner( self, self.gestureweapon, opponent, opponent.rockpaperscissorschoice );
        
        if ( isdefined( winner ) )
        {
            winner [[ level.showerrormessagefunc ]]( "MP_INGAME_ONLY/RPS_WIN" );
            winner thread [[ level.var_dbd43a8b925f566f ]]( "rock_paper_scissors_win" );
            loser = winner == self ? opponent : self;
            loser [[ level.showerrormessagefunc ]]( "MP_INGAME_ONLY/RPS_LOSE" );
        }
        else
        {
            self [[ level.showerrormessagefunc ]]( "MP_INGAME_ONLY/RPS_DRAW" );
            opponent [[ level.showerrormessagefunc ]]( "MP_INGAME_ONLY/RPS_DRAW" );
        }
        
        opponent notify( #"hash_d41b607650e4456b" );
        opponent.rockpaperscissorschoice = undefined;
        return;
    }
    
    self.rockpaperscissorschoice = self.gestureweapon;
    wait 3;
    self.rockpaperscissorschoice = undefined;
}

// Namespace gestures
// Params 0
// Checksum 0xefdab2e3, Offset: 0xb57
// Size: 0x14a
function gesture_getrockpaperscissorsplayers()
{
    forward = anglestoforward( self getplayerangles() );
    nearplayers = utility::playersinsphere( self.origin, 500 );
    
    foreach ( otherplayer in nearplayers )
    {
        if ( !isdefined( otherplayer ) || otherplayer == self )
        {
            continue;
        }
        
        if ( !isdefined( otherplayer.rockpaperscissorschoice ) )
        {
            continue;
        }
        
        tootherplayer = otherplayer.origin - self.origin;
        tootherplayer = vectornormalize( tootherplayer );
        var_e1bcf7d86177679f = vectordot( tootherplayer, forward );
        
        if ( var_e1bcf7d86177679f < 0.707107 )
        {
            continue;
        }
        
        otherplayerforward = anglestoforward( otherplayer getplayerangles() );
        fromotherplayer = tootherplayer * -1;
        var_8c18a5a27bc06250 = vectordot( fromotherplayer, otherplayerforward );
        
        if ( var_8c18a5a27bc06250 < 0.707107 )
        {
            continue;
        }
        
        return otherplayer;
    }
}

// Namespace gestures
// Params 4
// Checksum 0x4307b0b2, Offset: 0xca9
// Size: 0x96
function gesture_determinerockpaperscissorswinner( player1, player1choice, player2, player2choice )
{
    if ( player1choice == player2choice )
    {
        return;
    }
    
    switch ( player1choice )
    {
        case #"hash_e3d706263fb4a279":
            return ( player2choice == "ges_plyr_gesture114" ? player2 : player1 );
        case #"hash_eaeaf42643537972":
            return ( player2choice == "ges_plyr_gesture115" ? player2 : player1 );
        case #"hash_eaeaf52643537b05":
            return ( player2choice == "ges_plyr_gesture043" ? player2 : player1 );
    }
}

// Namespace gestures
// Params 1
// Checksum 0x17467001, Offset: 0xd47
// Size: 0x7b
function gesture_coinflipthink( gesture )
{
    self endon( #"cleargesture" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self notify( #"hash_24dc3fc1c0f9aa5a" );
    self endon( #"hash_24dc3fc1c0f9aa5a" );
    
    while ( true )
    {
        self waittill( #"hash_b2c43788a6b6b402" );
        
        while ( true )
        {
            if ( !self isgestureplaying( gesture ) )
            {
                break;
            }
            
            waitframe();
        }
        
        thread gesture_resetcoinflipgesture();
    }
}

// Namespace gestures
// Params 0
// Checksum 0xea06b355, Offset: 0xdca
// Size: 0x15
function gesture_resetcoinflipgesture()
{
    cleargesture();
    givegesture( "ges_plyr_gesture050" );
}

// Namespace gestures
// Params 0
// Checksum 0x736a7930, Offset: 0xde7
// Size: 0x3a, Type: bool
function haschangedarchetype()
{
    if ( isdefined( self.changedarchetypeinfo ) )
    {
        if ( !isdefined( self.lastarchetypeinfo ) )
        {
            return true;
        }
        
        if ( self.changedarchetypeinfo != self.lastarchetypeinfo )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace gestures
// Params 0
// Checksum 0x866a070, Offset: 0xe2a
// Size: 0x8b
function monitorcontextualcallout()
{
    if ( isai( self ) )
    {
        return;
    }
    
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self notify( #"contextualcallout" );
    self endon( #"contextualcallout" );
    
    if ( utility::is_player_gamepad_enabled() )
    {
        self notifyonplayercommand( "activateGesture", "+actionslot 1" );
    }
    else
    {
        self notifyonplayercommand( "activateGesture", "+actionslot 7" );
    }
    
    waitframe();
    cleargesture();
    
    while ( true )
    {
        self waittill( #"activateGesture" );
        processcontext();
    }
}

// Namespace gestures
// Params 0
// Checksum 0x8d0bfbd2, Offset: 0xebd
// Size: 0x27a
function processcontext()
{
    startpos = self geteye();
    viewangles = self getplayerangles();
    fwd = anglestoforward( viewangles );
    mindot = cos( 10 );
    bestdot = undefined;
    bestent = undefined;
    var_a61fa2bda41806ad = [];
    
    if ( isdefined( self.engstructks ) )
    {
        foreach ( ent in self.engstructks.outlinedents )
        {
            var_a61fa2bda41806ad[ var_a61fa2bda41806ad.size ] = ent;
        }
    }
    
    foreach ( ent in var_a61fa2bda41806ad )
    {
        dot = vectordot( fwd, vectornormalize( ent.origin - startpos ) );
        
        if ( !isdefined( bestdot ) || bestdot < dot )
        {
            bestdot = dot;
            bestent = ent;
        }
    }
    
    if ( isdefined( bestent ) && bestdot > mindot )
    {
        if ( isdefined( bestent.vehicle ) )
        {
            bestent = bestent.vehicle;
        }
        
        thread applyoutlinecalloutsource( bestent );
        return;
    }
    
    if ( isdefined( level.gamemodegesturecalloutassign ) && self thread [[ level.gamemodegesturecalloutassign ]]() )
    {
        return;
    }
    
    content = [ "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_characterproxy", "physicscontents_glass", "physicscontents_itemclip" ];
    contentoverride = physics_createcontents( content );
    endpos = startpos + fwd * 10000;
    trace = trace::sphere_trace( startpos, endpos, 0.1, self, contentoverride, 0 );
    
    if ( trace[ "fraction" ] < 0.99 )
    {
        thread markworldposition( trace[ "position" ] );
    }
}

// Namespace gestures
// Params 1
// Checksum 0xdf31b1e2, Offset: 0x113f
// Size: 0x13c
function markworldposition( org )
{
    self.worldmarkerpos = org;
    
    if ( !isdefined( self.worldmarkerid ) )
    {
        self.worldmarkerid = objidpoolmanager::requestobjectiveid( 1 );
        
        if ( self.worldmarkerid != -1 )
        {
            objidpoolmanager::objective_add_objective( self.worldmarkerid, "invisible", org, "icon_waypoint_marker" );
            objidpoolmanager::objective_teammask_single( self.worldmarkerid, self.team );
            objidpoolmanager::update_objective_setbackground( self.worldmarkerid, 1 );
            objidpoolmanager::objective_set_play_intro( self.worldmarkerid, 0 );
            objidpoolmanager::objective_set_play_outro( self.worldmarkerid, 0 );
        }
        else
        {
            self.worldmarkerid = undefined;
            return;
        }
    }
    else
    {
        objidpoolmanager::update_objective_position( self.worldmarkerid, org );
    }
    
    objid = self.worldmarkerid;
    self notify( #"hash_3056c27f80577b77" );
    self endon( #"hash_3056c27f80577b77" );
    objidpoolmanager::objective_set_pulsate( objid, 1 );
    wait 3;
    objidpoolmanager::objective_set_pulsate( objid, 0 );
    wait 5;
    objidpoolmanager::returnobjectiveid( objid );
    self.worldmarkerid = undefined;
    self.worldmarkerpos = undefined;
}

// Namespace gestures
// Params 1
// Checksum 0xf88fef85, Offset: 0x1283
// Size: 0x2b9
function applyoutlinecalloutsource( ent )
{
    if ( !isdefined( ent.outlinecalloutsource ) )
    {
        ent.outlinecalloutsource = [];
    }
    
    foreach ( player in ent.outlinecalloutsource )
    {
        if ( player == self )
        {
            return;
        }
    }
    
    event = "assist_ping";
    points = 0;
    
    if ( utility::issharedfuncdefined( #"rank", #"hash_b4c081ca47d526a4" ) )
    {
        points = [[ utility::getsharedfunc( #"rank", #"hash_b4c081ca47d526a4" ) ]]( event );
    }
    
    if ( utility::issharedfuncdefined( #"rank", #"giverankxp" ) )
    {
        self thread [[ utility::getsharedfunc( #"rank", #"giverankxp" ) ]]( event, points );
    }
    
    if ( utility::issharedfuncdefined( #"supers", #"givesuperpoints" ) )
    {
        self thread [[ utility::getsharedfunc( #"supers", #"givesuperpoints" ) ]]( points );
    }
    
    if ( utility::issharedfuncdefined( #"rank", #"hash_fa38071832f37bbf" ) )
    {
        self thread [[ utility::getsharedfunc( #"rank", #"hash_fa38071832f37bbf" ) ]]( event );
    }
    
    outlines = [];
    id = undefined;
    
    if ( utility::issharedfuncdefined( #"outline", #"outlineenableforteam" ) )
    {
        id = [[ utility::getsharedfunc( #"outline", #"outlineenableforteam" ) ]]( ent, self.team, "outline_nodepth_red", "perk_superior" );
    }
    
    ent.outlinecalloutsource[ ent.outlinecalloutsource.size ] = self;
    outlines[ id ] = ent;
    tempoutline = 0;
    
    if ( isdefined( ent.turret ) )
    {
        id = undefined;
        
        if ( utility::issharedfuncdefined( #"outline", #"outlineenableforteam" ) )
        {
            id = [[ utility::getsharedfunc( #"outline", #"outlineenableforteam" ) ]]( ent.turret, self.team, "outline_nodepth_red", "perk_superior" );
        }
        
        outlines[ id ] = ent.turret;
        tempoutline = 1;
    }
    
    if ( tempoutline )
    {
        ent thread processtimeout( self, outlines );
    }
}

// Namespace gestures
// Params 2
// Checksum 0x8c1a488, Offset: 0x1544
// Size: 0x121
function processtimeout( attacker, outlines )
{
    attacker endon( #"disconnect" );
    self endon( #"death" );
    timeout = 30;
    wait timeout;
    
    for ( i = 0; i < self.outlinecalloutsource.size ; i++ )
    {
        if ( self.outlinecalloutsource[ i ] == attacker )
        {
            self.outlinecalloutsource[ i ] = undefined;
        }
    }
    
    foreach ( id, ent in outlines )
    {
        if ( utility::issharedfuncdefined( #"outline", #"outlinedisable" ) )
        {
            [[ utility::getsharedfunc( #"outline", #"outlinedisable" ) ]]( id, ent );
        }
    }
}

// Namespace gestures
// Params 2
// Checksum 0xe864182a, Offset: 0x166d
// Size: 0x278
function processcalloutdeath( ent, attacker )
{
    if ( !( isdefined( ent ) && isdefined( attacker ) ) )
    {
        return;
    }
    
    if ( !isdefined( ent.outlinecalloutsource ) )
    {
        return;
    }
    
    foreach ( player in ent.outlinecalloutsource )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( player == attacker )
        {
            continue;
        }
        
        if ( player_utility::playersareenemies( player, attacker ) )
        {
            continue;
        }
        
        scoreevent = "assist_marked";
        points = 0;
        
        if ( utility::issharedfuncdefined( #"rank", #"hash_b4c081ca47d526a4" ) )
        {
            points = [[ utility::getsharedfunc( #"rank", #"hash_b4c081ca47d526a4" ) ]]( scoreevent );
        }
        
        if ( utility::issharedfuncdefined( #"rank", #"giverankxp" ) )
        {
            player thread [[ utility::getsharedfunc( #"rank", #"giverankxp" ) ]]( scoreevent, points );
        }
        
        if ( utility::issharedfuncdefined( #"supers", #"givesuperpoints" ) )
        {
            player thread [[ utility::getsharedfunc( #"supers", #"givesuperpoints" ) ]]( points );
        }
        
        if ( utility::issharedfuncdefined( #"rank", #"hash_fa38071832f37bbf" ) )
        {
            player thread [[ utility::getsharedfunc( #"rank", #"hash_fa38071832f37bbf" ) ]]( scoreevent );
        }
        
        points = 25;
        
        if ( utility::issharedfuncdefined( #"rank", #"giverankxp" ) )
        {
            attacker thread [[ utility::getsharedfunc( #"rank", #"giverankxp" ) ]]( scoreevent, points );
        }
        
        if ( utility::issharedfuncdefined( #"supers", #"givesuperpoints" ) )
        {
            attacker thread [[ utility::getsharedfunc( #"supers", #"givesuperpoints" ) ]]( points );
        }
        
        if ( utility::issharedfuncdefined( #"rank", #"hash_fa38071832f37bbf" ) )
        {
            attacker thread [[ utility::getsharedfunc( #"rank", #"hash_fa38071832f37bbf" ) ]]( scoreevent );
        }
    }
}

// Namespace gestures
// Params 3
// Checksum 0x28d893c9, Offset: 0x18ed
// Size: 0x30f
function applygamemodecallout( ent, msg, event )
{
    self endon( #"disconnect" );
    
    if ( isdefined( self.gamemodecalloutent ) )
    {
        if ( self.gamemodecalloutent == ent )
        {
            return;
        }
        
        self notify( #"hash_a5bb5854bc724410" );
    }
    else
    {
        scoreevent = "assist_ping";
        points = 0;
        
        if ( utility::issharedfuncdefined( #"rank", #"hash_b4c081ca47d526a4" ) )
        {
            points = [[ utility::getsharedfunc( #"rank", #"hash_b4c081ca47d526a4" ) ]]( scoreevent );
        }
        
        if ( utility::issharedfuncdefined( #"rank", #"giverankxp" ) )
        {
            self thread [[ utility::getsharedfunc( #"rank", #"giverankxp" ) ]]( scoreevent, points );
        }
        
        if ( utility::issharedfuncdefined( #"supers", #"givesuperpoints" ) )
        {
            self thread [[ utility::getsharedfunc( #"supers", #"givesuperpoints" ) ]]( points );
        }
        
        if ( utility::issharedfuncdefined( #"rank", #"hash_fa38071832f37bbf" ) )
        {
            self thread [[ utility::getsharedfunc( #"rank", #"hash_fa38071832f37bbf" ) ]]( scoreevent );
        }
    }
    
    self.gamemodecallouttime = gettime();
    self.gamemodecalloutent = ent;
    id = undefined;
    
    if ( isdefined( ent.outlineent ) )
    {
        id = undefined;
        
        if ( utility::issharedfuncdefined( #"outline", #"outlineenableforteam" ) )
        {
            id = [[ utility::getsharedfunc( #"outline", #"outlineenableforteam" ) ]]( ent.outlineent, self.team, "outline_nodepth_red", "perk_superior" );
        }
    }
    
    foreach ( player in level.players )
    {
        if ( player.team != self.team )
        {
            continue;
        }
        
        player iprintlnbold( msg );
    }
    
    thread waittillobjectiveevent( id, ent, event );
    thread waittillobjectivereplaced( id, ent, event );
    timeout = 30;
    utility::waittill_notify_or_timeout( "callout_processed_" + event, timeout );
    self notify( "callout_timeout_" + event );
    
    if ( isdefined( ent.outlineent ) )
    {
        if ( utility::issharedfuncdefined( #"outline", #"outlinedisable" ) )
        {
            [[ utility::getsharedfunc( #"outline", #"outlinedisable" ) ]]( id, ent.outlineent );
        }
    }
    
    self.gamemodecalloutent = undefined;
}

// Namespace gestures
// Params 3
// Checksum 0x25b74c93, Offset: 0x1c04
// Size: 0x298
function waittillobjectiveevent( id, ent, event )
{
    self endon( "callout_timeout_" + event );
    self endon( #"hash_a5bb5854bc724410" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        ent waittill( event, player );
        giveconfirm = 0;
        
        if ( isdefined( level.gamemodegesturecalloutverify ) )
        {
            giveconfirm = self [[ level.gamemodegesturecalloutverify ]]( event, player );
        }
        
        if ( giveconfirm )
        {
            scoreevent = "assist_marked";
            points = 0;
            
            if ( utility::issharedfuncdefined( #"rank", #"hash_b4c081ca47d526a4" ) )
            {
                points = [[ utility::getsharedfunc( #"rank", #"hash_b4c081ca47d526a4" ) ]]( scoreevent );
            }
            
            if ( utility::issharedfuncdefined( #"rank", #"giverankxp" ) )
            {
                self thread [[ utility::getsharedfunc( #"rank", #"giverankxp" ) ]]( scoreevent, points );
            }
            
            if ( utility::issharedfuncdefined( #"supers", #"givesuperpoints" ) )
            {
                self thread [[ utility::getsharedfunc( #"supers", #"givesuperpoints" ) ]]( points );
            }
            
            if ( utility::issharedfuncdefined( #"rank", #"hash_fa38071832f37bbf" ) )
            {
                self thread [[ utility::getsharedfunc( #"rank", #"hash_fa38071832f37bbf" ) ]]( scoreevent );
            }
            
            points = 25;
            
            if ( utility::issharedfuncdefined( #"rank", #"giverankxp" ) )
            {
                player thread [[ utility::getsharedfunc( #"rank", #"giverankxp" ) ]]( scoreevent, points );
            }
            
            if ( utility::issharedfuncdefined( #"supers", #"givesuperpoints" ) )
            {
                player thread [[ utility::getsharedfunc( #"supers", #"givesuperpoints" ) ]]( points );
            }
            
            if ( utility::issharedfuncdefined( #"rank", #"hash_fa38071832f37bbf" ) )
            {
                player thread [[ utility::getsharedfunc( #"rank", #"hash_fa38071832f37bbf" ) ]]( scoreevent );
            }
            
            if ( isdefined( ent.outlineent ) )
            {
                if ( utility::issharedfuncdefined( #"outline", #"outlinedisable" ) )
                {
                    [[ utility::getsharedfunc( #"outline", #"outlinedisable" ) ]]( id, ent.outlineent );
                }
            }
            
            self notify( "callout_processed_" + event );
            break;
        }
    }
}

// Namespace gestures
// Params 3
// Checksum 0xc3a3f9b9, Offset: 0x1ea4
// Size: 0x9f
function waittillobjectivereplaced( id, ent, event )
{
    self endon( "callout_timeout_" + event );
    self endon( "callout_processed_" + event );
    self endon( #"disconnect" );
    self waittill( #"hash_a5bb5854bc724410" );
    
    if ( isdefined( ent.outlineent ) )
    {
        if ( utility::issharedfuncdefined( #"outline", #"outlinedisable" ) )
        {
            [[ utility::getsharedfunc( #"outline", #"outlinedisable" ) ]]( id, ent.outlineent );
        }
    }
}

// Namespace gestures
// Params 2
// Checksum 0xc18735f8, Offset: 0x1f4b
// Size: 0xe5
function watchradialgestureactivation( gesturenotify, lootid )
{
    if ( ( isbrgamemode() || level.gametype == "dmz" ) && self hasweapon( "iw9_armor_plate_deploy_mp" ) )
    {
        return;
    }
    
    if ( gesturenotify == "radial_menu_selection_gesture" )
    {
        gesturedata = function_b55e95515bddae9b( lootid );
        
        if ( isdefined( gesturedata ) )
        {
            objweapon = makeweapon( gesturedata );
            
            if ( isdefined( objweapon ) && !isnullweapon( objweapon ) )
            {
                watchradialgesture( objweapon );
            }
        }
        
        return;
    }
    
    if ( gesturenotify == "radial_menu_selection_spray" )
    {
        objweapon = makeweapon( "t10_ges_plyr_spray" );
        
        if ( isdefined( objweapon ) && !isnullweapon( objweapon ) )
        {
            thread watchspraygesturedosprayevent( lootid );
            watchradialgesture( objweapon );
            return;
        }
        
        println( "<dev string:x8e>" + "<dev string:xac>" + "<dev string:xbf>" );
    }
}

// Namespace gestures
// Params 1
// Checksum 0xed110e3a, Offset: 0x2038
// Size: 0x86
function watchspraygesturedosprayevent( sprayindex )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self notify( #"hash_34031860a9ced096" );
    self endon( #"hash_34031860a9ced096" );
    endtime = gettime() + 200;
    
    while ( gettime() < endtime )
    {
        waitframe();
        
        if ( function_2dbbd851552dbfb8() )
        {
            self sprayevent( sprayindex );
            thread challenges::function_9e5c02c20963077f( self, sprayindex );
            return;
        }
    }
    
    println( "<dev string:xd2>" );
}

// Namespace gestures
// Params 1
// Checksum 0xcd0e3560, Offset: 0x20c6
// Size: 0x73
function watchradialgesture( objweapon )
{
    self giveandfireoffhand( objweapon );
    endtime = gettime() + 5000;
    
    while ( gettime() < endtime )
    {
        if ( !self hasweapon( objweapon ) )
        {
            break;
        }
        
        waitframe();
    }
    
    if ( self hasweapon( objweapon ) )
    {
        inventory_utility::_takeweapon( objweapon );
    }
    
    cleargesture();
    waitframe();
    self.gestureweapon = objweapon.basename;
}

// Namespace gestures
// Params 0
// Checksum 0xdc3f0868, Offset: 0x2141
// Size: 0xc
function function_2dbbd851552dbfb8()
{
    return self isgestureplaying( "t10_ges_plyr_spray" );
}

/#

    // Namespace gestures
    // Params 0
    // Checksum 0xdcf2291a, Offset: 0x2156
    // Size: 0x26, Type: dev
    function function_c81d508bf5409490()
    {
        wait 2;
        self iprintlnbold( "<dev string:xfe>" );
        self notify( #"luinotifyserver", "<dev string:x111>", 3 );
    }

#/
