// script_1eeb27472f818925  (hash_1eeb27472f818925.gscc) (size: 10876 Bytes / 0x2a7c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x70ceccf9 (1892601081)
// size ...... 10876 (0x2a7c)
// includes .. 10  (offset: 0x27f4)
// strings ... 33  (offset: 0x2844)
// dev strs .. 2   (offset: 0x2a64)
// exports ... 28  (offset: 0x1a84)
// cseg ...... 0x31f + 0x1765 (0x1a84)
// imports ... 72  (offset: 0x1ee4)
// animtree1 . 0   (offset: 0x2a7c)
// animtree2 . 0   (offset: 0x2a7c)
#using script_35efc59124dbb5db;
#using script_6f175ab567ad9495;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\damage;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_vo;

#namespace charge_the_weapon;

// Namespace charge_the_weapon
// Params 0
// Checksum 0x38334a7c, Offset: 0x33d
// Size: 0x53
function init()
{
    data = { #var_3c961b0682c21834:undefined, #past_crafting_table:undefined, #future_crafting_table:undefined };
    level.var_ebfb26f91bd45893.var_1e5d973acb8a3591 = data;
    utility::flag_set( #"hash_b571771f8fced32b" );
}

// Namespace charge_the_weapon
// Params 2
// Checksum 0xa070f6b8, Offset: 0x398
// Size: 0xce
function execute( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    utility::flag_wait( "mantis_ww_quest_crafting_table_build_disabled" );
    utility::flag_wait( #"hash_b571771f8fced32b" );
    data = level.var_ebfb26f91bd45893.var_1e5d973acb8a3591;
    data.future_crafting_table = setup_crafting_table( "ww_quest_crafting_table_future" );
    data.past_crafting_table = setup_crafting_table( "ww_quest_crafting_table_past" );
    utility::flag_set( "crafting_table_setup_complete" );
    level callback::add( #"player_used_item", &function_b035882402d85e2a );
    level callback::add( #"player_used_item", &function_ffcdff3277e6f507 );
    utility::flag_wait( "wwu_weapon_retrieved" );
}

// Namespace charge_the_weapon
// Params 2
// Checksum 0x59c1d642, Offset: 0x46e
// Size: 0x36
function cleanup( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        utility::flag_set( "wwu_weapon_retrieved" );
    }
    
    level zm_quest::update_round_cap( 7 );
}

// Namespace charge_the_weapon
// Params 1, eflags: 0x4
// Checksum 0xdfdc192c, Offset: 0x4ac
// Size: 0xa0
function private setup_crafting_table( id )
{
    crafting_table = utility::getent_or_struct( id, "script_noteworthy" );
    store_node = { #angles:crafting_table gettagangles( "tag_sundergat" ), #origin:crafting_table gettagorigin( "tag_sundergat" ) + ( 7.25, -5, 0 ) };
    
    if ( !isdefined( crafting_table ) || !isdefined( store_node ) )
    {
        return;
    }
    
    crafting_table.store_node = store_node;
    crafting_table thread damage::monitordamage( 115, "none", &open_crafting_table, &function_34b1080c11b15065 );
    return crafting_table;
}

// Namespace charge_the_weapon
// Params 2, eflags: 0x4
// Checksum 0x9058badc, Offset: 0x555
// Size: 0xe1
function private crafting_table_hint( interact, player )
{
    if ( !is_crafting_table_open( interact.crafting_table ) || !player function_d200f9b2d5093289() || function_90d0ffa323f14e8f( interact.crafting_table ) )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    hint = { #icon:"ui_icon_zm_ping_work_bench", #buttoncallout:&"zm_sat_mantis/wwu_place_btn_callout", #description:&"zm_sat_mantis/wwu_crafting_table_add_ww", #title:&"zm_sat_mantis/ww_crafting_table_title", #string:&"zm_sat_mantis/ww_crafting_table", #type:"HINT_BUTTON" };
    return hint;
}

// Namespace charge_the_weapon
// Params 1, eflags: 0x4
// Checksum 0x89dea6f, Offset: 0x63f
// Size: 0xca
function private crafting_table_interaction( player )
{
    if ( self.in_use || isdefined( player ) && player.interactions_disabled || !is_crafting_table_open( self.crafting_table ) || function_90d0ffa323f14e8f( self.crafting_table ) )
    {
        return;
    }
    
    crafting_table = self.crafting_table;
    
    if ( player function_d200f9b2d5093289() )
    {
        crafting_table.stored_weapon = player function_b8be0f03e93c6706( crafting_table );
        crafting_table.stored_weapon function_7653c765b6c7b815();
        crafting_table close_crafting_table();
        crafting_table setscriptablepartstate( "effects", "crafting" );
        crafting_table function_158023f2cec0c8c9();
        return;
    }
    
    crafting_table close_crafting_table();
}

// Namespace charge_the_weapon
// Params 1, eflags: 0x4
// Checksum 0xd6b9d3a2, Offset: 0x711
// Size: 0x18, Type: bool
function private function_90d0ffa323f14e8f( crafting_table )
{
    return isdefined( crafting_table.stored_weapon );
}

// Namespace charge_the_weapon
// Params 1, eflags: 0x4
// Checksum 0xfa2a1c30, Offset: 0x732
// Size: 0x2b
function private is_crafting_table_open( crafting_table )
{
    is_open = crafting_table getscriptablepartstate( "base" ) == "opened";
    return is_open;
}

// Namespace charge_the_weapon
// Params 1, eflags: 0x4
// Checksum 0x82caa9eb, Offset: 0x766
// Size: 0x2b
function private is_crafting_table_closed( crafting_table )
{
    is_closed = crafting_table getscriptablepartstate( "base" ) == "closed";
    return is_closed;
}

// Namespace charge_the_weapon
// Params 1, eflags: 0x4
// Checksum 0x5d6eaefe, Offset: 0x79a
// Size: 0x88
function private open_crafting_table( params )
{
    if ( is_crafting_table_closed( self ) && namespace_e5bec19a2173f137::is_crafting_table_charged() )
    {
        self setscriptablepartstate( "base", "open" );
        self setscriptablepartstate( "effects", "idle" );
        
        if ( isdefined( self.stored_weapon ) )
        {
            self.stored_weapon function_e203bba36cfb19d0();
            thread function_e2c7b3828af12db8( self.stored_weapon );
        }
        else
        {
            spawn_interactable();
        }
        
        function_158023f2cec0c8c9();
        utility::ent_flag_set( "wwu_crafting_table_opened" );
    }
}

// Namespace charge_the_weapon
// Params 1, eflags: 0x4
// Checksum 0x165123d, Offset: 0x82a
// Size: 0x50
function private close_crafting_table( params )
{
    if ( is_crafting_table_open( self ) )
    {
        if ( isdefined( self.interactable ) )
        {
            self.interactable freescriptable();
        }
        
        self setscriptablepartstate( "base", "close_slow" );
        wait 2;
        utility::ent_flag_clear( "wwu_crafting_table_opened" );
    }
}

// Namespace charge_the_weapon
// Params 1, eflags: 0x4
// Checksum 0x697c5142, Offset: 0x882
// Size: 0x22
function private function_e2c7b3828af12db8( stored_weapon )
{
    while ( isdefined( stored_weapon ) )
    {
        wait 0.1;
    }
    
    spawn_interactable();
}

// Namespace charge_the_weapon
// Params 0, eflags: 0x4
// Checksum 0x705e97f2, Offset: 0x8ac
// Size: 0x48
function private spawn_interactable()
{
    self.interactable = zm_quest::function_91f9590e98d57ff6( self.store_node.origin, &crafting_table_interaction, &crafting_table_hint, "small" );
    self.interactable.crafting_table = self;
}

// Namespace charge_the_weapon
// Params 1, eflags: 0x4
// Checksum 0x4f8306e3, Offset: 0x8fc
// Size: 0x3b, Type: bool
function private function_34b1080c11b15065( data )
{
    if ( isplayer( data.attacker ) && data.meansofdeath == "MOD_MELEE" )
    {
        open_crafting_table();
    }
    
    return false;
}

// Namespace charge_the_weapon
// Params 0, eflags: 0x4
// Checksum 0x6a616c94, Offset: 0x940
// Size: 0x110
function private function_25c168654be046ae()
{
    foreach ( player in level.players )
    {
        primary_weapons = player getweaponslistprimaries();
        
        foreach ( weapon in primary_weapons )
        {
            if ( weapon.basename == "sat_ww_mantis_zm" && !weapon hasattachment( "sat_bar_ww_mantis" ) )
            {
                return 1;
            }
        }
    }
}

// Namespace charge_the_weapon
// Params 0, eflags: 0x4
// Checksum 0xcff701f8, Offset: 0xa59
// Size: 0x34, Type: bool
function private function_d200f9b2d5093289()
{
    current_weapon = self getcurrentweapon();
    return current_weapon.basename == "sat_ww_mantis_zm" && !current_weapon hasattachment( "sat_bar_ww_mantis" );
}

// Namespace charge_the_weapon
// Params 0, eflags: 0x4
// Checksum 0x947324cb, Offset: 0xa96
// Size: 0xdf
function private function_158023f2cec0c8c9()
{
    data = level.var_ebfb26f91bd45893.var_1e5d973acb8a3591;
    future_crafting_table = data.future_crafting_table;
    past_crafting_table = data.past_crafting_table;
    
    if ( self == future_crafting_table || !function_90d0ffa323f14e8f( past_crafting_table ) )
    {
        return;
    }
    
    if ( is_crafting_table_closed( past_crafting_table ) )
    {
        function_63a79c0666db526f( future_crafting_table );
        future_crafting_table thread close_crafting_table();
        weapon = function_bb97ccf714e57dc9( future_crafting_table );
        
        if ( weapon )
        {
            weapon function_7653c765b6c7b815();
            future_crafting_table.stored_weapon = weapon;
            data.var_3c961b0682c21834 = weapon;
            future_crafting_table setscriptablepartstate( "effects", "crafting" );
        }
        
        return;
    }
    
    function_bbe7d00dac1159b8( future_crafting_table );
    data.var_3c961b0682c21834 = undefined;
}

// Namespace charge_the_weapon
// Params 1, eflags: 0x4
// Checksum 0x43d3dd1b, Offset: 0xb7d
// Size: 0x1f0
function private function_b8be0f03e93c6706( crafting_table )
{
    weapon = self getcurrentweapon();
    
    if ( weapon.basename != "sat_ww_mantis_zm" )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    weapon_bundle = getscriptbundle( %"hash_415cacfc80d21aab" );
    weapon_info_struct = item_weapon::function_8daff85dacc00ff4( self, weapon, weapon.ammomod );
    store_node = crafting_table.store_node;
    self playsoundtoplayer( "evt_wwq_weapon_part_placed", self );
    spawn_options = common_item::function_bc5ff2958b71a708( store_node.origin, store_node.angles );
    spawn_options.weapon = weapon;
    spawn_options.weaponinfostruct = weapon_info_struct;
    spawn_options.var_8d4f327170228364 = 1;
    spawn_options.var_b8402e625c429a31 = 1;
    spawn_options.var_fd47e835523b473f = 1;
    spawn_options.var_9161cf0784b6951d = 1;
    spawn_options.var_f35b5b18b029c493 = 0;
    spawn_options.critical = 1;
    var_8a61d4195b4b6e64 = item_weapon::function_b960bc85ea91de14( weapon_bundle, spawn_options );
    var_8a61d4195b4b6e64 setscriptablepartstate( var_8a61d4195b4b6e64.type, "visible_original_position_no_stem_no_obst" );
    inventory_utility::_takeweapon( weapon );
    waitframe();
    inventory_utility::forcevalidweapon( self.primaryweapons[ 1 ] ? self.primaryweapons[ 1 ] : self.primaryweapons[ 0 ] );
    crafting_table.stored_weapon = var_8a61d4195b4b6e64;
    crafting_table.stored_weapon_info_struct = weapon_info_struct;
    crafting_table utility::ent_flag_set( "wwu_crafting_table_stored_weapon" );
    
    if ( !crafting_table.var_869d23761820eea6 )
    {
        thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_fd95bf368e8213e7", #"hash_5212ed7ec42f115a" );
        crafting_table.var_869d23761820eea6 = 1;
    }
    
    return var_8a61d4195b4b6e64;
}

// Namespace charge_the_weapon
// Params 1, eflags: 0x4
// Checksum 0xd9d849df, Offset: 0xd76
// Size: 0x234
function private function_bb97ccf714e57dc9( crafting_table )
{
    data = level.var_ebfb26f91bd45893.var_1e5d973acb8a3591;
    past_weapon_case = data.past_crafting_table;
    
    if ( !isdefined( past_weapon_case.stored_weapon ) || !isdefined( past_weapon_case.stored_weapon_info_struct ) )
    {
        assertmsg( "<dev string:x52>" );
        return;
    }
    
    weapon_bundle = getscriptbundle( %"hash_39bfecdb33df38fc" );
    var_cdb29508b5dec13b = past_weapon_case.stored_weapon_info_struct;
    store_node = crafting_table.store_node;
    playsoundatpos( store_node.origin, "evt_zm_player_craft_success" );
    spawn_options = common_item::function_bc5ff2958b71a708( store_node.origin, store_node.angles );
    spawn_options.weapon_info_struct = var_cdb29508b5dec13b;
    spawn_options.weapon_variant_id = past_weapon_case.stored_weapon.weaponobj.variantid;
    spawn_options.var_26e2b63849fb2e8f = past_weapon_case.stored_weapon.weaponobj.camo;
    spawn_options.var_8d4f327170228364 = 1;
    spawn_options.var_b8402e625c429a31 = 1;
    spawn_options.var_fd47e835523b473f = 1;
    spawn_options.var_9161cf0784b6951d = 1;
    spawn_options.var_f35b5b18b029c493 = 0;
    spawn_options.critical = 1;
    spawn_options.overridepaplvl = var_cdb29508b5dec13b.paplv;
    spawn_options.overrideammomod = var_cdb29508b5dec13b.ammomod;
    var_8a61d4195b4b6e64 = item_weapon::function_b960bc85ea91de14( weapon_bundle, spawn_options );
    var_8a61d4195b4b6e64 setscriptablepartstate( var_8a61d4195b4b6e64.type, "visible_original_position_no_stem_no_obst" );
    var_8a61d4195b4b6e64.quest_ww = 1;
    crafting_table.stored_weapon = var_8a61d4195b4b6e64;
    data.var_3c961b0682c21834 = var_8a61d4195b4b6e64;
    crafting_table utility::ent_flag_set( "wwu_crafting_table_stored_weapon" );
    return var_8a61d4195b4b6e64;
}

// Namespace charge_the_weapon
// Params 1, eflags: 0x4
// Checksum 0xc7c9ddf, Offset: 0xfb3
// Size: 0x42
function private function_bbe7d00dac1159b8( crafting_table )
{
    if ( !function_90d0ffa323f14e8f( crafting_table ) )
    {
        return;
    }
    
    crafting_table.stored_weapon freescriptable();
    crafting_table.stored_weapon_info_struct = undefined;
    crafting_table utility::ent_flag_clear( "wwu_crafting_table_stored_weapon" );
}

// Namespace charge_the_weapon
// Params 1, eflags: 0x4
// Checksum 0xfc74d3e7, Offset: 0xffd
// Size: 0x161
function private function_63a79c0666db526f( crafting_table )
{
    if ( !function_90d0ffa323f14e8f( crafting_table ) )
    {
        return;
    }
    
    stored_weapon = crafting_table.stored_weapon;
    weapon_info_struct = crafting_table.stored_weapon_info_struct;
    
    if ( !isdefined( stored_weapon ) || !isdefined( weapon_info_struct ) )
    {
        return;
    }
    
    weapon_bundle = getscriptbundle( %"hash_415cacfc80d21aab" );
    store_node = crafting_table.store_node;
    spawn_options = common_item::function_f5dfaa3bbdf99a33( crafting_table.origin + anglestoforward( crafting_table.angles ) * 70, store_node.origin );
    spawn_options.weaponinfostruct = weapon_info_struct;
    spawn_options.var_26e2b63849fb2e8f = stored_weapon.weaponobj.camo;
    spawn_options.var_fd47e835523b473f = 1;
    spawn_options.var_9161cf0784b6951d = 1;
    spawn_options.var_f35b5b18b029c493 = 0;
    spawn_options.critical = 1;
    spawn_options.overridepaplvl = weapon_info_struct.paplv;
    spawn_options.overrideammomod = weapon_info_struct.ammomod;
    item_weapon::function_b960bc85ea91de14( weapon_bundle, spawn_options );
    function_bbe7d00dac1159b8( crafting_table );
}

// Namespace charge_the_weapon
// Params 1, eflags: 0x4
// Checksum 0xb41b444d, Offset: 0x1166
// Size: 0x7e
function private function_b035882402d85e2a( params )
{
    data = level.var_ebfb26f91bd45893.var_1e5d973acb8a3591;
    past_crafting_table = data.past_crafting_table;
    
    if ( params.item == past_crafting_table.stored_weapon )
    {
        past_crafting_table.stored_weapon = undefined;
        past_crafting_table.stored_weapon_info_struct = undefined;
        past_crafting_table utility::ent_flag_clear( "wwu_crafting_table_stored_weapon" );
    }
}

// Namespace charge_the_weapon
// Params 1, eflags: 0x4
// Checksum 0xf06974a6, Offset: 0x11ec
// Size: 0xce
function private function_ffcdff3277e6f507( params )
{
    data = level.var_ebfb26f91bd45893.var_1e5d973acb8a3591;
    
    if ( params.item == data.var_3c961b0682c21834 )
    {
        data.future_crafting_table setscriptablepartstate( "base", "close_slow" );
        data.past_crafting_table setscriptablepartstate( "effects", "idle" );
        function_bbe7d00dac1159b8( data.past_crafting_table );
        utility::flag_set( "wwu_weapon_retrieved" );
        thread utility::callsharedfunc( #"intel", #"collect_intel", "zmintel_sat_mantis_artifact_2" );
        thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_c041330e8718a960", #"hash_5212ed7ec42f115a" );
    }
}

// Namespace charge_the_weapon
// Params 0
// Checksum 0x8dc725be, Offset: 0x12c2
// Size: 0x666
function function_bcdd8958faa3f63b()
{
    if ( zm_quest::is_quest_step_complete( #"hash_fceafdb93947e902", #"hash_66d91a1c9c39b198" ) )
    {
        return 0;
    }
    
    self endon( #"hash_2c4eefaf7e2b24b6" );
    utility::flag_wait( "crafting_table_setup_complete" );
    quest_data = level.var_ebfb26f91bd45893.var_1e5d973acb8a3591;
    level callback::add( #"item_weapon_drop", &register_dropped_ww );
    
    while ( !utility::flag( "wwu_weapon_retrieved" ) )
    {
        wait 1;
        
        if ( !function_25c168654be046ae() && !function_90d0ffa323f14e8f( quest_data.past_crafting_table ) )
        {
            weapon = undefined;
            
            if ( function_90d0ffa323f14e8f( quest_data.future_crafting_table ) )
            {
                weapon = quest_data.future_crafting_table.stored_weapon;
            }
            else if ( level.mantis_ww_quest.var_1e5d983acb8a37c4.var_3c961b0682c21834 )
            {
                weapon = level.mantis_ww_quest.var_1e5d983acb8a37c4.var_3c961b0682c21834;
            }
            else if ( level.var_ebfb26f91bd45893.var_1e5d973acb8a3591.dropped_weapon )
            {
                weapon = level.var_ebfb26f91bd45893.var_1e5d973acb8a3591.dropped_weapon;
            }
            else
            {
                namespace_a7211835085600d5::clear_objective_marks( #"hash_4670d9548e1da722" );
                zm_quest::clear_all_guidance();
                return;
            }
            
            thread zm_quest::update_guidance( undefined, #"hash_4670d9548e1da722", #"hash_c8a468a77c9523eb", 1 );
            namespace_a7211835085600d5::add_objective_mark( #"hash_4670d9548e1da722", weapon.origin, "wwq_mark_ww", 15, 1, { #timetravel_step:{ #future:#"hash_b81af227cc9e5ea3", #past:#"hash_912ce9702a2b6610" }, #var_7be076c9078045aa:#"hash_c8a468a77c9523eb" } );
            level waittill( #"ww_picked_up" );
        }
        else if ( !is_crafting_table_open( quest_data.past_crafting_table ) && !function_90d0ffa323f14e8f( quest_data.past_crafting_table ) )
        {
            childthread function_fece42099cc71c0();
            thread zm_quest::update_guidance( undefined, #"hash_4670d9548e1da722", #"hash_95665c00aac054e1", 1 );
            namespace_a7211835085600d5::add_objective_mark( #"hash_4670d9548e1da722", quest_data.past_crafting_table.origin, "wwq_mark_workbench", 80, 1, { #timetravel_step:{ #future:#"hash_b81af227cc9e5ea3", #past:#"hash_912ce9702a2b6610" }, #var_7be076c9078045aa:#"hash_95665c00aac054e1" } );
            utility::waittill_any_ents_return_params( quest_data.past_crafting_table, "wwu_crafting_table_opened", level, "no_player_holds_ww" );
        }
        else if ( !function_90d0ffa323f14e8f( quest_data.past_crafting_table ) )
        {
            childthread function_fece42099cc71c0();
            thread zm_quest::update_guidance( undefined, #"hash_4670d9548e1da722", #"hash_95665b00aac0532e", 1 );
            namespace_a7211835085600d5::add_objective_mark( #"hash_4670d9548e1da722", quest_data.past_crafting_table.origin, "wwq_mark_workbench", 80, 1, { #timetravel_step:{ #future:#"hash_b81af227cc9e5ea3", #past:#"hash_912ce9702a2b6610" }, #var_7be076c9078045aa:#"hash_95665b00aac0532e" } );
            utility::waittill_any_ents_return_params( quest_data.past_crafting_table, "wwu_crafting_table_stored_weapon", level, "no_player_holds_ww" );
        }
        else if ( is_crafting_table_open( quest_data.past_crafting_table ) && function_90d0ffa323f14e8f( quest_data.past_crafting_table ) )
        {
            thread zm_quest::update_guidance( undefined, #"hash_4670d9548e1da722", #"hash_c8a468a77c9523eb", 1 );
            namespace_a7211835085600d5::add_objective_mark( #"hash_4670d9548e1da722", quest_data.past_crafting_table.origin, "wwq_mark_workbench", 80, 1, { #timetravel_step:{ #future:#"hash_b81af227cc9e5ea3", #past:#"hash_912ce9702a2b6610" }, #var_7be076c9078045aa:#"hash_c8a468a77c9523eb" } );
            quest_data.past_crafting_table utility::ent_flag_waitopen_any( "wwu_crafting_table_stored_weapon" );
        }
        else if ( !quest_data.future_crafting_table utility::ent_flag( "wwu_crafting_table_opened" ) )
        {
            quest_data.past_crafting_table childthread function_2ed8737b6c524955();
            thread zm_quest::update_guidance( undefined, #"hash_4670d9548e1da722", #"hash_95665a00aac0517b", 1 );
            namespace_a7211835085600d5::add_objective_mark( #"hash_4670d9548e1da722", quest_data.future_crafting_table.origin, "wwq_mark_workbench", 80, 1, { #timetravel_step:{ #future:#"hash_b81af227cc9e5ea3", #past:#"hash_912ce9702a2b6610" }, #var_7be076c9078045aa:#"hash_95665a00aac0517b" } );
            utility::waittill_any_ents_return_params( quest_data.future_crafting_table, "wwu_crafting_table_opened", quest_data.past_crafting_table, "ww_workbench_altered" );
        }
        else if ( function_90d0ffa323f14e8f( quest_data.future_crafting_table ) && function_90d0ffa323f14e8f( quest_data.past_crafting_table ) )
        {
            quest_data.past_crafting_table childthread function_2ed8737b6c524955();
            thread zm_quest::update_guidance( undefined, #"hash_4670d9548e1da722", #"hash_95665900aac04fc8", 1 );
            namespace_a7211835085600d5::add_objective_mark( #"hash_4670d9548e1da722", quest_data.future_crafting_table.origin, "wwq_mark_workbench", 80, 1, { #timetravel_step:{ #future:#"hash_b81af227cc9e5ea3", #past:#"hash_912ce9702a2b6610" }, #var_7be076c9078045aa:#"hash_95665900aac04fc8" } );
            utility::waittill_any_ents_return_params( level, "wwu_weapon_retrieved", quest_data.past_crafting_table, "ww_workbench_altered" );
        }
        
        namespace_a7211835085600d5::clear_objective_marks( #"hash_4670d9548e1da722" );
    }
    
    namespace_a7211835085600d5::clear_objective_marks( #"hash_4670d9548e1da722" );
    zm_quest::clear_all_guidance();
    return 1;
}

// Namespace charge_the_weapon
// Params 1, eflags: 0x4
// Checksum 0x399551e0, Offset: 0x1931
// Size: 0x7b
function private register_dropped_ww( params )
{
    if ( params.objweapon && params.objweapon.basename == "sat_ww_mantis_zm" && !params.objweapon hasattachment( "sat_bar_ww_mantis" ) )
    {
        level.var_ebfb26f91bd45893.var_1e5d973acb8a3591.dropped_weapon = params.instance;
    }
}

// Namespace charge_the_weapon
// Params 0, eflags: 0xc
// Checksum 0xb3150ba, Offset: 0x19b4
// Size: 0x72
function private function_fece42099cc71c0()
{
    self notify( #"hash_26267cbe77e25c07" );
    self endon( #"hash_26267cbe77e25c07" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( !function_25c168654be046ae() && !function_90d0ffa323f14e8f( level.var_ebfb26f91bd45893.var_1e5d973acb8a3591.past_crafting_table ) )
        {
            level notify( #"no_player_holds_ww" );
        }
        
        wait 0.5;
    }
}

// Namespace charge_the_weapon
// Params 0, eflags: 0xc
// Checksum 0xdc7dd9af, Offset: 0x1a2e
// Size: 0x56
function private function_2ed8737b6c524955()
{
    self notify( #"hash_cb1cf1fae10e229c" );
    self endon( #"hash_cb1cf1fae10e229c" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( is_crafting_table_open( self ) || !function_90d0ffa323f14e8f( self ) )
        {
            self notify( #"ww_workbench_altered" );
        }
        
        wait 0.5;
    }
}

