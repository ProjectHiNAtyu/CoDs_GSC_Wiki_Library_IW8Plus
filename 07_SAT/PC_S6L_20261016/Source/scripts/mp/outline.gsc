// scripts\mp\outline.gsc  (hash_66d1063967fa26fa.gscc) (size: 13081 Bytes / 0x3319 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6346a822 (1665574946)
// size ...... 13081 (0x3319)
// includes .. 3   (offset: 0x3205)
// strings ... 8   (offset: 0x321d)
// dev strs .. 11  (offset: 0x3295)
// exports ... 41  (offset: 0x239d)
// cseg ...... 0xb9 + 0x22e4 (0x239d)
// imports ... 61  (offset: 0x2a05)
// animtree1 . 0   (offset: 0x3319)
// animtree2 . 0   (offset: 0x3319)
#using script_2b062cc62170d7a8;
#using scripts\mp\common\utility\disconnect_event_aggregator;
#using scripts\mp\common\utility\join_team_aggregator;

#namespace outline;

// Namespace outline
// Params 0
// Checksum 0x27f6b620, Offset: 0xd7
// Size: 0x4c
function init()
{
    level.outlineids = 0;
    level.outlineents = [];
    level.outlineidspending = [];
    disconnect_event_aggregator::registerondisconnecteventcallback( &outlineonplayerdisconnect );
    join_team_aggregator::registeronplayerjointeamcallback( &outlineonplayerjoinedteam );
    namespace_9fd3ecf626067599::registeronplayerjoinsquadcallback( &outlineonplayerjoinedsquad );
    level thread outlineidswatchpending();
}

// Namespace outline
// Params 10
// Checksum 0x26df87be, Offset: 0x12b
// Size: 0x2f7
function outlineenableinternal( var_72bacf1a84917ff4, playersvisibleto, hudoutlineassetname, prioritygroup, type, var_973dacb2daa897a3, squadindex, var_d478999d804948f6 = 0, var_dee59419df84c9c4 = 0, var_51b3f2faa57d7ee8 = 0 )
{
    assert( type != "<dev string:x24>" || isdefined( var_973dacb2daa897a3 ), "<dev string:x29>" );
    assert( type != "<dev string:x7a>" || isdefined( var_973dacb2daa897a3 ) && isdefined( squadindex ), "<dev string:x80>" );
    
    if ( !isdefined( var_72bacf1a84917ff4.outlines ) )
    {
        var_72bacf1a84917ff4.outlines = [];
    }
    
    oinfo = spawnstruct();
    oinfo.isdisabled = 0;
    oinfo.priority = outlineprioritygroupmap( prioritygroup );
    oinfo.prioritygroup = prioritygroup;
    oinfo.playersvisibleto = arraycopy( playersvisibleto );
    oinfo.playersvisibletopending = [];
    oinfo.hudoutlineassetname = hudoutlineassetname;
    oinfo.type = type;
    oinfo.var_dee59419df84c9c4 = var_dee59419df84c9c4;
    
    if ( !isarray( var_973dacb2daa897a3 ) )
    {
        oinfo.teams = [ var_973dacb2daa897a3 ];
    }
    else
    {
        oinfo.teams = var_973dacb2daa897a3;
    }
    
    oinfo.sessionsquadid = squadindex;
    oinfo.permanence = var_d478999d804948f6;
    oinfo.var_51b3f2faa57d7ee8 = var_51b3f2faa57d7ee8;
    id = outlinegenerateuniqueid();
    var_72bacf1a84917ff4.outlines[ id ] = oinfo;
    outlineaddtogloballist( var_72bacf1a84917ff4 );
    var_e9422b6288315136 = [];
    
    foreach ( player in oinfo.playersvisibleto )
    {
        if ( !canoutlineforplayer( player, oinfo ) )
        {
            oinfo.playersvisibletopending[ oinfo.playersvisibletopending.size ] = player;
            level.outlineidspending[ id ] = var_72bacf1a84917ff4;
            continue;
        }
        
        var_af01cd69af2d6e5d = outlinegethighestinfoforplayer( var_72bacf1a84917ff4, player );
        
        if ( !isdefined( var_af01cd69af2d6e5d ) || var_af01cd69af2d6e5d == oinfo || var_af01cd69af2d6e5d.priority == oinfo.priority )
        {
            var_e9422b6288315136[ var_e9422b6288315136.size ] = player;
        }
    }
    
    if ( var_e9422b6288315136.size > 0 )
    {
        var_72bacf1a84917ff4 _hudoutlineenableforclients( var_e9422b6288315136, oinfo.hudoutlineassetname );
    }
    
    var_72bacf1a84917ff4 function_1b5ee52957258e00( 1 );
    return id;
}

