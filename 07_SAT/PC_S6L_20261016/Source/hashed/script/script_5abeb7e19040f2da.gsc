// script_5abeb7e19040f2da  (hash_5abeb7e19040f2da.gscc) (size: 7953 Bytes / 0x1f11 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb4e073da (3034608602)
// size ...... 7953 (0x1f11)
// includes .. 9   (offset: 0x1d91)
// strings ... 8   (offset: 0x1dd9)
// dev strs .. 15  (offset: 0x1e5d)
// exports ... 17  (offset: 0x11c9)
// cseg ...... 0xde + 0x10eb (0x11c9)
// imports ... 79  (offset: 0x1471)
// animtree1 . 0   (offset: 0x1f11)
// animtree2 . 0   (offset: 0x1f11)
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\scriptable;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\loot\common_item;
#using scripts\mp\ob\systems\region_difficulty_manager;

#namespace power_nodes;

// Namespace power_nodes
// Params 0, eflags: 0x1
// Checksum 0x33759009, Offset: 0xfc
// Size: 0x9
function autoexec main()
{
    init();
}

// Namespace power_nodes
// Params 0, eflags: 0x4
// Checksum 0x477aa35a, Offset: 0x10d
// Size: 0x2a6
function private init()
{
    if ( level.var_bb86f77304f193c4.var_5e4c23be40eb8b55 )
    {
        /#
            level thread function_9e2f10d0f090935f();
        #/
        
        scriptable::scriptable_addautousecallback( &function_b7553c6c20e4b836 );
        var_57bf6d83a57236a9 = getentitylessscriptablearray( "scriptable_" + "ob_sat_power_node", "classname" );
        level.var_326e483ae9289d99 = {};
        level.var_326e483ae9289d99.bundledata = {};
        level.var_326e483ae9289d99.bundledata.var_1dd3bdd47efa64a9 = level.var_bb86f77304f193c4.var_1dd3bdd47efa64a9;
        
        if ( getdvarint( @"hash_82993c185c7c183d", 0 ) )
        {
            utility::flag_wait( "scriptables_ready" );
            waitframe();
            
            foreach ( powernode in var_57bf6d83a57236a9 )
            {
                enable_power_node( powernode );
            }
            
            level.var_326e483ae9289d99.spawnednodes = var_57bf6d83a57236a9;
            return;
        }
        
        var_faf33e4dbb9c25dd = function_626dd3d638e91fb5( var_57bf6d83a57236a9 );
        level.var_326e483ae9289d99.bundledata.percentageenabled = max( getdvarfloat( @"hash_bbd7c864345c37f0", level.var_bb86f77304f193c4.var_89af1fc8bc7e9855 ?? 0.5 ), 1 );
        level.var_326e483ae9289d99.var_2256a661aff11815 = getdvarint( @"hash_c77153cacd447309", 0 );
        var_7f2df02fb38ebf92 = int( ceil( var_faf33e4dbb9c25dd.size / 4 ) );
        var_3e1a47ac71877758 = int( ceil( var_7f2df02fb38ebf92 * level.var_326e483ae9289d99.bundledata.percentageenabled ) );
        var_4ec83e9fa479336b = hashcat( @"hash_4223258f9cd27738", "__", "power_node" );
        setdvar( var_4ec83e9fa479336b, var_3e1a47ac71877758 );
        var_4ec83e9fa479336b = hashcat( @"hash_20d31e298a7c480d", "__", "power_node" );
        setdvar( var_4ec83e9fa479336b, var_3e1a47ac71877758 );
        var_4ec83e9fa479336b = hashcat( @"hash_2ba1577e853f4dd7", "__", "power_node" );
        setdvar( var_4ec83e9fa479336b, var_3e1a47ac71877758 );
        var_4ec83e9fa479336b = hashcat( @"hash_e6f6531887272c1c", "__", "power_node" );
        setdvar( var_4ec83e9fa479336b, var_3e1a47ac71877758 );
        thread function_1955fc5b1dbde123( var_faf33e4dbb9c25dd );
    }
}

// Namespace power_nodes
// Params 1
// Checksum 0x219a850c, Offset: 0x3bb
// Size: 0xe9
function function_626dd3d638e91fb5( old_array )
{
    new_array = [];
    marked_tag = [];
    array = arrayrandomize( old_array );
    
    foreach ( element in array )
    {
        if ( !element.script_noteworthy )
        {
            new_array[ new_array.size ] = element;
            continue;
        }
        
        if ( !arraycontains( marked_tag, element.script_noteworthy ) )
        {
            new_array[ new_array.size ] = element;
            marked_tag[ marked_tag.size ] = element.script_noteworthy;
            continue;
        }
    }
    
    return new_array;
}

