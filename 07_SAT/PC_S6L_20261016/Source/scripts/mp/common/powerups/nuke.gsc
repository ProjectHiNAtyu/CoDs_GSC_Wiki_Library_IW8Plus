// scripts\mp\common\powerups\nuke.gsc  (hash_3f51b689a9c2d7af.gscc) (size: 9280 Bytes / 0x2440 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe1010545 (3774940485)
// size ...... 9280 (0x2440)
// includes .. 6   (offset: 0x227c)
// strings ... 28  (offset: 0x22ac)
// dev strs .. 2   (offset: 0x2428)
// exports ... 23  (offset: 0x1690)
// cseg ...... 0x1e5 + 0x14ab (0x1690)
// imports ... 70  (offset: 0x1a28)
// animtree1 . 0   (offset: 0x2440)
// animtree2 . 0   (offset: 0x2440)
#using scripts\common\ai\aitypes\zombie_base\zombie_base_dismemberment;
#using scripts\common\callbacks;
#using scripts\common\powerups;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\powerups\powerups;

#namespace nuke;

// Namespace nuke
// Params 0, eflags: 0x1
// Checksum 0x8edfeaa8, Offset: 0x203
// Size: 0x9
function autoexec main()
{
    function_e7d1bc712fe46da8();
}

// Namespace nuke
// Params 0
// Checksum 0xa3f6f18, Offset: 0x214
// Size: 0x2d
function function_e7d1bc712fe46da8()
{
    powerups::register_powerup( "nuke", &function_abd449c71a89e094, &should_drop_nuke );
    callback::add( #"player_death", &on_player_killed );
}

// Namespace nuke
// Params 0, eflags: 0x4
// Checksum 0x9d777546, Offset: 0x249
// Size: 0x14, Type: bool
function private should_drop_nuke()
{
    if ( utility::flag( "powerup_disable_nuke" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace nuke
// Params 8
// Checksum 0x7da3f462, Offset: 0x266
// Size: 0x4ee
function function_abd449c71a89e094( str_powerup, ent_powerup, b_ignore_score_event, var_88c9fd15f0aedd9b, b_kill_all, var_76dd3a32b75e3e9e, b_skip_flash, var_d3a5661e94ea2efd )
{
    root = powerups::get_powerups_root();
    
    if ( isdefined( ent_powerup ) )
    {
        v_origin = ent_powerup.origin;
    }
    else
    {
        v_origin = self.origin;
    }
    
    a_players = powerups::get_powerup_players( str_powerup, v_origin );
    var_5b0382437832b7ed = powerups::function_7dc56e4550f62595( str_powerup );
    var_112be41eced88a7d = powerups::get_powerup_info( str_powerup ).var_d1da02398305301e;
    var_59269dfece2702c2 = powerups::get_powerup_info( str_powerup ).var_5b6d23ffea9a8603;
    
    if ( function_891d9c0d343ba117( a_players, root ) )
    {
        return;
    }
    
    level thread function_52f07262daa3795f( str_powerup );
    a_ai = [];
    
    if ( var_59269dfece2702c2 )
    {
        var_615c404270c6c4a3 = getaiarray();
        
        foreach ( ai in var_615c404270c6c4a3 )
        {
            if ( isplayer( ai.enemy ) && arraycontains( a_players, ai.enemy ) && ( !isdefined( var_112be41eced88a7d ) || var_112be41eced88a7d == 0 || distance( ai.enemy.origin, ai.origin ) <= var_112be41eced88a7d ) )
            {
                a_ai[ a_ai.size ] = ai;
            }
        }
    }
    else if ( var_112be41eced88a7d > 0 )
    {
        foreach ( player in a_players )
        {
            a_ai = arraycombineunique( a_ai, getaiarrayinradius( player.origin, var_112be41eced88a7d ) );
        }
    }
    else if ( var_5b0382437832b7ed > 0 )
    {
        a_ai = getaiarrayinradius( v_origin, var_5b0382437832b7ed );
    }
    else
    {
        a_ai = getaiarray();
    }
    
    var_1974ce20e84d09c4 = [];
    
    foreach ( player in a_players )
    {
        player notify( #"nuke_triggered" );
        
        if ( player val::get( "enable_nuke_flash_and_sound" ) )
        {
            player playsoundevent( %"sndevent_powerup_nuke" );
        }
        
        if ( !b_skip_flash )
        {
            player thread function_a17bb0ff89d17835();
        }
        
        if ( !var_88c9fd15f0aedd9b )
        {
            player thread powerups_cpmp::function_52318afc13635e7c( str_powerup );
        }
        
        foreach ( ai in a_ai )
        {
            if ( ai.team == player.team || ai.team == "neutral" || arraycontains( var_1974ce20e84d09c4, ai ) )
            {
                continue;
            }
            
            var_1974ce20e84d09c4[ var_1974ce20e84d09c4.size ] = ai;
        }
    }
    
    level notify( #"powerup_nuke_pickup", self );
    params = spawnstruct();
    params.player = self;
    callback::callback( "on_powerup_nuke_pickup", params );
    
    if ( !isdefined( var_d3a5661e94ea2efd ) )
    {
        function_6c5906115e825d8f( v_origin, var_1974ce20e84d09c4, str_powerup, b_kill_all );
    }
    else
    {
        function_6c5906115e825d8f( v_origin, var_d3a5661e94ea2efd, str_powerup, b_kill_all );
    }
    
    if ( isdefined( ent_powerup ) )
    {
        ent_powerup notify( #"picked_up" );
    }
    
    level notify( #"nuke_complete" );
    
    if ( isdefined( root.func_give_points ) && !b_ignore_score_event )
    {
        foreach ( player in a_players )
        {
            player [[ root.func_give_points ]]( #"powerup_nuke" );
        }
    }
}

// Namespace nuke
// Params 5
// Checksum 0x548920de, Offset: 0x75c
// Size: 0x765
function function_6c5906115e825d8f( v_location, var_590aef121c9fb611, str_powerup, b_kill_all, on_death_func )
{
    foreach ( ai in var_590aef121c9fb611 )
    {
        if ( isalive( ai ) && !ai.var_7ee152b43c7188e1 && !ai.ignore_nuke_fx )
        {
            ai set_ai_stun( 10 );
        }
    }
    
    foreach ( ai in var_590aef121c9fb611 )
    {
        if ( isalive( ai ) && !ai.var_7ee152b43c7188e1 && !ai.ignore_nuke_fx )
        {
            ai function_669ed7a96571422b();
            waitframe();
        }
    }
    
    wait 0.5;
    current_a_ais = function_46f9072493651dc9( var_590aef121c9fb611 );
    
    if ( !isdefined( v_location ) )
    {
        v_location = self.origin;
    }
    
    current_a_ais = utility::get_array_of_closest( v_location, current_a_ais );
    a_ais_nuked = [];
    
    foreach ( ai in current_a_ais )
    {
        if ( !isalive( ai ) )
        {
            continue;
        }
        
        if ( ai val::get( "damageshield_allow_delete" ) )
        {
            ai utility::callsharedfunc( #"ai", #"hash_c649178f35fe47cf" );
        }
        
        var_3cd2eba2b7ff6812 = 0;
        
        if ( ai.var_190f8e8daa83f8c || ai.var_7ee152b43c7188e1 || ai.magic_bullet_shield || ai.damageshield )
        {
            var_3cd2eba2b7ff6812 = 1;
        }
        
        if ( ai.marked_for_death )
        {
            var_3cd2eba2b7ff6812 = 1;
        }
        
        if ( isdefined( ai.var_17e346ced9ac7924 ) )
        {
            ai thread [[ ai.var_17e346ced9ac7924 ]]();
            var_3cd2eba2b7ff6812 = 1;
        }
        
        if ( var_3cd2eba2b7ff6812 )
        {
            if ( !ai.var_7ee152b43c7188e1 && !ai.ignore_nuke_fx )
            {
                ai function_62a77223fa83d822();
            }
            
            continue;
        }
        
        ai set_ai_stun( 100 );
        ai.marked_for_death = 1;
        
        if ( !ai.nuked )
        {
            ai.nuked = 1;
            ai.no_powerups = 1;
            ai.var_a13bed1ac47e1b2c = 1;
            ai.full_gib = 1;
            ai.var_65522105f3bdca37 = 1;
            ai.var_df2a1c1213d8ce81 = 1;
            
            if ( level.gametype == "zm_rb" )
            {
                ai.var_65522105f3bdca37 = 0;
            }
            
            a_ais_nuked[ a_ais_nuked.size ] = ai;
            
            if ( utility::issharedfuncdefined( #"zombie_utils", #"setmovespeed" ) )
            {
                ai utility::callsharedfunc( #"zombie_utils", #"setmovespeed", "walk", "nuke", 27 );
            }
        }
    }
    
    nuke_ent = undefined;
    
    foreach ( var_b4993495b85b42ac in a_ais_nuked )
    {
        wait randomfloatrange( 0.1, 0.3 );
        
        if ( !isalive( var_b4993495b85b42ac ) )
        {
            continue;
        }
        
        if ( !var_b4993495b85b42ac.ignore_nuke_fx )
        {
            var_b4993495b85b42ac function_62a77223fa83d822();
        }
        
        if ( var_b4993495b85b42ac.magic_bullet_shield || var_b4993495b85b42ac.damageshield )
        {
            continue;
        }
        
        var_b4993495b85b42ac playsound( "evt_zm_core_powerup_nuke_soul" );
        var_d8b0d1d8a5ba3663 = undefined;
        
        if ( isdefined( var_b4993495b85b42ac.aicategory ) && !b_kill_all )
        {
            if ( var_b4993495b85b42ac.aicategory == "special" )
            {
                var_d8b0d1d8a5ba3663 = var_b4993495b85b42ac.maxhealth * ( powerups::get_powerup_info( str_powerup ).var_146aa95142eb3e6e ?? 0 );
            }
            else if ( var_b4993495b85b42ac.aicategory == "elite" || var_b4993495b85b42ac.aicategory == "hvt" )
            {
                var_d8b0d1d8a5ba3663 = var_b4993495b85b42ac.maxhealth * ( powerups::get_powerup_info( str_powerup ).var_250113d020d500ea ?? 0 );
            }
            else if ( var_b4993495b85b42ac.aicategory == "boss" )
            {
                var_d8b0d1d8a5ba3663 = var_b4993495b85b42ac.maxhealth * ( powerups::get_powerup_info( str_powerup ).var_f1512e0d65a6bf26 ?? 0 );
            }
        }
        
        if ( isagent( var_b4993495b85b42ac ) && isdefined( var_b4993495b85b42ac.unittype ) && var_b4993495b85b42ac.unittype == "soldier" )
        {
            var_b4993495b85b42ac notify( #"flashbang", var_b4993495b85b42ac.origin, 1, 1, self, self.team );
            var_d8b0d1d8a5ba3663 = 0;
        }
        
        if ( var_d8b0d1d8a5ba3663 < var_b4993495b85b42ac.health )
        {
            if ( !isdefined( nuke_ent ) )
            {
                nuke_ent = spawn( "script_model", v_location );
            }
            
            if ( var_d8b0d1d8a5ba3663 > 0 )
            {
                var_b4993495b85b42ac dodamage( int( var_d8b0d1d8a5ba3663 ), var_b4993495b85b42ac.origin, self ?? undefined, nuke_ent, "MOD_UNKNOWN", "none", "none", undefined, 65536 );
            }
            
            var_b4993495b85b42ac.marked_for_death = 0;
            var_b4993495b85b42ac.nuked = 0;
            var_b4993495b85b42ac.var_65522105f3bdca37 = 0;
            var_b4993495b85b42ac.no_powerups = 0;
            var_b4993495b85b42ac.var_a13bed1ac47e1b2c = 0;
            var_b4993495b85b42ac.full_gib = 0;
            continue;
        }
        
        if ( isfunction( on_death_func ) )
        {
            [[ on_death_func ]]( var_b4993495b85b42ac );
        }
        
        if ( var_b4993495b85b42ac.var_62591663e6a187ce == 0 && var_b4993495b85b42ac.takedamage )
        {
            var_b4993495b85b42ac dodamage( var_b4993495b85b42ac.health, v_location );
            continue;
        }
        
        /#
            if ( var_b4993495b85b42ac.damageshield || var_b4993495b85b42ac.magic_bullet_shield )
            {
                iprintln( "<dev string:x24>" + istrue( var_b4993495b85b42ac.damageshield ) + "<dev string:x5e>" + istrue( var_b4993495b85b42ac.magic_bullet_shield ) );
            }
        #/
        
        var_b4993495b85b42ac namespace_b76ff2659823e89d::function_6c318bca7bb326e7( 1 );
        var_b4993495b85b42ac kill();
        
        if ( issubstr( var_b4993495b85b42ac.subclass, "zombie_base" ) )
        {
            var_24ed309d808c077a = var_b4993495b85b42ac getcorpseentity();
            
            if ( isdefined( var_24ed309d808c077a ) )
            {
                var_24ed309d808c077a thread function_fc12a24729ef4e67();
            }
        }
    }
    
    if ( isdefined( nuke_ent ) )
    {
        nuke_ent delete();
    }
}

// Namespace nuke
// Params 0, eflags: 0x4
// Checksum 0x73f8da5b, Offset: 0xec9
// Size: 0x81
function private function_fc12a24729ef4e67()
{
    level endon( #"game_ended" );
    utility::function_32b24db3127bff40( "burned", "burned_on" );
    wait 3;
    var_80f3576404b5eba0 = 0;
    
    if ( isdefined( self ) )
    {
        var_80f3576404b5eba0 = utility::function_7c10ea82c1e305b8( "burned", "burned_dead" );
    }
    
    if ( var_80f3576404b5eba0 )
    {
        return;
    }
    
    if ( isdefined( self ) )
    {
        utility::function_7c10ea82c1e305b8( "burned", "burned_dead" );
    }
    
    wait 3;
    
    if ( isdefined( self ) )
    {
        utility::function_7c10ea82c1e305b8( "burned", "burned_off" );
    }
}

// Namespace nuke
// Params 1, eflags: 0x4
// Checksum 0x34e71fff, Offset: 0xf52
// Size: 0x68
function private function_52f07262daa3795f( str_powerup )
{
    level endon( #"game_ended" );
    function_a62746745a02d3b6( 1 );
    level waittill( #"nuke_complete" );
    var_98f1781cd56e76c3 = powerups::get_powerup_info( str_powerup ).var_483aed10ea213a95 ?? 1;
    level utility::waittill_notify_or_timeout( "abort_nuke", var_98f1781cd56e76c3 );
    function_a62746745a02d3b6( 0 );
}

// Namespace nuke
// Params 1, eflags: 0x4
// Checksum 0x50e0417d, Offset: 0xfc2
// Size: 0x25
function private function_6e29460f3c86ace4( n_max_health_percent )
{
    self.var_17e346ced9ac7924 = &function_17e346ced9ac7924;
    self.var_cc5d6e3419df0c21 = n_max_health_percent;
}

// Namespace nuke
// Params 0, eflags: 0x4
// Checksum 0x86f395a1, Offset: 0xfef
// Size: 0x3f
function private function_17e346ced9ac7924()
{
    self endon( #"death" );
    wait randomfloatrange( 0.1, 0.7 );
    self dodamage( self.maxhealth * self.var_cc5d6e3419df0c21, self.origin );
}

// Namespace nuke
// Params 0, eflags: 0x4
// Checksum 0xa2f043fd, Offset: 0x1037
// Size: 0x6f
function private remove_white_screen()
{
    self endon( #"disconnect" );
    var_24c3037417857a23 = 0.5;
    
    if ( isdefined( self.white_screen_overlay ) )
    {
        self.white_screen_overlay fadeovertime( var_24c3037417857a23 );
        self.white_screen_overlay.alpha = 0;
    }
    
    wait var_24c3037417857a23;
    
    if ( isdefined( self.white_screen_overlay ) )
    {
        self.white_screen_overlay destroy();
    }
}

// Namespace nuke
// Params 1, eflags: 0x4
// Checksum 0x9e6b9ccf, Offset: 0x10ae
// Size: 0x20
function private on_player_killed( deathdata )
{
    if ( isdefined( self.white_screen_overlay ) )
    {
        remove_white_screen();
    }
}

// Namespace nuke
// Params 0, eflags: 0x4
// Checksum 0xf098c03, Offset: 0x10d6
// Size: 0x1b8
function private function_a17bb0ff89d17835()
{
    if ( !val::get( "enable_nuke_flash_and_sound" ) )
    {
        return;
    }
    
    self notify( #"play_nuke_screen_flash" );
    self endon( #"death_or_disconnect" );
    self endon( #"play_nuke_screen_flash" );
    
    if ( !isdefined( self.white_screen_overlay ) )
    {
        self.white_screen_overlay = newclienthudelem( self );
        self.white_screen_overlay.x = 0;
        self.white_screen_overlay.y = 0;
        self.white_screen_overlay setshader( "white", 640, 480 );
        self.white_screen_overlay.alignx = "left";
        self.white_screen_overlay.aligny = "top";
        self.white_screen_overlay.sort = 1;
        self.white_screen_overlay.horzalign = "fullscreen";
        self.white_screen_overlay.vertalign = "fullscreen";
        self.white_screen_overlay.alpha = 0;
        self.white_screen_overlay.foreground = 1;
        self.white_screen_overlay.archived = 0;
        self.white_screen_overlay.scramblerdisabled = 1;
    }
    
    var_24c3037417857a23 = 0.2;
    n_target_alpha = 0.8;
    self.white_screen_overlay fadeovertime( var_24c3037417857a23 );
    self.white_screen_overlay.alpha = n_target_alpha;
    wait 0.5;
    remove_white_screen();
}

// Namespace nuke
// Params 1, eflags: 0x4
// Checksum 0x3b85d7d8, Offset: 0x1296
// Size: 0x36
function private set_white_screen( screen_alpha )
{
    if ( isdefined( self.white_screen_overlay ) )
    {
        self.white_screen_overlay.alpha = clamp( screen_alpha, 0, 1 );
    }
}

// Namespace nuke
// Params 1, eflags: 0x4
// Checksum 0xb1ff5d4c, Offset: 0x12d4
// Size: 0xa7
function private function_a62746745a02d3b6( is_nuke_on )
{
    root = powerups::get_powerups_root();
    
    if ( !isdefined( root.nuke_listeners ) )
    {
        return;
    }
    
    foreach ( listener in root.nuke_listeners )
    {
        level [[ listener ]]( is_nuke_on );
    }
}

// Namespace nuke
// Params 1, eflags: 0x4
// Checksum 0x34af9b93, Offset: 0x1383
// Size: 0x42
function private set_ai_stun( n_dur )
{
    if ( utility::issharedfuncdefined( #"zombie", #"stunZombie" ) )
    {
        utility::callsharedfunc( #"zombie", #"stunZombie", n_dur );
    }
}

// Namespace nuke
// Params 0, eflags: 0x4
// Checksum 0x281f0280, Offset: 0x13cd
// Size: 0x47
function private function_669ed7a96571422b()
{
    utility::ent_flag( "burned" );
    params = spawnstruct();
    params.attacker = undefined;
    params.next_damage_time = gettime();
    callback::callback( "burned", params );
}

// Namespace nuke
// Params 0, eflags: 0x4
// Checksum 0xc78466a6, Offset: 0x141c
// Size: 0xbd
function private function_62a77223fa83d822()
{
    if ( isdefined( self ) )
    {
        if ( utility::issharedfuncdefined( #"zombie", #"clearstunzombie" ) )
        {
            utility::callsharedfunc( #"zombie", #"clearstunzombie" );
        }
        
        if ( self.nuked && utility::issharedfuncdefined( #"zombie_utils", #"setmovespeed" ) )
        {
            utility::callsharedfunc( #"zombie_utils", #"setmovespeed", undefined, "nuke", 27 );
        }
        
        params = spawnstruct();
        params.attacker = undefined;
        params.next_damage_time = gettime();
        callback::callback( "burned_end", params );
    }
}

// Namespace nuke
// Params 1
// Checksum 0x74357ebd, Offset: 0x14e1
// Size: 0x54
function function_da3f6806a9d04f42( var_c5d531f1ae010d9d )
{
    root = powerups::get_powerups_root();
    
    if ( !isdefined( root.nuke_listeners ) )
    {
        root.nuke_listeners = [];
    }
    
    root.nuke_listeners[ root.nuke_listeners.size ] = var_c5d531f1ae010d9d;
}

// Namespace nuke
// Params 1
// Checksum 0x8c6c6fe1, Offset: 0x153d
// Size: 0x2c
function function_6e3073b22b57b4f1( var_3a6b121416b9ff1 )
{
    root = powerups::get_powerups_root();
    root.var_27fcb260da34865a = var_3a6b121416b9ff1;
}

// Namespace nuke
// Params 0
// Checksum 0xec1e48d5, Offset: 0x1571
// Size: 0x32
function function_793f52c28e9c0afd()
{
    root = powerups::get_powerups_root();
    
    if ( !isdefined( root.var_27fcb260da34865a ) )
    {
        return 1;
    }
    
    return root.var_27fcb260da34865a;
}

// Namespace nuke
// Params 2
// Checksum 0x8811546a, Offset: 0x15ac
// Size: 0x9c
function function_891d9c0d343ba117( a_players, root )
{
    if ( isdefined( level.var_637d95206b711c69 ) )
    {
        foreach ( func in level.var_637d95206b711c69 )
        {
            return self [[ func ]]( a_players, root );
        }
    }
    
    return 0;
}

// Namespace nuke
// Params 1
// Checksum 0x2ba3f16d, Offset: 0x1651
// Size: 0x3f
function register_grab_override( var_1366eadedac007dc )
{
    if ( !isdefined( level.var_637d95206b711c69 ) )
    {
        level.var_637d95206b711c69 = [];
    }
    
    level.var_637d95206b711c69 = arraycombineunique( level.var_637d95206b711c69, [ var_1366eadedac007dc ] );
}

