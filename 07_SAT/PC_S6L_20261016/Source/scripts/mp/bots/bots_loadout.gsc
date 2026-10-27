// scripts\mp\bots\bots_loadout.gsc  (hash_715b1ae771ea5b66.gscc) (size: 15279 Bytes / 0x3baf / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x34f326f1 (888350449)
// size ...... 15279 (0x3baf)
// includes .. 7   (offset: 0x37f7)
// strings ... 41  (offset: 0x382f)
// dev strs .. 22  (offset: 0x3a47)
// exports ... 19  (offset: 0x2bc3)
// cseg ...... 0x235 + 0x298e (0x2bc3)
// imports ... 70  (offset: 0x2ebb)
// animtree1 . 0   (offset: 0x3baf)
// animtree2 . 0   (offset: 0x3baf)
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\bots\bots;
#using scripts\mp\class;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\weapon;

#namespace bots_loadout;

// Namespace bots_loadout
// Params 0
// Checksum 0xf06ce996, Offset: 0x253
// Size: 0xed
function init()
{
    level.botloadouts = spawnstruct();
    level.botloadouts.loadouts = [];
    level.botloadouts.loadoutsets = [];
    level.var_3beefd63b25fbb90 = [];
    level.botloadouts.initialized = 0;
    function_1c7880bdc80d07bc();
    function_82ce79c908588449();
    
    /#
        setdevdvarifuninitialized( @"hash_8f22d0a2bc0d7f30", 0 );
        setdevdvarifuninitialized( @"hash_7454b5e6ca849775", "<dev string:x24>" );
        setdevdvarifuninitialized( @"hash_6329fb6de82ba4d1", "<dev string:x24>" );
        setdevdvarifuninitialized( @"hash_d92dfc29f9af81bb", "<dev string:x24>" );
        setdevdvarifuninitialized( @"hash_a05a1967759feb7f", "<dev string:x24>" );
        setdevdvarifuninitialized( @"hash_52a5487e07ba8cd0", "<dev string:x24>" );
    #/
    
    level.botloadouts.initialized = 1;
}

