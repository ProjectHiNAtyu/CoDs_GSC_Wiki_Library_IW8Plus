// script_1b6226c923babd4a  (hash_1b6226c923babd4a.gscc) (size: 6603 Bytes / 0x19cb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3dc01da9 (1036000681)
// size ...... 6603 (0x19cb)
// includes .. 4   (offset: 0x1827)
// strings ... 12  (offset: 0x1847)
// dev strs .. 16  (offset: 0x18d7)
// exports ... 16  (offset: 0x11a7)
// cseg ...... 0x1b3 + 0xff4 (0x11a7)
// imports ... 34  (offset: 0x1427)
// animtree1 . 0   (offset: 0x19cb)
// animtree2 . 0   (offset: 0x19cb)
#using script_44280f644740bac;
#using scripts\common\utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\gametypes\frune_checkpoints;

#namespace namespace_1cac7a6a80266fcc;

// Namespace namespace_1cac7a6a80266fcc
// Params 0
// Checksum 0xc94116a6, Offset: 0x1d1
// Size: 0x3c2
function init()
{
    level endon( #"game_ended" );
    utility::flag_wait( "scriptables_ready" );
    modeinfo = game[ #"frune_tuning" ];
    modeinfo.var_959c1669e73471ab = {};
    modeinfo.var_959c1669e73471ab.var_d62576017c9dee6 = getdvarfloat( @"hash_d07c2a8a987b7f27", modeinfo.frune_bundle.var_3258fb8fb97b3634 ?? 1 );
    modeinfo.var_959c1669e73471ab.var_7808919dab0f2904 = [ 10:"ui_free_run_race_display_10", 9:"ui_free_run_race_display_09", 8:"ui_free_run_race_display_08", 7:"ui_free_run_race_display_07", 6:"ui_free_run_race_display_06", "ui_free_run_race_display_05", 4:"ui_free_run_race_display_04", 3:"ui_free_run_race_display_03", 2:"ui_free_run_race_display_02", 1:"ui_free_run_race_display_01" ];
    modeinfo.var_959c1669e73471ab.var_ea180186d55694ae = [ 10:#"hash_54cabc50eda0ab2f", 9:#"hash_54c73f50ed9da0f1", 8:#"hash_54c73e50ed9d9f3e", 7:#"hash_54c73950ed9d96bf", 6:#"hash_54c73850ed9d950c", #"hash_54c73b50ed9d9a25", 4:#"hash_54c73a50ed9d9872", 3:#"hash_54c73550ed9d8ff3", 2:#"hash_54c73450ed9d8e40", 1:#"hash_54c73750ed9d9359" ];
    function_85d94fa24a917ac2();
    
    /#
        helptext = "<dev string:x24>";
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"fre" ][ #"registercommand" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( "<dev string:x42>", "<dev string:x4f>", &function_240fd8f26de8cce9, helptext, "<dev string:x53>", [ 0 ] );
        }
        
        helptext = "<dev string:x5f>";
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"fre" ][ #"registercommand" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( "<dev string:x7e>", "<dev string:x4f>", &function_240fd8f26de8cce9, helptext, "<dev string:x53>", [ 0.25 ] );
        }
        
        helptext = "<dev string:x8c>";
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"fre" ][ #"registercommand" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( "<dev string:xab>", "<dev string:x4f>", &function_240fd8f26de8cce9, helptext, "<dev string:x53>", [ 0.5 ] );
        }
        
        helptext = "<dev string:xb9>";
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"fre" ][ #"registercommand" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( "<dev string:xd8>", "<dev string:x4f>", &function_240fd8f26de8cce9, helptext, "<dev string:x53>", [ 0.75 ] );
        }
        
        helptext = "<dev string:xe6>";
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"fre" ][ #"registercommand" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( "<dev string:x106>", "<dev string:x4f>", &function_240fd8f26de8cce9, helptext, "<dev string:x53>", [ 1 ] );
        }
        
        helptext = "<dev string:x115>";
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"fre" ][ #"registercommand" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( "<dev string:x163>", "<dev string:x4f>", &function_ae056d66a7387f83, helptext, "<dev string:x53>", undefined );
        }
        
        helptext = "<dev string:x178>";
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"fre" ][ #"registercommand" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( "<dev string:x1a1>", "<dev string:x4f>", &function_6182053aed2aadf2, helptext, "<dev string:x53>", undefined );
        }
    #/
    
    level thread function_c97c8f5679a81135();
}

