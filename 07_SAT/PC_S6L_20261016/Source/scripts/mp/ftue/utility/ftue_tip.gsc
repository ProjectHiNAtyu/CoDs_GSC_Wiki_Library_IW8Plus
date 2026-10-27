// scripts\mp\ftue\utility\ftue_tip.gsc  (hash_32d93a194074fa6a.gscc) (size: 7867 Bytes / 0x1ebb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfa0efa0c (4195285516)
// size ...... 7867 (0x1ebb)
// includes .. 2   (offset: 0x1d47)
// strings ... 21  (offset: 0x1d57)
// dev strs .. 6   (offset: 0x1e73)
// exports ... 33  (offset: 0x1283)
// cseg ...... 0x19f + 0x10e4 (0x1283)
// imports ... 48  (offset: 0x17ab)
// animtree1 . 0   (offset: 0x1ebb)
// animtree2 . 0   (offset: 0x1ebb)
#using scripts\common\telemetry_utils;
#using scripts\mp\ftue\utility\ftue_progress;

#namespace ftue_tip;

// Namespace ftue_tip
// Params 1
// Checksum 0x8046d361, Offset: 0x1bd
// Size: 0x36
function ftue_tip_init( var_3b581115eee4dfcc )
{
    if ( ftue_progress::ftue_enabled() )
    {
        ftuetips_list_bundle = getscriptbundle( var_3b581115eee4dfcc );
        
        if ( isdefined( ftuetips_list_bundle ) )
        {
            function_75cd26b36c26deb9( ftuetips_list_bundle );
        }
    }
}

// Namespace ftue_tip
// Params 1
// Checksum 0x91705fde, Offset: 0x1fb
// Size: 0x62, Type: bool
function function_197c6dbd7e501a20( var_6091cbcfc07a37d1 )
{
    var_8260aba025c68d4 = [];
    var_8260aba025c68d4[ "ALL" ] = -1;
    var_8260aba025c68d4[ "NONE" ] = 0;
    var_8260aba025c68d4[ "LOW" ] = 1;
    var_8260aba025c68d4[ "MID" ] = 2;
    var_8260aba025c68d4[ "HIGH" ] = 3;
    var_8260aba025c68d4[ "EXPERT" ] = 4;
    return var_8260aba025c68d4[ var_6091cbcfc07a37d1 ] ?? var_8260aba025c68d4[ "ALL" ];
}

// Namespace ftue_tip
// Params 1
// Checksum 0x28fe08a1, Offset: 0x266
// Size: 0x59, Type: bool
function function_1c01fc6e2467944e( var_ed6077b03f130d99 )
{
    var_3ddbf71141ca67dc = [];
    var_3ddbf71141ca67dc[ "LOW" ] = 10;
    var_3ddbf71141ca67dc[ "MED" ] = 20;
    var_3ddbf71141ca67dc[ "HIGH" ] = 30;
    var_3ddbf71141ca67dc[ "HIGHEST" ] = 40;
    var_3ddbf71141ca67dc[ "TOP" ] = 60;
    return var_3ddbf71141ca67dc[ var_ed6077b03f130d99 ] ?? var_3ddbf71141ca67dc[ "LOW" ];
}

// Namespace ftue_tip
// Params 0
// Checksum 0xbaf60c66, Offset: 0x2c8
// Size: 0x17
function ftue_tip_initplayer()
{
    self.ftue_tipdata = spawnstruct();
    function_55ac6801568cdf99( 0 );
}

// Namespace ftue_tip
// Params 1, eflags: 0x4
// Checksum 0x9397a4a4, Offset: 0x2e7
// Size: 0x10b
function private function_75cd26b36c26deb9( list_bundle )
{
    level.ftuetips_table = [];
    level.ftuetips_lookup = [];
    index = 1;
    
    foreach ( bundle in list_bundle.ftuetips_list )
    {
        ftuetip_ref = bundle.ref;
        
        if ( isdefined( ftuetip_ref ) )
        {
            tip = spawnstruct();
            tip.id = index;
            tip.bundle = bundle.bundle;
            level.ftuetips_table[ ftuetip_ref ] = tip;
            level.ftuetips_lookup[ index ] = ftuetip_ref;
        }
        
        index++;
    }
}

