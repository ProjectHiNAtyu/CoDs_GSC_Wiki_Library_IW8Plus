// scripts\mp\br\winstreak\winstreak.gsc  (hash_256d44cb27b6a5f2.gscc) (size: 10042 Bytes / 0x273a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc6f29478 (3337786488)
// size ...... 10042 (0x273a)
// includes .. 7   (offset: 0x258e)
// strings ... 6   (offset: 0x25c6)
// dev strs .. 23  (offset: 0x2612)
// exports ... 30  (offset: 0x175a)
// cseg ...... 0xbd + 0x169d (0x175a)
// imports ... 81  (offset: 0x1c0a)
// animtree1 . 0   (offset: 0x273a)
// animtree2 . 0   (offset: 0x273a)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\playerachievements;

#namespace winstreak;

// Namespace winstreak
// Params 0, eflags: 0x5
// Checksum 0x7cb3cccf, Offset: 0xdb
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"win_streak", undefined, &pre_init, &post_init );
}

// Namespace winstreak
// Params 0, eflags: 0x4
// Checksum 0x694480be, Offset: 0x100
// Size: 0x2
function private pre_init()
{
    
}

// Namespace winstreak
// Params 0, eflags: 0x4
// Checksum 0x78de8ced, Offset: 0x10a
// Size: 0x9a
function private post_init()
{
    if ( !( getdvarint( @"enable_win_streak", 1 ) > 0 ) )
    {
        return;
    }
    
    level.winstreak = spawnstruct();
    function_b8c813f884d1effb();
    
    if ( function_323522a0ab2ee503() )
    {
        level callback::add( #"player_connect", &on_player_connect );
        level callback::add( #"player_disconnect", &on_player_disconnect );
        level callback::add( #"hash_eb54ccc016130a88", &on_player_elim );
        
        /#
            level callback::add( #"hash_9d92d48a58900ff6", &function_7ca542a6cbb39622 );
        #/
    }
    
    /#
        setup_devgui();
    #/
}

// Namespace winstreak
// Params 3
// Checksum 0x9fdb41f1, Offset: 0x1ac
// Size: 0x42
function function_bfe07eb8c6d2db88( target, winstreak_level, var_ee570bf926268689 )
{
    if ( !( getdvarint( @"enable_win_streak", 1 ) > 0 ) )
    {
        return;
    }
    
    thread function_67240080854c6dd2( target, 1, winstreak_level, var_ee570bf926268689 );
}

// Namespace winstreak
// Params 1
// Checksum 0xbd8cc7, Offset: 0x1f6
// Size: 0x2c
function function_8434cc9b1f5a4b95( target )
{
    if ( !( getdvarint( @"enable_win_streak", 1 ) > 0 ) )
    {
        return;
    }
    
    thread function_67240080854c6dd2( target, 0 );
}

// Namespace winstreak
// Params 0, eflags: 0x4
// Checksum 0x2900cb7f, Offset: 0x22a
// Size: 0x7b, Type: bool
function private function_323522a0ab2ee503()
{
    if ( !( getdvarint( @"enable_win_streak", 1 ) > 0 ) )
    {
        return false;
    }
    
    if ( !level.winstreak.config )
    {
        return false;
    }
    
    if ( !level.winstreak.config.var_e17395ee4e155814 || level.winstreak.config.var_e17395ee4e155814 == -1 )
    {
        return false;
    }
    
    return true;
}

// Namespace winstreak
// Params 0, eflags: 0x4
// Checksum 0xaef0be4a, Offset: 0x2ae
// Size: 0xc5
function private function_2e13ca1ab335630e()
{
    var_31e94ecc9fbce548 = getscriptbundlenames( #"winstreakbundle" );
    currentseason = getdvarint( @"current_season", -1 );
    
    foreach ( bundlename in var_31e94ecc9fbce548 )
    {
        winstreakbundle = getscriptbundle( bundlename );
        
        if ( winstreakbundle && winstreakbundle.season == currentseason )
        {
            return winstreakbundle;
        }
    }
}

// Namespace winstreak
// Params 0, eflags: 0x4
// Checksum 0x2bbc701d, Offset: 0x37c
// Size: 0xe3
function private function_b8c813f884d1effb()
{
    if ( level.gametypebundle.isltm )
    {
        return;
    }
    
    gametype = game_utility::getgametype();
    scriptbundle = function_2e13ca1ab335630e();
    
    if ( !scriptbundle )
    {
        println( "<dev string:x24>" + getdvarint( @"current_season", -1 ) );
        return;
    }
    
    if ( gametype == "br" )
    {
        level.winstreak.config = scriptbundle.battleroyaleconfig;
        return;
    }
    
    if ( gametype == "resurgence" )
    {
        level.winstreak.config = scriptbundle.resurgenceconfig;
        return;
    }
    
    if ( gametype == "bongo" )
    {
        level.winstreak.config = scriptbundle.bongoconfig;
    }
}

// Namespace winstreak
// Params 1, eflags: 0x4
// Checksum 0x5076110b, Offset: 0x467
// Size: 0x9d
function private on_player_connect( params )
{
    player = self;
    
    if ( !isdefined( player.winstreak ) )
    {
        player.winstreak = spawnstruct();
        
        if ( isbot( player ) )
        {
            player.winstreak.achievementprogress = getdvarint( @"hash_3b0cf7d093bea552", 0 );
            return;
        }
        
        player function_f7449428c4129fcc();
        
        if ( getdvarint( @"hash_4fe028361da9d3c8", 0 ) > 0 )
        {
            player init_channels();
            return;
        }
        
        /#
            player init_channels();
        #/
    }
}

// Namespace winstreak
// Params 1, eflags: 0x4
// Checksum 0x6629694e, Offset: 0x50c
// Size: 0x8c
function private on_player_elim( params )
{
    winstreak = 0;
    
    if ( params.victim.winstreak )
    {
        winstreak = params.victim.winstreak.achievementprogress ?? 0;
    }
    
    /#
        winstreak = getdvarint( @"hash_a4ca39877939bbbf", winstreak );
    #/
    
    if ( winstreak > 0 )
    {
        thread points::doscoreevent( #"elimination_winstreak", params.objweapon );
    }
}

// Namespace winstreak
// Params 0, eflags: 0x4
// Checksum 0xae24731d, Offset: 0x5a0
// Size: 0x4d
function private function_f7449428c4129fcc()
{
    achievementid = level.winstreak.config.var_e17395ee4e155814;
    assert( achievementid, "<dev string:x55>" );
    thread function_bd3406c6d9e0e861( achievementid );
    playerachievements::getstate( self, achievementid );
}

// Namespace winstreak
// Params 1, eflags: 0xc
// Checksum 0x929d7a07, Offset: 0x5f5
// Size: 0x28c
function private function_bd3406c6d9e0e861( achievementid )
{
    self notify( #"hash_b3e0efc4ac03d42f" );
    self endon( #"hash_b3e0efc4ac03d42f" );
    self endon( #"disconnect" );
    self waittillmatch( #"challengeprogress", achievementid );
    winstreakprogress = playerachievements::function_ce48098d17912e1f( self, achievementid, "progress", 0 );
    println( "<dev string:x7f>" + self.name + "<dev string:xa2>" + achievementid + "<dev string:xac>" + winstreakprogress );
    self.winstreak.achievementprogress = winstreakprogress;
    partymembers = [ self ];
    
    if ( level.matchmakingmatch )
    {
        fireteammembers = self getfireteammembers();
        
        foreach ( fireteammember in fireteammembers )
        {
            partymembers[ partymembers.size ] = fireteammember;
        }
    }
    
    partymembers = arrayremoveduplicates( partymembers );
    partymembers = function_5713d46873b29625( partymembers );
    var_12f45f8e2c93d7e7 = 0;
    
    foreach ( member in partymembers )
    {
        if ( member.winstreak.achievementprogress && member.winstreak.achievementprogress > 0 )
        {
            var_12f45f8e2c93d7e7 = 1;
            break;
        }
    }
    
    foreach ( player in partymembers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( var_12f45f8e2c93d7e7 )
        {
            player setclientomnvar( o"hash_2ef2a308a5da221e", 1 );
            continue;
        }
        
        player setclientomnvar( o"hash_2ef2a308a5da221e", 0 );
    }
}

// Namespace winstreak
// Params 1, eflags: 0x4
// Checksum 0x836aa838, Offset: 0x889
// Size: 0x22c
function private on_player_disconnect( params )
{
    if ( !isdefined( self.winstreak.achievementprogress ) || self.winstreak.achievementprogress <= 0 )
    {
        return;
    }
    
    partymembers = [];
    
    if ( level.matchmakingmatch )
    {
        fireteammembers = self getfireteammembers();
        
        foreach ( fireteammember in fireteammembers )
        {
            partymembers[ partymembers.size ] = fireteammember;
        }
    }
    
    partymembers = arrayremoveduplicates( partymembers );
    partymembers = function_5713d46873b29625( partymembers );
    var_12f45f8e2c93d7e7 = 0;
    
    foreach ( member in partymembers )
    {
        if ( member.winstreak.achievementprogress && member.winstreak.achievementprogress > 0 )
        {
            var_12f45f8e2c93d7e7 = 1;
            break;
        }
    }
    
    foreach ( player in partymembers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( var_12f45f8e2c93d7e7 )
        {
            player setclientomnvar( o"hash_2ef2a308a5da221e", 1 );
            continue;
        }
        
        player setclientomnvar( o"hash_2ef2a308a5da221e", 0 );
    }
}

// Namespace winstreak
// Params 4, eflags: 0x4
// Checksum 0x29491a3f, Offset: 0xabd
// Size: 0x92
function private function_67240080854c6dd2( target, should_show, winstreak_level, var_ee570bf926268689 )
{
    player = self;
    player endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( !target )
    {
        assertmsg( "<dev string:xb8>" );
        return;
    }
    
    target_ent_num = target getentitynumber();
    omnvar = function_efba04acb2f9246e( target_ent_num );
    player thread set_player_omnvar( omnvar, target_ent_num, should_show, winstreak_level, var_ee570bf926268689 );
}

// Namespace winstreak
// Params 5, eflags: 0x4
// Checksum 0x2d3df130, Offset: 0xb57
// Size: 0x96
function private set_player_omnvar( omnvar, target_ent_num, should_show, winstreak_level, var_ee570bf926268689 )
{
    player = self;
    player endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    var_e5652a304f75ea6b = should_show ? winstreak_level : 0;
    omnvar_value = player make_omnvar_value( omnvar, target_ent_num, var_e5652a304f75ea6b, var_ee570bf926268689 );
    player setclientomnvar( omnvar, omnvar_value );
    waitframe();
    player free_channel( omnvar );
}

// Namespace winstreak
// Params 4, eflags: 0x4
// Checksum 0xaae9f52e, Offset: 0xbf5
// Size: 0xc1
function private make_omnvar_value( omnvar, target_ent_num, winstreak_level, var_ee570bf926268689 )
{
    player = self;
    value = 0;
    var_19f364528d876b4a = 0;
    
    if ( var_ee570bf926268689 )
    {
        var_19f364528d876b4a = 1;
    }
    
    assert( ( target_ent_num & 2047 ) === target_ent_num, "<dev string:xe5>" );
    value += target_ent_num << 0;
    winstreak_level = clampint( winstreak_level, 0, 31 );
    value += winstreak_level << 11;
    assert( ( var_19f364528d876b4a & 1 ) === var_19f364528d876b4a, "<dev string:xe5>" );
    value += var_19f364528d876b4a << 16;
    pulse_bit = player function_80988973d7591e2e( omnvar );
    value += pulse_bit << 17;
    return value;
}

// Namespace winstreak
// Params 0, eflags: 0x4
// Checksum 0xb9d632b8, Offset: 0xcbf
// Size: 0xa3
function private init_channels()
{
    assert( self.winstreak, "<dev string:xf9>" );
    self.winstreak.omnvar_channels = [];
    self.winstreak.var_6f220bb43209a1cc = [];
    
    for ( i = 0; i < 5 ; i++ )
    {
        omnvar = "ui_win_streak_channel_" + i + 1;
        self.winstreak.omnvar_channels[ omnvar ] = 1;
        self.winstreak.var_6f220bb43209a1cc[ omnvar ] = 0;
    }
}

// Namespace winstreak
// Params 1, eflags: 0x4
// Checksum 0x8d22a3d, Offset: 0xd6a
// Size: 0x6f
function private function_efba04acb2f9246e( target_ent_num )
{
    level endon( #"game_ended" );
    player = self;
    player endon( #"death_or_disconnect" );
    player notify( "stop_win_streak_channel_alloc_" + target_ent_num );
    player endon( "stop_win_streak_channel_alloc_" + target_ent_num );
    
    while ( true )
    {
        omnvar = player alloc_channel();
        
        if ( omnvar )
        {
            break;
        }
        
        waitframe();
    }
    
    return omnvar;
}

// Namespace winstreak
// Params 0, eflags: 0x4
// Checksum 0x5f64db15, Offset: 0xde2
// Size: 0xc3
function private alloc_channel()
{
    player = self;
    assert( player.winstreak, "<dev string:xf9>" );
    
    foreach ( omnvar, is_free in player.winstreak.omnvar_channels )
    {
        if ( is_free )
        {
            player.winstreak.omnvar_channels[ omnvar ] = 0;
            return omnvar;
        }
    }
}

// Namespace winstreak
// Params 1, eflags: 0x4
// Checksum 0x2c953322, Offset: 0xead
// Size: 0x4c
function private free_channel( omnvar )
{
    player = self;
    assert( player.winstreak, "<dev string:xf9>" );
    player.winstreak.omnvar_channels[ omnvar ] = 1;
}

// Namespace winstreak
// Params 1, eflags: 0x4
// Checksum 0xccd19550, Offset: 0xf01
// Size: 0xb1
function private function_80988973d7591e2e( omnvar )
{
    player = self;
    assert( player.winstreak, "<dev string:xf9>" );
    player.winstreak.var_6f220bb43209a1cc[ omnvar ] += 1;
    player.winstreak.var_6f220bb43209a1cc[ omnvar ] &= 1;
    return player.winstreak.var_6f220bb43209a1cc[ omnvar ];
}

/#

    // Namespace winstreak
    // Params 0, eflags: 0x4
    // Checksum 0xd9ba8d80, Offset: 0xfbb
    // Size: 0xb8, Type: dev
    function private setup_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x118>" );
        devgui::add_devgui_func( "<dev string:x126>", "<dev string:x137>", &function_38ae966bb195ab4d );
        devgui::add_devgui_func( "<dev string:x155>", "<dev string:x165>", &dev_stop_debug_draw );
        devgui::add_devgui_func( "<dev string:x182>", "<dev string:x191>", &function_5ee057c3a2a51da9 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x1ad>" );
        max_levels = 16;
        
        for ( i = 0; i < max_levels ; i++ )
        {
            lv = i + 1;
            devgui::function_cd4e263c1f3018ae( lv, "<dev string:x1ca>" + lv, &function_9e5dca3a3cc83d98 );
        }
        
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace winstreak
    // Params 1, eflags: 0x4
    // Checksum 0x40e6cbc3, Offset: 0x107b
    // Size: 0x9f, Type: dev
    function private function_9e5dca3a3cc83d98( params )
    {
        me = level.players[ 0 ];
        winstreak_level = int( params[ 0 ] );
        
        if ( me.var_8aaf5644da13e6d )
        {
            me function_bfe07eb8c6d2db88( me.var_8aaf5644da13e6d, winstreak_level );
            
            if ( !isdefined( me.var_b137c996b99b9bfa ) )
            {
                me.var_b137c996b99b9bfa = [];
            }
            
            target_ent_num = me.var_8aaf5644da13e6d getentitynumber();
            me.var_b137c996b99b9bfa[ target_ent_num ] = winstreak_level;
        }
    }

    // Namespace winstreak
    // Params 1, eflags: 0x4
    // Checksum 0x9a366c94, Offset: 0x1122
    // Size: 0x8c, Type: dev
    function private function_5ee057c3a2a51da9( params )
    {
        me = level.players[ 0 ];
        
        if ( me.var_8aaf5644da13e6d )
        {
            me function_8434cc9b1f5a4b95( me.var_8aaf5644da13e6d );
            
            if ( !isdefined( me.var_b137c996b99b9bfa ) )
            {
                me.var_b137c996b99b9bfa = [];
            }
            
            target_ent_num = me.var_8aaf5644da13e6d getentitynumber();
            me.var_b137c996b99b9bfa[ target_ent_num ] = 0;
        }
    }

    // Namespace winstreak
    // Params 0, eflags: 0xc
    // Checksum 0xcec57fc5, Offset: 0x11b6
    // Size: 0x12b, Type: dev
    function private function_38ae966bb195ab4d()
    {
        self notify( #"hash_5cd1762450af669e" );
        self endon( #"hash_5cd1762450af669e" );
        player = level.players[ 0 ];
        player endon( #"death_or_disconnect" );
        level endon( #"game_ended", #"hash_bf16346515752e05" );
        
        while ( true )
        {
            if ( player.sessionstate != "<dev string:x1e8>" )
            {
                waitframe();
                continue;
            }
            
            hit_entity = player function_fed502b7f8891e6();
            
            if ( !hit_entity )
            {
                waitframe();
                continue;
            }
            
            player.var_8aaf5644da13e6d = hit_entity;
            debug_color = ( 1, 1, 0 );
            debug_string = "<dev string:x1f0>";
            
            if ( player.var_b137c996b99b9bfa )
            {
                target_ent_num = hit_entity getentitynumber();
                
                if ( player.var_b137c996b99b9bfa[ target_ent_num ] )
                {
                    debug_color = ( 0, 1, 0 );
                    debug_string = target_ent_num + "<dev string:x1f1>" + player.var_b137c996b99b9bfa[ target_ent_num ];
                }
            }
            
            player function_4641de835d2d7cb( hit_entity, debug_string, debug_color );
            waitframe();
        }
    }

    // Namespace winstreak
    // Params 1, eflags: 0x4
    // Checksum 0x4d7c0a7c, Offset: 0x12e9
    // Size: 0x161, Type: dev
    function private function_7ca542a6cbb39622( params )
    {
        if ( !( getdvarint( @"enable_win_streak", 1 ) > 0 ) )
        {
            return;
        }
        
        foreach ( player in level.players )
        {
            foreach ( winnerplayer in params.teamplayers )
            {
                winstreakcount = 0;
                
                if ( winnerplayer.winstreak )
                {
                    winstreakcount = winnerplayer.winstreak.achievementprogress ?? 0;
                }
                
                /#
                    winstreakcount = getdvarint( @"hash_a4ca39877939bbbf", winstreakcount );
                #/
                
                winstreakcount += 1;
                player function_bfe07eb8c6d2db88( winnerplayer, winstreakcount, 1 );
            }
        }
    }

    // Namespace winstreak
    // Params 0, eflags: 0x4
    // Checksum 0x6ca5f4f, Offset: 0x1452
    // Size: 0x223, Type: dev
    function private function_fed502b7f8891e6()
    {
        entities_mask = createentitytypemask( [ "<dev string:x1f3>" ] );
        view_forward_cos = cos( 30 );
        
        if ( isplayer( self ) && self getcamerathirdperson() )
        {
            view_origin = self getcamerathirdpersonorigin();
            view_forward_cos = cos( 80 );
        }
        else if ( issentient( self.vehicle ) )
        {
            veh = self.vehicle;
            view_origin = veh geteye() + ( 0, 0, self getplayerviewheight() / 2 );
        }
        else
        {
            view_origin = self getvieworigin();
        }
        
        trace_start = view_origin;
        player_angles = self getplayerangles();
        var_fe7a645b39ffd903 = anglestoforward( player_angles );
        trace_dist = 2500;
        var_d3f030749f6993cf = getentitiesinradiusfrompartitiongrid( trace_start, trace_dist, entities_mask, [ self ] );
        var_cfd336c4bde101c5 = 0;
        
        foreach ( ent in var_d3f030749f6993cf )
        {
            var_b450de0f1a8cf657 = vectordot( var_fe7a645b39ffd903, vectornormalize( ent.origin - trace_start ) );
            var_79856eee032728bd = var_b450de0f1a8cf657 >= view_forward_cos;
            
            if ( !var_79856eee032728bd )
            {
                continue;
            }
            
            var_cfd336c4bde101c5 = 1;
            break;
        }
        
        if ( !var_cfd336c4bde101c5 )
        {
            return;
        }
        
        trace_end = trace_start + var_fe7a645b39ffd903 * trace_dist;
        var_f79efbe4ba0fbc79 = self isvehicleactive();
        trace_contents = trace::create_contents( 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 );
        ignore_ents = [];
        ignore_ents[ ignore_ents.size ] = self;
        results = physics_raycast( trace_start, trace_end, trace_contents, ignore_ents, var_f79efbe4ba0fbc79, "<dev string:x200>", 0, 1 );
        return results.size ? results[ 0 ][ "<dev string:x215>" ] : undefined;
    }

    // Namespace winstreak
    // Params 0, eflags: 0x4
    // Checksum 0xb1feb9c, Offset: 0x167d
    // Size: 0x11, Type: dev
    function private dev_stop_debug_draw()
    {
        level notify( #"hash_bf16346515752e05" );
    }

    // Namespace winstreak
    // Params 4, eflags: 0x4
    // Checksum 0x827f09be, Offset: 0x1696
    // Size: 0xc4, Type: dev
    function private function_4641de835d2d7cb( target, print_text, color, sphere_radius )
    {
        if ( !isdefined( print_text ) )
        {
            print_text = "<dev string:x1f0>";
        }
        
        if ( !isdefined( color ) )
        {
            color = ( 1, 0, 0 );
        }
        
        if ( !isdefined( sphere_radius ) )
        {
            sphere_radius = 5;
        }
        
        level endon( #"hash_bf16346515752e05" );
        
        if ( !target || !target.origin || !self )
        {
            return;
        }
        
        end = target.origin + ( 0, 0, 30 );
        line( self.origin, end, color );
        sphere( end, sphere_radius, color );
        print3d( end, print_text, color );
    }

#/
