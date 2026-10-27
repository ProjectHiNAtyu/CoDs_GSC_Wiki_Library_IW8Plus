// scripts\common\mega_jump.gsc  (hash_7de2ab2569d396d7.gscc) (size: 15382 Bytes / 0x3c16 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4b2a52ed (1261064941)
// size ...... 15382 (0x3c16)
// includes .. 13  (offset: 0x39e6)
// strings ... 29  (offset: 0x3a4e)
// dev strs .. 1   (offset: 0x3c0a)
// exports ... 41  (offset: 0x252e)
// cseg ...... 0x216 + 0x2318 (0x252e)
// imports ... 118 (offset: 0x2b96)
// animtree1 . 0   (offset: 0x3c16)
// animtree2 . 0   (offset: 0x3c16)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\hud_util;
#using scripts\mp\supers;

#namespace mega_jump;

// Namespace mega_jump
// Params 1
// Checksum 0xf7df2dbc, Offset: 0x234
// Size: 0xef, Type: bool
function function_73a22993dd3552d9( jumpdata )
{
    if ( jumpdata.var_749471e3c5f60fcf && self getstance() != "stand" )
    {
        return false;
    }
    
    if ( self isinexecutionattack() || self isinexecutionvictim() )
    {
        return false;
    }
    
    if ( self ismantling() )
    {
        return false;
    }
    
    if ( self isonascender() )
    {
        return false;
    }
    
    if ( self isonladder() )
    {
        return false;
    }
    
    if ( self ishanging() )
    {
        return false;
    }
    
    if ( !self isonground() && !function_a979e5b84fc43d0b( jumpdata ) || self isswimming() )
    {
        return false;
    }
    
    if ( !player::isaliveandnotinlaststand( self ) )
    {
        return false;
    }
    
    if ( self getstance() == "prone" )
    {
        return false;
    }
    
    if ( isdefined( self.carryobject ) )
    {
        return false;
    }
    
    if ( player_utility::function_cdedd9a19069ca4c( self ) )
    {
        return false;
    }
    
    if ( vehicle::is_in_vehicle() )
    {
        return false;
    }
    
    if ( self playermount() >= 0.1 )
    {
        return true;
    }
    
    if ( self getclientomnvar( "ui_tablet_usb" ) > 0 )
    {
        return true;
    }
    
    return true;
}

