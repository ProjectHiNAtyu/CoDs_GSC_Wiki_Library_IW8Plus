// scripts\common\gameplay_sound_fx.gsc  (hash_37a945f9ae16cee7.gscc) (size: 4216 Bytes / 0x1078 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x10bbd8f3 (280746227)
// size ...... 4216 (0x1078)
// includes .. 3   (offset: 0xf38)
// strings ... 3   (offset: 0xf50)
// dev strs .. 19  (offset: 0xf88)
// exports ... 15  (offset: 0x92c)
// cseg ...... 0xa0 + 0x88c (0x92c)
// imports ... 29  (offset: 0xb84)
// animtree1 . 0   (offset: 0x1078)
// animtree2 . 0   (offset: 0x1078)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;

#namespace gameplay_sound_fx;

// Namespace gameplay_sound_fx
// Params 0, eflags: 0x5
// Checksum 0x86aff8d3, Offset: 0xbe
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"gameplay_sound_fx", undefined, undefined, &init_gameplaysfx );
}

// Namespace gameplay_sound_fx
// Params 0
// Checksum 0x57536dac, Offset: 0xdf
// Size: 0x22f
function init_gameplaysfx()
{
    if ( isdefined( game[ "gameplay_sfx" ] ) )
    {
        callback::remove( #"gameplay_sfx_register", #"all" );
        utility::flag_set( "gameplaySFX_initDone" );
        return;
    }
    
    utility::flag_wait( "shared_functions_initialized" );
    game[ "gameplay_sfx" ] = [];
    
    if ( isdefined( level.gamemodebundle ) && isdefined( level.gamemodebundle.gameplaysfx ) )
    {
        gamemodesfxbundle = getscriptbundle( level.gamemodebundle.gameplaysfx );
        
        if ( isdefined( gamemodesfxbundle ) )
        {
            setgameplaysfx( gamemodesfxbundle, 1 );
        }
    }
    
    mapinfo = getmapscriptbundle();
    var_459bd826ff0d51cd = 1;
    
    if ( isdefined( mapinfo.var_9d6c6551df565b43 ) )
    {
        if ( isdefined( level.sharedfuncs[ #"game" ][ #"getgametype" ] ) )
        {
            gametyperef = [[ level.sharedfuncs[ #"game" ][ #"getgametype" ] ]]();
            
            foreach ( gameplaysfxoverride in mapinfo.var_9d6c6551df565b43 )
            {
                if ( gameplaysfxoverride.gametyperef == gametyperef )
                {
                    gametypesfxbundle = getscriptbundle( gameplaysfxoverride.gameplaysfx );
                    
                    if ( isdefined( gametypesfxbundle ) )
                    {
                        var_459bd826ff0d51cd = 0;
                        setgameplaysfx( gametypesfxbundle, 0 );
                    }
                }
            }
        }
    }
    
    if ( var_459bd826ff0d51cd && isdefined( level.gametypebundle ) && isdefined( level.gametypebundle.gameplaysfx ) )
    {
        gametypesfxbundle = getscriptbundle( level.gametypebundle.gameplaysfx );
        
        if ( isdefined( gametypesfxbundle ) )
        {
            setgameplaysfx( gametypesfxbundle, 0 );
        }
    }
    
    callback::callback( #"gameplay_sfx_register" );
    utility::flag_set( "gameplaySFX_initDone" );
}

// Namespace gameplay_sound_fx
// Params 2
// Checksum 0xaab1667e, Offset: 0x316
// Size: 0x143
function setgameplaysfx( bundlesfx, var_95481810089acb32 = 1 )
{
    if ( utility::flag( "gameplaySFX_initDone" ) )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    foreach ( event in bundlesfx.var_fdc02a9ef002a383 )
    {
        if ( !isdefined( event.soundref ) )
        {
            continue;
        }
        
        /#
            if ( isdefined( game[ "<dev string:x52>" ][ event.soundref ] ) )
            {
                if ( var_95481810089acb32 )
                {
                    assertmsg( "<dev string:x5f>" + getxhashsourcename( event.soundref ) + "<dev string:x7d>" );
                }
                else
                {
                    println( "<dev string:x5f>" + getxhashsourcename( event.soundref ) + "<dev string:xe1>" );
                }
            }
        #/
        
        game[ "gameplay_sfx" ][ event.soundref ] = event.alias;
    }
}

// Namespace gameplay_sound_fx
// Params 1
// Checksum 0xdf3dc3d7, Offset: 0x461
// Size: 0x5f
function getgameplaysfx( soundref )
{
    soundhash = soundref;
    
    if ( !isxhash( soundref ) )
    {
        soundhash = getxhash( soundref );
    }
    
    /#
        if ( !isdefined( game[ "<dev string:x52>" ][ soundhash ] ) )
        {
            println( "<dev string:x5f>" + getxhashsourcename( soundhash ) + "<dev string:xee>" );
        }
    #/
    
    return game[ "gameplay_sfx" ][ soundhash ];
}

// Namespace gameplay_sound_fx
// Params 4
// Checksum 0xce3c3d6d, Offset: 0x4c9
// Size: 0x62
function playlocalsoundfx( soundref, notifystring, var_9f48de58c68fabb8, var_4e68b2357c02837f )
{
    if ( !isdefined( soundref ) )
    {
        println( "<dev string:x117>" );
        return;
    }
    
    soundalias = getgameplaysfx( soundref );
    
    if ( !isdefined( soundalias ) )
    {
        return;
    }
    
    self playlocalsound( soundalias, notifystring, var_9f48de58c68fabb8 );
}

// Namespace gameplay_sound_fx
// Params 1
// Checksum 0xe615ed4, Offset: 0x533
// Size: 0x66
function stoplocalsoundfx( soundref )
{
    if ( !isdefined( self ) || self.isdisconnecting )
    {
        println( "<dev string:x13f>" );
        return;
    }
    
    if ( !isdefined( soundref ) )
    {
        println( "<dev string:x173>" );
        return;
    }
    
    soundalias = getgameplaysfx( soundref );
    
    if ( !isdefined( soundalias ) )
    {
        return;
    }
    
    self stoplocalsound( soundalias );
}

// Namespace gameplay_sound_fx
// Params 6
// Checksum 0x6b2c03df, Offset: 0x5a1
// Size: 0x111
function function_e319dc8e16c85fcb( soundref, players, excludeplayer, notifystring, var_9f48de58c68fabb8, var_4e68b2357c02837f )
{
    if ( !isdefined( soundref ) )
    {
        println( "<dev string:x19b>" );
        return;
    }
    
    soundalias = getgameplaysfx( soundref );
    
    if ( !isdefined( soundalias ) )
    {
        return;
    }
    
    if ( isarray( players ) )
    {
        foreach ( player in players )
        {
            if ( isplayer( player ) && !isagent( player ) && player != excludeplayer )
            {
                player playlocalsound( soundalias, notifystring, var_9f48de58c68fabb8 );
            }
        }
        
        return;
    }
    
    assertmsg( "<dev string:x1cd>" );
}

// Namespace gameplay_sound_fx
// Params 4
// Checksum 0xba0086b9, Offset: 0x6ba
// Size: 0x64
function function_6dac8db778849e61( soundref, team, ignoreplayer, soundsourceent )
{
    if ( !isdefined( soundref ) )
    {
        println( "<dev string:x202>" );
        return;
    }
    
    soundalias = getgameplaysfx( soundref );
    
    if ( !isdefined( soundalias ) )
    {
        return;
    }
    
    self playsoundtoteam( soundalias, team, ignoreplayer, soundsourceent );
}

// Namespace gameplay_sound_fx
// Params 2
// Checksum 0x2a44a2db, Offset: 0x726
// Size: 0x63
function function_28103d3430792dce( posorigin, soundref )
{
    if ( !isdefined( soundref ) )
    {
        println( "<dev string:x22b>" );
        return;
    }
    
    if ( !isdefined( posorigin ) )
    {
        println( "<dev string:x253>" );
        return;
    }
    
    soundalias = getgameplaysfx( soundref );
    
    if ( !isdefined( soundalias ) )
    {
        return;
    }
    
    playsoundatpos( posorigin, soundalias );
}

// Namespace gameplay_sound_fx
// Params 3
// Checksum 0x69d82117, Offset: 0x791
// Size: 0x59
function function_760dbc73d1362ab9( soundref, ignoreplayer, soundsourceent )
{
    if ( !isdefined( soundref ) )
    {
        println( "<dev string:x27c>" );
        return;
    }
    
    soundalias = getgameplaysfx( soundref );
    
    if ( !isdefined( soundalias ) )
    {
        return;
    }
    
    self playsound( soundalias, ignoreplayer, soundsourceent );
}

// Namespace gameplay_sound_fx
// Params 1
// Checksum 0x380dfd80, Offset: 0x7f2
// Size: 0x45
function function_8b59cca80c6c2af( soundref )
{
    if ( !isdefined( soundref ) )
    {
        println( "<dev string:x2a4>" );
        return;
    }
    
    soundalias = getgameplaysfx( soundref );
    
    if ( !isdefined( soundalias ) )
    {
        return;
    }
    
    self playsoundonmovingent( soundalias );
}

// Namespace gameplay_sound_fx
// Params 1
// Checksum 0x9e7fc311, Offset: 0x83f
// Size: 0x45
function function_8219c402fc8c37a3( soundref )
{
    if ( !isdefined( soundref ) )
    {
        println( "<dev string:x2d2>" );
        return;
    }
    
    soundalias = getgameplaysfx( soundref );
    
    if ( !isdefined( soundalias ) )
    {
        return;
    }
    
    self playloopsound( soundalias );
}

// Namespace gameplay_sound_fx
// Params 1
// Checksum 0x4a13c913, Offset: 0x88c
// Size: 0x47
function function_9d2677406f9212a5( soundref )
{
    if ( !isdefined( soundref ) )
    {
        println( "<dev string:x2fe>" );
        return;
    }
    
    soundalias = getgameplaysfx( soundref );
    
    if ( !isdefined( soundalias ) )
    {
        return;
    }
    
    self stoploopsound( soundalias, 1 );
}

// Namespace gameplay_sound_fx
// Params 2
// Checksum 0xcee38682, Offset: 0x8db
// Size: 0x51
function function_1ef72f46669e3816( soundref, ent )
{
    if ( !isdefined( soundref ) )
    {
        println( "<dev string:x32a>" );
        return;
    }
    
    soundalias = getgameplaysfx( soundref );
    
    if ( !isdefined( soundalias ) )
    {
        return;
    }
    
    self playsoundtoplayer( soundalias, self, ent );
}

