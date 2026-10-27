// script_7f0fdfedd9ca7570  (hash_7f0fdfedd9ca7570.gscc) (size: 21928 Bytes / 0x55a8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf10842fa (4043850490)
// size ...... 21928 (0x55a8)
// includes .. 8   (offset: 0x5340)
// strings ... 28  (offset: 0x5380)
// dev strs .. 14  (offset: 0x5500)
// exports ... 54  (offset: 0x3b0c)
// cseg ...... 0x24e + 0x38be (0x3b0c)
// imports ... 122 (offset: 0x437c)
// animtree1 . 0   (offset: 0x55a8)
// animtree2 . 0   (offset: 0x55a8)
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\shellshock_utility;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_diana_winged_tornado_attack;

// Namespace zombie_diana_winged_tornado_attack
// Params 0
// Checksum 0xd6a64306, Offset: 0x26c
// Size: 0x2d
function function_8bf6a89a142feeb1()
{
    callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_killed", &function_64cde68d1172cf61 );
    
    /#
        level thread winged_tornado_attack_devgui();
    #/
}

// Namespace zombie_diana_winged_tornado_attack
// Params 0
// Checksum 0xc0df3d0d, Offset: 0x2a1
// Size: 0x3a2
function init_zombie_diana_winged_tornado_attack()
{
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    self.var_2d19329c64eab014 = [];
    self.var_f8e129e8b7f6ba01 = settings.tornadolifetime;
    self.var_14ff3d060de7c5f7 = settings.var_ade159a6b27ffd4f;
    self.var_86090ad5aee7bdd9 = settings.var_86090ad5aee7bdd9;
    self.tornadodamageradius = settings.tornadodamageradius;
    self.var_5f9cdcd6bbc3841c = squared( settings.tornadodamageradius );
    self.var_e6a8c182f0e6901d = settings.var_e6a8c182f0e6901d;
    self.var_360dda343f526300 = getdvarfloat( @"hash_d410daa4699445fe", settings.var_360dda343f526300 );
    self.var_425c09d6e8bf4c43 = getdvarfloat( @"hash_5926469fc7dc7faf", settings.var_425c09d6e8bf4c43 );
    self.var_988e1bfb776e699b = settings.var_988e1bfb776e699b ?? 3;
    self.var_d9037c74882a3b18 = getdvarfloat( @"hash_6ef872e1a040a6e1", settings.var_d9037c74882a3b18 ) ?? 0.25;
    self.var_a5a4e39aeb96e4ad = getdvarfloat( @"hash_23bd2cde573b95cc", settings.var_a5a4e39aeb96e4ad ) ?? 1.5;
    self.var_98715bf756ba6514 = settings.var_98715bf756ba6514;
    self.var_e82e63f50a607637 = settings.var_e82e63f50a607637;
    self.var_dd99906788c15b95 = settings.var_dd99906788c15b95 ?? 300;
    self.var_982244ebf9619479 = squared( self.var_dd99906788c15b95 );
    self.var_a4af7d404c2a92a5 = settings.var_a4af7d404c2a92a5;
    self.var_49a974a214e8d409 = squared( self.var_a4af7d404c2a92a5 );
    self.var_b90aaedb81c8d467 = [ getdvarfloat( @"hash_fdf0ce480a111fa0", settings.var_b90a70db81c84c0d ), getdvarfloat( @"hash_fdf0d1480a112639", settings.var_b90a6ddb81c84574 ), getdvarfloat( @"hash_fdf0d0480a112406", settings.var_b90a6edb81c847a7 ) ];
    self.var_ce6e5d33ab5ea76a = settings.var_fe12bfa8542e7e5d ?? 500;
    self.var_ef2f055a632af5b4 = settings.var_9a1d4ab1db3bd7af ?? 2000;
    self.var_ea022a0944ad3fcc = settings.var_ea022a0944ad3fcc ?? 0.5;
    self.var_adca1a32a7df5d82 = settings.var_adca1a32a7df5d82 ?? 1.5;
    self.var_c4bd7e49583497f4 = settings.var_c4bd7e49583497f4 ?? 300;
    self.var_10c97cdb05c79ce1 = settings.var_10c97cdb05c79ce1 ?? 800;
    self.var_707c906407d968a4 = settings.var_707c906407d968a4 ?? 200;
    self.var_522fe5be5b52b8df = getdvarfloat( @"hash_50bc1e8d2216c833", settings.var_25838747641bede2 ?? 80 );
    self.var_e54cb8ede5cf2011 = getdvarfloat( @"hash_51d0fc593af72b33", settings.var_e54cb8ede5cf2011 ?? 600 );
    self.var_1aae8b7acfda8c13 = 0;
    self.var_7900bbbb6dec0637 = 2;
    self.var_d07937101f7ccc9f = clampint( level.players.size + 1, self.var_7900bbbb6dec0637, 4 );
    set_winged_tornado_attack_cooldown( settings.var_9596e7e00a4fa254 );
    function_5bcf086a3ac09f6c( self.origin, 600 );
    thread function_aaf0637ef9f5bb2a();
}

