// scripts\mp\common\supers\stealth_perks.gsc  (hash_7adc9c925d870bfc.gscc) (size: 5247 Bytes / 0x147f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xea1c4121 (3927720225)
// size ...... 5247 (0x147f)
// includes .. 11  (offset: 0x1373)
// strings ... 9   (offset: 0x13cb)
// dev strs .. 2   (offset: 0x1467)
// exports ... 17  (offset: 0xb1f)
// cseg ...... 0x162 + 0x9bd (0xb1f)
// imports ... 49  (offset: 0xdc7)
// animtree1 . 0   (offset: 0x147f)
// animtree2 . 0   (offset: 0x147f)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\emp_debuff;
#using scripts\mp\supers;
#using scripts\mp\telemetry_mp;

#namespace stealth_perks;

// Namespace stealth_perks
// Params 0, eflags: 0x5
// Checksum 0xe07df4cb, Offset: 0x180
// Size: 0x18
function private autoexec main()
{
    level callback::add( #"register_super", &register );
}

// Namespace stealth_perks
// Params 1, eflags: 0x4
// Checksum 0x4460744d, Offset: 0x1a0
// Size: 0xa0
function private register( params )
{
    staticdata = level.superglobals.staticsuperdata[ "super_stealth_perks" ];
    
    if ( !isdefined( staticdata ) )
    {
        return;
    }
    
    bundle = staticdata.bundle;
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    supers_mp::function_48aaa60b2ce7b8a1( "super_stealth_perks", &on_set, &on_unset, &begin_use, &natural_timeout, undefined, undefined, undefined );
    supers_mp::function_19492daedcf2689a( "super_stealth_perks", &get_use_time );
    level callback::add( #"player_death", &on_player_death );
}

// Namespace stealth_perks
// Params 1
// Checksum 0x9518a057, Offset: 0x248
// Size: 0x5a
function on_player_death( params )
{
    if ( ( isplayer( params.attacker ) || isagent( params.attacker ) ) && params.attacker is_stealth_perks_in_use() )
    {
        params.attacker award_kill( params );
    }
}

// Namespace stealth_perks
// Params 0
// Checksum 0x2a124494, Offset: 0x2aa
// Size: 0x18, Type: bool
function is_stealth_perks_in_use()
{
    return supers_mp::getcurrentsuperref() == "super_stealth_perks" && supers_mp::issuperinuse();
}

// Namespace stealth_perks
// Params 0
// Checksum 0xe87c011, Offset: 0x2cb
// Size: 0x2
function on_set()
{
    
}

// Namespace stealth_perks
// Params 0
// Checksum 0x53f8058e, Offset: 0x2d5
// Size: 0x2
function on_unset()
{
    
}

// Namespace stealth_perks
// Params 0
// Checksum 0x39eac6a2, Offset: 0x2df
// Size: 0x71, Type: bool
function begin_use()
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_stealth_perks" );
    assert( isdefined( bundle ), "<dev string:x24>" );
    result = utility::waittill_any_in_array_or_timeout( [ "death", "disconnect" ], 0.2121 );
    
    if ( result != "timeout" )
    {
        return false;
    }
    
    self.var_7eba2618f941d234 = 0;
    activate();
    return true;
}

// Namespace stealth_perks
// Params 1
// Checksum 0x5ab741f0, Offset: 0x359
// Size: 0xb0
function get_use_time( superinfo )
{
    bonusduration = 0;
    bundle = level.superglobals.staticsuperdata[ "super_stealth_perks" ].bundle;
    
    if ( bundle.var_c7709714d768097c && supers_mp::function_d45945781d29204a( "super_stealth_perks", bundle.var_c7709714d768097c ) )
    {
        assert( bundle.var_cd182e5bd9f80bea, "<dev string:x81>" );
        bonusduration = bundle.var_cd182e5bd9f80bea ?? 10;
    }
    
    return superinfo.staticdata.usetime + bonusduration;
}

// Namespace stealth_perks
// Params 2
// Checksum 0x932153cd, Offset: 0x412
// Size: 0x1c
function natural_timeout( fromdeath, attacker )
{
    deactivate();
}

// Namespace stealth_perks
// Params 0
// Checksum 0xb0dcf65b, Offset: 0x436
// Size: 0x39
function create_overlay()
{
    [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_382df7654f0561bd" ] ]]( { #postfxbundlename:%"sat_mp_stealth_perks" }, 1, 1 );
}

// Namespace stealth_perks
// Params 0
// Checksum 0xe0b840ac, Offset: 0x477
// Size: 0x35
function clear_overlay()
{
    [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_494b07757cd511a5" ] ]]( { #postfxbundlename:%"sat_mp_stealth_perks" } );
}

// Namespace stealth_perks
// Params 1
// Checksum 0xf098db77, Offset: 0x4b4
// Size: 0x183
function award_kill( params )
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_stealth_perks" );
    extend_duration_time = bundle.var_1ea280707fa9126b ?? 4;
    objweapon = params.objweapon;
    
    if ( !weapon_utility::isbulletweapon( objweapon ) && !weapon::function_1344ad15d2d7bd21( objweapon ) )
    {
        if ( weapon::iskillstreakweapon( objweapon ) )
        {
            return;
        }
        
        if ( weapon_utility::function_c1972d0d01397a22( objweapon ) || weapon_utility::function_186e07887b6bbeb1( objweapon ) )
        {
            return;
        }
        
        isthrowingknife = weapon::function_e1a6c47f66c6de20( objweapon );
        
        if ( ( weapon_utility::isgrenadeweapon( objweapon ) || weapon_utility::isoffhandweapon( objweapon ) ) && !isthrowingknife )
        {
            return;
        }
        
        switch ( params.meansofdeath )
        {
            case #"hash_19fbc34dda39832e":
            case #"hash_1b5395c651f95456":
            case #"hash_61e42661ac27b9f2":
            case #"hash_a5123f4d02745600":
                break;
            default:
                if ( !isthrowingknife )
                {
                    return;
                }
                
                break;
        }
    }
    
    self.var_7eba2618f941d234++;
    
    if ( self.var_7eba2618f941d234 == 3 )
    {
        thread points::doscoreevent( #"sound_veil_triple" );
    }
    
    thread points::function_f8a0deb1a12da52e( #"sound_veil_kill", undefined, bundle.lootid );
    self stoplocalsound( "fup_mute_field_extend_plr" );
    self playlocalsound( "fup_mute_field_extend_plr" );
    supers_mp::function_9f116b8da4a01a94( extend_duration_time );
}

// Namespace stealth_perks
// Params 0
// Checksum 0x21038efd, Offset: 0x63f
// Size: 0x1a6
function activate()
{
    self.stealth_perks_to_remove = [];
    superinfo = supers_mp::getcurrentsuper();
    var_50ea59bb1ee006a2 = superinfo.staticdata.objweapon;
    telemetry_mp::function_80a95f340a7c8f67( self, self, var_50ea59bb1ee006a2, 0 );
    
    foreach ( stealth_perk in [ "specialty_canvas_sneakers", "specialty_ghost", "specialty_coldblooded_and_hidden" ] )
    {
        if ( isdefined( self.perks[ stealth_perk ] ) )
        {
            continue;
        }
        
        perk::giveperk( stealth_perk );
        self.stealth_perks_to_remove[ self.stealth_perks_to_remove.size ] = stealth_perk;
    }
    
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_stealth_perks" );
    
    if ( bundle.var_e36b84555e7df1d3 && supers_mp::function_d45945781d29204a( "super_stealth_perks", bundle.var_e36b84555e7df1d3 ) )
    {
        player::function_e4f77222086e66b( 1 );
    }
    
    create_overlay();
    emp_disable_effect = bundle.var_69f6dbcc11db6bb ?? 0;
    
    if ( emp_disable_effect )
    {
        function_66ceeedaef99bfea( bundle.var_300c083dcc2e6224 ?? 0 );
    }
    
    self.var_d342c9285c347435 = 1;
    self setscriptablepartstate( #"stealth_perks", #"on", 0 );
}

// Namespace stealth_perks
// Params 1, eflags: 0x4
// Checksum 0x7db32e58, Offset: 0x7ed
// Size: 0x26
function private function_66ceeedaef99bfea( duration )
{
    emp_debuff::add_emp_ent( self );
    self.var_300c083dcc2e6224 = duration;
    thread function_d954a3bcacba390a();
}

// Namespace stealth_perks
// Params 0, eflags: 0x4
// Checksum 0x9f34d0c3, Offset: 0x81b
// Size: 0x1a0
function private function_d954a3bcacba390a()
{
    self endon( #"stealth_perks_end" );
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        self waittill( #"emp_applied" );
        self.var_fd27fa43eb22014c = 1;
        
        foreach ( var_36ce6004adc672c3 in self.stealth_perks_to_remove )
        {
            perk::removeperk( var_36ce6004adc672c3 );
        }
        
        clear_overlay();
        self setscriptablepartstate( #"stealth_perks", #"off", 0 );
        
        if ( self.var_300c083dcc2e6224 > 0 )
        {
            wait self.var_300c083dcc2e6224;
        }
        else
        {
            self waittill( #"emp_removed" );
        }
        
        self.var_fd27fa43eb22014c = undefined;
        
        foreach ( var_163a13774caef3d5 in self.stealth_perks_to_remove )
        {
            perk::giveperk( var_163a13774caef3d5 );
        }
        
        create_overlay();
        self setscriptablepartstate( #"stealth_perks", #"on", 0 );
    }
}

// Namespace stealth_perks
// Params 0
// Checksum 0x92163757, Offset: 0x9c3
// Size: 0x15c
function deactivate()
{
    superinfo = supers_mp::getcurrentsuper();
    var_50ea59bb1ee006a2 = superinfo.staticdata.objweapon;
    telemetry_mp::function_c4080f7bf60d4131( self, var_50ea59bb1ee006a2, 0 );
    
    foreach ( var_36ce6004adc672c3 in self.stealth_perks_to_remove )
    {
        perk::removeperk( var_36ce6004adc672c3 );
    }
    
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_stealth_perks" );
    
    if ( bundle.var_e36b84555e7df1d3 && supers_mp::function_d45945781d29204a( "super_stealth_perks", bundle.var_e36b84555e7df1d3 ) )
    {
        player::function_e4f77222086e66b( 0 );
    }
    
    clear_overlay();
    self.stealth_perks_to_remove = undefined;
    self notify( #"stealth_perks_end" );
    self.var_7eba2618f941d234 = undefined;
    self.var_d342c9285c347435 = undefined;
    self.var_9f977223c1d2bf5 = gettime();
    self playlocalsound( "fup_mute_field_end_plr" );
    self setscriptablepartstate( #"stealth_perks", #"off", 0 );
}

