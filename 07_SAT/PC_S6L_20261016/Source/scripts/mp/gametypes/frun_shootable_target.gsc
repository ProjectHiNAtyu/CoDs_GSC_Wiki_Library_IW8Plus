// scripts\mp\gametypes\frun_shootable_target.gsc  (hash_58acfc503626f3dd.gscc) (size: 7470 Bytes / 0x1d2e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5c25564 (96621924)
// size ...... 7470 (0x1d2e)
// includes .. 7   (offset: 0x1bae)
// strings ... 11  (offset: 0x1be6)
// dev strs .. 14  (offset: 0x1c6a)
// exports ... 21  (offset: 0x1202)
// cseg ...... 0x1dc + 0x1026 (0x1202)
// imports ... 51  (offset: 0x154a)
// animtree1 . 0   (offset: 0x1d2e)
// animtree2 . 0   (offset: 0x1d2e)
#using scripts\common\gameplay_sound_fx;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\damagefeedback;
#using scripts\mp\gametypes\frun_checkpoints;
#using scripts\mp\gametypes\frun_free_run;

#namespace frun_shootable_target;

// Namespace frun_shootable_target
// Params 0
// Checksum 0x9562bcdb, Offset: 0x1fa
// Size: 0x336
function init()
{
    utility::flag_wait( "scriptables_ready" );
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    
    if ( !isdefined( modeinfo.frun_bundle ) )
    {
        modeinfo.frun_bundle = game_utility_mp::function_4b7180ed8c2e9742( "gametypebundle_frun" );
    }
    
    modeinfo.var_21a2ecc610b6e93d = getdvarint( @"hash_40a67d2e00d106c3", modeinfo.frun_bundle.var_894a46c25bc31d8e ?? 5 );
    
    if ( !isdefined( modeinfo.var_ceab04bdf86e1fbc ) )
    {
        modeinfo.var_ceab04bdf86e1fbc = {};
    }
    
    if ( !isdefined( modeinfo.var_ceab04bdf86e1fbc.var_ff8a76bf4f768eee ) )
    {
        modeinfo.var_ceab04bdf86e1fbc.var_ff8a76bf4f768eee = [ 8:#"shootable_countdown_duration_seconds_8", 7:#"shootable_countdown_duration_seconds_7", 6:#"shootable_countdown_duration_seconds_6", 5:#"shootable_countdown_duration_seconds_5", #"shootable_countdown_duration_seconds_4", 3:#"shootable_countdown_duration_seconds_3", 2:#"shootable_countdown_duration_seconds_2" ];
    }
    
    framems = getframeduration();
    var_ed2633763641f2ff = int( 5000 / framems );
    
    if ( !isdefined( modeinfo.var_ceab04bdf86e1fbc.var_3ea570ed347afd4c ) )
    {
        modeinfo.var_ceab04bdf86e1fbc.var_3ea570ed347afd4c = { #var_9e0c6372dbdc5aaa:utility::function_6f5d2e1f1ff70482( int( var_ed2633763641f2ff * 0.1 ) * framems ), #shortpause:utility::function_6f5d2e1f1ff70482( int( var_ed2633763641f2ff * 0.12 ) * framems ), #medpause:utility::function_6f5d2e1f1ff70482( int( var_ed2633763641f2ff * 0.16 ) * framems ), #longpause:utility::function_6f5d2e1f1ff70482( int( var_ed2633763641f2ff * 0.2 ) * framems ) };
    }
    
    function_7b6dbd7fba638f38();
    
    if ( getdvarint( @"hash_860dbe5e68c21210", 1 ) )
    {
        function_63ca4d21d4429d06();
    }
    
    /#
        helptext = "<dev string:x24>";
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"fre" ][ #"registercommand" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( "<dev string:x51>", "<dev string:x68>", &function_63535c0b050d7bbb, helptext, "<dev string:x6c>", undefined );
        }
        
        helptext = "<dev string:x24>";
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"fre" ][ #"registercommand" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( "<dev string:x77>", "<dev string:x68>", &function_60465cee5aded23c, helptext, "<dev string:x6c>", undefined );
        }
        
        helptext = "<dev string:x8f>";
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"fre" ][ #"registercommand" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( "<dev string:xbb>", "<dev string:x68>", &function_6b1b71497b550a9b, helptext, "<dev string:x6c>", undefined );
        }
        
        helptext = "<dev string:xd5>";
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"fre" ][ #"registercommand" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( "<dev string:x103>", "<dev string:x68>", &function_cf361abe13a84248, helptext, "<dev string:x6c>", undefined );
        }
    #/
}

