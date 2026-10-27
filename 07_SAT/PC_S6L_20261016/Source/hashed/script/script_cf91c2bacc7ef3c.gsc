// script_cf91c2bacc7ef3c  (hash_0cf91c2bacc7ef3c.gscc) (size: 4084 Bytes / 0xff4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x21e977e7 (568948711)
// size ...... 4084 (0xff4)
// includes .. 6   (offset: 0xf10)
// strings ... 13  (offset: 0xf40)
// dev strs .. 0   (offset: 0xff4)
// exports ... 10  (offset: 0x9d0)
// cseg ...... 0x146 + 0x88a (0x9d0)
// imports ... 32  (offset: 0xb60)
// animtree1 . 0   (offset: 0xff4)
// animtree2 . 0   (offset: 0xff4)
#using script_52b2d6abd048104c;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\ztron\ztron_debug;
#using scripts\mp\zm\ztron\ztron_hazard;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace ztron_hazard_rune_statue;

// Namespace ztron_hazard_rune_statue
// Params 0, eflags: 0x5
// Checksum 0x2823a50d, Offset: 0x164
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ztron_hazard_rune_statue", #"ztron_hazards", undefined, &init );
}

// Namespace ztron_hazard_rune_statue
// Params 0
// Checksum 0xb49436af, Offset: 0x18d
// Size: 0x20
function init()
{
    ztron_hazard::function_6f661fac5fd31f1( #"runestatue", #"arenaspawn", &init_hazard_rune_statue );
}

// Namespace ztron_hazard_rune_statue
// Params 0
// Checksum 0xa16cef50, Offset: 0x1b5
// Size: 0x1b5
function init_hazard_rune_statue()
{
    arena = level.ztron.active_arena;
    statue_center = utility::getstruct( arena.name + "_statue_center", "targetname" );
    
    if ( !isdefined( statue_center ) )
    {
        return;
    }
    
    rune_statue = utility::spawn_model( "tag_origin", statue_center.origin );
    rune_statue.statue_center = statue_center;
    rune_statue.var_8988d5b4a762bdb3 = utility::getstruct( arena.name + "_ball_spawn", "targetname" );
    rune_statue.depress_trigger = ztron_util::function_2d9de5c7b97db39( arena.name + "_depress_trigger", #targetname );
    
    foreach ( depresstrigger in rune_statue.depress_trigger )
    {
        depresstrigger.scriptable = spawnscriptable( "ztron_rune_statue_fx", depresstrigger.origin, depresstrigger.angles );
    }
    
    rune_statue.var_2f389114ecdf856b = 0;
    rune_statue.activating = 0;
    rune_statue.ztron = spawnstruct();
    rune_statue thread function_9adf8d8e2f95de02();
    level.ztron.rune_statue = rune_statue;
}

// Namespace ztron_hazard_rune_statue
// Params 0, eflags: 0xc
// Checksum 0xecf0ba57, Offset: 0x372
// Size: 0xcb
function private function_9adf8d8e2f95de02()
{
    self notify( #"hash_abd7953de263b806" );
    self endon( #"hash_abd7953de263b806" );
    self endon( #"death" );
    self endon( #"hash_fa7da3b9dec7e4de" );
    
    foreach ( trigger in self.depress_trigger )
    {
        trigger thread depress_trigger_think();
    }
    
    thread function_97d4158cfd4196db();
    
    while ( true )
    {
        if ( function_ebccc90a4feb5c71() )
        {
            activateRuneStatue();
        }
        
        waitframe();
    }
}

// Namespace ztron_hazard_rune_statue
// Params 0, eflags: 0x4
// Checksum 0x19e4c0f0, Offset: 0x445
// Size: 0xc4
function private function_ebccc90a4feb5c71()
{
    if ( self.activating )
    {
        return 0;
    }
    
    if ( self.var_2f389114ecdf856b > gettime() )
    {
        return 0;
    }
    
    alltriggered = 1;
    index = 0;
    
    foreach ( trigger in self.depress_trigger )
    {
        index++;
        
        if ( !trigger.triggered )
        {
            alltriggered = 0;
            break;
        }
    }
    
    return alltriggered;
}

// Namespace ztron_hazard_rune_statue
// Params 0, eflags: 0x4
// Checksum 0xbd4d0112, Offset: 0x512
// Size: 0x162
function private activateRuneStatue()
{
    self.activating = 1;
    ztron_debug::debugmsg( "activateRuneStatue" );
    thread function_d9dcc70b159d26d7();
    wait 0.2;
    direction = self.var_8988d5b4a762bdb3.origin - self.statue_center.origin;
    params = spawnstruct();
    params.duration = 30;
    params.num = 10;
    params.force = 400;
    params.radius = length( direction );
    params.maxradius = params.radius + 100;
    params.angle = vectortoyaw( vectornormalize( direction ) );
    params.notcollapse = 1;
    params.rotatespeed = 45;
    params.expandtime = 2.5;
    params.endnote = "rune_statue_tesla_ball_end";
    params.zoffset = 0;
    thread namespace_3b4a83e58739c229::activateteslaball( self, params );
    self waittill( #"rune_statue_tesla_ball_end" );
    self.var_2f389114ecdf856b = gettime() + getdvarint( @"hash_66d060b8b0f26a10", 300 ) * 1000;
    self.activating = 0;
}

// Namespace ztron_hazard_rune_statue
// Params 0, eflags: 0x4
// Checksum 0xac01cb99, Offset: 0x67c
// Size: 0x3d
function private function_d9dcc70b159d26d7()
{
    self endon( #"death" );
    playfxontag( utility::getfx( "ztron_hazard_rune_statue_activate" ), self, "tag_origin" );
    wait 2;
    stopfxontag( utility::getfx( "ztron_hazard_rune_statue_activate" ), self, "tag_origin" );
}

// Namespace ztron_hazard_rune_statue
// Params 0, eflags: 0xc
// Checksum 0xfc79b140, Offset: 0x6c1
// Size: 0x174
function private function_97d4158cfd4196db()
{
    self notify( #"hash_df9520ff49d3e369" );
    self endon( #"hash_df9520ff49d3e369" );
    self endon( #"death" );
    thread ztron_hazard::function_4d643b159a80c647( 0 );
    self waittill( #"destroy_hazard" );
    
    foreach ( depresstrigger in self.depress_trigger )
    {
        depresstrigger notify( #"deactive_trigger" );
    }
    
    level.ztron.rune_statue = undefined;
    wait 0.5;
    self notify( #"hash_fa7da3b9dec7e4de" );
    waitframe();
    
    foreach ( depresstrigger in self.depress_trigger )
    {
        if ( isdefined( depresstrigger.scriptable ) )
        {
            depresstrigger.scriptable freescriptable();
            depresstrigger.scriptable = undefined;
        }
    }
    
    self delete();
}

// Namespace ztron_hazard_rune_statue
// Params 0, eflags: 0xc
// Checksum 0x6cad5d10, Offset: 0x83d
// Size: 0x193
function private depress_trigger_think()
{
    self notify( #"hash_11ecf1afa3a77e3c" );
    self endon( #"hash_11ecf1afa3a77e3c" );
    self endon( #"deactive_trigger" );
    self endon( #"death" );
    self.triggered = 0;
    self.scriptable setscriptablepartstate( "base", "no_power" );
    
    while ( true )
    {
        nowtime = gettime();
        triggered = 0;
        
        foreach ( player in level.players )
        {
            if ( player istouching( self ) )
            {
                triggered = 1;
                break;
            }
        }
        
        if ( triggered )
        {
            if ( !self.triggered )
            {
                self.scriptable setscriptablepartstate( "base", "activate" );
            }
            
            self.triggered = 1;
            self.triggeredtime = nowtime;
        }
        else if ( self.triggered )
        {
            if ( nowtime - self.triggeredtime > getdvarfloat( @"hash_eff82304144bab04", 0.5 ) * 1000 )
            {
                self.scriptable setscriptablepartstate( "base", "cooldown" );
                self.triggered = 0;
            }
        }
        
        wait 0.1;
    }
}

