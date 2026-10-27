// scripts\mp\entityheadicons.gsc  (hash_1b3b8c05b33df2fd.gscc) (size: 11993 Bytes / 0x2ed9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x341f476c (874465132)
// size ...... 11993 (0x2ed9)
// includes .. 6   (offset: 0x2da9)
// strings ... 15  (offset: 0x2dd9)
// dev strs .. 4   (offset: 0x2ea9)
// exports ... 30  (offset: 0x210d)
// cseg ...... 0x1a4 + 0x1f69 (0x210d)
// imports ... 58  (offset: 0x25bd)
// animtree1 . 0   (offset: 0x2ed9)
// animtree2 . 0   (offset: 0x2ed9)
#using scripts\common\utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\equipment;
#using scripts\mp\hostmigration;
#using scripts\mp\supers;

#namespace entityheadicons;

// Namespace entityheadicons
// Params 0
// Checksum 0xd8061213, Offset: 0x1c2
// Size: 0xd5
function init()
{
    /#
        utility::issharedfuncdefined( #"hostmigration", #"waitLongDurationWithPause", 1 );
    #/
    
    level.var_3b337a79912ad5b2 = getdvarint( @"hash_8ed0da01bb4e0c5f", 1 );
    level.factionfriendlyheadicon = "hud_icon_head_friendly_sm";
    level.factionenemyheadicon = "hud_icon_head_enemy_sm";
    
    if ( function_aeb3fc6af7792562() )
    {
        level.factionfriendlyheadicon = "hud_icon_head_equipment_friendly";
        level.factionenemyheadicon = "hud_icon_head_equipment_enemy";
    }
    
    level.activeheadicons = [];
    level.var_38884805d564da59 = [ "hud_icon_death_spawn", "hud_icon_head_friendly_sm", "hud_icon_head_enemy_sm", "hud_icon_new_marked", "ui_hud_icon_streak", "ui_hud_icon_tactical", "ui_hud_icon_lethal", "ui_hud_icon_field_upgrade" ];
}

// Namespace entityheadicons
// Params 15
// Checksum 0xd7884507, Offset: 0x29f
// Size: 0xc5
function setheadicon_singleimage( showto, image, offset, drawthroughgeo, maxdrawdist, naturaldist, delaytime, var_c6bd58f878e4420a, var_6275850de36415ea, overrideorigin, showonminimap, iconsize, var_2647798941f03f3b, var_36f6867c83910042, var_ec2e1175c694fcf6 )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    icon = setheadicon_createnewicon( undefined, overrideorigin );
    thread setheadicon_singleimageinternal( icon, showto, image, offset, drawthroughgeo, maxdrawdist, naturaldist, delaytime, var_c6bd58f878e4420a, var_6275850de36415ea, overrideorigin, showonminimap, iconsize, var_2647798941f03f3b, var_36f6867c83910042, var_ec2e1175c694fcf6 );
    return icon;
}

