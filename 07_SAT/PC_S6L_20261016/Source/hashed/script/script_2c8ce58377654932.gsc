// script_2c8ce58377654932  (hash_2c8ce58377654932.gscc) (size: 22754 Bytes / 0x58e2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc1a8edbb (3249073595)
// size ...... 22754 (0x58e2)
// includes .. 13  (offset: 0x543e)
// strings ... 68  (offset: 0x54a6)
// dev strs .. 10  (offset: 0x586a)
// exports ... 48  (offset: 0x3bd2)
// cseg ...... 0x510 + 0x36c2 (0x3bd2)
// imports ... 135 (offset: 0x4352)
// animtree1 . 0   (offset: 0x58e2)
// animtree2 . 0   (offset: 0x58e2)
#using scripts\common\callbacks;
#using scripts\common\omnvar_utility;
#using scripts\common\utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\skirmish_activity_manager;
#using scripts\mp\gametypes\skirmish_util;
#using scripts\mp\objidpoolmanager;

#namespace namespace_e965e5c30872dcae;

// Namespace namespace_e965e5c30872dcae
// Params 0
// Checksum 0x80b212da, Offset: 0x52e
// Size: 0x513
function init()
{
    level.var_3a3b9a0af2ceee4 = getmatchrulesdata( "skirmishData", "captureTime" );
    level.var_cb87bb6555f6eb52 = getmatchrulesdata( "skirmishData", "secureRadius" );
    level.var_8dd46223a66b9760 = level.gametypebundle.var_d53839bc5188682;
    level.var_f2eaa4f7b281eece = level.gametypebundle.var_f2929f7952dc8ad0;
    level.var_7ef9c9868ae8b25e = level.gametypebundle.var_266e0d6731b4f546;
    level.var_aa3648dc6237fc9a = level.gametypebundle.var_80e37eae18ccdad6;
    level.var_85b177faa9935b2a.var_61c006b49d4bc07d = getdvarint( @"hash_eee08f810315b8fb", level.gametypebundle.var_61c006b49d4bc07d ) == 1;
    level.var_9a7ba85e3b2e411d = getdvarint( @"hash_e9b973cf7e2f1eda", 1 );
    level.var_b1f3bfc4cefdc0bc = getdvarint( @"hash_edee111bfe61c070", 2 );
    level.var_ef13effbfbcc37d = getdvarfloat( @"hash_9a34342a7ffb03ff", 2.25 );
    level.var_416a7c7caeabd6e7[ "a" ] = ( -5156, 3856, 316 );
    level.var_416a7c7caeabd6e7[ "b" ] = ( -5659, -1575, -66 );
    level.var_416a7c7caeabd6e7[ "c" ] = ( -4995, -5621, 292.7 );
    level.var_416a7c7caeabd6e7[ "d" ] = ( 5, 501, 1048 );
    level.var_416a7c7caeabd6e7[ "e" ] = ( 2159, -3640, -1.3 );
    level.var_416a7c7caeabd6e7[ "f" ] = ( 4178, 750, 432 );
    level.var_416a7c7caeabd6e7[ "g" ] = ( 7488, 1610, -166 );
    level.var_416a7c7caeabd6e7[ "h" ] = ( 2662, 6063, -123.9 );
    
    if ( level.var_7ef9c9868ae8b25e )
    {
        if ( level.var_aa3648dc6237fc9a )
        {
            level.var_64ba6deb7c92d094[ "secure_a" ] = [ ( 0, 0, 0 ), ( 0, 500, 0 ), ( 0, 0, 0 ) ];
            level.var_64ba6deb7c92d094[ "secure_b" ] = [ ( 500, 0, 0 ), ( 500, 500, 0 ), ( 500, 0, 0 ) ];
            level.var_64ba6deb7c92d094[ "secure_c" ] = [ ( 1000, 0, 0 ), ( 1000, 500, 0 ), ( 1000, 0, 0 ) ];
            level.var_64ba6deb7c92d094[ "secure_d" ] = [ ( 1500, 0, 0 ), ( 1500, 500, 0 ), ( 1500, 0, 0 ) ];
            level.var_64ba6deb7c92d094[ "secure_e" ] = [ ( 2000, 0, 0 ), ( 2000, 500, 0 ), ( 2000, 0, 0 ) ];
            level.var_64ba6deb7c92d094[ "secure_f" ] = [ ( 2500, 0, 0 ), ( 2500, 500, 0 ), ( 2500, 0, 0 ) ];
            level.var_64ba6deb7c92d094[ "secure_g" ] = [ ( 3000, 0, 0 ), ( 3000, 500, 0 ), ( 3000, 0, 0 ) ];
            level.var_64ba6deb7c92d094[ "secure_h" ] = [ ( 3500, 0, 0 ), ( 3500, 500, 0 ), ( 3500, 0, 0 ) ];
            level.var_64ba6deb7c92d094[ "secure_i" ] = [ ( 4000, 0, 0 ), ( 4000, 500, 0 ), ( 4000, 0, 0 ) ];
            level.var_64ba6deb7c92d094[ "secure_j" ] = [ ( 4500, 0, 0 ), ( 4500, 500, 0 ), ( 4500, 0, 0 ) ];
            function_d3654c7bc071c9b5();
        }
        
        level callback::add( #"killstreak_begin_use", &function_21396bf10feb0abc );
        level callback::add( #"killstreak_finish_use", &on_killstreak_finish_use );
    }
    
    level callback::add( #"player_disconnect", &onplayerdisconnect );
}

// Namespace namespace_e965e5c30872dcae
// Params 0
// Checksum 0x8982334a, Offset: 0xa49
// Size: 0x12f
function function_d3654c7bc071c9b5()
{
    foreach ( pathname, pathnodes in level.var_64ba6deb7c92d094 )
    {
        foreach ( index, nodeorigin in pathnodes )
        {
            nodestruct = spawnstruct();
            nodestruct.targetname = pathname + "_node_" + index;
            nodestruct.target = pathname + "_node_" + index + 1;
            nodestruct.origin = nodeorigin;
            utility::addstruct( nodestruct );
        }
    }
}

// Namespace namespace_e965e5c30872dcae
// Params 1
// Checksum 0x84e03daa, Offset: 0xb80
// Size: 0x97
function getpatrolpath( pathname )
{
    patharray = [];
    startnode = utility::getstruct( pathname + "_node_0", "targetname" );
    
    if ( !isdefined( startnode ) )
    {
        return;
    }
    
    patharray[ patharray.size ] = startnode;
    currnode = startnode;
    
    while ( true )
    {
        if ( !isdefined( currnode.target ) )
        {
            break;
        }
        
        currnode = utility::getstruct( currnode.target, "targetname" );
        
        if ( !isdefined( currnode ) )
        {
            break;
        }
        
        patharray[ patharray.size ] = currnode;
    }
    
    return patharray;
}

// Namespace namespace_e965e5c30872dcae
// Params 0
// Checksum 0x8a285120, Offset: 0xc20
// Size: 0x33
function getnextnode()
{
    if ( self.patrolpath.size == self.currentnode + 1 )
    {
        return;
    }
    
    return self.patrolpath[ self.currentnode + 1 ];
}

// Namespace namespace_e965e5c30872dcae
// Params 1
// Checksum 0x63c2f930, Offset: 0xc5c
// Size: 0xa02
function function_4be998cd802fd4ec( params )
{
    assert( isstruct( params ) );
    level endon( #"game_ended" );
    triggers = getentarray( "skirmish_secure", #targetname );
    flagstructs = utility::getstructarray( "skirmish_secure_flag_origin" );
    
    foreach ( trigger in triggers )
    {
        if ( trigger.target == params.target && level.var_f2eaa4f7b281eece )
        {
            flagorigin = trigger.origin;
            
            foreach ( flagstruct in flagstructs )
            {
                if ( flagstruct.script_noteworthy == params.target )
                {
                    flagorigin = flagstruct.origin;
                    break;
                }
            }
            
            level.secureinstance[ params.target ].objidnum = objidpoolmanager::requestobjectiveid( 1 );
            level.secureinstance[ params.target ] = gameobjects::createuseobject( "neutral", trigger, [], ( 0, 0, 45 ), level.secureinstance[ params.target ].objidnum, undefined, 0 );
            level.secureinstance[ params.target ] gameobjects::setvisibleteam( "any" );
            level.secureinstance[ params.target ].showworldicon = 0;
            level.secureinstance[ params.target ].flagid = params.target;
            level.secureinstance[ params.target ].activitytype = params.type;
            level.secureinstance[ params.target ].activityname = params.name;
            level.secureinstance[ params.target ].origin = flagorigin;
            level.secureinstance[ params.target ] thread securechevrons( trigger.target, trigger.script_label );
            level.secureinstance[ params.target ].onplayerexit = &onplayerexit;
            level.secureinstance[ params.target ].var_f86aff2e377524e = 0;
            level.secureinstance[ params.target ] skirmish_util::function_27e85aa699653fa1( "waypoint_secure" );
            level.secureinstance[ params.target ] function_ebe709e6217ad62f( level.secureinstance[ params.target ].objidnum, level.secureinstance[ params.target ].origin );
            return level.secureinstance[ params.target ];
        }
    }
    
    if ( level.var_7ef9c9868ae8b25e )
    {
        securestartnode = utility::getstruct( params.target + "_node_0", "targetname" );
        level.secureinstance[ params.target ] = spawn( "script_model", securestartnode.origin );
        level.secureinstance[ params.target ].showworldicon = 0;
        level.secureinstance[ params.target ].flagid = params.target;
        level.secureinstance[ params.target ].activitytype = params.type;
        level.secureinstance[ params.target ].activityname = params.name;
        level.secureinstance[ params.target ].objidnum = objidpoolmanager::requestobjectiveid( 1 );
        level.secureinstance[ params.target ].offset3d = ( 0, 0, 45 );
        level.secureinstance[ params.target ] gameobjects::setvisibleteam( "any" );
        level.secureinstance[ params.target ].patrolpath = getpatrolpath( params.target );
        level.secureinstance[ params.target ].currentnode = 0;
        level.secureinstance[ params.target ] setmodel( "skirmish_secure_script_fx_origin" );
        objidpoolmanager::objective_add_objective( level.secureinstance[ params.target ].objidnum, "current", securestartnode.origin + level.secureinstance[ params.target ].offset3d, undefined );
        level.secureinstance[ params.target ] skirmish_util::function_27e85aa699653fa1( "waypoint_secure", undefined, level.secureinstance[ params.target ].objidnum );
        level.secureinstance[ params.target ] function_ebe709e6217ad62f( level.secureinstance[ params.target ].objidnum, level.secureinstance[ params.target ].origin );
        level.secureinstance[ params.target ] setscriptablepartstate( "main", "disabled" );
        trigger = spawn( "trigger_radius", level.secureinstance[ params.target ].origin, 0, level.var_cb87bb6555f6eb52, 60 );
        playingzone = gameobjects::createuseobject( "neutral", trigger, [], ( 0, 0, 45 ), level.secureinstance[ params.target ].objidnum, undefined, 0 );
        playingzone.onplayerenter = &function_61f15e25c5679dd3;
        playingzone.onplayerexit = &playermonitorexit;
        playingzone.playersintrigger = [];
        playingzone.trigger enablelinkto();
        playingzone.trigger linkto( level.secureinstance[ params.target ] );
        playingzone.activity_instance = level.secureinstance[ params.target ];
        level.secureinstance[ params.target ].var_132b898496c602a7 = playingzone;
        return level.secureinstance[ params.target ];
    }
    
    if ( isdefined( level.var_416a7c7caeabd6e7[ params.target ] ) )
    {
        level.secureinstance[ params.target ] = spawnstruct();
        level.secureinstance[ params.target ].flagid = params.target;
        level.secureinstance[ params.target ].activitytype = params.type;
        level.secureinstance[ params.target ].activityname = params.name;
        level.secureinstance[ params.target ].origin = level.secureinstance[ params.target ].flagorigin;
        level.secureinstance[ params.target ].offset3d = ( 0, 0, 45 );
        level.secureinstance[ params.target ].objidnum = objidpoolmanager::requestobjectiveid( 1 );
        level.secureinstance[ params.target ] skirmish_util::function_27e85aa699653fa1( "waypoint_secure" );
        level.secureinstance[ params.target ] function_ebe709e6217ad62f( level.secureinstance[ params.target ].objidnum, level.secureinstance[ params.target ].origin );
        return level.secureinstance[ params.target ];
    }
}

// Namespace namespace_e965e5c30872dcae
// Params 2
// Checksum 0x9454222d, Offset: 0x1667
// Size: 0x29
function function_dc45388a42fe7e( secureinstance, params )
{
    secureinstance thread function_90f65a5fb3b9712c( params.var_51f5a92414c2f4f8 );
}

// Namespace namespace_e965e5c30872dcae
// Params 1
// Checksum 0xdb16477b, Offset: 0x1698
// Size: 0xd0
function function_72fb79e8e2124f3( params )
{
    assert( isstruct( params ) );
    flagcarrier = level.secureinstance[ params.target ].claimplayer;
    level.secureinstance[ params.target ].var_132b898496c602a7.trigger delete();
    level.secureinstance[ params.target ] = undefined;
    skirmish_util::function_3059ce0968f29709( "secure_", flagcarrier, params.winningteam );
    skirmish_util::function_f0219df3de59b8fc( #"hash_ae862a87fbde993b", flagcarrier.origin, level.var_fd5a14340d3320e9, params.winningteam );
}

// Namespace namespace_e965e5c30872dcae
// Params 1
// Checksum 0xf536f37b, Offset: 0x1770
// Size: 0xe8
function function_ab80adb41ddd9fc0( param )
{
    triggers = getentarray( "skirmish_secure", #targetname );
    
    foreach ( trigger in triggers )
    {
        if ( trigger.target == param && level.var_f2eaa4f7b281eece )
        {
            return trigger.origin;
        }
    }
    
    if ( level.var_7ef9c9868ae8b25e )
    {
        return getpatrolpath( param )[ 0 ].origin;
    }
    
    return level.var_416a7c7caeabd6e7[ param ];
}

// Namespace namespace_e965e5c30872dcae
// Params 1, eflags: 0x4
// Checksum 0xc8da72c, Offset: 0x1861
// Size: 0x1c6
function private function_90f65a5fb3b9712c( var_98a051b80739a41e )
{
    level endon( #"game_ended" );
    self endon( #"hash_2ab96b9b977e9d35" );
    self.var_98a051b80739a41e = var_98a051b80739a41e;
    
    /#
        self.var_7a8784dd3bfbf9a2 = getdvarint( @"hash_fb0c6496a228c83f", 0 );
        printtoscreen2d( 50, 675, "<dev string:x24>" + self.flagid, ( 1, 0, 1 ), 1.5, 500 );
        
        if ( self.var_7a8784dd3bfbf9a2 )
        {
            thread zonedebug();
        }
    #/
    
    self.teamprogress = [];
    self.teamprogress[ "axis" ] = 0;
    self.teamprogress[ "allies" ] = 0;
    self.skrflagcarrier = undefined;
    thread flag_watchpickup( flag_makepickup() );
    var_9dc85fa33317c3a0 = skirmish_util::function_afc407a06438534e( self ) ? "SKR_Secure_Objective_Heat" : "SKR_Secure_Objective";
    game_utility::questcircle_create( var_9dc85fa33317c3a0, level.secureinstance[ self.flagid ].origin, level.var_fd5a14340d3320e9 );
    game_utility::questcircle_showtoall();
    self.var_d339769714fc98ac = 0;
    thread function_3fec787e1e063a4f();
    
    while ( true )
    {
        utility::waittill_any( "skr_flag_dropped", "skr_flag_picked_up" );
        
        if ( isdefined( self.skrflagcarrier ) )
        {
            if ( level.var_7ef9c9868ae8b25e )
            {
                self setscriptablepartstate( "main", self.skrflagcarrier.team );
                thread function_9d85499d322db5d4();
            }
            else
            {
                thread function_7639a0f5bb48d842();
            }
            
            thread function_157531f98340ad( self.skrflagcarrier );
            
            if ( !level.var_f2eaa4f7b281eece )
            {
                thread function_eed093f5030f08a6();
                continue;
            }
            
            thread function_947c268b8afab874();
        }
    }
}

// Namespace namespace_e965e5c30872dcae
// Params 1
// Checksum 0x487d37fa, Offset: 0x1a2f
// Size: 0x52
function function_157531f98340ad( skrflagcarrier )
{
    level endon( #"game_ended" );
    self endon( #"hash_2ab96b9b977e9d35" );
    self endon( #"skr_flag_dropped" );
    skrflagcarrier waittill( #"death_or_disconnect" );
    
    if ( isdefined( self.skrflagcarrier ) )
    {
        thread dropflag();
    }
}

// Namespace namespace_e965e5c30872dcae
// Params 1
// Checksum 0x29bb6fa0, Offset: 0x1a89
// Size: 0xe2
function flag_makepickup( flagdroppoint )
{
    level endon( #"game_ended" );
    self endon( #"hash_2ab96b9b977e9d35" );
    flagorigin = flagdroppoint ?? level.secureinstance[ self.flagid ].origin;
    
    /#
        if ( self.var_7a8784dd3bfbf9a2 )
        {
            thread flagdebug( flagdroppoint );
        }
    #/
    
    var_e4d7f49e8039a388 = spawn( "script_model", flagorigin );
    var_e4d7f49e8039a388.trigger = spawn( "trigger_radius", flagorigin, 0, 20, 60 );
    var_e4d7f49e8039a388.var_98a051b80739a41e = self.var_98a051b80739a41e;
    var_e4d7f49e8039a388 setmodel( "misc_loot_activity_phone_skr" );
    self.outlineid = outline::outlineenableforall( var_e4d7f49e8039a388, "sat_transmit_outline_skirmish", "equipment" );
    function_bdb4e5985ee57345( flagorigin );
    return var_e4d7f49e8039a388;
}

// Namespace namespace_e965e5c30872dcae
// Params 1
// Checksum 0x6bd26599, Offset: 0x1b74
// Size: 0x25d
function flag_watchpickup( var_e4d7f49e8039a388 )
{
    self endon( #"game_ended" );
    self endon( #"hash_2ab96b9b977e9d35" );
    self endon( #"skr_flag_picked_up" );
    var_2ea0d6d5293b708b = undefined;
    
    if ( level.var_f2eaa4f7b281eece )
    {
        var_2ea0d6d5293b708b = self.trigger getentitynumber();
    }
    
    while ( true )
    {
        var_e4d7f49e8039a388.trigger waittill( #"trigger", player );
        
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        if ( !player player::isreallyalive() )
        {
            continue;
        }
        
        if ( player ismeatshieldvictim() )
        {
            continue;
        }
        
        if ( level.var_f2eaa4f7b281eece )
        {
            if ( !isdefined( player.touchtriggers[ var_2ea0d6d5293b708b ] ) )
            {
                continue;
            }
            
            set_chevron_state( player.pers[ "team" ] );
        }
        
        playsoundatpos( player.origin, "amb_emt_t10_skirmish_secure_asset_picked" );
        player.var_4fb9141feec972cf = spawn( "script_model", player.origin );
        player.var_4fb9141feec972cf setmodel( "tag_origin" );
        player.var_4fb9141feec972cf linkto( player, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        player.var_4fb9141feec972cf playloopsound( #"hash_c05bae488cb029c5" );
        outline::outlinedisable( self.outlineid, self );
        var_e4d7f49e8039a388.trigger delete();
        var_e4d7f49e8039a388 delete();
        self.skrflagcarrier = player;
        player outline_create();
        self.var_9f54249c905fec90 = 0;
        flagcarrierclientnum = self.skrflagcarrier getplayerclientnum();
        
        if ( flagcarrierclientnum > 63 )
        {
            assert( "<dev string:x4f>" );
        }
        else
        {
            omnvar_offset = 17;
            omnvar_utility::function_8b206c75cb7ad548( "ui_objective_" + self.zone, omnvar_offset, 6, flagcarrierclientnum );
        }
        
        function_88069276d7b3c58b( player );
        player setclientomnvar( "ui_hud_carried_item_count", 1 );
        self notify( #"skr_flag_picked_up" );
        
        /#
            printtoscreen2d( 50, 575, "<dev string:x8e>", ( 1, 1, 1 ), 1.5, 100 );
        #/
    }
}

// Namespace namespace_e965e5c30872dcae
// Params 0
// Checksum 0xee272587, Offset: 0x1dd9
// Size: 0x360
function function_9d85499d322db5d4()
{
    level endon( #"game_ended" );
    self endon( #"hash_2ab96b9b977e9d35" );
    self endon( #"skr_flag_dropped" );
    self.skrflagcarrier endon( #"death_or_disconnect" );
    self.skrflagcarrier.securestreak = 0;
    self.var_6ad3d89d8ed567b2 = 1;
    function_26591dc81efa5fe8();
    
    while ( isdefined( self.skrflagcarrier ) )
    {
        flagcarrierteam = self.skrflagcarrier.team;
        nextnode = getnextnode();
        var_62f45dca84e04d58 = 1 - distance2d( self.origin, nextnode.origin ) / distance2d( self.patrolpath[ self.currentnode ].origin, nextnode.origin );
        var_62f45dca84e04d58 = clamp( var_62f45dca84e04d58, 0, 1 );
        var_9a36202726bf2200 = ( self.currentnode + var_62f45dca84e04d58 ) / ( self.patrolpath.size - 1 );
        var_9a36202726bf2200 = clamp( var_9a36202726bf2200, 0, 1 );
        self.skrflagcarrier setclientomnvar( "ui_objectiveSteppedProgressBar", var_9a36202726bf2200 );
        
        if ( var_62f45dca84e04d58 == 1 )
        {
            self.currentnode++;
            nextnode = getnextnode();
            
            if ( !isdefined( nextnode ) )
            {
                break;
            }
            
            movetoupdate( nextnode );
            var_86dff0e4653c8432 = skirmish_util::function_afc407a06438534e( self );
            pointsgained = level.var_9aa66bd5a0a587ad * ( var_86dff0e4653c8432 ? 2 : 1 );
            self.skrflagcarrier.securestreak += pointsgained;
            self.teamprogress[ flagcarrierteam ] += pointsgained;
            function_26591dc81efa5fe8();
            scoreeventmsg = var_86dff0e4653c8432 ? "mode_skr_flag_carry_hvs" : "mode_skr_flag_carry";
            skirmish_util::function_9bc92b9d0f473f97( level.var_9aa66bd5a0a587ad * ( var_86dff0e4653c8432 ? 2 : 1 ), scoreeventmsg, self.skrflagcarrier );
            
            foreach ( player in self.var_132b898496c602a7.playersintrigger )
            {
                if ( player.team == flagcarrierteam && player != self.skrflagcarrier )
                {
                    player points::doscoreevent( getxhash( scoreeventmsg ) );
                }
            }
        }
        else if ( self.var_6ad3d89d8ed567b2 )
        {
            movetoupdate( nextnode, 1 );
        }
        
        waitframe();
    }
    
    if ( player::isreallyalive( self.skrflagcarrier ) )
    {
        self.skrflagcarrier function_3f738cb141106e2f();
        self.skrflagcarrier playlocalsound( "uin_t10_skirmish_secure_objective_complete" );
        self setscriptablepartstate( "main", "disabled" );
        self.var_f86aff2e377524e = 1;
        thread function_e8e6fbcd8705f968( self.skrflagcarrier );
        self.skrflagcarrier = undefined;
    }
}

// Namespace namespace_e965e5c30872dcae
// Params 0
// Checksum 0xb2ca8596, Offset: 0x2141
// Size: 0x2df
function function_7639a0f5bb48d842()
{
    level endon( #"game_ended" );
    self endon( #"hash_2ab96b9b977e9d35" );
    self endon( #"skr_flag_dropped" );
    self.skrflagcarrier endon( #"death_or_disconnect" );
    self.skrflagcarrier.securestreak = 0;
    function_26591dc81efa5fe8();
    starttime = gettime();
    endtime = gettime() + level.var_3a3b9a0af2ceee4 * 1000;
    
    if ( level.var_9a7ba85e3b2e411d )
    {
        sectorcount = level.var_3a3b9a0af2ceee4 / level.var_296eaddf3f4f7675;
        var_a6293773e4a86c48 = starttime + level.var_b1f3bfc4cefdc0bc * 1000;
        var_ec5e2ab004f552fc = self.var_d339769714fc98ac * level.var_b1f3bfc4cefdc0bc * 1000;
        currentprogress = gettime() - starttime + var_ec5e2ab004f552fc / 1000;
        
        if ( currentprogress == 0 )
        {
            self.skrflagcarrier setclientomnvar( "ui_objectiveSteppedProgressBar", 0 );
        }
        else
        {
            self.skrflagcarrier setclientomnvar( "ui_objectiveSteppedProgressBar", currentprogress / level.var_3a3b9a0af2ceee4 );
        }
        
        while ( self.var_d339769714fc98ac < sectorcount )
        {
            waitframe();
            
            if ( isdefined( self.skrflagcarrier ) && gettime() > var_a6293773e4a86c48 )
            {
                var_86dff0e4653c8432 = skirmish_util::function_afc407a06438534e( self );
                self.skrflagcarrier setclientomnvar( "ui_objectiveSteppedProgressBar", ( gettime() - starttime + var_ec5e2ab004f552fc ) / level.var_3a3b9a0af2ceee4 * 1000 );
                var_a6293773e4a86c48 = gettime() + level.var_b1f3bfc4cefdc0bc * 1000;
                self.var_d339769714fc98ac++;
                self.skrflagcarrier.securestreak += level.var_51328d3d6cd16d3d * ( var_86dff0e4653c8432 ? 2 : 1 );
                function_26591dc81efa5fe8();
                scoreeventmsg = var_86dff0e4653c8432 ? "mode_skr_flag_carry_hvs" : "mode_skr_flag_carry";
                skirmish_util::function_9bc92b9d0f473f97( level.var_51328d3d6cd16d3d * ( var_86dff0e4653c8432 ? 2 : 1 ), scoreeventmsg, self.skrflagcarrier );
            }
        }
    }
    else
    {
        while ( gettime() < endtime )
        {
            waitframe();
            
            if ( isdefined( self.skrflagcarrier ) )
            {
                self.skrflagcarrier setclientomnvar( "ui_objectiveSteppedProgressBar", ( gettime() - starttime ) / 1000 );
            }
        }
    }
    
    if ( player::isreallyalive( self.skrflagcarrier ) )
    {
        self.skrflagcarrier function_3f738cb141106e2f();
        self.skrflagcarrier playlocalsound( "uin_t10_skirmish_secure_objective_complete" );
        self.var_f86aff2e377524e = 1;
        thread function_e8e6fbcd8705f968( self.skrflagcarrier );
        self.skrflagcarrier = undefined;
    }
}

// Namespace namespace_e965e5c30872dcae
// Params 1
// Checksum 0x62e8a884, Offset: 0x2428
// Size: 0x1f1
function function_e8e6fbcd8705f968( flagcarriercomplete )
{
    self notify( #"hash_2ab96b9b977e9d35" );
    
    if ( game_utility::questcircle_exists() )
    {
        game_utility::questcircle_delete();
    }
    
    flagcarriercomplete outline_clear();
    
    if ( level.var_f2eaa4f7b281eece )
    {
        set_chevron_state( "off" );
    }
    
    self.claimplayer = flagcarriercomplete;
    var_86dff0e4653c8432 = skirmish_util::function_afc407a06438534e( self );
    var_5f78c95518437eb3 = level.var_7ef9c9868ae8b25e ? level.var_32c152afc08dd0db : level.var_ad7564db111429d5;
    var_9f9b6dbb7538d427 = var_5f78c95518437eb3 * ( var_86dff0e4653c8432 ? 2 : 1 );
    self.teamprogress[ flagcarriercomplete.team ] += var_9f9b6dbb7538d427;
    var_13cb63f883077f27 = flagcarriercomplete.pers[ "team" ];
    scoreeventmsg = var_86dff0e4653c8432 ? #"hash_c6fa4b0db39d9cae" : #"hash_b975d11cd7750aea";
    flagcarriercomplete setclientomnvar( "ui_hud_carried_item_count", 0 );
    skirmish_util::function_7691fe63b803b07e( self.var_132b898496c602a7.playersintrigger, flagcarriercomplete.team, scoreeventmsg, flagcarriercomplete, 1 );
    skirmish_activity_manager::finishactivity( self.activitytype, self.activityname, var_13cb63f883077f27, [ flagcarriercomplete ] );
    function_1d607166f4de6f4c();
    
    if ( level.var_9a7ba85e3b2e411d )
    {
        wait 1.5;
    }
    
    flagcarriercomplete setclientomnvar( "ui_objectiveSteppedProgressBar", -1 );
    skirmish_util::function_9bc92b9d0f473f97( var_9f9b6dbb7538d427, scoreeventmsg, flagcarriercomplete );
    skirmish_util::function_55c12155a11106a0( flagcarriercomplete );
    
    /#
        printtoscreen2d( 50, 700, "<dev string:xa7>" + self.flagid + "<dev string:xb9>" + level.var_ad7564db111429d5 + "<dev string:xbf>", ( 0, 1, 0 ), 1.5, 100 );
    #/
}

// Namespace namespace_e965e5c30872dcae
// Params 1
// Checksum 0x9fed9da3, Offset: 0x2621
// Size: 0x30
function onplayerexit( player )
{
    if ( player == self.skrflagcarrier && !self.var_f86aff2e377524e )
    {
        dropflag();
    }
}

// Namespace namespace_e965e5c30872dcae
// Params 0
// Checksum 0xdd9dd893, Offset: 0x2659
// Size: 0x124
function function_eed093f5030f08a6()
{
    level endon( #"game_ended" );
    self endon( #"hash_2ab96b9b977e9d35" );
    self endon( #"skr_flag_dropped" );
    self.skrflagcarrier endon( #"death_or_disconnect" );
    
    while ( true )
    {
        if ( isdefined( self.skrflagcarrier ) )
        {
            var_b272729aee9a3ccc = distance2d( level.secureinstance[ self.flagid ].origin, self.skrflagcarrier.origin );
            
            if ( var_b272729aee9a3ccc >= level.var_cb87bb6555f6eb52 )
            {
                thread dropflag();
                return;
            }
            
            if ( var_b272729aee9a3ccc >= level.var_cb87bb6555f6eb52 - 100 && self.skrflagcarrier isonground() )
            {
                /#
                    printtoscreen2d( 50, 700, "<dev string:xc7>" + self.flagid, ( 1, 0, 0 ), 1.5, 100 );
                #/
            }
            else
            {
                function_273ab6e259fbabb4();
            }
            
            if ( !player::isreallyalive( self.skrflagcarrier ) )
            {
                thread dropflag();
                return;
            }
        }
        
        wait 0.1;
    }
}

// Namespace namespace_e965e5c30872dcae
// Params 0
// Checksum 0x5bfc0822, Offset: 0x2785
// Size: 0xed
function function_947c268b8afab874()
{
    level endon( #"game_ended" );
    self endon( #"hash_2ab96b9b977e9d35" );
    self endon( #"skr_flag_dropped" );
    self.skrflagcarrier endon( #"death_or_disconnect" );
    
    while ( isdefined( self.skrflagcarrier ) )
    {
        if ( isdefined( self.var_680c481fb5a582c4 ) )
        {
            var_fb46130abdfa7519 = distance2d( self.var_680c481fb5a582c4, self.skrflagcarrier.origin );
            
            if ( var_fb46130abdfa7519 > 20 && self.skrflagcarrier isonground() )
            {
                self.var_680c481fb5a582c4 = self.skrflagcarrier.origin;
            }
        }
        else if ( self.skrflagcarrier isonground() )
        {
            self.var_680c481fb5a582c4 = self.skrflagcarrier.origin;
        }
        
        wait 0.1;
    }
}

// Namespace namespace_e965e5c30872dcae
// Params 0
// Checksum 0x8f57c309, Offset: 0x287a
// Size: 0x81
function function_273ab6e259fbabb4()
{
    var_b272729aee9a3ccc = distance2d( level.secureinstance[ self.flagid ].origin, self.skrflagcarrier.origin );
    
    if ( var_b272729aee9a3ccc <= level.var_cb87bb6555f6eb52 - 100 && self.skrflagcarrier isonground() )
    {
        self.var_680c481fb5a582c4 = self.skrflagcarrier.origin;
    }
}

// Namespace namespace_e965e5c30872dcae
// Params 1
// Checksum 0x1a3bc159, Offset: 0x2903
// Size: 0x95
function onplayerdisconnect( params )
{
    foreach ( instance in level.secureinstance )
    {
        if ( self == instance.skrflagcarrier )
        {
            instance thread dropflag();
        }
    }
}

// Namespace namespace_e965e5c30872dcae
// Params 1, eflags: 0x4
// Checksum 0x124b17a1, Offset: 0x29a0
// Size: 0xbe
function private function_61f15e25c5679dd3( player )
{
    if ( !isdefined( self.var_63d1c1ac85f15eed[ player.team ] ) )
    {
        self.var_63d1c1ac85f15eed[ player.team ] = 0;
    }
    
    self.var_63d1c1ac85f15eed[ player.team ]++;
    self.playersintrigger[ self.playersintrigger.size ] = player;
    
    if ( player.team == self.activity_instance.skrflagcarrier.team )
    {
        self.activity_instance.var_6ad3d89d8ed567b2 = 1;
        self.activity_instance notify( #"hash_cb65fb6568c8fef1" );
    }
}

// Namespace namespace_e965e5c30872dcae
// Params 1, eflags: 0x4
// Checksum 0x6a76f710, Offset: 0x2a66
// Size: 0x90
function private playermonitorexit( player )
{
    self.var_63d1c1ac85f15eed[ player.team ]--;
    self.playersintrigger = arrayremove( self.playersintrigger, player );
    
    if ( player.team == self.activity_instance.skrflagcarrier.team )
    {
        self.activity_instance.var_6ad3d89d8ed567b2 = 1;
        self.activity_instance notify( #"hash_cb65fb6568c8fef1" );
    }
}

// Namespace namespace_e965e5c30872dcae
// Params 0, eflags: 0x4
// Checksum 0xf7ac14f7, Offset: 0x2afe
// Size: 0xb1
function private function_ba15682765a84aca()
{
    rate_array = [ 1, 1.4, 1.8, 2.2, 2.6, 3, 3 ];
    var_9a84669ee00948f9 = self.skrflagcarrier.team ? self.var_132b898496c602a7.var_63d1c1ac85f15eed[ self.skrflagcarrier.team ] : 0;
    var_1f4cb042194b3fa3 = clamp( var_9a84669ee00948f9, 1, 7 );
    return rate_array[ var_1f4cb042194b3fa3 - 1 ];
}

// Namespace namespace_e965e5c30872dcae
// Params 2, eflags: 0x4
// Checksum 0x30157a93, Offset: 0x2bb8
// Size: 0xd3
function private movetoupdate( goal_node, var_8b446f28594667cc )
{
    self endon( #"hash_cb65fb6568c8fef1" );
    
    if ( !goal_node )
    {
        return;
    }
    
    self.var_6ad3d89d8ed567b2 = 0;
    adjustedtime = level.var_ef13effbfbcc37d / function_ba15682765a84aca();
    movetimefrac = var_8b446f28594667cc ? distance2d( self.origin, goal_node.origin ) / distance2d( self.patrolpath[ self.currentnode ].origin, goal_node.origin ) : 1;
    self moveto( goal_node.origin, adjustedtime * movetimefrac );
    game_utility::questcircle_moveto( goal_node.origin, undefined, adjustedtime * movetimefrac );
}

// Namespace namespace_e965e5c30872dcae
// Params 1
// Checksum 0x2592712f, Offset: 0x2c93
// Size: 0x2a3
function dropflag( var_98a051b80739a41e )
{
    self endon( #"hash_2ab96b9b977e9d35" );
    self endon( #"skr_flag_dropped" );
    
    /#
        printtoscreen2d( 50, 675, "<dev string:xf9>" + self.flagid, ( 1, 0, 0 ), 1.5, 200 );
    #/
    
    objective_unpinforclient( self.objidnum, self.skrflagcarrier );
    
    if ( level.var_7ef9c9868ae8b25e )
    {
        level.secureinstance[ self.flagid ] moveto( level.secureinstance[ self.flagid ].origin, 0.1 );
        var_b272729aee9a3ccc = distance2d( level.secureinstance[ self.flagid ].origin, self.skrflagcarrier.origin );
        var_e473965e1fa87fbf = level.var_cb87bb6555f6eb52 - 100;
        
        if ( var_b272729aee9a3ccc <= var_e473965e1fa87fbf )
        {
            self.var_680c481fb5a582c4 = self.skrflagcarrier.origin;
        }
        else
        {
            self.var_680c481fb5a582c4 = vectorlerp( level.secureinstance[ self.flagid ].origin, self.skrflagcarrier.origin, var_e473965e1fa87fbf / var_b272729aee9a3ccc );
        }
        
        self.var_680c481fb5a582c4 = getgroundposition( self.var_680c481fb5a582c4, 20, 100, 100 );
    }
    
    if ( level.var_f2eaa4f7b281eece )
    {
        set_chevron_state( "idle" );
    }
    
    playsoundatpos( self.skrflagcarrier.origin, "amb_emt_t10_skirmish_secure_asset_dropped" );
    self.skrflagcarrier function_3f738cb141106e2f();
    self.skrflagcarrier setclientomnvar( "ui_objectiveSteppedProgressBar", -1 );
    self.skrflagcarrier setclientomnvar( "ui_hud_carried_item_count", 0 );
    self setscriptablepartstate( "main", "disabled" );
    
    if ( isdefined( self.skrflagcarrier ) )
    {
        self.skrflagcarrier outline_clear();
        self.skrflagcarrier = undefined;
    }
    
    if ( isdefined( self.var_680c481fb5a582c4 ) && ( level.var_8dd46223a66b9760 || level.var_7ef9c9868ae8b25e ) )
    {
        var_e4d7f49e8039a388 = flag_makepickup( self.var_680c481fb5a582c4 );
        wait 0.5;
        thread flag_watchpickup( var_e4d7f49e8039a388 );
        thread function_c37e026b20af695f( var_e4d7f49e8039a388 );
    }
    else
    {
        thread flag_watchpickup( flag_makepickup() );
    }
    
    self notify( #"skr_flag_dropped" );
}

// Namespace namespace_e965e5c30872dcae
// Params 1
// Checksum 0x2c9cb100, Offset: 0x2f3e
// Size: 0xa9
function function_c37e026b20af695f( var_e4d7f49e8039a388 )
{
    self endon( #"skr_flag_picked_up" );
    currentwaittime = 0;
    
    while ( currentwaittime < 10 )
    {
        waitframe();
        currentwaittime += level.framedurationseconds;
    }
    
    var_e4d7f49e8039a388.trigger delete();
    var_e4d7f49e8039a388 delete();
    self notify( #"skr_flag_reset" );
    thread flag_watchpickup( flag_makepickup() );
    
    /#
        printtoscreen2d( 50, 675, "<dev string:x125>" + self.flagid + "<dev string:x12b>", ( 1, 0, 0 ), 1.5, 200 );
    #/
}

// Namespace namespace_e965e5c30872dcae
// Params 0
// Checksum 0x462dbbd4, Offset: 0x2fef
// Size: 0x3d
function function_3f738cb141106e2f()
{
    if ( self.var_4fb9141feec972cf )
    {
        self.var_4fb9141feec972cf stoploopsound( #"hash_c05bae488cb029c5" );
        self.var_4fb9141feec972cf delete();
        self.var_4fb9141feec972cf = undefined;
    }
}

// Namespace namespace_e965e5c30872dcae
// Params 0
// Checksum 0x96e45642, Offset: 0x3034
// Size: 0x6d
function outline_create()
{
    if ( !player::isreallyalive( self ) )
    {
        return;
    }
    
    outline::_hudoutlineviewmodelenable( "outlinefill_you_sabattack", 0 );
    self.friendlyoutlineid = outline::outlineenableforteam( self, self.team, "outlinefill_friendly_hvt", "level_script", undefined, 1 );
    self.var_e82835bccfbadc6d = outline::outlineenableforteam( self, team_utility::getotherteam( self.team ), "outlinefill_enemy_hvt", "level_script", undefined, 1 );
}

// Namespace namespace_e965e5c30872dcae
// Params 0
// Checksum 0x8e635710, Offset: 0x30a9
// Size: 0x2b
function outline_clear()
{
    outline::outlinedisable( self.friendlyoutlineid, self );
    outline::outlinedisable( self.var_e82835bccfbadc6d, self );
    outline::_hudoutlineviewmodeldisable();
}

// Namespace namespace_e965e5c30872dcae
// Params 1, eflags: 0x4
// Checksum 0xec0ff1fd, Offset: 0x30dc
// Size: 0x95
function private function_21396bf10feb0abc( params )
{
    player = params.streakinfo.owner;
    
    if ( level.flagcarrier == player && killstreak::isremotekillstreak( params.streakinfo.streakname ) )
    {
        if ( params.streakinfo.streakname == "valkyrie_rocket" )
        {
            player waittill( #"valkyrie_fired" );
            player waittill( #"hash_769534f8253e5aa7" );
        }
    }
}

// Namespace namespace_e965e5c30872dcae
// Params 1, eflags: 0x4
// Checksum 0x353476, Offset: 0x3179
// Size: 0xc
function private on_killstreak_finish_use( params )
{
    
}

// Namespace namespace_e965e5c30872dcae
// Params 2
// Checksum 0x744ace4e, Offset: 0x318d
// Size: 0xdd
function securechevrons( target, label )
{
    othervisuals = getentitylessscriptablearray( target, #targetname );
    chevrons = [];
    
    foreach ( visual in othervisuals )
    {
        index = chevrons.size;
        chevrons[ index ] = visual;
        chevrons[ index ].numchevrons = 1;
    }
    
    self.chevrons = chevrons;
    set_chevron_state( "idle" );
}

// Namespace namespace_e965e5c30872dcae
// Params 1
// Checksum 0x4976f9a4, Offset: 0x3272
// Size: 0xff
function set_chevron_state( state )
{
    self notify( #"hash_4b8378ba629fc7e4" );
    self endon( #"hash_4b8378ba629fc7e4" );
    
    while ( !isdefined( self.chevrons ) )
    {
        waitframe();
    }
    
    var_1a5d8528edba5ab0 = "chevron_";
    
    foreach ( chevron in self.chevrons )
    {
        for ( i = 0; i < chevron.numchevrons ; i++ )
        {
            chevron setscriptablepartstate( var_1a5d8528edba5ab0 + i + ( level.gametypebundle.var_45b9f58d54501ba6 ?? "" ), state );
        }
    }
}

// Namespace namespace_e965e5c30872dcae
// Params 1
// Checksum 0xec891aa2, Offset: 0x3379
// Size: 0x4a
function function_bdb4e5985ee57345( flagorigin )
{
    self.offset3d = ( 0, 0, 45 );
    skirmish_util::function_27e85aa699653fa1( "waypoint_secure", undefined, self.objidnum );
    function_ebe709e6217ad62f( self.objidnum, flagorigin );
}

// Namespace namespace_e965e5c30872dcae
// Params 2
// Checksum 0x6233c6e, Offset: 0x33cb
// Size: 0x85
function function_ebe709e6217ad62f( objid, curorigin )
{
    objective_setbackground( objid, 2 );
    function_c97f0baa8ba1ccc6( objid, "sat_ui_hud_skirmish_waypoint_high_value_sector_star_tacmap" );
    objective_setshowprogress( objid, 1 );
    objective_setzoffset( objid, 0 );
    objective_position( objid, curorigin + self.offset3d );
    objective_state( objid, "current" );
    objective_setplayintro( objid, 0 );
    objective_setownerteam( objid, "neutral" );
    function_8eab38514b79538d( objid, getdvarint( @"hash_1e0197370cf88095", 7874 ) );
}

// Namespace namespace_e965e5c30872dcae
// Params 1
// Checksum 0x3953f21b, Offset: 0x3458
// Size: 0x9d
function function_88069276d7b3c58b( player )
{
    self.curorigin = self.origin;
    offset3d = ( 0, 0, 7 );
    gameobjects::setownerteam( player.team );
    skirmish_util::function_27e85aa699653fa1( "waypoint_secure_defend", "waypoint_secure_attack", self.objidnum );
    self.skrflagcarrier function_9e33ffb39931c8d( self.objidnum, offset3d, player );
    objective_pinforclient( self.objidnum, self.skrflagcarrier );
    thread function_c7f73cfe7253bbee();
}

// Namespace namespace_e965e5c30872dcae
// Params 3
// Checksum 0x467c36c2, Offset: 0x34fd
// Size: 0x5c
function function_9e33ffb39931c8d( objid, offset3d, player )
{
    objective_setbackground( objid, 2 );
    objective_position( objid, self geteye() + offset3d );
    objective_state( objid, "current" );
    objective_setplayintro( objid, 0 );
    objective_setownerteam( objid, player.team );
}

// Namespace namespace_e965e5c30872dcae
// Params 0
// Checksum 0x3c3e5951, Offset: 0x3561
// Size: 0xfd
function function_c7f73cfe7253bbee()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self notify( #"hash_be6e93c793773faf" );
    self endon( #"hash_be6e93c793773faf" );
    self endon( #"hash_2ab96b9b977e9d35" );
    
    if ( !isdefined( level.objpingdelay ) )
    {
        level.objpingdelay = 0;
    }
    
    previousupdatetime = gettime();
    
    while ( isdefined( self.skrflagcarrier ) )
    {
        objpos = self.skrflagcarrier geteye() + self.offset3d;
        objidpoolmanager::update_objective_position( self.objidnum, objpos );
        objective_ping( self.objidnum );
        currtime = gettime();
        
        if ( currtime - previousupdatetime >= level.objpingdelay * 1000 )
        {
            objidpoolmanager::update_objective_position( self.objidnum, objpos );
            objective_ping( self.objidnum );
            previousupdatetime = currtime;
        }
        
        waitframe();
    }
}

// Namespace namespace_e965e5c30872dcae
// Params 0
// Checksum 0xb6cf6f2d, Offset: 0x3666
// Size: 0x29
function function_1d607166f4de6f4c()
{
    if ( isdefined( self.objidnum ) )
    {
        objidpoolmanager::returnobjectiveid( self.objidnum );
        self.objidnum = undefined;
    }
}

// Namespace namespace_e965e5c30872dcae
// Params 0, eflags: 0x4
// Checksum 0x3cbeea1, Offset: 0x3697
// Size: 0x230
function private function_3fec787e1e063a4f()
{
    level endon( #"game_ended" );
    self endon( #"hash_2ab96b9b977e9d35" );
    
    if ( level.var_7ef9c9868ae8b25e )
    {
        while ( self.currentnode < self.patrolpath.size - 1 )
        {
            nextnode = getnextnode();
            var_62f45dca84e04d58 = 1 - distance2d( self.origin, nextnode.origin ) / distance2d( self.patrolpath[ self.currentnode ].origin, nextnode.origin );
            var_62f45dca84e04d58 = clamp( var_62f45dca84e04d58, 0, 1 );
            var_9a36202726bf2200 = ( self.currentnode + var_62f45dca84e04d58 ) / ( self.patrolpath.size - 1 );
            var_9a36202726bf2200 = clamp( var_9a36202726bf2200, 0, 1 );
            
            if ( isdefined( self.skrflagcarrier ) && self.skrflagcarrier player::isreallyalive() )
            {
                objidpoolmanager::objective_show_progress( self.objidnum, 1, 0 );
                objidpoolmanager::objective_show_progress( self.objidnum, 1, 0 );
                objidpoolmanager::objective_set_progress( self.objidnum, var_9a36202726bf2200 );
            }
            else if ( isdefined( self.objidnum ) )
            {
                if ( var_9a36202726bf2200 != 0 )
                {
                    objidpoolmanager::objective_show_progress( self.objidnum, 1, 0 );
                    objidpoolmanager::objective_set_progress( self.objidnum, var_9a36202726bf2200 );
                }
            }
            
            waitframe();
        }
        
        return;
    }
    
    sectorcounter = level.var_3a3b9a0af2ceee4 / level.var_296eaddf3f4f7675;
    
    while ( self.var_d339769714fc98ac < sectorcounter )
    {
        currentprogress = clamp( self.var_d339769714fc98ac / sectorcounter, 0, 1 );
        
        if ( isdefined( self.skrflagcarrier ) )
        {
            objidpoolmanager::objective_show_progress( self.objidnum, 1, 0 );
            objidpoolmanager::objective_set_progress( self.objidnum, currentprogress );
        }
        else if ( isdefined( self.objidnum ) )
        {
            objidpoolmanager::objective_show_progress( self.objidnum, 1, 0 );
            objidpoolmanager::objective_set_progress( self.objidnum, currentprogress );
        }
        
        waitframe();
    }
}

// Namespace namespace_e965e5c30872dcae
// Params 1
// Checksum 0xfa5ba941, Offset: 0x38cf
// Size: 0x2d
function function_868bd071bd89616( player )
{
    player setclientomnvar( "ui_skirmishSecureStreak", self.teamprogress[ player.team ] );
}

// Namespace namespace_e965e5c30872dcae
// Params 0
// Checksum 0x1f870231, Offset: 0x3904
// Size: 0xc9
function function_26591dc81efa5fe8()
{
    var_af5944ba8500daa = level.var_85b177faa9935b2a.running[ self.activitytype ][ self.activityname ].activitytrigger.triggerenterents;
    
    if ( !var_af5944ba8500daa )
    {
        return;
    }
    
    foreach ( ent in var_af5944ba8500daa )
    {
        if ( isplayer( ent ) )
        {
            function_868bd071bd89616( ent );
        }
    }
}

/#

    // Namespace namespace_e965e5c30872dcae
    // Params 0
    // Checksum 0x6ef9c0ff, Offset: 0x39d5
    // Size: 0xfa, Type: dev
    function zonedebug()
    {
        level endon( #"game_ended" );
        self endon( #"hash_2ab96b9b977e9d35" );
        
        while ( true )
        {
            cylinder( level.secureinstance[ self.flagid ].origin, level.secureinstance[ self.flagid ].origin + ( 0, 0, 10000 ), level.var_cb87bb6555f6eb52, ( 1, 0, 0 ), 0, 10 );
            cylinder( level.secureinstance[ self.flagid ].origin, level.secureinstance[ self.flagid ].origin + ( 0, 0, 10000 ), level.var_cb87bb6555f6eb52 - 100, ( 1, 1, 0 ), 0, 10 );
            wait 0.01;
        }
    }

    // Namespace namespace_e965e5c30872dcae
    // Params 1
    // Checksum 0xf2b8677e, Offset: 0x3ad7
    // Size: 0xa4, Type: dev
    function flagdebug( flagdroppoint )
    {
        level endon( #"game_ended" );
        self endon( #"hash_2ab96b9b977e9d35" );
        self endon( #"skr_flag_picked_up" );
        self endon( #"skr_flag_reset" );
        flagorigin = flagdroppoint ?? level.secureinstance[ self.flagid ].origin;
        
        while ( true )
        {
            cylinder( flagorigin, flagorigin + ( 0, 0, 60 ), 20, ( 0, 1, 0 ), 0, 10 );
            wait 0.01;
        }
    }

#/

// Namespace namespace_e965e5c30872dcae
// Params 2
// Checksum 0x5215d7ff, Offset: 0x3b83
// Size: 0x15
function function_614baa9a0614b119( secure, player )
{
    
}

// Namespace namespace_e965e5c30872dcae
// Params 2
// Checksum 0x94c7d0cd, Offset: 0x3ba0
// Size: 0x15
function function_c9a15a0921a98c34( secure, player )
{
    
}

// Namespace namespace_e965e5c30872dcae
// Params 2
// Checksum 0x8d3240e8, Offset: 0x3bbd
// Size: 0x15
function function_ab4e0b1bb14ffc51( secure, player )
{
    
}

