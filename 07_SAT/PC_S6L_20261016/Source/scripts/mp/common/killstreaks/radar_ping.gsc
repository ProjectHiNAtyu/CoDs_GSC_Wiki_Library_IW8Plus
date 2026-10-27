// scripts\mp\common\killstreaks\radar_ping.gsc  (hash_7cb6596962b1366b.gscc) (size: 5087 Bytes / 0x13df / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xeb693017 (3949539351)
// size ...... 5087 (0x13df)
// includes .. 9   (offset: 0x1327)
// strings ... 6   (offset: 0x136f)
// dev strs .. 2   (offset: 0x13c7)
// exports ... 18  (offset: 0xbd3)
// cseg ...... 0xc2 + 0xb11 (0xbd3)
// imports ... 40  (offset: 0xea3)
// animtree1 . 0   (offset: 0x13df)
// animtree2 . 0   (offset: 0x13df)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\utility;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\points;
#using scripts\mp\hud_message;
#using scripts\mp\telemetry_mp;

#namespace radar_ping;

// Namespace radar_ping
// Params 0, eflags: 0x1
// Checksum 0xb483a12, Offset: 0xe0
// Size: 0x17
function autoexec main()
{
    killstreak_shared::registerkillstreakinitfunction( getxhash( "radar_ping" ), &radar_ping_init );
}

// Namespace radar_ping
// Params 0
// Checksum 0xc5ec26a3, Offset: 0xff
// Size: 0x97
function radar_ping_init()
{
    bundle = level.streakglobals.streakbundles[ "radar_ping" ];
    assert( bundle.var_c11039e6760bccbc > 0, "<dev string:x24>" );
    assert( isdefined( bundle.deployweaponname ), "<dev string:x49>" );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"killstreak" ][ #"registerkillstreak" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        level [[ var_32dbca3143d9c4a5 ]]( "radar_ping", &function_e659ff9cf0b1cab7 );
    }
}

// Namespace radar_ping
// Params 1, eflags: 0x4
// Checksum 0xcd657c54, Offset: 0x19e
// Size: 0x98
function private function_e659ff9cf0b1cab7( streakinfo )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            return 0;
        }
    }
    
    bundle = streakinfo.bundle;
    gestureweaponobj = makeweapon( bundle.deployweaponname );
    animationresult = killstreakdeploy::streakdeploy_dogesturedeploy( streakinfo, gestureweaponobj );
    
    if ( !animationresult )
    {
        return 0;
    }
    
    return function_81610e2d476b0e99( streakinfo );
}

// Namespace radar_ping
// Params 1, eflags: 0x4
// Checksum 0x4c02ec00, Offset: 0x23f
// Size: 0xba, Type: bool
function private function_8f758d9743f1cdc1( options )
{
    streakinfo = options.streakinfo;
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
            return false;
        }
    }
    
    if ( level.gameended )
    {
        streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
        return false;
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"sound" ][ #"playkillstreakdeploydialog" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]( streakinfo.streakname );
    }
    
    thread hud_message::showsplash( "used_radar_ping", undefined, self );
    return true;
}

// Namespace radar_ping
// Params 2, eflags: 0x4
// Checksum 0xa0c130bb, Offset: 0x302
// Size: 0xdd
function private onplayerdeath( params, additionalparams )
{
    var_d82536d629927485 = 0;
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"jamming_system" ][ #"hash_f3a152be2dbc14b9" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        var_d82536d629927485 = params.victim [[ var_32dbca3143d9c4a5 ]]();
    }
    else
    {
        var_d82536d629927485 = 0;
    }
    
    if ( !var_d82536d629927485 )
    {
        params.victim killstreak::function_7acb73c1355e75ce( params.attacker, additionalparams.streakinfo.owner, additionalparams.streakinfo );
        telemetry_mp::function_cbf4eaf678a574e3( params.victim, additionalparams.streakinfo.streakname ?? "radar_ping", "" );
    }
}

