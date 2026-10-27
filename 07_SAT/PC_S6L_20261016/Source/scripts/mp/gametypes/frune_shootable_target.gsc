// scripts\mp\gametypes\frune_shootable_target.gsc  (hash_2b87d768dd86e290.gscc) (size: 12230 Bytes / 0x2fc6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb26390e4 (2992869604)
// size ...... 12230 (0x2fc6)
// includes .. 8   (offset: 0x2cf2)
// strings ... 13  (offset: 0x2d32)
// dev strs .. 35  (offset: 0x2dda)
// exports ... 27  (offset: 0x207e)
// cseg ...... 0x227 + 0x1e57 (0x207e)
// imports ... 66  (offset: 0x24b6)
// animtree1 . 0   (offset: 0x2fc6)
// animtree2 . 0   (offset: 0x2fc6)
#using script_44280f644740bac;
#using scripts\common\active_env\portals;
#using scripts\common\gameplay_sound_fx;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\damagefeedback;
#using scripts\mp\gametypes\frune_checkpoints;

#namespace frune_shootable_target;

// Namespace frune_shootable_target
// Params 0
// Checksum 0xeb2c69df, Offset: 0x245
// Size: 0x883
function init()
{
    utility::flag_wait( "scriptables_ready" );
    modeinfo = game[ #"frune_tuning" ];
    
    if ( !isdefined( modeinfo.frune_bundle ) )
    {
        modeinfo.frune_bundle = game_utility_mp::function_4b7180ed8c2e9742( "gametypebundle_frune" );
    }
    
    modeinfo.var_21a2ecc610b6e93d = getdvarint( @"hash_c75e94275bbec9cc", modeinfo.frune_bundle.var_7e80ccd7e3e521af ?? 5 );
    
    if ( !isdefined( modeinfo.var_ceab04bdf86e1fbc ) )
    {
        modeinfo.var_ceab04bdf86e1fbc = {};
    }
    
    if ( !isdefined( modeinfo.var_ceab04bdf86e1fbc.var_ff8a76bf4f768eee ) )
    {
        modeinfo.var_ceab04bdf86e1fbc.var_ff8a76bf4f768eee = [ 8:#"shootable_countdown_duration_seconds_8", 7:#"shootable_countdown_duration_seconds_7", 6:#"shootable_countdown_duration_seconds_6", 5:#"shootable_countdown_duration_seconds_5", #"shootable_countdown_duration_seconds_4", 3:#"shootable_countdown_duration_seconds_3", 2:#"shootable_countdown_duration_seconds_2" ];
    }
    
    if ( !isdefined( modeinfo.var_ceab04bdf86e1fbc.var_d9fa10a4746200c2 ) )
    {
        modeinfo.var_ceab04bdf86e1fbc.var_d9fa10a4746200c2 = [ 38:#"hash_ae865bdfcee45a27", 37:#"hash_ae8650dfcee44776", 36:#"hash_ae8651dfcee44929", 35:#"hash_ae864edfcee44410", 34:#"hash_ae864fdfcee445c3", 33:#"hash_ae8654dfcee44e42", 32:#"hash_ae8655dfcee44ff5", 31:#"hash_ae8652dfcee44adc", 30:#"hash_ae8653dfcee44c8f", 29:#"hash_ae82d6dfcee14251", 28:#"hash_ae82d5dfcee1409e", 27:#"hash_ae82d0dfcee1381f", 26:#"hash_ae82cfdfcee1366c", 25:#"hash_ae82d2dfcee13b85", 24:#"hash_ae82d1dfcee139d2", 23:#"hash_ae82ccdfcee13153", 22:#"hash_ae82cbdfcee12fa0", 21:#"hash_ae82cedfcee134b9", 20:#"hash_ae82cddfcee13306", #"hash_ae7f5edfcede4092", 18:#"hash_ae7f5fdfcede4245", 17:#"hash_ae7f60dfcede43f8", 16:#"hash_ae7f61dfcede45ab", 15:#"hash_ae7f62dfcede475e", 14:#"hash_ae7f63dfcede4911", 13:#"hash_ae7f64dfcede4ac4", 12:#"hash_ae7f65dfcede4c77", 11:#"hash_ae7f66dfcede4e2a", 10:#"hash_ae7f67dfcede4fdd", 9:#"hash_ae7bdadfcedb2a6f", 8:#"hash_ae7bd9dfcedb28bc", 7:#"hash_ae7be0dfcedb34a1", 6:#"hash_ae7bdfdfcedb32ee", 5:#"hash_ae7bdedfcedb313b", 4:#"hash_ae7bdddfcedb2f88", 3:#"hash_ae7be4dfcedb3b6d", 2:#"hash_ae7be3dfcedb39ba", 1:#"hash_ae7be2dfcedb3807" ];
    }
    
    if ( !isdefined( modeinfo.var_ceab04bdf86e1fbc.var_46680bfc4fc20a85 ) )
    {
        modeinfo.var_ceab04bdf86e1fbc.var_46680bfc4fc20a85 = [ 38:#"hash_3b532dea3bcd34bb", 37:#"hash_3b532aea3bcd2fa2", 36:#"hash_3b532bea3bcd3155", 35:#"hash_3b5328ea3bcd2c3c", 34:#"hash_3b5329ea3bcd2def", 33:#"hash_3b5326ea3bcd28d6", 32:#"hash_3b5327ea3bcd2a89", 31:#"hash_3b5324ea3bcd2570", 30:#"hash_3b5325ea3bcd2723", 29:#"hash_3b4fb8ea3bca3815", 28:#"hash_3b4fb7ea3bca3662", 27:#"hash_3b4fbaea3bca3b7b", 26:#"hash_3b4fb9ea3bca39c8", 25:#"hash_3b4fbcea3bca3ee1", 24:#"hash_3b4fbbea3bca3d2e", 23:#"hash_3b4fbeea3bca4247", 22:#"hash_3b4fbdea3bca4094", 21:#"hash_3b4fc0ea3bca45ad", 20:#"hash_3b4fbfea3bca43fa", #"hash_3b4c30ea3bc71b26", 18:#"hash_3b4c31ea3bc71cd9", 17:#"hash_3b4c3aea3bc72c24", 16:#"hash_3b4c3bea3bc72dd7", 15:#"hash_3b4c3cea3bc72f8a", 14:#"hash_3b4c3dea3bc7313d", 13:#"hash_3b4c36ea3bc72558", 12:#"hash_3b4c37ea3bc7270b", 11:#"hash_3b4c38ea3bc728be", 10:#"hash_3b4c39ea3bc72a71", 9:#"hash_3b492cea3bc4de83", 8:#"hash_3b492bea3bc4dcd0", 7:#"hash_3b493aea3bc4f64d", 6:#"hash_3b4939ea3bc4f49a", 5:#"hash_3b4938ea3bc4f2e7", 4:#"hash_3b4937ea3bc4f134", 3:#"hash_3b4936ea3bc4ef81", 2:#"hash_3b4935ea3bc4edce", 1:#"hash_3b4934ea3bc4ec1b" ];
    }
    
    framems = getframeduration();
    var_ed2633763641f2ff = int( 5000 / framems );
    
    if ( !isdefined( modeinfo.var_ceab04bdf86e1fbc.var_3ea570ed347afd4c ) )
    {
        modeinfo.var_ceab04bdf86e1fbc.var_3ea570ed347afd4c = { #var_9e0c6372dbdc5aaa:utility::function_6f5d2e1f1ff70482( int( var_ed2633763641f2ff * 0.1 ) * framems ), #shortpause:utility::function_6f5d2e1f1ff70482( int( var_ed2633763641f2ff * 0.12 ) * framems ), #medpause:utility::function_6f5d2e1f1ff70482( int( var_ed2633763641f2ff * 0.16 ) * framems ), #longpause:utility::function_6f5d2e1f1ff70482( int( var_ed2633763641f2ff * 0.2 ) * framems ) };
    }
    
    function_3b762fbb6fcf17d5();
    
    if ( getdvarint( @"hash_860dbe5e68c21210", 1 ) )
    {
        function_63ca4d21d4429d06();
    }
    
    /#
        helptext = "<dev string:x24>";
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"fre" ][ #"registercommand" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( "<dev string:x53>", "<dev string:x6c>", &function_a62924e6174e41b2, helptext, "<dev string:x70>", undefined );
        }
        
        helptext = "<dev string:x24>";
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"fre" ][ #"registercommand" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( "<dev string:x7b>", "<dev string:x6c>", &function_cb08ebe5746ea9cf, helptext, "<dev string:x70>", undefined );
        }
        
        helptext = "<dev string:x95>";
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"fre" ][ #"registercommand" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( "<dev string:xc3>", "<dev string:x6c>", &function_3a8a0dc23d62d364, helptext, "<dev string:x70>", undefined );
        }
        
        helptext = "<dev string:xdf>";
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"fre" ][ #"registercommand" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( "<dev string:x10f>", "<dev string:x6c>", &function_ab4b66e887c5fd07, helptext, "<dev string:x70>", undefined );
        }
        
        helptext = "<dev string:x12d>";
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"fre" ][ #"registercommand" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( "<dev string:x153>", "<dev string:x6c>", &function_6d4831ac497ffca5, helptext, "<dev string:x70>", undefined );
        }
        
        helptext = "<dev string:x169>";
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"fre" ][ #"registercommand" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( "<dev string:x1a1>", "<dev string:x6c>", &function_2b777fb3d23eb424, helptext, "<dev string:x70>", [ "<dev string:x1bb>", "<dev string:x1c8>" ] );
        }
        
        helptext = "<dev string:x1d3>";
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"fre" ][ #"registercommand" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( "<dev string:x20b>", "<dev string:x6c>", &function_2b777fb3d23eb424, helptext, "<dev string:x70>", [ "<dev string:x1bb>", "<dev string:x225>" ] );
        }
        
        helptext = "<dev string:x230>";
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"fre" ][ #"registercommand" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( "<dev string:x269>", "<dev string:x6c>", &function_2b777fb3d23eb424, helptext, "<dev string:x70>", [ "<dev string:x1bb>", "<dev string:x284>" ] );
        }
    #/
}

