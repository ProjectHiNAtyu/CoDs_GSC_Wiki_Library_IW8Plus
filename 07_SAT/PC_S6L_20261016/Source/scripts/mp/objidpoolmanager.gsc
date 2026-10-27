// scripts\mp\objidpoolmanager.gsc  (hash_5c0063ab6b81303f.gscc) (size: 18578 Bytes / 0x4892 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x66b5fda6 (1723202982)
// size ...... 18578 (0x4892)
// includes .. 4   (offset: 0x4766)
// strings ... 17  (offset: 0x4786)
// dev strs .. 3   (offset: 0x486e)
// exports ... 111 (offset: 0x25fa)
// cseg ...... 0x298 + 0x2362 (0x25fa)
// imports ... 135 (offset: 0x3752)
// animtree1 . 0   (offset: 0x4892)
// animtree2 . 0   (offset: 0x4892)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\utility\join_team_aggregator;
#using scripts\mp\common\utility\teams;

#namespace objidpoolmanager;

// Namespace objidpoolmanager
// Params 0, eflags: 0x1
// Checksum 0xe2d7bbdf, Offset: 0x2b6
// Size: 0xd5
function autoexec init()
{
    objectiveidpool = spawnstruct();
    objectiveidpool.active = [];
    objectiveidpool.reclaimed = [];
    objectiveidpool.reserved = [];
    objectiveidpool.index = 0;
    objectiveidpool.limit = getmaxobjectivecount();
    level.objectiveidpool = objectiveidpool;
    level.var_a66c07eb5b43687 = [];
    
    if ( !isdefined( level.var_4dd34998867ddde2 ) )
    {
        level.var_4dd34998867ddde2 = [];
    }
    
    level.var_4dd34998867ddde2[ 0 ] = [];
    level.var_4dd34998867ddde2[ 1 ] = [];
    
    if ( !callback::exists( #"Objective_Delete", &function_59fbd6a6bb5b8e99 ) )
    {
        callback::add( #"Objective_Delete", &function_59fbd6a6bb5b8e99 );
        join_team_aggregator::registeronplayerjointeamnospectatorcallback( &function_9b2b9110896c173e );
    }
}

// Namespace objidpoolmanager
// Params 1
// Checksum 0x82cfe1a, Offset: 0x393
// Size: 0xf8
function requestreservedid( objid )
{
    if ( !isdefined( objid ) || objid == -1 )
    {
        objid = getnextobjectiveid( 100 );
        
        if ( objid == -1 )
        {
            return -1;
        }
    }
    else if ( !isdefined( level.objectiveidpool.active[ objid ] ) )
    {
        level.objectiveidpool.index++;
    }
    else if ( isbrgamemode() )
    {
        throw( "Reserved ID already in use, overwriting it." );
    }
    
    entry = spawnstruct();
    entry.priority = 100;
    entry.requesttime = gettime();
    entry.objid = objid;
    level.objectiveidpool.active[ objid ] = entry;
    level.objectiveidpool.reserved[ level.objectiveidpool.reserved.size ] = objid;
    return objid;
}

// Namespace objidpoolmanager
// Params 1
// Checksum 0xec6b73a6, Offset: 0x494
// Size: 0xc6
function requestobjectiveid( priority )
{
    objid = getnextobjectiveid( priority );
    
    if ( !isdefined( objid ) || objid == -1 )
    {
        if ( getdvarint( @"hash_4b48454d225475a", 0 ) == 1 )
        {
            logstring( "[GSC_OBJECTIVE] Unable to request new objective ID" );
        }
        
        return -1;
    }
    
    entry = spawnstruct();
    entry.priority = priority;
    entry.requesttime = gettime();
    entry.objid = objid;
    level.objectiveidpool.active[ objid ] = entry;
    
    if ( getdvarint( @"hash_4b48454d225475a", 0 ) == 1 )
    {
        logstring( "[GSC_OBJECTIVE] New objective ID allocated: " + objid );
    }
    
    return objid;
}

// Namespace objidpoolmanager
// Params 1
// Checksum 0x2eca4560, Offset: 0x563
// Size: 0x266
function getnextobjectiveid( priority )
{
    /#
        var_dd2de0621c971c22 = getscriptcallstack();
        dlog_recordevent( "<dev string:x24>", [ "<dev string:x4d>", var_dd2de0621c971c22 ] );
    #/
    
    if ( getdvarint( @"hash_b7c28d3b4e160d39", 0 ) > 0 )
    {
        if ( level.objectiveidpool.index < level.objectiveidpool.limit )
        {
            nextid = level.objectiveidpool.limit - 1 - level.objectiveidpool.index;
            level.objectiveidpool.index++;
        }
        else
        {
            println( "<dev string:x57>" );
            
            if ( level.objectiveidpool.reclaimed.size == 0 )
            {
                dlog_recordevent( "dlog_event_server_gsc_objective_limit_reached", [] );
                throw( "No objective IDs available!" );
                return -1;
            }
            else
            {
                nextentry = level.objectiveidpool.reclaimed[ 0 ];
                nextid = nextentry.objid;
                level.objectiveidpool.reclaimed[ 0 ] = undefined;
                function_cdc669dbc8ea2101( level.objectiveidpool.reclaimed );
            }
        }
        
        return nextid;
    }
    
    if ( level.objectiveidpool.reclaimed.size == 0 )
    {
        if ( level.objectiveidpool.index >= level.objectiveidpool.limit )
        {
            dlog_recordevent( "dlog_event_server_gsc_objective_limit_reached", [] );
            throw( "No objective IDs available!" );
            return -1;
        }
        else
        {
            nextid = level.objectiveidpool.limit - 1 - level.objectiveidpool.index;
            level.objectiveidpool.index++;
        }
    }
    else
    {
        nextentry = level.objectiveidpool.reclaimed[ level.objectiveidpool.reclaimed.size - 1 ];
        nextid = nextentry.objid;
        level.objectiveidpool.reclaimed[ level.objectiveidpool.reclaimed.size - 1 ] = undefined;
    }
    
    return nextid;
}

// Namespace objidpoolmanager
// Params 1
// Checksum 0xd9fce047, Offset: 0x7d2
// Size: 0x9a
function function_1eca7bd1a3a49a4d( objid )
{
    foreach ( entry in level.objectiveidpool.reclaimed )
    {
        if ( entry.objid == objid )
        {
            return entry;
        }
    }
}

// Namespace objidpoolmanager
// Params 1
// Checksum 0x6fd74ec1, Offset: 0x875
// Size: 0x15, Type: bool
function function_fb05d646a96ed99e( objid )
{
    return isdefined( function_1eca7bd1a3a49a4d( objid ) );
}

// Namespace objidpoolmanager
// Params 1
// Checksum 0x7d05aeb, Offset: 0x893
// Size: 0x19d, Type: bool
function returnobjectiveid( objid )
{
    if ( !isdefined( objid ) || objid == -1 )
    {
        return false;
    }
    
    entry = function_1eca7bd1a3a49a4d( objid );
    
    if ( isdefined( entry ) )
    {
        additionalmsg = "";
        
        if ( entry.stack )
        {
            logstring( "[returnObjectiveID] Previous callstack of returned objective: \n" + entry.stack );
            var_d31cd1abd074e1c4 = strtok( entry.stack, "|" );
            
            if ( var_d31cd1abd074e1c4.size > 1 )
            {
                additionalmsg += var_d31cd1abd074e1c4[ 1 ];
            }
        }
        
        throw( "returnObjectiveID has already been returned! - " + objid + ". " + additionalmsg );
        return false;
    }
    
    level.objectiveidpool.active[ objid ] = undefined;
    
    if ( getdvarint( @"hash_4b48454d225475a", 0 ) == 1 )
    {
        logstring( "[GSC_OBJECTIVE] Returning objective ID " + objid );
    }
    
    level notify( #"Objective_Delete", objid );
    params = spawnstruct();
    params.objid = objid;
    callback::callback( #"Objective_Delete", params );
    objective_delete( objid );
    
    if ( getdvarint( @"hash_986a84ab3ac5b0c1", 1 ) )
    {
        var_dd2de0621c971c22 = getscriptcallstack();
    }
    else
    {
        var_dd2de0621c971c22 = "";
    }
    
    entry = { #objid:objid, #stack:var_dd2de0621c971c22 };
    level.objectiveidpool.reclaimed[ level.objectiveidpool.reclaimed.size ] = entry;
    return true;
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0x2bd4c6ff, Offset: 0xa39
// Size: 0x59, Type: bool
function returnreservedobjectiveid( objid, var_7d55edc3b6bec7ff )
{
    if ( !isdefined( objid ) || objid == -1 )
    {
        return false;
    }
    
    if ( var_7d55edc3b6bec7ff )
    {
        level.objectiveidpool.active[ objid ] = undefined;
    }
    
    level notify( #"Objective_Delete", objid );
    objective_delete( objid );
    return true;
}

// Namespace objidpoolmanager
// Params 3
// Checksum 0x1c67a058, Offset: 0xa9b
// Size: 0x38
function function_d15ca529817626c( presetref, var_8cb71fd19ae4e965, var_52233f155fb26d7c )
{
    level.var_a66c07eb5b43687[ presetref ] = [ var_8cb71fd19ae4e965, var_52233f155fb26d7c ];
}

// Namespace objidpoolmanager
// Params 5, eflags: 0x4
// Checksum 0xb976bade, Offset: 0xadb
// Size: 0x7d
function private objective_add_internal( objectivenumber, state, position, iconname, iconsize )
{
    level notify( #"Objective_Delete", objectivenumber );
    objective_delete( objectivenumber );
    
    if ( isdefined( state ) )
    {
        objective_state( objectivenumber, state );
    }
    
    if ( isdefined( position ) )
    {
        objective_position( objectivenumber, position );
    }
    
    if ( isdefined( iconname ) )
    {
        objective_icon( objectivenumber, iconname );
    }
    
    if ( isdefined( iconsize ) )
    {
        objective_setminimapiconsize( objectivenumber, iconsize );
    }
}

// Namespace objidpoolmanager
// Params 5
// Checksum 0xe4ef33c8, Offset: 0xb60
// Size: 0x86
function objective_add_objective( objid, state, position, iconshader, iconsize )
{
    if ( objid == -1 )
    {
        if ( getdvarint( @"hash_4b48454d225475a", 0 ) == 1 )
        {
            logstring( "[GSC_OBJECTIVE] Unable to add objective with ID of -1" );
        }
        
        return;
    }
    
    if ( getdvarint( @"hash_4b48454d225475a", 0 ) == 1 )
    {
        logstring( "[GSC_OBJECTIVE] Adding new objective with ID " + objid );
    }
    
    objective_add_internal( objid, state, position, iconshader, iconsize );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0x9f51f66b, Offset: 0xbee
// Size: 0x26
function update_objective_ownerteam( objid, ownerteam )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_setownerteam( objid, ownerteam );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0x2bb501e, Offset: 0xc1c
// Size: 0x26
function update_objective_ownerclient( objid, owner )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_setownerclient( objid, owner );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0xc6fedb33, Offset: 0xc4a
// Size: 0x26
function update_objective_setclientforsquadcustomcolor( objid, player )
{
    if ( objid == -1 )
    {
        return;
    }
    
    function_fa5c3fbfb8b4b8c0( objid, player );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0x50021e72, Offset: 0xc78
// Size: 0x26
function update_objective_sethot( objid, bool )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_sethot( objid, bool );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0x816a0b5, Offset: 0xca6
// Size: 0x26
function update_objective_setfriendlylabel( objid, stringref )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_setfriendlylabel( objid, stringref );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0x70bc1d3d, Offset: 0xcd4
// Size: 0x26
function update_objective_setenemylabel( objid, stringref )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_setenemylabel( objid, stringref );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0xd7fe6849, Offset: 0xd02
// Size: 0x26
function update_objective_setneutrallabel( objid, stringref )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_setneutrallabel( objid, stringref );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0x5f7b1aec, Offset: 0xd30
// Size: 0x26
function update_objective_state( objid, state )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_state( objid, state );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0xf6ab731b, Offset: 0xd5e
// Size: 0x26
function update_objective_position( objid, position )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_position( objid, position );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0xb3029407, Offset: 0xd8c
// Size: 0x26
function update_objective_icon( objid, iconshader )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_icon( objid, iconshader );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0xb8b65864, Offset: 0xdba
// Size: 0x26
function function_bfc5cc4dccf0cb5e( objid, icon )
{
    if ( objid == -1 )
    {
        return;
    }
    
    function_c0093af7054ddb28( objid, icon );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0xb05f7234, Offset: 0xde8
// Size: 0x26
function function_80210e6c15f41880( objid, force )
{
    if ( objid == -1 )
    {
        return;
    }
    
    function_2a2921af31b855a( objid, force );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0xcea93937, Offset: 0xe16
// Size: 0x26
function function_3fe36cbe084664b7( objid, show )
{
    if ( objid == -1 )
    {
        return;
    }
    
    function_30759e67b9067161( objid, show );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0x5175528, Offset: 0xe44
// Size: 0x26
function update_objective_description( objid, description )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_setdescription( objid, description );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0xd6ac0b12, Offset: 0xe72
// Size: 0x2c
function update_objective_size( objid, iconsize )
{
    if ( objid == -1 )
    {
        return;
    }
    
    if ( isdefined( iconsize ) )
    {
        objective_setminimapiconsize( objid, iconsize );
    }
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0xe148307f, Offset: 0xea6
// Size: 0x26
function update_objective_objectiveid( objid, iconshader )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_objectiveid( objid, iconshader );
}

// Namespace objidpoolmanager
// Params 1
// Checksum 0xc3707d63, Offset: 0xed4
// Size: 0x1c
function function_67fcfff73d6fb3c2( objid )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_reset_objectiveid( objid );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0xb17d3239, Offset: 0xef8
// Size: 0x26
function update_objective_setbackground( objid, type )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_setbackground( objid, type );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0xf107762d, Offset: 0xf26
// Size: 0x26
function update_objective_onentity( objid, ent )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_onentity( objid, ent );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0x823d7cb1, Offset: 0xf54
// Size: 0x2f
function update_objective_onentitywithrotation( objid, ent )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_onentity( objid, ent );
    objective_setrotateonminimap( objid, 1 );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0xb1bc5470, Offset: 0xf8b
// Size: 0x26
function function_fdc7130613f3a8ea( objid, var_a98790dd53d159c2 )
{
    if ( objid == -1 )
    {
        return;
    }
    
    function_beb96b20f4f9ff64( objid, var_a98790dd53d159c2 );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0x78470b17, Offset: 0xfb9
// Size: 0x26
function update_objective_setzoffset( objid, offset )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_setzoffset( objid, offset );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0xf0237144, Offset: 0xfe7
// Size: 0x26
function function_91f2afa01b0c400d( objid, disable )
{
    if ( objid == -1 )
    {
        return;
    }
    
    function_9cee41015b147e23( objid, disable );
}

// Namespace objidpoolmanager
// Params 1
// Checksum 0xcad9f527, Offset: 0x1015
// Size: 0x1c
function function_eb808b97701a4793( objid )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_removeallfrommask( objid );
}

// Namespace objidpoolmanager
// Params 1
// Checksum 0xc2e04faa, Offset: 0x1039
// Size: 0x1c
function function_6dfdf7da8037a1ee( objid )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_addalltomask( objid );
}

// Namespace objidpoolmanager
// Params 1
// Checksum 0xeee69518, Offset: 0x105d
// Size: 0x1c
function function_daf59ee8ea2cb071( objid )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_showtoplayersinmask( objid );
}

// Namespace objidpoolmanager
// Params 1
// Checksum 0x42865ee1, Offset: 0x1081
// Size: 0x1c
function function_a55b645deb36be18( objid )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_hidefromplayersinmask( objid );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0x68dbd192, Offset: 0x10a5
// Size: 0x34
function objective_playermask_single( objid, ent )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_removeallfrommask( objid );
    objective_addclienttomask( objid, ent );
    objective_showtoplayersinmask( objid );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0x313ac63a, Offset: 0x10e1
// Size: 0x34
function objective_teammask_single( objid, team )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_removeallfrommask( objid );
    objective_addteamtomask( objid, team );
    objective_showtoplayersinmask( objid );
}

// Namespace objidpoolmanager
// Params 1
// Checksum 0xda384c39, Offset: 0x111d
// Size: 0x23
function objective_playermask_hidefromallplayers( objid )
{
    if ( objid == -1 )
    {
        return;
    }
    
    function_38b84cb3d4357dd7( objid );
    objective_showtoplayersinmask( objid );
}

// Namespace objidpoolmanager
// Params 1
// Checksum 0x72c57c38, Offset: 0x1148
// Size: 0x23
function objective_playermask_hidefromall( objid )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_addalltomask( objid );
    objective_hidefromplayersinmask( objid );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0x29866613, Offset: 0x1173
// Size: 0x2d
function objective_playermask_hidefrom( objid, ent )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_removeclientfrommask( objid, ent );
    objective_showtoplayersinmask( objid );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0x2365c65c, Offset: 0x11a8
// Size: 0x2d
function objective_playermask_addshowplayer( objid, ent )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_addclienttomask( objid, ent );
    objective_showtoplayersinmask( objid );
}

// Namespace objidpoolmanager
// Params 1
// Checksum 0x7e0530ff, Offset: 0x11dd
// Size: 0x23
function objective_playermask_showtoallplayers( objid )
{
    if ( objid == -1 )
    {
        return;
    }
    
    function_fd9ed552c76d6299( objid );
    objective_showtoplayersinmask( objid );
}

// Namespace objidpoolmanager
// Params 1
// Checksum 0x10b58a5f, Offset: 0x1208
// Size: 0x23
function objective_playermask_showtoall( objid )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_addalltomask( objid );
    objective_showtoplayersinmask( objid );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0x4c40c579, Offset: 0x1233
// Size: 0x12b
function function_19410dd520bff519( objid, team )
{
    if ( objid == -1 )
    {
        return;
    }
    
    enemyplayers = teams::getenemyplayers( team );
    
    foreach ( player in enemyplayers )
    {
        objective_removeclientfrommask( objid, player );
    }
    
    players = teams::getfriendlyplayers( team );
    
    foreach ( player in players )
    {
        objective_addclienttomask( objid, player );
    }
    
    function_193ad161d179c680( objid, team );
    objective_showtoplayersinmask( objid );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0xbbcc2bb5, Offset: 0x1366
// Size: 0xb2
function function_5a1e9f21605aa4c1( objid, team )
{
    if ( objid == -1 )
    {
        return;
    }
    
    players = teams::getfriendlyplayers( team );
    
    foreach ( player in players )
    {
        objective_removeclientfrommask( objid, player );
    }
    
    function_e7c90129e84fc698( objid, team );
    objective_showtoplayersinmask( objid );
}

// Namespace objidpoolmanager
// Params 1, eflags: 0x4
// Checksum 0xf034f62a, Offset: 0x1420
// Size: 0x14e
function private function_9b2b9110896c173e( ent )
{
    key = ent.team == "axis" ? 0 : 1;
    
    foreach ( objective_id in level.var_4dd34998867ddde2[ key ] )
    {
        objective_addclienttomask( objective_id, ent );
        objective_showtoplayersinmask( objective_id );
    }
    
    oldkey = ent.team == "axis" ? 1 : 0;
    
    foreach ( objective_id in level.var_4dd34998867ddde2[ oldkey ] )
    {
        objective_removeclientfrommask( objective_id, ent );
        objective_showtoplayersinmask( objective_id );
    }
}

// Namespace objidpoolmanager
// Params 2, eflags: 0x4
// Checksum 0xb22817b7, Offset: 0x1576
// Size: 0x4c
function private function_193ad161d179c680( objid, team )
{
    key = team == "axis" ? 0 : 1;
    level.var_4dd34998867ddde2[ key ][ level.var_4dd34998867ddde2.size ] = objid;
}

// Namespace objidpoolmanager
// Params 1, eflags: 0x4
// Checksum 0xc69e68a6, Offset: 0x15ca
// Size: 0x8e
function private function_59fbd6a6bb5b8e99( params )
{
    foreach ( array in level.var_4dd34998867ddde2 )
    {
        arrayremove( array, params.objid );
    }
}

// Namespace objidpoolmanager
// Params 2, eflags: 0x4
// Checksum 0xbc295f7d, Offset: 0x1660
// Size: 0x44
function private function_e7c90129e84fc698( objid, team )
{
    key = team == "axis" ? 0 : 1;
    arrayremove( level.var_4dd34998867ddde2[ key ], objid );
}

// Namespace objidpoolmanager
// Params 3
// Checksum 0xf80ee890, Offset: 0x16ac
// Size: 0x4c
function objective_mask_showtoplayerteam( objid, ent, fallbackteam )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_removeallfrommask( objid );
    objective_addteamtomask( objid, ent.team ?? fallbackteam );
    objective_showtoplayersinmask( objid );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0xe10b3d19, Offset: 0x1700
// Size: 0x4f
function function_209503f30f7b215a( objid, ent )
{
    if ( objid == -1 )
    {
        return;
    }
    
    if ( !isdefined( ent.owner ) )
    {
        return;
    }
    
    objective_removeallfrommask( objid );
    objective_addclienttomask( objid, ent.owner );
    objective_showtoplayersinmask( objid );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0x48f5f65e, Offset: 0x1757
// Size: 0x55
function objective_mask_showtoenemyteam( objid, ent )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_removeallfrommask( objid );
    
    if ( level.teambased )
    {
        objective_addteamtomask( objid, ent.team );
    }
    else
    {
        objective_addclienttomask( objid, ent );
    }
    
    objective_hidefromplayersinmask( objid );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0xa73aee23, Offset: 0x17b4
// Size: 0x2d
function objective_teammask_addtomask( objid, team )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_addteamtomask( objid, team );
    objective_showtoplayersinmask( objid );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0x2d1b7210, Offset: 0x17e9
// Size: 0x2d
function objective_teammask_removefrommask( objid, team )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_removeteamfrommask( objid, team );
    objective_showtoplayersinmask( objid );
}

// Namespace objidpoolmanager
// Params 1
// Checksum 0xaf3e16a3, Offset: 0x181e
// Size: 0x23
function function_7736d86e518e223( objid )
{
    if ( objid == -1 )
    {
        return;
    }
    
    function_54cba32e5f1bc379( objid );
    objective_showtoplayersinmask( objid );
}

// Namespace objidpoolmanager
// Params 1
// Checksum 0x6f06ca5d, Offset: 0x1849
// Size: 0x23
function function_6bc07fb92848feab( objid )
{
    if ( objid == -1 )
    {
        return;
    }
    
    function_82680923a320d0af( objid );
    objective_showtoplayersinmask( objid );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0xe0b0e78e, Offset: 0x1874
// Size: 0x26
function objective_pin_global( objid, pin )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_setpinned( objid, pin );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0xc84a6aeb, Offset: 0x18a2
// Size: 0x26
function objective_pin_team( objid, team )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_pinforteam( objid, team );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0xbda5639f, Offset: 0x18d0
// Size: 0x26
function objective_unpin_team( objid, team )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_unpinforteam( objid, team );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0x25142bae, Offset: 0x18fe
// Size: 0x35
function objective_pin_player( objid, player )
{
    if ( objid == -1 || player.var_20fb6d9e02a1d35 )
    {
        return;
    }
    
    objective_pinforclient( objid, player );
}

// Namespace objidpoolmanager
// Params 3
// Checksum 0xb8b284b4, Offset: 0x193b
// Size: 0x46
function objective_unpin_player( objid, player, showoncompass )
{
    if ( objid == -1 || player.var_20fb6d9e02a1d35 )
    {
        return;
    }
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    objective_unpinforclient( objid, player );
}

// Namespace objidpoolmanager
// Params 3
// Checksum 0x7f9373e0, Offset: 0x1989
// Size: 0x49
function objective_show_progress( objid, show, unfill )
{
    if ( objid == -1 )
    {
        return;
    }
    
    if ( show && !unfill )
    {
        level notify( #"objective_statechanged", objid );
    }
    
    objective_setshowprogress( objid, show );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0x93a9fc5e, Offset: 0x19da
// Size: 0x26
function function_4c19b2a4563b489( objid, islocked )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_lock( objid, islocked );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0x91135199, Offset: 0x1a08
// Size: 0x26
function function_802456723d69e7bf( objid, status )
{
    if ( objid == -1 )
    {
        return;
    }
    
    function_b2583b3d2410b72f( objid, status );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0xd27a597c, Offset: 0x1a36
// Size: 0x26
function function_5351931681767819( objid, time )
{
    if ( objid == -1 )
    {
        return;
    }
    
    function_1ee17e515805ab9e( objid, time );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0x1e733749, Offset: 0x1a64
// Size: 0x26
function function_e4d6a71507372662( objid, iszone )
{
    if ( objid == -1 )
    {
        return;
    }
    
    function_fc192168841a5e30( objid, iszone );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0x3da7d961, Offset: 0x1a92
// Size: 0x28
function function_b3b969f2930890eb( state, player )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    objective_setshowpinnedprogressbar( state, player );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0xa3f96388, Offset: 0x1ac2
// Size: 0x28
function function_9d3f184285ca25e4( text, player )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    objective_setpinnedprogressbartext( text, player );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0x7e24378b, Offset: 0x1af2
// Size: 0x26
function objective_show_team_progress( objid, team )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_showprogressforteam( objid, team );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0x3fd2fdce, Offset: 0x1b20
// Size: 0x26
function objective_hide_team_progress( objid, team )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_hideprogressforteam( objid, team );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0x5acd81fe, Offset: 0x1b4e
// Size: 0x35
function objective_show_player_progress( objid, player )
{
    if ( objid == -1 || player.var_20fb6d9e02a1d35 )
    {
        return;
    }
    
    objective_showprogressforclient( objid, player );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0x90ce45a7, Offset: 0x1b8b
// Size: 0x35
function objective_hide_player_progress( objid, player )
{
    if ( objid == -1 || player.var_20fb6d9e02a1d35 )
    {
        return;
    }
    
    objective_hideprogressforclient( objid, player );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0xe2bea329, Offset: 0x1bc8
// Size: 0x2e
function objective_set_show_progress( objid, showprogress )
{
    if ( !isdefined( objid ) || objid == -1 )
    {
        return;
    }
    
    objective_setshowprogress( objid, showprogress );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0xad91b66c, Offset: 0x1bfe
// Size: 0x26
function objective_set_progress( objid, progress )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_setprogress( objid, progress );
}

// Namespace objidpoolmanager
// Params 3
// Checksum 0x71c907b0, Offset: 0x1c2c
// Size: 0x30
function objective_set_progress_count( objid, current, max )
{
    if ( objid == -1 )
    {
        return;
    }
    
    function_15f29908a6fed8cd( objid, current, max );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0xc6cab26, Offset: 0x1c64
// Size: 0x26
function objective_set_progress_team( objid, team )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_setprogressteam( objid, team );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0xfb1331d, Offset: 0x1c92
// Size: 0x26
function function_84651f3f2873ee19( objid, team )
{
    if ( objid == -1 )
    {
        return;
    }
    
    function_b07c4d6d86c731fb( objid, team );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0xe87eca9d, Offset: 0x1cc0
// Size: 0x35
function objective_set_progress_client( objid, player )
{
    if ( objid == -1 || player.var_20fb6d9e02a1d35 )
    {
        return;
    }
    
    objective_setprogressclient( objid, player );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0x112cad76, Offset: 0x1cfd
// Size: 0x26
function objective_set_play_intro( objid, show )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_setplayintro( objid, show );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0x112cad76, Offset: 0x1d2b
// Size: 0x26
function objective_set_play_outro( objid, show )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_setplayoutro( objid, show );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0x3bae5a54, Offset: 0x1d59
// Size: 0x26
function objective_set_pulsate( objid, pulse )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_setpulsate( objid, pulse );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0x41bd16f5, Offset: 0x1d87
// Size: 0x26
function function_4b37488488e7d007( objid, show )
{
    if ( objid == -1 )
    {
        return;
    }
    
    function_90a7a0e6b30de7b9( objid, show );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0x3d341114, Offset: 0x1db5
// Size: 0x26
function function_1f589e274283d14a( objid, show )
{
    if ( objid == -1 )
    {
        return;
    }
    
    function_eb48368e1cb0b7c( objid, show );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0x1b9c6e1b, Offset: 0x1de3
// Size: 0x26
function function_79ca076cf9eccbd9( objid, hide )
{
    if ( objid == -1 )
    {
        return;
    }
    
    function_2b8e3d3ae2a6414a( objid, hide );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0xfba969f3, Offset: 0x1e11
// Size: 0x26
function function_586b631e7bbb592a( objid, hide )
{
    if ( objid == -1 )
    {
        return;
    }
    
    function_44a344c68a68f28d( objid, hide );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0x46171c13, Offset: 0x1e3f
// Size: 0x26
function function_b1d5cb1069461e4f( objid, show )
{
    if ( objid == -1 )
    {
        return;
    }
    
    function_59c2c5d8363fbea0( objid, show );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0xd45ca3c, Offset: 0x1e6d
// Size: 0x26
function function_7c18c3f099912ff7( objid, show )
{
    if ( objid == -1 )
    {
        return;
    }
    
    function_d8515d9148d4388( objid, show );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0xecb28349, Offset: 0x1e9b
// Size: 0x26
function function_7761497b2fad8864( objid, var_9ebf8aea2b6d27a0 )
{
    if ( objid == -1 )
    {
        return;
    }
    
    function_382097d8732a0c41( objid, var_9ebf8aea2b6d27a0 );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0x2a76444d, Offset: 0x1ec9
// Size: 0x26
function function_5ebf6b201daf1c5( objid, var_9ebf8aea2b6d27a0 )
{
    if ( objid == -1 )
    {
        return;
    }
    
    function_8af0b8f18059cd2( objid, var_9ebf8aea2b6d27a0 );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0xc650e9b2, Offset: 0x1ef7
// Size: 0x26
function function_c34959a44b376957( objid, type )
{
    if ( objid == -1 )
    {
        return;
    }
    
    function_3759e26b1b750f5( objid, type );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0x12640afc, Offset: 0x1f25
// Size: 0x26
function function_1a27e9b999215f16( objid, hovercardindex )
{
    if ( objid == -1 )
    {
        return;
    }
    
    function_3f1a6a0ae5901866( objid, hovercardindex );
}

// Namespace objidpoolmanager
// Params 4
// Checksum 0x3dc0c1a5, Offset: 0x1f53
// Size: 0x48
function function_ce74ca2fcf1ffda7( objid, friendlyhovercardindex, enemyhovercardindex, neutralhovercardindex )
{
    if ( objid == -1 )
    {
        return;
    }
    
    function_95c77469baad8b7d( objid, friendlyhovercardindex );
    function_968e4bef92f91d1a( objid, enemyhovercardindex );
    function_ac6baf713fbab5ad( objid, neutralhovercardindex );
}

// Namespace objidpoolmanager
// Params 6
// Checksum 0x8c412ccb, Offset: 0x1fa3
// Size: 0xdc
function createobjective( shadername, team, friendlyonly, var_e42758791863cafb, var_97753f9fa027d9e2, iconsize )
{
    curobjid = createobjective_hidden( shadername, var_e42758791863cafb, var_97753f9fa027d9e2, iconsize );
    
    if ( level.teambased )
    {
        if ( isdefined( team ) )
        {
            update_objective_ownerteam( curobjid, team );
        }
    }
    else if ( isdefined( self.owner ) )
    {
        update_objective_ownerclient( curobjid, self.owner );
    }
    
    if ( friendlyonly )
    {
        if ( level.teambased )
        {
            objective_mask_showtoplayerteam( curobjid, self, team );
        }
        else
        {
            function_209503f30f7b215a( curobjid, self );
        }
    }
    else
    {
        objective_playermask_showtoall( curobjid );
    }
    
    if ( level.objvisall )
    {
        objective_playermask_showtoall( curobjid );
    }
    
    return curobjid;
}

// Namespace objidpoolmanager
// Params 4
// Checksum 0x59f4efd6, Offset: 0x2088
// Size: 0x4a
function createobjective_hidden( shadername, var_e42758791863cafb, var_97753f9fa027d9e2, iconsize )
{
    curobjid = createobjective_internal( shadername, var_e42758791863cafb, var_97753f9fa027d9e2, iconsize );
    objective_playermask_hidefromall( curobjid );
    return curobjid;
}

// Namespace objidpoolmanager
// Params 4
// Checksum 0xe5bcea30, Offset: 0x20db
// Size: 0xf3
function createobjective_engineer( shadername, var_e42758791863cafb, var_97753f9fa027d9e2, iconsize )
{
    curobjid = undefined;
    createfunc = undefined;
    
    if ( utility::issharedfuncdefined( #"game", #"createobjectivehidden" ) )
    {
        createfunc = utility::getsharedfunc( #"game", #"createobjectivehidden" );
    }
    
    level_info = level.var_6f47ece75eebb413;
    
    if ( isdefined( createfunc ) )
    {
        icon = shadername;
        
        if ( isdefined( level_info ) && isdefined( level_info.bundle.assassin_minimap_icon ) )
        {
            if ( !isdefined( icon ) )
            {
                icon = level_info.bundle.assassin_minimap_icon;
            }
        }
        
        curobjid = [[ createfunc ]]( icon, var_e42758791863cafb, var_97753f9fa027d9e2, iconsize );
        update_objective_ownerteam( curobjid, self.team );
    }
    
    return curobjid;
}

// Namespace objidpoolmanager
// Params 4
// Checksum 0x8d992c46, Offset: 0x21d7
// Size: 0xe2
function createobjective_internal( shadername, var_e42758791863cafb, var_97753f9fa027d9e2, iconsize )
{
    curobjid = requestobjectiveid( 10 );
    
    if ( curobjid == -1 )
    {
        return -1;
    }
    
    objective_add_objective( curobjid, "invisible", ( 0, 0, 0 ) );
    
    if ( ( !isent( self ) || !isdefined( self getlinkedparent() ) ) && !var_e42758791863cafb )
    {
        update_objective_position( curobjid, self.origin );
    }
    else if ( var_e42758791863cafb && var_97753f9fa027d9e2 )
    {
        update_objective_onentitywithrotation( curobjid, self );
    }
    else
    {
        update_objective_onentity( curobjid, self );
    }
    
    update_objective_state( curobjid, "active" );
    update_objective_icon( curobjid, shadername );
    update_objective_setbackground( curobjid, 1 );
    update_objective_size( curobjid, iconsize );
    return curobjid;
}

// Namespace objidpoolmanager
// Params 3
// Checksum 0x10e67c8d, Offset: 0x22c2
// Size: 0x69
function function_101225acbc89c1c1( progressbarstate, text, omnvarvalue )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( getdvarint( @"hash_141de4492226006e", 1 ) == 1 )
    {
        function_b3b969f2930890eb( progressbarstate, self );
        function_9d3f184285ca25e4( text ?? "", self );
        return;
    }
    
    self setclientomnvar( "ui_objective_pinned_text_param", omnvarvalue );
}

// Namespace objidpoolmanager
// Params 5
// Checksum 0x4d074d4c, Offset: 0x2333
// Size: 0xa8
function function_72efeaceb614613a( objid, player, priority, state, text )
{
    if ( objid == -1 || player.var_20fb6d9e02a1d35 )
    {
        return;
    }
    
    if ( !isdefined( player.objectivepriority ) )
    {
        player.objectivepriority = 0;
    }
    
    if ( player.objectivepriority < priority )
    {
        player.objectivepriority = priority;
        objective_show_player_progress( objid, player );
        function_9d3f184285ca25e4( text, player );
        function_b3b969f2930890eb( state, player );
        return 1;
    }
    
    return 0;
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0xf0cbe1db, Offset: 0x23e3
// Size: 0x56
function function_6ac40386d1cd0d9a( objid, player )
{
    if ( objid == -1 || !isdefined( player ) || player.var_20fb6d9e02a1d35 )
    {
        return;
    }
    
    player.objectivepriority = 0;
    objective_hide_player_progress( objid, player );
    function_b3b969f2930890eb( 0, player );
}

// Namespace objidpoolmanager
// Params 1
// Checksum 0xb45a46fd, Offset: 0x2441
// Size: 0x19
function function_beebd729a49b6cc3( player )
{
    player.objectivepriority = 0;
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0x28d7dd37, Offset: 0x2462
// Size: 0x26
function objective_showdistance( objid, shouldshow )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_setshowdistance( objid, shouldshow );
}

// Namespace objidpoolmanager
// Params 3
// Checksum 0xd010b73, Offset: 0x2490
// Size: 0x30
function function_de3fb937d4f45f38( objid, var_1e1ecace3b3c2a63, var_ee7bc8b53cebd37e )
{
    if ( objid == -1 )
    {
        return;
    }
    
    function_ac9886e0e2860e18( objid, var_1e1ecace3b3c2a63, var_ee7bc8b53cebd37e );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0x6037514, Offset: 0x24c8
// Size: 0x26
function function_9d4895ed38151e46( objid, shouldhide )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_sethideelevation( objid, shouldhide );
}

// Namespace objidpoolmanager
// Params 5
// Checksum 0x2c9c1279, Offset: 0x24f6
// Size: 0x45
function function_373aaf492aabde6f( objid, r, g, b, active )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_settint( objid, r, g, b, active );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0xbc5f9aac, Offset: 0x2543
// Size: 0x5b
function function_91c357c4f0f071a7( objid, presetref )
{
    if ( objid == -1 || !level.var_a66c07eb5b43687.size )
    {
        return;
    }
    
    preset = level.var_a66c07eb5b43687[ presetref ];
    
    if ( !isdefined( preset ) )
    {
        return;
    }
    
    function_ac9886e0e2860e18( objid, preset[ 0 ], preset[ 1 ] );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0x9d41462a, Offset: 0x25a6
// Size: 0x26
function objective_showtimer( objid, shouldshow )
{
    if ( objid == -1 )
    {
        return;
    }
    
    function_e1fd1567e23d7454( objid, shouldshow );
}

// Namespace objidpoolmanager
// Params 2
// Checksum 0xb20399bc, Offset: 0x25d4
// Size: 0x26
function function_567c775d86428d7( objid, zoomlevel )
{
    if ( objid == -1 )
    {
        return;
    }
    
    function_abf66d2f44db2c72( objid, zoomlevel );
}

