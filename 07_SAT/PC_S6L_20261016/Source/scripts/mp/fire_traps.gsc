// scripts\mp\fire_traps.gsc  (hash_72d6af97cfc97305.gscc) (size: 6864 Bytes / 0x1ad0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7780f27c (2004939388)
// size ...... 6864 (0x1ad0)
// includes .. 4   (offset: 0x18fc)
// strings ... 23  (offset: 0x191c)
// dev strs .. 0   (offset: 0x1ad0)
// exports ... 18  (offset: 0x1144)
// cseg ...... 0x1c9 + 0xf7b (0x1144)
// imports ... 40  (offset: 0x1414)
// animtree1 . 0   (offset: 0x1ad0)
// animtree2 . 0   (offset: 0x1ad0)
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\mp\flags;
#using scripts\mp\poi;

#namespace fire_traps;

// Namespace fire_traps
// Params 0
// Checksum 0x843217bb, Offset: 0x1e7
// Size: 0x2c6
function init()
{
    if ( getdvarint( @"scr_fire_traps_active", 1 ) == 0 )
    {
        return;
    }
    
    if ( !isdefined( level.var_1b7719e8fe46996d ) )
    {
        level.var_1b7719e8fe46996d = spawn( "script_origin", ( 0, 0, 0 ) );
        level.var_1b7719e8fe46996d.targetname = "fire_traps_init";
    }
    
    level.firetraps = spawnstruct();
    level.firetraps.traps = [];
    level.firetraps.var_7de9f530917919d3 = &function_2e70d2f856601b21;
    level.firetraps.nodesprocessed = 0;
    isactive = getdvarint( @"hash_70609fe5b82bd193", 1 );
    level.firetraps.traps[ "fireBarrel" ] = spawnstruct();
    level.firetraps.traps[ "fireBarrel" ].spawnfunction = &function_6f65f55ab7fa812a;
    level.firetraps.traps[ "fireBarrel" ].isactive = isactive;
    level.firetraps.traps[ "fireBarrel" ].var_1d570366f0dea95b = 0;
    isactive = getdvarint( @"hash_2d32cef4a90c84a4", 1 );
    level.firetraps.traps[ "gasPuddle" ] = spawnstruct();
    level.firetraps.traps[ "gasPuddle" ].spawnfunction = &function_fc0d6405fd4c22c3;
    level.firetraps.traps[ "gasPuddle" ].isactive = isactive;
    level.firetraps.traps[ "gasPuddle" ].var_1d570366f0dea95b = 10;
    level.firetraps.traps[ "gasPuddle" ].burntime = getdvarint( @"hash_3ea718dbf08ff7fe", 60 );
    isactive = getdvarint( @"hash_d02af883782d0eb9", 1 );
    level.firetraps.traps[ "gasLeak" ] = spawnstruct();
    level.firetraps.traps[ "gasLeak" ].spawnfunction = &function_d40bdd3940caa67c;
    level.firetraps.traps[ "gasLeak" ].isactive = isactive;
    level thread function_d14ea69ad7d4a63a();
    scriptable::scriptable_adddamagedcallback( &function_64e66710f1c81687 );
    
    /#
    #/
}

// Namespace fire_traps
// Params 0
// Checksum 0x58d1a36c, Offset: 0x4b5
// Size: 0x71
function function_d14ea69ad7d4a63a()
{
    while ( !utility::flag_exist( "create_script_initialized" ) )
    {
        waitframe();
    }
    
    utility::flag_wait( "create_script_initialized" );
    waitframe();
    level.firetraps.activetraptypes = [];
    function_e40badc24a5049a7( "fireBarrel" );
    function_e40badc24a5049a7( "gasPuddle" );
    function_e40badc24a5049a7( "gasLeak" );
    level.firetraps.nodesprocessed = 1;
}

