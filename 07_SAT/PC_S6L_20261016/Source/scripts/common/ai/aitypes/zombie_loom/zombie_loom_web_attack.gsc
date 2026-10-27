// scripts\common\ai\aitypes\zombie_loom\zombie_loom_web_attack.gsc  (hash_6a9a620aff3ca20c.gscc) (size: 4536 Bytes / 0x11b8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa9ed256d (2850891117)
// size ...... 4536 (0x11b8)
// includes .. 4   (offset: 0x10c8)
// strings ... 16  (offset: 0x10e8)
// dev strs .. 0   (offset: 0x11b8)
// exports ... 17  (offset: 0x99c)
// cseg ...... 0x1bc + 0x7e0 (0x99c)
// imports ... 39  (offset: 0xc44)
// animtree1 . 0   (offset: 0x11b8)
// animtree2 . 0   (offset: 0x11b8)
#using scripts\asm\asm;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_loom_web_attack;

// Namespace zombie_loom_web_attack
// Params 1
// Checksum 0xd6e69b3b, Offset: 0x1da
// Size: 0xc
function precache( aitypescriptbundle )
{
    
}

// Namespace zombie_loom_web_attack
// Params 0
// Checksum 0xaf66388b, Offset: 0x1ee
// Size: 0x42
function init_global()
{
    callback::get_template( self.animsetname ) callback::add( "out_playable_space", &out_playable_space );
    callback::get_template( self.animsetname ) callback::add( "in_playable_space", &in_playable_space );
}

// Namespace zombie_loom_web_attack
// Params 0
// Checksum 0x9ff7009, Offset: 0x238
// Size: 0x130
function init()
{
    thread function_b2edde8c99b8fffc();
    
    if ( !isdefined( self.var_577dec43cf1caedf ) )
    {
        self.var_577dec43cf1caedf = 1;
    }
    
    self function_786bb6aa1b76c7ee( "web_attack_max_target_count", self.var_577dec43cf1caedf );
    self function_786bb6aa1b76c7ee( "loom_web_attack_max_dist", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_79efe74e7ce5c899 );
    self function_786bb6aa1b76c7ee( "loom_web_attack_max_yaw", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_30940c5b5fdc7565 );
    self.web_projectile = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_7ed662155298d4d0;
    weaponhash = getxhash( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_b5550f1b7ade70a8 );
    
    if ( !isdefined( level.var_f01c6045bb80112f[ weaponhash ] ) )
    {
        level.var_f01c6045bb80112f[ weaponhash ] = makeweapon( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_b5550f1b7ade70a8 );
    }
    
    self.webweapon = level.var_f01c6045bb80112f[ weaponhash ];
    thread function_1c9c7adb7e3e3f69();
}

// Namespace zombie_loom_web_attack
// Params 1
// Checksum 0x8f0dc2e3, Offset: 0x370
// Size: 0x2c
function enable_projectile_attack( var_f1fbc291f2430b1e )
{
    if ( var_f1fbc291f2430b1e )
    {
        self function_f2df0257c63f229( "disable_web_attack" );
        return;
    }
    
    self function_786bb6aa1b76c7ee( "disable_web_attack", 1 );
}

// Namespace zombie_loom_web_attack
// Params 2
// Checksum 0x94cbf73a, Offset: 0x3a4
// Size: 0x42
function function_4832c0546c82cc2b( taskid, params )
{
    return istrue( self.enemy val::get( "recently_webbed" ) ) ? anim.success : anim.failure;
}

// Namespace zombie_loom_web_attack
// Params 1, eflags: 0x4
// Checksum 0x761a5fd, Offset: 0x3ef
// Size: 0x14
function private out_playable_space( params )
{
    enable_projectile_attack( 0 );
}

// Namespace zombie_loom_web_attack
// Params 1, eflags: 0x4
// Checksum 0x28fc82aa, Offset: 0x40b
// Size: 0x15
function private in_playable_space( params )
{
    enable_projectile_attack( 1 );
}

// Namespace zombie_loom_web_attack
// Params 1
// Checksum 0xfcd5ab04, Offset: 0x428
// Size: 0x23
function request_projectile_attack( target_ent )
{
    self.web_attack_target = target_ent;
    asm::function_7256f5ba459c840b( "web_attack_in" );
}

// Namespace zombie_loom_web_attack
// Params 0, eflags: 0x4
// Checksum 0xc2e351e8, Offset: 0x453
// Size: 0x33
function private function_b2edde8c99b8fffc()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"web_attack_requested" );
        request_projectile_attack( self.enemy );
    }
}

