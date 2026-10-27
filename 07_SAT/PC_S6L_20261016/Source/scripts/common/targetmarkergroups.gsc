// scripts\common\targetmarkergroups.gsc  (hash_4977f963a826a5b5.gscc) (size: 11852 Bytes / 0x2e4c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfb15049d (4212458653)
// size ...... 11852 (0x2e4c)
// includes .. 4   (offset: 0x2c70)
// strings ... 12  (offset: 0x2c90)
// dev strs .. 17  (offset: 0x2d60)
// exports ... 36  (offset: 0x1e1c)
// cseg ...... 0x138 + 0x1ce4 (0x1e1c)
// imports ... 62  (offset: 0x23bc)
// animtree1 . 0   (offset: 0x2e4c)
// animtree2 . 0   (offset: 0x2e4c)
#using scripts\common\callbacks;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\values;

#namespace targetmarkergroups;

// Namespace targetmarkergroups
// Params 0
// Checksum 0x915c5c10, Offset: 0x156
// Size: 0x71
function init()
{
    level.activetargetmarkergroups = [];
    callback::add( #"player_spawned", &targetmarkergroup_clearcacheonspawn );
    utility::registersharedfunc( #"game", #"targetmarkergroup_off", &targetmarkergroup_off );
    utility::registersharedfunc( #"game", #"targetmarkergroup_on", &targetmarkergroup_on );
    level.target_marker_throttle = throttle::throttle_initialize( "target_markers" );
}

// Namespace targetmarkergroups
// Params 10
// Checksum 0x877443cf, Offset: 0x1cf
// Size: 0xfa
function targetmarkergroup_on( markerwidgetname, showto, tomark, groupowner, friendlymarker, markonspawn, var_52abf1a1f858871c, var_1e1ecace3b3c2a63, var_ee7bc8b53cebd37e, var_def1ff63d8a13201 )
{
    if ( level.activetargetmarkergroups.size >= 50 )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    if ( targetmarkergroup_getownedgroups( groupowner ) >= 3 )
    {
        assertmsg( "<dev string:x92>" );
        return;
    }
    
    newtargetmarkergroupid = createtargetmarkergroup( markerwidgetname, var_1e1ecace3b3c2a63, var_ee7bc8b53cebd37e );
    
    if ( !isdefined( newtargetmarkergroupid ) )
    {
        assertmsg( "<dev string:x104>" );
        return;
    }
    else if ( targetmarkergroupexists( newtargetmarkergroupid ) )
    {
        assertmsg( "<dev string:x156>" + newtargetmarkergroupid + "<dev string:x1a1>" );
        return;
    }
    
    level thread addtargetmarkergroup( newtargetmarkergroupid, showto, tomark, groupowner, friendlymarker, markonspawn, var_52abf1a1f858871c, var_def1ff63d8a13201 );
    return newtargetmarkergroupid;
}

// Namespace targetmarkergroups
// Params 1
// Checksum 0xf29bd33d, Offset: 0x2d2
// Size: 0x3f
function targetmarkergroup_off( targetmarkergroupid )
{
    if ( !targetmarkergroupexists( targetmarkergroupid ) )
    {
        assertmsg( "<dev string:x1b2>" + targetmarkergroupid + "<dev string:x1e4>" );
        return;
    }
    
    removetargetmarkergroup( targetmarkergroupid );
    deletetargetmarkergroup( targetmarkergroupid );
}

// Namespace targetmarkergroups
// Params 1
// Checksum 0x914afdcb, Offset: 0x319
// Size: 0xa0
function function_3c0f8d85f1f71d58( ent )
{
    var_63134849bd846199 = 0;
    
    foreach ( markergroup in level.activetargetmarkergroups )
    {
        if ( arraycontains( markergroup.showntoents, ent ) )
        {
            var_63134849bd846199++;
        }
    }
    
    return var_63134849bd846199;
}

// Namespace targetmarkergroups
// Params 2
// Checksum 0x7e17529e, Offset: 0x3c2
// Size: 0x9c
function function_68c6f44397ca287e( targetmarkergroupid, showto )
{
    markergroup = gettargetmarkergroup( targetmarkergroupid );
    assert( isdefined( markergroup ), "<dev string:x1e6>" );
    
    if ( isdefined( showto ) )
    {
        if ( isplayer( showto ) )
        {
            if ( arraycontains( markergroup.showntoents, showto ) )
            {
                return;
            }
            
            if ( function_3c0f8d85f1f71d58( showto ) >= 3 )
            {
                assertmsg( "<dev string:x22a>" );
                return;
            }
            
            markergroup.showntoents[ markergroup.showntoents.size ] = showto;
            addclienttotargetmarkergroupmask( targetmarkergroupid, showto );
        }
    }
}

// Namespace targetmarkergroups
// Params 2
// Checksum 0x30a5a03a, Offset: 0x466
// Size: 0x124
function function_309d1a496a746c5a( targetmarkergroupid, showto )
{
    markergroup = gettargetmarkergroup( targetmarkergroupid );
    assert( isdefined( markergroup ), "<dev string:x1e6>" );
    assert( isdefined( showto ), "<dev string:x2a5>" );
    assert( isarray( showto ), "<dev string:x2e6>" );
    
    foreach ( showtoent in showto )
    {
        if ( isplayer( showtoent ) )
        {
            if ( arraycontains( markergroup.showntoents, showtoent ) )
            {
                continue;
            }
            
            if ( function_3c0f8d85f1f71d58( showtoent ) >= 3 )
            {
                assertmsg( "<dev string:x22a>" );
                continue;
            }
            
            markergroup.showntoents[ markergroup.showntoents.size ] = showtoent;
            addclienttotargetmarkergroupmask( targetmarkergroupid, showtoent );
        }
    }
}

// Namespace targetmarkergroups
// Params 2
// Checksum 0x4e0e2699, Offset: 0x592
// Size: 0x121
function function_499a37cdb452fb02( targetmarkergroupid, showto )
{
    markergroup = gettargetmarkergroup( targetmarkergroupid );
    assert( isdefined( markergroup ), "<dev string:x1e6>" );
    
    if ( isdefined( showto ) )
    {
        if ( isteam( showto ) )
        {
            if ( arraycontains( markergroup.showntoteams, showto ) )
            {
                return;
            }
            
            teaments = level.teamdata[ showto ][ "players" ];
            
            foreach ( player in teaments )
            {
                if ( function_3c0f8d85f1f71d58( player ) >= 3 )
                {
                    assertmsg( "<dev string:x22a>" );
                    return;
                }
            }
            
            markergroup.showntoteams[ markergroup.showntoteams.size ] = showto;
            addteamtotargetmarkergroupmask( targetmarkergroupid, showto );
        }
    }
}

// Namespace targetmarkergroups
// Params 2
// Checksum 0x9dfd62d9, Offset: 0x6bb
// Size: 0x1a9
function function_e3a7c9dbe1fe699e( targetmarkergroupid, showto )
{
    markergroup = gettargetmarkergroup( targetmarkergroupid );
    assert( isdefined( markergroup ), "<dev string:x1e6>" );
    assert( isdefined( showto ), "<dev string:x338>" );
    assert( isarray( showto ), "<dev string:x37d>" );
    
    foreach ( showtoent in showto )
    {
        if ( isteam( showtoent ) )
        {
            if ( arraycontains( markergroup.showntoteams, showtoent ) )
            {
                continue;
            }
            
            teaments = level.teamdata[ showtoent ][ "players" ];
            
            foreach ( player in teaments )
            {
                if ( function_3c0f8d85f1f71d58( player ) >= 3 )
                {
                    assertmsg( "<dev string:x22a>" );
                    break;
                }
            }
            
            markergroup.showntoteams[ markergroup.showntoteams.size ] = showtoent;
            addteamtotargetmarkergroupmask( targetmarkergroupid, showtoent );
        }
    }
}

// Namespace targetmarkergroups
// Params 2
// Checksum 0x24f71996, Offset: 0x86c
// Size: 0x1c4
function function_c67dee3040fbef65( targetmarkergroupid, var_c77011cbf926deac )
{
    markergroup = gettargetmarkergroup( targetmarkergroupid );
    assert( isdefined( markergroup ), "<dev string:x1e6>" );
    
    if ( isdefined( var_c77011cbf926deac ) )
    {
        if ( isarray( var_c77011cbf926deac ) )
        {
            foreach ( remove in var_c77011cbf926deac )
            {
                if ( isplayer( remove ) )
                {
                    if ( arraycontains( markergroup.showntoents, remove ) )
                    {
                        markergroup.showntoents = arrayremove( markergroup.showntoents, remove );
                        removeclientfromtargetmarkergroupmask( targetmarkergroupid, remove );
                    }
                    
                    continue;
                }
                
                if ( isteam( remove ) )
                {
                    if ( arraycontains( markergroup.showntoteams, remove ) )
                    {
                        markergroup.showntoteams = arrayremove( markergroup.showntoteams, remove );
                        removeteamfromtargetmarkergroupmask( targetmarkergroupid, remove );
                    }
                }
            }
            
            return;
        }
        
        if ( isplayer( var_c77011cbf926deac ) )
        {
            if ( arraycontains( markergroup.showntoents, var_c77011cbf926deac ) )
            {
                markergroup.showntoents = arrayremove( markergroup.showntoents, var_c77011cbf926deac );
                removeclientfromtargetmarkergroupmask( targetmarkergroupid, var_c77011cbf926deac );
            }
            
            return;
        }
        
        if ( isteam( var_c77011cbf926deac ) )
        {
            if ( arraycontains( markergroup.showntoteams, var_c77011cbf926deac ) )
            {
                markergroup.showntoteams = arrayremove( markergroup.showntoteams, var_c77011cbf926deac );
                removeteamfromtargetmarkergroupmask( targetmarkergroupid, var_c77011cbf926deac );
            }
        }
    }
}

// Namespace targetmarkergroups
// Params 8
// Checksum 0xd083a856, Offset: 0xa38
// Size: 0x2f1
function addtargetmarkergroup( targetmarkergroupid, showto, tomark, groupowner, friendlymarker, markonspawn, var_52abf1a1f858871c, var_def1ff63d8a13201 )
{
    markergroup = spawnstruct();
    markergroup.markerid = targetmarkergroupid;
    markergroup.markerowner = groupowner;
    markergroup.friendlymarker = friendlymarker;
    markergroup.var_def1ff63d8a13201 = var_def1ff63d8a13201;
    markergroup.showntoents = [];
    markergroup.showntoteams = [];
    markergroup.markedents = [];
    markergroup.markedentsinqueue = [];
    level.activetargetmarkergroups[ level.activetargetmarkergroups.size ] = markergroup;
    level thread targetmarkergroup_handlemarkingfromqueue( targetmarkergroupid );
    
    if ( isdefined( showto ) )
    {
        if ( isarray( showto ) )
        {
            foreach ( showtoent in showto )
            {
                if ( function_3c0f8d85f1f71d58( showtoent ) >= 3 )
                {
                    assertmsg( "<dev string:x22a>" );
                    continue;
                }
                
                if ( isplayer( showtoent ) )
                {
                    markergroup.showntoents[ markergroup.showntoents.size ] = showtoent;
                    addclienttotargetmarkergroupmask( targetmarkergroupid, showtoent );
                    continue;
                }
                
                if ( isteam( showtoent ) )
                {
                    markergroup.showntoteams[ markergroup.showntoteams.size ] = showtoent;
                    addteamtotargetmarkergroupmask( targetmarkergroupid, showtoent );
                }
            }
        }
        else if ( isplayer( showto ) )
        {
            markergroup.showntoents[ markergroup.showntoents.size ] = showto;
            addclienttotargetmarkergroupmask( targetmarkergroupid, showto );
        }
        else if ( isteam( showto ) )
        {
            markergroup.showntoteams[ markergroup.showntoteams.size ] = showto;
            addteamtotargetmarkergroupmask( targetmarkergroupid, showto );
        }
    }
    
    if ( isdefined( tomark ) )
    {
        if ( isarray( tomark ) )
        {
            foreach ( enttomark in tomark )
            {
                targetmarkergroup_markentity( enttomark, targetmarkergroupid, var_52abf1a1f858871c );
            }
        }
        else
        {
            targetmarkergroup_markentity( tomark, targetmarkergroupid, var_52abf1a1f858871c );
        }
    }
    
    if ( markonspawn )
    {
        level thread targetmarkergroup_watchmarkonspawn( targetmarkergroupid, var_52abf1a1f858871c );
    }
    
    if ( var_52abf1a1f858871c )
    {
        level thread targetmarkergroup_watchfornoscopeoutlineperkset( targetmarkergroupid );
        level thread targetmarkergroup_watchfornoscopeoutlineperkunset( targetmarkergroupid );
    }
}

// Namespace targetmarkergroups
// Params 1
// Checksum 0xb857f6, Offset: 0xd31
// Size: 0xfc
function function_1442b6529e65b4d8( targetmarkergroupid )
{
    level endon( #"game_ended" );
    level endon( "removed_targetMarkerGroup_" + targetmarkergroupid );
    
    while ( targetmarkergroupexists( targetmarkergroupid ) )
    {
        markergroup = gettargetmarkergroup( targetmarkergroupid );
        
        if ( markergroup.markedentsinqueue.size > 0 )
        {
            entnum = undefined;
            
            foreach ( ent in markergroup.markedents )
            {
                entnum = ent getentitynumber();
                
                if ( isdefined( entnum ) )
                {
                    ent function_5a317628d8bea4c( markergroup );
                    wait randomfloatrange( 0.1, 0.2 );
                    break;
                }
            }
        }
        
        waitframe();
    }
}

// Namespace targetmarkergroups
// Params 2
// Checksum 0x6657d528, Offset: 0xe35
// Size: 0x37
function setnewowner( targetmarkergroupid, newowner )
{
    tmg = gettargetmarkergroup( targetmarkergroupid );
    tmg.markerowner = newowner;
}

// Namespace targetmarkergroups
// Params 1
// Checksum 0xcf299cb4, Offset: 0xe74
// Size: 0xd0
function removetargetmarkergroup( targetmarkergroupid )
{
    grouptoremove = undefined;
    var_7e2b24254c706c92 = [];
    
    foreach ( markergroup in level.activetargetmarkergroups )
    {
        if ( markergroup.markerid == targetmarkergroupid )
        {
            grouptoremove = markergroup;
            continue;
        }
        
        var_7e2b24254c706c92[ var_7e2b24254c706c92.size ] = markergroup;
    }
    
    if ( isdefined( grouptoremove ) )
    {
        grouptoremove = undefined;
    }
    
    level.activetargetmarkergroups = var_7e2b24254c706c92;
    level notify( "removed_targetMarkerGroup_" + targetmarkergroupid );
}

// Namespace targetmarkergroups
// Params 1
// Checksum 0x900f0fc4, Offset: 0xf4c
// Size: 0xb8
function targetmarkergroupexists( targetmarkergroupid )
{
    groupexists = 0;
    
    if ( !isdefined( targetmarkergroupid ) )
    {
        assertmsg( "<dev string:x3c4>" );
        return groupexists;
    }
    
    foreach ( markergroup in level.activetargetmarkergroups )
    {
        if ( markergroup.markerid == targetmarkergroupid )
        {
            groupexists = 1;
            break;
        }
    }
    
    return groupexists;
}

// Namespace targetmarkergroups
// Params 1
// Checksum 0xae83a144, Offset: 0x100d
// Size: 0xa5
function gettargetmarkergroup( targetmarkergroupid )
{
    if ( !isdefined( targetmarkergroupid ) )
    {
        assertmsg( "<dev string:x3fc>" );
        return;
    }
    
    foreach ( markergroup in level.activetargetmarkergroups )
    {
        if ( markergroup.markerid == targetmarkergroupid )
        {
            return markergroup;
        }
    }
}

// Namespace targetmarkergroups
// Params 2
// Checksum 0x49e39168, Offset: 0x10bb
// Size: 0x64
function targetmarkergroup_watchmarkonspawn( targetmarkergroupid, var_52abf1a1f858871c )
{
    level endon( #"hash_7ab028711a912edc" );
    level endon( "removed_targetMarkerGroup_" + targetmarkergroupid );
    
    while ( true )
    {
        level waittill( #"player_spawned", player );
        
        if ( canbemarkedingroup( targetmarkergroupid, player ) )
        {
            targetmarkergroup_markentity( player, targetmarkergroupid, var_52abf1a1f858871c );
        }
    }
}

// Namespace targetmarkergroups
// Params 1
// Checksum 0xb860055f, Offset: 0x1127
// Size: 0x5a
function targetmarkergroup_watchfornoscopeoutlineperkunset( targetmarkergroupid )
{
    level endon( #"hash_7ab028711a912edc" );
    level endon( "removed_targetMarkerGroup_" + targetmarkergroupid );
    
    while ( true )
    {
        level waittill( #"unset_noscopeoutline", player );
        
        if ( canbemarkedingroup( targetmarkergroupid, player ) )
        {
            targetmarkergroup_markentity( player, targetmarkergroupid );
        }
    }
}

// Namespace targetmarkergroups
// Params 1
// Checksum 0x960e9027, Offset: 0x1189
// Size: 0x5a
function targetmarkergroup_watchfornoscopeoutlineperkset( targetmarkergroupid )
{
    level endon( #"hash_7ab028711a912edc" );
    level endon( "removed_targetMarkerGroup_" + targetmarkergroupid );
    
    while ( true )
    {
        level waittill( #"set_noscopeoutline", player );
        
        if ( canbemarkedingroup( targetmarkergroupid, player ) )
        {
            targetmarkergroup_unmarkentity( player, targetmarkergroupid );
        }
    }
}

// Namespace targetmarkergroups
// Params 0, eflags: 0x4
// Checksum 0x9509ada3, Offset: 0x11eb
// Size: 0x7e
function private function_e319583b038dc9eb()
{
    outxuid = undefined;
    
    if ( isent( self ) )
    {
        if ( isplayer( self ) && !isbot( self ) )
        {
            outxuid = self getxuid();
        }
        else if ( isdefined( self.owner ) && !isbot( self.owner ) && isplayer( self.owner ) )
        {
            outxuid = self.owner getxuid();
        }
        else
        {
            outxuid = self getentitynumber();
        }
    }
    
    return outxuid;
}

// Namespace targetmarkergroups
// Params 3
// Checksum 0xe401b8e9, Offset: 0x1272
// Size: 0x43
function targetmarkergroup_markentity( ent, targetmarkergroupid, var_52abf1a1f858871c )
{
    throttle::throttle_wait_in_queue( level.target_marker_throttle, ent );
    
    if ( isdefined( ent ) )
    {
        ent thread targetmarkergroup_markentityinternal( ent, targetmarkergroupid, var_52abf1a1f858871c );
    }
}

// Namespace targetmarkergroups
// Params 3
// Checksum 0xc0a8f0ee, Offset: 0x12bd
// Size: 0x300
function targetmarkergroup_markentityinternal( ent, targetmarkergroupid, var_52abf1a1f858871c )
{
    self notify( #"hash_ec57e425a4dc2faf" );
    self endon( #"hash_ec57e425a4dc2faf" );
    ent endon( #"death" );
    ent endon( #"disconnect" );
    
    if ( !ent val::get( "show_targetmarker" ) )
    {
        return;
    }
    
    while ( true )
    {
        if ( self.var_b4300d21ff2d6a8e )
        {
            ent waittill( #"hash_bfad9621a40b949" );
        }
        
        if ( self.var_c19506b543ae5021 )
        {
            ent waittill( #"hash_d9461c8b3a52ccb0" );
        }
        
        if ( !self.var_b4300d21ff2d6a8e && !self.var_c19506b543ae5021 )
        {
            break;
        }
    }
    
    markergroup = gettargetmarkergroup( targetmarkergroupid );
    
    if ( !isdefined( markergroup ) )
    {
        return;
    }
    
    if ( !isent( self ) )
    {
        return;
    }
    
    entnum = ent getentitynumber();
    
    if ( !isdefined( entnum ) )
    {
        return;
    }
    
    if ( markergroup.markedents.size >= 20 )
    {
        ent targetmarkergroup_addtomarkingqueue( markergroup );
        
        foreach ( savedent in markergroup.markedents )
        {
            if ( isdefined( savedent ) && markergroup.markedents.size > 20 )
            {
                targetmarkergroup_unmarkentity( savedent, targetmarkergroupid );
                savedent targetmarkergroup_addtomarkingqueue( markergroup );
                continue;
            }
            
            if ( markergroup.markedents.size <= 20 )
            {
                break;
            }
        }
        
        return;
    }
    
    if ( isplayer( ent ) )
    {
        if ( ent.liveragdoll )
        {
            return;
        }
        
        if ( var_52abf1a1f858871c )
        {
            markerowner = markergroup.markerowner;
            checkteam = isdefined( markergroup.friendlymarker );
            isfriendlymarker = istrue( markergroup.friendlymarker );
            
            if ( checkteam )
            {
                if ( !isfriendlymarker )
                {
                    if ( isdefined( ent.perks[ "specialty_noscopeoutline" ] ) )
                    {
                        return;
                    }
                }
            }
            else if ( isdefined( ent.perks[ "specialty_noscopeoutline" ] ) )
            {
                return;
            }
        }
    }
    
    if ( !arraycontains( markergroup.markedents, ent ) && markergroup.markedents.size < 20 )
    {
        markergroup.markedents[ entnum ] = ent;
        targetmarkergroupaddentity( targetmarkergroupid, ent );
        
        if ( isplayer( ent ) )
        {
            ent thread targetmarkergroup_removefromgroupaction( "death", markergroup );
            ent thread targetmarkergroup_removefromgroupaction( "disconnect", markergroup );
            ent thread targetmarkergroup_removefromgroupaction( "joined_team", markergroup );
            ent thread targetmarkergroup_removefromgroupaction( "enter_live_ragdoll", markergroup );
            return;
        }
        
        ent thread targetmarkergroup_removefromgroupaction( "death", markergroup );
    }
}

// Namespace targetmarkergroups
// Params 1
// Checksum 0xe2acfe3f, Offset: 0x15c5
// Size: 0x6c
function function_5a317628d8bea4c( markergroup )
{
    xuid = function_e319583b038dc9eb();
    entnum = self getentitynumber();
    markergroup endon( "ent_removed_" + xuid );
    level endon( "removed_targetMarkerGroup_" + markergroup.markerid );
    targetmarkergroup_addtomarkingqueue( markergroup );
    targetmarkergroup_unmarkentity( self, markergroup.markerid, xuid, entnum );
}

// Namespace targetmarkergroups
// Params 2
// Checksum 0xaced7450, Offset: 0x1639
// Size: 0x72
function targetmarkergroup_removefromgroupaction( action, markergroup )
{
    xuid = function_e319583b038dc9eb();
    entnum = self getentitynumber();
    markergroup endon( "ent_removed_" + xuid );
    level endon( "removed_targetMarkerGroup_" + markergroup.markerid );
    self waittill( action );
    targetmarkergroup_unmarkentity( self, markergroup.markerid, xuid, entnum );
}

// Namespace targetmarkergroups
// Params 1
// Checksum 0x920821e0, Offset: 0x16b3
// Size: 0x7a
function targetmarkergroup_addtomarkingqueue( markergroup )
{
    if ( isdefined( self ) && !arraycontains( markergroup.markedentsinqueue, self ) && markergroup.markedentsinqueue.size < 20 )
    {
        markergroup.markedentsinqueue[ markergroup.markedentsinqueue.size ] = self;
        
        if ( isplayer( self ) )
        {
            thread function_2ea9d4723d980f66( "disconnect", markergroup );
            return;
        }
        
        thread function_2ea9d4723d980f66( "death", markergroup );
    }
}

// Namespace targetmarkergroups
// Params 2
// Checksum 0xf37e4861, Offset: 0x1735
// Size: 0x44
function function_2ea9d4723d980f66( removenotify, markergroup )
{
    level endon( #"game_ended" );
    level endon( "removed_targetMarkerGroup_" + markergroup.markerid );
    self waittill( removenotify );
    targetmarkergroup_removefrommarkingqueue( markergroup );
}

// Namespace targetmarkergroups
// Params 1
// Checksum 0x3d55e39c, Offset: 0x1781
// Size: 0x6a
function targetmarkergroup_removefrommarkingqueue( markergroup )
{
    if ( !isdefined( markergroup ) )
    {
        assertmsg( "<dev string:x431>" );
        return;
    }
    
    newlist = [];
    
    if ( isdefined( self ) )
    {
        newlist = arrayremove( markergroup.markedentsinqueue, self );
    }
    else
    {
        newlist = function_5713d46873b29625( markergroup.markedentsinqueue );
    }
    
    markergroup.markedentsinqueue = newlist;
}

// Namespace targetmarkergroups
// Params 1
// Checksum 0x76036021, Offset: 0x17f3
// Size: 0xd0
function targetmarkergroup_handlemarkingfromqueue( markergroupid )
{
    level endon( #"game_ended" );
    level endon( "removed_targetMarkerGroup_" + markergroupid );
    
    while ( targetmarkergroupexists( markergroupid ) )
    {
        level waittill( #"hash_3193262612319ec9", var_2215a31c8d05b139 );
        markergroup = gettargetmarkergroup( markergroupid );
        
        if ( !isdefined( markergroup ) )
        {
            assertmsg( "<dev string:x479>" );
            break;
        }
        
        if ( var_2215a31c8d05b139 != markergroup )
        {
            continue;
        }
        
        if ( markergroup.markedentsinqueue.size == 0 )
        {
            continue;
        }
        
        enttoadd = undefined;
        
        if ( isdefined( markergroup.markedentsinqueue[ 0 ] ) )
        {
            enttoadd = markergroup.markedentsinqueue[ 0 ];
        }
        
        enttoadd targetmarkergroup_removefrommarkingqueue( markergroup );
        targetmarkergroup_markentity( enttoadd, markergroupid );
    }
}

// Namespace targetmarkergroups
// Params 4
// Checksum 0xe0b11f14, Offset: 0x18cb
// Size: 0xb7
function targetmarkergroup_unmarkentity( ent, targetmarkergroupid, xuid = ent function_e319583b038dc9eb(), entnum )
{
    markergroup = gettargetmarkergroup( targetmarkergroupid );
    
    if ( isdefined( markergroup ) && isdefined( markergroup.markedents ) )
    {
        markergroup.markedents = function_8aefef093c3b18a3( markergroup.markedents, ent );
        
        if ( isdefined( ent ) )
        {
            targetmarkergroupremoveentity( targetmarkergroupid, ent );
        }
        else if ( isdefined( entnum ) )
        {
            function_f41ce08b9c18176d( targetmarkergroupid, entnum );
        }
        
        level notify( #"hash_3193262612319ec9", markergroup );
        markergroup notify( "ent_removed_" + xuid );
    }
}

// Namespace targetmarkergroups
// Params 1
// Checksum 0xa63060f6, Offset: 0x198a
// Size: 0x110
function function_fb26696556bb5e3d( targetmarkergroupid )
{
    markergroup = gettargetmarkergroup( targetmarkergroupid );
    
    if ( isdefined( markergroup ) && isdefined( markergroup.markedents ) )
    {
        foreach ( ent in markergroup.markedents )
        {
            xuid = ent function_e319583b038dc9eb();
            entnum = ent getentitynumber();
            
            if ( isnumber( entnum ) )
            {
                function_f41ce08b9c18176d( targetmarkergroupid, entnum );
            }
            else if ( isdefined( ent ) )
            {
                targetmarkergroupremoveentity( targetmarkergroupid, ent );
            }
            
            level notify( #"hash_3193262612319ec9", markergroup );
            markergroup notify( "ent_removed_" + xuid );
        }
        
        markergroup.markedents = [];
    }
}

// Namespace targetmarkergroups
// Params 2
// Checksum 0x93c5d315, Offset: 0x1aa2
// Size: 0xa5
function function_8aefef093c3b18a3( markedents, enttoremove )
{
    newarray = [];
    
    foreach ( entnumindex, ent in markedents )
    {
        if ( !isdefined( ent ) )
        {
            continue;
        }
        
        if ( enttoremove == ent )
        {
            continue;
        }
        
        newarray[ entnumindex ] = ent;
    }
    
    return newarray;
}

// Namespace targetmarkergroups
// Params 2
// Checksum 0x637df1a4, Offset: 0x1b50
// Size: 0x54, Type: bool
function function_8057fbde5c4ad4d2( target, targetmarkergroupid )
{
    entnum = target getentitynumber();
    markergroup = gettargetmarkergroup( targetmarkergroupid );
    return isdefined( markergroup ) && isdefined( entnum ) && isdefined( markergroup.markedents[ entnum ] );
}

// Namespace targetmarkergroups
// Params 1
// Checksum 0xf781cf4c, Offset: 0x1bad
// Size: 0x9d
function targetmarkergroup_getownedgroups( groupowner )
{
    groupcount = 0;
    
    foreach ( markergroup in level.activetargetmarkergroups )
    {
        if ( markergroup.markerowner == groupowner )
        {
            groupcount++;
        }
    }
    
    return groupcount;
}

// Namespace targetmarkergroups
// Params 1
// Checksum 0x4745e2a8, Offset: 0x1c53
// Size: 0x1b
function targetmarkergroup_clearcacheonspawn( params )
{
    self setclientomnvar( "ui_clear_target_markers", gettime() );
}

// Namespace targetmarkergroups
// Params 1
// Checksum 0xbb58ad08, Offset: 0x1c76
// Size: 0x95, Type: bool
function isteam( showto )
{
    if ( showto == "spectator" )
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

// Namespace targetmarkergroups
// Params 2
// Checksum 0xe92865f2, Offset: 0x1d14
// Size: 0x107
function canbemarkedingroup( targetmarkergroupid, ent )
{
    canbemarked = 0;
    markergroup = gettargetmarkergroup( targetmarkergroupid );
    markergroupowner = markergroup.markerowner;
    checkteam = istrue( level.teambased );
    isfriendlymarker = istrue( markergroup.friendlymarker );
    
    if ( !isdefined( markergroupowner ) )
    {
        return canbemarked;
    }
    
    if ( isfriendlymarker && markergroup.var_def1ff63d8a13201 && ent != markergroupowner )
    {
        return 0;
    }
    
    if ( checkteam )
    {
        if ( isfriendlymarker )
        {
            if ( ent.team == markergroupowner.team )
            {
                canbemarked = 1;
            }
        }
        else if ( ent.team != markergroupowner.team )
        {
            canbemarked = 1;
        }
    }
    else if ( isfriendlymarker )
    {
        if ( ent == markergroupowner )
        {
            canbemarked = 1;
        }
    }
    else if ( ent != markergroupowner )
    {
        canbemarked = 1;
    }
    
    return canbemarked;
}

