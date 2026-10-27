// scripts\mp\common\supers\active_camo.gsc  (hash_51e351e3fad4f9d2.gscc) (size: 14197 Bytes / 0x3775 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa5ec8927 (2783742247)
// size ...... 14197 (0x3775)
// includes .. 16  (offset: 0x34f9)
// strings ... 25  (offset: 0x3579)
// dev strs .. 4   (offset: 0x3745)
// exports ... 43  (offset: 0x1e99)
// cseg ...... 0x2ba + 0x1bdf (0x1e99)
// imports ... 133 (offset: 0x2551)
// animtree1 . 0   (offset: 0x3775)
// animtree2 . 0   (offset: 0x3775)
#using scripts\anim\battlechatter;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\equipment_utility;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\emp_debuff;
#using scripts\mp\gamelogic;
#using scripts\mp\supers;
#using scripts\mp\telemetry_mp;

#namespace active_camo;

// Namespace active_camo
// Params 0, eflags: 0x5
// Checksum 0x2865ced7, Offset: 0x2d8
// Size: 0x54
function private autoexec main()
{
    level callback::add( #"register_super", &register );
    utility::registersharedfunc( #"player", #"hash_104a5cd5cbb639b6", &function_32ebebc1e0f4707f );
    utility::registersharedfunc( #"player", #"hash_64b07f4926bae8f8", &active_camo_off );
}

// Namespace active_camo
// Params 1, eflags: 0x4
// Checksum 0x651898ab, Offset: 0x334
// Size: 0xf8
function private register( params )
{
    staticdata = level.superglobals.staticsuperdata[ "super_active_camo" ];
    
    if ( !isdefined( staticdata ) )
    {
        return;
    }
    
    bundle = staticdata.bundle;
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    level callback::add( #"hash_2709fd1dd4cef88d", &function_743d80be69a25bc7 );
    level callback::add( #"player_deal_damage", &function_b3ef44fd26e51c0d );
    level callback::add( #"hash_eb54ccc016130a88", &on_player_elim );
    level callback::add( #"on_ai_killed", &function_8fbc04fe84d49b51 );
    level callback::add( #"on_ai_damaged", &function_b3ef44fd26e51c0d );
    supers_mp::function_48aaa60b2ce7b8a1( "super_active_camo", &on_set, &on_unset, &begin_use, &natural_timeout, undefined, undefined, undefined );
    supers_mp::function_19492daedcf2689a( "super_active_camo", &get_use_time );
}

// Namespace active_camo
// Params 0
// Checksum 0xaca4b76e, Offset: 0x434
// Size: 0xd1
function on_set()
{
    bundle = level.superglobals.staticsuperdata[ "super_active_camo" ].bundle;
    
    if ( !isdefined( self.var_6a2d9548aeda69ae ) )
    {
        self.var_6a2d9548aeda69ae = [];
    }
    
    if ( bundle.var_c7709714d768097c && supers_mp::function_d45945781d29204a( "super_active_camo", bundle.var_c7709714d768097c ) )
    {
        self.var_6a2d9548aeda69ae[ "super_active_camo" ] = 1;
        multiplier = bundle.var_47af9aa74b6be883 ?? 1.2;
        perk::giveperk( "specialty_faster_field_upgrade" );
        val::set( "super_active_camo", "field_upgrade_recharge_mult", multiplier );
        return;
    }
    
    self.var_6a2d9548aeda69ae[ "super_active_camo" ] = 0;
}

// Namespace active_camo
// Params 0
// Checksum 0x88b0f01a, Offset: 0x50d
// Size: 0x40
function on_unset()
{
    if ( self.var_6a2d9548aeda69ae[ "super_active_camo" ] )
    {
        val::reset( "super_active_camo", "field_upgrade_recharge_mult" );
        perk::removeperk( "specialty_faster_field_upgrade" );
    }
    
    self.var_6a2d9548aeda69ae[ "super_active_camo" ] = undefined;
}

// Namespace active_camo
// Params 0, eflags: 0x4
// Checksum 0x53b3d56b, Offset: 0x555
// Size: 0x2d
function private watch_game_end()
{
    self endon( #"active_camo_end", #"death_or_disconnect" );
    level waittill( #"game_ended" );
    thread end_active_camo( 1 );
}

// Namespace active_camo
// Params 1
// Checksum 0xc2bbf326, Offset: 0x58a
// Size: 0xa6
function get_use_time( superinfo )
{
    bundle = level.superglobals.staticsuperdata[ "super_active_camo" ].bundle;
    scale = 1;
    
    if ( bundle.var_c7709714d768097c && supers_mp::function_d45945781d29204a( "super_active_camo", bundle.var_c7709714d768097c ) )
    {
        scale = bundle.var_592aae594d6e1b5 ?? 1.2;
    }
    
    base_duration = supers_mp::function_b302d192481449e7( superinfo.staticdata );
    return base_duration * scale;
}

// Namespace active_camo
// Params 0
// Checksum 0x4601fc16, Offset: 0x639
// Size: 0x22f, Type: bool
function begin_use()
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_active_camo" );
    assert( isdefined( bundle ), "<dev string:x24>" );
    
    if ( self isswimunderwater() )
    {
        return false;
    }
    
    end_on_shoot = bundle.var_3d8262e6be67a7ab ?? 1;
    var_78c82ea8d2037230 = bundle.var_a2481b0e2896a117 ?? 1;
    temporary_break_duration = bundle.var_6f95717875953072 ?? 3;
    ai_interaction = bundle.var_a5bfeff3b38dc0ca ?? "DEFAULT";
    emp_disable_effect = bundle.var_9af6a5b4fe31acf3 ?? 0;
    var_25545bb817a1c59a = bundle.var_60b5a2fa042c3187;
    var_bfca32f96a3daa3b = bundle.var_5378a21c925164a8;
    var_8de908367f2fecd6 = bundle.var_1b78adb8dd9dea68;
    start_active_camo();
    
    if ( level.var_36218e71baa7e689 )
    {
        self.var_c5ccf9dff3b5e393 = &function_b47d51259e60b8d3;
    }
    
    thread watch_game_end();
    thread function_ad3bc63d853850df();
    thread function_eb2f31bf271ed564();
    thread function_2432194e1b447d68();
    
    /#
        if ( getdvarint( @"hash_cc8e8c275565e440", 0 ) )
        {
            superinfo = supers_mp::getcurrentsuper();
            self.var_8f921a7892e5cb69 = supers_mp::function_5edde74ac0c929eb( superinfo );
            thread debug_time_remaining();
        }
    #/
    
    if ( end_on_shoot )
    {
        thread function_8ce9d92657b64727();
    }
    
    if ( function_bac15957de6d26a2() )
    {
        thread function_41177027c38191de( var_8de908367f2fecd6 );
    }
    
    if ( bundle.var_ed5f367cc994aae5 )
    {
        thread function_165c31b0f507875d();
    }
    
    if ( var_78c82ea8d2037230 )
    {
        thread function_337b328286098985( temporary_break_duration );
    }
    
    if ( ai_interaction != "DEFAULT" )
    {
        function_ba4c630d6052f964( ai_interaction );
    }
    
    if ( emp_disable_effect )
    {
        function_66ceeedaef99bfea( var_25545bb817a1c59a, var_bfca32f96a3daa3b );
    }
    
    self.active_camo_enabled = 1;
    
    if ( bundle.var_8b9eade13fbfb044 )
    {
        assert( !callback::exists( #"super_cancel", &cancel ) );
        callback::add( #"super_cancel", &cancel );
    }
    
    self notify( #"active_camo_begin" );
    return true;
}

// Namespace active_camo
// Params 0, eflags: 0x4
// Checksum 0x14f7c797, Offset: 0x871
// Size: 0xf3
function private function_2432194e1b447d68()
{
    self endon( #"active_camo_end" );
    self endon( #"death_or_disconnect" );
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_active_camo" );
    superinfo = supers_mp::getcurrentsuper();
    usetime = supers_mp::function_5edde74ac0c929eb( superinfo );
    warningstarttime = bundle.var_e2e14e5cfd979f88 ?? 3;
    
    if ( usetime > warningstarttime )
    {
        wait usetime - warningstarttime;
    }
    
    while ( true )
    {
        if ( !function_67f0dd3e49e8ae97() )
        {
            break;
        }
        
        var_c1b0780ae18afce2 = self getscriptablepartstate( #"active_camo_fx", 1, 1 );
        
        if ( var_c1b0780ae18afce2 == #"super_fx_on" || var_c1b0780ae18afce2 == #"hash_5e9a1b8839da3a02" || var_c1b0780ae18afce2 == #"hash_e40da302d03cdadb" )
        {
            self playlocalsound( "fup_active_camo_timer" );
            wait 1;
            continue;
        }
        
        wait 0.1;
    }
}

/#

    // Namespace active_camo
    // Params 0, eflags: 0xc
    // Checksum 0xf291955, Offset: 0x96c
    // Size: 0xfe, Type: dev
    function private debug_time_remaining()
    {
        self notify( #"hash_665d91c87dc3eb26" );
        self endon( #"hash_665d91c87dc3eb26" );
        self endon( #"active_camo_end" );
        self endon( #"death_or_disconnect" );
        lasttime = gettime();
        
        while ( true )
        {
            now = gettime();
            delta = ( now - lasttime ) / 1000;
            lasttime = now;
            self.var_8f921a7892e5cb69 -= delta;
            
            if ( self.var_8f921a7892e5cb69 <= 0 )
            {
                break;
            }
            
            if ( isbot( self ) )
            {
                print3d( self.origin + ( 0, 0, 50 ), "<dev string:x7f>" + int( self.var_8f921a7892e5cb69 + 0.5 ) + "<dev string:x90>" );
            }
            else
            {
                iprintln( "<dev string:x92>" + int( self.var_8f921a7892e5cb69 + 0.5 ) );
            }
            
            waitframe();
        }
    }

#/

// Namespace active_camo
// Params 1, eflags: 0x4
// Checksum 0x8035620e, Offset: 0xa72
// Size: 0x18
function private cancel( params )
{
    supers_mp::reducesuperusepercent( 1 );
}

// Namespace active_camo
// Params 0, eflags: 0x4
// Checksum 0xa8461a54, Offset: 0xa92
// Size: 0x16, Type: bool
function private function_bac15957de6d26a2()
{
    return istrue( level.var_bb86f77304f193c4.var_446f982c7155c1d2 );
}

// Namespace active_camo
// Params 0
// Checksum 0xb7a5e023, Offset: 0xab1
// Size: 0x100
function start_active_camo()
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_active_camo" );
    give_cold_blooded = bundle.var_3796bd866cc9f845 ?? 1;
    
    if ( give_cold_blooded )
    {
        self.var_6b6d5839aacb174f = 1;
    }
    
    function_32ebebc1e0f4707f();
    battlechatter::broadcastnotify( self.origin, 1000, "react_player", "react_active_camo", { #var_282bf9970a98e27e:self.team, #otherent:self } );
    superinfo = supers_mp::getcurrentsuper();
    var_d1bf0981f99cbe80 = superinfo.staticdata.objweapon;
    telemetry_mp::function_80a95f340a7c8f67( self, self, var_d1bf0981f99cbe80, 0 );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hash_fa086db745e2c53e" ][ #"hash_29fb623c0b4dda71" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]( #"super_active_camo", &function_bcfeb3fbb9188111 );
    }
}

// Namespace active_camo
// Params 0
// Checksum 0xb709eea, Offset: 0xbb9
// Size: 0x13e
function function_32ebebc1e0f4707f()
{
    self.var_6eeba5380f051b = 0;
    self.var_67802b153747d6a5 = 1;
    self function_8c4d092479c8d615( 1 );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"assisted_targeting" ][ #"applydisabled" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]();
    }
    
    function_ab8230d40e82bc8f( self );
    self function_16332a7775f10aa9();
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_active_camo" );
    
    if ( !bundle.var_1dbc405142466e57 )
    {
        perk::giveperk( "specialty_no_target" );
    }
    
    self sethidenameplate( 1 );
    self setperk( "specialty_show_hidden_nameplate_to_allies", 1 );
    function_c6af39470b9475ea( 1 );
    
    if ( self.var_6b6d5839aacb174f )
    {
        perk::giveperk( "specialty_coldblooded_and_hidden" );
    }
    
    var_c1b0780ae18afce2 = self getscriptablepartstate( #"active_camo_fx", 1, 1 );
    var_7a410fddc7930849 = !( var_c1b0780ae18afce2 == #"super_fx_on" || var_c1b0780ae18afce2 == #"hash_5e9a1b8839da3a02" || var_c1b0780ae18afce2 == #"hash_e40da302d03cdadb" );
    
    if ( var_7a410fddc7930849 )
    {
        self setscriptablepartstate( #"active_camo_fx", #"super_fx_on", 0 );
    }
    
    thread function_9900253908edb3c2();
}

// Namespace active_camo
// Params 1
// Checksum 0xfc27f3ca, Offset: 0xcff
// Size: 0x183
function active_camo_off( immediate )
{
    self function_8c4d092479c8d615( 0 );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"assisted_targeting" ][ #"removedisabled" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]();
    }
    
    if ( self.operatorcustomization.reactiveoperator )
    {
        self function_184d7ec010cfaa92( self.operatorcustomization.reactiveoperator );
    }
    
    self.var_67802b153747d6a5 = undefined;
    self.var_569f1dc25d9d7e03 = gettime();
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_active_camo" );
    
    if ( !bundle.var_1dbc405142466e57 )
    {
        perk::removeperk( "specialty_no_target" );
    }
    
    self sethidenameplate( 0 );
    self unsetperk( "specialty_show_hidden_nameplate_to_allies", 1 );
    function_c6af39470b9475ea( 0 );
    
    if ( self.var_6b6d5839aacb174f )
    {
        perk::removeperk( "specialty_coldblooded_and_hidden" );
    }
    
    if ( immediate )
    {
        self setscriptablepartstate( #"active_camo_fx", #"super_fx_deactivate_final", 0 );
        return;
    }
    
    var_c1b0780ae18afce2 = self getscriptablepartstate( #"active_camo_fx", 1, 1 );
    var_1aa82dbdaa4abbaa = var_c1b0780ae18afce2 == #"super_fx_on" || var_c1b0780ae18afce2 == #"hash_5e9a1b8839da3a02" || var_c1b0780ae18afce2 == #"hash_e40da302d03cdadb";
    
    if ( var_1aa82dbdaa4abbaa )
    {
        self setscriptablepartstate( #"active_camo_fx", #"super_fx_deactivate", 0 );
    }
}

// Namespace active_camo
// Params 0, eflags: 0xc
// Checksum 0x42cc222c, Offset: 0xe8a
// Size: 0x14e
function private function_9900253908edb3c2()
{
    self notify( #"hash_7a911abc9ca3d2bc" );
    self endon( #"hash_7a911abc9ca3d2bc" );
    self endon( #"active_camo_end" );
    self endon( #"death_or_disconnect" );
    var_56a00875ab14c9a7 = self playerads();
    
    while ( true )
    {
        var_c1b0780ae18afce2 = self getscriptablepartstate( #"active_camo_fx", 1, 1 );
        
        switch ( var_c1b0780ae18afce2 )
        {
            case #"super_fx_on":
                break;
            case #"hash_5e9a1b8839da3a02":
                var_66ccb1276b2142df = self playerads();
                
                if ( !isdefined( var_56a00875ab14c9a7 ) )
                {
                    var_56a00875ab14c9a7 = var_66ccb1276b2142df;
                }
                
                if ( var_66ccb1276b2142df == 1 || var_66ccb1276b2142df > 0 && var_66ccb1276b2142df > var_56a00875ab14c9a7 )
                {
                    self setscriptablepartstate( #"active_camo_fx", #"hash_e40da302d03cdadb", 0 );
                }
                
                var_56a00875ab14c9a7 = var_66ccb1276b2142df;
                break;
            case #"hash_e40da302d03cdadb":
                var_66ccb1276b2142df = self playerads();
                
                if ( !isdefined( var_56a00875ab14c9a7 ) )
                {
                    var_56a00875ab14c9a7 = var_66ccb1276b2142df;
                }
                
                if ( var_66ccb1276b2142df == 0 || var_66ccb1276b2142df < 1 && var_66ccb1276b2142df < var_56a00875ab14c9a7 )
                {
                    self setscriptablepartstate( #"active_camo_fx", #"hash_5e9a1b8839da3a02", 0 );
                }
                
                var_56a00875ab14c9a7 = var_66ccb1276b2142df;
                break;
            default:
                break;
        }
        
        waitframe();
    }
}

// Namespace active_camo
// Params 2
// Checksum 0xa0eac190, Offset: 0xfe0
// Size: 0x1e
function natural_timeout( fromdeath, attacker )
{
    thread end_active_camo( fromdeath );
}

// Namespace active_camo
// Params 2, eflags: 0xc
// Checksum 0xb2c9a236, Offset: 0x1006
// Size: 0xf6
function private function_b8b1a723e003da4c( var_8e9b9c1ab8815ab, duration )
{
    self notify( #"hash_c2cf8dae541cfb88" );
    self endon( #"hash_c2cf8dae541cfb88" );
    assert( var_8e9b9c1ab8815ab >= 1 );
    assert( duration > 0 );
    self endon( #"death_or_disconnect" );
    self endon( #"active_camo_end" );
    superslot = supers_mp::getsuperslot( "super_active_camo" );
    superinfo = supers_mp::getcurrentsuper( superslot );
    var_d7b80a5bef393fd5 = supers_mp::function_5edde74ac0c929eb( superinfo );
    decayfactor = var_8e9b9c1ab8815ab - 1;
    endtime = gettime() + duration * 1000;
    
    while ( gettime() < endtime )
    {
        extrapercent = decayfactor * level.framedurationseconds / var_d7b80a5bef393fd5;
        supers_mp::reducesuperusepercent( extrapercent, undefined, 1 );
        waitframe();
    }
}

// Namespace active_camo
// Params 0
// Checksum 0x58e07ef6, Offset: 0x1104
// Size: 0xcb
function function_8ce9d92657b64727()
{
    self endon( #"active_camo_end" );
    self endon( #"death_or_disconnect" );
    breakduration = function_e0e2a44af5b67161();
    
    if ( breakduration )
    {
        var_8f880c5c4f1cb04b = utility::callsharedfunc( #"super_active_camo", #"hash_57df9ea72261e1db" );
        
        if ( var_8f880c5c4f1cb04b.duration )
        {
            while ( true )
            {
                self waittill( #"weapon_fired" );
                thread function_b8b1a723e003da4c( var_8f880c5c4f1cb04b.multiplier, var_8f880c5c4f1cb04b.duration );
            }
        }
        else
        {
            while ( true )
            {
                self waittill( #"weapon_fired" );
                thread temporary_break( breakduration );
            }
        }
    }
    else
    {
        self waittill( #"weapon_fired" );
    }
    
    thread supers_mp::superusefinished();
}

// Namespace active_camo
// Params 1
// Checksum 0xb207afe9, Offset: 0x11d7
// Size: 0x116
function function_41177027c38191de( break_threshold_angle )
{
    self endon( #"active_camo_end" );
    self endon( #"death_or_disconnect" );
    wait 3;
    
    while ( true )
    {
        ais = getaiarrayinradius( self.origin, 36 );
        
        if ( ais.size )
        {
            var_35fef03117b93408 = 1;
            
            if ( break_threshold_angle )
            {
                foreach ( ai in ais )
                {
                    if ( !isdefined( ai ) )
                    {
                        continue;
                    }
                    
                    if ( self isinexecutionattack() || damage_utility::function_96098e54715671d3( anglestoforward( self.angles ), ai.angles, break_threshold_angle ) )
                    {
                        var_35fef03117b93408 = 0;
                        break;
                    }
                }
            }
            
            if ( var_35fef03117b93408 )
            {
                break;
            }
        }
        
        wait 1;
    }
    
    thread supers_mp::superusefinished();
}

// Namespace active_camo
// Params 0
// Checksum 0xd1cce159, Offset: 0x12f5
// Size: 0x2e
function function_165c31b0f507875d()
{
    self endon( #"active_camo_end" );
    self endon( #"death_or_disconnect" );
    self waittill( #"hash_b104d266cdc3b33b" );
    thread supers_mp::superusefinished();
}

// Namespace active_camo
// Params 0, eflags: 0xc
// Checksum 0x1c3f30ce, Offset: 0x132b
// Size: 0x1b2
function private function_ad3bc63d853850df()
{
    self notify( #"hash_c05543966775285" );
    self endon( #"hash_c05543966775285" );
    self endon( #"active_camo_end" );
    self endon( #"death_or_disconnect" );
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_active_camo" );
    var_745e9ef5bd66b713 = bundle.var_3d8262e6be67a7ab ?? 1;
    var_33524f17f0172039 = bundle.var_e36b84555e7df1d3 && supers_mp::function_d45945781d29204a( "super_active_camo", bundle.var_e36b84555e7df1d3 );
    var_8fc474220520edf = bundle.var_4ac884e4c46aa88b;
    buffertime = 10000;
    
    if ( var_8fc474220520edf )
    {
        breaktime = bundle.var_eed8524846d57f4f;
    }
    else
    {
        breaktime = function_e0e2a44af5b67161();
    }
    
    while ( true )
    {
        msg = utility::waittill_any_ents_return( self, "meatshield_attacker_start", self, "meatshield_victim_start", self, "execution_begin", self, "execution_begin_victim" );
        
        if ( var_745e9ef5bd66b713 && !var_33524f17f0172039 && !var_8fc474220520edf )
        {
            thread supers_mp::superusefinished();
            break;
        }
        
        if ( msg == "meatshield_attacker_start" )
        {
            thread temporary_break( buffertime );
            self waittill( #"meatshield_attacker_stop", endstate );
            
            if ( self isinexecutionattack() )
            {
                wait breaktime + 3;
            }
            else
            {
                wait breaktime;
            }
            
            self notify( #"active_camo_stop_temporary_break" );
            continue;
        }
        
        if ( msg == "execution_begin" )
        {
            thread temporary_break( buffertime );
            utility::waittill_notify_or_timeout( "execution_stopped", 3 );
            wait breaktime;
            self notify( #"active_camo_stop_temporary_break" );
            continue;
        }
        
        thread supers_mp::superusefinished();
        break;
    }
}

// Namespace active_camo
// Params 0
// Checksum 0xeaaf8645, Offset: 0x14e5
// Size: 0x79
function function_eb2f31bf271ed564()
{
    self endon( #"active_camo_end", #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"execution_begin" );
        superinfo = supers_mp::getcurrentsuper();
        var_d1bf0981f99cbe80 = superinfo.staticdata.objweapon;
        thread gamelogic_mp::threadedsetweaponstatbyname( var_d1bf0981f99cbe80, 1, "special_hits" );
    }
}

// Namespace active_camo
// Params 1
// Checksum 0x9c205845, Offset: 0x1566
// Size: 0x52
function function_337b328286098985( duration )
{
    self endon( #"active_camo_end" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        utility::waittill_any( "damage", "damage_armor" );
        thread temporary_break( duration );
    }
}

// Namespace active_camo
// Params 1
// Checksum 0xfc8dbf8a, Offset: 0x15c0
// Size: 0x7c
function temporary_break( duration )
{
    self notify( #"hash_c78a9031d44e72aa" );
    self endon( #"hash_c78a9031d44e72aa" );
    self endon( #"active_camo_end" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( !self.var_6eeba5380f051b )
    {
        self.var_6eeba5380f051b = 1;
        active_camo_off();
    }
    
    utility::waittill_notify_or_timeout( "active_camo_stop_temporary_break", duration );
    function_32ebebc1e0f4707f();
}

// Namespace active_camo
// Params 1
// Checksum 0xa7bfaebb, Offset: 0x1644
// Size: 0x15d
function end_active_camo( immediate )
{
    self notify( #"active_camo_end" );
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_active_camo" );
    thread function_5dab3c91717d9771( bundle );
    active_camo_off( immediate );
    superinfo = supers_mp::getcurrentsuper();
    var_d1bf0981f99cbe80 = superinfo.staticdata.objweapon;
    thread telemetry_mp::function_e097bffa2fd8f2a0( self, var_d1bf0981f99cbe80, 0, bundle.var_16907742cebc0315 );
    function_c642554046607ca1();
    self.var_6b6d5839aacb174f = undefined;
    self.var_6eeba5380f051b = undefined;
    self.var_a0f61c58ecfd648b = undefined;
    self.empapplycallback = undefined;
    
    if ( level.var_36218e71baa7e689 )
    {
        self.var_c5ccf9dff3b5e393 = undefined;
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hash_fa086db745e2c53e" ][ #"hash_d428d7b9853a90d7" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]( #"super_active_camo" );
    }
    
    self.active_camo_enabled = undefined;
    self.activecamoendtime = gettime();
    
    if ( bundle.var_8b9eade13fbfb044 )
    {
        assert( callback::exists( #"super_cancel", &cancel ) );
        callback::remove( #"super_cancel", &cancel );
    }
}

// Namespace active_camo
// Params 0, eflags: 0x4
// Checksum 0x86d889c9, Offset: 0x17a9
// Size: 0x81
function private function_e0e2a44af5b67161()
{
    breakduration = undefined;
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_active_camo" );
    
    if ( bundle.var_e36b84555e7df1d3 && supers_mp::function_d45945781d29204a( "super_active_camo", bundle.var_e36b84555e7df1d3 ) )
    {
        breakduration = bundle.var_8ce6c6101063784 ?? 1;
    }
    else if ( bundle.var_43aa91345a106558 )
    {
        breakduration = bundle.var_43aa91345a106558;
    }
    
    return breakduration;
}

// Namespace active_camo
// Params 1, eflags: 0x4
// Checksum 0xb335b420, Offset: 0x1833
// Size: 0x20
function private function_ba4c630d6052f964( ai_interaction )
{
    self.var_5564ebebb4cc0609 = ai_interaction;
    function_c6af39470b9475ea( 1 );
}

// Namespace active_camo
// Params 0, eflags: 0x4
// Checksum 0x681ea12, Offset: 0x185b
// Size: 0x14
function private function_c642554046607ca1()
{
    function_c6af39470b9475ea( 0 );
    self.var_5564ebebb4cc0609 = undefined;
}

// Namespace active_camo
// Params 1, eflags: 0x4
// Checksum 0x4fd80ceb, Offset: 0x1877
// Size: 0x6f
function private function_c6af39470b9475ea( state )
{
    if ( !isdefined( self.var_5564ebebb4cc0609 ) )
    {
        return;
    }
    
    switch ( self.var_5564ebebb4cc0609 )
    {
        case #"hash_5bbf933722f00de3":
            ai::contribute_ignoreme( "super_active_camo", state );
            break;
        case #"hash_b0a1e0603517ece2":
            setstealthdisguised( self, state );
            break;
        default:
            break;
    }
}

// Namespace active_camo
// Params 2, eflags: 0x4
// Checksum 0x3001100e, Offset: 0x18ee
// Size: 0x3f
function private function_66ceeedaef99bfea( emp_grenade_duration, emp_blast_duration )
{
    emp_debuff::set_apply_emp_callback( &function_1de6986c69b59f9 );
    emp_debuff::add_emp_ent( self );
    self.var_a0f61c58ecfd648b = emp_grenade_duration;
    self.var_810d4d5a1c085fa5 = emp_blast_duration;
}

// Namespace active_camo
// Params 1, eflags: 0x4
// Checksum 0x7c86cda1, Offset: 0x1935
// Size: 0x49
function private function_b47d51259e60b8d3( data )
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_active_camo" );
    
    if ( bundle.var_50ca7b13add91330 )
    {
        end_active_camo();
        return;
    }
    
    active_camo_off();
    thread function_99d0a1bf6dc47743();
}

// Namespace active_camo
// Params 1, eflags: 0x4
// Checksum 0xdf9e6cbc, Offset: 0x1986
// Size: 0x1a
function private function_1de6986c69b59f9( data )
{
    active_camo_off();
    thread function_a4e2d155890ebc89();
}

// Namespace active_camo
// Params 0, eflags: 0x4
// Checksum 0xab8341b5, Offset: 0x19a8
// Size: 0x48
function private function_99d0a1bf6dc47743()
{
    self endon( #"active_camo_end" );
    self endon( #"death_or_disconnect" );
    
    if ( isdefined( self.var_810d4d5a1c085fa5 ) )
    {
        wait self.var_810d4d5a1c085fa5;
    }
    else
    {
        self waittill( #"emp_removed" );
    }
    
    function_32ebebc1e0f4707f();
}

// Namespace active_camo
// Params 0, eflags: 0x4
// Checksum 0xaf66daaa, Offset: 0x19f8
// Size: 0x48
function private function_a4e2d155890ebc89()
{
    self endon( #"active_camo_end" );
    self endon( #"death_or_disconnect" );
    
    if ( isdefined( self.var_a0f61c58ecfd648b ) )
    {
        wait self.var_a0f61c58ecfd648b;
    }
    else
    {
        self waittill( #"emp_removed" );
    }
    
    function_32ebebc1e0f4707f();
}

// Namespace active_camo
// Params 0, eflags: 0x4
// Checksum 0x9c24a78c, Offset: 0x1a48
// Size: 0x1e
function private function_bcfeb3fbb9188111()
{
    thread equipment_utility::function_364a1a0e0c018518( "super_active_camo", #"disrupted_hacked" );
    thread supers_mp::superusefinished();
}

// Namespace active_camo
// Params 1, eflags: 0x4
// Checksum 0x3dabfbd, Offset: 0x1a6e
// Size: 0x58
function private function_5dab3c91717d9771( bundle )
{
    self.var_59f5e3e01fdc2b1a = 1;
    graceperiod = bundle.var_16907742cebc0315;
    
    if ( graceperiod )
    {
        utility::waittill_notify_or_timeout( "death_or_disconnect", bundle.var_16907742cebc0315 );
    }
    else
    {
        waitframe();
    }
    
    self.var_59f5e3e01fdc2b1a = undefined;
}

// Namespace active_camo
// Params 0, eflags: 0x4
// Checksum 0xc99ce320, Offset: 0x1ace
// Size: 0x18, Type: bool
function private function_67f0dd3e49e8ae97()
{
    return supers_mp::getcurrentsuperref() == "super_active_camo" && supers_mp::issuperinuse();
}

// Namespace active_camo
// Params 1, eflags: 0x4
// Checksum 0x4d5dbf9f, Offset: 0x1aef
// Size: 0x11e
function private function_743d80be69a25bc7( params )
{
    if ( !self )
    {
        return;
    }
    
    if ( !function_67f0dd3e49e8ae97() && !self.var_59f5e3e01fdc2b1a )
    {
        return;
    }
    
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
    
    self.modifiers[ "active_camo_kill" ] = 1;
}

// Namespace active_camo
// Params 1, eflags: 0x4
// Checksum 0x19df1714, Offset: 0x1c15
// Size: 0x12c
function private function_b3ef44fd26e51c0d( params )
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_active_camo" );
    
    if ( isplayer( self ) && !bundle.var_4d9d21e37fd30386 || isagent( self ) && !bundle.var_fe3b91d35abd7972 )
    {
        return;
    }
    
    player = params.attacker ?? params.eattacker;
    meansofdeath = params.meansofdeath ?? params.smeansofdeath;
    var_4b6f186cb0736122 = meansofdeath == "MOD_MELEE" && ( isplayer( player ) || isagent( player ) ) && player function_67f0dd3e49e8ae97();
    
    if ( var_4b6f186cb0736122 )
    {
        if ( bundle.var_e36b84555e7df1d3 && player supers_mp::function_d45945781d29204a( "super_active_camo", bundle.var_e36b84555e7df1d3 ) )
        {
            if ( bundle.var_96d1af18d07fa8bd > 0 )
            {
                player thread temporary_break( bundle.var_96d1af18d07fa8bd );
            }
            
            return;
        }
        
        player thread supers_mp::superusefinished();
    }
}

// Namespace active_camo
// Params 1
// Checksum 0xc52b069d, Offset: 0x1d49
// Size: 0x29
function on_player_elim( params )
{
    if ( !self.modifiers[ "active_camo_kill" ] )
    {
        return;
    }
    
    function_b57c3fb941587ca5( params );
}

// Namespace active_camo
// Params 1
// Checksum 0xc7fab903, Offset: 0x1d7a
// Size: 0x55
function function_8fbc04fe84d49b51( params )
{
    player = params.einflictor;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( !player function_67f0dd3e49e8ae97() && !player.var_59f5e3e01fdc2b1a )
    {
        return;
    }
    
    player function_b57c3fb941587ca5( params );
}

// Namespace active_camo
// Params 1
// Checksum 0x5adadde4, Offset: 0x1dd7
// Size: 0xc2
function function_b57c3fb941587ca5( params )
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_active_camo" );
    eliminationscoreevent = bundle.eliminationscoreevent;
    
    if ( eliminationscoreevent )
    {
        weapon = self getcurrentweapon();
        thread points::function_f8a0deb1a12da52e( eliminationscoreevent, weapon, bundle.lootid );
    }
    
    if ( self.modifiers[ "backstab" ] && params.smeansofdeath == "MOD_MELEE" || params.smeansofdeath == "MOD_EXECUTION" || params.smeansofdeath == "MOD_MEATSHIELD" )
    {
        thread points::doscoreevent( #"camo_melee_kill" );
    }
}