// Namespace zombie_diana_winged_tornado_attack
// Params 0
// Checksum 0x322d5b9b, Offset: 0x64b
// Size: 0x144
function turn_off_winged_tornado_attack()
{
    self.var_15b01419a0d56fdc = undefined;
    self.var_2d19329c64eab014 = undefined;
    self.var_f8e129e8b7f6ba01 = undefined;
    self.var_14ff3d060de7c5f7 = undefined;
    self.var_86090ad5aee7bdd9 = undefined;
    self.var_5f9cdcd6bbc3841c = undefined;
    self.var_e6a8c182f0e6901d = undefined;
    self.var_360dda343f526300 = undefined;
    self.var_425c09d6e8bf4c43 = undefined;
    self.var_988e1bfb776e699b = undefined;
    self.var_d9037c74882a3b18 = undefined;
    self.var_a5a4e39aeb96e4ad = undefined;
    self.var_98715bf756ba6514 = undefined;
    self.var_e82e63f50a607637 = undefined;
    self.var_dd99906788c15b95 = undefined;
    self.var_982244ebf9619479 = undefined;
    self.var_a4af7d404c2a92a5 = undefined;
    self.var_49a974a214e8d409 = undefined;
    self.var_b90aaedb81c8d467 = undefined;
    self.var_ce6e5d33ab5ea76a = undefined;
    self.var_ef2f055a632af5b4 = undefined;
    self.var_ea022a0944ad3fcc = undefined;
    self.var_adca1a32a7df5d82 = undefined;
    self.var_c4bd7e49583497f4 = undefined;
    self.var_10c97cdb05c79ce1 = undefined;
    self.var_707c906407d968a4 = undefined;
    self.var_1aae8b7acfda8c13 = undefined;
    self.var_7900bbbb6dec0637 = undefined;
    self.var_d07937101f7ccc9f = undefined;
    self.var_522fe5be5b52b8df = undefined;
    self.var_e54cb8ede5cf2011 = undefined;
    self notify( #"turn_off_winged_tornado_attack" );
}

// Namespace zombie_diana_winged_tornado_attack
// Params 1
// Checksum 0x495b01be, Offset: 0x797
// Size: 0x17
function set_winged_tornado_attack_cooldown( cooldownseconds )
{
    self.var_9596e7e00a4fa254 = cooldownseconds;
}

// Namespace zombie_diana_winged_tornado_attack
// Params 1
// Checksum 0xadeea286, Offset: 0x7b6
// Size: 0x17
function function_eb67cab25bd84134( phase )
{
    self.var_8c04f7c1944e758 = phase;
}

// Namespace zombie_diana_winged_tornado_attack
// Params 1
// Checksum 0xbe5bfcff, Offset: 0x7d5
// Size: 0x3c
function function_487be135af565351( var_2fffdfe566ff40 )
{
    self.var_7900bbbb6dec0637 = var_2fffdfe566ff40;
    self.var_d07937101f7ccc9f = clampint( level.players.size + 1, self.var_7900bbbb6dec0637, 4 );
}

// Namespace zombie_diana_winged_tornado_attack
// Params 2
// Checksum 0x86ab3368, Offset: 0x819
// Size: 0x68
function function_5bcf086a3ac09f6c( var_6ffdf2ceff7e2473, anchorradius = 600 )
{
    assert( anchorradius > 0, "<dev string:x24>" );
    self.var_15b01419a0d56fdc = {};
    self.var_15b01419a0d56fdc.var_6ffdf2ceff7e2473 = var_6ffdf2ceff7e2473;
    self.var_15b01419a0d56fdc.anchorradius = anchorradius;
}

// Namespace zombie_diana_winged_tornado_attack
// Params 1
// Checksum 0xb9fad5fc, Offset: 0x889
// Size: 0xab
function function_c1f639281246500a( orbitdist )
{
    self.var_522fe5be5b52b8df = orbitdist;
    self.var_2d19329c64eab014 = function_5713d46873b29625( self.var_2d19329c64eab014 );
    
    foreach ( flametornado in self.var_2d19329c64eab014 )
    {
        flametornado.orbitdist = orbitdist;
    }
}

// Namespace zombie_diana_winged_tornado_attack
// Params 2
// Checksum 0x2dbe4c17, Offset: 0x93c
// Size: 0x52
function function_ff73a4d09eb571b0( flametornado, forceddestination )
{
    assert( arraycontains( self.var_2d19329c64eab014, flametornado ), "<dev string:x4d>" );
    assert( isvector( forceddestination ), "<dev string:x88>" );
    flametornado.forceddestination = forceddestination;
}

// Namespace zombie_diana_winged_tornado_attack
// Params 0
// Checksum 0x4dcdca77, Offset: 0x996
// Size: 0x91
function function_d302635cc6e02bdd()
{
    self.var_2d19329c64eab014 = function_5713d46873b29625( self.var_2d19329c64eab014 );
    
    foreach ( flametornado in self.var_2d19329c64eab014 )
    {
        function_e8a0b1a5c4fae6e2( flametornado );
    }
}

// Namespace zombie_diana_winged_tornado_attack
// Params 1
// Checksum 0x99d1b9f2, Offset: 0xa2f
// Size: 0x210
function function_e8a0b1a5c4fae6e2( flametornado )
{
    if ( !flametornado || flametornado.isdespawning )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) )
        {
            if ( player.var_f71c86cc6fcf9cd == flametornado )
            {
                var_f11557bc9c349a62 = 0;
                
                foreach ( activetornado in self.var_2d19329c64eab014 )
                {
                    if ( isdefined( activetornado ) && activetornado != flametornado )
                    {
                        if ( distance2dsquared( activetornado.origin, player.origin ) < self.var_982244ebf9619479 )
                        {
                            var_f11557bc9c349a62 = 1;
                            break;
                        }
                    }
                }
                
                if ( !var_f11557bc9c349a62 )
                {
                    flametornado function_bbf665e055741600( player, "off" );
                }
                
                player.var_f71c86cc6fcf9cd = undefined;
            }
            
            if ( player.var_754003c0046ec31b == flametornado )
            {
                player.var_754003c0046ec31b = undefined;
            }
        }
    }
    
    self.var_2d19329c64eab014 = arrayremove( self.var_2d19329c64eab014, flametornado );
    
    if ( flametornado.anchorent )
    {
        flametornado.anchorent delete();
    }
    
    flametornado setscriptablepartstate( "base", "despawn" );
    flametornado.isdespawning = 1;
    flametornado notify( #"hash_c2f97cd42822cf3d" );
    flametornado function_385d5746703d4a6a();
    flametornado thread utility::delete_after_delay( 1 );
}

// Namespace zombie_diana_winged_tornado_attack
// Params 0
// Checksum 0xcacdf54e, Offset: 0xc47
// Size: 0x95
function function_c40d8c7dad9b7976()
{
    if ( !self.var_2d19329c64eab014 )
    {
        return;
    }
    
    function_d302635cc6e02bdd();
    
    foreach ( player in level.players )
    {
        function_bbf665e055741600( player, "off" );
    }
}

// Namespace zombie_diana_winged_tornado_attack
// Params 1, eflags: 0x4
// Checksum 0x862d025b, Offset: 0xce4
// Size: 0x8b
function private function_64cde68d1172cf61( params )
{
    foreach ( flametornado in self.var_2d19329c64eab014 )
    {
        if ( isdefined( flametornado ) )
        {
            function_e8a0b1a5c4fae6e2( flametornado );
        }
    }
}

