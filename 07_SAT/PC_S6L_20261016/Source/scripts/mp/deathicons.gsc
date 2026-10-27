// scripts\mp\deathicons.gsc  (hash_706e421915fe0ec2.gscc) (size: 6828 Bytes / 0x1aac / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa059bdd1 (2690235857)
// size ...... 6828 (0x1aac)
// includes .. 9   (offset: 0x19a8)
// strings ... 12  (offset: 0x19f0)
// dev strs .. 2   (offset: 0x1a8c)
// exports ... 13  (offset: 0x11e4)
// cseg ...... 0x165 + 0x107f (0x11e4)
// imports ... 47  (offset: 0x13ec)
// animtree1 . 0   (offset: 0x1aac)
// animtree2 . 0   (offset: 0x1aac)
#using script_16ea1b94f0f381b3;
#using scripts\common\utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\entityheadicons;
#using scripts\mp\flags;

#namespace deathicons;

// Namespace deathicons
// Params 0
// Checksum 0x1df2f3a2, Offset: 0x183
// Size: 0xc4
function init()
{
    level.deathicons = spawnstruct();
    level.deathicons.var_8410911204701fc1 = getdvarint( @"hash_97e20befa2938a48", 10 );
    level.deathicons.var_d7140b84605c2819 = getdvarint( @"hash_f00ea016dc7b1272", 4000 );
    level.deathicons.var_b3aca5facfff09d6 = getdvarfloat( @"death_icon_teammate_duration", 10 );
    level.deathicons.var_f8992030acff1365 = getdvarfloat( @"hash_d4e44eecf9bc8099", 0 );
    level.deathicons.var_53e50bdfa221c3dc = getdvarint( @"hash_c8a232772217eb5c", 0 );
}

