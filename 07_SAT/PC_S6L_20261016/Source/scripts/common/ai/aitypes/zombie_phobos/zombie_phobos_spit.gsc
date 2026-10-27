// scripts\common\ai\aitypes\zombie_phobos\zombie_phobos_spit.gsc  (hash_6cff0e2cbf0ff341.gscc) (size: 3114 Bytes / 0xc2a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf93475d7 (4180964823)
// size ...... 3114 (0xc2a)
// includes .. 6   (offset: 0xbc6)
// strings ... 3   (offset: 0xbf6)
// dev strs .. 1   (offset: 0xc1e)
// exports ... 16  (offset: 0x686)
// cseg ...... 0xa5 + 0x5e1 (0x686)
// imports ... 24  (offset: 0x906)
// animtree1 . 0   (offset: 0xc2a)
// animtree2 . 0   (offset: 0xc2a)
#using script_1b934ce5a518748;
#using scripts\common\ai\aitypes\shared\zombie\zombie_toxic_gas;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\utility;

#namespace zombie_phobos_spit;

// Namespace zombie_phobos_spit
// Params 1
// Checksum 0x82e26d15, Offset: 0xc3
// Size: 0xc
function function_e2f06c2d94b763ef( var_4b4d72d84afd1ebd )
{
    
}

/#

    // Namespace zombie_phobos_spit
    // Params 0
    // Checksum 0x99e2066a, Offset: 0xd7
    // Size: 0xc, Type: dev
    function function_54867ff0ab30fc90()
    {
        setup_spit_devgui();
    }

#/

// Namespace zombie_phobos_spit
// Params 0
// Checksum 0xb563559a, Offset: 0xeb
// Size: 0xc6
function init_zombie_phobos_spit()
{
    self._blackboard.var_3c7d7ae944556d92 = int( self.var_d6894f01a36b4ff3.var_26c04115883926d8 * 1000 );
    self._blackboard.var_3c5a84e9442f3bd8 = int( self.var_d6894f01a36b4ff3.var_26e35715885f9ef2 * 1000 );
    self._blackboard.var_d751dec818290f98 = self.var_d6894f01a36b4ff3.var_9d909c03fc59c1b1;
    self.var_f744e8be8b657e6e = [];
    level callback::add( "zombie_toxic_gas_spawned", &on_zombie_toxic_gas_spawned, { #phobos:self } );
    callback::add( "on_zombie_ai_killed", &function_c6b1e85e584ae2ed );
    thread spit_listener();
}

// Namespace zombie_phobos_spit
// Params 1, eflags: 0x4
// Checksum 0x26065457, Offset: 0x1b9
// Size: 0x1e
function private function_c6b1e85e584ae2ed( params )
{
    level callback::remove( "zombie_toxic_gas_spawned", &on_zombie_toxic_gas_spawned );
}

// Namespace zombie_phobos_spit
// Params 0, eflags: 0x4
// Checksum 0x74b25fdf, Offset: 0x1df
// Size: 0x16
function private on_spit()
{
    self.spit_start_time = gettime();
    namespace_5d8c8e7c63b470d5::function_57593f2c96dd64bc();
}

// Namespace zombie_phobos_spit
// Params 0, eflags: 0x4
// Checksum 0xaeae3291, Offset: 0x1fd
// Size: 0x2a
function private spit_listener()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"ranged_attack_enemy_start" );
        thread on_spit();
    }
}

// Namespace zombie_phobos_spit
// Params 2, eflags: 0x4
// Checksum 0xa6284181, Offset: 0x22f
// Size: 0x44
function private on_zombie_toxic_gas_spawned( params, additional_params )
{
    if ( isalive( additional_params.phobos ) )
    {
        function_8dbc64d864b193e5( additional_params.phobos, params.toxic_gas );
    }
}

