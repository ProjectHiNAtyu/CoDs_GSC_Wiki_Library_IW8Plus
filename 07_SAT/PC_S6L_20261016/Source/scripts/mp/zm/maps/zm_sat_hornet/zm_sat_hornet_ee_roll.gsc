// scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_ee_roll.gsc  (hash_0959e1f542272fda.gscc) (size: 17569 Bytes / 0x44a1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8f6067e5 (2405459941)
// size ...... 17569 (0x44a1)
// includes .. 16  (offset: 0x4009)
// strings ... 64  (offset: 0x4089)
// dev strs .. 0   (offset: 0x44a1)
// exports ... 43  (offset: 0x28d1)
// cseg ...... 0x471 + 0x2460 (0x28d1)
// imports ... 135 (offset: 0x2f89)
// animtree1 . 0   (offset: 0x44a1)
// animtree2 . 0   (offset: 0x44a1)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\class;
#using scripts\mp\currency;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_ee_roll_cs;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_weather_ash;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;

#namespace zm_sat_hornet_ee_roll;

// Namespace zm_sat_hornet_ee_roll
// Params 0, eflags: 0x5
// Checksum 0xc36453e1, Offset: 0x48f
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"zm_sat_hornet_ee_roll", #"zm_quest", &function_7cf8dacb278a2665, &postmain_init );
}

// Namespace zm_sat_hornet_ee_roll
// Params 0, eflags: 0x4
// Checksum 0x505c19ee, Offset: 0x4bc
// Size: 0x1b
function private function_7cf8dacb278a2665()
{
    level._effect[ "celebrate_confetti" ] = loadfxasset( "vfx_sat_firefly_confetti_falling_cam" );
}