// Namespace mega_jump
// Params 1
// Checksum 0xba38d069, Offset: 0x32c
// Size: 0x10c, Type: bool
function is_jump_blocked( jumpdata )
{
    raystart = utility::function_f02ebab438642e16();
    radius = jumpdata.var_dd3219c1e457c686;
    height = jumpdata.var_7c03c68f5f3ba7db;
    rayend = utility::function_f02ebab438642e16() + anglestoup( self.angles ) * height;
    contents = trace::create_contents( 0, 1, 0, 0, 0, 0, 1 );
    
    if ( isdefined( radius ) )
    {
        /#
            if ( jumpdata.debug )
            {
                level thread debug::drawsphere( raystart, radius, 10, ( 0, 1, 0 ) );
                level thread debug::drawsphere( rayend, radius, 10, ( 0, 0, 1 ) );
                level thread debug::drawline( raystart, rayend, 10, ( 1, 1, 1 ) );
            }
        #/
        
        if ( !trace::sphere_trace_passed( raystart, rayend, radius, self, contents ) && !jumpdata.var_cbd83be916eedb5 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace mega_jump
// Params 1, eflags: 0x4
// Checksum 0x6adc999f, Offset: 0x441
// Size: 0x3b, Type: bool
function private function_a979e5b84fc43d0b( jumpdata )
{
    if ( !( isdefined( jumpdata ) && isdefined( jumpdata.airtime ) ) )
    {
        return false;
    }
    
    return jumpdata.airtime <= jumpdata.var_b8cd115af1fd2864;
}

// Namespace mega_jump
// Params 1
// Checksum 0x37c5e6eb, Offset: 0x485
// Size: 0x32
function toggle_allows( isactive )
{
    if ( isactive )
    {
        val::set( "jump_superpower", "allow_jump", 0 );
        return;
    }
    
    val::reset_all( "jump_superpower" );
}

// Namespace mega_jump
// Params 1
// Checksum 0xdf114004, Offset: 0x4bf
// Size: 0x79
function start_jump( jumpdata )
{
    jumpdata.incooldown = 0;
    jumpdata.var_66d334566c265db7 = 1;
    
    if ( !jumpdata.var_d43079b5fa943d16 )
    {
        toggle_allows( 1 );
    }
    
    thread monitor_player_state( jumpdata );
    thread function_d22a5f2abdb421d( jumpdata );
    thread function_da05dc66d77b4543( jumpdata );
    callback::callback( #"player_aerial", { #end:"superJump_end" } );
}

// Namespace mega_jump
// Params 1
// Checksum 0xe5675c2f, Offset: 0x540
// Size: 0x20
function set_fall_damage_reduction( var_afdfbc5754fd384 )
{
    self.falldamageprotection = var_afdfbc5754fd384 ? 1 : undefined;
}

// Namespace mega_jump
// Params 1, eflags: 0x4
// Checksum 0xa219a82f, Offset: 0x568
// Size: 0x14a
function private function_d22a5f2abdb421d( jumpdata )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self endon( #"superJump_end" );
    
    if ( !isdefined( jumpdata ) )
    {
        return;
    }
    
    jumpdata.airtime = 0;
    framesonground = 0;
    usabilityon = 0;
    
    while ( isdefined( jumpdata ) )
    {
        if ( self isonground() || self isparachuting() )
        {
            if ( self isonground() && !usabilityon )
            {
                usabilityon = 1;
                val::set( "jump_superpower", "usability", 1 );
                val::set( "jump_superpower", "allow_jump", 1 );
            }
            
            if ( jumpdata.airtime > 0 )
            {
                if ( framesonground >= 3 )
                {
                    jumpdata.airtime = 0;
                }
                else
                {
                    framesonground++;
                }
                
                waitframe();
                continue;
            }
        }
        else
        {
            framesonground = 0;
            jumpdata.airtime += level.framedurationseconds;
            
            if ( usabilityon )
            {
                usabilityon = 0;
                val::set( "jump_superpower", "usability", 0 );
                val::set( "jump_superpower", "allow_jump", 0 );
            }
        }
        
        waitframe();
    }
    
    if ( !jumpdata.var_d43079b5fa943d16 )
    {
        toggle_allows( 0 );
    }
}

// Namespace mega_jump
// Params 1, eflags: 0x4
// Checksum 0x8f32f833, Offset: 0x6ba
// Size: 0x79
function private monitor_player_state( jumpdata )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( #"superJump_end" );
    self endon( #"hash_65e8bcca9cf92cbb" );
    
    if ( jumpdata.var_d43079b5fa943d16 )
    {
        return;
    }
    
    while ( true )
    {
        if ( self isonladder() || self ishanging() )
        {
            toggle_allows( 0 );
        }
        else
        {
            toggle_allows( 1 );
        }
        
        waitframe();
    }
}

// Namespace mega_jump
// Params 1
// Checksum 0x69e8ea35, Offset: 0x73b
// Size: 0x33
function get_jump_button( jumpdata )
{
    if ( jumpdata.var_d43079b5fa943d16 )
    {
        return ( jumpdata.jumpbutton ?? &player_utility::_jumpbuttonpressed );
    }
    
    return &player_utility::_jumpbuttonpressed;
}

// Namespace mega_jump
// Params 2
// Checksum 0x85831e64, Offset: 0x777
// Size: 0x96
function function_c13b22b1d3677046( jumpdata, var_4a256b90e2572d59 )
{
    self endon( #"superJump_end" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    jumpbutton = get_jump_button( jumpdata );
    
    while ( true )
    {
        canjump = function_73a22993dd3552d9( jumpdata );
        
        if ( self [[ jumpbutton ]]() && !jumpdata.incooldown && canjump )
        {
            function_e3c042b8026e2789( jumpdata, var_4a256b90e2572d59, undefined, jumpbutton );
            continue;
        }
        
        waitframe();
    }
}

// Namespace mega_jump
// Params 1
// Checksum 0xe409d881, Offset: 0x815
// Size: 0x7d
function function_71d518aa9f31af3( jumpdata )
{
    self endon( #"superJump_end" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( function_a410e9b3bbdb71c9() )
        {
            jumpdata.hudelem.barelem hud_util::hideelem();
        }
        else
        {
            jumpdata.hudelem.barelem hud_util::showelem();
        }
        
        waitframe();
    }
}

// Namespace mega_jump
// Params 0, eflags: 0x4
// Checksum 0xebbbcd32, Offset: 0x89a
// Size: 0x76, Type: bool
function private function_a410e9b3bbdb71c9()
{
    if ( vehicle::is_in_vehicle() )
    {
        return true;
    }
    
    if ( utility::isusingremote() )
    {
        return true;
    }
    
    if ( self isparachuting() )
    {
        return true;
    }
    
    if ( self isskydiving() )
    {
        return true;
    }
    
    if ( self isonladder() )
    {
        return true;
    }
    
    if ( self isonascender() )
    {
        return true;
    }
    
    if ( player::isreviving() )
    {
        return true;
    }
    
    if ( self playermount() >= 0.1 )
    {
        return true;
    }
    
    if ( self getclientomnvar( "ui_tablet_usb" ) > 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace mega_jump
// Params 4
// Checksum 0xa31f96a2, Offset: 0x919
// Size: 0x30e
function function_e3c042b8026e2789( jumpdata, var_4a256b90e2572d59, powerref, jumpbutton )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    while ( !self [[ jumpbutton ]]() )
    {
        waitframe();
    }
    
    if ( jumpdata.chargelock )
    {
        self.jumplink = spawn( "script_model", self.origin );
        self.jumplink setmodel( "tag_player" );
        self playerlinkto( self.jumplink, "tag_player" );
    }
    
    jumpbar = undefined;
    
    if ( jumpdata.hudelem )
    {
        jumpbar = jumpdata.hudelem.barelem;
    }
    
    fraction = jumpdata.var_2ddae231fa1bce8d ?? 0;
    up = 1;
    var_99f0d49aff00fc07 = undefined;
    var_ccfbe3a5ce661731 = getdvarint( @"hash_2e1b06481900e874", 0 ) == 1;
    
    while ( self [[ jumpbutton ]]() )
    {
        if ( jumpbar )
        {
            jumpbar hud_util::updatebar( fraction, 0 );
        }
        
        prevfrac = fraction;
        
        if ( up )
        {
            if ( function_98d36482b53486d0( jumpdata ) && !jumpdata.var_cbd83be916eedb5 && !jumpdata.var_3033f47b69bebd3 )
            {
                waitframe();
                continue;
            }
            else if ( function_14c9831165851665( jumpdata ) )
            {
                up = 0;
            }
            else
            {
                fraction += jumpdata.var_94f4b18847f3db46;
                
                if ( fraction >= 1 )
                {
                    fraction = 1;
                    
                    if ( jumpdata.var_85cfd875cb522cf5 )
                    {
                        up = 0;
                    }
                    else if ( jumpdata.var_2f81976b1022304c >= 0 )
                    {
                        if ( !var_ccfbe3a5ce661731 && !isdefined( var_99f0d49aff00fc07 ) )
                        {
                            var_99f0d49aff00fc07 = gettime() + jumpdata.var_2f81976b1022304c * 1000;
                            thread function_bb5f20a428df72e7( jumpdata, powerref, jumpdata.var_2f81976b1022304c );
                        }
                        
                        if ( gettime() >= var_99f0d49aff00fc07 )
                        {
                            break;
                        }
                    }
                }
                
                if ( jumpbar && prevfrac < jumpdata.var_4216a58f5384bbe4 && fraction >= jumpdata.var_4216a58f5384bbe4 )
                {
                    jumpbar.bar.color = jumpdata.var_8d688d62dfcbcfb8;
                }
            }
        }
        else
        {
            fraction -= jumpdata.var_94f4b18847f3db46;
            
            if ( fraction <= 0 )
            {
                fraction = 0;
                up = 1;
            }
            
            if ( jumpbar && prevfrac > jumpdata.var_4216a58f5384bbe4 && fraction <= jumpdata.var_4216a58f5384bbe4 )
            {
                jumpbar.bar.color = jumpdata.var_cbc393d6c6f0e3b;
            }
        }
        
        waitframe();
    }
    
    jumpdata.var_66d334566c265db7 = 0;
    self notify( #"hash_c03a7072c36ca50e" );
    
    if ( jumpdata.chargelock )
    {
        self unlink();
    }
    
    thread function_95e0626532c216af( jumpdata, var_4a256b90e2572d59, fraction, powerref, 1 );
}

// Namespace mega_jump
// Params 1, eflags: 0x4
// Checksum 0xa0af0163, Offset: 0xc2f
// Size: 0x49, Type: bool
function private function_98d36482b53486d0( jumpdata )
{
    if ( jumpdata.var_749471e3c5f60fcf && self getstance() != "stand" )
    {
        return true;
    }
    
    if ( self ismantling() )
    {
        return true;
    }
    
    if ( self getstance() == "prone" )
    {
        return true;
    }
    
    return false;
}

// Namespace mega_jump
// Params 1, eflags: 0x4
// Checksum 0x1d41a6d1, Offset: 0xc81
// Size: 0xa2, Type: bool
function private function_14c9831165851665( jumpdata )
{
    if ( jumpdata.var_749471e3c5f60fcf && self getstance() != "stand" )
    {
        return true;
    }
    
    if ( self isinexecutionattack() || self isinexecutionvictim() )
    {
        return true;
    }
    
    if ( self ishanging() )
    {
        return true;
    }
    
    if ( self isonladder() )
    {
        return true;
    }
    
    if ( !self isonground() && !function_a979e5b84fc43d0b( jumpdata ) || self isswimming() )
    {
        return true;
    }
    
    if ( !player::isaliveandnotinlaststand( self ) )
    {
        return true;
    }
    
    if ( self isonascender() )
    {
        return true;
    }
    
    if ( isdefined( self.carryobject ) )
    {
        return true;
    }
    
    return false;
}

// Namespace mega_jump
// Params 5
// Checksum 0x445dbe11, Offset: 0xd2c
// Size: 0x1d4
function function_95e0626532c216af( jumpdata, var_4a256b90e2572d59, fraction, powerref, var_d5b13fba5eda252b )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    canjump = function_73a22993dd3552d9( jumpdata ) && !is_jump_blocked( jumpdata );
    jumpdata.jumpsucceeded = 0;
    
    if ( fraction >= jumpdata.var_4216a58f5384bbe4 && canjump )
    {
        if ( jumpdata.var_eacbf2fc79e9e24d )
        {
            thread function_43bf34120b60df84( jumpdata, fraction );
        }
        
        set_fall_damage_reduction( 1 );
        
        if ( jumpdata.applyjumpvelocity )
        {
            self [[ jumpdata.applyjumpvelocity ]]( jumpdata, fraction );
        }
        else
        {
            function_7ba68979645347cb( jumpdata, fraction );
        }
        
        jumpdata.jumpsucceeded = 1;
        
        if ( jumpdata.jumpcharge )
        {
            if ( var_d5b13fba5eda252b )
            {
                thread function_bbf299210ef4caf3( jumpdata, undefined );
            }
        }
        
        if ( jumpdata.var_ed8a4d10547d554a )
        {
            thread function_b589a29befcba7b6( jumpdata );
        }
    }
    else
    {
        if ( jumpdata.var_e14ece62d463f34b )
        {
            if ( jumpdata.hudelem )
            {
                jumpdata.hudelem.barelem.bar.frac = 0;
            }
            else
            {
                self setclientomnvar( "ui_super_high_jump_progress", 0 );
                self setclientomnvar( "ui_super_jump_cooldown", 0 );
            }
        }
        
        if ( jumpdata.var_fb383ec529298474 && jumpdata.var_9f8f8e3512f02bdf )
        {
            [[ jumpdata.var_9f8f8e3512f02bdf ]]( jumpdata );
        }
    }
    
    function_a5031efe20ecdeda( jumpdata, var_4a256b90e2572d59, powerref, 1 );
    
    if ( var_4a256b90e2572d59 )
    {
        supers_mp::superusefinished( !jumpdata.jumpsucceeded );
    }
}

// Namespace mega_jump
// Params 2
// Checksum 0xd872e1ed, Offset: 0xf08
// Size: 0xcd
function function_43bf34120b60df84( jumpdata, fraction )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( !isdefined( jumpdata.var_eacbf2fc79e9e24d ) )
    {
        return;
    }
    
    if ( jumpdata.var_7bea7513df321b89 )
    {
        self setscriptablepartstate( jumpdata.var_eacbf2fc79e9e24d, jumpdata.var_7bea7513df321b89, 0 );
        return;
    }
    
    if ( fraction < 0.6 )
    {
        self setscriptablepartstate( jumpdata.var_eacbf2fc79e9e24d, "jump_begin_small", 0 );
        return;
    }
    
    if ( fraction < 0.8 )
    {
        self setscriptablepartstate( jumpdata.var_eacbf2fc79e9e24d, "jump_begin_med", 0 );
        return;
    }
    
    self setscriptablepartstate( jumpdata.var_eacbf2fc79e9e24d, "jump_begin_lrg", 0 );
}

// Namespace mega_jump
// Params 4, eflags: 0x4
// Checksum 0x627201b, Offset: 0xfdd
// Size: 0x52
function private function_a5031efe20ecdeda( jumpdata, var_4a256b90e2572d59, powerref, docooldown )
{
    if ( docooldown )
    {
        thread handle_jump_cooldown( jumpdata, var_4a256b90e2572d59, powerref );
    }
    
    if ( isdefined( self.jumplink ) )
    {
        self.jumplink delete();
    }
}

// Namespace mega_jump
// Params 3, eflags: 0x4
// Checksum 0xfcb47e4c, Offset: 0x1037
// Size: 0x201
function private handle_jump_cooldown( jumpdata, var_4a256b90e2572d59, powerref )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"superjump_unset" );
    self endon( #"superJump_end" );
    
    if ( !self || !isdefined( jumpdata ) || jumpdata.incooldown )
    {
        return;
    }
    
    percentcharged = 0;
    
    if ( jumpdata.hudelem )
    {
        percentcharged = jumpdata.hudelem.barelem.bar.frac;
    }
    else
    {
        percentcharged = self getclientomnvar( "ui_super_high_jump_progress" );
    }
    
    cooldownmodifier = get_cooldown_modifier( jumpdata, percentcharged );
    function_15a519539fbfa3dc( jumpdata, var_4a256b90e2572d59, cooldownmodifier );
    
    if ( jumpdata.hudelem )
    {
        function_12a16ee2a93da71a( jumpdata, cooldownmodifier );
        return;
    }
    
    cooldownsec = jumpdata.var_10b5f37366d72995;
    self setclientomnvar( "ui_super_jump_cooldown", 1 );
    
    if ( percentcharged > 0 )
    {
        jumpdata.incooldown = 1;
        cooldownsec *= cooldownmodifier;
        num_ticks = int( ceil( cooldownsec / 0.05 ) );
        var_bab0dda32753d0ad = percentcharged / num_ticks;
        
        while ( num_ticks && percentcharged > 0 )
        {
            self setclientomnvar( "ui_super_high_jump_progress", percentcharged );
            num_ticks--;
            percentcharged -= var_bab0dda32753d0ad;
            waitframe();
            
            if ( !jumpdata.var_d43079b5fa943d16 )
            {
                toggle_allows( 1 );
            }
        }
        
        self setclientomnvar( "ui_super_high_jump_progress", 0 );
        self setclientomnvar( "ui_super_jump_cooldown", 0 );
        
        if ( !jumpdata.var_d43079b5fa943d16 )
        {
            toggle_allows( 1 );
        }
        
        jumpdata.incooldown = 0;
        self notify( #"hash_fcbcbca84ae21c05" );
        return;
    }
    
    self setclientomnvar( "ui_super_high_jump_progress", 0 );
    self setclientomnvar( "ui_super_jump_cooldown", 0 );
}

// Namespace mega_jump
// Params 1
// Checksum 0xaa583684, Offset: 0x1240
// Size: 0x7b
function function_b589a29befcba7b6( jumpdata )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"superjump_unset" );
    self endon( #"superJump_end" );
    
    if ( !can_skydive() )
    {
        return;
    }
    
    waitframe();
    function_f52bb5f367da9f23( 0 );
    delay = jumpdata.var_ed8a4d10547d554a ?? 1;
    wait delay;
    function_f52bb5f367da9f23( 1 );
}

// Namespace mega_jump
// Params 3, eflags: 0x4
// Checksum 0x27eb3c95, Offset: 0x12c3
// Size: 0x65
function private function_15a519539fbfa3dc( jumpdata, var_4a256b90e2572d59, modifier )
{
    if ( jumpdata.var_97aabaf084e97f80 && var_4a256b90e2572d59 )
    {
        superinfo = self.super;
        
        if ( isdefined( superinfo ) && isdefined( superinfo.staticdata ) )
        {
            supers_mp::function_c7a8c9a907d7e68b( modifier );
        }
    }
}

// Namespace mega_jump
// Params 2, eflags: 0x4
// Checksum 0xbafc7393, Offset: 0x1330
// Size: 0x7e
function private get_cooldown_modifier( jumpdata, percentcharged )
{
    if ( isdefined( percentcharged ) && jumpdata.var_97aabaf084e97f80 )
    {
        modifier = percentcharged;
        var_25cb6201cb358af3 = jumpdata.var_b7317905c84e7152;
        
        if ( var_25cb6201cb358af3 > 0 )
        {
            var_df915f8ab06b8957 = modifier * var_25cb6201cb358af3;
            var_2fd0067fbc293c7a = modifier - var_df915f8ab06b8957;
            modifier = var_df915f8ab06b8957 * percentcharged + var_2fd0067fbc293c7a;
        }
        
        return modifier;
    }
    
    return 1;
}

// Namespace mega_jump
// Params 2
// Checksum 0x5bed36cd, Offset: 0x13b7
// Size: 0x367
function function_7ba68979645347cb( jumpdata, fraction )
{
    view_angles = self getplayerangles();
    movementdir = vectornormalize( self getvelocity() );
    playerismoving = movementdir != ( 0, 0, 0 );
    var_e3c6966a0234b9c4 = jumpdata.var_e3c6966a0234b9c4 ?? 1;
    
    if ( playerismoving )
    {
        player_fwd = anglestoforward( self.angles );
        ismovingforward = vectordot( movementdir, player_fwd ) > 0.875;
        
        if ( !ismovingforward )
        {
            movementtoangles = vectortoangles( movementdir );
            view_angles = ( view_angles[ 0 ], movementtoangles[ 1 ], 0 );
        }
    }
    
    if ( var_e3c6966a0234b9c4 )
    {
        ground_normal = get_ground_normal();
        
        if ( !isdefined( ground_normal ) )
        {
            ground_normal = ( 0, 0, 1 );
        }
        
        view_right = anglestoright( ( 0, view_angles[ 1 ], 0 ) );
        ground_fwd = vectorcross( ground_normal, view_right );
        ground_pitch = vectortoangles( ground_fwd )[ 0 ];
        ground_pitch = angleclamp180( ground_pitch );
        min_pitch = -85;
        launch_pitch = clamp( view_angles[ 0 ], min_pitch, ground_pitch );
        var_d01e318b66fb6024 = jumpdata.var_cf6f2036b33cad3e ?? -45;
        var_cffb3f8b66d53736 = jumpdata.var_70b221ff07ec53dc ?? 0;
        frac = ( launch_pitch - min_pitch ) / ( ground_pitch - min_pitch );
        pitch_correction = var_cffb3f8b66d53736 + frac * ( var_d01e318b66fb6024 - var_cffb3f8b66d53736 );
        launch_angles = ( launch_pitch + pitch_correction, view_angles[ 1 ], 0 );
        
        /#
            if ( jumpdata.debug )
            {
                debuglinestart = self.origin + ( 0, 0, 40 );
                line( debuglinestart, debuglinestart + ( 1, 0, 0 ) * 100, ( 0, 0, 0 ), undefined, undefined, 10000 );
                line( debuglinestart, debuglinestart + ( 0, 1, 0 ) * 100, ( 0, 0, 0 ), undefined, undefined, 10000 );
                line( debuglinestart, debuglinestart + ( 0, 0, 1 ) * 100, ( 0, 0, 0 ), undefined, undefined, 10000 );
                line( debuglinestart, debuglinestart + anglestoforward( view_angles ) * 100, ( 1, 1, 0 ), undefined, undefined, 10000 );
                line( debuglinestart, debuglinestart + ground_fwd * 100, ( 1, 1, 1 ), undefined, undefined, 10000 );
            }
        #/
    }
    
    pitch_add = jumpdata.var_e223901f7fa0b10a ?? 0;
    
    if ( pitch_add != 0 )
    {
        launch_angles = ( launch_angles[ 0 ] + pitch_add, launch_angles[ 1 ], launch_angles[ 2 ] );
    }
    
    fraction = fraction ?? 1;
    dir = anglestoforward( launch_angles );
    
    if ( !playerismoving && jumpdata.var_4ced135dbe9fa50c )
    {
        dir = anglestoup( ( 0, 0, 1 ) );
    }
    
    velocity = dir * fraction * jumpdata.jumpvelocity;
    self setorigin( self.origin + ( 0, 0, 20 ) );
    self setvelocity( velocity );
}

// Namespace mega_jump
// Params 2, eflags: 0x4
// Checksum 0x700aba56, Offset: 0x1726
// Size: 0x2b5
function private get_ground_normal( jumpdata, traceignore )
{
    if ( !isdefined( traceignore ) )
    {
        ignore = self;
    }
    else
    {
        ignore = traceignore;
    }
    
    ignorelist = [ ignore ];
    tracepoints = [ self.origin ];
    i = -1;
    
    while ( i <= 1 )
    {
        j = -1;
        
        while ( j <= 1 )
        {
            corner = ignore getpointinbounds( i, j, 0 );
            corner = ( corner[ 0 ], corner[ 1 ], self.origin[ 2 ] );
            tracepoints[ tracepoints.size ] = corner;
            j += 2;
        }
        
        i += 2;
    }
    
    avgnormal = ( 0, 0, 0 );
    tracehitcount = 0;
    
    foreach ( point in tracepoints )
    {
        trace = trace::_bullet_trace( point + ( 0, 0, 4 ), point + ( 0, 0, -16 ), 0, ignorelist );
        tracehit = trace[ "fraction" ] > 0 && trace[ "fraction" ] < 1;
        
        if ( tracehit )
        {
            avgnormal += trace[ "normal" ];
            tracehitcount++;
        }
        
        /#
            if ( jumpdata.debug )
            {
                if ( tracehit )
                {
                    line( point, point + trace[ "<dev string:x24>" ] * 30, ( 0, 1, 0 ), undefined, undefined, 10000 );
                    continue;
                }
                
                sphere( point, 3, ( 1, 0, 0 ), undefined, 10000 );
            }
        #/
    }
    
    if ( tracehitcount > 0 )
    {
        avgnormal /= tracehitcount;
        
        /#
            if ( jumpdata.debug )
            {
                line( self.origin, self.origin + avgnormal * 20, ( 1, 1, 1 ), undefined, undefined, 10000 );
            }
        #/
        
        return avgnormal;
    }
    
    /#
        if ( jumpdata.debug )
        {
            sphere( self.origin, 5, ( 1, 0, 0 ), undefined, 10000 );
        }
    #/
    
    return;
}

// Namespace mega_jump
// Params 1, eflags: 0x4
// Checksum 0xd3cb77ab, Offset: 0x19e3
// Size: 0xa3
function private function_da05dc66d77b4543( jumpdata )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self endon( #"superJump_end" );
    
    if ( !isdefined( jumpdata.var_5969330601bd2a4f ) )
    {
        return;
    }
    
    while ( true )
    {
        self waittill( #"hash_76158f9795c6f611" );
        self radiusdamage( self.origin, jumpdata.damageradius ?? 256, function_dc7c0e066abe5ecf( jumpdata ), jumpdata.var_20d433e71e42e8ca, self, "MOD_CRUSH", jumpdata.var_6acc825afc52be6e );
        thread function_4d5b907516fd4178( jumpdata );
    }
}

// Namespace mega_jump
// Params 1, eflags: 0x4
// Checksum 0x9c451136, Offset: 0x1a8e
// Size: 0x77
function private function_dc7c0e066abe5ecf( jumpdata )
{
    if ( !( isdefined( jumpdata ) && isdefined( jumpdata.airtime ) ) || jumpdata.var_5969330601bd2a4f == 0 )
    {
        return jumpdata.var_20d433e71e42e8ca;
    }
    
    multfactor = clamp( jumpdata.airtime / jumpdata.var_5969330601bd2a4f, 0, 1 );
    return jumpdata.var_c853e3e5f6b758dc * multfactor;
}

// Namespace mega_jump
// Params 1, eflags: 0x4
// Checksum 0x8ee9bc6c, Offset: 0x1b0e
// Size: 0x6c
function private function_4d5b907516fd4178( jumpdata )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( !isdefined( jumpdata.var_eacbf2fc79e9e24d ) )
    {
        return;
    }
    
    self setscriptablepartstate( jumpdata.var_eacbf2fc79e9e24d, jumpdata.var_f32618e2a8138a0d, 0 );
    wait 1;
    self setscriptablepartstate( jumpdata.var_eacbf2fc79e9e24d, "off", 0 );
}

// Namespace mega_jump
// Params 2
// Checksum 0x2476f4d9, Offset: 0x1b82
// Size: 0x147
function function_bbf299210ef4caf3( jumpdata, var_4a256b90e2572d59 )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    self endon( #"superJump_end" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( var_4a256b90e2572d59 )
    {
        if ( !jumpdata.jumpsucceeded )
        {
            set_fall_damage_reduction( 0 );
            return;
        }
    }
    
    while ( self isonground() )
    {
        waitframe();
        
        if ( !self )
        {
            return;
        }
    }
    
    if ( !self isonground() && !self isswimming() )
    {
        jumpdata.isfreefalling = 1;
        set_fall_damage_reduction( 1 );
        
        while ( player::isaliveandnotinlaststand( self ) )
        {
            if ( self isonground() )
            {
                waitframe();
                break;
            }
            
            if ( self isparachuting() || self iswingsuitdeployed() )
            {
                jumpdata.isfreefalling = 0;
                set_fall_damage_reduction( 0 );
                reset_gravity( jumpdata );
                function_390b0ad3b5327478( jumpdata );
                
                if ( !jumpdata.jumpcharge )
                {
                    self notify( #"superJump_end" );
                }
                
                return;
            }
            
            waitframe();
        }
    }
    
    set_fall_damage_reduction( 0 );
    
    if ( can_skydive() )
    {
        function_f52bb5f367da9f23( 1 );
    }
    
    reset_gravity( jumpdata );
    function_390b0ad3b5327478( jumpdata );
    
    if ( self isonground() )
    {
        land_on_ground( jumpdata );
    }
}

// Namespace mega_jump
// Params 1
// Checksum 0x1690318d, Offset: 0x1cd1
// Size: 0x7c
function land_on_ground( jumpdata )
{
    if ( jumpdata.invulnerability )
    {
        thread apply_invulnerability( jumpdata );
    }
    
    if ( isdefined( jumpdata.var_f32618e2a8138a0d ) )
    {
        thread function_4d5b907516fd4178( jumpdata );
    }
    
    if ( isdefined( jumpdata.killscoreevent ) )
    {
        thread function_3b0c0163504f9c89( jumpdata );
    }
    
    if ( jumpdata.isfreefalling )
    {
        thread utility::callsharedfunc( #"stun", #"hash_6f1d67fc9c0380fd", jumpdata );
    }
}

// Namespace mega_jump
// Params 1, eflags: 0x4
// Checksum 0x82f411b5, Offset: 0x1d55
// Size: 0x3d
function private apply_invulnerability( jumpdata )
{
    val::set( "super_jump_invulnerability", "damage", 0 );
    wait jumpdata.invulnerabilityduration;
    val::set( "super_jump_invulnerability", "damage", 1 );
}

// Namespace mega_jump
// Params 1, eflags: 0xc
// Checksum 0xeb8077f, Offset: 0x1d9a
// Size: 0xeb
function private function_3b0c0163504f9c89( jumpdata )
{
    self notify( #"hash_dbea5c013edc1d84" );
    self endon( #"hash_dbea5c013edc1d84" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    jumpdata.owner = self;
    
    if ( !level callback::exists( #"on_ai_killed", &function_2f382948198227bb, jumpdata ) )
    {
        level callback::add( #"on_ai_killed", &function_2f382948198227bb, jumpdata );
    }
    
    if ( !level callback::exists( #"player_death", &function_2f382948198227bb, jumpdata ) )
    {
        level callback::add( #"player_death", &function_2f382948198227bb, jumpdata );
    }
    
    wait jumpdata.var_c804c31804a771d9;
    level callback::remove( #"on_ai_killed", &function_2f382948198227bb, jumpdata );
    level callback::remove( #"player_death", &function_2f382948198227bb, jumpdata );
}

// Namespace mega_jump
// Params 2, eflags: 0x4
// Checksum 0xbb1b3e1c, Offset: 0x1e8d
// Size: 0x60
function private function_2f382948198227bb( params, jumpdata )
{
    attacker = params.eattacker ?? params.attacker;
    
    if ( attacker != jumpdata.owner )
    {
        return;
    }
    
    attacker namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( jumpdata.killscoreevent );
}

// Namespace mega_jump
// Params 2, eflags: 0x4
// Checksum 0x897c4e91, Offset: 0x1ef5
// Size: 0x18f
function private function_12a16ee2a93da71a( jumpdata, cooldownmodifier )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"superjump_unset" );
    self endon( #"superJump_end" );
    powerbar = jumpdata.hudelem.barelem;
    percentcharged = powerbar.bar.frac;
    cooldownsec = jumpdata.var_10b5f37366d72995;
    
    if ( percentcharged > 0 )
    {
        jumpdata.incooldown = 1;
        cooldownsec *= cooldownmodifier;
        powerbar.bar.alpha = 0.4;
        powerbar.bar.color = jumpdata.var_e0f3e1650880f2cf;
        powerbar.bar scaleovertime( cooldownsec, 0, powerbar.height );
        wait cooldownsec;
        
        if ( !jumpdata.var_d43079b5fa943d16 )
        {
            toggle_allows( 1 );
        }
        
        jumpdata.incooldown = 0;
        self notify( #"hash_fcbcbca84ae21c05" );
    }
    else
    {
        powerbar hud_util::updatebar( 0, 0 );
    }
    
    powerbar.bar.color = ( 1, 1, 1 );
    powerbar.bar.alpha = 0.9;
}

// Namespace mega_jump
// Params 3, eflags: 0x4
// Checksum 0x78237da1, Offset: 0x208c
// Size: 0x125
function private function_bb5f20a428df72e7( jumpdata, powerref, time )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_c03a7072c36ca50e" );
    jumpbar = jumpdata.hudelem.barelem;
    
    if ( !jumpdata.var_f6fe964172e0713b || time <= 0 )
    {
        return;
    }
    
    waittimes = br_circle::array_init_distribute( time, int( time * 5 ), 1 );
    color = 1;
    
    for ( i = 0; i < waittimes.size ; i++ )
    {
        if ( !isdefined( jumpbar.bar ) )
        {
            return;
        }
        else if ( color )
        {
            jumpbar.bar.color = jumpdata.var_b6d9b1fbfc2f221e;
        }
        else
        {
            jumpbar.bar.color = jumpdata.var_8d688d62dfcbcfb8;
        }
        
        wait waittimes[ i ];
        color = !color;
    }
}

// Namespace mega_jump
// Params 2
// Checksum 0x25f24ace, Offset: 0x21b9
// Size: 0x1b8
function function_6f111bab77b7e98e( jumpdata, label )
{
    hudelem = hud_util::createfontstring( "default", 1.5 );
    hudelem.alignx = "left";
    hudelem.aligny = "top";
    hudelem.horzalign = "left_adjustable";
    hudelem.vertalign = "top_adjustable";
    hudelem.alpha = 0.9;
    hudelem.glowalpha = 0;
    hudelem.hidewheninmenu = 1;
    hudelem.archived = 0;
    
    if ( isdefined( label ) )
    {
        hudelem.label = label;
    }
    
    barelem = hud_util::createbar( ( 1, 1, 1 ), 160, 14 );
    barelem.x = jumpdata.barxpos;
    barelem.y = jumpdata.barypos;
    barelem.alignx = "right";
    barelem.aligny = "bottom";
    barelem.horzalign = "right_adjustable";
    barelem.vertalign = "bottom_adjustable";
    barelem function_abcd5ad537f2cc14();
    barelem.archived = 0;
    barelem.hidewheninmenu = 1;
    barelem.bar.archived = 0;
    barelem.bar.hidewheninmenu = 1;
    hudelem.barelem = barelem;
    return hudelem;
}

// Namespace mega_jump
// Params 4, eflags: 0x4
// Checksum 0x72280943, Offset: 0x237a
// Size: 0xf5
function private function_abcd5ad537f2cc14( point, relativepoint, xoffset, yoffset )
{
    self.bar.horzalign = self.horzalign;
    self.bar.vertalign = self.vertalign;
    self.bar.alignx = self.alignx;
    self.bar.aligny = self.aligny;
    self.bar.y = self.y - 2;
    self.bar.x = self.x - 2;
    hud_util::updatebar( self.bar.frac );
}

// Namespace mega_jump
// Params 1
// Checksum 0x92b1621f, Offset: 0x2477
// Size: 0x34
function reset_gravity( jumpdata )
{
    if ( jumpdata.var_1b4e0b2c23f781ca || jumpdata.var_2f73f374e23d1a57 )
    {
        self setgravityscale( 1 );
    }
}

// Namespace mega_jump
// Params 0
// Checksum 0xd732e750, Offset: 0x24b3
// Size: 0x1d, Type: bool
function can_skydive()
{
    if ( game_utility_mp::function_4818e8dcc8c3ec96() && !self.ignoreskydiving )
    {
        return true;
    }
    
    return false;
}

// Namespace mega_jump
// Params 1
// Checksum 0xc536ad88, Offset: 0x24d9
// Size: 0x1c
function function_f52bb5f367da9f23( enabled )
{
    self skydive_setdeploymentstatus( enabled );
    self skydive_setbasejumpingstatus( enabled );
}

// Namespace mega_jump
// Params 1
// Checksum 0x837f8a94, Offset: 0x24fd
// Size: 0x31
function function_390b0ad3b5327478( jumpdata )
{
    if ( jumpdata.var_eacbf2fc79e9e24d )
    {
        self setscriptablepartstate( jumpdata.var_eacbf2fc79e9e24d, "off", 0 );
    }
}

