// scripts\mp\health_overcharge.gsc  (hash_60f5f171f8299455.gscc) (size: 5105 Bytes / 0x13f1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc2f00185 (3270508933)
// size ...... 5105 (0x13f1)
// includes .. 3   (offset: 0x138d)
// strings ... 4   (offset: 0x13a5)
// dev strs .. 2   (offset: 0x13d9)
// exports ... 17  (offset: 0xca1)
// cseg ...... 0xbf + 0xbe2 (0xca1)
// imports ... 36  (offset: 0xf49)
// animtree1 . 0   (offset: 0x13f1)
// animtree2 . 0   (offset: 0x13f1)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\playerhealth;

#namespace health_overcharge;

// Namespace health_overcharge
// Params 0
// Checksum 0xbe752b7c, Offset: 0xdd
// Size: 0xce
function init_health_overcharge()
{
    level callback::add( #"player_spawned", &function_9c776bb73e5f8aa6 );
    level callback::add( #"player_disconnect", &function_687d6390c87dd1d2 );
    level callback::add( #"player_laststand", &function_3866eebe55689108 );
    level callback::add( "on_player_max_health_change", &on_player_max_health_change );
    utility::registersharedfunc( #"health", #"hash_291dc25cfb86af01", &function_f6da758a8ee4c988 );
    utility::registersharedfunc( #"health", #"hash_bbb5964adc2eedfb", &function_1c546d630583f860 );
    utility::registersharedfunc( #"health", #"get_player_health_overcharge", &get_player_health_overcharge );
    utility::registersharedfunc( #"health", #"hash_5a1b27fe9a788ec4", &function_517ae12f52d0fb01 );
}

// Namespace health_overcharge
// Params 0
// Checksum 0xdfe67a1a, Offset: 0x1b3
// Size: 0xb
function function_8747738d3cfe9a6a()
{
    return self.var_9fea5ca5a09c28c;
}

// Namespace health_overcharge
// Params 1
// Checksum 0xa3a452c, Offset: 0x1c7
// Size: 0x29
function function_1050a266d4743956( var_f1fbc291f2430b1e )
{
    if ( var_f1fbc291f2430b1e )
    {
        self.var_9fea5ca5a09c28c = 1;
        return;
    }
    
    self.var_9fea5ca5a09c28c = undefined;
}

// Namespace health_overcharge
// Params 1, eflags: 0x4
// Checksum 0x6ab47762, Offset: 0x1f8
// Size: 0x72
function private function_9c776bb73e5f8aa6( params )
{
    max_health = int( getmatchrulesdata( "commonOption", "maxHealth" ) );
    
    if ( !isnumber( max_health ) )
    {
        max_health = self.maxhealth;
    }
    
    self.var_68e0e97561171104 = { #max_health_overcharge:100, #overcharge_sources:[], #base_max_health:max_health };
    function_1a9f22ae5fbc86d2( self, 0 );
}

// Namespace health_overcharge
// Params 1, eflags: 0x4
// Checksum 0x4a387e2d, Offset: 0x272
// Size: 0x16
function private function_687d6390c87dd1d2( params )
{
    self.var_68e0e97561171104 = undefined;
}

// Namespace health_overcharge
// Params 1, eflags: 0x4
// Checksum 0x9331dcf2, Offset: 0x290
// Size: 0x95
function private function_3866eebe55689108( params )
{
    if ( isnumber( self.var_68e0e97561171104.var_e3eb0edac3b4f14 ) && self.var_68e0e97561171104.var_e3eb0edac3b4f14 != self.var_68e0e97561171104.base_max_health )
    {
        self.maxhealth = self.var_68e0e97561171104.base_max_health;
        self.var_68e0e97561171104.var_e3eb0edac3b4f14 = undefined;
        self.var_68e0e97561171104.overcharge_sources = [];
    }
}

// Namespace health_overcharge
// Params 1, eflags: 0x4
// Checksum 0x64a3460c, Offset: 0x32d
// Size: 0x98
function private on_player_max_health_change( params )
{
    if ( !function_8747738d3cfe9a6a() && isdefined( self.var_68e0e97561171104 ) && isnumber( params.new_max_health ) )
    {
        if ( isnumber( self.var_68e0e97561171104.var_e3eb0edac3b4f14 ) )
        {
            self.var_68e0e97561171104.var_e3eb0edac3b4f14 = undefined;
            self.var_68e0e97561171104.overcharge_sources = [];
        }
        
        self.var_68e0e97561171104.base_max_health = params.new_max_health;
    }
}

// Namespace health_overcharge
// Params 4
// Checksum 0xbdec60cf, Offset: 0x3cd
// Size: 0x2fe, Type: bool
function function_f6da758a8ee4c988( player, source_string, overcharge_amount, var_451dcdb37cd40978 )
{
    if ( !isplayer( player ) || !isstring( source_string ) && !isxhash( source_string ) || !isnumber( overcharge_amount ) )
    {
        return false;
    }
    
    if ( player.health + overcharge_amount <= player.maxhealth )
    {
        player.health += overcharge_amount;
        sparams = { #var_451dcdb37cd40978:var_451dcdb37cd40978, #overcharge_amount:overcharge_amount, #source_string:source_string, #player:player };
        player callback::callback( #"hash_11343ded26b4d165", sparams );
        player playerhealth::updatedeathsdoor();
        return true;
    }
    
    var_71cf3f71eed42476 = player.health + overcharge_amount - player.maxhealth;
    var_d6c59b9aa651329 = 0;
    
    foreach ( amount in player.var_68e0e97561171104.overcharge_sources )
    {
        var_d6c59b9aa651329 += amount;
    }
    
    var_af8a03f98a6776f8 = player.var_68e0e97561171104.overcharge_sources[ source_string ] ?? 0;
    
    if ( isnumber( var_451dcdb37cd40978 ) && var_451dcdb37cd40978 > 0 )
    {
        if ( var_af8a03f98a6776f8 + var_71cf3f71eed42476 > var_451dcdb37cd40978 )
        {
            var_71cf3f71eed42476 = var_451dcdb37cd40978 - var_af8a03f98a6776f8;
        }
    }
    
    var_dc463258b3c8111c = min( var_d6c59b9aa651329 + var_71cf3f71eed42476, 100 );
    new_add_amount = var_dc463258b3c8111c - var_d6c59b9aa651329;
    
    if ( new_add_amount <= 0 )
    {
        return false;
    }
    
    var_912929c2c2c84c23 = new_add_amount + var_af8a03f98a6776f8;
    var_912929c2c2c84c23 = int( var_912929c2c2c84c23 );
    var_dc463258b3c8111c = int( var_dc463258b3c8111c );
    player.var_68e0e97561171104.overcharge_sources[ source_string ] = var_912929c2c2c84c23;
    player.maxhealth = player.var_68e0e97561171104.base_max_health + var_dc463258b3c8111c;
    player.var_68e0e97561171104.var_e3eb0edac3b4f14 = player.maxhealth;
    player.maxhealth = player.maxhealth;
    player.health = player.maxhealth;
    player thread function_1679135e759a0395();
    sparams = { #var_451dcdb37cd40978:var_451dcdb37cd40978, #overcharge_amount:overcharge_amount, #source_string:source_string, #player:player };
    player callback::callback( #"hash_11343ded26b4d165", sparams );
    return true;
}

// Namespace health_overcharge
// Params 0, eflags: 0xc
// Checksum 0xcb7a019, Offset: 0x6d4
// Size: 0x1c3
function private function_1679135e759a0395()
{
    self notify( #"hash_3b64f67f71bd8479" );
    self endon( #"hash_3b64f67f71bd8479" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    function_1a9f22ae5fbc86d2( self, 1 );
    
    while ( true )
    {
        if ( self.health < ( self.var_68e0e97561171104.var_e3eb0edac3b4f14 ?? self.health ) )
        {
            function_fee762877758f297( self.var_68e0e97561171104.var_e3eb0edac3b4f14 - self.health );
            
            if ( self.health <= 0 )
            {
                /#
                    assertmsg( "<dev string:x24>" );
                    iprintlnbold( "<dev string:x7f>" );
                    stack = getscriptcallstack();
                    println( stack );
                #/
                
                self.maxhealth = self.var_68e0e97561171104.base_max_health ?? 150;
                self.var_68e0e97561171104.var_e3eb0edac3b4f14 = self.var_68e0e97561171104.base_max_health ?? 150;
            }
            else
            {
                self.maxhealth = self.health;
                self.var_68e0e97561171104.var_e3eb0edac3b4f14 = self.health;
            }
        }
        
        if ( self.health <= self.var_68e0e97561171104.base_max_health )
        {
            self.maxhealth = self.var_68e0e97561171104.base_max_health;
            self.var_68e0e97561171104.overcharge_sources = [];
            break;
        }
        
        waitframe();
    }
    
    function_1a9f22ae5fbc86d2( self, 0 );
    self.var_68e0e97561171104.var_e3eb0edac3b4f14 = undefined;
}

// Namespace health_overcharge
// Params 1, eflags: 0x4
// Checksum 0xa7b14117, Offset: 0x89f
// Size: 0xf0
function private function_fee762877758f297( damage_amount )
{
    foreach ( source, amount in self.var_68e0e97561171104.overcharge_sources )
    {
        if ( damage_amount <= 0 )
        {
            break;
        }
        
        if ( amount - damage_amount > 0 )
        {
            self.var_68e0e97561171104.overcharge_sources[ source ] = amount - damage_amount;
            damage_amount = 0;
            self notify( #"overcharge_damaged" );
            continue;
        }
        
        self.var_68e0e97561171104.overcharge_sources[ source ] = 0;
        damage_amount -= amount;
        self notify( #"overcharge_depleted" );
    }
}

// Namespace health_overcharge
// Params 2, eflags: 0x4
// Checksum 0x6b5f502c, Offset: 0x997
// Size: 0x44
function private function_1a9f22ae5fbc86d2( player, isactive )
{
    var_25f925f48ee1e217 = player.sessionuimemberindex;
    
    if ( var_25f925f48ee1e217 != -1 )
    {
        function_a9a8165656e26139( "ui_is_player_at_squad_index_transformed", var_25f925f48ee1e217, 1, isactive );
    }
}

// Namespace health_overcharge
// Params 0
// Checksum 0xfe6681e4, Offset: 0x9e3
// Size: 0x87, Type: bool
function function_1c546d630583f860()
{
    foreach ( amount in self.var_68e0e97561171104.overcharge_sources )
    {
        if ( amount > 0 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace health_overcharge
// Params 1
// Checksum 0x28404ea, Offset: 0xa73
// Size: 0xab
function get_player_health_overcharge( source_filter )
{
    total_overcharge = 0;
    
    foreach ( source, amount in self.var_68e0e97561171104.overcharge_sources )
    {
        total_overcharge += amount;
        
        if ( source === source_filter )
        {
            return amount;
        }
    }
    
    if ( isdefined( source_filter ) )
    {
        return 0;
    }
    
    return total_overcharge;
}

// Namespace health_overcharge
// Params 2
// Checksum 0x9dc3bdef, Offset: 0xb27
// Size: 0xf7
function function_aaa1259d369b69ea( base_max_health, overcharge_sources )
{
    self endon( #"death_or_disconnect" );
    
    if ( !isdefined( base_max_health ) )
    {
        return;
    }
    
    self.maxhealth = base_max_health;
    self.health = self.maxhealth;
    callback::callback( "on_player_max_health_change", { #new_max_health:base_max_health } );
    
    if ( isarray( overcharge_sources ) && overcharge_sources.size > 0 )
    {
        waitframe();
        waitframe();
        
        if ( isplayer( self ) && isalive( self ) )
        {
            foreach ( index, overheal_value in overcharge_sources )
            {
                function_f6da758a8ee4c988( self, index, overheal_value );
            }
        }
    }
}

// Namespace health_overcharge
// Params 1, eflags: 0x4
// Checksum 0x2c69b546, Offset: 0xc26
// Size: 0x46
function private function_9c3957f3d1d26e05( source_filter )
{
    current_health_overcharge = get_player_health_overcharge( source_filter );
    var_b1a3672832e77f33 = abs( current_health_overcharge - self.var_68e0e97561171104.max_health_overcharge );
    return var_b1a3672832e77f33;
}

// Namespace health_overcharge
// Params 1, eflags: 0x4
// Checksum 0xe131ec52, Offset: 0xc75
// Size: 0x2b, Type: bool
function private function_517ae12f52d0fb01( source_filter )
{
    var_b1a3672832e77f33 = function_9c3957f3d1d26e05( source_filter );
    
    if ( var_b1a3672832e77f33 > 0 )
    {
        return false;
    }
    
    return true;
}