// Namespace bots_loadout
// Params 0, eflags: 0x4
// Checksum 0x243f9ee8, Offset: 0x348
// Size: 0xf36
function private function_1c7880bdc80d07bc()
{
    var_e01ecb23fd9e9582 = level.gamemodebundle.var_4c34ed2963279005;
    
    foreach ( var_4085dc00f6569d80 in level.gamemodebundle.var_61330581b3e3a9e7 )
    {
        if ( isdefined( var_4085dc00f6569d80.var_4c34ed2963279005 ) )
        {
            var_e01ecb23fd9e9582 = var_4085dc00f6569d80.var_4c34ed2963279005;
            break;
        }
    }
    
    if ( isdefined( level.gametypebundle.botloadoutoverride ) )
    {
        var_e01ecb23fd9e9582 = level.gametypebundle.botloadoutoverride;
    }
    
    assert( isxhashasset( var_e01ecb23fd9e9582 ) );
    var_6233d3a3e8c1b47e = getscriptbundle( var_e01ecb23fd9e9582 );
    
    if ( !isdefined( var_6233d3a3e8c1b47e ) )
    {
        assertmsg( "<dev string:x25>" + getxhashsourcename( var_e01ecb23fd9e9582 ?? "<dev string:x79>" ) );
        return;
    }
    
    /#
        devgui::function_9082edeb5db93280( "<dev string:x83>" );
    #/
    
    foreach ( botloadout in var_6233d3a3e8c1b47e.botloadoutlist )
    {
        botloadoutname = botloadout.loadout;
        botloadoutscriptbundle = getscriptbundle( "botloadout:" + botloadoutname );
        
        if ( !isdefined( botloadoutscriptbundle ) )
        {
            assertmsg( "<dev string:x9f>" );
            continue;
        }
        
        botloadoutscriptbundle.archetype = "assault";
        
        if ( isdefined( botloadoutscriptbundle.equipment.primarytemplate ) )
        {
            var_30213667cde1e6c2 = getscriptbundle( hashcat( %"hash_5f1d2dca9000edf3", botloadoutscriptbundle.equipment.primarytemplate ) );
            
            if ( !isdefined( var_30213667cde1e6c2 ) )
            {
                assertmsg( "<dev string:xec>" + botloadoutscriptbundle.equipment.primarytemplate );
                return;
            }
            
            botloadoutscriptbundle.equipment.primary = [];
            
            foreach ( loadoutitem in var_30213667cde1e6c2.loadoutitems )
            {
                botloadoutscriptbundle.equipment.primary[ botloadoutscriptbundle.equipment.primary.size ] = loadoutitem.value;
            }
            
            botloadoutscriptbundle.equipment.primarytemplate = undefined;
        }
        else if ( isdefined( botloadoutscriptbundle.equipment.primary ) )
        {
            botloadoutscriptbundle.equipment.primary = strtok( botloadoutscriptbundle.equipment.primary, "|" );
        }
        
        /#
            foreach ( primaryequipment in botloadoutscriptbundle.equipment.primary )
            {
                if ( primaryequipment != "<dev string:x123>" && !isdefined( level.equipment.table[ primaryequipment ] ) )
                {
                    assertmsg( "<dev string:x128>" + primaryequipment + "<dev string:x149>" + botloadout.loadout + "<dev string:x162>" + getxhashsourcename( getgamemodescriptbundlename() ) + "<dev string:x179>" );
                }
            }
        #/
        
        if ( isdefined( botloadoutscriptbundle.equipment.secondarytemplate ) )
        {
            var_a4325e4ed2fa572 = getscriptbundle( hashcat( %"hash_5f1d2dca9000edf3", botloadoutscriptbundle.equipment.secondarytemplate ) );
            
            if ( !isdefined( var_a4325e4ed2fa572 ) )
            {
                assertmsg( "<dev string:xec>" + botloadoutscriptbundle.equipment.secondarytemplate );
                return;
            }
            
            botloadoutscriptbundle.equipment.secondary = [];
            
            foreach ( loadoutitem in var_a4325e4ed2fa572.loadoutitems )
            {
                botloadoutscriptbundle.equipment.secondary[ botloadoutscriptbundle.equipment.secondary.size ] = loadoutitem.value;
            }
            
            botloadoutscriptbundle.equipment.secondarytemplate = undefined;
        }
        else if ( isdefined( botloadoutscriptbundle.equipment.secondary ) )
        {
            botloadoutscriptbundle.equipment.secondary = strtok( botloadoutscriptbundle.equipment.secondary, "|" );
        }
        
        /#
            foreach ( secondaryequipment in botloadoutscriptbundle.equipment.secondary )
            {
                if ( secondaryequipment != "<dev string:x123>" && !isdefined( level.equipment.table[ secondaryequipment ] ) )
                {
                    assertmsg( "<dev string:x1a3>" + secondaryequipment + "<dev string:x149>" + botloadout.loadout + "<dev string:x162>" + getxhashsourcename( getgamemodescriptbundlename() ) + "<dev string:x179>" );
                }
            }
        #/
        
        if ( isdefined( botloadoutscriptbundle.fieldUpgrades.fieldupgrade1 ) )
        {
            var_fbff274ff7d254ab = getscriptbundle( hashcat( %"hash_5f1d2dca9000edf3", botloadoutscriptbundle.fieldUpgrades.fieldupgrade1 ) );
            
            if ( !isdefined( var_fbff274ff7d254ab ) )
            {
                assertmsg( "<dev string:xec>" + botloadoutscriptbundle.fieldUpgrades.fieldupgrade1 );
                return;
            }
            
            botloadoutscriptbundle.fieldUpgrades.fieldupgrade1 = [];
            
            foreach ( loadoutitem in var_fbff274ff7d254ab.loadoutitems )
            {
                if ( superisrestricted( loadoutitem.value ) )
                {
                    continue;
                }
                
                botloadoutscriptbundle.fieldUpgrades.fieldupgrade1[ botloadoutscriptbundle.fieldUpgrades.fieldupgrade1.size ] = loadoutitem.value;
            }
        }
        
        /#
            foreach ( fieldupgrade in botloadoutscriptbundle.fieldUpgrades.fieldupgrade1 )
            {
                if ( !isdefined( level.superglobals.staticsuperdata[ fieldupgrade ] ) )
                {
                    assertmsg( "<dev string:x1c6>" + fieldupgrade + "<dev string:x149>" + botloadout.loadout + "<dev string:x162>" + getxhashsourcename( getgamemodescriptbundlename() ) + "<dev string:x179>" );
                }
            }
        #/
        
        if ( isdefined( botloadoutscriptbundle.killstreaks.killstreaktemplate ) )
        {
            var_259524d8a7611fcf = getscriptbundle( hashcat( %"hash_5f1d2dca9000edf3", botloadoutscriptbundle.killstreaks.killstreaktemplate ) );
            
            if ( !isdefined( var_259524d8a7611fcf ) )
            {
                assertmsg( "<dev string:xec>" + botloadoutscriptbundle.killstreaks.killstreaktemplate );
                return;
            }
            
            botloadoutscriptbundle.killstreaks.killstreak1 = undefined;
            botloadoutscriptbundle.killstreaks.killstreak2 = undefined;
            botloadoutscriptbundle.killstreaks.killstreak3 = undefined;
            botloadoutscriptbundle.killstreaks.templatearray = [];
            
            foreach ( loadoutitem in var_259524d8a7611fcf.loadoutitems )
            {
                botloadoutscriptbundle.killstreaks.templatearray[ botloadoutscriptbundle.killstreaks.templatearray.size ] = loadoutitem.value;
            }
            
            botloadoutscriptbundle.killstreaks.killstreaktemplate = undefined;
        }
        
        level.botloadouts.loadouts[ botloadoutname ] = botloadoutscriptbundle;
        personalitylist = [];
        difficultylist = [];
        
        if ( isdefined( botloadoutscriptbundle.personality ) )
        {
            if ( botloadoutscriptbundle.personality.camper )
            {
                personalitylist[ personalitylist.size ] = "camper";
            }
            
            if ( botloadoutscriptbundle.personality.runandgun )
            {
                personalitylist[ personalitylist.size ] = "run_and_gun";
            }
            
            if ( botloadoutscriptbundle.personality.cqb )
            {
                personalitylist[ personalitylist.size ] = "cqb";
            }
        }
        
        if ( isdefined( botloadoutscriptbundle.difficulty ) )
        {
            if ( botloadoutscriptbundle.difficulty.casual )
            {
                difficultylist[ difficultylist.size ] = "casual";
            }
            
            if ( botloadoutscriptbundle.difficulty.recruit )
            {
                difficultylist[ difficultylist.size ] = "recruit";
            }
            
            if ( botloadoutscriptbundle.difficulty.regular )
            {
                difficultylist[ difficultylist.size ] = "regular";
            }
            
            if ( botloadoutscriptbundle.difficulty.hardened )
            {
                difficultylist[ difficultylist.size ] = "hardened";
            }
            
            if ( botloadoutscriptbundle.difficulty.veteran )
            {
                difficultylist[ difficultylist.size ] = "veteran";
            }
            
            if ( botloadoutscriptbundle.difficulty.elite )
            {
                difficultylist[ difficultylist.size ] = "elite";
            }
            
            if ( botloadoutscriptbundle.difficulty.master )
            {
                difficultylist[ difficultylist.size ] = "master";
            }
        }
        
        foreach ( personality in personalitylist )
        {
            foreach ( difficulty in difficultylist )
            {
                botloadoutsetkey = function_793fd3328037dd9f( personality, difficulty );
                
                if ( !isdefined( level.botloadouts.loadoutsets[ botloadoutsetkey ] ) )
                {
                    level.botloadouts.loadoutsets[ botloadoutsetkey ] = [];
                }
                
                var_819f2a26f0529b32 = level.botloadouts.loadoutsets[ botloadoutsetkey ].size;
                level.botloadouts.loadoutsets[ botloadoutsetkey ][ var_819f2a26f0529b32 ] = botloadoutname;
            }
        }
        
        botloadoutscriptbundle._internal = spawnstruct();
        botloadoutscriptbundle._internal.botpersonality = botloadoutscriptbundle.personality;
        botloadoutscriptbundle.personality = undefined;
        botloadoutscriptbundle._internal.botdifficulty = botloadoutscriptbundle.difficulty;
        botloadoutscriptbundle.difficulty = undefined;
        weapons = [ botloadoutscriptbundle.primaryweapon ];
        
        foreach ( var_458e07aa693477c9 in weapons )
        {
            weaponname = var_458e07aa693477c9.weapon;
            
            if ( isdefined( weaponname ) && weaponname != "none" )
            {
                if ( !isdefined( level.var_3beefd63b25fbb90[ weaponname ] ) )
                {
                    level.var_3beefd63b25fbb90[ weaponname ] = [];
                }
                
                foreach ( personality in personalitylist )
                {
                    if ( !arraycontains( level.var_3beefd63b25fbb90[ weaponname ], personality ) )
                    {
                        level.var_3beefd63b25fbb90[ weaponname ][ level.var_3beefd63b25fbb90[ weaponname ].size ] = personality;
                    }
                }
            }
        }
        
        /#
            devgui::add_devgui_command( botloadoutname, "<dev string:x1db>" + botloadoutname );
        #/
    }
    
    /#
        devgui::function_77df7fe7dd273e10();
    #/
}

