// scripts\mp\hud_util.gsc  (hash_64afae76ccb166fc.gscc) (size: 16778 Bytes / 0x418a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa3467287 (2739303047)
// size ...... 16778 (0x418a)
// includes .. 8   (offset: 0x3e86)
// strings ... 37  (offset: 0x3ec6)
// dev strs .. 5   (offset: 0x4146)
// exports ... 55  (offset: 0x2db6)
// cseg ...... 0x28b + 0x2b2b (0x2db6)
// imports ... 61  (offset: 0x364e)
// animtree1 . 0   (offset: 0x418a)
// animtree2 . 0   (offset: 0x418a)
#using script_16ea1b94f0f381b3;
#using scripts\common\script;
#using scripts\common\utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\hud_message;

#namespace hud_util;

// Namespace hud_util
// Params 1
// Checksum 0x422221d2, Offset: 0x2a9
// Size: 0x9d
function setparent( element )
{
    if ( self.parent == element )
    {
        return;
    }
    
    if ( isdefined( self.parent ) )
    {
        self.parent removechild( self );
    }
    
    self.parent = element;
    self.parent addchild( self );
    
    if ( isdefined( self.point ) )
    {
        setpoint( self.point, self.relativepoint, self.xoffset, self.yoffset );
        return;
    }
    
    setpoint( "TOPLEFT" );
}

// Namespace hud_util
// Params 0
// Checksum 0x6cd11e3e, Offset: 0x34e
// Size: 0xb
function getparent()
{
    return self.parent;
}

// Namespace hud_util
// Params 0
// Checksum 0xa20cac86, Offset: 0x362
// Size: 0xc7
function removedestroyedchildren()
{
    if ( self.childchecktime == gettime() )
    {
        return;
    }
    
    self.childchecktime = gettime();
    newchildren = [];
    
    foreach ( child in self.children )
    {
        if ( !isdefined( child ) )
        {
            continue;
        }
        
        child.index = newchildren.size;
        newchildren[ newchildren.size ] = child;
    }
    
    self.children = newchildren;
}

// Namespace hud_util
// Params 1
// Checksum 0xe47a69b5, Offset: 0x431
// Size: 0x40
function addchild( element )
{
    element.index = self.children.size;
    self.children[ self.children.size ] = element;
    removedestroyedchildren();
}

// Namespace hud_util
// Params 1
// Checksum 0xd414f726, Offset: 0x479
// Size: 0xae
function removechild( element )
{
    element.parent = undefined;
    
    if ( self.children[ self.children.size - 1 ] != element )
    {
        self.children[ element.index ] = self.children[ self.children.size - 1 ];
        self.children[ element.index ].index = element.index;
    }
    
    self.children[ self.children.size - 1 ] = undefined;
    element.index = undefined;
}

// Namespace hud_util
// Params 5
// Checksum 0xe1e964af, Offset: 0x52f
// Size: 0x3fc
function setpoint( point, relativepoint, xoffset, yoffset, movetime = 0 )
{
    element = getparent();
    
    if ( movetime )
    {
        self moveovertime( movetime );
    }
    
    if ( !isdefined( xoffset ) )
    {
        xoffset = 0;
    }
    
    self.xoffset = xoffset;
    
    if ( !isdefined( yoffset ) )
    {
        yoffset = 0;
    }
    
    self.yoffset = yoffset;
    self.point = point;
    self.alignx = "center";
    self.aligny = "middle";
    
    if ( issubstr( point, "TOP" ) )
    {
        self.aligny = "top";
    }
    
    if ( issubstr( point, "BOTTOM" ) )
    {
        self.aligny = "bottom";
    }
    
    if ( issubstr( point, "LEFT" ) )
    {
        self.alignx = "left";
    }
    
    if ( issubstr( point, "RIGHT" ) )
    {
        self.alignx = "right";
    }
    
    if ( !isdefined( relativepoint ) )
    {
        relativepoint = point;
    }
    
    self.relativepoint = relativepoint;
    relativex = "center_adjustable";
    relativey = "middle";
    
    if ( issubstr( relativepoint, "TOP" ) )
    {
        relativey = "top_adjustable";
    }
    
    if ( issubstr( relativepoint, "BOTTOM" ) )
    {
        relativey = "bottom_adjustable";
    }
    
    if ( issubstr( relativepoint, "LEFT" ) )
    {
        relativex = "left_adjustable";
    }
    
    if ( issubstr( relativepoint, "RIGHT" ) )
    {
        relativex = "right_adjustable";
    }
    
    if ( element == level.uiparent )
    {
        self.horzalign = relativex;
        self.vertalign = relativey;
    }
    else
    {
        self.horzalign = element.horzalign;
        self.vertalign = element.vertalign;
    }
    
    if ( script::strip_suffix( relativex, "_adjustable" ) == element.alignx )
    {
        offsetx = 0;
        xfactor = 0;
    }
    else if ( relativex == "center" || element.alignx == "center" )
    {
        offsetx = int( element.width / 2 );
        
        if ( relativex == "left_adjustable" || element.alignx == "right" )
        {
            xfactor = -1;
        }
        else
        {
            xfactor = 1;
        }
    }
    else
    {
        offsetx = element.width;
        
        if ( relativex == "left_adjustable" )
        {
            xfactor = -1;
        }
        else
        {
            xfactor = 1;
        }
    }
    
    self.x = element.x + offsetx * xfactor;
    
    if ( script::strip_suffix( relativey, "_adjustable" ) == element.aligny )
    {
        offsety = 0;
        yfactor = 0;
    }
    else if ( relativey == "middle" || element.aligny == "middle" )
    {
        offsety = int( element.height / 2 );
        
        if ( relativey == "top_adjustable" || element.aligny == "bottom" )
        {
            yfactor = -1;
        }
        else
        {
            yfactor = 1;
        }
    }
    else
    {
        offsety = element.height;
        
        if ( relativey == "top_adjustable" )
        {
            yfactor = -1;
        }
        else
        {
            yfactor = 1;
        }
    }
    
    self.y = element.y + offsety * yfactor;
    self.x += self.xoffset;
    self.y += self.yoffset;
    
    switch ( self.elemtype )
    {
        case #"hash_2125856c1b2381fa":
            setpointbar( point, relativepoint, xoffset, yoffset );
            break;
    }
    
    updatechildren();
}

