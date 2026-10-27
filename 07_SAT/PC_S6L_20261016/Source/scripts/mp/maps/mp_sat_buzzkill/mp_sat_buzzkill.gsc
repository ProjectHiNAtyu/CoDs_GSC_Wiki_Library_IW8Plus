// scripts\mp\maps\mp_sat_buzzkill\mp_sat_buzzkill.gsc  (hash_06337aff742bf5f1.gscc) (size: 11433 Bytes / 0x2ca9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x31478902 (826771714)
// size ...... 11433 (0x2ca9)
// includes .. 18  (offset: 0x28d9)
// strings ... 60  (offset: 0x2969)
// dev strs .. 0   (offset: 0x2ca9)
// exports ... 24  (offset: 0x1c09)
// cseg ...... 0x43d + 0x17cc (0x1c09)
// imports ... 72  (offset: 0x1fc9)
// animtree1 . 0   (offset: 0x2ca9)
// animtree2 . 0   (offset: 0x2ca9)
#using script_16ea1b94f0f381b3;
#using scripts\common\active_env\moving_platforms;
#using scripts\common\active_env\utility;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\compass;
#using scripts\mp\flags;
#using scripts\mp\gametypes\prop_controls;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_buzzkill\gen\mp_sat_buzzkill_art;
#using scripts\mp\maps\mp_sat_buzzkill\mp_sat_buzzkill_fx;
#using scripts\mp\maps\mp_sat_buzzkill\mp_sat_buzzkill_lighting;

#namespace mp_sat_buzzkill;

