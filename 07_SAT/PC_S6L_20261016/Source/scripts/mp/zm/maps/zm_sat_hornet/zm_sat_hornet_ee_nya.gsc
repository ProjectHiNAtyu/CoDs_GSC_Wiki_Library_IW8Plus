// scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_ee_nya.gsc  (hash_29b8ab9e5a9fcc41.gscc) (size: 17980 Bytes / 0x463c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3223c9f2 (841206258)
// size ...... 17980 (0x463c)
// includes .. 18  (offset: 0x42e4)
// strings ... 48  (offset: 0x4374)
// dev strs .. 2   (offset: 0x4624)
// exports ... 48  (offset: 0x2bdc)
// cseg ...... 0x3df + 0x27fd (0x2bdc)
// imports ... 129 (offset: 0x335c)
// animtree1 . 0   (offset: 0x463c)
// animtree2 . 0   (offset: 0x463c)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\powerups;
#using scripts\common\scriptable;
#using scripts\common\status_effects\effect_slow;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\crafting_table;
#using scripts\mp\interaction;
#using scripts\mp\magicbox;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_ee_nya_cs;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_hornet_ee_nya;

// Namespace zm_sat_hornet_ee_nya
// Params 0, eflags: 0x5
// Checksum 0x7d7c3d9c, Offset: 0x3fd
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"zm_sat_hornet_ee_maneki", undefined, &function_7cf8dacb278a2665, &postmain_init );
}

// Namespace zm_sat_hornet_ee_nya
// Params 0, eflags: 0x4
// Checksum 0x6221fbde, Offset: 0x422
// Size: 0x2
function private function_7cf8dacb278a2665()
{
    
}