// Namespace outline
// Params 3
// Checksum 0xfea36b47, Offset: 0x42b
// Size: 0xa3
function function_b8b81b3d2c58f000( var_72bacf1a84917ff4, hudoutlineassetname, prioritygroup )
{
    if ( !isdefined( var_72bacf1a84917ff4.outlinesviewmodel ) )
    {
        var_72bacf1a84917ff4.outlinesviewmodel = [];
    }
    
    oinfo = { #hudoutlineassetname:hudoutlineassetname, #prioritygroup:prioritygroup };
    oinfo.priority = outlineprioritygroupmap( prioritygroup );
    id = outlinegenerateuniqueid();
    var_72bacf1a84917ff4.outlinesviewmodel[ id ] = oinfo;
    outlineaddtogloballist( var_72bacf1a84917ff4 );
    var_72bacf1a84917ff4 hudoutlineviewmodelenable( hudoutlineassetname );
    return id;
}

// Namespace outline
// Params 2
// Checksum 0x2e877f4a, Offset: 0x4d7
// Size: 0x1f0
function outlinedisableinternal( id, var_a180bd51b09ab4ad )
{
    if ( !isdefined( var_a180bd51b09ab4ad ) )
    {
        level.outlineents = function_5713d46873b29625( level.outlineents );
        return;
    }
    else if ( !isdefined( var_a180bd51b09ab4ad.outlines ) )
    {
        outlineremovefromgloballist( var_a180bd51b09ab4ad );
        return;
    }
    
    var_a180bd51b09ab4ad function_1b5ee52957258e00( 0 );
    var_89c42f83c8b8382a = var_a180bd51b09ab4ad.outlines[ id ];
    
    if ( !isdefined( var_89c42f83c8b8382a ) || var_89c42f83c8b8382a.isdisabled )
    {
        return;
    }
    
    var_89c42f83c8b8382a.isdisabled = 1;
    var_38aba193e92da1b5 = [];
    
    foreach ( player in var_89c42f83c8b8382a.playersvisibleto )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !canoutlineforplayer( player, var_89c42f83c8b8382a ) )
        {
            var_89c42f83c8b8382a.playersvisibletopending[ var_89c42f83c8b8382a.playersvisibletopending.size ] = player;
            level.outlineidspending[ id ] = var_a180bd51b09ab4ad;
            continue;
        }
        
        var_af01cd69af2d6e5d = outlinegethighestinfoforplayer( var_a180bd51b09ab4ad, player );
        
        if ( isdefined( var_af01cd69af2d6e5d ) )
        {
            if ( var_af01cd69af2d6e5d.priority <= var_89c42f83c8b8382a.priority )
            {
                var_a180bd51b09ab4ad _hudoutlineenableforclient( player, var_af01cd69af2d6e5d.hudoutlineassetname );
            }
            
            continue;
        }
        
        var_38aba193e92da1b5[ var_38aba193e92da1b5.size ] = player;
    }
    
    if ( var_38aba193e92da1b5.size > 0 )
    {
        var_a180bd51b09ab4ad hudoutlinedisableforclients( var_38aba193e92da1b5 );
    }
    
    if ( var_89c42f83c8b8382a.playersvisibletopending.size == 0 )
    {
        var_a180bd51b09ab4ad.outlines[ id ] = undefined;
        
        if ( var_a180bd51b09ab4ad.outlines.size == 0 )
        {
            outlineremovefromgloballist( var_a180bd51b09ab4ad );
        }
    }
}

// Namespace outline
// Params 2
// Checksum 0x4f6de709, Offset: 0x6cf
// Size: 0xda
function function_e8a0016e4a4b5903( id, var_a180bd51b09ab4ad )
{
    if ( !isdefined( var_a180bd51b09ab4ad ) )
    {
        level.outlineents = function_5713d46873b29625( level.outlineents );
        return;
    }
    else if ( !isdefined( var_a180bd51b09ab4ad.outlinesviewmodel ) )
    {
        outlineremovefromgloballist( var_a180bd51b09ab4ad );
        return;
    }
    
    var_a180bd51b09ab4ad hudoutlineviewmodeldisable();
    var_89c42f83c8b8382a = var_a180bd51b09ab4ad.outlinesviewmodel[ id ];
    
    if ( !isdefined( var_89c42f83c8b8382a ) || var_89c42f83c8b8382a.isdisabled )
    {
        return;
    }
    
    var_89c42f83c8b8382a.isdisabled = 1;
    var_af01cd69af2d6e5d = function_8574b381ed225072( var_a180bd51b09ab4ad );
    
    if ( isdefined( var_af01cd69af2d6e5d ) )
    {
        if ( var_af01cd69af2d6e5d.priority <= var_89c42f83c8b8382a.priority )
        {
            var_a180bd51b09ab4ad hudoutlineviewmodelenable( var_af01cd69af2d6e5d.hudoutlineassetname );
        }
    }
}

