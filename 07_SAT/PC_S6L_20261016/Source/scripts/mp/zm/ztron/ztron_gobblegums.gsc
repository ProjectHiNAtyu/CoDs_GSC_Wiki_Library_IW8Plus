// scripts\mp\zm\ztron\ztron_gobblegums.gsc  (hash_1548e8035f3c2213.gscc) (size: 30782 Bytes / 0x783e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x135a549e (324687006)
// size ...... 30782 (0x783e)
// includes .. 28  (offset: 0x734e)
// strings ... 70  (offset: 0x742e)
// dev strs .. 2   (offset: 0x7826)
// exports ... 118 (offset: 0x454e)
// cseg ...... 0xabb + 0x3a93 (0x454e)
// imports ... 230 (offset: 0x57be)
// animtree1 . 0   (offset: 0x783e)
// animtree2 . 0   (offset: 0x783e)
#using script_1c34295b60b7d53c;
#using script_31ee2a173f3499b7;
#using script_3401cf8ba2ee045;
#using script_3940e26d28ff3a75;
#using script_4610d4deaba537e;
#using script_4752051716e28258;
#using script_4ce55cfc81c444ad;
#using script_540a62162cef20f0;
#using script_5441a11286579ddc;
#using script_75994df35243cb2a;
#using script_aa3bac81ad4fc8e;
#using scripts\anim\dialogue;
#using scripts\anim\utility;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\loot;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_debug;
#using scripts\mp\zm\ztron\ztron_enemy;
#using scripts\mp\zm\ztron\ztron_enemy_ai;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_main;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_score;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;
#using scripts\mp\zm\ztron\ztron_weapon;

#namespace ztron_gobblegums;

// Namespace ztron_gobblegums
// Params 0, eflags: 0x5
// Checksum 0xcc1a3341, Offset: 0xad9
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"ztron_gobblegums", undefined, undefined, &post_main );
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0xdfdc82b0, Offset: 0xafa
// Size: 0x97
function init()
{
    level thread function_64d6f7254be790a7();
    level.var_23378cc637cedbd7 = &validategobblegum;
    level.zm_get_current_zone_override = &function_3c80c96c509f6811;
    level.zm_get_round_number_override = &function_e25a9ced474d25d7;
    level.var_8e3d9df005542454 = &function_e58ae7579feff0ef;
    level.var_62bb99225010cdf3 = &function_c9116de5a0323dee;
    ztron_sound::function_4ac735395b173fe( "brimstone_incoming", "evt_ztron_brimstone_incoming" );
    ztron_sound::function_4ac735395b173fe( "brimstone_explo", "evt_ztron_brimstone_explode" );
    
    if ( level.ztron.cabinetmode )
    {
        level.bgb_pack_override = function_8de2ef0a64e4161b();
    }
}

// Namespace ztron_gobblegums
// Params 0, eflags: 0x4
// Checksum 0x6cf11ca5, Offset: 0xb99
// Size: 0x71
function private function_8de2ef0a64e4161b()
{
    return [ getdvar( @"hash_42c6ac79594eac5c", "respin_cycle" ), getdvar( @"hash_42c6af79594eb2f5", "dead_drop" ), getdvar( @"hash_42c6ae79594eb0c2", "explosive_flourish" ), getdvar( @"hash_42c6a979594ea5c3", "quacknarok" ), getdvar( @"hash_42c6a879594ea390", "wall_to_wall_clearance" ) ];
}

