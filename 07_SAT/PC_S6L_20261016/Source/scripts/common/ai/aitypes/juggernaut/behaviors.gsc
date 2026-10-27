// scripts\common\ai\aitypes\juggernaut\behaviors.gsc  (hash_40de8a418acf807b.gscc) (size: 3414 Bytes / 0xd56 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x66b7b109 (1723314441)
// size ...... 3414 (0xd56)
// includes .. 2   (offset: 0xc42)
// strings ... 19  (offset: 0xc52)
// dev strs .. 1   (offset: 0xd4a)
// exports ... 8   (offset: 0x85a)
// cseg ...... 0x129 + 0x731 (0x85a)
// imports ... 23  (offset: 0x99a)
// animtree1 . 0   (offset: 0xd56)
// animtree2 . 0   (offset: 0xd56)
#using scripts\common\cap;
#using scripts\common\utility;

#namespace behaviors;

// Namespace behaviors
// Params 1
// Checksum 0xd928e11c, Offset: 0x147
// Size: 0x31f
function function_d78086de89d42111( taskid )
{
    self.spec = "juggernaut";
    self.var_b37d3d9ac3aec3ad = 1;
    self allowedstances( "stand" );
    self.juggernaut = 1;
    self.dontmeleeme = 1;
    self.minpaindamage = 1000;
    self.grenadeammo = 0;
    self.doorflashchance = 0.05;
    self.aggressivemode = 1;
    self.ignoresuppression = 1;
    self.disablepistol = 1;
    self.var_ea826da7f0313e6a = 1;
    self.meleechargedistvsplayer = 150;
    self.meleechargedist = 150;
    self.meleestopattackdistsq = 22500;
    self.meleedamageoverride = 400;
    self.meleemaxzdiff = 500;
    self.var_11b2a6e302382a4b = 2500;
    self.meleetryhard = 0;
    self.meleeignorefinalzdiff = 0;
    self.meleeignoreplayerstance = 1;
    self.dontsyncmelee = 1;
    self.var_3b069f6418c8a803 = 50;
    self.meleerangesq = int( squared( 128 ) );
    self.disablebulletwhizbyreaction = 1;
    self setcanusecover( 0, "entity" );
    self.disablerunngun = 1;
    self.disabledodge = 1;
    self.pathenemyfightdist = 0;
    self.var_2f7b28254901f8d6 = 1;
    self.allowlongdeath = 0;
    self.var_c21cefdb0d231840 = 3000;
    self.var_1db1f2ef9c7f9036 = 750;
    self.var_aaf12cbad4692c1b = 300;
    self.var_47627bac27bc94ff = 750;
    self.var_e5d5b423587e876 = 300;
    self.var_d4b1e70a1931ada9 = 25;
    self.goalheight = 80;
    self.var_6b23d3ee096a27b4 = 0;
    self.cautiousnavigation = 0;
    self.cornercheckenabled = 0;
    self.var_1f8b3b00067dec6c = 40;
    self.var_c6f797c2ad63b8d6 = 1000;
    self.var_c71a89c2ad89e1c4 = 2000;
    self.var_26a62248c00aefec = 1000;
    self.var_26823048bfe293fe = 2000;
    self.var_de04c2fb38eec74a = 1;
    self.var_4db7986a3a6ac4c5 = self.unittype == "juggernaut";
    self.var_376245277a92fde3 = 57;
    self.var_aac9c74cd0f5eba8 = 1;
    self setlongdeathblocked( 1, "entity" );
    self function_5c50b48c0c81d566( "all", 0, "bt" );
    aitypescriptbundle = getaitypescriptbundle( self.classname );
    
    if ( aitypescriptbundle.var_61e44fac124dbd73 )
    {
        self allowvehiclepredictiveragdoll( 0 );
    }
    
    if ( !utility::issp() && level.gametype != "trial" && getprojectname() != "SAT" && getprojectname() != "REX" )
    {
        self giveweapon( "iw9_lm_dblmg_execution_mp" );
        self giveexecution( "jug_execution_000_stand_8", "iw9_lm_dblmg_execution_mp" );
    }
    
    /#
        setdvarifuninitialized( @"hash_45b89b729718bd15", 0 );
        setdvarifuninitialized( @"hash_55cdffcdb283c0cd", -1 );
    #/
    
    return anim.success;
}