// Namespace radar_ping
// Params 1, eflags: 0xc
// Checksum 0xab718c21, Offset: 0x3e7
// Size: 0x60
function private _radar_ping_end( options )
{
    self notify( #"hash_6cd9f854f0bd6da9" );
    self endon( #"hash_6cd9f854f0bd6da9" );
    streakinfo = options.streakinfo;
    namespace_9d8e359c3b1041e5::recordkillstreakendstatssharedfunc( streakinfo );
    callback::callback( #"killstreak_finish_use", { #streakinfo:streakinfo } );
}

// Namespace radar_ping
// Params 1, eflags: 0x4
// Checksum 0xbafb0f02, Offset: 0x44f
// Size: 0xfb
function private function_81610e2d476b0e99( streakinfo )
{
    bundle = streakinfo.bundle;
    streakinfo.streakduration = bundle.var_c11039e6760bccbc;
    return use( { #streakinfo:streakinfo, #on_end:&_radar_ping_end, #var_3695bbaa5fc2bea:&onplayerdeath, #var_332e00dc6d118b7d:&function_8f758d9743f1cdc1, #radar_ping_id:function_43b5ed5a14a56573( #"scriptbundle_killstreak", bundle.var_d80db24c90d421fb ), #var_2962c1bc94835e40:bundle.var_2962c1bc94835e40, #radarpingsweeptime:bundle.radarpingsweeptime, #radarpingsweepradius:bundle.radarpingsweepradius, #var_3fe43c81282a39e2:bundle.var_3fe43c81282a39e2, #var_c11039e6760bccbc:bundle.var_c11039e6760bccbc } );
}

// Namespace radar_ping
// Params 1
// Checksum 0x72bbd767, Offset: 0x553
// Size: 0xe9, Type: bool
function use( options )
{
    self.radarpinginfo = { #options:options, #streakowner:self };
    thread function_5c46a7a03a1aae04( options );
    thread _radar_watch_game_ended( options );
    thread function_15629c8a4bbe5200( options );
    level callback::add( #"hash_244314ef9125e636", &function_3695bbaa5fc2bea, self.radarpinginfo );
    level callback::add( #"player_disconnect", &onplayerdisconnect, self.radarpinginfo );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"player" ][ #"showminimap" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]();
    }
    
    _radar_ping_resume( options );
    
    if ( isdefined( options.var_332e00dc6d118b7d ) && ![[ options.var_332e00dc6d118b7d ]]( options ) )
    {
        return false;
    }
    
    return true;
}

// Namespace radar_ping
// Params 2, eflags: 0x4
// Checksum 0xec684f00, Offset: 0x645
// Size: 0xda
function private function_3695bbaa5fc2bea( params, additionalparams )
{
    if ( additionalparams.streakowner.radarpingstate != 1 )
    {
        return;
    }
    
    self [[ additionalparams.options.var_3695bbaa5fc2bea ]]( params, additionalparams.options );
    var_3cd63aea0193e3ce = params.attacker == additionalparams.streakowner;
    var_b6165d30daae2320 = additionalparams.streakowner.radarpingstate == 1;
    
    if ( var_3cd63aea0193e3ce && var_b6165d30daae2320 )
    {
        params.attacker thread points::doscoreevent( #"radar_ping_kill" );
        params.attacker.var_e006de984e056e08 = 1;
    }
}

// Namespace radar_ping
// Params 2, eflags: 0xc
// Checksum 0xdd3ad3f2, Offset: 0x727
// Size: 0x3f
function private onplayerdisconnect( params, additionalparams )
{
    self notify( #"hash_16dd8bc13c3bc31d" );
    self endon( #"hash_16dd8bc13c3bc31d" );
    end( additionalparams.options );
}

// Namespace radar_ping
// Params 1, eflags: 0x4
// Checksum 0x6da6e623, Offset: 0x76e
// Size: 0x9e
function private function_15629c8a4bbe5200( options )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"radar_ping_end" );
    var_ef52274dc1fa3e5 = utility::getsharedfunc( #"jamming_system", #"hash_23b4b2c8dfb75cde" );
    
    if ( !isdefined( var_ef52274dc1fa3e5 ) )
    {
        return;
    }
    
    while ( true )
    {
        utility::waittill_any( "radar_ping_jamming_started", "radar_ping_jamming_stopped" );
        
        if ( self.radarpingstate )
        {
            if ( self [[ var_ef52274dc1fa3e5 ]]() )
            {
                function_d56527ebe3847141( options );
                continue;
            }
            
            _radar_ping_resume( options );
        }
    }
}

// Namespace radar_ping
// Params 1, eflags: 0xc
// Checksum 0x23185ba1, Offset: 0x814
// Size: 0x5c
function private function_5c46a7a03a1aae04( options )
{
    self notify( #"hash_5195e53caefb1921" );
    self endon( #"hash_5195e53caefb1921" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    utility::waittill_any_timeout( options.var_c11039e6760bccbc, "death" );
    thread end( options );
}

// Namespace radar_ping
// Params 1, eflags: 0xc
// Checksum 0xb32d866e, Offset: 0x878
// Size: 0xae
function private _radar_watch_game_ended( options )
{
    self notify( #"hash_b095f27127c0ebf6" );
    self endon( #"hash_b095f27127c0ebf6" );
    self endon( #"disconnect" );
    options.streakinfo endon( #"radar_ping_end" );
    level waittill( #"game_ended" );
    
    if ( self )
    {
        if ( options.streakinfo )
        {
            var_32dbca3143d9c4a5 = level.sharedfuncs[ #"killstreak" ][ #"hash_bf17c172d25e8b3d" ];
            
            if ( isdefined( var_32dbca3143d9c4a5 ) )
            {
                self [[ var_32dbca3143d9c4a5 ]]( options.streakinfo );
            }
        }
        
        thread end( options );
    }
}

// Namespace radar_ping
// Params 1, eflags: 0xc
// Checksum 0xb147efbc, Offset: 0x92e
// Size: 0xa9
function private _radar_ping_resume( options )
{
    self notify( #"hash_c8d296bdb43886b4" );
    self endon( #"hash_c8d296bdb43886b4" );
    self.radarpingstate = 1;
    self setclientomnvar( "radar_ping", options.radar_ping_id );
    self.var_667ea7413e3ee64e = options.radarpingsweepradius;
    self function_744ec8023439271f( int( options.radarpingsweepradius ), int( options.radarpingsweeptime * 1000 ), int( options.var_2962c1bc94835e40 * 1000 ) );
    
    if ( options.var_3fe43c81282a39e2 )
    {
        thread function_34b2aa49504d0470();
    }
}

// Namespace radar_ping
// Params 1, eflags: 0xc
// Checksum 0xc0723658, Offset: 0x9df
// Size: 0x5b
function private function_d56527ebe3847141( options )
{
    self notify( #"hash_d420a77ea0ed832f" );
    self endon( #"hash_d420a77ea0ed832f" );
    self.radarpingstate = 2;
    self function_c67c92094ae6ccf7( 1 );
    self notify( #"radar_ping_jammed" );
    
    if ( options.var_3fe43c81282a39e2 )
    {
        self.radarshowenemydirection = 0;
    }
}

// Namespace radar_ping
// Params 1, eflags: 0x4
// Checksum 0x14f01ab1, Offset: 0xa42
// Size: 0x128
function private end( options )
{
    profilestart();
    
    if ( !self.radarpingstate )
    {
        profilestop();
        return;
    }
    
    level callback::remove( #"hash_244314ef9125e636", &function_3695bbaa5fc2bea, self.radarpinginfo );
    level callback::remove( #"player_disconnect", &onplayerdisconnect, self.radarpinginfo );
    self function_c67c92094ae6ccf7();
    
    if ( options.var_3fe43c81282a39e2 )
    {
        self.radarshowenemydirection = 0;
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"player" ][ #"hideminimap" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]();
    }
    
    self.radarpingstate = undefined;
    self.var_dca79eccbe7842eb = gettime();
    self.radarpinginfo = undefined;
    self.var_e006de984e056e08 = undefined;
    self notify( #"radar_ping_end" );
    
    if ( options.streakinfo )
    {
        options.streakinfo notify( #"radar_ping_end" );
    }
    
    if ( options.on_end )
    {
        self [[ options.on_end ]]( options );
    }
    
    profilestop();
}

// Namespace radar_ping
// Params 0, eflags: 0xc
// Checksum 0x7a3cf854, Offset: 0xb72
// Size: 0x61
function private function_34b2aa49504d0470()
{
    self notify( #"hash_e69f6263a90ddba8" );
    self endon( #"hash_e69f6263a90ddba8" );
    self endon( #"death_or_disconnect" );
    self endon( #"radar_ping_jammed" );
    self endon( #"radar_ping_end" );
    
    while ( true )
    {
        if ( !self.radarshowenemydirection )
        {
            self.radarshowenemydirection = 1;
        }
        
        wait 1;
    }
}

