// script_31ee2a173f3499b7  (hash_31ee2a173f3499b7.gscc) (size: 48834 Bytes / 0xbec2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x16deb00d (383692813)
// size ...... 48834 (0xbec2)
// includes .. 20  (offset: 0xafda)
// strings ... 131 (offset: 0xb07a)
// dev strs .. 144 (offset: 0xb7a2)
// exports ... 177 (offset: 0x72fa)
// cseg ...... 0xc61 + 0x6699 (0x72fa)
// imports ... 232 (offset: 0x8ea2)
// animtree1 . 0   (offset: 0xbec2)
// animtree2 . 0   (offset: 0xbec2)
#using script_4ce55cfc81c444ad;
#using script_5441a11286579ddc;
#using script_54a05cbb2455bc6f;
#using script_75994df35243cb2a;
#using scripts\common\callbacks;
#using scripts\common\queue;
#using scripts\common\scripted_widgets;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\bots\bots;
#using scripts\mp\loot\common_item;
#using scripts\mp\zm\zm_utility;
#using scripts\mp\zm\ztron\ztron_bonus_room;
#using scripts\mp\zm\ztron\ztron_enemy;
#using scripts\mp\zm\ztron\ztron_meta_progression;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_score;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace ztron_ui;

// Namespace ztron_ui
// Params 0
// Checksum 0x63239b27, Offset: 0xc7f
// Size: 0xf4
function init_ztron_ui()
{
    level.ztron.uibundles = level.ztron.uibundles ?? spawnstruct();
    function_be161c45a2d650a8();
    function_fe248a8ee5d10c6f();
    function_941dde4ba9fc1156();
    function_1df027349cb7e08f();
    function_6935dfeec4b455db();
    function_9a11cae4bd0c8dbb();
    ui::lui_registercallback( "ztron_meta_tab_show", &function_a45608c800fc82e5 );
    ui::lui_registercallback( "ztron_meta_tab_hide", &function_8bad9acac0039608 );
    ui::lui_registercallback( "ztron_meta_purchase", &function_dff727b8dcf05b7b );
    ztron_dialog::init_ztron_dialog();
    ztron_sound::function_4ac735395b173fe( "countdown_tick", "evt_ztron_countdown" );
    ztron_sound::function_4ac735395b173fe( "countdown_go", "evt_ztron_countdown_go" );
    ztron_sound::function_4ac735395b173fe( "hazard_zone", "uin_doa_splash_hazard_zone" );
    ztron_sound::function_4ac735395b173fe( "bonus_room", "uin_doa_splash_bonus_room" );
    ztron_sound::function_4ac735395b173fe( "silverback_challenge", "uin_doa_splash_silverback_challenge_begin" );
    
    /#
        level thread watchdebugdvars();
    #/
}

// Namespace ztron_ui
// Params 0
// Checksum 0x48f9ac4c, Offset: 0xd7b
// Size: 0xd
function function_f123792f377b1341()
{
    setomnvar( "ui_ztron_remaining_enemy_count", 0 );
}

// Namespace ztron_ui
// Params 0
// Checksum 0x2da40214, Offset: 0xd90
// Size: 0x9
function main()
{
    function_f123792f377b1341();
}

// Namespace ztron_ui
// Params 0
// Checksum 0x3b08f4dc, Offset: 0xda1
// Size: 0x2e, Type: bool
function function_cb44f155ea13ada2()
{
    if ( level.ztron.blitzmode )
    {
        return false;
    }
    
    return !level.ztron.var_8d2acc8bcc0c7053;
}

// Namespace ztron_ui
// Params 0
// Checksum 0xec36e88d, Offset: 0xdd8
// Size: 0x23
function function_4eb411ba146450()
{
    level.ztron.var_8d2acc8bcc0c7053 = 1;
    setomnvar( "ui_ztron_current_round_num", 0 );
}

// Namespace ztron_ui
// Params 0
// Checksum 0x85a8eb7b, Offset: 0xe03
// Size: 0x4b
function function_559d7c88c3ffd811()
{
    if ( level.ztron.blitzmode )
    {
        return;
    }
    
    level.ztron.var_8d2acc8bcc0c7053 = 0;
    setomnvar( "ui_ztron_current_round_num", level.ztron.roundnumber );
}

// Namespace ztron_ui
// Params 3
// Checksum 0xb316fb9, Offset: 0xe56
// Size: 0x38
function function_37aad40e39a9fdfe( promptref, var_e4b842a370d7b03a, var_e4b841a370d7ae07 )
{
    assert( promptref, "<dev string:x24>" );
    function_158c77eefa35b8d3( promptref, var_e4b842a370d7b03a, var_e4b841a370d7ae07 );
}

// Namespace ztron_ui
// Params 3
// Checksum 0x2299a32, Offset: 0xe96
// Size: 0x38
function function_145537baebbb5014( promptref, var_e4b842a370d7b03a, var_e4b841a370d7ae07 )
{
    assert( promptref, "<dev string:x65>" );
    thread function_a2048f7681715723( promptref, var_e4b842a370d7b03a, var_e4b841a370d7ae07 );
}

// Namespace ztron_ui
// Params 0
// Checksum 0xfec15a11, Offset: 0xed6
// Size: 0x81
function function_ed63f265289260bb()
{
    foreach ( player in level.players )
    {
        if ( isdefined( player ) )
        {
            player function_24215d7a620e26e7();
        }
    }
}

// Namespace ztron_ui
// Params 0
// Checksum 0xfb19c3c0, Offset: 0xf5f
// Size: 0x9
function function_b22cd181cc427c09()
{
    function_24215d7a620e26e7();
}

// Namespace ztron_ui
// Params 1
// Checksum 0xe7708661, Offset: 0xf70
// Size: 0x1a
function function_652bebdb4a15c169( challengename )
{
    function_37aad40e39a9fdfe( "challenge_start", challengename );
}

/#

    // Namespace ztron_ui
    // Params 1
    // Checksum 0xeaef4883, Offset: 0xf92
    // Size: 0x1f, Type: dev
    function function_b13bf7aa05e282b4( challengename )
    {
        function_f0b6e8c0ec2f6c2d( "<dev string:xa8>", challengename, 1 );
    }

#/

// Namespace ztron_ui
// Params 2
// Checksum 0x720404c3, Offset: 0xfb9
// Size: 0x24
function function_c970ade722a495c3( var_c20deeca6634e9d5, var_432837c73cc5752 )
{
    function_37aad40e39a9fdfe( "bonus_room", var_c20deeca6634e9d5, var_432837c73cc5752 );
}

// Namespace ztron_ui
// Params 1
// Checksum 0xbbfa9e8d, Offset: 0xfe5
// Size: 0x1a
function function_f7a15c1e9bacb543( var_8166982ad7436aff )
{
    function_145537baebbb5014( "fate_pickup", var_8166982ad7436aff );
}

// Namespace ztron_ui
// Params 1
// Checksum 0xd2f4b6f5, Offset: 0x1007
// Size: 0x18
function function_e8ba2d9576176792( var_432837c73cc5752 )
{
    function_37aad40e39a9fdfe( "fate_bonus_room_intro" );
}

// Namespace ztron_ui
// Params 0, eflags: 0x4
// Checksum 0xe1bec899, Offset: 0x1027
// Size: 0x12
function private function_fe248a8ee5d10c6f()
{
    level function_9775098283ada556();
    level thread function_5f0faf8e118f7a7b();
}

// Namespace ztron_ui
// Params 0, eflags: 0x4
// Checksum 0x2afee800, Offset: 0x1041
// Size: 0x16a
function private function_9775098283ada556()
{
    level.ztron.uibundles.promptentries = [];
    var_d1760b611f5a88c8 = getscriptbundle( %"hash_e6ad93508d5b45e" );
    assert( var_d1760b611f5a88c8, "<dev string:xb8>" );
    aprompts = var_d1760b611f5a88c8.promptlist;
    var_c1040049794b3d60 = aprompts.size;
    
    for ( i = 0; i < var_c1040049794b3d60 ; i++ )
    {
        var_b4f5da484b21efb = aprompts[ i ];
        var_b4f5da484b21efb.var_8984274053f994b1 = i + 1;
        level.ztron.uibundles.promptentries[ var_b4f5da484b21efb.ref ] = var_b4f5da484b21efb;
    }
    
    if ( getdvarint( @"hash_a673ff22938fd83c", 0 ) == 1 )
    {
        var_92582c35db5bbe91 = getscriptbundle( %"hash_29cc1b42be67c154" );
        
        if ( isdefined( var_92582c35db5bbe91 ) )
        {
            var_216602a6111f51f = var_92582c35db5bbe91.promptlist;
            
            for ( i = 0; i < var_216602a6111f51f.size ; i++ )
            {
                var_b4f5da484b21efb = var_216602a6111f51f[ i ];
                var_b4f5da484b21efb.var_8984274053f994b1 = var_c1040049794b3d60 + i + 1;
                level.ztron.uibundles.promptentries[ var_b4f5da484b21efb.ref ] = var_b4f5da484b21efb;
            }
        }
    }
}

// Namespace ztron_ui
// Params 1, eflags: 0x4
// Checksum 0x29e3679, Offset: 0x11b3
// Size: 0x8b
function private function_af52d668cba503d4( xhashref )
{
    assert( isxhash( xhashref ), "<dev string:xe6>" );
    promptentry = level.ztron.uibundles.promptentries[ xhashref ];
    assert( isdefined( promptentry ), "<dev string:x118>" + getxhashsourcename( xhashref ) );
    var_3c4e360968e410c3 = promptentry.var_8984274053f994b1;
    assert( var_3c4e360968e410c3 <= 127, "<dev string:x14e>" );
    return var_3c4e360968e410c3;
}