// Namespace bots_loadout
// Params 0
// Checksum 0x2febcc57, Offset: 0x1286
// Size: 0xd5
function function_82ce79c908588449()
{
    var_d412625358c0e8be = getdvar( @"hash_536fb96e928e1c53", "" );
    
    if ( var_d412625358c0e8be != "" )
    {
        level.botloadouts.overrideskins = [];
        tablename = "mp/" + var_d412625358c0e8be;
        numrows = tablelookupgetnumrows( tablename );
        
        for ( rownum = 0; rownum < numrows ; rownum++ )
        {
            skinname = tablelookupbyrow( tablename, rownum, 0 );
            level.botloadouts.overrideskins[ level.botloadouts.overrideskins.size ] = skinname;
        }
        
        assert( level.botloadouts.overrideskins.size > 0 );
    }
}

// Namespace bots_loadout
// Params 2, eflags: 0x4
// Checksum 0xbf273afa, Offset: 0x1363
// Size: 0x20
function private function_793fd3328037dd9f( personality, difficulty )
{
    return personality + "_" + difficulty;
}

// Namespace bots_loadout
// Params 0
// Checksum 0x80131681, Offset: 0x138c
// Size: 0x4ec
function function_6cf568c868aff953()
{
    default_class_options = [ "default1", "default2", "default3", "default4", "default5" ];
    default_class_picked = utility::array_random( default_class_options );
    default_class_picked = class::getclasschoice( default_class_picked );
    var_347e18171e73c6c0 = class::loadout_getclassstruct();
    class::loadout_updateclassdefault( var_347e18171e73c6c0, default_class_picked );
    defaultloadout = spawnstruct();
    defaultloadout.archetype = "assault";
    defaultloadout.primaryweapon = spawnstruct();
    defaultloadout.primaryweapon.weapon = var_347e18171e73c6c0.loadoutprimary;
    defaultloadout.primaryweapon.attachment1 = var_347e18171e73c6c0.loadoutprimaryattachments[ 0 ];
    defaultloadout.primaryweapon.attachment2 = var_347e18171e73c6c0.loadoutprimaryattachments[ 1 ];
    defaultloadout.primaryweapon.attachment3 = var_347e18171e73c6c0.loadoutprimaryattachments[ 2 ];
    defaultloadout.primaryweapon.attachment4 = var_347e18171e73c6c0.loadoutprimaryattachments[ 3 ];
    defaultloadout.primaryweapon.attachment5 = var_347e18171e73c6c0.loadoutprimaryattachments[ 4 ];
    defaultloadout.primaryweapon.attachment6 = var_347e18171e73c6c0.loadoutprimaryattachments[ 5 ];
    defaultloadout.primaryweapon.camo = var_347e18171e73c6c0.loadoutprimarycamo;
    defaultloadout.primaryweapon.chroma = var_347e18171e73c6c0.var_69ae546f481034e2;
    defaultloadout.primaryweapon.reticle = var_347e18171e73c6c0.loadoutprimaryreticle;
    defaultloadout.secondaryweapon = spawnstruct();
    defaultloadout.secondaryweapon.weapon = var_347e18171e73c6c0.loadoutsecondary;
    defaultloadout.secondaryweapon.attachment1 = var_347e18171e73c6c0.loadoutsecondaryattachments[ 0 ];
    defaultloadout.secondaryweapon.attachment2 = var_347e18171e73c6c0.loadoutsecondaryattachments[ 1 ];
    defaultloadout.secondaryweapon.attachment3 = var_347e18171e73c6c0.loadoutsecondaryattachments[ 2 ];
    defaultloadout.secondaryweapon.attachment4 = var_347e18171e73c6c0.loadoutsecondaryattachments[ 3 ];
    defaultloadout.secondaryweapon.attachment5 = var_347e18171e73c6c0.loadoutsecondaryattachments[ 4 ];
    defaultloadout.secondaryweapon.camo = var_347e18171e73c6c0.loadoutsecondarycamo;
    defaultloadout.secondaryweapon.chroma = var_347e18171e73c6c0.var_2bab3f4f3d38584a;
    defaultloadout.secondaryweapon.reticle = var_347e18171e73c6c0.loadoutsecondaryreticle;
    defaultloadout.tertiaryWeapon = spawnstruct();
    defaultloadout.tertiaryWeapon.weapon = var_347e18171e73c6c0.loadouttertiary;
    defaultloadout.equipment = spawnstruct();
    defaultloadout.equipment.primary = var_347e18171e73c6c0.loadoutequipmentprimary;
    defaultloadout.equipment.secondary = var_347e18171e73c6c0.loadoutequipmentsecondary;
    defaultloadout.perks = spawnstruct();
    defaultloadout.perks.perk1 = var_347e18171e73c6c0.loadoutperks[ 0 ];
    defaultloadout.perks.perk2 = var_347e18171e73c6c0.loadoutperks[ 1 ];
    defaultloadout.perks.perk3 = var_347e18171e73c6c0.loadoutperks[ 2 ];
    defaultloadout.extraperks = spawnstruct();
    defaultloadout.extraperks.perk1 = var_347e18171e73c6c0.loadoutextraperks[ 0 ];
    defaultloadout.extraperks.perk2 = var_347e18171e73c6c0.loadoutextraperks[ 1 ];
    defaultloadout.extraperks.perk3 = var_347e18171e73c6c0.loadoutextraperks[ 2 ];
    defaultloadout.gesture = var_347e18171e73c6c0.loadoutgesture;
    defaultloadout.fieldupgrade1 = var_347e18171e73c6c0.loadoutfieldupgrade1;
    return defaultloadout;
}