// Namespace namespace_1cac7a6a80266fcc
// Params 0, eflags: 0x4
// Checksum 0x9d5056f3, Offset: 0x59b
// Size: 0x13a
function private function_85d94fa24a917ac2()
{
    modeinfo = game[ #"frune_tuning" ];
    modeinfo.var_959c1669e73471ab.racedisplays = [];
    rawdisplays = getentarray( "race_display", #script_noteworthy );
    
    foreach ( display in rawdisplays )
    {
        display.var_917385c5e4a38af8 = int( display.targetname );
        displaypart = modeinfo.var_959c1669e73471ab.var_ea180186d55694ae[ display.var_917385c5e4a38af8 ];
        display setscriptablepartstate( #"race_display_meter", displaypart );
        modeinfo.var_959c1669e73471ab.racedisplays[ modeinfo.var_959c1669e73471ab.racedisplays.size ] = display;
    }
}

// Namespace namespace_1cac7a6a80266fcc
// Params 0, eflags: 0xc
// Checksum 0xc32f6a20, Offset: 0x6dd
// Size: 0x94
function private function_c97c8f5679a81135()
{
    self notify( #"hash_e58cfe864b7905c4" );
    self endon( #"hash_e58cfe864b7905c4" );
    level endon( #"game_ended" );
    modeinfo = game[ #"frune_tuning" ];
    var_d62576017c9dee6 = modeinfo.var_959c1669e73471ab.var_d62576017c9dee6;
    
    while ( true )
    {
        /#
            if ( modeinfo.var_959c1669e73471ab.var_8eafd12dc13edffb )
            {
                waitframe();
                continue;
            }
        #/
        
        function_78c33980e6ad7fa7();
        function_26a2a4606ac74951();
        wait var_d62576017c9dee6;
    }
}

// Namespace namespace_1cac7a6a80266fcc
// Params 0, eflags: 0x4
// Checksum 0x5e0b42e5, Offset: 0x779
// Size: 0x120
function private function_26a2a4606ac74951()
{
    modeinfo = game[ #"frune_tuning" ];
    
    foreach ( player in level.players )
    {
        foreach ( display in modeinfo.var_959c1669e73471ab.racedisplays )
        {
            progress = function_fb759e54e4fb8a8f( player, display );
            function_78d9f259081f7ca7( player, display, progress );
        }
        
        waitframe();
    }
}

// Namespace namespace_1cac7a6a80266fcc
// Params 0, eflags: 0x4
// Checksum 0x11be9bd9, Offset: 0x8a1
// Size: 0x1bc
function private function_78c33980e6ad7fa7()
{
    sortedplayers = arraycombine( [], level.players );
    sortedplayers = arraysort( sortedplayers, undefined, &function_7e87c26c1e0631f1 );
    
    foreach ( player in level.players )
    {
        player.freeruninfo.var_9cf035229789a830 = [];
        var_917385c5e4a38af8 = 1;
        var_1aa44b8fb8539707 = undefined;
        
        foreach ( enemyplayer in sortedplayers )
        {
            if ( player == enemyplayer )
            {
                continue;
            }
            
            var_1aa44b8fb8539707 = enemyplayer player::getuniqueid();
            player.freeruninfo.var_9cf035229789a830[ var_917385c5e4a38af8 ] = var_1aa44b8fb8539707;
            var_917385c5e4a38af8++;
        }
        
        enemycount = sortedplayers.size - 1;
        
        if ( enemycount > 0 && enemycount % 2 != 0 )
        {
            player.freeruninfo.var_9cf035229789a830[ var_917385c5e4a38af8 ] = var_1aa44b8fb8539707;
        }
        
        player.freeruninfo.var_9cf035229789a830[ 10 ] = player player::getuniqueid();
        waitframe();
    }
}

// Namespace namespace_1cac7a6a80266fcc
// Params 2, eflags: 0x4
// Checksum 0x1bad3e15, Offset: 0xa65
// Size: 0x75, Type: bool
function private function_7e87c26c1e0631f1( a, b )
{
    aprogress = a.freeruninfo.currentcheckpoint.flatindex ?? 0;
    bprogress = b.freeruninfo.currentcheckpoint.flatindex ?? 0;
    return aprogress >= bprogress;
}

// Namespace namespace_1cac7a6a80266fcc
// Params 2, eflags: 0x4
// Checksum 0x346a5535, Offset: 0xae3
// Size: 0x74
function private function_fb759e54e4fb8a8f( player, display )
{
    guid = player.freeruninfo.var_9cf035229789a830[ display.var_917385c5e4a38af8 ];
    displayplayer = player::getplayerforguid( guid );
    
    if ( !isplayer( displayplayer ) )
    {
        return 0;
    }
    
    progressint = function_8af007babef47246( displayplayer );
    return progressint;
}

// Namespace namespace_1cac7a6a80266fcc
// Params 3, eflags: 0x4
// Checksum 0xef2aa2d9, Offset: 0xb60
// Size: 0x69
function private function_78d9f259081f7ca7( player, display, progress )
{
    modeinfo = game[ #"frune_tuning" ];
    omnvarname = modeinfo.var_959c1669e73471ab.var_7808919dab0f2904[ display.var_917385c5e4a38af8 ];
    player setclientomnvar( omnvarname, progress );
}

// Namespace namespace_1cac7a6a80266fcc
// Params 1, eflags: 0x4
// Checksum 0xc3892646, Offset: 0xbd1
// Size: 0xa1
function private function_8af007babef47246( player )
{
    if ( !isplayer( player ) )
    {
        return 0;
    }
    
    finalcheckpoint = frune_checkpoints::function_879e36be517c8598();
    var_32147001ee219f7c = finalcheckpoint.flatindex ?? 1;
    currentindex = player.freeruninfo.currentcheckpoint.flatindex ?? 0;
    var_4a62b0f6788ba18e = min( 1, currentindex / var_32147001ee219f7c );
    progressint = roundint( 20 * var_4a62b0f6788ba18e );
    return progressint;
}

/#

    // Namespace namespace_1cac7a6a80266fcc
    // Params 2, eflags: 0x4
    // Checksum 0x7e5a0ac0, Offset: 0xc7b
    // Size: 0x14d, Type: dev
    function private function_240fd8f26de8cce9( host, args )
    {
        function_3c2bfa3cbaab91f1();
        modeinfo = game[ #"frune_tuning" ];
        destinationpercent = float( args[ 0 ] );
        destinationint = roundint( 20 * destinationpercent );
        
        foreach ( player in level.players )
        {
            foreach ( display in modeinfo.var_959c1669e73471ab.racedisplays )
            {
                function_78d9f259081f7ca7( player, display, destinationint );
            }
        }
    }

    // Namespace namespace_1cac7a6a80266fcc
    // Params 2, eflags: 0x4
    // Checksum 0x40403a5d, Offset: 0xdd0
    // Size: 0x61, Type: dev
    function private function_ae056d66a7387f83( host, args )
    {
        function_3c2bfa3cbaab91f1();
        var_e192ef1147f518ac = namespace_ec33f26de741e14e::function_7fb3afaa98ee9eeb( "<dev string:x4f>" );
        var_e192ef1147f518ac.var_c81f5c980304c8ef = !var_e192ef1147f518ac.var_c81f5c980304c8ef;
        level thread function_5e91f3c5c658a1a3( var_e192ef1147f518ac.var_c81f5c980304c8ef );
    }

    // Namespace namespace_1cac7a6a80266fcc
    // Params 1, eflags: 0xc
    // Checksum 0x319a2d84, Offset: 0xe39
    // Size: 0x2a6, Type: dev
    function private function_5e91f3c5c658a1a3( enabled )
    {
        self notify( #"hash_1447e1a0a368e43a" );
        self endon( #"hash_1447e1a0a368e43a" );
        
        if ( !enabled )
        {
            return;
        }
        
        modeinfo = game[ #"frune_tuning" ];
        
        while ( true )
        {
            foreach ( player in level.players )
            {
                for ( var_917385c5e4a38af8 = 1; var_917385c5e4a38af8 <= 10 ; var_917385c5e4a38af8++ )
                {
                    delayseconds = var_917385c5e4a38af8 * 0.3;
                    
                    foreach ( display in modeinfo.var_959c1669e73471ab.racedisplays )
                    {
                        if ( display.var_917385c5e4a38af8 == var_917385c5e4a38af8 )
                        {
                            display thread function_67f2bdd7fe7a3eac( delayseconds, player, display, 20 );
                        }
                    }
                }
            }
            
            wait delayseconds + 1;
            
            foreach ( player in level.players )
            {
                for ( var_917385c5e4a38af8 = 1; var_917385c5e4a38af8 <= 10 ; var_917385c5e4a38af8++ )
                {
                    delayseconds = var_917385c5e4a38af8 * 0.3;
                    
                    foreach ( display in modeinfo.var_959c1669e73471ab.racedisplays )
                    {
                        if ( display.var_917385c5e4a38af8 == var_917385c5e4a38af8 )
                        {
                            display thread function_67f2bdd7fe7a3eac( delayseconds, player, display, 0 );
                        }
                    }
                }
            }
            
            wait delayseconds + 1;
        }
    }

    // Namespace namespace_1cac7a6a80266fcc
    // Params 4, eflags: 0xc
    // Checksum 0x45ed16ac, Offset: 0x10e7
    // Size: 0x50, Type: dev
    function private function_67f2bdd7fe7a3eac( delayseconds, player, display, progressint )
    {
        self notify( #"hash_de7cca1161a94386" );
        self endon( #"hash_de7cca1161a94386" );
        wait delayseconds;
        function_78d9f259081f7ca7( player, display, progressint );
    }

    // Namespace namespace_1cac7a6a80266fcc
    // Params 0, eflags: 0x4
    // Checksum 0xb167570b, Offset: 0x113f
    // Size: 0x27, Type: dev
    function private function_3c2bfa3cbaab91f1()
    {
        game[ #"frune_tuning" ].var_959c1669e73471ab.var_8eafd12dc13edffb = 1;
    }

    // Namespace namespace_1cac7a6a80266fcc
    // Params 2, eflags: 0x4
    // Checksum 0xb3766275, Offset: 0x116e
    // Size: 0x39, Type: dev
    function private function_6182053aed2aadf2( host, args )
    {
        game[ #"frune_tuning" ].var_959c1669e73471ab.var_8eafd12dc13edffb = 0;
    }

#/