// Namespace power_nodes
// Params 3, eflags: 0x4
// Checksum 0x5fb782eb, Offset: 0x4ad
// Size: 0x439
function private consume_power_node( instance, player, var_bf7b575eb201a1fd = 0 )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( instance.playerscollected[ player getguid() ] )
    {
        return;
    }
    
    itembundle = common_item::function_33a2c00e46263d99( instance );
    
    if ( !itembundle )
    {
        return;
    }
    
    subtype = getscriptbundlefieldvalue( itembundle, #"subtype" );
    
    if ( subtype != #"power_node" )
    {
        return;
    }
    
    forward = anglestoforward( player getplayerangles() );
    var_3345c1d37f86cce0 = length( player getvelocity() ) * 0.2;
    forwardvelocity = forward * var_3345c1d37f86cce0;
    spawnposition = instance.origin + forwardvelocity;
    spawnoptions = common_item::items_initspawnoptions_spawnfromposition( spawnposition, instance.angles );
    spawnoptions.var_90cdc5dbcd319e5d = 1;
    spawnoptions.var_8d4f327170228364 = 1;
    spawnoptions.var_9161cf0784b6951d = 1;
    spawnoptions.dropradiusscale = 0;
    spawnoptions.var_23d3495c57d61bdf = 1;
    spawnoptions.var_10a99b46418cef2 = [];
    spawnoptions.ignoreents = [ instance ];
    spawnoptions.var_4a4b419f66681601 = [ player ];
    spawnoptions.var_c580c0e8b49f1fcc = 1;
    itemdroplist = %"hash_50efa144bb9e0f08";
    dropquantity = 1;
    
    foreach ( var_4a251b1c87c33279 in level.var_326e483ae9289d99.bundledata.var_1dd3bdd47efa64a9 )
    {
        if ( var_4a251b1c87c33279.regiondifficulty != getxhash( region_difficulty_manager::function_f9fbb630598afdc7( instance.origin ).difficulty ) )
        {
            continue;
        }
        
        itemdroplist = var_4a251b1c87c33279.lootlist;
        dropquantity = var_4a251b1c87c33279.lootquantity ?? 1;
        break;
    }
    
    if ( level.var_326e483ae9289d99.var_2256a661aff11815 )
    {
        dropquantity = level.var_326e483ae9289d99.var_2256a661aff11815;
    }
    
    if ( !player isonground() || var_bf7b575eb201a1fd )
    {
        spawnoptions.var_8d4f327170228364 = 1;
    }
    
    var_e9564cd22ae43276 = player common_item::function_38cde6a6acb68ea6( itemdroplist, dropquantity, spawnoptions );
    
    if ( spawnoptions.var_8d4f327170228364 )
    {
        foreach ( item in var_e9564cd22ae43276 )
        {
            if ( var_bf7b575eb201a1fd )
            {
                item.allowabsorb = 1;
                item utility::function_7c10ea82c1e305b8( item.type, #"hidden" );
                player common_item::function_2b5e2ff57d5f392( item, 1, 0 );
                continue;
            }
            
            item function_e3fcde595da2ca5f( player );
        }
    }
    
    if ( instance scriptablemaskallowed() )
    {
        instance.playerscollected[ player getguid() ] = 1;
        instance function_d6a7b7ef13a57f38( player );
    }
    else
    {
        instance utility::function_7c10ea82c1e305b8( #"ob_sat_power_node", #"hidden" );
        
        if ( instance.additional_trigger )
        {
            instance.additional_trigger delete();
            instance.additional_trigger = undefined;
        }
    }
    
    level callback::callback( #"hash_91f2a0e70afebfe1", { #instance:instance, #interactionevent:#"hash_f68bb686d0f02577", #player:player } );
}

// Namespace power_nodes
// Params 6, eflags: 0x4
// Checksum 0x558cdc37, Offset: 0x8ee
// Size: 0x43
function private function_b7553c6c20e4b836( instance, part, state, player, bautouse, usestring )
{
    consume_power_node( instance, player );
}

// Namespace power_nodes
// Params 1
// Checksum 0xf6390b5c, Offset: 0x939
// Size: 0x50
function function_1955fc5b1dbde123( var_326e483ae9289d99 )
{
    level endon( #"game_ended" );
    utility::flag_wait( "scriptables_ready" );
    waitframe();
    level.var_326e483ae9289d99.spawnednodes = [[ level.var_37ee95c5464d47be ]]( "power_node", var_326e483ae9289d99, &enable_power_node );
}

// Namespace power_nodes
// Params 2
// Checksum 0x78881443, Offset: 0x991
// Size: 0x92
function enable_power_node( node, var_791afcd1e03316b4 = 0 )
{
    node utility::function_7c10ea82c1e305b8( #"ob_sat_power_node", #"visible" );
    
    if ( ( var_791afcd1e03316b4 || node.script_parameters == "a_trigger" ) && !node.additional_trigger )
    {
        node.additional_trigger = spawn( "noent_volume_trigger_radius", node.origin, 512, 50, 80 );
        node thread function_89746141a686e443();
    }
}

// Namespace power_nodes
// Params 0
// Checksum 0x98fb54e0, Offset: 0xa2b
// Size: 0x94
function function_89746141a686e443()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self.additional_trigger endon( #"death" );
    
    while ( true )
    {
        self.additional_trigger waittill( #"trigger", ent );
        
        if ( isplayer( ent ) && isalive( ent ) )
        {
            if ( ent isonascender() && !self.playerscollected[ ent getguid() ] )
            {
                consume_power_node( self, ent, 1 );
            }
        }
    }
}

// Namespace power_nodes
// Params 1
// Checksum 0x6ff97de2, Offset: 0xac7
// Size: 0x70
function function_9b261dd8554ca232( origin )
{
    if ( function_479a91629c936167() == 0 )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    powernode = spawnscriptable( "ob_sat_power_node", origin );
    enable_power_node( powernode );
    level.var_326e483ae9289d99.spawnednodes[ level.var_326e483ae9289d99.spawnednodes.size ] = powernode;
    return powernode;
}

/#

    // Namespace power_nodes
    // Params 0, eflags: 0x4
    // Checksum 0x56810cd4, Offset: 0xb40
    // Size: 0x143, Type: dev
    function private function_60251d3506f7495()
    {
        while ( true )
        {
            waitframe();
            
            if ( !isdefined( level.players ) )
            {
                continue;
            }
            
            cheatplayers = level.players;
            var_6e4cf32910d62e5b = getdvar( @"cheat_player" );
            
            if ( isdefined( var_6e4cf32910d62e5b ) )
            {
                foreach ( player in level.players )
                {
                    if ( player.name == var_6e4cf32910d62e5b )
                    {
                        cheatplayers = [ player ];
                        break;
                    }
                }
            }
            
            cheat_dvars = function_d736a179632efa58();
            
            if ( cheat_dvars[ #"hash_61eb0bd90073ded0" ] )
            {
                function_3ae0bc2a697732da( cheatplayers );
            }
            
            if ( cheat_dvars[ #"hash_1586a4c809728680" ] )
            {
                function_3c0857ee1b2c0cfe();
            }
            
            if ( cheat_dvars[ #"hash_3bb512ceaf78c5c5" ] )
            {
                function_245da97d2fb46c03();
            }
            
            if ( cheat_dvars[ #"hash_19dba3042b0e01fc" ] )
            {
                level thread function_d875e719a38bd760();
            }
        }
    }

    // Namespace power_nodes
    // Params 0, eflags: 0x4
    // Checksum 0xdc3bc12d, Offset: 0xc8b
    // Size: 0x6f, Type: dev
    function private function_d736a179632efa58()
    {
        return [ #"hash_19dba3042b0e01fc":utility::consume_dvar_int( @"hash_74c5b2b7fbcd8d6c", 0 ), #"hash_3bb512ceaf78c5c5":utility::consume_dvar_int( @"hash_4c6015f5fcbaf9e6", 0 ), #"hash_1586a4c809728680":utility::consume_dvar_int( @"hash_e8114104db5d7937", 0 ), #"hash_61eb0bd90073ded0":utility::consume_dvar_int( @"hash_c7f18a93ba1882a8", 0 ) ];
    }

    // Namespace power_nodes
    // Params 0, eflags: 0x4
    // Checksum 0x70a97c3a, Offset: 0xd02
    // Size: 0x9a, Type: dev
    function private function_9e2f10d0f090935f()
    {
        waitframe();
        var_2007867e0cbe557a = game_utility::getgametype() != "<dev string:x64>";
        
        if ( var_2007867e0cbe557a )
        {
            devgui::function_9082edeb5db93280( "<dev string:x67>" );
            devgui::add_devgui_func( "<dev string:x77>", "<dev string:x7d>", &function_3ae0bc2a697732da );
            devgui::add_devgui_func( "<dev string:x8c>", "<dev string:xa2>", &function_245da97d2fb46c03 );
            devgui::add_devgui_func( "<dev string:xb6>", "<dev string:xc9>", &function_3c0857ee1b2c0cfe, 1 );
            devgui::add_devgui_func( "<dev string:xd8>", "<dev string:xf5>", &function_d875e719a38bd760, 1 );
            devgui::function_77df7fe7dd273e10();
        }
        
        level thread function_60251d3506f7495();
    }

    // Namespace power_nodes
    // Params 1, eflags: 0x4
    // Checksum 0x3b0dac12, Offset: 0xda4
    // Size: 0x18e, Type: dev
    function private function_3ae0bc2a697732da( cheatplayers )
    {
        if ( !isdefined( cheatplayers ) )
        {
            cheatplayers = level.players;
        }
        
        if ( !cheatplayers )
        {
            return;
        }
        
        castcontents = trace::create_contents( 0, 1, 1, 0, 1, 0 );
        
        foreach ( player in cheatplayers )
        {
            if ( !player.origin )
            {
                continue;
            }
            
            eyeposition = player geteye();
            playerforward = anglestoforward( player getplayerangles() );
            castend = eyeposition + playerforward * 600;
            castresult = trace::ray_trace( eyeposition, castend, player, castcontents );
            
            if ( !isdefined( castresult ) )
            {
                continue;
            }
            
            if ( castresult.size != 0 )
            {
                castend = castresult[ "<dev string:x10c>" ] + playerforward * 0.1;
            }
            
            if ( function_479a91629c936167() > 0 )
            {
                powernode = spawnscriptable( "<dev string:x115>", castend );
                enable_power_node( powernode, 1 );
                level.var_326e483ae9289d99.spawnednodes[ level.var_326e483ae9289d99.spawnednodes.size ] = powernode;
                continue;
            }
            
            assertmsg( "<dev string:x127>" );
        }
    }

    // Namespace power_nodes
    // Params 0, eflags: 0x4
    // Checksum 0x1c685edd, Offset: 0xf3a
    // Size: 0xf2, Type: dev
    function private function_245da97d2fb46c03()
    {
        foreach ( powernode in level.var_326e483ae9289d99.spawnednodes )
        {
            if ( powernode utility::function_9f2c41c1dcc8c94( #"ob_sat_power_node", #"hidden" ) )
            {
                powernode utility::function_7c10ea82c1e305b8( #"ob_sat_power_node", #"visible" );
                continue;
            }
            
            if ( powernode utility::function_9f2c41c1dcc8c94( #"ob_sat_power_node", #"visible" ) )
            {
                powernode utility::function_7c10ea82c1e305b8( #"ob_sat_power_node", #"hidden" );
            }
        }
    }

    // Namespace power_nodes
    // Params 0, eflags: 0x4
    // Checksum 0xd0952920, Offset: 0x1034
    // Size: 0xb2, Type: dev
    function private function_3c0857ee1b2c0cfe()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            foreach ( powernodes in level.var_326e483ae9289d99.spawnednodes )
            {
                debug::sphere( powernodes.origin, 250, "<dev string:x14b>" );
            }
            
            wait 5;
        }
    }

    // Namespace power_nodes
    // Params 0, eflags: 0xc
    // Checksum 0x3091bb07, Offset: 0x10ee
    // Size: 0xdb, Type: dev
    function private function_d875e719a38bd760()
    {
        self notify( #"hash_4d2de8b340d602e8" );
        self endon( #"hash_4d2de8b340d602e8" );
        level endon( #"game_ended" );
        
        while ( true )
        {
            foreach ( powernode in level.var_326e483ae9289d99.spawnednodes )
            {
                if ( powernode.additional_trigger )
                {
                    drawtrigger( powernode.additional_trigger, ( 1, 0, 0 ), 0, 1, 0 );
                }
            }
            
            waitframe();
        }
    }

#/
