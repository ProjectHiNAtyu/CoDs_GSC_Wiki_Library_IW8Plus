// scripts\mp\common\utility\gameplay_telemetry_utils.gsc  (hash_124cc8e9fbd972b9.gscc) (size: 5046 Bytes / 0x13b6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3220e7e8 (841017320)
// size ...... 5046 (0x13b6)
// includes .. 4   (offset: 0x12f6)
// strings ... 10  (offset: 0x1316)
// dev strs .. 2   (offset: 0x139e)
// exports ... 20  (offset: 0xc42)
// cseg ...... 0x119 + 0xb29 (0xc42)
// imports ... 30  (offset: 0xf62)
// animtree1 . 0   (offset: 0x13b6)
// animtree2 . 0   (offset: 0x13b6)
#using scripts\common\utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\gamelogic;

#namespace gameplay_telemetry_utils;

// Namespace gameplay_telemetry_utils
// Params 1
// Checksum 0x64d2d275, Offset: 0x137
// Size: 0xed
function function_ab5801f54c55eee8( var_c726feff36c500a2 )
{
    if ( !( self.var_f3f3e16847bb9f5e ?? function_f78eef1203724422() ) )
    {
        return 0;
    }
    
    if ( isint( var_c726feff36c500a2 ) )
    {
        return ( var_c726feff36c500a2 & level.var_bd8514fd3f70e2f1 );
    }
    
    if ( isarray( var_c726feff36c500a2 ) )
    {
        assertmsg( "<dev string:x24>" );
        
        switch ( level.var_bd8514fd3f70e2f1 )
        {
            case 2:
                statsmode = #"br";
                break;
            case 8:
                statsmode = #"ob";
                break;
            case 1:
                statsmode = #"mp";
                break;
            case 4:
                statsmode = #"zm";
                break;
        }
        
        return arraycontains( var_c726feff36c500a2, statsmode );
    }
    
    assert( !isdefined( var_c726feff36c500a2 ), "<dev string:x61>" );
    return 0;
}

// Namespace gameplay_telemetry_utils
// Params 0
// Checksum 0x6223f650, Offset: 0x22d
// Size: 0x33, Type: bool
function function_9f6656b47d8779ee()
{
    if ( getdvarint( @"scr_telemetry_gameplay", 1 ) == 0 )
    {
        return false;
    }
    
    if ( utility::issp() )
    {
        return false;
    }
    
    if ( level.istrainingcourse )
    {
        return false;
    }
    
    return true;
}

// Namespace gameplay_telemetry_utils
// Params 1
// Checksum 0x16f105ee, Offset: 0x269
// Size: 0x6e, Type: bool
function function_944c6d9098e40dfb( victim )
{
    if ( !( self.var_f3f3e16847bb9f5e ?? function_f78eef1203724422() ) )
    {
        return false;
    }
    
    if ( getdvarint( @"hash_d54a42b2ebad49af", 0 ) == 1 )
    {
        return true;
    }
    
    if ( isplayer( victim ) || isbot( victim ) )
    {
        return true;
    }
    
    if ( isagent( victim ) && level.var_bd8514fd3f70e2f1 == 8 )
    {
        return true;
    }
    
    return false;
}

// Namespace gameplay_telemetry_utils
// Params 0
// Checksum 0xbad7091, Offset: 0x2e0
// Size: 0x83
function function_f78eef1203724422()
{
    var_7237854e3be197ca = self.var_f3f3e16847bb9f5e;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    if ( !isdefined( self ) )
    {
        return 0;
    }
    
    if ( isai( self ) || !isplayer( self ) )
    {
        self.var_f3f3e16847bb9f5e = 0;
        return 0;
    }
    
    if ( !function_9f6656b47d8779ee() )
    {
        self.var_f3f3e16847bb9f5e = 0;
        return 0;
    }
    
    if ( gamelogic_mp::inprematch() && isbrgamemode() )
    {
        return 0;
    }
    
    self.var_f3f3e16847bb9f5e = 1;
    return self.var_f3f3e16847bb9f5e;
}