// Namespace hud_util
// Params 4
// Checksum 0xb7bcb3b1, Offset: 0x933
// Size: 0x1cb
function setpointbar( point, relativepoint, xoffset, yoffset )
{
    self.bar.horzalign = self.horzalign;
    self.bar.vertalign = self.vertalign;
    self.bar.alignx = "left";
    self.bar.aligny = self.aligny;
    self.bar.y = self.y;
    
    if ( self.alignx == "left" )
    {
        self.bar.x = self.x;
    }
    else if ( self.alignx == "right" )
    {
        self.bar.x = self.x - self.width;
    }
    else
    {
        self.bar.x = self.x - int( self.width / 2 );
    }
    
    if ( self.aligny == "top" )
    {
        self.bar.y = self.y;
    }
    else if ( self.aligny == "bottom" )
    {
        self.bar.y = self.y;
    }
    
    updatebar( self.bar.frac );
}

// Namespace hud_util
// Params 2
// Checksum 0xa11ed996, Offset: 0xb06
// Size: 0x31
function updatebar( barfrac, rateofchange )
{
    if ( self.elemtype == "bar" )
    {
        updatebarscale( barfrac, rateofchange );
    }
}

// Namespace hud_util
// Params 2
// Checksum 0xfd623d11, Offset: 0xb3f
// Size: 0x19c
function updatebarscale( barfrac, rateofchange )
{
    barwidth = int( self.width * barfrac + 0.5 );
    
    if ( !barwidth )
    {
        barwidth = 1;
    }
    
    self.bar.frac = barfrac;
    self.bar setshader( self.bar.shader, barwidth, self.height );
    assert( barwidth <= self.width, "<dev string:x24>" + barwidth + "<dev string:x3d>" + self.width + "<dev string:x42>" + barfrac );
    
    if ( isdefined( rateofchange ) && barwidth < self.width )
    {
        if ( rateofchange > 0 )
        {
            assert( ( 1 - barfrac ) / rateofchange > 0, "<dev string:x52>" + barfrac + "<dev string:x5c>" + rateofchange );
            self.bar scaleovertime( ( 1 - barfrac ) / rateofchange, self.width, self.height );
        }
        else if ( rateofchange < 0 )
        {
            assert( barfrac / -1 * rateofchange > 0, "<dev string:x52>" + barfrac + "<dev string:x5c>" + rateofchange );
            self.bar scaleovertime( barfrac / -1 * rateofchange, 1, self.height );
        }
    }
    
    self.bar.rateofchange = rateofchange;
    self.bar.lastupdatetime = gettime();
}

// Namespace hud_util
// Params 11
// Checksum 0xa736d329, Offset: 0xce3
// Size: 0x1c7
function createhudelem( label, value, point, relativepoint, xoffset, yoffset, color, team, fontscale = 1.5, player, alpha = 0 )
{
    if ( isdefined( team ) )
    {
        fontelem = newteamhudelem( team );
    }
    else if ( isdefined( player ) )
    {
        fontelem = newclienthudelem( player );
    }
    else
    {
        fontelem = newhudelem();
    }
    
    fontelem.elemtype = "font";
    fontelem.font = "default";
    fontelem.fontscale = fontscale;
    fontelem.basefontscale = fontscale;
    fontelem.x = 0;
    fontelem.y = 0;
    fontelem.width = 0;
    fontelem.height = int( level.fontheight * fontscale );
    fontelem.xoffset = 0;
    fontelem.yoffset = 0;
    fontelem.children = [];
    fontelem setparent( level.uiparent );
    fontelem.hidden = 0;
    fontelem.alpha = alpha;
    fontelem setpoint( point, relativepoint, xoffset, yoffset );
    
    if ( isdefined( label ) )
    {
        fontelem.label = label;
    }
    
    if ( isdefined( value ) )
    {
        fontelem setvalue( value );
    }
    
    if ( isdefined( color ) )
    {
        fontelem.color = color;
    }
    
    return fontelem;
}