// Namespace bots_loadout
// Params 1
// Checksum 0x28c55008, Offset: 0x1881
// Size: 0x55, Type: bool
function function_64f27e5d055fd969( loadoutname )
{
    assert( level.botloadouts.initialized, "<dev string:x1f3>" );
    
    if ( isdefined( level.botloadouts.loadouts[ loadoutname ] ) )
    {
        self.botloadoutname = loadoutname;
        return true;
    }
    
    return false;
}

// Namespace bots_loadout
// Params 2
// Checksum 0x95bb8386, Offset: 0x18df
// Size: 0x94, Type: bool
function function_c254ef039da6acd6( personality, difficulty )
{
    assert( level.botloadouts.initialized, "<dev string:x23f>" );
    loadoutsetkey = function_793fd3328037dd9f( personality, difficulty );
    
    if ( isdefined( level.botloadouts.loadoutsets[ loadoutsetkey ] ) )
    {
        botloadoutname = utility::array_random( level.botloadouts.loadoutsets[ loadoutsetkey ] );
        return function_64f27e5d055fd969( botloadoutname );
    }
    
    return false;
}

// Namespace bots_loadout
// Params 0
// Checksum 0xfbb4fa57, Offset: 0x197c
// Size: 0x52, Type: bool
function function_869a511557a60ad4()
{
    if ( !isdefined( self.pers[ "gamemodeLoadout" ] ) )
    {
        if ( level.botloadouts.initialized )
        {
            bot_set_loadout_class();
            self.classcallback = &function_c39c5c8073b9c407;
            return true;
        }
        
        assertmsg( "<dev string:x28c>" );
    }
    
    return false;
}

