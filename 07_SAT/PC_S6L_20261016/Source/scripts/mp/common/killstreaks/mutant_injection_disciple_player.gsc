// scripts\mp\common\killstreaks\mutant_injection_disciple_player.gsc  (hash_693b88d97bf0b4a5.gscc) (size: 6480 Bytes / 0x1950 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf11889a2 (4044917154)
// size ...... 6480 (0x1950)
// includes .. 7   (offset: 0x178c)
// strings ... 19  (offset: 0x17c4)
// dev strs .. 6   (offset: 0x1904)
// exports ... 20  (offset: 0xe78)
// cseg ...... 0x1ce + 0xcaa (0xe78)
// imports ... 51  (offset: 0x1198)
// animtree1 . 0   (offset: 0x1950)
// animtree2 . 0   (offset: 0x1950)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\utility;
#using scripts\mp\common\killstreaks\mutant_injection_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\operator;

#namespace mutant_injection_disciple;

// Namespace mutant_injection_disciple
// Params 0, eflags: 0x1
// Checksum 0x84d5c5c, Offset: 0x1ec
// Size: 0x17
function autoexec main()
{
    killstreak_shared::registerkillstreakinitfunction( #"zm_dinj", &init );
}

// Namespace mutant_injection_disciple
// Params 0
// Checksum 0xbbd8a6f5, Offset: 0x20b
// Size: 0x4e
function init()
{
    initkillstreak();
    level callback::add( #"on_ai_killed", &on_ai_killed );
    level utility::registersharedfunc( #"zm_dinj", #"get_weapon_name", &get_dinj_weapon_name );
    mutant_injection_utility::init( #"zm_dinj" );
}

// Namespace mutant_injection_disciple
// Params 1, eflags: 0x4
// Checksum 0x3006158, Offset: 0x261
// Size: 0x7f
function private onavailable( streakitem )
{
    bundle = level.streakglobals.streakbundles[ "zm_dinj" ];
    
    if ( bundle.mutantinjectiondata.var_46baaf51940dbaae != "" )
    {
        namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( "zm_dinj", utility::get_scripted_weapon_name( bundle.mutantinjectiondata.var_46baaf51940dbaae ), #"low" );
    }
}

// Namespace mutant_injection_disciple
// Params 1, eflags: 0x4
// Checksum 0xad9133d0, Offset: 0x2e8
// Size: 0xff, Type: bool
function private tryusemutantinjection( streakinfo )
{
    config = getconfig();
    assert( isdefined( config ), "<dev string:x24>" );
    setcontext( config, streakinfo );
    assert( isdefined( self.micontext ), "<dev string:x62>" );
    self.mutant_injection_start_time = undefined;
    
    if ( !mutant_injection_utility::canactivate( streakinfo.streakname ) )
    {
        return false;
    }
    
    if ( !makemutantinjection( streakinfo.mpstreaksysteminfo.skipdeployanimation ) )
    {
        return false;
    }
    
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    /#
        if ( self.var_d43bbb33841dcc9d )
        {
            self.var_d43bbb33841dcc9d = undefined;
        }
    #/
    
    thread mutant_injection_utility::watchmutantinjection( &function_14be0963e56d73dc, &exitcallback );
    return true;
}

// Namespace mutant_injection_disciple
// Params 0, eflags: 0x4
// Checksum 0x3bcaa34f, Offset: 0x3f0
// Size: 0x5b
function private initkillstreak()
{
    if ( utility::issharedfuncdefined( #"killstreak", #"registerkillstreak" ) )
    {
        self [[ utility::getsharedfunc( #"killstreak", #"registerkillstreak" ) ]]( "zm_dinj", &tryusemutantinjection, &onavailable );
    }
    
    killstreak_utility::registervisibilityomnvarforkillstreak( "zm_dinj", "on", 28 );
}

// Namespace mutant_injection_disciple
// Params 1, eflags: 0x4
// Checksum 0x7c94c23f, Offset: 0x453
// Size: 0x6a
function private function_14be0963e56d73dc( params )
{
    bundle = level.streakglobals.streakbundles[ "zm_dinj" ];
    
    if ( bundle.mutantinjectiondata.soundsubmix != "" )
    {
        self setsoundsubmix( bundle.mutantinjectiondata.soundsubmix );
    }
}

// Namespace mutant_injection_disciple
// Params 1, eflags: 0x4
// Checksum 0x194a4b19, Offset: 0x4c5
// Size: 0x6a
function private exitcallback( params )
{
    bundle = level.streakglobals.streakbundles[ "zm_dinj" ];
    
    if ( bundle.mutantinjectiondata.soundsubmix != "" )
    {
        self clearsoundsubmix( bundle.mutantinjectiondata.soundsubmix );
    }
}

// Namespace mutant_injection_disciple
// Params 2, eflags: 0x4
// Checksum 0x30caad13, Offset: 0x537
// Size: 0x1ca
function private setcontext( miconfig, streakinfo )
{
    bundle = level.streakglobals.streakbundles[ "zm_dinj" ];
    assert( bundle.mutantinjectiondata.var_46baaf51940dbaae != "<dev string:xa5>", "<dev string:xa6>" );
    mutant_injection_utility::function_64a3fcac1c224b2c( miconfig, streakinfo, #"zm_dinj", bundle.mutantinjectiondata.var_46baaf51940dbaae );
    assert( isdefined( self.micontext ), "<dev string:x62>" );
    self.micontext.mi_omnvar = "is_zm_minj";
    self.micontext.var_be28f4c5f7e79a1 = "is_zm_minj_sprint";
    self.micontext.transform_in_part = "zm_dinj_transform_in";
    self.micontext.deep_water_transform_cam_part = "deep_water_transform_cam";
    self.micontext.sprint_vfx_part = "sprint_vfx";
    self.micontext.var_8152e2282f3b3caa = &function_8152e2282f3b3caa;
    self.micontext.var_8f3bcdac5d9009b = &function_8f3bcdac5d9009b;
    self.micontext.var_e38f13b5654b5514 = &function_e38f13b5654b5514;
    self.micontext.var_3dad763ff705788d = &function_3dad763ff705788d;
    self.micontext.var_b602c5d0276c5b6 = &function_b602c5d0276c5b6;
    self.micontext.var_20a634c3d7f708bf = &function_acf106534287e588;
    self.micontext.var_69224c24ef535a12 = 1;
}

// Namespace mutant_injection_disciple
// Params 1, eflags: 0x4
// Checksum 0x17b2f533, Offset: 0x709
// Size: 0x19c, Type: bool
function private makemutantinjection( skipdeployanimation = 0 )
{
    bundle = level.streakglobals.streakbundles[ "zm_dinj" ];
    assert( isdefined( bundle.mutantinjectiondata.operator ), "<dev string:xf4>" );
    operator = bundle.mutantinjectiondata.operator;
    operatorrefs = operator::getoperatorrefs();
    
    if ( operator && !isdefined( operatorrefs[ operator ] ) )
    {
        operator::function_449035ab2454100( operator );
    }
    
    allows = [];
    allows[ "disallow_loot_but_auto_loot" ] = 1;
    allows[ "damage" ] = 0;
    mutant_injection_utility::function_cfe6a5fed7778f67( allows, 0 );
    
    if ( !skipdeployanimation )
    {
        deployresult = namespace_9d8e359c3b1041e5::streakdeploy_doweaponswitchdeploysharedfunc( self.micontext.streakinfo, self.micontext.deployweaponobj, 1 );
        
        if ( !deployresult )
        {
            mutant_injection_utility::function_cfe6a5fed7778f67( allows, 1 );
            return false;
        }
    }
    
    if ( namespace_9d8e359c3b1041e5::issuperinusesharedfunc() )
    {
        if ( utility::issharedfuncdefined( #"supers", #"superusefinished" ) )
        {
            self thread [[ utility::getsharedfunc( #"supers", #"superusefinished" ) ]]( 0, 0, 1 );
        }
    }
    
    thread starttransformation( skipdeployanimation );
    self.streakinfo = self.micontext.streakinfo;
    self.streakinfo.kills = 0;
    return true;
}

// Namespace mutant_injection_disciple
// Params 1, eflags: 0x4
// Checksum 0x959883fd, Offset: 0x8ae
// Size: 0x12b
function private starttransformation( skipdeployanimation = 0 )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    bundle = level.streakglobals.streakbundles[ "zm_dinj" ];
    operator_skin = bundle.mutantinjectiondata.operatorskin;
    suit = level.var_75c7b100ae39fcf1 ?? bundle.mutantinjectiondata.suit;
    assert( isdefined( suit ) && isdefined( operator_skin ), "<dev string:x131>" );
    mutant_injection_utility::starttransformation( operator_skin );
    
    if ( !skipdeployanimation )
    {
        var_d854877d78da6f90 = bundle.mutantinjectiondata.var_d854877d78da6f90;
        xanim = var_d854877d78da6f90.id;
        need_exit = !mutant_injection_utility::function_f247f77ac7ba541a( self.micontext.deployweaponobj, xanim );
    }
    else
    {
        need_exit = 0;
    }
    
    mutant_injection_utility::function_8b2421e41e3a9eb1( need_exit, suit, operator_skin );
}

// Namespace mutant_injection_disciple
// Params 1, eflags: 0x4
// Checksum 0x53e0ac9f, Offset: 0x9e1
// Size: 0xd7
function private function_8152e2282f3b3caa( params )
{
    bundle = level.streakglobals.streakbundles[ "zm_dinj" ];
    var_52e62810914f1014 = bundle.mutantinjectiondata.var_d85d937d78e4a8a2;
    xanim = var_52e62810914f1014.id;
    aliasname = getanimname( var_52e62810914f1014.id );
    utility::function_32b24db3127bff40( "zm_dinj_transform_in", "vfx_on" );
    utility::function_32b24db3127bff40( "zm_dinj_ambient_vfx", "vfx_on" );
    self playanimscriptsceneevent( "scripted_scene", aliasname, 0 );
    transform_time = getanimlength( xanim );
    msg = utility::waittill_any_timeout( transform_time, "mutant_injecton_instant_exit" );
    return msg;
}

// Namespace mutant_injection_disciple
// Params 1, eflags: 0x4
// Checksum 0x83330c05, Offset: 0xac1
// Size: 0xf9
function private function_8f3bcdac5d9009b( params )
{
    if ( utility::issharedfuncdefined( self.micontext.var_d31dc7187a8cc4db, #"drainlife" ) )
    {
        self [[ utility::getsharedfunc( self.micontext.var_d31dc7187a8cc4db, #"drainlife" ) ]]();
    }
    
    if ( utility::issharedfuncdefined( self.micontext.var_d31dc7187a8cc4db, #"hash_25813f7a5a02ae90" ) )
    {
        self [[ utility::getsharedfunc( self.micontext.var_d31dc7187a8cc4db, #"hash_25813f7a5a02ae90" ) ]]();
    }
    
    if ( utility::issharedfuncdefined( self.micontext.var_d31dc7187a8cc4db, #"scream" ) )
    {
        self [[ utility::getsharedfunc( self.micontext.var_d31dc7187a8cc4db, #"scream" ) ]]();
    }
    
    utility::ent_flag_set( "is_mutant_injection_disciple" );
}

// Namespace mutant_injection_disciple
// Params 2, eflags: 0x4
// Checksum 0x427a7afd, Offset: 0xbc2
// Size: 0x43
function private function_e38f13b5654b5514( istimeout, skipanimation )
{
    utility::function_32b24db3127bff40( "sprint_vfx", "off" );
    utility::function_32b24db3127bff40( "zm_dinj_ambient_vfx", "off" );
    utility::ent_flag_clear( "is_mutant_injection_disciple" );
}

// Namespace mutant_injection_disciple
// Params 1, eflags: 0x4
// Checksum 0x8e1134fe, Offset: 0xc0d
// Size: 0xc6
function private function_3dad763ff705788d( params )
{
    utility::function_32b24db3127bff40( "zm_dinj_transform_out", "vfx_on" );
    bundle = level.streakglobals.streakbundles[ "zm_dinj" ];
    var_6fe663f3fb948213 = bundle.mutantinjectiondata.var_b499cb2de0e829f;
    xanim = var_6fe663f3fb948213.id;
    aliasname = getanimname( var_6fe663f3fb948213.id );
    self playanimscriptsceneevent( "scripted_scene", aliasname, 0 );
    transform_time = getanimlength( xanim );
    msg = utility::waittill_any_timeout( transform_time, "mutant_injecton_instant_exit" );
    return msg;
}

// Namespace mutant_injection_disciple
// Params 1, eflags: 0x4
// Checksum 0x3b4381d3, Offset: 0xcdc
// Size: 0x2b
function private function_b602c5d0276c5b6( params )
{
    if ( params.var_647d934381f24be2 )
    {
        utility::function_32b24db3127bff40( "zm_dinj_transform_end", "vfx_on" );
    }
}

// Namespace mutant_injection_disciple
// Params 0, eflags: 0x4
// Checksum 0xcb916ebe, Offset: 0xd0f
// Size: 0x3a
function private getconfig()
{
    if ( !isdefined( config ) )
    {
        config = {};
    }
    
    config = mutant_injection_utility::function_a4d6e1d92b3d3491( config, #"zm_dinj" );
    config.pre_allows[ "mantle" ] = undefined;
    return config;
}

// Namespace mutant_injection_disciple
// Params 0
// Checksum 0xfe0046ec, Offset: 0xd52
// Size: 0x11
function get_dinj_weapon_name()
{
    return utility::get_scripted_weapon_name( #"mutant_injection_disciple" );
}

// Namespace mutant_injection_disciple
// Params 1, eflags: 0x4
// Checksum 0xfa2f4525, Offset: 0xd6c
// Size: 0xb2
function private on_ai_killed( params )
{
    if ( isdefined( params.eattacker ) && params.eattacker.ismutantinjection )
    {
        if ( params.eattacker.streakinfo.streakname != "zm_dinj" )
        {
            return;
        }
        
        if ( isdefined( params.eattacker.streakinfo.kills ) )
        {
            params.eattacker.streakinfo.kills++;
        }
        
        params.eattacker thread mutant_injection_utility::function_2c5f5babb946cfc7();
    }
}

// Namespace mutant_injection_disciple
// Params 1, eflags: 0x4
// Checksum 0xecfe43e9, Offset: 0xe26
// Size: 0x52
function private function_acf106534287e588( params )
{
    if ( params.isactive )
    {
        self.game_extrainfo |= 134217728;
        return;
    }
    
    self.game_extrainfo &= ~int( 134217728 );
}

