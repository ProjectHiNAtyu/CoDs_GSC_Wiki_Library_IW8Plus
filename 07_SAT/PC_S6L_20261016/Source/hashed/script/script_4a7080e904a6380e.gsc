// script_4a7080e904a6380e  (hash_4a7080e904a6380e.gscc) (size: 4847 Bytes / 0x12ef / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9c60e425 (2623595557)
// size ...... 4847 (0x12ef)
// includes .. 8   (offset: 0x1107)
// strings ... 22  (offset: 0x1147)
// dev strs .. 8   (offset: 0x1283)
// exports ... 13  (offset: 0xb67)
// cseg ...... 0x16c + 0x9fb (0xb67)
// imports ... 32  (offset: 0xd6f)
// animtree1 . 0   (offset: 0x12ef)
// animtree2 . 0   (offset: 0x12ef)
#using script_26ccbfe3954cacf4;
#using scripts\common\utility;
#using scripts\mp\bots\bots_gametype_br_super;
#using scripts\mp\bots\bots_util;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_weapons;
#using scripts\mp\class;
#using scripts\mp\spawnlogic;

#namespace super_bot;

// Namespace super_bot
// Params 4
// Checksum 0xcd406e2e, Offset: 0x18a
// Size: 0x123
function function_71585fa0eb269a5f( var_7dc27bc9fa62c763, var_d094491947d7985, var_5b5614b49b66a9b6, spawnangle = ( 0, 60, 0 ) )
{
    if ( level.var_935a32375dac97bf )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    level.var_935a32375dac97bf = 1;
    defaultpos = bots_util_mp::function_1882f18076610076( level.br_level.br_mapcenter ?? ( 0, 0, 0 ) );
    
    if ( !isdefined( var_7dc27bc9fa62c763 ) )
    {
        activatelocation = utility::getstruct( "br_bot_activate_location", "script_noteworthy" );
        
        if ( !isdefined( activatelocation.origin ) )
        {
            println( "<dev string:x55>" + defaultpos + "<dev string:xa7>" );
        }
        
        var_7dc27bc9fa62c763 = activatelocation.origin ?? defaultpos;
    }
    
    if ( !isdefined( var_d094491947d7985 ) )
    {
        var_d094491947d7985 = defaultpos;
    }
    
    if ( isdefined( level.var_3db2463af78badf7 ) )
    {
        [[ level.var_3db2463af78badf7 ]]( var_7dc27bc9fa62c763, var_d094491947d7985 );
        return;
    }
    
    function_785f590f229eae81( var_7dc27bc9fa62c763, var_d094491947d7985, var_5b5614b49b66a9b6, spawnangle );
}

// Namespace super_bot
// Params 4, eflags: 0x4
// Checksum 0x58e33029, Offset: 0x2b5
// Size: 0x65
function private function_785f590f229eae81( var_7dc27bc9fa62c763, var_d094491947d7985, var_5b5614b49b66a9b6, spawnangle )
{
    function_58e0d490b945efe( var_d094491947d7985 );
    manager::initialize( var_7dc27bc9fa62c763 );
    function_f1fe54955f1a92d9();
    level.br_standard_loadout = getdefaultloadout();
    
    if ( var_5b5614b49b66a9b6 > 0 )
    {
        function_42d531708b7617f3( var_5b5614b49b66a9b6 );
    }
    
    level thread bots_gametype_br_super::function_91ad800039e8b01d();
}

