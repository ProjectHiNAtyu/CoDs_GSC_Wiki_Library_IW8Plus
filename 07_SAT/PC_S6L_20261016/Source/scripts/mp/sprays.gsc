// scripts\mp\sprays.gsc  (hash_75101949899dfa98.gscc) (size: 2624 Bytes / 0xa40 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xacbfaf38 (2898243384)
// size ...... 2624 (0xa40)
// includes .. 3   (offset: 0x964)
// strings ... 7   (offset: 0x97c)
// dev strs .. 8   (offset: 0x9d4)
// exports ... 9   (offset: 0x570)
// cseg ...... 0xdc + 0x494 (0x570)
// imports ... 23  (offset: 0x6d8)
// animtree1 . 0   (offset: 0xa40)
// animtree2 . 0   (offset: 0xa40)
#using scripts\common\devgui;
#using scripts\mp\common\utility\lui_game_event_aggregator;
#using scripts\mp\gestures;

#namespace sprays;

// Namespace sprays
// Params 0
// Checksum 0x1f0bf525, Offset: 0xfa
// Size: 0x20
function sprays_init()
{
    level lui_game_event_aggregator::registeronluieventcallback( &spray_watcher );
    
    /#
        thread function_f90bc49cc2a05799();
    #/
    
    function_fc29b5b25f5f4065();
}

// Namespace sprays
// Params 2
// Checksum 0xd5422e39, Offset: 0x122
// Size: 0x83
function spray_watcher( notification, slotindex )
{
    if ( notification === "use_spray" )
    {
        assert( slotindex < 5, "<dev string:x24>" + slotindex + "<dev string:x42>" + 5 );
        spray = self.var_c9e5effa7d1a03b2[ slotindex ];
        
        if ( isdefined( spray ) )
        {
            gestures::watchradialgestureactivation( "radial_menu_selection_spray", spray );
            return;
        }
        
        assertmsg( "<dev string:x63>" + slotindex + "<dev string:x84>" );
    }
}

// Namespace sprays
// Params 0
// Checksum 0xa4b19803, Offset: 0x1ad
// Size: 0x4a
function function_437b5f4224c76e05()
{
    if ( isdefined( self.var_c9e5effa7d1a03b2 ) )
    {
        return;
    }
    
    self.var_c9e5effa7d1a03b2 = [];
    
    for ( i = 0; i < 5 ; i++ )
    {
        self.var_c9e5effa7d1a03b2[ i ] = function_9474d4c4b0b747f2( i );
    }
}

// Namespace sprays
// Params 0
// Checksum 0xda43cbc4, Offset: 0x1ff
// Size: 0x164
function function_fc29b5b25f5f4065()
{
    if ( isdefined( level.var_679930d4b0668529 ) )
    {
        return;
    }
    
    level.var_679930d4b0668529 = [];
    level.var_94a2c7b2dea5f763 = [];
    gamemodebundle = level.gamemodebundle;
    
    if ( !isdefined( gamemodebundle.spraylist ) )
    {
        return;
    }
    
    var_cae8eb56187566ff = getscriptbundle( gamemodebundle.spraylist );
    
    if ( !isdefined( var_cae8eb56187566ff ) )
    {
        return;
    }
    
    spraylist = var_cae8eb56187566ff.var_10257c3c5cd3d2ff;
    
    for ( i = 0; i < spraylist.size ; i++ )
    {
        if ( !isdefined( spraylist[ i ].spraybundle ) )
        {
            continue;
        }
        
        spraybundle = getscriptbundlefieldvalues( spraylist[ i ].spraybundle, [ #"spray", #"lootid" ] );
        sprayref = spraybundle.spray;
        
        if ( !isdefined( sprayref ) )
        {
            continue;
        }
        
        level.var_679930d4b0668529[ sprayref ] = spraybundle.lootid;
        level.var_94a2c7b2dea5f763[ spraybundle.lootid ] = sprayref;
        
        /#
            sourcename = getxhashsourcename( sprayref );
            devgui::add_devgui_command( "<dev string:xd5>" + sourcename, "<dev string:xe8>" + sourcename, i + 1 );
        #/
    }
}

// Namespace sprays
// Params 1
// Checksum 0xd1447d00, Offset: 0x36b
// Size: 0x10d
function function_9474d4c4b0b747f2( slot )
{
    if ( level.gamemodebundle.var_38512d10cd15416d )
    {
        if ( !self hasplayerdata() )
        {
            return;
        }
    }
    else if ( !self hasplayerdata() )
    {
        return;
    }
    
    spray = undefined;
    
    if ( isplayer( self ) )
    {
        var_b5dcfabaea4399f5 = undefined;
        
        if ( level.gamemodebundle.var_38512d10cd15416d )
        {
            var_b5dcfabaea4399f5 = self getplayerdata( level.loadoutsgroup, "customizations", "sprays", slot );
            
            if ( isdefined( var_b5dcfabaea4399f5 ) )
            {
                if ( isxhashasset( var_b5dcfabaea4399f5 ) )
                {
                    if ( var_b5dcfabaea4399f5 != %"" && var_b5dcfabaea4399f5 != %"none" )
                    {
                        return var_b5dcfabaea4399f5;
                    }
                }
                else if ( var_b5dcfabaea4399f5 != 0 )
                {
                    return function_5144f9fc9e4d0fbc( var_b5dcfabaea4399f5 );
                }
            }
        }
        else
        {
            var_b5dcfabaea4399f5 = self getplayerdata( level.loadoutsgroup, "customizationSetup", "sprayCustomization", "sprays", slot );
            
            if ( isdefined( var_b5dcfabaea4399f5 ) && var_b5dcfabaea4399f5 != 0 )
            {
                spray = function_5144f9fc9e4d0fbc( var_b5dcfabaea4399f5 );
            }
        }
    }
    
    return spray;
}

// Namespace sprays
// Params 1
// Checksum 0x7e650840, Offset: 0x481
// Size: 0x2e
function function_9034df6e577a38e8( sprayref )
{
    var_7237854e3be197ca = level.var_679930d4b0668529[ sprayref ];
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    return 0;
}

// Namespace sprays
// Params 1
// Checksum 0x13e377c3, Offset: 0x4b8
// Size: 0x32
function function_5144f9fc9e4d0fbc( spraylootid )
{
    var_7237854e3be197ca = level.var_94a2c7b2dea5f763[ spraylootid ];
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    return "defaultspray";
}

/#

    // Namespace sprays
    // Params 0
    // Checksum 0xb39a5c34, Offset: 0x4f3
    // Size: 0x7d, Type: dev
    function function_f90bc49cc2a05799()
    {
        setdevdvarifuninitialized( @"spray_use", "<dev string:xf7>" );
        
        while ( true )
        {
            spray = getdvar( @"spray_use", "<dev string:xf7>" );
            
            if ( spray != "<dev string:xf7>" )
            {
                level.player gestures::watchradialgestureactivation( "<dev string:xf8>", getxhashasset( spray ) );
                setdevdvar( @"spray_use", "<dev string:xf7>" );
            }
            
            wait 1;
        }
    }

#/
