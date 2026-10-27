// script_20c724312d257031  (hash_20c724312d257031.gscc) (size: 2110 Bytes / 0x83e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe4d65668 (3839252072)
// size ...... 2110 (0x83e)
// includes .. 6   (offset: 0x802)
// strings ... 1   (offset: 0x832)
// dev strs .. 0   (offset: 0x83e)
// exports ... 5   (offset: 0x522)
// cseg ...... 0x6d + 0x4b5 (0x522)
// imports ... 18  (offset: 0x5ea)
// animtree1 . 0   (offset: 0x83e)
// animtree2 . 0   (offset: 0x83e)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\mp\common\utility\teams;

#namespace activity_participation_mp;

// Namespace activity_participation_mp
// Params 0, eflags: 0x5
// Checksum 0x61ac691f, Offset: 0x8b
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"activity_participation_mp", undefined, &function_a3d0837ca4789f41, undefined );
}

// Namespace activity_participation_mp
// Params 0, eflags: 0x4
// Checksum 0xc6f67047, Offset: 0xac
// Size: 0x17
function private function_a3d0837ca4789f41()
{
    callback::add( #"player_assimilated", &function_218136c9f8bcd82b );
}

// Namespace activity_participation_mp
// Params 1, eflags: 0x4
// Checksum 0x39483f52, Offset: 0xcb
// Size: 0x219
function private function_218136c9f8bcd82b( params )
{
    var_4949085b18f0d529 = self;
    oldteamindex = params.oldteam;
    newteamindex = params.newteam;
    
    if ( isdefined( level.activities.nexusoverrides[ 11 ] ) )
    {
        activity_common::function_2ba08ba0c0544a1a( 11, [ var_4949085b18f0d529 ], 1 );
        return;
    }
    
    squad = teams::getsquadmates( var_4949085b18f0d529.team, var_4949085b18f0d529.sessionsquadid, 0 );
    
    if ( squad.size >= 2 )
    {
        var_5e05b63a19f5ae26 = squad[ 0 ];
        
        if ( var_5e05b63a19f5ae26 == var_4949085b18f0d529 )
        {
            var_5e05b63a19f5ae26 = squad[ 1 ];
        }
        
        function_e23f9e3a43314464( var_4949085b18f0d529, var_5e05b63a19f5ae26 );
        var_670b784a3e3985b = activity_participation::function_e8eabd79cc49540e( var_5e05b63a19f5ae26 );
        var_3dfe43044e41aeea = activity_participation::function_e8eabd79cc49540e( var_4949085b18f0d529 );
        var_7c15e5bcf619ea1d = arraycombine( var_670b784a3e3985b, var_3dfe43044e41aeea );
        
        foreach ( activityinfostruct in var_7c15e5bcf619ea1d )
        {
            activityinstance = level.activities.instances[ activityinfostruct.instanceid ];
            
            if ( activity_definition_utils::function_f35ffc5fdda1d8eb( activityinstance ) )
            {
                foreach ( squadmember in squad )
                {
                    if ( !activity_participation::function_e7fc1202ac164928( activityinstance, squadmember ) )
                    {
                        activity_participation::function_bc67362dace4370c( activityinstance, squadmember, "PlayerJoinedSquad" );
                    }
                }
            }
        }
    }
}

// Namespace activity_participation_mp
// Params 2, eflags: 0x4
// Checksum 0x3a0f6a85, Offset: 0x2ec
// Size: 0x236
function private function_e23f9e3a43314464( var_4949085b18f0d529, var_5e05b63a19f5ae26 )
{
    var_161f8e4ef80bbb8b = activity_participation::function_a2ffa98b763c335d( var_5e05b63a19f5ae26 );
    var_c122608a24fa3896 = activity_participation::function_e8eabd79cc49540e( var_4949085b18f0d529 );
    var_98181469a7039879 = [];
    var_39b340526224c12e = [];
    
    foreach ( instanceid, activityinfostruct in var_c122608a24fa3896 )
    {
        activityinstance = level.activities.instances[ instanceid ];
        activityinstancecategory = activityinstance.category;
        
        if ( activity_definition_utils::function_6e5624d15e574a2a( activityinstance ) && activity_definition_utils::function_f35ffc5fdda1d8eb( activityinstance ) )
        {
            if ( var_161f8e4ef80bbb8b activity_participation::function_a63ffe2063075fb4( activityinstancecategory ) )
            {
                var_98181469a7039879[ var_98181469a7039879.size ] = activityinstance;
            }
        }
        
        if ( var_161f8e4ef80bbb8b activity_participation::function_c9d70465e10a69e1( activityinstancecategory ) )
        {
            if ( var_39b340526224c12e[ activityinstancecategory ] )
            {
                var_98181469a7039879[ var_98181469a7039879.size ] = activityinstance;
                continue;
            }
            
            foreach ( var_8ff6414299010165 in var_161f8e4ef80bbb8b.var_ed75c40304082166[ activityinstancecategory ] )
            {
                if ( activity_definition_utils::function_f35ffc5fdda1d8eb( var_8ff6414299010165 ) )
                {
                    var_39b340526224c12e[ activityinstancecategory ] = 1;
                    var_98181469a7039879[ var_98181469a7039879.size ] = activityinstance;
                    break;
                }
            }
        }
    }
    
    foreach ( var_a1268bd94535e71e in var_98181469a7039879 )
    {
        activity_participation::function_61aa2b2879f2c0a2( var_a1268bd94535e71e, var_4949085b18f0d529, 1 );
    }
}