// Namespace bots_loadout
// Params 0
// Checksum 0x7532e34d, Offset: 0x19d7
// Size: 0x55e
function function_c39c5c8073b9c407()
{
    assert( level.botloadouts.initialized, "<dev string:x2db>" );
    loadout_struct = undefined;
    var_fe596bcd61ccf428 = getdvarint( @"hash_8f22d0a2bc0d7f30", 0 );
    
    if ( var_fe596bcd61ccf428 )
    {
        loadout_struct = function_5bebe8febbaa186d();
    }
    
    /#
        if ( !isdefined( loadout_struct ) )
        {
            debugloadout = getdvar( @"hash_6329fb6de82ba4d1", "<dev string:x24>" );
            
            if ( debugloadout != "<dev string:x24>" )
            {
                loadout_struct = function_64f27e5d055fd969( debugloadout );
            }
        }
    #/
    
    if ( !isdefined( loadout_struct ) )
    {
        if ( !isdefined( self.botloadoutname ) )
        {
            if ( !isdefined( self.difficulty ) || !isdefined( self.personality ) )
            {
                bots::function_7226c9d17a3ed27( 1 );
            }
            
            personality = self botgetpersonality();
            difficulty = self botgetdifficulty();
            assignsucceeded = function_c254ef039da6acd6( personality, difficulty );
            
            if ( !assignsucceeded )
            {
                assertmsg( "<dev string:x325>" + personality + "<dev string:x352>" + difficulty + "<dev string:x365>" + getxhashsourcename( level.gamemodebundle.var_4c34ed2963279005 ) + "<dev string:x37b>" );
            }
        }
        
        loadout_struct_ref = level.botloadouts.loadouts[ self.botloadoutname ];
        
        if ( isdefined( loadout_struct_ref ) )
        {
            loadout_struct = structcopy( loadout_struct_ref, 1 );
            loadout_struct.equipment.primary = utility::array_random( loadout_struct.equipment.primary );
            loadout_struct.equipment.secondary = utility::array_random( loadout_struct.equipment.secondary );
            loadout_struct.fieldUpgrades.fieldupgrade1 = utility::array_random( loadout_struct.fieldUpgrades.fieldupgrade1 );
            
            if ( isdefined( loadout_struct.killstreaks.templatearray ) )
            {
                loadout_struct.killstreaks.killstreak1 = utility::array_random( loadout_struct.killstreaks.templatearray );
                loadout_struct.killstreaks.templatearray = arrayremove( loadout_struct.killstreaks.templatearray, loadout_struct.killstreaks.killstreak1 );
                loadout_struct.killstreaks.killstreak2 = utility::array_random( loadout_struct.killstreaks.templatearray );
                loadout_struct.killstreaks.templatearray = arrayremove( loadout_struct.killstreaks.templatearray, loadout_struct.killstreaks.killstreak2 );
                loadout_struct.killstreaks.killstreak3 = utility::array_random( loadout_struct.killstreaks.templatearray );
                loadout_struct.killstreaks.templatearray = arrayremove( loadout_struct.killstreaks.templatearray, loadout_struct.killstreaks.killstreak3 );
                loadout_struct.killstreaks.templatearray = undefined;
            }
        }
        else
        {
            loadout_struct = function_6cf568c868aff953();
        }
    }
    
    /#
        var_ee7ee370ab51ac19 = getdvar( @"hash_7454b5e6ca849775", "<dev string:x24>" );
        
        if ( var_ee7ee370ab51ac19 != "<dev string:x24>" )
        {
            loadout_struct.primaryweapon = spawnstruct();
            loadout_struct.primaryweapon.weapon = var_ee7ee370ab51ac19;
        }
        
        var_2dde408de71da2f = getdvar( @"hash_d92dfc29f9af81bb", "<dev string:x24>" );
        
        if ( var_2dde408de71da2f != "<dev string:x24>" )
        {
            loadout_struct.equipment.primary = var_2dde408de71da2f;
        }
        
        var_a5e8c5981d75c18f = getdvar( @"hash_a05a1967759feb7f", "<dev string:x24>" );
        
        if ( var_a5e8c5981d75c18f != "<dev string:x24>" )
        {
            loadout_struct.equipment.secondary = var_a5e8c5981d75c18f;
        }
        
        var_794d0b85a0d94148 = getdvar( @"hash_52a5487e07ba8cd0", "<dev string:x24>" );
        
        if ( var_794d0b85a0d94148 != "<dev string:x24>" )
        {
            loadout_struct.fieldUpgrades.fieldupgrade1 = var_794d0b85a0d94148;
        }
    #/
    
    logstring( "[BOTS] Bot loadout picked for [" + self.name + "]" );
    logstring( " primaryWeapon: ", loadout_struct.primaryweapon );
    logstring( " secondaryWeapon: ", loadout_struct.secondaryweapon );
    logstring( " tertiaryWeapon: ", loadout_struct.tertiaryWeapon );
    logstring( " equipment: ", loadout_struct.equipment );
    logstring( " fieldUpgrades: ", loadout_struct.fieldUpgrades );
    logstring( " perks: ", loadout_struct.perks );
    logstring( " killstreaks: ", loadout_struct.killstreaks );
    return loadout_struct;
}

