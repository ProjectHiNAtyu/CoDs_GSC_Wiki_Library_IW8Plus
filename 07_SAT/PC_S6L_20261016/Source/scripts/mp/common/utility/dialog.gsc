// scripts\mp\common\utility\dialog.gsc  (hash_49ad4836e54c2e6b.gscc) (size: 7166 Bytes / 0x1bfe / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7067ec4e (1885858894)
// size ...... 7166 (0x1bfe)
// includes .. 7   (offset: 0x1ad2)
// strings ... 8   (offset: 0x1b0a)
// dev strs .. 2   (offset: 0x1bde)
// exports ... 19  (offset: 0x12f6)
// cseg ...... 0x110 + 0x11e6 (0x12f6)
// imports ... 41  (offset: 0x15ee)
// animtree1 . 0   (offset: 0x1bfe)
// animtree2 . 0   (offset: 0x1bfe)
#using scripts\common\callbacks;
#using scripts\common\script;
#using scripts\common\utility;
#using scripts\mp\common\utility\dialog_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\operator;

#namespace dialog;

// Namespace dialog
// Params 6
// Checksum 0x2d03d34d, Offset: 0x12e
// Size: 0x136
function leaderdialog( dialog, team, group, excludelist, location, time )
{
    assert( isdefined( level.players ) );
    
    if ( !dialog_utility::dialogueexists( dialog, team ) )
    {
        println( "<dev string:x24>" + getxhashsourcename( dialog ) + "<dev string:x2c>" );
        return;
    }
    
    if ( level.teambased && !isdefined( team ) )
    {
        return;
    }
    
    players = level.players;
    
    if ( isdefined( team ) )
    {
        players = teams::getteamdata( team, "players" );
    }
    
    for ( i = 0; i < players.size ; i++ )
    {
        player = players[ i ];
        
        if ( isdefined( excludelist ) && arraycontains( excludelist, player ) )
        {
            continue;
        }
        
        if ( player issplitscreenplayer() && !player issplitscreenplayerprimary() )
        {
            continue;
        }
        
        if ( isdefined( level.var_20a88e26990ef70a ) && arraycontains( level.var_20a88e26990ef70a, dialog ) )
        {
            continue;
        }
        
        player leaderdialogonplayer_internal( dialog, group, undefined, location, time );
    }
}

// Namespace dialog
// Params 0
// Checksum 0x45049791, Offset: 0x26c
// Size: 0x86
function initstatusdialog()
{
    foreach ( entry in level.teamnamelist )
    {
        level.lastteamstatustime[ entry ][ "" ] = 0;
    }
}

