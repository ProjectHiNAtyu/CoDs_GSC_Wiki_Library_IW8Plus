// scripts\mp\ob\systems\ob_nightmare_portal.gsc  (hash_152a94b9023267bb.gscc) (size: 25054 Bytes / 0x61de / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd23802c6 (3526886086)
// size ...... 25054 (0x61de)
// includes .. 22  (offset: 0x5b8e)
// strings ... 89  (offset: 0x5c3e)
// dev strs .. 21  (offset: 0x60da)
// exports ... 49  (offset: 0x3e96)
// cseg ...... 0x74a + 0x374c (0x3e96)
// imports ... 173 (offset: 0x463e)
// animtree1 . 0   (offset: 0x61de)
// animtree2 . 0   (offset: 0x61de)
#using script_162f01e3286930e2;
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\scripted_widgets;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\widgets_visibility;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\coop;
#using scripts\mp\gametypes\ob;
#using scripts\mp\hud_message;
#using scripts\mp\interaction;
#using scripts\mp\ob\systems\countdown_timer;
#using scripts\mp\ob\systems\ob_activity_instance_common;
#using scripts\mp\ob\systems\ob_exfil;
#using scripts\mp\objective_marker_bundle_helper_mp;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\overlord;
#using scripts\mp\squads;

#namespace ob_nightmare_portal;

// Namespace ob_nightmare_portal
// Params 0, eflags: 0x5
// Checksum 0xb7701024, Offset: 0x768
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"ob_nightmare_portal", undefined, undefined, &init );
}

