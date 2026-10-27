// scripts\mp\common\powerups\powerups.gsc  (hash_31b3b880c71579cf.gscc) (size: 7064 Bytes / 0x1b98 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2dffb4a0 (771732640)
// size ...... 7064 (0x1b98)
// includes .. 4   (offset: 0x19e0)
// strings ... 27  (offset: 0x1a00)
// dev strs .. 2   (offset: 0x1b78)
// exports ... 17  (offset: 0x10d4)
// cseg ...... 0x231 + 0xea3 (0x10d4)
// imports ... 52  (offset: 0x137c)
// animtree1 . 0   (offset: 0x1b98)
// animtree2 . 0   (offset: 0x1b98)
#using scripts\common\callbacks;
#using scripts\common\powerups;
#using scripts\common\utility;
#using scripts\common\vehicle;

#namespace powerups_cpmp;

// Namespace powerups_cpmp
// Params 3
// Checksum 0x26c8e59, Offset: 0x24f
// Size: 0xc7
function init( func_give_points, var_a53a6962d153065f, override_drop_event )
{
    powerups::init_powerups( "never", &init_mp_powerups );
    root = powerups::get_powerups_root();
    root.func_give_points = func_give_points;
    root.var_a53a6962d153065f = var_a53a6962d153065f;
    root.var_15d850493eb56845 = &function_41b8bcbfef791d2e;
    root.var_308566e25655dae1 = &function_b6d20332b27fa42e;
    root.var_d3bf519d8023999a = &function_8227edb6fbbe2d55;
    utility::registersharedfunc( #"powerups", #"showPowerupHud", &function_52318afc13635e7c );
    init_fx();
    
    if ( !override_drop_event )
    {
        powerups::set_powerup_drop_event( "on_zombie_ai_killed" );
    }
}

// Namespace powerups_cpmp
// Params 0, eflags: 0x4
// Checksum 0x6e0d7b60, Offset: 0x31e
// Size: 0xac
function private init_fx()
{
    introfx = powerups::get_bundle_list().intro_vfx_asset ?? "vfx_jup_ob_gameplay_zm_powerup_spawn_in_green";
    idlefx = powerups::get_bundle_list().idle_vfx_asset ?? "vfx_jup_ob_gameplay_zm_powerup_glow_green";
    grabbedfx = powerups::get_bundle_list().grabbed_vfx_asset ?? "vfx_jup_ob_gameplay_zm_powerup_glow_green_grab";
    level._effect[ "powerup_intro" ] = loadfxasset( introfx );
    level._effect[ "powerup_on" ] = loadfxasset( idlefx );
    level._effect[ "powerup_grabbed" ] = loadfxasset( grabbedfx );
}

// Namespace powerups_cpmp
// Params 0, eflags: 0x4
// Checksum 0xdf567f03, Offset: 0x3d2
// Size: 0x2c
function private init_mp_powerups()
{
    callback::add( #"player_laststand", &on_enter_laststand );
    callback::add( #"player_laststand_exit", &function_e5ee909b4de261a7 );
}

// Namespace powerups_cpmp
// Params 0, eflags: 0x4
// Checksum 0xf41e3aff, Offset: 0x406
// Size: 0x53
function private function_8227edb6fbbe2d55()
{
    player = undefined;
    var_b22a572aa01dc757 = self;
    
    if ( isplayer( var_b22a572aa01dc757 ) )
    {
        player = var_b22a572aa01dc757;
    }
    
    if ( var_b22a572aa01dc757 vehicle::is_vehicle() )
    {
        if ( isplayer( var_b22a572aa01dc757.owner ) )
        {
            player = var_b22a572aa01dc757.owner;
        }
    }
    
    return player;
}

// Namespace powerups_cpmp
// Params 4, eflags: 0x4
// Checksum 0x7e659e44, Offset: 0x462
// Size: 0x1c9
function private function_41b8bcbfef791d2e( hud_powerup, n_lifetime, var_1c4080bc473ba9c, var_fdc18e3ab4c9896b )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    self endon( "powerup_hud_show_" + hud_powerup.str_powerup );
    self endon( "powerup_hud_hide_" + hud_powerup.str_powerup );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( !( isdefined( hud_powerup ) && isdefined( n_lifetime ) ) )
    {
        return;
    }
    
    ref = "hud_powerup_" + hud_powerup.str_powerup;
    
    if ( self.powerup_timer_display.active_refs[ ref ] )
    {
        self.powerup_timer_display.active_refs[ ref ].var_ea39dccd6be02fad = gettime();
        self.powerup_timer_display.active_refs[ ref ].lifetime = n_lifetime;
    }
    
    function_84f08c827e575c31( hud_powerup, n_lifetime );
    var_d8e646ce2e532a7d = var_1c4080bc473ba9c;
    var_4d8d2d394125e81e = clamp( var_fdc18e3ab4c9896b, 0, var_1c4080bc473ba9c );
    var_df9bc210fd86790 = max( 0, n_lifetime - var_d8e646ce2e532a7d );
    blink_dur = min( n_lifetime, var_d8e646ce2e532a7d - var_4d8d2d394125e81e );
    
    if ( n_lifetime == -1 )
    {
        blink_dur = 0;
        var_4d8d2d394125e81e = 0;
        self waittill( "powerup_hud_hide_" + hud_powerup.str_powerup );
    }
    else
    {
        wait var_df9bc210fd86790;
        n_lifetime -= var_df9bc210fd86790;
    }
    
    if ( blink_dur > 0 )
    {
        powerups::set_powerup_timer_state( "hud_powerup_" + hud_powerup.str_powerup, "blink" );
        wait blink_dur;
    }
    
    if ( var_4d8d2d394125e81e > 0 )
    {
        powerups::set_powerup_timer_state( "hud_powerup_" + hud_powerup.str_powerup, "blinkfast" );
        wait var_4d8d2d394125e81e;
    }
}

// Namespace powerups_cpmp
// Params 1
// Checksum 0x32e2a509, Offset: 0x633
// Size: 0x49
function function_b6d20332b27fa42e( str_powerup )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    waitframe();
    
    if ( !isplayer( self ) )
    {
        return;
    }
    
    refname = "hud_powerup_" + str_powerup;
    
    if ( powerups::is_active_ref( refname ) )
    {
        powerups::remove_powerup_timer( refname );
    }
}

// Namespace powerups_cpmp
// Params 2, eflags: 0x4
// Checksum 0x914c06dd, Offset: 0x684
// Size: 0x21
function private function_84f08c827e575c31( hud_powerup, n_lifetime )
{
    function_56202a9fe9767255( hud_powerup, n_lifetime, 1 );
}

// Namespace powerups_cpmp
// Params 5
// Checksum 0x583d29b6, Offset: 0x6ad
// Size: 0x253
function function_52318afc13635e7c( var_5482fbfb44cd2983, n_lifetime, waitdur = 3, blinkdur = 10, var_c2cf7272309fb931 = 5 )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    root = powerups::get_powerups_root();
    refname = "hud_powerup_" + var_5482fbfb44cd2983;
    
    if ( powerups::is_active_ref( refname ) )
    {
        if ( self.powerup_timer_display.active_refs[ refname ].var_ea39dccd6be02fad )
        {
            var_dd9a26086a9975e0 = self.powerup_timer_display.active_refs[ refname ].lifetime - ( gettime() - self.powerup_timer_display.active_refs[ refname ].var_ea39dccd6be02fad ) * 0.001;
        }
        
        omnvar_data = level.powerup_timer_display.omnvars[ #"time" ];
        prev_time = var_dd9a26086a9975e0 ?? self getclientomnvar( omnvar_data.name + "_" + self.powerup_timer_display.active_refs[ refname ].index );
        
        if ( prev_time > n_lifetime )
        {
            return;
        }
    }
    
    if ( root.show_splash )
    {
        thread function_e73d8733cb149b39( var_5482fbfb44cd2983, n_lifetime );
    }
    
    if ( n_lifetime > 0 || n_lifetime == -1 )
    {
        hud_powerup = powerups::powerup_hud_init( var_5482fbfb44cd2983 );
        function_eab004ec502c98ba( hud_powerup, n_lifetime );
        
        if ( root.show_splash )
        {
            waitdur = 3;
            msg = utility::waittill_notify_or_timeout_return( "powerup_hud_show_" + var_5482fbfb44cd2983, waitdur );
            
            if ( msg == "timeout" )
            {
                if ( n_lifetime == -1 )
                {
                    powerups::powerup_hud_show( var_5482fbfb44cd2983, n_lifetime, blinkdur, var_c2cf7272309fb931 );
                }
                else
                {
                    powerups::powerup_hud_show( var_5482fbfb44cd2983, n_lifetime - waitdur, blinkdur, var_c2cf7272309fb931 );
                }
            }
            
            return;
        }
        
        if ( n_lifetime >= blinkdur )
        {
            wait waitdur;
            powerups::powerup_hud_show( var_5482fbfb44cd2983, n_lifetime - waitdur, blinkdur, var_c2cf7272309fb931 );
            return;
        }
        
        powerups::powerup_hud_show( var_5482fbfb44cd2983, n_lifetime, n_lifetime / 2, 0 );
    }
}

// Namespace powerups_cpmp
// Params 2, eflags: 0x4
// Checksum 0x6e99def8, Offset: 0x908
// Size: 0xee
function private function_e73d8733cb149b39( var_5482fbfb44cd2983, n_lifetime )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    root = powerups::get_powerups_root();
    var_9359c4f0fc179107 = root.powerup_list_index[ var_5482fbfb44cd2983 ];
    
    foreach ( n_powerup_index in root.powerup_list_index )
    {
        if ( n_powerup_index == var_9359c4f0fc179107 )
        {
            break;
        }
        
        waitframe();
    }
    
    self setclientomnvar( "ui_powerup_splash", var_9359c4f0fc179107 );
    self setclientomnvar( "ui_powerup_splash_notify", gettime() );
}

