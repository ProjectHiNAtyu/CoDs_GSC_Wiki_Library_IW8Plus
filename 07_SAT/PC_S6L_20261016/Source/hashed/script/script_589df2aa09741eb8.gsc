// script_589df2aa09741eb8  (hash_589df2aa09741eb8.gscc) (size: 3932 Bytes / 0xf5c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9c2458fd (2619627773)
// size ...... 3932 (0xf5c)
// includes .. 5   (offset: 0xd30)
// strings ... 13  (offset: 0xd58)
// dev strs .. 24  (offset: 0xdf4)
// exports ... 6   (offset: 0x9b8)
// cseg ...... 0x159 + 0x85f (0x9b8)
// imports ... 22  (offset: 0xaa8)
// animtree1 . 0   (offset: 0xf5c)
// animtree2 . 0   (offset: 0xf5c)
#using script_44280f644740bac;
#using scripts\common\utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\gametypes\frune_free_run_evo;

#namespace namespace_596312de8f8f3064;

// Namespace namespace_596312de8f8f3064
// Params 0
// Checksum 0x286f3ef1, Offset: 0x177
// Size: 0x612
function init()
{
    level endon( #"game_ended" );
    utility::flag_wait( "scriptables_ready" );
    modeinfo = game[ #"frune_tuning" ];
    
    if ( !isdefined( modeinfo.frune_bundle ) )
    {
        modeinfo.frune_bundle = game_utility_mp::function_4b7180ed8c2e9742( "gametypebundle_frune" );
    }
    
    modeinfo.var_56b190e460735239 = getdvarint( @"hash_1c728887cadb3d4", modeinfo.frune_bundle.var_8e0a79f66f5e734f ?? 0 );
    modeinfo.biomeinfo = {};
    
    if ( !isdefined( modeinfo.biomeinfo.var_ab8a0a6c56c28b2c ) )
    {
        modeinfo.biomeinfo.var_ab8a0a6c56c28b2c = [ "biome_water":( 0, 1, 1 ), "biome_snow_water":( 0, 0, 1 ), "biome_snow":( 1, 1, 1 ), "biome_sand_snow":( 1, 0.5, 0 ), "biome_sand":( 1, 1, 0 ), "biome_none_sand":( 1, 1, 0 ), "biome_none":( 0.75, 0.75, 0.75 ) ];
    }
    
    modeinfo.biomeinfo.biometriggers = getentarray( "biome", #script_noteworthy );
    
    foreach ( trigger in modeinfo.biomeinfo.biometriggers )
    {
        trigger.biome = trigger.targetname;
        trigger.var_5a316e72c750d457 = modeinfo.biomeinfo.var_ab8a0a6c56c28b2c[ trigger.biome ];
        trigger::makeenterexittrigger( trigger, &biomeentered );
    }
    
    modeinfo.biomeinfo.var_32cc2f071aebbae = utility::array_combine_multiple( [ getscriptablearray( "scriptable_mp_sat_free_run_evo_dynamic_portal", #classname ) ] );
    
    if ( modeinfo.var_56b190e460735239 )
    {
        foreach ( biometouched in modeinfo.biomeinfo.var_32cc2f071aebbae )
        {
            foreach ( trigger in modeinfo.biomeinfo.biometriggers )
            {
                if ( trigger istouching( biometouched ) )
                {
                    biometouched utility::function_32b24db3127bff40( #"biome_effect", trigger.biome );
                    break;
                }
            }
        }
    }
    
    /#
        helptext = "<dev string:x24>";
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"fre" ][ #"registercommand" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( "<dev string:x4d>", "<dev string:x5d>", &frune_free_run_evo::function_d73a3ff7943a2f95, helptext, "<dev string:x61>", [ "<dev string:x67>", "<dev string:x7a>" ] );
        }
        
        helptext = "<dev string:x85>";
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"fre" ][ #"registercommand" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( "<dev string:xae>", "<dev string:x5d>", &frune_free_run_evo::function_d73a3ff7943a2f95, helptext, "<dev string:x61>", [ "<dev string:x67>", "<dev string:xbe>" ] );
        }
        
        helptext = "<dev string:xc9>";
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"fre" ][ #"registercommand" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( "<dev string:xfb>", "<dev string:x5d>", &frune_free_run_evo::function_d73a3ff7943a2f95, helptext, "<dev string:x61>", [ "<dev string:x67>", "<dev string:x10f>" ] );
        }
        
        helptext = "<dev string:x11f>";
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"fre" ][ #"registercommand" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( "<dev string:x148>", "<dev string:x5d>", &frune_free_run_evo::function_d73a3ff7943a2f95, helptext, "<dev string:x61>", [ "<dev string:x67>", "<dev string:x158>" ] );
        }
        
        helptext = "<dev string:x163>";
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"fre" ][ #"registercommand" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( "<dev string:x196>", "<dev string:x5d>", &frune_free_run_evo::function_d73a3ff7943a2f95, helptext, "<dev string:x61>", [ "<dev string:x67>", "<dev string:x1ab>" ] );
        }
        
        helptext = "<dev string:x1bc>";
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"fre" ][ #"registercommand" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( "<dev string:x1e6>", "<dev string:x5d>", &frune_free_run_evo::function_d73a3ff7943a2f95, helptext, "<dev string:x61>", [ "<dev string:x67>", "<dev string:x1f7>" ] );
        }
        
        helptext = "<dev string:x203>";
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"fre" ][ #"registercommand" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( "<dev string:x22c>", "<dev string:x5d>", &function_e39baed314da06d, helptext, "<dev string:x61>", undefined );
        }
    #/
}