// Namespace hud_util
// Params 2
// Checksum 0xb66292c, Offset: 0xeb3
// Size: 0xec
function createfontstring( font, fontscale )
{
    fontelem = newclienthudelem( self );
    fontelem.elemtype = "font";
    fontelem.font = font;
    fontelem.fontscale = fontscale;
    fontelem.basefontscale = fontscale;
    fontelem.x = 0;
    fontelem.y = 0;
    fontelem.width = 0;
    fontelem.height = int( level.fontheight * fontscale );
    fontelem.xoffset = 0;
    fontelem.yoffset = 0;
    fontelem.children = [];
    fontelem setparent( level.uiparent );
    fontelem.hidden = 0;
    return fontelem;
}

// Namespace hud_util
// Params 3
// Checksum 0x80999c25, Offset: 0xfa8
// Size: 0x105
function createservertimer( font, fontscale, team )
{
    if ( isdefined( team ) )
    {
        timerelem = newteamhudelem( team );
    }
    else
    {
        timerelem = newhudelem();
    }
    
    timerelem.elemtype = "timer";
    timerelem.font = font;
    timerelem.fontscale = fontscale;
    timerelem.basefontscale = fontscale;
    timerelem.x = 0;
    timerelem.y = 0;
    timerelem.width = 0;
    timerelem.height = int( level.fontheight * fontscale );
    timerelem.xoffset = 0;
    timerelem.yoffset = 0;
    timerelem.children = [];
    timerelem setparent( level.uiparent );
    timerelem.hidden = 0;
    return timerelem;
}

// Namespace hud_util
// Params 2
// Checksum 0x293fae1c, Offset: 0x10b6
// Size: 0xec
function createtimer( font, fontscale )
{
    timerelem = newclienthudelem( self );
    timerelem.elemtype = "timer";
    timerelem.font = font;
    timerelem.fontscale = fontscale;
    timerelem.basefontscale = fontscale;
    timerelem.x = 0;
    timerelem.y = 0;
    timerelem.width = 0;
    timerelem.height = int( level.fontheight * fontscale );
    timerelem.xoffset = 0;
    timerelem.yoffset = 0;
    timerelem.children = [];
    timerelem setparent( level.uiparent );
    timerelem.hidden = 0;
    return timerelem;
}

// Namespace hud_util
// Params 4
// Checksum 0x2d2dc3f0, Offset: 0x11ab
// Size: 0x124
function createicon( shader, width, height, team )
{
    if ( team )
    {
        iconelem = newteamhudelem( team );
    }
    else
    {
        iconelem = newclienthudelem( self );
    }
    
    iconelem.elemtype = "icon";
    iconelem.x = 0;
    iconelem.y = 0;
    iconelem.width = width;
    iconelem.height = height;
    iconelem.basewidth = iconelem.width;
    iconelem.baseheight = iconelem.height;
    iconelem.xoffset = 0;
    iconelem.yoffset = 0;
    iconelem.children = [];
    iconelem setparent( level.uiparent );
    iconelem.hidden = 0;
    
    if ( isdefined( shader ) )
    {
        iconelem setshader( shader, width, height );
        iconelem.shader = shader;
    }
    
    return iconelem;
}

// Namespace hud_util
// Params 5
// Checksum 0xb31fcafc, Offset: 0x12d8
// Size: 0x1ef
function createbar( color, width, height, flashfrac, team )
{
    if ( isdefined( team ) )
    {
        barelem = newteamhudelem( team );
        barelembg = newteamhudelem( team );
    }
    else if ( isplayer( self ) )
    {
        barelem = newclienthudelem( self );
        barelembg = newclienthudelem( self );
    }
    else
    {
        barelem = newhudelem();
        barelembg = newhudelem();
    }
    
    barelem.x = 0;
    barelem.y = 0;
    barelem.frac = 0;
    barelem.color = color;
    barelem.sort = -2;
    barelem.shader = "progress_bar_fill";
    barelem setshader( "progress_bar_fill", width, height );
    barelem.hidden = 0;
    barelem.archived = 0;
    
    if ( isdefined( flashfrac ) )
    {
        barelem.flashfrac = flashfrac;
    }
    
    barelembg.elemtype = "bar";
    barelembg.width = width;
    barelembg.height = height;
    barelembg.xoffset = 0;
    barelembg.yoffset = 0;
    barelembg.bar = barelem;
    barelembg.children = [];
    barelembg.sort = -3;
    barelembg.color = ( 0, 0, 0 );
    barelembg.alpha = 0.5;
    barelembg setparent( level.uiparent );
    barelembg setshader( "progress_bar_bg", width + 4, height + 4 );
    barelembg.hidden = 0;
    barelembg.archived = 0;
    return barelembg;
}

