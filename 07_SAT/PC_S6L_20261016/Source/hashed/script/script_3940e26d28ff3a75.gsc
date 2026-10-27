// script_3940e26d28ff3a75  (hash_3940e26d28ff3a75.gscc) (size: 4266 Bytes / 0x10aa / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd79e4d17 (3617475863)
// size ...... 4266 (0x10aa)
// includes .. 10  (offset: 0xf52)
// strings ... 20  (offset: 0xfa2)
// dev strs .. 0   (offset: 0x10aa)
// exports ... 8   (offset: 0x8ae)
// cseg ...... 0x227 + 0x687 (0x8ae)
// imports ... 48  (offset: 0x9ee)
// animtree1 . 0   (offset: 0x10aa)
// animtree2 . 0   (offset: 0x10aa)
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\zombie_base\zombie_base_dismemberment;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;
#using scripts\mp\zm\ztron\ztron_vfx;

#namespace namespace_8898f05447e219f9;

// Namespace namespace_8898f05447e219f9
// Params 0, eflags: 0x5
// Checksum 0x574a3c17, Offset: 0x245
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_213b72f521eeab55", #"ztron_item", undefined, &init );
}

// Namespace namespace_8898f05447e219f9
// Params 0
// Checksum 0x4be9d8c0, Offset: 0x26e
// Size: 0x64
function init()
{
    ztron_item::function_5844a9c240f7dc8d( #"air_horn", #"use", &useairhorn );
    utility::add_fx( "ztron_air_horn", "vfx_sat_zm_air_horn_shock_ztron" );
    utility::add_fx( "ztron_air_horn_fade", "vfx_sat_zm_air_horn_shock_fade_ztron" );
    utility::add_fx( "ztron_air_horn_contact", "vfx_sat_zm_air_horn_shock_imp_ztron" );
    ztron_sound::function_4ac735395b173fe( "airhorn_blast_OS", "evt_ztron_pickup_airhorn_shockwave" );
}

// Namespace namespace_8898f05447e219f9
// Params 2
// Checksum 0x72879d46, Offset: 0x2da
// Size: 0x13b
function function_14c306bcc0c9e83f( parent, origin )
{
    if ( !isdefined( parent ) )
    {
        if ( !isdefined( origin ) )
        {
            return;
        }
        
        parent = spawn( "script_model", origin );
        parent setmodel( "tag_origin" );
        parent thread ztron_util::function_ea0a0be5c5468c48( 1 );
    }
    
    parent endon( #"death" );
    trigger = spawn( "trigger_radius", parent.origin, 9, 245, 60 );
    
    if ( !isdefined( trigger ) )
    {
        return;
    }
    
    trigger thread ztron_util::function_f7544bfa701db406( parent );
    trigger.targetname = "air_hornTrigger";
    trigger enablelinkto();
    trigger linkto( parent );
    trigger.opentime = 300;
    trigger.openfull = gettime() + trigger.opentime;
    trigger.radius = 245;
    
    /#
        trigger thread air_horn_debug();
    #/
    
    playfxontag( utility::getfx( "concussion_explo" ), parent, "tag_origin" );
    trigger thread generateshockwave();
    wait 0.25;
    physicsexplosionsphere( trigger.origin, 200, 64, 100 );
    wait 0.25;
    trigger delete();
}

// Namespace namespace_8898f05447e219f9
// Params 1, eflags: 0x4
// Checksum 0xf708d869, Offset: 0x41d
// Size: 0x150
function private useairhorn( params )
{
    player = params.player;
    item = params.scriptable;
    hitp = ztron_util::function_3fe38741460a4a49( item.origin );
    origin = ( item.origin[ 0 ], item.origin[ 1 ], hitp[ 2 ] + 12 );
    air_horn = utility::spawn_model( "sat_zm_ztron_props_boat_horn", origin );
    air_horn.targetname = "air_horn";
    air_horn thread ztron_util::function_b59665f20a2dbee( 0.6, 0 );
    timetowait = player ztron_player_utility::function_10777122eee28fa8( 20 );
    activeuntil = gettime() + timetowait * 1000;
    
    while ( gettime() < activeuntil )
    {
        level thread function_14c306bcc0c9e83f( air_horn );
        ztron_sound::ztron_playsound( "airhorn_blast_OS", air_horn.origin );
        msg = level utility::waittill_any_timeout( 3, "ztron_exit_taken", "ztron_teleporter_taken", "ztron_game_is_over", "round_over" );
        
        if ( msg != "timeout" )
        {
            break;
        }
    }
    
    if ( isdefined( air_horn ) )
    {
        air_horn delete();
    }
}

// Namespace namespace_8898f05447e219f9
// Params 0, eflags: 0x4
// Checksum 0x21ac40e2, Offset: 0x575
// Size: 0x16c
function private generateshockwave()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"trigger", guy );
        
        if ( !isagent( guy ) )
        {
            continue;
        }
        
        if ( guy.knockdowned )
        {
            continue;
        }
        
        if ( guy.disallow_knockdown || guy.ztron.boss )
        {
            continue;
        }
        
        if ( !isalive( guy ) || guy.health <= 0 )
        {
            continue;
        }
        
        if ( !guy zombie_knockdown::function_2eb6752428726543() || guy zombie_knockdown::function_19d6107cb6bdff5c() )
        {
            continue;
        }
        
        if ( ai::is_doing_traversal( guy ) )
        {
            continue;
        }
        
        if ( guy isragdoll() )
        {
            continue;
        }
        
        if ( isdefined( self.openfull ) )
        {
            time = gettime();
            
            if ( time < self.openfull )
            {
                dist = distance( guy.origin, self.origin );
                frac = dist / self.radius;
                diff = time - self.birthtime;
                dfrac = diff / self.opentime;
                
                if ( frac > dfrac )
                {
                    continue;
                }
            }
        }
        
        guy thread knockdown( self );
    }
}

