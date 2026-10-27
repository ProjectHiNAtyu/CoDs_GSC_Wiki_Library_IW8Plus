// scripts\mp\ob\ob_dialogue_util.gsc  (hash_585fd210247abadb.gscc) (size: 8583 Bytes / 0x2187 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf942f091 (4181913745)
// size ...... 8583 (0x2187)
// includes .. 8   (offset: 0x2047)
// strings ... 19  (offset: 0x2087)
// dev strs .. 1   (offset: 0x217b)
// exports ... 18  (offset: 0x1843)
// cseg ...... 0x111 + 0x1732 (0x1843)
// imports ... 41  (offset: 0x1b13)
// animtree1 . 0   (offset: 0x2187)
// animtree2 . 0   (offset: 0x2187)
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\activity_nexus\activity_player_broadcasting;
#using scripts\common\utility;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\ob\systems\region_difficulty_manager;
#using scripts\mp\overlord;

#namespace ob_dialogue_util;

/#

    // Namespace ob_dialogue_util
    // Params 0
    // Checksum 0x227fa0e3, Offset: 0x12f
    // Size: 0x5, Type: dev
    function function_bcb7e936377aa6bf()
    {
        
    }

#/

// Namespace ob_dialogue_util
// Params 6
// Checksum 0xacd9a44e, Offset: 0x13c
// Size: 0x420
function ob_dialogue_print( dialogue, players, var_cdf477eda0a78811, dialoguedist, clearcurrent, maxlines )
{
    if ( !isdefined( self.var_1c02349c6d98a704 ) )
    {
        self.var_1c02349c6d98a704 = 0;
    }
    
    if ( !isdefined( maxlines ) && isdefined( level.var_b332ab4e308e478b ) )
    {
        maxlines = level.var_b332ab4e308e478b;
    }
    
    assert( !isdefined( maxlines ) || maxlines >= 1, "<dev string:x24>" );
    
    if ( !isdefined( var_cdf477eda0a78811 ) )
    {
        var_cdf477eda0a78811 = "distance";
    }
    
    if ( !isdefined( players ) )
    {
        players = level.players;
    }
    
    if ( !isarray( players ) )
    {
        array = [];
        array[ 0 ] = players;
        players = array;
    }
    
    if ( !isdefined( dialoguedist ) )
    {
        dialoguedist = 512;
    }
    
    dialoguedistsq = dialoguedist * dialoguedist;
    
    foreach ( player in players )
    {
        if ( clearcurrent && isdefined( player.dialoguehud ) || isdefined( player.dialoguehud ) && player.dialoguehud.size >= maxlines )
        {
            function_490ed9e2b5d8dd6c( players, 1, maxlines - 1 );
        }
    }
    
    if ( isplayer( self ) )
    {
        color = "^3";
    }
    else if ( isdefined( self.team ) )
    {
        switch ( self.team )
        {
            case #"hash_7c2d091e6337bf54":
                color = "^1";
                break;
            case #"hash_5f54b9bf7583687f":
                color = "^5";
                break;
            case #"hash_24b14065e10b1f8d":
                color = "^4";
                break;
            default:
                color = "^2";
                break;
        }
    }
    else
    {
        color = "^2";
    }
    
    print_str = "";
    
    if ( isdefined( self.name ) )
    {
        print_str += self.name;
    }
    else if ( isplayer( self ) )
    {
        print_str += "Player";
    }
    else if ( isdefined( self.team ) )
    {
        if ( isdefined( level.var_d2b0a2a8d5fde2d4[ self.team ] ) )
        {
            print_str += level.var_d2b0a2a8d5fde2d4[ self.team ];
        }
        else
        {
            switch ( self.team )
            {
                case #"hash_7c2d091e6337bf54":
                    print_str += "Enemy";
                    break;
                case #"hash_24b14065e10b1f8d":
                    print_str += "Team3";
                    break;
                case #"hash_5f54b9bf7583687f":
                    print_str += "Friendly";
                    break;
                default:
                    print_str += "Civ";
                    break;
            }
        }
    }
    
    if ( print_str != "" )
    {
        print_str = color + print_str;
    }
    
    foreach ( player in players )
    {
        radio_str = "";
        
        if ( var_cdf477eda0a78811 == "always" )
        {
            radio_str = " (radio)";
        }
        else if ( isdefined( self.origin ) )
        {
            playerdistsq = distancesquared( self.origin, player.origin );
            
            if ( playerdistsq > dialoguedistsq )
            {
                if ( var_cdf477eda0a78811 == "never" )
                {
                    continue;
                }
                else
                {
                    radio_str = " (radio)";
                }
            }
        }
        
        full_str = print_str + radio_str + ": ^7" + dialogue;
        thread function_63cec73e5f8707ab( full_str, player );
    }
}