// Namespace super_bot
// Params 1
// Checksum 0xf281553e, Offset: 0x322
// Size: 0xfe
function function_58e0d490b945efe( var_d094491947d7985 )
{
    skiptype = getdvarint( @"hash_25ad2925d6075c8f", 0 );
    
    if ( skiptype != 0 )
    {
        level.skipprematch = 1;
        
        if ( skiptype == 2 )
        {
            level.skipprematchdropspawn = 1;
            level.br_infils_disabled = 1;
            level thread function_8820f463f7e4b06a();
            assert( isdefined( var_d094491947d7985 ) );
            
            if ( !isdefined( spawnangle ) )
            {
                spawnangle = ( 0, 60, 0 );
            }
            
            spawns = [];
            spawns[ spawns.size ] = spawnlogic::createscriptedspawnpoint( "mp_dm_spawn_start", var_d094491947d7985, spawnangle );
            spawnlogic::addscriptedspawnpoints( spawns );
        }
        
        return;
    }
    
    var_6c8cad110159fdc1 = 150;
    var_6771b2a17f2e4024 = br::function_c01db5f0551dc1ac();
    var_565053182d58a1ac = var_6c8cad110159fdc1 / var_6771b2a17f2e4024;
    var_1f5db2d8f00e0650 = manager::function_9228d096a2ad4d4e();
    level.var_a7b65f5a37e3ba00 = ceil( var_1f5db2d8f00e0650 / var_565053182d58a1ac );
}

// Namespace super_bot
// Params 0
// Checksum 0x7b287143, Offset: 0x428
// Size: 0x163
function function_f1fe54955f1a92d9()
{
    if ( !level.br_level )
    {
        return;
    }
    
    if ( !level.br_level.var_d334191fe4252ac )
    {
        botdifficulties = [ "casual", "recruit", "regular", "hardened", "veteran", "elite", "master" ];
        level.br_level.var_90935020921adca4 = [];
        
        for ( botloadoutphase = 0; botloadoutphase < 3 ; botloadoutphase++ )
        {
            level.br_level.var_90935020921adca4[ botloadoutphase ] = [];
            
            foreach ( botdifficulty in botdifficulties )
            {
                botloadoutconfig = function_476daf2eb840b7ca( botloadoutphase, botdifficulty );
                level.br_level.var_90935020921adca4[ botloadoutphase ][ botdifficulty ] = botloadoutconfig;
            }
        }
        
        level.br_level.var_d334191fe4252ac = 1;
    }
}