// Namespace hud_util
// Params 0
// Checksum 0x8775a372, Offset: 0x14d0
// Size: 0x81
function getcurrentfraction()
{
    frac = self.bar.frac;
    
    if ( isdefined( self.bar.rateofchange ) )
    {
        frac += ( gettime() - self.bar.lastupdatetime ) * self.bar.rateofchange;
        
        if ( frac > 1 )
        {
            frac = 1;
        }
        
        if ( frac < 0 )
        {
            frac = 0;
        }
    }
    
    return frac;
}

// Namespace hud_util
// Params 2
// Checksum 0x6b66c595, Offset: 0x155a
// Size: 0x98
function createprimaryprogressbar( xoffset, yoffset )
{
    if ( isagent( self ) )
    {
        return;
    }
    
    if ( !isdefined( xoffset ) )
    {
        xoffset = 0;
    }
    
    if ( !isdefined( yoffset ) )
    {
        yoffset = -25;
    }
    
    if ( self issplitscreenplayer() )
    {
        yoffset += 20;
    }
    
    bar = createbar( ( 1, 1, 1 ), level.primaryprogressbarwidth, level.primaryprogressbarheight );
    bar setpoint( "CENTER", undefined, level.primaryprogressbarx + xoffset, level.primaryprogressbary + yoffset );
    return bar;
}

// Namespace hud_util
// Params 3
// Checksum 0x54498f71, Offset: 0x15fb
// Size: 0x96
function function_fd8fe77747c87e17( xoffset, yoffset, color )
{
    if ( isagent( self ) )
    {
        return;
    }
    
    if ( !isdefined( xoffset ) )
    {
        xoffset = 0;
    }
    
    if ( !isdefined( yoffset ) )
    {
        yoffset = -25;
    }
    
    if ( self issplitscreenplayer() )
    {
        yoffset += 20;
    }
    
    bar = createbar( color, level.primaryprogressbarwidth, level.primaryprogressbarheight );
    bar setpoint( "CENTER", undefined, level.primaryprogressbarx + xoffset, level.primaryprogressbary + yoffset );
    return bar;
}

// Namespace hud_util
// Params 4
// Checksum 0x97b61ab8, Offset: 0x169a
// Size: 0x9b
function function_7e77a5e8c4e9e222( xoffset, yoffset, var_f6cda3299eddb2e6, var_d6feefb043cdffd9 )
{
    if ( isagent( self ) )
    {
        return;
    }
    
    if ( !isdefined( xoffset ) )
    {
        xoffset = 0;
    }
    
    if ( !isdefined( yoffset ) )
    {
        yoffset = -25;
    }
    
    if ( self issplitscreenplayer() )
    {
        yoffset += 20;
    }
    
    bar = createbar( ( 1, 1, 1 ), var_f6cda3299eddb2e6, var_d6feefb043cdffd9 );
    bar setpoint( "CENTER", undefined, level.primaryprogressbarx + xoffset, level.primaryprogressbary + yoffset );
    return bar;
}

// Namespace hud_util
// Params 4
// Checksum 0xb4b679aa, Offset: 0x173e
// Size: 0xd2
function createprimaryprogressbartext( xoffset, yoffset, fontsize, usefont )
{
    if ( isagent( self ) )
    {
        return;
    }
    
    if ( !isdefined( xoffset ) )
    {
        xoffset = 0;
    }
    
    if ( !isdefined( yoffset ) )
    {
        yoffset = -25;
    }
    
    if ( self issplitscreenplayer() )
    {
        yoffset += 20;
    }
    
    font_size = level.primaryprogressbarfontsize;
    font = "default";
    
    if ( isdefined( fontsize ) )
    {
        font_size = fontsize;
    }
    
    if ( isdefined( usefont ) )
    {
        font = usefont;
    }
    
    text = createfontstring( font, font_size );
    text setpoint( "CENTER", undefined, level.primaryprogressbartextx + xoffset, level.primaryprogressbartexty + yoffset );
    text.sort = -1;
    return text;
}

// Namespace hud_util
// Params 1
// Checksum 0xc08d27d9, Offset: 0x1819
// Size: 0x22
function setflashfrac( flashfrac )
{
    self.bar.flashfrac = flashfrac;
}

// Namespace hud_util
// Params 0
// Checksum 0xd5c43333, Offset: 0x1843
// Size: 0xbe
function hideelem()
{
    if ( !isdefined( self.hidden ) )
    {
        self.hidden = 0;
    }
    
    if ( self.hidden )
    {
        return;
    }
    
    self.hidden = 1;
    
    if ( self.alpha != 0 )
    {
        self.alpha = 0;
    }
    
    if ( isdefined( self.elemtype ) && ( self.elemtype == "bar" || self.elemtype == "bar_shader" ) )
    {
        self.bar.hidden = 1;
        
        if ( self.bar.alpha != 0 )
        {
            self.bar.alpha = 0;
        }
    }
}