// Namespace ob_dialogue_util
// Params 2
// Checksum 0xa55aa0d4, Offset: 0x564
// Size: 0x6be
function function_63cec73e5f8707ab( string, player )
{
    if ( isdefined( self.var_1c02349c6d98a704 ) )
    {
        self.var_1c02349c6d98a704++;
    }
    
    var_1f2d1184e020963f = int( 4.9 );
    lineheight = int( 10 );
    var_3a80a7bd515e3e74 = int( 2 );
    
    if ( isdefined( level.var_246632663f4539d4 ) )
    {
        endy = level.var_246632663f4539d4;
    }
    else
    {
        endy = 420;
    }
    
    width = int( clamp( string.size * var_1f2d1184e020963f, 350, 630 ) );
    string_array = utility::wrap_text( string, int( 630 / var_1f2d1184e020963f ) );
    height = lineheight * string_array.size + var_3a80a7bd515e3e74 * 2;
    text_array = [];
    
    foreach ( i, string in string_array )
    {
        text = newclienthudelem( player );
        text.alpha = 0;
        
        /#
            text setdevtext( string );
        #/
        
        text.fontscale = 1;
        text.row = i;
        text_array[ text_array.size ] = text;
    }
    
    bg = newclienthudelem( player );
    bg.alpha = 0;
    bg setshader( "black", width, height );
    
    if ( isdefined( player.dialoguehud ) )
    {
        foreach ( dialogueline in player.dialoguehud )
        {
            foreach ( hud in dialogueline )
            {
                hud moveovertime( 0.3 );
                hud.y -= height + 5;
            }
        }
    }
    else
    {
        player.dialoguehud = [];
    }
    
    array = arraycombine( text_array, [ bg ] );
    array[ 0 ] endon( #"hash_40e05c463bfbe415" );
    player.dialoguehud[ player.dialoguehud.size ] = array;
    
    foreach ( hud in array )
    {
        hud.alignx = "center";
        hud.aligny = "top";
        hud.x = 320;
        hud.y = height * -1;
        hud.sort = 5;
        
        if ( isdefined( hud.row ) )
        {
            hud.y += hud.row * lineheight + var_3a80a7bd515e3e74;
        }
    }
    
    endy -= height;
    
    foreach ( hud in array )
    {
        hud fadeovertime( 0.3 );
        
        if ( isdefined( hud.row ) )
        {
            hud.alpha = 1;
        }
        else
        {
            hud.alpha = 0.5;
        }
        
        hud moveovertime( 0.3 );
        
        if ( isdefined( hud.row ) )
        {
            hud.y = endy + hud.row * lineheight + var_3a80a7bd515e3e74;
            continue;
        }
        
        hud.y = endy;
    }
    
    wait 8.3;
    
    foreach ( hud in array )
    {
        hud fadeovertime( 2 );
        hud.alpha = 0;
    }
    
    wait 2;
    
    if ( isdefined( self.var_1c02349c6d98a704 ) )
    {
        self.var_1c02349c6d98a704--;
        
        if ( self.var_1c02349c6d98a704 < 0 )
        {
            self.var_1c02349c6d98a704 = 0;
        }
    }
    
    foreach ( i, dialogueline in player.dialoguehud )
    {
        if ( dialogueline[ 0 ] == array[ 0 ] )
        {
            player.dialoguehud[ i ] = undefined;
            
            if ( isint( i ) )
            {
                function_cdc669dbc8ea2101( player.dialoguehud );
            }
            
            break;
        }
    }
    
    if ( !player.dialoguehud.size )
    {
        player.dialoguehud = undefined;
    }
    
    foreach ( hud in array )
    {
        hud destroy();
    }
}

// Namespace ob_dialogue_util
// Params 3
// Checksum 0x37138c50, Offset: 0xc2a
// Size: 0xd2
function function_490ed9e2b5d8dd6c( players = level.players, immediate, maxlines )
{
    if ( !isarray( players ) )
    {
        array = [];
        array[ 0 ] = players;
        players = array;
    }
    
    foreach ( player in players )
    {
        if ( !isdefined( player.dialoguehud ) )
        {
            return;
        }
        
        thread function_f2a8ec6b33a9cd7d( player, immediate, maxlines );
    }
}

// Namespace ob_dialogue_util
// Params 3
// Checksum 0xad74b466, Offset: 0xd04
// Size: 0x2be
function function_f2a8ec6b33a9cd7d( player, immediate, maxlines = 0 )
{
    linestoclear = [];
    currentlines = player.dialoguehud.size;
    
    for ( i = 0; i < currentlines && currentlines - linestoclear.size > maxlines ; i++ )
    {
        player.dialoguehud[ i ][ 0 ] notify( #"hash_40e05c463bfbe415" );
        linestoclear[ linestoclear.size ] = player.dialoguehud[ i ];
        player.dialoguehud[ i ] = undefined;
    }
    
    player.dialoguehud = arraycombine( player.dialoguehud );
    
    if ( !immediate )
    {
        foreach ( dialogueline in linestoclear )
        {
            foreach ( hud in dialogueline )
            {
                if ( hud.alpha > 0 )
                {
                    hud fadeovertime( 2 );
                    hud.alpha = 0;
                }
            }
        }
        
        wait 2;
    }
    
    if ( isdefined( player.dialoguehud ) && !player.dialoguehud.size )
    {
        player.dialoguehud = undefined;
    }
    
    foreach ( dialogueline in linestoclear )
    {
        foreach ( hud in dialogueline )
        {
            if ( isdefined( hud ) )
            {
                hud destroy();
            }
        }
    }
}

/#

    // Namespace ob_dialogue_util
    // Params 0
    // Checksum 0xafa13167, Offset: 0xfca
    // Size: 0x5, Type: dev
    function function_5dd188f92cdcc2f9()
    {
        
    }

#/

// Namespace ob_dialogue_util
// Params 3
// Checksum 0xd6e31cd9, Offset: 0xfd7
// Size: 0x124
function function_cad9d9ba8c1649a8( var_6f0f75bb4949321, position, endons )
{
    self endon( #"activity_ended" );
    
    if ( isdefined( endons ) )
    {
        foreach ( str in endons )
        {
            self endon( str );
        }
    }
    
    for ( var_6ab9cab40be69133 = []; isdefined( position ) ; var_6ab9cab40be69133 = arraycombine( players, var_6ab9cab40be69133 ) )
    {
        wait 1;
        
        if ( isvector( position ) )
        {
            org = position;
        }
        else
        {
            org = position.origin;
        }
        
        players = function_51e6d195c113bf0f( org );
        
        if ( players.size > 0 && var_6ab9cab40be69133.size > 0 )
        {
            players = arrayremove( players, var_6ab9cab40be69133 );
        }
        
        if ( players.size > 0 )
        {
            activity_player_broadcasting::function_cb4750c84882dd07( var_6f0f75bb4949321, players );
        }
    }
}

// Namespace ob_dialogue_util
// Params 2
// Checksum 0x72bab018, Offset: 0x1103
// Size: 0x4d
function function_4dfe0f98d49e2245( var_6f0f75bb4949321, position )
{
    self endon( #"activity_ended" );
    wait 1;
    players = function_51e6d195c113bf0f( position );
    
    if ( players.size > 0 )
    {
        activity_player_broadcasting::function_cb4750c84882dd07( var_6f0f75bb4949321, players );
    }
}

// Namespace ob_dialogue_util
// Params 1
// Checksum 0x5773c158, Offset: 0x1158
// Size: 0xf9
function function_51e6d195c113bf0f( position )
{
    self endon( #"activity_ended" );
    players = [];
    var_37c8b9effa47207c = region_difficulty_manager::function_f9fbb630598afdc7( position );
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) )
        {
            var_973339c0023ebe8c = region_difficulty_manager::function_f9fbb630598afdc7( player.origin );
            
            if ( var_973339c0023ebe8c.index == var_37c8b9effa47207c.index && !activity_participation::function_75a087aafc3f50a4( player ) )
            {
                players[ players.size ] = player;
            }
        }
    }
    
    return players;
}

// Namespace ob_dialogue_util
// Params 4
// Checksum 0xd270bdc9, Offset: 0x125a
// Size: 0x142
function function_ef5f3aa7dd329ee9( var_6f0f75bb4949321, position, range, endons )
{
    self endon( #"activity_ended" );
    
    if ( isdefined( endons ) )
    {
        foreach ( str in endons )
        {
            self endon( str );
        }
    }
    
    if ( !isdefined( range ) )
    {
        range = 3072;
    }
    
    for ( var_6ab9cab40be69133 = []; isdefined( position ) ; var_6ab9cab40be69133 = arraycombine( players, var_6ab9cab40be69133 ) )
    {
        wait 1;
        
        if ( !isdefined( position ) )
        {
            break;
        }
        
        if ( isvector( position ) )
        {
            org = position;
        }
        else
        {
            org = position.origin;
        }
        
        players = get_free_players_in_range( org, range );
        
        if ( players.size > 0 && var_6ab9cab40be69133.size > 0 )
        {
            players = arrayremove( players, var_6ab9cab40be69133 );
        }
        
        if ( players.size > 0 )
        {
            activity_player_broadcasting::function_cb4750c84882dd07( var_6f0f75bb4949321, players );
        }
    }
}

// Namespace ob_dialogue_util
// Params 3
// Checksum 0x18d31d2a, Offset: 0x13a4
// Size: 0x86
function function_69c16219002ce52a( var_6f0f75bb4949321, position, range )
{
    self endon( #"activity_ended" );
    
    if ( !isdefined( range ) )
    {
        range = 3072;
    }
    
    if ( isvector( position ) )
    {
        org = position;
    }
    else
    {
        org = position.origin;
    }
    
    wait 1;
    players = get_free_players_in_range( org, range );
    
    if ( players.size > 0 )
    {
        activity_player_broadcasting::function_cb4750c84882dd07( var_6f0f75bb4949321, players );
    }
}

// Namespace ob_dialogue_util
// Params 2
// Checksum 0x382a69ed, Offset: 0x1432
// Size: 0xca
function get_free_players_in_range( position, range )
{
    self endon( #"activity_ended" );
    players = player_utility::script_getplayersinradius( position, range );
    
    if ( players.size > 0 )
    {
        foreach ( player in players )
        {
            if ( activity_participation::function_e7fc1202ac164928( self, player ) )
            {
                continue;
            }
            
            if ( activity_participation::function_75a087aafc3f50a4( player ) )
            {
                players = arrayremove( players, player );
            }
        }
    }
    
    return players;
}

// Namespace ob_dialogue_util
// Params 5
// Checksum 0x4362629a, Offset: 0x1505
// Size: 0xe5
function function_dc4e170d2a0bcc7b( activity_instance, banter_deck, var_f66207cc8525e0b8, wait_time = 60, loop_time = 0 )
{
    self notify( #"hash_e2346517e2037ec4" );
    self endon( #"hash_e2346517e2037ec4" );
    activity_instance endon( #"reset" );
    activity_instance endon( #"hash_90cbb55089bebc06" );
    
    if ( !isdefined( banter_deck ) )
    {
        banter_deck = utility::create_deck( [] );
    }
    
    if ( !isdefined( var_f66207cc8525e0b8 ) )
    {
        var_f66207cc8525e0b8 = utility::create_deck( [] );
    }
    
    if ( banter_deck.items.size <= 0 && var_f66207cc8525e0b8.items.size <= 0 )
    {
        return;
    }
    
    childthread function_b110fdf1206553b5( activity_instance, banter_deck, var_f66207cc8525e0b8, wait_time, loop_time );
    
    while ( true )
    {
        activity_instance waittill( #"hash_fdb9a9759eb73a30" );
        childthread function_b110fdf1206553b5( activity_instance, banter_deck, var_f66207cc8525e0b8, wait_time, loop_time );
    }
}

// Namespace ob_dialogue_util
// Params 5, eflags: 0xc
// Checksum 0xd5331d4b, Offset: 0x15f2
// Size: 0x20f
function private function_b110fdf1206553b5( activity_instance, banter_deck, var_f66207cc8525e0b8, wait_time, loop_time )
{
    self notify( #"hash_2800209b23fc381a" );
    self endon( #"hash_2800209b23fc381a" );
    activity_instance endon( #"reset" );
    activity_instance endon( #"hash_478f922a2ef2cb22" );
    activity_instance endon( #"hash_90cbb55089bebc06" );
    banter_size = banter_deck.items.size;
    banter_count = 0;
    nag_size = var_f66207cc8525e0b8.items.size;
    nag_count = 0;
    
    if ( loop_time <= 0 )
    {
        banter_size = min( banter_size, 1 );
        nag_size = min( nag_size, 1 );
        loop_time = wait_time;
    }
    
    target_deck = banter_deck;
    
    if ( banter_size <= 0 )
    {
        if ( nag_size <= 0 )
        {
            return;
        }
        
        target_deck = var_f66207cc8525e0b8;
    }
    
    /#
        if ( getdvarint( @"hash_fb7ddd656c8358e7", 0 ) > 0 )
        {
            wait_time = getdvarint( @"hash_fb7ddd656c8358e7", 0 );
            loop_time = wait_time;
        }
    #/
    
    wait wait_time;
    
    while ( banter_count < banter_size || nag_count < nag_size )
    {
        var_64bb57aa2d6e8b35 = teams::getsquaddata( activity_instance.team, activity_instance.sessionsquadid );
        
        if ( !overlord::function_dce0a14273dfa0a8( var_64bb57aa2d6e8b35.players ) )
        {
            active_dialogue = target_deck utility::deck_draw();
            
            if ( target_deck == banter_deck )
            {
                banter_count++;
                level thread overlord::playconversation( active_dialogue, var_64bb57aa2d6e8b35.players );
            }
            else
            {
                nag_count++;
                level thread overlord::playevent( active_dialogue, var_64bb57aa2d6e8b35.players );
            }
            
            squad_leader = squad_utility::getsquadleader( activity_instance.team, activity_instance.sessionsquadid );
            
            if ( banter_size <= 0 )
            {
                target_deck = var_f66207cc8525e0b8;
            }
            else if ( nag_size <= 0 )
            {
                target_deck = banter_deck;
            }
            else
            {
                target_deck = target_deck == banter_deck ? var_f66207cc8525e0b8 : banter_deck;
            }
            
            wait loop_time;
        }
        
        wait 1;
    }
}

// Namespace ob_dialogue_util
// Params 0
// Checksum 0xaed04899, Offset: 0x1809
// Size: 0xe
function pause_banter()
{
    self notify( #"hash_478f922a2ef2cb22" );
}

// Namespace ob_dialogue_util
// Params 0
// Checksum 0x44a3c1d1, Offset: 0x181f
// Size: 0xe
function progress_banter()
{
    self notify( #"hash_fdb9a9759eb73a30" );
}

// Namespace ob_dialogue_util
// Params 0
// Checksum 0x92587df8, Offset: 0x1835
// Size: 0xe
function end_banter()
{
    self notify( #"hash_90cbb55089bebc06" );
}