// Namespace deathicons
// Params 5
// Checksum 0xdf27515, Offset: 0x24f
// Size: 0x414
function adddeathicon( attacker, entity, dyingplayer, team, timeout )
{
    dyingplayer endon( #"disconnect" );
    
    if ( dyingplayer.skipdeathicon )
    {
        return;
    }
    
    if ( !level.teambased )
    {
        return;
    }
    
    if ( isdefined( level.gametypebundle ) && level.gametypebundle.var_45b038f7b0e3eaea )
    {
        return;
    }
    
    if ( getdvarint( @"ui_hud_showdeathicons", 1 ) == 0 )
    {
        return;
    }
    
    if ( game_utility::function_d3f8957534dc62af() )
    {
        return;
    }
    
    if ( dyingplayer namespace_9d8e359c3b1041e5::isplayeringulagsharedfunc() )
    {
        return;
    }
    
    if ( game_utility_mp::isteamreviveenabled() )
    {
        return;
    }
    
    if ( isdefined( attacker.perks[ "specialty_nodeathicon" ] ) && attacker != dyingplayer )
    {
        if ( isdefined( attacker.var_e3b3191ad394eb0d ) )
        {
            attacker [[ attacker.var_e3b3191ad394eb0d ]]();
        }
        
        return;
    }
    
    isbr = isbrgamemode() || game_utility::getgametype() == "dmz";
    isbrtdm = game_utility::getgametype() == "brtdm";
    var_7a9c7661d1ff67ff = isdefined( attacker.perks[ "specialty_silentkill" ] );
    
    if ( !isbr && var_7a9c7661d1ff67ff )
    {
        return;
    }
    
    dyingplayer notify( #"hash_c1aee3f64ea31d08" );
    dyingplayer endon( #"hash_c1aee3f64ea31d08" );
    assert( team_utility::isgameplayteam( team ) );
    
    if ( isdefined( dyingplayer.lastdeathheadicon ) )
    {
        entityheadicons::setheadicon_deleteicon( dyingplayer.lastdeathheadicon );
        dyingplayer.lastdeathheadicon = undefined;
    }
    
    dyingplayer notify( #"hash_11067d4da7370dc2" );
    image = %"hud_icon_death_spawn";
    showto = team;
    
    if ( isbr )
    {
        sessionnumber = dyingplayer.sessionuimemberindex;
        
        if ( !isdefined( sessionnumber ) || sessionnumber < 0 )
        {
            /#
                iprintln( "<dev string:x24>" + dyingplayer.name + "<dev string:x4c>" );
            #/
            
            return;
        }
        
        image = hashcat( %"hud_icon_player_dead_", dyingplayer.sessionuimemberindex + 1 );
        
        if ( var_7a9c7661d1ff67ff )
        {
            showto = [ dyingplayer ];
        }
        else if ( level.deathicons.var_53e50bdfa221c3dc )
        {
            showto = level.squaddata[ team ][ dyingplayer.sessionsquadid ].players;
        }
        else
        {
            showto = teams::getteamdata( dyingplayer.team, "players" );
        }
        
        foreach ( showtoplayer in showto )
        {
            if ( showtoplayer namespace_9d8e359c3b1041e5::isplayeringulagsharedfunc() )
            {
                showto = arrayremove( showto, showtoplayer );
            }
        }
    }
    else if ( isbrtdm )
    {
        if ( var_7a9c7661d1ff67ff )
        {
            showto = [ dyingplayer ];
        }
        else
        {
            showto = teams::getteamdata( dyingplayer.team, "players" );
        }
    }
    
    overrideorigin = dyingplayer.origin;
    var_6275850de36415ea = isbr;
    showonminimap = isbr;
    var_c6bd58f878e4420a = isbr;
    dyingplayer.lastdeathheadicon = dyingplayer entityheadicons::setheadicon_singleimage( showto, image, undefined, 1, 0, 0, undefined, var_c6bd58f878e4420a, var_6275850de36415ea, overrideorigin, showonminimap );
    
    if ( isbr )
    {
        setheadiconteam( dyingplayer.lastdeathheadicon, dyingplayer.team );
        function_d2fb105f172c1333( dyingplayer.lastdeathheadicon, dyingplayer.sessionuimemberindex + 1 );
    }
    
    if ( isdefined( dyingplayer.lastdeathheadicon ) )
    {
        if ( isbr || isbrtdm )
        {
            dyingplayer thread function_4a8c2c69e98d378( var_7a9c7661d1ff67ff );
            return;
        }
        
        dyingplayer thread destroyslowly( timeout );
    }
}

// Namespace deathicons
// Params 1
// Checksum 0xa258eab5, Offset: 0x66b
// Size: 0x17a
function function_50307255623796cc( var_dbf43db5f60a1e4f )
{
    var_dbf43db5f60a1e4f endon( #"disconnect" );
    level endon( #"game_ended" );
    var_dbf43db5f60a1e4f notify( #"hash_c1aee3f64ea31d08" );
    var_dbf43db5f60a1e4f endon( #"hash_c1aee3f64ea31d08" );
    
    if ( isdefined( var_dbf43db5f60a1e4f.lastdeathheadicon ) )
    {
        entityheadicons::setheadicon_deleteicon( var_dbf43db5f60a1e4f.lastdeathheadicon );
        var_dbf43db5f60a1e4f.lastdeathheadicon = undefined;
        var_dbf43db5f60a1e4f notify( #"hash_11067d4da7370dc2" );
    }
    
    sessionnumber = var_dbf43db5f60a1e4f.sessionuimemberindex;
    
    if ( !isdefined( sessionnumber ) || sessionnumber < 0 )
    {
        /#
            iprintln( "<dev string:x24>" + var_dbf43db5f60a1e4f.name + "<dev string:x4c>" );
        #/
        
        return;
    }
    
    image = hashcat( %"hud_icon_player_dead_", sessionnumber + 1 );
    overrideorigin = var_dbf43db5f60a1e4f.lastdeathpos;
    var_dbf43db5f60a1e4f.lastdeathheadicon = var_dbf43db5f60a1e4f entityheadicons::setheadicon_singleimage( var_dbf43db5f60a1e4f, image, undefined, 1, 0, 0, undefined, 1, 1, overrideorigin, 1 );
    function_d2fb105f172c1333( var_dbf43db5f60a1e4f.lastdeathheadicon, sessionnumber + 1 );
    var_dbf43db5f60a1e4f waittill( #"started_spawnplayer" );
    var_dbf43db5f60a1e4f function_9dd5b4727629a632( var_dbf43db5f60a1e4f.lastdeathheadicon, overrideorigin, var_dbf43db5f60a1e4f.team );
    entityheadicons::setheadicon_deleteicon( var_dbf43db5f60a1e4f.lastdeathheadicon );
    
    if ( isdefined( var_dbf43db5f60a1e4f ) )
    {
        var_dbf43db5f60a1e4f.lastdeathheadicon = undefined;
    }
}

// Namespace deathicons
// Params 1
// Checksum 0x69ffdf94, Offset: 0x7ed
// Size: 0xac
function function_4a8c2c69e98d378( var_7a9c7661d1ff67ff )
{
    self endon( #"hash_11067d4da7370dc2" );
    team = self.team;
    icon = self.lastdeathheadicon;
    deathiconlocation = self.origin;
    jobs = [ &function_9dd5b4727629a632 ];
    
    if ( !var_7a9c7661d1ff67ff )
    {
        jobs[ jobs.size ] = &function_27e3fdb3fd2bc893;
    }
    
    utility::function_bc06a8c564f539e5( jobs, [ icon, deathiconlocation, team ] );
    entityheadicons::setheadicon_deleteicon( icon );
    
    if ( isdefined( self ) )
    {
        self.lastdeathheadicon = undefined;
    }
}

// Namespace deathicons
// Params 3
// Checksum 0x4d00c472, Offset: 0x8a1
// Size: 0x1e9
function function_27e3fdb3fd2bc893( icon, deathiconlocation, team )
{
    wait level.deathicons.var_b3aca5facfff09d6;
    teammates = teams::getfriendlyplayers( team );
    
    foreach ( player in teammates )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( level.deathicons.var_f8992030acff1365 > 0 )
        {
            if ( self.sessionsquadid == player.sessionsquadid )
            {
                continue;
            }
        }
        
        if ( player == self )
        {
            continue;
        }
        
        entityheadicons::setheadicon_removeclientfrommask( icon, player );
    }
    
    if ( level.deathicons.var_f8992030acff1365 > 0 )
    {
        wait level.deathicons.var_f8992030acff1365;
        teammates = teams::getfriendlyplayers( team );
        
        foreach ( player in teammates )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( isdefined( self.sessionsquadid ) && isdefined( player.sessionsquadid ) && self.sessionsquadid != player.sessionsquadid )
            {
                continue;
            }
            
            if ( player == self )
            {
                continue;
            }
            
            entityheadicons::setheadicon_removeclientfrommask( icon, player );
        }
    }
}

// Namespace deathicons
// Params 3
// Checksum 0xc85c1d6b, Offset: 0xa92
// Size: 0x24c
function function_9dd5b4727629a632( icon, deathiconlocation, team )
{
    player = self;
    player endon( #"disconnect" );
    level endon( #"game_ended" );
    player notify( #"death_icon_on" );
    player endon( #"death_icon_on" );
    var_128bed83e68be0dd = player namespace_9d8e359c3b1041e5::isplayerinorgoingtogulagsharedfunc() || player namespace_9d8e359c3b1041e5::isplayerwaitingresurgencerespawnsharedfunc();
    var_ab219bd26743edb6 = player.issolo && isdefined( player.respawndelay ) && player.respawndelay <= 0;
    
    if ( !player::isreallyalive( player ) && !player namespace_9d8e359c3b1041e5::isplayerwaitingresurgencerespawnsharedfunc() && !var_128bed83e68be0dd && !level.useautorespawn && !var_ab219bd26743edb6 && flags::gameflag( "prematch_done" ) )
    {
        return;
    }
    
    if ( level.useautorespawn )
    {
        do
        {
            player waittill( #"playerRespawn_intermission_spawned" );
        }
        while ( player utility::ent_flag( "playerRespawn_intermission_spawned" ) );
    }
    else
    {
        while ( var_128bed83e68be0dd )
        {
            wait 2;
            var_128bed83e68be0dd = player namespace_9d8e359c3b1041e5::isplayerinorgoingtogulagsharedfunc() || player namespace_9d8e359c3b1041e5::isplayerwaitingresurgencerespawnsharedfunc();
        }
    }
    
    if ( isdefined( entityheadicons::setheadicon_getexistingiconinfo( player.lastdeathheadicon ) ) && flags::gameflag( "prematch_done" ) )
    {
        function_65dd049ece71414( player.lastdeathheadicon, "icon_medium_large" );
    }
    
    entityheadicons::setheadicon_addclienttomask( player.lastdeathheadicon, player );
    
    for ( var_91ced993d287c110 = 0; !var_91ced993d287c110 ; var_91ced993d287c110 = 1 )
    {
        wait 1;
        
        if ( isalive( player ) && ( player isonladder() || player ishanging() || player isonground() || player isswimming() || player isswimunderwater() ) )
        {
        }
    }
    
    if ( isdefined( player.lastdeathpos ) )
    {
        if ( distance2d( deathiconlocation, player.origin ) < level.deathicons.var_d7140b84605c2819 )
        {
            wait max( level.deathicons.var_8410911204701fc1, 0 );
        }
    }
    
    entityheadicons::setheadicon_removeclientfrommask( player.lastdeathheadicon, player );
}

// Namespace deathicons
// Params 1
// Checksum 0x1afbd662, Offset: 0xce6
// Size: 0x55
function destroyslowly( timeout )
{
    self endon( #"hash_11067d4da7370dc2" );
    owner = self;
    icon = self.lastdeathheadicon;
    wait timeout;
    entityheadicons::setheadicon_deleteicon( icon );
    
    if ( isdefined( owner ) )
    {
        owner.lastdeathheadicon = undefined;
    }
}

// Namespace deathicons
// Params 1
// Checksum 0x7c381cc8, Offset: 0xd43
// Size: 0x37
function hidedeathicon( player )
{
    if ( !( isdefined( player ) && isdefined( player.lastdeathheadicon ) ) )
    {
        return;
    }
    
    entityheadicons::setheadicon_removeclientfrommask( player.lastdeathheadicon, player );
}

// Namespace deathicons
// Params 1
// Checksum 0xa4110bc9, Offset: 0xd82
// Size: 0x4d
function removedeathicon( player )
{
    if ( !( isdefined( player ) && isdefined( player.lastdeathheadicon ) ) )
    {
        return;
    }
    
    entityheadicons::setheadicon_deleteicon( player.lastdeathheadicon );
    player.lastdeathheadicon = undefined;
    player notify( #"hash_11067d4da7370dc2" );
}

// Namespace deathicons
// Params 0
// Checksum 0x137daaaf, Offset: 0xdd7
// Size: 0x7b
function removealldeathicons()
{
    foreach ( player in level.players )
    {
        removedeathicon( player );
    }
}

// Namespace deathicons
// Params 6
// Checksum 0x521baf66, Offset: 0xe5a
// Size: 0x2c6
function addenemydeathicon( entity, dyingplayer, var_f3403dba6414357b, var_a150ec68c3b39178, timeout, var_2ef538616cb72e6a )
{
    dyingplayer endon( #"disconnect" );
    
    if ( !level.teambased )
    {
        return;
    }
    
    if ( dyingplayer namespace_9d8e359c3b1041e5::isplayeringulagsharedfunc() )
    {
        return;
    }
    
    dyingplayer notify( #"hash_c1aee3f64ea31d08" );
    dyingplayer endon( #"hash_c1aee3f64ea31d08" );
    assert( isarray( var_f3403dba6414357b ) );
    
    if ( !var_2ef538616cb72e6a )
    {
        if ( getdvarint( @"ui_hud_showdeathicons", 1 ) == 0 )
        {
            return;
        }
        
        if ( game_utility::function_d3f8957534dc62af() )
        {
            return;
        }
    }
    
    if ( isdefined( dyingplayer.var_f6cb21a004c2a271 ) )
    {
        foreach ( icon in dyingplayer.var_f6cb21a004c2a271 )
        {
            entityheadicons::setheadicon_deleteicon( icon );
        }
        
        dyingplayer.var_f6cb21a004c2a271 = undefined;
    }
    
    dyingplayer notify( #"hash_5d7103ffd5b57b7b" );
    
    if ( game_utility::function_d3f8957534dc62af() )
    {
        image = "hud_realism_head_death";
        drawthroughgeo = 0;
        maxdrawdist = 768;
        naturaldist = 10;
        
        if ( level.var_3b337a79912ad5b2 )
        {
            image = "hud_icon_death_spawn";
        }
    }
    else
    {
        image = "hud_icon_death_hunter_spawn";
        drawthroughgeo = 1;
        maxdrawdist = 768;
        naturaldist = 0;
        
        if ( level.var_3b337a79912ad5b2 )
        {
            image = "hud_icon_death_spawn";
        }
    }
    
    overrideorigin = dyingplayer.origin;
    
    if ( var_a150ec68c3b39178.size > 0 )
    {
        codcaster_image = "esports_codcaster_waypoint_skull";
        head_icon = dyingplayer entityheadicons::setheadicon_singleimage( var_a150ec68c3b39178, codcaster_image, undefined, drawthroughgeo, maxdrawdist, naturaldist, undefined, undefined, undefined, overrideorigin );
        setheadiconteam( head_icon, dyingplayer.team );
        
        if ( !isdefined( dyingplayer.var_f6cb21a004c2a271 ) )
        {
            dyingplayer.var_f6cb21a004c2a271 = [];
        }
        
        dyingplayer.var_f6cb21a004c2a271[ dyingplayer.var_f6cb21a004c2a271.size ] = head_icon;
    }
    
    if ( var_f3403dba6414357b.size > 0 )
    {
        head_icon = dyingplayer entityheadicons::setheadicon_singleimage( var_f3403dba6414357b, image, undefined, drawthroughgeo, maxdrawdist, naturaldist, undefined, undefined, undefined, overrideorigin );
        
        if ( !isdefined( dyingplayer.var_f6cb21a004c2a271 ) )
        {
            dyingplayer.var_f6cb21a004c2a271 = [];
        }
        
        dyingplayer.var_f6cb21a004c2a271[ dyingplayer.var_f6cb21a004c2a271.size ] = head_icon;
    }
    
    if ( isdefined( dyingplayer.var_f6cb21a004c2a271 ) )
    {
        dyingplayer thread destroyenemyiconslowly( timeout );
    }
}

// Namespace deathicons
// Params 1
// Checksum 0xb511c743, Offset: 0x1128
// Size: 0xbc
function destroyenemyiconslowly( timeout )
{
    self endon( #"hash_5d7103ffd5b57b7b" );
    owner = self;
    icons = self.var_f6cb21a004c2a271;
    wait timeout;
    
    foreach ( icon in icons )
    {
        entityheadicons::setheadicon_deleteicon( icon );
    }
    
    if ( isdefined( owner ) )
    {
        owner.var_f6cb21a004c2a271 = undefined;
    }
}

