// scripts\mp\zm\ztron\ztron_player_utility.gsc  (hash_5151aa1c43d055dc.gscc) (size: 31589 Bytes / 0x7b65 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcac4f670 (3401905776)
// size ...... 31589 (0x7b65)
// includes .. 36  (offset: 0x761d)
// strings ... 66  (offset: 0x773d)
// dev strs .. 15  (offset: 0x7aa5)
// exports ... 93  (offset: 0x4d8d)
// cseg ...... 0x550 + 0x483d (0x4d8d)
// imports ... 215 (offset: 0x5c15)
// animtree1 . 0   (offset: 0x7b65)
// animtree2 . 0   (offset: 0x7b65)
#using script_31ee2a173f3499b7;
#using script_3aa63d236f429fc3;
#using script_3b32e3e71e24c738;
#using script_5441a11286579ddc;
#using script_54a05cbb2455bc6f;
#using script_75994df35243cb2a;
#using scripts\common\ae_utility;
#using scripts\common\damage_effects;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\cash;
#using scripts\mp\common\perks\perkpackage;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\stats;
#using scripts\mp\equipment;
#using scripts\mp\gametypes\common;
#using scripts\mp\supers;
#using scripts\mp\weapons;
#using scripts\mp\zm\ztron\ztron_camera;
#using scripts\mp\zm\ztron\ztron_debug;
#using scripts\mp\zm\ztron\ztron_enemy;
#using scripts\mp\zm\ztron\ztron_enemy_ai;
#using scripts\mp\zm\ztron\ztron_gobblegums;
#using scripts\mp\zm\ztron\ztron_health_bar;
#using scripts\mp\zm\ztron\ztron_laststand;
#using scripts\mp\zm\ztron\ztron_main;
#using scripts\mp\zm\ztron\ztron_meta_progression;
#using scripts\mp\zm\ztron\ztron_score;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;
#using scripts\mp\zm\ztron\ztron_vfx;
#using scripts\mp\zm\ztron\ztron_weapon;
#using scripts\mp\zm\ztron\ztron_weather;

#namespace ztron_player_utility;

// Namespace ztron_player_utility
// Params 0
// Checksum 0xe900d8d4, Offset: 0x56e
// Size: 0xec
function playercreate()
{
    profilestart();
    
    if ( !isdefined( self.ztron ) )
    {
        self.ztron = spawnstruct();
    }
    
    self.ztron.color = function_e3c7f85ade5940a2( self );
    self.ztron.colorrgb = function_79922197e4989887();
    self.ztron.pickupupdate = 0;
    self.ztron.var_b6f09fd8df4d1bb = [];
    
    if ( !isdefined( self.ztron.var_8a4455464a940cd9 ) )
    {
        self.ztron.var_8a4455464a940cd9 = 1;
    }
    
    playerinitialize( 1 );
    ztron_debug::debugmsg( "Player(" + self.ztron.color + ") created." );
    thread function_1ade1607bdd74a7f();
    thread function_44eb94ac07970fee();
    thread ztron_weapon::preloadweapons();
    profilestop();
}

// Namespace ztron_player_utility
// Params 0
// Checksum 0xecc872a3, Offset: 0x662
// Size: 0x9f
function function_79922197e4989887()
{
    switch ( self.ztron.color )
    {
        case #"hash_883ff07272b4f9c":
            return ( 0, 1, 0 );
        case #"hash_778bb52ecd08072d":
            return ( 0, 0, 1 );
        case #"hash_97430f6c58e61cbc":
            return ( 1, 0, 0 );
        case #"hash_2ac407c1cd5943a9":
            return ( 1, 1, 0 );
        default:
            return ( 0, 1, 0 );
    }
}

// Namespace ztron_player_utility
// Params 1
// Checksum 0x3f2b274c, Offset: 0x709
// Size: 0x33
function function_55e798aacb02a82f( origin )
{
    sortedplayers = sortbydistance( level.players, origin );
    
    if ( sortedplayers.size == 0 )
    {
        return;
    }
    
    return sortedplayers[ 0 ];
}

// Namespace ztron_player_utility
// Params 1
// Checksum 0x1bb10157, Offset: 0x745
// Size: 0xc4
function function_6c0182e951281eab( origin )
{
    alive_players = [];
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) && !player.inlaststand )
        {
            alive_players[ alive_players.size ] = player;
        }
    }
    
    sortedplayers = sortbydistance( alive_players, origin );
    
    if ( sortedplayers.size == 0 )
    {
        return;
    }
    
    return sortedplayers[ 0 ];
}