// Namespace frun_shootable_target
// Params 0, eflags: 0x4
// Checksum 0xf425b0fb, Offset: 0x538
// Size: 0x1dd
function private function_7b6dbd7fba638f38()
{
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    modeinfo.var_ceab04bdf86e1fbc.platformlist = utility::array_combine_multiple( [ getscriptablearray( "scriptable_mp_sat_freerun_dynamic_platform_128_01", #classname ), getscriptablearray( "scriptable_mp_sat_freerun_dynamic_platform_128_01_walljump", #classname ), getscriptablearray( "scriptable_mp_sat_freerun_dynamic_platform_256x128_01", #classname ), getscriptablearray( "scriptable_mp_sat_freerun_dynamic_platform_walljump_64_01", #classname ) ] );
    
    foreach ( platform in modeinfo.var_ceab04bdf86e1fbc.platformlist )
    {
        platform.var_45f78fafefe8c95 = platform.script_noteworthy != #"platform_off";
        platform.pulsepart = platform.var_45f78fafefe8c95 ? #"activation_hides_me" : #"activation_shows_me";
        platform.var_60806bfd9969f371 = platform.var_45f78fafefe8c95 ? #"platform_on" : #"platform_off";
        platform.var_86b01a3e3b36f1f8 = platform.var_45f78fafefe8c95 ? #"platform_off" : #"platform_on";
        platform.unresolved_collision_func = &platform_unresolved_collision;
        deactivateplatform( platform );
    }
    
    level scriptable::scriptable_addnotifycallback( "target_damaged", &target_damaged );
}

// Namespace frun_shootable_target
// Params 4, eflags: 0x4
// Checksum 0xb9c514c8, Offset: 0x71d
// Size: 0x32
function private target_damaged( shootabletarget, var_fbe21110104b5926, var_acc7ae5f813fa77e, var_533710b0b76c405a )
{
    shootabletarget thread function_3db52fbe0253a958( shootabletarget, var_533710b0b76c405a );
}

// Namespace frun_shootable_target
// Params 2, eflags: 0xc
// Checksum 0x65ef3475, Offset: 0x757
// Size: 0x33e
function private function_3db52fbe0253a958( shootabletarget, playershooter )
{
    self notify( #"hash_daee82fe461adafe" );
    self endon( #"hash_daee82fe461adafe" );
    
    if ( !shootabletarget.target )
    {
        assertmsg( "<dev string:x11f>" );
        return;
    }
    
    playershooter gameplay_sound_fx::playlocalsoundfx( #"target_hit" );
    gameplay_sound_fx::function_760dbc73d1362ab9( #"hash_73e81466a6042cb0", playershooter, shootabletarget.entity );
    playershooter damagefeedback::updatehitmarker( "standard", 0, 0, 1, undefined, 0, 0, undefined, 1 );
    
    if ( !isdefined( shootabletarget.platformlist ) )
    {
        shootabletarget.platformlist = getscriptablearray( shootabletarget.target, "targetname" );
    }
    
    foreach ( platform in shootabletarget.platformlist )
    {
        activateplatform( platform );
    }
    
    currenttimems = gettime();
    shootabletarget.var_24d8fe86ffbaa866 = currenttimems;
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    var_7ad0491d8fa29199 = modeinfo.var_21a2ecc610b6e93d;
    activedurationms = utility::function_4b74c15943231980( var_7ad0491d8fa29199 );
    endtimems = shootabletarget.var_24d8fe86ffbaa866 + activedurationms;
    countdownpartname = function_92e9a93997b4c80( var_7ad0491d8fa29199 );
    
    if ( shootabletarget.var_ef78fc544547b520 )
    {
        shootabletarget setscriptablepartstate( countdownpartname, #"active_countdown_disabled" );
        waitframe();
        shootabletarget.var_ef78fc544547b520 = 0;
    }
    
    shootabletarget utility::function_32b24db3127bff40( countdownpartname, #"active_countdown_start" );
    
    while ( shootabletarget && currenttimems < endtimems )
    {
        var_68d5c64e3eb8bc82 = endtimems - currenttimems;
        
        if ( var_68d5c64e3eb8bc82 <= 5000 && !shootabletarget.var_ef78fc544547b520 )
        {
            shootabletarget.var_ef78fc544547b520 = 1;
            
            foreach ( platform in shootabletarget.platformlist )
            {
                platform thread function_1897d2d7b97628d4( platform );
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
    
    foreach ( platform in shootabletarget.platformlist )
    {
        deactivateplatform( platform );
    }
}

// Namespace frun_shootable_target
// Params 1, eflags: 0x4
// Checksum 0x620d7f2c, Offset: 0xa9d
// Size: 0x29
function private function_f96f427346322e54( platform )
{
    platform utility::function_32b24db3127bff40( platform.pulsepart, #"pulse_lowest" );
}

// Namespace frun_shootable_target
// Params 1, eflags: 0x4
// Checksum 0x51c5d741, Offset: 0xace
// Size: 0x29
function private function_f352c9eaf9f10aec( platform )
{
    platform utility::function_32b24db3127bff40( platform.pulsepart, #"pulse_low" );
}

// Namespace frun_shootable_target
// Params 1, eflags: 0x4
// Checksum 0x1bb430d2, Offset: 0xaff
// Size: 0x29
function private function_bd28bc7891f4c31d( platform )
{
    platform utility::function_32b24db3127bff40( platform.pulsepart, #"pulse_medium" );
}

// Namespace frun_shootable_target
// Params 1, eflags: 0x4
// Checksum 0x3c565347, Offset: 0xb30
// Size: 0x29
function private function_d5375e26cced1246( platform )
{
    platform utility::function_32b24db3127bff40( platform.pulsepart, #"pulse_high" );
}

// Namespace frun_shootable_target
// Params 1, eflags: 0x4
// Checksum 0xce0e9232, Offset: 0xb61
// Size: 0x29
function private function_29da33dc9d3a3179( platform )
{
    platform utility::function_32b24db3127bff40( platform.pulsepart, #"base" );
}

// Namespace frun_shootable_target
// Params 1, eflags: 0xc
// Checksum 0x139b3996, Offset: 0xb92
// Size: 0xe6
function private function_1897d2d7b97628d4( platform )
{
    self notify( #"hash_8c4671b01e1a62f1" );
    self endon( #"hash_8c4671b01e1a62f1" );
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    pauses = modeinfo.var_ceab04bdf86e1fbc.var_3ea570ed347afd4c;
    function_f96f427346322e54( platform );
    wait pauses.longpause;
    function_f96f427346322e54( platform );
    wait pauses.longpause;
    function_f352c9eaf9f10aec( platform );
    wait pauses.medpause;
    function_f352c9eaf9f10aec( platform );
    wait pauses.medpause;
    function_bd28bc7891f4c31d( platform );
    wait pauses.shortpause;
    function_d5375e26cced1246( platform );
    wait pauses.var_9e0c6372dbdc5aaa;
    gameplay_sound_fx::function_760dbc73d1362ab9( #"hash_db459da4a605d07f", undefined, platform );
}

// Namespace frun_shootable_target
// Params 2, eflags: 0x4
// Checksum 0xf2a60810, Offset: 0xc80
// Size: 0x34
function private platform_unresolved_collision( player, penetration )
{
    if ( !isplayer( player ) || !isalive( player ) )
    {
        return;
    }
    
    frun_checkpoints::function_aae76b5997fc6288( player );
}

// Namespace frun_shootable_target
// Params 1, eflags: 0x4
// Checksum 0x97e8465d, Offset: 0xcbc
// Size: 0x46
function private deactivateplatform( platform )
{
    platform utility::function_32b24db3127bff40( #"base", platform.var_60806bfd9969f371 );
    platform utility::function_32b24db3127bff40( platform.pulsepart, #"base" );
}

// Namespace frun_shootable_target
// Params 1, eflags: 0x4
// Checksum 0x6431cc10, Offset: 0xd0a
// Size: 0x46
function private activateplatform( platform )
{
    platform utility::function_32b24db3127bff40( #"base", platform.var_86b01a3e3b36f1f8 );
    platform utility::function_32b24db3127bff40( platform.pulsepart, #"base" );
}

// Namespace frun_shootable_target
// Params 1, eflags: 0x4
// Checksum 0x5f1e9462, Offset: 0xd58
// Size: 0x36
function private function_92e9a93997b4c80( durationseconds )
{
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    return modeinfo.var_ceab04bdf86e1fbc.var_ff8a76bf4f768eee[ durationseconds ];
}

// Namespace frun_shootable_target
// Params 0, eflags: 0x4
// Checksum 0xd23bfa6, Offset: 0xd97
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

    // Namespace frun_shootable_target
    // Params 1, eflags: 0x4
    // Checksum 0x72432654, Offset: 0xeb7
    // Size: 0xe5, Type: dev
    function private function_f335b9e816cb6f9b( platform )
    {
        iprintlnbold( "<dev string:x163>" );
        function_f96f427346322e54( platform );
        wait 1.2;
        function_f96f427346322e54( platform );
        wait 1.2;
        function_f96f427346322e54( platform );
        wait 2;
        iprintlnbold( "<dev string:x16a>" );
        function_f352c9eaf9f10aec( platform );
        wait 1.2;
        function_f352c9eaf9f10aec( platform );
        wait 1.2;
        function_f352c9eaf9f10aec( platform );
        wait 2;
        iprintlnbold( "<dev string:x16e>" );
        function_bd28bc7891f4c31d( platform );
        wait 1;
        function_bd28bc7891f4c31d( platform );
        wait 1;
        function_bd28bc7891f4c31d( platform );
        wait 2;
        iprintlnbold( "<dev string:x175>" );
        function_d5375e26cced1246( platform );
        wait 1;
        function_d5375e26cced1246( platform );
        wait 1;
        function_d5375e26cced1246( platform );
    }

    // Namespace frun_shootable_target
    // Params 2, eflags: 0x4
    // Checksum 0x3b38ab15, Offset: 0xfa4
    // Size: 0x92, Type: dev
    function private function_63535c0b050d7bbb( host, args )
    {
        foreach ( platform in level.platformlist )
        {
            platform thread function_f335b9e816cb6f9b( platform );
        }
    }

    // Namespace frun_shootable_target
    // Params 2, eflags: 0x4
    // Checksum 0x87410ce7, Offset: 0x103e
    // Size: 0x92, Type: dev
    function private function_60465cee5aded23c( host, args )
    {
        foreach ( platform in level.platformlist )
        {
            platform thread function_1897d2d7b97628d4( platform );
        }
    }

    // Namespace frun_shootable_target
    // Params 2, eflags: 0x4
    // Checksum 0x625d56cf, Offset: 0x10d8
    // Size: 0x91, Type: dev
    function private function_6b1b71497b550a9b( host, args )
    {
        foreach ( platform in level.platformlist )
        {
            activateplatform( platform );
        }
    }

    // Namespace frun_shootable_target
    // Params 2, eflags: 0x4
    // Checksum 0x437c08f9, Offset: 0x1171
    // Size: 0x91, Type: dev
    function private function_cf361abe13a84248( host, args )
    {
        foreach ( platform in level.platformlist )
        {
            deactivateplatform( platform );
        }
    }

#/
