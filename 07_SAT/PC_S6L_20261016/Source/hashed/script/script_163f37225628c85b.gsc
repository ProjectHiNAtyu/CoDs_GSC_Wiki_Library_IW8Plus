// script_163f37225628c85b  (hash_163f37225628c85b.gscc) (size: 3803 Bytes / 0xedb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2997a429 (697803817)
// size ...... 3803 (0xedb)
// includes .. 6   (offset: 0xe0b)
// strings ... 7   (offset: 0xe3b)
// dev strs .. 5   (offset: 0xe9f)
// exports ... 12  (offset: 0x7db)
// cseg ...... 0xd5 + 0x706 (0x7db)
// imports ... 36  (offset: 0x9bb)
// animtree1 . 0   (offset: 0xedb)
// animtree2 . 0   (offset: 0xedb)
#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\game_utility;

#namespace bgb_tokens;

// Namespace bgb_tokens
// Params 0, eflags: 0x5
// Checksum 0x219c766d, Offset: 0xf3
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"bgb_tokens", #"bgb", &__init__, &__main__ );
}

// Namespace bgb_tokens
// Params 0, eflags: 0x4
// Checksum 0x47c086fc, Offset: 0x120
// Size: 0xad
function private __init__()
{
    if ( getdvarint( @"hash_58b6c6f19581070c" ) || getdvarint( @"hash_294f374ff45e6632" ) || getmatchrulesdata( "zmData", "disableBGB" ) )
    {
        return;
    }
    
    callback::add( #"player_connect", &on_player_connect );
    callback::add( "on_round_start", &on_round_start );
    callback::add( "on_round_end", &on_round_end );
    callback::add( "zm_exfil_success", &on_round_end );
    callback::add( "zm_exfil_failure", &on_round_end );
    utility::registersharedfunc( #"bgb_token", #"hash_ced75e023f3c8a20", &function_a3411808ea4d58eb );
}

// Namespace bgb_tokens
// Params 0, eflags: 0x4
// Checksum 0x4aca78c0, Offset: 0x1d5
// Size: 0x36
function private __main__()
{
    if ( getdvarint( @"hash_58b6c6f19581070c" ) || getdvarint( @"hash_294f374ff45e6632" ) || getmatchrulesdata( "zmData", "disableBGB" ) )
    {
        return;
    }
}

// Namespace bgb_tokens
// Params 1, eflags: 0x4
// Checksum 0xfdc56b18, Offset: 0x213
// Size: 0x16
function private on_player_connect( params )
{
    /#
        thread setup_devgui();
    #/
}

// Namespace bgb_tokens
// Params 1
// Checksum 0x3008825c, Offset: 0x231
// Size: 0x8c
function on_round_start( params )
{
    foreach ( player in level.players )
    {
        player.var_a61ee633171141af = gettime();
    }
}

// Namespace bgb_tokens
// Params 1
// Checksum 0x34d96421, Offset: 0x2c5
// Size: 0x269
function on_round_end( params )
{
    n_current_time = gettime();
    a_exfil_players = params.a_exfil_players ?? level.players;
    
    foreach ( player in a_exfil_players )
    {
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        if ( !isdefined( player.var_a61ee633171141af ) || player.var_a61ee633171141af == 0 )
        {
            var_25dc583c72ac7ba9 = 0;
        }
        else
        {
            var_25dc583c72ac7ba9 = n_current_time - player.var_a61ee633171141af;
        }
        
        map_bit = utility::callsharedfunc( #"hash_7305513195fadf7e", #"get_zm_map_name_bit" );
        aeeventname = #"zm_round_end";
        aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
        var_7924c4217cee5320 = game_utility::function_67138bc0fb9151ff();
        gamemode = level.challengegamemode;
        eventparams = [];
        utility::callsharedfunc( #"challenges", #"hash_20d6b9ff2d84e1e7", aeeventname, eventparams );
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_f3034aff9c9a5f6e" ) ] = int( var_25dc583c72ac7ba9 / 1000 );
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gobblegum_earn_rate_multiplier" ) ] = int( getdvarfloat( @"hash_a4bd3657b64a4479", 1 ) * 100 );
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"pause_time_cumulative" ) ] = function_e3cd85eead6e1fc7();
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"zm_essence_collected" ) ] = player.essencegained;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"zm_map_name" ) ] = map_bit;
        
        if ( player.var_f8ed1f37b6e13f4c )
        {
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_f3034aff9c9a5f6e" ) ] = 1800;
        }
        
        if ( isdefined( aeeventid ) )
        {
            player function_2e45314624fdfdb8( aeeventid, eventparams );
        }
        
        player callback::callback( "gobble_gum_on_round_end" );
        player.var_a61ee633171141af = undefined;
    }
}