// Namespace outline
// Params 0
// Checksum 0x7ae3c00a, Offset: 0x7b1
// Size: 0x30
function hudoutline_channels_init()
{
    self.hudoutlinechannels = [];
    self.var_d28399809817431 = "outline_depth_white";
    hudoutline_add_channel_internal( "default", 0, self.var_d28399809817431 );
}

// Namespace outline
// Params 3
// Checksum 0x15e8cc23, Offset: 0x7e9
// Size: 0x108
function hudoutline_add_channel_internal( channelname, priority, outlineasset )
{
    if ( !isdefined( self.hudoutlinechannels ) )
    {
        hudoutline_channels_init();
    }
    
    if ( function_ae71e64ef30b2088( self.hudoutlinechannels, channelname ) == -1 )
    {
        channelsize = self.hudoutlinechannels.size;
        index = channelsize > 0 ? channelsize : 0;
        
        for ( i = 0; i < channelsize ; i++ )
        {
            if ( self.hudoutlinechannels[ i ].channelpriority >= priority )
            {
                index = i;
                break;
            }
        }
        
        channelstruct = spawnstruct();
        channelstruct.channelname = channelname;
        channelstruct.channelpriority = priority;
        channelstruct.outlineasset = outlineasset;
        channelstruct.var_c868a57c2268f960 = [];
        arrayinsert( self.hudoutlinechannels, channelstruct, index );
    }
}

// Namespace outline
// Params 3
// Checksum 0xbba1db15, Offset: 0x8f9
// Size: 0x235
function hudoutline_enable_internal( viewer, channelname = "default", hudoutlineasset )
{
    if ( !isdefined( self.hudoutlinechannels ) )
    {
        hudoutline_channels_init();
    }
    
    channelindex = function_ae71e64ef30b2088( self.hudoutlinechannels, channelname );
    
    if ( channelindex == -1 )
    {
        if ( !isdefined( hudoutlineasset ) )
        {
            hudoutlineasset = self.var_d28399809817431;
        }
        
        hudoutline_add_channel_internal( channelname, self.hudoutlinechannels[ 0 ].channelpriority - 1, hudoutlineasset );
        channelindex = function_ae71e64ef30b2088( self.hudoutlinechannels, channelname );
    }
    
    if ( channelname != "default" && isdefined( hudoutlineasset ) && self.hudoutlinechannels[ channelindex ].outlineasset != hudoutlineasset && function_7d3a304550a0b976( channelname, self ) )
    {
        self.hudoutlinechannels[ channelindex ].outlineasset = hudoutlineasset;
        function_8115319bb1ae7b36( channelname, self, hudoutlineasset );
    }
    
    if ( !isdefined( self.hudoutlinecurchannel ) )
    {
        hudoutline_activate_channel( channelname, viewer );
    }
    
    curchannelpriority = self.hudoutlinecurchannel.channelpriority;
    thischannelpriority = self.hudoutlinechannels[ channelindex ].channelpriority;
    self.hudoutlinechannels[ channelindex ].var_c868a57c2268f960 = arraycombineunique( self.hudoutlinechannels[ channelindex ].var_c868a57c2268f960, [ viewer ] );
    
    if ( self.hudoutlinecurchannel.channelname != channelname && curchannelpriority < thischannelpriority )
    {
        hudoutline_activate_channel( channelname, viewer );
        return;
    }
    
    if ( self.hudoutlinecurchannel.channelname == channelname )
    {
        function_ea8667c847036153( self, channelname, viewer );
        return;
    }
    
    if ( self.hudoutlinecurchannel.channelname != channelname && curchannelpriority > thischannelpriority && !arraycontains( self.hudoutlinecurchannel.var_c868a57c2268f960, viewer ) )
    {
        hudoutline_activate_channel( channelname, viewer );
    }
}

// Namespace outline
// Params 2
// Checksum 0xa20d61b3, Offset: 0xb36
// Size: 0x49
function function_ae71e64ef30b2088( channelarray, channelname )
{
    for ( i = 0; i < channelarray.size ; i++ )
    {
        if ( channelarray[ i ].channelname == channelname )
        {
            return i;
        }
    }
    
    return -1;
}

