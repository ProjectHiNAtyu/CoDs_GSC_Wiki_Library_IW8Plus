// script_3a40b69e86250ac3  (hash_3a40b69e86250ac3.gscc) (size: 8535 Bytes / 0x2157 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x51b63b19 (1370897177)
// size ...... 8535 (0x2157)
// includes .. 6   (offset: 0x1fcf)
// strings ... 19  (offset: 0x1fff)
// dev strs .. 0   (offset: 0x2157)
// exports ... 26  (offset: 0x13ef)
// cseg ...... 0x1b4 + 0x123b (0x13ef)
// imports ... 64  (offset: 0x17ff)
// animtree1 . 0   (offset: 0x2157)
// animtree2 . 0   (offset: 0x2157)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\common\weapons\lightning_chain;

#namespace namespace_3dd1cfdc2ab19755;

// Namespace namespace_3dd1cfdc2ab19755
// Params 0, eflags: 0x5
// Checksum 0xd35c2df2, Offset: 0x1d2
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"hash_a125986f3f0f332a", undefined, &pre_main, &post_main );
}

// Namespace namespace_3dd1cfdc2ab19755
// Params 0, eflags: 0x4
// Checksum 0xe60b8d14, Offset: 0x1f7
// Size: 0x20
function private pre_main()
{
    utility::registersharedfunc( #"hash_a125986f3f0f332a", #"init", &init );
}

// Namespace namespace_3dd1cfdc2ab19755
// Params 0, eflags: 0x4
// Checksum 0x4d6d4dfa, Offset: 0x21f
// Size: 0x22
function private post_main()
{
    common_init();
    utility::callsharedfunc( #"hash_a125986f3f0f332a", #"init" );
}

// Namespace namespace_3dd1cfdc2ab19755
// Params 0, eflags: 0x4
// Checksum 0xd6c6eec0, Offset: 0x249
// Size: 0x1f
function private init()
{
    level.var_36fc039c0d178f28 = lightning_chain::create_lightning_chain_params( 10, 300, 50, 0.5, 3 );
}

// Namespace namespace_3dd1cfdc2ab19755
// Params 0, eflags: 0x4
// Checksum 0xf32dcfa6, Offset: 0x270
// Size: 0x113
function private common_init()
{
    level callback::add( "on_zombie_ai_killed", &function_1597777910d0c21f );
    level callback::add( "on_zombie_ai_damaged", &function_5c7c45d609096c23 );
    level callback::add( "on_soldier_ai_damaged", &function_5c7c45d609096c23 );
    level callback::add( #"on_ai_killed", &function_2f7c16f659faf9fb );
    level callback::add( #"player_damaged", &function_2ca908516e731896 );
    level callback::add( #"player_weapon_change", &function_3351629d3f60c94 );
    level callback::add( #"player_spawned", &function_d1d55c47e227c3a3 );
    level callback::add( "on_player_damage_effects", &function_253fe5384ed04a67 );
    level callback::add( #"hash_474490f7ce8b74d0", &function_c814f5a773e6036 );
    level callback::add( #"reload_start", &function_894e1c43504afbb1 );
    
    if ( utility::issharedfuncdefined( #"zombie_utils", #"registerdamagecallback" ) )
    {
        utility::callsharedfunc( #"zombie_utils", #"registerdamagecallback", &function_335cad94306f4f95 );
    }
    
    agent_utils::register_soldier_damage_callback( &function_335cad94306f4f95 );
}

// Namespace namespace_3dd1cfdc2ab19755
// Params 0, eflags: 0x4
// Checksum 0x5b9eaf31, Offset: 0x38b
// Size: 0x1d7
function private function_4e35602cb92a0892()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( !level.var_7cbb7eeb5de4cb1b )
        {
            wait 3;
            continue;
        }
        
        var_9e0e8c874bdcd4b = 0;
        var_c952260b3e1bcdfd = 0;
        enemies = getaiarrayinradius( self.origin, 200 );
        
        foreach ( enemy in enemies )
        {
            if ( !isalive( enemy ) )
            {
                continue;
            }
            
            if ( enemy.lc_stunned )
            {
                var_dd720afab05b1fd8 = vectornormalize( enemy.origin - self.origin );
                player_view_forward = anglestoforward( self getplayerangles() );
                dot = vectordot( var_dd720afab05b1fd8, player_view_forward );
                
                if ( dot > 0.5 )
                {
                    var_9e0e8c874bdcd4b = 1;
                    
                    if ( enemy.lc_stunned_pap )
                    {
                        var_c952260b3e1bcdfd = 1;
                    }
                    
                    break;
                }
            }
        }
        
        if ( var_9e0e8c874bdcd4b )
        {
            if ( !utility::function_9f2c41c1dcc8c94( "DG2SplashVfx", "hit" ) )
            {
                if ( var_c952260b3e1bcdfd )
                {
                    utility::function_7c10ea82c1e305b8( "DG2SplashVfx", "near_pap" );
                }
                else
                {
                    utility::function_7c10ea82c1e305b8( "DG2SplashVfx", "near" );
                }
            }
        }
        else if ( utility::function_9f2c41c1dcc8c94( "DG2SplashVfx", "near" ) || utility::function_9f2c41c1dcc8c94( "DG2SplashVfx", "near_pap" ) )
        {
            utility::function_7c10ea82c1e305b8( "DG2SplashVfx", "off" );
        }
        
        wait 0.1;
    }
}

// Namespace namespace_3dd1cfdc2ab19755
// Params 1, eflags: 0x4
// Checksum 0x352a19ed, Offset: 0x56a
// Size: 0x28
function private function_d1d55c47e227c3a3( params )
{
    thread function_4e35602cb92a0892();
    thread function_dec9f528a8a22f9f();
    thread monitor_weapon_switch_started();
    thread function_b7408dc5ce0f1202();
}

// Namespace namespace_3dd1cfdc2ab19755
// Params 1, eflags: 0x4
// Checksum 0xbe05bdbf, Offset: 0x59a
// Size: 0x54
function private function_5b5ecce1aa9f4ff9( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !isweapon( self.currentweapon ) || self.currentweapon.var_1616e6fbba9a722d != %"hash_3e76992634249424" )
    {
        return;
    }
    
    self.var_f4fbf48d43a54447 = 1;
}

// Namespace namespace_3dd1cfdc2ab19755
// Params 1, eflags: 0x4
// Checksum 0xb899de32, Offset: 0x5f6
// Size: 0x15
function private function_c814f5a773e6036( params )
{
    function_5b5ecce1aa9f4ff9( params );
}

// Namespace namespace_3dd1cfdc2ab19755
// Params 1, eflags: 0x4
// Checksum 0xe76e1ac, Offset: 0x613
// Size: 0x15
function private function_894e1c43504afbb1( params )
{
    function_5b5ecce1aa9f4ff9( params );
}

// Namespace namespace_3dd1cfdc2ab19755
// Params 1, eflags: 0x4
// Checksum 0xa28bb10d, Offset: 0x630
// Size: 0x15b
function private function_2f7c16f659faf9fb( params )
{
    if ( !isplayer( params.eattacker ) )
    {
        return;
    }
    
    attacker = params.eattacker;
    
    if ( !isweapon( params.sweapon ) || !isweapon( attacker.currentweapon ) )
    {
        return;
    }
    
    if ( !isdefined( self.lc_record ) )
    {
        return;
    }
    
    if ( !isdefined( attacker.var_7578beccd1d5de0d ) )
    {
        attacker.var_7578beccd1d5de0d = [];
    }
    
    lightning_id = self.lc_record;
    
    if ( !isdefined( attacker.var_7578beccd1d5de0d[ lightning_id ] ) )
    {
        attacker.var_7578beccd1d5de0d[ lightning_id ] = 1;
        attacker thread function_8c385c2e874cc592( lightning_id );
    }
    else
    {
        attacker.var_7578beccd1d5de0d[ lightning_id ]++;
    }
    
    multi_kill_num = attacker.var_36fc039c0d178f28.max_enemies_killed ?? level.var_36fc039c0d178f28.max_enemies_killed ?? 10;
    
    if ( attacker.var_7578beccd1d5de0d[ lightning_id ] >= multi_kill_num && attacker.currentweapon.var_1616e6fbba9a722d == %"hash_3e76992634249424" )
    {
        attacker playsoundtoplayer( "wfoly_plr_dg2_reaction_happy", attacker );
    }
}

// Namespace namespace_3dd1cfdc2ab19755
// Params 1, eflags: 0x4
// Checksum 0xece051aa, Offset: 0x793
// Size: 0x27
function private function_8c385c2e874cc592( lightning_id )
{
    self endon( #"death_or_disconnect" );
    wait 10;
    self.var_7578beccd1d5de0d[ lightning_id ] = undefined;
}

// Namespace namespace_3dd1cfdc2ab19755
// Params 1, eflags: 0x4
// Checksum 0x6a4f2875, Offset: 0x7c2
// Size: 0x89
function private function_253fe5384ed04a67( var_23e3622a1b7e3e6b )
{
    self endon( #"death_or_disconnect" );
    
    if ( !isdefined( var_23e3622a1b7e3e6b.objweapon ) || !function_46ac2d9e751f0645( var_23e3622a1b7e3e6b.objweapon.basename ) )
    {
        return;
    }
    
    self notify( #"hash_8ab0005881decbae" );
    self endon( #"hash_8ab0005881decbae" );
    utility::function_7c10ea82c1e305b8( "DG2SplashVfx", "hit" );
    wait 0.5;
    utility::function_7c10ea82c1e305b8( "DG2SplashVfx", "off" );
}

// Namespace namespace_3dd1cfdc2ab19755
// Params 0, eflags: 0x4
// Checksum 0x3c3ab60c, Offset: 0x853
// Size: 0x2c
function private function_dec9f528a8a22f9f()
{
    self endon( #"disconnect" );
    self waittill( #"death" );
    utility::function_7c10ea82c1e305b8( "DG2SplashVfx", "off" );
}

// Namespace namespace_3dd1cfdc2ab19755
// Params 1, eflags: 0x4
// Checksum 0x7362bd23, Offset: 0x887
// Size: 0x93
function private function_1597777910d0c21f( params )
{
    if ( isplayer( params.eattacker ) && function_46ac2d9e751f0645( params.objweapon.basename ) && isdefined( params.einflictor ) && ( params.smeansofdeath == "MOD_ELEMENTAL_ELEC" || params.smeansofdeath == "MOD_PROJECTILE" || params.smeansofdeath == "MOD_PROJECTILE_SPLASH" ) )
    {
        namespace_9d8e359c3b1041e5::function_fd2dd8546ecc345e();
    }
}

// Namespace namespace_3dd1cfdc2ab19755
// Params 1, eflags: 0x4
// Checksum 0x47a47379, Offset: 0x922
// Size: 0x315
function private function_5c7c45d609096c23( params )
{
    if ( isplayer( params.eattacker ) && function_46ac2d9e751f0645( params.sweapon.basename ) && isdefined( params.einflictor ) && ( params.smeansofdeath == "MOD_PROJECTILE" || params.smeansofdeath == "MOD_PROJECTILE_SPLASH" ) && !self.lc_stunned )
    {
        if ( !isdefined( self.team ) || !isdefined( params.eattacker.team ) || !isenemyteam( self.team, params.eattacker.team ) )
        {
            return;
        }
        
        if ( params.einflictor.var_e76eebdb259e385b )
        {
            return;
        }
        else
        {
            params.einflictor.var_e76eebdb259e385b = 1;
        }
        
        params.eattacker.var_40619328d00ca2e0 = 1;
        params.eattacker.var_6a8018c50244433a = undefined;
        params.eattacker.var_9f9a21aa61089e2e = 0;
        params.eattacker.var_35ff0d14f2a02cd = 1;
        var_36fc039c0d178f28 = structcopy( params.eattacker.var_36fc039c0d178f28 ?? level.var_36fc039c0d178f28 );
        var_36fc039c0d178f28.weapon = params.objweapon;
        var_36fc039c0d178f28.attacker = params.eattacker;
        var_36fc039c0d178f28.inflictor = params.einflictor;
        var_36fc039c0d178f28.should_gib_head = 1;
        var_36fc039c0d178f28.var_7a514800b212feb9 = 1;
        var_36fc039c0d178f28.var_fff5dc5501f9e352 = 1;
        var_36fc039c0d178f28.var_516d207140d59c2 = params.eattacker namespace_9d8e359c3b1041e5::function_1d4087075103b248( params.sweapon );
        var_36fc039c0d178f28.lc_id = string( params.eattacker getentitynumber() ) + string( gettime() );
        var_36fc039c0d178f28.source_enemy = self;
        var_36fc039c0d178f28.var_7cae2e380e0347ab = [];
        var_36fc039c0d178f28.var_7cae2e380e0347ab[ 0 ] = 5000;
        var_36fc039c0d178f28.var_7cae2e380e0347ab[ 1 ] = 5000;
        var_36fc039c0d178f28.var_7cae2e380e0347ab[ 2 ] = 5000;
        var_36fc039c0d178f28.var_7cae2e380e0347ab[ 3 ] = 5000;
        var_36fc039c0d178f28.var_a4b06b7d5862ddea = 4;
        var_36fc039c0d178f28.var_ae23bfd4b4acd418 = 2;
        var_36fc039c0d178f28.var_bf1f7231596f25bc = 1;
        var_36fc039c0d178f28.var_6232d6ee94f13e0f = 1;
        var_36fc039c0d178f28.var_93c94c124f42e7c9 = "MOD_UNKNOWN";
        thread lightning_chain::arc_damage( self, params.eattacker, var_36fc039c0d178f28 );
    }
}

// Namespace namespace_3dd1cfdc2ab19755
// Params 1, eflags: 0x4
// Checksum 0x5bfb7bc5, Offset: 0xc40
// Size: 0x7c
function private function_335cad94306f4f95( params )
{
    if ( isplayer( params.eattacker ) && function_46ac2d9e751f0645( params.sweapon.basename ) && isdefined( params.einflictor ) && ( params.smeansofdeath == "MOD_PROJECTILE" || params.smeansofdeath == "MOD_PROJECTILE_SPLASH" ) )
    {
        return 1;
    }
    
    return -1;
}

// Namespace namespace_3dd1cfdc2ab19755
// Params 1, eflags: 0x4
// Checksum 0xc3c86a17, Offset: 0xcc5
// Size: 0x246
function private function_2ca908516e731896( params )
{
    if ( params.objweapon.basename != "t10_ar_p19_dg2_mp" )
    {
        return;
    }
    
    if ( !isdefined( params.einflictor ) )
    {
        return;
    }
    
    if ( !( params.smeansofdeath == "MOD_PROJECTILE" || params.smeansofdeath == "MOD_PROJECTILE_SPLASH" ) )
    {
        return;
    }
    
    if ( params.eattacker == params.victim )
    {
        return;
    }
    
    if ( params.einflictor.var_e76eebdb259e385b )
    {
        return;
    }
    else
    {
        params.einflictor.var_e76eebdb259e385b = 1;
    }
    
    if ( isplayer( params.eattacker ) )
    {
        params.eattacker.var_40619328d00ca2e0 = 1;
        params.eattacker.var_6a8018c50244433a = undefined;
        params.eattacker.var_9f9a21aa61089e2e = 0;
        params.eattacker.var_35ff0d14f2a02cd = 1;
    }
    
    var_36fc039c0d178f28 = structcopy( params.eattacker.var_36fc039c0d178f28 ?? level.var_36fc039c0d178f28 );
    var_36fc039c0d178f28.weapon = params.objweapon;
    var_36fc039c0d178f28.attacker = params.eattacker;
    var_36fc039c0d178f28.inflictor = params.einflictor;
    var_36fc039c0d178f28.should_gib_head = 0;
    var_36fc039c0d178f28.var_516d207140d59c2 = isplayer( params.eattacker ) ? params.eattacker namespace_9d8e359c3b1041e5::function_1d4087075103b248( params.objweapon ) : 0;
    var_36fc039c0d178f28.lc_id = string( params.eattacker getentitynumber() ) + string( gettime() );
    var_36fc039c0d178f28.smeansofdeath = params.smeansofdeath;
    var_36fc039c0d178f28.victim = self;
    thread lightning_chain::arc_damage( self, params.eattacker, var_36fc039c0d178f28 );
}

// Namespace namespace_3dd1cfdc2ab19755
// Params 1, eflags: 0x4
// Checksum 0xd70f063d, Offset: 0xf13
// Size: 0xeb
function private function_3351629d3f60c94( params )
{
    if ( !isdefined( params.weapon ) || !isplayer( self ) )
    {
        return;
    }
    
    var_d70c156c7513e664 = params.lastweapon.var_1616e6fbba9a722d == %"hash_3e76992634249424";
    var_c3b7e84742c463c3 = params.weapon.var_1616e6fbba9a722d == %"hash_3e76992634249424";
    
    if ( !var_d70c156c7513e664 && !var_c3b7e84742c463c3 )
    {
        return;
    }
    
    if ( function_46ac2d9e751f0645( params.weapon.basename ) )
    {
        level.var_7cbb7eeb5de4cb1b = 1;
        thread function_1fc34698fb455424( params.weapon );
        thread function_73be833172580dbd();
        return;
    }
    
    self notify( #"hash_652802621c475e58" );
    self setscriptablepartstate( "DG2Vfx", "off", 0 );
}

// Namespace namespace_3dd1cfdc2ab19755
// Params 0, eflags: 0xc
// Checksum 0xf0a68645, Offset: 0x1006
// Size: 0x70
function private function_73be833172580dbd()
{
    self notify( #"hash_7e779232b82f0490" );
    self endon( #"hash_7e779232b82f0490" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_652802621c475e58" );
    
    while ( true )
    {
        wait randomintrange( 10, 20 );
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        if ( !self.var_f4fbf48d43a54447 )
        {
            self playsoundtoplayer( "wfoly_plr_dg2_reaction_idle", self );
            continue;
        }
        
        self.var_f4fbf48d43a54447 = 0;
    }
}

// Namespace namespace_3dd1cfdc2ab19755
// Params 2, eflags: 0x4
// Checksum 0x1e52dd99, Offset: 0x107e
// Size: 0x2f
function private function_ae92cd6d72cca558( player, wait_time )
{
    wait wait_time;
    
    if ( isplayer( player ) )
    {
        player.var_fbc4c98e2219144c = 1;
    }
}

// Namespace namespace_3dd1cfdc2ab19755
// Params 0, eflags: 0x4
// Checksum 0x11289074, Offset: 0x10b5
// Size: 0xc8
function private function_b7408dc5ce0f1202()
{
    self endon( #"death_or_disconnect" );
    prevweapon = undefined;
    prevoffhand = undefined;
    player = self;
    
    while ( true )
    {
        currentweapon = player getcurrentweapon();
        heldoffhand = player getheldoffhand();
        
        if ( currentweapon != prevweapon || heldoffhand != prevoffhand )
        {
            var_4eb2659137469394 = 1;
            
            if ( isdefined( heldoffhand ) )
            {
                var_4eb2659137469394 = isnullweapon( heldoffhand );
            }
            
            if ( var_4eb2659137469394 && function_46ac2d9e751f0645( currentweapon.basename ) )
            {
                function_ae92cd6d72cca558( player, 0.7 );
            }
            else
            {
                player setscriptablepartstate( "DG2Vfx", "off", 0 );
            }
        }
        
        prevweapon = currentweapon;
        prevoffhand = heldoffhand;
        waitframe();
    }
}

// Namespace namespace_3dd1cfdc2ab19755
// Params 0, eflags: 0x4
// Checksum 0x440cb20, Offset: 0x1185
// Size: 0x63
function private monitor_weapon_switch_started()
{
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        self waittill( #"weapon_switch_started", weapon );
        
        if ( isdefined( weapon ) )
        {
            if ( !function_46ac2d9e751f0645( weapon.basename ) )
            {
                if ( isplayer( self ) )
                {
                    self setscriptablepartstate( "DG2Vfx", "off", 0 );
                }
            }
        }
    }
}

// Namespace namespace_3dd1cfdc2ab19755
// Params 1, eflags: 0xc
// Checksum 0xb63d88f0, Offset: 0x11f0
// Size: 0x1cb
function private function_1fc34698fb455424( current_weapon )
{
    self notify( #"hash_4bdceab074e007a7" );
    self endon( #"hash_4bdceab074e007a7" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_652802621c475e58" );
    last_fx_state = 0;
    inspecting = 0;
    var_98268e2ea704c424 = weaponclipsize( current_weapon ) == 6;
    
    while ( true )
    {
        if ( self function_985124b0e1e74f2e() )
        {
            inspecting = 1;
            self.var_fbc4c98e2219144c = 1;
        }
        
        while ( self function_985124b0e1e74f2e() )
        {
            waitframe();
        }
        
        if ( inspecting )
        {
            inspecting = 0;
            self setscriptablepartstate( "DG2Vfx", "off", 0 );
            wait 0.5;
        }
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        if ( self.var_cc2765049d953c5f && !self isreloading() )
        {
            self.var_cc2765049d953c5f = 0;
            var_8b73eb373daec40a = undefined;
        }
        
        if ( !isdefined( var_8b73eb373daec40a ) || var_8b73eb373daec40a > -1 )
        {
            current_weapon_clip = self getcurrentweaponclipammo();
            
            if ( var_98268e2ea704c424 )
            {
                var_8b73eb373daec40a = int( ceil( current_weapon_clip / 2 ) );
            }
            else
            {
                var_8b73eb373daec40a = current_weapon_clip;
            }
        }
        
        if ( !self.var_cc2765049d953c5f && self isreloading() )
        {
            self.var_cc2765049d953c5f = 1;
            var_8b73eb373daec40a = -1;
        }
        
        if ( var_8b73eb373daec40a != last_fx_state || self.var_fbc4c98e2219144c )
        {
            self.var_fbc4c98e2219144c = undefined;
            
            if ( var_8b73eb373daec40a <= 0 )
            {
                var_2ddc7346694c8caa = "off";
            }
            else
            {
                state_idx = int( clamp( var_8b73eb373daec40a, 1, 3 ) );
                var_2ddc7346694c8caa = "vfx_start_" + state_idx;
                
                if ( var_98268e2ea704c424 )
                {
                    var_2ddc7346694c8caa += "_paped";
                }
            }
            
            if ( var_8b73eb373daec40a == -1 )
            {
                wait 0.5;
            }
            
            self setscriptablepartstate( "DG2Vfx", var_2ddc7346694c8caa, 0 );
            last_fx_state = var_8b73eb373daec40a;
        }
        
        waitframe();
    }
}

// Namespace namespace_3dd1cfdc2ab19755
// Params 1, eflags: 0x4
// Checksum 0x94f8af5d, Offset: 0x13c3
// Size: 0x2b, Type: bool
function private function_46ac2d9e751f0645( weaponname )
{
    if ( weaponname == "t10_ar_p19_dg2_mp" || weaponname == level.var_2785543070d01fce )
    {
        return true;
    }
    
    return false;
}

