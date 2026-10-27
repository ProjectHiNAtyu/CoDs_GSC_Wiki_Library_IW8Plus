// scripts\common\snd\snd_debug.gsc  (hash_522cbfd52a7d0ca3.gscc) (size: 31654 Bytes / 0x7ba6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4e51c134 (1313980724)
// size ...... 31654 (0x7ba6)
// includes .. 6   (offset: 0x73ba)
// strings ... 0   (offset: 0x73ea)
// dev strs .. 131 (offset: 0x73ea)
// exports ... 53  (offset: 0x553e)
// cseg ...... 0x58 + 0x54e6 (0x553e)
// imports ... 163 (offset: 0x5d86)
// animtree1 . 0   (offset: 0x7ba6)
// animtree2 . 0   (offset: 0x7ba6)
#using scripts\common\createfx;
#using scripts\common\devgui;
#using scripts\common\snd\snd;
#using scripts\common\snd\snd_draw;
#using scripts\common\snd\snd_utility;
#using scripts\common\trace;

#namespace snd_debug;

/#

    // Namespace snd_debug
    // Params 0
    // Checksum 0xedd665a4, Offset: 0x76
    // Size: 0x145, Type: dev
    function snd_debug_init()
    {
        assert( isstruct( level.snd ), "<dev string:x24>" );
        level thread _snd_debug_init();
        snd::dvar( @"scr_levelnotify", "<dev string:x3d>", &_scr_levelnotify );
        snd::dvar( @"hash_52b4c8d3c40cfc34", "<dev string:x3d>", &function_86665a4fd8a97917 );
        snd::dvar( @"hash_e5b570e920b9c1fd", "<dev string:x3d>", &function_eafa25dd948e8574 );
        snd::dvar( @"hash_6db29b2f497ade76", "<dev string:x3d>", &function_eafa25dd948e8574 );
        snd::dvar( @"hash_2fa2b5d1e7614a6a", "<dev string:x3d>", &function_f68fde136706618f );
        snd::dvar( @"hash_571a72fc6a9a2647", "<dev string:x3d>", &function_b6f0c59e5f0c137c );
        snd::dvar( @"hash_fcb782f301399045", "<dev string:x3e>", &function_43e05727f7239730 );
        snd::dvar( @"hash_71610eca5056387", "<dev string:x3e>", &function_1be489c84c2399ec );
        snd::dvar( @"hash_46eb4af73fff2413", "<dev string:x3d>", &function_12bfd10e3a26fc86 );
        snd::dvar( @"hash_ba43c6fa400869e0", "<dev string:x3d>", &function_6b726b5284ecf141 );
        snd::dvar( @"hash_843400373f683963", "<dev string:x3e>", &function_79de28ff4dc5c6b8 );
    }

    // Namespace snd_debug
    // Params 1, eflags: 0x4
    // Checksum 0xd0c7a584, Offset: 0x1c3
    // Size: 0xf, Type: dev
    function private function_bfeb7575a70ddb20( var_dafe4dc0a58bbd2c )
    {
        
    }

    // Namespace snd_debug
    // Params 1, eflags: 0x4
    // Checksum 0xb47951f2, Offset: 0x1da
    // Size: 0x88, Type: dev
    function private function_386ba39c13e79145( linenum )
    {
        snd_hud_y = level.snd.debug.hud_y;
        vidresolution = snd::function_5e5cdedbd432d043();
        vidwidth = vidresolution[ 0 ];
        vidheight = vidresolution[ 1 ];
        
        if ( snd_hud_y < 0 )
        {
            snd_hud_y = vidheight + snd_hud_y;
        }
        
        posy = snd_hud_y + 21.3333 * linenum;
        return posy;
    }

    // Namespace snd_debug
    // Params 4, eflags: 0x4
    // Checksum 0xdadc3a37, Offset: 0x26a
    // Size: 0xec, Type: dev
    function private function_4a33b5ce75581e18( xoffset, linenum, text, color )
    {
        snd_hud_x = level.snd.debug.hud_x;
        vidresolution = snd::function_5e5cdedbd432d043();
        vidwidth = vidresolution[ 0 ];
        vidheight = vidresolution[ 1 ];
        
        if ( isdefined( color ) == 0 )
        {
            color = ( 1, 1, 1 );
        }
        
        if ( snd_hud_x < 0 )
        {
            snd_hud_x = vidwidth + snd_hud_x;
        }
        
        snd::function_2e8132539dbcad93( text, snd_hud_x + xoffset, function_386ba39c13e79145( linenum ), 1.33333, "<dev string:x40>", color, 0.854248, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
    }

    // Namespace snd_debug
    // Params 1, eflags: 0x4
    // Checksum 0xdebb40ad, Offset: 0x35e
    // Size: 0xf, Type: dev
    function private function_d795f0a94ed0d1c3( var_dafe4dc0a58bbd2c )
    {
        
    }

    // Namespace snd_debug
    // Params 0, eflags: 0x4
    // Checksum 0x50b0fda8, Offset: 0x375
    // Size: 0x7a, Type: dev
    function private _snd_debug_get_origin()
    {
        origin = undefined;
        
        if ( isdefined( self.origin ) )
        {
            origin = self.origin;
        }
        
        if ( isdefined( self.v ) )
        {
            origin = self.v[ "<dev string:x42>" ];
            self.origin = origin;
            self.var_dbb396cbe14e7e30 = 1;
        }
        
        if ( snd::is_object_invalid( self ) )
        {
            return;
        }
        
        assert( isvector( origin ) );
        return origin;
    }

    // Namespace snd_debug
    // Params 0, eflags: 0x4
    // Checksum 0xd0573e95, Offset: 0x3f7
    // Size: 0x7a, Type: dev
    function private _snd_debug_get_angles()
    {
        angles = undefined;
        
        if ( isdefined( self.angles ) )
        {
            angles = self.angles;
        }
        
        if ( isdefined( self.v ) )
        {
            angles = self.v[ "<dev string:x49>" ];
            self.angles = angles;
            self.var_cfe26b8fca2050b2 = 1;
        }
        
        if ( snd::is_object_invalid( self ) )
        {
            return;
        }
        
        assert( isvector( angles ) );
        return angles;
    }

    // Namespace snd_debug
    // Params 0, eflags: 0x4
    // Checksum 0xafab5eba, Offset: 0x479
    // Size: 0x58, Type: dev
    function private function_af818914637a4967()
    {
        soundalias = "<dev string:x50>";
        
        if ( isdefined( self.v[ "<dev string:x58>" ] ) )
        {
            soundalias = self.v[ "<dev string:x58>" ];
        }
        else if ( isdefined( self.soundalias ) )
        {
            soundalias = self.soundalias;
        }
        
        return soundalias;
    }

    // Namespace snd_debug
    // Params 1, eflags: 0x4
    // Checksum 0xf32c3647, Offset: 0x4d9
    // Size: 0xf, Type: dev
    function private function_f225f209a6cde3b6( var_dafe4dc0a58bbd2c )
    {
        
    }

    // Namespace snd_debug
    // Params 5, eflags: 0x4
    // Checksum 0x73a19553, Offset: 0x4f0
    // Size: 0x268, Type: dev
    function private function_fe9aaa74abb4d927( player, playerview, playerangles, cosfov, maxdistance )
    {
        filterstring = level.snd.debug.filter;
        soundalias = function_af818914637a4967();
        origin = undefined;
        assert( isdefined( soundalias ) );
        isalias3d = 1;
        
        if ( isalias3d == 0 )
        {
            return -1;
        }
        
        if ( filterstring )
        {
            if ( issubstr( soundalias, filterstring ) == 0 )
            {
                return -1;
            }
        }
        
        origin = _snd_debug_get_origin();
        
        if ( isdefined( origin ) == 0 )
        {
            return -1;
        }
        
        deltapos = origin - playerview;
        normal = vectornormalize( deltapos );
        playerforward = anglestoforward( playerangles );
        dot = vectordot( playerforward, normal );
        iswithinfov = dot >= cosfov;
        highlightdot = level.snd.debug.dot;
        
        if ( player.snd.var_59af7b6a1c5ebced == self && isdefined( player.snd.debugcenterdot ) && player.snd.debugcenterdot != dot )
        {
            player.snd.debugcenterdot = dot;
            player.snd.var_59af7b6a1c5ebced = undefined;
        }
        
        if ( dot > highlightdot && ( !isdefined( player.snd.debugcenterdot ) || dot > player.snd.debugcenterdot ) )
        {
            player.snd.debugcenterdot = dot;
            player.snd.var_59af7b6a1c5ebced = self;
        }
        
        if ( iswithinfov == 0 )
        {
            return -1;
        }
        
        dist_squared = distancesquared( playerview, origin );
        
        if ( dist_squared < 2 )
        {
            return -1;
        }
        
        maxdistancesquared = squared( maxdistance );
        
        if ( maxdistancesquared > 0 && maxdistancesquared < dist_squared )
        {
            return -1;
        }
        
        return dist_squared;
    }

    // Namespace snd_debug
    // Params 2
    // Checksum 0xe90ac86c, Offset: 0x760
    // Size: 0xb2, Type: dev
    function function_22d3250af7a27e69( array, var_3008e9bb66e3ada1 )
    {
        newarray = [];
        
        foreach ( i, item in array )
        {
            if ( snd::is_object_invalid( item ) )
            {
                continue;
            }
            
            if ( var_3008e9bb66e3ada1 )
            {
                newarray[ i ] = item;
                continue;
            }
            
            newarray[ newarray.size ] = item;
        }
        
        return newarray;
    }

    // Namespace snd_debug
    // Params 7, eflags: 0x4
    // Checksum 0xd09b5844, Offset: 0x81a
    // Size: 0x171, Type: dev
    function private function_9e1117a34984fe77( visiblesndents, array, player, playerview, playerangles, cosfov, maxdistance )
    {
        playerforward = anglestoforward( playerangles );
        playerfov = player snd::getplayerfov();
        visible = [];
        array = function_22d3250af7a27e69( array );
        assert( isarray( visiblesndents ) );
        
        if ( isarray( array ) && array.size > 0 )
        {
            visible = snd::function_51d82def583d96a( array, playerview, playerforward, playerfov, maxdistance );
            visiblesndents = arraycombine( visiblesndents, visible );
        }
        
        filterstring = level.snd.debug.filter;
        
        if ( filterstring )
        {
            foreach ( ent in visiblesndents )
            {
                soundalias = ent function_af818914637a4967();
                
                if ( issubstr( soundalias, filterstring ) )
                {
                    visiblesndents = arrayremove( visiblesndents, ent );
                }
            }
        }
        
        return visiblesndents;
    }

    // Namespace snd_debug
    // Params 2, eflags: 0x4
    // Checksum 0x21c16c3d, Offset: 0x993
    // Size: 0x14a, Type: dev
    function private function_8c32966046cc735b( player, scr_snddebug )
    {
        maxdistance = level.snd.debug.distance_max;
        maxdistance = maxdistance <= 0 ? 262144 : maxdistance;
        visiblesndents = [];
        assert( isdefined( player ) );
        assert( isdefined( scr_snddebug ) );
        playerview = player snd::getplayervieworigin();
        playerangles = player snd::getplayerviewangles();
        fov = player snd::getplayerfov();
        cosfov = cos( fov );
        
        if ( isdefined( level.snd.createfxent ) && scr_snddebug >= 3 )
        {
            visiblesndents = function_9e1117a34984fe77( visiblesndents, level.snd.createfxent, player, playerview, playerangles, cosfov, maxdistance );
        }
        
        if ( isdefined( level.snd ) && isdefined( level.snd.objects ) )
        {
            visiblesndents = function_9e1117a34984fe77( visiblesndents, level.snd.objects, player, playerview, playerangles, cosfov, maxdistance );
        }
        
        return visiblesndents;
    }

    // Namespace snd_debug
    // Params 1, eflags: 0x4
    // Checksum 0x96d7af93, Offset: 0xae5
    // Size: 0xf, Type: dev
    function private function_73fad679dd14e18c( var_dafe4dc0a58bbd2c )
    {
        
    }

    // Namespace snd_debug
    // Params 0, eflags: 0x4
    // Checksum 0x7984cbd1, Offset: 0xafc
    // Size: 0x26c, Type: dev
    function private function_be5bc2b4395f2e39()
    {
        origin = _snd_debug_get_origin();
        angles = _snd_debug_get_angles();
        soundalias = function_af818914637a4967();
        defaultradius = level.snd.debug.dist_radius;
        radius = defaultradius;
        minradiusunknown = 0;
        angle = undefined;
        
        if ( isdefined( self.angles ) )
        {
            angles = self.angles;
        }
        
        if ( soundalias != "<dev string:x50>" )
        {
            angle = snd::function_446279deaf2f09f6( soundalias, "<dev string:x63>" );
            dist_min = snd::function_4f80a4872306be7c( soundalias, "<dev string:x71>" );
            
            if ( dist_min > 0 )
            {
                radius = dist_min;
            }
            else
            {
                minradiusunknown = 1;
            }
        }
        
        var_1f9df6bd1c6cc298 = 0;
        
        foreach ( player in snd::getplayerssafe() )
        {
            playerview = player snd::getplayervieworigin();
            var_1f9df6bd1c6cc298 = snd::function_ae9898408a0c789a( playerview, origin, radius );
            
            if ( var_1f9df6bd1c6cc298 == 1 )
            {
                radius = defaultradius;
                break;
            }
        }
        
        colorscale = level.snd.debug.color_scale;
        color = snd::vectorscale( ( 1, 1, 1 ), colorscale );
        line_alpha = 0.72974;
        
        if ( angle > 0 )
        {
            half_radius = radius * 0.5;
            arrow_length = 2 + radius * 2 - half_radius;
            snd::debugarrow( origin, angles, arrow_length, half_radius, ( 1, 1, 1 ), line_alpha );
        }
        
        snd::debugcrosshair( origin, radius * 2, angles, ( 1, 1, 1 ), line_alpha );
        
        if ( var_1f9df6bd1c6cc298 == 1 || minradiusunknown == 1 )
        {
            snd::cube( origin, angles, radius, color, line_alpha, 0, 1 );
            return;
        }
        
        sphere( origin, radius, color, 0, 1 );
    }

    // Namespace snd_debug
    // Params 3, eflags: 0x4
    // Checksum 0x9b225eb7, Offset: 0xd70
    // Size: 0x184, Type: dev
    function private function_995c8182045e9f11( player, visiblesndents, scr_snddebug )
    {
        if ( isdefined( player.snd ) && isdefined( player.snd.var_59af7b6a1c5ebced ) )
        {
            return player.snd.var_59af7b6a1c5ebced;
        }
        
        crosshairradius = level.snd.debug.xhair_radius;
        fov = player snd::getplayerfov();
        playerview = player snd::getplayervieworigin();
        playerangles = player snd::getplayerviewangles();
        playerforward = anglestoforward( playerangles );
        highlightdot = level.snd.debug.dot;
        reticleentdot = 0;
        reticleent = undefined;
        visiblesndent = snd::function_f1c888429fdb949f( playerview, playerforward, visiblesndents );
        
        if ( isdefined( visiblesndent ) )
        {
            origin = visiblesndent _snd_debug_get_origin();
            deltapos = origin - playerview;
            normal = vectornormalize( deltapos );
            dot = vectordot( playerforward, normal );
            
            if ( dot > highlightdot && dot > reticleentdot )
            {
                reticleentdot = dot;
                reticleent = visiblesndent;
            }
        }
        
        return reticleent;
    }

    // Namespace snd_debug
    // Params 2, eflags: 0x4
    // Checksum 0x95c394ae, Offset: 0xefc
    // Size: 0x46d, Type: dev
    function private function_d934ff3e57aedb6b( player, scr_snddebug )
    {
        audiocolor = level.snd.debug.color_3d;
        colorscale = level.snd.debug.color_scale;
        selectioncolor = snd::function_69dc1ffd54edd65c( audiocolor, colorscale * 10 );
        fov = player snd::getplayerfov();
        origin = _snd_debug_get_origin();
        soundalias = function_af818914637a4967();
        radiusmin = "<dev string:x7a>";
        radiusmax = "<dev string:x7a>";
        assert( isdefined( player ) );
        playerview = player snd::getplayervieworigin();
        playerangles = player snd::getplayerviewangles();
        playerright = anglestoright( playerangles );
        
        if ( soundalias != "<dev string:x50>" )
        {
            dist_min = snd::function_4f80a4872306be7c( soundalias, "<dev string:x71>" );
            dist_max = snd::function_4f5d928722e04f2e( soundalias, "<dev string:x7c>" );
            
            if ( dist_min > 0 )
            {
                radiusmin = dist_min;
            }
            
            if ( dist_max > 0 )
            {
                radiusmax = dist_max;
            }
        }
        
        if ( isdefined( soundalias ) )
        {
            debugscale = level.snd.debug.scale_3d;
            dist = distance( origin, playerview );
            alpha = 1;
            alphasq = alpha * alpha;
            
            if ( isnumber( radiusmin ) && radiusmin > 0 && isnumber( radiusmax ) && radiusmax > 0 )
            {
                safetymax = 0;
                
                if ( radiusmin == radiusmax )
                {
                    safetymax = 0.001;
                }
                
                mapfloat( radiusmin, radiusmax + safetymax, 1, 0.5, dist );
            }
            
            fixeddistscalar = dist * 0.00133333;
            snd::print3dplus( soundalias, origin + ( 0, 0, -1.666 * fixeddistscalar * debugscale * 16 ), -1.666 * debugscale, "<dev string:x85>", selectioncolor, alpha, ( 0, 0, 0 ), alphasq, ( 1, 1, 1 ), alphasq, 1 );
            detail_text = "<dev string:x3d>";
            
            if ( level.snd.is_server_script )
            {
                detail_text = "<dev string:x8c>";
            }
            
            if ( level.snd.is_client_script )
            {
                detail_text = "<dev string:x93>";
            }
            
            if ( level.snd.debug.var_ba6233a13d1fb6cf )
            {
                var_fede4e39a017516a = isstring( radiusmin ) ? radiusmin : 0.0254 * radiusmin;
                var_faf35c45d8aef524 = isstring( radiusmax ) ? radiusmax : 0.0254 * radiusmax;
                var_eddf6c1ce2ee0c60 = isstring( dist ) ? dist : 0.0254 * dist;
                detail_text += "<dev string:x9a>" + snd::printdecimalcount( var_fede4e39a017516a ) + "<dev string:xa2>" + snd::printdecimalcount( var_eddf6c1ce2ee0c60 ) + "<dev string:xa2>" + snd::printdecimalcount( var_faf35c45d8aef524 ) + "<dev string:xa7>";
            }
            else
            {
                detail_text += "<dev string:x9a>" + snd::printdecimalcount( radiusmin ) + "<dev string:xa9>" + snd::printdecimalcount( dist ) + "<dev string:xa9>" + snd::printdecimalcount( radiusmax );
            }
            
            snd::print3dplus( detail_text, origin + ( 0, 0, -2.666 * fixeddistscalar * debugscale * 16 ), -1.333 * debugscale, "<dev string:x85>", selectioncolor, alpha, ( 0, 0, 0 ), alphasq, ( 1, 1, 1 ), alphasq, 1 );
        }
        
        if ( isnumber( radiusmax ) && radiusmax > 0 )
        {
            color = snd::vectorscale( selectioncolor, 1 );
            line_alpha = 1;
            angles = _snd_debug_get_angles();
            snd::debugcrosshair( origin, radiusmax * 2, angles, color, line_alpha );
            snd::linesphere( origin, radiusmax, snd::vectorscale( selectioncolor, 0.72974 ), line_alpha, 0, 1 );
        }
    }

    // Namespace snd_debug
    // Params 1, eflags: 0x4
    // Checksum 0x78c0e6d8, Offset: 0x1371
    // Size: 0x668, Type: dev
    function private function_26b6990e81885b97( scr_snddebug )
    {
        if ( scr_snddebug <= 1 )
        {
            return;
        }
        
        players = snd::getplayerssafe();
        level.snd.debug.visiblesndobjs = [];
        
        foreach ( player in players )
        {
            var_f58bbed5d7db1694 = [];
            var_f58bbed5d7db1694 = function_8c32966046cc735b( player, scr_snddebug );
            level.snd.debug.visiblesndobjs = arraycombineunique( level.snd.debug.visiblesndobjs, var_f58bbed5d7db1694 );
        }
        
        drawlimit = level.snd.debug.draw_limit;
        var_181ec128ffff18d8 = 0;
        
        if ( drawlimit > 0 && level.snd.debug.visiblesndobjs.size >= drawlimit )
        {
            allplayersviews = [];
            
            foreach ( player in players )
            {
                allplayersviews[ allplayersviews.size ] = player snd::getplayervieworigin();
            }
            
            var_b3095c995ecd792c = snd::vectoraverage( allplayersviews );
            level.snd.debug.visiblesndobjs = sortbydistance( level.snd.debug.visiblesndobjs, var_b3095c995ecd792c );
            
            if ( !isarray( level.snd.debug.visiblesndobjs ) )
            {
                level.snd.debug.visiblesndobjs = [];
            }
            
            foreach ( ent in level.snd.debug.visiblesndobjs )
            {
                if ( isdefined( ent.var_dbb396cbe14e7e30 ) )
                {
                    ent.origin = undefined;
                    ent.var_dbb396cbe14e7e30 = undefined;
                }
            }
        }
        
        level.snd.debug.visiblesndobjs = function_22d3250af7a27e69( level.snd.debug.visiblesndobjs );
        
        foreach ( visiblesndent in level.snd.debug.visiblesndobjs )
        {
            if ( drawlimit > 0 && var_181ec128ffff18d8 >= drawlimit )
            {
                function_4a33b5ce75581e18( 520, 2, "<dev string:xad>" + drawlimit + "<dev string:xb1>", ( 1, 0, 0 ) );
                break;
            }
            
            visiblesndent function_be5bc2b4395f2e39();
            var_181ec128ffff18d8 += 1;
        }
        
        var_946cf11e0d1cb42a = [];
        
        foreach ( player in players )
        {
            var_21b23b00f679755d = function_995c8182045e9f11( player, level.snd.debug.visiblesndobjs, scr_snddebug );
            
            if ( isdefined( var_946cf11e0d1cb42a ) && isdefined( var_21b23b00f679755d ) )
            {
                var_21b23b00f679755d function_d934ff3e57aedb6b( player, scr_snddebug );
                var_946cf11e0d1cb42a[ var_946cf11e0d1cb42a.size ] = var_21b23b00f679755d;
                var_181ec128ffff18d8 += 1;
            }
        }
        
        if ( level.snd.debug.draw_ai )
        {
            foreach ( player in players )
            {
                playervieworg = player snd::getplayervieworigin();
                playerangles = player snd::getplayerviewangles();
                playerforward = anglestoforward( playerangles );
                playerfov = player snd::getplayerfov();
                all_ai = getaiarray();
                visible_ai = snd::function_51d82def583d96a( all_ai, playervieworg, playerforward, playerfov );
                
                foreach ( ent in visible_ai )
                {
                    alertlevel = snd::function_c90113f46cd1abe8( ent );
                    state_color = snd::function_c8c5f9c0ee8f80c0( alertlevel );
                    snd::function_1ad7983cd9ca1761( ent.origin, alertlevel, state_color );
                }
            }
        }
    }

    // Namespace snd_debug
    // Params 1, eflags: 0x4
    // Checksum 0x44c045e7, Offset: 0x19e1
    // Size: 0xf, Type: dev
    function private function_2a8b39f79c5afdaf( var_dafe4dc0a58bbd2c )
    {
        
    }

    // Namespace snd_debug
    // Params 1, eflags: 0x4
    // Checksum 0xaf98edad, Offset: 0x19f8
    // Size: 0x7af, Type: dev
    function private function_2cce9d52cace3143( scr_snddebug )
    {
        filterstring = level.snd.debug.filter;
        var_1763ca805594e060 = 0;
        var_6ebca97bca1bbe79 = 0;
        sndentcount = 0;
        sndentvisiblestring = "<dev string:x3d>";
        sndentfilterstring = "<dev string:x3d>";
        sndparamcount = 0;
        
        if ( isdefined( level.snd.createfxent ) )
        {
            assert( isdefined( level.snd.createfxloopcount ) );
            assert( isdefined( level.snd.var_48b9a5697e99fb24 ) );
            var_1763ca805594e060 = level.snd.createfxloopcount;
            var_6ebca97bca1bbe79 = level.snd.var_48b9a5697e99fb24;
        }
        
        if ( isdefined( level.snd ) && isdefined( level.snd.objects ) )
        {
            sndentcount = level.snd.objects.size;
        }
        
        if ( level.snd.debug.visiblesndobjs.size > 0 && scr_snddebug >= 3 )
        {
            sndentvisiblestring += "<dev string:xbd>" + level.snd.debug.visiblesndobjs.size + "<dev string:xc0>";
        }
        
        if ( filterstring )
        {
            sndentfilterstring += "<dev string:xca>" + filterstring + "<dev string:xca>";
        }
        
        if ( isdefined( level.snd.param_ents ) )
        {
            sndparamcount = level.snd.param_ents.size;
        }
        
        row = -3;
        
        if ( level.snd.is_server_script )
        {
            mapname = tolower( level.script );
            mapname = snd::function_bb82f32186a9b8a( mapname, 24 );
            function_4a33b5ce75581e18( 0, row, mapname );
        }
        
        row = -2;
        
        if ( level.snd.is_server_script )
        {
            start = snd::function_7fde87582259c071();
            
            if ( !isstring( start ) || start == "<dev string:x3d>" )
            {
                start = "<dev string:xcc>";
            }
            
            start = snd::function_bb82f32186a9b8a( start, 24 );
            function_4a33b5ce75581e18( 0, row, start );
        }
        
        row = -1;
        
        if ( level.snd.is_client_script )
        {
            player = snd::getplayerssafe()[ 0 ];
            trigger = player.snd.trigger;
            trigger_name = trigger.script_ambientroom ?? "<dev string:xd7>";
            trigger_name = snd::function_bb82f32186a9b8a( trigger_name, 24 );
            function_4a33b5ce75581e18( 0, row, trigger_name );
        }
        
        row = 0;
        
        if ( level.snd.is_server_script )
        {
            function_4a33b5ce75581e18( 0, row, "<dev string:xe0>" + sndentcount );
        }
        
        row++;
        
        if ( level.snd.is_client_script )
        {
            function_4a33b5ce75581e18( 0, row, "<dev string:xfb>" + sndentcount );
            row++;
        }
        
        function_4a33b5ce75581e18( 0, row, "<dev string:x116>" + sndparamcount );
        row++;
        
        if ( scr_snddebug >= 3 )
        {
            visiblestring = "<dev string:x3d>";
            
            if ( level.snd.debug.visiblesndobjs.size > 0 )
            {
                visiblestring += level.snd.debug.visiblesndobjs.size;
            }
            else
            {
                visiblestring += "<dev string:x3e>";
            }
            
            if ( filterstring )
            {
                visiblestring += "<dev string:xbd>" + sndentfilterstring + "<dev string:x131>";
            }
            
            function_4a33b5ce75581e18( 0, row, "<dev string:x133>" + visiblestring );
            row++;
        }
        
        if ( level.snd.debug.draw_ai )
        {
            attacker_count = snd::function_be8701d28e71efbd( level.players );
            threat = 0;
            
            foreach ( player in level.players )
            {
                if ( isplayer( player ) )
                {
                    player_threat = getstealthmaxthreat( player );
                    
                    if ( player_threat > threat )
                    {
                        threat = player_threat;
                    }
                }
            }
            
            state = "<dev string:x14e>";
            squad = snd::function_c0c0d18177bbad02( level.players[ 0 ] );
            
            if ( snd::issquad( squad ) && isstruct( squad.snd ) && isstring( squad.snd.ai_state ) )
            {
                state = squad.snd.ai_state;
            }
            else if ( attacker_count > 0 )
            {
                state = "<dev string:x153>";
            }
            
            scale = 2;
            alpha = 1;
            threat_color = snd::function_25592a59fb9de67c( threat );
            state_color = snd::function_38325378bdc09e81( state );
            threat = snd::printdecimalcount( threat, 4 );
            ai_count = getaiarray().size;
            
            if ( attacker_count != ai_count )
            {
                var_9da492ca9f003438 = "<dev string:x3d>" + ai_count.size;
                var_9da492ca9f003438 = max( var_9da492ca9f003438, 2 );
                ai_count = snd::function_bb82f32186a9b8a( attacker_count, var_9da492ca9f003438 ) + "<dev string:xa9>" + snd::function_bb82f32186a9b8a( ai_count, var_9da492ca9f003438 );
            }
            
            snd::function_2e8132539dbcad93( "<dev string:x15a>", 240, 48, scale, "<dev string:x40>", ( 0.72974, 0.72974, 0.72974 ), alpha, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            snd::function_2e8132539dbcad93( "<dev string:x165>", 240, 80, scale, "<dev string:x40>", ( 0.72974, 0.72974, 0.72974 ), alpha, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            snd::function_2e8132539dbcad93( "<dev string:x170>", 240, 112, scale, "<dev string:x40>", ( 0.72974, 0.72974, 0.72974 ), alpha, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            snd::function_2e8132539dbcad93( "<dev string:x17b>" + threat, 240, 48, scale, "<dev string:x40>", threat_color, alpha, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            snd::function_2e8132539dbcad93( "<dev string:x17b>" + state, 240, 80, scale, "<dev string:x40>", state_color, alpha, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            snd::function_2e8132539dbcad93( "<dev string:x17b>" + ai_count, 240, 112, scale, "<dev string:x40>", ( 1, 1, 1 ), alpha, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
        }
    }

    // Namespace snd_debug
    // Params 1, eflags: 0x4
    // Checksum 0x6639bb7e, Offset: 0x21af
    // Size: 0x277, Type: dev
    function private function_c898a5192fe56c78( scr_snddebug )
    {
        aspect = 0.75;
        crosshair = level.snd.debug.xhair;
        crosshairalpha = level.snd.debug.xhair_alpha;
        crosshairradius = level.snd.debug.xhair_radius;
        
        if ( crosshair != 0 && isdefined( level.snd.debug.xhair_hudelem ) == 0 )
        {
            hud = newhudelem();
            hud.x = 320;
            hud.y = 240;
            hud.alignx = "<dev string:x85>";
            hud.aligny = "<dev string:x186>";
            hud.horzalign = "<dev string:x18d>";
            hud.vertalign = "<dev string:x18d>";
            hud.foreground = 1;
            hud.sort = 1;
            level.snd.debug.xhair_hudelem = hud;
        }
        
        if ( crosshair != 0 && isdefined( level.snd.debug.xhair_hudelem ) && "<dev string:x198>" != "<dev string:x3d>" )
        {
            level.snd.debug.xhair_hudelem setshader( "<dev string:x198>", int( crosshairradius * 2 * aspect ), int( crosshairradius * 2 ) );
            level.snd.debug.xhair_hudelem.alpha = crosshairalpha;
        }
        
        if ( crosshair == 0 && isdefined( level.snd.debug.xhair_hudelem ) )
        {
            level.snd.debug.xhair_hudelem destroy();
            level.snd.debug.xhair_hudelem = undefined;
        }
    }

    // Namespace snd_debug
    // Params 1, eflags: 0x4
    // Checksum 0x5577cf8c, Offset: 0x242e
    // Size: 0xf, Type: dev
    function private function_b5fce98e65d4a038( var_dafe4dc0a58bbd2c )
    {
        
    }

    // Namespace snd_debug
    // Params 1, eflags: 0x4
    // Checksum 0x76c9a555, Offset: 0x2445
    // Size: 0x1ec, Type: dev
    function private function_f1317df051ebb057( scr_snddebug )
    {
        if ( scr_snddebug < 1 )
        {
            return;
        }
        
        if ( getdvar( @"createfx" ) != "<dev string:x19e>" )
        {
            if ( level.snd.createfxent.size > 0 )
            {
                return;
            }
        }
        else
        {
            while ( isdefined( level.createfx ) == 0 )
            {
                waitframe();
            }
        }
        
        while ( isdefined( level.createfxent ) == 0 )
        {
            waitframe();
        }
        
        level.snd.createfxent = [];
        level.snd.createfxloopcount = 0;
        level.snd.var_48b9a5697e99fb24 = 0;
        
        foreach ( ent in level.createfxent )
        {
            if ( isdefined( ent.v[ "<dev string:x1a1>" ] ) == 0 )
            {
                continue;
            }
            
            if ( ent.v[ "<dev string:x1a1>" ] == "<dev string:x1a6>" )
            {
                level.snd.createfxloopcount++;
                level.snd.createfxent[ level.snd.createfxent.size ] = ent;
            }
            
            if ( ent.v[ "<dev string:x1a1>" ] == "<dev string:x1ae>" )
            {
                level.snd.var_48b9a5697e99fb24++;
                level.snd.createfxent[ level.snd.createfxent.size ] = ent;
            }
        }
    }

    // Namespace snd_debug
    // Params 2, eflags: 0x4
    // Checksum 0x29bfc91, Offset: 0x2639
    // Size: 0x475, Type: dev
    function private _scr_snddebug( key, value )
    {
        var_aae4d96bc8e20b1e = isdefined( key );
        var_bfb41b809bc328d9 = isdefined( value );
        
        if ( snd::condition_alert( !var_aae4d96bc8e20b1e, "<dev string:x1bf>" ) )
        {
            return;
        }
        
        if ( snd::condition_alert( !var_bfb41b809bc328d9, "<dev string:x1d9>" ) )
        {
            return;
        }
        
        if ( key == @"scr_snddebug" )
        {
            level.snd.debug.debuglevel = int( value );
            
            if ( level.snd.debug.debuglevel == 0 )
            {
                level notify( #"snd_debug_end" );
            }
            else
            {
                level thread _snd_debug_main();
            }
        }
        else if ( key == @"scr_snddebugfilter" )
        {
            level.snd.debug.filter = string( value );
        }
        else if ( key == @"hash_8f80f3ca72788192" )
        {
            level.snd.debug.hud_x = int( value );
        }
        else if ( key == @"hash_8f80f4ca727883c5" )
        {
            level.snd.debug.hud_y = int( value );
        }
        else if ( key == @"scr_snddebugradius" )
        {
            level.snd.debug.dist_radius = int( value );
        }
        else if ( key == @"hash_13a1898b461126f" )
        {
            level.snd.debug.var_ba6233a13d1fb6cf = int( value );
        }
        else if ( key == @"scr_snddebugscale" )
        {
            level.snd.debug.scale_3d = float( value );
        }
        else if ( key == @"scr_snddebugcolor" )
        {
            if ( isstring( value ) )
            {
            }
            else if ( isvector( value ) )
            {
                level.snd.debug.color_3d = value;
            }
        }
        else if ( key == @"hash_2a753b30a1212892" )
        {
            level.snd.debug.color_scale = float( value );
        }
        else if ( key == @"hash_fb5f3970d2e3bfdb" )
        {
            level.snd.debug.defer_msec = int( value );
        }
        else if ( key == @"scr_snddebugdistance" )
        {
            level.snd.debug.distance_max = int( value );
        }
        else if ( key == @"scr_snddebugdot" )
        {
            level.snd.debug.dot = float( value );
        }
        else if ( key == @"hash_9675532686541235" )
        {
            level.snd.debug.draw_ai = int( value );
        }
        else if ( key == @"hash_33175192ed572d96" )
        {
            level.snd.debug.draw_limit = int( value );
        }
        else if ( key == @"scr_snddebugcrosshair" )
        {
            level.snd.debug.xhair = int( value );
        }
        else if ( key == @"hash_abd89601b7f5878d" )
        {
            level.snd.debug.xhair_alpha = float( value );
        }
        else if ( key == @"hash_e307089961790a19" )
        {
            level.snd.debug.xhair_radius = int( value );
        }
        else if ( key == @"scr_snddebugnuke" )
        {
            level.snd.debug.nuke_msec = int( value );
            function_71a0152560066d18();
        }
        
        return value;
    }

    // Namespace snd_debug
    // Params 0, eflags: 0x4
    // Checksum 0x945170a0, Offset: 0x2ab6
    // Size: 0x4f, Type: dev
    function private _snd_debug_is_initialized()
    {
        if ( isdefined( level.snd ) && isdefined( level.snd.debug ) && level.snd.debug.initialized )
        {
            return 1;
        }
        
        return 0;
    }

    // Namespace snd_debug
    // Params 0, eflags: 0x4
    // Checksum 0x68e6ede2, Offset: 0x2b0d
    // Size: 0x14, Type: dev
    function private _snd_debug_wait_init()
    {
        while ( _snd_debug_is_initialized() == 0 )
        {
            waitframe();
        }
    }

    // Namespace snd_debug
    // Params 1, eflags: 0x4
    // Checksum 0xe50b9ec, Offset: 0x2b29
    // Size: 0x18, Type: dev
    function private function_55d2aa3fc06ffd9( text )
    {
        devgui::add_debug_command( text );
    }

    // Namespace snd_debug
    // Params 2, eflags: 0x4
    // Checksum 0x1554fd51, Offset: 0x2b49
    // Size: 0x3e, Type: dev
    function private function_491403de7281e813( menu, submenu )
    {
        var_4da32c45405dd7e7 = menu + "<dev string:x1f5>" + submenu + "<dev string:x1f5>";
        devgui::function_9082edeb5db93280( var_4da32c45405dd7e7 );
    }

    // Namespace snd_debug
    // Params 3, eflags: 0x4
    // Checksum 0x745d223f, Offset: 0x2b8f
    // Size: 0x2c, Type: dev
    function private function_957bdafe1a213047( menu_item, dvar, index )
    {
        devgui::add_devgui_dvar( menu_item, dvar, index );
    }

    // Namespace snd_debug
    // Params 0, eflags: 0x4
    // Checksum 0x81fd0da2, Offset: 0x2bc3
    // Size: 0xc, Type: dev
    function private function_7f5bdf2d5e2ac52b()
    {
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace snd_debug
    // Params 0, eflags: 0x4
    // Checksum 0x7e1a51bc, Offset: 0x2bd7
    // Size: 0xab1, Type: dev
    function private _snd_debug_init()
    {
        if ( _snd_debug_is_initialized() )
        {
            return;
        }
        
        if ( "<dev string:x198>" != "<dev string:x3d>" )
        {
            precacheshader( "<dev string:x198>" );
        }
        
        hudx = -320;
        hudy = -128;
        
        if ( level.pc )
        {
            hudx = -320;
            hudy = -128;
        }
        
        level.snd.debug = spawnstruct();
        level.snd.debug.debuglevel = getdvarint( @"scr_snddebug", 0 );
        level.snd.debug.filter = getdvar( @"scr_snddebugfilter", "<dev string:x3d>" );
        level.snd.debug.hud_x = getdvarint( @"hash_8f80f3ca72788192", hudx );
        level.snd.debug.hud_y = getdvarint( @"hash_8f80f4ca727883c5", hudy );
        level.snd.debug.dist_radius = getdvarint( @"scr_snddebugradius", 12 );
        level.snd.debug.var_ba6233a13d1fb6cf = getdvarint( @"hash_13a1898b461126f", 0 );
        level.snd.debug.scale_3d = getdvarfloat( @"scr_snddebugscale", 1 );
        level.snd.debug.color_3d = getdvarvector( @"scr_snddebugcolor", ( 0.5, 1, 0.666 ) );
        level.snd.debug.color_scale = getdvarfloat( @"hash_2a753b30a1212892", 0.72974 );
        level.snd.debug.defer_msec = getdvarint( @"hash_fb5f3970d2e3bfdb", 5 );
        level.snd.debug.distance_max = getdvarint( @"scr_snddebugdistance", 0 );
        level.snd.debug.dot = getdvarfloat( @"scr_snddebugdot", 0.99 );
        level.snd.debug.draw_ai = getdvarint( @"hash_9675532686541235", 0 );
        level.snd.debug.draw_limit = getdvarint( @"hash_33175192ed572d96", 0 );
        level.snd.debug.xhair = getdvarint( @"scr_snddebugcrosshair", 0 );
        level.snd.debug.xhair_alpha = getdvarfloat( @"hash_abd89601b7f5878d", 0.1 );
        level.snd.debug.xhair_radius = getdvarint( @"hash_e307089961790a19", 3 );
        level.snd.debug.nuke_msec = getdvarint( @"scr_snddebugnuke", 0 );
        level.snd.debug.initialized = 1;
        snd::dvar( @"scr_snddebug", level.snd.debug.debuglevel, &_scr_snddebug );
        snd::dvar( @"scr_snddebugfilter", level.snd.debug.filter, &_scr_snddebug );
        snd::dvar( @"hash_8f80f3ca72788192", level.snd.debug.hud_x, &_scr_snddebug );
        snd::dvar( @"hash_8f80f4ca727883c5", level.snd.debug.hud_y, &_scr_snddebug );
        snd::dvar( @"scr_snddebugradius", level.snd.debug.dist_radius, &_scr_snddebug );
        snd::dvar( @"hash_13a1898b461126f", level.snd.debug.var_ba6233a13d1fb6cf, &_scr_snddebug );
        snd::dvar( @"scr_snddebugscale", level.snd.debug.scale_3d, &_scr_snddebug );
        snd::dvar( @"scr_snddebugcolor", level.snd.debug.color_3d, &_scr_snddebug );
        snd::dvar( @"hash_2a753b30a1212892", level.snd.debug.color_scale, &_scr_snddebug );
        snd::dvar( @"hash_fb5f3970d2e3bfdb", level.snd.debug.defer_msec, &_scr_snddebug );
        snd::dvar( @"scr_snddebugdistance", level.snd.debug.distance_max, &_scr_snddebug );
        snd::dvar( @"scr_snddebugdot", level.snd.debug.dot, &_scr_snddebug );
        snd::dvar( @"hash_9675532686541235", level.snd.debug.draw_ai, &_scr_snddebug );
        snd::dvar( @"hash_33175192ed572d96", level.snd.debug.draw_limit, &_scr_snddebug );
        snd::dvar( @"scr_snddebugcrosshair", level.snd.debug.xhair, &_scr_snddebug );
        snd::dvar( @"hash_abd89601b7f5878d", level.snd.debug.xhair_alpha, &_scr_snddebug );
        snd::dvar( @"hash_e307089961790a19", level.snd.debug.xhair_radius, &_scr_snddebug );
        snd::dvar( @"scr_snddebugnuke", level.snd.debug.nuke_msec, &_scr_snddebug );
        function_491403de7281e813( "<dev string:x1f7>", "<dev string:x1fd>" );
        function_957bdafe1a213047( "<dev string:x20d>", "<dev string:x214>" );
        function_957bdafe1a213047( "<dev string:x221>", "<dev string:x22b>" );
        function_957bdafe1a213047( "<dev string:x241>", "<dev string:x252>" );
        function_957bdafe1a213047( "<dev string:x26e>", "<dev string:x277>" );
        function_957bdafe1a213047( "<dev string:x28c>", "<dev string:x29f>" );
        function_957bdafe1a213047( "<dev string:x2ba>", "<dev string:x2c2>" );
        function_957bdafe1a213047( "<dev string:x2d5>", "<dev string:x2e0>" );
        function_957bdafe1a213047( "<dev string:x2f6>", "<dev string:x304>" );
        function_957bdafe1a213047( "<dev string:x316>", "<dev string:x31c>" );
        function_957bdafe1a213047( "<dev string:x32e>", "<dev string:x33f>" );
        function_957bdafe1a213047( "<dev string:x356>", "<dev string:x360>" );
        function_957bdafe1a213047( "<dev string:x371>", "<dev string:x37b>" );
        function_957bdafe1a213047( "<dev string:x38c>", "<dev string:x399>" );
        function_7f5bdf2d5e2ac52b();
        function_55d2aa3fc06ffd9( "<dev string:x3aa>" );
        function_55d2aa3fc06ffd9( "<dev string:x3c6>" );
        function_55d2aa3fc06ffd9( "<dev string:x3e8>" + level.snd.debug.xhair_radius + "<dev string:x40e>" );
        function_55d2aa3fc06ffd9( "<dev string:x415>" + level.snd.debug.distance_max + "<dev string:x434>" );
        function_55d2aa3fc06ffd9( "<dev string:x43e>" + level.snd.debug.draw_ai + "<dev string:x45b>" );
        function_55d2aa3fc06ffd9( "<dev string:x463>" + level.snd.debug.draw_limit + "<dev string:x45b>" );
        function_55d2aa3fc06ffd9( "<dev string:x483>" + level.snd.debug.dist_radius + "<dev string:x4a0>" );
        function_55d2aa3fc06ffd9( "<dev string:x4a7>" );
        function_55d2aa3fc06ffd9( "<dev string:x4ce>" + level.snd.debug.scale_3d + "<dev string:x4ec>" );
        function_55d2aa3fc06ffd9( "<dev string:x4f6>" + level.snd.debug.color_3d );
        function_55d2aa3fc06ffd9( "<dev string:x519>" + level.snd.debug.color_scale + "<dev string:x53c>" );
        function_55d2aa3fc06ffd9( "<dev string:x545>" + level.snd.debug.hud_x + "<dev string:x560>" );
        function_55d2aa3fc06ffd9( "<dev string:x56c>" + level.snd.debug.hud_y + "<dev string:x587>" );
        function_55d2aa3fc06ffd9( "<dev string:x593>" );
        
        if ( level.snd.debug.debuglevel == 0 )
        {
            level notify( #"snd_debug_end" );
        }
        else
        {
            level thread _snd_debug_main();
        }
        
        if ( level.snd.debug.nuke_msec > 0 )
        {
            function_71a0152560066d18();
        }
    }

    // Namespace snd_debug
    // Params 0, eflags: 0x4
    // Checksum 0xa42a3afb, Offset: 0x3690
    // Size: 0x83, Type: dev
    function private _snd_debug_main()
    {
        level notify( #"snd_debug_end" );
        level endon( #"snd_debug_end" );
        _snd_debug_wait_init();
        snd::waitforplayers();
        
        while ( true )
        {
            scr_snddebug = level.snd.debug.debuglevel ?? 0;
            
            if ( scr_snddebug > 0 )
            {
                function_26b6990e81885b97( scr_snddebug );
                function_c898a5192fe56c78( scr_snddebug );
                function_2cce9d52cace3143( scr_snddebug );
            }
            
            waitframe();
        }
    }

    // Namespace snd_debug
    // Params 1, eflags: 0x4
    // Checksum 0xe257f0fd, Offset: 0x371b
    // Size: 0xf, Type: dev
    function private function_ca32888bca66677c( var_dafe4dc0a58bbd2c )
    {
        
    }

    // Namespace snd_debug
    // Params 2, eflags: 0x4
    // Checksum 0xfe1af7bc, Offset: 0x3732
    // Size: 0x4f, Type: dev
    function private _scr_levelnotify( key, value )
    {
        if ( value != "<dev string:x3d>" && isstring( value ) )
        {
            snd::condition_alert( 1, "<dev string:x5b6>" + value + "<dev string:x5c6>" );
            level notify( value );
        }
        
        return "<dev string:x3d>";
    }

    // Namespace snd_debug
    // Params 1, eflags: 0x4
    // Checksum 0x3b3a9d06, Offset: 0x3789
    // Size: 0x1c7, Type: dev
    function private function_18c59aff2485935( value )
    {
        level notify( #"hash_38568eb063b77f3e" );
        level endon( #"hash_38568eb063b77f3e" );
        
        if ( isdefined( level.snd.debug.playing ) )
        {
            snd::stop( level.snd.debug.playing );
            level.snd.debug.playing = undefined;
        }
        
        if ( isstring( value ) && value.size > 0 )
        {
            sndaliases = strtok( value, "<dev string:x5ca>" );
            snds = [];
            
            foreach ( sndalias in sndaliases )
            {
                snds[ snds.size ] = snd::play( sndalias );
            }
            
            level.snd.debug.playing = snds;
        }
        
        if ( isdefined( level.snd.debug.playing ) )
        {
            snd::await( level.snd.debug.playing );
            level.snd.debug.playing = undefined;
            setdvar( @"hash_52b4c8d3c40cfc34", "<dev string:x3d>" );
        }
    }

    // Namespace snd_debug
    // Params 2, eflags: 0x4
    // Checksum 0xe90af128, Offset: 0x3958
    // Size: 0x25, Type: dev
    function private function_86665a4fd8a97917( key, value )
    {
        level thread function_18c59aff2485935( value );
        return value;
    }

    // Namespace snd_debug
    // Params 2, eflags: 0x4
    // Checksum 0x6f1761ee, Offset: 0x3985
    // Size: 0x17c, Type: dev
    function private function_eafa25dd948e8574( key, value )
    {
        fadetime = 0;
        
        if ( key == @"hash_6db29b2f497ade76" || value == "<dev string:x3d>" )
        {
            foreach ( player in level.players )
            {
                player clearallsoundsubmixes( fadetime );
            }
        }
        else if ( key == @"hash_e5b570e920b9c1fd" )
        {
            valuearr = strtok( value, "<dev string:x5ce>" );
            submix = valuearr[ 0 ];
            scale = float( valuearr[ 1 ] ?? 1 );
            
            foreach ( player in level.players )
            {
                player setsoundsubmix( submix, fadetime, scale );
            }
        }
        
        return value;
    }

    // Namespace snd_debug
    // Params 2, eflags: 0x4
    // Checksum 0x29af5ead, Offset: 0x3b09
    // Size: 0xb3, Type: dev
    function private function_f68fde136706618f( key, value )
    {
        foreach ( player in level.players )
        {
            player setplayermusicstate( "<dev string:x3d>" );
            waitframe();
            player setplayermusicstate( value );
        }
        
        setdvar( @"hash_2fa2b5d1e7614a6a", "<dev string:x3d>" );
        return value;
    }

    // Namespace snd_debug
    // Params 1, eflags: 0x4
    // Checksum 0x3e3927a1, Offset: 0x3bc4
    // Size: 0x138, Type: dev
    function private function_724840ad9d945c0c( waitframes )
    {
        offset = ( 262144, 262144, 262144 );
        
        foreach ( player in level.players )
        {
            playerorigin = player.origin;
            playerhealth = player.health;
            player setpriorityclienttriggeraudiozone( "<dev string:x5d0>", "<dev string:x5d8>", 0 );
            
            while ( waitframes >= 0 )
            {
                player setorigin( playerorigin + offset );
                player dontinterpolate();
                player cancelmantle();
                waitframe();
                waitframes -= 1;
            }
            
            player clearpriorityclienttriggeraudiozone( "<dev string:x5d8>" );
            player setorigin( playerorigin );
            player dontinterpolate();
            player cancelmantle();
            player cleardamageindicators();
            player.health = playerhealth;
        }
    }

    // Namespace snd_debug
    // Params 2, eflags: 0x4
    // Checksum 0xa8fc1dbb, Offset: 0x3d04
    // Size: 0x46, Type: dev
    function private function_b6f0c59e5f0c137c( key, value )
    {
        waitframes = int( value );
        
        if ( waitframes < 1 )
        {
            waitframes = 1;
        }
        
        level thread function_724840ad9d945c0c( waitframes );
        return "<dev string:x3d>";
    }

    // Namespace snd_debug
    // Params 0, eflags: 0x4
    // Checksum 0x2f13379f, Offset: 0x3d52
    // Size: 0x2e1, Type: dev
    function private function_df0e10015781f8da()
    {
        player = self;
        player endon( #"death" );
        player endon( #"hash_3ba8c276d4903bd1" );
        
        while ( !snd::is_object_invalid( player ) )
        {
            vidsize = snd::function_5e5cdedbd432d043();
            var_861dfcde90b86c55 = vidsize[ 0 ] * 0.5;
            var_861dedde90b84b58 = vidsize[ 1 ] * 0.5;
            eyeorigin = player snd::getplayervieworigin();
            eyeangles = player snd::getplayerviewangles();
            eyeforward = anglestoforward( eyeangles );
            eyeright = anglestoright( eyeangles );
            traceend = eyeorigin + eyeforward * 262144;
            trace = trace::_bullet_trace( eyeorigin, traceend, 1, player, 1, 1 );
            
            if ( isdefined( trace[ "<dev string:x5df>" ] ) && trace[ "<dev string:x5df>" ] != eyeorigin )
            {
                pos = trace[ "<dev string:x5df>" ];
                surfacetype = trace[ "<dev string:x5e8>" ];
                dist = distance( pos, eyeorigin );
                fontscale = 1.5;
                posstring = "<dev string:x5f4>" + pos[ 0 ] + "<dev string:x5f7>" + pos[ 1 ] + "<dev string:x5f7>" + pos[ 2 ] + "<dev string:x5fa>";
                hoffset = 1 * fontscale * 16;
                snd::function_2e8132539dbcad93( posstring, var_861dfcde90b86c55, var_861dedde90b84b58 + hoffset, fontscale, "<dev string:x85>", ( 1, 1, 1 ), 0.854248, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
                diststring = string( dist );
                hoffset = 2 * fontscale * 16;
                snd::function_2e8132539dbcad93( diststring, var_861dfcde90b86c55, var_861dedde90b84b58 + hoffset, fontscale, "<dev string:x85>", ( 1, 1, 1 ), 0.854248, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
                
                if ( isdefined( surfacetype ) )
                {
                    surfstring = string( surfacetype ) + "<dev string:x3d>";
                    hoffset = 3 * fontscale * 16;
                    snd::function_2e8132539dbcad93( surfstring, var_861dfcde90b86c55, var_861dedde90b84b58 + hoffset, fontscale, "<dev string:x85>", ( 1, 1, 1 ), 0.854248, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
                }
                
                snd::debugcrosshair( pos, 4, ( 0, 0, 0 ), ( 1, 1, 1 ), 1, 1 );
            }
            
            waitframe();
        }
    }

    // Namespace snd_debug
    // Params 2, eflags: 0x4
    // Checksum 0x5d05f57b, Offset: 0x403b
    // Size: 0xbb, Type: dev
    function private function_43e05727f7239730( key, value )
    {
        intvalue = int( value );
        
        foreach ( player in level.players )
        {
            if ( intvalue > 0 )
            {
                player thread function_df0e10015781f8da();
                continue;
            }
            
            player notify( #"hash_3ba8c276d4903bd1" );
        }
        
        return value;
    }

    // Namespace snd_debug
    // Params 1, eflags: 0x4
    // Checksum 0x7d799c9f, Offset: 0x40fe
    // Size: 0x8be, Type: dev
    function private function_8924b8ad3373e0bc( dist )
    {
        player = self;
        player notify( #"hash_cd6bc2c72c2fe097" );
        player endon( #"hash_cd6bc2c72c2fe097" );
        player endon( #"death" );
        
        if ( !isdefined( dist ) )
        {
            dist = 2400;
        }
        
        while ( !snd::is_object_invalid( player ) )
        {
            playervieworg = player snd::getplayervieworigin();
            playerangles = player snd::getplayerviewangles();
            playerforward = anglestoforward( playerangles );
            playerfov = player snd::getplayerfov();
            scale = -1 * level.snd.debug.scale_3d;
            ents = [];
            
            if ( level.snd.is_client_script )
            {
                ents = snd::scr_getentitiesinradius( 0, playervieworg, dist );
            }
            else
            {
                ents = snd::scr_getentitiesinradius( playervieworg, dist, undefined );
            }
            
            visibleents = snd::function_51d82def583d96a( ents, playervieworg, playerforward, playerfov, dist );
            
            foreach ( ent in visibleents )
            {
                ent_dist = distance( ent.origin, playervieworg );
                zinc = ent_dist * 0.00125 * 16 * level.snd.debug.scale_3d;
                row = -1;
                yy = ( 0, 0, 0 );
                
                if ( level.snd.is_server_script )
                {
                    if ( isnumber( ent_dist ) )
                    {
                        yy = ( 0, 0, zinc * row );
                        snd::print3dplus( "<dev string:x5fd>", ent.origin + yy, scale, "<dev string:x608>", ( 0.72974, 0.72974, 0.72974 ), 1, ( 0, 0, 0 ), 0.72, ( 1, 1, 1 ), 0.72 );
                        snd::print3dplus( string( ent_dist ), ent.origin + yy, scale, "<dev string:x40>", ( 1, 1, 1 ), 1, ( 0, 0, 0 ), 0.72, ( 1, 1, 1 ), 0.72 );
                    }
                    
                    if ( isstring( ent.classname ) )
                    {
                        row++;
                        yy = ( 0, 0, zinc * row );
                        snd::print3dplus( "<dev string:x60a>", ent.origin + yy, scale, "<dev string:x608>", ( 0.72974, 0.72974, 0.72974 ), 1, ( 0, 0, 0 ), 0.72, ( 1, 1, 1 ), 0.72 );
                        snd::print3dplus( "<dev string:x3d>" + ( ent.classname ?? "<dev string:x619>" ), ent.origin + yy, scale, "<dev string:x40>", ( 1, 1, 1 ), 1, ( 0, 0, 0 ), 0.72, ( 1, 1, 1 ), 0.72 );
                    }
                    
                    if ( isstring( ent.targetname ) )
                    {
                        row++;
                        yy = ( 0, 0, zinc * row );
                        snd::print3dplus( "<dev string:x625>", ent.origin + yy, scale, "<dev string:x608>", ( 0.72974, 0.72974, 0.72974 ), 1, ( 0, 0, 0 ), 0.72, ( 1, 1, 1 ), 0.72 );
                        snd::print3dplus( "<dev string:x3d>" + ( ent.targetname ?? "<dev string:x619>" ), ent.origin + yy, scale, "<dev string:x40>", ( 1, 1, 1 ), 1, ( 0, 0, 0 ), 0.72, ( 1, 1, 1 ), 0.72 );
                    }
                    
                    if ( isstring( ent.script_noteworthy ) )
                    {
                        row++;
                        yy = ( 0, 0, zinc * row );
                        snd::print3dplus( "<dev string:x635>", ent.origin + yy, scale, "<dev string:x608>", ( 0.72974, 0.72974, 0.72974 ), 1, ( 0, 0, 0 ), 0.72, ( 1, 1, 1 ), 0.72 );
                        snd::print3dplus( "<dev string:x3d>" + ( ent.script_noteworthy ?? "<dev string:x619>" ), ent.origin + yy, scale, "<dev string:x40>", ( 1, 1, 1 ), 1, ( 0, 0, 0 ), 0.72, ( 1, 1, 1 ), 0.72 );
                    }
                }
                
                row = 3;
                
                if ( level.snd.is_client_script )
                {
                    if ( isstring( ent.classname ) )
                    {
                        snd::print3dplus( "<dev string:x64c>", ent.origin + yy, scale, "<dev string:x608>", ( 0.72974, 0.72974, 0.72974 ), 1, ( 0, 0, 0 ), 0.72, ( 1, 1, 1 ), 0.72 );
                        snd::print3dplus( "<dev string:x3d>" + ( ent.classname ?? "<dev string:x619>" ), ent.origin + yy, scale, "<dev string:x40>", ( 1, 1, 1 ), 1, ( 0, 0, 0 ), 0.72, ( 1, 1, 1 ), 0.72 );
                    }
                    
                    if ( isstring( ent.targetname ) )
                    {
                        row++;
                        yy = ( 0, 0, zinc * row );
                        snd::print3dplus( "<dev string:x65b>", ent.origin + yy, scale, "<dev string:x608>", ( 0.72974, 0.72974, 0.72974 ), 1, ( 0, 0, 0 ), 0.72, ( 1, 1, 1 ), 0.72 );
                        snd::print3dplus( "<dev string:x3d>" + ( ent.targetname ?? "<dev string:x619>" ), ent.origin + yy, scale, "<dev string:x40>", ( 1, 1, 1 ), 1, ( 0, 0, 0 ), 0.72, ( 1, 1, 1 ), 0.72 );
                    }
                    
                    if ( isstring( ent.script_noteworthy ) )
                    {
                        row++;
                        yy = ( 0, 0, zinc * row );
                        snd::print3dplus( "<dev string:x66b>", ent.origin + yy, scale, "<dev string:x608>", ( 0.72974, 0.72974, 0.72974 ), 1, ( 0, 0, 0 ), 0.72, ( 1, 1, 1 ), 0.72 );
                        snd::print3dplus( "<dev string:x3d>" + ( ent.script_noteworthy ?? "<dev string:x619>" ), ent.origin + yy, scale, "<dev string:x40>", ( 1, 1, 1 ), 1, ( 0, 0, 0 ), 0.72, ( 1, 1, 1 ), 0.72 );
                    }
                }
                
                if ( level.snd.is_server_script )
                {
                    snd::debugcrosshair( ent.origin, 12, ent.angles, ( 1, 1, 1 ), 1, 0 );
                }
                
                if ( level.snd.is_client_script )
                {
                    snd::debugarrow( ent.origin, ent.angles, 12, 4, ( 1, 0, 0 ), 1, 0 );
                }
            }
            
            waitframe();
        }
    }

    // Namespace snd_debug
    // Params 2, eflags: 0x4
    // Checksum 0xe7959dfc, Offset: 0x49c4
    // Size: 0xcc, Type: dev
    function private function_1be489c84c2399ec( key, value )
    {
        snd::waitforplayers();
        players = snd::getplayerssafe();
        intvalue = int( value );
        
        foreach ( player in players )
        {
            if ( intvalue > 0 )
            {
                player thread function_8924b8ad3373e0bc( intvalue );
                continue;
            }
            
            player notify( #"hash_cd6bc2c72c2fe097" );
        }
        
        return value;
    }

    // Namespace snd_debug
    // Params 2, eflags: 0x4
    // Checksum 0xa8b6336a, Offset: 0x4a98
    // Size: 0x1e, Type: dev
    function private function_12bfd10e3a26fc86( key, value )
    {
        return "<dev string:x3d>";
    }

    // Namespace snd_debug
    // Params 2, eflags: 0x4
    // Checksum 0x15f06ee6, Offset: 0x4abe
    // Size: 0x1ab, Type: dev
    function private function_6b726b5284ecf141( key, value )
    {
        level._createfx.selected_fx_ents = [];
        
        foreach ( ent in level.createfxent )
        {
            if ( isdefined( ent.v[ "<dev string:x1a1>" ] ) == 0 )
            {
                continue;
            }
            
            if ( isdefined( ent.v[ "<dev string:x42>" ] ) && isstartstr( ent.v[ "<dev string:x1a1>" ], "<dev string:x1a6>" ) )
            {
                origin = ent.v[ "<dev string:x42>" ];
                angles = ( 270, 0, 0 );
                origin = ( floor( origin[ 0 ] ), floor( origin[ 1 ] ), floor( origin[ 2 ] ) );
                ent.v[ "<dev string:x49>" ] = angles;
                ent.v[ "<dev string:x42>" ] = origin;
                level._createfx.selected_fx_ents[ level._createfx.selected_fx_ents.size ] = ent;
            }
        }
        
        createfx::update_selected_entities();
        level._createfx.selected_fx_ents = [];
        return "<dev string:x3d>";
    }

    // Namespace snd_debug
    // Params 2, eflags: 0x4
    // Checksum 0x34c95205, Offset: 0x4c71
    // Size: 0x1a3, Type: dev
    function private function_79de28ff4dc5c6b8( key, value )
    {
        if ( isarray( level.snd.objects ) )
        {
            count = 0;
            
            foreach ( sndobj in level.snd.objects )
            {
                soundkey = sndobj.soundkey ?? "<dev string:x682>";
                soundtype = sndobj.soundtype ?? "<dev string:x682>";
                soundalias = sndobj.soundalias ?? "<dev string:x619>";
                soundlinkedentity = "<dev string:x686>";
                
                if ( isdefined( sndobj.soundlinkedentity ) )
                {
                    soundlinkedentity = sndobj.soundlinkedentity.classname;
                }
                
                txt = string( count ) + "<dev string:x691>" + soundkey + "<dev string:x699>" + soundtype + "<dev string:x6a1>" + soundalias + "<dev string:x6ac>" + soundlinkedentity + "<dev string:x6bf>" + sndobj.origin + "<dev string:x3d>";
                print( txt );
                count += 1;
            }
        }
        
        return "<dev string:x3e>";
    }

    // Namespace snd_debug
    // Params 2, eflags: 0x4
    // Checksum 0x2483aa3c, Offset: 0x4e1c
    // Size: 0xc6, Type: dev
    function private function_b19affe5180af073( player, ent )
    {
        kill_origin = ent.origin + ( randomintrange( -6, 6 ), randomintrange( -6, 6 ), randomintrange( -6, -1 ) );
        player radiusdamage( kill_origin, 96, 69696969, ent.health * 2, player, "<dev string:x6ca>" );
        waittillframeend();
        physicsexplosionsphere( kill_origin, 96, 72, 969, 1 );
        ent kill( kill_origin, player, player, "<dev string:x6ca>" );
        
        if ( level._effect[ "<dev string:x6d8>" ] )
        {
            playfxanydistance( level._effect[ "<dev string:x6d8>" ], kill_origin, ( 0, 90, 0 ) );
        }
    }

    // Namespace snd_debug
    // Params 1, eflags: 0x4
    // Checksum 0x8fe8f010, Offset: 0x4eea
    // Size: 0x29c, Type: dev
    function private function_3d87517c4b34ca63( player )
    {
        bad_guys = [];
        bosses = [];
        vehicles = [];
        assert( isplayer( player ) );
        
        foreach ( bad_guy in getaispeciesarray( "<dev string:x6fe>", "<dev string:x707>" ) )
        {
            if ( isalive( bad_guy ) && !isdefined( bad_guy.godmode ) )
            {
                bad_guys[ bad_guys.size ] = bad_guy;
            }
        }
        
        if ( isarray( level.bosses ) )
        {
            foreach ( bossstruct in level.bosses )
            {
                foreach ( boss in bossstruct.instances )
                {
                    if ( isalive( boss ) && !isdefined( boss.godmode ) )
                    {
                        bosses[ bosses.size ] = boss;
                    }
                }
            }
        }
        
        foreach ( vehicle in vehicle_getarray() )
        {
            if ( vehicle.script_team == "<dev string:x70b>" && !isdefined( vehicle.godmode ) )
            {
                vehicles[ vehicles.size ] = vehicle;
            }
        }
        
        nuke_ents = sortbydistance( arraycombineunique( bad_guys, bosses, vehicles ), player.origin );
        return nuke_ents;
    }

    // Namespace snd_debug
    // Params 1, eflags: 0x4
    // Checksum 0x631c4713, Offset: 0x518e
    // Size: 0x1de, Type: dev
    function private function_a2494ebbaf818d44( msec )
    {
        self notify( #"scr_snddebugnuke" );
        self endon( #"scr_snddebugnuke" );
        self endon( #"disconnect" );
        buttonsnuke = 2147483647;
        var_77cba0c3517d7765 = 0;
        var_5d6639ba5ad3af8b = 0;
        
        while ( true )
        {
            now = gettime();
            buttonmelee = self meleebuttonpressed();
            buttonsprint = self sprintbuttonpressed();
            is_resetting = 0;
            
            if ( buttonsprint )
            {
                if ( buttonmelee )
                {
                    if ( buttonsnuke == 2147483647 )
                    {
                        buttonsnuke = now;
                        var_77cba0c3517d7765 += 1;
                    }
                    else if ( var_5d6639ba5ad3af8b == var_77cba0c3517d7765 )
                    {
                        var_77cba0c3517d7765 += 1;
                    }
                }
                else if ( !buttonmelee && var_5d6639ba5ad3af8b == var_77cba0c3517d7765 - 1 )
                {
                    var_5d6639ba5ad3af8b += 1;
                }
                
                delta = now - buttonsnuke;
                is_within_time = delta <= msec;
                var_4406aea7f0b473a3 = var_77cba0c3517d7765 >= 3;
                
                if ( is_within_time && var_4406aea7f0b473a3 )
                {
                    snd::function_7a77574e2157fbce( "<dev string:x710>" + delta + "<dev string:x725>" );
                    nuke_ents = function_3d87517c4b34ca63( self );
                    
                    foreach ( nuke_ent in nuke_ents )
                    {
                        function_b19affe5180af073( self, nuke_ent );
                        waitframe();
                    }
                    
                    is_resetting = 1;
                }
                else if ( !is_within_time )
                {
                    is_resetting = 1;
                }
            }
            else
            {
                is_resetting = 1;
            }
            
            if ( is_resetting )
            {
                buttonsnuke = 2147483647;
                var_77cba0c3517d7765 = 0;
                var_5d6639ba5ad3af8b = 0;
            }
            
            waitframe();
        }
    }

    // Namespace snd_debug
    // Params 0, eflags: 0xc
    // Checksum 0xbe84fd04, Offset: 0x5374
    // Size: 0x90, Type: dev
    function private function_c6fc95936d6c284e()
    {
        self notify( #"hash_9b392e59c24be6b3" );
        self endon( #"hash_9b392e59c24be6b3" );
        
        while ( true )
        {
            level waittill( #"connected", player );
            
            if ( isplayer( player ) && level.snd.debug.nuke_msec > 0 )
            {
                player thread function_a2494ebbaf818d44( level.snd.debug.nuke_msec );
            }
        }
    }

    // Namespace snd_debug
    // Params 1, eflags: 0x4
    // Checksum 0xff51d88d, Offset: 0x540c
    // Size: 0x132, Type: dev
    function private function_71a0152560066d18( nuke_msec )
    {
        if ( !isdefined( nuke_msec ) )
        {
            nuke_msec = level.snd.debug.nuke_msec;
        }
        
        if ( nuke_msec > 0 )
        {
            foreach ( player in level.players )
            {
                player thread function_a2494ebbaf818d44( nuke_msec );
            }
            
            level thread function_c6fc95936d6c284e();
            return;
        }
        
        foreach ( player in level.players )
        {
            player notify( #"scr_snddebugnuke" );
        }
    }

#/