// Namespace ftue_tip
// Params 0
// Checksum 0x3b158dfd, Offset: 0x3fa
// Size: 0x19, Type: bool
function function_bb643ddeb2f6e3fc()
{
    assert( isplayer( self ) );
    return istrue( self.ftuetips_enabled );
}

// Namespace ftue_tip
// Params 2
// Checksum 0x8e79c530, Offset: 0x41c
// Size: 0x97
function function_c9cca7ed21647155( ref, params = spawnstruct() )
{
    if ( !isdefined( level.ftuetips_table ) )
    {
        return;
    }
    
    assert( isplayer( self ) );
    
    if ( params.sound )
    {
        self playlocalsound( "uin_tip_appearance" );
    }
    
    if ( isdefined( params.waittimeoverride ) )
    {
        self.waittimeoverride = params.waittimeoverride;
    }
    
    function_64f14e3754f5b3d3( ref, params.callback, params.duration );
}

// Namespace ftue_tip
// Params 2
// Checksum 0x60e50014, Offset: 0x4bb
// Size: 0x103
function function_c2198fe46a43aff8( tipindex, data )
{
    if ( !ftue_progress::ftue_enabled() )
    {
        return;
    }
    
    assert( isint( tipindex ) && tipindex >= 0 && tipindex < 100, "<dev string:x24>" + tipindex );
    keyhash = getxhash( data.key );
    level.var_a0091bd8bb5fd717 = level.var_a0091bd8bb5fd717 ?? {};
    level.var_a0091bd8bb5fd717.contextualtips = level.var_a0091bd8bb5fd717.contextualtips ?? [];
    level.var_13483806c100ad3e = level.var_13483806c100ad3e ?? [];
    level.var_2e3590a0be8bd1ef = level.var_2e3590a0be8bd1ef ?? [];
    level.var_a0091bd8bb5fd717.contextualtips[ keyhash ] = data;
    level.var_13483806c100ad3e[ tipindex ] = keyhash;
    level.var_2e3590a0be8bd1ef[ keyhash ] = tipindex;
}

