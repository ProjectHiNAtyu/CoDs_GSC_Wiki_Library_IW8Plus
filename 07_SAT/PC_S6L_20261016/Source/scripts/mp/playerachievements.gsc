// scripts\mp\playerachievements.gsc  (hash_59b463d131b5400b.gscc) (size: 1554 Bytes / 0x612 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe8e9d137 (3907637559)
// size ...... 1554 (0x612)
// includes .. 0   (offset: 0x5d2)
// strings ... 1   (offset: 0x5d2)
// dev strs .. 4   (offset: 0x5e2)
// exports ... 8   (offset: 0x3a2)
// cseg ...... 0x79 + 0x329 (0x3a2)
// imports ... 8   (offset: 0x4e2)
// animtree1 . 0   (offset: 0x612)
// animtree2 . 0   (offset: 0x612)
#namespace playerachievements;

// Namespace playerachievements
// Params 2, eflags: 0x4
// Checksum 0x559705c, Offset: 0x97
// Size: 0x65
function private initachievement( player, achievementid )
{
    if ( !isdefined( player.achievements ) )
    {
        player.achievements = [];
    }
    
    if ( !isdefined( player.achievements[ achievementid ] ) )
    {
        player.achievements[ achievementid ] = { #progressvalues:[], #dataready:0 };
    }
}

// Namespace playerachievements
// Params 2
// Checksum 0xdc8defb8, Offset: 0x104
// Size: 0x53
function getstate( player, achievementid )
{
    println( "<dev string:x24>" + player.name + "<dev string:x42>" + achievementid );
    
    if ( player iscodcaster() )
    {
        return;
    }
    
    initachievement( player, achievementid );
    player function_fdf029c4be6546a3( achievementid );
}

// Namespace playerachievements
// Params 1
// Checksum 0xfbfd0e31, Offset: 0x15f
// Size: 0x65
function function_a550b9c75bcbee5e( progressname )
{
    if ( !isdefined( level.var_ff13eadad931c15a ) )
    {
        level.var_ff13eadad931c15a = [];
    }
    
    progressid = level.var_ff13eadad931c15a[ progressname ];
    
    if ( !isdefined( progressid ) )
    {
        progressid = int( tablelookup( "ae/ae_progress_target_ids.csv", 0, progressname, 1 ) );
        level.var_ff13eadad931c15a[ progressname ] = progressid;
    }
    
    return progressid;
}

// Namespace playerachievements
// Params 1
// Checksum 0x459a5215, Offset: 0x1cd
// Size: 0x1a
function function_6c2806c796cd19b2( progressid )
{
    return tablelookup( "ae/ae_progress_target_ids.csv", 1, progressid, 0 );
}

// Namespace playerachievements
// Params 4
// Checksum 0x1146788f, Offset: 0x1f0
// Size: 0x47
function function_ce48098d17912e1f( player, achievementid, progressname, defaultvalue )
{
    progressid = function_a550b9c75bcbee5e( progressname );
    return function_1792b9eb4905bb29( player, achievementid, progressid, defaultvalue );
}

// Namespace playerachievements
// Params 4
// Checksum 0x6921acab, Offset: 0x240
// Size: 0x7b
function function_1792b9eb4905bb29( player, achievementid, progressid, defaultvalue )
{
    initachievement( player, achievementid );
    progressvalue = defaultvalue;
    
    if ( isdefined( player.achievements[ achievementid ].progressvalues[ progressid ] ) )
    {
        progressvalue = player.achievements[ achievementid ].progressvalues[ progressid ];
    }
    
    return progressvalue;
}

// Namespace playerachievements/challenge_progress
// Params 3, eflags: 0x20
// Checksum 0x77aae728, Offset: 0x2c4
// Size: 0xde
function event_handler[challenge_progress] challenge_progress( player, achievementid, progression )
{
    println( "<dev string:x60>" + player.name + "<dev string:x88>" + achievementid );
    initachievement( player, achievementid );
    
    for ( index = 0; index < progression.progress_values.size ; index++ )
    {
        progress_id = progression.progress_values[ index ].progress_id;
        progress_value = progression.progress_values[ index ].progress;
        player.achievements[ achievementid ].progressvalues[ progress_id ] = progress_value;
    }
    
    player notify( #"challengeprogress", achievementid );
}

