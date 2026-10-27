// scripts\mp\common\utility\game_utility.gsc  (hash_49e4a4c208f44b76.gscc) (size: 37510 Bytes / 0x9286 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x25b1c77e (632407934)
// size ...... 37510 (0x9286)
// includes .. 10  (offset: 0x88d2)
// strings ... 143 (offset: 0x8922)
// dev strs .. 39  (offset: 0x907a)
// exports ... 170 (offset: 0x560e)
// cseg ...... 0x6b2 + 0x4f5c (0x560e)
// imports ... 173 (offset: 0x709e)
// animtree1 . 0   (offset: 0x9286)
// animtree2 . 0   (offset: 0x9286)
#using scripts\common\ae_utility;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\events;
#using scripts\mp\operator;

#namespace game_utility;

// Namespace game_utility
// Params 0, eflags: 0x5
// Checksum 0x8f9c12dc, Offset: 0x6d0
// Size: 0x197
function private autoexec init()
{
    level.var_12c9f0afb279b0c4 = getdvarfloat( @"hash_d11b505a097056cf", 0 );
    level.var_12c9f1afb279b2f7 = getdvarfloat( @"hash_d11b4f5a0970549c", 0 );
    level.var_9f41e4edef0a25e2 = getdvarfloat( @"hash_233f233fe59ce656", 0 );
    level.var_75eb11c5521aec04 = getdvarfloat( @"hash_b678e6b5a972d764", 0 );
    level.var_75eb12c5521aee37 = getdvarfloat( @"hash_b678e7b5a972d997", 0 );
    level.var_464c2753225e9622 = getdvarfloat( @"hash_f6606a515c264687", 0 );
    level.var_48d978555dd5643e = getdvarfloat( @"hash_ccbcc43256294106", 0 );
    level.var_48d979555dd56671 = getdvarfloat( @"hash_ccbcc53256294339", 0 );
    level.var_7ca8c63b5b1e7b64 = getdvarfloat( @"hash_ff6c6fb49f512849", 0 );
    level.var_b3047f71baa5ddfc = getdvarfloat( @"hash_23afb2011b6bbe3b", 0 );
    level.var_9c764a991b12ce33 = getdvarfloat( @"hash_8baf136f90ca01c5", 0 );
    level.var_6e773116db9931c = getdvarfloat( @"hash_edda3d403bf1cea0", 0 );
    level.var_edd4a79d616d3d53 = getdvarfloat( @"hash_85f40fedb4275aa4", 0 );
    level.var_6f6bbb94bbeb9d6 = getdvarfloat( @"hash_7468b2cc0f86cc02", 0 );
    level.var_2c52fb1b3a3d7929 = getdvarfloat( @"hash_170c7e08f2a119a2", 0 );
}

// Namespace game_utility
// Params 0
// Checksum 0x9b7c3b46, Offset: 0x86f
// Size: 0x2d
function getmapname()
{
    if ( !isdefined( level.mapname ) )
    {
        level.mapname = getdvar( @"g_mapname" );
    }
    
    return level.mapname;
}

// Namespace game_utility
// Params 0
// Checksum 0xf4aab5bb, Offset: 0x8a5
// Size: 0x73
function getgametype()
{
    var_7237854e3be197ca = level.gametype;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    if ( isbrgamemode() )
    {
        level.gametype = level.gametypebundle.brsubgametype ?? "br";
    }
    else
    {
        level.gametype = level.gametypebundle.var_53486d8d1bcaeac7;
    }
    
    return level.gametype;
}

// Namespace game_utility
// Params 0
// Checksum 0xd5aea633, Offset: 0x921
// Size: 0x85
function function_3fcf31cf168b10ea()
{
    if ( !isdefined( level.var_3fd543e4c07ef98e ) )
    {
        if ( isbrgamemode() )
        {
            subgametype = level.gametypebundle.brsubgametype;
            
            if ( isdefined( subgametype ) )
            {
                level.var_3fd543e4c07ef98e = subgametype;
            }
            else
            {
                level.var_3fd543e4c07ef98e = "br";
            }
        }
        else
        {
            gametype = function_67138bc0fb9151ff();
            
            if ( isdefined( gametype ) )
            {
                level.var_3fd543e4c07ef98e = gametype;
            }
        }
    }
    
    return level.var_3fd543e4c07ef98e;
}

// Namespace game_utility
// Params 0
// Checksum 0x79d1ff1a, Offset: 0x9af
// Size: 0x6a
function function_e9de4eeab29754c3()
{
    if ( !isdefined( level.telemetrygametype ) )
    {
        level.telemetrygametype = getgametypenamekey();
    }
    
    if ( !isdefined( level.var_7ca18ab899076acf ) )
    {
        level.var_7ca18ab899076acf = level.gametypebundle.isltm ? "ltm-" + level.telemetrygametype : level.telemetrygametype;
    }
    
    return level.telemetrygametype;
}

// Namespace game_utility
// Params 0
// Checksum 0x6b21703f, Offset: 0xa22
// Size: 0x6a
function function_43ddc64d3640063()
{
    if ( !isdefined( level.telemetrygametype ) )
    {
        level.telemetrygametype = getgametypenamekey();
    }
    
    if ( !isdefined( level.var_7ca18ab899076acf ) )
    {
        level.var_7ca18ab899076acf = level.gametypebundle.isltm ? "ltm-" + level.telemetrygametype : level.telemetrygametype;
    }
    
    return level.var_7ca18ab899076acf;
}

// Namespace game_utility
// Params 2
// Checksum 0x50fb8c96, Offset: 0xa95
// Size: 0x6b
function function_17b847c55b0c74af( expectedhash, defaulthash )
{
    toreturn = defaulthash ?? #"unknown";
    
    if ( isxhash( expectedhash ) )
    {
        toreturn = expectedhash;
    }
    else
    {
        if ( isstring( expectedhash ) )
        {
            toreturn = getxhash( expectedhash );
        }
        
        assert( isxhash( toreturn ), "<dev string:x24>" + expectedhash );
    }
    
    return toreturn;
}

// Namespace game_utility
// Params 0
// Checksum 0x78a12a92, Offset: 0xb09
// Size: 0xc3
function getbasegametype()
{
    var_7237854e3be197ca = level.var_9e4587c28c553fa9;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    gametype = getgametype();
    tokens = strtok( gametype, "_" );
    
    if ( tokens[ 0 ] == "hc" || tokens[ 0 ] == "cdl" || tokens[ 0 ] == "lp" )
    {
        gametype = tokens[ tokens.size - 1 ];
    }
    
    if ( tokens[ 1 ] == "snipers" || tokens[ 1 ] == "horde" || tokens[ 1 ] == "jugg" )
    {
        gametype = tokens[ 0 ];
    }
    
    if ( !isdefined( level.var_9e4587c28c553fa9 ) )
    {
        level.var_9e4587c28c553fa9 = gametype;
    }
    
    return level.var_9e4587c28c553fa9;
}

// Namespace game_utility
// Params 0
// Checksum 0x1a6df554, Offset: 0xbd5
// Size: 0x24, Type: bool
function isinfectedgametype()
{
    return level.gametype == "infect" || level.gametype == "infect_holiday";
}

// Namespace game_utility
// Params 0
// Checksum 0x25939e3c, Offset: 0xc02
// Size: 0x11, Type: bool
function function_36ce69a7be195555()
{
    return level.gametype == "bm";
}

// Namespace game_utility
// Params 0
// Checksum 0x6d4a0a21, Offset: 0xc1c
// Size: 0x25, Type: bool
function function_d60ba5ade32ddb31()
{
    if ( getdvarint( @"scr_bm_pvp_enabled", 0 ) )
    {
        return true;
    }
    
    return level.gametype == "bm_pvp";
}

// Namespace game_utility
// Params 0
// Checksum 0xf1295e6f, Offset: 0xc4a
// Size: 0x12, Type: bool
function function_affd501b220b03c5()
{
    return function_36ce69a7be195555() || function_d60ba5ade32ddb31();
}

// Namespace game_utility
// Params 0
// Checksum 0xc50119cf, Offset: 0xc65
// Size: 0x11, Type: bool
function function_55d5a3f03692e118()
{
    return level.gametype == "koth_horde";
}

// Namespace game_utility
// Params 0
// Checksum 0x3b88af66, Offset: 0xc7f
// Size: 0x11, Type: bool
function function_245a95d184375f25()
{
    return level.gametype == "wm";
}

// Namespace game_utility
// Params 0
// Checksum 0x5c6dc62b, Offset: 0xc99
// Size: 0x13, Type: bool
function function_bfa35a7c6234a9ad()
{
    return function_245a95d184375f25() && game[ "roundsPlayed" ];
}

// Namespace game_utility
// Params 0
// Checksum 0x23305b0d, Offset: 0xcb5
// Size: 0x37, Type: bool
function function_8d8af1d3e14d5c3b()
{
    return level.gametype == "arm" || level.gametype == "gwtdm" || level.gametype == "conflict";
}

// Namespace game_utility
// Params 0
// Checksum 0xcca26a05, Offset: 0xcf5
// Size: 0x13, Type: bool
function function_7cceeebf2891ed68()
{
    return getsubstr( getgametypenamekey(), 0, 4 ) == "cdl_";
}

// Namespace game_utility
// Params 0
// Checksum 0xd7675496, Offset: 0xd11
// Size: 0x13, Type: bool
function function_8ab57c66926af6b9()
{
    return getsubstr( getgametypenamekey(), 0, 3 ) == "lp_";
}

// Namespace game_utility
// Params 0
// Checksum 0xaee7f94, Offset: 0xd2d
// Size: 0x12, Type: bool
function function_a81fd80bdb4f6ab1()
{
    return function_7cceeebf2891ed68() || function_8ab57c66926af6b9();
}

// Namespace game_utility
// Params 0
// Checksum 0x61adc189, Offset: 0xd48
// Size: 0x11, Type: bool
function function_4904a96c7ddaa5e4()
{
    return level.gametype == "zxp";
}

// Namespace game_utility
// Params 0
// Checksum 0x8921742e, Offset: 0xd62
// Size: 0x12, Type: bool
function function_c446c60d2979dbfe()
{
    return getdvarint( @"hash_2412efa8e306b1c4", 0 ) != 0;
}

// Namespace game_utility
// Params 0
// Checksum 0x6e4b4569, Offset: 0xd7d
// Size: 0x29, Type: bool
function function_ece5a05594bcd651()
{
    var_56043d66c29080bc = getgametype() == "ob";
    return var_56043d66c29080bc && level.var_d661a9efc2ea9245;
}

// Namespace game_utility
// Params 0
// Checksum 0xb0bdfeec, Offset: 0xdaf
// Size: 0xd
function registerlargemap()
{
    level.largemap = 1;
}

// Namespace game_utility
// Params 0
// Checksum 0xe6edc34b, Offset: 0xdc4
// Size: 0xc, Type: bool
function islargemap()
{
    return istrue( level.largemap );
}