// Namespace zm_sat_hornet_ee_roll
// Params 0, eflags: 0x4
// Checksum 0x24d52b40, Offset: 0x4df
// Size: 0x16f
function private postmain_init()
{
    if ( !getdvarint( @"enable_hornet_sq", 0 ) || !getdvarint( @"hash_af29da0589cc9b9", 1 ) )
    {
        return;
    }
    
    namespace_b427b0e71c21a1b5::main();
    level utility::flag_wait( "zm_quest_initialized" );
    level.ee_roll = zm_quest::get_quest( #"hornet_ee_roll" );
    level.ee_roll.var_170dd9432044afb5 = 0;
    level.ee_roll.var_686ed4e0b6cb8bb9 = 0;
    level.ee_roll.a_trail_path = build_trail_path();
    level.ee_roll.var_fada4ab6d64960f1 = 2.5;
    level.ee_roll.var_8349343dfac96e71 = 1.5;
    scriptable::scriptable_adddamagedcallback( &function_145bfe89ae0313e5 );
    zm_quest::register_quest_step( #"hornet_ee_roll", #"cleanse_loc", &setup_purify_machine, &cleanup_purify_machine );
    level zm_save::function_1f44a48caae2acbf();
    level thread zm_quest::start_quest( #"hornet_ee_roll" );
    level thread function_b050bb87edfd6807();
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"charm_maneki", &function_117a9ca9647f8787 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"charm_pufferfish", &function_1fe555ddab82c1e2 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"charm_automaton", &function_c503e2601e2dbfd2 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"charm_ninja_kite", &function_cb297ed3daf76986 );
}

// Namespace zm_sat_hornet_ee_roll
// Params 2, eflags: 0x4
// Checksum 0x71ea2be4, Offset: 0x656
// Size: 0xdd
function private setup_purify_machine( b_skipped, b_save_restored )
{
    level thread function_c9d1422140f296d6();
    level waittill( "sh_" + "zone_second_bailey" + "_cl" );
    
    if ( !level.ee_roll.var_170dd9432044afb5 )
    {
        level.ee_roll.var_170dd9432044afb5 = 1;
        
        foreach ( player in level.players )
        {
            player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( "hornet_gachapon_purify_ash_first_time" );
        }
    }
}

// Namespace zm_sat_hornet_ee_roll
// Params 0, eflags: 0x4
// Checksum 0x30c3bd9d, Offset: 0x73b
// Size: 0x7f
function private function_c9d1422140f296d6()
{
    level utility::flag_wait( "scriptables_ready" );
    s_spawn = utility::getstruct( "gch_bar" );
    level.ee_roll.var_75385495715741fb = spawnscriptable( %"zm_sat_hornet_gch", s_spawn.origin, s_spawn.angles );
    level.ee_roll.var_75385495715741fb setscriptablepartstate( "model", "variable" );
}

// Namespace zm_sat_hornet_ee_roll
// Params 2, eflags: 0x4
// Checksum 0x2497c4f2, Offset: 0x7c2
// Size: 0x205
function private cleanup_purify_machine( b_skipped, b_save_restored )
{
    if ( !isdefined( level.ee_roll.var_75385495715741fb ) )
    {
        s_spawn = utility::getstruct( "gch_bar" );
        level.ee_roll.var_75385495715741fb = spawnscriptable( %"zm_sat_hornet_gch", s_spawn.origin, s_spawn.angles );
    }
    
    level.ee_roll.var_75385495715741fb setscriptablepartstate( "model", "gch" );
    level.ee_roll.var_75385495715741fb setscriptablepartstate( "usable_state", "enabled" );
    interaction::register_scriptable_interact( level.ee_roll.var_75385495715741fb, &function_db7de8e2a3951c09 );
    level.ee_roll.var_75385495715741fb interaction::set_interact_hint_callback( &function_2137126d2094048f );
    level.ee_roll.s_start = utility::getstruct( "gch_r_start" );
    level.ee_roll.var_4b4e6b999024cf0d = utility::getstruct( "gch_r_end" );
    level.ee_roll.s_control = utility::getstruct( "gch_r_ctrl" );
    level.ee_roll.var_45602b4ab3e83f38 = utility::getstruct( "gch_cam" );
    level.ash_root.var_160b0b1f71aadde2 = 1;
    level callback::add( "on_round_end", &function_12bd13c8a7b57cb );
    
    if ( !isdefined( level.ee_roll.var_cda87b83aa3adbd8 ) )
    {
        level.ee_roll.var_cda87b83aa3adbd8 = 0;
    }
    
    level callback::add( #"hash_9aafcac01b1facc6", &function_102bef7562480a9d );
    level callback::add( #"item_weapon_drop", &function_7c61d6a51ae79014 );
    
    if ( b_save_restored )
    {
        level thread function_23be2494871c3455();
    }
}

// Namespace zm_sat_hornet_ee_roll
// Params 1, eflags: 0x4
// Checksum 0x70181830, Offset: 0x9cf
// Size: 0x89
function private function_12bd13c8a7b57cb( sparams )
{
    foreach ( player in level.players )
    {
        player.var_88820b6a35bf0f81 = 0;
    }
}

// Namespace zm_sat_hornet_ee_roll
// Params 0, eflags: 0x4
// Checksum 0xf174669, Offset: 0xa60
// Size: 0x175
function private function_b050bb87edfd6807()
{
    level endon( #"game_ended" );
    level endon( #"cleaning_done" );
    var_ec34c59c739dd8b2 = 2;
    level utility::flag_wait( "ash_initialized" );
    
    while ( true )
    {
        if ( level.ash_root.var_160b0b1f71aadde2 || namespace_c885ed79305d37ad::is_zone_in_ash( "zone_second_bailey" ) )
        {
            foreach ( player in level.players )
            {
                if ( player namespace_c885ed79305d37ad::function_a153d005cc1fc4bc() )
                {
                    player setclientomnvar( "buff_condition_met", 1 );
                    continue;
                }
                
                player setclientomnvar( "buff_condition_met", 0 );
            }
        }
        else
        {
            foreach ( player in level.players )
            {
                player setclientomnvar( "buff_condition_met", 0 );
            }
        }
        
        wait var_ec34c59c739dd8b2;
    }
}

// Namespace zm_sat_hornet_ee_roll
// Params 0, eflags: 0x4
// Checksum 0x98c25a88, Offset: 0xbdd
// Size: 0x74
function private build_trail_path()
{
    var_24c350963fd9a36d = utility::getstruct( "gch_trail_path", "targetname" );
    var_d00b944707343dc9 = [ var_24c350963fd9a36d.origin ];
    
    while ( var_24c350963fd9a36d.target )
    {
        var_24c350963fd9a36d = utility::getstruct( var_24c350963fd9a36d.target, "targetname" );
        var_d00b944707343dc9[ var_d00b944707343dc9.size ] = var_24c350963fd9a36d.origin;
    }
    
    return var_d00b944707343dc9;
}

// Namespace zm_sat_hornet_ee_roll
// Params 11, eflags: 0x4
// Checksum 0x6f38c58c, Offset: 0xc5a
// Size: 0x121
function private function_145bfe89ae0313e5( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( !isdefined( level.ee_roll.var_75385495715741fb ) || instance != level.ee_roll.var_75385495715741fb )
    {
        return;
    }
    
    if ( smeansofdeath != "MOD_MELEE" || !isplayer( eattacker ) )
    {
        return;
    }
    
    if ( eattacker.var_f45589e115285c29 && !utility::time_has_passed( eattacker.var_f45589e115285c29, 0.5 ) )
    {
        return;
    }
    
    if ( zm_quest::is_quest_complete( #"hornet_ee_roll" ) )
    {
        eattacker.var_f45589e115285c29 = gettime();
        function_5afec83fb66a502b( eattacker );
        return;
    }
    
    if ( !eattacker namespace_c885ed79305d37ad::function_a153d005cc1fc4bc() )
    {
        return;
    }
    
    function_de239896a57f6f78( eattacker );
}

// Namespace zm_sat_hornet_ee_roll
// Params 1, eflags: 0x4
// Checksum 0x7e800654, Offset: 0xd83
// Size: 0x36
function private function_5afec83fb66a502b( player )
{
    if ( player.var_339f6f0b35a9b171 )
    {
        player.var_339f6f0b35a9b171 = undefined;
        return;
    }
    
    player.var_339f6f0b35a9b171 = 1;
}

// Namespace zm_sat_hornet_ee_roll
// Params 1, eflags: 0x4
// Checksum 0xd9f7722f, Offset: 0xdc1
// Size: 0x53
function private function_de239896a57f6f78( player )
{
    if ( level.ee_roll.var_686ed4e0b6cb8bb9 )
    {
        return;
    }
    
    if ( !namespace_c885ed79305d37ad::is_zone_in_ash( "zone_second_bailey" ) )
    {
        return;
    }
    
    level.ee_roll.var_686ed4e0b6cb8bb9 = 1;
    level thread function_1b37ce86cbf0aa14( player );
}

// Namespace zm_sat_hornet_ee_roll
// Params 1, eflags: 0x4
// Checksum 0xd03ab2fa, Offset: 0xe1c
// Size: 0x167
function private function_1b37ce86cbf0aa14( player )
{
    level endon( #"game_ended" );
    var_d00b944707343dc9 = level.ee_roll.a_trail_path;
    e_mover = utility::spawn_model( "tag_origin", var_d00b944707343dc9[ 0 ], ( 0, 0, 0 ) );
    trail = spawnscriptable( %"hash_7252822ca7c97764", var_d00b944707343dc9[ 0 ] );
    trail scriptablesetparententity( e_mover, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    trail setscriptablepartstate( "visual", "gold" );
    playsoundatpos( e_mover.origin, "evt_orb_spawn" );
    e_mover thread utility::play_loop_sound_on_entity( "evt_trail_lp" );
    
    if ( var_d00b944707343dc9.size >= 4 )
    {
        e_mover utility::function_2159dd4196ff4b81( var_d00b944707343dc9, 3, 1, 0 );
    }
    else
    {
        var_2da9944b4d9bd76b = 3 / ( var_d00b944707343dc9.size - 1 );
        
        for ( i = 1; i < var_d00b944707343dc9.size ; i++ )
        {
            e_mover moveto( var_d00b944707343dc9[ i ], var_2da9944b4d9bd76b );
            e_mover waittill( #"movedone" );
        }
    }
    
    e_mover utility::stop_loop_sound_on_entity( "evt_trail_lp" );
    playsoundatpos( e_mover.origin, "evt_trail_impact" );
    trail freescriptable();
    e_mover delete();
    level thread function_3be6b95f45a45b6f();
}

// Namespace zm_sat_hornet_ee_roll
// Params 0, eflags: 0x4
// Checksum 0x442bb0e4, Offset: 0xf8b
// Size: 0x75
function private function_3be6b95f45a45b6f()
{
    level endon( #"game_ended" );
    level.ee_roll.var_7e7749b5c5ed8c88 = 0;
    level thread function_8373da7e7a7294d8();
    level utility::waittill_any( "gch_purify_done", "sh_" + "zone_second_bailey" + "_end" );
    
    if ( !level.ee_roll.var_7e7749b5c5ed8c88 )
    {
        level.ee_roll.var_686ed4e0b6cb8bb9 = 0;
    }
}

// Namespace zm_sat_hornet_ee_roll
// Params 0, eflags: 0x4
// Checksum 0xf15e89cf, Offset: 0x1008
// Size: 0x7a
function private function_8373da7e7a7294d8()
{
    level endon( #"game_ended" );
    level endon( "sh_" + "zone_second_bailey" + "_end" );
    level.ee_roll.var_7e7749b5c5ed8c88 = 0;
    namespace_c885ed79305d37ad::function_17c9d94eccb26376( "zone_second_bailey" );
    level.ee_roll.var_7e7749b5c5ed8c88 = 1;
    level.ee_roll.var_686ed4e0b6cb8bb9 = 0;
    level notify( #"gch_purify_done" );
}

// Namespace zm_sat_hornet_ee_roll
// Params 1, eflags: 0x4
// Checksum 0xe2021a79, Offset: 0x108a
// Size: 0xb4
function private function_db7de8e2a3951c09( player )
{
    if ( player.var_88820b6a35bf0f81 )
    {
        return;
    }
    
    w_current = player getcurrentweapon();
    
    if ( !isnullweapon( w_current ) && ( class::ismeleeweapon( w_current ) || weapon::iswonderweapon( w_current ) ) )
    {
        return;
    }
    
    if ( !player currency::attempt_purchase( #"essence", 500 ) )
    {
        return;
    }
    
    if ( !player.var_3b28df377a60aa8c )
    {
        player.var_3b28df377a60aa8c = 1;
        player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( "hornet_gachapon_machine_first_use", #"hash_5212ed7ec42f115a" );
    }
    
    player.var_88820b6a35bf0f81 = 1;
    player roll_reward();
}

// Namespace zm_sat_hornet_ee_roll
// Params 2, eflags: 0x4
// Checksum 0x9fd8d269, Offset: 0x1146
// Size: 0x1a2
function private function_2137126d2094048f( usable, player )
{
    if ( player.interactions_disabled )
    {
        return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
    }
    
    obj = { #icon:"ui_icon_question_mark", #icon_text_value:500, #var_776a268784e089af:&"SHARED_HINTSTRINGS/COST_ESSENCE", #description:&"hash_f22fb4d3003c67d", #title:&"hash_172f084757e0af5a", #buttoncallout:&"SHARED_HINTSTRINGS/HINT_BUY", #type:"HINT_BUTTON" };
    w_current = player getcurrentweapon();
    
    if ( !isnullweapon( w_current ) && ( class::ismeleeweapon( w_current ) || weapon::iswonderweapon( w_current ) ) )
    {
        return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
    }
    
    if ( player.var_88820b6a35bf0f81 )
    {
        obj.aux_text = &"SHARED_HINTSTRINGS/TRAP_COOLDOWN_HINT";
        obj.interactable = 0;
        return obj;
    }
    
    if ( player currency::can_afford( #"essence", 500 ) )
    {
        return obj;
    }
    
    obj.var_776a268784e089af = &"SHARED_HINTSTRINGS/COST_ESSENCE_NOT_ENOUGH";
    obj.interactable = 0;
    return obj;
}

// Namespace zm_sat_hornet_ee_roll
// Params 0, eflags: 0x4
// Checksum 0xa17b50eb, Offset: 0x12f0
// Size: 0x1bd
function private roll_reward()
{
    level endon( #"game_ended" );
    charm = utility::random_weighted( [ "cos_sat_327_beckcat", "cos_sat_328_puffer", "cos_sat_330_puppet", "cos_sat_329_ninjakite" ], [ 10, 30, 30, 30 ] );
    pull_out_charm( charm );
    a_all_charms = [ "cos_sat_327_beckcat", "cos_sat_328_puffer", "cos_sat_330_puppet", "cos_sat_329_ninjakite" ];
    
    for ( i = 0; i < a_all_charms.size ; i++ )
    {
        if ( a_all_charms[ i ] == charm )
        {
            level zm_quest::function_4eefe6de31f5ddab( #"hornet_ee_roll", #"roll_charm", i + 1 );
            break;
        }
    }
    
    if ( !self )
    {
        return;
    }
    
    if ( !self.var_339f6f0b35a9b171 )
    {
        weapon = self getcurrentweapon();
        
        if ( !isnullweapon( weapon ) )
        {
            new_weapon = function_b813a0aba2b74fd7( weapon, charm );
            
            if ( !isnullweapon( new_weapon ) && new_weapon != weapon )
            {
                function_f1adcf6e411f375b( weapon, new_weapon );
                self forceweaponinspect();
            }
        }
    }
    
    function_95853fca0cc9129();
    
    switch ( charm )
    {
        case #"hash_ef2391c11e2525ec":
            function_60119bae018cc872();
            break;
        case #"hash_a8d20d75590e110c":
            function_cad3c2af0b7bada8();
            break;
        case #"hash_2f92638adeb1a725":
            function_31b9cc051d4081ea();
            break;
        case #"hash_14e66cd027d27104":
        default:
            function_d5512f520456ee5a();
            break;
    }
    
    self notify( #"hash_ab3aa59b1e0b9da3" );
}

// Namespace zm_sat_hornet_ee_roll
// Params 1, eflags: 0x4
// Checksum 0x8ce31fb5, Offset: 0x14b5
// Size: 0x2c9
function private pull_out_charm( charm )
{
    level endon( #"game_ended" );
    thread function_6e4bb6c3dbcea344();
    level.ee_roll.var_75385495715741fb setscriptablepartstate( "vfx", "roll" );
    wait 1.4;
    charm_mdl = utility::spawn_model( charm, level.ee_roll.s_start.origin, level.ee_roll.s_start.angles );
    trail = spawnscriptable( %"hash_7252822ca7c97764", level.ee_roll.s_start.origin );
    trail scriptablesetparententity( charm_mdl, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    
    if ( charm != "cos_sat_329_ninjakite" )
    {
        trail setscriptablepartstate( "visual", "gold" );
    }
    
    offset_up = getdvarint( @"hash_55629a3bbe3642ac", 0 );
    spiral_open = getdvarint( @"roll_spiral", 10 );
    charm_mdl utility::function_8001268940441423( level.ee_roll.s_start.origin, level.ee_roll.var_4b4e6b999024cf0d.origin + ( 0, 0, offset_up ), level.ee_roll.s_control.origin, 0.6 );
    
    if ( self )
    {
        self playsoundtoplayer( "evt_ee_complete_success_stinger", self );
    }
    
    if ( charm != "cos_sat_329_ninjakite" )
    {
        trail setscriptablepartstate( "visual", "gold_glow" );
    }
    
    num_bob = 3;
    var_8132b7eeee33c563 = 3.6 / 2 * num_bob;
    var_289763c200c240e1 = var_8132b7eeee33c563 / 3;
    
    for ( i = 0; i < num_bob ; i++ )
    {
        charm_mdl movez( -2, var_8132b7eeee33c563, var_289763c200c240e1, var_289763c200c240e1 );
        charm_mdl waittill( #"movedone" );
        charm_mdl movez( 2, var_8132b7eeee33c563, var_289763c200c240e1, var_289763c200c240e1 );
        charm_mdl waittill( #"movedone" );
    }
    
    if ( self )
    {
        self notify( #"hash_259e84acc2415ae" );
    }
    
    level.ee_roll.var_75385495715741fb setscriptablepartstate( "vfx", "none" );
    trail freescriptable();
    charm_mdl moveto( charm_mdl.origin + ( 0, 0, -50 ), 0.7, 0.5, 0 );
    charm_mdl waittill( #"movedone" );
    charm_mdl delete();
}

// Namespace zm_sat_hornet_ee_roll
// Params 0, eflags: 0x4
// Checksum 0x9976bec6, Offset: 0x1786
// Size: 0x274
function private function_6e4bb6c3dbcea344()
{
    self endon( #"death_or_disconnect" );
    val::set( "gch_watcher", "ignoreme", 1 );
    val::set( "gch_watcher", "damage", 0 );
    val::set( "gch_watcher", "show_hud", 0 );
    val::set( "gch_watcher", "freezecontrols", 1 );
    val::set( "gch_watcher", "weapon_switch", 0 );
    val::set( "gch_watcher", "fire", 0 );
    val::set( "gch_watcher", "killstreaks", 0 );
    val::set( "gch_watcher", "offhand_weapons", 0 );
    val::set( "gch_watcher", "offhand_primary_weapons", 0 );
    val::set( "gch_watcher", "offhand_secondary_weapons", 0 );
    val::set( "gch_watcher", "melee", 0 );
    self setstance( "crouch" );
    self.ground_link = utility::spawn_tag_origin( self.origin, self.angles );
    self playerlinktodelta( self.ground_link, "tag_origin", 1, 0, 0, 0, 0, 1, 1 );
    movetotime = 0.3;
    self.ground_link moveto( ( 3079, -20582, 383 ), movetotime, 0.1, 0.1 );
    self.ground_link rotateto( ( 353, 355, 0 ), movetotime, 0.1, 0.1 );
    self waittill( #"hash_ab3aa59b1e0b9da3" );
    val::reset( "gch_watcher", "freezecontrols" );
    val::reset( "gch_watcher", "fire" );
    val::reset( "gch_watcher", "show_hud" );
    val::reset( "gch_watcher", "weapon_switch" );
    val::reset( "gch_watcher", "killstreaks" );
    val::reset( "gch_watcher", "fire" );
    val::reset( "gch_watcher", "offhand_weapons" );
    val::reset( "gch_watcher", "offhand_primary_weapons" );
    val::reset( "gch_watcher", "offhand_secondary_weapons" );
    val::reset( "gch_watcher", "melee" );
    self.ground_link delete();
    self setstance( "stand" );
    wait 3;
    val::reset( "gch_watcher", "ignoreme" );
    val::reset( "gch_watcher", "damage" );
}

// Namespace zm_sat_hornet_ee_roll
// Params 2, eflags: 0x4
// Checksum 0x149b9be6, Offset: 0x1a02
// Size: 0x15d
function private function_b813a0aba2b74fd7( weapon, charm )
{
    camo = getweaponcamoname( weapon );
    reticle = function_4af0b444e167186d( weapon );
    
    if ( isstring( reticle ) && issubstr( reticle, "scope" ) )
    {
        reticle = int( removesubstr( reticle, "scope" ) );
        
        if ( reticle == 0 )
        {
            reticle = undefined;
        }
    }
    else
    {
        reticle = undefined;
    }
    
    variantid = getweaponvariantindex( weapon );
    cosmeticattachment = charm;
    stickers = [ weapon.stickerslot0, weapon.stickerslot1, weapon.stickerslot2, weapon.stickerslot3, weapon.var_73762c7cb8b2063 ?? "sticker_none" ];
    attachments = weapon.attachments;
    var_f1614eef81f0bdd2 = weapon.attachmentvarindices;
    var_f581dedba4f25efb = weapon::function_2374da6f1b4fad4e( weapon.basename, variantid );
    var_101633ed971732ba = weapon::buildweapon( weapon.basename, attachments, camo, reticle, variantid, var_f1614eef81f0bdd2, cosmeticattachment, stickers, undefined, undefined, undefined, var_f581dedba4f25efb );
    return var_101633ed971732ba;
}

// Namespace zm_sat_hornet_ee_roll
// Params 2, eflags: 0x4
// Checksum 0xe9dbc30a, Offset: 0x1b68
// Size: 0x207
function private function_f1adcf6e411f375b( var_3248d20086ef13a0, new_weapon )
{
    var_3bb181f15a404e4e = self getweaponammoclip( var_3248d20086ef13a0 );
    var_efe292aab202dd44 = self getweaponammostock( var_3248d20086ef13a0 );
    n_clip_ammo_left = undefined;
    
    if ( var_3248d20086ef13a0.isdualwield )
    {
        n_clip_ammo_left = self getweaponammoclip( var_3248d20086ef13a0, "left" );
    }
    
    n_alt_clip = undefined;
    n_alt_stock = undefined;
    var_1f06de6815f47d32 = var_3248d20086ef13a0.var_3eb68e4f7849ffd9;
    
    if ( isdefined( var_1f06de6815f47d32 ) && !isnullweapon( var_1f06de6815f47d32 ) )
    {
        n_alt_clip = self getweaponammoclip( var_1f06de6815f47d32 );
        n_alt_stock = self getweaponammostock( var_1f06de6815f47d32 );
    }
    
    var_951c89546ec50477 = utility::callsharedfunc( #"pack_a_punch", #"get_pap_level", var_3248d20086ef13a0 );
    var_4c506782108851c7 = utility::callsharedfunc( #"ammo_mod", #"hash_cf1012c4d313de70", var_3248d20086ef13a0, 0 );
    n_rarity = utility::callsharedfunc( #"zombie", #"GetPlayerWeaponRarity", var_3248d20086ef13a0 );
    self takeweapon( var_3248d20086ef13a0 );
    self giveweapon( new_weapon );
    self switchtoweaponimmediate( new_weapon );
    self setweaponammoclip( new_weapon, var_3bb181f15a404e4e );
    self setweaponammostock( new_weapon, var_efe292aab202dd44 );
    
    if ( isdefined( n_clip_ammo_left ) )
    {
        self setweaponammoclip( new_weapon, n_clip_ammo_left, "left" );
    }
    
    if ( isdefined( n_alt_clip ) )
    {
        new_alt = new_weapon.var_3eb68e4f7849ffd9;
        
        if ( isdefined( new_alt ) && !isnullweapon( new_alt ) )
        {
            self setweaponammoclip( new_alt, n_alt_clip );
            self setweaponammostock( new_alt, n_alt_stock );
        }
    }
    
    if ( var_951c89546ec50477 > 0 )
    {
        utility::callsharedfunc( #"pack_a_punch", #"hash_4fb89d74adceafac", new_weapon, var_951c89546ec50477, 1, var_3248d20086ef13a0 );
    }
    
    if ( var_4c506782108851c7 )
    {
        utility::callsharedfunc( #"ammo_mod", #"hash_24f1a2cf1ed6660d", new_weapon, var_4c506782108851c7, 1, 1, 0 );
    }
    
    if ( n_rarity > 0 )
    {
        utility::callsharedfunc( #"zombie", #"hash_e546039029657cd5", new_weapon, n_rarity );
    }
}

// Namespace zm_sat_hornet_ee_roll
// Params 0, eflags: 0x4
// Checksum 0x39974bc4, Offset: 0x1d77
// Size: 0x69
function private function_60119bae018cc872()
{
    if ( self.var_7ecb3e5a288bc03c )
    {
        return;
    }
    
    self.var_7ecb3e5a288bc03c = 1;
    function_c403e031db022ac5( #"charm_maneki_neko", self );
    
    if ( !level.ee_roll.var_abe3efb3f16befe5 )
    {
        level.ee_roll.var_abe3efb3f16befe5 = 1;
        common_item::function_5734400f32ca9803( "salvage", &function_cbd4e205f2746b7e );
    }
}

// Namespace zm_sat_hornet_ee_roll
// Params 0, eflags: 0x4
// Checksum 0x824cf6a0, Offset: 0x1de8
// Size: 0x95
function private function_cad3c2af0b7bada8()
{
    if ( self.b_charm_pufferfish )
    {
        return;
    }
    
    self.b_charm_pufferfish = 1;
    function_c403e031db022ac5( #"charm_pufferfish", self );
    
    if ( !isdefined( level.ee_roll.var_cda87b83aa3adbd8 ) )
    {
        level.ee_roll.var_cda87b83aa3adbd8 = 0;
    }
    
    if ( !level.ee_roll.var_203b19fe79951ca5 )
    {
        level.ee_roll.var_203b19fe79951ca5 = 1;
        level callback::add( "on_zombie_ai_killed", &function_bc68b1a59194f077 );
    }
}

// Namespace zm_sat_hornet_ee_roll
// Params 0, eflags: 0x4
// Checksum 0x4c782b77, Offset: 0x1e85
// Size: 0x2b
function private function_31b9cc051d4081ea()
{
    if ( self.var_c25d0d7274ec3c7d )
    {
        return;
    }
    
    self.var_c25d0d7274ec3c7d = 1;
    function_c403e031db022ac5( #"charm_automaton", self );
}

// Namespace zm_sat_hornet_ee_roll
// Params 0, eflags: 0x4
// Checksum 0xfd0db597, Offset: 0x1eb8
// Size: 0x2b
function private function_d5512f520456ee5a()
{
    if ( self.var_578f66e52894da77 )
    {
        return;
    }
    
    self.var_578f66e52894da77 = 1;
    function_c403e031db022ac5( #"charm_ninja_kite", self );
}

// Namespace zm_sat_hornet_ee_roll
// Params 1, eflags: 0x4
// Checksum 0x2c27c0a6, Offset: 0x1eeb
// Size: 0x139
function private function_bc68b1a59194f077( params )
{
    player = params.eattacker;
    
    if ( !isplayer( player ) || !player.b_charm_pufferfish )
    {
        return;
    }
    
    n_max = function_569f5d49066387d();
    
    if ( level.ee_roll.var_cda87b83aa3adbd8 >= n_max )
    {
        return;
    }
    
    if ( !utility::percent_chance( 4 ) )
    {
        return;
    }
    
    str_food_list = level.zombie_augments[ #"toxic_growth_plant_food" ].var_cd8ddaf98102287f;
    
    if ( str_food_list )
    {
        if ( utility::callsharedfunc( #"zombie", #"hash_bad01cbc996e3dba", self.origin ) )
        {
            spawn_options = common_item::items_initspawnoptions_spawnfromposition( self.origin, self.angles );
            spawn_options.var_4a4b419f66681601 = level.players;
            spawn_options.var_c580c0e8b49f1fcc = 1;
            items = common_item::function_38cde6a6acb68ea6( str_food_list, 1, spawn_options );
            
            if ( items )
            {
                level.ee_roll.var_cda87b83aa3adbd8++;
            }
        }
    }
}

// Namespace zm_sat_hornet_ee_roll
// Params 0, eflags: 0x4
// Checksum 0xf1c90988, Offset: 0x202c
// Size: 0x50
function private function_569f5d49066387d()
{
    switch ( level.players.size )
    {
        case 1:
            return 5;
        case 2:
            return 7;
        case 3:
            return 9;
        default:
            return 10;
    }
}

// Namespace zm_sat_hornet_ee_roll
// Params 1, eflags: 0x4
// Checksum 0x7d91737c, Offset: 0x2084
// Size: 0x170
function private function_cbd4e205f2746b7e( params )
{
    item = params.item;
    
    if ( !item )
    {
        return;
    }
    
    if ( level.ee_roll.var_5bbcff5f4baa5e66 )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        if ( !player.var_7ecb3e5a288bc03c )
        {
            continue;
        }
        
        if ( utility::percent_chance( int( 25 ) ) )
        {
            waittillframeend();
            
            if ( item )
            {
                level.ee_roll.var_5bbcff5f4baa5e66 = 1;
                spawn_options = common_item::items_initspawnoptions_spawnfromposition( item.origin + ( 0, 0, 25 ), ( 0, 0, 0 ) );
                spawn_options.var_4a4b419f66681601 = [ player ];
                spawn_options.var_c580c0e8b49f1fcc = 1;
                common_item::function_38cde6a6acb68ea6( %"hash_3f771c8c63105ac6", 1, spawn_options );
                waitframe();
                level.ee_roll.var_5bbcff5f4baa5e66 = 0;
            }
        }
    }
}

// Namespace zm_sat_hornet_ee_roll
// Params 2, eflags: 0x4
// Checksum 0x186be570, Offset: 0x21fc
// Size: 0x2a
function private function_c403e031db022ac5( charm_key, player )
{
    level zm_quest::function_4eefe6de31f5ddab( #"hornet_ee_roll", charm_key, 1 );
}

// Namespace zm_sat_hornet_ee_roll
// Params 1, eflags: 0x4
// Checksum 0x315c0ac8, Offset: 0x222e
// Size: 0x20
function private function_6ff25f485bb578b1( charm_key )
{
    level zm_quest::function_4eefe6de31f5ddab( #"hornet_ee_roll", charm_key, 0 );
}

// Namespace zm_sat_hornet_ee_roll
// Params 0, eflags: 0x4
// Checksum 0x68ca4c0a, Offset: 0x2256
// Size: 0xe5
function private function_23be2494871c3455()
{
    var_c05225eadb335d26 = [ #"charm_pufferfish", #"charm_ninja_kite", #"charm_automaton", #"charm_maneki_neko" ];
    a_funcs = [ &function_cad3c2af0b7bada8, &function_d5512f520456ee5a, &function_31b9cc051d4081ea, &function_60119bae018cc872 ];
    player = level.players[ 0 ];
    
    if ( !player )
    {
        level waittill( #"connected", player );
    }
    
    for ( i = 0; i < var_c05225eadb335d26.size ; i++ )
    {
        val = zm_quest::function_73720cdf21c3cfd7( #"hornet_ee_roll", var_c05225eadb335d26[ i ] ) ?? 0;
        
        if ( val > 0 )
        {
            player [[ a_funcs[ i ] ]]();
        }
    }
}

// Namespace zm_sat_hornet_ee_roll
// Params 0, eflags: 0x4
// Checksum 0xfd750d70, Offset: 0x2343
// Size: 0x9a
function private function_95853fca0cc9129()
{
    if ( self.b_charm_pufferfish )
    {
        self.b_charm_pufferfish = 0;
        function_6ff25f485bb578b1( #"charm_pufferfish" );
    }
    
    if ( self.var_578f66e52894da77 )
    {
        self.var_578f66e52894da77 = 0;
        function_6ff25f485bb578b1( #"charm_ninja_kite" );
    }
    
    if ( self.var_c25d0d7274ec3c7d )
    {
        self.var_c25d0d7274ec3c7d = 0;
        function_6ff25f485bb578b1( #"charm_automaton" );
    }
    
    if ( self.var_7ecb3e5a288bc03c )
    {
        self.var_7ecb3e5a288bc03c = 0;
        function_6ff25f485bb578b1( #"charm_maneki_neko" );
    }
}

// Namespace zm_sat_hornet_ee_roll
// Params 1
// Checksum 0xdba75305, Offset: 0x23e5
// Size: 0xe4
function function_dc47b8489d21c714( weapon )
{
    if ( !weapon.charmscriptbundle )
    {
        return;
    }
    
    charm_ref = weapon.charmscriptbundle.charmref;
    
    if ( !charm_ref )
    {
        return;
    }
    
    a_charms = [ "cos_sat_327_beckcat", "cos_sat_328_puffer", "cos_sat_330_puppet", "cos_sat_329_ninjakite" ];
    
    foreach ( charm in a_charms )
    {
        if ( charm_ref == charm )
        {
            return charm;
        }
    }
}

// Namespace zm_sat_hornet_ee_roll
// Params 1, eflags: 0x4
// Checksum 0x2b11969c, Offset: 0x24d2
// Size: 0x6e
function private function_56d312e57367fc18( charm_id )
{
    switch ( charm_id )
    {
        case #"hash_ef2391c11e2525ec":
            function_60119bae018cc872();
            break;
        case #"hash_a8d20d75590e110c":
            function_cad3c2af0b7bada8();
            break;
        case #"hash_2f92638adeb1a725":
            function_31b9cc051d4081ea();
            break;
        case #"hash_14e66cd027d27104":
            function_d5512f520456ee5a();
            break;
    }
}

// Namespace zm_sat_hornet_ee_roll
// Params 1, eflags: 0x4
// Checksum 0x6b998b84, Offset: 0x2548
// Size: 0x67
function private function_102bef7562480a9d( params )
{
    player = params.player;
    weapon = params.objweapon;
    
    if ( !player || !weapon )
    {
        return;
    }
    
    charm_id = function_dc47b8489d21c714( weapon );
    
    if ( charm_id )
    {
        player function_56d312e57367fc18( charm_id );
    }
}

// Namespace zm_sat_hornet_ee_roll
// Params 1, eflags: 0x4
// Checksum 0x85c80419, Offset: 0x25b7
// Size: 0x1a3
function private function_7c61d6a51ae79014( params )
{
    player = params.player;
    weapon = params.objweapon;
    
    if ( !player || !weapon )
    {
        return;
    }
    
    charm_id = function_dc47b8489d21c714( weapon );
    
    if ( !charm_id )
    {
        return;
    }
    
    foreach ( inv_weapon in player.primaryinventory )
    {
        remaining_charm = function_dc47b8489d21c714( inv_weapon );
        
        if ( remaining_charm == charm_id )
        {
            return;
        }
    }
    
    switch ( charm_id )
    {
        case #"hash_ef2391c11e2525ec":
            player.var_7ecb3e5a288bc03c = 0;
            function_6ff25f485bb578b1( #"charm_maneki_neko" );
            break;
        case #"hash_a8d20d75590e110c":
            player.b_charm_pufferfish = 0;
            function_6ff25f485bb578b1( #"charm_pufferfish" );
            break;
        case #"hash_2f92638adeb1a725":
            player.var_c25d0d7274ec3c7d = 0;
            function_6ff25f485bb578b1( #"charm_automaton" );
            break;
        case #"hash_14e66cd027d27104":
            player.var_578f66e52894da77 = 0;
            function_6ff25f485bb578b1( #"charm_ninja_kite" );
            break;
    }
}

// Namespace zm_sat_hornet_ee_roll
// Params 2, eflags: 0x4
// Checksum 0xca0a5b13, Offset: 0x2762
// Size: 0x77
function private function_b5fcd3ed165ff384( player, charm )
{
    if ( !isalive( player ) )
    {
        return;
    }
    
    weapon = player getcurrentweapon();
    
    if ( !isnullweapon( weapon ) )
    {
        new_weapon = player function_b813a0aba2b74fd7( weapon, charm );
        
        if ( !isnullweapon( new_weapon ) && new_weapon != weapon )
        {
            player function_f1adcf6e411f375b( weapon, new_weapon );
        }
    }
    
    player function_56d312e57367fc18( charm );
}

// Namespace zm_sat_hornet_ee_roll
// Params 1, eflags: 0x4
// Checksum 0xe1318fc5, Offset: 0x27e1
// Size: 0x36
function private function_117a9ca9647f8787( params )
{
    player = level.players[ 0 ];
    
    if ( player )
    {
        function_b5fcd3ed165ff384( player, "cos_sat_327_beckcat" );
    }
}

// Namespace zm_sat_hornet_ee_roll
// Params 1, eflags: 0x4
// Checksum 0xe5545d81, Offset: 0x281f
// Size: 0x36
function private function_1fe555ddab82c1e2( params )
{
    player = level.players[ 0 ];
    
    if ( player )
    {
        function_b5fcd3ed165ff384( player, "cos_sat_328_puffer" );
    }
}

// Namespace zm_sat_hornet_ee_roll
// Params 1, eflags: 0x4
// Checksum 0x69b91688, Offset: 0x285d
// Size: 0x36
function private function_c503e2601e2dbfd2( params )
{
    player = level.players[ 0 ];
    
    if ( player )
    {
        function_b5fcd3ed165ff384( player, "cos_sat_330_puppet" );
    }
}

// Namespace zm_sat_hornet_ee_roll
// Params 1, eflags: 0x4
// Checksum 0xb05c1848, Offset: 0x289b
// Size: 0x36
function private function_cb297ed3daf76986( params )
{
    player = level.players[ 0 ];
    
    if ( player )
    {
        function_b5fcd3ed165ff384( player, "cos_sat_329_ninjakite" );
    }
}

