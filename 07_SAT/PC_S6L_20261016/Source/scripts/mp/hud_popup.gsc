// scripts\mp\hud_popup.gsc  (hash_3fa1bf21e3fc7b80.gscc) (size: 2306 Bytes / 0x902 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x435de1be (1130226110)
// size ...... 2306 (0x902)
// includes .. 0   (offset: 0x8ca)
// strings ... 2   (offset: 0x8ca)
// dev strs .. 2   (offset: 0x8ea)
// exports ... 9   (offset: 0x4e6)
// cseg ...... 0x72 + 0x474 (0x4e6)
// imports ... 21  (offset: 0x64e)
// animtree1 . 0   (offset: 0x902)
// animtree2 . 0   (offset: 0x902)
#namespace hud_popup;

// Namespace hud_popup
// Params 0
// Checksum 0x177584e2, Offset: 0x90
// Size: 0xc
function init()
{
    level.var_60eee62ec28fb5f2 = [];
}

// Namespace hud_popup
// Params 1
// Checksum 0x5acb8cb7, Offset: 0xa4
// Size: 0x92
function showinfopopup( ref )
{
    assert( isplayer( self ) );
    popupid = function_87babd196b8f69( ref );
    
    if ( !isdefined( popupid ) || popupid < 0 )
    {
        assertmsg( "<dev string:x24>" + ref + "<dev string:x46>" + getxhashsourcename( function_6a48f158c17a3dfb() ) );
        return;
    }
    
    self setclientomnvar( "ui_player_popup_id", popupid );
    self.lastpopuptime = gettime();
    self.var_19f4eef76dc6a979 = ref;
    
    /#
        debugpopup( popupid );
    #/
}

// Namespace hud_popup
// Params 1
// Checksum 0x50834577, Offset: 0x13e
// Size: 0x75
function function_7a2062cf8e49c4b8( ref )
{
    assert( isplayer( self ) );
    
    if ( isdefined( ref ) )
    {
        popupid = function_87babd196b8f69( ref );
        
        if ( self getclientomnvar( "ui_player_popup_id" ) != popupid )
        {
            return;
        }
    }
    
    self setclientomnvar( "ui_player_popup_id", -1 );
    
    /#
        if ( getdvarint( @"hash_e2743b22a86111f", 1 ) == 1 )
        {
            level notify( #"draw_debug_popup" );
        }
    #/
}

// Namespace hud_popup
// Params 1
// Checksum 0xf5d6eeda, Offset: 0x1bb
// Size: 0xbe
function function_87babd196b8f69( popupref )
{
    id = level.var_60eee62ec28fb5f2[ popupref ];
    
    if ( !isdefined( id ) )
    {
        var_e9b77090b1e0e14 = getscriptbundle( function_6a48f158c17a3dfb() );
        var_71e8437714e884f5 = hashcat( %"hash_52d02d21c2da3502", popupref );
        id = undefined;
        
        for ( index = 0; index < var_e9b77090b1e0e14.entries.size ; index++ )
        {
            entrystruct = var_e9b77090b1e0e14.entries[ index ];
            
            if ( entrystruct.entry == var_71e8437714e884f5 )
            {
                id = index;
                break;
            }
        }
        
        level.var_60eee62ec28fb5f2[ popupref ] = id;
    }
    
    return id;
}

// Namespace hud_popup
// Params 1
// Checksum 0xb5f796c5, Offset: 0x282
// Size: 0x5e
function function_372e68a1d0e98eec( rownum )
{
    var_e9b77090b1e0e14 = getscriptbundle( function_6a48f158c17a3dfb() );
    var_fceeda4d076fd857 = var_e9b77090b1e0e14.entries[ rownum ].entry;
    
    if ( !isdefined( var_fceeda4d076fd857 ) )
    {
        return;
    }
    
    var_bdbbe1d9105a8b9c = getscriptbundle( var_fceeda4d076fd857 );
    return var_bdbbe1d9105a8b9c;
}

// Namespace hud_popup
// Params 0
// Checksum 0x73600afa, Offset: 0x2e9
// Size: 0x50
function function_6a48f158c17a3dfb()
{
    name = getdvar( @"hash_db7ab5886366dcda" );
    
    if ( !isdefined( name ) || name == "" )
    {
        name = level.projectbundle.var_5d0facd5662c7cf8;
    }
    else
    {
        name = getxhashasset( name );
    }
    
    return name;
}

/#

    // Namespace hud_popup
    // Params 4
    // Checksum 0x124d96d9, Offset: 0x342
    // Size: 0xf2, Type: dev
    function drawdebugpopup( popuptitle, popupdesc, popuptier, popupindex )
    {
        level endon( #"game_ended" );
        level notify( #"draw_debug_popup" );
        level endon( #"draw_debug_popup" );
        var_1b9e17510e14c3f6 = 6;
        starttime = gettime();
        
        while ( gettime() - starttime < var_1b9e17510e14c3f6 * 1000 )
        {
            printtoscreen2d( 750, 400, popuptitle, ( 1, 0, 0 ), 3 );
            printtoscreen2d( 750, 475, popupdesc, ( 1, 0, 0 ), 3 );
            printtoscreen2d( 750, 550, popuptier, ( 1, 0, 0 ), 3 );
            printtoscreen2d( 850, 550, popupindex, ( 1, 0, 0 ), 3 );
            waitframe();
        }
    }

    // Namespace hud_popup
    // Params 1
    // Checksum 0x512e675, Offset: 0x43c
    // Size: 0xaa, Type: dev
    function debugpopup( id )
    {
        if ( getdvarint( @"hash_e2743b22a86111f", 0 ) == 0 )
        {
            return;
        }
        
        if ( isbot( self ) )
        {
            return;
        }
        
        var_b96eb4fed655dbe8 = function_372e68a1d0e98eec( id );
        
        if ( !isdefined( var_b96eb4fed655dbe8 ) )
        {
            return;
        }
        
        popuptitle = var_b96eb4fed655dbe8.name;
        popupdesc = var_b96eb4fed655dbe8.description;
        popuptier = var_b96eb4fed655dbe8.tier;
        popupindex = var_b96eb4fed655dbe8.bitindex;
        level thread drawdebugpopup( popuptitle, popupdesc, popuptier, popupindex );
    }

#/
