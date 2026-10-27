// scripts\common\ai\aitypes\zombie_abom\zombie_abom_crawler_deploy.gsc  (hash_6b2a11261011d331.gscc) (size: 1969 Bytes / 0x7b1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x32b82d0b (850930955)
// size ...... 1969 (0x7b1)
// includes .. 3   (offset: 0x751)
// strings ... 6   (offset: 0x769)
// dev strs .. 0   (offset: 0x7b1)
// exports ... 7   (offset: 0x475)
// cseg ...... 0xd0 + 0x3a5 (0x475)
// imports ... 16  (offset: 0x58d)
// animtree1 . 0   (offset: 0x7b1)
// animtree2 . 0   (offset: 0x7b1)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace zombie_abom_crawler_deploy;

// Namespace zombie_abom_crawler_deploy
// Params 2
// Checksum 0xc2b8cbbf, Offset: 0xee
// Size: 0x64
function function_dab4c602e2c3adbb( taskid, params )
{
    if ( self function_c607805e62ad17af() < 2000 )
    {
        return anim.failure;
    }
    
    self.var_e9d572d303e71533 = function_46f9072493651dc9( self.var_e9d572d303e71533 );
    
    if ( self.var_e9d572d303e71533.size < 5 )
    {
        return anim.success;
    }
    
    return anim.failure;
}

// Namespace zombie_abom_crawler_deploy
// Params 2
// Checksum 0x7b2a97f5, Offset: 0x15b
// Size: 0x97
function function_75ca857f74ffa83f( taskid, params )
{
    if ( !self.var_ef590d4074c114 )
    {
        return anim.failure;
    }
    
    if ( self.var_208dd1687f1032bd && gettime() - self.var_208dd1687f1032bd < self.var_ef590d4074c114 )
    {
        return anim.failure;
    }
    
    self.var_e9d572d303e71533 = function_46f9072493651dc9( self.var_e9d572d303e71533 );
    
    if ( self.var_e9d572d303e71533.size < 5 )
    {
        return anim.success;
    }
    
    return anim.failure;
}

// Namespace zombie_abom_crawler_deploy
// Params 0
// Checksum 0x9fd93eca, Offset: 0x1fb
// Size: 0x13
function init_zombie_abom_crawler_deploy()
{
    self.var_e9d572d303e71533 = [];
    thread function_ef893f4fcdd967ca();
}

// Namespace zombie_abom_crawler_deploy
// Params 0, eflags: 0x4
// Checksum 0x8581f0be, Offset: 0x216
// Size: 0x46
function private function_ef893f4fcdd967ca()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"start_crawler_deploy" );
        
        if ( isdefined( self.enemy ) )
        {
            self getenemyinfo( self.enemy );
        }
        
        thread function_5749898cbd01c557();
    }
}

// Namespace zombie_abom_crawler_deploy
// Params 0, eflags: 0x4
// Checksum 0xe347b111, Offset: 0x264
// Size: 0x47
function private function_5749898cbd01c557()
{
    self endon( #"death" );
    self endon( #"start_crawler_deploy" );
    
    while ( true )
    {
        self waittill( #"spawn_crawler" );
        
        if ( self.var_e9d572d303e71533.size < 5 )
        {
            function_c14569f7e9b91c3a();
        }
        
        waitframe();
    }
}

// Namespace zombie_abom_crawler_deploy
// Params 0, eflags: 0x4
// Checksum 0xae5e1c54, Offset: 0x2b3
// Size: 0x1c2
function private function_c14569f7e9b91c3a()
{
    aitypes = namespace_9d8e359c3b1041e5::get_aitype_by_subclass_sharedfunc( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.crawlersubclass );
    assert( aitypes.size > 0 );
    var_86378c265bd6b3c6 = undefined;
    
    foreach ( aitype in aitypes )
    {
        strlen = aitype.size;
        
        if ( !isdefined( var_86378c265bd6b3c6 ) || var_86378c265bd6b3c6.size > strlen )
        {
            var_86378c265bd6b3c6 = aitype;
        }
    }
    
    var_fd1a257c13b43f01 = var_86378c265bd6b3c6;
    var_99b22c27bc415a7a = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( var_fd1a257c13b43f01, self.origin, self.angles, self.team );
    
    if ( isdefined( var_99b22c27bc415a7a ) )
    {
        var_99b22c27bc415a7a thread namespace_9d8e359c3b1041e5::animscripted_sharedfunc( "spawn_abom_crawler", "spawn_end", undefined, undefined, "spawn_animating" );
        var_99b22c27bc415a7a.var_2058466b83c7a86 = self;
        params = spawnstruct();
        params.zombie = var_99b22c27bc415a7a;
        var_99b22c27bc415a7a callback::callback( "on_abom_crawler_spawned", params );
        self.var_e9d572d303e71533[ self.var_e9d572d303e71533.size ] = var_99b22c27bc415a7a;
        
        if ( utility::flag( "level_stealth_initialized" ) && isdefined( self.enemy ) )
        {
            var_99b22c27bc415a7a aieventlistenerevent( "attack", self.enemy, self.enemy.origin );
        }
    }
}