// Namespace mp_sat_buzzkill
// Params 0
// Checksum 0x6f559b2c, Offset: 0x45b
// Size: 0x1cd
function main()
{
    mp_sat_buzzkill_art::main();
    namespace_2f485fb62333f5d3::main();
    namespace_995de1ea47707c89::main();
    load::main();
    level.kill_border_triggers = getentarray( "kill_border_trigger", #targetname );
    level.outofboundstriggers = getentarray( "OutOfBounds", "targetname" );
    level.var_750dbf45607817fd = getentarray( "Drone_OutOfBounds", #targetname );
    level.var_f11fa8013d4e241c = getentarray( "VTOL_OutOfBounds", #targetname );
    compass::setupminimap( "compass_map_mp_sat_buzzkill" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    level.var_bcfa839657b31dfe = [];
    level thread moving_platforms::moving_platforms_init();
    level thread function_9fdc8d8f8a95d570();
    function_7924b68dde9343f9();
    function_5d8adbf183f32be4();
    function_23b127c0d41439f8();
    weaponfilter = [ #"remote_robot":1, #"sniper_drone":1 ];
    utility::setup_no_deploy_zones( weaponfilter );
    dialog::function_192bd33a73576aca( #"mission_success", #"dx_mp_buzz_msnscs_bkgh" );
    dialog::function_192bd33a73576aca( #"gamestate_win_comeback", #"dx_mp_buzz_msnscs_bkgh" );
    dialog::function_192bd33a73576aca( #"mission_failure", #"dx_mp_buzz_msnfl_bkgh" );
    
    /#
        namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"test_cannon", &force_projectile );
        namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"test_score", &function_6cb1c476d89323e5 );
        namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"test_miss", &force_fail );
        namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"test_vo", &function_943ef516bbc99370 );
    #/
    
    level thread domination_fix();
}

// Namespace mp_sat_buzzkill
// Params 0
// Checksum 0x3fe5dcf8, Offset: 0x630
// Size: 0x2b1
function domination_fix()
{
    level endon( #"game_ended" );
    
    if ( getxhash( game_utility::getgametype() ) != #"dom" )
    {
        return;
    }
    
    primary_flags = getentarray( "flag_primary", #targetname );
    var_1474267b64df75c6 = ( -1637.63, -1002.28, 198.55 );
    var_dd7ff644151a17d9 = 311.8;
    var_2525e2fb298f098b = 347.198;
    var_645cd619c67c6da6 = 155;
    var_b0f181cbadabd999 = ( var_2525e2fb298f098b, var_dd7ff644151a17d9, var_645cd619c67c6da6 );
    var_441802bf3d3b941c = ( 1624.82, -1003.79, 171.996 );
    var_c87e0f21a0794d4f = 312;
    var_2ebb4e58147c0511 = 341.6;
    var_76ea3ac5124c8f60 = 98.9;
    var_34ab91ec4a23684f = ( var_2ebb4e58147c0511, var_c87e0f21a0794d4f, var_76ea3ac5124c8f60 );
    
    for ( i = 0; i < primary_flags.size ; i++ )
    {
        if ( primary_flags[ i ].target == "b" )
        {
            continue;
        }
        
        old_flag = primary_flags[ i ];
        
        if ( old_flag.target == "a" )
        {
            position = var_1474267b64df75c6;
            dimms = var_b0f181cbadabd999;
        }
        else if ( old_flag.target == "c" )
        {
            position = var_441802bf3d3b941c;
            dimms = var_34ab91ec4a23684f;
        }
        
        new_flag = spawn( "trigger_box", position, 0, dimms / 2, dimms / 2 );
        new_flag.target = old_flag.target;
        new_flag.script_label = old_flag.script_label;
        new_flag.script_noteworthy = old_flag.script_noteworthy;
        new_flag.targetname = old_flag.targetname;
        new_flag.script_gameobjectname = old_flag.script_gameobjectname;
        primary_flags[ i ] = new_flag;
        old_flag delete();
    }
    
    /#
        if ( getdvarint( @"hash_78c682fe0f4ae1c", 0 ) )
        {
            while ( true )
            {
                foreach ( flag in primary_flags )
                {
                    drawtrigger( flag, ( 1, 1, 1 ), 0, 1 );
                }
                
                waitframe();
            }
        }
    #/
}

// Namespace mp_sat_buzzkill
// Params 0
// Checksum 0x3b4a9efd, Offset: 0x8e9
// Size: 0x80
function function_59fcb0f4e9db35ec()
{
    if ( level.var_a5a819518c3899a2[ "_blue" ] > level.var_a5a819518c3899a2[ "_yellow" ] )
    {
        return "blue";
    }
    
    if ( level.var_a5a819518c3899a2[ "_blue" ] < level.var_a5a819518c3899a2[ "_yellow" ] )
    {
        return "yellow";
    }
    
    if ( level.var_a5a819518c3899a2[ "_blue" ] === level.var_a5a819518c3899a2[ "_yellow" ] )
    {
        return "draw";
    }
}

// Namespace mp_sat_buzzkill
// Params 1, eflags: 0x4
// Checksum 0x6af8c74b, Offset: 0x971
// Size: 0x14
function private function_943ef516bbc99370( params )
{
    function_8f3585bebcda99df( 0 );
}

// Namespace mp_sat_buzzkill
// Params 1, eflags: 0x4
// Checksum 0xd6f4ca40, Offset: 0x98d
// Size: 0x153
function private function_8f3585bebcda99df( var_6a6bed667cdea567 = 1 )
{
    level endon( #"exitlevel_called" );
    level.var_697ba496dd069d1b = 1;
    var_6b28baebe1ea964c = "dx_mp_buzz_msnscs_bkgh";
    var_c5f0c2976912867d = "dx_mp_buzz_msnfl_bkgh";
    
    if ( var_6a6bed667cdea567 )
    {
        level flags::function_2f3408423ccc9b2e( "potg_finalized" );
    }
    
    var_e5a8fad7b24e2a5e = "allies";
    n_allies_score = int( game[ "teamScores" ][ "allies" ] );
    n_axis_score = int( game[ "teamScores" ][ "axis" ] );
    
    if ( n_allies_score < n_axis_score )
    {
        var_e5a8fad7b24e2a5e = "axis";
    }
    
    if ( n_allies_score === n_axis_score )
    {
        var_e5a8fad7b24e2a5e = "";
    }
    
    foreach ( player in level.players )
    {
        if ( player.team === var_e5a8fad7b24e2a5e )
        {
            player playsoundtoplayer( var_6b28baebe1ea964c, player );
            continue;
        }
        
        player playsoundtoplayer( var_c5f0c2976912867d, player );
    }
}

// Namespace mp_sat_buzzkill
// Params 0, eflags: 0x4
// Checksum 0x70987b7c, Offset: 0xae8
// Size: 0x561
function private function_9fdc8d8f8a95d570()
{
    level endon( #"game_ended" );
    utility::flag_wait( "scriptables_ready" );
    utility::flag_wait( "moving_platforms_initialized" );
    var_76bd499cd531c9c4 = [ getent( "sushi_cannon_yellow", #targetname ), getent( "sushi_cannon_blue", #targetname ) ];
    
    foreach ( e_cannon in var_76bd499cd531c9c4 )
    {
        e_cannon.angles += ( 0, 90, 0 );
    }
    
    level.var_a5a819518c3899a2[ "_blue" ] = 0;
    level.var_a5a819518c3899a2[ "_yellow" ] = 0;
    
    if ( level.prematchperiodend > 0 && game_utility_mp::isfirstround() )
    {
        level waittill( #"match_start_real_countdown" );
    }
    
    activateworldevent( "we_vfx_yellow_cannon_start_confetti" );
    activateworldevent( "we_vfx_blue_cannon_start_confetti" );
    
    foreach ( e_cannon in var_76bd499cd531c9c4 )
    {
        moving_platforms::moving_platform_activate( e_cannon );
    }
    
    scriptable::scriptable_addusedcallbackbypart( "arcwire_transmitter", &control_panel_activate );
    scriptable::scriptable_addnotifycallback( "transmitter_damaged", &control_panel_activate );
    var_c4c19cd0e72fe598 = getentitylessscriptablearray( "button_cannon", #script_noteworthy );
    
    foreach ( scr_button in var_c4c19cd0e72fe598 )
    {
        scr_button.var_25c93cd85acadaae = utility::getstruct( scr_button.target, "targetname" );
        scr_button.var_25c93cd85acadaae.var_a9755989a52f335d = [ makeweapon( "sat_buzzkill_sushi_cannon_proj_mp" ), makeweapon( "sat_buzzkill_sushi_cannon_proj_mp_alt" ) ];
        scr_button.var_25c93cd85acadaae.var_eb22876971b935c1 = vectornormalize( anglestoforward( scr_button.var_25c93cd85acadaae.angles ) );
        scr_button.var_25c93cd85acadaae.n_strength = 1128;
        scr_button.var_25c93cd85acadaae.str_color = scr_button.var_25c93cd85acadaae.script_label;
        scr_button.e_target_mover = getent( "sushi_cannon" + scr_button.var_25c93cd85acadaae.str_color, #targetname );
        scr_button.scr_cannon = getscriptablearray( scr_button.e_target_mover.targetname, #script_noteworthy )[ 0 ];
        scr_button.scr_indicator = getentitylessscriptablearray( "control_panel_indicator" + scr_button.var_25c93cd85acadaae.str_color, #targetname )[ 0 ];
        
        if ( isdefined( scr_button.scr_indicator ) )
        {
            scr_button.scr_indicator setscriptablepartstate( "light_part", "on" );
        }
        
        scr_button.light_indicator = getent( "control_panel_indicator" + scr_button.var_25c93cd85acadaae.str_color + "_light", #targetname );
        
        if ( isdefined( scr_button.light_indicator ) )
        {
            scr_button.light_indicator setlightcolor( ( 0, 1, 0 ) );
        }
        
        scr_button thread control_panel_logic();
    }
    
    level.a_t_damage = getentarray( "hit_success", #script_noteworthy );
    
    foreach ( var_e49e01b230f55732 in level.a_t_damage )
    {
        var_e49e01b230f55732.a_e_indicators = getentitylessscriptablearray( var_e49e01b230f55732.target, #targetname );
        var_e49e01b230f55732.var_29ebcbb64912d85b = getentarray( var_e49e01b230f55732.target, #script_noteworthy );
        var_e49e01b230f55732.var_d0760f1fb3ab2a78 = 0;
        var_e49e01b230f55732.str_color = var_e49e01b230f55732.script_label;
        function_977111ebbf220cc8( var_e49e01b230f55732.var_29ebcbb64912d85b, var_e49e01b230f55732.var_d0760f1fb3ab2a78 );
    }
}

// Namespace mp_sat_buzzkill
// Params 0, eflags: 0x4
// Checksum 0xedf5d1e7, Offset: 0x1051
// Size: 0xc4
function private control_panel_logic()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"button_used", e_user );
        self setscriptablepartstate( "arcwire_transmitter", "activate" );
        self.scr_indicator setscriptablepartstate( "light_part", "off" );
        self.light_indicator setlightcolor( ( 1, 0, 0 ) );
        function_37b5cb9183e9202e( e_user );
        wait 4.5;
        self setscriptablepartstate( "arcwire_transmitter", "standby" );
        self.scr_indicator setscriptablepartstate( "light_part", "on" );
        self.light_indicator setlightcolor( ( 0, 1, 0 ) );
    }
}

// Namespace mp_sat_buzzkill
// Params 1, eflags: 0x4
// Checksum 0xca9af991, Offset: 0x111d
// Size: 0x1bb
function private function_37b5cb9183e9202e( e_user )
{
    var_80e3be05f03b15fa = self.var_25c93cd85acadaae.var_a9755989a52f335d[ randomint( self.var_25c93cd85acadaae.var_a9755989a52f335d.size ) ];
    n_fire_strength = self.var_25c93cd85acadaae.n_strength + randomfloatrange( -5, 5 );
    var_bde0d8d1b1b3aa61 = self.var_25c93cd85acadaae.var_eb22876971b935c1 * n_fire_strength;
    var_ce4c6073960103d3 = var_bde0d8d1b1b3aa61 + ( randomfloatrange( ( 1, 55, 5 )[ 0 ] * -1, ( 1, 55, 5 )[ 0 ] ), randomfloatrange( ( 1, 55, 5 )[ 1 ] * -1, ( 1, 55, 5 )[ 1 ] ), randomfloatrange( ( 1, 55, 5 )[ 2 ] * -1, ( 1, 55, 5 )[ 2 ] ) );
    var_81b7fe228d26667b = e_user weapon::_launchgrenade( var_80e3be05f03b15fa, self.var_25c93cd85acadaae.origin, var_ce4c6073960103d3 );
    var_81b7fe228d26667b.str_color = self.var_25c93cd85acadaae.str_color;
    var_81b7fe228d26667b.var_cdcc399e777de17 = e_user;
    var_81b7fe228d26667b.var_be6e8f5c5d18acc = 1;
    self.scr_cannon setscriptablepartstate( "cannon_fire", "fire" );
    level thread function_605b4035a990a58e( "we_vfx_cannon_fire" + self.var_25c93cd85acadaae.str_color, 1 );
    var_81b7fe228d26667b thread function_d667e7acc04a5669();
    var_81b7fe228d26667b thread function_197a38ae388a47ee();
}

// Namespace mp_sat_buzzkill
// Params 6, eflags: 0x4
// Checksum 0x6920202b, Offset: 0x12e0
// Size: 0x5c
function private control_panel_activate( e_instance, str_part, str_state, e_player, b_auto_use, str_use_string )
{
    if ( e_instance.script_noteworthy == "button_cannon" )
    {
        e_instance notify( #"button_used", e_player );
    }
}

// Namespace mp_sat_buzzkill
// Params 0, eflags: 0x4
// Checksum 0x3364e09a, Offset: 0x1344
// Size: 0x1a0
function private function_d667e7acc04a5669()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        foreach ( var_e49e01b230f55732 in level.a_t_damage )
        {
            if ( self istouching( var_e49e01b230f55732 ) )
            {
                self.b_in_mouth = 1;
                
                foreach ( var_35d81bdf3ea4c7b in var_e49e01b230f55732.a_e_indicators )
                {
                    var_35d81bdf3ea4c7b setscriptablepartstate( "feedback", "hit_success" + var_e49e01b230f55732.str_color );
                }
                
                var_e49e01b230f55732.var_d0760f1fb3ab2a78++;
                level.var_a5a819518c3899a2[ var_e49e01b230f55732.str_color ] = var_e49e01b230f55732.var_d0760f1fb3ab2a78;
                function_977111ebbf220cc8( var_e49e01b230f55732.var_29ebcbb64912d85b, var_e49e01b230f55732.var_d0760f1fb3ab2a78 );
                
                if ( isplayer( self.var_cdcc399e777de17 ) )
                {
                    challenges::function_bfa252952e732c7d( self.var_cdcc399e777de17 );
                }
                
                return;
            }
        }
        
        waitframe();
    }
}

// Namespace mp_sat_buzzkill
// Params 0, eflags: 0x4
// Checksum 0x2c143507, Offset: 0x14ec
// Size: 0x76
function private function_197a38ae388a47ee()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"death" );
        
        if ( !self.b_in_mouth )
        {
            e_eyes = getentitylessscriptablearray( "fail" + self.str_color, #targetname )[ 0 ];
            e_eyes setscriptablepartstate( "feedback", "hit_fail" + self.str_color );
        }
        
        return;
    }
}

// Namespace mp_sat_buzzkill
// Params 1, eflags: 0x4
// Checksum 0x78a68022, Offset: 0x156a
// Size: 0x4b
function private force_fail( params )
{
    e_eyes = getentitylessscriptablearray( "fail_" + params[ 0 ], #targetname )[ 0 ];
    e_eyes setscriptablepartstate( "feedback", "hit_fail" + "_" + params[ 0 ] );
}

// Namespace mp_sat_buzzkill
// Params 2, eflags: 0x4
// Checksum 0xe391f5e1, Offset: 0x15bd
// Size: 0xeb
function private function_977111ebbf220cc8( a_e_counters, var_13499fc5a3a2f18c )
{
    tens = var_13499fc5a3a2f18c >= 10 ? getxhash( string( int( var_13499fc5a3a2f18c / 10 ) % 10 ) ) : #"off";
    ones = getxhash( string( var_13499fc5a3a2f18c % 10 ) );
    
    foreach ( e_counter in a_e_counters )
    {
        e_counter setscriptablepartstate( #"hash_fa42e7ef19ca8b85", tens );
        e_counter setscriptablepartstate( #"hash_715e4b46adbc9d4", ones );
    }
}

// Namespace mp_sat_buzzkill
// Params 1, eflags: 0x4
// Checksum 0x943a04b1, Offset: 0x16b0
// Size: 0xbc
function private force_projectile( params )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( params[ 1 ] ) )
    {
        var_c4c19cd0e72fe598 = getentitylessscriptablearray( "button_cannon", #script_noteworthy );
        var_c4c19cd0e72fe598[ int( params[ 0 ] ) ] function_37b5cb9183e9202e( level.players[ 0 ] );
        return;
    }
    
    var_9684a7a4b41045d3 = int( params[ 1 ] );
    
    for ( i = 0; i < var_9684a7a4b41045d3 ; i++ )
    {
        var_c4c19cd0e72fe598 = getentitylessscriptablearray( "button_cannon", #script_noteworthy );
        var_c4c19cd0e72fe598[ int( params[ 0 ] ) ] function_37b5cb9183e9202e( level.players[ 0 ] );
        wait 0.5;
    }
}

// Namespace mp_sat_buzzkill
// Params 1, eflags: 0x4
// Checksum 0x2e946244, Offset: 0x1774
// Size: 0x165
function private function_6cb1c476d89323e5( params )
{
    foreach ( var_e49e01b230f55732 in level.a_t_damage )
    {
        if ( var_e49e01b230f55732.str_color == params[ 0 ] )
        {
            foreach ( var_35d81bdf3ea4c7b in var_e49e01b230f55732.a_e_indicators )
            {
                var_35d81bdf3ea4c7b setscriptablepartstate( "feedback", "hit_success" + var_e49e01b230f55732.str_color );
            }
            
            var_e49e01b230f55732.var_d0760f1fb3ab2a78++;
            level.var_a5a819518c3899a2[ var_e49e01b230f55732.str_color ] = var_e49e01b230f55732.var_d0760f1fb3ab2a78;
            function_977111ebbf220cc8( var_e49e01b230f55732.var_29ebcbb64912d85b, var_e49e01b230f55732.var_d0760f1fb3ab2a78 );
        }
    }
}

// Namespace mp_sat_buzzkill
// Params 0, eflags: 0x4
// Checksum 0xc77886ea, Offset: 0x18e1
// Size: 0x95
function private function_7924b68dde9343f9()
{
    var_4fea9954e6091f7b = getnoentvolumearray( "launcher_success_trigger", #targetname );
    
    foreach ( var_ed588ce7d4da2f07 in var_4fea9954e6091f7b )
    {
        trigger::makeenterexittrigger( var_ed588ce7d4da2f07, &function_ea62457158ec529f );
    }
}

// Namespace mp_sat_buzzkill
// Params 0, eflags: 0x4
// Checksum 0xea24e008, Offset: 0x197e
// Size: 0xb2
function private function_23b127c0d41439f8()
{
    if ( getxhash( game_utility::getgametype() ) != #"prop" )
    {
        return;
    }
    
    var_7f3f219e521422aa = getentarray( "no_equipment_zone", #script_noteworthy );
    
    foreach ( var_a1813a7738d0f19 in var_7f3f219e521422aa )
    {
        trigger::makeenterexittrigger( var_a1813a7738d0f19, &function_cb6ff504fa144b47, &function_886b4b59b89c5023 );
    }
}

// Namespace mp_sat_buzzkill
// Params 2, eflags: 0x4
// Checksum 0x2f6870bc, Offset: 0x1a38
// Size: 0x32
function private function_cb6ff504fa144b47( var_fd3a9f9e9a2a06c2, trigger )
{
    if ( isplayer( var_fd3a9f9e9a2a06c2 ) && isalive( var_fd3a9f9e9a2a06c2 ) )
    {
        var_fd3a9f9e9a2a06c2 namespace_404586677d964be2::function_22dfdf977055d577( 0 );
    }
}

// Namespace mp_sat_buzzkill
// Params 2, eflags: 0x4
// Checksum 0x34ba0c7d, Offset: 0x1a72
// Size: 0x29
function private function_886b4b59b89c5023( var_cfc19047cc2d028c, trigger )
{
    if ( isplayer( var_cfc19047cc2d028c ) )
    {
        var_cfc19047cc2d028c namespace_404586677d964be2::function_22dfdf977055d577( 1 );
    }
}

// Namespace mp_sat_buzzkill
// Params 2, eflags: 0x4
// Checksum 0x3a1df4be, Offset: 0x1aa3
// Size: 0x4b
function private function_ea62457158ec529f( var_fd3a9f9e9a2a06c2, trigger )
{
    if ( isplayer( var_fd3a9f9e9a2a06c2 ) && isalive( var_fd3a9f9e9a2a06c2 ) )
    {
        if ( var_fd3a9f9e9a2a06c2.var_b2b4a5303ac9f384 )
        {
            level thread function_605b4035a990a58e( trigger.script_noteworthy, 1 );
        }
    }
}

// Namespace mp_sat_buzzkill
// Params 0, eflags: 0x4
// Checksum 0x661b1dbe, Offset: 0x1af6
// Size: 0x90
function private function_5d8adbf183f32be4()
{
    var_80e3c4092a01cd4a = getentarray( "high_jump_hit_success", #targetname );
    
    foreach ( var_d19d9aed0f85ae6 in var_80e3c4092a01cd4a )
    {
        var_d19d9aed0f85ae6 thread function_5aa0047bf0ca372e();
    }
}

// Namespace mp_sat_buzzkill
// Params 0, eflags: 0x4
// Checksum 0x55b12f81, Offset: 0x1b8e
// Size: 0x41
function private function_5aa0047bf0ca372e()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"trigger" );
        self playsound( "dx_mp_buzz_msnscs_bkgh" );
        level thread function_605b4035a990a58e( self.script_noteworthy, 3 );
    }
}

// Namespace mp_sat_buzzkill
// Params 2, eflags: 0x4
// Checksum 0xb19d4292, Offset: 0x1bd7
// Size: 0x32
function private function_605b4035a990a58e( var_1dfee344824b8350, delay )
{
    level endon( #"game_ended" );
    activateworldevent( var_1dfee344824b8350 );
    wait delay;
    deactivateworldevent( var_1dfee344824b8350 );
}