// Namespace bots_loadout
// Params 0
// Checksum 0x4aff50f1, Offset: 0x1f3e
// Size: 0x5ce
function function_5bebe8febbaa186d()
{
    default_class_options = [ "default1", "default2", "default3", "default4", "default5" ];
    default_class_picked = utility::array_random( default_class_options );
    default_class_picked = class::getclasschoice( default_class_picked );
    var_347e18171e73c6c0 = class::loadout_getclassstruct();
    class::loadout_updateclassdefault( var_347e18171e73c6c0, default_class_picked );
    defaultloadout = spawnstruct();
    defaultloadout.archetype = "assault";
    
    if ( !level.var_f1705bdddaa9d739 )
    {
        level.var_15dd55f313034f43 = function_2c113ec2d03e1fd5( &weapon::iscacprimaryweapon );
        level.var_32ab4160b12d8877 = function_2c113ec2d03e1fd5( &weapon::iscacsecondaryweapon );
        level.var_f05362d2a47de107 = function_2c113ec2d03e1fd5( &weapon::function_6b74ecd475e99b4 );
        level.var_3f29be3f8aac7e35 = function_2c113ec2d03e1fd5( &weapon::ismeleeonly );
        level.var_f1705bdddaa9d739 = 1;
    }
    
    var_c87293ddaf6f7705 = getdvarint( @"hash_491a4026774b34", 1 );
    defaultloadout.primaryweapon = function_4c3ac5e76b073ee9( level.var_15dd55f313034f43, var_c87293ddaf6f7705 );
    defaultloadout.secondaryweapon = function_4c3ac5e76b073ee9( level.var_32ab4160b12d8877, var_c87293ddaf6f7705 );
    defaultloadout.tertiaryWeapon = function_4c3ac5e76b073ee9( level.var_f05362d2a47de107, var_c87293ddaf6f7705 );
    defaultloadout.meleeslot = function_4c3ac5e76b073ee9( level.var_3f29be3f8aac7e35, var_c87293ddaf6f7705 ).weapon;
    
    if ( !isdefined( defaultloadout.primaryweapon.weapon ) )
    {
        defaultloadout.primaryweapon.weapon = var_347e18171e73c6c0.loadoutprimary;
        defaultloadout.primaryweapon.attachment1 = var_347e18171e73c6c0.loadoutprimaryattachments[ 0 ];
        defaultloadout.primaryweapon.attachment2 = var_347e18171e73c6c0.loadoutprimaryattachments[ 1 ];
        defaultloadout.primaryweapon.attachment3 = var_347e18171e73c6c0.loadoutprimaryattachments[ 2 ];
        defaultloadout.primaryweapon.attachment4 = var_347e18171e73c6c0.loadoutprimaryattachments[ 3 ];
        defaultloadout.primaryweapon.attachment5 = var_347e18171e73c6c0.loadoutprimaryattachments[ 4 ];
        defaultloadout.primaryweapon.attachment6 = var_347e18171e73c6c0.loadoutprimaryattachments[ 5 ];
        defaultloadout.primaryweapon.camo = var_347e18171e73c6c0.loadoutprimarycamo;
        defaultloadout.primaryweapon.chroma = var_347e18171e73c6c0.var_69ae546f481034e2;
        defaultloadout.primaryweapon.reticle = var_347e18171e73c6c0.loadoutprimaryreticle;
    }
    
    if ( !isdefined( defaultloadout.secondaryweapon.weapon ) )
    {
        defaultloadout.secondaryweapon.weapon = var_347e18171e73c6c0.loadoutsecondary;
        defaultloadout.secondaryweapon.attachment1 = var_347e18171e73c6c0.loadoutsecondaryattachments[ 0 ];
        defaultloadout.secondaryweapon.attachment2 = var_347e18171e73c6c0.loadoutsecondaryattachments[ 1 ];
        defaultloadout.secondaryweapon.attachment3 = var_347e18171e73c6c0.loadoutsecondaryattachments[ 2 ];
        defaultloadout.secondaryweapon.attachment4 = var_347e18171e73c6c0.loadoutsecondaryattachments[ 3 ];
        defaultloadout.secondaryweapon.attachment5 = var_347e18171e73c6c0.loadoutsecondaryattachments[ 4 ];
        defaultloadout.secondaryweapon.camo = var_347e18171e73c6c0.loadoutsecondarycamo;
        defaultloadout.secondaryweapon.chroma = var_347e18171e73c6c0.var_2bab3f4f3d38584a;
        defaultloadout.secondaryweapon.reticle = var_347e18171e73c6c0.loadoutsecondaryreticle;
    }
    
    defaultloadout.equipment = spawnstruct();
    defaultloadout.equipment.primary = var_347e18171e73c6c0.loadoutequipmentprimary;
    defaultloadout.equipment.secondary = var_347e18171e73c6c0.loadoutequipmentsecondary;
    defaultloadout.perks = spawnstruct();
    defaultloadout.perks.perk1 = var_347e18171e73c6c0.loadoutperks[ 0 ];
    defaultloadout.perks.perk2 = var_347e18171e73c6c0.loadoutperks[ 1 ];
    defaultloadout.perks.perk3 = var_347e18171e73c6c0.loadoutperks[ 2 ];
    defaultloadout.extraperks = spawnstruct();
    defaultloadout.extraperks.perk1 = var_347e18171e73c6c0.loadoutextraperks[ 0 ];
    defaultloadout.extraperks.perk2 = var_347e18171e73c6c0.loadoutextraperks[ 1 ];
    defaultloadout.extraperks.perk3 = var_347e18171e73c6c0.loadoutextraperks[ 2 ];
    defaultloadout.gesture = var_347e18171e73c6c0.loadoutgesture;
    defaultloadout.fieldupgrade1 = var_347e18171e73c6c0.loadoutfieldupgrade1;
    return defaultloadout;
}

