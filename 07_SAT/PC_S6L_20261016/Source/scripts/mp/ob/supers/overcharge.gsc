// scripts\mp\ob\supers\overcharge.gsc  (hash_58674f062edcfadb.gscc) (size: 14322 Bytes / 0x37f2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8c6b3901 (2355837185)
// size ...... 14322 (0x37f2)
// includes .. 17  (offset: 0x363a)
// strings ... 9   (offset: 0x36c2)
// dev strs .. 7   (offset: 0x379e)
// exports ... 57  (offset: 0x1d02)
// cseg ...... 0xff + 0x1c03 (0x1d02)
// imports ... 140 (offset: 0x25ea)
// animtree1 . 0   (offset: 0x37f2)
// animtree2 . 0   (offset: 0x37f2)
#using script_16ea1b94f0f381b3;
#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\armor;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\equipment;
#using scripts\mp\hud_util;
#using scripts\mp\loot\common_item_ammo;
#using scripts\mp\rank;
#using scripts\mp\supers;

#namespace overcharge;

// Namespace overcharge
// Params 0, eflags: 0x5
// Checksum 0x26893bd2, Offset: 0x11d
// Size: 0x18
function private autoexec main()
{
    level callback::add( #"register_super", &register );
}

// Namespace overcharge
// Params 1, eflags: 0x4
// Checksum 0x2fb275f7, Offset: 0x13d
// Size: 0x107
function private register( params )
{
    static_data = level.superglobals.staticsuperdata[ "super_overcharge" ];
    
    if ( !isdefined( static_data ) )
    {
        level callback::remove( #"player_spawned", &function_1a8f8a0a1cca3af0 );
        return;
    }
    
    bundle = static_data.bundle;
    
    if ( !isdefined( bundle ) )
    {
        level callback::remove( #"player_spawned", &function_1a8f8a0a1cca3af0 );
        return;
    }
    
    level callback::add( #"on_ai_killed", &function_169d1ccb4f276163 );
    level callback::add( #"player_death", &function_169d1ccb4f276163 );
    
    if ( isdefined( params.var_a3817c24c60dccd2 ) )
    {
        level [[ params.var_a3817c24c60dccd2 ]]( "super_overcharge", undefined, undefined, &used, undefined, undefined, &function_9a52c179a63a2121, undefined );
        supers_mp::function_19492daedcf2689a( "super_overcharge", &get_buff_duration );
    }
    
    level callback::add( #"player_spawned", &function_1a8f8a0a1cca3af0 );
}

// Namespace overcharge
// Params 1, eflags: 0x4
// Checksum 0xf6ca9416, Offset: 0x24c
// Size: 0x61, Type: bool
function private get_buff_duration( super_info )
{
    time = undefined;
    
    if ( isdefined( super_info ) )
    {
        time = super_info.staticdata.usetime;
    }
    else
    {
        bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_overcharge" );
        time = bundle.usetime;
    }
    
    return time ?? 0;
}

// Namespace overcharge
// Params 0, eflags: 0x4
// Checksum 0x8fa33f8e, Offset: 0x2b6
// Size: 0x9
function private function_9a52c179a63a2121()
{
    thread function_1a8f8a0a1cca3af0();
}

// Namespace overcharge
// Params 1, eflags: 0xc
// Checksum 0xcb9fc22, Offset: 0x2c7
// Size: 0x92
function private function_1a8f8a0a1cca3af0( params )
{
    self notify( #"hash_9d267c04d5d14c47" );
    self endon( #"hash_9d267c04d5d14c47" );
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        childthread function_fb29bdf221d35a78();
        
        if ( !function_a657e71349e9436b() )
        {
            remove_widget();
            break;
        }
        
        super_slot = supers_mp::getsuperslot( "super_overcharge" );
        remove_notify = supers_mp::function_cc6f5a44b1441e16( super_slot, "remove_super" );
        utility::waittill_any( remove_notify, "overcharge_used" );
    }
}

// Namespace overcharge
// Params 0, eflags: 0x4
// Checksum 0x65cc1744, Offset: 0x361
// Size: 0x9d, Type: bool
function private function_a657e71349e9436b()
{
    super_slot = supers_mp::getsuperslot( "super_overcharge" );
    super_name = supers_mp::getcurrentsuperref( super_slot );
    
    if ( super_slot == #"tactical" )
    {
        tactical_ref = equipment_mp::getcurrentequipment( "secondary" );
        var_7d9d3c52270ed058 = equipment_mp::getequipmentammo( tactical_ref );
    }
    
    if ( super_name != "super_overcharge" || var_7d9d3c52270ed058 <= 0 || !( super_slot != #"default" || supers_mp::issuperready( undefined, #"default" ) ) )
    {
        return false;
    }
    
    return true;
}

// Namespace overcharge
// Params 0, eflags: 0xc
// Checksum 0x896d8c35, Offset: 0x407
// Size: 0x186
function private function_fb29bdf221d35a78()
{
    self notify( #"hash_b8f48ac82dc8cc73" );
    self endon( #"hash_b8f48ac82dc8cc73" );
    super_slot = supers_mp::getsuperslot( "super_overcharge" );
    notify_remove = supers_mp::function_cc6f5a44b1441e16( super_slot, "remove_super" );
    self endon( notify_remove );
    self endon( #"overcharge_used" );
    
    if ( !function_a657e71349e9436b() )
    {
        remove_widget();
        return;
    }
    
    static_data = level.superglobals.staticsuperdata[ "super_overcharge" ];
    bundle = static_data.bundle;
    self.var_541dcec97b6ef957 = { #owningplayer:self, #bundle:bundle };
    buff_radius = bundle.var_435465451488baff ?? 0;
    nearby_squadmates = [];
    nearby_squadmates[ nearby_squadmates.size ] = self;
    set_targets( nearby_squadmates, undefined, bundle );
    
    if ( level.teambased )
    {
        /#
            if ( getdvarint( @"hash_cb4d7e69214dc8ff", 0 ) )
            {
                childthread function_c16ab21f85281427( buff_radius );
            }
        #/
        
        while ( true )
        {
            nearby_squadmates = squad_utility::function_ed1cc36405244cd4( buff_radius, 0 );
            var_9d8d46552b880a0b = undefined;
            var_bddbd99649025a8c = utility::callsharedfunc( #"super_overcharge", #"hash_429fa6953cdb7c8e" ) ?? 0;
            
            if ( var_bddbd99649025a8c )
            {
                var_9d8d46552b880a0b = function_f5762c7aecaf6c64( buff_radius );
            }
            
            set_targets( nearby_squadmates, var_9d8d46552b880a0b, bundle );
            wait 0.2;
        }
    }
}

// Namespace overcharge
// Params 3, eflags: 0x4
// Checksum 0xf77d108f, Offset: 0x595
// Size: 0x14b
function private set_targets( nearby_players, var_a64dbe74f2f3f2bd, bundle )
{
    self.overchargetargets = nearby_players;
    self.var_b67faeedf0ff76eb = var_a64dbe74f2f3f2bd;
    
    if ( !nearby_players.size )
    {
        if ( bundle.var_bf6498fb13191c07 )
        {
            self setclientomnvar( bundle.var_bf6498fb13191c07, 0 );
        }
        
        if ( bundle.var_402d844eda5cbec6 )
        {
            self setclientomnvar( bundle.var_402d844eda5cbec6, 0 );
        }
        
        return;
    }
    
    squad_size = squad_utility::getsquadsize( self );
    
    if ( bundle.var_bf6498fb13191c07 )
    {
        self setclientomnvar( bundle.var_bf6498fb13191c07, squad_size - 1 );
    }
    
    if ( bundle.var_402d844eda5cbec6 )
    {
        if ( squad_size == 1 && !var_a64dbe74f2f3f2bd )
        {
            self setclientomnvar( bundle.var_402d844eda5cbec6, 0 );
            return;
        }
        
        assert( bundle.var_86497c9dc7265f1f, "<dev string:x24>" );
        self setclientomnvar( bundle.var_86497c9dc7265f1f, nearby_players.size - 1 );
        total_targets = nearby_players.size + ( var_a64dbe74f2f3f2bd ? var_a64dbe74f2f3f2bd.size : 0 );
        self setclientomnvar( bundle.var_402d844eda5cbec6, int( min( total_targets, 16 ) ) );
    }
}

// Namespace overcharge
// Params 0, eflags: 0x4
// Checksum 0xd4ab8029, Offset: 0x6e8
// Size: 0x6e, Type: bool
function private used()
{
    self endon( #"death_or_disconnect" );
    self notify( #"overcharge_used" );
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_overcharge" );
    function_48ecc1b3dc185dc7( bundle );
    thread function_255bc165344d3784( bundle.var_954628c402dcf42f );
    function_20fe13b386bb5f6b( bundle );
    thread buff_squadmates();
    function_bb8477042cbd9e20( bundle );
    childthread used_battlechatter();
    return true;
}

// Namespace overcharge
// Params 0, eflags: 0x4
// Checksum 0x21853fe6, Offset: 0x75f
// Size: 0xc
function private used_battlechatter()
{
    wait 3;
    battlechatter_mp::function_f3ffc3fa6aa3a992();
}

// Namespace overcharge
// Params 0, eflags: 0x4
// Checksum 0x614b1d8c, Offset: 0x773
// Size: 0x3e
function private remove_widget()
{
    waitframe();
    
    if ( self )
    {
        bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_overcharge" );
        
        if ( bundle.var_402d844eda5cbec6 )
        {
            self setclientomnvar( bundle.var_402d844eda5cbec6, 0 );
        }
    }
}

// Namespace overcharge
// Params 0, eflags: 0x4
// Checksum 0xcab307ac, Offset: 0x7b9
// Size: 0x132
function private buff_squadmates()
{
    self endon( #"death_or_disconnect" );
    
    if ( !isdefined( self.overchargetargets ) || self.overchargetargets.size == 0 )
    {
        return;
    }
    
    foreach ( ent in self.overchargetargets )
    {
        if ( ent )
        {
            apply_buff( ent );
        }
        
        waitframe();
    }
    
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_overcharge" );
    var_2bdf3cf428503af5 = self.overchargetargets.size - 1;
    
    if ( var_2bdf3cf428503af5 > 0 )
    {
        function_e5f5b6b414a252fe( bundle, var_2bdf3cf428503af5 );
    }
    
    function_3f8519253f6c1f21( bundle );
    utility::callsharedfunc( #"challenges", #"hash_c1ac67fc66891430", "super_overcharge", ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"use" ), self.overchargetargets.size );
}

// Namespace overcharge
// Params 1, eflags: 0x4
// Checksum 0x7dc7ecab, Offset: 0x8f3
// Size: 0xc1
function private apply_buff( player )
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_overcharge" );
    player.var_598587b9c1ad0e71 = self.var_541dcec97b6ef957;
    
    if ( player != self )
    {
        player.overchargebuffs[ self getentitynumber() ] = self.var_541dcec97b6ef957;
        var_cd34803eda35ad4b = bundle.var_b17c4312ef947596;
        
        if ( var_cd34803eda35ad4b )
        {
            function_9b0065d6803f0742( player, var_cd34803eda35ad4b );
        }
    }
    
    if ( !player.var_962fe2e37d13d847 )
    {
        player play_feedback( bundle, self );
        player function_5f8b74b211d28dda( bundle, self );
        buff_duration_ms = get_buff_duration() * 1000;
        player thread monitor_buff( buff_duration_ms, bundle, self );
    }
}

// Namespace overcharge
// Params 3, eflags: 0xc
// Checksum 0x6d0b0808, Offset: 0x9bc
// Size: 0xf0
function private monitor_buff( duration_ms, super_bundle, super_owner )
{
    self notify( #"hash_e39697627091f639" );
    self endon( #"hash_e39697627091f639" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self.var_962fe2e37d13d847 = 1;
    time_ms = gettime();
    buff_chrono = spawnstruct();
    buff_end_time_ms = time_ms + duration_ms;
    
    while ( time_ms < buff_end_time_ms )
    {
        time_ms = gettime();
        function_e6ac1ef5c62a77b3( super_bundle, buff_chrono );
        time_left_ms = max( buff_end_time_ms - time_ms, 0 );
        result = utility::waittill_notify_or_timeout_return( "death", min( 0.5, time_left_ms * 0.001 ) );
        
        if ( result == "death" )
        {
            break;
        }
    }
    
    end_buff( super_bundle, super_owner );
}

// Namespace overcharge
// Params 1, eflags: 0x4
// Checksum 0xc2222311, Offset: 0xab4
// Size: 0x17
function private get_fullscreen_fx_overlay( bundle )
{
    return bundle.var_e6225dde71b5895d;
}

// Namespace overcharge
// Params 2, eflags: 0x4
// Checksum 0x67c5e589, Offset: 0xad4
// Size: 0xf4
function private play_feedback( super_bundle, owner_player )
{
    if ( !isplayer( self ) || isbot( self ) )
    {
        return;
    }
    
    fullscreen_overlay_fx = get_fullscreen_fx_overlay( super_bundle );
    function_adca1e04dd24d31d( fullscreen_overlay_fx );
    
    if ( owner_player != self )
    {
        thread function_255bc165344d3784( super_bundle.var_73743ac6a65adce6 );
    }
    
    function_d5bf26cf8c19220b( super_bundle );
    
    if ( super_bundle.var_70d80b41f4600d3 )
    {
        var_de9a090a334dcbd4 = super_bundle.var_f1abe69c706500aa;
        var_d3317af20676e42a = super_bundle.var_68e375da07a76f3f;
        valid_data = isdefined( fullscreen_overlay_fx ) && isdefined( var_de9a090a334dcbd4 ) && isdefined( var_d3317af20676e42a );
        assert( valid_data, "<dev string:x84>" );
        
        if ( valid_data )
        {
            buff_end_time = gettime() + get_buff_duration() * 1000;
            thread function_f2161336a3cc8fa9( buff_end_time, fullscreen_overlay_fx, var_de9a090a334dcbd4, var_d3317af20676e42a );
        }
    }
}

// Namespace overcharge
// Params 1, eflags: 0x4
// Checksum 0x7aaee1fa, Offset: 0xbd0
// Size: 0x9f
function private function_bb8477042cbd9e20( bundle )
{
    if ( !self.var_b67faeedf0ff76eb.size )
    {
        return;
    }
    
    foreach ( player in self.var_b67faeedf0ff76eb )
    {
        if ( isalive( player ) )
        {
            player function_d27263992c63aba5( bundle, self );
        }
    }
}

// Namespace overcharge
// Params 1, eflags: 0x4
// Checksum 0xffb0c797, Offset: 0xc77
// Size: 0xd5
function private function_f5762c7aecaf6c64( radius )
{
    players = getplayersinradius( self.origin, radius );
    allies = [];
    
    foreach ( player in players )
    {
        if ( !player_utility::isfriendly( self.team, player ) )
        {
            continue;
        }
        
        if ( self.sessionsquadid == player.sessionsquadid )
        {
            continue;
        }
        
        allies[ allies.size ] = player;
    }
    
    return allies;
}

// Namespace overcharge
// Params 2, eflags: 0x4
// Checksum 0x34bef16b, Offset: 0xd55
// Size: 0x9f
function private end_buff( super_bundle, super_owner )
{
    function_429be17849ec1d68( super_bundle );
    function_6c37d6470298eb07();
    
    if ( isplayer( self ) && !isbot( self ) )
    {
        fullscreen_overlay_fx = get_fullscreen_fx_overlay( super_bundle );
        function_1cd2ac8ddbc5e3ba( fullscreen_overlay_fx );
        function_398195e8d031589a( super_bundle );
    }
    
    if ( function_2289bd8afb9d55d9( super_owner ) )
    {
        self.var_598587b9c1ad0e71 = undefined;
    }
    
    if ( super_owner != self )
    {
        self.overchargebuffs[ super_owner getentitynumber() ] = undefined;
    }
    
    self.var_962fe2e37d13d847 = undefined;
    self notify( #"overcharge_expired" );
}

// Namespace overcharge
// Params 4, eflags: 0x4
// Checksum 0x371ad7c6, Offset: 0xdfc
// Size: 0xbd
function private function_f2161336a3cc8fa9( buff_end_time, overlay_asset, duration, frequency )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"overcharge_expired" );
    var_9a7d6796cb3dbe1a = ( buff_end_time - gettime() ) * 0.001 - duration;
    wait var_9a7d6796cb3dbe1a;
    var_b9b15168a239b871 = frequency * 0.5;
    doing_fade_out = 0;
    
    while ( true )
    {
        if ( doing_fade_out )
        {
            function_adca1e04dd24d31d( overlay_asset );
        }
        else
        {
            function_1cd2ac8ddbc5e3ba( overlay_asset );
        }
        
        doing_fade_out = !doing_fade_out;
        wait var_b9b15168a239b871;
    }
}

// Namespace overcharge
// Params 1, eflags: 0x4
// Checksum 0x9723f9e6, Offset: 0xec1
// Size: 0x3b
function private function_adca1e04dd24d31d( overlay_asset )
{
    if ( isdefined( overlay_asset ) )
    {
        utility::callsharedfunc( #"fullscreenfx", #"hash_382df7654f0561bd", { #postfxbundlename:overlay_asset }, 1, 1 );
    }
}

// Namespace overcharge
// Params 1, eflags: 0x4
// Checksum 0xd1d60682, Offset: 0xf04
// Size: 0x37
function private function_1cd2ac8ddbc5e3ba( overlay_asset )
{
    if ( isdefined( overlay_asset ) )
    {
        utility::callsharedfunc( #"fullscreenfx", #"hash_494b07757cd511a5", { #postfxbundlename:overlay_asset } );
    }
}

// Namespace overcharge
// Params 1, eflags: 0x4
// Checksum 0xd67f79f9, Offset: 0xf43
// Size: 0x31
function private function_d5bf26cf8c19220b( super_bundle )
{
    sfx = super_bundle.var_b47883ac3620b6d3;
    
    if ( sfx )
    {
        self playsoundtoplayer( sfx, self );
    }
}

// Namespace overcharge
// Params 1, eflags: 0x4
// Checksum 0x9bf295ce, Offset: 0xf7c
// Size: 0x31
function private function_398195e8d031589a( super_bundle )
{
    sfx = super_bundle.var_98c6672a7dd0df66;
    
    if ( sfx )
    {
        self playsoundtoplayer( sfx, self );
    }
}

// Namespace overcharge
// Params 2, eflags: 0x4
// Checksum 0xed2db914, Offset: 0xfb5
// Size: 0x56
function private function_5f8b74b211d28dda( super_bundle, super_owner )
{
    function_ec562c9c11c1df3( super_bundle, super_owner );
    function_ca6288d9dac3ea06( super_bundle, super_owner );
    function_d27263992c63aba5( super_bundle, super_owner );
    function_bdbd6fd1ebd5d2ec( super_bundle );
    function_b598af7fffa1e5ab( super_bundle, super_owner );
    
    if ( self != super_owner )
    {
        function_f44f6b31fb399ab2( super_bundle );
    }
}

// Namespace overcharge
// Params 2, eflags: 0x4
// Checksum 0x985dc796, Offset: 0x1013
// Size: 0x1f
function private function_e6ac1ef5c62a77b3( super_bundle, buff_chrono )
{
    function_e179ae50d9a6581e( super_bundle, buff_chrono );
}

// Namespace overcharge
// Params 1, eflags: 0x4
// Checksum 0xd6d5d62f, Offset: 0x103a
// Size: 0x15
function private function_429be17849ec1d68( super_bundle )
{
    function_8cdb50d8c7e3460d( super_bundle );
}

// Namespace overcharge
// Params 0, eflags: 0x4
// Checksum 0x2037ca11, Offset: 0x1057
// Size: 0x9
function private function_6c37d6470298eb07()
{
    function_753c1bd63ebb7871();
}

// Namespace overcharge
// Params 2, eflags: 0x4
// Checksum 0xdc9252c0, Offset: 0x1068
// Size: 0x5d
function private function_ec562c9c11c1df3( super_bundle, super_owner )
{
    if ( supers_mp::isusingsuperweapon( #"default" ) )
    {
        percentage = function_2e15fe8fce0e53a9( super_bundle, super_owner ) ?? 0;
        function_a454b0cdc041e9b( super_bundle, percentage );
        return;
    }
    
    function_2cef8552bb0fba6d( super_bundle );
    function_ef5715b368a543bf( super_bundle );
}

// Namespace overcharge
// Params 2, eflags: 0x4
// Checksum 0x45b17d89, Offset: 0x10cd
// Size: 0x35
function private function_2e15fe8fce0e53a9( super_bundle, super_owner )
{
    return self == super_owner ? super_bundle.var_f79b2427365222e4 : super_bundle.var_38f368f7475cc8be;
}

// Namespace overcharge
// Params 1, eflags: 0x4
// Checksum 0x62a85aec, Offset: 0x110b
// Size: 0x48
function private function_2cef8552bb0fba6d( super_bundle )
{
    if ( !super_bundle.var_28ad501cce887767 )
    {
        return;
    }
    
    current_weapon = self getcurrentweapon();
    
    if ( function_673362ca47215d36( current_weapon ) )
    {
        item_ammo::function_5b3e00ec8cebdbea( undefined, 1, 1, 0 );
    }
}

// Namespace overcharge
// Params 2, eflags: 0x4
// Checksum 0x3f1e6c31, Offset: 0x115b
// Size: 0xee
function private function_e179ae50d9a6581e( super_bundle, buff_chrono )
{
    var_b08c3638b72fb45 = super_bundle.var_4e0e9a51e9682ed;
    
    if ( !isdefined( var_b08c3638b72fb45 ) )
    {
        return;
    }
    
    cooldown = super_bundle.var_29fa38cfe2a39cec;
    time_ms = gettime();
    
    if ( !isdefined( buff_chrono.var_247e732dd0cc4451 ) )
    {
        buff_chrono.var_247e732dd0cc4451 = time_ms;
    }
    
    if ( ( time_ms - buff_chrono.var_247e732dd0cc4451 ) * 0.001 < cooldown )
    {
        return;
    }
    
    buff_chrono.var_247e732dd0cc4451 = undefined;
    primary_equip_ref = equipment_mp::getcurrentequipment( "primary" );
    
    if ( primary_equip_ref )
    {
        equipment_mp::incrementequipmentammo( primary_equip_ref, var_b08c3638b72fb45 );
    }
    
    if ( !level.var_b7e70fa484e134dc )
    {
        secondary_equip_ref = equipment_mp::getcurrentequipment( "secondary" );
        
        if ( secondary_equip_ref )
        {
            equipment_mp::incrementequipmentammo( secondary_equip_ref, var_b08c3638b72fb45 );
        }
    }
}

// Namespace overcharge
// Params 1, eflags: 0x4
// Checksum 0xec618b7f, Offset: 0x1251
// Size: 0x45
function private function_f44f6b31fb399ab2( super_bundle )
{
    if ( !isdefined( super_bundle.var_1462ad4fc867b96a ) )
    {
        return;
    }
    
    perk::giveperk( "specialty_faster_field_upgrade" );
    val::set( "super_overcharge", "field_upgrade_recharge_mult", super_bundle.var_1462ad4fc867b96a );
}

// Namespace overcharge
// Params 1, eflags: 0x4
// Checksum 0xe77719d5, Offset: 0x129e
// Size: 0x8f
function private function_8cdb50d8c7e3460d( super_bundle )
{
    if ( !super_bundle.var_4650120affb6b730 )
    {
        return;
    }
    
    primary_equip_ref = equipment_mp::getcurrentequipment( "primary" );
    var_382c92ced2f61c35 = equipment_mp::getequipmentmaxammo( primary_equip_ref );
    equipment_mp::setequipmentammo( primary_equip_ref, var_382c92ced2f61c35, var_382c92ced2f61c35 );
    
    if ( !level.var_b7e70fa484e134dc )
    {
        secondary_equip_ref = equipment_mp::getcurrentequipment( "secondary" );
        var_f9720a7bbc3dc8a5 = equipment_mp::getequipmentmaxammo( secondary_equip_ref );
        equipment_mp::setequipmentammo( secondary_equip_ref, var_f9720a7bbc3dc8a5, var_f9720a7bbc3dc8a5 );
    }
}

// Namespace overcharge
// Params 1, eflags: 0x4
// Checksum 0x7df89f63, Offset: 0x1335
// Size: 0x60
function private function_ef5715b368a543bf( super_bundle )
{
    if ( !super_bundle.var_ed280eb631d0702 )
    {
        return;
    }
    
    primary_weapon = self getcurrentweapon();
    
    if ( function_673362ca47215d36( primary_weapon ) )
    {
        var_b3ad3ff580f72fb = weaponclipsize( primary_weapon );
        item_ammo::function_d668d164f515b571( self, primary_weapon, var_b3ad3ff580f72fb * super_bundle.var_ed280eb631d0702 );
    }
}

// Namespace overcharge
// Params 2, eflags: 0x4
// Checksum 0xdcc6cc32, Offset: 0x139d
// Size: 0xd4
function private function_ca6288d9dac3ea06( super_bundle, super_owner )
{
    var_1eace92b576a584e = super_owner utility::callsharedfunc( #"super_overcharge", #"hash_5414cd4daff8eb00" ) ?? super_bundle.var_188f7838bbcb6cc5;
    
    if ( !var_1eace92b576a584e )
    {
        return;
    }
    
    var_75719f12dac7d8dc = armor::function_22290101992e4874();
    armor::function_164c824617d7e8d7( var_1eace92b576a584e );
    newplatecount = armor::function_22290101992e4874();
    platedifference = newplatecount - var_75719f12dac7d8dc;
    
    if ( platedifference <= 0 )
    {
        return;
    }
    
    super_owner callback::callback( #"resupply_armor_plates", { #buffedplayer:self, #source:#"super_overcharge", #platecount:platedifference, #superowner:super_owner } );
}

// Namespace overcharge
// Params 2, eflags: 0x4
// Checksum 0x77d0a16c, Offset: 0x1479
// Size: 0xbe
function private function_d27263992c63aba5( super_bundle, super_owner )
{
    if ( !super_bundle.var_83d28142c7019333 )
    {
        return;
    }
    
    primary_equip_ref = equipment_mp::getcurrentequipment( "primary" );
    
    if ( primary_equip_ref )
    {
        current_ammo = equipment_mp::getequipmentammo( primary_equip_ref );
        max_ammo = equipment_mp::getequipmentmaxammo( primary_equip_ref );
        
        if ( current_ammo < max_ammo )
        {
            fully_refill = super_owner utility::callsharedfunc( #"super_overcharge", #"hash_93a2a2cba40b1c22", self ) ?? 0;
            var_bd48e8dd61a3c03c = fully_refill ? max_ammo : super_bundle.var_83d28142c7019333;
            equipment_mp::incrementequipmentammo( primary_equip_ref, var_bd48e8dd61a3c03c );
        }
    }
}

// Namespace overcharge
// Params 2, eflags: 0x4
// Checksum 0x728dd10d, Offset: 0x153f
// Size: 0x78, Type: bool
function private function_95968d4547a275d1( super_bundle, tactical_ref )
{
    current_ammo = equipment_mp::getequipmentammo( tactical_ref );
    max_ammo = equipment_mp::getequipmentmaxammo( tactical_ref );
    var_86b25c7af09df592 = super_bundle.var_3ae73858df3bf3c;
    threshold_passed = !isdefined( var_86b25c7af09df592 ) || var_86b25c7af09df592 < 0 || current_ammo <= var_86b25c7af09df592;
    return current_ammo < max_ammo && threshold_passed;
}

// Namespace overcharge
// Params 1, eflags: 0x4
// Checksum 0x6644c47a, Offset: 0x15c0
// Size: 0x84
function private function_bdbd6fd1ebd5d2ec( super_bundle )
{
    if ( !super_bundle.var_5842a5b89b1be2b3 )
    {
        return;
    }
    
    if ( level.var_b7e70fa484e134dc && supers_mp::function_31f00fe6e0334d03( #"tactical" ) )
    {
        tactical_ref = equipment_mp::getcurrentequipment( "secondary" );
        assert( tactical_ref );
        
        if ( tactical_ref )
        {
            if ( function_95968d4547a275d1( super_bundle, tactical_ref ) )
            {
                equipment_mp::incrementequipmentslotammo( "secondary", super_bundle.var_5842a5b89b1be2b3 );
            }
        }
    }
}

// Namespace overcharge
// Params 0, eflags: 0x4
// Checksum 0x2c40ebf8, Offset: 0x164c
// Size: 0x51
function private function_753c1bd63ebb7871()
{
    val::reset( "super_overcharge", "field_upgrade_recharge_mult" );
    recharge_mult = val::get( "field_upgrade_recharge_mult" );
    
    if ( !isdefined( recharge_mult ) && isdefined( self.perks[ "specialty_faster_field_upgrade" ] ) )
    {
        perk::removeperk( "specialty_faster_field_upgrade" );
    }
}

// Namespace overcharge
// Params 2, eflags: 0x4
// Checksum 0x4f91cc86, Offset: 0x16a5
// Size: 0x117
function private function_a454b0cdc041e9b( super_bundle, percentage )
{
    if ( !percentage )
    {
        return;
    }
    
    superinfo = supers_mp::getcurrentsuper( #"default" );
    useweapon = supers_mp::function_6c912116c8af1159( superinfo );
    
    if ( !useweapon )
    {
        return;
    }
    
    clip_size = supers_mp::function_9927ca332693e216( superinfo );
    ammo_to_add = int( clip_size * percentage );
    var_8d3454d1b5219ce = self getweaponammoclip( useweapon );
    target_clip = var_8d3454d1b5219ce + ammo_to_add;
    
    if ( super_bundle.var_6d7ac0e26a0eab59 && target_clip > clip_size )
    {
        var_6ec6573a4ffba907 = int( target_clip );
    }
    else
    {
        var_6ec6573a4ffba907 = int( min( target_clip, clip_size ) );
    }
    
    if ( var_6ec6573a4ffba907 > var_8d3454d1b5219ce )
    {
        assert( var_6ec6573a4ffba907 <= weaponclipsize( useweapon ), "<dev string:xdb>" + var_6ec6573a4ffba907 + "<dev string:x101>" + useweapon.basename + "<dev string:x11c>" + weaponclipsize( useweapon ) + "<dev string:x146>" );
        self setweaponammoclip( useweapon, var_6ec6573a4ffba907 );
    }
}

// Namespace overcharge
// Params 1, eflags: 0x4
// Checksum 0xb35b34ec, Offset: 0x17c4
// Size: 0x2d
function private function_fe706e38d7ba8fd3( super_bundle )
{
    if ( isdefined( super_bundle.var_5f86f0f12b2da30e ) )
    {
        namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( super_bundle.var_5f86f0f12b2da30e );
    }
}

// Namespace overcharge
// Params 1, eflags: 0x4
// Checksum 0x893e3431, Offset: 0x17f9
// Size: 0x2d
function private function_b69f60f4345f46b4( super_bundle )
{
    if ( isdefined( super_bundle.var_44fcafbf148d0ac9 ) )
    {
        namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( super_bundle.var_44fcafbf148d0ac9 );
    }
}

// Namespace overcharge
// Params 2, eflags: 0x4
// Checksum 0xf454d650, Offset: 0x182e
// Size: 0x90
function private function_e5f5b6b414a252fe( super_bundle, allies_count )
{
    event_name = super_bundle.var_39dcd8517c02ffe9;
    
    if ( isdefined( event_name ) )
    {
        event_xp = rank::getscoreinfoxp( event_name ) ?? 0;
        event_points = rank::getscoreinfovalue( event_name ) ?? 0;
        var_c128d622cc820d2 = event_points * allies_count;
        var_8f92616d51134d99 = event_xp * allies_count;
        namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( super_bundle.var_39dcd8517c02ffe9, undefined, var_c128d622cc820d2, var_8f92616d51134d99 );
    }
}

// Namespace overcharge
// Params 1, eflags: 0x4
// Checksum 0x596522be, Offset: 0x18c6
// Size: 0x2c
function private function_3f8519253f6c1f21( super_bundle )
{
    if ( super_bundle.var_c1595b1899c46f9b )
    {
        namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( super_bundle.var_c1595b1899c46f9b );
    }
}

// Namespace overcharge
// Params 1, eflags: 0x4
// Checksum 0xff2f1efa, Offset: 0x18fa
// Size: 0x68
function private function_169d1ccb4f276163( params )
{
    attacker = params.eattacker ?? params.attacker;
    
    if ( !isdefined( attacker ) || !isdefined( attacker.var_598587b9c1ad0e71 ) )
    {
        return;
    }
    
    attacker function_5aa3e201e158d1c1( attacker.var_598587b9c1ad0e71.bundle );
}

// Namespace overcharge
// Params 1, eflags: 0x4
// Checksum 0x475989c5, Offset: 0x196a
// Size: 0x5f
function private function_5aa3e201e158d1c1( super_bundle )
{
    killer = self;
    
    if ( killer == killer.var_598587b9c1ad0e71.owningplayer )
    {
        killer function_fe706e38d7ba8fd3( super_bundle );
        return;
    }
    
    killer.var_598587b9c1ad0e71.owningplayer function_b69f60f4345f46b4( super_bundle );
}

// Namespace overcharge
// Params 1, eflags: 0x4
// Checksum 0x65c25f36, Offset: 0x19d1
// Size: 0x2b, Type: bool
function private function_673362ca47215d36( weapon )
{
    return !weapon::iskillstreakweapon( weapon.basename ) && !weapon::issuperweapon( weapon );
}

// Namespace overcharge
// Params 1, eflags: 0x4
// Checksum 0x89f1d3b0, Offset: 0x1a05
// Size: 0x67
function private function_48ecc1b3dc185dc7( bundle )
{
    shader = bundle.var_17fb8369e7b0b961;
    
    if ( shader )
    {
        var_2ab9ed5f59c446f4 = hud_util::function_cd054751d2d5b5c5( shader );
        var_2ab9ed5f59c446f4 thread hud_util::function_d69ae82e9a4716aa( self, bundle.var_7afb8259471f1cf9, bundle.var_b8b25ccfe378ceb2, bundle.var_568ae2734e0e9026, 1 );
    }
}

// Namespace overcharge
// Params 1, eflags: 0x4
// Checksum 0xcd7b198a, Offset: 0x1a74
// Size: 0xb1
function private function_255bc165344d3784( overlay_data )
{
    if ( !overlay_data.asset || !overlay_data.duration )
    {
        return;
    }
    
    utility::callsharedfunc( #"fullscreenfx", #"hash_382df7654f0561bd", { #postfxbundlename:overlay_data.asset }, 1, 1 );
    utility::waittill_any_in_array_or_timeout( [ "death", "disconnect" ], overlay_data.duration );
    utility::callsharedfunc( #"fullscreenfx", #"hash_494b07757cd511a5", { #postfxbundlename:overlay_data.asset } );
}

// Namespace overcharge
// Params 1, eflags: 0x4
// Checksum 0xb4cd2e7b, Offset: 0x1b2d
// Size: 0x50
function private function_20fe13b386bb5f6b( super_bundle )
{
    part = super_bundle.var_2c695b17f23b3507;
    state = super_bundle.var_e08f7b16c86912f3;
    
    if ( !part && !state )
    {
        return;
    }
    
    utility::function_32b24db3127bff40( part, state );
}

/#

    // Namespace overcharge
    // Params 1, eflags: 0xc
    // Checksum 0x1bd4928c, Offset: 0x1b85
    // Size: 0x83, Type: dev
    function private function_c16ab21f85281427( radius )
    {
        self notify( #"hash_c17e30f3f726b21b" );
        self endon( #"hash_c17e30f3f726b21b" );
        
        while ( true )
        {
            text_distance = "<dev string:x182>" + string( radius );
            printtoscreen2d( 500, 350, text_distance, ( 1, 1, 1 ), 2 );
            sphere( self.origin, radius, ( 0, 1, 0 ), 1 );
            waitframe();
        }
    }

#/

// Namespace overcharge
// Params 2, eflags: 0x4
// Checksum 0xfa88ecf8, Offset: 0x1c10
// Size: 0x33
function private function_938dcfd365228b85( super_bundle, super_owner )
{
    if ( self == super_owner )
    {
        return super_bundle.var_71a516c27da27451;
    }
    
    return super_bundle.var_77a0c862d1831796;
}

// Namespace overcharge
// Params 2, eflags: 0x4
// Checksum 0xe30cbbfa, Offset: 0x1c4c
// Size: 0x38
function private function_b598af7fffa1e5ab( super_bundle, super_owner )
{
    var_ae0fa0aea45b833e = function_938dcfd365228b85( super_bundle, super_owner );
    
    if ( var_ae0fa0aea45b833e )
    {
        supers_mp::givesuperpoints( var_ae0fa0aea45b833e );
    }
}

// Namespace overcharge
// Params 1, eflags: 0x4
// Checksum 0x2ea4619, Offset: 0x1c8c
// Size: 0x3b
function private get_player_buff_data( super_owner )
{
    if ( self == super_owner )
    {
        return self.var_541dcec97b6ef957;
    }
    
    if ( self.overchargebuffs.size )
    {
        return self.overchargebuffs[ super_owner getentitynumber() ];
    }
}

// Namespace overcharge
// Params 2, eflags: 0x4
// Checksum 0x3e7c979, Offset: 0x1cd0
// Size: 0x31, Type: bool
function private function_2289bd8afb9d55d9( super_owner, buff_data )
{
    buff_data = get_player_buff_data( super_owner );
    return buff_data && self.var_598587b9c1ad0e71 === buff_data;
}