// Namespace zombie_loom_web_attack
// Params 0, eflags: 0xc
// Checksum 0xd064abeb, Offset: 0x48e
// Size: 0x50
function private function_1c9c7adb7e3e3f69()
{
    self notify( #"hash_d618b86866ab54c6" );
    self endon( #"hash_d618b86866ab54c6" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"web_attack_launched" );
        function_5a48a73ee2c4ab48( "tag_spinneret", self.web_projectile );
    }
}

// Namespace zombie_loom_web_attack
// Params 2, eflags: 0x4
// Checksum 0xd6a4078, Offset: 0x4e6
// Size: 0x2ca
function private function_5a48a73ee2c4ab48( var_2d27742912cc383c, var_d75eaefe66066143 )
{
    start_pos = self gettagorigin( var_2d27742912cc383c, 1 ) ?? ( 0, 0, 0 );
    local_start_pos = coordtransformtranspose( start_pos, self.origin, self.angles );
    var_e1b150b361aa0993 = isent( self.web_attack_target ) ? self.web_attack_target : undefined;
    self.var_ec263f0a689ef1dd = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_ead135c08a82370e;
    self._blackboard.var_6ac7c01b47866bee = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_1208fa2d0d55f581;
    gravity_scale = self.webweapon.var_4b34df4cbe697f89;
    var_267d01d2be2d145 = self function_d5e40e88a4ac1386( self.webweapon, var_e1b150b361aa0993, 0, 0, self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_d0e6b87134905218, self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_8032a879fa3c2c9e, self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_fb8d2d93bea31140, local_start_pos, self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_84d7ac6248ff8e9, gravity_scale );
    self.var_ec263f0a689ef1dd = self.var_d6894f01a36b4ff3.projectilespeedoverride;
    self._blackboard.var_6ac7c01b47866bee = self.var_d6894f01a36b4ff3.var_76fb5cbc92f9174e;
    
    if ( !isdefined( start_pos ) || !isdefined( var_267d01d2be2d145 ) )
    {
        return;
    }
    
    projectile = magicgrenademanual( self.webweapon, start_pos, var_267d01d2be2d145, self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_421a5f4e4090955e, self );
    projectile.angles = self gettagangles( var_2d27742912cc383c );
    projectile.owner = self;
    
    if ( var_d75eaefe66066143 )
    {
        projectile setmodel( var_d75eaefe66066143 );
    }
    
    projectile thread function_29494a18bd3990aa( self );
    projectile thread function_ca4a8f0725d5788e( self );
    projectile thread function_9015f6bc352ca61b( self );
    var_ad1efe5e8f84b51c = int( utility::function_4b74c15943231980( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_53441cf6eca3304d ) );
    self function_786bb6aa1b76c7ee( "web_attack_time", gettime() + var_ad1efe5e8f84b51c );
    
    if ( isplayer( var_e1b150b361aa0993 ) )
    {
        var_e1b150b361aa0993 function_884711fc94b10261();
        var_e1b150b361aa0993 function_a58e1bd7ca9f6222( "web_attack" );
        projectile thread function_b56b9dc4beab6efc( var_e1b150b361aa0993 );
    }
}

// Namespace zombie_loom_web_attack
// Params 1, eflags: 0x4
// Checksum 0x2bb81689, Offset: 0x7b8
// Size: 0x7b
function private function_29494a18bd3990aa( ai )
{
    self endon( #"delay_death" );
    childthread delay_endon( "death" );
    self waittill( #"projectile_impact_player", hitent );
    
    if ( isplayer( hitent ) )
    {
        if ( isalive( ai ) )
        {
            params = spawnstruct();
            params.player = hitent;
            ai callback::callback( "on_web_projectile_impact_player", params );
        }
    }
}

// Namespace zombie_loom_web_attack
// Params 1, eflags: 0x4
// Checksum 0xae931ec1, Offset: 0x83b
// Size: 0x7b
function private function_9015f6bc352ca61b( ai )
{
    self endon( #"delay_death" );
    childthread delay_endon( "death" );
    self waittill( #"projectile_impact_ai", hitent );
    
    if ( isai( hitent ) )
    {
        if ( isalive( ai ) )
        {
            params = spawnstruct();
            params.ai = hitent;
            ai callback::callback( "on_web_projectile_impact_ai", params );
        }
    }
}

// Namespace zombie_loom_web_attack
// Params 1, eflags: 0x4
// Checksum 0x52b82168, Offset: 0x8be
// Size: 0x7e
function private function_ca4a8f0725d5788e( ai )
{
    self endon( #"delay_death" );
    childthread delay_endon( "death" );
    self endon( #"projectile_impact_player" );
    self waittill( #"explode", position );
    
    if ( isalive( ai ) )
    {
        params = spawnstruct();
        params.position = position;
        ai callback::callback( "on_web_projectile_impact_world", params );
    }
}

// Namespace zombie_loom_web_attack
// Params 1, eflags: 0x4
// Checksum 0xf1985a0f, Offset: 0x944
// Size: 0x32
function private function_b56b9dc4beab6efc( player )
{
    self waittill( #"death" );
    
    if ( isdefined( player ) )
    {
        player function_88a6736ac53d2a25();
        player function_31d0b50675d9d6e( "web_attack" );
    }
}

// Namespace zombie_loom_web_attack
// Params 1, eflags: 0x4
// Checksum 0xb09d8c2b, Offset: 0x97e
// Size: 0x1e
function private delay_endon( string )
{
    self waittill( string );
    waitframe();
    self notify( "delay_" + string );
}

