// scripts\mp\gametypes\ob_gametype_pvp.gsc  (hash_535d417849d05a61.gscc) (size: 2235 Bytes / 0x8bb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x57a2f872 (1470298226)
// size ...... 2235 (0x8bb)
// includes .. 3   (offset: 0x867)
// strings ... 5   (offset: 0x87f)
// dev strs .. 0   (offset: 0x8bb)
// exports ... 11  (offset: 0x497)
// cseg ...... 0xc6 + 0x3d1 (0x497)
// imports ... 19  (offset: 0x64f)
// animtree1 . 0   (offset: 0x8bb)
// animtree2 . 0   (offset: 0x8bb)
#using scripts\common\utility;
#using scripts\mp\gametypes\ob;
#using scripts\mp\hud_util;

#namespace ob_gametype_pvp;

// Namespace ob_gametype_pvp
// Params 0
// Checksum 0x659c9190, Offset: 0xe4
// Size: 0x54
function main()
{
    initialize_data();
    ob::main();
    level.bypassclasschoicefunc = &function_9d1fc01f6242519d;
    level.var_449c32a0f392eed7 = &function_612ddc9e20a01eb0;
    utility::registersharedfunc( #"pvp_contract", #"hash_24ed85b21a923519", &function_ff81dbfe025d78af );
    
    /#
    #/
    
    initialize_phases();
}

// Namespace ob_gametype_pvp
// Params 0, eflags: 0x4
// Checksum 0xb52e5a11, Offset: 0x140
// Size: 0x72
function private initialize_data()
{
    level.ob_pvp = {};
    settingsbundlename = getdvar( @"hash_a105ac54d795ebf2", "default_ob_pvp_settings" );
    var_361d912f47630fbb = hashcat( %"hash_539e71f5a70253bc", settingsbundlename );
    level.ob_pvp.settings = getscriptbundle( var_361d912f47630fbb );
    level.ob_pvp.stop_phases = 0;
}

// Namespace ob_gametype_pvp
// Params 0, eflags: 0x4
// Checksum 0x4d43fbd0, Offset: 0x1ba
// Size: 0x2c
function private initialize_phases()
{
    level.ob_pvp.currentphase = 0;
    level.ob_pvp.phasestates = [];
}

// Namespace ob_gametype_pvp
// Params 0
// Checksum 0x16cdf3cb, Offset: 0x1ee
// Size: 0x1fd
function on_phase_change()
{
    level notify( #"next_phase" );
    currentphase = level.ob_pvp.settings.phases[ level.ob_pvp.currentphase ].variant_object;
    
    if ( currentphase.splash )
    {
        hud_util::showsplashtoall( currentphase.splash );
    }
    
    setomnvar( "ui_ob_phase_num", level.ob_pvp.currentphase + 1 );
    timer = currentphase.countdown * 1000;
    setomnvar( "ui_ob_match_timer", gettime() + int( timer ) );
    function_13442994db163924();
    phasefn = level.ob_pvp.phasestates[ currentphase.type ];
    var_e717d9c6a337ebb3 = [[ phasefn ]]( level.ob_pvp.settings.phases[ level.ob_pvp.currentphase ].variant_object );
    level utility::waittill_any_return_params_or_timeout( level.ob_pvp.settings.phases[ level.ob_pvp.currentphase ].variant_object.countdown, "ob_pvp_phase_advance_forced", var_e717d9c6a337ebb3 );
    
    /#
        while ( level.ob_pvp.stop_phases )
        {
            waitframe();
        }
    #/
    
    level.ob_pvp.currentphase++;
    
    if ( level.ob_pvp.currentphase < level.ob_pvp.settings.phases.size )
    {
        thread on_phase_change();
    }
}

// Namespace ob_gametype_pvp
// Params 0, eflags: 0x4
// Checksum 0x7079b67d, Offset: 0x3f3
// Size: 0x2
function private function_13442994db163924()
{
    
}

// Namespace ob_gametype_pvp
// Params 1, eflags: 0x4
// Checksum 0x1ce066ae, Offset: 0x3fd
// Size: 0xe, Type: bool
function private function_ff81dbfe025d78af( player )
{
    return true;
}

// Namespace ob_gametype_pvp
// Params 0, eflags: 0x4
// Checksum 0x508576b1, Offset: 0x414
// Size: 0x16
function private function_9d1fc01f6242519d()
{
    if ( isbot( self ) )
    {
        return "callback";
    }
    
    return ob::function_302d3d999a2ab368();
}

// Namespace ob_gametype_pvp
// Params 0, eflags: 0x4
// Checksum 0x4dada29, Offset: 0x433
// Size: 0x15
function private function_612ddc9e20a01eb0()
{
    return level.gametypebundle.laststandweapon;
}

/#

    // Namespace ob_gametype_pvp
    // Params 0
    // Checksum 0x395a1b3d, Offset: 0x451
    // Size: 0x11, Type: dev
    function advance_phase()
    {
        level notify( #"ob_pvp_phase_advance_forced" );
    }

    // Namespace ob_gametype_pvp
    // Params 0
    // Checksum 0xf36642f0, Offset: 0x46a
    // Size: 0x2d, Type: dev
    function stop_phase()
    {
        level.ob_pvp.stop_phases = !level.ob_pvp.stop_phases;
    }

#/