// Namespace frune_shootable_target
// Params 0, eflags: 0x4
// Checksum 0xcb598655, Offset: 0xad0
// Size: 0x45b
function private function_3b762fbb6fcf17d5()
{
    modeinfo = game[ #"frune_tuning" ];
    modeinfo.var_ceab04bdf86e1fbc.var_ede031eed94ec85d = utility::array_combine_multiple( [ getscriptablearray( "scriptable_mp_sat_free_run_evo_dynamic_platform_128_01", #classname ), getscriptablearray( "scriptable_mp_sat_free_run_evo_dynamic_platform_128_01_walljump", #classname ), getscriptablearray( "scriptable_mp_sat_free_run_evo_dynamic_platform_256x128_01", #classname ), getscriptablearray( "scriptable_mp_sat_free_run_evo_dynamic_platform_walljump_64_01", #classname ), getscriptablearray( "scriptable_mp_sat_free_run_evo_dynamic_portal", #classname ) ] );
    
    foreach ( var_e71993bad4d6941a in modeinfo.var_ceab04bdf86e1fbc.var_ede031eed94ec85d )
    {
        if ( var_e71993bad4d6941a.script_linkname )
        {
            splitname = strtok( var_e71993bad4d6941a.script_linkname, "_" );
            
            if ( splitname.size == 3 )
            {
                var_e71993bad4d6941a.script_parameters = splitname[ 1 ] + "_" + splitname[ 2 ];
            }
        }
        
        if ( var_e71993bad4d6941a.script_linkto )
        {
            splitname = strtok( var_e71993bad4d6941a.script_linkto, "_" );
            
            if ( splitname.size > 0 )
            {
                var_e71993bad4d6941a.portalnumber = int( splitname[ splitname.size - 1 ] );
            }
        }
        
        var_e71993bad4d6941a.var_45f78fafefe8c95 = var_e71993bad4d6941a.script_parameters != #"hash_a384987a90a14267";
        var_e71993bad4d6941a.pulsepart = var_e71993bad4d6941a.var_45f78fafefe8c95 ? #"activation_hides_me" : #"activation_shows_me";
        
        if ( var_e71993bad4d6941a.classname == "scriptable_mp_sat_free_run_evo_dynamic_portal" )
        {
            var_e71993bad4d6941a.var_56211def389f795a = 1;
            var_e71993bad4d6941a.activatefunc = var_e71993bad4d6941a.var_45f78fafefe8c95 ? &function_511126ab12bb08c : &function_340c16dfe49340f;
            var_e71993bad4d6941a.deactivatefunc = var_e71993bad4d6941a.var_45f78fafefe8c95 ? &function_340c16dfe49340f : &function_511126ab12bb08c;
            var_e71993bad4d6941a.portalparts = getentarray( var_e71993bad4d6941a.targetname, #targetname );
            portalindex = var_e71993bad4d6941a.portalnumber ?? 1;
            visiblestate = modeinfo.var_ceab04bdf86e1fbc.var_d9fa10a4746200c2[ portalindex ];
            var_5c5034c52bf01dcb = modeinfo.var_ceab04bdf86e1fbc.var_46680bfc4fc20a85[ portalindex ];
            var_e71993bad4d6941a.deactivestate = var_e71993bad4d6941a.var_45f78fafefe8c95 ? visiblestate : var_5c5034c52bf01dcb;
            var_e71993bad4d6941a.activestate = var_e71993bad4d6941a.var_45f78fafefe8c95 ? var_5c5034c52bf01dcb : visiblestate;
            
            foreach ( part in var_e71993bad4d6941a.portalparts )
            {
                namespace_491847e095ef9a1d::function_c2784dc7bd1c4dba( part, #"frune_portal", #"on" );
            }
        }
        else
        {
            var_e71993bad4d6941a.var_56211def389f795a = 0;
            var_e71993bad4d6941a.deactivestate = var_e71993bad4d6941a.var_45f78fafefe8c95 ? #"hash_6201896c911acc83" : #"hash_a384987a90a14267";
            var_e71993bad4d6941a.activestate = var_e71993bad4d6941a.var_45f78fafefe8c95 ? #"hash_a384987a90a14267" : #"hash_6201896c911acc83";
        }
        
        var_e71993bad4d6941a.unresolved_collision_func = &function_354789391e742e23;
        function_957a6918b4d92340( var_e71993bad4d6941a );
    }
    
    level scriptable::scriptable_addnotifycallback( "target_damaged", &target_damaged );
}

// Namespace frune_shootable_target
// Params 4, eflags: 0x4
// Checksum 0xd522fa04, Offset: 0xf33
// Size: 0x32
function private target_damaged( shootabletarget, var_fbe21110104b5926, var_acc7ae5f813fa77e, var_533710b0b76c405a )
{
    shootabletarget thread function_3db52fbe0253a958( shootabletarget, var_533710b0b76c405a );
}

// Namespace frune_shootable_target
// Params 2, eflags: 0xc
// Checksum 0x7bdf8dcb, Offset: 0xf6d
// Size: 0x343
function private function_3db52fbe0253a958( shootabletarget, playershooter )
{
    self notify( #"hash_ff090bc820f29938" );
    self endon( #"hash_ff090bc820f29938" );
    
    if ( !shootabletarget.target )
    {
        assertmsg( "<dev string:x290>" );
        return;
    }
    
    playershooter gameplay_sound_fx::playlocalsoundfx( #"target_hit" );
    gameplay_sound_fx::function_760dbc73d1362ab9( #"hash_73e81466a6042cb0", playershooter, shootabletarget.entity );
    playershooter damagefeedback::updatehitmarker( "standard", 0, 0, 1, undefined, 0, 0, undefined, 1 );
    
    if ( !isdefined( shootabletarget.var_ede031eed94ec85d ) )
    {
        shootabletarget.var_ede031eed94ec85d = getscriptablearray( shootabletarget.target, "targetname" );
    }
    
    foreach ( var_e71993bad4d6941a in shootabletarget.var_ede031eed94ec85d )
    {
        function_1e5e0f1459e05657( var_e71993bad4d6941a );
    }
    
    currenttimems = gettime();
    shootabletarget.var_24d8fe86ffbaa866 = currenttimems;
    modeinfo = game[ #"frune_tuning" ];
    var_7ad0491d8fa29199 = modeinfo.var_21a2ecc610b6e93d;
    activedurationms = utility::function_4b74c15943231980( var_7ad0491d8fa29199 );
    endtimems = shootabletarget.var_24d8fe86ffbaa866 + activedurationms;
    countdownpartname = function_92e9a93997b4c80( var_7ad0491d8fa29199 );
    
    if ( shootabletarget.var_7cc29191b416e8cf )
    {
        shootabletarget setscriptablepartstate( countdownpartname, #"active_countdown_disabled" );
        waitframe();
        shootabletarget.var_7cc29191b416e8cf = 0;
    }
    
    shootabletarget utility::function_32b24db3127bff40( countdownpartname, #"active_countdown_start" );
    
    while ( shootabletarget && currenttimems < endtimems )
    {
        var_68d5c64e3eb8bc82 = endtimems - currenttimems;
        
        if ( var_68d5c64e3eb8bc82 <= 5000 && !shootabletarget.var_7cc29191b416e8cf )
        {
            shootabletarget.var_7cc29191b416e8cf = 1;
            
            foreach ( var_e71993bad4d6941a in shootabletarget.var_ede031eed94ec85d )
            {
                var_e71993bad4d6941a thread function_94eac324ef8bd1c7( var_e71993bad4d6941a );
            }
        }
        
        waitframe();
        currenttimems = gettime();
    }
    
    if ( !shootabletarget )
    {
        return;
    }
    
    shootabletarget setscriptablepartstate( countdownpartname, #"active_countdown_disabled" );
    
    foreach ( var_e71993bad4d6941a in shootabletarget.var_ede031eed94ec85d )
    {
        function_957a6918b4d92340( var_e71993bad4d6941a );
    }
}

// Namespace frune_shootable_target
// Params 0, eflags: 0x4
// Checksum 0x3ff4a5f1, Offset: 0x12b8
// Size: 0x7b
function private function_340c16dfe49340f()
{
    foreach ( part in self.portalparts )
    {
        namespace_491847e095ef9a1d::portal_enable( part );
    }
}

// Namespace frune_shootable_target
// Params 0, eflags: 0x4
// Checksum 0x762811fe, Offset: 0x133b
// Size: 0x7b
function private function_511126ab12bb08c()
{
    foreach ( part in self.portalparts )
    {
        namespace_491847e095ef9a1d::portal_disable( part );
    }
}

// Namespace frune_shootable_target
// Params 1, eflags: 0x4
// Checksum 0x57c5f6d3, Offset: 0x13be
// Size: 0x29
function private function_c06e22ac1971702d( var_e71993bad4d6941a )
{
    var_e71993bad4d6941a utility::function_32b24db3127bff40( var_e71993bad4d6941a.pulsepart, #"pulse_lowest" );
}

// Namespace frune_shootable_target
// Params 1, eflags: 0x4
// Checksum 0x2937ad95, Offset: 0x13ef
// Size: 0x29
function private function_bce7367e3b7c6a9b( var_e71993bad4d6941a )
{
    var_e71993bad4d6941a utility::function_32b24db3127bff40( var_e71993bad4d6941a.pulsepart, #"pulse_low" );
}

// Namespace frune_shootable_target
// Params 1, eflags: 0x4
// Checksum 0x2e7cb92d, Offset: 0x1420
// Size: 0x29
function private function_3195456db42423a4( var_e71993bad4d6941a )
{
    var_e71993bad4d6941a utility::function_32b24db3127bff40( var_e71993bad4d6941a.pulsepart, #"pulse_medium" );
}

// Namespace frune_shootable_target
// Params 1, eflags: 0x4
// Checksum 0x1bbd019, Offset: 0x1451
// Size: 0x29
function private function_32149843fc27e8d7( var_e71993bad4d6941a )
{
    var_e71993bad4d6941a utility::function_32b24db3127bff40( var_e71993bad4d6941a.pulsepart, #"pulse_high" );
}

// Namespace frune_shootable_target
// Params 1, eflags: 0x4
// Checksum 0xfecb64ab, Offset: 0x1482
// Size: 0x29
function private function_e9b94dd72f4422f6( var_e71993bad4d6941a )
{
    var_e71993bad4d6941a utility::function_32b24db3127bff40( var_e71993bad4d6941a.pulsepart, #"base" );
}

// Namespace frune_shootable_target
// Params 1, eflags: 0xc
// Checksum 0x17095c15, Offset: 0x14b3
// Size: 0xeb
function private function_94eac324ef8bd1c7( var_e71993bad4d6941a )
{
    self notify( #"hash_7b1506d7be4b81a1" );
    self endon( #"hash_7b1506d7be4b81a1" );
    modeinfo = game[ #"frune_tuning" ];
    pauses = modeinfo.var_ceab04bdf86e1fbc.var_3ea570ed347afd4c;
    function_c06e22ac1971702d( var_e71993bad4d6941a );
    wait pauses.longpause;
    function_c06e22ac1971702d( var_e71993bad4d6941a );
    wait pauses.longpause;
    function_bce7367e3b7c6a9b( var_e71993bad4d6941a );
    wait pauses.medpause;
    function_bce7367e3b7c6a9b( var_e71993bad4d6941a );
    wait pauses.medpause;
    function_3195456db42423a4( var_e71993bad4d6941a );
    wait pauses.shortpause;
    function_32149843fc27e8d7( var_e71993bad4d6941a );
    wait pauses.var_9e0c6372dbdc5aaa;
    gameplay_sound_fx::function_760dbc73d1362ab9( #"hash_db459da4a605d07f", undefined, var_e71993bad4d6941a );
}

// Namespace frune_shootable_target
// Params 2, eflags: 0x4
// Checksum 0xa98fdb88, Offset: 0x15a6
// Size: 0x34
function private function_354789391e742e23( player, penetration )
{
    if ( !isplayer( player ) || !isalive( player ) )
    {
        return;
    }
    
    frune_checkpoints::function_aae76b5997fc6288( player );
}

// Namespace frune_shootable_target
// Params 1, eflags: 0x4
// Checksum 0x265789d3, Offset: 0x15e2
// Size: 0x71
function private function_957a6918b4d92340( var_e71993bad4d6941a )
{
    var_e71993bad4d6941a.activated = 0;
    var_e71993bad4d6941a utility::function_32b24db3127bff40( #"base", var_e71993bad4d6941a.deactivestate );
    var_e71993bad4d6941a utility::function_32b24db3127bff40( var_e71993bad4d6941a.pulsepart, #"base" );
    
    if ( var_e71993bad4d6941a.deactivatefunc )
    {
        var_e71993bad4d6941a [[ var_e71993bad4d6941a.deactivatefunc ]]();
    }
}

// Namespace frune_shootable_target
// Params 1, eflags: 0x4
// Checksum 0x603e8d6e, Offset: 0x165b
// Size: 0x72
function private function_1e5e0f1459e05657( var_e71993bad4d6941a )
{
    var_e71993bad4d6941a.activated = 1;
    var_e71993bad4d6941a utility::function_32b24db3127bff40( #"base", var_e71993bad4d6941a.activestate );
    var_e71993bad4d6941a utility::function_32b24db3127bff40( var_e71993bad4d6941a.pulsepart, #"base" );
    
    if ( var_e71993bad4d6941a.activatefunc )
    {
        var_e71993bad4d6941a [[ var_e71993bad4d6941a.activatefunc ]]();
    }
}

// Namespace frune_shootable_target
// Params 1, eflags: 0x4
// Checksum 0x14f8b1bc, Offset: 0x16d5
// Size: 0x3b
function private function_92e9a93997b4c80( durationseconds )
{
    modeinfo = game[ #"frune_tuning" ];
    return modeinfo.var_ceab04bdf86e1fbc.var_ff8a76bf4f768eee[ durationseconds ];
}

// Namespace frune_shootable_target
// Params 0, eflags: 0x4
// Checksum 0x44f2ad09, Offset: 0x1719
// Size: 0x118
function private function_63ca4d21d4429d06()
{
    grappletargets = getentarray( "grapple_target", #script_noteworthy );
    
    foreach ( grapple in grappletargets )
    {
        grapple enableaimassist();
    }
    
    shootabletargets = getscriptablearray( "scriptable_mp_sat_freerun_shootable_target_01", #classname );
    
    foreach ( shootable in shootabletargets )
    {
        shootable enableaimassist();
    }
}

/#

    // Namespace frune_shootable_target
    // Params 1, eflags: 0x4
    // Checksum 0xe111d5cf, Offset: 0x1839
    // Size: 0xe5, Type: dev
    function private function_f335b9e816cb6f9b( var_e71993bad4d6941a )
    {
        iprintlnbold( "<dev string:x2dd>" );
        function_c06e22ac1971702d( var_e71993bad4d6941a );
        wait 1.2;
        function_c06e22ac1971702d( var_e71993bad4d6941a );
        wait 1.2;
        function_c06e22ac1971702d( var_e71993bad4d6941a );
        wait 2;
        iprintlnbold( "<dev string:x2e4>" );
        function_bce7367e3b7c6a9b( var_e71993bad4d6941a );
        wait 1.2;
        function_bce7367e3b7c6a9b( var_e71993bad4d6941a );
        wait 1.2;
        function_bce7367e3b7c6a9b( var_e71993bad4d6941a );
        wait 2;
        iprintlnbold( "<dev string:x2e8>" );
        function_3195456db42423a4( var_e71993bad4d6941a );
        wait 1;
        function_3195456db42423a4( var_e71993bad4d6941a );
        wait 1;
        function_3195456db42423a4( var_e71993bad4d6941a );
        wait 2;
        iprintlnbold( "<dev string:x2ef>" );
        function_32149843fc27e8d7( var_e71993bad4d6941a );
        wait 1;
        function_32149843fc27e8d7( var_e71993bad4d6941a );
        wait 1;
        function_32149843fc27e8d7( var_e71993bad4d6941a );
    }

    // Namespace frune_shootable_target
    // Params 2, eflags: 0x4
    // Checksum 0x36246358, Offset: 0x1926
    // Size: 0xa8, Type: dev
    function private function_a62924e6174e41b2( host, args )
    {
        foreach ( var_e71993bad4d6941a in game[ #"frune_tuning" ].var_ceab04bdf86e1fbc.var_ede031eed94ec85d )
        {
            var_e71993bad4d6941a thread function_f335b9e816cb6f9b( var_e71993bad4d6941a );
        }
    }

    // Namespace frune_shootable_target
    // Params 2, eflags: 0x4
    // Checksum 0x6a37fb3c, Offset: 0x19d6
    // Size: 0xa8, Type: dev
    function private function_cb08ebe5746ea9cf( host, args )
    {
        foreach ( var_e71993bad4d6941a in game[ #"frune_tuning" ].var_ceab04bdf86e1fbc.var_ede031eed94ec85d )
        {
            var_e71993bad4d6941a thread function_94eac324ef8bd1c7( var_e71993bad4d6941a );
        }
    }

    // Namespace frune_shootable_target
    // Params 2, eflags: 0x4
    // Checksum 0x7a33517c, Offset: 0x1a86
    // Size: 0xa7, Type: dev
    function private function_3a8a0dc23d62d364( host, args )
    {
        foreach ( var_e71993bad4d6941a in game[ #"frune_tuning" ].var_ceab04bdf86e1fbc.var_ede031eed94ec85d )
        {
            function_1e5e0f1459e05657( var_e71993bad4d6941a );
        }
    }

    // Namespace frune_shootable_target
    // Params 2, eflags: 0x4
    // Checksum 0x7c3623a4, Offset: 0x1b35
    // Size: 0xa7, Type: dev
    function private function_ab4b66e887c5fd07( host, args )
    {
        foreach ( var_e71993bad4d6941a in game[ #"frune_tuning" ].var_ceab04bdf86e1fbc.var_ede031eed94ec85d )
        {
            function_957a6918b4d92340( var_e71993bad4d6941a );
        }
    }

    // Namespace frune_shootable_target
    // Params 2, eflags: 0x4
    // Checksum 0xc0397981, Offset: 0x1be4
    // Size: 0xbd, Type: dev
    function private function_2b777fb3d23eb424( host, args )
    {
        foreach ( var_e71993bad4d6941a in game[ #"frune_tuning" ].var_ceab04bdf86e1fbc.var_ede031eed94ec85d )
        {
            if ( var_e71993bad4d6941a.var_56211def389f795a == 1 )
            {
                var_e71993bad4d6941a setscriptablepartstate( args[ 0 ], args[ 1 ] );
            }
        }
    }

    // Namespace frune_shootable_target
    // Params 2, eflags: 0x4
    // Checksum 0x9fa67d3e, Offset: 0x1ca9
    // Size: 0x5a, Type: dev
    function private function_6d4831ac497ffca5( host, args )
    {
        var_8005b965951cc17 = namespace_ec33f26de741e14e::function_7fb3afaa98ee9eeb( "<dev string:x6c>" );
        var_8005b965951cc17.var_8fcf2b52f9758be6 = !var_8005b965951cc17.var_8fcf2b52f9758be6;
        level thread function_aaa3de1f1252b9c5( var_8005b965951cc17.var_8fcf2b52f9758be6 );
    }

    // Namespace frune_shootable_target
    // Params 1, eflags: 0xc
    // Checksum 0x14014cfb, Offset: 0x1d0b
    // Size: 0x11f, Type: dev
    function private function_aaa3de1f1252b9c5( enabled )
    {
        self notify( #"hash_4dfe4400d5e1c071" );
        self endon( #"hash_4dfe4400d5e1c071" );
        
        if ( !enabled )
        {
            return;
        }
        
        modeinfo = game[ #"frune_tuning" ];
        
        while ( true )
        {
            player = level.players[ 0 ];
            
            if ( !player )
            {
                waitframe();
                continue;
            }
            
            foreach ( var_e71993bad4d6941a in modeinfo.var_ceab04bdf86e1fbc.var_ede031eed94ec85d )
            {
                distancesq = distancesquared( player.origin, var_e71993bad4d6941a.origin );
                
                if ( distancesq < 5000000 )
                {
                    function_4ef14bce51cb46a0( var_e71993bad4d6941a );
                }
            }
            
            waitframe();
        }
    }

    // Namespace frune_shootable_target
    // Params 1, eflags: 0x4
    // Checksum 0xbd1086fd, Offset: 0x1e32
    // Size: 0x24c, Type: dev
    function private function_4ef14bce51cb46a0( var_e71993bad4d6941a )
    {
        origin = var_e71993bad4d6941a.origin;
        
        if ( !isdefined( var_e71993bad4d6941a.var_839601c38f7d03c3 ) )
        {
            var_e71993bad4d6941a.var_839601c38f7d03c3 = "<dev string:x2f4>" + var_e71993bad4d6941a.targetname;
        }
        
        if ( !isdefined( var_e71993bad4d6941a.var_3ac74be058460aeb ) )
        {
            var_e71993bad4d6941a.var_3ac74be058460aeb = "<dev string:x301>" + ( var_e71993bad4d6941a.var_56211def389f795a == 1 ? "<dev string:x308>" : "<dev string:x30f>" ) + ( var_e71993bad4d6941a.var_45f78fafefe8c95 ? "<dev string:x318>" : "<dev string:x32b>" );
        }
        
        activatedtext = "<dev string:x33e>" + ( var_e71993bad4d6941a.activated ? "<dev string:x34a>" : "<dev string:x34f>" );
        
        foreach ( part in var_e71993bad4d6941a.portalparts )
        {
            debugcolor = var_e71993bad4d6941a.activated ? ( 0.5, 0.5, 1 ) : ( 1, 0, 0 );
            drawtrigger( part, debugcolor, 1 );
        }
        
        print3d( origin, var_e71993bad4d6941a.var_839601c38f7d03c3, ( 1, 1, 1 ), 1, 1, 1, 1 );
        print3d( origin + ( 0, 0, -20 ), var_e71993bad4d6941a.var_3ac74be058460aeb, ( 1, 1, 1 ), 1, 1, 1, 1 );
        print3d( origin + ( 0, 0, -40 ), activatedtext, ( 1, 1, 1 ), 1, 1, 1, 1 );
        box( origin, 0, ( 0, 0, 1 ), 0, 1 );
        drawtrigger( var_e71993bad4d6941a, ( 0, 0, 1 ), 1 );
    }

#/
