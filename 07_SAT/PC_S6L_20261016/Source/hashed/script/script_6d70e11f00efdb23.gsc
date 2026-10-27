// script_6d70e11f00efdb23  (hash_6d70e11f00efdb23.gscc) (size: 6611 Bytes / 0x19d3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x43ac3e29 (1135361577)
// size ...... 6611 (0x19d3)
// includes .. 7   (offset: 0x1823)
// strings ... 28  (offset: 0x185b)
// dev strs .. 1   (offset: 0x19c7)
// exports ... 13  (offset: 0xe7f)
// cseg ...... 0x27a + 0xc05 (0xe7f)
// imports ... 65  (offset: 0x1087)
// animtree1 . 0   (offset: 0x19d3)
// animtree2 . 0   (offset: 0x19d3)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace namespace_79797bf925a3b4e6;

// Namespace namespace_79797bf925a3b4e6
// Params 0, eflags: 0x5
// Checksum 0x171831be, Offset: 0x298
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_b442a5ee2fa20d25", #"ztron_item", undefined, &init );
}

// Namespace namespace_79797bf925a3b4e6
// Params 0
// Checksum 0xd2142a5b, Offset: 0x2c1
// Size: 0xa1
function init()
{
    ztron_item::function_5844a9c240f7dc8d( #"sentry_turret", #"use", &use_sentry_turret );
    ztron_item::function_5844a9c240f7dc8d( #"sam_turret", #"use", &use_sentry_turret );
    
    if ( !isdefined( level.var_44cdf5fee6853ac5 ) )
    {
        level.var_44cdf5fee6853ac5 = [];
    }
    
    level.var_44cdf5fee6853ac5[ level.var_44cdf5fee6853ac5.size ] = "sat_ztron_sam_turret_missile";
    utility::add_fx( "ztron_turret_impact", "vfx_sat_zm_turret_impact_ztron" );
    ztron_sound::function_4ac735395b173fe( "turret_impact_OS", "evt_ztron_pickup_sentry_land" );
    ztron_sound::function_4ac735395b173fe( "turret_takeoff_OS", "evt_ztron_pickup_sentry_takeoff" );
}

// Namespace namespace_79797bf925a3b4e6
// Params 1, eflags: 0x4
// Checksum 0x85b82b5d, Offset: 0x36a
// Size: 0x29b
function private use_sentry_turret( params )
{
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
    
    is_sam_turret = params.bundle.genericstring == #"sam_turret";
    owner = params.player;
    item = params.scriptable;
    spot = getgroundposition( owner.origin ?? item.origin, 1 );
    turret = spawnturret( "misc_turret", spot + ( 0, 0, 2000 ), "sat_ztron_sentry_turret" );
    
    if ( !isdefined( turret ) )
    {
        return;
    }
    
    if ( is_sam_turret )
    {
        turret ztron_sam_turret_setup( owner );
    }
    else
    {
        turret ztron_sentry_turret_setup( owner );
    }
    
    turret thread function_5fb341f3a6420c6d( owner );
    turret endon( #"death" );
    turret thread ztron_util::fakemoveto( spot, 0.5 );
    turret waittill( #"movedone" );
    ztron_sound::ztron_playsound( "turret_impact_OS", turret.origin );
    ztron_util::function_7e8b8153f3f2566( spot, 128, 200, owner );
    turret_impact_vfx = utility::getfx( "ztron_turret_impact" );
    playfxontag( turret_impact_vfx, turret, turret.origin_tag_name );
    playrumbleonposition( "grenade_rumble", spot );
    
    if ( isdefined( owner ) )
    {
        owner playrumbleonentity( "damage_heavy" );
        
        if ( is_sam_turret )
        {
            turret thread function_fafab36aefd91a2a();
        }
        else
        {
            turret thread function_b383f36733483baa();
        }
        
        if ( owner.ztron.upgradeMask & 256 )
        {
            turret.damage_multiplier = 1.75;
        }
        
        itemdata = ztron_item::function_998f2b10462afbf4( params.bundle );
        timeout = owner ztron_player_utility::function_10777122eee28fa8( itemdata.duration );
        level utility::waittill_any_timeout( timeout, "ztron_exit_taken", "ztron_teleporter_taken", "ztron_game_is_over", "round_over" );
    }
    
    ztron_sound::ztron_playsound( "turret_takeoff_OS", turret.origin );
    turret notify( #"all_done" );
    turret thread ztron_util::fakemoveto( turret.origin + ( 0, 0, 2200 ), 1 );
    turret waittill( #"movedone" );
    
    if ( turret.targetentity )
    {
        turret.targetentity delete();
    }
    
    turret delete();
}

// Namespace namespace_79797bf925a3b4e6
// Params 1, eflags: 0x4
// Checksum 0xf7bde0d7, Offset: 0x60d
// Size: 0x65
function private function_5fb341f3a6420c6d( owner )
{
    owner endon( #"disconnect" );
    wait 0.1;
    
    if ( !isdefined( owner ) )
    {
        return;
    }
    
    playertrail = utility::getfx( "ztron_player_trail_" + owner.ztron.color );
    playfxontag( playertrail, self, self.origin_tag_name );
}

// Namespace namespace_79797bf925a3b4e6
// Params 1, eflags: 0x4
// Checksum 0xbd284241, Offset: 0x67a
// Size: 0x1ac
function private ztron_sentry_turret_setup( owner )
{
    self.angles = ( 0, 0, 0 );
    self.health = 9999;
    self.maxhealth = 9999;
    self.ammocount = 9999;
    self.timeout = 9999;
    self.momentum = 0;
    self.heatlevel = 0;
    self.overheated = 0;
    self.cooldownwaittime = 0.1;
    self.sentrytype = "ai_sentry_turret";
    self.origin_tag_name = "tag_origin";
    self.owner = owner;
    self.owningteam = owner.team;
    self.team = owner.team;
    self setmodel( "ztron_sentry_turret" );
    self setturretteam( self.owningteam );
    self setcandamage( 0 );
    self makeunusable();
    self setnodeploy( 1 );
    self setdefaultdroppitch( 0 );
    self setautorotationdelay( 0.5 );
    self maketurretinoperable();
    self.leftarc = 180;
    self setleftarc( self.leftarc );
    self.rightarc = 180;
    self setrightarc( self.rightarc );
    self setbottomarc( 180 );
    self settoparc( 180 );
    self setconvergencetime( 0.5, "pitch" );
    self setconvergencetime( 0.5, "yaw" );
    self setconvergenceheightpercent( 0.9 );
    self setdefaultdroppitch( -89 );
    self setturretmodechangewait( 1 );
    self.turreton = 1;
    self setmode( "sentry" );
}

// Namespace namespace_79797bf925a3b4e6
// Params 0, eflags: 0x4
// Checksum 0xbbcccdd, Offset: 0x82e
// Size: 0x142
function private function_b383f36733483baa()
{
    level endon( #"ztron_game_is_over" );
    self endon( #"death", #"all_done" );
    
    while ( self.health > 0 )
    {
        distsq = undefined;
        
        if ( isdefined( self.favoriteenemy ) )
        {
            distsq = distancesquared( self.origin, self.favoriteenemy.origin );
        }
        
        if ( !isdefined( distsq ) || distsq > squared( 200 ) )
        {
            lastenemy = self.favoriteenemy;
            
            if ( isdefined( self.owner ) && distancesquared( self.origin, self.owner.origin ) < squared( 700 ) )
            {
                self.favoriteenemy = self.owner ztron_util::function_93f43b1536a8b155();
            }
            else
            {
                self.favoriteenemy = ztron_util::function_93f43b1536a8b155();
            }
        }
        
        if ( lastenemy != self.favoriteenemy )
        {
            self.var_ffde1a5e6b7cd833 = 0;
            self.var_977d6144ec8b6495 = 0;
        }
        
        if ( !isdefined( self.favoriteenemy ) )
        {
            wait 1;
        }
        else
        {
            function_2bfab5ef8fce97f8( self.favoriteenemy );
        }
        
        waitframe();
    }
}

// Namespace namespace_79797bf925a3b4e6
// Params 1, eflags: 0x4
// Checksum 0xae4e505a, Offset: 0x978
// Size: 0x172
function private function_2bfab5ef8fce97f8( target )
{
    while ( self.turreton && !self.stopfiring && isdefined( target ) )
    {
        self settargetentity( target );
        self.momentum = 1.5;
        firetime = weaponfiretime( "sat_ztron_sentry_turret" );
        currenttime = 0;
        
        for ( istargetalive = 1; self.turreton && !self.stopfiring && currenttime < 4 && istargetalive ; istargetalive = isalive( target ) )
        {
            numshots = randomintrange( 20, 31 );
            
            for ( i = 0; i < numshots && !self.overheated ; i++ )
            {
                if ( !self.turreton || self.stopfiring )
                {
                    break;
                }
                
                target = self getturrettarget( 1 );
                
                if ( !isdefined( target ) )
                {
                    break;
                }
                
                self shootturret( "tag_flash", 6 );
                wait firetime;
                currenttime += firetime;
            }
            
            if ( !self.turreton || self.stopfiring )
            {
                break;
            }
            
            randwait = randomfloatrange( 0.15, 0.35 );
            wait randwait;
            currenttime += randwait;
        }
        
        self.momentum = 0;
        self cleartargetentity();
    }
}

// Namespace namespace_79797bf925a3b4e6
// Params 1, eflags: 0x4
// Checksum 0x4e7159b, Offset: 0xaf2
// Size: 0xf1
function private ztron_sam_turret_setup( owner )
{
    self setmodel( "ztron_sam_turret" );
    self settoparc( 360 );
    self setbottomarc( 360 );
    self setleftarc( 360 );
    self setrightarc( 360 );
    self setconvergencetime( 0.5, "pitch" );
    self setconvergencetime( 0.5, "yaw" );
    self setconvergenceheightpercent( 0.9 );
    self maketurretinoperable();
    self.owner = owner;
    self.owningteam = owner.team;
    self setturretteam( owner.team );
    self.origin_tag_name = "tag_turret";
    self.targetentity = spawn( "script_model", self.origin + anglestoforward( self.angles ) * 1000 );
    self settargetentity( self.targetentity );
    self setmode( "manual" );
}

// Namespace namespace_79797bf925a3b4e6
// Params 0, eflags: 0x4
// Checksum 0xb5553e54, Offset: 0xbeb
// Size: 0xb6
function private function_fafab36aefd91a2a()
{
    if ( !isdefined( self.owner ) )
    {
        return;
    }
    
    level endon( #"ztron_game_is_over" );
    self endon( #"death", #"all_done" );
    self.owner endon( #"death_or_disconnect" );
    
    while ( self.health > 0 )
    {
        if ( isdefined( self.owner ) )
        {
            self.favoriteenemy = self.owner ztron_util::function_93f43b1536a8b155();
        }
        else
        {
            self.favoriteenemy = ztron_util::function_93f43b1536a8b155();
        }
        
        if ( !isalive( self.favoriteenemy ) )
        {
            wait 1;
        }
        else
        {
            function_a0a3a009ab7b5278( self.favoriteenemy );
        }
        
        waitframe();
    }
}

// Namespace namespace_79797bf925a3b4e6
// Params 1, eflags: 0x4
// Checksum 0xd4bfea65, Offset: 0xca9
// Size: 0xb1
function private function_a0a3a009ab7b5278( target )
{
    timer = 0;
    real_fire_time = 2;
    self.targetentity.origin = ( target.origin + self.origin ) * 0.5 + ( 0, 0, 1000 );
    
    while ( timer < real_fire_time )
    {
        if ( !isdefined( target ) )
        {
            return;
        }
        
        thread ztron_sam_turret_fire_missile( target.origin );
        random_interval = randomfloatrange( 0.4, 0.8 );
        timer += random_interval;
        wait random_interval;
    }
    
    wait 4 - real_fire_time;
}

// Namespace namespace_79797bf925a3b4e6
// Params 1, eflags: 0x4
// Checksum 0xa3867ce4, Offset: 0xd62
// Size: 0xd9
function private ztron_sam_turret_fire_missile( target_pos )
{
    fakefireweapon = makeweapon( "sat_ztron_sam_turret_missile" );
    tag_name = "tag_fx_0" + randomintrange( 1, 8 );
    var_eb1f96c921ef5095 = self gettagorigin( tag_name );
    proj = weapon_utility::_magicbullet( fakefireweapon, var_eb1f96c921ef5095, self.targetentity.origin, self.owner );
    wait randomfloatrange( 0.5, 0.8 );
    
    if ( isdefined( proj ) )
    {
        proj.damage_multiplier = self.damage_multiplier;
        pos_offset = ( randomintrange( -50, 50 ), randomintrange( -50, 50 ), -5 );
        proj missile_settargetpos( target_pos + pos_offset );
        
        /#
            function_a582a1d6c21565e4( target_pos + pos_offset );
        #/
    }
}

/#

    // Namespace namespace_79797bf925a3b4e6
    // Params 1, eflags: 0x4
    // Checksum 0xe2e8596f, Offset: 0xe43
    // Size: 0x3c, Type: dev
    function private function_a582a1d6c21565e4( target_pos )
    {
        if ( getdvarint( @"scr_ztron_sam_turret_debug", 0 ) == 0 )
        {
            return;
        }
        
        sphere( target_pos, 20, ( 1, 0, 0 ), 0, 240 );
    }

#/