// Namespace game_utility
// Params 0
// Checksum 0x6a56e56b, Offset: 0xdd9
// Size: 0x10, Type: bool
function islargebrmap()
{
    return isbrgamemode() && islargemap();
}

// Namespace game_utility
// Params 0
// Checksum 0xadc4716c, Offset: 0xdf2
// Size: 0x14
function registerdonetskmap()
{
    registerlargemap();
    level.isdonetskmap = 1;
}

// Namespace game_utility
// Params 0
// Checksum 0x32b2c578, Offset: 0xe0e
// Size: 0xc, Type: bool
function isdonetskmap()
{
    return istrue( level.isdonetskmap );
}

// Namespace game_utility
// Params 0
// Checksum 0x3771778a, Offset: 0xe23
// Size: 0xd
function registerdonetsksubmap()
{
    level.donetsksubmap = 1;
}

// Namespace game_utility
// Params 0
// Checksum 0xb3d8091c, Offset: 0xe38
// Size: 0xc, Type: bool
function isdonetsksubmap()
{
    return istrue( level.donetsksubmap );
}

// Namespace game_utility
// Params 0
// Checksum 0x41d7c6cd, Offset: 0xe4d
// Size: 0x14
function function_efda72482ec75bb0()
{
    registerlargemap();
    level.var_87c1e942653b7c63 = 1;
}

// Namespace game_utility
// Params 0
// Checksum 0xb252ff34, Offset: 0xe69
// Size: 0xc, Type: bool
function function_87c1e942653b7c63()
{
    return istrue( level.var_87c1e942653b7c63 );
}

// Namespace game_utility
// Params 0
// Checksum 0xf0707495, Offset: 0xe7e
// Size: 0xd
function function_f28f2feeec35ecba()
{
    level.sabasubmap = 1;
}

// Namespace game_utility
// Params 0
// Checksum 0x7f7a0c3c, Offset: 0xe93
// Size: 0xc, Type: bool
function function_1ab42ace647394d7()
{
    return istrue( level.sabasubmap );
}

// Namespace game_utility
// Params 0
// Checksum 0xc2b555e4, Offset: 0xea8
// Size: 0x14
function function_a51509344bce43ad()
{
    registerlargemap();
    level.var_ef189b2abdd2c870 = 1;
}

// Namespace game_utility
// Params 0
// Checksum 0x8499a4fe, Offset: 0xec4
// Size: 0xc, Type: bool
function function_ef189b2abdd2c870()
{
    return istrue( level.var_ef189b2abdd2c870 );
}

// Namespace game_utility
// Params 0
// Checksum 0xca19687a, Offset: 0xed9
// Size: 0xd
function function_e6a415fabca0704d()
{
    level.crucesubmap = 1;
}

// Namespace game_utility
// Params 0
// Checksum 0x429e3895, Offset: 0xeee
// Size: 0xc, Type: bool
function function_35644a4bd796417a()
{
    return istrue( level.crucesubmap );
}

// Namespace game_utility
// Params 0
// Checksum 0xadc4716c, Offset: 0xf03
// Size: 0x14
function function_a06dc8a752105932()
{
    registerlargemap();
    level.var_238d71fc76232bef = 1;
}

// Namespace game_utility
// Params 0
// Checksum 0x32b2c578, Offset: 0xf1f
// Size: 0xc, Type: bool
function function_238d71fc76232bef()
{
    return istrue( level.var_238d71fc76232bef );
}

// Namespace game_utility
// Params 0
// Checksum 0x4d94f6fd, Offset: 0xf34
// Size: 0xd
function function_be3150667ede9958()
{
    level.var_35a854a7e421fc73 = 1;
}

// Namespace game_utility
// Params 0
// Checksum 0xc93d886b, Offset: 0xf49
// Size: 0xc, Type: bool
function function_35a854a7e421fc73()
{
    return istrue( level.var_35a854a7e421fc73 );
}

// Namespace game_utility
// Params 0
// Checksum 0xc2b555e4, Offset: 0xf5e
// Size: 0x14
function function_8a12fc3b9f2b42f3()
{
    registerlargemap();
    level.var_36de887ad1f5532e = 1;
}

// Namespace game_utility
// Params 0
// Checksum 0x8499a4fe, Offset: 0xf7a
// Size: 0xc, Type: bool
function function_36de887ad1f5532e()
{
    return istrue( level.var_36de887ad1f5532e );
}

// Namespace game_utility
// Params 0
// Checksum 0x74581ca6, Offset: 0xf8f
// Size: 0xd
function function_bf26e6313436d447()
{
    level.var_b9bb3382c71fbe54 = 1;
}

// Namespace game_utility
// Params 0
// Checksum 0xfcdf4c49, Offset: 0xfa4
// Size: 0xc, Type: bool
function function_b9bb3382c71fbe54()
{
    return istrue( level.var_b9bb3382c71fbe54 );
}

// Namespace game_utility
// Params 0
// Checksum 0x8728aa2d, Offset: 0xfb9
// Size: 0x14
function function_8bfce22ffc2f2676()
{
    registerlargemap();
    level.var_d2460960855e0301 = 1;
}

// Namespace game_utility
// Params 0
// Checksum 0xf8b2413d, Offset: 0xfd5
// Size: 0xc, Type: bool
function function_d2460960855e0301()
{
    return istrue( level.var_d2460960855e0301 );
}

// Namespace game_utility
// Params 0
// Checksum 0x34053ff1, Offset: 0xfea
// Size: 0xd
function function_db7f11d666accdda()
{
    level.var_c0c7a9d2f13dd549 = 1;
}

// Namespace game_utility
// Params 0
// Checksum 0x92878239, Offset: 0xfff
// Size: 0xc, Type: bool
function function_bb0791b80031ccdd()
{
    return istrue( level.var_c0c7a9d2f13dd549 );
}

// Namespace game_utility
// Params 0
// Checksum 0xefd5ab14, Offset: 0x1014
// Size: 0x11, Type: bool
function function_71778c032c09f03f()
{
    return level.mapname == "mp_bio_lab";
}

// Namespace game_utility
// Params 0
// Checksum 0xcb941111, Offset: 0x102e
// Size: 0x11, Type: bool
function function_67dc374c04e4d121()
{
    return level.mapname == "mp_biobunker";
}

// Namespace game_utility
// Params 0
// Checksum 0x27864959, Offset: 0x1048
// Size: 0x24, Type: bool
function function_ee6c5a6c2de518e1()
{
    return level.mapname == "mp_bio_lab" || level.mapname == "mp_biobunker";
}

// Namespace game_utility
// Params 0
// Checksum 0x9588db8a, Offset: 0x1075
// Size: 0x14
function function_45eeca70eae8ad8c()
{
    registerlargemap();
    level.var_2429ac8a30a088eb = 1;
}

// Namespace game_utility
// Params 0
// Checksum 0xe0bde467, Offset: 0x1091
// Size: 0xd
function registersubmap()
{
    level.issubmap = 1;
}

// Namespace game_utility
// Params 0
// Checksum 0x7bda4c94, Offset: 0x10a6
// Size: 0x3d, Type: bool
function issubmap()
{
    return level.issubmap || isdonetsksubmap() || function_1ab42ace647394d7() || function_35644a4bd796417a() || function_35a854a7e421fc73() || function_bb0791b80031ccdd();
}

// Namespace game_utility
// Params 0
// Checksum 0x171390df, Offset: 0x10ec
// Size: 0x24, Type: bool
function function_a65a0bbb95c5d54a()
{
    return level.mapname == "mp_saba_pm" || level.mapname == "mp_delta_pm";
}

// Namespace game_utility
// Params 0
// Checksum 0xcf6d70d9, Offset: 0x1119
// Size: 0x10
function function_3f43b9ae1e48e83f()
{
    return getdvarint( @"hash_430db1e3f28366e1", 0 );
}

// Namespace game_utility
// Params 0
// Checksum 0x1ed1478b, Offset: 0x1132
// Size: 0x11, Type: bool
function function_5a38ee99f49f73eb()
{
    return level.gametype == "push_zone";
}

// Namespace game_utility
// Params 1
// Checksum 0x7346f811, Offset: 0x114c
// Size: 0x36
function registernightmap( usenvgs = 1 )
{
    level.nightmap = 1;
    visionsetkillcamthirdpersonnight( "killcam_night" );
    
    if ( usenvgs )
    {
        function_6661717dd02ea9ce();
    }
}

// Namespace game_utility
// Params 0
// Checksum 0xe3b5e9fa, Offset: 0x118a
// Size: 0xd
function function_6661717dd02ea9ce()
{
    level.var_e54aa9fc8f17d734 = 1;
}

// Namespace game_utility
// Params 0
// Checksum 0x23d0e28, Offset: 0x119f
// Size: 0x2d
function registerarenamap()
{
    level.arenamap = 1;
    level.disablespawncamera = 1;
    level.skipfirstraise = 1;
    level.requiresminstartspawns = 0;
}

// Namespace game_utility
// Params 0
// Checksum 0x7b22386d, Offset: 0x11d4
// Size: 0x18
function registersmallmap()
{
    level.disablespawncamera = 1;
    level.skipfirstraise = 1;
}

// Namespace game_utility
// Params 0
// Checksum 0xe6edc34b, Offset: 0x11f4
// Size: 0xc, Type: bool
function isarenamap()
{
    return istrue( level.arenamap );
}

// Namespace game_utility
// Params 0
// Checksum 0xb0d66f12, Offset: 0x1209
// Size: 0xc, Type: bool
function function_c564dc42fbb871d5()
{
    return !level.var_f0f4fdb2281e1851;
}

// Namespace game_utility
// Params 0
// Checksum 0x309ca60e, Offset: 0x121e
// Size: 0xc, Type: bool
function function_cd3e55b03ffd725e()
{
    return !level.supersdisabled;
}

