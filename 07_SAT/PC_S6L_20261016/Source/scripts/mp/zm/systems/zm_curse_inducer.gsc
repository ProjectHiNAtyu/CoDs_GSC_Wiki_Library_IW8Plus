// scripts\mp\zm\systems\zm_curse_inducer.gsc  (hash_1d209fd8b2fbca88.gscc) (size: 9754 Bytes / 0x261a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5684f65 (90722149)
// size ...... 9754 (0x261a)
// includes .. 8   (offset: 0x2382)
// strings ... 24  (offset: 0x23c2)
// dev strs .. 11  (offset: 0x2596)
// exports ... 23  (offset: 0x1966)
// cseg ...... 0x1db + 0x178b (0x1966)
// imports ... 51  (offset: 0x1cfe)
// animtree1 . 0   (offset: 0x261a)
// animtree2 . 0   (offset: 0x261a)
#using script_162f01e3286930e2;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\mp\hud_message;
#using scripts\mp\interaction;
#using scripts\mp\zm\systems\relics\zm_relics;
#using scripts\mp\zm\systems\zm_quest;

#namespace zm_curse_inducer;

// Namespace zm_curse_inducer
// Params 2
// Checksum 0xd724e21c, Offset: 0x1f9
// Size: 0x155
function init_curse_inducer( var_239b77d2f197bc72 = %"hash_565a4420d8b46dac", spawn_point )
{
    setdvarifuninitialized( @"enable_curse_inducer", 0 );
    
    if ( !getdvarint( @"enable_curse_inducer", 0 ) )
    {
        return;
    }
    
    if ( isdefined( level.s_curse_inducer ) )
    {
        return;
    }
    
    assert( isdefined( var_239b77d2f197bc72 ), "<dev string:x24>" );
    level.s_curse_inducer = spawnstruct();
    level.s_curse_inducer.var_1059aa266990cfb2 = var_239b77d2f197bc72;
    level.s_curse_inducer.var_74761884f5182908 = [];
    level.s_curse_inducer.var_89db6aafc5939fb6 = [];
    level.s_curse_inducer.var_269f9f78402e32fd = getdvarint( @"hash_73ad3b29b6b93a02", 1 );
    level.s_curse_inducer.n_max_active_curses = getdvarint( @"curse_inducer_max_active", 0 );
    level.s_curse_inducer.n_round_counter = 0;
    level.s_curse_inducer.b_exhausted = 0;
    level.var_1fc058405b53460d = 0;
    function_58e30714b0f0f7e5( var_239b77d2f197bc72 );
    zm_quest::function_3c363613c60958f5( "curse_inducer_voting" );
    level thread spawn_curse_inducer( spawn_point );
    
    /#
        level thread init_curse_inducer_debug();
    #/
}

// Namespace zm_curse_inducer
// Params 1, eflags: 0x4
// Checksum 0xbf9cc26f, Offset: 0x356
// Size: 0x13d
function private function_58e30714b0f0f7e5( var_239b77d2f197bc72 )
{
    reliclist_bundle = getscriptbundle( var_239b77d2f197bc72 );
    assert( isdefined( reliclist_bundle ), "<dev string:x5e>" + var_239b77d2f197bc72 );
    
    foreach ( relic_entry in reliclist_bundle.relics )
    {
        if ( !isdefined( relic_entry.relicdata ) )
        {
            continue;
        }
        
        relic_bundle = getscriptbundle( relic_entry.relicdata );
        
        if ( isdefined( relic_bundle ) )
        {
            level.s_curse_inducer.var_74761884f5182908[ level.s_curse_inducer.var_74761884f5182908.size ] = relic_bundle;
        }
    }
    
    if ( !level.s_curse_inducer.n_max_active_curses )
    {
        level.s_curse_inducer.n_max_active_curses = level.s_curse_inducer.var_74761884f5182908.size;
    }
}