// Namespace fire_traps
// Params 1
// Checksum 0xfc76cfa1, Offset: 0x52e
// Size: 0x1dd
function function_e40badc24a5049a7( traptype )
{
    var_5bfa24b285fac405 = poi::poi_issystemactive();
    
    if ( var_5bfa24b285fac405 )
    {
        utility::callsharedfunc( #"poi", #"subarea_addfeaturearray", traptype );
    }
    
    if ( function_2eda0c1de1df96e3( traptype ) )
    {
        level.firetraps.activetraptypes[ level.firetraps.activetraptypes.size ] = traptype;
        level.firetraps.traps[ traptype ].potentialspawns = [];
        var_fbc43ed7ec7917d2 = utility::getstructarray( traptype, "script_noteworthy" );
        
        foreach ( struct in var_fbc43ed7ec7917d2 )
        {
            if ( isdefined( struct.targetname ) && issubstr( struct.targetname, "auto" ) )
            {
                continue;
            }
            
            level.firetraps.traps[ traptype ].potentialspawns[ level.firetraps.traps[ traptype ].potentialspawns.size ] = struct;
            
            if ( var_5bfa24b285fac405 )
            {
                if ( !isdefined( struct.script_poi ) )
                {
                    struct.script_poi = poi::poi_findpoioriginisin( struct.origin, 1, 1 );
                }
                
                utility::callsharedfunc( #"poi", #"subarea_registerfeatureelement", struct.script_poi, traptype, struct );
            }
        }
    }
}

// Namespace fire_traps
// Params 0
// Checksum 0xeaf2c5e7, Offset: 0x713
// Size: 0x140
function function_2e70d2f856601b21()
{
    while ( !level.firetraps.nodesprocessed )
    {
        waitframe();
    }
    
    foreach ( traptype in level.firetraps.activetraptypes )
    {
        foreach ( node in level.firetraps.traps[ traptype ].potentialspawns )
        {
            thread [[ level.firetraps.traps[ traptype ].spawnfunction ]]( node );
        }
    }
}

// Namespace fire_traps
// Params 1
// Checksum 0xb720f58c, Offset: 0x85b
// Size: 0x2c
function function_2eda0c1de1df96e3( traptype )
{
    return level.firetraps.traps[ traptype ].isactive;
}

// Namespace fire_traps
// Params 1
// Checksum 0x4c8f0f99, Offset: 0x890
// Size: 0xaa
function function_6f65f55ab7fa812a( node )
{
    if ( getdvarint( @"scr_fire_traps_active", 1 ) == 0 )
    {
        return;
    }
    
    if ( !flags::gameflagexists( "prematch_done" ) || flags::gameflagexists( "prematch_done" ) && !flags::gameflag( "prematch_done" ) )
    {
        wait level.firetraps.traps[ "fireBarrel" ].var_1d570366f0dea95b;
    }
    
    scriptable = spawnscriptable( "decor_barrels_gameplay_flammable_noent", node.origin, node.angles );
    level thread function_e28a69eaf48e5969( scriptable );
    return scriptable;
}

// Namespace fire_traps
// Params 1
// Checksum 0xad72eeea, Offset: 0x943
// Size: 0xe9
function function_e28a69eaf48e5969( scriptable )
{
    level endon( #"game_ended" );
    exploded = 0;
    explosionradius = 206;
    
    while ( !exploded )
    {
        scriptablestate = scriptable getscriptablepartstate( "base" );
        
        if ( !isdefined( scriptablestate ) )
        {
            return;
        }
        
        if ( scriptablestate == "death" )
        {
            if ( isdefined( scriptable.fortress ) )
            {
                scriptable.fortress notify( #"barrelexploded" );
            }
            
            exploded = 1;
            
            if ( isdefined( scriptable.lastattacker ) )
            {
                attacker = scriptable.lastattacker;
            }
            else
            {
                attacker = level.var_1b7719e8fe46996d;
            }
            
            level.var_1b7719e8fe46996d radiusdamage( scriptable.origin, explosionradius, 150, 50, attacker, "MOD_EXPLOSIVE", "rex_molotov_mp" );
        }
        
        waitframe();
    }
}

// Namespace fire_traps
// Params 11
// Checksum 0x5cef65d9, Offset: 0xa34
// Size: 0x88
function function_64e66710f1c81687( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( instance.type == "decor_barrels_gameplay_flammable_noent" )
    {
        instance.lastattacker = eattacker;
    }
}

// Namespace fire_traps
// Params 1
// Checksum 0xdf721201, Offset: 0xac4
// Size: 0x101
function function_fc0d6405fd4c22c3( node )
{
    if ( getdvarint( @"scr_fire_traps_active", 1 ) == 0 )
    {
        return;
    }
    
    if ( !flags::gameflagexists( "prematch_done" ) || flags::gameflagexists( "prematch_done" ) && !flags::gameflag( "prematch_done" ) )
    {
        wait level.firetraps.traps[ "gasPuddle" ].var_1d570366f0dea95b;
    }
    
    scriptable = spawnscriptable( "dmz_firetrap_gaspuddle", node.origin, node.angles + ( 0, 90, 0 ) );
    scriptable.node = node;
    puddleradius = 75;
    prelit = undefined;
    
    if ( isdefined( node.special_state ) )
    {
        prelit = node.special_state == "prelit";
    }
    
    level thread function_a6ffb50f50ed245a( scriptable, puddleradius, prelit );
    return scriptable;
}

// Namespace fire_traps
// Params 3
// Checksum 0x38f8c7e8, Offset: 0xbce
// Size: 0xc5
function function_a6ffb50f50ed245a( scriptable, radius, prelit )
{
    level endon( #"game_ended" );
    burning = 0;
    
    while ( !burning )
    {
        if ( prelit )
        {
            waitframe();
            scriptable setscriptablepartstate( "base", "death" );
        }
        
        scriptablestate = scriptable getscriptablepartstate( "base" );
        
        if ( scriptablestate == "death" )
        {
            size = radius * 0.7;
            navobstacle = createnavobstaclebybounds( scriptable.origin, ( size, size, size ), scriptable.angles );
            level thread function_4e1a03ec38e38751( scriptable, radius, prelit, navobstacle );
            burning = 1;
        }
        
        waitframe();
    }
}

// Namespace fire_traps
// Params 4
// Checksum 0xa21f7656, Offset: 0xc9b
// Size: 0xe1
function function_4e1a03ec38e38751( scriptable, radius, prelit, navobstacle )
{
    level endon( #"game_ended" );
    elapsedtime = 0;
    
    for ( keepburning = 1; keepburning ; keepburning = 0 )
    {
        level.var_1b7719e8fe46996d radiusdamage( scriptable.origin, radius, 5, 5, level.var_1b7719e8fe46996d, "MOD_FIRE", "rex_molotov_mp", 0, 0 );
        wait 1;
        
        if ( !prelit )
        {
            elapsedtime++;
            
            if ( elapsedtime >= level.firetraps.traps[ "gasPuddle" ].burntime )
            {
            }
        }
    }
    
    if ( isdefined( navobstacle ) )
    {
        destroynavobstacle( navobstacle );
    }
    
    scriptable setscriptablepartstate( "base", "off" );
}

// Namespace fire_traps
// Params 1
// Checksum 0x2cd0ff97, Offset: 0xd84
// Size: 0xae
function function_d40bdd3940caa67c( node )
{
    if ( getdvarint( @"scr_fire_traps_active", 1 ) == 0 )
    {
        return;
    }
    
    scriptable = spawnscriptable( "dmz_firetrap_gasleak", node.origin, node.angles );
    scriptable.node = node;
    scriptable.state = "off";
    
    if ( node.script_poi == "saba_S5Reveal" )
    {
        if ( !isdefined( level.var_e326b2fb09c32414 ) )
        {
            level.var_e326b2fb09c32414 = [];
        }
        
        level.var_e326b2fb09c32414[ level.var_e326b2fb09c32414.size ] = scriptable;
    }
    
    return scriptable;
}

// Namespace fire_traps
// Params 0
// Checksum 0xc31d2470, Offset: 0xe3b
// Size: 0xac
function function_65a5a73d615d7fdb()
{
    switch ( self.state )
    {
        case #"hash_3699ac6c262c25ea":
            self.state = "small";
            self setscriptablepartstate( "base", "small" );
            return self;
        case #"hash_5971965ed985a26c":
            self.state = "heavy";
            self setscriptablepartstate( "base", "heavy" );
            return self;
        case #"hash_2453c9ffec9f5c20":
            self.state = "damaging";
            self setscriptablepartstate( "base", "damaging" );
            thread function_554250293f88b294();
            return self;
        case #"hash_b06b2bd0fb6506bb":
            return self;
    }
}

// Namespace fire_traps
// Params 0
// Checksum 0x28ac7821, Offset: 0xeef
// Size: 0x2c
function function_8d102c6946c749dd()
{
    if ( self.state == "damaging" )
    {
        return;
    }
    
    self setscriptablepartstate( "base", "damaging" );
    thread function_554250293f88b294();
}

// Namespace fire_traps
// Params 0
// Checksum 0x2df48f4a, Offset: 0xf23
// Size: 0x77
function function_554250293f88b294()
{
    level endon( #"game_ended" );
    damageorigin = self.origin + rotatevector( ( 0, 120, 0 ), self.angles );
    
    while ( true )
    {
        level.var_1b7719e8fe46996d radiusdamage( damageorigin, 40, 4, 4, level.var_1b7719e8fe46996d, "MOD_FIRE", "rex_molotov_mp", 0, 0 );
        wait 0.2;
    }
}

// Namespace fire_traps
// Params 0
// Checksum 0xe37c0d17, Offset: 0xfa2
// Size: 0xeb
function function_79ce7c38029bb78a()
{
    wait 10;
    struct = spawnstruct();
    struct.origin = ( 974, 1932, 128 );
    struct.angles = ( 0, 0, 0 );
    function_6f65f55ab7fa812a( struct );
    struct = spawnstruct();
    struct.origin = ( 990, 2135, 135 );
    struct.angles = ( 0, 0, 0 );
    function_fc0d6405fd4c22c3( struct );
    struct = spawnstruct();
    struct.origin = ( 1230, 2339, 145 );
    struct.angles = ( 0, 180, 0 );
    struct.angles = ( 0, 0, 0 );
    function_d40bdd3940caa67c( struct );
}

// Namespace fire_traps
// Params 0
// Checksum 0x50887705, Offset: 0x1095
// Size: 0xaf
function firetrap_debug()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( getdvarint( @"hash_586023952faae9bc", 0 ) )
        {
            setdvar( @"hash_586023952faae9bc", 0 );
            node = spawnstruct();
            node.origin = level.players[ 0 ].origin + anglestoforward( level.players[ 0 ].angles ) * 100;
            node.angles = level.players[ 0 ].angles;
            function_6f65f55ab7fa812a( node );
        }
        
        waitframe();
    }
}

