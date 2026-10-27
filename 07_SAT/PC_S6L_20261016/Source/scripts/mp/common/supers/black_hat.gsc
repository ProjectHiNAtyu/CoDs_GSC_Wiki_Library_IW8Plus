// scripts\mp\common\supers\black_hat.gsc  (hash_58834a19d37de080.gscc) (size: 29351 Bytes / 0x72a7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xeef5ca5e (4009085534)
// size ...... 29351 (0x72a7)
// includes .. 26  (offset: 0x6e67)
// strings ... 45  (offset: 0x6f37)
// dev strs .. 7   (offset: 0x724f)
// exports ... 90  (offset: 0x465f)
// cseg ...... 0x418 + 0x4247 (0x465f)
// imports ... 218 (offset: 0x546f)
// animtree1 . 0   (offset: 0x72a7)
// animtree2 . 0   (offset: 0x72a7)
#using scripts\common\ae_utility;
#using scripts\common\ai\ai_utility;
#using scripts\common\callbacks;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\math;
#using scripts\common\metabone;
#using scripts\common\omnvar_utility;
#using scripts\common\targetmarkergroups;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle_tracking;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\equipment_utility;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\emp_debuff;
#using scripts\mp\gamelogic;
#using scripts\mp\gamescore;
#using scripts\mp\hud_util;
#using scripts\mp\supers;
#using scripts\mp\telemetry_mp;

#namespace black_hat;