// Namespace dialog
// Params 0
// Checksum 0x574ccc68, Offset: 0x2fa
// Size: 0x23c
function function_d030b7dd67fd809f()
{
    level callback::add( #"hash_1c82c96d0d334fcc", &function_b4a52fbc75585cc0 );
    
    if ( game[ #"hash_b6cddb3c34ceda35" ] == #"completed" )
    {
        return;
    }
    
    game[ #"hash_b6cddb3c34ceda35" ] = #"started";
    
    if ( !isdefined( suppressdialog ) )
    {
        suppressdialog = [];
    }
    
    if ( isdefined( level.gametypebundle.announceroverrides[ #"all" ] ) )
    {
        var_80dd0077bf0b8b62 = getscriptbundle( level.gametypebundle.announceroverrides[ #"all" ].var_bf4ba82d34d86717 );
        
        if ( isdefined( var_80dd0077bf0b8b62 ) )
        {
            suppressdialog = function_25a6831ffb8fbe83( var_80dd0077bf0b8b62, undefined, suppressdialog );
        }
    }
    
    if ( !isdefined( level.longdialoguecooldown ) )
    {
        level.longdialoguecooldown = level.gametypebundle.longdialoguecooldown;
    }
    
    teamnamelist = utility::callsharedfunc( #"game", #"hash_76ca91c8e20f1b72" ) ?? level.teamnamelist;
    
    foreach ( team in teamnamelist )
    {
        if ( !isdefined( game[ "dialog" ][ team ] ) )
        {
            game[ "dialog" ][ team ] = [];
        }
        
        xhashteam = getxhash( team );
        
        if ( isdefined( level.gametypebundle.announceroverrides[ xhashteam ] ) )
        {
            var_80dd0077bf0b8b62 = getscriptbundle( level.gametypebundle.announceroverrides[ xhashteam ].var_bf4ba82d34d86717 );
            
            if ( isdefined( var_80dd0077bf0b8b62 ) )
            {
                suppressdialog = function_25a6831ffb8fbe83( var_80dd0077bf0b8b62, team, suppressdialog );
            }
        }
        
        dialoguebundle = teams::function_1f6fdae0bcdd5de1( team );
        
        if ( isdefined( dialoguebundle ) )
        {
            suppressdialog = function_25a6831ffb8fbe83( dialoguebundle, team, suppressdialog );
        }
    }
    
    level.var_6149c575df2880e6 = undefined;
    game[ #"hash_b6cddb3c34ceda35" ] = #"completed";
}

// Namespace dialog
// Params 1
// Checksum 0x76a713b4, Offset: 0x53e
// Size: 0xa8
function function_b4a52fbc75585cc0( params )
{
    assert( isdefined( self.operatorcustomization ) );
    dialogset = self.operatorcustomization.dialogset;
    
    if ( dialogset != #"" && !isdefined( game[ "dialog" ][ dialogset ] ) )
    {
        if ( !isdefined( game[ "dialog" ][ dialogset ] ) )
        {
            game[ "dialog" ][ dialogset ] = [];
        }
        
        var_7a5e5b9c59ed8562 = operator::function_82d89269854f2e0f( self.operatorcustomization.operatorref );
        
        if ( isdefined( var_7a5e5b9c59ed8562 ) )
        {
            function_25a6831ffb8fbe83( var_7a5e5b9c59ed8562, dialogset );
        }
    }
}

// Namespace dialog
// Params 3
// Checksum 0xd1286406, Offset: 0x5ee
// Size: 0x318
function function_25a6831ffb8fbe83( bundle, dialogset, suppressdialog = [] )
{
    if ( isdefined( level.gametypebundle.var_a4810c65f79ab156 ) )
    {
        gametypecategory = bundle.gametypecategories[ level.gametypebundle.var_a4810c65f79ab156 ];
        
        if ( isdefined( gametypecategory ) )
        {
            suppressdialog = function_f79391b2728a65ba( gametypecategory.events, dialogset, undefined, undefined, suppressdialog );
        }
    }
    
    foreach ( category in bundle.sharedcategories )
    {
        suppressdialog = function_f79391b2728a65ba( category.events, dialogset, undefined, undefined, suppressdialog );
    }
    
    foreach ( killstreak in bundle.killstreaks )
    {
        function_f79391b2728a65ba( killstreak.events, dialogset, killstreak.killstreakref, #"events" );
        function_f79391b2728a65ba( killstreak.pilotevents, dialogset, killstreak.killstreakref, #"pilots" );
        function_209ef66952f70060( killstreak.var_6a12daf73cf5685e, dialogset, killstreak.killstreakref, #"pilots" );
    }
    
    foreach ( super in bundle.supers )
    {
        function_f79391b2728a65ba( super.events, dialogset, super.superref );
    }
    
    foreach ( equipment in bundle.equipment )
    {
        function_f79391b2728a65ba( equipment.events, dialogset, equipment.equipmentref );
    }
    
    return suppressdialog;
}

// Namespace dialog
// Params 1
// Checksum 0xb5ad95c9, Offset: 0x90f
// Size: 0x5c
function function_d3745f8fad33529e( queue )
{
    switch ( tolower( queue ) )
    {
        case #"hash_e0470877d31ceaa8":
            return #"queue1";
        case #"hash_8af104a09175887e":
            return #"queue2";
        case #"hash_298efc3980c8a32a":
            return #"queue3";
    }
}

// Namespace dialog
// Params 5
// Checksum 0xf214a7fd, Offset: 0x973
// Size: 0x36b
function function_f79391b2728a65ba( events, dialogset, var_4145cce44b0de5d0, var_4145cfe44b0dec69, suppressdialog = [] )
{
    if ( !isdefined( events ) )
    {
        return suppressdialog;
    }
    
    foreach ( event in events )
    {
        if ( event.var_27963e135e4f4631 )
        {
            suppressdialog[ event.dialogref ] = 1;
            continue;
        }
        
        if ( isdefined( suppressdialog[ event.dialogref ] ) )
        {
            continue;
        }
        
        if ( !( isdefined( event.dialogref ) && isdefined( event.aliases ) ) || event.aliases.size == 0 )
        {
            continue;
        }
        else if ( event.aliases.size > 0 )
        {
            shouldskip = 0;
            
            foreach ( aliasdata in event.aliases )
            {
                if ( !isdefined( aliasdata.alias ) )
                {
                    shouldskip = 1;
                    break;
                }
            }
            
            if ( shouldskip )
            {
                continue;
            }
        }
        
        if ( isdefined( event.queue ) )
        {
            event.queue = function_d3745f8fad33529e( event.queue );
        }
        
        if ( isdefined( var_4145cce44b0de5d0 ) && isdefined( var_4145cfe44b0dec69 ) )
        {
            assert( isdefined( dialogset ) );
            
            if ( !isdefined( game[ "dialog" ][ dialogset ][ var_4145cce44b0de5d0 ] ) )
            {
                game[ "dialog" ][ dialogset ][ var_4145cce44b0de5d0 ] = [];
            }
            
            if ( !isdefined( game[ "dialog" ][ dialogset ][ var_4145cce44b0de5d0 ][ var_4145cfe44b0dec69 ] ) )
            {
                game[ "dialog" ][ dialogset ][ var_4145cce44b0de5d0 ][ var_4145cfe44b0dec69 ] = [];
            }
            
            if ( !isdefined( game[ "dialog" ][ dialogset ][ var_4145cce44b0de5d0 ][ var_4145cfe44b0dec69 ][ event.dialogref ] ) )
            {
                game[ "dialog" ][ dialogset ][ var_4145cce44b0de5d0 ][ var_4145cfe44b0dec69 ][ event.dialogref ] = event;
            }
            
            continue;
        }
        
        if ( isdefined( var_4145cce44b0de5d0 ) )
        {
            assert( isdefined( dialogset ) );
            
            if ( !isdefined( game[ "dialog" ][ dialogset ][ var_4145cce44b0de5d0 ] ) )
            {
                game[ "dialog" ][ dialogset ][ var_4145cce44b0de5d0 ] = [];
            }
            
            if ( !isdefined( game[ "dialog" ][ dialogset ][ var_4145cce44b0de5d0 ][ event.dialogref ] ) )
            {
                game[ "dialog" ][ dialogset ][ var_4145cce44b0de5d0 ][ event.dialogref ] = event;
            }
            
            continue;
        }
        
        if ( isdefined( dialogset ) )
        {
            if ( !isdefined( game[ "dialog" ][ dialogset ] ) )
            {
                game[ "dialog" ][ dialogset ] = [];
            }
            
            if ( !isdefined( game[ "dialog" ][ dialogset ][ event.dialogref ] ) )
            {
                game[ "dialog" ][ dialogset ][ event.dialogref ] = event;
            }
            
            continue;
        }
        
        if ( !isdefined( game[ "dialog" ][ event.dialogref ] ) )
        {
            game[ "dialog" ][ event.dialogref ] = event;
        }
    }
    
    return suppressdialog;
}

// Namespace dialog
// Params 4
// Checksum 0x18c36003, Offset: 0xce7
// Size: 0xff
function function_209ef66952f70060( events, dialogset, var_4145cce44b0de5d0, var_4145cfe44b0dec69 )
{
    if ( !isdefined( events ) )
    {
        return;
    }
    
    foreach ( event in events )
    {
        if ( !( isdefined( event.dialogref ) && isdefined( event.aliases ) ) || event.aliases.size == 0 )
        {
            continue;
        }
        
        parentevent = dialog_utility::function_51c8a1c4bba55ed2( event.dialogref, dialogset, var_4145cce44b0de5d0, var_4145cfe44b0dec69 );
        
        if ( isdefined( parentevent ) )
        {
            parentevent.response = event;
        }
    }
}

// Namespace dialog
// Params 6
// Checksum 0xff6928c2, Offset: 0xdee
// Size: 0xd9
function statusdialog( dialog, team, group, excludelist, location, time )
{
    if ( level.gameended )
    {
        return;
    }
    
    if ( isdefined( team ) )
    {
        if ( !isdefined( level.lastteamstatustime[ team ][ dialog ] ) )
        {
            level.lastteamstatustime[ team ][ dialog ] = 0;
        }
        
        if ( isdefined( time ) )
        {
            if ( gettime() < level.lastteamstatustime[ team ][ dialog ] + time )
            {
                return;
            }
            
            time = undefined;
        }
        else if ( gettime() < level.lastteamstatustime[ team ][ dialog ] + getdialoguedebouncetime() )
        {
            return;
        }
    }
    
    thread delayedleaderdialog( dialog, team, group, excludelist, location, time );
    
    if ( isdefined( team ) )
    {
        level.lastteamstatustime[ team ][ dialog ] = gettime();
    }
}

// Namespace dialog
// Params 6
// Checksum 0xf6e48a7d, Offset: 0xecf
// Size: 0x61
function delayedleaderdialog( sound, team, group, excludelist, location, time )
{
    level endon( #"game_ended" );
    wait 0.1;
    script::waittillslowprocessallowed();
    leaderdialog( sound, team, group, excludelist, location, time );
}

// Namespace dialog
// Params 2
// Checksum 0xdfe90cb0, Offset: 0xf38
// Size: 0x25
function function_192bd33a73576aca( dialogref, aliasoverride )
{
    game[ #"hash_16421b91fcb141d3" ][ dialogref ] = aliasoverride;
}

// Namespace dialog
// Params 4
// Checksum 0xc6926cf8, Offset: 0xf65
// Size: 0x9e
function leaderdialogonplayers( dialog, players, group, location )
{
    foreach ( player in players )
    {
        player leaderdialogonplayer( dialog, group, undefined, location );
    }
}

// Namespace dialog
// Params 5
// Checksum 0x1e7537a, Offset: 0x100b
// Size: 0x97
function leaderdialogonplayer( dialog, group, groupoverride, location, time )
{
    if ( !dialog_utility::dialogueexists( dialog, self.team ) )
    {
        println( "<dev string:x24>" + getxhashsourcename( dialog ) + "<dev string:x2c>" );
        return;
    }
    
    if ( game[ #"hash_16421b91fcb141d3" ][ dialog ] )
    {
        function_4340020f39f41e13( dialog, game[ #"hash_16421b91fcb141d3" ][ dialog ] );
        return;
    }
    
    leaderdialogonplayer_internal( dialog, group, groupoverride, location, time );
}

// Namespace dialog
// Params 2
// Checksum 0x4d8a7508, Offset: 0x10aa
// Size: 0x2c
function function_4340020f39f41e13( dialog, aliasoverride )
{
    if ( level.disableannouncer )
    {
        return;
    }
    
    dialog_utility::function_4ecb0e9169d57eaa( dialog, aliasoverride );
}

// Namespace dialog
// Params 5
// Checksum 0x3bc667cd, Offset: 0x10de
// Size: 0x13d
function leaderdialogonplayer_internal( dialog, group, groupoverride, location, time )
{
    if ( level.disableannouncer )
    {
        return;
    }
    
    if ( isdefined( level.modeplayerskipdialog ) && self [[ level.modeplayerskipdialog ]]( dialog ) )
    {
        return;
    }
    
    if ( isdefined( time ) )
    {
        time *= 1000;
        
        if ( !isdefined( self.playerlastdialogstatus ) )
        {
            initstatusdialogonplayer();
        }
        
        if ( gettime() < self.playerlastdialogstatus[ "time" ] + time && self.playerlastdialogstatus[ "dialog" ] == dialog )
        {
            return;
        }
        
        self.playerlastdialogstatus[ "time" ] = gettime();
        self.playerlastdialogstatus[ "dialog" ] = dialog;
    }
    
    team = self.pers[ "team" ];
    
    if ( isbrgamemode() )
    {
        utility::callsharedfunc( #"game", #"hash_2000857173f60896", self );
    }
    
    dialogentry = dialog_utility::function_51c8a1c4bba55ed2( dialog, team );
    
    if ( !isdefined( dialogentry ) )
    {
        return;
    }
    
    dialog_utility::dialogonplayer( dialog, dialogentry, team, group, groupoverride, location );
}

// Namespace dialog
// Params 0
// Checksum 0xca8b94e6, Offset: 0x1223
// Size: 0x28
function initstatusdialogonplayer()
{
    self.playerlastdialogstatus[ "time" ] = 0;
    self.playerlastdialogstatus[ "dialog" ] = "";
}

// Namespace dialog
// Params 0
// Checksum 0x6abb3b90, Offset: 0x1253
// Size: 0x19
function getdialoguedebouncetime()
{
    if ( level.longdialoguecooldown )
    {
        return 15000;
    }
    
    return 5000;
}

// Namespace dialog
// Params 0
// Checksum 0x3b732812, Offset: 0x1274
// Size: 0x82
function function_5d010d54a561f605()
{
    switch ( game_utility::getgametype() )
    {
        case #"hash_ec086b911c1011ec":
            game[ "dialog" ][ #"gametype" ] = "iw9_mbtl_prmd_detl_name";
            break;
        case #"hash_fa50b0f6bd82e972":
            game[ "dialog" ][ #"gametype" ] = "iw9_mbtl_mode_uktl_name";
            break;
        case #"hash_eb5e5f470e0c1dc2":
            game[ "dialog" ][ #"gametype" ] = "iw9_cybr_mode_uktl_nam2";
            break;
    }
}

