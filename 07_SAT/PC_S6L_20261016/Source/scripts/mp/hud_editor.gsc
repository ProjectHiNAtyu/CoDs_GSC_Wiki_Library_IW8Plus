// scripts\mp\hud_editor.gsc  (hash_0cab104f5bd3bf3d.gscc) (size: 2477 Bytes / 0x9ad / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xec11f31b (3960599323)
// size ...... 2477 (0x9ad)
// includes .. 3   (offset: 0x921)
// strings ... 9   (offset: 0x939)
// dev strs .. 0   (offset: 0x9ad)
// exports ... 8   (offset: 0x4e5)
// cseg ...... 0xcc + 0x419 (0x4e5)
// imports ... 26  (offset: 0x625)
// animtree1 . 0   (offset: 0x9ad)
// animtree2 . 0   (offset: 0x9ad)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\utility\game_utility;

#namespace hud_editor;

// Namespace hud_editor
// Params 0, eflags: 0x1
// Checksum 0xc06341eb, Offset: 0xea
// Size: 0x2d
function autoexec init()
{
    if ( level.gamemodebundle.var_27ee0419996a1958 )
    {
        callback::add( #"player_connect", &function_629bfbb59076ff42 );
    }
}

// Namespace hud_editor
// Params 1
// Checksum 0x34d9af86, Offset: 0x11f
// Size: 0xdf
function function_629bfbb59076ff42( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    /#
        if ( isbot( self ) && getdvarint( @"hash_3e265dca96cd2809" ) == 1 )
        {
            randomint = randomintrange( 1, 6 );
            self.hudeditor = self.hudeditor ?? spawnstruct();
            self.hudeditor.themeindex = randomint;
            self.hudeditor.hueshift = -1;
            return;
        }
    #/
    
    if ( !isbot( self ) )
    {
        postfix = function_5f0f63a62605da4d();
        utility::function_e16c621f95fe3acf( &function_ff378b35d3454e85, [ "appliedhudthemeindex" + postfix, "themeHueShift" + postfix ] );
        function_ff378b35d3454e85();
        
        if ( self )
        {
            function_13731cb7aad1e2ed();
        }
    }
}

// Namespace hud_editor
// Params 0
// Checksum 0x34a7099a, Offset: 0x206
// Size: 0x63
function function_5f0f63a62605da4d()
{
    postfix = "_mp";
    
    if ( getdvarint( @"hash_e55d131d448270b6", 0 ) == 1 )
    {
        if ( isbrgamemode() )
        {
            postfix = "_wz";
        }
        else if ( game_utility::getgametype() == "ob" )
        {
            postfix = "_ob";
        }
        else if ( game_utility::function_6131f69cfe56ed90() )
        {
            postfix = "_zm";
        }
    }
    
    return postfix;
}

// Namespace hud_editor
// Params 0
// Checksum 0x5d004a49, Offset: 0x272
// Size: 0xb4
function function_ff378b35d3454e85()
{
    if ( !self || !isplayer( self ) || isbot( self ) )
    {
        return;
    }
    
    postfix = function_5f0f63a62605da4d();
    
    if ( !isdefined( self.hudeditor ) )
    {
        self.hudeditor = {};
    }
    
    themeindex = utility::requestgamerprofile( "appliedhudthemeindex" + postfix ) ?? 0;
    
    if ( !self )
    {
        return;
    }
    
    hueshift = utility::requestgamerprofile( "themeHueShift" + postfix ) ?? -1;
    
    if ( !self )
    {
        return;
    }
    
    self.hudeditor.themeindex = themeindex;
    self.hudeditor.hueshift = hueshift;
}

// Namespace hud_editor
// Params 1
// Checksum 0x1eb2aaf5, Offset: 0x32e
// Size: 0xd7
function function_8618046cf533c449( spectatedplayer )
{
    if ( !self || isbot( self ) )
    {
        return;
    }
    
    if ( isdefined( spectatedplayer.hudeditor ) )
    {
        themeindex = function_5cdebdd9e61b58f4( spectatedplayer.hudeditor.themeindex, 1, o"ui_spectating_hud_theme_index" );
        hueshift = function_5cdebdd9e61b58f4( spectatedplayer.hudeditor.hueshift, -1, o"ui_spectating_theme_hue_shift" );
        self setclientomnvar( o"ui_spectating_hud_theme_index", themeindex, 1 );
        self setclientomnvar( o"ui_spectating_theme_hue_shift", hueshift, 1 );
        return;
    }
    
    self setclientomnvar( o"ui_spectating_hud_theme_index", 1 );
    self setclientomnvar( o"ui_spectating_theme_hue_shift", -1 );
}

// Namespace hud_editor
// Params 3, eflags: 0x4
// Checksum 0x1a3d33f7, Offset: 0x40d
// Size: 0x59
function private function_5cdebdd9e61b58f4( value, defaultvalue, omnvarname )
{
    range = getomnvarrange( omnvarname );
    
    if ( !range || !value )
    {
        return defaultvalue;
    }
    
    if ( value < range[ 0 ] || value > range[ 1 ] )
    {
        return defaultvalue;
    }
    
    return value;
}

// Namespace hud_editor
// Params 0
// Checksum 0xc672d536, Offset: 0x46f
// Size: 0x76
function function_13731cb7aad1e2ed()
{
    self notify( #"hash_49287a789cc2a1c9" );
    self endon( #"hash_49287a789cc2a1c9" );
    self endon( #"disconnect" );
    
    while ( self )
    {
        utility::waittill_any( "joined_spectators", "spectating_cycle" );
        waittillframeend();
        spectatedplayer = self getspectatingplayer();
        
        if ( isdefined( spectatedplayer ) )
        {
            if ( !isbot( spectatedplayer ) )
            {
                spectatedplayer function_ff378b35d3454e85();
            }
            
            if ( self )
            {
                function_8618046cf533c449( spectatedplayer );
            }
        }
    }
}

