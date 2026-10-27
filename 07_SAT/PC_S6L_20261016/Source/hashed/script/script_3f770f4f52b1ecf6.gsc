// script_3f770f4f52b1ecf6  (hash_3f770f4f52b1ecf6.gscc) (size: 3743 Bytes / 0xe9f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x910580c9 (2433056969)
// size ...... 3743 (0xe9f)
// includes .. 3   (offset: 0xde7)
// strings ... 10  (offset: 0xdff)
// dev strs .. 0   (offset: 0xe9f)
// exports ... 16  (offset: 0x78f)
// cseg ...... 0x146 + 0x649 (0x78f)
// imports ... 31  (offset: 0xa0f)
// animtree1 . 0   (offset: 0xe9f)
// animtree2 . 0   (offset: 0xe9f)
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;

#namespace namespace_b0dcc24b66949d4;

// Namespace namespace_b0dcc24b66949d4
// Params 0
// Checksum 0x8191c2aa, Offset: 0x164
// Size: 0x2
function function_999613718bee9338()
{
    
}

// Namespace namespace_b0dcc24b66949d4
// Params 0
// Checksum 0xfb4f3179, Offset: 0x16e
// Size: 0x3b
function function_a45f0f32c558af3()
{
    thread function_bdf648aa7e1dabb1();
    thread deathcleanup();
    self endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"showing_final_killcam" );
    childthread function_a3a5fcd034c5275b();
}

