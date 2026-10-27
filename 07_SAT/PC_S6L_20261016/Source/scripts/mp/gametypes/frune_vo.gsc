// scripts\mp\gametypes\frune_vo.gsc  (hash_3bcc9fb3939013d2.gscc) (size: 5470 Bytes / 0x155e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2cbd80c5 (750616773)
// size ...... 5470 (0x155e)
// includes .. 5   (offset: 0x140a)
// strings ... 13  (offset: 0x1432)
// dev strs .. 8   (offset: 0x14ee)
// exports ... 19  (offset: 0xcae)
// cseg ...... 0x158 + 0xb56 (0xcae)
// imports ... 36  (offset: 0xfa6)
// animtree1 . 0   (offset: 0x155e)
// animtree2 . 0   (offset: 0x155e)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\trigger;

#namespace frune_vo;

// Namespace frune_vo
// Params 0
// Checksum 0xefcc4c2c, Offset: 0x176
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

// Namespace frune_vo
// Params 1, eflags: 0x4
// Checksum 0x17b6bcee, Offset: 0x25d
// Size: 0x2f
function private function_b5e8f72faa51650d( params )
{
    thread function_6d3a60b4241c86fe();
    thread function_7c7cdc93fac3b8bf();
    thread function_d4f912ae2281c530();
    thread function_6c6a914ec3cd7e65();
    thread function_f144812e6346f249();
}