// Namespace game_utility
// Params 0
// Checksum 0xe377dd14, Offset: 0x1233
// Size: 0x39
function function_5519236e1327ae3c()
{
    if ( utility::issharedfuncdefined( #"game", #"hash_d29df7993be117ab" ) )
    {
        return [[ utility::getsharedfunc( #"game", #"hash_d29df7993be117ab" ) ]]();
    }
    
    return 0;
}

// Namespace game_utility
// Params 0
// Checksum 0x5937735f, Offset: 0x1275
// Size: 0x38, Type: bool
function function_6131f69cfe56ed90()
{
    return level.gamemodebundle.aegamemode == "ZM" || level.gamemodebundle.aegamemode == "OB";
}

// Namespace game_utility
// Params 0
// Checksum 0x2b78865b, Offset: 0x12b6
// Size: 0x1b, Type: bool
function function_83cacac0964585da()
{
    return level.gamemodebundle.aegamemode == "WC";
}

// Namespace game_utility
// Params 0
// Checksum 0xfcb26af1, Offset: 0x12da
// Size: 0x2e, Type: bool
function function_d68874417f3eea5c()
{
    return getgametype() == "zm_rb_r_mod" || getgametype() == "zm_rb_r_mod_survival" || getgametype() == "zm_rb_rh_mod";
}

// Namespace game_utility
// Params 0
// Checksum 0x13daf4b8, Offset: 0x1311
// Size: 0x2e, Type: bool
function function_21211f3255f8ea58()
{
    return getgametype() == "zm_rb_survival" || getgametype() == "zm_rb_r_mod_survival" || getgametype() == "zm_rb_cranked_team";
}

// Namespace game_utility
// Params 0
// Checksum 0x11e8498b, Offset: 0x1348
// Size: 0x2e, Type: bool
function function_194a17c8979659a5()
{
    return getgametype() == "zm_rb_r_mod" || getgametype() == "zm_rb_rh_mod" || getgametype() == "zm_rb";
}

// Namespace game_utility
// Params 1
// Checksum 0x193f7d0f, Offset: 0x137f
// Size: 0x42, Type: bool
function function_d3590d4c71dbeae8( player )
{
    if ( function_5519236e1327ae3c() )
    {
        gametypenumlives = game_utility_mp::getgametypenumlives();
        
        if ( player.pers[ "deaths" ] >= gametypenumlives )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace game_utility
// Params 0
// Checksum 0x51aaf61f, Offset: 0x13ca
// Size: 0xc, Type: bool
function function_a43ada404e8c591f()
{
    return istrue( level.var_a43ada404e8c591f );
}

// Namespace game_utility
// Params 0
// Checksum 0x17ee1fa9, Offset: 0x13df
// Size: 0x2e
function function_f24780eadd3fb772()
{
    if ( !isdefined( level.maxteamsize ) )
    {
        level.maxteamsize = getmatchrulesdata( "commonOption", "teamSize" );
    }
    
    return level.maxteamsize;
}

// Namespace game_utility
// Params 1
// Checksum 0x882caf4e, Offset: 0x1416
// Size: 0x133
function function_bf2984e0278cf917( criteriastruct )
{
    assert( isdefined( criteriastruct ), "<dev string:x48>" );
    mapname = getmapname();
    bestmatch = criteriastruct.defaultconfig;
    
    if ( ( criteriastruct.var_890c1e8e51c81252 ?? 0 ) == 0 )
    {
        return bestmatch;
    }
    
    foreach ( kvp in criteriastruct.mapoverrides ?? [] )
    {
        if ( isdefined( kvp.key.mapasset ) )
        {
            mapinfobundle = getmapinfobundle( kvp.key.mapasset );
            
            if ( mapinfobundle.mapname == mapname )
            {
                bestmatch = function_8786ad5f972ef5df( bestmatch, kvp.value );
                break;
            }
        }
    }
    
    return bestmatch;
}

// Namespace game_utility
// Params 0
// Checksum 0xdbcc912c, Offset: 0x1552
// Size: 0xf7
function getlocaleid()
{
    if ( !level.localeassigned )
    {
        localeid = getdvar( @"scr_localeid", "0" );
        
        if ( level.gametypebundle.var_baece7bc78d6fcdd )
        {
            if ( !isdefined( game[ "round_locales" ] ) )
            {
                poinames = strtok( localeid, " " );
                
                if ( level.gametypebundle.var_d34fcb233751455e )
                {
                    game[ "round_locales" ] = arrayrandomize( poinames );
                }
                else
                {
                    game[ "round_locales" ] = poinames;
                }
            }
            
            localeid = game[ "round_locales" ][ game[ "roundsPlayed" ] ?? 0 ];
        }
        
        println( "<dev string:x76>" + localeid );
        
        if ( localeid == "0" )
        {
            level.localeid = undefined;
        }
        else
        {
            level.localeid = "locale_" + localeid;
        }
        
        level.localeassigned = 1;
    }
    
    return level.localeid;
}

// Namespace game_utility
// Params 1
// Checksum 0x518d391a, Offset: 0x1652
// Size: 0x2d
function setlocaleid( value )
{
    setdvar( @"scr_localeid", value );
    level.localeassigned = 0;
    getlocaleid();
}

// Namespace game_utility
// Params 3
// Checksum 0x1e127c45, Offset: 0x1687
// Size: 0x1f4
function getlocaleent( entname, var_61db3ae80e737603, ignorelocale )
{
    possibleents = getentarray( entname, #targetname );
    var_f30c7c43aaa28638 = undefined;
    
    if ( isdefined( getlocaleid() ) && !ignorelocale )
    {
        foreach ( ent in possibleents )
        {
            if ( ent.script_noteworthy == level.localeid )
            {
                var_f30c7c43aaa28638 = ent;
                continue;
            }
            
            if ( level.mapname == "mp_port2_gw" && entname == "airstrikeheight" )
            {
                if ( ent.origin == ( 34880, -26944, 3072 ) )
                {
                    var_f30c7c43aaa28638 = ent;
                }
                
                continue;
            }
            
            ent delete();
        }
    }
    else
    {
        foreach ( ent in possibleents )
        {
            if ( !isdefined( var_f30c7c43aaa28638 ) )
            {
                var_f30c7c43aaa28638 = ent;
                continue;
            }
            
            ent delete();
        }
    }
    
    var_7237854e3be197ca = var_f30c7c43aaa28638;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    /#
        if ( isdefined( level.localeid ) )
        {
            println( "<dev string:x91>" + entname + "<dev string:xa7>" + level.localeid + "<dev string:xc1>" );
        }
    #/
    
    if ( var_61db3ae80e737603 )
    {
        assertmsg( "<dev string:xe3>" );
    }
}

// Namespace game_utility
// Params 3
// Checksum 0x5366a26f, Offset: 0x1883
// Size: 0x1f2
function function_b89bc4390dd5787a( entname, var_61db3ae80e737603, ignorelocale = 0 )
{
    possibleents = getentarray( entname, #targetname );
    entarray = [];
    
    if ( isdefined( getlocaleid() ) && !ignorelocale )
    {
        foreach ( ent in possibleents )
        {
            if ( !isdefined( ent.script_noteworthy ) || ent.script_noteworthy == level.localeid )
            {
                entarray[ entarray.size ] = ent;
                continue;
            }
            
            ent delete();
        }
    }
    else
    {
        foreach ( ent in possibleents )
        {
            if ( isdefined( ent.script_noteworthy ) && issubstr( ent.script_noteworthy, "locale" ) )
            {
                ent delete();
                continue;
            }
            
            entarray[ entarray.size ] = ent;
        }
    }
    
    var_7237854e3be197ca = entarray;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    /#
        if ( isdefined( level.localeid ) )
        {
            println( "<dev string:x118>" + entname + "<dev string:xa7>" + level.localeid + "<dev string:xc1>" );
        }
    #/
    
    if ( var_61db3ae80e737603 )
    {
        assertmsg( "<dev string:xe3>" );
    }
}

// Namespace game_utility
// Params 2
// Checksum 0xedec6d3f, Offset: 0x1a7d
// Size: 0x190
function getlocalestruct( structname, var_61db3ae80e737603 )
{
    possibleents = utility::getstructarray( structname, "targetname" );
    var_f30c7c43aaa28638 = undefined;
    
    if ( isdefined( getlocaleid() ) )
    {
        foreach ( ent in possibleents )
        {
            if ( ent.script_noteworthy == level.localeid )
            {
                var_f30c7c43aaa28638 = ent;
            }
        }
    }
    else
    {
        foreach ( ent in possibleents )
        {
            if ( !isdefined( var_f30c7c43aaa28638 ) )
            {
                var_f30c7c43aaa28638 = ent;
                break;
            }
        }
    }
    
    var_7237854e3be197ca = var_f30c7c43aaa28638;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    /#
        if ( isdefined( level.localeid ) )
        {
            println( "<dev string:x91>" + structname + "<dev string:xa7>" + level.localeid + "<dev string:xc1>" );
        }
    #/
    
    if ( var_61db3ae80e737603 )
    {
        assertmsg( "<dev string:xe3>" );
    }
}

// Namespace game_utility
// Params 2
// Checksum 0xb1274c3d, Offset: 0x1c15
// Size: 0x135
function getlocalestructarray( structname, var_61db3ae80e737603 )
{
    possibleents = utility::getstructarray( structname, "targetname" );
    var_235eed643deff9f5 = [];
    
    if ( isdefined( getlocaleid() ) )
    {
        foreach ( ent in possibleents )
        {
            if ( getmapname() == "mp_quarry2" )
            {
                var_235eed643deff9f5[ var_235eed643deff9f5.size ] = ent;
                continue;
            }
            
            if ( ent.script_noteworthy == level.localeid )
            {
                var_235eed643deff9f5[ var_235eed643deff9f5.size ] = ent;
            }
        }
        
        return var_235eed643deff9f5;
    }
    
    if ( possibleents.size == 0 )
    {
        /#
            if ( isdefined( level.localeid ) )
            {
                println( "<dev string:x91>" + structname + "<dev string:xa7>" + level.localeid + "<dev string:xc1>" );
            }
        #/
        
        if ( var_61db3ae80e737603 )
        {
            assertmsg( "<dev string:xe3>" );
        }
        
        return;
    }
    
    return possibleents;
}

// Namespace game_utility
// Params 0
// Checksum 0xb8fa8c2c, Offset: 0x1d53
// Size: 0xc, Type: bool
function function_d3f8957534dc62af()
{
    return istrue( level.tier1modeenabled );
}

// Namespace game_utility
// Params 0
// Checksum 0x69269255, Offset: 0x1d68
// Size: 0x19, Type: bool
function function_ae97372c83da7acc()
{
    return level.hardcoremodeenabled || istrue( level.tier1modeenabled );
}

// Namespace game_utility
// Params 4
// Checksum 0x9da211b5, Offset: 0x1d8a
// Size: 0x34
function fadetoblackforplayerkeepui( player, fadetoblack, fadetime, var_a8c80c8156ac9bef )
{
    utility::fadetoblackforplayerkeepui( player, fadetoblack, fadetime, var_a8c80c8156ac9bef );
}

// Namespace game_utility
// Params 1
// Checksum 0x3c1b05ad, Offset: 0x1dc6
// Size: 0x17
function function_d4ba0aa63f12e375( bool )
{
    self.var_3948c60099a64112 = bool;
}

// Namespace game_utility
// Params 5
// Checksum 0x6975b32a, Offset: 0x1de5
// Size: 0x3e
function fadetoblackforplayer( player, fadetoblack, fadetime, var_951f14d75c38443d, var_a8c80c8156ac9bef )
{
    utility::fadetoblackforplayer( player, fadetoblack, fadetime, var_951f14d75c38443d, var_a8c80c8156ac9bef );
}

// Namespace game_utility
// Params 0
// Checksum 0xb17320c3, Offset: 0x1e2b
// Size: 0x1c
function gettimesincegamestart()
{
    return [[ utility::getsharedfunc( #"game_utility", #"gettimesincegamestart" ) ]]();
}

// Namespace game_utility
// Params 0, eflags: 0xc
// Checksum 0x7c8d3d08, Offset: 0x1e50
// Size: 0x14d
function private function_b1fbc84469f0b440()
{
    self notify( #"hash_d2f8acd35c5c082a" );
    self endon( #"hash_d2f8acd35c5c082a" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( isdefined( self.var_6755a3663898b873 ) )
    {
        return;
    }
    
    if ( !level.gametypebundle.var_5bbee11d9a5c8dea )
    {
        return;
    }
    
    self endon( #"hash_f49600676ac5d679" );
    interval = level.gametypebundle.var_89b63c84c2fe704a;
    aeeventname = #"mid_match";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = challenges::getchallengegamemode();
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = challenges::function_9edd00e9e48c0821();
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
    self.var_6755a3663898b873 = 1;
    
    while ( true )
    {
        wait interval;
        
        if ( self && !challenges::challengesenabledforplayer() )
        {
            continue;
        }
        
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"pause_time_cumulative" ) ] = function_e3cd85eead6e1fc7();
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        self function_2e45314624fdfdb8( aeeventid, eventparams );
    }
}

// Namespace game_utility
// Params 0
// Checksum 0x9d4c09b9, Offset: 0x1fa5
// Size: 0x26
function function_d3d1455624159b8()
{
    if ( !self.var_6755a3663898b873 )
    {
        return;
    }
    
    self notify( #"hash_f49600676ac5d679" );
    self.var_6755a3663898b873 = 0;
}

// Namespace game_utility
// Params 0
// Checksum 0x8df2e9e2, Offset: 0x1fd3
// Size: 0x189
function startkeyearning()
{
    allowbots = 0;
    
    /#
        if ( getdvarint( @"hash_455ed09fe13bd89d", 0 ) > 0 )
        {
            allowbots = 1;
        }
    #/
    
    if ( !allowbots && isbot( self ) )
    {
        return;
    }
    
    if ( isdefined( self.pers[ #"hash_728cbcbfbe4a7f9c" ] ) )
    {
        return;
    }
    
    if ( !level.playerxpenabled )
    {
        return;
    }
    
    if ( utility::callsharedfunc( #"br", #"isinstancedspace" ) )
    {
        return;
    }
    
    battlepassscalar = int( function_6e5351c7174b32b4() * 100 );
    gamemode = challenges::getchallengegamemode();
    aeeventname = #"start_match";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"playlist_id" ) ] = getplaylistid();
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"battlepass_xp_scalar" ) ] = battlepassscalar;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"lobby_id" ) ] = getlobbyid();
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"match_id" ) ] = getonlinematchid();
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
    self function_2e45314624fdfdb8( aeeventid, eventparams );
    self.pers[ #"hash_728cbcbfbe4a7f9c" ] = #"started";
    thread function_b1fbc84469f0b440();
}

// Namespace game_utility
// Params 2
// Checksum 0x7ce8e15d, Offset: 0x2164
// Size: 0x4e1
function stopkeyearning( winner, additionaleventparams )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    allowbots = 0;
    
    /#
        if ( getdvarint( @"hash_455ed09fe13bd89d", 0 ) > 0 )
        {
            allowbots = 1;
        }
    #/
    
    if ( isbot( self ) && !allowbots )
    {
        return;
    }
    
    var_f7841df344e8d433 = self.pers[ #"hash_728cbcbfbe4a7f9c" ];
    
    if ( !isdefined( var_f7841df344e8d433 ) )
    {
        return;
    }
    
    if ( var_f7841df344e8d433 == #"stopped" )
    {
        return;
    }
    
    function_d3d1455624159b8();
    
    if ( self.disconnecting && !isdefined( self.connectedpostgame ) )
    {
        result = ae_utility::function_14b0b5e8696534b6( #"matchresult", #"match_result_loss" );
    }
    else
    {
        result = ae_utility::function_14b0b5e8696534b6( #"matchresult", #"match_result_none" );
    }
    
    var_964bb3199b020e24 = getgametype() == "zm_rb_battle" || getgametype() == #"dmz";
    
    if ( !isdefined( winner ) && !var_964bb3199b020e24 )
    {
        assertmsg( "<dev string:x134>" );
    }
    else if ( level.teambased && getgametype() != "zm_rb_battle" )
    {
        if ( winner == "eliminated" )
        {
            result = ae_utility::function_14b0b5e8696534b6( #"matchresult", #"match_result_br_team_eliminated" );
        }
        else if ( winner == "tie" )
        {
            result = ae_utility::function_14b0b5e8696534b6( #"matchresult", #"match_result_draw" );
        }
        else if ( isdefined( self.pers[ "team" ] ) )
        {
            if ( self.pers[ "team" ] == winner )
            {
                result = ae_utility::function_14b0b5e8696534b6( #"matchresult", #"match_result_win" );
            }
            else if ( self.pers[ #"hash_47bf97fb56ab9eaf" ] == #"joinedlate" )
            {
                result = ae_utility::function_14b0b5e8696534b6( #"matchresult", #"match_result_loss_forgiven" );
                self.loss_forgiven = 1;
            }
            else
            {
                result = ae_utility::function_14b0b5e8696534b6( #"matchresult", #"match_result_loss" );
            }
        }
    }
    else if ( isdefined( self.connectedpostgame ) )
    {
        result = ae_utility::function_14b0b5e8696534b6( #"matchresult", #"match_result_none" );
        self.loss_forgiven = 1;
    }
    else if ( !isdefined( self.timeplayed ) || self.timeplayed[ "total" ] < 1 || self.pers[ "participation" ] < 1 )
    {
        result = ae_utility::function_14b0b5e8696534b6( #"matchresult", #"match_result_none" );
        self.loss_forgiven = 1;
    }
    else if ( !self.pers[ "hasDoneAnyCombat" ] )
    {
        result = ae_utility::function_14b0b5e8696534b6( #"matchresult", #"match_result_none" );
        self.loss_forgiven = 1;
    }
    else if ( !isdefined( level.placement ) )
    {
        result = ae_utility::function_14b0b5e8696534b6( #"matchresult", #"match_result_none" );
        self.loss_forgiven = 1;
    }
    else if ( !isplayer( winner ) && winner == "eliminated" )
    {
        result = ae_utility::function_14b0b5e8696534b6( #"matchresult", #"match_result_br_team_eliminated" );
    }
    else
    {
        if ( getgametype() == "zm_rb_battle" )
        {
            iswinner = isplayer( winner ) && winner == self;
        }
        else
        {
            iswinner = 0;
            
            for ( pidx = 0; pidx < min( level.placement[ "all" ].size, 3 ) ; pidx++ )
            {
                if ( level.placement[ "all" ][ pidx ] != self )
                {
                    continue;
                }
                
                iswinner = 1;
            }
        }
        
        if ( iswinner )
        {
            result = ae_utility::function_14b0b5e8696534b6( #"matchresult", #"match_result_win" );
        }
        else if ( self.pers[ #"hash_47bf97fb56ab9eaf" ] == #"joinedlate" )
        {
            result = ae_utility::function_14b0b5e8696534b6( #"matchresult", #"match_result_loss_forgiven" );
            self.loss_forgiven = 1;
        }
        else
        {
            result = ae_utility::function_14b0b5e8696534b6( #"matchresult", #"match_result_loss" );
        }
    }
    
    events::function_34bd3d332f10855a( 1 );
    thread challenges::function_24412890e8abf7dd( self, result, winner, additionaleventparams );
    
    if ( !level.leagueplaymatch && !level.var_309e3d9dac389de6 && !level.var_7f85d8c232d790ed )
    {
        thread challenges::function_21b5f21603591966( self );
    }
    
    self.pers[ #"hash_728cbcbfbe4a7f9c" ] = #"stopped";
}

// Namespace game_utility
// Params 2
// Checksum 0xc26d35e4, Offset: 0x264d
// Size: 0xba
function _visionsetnakedforplayer( visionset, transitionduration )
{
    assert( isdefined( visionset ), "<dev string:x17c>" );
    
    if ( visionset == "" )
    {
        self visionsetnakedforplayer( visionset, transitionduration );
        
        if ( isdefined( self.activevisionsetlist ) )
        {
            self.activevisionsetlist = undefined;
        }
        
        return;
    }
    
    if ( !isdefined( transitionduration ) )
    {
        transitionduration = 0;
    }
    
    if ( !isdefined( self.activevisionsetlist ) )
    {
        self.activevisionsetlist = [];
    }
    
    if ( !isdefined( self.activevisionsetlist[ visionset ] ) )
    {
        self.activevisionsetlist[ visionset ] = 1;
    }
    else
    {
        self.activevisionsetlist[ visionset ]++;
    }
    
    if ( self.activevisionsetlist[ visionset ] == 1 )
    {
        self visionsetnakedforplayer( visionset, transitionduration );
    }
}

// Namespace game_utility
// Params 1
// Checksum 0x1373c67c, Offset: 0x270f
// Size: 0x167
function _visionunsetnakedforplayer( visionset )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    assert( isdefined( self.activevisionsetlist[ visionset ] ), "<dev string:x1b8>" );
    self.activevisionsetlist[ visionset ]--;
    
    if ( self.activevisionsetlist[ visionset ] == 0 )
    {
        var_8ea03e48c409079c = [];
        
        foreach ( visionindex, visionsetcount in self.activevisionsetlist )
        {
            if ( visionindex == visionset )
            {
                continue;
            }
            
            var_8ea03e48c409079c[ visionindex ] = visionsetcount;
        }
        
        self.activevisionsetlist = var_8ea03e48c409079c;
        self visionsetnakedforplayer( "", 0 );
        
        foreach ( visionindex, visionsetcount in var_8ea03e48c409079c )
        {
            waitframe();
            self visionsetnakedforplayer( visionindex, level.framedurationseconds );
        }
    }
}

// Namespace game_utility
// Params 2
// Checksum 0x2ff380f4, Offset: 0x287e
// Size: 0xd0
function removematchingents_bymodel( name, var_56144cf216112482 )
{
    ents = getentarray();
    
    foreach ( ent in ents )
    {
        if ( ent.model == name )
        {
            if ( var_56144cf216112482 && isdefined( ent.target ) )
            {
                removematchingents_bykey( ent.target, "targetname" );
            }
            
            ent delete();
        }
    }
}

// Namespace game_utility
// Params 1
// Checksum 0xd0967ae9, Offset: 0x2956
// Size: 0x9b
function removematchingents_bycodeclassname( name )
{
    ents = getentarray();
    
    foreach ( ent in ents )
    {
        if ( ent.code_classname == name )
        {
            ent delete();
        }
    }
}

// Namespace game_utility
// Params 1
// Checksum 0xc840d97d, Offset: 0x29f9
// Size: 0x9b
function removematchingents_byclassname( name )
{
    ents = getentarray();
    
    foreach ( ent in ents )
    {
        if ( ent.classname == name )
        {
            ent delete();
        }
    }
}

// Namespace game_utility
// Params 2
// Checksum 0x766eda3d, Offset: 0x2a9c
// Size: 0x96
function removematchingents_bykey( name, key )
{
    ents = getentarray( name, key );
    
    foreach ( ent in ents )
    {
        ent delete();
    }
}

// Namespace game_utility
// Params 0
// Checksum 0xd1001e18, Offset: 0x2b3a
// Size: 0xd4b
function initchallengeandeventglobals()
{
    globals = {};
    level.challengeandeventglobals = globals;
    globals.game_type_col = [];
    globals.game_type_col[ "missions" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_cp_missions" );
    globals.game_type_col[ "dm" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_dm" );
    globals.game_type_col[ "war" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_tdm" );
    globals.game_type_col[ "sd" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_sd" );
    globals.game_type_col[ "dom" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_dom" );
    globals.game_type_col[ "conf" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_conf" );
    globals.game_type_col[ "sr" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_sr" );
    globals.game_type_col[ "grind" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_grind" );
    globals.game_type_col[ "ball" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_ball" );
    globals.game_type_col[ "infect" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_infect" );
    globals.game_type_col[ "tjugg" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"hash_dc39a236526e4509" );
    globals.game_type_col[ "gun" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_gun" );
    globals.game_type_col[ "grnd" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_grnd" );
    globals.game_type_col[ "siege" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_siege" );
    globals.game_type_col[ "koth" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_koth" );
    globals.game_type_col[ "ctf" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_ctf" );
    globals.game_type_col[ "dd" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_dd" );
    globals.game_type_col[ "tdef" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"hash_bae2324a6357ff25" );
    globals.game_type_col[ "front" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_front" );
    globals.game_type_col[ "cmd" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_cmd" );
    globals.game_type_col[ "arena" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_arena" );
    globals.game_type_col[ "cyber" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_cyber" );
    globals.game_type_col[ "rush" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_rush" );
    globals.game_type_col[ "esc" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_esc" );
    globals.game_type_col[ "vip" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_vip" );
    globals.game_type_col[ "btm" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_btm" );
    globals.game_type_col[ "rugby" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_rugby" );
    globals.game_type_col[ "arm" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_arm" );
    globals.game_type_col[ "mtmc" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"hash_4083828bb7543117" );
    globals.game_type_col[ "snatch" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"hash_7cad9b981acb29d" );
    globals.game_type_col[ "hq" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_hq" );
    globals.game_type_col[ "defcon" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_defcon" );
    globals.game_type_col[ "pill" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_pill" );
    globals.game_type_col[ "blitz" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_blitz" );
    globals.game_type_col[ "brm" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_brm" );
    globals.game_type_col[ "hvt" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_hvt" );
    globals.game_type_col[ "trial" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_trial" );
    globals.game_type_col[ "cp_survival" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_cp_survival" );
    globals.game_type_col[ "cp_wave_sv" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_cp_wave_sv" );
    globals.game_type_col[ "brtdm" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_brtdm" );
    globals.game_type_col[ "oic" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_oic" );
    globals.game_type_col[ "ko" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_ko" );
    globals.game_type_col[ "risk" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_risk" );
    globals.game_type_col[ "hstg" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"hash_c8df63a365d0db66" );
    globals.game_type_col[ "fr" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_fr" );
    globals.game_type_col[ "gwbomb" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_gwbomb" );
    globals.game_type_col[ "rescue" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_rescue" );
    globals.game_type_col[ "zm_rb" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"hash_ee1508011908d6f0" );
    globals.game_type_col[ "gwai" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"hash_a51fa5bbd5689172" );
    globals.game_type_col[ "control" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_control" );
    globals.game_type_col[ "ob" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_ob" );
    globals.game_type_col[ "elim" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_elim" );
    globals.game_type_col[ "benchmark" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_benchmark" );
    globals.game_type_col[ "ballmode" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_ballmode" );
    globals.game_type_col[ "dungeons" ] = 10;
    globals.game_type_col[ "zm_turned" ] = 6;
    globals.game_type_col[ "bounty" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_bounty" );
    globals.game_type_col[ "training_course" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_training_course" );
    globals.game_type_col[ "wm" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_wm" );
    globals.game_type_col[ "war_cranked" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"hash_5da6de525b828211" );
    globals.game_type_col[ "battleroyale_ftue" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_br_battleroyale_ftue" );
    globals.game_type_col[ "prop" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_prop" );
    globals.game_type_col[ "gold" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_gold" );
    globals.game_type_col[ "sugar" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_sugar" );
    globals.game_type_col[ "ctdm" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"hash_3b068cdeee31c99e" );
    globals.game_type_col[ "landgrab" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"hash_cd6f6b841b71085d" );
    globals.game_type_col[ "escort" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_escort" );
    globals.game_type_col[ "multi" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_multi" );
    globals.game_type_col[ "stop_and_go" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"hash_1660b4311a6816ff" );
    globals.game_type_col[ "sabattack" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"hash_34c9f4471729026c" );
    globals.game_type_col[ "sharp" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_sharp" );
    globals.game_type_col[ "cparty" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"hash_a2c715e04cfd72a9" );
    globals.game_type_col[ "zm_rb_survival" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"hash_eccc1680f33f8847" );
    globals.game_type_col[ "slash" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_slash" );
    globals.game_type_col[ "sticks" ] = ae_utility::function_14b0b5e8696534b6( #"gametype", #"gametype_mp_sticks" );
    var_c518e25f8f07d61 = function_67138bc0fb9151ff();
    
    if ( isdefined( level.gametypebundle.var_f1f566628cf3f54e ) )
    {
        var_75da502f9432cf4d = getscriptbundlefieldvalue( hashcat( %"hash_1f262b85a18b69c7", level.gametypebundle.var_f1f566628cf3f54e ), #"id" );
        
        if ( isdefined( var_75da502f9432cf4d ) )
        {
            globals.game_type_col[ var_c518e25f8f07d61 ] = var_75da502f9432cf4d;
        }
    }
    
    if ( !isdefined( globals.game_type_col[ "dungeons" ] ) )
    {
        globals.game_type_col[ "dungeons" ] = 10;
    }
    
    if ( !isdefined( globals.game_type_col[ "zm_turned" ] ) )
    {
        globals.game_type_col[ "zm_turned" ] = 6;
    }
    
    if ( !isdefined( globals.game_type_col[ var_c518e25f8f07d61 ] ) )
    {
        globals.game_type_col[ var_c518e25f8f07d61 ] = ae_utility::function_14b0b5e8696534b6( #"gametype", hashcat( #"hash_e4539b110505a9ee", var_c518e25f8f07d61 ) );
    }
}

// Namespace game_utility
// Params 0
// Checksum 0x49e5357e, Offset: 0x388d
// Size: 0x5c
function function_67138bc0fb9151ff()
{
    var_c518e25f8f07d61 = level.gametypebundle.var_53486d8d1bcaeac7;
    
    if ( !isdefined( var_c518e25f8f07d61 ) )
    {
        if ( isbrgamemode() )
        {
            assertmsg( "<dev string:x20c>" );
            var_c518e25f8f07d61 = "br";
        }
        else
        {
            assertmsg( "<dev string:x256>" );
            var_c518e25f8f07d61 = "war";
        }
    }
    
    return var_c518e25f8f07d61;
}

// Namespace game_utility
// Params 4
// Checksum 0xb0d6be66, Offset: 0x38f2
// Size: 0x56
function questcircle_create( var_897dae3075ed501f, origin, radius, entityowner )
{
    assert( isdefined( self ), "<dev string:x2a1>" );
    self.mapcircle = spawnquestcircle( var_897dae3075ed501f, origin[ 0 ], origin[ 1 ], radius, entityowner );
    questcircle_hidefromall();
}

// Namespace game_utility
// Params 1
// Checksum 0xebe4ad1, Offset: 0x3950
// Size: 0x57
function questcircle_move( neworigin )
{
    if ( questcircle_exists() )
    {
        self.mapcircle.origin = ( neworigin[ 0 ], neworigin[ 1 ], self.mapcircle.origin[ 2 ] );
        return;
    }
    
    assertmsg( "<dev string:x300>" );
}

// Namespace game_utility
// Params 3
// Checksum 0xf65b6e3f, Offset: 0x39af
// Size: 0x7b
function questcircle_moveto( neworigin, newradius, time )
{
    if ( questcircle_exists() )
    {
        if ( !isdefined( newradius ) )
        {
            newradius = self.mapcircle.origin[ 2 ];
        }
        
        var_93ea7a66175e78e1 = ( neworigin[ 0 ], neworigin[ 1 ], newradius );
        self.mapcircle moveto( var_93ea7a66175e78e1, time );
        return;
    }
    
    assertmsg( "<dev string:x364>" );
}

// Namespace game_utility
// Params 1
// Checksum 0x5cf9b016, Offset: 0x3a32
// Size: 0x35
function function_27df4a8c168476e9( newindex )
{
    if ( questcircle_exists() )
    {
        self.mapcircle setquestcircleindex( newindex );
        return;
    }
    
    assertmsg( "<dev string:x3ca>" );
}

// Namespace game_utility
// Params 1
// Checksum 0x18ef0f30, Offset: 0x3a6f
// Size: 0x4c
function function_339633e26ca732ea( coloroverride )
{
    if ( questcircle_exists() )
    {
        if ( isdefined( coloroverride ) )
        {
            self.mapcircle function_8de31a167f12c673( coloroverride );
        }
        else
        {
            self.mapcircle function_8de31a167f12c673();
        }
        
        return;
    }
    
    assertmsg( "<dev string:x432>" );
}

// Namespace game_utility
// Params 0
// Checksum 0xe2060114, Offset: 0x3ac3
// Size: 0x29
function questcircle_showtoall()
{
    if ( questcircle_exists() )
    {
        self.mapcircle show();
        return;
    }
    
    assertmsg( "<dev string:x4a2>" );
}

// Namespace game_utility
// Params 1
// Checksum 0x27ef412c, Offset: 0x3af4
// Size: 0x89
function function_5b1f02a1690aa24c( teamname )
{
    foreach ( player in teams::getteamdata( teamname, "players" ) )
    {
        questcircle_showtoplayer( player );
    }
}

// Namespace game_utility
// Params 0
// Checksum 0xc8e9bb83, Offset: 0x3b85
// Size: 0x29
function questcircle_hidefromall()
{
    if ( questcircle_exists() )
    {
        self.mapcircle hide();
        return;
    }
    
    assertmsg( "<dev string:x50b>" );
}

// Namespace game_utility
// Params 1
// Checksum 0xa9be7b62, Offset: 0x3bb6
// Size: 0x35
function questcircle_showtoplayer( player )
{
    if ( questcircle_exists() )
    {
        self.mapcircle showtoplayer( player );
        return;
    }
    
    assertmsg( "<dev string:x576>" );
}

// Namespace game_utility
// Params 1
// Checksum 0x736c3cd6, Offset: 0x3bf3
// Size: 0x35
function questcircle_hidefromplayer( player )
{
    if ( questcircle_exists() )
    {
        self.mapcircle hidefromplayer( player );
        return;
    }
    
    assertmsg( "<dev string:x5e2>" );
}

// Namespace game_utility
// Params 1
// Checksum 0x606266ef, Offset: 0x3c30
// Size: 0x89
function function_1f7fc1f084e4ee44( teamname )
{
    foreach ( player in teams::getteamdata( teamname, "players" ) )
    {
        questcircle_hidefromplayer( player );
    }
}

// Namespace game_utility
// Params 1
// Checksum 0x2815e53d, Offset: 0x3cc1
// Size: 0x35
function questcircle_fadeout( fadetime )
{
    if ( questcircle_exists() )
    {
        self.mapcircle questcirclefadeout( fadetime );
        return;
    }
    
    assertmsg( "<dev string:x650>" );
}

// Namespace game_utility
// Params 0
// Checksum 0xc6d1a59f, Offset: 0x3cfe
// Size: 0x29
function function_12b83090e6a63b86()
{
    if ( questcircle_exists() )
    {
        self.mapcircle function_e0574b99a7acea79();
        return;
    }
    
    assertmsg( "<dev string:x6b7>" );
}

// Namespace game_utility
// Params 1
// Checksum 0xdfc10c6e, Offset: 0x3d2f
// Size: 0x67
function function_d46d8731ed9d281( newradius )
{
    if ( questcircle_exists() )
    {
        self.mapcircle.origin = ( self.mapcircle.origin[ 0 ], self.mapcircle.origin[ 1 ], newradius );
        return;
    }
    
    assertmsg( "<dev string:x720>" );
}

// Namespace game_utility
// Params 0
// Checksum 0x4443ad20, Offset: 0x3d9e
// Size: 0x23
function questcircle_delete()
{
    if ( questcircle_exists() )
    {
        self.mapcircle delete();
        self.mapcircle = undefined;
    }
}

// Namespace game_utility
// Params 0
// Checksum 0x299243a6, Offset: 0x3dc9
// Size: 0x25, Type: bool
function questcircle_getorigin()
{
    return self.mapcircle.origin ?? ( 0, 0, 0 );
}

// Namespace game_utility
// Params 0
// Checksum 0x30a42877, Offset: 0x3df7
// Size: 0xc, Type: bool
function questcircle_exists()
{
    return isdefined( self.mapcircle );
}

// Namespace game_utility
// Params 0
// Checksum 0x8c8a1ef3, Offset: 0x3e0c
// Size: 0x2a
function function_4879dfc7047f9668()
{
    if ( !questcircle_exists() )
    {
        return [];
    }
    
    circleorigin = questcircle_getorigin();
    return getplayersinradius( circleorigin, circleorigin[ 2 ] );
}

// Namespace game_utility
// Params 4
// Checksum 0x52deb423, Offset: 0x3e3f
// Size: 0x56
function function_50dcc41281a10ae6( var_897dae3075ed501f, origin, radius, var_af69f71c1f9d97a4 )
{
    assert( isdefined( self ), "<dev string:x2a1>" );
    self.var_ff099728517fe06 = spawnquestcircle( var_897dae3075ed501f, origin[ 0 ], origin[ 1 ], radius, var_af69f71c1f9d97a4 );
    function_2197b380878e7ce5();
}

// Namespace game_utility
// Params 1
// Checksum 0xf5bbe984, Offset: 0x3e9d
// Size: 0x57
function function_97e255c843f6d72f( neworigin )
{
    if ( function_d1278c8f8c4819da() )
    {
        self.var_ff099728517fe06.origin = ( neworigin[ 0 ], neworigin[ 1 ], self.var_ff099728517fe06.origin[ 2 ] );
        return;
    }
    
    assertmsg( "<dev string:x789>" );
}

// Namespace game_utility
// Params 0
// Checksum 0xc37d7e93, Offset: 0x3efc
// Size: 0x29
function function_62882a3ac23ea349()
{
    if ( function_d1278c8f8c4819da() )
    {
        self.var_ff099728517fe06 show();
        return;
    }
    
    assertmsg( "<dev string:x7ee>" );
}

// Namespace game_utility
// Params 0
// Checksum 0x62e5e23a, Offset: 0x3f2d
// Size: 0x29
function function_2197b380878e7ce5()
{
    if ( function_d1278c8f8c4819da() )
    {
        self.var_ff099728517fe06 hide();
        return;
    }
    
    assertmsg( "<dev string:x858>" );
}

// Namespace game_utility
// Params 1
// Checksum 0x4a536eb0, Offset: 0x3f5e
// Size: 0x35
function function_a876d3dd7d7b002b( player )
{
    if ( function_d1278c8f8c4819da() )
    {
        self.var_ff099728517fe06 showtoplayer( player );
        return;
    }
    
    assertmsg( "<dev string:x8c4>" );
}

// Namespace game_utility
// Params 1
// Checksum 0xb3cb86ae, Offset: 0x3f9b
// Size: 0x35
function function_167207183beca56f( player )
{
    if ( function_d1278c8f8c4819da() )
    {
        self.var_ff099728517fe06 hidefromplayer( player );
        return;
    }
    
    assertmsg( "<dev string:x931>" );
}

// Namespace game_utility
// Params 1
// Checksum 0xfeba73e9, Offset: 0x3fd8
// Size: 0x67
function function_c320a0eb32354330( newradius )
{
    if ( function_d1278c8f8c4819da() )
    {
        self.var_ff099728517fe06.origin = ( self.var_ff099728517fe06.origin[ 0 ], self.var_ff099728517fe06.origin[ 1 ], newradius );
        return;
    }
    
    assertmsg( "<dev string:x9a0>" );
}

// Namespace game_utility
// Params 0
// Checksum 0x57f12876, Offset: 0x4047
// Size: 0x19
function function_b67daf7bb752a06d()
{
    if ( function_d1278c8f8c4819da() )
    {
        self.var_ff099728517fe06 delete();
    }
}

// Namespace game_utility
// Params 0
// Checksum 0x1d41f6fb, Offset: 0x4068
// Size: 0x25, Type: bool
function function_30d947695364f2a8()
{
    return self.var_ff099728517fe06.origin ?? ( 0, 0, 0 );
}

// Namespace game_utility
// Params 0
// Checksum 0xe8c7a164, Offset: 0x4096
// Size: 0xc, Type: bool
function function_d1278c8f8c4819da()
{
    return isdefined( self.var_ff099728517fe06 );
}

// Namespace game_utility
// Params 4
// Checksum 0x58321277, Offset: 0x40ab
// Size: 0x56
function function_5ed1978667757cd0( var_897dae3075ed501f, origin, radius, var_af69f71c1f9d97a4 )
{
    assert( isdefined( self ), "<dev string:x2a1>" );
    self.var_ff09a7285180039 = spawnquestcircle( var_897dae3075ed501f, origin[ 0 ], origin[ 1 ], radius, var_af69f71c1f9d97a4 );
    function_7360dc19b06fe117();
}

// Namespace game_utility
// Params 1
// Checksum 0x72f6b004, Offset: 0x4109
// Size: 0x57
function function_a2f6f0090613fc51( neworigin )
{
    if ( function_bfe35129316b29d4() )
    {
        self.var_ff09a7285180039.origin = ( neworigin[ 0 ], neworigin[ 1 ], self.var_ff09a7285180039.origin[ 2 ] );
        return;
    }
    
    assertmsg( "<dev string:xa0a>" );
}

// Namespace game_utility
// Params 0
// Checksum 0xcad57c8c, Offset: 0x4168
// Size: 0x29
function function_469602506da73e37()
{
    if ( function_bfe35129316b29d4() )
    {
        self.var_ff09a7285180039 show();
        return;
    }
    
    assertmsg( "<dev string:xa6f>" );
}

// Namespace game_utility
// Params 0
// Checksum 0x16676c39, Offset: 0x4199
// Size: 0x29
function function_7360dc19b06fe117()
{
    if ( function_bfe35129316b29d4() )
    {
        self.var_ff09a7285180039 hide();
        return;
    }
    
    assertmsg( "<dev string:xad9>" );
}

// Namespace game_utility
// Params 1
// Checksum 0x9465641e, Offset: 0x41ca
// Size: 0x35
function function_29a8d129125011c1( player )
{
    if ( function_bfe35129316b29d4() )
    {
        self.var_ff09a7285180039 showtoplayer( player );
        return;
    }
    
    assertmsg( "<dev string:xb45>" );
}

// Namespace game_utility
// Params 1
// Checksum 0x344cc8f8, Offset: 0x4207
// Size: 0x35
function function_fa7bd46fb69fa021( player )
{
    if ( function_bfe35129316b29d4() )
    {
        self.var_ff09a7285180039 hidefromplayer( player );
        return;
    }
    
    assertmsg( "<dev string:xbb2>" );
}

// Namespace game_utility
// Params 1
// Checksum 0xf71271f6, Offset: 0x4244
// Size: 0x67
function function_2c965632b33985b2( newradius )
{
    if ( function_bfe35129316b29d4() )
    {
        self.var_ff09a7285180039.origin = ( self.var_ff09a7285180039.origin[ 0 ], self.var_ff09a7285180039.origin[ 1 ], newradius );
        return;
    }
    
    assertmsg( "<dev string:xc21>" );
}

// Namespace game_utility
// Params 0
// Checksum 0x28d15c0e, Offset: 0x42b3
// Size: 0x19
function function_3bc63264eca52a8f()
{
    if ( function_bfe35129316b29d4() )
    {
        self.var_ff09a7285180039 delete();
    }
}

// Namespace game_utility
// Params 0
// Checksum 0xeb97f144, Offset: 0x42d4
// Size: 0x25, Type: bool
function function_4964d08dd46b5c82()
{
    return self.var_ff09a7285180039.origin ?? ( 0, 0, 0 );
}

// Namespace game_utility
// Params 0
// Checksum 0x6899d0bc, Offset: 0x4302
// Size: 0xc, Type: bool
function function_bfe35129316b29d4()
{
    return isdefined( self.var_ff09a7285180039 );
}

// Namespace game_utility
// Params 1
// Checksum 0xc9df989b, Offset: 0x4317
// Size: 0xfd
function function_de7fe184eb0e834c( var_5df2d410e3102a87 )
{
    self.mapcircle endon( #"death" );
    circle_origin = self.origin;
    
    if ( !isdefined( var_5df2d410e3102a87 ) )
    {
        var_5df2d410e3102a87 = level.players;
    }
    
    if ( !isdefined( minimap_floor ) )
    {
        minimap_floor = detect_minimap_floor( circle_origin );
    }
    
    while ( true )
    {
        foreach ( player in var_5df2d410e3102a87 )
        {
            if ( isdefined( player ) )
            {
                if ( player.player_floor_number == minimap_floor )
                {
                    questcircle_showtoplayer( player );
                    continue;
                }
                
                questcircle_hidefromplayer( player );
            }
        }
        
        wait 0.5;
    }
}

// Namespace game_utility
// Params 1
// Checksum 0x87ea70ec, Offset: 0x441c
// Size: 0xf2
function detect_minimap_floor( location )
{
    if ( !isdefined( level.minimap_floor_triggers ) )
    {
        level.minimap_floor_triggers = getentarray( "trigger_multiple_set_minimap_floor", #classname );
    }
    
    if ( !isdefined( level.minimap_floor_probe ) )
    {
        level.minimap_floor_probe = utility::spawn_script_origin();
    }
    
    level.minimap_floor_probe.origin = location;
    
    foreach ( var_16dfeeed09abfc2f in level.minimap_floor_triggers )
    {
        if ( level.minimap_floor_probe istouching( var_16dfeeed09abfc2f ) )
        {
            return var_16dfeeed09abfc2f.script_floor_number;
        }
    }
}

// Namespace game_utility
// Params 0
// Checksum 0xdbc0e9d5, Offset: 0x4517
// Size: 0x81
function trackprojectiles()
{
    if ( !isdefined( level.projectilekillstreaks ) )
    {
        level.projectilekillstreaks = [];
    }
    
    if ( !isdefined( level.var_4043363bc821bd45 ) )
    {
        level.var_4043363bc821bd45 = 0;
    }
    
    while ( true )
    {
        level.grenades = getentarray( "grenade", #classname );
        level.missiles = getentarray( "rocket", #classname );
        level.projectilepartition = undefined;
        level.smallprojectilepartition = undefined;
        waitframe();
    }
}

// Namespace game_utility
// Params 0
// Checksum 0xd3712dc1, Offset: 0x45a0
// Size: 0x57
function createProjectilePartition()
{
    if ( isdefined( level.projectilepartition ) )
    {
        return;
    }
    
    projectiles = function_be0dd53539a68b65( level.grenades, level.missiles, weapon::function_3aafcaf7ff6dea9e(), level.projectilekillstreaks );
    level.projectilepartition = utility::create_partition( projectiles, 400, 1 );
}

// Namespace game_utility
// Params 0
// Checksum 0x78ff96d8, Offset: 0x45ff
// Size: 0xa4
function game_utility_init()
{
    /#
        utility::issharedfuncdefined( #"game_utility", #"init", 1 );
    #/
    
    [[ utility::getsharedfunc( #"game_utility", #"init" ) ]]();
    
    /#
        utility::issharedfuncdefined( #"game_utility", #"gettimesincegamestart", 1 );
    #/
    
    battlepassxpscale = function_846dc4e6907bc44b();
    var_2af1a539e6721515 = function_e4e11cbe904e34f5();
    
    if ( var_2af1a539e6721515 && ( battlepassxpscale > 4 || battlepassxpscale < 0 ) )
    {
        exitlevel( 0 );
    }
    
    level addbattlepassxpmultiplier( battlepassxpscale, "online_global_battle_xpscale" );
}

// Namespace game_utility
// Params 0
// Checksum 0xc7947b84, Offset: 0x46ab
// Size: 0x7a
function values_init()
{
    val::register( "player_for_spawn_logic", 1, 0, "$self", &set_player_for_spawn_logic, "$value" );
    val::register( "cg_drawcrosshair", 1, 0, "$self", &set_allow_crosshair, "$value" );
    val::register( "show_hud_names", 1, 0, "$self", &set_hud_names, "$value" );
    val::register( "show_legs_and_shadow", 1, 0, "$self", &set_show_legs_and_shadow, "$value" );
}

// Namespace game_utility
// Params 1, eflags: 0x4
// Checksum 0x888ce5b4, Offset: 0x472d
// Size: 0x1e
function private set_player_for_spawn_logic( b_value = 1 )
{
    self ignorecharacterduringspawnselection( !b_value );
}

// Namespace game_utility
// Params 0
// Checksum 0x6aa48074, Offset: 0x4753
// Size: 0x83
function function_6e5351c7174b32b4()
{
    xpmodifier = level getbattlepassxpmultiplier();
    var_6ac9fec241bedac1 = 1;
    var_b1cc56b8b3c10c20 = getdvarint( @"hash_a429ab6edb6e3023", 0 ) == 0;
    
    if ( var_b1cc56b8b3c10c20 )
    {
        var_b1cc56b8b3c10c20 = function_e4e11cbe904e34f5();
    }
    
    if ( ( xpmodifier > 4 || xpmodifier < 0 ) && var_b1cc56b8b3c10c20 )
    {
        exitlevel( 0 );
    }
    
    if ( self isbnetigrplayer() )
    {
        var_6ac9fec241bedac1 = getbnetigrbattlepassxpmultiplier();
    }
    
    returnval = xpmodifier * var_6ac9fec241bedac1;
    return returnval;
}

// Namespace game_utility
// Params 0
// Checksum 0xffe39d, Offset: 0x47df
// Size: 0xa7
function getbattlepassxpmultiplier()
{
    if ( !isdefined( self.battlepassxpmultipliers ) )
    {
        return 1;
    }
    
    modifiertotal = 1;
    
    foreach ( modifier in self.battlepassxpmultipliers )
    {
        if ( !isdefined( modifier ) )
        {
            continue;
        }
        
        modifiertotal *= modifier;
    }
    
    return modifiertotal;
}

// Namespace game_utility
// Params 2
// Checksum 0xb4aa3313, Offset: 0x488f
// Size: 0x97
function addbattlepassxpmultiplier( multiplier, ref )
{
    maxmultiplier = 4 / level getbattlepassxpmultiplier();
    
    if ( !function_e4e11cbe904e34f5() )
    {
        maxmultiplier = 2147483647;
    }
    
    if ( multiplier > maxmultiplier )
    {
        return;
    }
    
    if ( !isdefined( self.battlepassxpmultipliers ) )
    {
        self.battlepassxpmultipliers = [];
    }
    
    if ( isdefined( self.battlepassxpmultipliers[ ref ] ) )
    {
        self.battlepassxpmultipliers[ ref ] = max( self.battlepassxpmultipliers[ ref ], multiplier );
        return;
    }
    
    self.battlepassxpmultipliers[ ref ] = multiplier;
}

// Namespace game_utility
// Params 0
// Checksum 0xadc56847, Offset: 0x492e
// Size: 0x12
function function_2616809fffa8657f()
{
    return function_815e978748e52d97() ? getglobalxpscale() : 1;
}

// Namespace game_utility
// Params 0
// Checksum 0x159e019e, Offset: 0x4949
// Size: 0x12
function function_9bfaf55b1b68d20d()
{
    return function_b5d06ecc3a6bfdf() ? function_d4ae9dc77d0f0da9() : 1;
}

// Namespace game_utility
// Params 0
// Checksum 0x52ed76f3, Offset: 0x4964
// Size: 0x39
function function_1312a7e835f15b66()
{
    playlistid = getplaylistid();
    playlistxpscale = 1;
    
    if ( playlistid != 0 && function_5d1f7cc0b3c22614( playlistid ) )
    {
        playlistxpscale = getplaylistxpscale( playlistid );
    }
    
    return playlistxpscale;
}

// Namespace game_utility
// Params 0
// Checksum 0x950a6c19, Offset: 0x49a6
// Size: 0x45
function function_c6e89e9bd38dba2c()
{
    globalxpscale = function_2616809fffa8657f();
    gamemodexpscale = function_9bfaf55b1b68d20d();
    playlistxpscale = function_1312a7e835f15b66();
    return int( max( max( globalxpscale, playlistxpscale ), gamemodexpscale ) );
}

// Namespace game_utility
// Params 0
// Checksum 0x70908bb7, Offset: 0x49f4
// Size: 0x8d
function function_52f600c9a675164c()
{
    playlistid = getplaylistid();
    xpscale = 1;
    playlistxpscale = 1;
    gamemodexpscale = 1;
    
    if ( function_9f6eff9c1ddd8433() )
    {
        xpscale = function_387bbf731f6e5c95();
    }
    
    if ( function_ff364161d2dfddbb() )
    {
        gamemodexpscale = function_310db1dca96cc9ed();
    }
    
    if ( !isdefined( playlistid ) || playlistid == 0 )
    {
        return int( max( xpscale, gamemodexpscale ) );
    }
    
    if ( function_5d1f7cc0b3c22614( playlistid ) )
    {
        playlistxpscale = function_e038053365acb66a( playlistid );
    }
    
    return int( max( max( xpscale, playlistxpscale ), gamemodexpscale ) );
}

// Namespace game_utility
// Params 0
// Checksum 0x68a2e76c, Offset: 0x4a8a
// Size: 0x8d
function function_846dc4e6907bc44b()
{
    playlistid = getplaylistid();
    xpscale = 1;
    playlistxpscale = 1;
    gamemodexpscale = 1;
    
    if ( function_c5a506dc6361acf6() )
    {
        xpscale = function_9f6d574c59cedd68();
    }
    
    if ( function_a1513c1d2de192ce() )
    {
        gamemodexpscale = function_50ee0432d3da51b0();
    }
    
    if ( !isdefined( playlistid ) || playlistid == 0 )
    {
        return int( max( xpscale, gamemodexpscale ) );
    }
    
    if ( function_5d1f7cc0b3c22614( playlistid ) )
    {
        playlistxpscale = function_32260acebced62e7( playlistid );
    }
    
    return int( max( max( xpscale, playlistxpscale ), gamemodexpscale ) );
}

// Namespace game_utility
// Params 0
// Checksum 0x716dd0fa, Offset: 0x4b20
// Size: 0x65
function function_de67813d104116b6()
{
    playlistid = getplaylistid();
    xpscale = 1;
    playlistxpscale = 1;
    
    if ( function_6dde6d8a9c8392df() )
    {
        xpscale = function_94663004267ca0d9();
    }
    
    if ( !isdefined( playlistid ) || playlistid == 0 )
    {
        return xpscale;
    }
    
    if ( function_5d1f7cc0b3c22614( playlistid ) )
    {
        playlistxpscale = function_25cb024cd49198de( playlistid );
    }
    
    return int( max( xpscale, playlistxpscale ) );
}

// Namespace game_utility
// Params 0
// Checksum 0x1bbfd369, Offset: 0x4b8e
// Size: 0x65
function function_9780a6a356d5aa72()
{
    playlistid = getplaylistid();
    xpscale = 1;
    playlistxpscale = 1;
    
    if ( function_2edac182960c6ef() )
    {
        xpscale = function_fa9fd5cf61790039();
    }
    
    if ( !isdefined( playlistid ) || playlistid == 0 )
    {
        return xpscale;
    }
    
    if ( function_5d1f7cc0b3c22614( playlistid ) )
    {
        playlistxpscale = function_417418fbe704c382( playlistid );
    }
    
    return int( max( xpscale, playlistxpscale ) );
}

// Namespace game_utility
// Params 1, eflags: 0x4
// Checksum 0x627a4752, Offset: 0x4bfc
// Size: 0x14
function private set_allow_crosshair( b_value = 0 )
{
    
}

// Namespace game_utility
// Params 0
// Checksum 0x27053d9b, Offset: 0x4c18
// Size: 0x79
function gettimepassed()
{
    if ( !( isdefined( level.starttime ) && isdefined( level.discardtime ) ) )
    {
        return 0;
    }
    
    if ( level.timerstopped )
    {
        return ( level.timerpausetime - level.starttime - level.discardtime - level.overtimetotal );
    }
    
    return gettime() - level.starttime - level.discardtime - level.overtimetotal;
}

// Namespace game_utility
// Params 0, eflags: 0x4
// Checksum 0xf5d042f7, Offset: 0x4c99
// Size: 0x1ae
function private function_19529f93bc3bc417()
{
    assert( isdefined( self ) );
    assert( isplayer( self ) );
    player = self;
    
    if ( !isdefined( player.var_445b97b81bcc1707 ) )
    {
        var_445b97b81bcc1707 = spawnstruct();
        var_445b97b81bcc1707.participantcount = 0;
        
        if ( !isdefined( player.operatorcustomization ) )
        {
            if ( isdefined( player.team ) && team_utility::isgameplayteam( player.team ) )
            {
                player utility::callsharedfunc( #"game", #"getoperatorcustomization" );
            }
        }
        
        if ( isdefined( player.operatorcustomization ) && isdefined( player.operatorcustomization.skinlootid ) )
        {
            var_445b97b81bcc1707.var_a92b9b2513205ee6 = operator::function_647772866281c051( player.operatorcustomization.skinlootid );
        }
        
        var_aa1a608286de80e = utility::ismp() && !isbrgamemode() && getgametype() != "ob" && getgametype() != "ob_rift_run" && getgametype() != "ob_pvpve";
        
        if ( var_aa1a608286de80e )
        {
            var_7a7f7d66f297edf7 = player operator::function_d24f366ea9117af1();
            
            if ( isdefined( var_7a7f7d66f297edf7 ) )
            {
                var_445b97b81bcc1707.var_8e3fc0f51217cd3f = operator::function_647772866281c051( var_7a7f7d66f297edf7 );
            }
            
            var_7d1157c4b4b08b6d = player operator::function_ef2efa78a5ae293f();
            
            if ( isdefined( var_7d1157c4b4b08b6d ) )
            {
                var_445b97b81bcc1707.var_9fee9ed88db6b5ed = operator::function_647772866281c051( var_7d1157c4b4b08b6d );
            }
        }
        
        player.var_445b97b81bcc1707 = var_445b97b81bcc1707;
    }
    
    return player.var_445b97b81bcc1707;
}

// Namespace game_utility
// Params 1, eflags: 0x4
// Checksum 0xeabc6380, Offset: 0x4e50
// Size: 0x1b0
function private function_71298cc395fc1b5a( var_689e96c1f3c97dcd )
{
    assert( isplayer( self ) );
    var_2185dfe521d70bc2 = function_19529f93bc3bc417();
    var_2185dfe521d70bc2.participantcount = 0;
    
    if ( !isdefined( self.var_3e7c96b4c1dd9367 ) )
    {
        self.var_3e7c96b4c1dd9367 = 0;
    }
    
    if ( isdefined( var_2185dfe521d70bc2.var_a92b9b2513205ee6 ) || isdefined( var_2185dfe521d70bc2.var_8e3fc0f51217cd3f ) || isdefined( var_2185dfe521d70bc2.var_9fee9ed88db6b5ed ) )
    {
        var_2185dfe521d70bc2.participantcount++;
        
        foreach ( other in self getfireteammembers() )
        {
            if ( other == var_689e96c1f3c97dcd )
            {
                continue;
            }
            
            var_2185dee521d7098f = other function_19529f93bc3bc417();
            var_dba75470e8db80f8 = var_2185dfe521d70bc2.var_a92b9b2513205ee6 == var_2185dee521d7098f.var_a92b9b2513205ee6;
            var_9403ce97a67de6fd = var_2185dfe521d70bc2.var_8e3fc0f51217cd3f == var_2185dee521d7098f.var_8e3fc0f51217cd3f;
            var_df337730bd717e8b = var_2185dfe521d70bc2.var_9fee9ed88db6b5ed == var_2185dee521d7098f.var_9fee9ed88db6b5ed;
            
            if ( var_dba75470e8db80f8 || var_9403ce97a67de6fd || var_df337730bd717e8b )
            {
                var_2185dfe521d70bc2.participantcount++;
            }
        }
    }
    
    self.var_3e7c96b4c1dd9367 = max( self.var_3e7c96b4c1dd9367, var_2185dfe521d70bc2.participantcount );
}

// Namespace game_utility
// Params 1
// Checksum 0x4dd1c11d, Offset: 0x5008
// Size: 0x128
function function_f3b8c430e6514f98( playeractive )
{
    assert( isplayer( self ) );
    
    if ( !level.onlinegame )
    {
        return;
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( playeractive )
    {
        function_71298cc395fc1b5a();
        
        foreach ( member in self getfireteammembers() )
        {
            member function_71298cc395fc1b5a();
        }
        
        return;
    }
    
    self.var_445b97b81bcc1707 = undefined;
    
    foreach ( member in self getfireteammembers() )
    {
        member function_71298cc395fc1b5a( self );
    }
}

// Namespace game_utility
// Params 0
// Checksum 0x777b6f6a, Offset: 0x5138
// Size: 0x32
function function_b3da48d8b8bfe95b()
{
    assert( isplayer( self ) );
    
    if ( !isdefined( self.var_445b97b81bcc1707 ) )
    {
        return 0;
    }
    
    return self.var_445b97b81bcc1707.participantcount;
}

// Namespace game_utility
// Params 3
// Checksum 0x882410e3, Offset: 0x5173
// Size: 0x7b, Type: bool
function set_scriptable_radar( radarent, radarstate, compassstate )
{
    if ( !function_6bf4f7f554c07a7f( radarent ) )
    {
        return false;
    }
    
    if ( !isdefined( radarstate ) )
    {
        return false;
    }
    
    radarent setscriptablepartstate( "radar", radarstate, 0 );
    
    if ( compassstate )
    {
        if ( radarstate == "on" )
        {
            self.owner function_d35b7b585d7fc266( compassstate, 1 );
        }
        else
        {
            self.owner function_2c796b5cbe343df3( compassstate );
        }
    }
    
    return true;
}

// Namespace game_utility
// Params 1
// Checksum 0xe7f0cbda, Offset: 0x51f7
// Size: 0x61, Type: bool
function function_6bf4f7f554c07a7f( radarent )
{
    if ( !getcodegate( #"hash_ecef4482de4a4fa2" ) )
    {
        return false;
    }
    
    if ( !radarent.bundle.var_5768d12e53aefe9a )
    {
        return false;
    }
    
    if ( !radarent getscriptablehaspart( "radar" ) )
    {
        return false;
    }
    
    if ( utility::function_9e8f69121ec4b65d( #"hash_ea8fecbd6f019225" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace game_utility
// Params 2
// Checksum 0x16e44e59, Offset: 0x5261
// Size: 0x1ba
function function_da5d11dbc396e28a( xptype, basexp )
{
    assert( isplayer( self ) );
    
    if ( !isxhash( xptype ) )
    {
        assert( 0, "<dev string:xc8b>" );
        xptype = getxhash( xptype );
    }
    
    modifier = 0;
    
    if ( !isdefined( self.var_100e04866d097e0 ) )
    {
        self.var_100e04866d097e0 = 0;
    }
    
    partysize = self getprivatepartysize();
    self.var_100e04866d097e0 = max( self.var_100e04866d097e0, partysize );
    
    if ( partysize == 2 )
    {
        switch ( xptype )
        {
            case #"account":
                modifier = level.var_12c9f0afb279b0c4;
                break;
            case #"weapon":
                modifier = level.var_75eb11c5521aec04;
                break;
            case #"bp":
                modifier = level.var_48d978555dd5643e;
                break;
        }
    }
    else if ( partysize == 3 )
    {
        switch ( xptype )
        {
            case #"account":
                modifier = level.var_12c9f1afb279b2f7;
                break;
            case #"weapon":
                modifier = level.var_75eb12c5521aee37;
                break;
            case #"bp":
                modifier = level.var_48d979555dd56671;
                break;
        }
    }
    else if ( partysize >= 4 )
    {
        switch ( xptype )
        {
            case #"account":
                modifier = level.var_9f41e4edef0a25e2;
                break;
            case #"weapon":
                modifier = level.var_464c2753225e9622;
                break;
            case #"bp":
                modifier = level.var_7ca8c63b5b1e7b64;
                break;
        }
    }
    
    return int( basexp * modifier );
}

// Namespace game_utility
// Params 2
// Checksum 0xa446d1f2, Offset: 0x5424
// Size: 0x12a
function function_7c41bb821a58f0a2( xptype, basexp )
{
    assert( isplayer( self ) );
    
    if ( !isxhash( xptype ) )
    {
        assert( 0, "<dev string:xc8b>" );
        xptype = getxhash( xptype );
    }
    
    modifier = 0;
    var_2fd90b4e413c7d56 = function_b3da48d8b8bfe95b();
    
    if ( var_2fd90b4e413c7d56 == 2 )
    {
        switch ( xptype )
        {
            case #"account":
                modifier = level.var_b3047f71baa5ddfc;
                break;
            case #"weapon":
                modifier = level.var_6e773116db9931c;
                break;
            case #"bp":
                modifier = level.var_6f6bbb94bbeb9d6;
                break;
        }
    }
    else if ( var_2fd90b4e413c7d56 >= 3 )
    {
        switch ( xptype )
        {
            case #"account":
                modifier = level.var_9c764a991b12ce33;
                break;
            case #"weapon":
                modifier = level.var_edd4a79d616d3d53;
                break;
            case #"bp":
                modifier = level.var_2c52fb1b3a3d7929;
                break;
        }
    }
    
    return int( basexp * modifier );
}

// Namespace game_utility
// Params 1, eflags: 0x4
// Checksum 0xe90e7642, Offset: 0x5557
// Size: 0xc
function private set_hud_names( b_value )
{
    
}

// Namespace game_utility
// Params 1, eflags: 0x4
// Checksum 0x914c146, Offset: 0x556b
// Size: 0x29
function private set_show_legs_and_shadow( b_value = 1 )
{
    if ( b_value )
    {
        self showlegsandshadow();
        return;
    }
    
    self hidelegsandshadow();
}

// Namespace game_utility
// Params 0
// Checksum 0x6eb951f8, Offset: 0x559c
// Size: 0x39
function function_c4ff84a7288ed707()
{
    assert( !level.var_13b70b3b5724494f, "<dev string:xca5>" );
    
    if ( !isdefined( level.var_c4ff84a7288ed707 ) )
    {
        level.var_c4ff84a7288ed707 = 0;
    }
    
    level.var_c4ff84a7288ed707++;
}

// Namespace game_utility
// Params 0
// Checksum 0xdc3c6996, Offset: 0x55dd
// Size: 0x31
function function_48cf7b776b9642d3()
{
    if ( !level.var_c4ff84a7288ed707 )
    {
        return;
    }
    
    level.var_c4ff84a7288ed707--;
    
    if ( !level.var_c4ff84a7288ed707 )
    {
        level.var_c4ff84a7288ed707 = undefined;
    }
}