// Namespace zombie_phobos_spit
// Params 2
// Checksum 0x5e37da68, Offset: 0x27b
// Size: 0xfd
function function_8dbc64d864b193e5( phobos, toxic_gas )
{
    phobos.var_f744e8be8b657e6e = function_5713d46873b29625( phobos.var_f744e8be8b657e6e );
    
    if ( phobos.var_f744e8be8b657e6e.size > 15 )
    {
        oldest_toxic_gas = undefined;
        var_856158daa1034524 = undefined;
        toxic_i = 0;
        
        while ( toxic_i < phobos.var_f744e8be8b657e6e.size )
        {
            Gas = phobos.var_f744e8be8b657e6e[ toxic_i ];
            
            if ( !Gas.var_de80f1299517bfab && ( !isdefined( var_856158daa1034524 ) || Gas.birthtime < var_856158daa1034524 ) )
            {
                var_856158daa1034524 = Gas.birthtime;
                oldest_toxic_gas = Gas;
            }
            
            toxic_i += 1;
        }
        
        if ( isdefined( oldest_toxic_gas ) )
        {
            thread zombie_toxic_gas::free_toxic_gas( oldest_toxic_gas );
        }
    }
    
    phobos.var_f744e8be8b657e6e[ phobos.var_f744e8be8b657e6e.size ] = toxic_gas;
}

// Namespace zombie_phobos_spit
// Params 1
// Checksum 0x23683457, Offset: 0x380
// Size: 0x9a
function function_13c285f3a5c52573( phobos )
{
    foreach ( Gas in phobos.var_f744e8be8b657e6e )
    {
        if ( isdefined( Gas ) )
        {
            thread zombie_toxic_gas::free_toxic_gas( Gas );
        }
    }
    
    phobos.var_f744e8be8b657e6e = [];
}

// Namespace zombie_phobos_spit
// Params 1
// Checksum 0x14579eb5, Offset: 0x422
// Size: 0xa0
function function_f70810ebb0103f22( phobos )
{
    phobos.var_f744e8be8b657e6e = function_5713d46873b29625( phobos.var_f744e8be8b657e6e );
    var_7fe1fb55bb2d6630 = 0;
    toxic_i = 0;
    
    while ( toxic_i < phobos.var_f744e8be8b657e6e.size )
    {
        Gas = phobos.var_f744e8be8b657e6e[ toxic_i ];
        
        if ( !Gas.var_de80f1299517bfab && Gas.id != "from_zombie_base_toxic" )
        {
            var_7fe1fb55bb2d6630 += 1;
        }
        
        toxic_i += 1;
    }
    
    return var_7fe1fb55bb2d6630;
}

// Namespace zombie_phobos_spit
// Params 2
// Checksum 0xdc23461b, Offset: 0x4cb
// Size: 0x1e
function shouldspit( taskid, params )
{
    return anim.success;
}

// Namespace zombie_phobos_spit
// Params 2
// Checksum 0x9c2e74da, Offset: 0x4f2
// Size: 0x5a
function function_c26ec53778fdd546( taskid, params )
{
    var_5ca3cc62ad480151 = gettime() - ( self.spit_start_time ?? 0 );
    cooldown_score = clamp( math::remap( var_5ca3cc62ad480151, 0, utility::function_4b74c15943231980( 30 ), 0, 1 ), 0, 1 );
    return cooldown_score;
}

// Namespace zombie_phobos_spit
// Params 2
// Checksum 0xa828995, Offset: 0x555
// Size: 0x74
function function_a65f06073a07ed03( taskid, params )
{
    if ( !isdefined( self.var_f744e8be8b657e6e ) )
    {
        return 1;
    }
    
    var_7fe1fb55bb2d6630 = function_5713d46873b29625( self.var_f744e8be8b657e6e ).size;
    
    if ( isdefined( self.active_spit_projectile ) )
    {
        var_7fe1fb55bb2d6630 += function_5713d46873b29625( self.active_spit_projectile ).size;
    }
    
    var_24cb63031538dab = 1 - var_7fe1fb55bb2d6630 / 3;
    return var_24cb63031538dab;
}

// Namespace zombie_phobos_spit
// Params 2
// Checksum 0xc40cf1ac, Offset: 0x5d2
// Size: 0x93
function function_df4137e6e9274bfc( taskid, params )
{
    if ( !isdefined( self.enemy ) )
    {
        return 0;
    }
    
    dist = distance( self.enemy.origin, self.origin );
    var_d0cc61378b5e595c = 800;
    var_387f6eac55078e1c = min( abs( var_d0cc61378b5e595c - dist ), var_d0cc61378b5e595c );
    var_689b8d27ece8ea69 = math::remap( var_387f6eac55078e1c, var_d0cc61378b5e595c, 0, 0.5, 1 );
    return var_689b8d27ece8ea69;
}

/#

    // Namespace zombie_phobos_spit
    // Params 0
    // Checksum 0x107d0864, Offset: 0x66e
    // Size: 0x18, Type: dev
    function setup_spit_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::function_77df7fe7dd273e10();
    }

#/