// Namespace entityheadicons
// Params 16, eflags: 0x4
// Checksum 0x486b2b6e, Offset: 0x36d
// Size: 0x316
function private setheadicon_singleimageinternal( icon, showto, image, offset, drawthroughgeo, maxdrawdist, naturaldist, delaytime, var_c6bd58f878e4420a, var_6275850de36415ea, overrideorigin, showonminimap, iconsize, var_2647798941f03f3b, var_36f6867c83910042, var_ec2e1175c694fcf6 )
{
    level endon( #"game_ended" );
    
    if ( isdefined( delaytime ) )
    {
        hostmigration::waitlongdurationwithpause( delaytime );
    }
    
    icondata = { #var_2647798941f03f3b:var_2647798941f03f3b ?? 0, #team:var_36f6867c83910042 ?? self.team, #image:image ?? level.gamemodebundle.var_251a2102c50e4fb6, #icon:icon };
    setheadiconimage( icon, icondata.image );
    setheadiconzoffset( icon, offset ?? 30 );
    setheadicondrawthroughgeo( icon, istrue( drawthroughgeo ) );
    setheadiconmaxdistance( icon, maxdrawdist ?? 0 );
    function_68a05eb0c1b31aae( icon, var_ec2e1175c694fcf6 ?? -1 );
    setheadiconnaturaldistance( icon, naturaldist ?? 0 );
    
    foreach ( player in level.players )
    {
        removeclientfromheadiconmask( icon, player );
    }
    
    if ( isarray( showto ) )
    {
        foreach ( showtoent in showto )
        {
            if ( isplayer( showtoent ) )
            {
                addclienttoheadiconmask( icon, showtoent );
                continue;
            }
            
            if ( isteam( showtoent ) )
            {
                addteamtoheadiconmask( icon, showtoent );
            }
        }
    }
    else if ( isplayer( showto ) )
    {
        addclienttoheadiconmask( icon, showto );
    }
    else if ( isteam( showto ) )
    {
        addteamtoheadiconmask( icon, showto );
    }
    
    if ( !var_c6bd58f878e4420a )
    {
        thread setheadicon_watchdeath( icon );
    }
    
    if ( var_6275850de36415ea )
    {
        setheadiconsnaptoedges( icon, 1 );
    }
    
    if ( showonminimap )
    {
        setheadicondrawinmap( icon, 1 );
    }
    
    if ( isplayer( self ) )
    {
        setheadiconowner( icon, self );
    }
    
    setheadiconteam( icon, icondata.team );
    
    if ( function_198d256524325751( icondata ) )
    {
        if ( isdefined( var_36f6867c83910042 ) )
        {
            function_72d8dc3b096411e3( icon, 0 );
        }
        else
        {
            function_72d8dc3b096411e3( icon, 1 );
        }
    }
    
    if ( isdefined( iconsize ) )
    {
        function_65dd049ece71414( icon, iconsize );
    }
}

// Namespace entityheadicons
// Params 14
// Checksum 0x63ab2118, Offset: 0x68b
// Size: 0x30d
function setheadicon_multiimage( showto, friendlyimage, neutralimage, enemyimage, offset, drawthroughgeo, maxdrawdist, naturaldist, delaytime, var_c6bd58f878e4420a, var_6275850de36415ea, overrideorigin, showonminimap, var_ec2e1175c694fcf6 )
{
    level endon( #"game_ended" );
    
    if ( isdefined( delaytime ) )
    {
        hostmigration::waitlongdurationwithpause( delaytime );
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    icon = setheadicon_createnewicon( undefined, overrideorigin );
    
    if ( isdefined( friendlyimage ) )
    {
        setheadiconfriendlyimage( icon, friendlyimage );
    }
    
    if ( isdefined( neutralimage ) )
    {
        setheadiconneutralimage( icon, neutralimage );
    }
    
    if ( isdefined( enemyimage ) )
    {
        setheadiconenemyimage( icon, enemyimage );
    }
    
    if ( !isplayer( self ) )
    {
        if ( !isdefined( self.owner ) && !isdefined( self.team ) )
        {
            assertmsg( "<dev string:x24>" );
            setheadicon_deleteicon( icon );
            return;
        }
        
        if ( isdefined( self.owner ) )
        {
            setheadiconowner( icon, self.owner );
        }
        
        if ( level.teambased && isdefined( self.team ) )
        {
            setheadiconteam( icon, self.team );
        }
    }
    
    setheadiconzoffset( icon, offset ?? 30 );
    setheadicondrawthroughgeo( icon, istrue( drawthroughgeo ) );
    setheadiconmaxdistance( icon, maxdrawdist ?? 0 );
    function_68a05eb0c1b31aae( icon, var_ec2e1175c694fcf6 ?? -1 );
    setheadiconnaturaldistance( icon, naturaldist ?? 0 );
    
    foreach ( player in level.players )
    {
        removeclientfromheadiconmask( icon, player );
    }
    
    if ( isarray( showto ) )
    {
        foreach ( showtoent in showto )
        {
            if ( isplayer( showtoent ) )
            {
                addclienttoheadiconmask( icon, showtoent );
                continue;
            }
            
            if ( isteam( showtoent ) )
            {
                addteamtoheadiconmask( icon, showtoent );
            }
        }
    }
    else if ( isplayer( showto ) )
    {
        addclienttoheadiconmask( icon, showto );
    }
    else if ( isteam( showto ) )
    {
        addteamtoheadiconmask( icon, showto );
    }
    
    if ( !var_c6bd58f878e4420a )
    {
        thread setheadicon_watchdeath( icon );
    }
    
    if ( var_6275850de36415ea )
    {
        setheadiconsnaptoedges( icon, 1 );
    }
    
    if ( showonminimap )
    {
        setheadicondrawinmap( icon, 1 );
    }
    
    return icon;
}

// Namespace entityheadicons
// Params 14
// Checksum 0x387a80b8, Offset: 0x9a1
// Size: 0x25d
function setheadicon_factionimage( showtoallfactions, offset, drawthroughgeo, maxdrawdist, naturaldist, delaytime, var_c6bd58f878e4420a, ownerinvisible, overrideorigin, showonminimap, image, iconsize, var_2647798941f03f3b, var_ec2e1175c694fcf6 )
{
    if ( game_utility::function_d3f8957534dc62af() )
    {
        return;
    }
    
    level endon( #"game_ended" );
    
    if ( isdefined( delaytime ) )
    {
        hostmigration::waitlongdurationwithpause( delaytime );
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    icon = setheadicon_createnewicon( undefined, overrideorigin );
    icondata = spawnstruct();
    icondata.icon = icon;
    icondata.image = image ?? level.gamemodebundle.var_251a2102c50e4fb6;
    icondata.team = self.team;
    icondata.entowner = self.owner;
    icondata.showtoallfactions = showtoallfactions ?? 0;
    icondata.ownerinvisible = ownerinvisible ?? 0;
    icondata.var_2647798941f03f3b = var_2647798941f03f3b ?? 1;
    
    if ( !isdefined( offset ) )
    {
        offset = 30;
    }
    
    setheadiconzoffset( icondata.icon, offset );
    
    if ( !isdefined( drawthroughgeo ) )
    {
        drawthroughgeo = 0;
    }
    
    setheadicondrawthroughgeo( icondata.icon, drawthroughgeo );
    
    if ( !isdefined( maxdrawdist ) )
    {
        maxdrawdist = 768;
    }
    
    setheadiconmaxdistance( icondata.icon, maxdrawdist );
    function_68a05eb0c1b31aae( icondata.icon, var_ec2e1175c694fcf6 ?? -1 );
    
    if ( !isdefined( naturaldist ) )
    {
        naturaldist = 0;
    }
    
    setheadiconnaturaldistance( icondata.icon, naturaldist );
    
    if ( isdefined( iconsize ) )
    {
        function_65dd049ece71414( icon, iconsize );
    }
    
    if ( !var_c6bd58f878e4420a )
    {
        thread setheadicon_watchdeath( icondata.icon );
    }
    
    if ( showonminimap )
    {
        setheadicondrawinmap( icon, 1 );
    }
    
    _updateiconowner( icondata );
    thread setheadicon_watchfornewowner( icondata );
    useteamswitch = getdvarint( @"hash_264312901607c2ac", 1 );
    
    if ( useteamswitch )
    {
        thread setheadicon_watchforteamswitch( icondata );
    }
    
    return icondata.icon;
}

// Namespace entityheadicons
// Params 1
// Checksum 0x393fead8, Offset: 0xc07
// Size: 0x4df
function _updateiconowner( icondata )
{
    self notify( #"hash_548094e8ccdef0ae" );
    
    if ( icondata.showtoallfactions )
    {
        if ( isdefined( icondata.image ) )
        {
            setheadiconfriendlyimage( icondata.icon, icondata.image );
            setheadiconneutralimage( icondata.icon, icondata.image );
            setheadiconenemyimage( icondata.icon, icondata.image );
        }
        else
        {
            setheadiconfriendlyimage( icondata.icon, level.factionfriendlyheadicon );
            setheadiconneutralimage( icondata.icon, level.factionenemyheadicon );
            setheadiconenemyimage( icondata.icon, level.factionenemyheadicon );
        }
        
        if ( !isplayer( self ) )
        {
            if ( !isdefined( self.owner ) && !isdefined( self.team ) )
            {
                assertmsg( "<dev string:x86>" );
                setheadicon_deleteicon( icondata.icon );
                return;
            }
            
            if ( isplayer( self.owner ) )
            {
                setheadiconowner( icondata.icon, self.owner );
            }
            
            if ( level.teambased && isdefined( self.team ) )
            {
                setheadiconteam( icondata.icon, self.team );
            }
            
            if ( function_198d256524325751( icondata ) )
            {
                function_72d8dc3b096411e3( icondata.icon, 1 );
            }
        }
    }
    else
    {
        setheadiconimage( icondata.icon, icondata.image );
        
        if ( self.owner && isplayer( self.owner ) )
        {
            setheadiconowner( icondata.icon, self.owner );
        }
        
        if ( isdefined( self.team ) )
        {
            setheadiconteam( icondata.icon, self.team );
        }
        
        if ( function_198d256524325751( icondata ) )
        {
            function_72d8dc3b096411e3( icondata.icon, 1 );
        }
    }
    
    foreach ( player in level.players )
    {
        removeclientfromheadiconmask( icondata.icon, player );
    }
    
    if ( icondata.showtoallfactions )
    {
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( icondata.ownerinvisible && player == self.owner )
            {
                continue;
            }
            
            addclienttoheadiconmask( icondata.icon, player );
        }
        
        thread setheadicon_watchforlateconnect( icondata.icon );
        return;
    }
    
    if ( !isdefined( self.owner ) && !isdefined( self.team ) )
    {
        assertmsg( "<dev string:xfc>" );
        setheadicon_deleteicon( icondata.icon );
        return;
    }
    
    team = self.owner.team ? self.owner.team : self.team;
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( level.teambased && isdefined( team ) && player.team != team )
        {
            continue;
        }
        
        if ( !level.teambased && player != self.owner )
        {
            continue;
        }
        
        if ( icondata.ownerinvisible && player == self.owner )
        {
            continue;
        }
        
        addclienttoheadiconmask( icondata.icon, player );
    }
}

// Namespace entityheadicons
// Params 1
// Checksum 0x7b972f42, Offset: 0x10ee
// Size: 0x7b
function setheadicon_watchforlateconnect( icon )
{
    self endon( #"death" );
    self endon( #"hash_548094e8ccdef0ae" );
    self endon( #"headicon_deleted" );
    
    if ( isplayer( self ) )
    {
        self endon( #"disconnect" );
    }
    
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"connected", player );
        thread setheadicon_watchforlatespawn( icon, player );
    }
}

// Namespace entityheadicons
// Params 2
// Checksum 0x993f754e, Offset: 0x1171
// Size: 0x7d
function setheadicon_watchforlatespawn( icon, player )
{
    self endon( #"death" );
    self endon( #"hash_548094e8ccdef0ae" );
    self endon( #"headicon_deleted" );
    
    if ( isplayer( self ) )
    {
        self endon( #"disconnect" );
    }
    
    level endon( #"game_ended" );
    
    while ( true )
    {
        player waittill( #"spawned_player" );
        
        if ( isdefined( player ) )
        {
            addclienttoheadiconmask( icon, player );
        }
    }
}

// Namespace entityheadicons
// Params 1
// Checksum 0x71e8a2ad, Offset: 0x11f6
// Size: 0x96
function setheadicon_watchfornewowner( icondata )
{
    self endon( #"death" );
    self endon( #"headicon_deleted" );
    
    if ( isplayer( self ) )
    {
        self endon( #"disconnect" );
    }
    
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( isdefined( self.owner ) && icondata.entowner != self.owner )
        {
            icondata.entowner = self.owner;
            _updateiconowner( icondata );
        }
        
        wait 0.1;
    }
}

// Namespace entityheadicons
// Params 1
// Checksum 0xfc8f4ce5, Offset: 0x1294
// Size: 0xde
function setheadicon_watchforteamswitch( icondata )
{
    level endon( #"game_ended" );
    self endon( #"headicon_deleted" );
    self endon( #"death" );
    
    while ( true )
    {
        level waittill( #"add_to_team", player );
        removeclientfromheadiconmask( icondata.icon, player );
        
        if ( icondata.showtoallfactions )
        {
            addclienttoheadiconmask( icondata.icon, player );
            continue;
        }
        
        if ( !isdefined( self.owner ) )
        {
            setheadicon_deleteicon( icondata.icon );
            return;
        }
        
        if ( player.team != self.owner.team )
        {
            continue;
        }
        
        addclienttoheadiconmask( icondata.icon, player );
    }
}

// Namespace entityheadicons
// Params 1
// Checksum 0xb7e18314, Offset: 0x137a
// Size: 0x5c
function setheadicon_watchdeath( icon )
{
    level endon( #"game_ended" );
    self endon( #"headicon_deleted" );
    
    if ( isplayer( self ) && !isbot( self ) )
    {
        self waittill( #"death_or_disconnect" );
    }
    else
    {
        self waittill( #"death" );
    }
    
    thread setheadicon_deleteicon( icon );
}

// Namespace entityheadicons
// Params 1
// Checksum 0xebcff01f, Offset: 0x13de
// Size: 0xa1, Type: bool
function isteam( showto )
{
    if ( showto == "spectator" || showto == "codcaster" )
    {
        return true;
    }
    
    foreach ( teamname in level.teamnamelist )
    {
        if ( showto == teamname )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace entityheadicons
// Params 2
// Checksum 0x9e0938ae, Offset: 0x1488
// Size: 0xf2
function setheadicon_createnewicon( prioritygroup = 0, overrideorigin )
{
    if ( !setheadicon_allowiconcreation() )
    {
        setheadicon_removeoldicon( prioritygroup );
    }
    
    newicon = undefined;
    
    if ( isdefined( overrideorigin ) )
    {
        newicon = createheadiconatorigin( overrideorigin );
    }
    else
    {
        newicon = createheadicon( self );
    }
    
    if ( !isdefined( newicon ) || newicon < 0 )
    {
        /#
            var_33ba376a106491b7 = self;
            
            if ( isdefined( self.owner ) )
            {
                var_33ba376a106491b7 = self.owner;
            }
            
            var_33ba376a106491b7 iprintlnbold( "<dev string:x172>" );
        #/
        
        return;
    }
    
    iconinfo = { #timecreated:gettime(), #prioritygroup:prioritygroup, #entmarked:self, #icon:newicon };
    level.activeheadicons[ iconinfo.icon ] = iconinfo;
    return iconinfo.icon;
}

// Namespace entityheadicons
// Params 1
// Checksum 0x591af7cc, Offset: 0x1583
// Size: 0x70
function setheadicon_deleteicon( icon )
{
    iconinfo = setheadicon_getexistingiconinfo( icon );
    
    if ( isdefined( iconinfo ) )
    {
        if ( isdefined( iconinfo.entmarked ) )
        {
            iconinfo.entmarked notify( #"headicon_deleted" );
        }
        
        deleteheadicon( iconinfo.icon );
        level.activeheadicons[ iconinfo.icon ] = undefined;
    }
}

// Namespace entityheadicons
// Params 4
// Checksum 0x5c993853, Offset: 0x15fb
// Size: 0x1af
function setheadicon_equipment( equipment, imageoverride, originoverride, var_2647798941f03f3b )
{
    if ( !( isdefined( equipment ) && isdefined( equipment.weapon_name ) ) )
    {
        return;
    }
    
    bundle = equipment.bundle ?? equipment_mp::getEquipmentBundleFromWeaponName( equipment.weapon_name );
    icondata = function_76fdf2d96729e6eb( bundle );
    
    if ( !icondata.enable )
    {
        return;
    }
    
    equiptype = bundle.equipmenttype;
    image = undefined;
    
    if ( equiptype == "lethal" )
    {
        image = level.gamemodebundle.var_251a2102c50e4fb6 ?? "ui_hud_icon_lethal";
    }
    else if ( equiptype == "tactical" )
    {
        image = level.gamemodebundle.var_b96d2dfbabc4742d ?? "ui_hud_icon_tactical";
    }
    else
    {
        image = level.gamemodebundle.var_a43747faa623d1b0 ?? "ui_hud_icon_field_upgrade";
    }
    
    if ( isdefined( imageoverride ) )
    {
        image = imageoverride;
    }
    
    return equipment setheadicon_factionimage( icondata.showtoall, icondata.offset, icondata.drawthroughgeo, icondata.maxdrawdist, icondata.naturaldist, icondata.delaytime, icondata.var_c6bd58f878e4420a, icondata.var_ed3628d65eca3b3f, originoverride, icondata.var_68bcd4109b2d2f88, image, icondata.worldsize, var_2647798941f03f3b, icondata.var_ec2e1175c694fcf6 );
}

// Namespace entityheadicons
// Params 5
// Checksum 0x9cddce13, Offset: 0x17b3
// Size: 0x1ef
function setheadicon_fieldupgrade( fieldupgradeent, imageoverride, originoverride, var_2647798941f03f3b, var_5da2d67c0914101f )
{
    if ( !( isdefined( fieldupgradeent ) && isdefined( fieldupgradeent.superref ) ) )
    {
        return;
    }
    
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( fieldupgradeent.superref );
    icondata = function_76fdf2d96729e6eb( bundle );
    
    if ( isdefined( var_5da2d67c0914101f ) )
    {
        icondata = var_5da2d67c0914101f;
    }
    
    if ( !icondata.enable )
    {
        return;
    }
    
    image = level.gamemodebundle.var_a43747faa623d1b0 ?? "ui_hud_icon_field_upgrade";
    
    if ( isdefined( imageoverride ) )
    {
        image = imageoverride;
    }
    
    headicon = undefined;
    
    if ( icondata.onlyowner )
    {
        headicon = fieldupgradeent setheadicon_singleimage( icondata.showto, image, icondata.offset, icondata.drawthroughgeo, icondata.maxdrawdist, icondata.naturaldist, icondata.delaytime, icondata.var_c6bd58f878e4420a, icondata.var_6275850de36415ea, originoverride, icondata.var_68bcd4109b2d2f88, icondata.worldsize, var_2647798941f03f3b, icondata.var_ec2e1175c694fcf6 );
    }
    else
    {
        headicon = fieldupgradeent setheadicon_factionimage( icondata.showtoall, icondata.offset, icondata.drawthroughgeo, icondata.maxdrawdist, icondata.naturaldist, icondata.delaytime, icondata.var_c6bd58f878e4420a, icondata.var_ed3628d65eca3b3f, originoverride, icondata.var_68bcd4109b2d2f88, image, icondata.worldsize, var_2647798941f03f3b, icondata.var_ec2e1175c694fcf6 );
    }
    
    return headicon;
}

// Namespace entityheadicons
// Params 4
// Checksum 0x8da6cf0d, Offset: 0x19ab
// Size: 0x13a
function setheadicon_killstreak( streakent, imageoverride, originoverride, var_2647798941f03f3b )
{
    streakname = streakent.streakinfo.streakname;
    
    if ( !isdefined( streakname ) )
    {
        return;
    }
    
    bundle = killstreak_utility::function_f943c0602acdc2af( streakname );
    icondata = function_76fdf2d96729e6eb( bundle );
    
    if ( !icondata.enable )
    {
        return;
    }
    
    image = level.gamemodebundle.var_345ef9e4a8b98096 ?? "ui_hud_icon_streak";
    
    if ( isdefined( imageoverride ) )
    {
        image = imageoverride;
    }
    
    return streakent setheadicon_factionimage( icondata.showtoall, icondata.offset, icondata.drawthroughgeo, icondata.maxdrawdist, icondata.naturaldist, icondata.delaytime, icondata.var_c6bd58f878e4420a, icondata.var_ed3628d65eca3b3f, originoverride, icondata.var_68bcd4109b2d2f88, image, icondata.worldsize, var_2647798941f03f3b, icondata.var_ec2e1175c694fcf6 );
}

// Namespace entityheadicons
// Params 1
// Checksum 0x40c80861, Offset: 0x1aee
// Size: 0x169
function function_76fdf2d96729e6eb( bundle )
{
    icondata = spawnstruct();
    icondata.enable = bundle.headicon_enable ?? 0;
    icondata.showtoall = bundle.headicon_showtoall ?? 0;
    icondata.drawthroughgeo = bundle.headicon_drawthroughgeo ?? 0;
    icondata.var_c6bd58f878e4420a = bundle.var_cf53a699bcb581fe ?? 0;
    icondata.var_ed3628d65eca3b3f = bundle.var_988bd648ece8d377 ?? 0;
    icondata.var_68bcd4109b2d2f88 = bundle.var_8d44d03cadd809dc ?? 0;
    icondata.offset = bundle.headicon_offset ?? 0;
    icondata.maxdrawdist = bundle.var_1ac222e0fc15d67a ?? 768;
    icondata.naturaldist = bundle.headicon_naturaldist ?? 0;
    icondata.delaytime = bundle.headicon_delaytime ?? 0;
    icondata.worldsize = bundle.var_a2132be96c43b09f ?? "icon_regular";
    icondata.var_ec2e1175c694fcf6 = bundle.var_cdb7d38b7c9e666 ?? -1;
    return icondata;
}

// Namespace entityheadicons
// Params 0
// Checksum 0x855e8948, Offset: 0x1c60
// Size: 0x10, Type: bool
function setheadicon_allowiconcreation()
{
    return level.activeheadicons.size < 1023;
}

// Namespace entityheadicons
// Params 1
// Checksum 0x2b8672c0, Offset: 0x1c79
// Size: 0x18
function setheadicon_getexistingiconinfo( icon )
{
    return level.activeheadicons[ icon ];
}

// Namespace entityheadicons
// Params 1
// Checksum 0xa368da4c, Offset: 0x1c9a
// Size: 0x3b
function setheadicon_removeoldicon( var_709dffc252bf05b6 )
{
    lowestpriority = setheadicon_findlowestprioritygroup( var_709dffc252bf05b6 );
    oldestcreatedicon = setheadicon_findoldestcreatedicon( lowestpriority );
    setheadicon_deleteicon( oldestcreatedicon );
}

// Namespace entityheadicons
// Params 1
// Checksum 0xbb294d21, Offset: 0x1cdd
// Size: 0xa8
function setheadicon_findlowestprioritygroup( var_709dffc252bf05b6 )
{
    lowestpriority = var_709dffc252bf05b6;
    
    foreach ( iconinfo in level.activeheadicons )
    {
        if ( lowestpriority > iconinfo.prioritygroup )
        {
            lowestpriority = iconinfo.prioritygroup;
        }
    }
    
    return lowestpriority;
}

// Namespace entityheadicons
// Params 1
// Checksum 0x7f994d63, Offset: 0x1d8e
// Size: 0xcf
function setheadicon_findoldestcreatedicon( var_18390b6a1b1bdbcc )
{
    var_b453acfc98582a04 = undefined;
    oldesticon = undefined;
    
    foreach ( iconinfo in level.activeheadicons )
    {
        if ( !isdefined( var_b453acfc98582a04 ) && !isdefined( oldesticon ) || var_b453acfc98582a04.timecreated > iconinfo.timecreated )
        {
            var_b453acfc98582a04 = iconinfo;
            oldesticon = iconinfo.icon;
        }
    }
    
    return oldesticon;
}

// Namespace entityheadicons
// Params 2
// Checksum 0x26316bb7, Offset: 0x1e66
// Size: 0x99
function function_1efc2b37fd66cc90( headicon, teams )
{
    if ( !isarray( teams ) )
    {
        teams = [ teams ];
    }
    
    foreach ( team in teams )
    {
        addteamtoheadiconmask( headicon, team );
    }
}

// Namespace entityheadicons
// Params 2
// Checksum 0x41e8734e, Offset: 0x1f07
// Size: 0x99
function function_57b1edf6f2986e84( headicon, teams )
{
    if ( !isarray( teams ) )
    {
        teams = [ teams ];
    }
    
    foreach ( team in teams )
    {
        removeteamfromheadiconmask( headicon, team );
    }
}

// Namespace entityheadicons
// Params 2
// Checksum 0x3df37f05, Offset: 0x1fa8
// Size: 0x37
function setheadicon_addclienttomask( headicon, client )
{
    iconinfo = setheadicon_getexistingiconinfo( headicon );
    
    if ( isdefined( iconinfo ) )
    {
        addclienttoheadiconmask( headicon, client );
    }
}

// Namespace entityheadicons
// Params 2
// Checksum 0x982b4bd4, Offset: 0x1fe7
// Size: 0x37
function setheadicon_removeclientfrommask( headicon, client )
{
    iconinfo = setheadicon_getexistingiconinfo( headicon );
    
    if ( isdefined( iconinfo ) )
    {
        removeclientfromheadiconmask( headicon, client );
    }
}

// Namespace entityheadicons
// Params 1
// Checksum 0xe263fb5a, Offset: 0x2026
// Size: 0xcd, Type: bool
function function_198d256524325751( icondata )
{
    if ( icondata.var_2647798941f03f3b )
    {
        return true;
    }
    
    if ( level.var_3b337a79912ad5b2 )
    {
        if ( level.teambased && !isdefined( icondata.team ) )
        {
            return false;
        }
        
        foreach ( name in level.var_38884805d564da59 )
        {
            if ( name == icondata.image )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace entityheadicons
// Params 0
// Checksum 0x98b5ca71, Offset: 0x20fc
// Size: 0x10
function function_aeb3fc6af7792562()
{
    return getdvarint( @"hash_1d8c3eb547f8c176", 0 );
}