// Namespace zm_sat_hornet_ee_nya
// Params 0, eflags: 0x4
// Checksum 0x796d292b, Offset: 0x42c
// Size: 0xec
function private postmain_init()
{
    if ( !getdvarint( @"enable_hornet_sq", 0 ) || !getdvarint( @"hash_d751963f6977a5a6", 1 ) )
    {
        return;
    }
    
    zm_sat_hornet_ee_nya_cs::main();
    level utility::flag_wait( "zm_quest_initialized" );
    level.ee_maneki = zm_quest::get_quest( #"hash_7a4be9bbf8b8856b" );
    zm_quest::register_quest_step( #"hash_7a4be9bbf8b8856b", #"hash_802ff2306181e72", &setup_wait_maneki, &cleanup_wait_maneki );
    zm_quest::register_quest_step( #"hash_7a4be9bbf8b8856b", #"hash_5bcce0128295292c", &function_974da592735bde67, &function_e7864a7d2339dd80 );
    zm_quest::register_quest_step( #"hash_7a4be9bbf8b8856b", #"hash_112a9e88f58f0877", &setup_craft_step, &cleanup_craft_step );
    level zm_save::function_1f44a48caae2acbf();
    level thread zm_quest::start_quest( #"hash_7a4be9bbf8b8856b" );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"give_maneki", &function_90b535a4823e1a1d );
}

// Namespace zm_sat_hornet_ee_nya
// Params 2, eflags: 0x4
// Checksum 0xdc1f0429, Offset: 0x520
// Size: 0x17a
function private setup_wait_maneki( b_skipped, b_save_restored )
{
    var_e8a37b4780ab2f23 = level zm_quest::function_73720cdf21c3cfd7( #"hash_7a4be9bbf8b8856b", #"hash_8ee069599e3e1294" ) ?? 0;
    var_27c330f86a0f22cf = level zm_quest::function_73720cdf21c3cfd7( #"hash_7a4be9bbf8b8856b", #"hash_c7d2ec9fd2c7b24c" ) ?? 0;
    var_834c6c66850820a = level zm_quest::function_73720cdf21c3cfd7( #"hash_7a4be9bbf8b8856b", #"hash_8f70828a48f4af8f" ) ?? 0;
    
    if ( var_e8a37b4780ab2f23 )
    {
        level utility::flag_set( "nya_gunpowder" );
    }
    
    if ( var_27c330f86a0f22cf )
    {
        level utility::flag_set( "nya_flint" );
    }
    
    if ( var_834c6c66850820a )
    {
        level utility::flag_set( "nya_tinder" );
    }
    
    function_e961ebf9515ac470( var_27c330f86a0f22cf, var_834c6c66850820a );
    
    if ( !var_e8a37b4780ab2f23 )
    {
        foreach ( player in level.players )
        {
            player callback::add( #"reload_start", &function_94c3d3a16569d75d );
        }
        
        level callback::add( #"player_connect", &setup_gunpowder_detection );
    }
    
    level utility::flag_wait( "crafted_maneki" );
}

// Namespace zm_sat_hornet_ee_nya
// Params 2, eflags: 0x4
// Checksum 0x894c5b02, Offset: 0x6a2
// Size: 0x15
function private cleanup_wait_maneki( b_skipped, b_save_restored )
{
    
}

// Namespace zm_sat_hornet_ee_nya
// Params 2, eflags: 0x4
// Checksum 0xc5639937, Offset: 0x6bf
// Size: 0x35
function private function_974da592735bde67( b_skipped, b_save_restored )
{
    if ( b_save_restored )
    {
        return;
    }
    
    level utility::flag_wait_all( "nya_gunpowder", "nya_flint", "nya_tinder" );
}

// Namespace zm_sat_hornet_ee_nya
// Params 2, eflags: 0x4
// Checksum 0x334bdeb1, Offset: 0x6fc
// Size: 0x54
function private function_e7864a7d2339dd80( b_skipped, b_save_restored )
{
    if ( b_skipped )
    {
        level utility::flag_set( "nya_gunpowder" );
        level utility::flag_set( "nya_flint" );
        level utility::flag_set( "nya_tinder" );
    }
    
    if ( !b_save_restored )
    {
        level utility::flag_set( "nya_needs_crafting" );
    }
}

// Namespace zm_sat_hornet_ee_nya
// Params 2, eflags: 0x4
// Checksum 0x9a2a3190, Offset: 0x758
// Size: 0x28
function private setup_craft_step( b_skipped, b_save_restored )
{
    if ( !b_save_restored )
    {
        level utility::flag_wait( "nya_crafted" );
    }
}

// Namespace zm_sat_hornet_ee_nya
// Params 2, eflags: 0x4
// Checksum 0x6d58ffac, Offset: 0x788
// Size: 0x12b
function private cleanup_craft_step( b_skipped, b_save_restored )
{
    level utility::flag_set( "nya_crafted" );
    level callback::add( #"hash_4cc399a485ab171d", &function_51a91bd3d2250bd1 );
    scriptable::scriptable_adddamagedcallback( &function_6ee8e6657282ebba );
    magicbox::function_1b154b89e87377fa( &function_3e7041d36c745933 );
    level callback::add( "magicbox_used", &function_1bda5e49ccb9d72f );
    level.ee_maneki.var_f11ef9f21f5bf1da = 1500;
    level.ee_maneki.var_f70b3d500d243059 = 0;
    
    foreach ( player in level.players )
    {
        player callback::add( #"player_item_drop", &function_5af739a871ca6bc2 );
    }
    
    level callback::add( #"player_connect", &function_56d68fa18c72ec99 );
}

// Namespace zm_sat_hornet_ee_nya
// Params 1, eflags: 0x4
// Checksum 0x404c4ad0, Offset: 0x8bb
// Size: 0x21
function private function_56d68fa18c72ec99( sparams )
{
    callback::add( #"player_item_drop", &function_5af739a871ca6bc2 );
}

// Namespace zm_sat_hornet_ee_nya
// Params 1, eflags: 0x4
// Checksum 0x37576a84, Offset: 0x8e4
// Size: 0x61
function private function_5af739a871ca6bc2( params )
{
    item = params.item;
    
    if ( !item )
    {
        return;
    }
    
    if ( item.type && issubstr( item.type, "maneki" ) )
    {
        item setscriptablepartstate( "zmloot_sat_offhand_maneki_neko", "dropped_glow" );
    }
}

// Namespace zm_sat_hornet_ee_nya
// Params 0, eflags: 0x4
// Checksum 0x8531c4a, Offset: 0x94d
// Size: 0xfb
function private function_5f0e83d6823c2c3d()
{
    level utility::flag_wait( "scriptables_ready" );
    s_tinder = utility::getstruct( "ny_tdr_sp", "targetname" );
    offset = 15 * anglestoforward( s_tinder.angles );
    
    if ( s_tinder )
    {
        tinder_mdl = utility::spawn_model( %"misc_vm_matchbox_prop", s_tinder.origin, s_tinder.angles );
        setup_item_pickup( "tinder", tinder_mdl, offset );
    }
    
    s_flint = utility::getstruct( "ny_nug_sp", "targetname" );
    offset = 15 * anglestoforward( s_flint.angles );
    
    if ( s_tinder )
    {
        flint_mdl = utility::spawn_model( %"t10_rocks_coal_nugget_03", s_flint.origin, s_flint.angles );
        setup_item_pickup( "flint", flint_mdl, offset );
    }
}

// Namespace zm_sat_hornet_ee_nya
// Params 2, eflags: 0x4
// Checksum 0xfa23704c, Offset: 0xa50
// Size: 0x11a
function private function_e961ebf9515ac470( var_27c330f86a0f22cf, var_834c6c66850820a )
{
    level utility::flag_wait( "scriptables_ready" );
    
    if ( !var_834c6c66850820a )
    {
        s_tinder = utility::getstruct( "ny_tdr_sp", "targetname" );
        
        if ( s_tinder )
        {
            offset = 15 * anglestoforward( s_tinder.angles );
            tinder_mdl = utility::spawn_model( %"misc_vm_matchbox_prop", s_tinder.origin, s_tinder.angles );
            setup_item_pickup( "tinder", tinder_mdl, offset );
        }
    }
    
    if ( !var_27c330f86a0f22cf )
    {
        s_flint = utility::getstruct( "ny_nug_sp", "targetname" );
        
        if ( s_flint )
        {
            offset = 15 * anglestoforward( s_flint.angles );
            flint_mdl = utility::spawn_model( %"t10_rocks_coal_nugget_03", s_flint.origin, s_flint.angles );
            setup_item_pickup( "flint", flint_mdl, offset );
        }
    }
}

// Namespace zm_sat_hornet_ee_nya
// Params 3, eflags: 0x4
// Checksum 0x26e4d77c, Offset: 0xb72
// Size: 0x7a
function private setup_item_pickup( var_b603a7fc89cd1871, mdl, offset = ( 0, 0, 0 ) )
{
    var_8713485142ad4620 = interaction::register_interact( mdl.origin + offset, 64, &nya_on_pickup_item, undefined, undefined, undefined, 1 );
    var_8713485142ad4620.var_b603a7fc89cd1871 = var_b603a7fc89cd1871;
    var_8713485142ad4620.mdl = mdl;
}

// Namespace zm_sat_hornet_ee_nya
// Params 0, eflags: 0x4
// Checksum 0xb7c58e8a, Offset: 0xbf4
// Size: 0xf4
function private setup_flint_spawn()
{
    level endon( #"hash_a23825cfafca43bb" );
    
    while ( true )
    {
        level waittill( #"hash_5d12c982d0942ee5", spawn_loc );
        nearby_point = math::function_78a5b128a3e32460( spawn_loc, 75 );
        nearby_point = getclosestpointonnavmesh( nearby_point ) + ( 0, 0, 5 );
        midpoint = ( nearby_point + spawn_loc ) / 2 + ( 0, 0, 50 );
        flint = utility::spawn_model( %"t10_rocks_coal_nugget_03", spawn_loc, undefined, undefined, 8 );
        flint utility::function_8001268940441423( spawn_loc, nearby_point, midpoint, 0.75 );
        setup_item_pickup( "flint", flint, ( 0, 0, 40 ) );
        
        /#
            sphere( flint.origin, 25, ( 255, 255, 0 ), 0, 6000 );
        #/
        
        wait 15;
        flint delete();
    }
}

// Namespace zm_sat_hornet_ee_nya
// Params 1, eflags: 0x4
// Checksum 0xe77c0844, Offset: 0xcf0
// Size: 0x21
function private setup_gunpowder_detection( params )
{
    callback::add( #"reload_start", &function_94c3d3a16569d75d );
}

// Namespace zm_sat_hornet_ee_nya
// Params 1, eflags: 0x4
// Checksum 0x24d83bb3, Offset: 0xd19
// Size: 0x206
function private function_94c3d3a16569d75d( params )
{
    player = params.player;
    
    if ( !isalive( player ) )
    {
        return;
    }
    
    var_2747e0528b1f176 = level.murder_holes_root.var_2747e0528b1f176;
    
    for ( i = 0; i < var_2747e0528b1f176.size ; i++ )
    {
        trap = var_2747e0528b1f176[ i ];
        
        if ( !trap.var_711e3c9a288e87ff )
        {
            continue;
        }
        
        a_ghosts = trap.a_ghosts;
        
        for ( j = 0; j < a_ghosts.size ; j++ )
        {
            ghost = a_ghosts[ j ];
            
            if ( distancesquared( player.origin, ghost.origin ) <= 5625 )
            {
                ground_pos = ( ghost.origin[ 0 ], ghost.origin[ 1 ], 780 );
                ground_pos = getgroundposition( ground_pos, 1, 15 );
                gunpowder = utility::spawn_model( %"sat_zm_chemistry_bench_white_powder", ground_pos );
                setup_item_pickup( "gunpowder", gunpowder, ( 0, 0, 15 ) );
                
                /#
                    sphere( gunpowder.origin, 25, ( 255, 255, 0 ), 0, 6000 );
                #/
                
                level callback::remove( #"player_connect", &setup_gunpowder_detection );
                
                foreach ( player in level.players )
                {
                    player callback::remove( #"reload_start", &function_94c3d3a16569d75d );
                }
                
                return;
            }
        }
    }
}

// Namespace zm_sat_hornet_ee_nya
// Params 1, eflags: 0x4
// Checksum 0x58002ec4, Offset: 0xf27
// Size: 0xea
function private nya_on_pickup_item( player )
{
    var_b603a7fc89cd1871 = self.var_b603a7fc89cd1871;
    mdl = self.mdl;
    player playsoundtoplayer( "uin_zm_common_pickup_item", player );
    level utility::flag_set( "nya_" + var_b603a7fc89cd1871 );
    
    switch ( var_b603a7fc89cd1871 )
    {
        case #"hash_e2bfc6678a54d480":
            level zm_quest::function_4eefe6de31f5ddab( #"hash_7a4be9bbf8b8856b", #"hash_8ee069599e3e1294", 1 );
            break;
        case #"hash_6bcbdf4664a27f40":
            level zm_quest::function_4eefe6de31f5ddab( #"hash_7a4be9bbf8b8856b", #"hash_c7d2ec9fd2c7b24c", 1 );
            break;
        case #"hash_eb02d9efa8ad92b":
            level zm_quest::function_4eefe6de31f5ddab( #"hash_7a4be9bbf8b8856b", #"hash_8f70828a48f4af8f", 1 );
            break;
    }
    
    mdl delete();
    self delete();
}

// Namespace zm_sat_hornet_ee_nya
// Params 2, eflags: 0x4
// Checksum 0x5a14958c, Offset: 0x1019
// Size: 0xb6
function private function_c0b901347fe410dd( usable, player )
{
    if ( player.interactions_disabled )
    {
        return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
    }
    
    if ( !level utility::flag( "nya_all_parts_collected" ) )
    {
        return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"hash_13f1ab4a9bad547b", #type:"HINT_BUTTON" };
}

// Namespace zm_sat_hornet_ee_nya
// Params 1, eflags: 0x4
// Checksum 0xbe2cfeed, Offset: 0x10d8
// Size: 0x4d
function private function_51a91bd3d2250bd1( sparams )
{
    grenade = sparams.grenade;
    player = grenade.owner;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    player thread function_96531df36832017c( grenade );
}

// Namespace zm_sat_hornet_ee_nya
// Params 1, eflags: 0x4
// Checksum 0x7d28a1ea, Offset: 0x112d
// Size: 0x235
function private function_96531df36832017c( grenade )
{
    level endon( #"game_ended" );
    wait 0.7;
    deploy_origin = grenade.origin ?? self.maneki_neko.origin;
    deploy_angles = grenade.angles ?? self.maneki_neko.origin;
    
    if ( !isdefined( deploy_origin ) )
    {
        return;
    }
    
    anchor = spawn( "script_origin", deploy_origin + ( 0, 0, 0 ) );
    anchor.angles = deploy_angles;
    
    if ( self.nyashields.size >= 1 )
    {
        nya_shield_end( self.nyashields[ 0 ] );
    }
    
    data = function_b5aa354693adf730();
    shield = nya_spawn_shield( anchor, data );
    shield thread function_db39a4e15b09a712( data.lifetime );
    
    if ( data.var_1956e86f35009d24 && data.var_2417fceafb5af915 )
    {
        assert( data.var_1956e86f35009d24 >= data.var_2417fceafb5af915, "<dev string:x24>" );
        var_e4ef945ff07e0fa7 = data.lifetime - data.var_1956e86f35009d24;
        var_7214160b86d92c98 = data.var_1956e86f35009d24 - data.var_2417fceafb5af915;
        shield thread function_ef399dc963f62399( var_e4ef945ff07e0fa7, var_7214160b86d92c98 );
    }
    
    thread function_4b2fd668ad0da643( shield );
    shield thread function_29ac64e2b9d75eda();
    
    foreach ( shield in self.nyashields )
    {
        if ( !shield.var_f044089a73ddebd8 )
        {
            shield.var_f044089a73ddebd8 = 1;
            shield thread function_42601dec206714b0( anchor );
        }
    }
}

// Namespace zm_sat_hornet_ee_nya
// Params 0, eflags: 0x4
// Checksum 0x3dccdbbc, Offset: 0x136a
// Size: 0xa8
function private function_b5aa354693adf730()
{
    return { #var_6708353a02eb3e88:1, #var_bcc9d12e86a3096d:1.015, #submixkey:"mp_sat_ob_gemini_elevator_buzzer", #var_7466ff13ec4679d4:"sndevent_ob_bubble_shield_plr_exit", #var_c272397339d03bc2:"sndevent_ob_bubble_shield_plr_enter", #var_fd66655416004272:1.39, #var_8d82e19b407e8a9d:1, #var_2417fceafb5af915:5, #var_1956e86f35009d24:10, #var_6ed782b00e2247f:0.25, #var_3080e759a26cd844:0.7, #lifetime:21, #health:7000 };
}

// Namespace zm_sat_hornet_ee_nya
// Params 2, eflags: 0x4
// Checksum 0x7cc4158, Offset: 0x141b
// Size: 0x4a1
function private nya_spawn_shield( anchor, data )
{
    teampayload = [ #"teamselect", self.team ];
    shield = spawnscriptable( %"super_bubble_shield_hornet", ( 0, 0, 0 ), ( 0, 0, 0 ), anchor, teampayload );
    shield.connectedplayer = self;
    shield.var_3080e759a26cd844 = data.var_3080e759a26cd844;
    shield.var_6ed782b00e2247f = data.var_6ed782b00e2247f;
    shield.maxhealth = max( data.health, 1 );
    shield.health = data.health;
    shield.radius = function_decb653c5689e4ca( %"sat_electronics_bubble_shield_02" )[ 1 ];
    shield.var_c272397339d03bc2 = data.var_c272397339d03bc2;
    shield.var_7466ff13ec4679d4 = data.var_7466ff13ec4679d4;
    shield.submixkey = data.submixkey;
    shield.var_cd361b3d06fd5f62 = data.var_bcc9d12e86a3096d ? shield.radius * data.var_bcc9d12e86a3096d : shield.radius;
    shield.var_6708353a02eb3e88 = data.var_6708353a02eb3e88;
    shield.var_8d82e19b407e8a9d = data.var_8d82e19b407e8a9d;
    shield.anchor = anchor;
    assert( data.var_8d82e19b407e8a9d > 0, "<dev string:x61>" );
    shield.badplaceid = createnavbadplacebyshape( anchor.origin, anchor.angles, 8, data.var_8d82e19b407e8a9d * shield.radius, shield.radius, "team_two_hundred" );
    
    if ( data.var_fd66655416004272 > 0 )
    {
        shield.zombieattractor = zombie_attractor_manager::add_attractor( shield, 1, shield.radius * data.var_fd66655416004272, 1, &function_5f499394d9855ee8, &function_530f8302be742521 );
    }
    
    if ( !isdefined( level.var_be38db58a3f49ac9 ) )
    {
        level.var_be38db58a3f49ac9 = [];
    }
    
    level.var_be38db58a3f49ac9[ level.var_be38db58a3f49ac9.size ] = shield;
    
    if ( !isdefined( self.nyashields ) )
    {
        self.nyashields = [];
    }
    
    self.nyashields[ self.nyashields.size ] = shield;
    shield.shieldscriptable = shield;
    shield.var_f044089a73ddebd8 = 0;
    shieldtrigger = spawn( "trigger_radius", shield.origin, 0, shield.radius, shield.radius );
    shieldtrigger.owner = shield;
    shieldtrigger.var_8ab0e58f0bcb46ff = 0;
    
    if ( utility::issharedfuncdefined( #"game", #"makeenterexittrigger" ) )
    {
        [[ utility::getsharedfunc( #"game", #"makeenterexittrigger" ) ]]( shieldtrigger, &function_e3aca3930b44a486, &nya_exit_shield_radius );
    }
    
    shieldtrigger enablelinkto();
    shieldtrigger linkto( anchor );
    shield.shieldtrigger = shieldtrigger;
    anchor thread function_6be3681e1acff678( shieldtrigger );
    anchor thread function_efd6fdca0f32fe84( shield );
    potential_targets = getaiarrayinradius( anchor.origin, shield.radius );
    
    foreach ( target in potential_targets )
    {
        if ( isalive( target ) && ( !isdefined( target.aicategory ) || target.aicategory == "normal" ) && !target zombie_knockdown::function_19d6107cb6bdff5c() )
        {
            target zombie_knockdown::function_6fc167d4a3590991( anchor.origin, 275, 30 );
            target thread val::set_for_time( 5, "nya_bbl_shld", "ignore_ai_collision", 1 );
        }
    }
    
    return shield;
}

// Namespace zm_sat_hornet_ee_nya
// Params 2, eflags: 0x4
// Checksum 0xed1ca5f1, Offset: 0x18c5
// Size: 0x2c, Type: bool
function private function_530f8302be742521( attractor, zombie )
{
    return attractor.source.var_5512e79e2c1c0098 > 0;
}

// Namespace zm_sat_hornet_ee_nya
// Params 2, eflags: 0x4
// Checksum 0xa598246f, Offset: 0x18fa
// Size: 0x6b
function private function_5f499394d9855ee8( attractor, zombie )
{
    shield = attractor.source;
    offset = vectornormalize2( zombie.origin - shield.origin );
    goalpoint = shield.origin + offset;
    return goalpoint;
}

// Namespace zm_sat_hornet_ee_nya
// Params 2
// Checksum 0x1a78ba92, Offset: 0x196e
// Size: 0xe7
function function_e3aca3930b44a486( player, trigger )
{
    if ( isplayer( player ) )
    {
        if ( trigger.owner )
        {
            trigger.owner.var_5512e79e2c1c0098 = ( trigger.owner.var_5512e79e2c1c0098 ?? 0 ) + 1;
        }
        
        if ( !isdefined( player.var_655151ca5dfd0770 ) )
        {
            player.var_655151ca5dfd0770 = [];
        }
        
        player.var_655151ca5dfd0770[ player.var_655151ca5dfd0770.size ] = trigger.owner;
        player.var_b6f2224be9ed1a1b = 1;
        player.inside_bubble_shield = 1;
        player.bubble_origin = trigger.origin;
        player.trigger = trigger;
        player thread function_1d149b4daa7b6277();
    }
}

// Namespace zm_sat_hornet_ee_nya
// Params 2
// Checksum 0xac553a9, Offset: 0x1a5d
// Size: 0xca
function nya_exit_shield_radius( player, trigger )
{
    if ( isplayer( player ) && player function_4deab75c94b141ca() )
    {
        if ( trigger.owner.var_5512e79e2c1c0098 )
        {
            trigger.owner.var_5512e79e2c1c0098 -= 1;
        }
        
        player.var_655151ca5dfd0770 = arrayremove( player.var_655151ca5dfd0770, trigger.owner );
        
        if ( player.var_655151ca5dfd0770.size == 0 )
        {
            player.var_b6f2224be9ed1a1b = undefined;
            player.inside_bubble_shield = undefined;
            player notify( #"nya_exit_shield" );
        }
    }
}

// Namespace zm_sat_hornet_ee_nya
// Params 1, eflags: 0x4
// Checksum 0x6c265640, Offset: 0x1b2f
// Size: 0x144
function private nya_delete_trigger( trigger )
{
    if ( !trigger.owner )
    {
        return;
    }
    
    playersinradius = getplayersinradius( trigger.owner.origin, trigger.owner.radius + 200, trigger.owner.radius + 200 );
    
    foreach ( player in playersinradius )
    {
        nya_exit_shield_radius( player, trigger );
        
        if ( arraycontains( trigger.owner.var_ac0fc14229cfc93b, player ) )
        {
            player playsoundevent( trigger.owner.var_7466ff13ec4679d4 );
            player clearsoundsubmix( trigger.owner.submixkey );
        }
    }
    
    if ( trigger )
    {
        trigger delete();
    }
}

// Namespace zm_sat_hornet_ee_nya
// Params 1, eflags: 0x4
// Checksum 0xa3805fb1, Offset: 0x1c7b
// Size: 0x22
function private function_6be3681e1acff678( trigger )
{
    self waittill( #"death" );
    nya_delete_trigger( trigger );
}

// Namespace zm_sat_hornet_ee_nya
// Params 1, eflags: 0x4
// Checksum 0xc8b405af, Offset: 0x1ca5
// Size: 0x282
function private function_efd6fdca0f32fe84( shield )
{
    self endon( #"death" );
    shield endon( #"hash_ab18f8939b3090f6" );
    
    while ( true )
    {
        players_in_radius = getplayersinradius( shield.origin, shield.var_cd361b3d06fd5f62, shield.var_cd361b3d06fd5f62 );
        
        if ( !isdefined( shield.var_ac0fc14229cfc93b ) )
        {
            shield.var_ac0fc14229cfc93b = [];
        }
        
        current_players = [];
        
        foreach ( player in players_in_radius )
        {
            eyepos = player geteye();
            dist = distance( eyepos, shield.origin );
            
            if ( dist <= shield.var_cd361b3d06fd5f62 )
            {
                if ( !isdefined( current_players ) )
                {
                    current_players = [];
                }
                
                current_players[ current_players.size ] = player;
                
                if ( !arraycontains( shield.var_ac0fc14229cfc93b, player ) )
                {
                    if ( shield.var_c272397339d03bc2 )
                    {
                        player playsoundevent( shield.var_c272397339d03bc2 );
                    }
                    
                    if ( shield.submixkey )
                    {
                        player setsoundsubmix( shield.submixkey );
                    }
                    
                    if ( !isdefined( shield.var_ac0fc14229cfc93b ) )
                    {
                        shield.var_ac0fc14229cfc93b = [];
                    }
                    
                    shield.var_ac0fc14229cfc93b[ shield.var_ac0fc14229cfc93b.size ] = player;
                }
            }
        }
        
        players_to_remove = arrayremove( shield.var_ac0fc14229cfc93b, current_players );
        
        foreach ( player in players_to_remove )
        {
            player playsoundevent( shield.var_7466ff13ec4679d4 );
            player clearsoundsubmix( shield.submixkey );
            shield.var_ac0fc14229cfc93b = arrayremove( shield.var_ac0fc14229cfc93b, player );
        }
        
        wait 0.3;
    }
}

// Namespace zm_sat_hornet_ee_nya
// Params 0, eflags: 0x4
// Checksum 0x2572f653, Offset: 0x1f2f
// Size: 0xda
function private function_29ac64e2b9d75eda()
{
    self endon( #"hash_ab18f8939b3090f6" );
    
    while ( true )
    {
        ai_array = getaiarrayinradius( self.origin, self.radius );
        
        foreach ( agent in ai_array )
        {
            if ( agent.agentteam == "team_two_hundred" )
            {
                agent effect_slow::slow( "nya_shield", 0.55, 0.5, self.connectedplayer );
            }
        }
        
        wait 0.5;
    }
}

// Namespace zm_sat_hornet_ee_nya
// Params 11
// Checksum 0x34518a6f, Offset: 0x2011
// Size: 0x17c
function function_6ee8e6657282ebba( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( !( isdefined( instance ) && isdefined( instance.type ) ) || instance.type != %"super_bubble_shield_hornet" )
    {
        return;
    }
    
    if ( smeansofdeath == "MOD_MELEE" )
    {
        if ( !instance.var_6708353a02eb3e88 || !isagent( eattacker ) )
        {
            return;
        }
    }
    
    if ( !utility::playerwithindistance( eattacker, instance.origin, instance.radius ) )
    {
        instance.health -= idamage;
    }
    
    healthpercent = instance.health / instance.maxhealth;
    
    if ( instance.health <= 0 )
    {
        instance notify( #"nya_shield_broken" );
        return;
    }
    
    if ( healthpercent <= instance.var_6ed782b00e2247f )
    {
        instance function_21ad722dcb713679( "shield_heavy_damaged" );
        return;
    }
    
    if ( healthpercent <= instance.var_3080e759a26cd844 )
    {
        instance function_21ad722dcb713679( "shield_light_damaged" );
    }
}

// Namespace zm_sat_hornet_ee_nya
// Params 1, eflags: 0x4
// Checksum 0xd4cff62d, Offset: 0x2195
// Size: 0x4d
function private function_21ad722dcb713679( new_state )
{
    currentstate = self getscriptablepartstate( "shield_base" );
    
    if ( currentstate != new_state )
    {
        self setscriptablepartstate( "shield_base", new_state );
        
        if ( new_state == "shield_heavy_damaged" )
        {
            self notify( #"nya_shield_heavy_damage" );
        }
    }
}

// Namespace zm_sat_hornet_ee_nya
// Params 1, eflags: 0x4
// Checksum 0xcb6ff504, Offset: 0x21ea
// Size: 0x33
function private function_db39a4e15b09a712( lifetime )
{
    self endon( #"hash_ab18f8939b3090f6" );
    self endon( #"hash_66f5b8599014f2e1" );
    wait lifetime;
    self notify( #"nya_shield_end" );
}

// Namespace zm_sat_hornet_ee_nya
// Params 2, eflags: 0xc
// Checksum 0x51e9af3b, Offset: 0x2225
// Size: 0x60
function private function_ef399dc963f62399( var_e4ef945ff07e0fa7, var_7214160b86d92c98 )
{
    self notify( #"hash_ccc4c3ee0b188566" );
    self endon( #"hash_ccc4c3ee0b188566" );
    self endon( #"hash_ab18f8939b3090f6", #"nya_shield_heavy_damage" );
    wait var_e4ef945ff07e0fa7;
    function_21ad722dcb713679( "shield_light_damaged" );
    wait var_7214160b86d92c98;
    function_21ad722dcb713679( "shield_heavy_damaged" );
}

// Namespace zm_sat_hornet_ee_nya
// Params 1, eflags: 0x4
// Checksum 0x56835db4, Offset: 0x228d
// Size: 0x55
function private function_4b2fd668ad0da643( shield )
{
    shield endon( #"death" );
    shield endon( #"hash_66f5b8599014f2e1" );
    result = shield utility::waittill_any_return( "nya_shield_end", "nya_shield_broken", "game_ended" );
    nya_shield_end( shield, 0, result );
}

// Namespace zm_sat_hornet_ee_nya
// Params 1, eflags: 0x4
// Checksum 0xfb473f50, Offset: 0x22ea
// Size: 0x40
function private function_42601dec206714b0( anchor )
{
    self waittill( #"hash_ab18f8939b3090f6", end_reason );
    
    if ( end_reason == "game_ended" )
    {
        return;
    }
    
    wait 1;
    
    if ( anchor )
    {
        anchor delete();
    }
}

// Namespace zm_sat_hornet_ee_nya
// Params 3, eflags: 0x4
// Checksum 0xe7245acd, Offset: 0x2332
// Size: 0x212
function private nya_shield_end( shield, skipstatechange = 0, end_reason )
{
    if ( !skipstatechange )
    {
        shield.shieldscriptable setscriptablepartstate( "shield_base", "shield_destroyed" );
    }
    
    shield notify( #"hash_ab18f8939b3090f6", end_reason );
    level notify( #"nya_shield_terminated" );
    
    if ( shield.badplaceid )
    {
        destroynavobstacle( shield.badplaceid );
        shield.badplaceid = undefined;
    }
    
    if ( shield.zombieattractor )
    {
        zombie_attractor_manager::remove_attractor( shield.zombieattractor );
    }
    
    level.var_be38db58a3f49ac9 = arrayremove( level.var_be38db58a3f49ac9, shield );
    
    if ( shield.connectedplayer )
    {
        shield.connectedplayer.nyashields = arrayremove( shield.connectedplayer.nyashields, shield );
    }
    
    potential_targets = getaiarrayinradius( shield.origin, shield.radius + 50 );
    counter = 0;
    
    foreach ( target in potential_targets )
    {
        if ( isalive( target ) && ( !isdefined( target.aicategory ) || target.aicategory == "normal" ) )
        {
            target.forceannihilate = 1;
            target kill();
            counter++;
            
            if ( counter % 3 == 0 )
            {
                waitframe();
            }
        }
    }
    
    if ( !skipstatechange )
    {
        wait 1;
    }
    
    shield.shieldscriptable freescriptable();
    shield.shieldscriptable = undefined;
}

// Namespace zm_sat_hornet_ee_nya
// Params 0, eflags: 0x4
// Checksum 0xd8cdc95d, Offset: 0x254c
// Size: 0x1b, Type: bool
function private function_4deab75c94b141ca()
{
    return self.var_655151ca5dfd0770 && self.var_655151ca5dfd0770.size > 0;
}

// Namespace zm_sat_hornet_ee_nya
// Params 0, eflags: 0xc
// Checksum 0xcb810451, Offset: 0x2570
// Size: 0xc1
function private function_1d149b4daa7b6277()
{
    self notify( #"hash_bdb3c6efb461fcfb" );
    self endon( #"hash_bdb3c6efb461fcfb" );
    self endon( #"disconnect" );
    self notify( #"hash_511081e0254ffbe6" );
    self endon( #"hash_511081e0254ffbe6" );
    root = powerups::get_powerups_root();
    self [[ root.var_a53a6962d153065f ]]( 2 );
    utility::callsharedfunc( #"powerup_double_points", #"apply_effect" );
    utility::waittill_any( "nya_exit_shield", "death" );
    self [[ root.var_a53a6962d153065f ]]( 1 );
    utility::callsharedfunc( #"powerup_double_points", #"remove_effect" );
    self notify( #"hash_ac5614462d6f7a81" );
}

// Namespace zm_sat_hornet_ee_nya
// Params 1, eflags: 0x4
// Checksum 0x8ffbb119, Offset: 0x2639
// Size: 0x158
function private function_1bda5e49ccb9d72f( params )
{
    player = self;
    var_be85f46825694ebe = [];
    
    foreach ( p in level.players )
    {
        if ( isdefined( p.maneki_neko ) )
        {
            var_be85f46825694ebe[ var_be85f46825694ebe.size ] = p.maneki_neko;
        }
    }
    
    if ( var_be85f46825694ebe.size <= 0 )
    {
        return;
    }
    
    near_neko = function_507735afa749bd37( var_be85f46825694ebe, params.var_349a0723ed9ac19c );
    
    if ( !isdefined( near_neko ) )
    {
        return;
    }
    
    if ( randomfloat( 100 ) < 10 && level.ee_maneki.var_f70b3d500d243059 < 2 )
    {
        level.var_aef038a20b4915b3 = "zm_sat_item_weapon_ww_hornet";
        player.var_12b5f0920bfd3f5d = undefined;
        params.var_349a0723ed9ac19c thread function_372d3d741aee39b9();
    }
    else
    {
        player.var_12b5f0920bfd3f5d = 1;
    }
    
    near_neko thread function_dbef79cc85b63511( params.var_349a0723ed9ac19c, player );
}

// Namespace zm_sat_hornet_ee_nya
// Params 0, eflags: 0x4
// Checksum 0xb001b06c, Offset: 0x2799
// Size: 0xd
function private function_372d3d741aee39b9()
{
    waitframe();
    level.var_aef038a20b4915b3 = undefined;
}

// Namespace zm_sat_hornet_ee_nya
// Params 3, eflags: 0x4
// Checksum 0x35d464a0, Offset: 0x27ae
// Size: 0x61
function private function_3e7041d36c745933( player, str_override_rarity, var_4b076b5c2a1741db )
{
    if ( !player.var_12b5f0920bfd3f5d )
    {
        return;
    }
    
    player.var_12b5f0920bfd3f5d = undefined;
    n_next_ultra = function_19c974b46e26316a();
    
    if ( randomfloat( 100 ) < n_next_ultra )
    {
        return level.var_8b6bf63f61fe01f9;
    }
}

// Namespace zm_sat_hornet_ee_nya
// Params 0, eflags: 0x4
// Checksum 0xb2c8055, Offset: 0x2818
// Size: 0xb9, Type: bool
function private function_19c974b46e26316a()
{
    n_round = zm_utility::get_round_number();
    n_current_index = undefined;
    a_scaling = level.s_magicbox_scaling.var_e706c54ff9d8cadc;
    
    for ( i = 0; i < a_scaling.size ; i++ )
    {
        if ( n_round >= a_scaling[ i ].minround && n_round <= a_scaling[ i ].maxround )
        {
            n_current_index = i;
            break;
        }
    }
    
    if ( !isdefined( n_current_index ) )
    {
        return false;
    }
    
    n_next_index = n_current_index + 1;
    
    if ( n_next_index >= a_scaling.size )
    {
        n_next_index = n_current_index;
    }
    
    return a_scaling[ n_next_index ].ultrachance ?? 0;
}

// Namespace zm_sat_hornet_ee_nya
// Params 2, eflags: 0x4
// Checksum 0x22e540a, Offset: 0x28da
// Size: 0xa2
function private function_507735afa749bd37( a_maneki, var_349a0723ed9ac19c )
{
    foreach ( neko in a_maneki )
    {
        if ( distance2dsquared( neko.origin, var_349a0723ed9ac19c.origin ) < 40000 )
        {
            return neko;
        }
    }
}

// Namespace zm_sat_hornet_ee_nya
// Params 2, eflags: 0x4
// Checksum 0xb12ab5c3, Offset: 0x2985
// Size: 0x187
function private function_dbef79cc85b63511( var_349a0723ed9ac19c, player )
{
    level endon( #"game_ended" );
    
    if ( level utility::flag( "mq_step_8_complete" ) && !level utility::flag( "mq_step_9_complete" ) )
    {
        return;
    }
    
    self.var_2bcafe8bb5fe1d06 = 1;
    var_bde78d153e185e1b = level.var_aef038a20b4915b3 == "zm_sat_item_weapon_ww_hornet";
    bob_pos = var_349a0723ed9ac19c.origin + ( 0, 0, 58 );
    self moveto( bob_pos, 0.6 );
    self rotateto( var_349a0723ed9ac19c.angles + ( 0, 90, 0 ), 0.6 );
    wait 0.6;
    
    if ( isdefined( player.nyashields[ 0 ] ) )
    {
        player.nyashields[ 0 ] notify( #"hash_66f5b8599014f2e1" );
    }
    
    wait 5;
    
    if ( var_bde78d153e185e1b )
    {
        level.ee_maneki.var_f70b3d500d243059++;
    }
    
    self.var_2bcafe8bb5fe1d06 = undefined;
    
    if ( isdefined( player.nyashields[ 0 ] ) )
    {
        player nya_shield_end( player.nyashields[ 0 ] );
    }
    
    if ( self.t_maneki.var_7c00f823b7c297d4 )
    {
        destroynavobstacle( self.t_maneki.var_7c00f823b7c297d4 );
    }
    
    if ( isdefined( self ) )
    {
        self moveto( var_349a0723ed9ac19c.origin, 0.6, 0.6, 0 );
    }
}

// Namespace zm_sat_hornet_ee_nya
// Params 1, eflags: 0x4
// Checksum 0x25e023ab, Offset: 0x2b14
// Size: 0xc8
function private function_90b535a4823e1a1d( params )
{
    level utility::flag_set( "crafted_maneki" );
    level utility::flag_set( "nya_crafted" );
    level callback::add( #"hash_4cc399a485ab171d", &function_51a91bd3d2250bd1 );
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) )
        {
            player crafting_table::craft_give_equipment( "equip_attractor", "secondary" );
        }
    }
}