// Namespace gameplay_telemetry_utils
// Params 4
// Checksum 0xa418b140, Offset: 0x36c
// Size: 0xa1
function function_c7f73c82e4054e10( var_7e2e012bec81f493, omnvarname, value = 1, var_7641799389b97b6d )
{
    self endon( #"disconnect" );
    
    if ( !( self.var_f3f3e16847bb9f5e ?? function_f78eef1203724422() ) )
    {
        return;
    }
    
    if ( !isdefined( self.pers[ var_7e2e012bec81f493 ] ) )
    {
        self.pers[ var_7e2e012bec81f493 ] = 0;
    }
    
    self.pers[ var_7e2e012bec81f493 ] += value;
    function_e142f5a45733e061( self.pers[ var_7e2e012bec81f493 ], omnvarname, var_7641799389b97b6d );
}

// Namespace gameplay_telemetry_utils
// Params 4
// Checksum 0xfe76ac9d, Offset: 0x415
// Size: 0x91
function function_46061476250367dd( var_7e2e012bec81f493, omnvarname, value, var_7641799389b97b6d )
{
    self endon( #"disconnect" );
    
    if ( !( self.var_f3f3e16847bb9f5e ?? function_f78eef1203724422() ) )
    {
        return;
    }
    
    if ( !value )
    {
        return;
    }
    
    if ( !isdefined( self.pers[ var_7e2e012bec81f493 ] ) )
    {
        self.pers[ var_7e2e012bec81f493 ] = 0;
    }
    
    self.pers[ var_7e2e012bec81f493 ] = value;
    function_e142f5a45733e061( self.pers[ var_7e2e012bec81f493 ], omnvarname, var_7641799389b97b6d );
}

// Namespace gameplay_telemetry_utils
// Params 5
// Checksum 0x6403463a, Offset: 0x4ae
// Size: 0xd2
function function_272e03c2ab47fa34( var_7e2e012bec81f493, weaponname, omnvarname, value = 1, var_7641799389b97b6d )
{
    self endon( #"disconnect" );
    
    if ( !( self.var_f3f3e16847bb9f5e ?? function_f78eef1203724422() ) )
    {
        return;
    }
    
    if ( !isdefined( self.pers[ var_7e2e012bec81f493 ] ) )
    {
        self.pers[ var_7e2e012bec81f493 ] = [];
    }
    
    if ( !isdefined( self.pers[ var_7e2e012bec81f493 ][ weaponname ] ) )
    {
        self.pers[ var_7e2e012bec81f493 ][ weaponname ] = 0;
    }
    
    self.pers[ var_7e2e012bec81f493 ][ weaponname ] += value;
    function_e142f5a45733e061( self.pers[ var_7e2e012bec81f493 ][ weaponname ], omnvarname, var_7641799389b97b6d );
}

// Namespace gameplay_telemetry_utils
// Params 5
// Checksum 0xee279fc9, Offset: 0x588
// Size: 0x92
function function_aa2d78134e623dd9( var_7e2e012bec81f493, weaponname, omnvarname, value, var_7641799389b97b6d )
{
    self endon( #"disconnect" );
    
    if ( !( self.var_f3f3e16847bb9f5e ?? function_f78eef1203724422() ) )
    {
        return;
    }
    
    if ( !value )
    {
        return;
    }
    
    if ( !isdefined( self.pers[ var_7e2e012bec81f493 ] ) )
    {
        self.pers[ var_7e2e012bec81f493 ] = [];
    }
    
    self.pers[ var_7e2e012bec81f493 ][ weaponname ] = value;
    function_e142f5a45733e061( value, omnvarname, var_7641799389b97b6d );
}

// Namespace gameplay_telemetry_utils
// Params 1, eflags: 0x4
// Checksum 0xec969c83, Offset: 0x622
// Size: 0x62
function private function_1ba499b14e24ecd2( slotindex )
{
    switch ( slotindex ?? 0 )
    {
        case 2:
            return "sec";
        case 3:
            return "ter";
        case 4:
            return "mule";
        default:
            return "pri";
    }
}

// Namespace gameplay_telemetry_utils
// Params 1, eflags: 0x4
// Checksum 0x32863d15, Offset: 0x68c
// Size: 0x72
function private function_1440e7a749a1d447( slotindex )
{
    switch ( slotindex ?? 0 )
    {
        case 2:
            return o"ui_gameplay_telemetry_sec_";
        case 3:
            return o"ui_gameplay_telemetry_ter_";
        case 4:
            return o"ui_gameplay_telemetry_mule_";
        default:
            return o"ui_gameplay_telemetry_pri_";
    }
}

// Namespace gameplay_telemetry_utils
// Params 1
// Checksum 0xc276c287, Offset: 0x706
// Size: 0x72
function function_138547b76fca2153( var_7e2e012bec81f493 )
{
    var_1312881f0ca313c9 = isdefined( self.pers[ var_7e2e012bec81f493 ] ) ?? 0;
    omnvarname = "ui_gameplay_telemetry_" + var_7e2e012bec81f493;
    
    if ( self function_5c766d1d0140b86( omnvarname ) )
    {
        range = getomnvarrange( omnvarname );
        
        if ( range )
        {
            var_1312881f0ca313c9 = clamp( var_1312881f0ca313c9, range[ 0 ], range[ 1 ] );
        }
        
        self setclientomnvar( omnvarname, var_1312881f0ca313c9 );
    }
}

// Namespace gameplay_telemetry_utils
// Params 2
// Checksum 0xf9682d56, Offset: 0x780
// Size: 0xf1
function function_393d5636f0bd5c27( var_7e2e012bec81f493, weapons )
{
    if ( !isdefined( self.pers[ var_7e2e012bec81f493 ] ) )
    {
        self.pers[ var_7e2e012bec81f493 ] = [];
    }
    
    var_d396eb51a31fb313 = 0;
    
    foreach ( playerweapon in weapons )
    {
        var_d396eb51a31fb313++;
        omnvarname = hashcat( function_1440e7a749a1d447( var_d396eb51a31fb313 ), var_7e2e012bec81f493 );
        
        if ( self function_5c766d1d0140b86( omnvarname ) )
        {
            self setclientomnvar( omnvarname, self.pers[ var_7e2e012bec81f493 ][ playerweapon.basename ] ?? 0, 1 );
        }
    }
}

// Namespace gameplay_telemetry_utils
// Params 3, eflags: 0x4
// Checksum 0xdd953acd, Offset: 0x879
// Size: 0x4d
function private function_e142f5a45733e061( result, omnvarname, var_7641799389b97b6d = 1 )
{
    if ( !self function_5c766d1d0140b86( omnvarname ) )
    {
        return;
    }
    
    self setclientomnvar( omnvarname, var_7641799389b97b6d ? int( result ) : result, 1 );
}

// Namespace gameplay_telemetry_utils
// Params 1
// Checksum 0x4a6adf0a, Offset: 0x8ce
// Size: 0x91
function function_87e071d9cdce86a7( current_weapon_basename )
{
    if ( self.var_603514195edd5aa6.basename == current_weapon_basename )
    {
        return "pri";
    }
    
    if ( self.var_ebc72ab4e92da81a.basename == current_weapon_basename )
    {
        return "sec";
    }
    
    if ( self.var_e8ffb5dcbfc1952a.basename == current_weapon_basename )
    {
        return "ter";
    }
    
    if ( self.var_3bf72dcd2775aa78.basename == current_weapon_basename )
    {
        return "mule";
    }
}

// Namespace gameplay_telemetry_utils
// Params 1
// Checksum 0x7e00702, Offset: 0x968
// Size: 0x91
function function_8437da42a22966b4( current_weapon_basename )
{
    if ( self.var_603514195edd5aa6.basename == current_weapon_basename )
    {
        return "ui_gameplay_telemetry_pri_";
    }
    
    if ( self.var_ebc72ab4e92da81a.basename == current_weapon_basename )
    {
        return "ui_gameplay_telemetry_sec_";
    }
    
    if ( self.var_e8ffb5dcbfc1952a.basename == current_weapon_basename )
    {
        return "ui_gameplay_telemetry_ter_";
    }
    
    if ( self.var_3bf72dcd2775aa78.basename == current_weapon_basename )
    {
        return "ui_gameplay_telemetry_mule_";
    }
}

// Namespace gameplay_telemetry_utils
// Params 0
// Checksum 0x9ea5332c, Offset: 0xa02
// Size: 0x91
function function_8f71c8ffb480ebc3()
{
    if ( !isplayer( self ) || isai( self ) )
    {
        return 0;
    }
    
    currentscore = level.teambased ? self.score : self.pers[ "gamemodeScore" ];
    
    if ( !isdefined( currentscore ) )
    {
        return 0;
    }
    
    minutespassed = game_utility_mp::getgamelength() / 60000;
    
    if ( minutespassed <= 0 )
    {
        return 0;
    }
    
    spm = currentscore / minutespassed;
    
    if ( spm > 100000 )
    {
        spm = 100000;
    }
    
    return spm;
}

// Namespace gameplay_telemetry_utils
// Params 3
// Checksum 0xb3285d0b, Offset: 0xa9c
// Size: 0x61
function function_7e116413984d3a47( primaryweaponobj, secondaryweaponobj, var_cc1262e66dbb1c79 )
{
    if ( !( self.var_f3f3e16847bb9f5e ?? function_f78eef1203724422() ) )
    {
        return;
    }
    
    self.var_1933958cb3f38a47 = primaryweaponobj;
    self.var_8aa3e89e1457f783 = secondaryweaponobj;
    self.var_802dab83a7e79e8d = var_cc1262e66dbb1c79;
    function_36707ddf39464a70( primaryweaponobj, secondaryweaponobj, var_cc1262e66dbb1c79 );
}

// Namespace gameplay_telemetry_utils
// Params 3
// Checksum 0x779458b6, Offset: 0xb05
// Size: 0x71
function function_36707ddf39464a70( primaryweaponobj, secondaryweaponobj, var_cc1262e66dbb1c79 )
{
    if ( !( self.var_f3f3e16847bb9f5e ?? function_f78eef1203724422() ) )
    {
        return;
    }
    
    self.var_603514195edd5aa6 = primaryweaponobj ?? self function_a4f068798d87b7ea( 0 );
    self.var_ebc72ab4e92da81a = secondaryweaponobj ?? self function_a4f068798d87b7ea( 1 );
    self.var_e8ffb5dcbfc1952a = var_cc1262e66dbb1c79 ?? self getweaponmeleeslot();
}

// Namespace gameplay_telemetry_utils
// Params 1
// Checksum 0xcdb9970, Offset: 0xb7e
// Size: 0xc3
function function_7e422cf7672bb058( isendgame )
{
    var_9dbeba9a26baf851 = self.var_603514195edd5aa6;
    var_b24ccbd57c90e821 = self.var_ebc72ab4e92da81a;
    var_adf051cfec55aa81 = self.var_e8ffb5dcbfc1952a;
    var_388092cb2ca04058 = self.var_3bf72dcd2775aa78;
    
    if ( isendgame )
    {
        if ( isbrgamemode() )
        {
            var_9dbeba9a26baf851 = self.weapon_most_kills;
            var_b24ccbd57c90e821 = self.var_cdc77dd39cc1462e;
        }
        else if ( !game_utility::function_6131f69cfe56ed90() )
        {
            var_9dbeba9a26baf851 = self.var_1933958cb3f38a47;
            var_b24ccbd57c90e821 = self.var_8aa3e89e1457f783;
            var_adf051cfec55aa81 = self.var_802dab83a7e79e8d;
        }
    }
    
    return [ var_9dbeba9a26baf851, var_b24ccbd57c90e821, var_adf051cfec55aa81, var_388092cb2ca04058 ];
}

