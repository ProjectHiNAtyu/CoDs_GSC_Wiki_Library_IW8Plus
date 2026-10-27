// scripts\mp\ammorestock.gsc  (hash_774a3800757e6127.gscc) (size: 21728 Bytes / 0x54e0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x886616f7 (2288391927)
// size ...... 21728 (0x54e0)
// includes .. 13  (offset: 0x500c)
// strings ... 61  (offset: 0x5074)
// dev strs .. 13  (offset: 0x5418)
// exports ... 36  (offset: 0x391c)
// cseg ...... 0x51e + 0x33fe (0x391c)
// imports ... 124 (offset: 0x3ebc)
// animtree1 . 0   (offset: 0x54e0)
// animtree2 . 0   (offset: 0x54e0)
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\br\ammorestock;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\damagefeedback;
#using scripts\mp\equipment;
#using scripts\mp\hud_message;
#using scripts\mp\structspawnconfig;
#using scripts\mp\weapons;

#namespace ammorestock;

// Namespace ammorestock
// Params 0
// Checksum 0x91ff111a, Offset: 0x53c
// Size: 0x462
function init()
{
    level.var_c95a4556478f1db8 = [];
    level.var_5ca0fdd41df6590c = getdvarint( @"hash_26a615d4f4451183", 1 ) == 1;
    
    if ( !isdefined( level.ammorestocklocs ) )
    {
        level.ammorestocklocs = [];
    }
    
    usingssc = getdvarint( @"scr_ssc_enabled", 1 );
    
    if ( usingssc )
    {
        utility::flag_wait( "ssc_initialized" );
        structspawnconfig::function_7418a260adaec05( "ammorestock", &function_b1a19e953e5d4086 );
        structspawnconfig::function_8c0a09968efe9138( "ammorestock", &function_91c6d2181edaba63 );
        structspawnconfig::function_5d240d112f92de88( "ammorestock", &function_3588fba6bb01452e );
        structspawnconfig::function_36050499b5f48983( "ammorestock", &function_b053e53ff79f87ff );
    }
    else
    {
        wait 10;
        ammorestocklocs = getentitylessscriptablearray( undefined, undefined, undefined, undefined, "military_ammo_restock" );
        
        if ( isdefined( level.var_6f6e0bbb01a6e290 ) )
        {
            ammorestocklocs = [[ level.var_6f6e0bbb01a6e290 ]]( ammorestocklocs );
        }
        
        function_5b2510298ae07fc();
        println( "<dev string:x24>" + ( game_utility::getlocaleid() ?? "<dev string:x44>" ) + "<dev string:x49>" + ammorestocklocs.size );
        
        foreach ( loc in ammorestocklocs )
        {
            localemismatch = isdefined( game_utility::getlocaleid() ) && ( isdefined( loc.script_noteworthy ) && loc.script_noteworthy != level.localeid || !isdefined( loc.script_noteworthy ) );
            nolocale = !isdefined( game_utility::getlocaleid() ) && isdefined( loc.script_noteworthy ) && issubstr( loc.script_noteworthy, "locale" );
            isduplicate = duplicatecheck( loc );
            isglobal = loc.script_gameobjectname == "br";
            allowglobal = isbrgamemode() || function_66c12ebdbc81570( loc ) || level.var_b60d1f50eaf8eb5;
            
            if ( !level.useammorestocklocs || nolocale || localemismatch && !function_42aba6b8506a82cd( loc ) || isduplicate || isglobal && !allowglobal )
            {
                removelocation( loc );
                continue;
            }
            
            if ( utility::callsharedfunc( #"poi", #"isSystemActive" ) && !utility::callsharedfunc( #"poi", #"isactive", loc.origin ) )
            {
                removelocation( loc );
                continue;
            }
            
            if ( isdefined( loc.script_string ) && isglobal )
            {
                gametype = game_utility::getgametype();
                tokens = strtok( loc.script_string, " " );
                
                if ( tokens.size > 0 && arraycontains( tokens, gametype ) )
                {
                    removelocation( loc );
                    continue;
                }
            }
            
            println( "<dev string:x5e>" + loc.origin + "<dev string:x88>" + ( loc.script_noteworthy ?? "<dev string:x44>" ) + "<dev string:x9f>" + ( loc.script_string ?? "<dev string:x44>" ) );
            addlocation( loc );
        }
        
        if ( level.localeid == "locale_6" )
        {
            ammorestock_customlocale6cleanup();
        }
        
        function_27c9a5a3257ff73f();
    }
    
    if ( isbrgamemode() )
    {
        ammorestock_br::function_842c4fb51e4f480f();
    }
    
    if ( utility::issharedfuncdefined( #"gamemode", #"ammorestockused" ) )
    {
        scriptable::scriptable_addusedcallbackbypart( "military_ammo_restock", utility::getsharedfunc( #"gamemode", #"ammorestockused" ) );
    }
    else
    {
        scriptable::scriptable_addusedcallbackbypart( "military_ammo_restock", &ammorestock_used );
    }
    
    if ( utility::issharedfuncdefined( #"ammorestock", #"hash_d1fdd5d882c1ef98" ) )
    {
        [[ utility::getsharedfunc( #"ammorestock", #"hash_d1fdd5d882c1ef98" ) ]]();
    }
    
    utility::flag_set( "ammorestock_initialized" );
}

// Namespace ammorestock
// Params 1, eflags: 0x4
// Checksum 0xbc5913b9, Offset: 0x9a6
// Size: 0x79
function private function_baef5a7246249fbc( instance )
{
    if ( !isdefined( instance ) )
    {
        return "";
    }
    
    currentstate = instance getscriptablepartstate( "military_ammo_restock" );
    
    if ( !isdefined( currentstate ) )
    {
        return "";
    }
    
    statearray = strtok( currentstate, "_" );
    statesuffix = statearray[ statearray.size - 1 ];
    return statesuffix == "armor" ? statesuffix : "";
}

// Namespace ammorestock
// Params 1, eflags: 0x4
// Checksum 0xc4837c27, Offset: 0xa28
// Size: 0x1a, Type: bool
function private function_9a6e9a1f5e1e40ed( instance )
{
    return function_baef5a7246249fbc( instance ) == "armor";
}

// Namespace ammorestock
// Params 1
// Checksum 0xc2d7f405, Offset: 0xa4b
// Size: 0x2a6
function removelocation( loc )
{
    println( "<dev string:xb2>" + loc.origin + "<dev string:x88>" + ( loc.script_noteworthy ?? "<dev string:x44>" ) + "<dev string:x9f>" + ( loc.script_string ?? "<dev string:x44>" ) );
    
    if ( isdefined( loc.target ) )
    {
        targetents = getentarray( loc.target, #targetname );
        
        if ( targetents.size > 0 )
        {
            foreach ( ent in targetents )
            {
                ent disable_internal();
                ent delete();
            }
        }
        
        targetents = getentitylessscriptablearray( loc.target, #targetname );
        
        if ( targetents.size > 0 )
        {
            foreach ( scriptable in targetents )
            {
                scriptable disable_internal();
                scriptable setscriptablepartstate( "military_ammo_restock", "hidden" );
            }
        }
    }
    
    /#
        if ( getdvarint( @"hash_d684f98557413539", 0 ) == 1 )
        {
            print3d( loc.origin + ( 0, 0, 100 ), "<dev string:xde>" + loc.origin[ 0 ] + "<dev string:xe1>" + loc.origin[ 1 ] + "<dev string:xe1>" + loc.origin[ 2 ] + "<dev string:xe4>", ( 1, 1, 1 ), 1, 1, 9999, 1 );
            thread debug_utility::drawline( loc.origin, loc.origin + ( 0, 0, 5000 ), 600, ( 1, 0, 0 ) );
        }
    #/
    
    loc disable_internal();
    
    if ( isent( loc ) )
    {
        loc delete();
        return;
    }
    
    loc setscriptablepartstate( "military_ammo_restock", "hidden" );
}

// Namespace ammorestock
// Params 1
// Checksum 0x96be8c5c, Offset: 0xcf9
// Size: 0x20
function spawnlocation( struct )
{
    spawnmodel( struct );
    spawncollision( struct );
    return struct;
}

// Namespace ammorestock
// Params 1
// Checksum 0x489a427, Offset: 0xd22
// Size: 0x1a6
function addlocation( loc )
{
    if ( !isdefined( level.ammorestocklocs ) )
    {
        level.ammorestocklocs = [];
    }
    
    /#
        if ( getdvarint( @"hash_d684f98557413539", 0 ) == 1 )
        {
            print3d( loc.origin + ( 0, 0, 200 ), "<dev string:xde>" + loc.origin[ 0 ] + "<dev string:xe1>" + loc.origin[ 1 ] + "<dev string:xe1>" + loc.origin[ 2 ] + "<dev string:xe4>", ( 1, 1, 1 ), 1, 1, 9999, 1 );
            thread debug_utility::drawline( loc.origin, loc.origin + ( 0, 0, 2000 ), 600, ( 0, 1, 0 ) );
            thread debug_utility::drawsphere( loc.origin, 128, 600, ( 0, 1, 0 ) );
        }
    #/
    
    if ( isstring( loc.target ) )
    {
        loc.scriptables = getentarray( loc.target, "targetname" );
        ammorestockentityless = getentitylessscriptablearray( loc.target, "targetname" );
        loc.scriptables = arraycombine( loc.scriptables, ammorestockentityless );
    }
    
    loc.timeplayerused = [];
    level.ammorestocklocs[ level.ammorestocklocs.size ] = loc;
}

// Namespace ammorestock
// Params 0
// Checksum 0x7d5ff91, Offset: 0xed0
// Size: 0x19
function enable_internal()
{
    if ( self isscriptable() || self isscriptableinstance() )
    {
        function_9bebf79aee6c7add( self );
    }
}

// Namespace ammorestock
// Params 0
// Checksum 0x8cff162c, Offset: 0xef1
// Size: 0x19
function disable_internal()
{
    if ( self isscriptable() || self isscriptableinstance() )
    {
        function_d1c123d5d7f81c2a( self );
    }
}

// Namespace ammorestock
// Params 1
// Checksum 0xe289b68b, Offset: 0xf12
// Size: 0xb5
function disablelocation( loc )
{
    loc.disabled = 1;
    
    if ( isdefined( loc.target ) )
    {
        foreach ( ent in loc.scriptables )
        {
            ent disable_internal();
            ent setscriptablepartstate( "military_ammo_restock", "disabled" );
        }
    }
}

// Namespace ammorestock
// Params 1
// Checksum 0x25041928, Offset: 0xfcf
// Size: 0x170
function enablelocation( loc )
{
    loc.disabled = undefined;
    
    if ( isdefined( loc.target ) )
    {
        targetents = getentarray( loc.target, "targetname" );
        targetentityless = getentitylessscriptablearray( loc.target, "targetname" );
        toenable = arraycombine( targetents, targetentityless );
        
        if ( toenable.size > 0 )
        {
            var_164a5a1fe7fb0ba2 = isbrgamemode() ? @"hash_9946861f4644413f" : @"hash_c95a149e3fb09e8c";
            var_93b02176c399fc17 = getdvar( var_164a5a1fe7fb0ba2, "ON" );
            state = undefined;
            
            if ( var_93b02176c399fc17 == "ON" )
            {
                state = "useable_on";
            }
            else if ( var_93b02176c399fc17 == "OFF" )
            {
                state = "useable_on_no_icon";
            }
            
            if ( !isdefined( state ) )
            {
                return;
            }
            
            foreach ( ammocache in toenable )
            {
                ammocache enable_internal();
                ammocache setscriptablepartstate( "military_ammo_restock", state );
            }
        }
    }
}

// Namespace ammorestock
// Params 0
// Checksum 0xfda5a626, Offset: 0x1147
// Size: 0x86
function function_be091faf99f438f()
{
    level.ammorestock_all_disabled = 1;
    
    foreach ( loc in level.ammorestocklocs )
    {
        disablelocation( loc );
    }
}

// Namespace ammorestock
// Params 1
// Checksum 0x6c30a02c, Offset: 0x11d5
// Size: 0x160, Type: bool
function function_42aba6b8506a82cd( loc )
{
    switch ( level.mapname )
    {
        case #"hash_c8b70146f0c8a9cd":
        case #"hash_decd2e8ff1f996d7":
            return true;
        case #"hash_5586b38644ed9b26":
            if ( loc.script_noteworthy == "locale_28" || loc.script_noteworthy == "locale_34" )
            {
                return true;
            }
            
            break;
        case #"hash_a11e6e81ea219453":
            if ( loc.script_noteworthy == "locale_50" || loc.script_noteworthy == "locale_51" )
            {
                return true;
            }
            
            break;
        case #"hash_3e552e81b4a21fff":
            if ( loc.script_noteworthy == "locale_26" || loc.script_noteworthy == "locale_27" )
            {
                return true;
            }
            
            break;
        case #"hash_ec2ebc1298ef7373":
            if ( loc.script_noteworthy == "locale_22" || loc.script_noteworthy == "locale_88" )
            {
                return true;
            }
            
            break;
        case #"hash_d707e2cfc340c376":
            if ( loc.script_noteworthy == "locale_24" || loc.script_noteworthy == "locale_25" )
            {
                return true;
            }
            
            break;
    }
    
    return false;
}

// Namespace ammorestock
// Params 1
// Checksum 0x91996288, Offset: 0x133e
// Size: 0xc3, Type: bool
function function_66c12ebdbc81570( loc )
{
    switch ( level.mapname )
    {
        case #"hash_a11e6e81ea219453":
            if ( distance2dsquared( loc.origin, ( -34993, -21635.7, 308 ) ) < 65536 )
            {
                return true;
            }
            
            break;
        case #"hash_5586b38644ed9b26":
            if ( distance2dsquared( loc.origin, ( 2248.88, -38875.6, 216 ) ) < 65536 )
            {
                return true;
            }
            
            break;
        case #"hash_c8b70146f0c8a9cd":
            if ( distance2dsquared( loc.origin, ( 22721.7, 23480.7, 1668.93 ) ) < 65536 )
            {
                return true;
            }
            
            break;
    }
    
    return false;
}

// Namespace ammorestock
// Params 1, eflags: 0x4
// Checksum 0xc93ff23c, Offset: 0x140a
// Size: 0x45
function private function_b1a19e953e5d4086( structname )
{
    instances = utility::getstructarray( "ammorestock", "targetname" );
    
    if ( instances.size > 0 )
    {
        return instances;
    }
    
    return getentarray( "ammo_restock_location", #targetname );
}

// Namespace ammorestock
// Params 2, eflags: 0x4
// Checksum 0xbb81bd32, Offset: 0x1458
// Size: 0x34
function private function_91c6d2181edaba63( structname, loc )
{
    loc.movingplatforminfo = loc utility::function_7c45b71b8e0d3cff();
    addlocation( loc );
    return loc;
}

// Namespace ammorestock
// Params 2, eflags: 0x4
// Checksum 0x63bbab91, Offset: 0x1495
// Size: 0x1e
function private function_3588fba6bb01452e( structname, loc )
{
    removelocation( loc );
}

// Namespace ammorestock
// Params 1, eflags: 0x4
// Checksum 0x1281c6f0, Offset: 0x14bb
// Size: 0xb9
function private function_b053e53ff79f87ff( structname )
{
    if ( !isdefined( level.ammorestocklocs[ 0 ] ) )
    {
        return;
    }
    
    if ( isstruct( level.ammorestocklocs[ 0 ] ) )
    {
        foreach ( loc in level.ammorestocklocs )
        {
            spawn_ammo_restock( loc );
        }
        
        return;
    }
    
    function_5b2510298ae07fc();
    function_27c9a5a3257ff73f();
}

// Namespace ammorestock
// Params 1, eflags: 0x4
// Checksum 0x909e4658, Offset: 0x157c
// Size: 0xd5
function private spawn_ammo_restock( loc )
{
    var_b7f16068d1a178cb = isdefined( loc.movingplatforminfo.groundent );
    asset_name = !var_b7f16068d1a178cb ? "ammo_restock_static" : "ammo_restock";
    restock = spawnscriptable( asset_name, loc.origin, loc.angles );
    
    if ( !isdefined( restock ) )
    {
        assertmsg( "<dev string:xe6>" + asset_name + "<dev string:x111>" );
        return;
    }
    
    if ( var_b7f16068d1a178cb )
    {
        restock utility::scriptable_setparententity( loc.movingplatforminfo.groundent, loc.movingplatforminfo.localorigin );
    }
    
    loc.target = restock;
}

// Namespace ammorestock
// Params 2, eflags: 0x4
// Checksum 0x2f4b6982, Offset: 0x1659
// Size: 0x76
function private function_8de65e9fa7e101af( ammorestock, icontoggle )
{
    if ( icontoggle == "ON" )
    {
        ammorestock setscriptablepartstate( "military_ammo_restock", function_9a6e9a1f5e1e40ed( ammorestock ) ? "useable_on_armor" : "useable_on" );
        return;
    }
    
    if ( icontoggle == "OFF" )
    {
        ammorestock setscriptablepartstate( "military_ammo_restock", function_9a6e9a1f5e1e40ed( ammorestock ) ? "useable_on_no_icon_armor" : "useable_on_no_icon" );
    }
}

// Namespace ammorestock
// Params 0
// Checksum 0xafbc0af4, Offset: 0x16d7
// Size: 0x15d
function function_27c9a5a3257ff73f()
{
    var_164a5a1fe7fb0ba2 = isbrgamemode() ? @"hash_9946861f4644413f" : @"hash_c95a149e3fb09e8c";
    var_93b02176c399fc17 = getdvar( var_164a5a1fe7fb0ba2, "ON" );
    
    foreach ( ammocache in level.ammorestocklocs )
    {
        if ( !isdefined( ammocache.target ) )
        {
            continue;
        }
        
        foreach ( ammoscriptable in ammocache.scriptables )
        {
            if ( !( ammoscriptable isscriptable() || ammoscriptable isscriptableinstance() ) )
            {
                continue;
            }
            
            ammoscriptable enable_internal();
            function_8de65e9fa7e101af( ammoscriptable, var_93b02176c399fc17 );
            break;
        }
    }
}

// Namespace ammorestock
// Params 0, eflags: 0x4
// Checksum 0xe005402d, Offset: 0x183c
// Size: 0x1b2
function private function_5b2510298ae07fc()
{
    level.ammorestockclip = undefined;
    
    foreach ( loc in level.ammorestocklocs )
    {
        if ( isstruct( loc.target ) )
        {
            foreach ( ent in getentarray( loc.target, #targetname ) )
            {
                if ( ent.classname == "script_brushmodel" )
                {
                    collisionarr = getentarray( "tactical_cover_col", #targetname );
                    origin = collisionarr[ 0 ].origin;
                    angles = collisionarr[ 0 ].angles;
                    model = spawn( "script_model", origin );
                    model.angles = angles;
                    model clonebrushmodeltoscriptmodel( ent );
                    level.ammorestockclip = model;
                    break;
                }
            }
        }
        
        if ( isdefined( level.ammorestockclip ) )
        {
            break;
        }
    }
}

// Namespace ammorestock
// Params 1
// Checksum 0xfc71ddca, Offset: 0x19f6
// Size: 0x36d
function function_df31bc416648d453( loc )
{
    switch ( level.mapname )
    {
        case #"hash_5586b38644ed9b26":
            break;
        case #"hash_c8b70146f0c8a9cd":
            if ( distance2dsquared( loc.origin, ( 26214, 33992, 1650 ) ) < 65536 )
            {
                origin = ( 26215, 33993.5, 1624 );
                angles = loc.angles + ( 0, 180, 0 );
                model = spawn( "script_model", origin );
                model.angles = angles;
                model setmodel( "military_ammo_restock_location" );
            }
            
            if ( distance2dsquared( loc.origin, ( 25609.8, 31617.3, 1669.66 ) ) < 65536 )
            {
                origin = ( 25642, 31626, 1625 );
                angles = loc.angles + ( 0, 180, 0 );
                model = spawn( "script_model", origin );
                model.angles = angles;
                model setmodel( "military_ammo_restock_location" );
            }
            
            if ( distance2dsquared( loc.origin, ( 27155.5, 27512.2, 1777.76 ) ) < 65536 )
            {
                if ( isdefined( level.ammorestockclip ) )
                {
                    origin = ( 27186.1, 27524.5, 1760 );
                    angles = loc.angles + ( 0, 315, 0 );
                    model = spawn( "script_model", origin );
                    model.angles = angles;
                    model clonebrushmodeltoscriptmodel( level.ammorestockclip );
                }
            }
            
            if ( distance2dsquared( loc.origin, ( 28623.1, 31207.5, 1681.75 ) ) < 65536 )
            {
                spawnmodel( loc );
            }
            
            break;
        case #"hash_3e552e81b4a21fff":
            if ( distance2dsquared( loc.origin, ( -7699.69, 50690.9, 284.391 ) ) < 65536 )
            {
                spawnmodel( loc );
            }
            
            if ( distance2dsquared( loc.origin, ( -5924.76, 44588.8, 284.861 ) ) < 65536 )
            {
                spawncollision( loc );
            }
            
            if ( distance2dsquared( loc.origin, ( -7280.71, 48236.9, 443.596 ) ) < 65536 )
            {
                model = spawnmodel( loc );
                col = spawncollision( loc );
            }
            
            if ( distance2dsquared( loc.origin, ( -9064.73, 41041, 300.758 ) ) < 65536 )
            {
                model = spawnmodel( loc );
                col = spawncollision( loc );
            }
            
            if ( distance2dsquared( loc.origin, ( -10185.3, 35049.8, 547.523 ) ) < 65536 )
            {
                model = spawnmodel( loc );
                col = spawncollision( loc );
            }
            
            if ( distance2dsquared( loc.origin, ( -7660.12, 35053.6, 332.271 ) ) < 65536 )
            {
                model = spawnmodel( loc );
                model.origin += anglestoright( model.angles ) * 64;
            }
            
            break;
    }
}

// Namespace ammorestock
// Params 1
// Checksum 0x29eb682c, Offset: 0x1d6b
// Size: 0x85
function spawnmodel( loc )
{
    origin = loc.origin + ( -9.04004, -31.8008, -44 );
    angles = loc.angles + ( 0, 180, 0 );
    model = spawn( "script_model", origin );
    model.angles = angles;
    model setmodel( "military_ammo_restock_location" );
    return model;
}

// Namespace ammorestock
// Params 1
// Checksum 0xc13fa1b9, Offset: 0x1df9
// Size: 0x98
function spawncollision( loc )
{
    if ( !isdefined( level.ammorestockclip ) )
    {
        return;
    }
    
    origin = loc.origin + ( -9.04004, -31.8008, -19.861 );
    angles = loc.angles + ( 0, 90.901, 0 );
    col = spawn( "script_model", origin );
    col.angles = angles;
    col clonebrushmodeltoscriptmodel( level.ammorestockclip );
    return col;
}

// Namespace ammorestock
// Params 1
// Checksum 0xf87b21fd, Offset: 0x1e9a
// Size: 0xa3, Type: bool
function duplicatecheck( loc )
{
    foreach ( ammocache in level.ammorestocklocs )
    {
        if ( distance2dsquared( loc.origin, ammocache.origin ) < 65536 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace ammorestock
// Params 1
// Checksum 0x8aeafed8, Offset: 0x1f46
// Size: 0x968, Type: bool
function function_595f1dbe03eda878( loc )
{
    switch ( level.mapname )
    {
        case #"hash_decd2e8ff1f996d7":
            if ( distance2dsquared( loc.origin, ( 27585, -29335, 3209 ) ) < 65536 || distance2dsquared( loc.origin, ( 32187.5, -34962.8, 3139.13 ) ) < 65536 || distance2dsquared( loc.origin, ( 22908.5, -31250.1, 3192 ) ) < 65536 )
            {
                removelocation( loc );
                return true;
            }
            
            break;
        case #"hash_c8b70146f0c8a9cd":
            if ( distance2dsquared( loc.origin, ( 34922, 16940, 1550 ) ) < 65536 || distance2dsquared( loc.origin, ( 29681, 33095.8, 1674 ) ) < 65536 || distance2dsquared( loc.origin, ( 30032.3, 29652.4, 1669.66 ) ) < 65536 || distance2dsquared( loc.origin, ( 28574.3, 28187.4, 1674 ) ) < 65536 || distance2dsquared( loc.origin, ( 31164.6, 32598.1, 1666 ) ) < 65536 || distance2dsquared( loc.origin, ( 24806.9, 29899.7, 1680 ) ) < 65536 || distance2dsquared( loc.origin, ( 25007.2, 26987.8, 1293 ) ) < 65536 || distance2dsquared( loc.origin, ( 27094.5, 29440, 1674 ) ) < 65536 || distance2dsquared( loc.origin, ( 26380.5, 25555.4, 1677.27 ) ) < 65536 || distance2dsquared( loc.origin, ( 28506.1, 22508.5, 1914.25 ) ) < 65536 || distance2dsquared( loc.origin, ( 30202.3, 23396.5, 1332.92 ) ) < 65536 || distance2dsquared( loc.origin, ( 21877, 27019, 1668 ) ) < 65536 || distance2dsquared( loc.origin, ( 29313.7, 25313, 1258.43 ) ) < 65536 )
            {
                removelocation( loc );
                return true;
            }
            
            break;
        case #"hash_3e552e81b4a21fff":
        case #"hash_ec2ebc1298ef7373":
            if ( distance2dsquared( loc.origin, ( -24068.8, -5005.74, 2080 ) ) < 65536 || distance2dsquared( loc.origin, ( -6611.97, 50858, 288.512 ) ) < 65536 || distance2dsquared( loc.origin, ( -7647.53, 49632.1, 329.7 ) ) < 65536 || distance2dsquared( loc.origin, ( -10818.5, 47390.5, 274.765 ) ) < 65536 || distance2dsquared( loc.origin, ( -9077.3, 47987.4, 360.799 ) ) < 65536 || distance2dsquared( loc.origin, ( -8043.09, 46428.5, 403.384 ) ) < 65536 || distance2dsquared( loc.origin, ( -8052.51, 44386.2, 306.807 ) ) < 65536 || distance2dsquared( loc.origin, ( -9094.11, 44151.5, 297.895 ) ) < 65536 || distance2dsquared( loc.origin, ( -8235.79, 43038.2, 306.207 ) ) < 65536 || distance2dsquared( loc.origin, ( -6724.8, 42424.4, 259.02 ) ) < 65536 || distance2dsquared( loc.origin, ( -7015.17, 40804.3, 218.733 ) ) < 65536 || distance2dsquared( loc.origin, ( -10678.2, 42638.1, 271.852 ) ) < 65536 || distance2dsquared( loc.origin, ( -9775.65, 40978.9, 132.481 ) ) < 65536 || distance2dsquared( loc.origin, ( -8632.71, 39498, 263.335 ) ) < 65536 || distance2dsquared( loc.origin, ( -8842.61, 41604.6, 305.341 ) ) < 65536 || distance2dsquared( loc.origin, ( -10148.6, 39588, 294.909 ) ) < 65536 || distance2dsquared( loc.origin, ( -7032.02, 36217.1, 552.224 ) ) < 65536 || distance2dsquared( loc.origin, ( -7850.63, 37874.3, 422.542 ) ) < 65536 || distance2dsquared( loc.origin, ( -7595.55, 34161, 310.81 ) ) < 65536 || distance2dsquared( loc.origin, ( -23719.8, -3455.37, 2102.24 ) ) < 65536 )
            {
                removelocation( loc );
                return true;
            }
        case #"hash_5586b38644ed9b26":
            if ( distance2dsquared( loc.origin, ( 6003.04, -38388.4, 256.987 ) ) < 65536 || distance2dsquared( loc.origin, ( 4172.42, -36837.8, 333.041 ) ) < 65536 || distance2dsquared( loc.origin, ( 1273.09, -41459.6, 257 ) ) < 65536 || distance2dsquared( loc.origin, ( 1311.22, -39883.5, 252.392 ) ) < 65536 || distance2dsquared( loc.origin, ( 644.51, -41408, 257 ) ) < 65536 || distance2dsquared( loc.origin, ( 1594.75, -37749.8, 252 ) ) < 65536 || distance2dsquared( loc.origin, ( 3059.22, -38664.9, 257.905 ) ) < 65536 || distance2dsquared( loc.origin, ( -2121.11, -42953.5, 257.5 ) ) < 65536 || distance2dsquared( loc.origin, ( -2971.54, -42092.5, 244 ) ) < 65536 || distance2dsquared( loc.origin, ( -4386.93, -43629.1, 242.893 ) ) < 65536 || distance2dsquared( loc.origin, ( -2508.26, -40082.4, 428.444 ) ) < 65536 || distance2dsquared( loc.origin, ( -4990.83, -45574.4, 247.751 ) ) < 65536 || distance2dsquared( loc.origin, ( 3173.23, -41330.2, 300 ) ) < 65536 )
            {
                removelocation( loc );
                return true;
            }
        case #"hash_a11e6e81ea219453":
            if ( distance2dsquared( loc.origin, ( -22231.6, -21681.7, 612 ) ) < 65536 || distance2dsquared( loc.origin, ( 42365, -4481, 786 ) ) < 65536 || distance2dsquared( loc.origin, ( -36878, -23688, 264 ) ) < 65536 || distance2dsquared( loc.origin, ( -36012, -22546, 260 ) ) < 65536 || distance2dsquared( loc.origin, ( -35208, -24096, 264 ) ) < 65536 || distance2dsquared( loc.origin, ( -34808, -22240, 264 ) ) < 65536 || distance2dsquared( loc.origin, ( -31860, -22846, 264 ) ) < 65536 || distance2dsquared( loc.origin, ( -32038, -20154, 272 ) ) < 65536 || distance2dsquared( loc.origin, ( -33783, -23470, 264 ) ) < 65536 || distance2dsquared( loc.origin, ( -33930, -21932, 264 ) ) < 65536 )
            {
                removelocation( loc );
                return true;
            }
            
            break;
    }
    
    return false;
}

// Namespace ammorestock
// Params 6
// Checksum 0xdfdfdc62, Offset: 0x28b7
// Size: 0xcf
function ammorestock_used( instance, part, state, player, bautouse, usestring )
{
    assert( part == "<dev string:x121>" );
    assert( !isbrgamemode() && !isdmzgamemode() );
    result = ammorestock_playeruse( player, instance );
    
    if ( result == 1 )
    {
        thread ammorestock_disableusefortime( instance, player, 0.1 );
        thread function_2c7ced6e527ed331( player, instance, getdvarint( @"ammorestockcooldown", 60 ) );
        return;
    }
    
    if ( result == 0 )
    {
        thread ammorestock_disableusefortime( instance, player, 0.1 );
        return;
    }
    
    thread ammorestock_disableusefortime( instance, player, 0.1 );
}

// Namespace ammorestock
// Params 1
// Checksum 0xadf2e3ab, Offset: 0x298e
// Size: 0x18
function function_5307db144f009fd7( guid )
{
    level.var_c95a4556478f1db8[ guid ] = undefined;
}

// Namespace ammorestock
// Params 2
// Checksum 0xfea0a61, Offset: 0x29ae
// Size: 0x23
function function_6f389aa37b85ac85( guid, instanceindex )
{
    level.var_c95a4556478f1db8[ guid ][ instanceindex ] = undefined;
}

// Namespace ammorestock
// Params 3
// Checksum 0x5838dd6a, Offset: 0x29d9
// Size: 0xb6
function function_2c7ced6e527ed331( player, instance, time )
{
    assert( player );
    assert( instance );
    guid = player player::getuniqueid();
    instanceindex = instance.index;
    level.var_c95a4556478f1db8[ guid ][ instanceindex ] = gettime() + time * 1000;
    level utility::waittill_any_ents_or_timeout_return( time, player, "death_or_disconnect", instance, "death" );
    
    if ( !isdefined( player ) || !player::isreallyalive( player ) )
    {
        function_5307db144f009fd7( guid );
        return;
    }
    
    function_6f389aa37b85ac85( guid, instanceindex );
}

// Namespace ammorestock
// Params 3
// Checksum 0xfc45e292, Offset: 0x2a97
// Size: 0x4b
function ammorestock_disableusefortime( scriptable, player, time )
{
    player endon( #"disconnect" );
    scriptable endon( #"death" );
    scriptable disablescriptableplayeruse( player );
    wait time;
    scriptable enablescriptableplayeruse( player );
}

// Namespace ammorestock
// Params 1
// Checksum 0xcf26667e, Offset: 0x2aea
// Size: 0x53, Type: bool
function function_dc53596deb350dab( equipment_name )
{
    if ( isdefined( equipment_name ) )
    {
        switch ( equipment_name )
        {
            case #"hash_2fd6e4e58e79a638":
            case #"hash_7a24b50365517bba":
            case #"hash_d520713a70b60a2e":
                return false;
            default:
                return true;
        }
    }
    
    return true;
}

// Namespace ammorestock
// Params 1
// Checksum 0xf9dd9aa4, Offset: 0x2b46
// Size: 0xbc, Type: bool
function function_2e55a2cd0291e601( player )
{
    armor = player equipment_mp::getcurrentequipment( "health" );
    
    if ( isdefined( armor ) )
    {
        var_78e7416ea6080fad = player equipment_mp::getequipmentammo( armor );
        maxarmorcount = player equipment_mp::getequipmentmaxammo( armor );
        
        if ( !isdefined( var_78e7416ea6080fad ) || var_78e7416ea6080fad < maxarmorcount )
        {
            player equipment_mp::incrementequipmentammo( armor, maxarmorcount );
        }
        else
        {
            player utility::callsharedfunc( #"hud", #"showerrormessage", %"mp/br_armor_deny_armor_full" );
            player playlocalsound( "fly_pickup_deny" );
            return false;
        }
    }
    
    player damagefeedback::hudicontype( "br_ammo" );
    player playlocalsound( "fly_pickup_ammo_gen" );
    return true;
}

// Namespace ammorestock
// Params 2
// Checksum 0x1a2aedca, Offset: 0x2c0b
// Size: 0xa64
function ammorestock_playeruse( player, instance )
{
    player endon( #"death_or_disconnect" );
    guid = player player::getuniqueid();
    var_cd756e7d601c68cc = 0;
    var_dc5a9fe38546f668 = 0;
    var_f39df42255107ffd = 0;
    var_41dcb4a8e7461a0b = 0;
    var_5eb5eae195791cf6 = 0;
    var_d1f84487d38a5d5b = 0;
    var_21afbaaf534adcdd = "";
    var_52226a7f0df824f5 = 0;
    
    if ( isusingmatchrulesdata() )
    {
        var_cd756e7d601c68cc = getdvarint( @"ammorestockclipnum", getmatchrulesdata( "commonOption", "ammoRestockClipNum" ) );
        var_dc5a9fe38546f668 = getdvarint( @"ammorestocklauncherclipnum", getmatchrulesdata( "commonOption", "ammoRestockLauncherClipNum" ) );
        var_f39df42255107ffd = getdvarint( @"ammorestocksniperclipnum", getmatchrulesdata( "commonOption", "ammoRestockSniperClipNum" ) );
        var_41dcb4a8e7461a0b = getdvarint( @"ammorestockallowsuperweapons", getmatchrulesdata( "commonOption", "ammoRestockAllowSuperWeapons" ) );
        var_5eb5eae195791cf6 = getdvarint( @"ammorestockforceclipsize", getmatchrulesdata( "commonOption", "ammoRestockForceClipSize" ) );
        var_d1f84487d38a5d5b = getdvarint( @"ammorestockmaxequipment", getmatchrulesdata( "commonOption", "ammoRestockMaxEquipment" ) );
        var_21afbaaf534adcdd = getmatchrulesdata( "commonOption", "ammoRestockAmmoIcon" );
        var_52226a7f0df824f5 = getdvarint( @"hash_ffdcf3aa9cb235fe", getmatchrulesdata( "commonOption", "ammoRestockMaxAmmo" ) );
    }
    
    if ( !isdefined( level.var_c95a4556478f1db8[ guid ] ) )
    {
        level.var_c95a4556478f1db8[ guid ] = [];
    }
    
    if ( isdefined( level.var_c95a4556478f1db8[ guid ][ instance.index ] ) )
    {
        /#
        #/
        
        player hud_message::showerrormessage( %"mp_ingame_only/ammo_restock_on_cooldown", int( ( level.var_c95a4556478f1db8[ guid ][ instance.index ] - gettime() ) / 1000 ) );
        player playlocalsound( "fly_pickup_deny" );
        return 2;
    }
    
    if ( function_9a6e9a1f5e1e40ed( instance ) )
    {
        return function_2e55a2cd0291e601( player );
    }
    
    var_f3f1ae1911b3c3c6 = player.primaryweapons;
    temparray = [];
    
    foreach ( item in var_f3f1ae1911b3c3c6 )
    {
        if ( !weapon::ismeleeonly( item ) && ( var_41dcb4a8e7461a0b || !weapon::issuperweapon( item ) ) && !weapon::iskillstreakweapon( item ) && !weapon::isgamemodeweapon( item ) )
        {
            temparray[ temparray.size ] = item;
        }
    }
    
    var_f3f1ae1911b3c3c6 = temparray;
    var_c56e85112f06f7be = 0;
    
    foreach ( weaponobj in var_f3f1ae1911b3c3c6 )
    {
        var_87edbe5766dd0048 = 0;
        
        if ( weapon::function_33e74163843b348e( weaponobj ) )
        {
            if ( player getweaponammoclip( weaponobj ) < weaponclipsize( weaponobj ) )
            {
                continue;
            }
        }
        
        if ( weaponobj.hasalternate )
        {
            weaponaltobj = weaponobj getaltweapon();
            
            if ( player getweaponammostock( weaponaltobj ) < weaponmaxammo( weaponaltobj ) )
            {
                var_87edbe5766dd0048 = 1;
            }
        }
        
        if ( weaponmaxammo( weaponobj ) <= player getweaponammostock( weaponobj ) && !var_87edbe5766dd0048 )
        {
            var_c56e85112f06f7be++;
        }
    }
    
    var_160a158cdd8c6245 = 0;
    
    foreach ( equipobj in player.equipment )
    {
        tableinfo = player equipment_mp::getequipmenttableinfo( equipobj );
        
        if ( isdefined( tableinfo ) )
        {
            var_72aba7d4272c25ae = player equipment_mp::getequipmentmaxammo( equipobj );
            var_e6c9ee5a655526f3 = player equipment_mp::getequipmentammo( equipobj );
            
            if ( var_72aba7d4272c25ae == var_e6c9ee5a655526f3 )
            {
                var_160a158cdd8c6245++;
            }
        }
    }
    
    var_4c48fad50fa1fc28 = [];
    gasmaskrefilled = 0;
    
    if ( isdefined( player.gasmaskmaxhealth ) && getdvarint( @"hash_d2b88b5ac40363ee", 0 ) && player.gasmaskhealth >= 0 && player.gasmaskhealth < player.gasmaskmaxhealth )
    {
        player.gasmaskhealth = player.gasmaskmaxhealth;
        player setclientomnvar( "ui_gasmask_damage", 1 );
        gasmaskrefilled = 1;
    }
    
    if ( var_c56e85112f06f7be == var_f3f1ae1911b3c3c6.size && var_160a158cdd8c6245 == player.equipment.size && !gasmaskrefilled )
    {
        player hud_message::showerrormessage( %"MP_INGAME_ONLY/AMMO_RESTOCK_STOCK_FULL" );
        player playlocalsound( "fly_pickup_deny" );
        return 0;
    }
    else
    {
        foreach ( weaponobj in var_f3f1ae1911b3c3c6 )
        {
            forceclipsize = var_5eb5eae195791cf6;
            
            if ( utility::issharedfuncdefined( #"zombie", #"get_pap_level" ) )
            {
                packlv = player [[ utility::getsharedfunc( #"zombie", #"get_pap_level" ) ]]( weaponobj );
                
                if ( packlv > 0 )
                {
                    forceclipsize = 1;
                }
            }
            
            weapongroup = weapon::getweapongroup( weaponobj );
            clipnum = undefined;
            
            if ( weapon::issinglehitweapon( weaponobj ) )
            {
                clipnum = var_dc5a9fe38546f668 > 0 ? var_dc5a9fe38546f668 : 1;
            }
            else if ( weapongroup == "weapon_sniper" )
            {
                clipnum = var_f39df42255107ffd > 0 ? var_f39df42255107ffd : 3;
            }
            else
            {
                clipnum = var_cd756e7d601c68cc > 0 ? var_cd756e7d601c68cc : 3;
            }
            
            if ( weaponobj.hasalternate && !weapon::function_33e74163843b348e( weaponobj ) )
            {
                weaponaltobj = weaponobj getaltweapon();
                var_cf9a66baeefb77cf = weaponclass( weaponaltobj );
                
                if ( var_cf9a66baeefb77cf == "grenade" )
                {
                    addammo = weapons::getammooverride( weaponaltobj );
                    stockammo = player getweaponammostock( weaponaltobj );
                    newammo = int( stockammo + addammo );
                    player setweaponammostock( weaponaltobj, newammo );
                }
                else if ( weaponaltobj.type == "bullet" )
                {
                    if ( getdvarint( @"hash_9ff8020dd5f23959", 0 ) && isdefined( weaponaltobj.underbarrel ) && weaponaltobj.underbarrel == "jup_ub_flame_01" )
                    {
                        player setweaponammoclip( weaponaltobj, weaponaltobj.clipsize );
                    }
                    else if ( var_cf9a66baeefb77cf == "spread" )
                    {
                        addammo = weapons::getammooverride( weaponaltobj, forceclipsize );
                        stockammo = player getweaponammostock( weaponaltobj );
                        newammo = int( stockammo + addammo );
                        player setweaponammostock( weaponaltobj, newammo );
                    }
                }
                else
                {
                    addammo = weapons::getammooverride( weaponaltobj, forceclipsize );
                    stockammo = player getweaponammostock( weaponaltobj );
                    newammo = int( stockammo + addammo );
                    player setweaponammostock( weaponaltobj, newammo );
                }
            }
            
            addammo = weapons::getammooverride( weaponobj, forceclipsize ) * clipnum;
            stockammo = player getweaponammostock( weaponobj );
            newammo = int( stockammo + addammo );
            
            if ( weapon::function_33e74163843b348e( weaponobj ) )
            {
                player setweaponammoclip( weaponobj, weaponclipsize( weaponobj ) );
            }
            else if ( var_52226a7f0df824f5 )
            {
                max_clip_ammo = weaponclipsize( weaponobj );
                max_stock_ammo = weaponmaxammo( weaponobj );
                player setweaponammoclip( weaponobj, max_clip_ammo );
                player setweaponammostock( weaponobj, max_stock_ammo );
                addammo = max_stock_ammo;
            }
            else
            {
                player setweaponammostock( weaponobj, newammo );
            }
            
            fakepickup = spawnstruct();
            fakepickup.count = addammo;
            fakepickup.ref = var_21afbaaf534adcdd;
            var_4c48fad50fa1fc28[ var_4c48fad50fa1fc28.size ] = fakepickup;
        }
    }
    
    if ( level.var_5ca0fdd41df6590c )
    {
        primary = player equipment_mp::getcurrentequipment( "primary" );
        
        if ( isdefined( primary ) && function_dc53596deb350dab( primary ) )
        {
            var_f6d1f05c41cc8aeb = player equipment_mp::getequipmentammo( primary );
            var_f0a78fa090433bda = player equipment_mp::getequipmentmaxammo( primary, player.class );
            
            if ( var_f6d1f05c41cc8aeb < var_f0a78fa090433bda )
            {
                if ( var_d1f84487d38a5d5b )
                {
                    player equipment_mp::setequipmentslotammo( "primary", var_f0a78fa090433bda );
                }
                else
                {
                    player equipment_mp::incrementequipmentammo( primary );
                }
                
                addammo = player equipment_mp::getequipmentammo( primary ) - var_f6d1f05c41cc8aeb;
                
                if ( addammo > 0 )
                {
                    fakepickup = spawnstruct();
                    fakepickup.count = addammo;
                    fakepickup.ref = primary;
                    var_4c48fad50fa1fc28[ var_4c48fad50fa1fc28.size ] = fakepickup;
                }
            }
        }
        
        secondary = player equipment_mp::getcurrentequipment( "secondary" );
        
        if ( isdefined( secondary ) && function_dc53596deb350dab( secondary ) )
        {
            var_f6d1f05c41cc8aeb = player equipment_mp::getequipmentammo( secondary );
            var_f0a78fa090433bda = player equipment_mp::getequipmentmaxammo( secondary, player.class );
            
            if ( var_f6d1f05c41cc8aeb < var_f0a78fa090433bda )
            {
                if ( var_d1f84487d38a5d5b )
                {
                    player equipment_mp::setequipmentslotammo( "secondary", var_f0a78fa090433bda );
                }
                else
                {
                    player equipment_mp::incrementequipmentammo( secondary );
                }
                
                addammo = player equipment_mp::getequipmentammo( secondary ) - var_f6d1f05c41cc8aeb;
                
                if ( addammo > 0 )
                {
                    fakepickup = spawnstruct();
                    fakepickup.count = addammo;
                    fakepickup.ref = secondary;
                    var_4c48fad50fa1fc28[ var_4c48fad50fa1fc28.size ] = fakepickup;
                }
            }
        }
    }
    
    player damagefeedback::hudicontype( "br_ammo" );
    
    if ( var_4c48fad50fa1fc28.size == 0 && !gasmaskrefilled )
    {
        player hud_message::showerrormessage( "MP_INGAME_ONLY/AMMO_RESTOCK_STOCK_FULL" );
        player playlocalsound( "fly_pickup_deny" );
        return 0;
    }
    
    if ( utility::issharedfuncdefined( #"game", #"showStockLootFeed" ) )
    {
        level thread [[ utility::getsharedfunc( #"game", #"showStockLootFeed" ) ]]( player, var_4c48fad50fa1fc28 );
    }
    
    player playlocalsound( "fly_pickup_ammo_gen" );
    return 1;
}

// Namespace ammorestock
// Params 0
// Checksum 0x52735066, Offset: 0x3678
// Size: 0x2a4
function ammorestock_customlocale6cleanup()
{
    var_ddfab4bd0bf8cb43 = [];
    var_ddfab4bd0bf8cb43[ 0 ] = ( 15946, -71, -469 );
    var_ddfab4bd0bf8cb43[ 1 ] = ( 16829, -8996, -333 );
    var_ddfab4bd0bf8cb43[ 2 ] = ( 16531, -13847, -154 );
    var_ddfab4bd0bf8cb43[ 3 ] = ( 24472, -14782, -134 );
    var_ddfab4bd0bf8cb43[ 4 ] = ( 22373, -19948, -36 );
    var_ddfab4bd0bf8cb43[ 5 ] = ( 18250, -2057, -439 );
    var_ddfab4bd0bf8cb43[ 6 ] = ( 17549, -4262, -432 );
    var_ddfab4bd0bf8cb43[ 7 ] = ( 19147, -11546, -257 );
    var_ddfab4bd0bf8cb43[ 8 ] = ( 19845, -21990, -98 );
    var_ddfab4bd0bf8cb43[ 9 ] = ( 19838, -18100, -23 );
    var_ddfab4bd0bf8cb43[ 10 ] = ( 21978, -11276, -58 );
    
    foreach ( loc in level.ammorestocklocs )
    {
        var_3b3ac614c0ebfb81 = 0;
        
        foreach ( var_9b755226b5f484ef in var_ddfab4bd0bf8cb43 )
        {
            if ( var_3b3ac614c0ebfb81 )
            {
                break;
            }
            
            if ( distance2dsquared( loc.origin, var_9b755226b5f484ef ) < 10000 )
            {
                var_3b3ac614c0ebfb81 = 1;
            }
        }
        
        if ( var_3b3ac614c0ebfb81 )
        {
            targetents = getentarray( loc.target, #targetname );
            
            foreach ( ent in targetents )
            {
                ent disable_internal();
                
                if ( ent.classname == "script_model" )
                {
                    ent delete();
                    continue;
                }
                
                ent delete();
            }
            
            loc disable_internal();
            loc delete();
        }
    }
}

