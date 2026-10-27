// scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_ee_phonos.gsc  (hash_40fb5a6f03526e9a.gscc) (size: 9025 Bytes / 0x2341 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x957f3c69 (2508143721)
// size ...... 9025 (0x2341)
// includes .. 8   (offset: 0x2109)
// strings ... 32  (offset: 0x2149)
// dev strs .. 1   (offset: 0x2335)
// exports ... 27  (offset: 0x137d)
// cseg ...... 0x309 + 0x1074 (0x137d)
// imports ... 79  (offset: 0x17b5)
// animtree1 . 0   (offset: 0x2341)
// animtree2 . 0   (offset: 0x2341)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\loot\common_item;
#using scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_ee_phonos_cs;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_ruby_ee_phonos;

// Namespace zm_sat_ruby_ee_phonos
// Params 0, eflags: 0x5
// Checksum 0xafb9002c, Offset: 0x327
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"hash_dcd75ff07be3568e", #"zm_quest", &function_a152df2f1e40d89b, &function_df0ea1392dd63838 );
}

// Namespace zm_sat_ruby_ee_phonos
// Params 0, eflags: 0x4
// Checksum 0x782dcbd4, Offset: 0x354
// Size: 0x171
function private function_a152df2f1e40d89b()
{
    if ( !getdvarint( @"hash_3a9ff30b9c2ea1f1", 0 ) || !getmatchrulesdata( "zmData", "sideContentEnabled" ) )
    {
        return;
    }
    
    level.var_a23bf6f5f0ec875 = zm_quest::get_quest( #"hash_dcd75ff07be3568e" );
    level._effect[ #"hash_45576c66a16bd041" ] = loadfxasset( "vfx_t10_gameplay_zm_soul_charge_purple" );
    level._effect[ #"hash_b872697deaa69f7b" ] = loadfxasset( "vfx_t10_gameplay_zm_zombie_souls_trail" );
    zm_quest::register_quest_step( #"hash_dcd75ff07be3568e", #"phonos_setup_step", &function_dd5bb22611526289 );
    zm_quest::register_quest_step( #"hash_dcd75ff07be3568e", #"hash_b444248b9bed2d8e", &function_b675483df23ecc3d, &function_4ac0140a8f54e4b3 );
    zm_quest::register_quest_step( #"hash_dcd75ff07be3568e", #"hash_b444238b9bed2bdb", &function_b675453df23ec5a4, &function_4ac0150a8f54e6e6 );
    zm_quest::register_quest_step( #"hash_dcd75ff07be3568e", #"hash_b444228b9bed2a28", &function_b675463df23ec7d7, &function_4ac0160a8f54e919 );
    zm_quest::register_quest_step( #"hash_dcd75ff07be3568e", #"hash_d0f91aa6fc4d978", &function_6bf22ea7b110be6c, &function_71f0563a8146ee82 );
    zm_quest::register_quest_step( #"hash_dcd75ff07be3568e", #"hash_d0f94aa6fc4de91", &function_6bf231a7b110c505, &function_71f0553a8146ec4f );
    zm_quest::register_quest_step( #"hash_dcd75ff07be3568e", #"hash_d0f93aa6fc4dcde", &function_6bf230a7b110c2d2, &function_71f0543a8146ea1c );
    zm_sat_ruby_ee_phonos_cs::main();
}

// Namespace zm_sat_ruby_ee_phonos
// Params 0, eflags: 0x4
// Checksum 0x30b3333b, Offset: 0x4cd
// Size: 0x40
function private function_df0ea1392dd63838()
{
    if ( !getdvarint( @"hash_3a9ff30b9c2ea1f1", 0 ) || !getmatchrulesdata( "zmData", "sideContentEnabled" ) )
    {
        return;
    }
    
    zm_save::function_1f44a48caae2acbf();
    level thread zm_quest::start_quest( #"hash_dcd75ff07be3568e" );
}

// Namespace zm_sat_ruby_ee_phonos
// Params 2, eflags: 0x4
// Checksum 0x1cde5de7, Offset: 0x515
// Size: 0x1d
function private function_dd5bb22611526289( b_skipped, b_save_restored )
{
    level thread setup_phonos_interacts();
}

// Namespace zm_sat_ruby_ee_phonos
// Params 0, eflags: 0x4
// Checksum 0x3482378a, Offset: 0x53a
// Size: 0x2a1
function private setup_phonos_interacts()
{
    level utility::flag_wait( "begin_round_logic" );
    level utility::flag_wait( "scriptables_ready" );
    a_records = getentarray( "ee_phonos_record_find", #targetname );
    
    foreach ( record in a_records )
    {
        interact = zm_quest::function_91f9590e98d57ff6( record.origin + ( 0, 0, 24 ), &take_record, undefined, "hidden" );
        interact.record = record;
        record.interact = interact;
    }
    
    level utility::flag_wait_any( "ruby_ee_rec_found_1", "ruby_ee_rec_found_2", "ruby_ee_rec_found_3" );
    waitframe();
    
    foreach ( record in a_records )
    {
        if ( level utility::flag( "ruby_ee_rec_found_" + record.script_noteworthy ) )
        {
            record.interact take_record();
        }
    }
    
    a_phonos = utility::getstructarray( "ee_phonos_record_placed" );
    
    foreach ( phono in a_phonos )
    {
        phono.capture_trigger = getnoentvolumearray( "ee_phonos_capture_trigger_" + phono.script_noteworthy, #targetname )[ 0 ];
        interact = zm_quest::function_91f9590e98d57ff6( phono, &play_record, undefined, "hidden" );
        interact.info = phono;
        interact.info.n_souls = 0;
        
        if ( zm_quest::function_73720cdf21c3cfd7( #"hash_dcd75ff07be3568e", getxhash( phono.script_noteworthy ) ) )
        {
            interact function_ecbe90de84cfb804();
        }
    }
}

// Namespace zm_sat_ruby_ee_phonos
// Params 1, eflags: 0x4
// Checksum 0x45ec44cf, Offset: 0x7e3
// Size: 0xbb
function private take_record( player )
{
    level utility::flag_set( "ruby_ee_rec_found_" + self.record.script_noteworthy );
    
    if ( !isdefined( level.var_a23bf6f5f0ec875.var_87d9af34cdf7f9db ) )
    {
        level.var_a23bf6f5f0ec875.var_87d9af34cdf7f9db = [];
    }
    
    level.var_a23bf6f5f0ec875.var_87d9af34cdf7f9db[ level.var_a23bf6f5f0ec875.var_87d9af34cdf7f9db.size ] = self.record.script_noteworthy;
    
    if ( player )
    {
        player playsoundtoplayer( "uin_zm_common_pickup_item", player );
    }
    
    self.record delete();
    self freescriptable();
}

// Namespace zm_sat_ruby_ee_phonos
// Params 1, eflags: 0x4
// Checksum 0xf88ee06e, Offset: 0x8a6
// Size: 0x266
function private play_record( player )
{
    if ( level utility::flag( "ruby_ee_rec_used_" + self.info.script_noteworthy ) )
    {
        return;
    }
    
    if ( !self.mdl_record )
    {
        if ( !level.var_a23bf6f5f0ec875.var_87d9af34cdf7f9db.size )
        {
            return;
        }
        
        function_ecbe90de84cfb804( player );
    }
    
    self.mdl_record rotateby( ( 0, 3600, 0 ), 30 );
    level utility::flag_set( "ruby_ee_rec_playing_" + self.info.script_noteworthy );
    level utility::flag_set( "ruby_ee_rec_used_" + self.info.script_noteworthy );
    function_ad6f66df218a1cdc( self.info );
    s_rewards = calculate_rewards( self.info );
    s_landing = utility::getstruct( "ee_phonos_reward_" + self.info.script_noteworthy );
    spawnoptions = common_item::function_f5dfaa3bbdf99a33( s_landing.origin, self.info.var_4b4e6b999024cf0d.origin );
    spawnoptions.var_9161cf0784b6951d = 0;
    common_item::function_38cde6a6acb68ea6( s_rewards.itemspawnlist, s_rewards.n_count, spawnoptions );
    
    if ( !level utility::flag( "ee_phonos_reward_" + self.info.script_noteworthy ) && s_rewards.n_count == 5 )
    {
        level utility::flag_set( "ee_phonos_reward_" + self.info.script_noteworthy );
        spawnoptions.var_9161cf0784b6951d = 1;
        common_item::function_61c2c0251e742ffd( %"hash_63a8dbb95fa75efb", 1, spawnoptions );
        playsoundatpos( self.origin, "evt_success_stinger" );
    }
    
    level utility::flag_clear( "ruby_ee_rec_playing_" + self.info.script_noteworthy );
    level waittill( #"on_round_end" );
    level utility::flag_clear( "ruby_ee_rec_used_" + self.info.script_noteworthy );
    self.info.n_souls = 0;
}

// Namespace zm_sat_ruby_ee_phonos
// Params 1, eflags: 0x4
// Checksum 0x6c84d8bf, Offset: 0xb14
// Size: 0x150
function private function_ecbe90de84cfb804( player )
{
    n_record = level.var_a23bf6f5f0ec875.var_87d9af34cdf7f9db[ level.var_a23bf6f5f0ec875.var_87d9af34cdf7f9db.size - 1 ];
    level.var_a23bf6f5f0ec875.var_87d9af34cdf7f9db = arrayremove( level.var_a23bf6f5f0ec875.var_87d9af34cdf7f9db, n_record );
    
    switch ( n_record )
    {
        case #"hash_31100fbc01bd387c":
            var_1479f07b528e4ff7 = %"01a::t10_int_decor_vinyl_record_01";
            break;
        case #"hash_311012bc01bd3d35":
            var_1479f07b528e4ff7 = %"01b::t10_int_decor_vinyl_record_01";
            break;
        case #"hash_311011bc01bd3ba2":
            var_1479f07b528e4ff7 = %"t10_int_decor_vinyl_record_01";
            break;
    }
    
    level utility::flag_set( "ruby_ee_rec_placed_" + self.info.script_noteworthy );
    zm_quest::function_4eefe6de31f5ddab( #"hash_dcd75ff07be3568e", getxhash( self.info.script_noteworthy ), 1 );
    self.mdl_record = utility::spawn_model( var_1479f07b528e4ff7, self.origin, self.angles );
    
    if ( player )
    {
        player playsoundtoplayer( "evt_item_placed_generic", player );
    }
}

// Namespace zm_sat_ruby_ee_phonos
// Params 1, eflags: 0x4
// Checksum 0x64be07c0, Offset: 0xc6c
// Size: 0x8d
function private function_ad6f66df218a1cdc( s_phono )
{
    s_phono endon( #"hash_59bd8603ddc16975" );
    s_phono thread function_8db37ea72a9b4b2a();
    
    while ( s_phono.capture_trigger )
    {
        s_phono.capture_trigger waittill( #"trigger", ent );
        
        if ( isai( ent ) && !ent callback::exists( "on_zombie_ai_killed", &function_b87d65ac814b36bc, s_phono ) )
        {
            ent callback::add( "on_zombie_ai_killed", &function_b87d65ac814b36bc, s_phono );
        }
    }
}

// Namespace zm_sat_ruby_ee_phonos
// Params 0, eflags: 0x4
// Checksum 0x65435e75, Offset: 0xd01
// Size: 0x43
function private function_8db37ea72a9b4b2a()
{
    alias = hashcat( #"hash_9b2e0aa092507ad3", self.script_noteworthy );
    playsoundatpos( self.origin, alias );
    wait 30;
    self notify( #"hash_59bd8603ddc16975" );
}

// Namespace zm_sat_ruby_ee_phonos
// Params 2, eflags: 0x4
// Checksum 0x7243a363, Offset: 0xd4c
// Size: 0xc6
function private function_b87d65ac814b36bc( params, info )
{
    if ( self && ( isplayer( params.eattacker ) || isplayer( params.eattacker.owner ) ) && level utility::flag( "ruby_ee_rec_playing_" + info.script_noteworthy ) && self istouching( info.capture_trigger ) && function_abcd0a8ed4c4106c( params, info.script_noteworthy ) )
    {
        var_dac75f4116c98678 = self getcentroid();
        playfx( level._effect[ #"hash_45576c66a16bd041" ], var_dac75f4116c98678 );
        level thread function_513d0f249c9fde30( var_dac75f4116c98678, info );
    }
}

// Namespace zm_sat_ruby_ee_phonos
// Params 2, eflags: 0x4
// Checksum 0x603ed094, Offset: 0xe1a
// Size: 0xee, Type: bool
function private function_abcd0a8ed4c4106c( params, var_48bfea3d0b39b29c )
{
    switch ( var_48bfea3d0b39b29c )
    {
        case #"hash_81362f13a0a0d675":
            if ( params.smeansofdeath == "MOD_MELEE" )
            {
                return true;
            }
            
            break;
        case #"hash_5b21878931904ace":
            if ( params.objweapon.inventorytype == "offhand" || issubstr( params.objweapon.basename, "mini_sentry_turret" ) )
            {
                return true;
            }
            
            break;
        case #"hash_4e14337458825829":
            if ( params.objweapon.isfieldupgrade || self.var_e797f68de73ece4e == "_ashroud" || params.eattacker.aether_shroud_active )
            {
                return true;
            }
            
            break;
    }
    
    return false;
}

// Namespace zm_sat_ruby_ee_phonos
// Params 2, eflags: 0x4
// Checksum 0x924a2864, Offset: 0xf11
// Size: 0x129
function private function_513d0f249c9fde30( v_start, info )
{
    e_fx = utility::spawn_model( "tag_origin", v_start );
    playfxontag( level._effect[ #"hash_b872697deaa69f7b" ], e_fx, "tag_origin" );
    e_fx playloopsound( "evt_trail_lp" );
    n_time = distance2d( v_start, info.origin ) / 200;
    s_control = utility::getstruct( info.target );
    info.var_4b4e6b999024cf0d = utility::getstruct( s_control.target );
    e_fx utility::function_8001268940441423( v_start, info.var_4b4e6b999024cf0d.origin, s_control.origin, n_time, 0, 1 );
    e_fx delete();
    playsoundatpos( info.var_4b4e6b999024cf0d.origin, "evt_trail_impact" );
    info.n_souls++;
    
    /#
        iprintln( info.n_souls + "<dev string:x24>" );
    #/
}

// Namespace zm_sat_ruby_ee_phonos
// Params 1, eflags: 0x4
// Checksum 0xf7c02bb5, Offset: 0x1042
// Size: 0x11e
function private calculate_rewards( info )
{
    n_round = zm_utility::get_round_number();
    
    if ( n_round < 6 )
    {
        n_reward_count = int( info.n_souls );
    }
    else if ( n_round < 11 )
    {
        n_reward_count = int( info.n_souls / 2 );
    }
    else if ( n_round < 20 )
    {
        n_reward_count = int( info.n_souls / 3 );
    }
    else
    {
        n_reward_count = int( info.n_souls / 4 );
    }
    
    n_reward_count = min( 5, n_reward_count );
    
    switch ( info.script_noteworthy )
    {
        case #"hash_81362f13a0a0d675":
            str_item_list = %"hash_20e6ae94f84d9769";
            break;
        case #"hash_5b21878931904ace":
            str_item_list = %"hash_7588d1e5f06f25e1";
            break;
        case #"hash_4e14337458825829":
            str_item_list = %"hash_6cb8be94c23cc099";
            break;
    }
    
    return { #n_count:n_reward_count, #itemspawnlist:str_item_list };
}

// Namespace zm_sat_ruby_ee_phonos
// Params 2, eflags: 0x4
// Checksum 0xfad58a4, Offset: 0x1169
// Size: 0x22
function private function_b675483df23ecc3d( b_skipped, b_save_restored )
{
    level utility::flag_wait( "ruby_ee_rec_found_1" );
}

// Namespace zm_sat_ruby_ee_phonos
// Params 2, eflags: 0x4
// Checksum 0x6fbfb08f, Offset: 0x1193
// Size: 0x22
function private function_4ac0140a8f54e4b3( b_skipped, b_save_restored )
{
    level utility::flag_set( "ruby_ee_rec_found_1" );
}

// Namespace zm_sat_ruby_ee_phonos
// Params 2, eflags: 0x4
// Checksum 0xfad58a4, Offset: 0x11bd
// Size: 0x22
function private function_b675453df23ec5a4( b_skipped, b_save_restored )
{
    level utility::flag_wait( "ruby_ee_rec_found_2" );
}

// Namespace zm_sat_ruby_ee_phonos
// Params 2, eflags: 0x4
// Checksum 0x6fbfb08f, Offset: 0x11e7
// Size: 0x22
function private function_4ac0150a8f54e6e6( b_skipped, b_save_restored )
{
    level utility::flag_set( "ruby_ee_rec_found_2" );
}

// Namespace zm_sat_ruby_ee_phonos
// Params 2, eflags: 0x4
// Checksum 0xfad58a4, Offset: 0x1211
// Size: 0x22
function private function_b675463df23ec7d7( b_skipped, b_save_restored )
{
    level utility::flag_wait( "ruby_ee_rec_found_3" );
}

// Namespace zm_sat_ruby_ee_phonos
// Params 2, eflags: 0x4
// Checksum 0x6fbfb08f, Offset: 0x123b
// Size: 0x22
function private function_4ac0160a8f54e919( b_skipped, b_save_restored )
{
    level utility::flag_set( "ruby_ee_rec_found_3" );
}

// Namespace zm_sat_ruby_ee_phonos
// Params 2, eflags: 0x4
// Checksum 0x478f6161, Offset: 0x1265
// Size: 0x28
function private function_6bf22ea7b110be6c( b_skipped, b_save_restored )
{
    level utility::flag_wait( "ee_phonos_reward_" + "museum" );
}

// Namespace zm_sat_ruby_ee_phonos
// Params 2, eflags: 0x4
// Checksum 0xf23fec21, Offset: 0x1295
// Size: 0x28
function private function_71f0563a8146ee82( b_skipped, b_save_restored )
{
    level utility::flag_set( "ee_phonos_reward_" + "museum" );
}

// Namespace zm_sat_ruby_ee_phonos
// Params 2, eflags: 0x4
// Checksum 0x5abee3e5, Offset: 0x12c5
// Size: 0x28
function private function_6bf231a7b110c505( b_skipped, b_save_restored )
{
    level utility::flag_wait( "ee_phonos_reward_" + "study" );
}

// Namespace zm_sat_ruby_ee_phonos
// Params 2, eflags: 0x4
// Checksum 0xef0e6ea5, Offset: 0x12f5
// Size: 0x28
function private function_71f0553a8146ec4f( b_skipped, b_save_restored )
{
    level utility::flag_set( "ee_phonos_reward_" + "study" );
}

// Namespace zm_sat_ruby_ee_phonos
// Params 2, eflags: 0x4
// Checksum 0x11d51e33, Offset: 0x1325
// Size: 0x28
function private function_6bf230a7b110c2d2( b_skipped, b_save_restored )
{
    level utility::flag_wait( "ee_phonos_reward_" + "planetarium" );
}

// Namespace zm_sat_ruby_ee_phonos
// Params 2, eflags: 0x4
// Checksum 0xa4659373, Offset: 0x1355
// Size: 0x28
function private function_71f0543a8146ea1c( b_skipped, b_save_restored )
{
    level utility::flag_set( "ee_phonos_reward_" + "planetarium" );
}