// Namespace hud_util
// Params 0
// Checksum 0xaad8c812, Offset: 0x1909
// Size: 0xce
function showelem()
{
    if ( !self.hidden )
    {
        return;
    }
    
    self.hidden = 0;
    
    if ( isdefined( self.elemtype ) && ( self.elemtype == "bar" || self.elemtype == "bar_shader" ) )
    {
        if ( self.alpha != 0.5 )
        {
            self.alpha = 0.5;
        }
        
        self.bar.hidden = 0;
        
        if ( self.bar.alpha != 1 )
        {
            self.bar.alpha = 1;
        }
        
        return;
    }
    
    if ( self.alpha != 1 )
    {
        self.alpha = 1;
    }
}

// Namespace hud_util
// Params 0
// Checksum 0x413cfdcd, Offset: 0x19df
// Size: 0xbd
function flashthread()
{
    self endon( #"death" );
    
    if ( !self.hidden )
    {
        self.alpha = 1;
    }
    
    while ( true )
    {
        if ( self.frac >= self.flashfrac )
        {
            if ( !self.hidden )
            {
                self fadeovertime( 0.3 );
                self.alpha = 0.2;
                wait 0.35;
                self fadeovertime( 0.3 );
                self.alpha = 1;
            }
            
            wait 0.7;
            continue;
        }
        
        if ( !self.hidden && self.alpha != 1 )
        {
            self.alpha = 1;
        }
        
        wait 0.05;
    }
}

// Namespace hud_util
// Params 0
// Checksum 0xf26be2e1, Offset: 0x1aa4
// Size: 0xce
function destroyelem()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isdefined( self.children ) )
    {
        tempchildren = [];
        
        for ( index = 0; index < self.children.size ; index++ )
        {
            if ( isdefined( self.children[ index ] ) )
            {
                tempchildren[ tempchildren.size ] = self.children[ index ];
            }
        }
        
        for ( index = 0; index < tempchildren.size ; index++ )
        {
            tempchildren[ index ] setparent( getparent() );
        }
    }
    
    if ( self.elemtype === "bar" || self.elemtype === "bar_shader" )
    {
        if ( isdefined( self.bar ) )
        {
            self.bar destroy();
        }
    }
    
    self destroy();
}

// Namespace hud_util
// Params 1
// Checksum 0x785397f2, Offset: 0x1b7a
// Size: 0x31
function seticonshader( shader )
{
    self setshader( shader, self.width, self.height );
    self.shader = shader;
}

// Namespace hud_util
// Params 1
// Checksum 0x9af89602, Offset: 0x1bb3
// Size: 0x15
function geticonshader( shader )
{
    return self.shader;
}

// Namespace hud_util
// Params 2
// Checksum 0x6711ae4c, Offset: 0x1bd1
// Size: 0x39
function seticonsize( width, height )
{
    assert( isdefined( self.shader ) );
    self setshader( self.shader, width, height );
}

// Namespace hud_util
// Params 1
// Checksum 0x8dbba50c, Offset: 0x1c12
// Size: 0x17
function setwidth( width )
{
    self.width = width;
}

// Namespace hud_util
// Params 1
// Checksum 0x9dfd0d56, Offset: 0x1c31
// Size: 0x17
function setheight( height )
{
    self.height = height;
}

// Namespace hud_util
// Params 2
// Checksum 0x9ffe21be, Offset: 0x1c50
// Size: 0x2b
function setsize( width, height )
{
    self.width = width;
    self.height = height;
}

// Namespace hud_util
// Params 1
// Checksum 0xd84bb545, Offset: 0x1c83
// Size: 0x3b
function function_63de19fbe09512d7( scale )
{
    self.fontscale = scale;
    self.basefontscale = scale;
    self.height = int( level.fontheight * scale );
}

// Namespace hud_util
// Params 0
// Checksum 0x4a46e0c1, Offset: 0x1cc6
// Size: 0x70
function updatechildren()
{
    for ( index = 0; index < self.children.size ; index++ )
    {
        child = self.children[ index ];
        child setpoint( child.point, child.relativepoint, child.xoffset, child.yoffset );
    }
}

// Namespace hud_util
// Params 0
// Checksum 0x4131ae48, Offset: 0x1d3e
// Size: 0x9c
function transitionreset()
{
    self.x = self.xoffset;
    self.y = self.yoffset;
    
    if ( self.elemtype == "font" )
    {
        self.fontscale = self.basefontscale;
        self.label = &"";
    }
    else if ( self.elemtype == "icon" )
    {
        self setshader( self.shader, self.width, self.height );
    }
    
    self.alpha = 0;
}