// Namespace behaviors
// Params 1
// Checksum 0xd04fba8e, Offset: 0x46f
// Size: 0x126
function function_d548c8655deba223( taskid )
{
    var_691d6fcefa6250c = 10000;
    var_32f2fcfd319274c9 = 1;
    
    /#
        if ( getdvarint( @"hash_45b89b729718bd15" ) )
        {
            var_32f2fcfd319274c9 = 0;
        }
    #/
    
    if ( var_32f2fcfd319274c9 && !self.ballowexecutions )
    {
        return anim.failure;
    }
    
    if ( isdefined( self.var_28285b8ecb780d6d ) && gettime() - self.var_28285b8ecb780d6d < var_691d6fcefa6250c )
    {
        return anim.failure;
    }
    
    if ( self.var_f4875c5a4b65189 )
    {
        assert( isdefined( self.enemy ) );
        targettome = self.origin - self.enemy.origin;
        var_9c5a0a3cf6ab246b = vectortoyaw( targettome );
        angledelta = angleclamp180( var_9c5a0a3cf6ab246b - self.enemy.angles[ 1 ] );
        
        if ( angledelta < -45 || angledelta > 45 )
        {
            return anim.failure;
        }
    }
    
    return anim.success;
}

// Namespace behaviors
// Params 1
// Checksum 0x7e8beaf0, Offset: 0x59e
// Size: 0x188
function function_27965051b6b34587( taskid )
{
    self.var_28285b8ecb780d6d = gettime();
    assert( isdefined( self.enemy ) );
    targettome = self.origin - self.enemy.origin;
    var_9c5a0a3cf6ab246b = vectortoyaw( targettome );
    angledelta = angleclamp180( var_9c5a0a3cf6ab246b - self.enemy.angles[ 1 ] );
    var_bcd3b8c5a6506a18 = "jug_execution_";
    var_578bfec11200afcb = "_stand_";
    var_2da68790b5b9ee8e = "00";
    dir = "8";
    
    if ( angledelta < 45 && angledelta > -45 )
    {
        var_c60af8076179d10 = randomint( 4 );
        var_2da68790b5b9ee8e += var_c60af8076179d10;
    }
    else
    {
        var_c60af8076179d10 = randomint( 2 );
        var_2da68790b5b9ee8e += var_c60af8076179d10;
        
        if ( angledelta < -135 || angledelta > 135 )
        {
            dir = "2";
        }
        else if ( angledelta >= 45 )
        {
            dir = "4";
        }
        else
        {
            dir = "6";
        }
    }
    
    /#
        var_2d3755f4419d859b = getdvarint( @"hash_55cdffcdb283c0cd" );
        
        if ( var_2d3755f4419d859b >= 0 )
        {
            var_2da68790b5b9ee8e = "<dev string:x24>" + var_2d3755f4419d859b;
        }
    #/
    
    var_225e95241f12b16c = var_bcd3b8c5a6506a18 + var_2da68790b5b9ee8e + var_578bfec11200afcb + dir;
    self giveexecution( var_225e95241f12b16c, "iw9_lm_dblmg_execution_mp" );
    return anim.success;
}

// Namespace behaviors
// Params 1
// Checksum 0x4c19f2d8, Offset: 0x72f
// Size: 0x6e
function function_2c95ef4851a39f0c( taskid )
{
    self.var_501f5af0d865449 = 1;
    
    if ( self pathdisttogoal() > 256 && self aigetdesiredspeed() > 70 )
    {
        self.var_347849d6e7b2b666 = 1;
    }
    
    self._blackboard.bseqphase = undefined;
    thread cap::cap_start( "cap_jugg_sweep", "cap_jugg_sweep" );
    thread function_6df67239c974e2ff();
    return anim.success;
}

// Namespace behaviors
// Params 1
// Checksum 0xf3ea6803, Offset: 0x7a6
// Size: 0x2c
function function_a6e16add02cb9f5f( taskid )
{
    if ( isdefined( self.var_501f5af0d865449 ) )
    {
        return anim.running;
    }
    
    return anim.success;
}

// Namespace behaviors
// Params 1
// Checksum 0x7c43ef55, Offset: 0x7db
// Size: 0x52
function function_8180f399c8ed8cc1( taskid )
{
    if ( isdefined( self.var_501f5af0d865449 ) )
    {
        self.var_501f5af0d865449 = undefined;
        
        if ( !isdefined( self._blackboard.bseqphase ) )
        {
            self._blackboard.bseqphase = "abort";
        }
    }
}

// Namespace behaviors
// Params 0
// Checksum 0xa6fe9d29, Offset: 0x835
// Size: 0x25
function function_6df67239c974e2ff()
{
    self endon( #"death" );
    self waittill( #"cap_exit_completed" );
    self.var_501f5af0d865449 = undefined;
}

