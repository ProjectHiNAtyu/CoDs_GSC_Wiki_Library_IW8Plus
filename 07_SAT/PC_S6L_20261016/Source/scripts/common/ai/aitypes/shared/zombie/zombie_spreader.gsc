// scripts\common\ai\aitypes\shared\zombie\zombie_spreader.gsc  (hash_6b5c48e83676a3e3.gscc) (size: 2188 Bytes / 0x88c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x205abd36 (542817590)
// size ...... 2188 (0x88c)
// includes .. 4   (offset: 0x82c)
// strings ... 4   (offset: 0x84c)
// dev strs .. 0   (offset: 0x88c)
// exports ... 6   (offset: 0x4e4)
// cseg ...... 0x9f + 0x445 (0x4e4)
// imports ... 20  (offset: 0x5d4)
// animtree1 . 0   (offset: 0x88c)
// animtree2 . 0   (offset: 0x88c)
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_spreader;

// Namespace zombie_spreader
// Params 0, eflags: 0x5
// Checksum 0xb118bc49, Offset: 0xbd
// Size: 0x48
function private autoexec init_zombie_spreader()
{
    if ( level.gametypebundle.enablezombiespreader )
    {
        level callback::add( "on_zombie_ai_spawned", &zombie_spreader_on_spawned );
        val::register( "disallow_zombie_spreader", 0, 1, "$self", &disallow_zombie_spreader, "$value" );
    }
}

// Namespace zombie_spreader
// Params 1, eflags: 0x4
// Checksum 0xdf99c59b, Offset: 0x10d
// Size: 0x32
function private zombie_spreader_on_spawned( params )
{
    if ( self.enablespreading )
    {
        thread function_7c6616850c3655f1();
    }
    
    if ( self.var_5ef407fd795e3461 )
    {
        thread function_10acfcf1091d35ab();
    }
}

// Namespace zombie_spreader
// Params 0, eflags: 0x4
// Checksum 0x63af5984, Offset: 0x147
// Size: 0x17a
function private function_7c6616850c3655f1()
{
    self endon( #"death" );
    var_94ba7a817c713161 = 1000;
    var_8ff405c65e3acb6e = randomfloat( var_94ba7a817c713161 );
    var_f9b7e60e3ab4dd1b = self.var_d6894f01a36b4ff3.var_446f1df7786c277d ?? 35;
    rate = self.var_d6894f01a36b4ff3.var_acf561aaf432388f ?? 0.05;
    
    /#
        var_f9b7e60e3ab4dd1b = getdvarfloat( @"avoidancemaxradius", var_f9b7e60e3ab4dd1b );
        rate = getdvarfloat( @"hash_11389fa5bc3c54d8", rate );
    #/
    
    var_e7dc035d3005e76a = 0;
    
    while ( true )
    {
        b_enable_spreader = !utility::ent_flag( "disallow_zombie_spreader" ) && !self._blackboard.var_79b2d8d61c6ef8b1 && !self._blackboard.var_a1343e824832d912 && isplayer( self.enemy );
        
        if ( b_enable_spreader )
        {
            var_e7dc035d3005e76a = 1;
            progress = gettime() * rate + var_8ff405c65e3acb6e;
            var_9bd1e5abf0276466 = ( sin( progress ) + 1 ) * 0.5;
            pct_extra_radius = var_9bd1e5abf0276466 * var_f9b7e60e3ab4dd1b;
            self setavoidanceradius( self.radius + pct_extra_radius );
            waitframe();
            continue;
        }
        
        if ( var_e7dc035d3005e76a )
        {
            var_e7dc035d3005e76a = 0;
            self setavoidanceradius( self.radius );
        }
        
        wait 0.25;
    }
}

// Namespace zombie_spreader
// Params 0, eflags: 0x4
// Checksum 0x76d8e3cf, Offset: 0x2c9
// Size: 0x1df
function private function_10acfcf1091d35ab()
{
    self endon( #"death" );
    var_4de669ef6c56c22a = self.var_d6894f01a36b4ff3.var_9a71f0a16a69231b ?? 10;
    var_4e0973ef6c7d1fe0 = self.var_d6894f01a36b4ff3.var_12895e5544b9e1d9 ?? 30;
    clamp_dist_min = self.var_d6894f01a36b4ff3.var_cdab6a97a9caea87 ?? 500;
    clamp_dist_max = self.var_d6894f01a36b4ff3.var_e1f64df603fda49d ?? 1000;
    var_b8927149d251347f = !( self.var_d6894f01a36b4ff3.var_b193abd26d2de4ae ?? 0 );
    
    /#
        var_4de669ef6c56c22a = getdvarfloat( @"hash_85bf77953831c5ce", var_4de669ef6c56c22a );
        var_4e0973ef6c7d1fe0 = getdvarfloat( @"hash_859b699538092c4c", var_4e0973ef6c7d1fe0 );
        clamp_dist_min = getdvarfloat( @"hash_1657465904bf8e1d", clamp_dist_min );
        clamp_dist_max = getdvarfloat( @"hash_1633505904972963", clamp_dist_max );
    #/
    
    var_e7e8df0769174c82 = 0;
    
    while ( true )
    {
        b_enable_spreader = !utility::ent_flag( "disallow_zombie_spreader" ) && !self._blackboard.var_79b2d8d61c6ef8b1 && isplayer( self.enemy );
        
        if ( b_enable_spreader )
        {
            var_e7e8df0769174c82 = 1;
            pathdist = self pathdisttogoal( 0 );
            
            if ( var_b8927149d251347f && pathdist >= clamp_dist_max )
            {
                self function_6f63c6da44aeab9( -1 );
            }
            else
            {
                new_angle_clamp = clamp( math::remap( pathdist, clamp_dist_min, clamp_dist_max, var_4de669ef6c56c22a, var_4e0973ef6c7d1fe0 ), var_4de669ef6c56c22a, var_4e0973ef6c7d1fe0 );
                self function_6f63c6da44aeab9( new_angle_clamp );
            }
            
            if ( pathdist >= clamp_dist_max )
            {
                wait randomfloatrange( 0.15, 0.25 );
            }
            else
            {
                waitframe();
            }
            
            continue;
        }
        
        if ( var_e7e8df0769174c82 )
        {
            var_e7e8df0769174c82 = 0;
            self function_6f63c6da44aeab9( -1 );
        }
        
        wait 0.25;
    }
}

// Namespace zombie_spreader
// Params 1, eflags: 0x4
// Checksum 0x2ba96ac6, Offset: 0x4b0
// Size: 0x34
function private disallow_zombie_spreader( b_value = 0 )
{
    if ( b_value )
    {
        utility::ent_flag_set( "disallow_zombie_spreader" );
        return;
    }
    
    utility::ent_flag_clear( "disallow_zombie_spreader" );
}