// Namespace hud_util
// Params 1
// Checksum 0x5a7b70c6, Offset: 0x1de2
// Size: 0xb0
function transitionzoomin( duration )
{
    switch ( self.elemtype )
    {
        case #"hash_7d97db7c4e68ac02":
        case #"hash_fb98191526a6d8f0":
            self.fontscale = 6.3;
            self changefontscaleovertime( duration );
            self.fontscale = self.basefontscale;
            break;
        case #"hash_502e6f4e764c2750":
            self setshader( self.shader, self.width * 6, self.height * 6 );
            self scaleovertime( duration, self.width, self.height );
            break;
    }
}

// Namespace hud_util
// Params 2
// Checksum 0xa957232d, Offset: 0x1e9a
// Size: 0x8e
function transitionpulsefxin( intime, duration )
{
    transtime = int( intime ) * 1000;
    showtime = int( duration ) * 1000;
    
    switch ( self.elemtype )
    {
        case #"hash_7d97db7c4e68ac02":
        case #"hash_fb98191526a6d8f0":
            self setpulsefx( transtime + 250, showtime + transtime, transtime + 250 );
            break;
        default:
            break;
    }
}

// Namespace hud_util
// Params 2
// Checksum 0x5bf55987, Offset: 0x1f30
// Size: 0xeb
function transitionslidein( duration, direction = "left" )
{
    switch ( direction )
    {
        case #"hash_c9b3133a17a3b2d0":
            self.x += 1000;
            break;
        case #"hash_96815ce4f2a3dbc5":
            self.x -= 1000;
            break;
        case #"hash_fa3db8f6bd73eb80":
            self.y -= 1000;
            break;
        case #"hash_f91b350a054b6175":
            self.y += 1000;
            break;
    }
    
    self moveovertime( duration );
    self.x = self.xoffset;
    self.y = self.yoffset;
}

// Namespace hud_util
// Params 2
// Checksum 0x829b8c54, Offset: 0x2023
// Size: 0xd8
function transitionslideout( duration, direction = "left" )
{
    gotox = self.xoffset;
    gotoy = self.yoffset;
    
    switch ( direction )
    {
        case #"hash_c9b3133a17a3b2d0":
            gotox += 1000;
            break;
        case #"hash_96815ce4f2a3dbc5":
            gotox -= 1000;
            break;
        case #"hash_fa3db8f6bd73eb80":
            gotoy -= 1000;
            break;
        case #"hash_f91b350a054b6175":
            gotoy += 1000;
            break;
    }
    
    self.alpha = 1;
    self moveovertime( duration );
    self.x = gotox;
    self.y = gotoy;
}

// Namespace hud_util
// Params 1
// Checksum 0x3f084ab8, Offset: 0x2103
// Size: 0x7a
function transitionzoomout( duration )
{
    switch ( self.elemtype )
    {
        case #"hash_7d97db7c4e68ac02":
        case #"hash_fb98191526a6d8f0":
            self changefontscaleovertime( duration );
            self.fontscale = 6.3;
        case #"hash_502e6f4e764c2750":
            self scaleovertime( duration, self.width * 6, self.height * 6 );
            break;
    }
}

// Namespace hud_util
// Params 1
// Checksum 0x7f568d04, Offset: 0x2185
// Size: 0x41
function transitionfadein( duration )
{
    self fadeovertime( duration );
    
    if ( isdefined( self.maxalpha ) )
    {
        self.alpha = self.maxalpha;
        return;
    }
    
    self.alpha = 1;
}

// Namespace hud_util
// Params 1
// Checksum 0xfd2e1f35, Offset: 0x21ce
// Size: 0x1e
function transitionfadeout( duration )
{
    self fadeovertime( duration );
    self.alpha = 0;
}

// Namespace hud_util
// Params 5
// Checksum 0x8968a5ca, Offset: 0x21f4
// Size: 0x112, Type: bool
function function_d69ae82e9a4716aa( player, fadein_duration, show_duration, var_e20ad3346f3833bd, var_10eac31328d17260 )
{
    assert( isplayer( player ) && isdefined( self ) && isdefined( fadein_duration ) && isdefined( show_duration ) && isdefined( var_e20ad3346f3833bd ) );
    result = "";
    premature_end = 0;
    
    if ( fadein_duration )
    {
        self.alpha = 0;
        transitionfadein( fadein_duration );
        result = player utility::waittill_any_timeout( fadein_duration, "death_or_disconnect" );
        premature_end = result != "timeout";
    }
    
    if ( show_duration && !premature_end )
    {
        result = player utility::waittill_any_timeout( show_duration, "death_or_disconnect" );
        premature_end = result != "timeout";
    }
    
    if ( var_e20ad3346f3833bd && !premature_end )
    {
        transitionfadeout( var_e20ad3346f3833bd );
        self.alpha = 0;
        result = player utility::waittill_any_timeout( var_e20ad3346f3833bd, "death_or_disconnect" );
        premature_end = result != "timeout";
    }
    
    if ( var_10eac31328d17260 )
    {
        destroyelem();
    }
    
    return !premature_end;
}

