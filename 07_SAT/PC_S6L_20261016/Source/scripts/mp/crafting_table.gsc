// scripts\mp\crafting_table.gsc  (hash_23131bd305bbd11b.gscc) (size: 12784 Bytes / 0x31f0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa10a936d (2701824877)
// size ...... 12784 (0x31f0)
// includes .. 15  (offset: 0x2f50)
// strings ... 37  (offset: 0x2fc8)
// dev strs .. 0   (offset: 0x31f0)
// exports ... 26  (offset: 0x1f88)
// cseg ...... 0x3a6 + 0x1be2 (0x1f88)
// imports ... 99  (offset: 0x2398)
// animtree1 . 0   (offset: 0x31f0)
// animtree2 . 0   (offset: 0x31f0)
#using script_59336152890f5f73;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\armor;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\lui_game_event_aggregator;
#using scripts\mp\content_manager;
#using scripts\mp\currency;
#using scripts\mp\equipment;
#using scripts\mp\interaction;
#using scripts\mp\laststand;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_database;
#using scripts\mp\purchasemenu;

#namespace crafting_table;

// Namespace crafting_table
// Params 0
// Checksum 0x15405019, Offset: 0x3c4
// Size: 0x46
function init_crafting_table()
{
    level.a_s_crafting_tables = [];
    level thread _init_crafting_table();
    level.var_6f5cbfe6aee65f4 = &craft_give_equipment;
    level.crafting_table_menu = namespace_c1f157ec34641640::register();
    callback::add( #"player_death", &on_player_killed );
}

// Namespace crafting_table
// Params 0, eflags: 0x4
// Checksum 0x9565e0a8, Offset: 0x412
// Size: 0x88
function private _init_crafting_table()
{
    content_manager::function_3209da123476142f( "crafting_table", &function_6ddad73b7734c1a );
    content_manager::register_disable_toggle( "crafting_table", &content_manager::function_5d04e50a29a2142c, &function_6af83b4b84871d7e, &function_6829250c1915a033 );
    waittillframeend();
    utility::flag_wait( "scriptables_ready" );
    var_959dbddcfff2592d = utility::getstructarray( "content_destination", "variantname" );
    
    if ( isdefined( var_959dbddcfff2592d ) && var_959dbddcfff2592d.size > 0 )
    {
        level thread function_605a8d53c17ec2fa( var_959dbddcfff2592d[ 0 ] );
    }
    
    utility::flag_set( "crafting_tables_ready" );
    
    /#
        level thread setup_crafting_table_devgui();
    #/
}

// Namespace crafting_table
// Params 0
// Checksum 0x762e2d8, Offset: 0x4a2
// Size: 0x19f
function init_crafting_items()
{
    var_9c657aff3a2d52cf = purchasemenu::get_purchasemenu( #"crafting_table" );
    
    if ( isdefined( var_9c657aff3a2d52cf ) && isdefined( var_9c657aff3a2d52cf.items ) )
    {
        foreach ( item in var_9c657aff3a2d52cf.items )
        {
            if ( isdefined( item.category ) )
            {
                switch ( item.category )
                {
                    case #"hash_25789111b74943b4":
                        item.var_6819427fe9874956 = &craft_armor_tier;
                        break;
                    case #"hash_339227cb650975db":
                        item.slot = "primary";
                        item.var_6819427fe9874956 = &function_854dc844d37cdb7f;
                        break;
                    case #"hash_850999d7864fa3b4":
                        item.slot = "secondary";
                        item.var_6819427fe9874956 = &function_854dc844d37cdb7f;
                        break;
                    case #"hash_605929bc0f7f95c8":
                        item.var_6819427fe9874956 = &function_5733b57d986511b0;
                        break;
                    default:
                        utility::error( "crafting_table item: " + item.itemref + " does not have a category set." );
                        break;
                }
            }
        }
    }
    
    lui_game_event_aggregator::registeronluieventcallback( &craft_purchase_response );
}

// Namespace crafting_table
// Params 1
// Checksum 0xca32fcbf, Offset: 0x649
// Size: 0x196
function function_a2f9d132dd19ad1a( alt_alias )
{
    var_9c657aff3a2d52cf = purchasemenu::get_purchasemenu( alt_alias );
    
    if ( isdefined( var_9c657aff3a2d52cf ) && isdefined( var_9c657aff3a2d52cf.items ) )
    {
        foreach ( item in var_9c657aff3a2d52cf.items )
        {
            if ( isdefined( item.category ) )
            {
                switch ( item.category )
                {
                    case #"hash_25789111b74943b4":
                        item.var_6819427fe9874956 = &craft_armor_tier;
                        break;
                    case #"hash_339227cb650975db":
                        item.slot = "primary";
                        item.var_6819427fe9874956 = &function_854dc844d37cdb7f;
                        break;
                    case #"hash_850999d7864fa3b4":
                        item.slot = "secondary";
                        item.var_6819427fe9874956 = &function_854dc844d37cdb7f;
                        break;
                    case #"hash_605929bc0f7f95c8":
                        item.var_6819427fe9874956 = &function_5733b57d986511b0;
                        break;
                    default:
                        utility::error( "crafting_table item: " + item.itemref + " does not have a category set." );
                        break;
                }
            }
        }
    }
}

// Namespace crafting_table
// Params 1
// Checksum 0xcfca446, Offset: 0x7e7
// Size: 0x118
function function_605a8d53c17ec2fa( destination )
{
    foreach ( location in destination.locations )
    {
        var_3adc81ea20cc8649 = location.instances[ "crafting_table" ];
        
        if ( isdefined( var_3adc81ea20cc8649 ) )
        {
            foreach ( instance in var_3adc81ea20cc8649.versions )
            {
                content_manager::function_67e4b7678fb21e11( instance );
            }
        }
    }
}

/#

    // Namespace crafting_table
    // Params 0
    // Checksum 0xf1790153, Offset: 0x907
    // Size: 0x5, Type: dev
    function setup_crafting_table_devgui()
    {
        
    }

#/

// Namespace crafting_table
// Params 1, eflags: 0x4
// Checksum 0x7556440b, Offset: 0x914
// Size: 0x30
function private on_player_killed( deathdata )
{
    if ( level.crafting_table_menu namespace_c1f157ec34641640::is_open( self ) )
    {
        level.crafting_table_menu namespace_c1f157ec34641640::close( self );
    }
}

// Namespace crafting_table
// Params 1
// Checksum 0xfe4fd1cc, Offset: 0x94c
// Size: 0xaa
function function_6ddad73b7734c1a( instance )
{
    crafting_table_structs = utility::getstructarray( "crafting_table_trigger", "targetname" );
    
    foreach ( struct in crafting_table_structs )
    {
        if ( struct content_manager::function_e0f0562adcd2c071() )
        {
            struct spawn_crafting_table();
        }
    }
    
    init_crafting_items();
}

// Namespace crafting_table
// Params 0
// Checksum 0x8995a70a, Offset: 0x9fe
// Size: 0x1a2
function spawn_crafting_table()
{
    if ( !arraycontains( level.a_s_crafting_tables, self ) )
    {
        level.a_s_crafting_tables[ level.a_s_crafting_tables.size ] = self;
    }
    
    if ( isdefined( self.target2 ) )
    {
        var_ba0fb417fd6f6a49 = utility::getstruct( self.target2, "targetname" );
    }
    else
    {
        var_ba0fb417fd6f6a49 = self;
    }
    
    self.var_7fac639c5e7fd54 = content_manager::spawn_script_model( var_ba0fb417fd6f6a49, "t10_zm_machine_crafting_set_table_fxanim", 1, 1 );
    self.var_7fac639c5e7fd54 thread set_crafting_table_vfx( "static" );
    utility::callsharedfunc( #"scriptable", #"hash_10d5e3bb8a551724", self.var_7fac639c5e7fd54, "icon" );
    interact_org = self.var_7fac639c5e7fd54.origin;
    
    if ( self.var_7fac639c5e7fd54 tagexists( "j_prop_38" ) )
    {
        interact_org = self.var_7fac639c5e7fd54 gettagorigin( "j_prop_38" );
    }
    
    var_45b620bc30783968 = spawnscriptable( "t10_zm_machine_crafting_interact", self.var_7fac639c5e7fd54.origin );
    var_45b620bc30783968 setscriptablepartstate( "usable", "usable" );
    var_45b620bc30783968 = interaction::register_scriptable_interact( var_45b620bc30783968, &function_4c0d42b2cb94d589, undefined, undefined, &function_1c082d2f2c01c7b );
    self.var_7fac639c5e7fd54.interact = var_45b620bc30783968;
    self.var_7fac639c5e7fd54.interact.struct = self;
    self.var_7fac639c5e7fd54 utility::callsharedfunc( #"zombie", #"hash_896b88a46f6a4c15", "crafting" );
}

// Namespace crafting_table
// Params 1
// Checksum 0x7cd2ac5f, Offset: 0xba8
// Size: 0x9e
function function_4c0d42b2cb94d589( player )
{
    if ( player.interactions_disabled || player.crafting_table_disabled || player.isdeploying )
    {
        return;
    }
    
    if ( utility::issharedfuncdefined( #"crafting_table", #"hash_68556212236c31b1" ) )
    {
        s_crafting_table = self.struct;
        
        if ( s_crafting_table.is_locked )
        {
            player utility::callsharedfunc( #"crafting_table", #"hash_68556212236c31b1", s_crafting_table );
            return;
        }
    }
    
    function_696662b35d51b80d( player );
}

// Namespace crafting_table
// Params 2
// Checksum 0xba6d8a18, Offset: 0xc4e
// Size: 0x263
function function_1c082d2f2c01c7b( usable, player )
{
    if ( isdefined( player ) && isdefined( usable ) && !player.interactions_disabled && !player.crafting_table_disabled )
    {
        if ( utility::issharedfuncdefined( #"crafting_table", #"hash_c07d5108efec9058" ) )
        {
            s_crafting_table = usable.struct;
            [ is_locked, hint_string, not_enough_string ] = utility::callsharedfunc( #"crafting_table", #"hash_c07d5108efec9058", s_crafting_table );
            
            if ( is_locked )
            {
                locked_cost = s_crafting_table.locked_cost;
                can_interact = player currency::can_afford( #"essence", locked_cost );
                return { #interactable:can_interact, #aux_text:can_interact ? &"" : not_enough_string, #icon_text_value:locked_cost, #var_776a268784e089af:&"SHARED_HINTSTRINGS/COST_ESSENCE", #buttoncallout:hint_string, #icon:"ui_icon_zm_ping_crafting_table", #description:&"SHARED_HINTSTRINGS/CRAFTING_TABLE_DESCRIPTION", #title:&"SHARED_HINTSTRINGS/CRAFTING_TABLE", #string:&"shared_hintstrings/crafting_table_start_hint", #type:"HINT_BUTTON" };
            }
        }
        
        return { #buttoncallout:&"SHARED_HINTSTRINGS/USE", #icon:"ui_icon_zm_ping_crafting_table", #description:&"SHARED_HINTSTRINGS/CRAFTING_TABLE_DESCRIPTION", #title:&"SHARED_HINTSTRINGS/CRAFTING_TABLE", #string:&"shared_hintstrings/crafting_table_start_hint", #type:"HINT_BUTTON" };
    }
    else if ( player.crafting_table_disabled )
    {
        return { #string:usable.var_5523ddf0718b94ed ?? &"hash_67764dd5edcfba38", #type:"HINT_NOBUTTON" };
    }
    
    return { #string:&"", #type:"HINT_NOICON" };
}

// Namespace crafting_table
// Params 1
// Checksum 0x45a6d7e5, Offset: 0xeba
// Size: 0x156
function function_696662b35d51b80d( player )
{
    player endon( #"death_or_disconnect" );
    player endon( #"hash_998fd043e12681a1" );
    ref = player.var_d1b557dbfbe1e196 ?? level.var_d1b557dbfbe1e196 ?? #"crafting_table";
    var_9c657aff3a2d52cf = purchasemenu::get_purchasemenu( ref );
    
    if ( !isdefined( var_9c657aff3a2d52cf ) )
    {
        return;
    }
    
    if ( !isdefined( player.var_3b2b912816c110b4 ) )
    {
        player.var_3b2b912816c110b4 = 0;
    }
    
    n_menu_id = var_9c657aff3a2d52cf.id ?? -1;
    player val::set( "using_crafting_table", "killstreaks", 0 );
    player setclientomnvar( "ui_self_revive_bought_count", player.var_3b2b912816c110b4 );
    player setclientomnvar( "ui_purchasemenu_id", n_menu_id );
    waitframe();
    
    if ( !level.crafting_table_menu namespace_c1f157ec34641640::is_open( player ) )
    {
        level.crafting_table_menu namespace_c1f157ec34641640::open( player );
        self disableplayeruse( player );
        
        if ( isdefined( var_9c657aff3a2d52cf.soundopenmenu ) )
        {
            player playsoundtoplayer( var_9c657aff3a2d52cf.soundopenmenu, player );
        }
        
        player.crafting_table_active = self;
    }
    
    player thread function_d9bcec55ddec74a9( self );
    player thread purchasemenu::menu_close_notify( var_9c657aff3a2d52cf, &on_menu_close );
}

// Namespace crafting_table
// Params 1
// Checksum 0xf828a801, Offset: 0x1018
// Size: 0x1a
function on_menu_close( player )
{
    player.var_fa38187d52ae7d76 = 1;
}

// Namespace crafting_table
// Params 1
// Checksum 0x34d5b8da, Offset: 0x103a
// Size: 0x206
function function_d9bcec55ddec74a9( crafting_table_interact )
{
    self notify( #"hash_7d2ef56e19d7ecec" );
    self endon( #"hash_7d2ef56e19d7ecec" );
    self endon( #"disconnect" );
    var_9c657aff3a2d52cf = purchasemenu::get_purchasemenu( #"crafting_table" );
    
    if ( !( isdefined( var_9c657aff3a2d52cf ) && isdefined( level.crafting_table_menu ) ) )
    {
        return;
    }
    
    table = crafting_table_interact.struct.var_7fac639c5e7fd54;
    wait 0.75;
    
    if ( crafting_table_interact.struct.var_7fac639c5e7fd54 )
    {
        n_start_distance = distance2d( table.origin, self.origin );
        v_start = self.origin;
        self.var_fa38187d52ae7d76 = undefined;
        
        while ( isdefined( table ) && isalive( self ) && !self.inlaststand && ( distance2d( table.origin, self.origin ) <= n_start_distance || distance2d( self.origin, table.origin ) < 64 ) )
        {
            if ( !isdefined( table ) || self stancebuttonpressed() || self.var_fa38187d52ae7d76 || level.b_zm_game_over )
            {
                break;
            }
            
            waitframe();
        }
    }
    
    if ( isdefined( self ) )
    {
        self.var_fa38187d52ae7d76 = undefined;
        purchasemenu::function_93f934ea2f1c06f8( 2 );
        level.crafting_table_menu namespace_c1f157ec34641640::close( self );
        self setclientomnvar( "ui_purchasemenu_id", 0 );
        
        if ( isdefined( var_9c657aff3a2d52cf.soundclosemenu ) )
        {
            self playsoundtoplayer( var_9c657aff3a2d52cf.soundclosemenu, self );
        }
        
        if ( isdefined( crafting_table_interact ) )
        {
            crafting_table_interact enableplayeruse( self );
        }
        
        self.crafting_table_active = undefined;
        self.var_fa38187d52ae7d76 = undefined;
        self notify( #"hash_998fd043e12681a1" );
        self notify( var_9c657aff3a2d52cf.var_8a64e37068076a47 );
        val::reset_all( "using_crafting_table" );
    }
}

// Namespace crafting_table
// Params 1
// Checksum 0x84113e22, Offset: 0x1248
// Size: 0xe7
function set_crafting_table_vfx( state )
{
    self notify( #"hash_3e1b7a3eb74b0c8b" );
    self endon( #"hash_3e1b7a3eb74b0c8b" );
    
    if ( !self isscriptable() )
    {
        return;
    }
    
    if ( self.is_playing_vfx )
    {
        return;
    }
    
    self.is_playing_vfx = 0;
    
    switch ( state )
    {
        case #"hash_b196217e12b52a9b":
            self setscriptablepartstate( "base", "static" );
            break;
        case #"hash_b389e7ddef378fd0":
            self setscriptablepartstate( "base", "activate" );
            self.is_playing_vfx = 1;
            wait 6.7;
            self setscriptablepartstate( "base", "static" );
            self.is_playing_vfx = 0;
            break;
        case #"hash_35bb36c485686365":
            self setscriptablepartstate( "base", "disabled" );
            self setscriptablepartstate( "icon", "disabled" );
            break;
    }
}

// Namespace crafting_table
// Params 2
// Checksum 0x1c04c49, Offset: 0x1337
// Size: 0x51
function craft_purchase_response( channel, purchaseindex )
{
    if ( isdefined( purchaseindex ) )
    {
        if ( channel == "craft_purchase" )
        {
            function_779171b7b7ba266e( purchaseindex );
            return;
        }
        
        if ( purchasemenu::function_bc886ba2b8da88c( #"crafting_table", channel ) )
        {
            self.var_fa38187d52ae7d76 = 1;
        }
    }
}

// Namespace crafting_table
// Params 1
// Checksum 0x43621313, Offset: 0x1390
// Size: 0x1be
function function_779171b7b7ba266e( var_bcb95e7738d59d5d )
{
    var_9c657aff3a2d52cf = purchasemenu::get_purchasemenu( #"crafting_table" );
    
    if ( !isdefined( var_9c657aff3a2d52cf ) )
    {
        return;
    }
    
    ref = self.var_d1b557dbfbe1e196 ?? level.var_d1b557dbfbe1e196 ?? #"crafting_table";
    item = purchasemenu::create_item_struct( ref, var_bcb95e7738d59d5d );
    
    if ( isdefined( item ) )
    {
        response = self [[ var_9c657aff3a2d52cf.items[ var_bcb95e7738d59d5d ].var_6819427fe9874956 ]]( item );
        
        if ( response == 1 )
        {
            if ( isdefined( item.var_9281c8f5b1f3b37a ) )
            {
                self playsoundtoplayer( item.var_9281c8f5b1f3b37a, self );
            }
            
            if ( isdefined( self.crafting_table_active ) && isdefined( self.crafting_table_active.struct ) && isdefined( self.crafting_table_active.struct.var_7fac639c5e7fd54 ) )
            {
                self.crafting_table_active.struct.var_7fac639c5e7fd54 thread set_crafting_table_vfx( "activate" );
            }
            
            paramsitem = spawnstruct();
            paramsitem.item = item;
            paramsitem.currency = item.currency;
            paramsitem.cost = item.cost;
            callback::callback( "on_crafting_item_success", paramsitem );
        }
        else if ( response == 3 )
        {
            if ( isdefined( item.var_ac7c10eb14c9d6e0 ) )
            {
                self playsoundtoplayer( item.var_ac7c10eb14c9d6e0, self );
            }
        }
        
        purchasemenu::function_93f934ea2f1c06f8( response );
    }
}

// Namespace crafting_table
// Params 3
// Checksum 0x8f87619b, Offset: 0x1556
// Size: 0x14a
function craft_give_equipment( equipref, slot, isrefund )
{
    if ( slot == "secondary" )
    {
        if ( utility::callsharedfunc( #"crafting_table", #"hash_a55f67deb6de0476", equipref ) )
        {
            return 3;
        }
    }
    
    currentequipment = equipment_mp::getcurrentequipment( slot );
    currentammo = 0;
    var_6a99a18ed8873ab5 = undefined;
    
    if ( isdefined( currentequipment ) )
    {
        currentammo = equipment_mp::getequipmentammo( currentequipment );
        var_6a99a18ed8873ab5 = equipment_mp::getequipmentmaxammo( currentequipment );
    }
    
    if ( isdefined( currentequipment ) && currentequipment != equipref && currentammo > 0 )
    {
        function_8fad33553f964d5b( currentequipment, currentammo );
        currentammo = 0;
        var_6a99a18ed8873ab5 = equipment_mp::getequipmentmaxammo( equipref );
    }
    
    if ( !isdefined( var_6a99a18ed8873ab5 ) )
    {
        var_6a99a18ed8873ab5 = equipment_mp::getequipmentmaxammo( equipref );
    }
    
    if ( currentammo >= var_6a99a18ed8873ab5 )
    {
        return 5;
    }
    else
    {
        var_9d8fec2818e99d0a = utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_z_mod", #"z_mod_buy_one_get_one" );
        
        if ( var_9d8fec2818e99d0a && !isrefund )
        {
            if ( var_6a99a18ed8873ab5 - currentammo != 1 )
            {
                currentammo += 2;
            }
            else
            {
                currentammo++;
            }
        }
        else
        {
            currentammo++;
        }
    }
    
    if ( currentequipment != equipref )
    {
        equipment_mp::giveequipment( equipref, slot );
    }
    
    equipment_mp::setequipmentammo( equipref, currentammo );
}

// Namespace crafting_table
// Params 1
// Checksum 0x9c283b37, Offset: 0x16a9
// Size: 0xc6
function function_854dc844d37cdb7f( item )
{
    var_30f37d57a23dc69f = purchasemenu::get_purchasemenu_item( #"crafting_table", item.globalindex );
    
    if ( currency::get_currency_amount( item.currency ) < item.cost )
    {
        return 3;
    }
    
    if ( isdefined( level.var_71b6079fc23545cd ) && !self [[ level.var_71b6079fc23545cd ]]( item ) )
    {
        return 3;
    }
    
    var_8a2fbbbee4ef7526 = craft_give_equipment( item.itemref, var_30f37d57a23dc69f.slot );
    
    if ( isdefined( var_8a2fbbbee4ef7526 ) )
    {
        return var_8a2fbbbee4ef7526;
    }
    
    currency::function_b5fe1e05c892a7f3( item.currency, item.cost );
    return 1;
}

// Namespace crafting_table
// Params 1
// Checksum 0xbfcc2cd1, Offset: 0x1778
// Size: 0x3f1
function function_5733b57d986511b0( item )
{
    cost = item.cost;
    
    if ( item.itemref == "equip_self_revive" && isdefined( item.var_87bb7cc888933731 ) )
    {
        cost += self.var_3b2b912816c110b4 * item.var_87bb7cc888933731;
    }
    
    if ( !currency::can_afford( item.currency, cost ) )
    {
        return 3;
    }
    
    if ( isdefined( level.var_71b6079fc23545cd ) && !self [[ level.var_71b6079fc23545cd ]]( item ) )
    {
        return 3;
    }
    
    switch ( item.itemref )
    {
        case #"hash_66b1dce46fb55c22":
            purchase_limit = item.purchaselimit;
            var_19642844e0fda25a = utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_quickrevive", #"quick_revive_emergency_medical_kit" );
            
            if ( var_19642844e0fda25a )
            {
                purchase_limit++;
            }
            
            if ( item.var_7e02ec01953711b4 && self.var_3b2b912816c110b4 >= purchase_limit )
            {
                return 5;
            }
            
            if ( laststand::function_ed4da7e5751eed47() )
            {
                laststand::function_a2e03a85015b1897();
                self.var_3b2b912816c110b4++;
                
                if ( isdefined( item.var_fd31b7199454f3b6 ) )
                {
                    self setclientomnvar( item.var_fd31b7199454f3b6, self.var_3b2b912816c110b4 );
                }
                
                currency::function_b5fe1e05c892a7f3( item.currency, cost );
                return 1;
            }
            else
            {
                return 5;
            }
            
            break;
        case #"hash_a825dc92f843028d":
            if ( armor::function_22290101992e4874() < armor::function_db9ebf086f67fe92() )
            {
                armor::function_164c824617d7e8d7( 1 );
                currency::function_b5fe1e05c892a7f3( item.currency, cost );
                return 1;
            }
            else
            {
                return 5;
            }
            
            break;
        case #"hash_550bcff32518eb71":
            meter = utility::callsharedfunc( #"playermod", #"get_meter", #"daisy_rad" );
            
            if ( meter > 0 )
            {
                currency::function_b5fe1e05c892a7f3( item.currency, cost );
                meter -= 250;
                utility::callsharedfunc( #"playermod", #"set_meter", #"daisy_rad", meter );
                return 1;
            }
            else
            {
                return 5;
            }
            
            break;
        case #"hash_592aa356fe5a08b0":
        case #"hash_cfc03a44a450a180":
            return utility::callsharedfunc( #"zm_robot_controller", #"hash_77d0f357c78c939", item, cost );
        default:
            var_30e3c97dbff58cd1 = 1;
            var_a5d2c8c32ea3ac76 = item.itemref;
            
            if ( isdefined( level.killstreaksetups[ var_a5d2c8c32ea3ac76 ] ) )
            {
                var_ff8ad536cc2f2ee8 = killstreaks::getkillstreakinslot( var_30e3c97dbff58cd1 );
                
                if ( isdefined( var_ff8ad536cc2f2ee8 ) && var_ff8ad536cc2f2ee8.available >= item.maxstack )
                {
                    if ( var_a5d2c8c32ea3ac76 == var_ff8ad536cc2f2ee8.streakname )
                    {
                        return 5;
                    }
                }
                
                item_bundle_name = common_item_database::function_a4f0a21951180013( item.itemref );
                
                if ( isdefined( item_bundle_name ) )
                {
                    scriptable_name = getscriptbundlefieldvalue( item_bundle_name, #"scriptable" );
                    fake_scriptable = { #count:item.itemamount ?? 1, #type:scriptable_name };
                    success = common_item::function_2b5e2ff57d5f392( fake_scriptable, 0, 1 );
                    
                    if ( success )
                    {
                        currency::function_b5fe1e05c892a7f3( item.currency, cost );
                        params = spawnstruct();
                        params.item = item;
                        params.player = self;
                        callback::callback( #"hash_6998a4a69df2653", params );
                        return 1;
                    }
                }
            }
            
            break;
    }
    
    return 2;
}

// Namespace crafting_table
// Params 2
// Checksum 0x5ad4cf34, Offset: 0x1b72
// Size: 0xd6
function function_8fad33553f964d5b( var_80ce893c79d1d533, n_count )
{
    dist = 64;
    player_forward = anglestoforward( self.angles );
    player_forward = vectornormalize( player_forward );
    player_forward *= -1;
    drop_pos = self.origin + player_forward * 64;
    spawnoptions = common_item::items_initspawnoptions_spawnfromposition( drop_pos );
    spawnoptions.var_90cdc5dbcd319e5d = 1;
    item = common_item::function_325e28c0fb65c36a( var_80ce893c79d1d533, n_count, spawnoptions );
    
    if ( isdefined( item ) )
    {
        params = { #itembundlename:common_item_database::function_a4f0a21951180013( var_80ce893c79d1d533 ), #item:item };
        level callback::callback( #"player_item_drop", params );
    }
}

// Namespace crafting_table
// Params 1
// Checksum 0x7b507115, Offset: 0x1c50
// Size: 0xe9
function craft_armor_tier( item )
{
    if ( currency::get_currency_amount( item.currency ) < item.cost )
    {
        return 3;
    }
    
    if ( isdefined( level.var_71b6079fc23545cd ) && !self [[ level.var_71b6079fc23545cd ]]( item ) )
    {
        return 3;
    }
    
    var_fb9dbc5e38c0b372 = item.itemref == "armor_repair";
    
    if ( var_fb9dbc5e38c0b372 )
    {
        if ( !armor::has_full_armor() )
        {
            armor::repair_armor( self.maxarmorhealth );
        }
        else
        {
            return 4;
        }
    }
    else if ( self.platecarrierlevel == item.tier - 1 )
    {
        function_fdbe2cad6d8bb7e7( item.tier );
    }
    else
    {
        return 4;
    }
    
    currency::function_b5fe1e05c892a7f3( item.currency, item.cost );
    return 1;
}

// Namespace crafting_table
// Params 1
// Checksum 0x2aee7d0, Offset: 0x1d42
// Size: 0xd4
function function_fdbe2cad6d8bb7e7( platecarrierlevel )
{
    var_ea78267032a84853 = 100;
    var_ea78277032a84a86 = 200;
    var_ea78287032a84cb9 = 300;
    
    switch ( platecarrierlevel )
    {
        case 1:
            self.platecarrierlevel = 1;
            self.maxarmorhealth = var_ea78267032a84853;
            armor::setarmorhealth( var_ea78267032a84853 );
            break;
        case 2:
            self.platecarrierlevel = 2;
            self.maxarmorhealth = var_ea78277032a84a86;
            armor::setarmorhealth( var_ea78277032a84a86 );
            break;
        case 3:
            self.platecarrierlevel = 3;
            self.maxarmorhealth = var_ea78287032a84cb9;
            armor::setarmorhealth( var_ea78287032a84cb9 );
            break;
    }
    
    self setclientomnvar( "ui_armor_current_level", platecarrierlevel );
}

// Namespace crafting_table
// Params 1
// Checksum 0x59192968, Offset: 0x1e1e
// Size: 0x117
function function_6af83b4b84871d7e( s_feature )
{
    crafting_table = s_feature.var_7fac639c5e7fd54;
    
    foreach ( player in level.players )
    {
        if ( !level.crafting_table_menu namespace_c1f157ec34641640::is_open( player ) )
        {
            continue;
        }
        
        if ( player.crafting_table_active != crafting_table.interact )
        {
            continue;
        }
        
        player.var_fa38187d52ae7d76 = 1;
    }
    
    if ( crafting_table.is_playing_vfx )
    {
        crafting_table.is_playing_vfx = 0;
    }
    
    crafting_table set_crafting_table_vfx( "disabled" );
    crafting_table.interact setscriptablepartstate( "usable", "off" );
}

// Namespace crafting_table
// Params 1
// Checksum 0x900e6e7a, Offset: 0x1f3d
// Size: 0x4b
function function_6829250c1915a033( s_feature )
{
    crafting_table = s_feature.var_7fac639c5e7fd54;
    crafting_table set_crafting_table_vfx( "static" );
    crafting_table.interact setscriptablepartstate( "usable", "usable" );
}