// Namespace black_hat
// Params 0, eflags: 0x1
// Checksum 0xdd1eedb9, Offset: 0x436
// Size: 0x69
function autoexec main()
{
    supers_mp::function_adf2820d5daa2e81( getxhash( "super_black_hat" ), &black_hat_init );
    utility::registersharedfunc( #"black_hat", #"hash_29fb623c0b4dda71", &function_67f7849d1b909800 );
    utility::registersharedfunc( #"black_hat", #"hash_d428d7b9853a90d7", &function_d77bf7a46d5c6fc4 );
    level callback::add( #"hash_244314ef9125e636", &function_6a4dc66cc77c88c1 );
}

// Namespace black_hat
// Params 0, eflags: 0x4
// Checksum 0xa1af95d4, Offset: 0x4a7
// Size: 0x7a
function private black_hat_init()
{
    staticdata = level.superglobals.staticsuperdata[ "super_black_hat" ];
    
    if ( !staticdata )
    {
        return;
    }
    
    bundle = staticdata.bundle;
    
    if ( !bundle )
    {
        return;
    }
    
    supers_mp::function_48aaa60b2ce7b8a1( "super_black_hat", &black_hat_set, &black_hat_unset, &begin_use, &end_use, &repeat_use, undefined, undefined );
    function_bc308c115f7c466( bundle );
}

// Namespace black_hat
// Params 4, eflags: 0x4
// Checksum 0xc7ba7c84, Offset: 0x529
// Size: 0x83
function private repeat_use( skipfirstraise, isimmediate, var_686ab1c37bca9979, slot )
{
    result = supers_mp::function_a456d0290912f49( skipfirstraise, isimmediate, var_686ab1c37bca9979, slot );
    
    if ( result )
    {
        if ( !self.black_hat_data )
        {
            set_up_black_hat_data();
        }
        
        if ( !self.black_hat_scriptable )
        {
            set_up_scriptable( self.black_hat_data );
        }
        
        self notify( #"using" );
    }
    
    return result;
}

// Namespace black_hat
// Params 0, eflags: 0x4
// Checksum 0x3af979b2, Offset: 0x5b5
// Size: 0x17
function private function_8d8aadf5929ab1b0()
{
    thread equipment_utility::function_364a1a0e0c018518( "super_black_hat", #"disrupted_hacked" );
}

// Namespace black_hat
// Params 0, eflags: 0x4
// Checksum 0x952f2e65, Offset: 0x5d4
// Size: 0x9
function private black_hat_set()
{
    thread function_927d85384297cd73();
}

// Namespace black_hat
// Params 0, eflags: 0x4
// Checksum 0x1c392302, Offset: 0x5e5
// Size: 0xe
function private black_hat_unset()
{
    self notify( #"black_hat_unset" );
}

// Namespace black_hat
// Params 0, eflags: 0xc
// Checksum 0x769535be, Offset: 0x5fb
// Size: 0x9c
function private function_927d85384297cd73()
{
    self notify( #"hash_3a2bfb49f232a9bf" );
    self endon( #"hash_3a2bfb49f232a9bf" );
    self endon( #"disconnect", #"black_hat_unset" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        msg = utility::waittill_any_return( "ui_black_hat_screen_on", "ui_black_hat_screen_off" );
        
        if ( msg == "ui_black_hat_screen_on" )
        {
            killstreak_shared::starttabletscreen( "super_black_hat", 0, 1 );
            continue;
        }
        
        if ( msg == "ui_black_hat_screen_off" )
        {
            killstreak_shared::stoptabletscreen( "super_black_hat", 0 );
        }
    }
}

// Namespace black_hat
// Params 0, eflags: 0x4
// Checksum 0xce4290ff, Offset: 0x69f
// Size: 0xd4, Type: bool
function private begin_use()
{
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"black_hat" ][ #"hash_29fb623c0b4dda71" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]( #"super_black_hat", &function_8d8aadf5929ab1b0 );
    }
    
    black_hat_data = set_up_black_hat_data();
    set_up_scriptable( black_hat_data );
    thread function_d00a40030e6164e( black_hat_data );
    thread function_cae092ca3c94fd8c( black_hat_data );
    thread function_9c3da356096a4b58( black_hat_data );
    thread function_26dd8562d1c08109();
    self notify( #"using" );
    
    if ( black_hat_data.bundle.var_8b9eade13fbfb044 && !callback::exists( #"super_cancel", &cancel ) )
    {
        callback::add( #"super_cancel", &cancel );
    }
    
    return true;
}

// Namespace black_hat
// Params 1, eflags: 0x4
// Checksum 0xb4d977c5, Offset: 0x77c
// Size: 0x2f
function private cancel( params )
{
    self notify( #"cancel_black_hat" );
    supers_mp::reducesuperusepercent( 1, undefined, undefined, #"tactical" );
}

// Namespace black_hat
// Params 2, eflags: 0x4
// Checksum 0x43a8ac62, Offset: 0x7b3
// Size: 0xe1
function private end_use( fromdeath, attacker )
{
    self notify( #"black_hat_end" );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"black_hat" ][ #"hash_d428d7b9853a90d7" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]( #"super_black_hat" );
    }
    
    self lerpfovbypreset( "default" );
    
    if ( self.black_hat_data )
    {
        function_6190e85c8e8920db( self.black_hat_data, "stowed" );
        self.black_hat_data = undefined;
    }
    
    if ( level.superglobals.staticsuperdata[ "super_black_hat" ].bundle.var_8b9eade13fbfb044 )
    {
        callback::remove( #"super_cancel", &cancel );
    }
    
    thread function_e8cdb5c96e326eff();
}

// Namespace black_hat
// Params 0, eflags: 0xc
// Checksum 0xba837f12, Offset: 0x89c
// Size: 0x50
function private function_e8cdb5c96e326eff()
{
    self notify( #"hash_9f2feecedf47b159" );
    self endon( #"hash_9f2feecedf47b159" );
    self notify( #"player_switched_weapon" );
    wait 0.2;
    
    if ( self.black_hat_scriptable )
    {
        self.black_hat_scriptable delete();
        self.black_hat_scriptable = undefined;
    }
}

// Namespace black_hat
// Params 1, eflags: 0x4
// Checksum 0x4589f577, Offset: 0x8f4
// Size: 0x176
function private function_bc308c115f7c466( bundle )
{
    assert( bundle.var_c42002f2a977d98f.size, "<dev string:x24>" );
    
    if ( bundle.blackhatrange )
    {
        level.var_cc094137ecb800f = squared( bundle.blackhatrange );
    }
    
    level.black_hat_target_info = [];
    
    for ( i = 0; i < bundle.var_c42002f2a977d98f.size ; i++ )
    {
        hackableref = bundle.var_c42002f2a977d98f[ i ].reference;
        
        if ( isdefined( hackableref ) )
        {
            level.black_hat_target_info[ hackableref ] = bundle.var_c42002f2a977d98f[ i ];
            level.black_hat_target_info[ hackableref ].var_a8b5c5b59e8ce3e6 = i;
            callbackcategory = bundle.var_c42002f2a977d98f[ i ].callbackcategory;
            
            if ( !callbackcategory )
            {
                callbackcategory = utility::callsharedfunc( #"gametype", #"hash_9c548c8168f54b66", hackableref );
            }
            
            if ( callbackcategory )
            {
                level.black_hat_target_info[ hackableref ].callbackcategory = callbackcategory;
            }
        }
    }
    
    level thread function_ea8ed2d9eed62718();
    
    if ( bundle.blackhatexplosionradius )
    {
        level._effect[ "black_hat_elec_explosion_fx" ] = loadfxasset( utility::function_b720276ae54a4d70( bundle.var_71e207ecf30423ef, "black_hat: missing blackHatExplosionVFX when blackHatExplosionRadius is defined" ) );
    }
}

// Namespace black_hat
// Params 0, eflags: 0xc
// Checksum 0x251966e0, Offset: 0xa72
// Size: 0x6c
function private function_ea8ed2d9eed62718()
{
    self notify( #"hash_af3f37613e8a31ba" );
    self endon( #"hash_af3f37613e8a31ba" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( level.var_80c6e313f9c36e80 )
        {
            level.var_80c6e313f9c36e80 = function_5713d46873b29625( level.var_80c6e313f9c36e80 );
            
            if ( level.var_80c6e313f9c36e80.size == 0 )
            {
                level.var_80c6e313f9c36e80 = undefined;
            }
        }
        
        wait 10;
    }
}

// Namespace black_hat
// Params 0, eflags: 0x4
// Checksum 0xe229b3f5, Offset: 0xae6
// Size: 0x86
function private set_up_black_hat_data()
{
    bundle = level.superglobals.staticsuperdata[ "super_black_hat" ].bundle;
    self.black_hat_data = { #explosion_data:function_2ae0b00a53cad1c1( bundle ), #bundle:bundle, #weaponref:self getcurrentweapon(), #state:"using", #owner:self };
    return self.black_hat_data;
}

// Namespace black_hat
// Params 1, eflags: 0x4
// Checksum 0x9a63851c, Offset: 0xb75
// Size: 0x105
function private function_2ae0b00a53cad1c1( bundle )
{
    if ( !bundle.blackhatexplosionradius )
    {
        return;
    }
    
    explosion_data = { #stun_chance:bundle.var_36abffde5a79ceed, #sfx:utility::function_b720276ae54a4d70( bundle.blackhatexplosionsfx, "black_hat: missing blackHatExplosionSFX" ), #vfx:"black_hat_elec_explosion_fx", #var_c04e417f8531bdb5:utility::function_b720276ae54a4d70( bundle.blackhatexplosionmaxtier, "black_hat: missing blackHatExplosionMaxTier" ), #damage:utility::function_b720276ae54a4d70( bundle.blackhatexplosiondamage, "black_hat: missing blackHatExplosionDamage" ), #radius:bundle.blackhatexplosionradius };
    
    if ( explosion_data.stun_chance )
    {
        explosion_data.stun_duration = utility::function_b720276ae54a4d70( bundle.var_b4c95a496b81f4a1, "black_hat: missing blackHatExplosionStunDuration when stun_chance is defined" );
        explosion_data.stun_max_tier = bundle.var_8c42714264c32ff9;
    }
    
    return explosion_data;
}

// Namespace black_hat
// Params 1, eflags: 0x4
// Checksum 0x5488c686, Offset: 0xc83
// Size: 0x7d
function private set_up_scriptable( black_hat_data )
{
    self.black_hat_scriptable = spawn( "script_model", self gettagorigin( "j_head" ) );
    self.black_hat_scriptable setotherent( self );
    self.black_hat_scriptable setentityowner( self );
    self.black_hat_scriptable setmodel( black_hat_data.bundle.var_8af749c3313d96a3 );
    self.black_hat_scriptable linkto( self, "j_head" );
}

// Namespace black_hat
// Params 1, eflags: 0x4
// Checksum 0x1f034c94, Offset: 0xd08
// Size: 0x64
function private function_cae092ca3c94fd8c( black_hat_data )
{
    self endon( #"death_or_disconnect" );
    self endon( #"black_hat_end" );
    
    while ( black_hat_data )
    {
        self waittill( #"weapon_switch_started", weapon );
        
        if ( weapon != black_hat_data.weaponref )
        {
            function_6190e85c8e8920db( black_hat_data, "stowed" );
        }
    }
}

// Namespace black_hat
// Params 1, eflags: 0x4
// Checksum 0x8a53a402, Offset: 0xd74
// Size: 0x62
function private function_9c3da356096a4b58( black_hat_data )
{
    self endon( #"death_or_disconnect" );
    self endon( #"black_hat_end" );
    
    while ( black_hat_data )
    {
        self waittill( #"weapon_change", weapon );
        
        if ( weapon == black_hat_data.weaponref )
        {
            self notify( #"using" );
        }
    }
}

// Namespace black_hat
// Params 0, eflags: 0x4
// Checksum 0x6f4a93af, Offset: 0xdde
// Size: 0x56
function private function_26dd8562d1c08109()
{
    self endon( #"death_or_disconnect" );
    self endon( #"black_hat_end" );
    
    while ( true )
    {
        if ( self isskydiving() )
        {
            self notify( #"cancel_black_hat" );
            thread supers_mp::reducesuperusepercent( 1, undefined, undefined, #"tactical" );
            break;
        }
        
        wait 0.5;
    }
}

// Namespace black_hat
// Params 1, eflags: 0x4
// Checksum 0x32cdd3b1, Offset: 0xe3c
// Size: 0x275
function private function_d00a40030e6164e( black_hat_data )
{
    self endon( #"death_or_disconnect" );
    self endon( #"black_hat_end" );
    var_b697580429b5389 = 0;
    
    while ( black_hat_data )
    {
        if ( self.var_b57d118f387faec7 || self.ksempd || self isswitchingweapon() )
        {
            waitframe();
            continue;
        }
        
        var_26bdc72f0e72f62 = self getcurrentweapon() == black_hat_data.weaponref;
        attackbuttonpressed = self attackbuttonpressed() && var_26bdc72f0e72f62;
        
        if ( attackbuttonpressed && !var_b697580429b5389 )
        {
            self lerpfovbypreset( "black_hat_zoom_in" );
            helper_prompts = [];
            helper_prompts[ "prompt_aim" ] = &"hash_7829a41cbe38589a";
            utility::callsharedfunc( #"helper_bar_prompts", #"add_array", "black_hat", helper_prompts, 1 );
            function_e979988ab0a88e01( attackbuttonpressed );
        }
        else if ( !attackbuttonpressed && var_b697580429b5389 )
        {
            self lerpfovbypreset( "default" );
            
            if ( black_hat_data.var_892aa7c3f0e4873a && black_hat_data.bundle.var_8d764b76c9413aea )
            {
                self notify( #"hash_7cf2cad15a59cd4d" );
                black_hat_data.var_892aa7c3f0e4873a = undefined;
            }
            
            function_e979988ab0a88e01( attackbuttonpressed );
        }
        
        if ( !var_26bdc72f0e72f62 )
        {
            function_6190e85c8e8920db( black_hat_data, "stowed" );
            self waittill( #"using" );
        }
        else if ( black_hat_data.var_892aa7c3f0e4873a )
        {
            function_6190e85c8e8920db( black_hat_data, "hacking" );
        }
        else if ( !black_hat_data.targetent )
        {
            function_6190e85c8e8920db( black_hat_data, "using" );
        }
        else if ( attackbuttonpressed )
        {
            function_6190e85c8e8920db( black_hat_data, "hacking" );
        }
        else
        {
            function_6190e85c8e8920db( black_hat_data, "using" );
        }
        
        if ( self.black_hat_scriptable )
        {
            if ( attackbuttonpressed && !black_hat_data.targetent )
            {
                self.black_hat_scriptable setscriptablepartstate( #"hacking", #"hash_f2ec11589b849d5f" );
            }
            else if ( self.black_hat_scriptable getscriptablepartstate( #"hacking", 1 ) == #"hash_f2ec11589b849d5f" )
            {
                self.black_hat_scriptable setscriptablepartstate( #"hacking", #"off" );
            }
        }
        
        function_d2a29e8a4abbf54c( black_hat_data );
        function_3f4ebfd2b731ee91( black_hat_data );
        var_b697580429b5389 = attackbuttonpressed;
        waitframe();
    }
}

// Namespace black_hat
// Params 2, eflags: 0x4
// Checksum 0x3c2e65b2, Offset: 0x10b9
// Size: 0x89
function private function_6190e85c8e8920db( black_hat_data, newstate )
{
    oldstate = black_hat_data.state;
    black_hat_data.state = newstate;
    
    if ( oldstate != newstate )
    {
        function_19b1d3d432812bda( newstate );
        
        if ( newstate == "stowed" )
        {
            function_d179aa1a0d290d7a( black_hat_data );
        }
        
        if ( newstate == "hacking" )
        {
            function_cdc8ba50a835d922( black_hat_data );
            return;
        }
        
        if ( oldstate == "hacking" )
        {
            function_b770cc3b02530da( black_hat_data );
        }
    }
}

// Namespace black_hat
// Params 1, eflags: 0x4
// Checksum 0x35a653bc, Offset: 0x114a
// Size: 0x4d
function private function_d179aa1a0d290d7a( black_hat_data )
{
    thread function_7acd421e5925ea0b( black_hat_data, 0 );
    
    if ( self.black_hat_scriptable )
    {
        self.black_hat_scriptable setscriptablepartstate( #"hacking", #"off" );
    }
    
    self lerpfovbypreset( "default" );
}

// Namespace black_hat
// Params 1, eflags: 0x4
// Checksum 0x8b0a33f8, Offset: 0x119f
// Size: 0x20f
function private function_d2a29e8a4abbf54c( black_hat_data )
{
    if ( black_hat_data.state == "using" )
    {
        if ( black_hat_data.var_27f531c314c90578 && gettime() - black_hat_data.var_27f531c314c90578 < 200 )
        {
            return;
        }
        
        prevtarget = black_hat_data.targetent;
        var_3399f030914c73eb = function_4093f47c1f4a04ff( black_hat_data );
        var_627ffa4323870b0a = function_40137c7634157753( var_3399f030914c73eb );
        function_4f6a19bf9c130ab8( var_3399f030914c73eb, black_hat_data.targetref, var_627ffa4323870b0a );
        
        if ( prevtarget != var_3399f030914c73eb || !var_3399f030914c73eb && black_hat_data.var_c63dc78948d98cb7 )
        {
            black_hat_data.var_4f771571f5fc876e = var_627ffa4323870b0a;
            function_3ebf486b28800872( black_hat_data );
            function_f10d8142d524ac1( black_hat_data.targetref );
        }
        else if ( black_hat_data.var_4f771571f5fc876e != var_627ffa4323870b0a )
        {
            black_hat_data.var_aa778d21f7d75252 = 0;
            black_hat_data.var_4f771571f5fc876e = var_627ffa4323870b0a;
            function_3ebf486b28800872( black_hat_data );
        }
        
        if ( black_hat_data.hackingent && black_hat_data.var_aa778d21f7d75252 && black_hat_data.hackingent == var_3399f030914c73eb )
        {
            function_19b1d3d432812bda( "hacking" );
            function_bdb762bca55b5265( black_hat_data );
        }
        else
        {
            function_19b1d3d432812bda( "using" );
            function_443d9af0ce83272();
        }
        
        black_hat_data.var_27f531c314c90578 = gettime();
        return;
    }
    
    if ( black_hat_data.state == "hacking" )
    {
        if ( !function_d51b75709fe153b4( black_hat_data, black_hat_data.targetent, black_hat_data.targetref ) || is_target_obstructed( black_hat_data, black_hat_data.targetent, black_hat_data.targetref ) || black_hat_data.var_4f771571f5fc876e < function_40137c7634157753( black_hat_data.targetent ) )
        {
            black_hat_data.targetent = undefined;
            function_3ebf486b28800872( black_hat_data );
        }
    }
}

// Namespace black_hat
// Params 3, eflags: 0x4
// Checksum 0xcad0215e, Offset: 0x13b6
// Size: 0x68
function private function_4f6a19bf9c130ab8( target, ref, pip_count )
{
    upgradetier = utility::callsharedfunc( "super_black_hat", #"hash_903dd7726ab06c33" ) ?? 0;
    function_5d4acc35d65544a8( upgradetier );
    var_3d09df77eb5ab8c = function_901c6ac0c2cbfaa8( target, ref, pip_count );
    function_8bde032086301530( var_3d09df77eb5ab8c );
}

// Namespace black_hat
// Params 1, eflags: 0x4
// Checksum 0xf78a059c, Offset: 0x1426
// Size: 0x5e
function private function_109347567a0d9694( vehicleent )
{
    driverai = vehicleent.driver;
    basestr = vehicleent.classname;
    
    if ( isagent( driverai ) && vehicleent.riders.size > 0 )
    {
        return ( basestr + "_ai" );
    }
    
    return basestr;
}

// Namespace black_hat
// Params 1, eflags: 0x4
// Checksum 0x92af26e0, Offset: 0x148d
// Size: 0x821
function private function_4093f47c1f4a04ff( black_hat_data )
{
    bundle = black_hat_data.bundle;
    black_hat_data.targetent = undefined;
    black_hat_data.targetref = undefined;
    black_hat_data.targetangle = bundle.var_a0e3a29ba15f937c;
    black_hat_data.range = utility::callsharedfunc( "super_black_hat", #"hash_58e6af5b72d0a002" ) ?? bundle.blackhatrange;
    
    if ( level.activekillstreaks.size )
    {
        killstreakarray = arrayremoveduplicates( level.activekillstreaks );
        
        foreach ( ent in killstreakarray )
        {
            if ( !ent.team || !player_utility::isenemy( ent ) )
            {
                continue;
            }
            
            update_closest_target( black_hat_data, ent, ent.streakname );
        }
    }
    
    equipmentarray = [[ level.getactiveequipmentarray ]]();
    function_5713d46873b29625( equipmentarray );
    
    if ( equipmentarray.size )
    {
        foreach ( ent in equipmentarray )
        {
            if ( !ent.team || !player_utility::isenemy( ent ) )
            {
                continue;
            }
            
            update_closest_target( black_hat_data, ent, ent.equipmentref );
        }
    }
    
    if ( level.var_80c6e313f9c36e80.size )
    {
        foreach ( ent in level.var_80c6e313f9c36e80 )
        {
            if ( !ent.team || !player_utility::isenemy( ent ) )
            {
                continue;
            }
            
            update_closest_target( black_hat_data, ent, ent.equipmentref ?? ent.superref ?? ent.streakref );
        }
    }
    
    vehiclearray = vehicle_tracking::function_5820a38c9873992e();
    
    if ( vehiclearray.size )
    {
        vehiclearray = arrayremove( vehiclearray, killstreakarray );
        vehiclearray = arrayremove( vehiclearray, equipmentarray );
        
        foreach ( ent in vehiclearray )
        {
            if ( ent.var_92f27893e3e47b21 )
            {
                continue;
            }
            
            var_29691d37a9f18dc3 = ent.classname + "_" + ent.vehiclename;
            vehicleref = ent.blackhatref ?? ( ent.streakname ? ent.streakname : function_109347567a0d9694( ent ) );
            
            if ( level.black_hat_target_info[ var_29691d37a9f18dc3 ] )
            {
                update_closest_target( black_hat_data, ent, var_29691d37a9f18dc3 );
                continue;
            }
            
            update_closest_target( black_hat_data, ent, vehicleref );
        }
    }
    
    aiarray = getaiarrayinradius( self.origin, black_hat_data.range );
    
    if ( aiarray.size )
    {
        aiarray = arrayremove( aiarray, killstreakarray );
        aiarray = arrayremove( aiarray, equipmentarray );
        
        foreach ( ent in aiarray )
        {
            if ( ent isonladder() )
            {
                continue;
            }
            
            var_cd645e578021c8b9 = ent.blackhatref ?? ent.type + "_" + ent.agent_type;
            aipowertier = ent ai_utility::get_power_tier();
            
            if ( aipowertier )
            {
                var_5122bc55770defc9 = ent.type + "_tier" + aipowertier;
            }
            
            if ( level.black_hat_target_info[ var_cd645e578021c8b9 ] )
            {
                update_closest_target( black_hat_data, ent, var_cd645e578021c8b9 );
                continue;
            }
            
            if ( var_5122bc55770defc9 && level.black_hat_target_info[ var_5122bc55770defc9 ] )
            {
                update_closest_target( black_hat_data, ent, var_5122bc55770defc9 );
                continue;
            }
            
            update_closest_target( black_hat_data, ent, ent.type );
        }
    }
    
    enemyplayers = level.teambased ? teams::getenemyplayers( self.team ) : level.players;
    
    foreach ( ent in teams::getenemyplayers( level.teambased ? self.team : undefined, 1 ) )
    {
        if ( level.black_hat_target_info[ "remote_robot" ] && killstreaks::function_b5fe8b8e8c5ce798( "remote_robot" ) && ent.isjuggernaut )
        {
            update_closest_target( black_hat_data, ent, "remote_robot" );
            continue;
        }
        
        update_closest_target( black_hat_data, ent, "player" );
    }
    
    if ( utility::issharedfuncdefined( #"gametype", #"hash_d12983acf2f30a1b" ) )
    {
        hackable_target_array = utility::callsharedfunc( #"gametype", #"hash_d12983acf2f30a1b" );
        
        foreach ( target in hackable_target_array )
        {
            ref = target utility::callsharedfunc( #"gametype", #"hash_4874c6337bffafb0" );
            update_closest_target( black_hat_data, target, ref );
        }
    }
    
    foreach ( ent in level.huntdrones )
    {
        if ( ent.hackable )
        {
            var_cdffe119ed60d14d = "flying_drone_unit";
            
            if ( ent.type != %"main_drone" )
            {
                var_cdffe119ed60d14d = "flying_drone_unit_helper";
            }
            
            var_a64830ff65518e0d = utility::callsharedfunc( #"ob_story", #"get_active_mission_index", self );
            
            if ( var_a64830ff65518e0d || level.var_6488d1fb560a08fb )
            {
                drone_type_sm = var_cdffe119ed60d14d + "_sm";
                
                if ( level.black_hat_target_info[ drone_type_sm ] )
                {
                    var_cdffe119ed60d14d = drone_type_sm;
                }
            }
            
            update_closest_target( black_hat_data, ent, var_cdffe119ed60d14d );
        }
    }
    
    return black_hat_data.targetent;
}

// Namespace black_hat
// Params 3, eflags: 0x4
// Checksum 0xfb8c328e, Offset: 0x1cb7
// Size: 0xa1
function private update_closest_target( black_hat_data, ent, targetref )
{
    assert( targetref, "<dev string:x55>" );
    
    if ( function_d51b75709fe153b4( black_hat_data, ent, targetref ) )
    {
        entangle = function_408a2e83fb431ad4( get_target_origin( ent, targetref, 1 ) );
        
        if ( entangle <= black_hat_data.targetangle && !is_target_obstructed( black_hat_data, ent, targetref ) )
        {
            black_hat_data.targetangle = entangle;
            black_hat_data.targetent = ent;
            black_hat_data.targetref = targetref;
        }
    }
}

// Namespace black_hat
// Params 2, eflags: 0x4
// Checksum 0xc3a370ae, Offset: 0x1d60
// Size: 0xd4, Type: bool
function private function_f4ccd81edcca6dab( target, ref )
{
    if ( ref == "player" )
    {
        return false;
    }
    
    if ( level.black_hat_target_info[ ref ].var_3a801ae958e17e84 )
    {
        return false;
    }
    
    if ( level.black_hat_target_info[ ref ].var_1fdf911fde69b5da )
    {
        return false;
    }
    
    assert( level.black_hat_target_info[ ref ].var_cfdc710c95f72391, "<dev string:xd8>" );
    
    if ( !target.var_70e5107fa80844df )
    {
        return false;
    }
    
    var_332793cc0ec2926d = level.black_hat_target_info[ ref ].var_b54ffda5b082d46a.size * level.black_hat_target_info[ ref ].var_cfdc710c95f72391;
    return target.var_70e5107fa80844df >= var_332793cc0ec2926d;
}

// Namespace black_hat
// Params 3, eflags: 0x4
// Checksum 0x1f34bd02, Offset: 0x1e3d
// Size: 0xae, Type: bool
function private is_target_in_view( black_hat_data, target, ref )
{
    if ( isent( target ) && !isalive( target ) && target.maxhealth > 0 )
    {
        return false;
    }
    
    var_8daf74bad56d86cf = function_408a2e83fb431ad4( get_target_origin( target, ref, 1 ) );
    var_2673a701b5abf7e8 = black_hat_data.hackingent == target ? black_hat_data.bundle.var_3abb6f4ae73e61e2 : black_hat_data.bundle.var_a0e3a29ba15f937c;
    return var_8daf74bad56d86cf <= var_2673a701b5abf7e8;
}

// Namespace black_hat
// Params 3, eflags: 0x4
// Checksum 0xb7da4695, Offset: 0x1ef4
// Size: 0x7f, Type: bool
function private is_target_in_range( black_hat_data, target, ref )
{
    target_origin = get_target_origin( target, ref );
    
    if ( level.black_hat_target_info[ ref ].aerial )
    {
        return true;
    }
    
    return distancesquared( target_origin, self.origin ) <= ( utility::callsharedfunc( "super_black_hat", #"hash_2a678715a290a1b6" ) ?? level.var_cc094137ecb800f );
}

// Namespace black_hat
// Params 3, eflags: 0x4
// Checksum 0x69d8cef9, Offset: 0x1f7c
// Size: 0x18c, Type: bool
function private is_target_obstructed( black_hat_data, target, ref )
{
    if ( !black_hat_data.bundle.var_9346fe8a317c9ea0 )
    {
        return false;
    }
    
    if ( black_hat_data.bundle.var_e36b84555e7df1d3 && supers_mp::function_d45945781d29204a( "super_black_hat", black_hat_data.bundle.var_e36b84555e7df1d3 ) )
    {
        return false;
    }
    
    endpos = get_target_origin( target, ref, 1 );
    
    if ( level.black_hat_target_info[ ref ].positionoffset )
    {
        offset_vec = ( level.black_hat_target_info[ ref ].positionoffset.xoffset ?? 0, ( level.black_hat_target_info[ ref ].positionoffset.yoffset ?? 0 ) * -1, level.black_hat_target_info[ ref ].positionoffset.zoffset ?? 0 );
        endpos += rotatevector( offset_vec, target.angles );
    }
    
    contents = trace::create_contents( 0, 1, 0, 0, 1, 1, 0 );
    ignorelist = [];
    result = physics_raycast( self geteye(), endpos, contents, undefined, 0, "physicsquery_closest" );
    return result[ 0 ] && target != result[ 0 ][ "entity" ];
}

// Namespace black_hat
// Params 3, eflags: 0x4
// Checksum 0xda438dcf, Offset: 0x2111
// Size: 0x149, Type: bool
function private function_d51b75709fe153b4( black_hat_data, target, ref )
{
    var_a7a1772eaed810c8 = get_upgrade_target_info( ref ) ?? level.black_hat_target_info[ ref ];
    
    if ( !target || !ref )
    {
        return false;
    }
    
    if ( ref != "player" && !var_a7a1772eaed810c8 )
    {
        return false;
    }
    
    if ( target.var_c3c4d711e69d5ab9 )
    {
        return false;
    }
    
    if ( ref == "player" || ref == "remote_robot" )
    {
        if ( self == target )
        {
            return false;
        }
        
        if ( target.var_b57d118f387faec7 )
        {
            return false;
        }
        
        if ( isdefined( target.perks[ "specialty_hack_immunity" ] ) )
        {
            return false;
        }
    }
    else if ( level.teambased && ( target.team == self.team || target.owner.team == self.team ) )
    {
        return false;
    }
    
    if ( !is_target_in_range( black_hat_data, target, ref ) )
    {
        return false;
    }
    
    if ( function_f4ccd81edcca6dab( target, ref ) )
    {
        return false;
    }
    
    if ( !is_target_in_view( black_hat_data, target, ref ) )
    {
        return false;
    }
    
    if ( !var_a7a1772eaed810c8.var_b54ffda5b082d46a )
    {
        return false;
    }
    
    return true;
}

// Namespace black_hat
// Params 1, eflags: 0x4
// Checksum 0xfdc48cbe, Offset: 0x2263
// Size: 0x23
function private function_408a2e83fb431ad4( origin )
{
    return math::anglebetweenvectors( origin - self getvieworigin(), anglestoforward( self getplayerangles() ) );
}

// Namespace black_hat
// Params 3, eflags: 0x4
// Checksum 0xe6c2844f, Offset: 0x228f
// Size: 0x176
function private get_target_origin( target, ref, var_a5f4cf5c0c1e356 = 0 )
{
    if ( !var_a5f4cf5c0c1e356 )
    {
        return target.origin;
    }
    
    bone_override = level.black_hat_target_info[ ref ].var_52ddb565872f3011;
    
    if ( bone_override && target tagexists( bone_override ) )
    {
        return target gettagorigin( bone_override, 1 );
    }
    
    if ( level.black_hat_target_info[ ref ].var_8b4be2567b8b19c4 )
    {
        return target getcentroid();
    }
    
    if ( isent( target ) && target tagexists( "j_mainroot" ) )
    {
        return target gettagorigin( "j_mainroot", 1 );
    }
    
    if ( level.black_hat_target_info[ ref ].positionoffset )
    {
        offset_vec = ( level.black_hat_target_info[ ref ].positionoffset.xoffset ?? 0, ( level.black_hat_target_info[ ref ].positionoffset.yoffset ?? 0 ) * -1, level.black_hat_target_info[ ref ].positionoffset.zoffset ?? 0 );
        return ( target.origin + rotatevector( offset_vec, target.angles ) );
    }
    
    return target.origin;
}

// Namespace black_hat
// Params 1, eflags: 0x4
// Checksum 0x195d3cb7, Offset: 0x240e
// Size: 0x65
function private function_3f4ebfd2b731ee91( black_hat_data )
{
    if ( black_hat_data.state == "hacking" && black_hat_data.targetent == black_hat_data.hackingent && !is_hacking_successful( black_hat_data ) )
    {
        function_5eca3afcbbdda087( black_hat_data );
        
        if ( is_hacking_successful( black_hat_data ) )
        {
            thread successfully_hack( black_hat_data );
        }
    }
}

// Namespace black_hat
// Params 1, eflags: 0x4
// Checksum 0xf0847a8e, Offset: 0x247b
// Size: 0x107
function private function_cdc8ba50a835d922( black_hat_data )
{
    if ( black_hat_data.targetent )
    {
        if ( black_hat_data.hackingent != black_hat_data.targetent )
        {
            black_hat_data.hackingent = black_hat_data.targetent;
            black_hat_data.var_aa778d21f7d75252 = 0;
            black_hat_data.var_11a63b6058455078 = undefined;
            black_hat_data.var_16861543e02db952 = function_a368bb34abc087aa( black_hat_data.targetref, black_hat_data.hackingent );
        }
        
        if ( self.black_hat_scriptable )
        {
            self.black_hat_scriptable setscriptablepartstate( #"hacking", #"start" );
        }
        
        black_hat_data.targetent thread utility::callsharedfunc( level.black_hat_target_info[ black_hat_data.targetref ].callbackcategory, #"start_hacking", { #hacker:self, #black_hat_data:black_hat_data } );
    }
}

// Namespace black_hat
// Params 1, eflags: 0x4
// Checksum 0x9e7910ab, Offset: 0x258a
// Size: 0xc4
function private function_5eca3afcbbdda087( black_hat_data )
{
    if ( black_hat_data.var_11a63b6058455078 )
    {
        increment = gettime() - black_hat_data.var_11a63b6058455078;
        
        if ( black_hat_data.bundle.var_c7709714d768097c && supers_mp::function_d45945781d29204a( "super_black_hat", black_hat_data.bundle.var_c7709714d768097c ) )
        {
            increment *= black_hat_data.bundle.var_13a31706d0d0705a ?? 1;
        }
        
        black_hat_data.var_aa778d21f7d75252 += increment;
        function_bdb762bca55b5265( black_hat_data );
    }
    
    black_hat_data.var_11a63b6058455078 = gettime();
}

// Namespace black_hat
// Params 1, eflags: 0x4
// Checksum 0x8d04fd38, Offset: 0x2656
// Size: 0x6c
function private function_b770cc3b02530da( black_hat_data )
{
    black_hat_data.var_11a63b6058455078 = undefined;
    black_hat_data.var_16861543e02db952 = undefined;
    
    if ( self.black_hat_scriptable getscriptablepartstate( #"hacking" ) != #"success" )
    {
        self.black_hat_scriptable setscriptablepartstate( #"hacking", #"interrupted" );
    }
    
    function_443d9af0ce83272();
}

// Namespace black_hat
// Params 2, eflags: 0x4
// Checksum 0xc44f94b0, Offset: 0x26ca
// Size: 0xd4
function private function_7acd421e5925ea0b( black_hat_data, var_2e1fb2c92f11e450 )
{
    self endon( #"death_or_disconnect" );
    function_8a031a8ab0c15721( black_hat_data );
    
    if ( self.black_hat_scriptable )
    {
        self.black_hat_scriptable setscriptablepartstate( #"hash_e5b9d7bf0e2cd120", #"off" );
    }
    
    if ( var_2e1fb2c92f11e450 )
    {
        function_4da3de04c17549d1( black_hat_data, black_hat_data.bundle.var_892aa7c3f0e4873a );
    }
    
    if ( black_hat_data )
    {
        if ( var_2e1fb2c92f11e450 )
        {
            black_hat_data.hackingent = undefined;
            black_hat_data.var_aa778d21f7d75252 = undefined;
            black_hat_data.var_11a63b6058455078 = undefined;
            black_hat_data.hackingsuccess = undefined;
        }
        
        black_hat_data.targetent = undefined;
        black_hat_data.targetref = undefined;
        function_f10d8142d524ac1( undefined );
    }
    
    function_443d9af0ce83272();
}

// Namespace black_hat
// Params 1
// Checksum 0xc29bcfd5, Offset: 0x27a6
// Size: 0x3e, Type: bool
function is_hacking_successful( black_hat_data )
{
    return black_hat_data.hackingsuccess || black_hat_data.hackingent && black_hat_data.var_aa778d21f7d75252 >= function_3f9bbe6ef7cf029( black_hat_data );
}

// Namespace black_hat
// Params 1, eflags: 0x4
// Checksum 0x6c7bbc5f, Offset: 0x27ed
// Size: 0x178
function private successfully_hack( black_hat_data )
{
    self endon( #"death_or_disconnect" );
    use_weapon = level.superglobals.staticsuperdata[ "super_black_hat" ].useweapon;
    black_hat_data.hackingsuccess = 1;
    black_hat_data.hackingent.var_b57d118f387faec7 = 1;
    function_73d2ff9bd016634a( black_hat_data );
    
    if ( self.black_hat_scriptable )
    {
        self.black_hat_scriptable setscriptablepartstate( #"hacking", #"success" );
    }
    
    params = { #weaponref:black_hat_data.weaponref, #victimorigin:black_hat_data.hackingent.origin };
    callback::callback( "super_black_hat_success_hack", params );
    
    if ( function_8dfe0d5f9a71839a( black_hat_data ) )
    {
        function_5b89eee994243e7( params, black_hat_data );
    }
    
    function_7acd421e5925ea0b( black_hat_data, 1 );
    self setweaponammoclip( use_weapon, self getcurrentweaponclipammo() - 1 );
    superinfo = supers_mp::getcurrentsuper( supers_mp::getsuperslot( "super_black_hat" ) );
    superinfo.allowrefund = 0;
    use_weapon = level.superglobals.staticsuperdata[ "super_black_hat" ].useweapon;
    self notify( #"weapon_fired", use_weapon );
}

// Namespace black_hat
// Params 2, eflags: 0xc
// Checksum 0x36d2d1db, Offset: 0x296d
// Size: 0x83
function private function_4da3de04c17549d1( black_hat_data, cooldown )
{
    self notify( #"hash_9996fdc2d2171aeb" );
    self endon( #"hash_9996fdc2d2171aeb" );
    self endon( #"hash_7cf2cad15a59cd4d", #"death", #"disconnect", #"black_hat_end" );
    
    if ( !black_hat_data || !cooldown )
    {
        return;
    }
    
    black_hat_data.var_892aa7c3f0e4873a = 1;
    wait cooldown;
    
    if ( black_hat_data )
    {
        black_hat_data.var_892aa7c3f0e4873a = undefined;
    }
}

// Namespace black_hat
// Params 1
// Checksum 0x2fbdbb6c, Offset: 0x29f8
// Size: 0x19
function function_c01f5daeb3575bca( target_ent )
{
    target_ent.var_70e5107fa80844df = 0;
}

// Namespace black_hat
// Params 1, eflags: 0x4
// Checksum 0x3359f0c1, Offset: 0x2a19
// Size: 0x1b, Type: bool
function private function_40137c7634157753( target_ent )
{
    return target_ent.var_70e5107fa80844df ?? 0;
}

// Namespace black_hat
// Params 3, eflags: 0x4
// Checksum 0x8c38a577, Offset: 0x2a3d
// Size: 0x7e
function private function_901c6ac0c2cbfaa8( target_ent, var_bb518dbbcf4bc35d, hack_count )
{
    hack_info = get_upgrade_target_info( var_bb518dbbcf4bc35d ) ?? level.black_hat_target_info[ var_bb518dbbcf4bc35d ];
    
    if ( !hack_info )
    {
        return 0;
    }
    
    sequence_size = hack_info.var_b54ffda5b082d46a.size;
    
    if ( target_ent.var_efff1f4e9c80f6a5 && hack_count % sequence_size == 0 )
    {
        return sequence_size;
    }
    
    return hack_count % sequence_size;
}

// Namespace black_hat
// Params 2, eflags: 0x4
// Checksum 0xab2a9ef4, Offset: 0x2ac4
// Size: 0xea
function private function_a368bb34abc087aa( var_bb518dbbcf4bc35d, target_ent )
{
    if ( !level.black_hat_target_info[ var_bb518dbbcf4bc35d ] )
    {
        return;
    }
    
    var_a7a1772eaed810c8 = get_upgrade_target_info( var_bb518dbbcf4bc35d ) ?? level.black_hat_target_info[ var_bb518dbbcf4bc35d ];
    var_3636bc277324accc = var_a7a1772eaed810c8.var_b54ffda5b082d46a;
    
    if ( !var_3636bc277324accc || var_3636bc277324accc.size == 0 )
    {
        return;
    }
    
    var_1110277e317893f2 = self.black_hat_data.var_4f771571f5fc876e ?? function_40137c7634157753( target_ent );
    
    if ( function_f4ccd81edcca6dab( target_ent, var_bb518dbbcf4bc35d ) )
    {
        return;
    }
    
    if ( var_a7a1772eaed810c8.var_3a801ae958e17e84 )
    {
        if ( var_1110277e317893f2 >= var_3636bc277324accc.size )
        {
            var_b70054bec8823252 = var_3636bc277324accc[ var_3636bc277324accc.size - 1 ];
            return var_b70054bec8823252;
        }
    }
    
    var_e04d39c1e834c8fc = var_1110277e317893f2 % var_3636bc277324accc.size;
    function_194c56b6eb0b075e( var_e04d39c1e834c8fc );
    return var_3636bc277324accc[ var_e04d39c1e834c8fc ];
}

// Namespace black_hat
// Params 1, eflags: 0x4
// Checksum 0x24cdb673, Offset: 0x2bb7
// Size: 0xa7
function private get_upgrade_target_info( var_bb518dbbcf4bc35d )
{
    var_37ba3c58eb95312c = utility::callsharedfunc( "super_black_hat", #"hash_7af2b8cfb2b3a6c" );
    
    foreach ( target in var_37ba3c58eb95312c )
    {
        if ( target.reference == var_bb518dbbcf4bc35d )
        {
            return target;
        }
    }
}

// Namespace black_hat
// Params 1, eflags: 0x4
// Checksum 0xfb5ec4e4, Offset: 0x2c67
// Size: 0x63
function private function_12a5c3401fda8898( black_hat_data )
{
    ref = black_hat_data.targetref;
    
    if ( !ref )
    {
        return "";
    }
    
    var_5e320238033ce8bf = function_a368bb34abc087aa( ref, black_hat_data.targetent );
    
    if ( !var_5e320238033ce8bf )
    {
        return "";
    }
    
    return var_5e320238033ce8bf.displaytext;
}

// Namespace black_hat
// Params 1, eflags: 0x4
// Checksum 0xe661bf00, Offset: 0x2cd3
// Size: 0x66
function private function_3f9bbe6ef7cf029( black_hat_data )
{
    assert( isdefined( black_hat_data.hackingent ) );
    var_5e320238033ce8bf = function_a368bb34abc087aa( black_hat_data.targetref, black_hat_data.hackingent );
    
    if ( !var_5e320238033ce8bf )
    {
        return;
    }
    
    var_25aa019c4f8161ab = var_5e320238033ce8bf.var_c9579e1ee394d8e3;
    return var_25aa019c4f8161ab;
}

// Namespace black_hat
// Params 1, eflags: 0x4
// Checksum 0xc58a3b7a, Offset: 0x2d42
// Size: 0xb4
function private function_ea54a2d54bed3bb8( black_hat_data )
{
    if ( !isent( black_hat_data.targetent ) )
    {
        return;
    }
    
    bundle = black_hat_data.bundle;
    targetoutline = bundle.var_584b892b760254e7;
    
    if ( !targetoutline )
    {
        return;
    }
    
    var_408b5c71282b4baa = bundle.var_1b7028b97ebcf896;
    
    if ( !var_408b5c71282b4baa )
    {
        assertmsg( "<dev string:x128>" );
        return;
    }
    
    black_hat_data.var_482c93339fb54686 = outline::outlineenableforplayer( black_hat_data.targetent, self, targetoutline, var_408b5c71282b4baa );
    black_hat_data.var_1a16a488b7a373a8 = black_hat_data.targetent;
}

// Namespace black_hat
// Params 1, eflags: 0x4
// Checksum 0x28644eab, Offset: 0x2dfe
// Size: 0x44
function private function_f4180144ae0a7ecf( black_hat_data )
{
    if ( !black_hat_data.var_482c93339fb54686 )
    {
        return;
    }
    
    outline::outlinedisable( black_hat_data.var_482c93339fb54686, black_hat_data.var_3b32f7710e94e243 );
    black_hat_data.var_482c93339fb54686 = undefined;
}

// Namespace black_hat
// Params 1, eflags: 0x4
// Checksum 0xefd270fe, Offset: 0x2e4a
// Size: 0xc0
function private function_17c59e04339a161f( black_hat_data )
{
    text = function_12a5c3401fda8898( black_hat_data );
    black_hat_data.var_e13d3736b8856cd9 = hud_util::createfontstring( "default", 1 );
    black_hat_data.var_e13d3736b8856cd9.color = ( 1, 1, 1 );
    black_hat_data.var_e13d3736b8856cd9.alpha = 1;
    black_hat_data.var_e13d3736b8856cd9.sort = 1;
    black_hat_data.var_e13d3736b8856cd9 hud_util::setpoint( "CENTER", "BOTTOM", 0, -225 );
    black_hat_data.var_e13d3736b8856cd9 settext( text );
}

// Namespace black_hat
// Params 1, eflags: 0x4
// Checksum 0xea7343a2, Offset: 0x2f12
// Size: 0x3a
function private function_ee7e6f3ad8730c44( black_hat_data )
{
    if ( !isdefined( black_hat_data.var_e13d3736b8856cd9 ) )
    {
        return;
    }
    
    black_hat_data.var_e13d3736b8856cd9 hud_util::destroyelem();
    black_hat_data.var_e13d3736b8856cd9 = undefined;
}

// Namespace black_hat
// Params 1, eflags: 0x4
// Checksum 0x4e856e48, Offset: 0x2f54
// Size: 0x93
function private function_c511d8bb77af850a( black_hat_data )
{
    if ( black_hat_data.var_3b32f7710e94e243 || black_hat_data.var_c63dc78948d98cb7 )
    {
        function_8a031a8ab0c15721( black_hat_data );
    }
    
    function_ea54a2d54bed3bb8( black_hat_data );
    black_hat_data.targetmarkergroup = targetmarkergroups::targetmarkergroup_on( %"blackhattargetmarker", self, black_hat_data.targetent, self, 0, 0 );
    function_17c59e04339a161f( black_hat_data );
    black_hat_data.var_3b32f7710e94e243 = black_hat_data.targetent;
    black_hat_data.var_c63dc78948d98cb7 = 1;
}

// Namespace black_hat
// Params 1, eflags: 0x4
// Checksum 0xa8ce5859, Offset: 0x2fef
// Size: 0x65
function private function_8a031a8ab0c15721( black_hat_data )
{
    function_f4180144ae0a7ecf( black_hat_data );
    
    if ( isdefined( black_hat_data.targetmarkergroup ) )
    {
        targetmarkergroups::targetmarkergroup_off( black_hat_data.targetmarkergroup );
        black_hat_data.targetmarkergroup = undefined;
    }
    
    function_ee7e6f3ad8730c44( black_hat_data );
    
    if ( black_hat_data )
    {
        black_hat_data.var_3b32f7710e94e243 = undefined;
        black_hat_data.var_c63dc78948d98cb7 = undefined;
    }
}

// Namespace black_hat
// Params 1, eflags: 0x4
// Checksum 0x73884ce3, Offset: 0x305c
// Size: 0x9c
function private function_3ebf486b28800872( black_hat_data )
{
    if ( black_hat_data.state != "stowed" && black_hat_data.targetent )
    {
        function_c511d8bb77af850a( black_hat_data );
        
        if ( self.black_hat_scriptable )
        {
            self.black_hat_scriptable setscriptablepartstate( #"hash_e5b9d7bf0e2cd120", #"hash_33a620f317c602f5" );
        }
        
        return;
    }
    
    function_8a031a8ab0c15721( black_hat_data );
    
    if ( self.black_hat_scriptable )
    {
        self.black_hat_scriptable setscriptablepartstate( #"hash_e5b9d7bf0e2cd120", #"off" );
    }
}

// Namespace black_hat
// Params 1, eflags: 0x4
// Checksum 0xaa8bad15, Offset: 0x3100
// Size: 0x32
function private function_bdb762bca55b5265( black_hat_data )
{
    self setclientomnvar( "ui_super_hacking_progress", clamp( black_hat_data.var_aa778d21f7d75252 / function_3f9bbe6ef7cf029( black_hat_data ), 0, 1 ) );
}

// Namespace black_hat
// Params 0, eflags: 0x4
// Checksum 0x64fae355, Offset: 0x313a
// Size: 0xe
function private function_443d9af0ce83272()
{
    self setclientomnvar( "ui_super_hacking_progress", 0 );
}

// Namespace black_hat
// Params 1, eflags: 0x4
// Checksum 0xe594880, Offset: 0x3150
// Size: 0x226
function private function_73d2ff9bd016634a( black_hat_data )
{
    target_ent = black_hat_data.hackingent;
    var_bb518dbbcf4bc35d = black_hat_data.targetref;
    function_ccc96bfbc52ba2bb( black_hat_data );
    var_5e320238033ce8bf = black_hat_data.var_16861543e02db952 ?? function_a368bb34abc087aa( var_bb518dbbcf4bc35d, target_ent );
    function_951a1c4892011a4( var_5e320238033ce8bf );
    utility::callsharedfunc( #"challenges", #"hash_c1ac67fc66891430", "super_black_hat", ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"hit" ), undefined, istrue( var_5e320238033ce8bf.var_30e7de3d76d5a085 ), target_ent );
    target_ent.var_c9c451cb47c1bee = gettime();
    
    if ( var_bb518dbbcf4bc35d == "player" )
    {
        thread hack_player( black_hat_data, target_ent );
        return;
    }
    
    thread gamelogic_mp::threadedsetweaponstatbyname( black_hat_data.weaponref, 1, "equipment_steals" );
    target_ent.var_1e6b5fa50d2b6d73 = black_hat_data.weaponref;
    target_ent.var_efff1f4e9c80f6a5 = 1;
    target_ent.var_70e5107fa80844df = ( black_hat_data.var_4f771571f5fc876e ?? function_40137c7634157753( target_ent ) ) + 1;
    function_4f6a19bf9c130ab8( target_ent, var_bb518dbbcf4bc35d, target_ent.var_70e5107fa80844df );
    var_5e320238033ce8bf.var_bfc0167eb5f93d9d = target_ent function_7d622cc6e1c4fd5a( var_5e320238033ce8bf.var_96829da7e36878f0 );
    target_ent function_31f3397d9a448b16( var_5e320238033ce8bf );
    bundle = black_hat_data.bundle;
    soundevent = var_5e320238033ce8bf.var_30e7de3d76d5a085 ? bundle.var_396477244ef595df : bundle.var_7f4e844e515e0ae9;
    level thread battlechatter_mp::trysaylocalsound( self, soundevent );
    function_4897384019513631( target_ent, var_bb518dbbcf4bc35d, var_5e320238033ce8bf, black_hat_data.weaponref );
    function_3be13921a575c2d4( black_hat_data, target_ent, var_5e320238033ce8bf.var_96829da7e36878f0 );
    apply_score_events( var_5e320238033ce8bf );
    thread function_fc410179f860951e( target_ent, var_bb518dbbcf4bc35d, var_5e320238033ce8bf );
    thread function_7aa56c1e373974f5( black_hat_data, target_ent, var_5e320238033ce8bf );
    target_ent thread function_e944ee22d6d82779( var_5e320238033ce8bf.hackduration );
}

// Namespace black_hat
// Params 2, eflags: 0x4
// Checksum 0x5972e7a3, Offset: 0x337e
// Size: 0x68, Type: bool
function private function_35facb7d868ddf1e( target_ent, var_bb518dbbcf4bc35d )
{
    hack_info = level.black_hat_target_info[ var_bb518dbbcf4bc35d ];
    hack_sequence = hack_info.var_b54ffda5b082d46a;
    var_20a64db112c2ad99 = function_a044b7c608d34f7e( target_ent, var_bb518dbbcf4bc35d );
    
    if ( var_20a64db112c2ad99 != 0 )
    {
        return false;
    }
    
    return !function_f4ccd81edcca6dab( target_ent, var_bb518dbbcf4bc35d );
}

// Namespace black_hat
// Params 2, eflags: 0x4
// Checksum 0xd73082bd, Offset: 0x33ef
// Size: 0x50
function private function_a044b7c608d34f7e( target_ent, var_bb518dbbcf4bc35d )
{
    hack_info = get_upgrade_target_info( var_bb518dbbcf4bc35d ) ?? level.black_hat_target_info[ var_bb518dbbcf4bc35d ];
    return target_ent.var_70e5107fa80844df % hack_info.var_b54ffda5b082d46a.size;
}

// Namespace black_hat
// Params 1, eflags: 0x4
// Checksum 0xbd8628d1, Offset: 0x3448
// Size: 0x9b
function private apply_score_events( var_5e320238033ce8bf )
{
    loot_id = level.superglobals.staticsuperdata[ "super_black_hat" ].bundle.lootid;
    
    if ( !var_5e320238033ce8bf.var_bfc0167eb5f93d9d && var_5e320238033ce8bf.var_96829da7e36878f0 > 0 )
    {
        thread points::function_f8a0deb1a12da52e( #"blackhat_damage", undefined, loot_id );
    }
    
    if ( var_5e320238033ce8bf.scoreevent )
    {
        thread points::function_f8a0deb1a12da52e( var_5e320238033ce8bf.scoreevent, undefined, loot_id );
    }
}

// Namespace black_hat
// Params 1, eflags: 0x4
// Checksum 0xed63c54d, Offset: 0x34eb
// Size: 0x41
function private function_e944ee22d6d82779( hack_duration_ms )
{
    self endon( #"death_or_disconnect" );
    
    if ( hack_duration_ms )
    {
        wait hack_duration_ms * 0.001;
    }
    
    if ( isent( self ) && isalive( self ) )
    {
        self.var_b57d118f387faec7 = 0;
    }
}

// Namespace black_hat
// Params 1, eflags: 0x4
// Checksum 0x3e4cf34d, Offset: 0x3534
// Size: 0x8c
function private function_31f3397d9a448b16( var_5e320238033ce8bf )
{
    if ( var_5e320238033ce8bf.var_836e43aa1bc9ce9a )
    {
        if ( !self getscriptableparthasstate( #"hack", #"hack_shocked" ) )
        {
            assertmsg( "<dev string:x14a>" + self.classname + "<dev string:x159>" );
        }
        
        if ( var_5e320238033ce8bf.var_bfc0167eb5f93d9d )
        {
            callback::add( "killed_body_cloned", &function_7f3a2bf787eb405 );
            return;
        }
        
        self setscriptablepartstate( #"hack", #"hack_shocked" );
    }
}

// Namespace black_hat
// Params 1, eflags: 0x4
// Checksum 0xaa2b8206, Offset: 0x35c8
// Size: 0x2e
function private function_7f3a2bf787eb405( params )
{
    params.body setscriptablepartstate( #"hack", #"hack_shocked" );
}

// Namespace black_hat
// Params 1, eflags: 0x4
// Checksum 0xda6125f7, Offset: 0x35fe
// Size: 0x63, Type: bool
function private function_7d622cc6e1c4fd5a( proportional_damage )
{
    if ( !proportional_damage || proportional_damage == 0 )
    {
        return false;
    }
    
    if ( self.maxhealth )
    {
        dealt_damage = self.maxhealth * proportional_damage;
        return ( proportional_damage == 1 || self.health - dealt_damage <= 0 );
    }
    
    return self.maxhealth <= 0;
}

// Namespace black_hat
// Params 4, eflags: 0x4
// Checksum 0x8155fc1c, Offset: 0x366a
// Size: 0x87
function private function_4897384019513631( target_ent, var_bb518dbbcf4bc35d, var_5e320238033ce8bf, weapon_ref )
{
    if ( var_5e320238033ce8bf.var_c682bb21b0b479dd )
    {
        thread function_6e6cd8b67cc0b559( target_ent, var_5e320238033ce8bf.hackduration, weapon_ref );
        return;
    }
    
    var_5e320238033ce8bf.var_fe6111ff085b2063 = 1;
    target_ent thread utility::callsharedfunc( level.black_hat_target_info[ var_bb518dbbcf4bc35d ].callbackcategory, #"hack", var_5e320238033ce8bf, self );
}

// Namespace black_hat
// Params 3, eflags: 0x4
// Checksum 0x8c5b9985, Offset: 0x36f9
// Size: 0xdf
function private function_6e6cd8b67cc0b559( target_ent, wait_time, weapon_ref )
{
    target_ent endon( #"death" );
    var_f0f21071d94cee1 = target_ent.team;
    var_dfcb65d17fe2fd44 = target_ent.health;
    target_ent [[ utility::getsharedfunc( #"zombie_utils", #"turn_ai" ) ]]( self, { #state:"brainrot_on", #part:"brainrot" } );
    wait wait_time * 0.001;
    target_ent [[ utility::getsharedfunc( #"zombie_utils", #"turn_ai_back" ) ]]( var_f0f21071d94cee1, "brainrot", "brainrot_off" );
    target_ent.skipdeathcount = 1;
    target_ent.health = var_dfcb65d17fe2fd44;
}

// Namespace black_hat
// Params 3, eflags: 0x4
// Checksum 0xfe5e099c, Offset: 0x37e0
// Size: 0xbc
function private function_fc410179f860951e( target_ent, var_bb518dbbcf4bc35d, var_5e320238033ce8bf )
{
    target_ent endon( #"death" );
    self endon( #"cancel_black_hat" );
    var_4f771571f5fc876e = target_ent.var_70e5107fa80844df;
    hackduration = var_5e320238033ce8bf.hackduration;
    
    if ( hackduration )
    {
        wait hackduration * 0.001;
    }
    
    if ( target_ent.var_70e5107fa80844df != var_4f771571f5fc876e )
    {
        return;
    }
    
    if ( var_5e320238033ce8bf.var_51490c6bee880b45 )
    {
        target_ent.var_70e5107fa80844df--;
    }
    
    if ( function_35facb7d868ddf1e( target_ent, var_bb518dbbcf4bc35d ) )
    {
        target_ent.var_efff1f4e9c80f6a5 = undefined;
        function_8bde032086301530( 0 );
    }
}

// Namespace black_hat
// Params 1, eflags: 0x4
// Checksum 0x7d8f3f3f, Offset: 0x38a4
// Size: 0x73
function private function_ccc96bfbc52ba2bb( black_hat_data )
{
    owner = undefined;
    
    if ( isplayer( black_hat_data.hackingent ) )
    {
        owner = black_hat_data.hackingent;
    }
    
    if ( owner )
    {
        owner utility::function_32b24db3127bff40( #"black_hat", #"off" );
        owner utility::function_32b24db3127bff40( #"black_hat", #"hack_success" );
    }
}

// Namespace black_hat
// Params 2
// Checksum 0xe81ebc9d, Offset: 0x391f
// Size: 0x35b
function hack_player( black_hat_data, target )
{
    bundle = black_hat_data.bundle;
    black_hat_weapon = black_hat_data.weaponref;
    data = damage_utility::packdamagedata( self, target, 1, black_hat_weapon );
    data.var_7563c9e8d353ca9a = &function_f4e42fe0a77d94b4;
    emp_debuff::apply_emp_struct( data, 0, 1 );
    level thread battlechatter_mp::trysaylocalsound( self, bundle.var_7f4e844e515e0ae9 );
    gamescore::trackdebuffassist( self, target, black_hat_weapon.basename );
    telemetry_mp::function_594cbdc6a4d8098a( target, black_hat_data.owner, black_hat_data.weaponref, target.var_c9c451cb47c1bee );
    
    if ( bundle.var_2ad1f7a54064db67 )
    {
        target emp_debuff::play_emp_scramble( bundle.var_46cc13ca23ff97dd, 1 );
        target utility::function_32b24db3127bff40( #"black_hat", #"jammed" );
    }
    
    if ( target.var_f997d7e36fbef3af )
    {
        foreach ( callback in target.var_f997d7e36fbef3af )
        {
            target [[ callback ]]();
        }
    }
    
    target.var_b57d118f387faec7 = 1;
    target.var_efff1f4e9c80f6a5 = 1;
    target.var_dd4aae4990623aea[ self getentitynumber() ] = gettime();
    target.var_70e5107fa80844df = ( black_hat_data.var_4f771571f5fc876e ?? function_40137c7634157753( target ) ) + 1;
    function_4f6a19bf9c130ab8( target, black_hat_data.targetref, target.var_70e5107fa80844df );
    target thread function_56c1fed3b55a8a5a();
    function_b262ef3b6aea5f88( target, bundle.var_f7dc10c3060ff7e2 );
    
    if ( target )
    {
        target emp_debuff::remove_emp();
        
        if ( bundle.var_2ad1f7a54064db67 )
        {
            target emp_debuff::stop_emp_scramble( bundle.var_46cc13ca23ff97dd, 1 );
            
            if ( target getscriptablepartstate( #"black_hat" ) == #"jammed" )
            {
                target setscriptablepartstate( #"black_hat", #"off" );
            }
        }
        
        if ( self && player::isreallyalive( self ) )
        {
            gamescore::untrackdebuffassist( self, target, black_hat_weapon.basename );
            telemetry_mp::function_edb43d25c7bd56c6( target, black_hat_weapon, target.var_c9c451cb47c1bee );
        }
        
        if ( target.var_14a1cc3e3b76a02c )
        {
            foreach ( callback in target.var_14a1cc3e3b76a02c )
            {
                target [[ callback ]]();
            }
        }
        
        target.var_b57d118f387faec7 = undefined;
        target.var_efff1f4e9c80f6a5 = undefined;
        target.var_c9c451cb47c1bee = undefined;
    }
}

// Namespace black_hat
// Params 1, eflags: 0x4
// Checksum 0x7431f3b3, Offset: 0x3c82
// Size: 0x6e
function private function_f4e42fe0a77d94b4( data )
{
    bundle = level.superglobals.staticsuperdata[ "super_black_hat" ].bundle;
    data.attacker thread points::function_f8a0deb1a12da52e( bundle.var_1205dd579798b374, data.objweapon, bundle.lootid );
}

// Namespace black_hat
// Params 2, eflags: 0x4
// Checksum 0x96991d64, Offset: 0x3cf8
// Size: 0x31
function private function_b262ef3b6aea5f88( target, duration )
{
    target endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    wait duration;
}

// Namespace black_hat
// Params 3, eflags: 0x4
// Checksum 0xd29076b0, Offset: 0x3d31
// Size: 0x107
function private function_3be13921a575c2d4( black_hat_data, target_ent, proportional_damage )
{
    waitframe();
    
    if ( proportional_damage )
    {
        if ( target_ent.maxhealth )
        {
            armored_bones = target_ent metabone::function_30d906ccb9fe2142();
            
            foreach ( bone_name in armored_bones )
            {
                bone_health = target_ent metabone::get_metabone_health( bone_name );
                
                if ( bone_health )
                {
                    target_ent metabone::damage_metabone( bone_name, bone_health * proportional_damage, self, self, undefined );
                }
            }
            
            target_ent dodamage( target_ent.maxhealth * proportional_damage, self getvieworigin(), self, self, "MOD_UNKNOWN", black_hat_data.weaponref, "torso_upper" );
        }
    }
}

// Namespace black_hat
// Params 3, eflags: 0x4
// Checksum 0x33fb8d5f, Offset: 0x3e40
// Size: 0x7e
function private function_7aa56c1e373974f5( black_hat_data, target_ent, var_5e320238033ce8bf )
{
    self endon( #"death_or_disconnect" );
    target_ent endon( #"death" );
    
    if ( var_5e320238033ce8bf.var_3a75845dc2e014fb )
    {
        wait ( var_5e320238033ce8bf.var_da4fcceacff258fb ?? var_5e320238033ce8bf.hackduration ?? 0 ) * 0.001;
        function_3be13921a575c2d4( black_hat_data, target_ent, var_5e320238033ce8bf.var_3a75845dc2e014fb );
    }
}

// Namespace black_hat
// Params 3
// Checksum 0x74aae59a, Offset: 0x3ec6
// Size: 0x72
function function_67f7849d1b909800( key, var_115cb9b18192655f, endhack )
{
    if ( var_115cb9b18192655f )
    {
        if ( !self.var_f997d7e36fbef3af )
        {
            self.var_f997d7e36fbef3af = [];
        }
        
        self.var_f997d7e36fbef3af[ key ] = var_115cb9b18192655f;
    }
    
    if ( endhack )
    {
        if ( !self.var_14a1cc3e3b76a02c )
        {
            self.var_14a1cc3e3b76a02c = [];
        }
        
        self.var_14a1cc3e3b76a02c[ key ] = endhack;
    }
}

// Namespace black_hat
// Params 1
// Checksum 0xab355708, Offset: 0x3f40
// Size: 0x3c
function function_d77bf7a46d5c6fc4( key )
{
    if ( self.var_f997d7e36fbef3af )
    {
        self.var_f997d7e36fbef3af[ key ] = undefined;
    }
    
    if ( self.var_14a1cc3e3b76a02c )
    {
        self.var_14a1cc3e3b76a02c[ key ] = undefined;
    }
}

// Namespace black_hat
// Params 0
// Checksum 0x14e2b39e, Offset: 0x3f84
// Size: 0x87
function function_56c1fed3b55a8a5a()
{
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        if ( !self.var_b57d118f387faec7 )
        {
            return;
        }
        
        if ( self.super.isactive )
        {
            waitframe();
            continue;
        }
        
        if ( self superbuttonpressed() )
        {
            if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
            {
                self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"mp/supers_unavailable" );
            }
        }
        
        waitframe();
    }
}

// Namespace black_hat
// Params 1
// Checksum 0xbab5ca55, Offset: 0x4013
// Size: 0x68
function function_19b1d3d432812bda( hackingstate )
{
    if ( isdefined( hackingstate ) )
    {
        var_76449469140a7d2b = undefined;
        
        if ( hackingstate == "stowed" )
        {
            var_76449469140a7d2b = 0;
        }
        else if ( hackingstate == "using" )
        {
            var_76449469140a7d2b = 1;
        }
        else if ( hackingstate == "hacking" )
        {
            var_76449469140a7d2b = 2;
        }
        
        if ( isdefined( var_76449469140a7d2b ) )
        {
            omnvar_utility::function_85d5f88af471ac4b( "ui_super_black_hat_hacking_data", 0, 3, var_76449469140a7d2b );
        }
    }
}

// Namespace black_hat
// Params 1
// Checksum 0x31aa079a, Offset: 0x4083
// Size: 0x4c
function function_f10d8142d524ac1( ref )
{
    targettype = level.black_hat_target_info[ ref ].var_a8b5c5b59e8ce3e6;
    
    if ( !isdefined( targettype ) )
    {
        targettype = -1;
    }
    
    omnvar_utility::function_85d5f88af471ac4b( "ui_super_black_hat_hacking_data", 3, 8, targettype + 1 );
}

// Namespace black_hat
// Params 1
// Checksum 0xf42696e0, Offset: 0x40d7
// Size: 0x24
function function_194c56b6eb0b075e( var_ff61dc169509160c )
{
    if ( isdefined( var_ff61dc169509160c ) )
    {
        omnvar_utility::function_85d5f88af471ac4b( "ui_super_black_hat_hacking_data", 11, 3, var_ff61dc169509160c );
    }
}

// Namespace black_hat
// Params 1
// Checksum 0x5d74c694, Offset: 0x4103
// Size: 0x24
function function_8bde032086301530( hackcount )
{
    if ( isdefined( hackcount ) )
    {
        omnvar_utility::function_85d5f88af471ac4b( "ui_super_black_hat_hacking_data", 14, 3, hackcount );
    }
}

// Namespace black_hat
// Params 1
// Checksum 0x335467bb, Offset: 0x412f
// Size: 0x1e
function function_e979988ab0a88e01( buttonpressed )
{
    omnvar_utility::function_85d5f88af471ac4b( "ui_super_black_hat_hacking_data", 17, 1, buttonpressed );
}

// Namespace black_hat
// Params 1
// Checksum 0xc0f7a949, Offset: 0x4155
// Size: 0x1e
function function_5d4acc35d65544a8( upgradetier )
{
    omnvar_utility::function_85d5f88af471ac4b( "ui_super_black_hat_hacking_data", 18, 2, upgradetier );
}

// Namespace black_hat
// Params 1, eflags: 0x4
// Checksum 0x4110f9b2, Offset: 0x417b
// Size: 0x5f
function private function_8dfe0d5f9a71839a( black_hat_data )
{
    if ( !black_hat_data.explosion_data )
    {
        return;
    }
    
    var_bb518dbbcf4bc35d = black_hat_data.targetref;
    target_info = get_upgrade_target_info( var_bb518dbbcf4bc35d ) ?? level.black_hat_target_info[ var_bb518dbbcf4bc35d ];
    return target_info.var_664fba54ef4a86bb;
}

// Namespace black_hat
// Params 2, eflags: 0x4
// Checksum 0xde5af839, Offset: 0x41e3
// Size: 0x1f0
function private function_5b89eee994243e7( params, black_hat_data )
{
    assert( black_hat_data.explosion_data );
    data = black_hat_data.explosion_data;
    victim_origin = params.victimorigin;
    
    if ( !victim_origin )
    {
        return;
    }
    
    fx = utility::getfx( data.vfx );
    playfx( fx, victim_origin );
    playsoundatpos( victim_origin, data.sfx );
    
    /#
        if ( getdvarint( @"black_hat_elec_explosion_debug", 0 ) )
        {
            sphere( victim_origin, data.radius, ( 1, 0, 0 ), 1, 30 );
        }
    #/
    
    ai_in_radius = getaiarrayinradius( victim_origin, data.radius );
    
    foreach ( enemy in ai_in_radius )
    {
        if ( !isalive( enemy ) )
        {
            continue;
        }
        
        if ( self.team == enemy.team )
        {
            continue;
        }
        
        enemy_tier = enemy ai_utility::get_power_tier();
        assert( enemy_tier, "<dev string:x196>" );
        
        if ( enemy_tier > data.var_c04e417f8531bdb5 )
        {
            continue;
        }
        
        enemy dodamage( data.damage, victim_origin, self, self, "MOD_ELEMENTAL_ELEC", params.weaponref, "none", undefined, 65537 );
        
        if ( data.stun_chance )
        {
            function_fd928c67b484298d( enemy, data, victim_origin );
        }
    }
}

// Namespace black_hat
// Params 3, eflags: 0x4
// Checksum 0x82bbf9ce, Offset: 0x43db
// Size: 0xec
function private function_fd928c67b484298d( victim, data, stun_origin )
{
    if ( !isalive( victim ) )
    {
        return;
    }
    
    if ( victim.var_cc997278e6e6e01[ "super_black_hat" ] )
    {
        return;
    }
    
    victim_tier = victim ai_utility::get_power_tier();
    assert( victim_tier, "<dev string:x196>" );
    
    if ( data.stun_max_tier && victim_tier > data.stun_max_tier )
    {
        return;
    }
    
    if ( !utility::percent_chance( data.stun_chance ) )
    {
        return;
    }
    
    stun_data = { #aistunduration:data.stun_duration, #source:"super_black_hat", #stunorigin:stun_origin };
    thread utility::callsharedfunc( #"stun", #"hash_349a1ff838f53f63", stun_data, victim );
}

// Namespace black_hat
// Params 1
// Checksum 0x9054b576, Offset: 0x44cf
// Size: 0x10e
function function_6a4dc66cc77c88c1( deathdata )
{
    inflictor = deathdata.inflictor;
    victim = deathdata.victim;
    
    if ( inflictor.var_70e5107fa80844df > 0 && isplayer( inflictor.owner ) && player_utility::playersareenemies( inflictor.owner, victim ) )
    {
        inflictor.owner thread points::function_f8a0deb1a12da52e( #"black_hat_kill", deathdata.objweapon, level.superglobals.staticsuperdata[ "super_black_hat" ].bundle.lootid );
        
        if ( inflictor.var_1e6b5fa50d2b6d73 && !isdefined( victim.var_c9c451cb47c1bee ) )
        {
            telemetry_mp::function_594cbdc6a4d8098a( victim, inflictor.owner, inflictor.var_1e6b5fa50d2b6d73, inflictor.var_c9c451cb47c1bee );
        }
    }
}

// Namespace black_hat
// Params 1, eflags: 0x4
// Checksum 0xe2b47c98, Offset: 0x45e5
// Size: 0x7a
function private function_951a1c4892011a4( var_5e320238033ce8bf )
{
    var_5e320238033ce8bf.var_398a78eb264487c3 = self.var_f6ce3f6c3c2ead86.bundle.var_935a27d4b3471b33 ?? var_5e320238033ce8bf.var_398a78eb264487c3;
    var_5e320238033ce8bf.var_80d4290702cc01dc = self.var_f6ce3f6c3c2ead86.bundle.var_f9362c018f0d402c ?? var_5e320238033ce8bf.var_80d4290702cc01dc;
}