// Namespace outline
// Params 2
// Checksum 0x697a76d3, Offset: 0xb88
// Size: 0x53, Type: bool
function function_7d3a304550a0b976( channelname, ent )
{
    channelindex = function_ae71e64ef30b2088( self.hudoutlinechannels, channelname );
    return channelindex >= 0 && self.hudoutlinechannels[ channelindex ].var_c868a57c2268f960.size > 0;
}

// Namespace outline
// Params 3
// Checksum 0x94c1aa3c, Offset: 0xbe4
// Size: 0x112
function function_ea8667c847036153( ent, channelname, viewer )
{
    if ( !function_69115bc8d45e8f1( ent, viewer ) )
    {
        function_809185fc70accea3( ent, channelname, viewer );
        return;
    }
    
    foreach ( outlinechannel in self.hudoutlinechannels )
    {
        channelindex = function_ae71e64ef30b2088( self.hudoutlinechannels, channelname );
        
        if ( channelindex >= 0 && outlinechannel.channelpriority > self.hudoutlinechannels[ channelindex ].channelpriority && arraycontains( outlinechannel.var_c868a57c2268f960, viewer ) )
        {
            return;
        }
    }
    
    function_809185fc70accea3( ent, channelname, viewer );
}

// Namespace outline
// Params 2
// Checksum 0xf569af24, Offset: 0xcfe
// Size: 0x9f, Type: bool
function function_69115bc8d45e8f1( ent, viewer )
{
    foreach ( channel in ent.hudoutlinechannels )
    {
        if ( arraycontains( channel.var_c868a57c2268f960, viewer ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace outline
// Params 3
// Checksum 0x8f8ac781, Offset: 0xda6
// Size: 0xc6
function function_8115319bb1ae7b36( channelname, ent, hudoutlineasset )
{
    channelindex = function_ae71e64ef30b2088( self.hudoutlinechannels, channelname );
    
    if ( channelindex >= 0 )
    {
        foreach ( viewer in self.hudoutlinechannels[ channelindex ].var_c868a57c2268f960 )
        {
            ent hudoutlineenableforclient( viewer, hudoutlineasset );
        }
    }
}

// Namespace outline
// Params 3
// Checksum 0xebe2115c, Offset: 0xe74
// Size: 0xad
function function_809185fc70accea3( ent, channelname, viewer )
{
    channelindex = function_ae71e64ef30b2088( self.hudoutlinechannels, channelname );
    
    if ( channelindex >= 0 )
    {
        channel = self.hudoutlinechannels[ channelindex ];
        ent hudoutlineenableforclient( viewer, channel.outlineasset );
        
        if ( !arraycontains( channel.var_c868a57c2268f960, viewer ) )
        {
            self.hudoutlinechannels[ channelindex ].var_c868a57c2268f960 = arraycombine( channel.var_c868a57c2268f960, [ viewer ] );
        }
    }
}

// Namespace outline
// Params 2
// Checksum 0x73baca8b, Offset: 0xf29
// Size: 0xa5
function hudoutline_activate_channel( channelname, viewer )
{
    if ( isdefined( self.hudoutlinecurchannel ) && self.hudoutlinecurchannel.channelname != channelname && arraycontains( self.hudoutlinecurchannel.var_c868a57c2268f960, viewer ) )
    {
        function_a232cd494502454d( viewer, self.hudoutlinecurchannel.channelname, 0 );
    }
    
    self.hudoutlinecurchannel = self.hudoutlinechannels[ function_ae71e64ef30b2088( self.hudoutlinechannels, channelname ) ];
    function_ea8667c847036153( self, channelname, viewer );
}

// Namespace outline
// Params 3
// Checksum 0xf2cad405, Offset: 0xfd6
// Size: 0x19a
function function_a232cd494502454d( var_23b1c9e1c62a77df, channelname, deleteviewer = 0 )
{
    if ( !isdefined( self.hudoutlinechannels ) )
    {
        return;
    }
    
    channelindex = function_ae71e64ef30b2088( self.hudoutlinechannels, channelname );
    channel = self.hudoutlinechannels[ channelindex ];
    
    if ( isdefined( channel ) )
    {
        for ( i = 0; i < channel.var_c868a57c2268f960.size ; i++ )
        {
            if ( channel.var_c868a57c2268f960[ i ] == var_23b1c9e1c62a77df )
            {
                self hudoutlinedisableforclient( var_23b1c9e1c62a77df );
                
                if ( deleteviewer )
                {
                    self.hudoutlinechannels[ channelindex ].var_c868a57c2268f960 = arraycopy( channel.var_c868a57c2268f960 );
                    self.hudoutlinechannels[ channelindex ].var_c868a57c2268f960[ i ] = undefined;
                    
                    if ( isint( i ) )
                    {
                        function_cdc669dbc8ea2101( self.hudoutlinechannels[ channelindex ].var_c868a57c2268f960 );
                    }
                }
                
                break;
            }
        }
        
        for ( i = self.hudoutlinechannels.size - 1; i >= 0 ; i-- )
        {
            if ( self.hudoutlinechannels[ i ].channelpriority > channel.channelpriority )
            {
                continue;
            }
            
            if ( arraycontains( self.hudoutlinechannels[ i ].var_c868a57c2268f960, var_23b1c9e1c62a77df ) )
            {
                hudoutline_activate_channel( self.hudoutlinechannels[ i ].channelname, var_23b1c9e1c62a77df );
                break;
            }
        }
    }
}

// Namespace outline
// Params 1
// Checksum 0x71e7d109, Offset: 0x1178
// Size: 0x162
function outlinerefreshinternal( var_a180bd51b09ab4ad )
{
    if ( !isdefined( var_a180bd51b09ab4ad.outlines ) || var_a180bd51b09ab4ad.outlines.size == 0 )
    {
        return;
    }
    
    foreach ( oinfo in var_a180bd51b09ab4ad.outlines )
    {
        if ( !isdefined( oinfo ) || oinfo.isdisabled )
        {
            continue;
        }
        
        foreach ( player in oinfo.playersvisibleto )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            var_af01cd69af2d6e5d = outlinegethighestinfoforplayer( var_a180bd51b09ab4ad, player );
            
            if ( isdefined( var_af01cd69af2d6e5d ) )
            {
                var_a180bd51b09ab4ad _hudoutlineenableforclient( player, var_af01cd69af2d6e5d.hudoutlineassetname );
            }
        }
    }
}

// Namespace outline
// Params 1
// Checksum 0x78c65658, Offset: 0x12e2
// Size: 0x1e
function outlineonplayerdisconnect( player )
{
    outlineremoveplayerfromvisibletoarrays( player );
    outlinedisableinternalall( player );
}

// Namespace outline
// Params 1
// Checksum 0x8b1d8ec4, Offset: 0x1308
// Size: 0x50
function outlineonplayerjoinedteam( player )
{
    if ( !isdefined( player.team ) || player.team == "spectator" || player.team == "codcaster" )
    {
        return;
    }
    
    thread outlineonplayerjoinedteam_onfirstspawn( player );
}

// Namespace outline
// Params 1
// Checksum 0x5f0bf332, Offset: 0x1360
// Size: 0x5c
function outlineonplayerjoinedteam_onfirstspawn( player )
{
    player notify( #"hash_ad8ea7501002cf12" );
    player endon( #"hash_ad8ea7501002cf12" );
    player endon( #"disconnect" );
    player waittill( #"spawned_player" );
    outlineremoveplayerfromvisibletoarrays( player );
    outlinedisableinternalall( player );
    outlineaddplayertoexistingallandteamoutlines( player );
}

// Namespace outline
// Params 1
// Checksum 0x43fe66d9, Offset: 0x13c4
// Size: 0x43
function outlineonplayerjoinedsquad( player )
{
    assert( isdefined( player.team ) && player.team != "<dev string:xe3>", "<dev string:xed>" );
    thread outlineonplayerjoinedsquad_onfirstspawn( player );
}

// Namespace outline
// Params 1
// Checksum 0x95bcb00, Offset: 0x140f
// Size: 0x55
function outlineonplayerjoinedsquad_onfirstspawn( player )
{
    player notify( #"hash_5a3ab8738d4fcd0f" );
    player endon( #"hash_5a3ab8738d4fcd0f" );
    player endon( #"disconnect" );
    player waittill( #"spawned_player" );
    outlineremoveplayerfromvisibletoarrays( player, 1 );
    outlineaddplayertoexistingsquadoutlines( player );
}

// Namespace outline
// Params 2
// Checksum 0x1ef47c8b, Offset: 0x146c
// Size: 0x1cf
function outlineremoveplayerfromvisibletoarrays( player, var_f20ab43441f25125 )
{
    level.outlineents = function_5713d46873b29625( level.outlineents );
    
    foreach ( var_a180bd51b09ab4ad in level.outlineents )
    {
        var_410974a6546360d2 = 0;
        
        if ( !( isdefined( var_a180bd51b09ab4ad ) && isdefined( var_a180bd51b09ab4ad.outlines ) ) )
        {
            continue;
        }
        
        foreach ( oinfo in var_a180bd51b09ab4ad.outlines )
        {
            if ( !isdefined( oinfo.playersvisibleto ) )
            {
                continue;
            }
            
            if ( var_f20ab43441f25125 )
            {
                if ( oinfo.type != "SQUAD" )
                {
                    continue;
                }
            }
            
            oinfo.playersvisibleto = function_5713d46873b29625( oinfo.playersvisibleto );
            
            if ( isdefined( player ) && arraycontains( oinfo.playersvisibleto, player ) )
            {
                oinfo.playersvisibleto = arrayremove( oinfo.playersvisibleto, player );
                var_410974a6546360d2 = 1;
            }
        }
        
        if ( var_410974a6546360d2 && isdefined( var_a180bd51b09ab4ad ) && isdefined( player ) )
        {
            var_a180bd51b09ab4ad hudoutlinedisableforclient( player );
        }
    }
}

// Namespace outline
// Params 1
// Checksum 0xd44f59b5, Offset: 0x1643
// Size: 0x1e3
function outlineaddplayertoexistingallandteamoutlines( player )
{
    foreach ( var_a180bd51b09ab4ad in level.outlineents )
    {
        if ( !isdefined( var_a180bd51b09ab4ad.outlines ) )
        {
            continue;
        }
        
        var_af01cd69af2d6e5d = undefined;
        
        foreach ( oinfo in var_a180bd51b09ab4ad.outlines )
        {
            if ( oinfo.var_51b3f2faa57d7ee8 )
            {
                continue;
            }
            
            if ( oinfo.type == "ALL" || oinfo.type == "TEAM" && arraycontains( oinfo.teams, player.team ) )
            {
                if ( !arraycontains( oinfo.playersvisibleto, player ) )
                {
                    oinfo.playersvisibleto[ oinfo.playersvisibleto.size ] = player;
                }
                else
                {
                    assertmsg( "<dev string:x12e>" );
                }
                
                if ( !isdefined( var_af01cd69af2d6e5d ) || oinfo.priority > var_af01cd69af2d6e5d.priority )
                {
                    var_af01cd69af2d6e5d = oinfo;
                }
            }
        }
        
        if ( isdefined( var_af01cd69af2d6e5d ) )
        {
            var_a180bd51b09ab4ad _hudoutlineenableforclient( player, var_af01cd69af2d6e5d.hudoutlineassetname );
        }
    }
}

// Namespace outline
// Params 1
// Checksum 0x411a12f8, Offset: 0x182e
// Size: 0x205
function outlineaddplayertoexistingsquadoutlines( player )
{
    if ( !isdefined( player.sessionsquadid ) )
    {
        assertmsg( "<dev string:x1d4>" );
    }
    
    foreach ( var_a180bd51b09ab4ad in level.outlineents )
    {
        if ( !isdefined( var_a180bd51b09ab4ad.outlines ) )
        {
            continue;
        }
        
        var_af01cd69af2d6e5d = undefined;
        
        foreach ( oinfo in var_a180bd51b09ab4ad.outlines )
        {
            if ( oinfo.type == "SQUAD" && arraycontains( oinfo.teams, player.team ) && isdefined( oinfo.sessionsquadid ) && oinfo.sessionsquadid == player.sessionsquadid )
            {
                if ( !arraycontains( oinfo.playersvisibleto, player ) )
                {
                    oinfo.playersvisibleto[ oinfo.playersvisibleto.size ] = player;
                }
                else
                {
                    assertmsg( "<dev string:x236>" );
                }
                
                if ( !isdefined( var_af01cd69af2d6e5d ) || oinfo.priority > var_af01cd69af2d6e5d.priority )
                {
                    var_af01cd69af2d6e5d = oinfo;
                }
            }
        }
        
        if ( isdefined( var_af01cd69af2d6e5d ) )
        {
            var_a180bd51b09ab4ad _hudoutlineenableforclient( player, var_af01cd69af2d6e5d.hudoutlineassetname );
        }
    }
}

// Namespace outline
// Params 1
// Checksum 0xf064f970, Offset: 0x1a3b
// Size: 0xcd
function outlinedisableinternalall( var_a180bd51b09ab4ad )
{
    if ( !( isdefined( var_a180bd51b09ab4ad ) && isdefined( var_a180bd51b09ab4ad.outlines ) ) || var_a180bd51b09ab4ad.outlines.size == 0 )
    {
        return;
    }
    
    foreach ( id, _ in var_a180bd51b09ab4ad.outlines )
    {
        if ( !var_a180bd51b09ab4ad.outlines[ id ].permanence )
        {
            outlinedisableinternal( id, var_a180bd51b09ab4ad );
        }
    }
}

// Namespace outline
// Params 1
// Checksum 0x1fbe1d0c, Offset: 0x1b10
// Size: 0x36
function outlineaddtogloballist( var_a180bd51b09ab4ad )
{
    if ( !arraycontains( level.outlineents, var_a180bd51b09ab4ad ) )
    {
        level.outlineents[ level.outlineents.size ] = var_a180bd51b09ab4ad;
    }
}

// Namespace outline
// Params 1
// Checksum 0xeadb2d9, Offset: 0x1b4e
// Size: 0x24
function outlineremovefromgloballist( var_a180bd51b09ab4ad )
{
    level.outlineents = arrayremove( level.outlineents, var_a180bd51b09ab4ad );
}

// Namespace outline
// Params 1
// Checksum 0xbe4def1a, Offset: 0x1b7a
// Size: 0xf6
function outlinegethighestpriorityid( var_a180bd51b09ab4ad )
{
    result = -1;
    
    if ( !isdefined( var_a180bd51b09ab4ad.outlines ) || var_a180bd51b09ab4ad.size == 0 )
    {
        return result;
    }
    
    var_af01cd69af2d6e5d = undefined;
    
    foreach ( id, oinfo in var_a180bd51b09ab4ad.outlines )
    {
        if ( !isdefined( oinfo ) || oinfo.isdisabled )
        {
            continue;
        }
        
        if ( !isdefined( var_af01cd69af2d6e5d ) || oinfo.priority > var_af01cd69af2d6e5d.priority )
        {
            var_af01cd69af2d6e5d = oinfo;
            result = id;
        }
    }
    
    return result;
}

// Namespace outline
// Params 1
// Checksum 0x30e3bb56, Offset: 0x1c79
// Size: 0xdd
function function_8574b381ed225072( var_a180bd51b09ab4ad )
{
    if ( !( var_a180bd51b09ab4ad.outlinesviewmodel.size > 0 ) )
    {
        return;
    }
    
    var_af01cd69af2d6e5d = undefined;
    
    foreach ( oinfo in var_a180bd51b09ab4ad.outlinesviewmodel )
    {
        if ( !isdefined( oinfo ) || oinfo.isdisabled )
        {
            continue;
        }
        
        if ( !isdefined( var_af01cd69af2d6e5d ) || oinfo.priority > var_af01cd69af2d6e5d.priority )
        {
            var_af01cd69af2d6e5d = oinfo;
        }
    }
    
    return var_af01cd69af2d6e5d;
}

// Namespace outline
// Params 2
// Checksum 0xcca1f17a, Offset: 0x1d5f
// Size: 0x10d
function outlinegethighestinfoforplayer( var_a180bd51b09ab4ad, player )
{
    var_af01cd69af2d6e5d = undefined;
    
    if ( !isdefined( var_a180bd51b09ab4ad.outlines ) || var_a180bd51b09ab4ad.outlines.size == 0 )
    {
        return var_af01cd69af2d6e5d;
    }
    
    foreach ( oinfo in var_a180bd51b09ab4ad.outlines )
    {
        if ( !isdefined( oinfo ) || oinfo.isdisabled )
        {
            continue;
        }
        
        if ( arraycontains( oinfo.playersvisibleto, player ) && ( !isdefined( var_af01cd69af2d6e5d ) || oinfo.priority > var_af01cd69af2d6e5d.priority ) )
        {
            var_af01cd69af2d6e5d = oinfo;
        }
    }
    
    return var_af01cd69af2d6e5d;
}

// Namespace outline
// Params 0
// Checksum 0xf7575a8b, Offset: 0x1e75
// Size: 0x2c
function outlinegenerateuniqueid()
{
    assert( isdefined( level.outlineids ), "<dev string:x2e0>" );
    level.outlineids++;
    return level.outlineids;
}

// Namespace outline
// Params 1
// Checksum 0xb60de357, Offset: 0x1eaa
// Size: 0x138
function outlineprioritygroupmap( prioritygroup )
{
    if ( !isxhash( prioritygroup ) )
    {
        assert( 0, prioritygroup );
        prioritygroup = getxhash( prioritygroup );
    }
    
    priority = undefined;
    
    switch ( prioritygroup )
    {
        case #"lowest":
            priority = 0;
            break;
        case #"level_script":
            priority = 1;
            break;
        case #"equipment_lesser":
            priority = 2;
            break;
        case #"perk_lesser":
            priority = 3;
            break;
        case #"equipment":
            priority = 4;
            break;
        case #"perk":
            priority = 5;
            break;
        case #"perk_superior":
            priority = 6;
            break;
        case #"killstreak":
            priority = 7;
            break;
        case #"killstreak_personal":
            priority = 8;
            break;
        case #"laststand":
            priority = 9;
            break;
        case #"top":
            priority = 10;
            break;
        default:
            assertmsg( "<dev string:x332>" + getxhashsourcename( prioritygroup ) );
            priority = 0;
            break;
    }
    
    return priority;
}

// Namespace outline
// Params 0
// Checksum 0xa6b5f92, Offset: 0x1feb
// Size: 0xd3
function outlineiddowatch()
{
    foreach ( index, ent in level.outlineidspending )
    {
        if ( !isdefined( ent ) )
        {
            level.outlineidspending[ index ] = undefined;
            continue;
        }
        
        oinfo = ent.outlines[ index ];
        
        if ( !isdefined( oinfo ) )
        {
            continue;
        }
        
        if ( oinfo.playersvisibletopending.size > 0 )
        {
            if ( outlinerefreshpending( ent, index ) )
            {
                level.outlineidspending[ index ] = undefined;
            }
        }
    }
}

// Namespace outline
// Params 0
// Checksum 0xbe7fba3d, Offset: 0x20c6
// Size: 0x13
function outlineidswatchpending()
{
    while ( true )
    {
        waittillframeend();
        outlineiddowatch();
        waitframe();
    }
}

// Namespace outline
// Params 2
// Checksum 0x1035b8db, Offset: 0x20e1
// Size: 0x175, Type: bool
function outlinerefreshpending( var_a180bd51b09ab4ad, id )
{
    oinfo = var_a180bd51b09ab4ad.outlines[ id ];
    
    foreach ( index, player in oinfo.playersvisibletopending )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( canoutlineforplayer( player, oinfo ) )
        {
            var_af01cd69af2d6e5d = outlinegethighestinfoforplayer( var_a180bd51b09ab4ad, player );
            
            if ( isdefined( var_af01cd69af2d6e5d ) && var_af01cd69af2d6e5d.hudoutlineassetname != "invisible" )
            {
                var_a180bd51b09ab4ad hudoutlineenableforclient( player, var_af01cd69af2d6e5d.hudoutlineassetname );
            }
            else
            {
                var_a180bd51b09ab4ad hudoutlinedisableforclient( player );
            }
            
            oinfo.playersvisibletopending[ index ] = undefined;
        }
    }
    
    oinfo.playersvisibletopending = function_5713d46873b29625( oinfo.playersvisibletopending );
    
    if ( oinfo.playersvisibletopending.size == 0 )
    {
        if ( oinfo.isdisabled )
        {
            var_a180bd51b09ab4ad.outlines[ id ] = undefined;
        }
        
        if ( var_a180bd51b09ab4ad.outlines.size == 0 )
        {
            outlineremovefromgloballist( var_a180bd51b09ab4ad );
        }
        
        return true;
    }
    
    return false;
}

// Namespace outline
// Params 2
// Checksum 0x6078b552, Offset: 0x225f
// Size: 0x35, Type: bool
function canoutlineforplayer( player, oinfo )
{
    return player.sessionstate != "spectator" || oinfo.var_dee59419df84c9c4;
}

// Namespace outline
// Params 2
// Checksum 0xe6a52407, Offset: 0x229d
// Size: 0x88
function function_26073654bc62492c( var_e9422b6288315136, prioritygroup )
{
    foreach ( operator in var_e9422b6288315136 )
    {
        hudoutline_enable_internal( operator, prioritygroup );
    }
}

// Namespace outline
// Params 2
// Checksum 0xe74a2312, Offset: 0x232d
// Size: 0x34
function _hudoutlineenableforclient( client, hudoutlineassetname )
{
    if ( hudoutlineassetname == "invisible" )
    {
        self hudoutlinedisableforclient( client );
        return;
    }
    
    self hudoutlineenableforclient( client, hudoutlineassetname );
}

// Namespace outline
// Params 2
// Checksum 0xfdc2797, Offset: 0x2369
// Size: 0x34
function _hudoutlineenableforclients( clientarray, hudoutlineassetname )
{
    if ( hudoutlineassetname == "invisible" )
    {
        self hudoutlinedisableforclients( clientarray );
        return;
    }
    
    self hudoutlineenableforclients( clientarray, hudoutlineassetname );
}

