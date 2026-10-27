// scripts\mp\gametypes\frun_vo.gsc  (hash_04ca3697a73445ff.gscc) (size: 5499 Bytes / 0x157b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb47429d2 (3027511762)
// size ...... 5499 (0x157b)
// includes .. 6   (offset: 0x141f)
// strings ... 13  (offset: 0x144f)
// dev strs .. 8   (offset: 0x150b)
// exports ... 19  (offset: 0xc9f)
// cseg ...... 0x158 + 0xb47 (0xc9f)
// imports ... 37  (offset: 0xf97)
// animtree1 . 0   (offset: 0x157b)
// animtree2 . 0   (offset: 0x157b)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\gametypes\frun_free_run;

#namespace frun_vo;

// Namespace frun_vo
// Params 0
// Checksum 0xc3a3172b, Offset: 0x176
// Size: 0xdf
function init()
{
    function_6e7226e19fa08bc5();
    function_f74fc4bd719c32e4();
    level.var_697ba496dd069d1b = 1;
    level thread function_8387cf0f03fb6346();
    callback::add( #"player_connect", &function_b5e8f72faa51650d );
    
    /#
        helptext = "<dev string:x24>";
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"fre" ][ #"registercommand" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( "<dev string:x6b>", "<dev string:x86>", &function_d908b51fb7a574e6, helptext, "<dev string:x8a>", undefined );
        }
        
        helptext = "<dev string:x8d>";
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"fre" ][ #"registercommand" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( "<dev string:xe1>", "<dev string:x86>", &function_e5a89a03fa4934ba, helptext, "<dev string:x8a>", undefined );
        }
    #/
}

// Namespace frun_vo
// Params 1, eflags: 0x4
// Checksum 0x9bb6e735, Offset: 0x25d
// Size: 0x2f
function private function_b5e8f72faa51650d( params )
{
    thread function_6d3a60b4241c86fe();
    thread function_7c7cdc93fac3b8bf();
    thread function_d4f912ae2281c530();
    thread function_6c6a914ec3cd7e65();
    thread function_f144812e6346f249();
}

