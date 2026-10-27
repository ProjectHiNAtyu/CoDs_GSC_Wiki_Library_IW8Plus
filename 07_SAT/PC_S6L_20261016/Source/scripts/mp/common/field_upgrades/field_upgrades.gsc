// scripts\mp\common\field_upgrades\field_upgrades.gsc  (hash_3d65c29bb3088049.gscc) (size: 3158 Bytes / 0xc56 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8fff67b (150992507)
// size ...... 3158 (0xc56)
// includes .. 3   (offset: 0xbd2)
// strings ... 4   (offset: 0xbea)
// dev strs .. 5   (offset: 0xc1a)
// exports ... 14  (offset: 0x6e6)
// cseg ...... 0xbe + 0x628 (0x6e6)
// imports ... 24  (offset: 0x916)
// animtree1 . 0   (offset: 0xc56)
// animtree2 . 0   (offset: 0xc56)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\mp\supers;

#namespace field_upgrades;

// Namespace field_upgrades
// Params 1
// Checksum 0x72e7e4ce, Offset: 0xdc
// Size: 0x92
function init( pausesuperpointsovertime )
{
    /#
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_command( "<dev string:x3a>", "<dev string:x45>" );
        devgui::function_77df7fe7dd273e10();
    #/
    
    level.var_d8c17916fed09937 = level.gametypebundle.var_29b8e12f13ae8f00 ?? 0;
    callback::add( #"player_spawned", &field_upgrade_on_spawned );
    callback::add( #"on_super_use_finished", &on_field_upgrade_used );
    level.field_upgrade_bundles = [];
    level.var_23c73a604b371f49 = pausesuperpointsovertime;
}

// Namespace field_upgrades
// Params 1
// Checksum 0x82f5a936, Offset: 0x176
// Size: 0x51
function function_1fcc83f10e7752e5( var_e93a67c34276fb3f )
{
    supers_mp::function_cd1719a14d935a1c();
    var_99aeefecc6ad2f37 = level.var_b72c376264827891[ var_e93a67c34276fb3f ];
    
    if ( var_99aeefecc6ad2f37 )
    {
        superbundle = getscriptbundle( var_99aeefecc6ad2f37 );
        level.field_upgrade_bundles[ var_e93a67c34276fb3f ] = superbundle;
        return superbundle;
    }
}

// Namespace field_upgrades
// Params 1
// Checksum 0x5f53b4f3, Offset: 0x1d0
// Size: 0x91
function field_upgrade_on_spawned( params )
{
    if ( !isdefined( self.var_6b07486215a175b0 ) )
    {
        self.var_6b07486215a175b0 = 0;
    }
    
    self.pausesuperpointsovertime = 1;
    
    if ( isdefined( level.var_23c73a604b371f49 ) )
    {
        self.pausesuperpointsovertime = level.var_23c73a604b371f49;
    }
    
    superinfo = self.super;
    
    if ( isdefined( superinfo ) && isdefined( superinfo.staticdata ) )
    {
        superinfo.staticdata.var_5afeac4251aa48da = &function_547d8d27c323ad0;
    }
}

// Namespace field_upgrades
// Params 1
// Checksum 0x278c7b0d, Offset: 0x269
// Size: 0x36
function on_field_upgrade_used( sparams )
{
    if ( level.var_d8c17916fed09937 > 0 )
    {
        self.var_6b07486215a175b0 += level.var_d8c17916fed09937;
    }
}

// Namespace field_upgrades
// Params 1
// Checksum 0x647bc120, Offset: 0x2a7
// Size: 0x42
function function_547d8d27c323ad0( superinfo )
{
    if ( isnumber( level.var_750a1cea39c9abc8 ) )
    {
        return level.var_750a1cea39c9abc8;
    }
    
    return get_field_upgrade_points_needed( self, superinfo.staticdata.ref );
}

// Namespace field_upgrades
// Params 2
// Checksum 0x4217ac35, Offset: 0x2f2
// Size: 0x50
function get_field_upgrade_points_needed( player, var_b112df1b5c8edfdb )
{
    defaultpoints = function_5f728868b18ef0c0( var_b112df1b5c8edfdb, "pointsNeeded" ) ?? 1;
    increased_cost = player.var_6b07486215a175b0 ?? 0;
    return defaultpoints + increased_cost;
}

// Namespace field_upgrades
// Params 1
// Checksum 0x78593e41, Offset: 0x34b
// Size: 0x45
function function_55abafe10f7fd36b( var_b112df1b5c8edfdb )
{
    if ( !isdefined( level.var_b72c376264827891 ) )
    {
        supers_mp::function_cd1719a14d935a1c();
    }
    
    var_99aeefecc6ad2f37 = level.var_b72c376264827891[ var_b112df1b5c8edfdb ];
    
    if ( var_99aeefecc6ad2f37 )
    {
        return getscriptbundle( var_99aeefecc6ad2f37 );
    }
}

// Namespace field_upgrades
// Params 2
// Checksum 0x8b53bc4f, Offset: 0x399
// Size: 0x4f
function function_5f728868b18ef0c0( var_b112df1b5c8edfdb, str_bundle_field_name )
{
    if ( !isdefined( level.var_b72c376264827891 ) )
    {
        supers_mp::function_cd1719a14d935a1c();
    }
    
    var_99aeefecc6ad2f37 = level.var_b72c376264827891[ var_b112df1b5c8edfdb ];
    
    if ( var_99aeefecc6ad2f37 )
    {
        return getscriptbundlefieldvalue( var_99aeefecc6ad2f37, str_bundle_field_name );
    }
}

// Namespace field_upgrades
// Params 3
// Checksum 0x5efa1db7, Offset: 0x3f1
// Size: 0xce
function function_f08689a65bca024b( eventstring, victim, sweapon )
{
    player = self;
    
    if ( isplayer( player ) )
    {
        var_c0c4324d255baab3 = player supers_mp::getcurrentsuper();
        
        if ( isdefined( var_c0c4324d255baab3 ) && !var_c0c4324d255baab3.isinuse )
        {
            n_start_points = var_c0c4324d255baab3.basepoints;
            player supers_mp::givesuperpoints( 0, eventstring );
            n_points_given = var_c0c4324d255baab3.basepoints - n_start_points;
            
            /#
                iprintlnbold( "<dev string:x66>" + var_c0c4324d255baab3.basepoints + "<dev string:x87>" + var_c0c4324d255baab3.staticdata.pointsneeded );
            #/
            
            return n_points_given;
        }
    }
    
    return 0;
}

// Namespace field_upgrades
// Params 0
// Checksum 0x37f6fbd7, Offset: 0x4c8
// Size: 0x39
function get_field_upgrade_tier()
{
    var_c0c4324d255baab3 = supers_mp::getcurrentsuper();
    var_7740b7b10253dd51 = var_c0c4324d255baab3.staticdata.var_7740b7b10253dd51 ?? 0;
    return var_7740b7b10253dd51;
}

// Namespace field_upgrades
// Params 0
// Checksum 0x5d98596e, Offset: 0x50a
// Size: 0x35
function get_field_upgrade_bundle()
{
    super = supers_mp::getcurrentsuper();
    bundle = super.staticdata.bundle;
    return bundle;
}

// Namespace field_upgrades
// Params 2
// Checksum 0x2f75def9, Offset: 0x548
// Size: 0xc6, Type: bool
function field_upgrade_play_gesture( weapon_name, field_upgrade_ref )
{
    self endon( #"death" );
    gestureweapon = makeweapon( weapon_name );
    firetime = gestureweapon.firetime;
    
    if ( !function_cf934704c94c9f7d( weapon_name ) )
    {
        self giveandfireoffhand( gestureweapon );
    }
    
    wait firetime;
    self playrumbleonentity( "zombie_field_upgrade_wand_fire" );
    params = spawnstruct();
    params.weaponname = weapon_name;
    params.ref = field_upgrade_ref;
    callback::callback( "field_upgrade_used", params );
    params = spawnstruct();
    params.weapon_name = weapon_name;
    callback::callback( "zombie_field_upgrade_fired", params );
    return true;
}

// Namespace field_upgrades
// Params 1
// Checksum 0xe2a1e11b, Offset: 0x617
// Size: 0xcf
function function_cf934704c94c9f7d( weapon_name )
{
    switch ( weapon_name )
    {
        case %"frenzied_guard_ob":
        case %"frenzied_guard_zm":
        case %"aether_shroud_zm":
        case %"aether_shroud_ob":
        case %"frost_blast_zm":
        case %"frost_blast_ob":
        case %"healing_aura_ob":
        case %"healing_aura_zm":
        case %"wiley_fox_zm":
        case %"tesla_storm_ob":
        case %"tesla_storm_zm":
        case %"energy_mine_ob":
        case %"energy_mine_zm":
        case %"dark_flare_zm":
            return 1;
        default:
            return 0;
    }
}

