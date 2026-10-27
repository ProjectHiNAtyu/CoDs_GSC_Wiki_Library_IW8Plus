// scripts\mp\common\powerups\zm_boba.gsc  (hash_552d755c6669c22c.gscc) (size: 7610 Bytes / 0x1dba / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2fb11c47 (800136263)
// size ...... 7610 (0x1dba)
// includes .. 13  (offset: 0x1b56)
// strings ... 37  (offset: 0x1bbe)
// dev strs .. 2   (offset: 0x1da2)
// exports ... 24  (offset: 0x10a2)
// cseg ...... 0x3cc + 0xcd6 (0x10a2)
// imports ... 58  (offset: 0x1462)
// animtree1 . 0   (offset: 0x1dba)
// animtree2 . 0   (offset: 0x1dba)
#using script_16ea1b94f0f381b3;
#using scripts\common\powerups;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\common\powerups\full_ammo;
#using scripts\mp\common\powerups\powerups;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\pack_a_punch;
#using scripts\mp\playerhealth;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\zm_utility;

#namespace zm_boba;

// Namespace zm_boba
// Params 0, eflags: 0x1
// Checksum 0x18409565, Offset: 0x3ea
// Size: 0x5f
function autoexec main()
{
    if ( getdvarint( @"hash_9c8828798532365", 0 ) )
    {
        return;
    }
    
    if ( !getdvarint( @"hash_310b30b8c71e8af5", 0 ) )
    {
        init_boba_one();
    }
    
    if ( !getdvarint( @"hash_310b2db8c71e845c", 0 ) )
    {
        init_boba_two();
    }
    
    if ( !getdvarint( @"hash_310b2eb8c71e868f", 0 ) )
    {
        init_boba_three();
    }
}

// Namespace zm_boba
// Params 0
// Checksum 0xc7b38b51, Offset: 0x451
// Size: 0x1d
function init_boba_one()
{
    powerups::register_powerup( "boba_1", &function_6e70fc380936e7a8, &function_3dcc309324807fb6, &function_62b0c5a67648e35f );
}

// Namespace zm_boba
// Params 2
// Checksum 0xb04f2811, Offset: 0x476
// Size: 0xe2
function function_6e70fc380936e7a8( str_powerup, ent_powerup )
{
    a_players = powerups::get_powerup_players( str_powerup );
    vo_alts = [ "dx_zm_zmbc_zboc_taro_zcpb", "dx_zm_zmbc_zboc_jsmn_zcpb", "dx_zm_zmbc_zboc_asam_zcpb", "dx_zm_zmbc_zboc_thai_zcpb" ];
    level thread namespace_c0b4f2882c9d100f::vo_say_announcer( utility::array_random( vo_alts ) );
    
    foreach ( player in a_players )
    {
        player give_full_clock();
        player thread namespace_9d8e359c3b1041e5::showpoweruphudsharedfunc( str_powerup );
    }
}

