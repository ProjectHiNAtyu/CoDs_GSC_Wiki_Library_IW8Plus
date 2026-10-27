// scripts\common\ai\aitypes\shared\zombie\zombie_cannonball.gsc  (hash_4fb6443fcc3b4f97.gscc) (size: 2793 Bytes / 0xae9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2f1dd3e4 (790483940)
// size ...... 2793 (0xae9)
// includes .. 3   (offset: 0xa49)
// strings ... 8   (offset: 0xa61)
// dev strs .. 1   (offset: 0xadd)
// exports ... 10  (offset: 0x5dd)
// cseg ...... 0xcf + 0x50e (0x5dd)
// imports ... 26  (offset: 0x76d)
// animtree1 . 0   (offset: 0xae9)
// animtree2 . 0   (offset: 0xae9)
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_traverse;
#using scripts\common\utility;

#namespace zombie_cannonball;

// Namespace zombie_cannonball
// Params 0, eflags: 0x5
// Checksum 0xbab26885, Offset: 0xed
// Size: 0x20
function private autoexec init()
{
    utility::registersharedfunc( #"zombie", #"cannonballzombie", &cannonball_ai );
}

// Namespace zombie_cannonball
// Params 4
// Checksum 0x24ed9349, Offset: 0x115
// Size: 0x218, Type: bool
function cannonball_ai( var_2501b9aef17e35f9, launch_magnitude = 300, settings, var_4dd9c210b998e030 = "default" )
{
    if ( !isalive( self ) || !isai( self ) )
    {
        return false;
    }
    
    if ( self.disallow_cannonball || self.disallow_knockdown )
    {
        return false;
    }
    
    if ( !( isdefined( var_2501b9aef17e35f9 ) && isdefined( launch_magnitude ) ) )
    {
        return false;
    }
    
    var_caa67496e8434636 = self findoverridearchetype( "animscript" );
    
    if ( isdefined( var_caa67496e8434636 ) && var_caa67496e8434636 != self getbasearchetype() )
    {
        return false;
    }
    
    if ( zombie_traverse::is_traversing() )
    {
        return false;
    }
    
    if ( !function_9c6cc815e69389cd() )
    {
        return false;
    }
    
    if ( !isdefined( var_4dd9c210b998e030 ) )
    {
        var_4dd9c210b998e030 = "default";
    }
    
    self function_695b8e1b655c2796( "cannonball", var_4dd9c210b998e030 );
    launch_vec = vectornormalize( var_2501b9aef17e35f9 ) * launch_magnitude;
    default_settings = adv_settings();
    
    if ( !isdefined( settings ) )
    {
        settings = default_settings;
    }
    
    self._blackboard.var_b6a894e28098cb2c = launch_vec;
    self._blackboard.var_a78d00bc500c9142 = settings.gravity_scalar ?? default_settings.gravity_scalar;
    self._blackboard.var_7f10cc358db1d109 = settings.var_56bf017a61a8b3f2 ?? default_settings.var_56bf017a61a8b3f2;
    self._blackboard.var_b11edfed122e3043 = settings.facing_source ?? default_settings.facing_source;
    self._blackboard.var_b7e5685c3aeaa25a = settings.var_90390ae034d0dd6c ?? default_settings.var_90390ae034d0dd6c;
    
    if ( isdefined( settings.ignore_ents ) )
    {
        self function_f82a07bd6a453e48( settings.ignore_ents );
    }
    
    self animmode( "noclip" );
    asm::function_7256f5ba459c840b( "cannonball_in" );
    thread function_86c3df436d85b1f1( undefined, settings.var_c83cbcdc64328a4e );
    return true;
}

// Namespace zombie_cannonball
// Params 6
// Checksum 0xb8ec7ea1, Offset: 0x336
// Size: 0xbb
function adv_settings( gravity_scalar, var_56bf017a61a8b3f2, facing_source, var_90390ae034d0dd6c, ignore_ents, var_c83cbcdc64328a4e )
{
    settings = spawnstruct();
    settings.gravity_scalar = gravity_scalar ?? 1;
    settings.var_56bf017a61a8b3f2 = var_56bf017a61a8b3f2 ?? 0;
    settings.facing_source = facing_source ?? 1;
    settings.var_90390ae034d0dd6c = var_90390ae034d0dd6c ?? 0;
    settings.var_c83cbcdc64328a4e = var_c83cbcdc64328a4e ?? 0;
    
    if ( isdefined( ignore_ents ) )
    {
        settings.ignore_ents = ignore_ents;
    }
    
    return settings;
}

// Namespace zombie_cannonball
// Params 1
// Checksum 0x58755ec6, Offset: 0x3fa
// Size: 0x17
function function_c47b4675a71d8167( func )
{
    self.cannonball_failsafe_func = func;
}

// Namespace zombie_cannonball
// Params 1
// Checksum 0x683f9bf6, Offset: 0x419
// Size: 0x26
function set_callback_hit_wall( func )
{
    thread utility::thread_on_notify( "hit_wall", func, self, self, [ "cannonball_end" ] );
}

// Namespace zombie_cannonball
// Params 1
// Checksum 0x7eb60a81, Offset: 0x447
// Size: 0x1b
function set_callback_on_end( func )
{
    thread utility::thread_on_notify( "cannonball_end", func, self );
}

// Namespace zombie_cannonball
// Params 0
// Checksum 0xfd3df780, Offset: 0x46a
// Size: 0x16, Type: bool
function function_aa1319badace3306()
{
    return istrue( self._blackboard.var_5c6f406c1ffc2b5c );
}

// Namespace zombie_cannonball
// Params 0
// Checksum 0xd30c2e6, Offset: 0x489
// Size: 0x15
function function_9c6cc815e69389cd()
{
    return self asmhasstate( self.asmname, "cannonball_in" );
}

// Namespace zombie_cannonball
// Params 2, eflags: 0xc
// Checksum 0x937ddd74, Offset: 0x4a7
// Size: 0x136
function private function_86c3df436d85b1f1( func, var_c83cbcdc64328a4e )
{
    self notify( #"hash_833e27d7333187b9" );
    self endon( #"hash_833e27d7333187b9" );
    self endon( #"death" );
    self endon( #"cannonball_end" );
    
    if ( func )
    {
        self.cannonball_failsafe_func = func;
    }
    
    self waittill( #"cannonball_start" );
    msg = utility::waittill_any_return( "cannonball_failsafe", "cannonball_end" );
    
    if ( msg == "cannonball_failsafe" )
    {
        assert( msg + "<dev string:x24>" );
        
        if ( isdefined( self.cannonball_failsafe_func ) )
        {
            [[ self.cannonball_failsafe_func ]]();
        }
        else
        {
            closest_navmesh_point = getclosestpointonnavmesh( self.origin );
            self forceteleport( closest_navmesh_point, self.angles, 10, 1 );
        }
        
        return;
    }
    
    if ( msg == "cannonball_end" && var_c83cbcdc64328a4e != 0 )
    {
        closest_navmesh_point = getclosestpointonnavmesh( self.origin );
        
        if ( distancesquared( self.origin, closest_navmesh_point ) > squared( var_c83cbcdc64328a4e ) )
        {
            self.death_source = "cannonball_failsafe";
            self kill();
        }
    }
}

