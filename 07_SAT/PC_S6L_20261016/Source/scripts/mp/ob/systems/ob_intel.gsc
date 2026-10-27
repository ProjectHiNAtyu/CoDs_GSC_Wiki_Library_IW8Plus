// scripts\mp\ob\systems\ob_intel.gsc  (hash_5162cdac792ad9fb.gscc) (size: 3579 Bytes / 0xdfb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x32de6c95 (853437589)
// size ...... 3579 (0xdfb)
// includes .. 3   (offset: 0xc77)
// strings ... 24  (offset: 0xc8f)
// dev strs .. 0   (offset: 0xdfb)
// exports ... 9   (offset: 0x8c3)
// cseg ...... 0x2d3 + 0x5f0 (0x8c3)
// imports ... 18  (offset: 0xa2b)
// animtree1 . 0   (offset: 0xdfb)
// animtree2 . 0   (offset: 0xdfb)
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\mp\overlord;

#namespace ob_intel;

// Namespace ob_intel
// Params 0
// Checksum 0xa4e61688, Offset: 0x2f1
// Size: 0x163
function init_ob_intel()
{
    if ( getdvarint( @"hash_1fbc80ee0748782c", 1 ) > 0 )
    {
        level.a_ob_intel = [];
        var_dde6b920793f245f = utility::getstructarray( "deadbolt_audio_intel", "targetname" );
        level.a_ob_intel[ "deadbolt_audio_intel" ] = function_b57d979dd382572e( "ob_intel_deadbolt_audio", var_dde6b920793f245f );
        deadbolt_radio_structs = utility::getstructarray( "deadbolt_radio_intel", "targetname" );
        level.a_ob_intel[ "deadbolt_radio_intel" ] = function_b57d979dd382572e( "ob_intel_deadbolt_radio", deadbolt_radio_structs );
        var_964ae40593a0deeb = utility::getstructarray( "terminus_audio_intel", "targetname" );
        level.a_ob_intel[ "terminus_audio_intel" ] = function_b57d979dd382572e( "ob_intel_terminus_audio", var_964ae40593a0deeb );
        var_340c90bc277ad5be = utility::getstructarray( "terminus_radio_intel", "targetname" );
        level.a_ob_intel[ "terminus_radio_intel" ] = function_b57d979dd382572e( "ob_intel_terminus_radio", var_340c90bc277ad5be );
        var_484248d5b93412a0 = utility::getstructarray( "terminus_audio_intel_warlord", "targetname" );
        level.ob.var_b4cffd23970a7f45 = var_484248d5b93412a0;
        level.a_ob_intel[ "note_intel" ] = getentitylessscriptablearray( "note_intel", #targetname );
        thread spawn_note_intel();
        scriptable::scriptable_addusedcallback( &function_96eed1c6d9490130 );
    }
}

// Namespace ob_intel
// Params 2, eflags: 0x4
// Checksum 0x6435a714, Offset: 0x45c
// Size: 0x11c
function private function_b57d979dd382572e( scriptable_name, struct_array )
{
    scriptable_array = [];
    
    foreach ( struct in struct_array )
    {
        if ( isdefined( struct.season ) && int( struct.season ) > getdvarint( @"hash_ddc349005b4d9cbb", 0 ) )
        {
            return;
        }
        
        radio = spawnscriptable( scriptable_name, struct.origin, struct.angles );
        
        if ( isdefined( struct.script_noteworthy ) )
        {
            radio.overlord_ref = struct.script_noteworthy;
            
            /#
                radio thread intel_debug_text();
            #/
        }
        
        scriptable_array[ scriptable_array.size ] = radio;
    }
    
    return scriptable_array;
}

// Namespace ob_intel
// Params 0, eflags: 0x4
// Checksum 0x2ba6d8f3, Offset: 0x581
// Size: 0xae
function private spawn_note_intel()
{
    if ( isdefined( level.a_ob_intel[ "note_intel" ] ) )
    {
        foreach ( note in level.a_ob_intel[ "note_intel" ] )
        {
            note setscriptablepartstate( "state", note.script_noteworthy );
            
            /#
                note thread note_intel_debug_text();
            #/
        }
    }
}

// Namespace ob_intel
// Params 0
// Checksum 0xa0ff5a96, Offset: 0x637
// Size: 0x4e
function intel_debug_text()
{
    while ( true )
    {
        if ( getdvarint( @"debug_intel", 0 ) )
        {
            /#
                print3d( self.origin + ( 0, 0, 10 ), self.overlord_ref, undefined, undefined, 0.5, undefined, 1 );
            #/
        }
        
        waitframe();
    }
}

// Namespace ob_intel
// Params 0
// Checksum 0x34730db8, Offset: 0x68d
// Size: 0x4e
function note_intel_debug_text()
{
    while ( true )
    {
        if ( getdvarint( @"debug_intel", 0 ) )
        {
            /#
                print3d( self.origin + ( 0, 0, 10 ), self.script_noteworthy, undefined, undefined, 0.5, undefined, 1 );
            #/
        }
        
        waitframe();
    }
}

// Namespace ob_intel
// Params 6
// Checksum 0x8e42b154, Offset: 0x6e3
// Size: 0xd3
function function_96eed1c6d9490130( instance, part, state, player, bautouse, usestring )
{
    if ( !isdefined( instance ) || !issubstr( instance.type, "ob_intel" ) )
    {
        return;
    }
    
    instance setscriptablepartstate( "state", "unusable" );
    function_332e655b8aca6130( instance );
    wait 1;
    
    if ( isdefined( instance.overlord_ref ) )
    {
        overlord::playconversation( instance.overlord_ref, undefined, undefined, 0, instance.origin + ( 0, 0, 10 ), "overlord_intel" );
    }
    
    instance setscriptablepartstate( "intel_sfx", "stop" );
    instance thread function_42ac30af53617d51();
}

// Namespace ob_intel
// Params 0, eflags: 0x4
// Checksum 0xced9cea, Offset: 0x7be
// Size: 0x21
function private function_42ac30af53617d51()
{
    level endon( #"game_ended" );
    wait 5;
    self setscriptablepartstate( "state", "usable" );
}

// Namespace ob_intel
// Params 1, eflags: 0x4
// Checksum 0x9f2b8fe3, Offset: 0x7e7
// Size: 0xdc
function private function_332e655b8aca6130( instance )
{
    switch ( instance.overlord_ref )
    {
        case #"hash_450ee5bc3bffa66b":
            instance setscriptablepartstate( "intel_sfx", "start_mistake" );
            break;
        case #"hash_25899687670ee5e6":
            instance setscriptablepartstate( "intel_sfx", "start_mobilearmor" );
            break;
        case #"hash_b04f01e7240b4bf6":
            instance setscriptablepartstate( "intel_sfx", "start_chaosdown" );
            break;
        case #"hash_77e01a6cb42f6303":
            instance setscriptablepartstate( "intel_sfx", "start_testing" );
            break;
        case #"hash_a202261611d5d72":
            instance setscriptablepartstate( "intel_sfx", "start_whoisthisguy" );
            break;
        default:
            instance setscriptablepartstate( "intel_sfx", "start" );
            break;
    }
}