// Namespace bots_loadout
// Params 1
// Checksum 0x56c55e52, Offset: 0x2515
// Size: 0x61
function function_8c4f5c27743197d5( weapon )
{
    if ( weapon )
    {
        weaponvariants = getweaponblueprintnames( weapon );
        
        if ( weaponvariants.size )
        {
            blueprint = spawnstruct();
            blueprint.variantid = randomint( weaponvariants.size );
            blueprint.weaponname = weapon::getweaponrootname( weapon );
            return blueprint;
        }
    }
}

// Namespace bots_loadout
// Params 1
// Checksum 0x7f3a8e6d, Offset: 0x257e
// Size: 0x33
function function_b1e78006d75ee4f3( validationfunction )
{
    var_f1c5fac94abfd027 = getdvarint( @"hash_a29d35a0c7f7307b", 1 );
    return function_14747e70f3e57908( validationfunction, 1, var_f1c5fac94abfd027 );
}

// Namespace bots_loadout
// Params 0
// Checksum 0xcf48593d, Offset: 0x25ba
// Size: 0x9b
function function_c53e9a8034b5fbff()
{
    weapons = [];
    
    foreach ( weaponref in level.weaponmapdata )
    {
        weaponname = weaponref.assetname;
        weapons[ weapons.size ] = weaponname;
    }
    
    return weapons;
}

