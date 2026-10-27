// script_5c221b3ec14e0ff7  (hash_5c221b3ec14e0ff7.gscc) (size: 7047 Bytes / 0x1b87 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x26aa23e0 (648684512)
// size ...... 7047 (0x1b87)
// includes .. 1   (offset: 0x1a63)
// strings ... 0   (offset: 0x1a6b)
// dev strs .. 18  (offset: 0x1a6b)
// exports ... 18  (offset: 0x125b)
// cseg ...... 0x58 + 0x1203 (0x125b)
// imports ... 39  (offset: 0x152b)
// animtree1 . 0   (offset: 0x1b87)
// animtree2 . 0   (offset: 0x1b87)
#using scripts\mp\dmz\gametypes\dmz_audio;

#namespace dmz_debug;

/#

    // Namespace dmz_debug
    // Params 3, eflags: 0x4
    // Checksum 0xee95e807, Offset: 0x76
    // Size: 0x5e, Type: dev
    function private function_91b332228724f596( text, total_length, pad_before )
    {
        if ( !isdefined( pad_before ) )
        {
            pad_before = 0;
        }
        
        while ( isstring( text ) && text.size < total_length )
        {
            if ( pad_before )
            {
                text = "<dev string:x24>" + text;
                continue;
            }
            
            text += "<dev string:x24>";
        }
        
        return text;
    }

    // Namespace dmz_debug
    // Params 1
    // Checksum 0x2b4a95a0, Offset: 0xdc
    // Size: 0x5d, Type: dev
    function function_1dbec3561d54e03e( text )
    {
        if ( isarray( text ) )
        {
            return text;
        }
        
        if ( isnumber( text ) )
        {
            return [ string( text ) ];
        }
        
        if ( isstring( text ) )
        {
            if ( issubstr( text, "<dev string:x26>" ) )
            {
                return strtok( text, "<dev string:x26>" );
            }
            
            return [ text ];
        }
        
        return [];
    }

    // Namespace dmz_debug
    // Params 1, eflags: 0x4
    // Checksum 0x4f6ccf55, Offset: 0x141
    // Size: 0x144, Type: dev
    function private function_f620f6626083980( state )
    {
        if ( !isdefined( state ) )
        {
            state = "<dev string:x28>";
        }
        
        color = undefined;
        assert( isstring( state ), "<dev string:x29>" );
        
        switch ( state )
        {
            case #"hash_d2a4c56b6b9ff274":
            default:
                color = ( randomfloatrange( 0.5, 1 ), randomfloatrange( 0.5, 1 ), randomfloatrange( 0.5, 1 ) );
                break;
            case #"hash_1c39674e5b0de0f3":
            case #"hash_4d6a329017fe1bd0":
            case #"hash_9128327eb51e0b7b":
            case #"hash_c6076a90d1a76064":
                color = ( 0.5, 1, 0.5 );
                break;
            case #"hash_186d745a92c317d9":
            case #"hash_21c69ec47c409a66":
                color = ( 1, 1, 0.333 );
                break;
            case #"hash_2d1406e602f0875d":
            case #"hash_9e02cd4a0f3ca981":
                color = ( 1, 0.5, 0.5 );
                break;
            case #"hash_cf14c509efeb3c87":
                color = ( 0.2, 0.2, 0.2 );
                break;
        }
        
        return color;
    }

    // Namespace dmz_debug
    // Params 1, eflags: 0x4
    // Checksum 0xf10e0a6, Offset: 0x28d
    // Size: 0x10a, Type: dev
    function private function_7e67ee34297e1bcc( ent )
    {
        assert( isent( ent ), "<dev string:x96>" );
        var_3d1dbec6dee3c9cd = getdvarint( @"hash_f86fbee6ae5321ec", "<dev string:xba>" );
        
        if ( var_3d1dbec6dee3c9cd )
        {
            alertmillisec = undefined;
            idlemillisec = undefined;
            
            if ( isstruct( ent.bossinstance ) )
            {
                alertmillisec = ent.bossinstance.var_4ef10bc9f3b5040f;
                idlemillisec = ent.bossinstance.var_20724260a310a4e9;
            }
            
            return dmz_audio::function_6b2f004cc0c9ff80( ent, alertmillisec, idlemillisec );
        }
        
        if ( isagent( ent ) && isstring( ent.alertlevel ) )
        {
            return ent.alertlevel;
        }
        else if ( ent.classname == "<dev string:xbc>" && isstring( ent.currentstate ) )
        {
            return ent.currentstate;
        }
        
        return "<dev string:x57>";
    }

    // Namespace dmz_debug
    // Params 1, eflags: 0x4
    // Checksum 0x55a67d8, Offset: 0x39f
    // Size: 0x60, Type: dev
    function private function_763814bb48133b1c( bossinstance )
    {
        assert( isstruct( bossinstance ), "<dev string:xcb>" );
        
        if ( bossinstance.killed )
        {
            return "<dev string:x91>";
        }
        else if ( isdefined( bossinstance.boss ) )
        {
            return function_7e67ee34297e1bcc( bossinstance.boss );
        }
        
        return "<dev string:x57>";
    }

    // Namespace dmz_debug
    // Params 5, eflags: 0x4
    // Checksum 0x316c6b12, Offset: 0x407
    // Size: 0xb9, Type: dev
    function private function_814e712fd1293c21( x, y, text, color, scale )
    {
        if ( !isdefined( color ) )
        {
            color = ( 1, 1, 1 );
        }
        
        if ( !isdefined( scale ) )
        {
            scale = 1;
        }
        
        text = function_1dbec3561d54e03e( text );
        yy = y;
        
        if ( isarray( text ) )
        {
            for ( i = 0; i < text.size ; i++ )
            {
                yy = y + 16 * scale * i;
                text_line = text[ i ];
                printtoscreen2d( x, yy, text_line, color, scale, 1 );
            }
        }
        
        return yy;
    }

    // Namespace dmz_debug
    // Params 4
    // Checksum 0xe642e514, Offset: 0x4c8
    // Size: 0xd0, Type: dev
    function function_59ea51fac9d063ec( origin, text, color, scale )
    {
        if ( !isvector( origin ) )
        {
            return;
        }
        
        if ( !isdefined( color ) )
        {
            color = ( 1, 1, 1 );
        }
        
        if ( !isdefined( scale ) )
        {
            scale = 1;
        }
        
        text = function_1dbec3561d54e03e( text );
        
        if ( isarray( text ) )
        {
            for ( i = 0; i < text.size ; i++ )
            {
                ii = text.size - 1 - i;
                text_origin = origin + ( 0, 0, 14 * scale * ii );
                text_line = text[ i ];
                print3d( text_origin, text_line, color, 1, scale, 1, 1 );
            }
        }
    }

    // Namespace dmz_debug
    // Params 3
    // Checksum 0x3baef420, Offset: 0x5a0
    // Size: 0x94, Type: dev
    function function_d601c5cd2e54db40( boss, name, state )
    {
        name = function_91b332228724f596( name ?? "<dev string:x57>", 12, 1 );
        health = function_91b332228724f596( boss.health + "<dev string:x102>", 10, 1 );
        state = function_91b332228724f596( state ?? "<dev string:x57>", 10, 0 );
        text = name + "<dev string:x106>" + health + "<dev string:x24>" + state;
        return text;
    }

    // Namespace dmz_debug
    // Params 6
    // Checksum 0x9bc0cadc, Offset: 0x63c
    // Size: 0x86, Type: dev
    function function_412a01c9e71093e5( x, y, text, color, scale, index )
    {
        scale = 1.25;
        
        if ( !isdefined( index ) )
        {
            index = 0;
        }
        
        font_height = 16 * scale;
        xx = x;
        yy = y + font_height * index;
        function_814e712fd1293c21( xx, yy, text, color, scale );
    }

    // Namespace dmz_debug
    // Params 5
    // Checksum 0xe6430672, Offset: 0x6ca
    // Size: 0x213, Type: dev
    function function_b742c52d437647a8( bossdetails, bossinstance, x, y, index )
    {
        x = int( x ?? 360 );
        y = int( y ?? 40 );
        index = int( index ?? 0 );
        
        if ( isdefined( bossinstance ) && isdefined( bossinstance.boss ) )
        {
            boss = bossinstance.boss;
            state = function_763814bb48133b1c( bossinstance );
            text = function_d601c5cd2e54db40( boss, bossdetails.name, state );
            color = function_f620f6626083980( state );
            function_412a01c9e71093e5( x, y, text, color, 1, index );
            index += 1;
            
            if ( isdefined( bossinstance.wheelson ) )
            {
                wheelson = bossinstance.wheelson;
                state = function_7e67ee34297e1bcc( wheelson );
                text = function_d601c5cd2e54db40( wheelson, "<dev string:x109>", state );
                color = function_f620f6626083980( state );
                function_412a01c9e71093e5( x, y, text, color, 1, index );
                index += 1;
            }
            
            if ( isarray( boss.minions ) )
            {
                foreach ( minion in boss.minions )
                {
                    state = function_7e67ee34297e1bcc( minion );
                    text = function_d601c5cd2e54db40( minion, minion.name, state );
                    color = function_f620f6626083980( state );
                    function_412a01c9e71093e5( x, y, text, color, 1, index );
                    index += 1;
                }
            }
        }
        
        return index;
    }

    // Namespace dmz_debug
    // Params 3
    // Checksum 0x241480c2, Offset: 0x8e5
    // Size: 0x76, Type: dev
    function function_d605ebcd2e5924a9( boss, name, state )
    {
        health = boss.health + "<dev string:x102>";
        
        if ( !isdefined( name ) )
        {
            name = "<dev string:x57>";
        }
        
        if ( !isdefined( state ) )
        {
            state = "<dev string:x57>";
        }
        
        text = [ name, health, state ];
        return text;
    }

    // Namespace dmz_debug
    // Params 5
    // Checksum 0xd116280, Offset: 0x963
    // Size: 0xc0, Type: dev
    function function_40ae7594f35e003d( origin, text, color, height, radius )
    {
        if ( !isvector( origin ) )
        {
            return;
        }
        
        if ( !isdefined( color ) )
        {
            color = ( 0.5, 1, 0.5 );
        }
        
        if ( !isdefined( height ) )
        {
            height = 72;
        }
        
        if ( !isdefined( radius ) )
        {
            radius = 24;
        }
        
        cylinder_end = origin + ( 0, 0, 6 );
        origin_hi = origin + ( 0, 0, height );
        cylinder( origin, cylinder_end, radius, color, 0, 1 );
        line( origin, origin_hi, color, 1, 0, 1 );
        function_59ea51fac9d063ec( origin_hi, text, color, 1 );
    }

    // Namespace dmz_debug
    // Params 6
    // Checksum 0xedda7ae9, Offset: 0xa2b
    // Size: 0xdb, Type: dev
    function function_b32524a262cd44d6( origin, angles, text, color, radius, var_5e599df2093da7da )
    {
        if ( !isvector( origin ) )
        {
            return;
        }
        
        if ( !isdefined( color ) )
        {
            color = ( 0.5, 1, 0.5 );
        }
        
        origin_hi = origin + ( 0, 0, 36 );
        origin_body = origin + ( 0, 0, -60 );
        
        if ( !isdefined( radius ) )
        {
            radius = 360;
        }
        
        if ( !isdefined( var_5e599df2093da7da ) )
        {
            var_5e599df2093da7da = ( 320, 80, 80 );
        }
        
        cylinder( origin, origin_hi, radius, color, 0, 1 );
        orientedbox( origin_body, var_5e599df2093da7da, angles, color, 0, 1 );
        function_59ea51fac9d063ec( origin_hi, text, color, 4 );
    }

    // Namespace dmz_debug
    // Params 5
    // Checksum 0x58caf0f5, Offset: 0xb0e
    // Size: 0xe5, Type: dev
    function function_6621cb74188b648b( origin, angles, text, color, var_5e599df2093da7da )
    {
        if ( !isvector( origin ) )
        {
            return;
        }
        
        if ( !isdefined( var_5e599df2093da7da ) )
        {
            var_5e599df2093da7da = ( 192, 80, 80 );
        }
        
        if ( !isdefined( color ) )
        {
            color = ( 0.5, 1, 0.5 );
        }
        
        origin += ( 0, 0, -24 );
        origin_hi = origin + ( 0, 0, 96 );
        origin_body = origin + ( 0, 0, var_5e599df2093da7da[ 2 ] * 0.5 );
        orientedbox( origin_body, var_5e599df2093da7da, angles, color, 0, 1 );
        line( origin, origin_hi, color, 1, 0, 1 );
        function_59ea51fac9d063ec( origin_hi, text, color, 1 );
    }

    // Namespace dmz_debug
    // Params 5
    // Checksum 0x550b5c84, Offset: 0xbfb
    // Size: 0xe5, Type: dev
    function function_3376a9821ab7c8b6( origin, angles, text, color, var_5e599df2093da7da )
    {
        if ( !isvector( origin ) )
        {
            return;
        }
        
        if ( !isdefined( var_5e599df2093da7da ) )
        {
            var_5e599df2093da7da = ( 64, 40, 26 );
        }
        
        if ( !isdefined( color ) )
        {
            color = ( 0.5, 1, 0.5 );
        }
        
        origin += ( 0, 0, 3 );
        origin_hi = origin + ( 0, 0, 54 );
        origin_body = origin + ( 0, 0, var_5e599df2093da7da[ 2 ] * 0.5 );
        orientedbox( origin_body, var_5e599df2093da7da, angles, color, 0, 1 );
        line( origin, origin_hi, color, 1, 0, 1 );
        function_59ea51fac9d063ec( origin_hi, text, color, 1 );
    }

    // Namespace dmz_debug
    // Params 2
    // Checksum 0x612e7169, Offset: 0xce8
    // Size: 0x380, Type: dev
    function function_b747ab2d437c3751( bossdetails, bossinstance )
    {
        if ( isdefined( bossinstance ) && isdefined( bossinstance.boss ) )
        {
            boss = bossinstance.boss;
            state = function_763814bb48133b1c( bossinstance );
            
            if ( isagent( boss ) )
            {
                name = bossdetails.name ?? "<dev string:x57>";
                text = function_d605ebcd2e5924a9( boss, bossdetails.name, state );
                color = function_f620f6626083980( state );
                function_40ae7594f35e003d( boss.origin, text, color );
            }
            else if ( boss.classname == "<dev string:xbc>" )
            {
                if ( bossdetails.name == "<dev string:x112>" )
                {
                    name = bossdetails.name ?? "<dev string:x57>";
                    text = function_d605ebcd2e5924a9( boss, bossdetails.name, state );
                    color = function_f620f6626083980( state );
                    function_b32524a262cd44d6( boss.origin, boss.angles, text, color );
                }
                else if ( bossdetails.name == "<dev string:x11a>" )
                {
                    name = bossdetails.name ?? "<dev string:x57>";
                    text = function_d605ebcd2e5924a9( boss, bossdetails.name, state );
                    color = function_f620f6626083980( state );
                    function_6621cb74188b648b( boss.origin, boss.angles, text, color );
                }
                else
                {
                    var_5e599df2093da7da = ( 72, 36, 36 );
                    origin_body = boss.origin + ( 0, 0, var_5e599df2093da7da[ 2 ] * 0.5 );
                    text = function_d605ebcd2e5924a9( boss, bossdetails.name, state );
                    color = function_f620f6626083980( state );
                    orientedbox( origin_body, var_5e599df2093da7da, boss.angles, color, 0, 1 );
                }
            }
            
            if ( isdefined( bossinstance.wheelson ) )
            {
                wheelson = bossinstance.wheelson;
                state = function_7e67ee34297e1bcc( wheelson );
                name = "<dev string:x109>";
                text = function_d605ebcd2e5924a9( wheelson, name, state );
                color = function_f620f6626083980( state );
                function_3376a9821ab7c8b6( wheelson.origin, wheelson.angles, text, color );
            }
            
            if ( isarray( boss.minions ) )
            {
                index = 0;
                
                foreach ( minion in boss.minions )
                {
                    state = function_7e67ee34297e1bcc( minion );
                    text = function_d605ebcd2e5924a9( minion, minion.name, state );
                    color = function_f620f6626083980( state );
                    height = 88 + 16 * index;
                    function_40ae7594f35e003d( minion.origin, text, color, height );
                    index += 1;
                }
            }
        }
    }

    // Namespace dmz_debug
    // Params 0
    // Checksum 0x9101ec1b, Offset: 0x1070
    // Size: 0x1eb, Type: dev
    function function_e82a4a3462eeffba()
    {
        bossdebug = getdvar( @"hash_a32ed8b3f923aa2d", "<dev string:xba>" );
        var_e42f59d3b664d6cf = bossdebug != "<dev string:xba>" && bossdebug != "<dev string:x28>";
        var_d83ab9d6c4d4eddd = var_e42f59d3b664d6cf && bossdebug != "<dev string:x122>" && bossdebug != "<dev string:x124>" && bossdebug != "<dev string:x128>";
        
        if ( isarray( level.bosses ) && var_e42f59d3b664d6cf )
        {
            x = 360;
            y = 60;
            index = 0;
            
            foreach ( boss in level.bosses )
            {
                if ( isstruct( boss ) && isarray( boss.instances ) )
                {
                    var_41cfd9e7e8d10c62 = var_d83ab9d6c4d4eddd && issubstr( boss.name, bossdebug );
                    
                    if ( !var_d83ab9d6c4d4eddd || var_41cfd9e7e8d10c62 )
                    {
                        foreach ( bossinstance in boss.instances )
                        {
                            function_b747ab2d437c3751( boss, bossinstance );
                            index = function_b742c52d437647a8( boss, bossinstance, x, y, index );
                        }
                    }
                }
            }
        }
    }

#/
