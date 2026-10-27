// script_7eb3c0a46440cc6c  (hash_7eb3c0a46440cc6c.gscc) (size: 2349 Bytes / 0x92d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x80272518 (2150049048)
// size ...... 2349 (0x92d)
// includes .. 1   (offset: 0x8cd)
// strings ... 0   (offset: 0x8d5)
// dev strs .. 7   (offset: 0x8d5)
// exports ... 7   (offset: 0x5b9)
// cseg ...... 0x58 + 0x561 (0x5b9)
// imports ... 17  (offset: 0x6d1)
// animtree1 . 0   (offset: 0x92d)
// animtree2 . 0   (offset: 0x92d)
#using scripts\mp\hud_util;

#namespace ob_story_mission_dev;

/#

    // Namespace ob_story_mission_dev
    // Params 0, eflags: 0x1
    // Checksum 0xcc9cd3e7, Offset: 0x76
    // Size: 0x15, Type: dev
    function autoexec init()
    {
        setdvarifuninitialized( @"hash_98e62272ddc4c0", 1 );
    }

    // Namespace ob_story_mission_dev/ai_spawn_failure
    // Params 1, eflags: 0x24
    // Checksum 0x8784486a, Offset: 0x93
    // Size: 0x25, Type: dev
    function private event_handler[ai_spawn_failure] function_1b8cb0cca6f600d8( info )
    {
        if ( level.var_b82767ad46340a9f )
        {
            level function_1e23e1e24afa9161( info );
        }
    }

    // Namespace ob_story_mission_dev
    // Params 3, eflags: 0x4
    // Checksum 0xa1094309, Offset: 0xc0
    // Size: 0x12f, Type: dev
    function private function_817c24c6721f2313( font, fontscale, forplayer )
    {
        if ( !isdefined( font ) )
        {
            font = "<dev string:x24>";
        }
        
        if ( !isdefined( fontscale ) )
        {
            fontscale = 1;
        }
        
        if ( !isdefined( forplayer ) )
        {
            forplayer = undefined;
        }
        
        hudelem = undefined;
        
        if ( isplayer( forplayer ) )
        {
            hudelem = newclienthudelem( forplayer );
        }
        else
        {
            hudelem = newhudelem();
        }
        
        hudelem.elemtype = "<dev string:x2c>";
        hudelem.font = font;
        hudelem.fontscale = fontscale;
        hudelem.basefontscale = fontscale;
        hudelem.x = 0;
        hudelem.y = 0;
        hudelem.width = 0;
        hudelem.height = int( level.fontheight * fontscale );
        hudelem.xoffset = 0;
        hudelem.yoffset = 0;
        hudelem.children = [];
        hudelem hud_util::setparent( level.uiparent );
        hudelem.hidden = 0;
        return hudelem;
    }

    // Namespace ob_story_mission_dev
    // Params 0
    // Checksum 0xf956998e, Offset: 0x1f7
    // Size: 0x180, Type: dev
    function function_4e8cfeac80565812()
    {
        self notify( #"hash_7fa7eeb2cc741984" );
        self endon( #"hash_7fa7eeb2cc741984" );
        level.var_b82767ad46340a9f = {};
        level.var_b82767ad46340a9f.failures = [];
        
        while ( true )
        {
            waitframe();
            removetime = gettime() - 30000;
            level.var_b82767ad46340a9f.count = getaicount();
            
            foreach ( time, failure in level.var_b82767ad46340a9f.failures )
            {
                if ( time < removetime )
                {
                    level.var_b82767ad46340a9f.failures[ time ] = undefined;
                }
            }
            
            foreach ( player in level.players )
            {
                player function_76e6ec5c75f85de7();
            }
        }
    }

    // Namespace ob_story_mission_dev
    // Params 1, eflags: 0x4
    // Checksum 0xdafadc93, Offset: 0x37f
    // Size: 0x2a, Type: dev
    function private function_1e23e1e24afa9161( info )
    {
        level.var_b82767ad46340a9f.failures[ gettime() ] = info;
    }

    // Namespace ob_story_mission_dev
    // Params 0, eflags: 0x4
    // Checksum 0x663959c4, Offset: 0x3b1
    // Size: 0x208, Type: dev
    function private function_76e6ec5c75f85de7()
    {
        assert( isplayer( self ) );
        
        if ( !isdefined( self.var_b82767ad46340a9f ) )
        {
            self.var_b82767ad46340a9f = function_817c24c6721f2313( undefined, undefined, self );
        }
        
        if ( !isdefined( self.var_b82767ad46340a9f ) )
        {
            return;
        }
        
        self.var_b82767ad46340a9f.y = 120;
        self.var_42940755ff7eb4ad = int( max( level.var_b82767ad46340a9f.count, self.var_42940755ff7eb4ad ?? 0 ) );
        visible = getdvarint( @"hash_98e62272ddc4c0", 0 ) != 0 && getdvarint( @"debug_hud_disable", 0 ) == 0;
        
        if ( !visible )
        {
            self.var_b82767ad46340a9f setdevtext( "<dev string:x31>" );
            self.var_42940755ff7eb4ad = undefined;
            self.var_deef50808debfa10 = undefined;
            return;
        }
        
        if ( visible && gettime() > ( self.var_deef50808debfa10 ?? 0 ) )
        {
            limit = getmaxagents();
            text = "<dev string:x31>";
            color = ( 1, 1, 1 );
            text = text + "<dev string:x32>" + self.var_42940755ff7eb4ad + "<dev string:x3e>" + limit + "<dev string:x42>";
            
            if ( level.var_b82767ad46340a9f.count >= limit )
            {
                color = ( 1, 1, 0 );
            }
            
            if ( level.var_b82767ad46340a9f.failures.size > 0 )
            {
                text = text + "<dev string:x44>" + level.var_b82767ad46340a9f.failures.size;
                color = ( 1, 0, 0 );
            }
            
            self.var_b82767ad46340a9f.color = color;
            self.var_b82767ad46340a9f setdevtext( text );
            self.var_42940755ff7eb4ad = undefined;
            self.var_deef50808debfa10 = gettime() + 1000;
        }
    }

#/