// Namespace ob_nightmare_portal
// Params 0, eflags: 0x4
// Checksum 0xf4f97f92, Offset: 0x789
// Size: 0x4e9
function private init()
{
    level.var_bb93bd616fa0487 = [ "libra":{ #var_4aa6738b2d38de08:10, #var_4b3aa7cc6a25d636:10, #briefdelay:9, #var_77c7046aedb80092:"vo_wlin_glitch_brief_libra", #splash:#"nm_portal_prime_target", #scriptable:%"sat_ob_nightmare_portal_libra", #shardnum:50, #index:4, #var_5e15e3487ecb4588:474 }, "gemini":{ #var_4aa6738b2d38de08:9, #var_4b3aa7cc6a25d636:9, #briefdelay:9, #var_77c7046aedb80092:"vo_wlin_glitch_brief_gemini", #splash:#"hash_3ff96379bc45a801", #scriptable:%"sat_ob_nightmare_portal_gemini", #shardnum:40, #index:3, #var_5e15e3487ecb4588:473 }, "virgo":{ #var_4aa6738b2d38de08:8, #var_4b3aa7cc6a25d636:8, #briefdelay:9, #var_77c7046aedb80092:"vo_wlin_glitch_brief_virgo", #splash:#"hash_8f6929bb80e64b8f", #scriptable:%"sat_ob_nightmare_portal_virgo", #shardnum:30, #index:2, #var_5e15e3487ecb4588:472 }, "aries":{ #var_4aa6738b2d38de08:7, #var_4b3aa7cc6a25d636:1, #briefdelay:9, #var_77c7046aedb80092:"vo_wlin_glitch_brief_aries", #splash:#"hash_21183c949fab650e", #scriptable:%"sat_ob_nightmare_portal_aries", #shardnum:20, #index:1, #var_5e15e3487ecb4588:471 }, "leo":{ #var_4aa6738b2d38de08:7, #var_4b3aa7cc6a25d636:1, #briefdelay:9, #var_77c7046aedb80092:"vo_wlin_glitch_brief_leo", #splash:#"nm_portal_enabled", #scriptable:%"sat_ob_nightmare_portal_leo", #shardnum:10, #index:0, #var_5e15e3487ecb4588:470 } ];
    
    if ( !isdefined( level.var_efaf944e1cea53d0 ) )
    {
        level.var_efaf944e1cea53d0 = getdvarint( @"hash_fdb034fec0293ad", 1 );
    }
    
    utility::registersharedfunc( #"hash_561b73e89e879cb7", #"hash_3fa3c8cca94e4308", &function_c8ea5ed993c2e4c0 );
    
    if ( !ob::nightmare_portal() && !ob::nightmare_shard() )
    {
        return;
    }
    
    setdvar( @"hash_dd9310e204f05a1f", 1 );
    ob_settings = ob::get_ob_settings();
    
    if ( ob_settings.var_aab22481530ff9ff )
    {
        return;
    }
    
    utility::flag_wait( "scriptables_ready" );
    level.var_c1b03c2c7b333b9b = [];
    entrances_structs = utility::getstructarray( "ob_nightmare_entrance", "targetname" );
    
    foreach ( entrance_struct in entrances_structs )
    {
        entrance_struct setup_entrance_portal();
    }
    
    assert( level.nightmareportals.size == level.var_bb93bd616fa0487.size, "<dev string:x24>" + level.var_bb93bd616fa0487.size + "<dev string:x3b>" );
    level callback::add( #"hash_cc06eb1d45f33a0c", &function_37904b06ac0bfaf1 );
    level callback::add( #"hash_513cfdee5f84f52d", &function_fd4d3ad9cba79915 );
    level callback::add( #"hash_18ed4a357bbe06eb", &function_430714da57926e95 );
    utility::registersharedfunc( #"hash_bd51c0eb64757b15", #"hash_8e3aa0d7f8e95e22", &function_d21bf49e60775a0b );
    
    if ( function_7c401a266a4ee0ca() )
    {
        callback::add( "ob_nightmare_shard_collected", &function_d4e87539e4ab187e );
    }
    
    if ( !isdefined( level.vote_hud ) )
    {
        level.vote_hud = vote_system_shared::register_vote_hud();
    }
    
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_2534a0ffd7cbc606", &function_cd7c73c5a4a61ea );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"nightmare_complete_mission", &dev_complete_mission );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_103420bf6830d73c", &dev_enable_portal );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_faf593dd548f037b", &function_bec51d5bcc71b26 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_7152e5bce4222399", &function_4ccf8d59a5d897ee );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_40aaaeb69946b512", &function_d0de09c74ea8bbc4 );
}

// Namespace ob_nightmare_portal
// Params 4, eflags: 0x4
// Checksum 0xf8dca3cf, Offset: 0xc7a
// Size: 0x112
function private nm_portal_log( squad, missionid, players, outmessage )
{
    msg = "[NM_PORTAL][Squad:" + ( squad.index ?? "?" ) + "][" + missionid + "]: ";
    
    foreach ( listplayer in players )
    {
        msg = msg + "<" + ( listplayer.name ?? "?" ) + ":" + listplayer getentitynumber() + ":" + listplayer.sessionsquadid + "> ";
    }
    
    msg += outmessage;
    logstring( msg );
}

// Namespace ob_nightmare_portal
// Params 0, eflags: 0x4
// Checksum 0xc55c7c87, Offset: 0xd94
// Size: 0x182
function private setup_entrance_portal()
{
    id = self.script_noteworthy;
    
    if ( !isdefined( id ) )
    {
        assertmsg( "<dev string:x5c>" + self.origin );
        return;
    }
    
    self.portalid = id;
    self.activeplayers = [];
    created = 0;
    scriptable = undefined;
    
    if ( function_479a91629c936167() > 0 )
    {
        scriptable = spawnscriptable( level.var_bb93bd616fa0487[ id ].scriptable ?? %"sat_ob_nightmare_portal", self.origin, self.angles );
        ob_activity_instance_common::function_63e771caf6df0970( scriptable, 5 );
        scriptable.portal = self;
        self.scriptable = scriptable;
        created++;
    }
    
    if ( function_479a91629c936167() > 0 )
    {
        scriptableprompt = spawnscriptable( %"sat_ob_nightmare_portal_prompt", self.origin, self.angles );
        interaction::register_scriptable_interact( scriptableprompt, &on_portal_interact, undefined, &function_3c0d500d1249a9b );
        scriptableprompt.portal = self;
        self.scriptableprompt = scriptableprompt;
        created++;
    }
    
    if ( created < 2 )
    {
        assertmsg( "<dev string:x83>" );
    }
    
    level.nightmareportals[ id ] = self;
    
    if ( isdefined( scriptable.index ) )
    {
        level.var_c1b03c2c7b333b9b[ scriptable.index ] = self;
    }
    
    thread function_abed7e5375d5f8ff();
    thread function_98ae70f18196cd1();
}

// Namespace ob_nightmare_portal
// Params 0, eflags: 0x4
// Checksum 0xf58979dc, Offset: 0xf1e
// Size: 0x12, Type: bool
function private portals_enabled()
{
    return getdvarint( @"scr_ob_nightmare_portal_disable", 0 ) == 0;
}

// Namespace ob_nightmare_portal
// Params 0, eflags: 0x4
// Checksum 0xda5e953f, Offset: 0xf39
// Size: 0x1a, Type: bool
function private function_7c401a266a4ee0ca()
{
    return ob::nightmare_shard() && getdvarint( @"hash_a67be0b0b8623208", 0 );
}

// Namespace ob_nightmare_portal
// Params 0, eflags: 0x4
// Checksum 0x13034eb5, Offset: 0xf5c
// Size: 0x41
function private function_59963ac3879d7121()
{
    if ( function_7c401a266a4ee0ca() && utility::issharedfuncdefined( #"hash_561b73e89e879cb7", #"hash_bc299ecad4d99dcc" ) )
    {
        return utility::callsharedfunc( #"hash_561b73e89e879cb7", #"hash_bc299ecad4d99dcc" );
    }
    
    return 0;
}

// Namespace ob_nightmare_portal
// Params 1, eflags: 0x4
// Checksum 0x132e3c6f, Offset: 0xfa6
// Size: 0x6d, Type: bool
function private function_abe971f792641911( portalid )
{
    if ( level.var_efaf944e1cea53d0 && !function_5d0d7d2b56f5a95( portalid ) )
    {
        return false;
    }
    
    if ( function_7c401a266a4ee0ca() )
    {
        mission_info = level.var_bb93bd616fa0487[ portalid ];
        shard_count = function_59963ac3879d7121();
        
        if ( mission_info.shardnum > shard_count )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace ob_nightmare_portal
// Params 0, eflags: 0x4
// Checksum 0xb3b8a4b1, Offset: 0x101c
// Size: 0x199
function private function_3fe18929a5be62f3()
{
    portalsenabled = portals_enabled();
    
    foreach ( var_8136100ae1df249c, portal in level.nightmareportals )
    {
        assert( portal.scriptable scriptablemaskallowed() );
        assert( portal.scriptableprompt scriptablemaskallowed() );
        is_portal_unlocked = function_abe971f792641911( var_8136100ae1df249c );
        
        if ( is_portal_unlocked && portalsenabled )
        {
            if ( !arraycontains( portal.activeplayers, self ) )
            {
                portal.scriptable function_6113853a877d5460( self );
                portal.scriptableprompt function_6113853a877d5460( self );
                portal.activeplayers[ portal.activeplayers.size ] = self;
            }
            
            continue;
        }
        
        if ( !portal.scriptable function_50b79f4d4032e234( self ) )
        {
            portal.scriptable function_d6a7b7ef13a57f38( self );
        }
        
        if ( !portal.scriptableprompt function_50b79f4d4032e234( self ) )
        {
            portal.scriptableprompt function_d6a7b7ef13a57f38( self );
        }
        
        if ( arraycontains( portal.activeplayers, self ) )
        {
            portal.activeplayers = arrayremove( portal.activeplayers, self );
        }
    }
}

// Namespace ob_nightmare_portal
// Params 1, eflags: 0x4
// Checksum 0x220aa85, Offset: 0x11bd
// Size: 0x2c
function private function_d4e87539e4ab187e( param )
{
    player = param.player;
    player function_3fe18929a5be62f3();
}

// Namespace ob_nightmare_portal
// Params 1, eflags: 0xc
// Checksum 0x5c097331, Offset: 0x11f1
// Size: 0x75
function private function_37904b06ac0bfaf1( params )
{
    self notify( #"hash_598d6544400f5374" );
    self endon( #"hash_598d6544400f5374" );
    self endon( #"disconnect" );
    self notify( #"nm_portal_leave_squad" );
    waitframe();
    function_3fe18929a5be62f3();
    squad = teams::function_72b89edf6b47c40a( self );
    
    if ( squad )
    {
        squad function_b26fb0454453aced( squad.var_ec3e8b015e4ce3df ?? 1 );
    }
}

// Namespace ob_nightmare_portal
// Params 3, eflags: 0x4
// Checksum 0x43e34e5a, Offset: 0x126e
// Size: 0x182
function private function_d21bf49e60775a0b( notification, pingindex, arg1 )
{
    if ( notification == "calloutmarkerping_added" )
    {
        pingtarget = self calloutmarkerping_getent( pingindex );
        
        if ( !pingtarget.index )
        {
            return;
        }
        
        portal = level.var_c1b03c2c7b333b9b[ pingtarget.index ];
        
        if ( !portal.scriptable || portal.scriptable != pingtarget )
        {
            return;
        }
        
        hiddenfrom = [];
        shownto = [];
        squad = teams::function_72b89edf6b47c40a( self );
        
        if ( squad.players )
        {
            foreach ( player in squad.players )
            {
                if ( !player function_5d0d7d2b56f5a95( portal.portalid ) )
                {
                    hiddenfrom[ player.guid ] = player;
                    continue;
                }
                
                shownto[ player.guid ] = player;
            }
        }
        
        if ( hiddenfrom.size == 0 )
        {
            return;
        }
        
        thread function_f6f354965769fc63( portal, pingindex, hiddenfrom, shownto );
    }
}

// Namespace ob_nightmare_portal
// Params 4, eflags: 0x4
// Checksum 0xca670762, Offset: 0x13f8
// Size: 0x16f
function private function_f6f354965769fc63( portal, pingindex, hiddenfrom, shownto )
{
    self endon( #"disconnect" );
    var_6675b0888e2dbc2 = function_1bf3a084cfe14025( 8 );
    newpingindex = calloutmarkerping::function_a3f0d6526c09f579( var_6675b0888e2dbc2, portal.origin + ( 0, 0, 20 ) );
    
    foreach ( guid, player in hiddenfrom )
    {
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        self calloutmarkerping_hide( pingindex, player );
    }
    
    foreach ( guid, player in shownto )
    {
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        self calloutmarkerping_hide( newpingindex, player );
    }
    
    self waittill( "predictiveCalloutClear_" + pingindex );
    calloutmarkerping::function_7c0ee9d4b604e6d6( newpingindex );
}

// Namespace ob_nightmare_portal
// Params 1
// Checksum 0x9d4fbc6c, Offset: 0x156f
// Size: 0x42
function function_5d0d7d2b56f5a95( id )
{
    mission_info = level.var_bb93bd616fa0487[ id ];
    return self getplayerdata( level.var_6f9b00680ed002d8, "nmMissionUnlocked", mission_info.index );
}

// Namespace ob_nightmare_portal
// Params 1
// Checksum 0xee9bd8db, Offset: 0x15ba
// Size: 0x6b
function function_f30d484ccde619be( id )
{
    var_fa17dfa36d85fe69 = function_5d0d7d2b56f5a95( id );
    
    if ( !var_fa17dfa36d85fe69 )
    {
        mission_info = level.var_bb93bd616fa0487[ id ];
        self setplayerdata( level.var_6f9b00680ed002d8, "nmMissionUnlocked", mission_info.index, 1 );
        thread function_3bc476da64183020();
        function_3fe18929a5be62f3();
    }
}

// Namespace ob_nightmare_portal
// Params 1, eflags: 0x4
// Checksum 0x4ae07621, Offset: 0x162d
// Size: 0x53
function private function_7bab68e56a20a95f( missionid )
{
    mission_info = level.var_bb93bd616fa0487[ missionid ];
    
    if ( isdefined( mission_info.index ) )
    {
        return self getplayerdata( level.var_6f9b00680ed002d8, "nmMissionCompleted", mission_info.index );
    }
    
    return 0;
}

// Namespace ob_nightmare_portal
// Params 1, eflags: 0x4
// Checksum 0xd4b0350, Offset: 0x1689
// Size: 0x99
function private function_c8ea5ed993c2e4c0( id )
{
    if ( !ob::nightmare() )
    {
        return;
    }
    
    mission_completed = function_7bab68e56a20a95f( id );
    
    if ( !mission_completed )
    {
        mission_info = level.var_bb93bd616fa0487[ id ];
        
        if ( isdefined( mission_info.index ) )
        {
            self setplayerdata( level.var_6f9b00680ed002d8, "nmMissionCompleted", mission_info.index, 1 );
            thread function_3bc476da64183020( 3 );
            return;
        }
        
        assertmsg( "<dev string:xa7>" + id + "<dev string:xb1>" );
    }
}

// Namespace ob_nightmare_portal
// Params 1, eflags: 0xc
// Checksum 0xb009b4da, Offset: 0x172a
// Size: 0x42
function private function_3bc476da64183020( source = 4 )
{
    self notify( #"hash_77b6ec26d2ee087" );
    self endon( #"hash_77b6ec26d2ee087" );
    self endon( #"disconnect" );
    waitframe();
    self function_432458e83a394206( source );
}

// Namespace ob_nightmare_portal
// Params 0, eflags: 0x4
// Checksum 0xb4c5ee15, Offset: 0x1774
// Size: 0x9e
function private function_f30b220ba90ef73c()
{
    if ( !isdefined( self.var_91b28ce8838e0dec ) )
    {
        scriptable = self.scriptable;
        objidnum = objective_marker_bundle_helper_mp::mp_createobjectivemarkerfrombundlexhash( %"hash_4ea01b6847a7cc1b" );
        objidpoolmanager::function_eb808b97701a4793( objidnum );
        objidpoolmanager::function_daf59ee8ea2cb071( objidnum );
        objidpoolmanager::update_objective_position( objidnum, scriptable.origin + ( 0, 0, 0 ) );
        function_e79ad5f5fb225e7c( objidnum, 0 );
        objective_disableping( objidnum, 1 );
        self.var_91b28ce8838e0dec = objidnum;
    }
    
    thread function_836577a67e149116();
    return self.var_91b28ce8838e0dec;
}

// Namespace ob_nightmare_portal
// Params 0, eflags: 0xc
// Checksum 0x430ff3c7, Offset: 0x181b
// Size: 0x52
function private function_836577a67e149116()
{
    self notify( #"hash_c387fd0d1b8050dc" );
    self endon( #"hash_c387fd0d1b8050dc" );
    level endon( #"game_ended" );
    
    if ( !isdefined( self.var_91b28ce8838e0dec ) )
    {
        return;
    }
    
    wait 10;
    objidpoolmanager::returnobjectiveid( self.var_91b28ce8838e0dec );
    self.var_91b28ce8838e0dec = undefined;
}

// Namespace ob_nightmare_portal
// Params 2
// Checksum 0x1f8403, Offset: 0x1875
// Size: 0xc6
function enable_nightmare_portal( players, portalname )
{
    if ( !isarray( players ) )
    {
        return;
    }
    
    if ( !portals_enabled() )
    {
        return;
    }
    
    foreach ( player in players )
    {
        was_portal_enabled = player function_5d0d7d2b56f5a95( portalname );
        
        if ( !was_portal_enabled )
        {
            player function_f30d484ccde619be( portalname );
        }
        
        player thread post_portal_enabled( portalname, 5, !was_portal_enabled );
    }
}

// Namespace ob_nightmare_portal
// Params 3, eflags: 0xc
// Checksum 0x8ba8f78f, Offset: 0x1943
// Size: 0x242
function private post_portal_enabled( portalname, delay, var_57ac30dc0946875b = 1 )
{
    self notify( #"hash_1cbc799db85aaa6" );
    self endon( #"hash_1cbc799db85aaa6" );
    self endon( #"disconnect" );
    
    switch ( tolower( portalname ) )
    {
        case #"hash_2f473c6c225c787f":
            level callback::callback( #"nm_portal_leo", { #players:[ self ] } );
            break;
        case #"hash_621de11a66b8b95":
            level callback::callback( #"nm_portal_aries", { #players:[ self ] } );
            break;
        case #"hash_b03b4ce755915804":
            level callback::callback( #"nm_portal_virgo", { #players:[ self ] } );
            break;
        case #"hash_a2ee5eef3c31d6ee":
            level callback::callback( #"nm_portal_gemini", { #players:[ self ] } );
            break;
        case #"hash_ed831d287b669661":
            level callback::callback( #"nm_portal_libra", { #players:[ self ] } );
            break;
        default:
            assertmsg( "<dev string:xd5>" + portalname + "<dev string:x102>" );
            break;
    }
    
    wait delay;
    var_77c7046aedb80092 = level.var_bb93bd616fa0487[ portalname ].var_77c7046aedb80092;
    splash = level.var_bb93bd616fa0487[ portalname ].splash;
    
    if ( var_57ac30dc0946875b && var_77c7046aedb80092 )
    {
        briefdelay = level.var_bb93bd616fa0487[ portalname ].briefdelay;
        level thread overlord::playconversation( var_77c7046aedb80092, [ self ] );
        
        if ( briefdelay && briefdelay > 0 )
        {
            wait briefdelay;
        }
    }
    
    thread function_16884b533562394( portalname, [ self ] );
    waitframe();
    
    if ( splash )
    {
        squad = teams::function_72b89edf6b47c40a( self );
        nm_portal_log( squad, portalname, [ self ], "Portal unlock splash - " + portalname );
        thread hud_message::showsplash( splash );
    }
}

// Namespace ob_nightmare_portal
// Params 2, eflags: 0x4
// Checksum 0x631ee1b9, Offset: 0x1b8d
// Size: 0x1df
function private function_16884b533562394( id, players )
{
    portal = level.nightmareportals[ id ];
    scriptable = portal.scriptable;
    objidnum = portal function_f30b220ba90ef73c();
    waitframe();
    
    foreach ( player in players )
    {
        assert( player function_abe971f792641911( id ), "<dev string:x104>" + id );
        scriptable calloutmarkerping::function_608710c894185549( player );
        objective_addclienttomask( objidnum, player );
    }
    
    var_59b6b3e08cc798ff = level.gametypebundle.var_7b2c0bd7b762b029 ?? 1500;
    var_c5e2d088c596aa47 = level.gametypebundle.var_8d87d33bf6766724 ?? 500;
    var_659f72f4ff3f7064 = ( var_59b6b3e08cc798ff + var_c5e2d088c596aa47 ) * 0.001;
    wait var_659f72f4ff3f7064;
    scriptable_index = scriptable getscriptableindex();
    
    foreach ( player in players )
    {
        objective_removeclientfrommask( objidnum, player );
        ping_id = player calloutmarkerping::function_920a63c06abdefe8( scriptable_index );
        player calloutmarkerping_hide( ping_id );
        player calloutmarkerping_show( ping_id, player );
    }
}

// Namespace ob_nightmare_portal
// Params 1, eflags: 0x4
// Checksum 0x9d1bd47a, Offset: 0x1d74
// Size: 0x64
function private function_3c0d500d1249a9b( player )
{
    player endon( #"disconnect" );
    valgroup = "nm_portal_interact_started";
    player val::set( valgroup, "killstreaks", 0 );
    player val::set( valgroup, "remote_killstreaks", 0 );
    player utility::waittill_any_timeout( 1, "nm_portal_leave_squad" );
    player val::reset_all( valgroup );
}

// Namespace ob_nightmare_portal
// Params 1, eflags: 0x4
// Checksum 0x557b95dc, Offset: 0x1de0
// Size: 0x58
function private on_portal_interact( player )
{
    scriptable = self;
    portal = scriptable.portal;
    assert( portal.scriptableprompt == scriptable );
    function_8d12cbc8967869c( portal.portalid, player );
}

// Namespace ob_nightmare_portal
// Params 2, eflags: 0x4
// Checksum 0xba327f7b, Offset: 0x1e40
// Size: 0xf8
function private function_8d12cbc8967869c( missionid, player )
{
    player endon( #"death_or_disconnect" );
    mission_info = level.var_bb93bd616fa0487[ missionid ];
    player setclientomnvar( "ui_nm_mission_index", mission_info.index );
    player widgets_visibility::hide( "mission_select", [ #"ingamemissionselect" ], 1, 1 );
    player scripted_widgets::create( "mission_select", "scripted_widget_mission_select_screen" );
    squad = teams::function_72b89edf6b47c40a( player );
    nm_portal_log( squad, missionid, [ player ], "Mission Select Open" );
    ret = player utility::waittill_any_return( "mission_initiate", "mission_select_cancel", "vote_started" );
    
    if ( ret == "mission_initiate" )
    {
        thread function_f57bd2985246fecf( missionid, player, mission_info.var_5e15e3487ecb4588 );
    }
    
    function_9438d5947f8d940d( squad, missionid, player );
}

// Namespace ob_nightmare_portal
// Params 3, eflags: 0x4
// Checksum 0x59338aa7, Offset: 0x1f40
// Size: 0x50
function private function_9438d5947f8d940d( squad, missionid, player )
{
    nm_portal_log( squad, missionid, [ player ], "Mission Select Close" );
    player scripted_widgets::destroy( "mission_select" );
    player widgets_visibility::reset( "mission_select" );
}

// Namespace ob_nightmare_portal
// Params 3, eflags: 0x4
// Checksum 0x78095171, Offset: 0x1f98
// Size: 0x567
function private function_f57bd2985246fecf( missionid, var_64ffacba090c91be, playlistid )
{
    level endon( #"game_ended" );
    
    if ( !level.onlinegame )
    {
        /#
            var_64ffacba090c91be thread function_e548035f9b31d373( "<dev string:x11d>" );
        #/
        
        return;
    }
    
    squad = teams::function_72b89edf6b47c40a( var_64ffacba090c91be );
    
    if ( squad.s_portal_vote || squad.var_ee9234c64a2d2082 == 0 )
    {
        /#
            var_64ffacba090c91be thread function_e548035f9b31d373( "<dev string:x145>" + squad.index + "<dev string:x14c>" );
        #/
        
        nm_portal_log( squad, missionid, squad.players, "Prevent double vote start " + var_64ffacba090c91be.name );
        return;
    }
    
    if ( squad.players.size == 1 )
    {
        nm_portal_log( squad, missionid, squad.players, "Transition started. Solo player." );
        level thread nightmare_portal_transition_finish( missionid, squad, squad.players, playlistid, level.nightmareportals[ missionid ] );
        return;
    }
    
    var_3faf858e79cd17bb = spawnstruct();
    var_3faf858e79cd17bb.header = &"hash_330fc482ee5e39d5";
    var_3faf858e79cd17bb.init_message = &"hash_487c869056addd0a";
    var_3faf858e79cd17bb.description = &"hash_487c869056addd0a";
    var_3faf858e79cd17bb.header_omnvar = "ob_vote_header";
    var_3faf858e79cd17bb.init_message_omnvar = "ob_vote_description";
    var_3faf858e79cd17bb.description_omnvar = "ob_vote_description";
    var_3faf858e79cd17bb.choice_cancel = &"hash_29fde982bfbd0cd5";
    var_3faf858e79cd17bb.var_7727bbdfa397b825 = &"hash_265dd733b5b18437";
    var_3faf858e79cd17bb.var_7727b8dfa397b18c = &"hash_320f23d595acaf53";
    var_3faf858e79cd17bb.var_22d182fc8263c9f2 = "ob_vote_prompt_cancel";
    var_3faf858e79cd17bb.var_89cf47e6af2f880d = "ob_vote_prompt_accept";
    var_3faf858e79cd17bb.var_f13ea9060d6f3112 = "ob_vote_prompt_decline";
    var_3faf858e79cd17bb.player_vote_1 = &"hash_3897fa31f5f16479";
    var_3faf858e79cd17bb.player_vote_2 = &"hash_31d0a0176d258892";
    var_3faf858e79cd17bb.var_3b1d39af5974251e = "ob_vote_accepted";
    var_3faf858e79cd17bb.var_5b37d6a26edc0049 = "ob_vote_declined";
    var_3faf858e79cd17bb.player_cancel = &"sat_ob/cancelled";
    var_3faf858e79cd17bb.player_cancel_omnvar = "ob_vote_cancelled";
    var_3faf858e79cd17bb.var_5c854591406ed04 = &"hash_3897fa31f5f16479";
    var_3faf858e79cd17bb.var_5c857591406f39d = &"hash_31d0a0176d258892";
    var_3faf858e79cd17bb.var_cf443a7c10e8da3a = "ob_vote_accepted";
    var_3faf858e79cd17bb.var_8de07faa894bf315 = "ob_vote_declined";
    var_3faf858e79cd17bb.var_4185eab05d5f797e = 1;
    mission_info = level.var_bb93bd616fa0487[ missionid ];
    squad function_b26fb0454453aced( 0 );
    
    foreach ( player in squad.players )
    {
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        player notify( #"vote_started" );
    }
    
    wait 0.1;
    
    foreach ( player in squad.players )
    {
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        player setclientomnvar( "ui_nm_mission_index", mission_info.index );
        player notify( #"vote_started" );
    }
    
    wait 0.1;
    nm_portal_log( squad, missionid, squad.players, "Vote starting." );
    squad.s_portal_vote = vote_system_shared::vote_think( var_64ffacba090c91be, var_3faf858e79cd17bb, squad, level.vote_hud, undefined, undefined, 1 );
    nm_portal_log( squad, missionid, squad.players, "Vote resolved." );
    nightmare_portal_transition_start( missionid, squad, squad.s_portal_vote.a_players_accepted, playlistid, level.nightmareportals[ missionid ] );
    
    if ( squad.s_portal_vote.a_players_accepted.size > 0 )
    {
        nm_portal_log( squad, missionid, squad.s_portal_vote.a_players_accepted, "Transition started. From Vote." );
        squad waittill( #"nightmare_portal_transition_finished" );
    }
    
    if ( squad.s_portal_vote.a_players_accepted.size > 0 )
    {
        nm_portal_log( squad, missionid, squad.s_portal_vote.a_players_accepted, "Finished." );
    }
    else
    {
        nm_portal_log( squad, missionid, squad.players, "Canceled." );
    }
    
    squad.s_portal_vote = undefined;
    squad function_b26fb0454453aced( 1 );
}

// Namespace ob_nightmare_portal
// Params 1, eflags: 0x4
// Checksum 0x89dccbf2, Offset: 0x2507
// Size: 0x154
function private function_430714da57926e95( params )
{
    if ( params.s_vote.var_be908c4fc7caf076 )
    {
        foreach ( player in params.s_vote.var_be908c4fc7caf076 )
        {
            if ( !isplayer( player ) )
            {
                continue;
            }
            
            player.var_daa8e6704828e14f = 1;
        }
        
        wait params.secondsremaining + 1;
        
        foreach ( player in params.s_vote.var_be908c4fc7caf076 )
        {
            if ( !isplayer( player ) )
            {
                continue;
            }
            
            player.var_daa8e6704828e14f = undefined;
        }
    }
}

// Namespace ob_nightmare_portal
// Params 5, eflags: 0x4
// Checksum 0x1a640d44, Offset: 0x2663
// Size: 0x188
function private nightmare_portal_transition_start( missionid, squad, players, playlistid, portal )
{
    if ( isarray( players ) && players.size > 0 )
    {
        var_75ed518240f11e29 = undefined;
        squadplayers = arraycopy( squad.players );
        
        foreach ( player in squadplayers )
        {
            if ( !arraycontains( players, player ) )
            {
                player squads::leavesquad( player.team, player.sessionsquadid );
                
                if ( !isdefined( var_75ed518240f11e29 ) )
                {
                    player squads::requestnewsquad( player.team, undefined, 0 );
                    var_75ed518240f11e29 = player.sessionsquadid;
                }
                else
                {
                    player squads::joinsquad( player.team, var_75ed518240f11e29 );
                }
                
                nm_portal_log( squad, missionid, [ player ], "Forming new squad " + var_75ed518240f11e29 );
                var_724d2c981adb536 = teams::function_72b89edf6b47c40a( player );
            }
        }
        
        if ( var_724d2c981adb536 )
        {
            var_724d2c981adb536 function_29086df6db70b1df( missionid, squad, portal );
        }
        
        level thread nightmare_portal_transition_finish( missionid, squad, players, playlistid, portal );
    }
}

// Namespace ob_nightmare_portal
// Params 5, eflags: 0x4
// Checksum 0xe505e80c, Offset: 0x27f3
// Size: 0x39a
function private nightmare_portal_transition_finish( missionid, squad, players, playlistid, portal )
{
    if ( isarray( players ) && players.size > 0 )
    {
        var_6027bcabacd3a0a8 = squad coop::function_9bd80c0b7d85aef7();
        players = function_854c523b6ba57529( missionid, squad, players, var_6027bcabacd3a0a8 );
        nm_portal_log( squad, missionid, players, "Countdown started." );
        
        foreach ( player in players )
        {
            if ( !isplayer( player ) )
            {
                continue;
            }
            
            player thread countdown_timer::close( "nightmare_portal_timer" );
            player thread countdown_timer::create( "nightmare_portal_timer", "scripted_widget_countdown_banner", 5, undefined, &"sat_ob/nightmare_portal_transition" );
            player thread function_1cc56645f47b796b( portal, 11.25 );
        }
        
        wait 4;
        
        foreach ( player in players )
        {
            if ( !isplayer( player ) )
            {
                continue;
            }
            
            player thread namespace_3a2a361a08f89b78::ob_finalize_exfil( portal );
        }
        
        wait 1;
        
        foreach ( player in players )
        {
            if ( !isplayer( player ) )
            {
                continue;
            }
            
            player thread countdown_timer::close( "nightmare_portal_timer" );
        }
        
        players = function_854c523b6ba57529( missionid, squad, players, var_6027bcabacd3a0a8 );
        finished = 0;
        
        while ( finished < players.size )
        {
            finished = 0;
            
            foreach ( player in players )
            {
                if ( !isplayer( player ) )
                {
                    finished++;
                    continue;
                }
                
                if ( player utility::ent_flag( "ob_exfil_finalized" ) )
                {
                    finished++;
                }
            }
            
            players = function_854c523b6ba57529( missionid, squad, players, var_6027bcabacd3a0a8 );
            waitframe();
        }
        
        players = function_854c523b6ba57529( missionid, squad, players, var_6027bcabacd3a0a8 );
        nm_portal_log( squad, missionid, players, "Exfil finalized." );
        
        if ( !squad utility::ent_flag( "mission_failed" ) )
        {
            nm_portal_log( squad, missionid, players, "nightmare_wormhole" );
            level thread nightmare_wormhole( players, "nightmare_wormhole" );
            level utility::flag_wait( "nightmare_wormhole" );
        }
        
        if ( !squad utility::ent_flag( "mission_failed" ) )
        {
            players = function_854c523b6ba57529( missionid, squad, players, var_6027bcabacd3a0a8 );
            nm_portal_log( squad, missionid, players, "map_to_map_start()." );
            level thread namespace_3a2a361a08f89b78::map_to_map_start( players, playlistid );
        }
    }
    
    if ( squad.s_portal_vote )
    {
        squad.s_portal_vote.a_players_accepted = players;
    }
    
    squad notify( #"nightmare_portal_transition_finished" );
}

// Namespace ob_nightmare_portal
// Params 4, eflags: 0x4
// Checksum 0x27ec5c74, Offset: 0x2b95
// Size: 0xfb
function private function_854c523b6ba57529( missionid, squad, players, var_f24bbed7a381981d )
{
    var_10e0fe31199494d6 = [];
    
    foreach ( player in players )
    {
        if ( arraycontains( squad.players, player ) )
        {
            if ( player.sessionsquadid != var_f24bbed7a381981d )
            {
                nm_portal_log( squad, missionid, [ player ], "SQUAD_PARTY_ID_MISMATCH. Dropped." );
                continue;
            }
            
            var_10e0fe31199494d6[ var_10e0fe31199494d6.size ] = player;
            continue;
        }
        
        nm_portal_log( squad, missionid, [ player ], "Left squad." );
    }
    
    return var_10e0fe31199494d6;
}

// Namespace ob_nightmare_portal
// Params 1, eflags: 0x4
// Checksum 0x86f17606, Offset: 0x2c99
// Size: 0x1bb
function private function_b26fb0454453aced( isvisible )
{
    squad = self;
    
    if ( !isarray( squad.players ) )
    {
        return;
    }
    
    squad.var_ec3e8b015e4ce3df = isvisible;
    
    foreach ( portal in level.nightmareportals )
    {
        if ( !portal.scriptableprompt )
        {
            return;
        }
        
        foreach ( player in squad.players )
        {
            if ( !isplayer( player ) )
            {
                continue;
            }
            
            if ( !arraycontains( portal.activeplayers, player ) )
            {
                continue;
            }
            
            if ( player.sessionstate != "playing" && player.sessionstate != "playing_but_spectating" )
            {
                continue;
            }
            
            if ( isvisible )
            {
                portal.scriptableprompt function_6113853a877d5460( player );
                continue;
            }
            
            if ( !portal.scriptableprompt function_50b79f4d4032e234( player ) )
            {
                portal.scriptableprompt function_d6a7b7ef13a57f38( player );
            }
        }
    }
}

// Namespace ob_nightmare_portal
// Params 1, eflags: 0x4
// Checksum 0xb79072a7, Offset: 0x2e5c
// Size: 0x50
function private function_fd4d3ad9cba79915( params )
{
    if ( isarray( params.a_squad_players ) )
    {
        squad = teams::function_72b89edf6b47c40a( params.a_squad_players[ 0 ] );
        
        if ( squad )
        {
            squad utility::ent_flag_set( "mission_failed" );
        }
    }
}

// Namespace ob_nightmare_portal
// Params 3, eflags: 0x4
// Checksum 0xc3784dcb, Offset: 0x2eb4
// Size: 0x2bb
function private function_29086df6db70b1df( missionid, originalsquad, portal )
{
    assert( isarray( self.players ) );
    assert( level != self );
    assert( isdefined( portal.origin ) );
    assert( isdefined( level.var_2a486bda36a2b6e1 ) );
    squad = self;
    beingrevived = [];
    
    foreach ( player in squad.players )
    {
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        if ( !isalive( player ) || player::isinlaststand( player ) )
        {
            nm_portal_log( originalsquad, missionid, [ player ], "Reviving down/dead player." );
            beingrevived[ beingrevived.size ] = player;
        }
    }
    
    if ( beingrevived.size > 0 )
    {
        spawnpoints = [];
        
        if ( !isdefined( portal.var_73a61dae0461d7c7 ) )
        {
            portal.var_73a61dae0461d7c7 = 0;
        }
        
        portal.var_73a61dae0461d7c7 += 25;
        
        for ( ipoint = 0; ipoint < 4 ; ipoint++ )
        {
            spawnpoints[ ipoint ] = portal.origin + rotatevector( ( 50, 0, 20 ), ( 0, ipoint * 90 + portal.var_73a61dae0461d7c7, 0 ) );
        }
        
        foreach ( revivedplayer in beingrevived )
        {
            revivedplayer ob::function_2b9dde49097a039e();
        }
        
        squad [[ level.var_2a486bda36a2b6e1 ]]( { #spawnpoints:spawnpoints } );
        
        foreach ( revivedplayer in beingrevived )
        {
            revivedplayer utility::delaycall( 1, &freezecontrols, 0 );
        }
    }
}

// Namespace ob_nightmare_portal
// Params 2, eflags: 0xc
// Checksum 0xb0413615, Offset: 0x3177
// Size: 0xe0
function private function_1cc56645f47b796b( portal, timeseconds )
{
    self notify( #"hash_5cb89f06c8ad23e2" );
    self endon( #"hash_5cb89f06c8ad23e2" );
    assert( isplayer( self ) );
    self endon( #"disconnect" );
    valgroup = "nm_portal_regroup";
    val::set( valgroup, "damage", 0 );
    val::set( valgroup, "death", 0 );
    val::set( valgroup, "killstreaks", 0 );
    val::set( valgroup, "remote_killstreaks", 0 );
    coop::function_eb6e09941acb48e9();
    
    if ( self.isjuggernaut )
    {
        self notify( #"remote_robot_manual_exit" );
    }
    
    result = utility::waittill_any_timeout( timeseconds, "nm_portal_leave_squad" );
    
    if ( result == "nm_portal_leave_squad" )
    {
        wait 1;
    }
    
    val::reset_all( valgroup );
}

// Namespace ob_nightmare_portal
// Params 2
// Checksum 0xbf006744, Offset: 0x325f
// Size: 0xa9
function nightmare_wormhole( players, flag )
{
    level endon( #"game_ended" );
    options = spawnstruct();
    options.players = players;
    options.skip = 0;
    options.flag = flag;
    options.fadestartshader = "white";
    options.fadeendshader = "black";
    options.timeout = 5.25;
    options.var_1fea8eb2ea91b7ac = 1;
    coop::play_cinematic( "sat_nm_wormhole", options );
}

// Namespace ob_nightmare_portal
// Params 0, eflags: 0x4
// Checksum 0x43d24c35, Offset: 0x3310
// Size: 0x1dd
function private function_abed7e5375d5f8ff()
{
    level endon( #"game_ended" );
    var_c0299a00f4d67db0 = [];
    far_distance_vo_played = [];
    var_ba664eb14d14a542 = level.var_bb93bd616fa0487[ self.portalid ];
    
    while ( true )
    {
        wait 0.2;
        
        if ( getplayerinfluenceatposition( self.origin ) <= 0 )
        {
            assert( getdvarfloat( @"hash_7cea12faaeb9d47", 0 ) >= 1500 );
            continue;
        }
        
        nearplayers = getplayersinradius( self.origin, 1500, undefined, undefined, var_c0299a00f4d67db0 );
        
        foreach ( player in nearplayers )
        {
            if ( !arraycontains( self.activeplayers, player ) )
            {
                continue;
            }
            
            if ( player function_7bab68e56a20a95f( self.portalid ) )
            {
                var_c0299a00f4d67db0[ var_c0299a00f4d67db0.size ] = player;
                continue;
            }
            
            if ( !arraycontains( far_distance_vo_played, player ) )
            {
                far_distance_vo_played[ far_distance_vo_played.size ] = player;
                
                if ( var_ba664eb14d14a542.var_4b3aa7cc6a25d636 )
                {
                    i = randomintrange( var_ba664eb14d14a542.var_4b3aa7cc6a25d636, var_ba664eb14d14a542.var_4aa6738b2d38de08 + 1 );
                    level thread overlord::playevent( "vo_glitch_approach_" + i, [ player ] );
                }
            }
            
            if ( distancesquared( player.origin, self.origin ) <= 262144 )
            {
                var_c0299a00f4d67db0[ var_c0299a00f4d67db0.size ] = player;
                level thread overlord::playevent( "vo_glitch_approach_end_" + self.portalid, [ player ] );
            }
        }
    }
}

// Namespace ob_nightmare_portal
// Params 0, eflags: 0x4
// Checksum 0x3acf1fb8, Offset: 0x34f5
// Size: 0xfe
function private function_98ae70f18196cd1()
{
    level endon( #"game_ended" );
    blockers_mask = createentitytypemask( [ "etype_turret", "etype_vehicle" ] );
    var_d226408b94784d5d = self.origin + ( 0, 0, -50 );
    
    while ( true )
    {
        blockers = getentitiesinradiusfrompartitiongrid( var_d226408b94784d5d, 200, blockers_mask );
        
        foreach ( blocker in blockers )
        {
            blocker dodamage( blocker.maxhealth * 0.1, blocker.origin );
        }
        
        wait 0.5;
    }
}

// Namespace ob_nightmare_portal
// Params 1, eflags: 0x4
// Checksum 0xf742c90, Offset: 0x35fb
// Size: 0x5b
function private dev_enable_portal( params )
{
    players = [];
    
    if ( isplayer( self ) )
    {
        players = [ self ];
    }
    else
    {
        iprintlnbold( "dev_enable_portal must be called on a player." );
        return;
    }
    
    var_352294209b15174a = params[ 0 ];
    
    if ( !isdefined( var_352294209b15174a ) )
    {
        var_352294209b15174a = "leo";
    }
    
    level thread enable_nightmare_portal( players, var_352294209b15174a );
}

// Namespace ob_nightmare_portal
// Params 1, eflags: 0x4
// Checksum 0xf2ae81f0, Offset: 0x365e
// Size: 0xcb
function private dev_complete_mission( params )
{
    var_352294209b15174a = params[ 0 ];
    players = level.players;
    
    if ( isplayer( self ) )
    {
        players = [ self ];
    }
    
    foreach ( player in players )
    {
        player utility::callsharedfunc( #"hash_561b73e89e879cb7", #"hash_3fa3c8cca94e4308", var_352294209b15174a );
        player function_3fe18929a5be62f3();
    }
}

// Namespace ob_nightmare_portal
// Params 1, eflags: 0x4
// Checksum 0xb351bd21, Offset: 0x3731
// Size: 0xd9
function private function_bec51d5bcc71b26( params )
{
    players = level.players;
    
    if ( isplayer( self ) )
    {
        players = [ self ];
    }
    
    portal_tag = params[ 0 ];
    
    if ( !isdefined( portal_tag ) )
    {
        portal_tag = "leo";
    }
    
    portal = level.nightmareportals[ portal_tag ];
    
    foreach ( player in players )
    {
        player setorigin( portal.origin );
    }
}

// Namespace ob_nightmare_portal
// Params 1, eflags: 0x4
// Checksum 0x54862c6, Offset: 0x3812
// Size: 0x3b
function private function_4ccf8d59a5d897ee( params )
{
    /#
        player = isplayer( self ) ? self : level.players[ 0 ];
        player thread function_f63e766c70463b96();
    #/
}

// Namespace ob_nightmare_portal
// Params 1, eflags: 0x4
// Checksum 0xbd90389a, Offset: 0x3855
// Size: 0x19a
function private function_cd7c73c5a4a61ea( params )
{
    player = isplayer( self ) ? self : level.players[ 0 ];
    debugtext = "";
    
    if ( function_7c401a266a4ee0ca() )
    {
        var_6377b42ea00cba29 = player function_59963ac3879d7121();
        debugtext += "Shard Count: " + var_6377b42ea00cba29 + "\n";
    }
    else
    {
        debugtext += "Shard disabled\n";
    }
    
    foreach ( missionname, missioninfo in level.var_bb93bd616fa0487 )
    {
        portalenabled = player function_5d0d7d2b56f5a95( missionname );
        var_d5bbdd4e970fb0ed = player function_7bab68e56a20a95f( missionname );
        debugtext += missionname + "  ";
        debugtext += portalenabled ? "ENABLED " : "DISABLED ";
        debugtext += var_d5bbdd4e970fb0ed ? "COMPLETED" : "UNCOMPLETED";
        
        if ( function_7c401a266a4ee0ca() )
        {
            debugtext += "  require Shards: " + missioninfo.shardnum;
        }
        
        debugtext += "\n";
    }
    
    /#
        player thread function_e548035f9b31d373( debugtext );
    #/
    
    logstring( "[OB_NIGHTMARE_PORTAL] " + player.name + "\n" + debugtext );
}

// Namespace ob_nightmare_portal
// Params 1, eflags: 0x4
// Checksum 0xbf6d6d61, Offset: 0x39f7
// Size: 0xf1
function private function_d0de09c74ea8bbc4( params )
{
    player = isplayer( self ) ? self : level.players[ 0 ];
    
    foreach ( missioninfo in level.var_bb93bd616fa0487 )
    {
        player setplayerdata( level.var_6f9b00680ed002d8, "nmMissionCompleted", missioninfo.index, 0 );
        player setplayerdata( level.var_6f9b00680ed002d8, "nmMissionUnlocked", missioninfo.index, 0 );
    }
    
    player thread function_3bc476da64183020();
    player function_3fe18929a5be62f3();
}

/#

    // Namespace ob_nightmare_portal
    // Params 1
    // Checksum 0xd8a77eb8, Offset: 0x3af0
    // Size: 0xe3, Type: dev
    function function_e548035f9b31d373( text )
    {
        self notify( #"hash_1799c3d317bd499a" );
        self endon( #"hash_1799c3d317bd499a" );
        level endon( #"game_ended" );
        self endon( #"disconnect" );
        
        if ( !self.var_240eaa56102c75d7 )
        {
            hud = newclienthudelem( self );
            hud.x = 400;
            hud.y = 100;
            hud.foreground = 1;
            hud.color = ( 0, 0, 1 );
            hud.fontscale = 1.5;
            self.var_240eaa56102c75d7 = hud;
        }
        
        self.var_240eaa56102c75d7 setdevtext( text );
        wait 5;
        self.var_240eaa56102c75d7 setdevtext( "<dev string:x178>" );
    }

    // Namespace ob_nightmare_portal
    // Params 1, eflags: 0xc
    // Checksum 0xddad06bb, Offset: 0x3bdb
    // Size: 0x1cd, Type: dev
    function private function_f63e766c70463b96( params )
    {
        self notify( #"hash_ee0f3e9fb7bf8c73" );
        self endon( #"hash_ee0f3e9fb7bf8c73" );
        me = self;
        
        if ( !me )
        {
            return;
        }
        
        if ( level.var_17a1cdc88bfcccdf )
        {
            level.var_17a1cdc88bfcccdf = 0;
            return;
        }
        
        level.var_17a1cdc88bfcccdf = 1;
        
        while ( true )
        {
            if ( !me )
            {
                break;
            }
            
            foreach ( portal in level.nightmareportals )
            {
                missionname = portal.portalid;
                missioninfo = level.var_bb93bd616fa0487[ missionname ];
                portalenabled = me function_5d0d7d2b56f5a95( missionname );
                var_d5bbdd4e970fb0ed = me function_7bab68e56a20a95f( missionname );
                var_978832f3a778350b = me function_abe971f792641911( missionname );
                str = "<dev string:x179>";
                str += portalenabled;
                str += "<dev string:x17e>";
                str += missioninfo.index;
                str += "<dev string:x182>";
                str += var_d5bbdd4e970fb0ed ? "<dev string:x186>" : "<dev string:x188>";
                me function_bcbe45b27ab30c35( portal, missionname + "<dev string:x18a>" + str + "<dev string:x18c>", var_978832f3a778350b ? ( 0, 1, 0 ) : ( 1, 0, 0 ) );
            }
            
            waitframe();
        }
    }

    // Namespace ob_nightmare_portal
    // Params 4, eflags: 0x4
    // Checksum 0x67cedae2, Offset: 0x3db0
    // Size: 0xe6, Type: dev
    function private function_bcbe45b27ab30c35( target, print_text, color, sphere_radius )
    {
        if ( !isdefined( print_text ) )
        {
            print_text = "<dev string:x178>";
        }
        
        if ( !isdefined( color ) )
        {
            color = ( 1, 0, 0 );
        }
        
        if ( !isdefined( sphere_radius ) )
        {
            sphere_radius = 4;
        }
        
        if ( !target || !target.origin || !self )
        {
            return 0;
        }
        
        line( self.origin, target.origin, color );
        sphere( target.origin, sphere_radius, color );
        print3d( target.origin, print_text + "<dev string:x18e>" + length( target.origin - self.origin ) + "<dev string:x18c>", color, 1, 0.5, 1, 1 );
        return 1;
    }

#/