// Namespace powerups_cpmp
// Params 3, eflags: 0x4
// Checksum 0xcbe017da, Offset: 0x9fe
// Size: 0xb8
function private function_5ccb508248fabb68( str_powerup, var_4aa832914aea8085, b_ignore_pause )
{
    assert( isplayer( self ) );
    
    if ( self.inlaststand && !b_ignore_pause )
    {
        return;
    }
    
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    refname = "hud_powerup_" + str_powerup;
    player = self;
    isactive = player powerups::is_active_ref( refname );
    
    if ( !isactive )
    {
        return;
    }
    
    player powerups::set_powerup_timer_state( refname, "hide" );
    
    if ( var_4aa832914aea8085 > 0 )
    {
        wait var_4aa832914aea8085;
        player powerups::set_powerup_timer_state( refname, "show" );
    }
}

// Namespace powerups_cpmp
// Params 4, eflags: 0x4
// Checksum 0xeb711d82, Offset: 0xabe
// Size: 0x194
function private function_56202a9fe9767255( hud_powerup, n_lifetime, var_d48d62a7f69c6ec3, var_ce136c3600e76d97 )
{
    assert( isplayer( self ) );
    self endon( #"disconnect" );
    root = powerups::get_powerups_root();
    poweruplist = powerups::get_bundle_list();
    assert( isdefined( root.powerup_list_index[ hud_powerup.str_powerup ] ), "<dev string:x24>" + hud_powerup.str_powerup + "<dev string:x36>" );
    var_87b8bf682995ba90 = poweruplist.var_c3b00301afe5cb49;
    
    if ( !isdefined( var_87b8bf682995ba90 ) || var_87b8bf682995ba90 == "" )
    {
        return;
    }
    
    refname = "hud_powerup_" + hud_powerup.str_powerup;
    var_a08c459e4043404e = [];
    var_a08c459e4043404e[ "bundle_index" ] = root.powerup_list_index[ hud_powerup.str_powerup ];
    var_a08c459e4043404e[ "time" ] = n_lifetime;
    isactive = powerups::is_active_ref( refname );
    
    if ( !isactive )
    {
        function_eab004ec502c98ba( hud_powerup, n_lifetime, var_d48d62a7f69c6ec3, var_ce136c3600e76d97 );
    }
    else
    {
        powerups::set_powerup_timer_state( refname, "Static" );
        waitframe();
        powerups::set_powerup_timer_state( refname, "Show" );
    }
    
    if ( getdvarint( @"hash_7818eb99f45ec4d0" ) == 1 && self.inlaststand )
    {
        powerups::set_powerup_timer_state( refname, "Hide" );
    }
    
    if ( !var_ce136c3600e76d97 )
    {
        powerups::set_powerup_timer_time( refname, n_lifetime );
    }
}

// Namespace powerups_cpmp
// Params 4, eflags: 0x4
// Checksum 0xabbd1fc4, Offset: 0xc5a
// Size: 0x16b
function private function_eab004ec502c98ba( hud_powerup, n_lifetime, var_d48d62a7f69c6ec3, var_ce136c3600e76d97 )
{
    assert( isplayer( self ) );
    self endon( #"disconnect" );
    root = powerups::get_powerups_root();
    poweruplist = powerups::get_bundle_list();
    assert( isdefined( root.powerup_list_index[ hud_powerup.str_powerup ] ), "<dev string:x24>" + hud_powerup.str_powerup + "<dev string:x36>" );
    var_87b8bf682995ba90 = poweruplist.var_c3b00301afe5cb49;
    
    if ( !isdefined( var_87b8bf682995ba90 ) || var_87b8bf682995ba90 == "" )
    {
        return;
    }
    
    player = self;
    refname = "hud_powerup_" + hud_powerup.str_powerup;
    state = "Hide";
    isactive = player powerups::is_active_ref( refname );
    
    if ( !isactive )
    {
        options = spawnstruct();
        options.under_hud = 1;
        player powerups::add_powerup_timer( refname, root.powerup_list_index[ hud_powerup.str_powerup ], n_lifetime );
        player powerups::set_powerup_timer_state( refname, state );
    }
    
    if ( !var_ce136c3600e76d97 )
    {
        player powerups::set_powerup_timer_time( refname, n_lifetime );
    }
}

// Namespace powerups_cpmp
// Params 0, eflags: 0x4
// Checksum 0xf732de01, Offset: 0xdcd
// Size: 0xc, Type: bool
function private should_pause_timer()
{
    return istrue( self.inlaststand );
}

// Namespace powerups_cpmp
// Params 1, eflags: 0x4
// Checksum 0xaf49ac97, Offset: 0xde2
// Size: 0xcf
function private on_enter_laststand( params )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( getdvarint( @"hash_7818eb99f45ec4d0" ) != 1 )
    {
        return;
    }
    
    waitframe();
    
    if ( isalive( self ) )
    {
        root = powerups::get_powerups_root();
        
        foreach ( ref, powerup in root.powerups )
        {
            thread function_5ccb508248fabb68( ref, 0, 1 );
        }
    }
}

// Namespace powerups_cpmp
// Params 1, eflags: 0x4
// Checksum 0x4ad1e831, Offset: 0xeb9
// Size: 0xc3
function private function_e5ee909b4de261a7( params )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    waitframe();
    
    if ( isalive( self ) )
    {
        root = powerups::get_powerups_root();
        
        foreach ( ref, powerup in root.powerups )
        {
            powerups::set_powerup_timer_state( "hud_powerup_" + ref, "show" );
        }
    }
}

// Namespace powerups_cpmp
// Params 1
// Checksum 0x10271c81, Offset: 0xf84
// Size: 0x14f, Type: bool
function can_drop_powerup( params )
{
    if ( !level utility::flag( "drop_powerups" ) )
    {
        return false;
    }
    
    if ( !isplayer( params.eattacker ) )
    {
        return false;
    }
    
    if ( getdvarint( @"hash_f82c8db80df59e50", 0 ) )
    {
        return false;
    }
    
    root = powerups::get_powerups_root();
    
    if ( root.no_powerups || isdefined( params.weapon ) && params.weapon.var_b6bae06021a9c5e )
    {
        return false;
    }
    
    if ( root.var_daa5409624d494e )
    {
        volumes = getentarray( "no_powerups", #targetname );
        
        foreach ( volume in volumes )
        {
            if ( ispointinvolume( params.origin, volume ) )
            {
                return false;
            }
        }
    }
    
    if ( !ispointonnavmesh( params.origin ) )
    {
        return false;
    }
    
    return true;
}

