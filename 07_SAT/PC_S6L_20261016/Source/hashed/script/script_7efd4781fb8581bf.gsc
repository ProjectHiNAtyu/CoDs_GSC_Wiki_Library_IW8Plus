// script_7efd4781fb8581bf  (hash_7efd4781fb8581bf.gscc) (size: 9976 Bytes / 0x26f8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6bfa9b53 (1811585875)
// size ...... 9976 (0x26f8)
// includes .. 2   (offset: 0x2390)
// strings ... 47  (offset: 0x23a0)
// dev strs .. 14  (offset: 0x2648)
// exports ... 22  (offset: 0x1a00)
// cseg ...... 0x33e + 0x16c2 (0x1a00)
// imports ... 50  (offset: 0x1d70)
// animtree1 . 0   (offset: 0x26f8)
// animtree2 . 0   (offset: 0x26f8)
#using scripts\common\devgui;
#using scripts\common\utility;

#namespace namespace_62b7f420ce3bac05;

// Namespace namespace_62b7f420ce3bac05
// Params 0, eflags: 0x5
// Checksum 0x7d6bd937, Offset: 0x35c
// Size: 0x8a
function private autoexec function_8863d9abf1275e6f()
{
    utility::registersharedfunc( #"aiplanner", #"hash_75beb6489f29aa4e", &function_762ab969628bce83, 1 );
    utility::registersharedfunc( #"aiplanner", #"hash_a069f793edaa185b", &function_c0dd3dced737ded5, 1 );
    utility::registersharedfunc( #"aiplanner", #"hash_7d8a84e33916f544", &function_c0750097b3155a30, 1 );
    utility::registersharedfunc( #"aiplanner", #"hash_1de60ae651af6647", &function_49bb60ecabc12964, 1 );
    level thread function_b7c293ccd527f62e();
}

// Namespace namespace_62b7f420ce3bac05
// Params 0
// Checksum 0xcc733ac8, Offset: 0x3ee
// Size: 0x64
function function_b7c293ccd527f62e()
{
    if ( utility::issp() )
    {
        while ( !isdefined( level.player ) )
        {
            waitframe();
        }
        
        level thread function_3090a16a95f12d04();
    }
    
    if ( utility::ismp() )
    {
        level utility::flag_wait( "onStartGameTypeFinished" );
        level thread function_3090a16a95f12d04();
    }
    
    entries = function_c64ab000988193f4();
    
    if ( entries.size > 0 )
    {
        function_7d5ca2dcecba4c1f( entries );
    }
}

// Namespace namespace_62b7f420ce3bac05
// Params 0
// Checksum 0xbbea036c, Offset: 0x45a
// Size: 0x48
function function_3090a16a95f12d04()
{
    /#
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x3e>", "<dev string:x55>", &function_96cf7cadb6e8fce4, 1 );
        devgui::add_devgui_func( "<dev string:x6a>", "<dev string:x80>", &function_deeaed64de83e335, 1 );
        devgui::function_77df7fe7dd273e10();
    #/
}

// Namespace namespace_62b7f420ce3bac05
// Params 0
// Checksum 0x32f5c7a, Offset: 0x4aa
// Size: 0xb
function function_96cf7cadb6e8fce4()
{
    function_b7c57f6baee6afa0( 1 );
}

// Namespace namespace_62b7f420ce3bac05
// Params 0
// Checksum 0x95b84e51, Offset: 0x4bd
// Size: 0xa
function function_deeaed64de83e335()
{
    function_b7c57f6baee6afa0( 0 );
}

// Namespace namespace_62b7f420ce3bac05
// Params 1
// Checksum 0x8a750a2d, Offset: 0x4cf
// Size: 0x1b4
function function_b7c57f6baee6afa0( toggle )
{
    all_ai_array = getaiarray( "axis", "allies", "neutral" );
    
    if ( all_ai_array.size > 0 )
    {
        squads = [];
        
        foreach ( ai in all_ai_array )
        {
            squadid = function_8398629a6c526ce3( ai );
            
            if ( isdefined( squadid ) )
            {
                squads[ squads.size ] = squadid;
            }
        }
    }
    
    if ( squads.size > 0 )
    {
        if ( toggle )
        {
            foreach ( squad in squads )
            {
                function_16c1558e19baa945( squad, "show" );
            }
            
            return;
        }
        
        foreach ( squad in squads )
        {
            function_16c1558e19baa945( squad, "hide" );
        }
    }
}

// Namespace namespace_62b7f420ce3bac05
// Params 0
// Checksum 0x6d50dcef, Offset: 0x68b
// Size: 0x1d
function function_c0dd3dced737ded5()
{
    planactive = self.var_80c39a64c7a0542f ?? 0;
    return planactive;
}

// Namespace namespace_62b7f420ce3bac05
// Params 0
// Checksum 0xe4b7ac4e, Offset: 0x6b1
// Size: 0x21
function function_c0750097b3155a30()
{
    plan = self.var_46bdb508bb396b63 ?? "no_plan_found";
    return plan;
}

// Namespace namespace_62b7f420ce3bac05
// Params 2
// Checksum 0x7c62cbec, Offset: 0x6db
// Size: 0xca
function function_16c1558e19baa945( squadid, var_1f58d863b28e0922 = "show" )
{
    squadmembers = aigetsquadmembers( squadid );
    
    if ( squadmembers.size > 0 )
    {
        for ( i = 0; i < squadmembers.size ; i++ )
        {
            m = squadmembers[ i ];
            
            if ( isalive( m ) && isai( m ) )
            {
                if ( var_1f58d863b28e0922 == "show" )
                {
                    if ( !m.var_597c2ce6e8b71052 || m.var_597c2ce6e8b71052 == 0 )
                    {
                        m thread function_116c1b7b64587f03( "show" );
                    }
                    
                    continue;
                }
                
                if ( var_1f58d863b28e0922 == "hide" )
                {
                    m thread function_116c1b7b64587f03( "hide" );
                }
            }
        }
    }
}

// Namespace namespace_62b7f420ce3bac05
// Params 1
// Checksum 0x95192e4d, Offset: 0x7ad
// Size: 0x288
function function_116c1b7b64587f03( var_1f58d863b28e0922 )
{
    self endon( #"died" );
    self endon( #"hash_95c389a4ac96e9b6" );
    level endon( #"death_or_disconnect" );
    
    if ( var_1f58d863b28e0922 == "hide" )
    {
        self.var_597c2ce6e8b71052 = 0;
        self notify( #"hash_95c389a4ac96e9b6" );
        return;
    }
    
    if ( var_1f58d863b28e0922 == "show" )
    {
        self.var_597c2ce6e8b71052 = 1;
        
        while ( true )
        {
            info_to_show = [];
            
            if ( self.var_80c39a64c7a0542f == 1 )
            {
                info_to_show[ info_to_show.size ] = "----- CURRENT PLAN INFO -----";
                info_to_show[ info_to_show.size ] = "Current Plan: " + self.var_46bdb508bb396b63;
                info_to_show[ info_to_show.size ] = "Plan Started at : " + self.var_3ff22181f0a22c31;
                var_49fb1db9fc06af31 = gettime() - self.var_3ff22181f0a22c31;
                info_to_show[ info_to_show.size ] = "Time since plan began: " + var_49fb1db9fc06af31;
                info_to_show[ info_to_show.size ] = "";
            }
            
            if ( self.var_e3654728bbccc2e9 )
            {
                info_to_show[ info_to_show.size ] = "----- PREVIOUS PLAN INFO -----";
                info_to_show[ info_to_show.size ] = "Previous Plan: " + self.var_e3654728bbccc2e9;
                info_to_show[ info_to_show.size ] = "Previous Plan Outcome: " + self.var_64420db31bd19536;
                info_to_show[ info_to_show.size ] = "Previous Plan Completed at: " + self.var_d1f9ff4a404fc68c;
                var_71407aa4ee561516 = self.var_857ec3bef1784b5e / 1000;
                info_to_show[ info_to_show.size ] = "Previous Plan Duration: " + self.var_857ec3bef1784b5e + " ms " + var_71407aa4ee561516 + "s";
                var_8912f8051fac9fbd = gettime() - self.var_d1f9ff4a404fc68c;
                var_a2b38b4ddc708a3e = var_8912f8051fac9fbd / 1000;
                info_to_show[ info_to_show.size ] = "Time since Previous Plan Completed: " + var_8912f8051fac9fbd + " ms " + var_a2b38b4ddc708a3e + "s";
            }
            
            if ( info_to_show.size > 0 )
            {
                linedelta = 8;
                starting_line_pos = 40;
                
                for ( i = 0; i < info_to_show.size ; i++ )
                {
                    lineoffset = starting_line_pos + ( i + 1 ) * linedelta;
                    
                    /#
                        print3d( self.origin - ( 0, 0, lineoffset ), info_to_show[ i ], ( 255, 255, 255 ), 1, 0.45, 1, 1 );
                    #/
                }
            }
            else
            {
                /#
                    print3d( self.origin - ( 0, 0, 48 ), "<dev string:x96>", ( 200, 255, 100 ), 1, 0.3, 1, 1 );
                #/
            }
            
            waitframe();
        }
    }
}

// Namespace namespace_62b7f420ce3bac05
// Params 1
// Checksum 0xfc5ff3ac, Offset: 0xa3d
// Size: 0x252
function function_5dcf92b256737f3( bdisplay = 0 )
{
    level endon( #"death_or_disconnect" );
    self endon( #"death" );
    self endon( #"cancel_plan" );
    resultarray = [ "plan_complete", "plan_failed" ];
    result = utility::waittill_any_in_array_return( resultarray );
    self notify( #"planner_finished" );
    self.var_64420db31bd19536 = result;
    self.var_506665ba6d5fab5b = self.var_3ff22181f0a22c31;
    self.var_d1f9ff4a404fc68c = gettime();
    self.var_857ec3bef1784b5e = self.var_d1f9ff4a404fc68c - self.var_506665ba6d5fab5b;
    self.var_de890ec6841b650c = self.var_e6f77a8052580740;
    self.var_e3654728bbccc2e9 = self.var_46bdb508bb396b63;
    self.var_46bdb508bb396b63 = undefined;
    self.var_e6f77a8052580740 = undefined;
    self.var_80c39a64c7a0542f = 0;
    last_plan_id = self.var_de890ec6841b650c;
    var_7bb11d8b08372b74 = [];
    
    if ( self.skitvars )
    {
        for ( i = 0; i < self.skitvars.size ; i++ )
        {
            var_6c1176d67596327b = self.skitvars[ i ].planid ?? undefined;
            
            if ( var_6c1176d67596327b && var_6c1176d67596327b == last_plan_id )
            {
                if ( self.skitvars[ i ].var_89e39ca8d7769234.size > 0 )
                {
                    foreach ( var in self.skitvars[ i ].var_89e39ca8d7769234 )
                    {
                        var_7bb11d8b08372b74[ var_7bb11d8b08372b74.size ] = var;
                    }
                }
            }
        }
    }
    
    if ( var_7bb11d8b08372b74.size > 0 )
    {
        self notify( #"hash_a03124cbb2068c1f", var_7bb11d8b08372b74 );
        waitframe();
        self notify( result );
    }
    else
    {
        self notify( result );
    }
    
    if ( bdisplay )
    {
        thread function_99f6a198cc949732( self.var_e3654728bbccc2e9, result );
    }
}

// Namespace namespace_62b7f420ce3bac05
// Params 2
// Checksum 0xd700a59b, Offset: 0xc97
// Size: 0xd7
function function_99f6a198cc949732( plan, result )
{
    duration = 1000 / getframeduration();
    var_9a39a99f9cb28bb3 = duration * 5;
    resultcolor = result == "plan_complete" ? ( 0, 255, 0 ) : ( 255, 0, 0 );
    
    /#
        print3d( self.origin + ( 0, 0, 90 ), "<dev string:xa9>", resultcolor, 1, 0.5, int( var_9a39a99f9cb28bb3 ), 1 );
    #/
    
    /#
        print3d( self.origin + ( 0, 0, 80 ), "<dev string:xbb>" + result, resultcolor, 1, 0.5, int( var_9a39a99f9cb28bb3 ), 1 );
    #/
}

// Namespace namespace_62b7f420ce3bac05
// Params 1
// Checksum 0x19e7e865, Offset: 0xd76
// Size: 0x132
function function_49bb60ecabc12964( squadid )
{
    squadmembers = aigetsquadmembers( squadid );
    
    foreach ( guy in squadmembers )
    {
        if ( !isdefined( self.var_64420db31bd19536 ) )
        {
            self.var_64420db31bd19536 = "cancelled";
        }
        
        self.var_506665ba6d5fab5b = self.var_3ff22181f0a22c31 ?? gettime();
        self.var_d1f9ff4a404fc68c = gettime();
        self.var_857ec3bef1784b5e = self.var_d1f9ff4a404fc68c - self.var_506665ba6d5fab5b;
        self.var_de890ec6841b650c = self.var_e6f77a8052580740 ?? undefined;
        self.var_e3654728bbccc2e9 = self.var_46bdb508bb396b63 ?? undefined;
        self.var_46bdb508bb396b63 = undefined;
        self.var_e6f77a8052580740 = undefined;
        self.var_80c39a64c7a0542f = 0;
    }
    
    function_abcedea98b0ac426( squadid );
}

// Namespace namespace_62b7f420ce3bac05
// Params 4
// Checksum 0x65d59f00, Offset: 0xeb0
// Size: 0x171
function function_762ab969628bce83( planname, squadid, dictionary, showdebug = 0 )
{
    squadmembers = aigetsquadmembers( squadid );
    
    foreach ( guy in squadmembers )
    {
        if ( showdebug )
        {
            guy thread function_44c9f07d7d61e200( planname );
        }
        
        guy thread function_5dcf92b256737f3();
    }
    
    thread function_9c8748f5d099c17e( planname, squadid, dictionary );
    
    for ( i = 0; i < squadmembers.size ; i++ )
    {
        member = squadmembers[ i ];
        
        if ( member.var_46bdb508bb396b63 )
        {
            member.var_e3654728bbccc2e9 = member.var_46bdb508bb396b63;
        }
        
        if ( !isdefined( member.var_e3654728bbccc2e9 ) )
        {
            member.var_e3654728bbccc2e9 = planname;
        }
        
        member.var_46bdb508bb396b63 = planname;
        member.var_80c39a64c7a0542f = 1;
        member.var_3ff22181f0a22c31 = gettime();
        member.var_e6f77a8052580740 = function_12feb19c70cef19b( squadid );
    }
}

// Namespace namespace_62b7f420ce3bac05
// Params 3
// Checksum 0xd8d58332, Offset: 0x1029
// Size: 0xe7
function function_9c8748f5d099c17e( planname, squadid, dictionary )
{
    members = aigetsquadmembers( squadid );
    
    foreach ( ai in members )
    {
        ai notify( #"plan_started" );
    }
    
    if ( isdefined( dictionary ) && dictionary.size > 0 )
    {
        if ( isdefined( dictionary[ 0 ] ) )
        {
            dictionary = function_a563fc8c652c59ef( dictionary );
        }
        
        function_666d01878e98cc97( "htn:" + planname, squadid, dictionary );
        return;
    }
    
    function_666d01878e98cc97( "htn:" + planname, squadid, [] );
}

// Namespace namespace_62b7f420ce3bac05
// Params 2
// Checksum 0x387d6c87, Offset: 0x1118
// Size: 0x36
function function_630434bccf308ae7( planname, dictionary )
{
    queryworldobjectkeys = [];
    function_1ac5ea83943c78a0( planname, queryworldobjectkeys );
    function_6ef2443a752d94fb( queryworldobjectkeys, dictionary );
}

// Namespace namespace_62b7f420ce3bac05
// Params 2
// Checksum 0xf177af57, Offset: 0x1156
// Size: 0x1c0
function function_1ac5ea83943c78a0( planname, keys )
{
    scriptbundle = getscriptbundle( "htn:" + planname );
    
    foreach ( method in scriptbundle.root.methods )
    {
        if ( isdefined( method.subtasks ) && method.subtasks.size > 0 )
        {
            foreach ( subtask in method.subtasks )
            {
                if ( isdefined( subtask.variant_object ) && isdefined( subtask.variant_object.asset ) )
                {
                    function_1ac5ea83943c78a0( subtask.variant_object.asset, keys );
                }
                
                if ( subtask.variant_type == "Types_QueryWorldObject" )
                {
                    keys[ subtask.variant_object.targetname ] = subtask.variant_object.targetname;
                }
            }
        }
    }
}

// Namespace namespace_62b7f420ce3bac05
// Params 2
// Checksum 0x6794e869, Offset: 0x131e
// Size: 0x145
function function_6ef2443a752d94fb( targetnamekeys, table = [] )
{
    foreach ( targetnamekey in targetnamekeys )
    {
        entries = level.struct_class_names[ "targetname" ][ targetnamekey ];
        
        if ( !entries.size )
        {
            continue;
        }
        
        index = 0;
        
        foreach ( ent in entries )
        {
            table[ table.size ] = targetnamekey + "_" + index;
            table[ table.size ] = ent.origin;
            index++;
        }
    }
    
    return table;
}

// Namespace namespace_62b7f420ce3bac05
// Params 1
// Checksum 0x4e49d17c, Offset: 0x146c
// Size: 0x365
function function_c64ab000988193f4( entries = [] )
{
    radiant_structs = level.struct_class_names[ "script_noteworthy" ][ "ai_planner_script_struct" ];
    
    if ( !radiant_structs )
    {
        return entries;
    }
    
    foreach ( ent in radiant_structs )
    {
        entry = [];
        entry[ "origin" ] = ent.origin;
        entry[ "scriptStructSearchType" ] = ent.scriptStructSearchType;
        conditions = strtok( ent.script_conditions ?? "", "," );
        conditionindex = 0;
        
        foreach ( condition in conditions )
        {
            conditionparts = strtok( condition, "|" );
            
            if ( conditionparts.size == 4 )
            {
                prefix = "_condition_" + conditionindex + "_";
                entry[ prefix + "name" ] = conditionparts[ 0 ];
                entry[ prefix + "type" ] = conditionparts[ 1 ];
                entry[ prefix + "value" ] = conditionparts[ 2 ];
                entry[ prefix + "comparisonType" ] = conditionparts[ 3 ];
                conditionindex++;
                continue;
            }
            
            assertmsg( "<dev string:xc4>" + ent.origin + "<dev string:xf0>" + condition + "<dev string:x13c>" );
        }
        
        entry[ "conditionCount" ] = conditionindex;
        effects = strtok( ent.script_effects ?? "", "," );
        effectindex = 0;
        
        foreach ( effect in effects )
        {
            effectparts = strtok( effect, "|" );
            
            if ( effectparts.size == 4 )
            {
                prefix = "_effect_" + effectindex + "_";
                entry[ prefix + "name" ] = effectparts[ 0 ];
                entry[ prefix + "type" ] = effectparts[ 1 ];
                entry[ prefix + "value" ] = effectparts[ 2 ];
                entry[ prefix + "comparisonType" ] = effectparts[ 3 ];
                effectindex++;
                continue;
            }
            
            assertmsg( "<dev string:x13e>" + ent.origin + "<dev string:xf0>" + effect + "<dev string:x13c>" );
        }
        
        entry[ "effectCount" ] = effectindex;
        entries[ entries.size ] = entry;
    }
    
    return entries;
}

// Namespace namespace_62b7f420ce3bac05
// Params 1
// Checksum 0x9749d30d, Offset: 0x17da
// Size: 0xef
function function_44c9f07d7d61e200( planname )
{
    self endon( #"died" );
    showtime = 5000;
    time = getframeduration();
    showtime_frames = showtime / time;
    showtime_frames = int( showtime_frames );
    
    while ( true )
    {
        self waittill( #"plan_started" );
        
        /#
            print3d( self.origin + ( 0, 0, 100 ), "<dev string:x167>" + planname, ( 255, 255, 255 ), 1, 0.5, showtime_frames, 1 );
        #/
        
        utility::waittill_any( "plan_complete", "plan_failed" );
        
        /#
            print3d( self.origin + ( 0, 0, 70 ), "<dev string:x176>" + planname, ( 255, 255, 255 ), 1, 0.5, showtime_frames, 1 );
        #/
    }
}

// Namespace namespace_62b7f420ce3bac05
// Params 1
// Checksum 0x17e459c5, Offset: 0x18d1
// Size: 0x12e
function function_a563fc8c652c59ef( var_fd4487362afe0834 )
{
    var_b4dbb6a8e589523b = [];
    i = 0;
    
    while ( i < var_fd4487362afe0834.size )
    {
        assert( isdefined( var_fd4487362afe0834[ i + 1 ] ) );
        datatype = undefined;
        
        if ( var_fd4487362afe0834[ i + 1 ] === "boolTrue" )
        {
            datatype = "boolTrue";
        }
        else if ( var_fd4487362afe0834[ i + 1 ] === "boolFalse" )
        {
            datatype = "boolFalse";
        }
        else if ( isstring( var_fd4487362afe0834[ i + 1 ] ) )
        {
            datatype = "string";
        }
        else if ( isint( var_fd4487362afe0834[ i + 1 ] ) )
        {
            datatype = "int";
        }
        else if ( isvector( var_fd4487362afe0834[ i + 1 ] ) )
        {
            datatype = "vector";
        }
        
        if ( datatype == "boolTrue" )
        {
            var_b4dbb6a8e589523b[ var_fd4487362afe0834[ i ] ] = [ "bool", 1 ];
        }
        else if ( datatype == "boolFalse" )
        {
            var_b4dbb6a8e589523b[ var_fd4487362afe0834[ i ] ] = [ "bool", 0 ];
        }
        else
        {
            var_b4dbb6a8e589523b[ var_fd4487362afe0834[ i ] ] = [ datatype, var_fd4487362afe0834[ i + 1 ] ];
        }
        
        i += 2;
    }
    
    return var_b4dbb6a8e589523b;
}

