// scripts\common\ai\aitypes\zombie_phobos\zombie_phobos_collision.gsc  (hash_3ff59e7e6c39c05f.gscc) (size: 9493 Bytes / 0x2515 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x990e4908 (2567850248)
// size ...... 9493 (0x2515)
// includes .. 9   (offset: 0x22ed)
// strings ... 24  (offset: 0x2335)
// dev strs .. 11  (offset: 0x248d)
// exports ... 27  (offset: 0x13c9)
// cseg ...... 0x1a3 + 0x1226 (0x13c9)
// imports ... 93  (offset: 0x1801)
// animtree1 . 0   (offset: 0x2515)
// animtree2 . 0   (offset: 0x2515)
#using scripts\common\ai\aitypes\shared\zombie\zombie_leap_attack;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_phobos\zombie_phobos_jumpout;
#using scripts\common\ai\aitypes\zombie_phobos\zombie_phobos_leap;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_phobos_collision;

// Namespace zombie_phobos_collision
// Params 1
// Checksum 0x8a08a30d, Offset: 0x1c1
// Size: 0xc
function function_e0fd57a28c8b99cb( var_4b4d72d84afd1ebd )
{
    
}

// Namespace zombie_phobos_collision
// Params 0
// Checksum 0x910b6dfd, Offset: 0x1d5
// Size: 0x54
function function_7eeb3762f93011e()
{
    scriptable::scriptable_adddamagedcallback( &function_cb3cf96706e0a80 );
    utility::registersharedfunc( #"zombie_phobos", #"is_player_attached", &is_player_attached );
    utility::registersharedfunc( #"zombie_phobos", #"hash_b1059ccb2f0cdb27", &function_46bfa3471894c398 );
    
    /#
        function_80568fe95f5e5f30();
    #/
}

// Namespace zombie_phobos_collision
// Params 0
// Checksum 0xb22d1d89, Offset: 0x231
// Size: 0x9
function init_zombie_phobos_collision()
{
    thread function_4139635ef8338a23();
}

// Namespace zombie_phobos_collision
// Params 0, eflags: 0x4
// Checksum 0x5ca180ef, Offset: 0x242
// Size: 0x2ed
function private function_4139635ef8338a23()
{
    self endon( #"death" );
    self.var_772ac58ba54c0701 = getdvarint( @"hash_2a98457dd0563cf1", 4 );
    self.var_77d0126cc851fda8 = [];
    
    if ( self.var_772ac58ba54c0701 > 0 )
    {
        for ( var_c2ad6de33364b53e = 0; var_c2ad6de33364b53e < self.var_772ac58ba54c0701 ; var_c2ad6de33364b53e++ )
        {
            self.var_77d0126cc851fda8[ var_c2ad6de33364b53e ] = utility::spawn_tag_origin( self.origin, self.angles );
            waitframe();
            self.var_77d0126cc851fda8[ var_c2ad6de33364b53e ] linkto( self, "j_spine" + var_c2ad6de33364b53e + 1, ( 0, getdvarfloat( @"hash_91b330b2394e4fa2", 30 ), 0 ), ( 0, 0, -90 ) );
            thread utility::delete_on_death( self.var_77d0126cc851fda8[ var_c2ad6de33364b53e ] );
            self.var_77d0126cc851fda8[ var_c2ad6de33364b53e ].var_66bba814987ce4ee = 1;
            self.var_77d0126cc851fda8[ var_c2ad6de33364b53e ].phobos_owner = self;
        }
        
        self.phobos_trigger_origin = utility::spawn_script_origin( self.var_77d0126cc851fda8[ 0 ].origin, ( 0, 0, 0 ) );
        self.phobos_trigger_origin.phobos_owner = self;
        self.phobos_trigger_origin linkto( self, "j_spine1", ( 0, 70, 0 ), ( 0, 0, -90 ) );
        thread utility::delete_on_death( self.phobos_trigger_origin );
        thread setup_trigger_origin( self.phobos_trigger_origin );
    }
    
    leg_scriptable = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.legscriptable;
    self.var_3f696ebfb0ffe19b = [];
    self.var_3f696ebfb0ffe19b[ 0 ] = spawnscriptable( leg_scriptable, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    self.var_3f696ebfb0ffe19b[ 1 ] = spawnscriptable( leg_scriptable, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    
    if ( utility::issharedfuncdefined( #"zombie_phobos", #"manage_legs" ) )
    {
        utility::callsharedfunc( #"zombie_phobos", #"manage_legs" );
    }
    else
    {
        thread manage_legs();
    }
    
    self.var_b331e173161548c3 = [];
    thread utility::thread_on_notify_no_endon_death( "death", &function_ce05ecd4fb90717, self, self );
    phobos_back = getent( "phobos_back", "targetname" );
    
    if ( isdefined( phobos_back ) )
    {
        if ( !phobos_back utility::ent_flag( "attached_on_back" ) )
        {
            self.phobos_back = phobos_back;
            phobos_back.original_origin = phobos_back.origin;
            function_bf1ac32aa8a5238b( phobos_back );
            thread utility::thread_on_notify_no_endon_death( "death", &function_7210629f713a7546, phobos_back, phobos_back );
        }
    }
}

// Namespace zombie_phobos_collision
// Params 1, eflags: 0x4
// Checksum 0xb61c6096, Offset: 0x537
// Size: 0x41
function private function_bf1ac32aa8a5238b( phobosback )
{
    phobosback utility::ent_flag_set( "attached_on_back" );
    phobosback linkto( self, "j_spine4", ( -50, 0, -20 ), ( 90, 0, -90 ) );
}

// Namespace zombie_phobos_collision
// Params 0, eflags: 0x4
// Checksum 0x6c027d7d, Offset: 0x580
// Size: 0x210
function private manage_legs()
{
    leg_scriptable = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.legscriptable;
    var_3f696ebfb0ffe19b = self.var_3f696ebfb0ffe19b;
    
    while ( isalive( self ) && isdefined( var_3f696ebfb0ffe19b[ 0 ] ) && isdefined( var_3f696ebfb0ffe19b[ 1 ] ) )
    {
        if ( !self.var_c3c26fd223625df0 )
        {
            if ( self.phobos_back && !self.phobos_back utility::ent_flag( "attached_on_back" ) )
            {
                function_bf1ac32aa8a5238b( self.phobos_back );
            }
            
            for ( leg_i = 0; leg_i < 2 ; leg_i++ )
            {
                tag = "j_ball_" + ( leg_i == 0 ? "le" : "ri" );
                target_origin = self gettagorigin( tag ) - ( 0, 0, 10 );
                target_origin = self.origin + anglestoright( self.angles ) * 60 * ( leg_i - 0.5 ) * 2;
                
                if ( distance( target_origin, var_3f696ebfb0ffe19b[ leg_i ].origin ) > 10 )
                {
                    var_3f696ebfb0ffe19b[ leg_i ] freescriptable();
                    var_3f696ebfb0ffe19b[ leg_i ] = spawnscriptable( leg_scriptable, target_origin, self.angles );
                    var_3f696ebfb0ffe19b[ leg_i ].owner = self;
                }
            }
        }
        else
        {
            if ( self.phobos_back utility::ent_flag( "attached_on_back" ) )
            {
                function_7210629f713a7546( self.phobos_back );
            }
            
            for ( leg_i = 0; leg_i < 2 ; leg_i++ )
            {
                if ( var_3f696ebfb0ffe19b[ leg_i ].origin != ( 0, 0, 0 ) )
                {
                    var_3f696ebfb0ffe19b[ leg_i ] freescriptable();
                    var_3f696ebfb0ffe19b[ leg_i ] = spawnscriptable( leg_scriptable, ( 0, 0, 0 ), ( 0, 0, 0 ) );
                }
            }
        }
        
        waitframe();
    }
    
    if ( isdefined( var_3f696ebfb0ffe19b[ 0 ] ) )
    {
        var_3f696ebfb0ffe19b[ 0 ] freescriptable();
    }
    
    if ( isdefined( var_3f696ebfb0ffe19b[ 1 ] ) )
    {
        var_3f696ebfb0ffe19b[ 1 ] freescriptable();
    }
}

// Namespace zombie_phobos_collision
// Params 11, eflags: 0x4
// Checksum 0xe9395fb, Offset: 0x798
// Size: 0xd2
function private function_cb3cf96706e0a80( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( !issubstr( instance.type, "phobos_leg" ) )
    {
        return;
    }
    
    if ( smeansofdeath != "MOD_MELEE" && smeansofdeath != "MOD_CRUSH" )
    {
        return;
    }
    
    instance.owner dodamage( idamage, instance.owner.origin + ( 0, 0, 36 ), eattacker, einflictor, smeansofdeath, objweapon );
}

// Namespace zombie_phobos_collision
// Params 2, eflags: 0x4
// Checksum 0x7ca7f90b, Offset: 0x872
// Size: 0x22d
function private function_38a0b53e2e4921a3( phobos, player )
{
    if ( is_player_attached( player ) )
    {
        function_46bfa3471894c398( phobos, player );
        return;
    }
    
    var_77f3ec339001856d = undefined;
    
    for ( var_c2ad6de33364b53e = phobos.var_772ac58ba54c0701 - 1; var_c2ad6de33364b53e >= 0 ; var_c2ad6de33364b53e-- )
    {
        children = phobos.var_77d0126cc851fda8[ var_c2ad6de33364b53e ] getlinkedchildren( 0 );
        
        if ( !isdefined( children ) || children.size <= 0 )
        {
            var_77f3ec339001856d = phobos.var_77d0126cc851fda8[ var_c2ad6de33364b53e ];
            break;
        }
    }
    
    if ( !isdefined( var_77f3ec339001856d ) )
    {
        return;
    }
    
    player.var_1246efafdc4d25ea = gettime();
    player setstance( "crouch", 1, 1 );
    player thread set_stance( phobos );
    
    if ( isdefined( player.var_cc1262e66dbb1c79 ) )
    {
        player switchtoweaponimmediate( player.var_cc1262e66dbb1c79 );
    }
    else
    {
        player val::set( "phobos_on_back", "weapon", 0 );
    }
    
    player callback::add( #"player_laststand", &function_cdcb4590421e60c2, { #phobos:phobos } );
    player playerlinkto( var_77f3ec339001856d, "tag_origin", 1, 180, 180, 90, 90, 0 );
    
    if ( isdefined( phobos.phobos_back ) )
    {
        phobos.phobos_back hide();
    }
    
    player utility::ent_flag_set( "attached_to_back" );
    player val::set( "phobos_on_back", "killstreaks", 0 );
    player val::set( "phobos_on_back", "weapon_switch", 0 );
    player notifyonplayercommand( "phobos_melee_on_back", "+attack" );
    phobos thread function_18102dd579feeaeb( phobos, player );
    phobos.var_b331e173161548c3[ phobos.var_b331e173161548c3.size ] = player;
    level callback::callback( #"hash_3f722221fa539420", { #interactionevent:#"hash_d34e1eadd49e5a21", #player:player } );
    var_9552a95d96dcbd5e = getdvarint( @"hash_8365ccfad97aa60d", 60 );
    player thread utility::delaythreadendon( var_9552a95d96dcbd5e, "removed_from_phobos_back", &function_46bfa3471894c398, phobos, player );
}

// Namespace zombie_phobos_collision
// Params 1
// Checksum 0x3bb16d06, Offset: 0xaa7
// Size: 0x42, Type: bool
function is_player_attached( player )
{
    if ( isdefined( player ) )
    {
        var_37bf28e977662d28 = player getlinkedparent();
        return ( var_37bf28e977662d28.var_66bba814987ce4ee || player utility::ent_flag( "attached_to_back" ) );
    }
    
    return false;
}

// Namespace zombie_phobos_collision
// Params 2, eflags: 0x4
// Checksum 0xc6a45910, Offset: 0xaf2
// Size: 0x36
function private function_cdcb4590421e60c2( params, additional_params )
{
    phobos = additional_params.phobos;
    function_46bfa3471894c398( phobos, self );
}

// Namespace zombie_phobos_collision
// Params 2
// Checksum 0x447ad1b0, Offset: 0xb30
// Size: 0x91
function function_ce05ecd4fb90717( phobos, params )
{
    foreach ( player in phobos.var_b331e173161548c3 )
    {
        function_46bfa3471894c398( phobos, player );
    }
}

// Namespace zombie_phobos_collision
// Params 2, eflags: 0x4
// Checksum 0x863f321e, Offset: 0xbc9
// Size: 0x121
function private function_46bfa3471894c398( phobos, player )
{
    if ( player )
    {
        if ( !is_player_attached( player ) )
        {
            return;
        }
        
        player unlink( 1 );
        
        if ( phobos )
        {
            player knockback( anglestoright( phobos.angles ), 200, 1 );
        }
        
        player.var_db1bfb1d736629c6 = gettime();
        player utility::ent_flag_clear( "attached_to_back" );
        
        if ( phobos && phobos.var_b331e173161548c3 )
        {
            phobos.var_b331e173161548c3 = arrayremove( phobos.var_b331e173161548c3, player );
            
            if ( phobos.var_b331e173161548c3.size <= 0 )
            {
                if ( isdefined( phobos.phobos_back ) )
                {
                    phobos.phobos_back show();
                }
                
                phobos.var_72db27666d830ea3 = gettime();
            }
        }
        
        player val::reset_all( "phobos_on_back" );
        player callback::remove( #"player_laststand", &function_cdcb4590421e60c2 );
        player notifyonplayercommandremove( "phobos_melee_on_back", "+attack" );
        player notify( #"removed_from_phobos_back" );
    }
}

// Namespace zombie_phobos_collision
// Params 1, eflags: 0x4
// Checksum 0x3f67119b, Offset: 0xcf2
// Size: 0x49
function private set_stance( phobos )
{
    self endon( #"removed_from_phobos_back" );
    self endon( #"death" );
    phobos endon( #"death" );
    
    while ( true )
    {
        self setstance( "crouch", 1, 1 );
        waitframe();
    }
}

// Namespace zombie_phobos_collision
// Params 2, eflags: 0x4
// Checksum 0xccebb097, Offset: 0xd43
// Size: 0xc9
function private function_18102dd579feeaeb( phobos, player )
{
    phobos endon( #"death" );
    player endon( #"death" );
    player endon( #"removed_from_phobos_back" );
    player.var_e85ed5b71f428683 = 0;
    var_234c25b58673e9b6 = getdvarint( @"hash_f8ea6bcb8e715db1", 500 );
    
    while ( true )
    {
        player waittill( #"phobos_melee_on_back" );
        player_angles = player getplayerangles();
        
        if ( player_angles[ 0 ] > 45 )
        {
            phobos dodamage( var_234c25b58673e9b6, player.origin, player, player, "MOD_MELEE", player getcurrentweapon() );
            var_2788ca27d9161df3 = 1;
        }
    }
}

// Namespace zombie_phobos_collision
// Params 2
// Checksum 0xb410f827, Offset: 0xe14
// Size: 0xe0
function function_c1f2696a8edc6e5c( phobos, player )
{
    if ( gettime() - ( phobos.var_9cd09373e3dad13 ?? 0 ) < 300 )
    {
        return;
    }
    
    phobos.var_9cd09373e3dad13 = gettime();
    melee_hit_limit = getdvarfloat( @"hash_f9a2c99130312cad", 7 );
    player.var_e85ed5b71f428683++;
    
    if ( player.var_e85ed5b71f428683 > melee_hit_limit )
    {
        function_46bfa3471894c398( phobos, player );
        return;
    }
    
    if ( getdvarint( @"hash_ed4e3df98fb780f2", 1 ) )
    {
        if ( phobos.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_62b1a2c60986cf52 )
        {
            function_8f9c848ecb6ccdd3( phobos );
            return;
        }
        
        if ( !zombie_phobos_leap::leap_forward( phobos, 500 ) )
        {
            zombie_phobos_leap::leap_forward( phobos, 200 );
        }
    }
}

// Namespace zombie_phobos_collision
// Params 1, eflags: 0x4
// Checksum 0x55066c2b, Offset: 0xefc
// Size: 0x9a
function private function_8f9c848ecb6ccdd3( phobos )
{
    if ( phobos zombie_leap_attack::is_in_leap_attack() )
    {
        return;
    }
    
    if ( gettime() - ( phobos._blackboard.var_576df40752e47aac ?? 0 ) <= 0 )
    {
        return;
    }
    
    leap_success = zombie_phobos_leap::leap_forward( phobos, 500 );
    
    if ( !leap_success )
    {
        leap_success = zombie_phobos_leap::leap_forward( phobos, 200 );
    }
    
    if ( leap_success )
    {
        phobos._blackboard.var_576df40752e47aac = gettime() + phobos._blackboard.var_61e56d196f8dacad;
    }
}

// Namespace zombie_phobos_collision
// Params 1, eflags: 0x4
// Checksum 0xbe427ce4, Offset: 0xf9e
// Size: 0x88
function private setup_trigger_origin( trigger_origin )
{
    trigger_origin makeusable();
    trigger_origin.range = getdvarfloat( @"hash_24049a432ddd99c5", 128 );
    trigger_origin setuserange( trigger_origin.range );
    trigger_origin setusableenabled( 1 );
    trigger_origin sethintonobstruction( "show" );
    trigger_origin sethintdisplayfov( 360 );
    trigger_origin sethintdisplayrange( 500 );
    trigger_origin setusefov( 360 );
    trigger_origin thread listen_for_uses();
    
    /#
        trigger_origin thread debug_draw_trigger();
    #/
}

// Namespace zombie_phobos_collision
// Params 0, eflags: 0x4
// Checksum 0xc86f0f0f, Offset: 0x102e
// Size: 0xd5
function private listen_for_uses()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"trigger", player );
        
        if ( utility::time_has_passed( player.var_1246efafdc4d25ea ?? 0, 1 ) && utility::time_has_passed( player.var_db1bfb1d736629c6 ?? 0, 2 ) && !self.phobos_owner zombie_phobos_jumpout::is_outside_arena() && !player.interactions_disabled )
        {
            if ( utility::issharedfuncdefined( #"zombie_phobos", #"hash_7c6ed9822fa04c81" ) )
            {
                if ( utility::callsharedfunc( #"zombie_phobos", #"hash_7c6ed9822fa04c81", player ) )
                {
                    continue;
                }
            }
            
            function_38a0b53e2e4921a3( self.phobos_owner, player );
        }
    }
}

// Namespace zombie_phobos_collision
// Params 1, eflags: 0x4
// Checksum 0x6309beb1, Offset: 0x110b
// Size: 0x38
function private function_7210629f713a7546( back )
{
    back unlink();
    back.origin = back.original_origin;
    back utility::ent_flag_clear( "attached_on_back" );
}

/#

    // Namespace zombie_phobos_collision
    // Params 0, eflags: 0x4
    // Checksum 0x72c13704, Offset: 0x114b
    // Size: 0x70, Type: dev
    function private function_80568fe95f5e5f30()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x3c>", "<dev string:x48>", &function_e1170986458bd376 );
        devgui::add_devgui_func( "<dev string:x5a>", "<dev string:x6a>", &toggle_collision_debug );
        devgui::add_devgui_func( "<dev string:x81>", "<dev string:x95>", &function_527ca7cc828e9bd8 );
        devgui::add_devgui_func( "<dev string:xab>", "<dev string:xcf>", &function_8f99a90422093986 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_phobos_collision
    // Params 1, eflags: 0x4
    // Checksum 0xb7f46a45, Offset: 0x11c3
    // Size: 0xcb, Type: dev
    function private function_e1170986458bd376( params )
    {
        phobos = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:xe9>" );
        
        if ( isdefined( phobos ) )
        {
            foreach ( player in level.players )
            {
                if ( player != level.players[ 0 ] )
                {
                    function_38a0b53e2e4921a3( phobos, player );
                }
            }
        }
    }

    // Namespace zombie_phobos_collision
    // Params 1, eflags: 0x4
    // Checksum 0xc2268e0f, Offset: 0x1296
    // Size: 0x24, Type: dev
    function private toggle_collision_debug( params )
    {
        devgui::function_3f8a26ec96988e80( "<dev string:xf7>", @"phobos_collision_debug" );
    }

    // Namespace zombie_phobos_collision
    // Params 0, eflags: 0x4
    // Checksum 0xb5851dc, Offset: 0x12c2
    // Size: 0x16, Type: dev
    function private debug_collision()
    {
        return getdvarint( @"phobos_collision_debug", 0 ) > 0;
    }

    // Namespace zombie_phobos_collision
    // Params 0, eflags: 0x4
    // Checksum 0xa33c7950, Offset: 0x12e0
    // Size: 0x47, Type: dev
    function private debug_draw_trigger()
    {
        self endon( #"death" );
        
        while ( true )
        {
            if ( debug_collision() )
            {
                sphere( self.origin, self.range, ( 1, 0, 0 ) );
            }
            
            waitframe();
        }
    }

    // Namespace zombie_phobos_collision
    // Params 0, eflags: 0x4
    // Checksum 0x61a95a00, Offset: 0x132f
    // Size: 0x69, Type: dev
    function private function_527ca7cc828e9bd8()
    {
        player = level.players[ 0 ];
        
        if ( !isdefined( player.var_e85ed5b71f428683 ) )
        {
            player.var_e85ed5b71f428683 = 0;
        }
        
        phobos = zombie_utils::get_closest_zombie( player.origin, undefined, "<dev string:xe9>" );
        
        if ( !phobos )
        {
            return;
        }
        
        function_c1f2696a8edc6e5c( phobos, player );
    }

    // Namespace zombie_phobos_collision
    // Params 0, eflags: 0x4
    // Checksum 0x33588335, Offset: 0x13a0
    // Size: 0x29, Type: dev
    function private function_8f99a90422093986()
    {
        player = level.players[ 0 ];
        player.var_e85ed5b71f428683 = 0;
    }

#/