// Namespace zombie_diana_winged_tornado_attack
// Params 0, eflags: 0xc
// Checksum 0xb0c13856, Offset: 0xd77
// Size: 0x144
function private function_aaf0637ef9f5bb2a()
{
    self notify( #"hash_a460af2058588a5c" );
    self endon( #"hash_a460af2058588a5c" );
    self endon( #"death" );
    self endon( #"turn_off_winged_tornado_attack" );
    
    while ( true )
    {
        self waittill( #"winged_tornado_attack_start" );
        self function_786bb6aa1b76c7ee( "in_idle_waiting_for_action", 1 );
        waitmsg = utility::waittill_any_in_array_or_timeout( [ "armor_break_start", "hibernation_start", "idle_loop_end" ], 2 );
        
        if ( waitmsg == "idle_loop_end" )
        {
            self.var_fbd2b9707b5bd16f = 1;
            function_ff42fc633dc464c4();
            asm::function_7256f5ba459c840b( "tornado_winged_attack_in" );
            self function_786bb6aa1b76c7ee( "in_idle_waiting_for_action", 0 );
            thread function_33372a1b94be2b52();
            utility::waittill_notify_or_timeout( "winged_tornado_attack_end", 12 );
            self.var_fbd2b9707b5bd16f = undefined;
            self.var_6a8cf624c493c50b = gettime();
            
            if ( self.var_f9e48b7ff2c39654.size + 1 > 6 )
            {
                self.var_f9e48b7ff2c39654[ self.var_f9e48b7ff2c39654.size - 1 ] = undefined;
            }
            
            self.var_f9e48b7ff2c39654 = arraycombine( [ "winged_tornado_attack" ], self.var_f9e48b7ff2c39654 );
            continue;
        }
        
        self function_786bb6aa1b76c7ee( "in_idle_waiting_for_action", 0 );
    }
}

// Namespace zombie_diana_winged_tornado_attack
// Params 0, eflags: 0x4
// Checksum 0x734fe072, Offset: 0xec3
// Size: 0xac
function private function_ff42fc633dc464c4()
{
    traversalattributes = {};
    traversalattributes.startpos = self.origin;
    traversalattributes.endpos = self.origin;
    traversalattributes.angles = self.angles;
    
    if ( traversalattributes.startpos && traversalattributes.endpos && traversalattributes.angles )
    {
        self settraversalattributes( traversalattributes.startpos, traversalattributes.endpos, traversalattributes.angles, traversalattributes.endpos );
    }
}

// Namespace zombie_diana_winged_tornado_attack
// Params 0, eflags: 0xc
// Checksum 0x790174f5, Offset: 0xf77
// Size: 0x7b
function private function_33372a1b94be2b52()
{
    self notify( #"hash_7447ec880326731b" );
    self endon( #"hash_7447ec880326731b" );
    self endon( #"death" );
    self endon( #"winged_tornado_attack_end" );
    
    while ( true )
    {
        self waittill( #"spawn_flame_tornado" );
        tornadospawnpos = get_tornado_spawn_position();
        
        if ( isdefined( tornadospawnpos ) )
        {
            thread spawn_flame_tornado( tornadospawnpos, ( 0, vectortoyaw( tornadospawnpos - self.origin ), 0 ) );
        }
    }
}

// Namespace zombie_diana_winged_tornado_attack
// Params 0, eflags: 0x4
// Checksum 0x8256100b, Offset: 0xffa
// Size: 0x2ff
function private get_tornado_spawn_positions()
{
    var_adfac6b0273b6ad = 35;
    
    if ( !self )
    {
        return;
    }
    
    var_3569f8693ddeb680 = [];
    currentplayerindex = 0;
    activeplayers = arrayrandomize( self.var_c15224f047a275e5 );
    var_c962ec5b95a1cf0 = getdvarint( @"hash_710214172cd8c65d", 1 );
    
    if ( activeplayers.size > 0 )
    {
        for ( i = 0; i < self.var_d07937101f7ccc9f ; i++ )
        {
            playertarget = activeplayers[ currentplayerindex ];
            var_3f85e4df1ef10b02 = var_c962ec5b95a1cf0 && ( playertarget.ignoreme && !playertarget.var_f468cf5c9e75db1 || playertarget.notarget || playertarget.aether_shroud_active || playertarget getthreatbiasgroup() == "ignored_by_zombies" || playertarget.inlaststand );
            var_17530d9e25ed70e2 = vectornormalize2( self.origin - playertarget.origin );
            
            if ( i == activeplayers.size - 1 && self.var_d07937101f7ccc9f != activeplayers.size )
            {
                if ( var_3f85e4df1ef10b02 )
                {
                    for ( j = 0; j < 2 ; j++ )
                    {
                        randompoint = utility::getrandompointincircle( self.var_4827856486127f11.tetherpoint, self.var_4827856486127f11.tetherradius );
                        tornadospawnpos = getclosestpointonnavmesh( randompoint );
                        
                        if ( !tornadospawnpos )
                        {
                            tornadospawnpos = self.var_4827856486127f11.tetherpoint;
                        }
                        
                        tornadospawnpos = utility::drop_to_ground( tornadospawnpos );
                        var_3569f8693ddeb680[ var_3569f8693ddeb680.size ] = tornadospawnpos;
                    }
                }
                else
                {
                    var_abdf0c3dfc312feb = rotatepointaroundvector( ( 0, 0, 1 ), var_17530d9e25ed70e2, var_adfac6b0273b6ad );
                    tornadospawnpos = utility::drop_to_ground( getclosestpointonnavmesh( playertarget.origin + self.var_86090ad5aee7bdd9 * var_abdf0c3dfc312feb ) );
                    var_3569f8693ddeb680[ var_3569f8693ddeb680.size ] = tornadospawnpos;
                    var_a29724aa9b8abd7d = rotatepointaroundvector( ( 0, 0, 1 ), var_17530d9e25ed70e2, var_adfac6b0273b6ad * -1 );
                    tornadospawnpos = utility::drop_to_ground( getclosestpointonnavmesh( playertarget.origin + self.var_86090ad5aee7bdd9 * var_a29724aa9b8abd7d ) );
                    var_3569f8693ddeb680[ var_3569f8693ddeb680.size ] = tornadospawnpos;
                }
                
                break;
            }
            
            if ( var_3f85e4df1ef10b02 )
            {
                randompoint = utility::getrandompointincircle( self.var_4827856486127f11.tetherpoint, self.var_4827856486127f11.tetherradius );
                tornadospawnpos = getclosestpointonnavmesh( randompoint );
                
                if ( !tornadospawnpos )
                {
                    tornadospawnpos = self.var_4827856486127f11.tetherpoint;
                }
                
                tornadospawnpos = utility::drop_to_ground( tornadospawnpos );
            }
            else
            {
                tornadospawnpos = utility::drop_to_ground( getclosestpointonnavmesh( playertarget.origin + self.var_86090ad5aee7bdd9 * var_17530d9e25ed70e2 ) );
            }
            
            var_3569f8693ddeb680[ var_3569f8693ddeb680.size ] = tornadospawnpos;
            currentplayerindex++;
        }
        
        return var_3569f8693ddeb680;
    }
}

// Namespace zombie_diana_winged_tornado_attack
// Params 0, eflags: 0x4
// Checksum 0xaaa7b075, Offset: 0x1301
// Size: 0x3a2
function private get_tornado_spawn_position()
{
    var_adfac6b0273b6ad = 35;
    
    if ( !self.var_f67f91df3faf9e3f || self.var_f67f91df3faf9e3f >= self.var_d07937101f7ccc9f )
    {
        self.var_3ef45dbc2328820b = arrayrandomize( self.var_c15224f047a275e5 );
        self.var_f67f91df3faf9e3f = 0;
        self.var_e933ab5e6490275 = 0;
    }
    
    i = self.var_f67f91df3faf9e3f;
    activeplayers = self.var_3ef45dbc2328820b;
    currentplayerindex = self.var_e933ab5e6490275;
    var_c962ec5b95a1cf0 = getdvarint( @"hash_710214172cd8c65d", 1 );
    tornadospawnpos = undefined;
    
    if ( activeplayers.size > 0 )
    {
        playertarget = activeplayers[ currentplayerindex ];
        
        if ( !isdefined( playertarget ) )
        {
            self.var_f67f91df3faf9e3f++;
            return;
        }
        
        var_3f85e4df1ef10b02 = var_c962ec5b95a1cf0 && ( playertarget.ignoreme && !playertarget.var_f468cf5c9e75db1 || playertarget.notarget || playertarget.aether_shroud_active || playertarget getthreatbiasgroup() == "ignored_by_zombies" || playertarget.inlaststand );
        var_17530d9e25ed70e2 = vectornormalize2( self.origin - playertarget.origin );
        
        if ( i == activeplayers.size - 1 && self.var_d07937101f7ccc9f != activeplayers.size )
        {
            if ( var_3f85e4df1ef10b02 )
            {
                randompoint = utility::getrandompointincircle( self.var_4827856486127f11.tetherpoint, self.var_4827856486127f11.tetherradius );
                tornadospawnpos = getclosestpointonnavmesh( randompoint );
                
                if ( !tornadospawnpos )
                {
                    tornadospawnpos = self.var_4827856486127f11.tetherpoint;
                }
                
                tornadospawnpos = utility::drop_to_ground( tornadospawnpos );
            }
            else
            {
                var_abdf0c3dfc312feb = rotatepointaroundvector( ( 0, 0, 1 ), var_17530d9e25ed70e2, var_adfac6b0273b6ad );
                tornadospawnpos = utility::drop_to_ground( getclosestpointonnavmesh( playertarget.origin + self.var_86090ad5aee7bdd9 * var_abdf0c3dfc312feb ) );
            }
        }
        else if ( i > activeplayers.size - 1 && self.var_d07937101f7ccc9f != activeplayers.size )
        {
            if ( var_3f85e4df1ef10b02 )
            {
                randompoint = utility::getrandompointincircle( self.var_4827856486127f11.tetherpoint, self.var_4827856486127f11.tetherradius );
                tornadospawnpos = getclosestpointonnavmesh( randompoint );
                
                if ( !tornadospawnpos )
                {
                    tornadospawnpos = self.var_4827856486127f11.tetherpoint;
                }
                
                tornadospawnpos = utility::drop_to_ground( tornadospawnpos );
            }
            else
            {
                var_a29724aa9b8abd7d = rotatepointaroundvector( ( 0, 0, 1 ), var_17530d9e25ed70e2, var_adfac6b0273b6ad * -1 );
                tornadospawnpos = utility::drop_to_ground( getclosestpointonnavmesh( playertarget.origin + self.var_86090ad5aee7bdd9 * var_a29724aa9b8abd7d ) );
            }
        }
        else
        {
            if ( var_3f85e4df1ef10b02 )
            {
                randompoint = utility::getrandompointincircle( self.var_4827856486127f11.tetherpoint, self.var_4827856486127f11.tetherradius );
                tornadospawnpos = getclosestpointonnavmesh( randompoint );
                
                if ( !tornadospawnpos )
                {
                    tornadospawnpos = self.var_4827856486127f11.tetherpoint;
                }
                
                tornadospawnpos = utility::drop_to_ground( tornadospawnpos );
            }
            else
            {
                tornadospawnpos = utility::drop_to_ground( getclosestpointonnavmesh( playertarget.origin + self.var_86090ad5aee7bdd9 * var_17530d9e25ed70e2 ) );
            }
            
            self.var_e933ab5e6490275++;
        }
    }
    
    self.var_f67f91df3faf9e3f++;
    return tornadospawnpos;
}

// Namespace zombie_diana_winged_tornado_attack
// Params 2, eflags: 0x4
// Checksum 0xf7f4e3cb, Offset: 0x16ac
// Size: 0x171
function private spawn_flame_tornado( tornadospawnpos, spawnangles )
{
    self endon( #"death" );
    assert( isdefined( self.var_14ff3d060de7c5f7 ), "<dev string:xdc>" );
    tornado = utility::spawn_model( self.var_14ff3d060de7c5f7, tornadospawnpos, spawnangles ?? ( 0, 0, 0 ) );
    
    if ( !isdefined( self.var_2d19329c64eab014 ) )
    {
        self.var_2d19329c64eab014 = [];
    }
    
    self.var_2d19329c64eab014[ self.var_2d19329c64eab014.size ] = tornado;
    tornado.owner = self;
    tornado.team = self.team;
    tornado.speed = self.var_b90aaedb81c8d467[ self.bossfightphase - 1 ];
    tornado.basespeed = tornado.speed;
    tornado.offsetdirection = self.var_1aae8b7acfda8c13 % 3;
    self.var_1aae8b7acfda8c13++;
    tornado setscriptablepartstate( "impact", "on" );
    wait 0.1;
    tornado setscriptablepartstate( "base", "move" );
    tornado thread function_b9f608fec11a7545();
    tornado thread function_8fcd7b9af5e7db0();
    tornado thread function_3b166c3580f9c68a();
    tornado thread flame_tornado_watch_timeout();
    tornado thread function_6286715cb1353030();
    tornado thread function_e6cc75409d57e9a0();
    return tornado;
}

// Namespace zombie_diana_winged_tornado_attack
// Params 0, eflags: 0x4
// Checksum 0xf5f4910f, Offset: 0x1826
// Size: 0x188
function private function_b9f608fec11a7545()
{
    self endon( #"death" );
    self.owner endon( #"death" );
    flametornado = self;
    diana = flametornado.owner;
    
    while ( true )
    {
        if ( flametornado.var_1887aca4206260e6 )
        {
            wait 0.1;
            continue;
        }
        
        potentialtarget = undefined;
        closestdistsq = undefined;
        var_c962ec5b95a1cf0 = getdvarint( @"hash_710214172cd8c65d", 1 );
        var_ac1ba83c9e0a6a2d = diana function_f017e352a29a57a1( flametornado.origin, diana.var_a4af7d404c2a92a5, var_c962ec5b95a1cf0 );
        
        if ( var_ac1ba83c9e0a6a2d.size > 0 )
        {
            foreach ( var_6a489cc91ef7ba in var_ac1ba83c9e0a6a2d )
            {
                if ( !flametornado function_cb7590cfaf46aded( var_6a489cc91ef7ba ) )
                {
                    continue;
                }
                
                var_3e4d67be86840ef8 = distancesquared( var_6a489cc91ef7ba.origin, flametornado.origin );
                
                if ( !closestdistsq || var_3e4d67be86840ef8 < closestdistsq )
                {
                    potentialtarget = var_6a489cc91ef7ba;
                    closestdistsq = var_3e4d67be86840ef8;
                }
            }
            
            if ( potentialtarget )
            {
                flametornado function_89e1dbd92afdad33( potentialtarget );
            }
        }
        
        wait 0.1;
    }
}

// Namespace zombie_diana_winged_tornado_attack
// Params 1, eflags: 0x4
// Checksum 0xa06a028e, Offset: 0x19b6
// Size: 0xe2, Type: bool
function private function_cb7590cfaf46aded( var_6a489cc91ef7ba )
{
    if ( !isplayer( var_6a489cc91ef7ba ) || isai( var_6a489cc91ef7ba ) || !isdefined( var_6a489cc91ef7ba.team ) || var_6a489cc91ef7ba.team == self.team )
    {
        return false;
    }
    
    flametornado = self;
    
    if ( isdefined( var_6a489cc91ef7ba.var_df84ed0d5103a89a ) && var_6a489cc91ef7ba.var_df84ed0d5103a89a != flametornado )
    {
        if ( distancesquared( flametornado.origin, var_6a489cc91ef7ba.origin ) >= distancesquared( var_6a489cc91ef7ba.var_df84ed0d5103a89a.origin, var_6a489cc91ef7ba.origin ) )
        {
            return false;
        }
    }
    
    if ( flametornado.var_1887aca4206260e6 && var_6a489cc91ef7ba == flametornado.var_abd905c22192cba8 )
    {
        return false;
    }
    
    return true;
}

// Namespace zombie_diana_winged_tornado_attack
// Params 1, eflags: 0x4
// Checksum 0xc8aecb9a, Offset: 0x1aa1
// Size: 0xbb
function private function_89e1dbd92afdad33( player )
{
    flametornado = self;
    
    if ( isdefined( player ) )
    {
        if ( isdefined( flametornado.seekingplayer ) && player != flametornado.seekingplayer )
        {
            flametornado function_385d5746703d4a6a();
        }
        
        flametornado.seekingplayer = player;
        player.var_df84ed0d5103a89a = flametornado;
        
        if ( !isdefined( flametornado.var_4b79f02d647a0220 ) || distancesquared( flametornado.var_4b79f02d647a0220, player.origin ) > 4000 )
        {
            flametornado.var_4b79f02d647a0220 = player.origin;
            flametornado notify( #"seek_new_target" );
        }
    }
}

// Namespace zombie_diana_winged_tornado_attack
// Params 0, eflags: 0x4
// Checksum 0x663f3d1f, Offset: 0x1b64
// Size: 0x4b
function private function_385d5746703d4a6a()
{
    flametornado = self;
    
    if ( !isdefined( flametornado.seekingplayer ) )
    {
        return;
    }
    
    flametornado.seekingplayer.var_df84ed0d5103a89a = undefined;
    flametornado.seekingplayer = undefined;
    flametornado.var_4b79f02d647a0220 = undefined;
}

// Namespace zombie_diana_winged_tornado_attack
// Params 0, eflags: 0x4
// Checksum 0x81b762bb, Offset: 0x1bb7
// Size: 0x107
function private function_8fcd7b9af5e7db0()
{
    self endon( #"death" );
    self.owner endon( #"death" );
    flametornado = self;
    flametornado.destination = function_72eb7c7f40b0d612();
    flametornado thread function_5a2552a24a760745();
    flametornado thread function_af4ad618616bae1();
    flametornado thread function_82dd2efdfebdceb();
    flametornado thread function_a474d6fecc058b1d();
    
    while ( true )
    {
        function_817866302340a75();
        result = flametornado utility::waittill_any_timeout( 60, "seek_new_target", "reached_destination", "stuck_seeking_target" );
        
        if ( result == "reached_destination" || result == "seek_new_target" )
        {
            flametornado.destination = function_72eb7c7f40b0d612();
        }
        
        /#
            function_8a6daf5fd07c3b65();
            
            if ( result == "<dev string:x116>" || result == "<dev string:x12a>" )
            {
                flame_tornado_debug_print( "<dev string:x13a>" );
                continue;
            }
            
            if ( result == "<dev string:x155>" )
            {
                flame_tornado_debug_print( "<dev string:x16a>" );
            }
        #/
    }
}

// Namespace zombie_diana_winged_tornado_attack
// Params 0, eflags: 0x4
// Checksum 0x976bf351, Offset: 0x1cc6
// Size: 0x1b6
function private function_72eb7c7f40b0d612()
{
    var_d730cbdee7f394c2 = 10;
    flametornado = self;
    diana = flametornado.owner;
    
    if ( flametornado.var_1887aca4206260e6 && flametornado.var_abd905c22192cba8 )
    {
        return flametornado function_385ae2ffcafd7280( flametornado.var_abd905c22192cba8 );
    }
    
    if ( isalive( flametornado.seekingplayer ) && !flametornado.seekingplayer.var_f468cf5c9e75db1 )
    {
        return flametornado.seekingplayer.origin;
    }
    
    for ( i = 0; i < var_d730cbdee7f394c2 ; i++ )
    {
        var_65247e74fbc0419d = flametornado function_4aad082baf252738( diana.var_15b01419a0d56fdc.var_6ffdf2ceff7e2473, diana.tornadodamageradius + diana.var_522fe5be5b52b8df ) ? flametornado.origin : diana.var_15b01419a0d56fdc.var_6ffdf2ceff7e2473;
        randomnavpoint = getrandomnavpoint( var_65247e74fbc0419d, diana.var_15b01419a0d56fdc.anchorradius );
        
        if ( isdefined( randomnavpoint ) && !flametornado function_4aad082baf252738( randomnavpoint, diana.tornadodamageradius + diana.var_522fe5be5b52b8df ) )
        {
            return randomnavpoint;
        }
    }
    
    if ( !flametornado function_4aad082baf252738( diana.var_15b01419a0d56fdc.var_6ffdf2ceff7e2473, diana.tornadodamageradius + diana.var_522fe5be5b52b8df ) )
    {
        return flametornado.origin;
    }
}

// Namespace zombie_diana_winged_tornado_attack
// Params 2, eflags: 0x4
// Checksum 0x37ffc5b0, Offset: 0x1e85
// Size: 0xd0, Type: bool
function private function_4aad082baf252738( pos, var_f4d8d0c3f40d993c )
{
    foreach ( talisman in level.talisman_system.talismans )
    {
        if ( talisman.state == "active" && distancesquared( pos, talisman.scriptable.origin ) <= squared( var_f4d8d0c3f40d993c + 240 ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zombie_diana_winged_tornado_attack
// Params 0, eflags: 0xc
// Checksum 0x587832bd, Offset: 0x1f5e
// Size: 0x12b
function private function_6286715cb1353030()
{
    self notify( #"hash_807e9ba044a7ba2d" );
    self endon( #"hash_807e9ba044a7ba2d" );
    self endon( #"death" );
    self endon( #"hash_c2f97cd42822cf3d" );
    flametornado = self;
    diana = flametornado.owner;
    
    while ( true )
    {
        talisman = undefined;
        level waittill( #"hash_7748191fb2849b3b", talisman );
        
        if ( !talisman )
        {
            continue;
        }
        
        talismanorigin = talisman.scriptable.origin;
        
        if ( distance2dsquared( flametornado.origin, talismanorigin ) < squared( 240 ) || distance2dsquared( flametornado.anchorent.origin, talismanorigin ) < squared( 240 ) )
        {
            diana function_e8a0b1a5c4fae6e2( flametornado );
            return;
        }
        
        if ( isdefined( flametornado.destination ) && distance2dsquared( flametornado.destination, talismanorigin ) < squared( 240 ) )
        {
            flametornado function_385d5746703d4a6a();
            flametornado notify( #"seek_new_target" );
        }
    }
}

// Namespace zombie_diana_winged_tornado_attack
// Params 0, eflags: 0xc
// Checksum 0x2e785838, Offset: 0x2091
// Size: 0xd6
function private function_5a2552a24a760745()
{
    self notify( #"hash_46c75a7fa9ea34a2" );
    self endon( #"hash_46c75a7fa9ea34a2" );
    self endon( #"death" );
    flametornado = self;
    
    while ( true )
    {
        if ( isdefined( flametornado.destination ) && distancesquared( flametornado.origin, flametornado.destination ) < 400 )
        {
            flametornado notify( #"reached_destination" );
        }
        
        if ( isdefined( flametornado.anchorent ) && isdefined( flametornado.destination ) && distancesquared( flametornado.anchorent.origin, flametornado.destination ) < 400 )
        {
            flametornado notify( #"reached_destination" );
        }
        
        wait 0.5;
    }
}

// Namespace zombie_diana_winged_tornado_attack
// Params 0, eflags: 0xc
// Checksum 0x9e521456, Offset: 0x216f
// Size: 0x244
function private function_af4ad618616bae1()
{
    self notify( #"hash_4d6c9a352a398e7c" );
    self endon( #"hash_4d6c9a352a398e7c" );
    self endon( #"death" );
    flametornado = self;
    diana = self.owner;
    var_72abf532b2dda3a7 = getdvarint( @"hash_66c9934511430732", 100 );
    var_588879b2b78e2267 = getdvarint( @"hash_169fa59344eccdd4", 1000 );
    var_887093f10ed79140 = getdvarint( @"flame_tornado_enemy_time", 10000 );
    var_96c166b725f23d7f = getdvarint( @"hash_d0654444f6b31744", 5 );
    curtime = gettime();
    var_5dd94ba48e71295b = flametornado.origin;
    stucktime = curtime;
    var_88a2d2b6b154e2fb = curtime;
    var_2ba0b97e19df6a5d = 0;
    var_a318e640346aa041 = 0;
    
    while ( true )
    {
        var_2ba0b97e19df6a5d += distance( var_5dd94ba48e71295b, flametornado.origin );
        var_5dd94ba48e71295b = flametornado.anchorent.origin ?? flametornado.origin;
        curtime = gettime();
        
        if ( curtime > stucktime + var_588879b2b78e2267 )
        {
            stucktime = curtime;
            var_2ba0b97e19df6a5d = 0;
            var_a318e640346aa041++;
            
            if ( var_a318e640346aa041 > var_96c166b725f23d7f )
            {
                diana function_e8a0b1a5c4fae6e2( flametornado );
                return;
            }
            else
            {
                flametornado notify( #"stuck_seeking_target" );
            }
        }
        else if ( curtime > var_88a2d2b6b154e2fb + var_887093f10ed79140 )
        {
            diana function_e8a0b1a5c4fae6e2( flametornado );
            return;
        }
        
        if ( var_2ba0b97e19df6a5d > var_72abf532b2dda3a7 )
        {
            stucktime = curtime;
            var_2ba0b97e19df6a5d = 0;
            var_a318e640346aa041 = 0;
        }
        
        if ( isalive( flametornado.seekingplayer ) )
        {
            var_88a2d2b6b154e2fb = curtime;
            
            if ( distancesquared( flametornado.seekingplayer.origin, flametornado.origin ) < diana.var_a221500bc6423651 || isdefined( flametornado.anchorent ) && distancesquared( flametornado.seekingplayer.origin, flametornado.anchorent.origin ) < diana.var_a221500bc6423651 )
            {
                stucktime = curtime;
            }
        }
        
        wait 0.2;
    }
}

// Namespace zombie_diana_winged_tornado_attack
// Params 0, eflags: 0x4
// Checksum 0xfe993715, Offset: 0x23bb
// Size: 0x196
function private function_82dd2efdfebdceb()
{
    self endon( #"death" );
    self.owner endon( #"death" );
    var_7796b1817ac9fa60 = getdvarfloat( @"flame_tornado_rotation_speed", 3 );
    var_a7553f503eb8c176 = getdvarfloat( @"hash_f1856e062beacacd", 0.5 );
    flametornado = self;
    flametornado.orbitdist = flametornado.owner.var_522fe5be5b52b8df;
    flametornado.var_fc22d93af32b62b9 = rotatepointaroundvector( ( 0, 0, 1 ), ( flametornado.orbitdist, 0, 0 ), randomfloat( 360 ) );
    
    while ( true )
    {
        var_daa590b83d7e972 = length( flametornado.var_fc22d93af32b62b9 );
        
        if ( abs( var_daa590b83d7e972 - flametornado.orbitdist ) > var_a7553f503eb8c176 )
        {
            if ( flametornado.orbitdist <= 0 )
            {
                flametornado.var_fc22d93af32b62b9 = ( 0, 0, 0 );
            }
            else if ( var_daa590b83d7e972 > 0.01 )
            {
                flametornado.var_fc22d93af32b62b9 = vectornormalize( flametornado.var_fc22d93af32b62b9 ) * flametornado.orbitdist;
            }
            else
            {
                flametornado.var_fc22d93af32b62b9 = ( flametornado.orbitdist, 0, 0 );
            }
        }
        
        flametornado.var_fc22d93af32b62b9 = rotatepointaroundvector( ( 0, 0, 1 ), flametornado.var_fc22d93af32b62b9, var_7796b1817ac9fa60 );
        waitframe();
    }
}

// Namespace zombie_diana_winged_tornado_attack
// Params 0, eflags: 0xc
// Checksum 0x565bb0c5, Offset: 0x2559
// Size: 0x148
function private function_a474d6fecc058b1d()
{
    self notify( #"hash_ea5d1e28e50f60fc" );
    self endon( #"hash_ea5d1e28e50f60fc" );
    self endon( #"death" );
    flametornado = self;
    diana = self.owner;
    
    while ( true )
    {
        var_9eee70b7611aa079 = 0;
        
        foreach ( talisman in level.talisman_system.talismans )
        {
            if ( talisman.state == "active" && distance2dsquared( flametornado.origin, talisman.scriptable.origin ) < squared( diana.tornadodamageradius + 240 ) )
            {
                var_9eee70b7611aa079 = 1;
                break;
            }
        }
        
        flametornado.orbitdist = var_9eee70b7611aa079 ? 0 : diana.var_522fe5be5b52b8df;
        waitframe();
    }
}

// Namespace zombie_diana_winged_tornado_attack
// Params 0, eflags: 0x4
// Checksum 0xc5a0fc91, Offset: 0x26a9
// Size: 0x254
function private function_817866302340a75()
{
    flametornado = self;
    function_f1dacb7ed52e58fb();
    
    if ( flametornado.forceddestination )
    {
        flametornado.destination = flametornado.forceddestination;
    }
    
    if ( !isdefined( flametornado.destination ) )
    {
        return;
    }
    
    adjusteddestination = function_f0a5665d6c4c1d7d( flametornado.destination );
    
    /#
        function_6bedaf5c1ad1100f( adjusteddestination );
    #/
    
    disttodest = distance( flametornado.origin, adjusteddestination );
    pointspacing = disttodest < 500 ? disttodest / 10 : 50;
    
    if ( disttodest > 4000 )
    {
        adjusteddestination = flametornado.origin + vectornormalize( adjusteddestination - flametornado.origin ) * 4000 * 0.5;
    }
    
    if ( !isdefined( flametornado.anchorent ) )
    {
        flametornado.anchorent = flametornado utility::spawn_tag_origin();
    }
    
    splinepoints = flametornado.anchorent findsplinepath( getclosestpointonnavmesh( flametornado.anchorent.origin ), getclosestpointonnavmesh( adjusteddestination ), 200, 200, pointspacing, anglestoforward( flametornado.anchorent.angles ), ( 0, 0, 0 ), 100, 0.25, 0, "small_veh_jump", undefined, 0, 2 );
    
    if ( !splinepoints || splinepoints.size <= 2 )
    {
        return;
    }
    
    if ( splinepoints.size >= 48 )
    {
        splinepoints = utility::array_slice( splinepoints, 0, 47 );
    }
    
    splinepoints[ splinepoints.size - 1 ] = undefined;
    var_dcfed6d41060c405 = function_43f8b1e8138fb1d4( splinepoints, flametornado.speed );
    
    if ( var_dcfed6d41060c405 )
    {
        flametornado.anchorent notify( #"stop_curve" );
        flametornado.anchorent thread utility::function_2159dd4196ff4b81( splinepoints, var_dcfed6d41060c405, 1, 1, 1, 0.5, 0.5, getdvarint( @"flame_tornado_debug" ) );
        
        if ( !flametornado.isorbiting )
        {
            flametornado.isorbiting = 1;
            flametornado thread function_bef77f900cac0334( flametornado.anchorent );
        }
        
        flametornado.destination = splinepoints[ splinepoints.size - 1 ];
    }
}

// Namespace zombie_diana_winged_tornado_attack
// Params 1, eflags: 0x4
// Checksum 0xb0041d75, Offset: 0x2905
// Size: 0x66
function private function_bef77f900cac0334( anchorent )
{
    self endon( #"death" );
    flametornado = self;
    
    while ( true )
    {
        if ( isdefined( anchorent ) && isdefined( flametornado.var_fc22d93af32b62b9 ) )
        {
            flametornado.origin = anchorent.origin + flametornado.var_fc22d93af32b62b9;
        }
        
        waitframe();
    }
}

// Namespace zombie_diana_winged_tornado_attack
// Params 0, eflags: 0x4
// Checksum 0x548e8654, Offset: 0x2973
// Size: 0xed
function private function_f1dacb7ed52e58fb()
{
    flametornado = self;
    diana = self.owner;
    
    if ( !isalive( flametornado.seekingplayer ) )
    {
        flametornado.speed = flametornado.basespeed;
        return;
    }
    
    var_af9ead3948ec52f0 = distance( flametornado.origin, flametornado.seekingplayer.origin );
    speedmult = math::remap( clamp( var_af9ead3948ec52f0, diana.var_ce6e5d33ab5ea76a, diana.var_ef2f055a632af5b4 ), diana.var_ce6e5d33ab5ea76a, diana.var_ef2f055a632af5b4, diana.var_ea022a0944ad3fcc, diana.var_adca1a32a7df5d82 );
    flametornado.speed = flametornado.basespeed * speedmult;
}

// Namespace zombie_diana_winged_tornado_attack
// Params 1, eflags: 0x4
// Checksum 0x66772986, Offset: 0x2a68
// Size: 0x1ce
function private function_f0a5665d6c4c1d7d( destination )
{
    var_8865056b23df3cb3 = 0.3;
    var_9210fe7c265ddec0 = 50;
    flametornado = self;
    diana = self.owner;
    
    if ( flametornado.offsetdirection == 2 )
    {
        return destination;
    }
    
    disttotarget = distance( flametornado.origin, destination );
    
    if ( disttotarget <= diana.var_707c906407d968a4 )
    {
        return destination;
    }
    
    offsetscale = math::remap( clamp( disttotarget, diana.var_707c906407d968a4, diana.var_10c97cdb05c79ce1 ), diana.var_707c906407d968a4, diana.var_10c97cdb05c79ce1, 0, 1 );
    dirtotarget = vectornormalize( destination - flametornado.origin );
    var_6c85a309ebde60f9 = vectorcross( dirtotarget, ( 0, 0, 1 ) );
    offsetamount = diana.var_c4bd7e49583497f4 * offsetscale;
    
    if ( flametornado.offsetdirection == 0 )
    {
        offsetamount *= -1;
    }
    
    if ( !var_6c85a309ebde60f9 || !offsetamount )
    {
        return destination;
    }
    
    newdestination = destination + var_6c85a309ebde60f9 * offsetamount;
    navtraceresult = navtrace( flametornado.origin, newdestination, undefined, 1 );
    
    if ( navtraceresult[ "fraction" ] < 1 )
    {
        if ( navtraceresult[ "fraction" ] > var_8865056b23df3cb3 )
        {
            newdestination = navtraceresult[ "position" ] - var_6c85a309ebde60f9 * var_9210fe7c265ddec0;
        }
        else
        {
            return destination;
        }
    }
    
    navpoint = utility::drop_to_ground( getclosestpointonnavmesh( newdestination, flametornado.origin ) );
    return navpoint ?? destination;
}

// Namespace zombie_diana_winged_tornado_attack
// Params 2, eflags: 0x4
// Checksum 0x24b1efa6, Offset: 0x2c3f
// Size: 0x6b
function private function_43f8b1e8138fb1d4( splinepoints, speed )
{
    if ( splinepoints.size < 2 )
    {
        return 0;
    }
    
    time = 0;
    
    for ( i = 0; i < splinepoints.size - 1 ; i++ )
    {
        time += max( distance( splinepoints[ i ], splinepoints[ i + 1 ] ) / speed, 0.05 );
    }
    
    return time;
}

// Namespace zombie_diana_winged_tornado_attack
// Params 0, eflags: 0x4
// Checksum 0xa053fca8, Offset: 0x2cb3
// Size: 0x4a1
function private function_3b166c3580f9c68a()
{
    self endon( #"death" );
    self endon( #"hash_c2f97cd42822cf3d" );
    flametornado = self;
    diana = self.owner;
    damagestarttime = [];
    var_2aee8bcbeff7f5c2 = diana.var_360dda343f526300;
    warningradius = diana.var_dd99906788c15b95;
    
    while ( true )
    {
        wait 1;
        
        foreach ( player in level.players )
        {
            if ( player.var_f71c86cc6fcf9cd == self )
            {
                if ( distance2dsquared( flametornado.origin, player.origin ) >= diana.var_982244ebf9619479 )
                {
                    var_f11557bc9c349a62 = 0;
                    
                    foreach ( var_3d7d741ae4f95330 in diana.var_2d19329c64eab014 )
                    {
                        if ( isdefined( var_3d7d741ae4f95330 ) && var_3d7d741ae4f95330 != self )
                        {
                            if ( distance2dsquared( var_3d7d741ae4f95330.origin, player.origin ) < diana.var_982244ebf9619479 )
                            {
                                var_f11557bc9c349a62 = 1;
                                break;
                            }
                        }
                    }
                    
                    if ( !var_f11557bc9c349a62 )
                    {
                        flametornado function_bbf665e055741600( player, "off" );
                    }
                    
                    player.var_f71c86cc6fcf9cd = undefined;
                    
                    if ( player.var_754003c0046ec31b == self )
                    {
                        player.var_754003c0046ec31b = undefined;
                    }
                    
                    damagestarttime[ player getentitynumber() ] = undefined;
                }
            }
        }
        
        var_5d15b8101cf0a2de = getplayersinradius( flametornado.origin, warningradius );
        
        foreach ( var_b69923574b3576d1 in var_5d15b8101cf0a2de )
        {
            if ( !isalive( var_b69923574b3576d1 ) || var_b69923574b3576d1.inlaststand || !var_b69923574b3576d1 val::get( "damage" ) )
            {
                continue;
            }
            
            if ( flametornado function_45616b11354d9804( var_b69923574b3576d1 ) )
            {
                flametornado function_bbf665e055741600( var_b69923574b3576d1, "damage" );
                var_b69923574b3576d1.var_f71c86cc6fcf9cd = self;
                entitynum = var_b69923574b3576d1 getentitynumber();
                shoulddamage = !isdefined( damagestarttime[ entitynum ] ) || utility::time_has_passed( damagestarttime[ entitynum ], var_2aee8bcbeff7f5c2 );
                
                if ( ( !isdefined( var_b69923574b3576d1.var_754003c0046ec31b ) || var_b69923574b3576d1.var_754003c0046ec31b == self ) && shoulddamage )
                {
                    var_b69923574b3576d1.var_754003c0046ec31b = self;
                    
                    if ( !isdefined( damagestarttime[ entitynum ] ) )
                    {
                        damagestarttime[ entitynum ] = gettime();
                    }
                    
                    damage = flametornado function_759fe0ba1b51378c( damagestarttime[ entitynum ] );
                    var_925aac12b2c9ae62 = diana.var_a5a4e39aeb96e4ad;
                    diana.var_a5a4e39aeb96e4ad = ( var_925aac12b2c9ae62 ?? 1 ) * diana.var_a5a4e39aeb96e4ad;
                    var_b69923574b3576d1 dodamage( damage, flametornado.origin, diana, flametornado, "MOD_ELEMENTAL_FIRE" );
                    diana.var_a5a4e39aeb96e4ad = var_925aac12b2c9ae62;
                    level callback::callback( "on_hornet_boss_tornado_damage_vo", { #player:var_b69923574b3576d1 } );
                    
                    if ( !var_b69923574b3576d1.var_fdd36d6374b9f823 )
                    {
                        var_b69923574b3576d1 shellshock_utility::_shellshock( %"hash_3e853b61f7d7058a", #"damage", 1.5 );
                        var_b69923574b3576d1 function_458830bd71386a04( diana, flametornado.origin, diana.var_98715bf756ba6514, diana.var_e82e63f50a607637 );
                        flametornado notify( #"hash_558593d6b115229b", var_b69923574b3576d1 );
                    }
                }
                
                continue;
            }
            
            flametornado function_bbf665e055741600( var_b69923574b3576d1, "warn" );
            var_b69923574b3576d1.var_f71c86cc6fcf9cd = self;
            
            if ( var_b69923574b3576d1.var_754003c0046ec31b == self )
            {
                var_b69923574b3576d1.var_754003c0046ec31b = undefined;
            }
            
            damagestarttime[ var_b69923574b3576d1 getentitynumber() ] = undefined;
        }
    }
}

// Namespace zombie_diana_winged_tornado_attack
// Params 2, eflags: 0x4
// Checksum 0x12d5ffe3, Offset: 0x315c
// Size: 0x44
function private function_bbf665e055741600( player, state )
{
    if ( player.var_a5f922ce61fbfb77 != state )
    {
        player.var_a5f922ce61fbfb77 = state;
        player utility::function_7c10ea82c1e305b8( "flame_tornado", state );
    }
}

// Namespace zombie_diana_winged_tornado_attack
// Params 1, eflags: 0x4
// Checksum 0x7a47afe6, Offset: 0x31a8
// Size: 0x8c, Type: bool
function private function_45616b11354d9804( player )
{
    flametornado = self;
    diana = self.owner;
    
    if ( distance2dsquared( flametornado.origin, player.origin ) >= diana.var_5f9cdcd6bbc3841c )
    {
        return false;
    }
    
    heightdiff = player.origin[ 2 ] - flametornado.origin[ 2 ];
    return heightdiff < diana.var_e6a8c182f0e6901d;
}

// Namespace zombie_diana_winged_tornado_attack
// Params 1, eflags: 0x4
// Checksum 0x722868d7, Offset: 0x323d
// Size: 0x75
function private function_759fe0ba1b51378c( starttime )
{
    diana = self.owner;
    basedamage = diana.var_425c09d6e8bf4c43;
    var_b74178279ac39879 = ( gettime() - starttime ) / 1000;
    
    if ( var_b74178279ac39879 <= diana.var_988e1bfb776e699b )
    {
        return basedamage;
    }
    
    return basedamage * self.owner.var_d9037c74882a3b18;
}

// Namespace zombie_diana_winged_tornado_attack
// Params 4, eflags: 0x4
// Checksum 0x21f9fb9a, Offset: 0x32bb
// Size: 0xce
function private function_458830bd71386a04( diana, tornadoorigin, var_2a9889351e7486b5, var_e5070b52534334ac )
{
    var_47034541e404cfc2 = vectornormalize2( self.origin - tornadoorigin );
    
    if ( length( var_47034541e404cfc2 ) == 0 )
    {
        var_47034541e404cfc2 = vectornormalize2( self.origin - diana.origin );
    }
    
    var_103add71c72eba2f = vectorcross( var_47034541e404cfc2, ( 0, 0, 1 ) );
    var_2a9889351e7486b5 = getdvarfloat( @"hash_21bfc2f5f654ff20", var_2a9889351e7486b5 );
    var_e5070b52534334ac = getdvarfloat( @"hash_63a5c8451997935d", var_e5070b52534334ac );
    impactvector = rotatepointaroundvector( var_103add71c72eba2f, var_47034541e404cfc2, var_2a9889351e7486b5 );
    self knockback( impactvector, var_e5070b52534334ac, 1 );
    thread function_fd8e17b0f00a4575( diana );
}

// Namespace zombie_diana_winged_tornado_attack
// Params 1, eflags: 0x4
// Checksum 0x802b8ead, Offset: 0x3391
// Size: 0x86
function private function_fd8e17b0f00a4575( diana )
{
    self endon( #"death" );
    var_f07ec2e26d68259f = 0.3;
    var_32122529ed44c380 = 1.5;
    self.var_fdd36d6374b9f823 = 1;
    wait var_f07ec2e26d68259f;
    
    if ( isalive( self ) )
    {
        while ( !self isonground() )
        {
            waitframe();
        }
    }
    
    if ( isalive( diana ) )
    {
        diana notify( #"stop_current_movement_prediction" );
    }
    
    if ( isalive( self ) )
    {
        wait var_32122529ed44c380;
    }
    
    self.var_fdd36d6374b9f823 = undefined;
}

// Namespace zombie_diana_winged_tornado_attack
// Params 0, eflags: 0x4
// Checksum 0xad7a0e1, Offset: 0x341f
// Size: 0x44
function private flame_tornado_watch_timeout()
{
    self endon( #"death" );
    flametornado = self;
    diana = self.owner;
    wait diana.var_f8e129e8b7f6ba01;
    diana function_e8a0b1a5c4fae6e2( flametornado );
}

// Namespace zombie_diana_winged_tornado_attack
// Params 0, eflags: 0xc
// Checksum 0x9b6086f2, Offset: 0x346b
// Size: 0xbe
function private function_e6cc75409d57e9a0()
{
    self notify( #"hash_eb80c0b9b3586a8c" );
    self endon( #"hash_eb80c0b9b3586a8c" );
    self endon( #"death" );
    self endon( #"hash_c2f97cd42822cf3d" );
    flametornado = self;
    
    while ( true )
    {
        flametornado waittill( #"hash_558593d6b115229b", hitplayer );
        
        if ( flametornado.var_1887aca4206260e6 )
        {
            continue;
        }
        
        flametornado.var_1887aca4206260e6 = 1;
        flametornado.var_abd905c22192cba8 = hitplayer;
        flametornado function_385d5746703d4a6a();
        flametornado notify( #"seek_new_target" );
        wait 5;
        flametornado.var_1887aca4206260e6 = undefined;
        flametornado.var_abd905c22192cba8 = undefined;
    }
}

// Namespace zombie_diana_winged_tornado_attack
// Params 1, eflags: 0x4
// Checksum 0xb7c7efc3, Offset: 0x3531
// Size: 0x268
function private function_385ae2ffcafd7280( hitplayer )
{
    var_6a5083523ffc3e81 = 10;
    flametornado = self;
    diana = flametornado.owner;
    var_c7c7f21154747ad5 = squared( diana.var_e54cb8ede5cf2011 );
    
    for ( i = 0; i < var_6a5083523ffc3e81 ; i++ )
    {
        var_65247e74fbc0419d = diana.var_15b01419a0d56fdc.var_6ffdf2ceff7e2473;
        randomnavpoint = getrandomnavpoint( var_65247e74fbc0419d, diana.var_15b01419a0d56fdc.anchorradius );
        
        if ( !randomnavpoint )
        {
            continue;
        }
        
        var_76fb29413aefbab4 = 1;
        
        foreach ( player in level.players )
        {
            if ( isalive( player ) && distancesquared( randomnavpoint, player.origin ) < var_c7c7f21154747ad5 )
            {
                var_76fb29413aefbab4 = 0;
                break;
            }
        }
        
        if ( var_76fb29413aefbab4 && !flametornado function_4aad082baf252738( randomnavpoint, diana.tornadodamageradius + diana.var_522fe5be5b52b8df ) )
        {
            return randomnavpoint;
        }
    }
    
    if ( isdefined( hitplayer ) )
    {
        var_f0f4cc97d1d28b1d = vectornormalize2( flametornado.origin - hitplayer.origin );
        
        if ( length( var_f0f4cc97d1d28b1d ) < 0.01 )
        {
            randomangle = randomfloat( 360 );
            var_f0f4cc97d1d28b1d = ( cos( randomangle ), sin( randomangle ), 0 );
        }
        
        var_191f0bfb1ba7af49 = flametornado.origin + var_f0f4cc97d1d28b1d * diana.var_e54cb8ede5cf2011;
        navpoint = utility::drop_to_ground( getclosestpointonnavmesh( var_191f0bfb1ba7af49, flametornado.origin ) );
        
        if ( navpoint && !flametornado function_4aad082baf252738( navpoint, diana.tornadodamageradius + diana.var_522fe5be5b52b8df ) )
        {
            return navpoint;
        }
    }
    
    return diana.var_15b01419a0d56fdc.var_6ffdf2ceff7e2473;
}

// Namespace zombie_diana_winged_tornado_attack
// Params 2
// Checksum 0xb4d4cf28, Offset: 0x37a2
// Size: 0x2d, Type: bool
function function_6f9caac5837a4d5d( taskid, params )
{
    return self.bossfightphase >= ( self.var_8c04f7c1944e758 ?? 2 );
}

// Namespace zombie_diana_winged_tornado_attack
// Params 2
// Checksum 0xf10501ea, Offset: 0x37d8
// Size: 0x61
function function_1cb2023a9be7540f( taskid, params )
{
    var_4179dcbac8fecb02 = gettime() - ( self.var_6a8cf624c493c50b ?? 0 );
    cooldownscore = clamp( math::remap( var_4179dcbac8fecb02, 0, utility::function_4b74c15943231980( self.var_9596e7e00a4fa254 ), 0, 1 ), 0, 1 );
    return cooldownscore;
}

// Namespace zombie_diana_winged_tornado_attack
// Params 2
// Checksum 0x9c9e9137, Offset: 0x3842
// Size: 0xbf
function function_ed516f5f939ae3b3( taskid, params )
{
    var_401071f96cde8f51 = 0;
    
    foreach ( var_2bdea747682d42f1 in self.var_f9e48b7ff2c39654 )
    {
        if ( var_2bdea747682d42f1 == "winged_torando_attack" )
        {
            var_401071f96cde8f51++;
        }
    }
    
    var_9a48b1aac439ed1d = clamp( math::remap( var_401071f96cde8f51, 3, 0, 0, 1 ), 0, 1 );
    return var_9a48b1aac439ed1d;
}

/#

    // Namespace zombie_diana_winged_tornado_attack
    // Params 0
    // Checksum 0x3811ecfc, Offset: 0x390a
    // Size: 0x2e, Type: dev
    function winged_tornado_attack_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x17c>" );
        devgui::add_devgui_func( "<dev string:x193>", "<dev string:x1ac>", &do_winged_tornado_attack );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_diana_winged_tornado_attack
    // Params 1
    // Checksum 0x1ae66e24, Offset: 0x3940
    // Size: 0x4f, Type: dev
    function do_winged_tornado_attack( params )
    {
        diana = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x1c5>" );
        
        if ( isdefined( diana ) )
        {
            diana notify( #"winged_tornado_attack_start" );
        }
    }

    // Namespace zombie_diana_winged_tornado_attack
    // Params 1, eflags: 0x4
    // Checksum 0xff12b068, Offset: 0x3997
    // Size: 0x32, Type: dev
    function private flame_tornado_debug_print( message )
    {
        if ( getdvarint( @"flame_tornado_debug" ) )
        {
            iprintln( self getentitynumber() + "<dev string:x1d2>" + message );
        }
    }

    // Namespace zombie_diana_winged_tornado_attack
    // Params 0, eflags: 0x4
    // Checksum 0x1964736a, Offset: 0x39d1
    // Size: 0x43, Type: dev
    function private function_8a6daf5fd07c3b65()
    {
        if ( getdvarint( @"flame_tornado_debug" ) && isdefined( self.destination ) )
        {
            sphere( self.destination, 10, ( 1, 0, 0 ), 0, 30 );
        }
    }

    // Namespace zombie_diana_winged_tornado_attack
    // Params 1, eflags: 0x4
    // Checksum 0xfad14482, Offset: 0x3a1c
    // Size: 0xf0, Type: dev
    function private function_6bedaf5c1ad1100f( adjusteddest )
    {
        if ( !getdvarint( @"flame_tornado_debug" ) )
        {
            return;
        }
        
        line( self.origin, adjusteddest, ( 1, 1, 0 ), 1, 30 );
        
        switch ( self.offsetdirection )
        {
            case 0:
                color = ( 1, 0, 0 );
                break;
            case 1:
                color = ( 0, 1, 0 );
                break;
            default:
                color = ( 0, 0, 1 );
                break;
        }
        
        sphere( adjusteddest, 30, color, 1 );
        
        if ( isdefined( self.destination ) )
        {
            sphere( self.destination, 20, ( 1, 1, 1 ), 1 );
        }
    }

#/