// Namespace namespace_8898f05447e219f9
// Params 1, eflags: 0xc
// Checksum 0x7ed2a732, Offset: 0x6e9
// Size: 0xfc
function private knockdown( trigger )
{
    self notify( #"hash_ef91d3f8ed913059" );
    self endon( #"hash_ef91d3f8ed913059" );
    self endon( #"death" );
    self.knockdowned = 1;
    ztron_vfx::function_a2884eba34f8ea6b( utility::getfx( "ztron_air_horn_contact" ), self, "tag_origin" );
    
    if ( namespace_b76ff2659823e89d::is_crawling() )
    {
        dir = vectornormalize( self.origin - trigger.origin );
        thread ztron_util::function_afa1f6a404783c8a( dir, 4000 );
    }
    else
    {
        zombie_knockdown::function_6fc167d4a3590991( trigger.origin, 350, 60 );
    }
    
    while ( isalive( self ) && isdefined( trigger ) && self istouching( trigger ) && zombie_knockdown::function_19d6107cb6bdff5c() )
    {
        wait 0.5;
    }
    
    ztron_vfx::aistopfxontag( utility::getfx( "ztron_air_horn_contact" ), self, "tag_origin" );
    wait 0.75;
    self.knockdowned = undefined;
}

/#

    // Namespace namespace_8898f05447e219f9
    // Params 0
    // Checksum 0x37e4a461, Offset: 0x7ed
    // Size: 0xc1, Type: dev
    function air_horn_debug()
    {
        self endon( #"death" );
        
        while ( true )
        {
            if ( getdvarint( @"scr_debug_ztron_air_horn", 0 ) )
            {
                drawtrigger( self, ( 1, 0, 0 ), 0, 0, 0, ( 1, 0, 0 ) );
                deltatime = gettime() - self.birthtime;
                timefrac = deltatime / self.opentime;
                radius = min( self.radius, timefrac * self.radius );
                sphere( self.origin, radius, ( 0, 1, 0 ), 0, 1 );
            }
            
            waitframe();
        }
    }

#/