// Namespace zm_curse_inducer
// Params 1, eflags: 0x4
// Checksum 0x3547faa8, Offset: 0x49b
// Size: 0x1ba
function private spawn_curse_inducer( spawnpoint )
{
    level endon( #"game_ended" );
    utility::flag_wait( "scriptables_ready" );
    var_ed100f9a07836d02 = spawnstruct();
    
    if ( utility::issharedfuncdefined( #"curse_inducer", #"override_curse_inducer" ) )
    {
        var_ed100f9a07836d02 = utility::callsharedfunc( #"curse_inducer", #"override_curse_inducer" );
    }
    else
    {
        var_ed100f9a07836d02 = utility::getstruct( "round_accelerant", "targetname" );
    }
    
    assert( isdefined( var_ed100f9a07836d02 ), "<dev string:x94>" );
    level.s_curse_inducer.origin = var_ed100f9a07836d02.origin;
    level.s_curse_inducer.angles = var_ed100f9a07836d02.angles;
    level.s_curse_inducer.mdl = spawnscriptable( %"hash_749ad51d8205d901", var_ed100f9a07836d02.origin, var_ed100f9a07836d02.angles );
    interact = interaction::register_interact( var_ed100f9a07836d02.origin + ( 0, 0, 30 ), 64, &on_interact_curse_inducer, &function_631dbd66ab220555 );
    
    if ( isdefined( interact ) )
    {
        interact.b_cool_down = 1;
        interact.b_can_use = 1;
        interact setusefov( 360 );
        interact sethintonobstruction( "show" );
    }
    
    level.s_curse_inducer.interact = interact;
    level.s_curse_inducer.vote_hud = vote_system_shared::register_vote_hud();
    interact.var_7d3c1031c8e3dfd7 = 0;
    interact.var_69a1196ff0622b60 = 0;
}

// Namespace zm_curse_inducer
// Params 0, eflags: 0x4
// Checksum 0x74c205d7, Offset: 0x65d
// Size: 0x3c
function private function_426b18af971fc322()
{
    if ( !self.var_7d3c1031c8e3dfd7 )
    {
        level.s_curse_inducer.mdl setscriptablepartstate( "base", "player_close" );
        self.var_7d3c1031c8e3dfd7 = 1;
    }
}

// Namespace zm_curse_inducer
// Params 0, eflags: 0x4
// Checksum 0xd986df6b, Offset: 0x6a1
// Size: 0x47
function private function_72604f9c08da86a()
{
    if ( self.var_7d3c1031c8e3dfd7 && self.b_can_use )
    {
        level.s_curse_inducer.mdl setscriptablepartstate( "base", "deactivate" );
        self.var_7d3c1031c8e3dfd7 = 0;
    }
}

// Namespace zm_curse_inducer
// Params 0, eflags: 0xc
// Checksum 0xfde7643d, Offset: 0x6f0
// Size: 0x68
function private function_c63d3ba6b25a3d8e()
{
    self notify( #"hash_dc56871cf01db60f" );
    self endon( #"hash_dc56871cf01db60f" );
    level endon( #"game_ended" );
    self endon( #"hash_6e6e2400a0a0fc37" );
    
    while ( true )
    {
        self.var_69a1196ff0622b60 = 0;
        waitframe();
        
        if ( self.var_69a1196ff0622b60 <= 0 )
        {
            function_72604f9c08da86a();
            
            if ( !self.var_7d3c1031c8e3dfd7 )
            {
                return;
            }
        }
    }
}

// Namespace zm_curse_inducer
// Params 1, eflags: 0x4
// Checksum 0xe10ffe9c, Offset: 0x760
// Size: 0x1f3
function private function_ab0e0491b5b85f3b( relic_bundle )
{
    firefly_xi_relic = level.zm_relics[ %"relic:sat_zm_firefly_xi_relic" ];
    
    if ( !isdefined( firefly_xi_relic ) || relic_bundle.lootid != firefly_xi_relic.lootid )
    {
        return;
    }
    
    waitframe();
    
    foreach ( player in level.players )
    {
        player.var_9413068bac411438 = [];
        a_active_perks = [];
        
        foreach ( perk in player.perks_active )
        {
            a_active_perks[ a_active_perks.size ] = perk;
        }
        
        foreach ( perk in a_active_perks )
        {
            var_4eade8b4558610e = isdefined( player.perkspurchased ) && player.perkspurchased[ perk ];
            player utility::callsharedfunc( #"zm_mode_modifiers", #"hash_6843c64da905f4f8", perk, var_4eade8b4558610e, 0, 0 );
        }
    }
}

// Namespace zm_curse_inducer
// Params 0, eflags: 0x4
// Checksum 0x2a7ecd8a, Offset: 0x95b
// Size: 0x3cb
function private function_c3ebc6977ba19053()
{
    var_8cac6998746b53e0 = [];
    
    foreach ( relic_bundle in level.s_curse_inducer.var_74761884f5182908 )
    {
        if ( !zm_relics::function_9ee232e9e55c3939( relic_bundle.modifiertype ) )
        {
            var_8cac6998746b53e0[ var_8cac6998746b53e0.size ] = relic_bundle;
        }
    }
    
    if ( utility::issharedfuncdefined( #"curse_inducer", #"hash_7bd5942a5e07aa20" ) )
    {
        var_8cac6998746b53e0 = utility::callsharedfunc( #"curse_inducer", #"hash_7bd5942a5e07aa20", var_8cac6998746b53e0 );
    }
    
    if ( !var_8cac6998746b53e0.size )
    {
        /#
            iprintlnbold( "<dev string:xec>" );
        #/
        
        return;
    }
    
    n_max = level.s_curse_inducer.n_max_active_curses;
    
    if ( level.s_curse_inducer.var_89db6aafc5939fb6.size >= n_max )
    {
        /#
            iprintlnbold( "<dev string:x121>" + n_max );
        #/
        
        return;
    }
    
    var_78b9628d20f38f44 = randomint( var_8cac6998746b53e0.size );
    relic_bundle = var_8cac6998746b53e0[ var_78b9628d20f38f44 ];
    function_ab0e0491b5b85f3b( relic_bundle );
    zm_relics::function_f6ef95770f20fc2c( relic_bundle );
    level.s_curse_inducer.var_89db6aafc5939fb6[ level.s_curse_inducer.var_89db6aafc5939fb6.size ] = relic_bundle;
    
    if ( relic_bundle.lootid )
    {
        foreach ( player in level.players )
        {
            player setclientomnvar( "ui_zm_echo_portal_splash_reward_lootid", relic_bundle.lootid );
            player thread hud_message::showsplash( #"hash_f63238ad7dbd2c15" );
        }
    }
    
    logstring( "[CurseInducer] Curse activated: " + relic_bundle.modifiertype );
    wait 2;
    
    if ( level.s_curse_inducer.mdl )
    {
        level.s_curse_inducer.mdl setscriptablepartstate( "vfx", "leave" );
        level.s_curse_inducer.mdl setscriptablepartstate( "material", "off" );
        level.s_curse_inducer.mdl setscriptablepartstate( "icon", "off" );
        level.s_curse_inducer.mdl setscriptablepartstate( "audio", "leave" );
        level.s_curse_inducer.mdl setscriptablepartstate( "ambient", "off" );
        wait 2;
        level.s_curse_inducer.mdl setscriptablepartstate( "base", "deactivate" );
    }
    
    foreach ( e_player in level.players )
    {
        e_player callback::callback( #"hash_e5725a37fb41232c" );
    }
    
    level notify( #"hash_e9e3249a0ac480ad" );
    
    if ( !function_feb8d344bf54724f() )
    {
        function_9094f25538aa1d86();
    }
}

// Namespace zm_curse_inducer
// Params 0, eflags: 0x4
// Checksum 0x1240a5eb, Offset: 0xd2e
// Size: 0x168
function private function_9094f25538aa1d86()
{
    level.s_curse_inducer.b_exhausted = 1;
    level.var_1fc058405b53460d = 1;
    
    if ( isdefined( level.s_curse_inducer.interact ) )
    {
        level.s_curse_inducer.interact notify( #"hash_6e6e2400a0a0fc37" );
        level.s_curse_inducer.interact delete();
        level.s_curse_inducer.interact = undefined;
    }
    
    if ( !isdefined( level.s_curse_inducer.mdl ) )
    {
        return;
    }
    
    level.s_curse_inducer.mdl setscriptablepartstate( "base", "deactivate" );
    level.s_curse_inducer.mdl setscriptablepartstate( "vfx", "off" );
    level.s_curse_inducer.mdl setscriptablepartstate( "material", "off" );
    level.s_curse_inducer.mdl setscriptablepartstate( "icon", "off" );
    level.s_curse_inducer.mdl setscriptablepartstate( "audio", "off" );
    level.s_curse_inducer.mdl setscriptablepartstate( "ambient", "off" );
}

// Namespace zm_curse_inducer
// Params 0, eflags: 0x4
// Checksum 0xc9214fb, Offset: 0xe9e
// Size: 0x95, Type: bool
function private function_feb8d344bf54724f()
{
    foreach ( relic_bundle in level.s_curse_inducer.var_74761884f5182908 )
    {
        if ( !zm_relics::function_9ee232e9e55c3939( relic_bundle.modifiertype ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_curse_inducer
// Params 2, eflags: 0x4
// Checksum 0x97968d2d, Offset: 0xf3c
// Size: 0x18a
function private function_631dbd66ab220555( usable, player )
{
    if ( usable.b_can_use && isdefined( level.s_curse_inducer.mdl ) )
    {
        usable.var_69a1196ff0622b60++;
        usable function_426b18af971fc322();
        usable thread function_c63d3ba6b25a3d8e();
    }
    
    if ( utility::flag( "zm_vote_active" ) || utility::flag( "exfil_active" ) )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( isdefined( player ) && isdefined( usable ) && player.interactions_disabled )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( usable.b_voting || !usable.b_cool_down || !usable.b_can_use )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    return { #icon:"ui_icon_zm_ping_rampage_indicator", #buttoncallout:&"SHARED_HINTSTRINGS/ACTIVATE_RAMPAGE", #description:&"hash_53e26d322b7d71ba", #title:&"hash_60d2458a687a57a6", #string:&"SHARED_HINTSTRINGS/ACTIVATE_RAMPAGE", #type:"HINT_BUTTON" };
}

// Namespace zm_curse_inducer
// Params 1, eflags: 0x4
// Checksum 0xae61ea5b, Offset: 0x10cf
// Size: 0x203
function private on_interact_curse_inducer( player )
{
    level endon( #"game_ended" );
    
    if ( utility::flag( "zm_vote_active" ) || utility::flag( "exfil_active" ) )
    {
        return;
    }
    
    if ( player.interactions_disabled )
    {
        return;
    }
    
    if ( !self.b_cool_down || !self.b_can_use )
    {
        return;
    }
    
    self.b_voting = 1;
    self.b_cool_down = 0;
    
    if ( isdefined( level.s_curse_inducer.mdl ) )
    {
        level.s_curse_inducer.mdl setscriptablepartstate( "base", "activate" );
        level.s_curse_inducer.mdl setscriptablepartstate( "vfx", "on" );
        level.s_curse_inducer.mdl setscriptablepartstate( "audio", "activate" );
    }
    
    var_3faf858e79cd17bb = spawnstruct();
    var_3faf858e79cd17bb.init_message = &"hash_62d2e61c179c726a";
    var_3faf858e79cd17bb.description = &"hash_74332f5f46b94c4c";
    b_passed = zm_quest::vote_think( player, var_3faf858e79cd17bb, undefined, 3 );
    self.b_voting = undefined;
    
    if ( !b_passed )
    {
        if ( isdefined( level.s_curse_inducer.mdl ) )
        {
            level.s_curse_inducer.mdl setscriptablepartstate( "base", "deactivate" );
            level.s_curse_inducer.mdl setscriptablepartstate( "vfx", "off" );
            level.s_curse_inducer.mdl setscriptablepartstate( "audio", "off" );
        }
        
        if ( isdefined( self ) )
        {
            self.b_cool_down = 1;
        }
        
        return;
    }
    
    if ( isdefined( self ) )
    {
        self.b_can_use = 0;
        self.b_cool_down = 1;
    }
    
    level thread function_c3ebc6977ba19053();
}

// Namespace zm_curse_inducer
// Params 0
// Checksum 0xe6742b9b, Offset: 0x12da
// Size: 0x19, Type: bool
function get_active_curses()
{
    return level.s_curse_inducer.var_89db6aafc5939fb6 ?? [];
}

// Namespace zm_curse_inducer
// Params 1
// Checksum 0xcce42263, Offset: 0x12fc
// Size: 0x14
function is_curse_active( modifier_hash )
{
    return zm_relics::function_9ee232e9e55c3939( modifier_hash );
}

// Namespace zm_curse_inducer
// Params 1
// Checksum 0x9d7de1c0, Offset: 0x1319
// Size: 0xda
function disable_curse( modifier_hash )
{
    if ( !isdefined( level.s_curse_inducer ) )
    {
        return;
    }
    
    a_remaining = [];
    
    foreach ( relic_bundle in level.s_curse_inducer.var_89db6aafc5939fb6 )
    {
        if ( relic_bundle.modifiertype == modifier_hash )
        {
            zm_relics::function_90442c590e60cb05( relic_bundle );
            continue;
        }
        
        a_remaining[ a_remaining.size ] = relic_bundle;
    }
    
    level.s_curse_inducer.var_89db6aafc5939fb6 = a_remaining;
}

// Namespace zm_curse_inducer
// Params 0
// Checksum 0xcc367ce8, Offset: 0x13fb
// Size: 0xa9
function function_6c19140a47ed7028()
{
    if ( !isdefined( level.s_curse_inducer ) )
    {
        return;
    }
    
    foreach ( relic_bundle in level.s_curse_inducer.var_89db6aafc5939fb6 )
    {
        zm_relics::function_90442c590e60cb05( relic_bundle );
    }
    
    level.s_curse_inducer.var_89db6aafc5939fb6 = [];
}

// Namespace zm_curse_inducer
// Params 1
// Checksum 0xebf2badd, Offset: 0x14ac
// Size: 0x5d
function set_curse_max_active( n )
{
    if ( !isdefined( level.s_curse_inducer ) )
    {
        return;
    }
    
    n_resolved = n > 0 ? n : level.s_curse_inducer.var_74761884f5182908.size;
    level.s_curse_inducer.n_max_active_curses = n_resolved;
}

// Namespace zm_curse_inducer
// Params 1
// Checksum 0x6c82f2c2, Offset: 0x1511
// Size: 0xd6
function function_b477dadfb1410aae( b_can_use )
{
    if ( !( isdefined( level.s_curse_inducer ) && isdefined( level.s_curse_inducer.interact ) ) )
    {
        return;
    }
    
    level.s_curse_inducer.interact.b_can_use = b_can_use;
    
    if ( b_can_use )
    {
        level.s_curse_inducer.interact setcursorhint( "HINT_BUTTON" );
        level.s_curse_inducer.interact sethintstring( &"SHARED_HINTSTRINGS/ACTIVATE_RAMPAGE" );
        return;
    }
    
    level.s_curse_inducer.interact setcursorhint( "HINT_NOBUTTON" );
    level.s_curse_inducer.interact sethintstring( &"" );
}

// Namespace zm_curse_inducer
// Params 1
// Checksum 0x1c04c708, Offset: 0x15ef
// Size: 0x1f6
function move_curse_inducer( var_16af6624858ffa21 )
{
    if ( !isdefined( level.s_curse_inducer ) )
    {
        return;
    }
    
    assert( isdefined( var_16af6624858ffa21 ), "<dev string:x14b>" );
    
    if ( isdefined( level.s_curse_inducer.mdl ) )
    {
        level.s_curse_inducer.mdl.origin = var_16af6624858ffa21.origin;
        level.s_curse_inducer.mdl.angles = var_16af6624858ffa21.angles;
    }
    
    if ( isdefined( level.s_curse_inducer.interact ) )
    {
        level.s_curse_inducer.interact notify( #"hash_6e6e2400a0a0fc37" );
        level.s_curse_inducer.interact delete();
    }
    
    if ( level.s_curse_inducer.b_exhausted )
    {
        level.s_curse_inducer.interact = undefined;
        function_9094f25538aa1d86();
        return;
    }
    
    interact = interaction::register_interact( var_16af6624858ffa21.origin + ( 0, 0, 30 ), 64, &on_interact_curse_inducer, &function_631dbd66ab220555 );
    
    if ( isdefined( interact ) )
    {
        interact.b_cool_down = 1;
        interact.b_can_use = 1;
        interact.var_7d3c1031c8e3dfd7 = 0;
        interact.var_69a1196ff0622b60 = 0;
        interact setusefov( 360 );
        interact sethintonobstruction( "show" );
    }
    
    level.s_curse_inducer.interact = interact;
    level.s_curse_inducer.origin = var_16af6624858ffa21.origin;
    level.s_curse_inducer.angles = var_16af6624858ffa21.angles;
    function_1572a91b3abc6866();
}

// Namespace zm_curse_inducer
// Params 0, eflags: 0x4
// Checksum 0x56f7f2cc, Offset: 0x17ed
// Size: 0xc5
function private function_1572a91b3abc6866()
{
    if ( !isdefined( level.s_curse_inducer.mdl ) )
    {
        return;
    }
    
    level.s_curse_inducer.mdl setscriptablepartstate( "base", "deactivate" );
    level.s_curse_inducer.mdl setscriptablepartstate( "vfx", "off" );
    level.s_curse_inducer.mdl setscriptablepartstate( "material", "on" );
    level.s_curse_inducer.mdl setscriptablepartstate( "icon", "on" );
    level.s_curse_inducer.mdl setscriptablepartstate( "ambient", "on" );
}

/#

    // Namespace zm_curse_inducer
    // Params 0, eflags: 0x4
    // Checksum 0xc793294d, Offset: 0x18ba
    // Size: 0x2e, Type: dev
    function private init_curse_inducer_debug()
    {
        devgui::function_9082edeb5db93280( "<dev string:x175>" );
        devgui::add_devgui_func( "<dev string:x187>", "<dev string:x19d>", &function_281fed9e6c29b3 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_curse_inducer
    // Params 0, eflags: 0x4
    // Checksum 0xd6a1b512, Offset: 0x18f0
    // Size: 0x76, Type: dev
    function private function_281fed9e6c29b3()
    {
        if ( !isdefined( level.s_curse_inducer ) )
        {
            iprintlnbold( "<dev string:x1b4>" );
            return;
        }
        
        var_ed100f9a07836d02 = { #angles:level.s_curse_inducer.angles, #origin:level.s_curse_inducer.origin };
        move_curse_inducer( var_ed100f9a07836d02 );
        iprintlnbold( "<dev string:x1d4>" );
    }

#/