// Namespace bots_loadout
// Params 3
// Checksum 0x84550b01, Offset: 0x265e
// Size: 0x29b
function function_14747e70f3e57908( validationfunction, var_337f5fc510e5c6e0, var_f1c5fac94abfd027 )
{
    weapons = [];
    gamemode = "MP";
    gametype = toupper( game_utility::getgametype() );
    
    if ( gametype == "OB" || gametype == "BR" )
    {
        gamemode = gametype;
    }
    
    if ( var_f1c5fac94abfd027 )
    {
        projectname = tolower( getprojectname() );
        
        if ( projectname == "wz2" )
        {
            projectname = "t10";
        }
    }
    
    foreach ( weaponref in level.weaponmapdata )
    {
        weaponname = weaponref.assetname;
        
        if ( var_f1c5fac94abfd027 && !isstartstr( weaponname, projectname ) )
        {
            continue;
        }
        
        weaponobj = utility::function_64003742d8f5c781( weaponname );
        rootname = weapon::getweaponrootname( weaponname );
        
        if ( ![[ validationfunction ]]( weaponobj ) )
        {
            continue;
        }
        
        if ( var_337f5fc510e5c6e0 )
        {
            displayorder = weapon::function_c37ac3c4f987e506( rootname, #"displayorder" );
            
            if ( displayorder == -1 )
            {
                continue;
            }
        }
        
        if ( weapon::iskillstreakweapon( weaponobj ) )
        {
            continue;
        }
        
        gamemodes = weapon::function_c37ac3c4f987e506( rootname, #"availablegamemodes" );
        
        if ( gamemodes.size > 0 )
        {
            gamemodelist = strtok( gamemodes, "," );
            found = function_f02c63b99c9614c9( gamemodelist, gamemode );
            
            if ( !isdefined( found ) )
            {
                continue;
            }
        }
        
        if ( weaponobj.inventorytype == "item" )
        {
            continue;
        }
        
        broken_weapons = [];
        foundbroken = 0;
        
        foreach ( broken in broken_weapons )
        {
            if ( isstartstr( weaponname, broken ) )
            {
                foundbroken = 1;
                break;
            }
        }
        
        if ( foundbroken )
        {
            continue;
        }
        
        weapons[ weapons.size ] = weaponname;
    }
    
    return weapons;
}

// Namespace bots_loadout
// Params 2
// Checksum 0xe03c82dd, Offset: 0x2902
// Size: 0x107
function function_4c3ac5e76b073ee9( weaponlist, random )
{
    botweapon = spawnstruct();
    
    if ( weaponlist.list.size > 0 )
    {
        if ( random )
        {
            botweapon.weapon = utility::array_random( weaponlist.list );
        }
        else
        {
            botweapon.weapon = weaponlist.list[ weaponlist.nextindex ];
            weaponlist.nextindex = ( weaponlist.nextindex + 1 ) % weaponlist.list.size;
        }
        
        if ( getdvarint( @"hash_26174b2721bb71b4", 1 ) )
        {
            weaponblueprint = function_8c4f5c27743197d5( botweapon.weapon );
            
            if ( weaponblueprint )
            {
                botweapon.weapon = weaponblueprint.weaponname;
                botweapon.variantid = weaponblueprint.variantid;
            }
        }
    }
    
    return botweapon;
}

// Namespace bots_loadout
// Params 1
// Checksum 0xbd77ebde, Offset: 0x2a12
// Size: 0x3f
function function_2c113ec2d03e1fd5( validationfunction )
{
    weaponlist = spawnstruct();
    weaponlist.list = function_b1e78006d75ee4f3( validationfunction );
    weaponlist.nextindex = 0;
    return weaponlist;
}

// Namespace bots_loadout
// Params 0
// Checksum 0x758dbe1e, Offset: 0x2a5a
// Size: 0x29
function function_605c93dfe43e02ee()
{
    self.botloadoutname = undefined;
    self.pers[ #"classcache" ][ #"callback" ] = undefined;
}

// Namespace bots_loadout
// Params 0
// Checksum 0xcdcb31ab, Offset: 0x2a8b
// Size: 0x138
function bot_set_loadout_class()
{
    if ( !bots::function_d368124e9c5a1809() )
    {
        assert( isdefined( self.class ) );
        return;
    }
    
    if ( !isdefined( self.bot_class ) )
    {
        if ( !level.bots_gametype_handles_class_choice )
        {
            if ( isdefined( level.gametypebundle.classTableOverride ) || getdvar( @"scr_classtable_override", "" ) != "" )
            {
                num_loadouts = class::function_868832c7872f848e( level.classtablename );
                loadout_picked = randomintrange( 1, 1 + num_loadouts );
                self.bot_class = "default" + loadout_picked;
            }
            else
            {
                while ( !( isdefined( level.botloadouts ) && isdefined( level.botloadouts.initialized ) ) )
                {
                    wait 0.05;
                }
                
                if ( isdefined( self.override_class_function ) )
                {
                    self.bot_class = [[ self.override_class_function ]]();
                }
                else
                {
                    self.bot_class = "callback";
                }
            }
        }
        else
        {
            self.bot_class = self.class;
        }
    }
    
    self.class = self.bot_class;
}

