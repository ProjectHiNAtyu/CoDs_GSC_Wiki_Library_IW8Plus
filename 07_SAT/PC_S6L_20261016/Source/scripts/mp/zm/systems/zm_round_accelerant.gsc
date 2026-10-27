// scripts\mp\zm\systems\zm_round_accelerant.gsc  (hash_066cb9fe5d1bbff6.gscc) (size: 11536 Bytes / 0x2d10 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6b523cf9 (1800551673)
// size ...... 11536 (0x2d10)
// includes .. 11  (offset: 0x29c8)
// strings ... 40  (offset: 0x2a20)
// dev strs .. 7   (offset: 0x2cb8)
// exports ... 22  (offset: 0x1c28)
// cseg ...... 0x3a8 + 0x1880 (0x1c28)
// imports ... 83  (offset: 0x1f98)
// animtree1 . 0   (offset: 0x2d10)
// animtree2 . 0   (offset: 0x2d10)
#using script_162f01e3286930e2;
#using scripts\asm\asm_bb;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\interaction;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_round_spawning;

#namespace zm_round_accelerant;

// Namespace zm_round_accelerant
// Params 0
// Checksum 0x78b81dc2, Offset: 0x3c6
// Size: 0xa4
function init_round_accelerant()
{
    setdvarifuninitialized( @"hash_6bfc8f70c4585e00", 0 );
    setdvarifuninitialized( @"hash_54d97c81fc15dc50", 0 );
    
    if ( !getdvarint( @"hash_54d97c81fc15dc50", 0 ) )
    {
        return;
    }
    
    if ( isdefined( level.s_rampage ) )
    {
        return;
    }
    
    level._effect[ "rampage_inducer_despawn" ] = loadfxasset( "vfx_jup_ob_gameplay_zm_rampage_inducer_despawn" );
    level callback::add( "on_round_end", &function_449e7ed200f89e8c );
    level callback::add( "on_zombie_ai_spawned", &function_691eb243fc280e3e );
    level callback::add( "zm_exfil_started", &deactivate_rampage_inducer );
    zm_quest::function_3c363613c60958f5( "rampage_inducer_voting" );
    level thread spawn_round_accelerant();
}

// Namespace zm_round_accelerant
// Params 1
// Checksum 0xb802f618, Offset: 0x472
// Size: 0x23
function deactivate_rampage_inducer( params )
{
    if ( level utility::flag( "rampage_inducer_activated" ) )
    {
        set_round_accelerant( 0 );
    }
}

