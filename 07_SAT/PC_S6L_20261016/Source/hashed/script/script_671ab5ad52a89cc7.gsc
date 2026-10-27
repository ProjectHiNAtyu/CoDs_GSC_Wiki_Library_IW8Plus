// script_671ab5ad52a89cc7  (hash_671ab5ad52a89cc7.gscc) (size: 38529 Bytes / 0x9681 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1541fb0f (356645647)
// size ...... 38529 (0x9681)
// includes .. 24  (offset: 0x8d6d)
// strings ... 75  (offset: 0x8e2d)
// dev strs .. 77  (offset: 0x92c1)
// exports ... 100 (offset: 0x5f25)
// cseg ...... 0x5ad + 0x5978 (0x5f25)
// imports ... 245 (offset: 0x6ec5)
// animtree1 . 0   (offset: 0x9681)
// animtree2 . 0   (offset: 0x9681)
#using script_4197d8df5d4e11be;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_nexus_debug;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\activity_nexus\activity_scriptables;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\scriptable;
#using scripts\common\scriptable_door;
#using scripts\common\spatial_zone_container;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\br\gametypes\br_map_quest;
#using scripts\mp\chaff_debuff;
#using scripts\mp\common\equipment\gas_grenade;
#using scripts\mp\common\equipment\geiger_counter;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\scriptable_door_utility;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;

#namespace quest_ghost_hunt;

// Namespace quest_ghost_hunt
// Params 0, eflags: 0x5
// Checksum 0x3ec72602, Offset: 0x5cb
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mtc_ghost_hunt", #"br_map_quest", &pre_main, undefined );
}

// Namespace quest_ghost_hunt
// Params 0
// Checksum 0xd0a7ca85, Offset: 0x5f4
// Size: 0x492
function pre_main()
{
    quest = { #item_spawn_z_offset:getdvarint( @"hash_de22332d65946fcd", 15 ), #var_2ebafa62b170953c:getdvarfloat( @"hash_434dcf74a63f4e19", 4 ), #var_156d363f42beb893:getdvarfloat( @"hash_9d2c49d2e1bb845e", 0.25 ), #var_b732411d1830d18e:getdvarint( @"hash_eb74f87f34f5e3f3", 25 ), #reward_count:getdvarint( @"scr_ghost_hunt_reward_count", 6 ), #var_864cb9247f20f29b:getdvarint( @"hash_902163def4a2fc8a", 5 ), #var_2967ab9db3c53ed9:getdvarint( @"hash_a1b23437338fabea", 3 ), #var_d94f0d16c258e03e:getdvarfloat( @"hash_b62e3a09cb7d0599", 0.5 ), #var_ac1eff7e1f5843b6:getdvarfloat( @"hash_6c097f1c649a87e7", 1.5 ), #var_511bfeca818dceeb:getdvarfloat( @"hash_32c7194c9c8d0126", 0.996 ), #var_1a5efb15e88ac94c:getdvarfloat( @"hash_6eaeb7addc3a7045", 4 ), #var_976bd82bf565ac87:getdvarfloat( @"hash_aa744e1e71b7866c", 4 ), #var_442689cbd2238367:getdvarfloat( @"hash_9a08707140fa378e", 1 ), #var_6ea18ca2194d0759:getdvarfloat( @"hash_2824a04f1e99bb0c", 0.4 ), #var_a9f993f2b8c84b4d:getdvarint( @"hash_ac22ca248adb0ca8", 4 ), #var_a9d57df2b89fa033:getdvarint( @"hash_ac45e0248b0184c2", 1 ), #var_f297fdb55e5fe955:getdvarfloat( @"hash_4a2ae09075913794", 1 ), #var_c963f6359eca29d5:getdvarfloat( @"hash_bc86bdd3c09f030a", 0 ), #var_d2bd958d0471593f:getdvarint( @"hash_6d39f522b791c2f0", 25 ), #var_339ce4bd4c26ddcc:getdvarfloat( @"hash_e513165c0db55f5", 30 ), #var_2cf76b8338147b68:getdvarfloat( @"hash_c966a01cf177127d", 0.4 ), #var_6936c9367c2031d0:getdvarfloat( @"hash_cdbffed9680aeb65", 0.2 ), #var_b0ee4d4aa37f3dc6:getdvarint( @"hash_8929470bdd21864d", 250 ), #var_38d25c77d21d75ff:getdvarint( @"hash_44d0550a445c5584", 650 ), #var_dafe11358a5a3d86:getdvarfloat( @"hash_3bad81d9718f62bf", 10 ), #var_230c8cf3c1a00f1e:getdvarfloat( @"hash_5e649952a743385d", 0.275 ), #var_700625c521f1e8f9:[ "plant":"mp_saw_manticore_s6_ghost_hunt_hidden_prop_plant", "book":"mp_saw_manticore_s6_ghost_hunt_hidden_prop_book" ], #ghost_encounters:[], #var_e26bdc109d49b377:[], #var_fc99a22f27965a48:[], #var_d3b61df1ec057077:[], #on_disabled:&on_disabled, #on_infil:&on_infil, #on_prematch_end:&on_prematch_end, #on_start:&on_start, #on_precache:&on_precache, #on_init:&on_init, #name:"mtc_ghost_hunt" };
    br_map_quest::register( quest );
    activity_common::function_944074f3079c1d4e( "GHOST_HUNT", 1, &begin_activity );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &function_7730c783c0e4be5c, "GHOST_HUNT" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &player_left_activity, "GHOST_HUNT" );
    function_5a959dae78ca4ce7( &function_f545b8d9c1b6b800, 1, "Jumpscare" );
    function_5a959dae78ca4ce7( &function_e1eac18ebb047f85, 2, "Doors" );
    function_5a959dae78ca4ce7( &function_d4a67d6091123219, 2, "Gas" );
    function_5a959dae78ca4ce7( &function_144707f6619fb418, 2, "Radar" );
    function_aad80051c91fcfab( 0, &function_479db041c3bf5829, &function_ff8e1d1111f75c78, "Thermal" );
    function_aad80051c91fcfab( 1, &function_8585f86e4ff6f044, &function_6945679328cd1fb5, "Radar" );
    function_aad80051c91fcfab( 2, &function_58762eb5daac0166, &function_7f78e2b1a5b8350d, "Weapon Close" );
    function_aad80051c91fcfab( 3, &function_58762eb5daac0166, &function_7f78e2b1a5b8350d, "Weapon Far" );
    function_aad80051c91fcfab( 4, &function_58762eb5daac0166, &function_7f78e2b1a5b8350d, "Weapon Explosive" );
    var_363e920f26f79dae = 2;
    var_f72693e16b1d4a68 = [ 0 ];
    function_59d4e585c6210a( 0, var_363e920f26f79dae, var_f72693e16b1d4a68 );
    level thread setup_geiger_counter();
    precache_vfx();
    
    /#
        thread setup_devgui();
    #/
}