// Namespace hud_util
// Params 1
// Checksum 0x616d2b56, Offset: 0x230f
// Size: 0xb3
function function_cd054751d2d5b5c5( shader = "white" )
{
    var_3711ae4f6887d358 = newclienthudelem( self );
    var_3711ae4f6887d358.x = 0;
    var_3711ae4f6887d358.y = 0;
    var_3711ae4f6887d358.alignx = "left";
    var_3711ae4f6887d358.aligny = "top";
    var_3711ae4f6887d358.sort = 1;
    var_3711ae4f6887d358.horzalign = "fullscreen";
    var_3711ae4f6887d358.vertalign = "fullscreen";
    var_3711ae4f6887d358.foreground = 1;
    var_3711ae4f6887d358 setshader( shader, 640, 480 );
    return var_3711ae4f6887d358;
}

// Namespace hud_util
// Params 1
// Checksum 0x6d18a9fa, Offset: 0x23cb
// Size: 0x14
function debug_iprintln( msg )
{
    self iprintln( msg );
}

// Namespace hud_util
// Params 5
// Checksum 0x96c2ab70, Offset: 0x23e7
// Size: 0x231
function teamplayercardsplash( splash, owner, team, optionalnumber, var_13fc249ff229eeb )
{
    if ( !canshowsplash( splash ) )
    {
        return;
    }
    
    var_13fc249ff229eeb = istrue( var_13fc249ff229eeb );
    
    if ( game_utility::islargebrmap() )
    {
        friendlyplayers = teams::function_d032b36d01bbbab3( owner.team, owner.sessionsquadid );
        
        if ( isdefined( friendlyplayers ) )
        {
            foreach ( player in friendlyplayers )
            {
                if ( !isdefined( player ) || !player::isreallyalive( player ) || namespace_9d8e359c3b1041e5::isplayeringulagsharedfunc() )
                {
                    continue;
                }
                
                if ( var_13fc249ff229eeb && isplayer( owner ) && player == owner )
                {
                    continue;
                }
                
                player thread hud_message::showsplash( splash, optionalnumber, owner );
            }
        }
        
        return;
    }
    
    participantplayers = game_utility_mp::function_4b15b7eb1dc364e7( owner.team );
    
    foreach ( player in participantplayers )
    {
        if ( player iscodcaster() )
        {
            spectatingplayer = player getspectatingplayer();
            
            if ( isdefined( spectatingplayer ) && isdefined( team ) && spectatingplayer.team != team )
            {
                continue;
            }
        }
        else
        {
            if ( !isplayer( player ) )
            {
                continue;
            }
            
            if ( isdefined( team ) && player.team != team )
            {
                continue;
            }
            
            if ( var_13fc249ff229eeb && isplayer( owner ) && player == owner )
            {
                continue;
            }
        }
        
        player thread hud_message::showsplash( splash, optionalnumber, owner );
    }
}

// Namespace hud_util
// Params 8
// Checksum 0x91340e4, Offset: 0x2620
// Size: 0x8b
function function_ddf9cb7f151d8d96( owner, ownersplash, friendlysplash, enemysplash, var_13fc249ff229eeb, var_f89e3dd128718f39, var_db7bc0c2a6467656, var_db88dec2a654ccd5 )
{
    if ( canshowsplash( ownersplash ) && !var_13fc249ff229eeb )
    {
        owner thread hud_message::showsplash( ownersplash, var_f89e3dd128718f39, owner );
    }
    
    level thread hud_message::notifyteam( friendlysplash, enemysplash, owner.team, [ owner ], var_db7bc0c2a6467656, var_db88dec2a654ccd5, owner );
}

// Namespace hud_util
// Params 1
// Checksum 0x79c2fd08, Offset: 0x26b3
// Size: 0xfd
function iskillstreakcalloutsplash( splash )
{
    calloutsplash = 0;
    
    if ( issubstr( splash, "used_" ) )
    {
        strtokarray = strtok( splash, "_" );
        killstreakref = undefined;
        
        foreach ( tok in strtokarray )
        {
            if ( tok == "used" )
            {
                continue;
            }
            
            if ( !isdefined( killstreakref ) )
            {
                killstreakref = tok;
                continue;
            }
            
            killstreakref = killstreakref + "_" + tok;
        }
        
        if ( isdefined( killstreakref ) && isdefined( level.streakglobals.streakbundles[ killstreakref ] ) )
        {
            calloutsplash = 1;
        }
    }
    
    return calloutsplash;
}

// Namespace hud_util
// Params 1
// Checksum 0x16184d01, Offset: 0x27b9
// Size: 0x22, Type: bool
function iseventcalloutsplash( splash )
{
    return !isxhash( splash ) && issubstr( splash, "callout_" );
}