// Namespace bgb_tokens
// Params 0
// Checksum 0xfe9802ba, Offset: 0x536
// Size: 0x8e
function function_a3411808ea4d58eb()
{
    if ( getdvarint( @"hash_58b6c6f19581070c" ) || getdvarint( @"hash_294f374ff45e6632" ) || getmatchrulesdata( "zmData", "disableBGB" ) )
    {
        return 2147483647;
    }
    
    if ( !isdefined( self.var_a61ee633171141af ) || self.var_a61ee633171141af == 0 )
    {
        var_25dc583c72ac7ba9 = 0;
    }
    else
    {
        var_25dc583c72ac7ba9 = gettime() - self.var_a61ee633171141af;
    }
    
    return int( clamp( 900000 - var_25dc583c72ac7ba9, 0, 2147483647 ) );
}

/#

    // Namespace bgb_tokens
    // Params 0, eflags: 0x4
    // Checksum 0x37742e60, Offset: 0x5cd
    // Size: 0x6c, Type: dev
    function private setup_devgui()
    {
        if ( isdefined( level.ztron ) )
        {
            return;
        }
        
        self endon( #"disconnect" );
        wait 2;
        str_player_name = self.name;
        devgui::function_9082edeb5db93280( "<dev string:x24>" + str_player_name + "<dev string:x2c>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2e>", "<dev string:x4e>" + str_player_name, &function_b1fb09d59c0f32d8 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace bgb_tokens
    // Params 1
    // Checksum 0x17499ea1, Offset: 0x641
    // Size: 0x32, Type: dev
    function function_b1fb09d59c0f32d8( a_params )
    {
        player = function_fdfae7e5048bf698( a_params[ 0 ] );
        player.var_f8ed1f37b6e13f4c = 1;
    }

    // Namespace bgb_tokens
    // Params 1
    // Checksum 0x4938b9b2, Offset: 0x67b
    // Size: 0xb6, Type: dev
    function function_fdfae7e5048bf698( str_name )
    {
        foreach ( player in level.players )
        {
            if ( player.name == str_name )
            {
                return player;
            }
            
            if ( isbot( player ) )
            {
                if ( issubstr( player.name, str_name ) )
                {
                    return player;
                }
            }
        }
    }

    // Namespace bgb_tokens
    // Params 0, eflags: 0xc
    // Checksum 0x1937d15a, Offset: 0x739
    // Size: 0xa2, Type: dev
    function private set_debug_text()
    {
        self notify( #"hash_95e3f3e7647d0fcd" );
        self endon( #"hash_95e3f3e7647d0fcd" );
        self endon( #"disconnect" );
        self.var_e31fa44d3f590f81 fadeovertime( 0.05 );
        self.var_e31fa44d3f590f81.alpha = 1;
        self.var_e31fa44d3f590f81.hidden = 0;
        self.var_e31fa44d3f590f81 setdevtext( "<dev string:x69>" );
        wait 3;
        self.var_e31fa44d3f590f81 fadeovertime( 1 );
        self.var_e31fa44d3f590f81.alpha = 0;
    }

#/