// Namespace quest_ghost_hunt
// Params 0, eflags: 0x4
// Checksum 0xe2bdca39, Offset: 0xa8e
// Size: 0x53
function private setup_geiger_counter()
{
    level endon( #"game_ended" );
    utility::flag_wait( "geiger_counter_initialized" );
    utility::registersharedfunc( #"geiger_counter", #"hash_436274116a37009a", &function_44c17375f1fe650c );
    geiger_counter::function_1a05f0abe89e076e( 2500 );
    geiger_counter::function_bf789e175884e11c( "geiger_counter", "equip_emf_reader" );
}

// Namespace quest_ghost_hunt
// Params 3, eflags: 0x4
// Checksum 0xc2fc915d, Offset: 0xae9
// Size: 0x97
function private function_5a959dae78ca4ce7( encounter_func, var_363e920f26f79dae = 0, name = "Unknown" )
{
    quest = br_map_quest::get_quest( "mtc_ghost_hunt" );
    
    if ( quest )
    {
        ghost_encounter_struct = { #var_5d14e086aa7bf6ae:var_363e920f26f79dae, #func:encounter_func };
        quest.ghost_encounters[ quest.ghost_encounters.size ] = ghost_encounter_struct;
    }
    
    /#
        function_9b958be0688c30c4( name, encounter_func );
    #/
}

// Namespace quest_ghost_hunt
// Params 4, eflags: 0x4
// Checksum 0xc222e2da, Offset: 0xb88
// Size: 0x97
function private function_aad80051c91fcfab( type, var_867dfc6deb54546c, var_c1ba54ed6ffcc6c7, name = "Unknown" )
{
    quest = br_map_quest::get_quest( "mtc_ghost_hunt" );
    
    if ( quest )
    {
        var_71c8d030ddd4a99 = { #name:name, #deactivate_func:var_c1ba54ed6ffcc6c7, #activate_func:var_867dfc6deb54546c };
        quest.ghost_evidence[ type ] = var_71c8d030ddd4a99;
    }
    
    /#
        function_8e8c50a03afc1c74( name );
    #/
}

// Namespace quest_ghost_hunt
// Params 3, eflags: 0x4
// Checksum 0xb52270c, Offset: 0xc27
// Size: 0x7e
function private function_59d4e585c6210a( type, var_363e920f26f79dae, evidence_list = [] )
{
    quest = br_map_quest::get_quest( "mtc_ghost_hunt" );
    
    if ( quest )
    {
        ghost_type_struct = { #evidence_list:evidence_list, #var_5d14e086aa7bf6ae:var_363e920f26f79dae, #type:type };
        quest.var_e26bdc109d49b377[ type ] = ghost_type_struct;
    }
}

// Namespace quest_ghost_hunt
// Params 0, eflags: 0x4
// Checksum 0x993c2935, Offset: 0xcad
// Size: 0xb7
function private function_d40f38c472fcff5e()
{
    if ( isarray( self.var_d3b61df1ec057077 ) && self.var_d3b61df1ec057077.size > 0 )
    {
        var_275536255832038f = getdvar( @"hash_ae2f4979b3ca8ccf", "" );
        
        if ( var_275536255832038f != "" )
        {
            for ( i = 0; i < self.var_d3b61df1ec057077.size ; i++ )
            {
                variant_tag = getarraykey( self.var_d3b61df1ec057077, i );
                
                if ( variant_tag == var_275536255832038f )
                {
                    return variant_tag;
                }
            }
        }
        
        random_variant_tag = getarraykey( self.var_d3b61df1ec057077, randomint( self.var_d3b61df1ec057077.size ) );
        return random_variant_tag;
    }
}

// Namespace quest_ghost_hunt
// Params 0
// Checksum 0x65654dca, Offset: 0xd6c
// Size: 0x2
function on_init()
{
    
}

// Namespace quest_ghost_hunt
// Params 0
// Checksum 0x28ef9817, Offset: 0xd76
// Size: 0x2
function on_precache()
{
    
}

// Namespace quest_ghost_hunt
// Params 0
// Checksum 0x8a0affd5, Offset: 0xd80
// Size: 0x9
function on_start()
{
    thread create_activity();
}

// Namespace quest_ghost_hunt
// Params 0
// Checksum 0x15d23da7, Offset: 0xd91
// Size: 0x2
function on_prematch_end()
{
    
}

// Namespace quest_ghost_hunt
// Params 0
// Checksum 0x53789c07, Offset: 0xd9b
// Size: 0x2
function on_infil()
{
    
}

// Namespace quest_ghost_hunt
// Params 0
// Checksum 0xc1c87b1c, Offset: 0xda5
// Size: 0x2
function on_disabled()
{
    
}

// Namespace quest_ghost_hunt
// Params 0, eflags: 0x4
// Checksum 0xfd93f9ff, Offset: 0xdaf
// Size: 0x48f
function private create_activity()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "activity_map_data_cached" );
    self.var_d3b61df1ec057077 = activity_definition_utils::function_326a5e04c9b438f5( "GHOST_HUNT" );
    selected_variant_name = function_d40f38c472fcff5e();
    
    if ( !selected_variant_name )
    {
        assert( selected_variant_name, "<dev string:x24>" );
        return;
    }
    
    self.activity_instance = activity_instance_common::createactivityinstance( "GHOST_HUNT", selected_variant_name );
    self.activity_instance.var_c7966171ba17ce9c = activity_instance_common::function_245ea339f8da9fdf( self.activity_instance );
    self.activity_instance.var_b0b03d23c4bc231f = [];
    self.activity_instance.emf_spawn_struct = undefined;
    self.activity_instance.var_6751dd2a3da6b6c3 = [];
    
    foreach ( map_struct in self.activity_instance.var_c7966171ba17ce9c )
    {
        if ( map_struct.targetname == "haunt" )
        {
            [ haunt_volume ] = getnoentvolumearray( map_struct.target, #targetname );
            nearby_doors = [];
            
            if ( int( map_struct.doors ) )
            {
                nearby_doors = scriptable_door_utility::scriptable_door_get_in_radius( map_struct.origin, self.var_38d25c77d21d75ff, self.var_b0ee4d4aa37f3dc6 );
            }
            
            haunt_linked_structs = utility::getstructarray( map_struct.target, "targetname" );
            var_6a7ea76ddc979330 = [];
            
            foreach ( haunt_linked_struct in haunt_linked_structs )
            {
                if ( haunt_linked_struct.script_noteworthy == "thermal" )
                {
                    reward_struct = utility::getstruct( haunt_linked_struct.target, "targetname" );
                    
                    if ( reward_struct )
                    {
                        haunt_linked_struct.var_ed2431ff5fd3b5d8 = reward_struct.origin;
                    }
                    
                    var_6a7ea76ddc979330 = arraycombineunique( var_6a7ea76ddc979330, [ haunt_linked_struct ] );
                }
            }
            
            haunt_info_struct = { #var_72b76ffa75a8a3aa:undefined, #var_6a7ea76ddc979330:var_6a7ea76ddc979330, #doors:nearby_doors, #volume:haunt_volume, #origin:map_struct.origin };
            self.activity_instance.var_b0b03d23c4bc231f = arraycombineunique( self.activity_instance.var_b0b03d23c4bc231f, [ haunt_info_struct ] );
            continue;
        }
        
        if ( map_struct.targetname == "emf_spawn" )
        {
            assert( !self.activity_instance.emf_spawn_struct, "<dev string:x6d>" );
            self.activity_instance.emf_spawn_struct = map_struct;
            continue;
        }
        
        if ( map_struct.targetname == "thermal_weapon_spawn" )
        {
            self.activity_instance.thermal_weapon_spawn_struct = map_struct;
        }
    }
    
    if ( isarray( self.activity_instance.var_b0b03d23c4bc231f ) && self.activity_instance.var_b0b03d23c4bc231f.size > 0 )
    {
        utility::flag_set( "haunt_structs_initialized" );
    }
    
    self.activity_instance.var_8f3f45e46073ab37 = self.activity_instance.var_b0b03d23c4bc231f;
    spawn_options = common_item::function_bc5ff2958b71a708( self.activity_instance.emf_spawn_struct.origin, self.activity_instance.emf_spawn_struct.angles );
    common_item::function_325e28c0fb65c36a( "equip_emf_reader", 1, spawn_options );
    scriptable::scriptable_addusedcallback( &function_9837a73d9f6c0b62 );
    self.activity_instance thread function_98d47cd5be8d0ce();
}

// Namespace quest_ghost_hunt
// Params 0, eflags: 0x4
// Checksum 0xfbc043aa, Offset: 0x1246
// Size: 0x106
function private begin_activity()
{
    quest = br_map_quest::get_quest( "mtc_ghost_hunt" );
    spatial_zone_container::function_3b687b8681411c9f( self, "EMF_ZONE", &function_a0af5e1aa94310ae, 1 );
    var_ea54c0ab42a167ca = activity_instance_common::function_776ee11e7acc64a5( self );
    self.ghost_ent = utility::spawn_model( "tag_origin", var_ea54c0ab42a167ca );
    self.ghost_ent.definition = utility::array_random( quest.var_e26bdc109d49b377 );
    self.ghost_ent.team = "team_hundred_ninety_nine";
    self.ghost_ent setcandamage( 0 );
    self.evidence_collected = [];
    level thread function_b2edcc660673297a();
    level callback::add( #"killstreak_begin_use", &function_ea2000fd7335950a );
    level callback::add( #"killstreak_finish_use", &on_player_killstreak_finish_use );
    self.var_c8492f97a6a90db9 = [];
    
    /#
        level thread function_1855c5e219661fcd( self );
        level thread function_509670c0108f23bb( self );
        level thread function_bac0d8eee008beb7();
    #/
}

// Namespace quest_ghost_hunt
// Params 0, eflags: 0x4
// Checksum 0x60d8253, Offset: 0x1354
// Size: 0x8d
function private function_41b960ce7807481d()
{
    quest = br_map_quest::get_quest( "mtc_ghost_hunt" );
    
    if ( self.current_haunt )
    {
        function_c4253dcf6b6eca56();
    }
    
    spawn_rewards( self.reward_scriptable );
    spatial_zone_container::function_4f9fccd04a537897( self, "EMF_ZONE" );
    level callback::remove( #"killstreak_begin_use", &function_ea2000fd7335950a );
    level callback::remove( #"killstreak_finish_use", &on_player_killstreak_finish_use );
    self.ghost_ent delete();
    activity_instance_common::endactivity( self, 1 );
}

// Namespace quest_ghost_hunt
// Params 1
// Checksum 0xb81bc54d, Offset: 0x13e9
// Size: 0xe6
function function_7730c783c0e4be5c( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    
    foreach ( player in player_list )
    {
        player callback::add( #"hash_474490f7ce8b74d0", &function_b91eb8fc0e0a49bf );
        player callback::add( #"grenade_fire", &function_eb5ecbbe1e5ebdbf );
        player callback::add( #"player_offhand_pullback", &function_9229a8d5908b95f8 );
        player callback::add( #"equipment_use", &function_f33dfb3098e8a9d0 );
    }
}

// Namespace quest_ghost_hunt
// Params 1
// Checksum 0x45e462ca, Offset: 0x14d7
// Size: 0x190
function player_left_activity( relevant_info_struct )
{
    quest = br_map_quest::get_quest( "mtc_ghost_hunt" );
    player_list = relevant_info_struct.playerlist;
    
    foreach ( player in player_list )
    {
        player callback::remove( #"hash_474490f7ce8b74d0", &function_b91eb8fc0e0a49bf );
        player callback::remove( #"grenade_fire", &function_eb5ecbbe1e5ebdbf );
        player callback::remove( #"player_offhand_pullback", &function_9229a8d5908b95f8 );
        player callback::remove( #"equipment_use", &function_f33dfb3098e8a9d0 );
        
        if ( isdefined( quest.activity_instance.var_c8492f97a6a90db9[ player.guid ] ) && quest.activity_instance.var_c8492f97a6a90db9[ player.guid ].enabled )
        {
            player chaff_debuff::function_c1fa63136ba5a433( quest.var_864cb9247f20f29b );
            quest.activity_instance.var_c8492f97a6a90db9[ player.guid ].enabled = 0;
        }
    }
}

// Namespace quest_ghost_hunt
// Params 0, eflags: 0x4
// Checksum 0x2717bd6e, Offset: 0x166f
// Size: 0x181
function private function_c4253dcf6b6eca56()
{
    quest = br_map_quest::get_quest( "mtc_ghost_hunt" );
    
    if ( quest.activity_instance.current_haunt )
    {
        level thread function_5b33be45ff63273f( quest.activity_instance.current_haunt );
        quest.activity_instance.previous_haunt = quest.activity_instance.current_haunt;
        utility::delaythread( 0.5, &geiger_counter::function_54886797fcd30128, quest.activity_instance.current_haunt );
        
        foreach ( player in quest.activity_instance.previous_haunt.var_50a88292323ed49 )
        {
            level thread function_5cfce4d50702d001( player );
        }
        
        quest.activity_instance.previous_haunt.var_50a88292323ed49 = [];
        level thread function_7d83e0550683b300();
        quest.activity_instance.current_haunt = undefined;
    }
    
    quest.activity_instance notify( #"hash_f5ad1aa46dd744ac" );
}

// Namespace quest_ghost_hunt
// Params 1, eflags: 0x4
// Checksum 0xf6d17ac9, Offset: 0x17f8
// Size: 0xb4
function private function_5b33be45ff63273f( haunt_location_struct )
{
    foreach ( door in haunt_location_struct.doors )
    {
        if ( scriptable_door::isscriptabledoor( door ) )
        {
            random_delay_sec = randomfloatrange( 0, 0.5 );
            haunt_location_struct utility::delaythread( random_delay_sec, &scriptable_door::scriptabledoor_open, door, 1 );
        }
    }
}

// Namespace quest_ghost_hunt
// Params 1, eflags: 0x4
// Checksum 0x49b72812, Offset: 0x18b4
// Size: 0xb2
function private function_75277d8cfd2c4a33( haunt_location_struct )
{
    foreach ( door in haunt_location_struct.doors )
    {
        if ( scriptable_door::isscriptabledoor( door ) )
        {
            random_delay_sec = randomfloatrange( 0, 0.5 );
            haunt_location_struct utility::delaythread( random_delay_sec, &scriptable_door::scriptabledoor_close, door );
        }
    }
}

// Namespace quest_ghost_hunt
// Params 0, eflags: 0x4
// Checksum 0xcb90e10d, Offset: 0x196e
// Size: 0x164
function private function_b2edcc660673297a()
{
    quest = br_map_quest::get_quest( "mtc_ghost_hunt" );
    var_91e9b298e99df720 = quest.activity_instance && activity_instance_common::getactivitystate( quest.activity_instance ) == "Active";
    
    if ( var_91e9b298e99df720 )
    {
        var_4ad1b449f1662bf4 = [];
        
        foreach ( haunt_struct in quest.activity_instance.var_b0b03d23c4bc231f )
        {
            if ( haunt_struct != quest.activity_instance.previous_haunt )
            {
                var_4ad1b449f1662bf4[ var_4ad1b449f1662bf4.size ] = haunt_struct;
            }
        }
        
        quest.activity_instance.current_haunt = utility::array_random( var_4ad1b449f1662bf4 );
        geiger_counter::function_69cfcbb5ee5bfc98( quest.activity_instance.current_haunt );
        level thread function_2dbefc64dc7c5f06();
        level thread function_93a6a936ce2e7411();
        level thread function_f2fe459a81c2baaf();
        level thread function_75277d8cfd2c4a33( quest.activity_instance.current_haunt );
    }
}

// Namespace quest_ghost_hunt
// Params 0, eflags: 0x4
// Checksum 0xb1e073f4, Offset: 0x1ada
// Size: 0x6c
function private function_3eadd50bd5e3381d()
{
    quest = br_map_quest::get_quest( "mtc_ghost_hunt" );
    var_91e9b298e99df720 = quest.activity_instance && activity_instance_common::getactivitystate( quest.activity_instance ) == "Active";
    
    if ( var_91e9b298e99df720 )
    {
        function_c4253dcf6b6eca56();
        utility::delaythread( quest.var_dafe11358a5a3d86, &function_b2edcc660673297a );
    }
}

// Namespace quest_ghost_hunt
// Params 0, eflags: 0xc
// Checksum 0x5d64041, Offset: 0x1b4e
// Size: 0x279
function private function_2dbefc64dc7c5f06()
{
    self notify( #"hash_febb2a650151c646" );
    self endon( #"hash_febb2a650151c646" );
    quest = br_map_quest::get_quest( "mtc_ghost_hunt" );
    activity_instance = quest.activity_instance;
    level endon( #"game_ended" );
    activity_instance endon( #"hash_f5ad1aa46dd744ac" );
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( quest.activity_instance.current_haunt )
    {
        quest.activity_instance.current_haunt.var_50a88292323ed49 = [];
    }
    
    while ( quest.activity_instance.current_haunt )
    {
        volume = quest.activity_instance.current_haunt.volume;
        var_9fd3c719da675a79 = activity_instance.playerparticipants;
        
        foreach ( player in var_9fd3c719da675a79 )
        {
            if ( ispointinvolume( player.origin, volume ) )
            {
                if ( !quest.activity_instance.current_haunt.var_50a88292323ed49[ player.guid ] )
                {
                    level thread function_60429f2a795293df( player );
                }
                
                quest.activity_instance.current_haunt.var_50a88292323ed49[ player.guid ] = player;
                continue;
            }
            
            if ( quest.activity_instance.current_haunt.var_50a88292323ed49[ player.guid ] )
            {
                level thread function_5cfce4d50702d001( player );
                quest.activity_instance.current_haunt.var_50a88292323ed49 = arrayremove( quest.activity_instance.current_haunt.var_50a88292323ed49, player );
            }
        }
        
        wait quest.var_6936c9367c2031d0;
    }
}

// Namespace quest_ghost_hunt
// Params 1, eflags: 0x4
// Checksum 0xf40ef2fb, Offset: 0x1dcf
// Size: 0x49
function private function_60429f2a795293df( player )
{
    level notify( #"hash_ecc3602650d2c2c6", player );
    level notify( #"player_haunt_volume_state_updated", player );
    pbgpostfxbundlestart( player, "saw_pbg_ghost_hunt_nearby" );
    player setsoundsubmix( "saw_manticore_s6_ghost_hunt_room_darken" );
    player thread function_dda0005f3f27492d();
}

// Namespace quest_ghost_hunt
// Params 1, eflags: 0x4
// Checksum 0xd3e1b3a1, Offset: 0x1e20
// Size: 0x40
function private function_5cfce4d50702d001( player )
{
    level notify( #"hash_e663022b74af74de", player );
    level notify( #"player_haunt_volume_state_updated", player );
    pbgpostfxbundleend( player, "saw_pbg_ghost_hunt_nearby" );
    player clearsoundsubmix( "saw_manticore_s6_ghost_hunt_room_darken" );
}

// Namespace quest_ghost_hunt
// Params 0, eflags: 0x4
// Checksum 0x47e054c5, Offset: 0x1e68
// Size: 0x31
function private function_dda0005f3f27492d()
{
    self endon( #"player_haunt_volume_state_updated" );
    level waittill( #"game_ended" );
    pbgpostfxbundleend( self, "saw_pbg_ghost_hunt_nearby" );
    self clearsoundsubmix( "saw_manticore_s6_ghost_hunt_room_darken" );
}

// Namespace quest_ghost_hunt
// Params 1, eflags: 0x4
// Checksum 0x849634f4, Offset: 0x1ea1
// Size: 0x164
function private function_f6cb177de46abd75( var_eca66541988ca3ca = undefined )
{
    quest = br_map_quest::get_quest( "mtc_ghost_hunt" );
    activity_instance = quest.activity_instance;
    level endon( #"game_ended" );
    activity_instance endon( #"hash_f5ad1aa46dd744ac" );
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( quest.activity_instance.current_haunt )
    {
        var_5acb3a00da9eee60 = var_eca66541988ca3ca ?? function_3d4558de504d1f4f();
        
        if ( var_5acb3a00da9eee60 )
        {
            foreach ( player in quest.activity_instance.current_haunt.var_50a88292323ed49 )
            {
                level thread function_c70f6cd2bc9151fa( player, "saw_pbg_ghost_hunt_intense", quest.var_2cf76b8338147b68 );
            }
            
            wait quest.var_2cf76b8338147b68;
            [[ var_5acb3a00da9eee60 ]]();
            return;
        }
        
        assertmsg( "<dev string:xd2>" );
    }
}

// Namespace quest_ghost_hunt
// Params 0, eflags: 0x4
// Checksum 0xa70f688a, Offset: 0x200d
// Size: 0xfb
function private function_3d4558de504d1f4f()
{
    quest = br_map_quest::get_quest( "mtc_ghost_hunt" );
    var_7817de6f6ec5edde = quest.activity_instance.ghost_ent.definition;
    var_338dfb58739b521f = [];
    
    if ( quest && var_7817de6f6ec5edde )
    {
        foreach ( var_f53b9668ae989029 in quest.ghost_encounters )
        {
            if ( var_f53b9668ae989029.var_5d14e086aa7bf6ae == var_7817de6f6ec5edde.var_5d14e086aa7bf6ae )
            {
                var_338dfb58739b521f[ var_338dfb58739b521f.size ] = var_f53b9668ae989029.func;
            }
        }
    }
    
    return utility::array_random( var_338dfb58739b521f );
}

// Namespace quest_ghost_hunt
// Params 0, eflags: 0xc
// Checksum 0xa3a6d2b5, Offset: 0x2111
// Size: 0x18d
function private function_f2fe459a81c2baaf()
{
    self notify( #"hash_40927c1c6501c63b" );
    self endon( #"hash_40927c1c6501c63b" );
    quest = br_map_quest::get_quest( "mtc_ghost_hunt" );
    activity_instance = quest.activity_instance;
    level endon( #"game_ended" );
    activity_instance endon( #"hash_f5ad1aa46dd744ac" );
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    while ( quest.activity_instance.current_haunt.var_50a88292323ed49.size == 0 )
    {
        waitframe();
    }
    
    hunt_start_time_ms = gettime();
    current_time_ms = hunt_start_time_ms;
    var_de655c34197c468b = hunt_start_time_ms + quest.var_339ce4bd4c26ddcc * 1000 / 2;
    hunt_end_time_ms = hunt_start_time_ms + quest.var_339ce4bd4c26ddcc * 1000;
    var_d07db77741b82b8d = 0;
    
    while ( quest.activity_instance.current_haunt && current_time_ms < hunt_end_time_ms )
    {
        current_time_ms = gettime();
        
        if ( current_time_ms >= var_de655c34197c468b && !var_d07db77741b82b8d )
        {
            thermal_scriptable = activity_instance.var_72b76ffa75a8a3aa;
            
            if ( thermal_scriptable )
            {
                thermal_scriptable setscriptablepartstate( #"ghost", #"encounter" );
            }
            
            level thread function_f6cb177de46abd75();
            var_d07db77741b82b8d = 1;
        }
        
        waitframe();
    }
    
    function_f6cb177de46abd75( &function_f545b8d9c1b6b800 );
    level thread function_3eadd50bd5e3381d();
}

// Namespace quest_ghost_hunt
// Params 0, eflags: 0x4
// Checksum 0x3d50b108, Offset: 0x22a6
// Size: 0xed
function private function_f545b8d9c1b6b800()
{
    quest = br_map_quest::get_quest( "mtc_ghost_hunt" );
    activity_instance = quest.activity_instance;
    participating_players = activity_instance.playerparticipants;
    
    foreach ( player in participating_players )
    {
        if ( quest.activity_instance.current_haunt.var_50a88292323ed49[ player.guid ] )
        {
            player thread namespace_8feb0d461816c715::perform_jump_scare();
        }
    }
    
    wait quest.var_f297fdb55e5fe955;
}

// Namespace quest_ghost_hunt
// Params 0, eflags: 0x4
// Checksum 0x7d6a539d, Offset: 0x239b
// Size: 0xaa
function private function_d4a67d6091123219()
{
    quest = br_map_quest::get_quest( "mtc_ghost_hunt" );
    activity_instance = quest.activity_instance;
    haunt_origin = quest.activity_instance.current_haunt.origin;
    level thread gas_grenade::gas_createtrigger( haunt_origin, activity_instance.ghost_ent, activity_instance.ghost_ent.team, quest.var_976bd82bf565ac87, 1, 0, undefined, quest.var_38d25c77d21d75ff, quest.var_b0ee4d4aa37f3dc6, 0 );
}

// Namespace quest_ghost_hunt
// Params 0, eflags: 0x4
// Checksum 0x523750e2, Offset: 0x244d
// Size: 0x18e
function private function_144707f6619fb418()
{
    quest = br_map_quest::get_quest( "mtc_ghost_hunt" );
    activity_instance = quest.activity_instance;
    participating_players = activity_instance.playerparticipants;
    
    foreach ( player in participating_players )
    {
        if ( quest.activity_instance.current_haunt.var_50a88292323ed49[ player.guid ] )
        {
            if ( !isdefined( quest.activity_instance.var_c8492f97a6a90db9[ player.guid ] ) )
            {
                quest.activity_instance.var_c8492f97a6a90db9[ player.guid ] = { #enabled:0, #var_78f0f63e7166815b:0 };
            }
            
            player chaff_debuff::function_f966e23bd8f1adb5( quest.var_864cb9247f20f29b );
            quest.activity_instance.var_c8492f97a6a90db9[ player.guid ].enabled = 1;
        }
    }
    
    utility::delaythread( quest.var_1a5efb15e88ac94c, &function_1a01b1107f6230ea, participating_players );
}

// Namespace quest_ghost_hunt
// Params 1, eflags: 0x4
// Checksum 0x730208b, Offset: 0x25e3
// Size: 0x124
function private function_1a01b1107f6230ea( player_list )
{
    quest = br_map_quest::get_quest( "mtc_ghost_hunt" );
    
    foreach ( player in player_list )
    {
        if ( player )
        {
            if ( isdefined( quest.activity_instance.var_c8492f97a6a90db9[ player.guid ] ) && quest.activity_instance.var_c8492f97a6a90db9[ player.guid ].enabled )
            {
                player chaff_debuff::function_c1fa63136ba5a433( quest.var_864cb9247f20f29b );
                quest.activity_instance.var_c8492f97a6a90db9[ player.guid ].enabled = 0;
            }
        }
    }
}

// Namespace quest_ghost_hunt
// Params 0, eflags: 0x4
// Checksum 0x1866b04, Offset: 0x270f
// Size: 0x11b
function private function_e1eac18ebb047f85()
{
    quest = br_map_quest::get_quest( "mtc_ghost_hunt" );
    activity_instance = quest.activity_instance;
    level endon( #"game_ended" );
    activity_instance endon( #"hash_f5ad1aa46dd744ac" );
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    var_4f62fe081e2283c7 = randomintrange( quest.var_a9d57df2b89fa033, quest.var_a9f993f2b8c84b4d );
    
    for ( i = 0; i < var_4f62fe081e2283c7 ; i++ )
    {
        function_5b33be45ff63273f( quest.activity_instance.current_haunt );
        random_delay_sec = randomfloatrange( quest.var_6ea18ca2194d0759, quest.var_442689cbd2238367 );
        wait random_delay_sec;
        function_75277d8cfd2c4a33( quest.activity_instance.current_haunt );
        random_delay_sec = randomfloatrange( quest.var_6ea18ca2194d0759, quest.var_442689cbd2238367 );
        wait random_delay_sec;
    }
}

// Namespace quest_ghost_hunt
// Params 0, eflags: 0x4
// Checksum 0x1658df, Offset: 0x2832
// Size: 0xdf
function private function_93a6a936ce2e7411()
{
    quest = br_map_quest::get_quest( "mtc_ghost_hunt" );
    evidence_list = quest.activity_instance.ghost_ent.definition.evidence_list;
    
    if ( evidence_list )
    {
        foreach ( evidence_type in evidence_list )
        {
            evidence_struct = quest.ghost_evidence[ evidence_type ];
            level thread [[ evidence_struct.activate_func ]]();
        }
    }
}

// Namespace quest_ghost_hunt
// Params 0, eflags: 0x4
// Checksum 0x437596dc, Offset: 0x2919
// Size: 0xdf
function private function_7d83e0550683b300()
{
    quest = br_map_quest::get_quest( "mtc_ghost_hunt" );
    evidence_list = quest.activity_instance.ghost_ent.definition.evidence_list;
    
    if ( evidence_list )
    {
        foreach ( evidence_type in evidence_list )
        {
            evidence_struct = quest.ghost_evidence[ evidence_type ];
            level thread [[ evidence_struct.deactivate_func ]]();
        }
    }
}

// Namespace quest_ghost_hunt
// Params 1, eflags: 0x4
// Checksum 0x9fe6ce1e, Offset: 0x2a00
// Size: 0x71, Type: bool
function private function_6bac655c0c4e7df1( evidence_type )
{
    quest = br_map_quest::get_quest( "mtc_ghost_hunt" );
    evidence_list = quest.activity_instance.ghost_ent.definition.evidence_list;
    
    if ( evidence_list )
    {
        found_index = function_f02c63b99c9614c9( evidence_list, evidence_type );
        return isdefined( found_index );
    }
    
    return false;
}

// Namespace quest_ghost_hunt
// Params 0, eflags: 0x4
// Checksum 0x89c6f8e9, Offset: 0x2a7a
// Size: 0x2
function private function_58762eb5daac0166()
{
    
}

// Namespace quest_ghost_hunt
// Params 0, eflags: 0x4
// Checksum 0xaf224756, Offset: 0x2a84
// Size: 0x2
function private function_7f78e2b1a5b8350d()
{
    
}

// Namespace quest_ghost_hunt
// Params 0, eflags: 0x4
// Checksum 0x247cb6c4, Offset: 0x2a8e
// Size: 0x1e4
function private function_479db041c3bf5829()
{
    quest = br_map_quest::get_quest( "mtc_ghost_hunt" );
    
    if ( quest.activity_instance.current_haunt )
    {
        quest.activity_instance.var_72b76ffa75a8a3aa = quest.activity_instance.current_haunt.thermal_scriptable;
        
        if ( !quest.activity_instance.var_72b76ffa75a8a3aa )
        {
            var_cf84ff78243cc35b = utility::array_random( quest.activity_instance.current_haunt.var_6a7ea76ddc979330 );
            var_c112c5a3e30cc7b0 = quest.var_700625c521f1e8f9[ var_cf84ff78243cc35b.prop_type ];
            quest.activity_instance.var_72b76ffa75a8a3aa = spawnscriptable( var_c112c5a3e30cc7b0, var_cf84ff78243cc35b.origin, var_cf84ff78243cc35b.angles );
            activity_scriptables::function_114d59757e8d7bd9( quest.activity_instance, quest.activity_instance.var_72b76ffa75a8a3aa, "InstanceEnd" );
            quest.activity_instance.current_haunt.thermal_scriptable = quest.activity_instance.var_72b76ffa75a8a3aa;
            quest.activity_instance.var_72b76ffa75a8a3aa.associated_struct = var_cf84ff78243cc35b;
        }
        
        if ( quest.activity_instance.var_72b76ffa75a8a3aa )
        {
            quest.activity_instance.var_72b76ffa75a8a3aa setscriptablepartstate( #"base", #"haunted" );
            quest.activity_instance.var_72b76ffa75a8a3aa thread function_19eb45ec779fd218();
        }
    }
}

// Namespace quest_ghost_hunt
// Params 0, eflags: 0x4
// Checksum 0xaa1bb9bc, Offset: 0x2c7a
// Size: 0x91
function private function_ff8e1d1111f75c78()
{
    quest = br_map_quest::get_quest( "mtc_ghost_hunt" );
    thermal_scriptable = quest.activity_instance.var_72b76ffa75a8a3aa;
    
    if ( thermal_scriptable )
    {
        thermal_scriptable setscriptablepartstate( #"base", #"normal" );
        thermal_scriptable setscriptablepartstate( #"ghost", #"fail" );
        thermal_scriptable notify( #"evidence_deactivated" );
    }
    
    quest.activity_instance.var_72b76ffa75a8a3aa = undefined;
}

// Namespace quest_ghost_hunt
// Params 0, eflags: 0xc
// Checksum 0x3629e55c, Offset: 0x2d13
// Size: 0x2ae
function private function_19eb45ec779fd218()
{
    self notify( #"hash_4905b1449226fae6" );
    self endon( #"hash_4905b1449226fae6" );
    self endon( #"death", #"entitydeleted" );
    self endon( #"evidence_deactivated" );
    quest = br_map_quest::get_quest( "mtc_ghost_hunt" );
    activity_instance = quest.activity_instance;
    level endon( #"game_ended" );
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance.var_ee3a307dab7558cf = [];
    current_time_sec = gettime() * 0.001;
    previous_time_sec = current_time_sec;
    
    while ( true )
    {
        previous_time_sec = current_time_sec;
        current_time_sec = gettime() * 0.001;
        time_diff_sec = current_time_sec - previous_time_sec;
        participating_players = activity_instance.playerparticipants;
        
        foreach ( player in participating_players )
        {
            var_14bdc6a7d083a0dc = function_5b322610717823ce( player );
            
            if ( var_14bdc6a7d083a0dc.active )
            {
                player_forward = anglestoforward( player getplayerangles() );
                scriptable_dir = vectornormalize( self.origin - var_14bdc6a7d083a0dc.origin );
                dot = vectordot( player_forward, scriptable_dir );
                
                if ( dot >= quest.var_511bfeca818dceeb )
                {
                    if ( !isdefined( activity_instance.var_ee3a307dab7558cf[ player.guid ] ) )
                    {
                        activity_instance.var_ee3a307dab7558cf[ player.guid ] = 0;
                    }
                    
                    activity_instance.var_ee3a307dab7558cf[ player.guid ] += time_diff_sec;
                    
                    if ( activity_instance.var_ee3a307dab7558cf[ player.guid ] >= quest.var_ac1eff7e1f5843b6 )
                    {
                        player points::doscoreevent( #"hash_4f96be0fcf302915" );
                        level thread function_a954ecb622f042b4();
                        return;
                    }
                    
                    player earthquakeforplayer( 0.065, 1.25, player.origin, 100 );
                }
            }
        }
        
        wait quest.var_d94f0d16c258e03e;
    }
}

// Namespace quest_ghost_hunt
// Params 1, eflags: 0x4
// Checksum 0x2c5153e2, Offset: 0x2fc9
// Size: 0xff
function private function_5b322610717823ce( player )
{
    quest = br_map_quest::get_quest( "mtc_ghost_hunt" );
    primary_weapon = player getcurrentprimaryweapon();
    
    if ( isweapon( primary_weapon ) && function_a805442a733c54db( primary_weapon ) && player playerads() == 1 )
    {
        if ( quest.activity_instance.current_haunt.var_50a88292323ed49[ player.guid ] )
        {
            return { #origin:player getvieworigin(), #active:1 };
        }
    }
    else if ( player utility::isusingremote() )
    {
        drone = player.vehicle;
        
        if ( isdefined( drone ) && drone.isthermalenabled === 1 )
        {
            return { #origin:player getvieworigin(), #active:1 };
        }
    }
    
    return { #active:0 };
}

// Namespace quest_ghost_hunt
// Params 0, eflags: 0x4
// Checksum 0x64f37897, Offset: 0x30d1
// Size: 0x18d
function private function_a954ecb622f042b4()
{
    quest = br_map_quest::get_quest( "mtc_ghost_hunt" );
    activity_instance = quest.activity_instance;
    
    if ( !isdefined( activity_instance.evidence_collected[ 0 ] ) )
    {
        activity_instance.evidence_collected[ 0 ] = 0;
    }
    
    activity_instance.evidence_collected[ 0 ]++;
    
    if ( quest.activity_instance.current_haunt )
    {
        quest.activity_instance.var_b0b03d23c4bc231f = arrayremove( quest.activity_instance.var_b0b03d23c4bc231f, quest.activity_instance.current_haunt );
    }
    
    if ( activity_instance.evidence_collected[ 0 ] >= quest.var_2967ab9db3c53ed9 )
    {
        activity_instance.reward_scriptable = quest.activity_instance.var_72b76ffa75a8a3aa;
        activity_instance thread function_41b960ce7807481d();
        return;
    }
    
    if ( quest.activity_instance.var_72b76ffa75a8a3aa )
    {
        quest.activity_instance.var_72b76ffa75a8a3aa setscriptablepartstate( #"base", #"found" );
        quest.activity_instance.var_72b76ffa75a8a3aa setscriptablepartstate( #"ghost", #"success" );
        quest.activity_instance.var_72b76ffa75a8a3aa = undefined;
    }
    
    level thread function_3eadd50bd5e3381d();
}

// Namespace quest_ghost_hunt
// Params 0, eflags: 0x4
// Checksum 0x5ead0c88, Offset: 0x3266
// Size: 0xa
function private function_8585f86e4ff6f044()
{
    level thread function_d25d64b37ea9dae9();
}

// Namespace quest_ghost_hunt
// Params 0, eflags: 0x4
// Checksum 0x4d6c849a, Offset: 0x3278
// Size: 0x17f
function private function_6945679328cd1fb5()
{
    quest = br_map_quest::get_quest( "mtc_ghost_hunt" );
    activity_instance = quest.activity_instance;
    participating_players = activity_instance.playerparticipants;
    
    foreach ( player in participating_players )
    {
        if ( isdefined( activity_instance.var_c8492f97a6a90db9[ player.guid ] ) && activity_instance.var_c8492f97a6a90db9[ player.guid ].enabled )
        {
            if ( isdefined( quest.activity_instance.var_c8492f97a6a90db9[ player.guid ] ) && quest.activity_instance.var_c8492f97a6a90db9[ player.guid ].enabled )
            {
                player chaff_debuff::function_c1fa63136ba5a433( quest.var_864cb9247f20f29b );
                quest.activity_instance.var_c8492f97a6a90db9[ player.guid ].enabled = 0;
            }
        }
    }
}

// Namespace quest_ghost_hunt
// Params 0, eflags: 0xc
// Checksum 0xfe3da2e7, Offset: 0x33ff
// Size: 0x368
function private function_d25d64b37ea9dae9()
{
    self notify( #"hash_99298d80948f219e" );
    self endon( #"hash_99298d80948f219e" );
    quest = br_map_quest::get_quest( "mtc_ghost_hunt" );
    activity_instance = quest.activity_instance;
    level endon( #"game_ended" );
    activity_instance endon( #"hash_f5ad1aa46dd744ac" );
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    while ( true )
    {
        [ player ] = level utility::waittill_any_return_params( "player_haunt_volume_state_updated", "radar_ref_count_updated" );
        
        if ( isplayer( player ) )
        {
            var_13a5e2a53266ab07 = 0;
            
            if ( quest.activity_instance.current_haunt.var_50a88292323ed49[ player.guid ] )
            {
                if ( isdefined( quest.activity_instance.var_c8492f97a6a90db9[ player.guid ] ) )
                {
                    if ( quest.activity_instance.var_c8492f97a6a90db9[ player.guid ].var_78f0f63e7166815b > 0 && !quest.activity_instance.var_c8492f97a6a90db9[ player.guid ].enabled )
                    {
                        if ( !isdefined( quest.activity_instance.var_c8492f97a6a90db9[ player.guid ] ) )
                        {
                            quest.activity_instance.var_c8492f97a6a90db9[ player.guid ] = { #enabled:0, #var_78f0f63e7166815b:0 };
                        }
                        
                        player chaff_debuff::function_f966e23bd8f1adb5( quest.var_864cb9247f20f29b );
                        quest.activity_instance.var_c8492f97a6a90db9[ player.guid ].enabled = 1;
                    }
                    else if ( quest.activity_instance.var_c8492f97a6a90db9[ player.guid ].var_78f0f63e7166815b == 0 && quest.activity_instance.var_c8492f97a6a90db9[ player.guid ].enabled )
                    {
                        var_13a5e2a53266ab07 = 1;
                    }
                }
            }
            else if ( isdefined( quest.activity_instance.var_c8492f97a6a90db9[ player.guid ] ) && quest.activity_instance.var_c8492f97a6a90db9[ player.guid ].enabled )
            {
                var_13a5e2a53266ab07 = 1;
            }
            
            if ( var_13a5e2a53266ab07 )
            {
                if ( isdefined( quest.activity_instance.var_c8492f97a6a90db9[ player.guid ] ) && quest.activity_instance.var_c8492f97a6a90db9[ player.guid ].enabled )
                {
                    player chaff_debuff::function_c1fa63136ba5a433( quest.var_864cb9247f20f29b );
                    quest.activity_instance.var_c8492f97a6a90db9[ player.guid ].enabled = 0;
                }
            }
        }
    }
}

// Namespace quest_ghost_hunt
// Params 1, eflags: 0x4
// Checksum 0x699e653f, Offset: 0x376f
// Size: 0x54
function private function_b91eb8fc0e0a49bf( params )
{
    quest = br_map_quest::get_quest( "mtc_ghost_hunt" );
    
    if ( activity_participation::function_e7fc1202ac164928( quest.activity_instance, self ) )
    {
        thread function_df08aa58e58551cc( { #weapon:params.objweapon } );
    }
}

// Namespace quest_ghost_hunt
// Params 1, eflags: 0x4
// Checksum 0xfd34250a, Offset: 0x37cb
// Size: 0x1a8
function private function_ea2000fd7335950a( params )
{
    quest = br_map_quest::get_quest( "mtc_ghost_hunt" );
    owner = params.streakinfo.owner;
    streak_name = params.streakinfo.streakname;
    
    if ( isplayer( owner ) && activity_participation::function_e7fc1202ac164928( quest.activity_instance, owner ) && streak_name == "uav" )
    {
        participating_players = quest.activity_instance.playerparticipants;
        
        foreach ( player in participating_players )
        {
            if ( !isdefined( quest.activity_instance.var_c8492f97a6a90db9[ player.guid ] ) )
            {
                quest.activity_instance.var_c8492f97a6a90db9[ player.guid ] = { #enabled:0, #var_78f0f63e7166815b:0 };
            }
            
            quest.activity_instance.var_c8492f97a6a90db9[ player.guid ].var_78f0f63e7166815b++;
            level notify( #"radar_ref_count_updated", player );
        }
    }
}

// Namespace quest_ghost_hunt
// Params 1, eflags: 0x4
// Checksum 0xb368e58d, Offset: 0x397b
// Size: 0x1db
function private on_player_killstreak_finish_use( params )
{
    quest = br_map_quest::get_quest( "mtc_ghost_hunt" );
    owner = params.streakinfo.owner;
    streak_name = params.streakinfo.streakname;
    
    if ( isplayer( owner ) && activity_participation::function_e7fc1202ac164928( quest.activity_instance, owner ) && streak_name == "uav" )
    {
        participating_players = quest.activity_instance.playerparticipants;
        
        foreach ( player in participating_players )
        {
            if ( !isdefined( quest.activity_instance.var_c8492f97a6a90db9[ player.guid ] ) )
            {
                quest.activity_instance.var_c8492f97a6a90db9[ player.guid ] = { #enabled:0, #var_78f0f63e7166815b:0 };
            }
            
            quest.activity_instance.var_c8492f97a6a90db9[ player.guid ].var_78f0f63e7166815b = maxint( 0, quest.activity_instance.var_c8492f97a6a90db9[ player.guid ].var_78f0f63e7166815b - 1 );
            level notify( #"radar_ref_count_updated", player );
        }
    }
}

// Namespace quest_ghost_hunt
// Params 1, eflags: 0x4
// Checksum 0x88412b82, Offset: 0x3b5e
// Size: 0x11a
function private function_9229a8d5908b95f8( params )
{
    quest = br_map_quest::get_quest( "mtc_ghost_hunt" );
    player = self;
    weapon = params.objweapon;
    
    if ( isweapon( weapon ) && issubstr( weapon.basename, "hb_sensor" ) && isplayer( player ) && activity_participation::function_e7fc1202ac164928( quest.activity_instance, player ) )
    {
        if ( !isdefined( quest.activity_instance.var_c8492f97a6a90db9[ player.guid ] ) )
        {
            quest.activity_instance.var_c8492f97a6a90db9[ player.guid ] = { #enabled:0, #var_78f0f63e7166815b:0 };
        }
        
        quest.activity_instance.var_c8492f97a6a90db9[ player.guid ].var_78f0f63e7166815b++;
        level notify( #"radar_ref_count_updated", player );
    }
}

// Namespace quest_ghost_hunt
// Params 1, eflags: 0x4
// Checksum 0xf9940606, Offset: 0x3c80
// Size: 0x14c
function private function_f33dfb3098e8a9d0( params )
{
    quest = br_map_quest::get_quest( "mtc_ghost_hunt" );
    owner = self;
    weapon = params.weapon_object;
    
    if ( isweapon( weapon ) && isplayer( owner ) && activity_participation::function_e7fc1202ac164928( quest.activity_instance, owner ) )
    {
        if ( issubstr( weapon.basename, "hb_sensor" ) )
        {
            if ( !isdefined( quest.activity_instance.var_c8492f97a6a90db9[ owner.guid ] ) )
            {
                quest.activity_instance.var_c8492f97a6a90db9[ owner.guid ] = { #enabled:0, #var_78f0f63e7166815b:0 };
            }
            
            quest.activity_instance.var_c8492f97a6a90db9[ owner.guid ].var_78f0f63e7166815b = maxint( 0, quest.activity_instance.var_c8492f97a6a90db9[ owner.guid ].var_78f0f63e7166815b - 1 );
            level notify( #"radar_ref_count_updated", owner );
        }
    }
}

// Namespace quest_ghost_hunt
// Params 1, eflags: 0x4
// Checksum 0x3567141b, Offset: 0x3dd4
// Size: 0x1da
function private function_eb5ecbbe1e5ebdbf( params )
{
    quest = br_map_quest::get_quest( "mtc_ghost_hunt" );
    owner = params.originalowner ?? self;
    grenade = params.grenade;
    
    if ( isdefined( grenade ) && isplayer( owner ) && activity_participation::function_e7fc1202ac164928( quest.activity_instance, owner ) )
    {
        if ( issubstr( grenade.equipmentref, "sensor_dart" ) )
        {
            participating_players = quest.activity_instance.playerparticipants;
            
            foreach ( player in participating_players )
            {
                if ( !isdefined( quest.activity_instance.var_c8492f97a6a90db9[ player.guid ] ) )
                {
                    quest.activity_instance.var_c8492f97a6a90db9[ player.guid ] = { #enabled:0, #var_78f0f63e7166815b:0 };
                }
                
                quest.activity_instance.var_c8492f97a6a90db9[ player.guid ].var_78f0f63e7166815b++;
                level notify( #"radar_ref_count_updated", player );
            }
            
            grenade thread function_f07fb039acec1724();
        }
        
        thread function_df08aa58e58551cc( { #ref:grenade.equipmentref, #grenade:grenade } );
    }
}

// Namespace quest_ghost_hunt
// Params 1, eflags: 0x4
// Checksum 0xe315f00c, Offset: 0x3fb6
// Size: 0x18a
function private function_df08aa58e58551cc( params )
{
    quest = br_map_quest::get_quest( "mtc_ghost_hunt" );
    
    if ( quest.activity_instance.current_haunt && quest.activity_instance.current_haunt.var_50a88292323ed49[ self.guid ] )
    {
        var_c582c6c7aa628ff1 = undefined;
        
        if ( params.grenade && params.ref )
        {
            if ( is_explosive_grenade( params.grenade ) )
            {
                if ( function_6bac655c0c4e7df1( 4 ) )
                {
                    var_c582c6c7aa628ff1 = 4;
                }
            }
        }
        else if ( params.weapon )
        {
            weapon_class = weaponclass( params.weapon );
            
            if ( weapon_class )
            {
                if ( function_6bac655c0c4e7df1( 2 ) && arraycontains( [ "pistol", "shotgun", "smg" ], weapon_class ) )
                {
                    var_c582c6c7aa628ff1 = 2;
                }
                else if ( function_6bac655c0c4e7df1( 3 ) && arraycontains( [ "sniper", "rocketlauncher", "rifle" ], weapon_class ) )
                {
                    var_c582c6c7aa628ff1 = 3;
                }
            }
        }
        
        if ( isdefined( var_c582c6c7aa628ff1 ) )
        {
            if ( var_c582c6c7aa628ff1 == 2 || var_c582c6c7aa628ff1 == 3 )
            {
                item_weapon::function_c2ad12bd3e5d5da5( { #weapon:params.weapon } );
            }
            
            level thread function_3eadd50bd5e3381d();
        }
    }
}

// Namespace quest_ghost_hunt
// Params 6, eflags: 0x4
// Checksum 0xab46951b, Offset: 0x4148
// Size: 0xa2
function private function_9837a73d9f6c0b62( instance, part, state, player, bautouse, usestring )
{
    if ( isplayer( player ) && part == "zmloot_offhand_geigercounter" )
    {
        quest = br_map_quest::get_quest( "mtc_ghost_hunt" );
        
        if ( !activity_participation::function_e7fc1202ac164928( quest.activity_instance, player ) )
        {
            activity_participation::function_1f1a3bd685df59e8( quest.activity_instance );
            activity_participation::function_bc67362dace4370c( quest.activity_instance, player );
        }
    }
}

// Namespace quest_ghost_hunt
// Params 1, eflags: 0x4
// Checksum 0xbe46fddf, Offset: 0x41f2
// Size: 0x7b
function private function_a0af5e1aa94310ae( var_54c779cf281bb58d )
{
    quest = br_map_quest::get_quest( "mtc_ghost_hunt" );
    
    if ( var_54c779cf281bb58d.enteredzone )
    {
        quest.var_fc99a22f27965a48[ var_54c779cf281bb58d.player.guid ] = 1;
        return;
    }
    
    quest.var_fc99a22f27965a48[ var_54c779cf281bb58d.player.guid ] = 0;
}

// Namespace quest_ghost_hunt
// Params 0, eflags: 0x4
// Checksum 0xf92627c7, Offset: 0x4275
// Size: 0x13f
function private function_98d47cd5be8d0ce()
{
    level endon( #"game_ended" );
    level waittill( #"infil_animatic_complete" );
    weapon_item_bundle_name = item_weapon::function_3da93a43aae4473d( "sat_ar_heron_mp" );
    weapon_item_bundle = isdefined( weapon_item_bundle_name ) ? getscriptbundle( weapon_item_bundle_name ) : undefined;
    
    if ( !isdefined( weapon_item_bundle ) )
    {
        println( "<dev string:xf2>" + "<dev string:x12c>" + "<dev string:x13c>" + ( weapon_item_bundle_name ?? "<dev string:x14b>" ) + "<dev string:x155>" );
        return;
    }
    
    spawn_origin = self.thermal_weapon_spawn_struct.origin;
    spawn_angles = self.thermal_weapon_spawn_struct.angles;
    weapon_spawn_options = common_item::function_bc5ff2958b71a708( spawn_origin, spawn_angles );
    weapon_spawn_options.weapon = weapon::buildweapon( "sat_ar_heron_mp", [ "sat_thermal01_ar", "sat_ammo_762s", "sat_grip_ar_heron", "sat_selectsemi_ar_heron", "sat_mag_ar_heron", "sat_stock_ar_heron", "sat_bar_ar_heron", "sat_rec_ar_heron" ], "camo_none", "none" );
    item_weapon::function_b960bc85ea91de14( weapon_item_bundle, weapon_spawn_options );
}

// Namespace quest_ghost_hunt
// Params 0, eflags: 0x4
// Checksum 0x55d3e79d, Offset: 0x43bc
// Size: 0x178
function private function_f07fb039acec1724()
{
    utility::waittill_any( "death", "destroyed" );
    quest = br_map_quest::get_quest( "mtc_ghost_hunt" );
    participating_players = quest.activity_instance.playerparticipants;
    
    foreach ( player in participating_players )
    {
        if ( !isdefined( quest.activity_instance.var_c8492f97a6a90db9[ player.guid ] ) )
        {
            quest.activity_instance.var_c8492f97a6a90db9[ player.guid ] = { #enabled:0, #var_78f0f63e7166815b:0 };
        }
        
        quest.activity_instance.var_c8492f97a6a90db9[ player.guid ].var_78f0f63e7166815b = maxint( 0, quest.activity_instance.var_c8492f97a6a90db9[ player.guid ].var_78f0f63e7166815b - 1 );
        level notify( #"radar_ref_count_updated", player );
    }
}

// Namespace quest_ghost_hunt
// Params 1, eflags: 0x4
// Checksum 0x871963e5, Offset: 0x453c
// Size: 0xe6, Type: bool
function private is_explosive_grenade( grenade )
{
    if ( !isdefined( grenade.equipmentref ) )
    {
        return false;
    }
    
    foreach ( ref in [ "at_mine", "bunkerbuster", "c4", "claymore", "cluster_grenade", "dart_mark_zero", "frag", "semtex" ] )
    {
        if ( issubstr( grenade.equipmentref, ref ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace quest_ghost_hunt
// Params 3, eflags: 0x4
// Checksum 0x29558aa2, Offset: 0x462b
// Size: 0x31
function private function_c70f6cd2bc9151fa( player, pbg_asset, duration )
{
    pbgpostfxbundlestart( player, pbg_asset );
    wait duration;
    pbgpostfxbundleend( player, pbg_asset );
}

// Namespace quest_ghost_hunt
// Params 2, eflags: 0x4
// Checksum 0x8218fb64, Offset: 0x4664
// Size: 0x118
function private function_44c17375f1fe650c( dist_sq, object )
{
    quest = br_map_quest::get_quest( "mtc_ghost_hunt" );
    var_91e9b298e99df720 = quest.activity_instance && activity_instance_common::getactivitystate( quest.activity_instance ) == "Active" && quest.activity_instance.current_haunt;
    pulse_rate = 1.4;
    
    if ( var_91e9b298e99df720 )
    {
        var_85176beceb336617 = quest.var_fc99a22f27965a48[ self.guid ];
        
        if ( var_85176beceb336617 )
        {
            pulse_rate = geiger_counter::_geigercounter_calculategeigercounterpulserate( dist_sq, object );
            
            if ( pulse_rate <= quest.var_230c8cf3c1a00f1e && quest.activity_instance.current_haunt.var_50a88292323ed49[ self.guid ] )
            {
                pulse_rate = 0;
            }
        }
    }
    
    scale = 1.47368;
    mapped_rate = pulse_rate * scale;
    return mapped_rate;
}

// Namespace quest_ghost_hunt
// Params 2, eflags: 0x4
// Checksum 0xd63e7ea7, Offset: 0x4785
// Size: 0x85
function private function_c64b6ed7f276232a( player, damage_amt )
{
    quest = br_map_quest::get_quest( "mtc_ghost_hunt" );
    activity_instance = quest.activity_instance;
    
    if ( player && isalive( player ) )
    {
        player dodamage( quest.var_d2bd958d0471593f, player.origin, activity_instance.ghost_ent, undefined, "MOD_UNKNOWN", undefined, "torso_upper", undefined );
    }
}

// Namespace quest_ghost_hunt
// Params 0, eflags: 0x4
// Checksum 0xa47d6dad, Offset: 0x4812
// Size: 0x30
function private precache_vfx()
{
    utility::add_fx( "mtc_ghost_hunt" + "thermal_aura", "vfx_saw_manticore_ghost_hunt_thermal_aura" );
    utility::add_fx( "mtc_ghost_hunt" + "wisp_free", "vfx_sat_levels_mp_saw_manticore_ee_ghost_hunt_soul_wisp_free" );
}

// Namespace quest_ghost_hunt
// Params 1, eflags: 0x4
// Checksum 0x5319652d, Offset: 0x484a
// Size: 0x1a
function private function_78edf75e42900b89( vfx_name )
{
    return utility::getfx( "mtc_ghost_hunt" + vfx_name );
}

// Namespace quest_ghost_hunt
// Params 1, eflags: 0x4
// Checksum 0x324810c, Offset: 0x486d
// Size: 0x1b9
function private spawn_rewards( var_53a4e09d26289e8d )
{
    level endon( #"game_ended" );
    quest = br_map_quest::get_quest( "mtc_ghost_hunt" );
    items = common_item::items_selectfromlist( %"hash_35805e9df48b9b0b", quest.reward_count );
    spawn_origin = var_53a4e09d26289e8d.origin;
    destination_origin = var_53a4e09d26289e8d.associated_struct.var_ed2431ff5fd3b5d8;
    var_53a4e09d26289e8d setscriptablepartstate( #"base", #"reward" );
    var_53a4e09d26289e8d setscriptablepartstate( #"ghost", #"reward" );
    level thread spawn_reward_fx_ent( var_53a4e09d26289e8d.origin, var_53a4e09d26289e8d.angles );
    
    foreach ( item in items )
    {
        randomized_destination_origin = getclosestpointonnavmesh( destination_origin + ( quest.var_b732411d1830d18e * cos( randomint( 360 ) ), quest.var_b732411d1830d18e * sin( randomint( 360 ) ), 0 ) );
        spawn_options = common_item::function_f5dfaa3bbdf99a33( randomized_destination_origin + ( 0, 0, quest.item_spawn_z_offset ), spawn_origin );
        common_item::function_61c2c0251e742ffd( item, undefined, spawn_options );
        wait quest.var_156d363f42beb893;
    }
}

// Namespace quest_ghost_hunt
// Params 2, eflags: 0x4
// Checksum 0xac579275, Offset: 0x4a2e
// Size: 0x8d
function private spawn_reward_fx_ent( origin, angles )
{
    quest = br_map_quest::get_quest( "mtc_ghost_hunt" );
    var_ae90daf51ad0f940 = function_78edf75e42900b89( "wisp_free" );
    reward_fx_ent = utility::spawn_model( "tag_origin", origin, angles );
    reward_fx_ent.fx = var_ae90daf51ad0f940;
    playfxontag( var_ae90daf51ad0f940, reward_fx_ent, "tag_origin" );
    utility::delaythread( quest.var_2ebafa62b170953c, &function_ec33af94ff88db53, reward_fx_ent );
}

// Namespace quest_ghost_hunt
// Params 1, eflags: 0x4
// Checksum 0x1358c00, Offset: 0x4ac3
// Size: 0x2f
function private function_ec33af94ff88db53( reward_fx_ent )
{
    if ( reward_fx_ent )
    {
        stopfxontag( reward_fx_ent.fx, reward_fx_ent, "tag_origin" );
        reward_fx_ent delete();
    }
}

/#

    // Namespace quest_ghost_hunt
    // Params 0, eflags: 0x4
    // Checksum 0xf3010b67, Offset: 0x4afa
    // Size: 0x12, Type: dev
    function private get_devgui_path()
    {
        return activity_nexus_debug::function_3a45e311cf4d30b7() + "<dev string:x19d>";
    }

    // Namespace quest_ghost_hunt
    // Params 0, eflags: 0x4
    // Checksum 0x37c6e29a, Offset: 0x4b14
    // Size: 0x21f, Type: dev
    function private setup_devgui()
    {
        var_c97c1fa76d5f85fe = get_devgui_path();
        devgui::function_9082edeb5db93280( var_c97c1fa76d5f85fe + "<dev string:x1a9>" );
        devgui::add_devgui_func( "<dev string:x1ae>", "<dev string:x1bf>", &function_65a8e238e229d1f8 );
        devgui::add_devgui_func( "<dev string:x1d6>", "<dev string:x1e6>", &function_2e2f0e144753dd18 );
        devgui::add_devgui_func( "<dev string:x1fc>", "<dev string:x20e>", &function_285061e0ea70ff53 );
        devgui::add_devgui_func( "<dev string:x226>", "<dev string:x237>", &function_1eeea8c0dc862af3 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( var_c97c1fa76d5f85fe );
        devgui::add_devgui_func( "<dev string:x24e>", "<dev string:x26a>", &function_366cfc9219a12dae );
        devgui::add_devgui_func( "<dev string:x28c>", "<dev string:x2a1>", &debug_spawn_geiger_counter );
        devgui::add_devgui_func( "<dev string:x2bc>", "<dev string:x2ca>", &debug_spawn_rewards );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( var_c97c1fa76d5f85fe + "<dev string:x2de>" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x2e4>", @"hash_2c6fa81e020fd1d2" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x300>", @"hash_c02355704fd89532" );
        devgui::add_devgui_func( "<dev string:x31f>", "<dev string:x33c>", &function_bdd68616136fa5ea );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( var_c97c1fa76d5f85fe + "<dev string:x366>" );
        devgui::add_devgui_func( "<dev string:x37b>", "<dev string:x399>", &function_61790e89938ca406 );
        devgui::add_devgui_func( "<dev string:x3bd>", "<dev string:x3d3>", &function_194d51ca0c4e9531 );
        devgui::add_devgui_func( "<dev string:x3f8>", "<dev string:x40f>", &function_e96140b8a350ba63 );
        devgui::add_devgui_func( "<dev string:x435>", "<dev string:x44a>", &function_9884b441904586ee );
        devgui::add_devgui_func( "<dev string:x46e>", "<dev string:x484>", &function_ddb9ef9ee218d4ad );
        devgui::add_devgui_func( "<dev string:x4a9>", "<dev string:x4c4>", &function_626976b4e6d813dc );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( var_c97c1fa76d5f85fe + "<dev string:x4f8>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x4fd>", "<dev string:x50f>", &debug_play_vfx );
        devgui::add_devgui_func( "<dev string:x52b>", "<dev string:x53b>", &function_f4d8dcce7d4f0dea );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( var_c97c1fa76d5f85fe + "<dev string:x551>" );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace quest_ghost_hunt
    // Params 2, eflags: 0x4
    // Checksum 0x5ee8a43e, Offset: 0x4d3b
    // Size: 0x59, Type: dev
    function private function_9b958be0688c30c4( name, encounter_func )
    {
        var_c97c1fa76d5f85fe = get_devgui_path();
        devgui::function_9082edeb5db93280( var_c97c1fa76d5f85fe + "<dev string:x55f>" );
        devgui::add_devgui_func( "<dev string:x571>" + name, "<dev string:x57a>" + name, encounter_func );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace quest_ghost_hunt
    // Params 1, eflags: 0x4
    // Checksum 0x620842a5, Offset: 0x4d9c
    // Size: 0x72, Type: dev
    function private function_8e8c50a03afc1c74( name )
    {
        var_c97c1fa76d5f85fe = get_devgui_path();
        devgui::function_9082edeb5db93280( var_c97c1fa76d5f85fe + "<dev string:x593>" + name + "<dev string:x5a3>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x5a5>", "<dev string:x5ae>" + name, &function_ebff490f7a0cf389 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x5c7>", "<dev string:x5d2>" + name, &function_cfa67b166913891c );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace quest_ghost_hunt
    // Params 1, eflags: 0x4
    // Checksum 0x36fdfae5, Offset: 0x4e16
    // Size: 0xc4, Type: dev
    function private function_ebff490f7a0cf389( params )
    {
        evidence_name = params[ 0 ];
        quest = br_map_quest::get_quest( "<dev string:x5ed>" );
        
        foreach ( evidence_struct in quest.ghost_evidence )
        {
            if ( evidence_struct.name == evidence_name )
            {
                level thread [[ evidence_struct.activate_func ]]();
                return;
            }
        }
    }

    // Namespace quest_ghost_hunt
    // Params 1, eflags: 0x4
    // Checksum 0x6487debb, Offset: 0x4ee2
    // Size: 0xc4, Type: dev
    function private function_cfa67b166913891c( params )
    {
        evidence_name = params[ 0 ];
        quest = br_map_quest::get_quest( "<dev string:x5ed>" );
        
        foreach ( evidence_struct in quest.ghost_evidence )
        {
            if ( evidence_struct.name == evidence_name )
            {
                level thread [[ evidence_struct.deactivate_func ]]();
                return;
            }
        }
    }

    // Namespace quest_ghost_hunt
    // Params 0, eflags: 0x4
    // Checksum 0x3a1d71ed, Offset: 0x4fae
    // Size: 0x1a, Type: dev
    function private function_65a8e238e229d1f8()
    {
        pbgpostfxbundlestart( level.players[ 0 ], "<dev string:x5fc>" );
    }

    // Namespace quest_ghost_hunt
    // Params 0, eflags: 0x4
    // Checksum 0xcd182266, Offset: 0x4fd0
    // Size: 0x1a, Type: dev
    function private function_2e2f0e144753dd18()
    {
        pbgpostfxbundleend( level.players[ 0 ], "<dev string:x5fc>" );
    }

    // Namespace quest_ghost_hunt
    // Params 0, eflags: 0x4
    // Checksum 0x4b107695, Offset: 0x4ff2
    // Size: 0x1a, Type: dev
    function private function_285061e0ea70ff53()
    {
        pbgpostfxbundlestart( level.players[ 0 ], "<dev string:x616>" );
    }

    // Namespace quest_ghost_hunt
    // Params 0, eflags: 0x4
    // Checksum 0x20bc211f, Offset: 0x5014
    // Size: 0x1a, Type: dev
    function private function_1eeea8c0dc862af3()
    {
        pbgpostfxbundleend( level.players[ 0 ], "<dev string:x616>" );
    }

    // Namespace quest_ghost_hunt
    // Params 0, eflags: 0x4
    // Checksum 0x909e2be8, Offset: 0x5036
    // Size: 0x71, Type: dev
    function private debug_spawn_geiger_counter()
    {
        player = level.players[ 0 ];
        spawn_origin = player.origin + anglestoforward( player.angles ) * 50;
        spawn_options = common_item::function_bc5ff2958b71a708( spawn_origin, player.angles );
        common_item::function_325e28c0fb65c36a( "<dev string:x631>", 1, spawn_options );
    }

    // Namespace quest_ghost_hunt
    // Params 0, eflags: 0x4
    // Checksum 0xcaf146e7, Offset: 0x50af
    // Size: 0x50, Type: dev
    function private debug_spawn_rewards()
    {
        quest = br_map_quest::get_quest( "<dev string:x5ed>" );
        
        if ( !quest || !quest.activity_instance )
        {
            return;
        }
        
        level thread spawn_rewards( quest.activity_instance.var_72b76ffa75a8a3aa );
    }

    // Namespace quest_ghost_hunt
    // Params 0, eflags: 0x4
    // Checksum 0xb2610eb7, Offset: 0x5107
    // Size: 0x20b, Type: dev
    function private function_61790e89938ca406()
    {
        quest = br_map_quest::get_quest( "<dev string:x5ed>" );
        
        if ( !quest || !quest.activity_instance )
        {
            return;
        }
        
        if ( !isdefined( level.var_34c2431075544dc8 ) )
        {
            level.var_34c2431075544dc8 = [];
        }
        
        var_f0610371107e547d = quest.activity_instance.var_8f3f45e46073ab37 ?? quest.activity_instance.var_b0b03d23c4bc231f;
        
        foreach ( haunt_struct in var_f0610371107e547d )
        {
            foreach ( thermal_struct in haunt_struct.var_6a7ea76ddc979330 )
            {
                if ( function_252b5e3f0feec0b5( thermal_struct ) )
                {
                    continue;
                }
                
                var_c112c5a3e30cc7b0 = quest.var_700625c521f1e8f9[ thermal_struct.prop_type ];
                thermal_scriptable = spawnscriptable( var_c112c5a3e30cc7b0, thermal_struct.origin, thermal_struct.angles );
                activity_scriptables::function_114d59757e8d7bd9( quest.activity_instance, thermal_scriptable, "<dev string:x642>" );
                thermal_scriptable.associated_struct = thermal_struct;
                debug_entry = { #struct:thermal_struct, #scriptable:thermal_scriptable };
                level.var_34c2431075544dc8[ level.var_34c2431075544dc8.size ] = debug_entry;
            }
        }
    }

    // Namespace quest_ghost_hunt
    // Params 1, eflags: 0x4
    // Checksum 0x7a5b02c0, Offset: 0x531a
    // Size: 0xb4, Type: dev
    function private function_252b5e3f0feec0b5( thermal_struct )
    {
        if ( !isdefined( level.var_34c2431075544dc8 ) )
        {
            return 0;
        }
        
        foreach ( entry in level.var_34c2431075544dc8 )
        {
            if ( entry.struct == thermal_struct && entry.scriptable )
            {
                return 1;
            }
        }
        
        return 0;
    }

    // Namespace quest_ghost_hunt
    // Params 2, eflags: 0x4
    // Checksum 0x33318454, Offset: 0x53d6
    // Size: 0x9a, Type: dev
    function private function_17c94bd5388043c7( base_state, ghost_state )
    {
        nearest_entry = function_90b0ff85c8a95b3c();
        
        if ( !isdefined( nearest_entry ) )
        {
            return;
        }
        
        nearest_entry.scriptable setscriptablepartstate( #"base", base_state );
        nearest_entry.scriptable setscriptablepartstate( #"ghost", ghost_state );
        level thread spawn_reward_fx_ent( nearest_entry.scriptable.origin, nearest_entry.scriptable.angles );
    }

    // Namespace quest_ghost_hunt
    // Params 0, eflags: 0x4
    // Checksum 0xef6214fd, Offset: 0x5478
    // Size: 0x119, Type: dev
    function private function_90b0ff85c8a95b3c()
    {
        if ( !isdefined( level.var_34c2431075544dc8 ) || level.var_34c2431075544dc8.size == 0 )
        {
            return;
        }
        
        player = level.players[ 0 ];
        nearest_entry = undefined;
        nearest_dist_sq = undefined;
        
        foreach ( entry in level.var_34c2431075544dc8 )
        {
            if ( !entry.scriptable )
            {
                continue;
            }
            
            dist_sq = distancesquared( player.origin, entry.scriptable.origin );
            
            if ( !isdefined( nearest_dist_sq ) || dist_sq < nearest_dist_sq )
            {
                nearest_dist_sq = dist_sq;
                nearest_entry = entry;
            }
        }
        
        return nearest_entry;
    }

    // Namespace quest_ghost_hunt
    // Params 0, eflags: 0x4
    // Checksum 0x8cf79d7, Offset: 0x5599
    // Size: 0x1e, Type: dev
    function private function_e96140b8a350ba63()
    {
        function_17c94bd5388043c7( #"haunted", #"none" );
    }

    // Namespace quest_ghost_hunt
    // Params 0, eflags: 0x4
    // Checksum 0xcc6d6d31, Offset: 0x55bf
    // Size: 0x1e, Type: dev
    function private function_9884b441904586ee()
    {
        function_17c94bd5388043c7( #"found", #"success" );
    }

    // Namespace quest_ghost_hunt
    // Params 0, eflags: 0x4
    // Checksum 0x8eb4cf4d, Offset: 0x55e5
    // Size: 0x1e, Type: dev
    function private function_ddb9ef9ee218d4ad()
    {
        function_17c94bd5388043c7( #"reward", #"reward" );
    }

    // Namespace quest_ghost_hunt
    // Params 0, eflags: 0x4
    // Checksum 0xe3252f3, Offset: 0x560b
    // Size: 0x1e, Type: dev
    function private function_194d51ca0c4e9531()
    {
        function_17c94bd5388043c7( #"normal", #"none" );
    }

    // Namespace quest_ghost_hunt
    // Params 0, eflags: 0x4
    // Checksum 0x1038debb, Offset: 0x5631
    // Size: 0x30, Type: dev
    function private function_626976b4e6d813dc()
    {
        nearest_entry = function_90b0ff85c8a95b3c();
        
        if ( isdefined( nearest_entry ) )
        {
            level thread spawn_rewards( nearest_entry.scriptable );
        }
    }

    // Namespace quest_ghost_hunt
    // Params 1, eflags: 0x4
    // Checksum 0x9b5c54bb, Offset: 0x5669
    // Size: 0xa9, Type: dev
    function private debug_play_vfx( params )
    {
        function_f4d8dcce7d4f0dea();
        player = level.players[ 0 ];
        spawn_origin = player.origin + anglestoforward( player.angles ) * 150;
        fx = function_78edf75e42900b89( params[ 0 ] );
        level.var_189366c7e20493f2 = utility::spawn_model( "<dev string:x64e>", spawn_origin );
        level.var_189366c7e20493f2.fx = fx;
        playfxontag( fx, level.var_189366c7e20493f2, "<dev string:x64e>" );
    }

    // Namespace quest_ghost_hunt
    // Params 0, eflags: 0x4
    // Checksum 0x918c7a09, Offset: 0x571a
    // Size: 0x50, Type: dev
    function private function_f4d8dcce7d4f0dea()
    {
        if ( isdefined( level.var_189366c7e20493f2 ) )
        {
            stopfxontag( level.var_189366c7e20493f2.fx, level.var_189366c7e20493f2, "<dev string:x64e>" );
            level.var_189366c7e20493f2 delete();
            level.var_189366c7e20493f2 = undefined;
        }
    }

    // Namespace quest_ghost_hunt
    // Params 0, eflags: 0x4
    // Checksum 0xa59048d5, Offset: 0x5772
    // Size: 0x19c, Type: dev
    function private function_366cfc9219a12dae()
    {
        quest = br_map_quest::get_quest( "<dev string:x5ed>" );
        
        if ( !quest || !quest.activity_instance )
        {
            return;
        }
        
        player = level.players[ 0 ];
        nearest_haunt = undefined;
        nearest_dist_sq = undefined;
        
        foreach ( haunt_struct in quest.activity_instance.var_b0b03d23c4bc231f )
        {
            dist_sq = distancesquared( player.origin, haunt_struct.origin );
            
            if ( !isdefined( nearest_dist_sq ) || dist_sq < nearest_dist_sq )
            {
                nearest_dist_sq = dist_sq;
                nearest_haunt = haunt_struct;
            }
        }
        
        if ( nearest_haunt )
        {
            if ( quest.activity_instance.current_haunt )
            {
                function_c4253dcf6b6eca56();
            }
            
            quest.activity_instance.current_haunt = nearest_haunt;
            quest.activity_instance.current_haunt.var_50a88292323ed49 = [];
            geiger_counter::function_69cfcbb5ee5bfc98( quest.activity_instance.current_haunt );
            level thread function_2dbefc64dc7c5f06();
            level thread function_f2fe459a81c2baaf();
        }
    }

    // Namespace quest_ghost_hunt
    // Params 1, eflags: 0xc
    // Checksum 0x7ab8e46e, Offset: 0x5916
    // Size: 0xa8, Type: dev
    function private function_1855c5e219661fcd( activity_instance )
    {
        self notify( #"hash_1c665a76de3e4bbd" );
        self endon( #"hash_1c665a76de3e4bbd" );
        level endon( #"game_ended" );
        activity_instance endon( #"activity_ended" );
        activity_instance endon( #"instance_destroyed" );
        
        while ( true )
        {
            current_haunt = activity_instance.current_haunt;
            
            if ( isdefined( current_haunt ) && getdvarint( @"hash_2c6fa81e020fd1d2", 0 ) )
            {
                debug::sphere( current_haunt.origin, 32, "<dev string:x659>", 0.25 );
            }
            
            wait 0.25;
        }
    }

    // Namespace quest_ghost_hunt
    // Params 1, eflags: 0xc
    // Checksum 0x78457459, Offset: 0x59c6
    // Size: 0xc1, Type: dev
    function private function_509670c0108f23bb( activity_instance )
    {
        self notify( #"hash_5b878a5a4a640fa8" );
        self endon( #"hash_5b878a5a4a640fa8" );
        level endon( #"game_ended" );
        activity_instance endon( #"activity_ended" );
        activity_instance endon( #"instance_destroyed" );
        
        while ( true )
        {
            current_haunt = activity_instance.current_haunt;
            
            if ( isdefined( current_haunt ) && activity_instance.var_72b76ffa75a8a3aa && getdvarint( @"hash_c02355704fd89532", 0 ) )
            {
                debug::sphere( activity_instance.var_72b76ffa75a8a3aa.origin, 16, "<dev string:x65d>", 0.25 );
            }
            
            wait 0.25;
        }
    }

    // Namespace quest_ghost_hunt
    // Params 0, eflags: 0xc
    // Checksum 0x733f2b1d, Offset: 0x5a8f
    // Size: 0xfc, Type: dev
    function private function_bac0d8eee008beb7()
    {
        self notify( #"hash_ca356d39d62b27bf" );
        self endon( #"hash_ca356d39d62b27bf" );
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( isdefined( level.var_34c2431075544dc8 ) && getdvarint( @"hash_f7fca58319bf6c66", 0 ) )
            {
                foreach ( entry in level.var_34c2431075544dc8 )
                {
                    if ( entry.scriptable )
                    {
                        debug::sphere( entry.scriptable.origin, 16, "<dev string:x663>", 0.25 );
                    }
                }
            }
            
            wait 0.25;
        }
    }

    // Namespace quest_ghost_hunt
    // Params 0, eflags: 0x4
    // Checksum 0x3912dc83, Offset: 0x5b93
    // Size: 0x45, Type: dev
    function private function_bdd68616136fa5ea()
    {
        new_state = getdvarint( @"hash_f7fca58319bf6c66", 0 ) ? 0 : 1;
        setdvar( @"hash_f7fca58319bf6c66", new_state );
        
        if ( new_state )
        {
            level thread function_bac0d8eee008beb7();
        }
    }

    // Namespace quest_ghost_hunt
    // Params 1, eflags: 0x4
    // Checksum 0xa81876a2, Offset: 0x5be0
    // Size: 0x2c1, Type: dev
    function private function_9f03a4ec00fdc845( activity_instance )
    {
        level endon( #"game_ended" );
        activity_instance endon( #"activity_ended" );
        activity_instance endon( #"instance_destroyed" );
        quest = br_map_quest::get_quest( "<dev string:x5ed>" );
        definition = activity_instance.ghost_ent.definition;
        
        if ( !isdefined( definition ) || !isdefined( activity_instance.emf_spawn_struct ) )
        {
            return;
        }
        
        debug_entries = [];
        header_entry = { #color:( 1, 1, 0 ), #text:"<dev string:x668>" + function_c037ddc295f61d67( definition.type ) };
        debug_entries[ debug_entries.size ] = header_entry;
        header_entry = { #color:( 1, 1, 0 ), #text:"<dev string:x675>" + function_2d7372685c86e8e5( definition.var_5d14e086aa7bf6ae ) };
        debug_entries[ debug_entries.size ] = header_entry;
        
        foreach ( evidence_type, evidence_struct in quest.ghost_evidence )
        {
            supported = arraycontains( definition.evidence_list, evidence_type );
            entry_color = supported ? ( 0, 1, 0 ) : ( 1, 0, 0 );
            entry_status = supported ? "<dev string:x683>" : "<dev string:x687>";
            evidence_entry = { #color:entry_color, #text:"<dev string:x68a>" + evidence_struct.name + "<dev string:x68f>" + entry_status };
            debug_entries[ debug_entries.size ] = evidence_entry;
        }
        
        text_origin = activity_instance.emf_spawn_struct.origin + ( 0, 0, 80 );
        
        while ( true )
        {
            for ( i = 0; i < debug_entries.size ; i++ )
            {
                line_origin = text_origin + ( 0, 0, ( debug_entries.size - i ) * 12 );
                print3d( line_origin, debug_entries[ i ].text, debug_entries[ i ].color, 1, 1, 1, 1 );
            }
            
            wait 0.05;
        }
    }

    // Namespace quest_ghost_hunt
    // Params 1, eflags: 0x4
    // Checksum 0x2cfab83b, Offset: 0x5ea9
    // Size: 0x31, Type: dev
    function private function_c037ddc295f61d67( type )
    {
        switch ( type )
        {
            default:
                return "<dev string:x692>";
        }
        
        return "<dev string:x6a2>";
    }

    // Namespace quest_ghost_hunt
    // Params 1, eflags: 0x4
    // Checksum 0x84ee8059, Offset: 0x5ee2
    // Size: 0x43, Type: dev
    function private function_2d7372685c86e8e5( var_5d14e086aa7bf6ae )
    {
        switch ( var_5d14e086aa7bf6ae )
        {
            case 1:
                return "<dev string:x6aa>";
            case 2:
                return "<dev string:x6b5>";
        }
        
        return "<dev string:x6bd>";
    }

#/