// Namespace hud_util
// Params 1
// Checksum 0xf326360e, Offset: 0x27e4
// Size: 0xc0
function getbaseeventcalloutsplash( splash )
{
    basesplash = undefined;
    var_49d7e8c46da559f8 = strtok( splash, "_" );
    
    foreach ( tok in var_49d7e8c46da559f8 )
    {
        if ( tok == "callout" )
        {
            continue;
        }
        
        if ( !isdefined( basesplash ) )
        {
            basesplash = tok;
            continue;
        }
        
        basesplash = basesplash + "_" + tok;
    }
    
    return basesplash;
}

// Namespace hud_util
// Params 1
// Checksum 0xa05e0691, Offset: 0x28ad
// Size: 0x1b1
function canshowsplash( splash )
{
    if ( level.var_90854497526d85e2 || game_utility::function_d3f8957534dc62af() )
    {
        return 0;
    }
    
    if ( !isdefined( splash ) || splash == "" )
    {
        return 0;
    }
    
    var_bd69e68bc78877c5 = 1;
    
    if ( isbrgamemode() )
    {
        if ( iseventcalloutsplash( splash ) )
        {
            basesplash = getbaseeventcalloutsplash( splash );
            
            if ( isdefined( basesplash ) )
            {
                switch ( basesplash )
                {
                    case #"hash_37c71ce8ac0e2195":
                    case #"hash_44f3835e85deb518":
                    case #"hash_55016d1c29bc8e41":
                    case #"hash_734f5ecda7227872":
                    case #"hash_7e105520842ac343":
                    case #"hash_912fa2cd3f4a5914":
                    case #"hash_cf771f343d6b37bb":
                    case #"hash_dfba1b37885d879e":
                        var_bd69e68bc78877c5 = 0;
                        break;
                }
            }
        }
    }
    else
    {
        switch ( game_utility::getgametype() )
        {
            case #"hash_ca6516c10db2c95":
            case #"hash_7f9c384a34cc392f":
            case #"hash_8f01ce022684fbc8":
                if ( iskillstreakcalloutsplash( splash ) )
                {
                    var_bd69e68bc78877c5 = 0;
                }
                else if ( iseventcalloutsplash( splash ) )
                {
                    basesplash = getbaseeventcalloutsplash( splash );
                    
                    switch ( basesplash )
                    {
                        case #"hash_37c71ce8ac0e2195":
                        case #"hash_44f3835e85deb518":
                        case #"hash_55016d1c29bc8e41":
                        case #"hash_734f5ecda7227872":
                        case #"hash_7e105520842ac343":
                        case #"hash_912fa2cd3f4a5914":
                        case #"hash_cf771f343d6b37bb":
                        case #"hash_dfba1b37885d879e":
                            var_bd69e68bc78877c5 = 0;
                            break;
                    }
                }
                
                break;
        }
    }
    
    return var_bd69e68bc78877c5;
}

// Namespace hud_util
// Params 6
// Checksum 0xb3727171, Offset: 0x2a67
// Size: 0xba
function showsplashtoall( splashname, optionalnumber, playerforplayercard, altdisplayindex, var_4dd30bf63f0b5e8b, splashlistoverride )
{
    foreach ( player in level.players )
    {
        player hud_message::showsplash( splashname, optionalnumber, playerforplayercard, altdisplayindex, var_4dd30bf63f0b5e8b, splashlistoverride );
    }
}

// Namespace hud_util
// Params 8
// Checksum 0xf32ff5b, Offset: 0x2b29
// Size: 0xd6
function function_587cacc589583dd8( splashname, origin, distance, optionalnumber, playerforplayercard, altdisplayindex, var_4dd30bf63f0b5e8b, splashlistoverride )
{
    playersinrange = getplayersinradius( origin, distance );
    
    foreach ( player in playersinrange )
    {
        player hud_message::showsplash( splashname, optionalnumber, playerforplayercard, altdisplayindex, var_4dd30bf63f0b5e8b, splashlistoverride );
    }
}

// Namespace hud_util
// Params 7
// Checksum 0x23d7611, Offset: 0x2c07
// Size: 0xcc
function showsplashtoteam( team, splashname, optionalnumber, playerforplayercard, altdisplayindex, var_4dd30bf63f0b5e8b, splashlistoverride )
{
    foreach ( player in level.teamdata[ team ][ "players" ] )
    {
        player hud_message::showsplash( splashname, optionalnumber, playerforplayercard, altdisplayindex, var_4dd30bf63f0b5e8b, splashlistoverride );
    }
}

// Namespace hud_util
// Params 7
// Checksum 0xd79b889c, Offset: 0x2cdb
// Size: 0xdb
function showsplashtoallexceptteam( team, splashname, optionalnumber, playerforplayercard, altdisplayindex, var_4dd30bf63f0b5e8b, splashlistoverride )
{
    foreach ( player in level.players )
    {
        if ( isdefined( player ) && player.team != team )
        {
            player hud_message::showsplash( splashname, optionalnumber, playerforplayercard, altdisplayindex, var_4dd30bf63f0b5e8b, splashlistoverride );
        }
    }
}