// Namespace super_bot
// Params 2, eflags: 0x4
// Checksum 0xd28ac3f2, Offset: 0x593
// Size: 0x81
function private function_476daf2eb840b7ca( botloadoutphase, botdifficulty )
{
    loadouts = class::function_8cc2758f17a3d70a( #"bot", 1, botloadoutphase, botdifficulty );
    bundle = loadouts[ 0 ].bundle;
    
    if ( isbrgamemode() && !isdefined( bundle ) )
    {
        return;
    }
    
    classtablebundle = undefined;
    
    if ( isdefined( bundle ) )
    {
        classtablebundle = bundle;
    }
    else
    {
        classtablebundle = level.classtablename;
    }
    
    return classtablebundle;
}

// Namespace super_bot
// Params 0
// Checksum 0xb064d779, Offset: 0x61d
// Size: 0x12
function getdefaultloadout()
{
    return br::initstandardloadout( level.classtablename, 0 );
}

// Namespace super_bot
// Params 0, eflags: 0x4
// Checksum 0xef300563, Offset: 0x638
// Size: 0x5c
function private function_8820f463f7e4b06a()
{
    level waittill( #"player_spawned", player );
    player setclientomnvar( "ui_br_infiled", 1 );
    level waittill( #"infils_ready" );
    level.br_c130spawndone = 1;
    player br_weapons::br_ammo_player_clear();
    player skydive_setdeploymentstatus( 1 );
    player skydive_setbasejumpingstatus( 1 );
}

// Namespace super_bot
// Params 1
// Checksum 0x53569e07, Offset: 0x69c
// Size: 0xdf
function function_7af21960125481f9( landingspots )
{
    if ( !isdefined( level.landingspots ) )
    {
        level.landingspots = [];
    }
    
    foreach ( landingspot in landingspots )
    {
        spot = { #script_parameters:1, #origin:landingspot, #target:"spot" + level.landingspots.size + 1 };
        level.landingspots[ level.landingspots.size ] = spot;
    }
}

// Namespace super_bot
// Params 6, eflags: 0x4
// Checksum 0x2d9d35d5, Offset: 0x783
// Size: 0x1b7
function private loginternal( loglevel, isglobal, var_e8c1eb3de8a0ecdf, functionname = "undefined", message = "", var_b2617ca1cf78104a = "" )
{
    if ( loglevel < level.uibotmanager.loglevel )
    {
        return;
    }
    
    if ( !isglobal )
    {
        if ( var_e8c1eb3de8a0ecdf )
        {
            name = var_e8c1eb3de8a0ecdf.name ?? "undefined";
            team = var_e8c1eb3de8a0ecdf.team ?? "undefined";
            xuid = var_e8c1eb3de8a0ecdf.xuid ?? "undefined";
            bba_id = var_e8c1eb3de8a0ecdf.bba_id ?? "undefined";
            message = "name=" + name + " team=" + team + " xuid=" + xuid + " BBA_Id=" + bba_id + " " + message;
        }
        else
        {
            message = "bot is undefined! " + message;
        }
    }
    
    levelstr = level.uibotmanager.var_6ba0b05a074ecd1d[ loglevel ] ?? "";
    str = "[Super Bots]" + levelstr + var_b2617ca1cf78104a + " " + functionname + ": " + message;
    
    if ( loglevel == 2 )
    {
        assertmsg( str );
        logstring( str );
        return;
    }
    
    if ( loglevel == 3 )
    {
        throw( str );
        return;
    }
    
    logstring( str );
}

// Namespace super_bot
// Params 5
// Checksum 0x50092357, Offset: 0x942
// Size: 0x64
function function_cb27523a07bf9c83( loglevel, var_e8c1eb3de8a0ecdf, functionname = "undefined", message = "", var_b2617ca1cf78104a = "" )
{
    loginternal( loglevel, 0, var_e8c1eb3de8a0ecdf, functionname, message, var_b2617ca1cf78104a );
}

// Namespace super_bot
// Params 4
// Checksum 0xe64afb81, Offset: 0x9ae
// Size: 0x5b
function lograw( loglevel, functionname = "undefined", message = "", var_b2617ca1cf78104a = "" )
{
    loginternal( loglevel, 1, undefined, functionname, message, var_b2617ca1cf78104a );
}

/#

    // Namespace super_bot
    // Params 4
    // Checksum 0x9dfa5965, Offset: 0xa11
    // Size: 0x156, Type: dev
    function function_7b74a5d32df070f8( context, var_51ebd08c927b2d8c, functionname, var_7b5caaa2a63c71ed )
    {
        if ( !isdefined( context ) )
        {
            context = "<dev string:xfa>";
        }
        
        level endon( #"game_ended" );
        level.var_b345e58e92744c1d.var_a663c9d8d5984403[ var_7b5caaa2a63c71ed ] = 0;
        
        while ( isdefined( var_51ebd08c927b2d8c ) )
        {
            waitframe();
        }
        
        if ( !level.var_b345e58e92744c1d.var_a663c9d8d5984403[ var_7b5caaa2a63c71ed ] )
        {
            lograw( 2, functionname, "<dev string:xfb>" + context );
        }
        else
        {
            errorcode = level.var_b345e58e92744c1d.var_a663c9d8d5984403[ var_7b5caaa2a63c71ed ].errorcode ?? 0;
            message = level.var_b345e58e92744c1d.var_a663c9d8d5984403[ var_7b5caaa2a63c71ed ].message ?? "<dev string:xfa>";
            
            if ( errorcode != 0 )
            {
                lograw( 1, functionname, "<dev string:x125>" + context + "<dev string:x13c>" + errorcode + "<dev string:x148>" + message );
            }
            else
            {
                lograw( 0, functionname, "<dev string:x125>" + context + "<dev string:x148>" + message );
            }
        }
        
        level.var_b345e58e92744c1d.var_a663c9d8d5984403[ var_7b5caaa2a63c71ed ] = undefined;
    }

#/
