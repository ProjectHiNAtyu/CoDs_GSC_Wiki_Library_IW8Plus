// script_509ee20a8f307e83  (hash_509ee20a8f307e83.gscc) (size: 5491 Bytes / 0x1573 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xec0d6245 (3960300101)
// size ...... 5491 (0x1573)
// includes .. 9   (offset: 0x14e3)
// strings ... 5   (offset: 0x152b)
// dev strs .. 0   (offset: 0x1573)
// exports ... 20  (offset: 0xb87)
// cseg ...... 0xa0 + 0xae7 (0xb87)
// imports ... 50  (offset: 0xea7)
// animtree1 . 0   (offset: 0x1573)
// animtree2 . 0   (offset: 0x1573)
#using script_19aec99df234f03a;
#using scripts\common\callbacks;
#using scripts\common\gameplay_sound_fx;
#using scripts\common\math;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\common\utility\points;
#using scripts\mp\gametypes\multi_mode;
#using scripts\mp\weapons;

#namespace multi_mode_heavy_metal;

// Namespace multi_mode_heavy_metal
// Params 0
// Checksum 0xfa6906d7, Offset: 0xbe
// Size: 0x10
function main()
{
    multi_mode::main();
    register_shared_funcs();
}

// Namespace multi_mode_heavy_metal
// Params 0
// Checksum 0xad6854ca, Offset: 0xd6
// Size: 0x1ab
function register_shared_funcs()
{
    if ( !isdefined( level.sharedfuncs[ #"multimode" ][ #"onplayerkilled" ] ) )
    {
        utility::registersharedfunc( #"multimode", #"onplayerkilled", &on_player_killed );
    }
    
    if ( !isdefined( level.sharedfuncs[ #"multimode" ][ #"hash_61e0fbf08357154b" ] ) )
    {
        utility::registersharedfunc( #"multimode", #"hash_61e0fbf08357154b", &function_b1b1d87a7f4feb06 );
    }
    
    if ( !isdefined( level.sharedfuncs[ #"multimode" ][ #"hash_b5e2501f9409e185" ] ) )
    {
        utility::registersharedfunc( #"multimode", #"hash_b5e2501f9409e185", &function_d07c289bb0c6eb18 );
    }
    
    if ( !isdefined( level.sharedfuncs[ #"multimode" ][ #"hash_e8742aff4abdfd2e" ] ) )
    {
        utility::registersharedfunc( #"multimode", #"hash_e8742aff4abdfd2e", &function_2ed28341b47e118f );
    }
    
    if ( !isdefined( level.sharedfuncs[ #"multimode" ][ #"hash_592eb0a88aedc4a" ] ) )
    {
        utility::registersharedfunc( #"multimode", #"hash_592eb0a88aedc4a", &function_50264883c66d6104 );
    }
    
    callback::add( #"player_spawned", &on_player_spawned );
    callback::add( #"elimination_assist", &function_334bbf00fa1fdf31 );
    callback::add( #"dtp_begin", &on_dtp_begin );
    callback::add( #"sprint_slide_begin", &on_sprint_slide_begin );
    callback::add( #"sprint_slide_end", &on_sprint_slide_end );
}

// Namespace multi_mode_heavy_metal
// Params 2
// Checksum 0xc707cb61, Offset: 0x289
// Size: 0xfc
function encore_add( amount = 0, var_f67d3cf06e989539 )
{
    prevtier = namespace_69e3a436b5d8370e::function_c6facc0238baaa44();
    var_82693f585d2dbfff = namespace_69e3a436b5d8370e::function_8af42f15cd41334c() + amount;
    var_82693f585d2dbfff = math::round_float( var_82693f585d2dbfff, 3 );
    var_82693f585d2dbfff = clamp( var_82693f585d2dbfff, 0, level.var_93532ab90ccea78c.var_96297da92d9f0644 );
    namespace_69e3a436b5d8370e::function_5f06be4b62682c68( var_82693f585d2dbfff, var_f67d3cf06e989539 );
    currtier = namespace_69e3a436b5d8370e::function_c6facc0238baaa44();
    
    if ( int( var_82693f585d2dbfff ) > self.var_2c67a55da9b5aecd )
    {
        self setclientomnvar( o"ui_bonus_points", int( var_82693f585d2dbfff ) );
        self.var_2c67a55da9b5aecd = int( var_82693f585d2dbfff );
    }
    
    if ( currtier >= 0 && prevtier != currtier )
    {
        function_e45b9d662670222c( prevtier, currtier );
    }
    
    if ( amount > 0 )
    {
        thread points::doscoreevent( level.var_93532ab90ccea78c.var_820fc8428fd5e8ec );
        function_d19832dca2891fad();
    }
}

// Namespace multi_mode_heavy_metal
// Params 0
// Checksum 0xa58f3935, Offset: 0x38d
// Size: 0x14e
function function_8f01c5d9a81b606b()
{
    self notify( #"hash_74fb521e5df61684" );
    self endon( #"hash_74fb521e5df61684" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    decay_interval = 1;
    omnvar_update_interval = 0.1;
    decayelapsed = 0;
    var_f7b0c50e02bf2e64 = namespace_69e3a436b5d8370e::function_8af42f15cd41334c();
    var_91093ab59d2d7c08 = level.var_93532ab90ccea78c.var_f12e07dfbc6a71c6;
    
    while ( self.awardtierpoints > 0 )
    {
        wait omnvar_update_interval;
        decayelapsed += omnvar_update_interval;
        var_20a4a550e912e157 = namespace_69e3a436b5d8370e::function_8af42f15cd41334c();
        
        if ( var_20a4a550e912e157 != var_f7b0c50e02bf2e64 )
        {
            decayelapsed = 0;
            var_f7b0c50e02bf2e64 = var_20a4a550e912e157;
        }
        
        var_67f1d70560202dd8 = var_20a4a550e912e157 - var_91093ab59d2d7c08 * decayelapsed;
        var_67f1d70560202dd8 = clamp( var_67f1d70560202dd8, 0, level.var_93532ab90ccea78c.var_96297da92d9f0644 );
        progress = var_91093ab59d2d7c08 > 0 ? function_cb39cc8f1e0cab94( var_67f1d70560202dd8 ) : 0;
        self setclientomnvar( o"ui_cranked_timer_time", progress );
        
        if ( decayelapsed >= decay_interval )
        {
            decayelapsed = 0;
            encore_add( var_91093ab59d2d7c08 * -1, 1 );
            var_f7b0c50e02bf2e64 = namespace_69e3a436b5d8370e::function_8af42f15cd41334c();
        }
    }
    
    if ( self.awardtierpoints <= 0 )
    {
        function_97532387c594d62e();
    }
}

// Namespace multi_mode_heavy_metal
// Params 2
// Checksum 0xe5a22a3d, Offset: 0x4e3
// Size: 0xae
function function_e45b9d662670222c( prevstage, newstage )
{
    if ( prevstage == -1 )
    {
        gameplay_sound_fx::playlocalsoundfx( #"hash_c3c6400fae7b612" );
        self setscriptablepartstate( "heavy_metal_encore_fx", "on", 1 );
        thread function_8f01c5d9a81b606b();
    }
    else if ( newstage > prevstage )
    {
        gameplay_sound_fx::playlocalsoundfx( #"hash_723c56df799b5ca8" );
    }
    
    self setclientomnvar( o"ui_hide_bonus_widget", newstage < 0 );
    
    if ( newstage == 0 )
    {
        self.var_72922a0ed9e99c02 = 1;
        self.var_5978ec20993ddc51 = 1;
        return;
    }
    
    if ( prevstage == 0 )
    {
        self.var_72922a0ed9e99c02 = undefined;
        self.var_5978ec20993ddc51 = undefined;
    }
}

// Namespace multi_mode_heavy_metal
// Params 0
// Checksum 0xd60ac37, Offset: 0x599
// Size: 0x3d
function function_e2c54f4788810c5f()
{
    self.var_2c67a55da9b5aecd = 0;
    self setclientomnvar( o"ui_cranked_timer_time", 0 );
    self setclientomnvar( o"ui_hide_bonus_widget", 1 );
    self setclientomnvar( o"ui_bonus_points", 0 );
}

// Namespace multi_mode_heavy_metal
// Params 0
// Checksum 0x3ac006e5, Offset: 0x5de
// Size: 0x51
function function_97532387c594d62e()
{
    if ( namespace_69e3a436b5d8370e::function_c6facc0238baaa44() >= 0 )
    {
        gameplay_sound_fx::playlocalsoundfx( #"encore_reset" );
        self setscriptablepartstate( "heavy_metal_encore_fx", "off", 1 );
    }
    
    function_e2c54f4788810c5f();
    self.var_72922a0ed9e99c02 = undefined;
    self.var_5978ec20993ddc51 = undefined;
    namespace_69e3a436b5d8370e::function_5a505b4c7944bceb();
}

// Namespace multi_mode_heavy_metal
// Params 1
// Checksum 0xcdc604, Offset: 0x637
// Size: 0x42
function function_cb39cc8f1e0cab94( score )
{
    if ( level.var_93532ab90ccea78c.var_f12e07dfbc6a71c6 )
    {
        return int( score / level.var_93532ab90ccea78c.var_f12e07dfbc6a71c6 * 1000 );
    }
    
    return 0;
}

// Namespace multi_mode_heavy_metal
// Params 1
// Checksum 0x83621187, Offset: 0x682
// Size: 0x5a
function on_player_spawned( params )
{
    var_182ca81d1df1f781 = function_cb39cc8f1e0cab94( level.var_93532ab90ccea78c.var_96297da92d9f0644 );
    self setclientomnvar( o"ui_cranked_timer_time_max", var_182ca81d1df1f781 );
    function_e2c54f4788810c5f();
    self setclientomnvar( o"ui_cranked_meter_is_shown", 1 );
}

// Namespace multi_mode_heavy_metal
// Params 1
// Checksum 0xd825ca8d, Offset: 0x6e4
// Size: 0x67
function on_dtp_begin( params )
{
    if ( self.var_5978ec20993ddc51 )
    {
        velocity = self getvelocity();
        velocity = ( velocity[ 0 ] * level.var_93532ab90ccea78c.var_a03394a9fdcbb0a9, velocity[ 1 ] * level.var_93532ab90ccea78c.var_a03394a9fdcbb0a9, velocity[ 2 ] );
        self setvelocity( velocity );
    }
}

// Namespace multi_mode_heavy_metal
// Params 1
// Checksum 0x192dc7c3, Offset: 0x753
// Size: 0x45
function on_sprint_slide_begin( params )
{
    if ( self.var_72922a0ed9e99c02 )
    {
        weapons::addextramovespeed( "encore_slide_faster", float( level.var_93532ab90ccea78c.var_27777c3248414ff8 ) - 1 );
        weapons::updatemovespeedscale();
    }
}

// Namespace multi_mode_heavy_metal
// Params 1
// Checksum 0x2e30b370, Offset: 0x7a0
// Size: 0x2d
function on_sprint_slide_end( params )
{
    if ( weapons::function_67041fa03f87323c( "encore_slide_faster" ) )
    {
        weapons::removeextramovespeed( "encore_slide_faster" );
        weapons::updatemovespeedscale();
    }
}

// Namespace multi_mode_heavy_metal
// Params 1
// Checksum 0xc830b886, Offset: 0x7d5
// Size: 0x154
function on_player_killed( deathdata )
{
    iskillstreakweapon = weapon::iskillstreakweapon( deathdata.objweapon );
    var_1344ad15d2d7bd21 = weapon::function_1344ad15d2d7bd21( deathdata.objweapon );
    var_72c1480c4ea11404 = !iskillstreakweapon || var_1344ad15d2d7bd21;
    
    if ( isplayer( deathdata.attacker ) && deathdata.attacker != deathdata.victim && var_72c1480c4ea11404 )
    {
        if ( multi_mode::is_tdm_active() || multi_mode::is_piggy_bank_active() )
        {
            deathdata.attacker encore_add( level.var_93532ab90ccea78c.var_b270d2ab64029868 );
        }
        else
        {
            deathdata.attacker encore_add( level.var_93532ab90ccea78c.var_ea22addb173e6a3b );
        }
        
        if ( deathdata.attacker namespace_69e3a436b5d8370e::function_c6facc0238baaa44() >= 0 )
        {
            deathdata.attacker gameplay_sound_fx::playlocalsoundfx( #"encore_kill_bonus" );
        }
    }
    
    if ( isplayer( deathdata.victim ) )
    {
        deathdata.victim namespace_69e3a436b5d8370e::function_5f06be4b62682c68( 0, 1 );
        deathdata.victim function_97532387c594d62e();
    }
}

// Namespace multi_mode_heavy_metal
// Params 1
// Checksum 0xfa0e6f3f, Offset: 0x931
// Size: 0x56
function function_334bbf00fa1fdf31( params )
{
    if ( multi_mode::is_tdm_active() || multi_mode::is_piggy_bank_active() )
    {
        encore_add( level.var_93532ab90ccea78c.var_5dff73862220ffa7 );
        return;
    }
    
    encore_add( level.var_93532ab90ccea78c.var_f28c582197551998 );
}

// Namespace multi_mode_heavy_metal
// Params 1
// Checksum 0x327914d8, Offset: 0x98f
// Size: 0x31
function function_b1b1d87a7f4feb06( player )
{
    if ( isplayer( player ) )
    {
        player encore_add( level.var_93532ab90ccea78c.var_ece9e0fdf8536c1c );
    }
}

// Namespace multi_mode_heavy_metal
// Params 1
// Checksum 0x96c181be, Offset: 0x9c8
// Size: 0x31
function function_d07c289bb0c6eb18( player )
{
    if ( isplayer( player ) )
    {
        player encore_add( level.var_93532ab90ccea78c.var_b197885583d80bc3 );
    }
}

// Namespace multi_mode_heavy_metal
// Params 0
// Checksum 0xde475039, Offset: 0xa01
// Size: 0x1c
function function_2ed28341b47e118f()
{
    encore_add( level.var_93532ab90ccea78c.var_b612d51033b66277 );
}

// Namespace multi_mode_heavy_metal
// Params 6
// Checksum 0x93727781, Offset: 0xa25
// Size: 0x8f
function function_50264883c66d6104( objectivetype, label, credit_player, team, oldteam, flagobj )
{
    if ( isplayer( credit_player ) )
    {
        if ( oldteam == "neutral" )
        {
            credit_player encore_add( level.var_93532ab90ccea78c.var_bfd44306e2feaaf4 );
            return;
        }
        
        if ( oldteam != team )
        {
            credit_player encore_add( level.var_93532ab90ccea78c.var_cc93b5cf4cd8edb9 );
        }
    }
}

// Namespace multi_mode_heavy_metal
// Params 0
// Checksum 0x4e1daee1, Offset: 0xabc
// Size: 0xcb
function function_d19832dca2891fad()
{
    if ( self.awardtierpoints <= 1 )
    {
        gameplay_sound_fx::playlocalsoundfx( #"hash_b00a046aaef0a16" );
        return;
    }
    
    if ( self.awardtierpoints <= 2 )
    {
        gameplay_sound_fx::playlocalsoundfx( #"hash_b009f46aaef0863" );
        return;
    }
    
    if ( self.awardtierpoints <= 3 )
    {
        gameplay_sound_fx::playlocalsoundfx( #"hash_b009e46aaef06b0" );
        return;
    }
    
    if ( self.awardtierpoints <= 4 )
    {
        gameplay_sound_fx::playlocalsoundfx( #"hash_b00a546aaef1295" );
        return;
    }
    
    if ( self.awardtierpoints <= 5 )
    {
        gameplay_sound_fx::playlocalsoundfx( #"hash_b00a446aaef10e2" );
        return;
    }
    
    if ( self.awardtierpoints <= 6 )
    {
        gameplay_sound_fx::playlocalsoundfx( #"hash_b00a346aaef0f2f" );
    }
}