// Namespace frune_vo
// Params 0, eflags: 0x4
// Checksum 0x930c41ea, Offset: 0x294
// Size: 0x1cc
function private function_6e7226e19fa08bc5()
{
    modeinfo = game[ #"frune_tuning" ];
    modeinfo.var_24471a67911d2acb = getdvarint( @"hash_a0622946523d9eae", modeinfo.frune_bundle.var_987051861db33b85 ?? 7000 );
    modeinfo.var_4ac4ecc908907230 = getdvarfloat( @"hash_4b3b42dd1bee1c6c", modeinfo.frune_bundle.var_64bf48840b7332e9 ?? 0.5 );
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

// Namespace frune_vo
// Params 2, eflags: 0x4
// Checksum 0x25f12e5e, Offset: 0x468
// Size: 0xda
function private function_e0e7d621712d6072( triggeringent, enttrigger )
{
    if ( enttrigger.script_noteworthy == "secret_path_complete_trigger" )
    {
        modeinfo = game[ #"frune_tuning" ];
        
        if ( self.freeruninfo.var_b8ec11d5f312daf5.script_noteworthy == "secret_path_trigger" && self.freeruninfo.var_cca8f3cdd35916d8 && gettime() - self.freeruninfo.var_cca8f3cdd35916d8 < modeinfo.var_24471a67911d2acb )
        {
            function_62af58177c405e21();
        }
    }
    
    self.freeruninfo.var_b8ec11d5f312daf5 = enttrigger;
    self.freeruninfo.var_cca8f3cdd35916d8 = gettime();
}

// Namespace frune_vo
// Params 2, eflags: 0x4
// Checksum 0xe11855d5, Offset: 0x54a
// Size: 0x29, Type: bool
function private function_2338094b60c86749( triggeringent, enttrigger )
{
    return !isplayer( triggeringent ) || !player::isreallyalive( triggeringent );
}

// Namespace frune_vo
// Params 0, eflags: 0x4
// Checksum 0xb4f95530, Offset: 0x57c
// Size: 0x51
function private function_62af58177c405e21()
{
    modeinfo = game[ #"frune_tuning" ];
    
    if ( randomfloat( 1 ) < modeinfo.var_4ac4ecc908907230 )
    {
        dialog::leaderdialogonplayer( modeinfo.var_9193c4e5a0063ed2[ randomint( modeinfo.var_9193c4e5a0063ed2.size ) ] );
    }
}

// Namespace frune_vo
// Params 0, eflags: 0x4
// Checksum 0x99b2b8fc, Offset: 0x5d5
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

// Namespace frune_vo
// Params 2, eflags: 0x4
// Checksum 0x6585d689, Offset: 0x785
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

// Namespace frune_vo
// Params 0, eflags: 0xc
// Checksum 0x4c949549, Offset: 0x7ea
// Size: 0x4f
function private function_6d3a60b4241c86fe()
{
    self notify( #"hash_599777acfdacf8e4" );
    self endon( #"hash_599777acfdacf8e4" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self waittill( #"frun_killzone_death" );
    dialog::leaderdialogonplayer( #"first_death" );
}

// Namespace frune_vo
// Params 0, eflags: 0xc
// Checksum 0x80dd0d71, Offset: 0x841
// Size: 0x84
function private function_7c7cdc93fac3b8bf()
{
    self notify( #"hash_525b3c6c5c1d9955" );
    self endon( #"hash_525b3c6c5c1d9955" );
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

// Namespace frune_vo
// Params 0, eflags: 0xc
// Checksum 0x9385df67, Offset: 0x8cd
// Size: 0x64
function private function_d4f912ae2281c530()
{
    self notify( #"hash_50338bea61b704a3" );
    self endon( #"hash_50338bea61b704a3" );
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

// Namespace frune_vo
// Params 0, eflags: 0xc
// Checksum 0xd877f094, Offset: 0x939
// Size: 0x13f
function private function_6c6a914ec3cd7e65()
{
    self notify( #"hash_dc7e378e3a80dd1b" );
    self endon( #"hash_dc7e378e3a80dd1b" );
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

// Namespace frune_vo
// Params 0, eflags: 0xc
// Checksum 0x88a0217b, Offset: 0xa80
// Size: 0xc8
function private function_8387cf0f03fb6346()
{
    self notify( #"hash_5dd2ef7e630787d1" );
    self endon( #"hash_5dd2ef7e630787d1" );
    level waittill( #"game_ended" );
    
    foreach ( player in level.players )
    {
        if ( player && !player.freeruninfo.var_328df64682b9ec5c )
        {
            player dialog::leaderdialogonplayer( #"match_timeout" );
        }
    }
}

// Namespace frune_vo
// Params 1, eflags: 0x4
// Checksum 0xcfd4fa9b, Offset: 0xb50
// Size: 0x39, Type: bool
function private function_d88190283f548b0a( bit )
{
    playedbitmask = int( self getplayerdata( "mp", "frunTutorialVoPlayedBitmask" ) ?? 0 );
    return ( playedbitmask & 1 << bit ) != 0;
}

// Namespace frune_vo
// Params 1, eflags: 0x4
// Checksum 0xf4669297, Offset: 0xb92
// Size: 0x47
function private function_6edf51a291cf6be2( bit )
{
    playedbitmask = int( self getplayerdata( "mp", "frunTutorialVoPlayedBitmask" ) ?? 0 );
    self setplayerdata( "mp", "frunTutorialVoPlayedBitmask", playedbitmask | 1 << bit );
}

// Namespace frune_vo
// Params 0, eflags: 0xc
// Checksum 0xd781f7c9, Offset: 0xbe1
// Size: 0x5a
function private function_f144812e6346f249()
{
    self notify( #"hash_f224a10cb89c71f1" );
    self endon( #"hash_f224a10cb89c71f1" );
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

    // Namespace frune_vo
    // Params 2, eflags: 0x4
    // Checksum 0xc6932af4, Offset: 0xc43
    // Size: 0x2a, Type: dev
    function private function_d908b51fb7a574e6( host, args )
    {
        host setplayerdata( "<dev string:xfa>", "<dev string:xfd>", 0 );
    }

    // Namespace frune_vo
    // Params 2, eflags: 0x4
    // Checksum 0x3ad36c82, Offset: 0xc75
    // Size: 0x39, Type: dev
    function private function_e5a89a03fa4934ba( host, args )
    {
        allbits = 31;
        host setplayerdata( "<dev string:xfa>", "<dev string:xfd>", allbits );
    }

#/