// Namespace ftue_tip
// Params 8
// Checksum 0x19424246, Offset: 0x5c6
// Size: 0xf6
function function_d454ba9425f5164c( tipid, key, condfunc, execfunc, var_887f369888f42d5b, priority, notificationid, inprematch )
{
    data = { #inprematch:inprematch ?? 0, #notificationid:notificationid ?? "currentContextualTipCompleted", #execfunc:execfunc ?? &function_517f769824070ef6, #condfunc:condfunc ?? &function_60a29644e3a7c4, #priority:priority ?? 30, #var_887f369888f42d5b:var_887f369888f42d5b ?? [ 0, 1, 2, 3 ], #key:key, #id:tipid };
    function_c2198fe46a43aff8( tipid, data );
}

// Namespace ftue_tip
// Params 4
// Checksum 0x8ac28b92, Offset: 0x6c4
// Size: 0x1e6
function function_71074e02901b1265( var_9abe56897693a283, var_2569bbde753d6277, condfunc, execfunc )
{
    var_887f369888f42d5b = [];
    
    foreach ( expertise in var_2569bbde753d6277.var_887f369888f42d5b )
    {
        var_887f369888f42d5b[ var_887f369888f42d5b.size ] = function_197c6dbd7e501a20( expertise.playerexpertise );
    }
    
    if ( var_887f369888f42d5b.size == 0 )
    {
        var_887f369888f42d5b = [ 0, 1, 2, 3 ];
    }
    
    var_dd8cecd01ff5f6a2 = { #conditionalsteps:var_2569bbde753d6277.conditionalsteps, #tipskey:var_9abe56897693a283 };
    data = { #inprematch:var_2569bbde753d6277.inprematch ?? 0, #notificationid:var_2569bbde753d6277.autocomplete ? "currentContextualTipCompleted" : "currentContextualTipAborted", #execfunc:execfunc ?? &function_517f769824070ef6, #var_dd8cecd01ff5f6a2:var_dd8cecd01ff5f6a2, #condfunc:&function_f246c5e69ecaf1b0, #priority:function_1c01fc6e2467944e( var_2569bbde753d6277.priority ), #var_887f369888f42d5b:var_887f369888f42d5b, #key:var_9abe56897693a283, #id:var_2569bbde753d6277.id };
    function_be701115362b5193( var_9abe56897693a283, var_2569bbde753d6277.initsteps );
    function_c2198fe46a43aff8( var_2569bbde753d6277.id, data );
}

// Namespace ftue_tip
// Params 2
// Checksum 0x9ab074c0, Offset: 0x8b2
// Size: 0x1ca
function function_be701115362b5193( tipskey, initsteps )
{
    level.var_11133cb0607b498f = level.var_11133cb0607b498f ?? {};
    level.var_11133cb0607b498f.var_3128982b9edb0001 = level.var_11133cb0607b498f.var_3128982b9edb0001 ?? [];
    level.var_11133cb0607b498f.var_3128982b9edb0001[ tipskey ] = [];
    var_81b93d3cf5844830 = level.var_11133cb0607b498f.var_3128982b9edb0001[ tipskey ];
    
    foreach ( step in initsteps )
    {
        params = { #var_9b3000a2f37ff90f:step.var_7aab10ae09d48477 == "int" ? step.var_cc9063caae1fe580 : step.var_f6ae8e62fc3b476b, #datakey:step.datakey, #callbacktype:step.callbacktype, #callbackname:step.callbackname, #tipskey:tipskey };
        var_81b93d3cf5844830[ step.datakey ] = step.var_7aab10ae09d48477 == "int" ? 0 : 0;
        [[ level.var_11133cb0607b498f.var_7df46f7e792a7ed[ step.initfunctions ] ]]( params );
    }
}

// Namespace ftue_tip
// Params 1
// Checksum 0xa99ac4c0, Offset: 0xa84
// Size: 0x178, Type: bool
function function_f246c5e69ecaf1b0( var_dd8cecd01ff5f6a2 )
{
    tipskey = var_dd8cecd01ff5f6a2.tipskey;
    
    foreach ( step in var_dd8cecd01ff5f6a2.conditionalsteps )
    {
        params = { #var_dec8a38453275dcb:step.loots, #var_9b3000a2f37ff90f:step.var_7aab10ae09d48477 == "int" ? step.var_cc9063caae1fe580 : step.var_f6ae8e62fc3b476b, #datakey:step.datakey, #tipskey:tipskey };
        result = [[ level.var_11133cb0607b498f.var_676d11a91d9e3069[ step.conditionalfunction ] ]]( params );
        
        if ( result && step.var_ce8d07aa49877c45 )
        {
            ftue_progress::function_d00c0941d634466b( level.var_2e3590a0be8bd1ef[ tipskey ] );
            continue;
        }
        
        if ( !result && !step.var_ce8d07aa49877c45 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace ftue_tip
// Params 1
// Checksum 0x5e1de488, Offset: 0xc05
// Size: 0xe, Type: bool
function function_60a29644e3a7c4( params )
{
    return true;
}

// Namespace ftue_tip
// Params 2
// Checksum 0x757df9ce, Offset: 0xc1c
// Size: 0x24
function function_517f769824070ef6( tipid, notificationid )
{
    function_c9cca7ed21647155( tipid );
    waitframe();
    self notify( notificationid );
}

// Namespace ftue_tip
// Params 3, eflags: 0x4
// Checksum 0x73e7756d, Offset: 0xc48
// Size: 0x91
function private function_64f14e3754f5b3d3( ref, callback, duration )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    ftuetip_id = function_9cc52f74c008f3f7( ref );
    
    if ( !isdefined( ftuetip_id ) )
    {
        assertmsg( "<dev string:x50>" + ref + "<dev string:x7d>" );
        return;
    }
    
    function_55ac6801568cdf99( ftuetip_id );
    self setftuetipid( ftuetip_id );
    thread function_a96df8f20bd6b51a( ref, 0 );
    self notify( #"newtip" );
    
    if ( isdefined( duration ) )
    {
        wait duration;
        function_953a5a3682bc5957();
    }
}

// Namespace ftue_tip
// Params 3
// Checksum 0x82dc66e7, Offset: 0xce1
// Size: 0x10f
function function_84dafc5c5a3f97ff( ref, issucceed, params )
{
    if ( !isdefined( ref ) )
    {
        assertmsg( "<dev string:xad>" + ref + "<dev string:xd5>" + level.ftuetips_table );
        return;
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !isdefined( params ) )
    {
        params = spawnstruct();
    }
    
    if ( !function_a23b3ba313ea096() )
    {
        function_c9cca7ed21647155( ref );
        ftue_tip_wait( 1, params.duration );
    }
    
    if ( params.sound )
    {
        sound = "uin_tip_complete";
        
        if ( !issucceed )
        {
            sound = "uin_tip_failed";
        }
        
        self playlocalsound( sound );
    }
    
    function_ab381037b06a31b2( ref, issucceed );
    result = "SUCCESS";
    
    if ( !issucceed )
    {
        result = "FAILED";
    }
    
    thread function_a96df8f20bd6b51a( ref, 1, result );
    ftue_tip_wait( 0.8, params.duration );
    function_953a5a3682bc5957( params.duration );
}

// Namespace ftue_tip
// Params 2
// Checksum 0xd45b32b5, Offset: 0xdf8
// Size: 0x57
function function_e1b6c8c6f8f3dc45( issucceeded, params )
{
    tipid = function_18b4e3afc3869bc5();
    
    if ( tipid == 0 )
    {
        return;
    }
    
    tipref = function_43d52df2874e8a0( tipid );
    assert( isdefined( tipref ) );
    function_84dafc5c5a3f97ff( tipref, issucceeded, params );
}

// Namespace ftue_tip
// Params 2
// Checksum 0x29e5f23f, Offset: 0xe57
// Size: 0x42
function function_ab381037b06a31b2( ref, issucceed )
{
    if ( !isdefined( level.ftuetips_table ) )
    {
        return;
    }
    
    assert( isplayer( self ) );
    function_ef5b05e5d4c2490e( ref, function_dd08872ebcb290a0( issucceed ) );
}

// Namespace ftue_tip
// Params 2, eflags: 0x4
// Checksum 0x4dda2235, Offset: 0xea1
// Size: 0x27
function private function_ef5b05e5d4c2490e( ref, newstate )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    self setftuetipstate( newstate );
}

// Namespace ftue_tip
// Params 1, eflags: 0x4
// Checksum 0x3de01c43, Offset: 0xed0
// Size: 0x31
function private function_dd08872ebcb290a0( issucceed )
{
    newstate = 0;
    
    if ( isdefined( issucceed ) )
    {
        if ( issucceed )
        {
            newstate = 1;
        }
        else
        {
            newstate = 2;
        }
    }
    
    return newstate;
}

// Namespace ftue_tip
// Params 1
// Checksum 0x8b9add0b, Offset: 0xf0a
// Size: 0x28
function function_953a5a3682bc5957( overridewaittime )
{
    function_55ac6801568cdf99( 0 );
    self clearftuetip();
    ftue_tip_wait( 0.5, overridewaittime );
}

// Namespace ftue_tip
// Params 2, eflags: 0x4
// Checksum 0xae1cbc5b, Offset: 0xf3a
// Size: 0x37
function private ftue_tip_wait( defaultwaittime, overridewaittime )
{
    waittime = defaultwaittime;
    
    if ( isdefined( overridewaittime ) )
    {
        waittime = overridewaittime;
    }
    
    if ( waittime > 0 )
    {
        wait waittime;
    }
}

// Namespace ftue_tip
// Params 1
// Checksum 0x1270a3e4, Offset: 0xf79
// Size: 0x1b
function function_817c1ed230cb866c( callback )
{
    if ( isdefined( callback ) )
    {
        thread function_4555cd2d3c58f035( callback );
    }
}

// Namespace ftue_tip
// Params 1, eflags: 0x4
// Checksum 0x2e14490f, Offset: 0xf9c
// Size: 0x9e
function private function_4555cd2d3c58f035( callback )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( !isdefined( self.ftue_tipdata ) )
    {
        return;
    }
    
    if ( !isdefined( callback ) )
    {
        return;
    }
    
    while ( true )
    {
        self waittill( #"luinotifyserver", event, value );
        
        if ( event == "ftuetip_completed" )
        {
            if ( value == function_18b4e3afc3869bc5() )
            {
                tipref = function_43d52df2874e8a0( value );
                
                if ( isdefined( tipref ) )
                {
                    self [[ callback ]]( tipref );
                    return;
                }
            }
        }
    }
}

// Namespace ftue_tip
// Params 1, eflags: 0x4
// Checksum 0xd0ae1d84, Offset: 0x1042
// Size: 0x18
function private function_43d52df2874e8a0( index )
{
    return level.ftuetips_lookup[ index ];
}

// Namespace ftue_tip
// Params 1, eflags: 0x4
// Checksum 0xc64e04a2, Offset: 0x1063
// Size: 0x30
function private function_9cc52f74c008f3f7( tip_ref )
{
    id = level.ftuetips_table[ tip_ref ].id;
    return id;
}

// Namespace ftue_tip
// Params 1
// Checksum 0x13c7a5e5, Offset: 0x109c
// Size: 0x30
function function_cd5fd90805a9ca0c( tip_ref )
{
    id = level.ftuetips_table[ tip_ref ].bundle;
    return id;
}

// Namespace ftue_tip
// Params 0, eflags: 0x4
// Checksum 0x2f77fb65, Offset: 0x10d5
// Size: 0x17, Type: bool
function private function_a23b3ba313ea096()
{
    return self.ftue_tipdata.ftuetipid != 0;
}

// Namespace ftue_tip
// Params 0, eflags: 0x4
// Checksum 0x9926c98, Offset: 0x10f5
// Size: 0x15
function private function_18b4e3afc3869bc5()
{
    return self.ftue_tipdata.ftuetipid;
}

// Namespace ftue_tip
// Params 1, eflags: 0x4
// Checksum 0x2c99e793, Offset: 0x1113
// Size: 0x22
function private function_55ac6801568cdf99( newid )
{
    self.ftue_tipdata.ftuetipid = newid;
}

// Namespace ftue_tip
// Params 3, eflags: 0x4
// Checksum 0x600c3fc9, Offset: 0x113d
// Size: 0x126
function private function_a96df8f20bd6b51a( ref, finished, result )
{
    tipid = function_cd5fd90805a9ca0c( ref );
    telemetrykeys = [ #"stepname", #"stepnumber", #"issingle", #"ismandatory", #"isautomatic" ];
    telemetrydata = getscriptbundlefieldvalues( hashcat( %"hash_6b016976aff9ae9f", tipid ), telemetrykeys );
    assert( isdefined( telemetrydata ), "<dev string:xf1>" + tipid );
    
    if ( !function_e8ca6a3a523ace55( telemetrydata ) )
    {
        return;
    }
    
    telemetrydata.player = self;
    callback = "mobile_ftue_step_start";
    
    if ( telemetrydata.issingle )
    {
        telemetrydata.result = "SUCCESS";
        callback = "mobile_ftue_step_single";
    }
    else if ( finished )
    {
        telemetrydata.result = result;
        callback = "mobile_ftue_step_finished";
    }
    
    telemetry_utils::function_af2d366f9522f76f( callback, telemetrydata );
}

// Namespace ftue_tip
// Params 1, eflags: 0x4
// Checksum 0x81b53683, Offset: 0x126b
// Size: 0x17
function private function_e8ca6a3a523ace55( telemetrydata )
{
    return telemetrydata.stepname;
}

