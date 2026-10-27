// scripts\common\status_effects\status_effects.gsc  (hash_5a4a5d9ba343ff8f.gscc) (size: 6709 Bytes / 0x1a35 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2ac1125c (717296220)
// size ...... 6709 (0x1a35)
// includes .. 2   (offset: 0x19b5)
// strings ... 0   (offset: 0x19c5)
// dev strs .. 8   (offset: 0x19c5)
// exports ... 15  (offset: 0x12c9)
// cseg ...... 0x58 + 0x1271 (0x12c9)
// imports ... 36  (offset: 0x1521)
// animtree1 . 0   (offset: 0x1a35)
// animtree2 . 0   (offset: 0x1a35)
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace status_effects;

// Namespace status_effects
// Params 0
// Checksum 0x298941bb, Offset: 0x76
// Size: 0x49
function function_36719164038cc9ce()
{
    /#
        level thread debug_status_effects();
    #/
    
    utility::registersharedfunc( #"status_effects", #"hash_5a9731327b5c2a13", &function_dfbbd41120ea8eca );
    utility::registersharedfunc( #"status_effects", #"hash_91e247f23b28ce36", &function_7ce691f9a36ea8a1 );
}

// Namespace status_effects
// Params 1
// Checksum 0x73da238d, Offset: 0xc7
// Size: 0x3f
function function_dfbbd41120ea8eca( var_749345f344f55b77 )
{
    if ( !isdefined( level.var_78d4983161fad819 ) )
    {
        level.var_78d4983161fad819 = [];
    }
    
    level.var_78d4983161fad819 = arraycombineunique( level.var_78d4983161fad819, [ var_749345f344f55b77 ] );
}

// Namespace status_effects
// Params 1
// Checksum 0x646ad652, Offset: 0x10e
// Size: 0x3a
function function_7ce691f9a36ea8a1( var_749345f344f55b77 )
{
    if ( !isdefined( level.var_78d4983161fad819 ) )
    {
        level.var_78d4983161fad819 = [];
    }
    
    level.var_78d4983161fad819 = arrayremove( level.var_78d4983161fad819, var_749345f344f55b77 );
}

// Namespace status_effects
// Params 2
// Checksum 0x92165fdd, Offset: 0x150
// Size: 0x6a, Type: bool
function has_status_effect_type( var_721a3ba8345b9108, include_cooldown = 0 )
{
    if ( isdefined( self.status_effects[ var_721a3ba8345b9108 ] ) && self.status_effects[ var_721a3ba8345b9108 ].size > 0 )
    {
        return true;
    }
    
    if ( include_cooldown )
    {
        return ( isdefined( self.effects_on_cooldown[ var_721a3ba8345b9108 ] ) && self.effects_on_cooldown[ var_721a3ba8345b9108 ].size > 0 );
    }
    
    return false;
}

// Namespace status_effects
// Params 2
// Checksum 0xaf6c0a0c, Offset: 0x1c3
// Size: 0xad, Type: bool
function function_e947cf9a9f176b2e( var_721a3ba8345b9108, var_749345f344f55b77 )
{
    if ( isdefined( self.status_effects[ var_721a3ba8345b9108 ] ) )
    {
        foreach ( status in self.status_effects[ var_721a3ba8345b9108 ] )
        {
            if ( status.var_749345f344f55b77 === var_749345f344f55b77 )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace status_effects
// Params 3
// Checksum 0x44fcea9e, Offset: 0x279
// Size: 0x15a, Type: bool
function function_fa35fc2723e956eb( var_721a3ba8345b9108, effect_id, include_cooldown = 0 )
{
    assert( isstring( effect_id ), "<dev string:x24>" );
    
    if ( !has_status_effect_type( var_721a3ba8345b9108, include_cooldown ) )
    {
        return false;
    }
    
    foreach ( var_c6321cb8cd32b6a0 in self.status_effects[ var_721a3ba8345b9108 ] )
    {
        if ( effect_id === var_c6321cb8cd32b6a0.unique_id )
        {
            return true;
        }
    }
    
    if ( include_cooldown )
    {
        foreach ( cooldown_effect in self.effects_on_cooldown[ var_721a3ba8345b9108 ] )
        {
            if ( effect_id === cooldown_effect.unique_id )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace status_effects
// Params 3
// Checksum 0x6c78ccf5, Offset: 0x3dc
// Size: 0xfb
function function_a541569a5cf7126b( var_721a3ba8345b9108, effect_id, duration )
{
    assert( isstring( effect_id ), "<dev string:x24>" );
    
    if ( !has_status_effect_type( var_721a3ba8345b9108 ) )
    {
        return;
    }
    
    foreach ( var_c6321cb8cd32b6a0 in self.status_effects[ var_721a3ba8345b9108 ] )
    {
        if ( effect_id === var_c6321cb8cd32b6a0.unique_id )
        {
            time_left = var_c6321cb8cd32b6a0.end_time - gettime();
            var_c6321cb8cd32b6a0.end_time = gettime() + max( time_left, utility::function_4b74c15943231980( duration ) );
        }
    }
}

// Namespace status_effects
// Params 7
// Checksum 0x488e, Offset: 0x4df
// Size: 0xe5
function function_93edde8d0fe48bb6( var_721a3ba8345b9108, durations, unique_id, start_func, end_func, var_749345f344f55b77, cooldowns )
{
    var_c49e50eb54d3a7a9 = spawnstruct();
    var_c49e50eb54d3a7a9.var_721a3ba8345b9108 = var_721a3ba8345b9108;
    var_c49e50eb54d3a7a9.unique_id = unique_id;
    var_c49e50eb54d3a7a9.durations = durations;
    var_c49e50eb54d3a7a9.start_func = start_func;
    var_c49e50eb54d3a7a9.end_func = end_func;
    var_c49e50eb54d3a7a9.end_time = gettime() + utility::function_4b74c15943231980( var_c49e50eb54d3a7a9.durations );
    var_c49e50eb54d3a7a9.var_efcde2142240af7 = 0;
    var_c49e50eb54d3a7a9.var_749345f344f55b77 = var_749345f344f55b77;
    var_c49e50eb54d3a7a9.cooldowns = cooldowns;
    return var_c49e50eb54d3a7a9;
}

// Namespace status_effects
// Params 1
// Checksum 0xf87acb20, Offset: 0x5cd
// Size: 0x2fe, Type: bool
function function_3747671c47b03216( effect )
{
    assert( isalive( self ), "<dev string:x41>" );
    
    if ( !isdefined( self.status_effects ) )
    {
        self.status_effects = [];
    }
    
    if ( !isdefined( self.status_effects[ effect.var_721a3ba8345b9108 ] ) )
    {
        self.status_effects[ effect.var_721a3ba8345b9108 ] = [];
    }
    
    if ( self.effects_on_cooldown[ effect.var_721a3ba8345b9108 ] && self.effects_on_cooldown[ effect.var_721a3ba8345b9108 ].size > 0 )
    {
        if ( effect.unique_id )
        {
            foreach ( cooldown_effect in self.effects_on_cooldown[ effect.var_721a3ba8345b9108 ] )
            {
                if ( cooldown_effect.unique_id == effect.unique_id )
                {
                    return false;
                }
            }
        }
        else
        {
            return false;
        }
    }
    
    foreach ( var_c6321cb8cd32b6a0 in self.status_effects[ effect.var_721a3ba8345b9108 ] )
    {
        if ( var_c6321cb8cd32b6a0.cooldowns > 0 )
        {
            if ( !effect.unique_id || var_c6321cb8cd32b6a0.unique_id == effect.unique_id )
            {
                return false;
            }
        }
    }
    
    if ( isdefined( effect.unique_id ) )
    {
        foreach ( var_c6321cb8cd32b6a0 in self.status_effects[ effect.var_721a3ba8345b9108 ] )
        {
            if ( effect.unique_id == var_c6321cb8cd32b6a0.unique_id )
            {
                var_c6321cb8cd32b6a0.var_efcde2142240af7 = 1;
            }
        }
    }
    
    self.status_effects[ effect.var_721a3ba8345b9108 ][ self.status_effects[ effect.var_721a3ba8345b9108 ].size ] = effect;
    
    if ( isdefined( effect.start_func ) )
    {
        self [[ effect.start_func ]]( effect );
    }
    
    if ( isdefined( self ) )
    {
        thread function_dd4701950a3f56f5();
    }
    
    return true;
}

// Namespace status_effects
// Params 0, eflags: 0xc
// Checksum 0xe690bfd4, Offset: 0x8d4
// Size: 0x4d4
function private function_dd4701950a3f56f5()
{
    self notify( #"hash_69b8b2d378fc730d" );
    self endon( #"hash_69b8b2d378fc730d" );
    self endon( #"disconnect" );
    
    if ( !isdefined( self ) || !isdefined( self.status_effects ) )
    {
        println( "<dev string:x91>" );
        return;
    }
    
    if ( !isdefined( self.effects_on_cooldown ) )
    {
        self.effects_on_cooldown = [];
    }
    
    if ( isplayer( self ) )
    {
        if ( !callback::exists( #"player_death", &function_d4ab436c2953fc33 ) )
        {
            callback::add( #"player_death", &function_d4ab436c2953fc33 );
        }
    }
    else if ( isai( self ) )
    {
        if ( !callback::exists( #"on_ai_killed", &function_d4ab436c2953fc33 ) )
        {
            callback::add( #"on_ai_killed", &function_d4ab436c2953fc33 );
        }
    }
    
    var_38b5f44f1eb591b = self.status_effects.size;
    
    while ( isdefined( self ) && var_38b5f44f1eb591b > 0 && ( isalive( self ) || self.inlaststand ) )
    {
        now = gettime();
        var_e47d2bf8292dea9a = [];
        
        foreach ( var_721a3ba8345b9108, effects in self.effects_on_cooldown )
        {
            active_cooldowns = [];
            
            foreach ( effect in effects )
            {
                if ( now < effect.cooldown_end_time )
                {
                    active_cooldowns[ active_cooldowns.size ] = effect;
                }
            }
            
            self.effects_on_cooldown[ var_721a3ba8345b9108 ] = active_cooldowns;
        }
        
        if ( isdefined( self.status_effects ) )
        {
            foreach ( var_721a3ba8345b9108, effects in self.status_effects )
            {
                var_12ebfd6b46881209 = [];
                
                foreach ( effect in effects )
                {
                    if ( effect.var_efcde2142240af7 )
                    {
                        var_e47d2bf8292dea9a[ var_e47d2bf8292dea9a.size ] = effect;
                        continue;
                    }
                    
                    if ( level.var_78d4983161fad819 && arraycontains( level.var_78d4983161fad819, effect.var_749345f344f55b77 ) )
                    {
                        var_12ebfd6b46881209[ var_12ebfd6b46881209.size ] = effect;
                        continue;
                    }
                    
                    if ( effect.durations < -1 )
                    {
                        var_12ebfd6b46881209[ var_12ebfd6b46881209.size ] = effect;
                        continue;
                    }
                    
                    if ( now < effect.end_time )
                    {
                        var_12ebfd6b46881209[ var_12ebfd6b46881209.size ] = effect;
                        continue;
                    }
                    
                    if ( effect.cooldowns > 0 )
                    {
                        effect.cooldown_end_time = now + utility::function_4b74c15943231980( effect.cooldowns );
                        
                        if ( !isdefined( self.effects_on_cooldown[ var_721a3ba8345b9108 ] ) )
                        {
                            self.effects_on_cooldown[ var_721a3ba8345b9108 ] = [];
                        }
                        
                        self.effects_on_cooldown[ var_721a3ba8345b9108 ][ self.effects_on_cooldown[ var_721a3ba8345b9108 ].size ] = effect;
                    }
                    
                    var_e47d2bf8292dea9a[ var_e47d2bf8292dea9a.size ] = effect;
                }
                
                self.status_effects[ var_721a3ba8345b9108 ] = var_12ebfd6b46881209;
            }
        }
        
        foreach ( effect in var_e47d2bf8292dea9a )
        {
            function_3753f3428c9ec551( effect );
        }
        
        if ( isdefined( self.status_effects ) && isdefined( self.status_effects.size ) )
        {
            var_38b5f44f1eb591b = self.status_effects.size;
        }
        else
        {
            var_38b5f44f1eb591b = 0;
        }
        
        waitframe();
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isplayer( self ) )
    {
        callback::remove( #"player_death", &function_d4ab436c2953fc33 );
        return;
    }
    
    if ( isai( self ) )
    {
        callback::remove( #"on_ai_killed", &function_d4ab436c2953fc33 );
    }
}

// Namespace status_effects
// Params 1, eflags: 0x4
// Checksum 0xe55a854c, Offset: 0xdb0
// Size: 0x2c
function private function_3753f3428c9ec551( effect )
{
    if ( isdefined( effect.end_func ) )
    {
        self [[ effect.end_func ]]( effect );
    }
}

// Namespace status_effects
// Params 1, eflags: 0x4
// Checksum 0xcb2314ec, Offset: 0xde4
// Size: 0x13
function private function_d4ab436c2953fc33( params )
{
    function_4306f85454d862ba();
}

// Namespace status_effects
// Params 0
// Checksum 0x8b083808, Offset: 0xdff
// Size: 0xfe
function function_4306f85454d862ba()
{
    if ( !self.status_effects )
    {
        return;
    }
    
    foreach ( key, effects in self.status_effects )
    {
        self.status_effects[ key ] = [];
        
        foreach ( effect in effects )
        {
            thread function_3753f3428c9ec551( effect );
        }
    }
}

/#

    // Namespace status_effects
    // Params 0, eflags: 0x4
    // Checksum 0xcc30487c, Offset: 0xf05
    // Size: 0x3c4, Type: dev
    function private debug_status_effects()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            entity_num = getdvarint( @"hash_f429fe6098c1896a", -1 );
            entity = getentbynum( entity_num );
            
            if ( isdefined( entity ) )
            {
                now = gettime();
                print_x = 400;
                print_y = 300;
                printtoscreen2d( print_x, print_y, "<dev string:xbf>" );
                
                if ( isdefined( entity.status_effects ) )
                {
                    foreach ( var_721a3ba8345b9108, effects in entity.status_effects )
                    {
                        if ( effects.size == 0 )
                        {
                            continue;
                        }
                        
                        var_ef9f33a98df048f8 = [];
                        var_68d5c64e3eb8bc82 = 0;
                        
                        foreach ( effect in effects )
                        {
                            var_7ca3989f860d14f0 = effect.end_time - now;
                            
                            if ( var_7ca3989f860d14f0 > var_68d5c64e3eb8bc82 )
                            {
                                var_68d5c64e3eb8bc82 = var_7ca3989f860d14f0;
                            }
                            
                            if ( isdefined( effect.unique_id ) )
                            {
                                var_ef9f33a98df048f8 = arraycombineunique( var_ef9f33a98df048f8, [ effect.unique_id ] );
                            }
                        }
                        
                        print_y += 20;
                        status_effect_info = var_721a3ba8345b9108 + "<dev string:xce>" + effects.size + "<dev string:xd1>" + utility::function_6f5d2e1f1ff70482( var_68d5c64e3eb8bc82 ) + "<dev string:xd4>";
                        printtoscreen2d( print_x, print_y, status_effect_info );
                        
                        foreach ( id in var_ef9f33a98df048f8 )
                        {
                            print_y += 20;
                            printtoscreen2d( print_x + 10, print_y, id );
                        }
                    }
                }
                
                print_y += 20;
                printtoscreen2d( print_x, print_y, "<dev string:xd6>" );
                
                if ( isdefined( entity.effects_on_cooldown ) )
                {
                    foreach ( var_721a3ba8345b9108, effects in entity.effects_on_cooldown )
                    {
                        if ( effects.size == 0 )
                        {
                            continue;
                        }
                        
                        var_68d5c64e3eb8bc82 = 0;
                        
                        foreach ( effect in effects )
                        {
                            var_7ca3989f860d14f0 = effect.cooldown_end_time - now;
                            
                            if ( var_7ca3989f860d14f0 > var_68d5c64e3eb8bc82 )
                            {
                                var_68d5c64e3eb8bc82 = var_7ca3989f860d14f0;
                            }
                        }
                        
                        print_y += 20;
                        status_effect_info = var_721a3ba8345b9108 + "<dev string:xce>" + effects.size + "<dev string:xd1>" + utility::function_6f5d2e1f1ff70482( var_68d5c64e3eb8bc82 ) + "<dev string:xd4>";
                        printtoscreen2d( print_x, print_y, status_effect_info );
                    }
                }
            }
            
            waitframe();
        }
    }

#/