// Namespace zm_round_accelerant
// Params 0, eflags: 0x4
// Checksum 0x9b703ce2, Offset: 0x49d
// Size: 0x264
function private spawn_round_accelerant()
{
    level endon( #"game_ended" );
    utility::flag_wait( "scriptables_ready" );
    
    if ( utility::issharedfuncdefined( #"rampage_inducer", #"override_round_accelerant" ) )
    {
        level.s_rampage = utility::callsharedfunc( #"rampage_inducer", #"override_round_accelerant" );
    }
    else
    {
        level.s_rampage = utility::getstruct( "round_accelerant", "targetname" );
    }
    
    assert( isdefined( level.s_rampage ), "<dev string:x24>" );
    level.s_rampage.var_68f8b6d59d9f3560 = function_32e28dc65b7ed3c();
    level.s_rampage.var_e06b5c72f9591a0f = 0;
    level.s_rampage.n_round_count = 0;
    level.s_rampage.mdl = utility::spawn_model( "t10_zm_essence_container_orange", level.s_rampage.origin, level.s_rampage.angles );
    assert( level.s_rampage.mdl isscriptable(), "<dev string:x53>" );
    utility::callsharedfunc( #"scriptable", #"hash_10d5e3bb8a551724", level.s_rampage.mdl, "minimap" );
    level.s_rampage.interact = interaction::register_interact( level.s_rampage.origin + ( 0, 0, 30 ), 64, &on_interact_round_accelerant, undefined, undefined, undefined, undefined, "HINT_BUTTON" );
    level.s_rampage.interact.var_762f5d19a53f7c0 = 0;
    level.s_rampage.interact.b_cool_down = 1;
    level.s_rampage.interact.b_can_use = 1;
    level.s_rampage.interact setusefov( 130 );
    level.s_rampage.interact interaction::set_interact_hint_callback( &function_272a6dfdd1d92b1f );
    level.s_rampage.vote_hud = vote_system_shared::register_vote_hud();
}

// Namespace zm_round_accelerant
// Params 0, eflags: 0x4
// Checksum 0xaaa327fc, Offset: 0x709
// Size: 0x44
function private function_32e28dc65b7ed3c()
{
    round = zm_round_logic::get_rb_round_number();
    
    if ( !isdefined( round ) )
    {
        round = 1;
    }
    
    var_e582988afa6ff332 = int( floor( round / 5 ) );
    return clamp( 20 + var_e582988afa6ff332 * 5, 20, 95 );
}

// Namespace zm_round_accelerant
// Params 1
// Checksum 0xc25c6cc8, Offset: 0x756
// Size: 0x345
function set_round_accelerant( active )
{
    if ( !active )
    {
        setomnvar( "ui_zm_rampage_inducer_active", 0 );
        level utility::flag_clear( "rampage_inducer_activated" );
        level.var_4a38700181272d10 = 0;
        
        if ( isdefined( level.s_rampage.mdl ) && level.s_rampage.mdl isscriptable() )
        {
            level.s_rampage.mdl setscriptablepartstate( "base", "deactivate" );
            level.s_rampage.mdl setscriptablepartstate( "audio_rampind_use", "deactivate" );
        }
        
        if ( isdefined( level.s_rampage ) )
        {
            level.s_rampage.var_e06b5c72f9591a0f = 0;
        }
        
        level thread cleanup_round_accelerant();
        return;
    }
    
    setomnvar( "ui_zm_rampage_inducer_active", 1 );
    
    if ( !isdefined( level.s_rampage ) )
    {
        init_round_accelerant();
    }
    
    level utility::flag_set( "rampage_inducer_activated" );
    level.var_4a38700181272d10 = 0;
    
    if ( isdefined( level.s_rampage.mdl ) && level.s_rampage.mdl isscriptable() )
    {
        level.s_rampage.mdl setscriptablepartstate( "base", "activate" );
        level.s_rampage.mdl setscriptablepartstate( "audio_rampind_use", "activate" );
    }
    
    var_d67449707720df4a = function_32e28dc65b7ed3c();
    
    if ( isdefined( level.s_rampage ) )
    {
        level.s_rampage.var_e06b5c72f9591a0f = 1;
        level.s_rampage.var_68f8b6d59d9f3560 = var_d67449707720df4a;
    }
    
    var_88a5b75e51384e9 = getaiarray( "team_two_hundred" );
    
    foreach ( zombie in var_88a5b75e51384e9 )
    {
        if ( !isalive( zombie ) )
        {
            continue;
        }
        
        if ( issubstr( zombie.subclass, "zombie_galileo" ) )
        {
            continue;
        }
        
        if ( utility::percent_chance( var_d67449707720df4a ?? 20 ) && issubstr( zombie.subclass, "zombie_base" ) && zombie.subclass != "zombie_base_armored_agni" && zm_round_logic::get_rb_round_number() >= 20 )
        {
            zombie thread zombie_utils::function_a8ce00e0448cb6f0( "super_sprint", "rampage_inducer", 25 );
            continue;
        }
        
        if ( !zombie asm_bb::bb_movetyperequested( "super_sprint" ) )
        {
            zombie thread zombie_utils::function_a8ce00e0448cb6f0( "sprint", "rampage_inducer", 25 );
        }
    }
    
    level.override_zombie_spawn_delay = &set_zombie_spawn_delay;
    level.var_545d992d40a9d7de = &function_6d48483f3385646;
    params = { #new_override:level.var_545d992d40a9d7de };
    level callback::callback( #"hash_da9c9f574ec3737b", params );
}

// Namespace zm_round_accelerant
// Params 0
// Checksum 0x57b459a5, Offset: 0xaa3
// Size: 0xe2
function set_zombie_speed()
{
    self endon( #"death" );
    
    if ( isdefined( self.subclass ) && !issubstr( self.subclass, "zombie_base" ) && !issubstr( self.subclass, "zombie_vermin" ) && !issubstr( self.subclass, "zombie_galileo" ) )
    {
        return;
    }
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    wait 1;
    
    if ( utility::percent_chance( level.s_rampage.var_68f8b6d59d9f3560 ) && self.subclass != "zombie_base_armored_agni" && zm_round_logic::get_rb_round_number() >= 20 )
    {
        thread zombie_utils::function_a8ce00e0448cb6f0( "super_sprint", "rampage_inducer", 25 );
        return;
    }
    
    if ( !asm_bb::bb_movetyperequested( "super_sprint" ) )
    {
        thread zombie_utils::function_a8ce00e0448cb6f0( "sprint", "rampage_inducer", 25 );
    }
}

// Namespace zm_round_accelerant
// Params 0
// Checksum 0xd808185c, Offset: 0xb8d
// Size: 0x96
function restore_zombie_speed()
{
    var_88a5b75e51384e9 = getaiarray( "team_two_hundred" );
    
    foreach ( zombie in var_88a5b75e51384e9 )
    {
        if ( isalive( zombie ) )
        {
            zombie thread zombie_utils::function_a8ce00e0448cb6f0( undefined, "rampage_inducer" );
        }
    }
}

// Namespace zm_round_accelerant
// Params 2
// Checksum 0x17f03514, Offset: 0xc2b
// Size: 0x42
function set_zombie_spawn_delay( roundnumber, specialroundstruct )
{
    if ( isdefined( specialroundstruct ) )
    {
        return;
    }
    
    normal_spawn_delay = zm_round_spawning::function_5f35aa2e209190da( roundnumber, specialroundstruct );
    return min( 0.5, normal_spawn_delay * 0.5 );
}

// Namespace zm_round_accelerant
// Params 0
// Checksum 0xf12abc28, Offset: 0xc76
// Size: 0x7
function function_6d48483f3385646()
{
    return 0.5;
}

// Namespace zm_round_accelerant
// Params 2, eflags: 0x4
// Checksum 0x41b40642, Offset: 0xc86
// Size: 0x166
function private function_272a6dfdd1d92b1f( usable, player )
{
    if ( utility::flag( "zm_vote_active" ) || utility::flag( "exfil_active" ) )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( isdefined( player ) && isdefined( usable ) )
    {
        if ( player.interactions_disabled )
        {
            return { #string:&"", #type:"HINT_NOBUTTON" };
        }
    }
    
    if ( usable.b_voting || !usable.b_cool_down || !usable.b_can_use )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    string = &"SHARED_HINTSTRINGS/ACTIVATE_RAMPAGE";
    
    if ( level utility::flag( "rampage_inducer_activated" ) )
    {
        string = &"SHARED_HINTSTRINGS/DEACTIVATE_RAMPAGE";
    }
    
    return { #icon:"ui_icon_zm_ping_rampage_indicator", #buttoncallout:string, #description:&"SHARED_HINTSTRINGS/RAMPAGE_INDUCER_DESCRIPTION", #title:&"SHARED_HINTSTRINGS/RAMPAGE_INDUCER", #string:string, #type:"HINT_BUTTON" };
}

// Namespace zm_round_accelerant
// Params 1
// Checksum 0x28899eab, Offset: 0xdf5
// Size: 0x3c7
function on_interact_round_accelerant( player )
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
    
    if ( !self.b_cool_down )
    {
        return;
    }
    
    if ( !self.b_can_use )
    {
        return;
    }
    
    if ( level utility::flag( "rampage_inducer_activated" ) )
    {
        self.b_voting = 1;
        self.b_cool_down = 0;
        
        if ( level.players.size > 1 )
        {
            foreach ( e_player in level.players )
            {
                e_player thread hud_message::showsplash( "zm_rampage_inducer_deactivate_initiated", undefined, player );
            }
        }
        
        var_3faf858e79cd17bb = spawnstruct();
        var_3faf858e79cd17bb.init_message = &"hash_14926d3043f802c2";
        var_3faf858e79cd17bb.description = &"hash_43039533777f181e";
        b_passed = zm_quest::vote_think( player, var_3faf858e79cd17bb, undefined, 3 );
        self.b_voting = undefined;
        
        if ( !b_passed )
        {
            self.b_cool_down = 1;
            return;
        }
        
        set_round_accelerant( 0 );
        self.var_762f5d19a53f7c0 = 0;
        
        foreach ( e_player in level.players )
        {
            e_player thread hud_message::showsplash( "zm_rampage_inducer_deactivate" );
            e_player callback::callback( #"hash_2aa5b4d8cc07dff0" );
        }
        
        wait 8;
        self.b_cool_down = 1;
        return;
    }
    
    self.b_voting = 1;
    self.b_cool_down = 0;
    
    if ( level.players.size > 1 )
    {
        foreach ( e_player in level.players )
        {
            e_player thread hud_message::showsplash( "zm_rampage_inducer_activate_initiated", undefined, player );
        }
    }
    
    var_3faf858e79cd17bb = spawnstruct();
    var_3faf858e79cd17bb.init_message = &"hash_2caa80cc3739eb71";
    var_3faf858e79cd17bb.description = &"zm_hud/rampage_inducer_description";
    b_passed = zm_quest::vote_think( player, var_3faf858e79cd17bb, undefined, 3 );
    self.b_voting = undefined;
    
    if ( !b_passed )
    {
        self.b_cool_down = 1;
        return;
    }
    
    set_round_accelerant( 1 );
    self.var_762f5d19a53f7c0 = 1;
    
    foreach ( e_player in level.players )
    {
        e_player thread hud_message::showsplash( "zm_rampage_inducer_activate" );
        e_player callback::callback( #"hash_8d01d5b76b0739a3" );
    }
    
    wait 8;
    self.b_cool_down = 1;
}

// Namespace zm_round_accelerant
// Params 0
// Checksum 0xf0689a17, Offset: 0x11c4
// Size: 0x5c
function cleanup_round_accelerant()
{
    level thread restore_zombie_speed();
    level.override_zombie_spawn_delay = undefined;
    level.var_545d992d40a9d7de = undefined;
    level notify( #"round_accelerant_closed" );
    params = { #new_override:level.var_545d992d40a9d7de };
    level callback::callback( #"hash_da9c9f574ec3737b", params );
}

// Namespace zm_round_accelerant
// Params 1
// Checksum 0x54518e31, Offset: 0x1228
// Size: 0x24
function function_691eb243fc280e3e( params )
{
    if ( !level utility::flag( "rampage_inducer_activated" ) )
    {
        return;
    }
    
    thread set_zombie_speed();
}

// Namespace zm_round_accelerant
// Params 1
// Checksum 0x1c205d1d, Offset: 0x1254
// Size: 0x190
function function_449e7ed200f89e8c( params )
{
    level endon( #"game_ended" );
    
    if ( level utility::flag( "rampage_inducer_activated" ) )
    {
        if ( !isdefined( level.var_4a38700181272d10 ) )
        {
            level.var_4a38700181272d10 = 0;
        }
        
        level.var_4a38700181272d10++;
    }
    
    level.s_rampage.var_68f8b6d59d9f3560 = function_32e28dc65b7ed3c();
    
    if ( zm_round_logic::get_rb_round_number() >= 1000 )
    {
        if ( !isdefined( level.s_rampage.interact ) )
        {
            return;
        }
        
        level.s_rampage.interact delete();
        
        foreach ( player in level.players )
        {
            player cleanup_vote_hud();
        }
        
        playfx( level._effect[ "rampage_inducer_despawn" ], level.s_rampage.origin );
        level.s_rampage.mdl delete();
        level utility::flag_clear( "rampage_inducer_activated" );
        level thread cleanup_round_accelerant();
        level callback::remove( "on_round_end", &function_449e7ed200f89e8c );
        level callback::remove( "on_zombie_ai_spawned", &function_691eb243fc280e3e );
    }
}

/#

    // Namespace zm_round_accelerant
    // Params 1
    // Checksum 0x7e06ab01, Offset: 0x13ec
    // Size: 0xdf, Type: dev
    function function_8a9e1480fc21c85b( s_vote )
    {
        level endon( #"game_ended" );
        self endon( #"death_or_disconnect" );
        self.vote_hud.var_a8e853f391b80753 = createclientfontstring( "<dev string:x75>", "<dev string:x76>", 1 );
        self.vote_hud.var_a8e853f391b80753 hud_util::setpoint( "<dev string:x7e>", "<dev string:x7e>", 20, 75 );
        self.vote_hud.var_a8e853f391b80753 endon( #"death" );
        
        while ( true )
        {
            if ( isdefined( s_vote.n_players_needed ) )
            {
                self.vote_hud.var_a8e853f391b80753 setdevtext( "<dev string:x83>" + s_vote.n_players_needed + "<dev string:x89>" );
            }
            
            wait 0.1;
        }
    }

#/

// Namespace zm_round_accelerant
// Params 2
// Checksum 0x413e99e4, Offset: 0x14d3
// Size: 0x1b8
function function_f95517c048499db1( var_762f5d19a53f7c0, var_9f4429dcad1102a1 )
{
    if ( !isdefined( self.vote_hud ) )
    {
        self.vote_hud = spawnstruct();
    }
    
    if ( var_762f5d19a53f7c0 )
    {
        stringhint = &"SHARED_HINTSTRINGS/RAMPAGE_TITLE_ACTIVATE";
    }
    else
    {
        stringhint = &"SHARED_HINTSTRINGS/RAMPAGE_TITLE_DEACTIVATE";
    }
    
    self.vote_hud.hud_title = createclientfontstring( stringhint, "default", 1 );
    self.vote_hud.hud_title hud_util::setpoint( "LEFT", "LEFT", 20, 20 );
    
    if ( var_9f4429dcad1102a1 )
    {
        return;
    }
    
    self.vote_hud.hud_accept = createclientfontstring( &"SHARED_HINTSTRINGS/RAMPAGE_ACCEPT", "default", 1 );
    self.vote_hud.hud_accept hud_util::setpoint( "LEFT", "LEFT", 20, 45 );
    self.vote_hud.hud_decline = createclientfontstring( &"SHARED_HINTSTRINGS/RAMPAGE_DECLINE", "default", 1 );
    self.vote_hud.hud_decline hud_util::setpoint( "LEFT", "LEFT", 20, 60 );
    self.vote_hud.time_progress = createclientbar( ( 1, 1, 1 ), 100, 10 );
    self.vote_hud.time_progress hud_util::setpoint( "LEFT", "LEFT", 20, 75 );
    self.vote_hud.time_progress thread update_time_progress();
}

// Namespace zm_round_accelerant
// Params 0
// Checksum 0xc5678ca1, Offset: 0x1693
// Size: 0x64
function update_time_progress()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    start_time = gettime();
    
    while ( true )
    {
        bar_fac = utility::function_6f5d2e1f1ff70482( gettime() - start_time ) / 15;
        bar_fac = clamp( bar_fac, 0, 1 );
        hud_util::updatebar( 1 - bar_fac );
        waitframe();
    }
}

// Namespace zm_round_accelerant
// Params 0
// Checksum 0x11150a0b, Offset: 0x16ff
// Size: 0xff
function cleanup_vote_hud()
{
    if ( isdefined( self.vote_hud ) )
    {
        if ( isdefined( self.vote_hud.hud_title ) )
        {
            self.vote_hud.hud_title destroy();
        }
        
        if ( isdefined( self.vote_hud.hud_accept ) )
        {
            self.vote_hud.hud_accept destroy();
        }
        
        if ( isdefined( self.vote_hud.hud_decline ) )
        {
            self.vote_hud.hud_decline destroy();
        }
        
        if ( isdefined( self.vote_hud.time_progress ) )
        {
            self.vote_hud.time_progress hud_util::destroyelem();
        }
        
        /#
            if ( isdefined( self.vote_hud.var_a8e853f391b80753 ) )
            {
                self.vote_hud.var_a8e853f391b80753 destroy();
            }
        #/
    }
}

// Namespace zm_round_accelerant
// Params 3
// Checksum 0x7a17232, Offset: 0x1806
// Size: 0x199
function createclientbar( color, width, height )
{
    barelem = newclienthudelem( self );
    barelem.x = 0;
    barelem.y = 0;
    barelem.frac = 0;
    barelem.color = color;
    barelem.sort = -2;
    barelem.shader = "progress_bar_fill";
    barelem setshader( "progress_bar_fill", width, height );
    barelem.hidden = 0;
    barelem.archived = 0;
    barelembg = newclienthudelem( self );
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
    barelembg hud_util::setparent( level.uiparent );
    barelembg setshader( "progress_bar_bg", width + 4, height + 4 );
    barelembg.hidden = 0;
    barelembg.archived = 0;
    return barelembg;
}

// Namespace zm_round_accelerant
// Params 3
// Checksum 0x2468ee1e, Offset: 0x19a8
// Size: 0x123
function createclientfontstring( text, font, fontscale )
{
    fontelem = newclienthudelem( self );
    fontelem.elemtype = "font";
    fontelem.font = font;
    fontelem.fontscale = fontscale;
    fontelem.basefontscale = fontscale;
    fontelem.x = 0;
    fontelem.y = 0;
    fontelem.width = 0;
    fontelem.color = ( 1, 1, 1 );
    fontelem.height = int( level.fontheight * fontscale );
    fontelem.xoffset = 0;
    fontelem.yoffset = 0;
    fontelem.children = [];
    fontelem hud_util::setparent( level.uiparent );
    fontelem.hidden = 0;
    fontelem settext( text );
    fontelem.archived = 0;
    return fontelem;
}

// Namespace zm_round_accelerant
// Params 1
// Checksum 0xb65a1442, Offset: 0x1ad4
// Size: 0x154
function enable_rampage_inducer_interaction( b_can_use )
{
    if ( !( isdefined( level.s_rampage ) && isdefined( level.s_rampage.interact ) ) )
    {
        return;
    }
    
    level.s_rampage.interact.b_can_use = b_can_use;
    
    if ( b_can_use )
    {
        level.s_rampage.interact setcursorhint( "HINT_BUTTON" );
        
        if ( level.s_rampage.interact.var_762f5d19a53f7c0 )
        {
            level.s_rampage.interact sethintstring( &"SHARED_HINTSTRINGS/ACTIVATE_RAMPAGE" );
            level.s_rampage.interact setcursorhint( "HINT_BUTTON" );
        }
        else
        {
            level.s_rampage.interact sethintstring( &"SHARED_HINTSTRINGS/DEACTIVATE_RAMPAGE" );
            level.s_rampage.interact setcursorhint( "HINT_BUTTON" );
        }
        
        return;
    }
    
    level.s_rampage.interact setcursorhint( "HINT_NOBUTTON" );
    level.s_rampage.interact sethintstring( &"" );
}

