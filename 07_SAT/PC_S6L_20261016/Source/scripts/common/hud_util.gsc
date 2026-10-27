// scripts\common\hud_util.gsc  (hash_0663ff1906e9fe70.gscc) (size: 2062 Bytes / 0x80e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x72e461e3 (1927569891)
// size ...... 2062 (0x80e)
// includes .. 0   (offset: 0x7c2)
// strings ... 4   (offset: 0x7c2)
// dev strs .. 2   (offset: 0x7f6)
// exports ... 9   (offset: 0x4f6)
// cseg ...... 0x7e + 0x478 (0x4f6)
// imports ... 12  (offset: 0x65e)
// animtree1 . 0   (offset: 0x80e)
// animtree2 . 0   (offset: 0x80e)
#namespace hud_util;

// Namespace hud_util
// Params 3
// Checksum 0xb455ca7c, Offset: 0x9c
// Size: 0xf3
function create_client_overlay( shader_name, start_alpha, player )
{
    if ( isdefined( player ) )
    {
        overlay = newclienthudelem( player );
    }
    else
    {
        overlay = newhudelem();
    }
    
    overlay.x = 0;
    overlay.y = 0;
    overlay setshader( shader_name, 640, 480 );
    overlay.alignx = "left";
    overlay.aligny = "top";
    overlay.sort = 1;
    overlay.horzalign = "fullscreen";
    overlay.vertalign = "fullscreen";
    overlay.alpha = start_alpha;
    overlay.foreground = 1;
    
    if ( player.var_ef54b223f43655d )
    {
        overlay.scramblerdisabled = 1;
    }
    
    return overlay;
}

// Namespace hud_util
// Params 3
// Checksum 0xef47087b, Offset: 0x198
// Size: 0xb7
function function_a7b5c7ac6074b623( custom_name, shader_name, tint_color )
{
    assert( isplayer( self ), "<dev string:x24>" );
    
    if ( !isdefined( self.overlay ) )
    {
        self.overlay = [];
    }
    
    if ( !isdefined( self.overlay[ custom_name ] ) )
    {
        self.overlay[ custom_name ] = create_client_overlay( shader_name, 0, self );
        self.overlay[ custom_name ].sort = 0;
        self.overlay[ custom_name ].foreground = 1;
    }
    
    self.overlay[ custom_name ].color = tint_color;
}

// Namespace hud_util
// Params 1
// Checksum 0x4e091f, Offset: 0x257
// Size: 0x57
function function_e71c430005379a39( custom_name )
{
    assert( isplayer( self ), "<dev string:x5b>" );
    
    if ( self.overlay && self.overlay[ custom_name ] )
    {
        self.overlay[ custom_name ] destroy();
        self.overlay[ custom_name ] = undefined;
    }
}

// Namespace hud_util
// Params 3
// Checksum 0xd47e31a2, Offset: 0x2b6
// Size: 0x81
function fade_in( time, shader, targetalpha = 0 )
{
    if ( level.missionfailed )
    {
        return;
    }
    
    if ( !isdefined( time ) )
    {
        time = 0.3;
    }
    
    overlay = get_optional_overlay( shader );
    
    if ( !overlay )
    {
        return;
    }
    
    if ( time > 0 )
    {
        overlay fadeovertime( time );
    }
    
    overlay.alpha = targetalpha;
    
    if ( time > 0 )
    {
        wait time;
    }
}

// Namespace hud_util
// Params 1
// Checksum 0xb9fd69ef, Offset: 0x33f
// Size: 0x20
function get_optional_overlay( shader = "black" )
{
    return get_overlay( shader );
}

// Namespace hud_util
// Params 3
// Checksum 0xb67357ac, Offset: 0x368
// Size: 0x75
function fade_out( time = 0.3, shader, targetalpha = 1 )
{
    overlay = get_optional_overlay( shader );
    
    if ( !overlay )
    {
        return;
    }
    
    if ( time > 0 )
    {
        overlay fadeovertime( time );
    }
    
    overlay.alpha = targetalpha;
    
    if ( time > 0 )
    {
        wait time;
    }
}

// Namespace hud_util
// Params 1
// Checksum 0x6bb08567, Offset: 0x3e5
// Size: 0xbf
function get_overlay( shader )
{
    if ( isplayer( self ) )
    {
        guy = self;
    }
    else
    {
        guy = level.player;
    }
    
    if ( !guy )
    {
        return;
    }
    
    if ( !isdefined( guy.overlay ) )
    {
        guy.overlay = [];
    }
    
    if ( !isdefined( guy.overlay[ shader ] ) )
    {
        guy.overlay[ shader ] = create_client_overlay( shader, 0, guy );
    }
    
    guy.overlay[ shader ].sort = 0;
    guy.overlay[ shader ].foreground = 1;
    return guy.overlay[ shader ];
}

// Namespace hud_util
// Params 1
// Checksum 0x22770f55, Offset: 0x4ad
// Size: 0x49
function function_be7e0db0a4ea532( disablescrambler )
{
    if ( isplayer( self ) )
    {
        guy = self;
    }
    else
    {
        guy = level.player;
    }
    
    if ( !guy )
    {
        return;
    }
    
    guy.var_ef54b223f43655d = disablescrambler ?? 1;
}