// Namespace ztron_ui
// Params 0, eflags: 0x4
// Checksum 0xf1bdb4f6, Offset: 0x1247
// Size: 0x3f
function private function_5f0faf8e118f7a7b()
{
    level endon( #"ztron_game_is_over" );
    
    while ( true )
    {
        level utility::waittill_any( "arena_completed", "ztron_exit_taken", "bonus_room_completed", "slayer_event_finished", "start_game_ended" );
        function_ed63f265289260bb();
        waitframe();
    }
}

// Namespace ztron_ui
// Params 3, eflags: 0x4
// Checksum 0x96f010b4, Offset: 0x128e
// Size: 0xa1
function private function_158c77eefa35b8d3( promptref, param1, param2 )
{
    foreach ( player in level.players )
    {
        if ( isdefined( player ) )
        {
            player thread function_a2048f7681715723( promptref, param1, param2 );
        }
    }
}

// Namespace ztron_ui
// Params 3, eflags: 0xc
// Checksum 0x5489e4ca, Offset: 0x1337
// Size: 0xf3
function private function_a2048f7681715723( promptref, param1, param2 )
{
    self notify( #"hash_c1cc9a0b96b06670" );
    self endon( #"hash_c1cc9a0b96b06670" );
    level endon( #"ztron_game_is_over" );
    self endon( #"disconnect" );
    assert( promptref, "<dev string:x1c6>" );
    hashref = isstring( promptref ) ? getxhash( promptref ) : promptref;
    omnvarvalue = function_de31418eabe6bee2( hashref, param1, param2 );
    self setclientomnvar( "ui_ztron_prompt_bits", omnvarvalue );
    self setclientomnvar( "ui_ztron_prompt_pulse", gettime() );
    soundalias = function_297555f404b90f41( hashref );
    
    if ( isdefined( soundalias ) )
    {
        self playlocalsound( soundalias );
    }
    
    var_8fc6929ec1a73de6 = function_983e779dee1ea979( hashref );
    
    if ( !var_8fc6929ec1a73de6 )
    {
        return;
    }
    
    waitframe();
    self setclientomnvar( "ui_ztron_prompt_bits", 0 );
}

// Namespace ztron_ui
// Params 3, eflags: 0x4
// Checksum 0x93260173, Offset: 0x1432
// Size: 0xae
function private function_de31418eabe6bee2( hashref, param1, param2 )
{
    var_6fb49d0e4ce9153 = function_af52d668cba503d4( hashref );
    
    if ( !isdefined( var_6fb49d0e4ce9153 ) )
    {
        return 0;
    }
    
    value = 0;
    value += var_6fb49d0e4ce9153 << 0;
    
    if ( isdefined( param1 ) )
    {
        param1 = function_4b44577c695e3962( hashref, param1, 1 );
        assert( isint( param1 ), "<dev string:x201>" );
        value += param1 << 7;
    }
    
    if ( isdefined( param2 ) )
    {
        param2 = function_4b44577c695e3962( hashref, param2, 2 );
        assert( isint( param2 ), "<dev string:x236>" );
        value += param2 << 17;
    }
    
    return value;
}

// Namespace ztron_ui
// Params 0, eflags: 0x4
// Checksum 0xf3b5f944, Offset: 0x14e9
// Size: 0x1d
function private function_24215d7a620e26e7()
{
    self setclientomnvar( "ui_ztron_prompt_bits", 0 );
    self setclientomnvar( "ui_ztron_prompt_pulse", gettime() );
}

// Namespace ztron_ui
// Params 3, eflags: 0x4
// Checksum 0xbb7838bb, Offset: 0x150e
// Size: 0xec
function private function_4b44577c695e3962( hashref, param, paramindex )
{
    assert( isxhash( hashref ), "<dev string:x26b>" );
    assert( isdefined( param ), "<dev string:x2ac>" );
    assert( isdefined( paramindex ), "<dev string:x2e7>" );
    promptentry = level.ztron.uibundles.promptentries[ hashref ];
    var_6e6bea9f0ff543ac = undefined;
    
    switch ( paramindex )
    {
        case 1:
            var_6e6bea9f0ff543ac = promptentry.var_1c07937fcecd5b01;
            break;
        case 2:
            var_6e6bea9f0ff543ac = promptentry.var_7896666c87351d9e;
            break;
        default:
            break;
    }
    
    if ( !isdefined( var_6e6bea9f0ff543ac ) )
    {
        return param;
    }
    
    return function_fc76def703d56598( var_6e6bea9f0ff543ac, param );
}

// Namespace ztron_ui
// Params 1, eflags: 0x4
// Checksum 0xb16fbda0, Offset: 0x1603
// Size: 0x57, Type: bool
function private function_983e779dee1ea979( promptref )
{
    assert( isxhash( promptref ), "<dev string:x327>" );
    promptentry = level.ztron.uibundles.promptentries[ promptref ];
    return istrue( promptentry.var_7e49796c2dc960c );
}

// Namespace ztron_ui
// Params 1, eflags: 0x4
// Checksum 0x34f9767d, Offset: 0x1663
// Size: 0x56
function private function_297555f404b90f41( promptref )
{
    assert( isxhash( promptref ), "<dev string:x35d>" );
    promptentry = level.ztron.uibundles.promptentries[ promptref ];
    return promptentry.soundalias;
}

/#

    // Namespace ztron_ui
    // Params 3, eflags: 0x4
    // Checksum 0x828460de, Offset: 0x16c2
    // Size: 0x18a, Type: dev
    function private function_f0b6e8c0ec2f6c2d( promptref, paramref, paramindex )
    {
        assert( isdefined( promptref ), "<dev string:x395>" );
        assert( isdefined( paramref ), "<dev string:x3e3>" );
        assert( isdefined( paramindex ), "<dev string:x430>" );
        promptref = isstring( promptref ) ? getxhash( promptref ) : promptref;
        paramref = isstring( paramref ) ? getxhash( paramref ) : paramref;
        promptentry = level.ztron.uibundles.promptentries[ promptref ];
        var_6e6bea9f0ff543ac = undefined;
        
        switch ( paramindex )
        {
            case 1:
                var_6e6bea9f0ff543ac = promptentry.var_1c07937fcecd5b01;
                break;
            case 2:
                var_6e6bea9f0ff543ac = promptentry.var_7896666c87351d9e;
                break;
            default:
                break;
        }
        
        assert( isdefined( var_6e6bea9f0ff543ac ), "<dev string:x47f>" + getxhashsourcename( promptref ) + "<dev string:x4e2>" + paramindex + "<dev string:x4f0>" );
        var_3752eaf7923e1e6f = level.ztron.uibundles.var_e046c442c54ef47[ var_6e6bea9f0ff543ac ];
        assert( var_3752eaf7923e1e6f, "<dev string:x4f3>" + getxhashsourcename( var_6e6bea9f0ff543ac ) + "<dev string:x544>" );
        assert( isdefined( var_3752eaf7923e1e6f[ paramref ] ), "<dev string:x54f>" + getxhashsourcename( var_6e6bea9f0ff543ac ) );
    }

#/

// Namespace ztron_ui
// Params 0
// Checksum 0xd3f8a7e6, Offset: 0x1854
// Size: 0x97
function function_58681cbec0799512()
{
    foreach ( player in level.players )
    {
        for ( i = 0; i < 4 ; i++ )
        {
            player thread function_ecddb0816040db5c( i, 0, 0 );
        }
    }
}

// Namespace ztron_ui
// Params 1
// Checksum 0xaa15ec48, Offset: 0x18f3
// Size: 0xad
function function_da161949f457f822( banner )
{
    var_8984274053f994b1 = function_fc76def703d56598( %"hash_35087f266b66f89d", banner );
    
    foreach ( player in level.players )
    {
        player thread function_ecddb0816040db5c( self.sessionuimemberindex, 1, var_8984274053f994b1 );
    }
}

// Namespace ztron_ui
// Params 1
// Checksum 0xf6ce0cf6, Offset: 0x19a8
// Size: 0x47
function function_65167952d8c180ac( banner )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    var_8984274053f994b1 = function_fc76def703d56598( %"hash_35087f266b66f89d", banner );
    thread function_ecddb0816040db5c( self.sessionuimemberindex, 1, var_8984274053f994b1 );
}

// Namespace ztron_ui
// Params 3, eflags: 0x4
// Checksum 0xbb693182, Offset: 0x19f7
// Size: 0x8b
function private function_ecddb0816040db5c( var_8bc333046a418cb6, actiontype, strindex )
{
    level endon( #"ztron_game_is_over" );
    self endon( #"disconnect" );
    squadindex = var_8bc333046a418cb6 + 1;
    value = 0;
    value += actiontype << 0;
    value += strindex << 7;
    omnvarname = "ui_ztron_player_banner_" + squadindex;
    self setclientomnvar( omnvarname, value );
    waitframe();
    self setclientomnvar( omnvarname, 2 );
    return value;
}

// Namespace ztron_ui
// Params 1
// Checksum 0xb531d6c, Offset: 0x1a8b
// Size: 0xab
function function_e5c28b773c483dbb( banner )
{
    strindex = function_fc76def703d56598( %"hash_35087f266b66f89d", banner );
    
    foreach ( player in level.players )
    {
        player thread function_8fd66f3591fbb4c4( self.sessionuimemberindex, strindex );
    }
}

// Namespace ztron_ui
// Params 0
// Checksum 0x42389a58, Offset: 0x1b3e
// Size: 0x91
function function_881375a170813656()
{
    value = 0;
    value += 0;
    
    foreach ( player in level.players )
    {
        player setclientomnvar( "ui_ztron_player_banner_5", value );
    }
}

// Namespace ztron_ui
// Params 2, eflags: 0x4
// Checksum 0x8530fd5b, Offset: 0x1bd7
// Size: 0x7d
function private function_8fd66f3591fbb4c4( var_8bc333046a418cb6, strindex )
{
    level endon( #"ztron_game_is_over" );
    self endon( #"disconnect" );
    squadindex = var_8bc333046a418cb6 + 1;
    value = 0;
    value += 1;
    value += strindex << 7;
    value += squadindex << 14;
    self setclientomnvar( "ui_ztron_player_banner_5", value );
    waitframe();
    self setclientomnvar( "ui_ztron_player_banner_5", 2 );
}

// Namespace ztron_ui
// Params 0
// Checksum 0x857829b4, Offset: 0x1c5c
// Size: 0xc
function clearplayerhint()
{
    thread function_8243fa1809b7d3e3( 0, 0, 0 );
}

// Namespace ztron_ui
// Params 0
// Checksum 0x6e2411a6, Offset: 0x1c70
// Size: 0x7e
function function_d43781ee65f990d()
{
    foreach ( player in level.players )
    {
        player thread function_8243fa1809b7d3e3( 0, 0, 0 );
    }
}

// Namespace ztron_ui
// Params 5
// Checksum 0x4cde8d8a, Offset: 0x1cf6
// Size: 0x7d
function function_787d89891b886acf( hintref, durations = 8, force = 0, hinttype = 1, additionalvalue = 0 )
{
    var_8984274053f994b1 = function_fc76def703d56598( %"hash_5b35bf57b6e362ba", hintref );
    thread function_8243fa1809b7d3e3( hinttype, var_8984274053f994b1, durations, force, additionalvalue );
}

// Namespace ztron_ui
// Params 6
// Checksum 0x74139b68, Offset: 0x1d7b
// Size: 0x11f
function function_6e791be3702fa2a8( hintref, delay = 0, durations = 8, force = 0, hinttype = 1, additionalvalue = 0 )
{
    level endon( #"ztron_game_is_over" );
    self endon( #"disconnect" );
    
    if ( delay > 0 )
    {
        wait delay;
    }
    
    foreach ( player in level.players )
    {
        var_8984274053f994b1 = function_fc76def703d56598( %"hash_5b35bf57b6e362ba", hintref );
        player thread function_8243fa1809b7d3e3( hinttype, var_8984274053f994b1, durations, force, additionalvalue );
    }
}

// Namespace ztron_ui
// Params 5, eflags: 0x4
// Checksum 0x3a5abbf3, Offset: 0x1ea2
// Size: 0x142
function private function_8243fa1809b7d3e3( actiontype, strindex, durations, force = 0, additionalvalue = 0 )
{
    level endon( #"ztron_game_is_over" );
    self endon( #"disconnect" );
    
    if ( !isplayer( self ) || !isdefined( strindex ) )
    {
        return;
    }
    
    if ( !isdefined( self.ztron.var_b6f09fd8df4d1bb[ strindex ] ) )
    {
        self.ztron.var_b6f09fd8df4d1bb[ strindex ] = 0;
    }
    
    if ( !force && self.ztron.var_b6f09fd8df4d1bb[ strindex ] >= 2 && 0 != strindex )
    {
        return;
    }
    
    value = 0;
    value += actiontype << 0;
    value += strindex << 7;
    value += durations << 14;
    value += additionalvalue << 24;
    self setclientomnvar( "ui_ztron_player_hint", value );
    waitframe();
    self setclientomnvar( "ui_ztron_player_hint", 2 );
    self.ztron.var_b6f09fd8df4d1bb[ strindex ] += 1;
}

// Namespace ztron_ui
// Params 0, eflags: 0x4
// Checksum 0x299e087e, Offset: 0x1fec
// Size: 0x2e
function private function_941dde4ba9fc1156()
{
    level callback::add( #"hash_a170ada7569c82e5", &function_f4f63fc49d3111a7 );
    level callback::add( #"hash_5b0ba7dbe42fc385", &function_cf43dfceec15f3bf );
}

// Namespace ztron_ui
// Params 1, eflags: 0x4
// Checksum 0x561cba78, Offset: 0x2022
// Size: 0x6e
function private function_f4f63fc49d3111a7( params )
{
    assert( params, "<dev string:x5aa>" );
    assert( isdefined( params.squadmemberindex ), "<dev string:x5dc>" );
    assert( isdefined( params.count ), "<dev string:x61f>" );
    setomnvar( "ui_ztron_nuke_count_" + params.squadmemberindex, params.count );
}

// Namespace ztron_ui
// Params 1, eflags: 0x4
// Checksum 0xc968229a, Offset: 0x2098
// Size: 0x6e
function private function_cf43dfceec15f3bf( params )
{
    assert( params, "<dev string:x657>" );
    assert( isdefined( params.squadmemberindex ), "<dev string:x68a>" );
    assert( isdefined( params.count ), "<dev string:x6ce>" );
    setomnvar( "ui_ztron_boost_count_" + params.squadmemberindex, params.count );
}

// Namespace ztron_ui
// Params 1
// Checksum 0x4f7fd929, Offset: 0x210e
// Size: 0x6e
function function_ee51f6fb7a9e1e40( params )
{
    assert( params, "<dev string:x707>" );
    assert( isdefined( params.squadmemberindex ), "<dev string:x73b>" );
    assert( isdefined( params.count ), "<dev string:x780>" );
    setomnvar( "ui_ztron_score_" + params.squadmemberindex, params.count );
}

// Namespace ztron_ui
// Params 1
// Checksum 0x9433d638, Offset: 0x2184
// Size: 0x6e
function function_a412ceb9a2302a81( params )
{
    assert( params, "<dev string:x7ba>" );
    assert( isdefined( params.squadmemberindex ), "<dev string:x7f4>" );
    assert( isdefined( params.count ), "<dev string:x83f>" );
    setomnvar( "ui_ztron_score_multix_" + params.squadmemberindex, params.count );
}

// Namespace ztron_ui
// Params 1
// Checksum 0x3d57b9d6, Offset: 0x21fa
// Size: 0x6e
function function_62fb0213ded4c790( params )
{
    assert( params, "<dev string:x87f>" );
    assert( isdefined( params.squadmemberindex ), "<dev string:x8c1>" );
    assert( isdefined( params.count ), "<dev string:x914>" );
    setomnvar( "ui_ztron_score_multix_progress_" + params.squadmemberindex, params.count );
}

// Namespace ztron_ui
// Params 0, eflags: 0x4
// Checksum 0x134fce69, Offset: 0x2270
// Size: 0x18
function private function_1df027349cb7e08f()
{
    level callback::add( #"hash_400f60cbd2e2cb11", &function_690da4cc46cb881f );
}

// Namespace ztron_ui
// Params 1, eflags: 0x4
// Checksum 0xd9354bb6, Offset: 0x2290
// Size: 0xb0
function private function_690da4cc46cb881f( params )
{
    assert( params, "<dev string:x95c>" );
    assert( isdefined( params.squadmemberindex ), "<dev string:x991>" );
    assert( isdefined( params.weaponlv ), "<dev string:x9d7>" );
    assert( isdefined( params.weaponincrement ), "<dev string:xa15>" );
    setomnvar( "ui_ztron_weapon_lv_" + params.squadmemberindex, int( params.weaponlv ) );
    setomnvar( "ui_ztron_weapon_pi_" + params.squadmemberindex, int( params.weaponincrement ) );
}

// Namespace ztron_ui
// Params 1
// Checksum 0x4202244d, Offset: 0x2348
// Size: 0x6e
function function_cd73203f57d03da0( params )
{
    assert( params, "<dev string:xa5a>" );
    assert( isdefined( params.squadmemberindex ), "<dev string:xa93>" );
    assert( isdefined( params.count ), "<dev string:xadd>" );
    setomnvar( "ui_ztron_lives_count_" + params.squadmemberindex, params.count );
}

// Namespace ztron_ui
// Params 1
// Checksum 0x943a827, Offset: 0x23be
// Size: 0x58
function function_134f592b4d4851c1( endtimems )
{
    if ( level.ztron.blitzmode && !level.ztron.var_7bccdb18d1ded9f2 )
    {
        setomnvar( "ui_ztron_count_down_time_ms", 2147483647 );
        return;
    }
    
    setomnvar( "ui_ztron_count_down_time_ms", endtimems );
}

// Namespace ztron_ui
// Params 1
// Checksum 0x14bd25e5, Offset: 0x241e
// Size: 0x28
function function_f41315c660256627( durationms )
{
    endtimems = gettime() + durationms;
    function_134f592b4d4851c1( endtimems );
}

// Namespace ztron_ui
// Params 0
// Checksum 0x72a16f2, Offset: 0x244e
// Size: 0x4d
function function_ce7fbecb1ea8d56f()
{
    if ( level.ztron.blitzmode && !level.ztron.var_7bccdb18d1ded9f2 )
    {
        setomnvar( "ui_ztron_count_down_time_ms", 2147483647 );
        return;
    }
    
    setomnvar( "ui_ztron_count_down_time_ms", 0 );
}

// Namespace ztron_ui
// Params 1
// Checksum 0xec8c50fc, Offset: 0x24a3
// Size: 0x19
function function_2a3f45a4f0ab93b6( timesec )
{
    function_f41315c660256627( timesec * 1000 );
}

// Namespace ztron_ui
// Params 0
// Checksum 0x5b889b84, Offset: 0x24c4
// Size: 0x9
function function_f6f4dd304ac8569b()
{
    function_ce7fbecb1ea8d56f();
}

// Namespace ztron_ui
// Params 0
// Checksum 0xd3fdfd32, Offset: 0x24d5
// Size: 0xc7
function function_1f463ca364400259()
{
    self notify( #"hash_46901b4e735636d1" );
    self endon( #"hash_46901b4e735636d1" );
    level endon( #"ztron_game_is_over" );
    level waittill( #"hash_c1b1475af2f47aa3" );
    level.ztron.blitzstarttime = gettime();
    level.ztron.var_c6662bd024bb6e72 = undefined;
    setomnvar( "ui_ztron_count_down_time_ms", 2147483647 );
    
    while ( !isdefined( level.ztron.var_c6662bd024bb6e72 ) )
    {
        elapsedms = int( clamp( gettime() - level.ztron.blitzstarttime, 0, 10000000 ) );
        setomnvar( "ui_ztron_blitz_race_time_s", elapsedms );
        waitframe();
    }
}

// Namespace ztron_ui
// Params 0
// Checksum 0xc5b81a37, Offset: 0x25a4
// Size: 0x7d
function function_ce37a481d70a78ed()
{
    if ( !isdefined( level.ztron.blitzstarttime ) )
    {
        return;
    }
    
    level.ztron.var_c6662bd024bb6e72 = int( clamp( gettime() - level.ztron.blitzstarttime, 0, 10000000 ) );
    setomnvar( "ui_ztron_blitz_race_time_s", level.ztron.var_c6662bd024bb6e72 );
    setomnvar( "ui_ztron_count_down_time_ms", 0 );
}

// Namespace ztron_ui
// Params 1
// Checksum 0xa4960bb5, Offset: 0x2629
// Size: 0x5a3
function function_3579c3e1cfd9f4ba( success = 0 )
{
    breakdown = spawnstruct();
    breakdown.elapsedms = level.ztron.var_c6662bd024bb6e72 ?? 0;
    breakdown.timepieces = level.ztron.timepiecescollected ?? 0;
    var_5346d0ac68fab7c1 = namespace_4f98d1d7dc3196d::function_de5c10056990b7da( "chronoCollector" );
    var_3ffd2f2efd0e00e9 = 40000 + var_5346d0ac68fab7c1 * 5000;
    avgplayercount = 1;
    
    if ( level.ztron.var_baa92581d736bcde > 0 )
    {
        avgplayercount = level.ztron.var_82d1944280581536 / level.ztron.var_baa92581d736bcde;
    }
    
    avgplayercount = clamp( avgplayercount, 1, getdvarint( @"party_maxplayers", 1 ) );
    breakdown.var_a4c8ebfac02e5c3 = int( breakdown.timepieces * var_3ffd2f2efd0e00e9 / avgplayercount );
    breakdown.var_400fd5601ee45aca = 0;
    breakdown.var_6a3e64a6616b0e00 = 0;
    self setclientomnvar( "ui_ztron_meta_token_count", 0 );
    allmaxed = namespace_4f98d1d7dc3196d::function_929384f55e44537f();
    var_400fd5601ee45aca = self.ztron.meta.tokens ?? 0;
    iprintln( "^3Breakdown: allMaxed=" + allmaxed + " tokens=" + var_400fd5601ee45aca );
    
    if ( allmaxed && var_400fd5601ee45aca > 0 )
    {
        breakdown.var_400fd5601ee45aca = var_400fd5601ee45aca;
        breakdown.var_6a3e64a6616b0e00 = var_400fd5601ee45aca * 15000;
        breakdown.var_a4c8ebfac02e5c3 += breakdown.var_6a3e64a6616b0e00;
        self setclientomnvar( "ui_ztron_meta_token_count", var_400fd5601ee45aca );
        self.ztron.meta.tokens = 0;
        namespace_4f98d1d7dc3196d::function_c2b0649474e1e376();
        iprintln( "^2Breakdown: converted " + var_400fd5601ee45aca + " tokens to " + breakdown.var_6a3e64a6616b0e00 + "ms" );
    }
    
    breakdown.lives = ztron_score::function_4f2852a8848fa4ce();
    breakdown.bombs = namespace_a6a7fe92789f4ad9::function_d99937c243f5f1d6();
    breakdown.var_59f1f1595961cbe = namespace_33e886a9a5b55137::function_a4ca73e22464e330();
    breakdown.scoreunits = 0;
    
    if ( isdefined( self.ztron ) && isdefined( self.ztron.score ) )
    {
        breakdown.scoreunits = int( self.ztron.score.points / 10000 );
    }
    
    breakdown.var_5e94ad8f8f707a52 = breakdown.lives * 20000;
    breakdown.var_706fe7d2dc428b6c = breakdown.bombs * 12000;
    breakdown.var_f67fd7b25b10507d = breakdown.var_59f1f1595961cbe * 7500;
    breakdown.var_6c666286214fa16b = breakdown.scoreunits * 500;
    breakdown.var_9e1b039eb653064f = self.ztron.blitzmode.var_9e1b039eb653064f ?? 0;
    breakdown.var_bb5d405632cf9df8 = self.ztron.blitzmode.var_bb5d405632cf9df8 ?? 0;
    breakdown.var_c1602c8627eaecf8 = self.ztron.blitzmode.var_c1602c8627eaecf8 ?? 0;
    breakdown.var_f46ce1edc06a1312 = self.ztron.blitzmode.var_f46ce1edc06a1312 ?? 0;
    var_1a397ba01e827061 = namespace_4f98d1d7dc3196d::function_de5c10056990b7da( "timeThief" );
    var_d186fca5e3702a81 = 1 + 0.1 * var_1a397ba01e827061;
    breakdown.var_63b850cd1542822f = int( breakdown.var_9e1b039eb653064f * 25 * var_d186fca5e3702a81 );
    breakdown.var_50a5be0ba51746c6 = int( breakdown.var_bb5d405632cf9df8 * 500 * var_d186fca5e3702a81 );
    breakdown.var_c683cbbeb0718bc6 = int( breakdown.var_c1602c8627eaecf8 * 5000 * var_d186fca5e3702a81 );
    breakdown.var_16a93834edecd7c8 = int( breakdown.var_f46ce1edc06a1312 * 20000 * var_d186fca5e3702a81 );
    breakdown.var_67c9cb7aae4c59c9 = breakdown.var_63b850cd1542822f + breakdown.var_50a5be0ba51746c6 + breakdown.var_c683cbbeb0718bc6 + breakdown.var_16a93834edecd7c8;
    breakdown.var_fb79a014a10a91af = breakdown.var_a4c8ebfac02e5c3 + breakdown.var_5e94ad8f8f707a52 + breakdown.var_706fe7d2dc428b6c + breakdown.var_f67fd7b25b10507d + breakdown.var_6c666286214fa16b + breakdown.var_67c9cb7aae4c59c9;
    breakdown.var_30e0e22993cf04e7 = breakdown.elapsedms - breakdown.var_fb79a014a10a91af;
    
    if ( breakdown.var_30e0e22993cf04e7 < 0 )
    {
        breakdown.var_30e0e22993cf04e7 = 0;
    }
    
    breakdown.success = success;
    self.ztron.blitzmode.breakdown = breakdown;
    return breakdown;
}

// Namespace ztron_ui
// Params 0
// Checksum 0x3b560795, Offset: 0x2bd5
// Size: 0x252
function function_7716b71d0d232366()
{
    if ( scripted_widgets::is_active( "ztron_blitz_breakdown" ) )
    {
        return;
    }
    
    function_ed63f265289260bb();
    setomnvar( "ui_ztron_remaining_enemy_count", 0 );
    setomnvar( "ui_ztron_blitz_escape_dur_s", 0 );
    setomnvar( "ui_ztron_blitz_pip_state", 0 );
    self setclientomnvar( "ui_ztron_blitz_meta_hint", 0 );
    widget_struct = spawnstruct();
    widget_struct.remove_on_death = 1;
    scripted_widgets::create( "ztron_blitz_breakdown", "scripted_widget_ztron_blitz_breakdown", widget_struct );
    breakdown = self.ztron.blitzmode.breakdown;
    fields = [];
    fields[ "elapsed_ms" ] = breakdown.elapsedms;
    fields[ "timepieces_count" ] = breakdown.timepieces;
    fields[ "timepieces_deduct_ms" ] = breakdown.var_a4c8ebfac02e5c3;
    fields[ "lives_count" ] = breakdown.lives;
    fields[ "lives_deduct_ms" ] = breakdown.var_5e94ad8f8f707a52;
    fields[ "bombs_count" ] = breakdown.bombs;
    fields[ "bombs_deduct_ms" ] = breakdown.var_706fe7d2dc428b6c;
    fields[ "boosts_count" ] = breakdown.var_59f1f1595961cbe;
    fields[ "boosts_deduct_ms" ] = breakdown.var_f67fd7b25b10507d;
    fields[ "score_count" ] = breakdown.scoreunits;
    fields[ "score_deduct_ms" ] = breakdown.var_6c666286214fa16b;
    fields[ "otk_total_deduct_ms" ] = breakdown.var_67c9cb7aae4c59c9;
    fields[ "otk_basic_count" ] = breakdown.var_9e1b039eb653064f;
    fields[ "otk_basic_deduct_ms" ] = breakdown.var_63b850cd1542822f;
    fields[ "otk_special_count" ] = breakdown.var_bb5d405632cf9df8;
    fields[ "otk_special_deduct_ms" ] = breakdown.var_50a5be0ba51746c6;
    fields[ "otk_elite_count" ] = breakdown.var_c1602c8627eaecf8;
    fields[ "otk_elite_deduct_ms" ] = breakdown.var_c683cbbeb0718bc6;
    fields[ "otk_boss_count" ] = breakdown.var_f46ce1edc06a1312;
    fields[ "otk_boss_deduct_ms" ] = breakdown.var_16a93834edecd7c8;
    fields[ "final_time_ms" ] = breakdown.var_30e0e22993cf04e7;
    fields[ "line_delay_ms" ] = 500;
    scripted_widgets::function_dd7a63eea5bde0dc( "ztron_blitz_breakdown", fields, 1 );
}

// Namespace ztron_ui
// Params 0
// Checksum 0x501d8233, Offset: 0x2e2f
// Size: 0x28
function function_ccc4f097446d1043()
{
    if ( scripted_widgets::is_active( "ztron_blitz_breakdown" ) )
    {
        self notify( #"hash_343fde5c43955f6f" );
        scripted_widgets::destroy( "ztron_blitz_breakdown" );
    }
}

// Namespace ztron_ui
// Params 1
// Checksum 0xf676af9f, Offset: 0x2e5f
// Size: 0x60
function function_545666b11d318ade( force = 0 )
{
    if ( getdvarint( @"hash_294f374ff45e6632" ) || getmatchrulesdata( "zmData", "disableBGB" ) )
    {
        force = 2;
    }
    
    self.ztron.blockgg = force == 2;
    self setclientomnvar( "ui_ztron_gobblegum_force_display", force );
}

// Namespace ztron_ui
// Params 1
// Checksum 0x5fca2060, Offset: 0x2ec7
// Size: 0x94
function function_f5177e090dadd8f4( force = 0 )
{
    foreach ( player in level.players )
    {
        if ( isdefined( player ) )
        {
            player function_545666b11d318ade( force );
        }
    }
}

// Namespace ztron_ui
// Params 1
// Checksum 0x2a0d1c7c, Offset: 0x2f63
// Size: 0x8a
function function_2bea9afab8148cc7( benable )
{
    foreach ( player in level.players )
    {
        player setclientomnvar( "ui_ztron_super_enable_to_show", benable );
    }
}

// Namespace ztron_ui
// Params 0
// Checksum 0x54bd0862, Offset: 0x2ff5
// Size: 0x9
function function_38a72e402dc87ace()
{
    function_4460fee577dfadba();
}

// Namespace ztron_ui
// Params 1
// Checksum 0x1d18693, Offset: 0x3006
// Size: 0x37
function function_3cd1e7679d332da7( var_14d75b25f833a4ab )
{
    if ( !self.ztron )
    {
        return;
    }
    
    self.ztron.var_bca1a69030befaca = var_14d75b25f833a4ab;
    function_4460fee577dfadba();
}

// Namespace ztron_ui
// Params 0, eflags: 0x4
// Checksum 0x106a88c9, Offset: 0x3045
// Size: 0x37
function private function_4460fee577dfadba()
{
    var_3c3145d3b1998e96 = function_7b13c7490db090e4();
    armorvalue = function_f085f654457d1feb();
    function_c103cc825a3a036f( self.sessionuimemberindex, var_3c3145d3b1998e96, armorvalue );
}

// Namespace ztron_ui
// Params 0, eflags: 0x4
// Checksum 0x416360e4, Offset: 0x3084
// Size: 0x48, Type: bool
function private function_7b13c7490db090e4()
{
    assert( isdefined( self ), "<dev string:xb1c>" );
    assert( isdefined( self.ztron ), "<dev string:xb51>" );
    
    if ( self.ztron.var_bca1a69030befaca )
    {
        return false;
    }
    
    return function_f085f654457d1feb() > 0;
}

// Namespace ztron_ui
// Params 0, eflags: 0x4
// Checksum 0xa7de6746, Offset: 0x30d5
// Size: 0x3f, Type: bool
function private function_f085f654457d1feb()
{
    assert( isdefined( self ), "<dev string:xb1c>" );
    assert( isdefined( self.ztron ), "<dev string:xb51>" );
    return self.ztron.var_6fe8ea86c8758aec ?? 0;
}

// Namespace ztron_ui
// Params 3, eflags: 0x4
// Checksum 0xce4250c4, Offset: 0x311d
// Size: 0xad
function private function_c103cc825a3a036f( sessionuimemberindex, var_3c3145d3b1998e96, armorvalue )
{
    assert( isdefined( sessionuimemberindex ), "<dev string:xb92>" );
    assert( isdefined( var_3c3145d3b1998e96 ), "<dev string:xbda>" );
    assert( isdefined( armorvalue ), "<dev string:xc19>" );
    assert( armorvalue <= 3, "<dev string:xc57>" + armorvalue + "<dev string:xc97>" + 3 );
    var_39b714439b8aac38 = "ui_ztron_armor_" + sessionuimemberindex;
    omnvarvalue = 0;
    omnvarvalue += ( var_3c3145d3b1998e96 ? 1 : 0 ) << 0;
    omnvarvalue += armorvalue << 1;
    setomnvar( var_39b714439b8aac38, omnvarvalue );
}

// Namespace ztron_ui
// Params 0
// Checksum 0x8c8a5dde, Offset: 0x31d2
// Size: 0x3a
function function_c0e9929809a7d942()
{
    assert( isdefined( self.sessionuimemberindex ), "<dev string:xca0>" );
    isshowing = getomnvar( "ui_ztron_should_show_plunder_" + self.sessionuimemberindex );
    return isshowing;
}

// Namespace ztron_ui
// Params 2
// Checksum 0x9548a5df, Offset: 0x3215
// Size: 0x71
function function_f7e6c4641e827bf8( var_9afd627d9ef8ae21, timeout )
{
    if ( level.ztron.var_95d8c7a469393957 )
    {
        return;
    }
    
    assert( isdefined( self.sessionuimemberindex ), "<dev string:xca0>" );
    setomnvar( "ui_ztron_should_show_plunder_" + self.sessionuimemberindex, var_9afd627d9ef8ae21 ? 1 : 0 );
    
    if ( isdefined( timeout ) )
    {
        thread function_6d5c61978de2c559( timeout );
    }
}

// Namespace ztron_ui
// Params 1
// Checksum 0xa736ccb4, Offset: 0x328e
// Size: 0x30
function function_6d5c61978de2c559( timeout )
{
    self endon( #"disconnect" );
    wait timeout;
    setomnvar( "ui_ztron_should_show_plunder_" + self.sessionuimemberindex, 0 );
}

// Namespace ztron_ui
// Params 0, eflags: 0x4
// Checksum 0xbcb5593a, Offset: 0x32c6
// Size: 0xe4
function private function_6935dfeec4b455db()
{
    var_58e2ce5444dc29de = getscriptbundle( %"hash_53b91298f9d931fe" );
    assert( var_58e2ce5444dc29de, "<dev string:xcde>" );
    entriesarray = var_58e2ce5444dc29de.var_f769f7791d1dc1d;
    level.ztron.uibundles.var_847e8710e6cf7a14 = [];
    var_c1040049794b3d60 = entriesarray.size;
    
    for ( i = 0; i < var_c1040049794b3d60 ; i++ )
    {
        entrystruct = entriesarray[ i ];
        level.ztron.uibundles.var_847e8710e6cf7a14[ entrystruct.var_5a5f787591779ad1 ] = entrystruct;
        entrystruct.var_b0e22dbfdf596bb3 = i + 1;
    }
    
    level callback::add( #"player_connect", &function_59a833ed495ffdb4 );
}

// Namespace ztron_ui
// Params 1, eflags: 0x4
// Checksum 0x2e44d3df, Offset: 0x33b2
// Size: 0x19
function private function_59a833ed495ffdb4( params )
{
    function_13e6f3cff9f6c2bb( function_63994aadb805dfac() );
}

// Namespace ztron_ui
// Params 1
// Checksum 0xbb624aea, Offset: 0x33d3
// Size: 0xad
function function_13e6f3cff9f6c2bb( var_bd3057133eaa4a01 )
{
    assert( isxhash( var_bd3057133eaa4a01 ), "<dev string:xd19>" );
    assert( isdefined( level.ztron.uibundles.var_847e8710e6cf7a14 ), "<dev string:xd69>" );
    entry = level.ztron.uibundles.var_847e8710e6cf7a14[ var_bd3057133eaa4a01 ];
    
    if ( !entry )
    {
        assertmsg( "<dev string:xdab>" + getxhashsourcename( var_bd3057133eaa4a01 ) + "<dev string:xe01>" );
        return;
    }
    
    self setclientomnvar( "ui_ztron_keybinding_ref", entry.var_b0e22dbfdf596bb3 );
}

// Namespace ztron_ui
// Params 1
// Checksum 0xa6c98601, Offset: 0x3488
// Size: 0xc5
function function_47fba147a5ea5291( var_bd3057133eaa4a01 )
{
    assert( var_bd3057133eaa4a01, "<dev string:xe03>" );
    assert( level.ztron.uibundles.var_847e8710e6cf7a14, "<dev string:xe4c>" );
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) )
        {
            player function_13e6f3cff9f6c2bb( var_bd3057133eaa4a01 );
        }
    }
}

// Namespace ztron_ui
// Params 1
// Checksum 0xb55f067d, Offset: 0x3555
// Size: 0x22
function function_f07e07779189a689( var_bd3057133eaa4a01 = function_63994aadb805dfac() )
{
    function_47fba147a5ea5291( var_bd3057133eaa4a01 );
}

// Namespace ztron_ui
// Params 1
// Checksum 0x158f778e, Offset: 0x357f
// Size: 0x22
function function_d3d5fb2ecccb6e13( var_bd3057133eaa4a01 = function_63994aadb805dfac() )
{
    function_13e6f3cff9f6c2bb( var_bd3057133eaa4a01 );
}

// Namespace ztron_ui
// Params 0, eflags: 0x4
// Checksum 0xd73c8afb, Offset: 0x35a9
// Size: 0x7d
function private function_63994aadb805dfac()
{
    if ( level.ztron.var_95d8c7a469393957 )
    {
        defaultref = getdvarint( @"hash_12202845e7a09a61", 0 ) == 1 ? #"arena_hardcore_fps" : #"arena_hardcore";
    }
    else
    {
        defaultref = getdvarint( @"hash_12202845e7a09a61", 0 ) == 1 ? #"arena_fps" : #"arena";
    }
    
    return defaultref;
}

// Namespace ztron_ui
// Params 1
// Checksum 0xc48f6d36, Offset: 0x362f
// Size: 0x20
function function_767b331f1efd12c9( var_432837c73cc5752 )
{
    function_c970ade722a495c3( ztron_bonus_room::get_room_category( var_432837c73cc5752 ), "racing_description" );
}

// Namespace ztron_ui
// Params 0
// Checksum 0xef05accd, Offset: 0x3657
// Size: 0x54
function function_96897bdfbaa6298b()
{
    function_70f07b9fc0432f17( 2 );
    function_37aad40e39a9fdfe( "racing_count_down" );
    level ztron_sound::ztron_playsound( "countdown_tick" );
    wait 1;
    level ztron_sound::ztron_playsound( "countdown_tick" );
    wait 1;
    level ztron_sound::ztron_playsound( "countdown_tick" );
    wait 1;
    level ztron_sound::ztron_playsound( "countdown_go" );
}

// Namespace ztron_ui
// Params 0
// Checksum 0xf223bb34, Offset: 0x36b3
// Size: 0x17
function function_d03865600d43ade()
{
    function_70f07b9fc0432f17( 3 );
    function_37aad40e39a9fdfe( "racing_start" );
}

// Namespace ztron_ui
// Params 0
// Checksum 0x8877c7e0, Offset: 0x36d2
// Size: 0x14
function function_4f292e068db3b5ab()
{
    function_70f07b9fc0432f17( 1 );
    function_f5177e090dadd8f4( 2 );
}

// Namespace ztron_ui
// Params 0
// Checksum 0xba3775ba, Offset: 0x36ee
// Size: 0x12
function function_44e8216813f94f57()
{
    function_70f07b9fc0432f17( 0 );
    function_f5177e090dadd8f4( 0 );
}

// Namespace ztron_ui
// Params 1
// Checksum 0xd79aafd5, Offset: 0x3708
// Size: 0x78
function function_f262d9b2b1d0c583( remainlaps )
{
    assert( isdefined( self.sessionuimemberindex ), "<dev string:xe92>" );
    assert( isint( remainlaps ), "<dev string:xed8>" );
    assert( remainlaps <= 999, "<dev string:xf0e>" + 999 );
    remainlaps = int( min( remainlaps, 999 ) );
    setomnvar( "ui_ztron_racing_remain_laps_" + function_aad29328502ffe83( self.sessionuimemberindex ), remainlaps );
}

// Namespace ztron_ui
// Params 1
// Checksum 0x1240965d, Offset: 0x3788
// Size: 0x78
function function_30b8cab14b533909( boosterscount )
{
    assert( isdefined( self.sessionuimemberindex ), "<dev string:xf5d>" );
    assert( isint( boosterscount ), "<dev string:xfa3>" );
    assert( boosterscount <= 999, "<dev string:xfdc>" + 999 );
    boosterscount = int( min( boosterscount, 999 ) );
    setomnvar( "ui_ztron_racing_own_boosters_count_" + function_aad29328502ffe83( self.sessionuimemberindex ), boosterscount );
}

// Namespace ztron_ui
// Params 1
// Checksum 0x1e4c9913, Offset: 0x3808
// Size: 0x78
function function_3ff205a35de1fb9d( killscount )
{
    assert( isdefined( self.sessionuimemberindex ), "<dev string:x102e>" );
    assert( isint( killscount ), "<dev string:x1074>" );
    assert( killscount <= 999, "<dev string:x10aa>" + 999 );
    killscount = int( min( killscount, 999 ) );
    setomnvar( "ui_ztron_racing_kills_" + function_aad29328502ffe83( self.sessionuimemberindex ), killscount );
}

// Namespace ztron_ui
// Params 1
// Checksum 0xb8b0cf00, Offset: 0x3888
// Size: 0x78
function function_2c4a59567887a7dc( gemsCount )
{
    assert( isdefined( self.sessionuimemberindex ), "<dev string:x10f9>" );
    assert( isint( gemsCount ), "<dev string:x113e>" );
    assert( gemsCount <= 999, "<dev string:x1172>" + 999 );
    gemsCount = int( min( gemsCount, 999 ) );
    setomnvar( "ui_ztron_racing_gems_" + function_aad29328502ffe83( self.sessionuimemberindex ), gemsCount );
}

// Namespace ztron_ui
// Params 2
// Checksum 0xe751fd4e, Offset: 0x3908
// Size: 0x95
function function_55784a0916b0cb86( endtimems, inctimes = 0 )
{
    assert( isint( endtimems ), "<dev string:x11bf>" );
    assert( isint( inctimes ), "<dev string:x11ee>" );
    assert( endtimems <= 134217727, "<dev string:x121c>" + 134217727 );
    assert( inctimes <= 31, "<dev string:x1264>" + 31 );
    timebits = ( inctimes << 0 ) + ( endtimems << 5 );
    setomnvar( "ui_ztron_racing_time_bits", timebits );
}

// Namespace ztron_ui
// Params 1
// Checksum 0xda42911f, Offset: 0x39a5
// Size: 0xc1
function function_6447749c19d2e5ac( var_a9fd009c96fde6fc )
{
    assert( isdefined( var_a9fd009c96fde6fc ), "<dev string:x12ab>" );
    assert( isint( var_a9fd009c96fde6fc.maxlaps ), "<dev string:x12ed>" );
    assert( isint( var_a9fd009c96fde6fc.timelimits ), "<dev string:x1340>" );
    assert( isint( var_a9fd009c96fde6fc.var_6f328661d639ec04 ), "<dev string:x1396>" );
    databits = 0;
    databits += var_a9fd009c96fde6fc.maxlaps << 0;
    databits += var_a9fd009c96fde6fc.timelimits << 4;
    databits += var_a9fd009c96fde6fc.var_6f328661d639ec04 << 14;
    setomnvar( "ui_ztron_racing_init_data_bits", databits );
}

// Namespace ztron_ui
// Params 1
// Checksum 0x82b01606, Offset: 0x3a6e
// Size: 0x4d
function function_16f36d279c740aa( winner )
{
    squadindex = 0;
    
    if ( isdefined( winner ) )
    {
        squadindex = winner.sessionuimemberindex + 1;
    }
    else
    {
        assertmsg( "<dev string:x13f2>" );
    }
    
    function_37aad40e39a9fdfe( "racing_winner", squadindex );
}

// Namespace ztron_ui
// Params 0
// Checksum 0x1c2f9c75, Offset: 0x3ac3
// Size: 0xb
function function_9e17b295214b44f6()
{
    function_70f07b9fc0432f17( 4 );
}

// Namespace ztron_ui
// Params 1, eflags: 0x4
// Checksum 0x1afa5d28, Offset: 0x3ad6
// Size: 0x21
function private function_70f07b9fc0432f17( var_c95efbc0576b6155 )
{
    function_aa5210c266fb86f5( var_c95efbc0576b6155 );
    setomnvar( "ui_ztron_racing_stage", var_c95efbc0576b6155 );
}

// Namespace ztron_ui
// Params 1
// Checksum 0x6037bbed, Offset: 0x3aff
// Size: 0x18
function function_8a888030d7860092( forcedisplay )
{
    setomnvar( "ui_ztron_force_display_minimap", forcedisplay );
}

// Namespace ztron_ui
// Params 1, eflags: 0x4
// Checksum 0x9d813351, Offset: 0x3b1f
// Size: 0x9f
function private function_aa5210c266fb86f5( var_c95efbc0576b6155 )
{
    if ( !isdefined( var_c95efbc0576b6155 ) )
    {
        assertmsg( "<dev string:x1421>" );
        return 0;
    }
    
    switch ( var_c95efbc0576b6155 )
    {
        case 0:
        case 1:
        case 2:
        case 3:
        case 4:
            println( "<dev string:x1459>" + var_c95efbc0576b6155 );
            return 1;
        default:
            assertmsg( "<dev string:x145e>" + var_c95efbc0576b6155 + "<dev string:x1489>" );
            return 0;
    }
}

// Namespace ztron_ui
// Params 0
// Checksum 0xa58ea212, Offset: 0x3bc6
// Size: 0x3e
function function_477495be638928c3()
{
    for ( i = 0; i < 4 ; i++ )
    {
        setomnvar( "ui_ztron_side_heli_health_" + i, -1 );
        setomnvar( "ui_ztron_side_heli_fuel_percentage_" + i, 0 );
    }
}

// Namespace ztron_ui
// Params 0
// Checksum 0xaab396c, Offset: 0x3c0c
// Size: 0x3e
function function_a4f9663d5b871640()
{
    if ( isdefined( self.sessionuimemberindex ) )
    {
        setomnvar( "ui_ztron_side_heli_health_" + self.sessionuimemberindex, -1 );
        setomnvar( "ui_ztron_side_heli_fuel_percentage_" + self.sessionuimemberindex, 0 );
    }
}

// Namespace ztron_ui
// Params 0
// Checksum 0xe4c6268c, Offset: 0x3c52
// Size: 0x52
function function_ba4ed5d9b5ec4bae()
{
    if ( isdefined( self.sessionuimemberindex ) )
    {
        vehicle = self.ztron.vehicle;
        setomnvar( "ui_ztron_side_heli_health_" + self.sessionuimemberindex, vehicle.health ?? -1 );
    }
}

// Namespace ztron_ui
// Params 0
// Checksum 0x3b5fdc0b, Offset: 0x3cac
// Size: 0x9b
function function_76bcd958c9d09b8c()
{
    if ( isdefined( self.sessionuimemberindex ) )
    {
        vehicle = self.ztron.vehicle;
        percent = 0;
        
        if ( vehicle.maxfuel > 0 && vehicle.fuel >= 0 )
        {
            percent = clamp( vehicle.fuel / vehicle.maxfuel, 0, 1 );
        }
        
        setomnvar( "ui_ztron_side_heli_fuel_percentage_" + self.sessionuimemberindex, percent );
    }
}

// Namespace ztron_ui
// Params 2
// Checksum 0x482bcb5c, Offset: 0x3d4f
// Size: 0x95
function function_835bf4fbcc8fb1a3( var_c1abfd3a2e052507, var_f79921e04efb033 = 0 )
{
    assert( isint( var_c1abfd3a2e052507 ), "<dev string:x1499>" );
    assert( isint( var_f79921e04efb033 ), "<dev string:x14db>" );
    assert( var_f79921e04efb033 <= 31, "<dev string:x151c>" + 31 + "<dev string:x1551>" + "<dev string:x159a>" );
    bits = 0;
    
    if ( var_f79921e04efb033 > 0 )
    {
        bits += var_f79921e04efb033 << 0;
    }
    
    bits += var_c1abfd3a2e052507 << 5;
    setomnvar( "ui_ztron_slayer_end_time_bits", bits );
}

// Namespace ztron_ui
// Params 1
// Checksum 0x75c590c, Offset: 0x3dec
// Size: 0x25
function function_e43f76fd8ed80050( var_72eb9bb9dd9d7a86 )
{
    function_37aad40e39a9fdfe( var_72eb9bb9dd9d7a86 ? "slayer_victory" : "slayer_lost" );
}

/#

    // Namespace ztron_ui
    // Params 1
    // Checksum 0x87f45aae, Offset: 0x3e19
    // Size: 0x1f, Type: dev
    function function_b0e9b66c0b941d65( bossname )
    {
        function_f0b6e8c0ec2f6c2d( "<dev string:x15b8>", bossname, 1 );
    }

#/

// Namespace ztron_ui
// Params 0
// Checksum 0xc969783c, Offset: 0x3e40
// Size: 0xd
function function_b44e50728d85a55f()
{
    setomnvar( "ui_ztron_slayer_treasure_bits", 0 );
}

// Namespace ztron_ui
// Params 2
// Checksum 0x1bc766e5, Offset: 0x3e55
// Size: 0x9a
function function_415162ed1c0ab5a5( icurrent, imax )
{
    assert( isint( icurrent ), "<dev string:x15d3>" );
    assert( isint( imax ), "<dev string:x1618>" );
    assert( imax > 0, "<dev string:x1659>" );
    
    if ( imax <= 0 )
    {
        return;
    }
    
    bits = 0;
    bits += 1;
    scaledfill = minint( int( icurrent / imax * 1000 ), 1000 );
    bits += scaledfill << 1;
    setomnvar( "ui_ztron_slayer_treasure_bits", bits );
}

// Namespace ztron_ui
// Params 1
// Checksum 0x8b8248c3, Offset: 0x3ef7
// Size: 0x2b
function function_5c155905dff981cc( var_cc1db5713803951 )
{
    assert( isint( var_cc1db5713803951 ), "<dev string:x1695>" );
    setomnvar( "ui_ztron_slayer_wave_number", var_cc1db5713803951 );
}

// Namespace ztron_ui
// Params 1
// Checksum 0x8cb97be9, Offset: 0x3f2a
// Size: 0x18
function function_21c2c21ccce1057d( endtimems )
{
    setomnvar( "ui_ztron_slayer_store_count_down", endtimems );
}

// Namespace ztron_ui
// Params 0
// Checksum 0xcda9e308, Offset: 0x3f4a
// Size: 0xd
function function_5307e621c8b48b6c()
{
    setomnvar( "ui_ztron_slayer_store_count_down", 0 );
}

// Namespace ztron_ui
// Params 1
// Checksum 0x56ba36cd, Offset: 0x3f5f
// Size: 0x18
function function_df7c17144068ff35( flag )
{
    setomnvar( "ui_ztron_store_alert", flag );
}

// Namespace ztron_ui
// Params 1
// Checksum 0xc9cd53c0, Offset: 0x3f7f
// Size: 0x54
function function_b3cd3901851be921( livescount )
{
    assert( isint( livescount ), "<dev string:x16d5>" );
    assert( numberinrange( livescount, 0, 7 ), "<dev string:x16f4>" + 0 + "<dev string:x1710>" + 7 + "<dev string:xe01>" );
    setomnvar( "ui_ztron_slayer_team_lives", livescount );
}

// Namespace ztron_ui
// Params 0, eflags: 0x4
// Checksum 0x8d33ca20, Offset: 0x3fdb
// Size: 0x182
function private function_be161c45a2d650a8()
{
    level.ztron.uibundles.var_e046c442c54ef47 = [];
    bundles = getscriptbundlenames( #"hash_a177b54447dcc15f" );
    
    foreach ( bundlename in bundles )
    {
        bundle = getscriptbundle( bundlename );
        
        if ( !isdefined( bundle.var_6981107be48ef427 ) )
        {
            continue;
        }
        
        var_91fc77eda3e565d6 = [];
        
        foreach ( index, stringstruct in bundle.var_6981107be48ef427 )
        {
            stringstruct.var_8984274053f994b1 = index + 1;
            var_91fc77eda3e565d6[ stringstruct.scriptref ] = stringstruct;
        }
        
        level.ztron.uibundles.var_e046c442c54ef47[ bundlename ] = var_91fc77eda3e565d6;
    }
}

// Namespace ztron_ui
// Params 2
// Checksum 0x95dfb7b8, Offset: 0x4165
// Size: 0x133
function function_fc76def703d56598( bundlename, hashref )
{
    assert( level.ztron.uibundles, "<dev string:x1713>" );
    assert( level.ztron.uibundles.var_e046c442c54ef47, "<dev string:x1744>" );
    assert( bundlename, "<dev string:x1775>" );
    assert( hashref, "<dev string:x17a0>" );
    bundlename = isstring( bundlename ) ? getxhash( bundlename ) : bundlename;
    hashref = isstring( hashref ) ? getxhash( hashref ) : hashref;
    var_f4d9f3d643b780a3 = level.ztron.uibundles.var_e046c442c54ef47[ bundlename ];
    assert( var_f4d9f3d643b780a3, "<dev string:x17c8>" + getxhashsourcename( bundlename ) + "<dev string:x544>" );
    stringstruct = var_f4d9f3d643b780a3[ hashref ];
    assert( stringstruct, "<dev string:x17ea>" + getxhashsourcename( hashref ) + "<dev string:x180c>" + getxhashsourcename( bundlename ) + "<dev string:x544>" );
    return stringstruct.var_8984274053f994b1;
}

// Namespace ztron_ui
// Params 0
// Checksum 0xf0862e04, Offset: 0x42a1
// Size: 0xa3
function showoverworld()
{
    function_f5177e090dadd8f4( 2 );
    setomnvarforallclients( "ui_ztron_disable_scoreboard", 1 );
    setomnvar( "ui_ztron_should_show_overworld", 1 );
    
    foreach ( player in level.players )
    {
        player ztron_util::set_player_frozen_vars( 1, "ztron_overworld" );
    }
}

// Namespace ztron_ui
// Params 0
// Checksum 0xf78d0ab6, Offset: 0x434c
// Size: 0x9f
function hideoverworld()
{
    setomnvar( "ui_ztron_should_show_overworld", 0 );
    
    foreach ( player in level.players )
    {
        player ztron_util::set_player_frozen_vars( 0, "ztron_overworld" );
    }
    
    function_f5177e090dadd8f4( 0 );
    setomnvarforallclients( "ui_ztron_disable_scoreboard", 0 );
}

// Namespace ztron_ui
// Params 1
// Checksum 0xf1a0521e, Offset: 0x43f3
// Size: 0x11
function function_aad29328502ffe83( sessionuimemberindex )
{
    return sessionuimemberindex + 1;
}

// Namespace ztron_ui
// Params 3
// Checksum 0xeae0bc4b, Offset: 0x440d
// Size: 0x2a, Type: bool
function numberinrange( number, min, max )
{
    return number >= min && number <= max;
}

// Namespace ztron_ui
// Params 4
// Checksum 0xaf12e28d, Offset: 0x4440
// Size: 0xb5
function function_e871c2190f0db007( var_7e0d24a9bb7c209a, loop, soundevent = undefined, var_41ebcbc1776b7ed1 = 0 )
{
    foreach ( player in level.players )
    {
        player playmovie( var_7e0d24a9bb7c209a, loop, soundevent, var_41ebcbc1776b7ed1 );
    }
}

// Namespace ztron_ui
// Params 0
// Checksum 0xe81951b5, Offset: 0x44fd
// Size: 0x7b
function function_bddb5fe817c432f1()
{
    foreach ( player in level.players )
    {
        player stopmovie();
    }
}

// Namespace ztron_ui
// Params 4
// Checksum 0xc0b5aeb, Offset: 0x4580
// Size: 0xaf
function playmovie( var_7e0d24a9bb7c209a, loop, soundevent = undefined, var_41ebcbc1776b7ed1 = 0 )
{
    if ( !isdefined( var_7e0d24a9bb7c209a ) )
    {
        return;
    }
    
    self setclientomnvar( "ui_ztron_disable_scoreboard", 1 );
    function_545666b11d318ade( 2 );
    zm_utility::set_player_frozen_vars( 1, "ztron_movie_fade" );
    
    if ( var_41ebcbc1776b7ed1 )
    {
        self setclientomnvar( "ui_zm_bink_overlay_state", 2 );
    }
    else
    {
        self setclientomnvar( "ui_zm_bink_overlay_state", 1 );
    }
    
    if ( loop )
    {
        self function_73788e9f76af4fad( var_7e0d24a9bb7c209a, 1 );
    }
    else
    {
        self playcinematicforplayer( var_7e0d24a9bb7c209a, 1 );
    }
    
    if ( isdefined( soundevent ) )
    {
        self playsoundevent( soundevent );
    }
}

// Namespace ztron_ui
// Params 0
// Checksum 0x5f892fa3, Offset: 0x4637
// Size: 0x39
function stopmovie()
{
    self stopcinematicforplayer( 1, 1 );
    self setclientomnvar( "ui_zm_bink_overlay_state", 0 );
    self setclientomnvar( "ui_ztron_disable_scoreboard", 0 );
    zm_utility::set_player_frozen_vars( 0, "ztron_movie_fade" );
    function_545666b11d318ade( 0 );
}

// Namespace ztron_ui
// Params 0
// Checksum 0x29224818, Offset: 0x4678
// Size: 0x2e
function function_464c14312837a513()
{
    setomnvar( "ui_ztron_selected_branch_count", 0 );
    setomnvar( "ui_ztron_selected_branch", ztron_util::function_34cfaede9c9a96ef() );
    waitframe();
    setomnvar( "ui_ztron_selected_branch_count", ztron_util::function_d0cfe1c172136d8a() );
}

// Namespace ztron_ui
// Params 1
// Checksum 0x6ecdb6f5, Offset: 0x46ae
// Size: 0xb2
function function_747abd5a8ffb630e( bundlename )
{
    var_27a1c8d9b799d398 = getscriptbundle( bundlename );
    assert( var_27a1c8d9b799d398, "<dev string:x181c>" );
    atips = var_27a1c8d9b799d398.tipslist;
    var_c1040049794b3d60 = atips.size;
    
    for ( i = 0; i < var_c1040049794b3d60 ; i++ )
    {
        stipsentry = atips[ i ];
        stipsentry.var_8984274053f994b1 = i + 1;
        level.ztron.uibundles.tipsentries[ stipsentry.ref ] = stipsentry;
    }
}

// Namespace ztron_ui
// Params 0
// Checksum 0x82e4d48c, Offset: 0x4768
// Size: 0x55
function function_9a11cae4bd0c8dbb()
{
    level.ztron.uibundles.tipsentries = [];
    function_747abd5a8ffb630e( %"hash_202de6dc77abf9b1" );
    
    if ( getdvarint( @"hash_a673ff22938fd83c", 0 ) == 1 )
    {
        function_747abd5a8ffb630e( %"hash_3cb409a42cda73c1" );
    }
}

// Namespace ztron_ui
// Params 1, eflags: 0x4
// Checksum 0xbcc9f130, Offset: 0x47c5
// Size: 0x79
function private function_3fbff69381657d4( xhashref )
{
    assert( isxhash( xhashref ), "<dev string:x1846>" );
    tipsentry = level.ztron.uibundles.tipsentries[ xhashref ];
    assert( isdefined( tipsentry ), "<dev string:x1876>" + getxhashsourcename( xhashref ) );
    var_b3d189c6337ac2a3 = tipsentry.var_8984274053f994b1;
    return var_b3d189c6337ac2a3;
}

// Namespace ztron_ui
// Params 1
// Checksum 0x868bd051, Offset: 0x4847
// Size: 0x9b
function function_5f0c791ad5b0768a( tipsref )
{
    assert( tipsref, "<dev string:x18aa>" );
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) )
        {
            player thread function_fa8cb9aab9b2f1ef( tipsref );
        }
    }
}

// Namespace ztron_ui
// Params 1
// Checksum 0xe3078293, Offset: 0x48ea
// Size: 0x7a
function function_50d443b158550ecd( tipref )
{
    self notify( #"hash_328d3a4330363b83" );
    self endon( #"hash_328d3a4330363b83" );
    
    if ( !isdefined( level.ztron.tipsqueue ) )
    {
        level.ztron.tipsqueue = [];
    }
    
    level.ztron.tipsqueue[ level.ztron.tipsqueue.size ] = tipref;
}

// Namespace ztron_ui
// Params 0
// Checksum 0xdf11be66, Offset: 0x496c
// Size: 0x9e
function function_5c32841a472fb828()
{
    self notify( #"hash_21c66b1760659fe5" );
    self endon( #"hash_21c66b1760659fe5" );
    level endon( #"ztron_game_is_over" );
    
    while ( level.ztron.tipsqueue.size )
    {
        tipref = level.ztron.tipsqueue[ 0 ];
        level.ztron.tipsqueue[ 0 ] = undefined;
        function_cdc669dbc8ea2101( level.ztron.tipsqueue );
        level thread function_5f0c791ad5b0768a( tipref );
        wait 0.65;
    }
}

// Namespace ztron_ui
// Params 1, eflags: 0x4
// Checksum 0xd3569084, Offset: 0x4a12
// Size: 0x73
function private function_29c21e1faf71de6e( hashref )
{
    var_3cffd94ebecd1133 = function_3fbff69381657d4( hashref );
    
    if ( !isdefined( var_3cffd94ebecd1133 ) )
    {
        return 0;
    }
    
    var_da2d39ec3e03f885 = self getclientomnvar( "ui_ztron_tips_bits" );
    var_444830535c8fa86b = int( mod( mod( var_da2d39ec3e03f885, 10 ) + 1, 10 ) );
    value = 0;
    value = var_3cffd94ebecd1133 * 10 + var_444830535c8fa86b;
    return value;
}

// Namespace ztron_ui
// Params 1
// Checksum 0xebb9dc4, Offset: 0x4a8e
// Size: 0x63
function function_fa8cb9aab9b2f1ef( tipsref )
{
    level endon( #"ztron_game_is_over" );
    self endon( #"disconnect" );
    hashref = isstring( tipsref ) ? getxhash( tipsref ) : tipsref;
    omnvarvalue = function_29c21e1faf71de6e( hashref );
    self setclientomnvar( "ui_ztron_tips_bits", omnvarvalue );
}

// Namespace ztron_ui
// Params 1
// Checksum 0x5f0a2be6, Offset: 0x4af9
// Size: 0x167
function function_901bb77b1e0ac87a( itemindex )
{
    if ( self.ztron.var_293457251497a573 )
    {
        return;
    }
    
    assert( gettime() <= self.ztron.var_ea3cdf2bb86080e8 );
    itempurchase = undefined;
    
    foreach ( item in self.ztron.var_1273ec6eee47c2 )
    {
        if ( item.globalindex == itemindex )
        {
            itempurchase = item;
            break;
        }
    }
    
    if ( itempurchase )
    {
        handled = ztron_fate::function_3a560377b08e2c42( itempurchase.itemref );
        
        if ( !handled )
        {
            handled = ztron_fate::function_42606f145c609140( itempurchase.itemref );
        }
        
        self.ztron.var_a29e0ac675549772 = itempurchase;
        self.ztron.var_1273ec6eee47c2 = undefined;
        self notify( #"ztron_fate_upgrade_item_chosen" );
        playfx( utility::getfx( "slayer_store_reward_impact" ), self.origin );
    }
}

// Namespace ztron_ui
// Params 0
// Checksum 0x121bdb00, Offset: 0x4c68
// Size: 0xcf
function function_870efd04e2df9aab()
{
    if ( self.ztron.var_1273ec6eee47c2 && self.ztron.var_1273ec6eee47c2.size > 0 )
    {
        fateitem = utility::array_random( self.ztron.var_1273ec6eee47c2 );
        handled = ztron_fate::function_3a560377b08e2c42( fateitem.itemref );
        
        if ( !handled )
        {
            handled = ztron_fate::function_42606f145c609140( fateitem.itemref );
        }
        
        playfx( utility::getfx( "slayer_store_reward_impact" ), self.origin );
    }
    
    self.ztron.var_ea3cdf2bb86080e8 = gettime();
    self.ztron.var_1273ec6eee47c2 = undefined;
}

// Namespace ztron_ui
// Params 3, eflags: 0x4
// Checksum 0x3e978854, Offset: 0x4d3f
// Size: 0x1ac
function private function_3674af9ad8a86f4f( params, start_time, endons )
{
    widget_struct = spawnstruct();
    widget_struct.remove_on_death = 1;
    scripted_widgets::create( params.ref, params.widget_type, widget_struct );
    
    if ( isdefined( params.param ) )
    {
        scripted_widgets::set_param( params.ref, params.param );
    }
    
    invalid_global_index = 255;
    fields = [];
    keys = [ "fate_upgrade_index_1", "fate_upgrade_index_2", "fate_upgrade_index_3" ];
    
    for ( i = 0; i < keys.size ; i++ )
    {
        key = keys[ i ];
        upgrade_option = params.upgrade_options[ i ];
        fields[ key ] = upgrade_option ? upgrade_option.globalindex : invalid_global_index;
    }
    
    if ( params.duration )
    {
        fields[ "fate_upgrade_duration" ] = params.duration;
    }
    
    scripted_widgets::function_dd7a63eea5bde0dc( params.ref, fields, 1 );
    self.ztron.var_ea3cdf2bb86080e8 = gettime() + params.duration * 1000;
    self.ztron.var_1273ec6eee47c2 = params.upgrade_options;
    ui::lui_registercallback( "ztron_store_purchase", &function_901bb77b1e0ac87a );
}

// Namespace ztron_ui
// Params 3, eflags: 0x4
// Checksum 0x8484c82e, Offset: 0x4ef3
// Size: 0x6a, Type: bool
function private function_a8c612553787f70b( params, start_time, var_fe902fd1ef1785b4 )
{
    if ( var_fe902fd1ef1785b4 )
    {
        return false;
    }
    
    if ( self.ztron.var_293457251497a573 )
    {
        return false;
    }
    
    if ( !isdefined( self.ztron.var_1273ec6eee47c2 ) )
    {
        return true;
    }
    
    return !scripted_widgets::is_active( params.ref );
}

// Namespace ztron_ui
// Params 1, eflags: 0x4
// Checksum 0xd06e5ae, Offset: 0x4f66
// Size: 0xb0
function private _ztron_fate_upgrade_choices_finished( params )
{
    foreach ( player in level.players )
    {
        if ( player scripted_widgets::is_active( params.ref ) )
        {
            return;
        }
    }
    
    ui::function_c2505ff7b7fc55a4( "ztron_store_purchase", &function_901bb77b1e0ac87a );
    level notify( #"ztron_fate_upgrade_choices_finished" );
}

// Namespace ztron_ui
// Params 2, eflags: 0x4
// Checksum 0xd84d680, Offset: 0x501e
// Size: 0x3e
function private function_faa46729b5651cb3( params, start_time )
{
    function_870efd04e2df9aab();
    function_f6f4dd304ac8569b();
    scripted_widgets::destroy( params.ref );
    _ztron_fate_upgrade_choices_finished( params );
}

// Namespace ztron_ui
// Params 2, eflags: 0x4
// Checksum 0x451e2a9a, Offset: 0x5064
// Size: 0x3e
function private function_4deb3a329576fed9( params, start_time )
{
    function_870efd04e2df9aab();
    function_f6f4dd304ac8569b();
    scripted_widgets::destroy( params.ref );
    _ztron_fate_upgrade_choices_finished( params );
}

// Namespace ztron_ui
// Params 4
// Checksum 0x12a4b8aa, Offset: 0x50aa
// Size: 0x15e
function ztron_fate_upgrade_show( var_6e488144472f7af9, duration, lifetime, widget_type )
{
    if ( !isdefined( var_6e488144472f7af9 ) || var_6e488144472f7af9.size == 0 )
    {
        return;
    }
    
    assert( duration > 0 && duration < 256 );
    
    if ( !isdefined( params ) )
    {
        params = spawnstruct();
    }
    
    if ( !isdefined( params.ref ) )
    {
        params.ref = "ztron_fate_upgrade";
    }
    
    if ( !isdefined( params.widget_type ) )
    {
        params.widget_type = widget_type ?? "scripted_widget_ztron_fate_upgrade";
    }
    
    params.upgrade_options = var_6e488144472f7af9;
    params.duration = duration;
    
    if ( scripted_widgets::is_active( params.ref ) )
    {
        return;
    }
    
    item = spawnstruct();
    item.init_func = &function_3674af9ad8a86f4f;
    item.break_func = &function_a8c612553787f70b;
    item.interrupt_func = &function_faa46729b5651cb3;
    item.finish_func = &function_4deb3a329576fed9;
    item.func_params = params;
    item.duration = lifetime ?? duration;
    thread queue::function_8b2f4edf07bdea0c( params.ref, item );
}

// Namespace ztron_ui
// Params 0
// Checksum 0xe945b81a, Offset: 0x5210
// Size: 0x48
function ztron_fate_upgrade_hide()
{
    if ( !isdefined( params ) )
    {
        params = spawnstruct();
    }
    
    if ( !isdefined( params.ref ) )
    {
        params.ref = "ztron_fate_upgrade";
    }
    
    scripted_widgets::destroy( params.ref );
}

// Namespace ztron_ui
// Params 1, eflags: 0x4
// Checksum 0x80f64949, Offset: 0x5260
// Size: 0xd3
function private function_dff727b8dcf05b7b( param )
{
    var_868a2a6ea40f13cf = [ "fleetFeet", "deadshot", "armory", "timeThief", "thickSkin", "chronoCollector", "diseaseInflictor", "scavenger", "secondWind", "masterBlaster" ];
    selectedindex = int( param );
    
    if ( selectedindex < 0 || selectedindex >= var_868a2a6ea40f13cf.size )
    {
        return;
    }
    
    attribute = var_868a2a6ea40f13cf[ selectedindex ];
    success = namespace_4f98d1d7dc3196d::spendtoken( attribute );
    
    if ( success )
    {
        function_e4c6bb291268e9d5();
        ztron_player_utility::function_7f458cb3544acb6b();
        self notify( #"hash_9741ab5569a50963" );
    }
}

// Namespace ztron_ui
// Params 0
// Checksum 0xe58df030, Offset: 0x533b
// Size: 0xd3
function function_e4c6bb291268e9d5()
{
    if ( !isdefined( self.ztron ) || !isdefined( self.ztron.meta ) )
    {
        return;
    }
    
    var_868a2a6ea40f13cf = [ "fleetFeet", "deadshot", "armory", "timeThief", "thickSkin", "chronoCollector", "diseaseInflictor", "scavenger", "secondWind", "masterBlaster" ];
    self setclientomnvar( "ui_ztron_meta_token_count", namespace_4f98d1d7dc3196d::function_64f7efe5d5024f66() );
    
    for ( i = 0; i < var_868a2a6ea40f13cf.size ; i++ )
    {
        self setclientomnvar( "ui_ztron_meta_level_" + i, namespace_4f98d1d7dc3196d::function_36f7e718fb0fa424( var_868a2a6ea40f13cf[ i ] ) );
    }
}

// Namespace ztron_ui
// Params 1, eflags: 0x4
// Checksum 0xad559014, Offset: 0x5416
// Size: 0x13
function private function_a45608c800fc82e5( param )
{
    function_e4c6bb291268e9d5();
}

// Namespace ztron_ui
// Params 1, eflags: 0x4
// Checksum 0x4dbcb4b4, Offset: 0x5431
// Size: 0xc
function private function_8bad9acac0039608( param )
{
    
}

// Namespace ztron_ui
// Params 1
// Checksum 0xc0d74878, Offset: 0x5445
// Size: 0xa8
function function_b4c1134ed6d00708( data )
{
    player = data.player;
    var_8f043866645d0c80 = data.var_8f043866645d0c80 ?? 1;
    newtotal = data.newtotal ?? 0;
    player setclientomnvar( "ui_ztron_meta_token_count", newtotal );
    player function_e4c6bb291268e9d5();
    player setclientomnvar( "ui_ztron_meta_token_toast", 1 );
    player thread function_5b87970944a6f167();
    player function_787d89891b886acf( "META_SCOREBOARD_HINT", 10, 1 );
    player ztron_dialog::function_927bb94feca983e8( getxhash( "meta_token_awarded_group" ) );
}

// Namespace ztron_ui
// Params 0, eflags: 0x4
// Checksum 0xa5f37bee, Offset: 0x54f5
// Size: 0x1d
function private function_5b87970944a6f167()
{
    self endon( #"disconnect" );
    wait 5;
    self setclientomnvar( "ui_ztron_meta_token_toast", 0 );
}

// Namespace ztron_ui
// Params 0
// Checksum 0x7ab1b2a6, Offset: 0x551a
// Size: 0x98
function function_a9f44f8a92e81c65()
{
    if ( "" == "" )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        player setclientomnvar( "", 1 );
        player thread function_74c05a00afd311fa();
    }
}

// Namespace ztron_ui
// Params 0
// Checksum 0x72c9adf4, Offset: 0x55ba
// Size: 0x1d
function function_1efa96816bcbb6ae()
{
    if ( "" == "" )
    {
        return;
    }
    
    self setclientomnvar( "", 0 );
}

// Namespace ztron_ui
// Params 1, eflags: 0x4
// Checksum 0x30b3c218, Offset: 0x55df
// Size: 0x30
function private function_74c05a00afd311fa( delay = 5 )
{
    self endon( #"disconnect" );
    
    if ( delay )
    {
        wait delay;
    }
    
    function_1efa96816bcbb6ae();
}

/#

    // Namespace ztron_ui
    // Params 0, eflags: 0xc
    // Checksum 0xed8bd1b8, Offset: 0x5617
    // Size: 0xe2, Type: dev
    function private watchdebugdvars()
    {
        self notify( #"hash_74dafa822b01efbe" );
        self endon( #"hash_74dafa822b01efbe" );
        level endon( #"ztron_game_is_over" );
        function_27d5d0320fc45963();
        
        while ( true )
        {
            if ( !level.var_3b4c897516e86826 )
            {
                wait 1;
                continue;
            }
            
            foreach ( dvar, func in level.var_3b4c897516e86826 )
            {
                if ( getdvar( dvar, "<dev string:x18e7>" ) != "<dev string:x18e7>" )
                {
                    [[ func ]]( function_a13e29c5db16fa11( dvar ) );
                    break;
                }
            }
            
            wait 1;
        }
    }

    // Namespace ztron_ui
    // Params 1, eflags: 0x4
    // Checksum 0x2ad81caa, Offset: 0x5701
    // Size: 0x3e, Type: dev
    function private function_a13e29c5db16fa11( dvarname )
    {
        params = getdvar( dvarname, "<dev string:x18e7>" );
        setdvar( dvarname, "<dev string:x18e7>" );
        return strtok( params, "<dev string:x18e8>" );
    }

    // Namespace ztron_ui
    // Params 0, eflags: 0x4
    // Checksum 0x672c0645, Offset: 0x5747
    // Size: 0x251, Type: dev
    function private function_27d5d0320fc45963()
    {
        function_b668f827a5fefc62( @"hash_58ff7b6520c1b3c2", &function_8c7d28e68ad8f775 );
        function_b668f827a5fefc62( @"hash_8063fdf349b7636e", &function_5448ce67d79476aa );
        function_b668f827a5fefc62( @"hash_1d605b3592dad398", &function_fda3275d06e68745 );
        function_b668f827a5fefc62( @"hash_3a37626ae49b7f66", &function_9a2bb6f29bc1635e );
        function_b668f827a5fefc62( @"hash_feaf3fe973a4b51", &function_1d0971891db8a2ad );
        function_b668f827a5fefc62( @"hash_b6b612001d2d9ba0", &function_af461c6db77be60c );
        function_b668f827a5fefc62( @"hash_2a3242648c995c36", &function_b97557cf4758535d );
        function_b668f827a5fefc62( @"hash_6e4341bf21e40de1", &function_718a58507357cc21 );
        function_b668f827a5fefc62( @"hash_c6427542ed9835b3", &function_3310bd509de997e2 );
        function_b668f827a5fefc62( @"hash_da4b8e9af3591b4e", &function_712d80b968049c29 );
        function_b668f827a5fefc62( @"hash_798403c5351c0ded", &function_de6849bfb8dc4cc4 );
        function_b668f827a5fefc62( @"hash_17787a34d794329f", &function_c00284148fd3d9db );
        function_b668f827a5fefc62( @"hash_8a45a7f7aaaf4ed4", &function_dfe2b1c0f09791c3 );
        function_b668f827a5fefc62( @"hash_8ceaaf1a02dd2e32", &function_ae493d204fcdf4c4 );
        function_b668f827a5fefc62( @"hash_4cb024d790400730", &function_dbc3f330ea352070 );
        function_b668f827a5fefc62( @"hash_9749b6bbb3583c35", &function_589e2d493be60784 );
        function_b668f827a5fefc62( @"hash_f9398412c06426db", &function_13877050d4d89143 );
        function_b668f827a5fefc62( @"hash_4168bc87da3f02fc", &function_2bc20c75d490a150 );
        function_b668f827a5fefc62( @"hash_7e56fb416a5090ab", &function_7e47e166bcd30595 );
        function_b668f827a5fefc62( @"hash_ac2287f012909697", &function_90471b772a5d209a );
        function_b668f827a5fefc62( @"hash_a11d14508c794ee1", &function_6066b12431f616e3 );
        function_b668f827a5fefc62( @"hash_e410b7ff0516ea01", &function_a4292c6b8749e1e9 );
        function_b668f827a5fefc62( @"hash_6142af8c50e44313", &function_64a738ae2941bdc9 );
        function_b668f827a5fefc62( @"hash_28663c8868a659d1", &function_e09be485c4451c68 );
        function_b668f827a5fefc62( @"hash_2916d692e8629a36", &function_933d72bddeaa6392 );
        function_b668f827a5fefc62( @"hash_ce96c3cb47603234", &function_2bea788d87639d5e );
        function_b668f827a5fefc62( @"hash_b9bd14e152924315", &function_df6f550bc728414f );
        function_b668f827a5fefc62( @"ztron_fate_upgrade_show", &function_594a87e444f4df56 );
    }

    // Namespace ztron_ui
    // Params 1, eflags: 0x4
    // Checksum 0xd3431f8c, Offset: 0x59a0
    // Size: 0xe0, Type: dev
    function private function_594a87e444f4df56( tokens )
    {
        if ( tokens.size > 0 )
        {
            foreach ( player in level.players )
            {
                if ( int( tokens[ 0 ] ) == 1 || int( tokens[ 0 ] ) == 2 )
                {
                    var_6e488144472f7af9 = player ztron_fate::function_2106022388ab40d( int( tokens[ 0 ] ) );
                    player ztron_fate_upgrade_show( var_6e488144472f7af9, 60 );
                    continue;
                }
                
                if ( int( tokens[ 0 ] ) == 3 )
                {
                    player ztron_fate_upgrade_hide();
                }
            }
        }
    }

    // Namespace ztron_ui
    // Params 2, eflags: 0x4
    // Checksum 0x7e0aa494, Offset: 0x5a88
    // Size: 0x3c, Type: dev
    function private function_b668f827a5fefc62( dvarname, func )
    {
        level.var_3b4c897516e86826 = level.var_3b4c897516e86826 ?? [];
        level.var_3b4c897516e86826[ dvarname ] = func;
    }

    // Namespace ztron_ui
    // Params 1, eflags: 0x4
    // Checksum 0x223620a7, Offset: 0x5acc
    // Size: 0x92, Type: dev
    function private function_8c7d28e68ad8f775( tokens )
    {
        promptref = tokens.size >= 1 ? tokens[ 0 ] : undefined;
        p1 = tokens.size >= 2 ? tokens[ 1 ] : undefined;
        p2 = tokens.size >= 3 ? tokens[ 2 ] : undefined;
        p1 = isdefined( p1 ) ? int( p1 ) : p1;
        p2 = isdefined( p2 ) ? int( p2 ) : p2;
        function_37aad40e39a9fdfe( promptref, p1, p2 );
    }

    // Namespace ztron_ui
    // Params 1, eflags: 0x4
    // Checksum 0x942faca0, Offset: 0x5b66
    // Size: 0x13e, Type: dev
    function private function_5448ce67d79476aa( tokens )
    {
        if ( tokens.size != 3 )
        {
            iprintln( "<dev string:x18ea>" );
            return;
        }
        
        hudindex = int( tokens[ 0 ] );
        ispick = int( tokens[ 1 ] ) == 1;
        itemname = tokens[ 2 ];
        
        foreach ( player in level.players )
        {
            if ( player.sessionuimemberindex == hudindex )
            {
                if ( ispick )
                {
                    fakeitem = spawnstruct();
                    item_bundle = getscriptbundle( "<dev string:x1973>" + itemname );
                    var_34cdd5cda21b2ad1 = item_bundle.scriptable;
                    fakeitem.count = 1;
                    player common_item::function_3f39e7be347cf7e1( item_bundle, fakeitem );
                }
                else
                {
                    player thread namespace_a6a7fe92789f4ad9::function_35260497c4cb7b2c();
                }
                
                break;
            }
        }
    }

    // Namespace ztron_ui
    // Params 1, eflags: 0x4
    // Checksum 0xe6d1dc35, Offset: 0x5cac
    // Size: 0x66, Type: dev
    function private function_fda3275d06e68745( tokens )
    {
        if ( tokens.size != 2 )
        {
            iprintln( "<dev string:x1983>" );
            return;
        }
        
        var_f118922d6f1d1e00 = int( tokens[ 0 ] );
        livescount = int( tokens[ 1 ] );
        function_cd73203f57d03da0( { #count:livescount, #squadmemberindex:var_f118922d6f1d1e00 } );
    }

    // Namespace ztron_ui
    // Params 1, eflags: 0x4
    // Checksum 0xef0ac809, Offset: 0x5d1a
    // Size: 0xb0, Type: dev
    function private function_9a2bb6f29bc1635e( tokens )
    {
        if ( tokens.size < 2 )
        {
            iprintln( "<dev string:x19fe>" );
            return;
        }
        
        entnumber = int( tokens[ 0 ] );
        dialogref = tokens[ 1 ];
        bimmediately = tokens.size >= 3 ? int( tokens[ 2 ] ) == 1 : 0;
        var_525bc80e74cc6950 = tokens.size >= 4 ? int( tokens[ 3 ] ) == 1 : 1;
        ent = getentbynum( entnumber );
        
        if ( ent )
        {
            ent ztron_dialog::function_7e3f6329d9afcdc1( getxhash( dialogref ), bimmediately, var_525bc80e74cc6950 );
        }
    }

    // Namespace ztron_ui
    // Params 1, eflags: 0x4
    // Checksum 0xaa6b8f2e, Offset: 0x5dd2
    // Size: 0xb0, Type: dev
    function private function_1d0971891db8a2ad( tokens )
    {
        if ( tokens.size < 2 )
        {
            iprintln( "<dev string:x1a64>" );
            return;
        }
        
        entnumber = int( tokens[ 0 ] );
        groupref = tokens[ 1 ];
        bimmediately = tokens.size >= 3 ? int( tokens[ 2 ] ) == 1 : 0;
        var_525bc80e74cc6950 = tokens.size >= 4 ? int( tokens[ 3 ] ) == 1 : 1;
        ent = getentbynum( entnumber );
        
        if ( ent )
        {
            ent ztron_dialog::function_927bb94feca983e8( getxhash( groupref ), bimmediately, var_525bc80e74cc6950 );
        }
    }

    // Namespace ztron_ui
    // Params 1, eflags: 0x4
    // Checksum 0xbb115f82, Offset: 0x5e8a
    // Size: 0x79, Type: dev
    function private function_af461c6db77be60c( tokens )
    {
        if ( tokens.size < 2 )
        {
            iprintln( "<dev string:x1ac8>" );
            return;
        }
        
        entnumber = int( tokens[ 0 ] );
        var_f3abe5b9977379d3 = int( tokens[ 1 ] );
        ent = getentbynum( entnumber );
        
        if ( ent )
        {
            ent ztron_dialog::function_7e3f6329d9afcdc1( getxhash( "<dev string:x1b25>" ), 0, 1, [ var_f3abe5b9977379d3 ] );
        }
    }

    // Namespace ztron_ui
    // Params 1, eflags: 0x4
    // Checksum 0x997224f7, Offset: 0x5f0b
    // Size: 0x72, Type: dev
    function private function_b97557cf4758535d( tokens )
    {
        if ( tokens.size < 1 )
        {
            iprintln( "<dev string:x1b30>" );
            return;
        }
        
        entnumber = int( tokens[ 0 ] );
        ent = getentbynum( entnumber );
        
        if ( ent )
        {
            ent ztron_dialog::function_7e3f6329d9afcdc1( getxhash( "<dev string:x1b73>" ), 0, 1, [ 0, 1, 2 ] );
        }
    }

    // Namespace ztron_ui
    // Params 1, eflags: 0x4
    // Checksum 0x9c9dedbd, Offset: 0x5f85
    // Size: 0xaf, Type: dev
    function private function_718a58507357cc21( tokens )
    {
        if ( tokens.size < 1 )
        {
            iprintln( "<dev string:x1b30>" );
            return;
        }
        
        entnumber = int( tokens[ 0 ] );
        ent = getentbynum( entnumber );
        
        if ( ent )
        {
            ent ztron_dialog::function_7e3f6329d9afcdc1( getxhash( "<dev string:x1b7f>" ) );
            ent ztron_dialog::function_7e3f6329d9afcdc1( getxhash( "<dev string:x1b86>" ) );
            ent ztron_dialog::function_7e3f6329d9afcdc1( getxhash( "<dev string:x1b25>" ), 0, 1, [ 0 ] );
            ent ztron_dialog::function_7e3f6329d9afcdc1( getxhash( "<dev string:x1b73>" ), 0, 1, [ 0, 0, 0 ] );
        }
    }

    // Namespace ztron_ui
    // Params 1, eflags: 0x4
    // Checksum 0xe68d6213, Offset: 0x603c
    // Size: 0xb4, Type: dev
    function private function_3310bd509de997e2( tokens )
    {
        p1 = getentbynum( 0 );
        
        if ( p1 )
        {
            p1 ztron_dialog::function_7e3f6329d9afcdc1( getxhash( "<dev string:x1b7f>" ) );
            p1 ztron_dialog::function_7e3f6329d9afcdc1( getxhash( "<dev string:x1b73>" ), 0, 1, [ 0, 0, 0 ] );
        }
        
        p2 = getentbynum( 1 );
        
        if ( p2 )
        {
            p2 ztron_dialog::function_7e3f6329d9afcdc1( getxhash( "<dev string:x1b86>" ) );
        }
        
        p3 = getentbynum( 2 );
        
        if ( p3 )
        {
            p3 ztron_dialog::function_7e3f6329d9afcdc1( getxhash( "<dev string:x1b25>" ), 0, 1, [ 2 ] );
        }
    }

    // Namespace ztron_ui
    // Params 1, eflags: 0x4
    // Checksum 0xf49a6d1e, Offset: 0x60f8
    // Size: 0xcf, Type: dev
    function private function_712d80b968049c29( tokens )
    {
        player = level.players[ 0 ];
        enes = [];
        count = 5;
        
        for ( i = 0; i < count ; i++ )
        {
            ene = ztron_enemy::function_acee91c445fafd29( ztron_enemy::function_96eea0d09d5640d1( "<dev string:x1b8d>" ), player.origin + ( 50, 50 * ( i + 1 ), 0 ), undefined, undefined, 1, 1 );
            ene.ignoreall = 1;
            ene ztron_dialog::function_7e3f6329d9afcdc1( "<dev string:x1b7f>" );
            enes[ enes.size ] = ene;
        }
        
        wait 2;
        
        for ( i = 0; i < count ; i++ )
        {
            enes[ i ] agent_utils::despawnagent();
        }
    }

    // Namespace ztron_ui
    // Params 1, eflags: 0x4
    // Checksum 0x3a32837a, Offset: 0x61cf
    // Size: 0x64, Type: dev
    function private function_c00284148fd3d9db( tokens )
    {
        if ( tokens.size > 0 )
        {
            refreshflag = tokens[ 0 ];
        }
        
        shouldrefresh = refreshflag == "<dev string:x1b96>";
        me = level.players[ 0 ];
        me ztron_dialog::function_927bb94feca983e8( #"crab_greeting", 0, 1, shouldrefresh );
    }

    // Namespace ztron_ui
    // Params 1, eflags: 0x4
    // Checksum 0xef98f3f, Offset: 0x623b
    // Size: 0x82, Type: dev
    function private function_dfe2b1c0f09791c3( tokens )
    {
        if ( level.players.size < 2 )
        {
            bots::spawn_bots( 1, "<dev string:x1b98>" );
        }
        
        wait 3;
        
        for ( i = 0; i < 5 ; i++ )
        {
            level.players[ 0 ] ztron_dialog::function_927bb94feca983e8( #"crab_greeting" );
            level.players[ 1 ] ztron_dialog::function_927bb94feca983e8( #"bubble_message_papaback" );
        }
    }

    // Namespace ztron_ui
    // Params 1, eflags: 0x4
    // Checksum 0x78d83b4c, Offset: 0x62c5
    // Size: 0xe7, Type: dev
    function private function_ae493d204fcdf4c4( tokens )
    {
        if ( level.players.size < 4 )
        {
            fill = 4 - level.players.size;
            bots::spawn_bots( fill, "<dev string:x1b98>" );
        }
        
        wait 2;
        level.players[ 0 ] ztron_dialog::function_7e3f6329d9afcdc1( "<dev string:x1b73>" );
        level.players[ 0 ] ztron_dialog::function_7e3f6329d9afcdc1( "<dev string:x1b9f>" );
        level.players[ 1 ] ztron_dialog::function_7e3f6329d9afcdc1( "<dev string:x1bb7>" );
        level.players[ 1 ] ztron_dialog::function_7e3f6329d9afcdc1( "<dev string:x1bcc>" );
        level.players[ 2 ] ztron_dialog::function_7e3f6329d9afcdc1( "<dev string:x1be1>" );
        level.players[ 3 ] ztron_dialog::function_7e3f6329d9afcdc1( "<dev string:x1bf7>" );
        wait 1;
        level utility::flag_set( "<dev string:x1c0d>" );
    }

    // Namespace ztron_ui
    // Params 1, eflags: 0x4
    // Checksum 0x4ef20b92, Offset: 0x63b4
    // Size: 0x8c, Type: dev
    function private function_dbc3f330ea352070( tokens )
    {
        me = level.players[ 0 ];
        me ztron_dialog::function_927bb94feca983e8( #"player_last_stand_group", 1 );
        me ztron_dialog::function_927bb94feca983e8( #"player_last_stand_group", 1 );
        me ztron_dialog::function_927bb94feca983e8( #"player_last_stand_group", 1 );
        waitframe();
        me ztron_dialog::function_927bb94feca983e8( #"player_last_stand_group", 1 );
        waitframe();
        me ztron_dialog::function_927bb94feca983e8( #"player_last_stand_group", 1 );
    }

    // Namespace ztron_ui
    // Params 1, eflags: 0x4
    // Checksum 0x2a981f96, Offset: 0x6448
    // Size: 0x12e, Type: dev
    function private function_de6849bfb8dc4cc4( tokens )
    {
        if ( level.players.size < 4 )
        {
            bots::spawn_bots( 3, "<dev string:x1b98>" );
        }
        
        wait 3;
        
        foreach ( p in level.players )
        {
            p ztron_dialog::function_7e3f6329d9afcdc1( "<dev string:x1b7f>" );
        }
        
        wait 1;
        
        foreach ( p in level.players )
        {
            if ( isbot( p ) )
            {
                kick( p getentitynumber() );
                break;
            }
        }
    }

    // Namespace ztron_ui
    // Params 1, eflags: 0x4
    // Checksum 0x657146a6, Offset: 0x657e
    // Size: 0xd7, Type: dev
    function private function_589e2d493be60784( tokens )
    {
        if ( tokens.size != 2 )
        {
            iprintln( "<dev string:x1c24>" );
            return;
        }
        
        var_2f2e8cf6f666d618 = int( tokens[ 0 ] );
        var_14d75b25f833a4ab = int( tokens[ 1 ] ) == 1;
        
        foreach ( player in level.players )
        {
            if ( player.sessionuimemberindex == var_2f2e8cf6f666d618 )
            {
                player function_3cd1e7679d332da7( var_14d75b25f833a4ab );
                break;
            }
        }
    }

    // Namespace ztron_ui
    // Params 1, eflags: 0x4
    // Checksum 0x409ff37d, Offset: 0x665d
    // Size: 0x104, Type: dev
    function private function_13877050d4d89143( tokens )
    {
        if ( tokens.size != 1 )
        {
            iprintln( "<dev string:x1cbf>" );
            return;
        }
        
        var_2f2e8cf6f666d618 = int( tokens[ 0 ] );
        
        foreach ( player in level.players )
        {
            if ( player.sessionuimemberindex == var_2f2e8cf6f666d618 )
            {
                player.ztron.var_4095e0b1332ea87 = 1;
                player.ztron.var_6fe8ea86c8758aec = player.ztron.var_4095e0b1332ea87;
                player function_38a72e402dc87ace();
                break;
            }
        }
    }

    // Namespace ztron_ui
    // Params 1, eflags: 0x4
    // Checksum 0x8898e285, Offset: 0x6769
    // Size: 0xd7, Type: dev
    function private function_2bc20c75d490a150( tokens )
    {
        if ( tokens.size != 1 )
        {
            iprintln( "<dev string:x1cbf>" );
            return;
        }
        
        var_2f2e8cf6f666d618 = int( tokens[ 0 ] );
        
        foreach ( player in level.players )
        {
            if ( player.sessionuimemberindex == var_2f2e8cf6f666d618 )
            {
                player.ztron.var_6fe8ea86c8758aec++;
                player function_38a72e402dc87ace();
                break;
            }
        }
    }

    // Namespace ztron_ui
    // Params 1, eflags: 0x4
    // Checksum 0xc25933a3, Offset: 0x6848
    // Size: 0xf1, Type: dev
    function private function_7e47e166bcd30595( tokens )
    {
        if ( tokens.size != 1 )
        {
            iprintln( "<dev string:x1cbf>" );
            return;
        }
        
        var_2f2e8cf6f666d618 = int( tokens[ 0 ] );
        
        foreach ( player in level.players )
        {
            if ( player.sessionuimemberindex == var_2f2e8cf6f666d618 )
            {
                if ( player.ztron.var_6fe8ea86c8758aec > 0 )
                {
                    player.ztron.var_6fe8ea86c8758aec--;
                    player function_38a72e402dc87ace();
                }
                
                break;
            }
        }
    }

    // Namespace ztron_ui
    // Params 1, eflags: 0x4
    // Checksum 0x5332910d, Offset: 0x6941
    // Size: 0x3eb, Type: dev
    function private function_90471b772a5d209a( tokens )
    {
        progress = int( tokens[ 0 ] );
        
        if ( level.players.size < 4 )
        {
            bots::spawn_bots( 4 - level.players.size, "<dev string:x1b98>" );
        }
        
        wait 2;
        
        if ( progress >= 1 )
        {
            foreach ( index, p in level.players )
            {
                p._ztron_test = spawnstruct();
                
                if ( index <= 2 )
                {
                    p.ztron.var_4095e0b1332ea87 = 1;
                    p.ztron.var_6fe8ea86c8758aec = p.ztron.var_4095e0b1332ea87;
                    p function_38a72e402dc87ace();
                    p._ztron_test.var_2168c9d5c00d7917 = index == 2;
                    p._ztron_test.var_52409666fc5dbe6c = index == 1;
                }
            }
        }
        
        wait 2;
        
        if ( progress >= 2 )
        {
            foreach ( p in level.players )
            {
                if ( p.ztron.var_4095e0b1332ea87 && !p._ztron_test.var_2168c9d5c00d7917 )
                {
                    p.ztron.var_6fe8ea86c8758aec++;
                    p function_38a72e402dc87ace();
                }
            }
        }
        
        wait 2;
        
        if ( progress >= 3 )
        {
            foreach ( p in level.players )
            {
                if ( p.ztron.var_4095e0b1332ea87 && !p._ztron_test.var_52409666fc5dbe6c )
                {
                    if ( p.ztron.var_6fe8ea86c8758aec > 0 )
                    {
                        p.ztron.var_6fe8ea86c8758aec--;
                        p function_38a72e402dc87ace();
                    }
                }
            }
        }
        
        wait 2;
        
        if ( progress >= 4 )
        {
            foreach ( p in level.players )
            {
                p function_3cd1e7679d332da7( 1 );
            }
            
            wait 2;
            
            foreach ( p in level.players )
            {
                p function_3cd1e7679d332da7( 0 );
            }
        }
    }

    // Namespace ztron_ui
    // Params 1, eflags: 0x4
    // Checksum 0x9e00edf0, Offset: 0x6d34
    // Size: 0xd7, Type: dev
    function private function_6066b12431f616e3( tokens )
    {
        if ( tokens.size != 2 )
        {
            iprintln( "<dev string:x1d20>" );
            return;
        }
        
        var_2f2e8cf6f666d618 = int( tokens[ 0 ] );
        shouldshow = int( tokens[ 1 ] ) == 1;
        
        foreach ( player in level.players )
        {
            if ( player.sessionuimemberindex == var_2f2e8cf6f666d618 )
            {
                player function_f7e6c4641e827bf8( shouldshow );
                break;
            }
        }
    }

    // Namespace ztron_ui
    // Params 1, eflags: 0x4
    // Checksum 0x59b836f4, Offset: 0x6e13
    // Size: 0xd4, Type: dev
    function private function_a4292c6b8749e1e9( tokens )
    {
        if ( tokens.size != 2 )
        {
            iprintln( "<dev string:x1da6>" );
            return;
        }
        
        var_2f2e8cf6f666d618 = int( tokens[ 0 ] );
        plundervalue = int( tokens[ 1 ] );
        
        foreach ( player in level.players )
        {
            if ( player.sessionuimemberindex == var_2f2e8cf6f666d618 )
            {
                player ztron_player_utility::function_8e1155bcebb3b7b3( plundervalue );
                break;
            }
        }
    }

    // Namespace ztron_ui
    // Params 1, eflags: 0x4
    // Checksum 0xcb4720c5, Offset: 0x6eef
    // Size: 0xe1, Type: dev
    function private function_64a738ae2941bdc9( tokens )
    {
        if ( tokens.size != 1 )
        {
            iprintln( "<dev string:x1e1a>" );
            return;
        }
        
        indexfrom = int( tokens[ 0 ] );
        actiontype = indexfrom == 0 ? 0 : 1;
        
        foreach ( player in level.players )
        {
            for ( i = 0; i < 4 ; i++ )
            {
                player thread function_ecddb0816040db5c( i, actiontype, indexfrom );
            }
        }
    }

    // Namespace ztron_ui
    // Params 1, eflags: 0x4
    // Checksum 0xb6ed4251, Offset: 0x6fd8
    // Size: 0x82, Type: dev
    function private function_e09be485c4451c68( tokens )
    {
        if ( tokens.size != 2 )
        {
            iprintln( "<dev string:x1ea2>" );
            return;
        }
        
        indexfrom = int( tokens[ 0 ] );
        var_9875a4a4c841bb48 = int( tokens[ 1 ] );
        shouldshow = indexfrom == 1 ? 1 : 0;
        
        if ( shouldshow )
        {
            showoverworld();
            setomnvar( "<dev string:x1f10>", var_9875a4a4c841bb48 );
            return;
        }
        
        hideoverworld();
    }

    // Namespace ztron_ui
    // Params 1, eflags: 0x4
    // Checksum 0x8c0afeba, Offset: 0x7062
    // Size: 0x4c, Type: dev
    function private function_933d72bddeaa6392( tokens )
    {
        if ( tokens.size != 1 )
        {
            iprintln( "<dev string:x1f26>" );
            return;
        }
        
        duration = int( tokens[ 0 ] );
        function_e871c2190f0db007( "<dev string:x1f84>" );
        wait duration;
        function_bddb5fe817c432f1();
    }

    // Namespace ztron_ui
    // Params 1, eflags: 0x4
    // Checksum 0x4bfd4e81, Offset: 0x70b6
    // Size: 0xdc, Type: dev
    function private function_2bea788d87639d5e( tokens )
    {
        if ( tokens.size != 2 )
        {
            iprintln( "<dev string:x1fa5>" );
            return;
        }
        
        index = int( tokens[ 0 ] );
        duration = int( tokens[ 1 ] );
        shouldshow = index > 0 ? 1 : 0;
        
        foreach ( player in level.players )
        {
            player function_8243fa1809b7d3e3( shouldshow, index, duration, 1 );
        }
    }

    // Namespace ztron_ui
    // Params 1, eflags: 0x4
    // Checksum 0x841b0eef, Offset: 0x719a
    // Size: 0x160, Type: dev
    function private function_df6f550bc728414f( tokens )
    {
        if ( tokens.size != 2 )
        {
            iprintln( "<dev string:x2016>" );
            return;
        }
        
        indexfrom = int( tokens[ 0 ] );
        var_eca526b720756ee7 = tokens[ 1 ];
        shouldshow = indexfrom == 1 ? 1 : 0;
        hideoverworld();
        
        if ( shouldshow )
        {
            setdvar( @"hash_5f1035b22c47683c", 1 );
            waitframe();
            var_78ea4c5a1a749c94 = strtok( var_eca526b720756ee7, "<dev string:x20aa>" );
            arenalist = [];
            
            foreach ( arenastr in var_78ea4c5a1a749c94 )
            {
                arenalist[ arenalist.size ] = clamp( int( arenastr ), 0, 4 );
            }
            
            level.ztron.var_a58d52a0faa75a57 = arenalist;
            showoverworld();
            thread function_464c14312837a513();
            return;
        }
        
        if ( !level.ztron.var_371903e5801e0e08 )
        {
            setdvar( @"hash_5f1035b22c47683c", 0 );
        }
    }

#/
