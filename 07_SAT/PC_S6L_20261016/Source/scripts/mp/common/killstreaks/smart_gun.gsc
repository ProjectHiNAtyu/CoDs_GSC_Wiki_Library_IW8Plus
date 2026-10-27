// scripts\mp\common\killstreaks\smart_gun.gsc  (hash_0676fd9abd21fae4.gscc) (size: 7805 Bytes / 0x1e7d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4e096f8f (1309241231)
// size ...... 7805 (0x1e7d)
// includes .. 8   (offset: 0x1d69)
// strings ... 15  (offset: 0x1da9)
// dev strs .. 0   (offset: 0x1e7d)
// exports ... 25  (offset: 0x111d)
// cseg ...... 0x1d7 + 0xf46 (0x111d)
// imports ... 70  (offset: 0x1505)
// animtree1 . 0   (offset: 0x1e7d)
// animtree2 . 0   (offset: 0x1e7d)
#using script_16ea1b94f0f381b3;
#using scripts\common\killstreaks\killstreak_common;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\targetmarkergroups;
#using scripts\common\utility;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\outline;
#using scripts\mp\emp_debuff;

#namespace smart_gun;

// Namespace smart_gun
// Params 0, eflags: 0x1
// Checksum 0xefcc67d, Offset: 0x1f5
// Size: 0x17
function autoexec main()
{
    killstreak_shared::registerkillstreakinitfunction( #"smart_gun", &init );
}

// Namespace smart_gun
// Params 0
// Checksum 0x4da1bf66, Offset: 0x214
// Size: 0x9b
function init()
{
    weaponname = utility::get_scripted_weapon_name( #"smart_gun" );
    
    if ( !isdefined( weaponname ) )
    {
        return;
    }
    
    level.smartgunid = 9999;
    killstreaks::registerkillstreak( "smart_gun", &function_4dff4187d98e9692, undefined, undefined, &function_f84c154bc566a76 );
    killstreaks::registerkillstreakstowableweapon( "smart_gun", weaponname, undefined, "bulletWeapon", undefined, undefined, 1 );
    namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( "smart_gun", weaponname, #"low" );
    killstreaks::function_61ba08bb8e2dd7a6( "smart_gun", 1, #"low" );
    utility::flag_set( "smart_gun_initialized" );
}

// Namespace smart_gun
// Params 1
// Checksum 0xc0de799e, Offset: 0x2b7
// Size: 0x1df
function function_4dff4187d98e9692( streakinfo )
{
    self.var_3367ec443928a42f = level.smartgunid;
    level.smartgunid++;
    self.smartguntargets = [];
    weaponname = utility::get_scripted_weapon_name( #"smart_gun" );
    bundle = streakinfo.bundle;
    self.streakname = "smart_gun";
    streakinfo.streakname = "smart_gun";
    
    if ( !isdefined( self.var_ec0bb630fbaa253a ) )
    {
        self.var_ec0bb630fbaa253a = [];
    }
    
    self.var_ec0bb630fbaa253a[ weaponname ] = streakinfo;
    thread function_8058a7e6aab0b54a( streakinfo );
    self.var_e26dbcf5d36210ee = targetmarkergroups::targetmarkergroup_on( bundle.var_598d79add3230927, self, undefined, self, 0, 0, 1 );
    streakinfo.var_b7f22211336c491a = bundle.var_b7f22211336c491a ?? 0;
    killstreak_shared::function_9fc2f7ee10890d99( streakinfo.streakname );
    thread function_4792fb9b7edef433( streakinfo );
    thread function_d9d207f4dcbcb6bc();
    thread function_9fbc447a68dcec96( streakinfo );
    thread function_8ebd2a7cf9e0ab6c( streakinfo );
    thread function_e79c4d86a8cd5361( streakinfo );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"killstreak" ][ #"addtoactivekillstreaklist" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]( streakinfo.streakname, "Killstreak_Ground", self );
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"sound" ][ #"playkillstreakdeploydialog" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]( streakinfo.streakname );
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hud" ][ #"teamplayercardsplash" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]( bundle.usedsplashref, self );
    }
    
    thread function_ac6336261a1a1607();
}

// Namespace smart_gun
// Params 0, eflags: 0xc
// Checksum 0x9f4c0baf, Offset: 0x49e
// Size: 0x64
function private function_ac6336261a1a1607()
{
    self notify( #"hash_c3b121fd1c6e68b1" );
    self endon( #"hash_c3b121fd1c6e68b1" );
    level endon( #"game_ended" );
    self endon( #"streak_end", #"smart_gun_complete", #"disconnect" );
    
    while ( true )
    {
        function_ddf761e63637d483();
        utility::waittill_any( "emp_started", "emp_cleared" );
    }
}

// Namespace smart_gun
// Params 0, eflags: 0x4
// Checksum 0x60bd72a7, Offset: 0x50a
// Size: 0x23
function private function_ddf761e63637d483()
{
    if ( !self )
    {
        return;
    }
    
    if ( emp_debuff::is_empd() )
    {
        self function_7e1f756ed35efe8( 0 );
        return;
    }
    
    self function_7e1f756ed35efe8( 1 );
}

// Namespace smart_gun
// Params 1
// Checksum 0x5a56152d, Offset: 0x535
// Size: 0x56
function function_4792fb9b7edef433( streakinfo )
{
    self notify( #"hash_532936bd3457cb49" );
    self endon( #"hash_532936bd3457cb49" );
    level endon( #"game_ended" );
    self endon( #"smart_gun_complete" );
    utility::waittill_any( "death", "disconnect" );
    thread smartgun_cleanup( streakinfo );
}

// Namespace smart_gun
// Params 2
// Checksum 0xd9f84343, Offset: 0x593
// Size: 0x1e
function function_f84c154bc566a76( streakitem, streakinfo )
{
    thread smartgun_cleanup( streakinfo );
}

// Namespace smart_gun
// Params 1
// Checksum 0xaf611f4, Offset: 0x5b9
// Size: 0x3d
function function_8058a7e6aab0b54a( streakinfo )
{
    self endon( #"death_or_disconnect" );
    self endon( #"smart_gun_complete" );
    streakinfo waittill( #"killstreak_stowable_weapon_switched" );
    thread smartgun_cleanup( streakinfo, 1 );
}

// Namespace smart_gun
// Params 2
// Checksum 0x897ac448, Offset: 0x5fe
// Size: 0x166
function smartgun_cleanup( streakinfo, killstreakweaponstowed )
{
    self notify( #"streak_end" );
    self notify( #"smart_gun_complete" );
    bundle = killstreak::function_85b2d8e857ab4898( "smart_gun" );
    weaponname = bundle.deployweaponname ?? "sat_ks_smartgun_mp";
    killstreak_shared::function_76bbbe12ce816ed2();
    
    if ( !killstreakweaponstowed && streakinfo && killstreaks::function_86ffe5755d194a83( streakinfo, weaponname ) )
    {
        namespace_9d8e359c3b1041e5::recordkillstreakendstatssharedfunc( streakinfo );
    }
    
    if ( self )
    {
        self setclientomnvar( o"ui_killstreak_smartgun_state", 0 );
    }
    
    if ( isdefined( self.var_e26dbcf5d36210ee ) )
    {
        targetmarkergroups::function_fb26696556bb5e3d( self.var_e26dbcf5d36210ee );
        targetmarkergroups::targetmarkergroup_off( self.var_e26dbcf5d36210ee );
        self.var_e26dbcf5d36210ee = undefined;
    }
    
    foreach ( target in self.smartguntargets )
    {
        if ( isplayer( target ) )
        {
            target thread function_8c607674ea0b789();
        }
    }
    
    function_b1682cc3d68963f2();
    self.streakname = undefined;
}

// Namespace smart_gun
// Params 0
// Checksum 0x6ea3578d, Offset: 0x76c
// Size: 0x59
function function_d9d207f4dcbcb6bc()
{
    self endon( #"death_or_disconnect" );
    self endon( #"smart_gun_complete" );
    
    while ( true )
    {
        if ( !self adsbuttonpressed() )
        {
            self notify( #"smart_gun_target_acquired" );
            self notify( #"hash_55dd16032bd56b2" );
            targetmarkergroups::function_fb26696556bb5e3d( self.var_e26dbcf5d36210ee );
        }
        
        wait 0.1;
    }
}

// Namespace smart_gun
// Params 1
// Checksum 0x6631d2a7, Offset: 0x7cd
// Size: 0x42
function function_2b48f9d9db935069( streakinfo )
{
    self.var_f8bebb6b5e2c31c = undefined;
    function_b1682cc3d68963f2();
    function_d1486589c259dd57( streakinfo.bundle.var_57fe957d82b5bd3b, self.smartguntargets );
}

// Namespace smart_gun
// Params 1
// Checksum 0x6f32ef7e, Offset: 0x817
// Size: 0xf8
function function_9fbc447a68dcec96( streakinfo )
{
    self endon( #"death_or_disconnect" );
    self endon( #"smart_gun_complete" );
    
    while ( true )
    {
        self waittill( #"hash_92909f92e5a246", target0, target1, target2, target3 );
        targets = [ function_862a89df67222cd( target0 ), function_862a89df67222cd( target1 ), function_862a89df67222cd( target2 ), function_862a89df67222cd( target3 ) ];
        
        for ( i = 0; i < 4 ; i++ )
        {
            target = targets[ i ];
            
            if ( isplayer( target ) || isagent( target ) )
            {
                smartgun_updatestate( target, 1 );
            }
        }
        
        if ( self.var_f8bebb6b5e2c31c )
        {
            function_2b48f9d9db935069( streakinfo );
        }
    }
}

// Namespace smart_gun
// Params 1
// Checksum 0x6c431561, Offset: 0x917
// Size: 0x15f
function function_8ebd2a7cf9e0ab6c( streakinfo )
{
    self endon( #"death_or_disconnect" );
    self endon( #"smart_gun_complete" );
    targets = undefined;
    
    while ( true )
    {
        prevtargets = targets;
        self waittill( #"smart_gun_target_acquired", target0, target1, target2, target3 );
        targets = [ function_862a89df67222cd( target0 ), function_862a89df67222cd( target1 ), function_862a89df67222cd( target2 ), function_862a89df67222cd( target3 ) ];
        self setclientomnvar( o"ui_killstreak_smartgun_state", targets.size > 0 );
        
        for ( i = 0; i < 4 ; i++ )
        {
            target = targets[ i ];
            
            if ( ( isplayer( target ) || isagent( target ) ) && !arraycontains( prevtargets, target ) )
            {
                smartgun_updatestate( target, 4 );
            }
            
            prevtarget = prevtargets[ i ];
            
            if ( ( isplayer( prevtarget ) || isagent( prevtarget ) ) && !arraycontains( targets, prevtarget ) )
            {
                smartgun_updatestate( prevtarget, 1 );
            }
        }
        
        if ( self.var_f8bebb6b5e2c31c )
        {
            function_2b48f9d9db935069( streakinfo );
        }
    }
}

// Namespace smart_gun
// Params 1
// Checksum 0xa991cb0f, Offset: 0xa7e
// Size: 0x157
function function_e79c4d86a8cd5361( streakinfo )
{
    self endon( #"death_or_disconnect" );
    self endon( #"smart_gun_complete" );
    targets = undefined;
    
    while ( true )
    {
        prevtargets = targets;
        self waittill( #"hash_55dd16032bd56b2", target0, target1, target2, target3 );
        targets = [ function_862a89df67222cd( target0 ), function_862a89df67222cd( target1 ), function_862a89df67222cd( target2 ), function_862a89df67222cd( target3 ) ];
        
        for ( i = 0; i < 4 ; i++ )
        {
            target = targets[ i ];
            
            if ( ( isplayer( target ) || isagent( target ) ) && ( !isdefined( prevtargets ) || !arraycontains( prevtargets, target ) ) )
            {
                smartgun_updatestate( target, 3, streakinfo );
            }
            
            prevtarget = prevtargets[ i ];
            
            if ( ( isplayer( prevtarget ) || isagent( prevtarget ) ) && !arraycontains( targets, prevtarget ) )
            {
                smartgun_updatestate( prevtarget, 2, streakinfo );
            }
        }
        
        if ( self.var_f8bebb6b5e2c31c )
        {
            function_2b48f9d9db935069( streakinfo );
        }
    }
}

// Namespace smart_gun
// Params 3
// Checksum 0x74d4132b, Offset: 0xbdd
// Size: 0xd0
function smartgun_updatestate( target, transition, streakinfo )
{
    if ( !isdefined( target.smartgunstates ) )
    {
        target.smartgunstates = [];
    }
    
    switch ( target.smartgunstates[ self.var_3367ec443928a42f ] ?? 1 )
    {
        case 2:
            if ( transition == 4 )
            {
                function_ebeeb9519572ce18( target );
            }
            else if ( transition == 2 )
            {
                smartgun_notarget( target );
            }
            
            break;
        case 3:
            if ( transition == 1 )
            {
                smartgun_notarget( target );
            }
            
            break;
        default:
            if ( transition == 3 )
            {
                function_ec3b207ce3c608a0( target, streakinfo );
            }
            
            break;
    }
}

// Namespace smart_gun
// Params 2
// Checksum 0x723cfb51, Offset: 0xcb5
// Size: 0xda
function function_ec3b207ce3c608a0( target, streakinfo )
{
    target.smartgunstates[ self.var_3367ec443928a42f ] = 2;
    self clearsoundsubmix( "sat_mp_kls_smartgun_target_locking_plr_mute" );
    self playlocalsound( "kls_uin_smartgun_target_locking_start_plr" );
    targetmarkergroups::targetmarkergroup_markentity( target, self.var_e26dbcf5d36210ee );
    targetmarkergroupsetentitystate( self.var_e26dbcf5d36210ee, target, 1 );
    function_38187ef7c844fb3a( self.var_e26dbcf5d36210ee, target, 3 );
    
    if ( isplayer( target ) )
    {
        target function_7c52117edbe187e( streakinfo.bundle.var_e748a9c9d02df1f2 );
        target function_1c22c82193d06f45( self, streakinfo );
    }
    
    self.smartguntargets[ target.entnum ?? utility::get_entity_number( target ) ] = target;
    self.var_f8bebb6b5e2c31c = 1;
}

// Namespace smart_gun
// Params 1
// Checksum 0xab799baf, Offset: 0xd97
// Size: 0x53
function function_ebeeb9519572ce18( target )
{
    target.smartgunstates[ self.var_3367ec443928a42f ] = 3;
    self playlocalsound( "kls_uin_smartgun_target_locked_plr" );
    function_3fc498b880daf5fd( self.var_e26dbcf5d36210ee, target, 3 );
    function_38187ef7c844fb3a( self.var_e26dbcf5d36210ee, target, 2 );
}

// Namespace smart_gun
// Params 1
// Checksum 0x71ec149f, Offset: 0xdf2
// Size: 0xb4
function smartgun_notarget( target )
{
    target.smartgunstates[ self.var_3367ec443928a42f ] = undefined;
    
    if ( target.smartgunstates.size == 0 )
    {
        target.smartgunstates = undefined;
    }
    
    self playlocalsound( "kls_uin_smartgun_target_lost_plr" );
    self setsoundsubmix( "sat_mp_kls_smartgun_target_locking_plr_mute" );
    targetmarkergroups::targetmarkergroup_unmarkentity( target, self.var_e26dbcf5d36210ee );
    function_3fc498b880daf5fd( self.var_e26dbcf5d36210ee, target, 3 );
    
    if ( isplayer( target ) )
    {
        target thread function_8c607674ea0b789();
    }
    
    self.smartguntargets[ target.entnum ?? utility::get_entity_number( target ) ] = undefined;
    self.var_f8bebb6b5e2c31c = 1;
}

// Namespace smart_gun
// Params 2
// Checksum 0x6c5505c1, Offset: 0xeae
// Size: 0x91
function function_1c22c82193d06f45( owner, streakinfo )
{
    currtime = gettime();
    
    if ( ( currtime - ( self.var_df0d3415642d60a7 ?? 0 ) ) * 0.001 > ( streakinfo.bundle.var_921b9f4aa397fdb8 ?? 3 ) )
    {
        self.var_df0d3415642d60a7 = currtime;
        owner playsoundtoplayer( streakinfo.bundle.var_f65485791c7ec05, self, owner );
        self clearsoundsubmix( "sat_mp_kls_smartgun_target_locking_on_victim_mute" );
    }
}

// Namespace smart_gun
// Params 1
// Checksum 0x43e0b3a7, Offset: 0xf47
// Size: 0x5b
function function_7c52117edbe187e( outline )
{
    if ( !isdefined( self.var_7ff6442c12795872 ) )
    {
        self.var_7ff6442c12795872 = 0;
    }
    
    self.var_7ff6442c12795872++;
    
    if ( !outline::function_e5be62c454a35e6c( self, self.var_6ad8efa421d90fde ) )
    {
        self.var_6ad8efa421d90fde = outline::outlineviewmodelenable( self, outline, #"killstreak" );
    }
}

// Namespace smart_gun
// Params 0
// Checksum 0x2b5269a8, Offset: 0xfaa
// Size: 0xc7
function function_8c607674ea0b789()
{
    self notify( #"hash_c4c3079a538903ea" );
    self endon( #"hash_c4c3079a538903ea" );
    self endon( #"death_or_disconnect" );
    
    if ( isdefined( self.var_7ff6442c12795872 ) )
    {
        self.var_7ff6442c12795872 -= 1;
        
        if ( self.var_7ff6442c12795872 <= 0 )
        {
            self.var_7ff6442c12795872 = undefined;
        }
    }
    
    wait 0.5;
    
    if ( isplayer( self ) && !isdefined( self.var_7ff6442c12795872 ) )
    {
        if ( isint( self.var_6ad8efa421d90fde ) && outline::function_d922cfa94c5afc77( self, self.var_6ad8efa421d90fde ) )
        {
            outline::outlineviewmodeldisable( self.var_6ad8efa421d90fde, self );
        }
        
        self.var_6ad8efa421d90fde = undefined;
        self setsoundsubmix( "sat_mp_kls_smartgun_target_locking_on_victim_mute" );
    }
}

// Namespace smart_gun
// Params 2
// Checksum 0x84834d9f, Offset: 0x1079
// Size: 0x49
function function_d1486589c259dd57( outline, playersvisibleto )
{
    if ( !outline::function_546d21e688121132( self, self.var_66afd059685a3271 ) )
    {
        if ( playersvisibleto.size > 0 )
        {
            self.var_66afd059685a3271 = outline::function_cc0ba57bbdf62b90( self, playersvisibleto, outline, "killstreak" );
        }
    }
}

// Namespace smart_gun
// Params 0
// Checksum 0x87f982ea, Offset: 0x10ca
// Size: 0x30
function function_b1682cc3d68963f2()
{
    if ( outline::isoutlineenabled( self, self.var_66afd059685a3271 ) )
    {
        outline::outlinedisable( self.var_66afd059685a3271, self );
        self.var_66afd059685a3271 = undefined;
    }
}

// Namespace smart_gun
// Params 1
// Checksum 0xd3aa38ed, Offset: 0x1102
// Size: 0x1a
function function_862a89df67222cd( targetnum )
{
    if ( !isdefined( targetnum ) )
    {
        return;
    }
    
    return getentbynum( targetnum );
}

