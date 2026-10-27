// script_639a25a0602c801d  (hash_639a25a0602c801d.gscc) (size: 4668 Bytes / 0x123c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x228bdd5c (579591516)
// size ...... 4668 (0x123c)
// includes .. 10  (offset: 0x1100)
// strings ... 18  (offset: 0x1150)
// dev strs .. 0   (offset: 0x123c)
// exports ... 11  (offset: 0xa40)
// cseg ...... 0x189 + 0x8b7 (0xa40)
// imports ... 45  (offset: 0xbf8)
// animtree1 . 0   (offset: 0x123c)
// animtree2 . 0   (offset: 0x123c)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\vortex;
#using scripts\mp\zm\zm_utility;
#using scripts\mp\zm\ztron\ztron_debug;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace namespace_7bb96b83b3187b08;

// Namespace namespace_7bb96b83b3187b08
// Params 0, eflags: 0x5
// Checksum 0xfa6b584d, Offset: 0x1a7
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_df18bdb986139a1d", #"ztron_item", undefined, &init );
}

// Namespace namespace_7bb96b83b3187b08
// Params 0
// Checksum 0x981a4d, Offset: 0x1d0
// Size: 0x43
function init()
{
    ztron_item::function_5844a9c240f7dc8d( #"vortex", #"use", &usevortex );
    level callback::add( "on_zombie_ai_killed", &function_6ed4bb386145f46 );
    ztron_sound::function_4ac735395b173fe( "vortex_zombie_squish_OS", "evt_ai_zombie_annihilate" );
}

// Namespace namespace_7bb96b83b3187b08
// Params 1, eflags: 0x4
// Checksum 0x8bbd5ca, Offset: 0x21b
// Size: 0x16
function private usevortex( params )
{
    level thread createvortex( params );
}

// Namespace namespace_7bb96b83b3187b08
// Params 1, eflags: 0x4
// Checksum 0x1f868707, Offset: 0x239
// Size: 0x1fd
function private createvortex( params )
{
    player = params.player;
    item = params.scriptable;
    hitp = ztron_util::function_3fe38741460a4a49( item.origin );
    origin = ( item.origin[ 0 ], item.origin[ 1 ], hitp[ 2 ] + 12 );
    scriptable = spawnscriptable( "ztron_vortex", origin );
    vortex = utility::spawn_model( "tag_origin", origin );
    waitframe();
    scriptable scriptablesetparententity( vortex );
    itemdata = ztron_item::function_998f2b10462afbf4( params.bundle );
    vortex.scriptable = scriptable;
    vortex.ztronitemtype = #"vortex";
    vortex.owner = player;
    vortex.duration = itemdata.duration;
    vortex.deathrange = 60;
    vortex.dragrange = 245;
    vortex.triggerheight = 60;
    vortex.gemscale = 1;
    vortex.navmeshorigin = getclosestpointonnavmesh( origin );
    
    if ( player.ztron.upgradeMask & 65536 )
    {
        vortex.dragrange *= 2;
        vortex.gemscale *= 2;
    }
    
    vortex.trigger = spawn( "trigger_radius", vortex.origin, 0, vortex.deathrange, vortex.triggerheight );
    vortex thread vortexthink();
    vortex thread function_c7ec739aaf7d3e16();
}

// Namespace namespace_7bb96b83b3187b08
// Params 4, eflags: 0x4
// Checksum 0x357bd1ab, Offset: 0x43e
// Size: 0xc7
function private function_da7d8cf7876036b5( origin, numitems, offset = 256, scale = 1 )
{
    if ( !isdefined( params ) )
    {
        params = spawnstruct();
    }
    
    if ( !isdefined( params.launchforce ) )
    {
        params.launchforce = ( randomintrange( -10, 10 ), randomintrange( -10, 10 ), 400 );
    }
    
    params.scale = scale;
    itembundlename = level.ztron.gembundles[ "ztron_gem_red" ];
    
    while ( numitems )
    {
        ztron_item::requestspawnitem( itembundlename, origin, offset, undefined, params );
        numitems--;
    }
}

// Namespace namespace_7bb96b83b3187b08
// Params 1
// Checksum 0xfdbd8c5b, Offset: 0x50d
// Size: 0x86
function function_6ed4bb386145f46( params )
{
    einflictor = params.einflictor;
    
    if ( einflictor.ztronitemtype === #"vortex" )
    {
        function_da7d8cf7876036b5( self.origin + ( 0, 0, 100 ), 1, einflictor.deathrange, einflictor.gemscale );
        ztron_sound::ztron_playsound( "vortex_zombie_squish_OS", self.origin );
    }
}

// Namespace namespace_7bb96b83b3187b08
// Params 0, eflags: 0x4
// Checksum 0x3e0e0907, Offset: 0x59b
// Size: 0x25e
function private vortexthink()
{
    self endon( #"death" );
    self endon( #"vortex_clear" );
    self.pulledzombies = [];
    
    if ( !isdefined( self.owner ) )
    {
        waittillframeend();
        self notify( #"vortex_clear" );
        return;
    }
    
    self.scriptable setscriptablepartstate( "vortex", "activated" );
    endtime = gettime() + self.owner ztron_player_utility::function_10777122eee28fa8( self.duration * 1000 );
    var_8452b0144229a980 = { #mode:"blackhole", #height:self.triggerheight };
    
    /#
        thread debugdraw();
    #/
    
    while ( endtime > gettime() )
    {
        affectedzombies = getaiarrayinradius( self.origin, self.dragrange, zm_utility::get_zombie_team() );
        self.pulledzombies = function_46f9072493651dc9( self.pulledzombies );
        
        foreach ( zombie in affectedzombies )
        {
            if ( !isalive( zombie ) )
            {
                continue;
            }
            
            test_origin = zombie getcentroid();
            dist_check_sq = distancesquared( self.origin, test_origin );
            
            if ( zombie.aicategory == "normal" )
            {
                if ( zombie istouching( self.trigger ) )
                {
                    zombie.forceannihilate = 1;
                    zombie kill( self.origin, self.owner, self, "MOD_CRUSH" );
                    continue;
                }
                
                if ( !arraycontains( self.pulledzombies, zombie ) )
                {
                    zombie vortex::set_vortex_state( "blackhole", self.scriptable, self.navmeshorigin, self.deathrange, var_8452b0144229a980 );
                    self.pulledzombies[ self.pulledzombies.size ] = zombie;
                }
            }
        }
        
        wait 0.2;
    }
    
    waittillframeend();
    self notify( #"vortex_clear" );
}

// Namespace namespace_7bb96b83b3187b08
// Params 0, eflags: 0xc
// Checksum 0x1b889fd8, Offset: 0x801
// Size: 0x13e
function private function_c7ec739aaf7d3e16()
{
    self notify( #"hash_edab41fdeba6761f" );
    self endon( #"hash_edab41fdeba6761f" );
    thread watcharena();
    self waittill( #"vortex_clear" );
    self.scriptable setscriptablepartstate( "vortex", "implode" );
    self.pulledzombies = function_46f9072493651dc9( self.pulledzombies );
    
    foreach ( zombie in self.pulledzombies )
    {
        zombie vortex::clear_vortex_state( "blackhole", self.scriptable );
    }
    
    self.pulledzombies = [];
    wait 7;
    self.scriptable setscriptablepartstate( "vortex", "hidden" );
    self.trigger delete();
    self.trigger = undefined;
    self.scriptable freescriptable();
    self.scriptable = undefined;
    self delete();
}

// Namespace namespace_7bb96b83b3187b08
// Params 0, eflags: 0xc
// Checksum 0x999eb83e, Offset: 0x947
// Size: 0x4e
function private watcharena()
{
    self notify( #"hash_b959f58a0a53197d" );
    self endon( #"hash_b959f58a0a53197d" );
    self endon( #"vortex_clear" );
    level utility::waittill_any( "round_over", "ztron_exit_taken", "ztron_teleporter_taken", "ztron_game_is_over" );
    self notify( #"vortex_clear" );
}

/#

    // Namespace namespace_7bb96b83b3187b08
    // Params 0, eflags: 0x4
    // Checksum 0x10ce863d, Offset: 0x99d
    // Size: 0xa3, Type: dev
    function private debugdraw()
    {
        self endon( #"death" );
        self endon( #"vortex_clear" );
        is_enabled = getdvarint( @"scr_debug_ztron_vortex", 0 );
        
        while ( is_enabled )
        {
            drawtrigger( self.trigger, ( 1, 0, 0 ), 0, 0, 0, ( 1, 0, 0 ) );
            thread ztron_debug::drawcylinder( self.origin, self.dragrange, self.triggerheight, level.framedurationseconds, ( 1, 1, 0 ) );
            waitframe();
        }
    }

#/