// Namespace frun_vo
// Params 0, eflags: 0x4
// Checksum 0xe1d874e8, Offset: 0x294
// Size: 0x1c7
function private function_6e7226e19fa08bc5()
{
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    modeinfo.var_24471a67911d2acb = getdvarint( @"hash_fc105ff30f496381", modeinfo.frun_bundle.var_3871c71ee0d70390 ?? 7000 );
    modeinfo.var_4ac4ecc908907230 = getdvarfloat( @"hash_cb189c57153627c5", modeinfo.frun_bundle.var_e1f0c45f087613be ?? 0.5 );
    modeinfo.var_9193c4e5a0063ed2 = [ #"hidden_path", #"impressive" ];
    secret_path_triggers_start = getentarray( "secret_path_trigger", "script_noteworthy" );
    secret_path_triggers_end = getentarray( "secret_path_complete_trigger", "script_noteworthy" );
    
    foreach ( trigger in secret_path_triggers_start )
    {
        trigger::makeenterexittrigger( trigger, &function_e0e7d621712d6072, undefined, undefined, undefined, &function_2338094b60c86749 );
    }
    
    foreach ( trigger in secret_path_triggers_end )
    {
        trigger::makeenterexittrigger( trigger, &function_e0e7d621712d6072, undefined, undefined, undefined, &function_2338094b60c86749 );
    }
}

// Namespace frun_vo
// Params 2, eflags: 0x4
// Checksum 0xabc642f4, Offset: 0x463
// Size: 0xd5
function private function_e0e7d621712d6072( triggeringent, enttrigger )
{
    if ( enttrigger.script_noteworthy == "secret_path_complete_trigger" )
    {
        modeinfo = frun_free_run::function_97dc8f6dff0a9255();
        
        if ( self.freeruninfo.var_b8ec11d5f312daf5.script_noteworthy == "secret_path_trigger" && self.freeruninfo.var_cca8f3cdd35916d8 && gettime() - self.freeruninfo.var_cca8f3cdd35916d8 < modeinfo.var_24471a67911d2acb )
        {
            function_62af58177c405e21();
        }
    }
    
    self.freeruninfo.var_b8ec11d5f312daf5 = enttrigger;
    self.freeruninfo.var_cca8f3cdd35916d8 = gettime();
}

// Namespace frun_vo
// Params 2, eflags: 0x4
// Checksum 0x6d180e0e, Offset: 0x540
// Size: 0x29, Type: bool
function private function_2338094b60c86749( triggeringent, enttrigger )
{
    return !isplayer( triggeringent ) || !player::isreallyalive( triggeringent );
}

// Namespace frun_vo
// Params 0, eflags: 0x4
// Checksum 0x9aa13946, Offset: 0x572
// Size: 0x4c
function private function_62af58177c405e21()
{
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    
    if ( randomfloat( 1 ) < modeinfo.var_4ac4ecc908907230 )
    {
        dialog::leaderdialogonplayer( modeinfo.var_9193c4e5a0063ed2[ randomint( modeinfo.var_9193c4e5a0063ed2.size ) ] );
    }
}

// Namespace frun_vo
// Params 0, eflags: 0x4
// Checksum 0x15b2e327, Offset: 0x5c6
// Size: 0x1a8
function private function_f74fc4bd719c32e4()
{
    var_dead930bc3c4635e = [ "progress_90":{ #bit:undefined, #voref:#"progress_90" }, "progress_50":{ #bit:undefined, #voref:#"progress_50" }, "progress_25":{ #bit:undefined, #voref:#"progress_25" }, "first_target_shooting":{ #bit:2, #voref:#"first_target_shooting" }, "first_dive":{ #bit:1, #voref:#"first_dive" }, "first_wall_jump":{ #bit:0, #voref:#"first_wall_jump" } ];
    
    foreach ( noteworthy, entry in var_dead930bc3c4635e )
    {
        trigger = getent( noteworthy, "script_noteworthy" );
        
        if ( trigger )
        {
            trigger.var_13d7ea3fa7724155 = entry.voref;
            trigger.var_2dd1483eff997493 = entry.bit;
            trigger::makeenterexittrigger( trigger, &function_91d6fd80e8c2f530, undefined, undefined, undefined, &function_2338094b60c86749 );
        }
    }
}

// Namespace frun_vo
// Params 2, eflags: 0x4
// Checksum 0x49ea8d8e, Offset: 0x776
// Size: 0x5d
function private function_91d6fd80e8c2f530( triggeringent, enttrigger )
{
    if ( isdefined( enttrigger.var_2dd1483eff997493 ) )
    {
        if ( function_d88190283f548b0a( enttrigger.var_2dd1483eff997493 ) )
        {
            return;
        }
        
        function_6edf51a291cf6be2( enttrigger.var_2dd1483eff997493 );
    }
    
    dialog::leaderdialogonplayer( enttrigger.var_13d7ea3fa7724155 );
}

// Namespace frun_vo
// Params 0, eflags: 0xc
// Checksum 0x60fbce4e, Offset: 0x7db
// Size: 0x4f
function private function_6d3a60b4241c86fe()
{
    self notify( #"hash_fd2fa518354ae30d" );
    self endon( #"hash_fd2fa518354ae30d" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self waittill( #"frun_killzone_death" );
    dialog::leaderdialogonplayer( #"first_death" );
}

// Namespace frun_vo
// Params 0, eflags: 0xc
// Checksum 0xacb25676, Offset: 0x832
// Size: 0x84
function private function_7c7cdc93fac3b8bf()
{
    self notify( #"hash_558fdcd1bbd7c5c0" );
    self endon( #"hash_558fdcd1bbd7c5c0" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( function_d88190283f548b0a( 3 ) )
    {
        return;
    }
    
    while ( true )
    {
        self waittill( #"equipment_given", ref );
        
        if ( ref == "equip_grappling_hook" )
        {
            function_6edf51a291cf6be2( 3 );
            dialog::leaderdialogonplayer( #"hash_402a00bfd92890ba" );
            return;
        }
    }
}

// Namespace frun_vo
// Params 0, eflags: 0xc
// Checksum 0xbfea8460, Offset: 0x8be
// Size: 0x64
function private function_d4f912ae2281c530()
{
    self notify( #"hash_d0acc349d3c99df2" );
    self endon( #"hash_d0acc349d3c99df2" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( function_d88190283f548b0a( 4 ) )
    {
        return;
    }
    
    self waittill( #"hash_2d24f0b2e15c3f12" );
    function_6edf51a291cf6be2( 4 );
    dialog::leaderdialogonplayer( #"hash_1bc06b91ad858b31" );
}

// Namespace frun_vo
// Params 0, eflags: 0xc
// Checksum 0xf418ab93, Offset: 0x92a
// Size: 0x13f
function private function_6c6a914ec3cd7e65()
{
    self notify( #"hash_872aa369376e7bd4" );
    self endon( #"hash_872aa369376e7bd4" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self waittill( #"hash_9e9bf21e01b8eb5", place );
    var_cc5e2854e7317e16 = self.freeruninfo.var_cc5e2854e7317e16;
    var_9d3bc37eee7f5ce1 = self.freeruninfo.var_9d3bc37eee7f5ce1;
    
    if ( place == 1 && var_cc5e2854e7317e16 )
    {
        dialog::leaderdialogonplayer( #"hash_619e2916c3f5de5e" );
        return;
    }
    
    if ( var_cc5e2854e7317e16 )
    {
        dialog::leaderdialogonplayer( #"hash_ca18082d1ca93842" );
        return;
    }
    
    if ( var_9d3bc37eee7f5ce1 )
    {
        dialog::leaderdialogonplayer( #"hash_18de9c0f870ec35b" );
        return;
    }
    
    if ( place == 1 )
    {
        dialog::leaderdialogonplayer( #"hash_eb764ca715a0725e" );
        return;
    }
    
    if ( place <= 3 )
    {
        dialog::leaderdialogonplayer( #"hash_7232bc309cc2935d" );
        return;
    }
    
    if ( place <= 8 )
    {
        dialog::leaderdialogonplayer( #"hash_a3fe2b30b858d73a" );
        return;
    }
    
    if ( place <= 10 )
    {
        dialog::leaderdialogonplayer( #"hash_6fe8755dbf7433ca" );
    }
}

// Namespace frun_vo
// Params 0, eflags: 0xc
// Checksum 0xa4cf7a7c, Offset: 0xa71
// Size: 0xc8
function private function_8387cf0f03fb6346()
{
    self notify( #"hash_e44c75527a7d66" );
    self endon( #"hash_e44c75527a7d66" );
    level waittill( #"game_ended" );
    
    foreach ( player in level.players )
    {
        if ( player && !player.freeruninfo.var_328df64682b9ec5c )
        {
            player dialog::leaderdialogonplayer( #"match_timeout" );
        }
    }
}

// Namespace frun_vo
// Params 1, eflags: 0x4
// Checksum 0xe3bba19c, Offset: 0xb41
// Size: 0x39, Type: bool
function private function_d88190283f548b0a( bit )
{
    playedbitmask = int( self getplayerdata( "mp", "frunTutorialVoPlayedBitmask" ) ?? 0 );
    return ( playedbitmask & 1 << bit ) != 0;
}

// Namespace frun_vo
// Params 1, eflags: 0x4
// Checksum 0x7866c94c, Offset: 0xb83
// Size: 0x47
function private function_6edf51a291cf6be2( bit )
{
    playedbitmask = int( self getplayerdata( "mp", "frunTutorialVoPlayedBitmask" ) ?? 0 );
    self setplayerdata( "mp", "frunTutorialVoPlayedBitmask", playedbitmask | 1 << bit );
}

// Namespace frun_vo
// Params 0, eflags: 0xc
// Checksum 0xfbeeacce, Offset: 0xbd2
// Size: 0x5a
function private function_f144812e6346f249()
{
    self notify( #"hash_2741d3ea02c0c934" );
    self endon( #"hash_2741d3ea02c0c934" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    utility::ent_flag_wait( "loading_done" );
    wait 0.5;
    
    if ( !self )
    {
        return;
    }
    
    dialog::leaderdialogonplayer( #"prematch" );
}

/#

    // Namespace frun_vo
    // Params 2, eflags: 0x4
    // Checksum 0x4a93712f, Offset: 0xc34
    // Size: 0x2a, Type: dev
    function private function_d908b51fb7a574e6( host, args )
    {
        host setplayerdata( "<dev string:xfa>", "<dev string:xfd>", 0 );
    }

    // Namespace frun_vo
    // Params 2, eflags: 0x4
    // Checksum 0xb6d33759, Offset: 0xc66
    // Size: 0x39, Type: dev
    function private function_e5a89a03fa4934ba( host, args )
    {
        allbits = 31;
        host setplayerdata( "<dev string:xfa>", "<dev string:xfd>", allbits );
    }

#/