// Namespace zm_boba
// Params 0
// Checksum 0xb7e45117, Offset: 0x560
// Size: 0x38
function function_3dcc309324807fb6()
{
    if ( utility::issharedfuncdefined( #"powerup_boba_one", #"hash_75b10183404b5a16" ) )
    {
        return utility::callsharedfunc( #"powerup_boba_one", #"hash_75b10183404b5a16" );
    }
    
    return 1;
}

// Namespace zm_boba
// Params 2
// Checksum 0xd6c0eb59, Offset: 0x5a1
// Size: 0x4e
function function_62b0c5a67648e35f( chance, context )
{
    if ( utility::issharedfuncdefined( #"powerup_boba_one", #"modify_drop_chance" ) )
    {
        return utility::callsharedfunc( #"powerup_boba_one", #"modify_drop_chance", chance, context );
    }
    
    return chance;
}

// Namespace zm_boba
// Params 0
// Checksum 0xf7c3aafa, Offset: 0x5f8
// Size: 0x44
function give_full_clock()
{
    if ( utility::issharedfuncdefined( #"powerup_boba_one", #"give_clock" ) )
    {
        utility::callsharedfunc( #"powerup_boba_one", #"give_clock" );
        return;
    }
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
}

// Namespace zm_boba
// Params 0
// Checksum 0x5ebadaeb, Offset: 0x644
// Size: 0x1d
function init_boba_two()
{
    powerups::register_powerup( "boba_2", &function_e5bca336e8fd7bce, &function_d7b1f792d9748dac, &function_f7eecea56c5a67b9 );
}

// Namespace zm_boba
// Params 2
// Checksum 0x14b34eb6, Offset: 0x669
// Size: 0xe2
function function_e5bca336e8fd7bce( str_powerup, ent_powerup )
{
    a_players = powerups::get_powerup_players( str_powerup );
    vo_alts = [ "dx_zm_zmbc_zboc_taro_zcsp", "dx_zm_zmbc_zboc_jsmn_zcsp", "dx_zm_zmbc_zboc_asam_zcsp", "dx_zm_zmbc_zboc_thai_zcsp" ];
    level thread namespace_c0b4f2882c9d100f::vo_say_announcer( utility::array_random( vo_alts ) );
    
    foreach ( player in a_players )
    {
        player function_7a553ea6009d2e8c();
        player thread namespace_9d8e359c3b1041e5::showpoweruphudsharedfunc( str_powerup );
    }
}

// Namespace zm_boba
// Params 0
// Checksum 0xdc425d80, Offset: 0x753
// Size: 0x38
function function_d7b1f792d9748dac()
{
    if ( utility::issharedfuncdefined( #"powerup_boba_two", #"hash_75b10183404b5a16" ) )
    {
        return utility::callsharedfunc( #"powerup_boba_two", #"hash_75b10183404b5a16" );
    }
    
    return 1;
}

// Namespace zm_boba
// Params 2
// Checksum 0xbd66e7ce, Offset: 0x794
// Size: 0x4e
function function_f7eecea56c5a67b9( chance, context )
{
    if ( utility::issharedfuncdefined( #"powerup_boba_two", #"modify_drop_chance" ) )
    {
        return utility::callsharedfunc( #"powerup_boba_two", #"modify_drop_chance", chance, context );
    }
    
    return chance;
}

// Namespace zm_boba
// Params 0
// Checksum 0x3899c0ca, Offset: 0x7eb
// Size: 0x44
function function_7a553ea6009d2e8c()
{
    if ( utility::issharedfuncdefined( #"powerup_boba_two", #"hash_c604cefa4425c99f" ) )
    {
        utility::callsharedfunc( #"powerup_boba_two", #"hash_c604cefa4425c99f" );
        return;
    }
    
    /#
        iprintlnbold( "<dev string:x33>" );
    #/
}

// Namespace zm_boba
// Params 0
// Checksum 0x3b472e48, Offset: 0x837
// Size: 0x1f5
function init_boba_three()
{
    powerups::register_powerup( "boba_3", &function_b1ddfd257a6060ec, &function_81d3c34cc9d1a47e, &function_b04246940a8199d3 );
    operator_l = spawnstruct();
    operator_l.skin = %"t10_usa_pl_oriole_base_skin";
    operator_l.weap = "t10_me_p37_katanas";
    operator_l.var_f5d1b1026f319b1a = "dx_zm_zmbc_zboc_taro_zcjs";
    operator_l.var_42ad352ed55ade0f = "dx_zm_zmbc_zboc_taro_zcje";
    operator_d = spawnstruct();
    operator_d.skin = %"t10_usa_pl_martin_base_skin";
    operator_d.weap = "t10_me_p40_bostaff";
    operator_d.var_f5d1b1026f319b1a = "dx_zm_zmbc_zboc_jsmn_zcps";
    operator_d.var_42ad352ed55ade0f = "dx_zm_zmbc_zboc_jsmn_zcpe";
    operator_r = spawnstruct();
    operator_r.skin = %"t10_usa_pl_flycatcher_base_skin";
    operator_r.weap = "t10_me_p38_sais";
    operator_r.var_f5d1b1026f319b1a = "dx_zm_zmbc_zboc_thai_zpfs";
    operator_r.var_42ad352ed55ade0f = "dx_zm_zmbc_zboc_thai_zpfe";
    operator_m = spawnstruct();
    operator_m.skin = %"t10_usa_pl_jay_base_skin";
    operator_m.weap = "t10_me_p39_nunchaku";
    operator_m.var_f5d1b1026f319b1a = "dx_zm_zmbc_zboc_asam_zcpo";
    operator_m.var_42ad352ed55ade0f = "dx_zm_zmbc_zboc_asam_zpoe";
    operator_s = spawnstruct();
    operator_s.skin = %"t10_usa_pl_buck_base_skin";
    operator_s.weap = "t10_me_p40_bostaff_brownsugar";
    operator_s.var_f5d1b1026f319b1a = "dx_zm_zmbc_zboc_brwn_zpbs";
    operator_s.var_42ad352ed55ade0f = "dx_zm_zmbc_zboc_brwn_zpbe";
    level.var_959fb7a8cc9c3690 = [ operator_l, operator_d, operator_r, operator_m, operator_s ];
}

// Namespace zm_boba
// Params 2
// Checksum 0x376e8bec, Offset: 0xa34
// Size: 0x9a
function function_b1ddfd257a6060ec( str_powerup, ent_powerup )
{
    a_players = powerups::get_powerup_players( str_powerup );
    
    foreach ( player in a_players )
    {
        player thread function_1befb5f3c3f8b040( str_powerup );
    }
}

// Namespace zm_boba
// Params 1
// Checksum 0xfb55ca91, Offset: 0xad6
// Size: 0x256
function function_1befb5f3c3f8b040( str_powerup )
{
    self endon( #"death_or_disconnect" );
    self notify( #"hash_e1bdf2af3c6321ad" );
    self endon( #"hash_e1bdf2af3c6321ad" );
    
    if ( !isdefined( self.var_a46c5e91bf1b0e3d ) )
    {
        if ( self.ismutantinjection || self.mutantinjectiontransformed )
        {
            return;
        }
        
        val::set( "powerup_boba_3", "weapon_pickup", 0 );
        val::set( "powerup_boba_3", "crate_use", 0 );
        
        foreach ( var_386c01eb444cabb9 in level.var_959fb7a8cc9c3690 )
        {
            if ( self.operatorcustomization.skinref == var_386c01eb444cabb9.skin )
            {
                boba_op = var_386c01eb444cabb9;
            }
        }
        
        if ( !isdefined( boba_op ) )
        {
            boba_op = utility::array_random( level.var_959fb7a8cc9c3690 );
        }
        
        self.var_a46c5e91bf1b0e3d = 1;
        self.boba_op = boba_op;
        self playlocalsound( #"hash_e9b2d63f91cb3f1a" );
        thread function_5c1d7c63f50cbe93();
        thread function_7fd4808fe6057fe9( boba_op.weap );
        function_1a9f22ae5fbc86d2( self, 1 );
        level thread namespace_c0b4f2882c9d100f::vo_say_announcer( boba_op.var_f5d1b1026f319b1a );
        self setscriptablepartstate( "bgb_profit_sharing", "boba_fx_on", 0 );
        
        if ( isdefined( level.var_5b7f625835bf2018 ) )
        {
            level thread [[ level.var_5b7f625835bf2018 ]]( 1 );
        }
    }
    
    thread powerups_cpmp::function_52318afc13635e7c( str_powerup, 30 );
    wait 30;
    level thread namespace_c0b4f2882c9d100f::vo_say_announcer( self.boba_op.var_42ad352ed55ade0f );
    
    while ( self.ismutantinjection || self.mutantinjectiontransformed )
    {
        waitframe();
    }
    
    thread function_9a2bfa41b03685c2();
    val::reset( "powerup_boba_3", "weapon_pickup" );
    val::reset( "powerup_boba_3", "crate_use" );
    
    if ( isdefined( level.var_5b7f625835bf2018 ) )
    {
        level thread [[ level.var_5b7f625835bf2018 ]]( 0 );
    }
    
    self.var_a46c5e91bf1b0e3d = undefined;
    self.boba_op = undefined;
}

// Namespace zm_boba
// Params 0
// Checksum 0x966ada39, Offset: 0xd34
// Size: 0x38
function function_81d3c34cc9d1a47e()
{
    if ( utility::issharedfuncdefined( #"powerup_boba_three", #"hash_75b10183404b5a16" ) )
    {
        return utility::callsharedfunc( #"powerup_boba_three", #"hash_75b10183404b5a16" );
    }
    
    return 1;
}

// Namespace zm_boba
// Params 2
// Checksum 0x27fb349a, Offset: 0xd75
// Size: 0x4e
function function_b04246940a8199d3( chance, context )
{
    if ( utility::issharedfuncdefined( #"powerup_boba_three", #"modify_drop_chance" ) )
    {
        return utility::callsharedfunc( #"powerup_boba_three", #"modify_drop_chance", chance, context );
    }
    
    return chance;
}

// Namespace zm_boba
// Params 0
// Checksum 0xc9b3ecb8, Offset: 0xdcc
// Size: 0x31
function function_5c1d7c63f50cbe93()
{
    n_max_total_health = self.maxhealth + 150;
    self.maxhealth = n_max_total_health;
    playerhealth::forcehealthregendelay( self, 1, 1 );
}

// Namespace zm_boba
// Params 0
// Checksum 0x689623a3, Offset: 0xe05
// Size: 0x92
function function_b484a7f18a59c789()
{
    if ( zombie_perks::has_perk( "specialty_juggernog" ) )
    {
        self.var_f7aab25af0479839 = 1;
        zombie_perks::take_perk( "specialty_juggernog" );
        waitframe();
    }
    else
    {
        n_max_total_health = int( getmatchrulesdata( "commonOption", "maxHealth" ) );
        self.maxhealth = n_max_total_health;
    }
    
    if ( self.var_f7aab25af0479839 )
    {
        zombie_perks::give_perk( "specialty_juggernog", 0, 0 );
        self.var_f7aab25af0479839 = undefined;
    }
    
    if ( isalive( self ) )
    {
        self.health = self.maxhealth;
    }
}

// Namespace zm_boba
// Params 1
// Checksum 0xb3516d9c, Offset: 0xe9f
// Size: 0xb6
function function_7fd4808fe6057fe9( weapname )
{
    self endon( #"death_or_disconnect" );
    self.var_789fe40eacd01445 = self getcurrentweapon();
    zm_utility::function_d47920bb0d5fa327( "boba3_giveweapon" );
    zm_utility::function_92275a9d3969d91d();
    waitframe();
    weap = weapon::buildweapon( weapname );
    self giveweapon( weap, undefined, 0, -1, 1 );
    self.var_cc1262e66dbb1c79 = weap;
    self.var_f1ad71336d1914c5 = self.b_disable_pap_camo;
    waitframe();
    self.b_disable_pap_camo = 1;
    self switchtoweapon( weap );
    item_weapon::function_40e1cbd0e1f47d1a( weap, 4 );
    pack_a_punch::pap_weapon( weap, 2, 0, 1, #"essence" );
    thread function_36154745f99dd859();
}

// Namespace zm_boba
// Params 0
// Checksum 0x7e5d923, Offset: 0xf5d
// Size: 0x32
function function_36154745f99dd859()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_3e31dbf443ae7b5b" );
    self waittill( #"zmb_max_ammo" );
    self.var_8704ba881b5e4852 = 1;
}

// Namespace zm_boba
// Params 0
// Checksum 0xb17bf228, Offset: 0xf97
// Size: 0x5f
function function_4c864def19210087()
{
    self endon( #"death_or_disconnect" );
    
    while ( self.inlaststand )
    {
        waitframe();
    }
    
    zm_utility::function_663d59490abc834f( self.var_789fe40eacd01445, 1 );
    self.b_disable_pap_camo = self.var_f1ad71336d1914c5;
    
    if ( self.var_8704ba881b5e4852 )
    {
        full_ammo::function_cf46f312587658ee();
        self.var_8704ba881b5e4852 = undefined;
    }
}

// Namespace zm_boba
// Params 0
// Checksum 0x649c7ad3, Offset: 0xffe
// Size: 0x58
function function_9a2bfa41b03685c2()
{
    self notify( #"hash_3e31dbf443ae7b5b" );
    thread function_b484a7f18a59c789();
    thread function_4c864def19210087();
    self playlocalsound( #"hash_c3a11eeae94765cb" );
    function_1a9f22ae5fbc86d2( self, 0 );
    
    if ( self getscriptablepartstate( "bgb_profit_sharing" ) == "boba_fx_on" )
    {
        self setscriptablepartstate( "bgb_profit_sharing", "bgb_fx_off", 0 );
    }
}

// Namespace zm_boba
// Params 2, eflags: 0x4
// Checksum 0x4a375297, Offset: 0x105e
// Size: 0x44
function private function_1a9f22ae5fbc86d2( player, isactive )
{
    var_25f925f48ee1e217 = player.sessionuimemberindex;
    
    if ( var_25f925f48ee1e217 != -1 )
    {
        function_a9a8165656e26139( "ui_is_player_at_squad_index_transformed", var_25f925f48ee1e217, 1, isactive );
    }
}