// Namespace ztron_gobblegums
// Params 0, eflags: 0x4
// Checksum 0x80a516b1, Offset: 0xc13
// Size: 0x20
function private post_main()
{
    utility::registersharedfunc( #"bgb", #"convert_gobblegum", &function_b6be751f6fa6f6c8 );
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0x483ee23d, Offset: 0xc3b
// Size: 0x1a
function main()
{
    self notify( #"hash_165dab9c17e95cf0" );
    self endon( #"hash_165dab9c17e95cf0" );
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0x4d6f628c, Offset: 0xc5d
// Size: 0x15
function function_e25a9ced474d25d7()
{
    return level.ztron.roundnumber;
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0xad07f354, Offset: 0xc7b
// Size: 0xb
function function_3c80c96c509f6811()
{
    return #"ztron";
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0x232975d7, Offset: 0xc8f
// Size: 0x7f
function function_e58ae7579feff0ef()
{
    if ( level.ztron.cabinetmode )
    {
        return function_8de2ef0a64e4161b();
    }
    
    var_de48a70a55b51b66 = [ #"", #"", #"", #"", #"" ];
    
    if ( self hasplayerdata() )
    {
        return function_c9116de5a0323dee( 0 );
    }
    
    return var_de48a70a55b51b66;
}

// Namespace ztron_gobblegums
// Params 1
// Checksum 0xeb303879, Offset: 0xd17
// Size: 0x8c
function function_c9116de5a0323dee( index )
{
    var_37dc0376726efd20 = [];
    
    for ( gumindex = 0; gumindex < 5 ; gumindex++ )
    {
        gumlootid = self getplayerdata( level.loadoutsgroup, "equippedPack", "gumLootIDs", gumindex );
        gumref = loot::function_f54ecb89dfab8e8c( gumlootid );
        
        if ( isdefined( gumref ) )
        {
            var_37dc0376726efd20[ gumindex ] = getxhash( gumref );
            continue;
        }
        
        var_37dc0376726efd20[ gumindex ] = #"";
    }
    
    return var_37dc0376726efd20;
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0xb8536200, Offset: 0xdac
// Size: 0x2
function disable()
{
    
}

// Namespace ztron_gobblegums
// Params 1
// Checksum 0x3f4d4c14, Offset: 0xdb6
// Size: 0x115, Type: bool
function validategobblegum( ggname )
{
    if ( level.ztron.var_95d8c7a469393957 || level.ztron.blitzmode )
    {
        return false;
    }
    
    if ( !level.ztron.gobblegumsenabled )
    {
        return false;
    }
    
    if ( level.ztron.blockgg )
    {
        return false;
    }
    
    if ( self.ztron.blockgg )
    {
        return false;
    }
    
    if ( level.bgp[ ggname ].var_65443a749236d116 )
    {
        ztron_debug::debugmsg( "Gobble Gum " + ggname + " is not supported in DOA" );
        return false;
    }
    
    var_26f130d59db084d7 = ztron_main::function_4da200e9b8d58a3c();
    
    if ( var_26f130d59db084d7 == 1 || var_26f130d59db084d7 == 5 )
    {
        return true;
    }
    
    if ( var_26f130d59db084d7 == 3 )
    {
        if ( level.ztron.var_8a9067aa4cd65369.hazardzone )
        {
            return true;
        }
        
        if ( !function_7cfdad6a0da47a2f( ggname ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace ztron_gobblegums
// Params 1
// Checksum 0xeddbc07e, Offset: 0xed4
// Size: 0x80
function function_7cfdad6a0da47a2f( ggname )
{
    if ( ggname )
    {
        blacklist = [ "arsenal_accelerator", "kill_joy", "tactical_diffusion", "whos_keeping_score", "respin_cycle", "free_fire", "soda_fountain", "immolation_liquidation", "round_off", "near_death_experience" ];
        return arraycontains( blacklist, ggname );
    }
}

// Namespace ztron_gobblegums
// Params 1
// Checksum 0x99bb54f9, Offset: 0xf5c
// Size: 0x44
function function_567e40a90a218019( ggname )
{
    if ( ztron_main::function_4da200e9b8d58a3c() != 1 )
    {
        function_95d5e1686d9b9d66();
        return 0;
    }
    
    result = validategobblegum( ggname );
    
    if ( !result )
    {
        function_95d5e1686d9b9d66();
    }
    
    return result;
}

// Namespace ztron_gobblegums
// Params 1
// Checksum 0xb3c28eda, Offset: 0xfa9
// Size: 0xba
function function_21d28fc5b0aad9a2( hash )
{
    if ( isdefined( hash ) )
    {
        keys = getarraykeys( level.ztron.var_d3124fdd62dd9b27 );
        
        foreach ( key in keys )
        {
            if ( key == hash )
            {
                return level.ztron.var_d3124fdd62dd9b27[ key ];
            }
        }
    }
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0x53045c70, Offset: 0x106c
// Size: 0x224
function function_64d6f7254be790a7()
{
    level waittill( #"ztron_game_reset" );
    
    if ( level.ztron.var_84c259bb82ac8285 )
    {
        return;
    }
    
    level.ztron.var_d3124fdd62dd9b27 = [];
    level.ztron.var_84c259bb82ac8285 = 1;
    
    foreach ( var_86b85831429e52f4 in level.bgb )
    {
        level.ztron.var_d3124fdd62dd9b27[ getxhash( var_86b85831429e52f4.name ) ] = var_86b85831429e52f4.name;
        overridesettings = function_d0b288fff91a3fe7( var_86b85831429e52f4.name );
        
        if ( !overridesettings.donothing )
        {
            var_86b85831429e52f4.var_e187252c277f51b1 = overridesettings.var_9fa31e7ba059f090;
            var_86b85831429e52f4.var_866744e27c70eb1c = overridesettings.validatefunc;
            var_86b85831429e52f4.var_eeaed1eb223197cd = overridesettings.activatefunc;
            var_86b85831429e52f4.var_eeb9a3815362758c = overridesettings.enablefunc;
            var_86b85831429e52f4.var_882452eafdaa1626 = overridesettings.var_882452eafdaa1626;
            var_86b85831429e52f4.limit = overridesettings.limit;
            var_86b85831429e52f4.hint = overridesettings.hint;
            var_86b85831429e52f4.hint_oos = undefined;
            var_86b85831429e52f4.var_f7a5175f1157cddd = overridesettings.var_f7a5175f1157cddd;
            var_86b85831429e52f4.var_925d847561d6b98e = overridesettings.var_925d847561d6b98e;
        }
        
        if ( level.ztron.cabinetmode )
        {
            var_86b85831429e52f4.consumable = 0;
        }
    }
    
    level utility::flag_set( "ztron_gobblegums_initialized" );
}

// Namespace ztron_gobblegums
// Params 1
// Checksum 0xab4e9acb, Offset: 0x1298
// Size: 0x179
function function_8571318e6b50e284( fullinit )
{
    self endon( #"disconnect" );
    level utility::flag_wait( "ztron_gobblegums_initialized" );
    
    if ( fullinit )
    {
        if ( level.ztron.cabinetmode )
        {
            bgb::take( 1 );
            bgb::take( 2 );
            bgb::take( 3 );
            bgb::set_action_slot( 1, getdvar( @"hash_42c6ac79594eac5c", "respin_cycle" ), 0, 0 );
            bgb::set_action_slot( 2, getdvar( @"hash_42c6af79594eb2f5", "dead_drop" ), 0, 0 );
            bgb::set_action_slot( 3, getdvar( @"hash_42c6ae79594eb0c2", "explosive_flourish" ), 0, 0 );
        }
        
        if ( !callback::exists( "on_gobblegum_used", &function_e3b046bc6a711802 ) )
        {
            callback::add( "on_gobblegum_used", &function_e3b046bc6a711802 );
        }
    }
    
    if ( getdvarint( @"hash_294f374ff45e6632" ) || getmatchrulesdata( "zmData", "disableBGB" ) || level.ztron.var_95d8c7a469393957 || !level.ztron.gobblegumsenabled )
    {
        self.ztron.blockgg = 1;
        thread ztron_ui::function_545666b11d318ade( 2 );
        
        for ( i = 1; i <= 3 ; i++ )
        {
            bgb::clear_action_slot( i );
        }
        
        return;
    }
    
    utility::flag_set( "begin_round_logic" );
}

// Namespace ztron_gobblegums
// Params 1, eflags: 0xc
// Checksum 0x982664c5, Offset: 0x1419
// Size: 0x64
function private function_e3b046bc6a711802( params )
{
    self notify( #"hash_4ee2c5bdf2ba827f" );
    self endon( #"hash_4ee2c5bdf2ba827f" );
    thread dialogue::say( level.ztron.dialogues[ "on_gobblegum_used" ], 0, 0, 1, 0, "global" );
    self.ztron.var_3c6c0516b9bba99e = params;
}

// Namespace ztron_gobblegums
// Params 1
// Checksum 0xc29cbcca, Offset: 0x1485
// Size: 0xd49
function function_d0b288fff91a3fe7( ggname )
{
    overridesettings = spawnstruct();
    overridesettings.var_9fa31e7ba059f090 = &disable;
    overridesettings.validatefunc = &function_b35ae8a35057f6f8;
    overridesettings.activatefunc = &function_8cfa919bae66fd7a;
    overridesettings.enablefunc = undefined;
    overridesettings.limit = 1;
    overridesettings.var_882452eafdaa1626 = "activated";
    overridesettings.var_f7a5175f1157cddd = 1;
    overridesettings.var_925d847561d6b98e = undefined;
    
    switch ( ggname )
    {
        case #"hash_a648d524de3bf2c0":
            overridesettings.activatefunc = &function_830d0a1061c47bf;
            break;
        case #"hash_2e85a981d76f1e38":
            overridesettings.donothing = 1;
            break;
        case #"hash_cb713aba09a45f7":
            overridesettings.activatefunc = &function_97faaed351fecdba;
            overridesettings.validatefunc = &function_fe674d4fccc1c3b7;
            break;
        case #"hash_85c1d7fa646ed50e":
            overridesettings.activatefunc = &function_41c3c640c5275edc;
            overridesettings.validatefunc = &function_f6f881c79f618fd;
            break;
        case #"hash_b887cb8f352d17b1":
            overridesettings.enablefunc = &function_8e13a1358a19390b;
            overridesettings.activatefunc = undefined;
            overridesettings.limit = 30;
            overridesettings.var_882452eafdaa1626 = "time";
            break;
        case #"hash_ce761b58c60d0acd":
            overridesettings.activatefunc = &function_5e308b80ad895835;
            break;
        case #"hash_1b7582a156b104e":
            overridesettings.activatefunc = &function_d4aa357641dca6b6;
            break;
        case #"hash_5b90b0afe4c76465":
            overridesettings.validatefunc = &function_aa17d91c62322faa;
            overridesettings.enablefunc = &function_b899bb111c29afb9;
            overridesettings.activatefunc = undefined;
            overridesettings.limit = 300;
            overridesettings.var_882452eafdaa1626 = "time";
            overridesettings.var_925d847561d6b98e = &function_91b578e81292981d;
            break;
        case #"hash_bc87445420837579":
            overridesettings.donothing = 1;
            break;
        case #"hash_408424aab12ec40b":
            overridesettings.validatefunc = &function_df34f0a8f76a63ef;
            overridesettings.enablefunc = &function_fa7d85842265d694;
            overridesettings.activatefunc = undefined;
            overridesettings.limit = 600;
            overridesettings.var_882452eafdaa1626 = "time";
            overridesettings.var_925d847561d6b98e = &function_7cca353b469d09b8;
            break;
        case #"hash_73d480d256a19d7":
            overridesettings.enablefunc = &function_b149bd16273529bb;
            overridesettings.activatefunc = undefined;
            overridesettings.limit = 1800;
            overridesettings.var_882452eafdaa1626 = "time";
            overridesettings.var_925d847561d6b98e = &function_d12a84de7b548c37;
            break;
        case #"hash_47d0a52955ef56d5":
            overridesettings.activatefunc = &function_de0141e169f950eb;
            break;
        case #"hash_87f9f47b5d5cb3db":
            overridesettings.donothing = 1;
            break;
        case #"hash_e0356e5d9f8530cb":
            overridesettings.donothing = 1;
            break;
        case #"hash_9a381eb7c0c03b20":
            overridesettings.enablefunc = &function_36bfb24cb2b81670;
            overridesettings.activatefunc = undefined;
            overridesettings.limit = 60;
            overridesettings.var_882452eafdaa1626 = "time";
            overridesettings.var_925d847561d6b98e = &function_d23e440179e54274;
            break;
        case #"hash_912374f5f53257e8":
            overridesettings.validatefunc = &function_f7033f6d1e862a3d;
            overridesettings.activatefunc = &function_5596f377098aaf9c;
            break;
        case #"hash_1b89742a4e80648e":
            overridesettings.validatefunc = &function_fc456acf10d8ae9d;
            overridesettings.activatefunc = &function_8e78b0d5a83055f2;
            break;
        case #"hash_d6150dfe9afcc78f":
            overridesettings.validatefunc = &function_b8730c82fd6bdac;
            overridesettings.activatefunc = &function_e55831b8b0e6505f;
            break;
        case #"hash_e4333654192fe103":
            overridesettings.enablefunc = &function_e79b8aeb5af91101;
            overridesettings.activatefunc = undefined;
            overridesettings.limit = 600;
            overridesettings.var_882452eafdaa1626 = "time";
            overridesettings.var_925d847561d6b98e = &function_fe09c25f080ce59d;
            break;
        case #"hash_477f8d0003a232c9":
            overridesettings.donothing = 1;
            break;
        case #"hash_303f43df25b17436":
            overridesettings.donothing = 1;
            break;
        case #"hash_7ed458096ea613d4":
            overridesettings.enablefunc = &function_1218b7fb7d0de30d;
            overridesettings.activatefunc = undefined;
            overridesettings.limit = 300;
            overridesettings.var_882452eafdaa1626 = "time";
            overridesettings.var_925d847561d6b98e = &function_dee502f200b2dc9;
            break;
        case #"hash_7d0d346bec096283":
            overridesettings.donothing = 1;
            break;
        case #"hash_551edce1228a29f4":
            overridesettings.validatefunc = &function_819cf7b336d5853a;
            overridesettings.enablefunc = &function_85e5a0a2a2cd5ca;
            overridesettings.activatefunc = undefined;
            overridesettings.limit = 60;
            overridesettings.var_882452eafdaa1626 = "time";
            overridesettings.var_925d847561d6b98e = &function_667beff3ebdc1d84;
            break;
        case #"hash_1e3c2c880db13c91":
            overridesettings.donothing = 1;
            break;
        case #"hash_52ffa7c8ee0c1e11":
            overridesettings.donothing = 1;
            break;
        case #"hash_a7c2be2cfcc8c7cf":
            overridesettings.validatefunc = &function_19420b46754e052c;
            overridesettings.enablefunc = &function_70c3e3bb5f3a99dc;
            overridesettings.activatefunc = undefined;
            overridesettings.limit = 10;
            overridesettings.var_882452eafdaa1626 = "time";
            overridesettings.var_925d847561d6b98e = &function_c862bde4c4788210;
            break;
        case #"hash_bd9618d96c52ffdc":
            overridesettings.donothing = 1;
            break;
        case #"hash_2cbdc0f24f302da4":
            overridesettings.activatefunc = &function_ef40cd927fd5d281;
            break;
        case #"hash_3b1fa3f09c604257":
            overridesettings.activatefunc = &function_250cea620d83b78e;
            break;
        case #"hash_dcbc54a477d1043b":
            overridesettings.activatefunc = &function_973a3c798b3dfaec;
            break;
        case #"hash_25f41071215bc340":
            overridesettings.donothing = 1;
            break;
        case #"hash_64daf7cfea7fe26c":
            overridesettings.activatefunc = &function_c8052efe158d38fe;
            break;
        case #"hash_d0eaa35873db1d98":
            overridesettings.enablefunc = &function_c7b4d531fc5c2ae2;
            overridesettings.activatefunc = undefined;
            overridesettings.limit = 300;
            overridesettings.var_882452eafdaa1626 = "time";
            overridesettings.var_925d847561d6b98e = &function_86f79aaeefd2defe;
            break;
        case #"hash_c315e69b670e9678":
            overridesettings.enablefunc = &function_fbd5c7f7477f1a50;
            overridesettings.activatefunc = undefined;
            overridesettings.limit = 60;
            overridesettings.var_882452eafdaa1626 = "time";
            overridesettings.var_925d847561d6b98e = &function_47a7991a5814ffc2;
            break;
        case #"hash_495c0c1b33d9b414":
            overridesettings.validatefunc = &function_c2c2e61f8aac3d1e;
            overridesettings.activatefunc = &function_e41cb89b94311fea;
            break;
        case #"hash_600d1030f4ef37":
            overridesettings.donothing = 1;
            break;
        case #"hash_707c896a4bb57829":
            overridesettings.donothing = 1;
            break;
        case #"hash_18a182cf11e85771":
            overridesettings.validatefunc = &function_979365999140cce5;
            overridesettings.activatefunc = &function_606cfbf7b7942531;
            break;
        case #"hash_576bab0b8626344b":
            overridesettings.validatefunc = &function_18e3ce6da5fa1445;
            overridesettings.activatefunc = &function_7fbcc8767a153bfb;
            break;
        case #"hash_dc68b5370558e47":
            overridesettings.activatefunc = &function_171d930e0876fc0;
            break;
        case #"hash_fa1cbff638900491":
            overridesettings.activatefunc = &function_70b82d41e7b69783;
            overridesettings.validatefunc = &function_edc3e0989178e000;
            break;
        case #"hash_fdbae0875e6f63af":
            overridesettings.validatefunc = &function_c711ad4b7854fd17;
            overridesettings.enablefunc = &function_3f9aed588096a133;
            overridesettings.activatefunc = undefined;
            overridesettings.var_9fa31e7ba059f090 = &function_8b4db647308b21a;
            overridesettings.limit = 300;
            overridesettings.var_882452eafdaa1626 = "time";
            overridesettings.var_925d847561d6b98e = &function_97b4a15da7029c17;
            break;
        case #"hash_25b68f530d97ade0":
            overridesettings.donothing = 1;
            break;
        case #"hash_1a07555d5384dcf5":
            overridesettings.validatefunc = &function_567e40a90a218019;
            overridesettings.enablefunc = &function_1c26bb4121e5b21f;
            overridesettings.activatefunc = undefined;
            overridesettings.limit = 300;
            overridesettings.var_882452eafdaa1626 = "time";
            overridesettings.var_925d847561d6b98e = &function_1e57b9ad28f538ab;
            break;
        case #"hash_e83864e8050c4783":
            overridesettings.activatefunc = &function_d4179ca330479027;
            break;
        case #"hash_f22d4dbd298e60bc":
            overridesettings.enablefunc = &function_175ceacda031441c;
            overridesettings.activatefunc = undefined;
            overridesettings.limit = 300;
            overridesettings.var_882452eafdaa1626 = "time";
            overridesettings.var_925d847561d6b98e = &function_dee05e9bf942ff28;
            break;
        case #"hash_eee3ac45e4acfad8":
            overridesettings.enablefunc = &function_97cee97fce530740;
            overridesettings.activatefunc = undefined;
            overridesettings.limit = 90;
            overridesettings.var_882452eafdaa1626 = "time";
            overridesettings.var_925d847561d6b98e = &function_2ccd9cf175cec9ec;
            break;
        case #"hash_c89848c151306c22":
            overridesettings.activatefunc = &function_a707775e89a0aa0e;
            break;
        case #"hash_3a711ea891cf7c7b":
            overridesettings.validatefunc = &function_567e40a90a218019;
            overridesettings.enablefunc = &function_8226a1462b7ef7d3;
            overridesettings.activatefunc = undefined;
            overridesettings.limit = 1800;
            overridesettings.var_882452eafdaa1626 = "time";
            overridesettings.var_925d847561d6b98e = &function_4736ea87a079b207;
            break;
        case #"hash_4ab376a26079fbbc":
            overridesettings.activatefunc = &function_8fcfa0056979d7ca;
            break;
        case #"hash_fffef9bd5de0610f":
            overridesettings.activatefunc = &function_19b7e6d882ca32cd;
            break;
        case #"hash_aaf5b8a331f3555d":
            overridesettings.validatefunc = &function_e7aeb767fe63f5ed;
            overridesettings.enablefunc = &function_ce56b39fd63faa4a;
            overridesettings.activatefunc = undefined;
            overridesettings.limit = 120;
            overridesettings.var_882452eafdaa1626 = "time";
            overridesettings.var_925d847561d6b98e = &function_5606c521059314e6;
            break;
        case #"hash_bbbb9439bc7a1999":
            overridesettings.validatefunc = &function_daa7165333710baf;
            overridesettings.enablefunc = &function_175665e24d098ec8;
            overridesettings.activatefunc = undefined;
            overridesettings.limit = 300;
            overridesettings.var_882452eafdaa1626 = "time";
            overridesettings.var_925d847561d6b98e = &function_1c0a7143cd436fb4;
            break;
        case #"hash_1ba400f3ebbececb":
            overridesettings.validatefunc = &function_567e40a90a218019;
            overridesettings.enablefunc = &function_a2b1f2262256dba8;
            overridesettings.activatefunc = undefined;
            overridesettings.limit = 1800;
            overridesettings.var_882452eafdaa1626 = "time";
            overridesettings.var_925d847561d6b98e = &function_b6d710a2c3c4a6c4;
            break;
        default:
            assertmsg( "<dev string:x24>" + ggname + "<dev string:x30>" );
            ztron_debug::debugmsg( "Gobble Gum " + ggname + " has no enable_func mapping in DOA" );
            overridesettings.var_65443a749236d116 = 1;
            break;
    }
    
    return overridesettings;
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0xd0195c7d, Offset: 0x21d7
// Size: 0x1a
function function_95d5e1686d9b9d66()
{
    if ( self )
    {
        ztron_dialog::function_927bb94feca983e8( #"hash_d78c30f22be8493a", 1, 1 );
    }
}

// Namespace ztron_gobblegums
// Params 1
// Checksum 0x8f6014b5, Offset: 0x21f9
// Size: 0x2f
function function_b35ae8a35057f6f8( ggname )
{
    result = validategobblegum( ggname );
    
    if ( !result )
    {
        function_95d5e1686d9b9d66();
    }
    
    return result;
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0xb6e188e8, Offset: 0x2231
// Size: 0x2
function function_8cfa919bae66fd7a()
{
    
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0x707f2669, Offset: 0x223b
// Size: 0x18
function function_830d0a1061c47bf()
{
    self.ztron.var_8487be91b45f17c5 = 1;
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0x8a7e5de, Offset: 0x225b
// Size: 0x28, Type: bool
function function_fe674d4fccc1c3b7()
{
    if ( gettime() < self.ztron.var_52650c188f2276c2 )
    {
        function_95d5e1686d9b9d66();
        return false;
    }
    
    return true;
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0x3d90eb50, Offset: 0x228c
// Size: 0x2f
function function_97faaed351fecdba()
{
    thread namespace_3d206415c2287a2b::addchicken( 0, 300, 1, 1 );
    self.ztron.var_52650c188f2276c2 = gettime() + 600000;
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0x7816d91d, Offset: 0x22c3
// Size: 0x78
function function_f6f881c79f618fd()
{
    if ( self.ztron.var_4095e0b1332ea87 == 0 )
    {
        return 1;
    }
    
    result = self.ztron.var_4095e0b1332ea87 > 0 && self.ztron.var_6fe8ea86c8758aec < self.ztron.var_4095e0b1332ea87;
    
    if ( !result )
    {
        function_95d5e1686d9b9d66();
    }
    
    return result;
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0x523c008c, Offset: 0x2344
// Size: 0x5e
function function_41c3c640c5275edc()
{
    if ( self.ztron.var_4095e0b1332ea87 == 0 )
    {
        self.ztron.var_4095e0b1332ea87 = 1;
    }
    
    self.ztron.var_6fe8ea86c8758aec = self.ztron.var_4095e0b1332ea87;
    ztron_ui::function_38a72e402dc87ace();
}

// Namespace ztron_gobblegums
// Params 1
// Checksum 0xb293791c, Offset: 0x23aa
// Size: 0x78
function function_600d5bfb7b2b1b78( superid )
{
    self endon( #"disconnect" );
    super = level.superglobals.staticsuperdata[ superid ];
    
    if ( isdefined( super ) )
    {
        ztron_debug::debugmsg( "Player(" + self.ztron.color + ") poping Random Super: " + superid );
        self [[ super.beginusefunc ]]();
    }
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0xe3867f8a, Offset: 0x242a
// Size: 0x3b
function function_8e13a1358a19390b()
{
    self endon( #"disconnect" );
    thread function_600d5bfb7b2b1b78( "super_energy_mine" );
    wait 15;
    thread function_600d5bfb7b2b1b78( "super_energy_mine" );
    wait 14.75;
    thread function_600d5bfb7b2b1b78( "super_energy_mine" );
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0xa846022d, Offset: 0x246d
// Size: 0x61
function function_5e308b80ad895835()
{
    self endon( #"death_or_disconnect" );
    ztron_weapon::giveweaponpack( %"hash_1d1e9a024950ca1d" );
    ztron_weapon::function_951f0c703dffc47();
    ztron_weapon::function_601fc4d0362f327b();
    ztron_weapon::function_601fc4d0362f327b();
    ztron_weapon::function_601fc4d0362f327b();
    self.ztron.var_f41b955260ed467e = self.ztron.var_dcf9ab22b803b383;
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0x5f9a6815, Offset: 0x24d6
// Size: 0x18
function function_d4aa357641dca6b6()
{
    self.ztron.var_ee12821b601e753a = 1;
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0xe2f7580a, Offset: 0x24f6
// Size: 0x4b, Type: bool
function function_df34f0a8f76a63ef()
{
    if ( isdefined( level.ztron.active_arena ) && level.ztron.active_arena.name == "silverback_arena" )
    {
        function_95d5e1686d9b9d66();
        return false;
    }
    
    return true;
}

// Namespace ztron_gobblegums
// Params 2
// Checksum 0x9b7d7938, Offset: 0x254a
// Size: 0x81
function function_c7e555373b580af9( times, var_42feb778d5700c99 = 0 )
{
    self notify( #"hash_880a4d1e0b6e1720" );
    self endon( #"hash_880a4d1e0b6e1720" );
    self endon( #"disconnect" );
    self.no_hazards = 1;
    
    if ( var_42feb778d5700c99 )
    {
        level utility::waittill_any_timeout( times, "ztron_game_is_over", "ztron_game_reset" );
    }
    else
    {
        level utility::waittill_any_timeout( times, "silverback_arena_activated" );
    }
    
    self.no_hazards = undefined;
}

// Namespace ztron_gobblegums
// Params 1
// Checksum 0xa9c48629, Offset: 0x25d3
// Size: 0x20
function function_fa7d85842265d694( var_42feb778d5700c99 = 0 )
{
    thread function_c7e555373b580af9( 600, var_42feb778d5700c99 );
}

// Namespace ztron_gobblegums
// Params 2
// Checksum 0x27953f01, Offset: 0x25fb
// Size: 0x27
function function_7cca353b469d09b8( time, var_42feb778d5700c99 = 0 )
{
    thread function_c7e555373b580af9( time, var_42feb778d5700c99 );
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0xdb10fe20, Offset: 0x262a
// Size: 0x26
function function_aa17d91c62322faa()
{
    result = ztron_main::function_4da200e9b8d58a3c() == 1;
    
    if ( !result )
    {
        function_95d5e1686d9b9d66();
    }
    
    return result;
}

// Namespace ztron_gobblegums
// Params 2
// Checksum 0xa7a6ef0c, Offset: 0x2659
// Size: 0x82
function function_c7c5e11b2ff6f4d1( rate, duration )
{
    self notify( #"hash_3c6b75231776c4fa" );
    self endon( #"hash_3c6b75231776c4fa" );
    level.ztron.var_ee6c88337e58c72e = 0;
    level.ztron.var_66eddb4a56806387 = rate;
    level utility::waittill_any_timeout( duration, "ztron_game_is_over", "ztron_game_reset" );
    level.ztron.var_66eddb4a56806387 = 1;
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0x62abc5e7, Offset: 0x26e3
// Size: 0x12
function function_b899bb111c29afb9()
{
    level thread function_c7c5e11b2ff6f4d1( 0.2, 300 );
}

// Namespace ztron_gobblegums
// Params 1
// Checksum 0xe3287392, Offset: 0x26fd
// Size: 0x1b
function function_91b578e81292981d( time )
{
    level thread function_c7c5e11b2ff6f4d1( 0.2, time );
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0xbfe120ee, Offset: 0x2720
// Size: 0x20
function function_b149bd16273529bb()
{
    level.ztron.var_29c73ec85b0cb9c6 = gettime() + 1800000;
}

// Namespace ztron_gobblegums
// Params 1
// Checksum 0x7c5b3338, Offset: 0x2748
// Size: 0x2b
function function_d12a84de7b548c37( time )
{
    level.ztron.var_29c73ec85b0cb9c6 = gettime() + time * 1000;
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0x8820678f, Offset: 0x277b
// Size: 0x65
function function_de0141e169f950eb()
{
    self endon( #"death_or_disconnect" );
    ztron_weapon::giveweaponpack( %"hash_60a2016301f4d7d6" );
    ztron_weapon::function_951f0c703dffc47( 1, 20 );
    ztron_weapon::function_601fc4d0362f327b();
    ztron_weapon::function_601fc4d0362f327b();
    ztron_weapon::function_601fc4d0362f327b();
    self.ztron.var_f41b955260ed467e = self.ztron.var_dcf9ab22b803b383;
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0x79283398, Offset: 0x27e8
// Size: 0x40
function function_36bfb24cb2b81670()
{
    self endon( #"death_or_disconnect" );
    ztron_weapon::function_951f0c703dffc47( 1, 60 );
    self.ztron.var_f41b955260ed467e = self.ztron.var_dcf9ab22b803b383;
}

// Namespace ztron_gobblegums
// Params 1
// Checksum 0xf8ab84a8, Offset: 0x2830
// Size: 0x4a
function function_d23e440179e54274( time )
{
    self endon( #"death_or_disconnect" );
    ztron_weapon::function_951f0c703dffc47( 1, time );
    self.ztron.var_f41b955260ed467e = self.ztron.var_dcf9ab22b803b383;
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0xaac62358, Offset: 0x2882
// Size: 0x4e
function function_f7033f6d1e862a3d()
{
    result = !( self.ztron.var_4095e0b1332ea87 == 2 && self.ztron.var_6fe8ea86c8758aec == 2 );
    
    if ( !result )
    {
        function_95d5e1686d9b9d66();
    }
    
    return result;
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0x8f85fa6d, Offset: 0x28d9
// Size: 0xe
function function_5596f377098aaf9c()
{
    thread ztron_item::function_bdebc9f850639d13( "ztron_armor_vest2" );
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0xad516f48, Offset: 0x28ef
// Size: 0x46
function function_fc456acf10d8ae9d()
{
    curcash = ztron_player_utility::function_da0857c472c9dc5e();
    result = curcash <= getdvarint( @"hash_35512059a8602abd", 130000 ) - 30000;
    
    if ( !result )
    {
        function_95d5e1686d9b9d66();
    }
    
    return result;
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0x1ad657f2, Offset: 0x293e
// Size: 0x17
function function_8e78b0d5a83055f2()
{
    ztron_player_utility::function_8e1155bcebb3b7b3( 30000 );
    ztron_ui::function_f7e6c4641e827bf8( 1, 3 );
}

// Namespace ztron_gobblegums
// Params 1
// Checksum 0x6ac02e32, Offset: 0x295d
// Size: 0x4f
function function_e79b8aeb5af91101( duration = 600 )
{
    self.ztron.var_44f53f7bae20636e = gettime() + duration * 1000;
    ztron_weapon::giveweaponpack( self.ztron.var_c5c31e76e1c42198 );
}

// Namespace ztron_gobblegums
// Params 1
// Checksum 0x82856d7d, Offset: 0x29b4
// Size: 0x2b
function function_fe09c25f080ce59d( time )
{
    self.ztron.var_44f53f7bae20636e = gettime() + time * 1000;
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0xc8548849, Offset: 0x29e7
// Size: 0xb
function function_1218b7fb7d0de30d()
{
    level thread activateholybrimestone( self );
}

// Namespace ztron_gobblegums
// Params 1
// Checksum 0x8505201a, Offset: 0x29fa
// Size: 0x17
function function_dee502f200b2dc9( time )
{
    level thread activateholybrimestone( self, time );
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0xf2256f45, Offset: 0x2a19
// Size: 0x28, Type: bool
function function_819cf7b336d5853a()
{
    if ( gettime() < level.ztron.var_24aefdb5f53fb42c )
    {
        function_95d5e1686d9b9d66();
        return false;
    }
    
    return true;
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0x6c1dfb83, Offset: 0x2a4a
// Size: 0x3c
function function_85e5a0a2a2cd5ca()
{
    self.ztron.var_6665afa32a182ee0 = gettime() + 60000;
    level.ztron.var_24aefdb5f53fb42c = gettime() + 300000;
}

// Namespace ztron_gobblegums
// Params 1
// Checksum 0x6f48854, Offset: 0x2a8e
// Size: 0x52
function function_667beff3ebdc1d84( time )
{
    self.ztron.var_6665afa32a182ee0 = gettime() + time * 1000;
    level.ztron.var_24aefdb5f53fb42c = gettime() + 300000 - 300000 - time;
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0x52710f6f, Offset: 0x2ae8
// Size: 0x26
function function_19420b46754e052c()
{
    result = ztron_main::function_4da200e9b8d58a3c() == 1;
    
    if ( !result )
    {
        function_95d5e1686d9b9d66();
    }
    
    return result;
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0xdd8ae29d, Offset: 0x2b17
// Size: 0x1e
function function_70c3e3bb5f3a99dc()
{
    self.ztron.var_3672c53f92a18974 = gettime() + 10000;
}

// Namespace ztron_gobblegums
// Params 1
// Checksum 0x3e439003, Offset: 0x2b3d
// Size: 0x2b
function function_c862bde4c4788210( time )
{
    self.ztron.var_3672c53f92a18974 = gettime() + time * 1000;
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0x674a91a2, Offset: 0x2b70
// Size: 0x8b
function function_ef40cd927fd5d281()
{
    self endon( #"death_or_disconnect" );
    
    foreach ( player in level.players )
    {
        player ztron_player_utility::function_28d3a926aa4df460( 1, 1 );
    }
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0x8bd0d72d, Offset: 0x2c03
// Size: 0x18
function function_250cea620d83b78e()
{
    self.ztron.var_e16332c131ecee06 = 1;
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0x72fc8bd2, Offset: 0x2c23
// Size: 0x74
function function_973a3c798b3dfaec()
{
    self notify( #"hash_633abbaf805791ef" );
    ztron_player_utility::function_64952a50eba73135();
    ztron_weapon::giveammomod( level.ztron.ammomodids[ randomint( level.ztron.ammomodids.size ) ] );
    function_41c3c640c5275edc();
    chicken = namespace_3d206415c2287a2b::addchicken( 0, 2700, 0, 1, 1, 0 );
    thread function_867518b74bdb3d4( chicken );
}

// Namespace ztron_gobblegums
// Params 1
// Checksum 0xdee54584, Offset: 0x2c9f
// Size: 0x4e
function function_867518b74bdb3d4( chicken )
{
    self endon( #"disconnect" );
    chicken endon( #"death", #"spin_out" );
    self waittill( #"hash_633abbaf805791ef" );
    
    if ( isdefined( chicken ) )
    {
        chicken notify( #"spin_out" );
    }
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0xce2d7c43, Offset: 0x2cf5
// Size: 0x80
function function_c8052efe158d38fe()
{
    foreach ( player in level.players )
    {
        player ztron_item::function_d2dd7af394ebdbdd( "ztron_extra_life" );
    }
}

// Namespace ztron_gobblegums
// Params 1
// Checksum 0xbc1e5188, Offset: 0x2d7d
// Size: 0x75
function function_19b0b1771c387677( durationsec )
{
    self notify( #"hash_3551802f428e8f35" );
    self endon( #"hash_3551802f428e8f35" );
    self endon( #"death_or_disconnect" );
    level endon( #"ztron_game_is_over", #"ztron_game_reset" );
    activeuntil = gettime() + durationsec * 1000;
    
    while ( gettime() < activeuntil )
    {
        level thread namespace_8898f05447e219f9::function_14c306bcc0c9e83f( self );
        wait 3;
    }
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0xb072ee0c, Offset: 0x2dfa
// Size: 0x17
function function_fbd5c7f7477f1a50()
{
    self endon( #"death_or_disconnect" );
    thread function_19b0b1771c387677( 60 );
}

// Namespace ztron_gobblegums
// Params 1
// Checksum 0x55f3c08a, Offset: 0x2e19
// Size: 0x21
function function_47a7991a5814ffc2( time )
{
    self endon( #"death_or_disconnect" );
    thread function_19b0b1771c387677( time );
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0x2d155096, Offset: 0x2e42
// Size: 0x2c
function function_c7b4d531fc5c2ae2()
{
    self endon( #"death_or_disconnect" );
    self.ztron.var_7983e332af5bf628 = gettime() + 300000;
}

// Namespace ztron_gobblegums
// Params 1
// Checksum 0x80f81965, Offset: 0x2e76
// Size: 0x37
function function_86f79aaeefd2defe( time )
{
    self endon( #"death_or_disconnect" );
    self.ztron.var_7983e332af5bf628 = gettime() + time * 1000;
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0xa3bb1d6a, Offset: 0x2eb5
// Size: 0x2a
function function_c2c2e61f8aac3d1e()
{
    result = level.players.size > 1;
    
    if ( !result )
    {
        function_95d5e1686d9b9d66();
    }
    
    return result;
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0xaaf0e8e3, Offset: 0x2ee8
// Size: 0xbe
function function_e41cb89b94311fea()
{
    var_e22bd8a529218987 = ztron_player_utility::function_da0857c472c9dc5e();
    
    if ( var_e22bd8a529218987 > 0 )
    {
        ztron_player_utility::function_8e1155bcebb3b7b3( var_e22bd8a529218987 * -1 );
        var_4b631ad4eaeb0b75 = int( var_e22bd8a529218987 / level.players.size );
        
        foreach ( player in level.players )
        {
            player ztron_player_utility::function_8e1155bcebb3b7b3( var_4b631ad4eaeb0b75, undefined, undefined, 1 );
        }
    }
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0xea882102, Offset: 0x2fae
// Size: 0x89
function function_7edc2ba44da45211()
{
    self notify( #"hash_6b7679e6ae8eeec2" );
    self endon( #"hash_6b7679e6ae8eeec2" );
    self endon( #"death_or_disconnect" );
    discount = randomintrange( 2, 6 ) * 0.1;
    self.ztron.var_d1918d2fd760ac46 = 1 - discount;
    self waittill( #"hash_939001e91f180a62" );
    self waittill( #"slayermart_is_done" );
    self.ztron.var_d1918d2fd760ac46 = undefined;
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0xe418e1c6, Offset: 0x303f
// Size: 0x32
function function_18e3ce6da5fa1445()
{
    result = !isdefined( self.ztron.var_d1918d2fd760ac46 );
    
    if ( !result )
    {
        function_95d5e1686d9b9d66();
    }
    
    return result;
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0xe7155465, Offset: 0x307a
// Size: 0x9
function function_7fbcc8767a153bfb()
{
    thread function_7edc2ba44da45211();
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0x73567b81, Offset: 0x308b
// Size: 0x4b
function function_979365999140cce5()
{
    result = !isdefined( self.ztron.vehicle ) && !isdefined( self.ztron.vehicleblocked );
    
    if ( !result )
    {
        function_95d5e1686d9b9d66();
    }
    
    return result;
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0xe0d2fec6, Offset: 0x30df
// Size: 0x22
function function_606cfbf7b7942531()
{
    ztron_item::function_d2dd7af394ebdbdd( randomint( 100 ) > 50 ? "ztron_tank" : "ztron_helicopter" );
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0x4139c0eb, Offset: 0x3109
// Size: 0xac
function function_171d930e0876fc0()
{
    self endon( #"death_or_disconnect" );
    
    for ( var_2f9dcaebfba716e0 = 4; var_2f9dcaebfba716e0 ; var_2f9dcaebfba716e0-- )
    {
        if ( namespace_a6a7fe92789f4ad9::function_d99937c243f5f1d6() < ztron_score::function_b986c55261cc358e() && namespace_33e886a9a5b55137::function_a4ca73e22464e330() < ztron_score::getmaxboosts() )
        {
            ztron_item::function_d2dd7af394ebdbdd( randomint( 100 ) > 50 ? "ztron_nuke" : "ztron_boost" );
        }
        else if ( namespace_a6a7fe92789f4ad9::function_d99937c243f5f1d6() < ztron_score::function_b986c55261cc358e() )
        {
            ztron_item::function_d2dd7af394ebdbdd( "ztron_nuke" );
        }
        else if ( namespace_33e886a9a5b55137::function_a4ca73e22464e330() < ztron_score::getmaxboosts() )
        {
            ztron_item::function_d2dd7af394ebdbdd( "ztron_boost" );
        }
        
        wait 0.25;
    }
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0xbe4b73ad, Offset: 0x31bd
// Size: 0x93
function function_edc3e0989178e000()
{
    if ( gettime() < level.ztron.var_6424e7e280deff63 )
    {
        function_95d5e1686d9b9d66();
        return 0;
    }
    
    if ( level.ztron.bossround )
    {
        function_95d5e1686d9b9d66();
        return 0;
    }
    
    result = level utility::flag( "ztron_round_spawning" ) && ztron_main::function_4da200e9b8d58a3c() == 1 && level.ztron.roundnumber < 70;
    
    if ( !result )
    {
        function_95d5e1686d9b9d66();
    }
    
    return result;
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0x357176b6, Offset: 0x3259
// Size: 0x27
function function_70b82d41e7b69783()
{
    level.ztron.var_6424e7e280deff63 = gettime() + 1800000;
    ztron_arena::function_6fc50167bb958c08();
}

// Namespace ztron_gobblegums
// Params 1
// Checksum 0x18e6f21e, Offset: 0x3288
// Size: 0x4e
function function_c711ad4b7854fd17( ggname )
{
    if ( self.ztron.var_604bef368f455697 )
    {
        function_95d5e1686d9b9d66();
        return 0;
    }
    
    result = validategobblegum( ggname );
    
    if ( !result )
    {
        function_95d5e1686d9b9d66();
    }
    
    return result;
}

// Namespace ztron_gobblegums
// Params 1
// Checksum 0x4501ffde, Offset: 0x32df
// Size: 0x66
function function_349efb1be500f4df( params )
{
    self notify( #"hash_5edbdfaf6203abf3" );
    self endon( #"hash_5edbdfaf6203abf3" );
    self endon( #"disconnect", #"shields_up_deactivated" );
    var_e97a4f4962bc3f25 = params.var_e97a4f4962bc3f25;
    self waittill( #"laststand" );
    thread bgb::take( var_e97a4f4962bc3f25 );
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0x3b2b8fba, Offset: 0x334d
// Size: 0x21
function function_8b4db647308b21a()
{
    self notify( #"shields_up_deactivated" );
    self.ztron.var_604bef368f455697 = undefined;
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0xff1366eb, Offset: 0x3376
// Size: 0x1b
function function_27855e8ff4545f62()
{
    thread namespace_a1597a4eb2463645::activatesawblade( self, 120, 1 );
    thread namespace_73e2c42fdcce1e90::activatebarrel( self, 300, 1 );
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0xf16867a, Offset: 0x3399
// Size: 0x45
function function_3f9aed588096a133()
{
    self endon( #"death_or_disconnect" );
    thread function_349efb1be500f4df( self.ztron.var_3c6c0516b9bba99e );
    self.ztron.var_604bef368f455697 = 1;
    thread function_27855e8ff4545f62();
}

// Namespace ztron_gobblegums
// Params 1
// Checksum 0x609aff07, Offset: 0x33e6
// Size: 0x3d
function function_97b4a15da7029c17( time )
{
    self endon( #"death_or_disconnect" );
    self notify( #"kill_shield" );
    waitframe();
    thread namespace_a1597a4eb2463645::activatesawblade( self, time, 1 );
    thread namespace_73e2c42fdcce1e90::activatebarrel( self, time, 1 );
}

// Namespace ztron_gobblegums
// Params 2
// Checksum 0xac8b9ec7, Offset: 0x342b
// Size: 0x82
function function_c8f519520b7a6dde( rate, duration )
{
    self notify( #"hash_fc423bca2a9e5ee3" );
    self endon( #"hash_fc423bca2a9e5ee3" );
    level.ztron.var_841c9de1c43b2971 = 0;
    level.ztron.var_293c4b94e80c822a = rate;
    level utility::waittill_any_timeout( duration, "ztron_game_is_over", "ztron_game_reset" );
    level.ztron.var_293c4b94e80c822a = 1;
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0x8e137f80, Offset: 0x34b5
// Size: 0x12
function function_1c26bb4121e5b21f()
{
    level thread function_c8f519520b7a6dde( 0.25, 300 );
}

// Namespace ztron_gobblegums
// Params 1
// Checksum 0x4db219ce, Offset: 0x34cf
// Size: 0x1b
function function_1e57b9ad28f538ab( time )
{
    level thread function_c8f519520b7a6dde( 0.25, time );
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0x5952f6ad, Offset: 0x34f2
// Size: 0xb7
function function_d4179ca330479027()
{
    self endon( #"death_or_disconnect" );
    
    foreach ( player in level.players )
    {
        player ztron_weapon::function_951f0c703dffc47();
        player ztron_weapon::function_601fc4d0362f327b();
        self.ztron.var_f41b955260ed467e = self.ztron.var_dcf9ab22b803b383;
    }
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0x40f66de7, Offset: 0x35b1
// Size: 0x3f
function function_175ceacda031441c()
{
    level.ztron.var_1aafcf52beca1b11 = ztron_item::function_44d7d2feb29ee403( "ztron_monkey_bomb" );
    level.ztron.var_edc387a66e6f8d8c = gettime() + 300000;
}

// Namespace ztron_gobblegums
// Params 1
// Checksum 0x83539a91, Offset: 0x35f8
// Size: 0x4a
function function_dee05e9bf942ff28( time )
{
    level.ztron.var_1aafcf52beca1b11 = ztron_item::function_44d7d2feb29ee403( "ztron_monkey_bomb" );
    level.ztron.var_edc387a66e6f8d8c = gettime() + time * 1000;
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0x8bc6e691, Offset: 0x364a
// Size: 0x6e
function function_97cee97fce530740()
{
    self endon( #"death_or_disconnect" );
    self.ztron.var_bfa83a4b1e005de8 = gettime() + 90000;
    self.ztron.var_f235f713dade67e7 = 0;
    self.ztron.var_2d5d4cafb7f0ffb9 = 2000;
    self.ztron.var_93a0de915a326de5 = 3;
}

// Namespace ztron_gobblegums
// Params 1
// Checksum 0xdcf96dd4, Offset: 0x36c0
// Size: 0x79
function function_2ccd9cf175cec9ec( time )
{
    self endon( #"death_or_disconnect" );
    self.ztron.var_bfa83a4b1e005de8 = gettime() + time * 1000;
    self.ztron.var_f235f713dade67e7 = 0;
    self.ztron.var_2d5d4cafb7f0ffb9 = 2000;
    self.ztron.var_93a0de915a326de5 = 3;
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0xd1be371, Offset: 0x3741
// Size: 0x24
function function_a707775e89a0aa0e()
{
    self endon( #"death_or_disconnect" );
    self.ztron.var_930cb6796e836ff7 = 2;
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0x34c60322, Offset: 0x376d
// Size: 0x1a
function function_8226a1462b7ef7d3()
{
    self endon( #"death_or_disconnect" );
    thread function_1adf9a171050be46( 1800000 );
}

// Namespace ztron_gobblegums
// Params 1
// Checksum 0x97cf958, Offset: 0x378f
// Size: 0x25
function function_4736ea87a079b207( timeseconds )
{
    self endon( #"death_or_disconnect" );
    thread function_1adf9a171050be46( timeseconds * 1000 );
}

// Namespace ztron_gobblegums
// Params 1
// Checksum 0xbee995eb, Offset: 0x37bc
// Size: 0x7b
function function_1adf9a171050be46( durationms )
{
    self notify( #"hash_7b8908035097d33b" );
    self endon( #"hash_7b8908035097d33b" );
    level endon( #"ztron_game_is_over", #"ztron_game_reset" );
    self endon( #"disconnect" );
    timeout = gettime() + durationms;
    thread function_6aa72ee5c500ada8();
    
    while ( timeout > gettime() )
    {
        wait 5;
    }
    
    self notify( #"hash_c22b976b94d0d226" );
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0x46305b65, Offset: 0x383f
// Size: 0x74
function function_6aa72ee5c500ada8()
{
    self notify( #"hash_b48f693e1f042c4a" );
    self endon( #"hash_b48f693e1f042c4a" );
    level endon( #"ztron_game_is_over", #"ztron_game_reset" );
    self endon( #"disconnect", #"hash_c22b976b94d0d226" );
    
    while ( true )
    {
        level utility::waittill_any( "round_begin", "ztron_slayer_waves_spawning", "the_long_climb" );
        wait randomintrange( 20, 30 );
        thread namespace_a6a7fe92789f4ad9::function_35260497c4cb7b2c( 0 );
    }
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0x893e17e7, Offset: 0x38bb
// Size: 0x33
function function_b8730c82fd6bdac()
{
    result = ztron_main::function_4da200e9b8d58a3c() == 1 || ztron_main::function_4da200e9b8d58a3c() == 5;
    
    if ( !result )
    {
        function_95d5e1686d9b9d66();
    }
    
    return result;
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0xe80f5e88, Offset: 0x38f7
// Size: 0xe4
function function_e55831b8b0e6505f()
{
    player = self;
    hellhounddef = ztron_enemy::function_96eea0d09d5640d1( "hellhound" );
    
    if ( !isdefined( hellhounddef ) )
    {
        return;
    }
    
    for ( i = 0; i < 3 ; i++ )
    {
        spawnpos = ztron_arena::function_8c2aa5e7037af31c().origin;
        playfx( utility::getfx( "lightning_b" ), spawnpos );
        wait 0.5;
        playfx( utility::getfx( "lightning_strike" ), spawnpos );
        var_62f538f25aff1d94 = ztron_enemy::function_acee91c445fafd29( hellhounddef, spawnpos, undefined, undefined, 1, 1 );
        
        if ( isdefined( var_62f538f25aff1d94 ) )
        {
            var_62f538f25aff1d94 thread function_b68463b5453ce745( player );
            var_62f538f25aff1d94.maxhealth += 900;
            var_62f538f25aff1d94.health = var_62f538f25aff1d94.maxhealth;
        }
    }
}

// Namespace ztron_gobblegums
// Params 1, eflags: 0x4
// Checksum 0x1e91daa8, Offset: 0x39e3
// Size: 0xc8
function private function_b68463b5453ce745( player )
{
    self endon( #"death" );
    self.teamshifted = 1;
    self.oldteam = self.team;
    self.team = player.team;
    self clearenemy();
    self.favoriteenemy = undefined;
    ztron_enemy_ai::function_29bbc6846013b71b();
    
    if ( isdefined( self.favoriteenemy ) )
    {
        self getenemyinfo( self.favoriteenemy );
    }
    
    level utility::waittill_any( "slayer_round_finished", "round_over", "ztron_exit_taken", "ztron_teleporter_taken" );
    self.teamshifted = undefined;
    self.team = self.oldteam;
    
    if ( isalive( self ) )
    {
        thread ztron_util::function_ea0a0be5c5468c48( 0.1 );
    }
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0x49c9d75f, Offset: 0x3ab3
// Size: 0x14
function function_8fcfa0056979d7ca()
{
    level thread namespace_88202cd1fcbe89e9::function_48af9b28a56a2c8c( self.origin, self );
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0xc08d25fb, Offset: 0x3acf
// Size: 0x73
function function_247d54c84f964333()
{
    self notify( #"hash_c504663472606069" );
    self endon( #"hash_c504663472606069" );
    self endon( #"death_or_disconnect" );
    self.ztron.var_1bcec1b9cd2716d8 = 1;
    level waittill( #"round_over" );
    level utility::waittill_any( "ztron_exit_taken", "ztron_teleporter_taken", "ztron_slayerportal_taken" );
    self.ztron.var_1bcec1b9cd2716d8 = undefined;
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0xe4be6127, Offset: 0x3b4a
// Size: 0x9
function function_19b7e6d882ca32cd()
{
    thread function_247d54c84f964333();
}

// Namespace ztron_gobblegums
// Params 1
// Checksum 0x8380d565, Offset: 0x3b5b
// Size: 0x7f
function function_41379860dbf79104( time = 120000 )
{
    self notify( #"hash_83bd7fce8c2be8a8" );
    self endon( #"hash_83bd7fce8c2be8a8" );
    level endon( #"ztron_game_is_over", #"ztron_game_reset" );
    self endon( #"death_or_disconnect" );
    var_e5ae6908b4eaabe5 = gettime() + time;
    
    while ( gettime() < var_e5ae6908b4eaabe5 )
    {
        namespace_a6a7fe92789f4ad9::function_35260497c4cb7b2c( 0 );
        wait 9.8;
    }
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0x6f5000ac, Offset: 0x3be2
// Size: 0x28, Type: bool
function function_e7aeb767fe63f5ed()
{
    if ( gettime() < level.ztron.var_38ef38fae633e8 )
    {
        function_95d5e1686d9b9d66();
        return false;
    }
    
    return true;
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0x9f221c36, Offset: 0x3c13
// Size: 0x27
function function_ce56b39fd63faa4a()
{
    thread function_41379860dbf79104();
    level.ztron.var_38ef38fae633e8 = gettime() + 900000;
}

// Namespace ztron_gobblegums
// Params 1
// Checksum 0x5aea21cc, Offset: 0x3c42
// Size: 0x40
function function_5606c521059314e6( time )
{
    thread function_41379860dbf79104( time * 1000 );
    level.ztron.var_38ef38fae633e8 = gettime() + 900000 - 120000 - time;
}

// Namespace ztron_gobblegums
// Params 2
// Checksum 0xf5116501, Offset: 0x3c8a
// Size: 0x82
function function_3f20f5f5b4b9f2c( rate, duration )
{
    self notify( #"hash_965064dcb83c098f" );
    self endon( #"hash_965064dcb83c098f" );
    level.ztron.var_ae907b7861f41f63 = 0;
    level.ztron.var_992f29dbad27ad98 = rate;
    level utility::waittill_any_timeout( duration, "ztron_game_is_over", "ztron_game_reset" );
    level.ztron.var_992f29dbad27ad98 = 1;
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0x1731cd89, Offset: 0x3d14
// Size: 0x26
function function_daa7165333710baf()
{
    result = ztron_main::function_4da200e9b8d58a3c() == 1;
    
    if ( !result )
    {
        function_95d5e1686d9b9d66();
    }
    
    return result;
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0x1864f6d2, Offset: 0x3d43
// Size: 0x12
function function_175665e24d098ec8()
{
    level thread function_3f20f5f5b4b9f2c( 0.2, 300 );
}

// Namespace ztron_gobblegums
// Params 1
// Checksum 0x4e06bc90, Offset: 0x3d5d
// Size: 0x1b
function function_1c0a7143cd436fb4( time )
{
    level thread function_3f20f5f5b4b9f2c( 0.2, time );
}

// Namespace ztron_gobblegums
// Params 0
// Checksum 0xc41f6fa6, Offset: 0x3d80
// Size: 0xe
function function_a2b1f2262256dba8()
{
    thread wonderbar_internal( 1800000 );
}

// Namespace ztron_gobblegums
// Params 1
// Checksum 0x2b508895, Offset: 0x3d96
// Size: 0x19
function function_b6d710a2c3c4a6c4( time )
{
    thread wonderbar_internal( time * 1000 );
}

// Namespace ztron_gobblegums
// Params 1
// Checksum 0xd33d6bb7, Offset: 0x3db7
// Size: 0xa5
function wonderbar_internal( durationms )
{
    self notify( #"hash_53a0d1de81d4acf5" );
    self endon( #"hash_53a0d1de81d4acf5" );
    self endon( #"disconnect" );
    timeout = gettime() + durationms;
    
    while ( true )
    {
        self waittill( #"round_begin" );
        
        if ( gettime() > timeout )
        {
            return;
        }
        
        roll = randomint( 100 );
        
        if ( roll < 50 )
        {
            thread namespace_3d206415c2287a2b::addchicken( 0 );
            continue;
        }
        
        success = namespace_9c38de505200a0ad::function_9cdbe50399a4b30a( self );
        
        if ( !success )
        {
            thread namespace_3d206415c2287a2b::addchicken( 0 );
        }
    }
}

// Namespace ztron_gobblegums
// Params 1
// Checksum 0x581b7892, Offset: 0x3e64
// Size: 0xfa
function rainfire( targetorg )
{
    self endon( #"death" );
    playfxontag( utility::getfx( "ztron_brimestone_body" ), self, "tag_origin" );
    ztron_sound::ztron_playsound( "brimstone_incoming" );
    self moveto( targetorg, randomfloatrange( 0.8, 1.5 ) );
    self waittill( #"movedone" );
    stopfxontag( utility::getfx( "ztron_brimestone_body" ), self, "tag_origin" );
    playfx( utility::getfx( "ztron_brimestone_explo" ), self.origin );
    waitframe();
    playfx( utility::getfx( "ztron_brimestone_explo2" ), self.origin );
    physicsexplosionsphere( self.origin, 256, 256, 100 );
    ztron_sound::ztron_playsound( "brimstone_explo" );
    ztron_util::radialdamage( self.origin, 0, 256, 0, 1500 * level.ztron.roundnumber );
    self delete();
}

// Namespace ztron_gobblegums
// Params 2
// Checksum 0xc85bd145, Offset: 0x3f66
// Size: 0x291
function activateholybrimestone( player, time = 300 )
{
    self notify( #"hash_ed8707e9a8dec9d6" );
    self endon( #"hash_ed8707e9a8dec9d6" );
    level endon( #"ztron_game_is_over", #"ztron_game_reset" );
    player endon( #"disconnect" );
    spot = spawnstruct();
    keepgoing = 1;
    timeleft = gettime() + time * 1000;
    player.ztron.var_268eab318221acba = timeleft;
    
    do
    {
        volly = randomintrange( 10, 18 );
        
        while ( volly > 0 )
        {
            wait randomfloatrange( 0.2, 0.7 );
            volly--;
            
            if ( ztron_main::function_4da200e9b8d58a3c() == 1 )
            {
                if ( level.ztron.zombies.size <= 0 )
                {
                    continue;
                }
                
                var_4d64a5b861c8840 = arraycombineunique( level.ztron.active_arena.safespots, level.ztron.zombies );
            }
            else if ( ztron_main::function_4da200e9b8d58a3c() == 5 )
            {
                if ( !level utility::flag( "ztron_slayer_waves_spawning" ) )
                {
                    continue;
                }
                
                var_4d64a5b861c8840 = arraycombineunique( level.ztron.slayer.active_arena.safespots, level.ztron.zombies );
            }
            else if ( ztron_main::function_4da200e9b8d58a3c() == 3 )
            {
                if ( level.ztron.var_8a9067aa4cd65369.hazardzone )
                {
                    var_4d64a5b861c8840 = [];
                    spot.origin = ztron_util::function_78a5b128a3e32460( player.origin, 800, 128 );
                    var_4d64a5b861c8840[ var_4d64a5b861c8840.size ] = spot;
                }
                else
                {
                    continue;
                }
            }
            else
            {
                continue;
            }
            
            if ( var_4d64a5b861c8840.size > 0 )
            {
                var_4d64a5b861c8840 = var_4d64a5b861c8840[ randomint( var_4d64a5b861c8840.size ) ];
                sourceloc = var_4d64a5b861c8840.origin + ( randomintrange( -1024, 1024 ), randomintrange( -1024, 1024 ), 2000 );
                brimestoneobj = utility::spawn_model( "sat_zm_ztron_props_fireball", sourceloc );
                brimestoneobj thread rainfire( var_4d64a5b861c8840.origin + ( randomintrange( -128, 128 ), randomintrange( -128, 128 ), 0 ) );
            }
        }
        
        wait randomfloatrange( 6, 20 );
    }
    while ( gettime() < timeleft );
}

// Namespace ztron_gobblegums
// Params 1, eflags: 0x4
// Checksum 0xe417ee12, Offset: 0x41ff
// Size: 0x16b
function private function_b6be751f6fa6f6c8( value )
{
    self endon( #"disconnect" );
    
    if ( self.ztron.blockgg )
    {
        return;
    }
    
    if ( self.var_f1dccd054c74a27e[ value ] || bgb::is_enabled( self.var_b02f6e7abbbc8a84[ value ] ) )
    {
        self playlocalsound( #"hash_d8d9c4eb514390a7" );
        return;
    }
    
    var_ae930e09dfcb0371 = 0;
    
    switch ( level.bgb[ self.var_b02f6e7abbbc8a84[ value ] ].rarity )
    {
        case #"hash_56dca9558042f91d":
            var_ae930e09dfcb0371 = 500;
            break;
        case #"hash_9f79c9fc1aa660aa":
            var_ae930e09dfcb0371 = 2500;
            break;
        case #"hash_c81e81c97be2c6a8":
            var_ae930e09dfcb0371 = 1250;
            break;
        case #"hash_ca3e413b1500d035":
            var_ae930e09dfcb0371 = 5000;
            break;
        case #"hash_b8ce55e0f7e8f868":
            var_ae930e09dfcb0371 = 100;
            break;
    }
    
    var_29befae4c74639d1 = "cer_zm_vm_ges_bgb_dust_" + self.var_b02f6e7abbbc8a84[ value ];
    thread utility::function_72b6372d2d8c997( var_29befae4c74639d1, 1 );
    utility::waittill_any_timeout( 1, "death", "last_stand_enter", "gesture_stopped", "disconnect", "weapon_gesture_failed" );
    bgb::function_4818e19472b65502( self.var_b02f6e7abbbc8a84[ value ], value );
    thread bgb::take( value );
    ztron_player_utility::function_8e1155bcebb3b7b3( var_ae930e09dfcb0371 );
}

// Namespace ztron_gobblegums
// Params 1
// Checksum 0x3faa4e8e, Offset: 0x4372
// Size: 0x1dc
function function_ee96811ad1811850( itemref )
{
    switch ( itemref )
    {
        case #"hash_ef1581faa0137403":
            thread function_d4179ca330479027();
            break;
        case #"hash_197fc4229e98434d":
            thread function_5e308b80ad895835();
            break;
        case #"hash_ad248de9f89501ce":
            thread function_d4aa357641dca6b6();
            break;
        case #"hash_1f7e9fe1acef83f1":
            thread function_606cfbf7b7942531();
            break;
        case #"hash_69a4d6a4d2591f55":
            thread function_de0141e169f950eb();
            break;
        case #"hash_58d0341d48e0c6c7":
            thread function_171d930e0876fc0();
            break;
        case #"hash_4b08a287366b998f":
            thread function_19b7e6d882ca32cd();
            break;
        case #"hash_635a30f40fb3b931":
            thread function_8e13a1358a19390b();
            break;
        case #"hash_d89d264bf47f8e74":
            thread function_85e5a0a2a2cd5ca();
            break;
        case #"hash_48c4895136fa9c2f":
            thread function_27855e8ff4545f62();
            break;
        case #"hash_b847f9c3ec5bcbf8":
            thread function_fbd5c7f7477f1a50();
            break;
        case #"hash_8f6a31e0460d70a0":
            thread function_36bfb24cb2b81670();
            break;
        case #"hash_ef4899a75fcfea75":
            thread function_1c26bb4121e5b21f();
            break;
        case #"hash_50c2c3d86a1499e5":
            thread function_b899bb111c29afb9();
            break;
        case #"hash_d7c7c06b0ee24a18":
            thread function_c7b4d531fc5c2ae2();
            break;
        case #"hash_8b8dcd7489b9fc8b":
            thread function_fa7d85842265d694( istrue( level.ztron.metaenabled ) );
            break;
        case #"hash_f04ecfa012b467c0":
            thread function_ce56b39fd63faa4a();
            break;
        default:
            msg = "Unhandled gobblegum effect: " + itemref;
            ztron_debug::debugmsg( "grantGobbleGumEffectByItemRef: " + msg );
            assertmsg( msg );
            break;
    }
}