// Namespace namespace_b0dcc24b66949d4
// Params 0
// Checksum 0xcc6f4f7e, Offset: 0x1b1
// Size: 0x5b
function function_a3a5fcd034c5275b()
{
    while ( true )
    {
        if ( isdefined( self.currentweapon ) && function_229f7625af5913c5( self.currentweapon ) )
        {
            if ( level.auto_update_bulletdrop )
            {
                childthread targetdistanceupdate();
            }
            else
            {
                childthread function_40341a3ce5f8cfd6();
            }
            
            childthread function_8c7098e6b98bba02();
        }
        
        self waittill( #"weapon_change" );
    }
}

// Namespace namespace_b0dcc24b66949d4
// Params 1
// Checksum 0x743510c1, Offset: 0x214
// Size: 0x3d, Type: bool
function function_229f7625af5913c5( weaponobj )
{
    if ( isdefined( weaponobj ) && isdefined( weaponobj.scope ) && isstartstr( weaponobj.scope, "snscope_drop" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_b0dcc24b66949d4
// Params 0
// Checksum 0xd6a8fde6, Offset: 0x25a
// Size: 0xb0
function function_40341a3ce5f8cfd6()
{
    self endon( #"weapon_change" );
    contents = trace::create_contents( 1, 1, 1, 0, 0, 1, 0, 0, 0, 0 );
    
    while ( true )
    {
        waitframe();
        
        if ( !self playerads() )
        {
            continue;
        }
        
        start = self geteye();
        end = trace::ray_trace( start, start + anglestoforward( level.player getplayerangles() ) * 99999, undefined, contents )[ "position" ];
        distance = length( start - end );
        self setclientomnvar( "ui_scope_range_finder_distance", int( distance * 0.0254 ) );
    }
}

// Namespace namespace_b0dcc24b66949d4
// Params 0
// Checksum 0xdeb433fc, Offset: 0x312
// Size: 0x76
function targetdistanceupdate()
{
    self endon( #"weapon_change" );
    thread targetenemychanged();
    contents = trace::create_contents( 1, 1, 1, 0, 0, 1, 0, 0, 0, 0 );
    
    while ( true )
    {
        waitframe();
        
        while ( isdefined( level.target_guy ) )
        {
            waitframe();
        }
        
        thread function_ec1236c1c91dbd49( contents );
        
        while ( !isdefined( level.target_guy ) )
        {
            waitframe();
        }
        
        level notify( #"target_sighted" );
    }
}

// Namespace namespace_b0dcc24b66949d4
// Params 1
// Checksum 0xb8a36fc0, Offset: 0x390
// Size: 0x9c
function function_ec1236c1c91dbd49( contents )
{
    level endon( #"target_sighted" );
    
    while ( true )
    {
        waitframe();
        
        if ( !self playerads() )
        {
            continue;
        }
        
        start = self geteye();
        end = trace::ray_trace( start, start + anglestoforward( level.player getplayerangles() ) * 99999, undefined, contents )[ "position" ];
        distance = length( start - end );
        self setclientomnvar( "ui_scope_range_finder_distance", int( distance * 0.0254 ) );
    }
}

// Namespace namespace_b0dcc24b66949d4
// Params 0
// Checksum 0x9aa6460b, Offset: 0x434
// Size: 0x93
function targetenemychanged()
{
    lastenemy = undefined;
    thread function_5c184fd6b31df0f1();
    
    while ( true )
    {
        waitframe();
        enemies = getaiarray( "axis" );
        
        if ( enemies.size <= 0 )
        {
            while ( enemies.size <= 0 )
            {
                waitframe();
                enemies = getaiarray( "axis" );
            }
        }
        
        currentenemy = [[ self.var_3ae8574fa2a9b542 ]]( enemies );
        
        if ( !isdefined( currentenemy ) )
        {
            continue;
        }
        
        if ( lastenemy != currentenemy )
        {
            level notify( #"target_changed" );
        }
        
        lastenemy = currentenemy;
        waittillframeend();
        thread targetenemy( currentenemy );
    }
}

// Namespace namespace_b0dcc24b66949d4
// Params 0
// Checksum 0x66335c2c, Offset: 0x4cf
// Size: 0x76
function function_5c184fd6b31df0f1()
{
    for ( startingenemies = undefined; !isdefined( startingenemies ) ; startingenemies = getaiarray( "axis" ) )
    {
        waitframe();
    }
    
    while ( true )
    {
        waitframe();
        currentenemies = getaiarray( "axis" );
        
        if ( !isdefined( currentenemies ) )
        {
            continue;
        }
        
        if ( currentenemies.size < startingenemies.size )
        {
            startingenemies = currentenemies;
            continue;
        }
        
        if ( currentenemies.size > startingenemies.size )
        {
            level notify( #"scope_timeout" );
            startingenemies = currentenemies;
        }
    }
}

// Namespace namespace_b0dcc24b66949d4
// Params 1
// Checksum 0x27ee555b, Offset: 0x54d
// Size: 0x7e
function targetenemy( enemy )
{
    enemy endon( #"death" );
    level endon( #"target_changed" );
    
    while ( true )
    {
        waitframe();
        
        if ( !self playerads() )
        {
            continue;
        }
        
        start = self geteye();
        distance = length( start - enemy.origin );
        self setclientomnvar( "ui_scope_range_finder_distance", int( distance * 0.0254 ) );
    }
}

// Namespace namespace_b0dcc24b66949d4
// Params 0
// Checksum 0x85bddbe4, Offset: 0x5d3
// Size: 0x94
function function_8c7098e6b98bba02()
{
    self endon( #"weapon_change" );
    
    while ( true )
    {
        if ( level.auto_update_bulletdrop )
        {
            function_6a38bb706c36fc23();
        }
        else if ( self playerads() == 1 && self sprintbuttonpressed() )
        {
            pressstarttime = gettime();
            
            while ( self playerads() == 1 && self sprintbuttonpressed() )
            {
                waitframe();
            }
            
            if ( self playerads() == 1 )
            {
                timepressed = gettime() - pressstarttime;
                
                if ( timepressed < 200 )
                {
                    function_6a38bb706c36fc23();
                }
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_b0dcc24b66949d4
// Params 0
// Checksum 0xc2e41090, Offset: 0x66f
// Size: 0x71
function function_6a38bb706c36fc23()
{
    range = self getclientomnvar( "ui_scope_range_finder_distance" );
    
    if ( range < 30 )
    {
        range = 0;
    }
    
    self setclientomnvar( "ui_scope_range_finder_distance_locked", int( range ) );
    drop = function_63a8f1f9d911afa9( range );
    self setclientomnvar( "ui_scope_range_finder_bulletdrop", int( drop ) );
    self setclientomnvar( "ui_scope_range_finder_bulletdrop_update", 1 );
    waitframe();
    self setclientomnvar( "ui_scope_range_finder_bulletdrop_update", 0 );
}

// Namespace namespace_b0dcc24b66949d4
// Params 1
// Checksum 0x29c5cd6b, Offset: 0x6e8
// Size: 0x5f
function function_63a8f1f9d911afa9( range )
{
    drop = math::normalize_value( 0, 2000, range );
    factor = math::factor_value( 0, 200, drop );
    
    if ( isdefined( level.var_e8e70aa080e87f22 ) )
    {
        factor *= 2.9;
    }
    else
    {
        factor *= 1.2;
    }
    
    return factor;
}

// Namespace namespace_b0dcc24b66949d4
// Params 0
// Checksum 0x2d9f87d9, Offset: 0x750
// Size: 0x18
function function_bdf648aa7e1dabb1()
{
    utility::waittill_any( "death", "disconnect", "showing_final_killcam" );
}

// Namespace namespace_b0dcc24b66949d4
// Params 0
// Checksum 0x932a5834, Offset: 0x770
// Size: 0x1f
function deathcleanup()
{
    self endon( #"disconnect" );
    utility::waittill_any( "death", "showing_final_killcam" );
}

