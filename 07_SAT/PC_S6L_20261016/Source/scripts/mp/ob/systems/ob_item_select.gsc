// scripts\mp\ob\systems\ob_item_select.gsc  (hash_148f412c569f3293.gscc) (size: 41396 Bytes / 0xa1b4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfdfa7485 (4261049477)
// size ...... 41396 (0xa1b4)
// includes .. 21  (offset: 0x97d0)
// strings ... 80  (offset: 0x9878)
// dev strs .. 69  (offset: 0x9e2c)
// exports ... 62  (offset: 0x7228)
// cseg ...... 0x80c + 0x6a1c (0x7228)
// imports ... 207 (offset: 0x7bd8)
// animtree1 . 0   (offset: 0xa1b4)
// animtree2 . 0   (offset: 0xa1b4)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\script;
#using scripts\common\scriptable;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\common\perks\perkpackage;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\equipment;
#using scripts\mp\hud_message;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_database;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\ob\ob_reward_select;
#using scripts\mp\ob\ob_skill_select;
#using scripts\mp\ob\ob_skill_selection;
#using scripts\mp\supers;

#namespace ob_item_select;

// Namespace ob_item_select
// Params 0, eflags: 0x1
// Checksum 0x24ec33a2, Offset: 0x82a
// Size: 0x3b4
function autoexec main()
{
    if ( !common_item::items_isenabled() )
    {
        return;
    }
    
    if ( !getdvarint( @"scr_ob_item_select_enabled", 1 ) )
    {
        return;
    }
    
    utility::flag_wait( "common_items_init" );
    utility::registersharedfunc( #"item_select", #"item_select_used", &function_f5c0d2bd620169a4 );
    callback::add( #"cache_opened", &function_1951ae23a618fc1b );
    callback::add( "lootcache_looted", &function_fcec9cf38ac2f3dd );
    callback::add( #"player_disconnect", &onplayerdisconnect );
    callback::add( #"skill_acquired", &function_37c677a0688cb904 );
    callback::add( #"skill_removed", &function_551d94000edad68 );
    
    if ( !isbrgamemode() )
    {
        common_item::function_5734400f32ca9803( "item_select", &function_cd34c925ad699236 );
        utility::registersharedfunc( #"ability_case", #"spawn", &function_95f9ecc2af4693f6 );
        thread function_eae3d29fb3b9d128();
        level.var_2a010f82d868b9cc = getdvarint( @"hash_c0edd3b2858b5f96", getbuildversion() != "SHIP" );
    }
    
    scriptable::scriptable_addnotifycallback( "item_select_state_change", &function_36ce53759b7f0445 );
    scriptable::scriptable_addnotifycallback( "ability_case_state_change", &function_f2da572aea2b5190 );
    level.var_cead0170a5b9b5eb = getdvarint( @"hash_ca24b5526f0a8c55", 0 );
    
    if ( level.var_cead0170a5b9b5eb )
    {
        level.var_e78d2aa742312b7e = [];
        level.var_8419acdb385780db = [];
        level.var_fef827b18b34acfd = getdvarfloat( @"hash_41a1d204d2783a64", 400 );
        level.var_f64b612f3abaef17 = throttle::throttle_initialize( "ob_item_select_weapon_streaming", getdvarint( @"hash_e94ef54c2908af74", 2 ) );
        level.var_e885e808ca5a7060 = item_weapon::function_f75620a38a24072() ?? %"obloot_custom_weapon";
        level.var_685fb57a1babacf0 = getdvarint( @"hash_480587cb65723c2f", getbuildversion() != "SHIP" );
        callback::add( #"player_connect", &function_f67f67b65329c95 );
    }
    
    /#
        devgui::function_cd4e263c1f3018ae( "<dev string:x24>", "<dev string:x4d>", &function_c620066e0d21a30f, 0, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x89>", "<dev string:xb2>", &function_c620066e0d21a30f, 0, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xf2>", "<dev string:x124>", &function_c620066e0d21a30f, 0, 2 );
        devgui::function_9082edeb5db93280( "<dev string:x152>" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x164>", @"hash_13b13d8336999e21" );
        devgui::add_devgui_func( "<dev string:x176>", "<dev string:x191>", &function_513a59988d5fbfef );
        devgui::add_devgui_func( "<dev string:x19d>", "<dev string:x1b9>", &function_5cf35aebe8c48e3c );
        devgui::add_devgui_func( "<dev string:x1c6>", "<dev string:x1de>", &function_75ef086b4052e39d );
        devgui::add_devgui_func( "<dev string:x1ee>", "<dev string:x207>", &function_e3c4f9a6c31cbc7a );
        devgui::add_devgui_func( "<dev string:x215>", "<dev string:x22d>", &function_e91d0a23070b5174 );
        devgui::add_devgui_func( "<dev string:x23d>", "<dev string:x261>", &function_f93ed8f9d6a1f17c );
        devgui::add_devgui_func( "<dev string:x271>", "<dev string:x28f>", &function_14b594bde709a844 );
        devgui::add_devgui_func( "<dev string:x29b>", "<dev string:x2ba>", &function_44818d3629e55337 );
        devgui::add_devgui_func( "<dev string:x2c7>", "<dev string:x2e2>", &function_be75b3f7a504ae2 );
        devgui::add_devgui_func( "<dev string:x2f2>", "<dev string:x30e>", &function_87cb1eac16c03dbf );
        devgui::add_devgui_func( "<dev string:x31c>", "<dev string:x337>", &function_7b02cbfef8a197c1 );
        devgui::add_devgui_func( "<dev string:x347>", "<dev string:x36e>", &function_f1af320df03f2713 );
        devgui::add_devgui_func( "<dev string:x37e>", "<dev string:x3a8>", &function_e9bc1b34149fcda4 );
        devgui::add_devgui_func( "<dev string:x3b7>", "<dev string:x3e1>", &function_786fe04d2043ddfc );
        devgui::add_devgui_func( "<dev string:x3f0>", "<dev string:x414>", &function_fe8298529cf5670a );
        devgui::function_77df7fe7dd273e10();
    #/
}

// Namespace ob_item_select
// Params 1, eflags: 0x4
// Checksum 0xb3870d47, Offset: 0xbe6
// Size: 0x65
function private function_1c43a08346f99fba( interactobject )
{
    self endon( #"disconnect" );
    
    while ( true )
    {
        wait 0.5;
        
        if ( !isdefined( interactobject.origin ) || distancesquared( interactobject.origin, self.origin ) > 14400 )
        {
            self notify( #"allow_reward_select" );
            return;
        }
    }
}

// Namespace ob_item_select
// Params 4
// Checksum 0x2a017fe0, Offset: 0xc53
// Size: 0x1c7
function function_55bae6c0c5e50953( interactobject, var_3325d0eb2231cf18, var_3325d3eb2231d5b1, var_3325d2eb2231d37e )
{
    self endon( #"disconnect" );
    
    while ( true )
    {
        while ( !val::get( "allow_reward_select" ) )
        {
            self waittill( #"allow_reward_select" );
        }
        
        self setclientomnvar( "ui_ob_selectable_reward_id_1", 0 );
        self setclientomnvar( "ui_ob_selectable_reward_id_2", 0 );
        self setclientomnvar( "ui_ob_selectable_reward_id_3", 0 );
        
        if ( isdefined( var_3325d0eb2231cf18 ) )
        {
            var_55fc1ec7f461c0c0 = function_43b5ed5a14a56573( #"scriptbundle_itemspawnentry", var_3325d0eb2231cf18 );
            
            if ( isdefined( var_55fc1ec7f461c0c0 ) )
            {
                self setclientomnvar( "ui_ob_selectable_reward_id_1", var_55fc1ec7f461c0c0 );
            }
        }
        
        if ( isdefined( var_3325d3eb2231d5b1 ) )
        {
            var_55fc21c7f461c759 = function_43b5ed5a14a56573( #"scriptbundle_itemspawnentry", var_3325d3eb2231d5b1 );
            
            if ( isdefined( var_55fc21c7f461c759 ) )
            {
                self setclientomnvar( "ui_ob_selectable_reward_id_2", var_55fc21c7f461c759 );
            }
        }
        
        if ( isdefined( var_3325d2eb2231d37e ) )
        {
            var_55fc20c7f461c526 = function_43b5ed5a14a56573( #"scriptbundle_itemspawnentry", var_3325d2eb2231d37e );
            
            if ( isdefined( var_55fc20c7f461c526 ) )
            {
                self setclientomnvar( "ui_ob_selectable_reward_id_3", var_55fc20c7f461c526 );
            }
        }
        
        var_5ce0dbf5f38f284b = ob_skill_select::ob_skill_select_is_active() && !self.skillpicked;
        
        if ( var_5ce0dbf5f38f284b )
        {
            ob_skill_select::close_ob_skill_select();
        }
        
        ob_reward_select::open_ob_reward_select();
        thread function_1c43a08346f99fba( interactobject );
        rewardpicked = utility::waittill_any_return( "RewardSelectLeft", "RewardSelectRight", "RewardSelect3", "allow_reward_select", "last_stand_enter", "deactivate_ob_reward_select", "death", "entitydeleted" );
        ob_reward_select::close_ob_reward_select();
        
        if ( var_5ce0dbf5f38f284b )
        {
            ob_skill_select::open_ob_skill_select();
        }
        
        if ( rewardpicked == "RewardSelectLeft" )
        {
            return 0;
        }
        
        if ( rewardpicked == "RewardSelectRight" )
        {
            return 1;
        }
        
        if ( rewardpicked == "RewardSelect3" )
        {
            return 2;
        }
        
        return -1;
    }
}

// Namespace ob_item_select
// Params 7, eflags: 0x4
// Checksum 0xee0bab08, Offset: 0xe22
// Size: 0xc1
function private function_107a19ba8e9d4bfb( assettype, assetref, var_c1611a65af8736a3, itemspawnname, skilllevel, var_72b4fdb97118db5e, isreplaceable )
{
    tiledata = { #is_replaceable:isreplaceable, #is_upgrade:var_72b4fdb97118db5e, #is_equipped:var_c1611a65af8736a3, #asset:assetref, #asset_type:assettype };
    
    if ( isdefined( itemspawnname ) )
    {
        tiledata.description = getlocstringindex( getscriptbundlefieldvalue( itemspawnname, #"hash_77540284b1a6e149" ) );
    }
    
    if ( isdefined( skilllevel ) )
    {
        tiledata.skill_level = skilllevel;
    }
    
    return tiledata;
}

// Namespace ob_item_select
// Params 1, eflags: 0x4
// Checksum 0x9dbdf9e, Offset: 0xeec
// Size: 0x24
function private function_d1f4883f5539b473( assetref )
{
    if ( isxhashasset( assetref ) )
    {
        return assetref;
    }
    
    return getxhashasset( "skill:" + assetref );
}

// Namespace ob_item_select
// Params 1, eflags: 0x4
// Checksum 0x312053f1, Offset: 0xf19
// Size: 0x24
function private function_b528615c0dce3d05( abilityref )
{
    if ( isxhashasset( abilityref ) )
    {
        return abilityref;
    }
    
    return getxhashasset( "super:" + abilityref );
}

// Namespace ob_item_select
// Params 1, eflags: 0x4
// Checksum 0x256f70bc, Offset: 0xf46
// Size: 0x8e
function private function_55c10c1014749803( equipref )
{
    tableinfo = level.equipment.table[ equipref ];
    
    if ( isdefined( tableinfo ) && isdefined( tableinfo.bundle.superref ) )
    {
        fullbundlename = level.var_b72c376264827891[ tableinfo.bundle.superref ];
        
        if ( isdefined( fullbundlename ) )
        {
            return function_b528615c0dce3d05( fullbundlename );
        }
    }
    
    return function_b528615c0dce3d05( equipref );
}

// Namespace ob_item_select
// Params 1, eflags: 0x4
// Checksum 0xa25797df, Offset: 0xfdd
// Size: 0x46
function private function_cc80d42be9f0ca44( obref )
{
    baseref = function_1b44a8bef83e8e02( obref, "_ob" );
    fullbundlename = level.var_b72c376264827891[ baseref ];
    return function_b528615c0dce3d05( fullbundlename ?? obref );
}

// Namespace ob_item_select
// Params 4
// Checksum 0x43e97151, Offset: 0x102c
// Size: 0xb2
function function_3fe3b855505e2c8b( interactobject, var_6b26d0a59b76b334, var_1beaecc99fb0c2d3, var_f06bf262e0bdbfb1 )
{
    self endon( #"disconnect" );
    var_cb18fbca207f8bda = getlocstringindex( var_1beaecc99fb0c2d3 );
    
    while ( !val::get( "allow_reward_select" ) )
    {
        self waittill( #"allow_reward_select" );
    }
    
    var_5ce0dbf5f38f284b = ob_skill_selection::ob_skill_selection_is_active() && !self.skillpicked;
    
    if ( var_5ce0dbf5f38f284b )
    {
        ob_skill_selection::close_ob_skill_selection();
    }
    
    if ( interactobject )
    {
        thread function_1c43a08346f99fba( interactobject );
    }
    
    if ( var_5ce0dbf5f38f284b )
    {
        ob_skill_selection::open_ob_skill_selection();
    }
    
    return ob_skill_selection::function_d9353542f9f53014( var_6b26d0a59b76b334, var_cb18fbca207f8bda, var_f06bf262e0bdbfb1 );
}

// Namespace ob_item_select
// Params 5
// Checksum 0x739fd972, Offset: 0x10e7
// Size: 0x72
function function_8df94337cce4ddcf( interactobject, var_7b955ef638656ecb, skilltier, var_821f24df33d3c2d2, var_f06bf262e0bdbfb1 )
{
    if ( isdefined( var_821f24df33d3c2d2 ) )
    {
        var_1beaecc99fb0c2d3 = var_821f24df33d3c2d2;
    }
    else
    {
        var_1beaecc99fb0c2d3 = skilltier == 2 ? &"hash_18c23eba3c487fdd" : &"hash_34929b100d2844de";
    }
    
    return function_3fe3b855505e2c8b( interactobject, var_7b955ef638656ecb, var_1beaecc99fb0c2d3, var_f06bf262e0bdbfb1 );
}

// Namespace ob_item_select
// Params 4, eflags: 0x4
// Checksum 0xe029b0f, Offset: 0x1162
// Size: 0x65e
function private function_3b98ec3b104d8d9( instance, player, list, count )
{
    if ( !isdefined( instance.playeroptions ) )
    {
        instance.playeroptions = [];
    }
    
    xuid = player getxuid();
    
    if ( instance.playeroptions[ xuid ] && ( !instance.playeroperator[ xuid ] || instance.playeroperator[ xuid ] == player.operatorlootid ) )
    {
        return;
    }
    
    if ( !isdefined( instance.playeroptions[ xuid ] ) )
    {
        instance.playeroptions[ xuid ] = [];
    }
    
    if ( !isdefined( level.ob_item_select_scriptables ) )
    {
        level.ob_item_select_scriptables = [];
    }
    
    level.ob_item_select_scriptables = arraycombineunique( level.ob_item_select_scriptables, [ instance ] );
    items = function_c11af7a197679429( list, count + getdvarint( @"hash_ab710dc80bf92dd", 5 ), undefined, 1 );
    
    for ( i = 0; i < items.size ; i++ )
    {
        itembundle = getscriptbundlefieldvalues( items[ i ], [ #"lootitemtype", #"baseweapon", #"ref", #"subtype", #"rarity" ] );
        type = common_item::function_16e8c106491eeaca( itembundle );
        weaponobj = undefined;
        
        if ( type == "weapon" )
        {
            alreadyhasweapon = 0;
            
            foreach ( weapon in player.primaryinventory )
            {
                if ( weapon.basename == itembundle.baseweapon && !weapon::isbackuppistol( weapon ) )
                {
                    alreadyhasweapon = 1;
                    break;
                }
            }
            
            if ( alreadyhasweapon )
            {
                continue;
            }
            
            if ( instance.playeroptions[ xuid ].size > 0 && instance.playeroptions[ xuid ][ 0 ].weapon.basename == itembundle.baseweapon )
            {
                continue;
            }
            
            weaponobj = item_weapon::function_477bf1207c6672a5( getscriptbundle( items[ i ] ) );
        }
        else if ( type == "revive" )
        {
            var_e7326f6fcf450ebc = player common_item::function_c4c43ebb7aa636dc( "revive" );
            
            if ( var_e7326f6fcf450ebc.count > 0 )
            {
                continue;
            }
        }
        else if ( type == "redeploy_token" )
        {
            if ( namespace_9d8e359c3b1041e5::respawntokendisabledsharedfunc() )
            {
                continue;
            }
        }
        else if ( itembundle.subtype == "exotic_skill" || itembundle.subtype == "nightmare_skill" )
        {
            var_fea25f7ebc743532 = player.var_171e758625364ee0[ itembundle.subtype ][ 0 ];
            
            if ( var_fea25f7ebc743532 && level.skillbundles[ var_fea25f7ebc743532 ][ 0 ].itemspawnentry == items[ i ] )
            {
                continue;
            }
            
            var_9c5a82fcbb086794 = player.var_171e758625364ee0[ itembundle.subtype ][ 1 ];
            
            if ( var_9c5a82fcbb086794 && level.skillbundles[ var_9c5a82fcbb086794 ][ 0 ].itemspawnentry == items[ i ] )
            {
                continue;
            }
        }
        else if ( itembundle.subtype == "major_ability_upgrade" || itembundle.subtype == "minor_ability_upgrade" )
        {
            superref = supers_mp::getcurrentsuperref( itembundle.subtype == "major_ability_upgrade" ? #"default" : #"tactical" );
            abilityupgrades = level.var_df3fc2ed023c3c0d[ getxhash( superref ) ];
            
            if ( abilityupgrades.size == 0 )
            {
                continue;
            }
            
            if ( player.var_bcde97a1f15e0648[ abilityupgrades[ 1 ].skillref ] == 1 )
            {
                items[ i ] = abilityupgrades[ 2 ].itemspawnentry;
            }
            else if ( player.var_bcde97a1f15e0648[ abilityupgrades[ 2 ].skillref ] == 2 )
            {
                items[ i ] = abilityupgrades[ 1 ].itemspawnentry;
            }
            else
            {
                items[ i ] = abilityupgrades[ randomintrange( 1, 3 ) ].itemspawnentry;
            }
        }
        else if ( itembundle.subtype == "rescue_token" && player utility::callsharedfunc( #"ob", #"get_rescue_token_balance" ) > 0 )
        {
            continue;
        }
        else
        {
            var_e7326f6fcf450ebc = player common_item::function_c4c43ebb7aa636dc( type );
            
            if ( var_e7326f6fcf450ebc.name == items[ i ] )
            {
                continue;
            }
        }
        
        instance.playeroptions[ xuid ][ instance.playeroptions[ xuid ].size ] = { #super:superref, #weapon:weaponobj, #subtype:itembundle.subtype, #type:type, #name:items[ i ] };
        
        if ( instance.playeroptions[ xuid ].size >= count )
        {
            break;
        }
    }
    
    if ( instance.playeroptions[ xuid ].size == 0 )
    {
        if ( items.size > 0 )
        {
            type = common_item::function_3cba34a99d02cd9( items[ 0 ] );
            
            if ( type == "weapon" )
            {
                weaponobj = item_weapon::function_477bf1207c6672a5( getscriptbundle( items[ 0 ] ) );
            }
            
            instance.playeroptions[ xuid ][ 0 ] = { #weapon:weaponobj, #type:type, #name:items[ 0 ] };
            return;
        }
        
        instance disablescriptableplayeruse( player );
        instance.disabledplayers = arraycombineunique( instance.disabledplayers, [ player ] );
        assertmsg( "<dev string:x424>" );
    }
}

// Namespace ob_item_select
// Params 2, eflags: 0x4
// Checksum 0xaa8f42fe, Offset: 0x17c8
// Size: 0xf6c
function private function_68ba352ce854066b( instance, player )
{
    xuid = player getxuid();
    options = instance.playeroptions[ xuid ];
    
    if ( !options || player.var_a4730faa314d4569 )
    {
        return -1;
    }
    
    if ( options[ 0 ].subtype == "major_ability_upgrade" )
    {
        if ( options[ 0 ].super != player supers_mp::getcurrentsuperref( #"default" ) )
        {
            options[ 0 ] = options[ 1 ];
            options[ 1 ] = undefined;
            
            if ( options.size == 0 )
            {
                return -1;
            }
        }
    }
    else if ( options[ 0 ].subtype == "minor_ability_upgrade" )
    {
        if ( options[ 0 ].super != player supers_mp::getcurrentsuperref( #"tactical" ) )
        {
            options[ 0 ] = options[ 1 ];
            options[ 1 ] = undefined;
            
            if ( options.size == 0 )
            {
                return -1;
            }
        }
    }
    else if ( options[ 1 ].subtype == "major_ability_upgrade" )
    {
        if ( options[ 1 ].super != player supers_mp::getcurrentsuperref( #"default" ) )
        {
            options[ 1 ] = undefined;
            
            if ( options.size == 0 )
            {
                return -1;
            }
        }
    }
    else if ( options[ 1 ].subtype == "minor_ability_upgrade" )
    {
        if ( options[ 1 ].super != player supers_mp::getcurrentsuperref( #"tactical" ) )
        {
            options[ 1 ] = undefined;
            
            if ( options.size == 0 )
            {
                return -1;
            }
        }
    }
    
    if ( level.var_cead0170a5b9b5eb && options[ 0 ].weapon )
    {
        function_d39fce9af84f0a66( instance, player, xuid );
        player.var_e255db54b20e6285 = instance;
    }
    
    player.var_a4730faa314d4569 = 1;
    
    if ( instance.isexotic )
    {
        assert( options.size == 1, "<dev string:x47f>" );
        
        if ( options[ 0 ].weapon )
        {
            if ( !isdefined( options[ 0 ].ammomod ) )
            {
                var_d25ad50274bfe255 = getscriptbundle( options[ 0 ].name );
                
                if ( isdefined( var_d25ad50274bfe255.var_3b3ea909a13145af ) )
                {
                    ammomodbundle = getscriptbundle( var_d25ad50274bfe255.var_3b3ea909a13145af );
                    
                    if ( isdefined( ammomodbundle ) )
                    {
                        options[ 0 ].ammomod = ammomodbundle.ammomodname;
                    }
                }
            }
            
            if ( function_5ec16980330fc36f( options[ 0 ].weapon ) )
            {
                var_d6d01b48b1a9f85d = function_e29d92c7411b0446( options[ 0 ].weapon );
                
                if ( isdefined( var_d6d01b48b1a9f85d ) )
                {
                    options[ 1 ] = { #weapon:var_d6d01b48b1a9f85d.weaponobj, #type:"weapon", #name:var_d6d01b48b1a9f85d.name };
                    var_984f6ed6dce715e6 = player utility::callsharedfunc( #"zombie", #"get_ammo_mod_name", var_d6d01b48b1a9f85d.weaponobj );
                    
                    if ( var_984f6ed6dce715e6 && var_984f6ed6dce715e6 != "" )
                    {
                        options[ 1 ].ammomod = var_984f6ed6dce715e6;
                    }
                    
                    player setclientomnvar( "ui_ob_selectable_reward_is_equipped_2", 1 );
                }
            }
        }
        else if ( options[ 0 ].subtype == "exotic_skill" || options[ 0 ].subtype == "nightmare_skill" )
        {
            if ( !isdefined( instance.var_154f12a4fb056f4f ) )
            {
                instance.var_154f12a4fb056f4f = [];
            }
            
            if ( !isdefined( instance.var_154f12a4fb056f4f[ xuid ] ) )
            {
                instance.var_154f12a4fb056f4f[ xuid ] = options[ 0 ].name;
            }
            
            var_388d8f529fd6af86 = player.var_171e758625364ee0[ options[ 0 ].subtype ];
            
            if ( var_388d8f529fd6af86.size )
            {
                options[ 0 ].var_72b4fdb97118db5e = undefined;
                
                if ( !instance.var_8ed41bd7f5cb740[ xuid ] && instance.var_154f12a4fb056f4f[ xuid ] != options[ 0 ].name && instance.var_154f12a4fb056f4f[ xuid ] != level.skillbundles[ options[ 0 ].skillref ][ 0 ].itemspawnentry && options[ 0 ].skilllevel < options[ 0 ].var_f463fd4a9608ce51 )
                {
                    options[ 0 ].name = level.skillbundles[ options[ 0 ].skillref ][ options[ 0 ].skilllevel + 1 ].itemspawnentry;
                    options[ 0 ].var_72b4fdb97118db5e = 1;
                    player setclientomnvar( "ui_ob_selectable_reward_is_loadout_weapon_1", 1 );
                }
                else
                {
                    player setclientomnvar( "ui_ob_selectable_reward_is_new_1", 1 );
                }
                
                var_fea25f7ebc743532 = var_388d8f529fd6af86[ 0 ];
                var_94adb1651f05dacd = player.activeskills[ var_fea25f7ebc743532 ];
                var_86b3b2f68f9f5a21 = level.skillbundles[ var_fea25f7ebc743532 ][ 0 ].var_f463fd4a9608ce51;
                var_9c43b88c770b0436 = level.skillbundles[ var_fea25f7ebc743532 ][ var_94adb1651f05dacd ].itemspawnentry;
                assert( isdefined( var_94adb1651f05dacd ) );
                
                if ( instance.var_8ed41bd7f5cb740[ xuid ] || var_86b3b2f68f9f5a21 == var_94adb1651f05dacd || instance.var_154f12a4fb056f4f[ xuid ] == var_9c43b88c770b0436 )
                {
                    options[ 1 ] = { #skillref:var_fea25f7ebc743532, #subtype:options[ 0 ].subtype, #type:"generic", #name:var_9c43b88c770b0436 };
                    player setclientomnvar( "ui_ob_selectable_reward_is_equipped_2", 1 );
                }
                else
                {
                    options[ 1 ] = { #skillref:var_fea25f7ebc743532, #var_72b4fdb97118db5e:1, #subtype:options[ 0 ].subtype, #type:"generic", #name:level.skillbundles[ var_fea25f7ebc743532 ][ var_94adb1651f05dacd + 1 ].itemspawnentry };
                    player setclientomnvar( "ui_ob_selectable_reward_is_loadout_weapon_2", 1 );
                }
                
                var_9c5a82fcbb086794 = var_388d8f529fd6af86[ 1 ];
                
                if ( var_9c5a82fcbb086794 )
                {
                    var_ca40a8404651efeb = player.activeskills[ var_9c5a82fcbb086794 ];
                    var_3bd920b90fcf2f3 = level.skillbundles[ var_9c5a82fcbb086794 ][ 0 ].var_f463fd4a9608ce51;
                    var_ba88a4fb500cffd0 = level.skillbundles[ var_9c5a82fcbb086794 ][ var_ca40a8404651efeb ].itemspawnentry;
                    assert( isdefined( var_ca40a8404651efeb ) );
                    
                    if ( instance.var_8ed41bd7f5cb740[ xuid ] || var_3bd920b90fcf2f3 == var_ca40a8404651efeb || instance.var_154f12a4fb056f4f[ xuid ] == var_ba88a4fb500cffd0 )
                    {
                        options[ 2 ] = { #skillref:var_9c5a82fcbb086794, #subtype:options[ 0 ].subtype, #type:"generic", #name:var_ba88a4fb500cffd0 };
                        player setclientomnvar( "ui_ob_selectable_reward_is_equipped_3", 1 );
                    }
                    else
                    {
                        options[ 2 ] = { #skillref:var_9c5a82fcbb086794, #var_72b4fdb97118db5e:1, #subtype:options[ 0 ].subtype, #type:"generic", #name:level.skillbundles[ var_9c5a82fcbb086794 ][ var_ca40a8404651efeb + 1 ].itemspawnentry };
                        player setclientomnvar( "ui_ob_selectable_reward_is_loadout_weapon_3", 1 );
                    }
                }
                
                var_1e1f801e8805ed1b = getscriptbundlefieldvalue( options[ 0 ].name, #"ref" );
                
                if ( var_1e1f801e8805ed1b )
                {
                    var_51e27477b979110b = getscriptbundlefieldvalue( hashcat( %"skill:", var_1e1f801e8805ed1b ), #"skillref" );
                    
                    if ( var_51e27477b979110b == var_fea25f7ebc743532 || var_51e27477b979110b == var_9c5a82fcbb086794 )
                    {
                        player setclientomnvar( "ui_ob_selectable_reward_is_new_1", 0 );
                        player setclientomnvar( "ui_ob_selectable_reward_is_loadout_weapon_1", 0 );
                        player setclientomnvar( "ui_ob_selectable_reward_is_equipped_1", 1 );
                    }
                }
            }
            else
            {
                player setclientomnvar( "ui_ob_selectable_reward_is_new_1", 1 );
            }
        }
    }
    
    for ( i = 0; i < options.size ; i++ )
    {
        weapon = options[ i ].weapon;
        
        if ( weapon )
        {
            j = i + 1;
            
            if ( weapon.conversionkit )
            {
                player setclientomnvar( "ui_ob_selectable_reward_conversion_id_" + j, weapon.attachmentsbundles[ weapon.attachmentsbundles.size - 1 ].lootid );
            }
            
            if ( options[ i ].weaponmetadata )
            {
                player setclientomnvar( "ui_ob_selectable_reward_is_loadout_weapon_" + j, 1 );
            }
            
            attachmentcount = 0;
            defaultattachments = getweapondefaultattachments( weapon );
            
            foreach ( attachment in weapon.attachments )
            {
                if ( "conversionkit" == getattachmentslot( weapon, attachment ) )
                {
                    attachmentcount = 8;
                    break;
                }
                
                if ( arraycontains( defaultattachments, attachment ) )
                {
                    continue;
                }
                
                if ( !utility::callsharedfunc( #"weapons", #"hash_35d31d8d23e44a0", weapon, attachment ) )
                {
                    continue;
                }
                
                attachmentcount += 1;
            }
            
            player setclientomnvar( "ui_ob_selectable_reward_num_attachments_" + j, minint( 8, attachmentcount ) );
            modindex = player utility::callsharedfunc( #"ammo_mod", #"hash_ddbe3f904027bd04", options[ i ].ammomod );
            
            if ( isdefined( modindex ) )
            {
                player setclientomnvar( "ui_ob_selectable_reward_ammo_mod_index_" + j, modindex );
            }
            
            continue;
        }
        
        if ( options[ i ].type == "redeploy_token" )
        {
            if ( namespace_9d8e359c3b1041e5::respawntokendisabledsharedfunc() )
            {
                options[ i ] = undefined;
                continue;
            }
            
            if ( !namespace_9d8e359c3b1041e5::function_cddfe06629132726() )
            {
                player setclientomnvar( "ui_ob_selectable_reward_is_equipped_" + i + 1, 1 );
            }
            
            continue;
        }
        
        if ( options[ i ].type != "exotic_skill" && options[ i ].type != "nightmare_skill" )
        {
            var_e7326f6fcf450ebc = player common_item::function_c4c43ebb7aa636dc( options[ i ].type );
            
            if ( var_e7326f6fcf450ebc.count > 0 && var_e7326f6fcf450ebc.name == options[ i ].name )
            {
                player setclientomnvar( "ui_ob_selectable_reward_is_equipped_" + i + 1, 1 );
            }
        }
    }
    
    var_d80b9af675cc8273 = options[ 0 ].subtype == "exotic_skill" || options[ 0 ].subtype == "nightmare_skill";
    use_skill_widget = var_d80b9af675cc8273 && getdvarint( @"hash_13b13d8336999e21", 0 ) != 0;
    
    if ( use_skill_widget )
    {
        skilltier = options[ 0 ].subtype == "nightmare_skill" ? 2 : 1;
        var_7b955ef638656ecb = [];
        var_388d8f529fd6af86 = player.var_171e758625364ee0[ options[ 0 ].subtype ];
        tileidx = 0;
        optionref = undefined;
        var_aa5d6b7be73d367b = undefined;
        var_c1611a65af8736a3 = 0;
        var_51e27477b979110b = undefined;
        var_40639cb5246475fb = undefined;
        
        for ( tileidx = 0; tileidx < options.size ; tileidx++ )
        {
            if ( !isdefined( options[ tileidx ] ) )
            {
                continue;
            }
            
            optionref = getscriptbundlefieldvalue( options[ tileidx ].name, #"ref" );
            var_aa5d6b7be73d367b = function_d1f4883f5539b473( optionref );
            skillref = getscriptbundlefieldvalue( var_aa5d6b7be73d367b, #"skillref" );
            var_c1611a65af8736a3 = isdefined( player.activeskills[ skillref ] );
            var_72b4fdb97118db5e = options[ tileidx ].var_72b4fdb97118db5e;
            isreplaceable = tileidx > 0;
            var_40639cb5246475fb = 0;
            
            if ( !var_c1611a65af8736a3 || var_72b4fdb97118db5e )
            {
                var_40639cb5246475fb = getscriptbundlefieldvalue( var_aa5d6b7be73d367b, #"skilllevel" ) ?? 0;
            }
            else
            {
                var_40639cb5246475fb = player.activeskills[ skillref ];
            }
            
            var_7b955ef638656ecb[ tileidx ] = function_107a19ba8e9d4bfb( "skill", var_aa5d6b7be73d367b, var_c1611a65af8736a3, options[ tileidx ].name, var_40639cb5246475fb, var_72b4fdb97118db5e, isreplaceable );
        }
        
        var_7f5d0a08e45040ca = 1;
        
        if ( options[ 0 ].subtype == "nightmare_skill" && player.operatorprestige > 1 )
        {
            var_7f5d0a08e45040ca = 2;
        }
        else if ( options[ 0 ].subtype == "exotic_skill" && player.operatorprestige > 0 )
        {
            var_7f5d0a08e45040ca = 2;
        }
        
        needsreplace = var_388d8f529fd6af86.size >= var_7f5d0a08e45040ca;
        chosenindex = player function_8df94337cce4ddcf( instance, var_7b955ef638656ecb, skilltier, undefined, needsreplace );
        
        if ( player.swappingskill )
        {
            player.swappingskill--;
            chosenindex = 0;
        }
    }
    else
    {
        chosenindex = player function_55bae6c0c5e50953( instance, options[ 0 ].name, options[ 1 ].name, options[ 2 ].name );
        
        if ( chosenindex == 0 && options.size == 3 && var_d80b9af675cc8273 )
        {
            waitframe();
            player setclientomnvar( "ui_ob_selectable_reward_is_new_1", 0 );
            player setclientomnvar( "ui_ob_selectable_reward_is_equipped_1", 0 );
            player setclientomnvar( "ui_ob_selectable_reward_is_equipped_2", 0 );
            player setclientomnvar( "ui_ob_selectable_reward_is_loadout_weapon_1", 0 );
            player setclientomnvar( "ui_ob_selectable_reward_is_loadout_weapon_2", 0 );
            item1 = level.skillbundles[ options[ 1 ].skillref ][ player.activeskills[ options[ 1 ].skillref ] ].itemspawnentry;
            item2 = level.skillbundles[ options[ 2 ].skillref ][ player.activeskills[ options[ 2 ].skillref ] ].itemspawnentry;
            chosenindex = player function_55bae6c0c5e50953( instance, item1, item2 );
            
            if ( chosenindex >= 0 )
            {
                player.swappingskill = chosenindex;
                chosenindex = 0;
            }
        }
    }
    
    for ( i = 0; i < 3 ; i++ )
    {
        j = i + 1;
        player setclientomnvar( "ui_ob_selectable_reward_conversion_id_" + j, 0 );
        player setclientomnvar( "ui_ob_selectable_reward_is_loadout_weapon_" + j, 0 );
        player setclientomnvar( "ui_ob_selectable_reward_num_attachments_" + j, 0 );
        player setclientomnvar( "ui_ob_selectable_reward_is_equipped_" + j, 0 );
        player setclientomnvar( "ui_ob_selectable_reward_ammo_mod_index_" + j, 0 );
        player setclientomnvar( "ui_ob_selectable_reward_is_new_" + j, 0 );
    }
    
    player.var_a4730faa314d4569 = undefined;
    player.var_e255db54b20e6285 = undefined;
    return chosenindex;
}

// Namespace ob_item_select
// Params 6, eflags: 0x4
// Checksum 0x719dd48d, Offset: 0x273d
// Size: 0x43d
function private function_21ba59c9071828bd( instance, player, index, xuid, option, newitembundle )
{
    player endon( #"disconnect" );
    skillbundle = getscriptbundlefieldvalues( hashcat( %"skill:", newitembundle.ref ), [ #"skillref", #"skilllevel", #"hash_cec10972b7814dd0" ] );
    
    if ( !skillbundle.skillref || player.activeskills[ skillbundle.skillref ] == skillbundle.skilllevel )
    {
        return;
    }
    
    choicecount = instance.playeroptions[ xuid ].size;
    requiredprestige = option.subtype == "exotic_skill" ? 1 : 2;
    
    if ( !isdefined( player.operatorprestige ) || player.operatorprestige < requiredprestige )
    {
        var_425747011984ea95 = player.var_171e758625364ee0[ option.subtype ][ 0 ];
        var_e6e738f904d9141e = player.activeskills[ var_425747011984ea95 ];
    }
    else if ( isdefined( player.swappingskill ) )
    {
        var_425747011984ea95 = player.var_171e758625364ee0[ option.subtype ][ player.swappingskill ];
        var_e6e738f904d9141e = player.activeskills[ var_425747011984ea95 ];
        player.var_171e758625364ee0[ option.subtype ][ player.swappingskill ] = undefined;
        swappedskill = player.swappingskill;
        player.swappingskill = undefined;
    }
    else if ( player.var_171e758625364ee0[ option.subtype ].size == 1 )
    {
        var_317edd0bf8e8323b = 1;
    }
    
    if ( getdvarint( @"hash_fa536bc1c4c0d1ac", 0 ) && isdefined( player.activeskills[ skillbundle.skillref ] ) )
    {
        player utility::callsharedfunc( #"skills", #"removeskill", skillbundle.skillref );
        
        if ( var_317edd0bf8e8323b )
        {
            instance.playeroptions[ xuid ] = [];
        }
        
        waitframe();
    }
    
    if ( player utility::callsharedfunc( #"skills", #"giveskill", skillbundle.skillref, skillbundle.skilllevel, 1 ) )
    {
        if ( option.subtype == "exotic_skill" )
        {
            player thread hud_message::showsplash( option.var_72b4fdb97118db5e ? #"exotic_skill_upgraded" : #"exotic_skill_equipped" );
        }
        else
        {
            player thread hud_message::showsplash( option.var_72b4fdb97118db5e ? #"nightmare_skill_upgraded" : #"nightmare_skill_equipped" );
        }
        
        if ( option.var_72b4fdb97118db5e || var_317edd0bf8e8323b )
        {
            if ( !isdefined( instance.var_8ed41bd7f5cb740 ) )
            {
                instance.var_8ed41bd7f5cb740 = [];
            }
            
            instance.var_8ed41bd7f5cb740[ xuid ] = 1;
        }
        
        if ( index == 0 && var_425747011984ea95 )
        {
            option.skillref = var_425747011984ea95;
            option.skilllevel = var_e6e738f904d9141e;
            option.var_f463fd4a9608ce51 = level.skillbundles[ var_425747011984ea95 ][ 0 ].var_f463fd4a9608ce51;
            option.name = level.skillbundles[ var_425747011984ea95 ][ var_e6e738f904d9141e ].itemspawnentry;
            player utility::callsharedfunc( #"skills", #"removeskill", var_425747011984ea95 );
        }
        
        if ( choicecount == 1 || var_317edd0bf8e8323b )
        {
            instance.playeroptions[ xuid ] = [];
        }
        
        return;
    }
    
    if ( isdefined( swappedskill ) )
    {
        player.var_171e758625364ee0[ option.subtype ][ swappedskill ] = var_425747011984ea95;
    }
}

// Namespace ob_item_select
// Params 6, eflags: 0x4
// Checksum 0x3a81eb4, Offset: 0x2b82
// Size: 0x204
function private function_389edea8a57ee508( instance, player, index, xuid, option, newitembundle )
{
    player endon( #"disconnect" );
    choicecount = instance.playeroptions[ xuid ].size;
    var_3b05ce84776ac811 = player.var_171e758625364ee0[ option.subtype ];
    
    if ( var_3b05ce84776ac811 && getdvarint( @"hash_fa536bc1c4c0d1ac", 0 ) )
    {
        var_425747011984ea95 = var_3b05ce84776ac811;
        var_e6e738f904d9141e = player.var_bcde97a1f15e0648[ var_3b05ce84776ac811 ];
        player utility::callsharedfunc( #"skills", #"removeskill", var_3b05ce84776ac811 );
        waitframe();
    }
    
    skillbundle = getscriptbundlefieldvalues( hashcat( %"skill:", newitembundle.ref ), [ #"skillref", #"skilllevel" ] );
    
    if ( skillbundle.skillref && player utility::callsharedfunc( #"skills", #"giveskill", skillbundle.skillref, skillbundle.skilllevel, 1 ) )
    {
        player thread hud_message::showsplash( #"ability_upgrade_equipped" );
        
        if ( var_425747011984ea95 )
        {
            option.name = level.skillbundles[ var_425747011984ea95 ][ var_e6e738f904d9141e ].itemspawnentry;
        }
        else if ( choicecount == 1 )
        {
            instance.playeroptions[ xuid ] = [];
        }
        else
        {
            instance.playeroptions[ xuid ][ index ] = undefined;
            function_cdc669dbc8ea2101( instance.playeroptions[ xuid ] );
        }
        
        return;
    }
    
    if ( var_425747011984ea95 )
    {
        player utility::callsharedfunc( #"skills", #"giveskill", var_425747011984ea95, var_e6e738f904d9141e, 1 );
    }
}

// Namespace ob_item_select
// Params 4, eflags: 0x4
// Checksum 0x2261feee, Offset: 0x2d8e
// Size: 0x78e
function private function_5e5c7083dfb3c733( instance, player, index, var_bc9fa6df155b600 )
{
    xuid = player getxuid();
    option = instance.playeroptions[ xuid ][ index ];
    
    if ( !option )
    {
        return;
    }
    
    newitembundle = getscriptbundle( option.name );
    
    if ( newitembundle.subtype == "exotic_skill" || newitembundle.subtype == "nightmare_skill" )
    {
        thread function_21ba59c9071828bd( instance, player, index, xuid, option, newitembundle );
        return;
    }
    
    if ( newitembundle.subtype == "major_ability_upgrade" || newitembundle.subtype == "minor_ability_upgrade" )
    {
        thread function_389edea8a57ee508( instance, player, index, xuid, option, newitembundle );
        return;
    }
    
    if ( newitembundle.subtype == "rescue_token" )
    {
        player setplayerdata( "common", "rescueTokenBalance", 1 );
        player.var_77fecdad95537975 = 1;
        instance.playeroptions[ xuid ][ index ] = undefined;
        function_cdc669dbc8ea2101( instance.playeroptions[ xuid ] );
        return;
    }
    
    callback::callback( #"hash_7d9bc8c63927657", { #player:player, #objweapon:option.weapon, #instance:instance } );
    oldweapon = isdefined( option.weapon ) ? player item_weapon::function_6e9acdbb392dabc5( option.weapon )[ 1 ] : undefined;
    var_1ce8b427e7614850 = player common_item::function_c4c43ebb7aa636dc( option.type, { #weapon:oldweapon } );
    
    if ( var_1ce8b427e7614850.name == option.name && oldweapon === option.weapon && option.type != "revive" && option.type != "redeploy_token" )
    {
        return;
    }
    
    if ( option.type == "killstreak" && !player val::get( "crate_use" ) )
    {
        return;
    }
    
    if ( !player common_item::function_5f81801cb8c86ac2( option.name, newitembundle, undefined, 0, option.type ) )
    {
        return;
    }
    
    if ( var_1ce8b427e7614850 )
    {
        if ( oldweapon )
        {
            oldammomod = player utility::callsharedfunc( #"ammo_mod", #"hash_cf1012c4d313de70", oldweapon );
            var_b92e1c35f6d3ef47 = utility::callsharedfunc( #"instanceInventory", #"hash_6198432a8749926e", player, oldweapon );
            var_5f064b00559f72e6 = utility::callsharedfunc( #"instanceInventory", #"getweaponmetadata", player, var_b92e1c35f6d3ef47 );
            var_87c8d3d81132dea9 = var_1ce8b427e7614850.count;
            oldweaponstockammo = player getweaponammostock( oldweapon );
            utility::callsharedfunc( #"instanceInventory", #"hash_2ada83a8a20e59f7", player, var_b92e1c35f6d3ef47 );
        }
        
        if ( !var_bc9fa6df155b600 )
        {
            player common_item::function_bbba261e6fdc7e52( option.type, { #var_374a2fec695f49d8:1, #weapon:oldweapon, #dontdrop:1 } );
        }
    }
    else if ( option.type == "lethal" )
    {
        if ( getdvarint( @"hash_d85c338f51e0290a", 0 ) )
        {
            var_58bcf9d6158779a5 = player equipment_mp::getcurrentequipment( "primary" );
            var_771b0eea37584a5b = common_item_database::function_a4f0a21951180013( var_58bcf9d6158779a5 );
            script::demoforcesre( "oldItemInfo is undefined. \nSelected Item Name: " + option.name + "\nSelected Item Type: " + option.type + "\nSelected Item Ref: " + newitembundle.ref + "\nPrimary Equipment Name: " + var_771b0eea37584a5b + "\nPrimary Equipment Ref: " + var_58bcf9d6158779a5 );
        }
    }
    
    spawnoptions = common_item::items_initspawnoptions_spawnfromentity( instance );
    spawnoptions.weapon = option.weapon;
    newitem = common_item::function_61c2c0251e742ffd( newitembundle, option.count, spawnoptions );
    newitem.name = option.name;
    newitem.bundlename = option.name;
    newitem.fromground = var_bc9fa6df155b600;
    
    if ( newitem.var_6828becb300b1c44 )
    {
        newitem.var_6828becb300b1c44.itembundlename = option.name;
        
        if ( option.ammomod )
        {
            newitem.var_6828becb300b1c44.var_3b3ea909a13145af = option.ammomod;
        }
    }
    
    if ( option.stockammo )
    {
        newitem.weaponstockammo = option.stockammo;
    }
    
    instance callback::callback( #"hash_ea64b6a9c741bb10", { #newitem:newitem, #player:player } );
    
    if ( var_bc9fa6df155b600 )
    {
        player common_item::function_96119bed8ab4c5d9( newitem );
    }
    else if ( !player common_item::function_2b5e2ff57d5f392( newitem, undefined, undefined, option.name, newitembundle, option.type ) )
    {
        assertmsg( "<dev string:x4ca>" + getxhashsourcename( option.name ) );
    }
    
    if ( var_1ce8b427e7614850.count == 0 && option.type == "lethal" && level.equipment.table[ newitembundle.ref ].bundle.var_ff969a74ed1aaeba && !level.var_83d8ad2846573fbf )
    {
        player equipment_mp::setequipmentammo( newitembundle.ref, 0 );
    }
    
    if ( option.weaponmetadata )
    {
        var_a094c8270cd5a81c = utility::callsharedfunc( #"instanceInventory", #"hash_6198432a8749926e", player, option.weapon );
        utility::callsharedfunc( #"instanceInventory", #"hash_a7273367e0015a6e", player, var_a094c8270cd5a81c, option.weaponmetadata );
    }
    
    if ( !var_bc9fa6df155b600 && var_1ce8b427e7614850 && option.type != "revive" && option.type != "redeploy_token" )
    {
        instance.playeroptions[ xuid ][ index ] = { #weaponmetadata:var_5f064b00559f72e6, #ammomod:oldammomod, #stockammo:oldweaponstockammo, #weapon:var_1ce8b427e7614850.weaponobj, #count:var_87c8d3d81132dea9, #type:option.type, #name:var_1ce8b427e7614850.name };
    }
    else
    {
        instance.playeroptions[ xuid ][ index ] = undefined;
        function_cdc669dbc8ea2101( instance.playeroptions[ xuid ] );
    }
    
    if ( instance.playeroptions[ xuid ].size == 0 )
    {
        instance disablescriptableplayeruse( player );
        instance.disabledplayers = arraycombineunique( instance.disabledplayers, [ player ] );
    }
}

// Namespace ob_item_select
// Params 1, eflags: 0x4
// Checksum 0x2882bafa, Offset: 0x3524
// Size: 0x49, Type: bool
function private function_56480c009bae5d9d( instance )
{
    return instance.isexotic && ( instance.type == #"obloot_item_select_exotic_skill" || instance.type == #"obloot_item_select_nightmare_skill" );
}

// Namespace ob_item_select
// Params 1, eflags: 0x4
// Checksum 0x618c6a5, Offset: 0x3576
// Size: 0x30, Type: bool
function private function_52f1736c4c1b06d4( instance )
{
    return instance.isexotic && instance.type == #"obloot_item_select_exotic_weapon";
}

// Namespace ob_item_select
// Params 1, eflags: 0x4
// Checksum 0x14046100, Offset: 0x35af
// Size: 0x54b, Type: bool
function private function_f5c0d2bd620169a4( params )
{
    player = params.player;
    instance = params.instance;
    
    if ( !isplayer( player ) )
    {
        return false;
    }
    
    player endon( #"disconnect" );
    
    if ( params.itembundle.subtype != "item_select" || !params.itembundle.var_c53cd28a247f8de5 )
    {
        return false;
    }
    
    xuid = player getxuid();
    
    if ( params.itembundle.var_525549285414da41 && params.itembundle.var_525549285414da41 <= instance.playeroptions.size && !instance.playeroptions[ xuid ] )
    {
        return false;
    }
    
    instance.usercount = isdefined( instance.usercount ) ? instance.usercount + 1 : 1;
    
    if ( !isdefined( instance.disabledplayers ) )
    {
        instance.disabledplayers = [];
    }
    
    instance.isexotic = params.itembundle.rarity == 5;
    
    if ( !isdefined( instance.isanimated ) )
    {
        instance.isanimated = instance getscriptableparthasstate( instance.type, #"opening" );
    }
    
    if ( instance.isanimated && #"visible" == instance getscriptablepartstate( instance.type, 0, 1 ) )
    {
        instance setscriptablepartstate( instance.type, #"opening" );
    }
    
    instance disablescriptableplayeruse( player );
    instance.disabledplayers = arraycombineunique( instance.disabledplayers, [ player ] );
    function_3b98ec3b104d8d9( instance, player, params.itembundle.var_c53cd28a247f8de5, params.itembundle.var_4d4a60aa4f956c20 );
    chosenindex = function_68ba352ce854066b( instance, player );
    
    if ( !player || !instance )
    {
        return false;
    }
    
    function_5e5c7083dfb3c733( instance, player, chosenindex, params.itembundle.var_25b7c1d5004bec2f );
    
    if ( instance.isexotic )
    {
        if ( getdvarint( @"hash_86bb7fa9780e922e", 1 ) )
        {
            if ( !isdefined( instance.playeroperator ) )
            {
                instance.playeroperator = [];
            }
            
            instance.playeroperator[ xuid ] = player.operatorlootid;
        }
        
        instance.playeroptions[ xuid ][ 1 ] = undefined;
        instance.playeroptions[ xuid ][ 2 ] = undefined;
    }
    
    if ( function_56480c009bae5d9d( instance ) )
    {
        level callback::callback( #"hash_91f2a0e70afebfe1", { #exoticcase:instance, #interactionevent:#"hash_5907e591e1155d16", #player:player } );
    }
    else if ( function_52f1736c4c1b06d4( instance ) )
    {
        level callback::callback( #"hash_91f2a0e70afebfe1", { #exoticcase:instance, #interactionevent:#"hash_a8733271ed9400d7", #player:player } );
    }
    
    if ( instance.var_df76d6977d8f4265 )
    {
        level callback::callback( #"hash_91f2a0e70afebfe1", { #interactionevent:#"on_obtain_elite_weapon", #player:player } );
    }
    
    instance.usercount--;
    
    if ( instance.playeroptions[ xuid ].size > 0 )
    {
        instance enablescriptableplayeruse( player );
        instance.disabledplayers = arrayremove( instance.disabledplayers, player );
    }
    else if ( params.itembundle.var_525549285414da41 && params.itembundle.var_525549285414da41 <= instance.playeroptions.size )
    {
        var_82bf54d9d93f9cc7 = 1;
        
        foreach ( playeroptions in instance.playeroptions )
        {
            if ( playeroptions.size > 0 )
            {
                var_82bf54d9d93f9cc7 = 0;
                break;
            }
        }
        
        if ( var_82bf54d9d93f9cc7 )
        {
            return true;
        }
    }
    
    if ( instance.isanimated && instance.usercount <= 0 )
    {
        state = instance getscriptablepartstate( instance.type, 0, 1 );
        
        if ( #"open" == state || #"opening" == state )
        {
            instance setscriptablepartstate( instance.type, #"closing" );
        }
    }
    
    return false;
}

// Namespace ob_item_select
// Params 1, eflags: 0x4
// Checksum 0x20d37330, Offset: 0x3b03
// Size: 0x86
function private function_cd34c925ad699236( params )
{
    params.item endon( #"death" );
    params.item notify( #"hash_3ae3c300e1469d62" );
    wait params.itembundle.lifetime ?? 90;
    
    while ( params.item.usercount > 0 )
    {
        wait 10;
    }
    
    level thread common_item::function_869d7676e359a627( params.item );
}

// Namespace ob_item_select
// Params 1, eflags: 0x4
// Checksum 0x16d03644, Offset: 0x3b91
// Size: 0x2a
function private function_1951ae23a618fc1b( params )
{
    level thread function_645fa793f9d08b90( params.cache, params.player );
}

// Namespace ob_item_select
// Params 2, eflags: 0x4
// Checksum 0xff864a6c, Offset: 0x3bc3
// Size: 0x2d3
function private function_645fa793f9d08b90( instance, player )
{
    if ( !isplayer( player ) )
    {
        return 0;
    }
    
    player endon( #"disconnect" );
    itembundlename = common_item::function_33a2c00e46263d99( instance );
    itembundle = getscriptbundlefieldvalues( itembundlename, [ #"subtype" ] );
    
    if ( itembundle.subtype != "item_select" )
    {
        return;
    }
    
    instance.usercount = isdefined( instance.usercount ) ? instance.usercount + 1 : 1;
    
    if ( !isdefined( instance.disabledplayers ) )
    {
        instance.disabledplayers = [];
    }
    
    if ( !isdefined( instance.isanimated ) )
    {
        instance.isanimated = instance getscriptableparthasstate( "body", #"opening" );
    }
    
    if ( instance.isanimated && #"closed_usable" == instance getscriptablepartstate( "body", 0, 1 ) )
    {
        instance setscriptablepartstate( "body", #"opening" );
    }
    
    var_f0d1f5bbea1fc792 = function_c0c3cd7e33e65928( instance );
    
    if ( var_f0d1f5bbea1fc792 )
    {
        instance disablescriptableplayeruse( player );
        instance.disabledplayers = arraycombineunique( instance.disabledplayers, [ player ] );
        var_3efdaa7af9dd3471 = getscriptbundlefieldvalues( var_f0d1f5bbea1fc792, [ #"hash_f18e4961437edd9d", #"hash_6185e16d74c7bd2a" ] );
        function_3b98ec3b104d8d9( instance, player, var_3efdaa7af9dd3471.var_c53cd28a247f8de5, var_3efdaa7af9dd3471.var_4d4a60aa4f956c20 );
        chosenindex = function_68ba352ce854066b( instance, player );
        
        if ( !player || !instance )
        {
            return;
        }
        
        function_5e5c7083dfb3c733( instance, player, chosenindex );
        xuid = player getxuid();
        
        if ( instance.isexotic )
        {
            instance.playeroptions[ xuid ][ 1 ] = undefined;
            instance.playeroptions[ xuid ][ 2 ] = undefined;
        }
        
        instance.usercount--;
        
        if ( instance.playeroptions[ xuid ].size > 0 )
        {
            instance enablescriptableplayeruse( player );
            instance.disabledplayers = arrayremove( instance.disabledplayers, player );
        }
        
        if ( instance.isanimated && instance.usercount <= 0 )
        {
            state = instance getscriptablepartstate( "body", 0, 1 );
            
            if ( #"open" == state || #"opening" == state )
            {
                instance setscriptablepartstate( "body", #"closing" );
            }
        }
    }
}

// Namespace ob_item_select
// Params 1, eflags: 0x4
// Checksum 0x8bed0181, Offset: 0x3e9e
// Size: 0x116
function private function_c0c3cd7e33e65928( instance )
{
    var_7237854e3be197ca = instance.var_f0d1f5bbea1fc792;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    var_f0d1f5bbea1fc792 = undefined;
    newcontents = [];
    
    foreach ( iteminfo in instance.contents )
    {
        var_1820281685f330c8 = common_item_database::function_db2360bc1c33f6f9( iteminfo.lootid );
        
        if ( var_1820281685f330c8 )
        {
            if ( "item_select" == getscriptbundlefieldvalue( var_1820281685f330c8, #"subtype" ) )
            {
                var_f0d1f5bbea1fc792 = var_1820281685f330c8;
                instance.var_f0d1f5bbea1fc792 = var_1820281685f330c8;
                continue;
            }
            
            newcontents[ newcontents.size ] = iteminfo;
        }
    }
    
    instance.contents = newcontents;
    return var_f0d1f5bbea1fc792;
}

// Namespace ob_item_select
// Params 1, eflags: 0x4
// Checksum 0x158e39a3, Offset: 0x3fbd
// Size: 0x23
function private function_fcec9cf38ac2f3dd( params )
{
    params.cacheinstance.contents = [];
}

// Namespace ob_item_select
// Params 4, eflags: 0x4
// Checksum 0xfaeb3efe, Offset: 0x3fe8
// Size: 0x13e
function private function_36ce53759b7f0445( instance, note, param, var_64ffacba090c91be )
{
    if ( instance.enabledplayers )
    {
        instance function_7653c765b6c7b815();
        
        foreach ( player in instance.enabledplayers )
        {
            instance enablescriptableplayeruse( player );
        }
    }
    else
    {
        instance function_e203bba36cfb19d0();
    }
    
    if ( instance.disabledplayers )
    {
        foreach ( player in instance.disabledplayers )
        {
            instance disablescriptableplayeruse( player );
        }
    }
}

/#

    // Namespace ob_item_select
    // Params 1, eflags: 0x4
    // Checksum 0x4aae55b4, Offset: 0x412e
    // Size: 0x8c, Type: dev
    function private function_c620066e0d21a30f( params )
    {
        var_368ec277cd35ed4 = params[ 0 ];
        var_368ef277cd3656d = params[ 1 ] == "<dev string:x4f6>" ? undefined : params[ 1 ];
        
        if ( int( params[ 2 ] ) == 1 )
        {
            slot = #"default";
        }
        else
        {
            slot = #"tactical";
        }
        
        function_95f9ecc2af4693f6( level.players[ 0 ].origin, var_368ec277cd35ed4, var_368ef277cd3656d, slot );
    }

    // Namespace ob_item_select
    // Params 1, eflags: 0x4
    // Checksum 0xda2be386, Offset: 0x41c2
    // Size: 0x155, Type: dev
    function private function_34849e5d6b5b9ded( var_641a5946f172bffd )
    {
        var_d7a8f33465bf1740 = [];
        allskills = level.skillbundles;
        expectedcategory = var_641a5946f172bffd == "<dev string:x4fb>" ? #"nightmare" : #"end_game";
        
        foreach ( skillref, skilllevels in allskills )
        {
            if ( isdefined( skilllevels[ 0 ] ) && skilllevels[ 0 ].skillcategory == expectedcategory )
            {
                info = {};
                info.asset = skilllevels[ 0 ].asset;
                info.itemspawnentry = skilllevels[ 0 ].itemspawnentry;
                info.var_f463fd4a9608ce51 = skilllevels[ 0 ].var_f463fd4a9608ce51;
                info.skillref = skillref;
                var_d7a8f33465bf1740[ var_d7a8f33465bf1740.size ] = info;
            }
            
            if ( var_d7a8f33465bf1740.size >= 3 )
            {
                break;
            }
        }
        
        return var_d7a8f33465bf1740;
    }

    // Namespace ob_item_select
    // Params 5, eflags: 0x4
    // Checksum 0x14221217, Offset: 0x431f
    // Size: 0x98, Type: dev
    function private function_89d53b507d5e45a6( skillinfo, skilllevel, var_c1611a65af8736a3, var_72b4fdb97118db5e, isreplaceable )
    {
        skilllevels = level.skillbundles[ skillinfo.skillref ];
        itemspawnname = skilllevels[ skilllevel ].itemspawnentry;
        skillasset = skilllevels[ skilllevel ].asset;
        return function_107a19ba8e9d4bfb( "<dev string:x50b>", skillasset, var_c1611a65af8736a3, itemspawnname, skilllevel, var_72b4fdb97118db5e, isreplaceable );
    }

    // Namespace ob_item_select
    // Params 5, eflags: 0x4
    // Checksum 0x7e42c573, Offset: 0x43bf
    // Size: 0xf4, Type: dev
    function private function_b61c3ef8d2e87a74( interactobject, var_7b955ef638656ecb, skilltier, var_821f24df33d3c2d2, var_f06bf262e0bdbfb1 )
    {
        self endon( #"disconnect" );
        chosenindex = function_8df94337cce4ddcf( interactobject, var_7b955ef638656ecb, skilltier, var_821f24df33d3c2d2, var_f06bf262e0bdbfb1 );
        
        if ( chosenindex < 0 )
        {
            iprintlnbold( "<dev string:x511>" );
            return;
        }
        
        if ( isdefined( self.swappingskill ) )
        {
            chosenname = function_8a9e3d131f74a874( var_7b955ef638656ecb, 0 );
            replacedname = function_8a9e3d131f74a874( var_7b955ef638656ecb, self.swappingskill + 1 );
            iprintlnbold( "<dev string:x52a>" + chosenname + "<dev string:x540>" + replacedname );
            self.swappingskill = undefined;
            return;
        }
        
        chosenname = function_8a9e3d131f74a874( var_7b955ef638656ecb, chosenindex );
        iprintlnbold( "<dev string:x52a>" + chosenname + "<dev string:x54d>" + chosenindex + "<dev string:x555>" );
    }

    // Namespace ob_item_select
    // Params 2, eflags: 0x4
    // Checksum 0x755c73dc, Offset: 0x44bb
    // Size: 0x67, Type: dev
    function private function_8a9e3d131f74a874( var_7b955ef638656ecb, tileindex )
    {
        if ( !isdefined( var_7b955ef638656ecb[ tileindex ] ) )
        {
            return ( "<dev string:x557>" + tileindex );
        }
        
        skillref = getscriptbundlefieldvalue( var_7b955ef638656ecb[ tileindex ].asset, #"skillref" );
        
        if ( isdefined( skillref ) )
        {
            return getxhashsourcename( skillref );
        }
        
        return "<dev string:x557>" + tileindex;
    }

    // Namespace ob_item_select
    // Params 0, eflags: 0x4
    // Checksum 0xe895dfb, Offset: 0x452a
    // Size: 0x92, Type: dev
    function private function_513a59988d5fbfef()
    {
        player = level.players[ 0 ];
        var_d7a8f33465bf1740 = function_34849e5d6b5b9ded( "<dev string:x55d>" );
        
        if ( var_d7a8f33465bf1740.size < 2 )
        {
            /#
                iprintlnbold( "<dev string:x56a>" );
            #/
            
            return;
        }
        
        var_7b955ef638656ecb = [];
        var_7b955ef638656ecb[ 0 ] = function_89d53b507d5e45a6( var_d7a8f33465bf1740[ 0 ], 0, 0 );
        var_7b955ef638656ecb[ 1 ] = function_89d53b507d5e45a6( var_d7a8f33465bf1740[ 1 ], var_d7a8f33465bf1740[ 1 ].var_f463fd4a9608ce51, 1, 0, 1 );
        player thread function_b61c3ef8d2e87a74( undefined, var_7b955ef638656ecb, 1 );
    }

    // Namespace ob_item_select
    // Params 0, eflags: 0x4
    // Checksum 0x9dc09ca6, Offset: 0x45c4
    // Size: 0x95, Type: dev
    function private function_5cf35aebe8c48e3c()
    {
        player = level.players[ 0 ];
        var_d7a8f33465bf1740 = function_34849e5d6b5b9ded( "<dev string:x55d>" );
        
        if ( var_d7a8f33465bf1740.size < 2 )
        {
            /#
                iprintlnbold( "<dev string:x59c>" );
            #/
            
            return;
        }
        
        var_7b955ef638656ecb = [];
        var_7b955ef638656ecb[ 0 ] = function_89d53b507d5e45a6( var_d7a8f33465bf1740[ 0 ], 0, 0 );
        var_7b955ef638656ecb[ 1 ] = function_89d53b507d5e45a6( var_d7a8f33465bf1740[ 1 ], var_d7a8f33465bf1740[ 1 ].var_f463fd4a9608ce51, 1, 0, 1 );
        player thread function_b61c3ef8d2e87a74( undefined, var_7b955ef638656ecb, 1, undefined, 1 );
    }

    // Namespace ob_item_select
    // Params 0, eflags: 0x4
    // Checksum 0x759a2521, Offset: 0x4661
    // Size: 0xb3, Type: dev
    function private function_75ef086b4052e39d()
    {
        player = level.players[ 0 ];
        var_d7a8f33465bf1740 = function_34849e5d6b5b9ded( "<dev string:x55d>" );
        
        if ( var_d7a8f33465bf1740.size < 2 )
        {
            /#
                iprintlnbold( "<dev string:x5d6>" );
            #/
            
            return;
        }
        
        upgradelevel = minint( 1, var_d7a8f33465bf1740[ 0 ].var_f463fd4a9608ce51 );
        var_7b955ef638656ecb = [];
        var_7b955ef638656ecb[ 0 ] = function_89d53b507d5e45a6( var_d7a8f33465bf1740[ 0 ], upgradelevel, 1, 1 );
        var_7b955ef638656ecb[ 1 ] = function_89d53b507d5e45a6( var_d7a8f33465bf1740[ 1 ], var_d7a8f33465bf1740[ 1 ].var_f463fd4a9608ce51, 1, 0, 1 );
        player thread function_b61c3ef8d2e87a74( undefined, var_7b955ef638656ecb, 1 );
    }

    // Namespace ob_item_select
    // Params 0, eflags: 0x4
    // Checksum 0x69fbcc4e, Offset: 0x471c
    // Size: 0x9f, Type: dev
    function private function_e3c4f9a6c31cbc7a()
    {
        player = level.players[ 0 ];
        var_d7a8f33465bf1740 = function_34849e5d6b5b9ded( "<dev string:x55d>" );
        
        if ( var_d7a8f33465bf1740.size < 2 )
        {
            /#
                iprintlnbold( "<dev string:x60c>" );
            #/
            
            return;
        }
        
        var_7b955ef638656ecb = [];
        var_7b955ef638656ecb[ 0 ] = function_89d53b507d5e45a6( var_d7a8f33465bf1740[ 0 ], var_d7a8f33465bf1740[ 0 ].var_f463fd4a9608ce51, 1 );
        var_7b955ef638656ecb[ 1 ] = function_89d53b507d5e45a6( var_d7a8f33465bf1740[ 1 ], var_d7a8f33465bf1740[ 1 ].var_f463fd4a9608ce51, 1, 0, 1 );
        player thread function_b61c3ef8d2e87a74( undefined, var_7b955ef638656ecb, 1 );
    }

    // Namespace ob_item_select
    // Params 0, eflags: 0x4
    // Checksum 0x920549d4, Offset: 0x47c3
    // Size: 0xba, Type: dev
    function private function_e91d0a23070b5174()
    {
        player = level.players[ 0 ];
        var_d7a8f33465bf1740 = function_34849e5d6b5b9ded( "<dev string:x55d>" );
        
        if ( var_d7a8f33465bf1740.size < 3 )
        {
            /#
                iprintlnbold( "<dev string:x643>" );
            #/
            
            return;
        }
        
        var_7b955ef638656ecb = [];
        var_7b955ef638656ecb[ 0 ] = function_89d53b507d5e45a6( var_d7a8f33465bf1740[ 0 ], 0, 0 );
        var_7b955ef638656ecb[ 1 ] = function_89d53b507d5e45a6( var_d7a8f33465bf1740[ 1 ], var_d7a8f33465bf1740[ 1 ].var_f463fd4a9608ce51 - 1, 1, 0, 1 );
        var_7b955ef638656ecb[ 2 ] = function_89d53b507d5e45a6( var_d7a8f33465bf1740[ 2 ], var_d7a8f33465bf1740[ 2 ].var_f463fd4a9608ce51, 1, 0, 1 );
        player thread function_b61c3ef8d2e87a74( undefined, var_7b955ef638656ecb, 1, undefined, 1 );
    }

    // Namespace ob_item_select
    // Params 0, eflags: 0x4
    // Checksum 0x712bc04, Offset: 0x4885
    // Size: 0x92, Type: dev
    function private function_14b594bde709a844()
    {
        player = level.players[ 0 ];
        var_d7a8f33465bf1740 = function_34849e5d6b5b9ded( "<dev string:x4fb>" );
        
        if ( var_d7a8f33465bf1740.size < 2 )
        {
            /#
                iprintlnbold( "<dev string:x679>" );
            #/
            
            return;
        }
        
        var_7b955ef638656ecb = [];
        var_7b955ef638656ecb[ 0 ] = function_89d53b507d5e45a6( var_d7a8f33465bf1740[ 0 ], 0, 0 );
        var_7b955ef638656ecb[ 1 ] = function_89d53b507d5e45a6( var_d7a8f33465bf1740[ 1 ], var_d7a8f33465bf1740[ 1 ].var_f463fd4a9608ce51, 1, 0, 1 );
        player thread function_b61c3ef8d2e87a74( undefined, var_7b955ef638656ecb, 2 );
    }

    // Namespace ob_item_select
    // Params 0, eflags: 0x4
    // Checksum 0xea62b4f2, Offset: 0x491f
    // Size: 0x95, Type: dev
    function private function_44818d3629e55337()
    {
        player = level.players[ 0 ];
        var_d7a8f33465bf1740 = function_34849e5d6b5b9ded( "<dev string:x4fb>" );
        
        if ( var_d7a8f33465bf1740.size < 2 )
        {
            /#
                iprintlnbold( "<dev string:x6b1>" );
            #/
            
            return;
        }
        
        var_7b955ef638656ecb = [];
        var_7b955ef638656ecb[ 0 ] = function_89d53b507d5e45a6( var_d7a8f33465bf1740[ 0 ], 0, 0 );
        var_7b955ef638656ecb[ 1 ] = function_89d53b507d5e45a6( var_d7a8f33465bf1740[ 1 ], var_d7a8f33465bf1740[ 1 ].var_f463fd4a9608ce51, 1, 0, 1 );
        player thread function_b61c3ef8d2e87a74( undefined, var_7b955ef638656ecb, 2, undefined, 1 );
    }

    // Namespace ob_item_select
    // Params 0, eflags: 0x4
    // Checksum 0xe3e860b8, Offset: 0x49bc
    // Size: 0xba, Type: dev
    function private function_7b02cbfef8a197c1()
    {
        player = level.players[ 0 ];
        var_d7a8f33465bf1740 = function_34849e5d6b5b9ded( "<dev string:x4fb>" );
        
        if ( var_d7a8f33465bf1740.size < 3 )
        {
            /#
                iprintlnbold( "<dev string:x6f1>" );
            #/
            
            return;
        }
        
        var_7b955ef638656ecb = [];
        var_7b955ef638656ecb[ 0 ] = function_89d53b507d5e45a6( var_d7a8f33465bf1740[ 0 ], 0, 0 );
        var_7b955ef638656ecb[ 1 ] = function_89d53b507d5e45a6( var_d7a8f33465bf1740[ 1 ], var_d7a8f33465bf1740[ 1 ].var_f463fd4a9608ce51 - 1, 1, 0, 1 );
        var_7b955ef638656ecb[ 2 ] = function_89d53b507d5e45a6( var_d7a8f33465bf1740[ 2 ], var_d7a8f33465bf1740[ 2 ].var_f463fd4a9608ce51, 1, 0, 1 );
        player thread function_b61c3ef8d2e87a74( undefined, var_7b955ef638656ecb, 2, undefined, 1 );
    }

    // Namespace ob_item_select
    // Params 0, eflags: 0x4
    // Checksum 0xfa63ddcd, Offset: 0x4a7e
    // Size: 0xb2, Type: dev
    function private function_be75b3f7a504ae2()
    {
        player = level.players[ 0 ];
        var_d7a8f33465bf1740 = function_34849e5d6b5b9ded( "<dev string:x4fb>" );
        
        if ( var_d7a8f33465bf1740.size < 2 )
        {
            /#
                iprintlnbold( "<dev string:x72d>" );
            #/
            
            return;
        }
        
        upgradelevel = minint( 1, var_d7a8f33465bf1740[ 0 ].var_f463fd4a9608ce51 );
        var_7b955ef638656ecb = [];
        var_7b955ef638656ecb[ 0 ] = function_89d53b507d5e45a6( var_d7a8f33465bf1740[ 0 ], upgradelevel, 1 );
        var_7b955ef638656ecb[ 1 ] = function_89d53b507d5e45a6( var_d7a8f33465bf1740[ 1 ], var_d7a8f33465bf1740[ 1 ].var_f463fd4a9608ce51, 1, 1, 1 );
        player thread function_b61c3ef8d2e87a74( undefined, var_7b955ef638656ecb, 2 );
    }

    // Namespace ob_item_select
    // Params 0, eflags: 0x4
    // Checksum 0xaa78bb14, Offset: 0x4b38
    // Size: 0x9f, Type: dev
    function private function_87cb1eac16c03dbf()
    {
        player = level.players[ 0 ];
        var_d7a8f33465bf1740 = function_34849e5d6b5b9ded( "<dev string:x4fb>" );
        
        if ( var_d7a8f33465bf1740.size < 2 )
        {
            /#
                iprintlnbold( "<dev string:x769>" );
            #/
            
            return;
        }
        
        var_7b955ef638656ecb = [];
        var_7b955ef638656ecb[ 0 ] = function_89d53b507d5e45a6( var_d7a8f33465bf1740[ 0 ], var_d7a8f33465bf1740[ 0 ].var_f463fd4a9608ce51, 1 );
        var_7b955ef638656ecb[ 1 ] = function_89d53b507d5e45a6( var_d7a8f33465bf1740[ 1 ], var_d7a8f33465bf1740[ 1 ].var_f463fd4a9608ce51, 1, 0, 1 );
        player thread function_b61c3ef8d2e87a74( undefined, var_7b955ef638656ecb, 2 );
    }

    // Namespace ob_item_select
    // Params 0, eflags: 0x4
    // Checksum 0x84223e03, Offset: 0x4bdf
    // Size: 0xa5, Type: dev
    function private function_f93ed8f9d6a1f17c()
    {
        player = level.players[ 0 ];
        var_d7a8f33465bf1740 = function_34849e5d6b5b9ded( "<dev string:x55d>" );
        
        if ( var_d7a8f33465bf1740.size < 2 )
        {
            /#
                iprintlnbold( "<dev string:x7a6>" );
            #/
            
            return;
        }
        
        upgradelevel = minint( 1, var_d7a8f33465bf1740[ 1 ].var_f463fd4a9608ce51 );
        var_7b955ef638656ecb = [];
        var_7b955ef638656ecb[ 0 ] = function_89d53b507d5e45a6( var_d7a8f33465bf1740[ 0 ], 0, 0 );
        var_7b955ef638656ecb[ 1 ] = function_89d53b507d5e45a6( var_d7a8f33465bf1740[ 1 ], upgradelevel, 1, 1, 1 );
        player thread function_b61c3ef8d2e87a74( undefined, var_7b955ef638656ecb, 1 );
    }

    // Namespace ob_item_select
    // Params 0, eflags: 0x4
    // Checksum 0xd2c4cdd1, Offset: 0x4c8c
    // Size: 0xa5, Type: dev
    function private function_f1af320df03f2713()
    {
        player = level.players[ 0 ];
        var_d7a8f33465bf1740 = function_34849e5d6b5b9ded( "<dev string:x4fb>" );
        
        if ( var_d7a8f33465bf1740.size < 2 )
        {
            /#
                iprintlnbold( "<dev string:x7e6>" );
            #/
            
            return;
        }
        
        upgradelevel = minint( 1, var_d7a8f33465bf1740[ 1 ].var_f463fd4a9608ce51 );
        var_7b955ef638656ecb = [];
        var_7b955ef638656ecb[ 0 ] = function_89d53b507d5e45a6( var_d7a8f33465bf1740[ 0 ], 0, 0 );
        var_7b955ef638656ecb[ 1 ] = function_89d53b507d5e45a6( var_d7a8f33465bf1740[ 1 ], upgradelevel, 1, 1, 1 );
        player thread function_b61c3ef8d2e87a74( undefined, var_7b955ef638656ecb, 2 );
    }

    // Namespace ob_item_select
    // Params 2, eflags: 0x4
    // Checksum 0x8e43a61e, Offset: 0x4d39
    // Size: 0x56, Type: dev
    function private function_eca53a74142bc77e( superref, var_c1611a65af8736a3 )
    {
        fullbundlename = level.var_b72c376264827891[ superref ];
        superasset = function_b528615c0dce3d05( fullbundlename ?? superref );
        return function_107a19ba8e9d4bfb( "<dev string:x82c>", superasset, var_c1611a65af8736a3 );
    }

    // Namespace ob_item_select
    // Params 0, eflags: 0x4
    // Checksum 0x90899d3f, Offset: 0x4d97
    // Size: 0x82, Type: dev
    function private function_e9bc1b34149fcda4()
    {
        player = level.players[ 0 ];
        var_d7a8f33465bf1740 = function_34849e5d6b5b9ded( "<dev string:x55d>" );
        
        if ( var_d7a8f33465bf1740.size < 1 )
        {
            /#
                iprintlnbold( "<dev string:x832>" );
            #/
            
            return;
        }
        
        var_7b955ef638656ecb = [];
        var_7b955ef638656ecb[ 0 ] = function_89d53b507d5e45a6( var_d7a8f33465bf1740[ 0 ], 0, 0 );
        var_7b955ef638656ecb[ 1 ] = function_eca53a74142bc77e( "<dev string:x877>", 1 );
        player thread function_b61c3ef8d2e87a74( undefined, var_7b955ef638656ecb, 1 );
    }

    // Namespace ob_item_select
    // Params 0, eflags: 0x4
    // Checksum 0x42aedcd3, Offset: 0x4e21
    // Size: 0x8e, Type: dev
    function private function_786fe04d2043ddfc()
    {
        player = level.players[ 0 ];
        var_d7a8f33465bf1740 = function_34849e5d6b5b9ded( "<dev string:x55d>" );
        
        if ( var_d7a8f33465bf1740.size < 1 )
        {
            /#
                iprintlnbold( "<dev string:x886>" );
            #/
            
            return;
        }
        
        var_7b955ef638656ecb = [];
        var_7b955ef638656ecb[ 0 ] = function_eca53a74142bc77e( "<dev string:x877>", 0 );
        var_7b955ef638656ecb[ 1 ] = function_89d53b507d5e45a6( var_d7a8f33465bf1740[ 0 ], var_d7a8f33465bf1740[ 0 ].var_f463fd4a9608ce51, 1 );
        player thread function_b61c3ef8d2e87a74( undefined, var_7b955ef638656ecb, 1 );
    }

    // Namespace ob_item_select
    // Params 0, eflags: 0x4
    // Checksum 0x54ea1902, Offset: 0x4eb7
    // Size: 0x97, Type: dev
    function private function_fe8298529cf5670a()
    {
        player = level.players[ 0 ];
        var_d7a8f33465bf1740 = function_34849e5d6b5b9ded( "<dev string:x55d>" );
        
        if ( var_d7a8f33465bf1740.size < 1 )
        {
            /#
                iprintlnbold( "<dev string:x8cb>" );
            #/
            
            return;
        }
        
        var_7b955ef638656ecb = [];
        var_7b955ef638656ecb[ 0 ] = function_89d53b507d5e45a6( var_d7a8f33465bf1740[ 0 ], 0, 0 );
        var_7b955ef638656ecb[ 1 ] = function_eca53a74142bc77e( "<dev string:x877>", 1 );
        var_7b955ef638656ecb[ 2 ] = function_eca53a74142bc77e( "<dev string:x909>", 1 );
        player thread function_b61c3ef8d2e87a74( undefined, var_7b955ef638656ecb, 1, undefined, 1 );
    }

#/

// Namespace ob_item_select
// Params 7
// Checksum 0x3afa6e5a, Offset: 0x4f56
// Size: 0x17e
function function_95f9ecc2af4693f6( origin, var_368ec277cd35ed4, var_368ef277cd3656d, slot, angles, parent, oneuse )
{
    abilitycase = spawnscriptable( "ob_loot_ability_case", origin, angles, parent );
    
    if ( var_368ef277cd3656d && superisrestricted( var_368ef277cd3656d ) )
    {
        var_368ef277cd3656d = undefined;
    }
    
    if ( superisrestricted( var_368ec277cd35ed4 ) )
    {
        var_368ec277cd35ed4 = var_368ef277cd3656d;
        var_368ef277cd3656d = undefined;
    }
    
    if ( !var_368ec277cd35ed4 || superisrestricted( var_368ec277cd35ed4 ) )
    {
        if ( slot == #"tactical" )
        {
            if ( !superisrestricted( "super_mega_jump" ) )
            {
                var_368ec277cd35ed4 = "super_mega_jump";
            }
        }
        else if ( !superisrestricted( "super_war_machine" ) )
        {
            var_368ec277cd35ed4 = "super_war_machine";
        }
    }
    
    abilitycase.slot = slot;
    
    if ( slot == #"tactical" )
    {
        abilitycase.var_368ec277cd35ed4 = "equip_" + var_368ec277cd35ed4;
        
        if ( var_368ef277cd3656d )
        {
            abilitycase.var_368ef277cd3656d = "equip_" + var_368ef277cd3656d;
        }
    }
    else
    {
        abilitycase.var_368ec277cd35ed4 = var_368ec277cd35ed4 + "_ob";
        
        if ( var_368ef277cd3656d )
        {
            abilitycase.var_368ef277cd3656d = var_368ef277cd3656d + "_ob";
        }
    }
    
    interaction::register_scriptable_interact( abilitycase, &function_1d447d8051385a36 );
    
    if ( !isdefined( level.ob_item_select_scriptables ) )
    {
        level.ob_item_select_scriptables = [];
    }
    
    level.ob_item_select_scriptables[ level.ob_item_select_scriptables.size ] = abilitycase;
    return abilitycase;
}

// Namespace ob_item_select
// Params 4, eflags: 0x4
// Checksum 0xcbc1700e, Offset: 0x50dd
// Size: 0x13e
function private function_f2da572aea2b5190( instance, note, param, var_64ffacba090c91be )
{
    if ( instance.enabledplayers )
    {
        instance function_7653c765b6c7b815();
        
        foreach ( player in instance.enabledplayers )
        {
            instance enablescriptableplayeruse( player );
        }
    }
    else
    {
        instance function_e203bba36cfb19d0();
    }
    
    if ( instance.disabledplayers )
    {
        foreach ( player in instance.disabledplayers )
        {
            instance disablescriptableplayeruse( player );
        }
    }
}

// Namespace ob_item_select
// Params 1
// Checksum 0x7df16cb6, Offset: 0x5223
// Size: 0x20
function function_1dfd8b3bc8e33dd8( abilitycase )
{
    abilitycase.enabledplayers = [];
    abilitycase function_7653c765b6c7b815();
}

// Namespace ob_item_select
// Params 2
// Checksum 0xf42a61f6, Offset: 0x524b
// Size: 0xc2
function function_923ddf97f6cdbee( abilitycase, players )
{
    if ( abilitycase.enabledplayers )
    {
        abilitycase.enabledplayers = arraycombineunique( abilitycase.enabledplayers, players );
    }
    else
    {
        abilitycase.enabledplayers = players;
    }
    
    foreach ( player in players )
    {
        abilitycase enablescriptableplayeruse( player );
    }
}

// Namespace ob_item_select
// Params 2
// Checksum 0x68cd79ae, Offset: 0x5315
// Size: 0xcf
function function_a499824164a33b4f( abilitycase, players )
{
    if ( abilitycase.enabledplayers )
    {
        abilitycase.enabledplayers = arrayremove( abilitycase.enabledplayers, players );
    }
    else
    {
        abilitycase.enabledplayers = arrayremove( level.players, players );
    }
    
    foreach ( player in players )
    {
        abilitycase disablescriptableplayeruse( player );
    }
}

// Namespace ob_item_select
// Params 1
// Checksum 0xbc2c6a94, Offset: 0x53ec
// Size: 0xd10
function function_1d447d8051385a36( player )
{
    player endon( #"disconnect" );
    abilitycase = self;
    
    if ( player ob_reward_select::ob_reward_select_is_active() )
    {
        return;
    }
    
    xuid = player getxuid();
    
    if ( !isdefined( abilitycase.playeroptions ) )
    {
        abilitycase.playeroptions = [];
    }
    
    if ( !abilitycase.playeroptions[ xuid ] )
    {
        if ( abilitycase.dynamicoptions )
        {
            if ( abilitycase.slot == #"default" )
            {
                oldref = player supers_mp::getcurrentsuperref( #"default" );
                
                if ( oldref )
                {
                    oldref += "_ob";
                }
                
                refs = arrayremove( level.var_807e51ff19b94a94, oldref );
                refs = arrayrandomize( refs );
                abilitycase.playeroptions[ xuid ] = [];
                
                if ( refs[ 0 ] )
                {
                    abilitycase.playeroptions[ xuid ][ abilitycase.playeroptions[ xuid ].size ] = { #ref:refs[ 0 ] };
                }
                
                if ( refs[ 1 ] )
                {
                    abilitycase.playeroptions[ xuid ][ abilitycase.playeroptions[ xuid ].size ] = { #ref:refs[ 1 ] };
                }
            }
            else
            {
                oldref = player equipment_mp::getcurrentequipment( "secondary" );
                refs = arrayremove( level.var_1aca1c6e33605918, oldref );
                refs = arrayrandomize( refs );
                abilitycase.playeroptions[ xuid ] = [];
                
                if ( refs[ 0 ] )
                {
                    abilitycase.playeroptions[ xuid ][ abilitycase.playeroptions[ xuid ].size ] = { #ref:refs[ 0 ] };
                }
                
                if ( refs[ 1 ] )
                {
                    abilitycase.playeroptions[ xuid ][ abilitycase.playeroptions[ xuid ].size ] = { #ref:refs[ 1 ] };
                }
            }
            
            if ( level.var_2a010f82d868b9cc )
            {
                logstring( "[OB_ABILITY_CASE] Presenting to player " + ( player.name ?? "" ) + " the dynamic options " + ( abilitycase.playeroptions[ xuid ][ 0 ].ref ?? "" ) + " and " + ( abilitycase.playeroptions[ xuid ][ 1 ].ref ?? "" ) );
            }
        }
        else
        {
            abilitycase.playeroptions[ xuid ] = [];
            
            if ( abilitycase.var_368ec277cd35ed4 )
            {
                abilitycase.playeroptions[ xuid ][ abilitycase.playeroptions[ xuid ].size ] = { #ref:abilitycase.var_368ec277cd35ed4 };
            }
            
            if ( abilitycase.var_368ef277cd3656d )
            {
                abilitycase.playeroptions[ xuid ][ abilitycase.playeroptions[ xuid ].size ] = { #ref:abilitycase.var_368ef277cd3656d };
            }
        }
    }
    
    options = abilitycase.playeroptions[ xuid ];
    
    if ( !isdefined( abilitycase.disabledplayers ) )
    {
        abilitycase.disabledplayers = [];
    }
    
    abilitycase.usercount = isdefined( abilitycase.usercount ) ? abilitycase.usercount + 1 : 1;
    
    if ( #"closed" == abilitycase getscriptablepartstate( #"body", 0, 1 ) )
    {
        abilitycase setscriptablepartstate( #"body", #"opening" );
    }
    
    abilitycase disablescriptableplayeruse( player );
    abilitycase.disabledplayers = arraycombineunique( abilitycase.disabledplayers, [ player ] );
    player notify( #"player_used_ability_case" );
    
    if ( abilitycase.slot == #"default" )
    {
        oldref = player supers_mp::getcurrentsuperref( #"default" );
    }
    else
    {
        oldref = player equipment_mp::getcurrentequipment( "secondary" );
    }
    
    if ( oldref )
    {
        if ( options[ 0 ].ref )
        {
            player setclientomnvar( "ui_ob_selectable_reward_is_equipped_1", oldref == function_1b44a8bef83e8e02( options[ 0 ].ref, "_ob" ) );
        }
        
        if ( options[ 1 ].ref )
        {
            player setclientomnvar( "ui_ob_selectable_reward_is_equipped_2", oldref == function_1b44a8bef83e8e02( options[ 1 ].ref, "_ob" ) );
        }
    }
    
    chosenindex = 0;
    var_f1bad5a7b77025b = level.var_bb86f77304f193c4.var_aab22481530ff9ff || level.var_bb86f77304f193c4.var_49178f6e5c220274;
    
    if ( !var_f1bad5a7b77025b && getdvarint( @"hash_13b13d8336999e21", 0 ) && !( options[ 0 ].upgraderef || options[ 1 ].upgraderef ) )
    {
        var_33ef3142f976739 = [];
        
        for ( optionindex = 0; optionindex < options.size ; optionindex++ )
        {
            if ( !isdefined( options[ optionindex ] ) || !isdefined( options[ optionindex ].ref ) )
            {
                continue;
            }
            
            optionref = abilitycase.playeroptions[ xuid ][ optionindex ].ref;
            var_c1611a65af8736a3 = oldref == function_1b44a8bef83e8e02( optionref, "_ob" );
            superasset = abilitycase.slot == #"default" ? function_cc80d42be9f0ca44( optionref ) : function_55c10c1014749803( optionref );
            var_33ef3142f976739[ optionindex ] = function_107a19ba8e9d4bfb( "super", superasset, var_c1611a65af8736a3 );
        }
        
        chosenindex = player function_3fe3b855505e2c8b( abilitycase, var_33ef3142f976739, abilitycase.slot == #"default" ? &"hash_2a36b9f8aa207a55" : &"hash_6b24c2d814b9d191" );
    }
    else
    {
        itemoverride = [];
        
        for ( optionindex = 0; optionindex < options.size ; optionindex++ )
        {
            if ( "equip_super_portal_summon" == options[ optionindex ].ref )
            {
                options[ optionindex ].ref = "equip_portal_summon_sat";
            }
            
            if ( options[ optionindex ].upgraderef )
            {
                itemoverride[ optionindex ] = level.skillbundles[ options[ optionindex ].upgraderef ][ options[ optionindex ].upgradelevel ].itemspawnentry;
            }
        }
        
        var_3325d0eb2231cf18 = itemoverride[ 0 ] ?? common_item_database::function_a4f0a21951180013( options[ 0 ].ref );
        var_3325d3eb2231d5b1 = itemoverride[ 1 ] ?? common_item_database::function_a4f0a21951180013( options[ 1 ].ref );
        chosenindex = player function_55bae6c0c5e50953( abilitycase, var_3325d0eb2231cf18, var_3325d3eb2231d5b1 );
    }
    
    if ( !player )
    {
        return;
    }
    
    player setclientomnvar( "ui_ob_selectable_reward_is_equipped_1", 0 );
    player setclientomnvar( "ui_ob_selectable_reward_is_equipped_2", 0 );
    
    if ( !abilitycase )
    {
        return;
    }
    
    abilitycase.usercount--;
    
    if ( abilitycase.usercount <= 0 )
    {
        state = abilitycase getscriptablepartstate( #"body", 0, 1 );
        
        if ( #"open" == state || #"opening" == state )
        {
            abilitycase setscriptablepartstate( #"body", #"closing" );
        }
    }
    
    abilitycase enablescriptableplayeruse( player );
    abilitycase.disabledplayers = arrayremove( abilitycase.disabledplayers, player );
    var_1b0b8d181bc616d4 = options[ chosenindex ].ref;
    
    if ( !var_1b0b8d181bc616d4 )
    {
        return;
    }
    
    var_1b0b8d181bc616d4 = function_1b44a8bef83e8e02( var_1b0b8d181bc616d4, "_ob" );
    
    if ( "equip_portal_summon_sat" == var_1b0b8d181bc616d4 )
    {
        var_1b0b8d181bc616d4 = "equip_super_portal_summon";
    }
    
    player canceloffhands();
    player releaseoffhand();
    
    if ( player supers_mp::issuperinuse( abilitycase.slot ) )
    {
        player supers_mp::superusefinished( undefined, undefined, undefined, undefined, undefined, undefined, abilitycase.slot );
        
        foreach ( bubbleshield in player.bubbleshields )
        {
            bubbleshield notify( #"bubble_shield_end" );
        }
    }
    
    player callback::callback( #"super_cancel" );
    
    if ( !isdefined( abilitycase.playerused ) )
    {
        abilitycase.playerused = [];
    }
    
    if ( abilitycase.slot == #"default" )
    {
        if ( oldref == var_1b0b8d181bc616d4 )
        {
            return;
        }
        
        var_867eee8bd7786b07 = player.var_171e758625364ee0[ "major_ability_upgrade" ];
        
        if ( var_867eee8bd7786b07 )
        {
            var_2b9a37f3c82f5a34 = player.var_bcde97a1f15e0648[ var_867eee8bd7786b07 ];
        }
        
        currentsuper = player supers_mp::getcurrentsuper();
        var_68a2d5f3aa12e75b = !abilitycase.playerused[ xuid ] || !currentsuper;
        
        if ( !var_68a2d5f3aa12e75b && currentsuper )
        {
            currentpoints = player supers_mp::getcurrentsuperpoints();
            neededpoints = player supers_mp::getsuperpointsneeded();
            percentageneeded = currentpoints / neededpoints;
        }
        
        player perkpackage::perkpackage_giveimmediate( var_1b0b8d181bc616d4, undefined, undefined, undefined, var_68a2d5f3aa12e75b );
        newsuper = player supers_mp::getcurrentsuper();
        
        if ( !var_68a2d5f3aa12e75b && newsuper )
        {
            var_3e5eeec3ff89c03a = player supers_mp::getsuperpointsneeded();
            var_d50c741943dc2762 = var_3e5eeec3ff89c03a * percentageneeded;
            player supers_mp::setsuperbasepoints( var_d50c741943dc2762 );
        }
        
        abilitycase.playerused[ xuid ] = 1;
    }
    else
    {
        if ( oldref )
        {
            if ( oldref == var_1b0b8d181bc616d4 )
            {
                return;
            }
        }
        
        var_867eee8bd7786b07 = player.var_171e758625364ee0[ "minor_ability_upgrade" ];
        
        if ( var_867eee8bd7786b07 )
        {
            var_2b9a37f3c82f5a34 = player.var_bcde97a1f15e0648[ var_867eee8bd7786b07 ];
        }
        
        currentsuper = player supers_mp::getcurrentsuper( #"tactical" );
        var_68a2d5f3aa12e75b = !abilitycase.playerused[ xuid ] || !currentsuper;
        oldammo = 0;
        
        if ( !var_68a2d5f3aa12e75b && currentsuper )
        {
            currentpoints = player supers_mp::getcurrentsuperpoints( #"tactical" );
            neededpoints = player supers_mp::getsuperpointsneeded( undefined, #"tactical" );
            percentageneeded = currentpoints / neededpoints;
            
            if ( oldref )
            {
                oldammo = player equipment_mp::getequipmentammo( oldref );
            }
        }
        
        player equipment_mp::giveequipment( var_1b0b8d181bc616d4, "secondary" );
        newsuper = player supers_mp::getcurrentsuper( #"tactical" );
        
        if ( !var_68a2d5f3aa12e75b && newsuper )
        {
            newref = player equipment_mp::getcurrentequipment( "secondary" );
            player equipment_mp::setequipmentammo( newref, oldammo );
            var_3e5eeec3ff89c03a = player supers_mp::getsuperpointsneeded( undefined, #"tactical" );
            var_d50c741943dc2762 = var_3e5eeec3ff89c03a * percentageneeded;
            player supers_mp::setsuperbasepoints( var_d50c741943dc2762, undefined, #"tactical" );
        }
        else
        {
            maxammo = equipment_mp::getequipmentmaxammo( var_1b0b8d181bc616d4 );
            player equipment_mp::setequipmentammo( var_1b0b8d181bc616d4, maxammo );
            neededpoints = player supers_mp::getsuperpointsneeded( undefined, #"tactical" );
            player supers_mp::setsuperbasepoints( neededpoints, undefined, #"tactical" );
        }
        
        abilitycase.playerused[ xuid ] = 1;
    }
    
    var_f29d3d8b640fb3bc = options[ chosenindex ].upgraderef;
    
    if ( var_f29d3d8b640fb3bc )
    {
        var_f38d59636847dd3 = options[ chosenindex ].upgradelevel;
        player utility::callsharedfunc( #"skills", #"giveskill", var_f29d3d8b640fb3bc, var_f38d59636847dd3, 1 );
        options[ chosenindex ].upgraderef = undefined;
        options[ chosenindex ].upgradelevel = undefined;
    }
    
    player playsoundtoplayer( "dx_wc_wcmr_upge_tacb_wcmissionremindupgener_08", player );
    utility::callsharedfunc( #"ob_gametype_story_mission", #"hash_b065bf3f05c1b1e2", player );
    abilitycase notify( #"player_used_ability_case", player, var_1b0b8d181bc616d4 );
    player notify( #"player_used_ability_case", var_1b0b8d181bc616d4 );
    
    if ( oldref )
    {
        if ( abilitycase.slot == #"default" )
        {
            options[ chosenindex ].ref = oldref + "_ob";
        }
        else
        {
            options[ chosenindex ].ref = oldref;
        }
        
        if ( var_867eee8bd7786b07 )
        {
            options[ chosenindex ].upgraderef = var_867eee8bd7786b07;
            options[ chosenindex ].upgradelevel = var_2b9a37f3c82f5a34;
            player utility::callsharedfunc( #"skills", #"removeskill", var_867eee8bd7786b07 );
        }
    }
    else
    {
        options[ chosenindex ] = undefined;
        function_cdc669dbc8ea2101( options );
    }
    
    if ( options.size == 0 )
    {
        abilitycase disablescriptableplayeruse( player );
        abilitycase.disabledplayers = arraycombineunique( abilitycase.disabledplayers, [ player ] );
    }
}

// Namespace ob_item_select
// Params 1, eflags: 0x4
// Checksum 0x8f7b737e, Offset: 0x6104
// Size: 0x2ab
function private function_37c677a0688cb904( params )
{
    player = params.player;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    skillbundle = level.skillbundles[ params.skillref ][ params.skilllevel ];
    
    if ( !skillbundle )
    {
        return;
    }
    
    if ( !isdefined( player.var_171e758625364ee0 ) )
    {
        player.var_171e758625364ee0 = [];
    }
    
    if ( skillbundle.skillcategory == #"end_game" )
    {
        if ( !isdefined( player.var_171e758625364ee0[ "exotic_skill" ] ) )
        {
            player.var_171e758625364ee0[ "exotic_skill" ] = [];
        }
        
        if ( player.var_171e758625364ee0[ "exotic_skill" ][ 0 ] && player.operatorprestige > 0 )
        {
            player.var_171e758625364ee0[ "exotic_skill" ][ 1 ] = params.skillref;
        }
        else
        {
            player.var_171e758625364ee0[ "exotic_skill" ][ 0 ] = params.skillref;
        }
        
        return;
    }
    
    if ( skillbundle.skillcategory == #"nightmare" )
    {
        if ( !isdefined( player.var_171e758625364ee0[ "nightmare_skill" ] ) )
        {
            player.var_171e758625364ee0[ "nightmare_skill" ] = [];
        }
        
        if ( player.var_171e758625364ee0[ "nightmare_skill" ][ 0 ] && player.operatorprestige > 1 )
        {
            player.var_171e758625364ee0[ "nightmare_skill" ][ 1 ] = params.skillref;
        }
        else
        {
            player.var_171e758625364ee0[ "nightmare_skill" ][ 0 ] = params.skillref;
        }
        
        return;
    }
    
    if ( skillbundle.skillcategory == #"ability" )
    {
        if ( skillbundle.abilityref == getxhash( player supers_mp::getcurrentsuperref( #"default" ) ) )
        {
            player.var_171e758625364ee0[ "major_ability_upgrade" ] = params.skillref;
            player setclientomnvar( o"hash_b150dd79f9f43b29", skillbundle.index + 1 );
            return;
        }
        
        if ( skillbundle.abilityref == getxhash( player supers_mp::getcurrentsuperref( #"tactical" ) ) )
        {
            player.var_171e758625364ee0[ "minor_ability_upgrade" ] = params.skillref;
            player setclientomnvar( o"hash_b150de79f9f43dea", skillbundle.index + 1 );
        }
    }
}

// Namespace ob_item_select
// Params 1, eflags: 0x4
// Checksum 0x9862d759, Offset: 0x63b7
// Size: 0x1d5
function private function_551d94000edad68( params )
{
    player = params.player;
    
    if ( !isplayer( player ) || !player.var_171e758625364ee0.size )
    {
        return;
    }
    
    skillbundle = level.skillbundles[ params.skillref ][ params.skilllevel ];
    
    if ( !skillbundle )
    {
        return;
    }
    
    if ( player.var_171e758625364ee0[ "exotic_skill" ] )
    {
        var_5408ea8c31282957 = function_f02c63b99c9614c9( player.var_171e758625364ee0[ "exotic_skill" ], params.skillref );
        
        if ( isdefined( var_5408ea8c31282957 ) )
        {
            player.var_171e758625364ee0[ "exotic_skill" ][ var_5408ea8c31282957 ] = undefined;
            function_cdc669dbc8ea2101( player.var_171e758625364ee0[ "exotic_skill" ] );
            return;
        }
    }
    
    if ( player.var_171e758625364ee0[ "nightmare_skill" ] )
    {
        var_7f11577437125c6c = function_f02c63b99c9614c9( player.var_171e758625364ee0[ "nightmare_skill" ], params.skillref );
        
        if ( isdefined( var_7f11577437125c6c ) )
        {
            player.var_171e758625364ee0[ "nightmare_skill" ][ var_7f11577437125c6c ] = undefined;
            function_cdc669dbc8ea2101( player.var_171e758625364ee0[ "nightmare_skill" ] );
            return;
        }
    }
    
    if ( params.skillref == player.var_171e758625364ee0[ "major_ability_upgrade" ] )
    {
        player.var_171e758625364ee0[ "major_ability_upgrade" ] = undefined;
        player setclientomnvar( o"hash_b150dd79f9f43b29", 0 );
        return;
    }
    
    if ( params.skillref == player.var_171e758625364ee0[ "minor_ability_upgrade" ] )
    {
        player.var_171e758625364ee0[ "minor_ability_upgrade" ] = undefined;
        player setclientomnvar( o"hash_b150de79f9f43dea", 0 );
        return;
    }
}

// Namespace ob_item_select
// Params 1
// Checksum 0xa30669ec, Offset: 0x6594
// Size: 0x16c
function onplayerdisconnect( params )
{
    xuid = self getxuid();
    remaining_scriptables = [];
    
    foreach ( scriptable in level.ob_item_select_scriptables )
    {
        if ( !isdefined( scriptable ) )
        {
            continue;
        }
        
        if ( scriptable.playeroptions && !scriptable.isexotic )
        {
            scriptable.playeroptions[ xuid ] = undefined;
        }
        
        if ( scriptable.playerused )
        {
            scriptable.playerused[ xuid ] = undefined;
        }
        
        if ( scriptable.disabledplayers )
        {
            scriptable.disabledplayers = arrayremove( scriptable.disabledplayers, self );
        }
        
        if ( scriptable.enabledplayers )
        {
            scriptable.enabledplayers = arrayremove( scriptable.enabledplayers, self );
        }
        
        remaining_scriptables[ remaining_scriptables.size ] = scriptable;
        scriptable enablescriptableplayeruse( self );
    }
    
    level.ob_item_select_scriptables = remaining_scriptables;
    
    if ( level.var_cead0170a5b9b5eb )
    {
        function_8402869102e3b2ec( self, xuid );
    }
}

// Namespace ob_item_select
// Params 1, eflags: 0x4
// Checksum 0xb5e9d2a9, Offset: 0x6708
// Size: 0x232
function private function_f67f67b65329c95( params )
{
    self endon( #"disconnect" );
    xuid = self getxuid();
    
    while ( self )
    {
        throttle::throttle_wait_in_queue( level.var_f64b612f3abaef17, self );
        
        if ( !self.origin )
        {
            wait 5;
            continue;
        }
        
        if ( self.var_e255db54b20e6285 )
        {
            continue;
        }
        
        relevant_scriptables = [];
        loot_scriptables = getlootscriptablearrayinradius( undefined, undefined, self.origin, level.var_fef827b18b34acfd );
        
        foreach ( scriptable in loot_scriptables )
        {
            if ( !scriptable.playeroptions[ xuid ] )
            {
                item_bundle_name = common_item::function_33a2c00e46263d99( scriptable );
                
                if ( item_bundle_name )
                {
                    item_bundle = getscriptbundlefieldvalues( item_bundle_name, [ #"subtype", #"hash_6185e16d74c7bd2a", #"hash_f18e4961437edd9d" ] );
                    
                    if ( item_bundle.subtype == "item_select" )
                    {
                        if ( scriptable.contents )
                        {
                            item_bundle_name = function_c0c3cd7e33e65928( scriptable );
                            
                            if ( item_bundle_name )
                            {
                                item_bundle = getscriptbundlefieldvalues( item_bundle_name, [ #"hash_6185e16d74c7bd2a", #"hash_f18e4961437edd9d" ] );
                            }
                        }
                        
                        if ( item_bundle.var_4d4a60aa4f956c20 )
                        {
                            function_3b98ec3b104d8d9( scriptable, self, item_bundle.var_c53cd28a247f8de5, item_bundle.var_4d4a60aa4f956c20 );
                        }
                    }
                }
            }
            
            if ( scriptable.playeroptions[ xuid ][ 0 ].weapon )
            {
                relevant_scriptables[ relevant_scriptables.size ] = scriptable;
            }
        }
        
        if ( relevant_scriptables.size > 0 )
        {
            closest_scriptable = sortbydistance( relevant_scriptables, self.origin )[ 0 ];
            
            if ( closest_scriptable )
            {
                function_d39fce9af84f0a66( closest_scriptable, self, xuid );
            }
        }
    }
}

// Namespace ob_item_select
// Params 3, eflags: 0x4
// Checksum 0x1d981c60, Offset: 0x6942
// Size: 0x433
function private function_d39fce9af84f0a66( instance, player, xuid )
{
    if ( player.var_e255db54b20e6285 == instance )
    {
        return;
    }
    
    options = instance.playeroptions[ xuid ];
    
    if ( instance.isexotic )
    {
        assert( options.size == 1, "<dev string:x47f>" );
        
        if ( options[ 0 ].weapon && function_5ec16980330fc36f( options[ 0 ].weapon ) )
        {
            var_d6d01b48b1a9f85d = function_e29d92c7411b0446( options[ 0 ].weapon );
            
            if ( isdefined( var_d6d01b48b1a9f85d ) )
            {
                options[ 1 ] = { #weapon:var_d6d01b48b1a9f85d.weaponobj, #type:"weapon", #name:var_d6d01b48b1a9f85d.name };
            }
        }
    }
    
    if ( !isdefined( level.var_e78d2aa742312b7e[ xuid ] ) )
    {
        level.var_e78d2aa742312b7e[ xuid ] = [];
    }
    
    foreach ( index, option in options )
    {
        if ( !option.weapon )
        {
            continue;
        }
        
        if ( !isdefined( level.var_e78d2aa742312b7e[ xuid ][ index ] ) )
        {
            level.var_e78d2aa742312b7e[ xuid ][ index ] = {};
        }
        
        var_aca0e49333b83af1 = level.var_e78d2aa742312b7e[ xuid ][ index ];
        
        if ( var_aca0e49333b83af1.weapon == option.weapon )
        {
            continue;
        }
        
        if ( var_aca0e49333b83af1.handle )
        {
            foreach ( cached_index, cached_xuid in level.var_8419acdb385780db[ var_aca0e49333b83af1.handle ] )
            {
                if ( xuid == cached_xuid )
                {
                    level.var_8419acdb385780db[ var_aca0e49333b83af1.handle ][ cached_index ] = undefined;
                    function_cdc669dbc8ea2101( level.var_8419acdb385780db[ var_aca0e49333b83af1.handle ] );
                    break;
                }
            }
            
            if ( level.var_8419acdb385780db[ var_aca0e49333b83af1.handle ].size == 0 )
            {
                player setclientomnvar( "ui_ob_selectable_reward_weapon_handle_" + index + 1, -1 );
                function_a76fdf4e079af7be( var_aca0e49333b83af1.handle );
                level.var_8419acdb385780db[ var_aca0e49333b83af1.handle ] = undefined;
                
                if ( level.var_685fb57a1babacf0 )
                {
                    logstring( "[OB_ITEM_SELECT] Released the weapon map handle [" + var_aca0e49333b83af1.handle + "] held by player [" + ( player.name ?? xuid ) + "]. Weapons Added: " + level.var_8419acdb385780db.size );
                }
            }
        }
        
        weaponmaphandle = function_646cc662db6a3fe0( level.var_e885e808ca5a7060, option.weapon );
        
        if ( weaponmaphandle )
        {
            thread function_d14ee364d85b45f7( player, "ui_ob_selectable_reward_weapon_handle_" + index + 1, weaponmaphandle );
            var_aca0e49333b83af1.handle = weaponmaphandle;
            var_aca0e49333b83af1.weapon = option.weapon;
            
            if ( !isdefined( level.var_8419acdb385780db[ weaponmaphandle ] ) )
            {
                level.var_8419acdb385780db[ weaponmaphandle ] = [];
            }
            
            level.var_8419acdb385780db[ weaponmaphandle ][ level.var_8419acdb385780db[ weaponmaphandle ].size ] = xuid;
            
            if ( level.var_685fb57a1babacf0 )
            {
                logstring( "[OB_ITEM_SELECT] Added the weapon map handle [" + weaponmaphandle + "] for player [" + ( player.name ?? xuid ) + "]. Weapons Added: " + level.var_8419acdb385780db.size );
            }
        }
    }
    
    if ( instance.isexotic )
    {
        options[ 1 ] = undefined;
        options[ 2 ] = undefined;
    }
}

// Namespace ob_item_select
// Params 3, eflags: 0x4
// Checksum 0x23d1922d, Offset: 0x6d7d
// Size: 0x44
function private function_d14ee364d85b45f7( player, omnvar, weaponmaphandle )
{
    player endon( #"disconnect" );
    waitframe();
    
    if ( player && player isconnected() )
    {
        player setclientomnvar( omnvar, weaponmaphandle );
    }
}

// Namespace ob_item_select
// Params 2, eflags: 0x4
// Checksum 0x78a67027, Offset: 0x6dc9
// Size: 0x177
function private function_8402869102e3b2ec( player, xuid )
{
    if ( level.var_e78d2aa742312b7e[ xuid ] )
    {
        foreach ( entry in level.var_e78d2aa742312b7e[ xuid ] )
        {
            if ( isdefined( level.var_8419acdb385780db[ entry.handle ] ) )
            {
                level.var_8419acdb385780db[ entry.handle ] = arrayremove( level.var_8419acdb385780db[ entry.handle ], xuid );
                
                if ( level.var_8419acdb385780db[ entry.handle ].size == 0 )
                {
                    function_a76fdf4e079af7be( entry.handle );
                    level.var_8419acdb385780db[ entry.handle ] = undefined;
                    
                    if ( level.var_685fb57a1babacf0 )
                    {
                        logstring( "[OB_ITEM_SELECT] Released the weapon map handle [" + entry.handle + "] held by player [" + ( player.name ?? xuid ) + "]. Weapons Added: " + level.var_8419acdb385780db.size );
                    }
                }
            }
        }
        
        level.var_e78d2aa742312b7e[ xuid ] = undefined;
    }
}

// Namespace ob_item_select
// Params 0, eflags: 0x4
// Checksum 0xa158c2d3, Offset: 0x6f48
// Size: 0x15b
function private function_eae3d29fb3b9d128()
{
    utility::flag_wait( "items_database_init" );
    level.var_807e51ff19b94a94 = [];
    level.var_1aca1c6e33605918 = [];
    itemnames = function_b79f7feabd9df55d( #"super" );
    
    foreach ( name in itemnames )
    {
        itembundle = getscriptbundlefieldvalues( name, [ #"subtype", #"ref" ] );
        ref = itembundle.ref;
        
        if ( "equip_super_grappling_hook_sm" == ref )
        {
            continue;
        }
        
        if ( "equip_portal_summon_sat" == ref )
        {
            ref = "equip_super_portal_summon";
        }
        
        if ( itembundle.subtype == "major" )
        {
            level.var_807e51ff19b94a94[ level.var_807e51ff19b94a94.size ] = ref;
            continue;
        }
        
        if ( itembundle.subtype == "minor" )
        {
            level.var_1aca1c6e33605918[ level.var_1aca1c6e33605918.size ] = ref;
        }
    }
}

// Namespace ob_item_select
// Params 1, eflags: 0x4
// Checksum 0xdb9ab7d3, Offset: 0x70ab
// Size: 0x4e
function private function_5ec16980330fc36f( weaponobj )
{
    if ( utility::issharedfuncdefined( #"weapon", #"hash_d632d4a2fa14261c" ) )
    {
        return utility::callsharedfunc( #"weapon", #"hash_d632d4a2fa14261c", weaponobj );
    }
    
    return isdefined( weaponobj.conversionkit );
}

// Namespace ob_item_select
// Params 1, eflags: 0x4
// Checksum 0x72b4c5d, Offset: 0x7102
// Size: 0x125
function private function_e29d92c7411b0446( var_caa81f49caeafd35 )
{
    player = self;
    
    if ( weapon::function_6b74ecd475e99b4( var_caa81f49caeafd35 ) )
    {
        var_d6d01b48b1a9f85d = player common_item::function_c4c43ebb7aa636dc( "weapon", { #slotname:#"tertiary_0" } );
        
        if ( var_d6d01b48b1a9f85d.weaponobj.conversionkit && function_5ec16980330fc36f( var_d6d01b48b1a9f85d.weaponobj ) )
        {
            return var_d6d01b48b1a9f85d;
        }
        
        return;
    }
    
    var_d6d01b48b1a9f85d = player common_item::function_c4c43ebb7aa636dc( "weapon", { #slotname:#"primary_0" } );
    
    if ( var_d6d01b48b1a9f85d.weaponobj.conversionkit && function_5ec16980330fc36f( var_d6d01b48b1a9f85d.weaponobj ) )
    {
        return var_d6d01b48b1a9f85d;
    }
    
    var_d6d01b48b1a9f85d = player common_item::function_c4c43ebb7aa636dc( "weapon", { #slotname:#"primary_1" } );
    
    if ( var_d6d01b48b1a9f85d.weaponobj.conversionkit && function_5ec16980330fc36f( var_d6d01b48b1a9f85d.weaponobj ) )
    {
        return var_d6d01b48b1a9f85d;
    }
}