// Namespace namespace_596312de8f8f3064
// Params 2, eflags: 0x4
// Checksum 0x5f091bf9, Offset: 0x791
// Size: 0x5b
function private biomeentered( player, trigger )
{
    if ( !isplayer( player ) || !isalive( player ) )
    {
        return;
    }
    
    player utility::function_32b24db3127bff40( "frune_biome_effect", trigger.biome );
    setglobalsoundcontext( "freerun_biome", trigger.biome, 1 );
}

/#

    // Namespace namespace_596312de8f8f3064
    // Params 2, eflags: 0x4
    // Checksum 0x78a3c23f, Offset: 0x7f4
    // Size: 0x5a, Type: dev
    function private function_e39baed314da06d( host, args )
    {
        var_e192ef1147f518ac = namespace_ec33f26de741e14e::function_7fb3afaa98ee9eeb( "<dev string:x5d>" );
        var_e192ef1147f518ac.var_19f45166adf5c70e = !var_e192ef1147f518ac.var_19f45166adf5c70e;
        level thread function_3402a2986319570d( var_e192ef1147f518ac.var_19f45166adf5c70e );
    }

    // Namespace namespace_596312de8f8f3064
    // Params 1, eflags: 0xc
    // Checksum 0xa4d8ca22, Offset: 0x856
    // Size: 0xed, Type: dev
    function private function_3402a2986319570d( enabled )
    {
        self notify( #"hash_315598cc0dd4578c" );
        self endon( #"hash_315598cc0dd4578c" );
        
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
                return;
            }
            
            foreach ( trigger in modeinfo.biomeinfo.biometriggers )
            {
                function_100c5c3149a47bb4( trigger );
            }
            
            waitframe();
        }
    }

    // Namespace namespace_596312de8f8f3064
    // Params 1, eflags: 0x4
    // Checksum 0x7af96016, Offset: 0x94b
    // Size: 0x6d, Type: dev
    function private function_100c5c3149a47bb4( trigger )
    {
        drawtrigger( trigger, trigger.var_5a316e72c750d457, 1 );
        print3d( trigger.origin, "<dev string:x23d>" + trigger.biome, trigger.var_5a316e72c750d457 ?? ( 0.75, 0.75, 0.75 ), 1, 1, 1, 1 );
    }

#/