// Namespace ztron_player_utility
// Params 0
// Checksum 0x8ddd5bfa, Offset: 0x812
// Size: 0xac
function function_1ade1607bdd74a7f()
{
    self notify( #"hash_f5a3a024f273c65c" );
    self endon( #"hash_f5a3a024f273c65c" );
    self endon( #"disconnect" );
    level endon( #"ztron_game_is_over" );
    
    while ( true )
    {
        self waittill( #"vehicle_enter", vehicle );
        
        if ( !vehicle.forcefp )
        {
            continue;
        }
        
        ztron_camera::function_4cb0fb44c3e8f6ed( -1, 1, 0 );
        self waittill( #"vehicle_exit" );
        
        if ( self.ztron.var_a4c2f70bbc713f98 )
        {
            self notify( #"ztron_playerdumpfps", { #clearforced:1 } );
        }
    }
}

// Namespace ztron_player_utility
// Params 0
// Checksum 0xeae38710, Offset: 0x8c6
// Size: 0x11f
function resetplayerstate()
{
    self.ztron.var_c5c31e76e1c42198 = "";
    self.ztron.weaponLevel = 0;
    self.ztron.weaponincrement = 0;
    self.ztron.var_dcf9ab22b803b383 = 0;
    self.ztron.var_6fe8ea86c8758aec = 0;
    ztron_ui::function_38a72e402dc87ace();
    self.ztron.var_8487be91b45f17c5 = undefined;
    self.ztron.var_ee12821b601e753a = level.var_5ac542875a6578d7 ? self.ztron.var_ee12821b601e753a : undefined;
    self.ztron.var_ccae92f84b4e34b2 = 0;
    self.ztron.var_ab917cce8153980e = 0;
    
    if ( ztron_fate::hasfate( 1 ) )
    {
        self.ztron.var_ab917cce8153980e += 1;
    }
}

// Namespace ztron_player_utility
// Params 0
// Checksum 0xc230cfb2, Offset: 0x9ed
// Size: 0x64
function function_37e3b28a6a000dda()
{
    self notify( #"hash_2d7c7a048e3e2297" );
    self endon( #"hash_2d7c7a048e3e2297" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        level waittill( #"enter_vehicle", vehicle, player );
        
        if ( player == self )
        {
            self notify( #"enter_vehicle" );
        }
    }
}

// Namespace ztron_player_utility
// Params 0
// Checksum 0x9e47dac7, Offset: 0xa59
// Size: 0x64
function function_fad5d5ac4a2fa7ec()
{
    self notify( #"hash_b09ba81ab23cd5b1" );
    self endon( #"hash_b09ba81ab23cd5b1" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        level waittill( #"exit_vehicle", vehicle, player );
        
        if ( player == self )
        {
            self notify( #"exit_vehicle" );
        }
    }
}

// Namespace ztron_player_utility
// Params 1
// Checksum 0x34bdf6ab, Offset: 0xac5
// Size: 0x552
function playerinitialize( fullinit = 0 )
{
    profilestart();
    
    if ( fullinit )
    {
        if ( level.ztron.metaenabled )
        {
            namespace_4f98d1d7dc3196d::initmeta();
            ztron_ui::function_e4c6bb291268e9d5();
        }
        
        self.ztron.initialized = 1;
        self.ztron.dead = 0;
        player::_setsuit( "sat_defaultsuit_ztron" );
        utility::function_7c10ea82c1e305b8( "ztron_player_trail_fx", self.ztron.color );
        utility::function_7c10ea82c1e305b8( "ztron_player_heads_up", "off" );
        ztron_score::initplayer();
        ztron_fate::function_a0f4e201932db40e();
        ztron_camera::function_79d64be315aa51c9( level.ztron.defaultcameramode );
        val::set( "ztron", "weapon_switch", 0 );
        perk::giveperk( "specialty_quickswap" );
        ztron_camera::flipTopdownCamera( level.ztron.arenaCamFlip );
        self.ztron.default_weapon_bundle = %"hash_28daa78760241031";
        self.ztron.healthRegenScale = 1;
        function_2c9ea3b797f22c77( getdvarfloat( @"hash_b84c9488d420c7d3", 1 ) );
        self.armorhealth = 0;
        self.ztron.checkpoint = spawnstruct();
        self.ztron.checkpoint.valid = 0;
        self.ztron.checkpoint.origin = ( 0, 0, 0 );
        self.ztron.default_ammo_mod = undefined;
        self.var_5812f44cd938ce65 = 0;
        self.ztron.var_4095e0b1332ea87 = 0;
        self.ztron.var_6fe8ea86c8758aec = 0;
        self.ztron.lifedonatecooldown = 0;
        self.var_d9f82b082e1118d3 = 0;
        self.ztron.var_a2dfad0f9eaffed3 = 0;
        self.ztron.var_1d3f9f191add52a8 = 0;
        self.ztron.penaltycooldown = 0;
        self.ztron.upgradeMask = 0;
        self.ztron.localitems = [];
        self.ztron.store_reroll_tokens = 3;
        ztron_score::function_1274c7ff344280d8();
        thread ztron_score::function_7cefb98972a39f08();
        self.ztron.var_eeeeba1fb45eb3ce = 1;
        ztron_enemy_ai::function_9be045fd327cab44();
        thread function_ee455a0fc54e29fb();
        thread ztron_health_bar::function_e3d2dc1ba03e14e3();
        thread ztron_health_bar::function_1ebb7cfeb9967ff6();
        thread function_a6bd4d3b32a06a5f();
        
        if ( !isdefined( self.ztron.shieldtrigger ) )
        {
            self.ztron.shieldtrigger = spawn( "trigger_radius", self.origin, 1, 60, 72 );
            self.ztron.shieldtrigger.activetime = 0;
            self.ztron.shieldtrigger thread ztron_util::function_1544885c712921f8( self );
            self.ztron.shieldtrigger thread ztron_util::function_36239518d8da65f0( level, "game_reset" );
            self.ztron.shieldtrigger thread ztron_util::function_36239518d8da65f0( level, "ztron_game_is_over" );
            self.ztron.shieldtrigger.targetname = "turnPlayerShieldOn";
            self.ztron.shieldtrigger enablelinkto();
            self.ztron.shieldtrigger linkto( self );
            self.ztron.shieldtrigger thread shield_trigger_think( self );
        }
        
        if ( level.ztron.blitzmode )
        {
            self.ztron.blitzmode = spawnstruct();
            self.ztron.blitzmode.timepiecescollected = 0;
            self.ztron.blitzmode.var_9e1b039eb653064f = 0;
            self.ztron.blitzmode.var_bb5d405632cf9df8 = 0;
            self.ztron.blitzmode.var_c1602c8627eaecf8 = 0;
            self.ztron.blitzmode.var_f46ce1edc06a1312 = 0;
        }
        
        thread ztron_weather::function_71715e0f568a17c();
        thread function_af4808ad87d6d3a();
        thread function_37e3b28a6a000dda();
        thread function_fad5d5ac4a2fa7ec();
        thread function_e16c5064f5621594();
    }
    
    thread ztron_gobblegums::function_8571318e6b50e284( fullinit );
    resetplayerstate();
    ztron_weapon::takeweaponpack();
    self.ztron.var_7edbd86a0f44be7b = 0;
    self.ztron.var_90b71b483dd76492 = 0;
    function_206220818cd503b8();
    function_7f458cb3544acb6b();
    profilestop();
}

// Namespace ztron_player_utility
// Params 0, eflags: 0x4
// Checksum 0xe0f421fc, Offset: 0x101f
// Size: 0x48
function private function_206220818cd503b8()
{
    self.ztron.respawnduration = 0;
    self.ztron.respawnprogress = 0;
    self.ztron.respawnmedics = 0;
    ztron_laststand::function_51e4dcf6ec6aaf61();
}

// Namespace ztron_player_utility
// Params 1
// Checksum 0xcd93caee, Offset: 0x106f
// Size: 0x36
function function_2c9ea3b797f22c77( speedscale )
{
    self.movespeedscaler = speedscale;
    common::function_a0f5c85d465c5f0a( "moveSpeedScaler", self.movespeedscaler - 1 );
    weapons::updatemovespeedscale();
}

// Namespace ztron_player_utility
// Params 0
// Checksum 0xe2b8c0ba, Offset: 0x10ad
// Size: 0x138
function function_7f458cb3544acb6b()
{
    if ( !( getdvarint( @"hash_855920521a29a8de", 0 ) == 1 ) )
    {
        return;
    }
    
    baserate = 1;
    
    if ( ztron_fate::hasfate( 6 ) )
    {
        baserate = 2.5;
    }
    
    self.ztron.healthRegenScale = baserate * ( 1 + 0.1 * namespace_4f98d1d7dc3196d::function_996793ae2b9b6a3c( self, "secondWind" ) );
    var_d192b31513fe1e14 = 1 + 0.07 * namespace_4f98d1d7dc3196d::function_996793ae2b9b6a3c( self, "fleetFeet" );
    
    if ( self.movespeedscaler < var_d192b31513fe1e14 )
    {
        function_2c9ea3b797f22c77( var_d192b31513fe1e14 );
    }
    
    basehealth = 150;
    var_7a0d2800aca3a50a = int( basehealth * ( 1 + 0.15 * namespace_4f98d1d7dc3196d::function_996793ae2b9b6a3c( self, "thickSkin" ) ) );
    
    if ( var_7a0d2800aca3a50a != self.maxhealth )
    {
        healthratio = self.health / self.maxhealth;
        self.maxhealth = var_7a0d2800aca3a50a;
        self.health = int( var_7a0d2800aca3a50a * healthratio );
        
        if ( self.health < 1 )
        {
            self.health = 1;
        }
    }
}

// Namespace ztron_player_utility
// Params 0
// Checksum 0xb8646171, Offset: 0x11ed
// Size: 0x54
function function_2ce403b2be5072e9()
{
    lethalequipment = self.equipment[ "primary" ];
    tacticalequipment = self.equipment[ "secondary" ];
    
    if ( lethalequipment )
    {
        equipment_mp::setequipmentammo( lethalequipment, 0 );
    }
    
    if ( tacticalequipment )
    {
        equipment_mp::setequipmentammo( tacticalequipment, 0 );
    }
}

// Namespace ztron_player_utility
// Params 1
// Checksum 0xecd89016, Offset: 0x1249
// Size: 0xac
function function_1bb9b2e327c29632( player )
{
    profilestart();
    
    if ( isdefined( player ) )
    {
        player.health = player.maxhealth;
        profilestop();
        return;
    }
    
    foreach ( player in level.players )
    {
        player.health = player.maxhealth;
    }
    
    profilestop();
}

// Namespace ztron_player_utility
// Params 0
// Checksum 0x9674962c, Offset: 0x12fd
// Size: 0x168
function function_44eb94ac07970fee()
{
    self notify( #"hash_f432da1df24ded2b" );
    self endon( #"hash_f432da1df24ded2b" );
    self endon( #"disconnect" );
    level endon( #"ztron_game_is_over" );
    
    while ( isdefined( self ) )
    {
        if ( self.ztron.var_2c44544a01cc415e )
        {
            wait 1;
            continue;
        }
        
        if ( self.health < self.maxhealth )
        {
            if ( gettime() > self.var_5812f44cd938ce65 )
            {
                baserate = getdvarint( @"scr_ztron_player_health_regen", 2 );
                
                if ( self.ztron.upgradeMask & 8 )
                {
                    baserate = int( baserate * 1.5 );
                }
                
                rate = int( baserate * self.ztron.healthRegenScale );
                
                if ( self.health + rate <= self.maxhealth )
                {
                    self.health += rate;
                }
                else
                {
                    self.health = self.maxhealth;
                }
            }
        }
        
        if ( !player::isinlaststand() )
        {
            healthratio = self.health / self.maxhealth;
            
            if ( healthratio > self.var_b487d47112fa93d )
            {
                thread damage_effects::onexitdeathsdoor( 1 );
            }
        }
        
        wait 1;
    }
}

// Namespace ztron_player_utility
// Params 2
// Checksum 0xa4d74f74, Offset: 0x146d
// Size: 0x212
function shield_trigger_think( player, var_fedfe8d9224df1c7 )
{
    self notify( #"hash_73a37563fbbeb6cb" );
    self endon( #"hash_73a37563fbbeb6cb" );
    self endon( #"death" );
    
    /#
        if ( getdvarint( @"hash_96b7465214c5a3e6", 0 ) == 1 )
        {
            thread shield_debug_trigger( player );
        }
    #/
    
    self.player = player;
    throttle = 10;
    
    while ( isdefined( player ) )
    {
        self waittill( #"trigger", guy );
        
        if ( self.activetime < gettime() )
        {
            continue;
        }
        
        if ( !isdefined( player.team ) )
        {
            continue;
        }
        
        if ( !isdefined( guy ) )
        {
            continue;
        }
        
        if ( isplayer( guy ) )
        {
            continue;
        }
        
        if ( !issentient( guy ) )
        {
            continue;
        }
        
        if ( !guy.takedamage )
        {
            continue;
        }
        
        if ( guy.ztron.ignorebooster || guy.ztron.boss )
        {
            continue;
        }
        
        if ( !isdefined( guy.team ) )
        {
            continue;
        }
        
        if ( guy.team === player.team )
        {
            continue;
        }
        
        if ( gettime() < guy.ztron.shieldprotected )
        {
            continue;
        }
        
        guy function_7f8988ce63c1623d( 0 );
        player thread function_9dbd11353321b474( "booster", guy.var_945ef487faad2413 );
        guy dodamage( guy.maxhealth, guy.origin, player, player, "MOD_EXPLOSIVE", "<explicitweaponnone>" );
        dir = vectornormalize( guy.origin - player.origin + ( 0, 0, 64 ) );
        guy ztron_util::function_b9c77e54af91a636( dir, 8000 );
        throttle--;
        
        if ( throttle <= 0 )
        {
            throttle = 10;
            waitframe();
        }
    }
    
    self delete();
}

// Namespace ztron_player_utility
// Params 1
// Checksum 0x85d2fe62, Offset: 0x1687
// Size: 0x6d
function function_e914a81b9f8ce0c8( origin )
{
    assert( isdefined( self.ztron.checkpoint ), "<dev string:x24>" );
    self.ztron.checkpoint.valid = 1;
    self.ztron.checkpoint.origin = origin;
}

// Namespace ztron_player_utility
// Params 0
// Checksum 0xf142af6e, Offset: 0x16fc
// Size: 0x59
function function_d078263c76543d67()
{
    assert( self.ztron.checkpoint.valid, "<dev string:x55>" );
    ztron_util::teleport_player( self.ztron.checkpoint.origin, self.angles );
}

// Namespace ztron_player_utility
// Params 0
// Checksum 0x1b85946f, Offset: 0x175d
// Size: 0x43, Type: bool
function function_b22546586c836fe9()
{
    if ( self.takedamage == 0 )
    {
        return false;
    }
    
    if ( self.ztron.takedamage == 0 )
    {
        return false;
    }
    
    if ( function_826c7b60e2aeb3c0() )
    {
        return false;
    }
    
    if ( isingodmode( self ) )
    {
        return false;
    }
    
    return true;
}

// Namespace ztron_player_utility
// Params 1
// Checksum 0x9797b5c3, Offset: 0x17a9
// Size: 0x63
function shield_debug_trigger( player )
{
    self endon( #"death" );
    level endon( #"ztron_game_is_over" );
    
    while ( true )
    {
        if ( player function_826c7b60e2aeb3c0() )
        {
            level thread ztron_debug::drawcylinder( self.origin, 60, 72, level.framedurationseconds, ( 1, 0, 0 ) );
        }
        
        waitframe();
    }
}

// Namespace ztron_player_utility
// Params 0
// Checksum 0x44a094f8, Offset: 0x1814
// Size: 0x3c, Type: bool
function function_826c7b60e2aeb3c0()
{
    return isdefined( self.ztron.shieldtrigger ) && self.ztron.shieldtrigger.activetime >= gettime();
}

// Namespace ztron_player_utility
// Params 0
// Checksum 0xff580841, Offset: 0x1859
// Size: 0x4c
function function_f7e934186e91b71e()
{
    if ( isdefined( self.ztron.shieldtrigger ) )
    {
        self.ztron.shieldtrigger.activetime = 0;
    }
    
    thread ztron_vfx::function_f1048dd5d33090f8();
    level thread ztron_debug::debugmsg( " Player shield off" );
}

// Namespace ztron_player_utility
// Params 1
// Checksum 0x4a73e10d, Offset: 0x18ad
// Size: 0xd2
function turnPlayerShieldOn( short_shield = 1 )
{
    profilestart();
    
    if ( !isplayer( self ) )
    {
        profilestop();
        return;
    }
    
    if ( !isdefined( self.ztron ) || isdefined( self.ztron.vehicle ) )
    {
        profilestop();
        return;
    }
    
    var_f548a5c3215d81da = short_shield ? 3500 : 9500;
    
    if ( !short_shield && self.ztron.upgradeMask & 2 )
    {
        var_f548a5c3215d81da = int( var_f548a5c3215d81da * 1.5 );
    }
    
    activetime = gettime() + var_f548a5c3215d81da;
    
    if ( self.ztron.shieldtrigger.activetime > activetime )
    {
        profilestop();
        return;
    }
    
    thread function_d043fe1ade00898d( var_f548a5c3215d81da, short_shield );
    profilestop();
}

// Namespace ztron_player_utility
// Params 2
// Checksum 0xab22947c, Offset: 0x1987
// Size: 0x63
function function_a7362524677cd11e( watchnote, killshield = 1 )
{
    self notify( #"hash_b23d2afbe89526a7" );
    self endon( #"hash_b23d2afbe89526a7" );
    self endon( #"disconnect" );
    utility::waittill_any( watchnote, "shield_vfx_done" );
    thread ztron_vfx::function_f1048dd5d33090f8();
    
    if ( killshield )
    {
        function_f7e934186e91b71e();
    }
}

// Namespace ztron_player_utility
// Params 2, eflags: 0xc
// Checksum 0x2d0ef4b0, Offset: 0x19f2
// Size: 0x14f
function private function_d043fe1ade00898d( var_f548a5c3215d81da, shortshield )
{
    self notify( #"hash_be7467f73d95c9e2" );
    self endon( #"hash_be7467f73d95c9e2" );
    self endon( #"disconnect" );
    self endon( #"enter_vehicle" );
    function_f7e934186e91b71e();
    level thread ztron_debug::debugmsg( "Player shield on.  Radius: " + 60 );
    
    if ( isdefined( self.ztron.shieldtrigger ) )
    {
        self.ztron.shieldtrigger.activetime = gettime() + var_f548a5c3215d81da;
    }
    
    if ( !self.ztron.isboosting )
    {
        ztron_sound::ztron_playsound( "ztron_player_shield_start", undefined, self );
    }
    
    if ( !shortshield )
    {
        var_c0a0269c84d92f58 = ( var_f548a5c3215d81da - 500 ) / 1000 - 3;
        ztron_sound::ztron_playsound( "ztron_player_shield_full", undefined, self );
        thread ztron_vfx::function_b63ffc146fbe05b5( 0 );
        thread function_a7362524677cd11e( "enter_vehicle", 0 );
        wait var_c0a0269c84d92f58;
        self notify( #"shield_vfx_done" );
        waitframe();
    }
    
    thread ztron_vfx::function_b63ffc146fbe05b5( 1 );
    thread function_a7362524677cd11e( "enter_vehicle" );
    ztron_sound::ztron_playsound( "ztron_player_shield_half", undefined, self );
    wait 3;
    ztron_sound::ztron_playsound( "ztron_player_shield_stop", undefined, self );
    self notify( #"shield_vfx_done" );
}

// Namespace ztron_player_utility
// Params 1
// Checksum 0x205b947f, Offset: 0x1b49
// Size: 0xb8
function function_a6f524867f63c5cc( value = 450 )
{
    self endon( #"disconnect" );
    self.ztron.var_7edbd86a0f44be7b += value;
    dec = 6;
    
    while ( self.ztron.var_7edbd86a0f44be7b > 0 )
    {
        waitframe();
        self.ztron.var_7edbd86a0f44be7b = clamp( self.ztron.var_7edbd86a0f44be7b - dec, 0, self.ztron.var_7edbd86a0f44be7b );
    }
}

// Namespace ztron_player_utility
// Params 2
// Checksum 0xb416fd15, Offset: 0x1c09
// Size: 0x103
function playerinvulnerability( on, clear = 0 )
{
    if ( !isdefined( self ) || !isdefined( self.ztron ) )
    {
        return;
    }
    
    if ( !isdefined( self.ztron.var_91e07ff4b3a33b14 ) )
    {
        self.ztron.var_91e07ff4b3a33b14 = 0;
    }
    
    if ( clear )
    {
        self.ztron.var_91e07ff4b3a33b14 = 0;
    }
    
    if ( on )
    {
        self.ztron.var_91e07ff4b3a33b14++;
    }
    else
    {
        self.ztron.var_91e07ff4b3a33b14--;
    }
    
    if ( self.ztron.var_91e07ff4b3a33b14 > 0 )
    {
        self.ztron.takedamage = 0;
        return;
    }
    
    self.ztron.var_91e07ff4b3a33b14 = 0;
    self.ztron.takedamage = 1;
}

// Namespace ztron_player_utility
// Params 0
// Checksum 0x8ab463f9, Offset: 0x1d14
// Size: 0x47
function function_afac1199d03801b2()
{
    var_be4f500b14219ad8 = self.ztron.var_91e07ff4b3a33b14 || self.inlaststand;
    
    /#
        var_be4f500b14219ad8 |= isingodmode( self );
        var_be4f500b14219ad8 |= function_c24dbc26b2caf4a5( self );
    #/
    
    return var_be4f500b14219ad8;
}

// Namespace ztron_player_utility
// Params 1
// Checksum 0xb5c1a55b, Offset: 0x1d64
// Size: 0x96
function function_e3c7f85ade5940a2( player )
{
    i = player.sessionuimemberindex;
    i %= 4;
    
    switch ( i )
    {
        case 0:
            return "green";
        case 1:
            return "blue";
        case 2:
            return "red";
        case 3:
            return "yellow";
        default:
            assert( 0, "<dev string:x84>" );
            break;
    }
}

// Namespace ztron_player_utility
// Params 4
// Checksum 0x8357cd60, Offset: 0x1e02
// Size: 0x12b
function playerrespawnnow( fullinit = 0, spot = undefined, lifecost = -1, shieldon = 1 )
{
    self.ztron.var_2c44544a01cc415e = 0;
    
    if ( isdefined( self.revivetrigger ) )
    {
        self.revivetrigger delete();
    }
    
    ztron_laststand::exit( "last_stand_revived", self );
    self setorigin( spot ?? self.origin );
    self.health = self.maxhealth;
    playerinvulnerability( 1 );
    ztron_sound::ztron_playsound( "ztron_player_respawn", undefined, self );
    thread playerinitialize( fullinit );
    thread br_public::setplayerdownedextrainfo( 0 );
    level.ztron.downedplayers = function_bc138bbc1c54c35b();
    
    if ( ztron_main::function_4da200e9b8d58a3c() == 5 )
    {
        lifecost = 0;
    }
    
    if ( !fullinit )
    {
        ztron_score::givelives( lifecost );
    }
    
    if ( ztron_fate::hasfate( 6 ) )
    {
        thread function_8ee472666b217faf();
    }
    
    thread function_a010ad496283b361( fullinit, spot, lifecost, shieldon );
}

// Namespace ztron_player_utility
// Params 4, eflags: 0xc
// Checksum 0x46d7a4a7, Offset: 0x1f35
// Size: 0xa7
function private function_a010ad496283b361( fullinit, spot, lifecost, shieldon )
{
    self notify( #"hash_eac6680a454bf12a" );
    self endon( #"hash_eac6680a454bf12a" );
    self endon( #"disconnect" );
    waitframe();
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    playfxontag( utility::getfx( "ztron_player_respawn_" + self.ztron.color ), self, "tag_origin" );
    
    if ( !fullinit && shieldon )
    {
        thread turnPlayerShieldOn( 0 );
    }
    
    playerinvulnerability( 0, 1 );
    self notify( #"self_respawned" );
}

// Namespace ztron_player_utility
// Params 0
// Checksum 0xe475148e, Offset: 0x1fe4
// Size: 0xb0
function function_f39a4b7692450805()
{
    players = [];
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( player.inlaststand )
        {
            continue;
        }
        
        if ( isdefined( player.ztron ) )
        {
            players[ players.size ] = player;
        }
    }
    
    return players;
}

// Namespace ztron_player_utility
// Params 0
// Checksum 0x5e86f44a, Offset: 0x209d
// Size: 0xbf
function function_bc138bbc1c54c35b()
{
    downedplayers = [];
    
    foreach ( player in level.players )
    {
        if ( !player.inlaststand )
        {
            continue;
        }
        
        if ( player.ztron.score.lives > 0 )
        {
            continue;
        }
        
        downedplayers[ downedplayers.size ] = player;
    }
    
    return downedplayers;
}

// Namespace ztron_player_utility
// Params 1
// Checksum 0x49561eda, Offset: 0x2165
// Size: 0x33
function freezeplayercontrols( frozen = 1 )
{
    self.ztron.var_d7d14e7f8296da4d = frozen;
    self freezecontrols( frozen );
}

// Namespace ztron_player_utility
// Params 0, eflags: 0x4
// Checksum 0x25240fc6, Offset: 0x21a0
// Size: 0x100
function private function_4a58d49c13fdf620()
{
    if ( self.ztron )
    {
        if ( !isdefined( self.ztron.prevstate ) )
        {
            self.ztron.prevstate = spawnstruct();
        }
        
        self.ztron.prevstate.var_8a46e28ad02229a8 = self.ztron.var_8a46e28ad02229a8;
        self.ztron.prevstate.blockboost = self.ztron.blockboost;
        self.ztron.prevstate.blockgg = self.ztron.blockgg;
        self.ztron.prevstate.var_557a2e6d2ffa015c = self.ztron.var_557a2e6d2ffa015c;
    }
}

// Namespace ztron_player_utility
// Params 0, eflags: 0x4
// Checksum 0xf1a7f8ef, Offset: 0x22a8
// Size: 0xf3, Type: bool
function private function_b1c6a4ea03884a13()
{
    if ( self.ztron.prevstate )
    {
        self.ztron.var_8a46e28ad02229a8 = self.ztron.prevstate.var_8a46e28ad02229a8;
        self.ztron.blockboost = self.ztron.prevstate.blockboost;
        self.ztron.blockgg = self.ztron.prevstate.blockgg;
        self.ztron.var_557a2e6d2ffa015c = self.ztron.prevstate.var_557a2e6d2ffa015c;
        self.ztron.prevstate = undefined;
        return true;
    }
    
    return false;
}

// Namespace ztron_player_utility
// Params 0
// Checksum 0x5f2b8ec2, Offset: 0x23a4
// Size: 0x58
function function_dac9f20d4461a130()
{
    profilestart();
    self.ztron.var_8a46e28ad02229a8 = 0;
    self.ztron.blockboost = 0;
    self.ztron.blockgg = 0;
    self.ztron.var_557a2e6d2ffa015c = 0;
    profilestop();
}

// Namespace ztron_player_utility
// Params 4, eflags: 0xc
// Checksum 0x2c195bb5, Offset: 0x2404
// Size: 0x188
function private function_48d9c10d9b0730f8( frozen = 1, origin, angles, forcefixed = 0 )
{
    self notify( #"hash_48f7962ca874e71f" );
    self endon( #"hash_48f7962ca874e71f" );
    self endon( #"disconnect" );
    
    if ( frozen )
    {
        ztron_camera::function_79d64be315aa51c9( 5, forcefixed );
        level utility::flag_set( "ztron_cutscene" );
        self notify( #"ztron_player_dump_vehicle" );
        self notify( #"cutscene_played" );
        
        while ( function_32883fa42c326520() || self.ztron.vehicle )
        {
            waitframe();
        }
        
        function_4a58d49c13fdf620();
        self.ztron.var_8a46e28ad02229a8 = 1;
        self.ztron.blockboost = 1;
        self.ztron.blockgg = 1;
        self.ztron.var_557a2e6d2ffa015c = 1;
        self freezecontrols( 1 );
        self freezelookcontrols( 1 );
        ztron_util::teleport_player( origin, angles );
        val::set( "ztron_cutscene", "show_hud", 0 );
        return;
    }
    
    level utility::flag_clear( "ztron_cutscene" );
    val::reset( "ztron_cutscene", "show_hud" );
    ztron_camera::function_9d2ce447580a6290();
    
    if ( function_b1c6a4ea03884a13() == 0 )
    {
        function_dac9f20d4461a130();
    }
    
    self freezecontrols( 0 );
    self freezelookcontrols( 0 );
}

// Namespace ztron_player_utility
// Params 4
// Checksum 0x15b23485, Offset: 0x2594
// Size: 0x45
function function_a9dd68a6d53566b0( frozen = 1, origin, angles, forcefixed = 0 )
{
    thread function_48d9c10d9b0730f8( frozen, origin, angles, forcefixed );
}

// Namespace ztron_player_utility
// Params 1, eflags: 0x4
// Checksum 0x1bc55333, Offset: 0x25e1
// Size: 0x91
function private function_80c059c3398e8b92( speedrate )
{
    if ( isdefined( self.var_e5996377e9a13e32 ) )
    {
        foreach ( var_b39e5fef59c72627 in self.var_e5996377e9a13e32 )
        {
            speedrate *= var_b39e5fef59c72627;
        }
    }
    
    return speedrate;
}

/#

    // Namespace ztron_player_utility
    // Params 0, eflags: 0xc
    // Checksum 0x348d79be, Offset: 0x267b
    // Size: 0xfc, Type: dev
    function private function_ceebc3871e0019d0()
    {
        self notify( #"hash_467801f3ed0d9cfb" );
        self endon( #"hash_467801f3ed0d9cfb" );
        self endon( #"disconnect" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_b5517d1e0b124f30", 0 ) == 1 )
            {
                speedscalemulti = function_80c059c3398e8b92( 1 );
                ztron_debug::function_7a494955e7b24aa3( 200, 300, "<dev string:xa5>" + string( self.ztron.speedoverride ), ( 1, 1, 1 ), level.framedurationseconds );
                ztron_debug::function_7a494955e7b24aa3( 200, 320, "<dev string:xba>" + string( speedscalemulti ), ( 1, 1, 1 ), level.framedurationseconds );
                ztron_debug::function_7a494955e7b24aa3( 200, 340, "<dev string:xcc>" + string( self.movespeedscaler ), ( 1, 1, 1 ), level.framedurationseconds );
            }
            
            waitframe();
        }
    }

#/

// Namespace ztron_player_utility
// Params 0
// Checksum 0xb553fedf, Offset: 0x277f
// Size: 0x7e
function updateplayerspeed()
{
    /#
        thread function_ceebc3871e0019d0();
    #/
    
    if ( self.ztron.speedoverride )
    {
        rate = function_80c059c3398e8b92( self.ztron.speedoverride );
        val::set( "ztron_speed_change", "move_speed_scale", rate );
        return;
    }
    
    val::reset( "ztron_speed_change", "move_speed_scale" );
    function_2c9ea3b797f22c77( self.movespeedscaler );
}

// Namespace ztron_player_utility
// Params 2, eflags: 0xc
// Checksum 0xdb68bc46, Offset: 0x2805
// Size: 0x9a
function private _do_speed_change( rate, timeout )
{
    self notify( #"hash_1557322e713f17b3" );
    self endon( #"hash_1557322e713f17b3" );
    self endon( #"disconnect" );
    self.ztron.speedoverride = rate;
    updateplayerspeed();
    msg = utility::waittill_any_timeout( timeout, "last_stand_enter", "force_reset_speed" );
    self notify( #"speed_reset" );
    self.ztron.speedoverride = undefined;
    updateplayerspeed();
}

// Namespace ztron_player_utility
// Params 3
// Checksum 0x1e18af26, Offset: 0x28a7
// Size: 0xbc
function function_1dc834c65d7c8ea( time, rate, penalty_scriptable_state = #"slow_down_green" )
{
    if ( function_826c7b60e2aeb3c0() || function_afac1199d03801b2() )
    {
        return;
    }
    
    if ( gettime() < self.ztron.penaltycooldown )
    {
        return;
    }
    
    self notify( #"force_reset_speed" );
    self setscriptablepartstate( #"ztron_player_speed_change_fx", penalty_scriptable_state, 0 );
    ztron_sound::ztron_playsound( "ztron_playerNovaPoisonedOS", undefined, self );
    self.ztron.penaltycooldown = gettime() + 500;
    thread _do_speed_change( rate, time );
    thread function_a12d3aecd2b31eb0( "speed_reset" );
}

// Namespace ztron_player_utility
// Params 2
// Checksum 0x1ed15815, Offset: 0x296b
// Size: 0x93
function function_8ee472666b217faf( time = 25, rate = getdvarfloat( @"hash_b84c9488d420c7d3", 1 ) * getdvarfloat( @"hash_8bc9aeb7a354b719", 1.65 ) )
{
    self notify( #"force_reset_speed" );
    self setscriptablepartstate( #"ztron_player_speed_change_fx", #"hash_8bbd1e9dfde216e8", 0 );
    ztron_sound::ztron_playsound( "ztron_playerSpeedFeetOS", undefined, self );
    thread _do_speed_change( rate, time );
    thread function_a12d3aecd2b31eb0( "speed_reset" );
}

// Namespace ztron_player_utility
// Params 1, eflags: 0xc
// Checksum 0x450ab9eb, Offset: 0x2a06
// Size: 0x4f
function private function_a12d3aecd2b31eb0( msg )
{
    self notify( #"hash_f8aa7afad7a18c17" );
    self endon( #"hash_f8aa7afad7a18c17" );
    self endon( #"disconnect" );
    self waittill( msg );
    self setscriptablepartstate( #"ztron_player_speed_change_fx", #"normal", 0 );
}

// Namespace ztron_player_utility
// Params 0
// Checksum 0xb3c58ecf, Offset: 0x2a5d
// Size: 0x18, Type: bool
function function_a4f2178e61908c66()
{
    profilestart();
    profilestop();
    return !self.ztron.var_8103a5c573d38485;
}

// Namespace ztron_player_utility
// Params 0
// Checksum 0xbcf86741, Offset: 0x2a7f
// Size: 0x33, Type: bool
function function_9abc64ef2cb9cbd()
{
    profilestart();
    
    if ( !level.onlinegame )
    {
        profilestop();
        return false;
    }
    
    if ( level.ztron.var_1228c567770e4580 )
    {
        profilestop();
        return false;
    }
    
    profilestop();
    return function_a4f2178e61908c66();
}

// Namespace ztron_player_utility
// Params 4
// Checksum 0x57f7d1db, Offset: 0x2abc
// Size: 0x203
function function_8e1155bcebb3b7b3( amount, pickup = 0, var_c33684ac63b5dfae = 1, issplit = 0 )
{
    profilestart();
    
    if ( pickup && amount > 0 && ztron_fate::function_c93d5c389d532c34( 2, 2 ) )
    {
        amount = int( amount * 1.25 );
    }
    
    if ( amount > 0 )
    {
        amount = int( ( amount + 24 ) / 25 ) * 25;
    }
    else
    {
        amount = int( ( amount - 24 ) / 25 ) * 25;
    }
    
    if ( !isdefined( self.currency[ #"plunder" ] ) )
    {
        self.currency[ #"plunder" ] = 0;
    }
    
    self.currency[ #"plunder" ] = int( clamp( self.currency[ #"plunder" ] + amount, 0, getdvarint( @"hash_35512059a8602abd", 130000 ) ) );
    
    if ( self isconnected() )
    {
        cash::playersetplunderomnvar( self.currency[ #"plunder" ] );
    }
    
    if ( amount > 0 && !issplit )
    {
        if ( !isdefined( self.ztron.var_71483ab64fc14eb4 ) )
        {
            self.ztron.var_71483ab64fc14eb4 = 0;
        }
        
        self.ztron.var_71483ab64fc14eb4 += amount;
        
        if ( var_c33684ac63b5dfae )
        {
            if ( !isdefined( self.ztron.var_b9361a06e37de074 ) )
            {
                self.ztron.var_b9361a06e37de074 = 0;
            }
            
            self.ztron.var_b9361a06e37de074 += amount;
        }
    }
    
    function_c2b330b498256506();
    
    if ( ztron_ui::function_c0e9929809a7d942() == 0 )
    {
        ztron_ui::function_f7e6c4641e827bf8( 1, 3 );
    }
    
    profilestop();
}

// Namespace ztron_player_utility
// Params 0
// Checksum 0xccc0938a, Offset: 0x2cc7
// Size: 0x42
function function_da0857c472c9dc5e()
{
    profilestart();
    
    if ( !isdefined( self.currency[ #"plunder" ] ) )
    {
        self.currency[ #"plunder" ] = 0;
    }
    
    profilestop();
    return self.currency[ #"plunder" ];
}

// Namespace ztron_player_utility
// Params 2
// Checksum 0x3d85fe56, Offset: 0x2d13
// Size: 0x71
function function_402a17b12b263a82( delay = 2, duration = 3 )
{
    self notify( #"hash_c6a2ed342399b0d6" );
    self endon( #"hash_c6a2ed342399b0d6" );
    self endon( #"disconnect" );
    self waittill( #"round_begin" );
    wait delay;
    
    if ( ztron_ui::function_c0e9929809a7d942() == 0 )
    {
        ztron_ui::function_f7e6c4641e827bf8( 1, duration );
    }
}

// Namespace ztron_player_utility
// Params 0
// Checksum 0xb3fc1652, Offset: 0x2d8c
// Size: 0x1c
function isplayerspectating()
{
    if ( self.sessionstate === "spectator" )
    {
        return 1;
    }
    
    return self isspectatinganyone();
}

// Namespace ztron_player_utility
// Params 2
// Checksum 0x13d2d9c1, Offset: 0x2db1
// Size: 0xfb
function function_28d3a926aa4df460( var_e75b6e047bd409ac = 1, restoresuper = 0 )
{
    foreach ( player in level.players )
    {
        if ( !player function_a120489ddd3aa5ce() )
        {
            continue;
        }
        
        if ( player isplayerspectating() )
        {
            continue;
        }
        
        if ( !isalive( player ) || player.ztron.var_2c44544a01cc415e )
        {
            player playerrespawnnow();
        }
        
        if ( var_e75b6e047bd409ac )
        {
            player function_8be6001f06970a15();
        }
        
        if ( restoresuper )
        {
            player restoresuper();
        }
    }
}

// Namespace ztron_player_utility
// Params 0
// Checksum 0xa8a3e7e6, Offset: 0x2eb4
// Size: 0x9c
function function_ee455a0fc54e29fb()
{
    self notify( #"hash_46c5c98eaaea400d" );
    self endon( #"hash_46c5c98eaaea400d" );
    self endon( #"disconnect" );
    self.ztron.superid = undefined;
    superinfo = supers_mp::getcurrentsuper();
    
    if ( isdefined( superinfo ) )
    {
        while ( superinfo.isinuse )
        {
            superinfo = supers_mp::getcurrentsuper();
            waitframe();
        }
        
        supers_mp::function_78d95dc7f8d14c64( supers_mp::function_e48058725c0c163a() );
        supers_mp::setsuperbasepoints( 0, 0 );
        perkpackage::perkpackage_giveoverridefieldupgrades();
        supers_mp::clearsuper();
    }
    
    waitframe();
    self notify( #"hash_2462cea404e8e164" );
}

// Namespace ztron_player_utility
// Params 2
// Checksum 0x6b87f630, Offset: 0x2f58
// Size: 0xfd
function function_64952a50eba73135( superid, fullpower = 1 )
{
    self endon( #"disconnect" );
    
    if ( !isdefined( superid ) )
    {
        var_9aa974a76b9a6486 = level.ztron.superids;
        
        if ( isdefined( self.ztron.superid ) )
        {
            var_9aa974a76b9a6486 = arrayremove( var_9aa974a76b9a6486, self.ztron.superid );
        }
        
        superid = var_9aa974a76b9a6486[ randomint( var_9aa974a76b9a6486.size ) ];
    }
    
    assert( arraycontains( level.ztron.superids, superid ), "<dev string:xde>" );
    thread function_ee455a0fc54e29fb();
    self waittill( #"hash_2462cea404e8e164" );
    self.ztron.superid = superid;
    perkpackage::perkpackage_giveoverridefieldupgrades( superid );
    waitframe();
    
    if ( fullpower )
    {
        function_21f8005dcd5af7f9();
    }
    
    thread function_a45c0d0e27c8febe();
}

// Namespace ztron_player_utility
// Params 0
// Checksum 0x752537d4, Offset: 0x305d
// Size: 0x6d
function function_a45c0d0e27c8febe()
{
    self notify( #"hash_e418d679c9d17ce3" );
    self endon( #"hash_e418d679c9d17ce3" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"super_started" );
        
        if ( self.ztron.upgradeMask & 536870912 )
        {
            if ( randomint( 100 ) < 20 )
            {
                thread namespace_725ac80c95cdb365::activate_magic_hat( self, 30 );
            }
        }
    }
}

// Namespace ztron_player_utility
// Params 1
// Checksum 0x93e9d531, Offset: 0x30d2
// Size: 0xba
function function_ba9d8c3e2b4f18ad( hash )
{
    if ( isdefined( hash ) )
    {
        keys = getarraykeys( level.ztron.var_6c96caea03d7b13c );
        
        foreach ( key in keys )
        {
            if ( key == hash )
            {
                return level.ztron.var_6c96caea03d7b13c[ key ];
            }
        }
    }
}

// Namespace ztron_player_utility
// Params 0
// Checksum 0x76b6b19, Offset: 0x3195
// Size: 0x33
function restoresuper()
{
    if ( isdefined( self.ztron.superid ) )
    {
        thread function_64952a50eba73135( self.ztron.superid );
    }
}

// Namespace ztron_player_utility
// Params 0
// Checksum 0xd8fdbfce, Offset: 0x31d0
// Size: 0x34
function function_21f8005dcd5af7f9()
{
    var_c0c4324d255baab3 = supers_mp::getcurrentsuper();
    
    if ( !isalive( self ) || !isdefined( var_c0c4324d255baab3 ) )
    {
        return;
    }
    
    thread supers_mp::function_235acb90dc5ccdbe();
    thread function_33e6a52cd856a38();
}

// Namespace ztron_player_utility
// Params 2
// Checksum 0xeab00a11, Offset: 0x320c
// Size: 0x2ae
function function_9dbd11353321b474( selement = "", rechargeaward )
{
    if ( !isdefined( self.ztron.superid ) )
    {
        return;
    }
    
    if ( !isdefined( rechargeaward ) )
    {
        rechargeaward = 0;
    }
    
    if ( !isdefined( self.ztron.var_945ef487faad2413 ) )
    {
        self.ztron.var_945ef487faad2413 = 0;
    }
    
    self.ztron.var_945ef487faad2413 += rechargeaward;
    
    switch ( selement )
    {
        case #"hash_a7c76a8f41a40e13":
            if ( self.ztron.superid == "super_tesla_storm" )
            {
                self.ztron.var_945ef487faad2413 += 0.2;
            }
            
            break;
        case #"hash_388125c3427822bb":
            if ( self.ztron.superid == "super_frost_blast" )
            {
                self.ztron.var_945ef487faad2413 += 1.5;
            }
            
            break;
        case #"hash_f246c1c876db5240":
            if ( self.ztron.superid == "super_aether_shroud" )
            {
                self.ztron.var_945ef487faad2413 += 1.2;
            }
            
            break;
        case #"hash_953280ba7c867997":
            if ( self.ztron.superid == "super_mary_paris" )
            {
                self.ztron.var_945ef487faad2413 += 1.2;
            }
            
            break;
        case #"hash_195360490caa3220":
            if ( self.ztron.superid == "super_energy_mine" )
            {
                self.ztron.var_945ef487faad2413 += 0.2;
            }
            
            break;
        case #"hash_9535ce45708366b9":
            if ( self.ztron.superid == "super_dark_flare" )
            {
                self.ztron.var_945ef487faad2413 += 1;
            }
            
            break;
    }
}

// Namespace ztron_player_utility
// Params 1
// Checksum 0x6ff94d9f, Offset: 0x34c2
// Size: 0xd8
function function_33e6a52cd856a38( var_912335f1ac2617b4 )
{
    self notify( #"hash_609c4d11a51d8197" );
    self endon( #"hash_609c4d11a51d8197" );
    self endon( #"disconnect", #"hash_2462cea404e8e164" );
    level endon( #"ztron_game_is_over" );
    self.ztron.var_945ef487faad2413 = var_912335f1ac2617b4 ?? 0;
    
    while ( true )
    {
        superboost = int( self.ztron.var_945ef487faad2413 ?? 0 );
        
        if ( superboost > 0 )
        {
            self.ztron.var_945ef487faad2413 -= superboost;
            
            if ( !supers_mp::issuperready() )
            {
                thread supers_mp::givesuperpoints( superboost, undefined, 1 );
            }
        }
        
        wait 2;
    }
}

// Namespace ztron_player_utility
// Params 0
// Checksum 0xf7950594, Offset: 0x35a2
// Size: 0x47, Type: bool
function function_a120489ddd3aa5ce()
{
    if ( !isplayer( self ) )
    {
        return false;
    }
    
    if ( !self.ztron.initialized )
    {
        return false;
    }
    
    if ( self.sessionstate != "playing" )
    {
        return false;
    }
    
    if ( !self isconnected() )
    {
        return false;
    }
    
    return true;
}

// Namespace ztron_player_utility
// Params 2
// Checksum 0x31de476d, Offset: 0x35f2
// Size: 0xcd
function function_10777122eee28fa8( time, isshield = 0 )
{
    if ( !isplayer( self ) && isplayer( self.owner ) )
    {
        return time;
    }
    
    if ( isbot( self ) || self.bsoldier )
    {
        return time;
    }
    
    assert( isplayer( self ), "<dev string:xef>" );
    
    if ( isdefined( self.ztron.var_930cb6796e836ff7 ) )
    {
        time *= self.ztron.var_930cb6796e836ff7;
        self.ztron.var_930cb6796e836ff7 = undefined;
    }
    
    if ( !isshield )
    {
        return ztron_fate::function_ae31dc85d3cf758( time );
    }
    
    return max( ztron_fate::function_ae31dc85d3cf758( time ), ztron_fate::function_6ddf81aedfabc3d6( time ) );
}

// Namespace ztron_player_utility
// Params 0
// Checksum 0xda910b3, Offset: 0x36c7
// Size: 0x1a7
function function_8be6001f06970a15()
{
    boostcount = self.ztron.score.var_59f1f1595961cbe;
    
    if ( level.ztron.blitzmode )
    {
        if ( self.ztron.upgradeMask & 4398046511104 )
        {
            boostcount = int( max( boostcount, 2 ) );
        }
    }
    else if ( ztron_fate::hasfate( 4 ) )
    {
        boostcount = int( max( boostcount, 2 ) );
        
        if ( ztron_fate::function_c93d5c389d532c34( 4, 1 ) )
        {
            boostcount = int( max( boostcount, 4 ) );
        }
    }
    else
    {
        boostcount = int( max( boostcount, 1 ) );
        
        if ( level.ztron.var_95d8c7a469393957 || !level.ztron.gobblegumsenabled )
        {
            ztron_ui::function_545666b11d318ade( 2 );
        }
    }
    
    namespace_33e886a9a5b55137::function_992dffefa33a9534( boostcount );
    
    if ( ztron_fate::hasfate( 5 ) )
    {
        ztron_fate_shield::activate();
    }
    
    nukecount = self.ztron.score.bombs;
    
    if ( level.ztron.blitzmode )
    {
        nukecount = int( max( nukecount, 0 ) );
    }
    else if ( ztron_fate::function_c93d5c389d532c34( 1, 1 ) )
    {
        nukecount = int( max( nukecount, 3 ) );
    }
    else
    {
        nukecount = int( max( nukecount, 1 ) );
    }
    
    namespace_a6a7fe92789f4ad9::function_8cab6adef8e1bef2( nukecount );
    self.health = self.maxhealth;
    self.ignoreme = 0;
}

// Namespace ztron_player_utility
// Params 3
// Checksum 0x14dacefe, Offset: 0x3876
// Size: 0x94
function entityhighlight( player, timeout = 4, bscriptable = 0 )
{
    if ( isent( self ) )
    {
        self hudoutlineenable( "outline_nodepth_red" );
        utility::waittill_any_timeout( timeout, "death" );
        
        if ( isdefined( self ) )
        {
            self hudoutlinedisable();
        }
        
        return;
    }
    
    if ( bscriptable )
    {
        self setscriptablepartstate( "outline", "on" );
        utility::waittill_any_timeout( timeout, "death" );
        
        if ( isdefined( self ) )
        {
            self setscriptablepartstate( "outline", "off" );
        }
    }
}

// Namespace ztron_player_utility
// Params 2
// Checksum 0x186be2af, Offset: 0x3912
// Size: 0xa9
function sentienthighlight( player, timeout = 4 )
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    if ( player isconnected() )
    {
        player setclientomnvar( "ui_ztron_zombie_killer_ent_num", self getentitynumber() );
    }
    
    /#
        if ( getdvarint( @"hash_e0d1acd921d5fdb5", 0 ) >= 1 )
        {
            level thread ztron_debug::draw_circle( self.origin, 36, ( 1, 0, 0 ), undefined, undefined, 5 );
        }
    #/
    
    utility::waittill_any_timeout( timeout, "death" );
    
    if ( isdefined( player ) && player isconnected() )
    {
        player setclientomnvar( "ui_ztron_zombie_killer_ent_num", -1 );
    }
}

// Namespace ztron_player_utility
// Params 1
// Checksum 0x8e82f02d, Offset: 0x39c3
// Size: 0x118
function highlightkiller( eattacker )
{
    if ( issentient( eattacker ) )
    {
        eattacker thread sentienthighlight( self );
    }
    
    if ( isdefined( eattacker ) && getdvarint( @"hash_d8ef6547a4c77e77", 1 ) == 1 )
    {
        if ( isai( eattacker ) )
        {
            if ( getdvarint( @"hash_13f98f6871353096", 0 ) == 1 )
            {
                eattacker thread entityhighlight( self, 4 );
            }
            
            return;
        }
        
        if ( getdvarint( @"hash_e3878c9421f14f50", 1 ) == 1 )
        {
            bscriptable = 0;
            
            if ( isdefined( eattacker.owner ) && eattacker.owner != self )
            {
                eattacker = eattacker.owner;
            }
            
            if ( isdefined( eattacker.script_model ) )
            {
                eattacker = eattacker.script_model;
            }
            
            if ( isdefined( eattacker.scriptable ) )
            {
                eattacker = eattacker.scriptable;
                modelent = eattacker function_f911103fc8a0b6e7();
                
                if ( isdefined( modelent ) )
                {
                    eattacker = modelent;
                }
                
                bscriptable = 1;
            }
            
            eattacker thread entityhighlight( self, 4, bscriptable );
        }
    }
}

// Namespace ztron_player_utility
// Params 1
// Checksum 0xb171261b, Offset: 0x3ae3
// Size: 0x7f
function resetdefaultweapon( waitnote )
{
    self endon( #"disconnect" );
    
    if ( isdefined( waitnote ) )
    {
        self waittill( waitnote );
    }
    
    if ( ztron_fate::hasfate( 1 ) )
    {
        self.ztron.default_weapon_bundle = %"hash_38aaa6806435d580";
    }
    else
    {
        self.ztron.default_weapon_bundle = %"hash_28daa78760241031";
    }
    
    ztron_weapon::function_596b8bb19981e412();
    ztron_weapon::takeweaponpack( 1, 0, 1 );
}

// Namespace ztron_player_utility
// Params 0
// Checksum 0x23d7d29c, Offset: 0x3b6a
// Size: 0x16, Type: bool
function function_c957d7ce1000405e()
{
    return !self.ztron.var_8103a5c573d38485;
}

// Namespace ztron_player_utility
// Params 2
// Checksum 0xe5c247c6, Offset: 0x3b89
// Size: 0xbb
function getplayersinradius( origin, radiussq )
{
    players = [];
    
    foreach ( player in level.players )
    {
        distsq = distancesquared( player.origin, origin );
        
        if ( distsq < radiussq )
        {
            players[ players.size ] = player;
        }
    }
    
    return players;
}

// Namespace ztron_player_utility
// Params 2
// Checksum 0xd6359477, Offset: 0x3c4d
// Size: 0x105
function function_9137f806254e5d71( player, timexp )
{
    profilestart();
    aeeventname = #"zm_round_end";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    var_7924c4217cee5320 = game_utility::function_67138bc0fb9151ff();
    
    if ( isdefined( aeeventid ) )
    {
        eventparams = [];
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_f3034aff9c9a5f6e" ) ] = timexp;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gobblegum_earn_rate_multiplier" ) ] = int( getdvarfloat( @"hash_a4bd3657b64a4479", 1 ) * 100 );
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = level.challengeandeventglobals.game_type_col[ var_7924c4217cee5320 ];
        
        if ( level.ztron.var_f8ed1f37b6e13f4c )
        {
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_f3034aff9c9a5f6e" ) ] = 1800;
        }
        
        player function_2e45314624fdfdb8( aeeventid, eventparams );
    }
    
    profilestop();
}

// Namespace ztron_player_utility
// Params 0
// Checksum 0x8c4a03e3, Offset: 0x3d5a
// Size: 0x17
function function_c797d87f64b625c0()
{
    self.ztron.var_d0fa1c02675f0d94 = 0;
}

// Namespace ztron_player_utility
// Params 0
// Checksum 0xdb2dc5ee, Offset: 0x3d79
// Size: 0x4c
function function_a6bd4d3b32a06a5f()
{
    self notify( #"hash_fa8d626ee8b84057" );
    self endon( #"hash_fa8d626ee8b84057" );
    self endon( #"disconnect" );
    function_c797d87f64b625c0();
    
    while ( true )
    {
        wait 1;
        self.ztron.var_d0fa1c02675f0d94++;
    }
}

// Namespace ztron_player_utility
// Params 1
// Checksum 0x21366281, Offset: 0x3dcd
// Size: 0x37
function function_baf22e7b5779b533( ent )
{
    entnum = ent getentitynumber();
    return arraycontains( level.ztron.var_909f9ee392414e7, entnum );
}

// Namespace ztron_player_utility
// Params 0
// Checksum 0x9fb7c9, Offset: 0x3e0d
// Size: 0x30
function function_c2b330b498256506()
{
    var_e22bd8a529218987 = function_da0857c472c9dc5e();
    
    if ( !isdefined( var_e22bd8a529218987 ) )
    {
        var_e22bd8a529218987 = 0;
    }
    
    stats::setextrascore0( var_e22bd8a529218987 & 32767 );
    function_4a2fd6493a314ea6();
}

// Namespace ztron_player_utility
// Params 1
// Checksum 0x80ef9fa2, Offset: 0x3e45
// Size: 0x29
function update_papaback_defeated( isdefeated )
{
    self.ztron.papabackdefeated = isdefeated;
    function_4a2fd6493a314ea6();
}

// Namespace ztron_player_utility
// Params 0
// Checksum 0x6a1de8bb, Offset: 0x3e76
// Size: 0x9
function update_current_round()
{
    function_4a2fd6493a314ea6();
}

// Namespace ztron_player_utility
// Params 0
// Checksum 0x69ccd80c, Offset: 0x3e87
// Size: 0x9e
function function_4a2fd6493a314ea6()
{
    var_e22bd8a529218987 = function_da0857c472c9dc5e();
    
    if ( !isdefined( var_e22bd8a529218987 ) )
    {
        var_e22bd8a529218987 = 0;
    }
    
    var_ab2a65ad1abd54b4 = 0;
    
    if ( self.ztron.papabackdefeated )
    {
        var_ab2a65ad1abd54b4 = 16384;
    }
    
    if ( level.ztron.roundnumber > 255 )
    {
        level.ztron.roundnumber = 255;
    }
    
    var_ab2a65ad1abd54b4 |= level.ztron.roundnumber << 6;
    var_ab2a65ad1abd54b4 |= var_e22bd8a529218987 >> 15;
    stats::setextrascore1( var_ab2a65ad1abd54b4 );
}

// Namespace ztron_player_utility
// Params 0
// Checksum 0x3a6ac375, Offset: 0x3f2d
// Size: 0x3d
function function_af4808ad87d6d3a()
{
    if ( getdvarint( @"hash_6cb980a6d9b2caee", 1 ) == 1 )
    {
        self notify( #"hash_70a8eb4e9c044f99" );
        level notify( #"hash_70a8eb4e9c044f99" );
        function_1a460ed0c0d7c466();
        function_1a460fd0c0d7c699();
    }
}

// Namespace ztron_player_utility
// Params 0
// Checksum 0xd87bba23, Offset: 0x3f72
// Size: 0x48
function function_1a460ed0c0d7c466()
{
    if ( getdvarint( @"hash_6cb980a6d9b2caee", 1 ) == 1 )
    {
        self notify( #"clearScript0Hint" );
        level notify( #"clearScript0Hint" );
        self.ztron.var_8a4193f4617d0b03 = undefined;
        self clearpredictedstreampos();
    }
}

// Namespace ztron_player_utility
// Params 0
// Checksum 0xcda188dc, Offset: 0x3fc2
// Size: 0x48
function function_1a460fd0c0d7c699()
{
    if ( getdvarint( @"hash_6cb980a6d9b2caee", 1 ) == 1 )
    {
        self notify( #"clearScript1Hint" );
        level notify( #"clearScript1Hint" );
        self.ztron.var_b295bd57c4838574 = undefined;
        self clearadditionalstreampos();
    }
}

// Namespace ztron_player_utility
// Params 2
// Checksum 0x245f3abd, Offset: 0x4012
// Size: 0xc9
function function_ca24a1915072ab29( hintpos, lightstate = 0 )
{
    if ( getdvarint( @"hash_6cb980a6d9b2caee", 1 ) == 1 )
    {
        if ( isdefined( self.ztron ) )
        {
            self.ztron.var_8a4193f4617d0b03 = hintpos;
        }
        
        self predictstreamposuntilcleared( hintpos, 3, undefined, lightstate );
        
        /#
            if ( getdvarint( @"hash_761c860994ef4569", 0 ) == 1 )
            {
                level thread ztron_debug::drawsphere( hintpos, 24, 18, ( 0, 1, 0 ), "<dev string:x10e>", "<dev string:x117>" );
                thread ztron_debug::function_cadec874ded26d36( "<dev string:x128>" + lightstate + "<dev string:x142>", ( 0, 1, 0 ), undefined, undefined, 18, "<dev string:x117>" );
            }
        #/
    }
}

// Namespace ztron_player_utility
// Params 2
// Checksum 0x27978c96, Offset: 0x40e3
// Size: 0xd5
function function_ca24a0915072a8f6( hintpos, lightstate = 0 )
{
    if ( getdvarint( @"hash_6cb980a6d9b2caee", 1 ) == 1 )
    {
        if ( isdefined( self.ztron ) )
        {
            self.ztron.var_b295bd57c4838574 = hintpos;
        }
        
        self setadditionalstreamposuntilcleared( hintpos, 3, undefined, lightstate );
        
        /#
            if ( getdvarint( @"hash_761c860994ef4569", 0 ) == 1 )
            {
                level thread ztron_debug::drawsphere( hintpos, 28, 18, ( 0, 0, 1 ), "<dev string:x144>", "<dev string:x14d>" );
                thread ztron_debug::function_cadec874ded26d36( "<dev string:x15e>" + lightstate + "<dev string:x142>", ( 0, 0, 1 ), ( 0, 0, 130 ), undefined, 18, "<dev string:x14d>" );
            }
        #/
    }
}

// Namespace ztron_player_utility
// Params 3
// Checksum 0x3a6c9f22, Offset: 0x41c0
// Size: 0xfd
function function_fa760210c6b56964( hintpos, durations = -1, lightstate = 0 )
{
    self notify( #"hash_9706888771c3969d" );
    self endon( #"hash_9706888771c3969d" );
    level endon( #"ztron_game_is_over" );
    self endon( #"disconnect" );
    
    if ( getdvarint( @"hash_6cb980a6d9b2caee", 1 ) == 1 )
    {
        if ( durations == -1 )
        {
            while ( true )
            {
                thread function_ca24a1915072ab29( hintpos, lightstate );
                msg = utility::waittill_any_timeout( 18, "clearScript0Hint" );
                
                if ( msg == "clearScript0Hint" )
                {
                    return;
                }
            }
            
            return;
        }
        
        var_76fb484824dcfae9 = gettime() + durations * 1000;
        
        while ( gettime() < var_76fb484824dcfae9 )
        {
            thread function_ca24a1915072ab29( hintpos, lightstate );
            msg = utility::waittill_any_timeout( 18, "clearScript0Hint" );
            
            if ( msg == "clearScript0Hint" )
            {
                return;
            }
        }
    }
}

// Namespace ztron_player_utility
// Params 3
// Checksum 0x2fec860b, Offset: 0x42c5
// Size: 0xfc
function function_53a479766e307885( hintpos, durations = -1, lightstate = 0 )
{
    self notify( #"hash_3343b5aa950892b1" );
    self endon( #"hash_3343b5aa950892b1" );
    level endon( #"ztron_game_is_over" );
    self endon( #"disconnect" );
    
    if ( getdvarint( @"hash_6cb980a6d9b2caee", 1 ) == 1 )
    {
        if ( durations == -1 )
        {
            while ( true )
            {
                thread function_ca24a0915072a8f6( hintpos, lightstate );
                msg = utility::waittill_any_timeout( 18, "clearScript1Hint" );
                
                if ( msg == "clearScript1Hint" )
                {
                    return;
                }
            }
            
            return;
        }
        
        var_76fb484824dcfae9 = gettime() + durations * 1000;
        
        while ( gettime() < var_76fb484824dcfae9 )
        {
            thread function_ca24a0915072a8f6( hintpos );
            msg = utility::waittill_any_timeout( 18, "clearScript1Hint" );
            
            if ( msg == "clearScript1Hint" )
            {
                return;
            }
        }
    }
}

// Namespace ztron_player_utility
// Params 0
// Checksum 0x5fa19fc2, Offset: 0x43c9
// Size: 0x2c, Type: bool
function function_32883fa42c326520()
{
    return self.ztron.usingmutant || self.ztron.var_c516f6d55a2165b4;
}

// Namespace ztron_player_utility
// Params 1
// Checksum 0x36a765f7, Offset: 0x43fe
// Size: 0xd3
function function_f0bf0ac112ebf51( timeout = 3.5 )
{
    endtime = gettime() + timeout * 1000;
    
    while ( gettime() < endtime )
    {
        continueflag = 0;
        
        foreach ( player in level.players )
        {
            if ( player function_32883fa42c326520() )
            {
                continueflag = 1;
                break;
            }
        }
        
        if ( continueflag )
        {
            waitframe();
            continue;
        }
        
        break;
    }
}

// Namespace ztron_player_utility
// Params 0
// Checksum 0x19c5c592, Offset: 0x44d9
// Size: 0x2c6
function function_456345b11e49d982()
{
    self notify( #"hash_627266c59163af61" );
    self endon( #"hash_627266c59163af61" );
    self endon( #"disconnect", #"hash_e1ce4515826b49f" );
    self.ztron.camping_level = 0;
    
    if ( !isdefined( level.ztron.riserdef ) )
    {
        level.ztron.riserdef = ztron_enemy::function_96eea0d09d5640d1( "riser_zombie" );
    }
    
    if ( !isdefined( level.ztron.heavyarmordef ) )
    {
        level.ztron.heavyarmordef = ztron_enemy::function_96eea0d09d5640d1( "heavy_armored_zombie" );
    }
    
    validdefs = [];
    var_bed1ca724d5578b4 = 0;
    
    if ( level.ztron.var_eb927027004f4817 )
    {
        validdefs = level.ztron.var_eb927027004f4817;
        var_bed1ca724d5578b4 = 1;
    }
    
    if ( validdefs.size == 0 )
    {
        validdefs[ validdefs.size ] = level.ztron.riserdef;
        
        if ( arraycontains( level.ztron.var_6fdc39ee25e5365e, level.ztron.heavyarmordef ) )
        {
            validdefs[ validdefs.size ] = level.ztron.heavyarmordef;
        }
    }
    
    while ( true )
    {
        wait 1;
        self.ztron.camping_level++;
        self.ztron.camping_level %= 10;
        
        if ( self.ztron.camping_level == 0 )
        {
            enemydef = validdefs[ 0 ];
            
            if ( validdefs.size > 1 )
            {
                enemydef = validdefs[ randomint( validdefs.size ) ];
            }
            
            if ( var_bed1ca724d5578b4 )
            {
                var_4491d6c5a5d1f8c6 = 1;
            }
            else
            {
                var_4491d6c5a5d1f8c6 = randomintrange( 3, 7 );
            }
            
            while ( var_4491d6c5a5d1f8c6 )
            {
                level thread ztron_debug::draw_circle( self.ztron.campanchor + ( 0, 0, 24 ), 48, self.ztron.colorrgb, 1 );
                
                if ( var_bed1ca724d5578b4 )
                {
                    targetloc = self.ztron.campanchor;
                }
                else
                {
                    targetloc = ztron_util::function_78a5b128a3e32460( self.ztron.campanchor, 48, 12 );
                }
                
                ai = ztron_enemy::function_acee91c445fafd29( enemydef, targetloc, self, undefined, 1, 1, var_bed1ca724d5578b4 );
                
                if ( isdefined( ai ) )
                {
                    level.ztron.var_91517987ca332e2a++;
                }
                
                var_4491d6c5a5d1f8c6--;
                wait 0.1;
            }
        }
    }
}

// Namespace ztron_player_utility
// Params 0
// Checksum 0x6f80a961, Offset: 0x47a7
// Size: 0xd9
function function_e16c5064f5621594()
{
    if ( !( getdvarint( @"hash_8e9b11f2bb5de3e5", 1 ) == 1 ) )
    {
        return;
    }
    
    self endon( #"disconnect" );
    init_camp_simple();
    var_25dd4e268de51e17 = getdvarint( @"hash_727982273088a057", 3 );
    
    while ( true )
    {
        if ( level.players.size >= var_25dd4e268de51e17 )
        {
            var_e35c8d9038126255 = self.ztron.campactive;
            function_9f1f198495631ca6( 0.25 );
            
            if ( var_e35c8d9038126255 != self.ztron.campactive )
            {
                if ( self.ztron.campactive )
                {
                    thread function_456345b11e49d982();
                }
                else
                {
                    self notify( #"hash_e1ce4515826b49f" );
                }
            }
            
            wait 0.25;
            continue;
        }
        
        wait 4;
    }
}

// Namespace ztron_player_utility
// Params 0
// Checksum 0xa06e3667, Offset: 0x4888
// Size: 0x80, Type: bool
function is_ignored_state()
{
    if ( !isalive( self ) )
    {
        return true;
    }
    
    if ( self.ztron.inlaststand )
    {
        return true;
    }
    
    if ( ztron_main::function_4da200e9b8d58a3c() != 1 )
    {
        return true;
    }
    
    if ( !level utility::flag( "ztron_round_spawning" ) )
    {
        return true;
    }
    
    if ( level.ztron.roundnumber < 20 )
    {
        return true;
    }
    
    if ( isdefined( self.ztron.vehicle ) )
    {
        return true;
    }
    
    return false;
}

// Namespace ztron_player_utility
// Params 0
// Checksum 0x108649a6, Offset: 0x4911
// Size: 0x9d
function init_camp_simple()
{
    self.ztron.campactive = 0;
    self.ztron.campanchor = undefined;
    self.ztron.campcenter = undefined;
    self.ztron.var_1b40e19dbb2a63ad = 0;
    self.ztron.lastpos = self.origin;
    self.ztron.setcount = 0;
    self.ztron.var_45aa17741287f290 = 0;
}

// Namespace ztron_player_utility
// Params 1
// Checksum 0xb287ca0a, Offset: 0x49b6
// Size: 0x3d7
function function_9f1f198495631ca6( tickrate )
{
    profilestart();
    
    if ( is_ignored_state() )
    {
        if ( self.ztron.campactive )
        {
            init_camp_simple();
        }
        
        profilestop();
        return;
    }
    
    var_1f46953acc8a45ae = distance2dsquared( self.origin, self.ztron.lastpos );
    self.ztron.lastpos = self.origin;
    
    if ( !isdefined( self.ztron.campanchor ) )
    {
        self.ztron.campanchor = self.origin;
    }
    
    anchor = self.ztron.campanchor;
    var_9398d43294791384 = distance2dsquared( self.origin, anchor );
    
    if ( var_9398d43294791384 <= 10000 )
    {
        self.ztron.var_1b40e19dbb2a63ad += tickrate;
    }
    else if ( var_9398d43294791384 < 18496 )
    {
        self.ztron.var_1b40e19dbb2a63ad -= 1 * tickrate;
        
        if ( self.ztron.var_1b40e19dbb2a63ad < 0 )
        {
            self.ztron.var_1b40e19dbb2a63ad = 0;
        }
        
        if ( var_9398d43294791384 <= 15184 )
        {
            alpha = 0.05;
            var_b972901f5c17c1b = anchor[ 0 ] + alpha * ( self.origin[ 0 ] - anchor[ 0 ] );
            var_b972801f5c179e8 = anchor[ 1 ] + alpha * ( self.origin[ 1 ] - anchor[ 1 ] );
            self.ztron.campanchor = ( var_b972901f5c17c1b, var_b972801f5c179e8, 0 );
            anchor = self.ztron.campanchor;
        }
    }
    else
    {
        self.ztron.var_1b40e19dbb2a63ad = 0;
        self.ztron.campanchor = self.origin;
        anchor = self.ztron.campanchor;
    }
    
    shouldflag = self.ztron.var_1b40e19dbb2a63ad >= 30;
    
    if ( !self.ztron.campactive )
    {
        self.ztron.setcount = shouldflag ? self.ztron.setcount + 1 : 0;
        
        if ( self.ztron.setcount >= 3 )
        {
            self.ztron.campactive = 1;
            self.ztron.campcenter = anchor;
            self.ztron.var_45aa17741287f290 = 0;
            self.ztron.setcount = 0;
        }
    }
    else
    {
        var_61e8547bc4dea8a9 = distance2dsquared( self.origin, self.ztron.campcenter );
        clearnow = var_61e8547bc4dea8a9 >= 18496;
        self.ztron.var_45aa17741287f290 = clearnow ? self.ztron.var_45aa17741287f290 + 1 : 0;
        
        if ( self.ztron.var_45aa17741287f290 >= 3 )
        {
            init_camp_simple();
        }
    }
    
    profilestop();
}

