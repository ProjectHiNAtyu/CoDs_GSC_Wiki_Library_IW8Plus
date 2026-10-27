// script_6559b97af8aaf4bd  (hash_6559b97af8aaf4bd.gscc) (size: 9199 Bytes / 0x23ef / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc1bdcf7d (3250442109)
// size ...... 9199 (0x23ef)
// includes .. 6   (offset: 0x219b)
// strings ... 26  (offset: 0x21cb)
// dev strs .. 11  (offset: 0x236b)
// exports ... 24  (offset: 0x143b)
// cseg ...... 0x2c0 + 0x117b (0x143b)
// imports ... 80  (offset: 0x17fb)
// animtree1 . 0   (offset: 0x23ef)
// animtree2 . 0   (offset: 0x23ef)
#using script_53651341190c5aab;
#using scripts\asm\asm;
#using scripts\asm\cap\interactions\cap_ai_revival;
#using scripts\common\cap;
#using scripts\common\utility;
#using scripts\common\values;

#namespace ai_revival;

// Namespace ai_revival
// Params 1
// Checksum 0x8a3b144f, Offset: 0x2de
// Size: 0x122
function getfunction( funcid )
{
    switch ( funcid )
    {
        case #"hash_dab0d83df51da4d":
            return &onuserinit;
        case #"hash_722d767fd6d40f56":
            return &onuserterminate;
        case #"hash_902f9e79d5e57c83":
            return &oneventreceived;
        case #"hash_ae182ac0084f18fa":
            return &movingtodyingguy;
        case #"hash_cfc067e44f70f86b":
            return &reviving;
        case #"hash_e7ffa3549475787":
            return &dyingguybeingrevived;
        case #"hash_f5cf55913a442596":
            return &earlyrevivedsuccess;
        case #"hash_303d74db152a39b9":
            return &interaction_common::function_ac09dd92b7250c46;
        case #"hash_707105c84039143f":
            return &tookdamageduringrevive;
        case #"hash_be6abeab18f64c91":
            return &moveintoposition;
        case #"hash_25397093dba07e3a":
            return &remoterevive;
        case #"hash_2a5b537d23266f19":
            return &providecoverfire;
        case #"hash_669a3d0df855846d":
            return &beingremoterevived;
        case #"hash_18372b0f69e4b08c":
            return &waitforreviver;
    }
    
    assertmsg( "<dev string:x24>" + funcid );
}

// Namespace ai_revival
// Params 1
// Checksum 0xfca99481, Offset: 0x408
// Size: 0x58
function onuserinit( interactionid )
{
    self.revival = spawnstruct();
    self.revival.initialhealth = self.health;
    
    if ( self.doinglongdeath )
    {
        self.revival.var_e0abaa4348755a5c = 1;
    }
}

// Namespace ai_revival
// Params 1
// Checksum 0x974f244c, Offset: 0x468
// Size: 0x21d
function onuserterminate( interactionid )
{
    /#
        if ( isagent( self ) )
        {
            assert( self isscriptable(), "<dev string:x42>" + self.agent_type + "<dev string:x4f>" );
        }
    #/
    
    scriptablepart = "revival_helper_stim";
    
    if ( self isscriptable() && self getscriptablehaspart( scriptablepart ) )
    {
        self setscriptablepartstate( scriptablepart, "default" );
    }
    
    self.pushable = 1;
    self.skipdyingbackcrawl = 0;
    bisalive = isalive( self );
    var_e0abaa4348755a5c = self.revival.var_e0abaa4348755a5c;
    
    if ( self islinked() )
    {
        /#
            println( "<dev string:x68>" );
            println( "<dev string:x8f>" );
            
            if ( var_e0abaa4348755a5c )
            {
                println( "<dev string:x9c>" );
            }
            else
            {
                println( "<dev string:xac>" );
            }
            
            if ( bisalive )
            {
                println( "<dev string:xb8>" );
            }
            else
            {
                println( "<dev string:xc0>" );
            }
            
            println( "<dev string:xca>" );
        #/
        
        self motionwarpcancel();
        self unlink();
    }
    
    if ( !bisalive )
    {
        function_dd518df9ee8d217c( interactionid, "death", 1 );
    }
    else
    {
        if ( var_e0abaa4348755a5c )
        {
            self.ignoreall = 0;
        }
        else
        {
            if ( self.stealth_bsmstate == 0 )
            {
                function_dd518df9ee8d217c( interactionid, "stealth_idle", 1 );
            }
            else if ( self.asmname == self.defaultasm )
            {
                function_dd518df9ee8d217c( interactionid, "death", 1 );
            }
            
            self.customarrivalstanceoverride = undefined;
            self.var_f683b9aaeb09d20e = 0;
            self.var_7362dcf4058bc522 = 0;
            self clearbtgoal( 3 );
            
            if ( self.var_c7d51f68e3d4a6e1 )
            {
                function_ea3f4aa8f5f16cdf();
                coveringfirecleanup();
            }
        }
        
        if ( self.doinglongdeath )
        {
            bleedoutbooster = self.revive_bleedouttime ?? 5000;
            self.desiredtimeofdeath = gettime() + bleedoutbooster;
        }
        
        utility::delaythreadendon( 5, "death", &val::reset_all, "revival" );
    }
    
    self notify( #"end_revival" );
}

// Namespace ai_revival
// Params 3
// Checksum 0x956e175d, Offset: 0x68d
// Size: 0x8e, Type: bool
function oneventreceived( receiver, info, origin )
{
    if ( info == "focused_on" && !utility::doinglongdeath() )
    {
        distsq = distancesquared( receiver.origin, origin );
        breakoutdist = 200;
        
        if ( distsq < breakoutdist * breakoutdist && !function_521b5a0a07a246a8( self getinteractionid(), "death" ) )
        {
            function_dd518df9ee8d217c( self getinteractionid(), "death", 1 );
            return true;
        }
    }
    
    return false;
}

// Namespace ai_revival
// Params 2
// Checksum 0x9a794bf1, Offset: 0x724
// Size: 0x468
function movingtodyingguy( statename, params )
{
    self endon( #"death" );
    self endon( #"end_revival" );
    dyingguy = getdyingguy();
    
    if ( !isdefined( dyingguy ) )
    {
        earlyoutinteraction();
    }
    
    dyingguy endon( #"death" );
    dyingguy endon( #"end_revival" );
    goalrad = 10;
    dyingguypos = dyingguy.origin;
    self setbtgoalpos( 3, dyingguypos );
    self setbtgoalradius( 3, goalrad );
    self waittill( #"path_set" );
    
    if ( self.team == "axis" )
    {
        val::set( "revival", "attackeraccuracy", 0.6 );
        dyingguy val::set( "revival", "attackeraccuracy", 0.6 );
    }
    else
    {
        val::set( "revival", "attackeraccuracy", 0.15 );
        dyingguy val::set( "revival", "attackeraccuracy", 0.15 );
    }
    
    dyingguy.desiredtimeofdeath += 20000;
    self.var_f683b9aaeb09d20e = 1;
    self.var_7362dcf4058bc522 = 1;
    var_238f3d0246d8726d = 200;
    
    for ( pathlength = self pathdisttogoal(); pathlength > var_238f3d0246d8726d ; pathlength = self pathdisttogoal() )
    {
        if ( !isdefined( dyingguy ) )
        {
            earlyoutinteraction();
        }
        
        dyingguypos = dyingguy.origin;
        self setbtgoalpos( 3, dyingguypos );
        wait 0.2;
    }
    
    if ( !isdefined( dyingguy ) )
    {
        earlyoutinteraction();
    }
    
    dyingguy animmode( "angle deltas" );
    dyingguy.skipdyingbackcrawl = 1;
    dyingguy asmfireevent( dyingguy.asmname, "dying_back_crawl_done" );
    dyingguypos = dyingguy.origin;
    dyingguy.pushable = 0;
    self.pushable = 0;
    introalias = function_dd687aabb00ca84e( dyingguy );
    rolestring = "reviving_guy";
    capinfo = getcapinfoforrole( self, rolestring );
    arcanimset = capinfo.animation;
    introstate = "reviving_intro";
    alias = archetypegetalias( arcanimset, introstate, introalias );
    animation = alias.anims;
    startorigin = getstartorigin( dyingguy.origin, dyingguy.angles, animation );
    startangles = getstartangles( dyingguy.origin, dyingguy.angles, animation );
    
    if ( !ispointonnavmesh( startorigin, self ) )
    {
        newalias = function_8e6601c7cd695bf1( introalias );
        alias = archetypegetalias( arcanimset, introstate, newalias );
        animation = alias.anims;
        startorigin = getstartorigin( dyingguy.origin, dyingguy.angles, animation );
        startangles = getstartangles( dyingguy.origin, dyingguy.angles, animation );
        
        if ( !ispointonnavmesh( startorigin, self ) )
        {
            dyingguy.var_38a06ee92c60ee9e = 0;
            function_dd518df9ee8d217c( self getinteractionid(), "death", 1 );
        }
    }
    
    self.revivetargetpos = startorigin;
    self setbtgoalpos( 3, self.revivetargetpos );
    self.revivetargetangles = startangles;
    self.customarrivalangles = self.revivetargetangles;
    self.customarrivalstanceoverride = "crouch";
    var_6dae028fbad50a3 = 2;
    utility::waittill_any_timeout( var_6dae028fbad50a3, "bt_goal" );
    
    while ( self.arriving )
    {
        waitframe();
    }
    
    if ( !isdefined( dyingguy ) )
    {
        earlyoutinteraction();
    }
    
    self.customarrivalstanceoverride = undefined;
    var_2552b57970937635 = 1024;
    var_9d37a8cc37caafc8 = distancesquared( self.origin, self.revivetargetpos );
    
    if ( var_9d37a8cc37caafc8 < var_2552b57970937635 )
    {
        cap::cap_start( "cap_ai_revival", "cap_ai_revival" );
        self waittill( #"reviving_intro_starts" );
    }
    else
    {
        function_dd518df9ee8d217c( self getinteractionid(), "death", 1 );
    }
    
    self.var_f683b9aaeb09d20e = 0;
    self clearbtgoal( 3 );
}

// Namespace ai_revival
// Params 2
// Checksum 0x1a311a7f, Offset: 0xb94
// Size: 0x8f
function reviving( statename, params )
{
    self endon( #"death" );
    self endon( #"end_revival" );
    self endon( #"cap_exit_completed" );
    childthread adjustpos();
    wait 0.3;
    downedguy = getdyingguy();
    self.var_f683b9aaeb09d20e = 0;
    
    if ( isdefined( downedguy ) )
    {
        self linktoblendtotag( downedguy, "tag_sync" );
    }
    
    self waittill( #"cap_exit_completed" );
    self.var_3724cf9bb3ac6bf7 = gettime();
}

// Namespace ai_revival
// Params 2
// Checksum 0x7ca7de10, Offset: 0xc2b
// Size: 0xe0
function dyingguybeingrevived( statename, params )
{
    self endon( #"death" );
    self endon( #"end_revival" );
    cap::cap_start( "cap_ai_revival", "cap_ai_revival" );
    
    while ( !asm::asm_ephemeraleventfired( "being_revived", "end" ) )
    {
        self.desiredtimeofdeath += level.frameduration;
        waitframe();
    }
    
    self.doinglongdeath = 0;
    
    if ( level.longdeath.revivepct > 0 )
    {
        self.health = int( level.longdeath.revivepct * self.maxhealth );
    }
    else
    {
        self.health = 150;
    }
    
    self waittill( #"cap_exit_completed" );
    function_410675d68e6e1260();
}

// Namespace ai_revival
// Params 2
// Checksum 0xf8356cf1, Offset: 0xd13
// Size: 0xbc
function earlyrevivedsuccess( statename, params )
{
    self endon( #"death" );
    self endon( #"end_revival" );
    asm::asm_fireevent( self.asmname, "early_revived_success" );
    
    if ( self.doinglongdeath )
    {
        self.doinglongdeath = 0;
        
        if ( level.longdeath.revivepct > 0 )
        {
            self.health = int( level.longdeath.revivepct * self.maxhealth );
        }
        else
        {
            self.health = 150;
        }
    }
    
    self waittill( #"cap_exit_completed" );
    function_410675d68e6e1260();
}

// Namespace ai_revival
// Params 2
// Checksum 0xf81dc79f, Offset: 0xdd7
// Size: 0x129
function moveintoposition( statename, params )
{
    self endon( #"death" );
    self endon( #"end_revival" );
    self setcanusecover( 0 );
    self allowedstances( "stand" );
    self.revivetarget = getdyingguy();
    targetpos = self.revivetarget.origin;
    canseedyingguy = self cansee( self.revivetarget );
    
    if ( !canseedyingguy || distancesquared( self.origin, targetpos ) > self.var_170e6bf47c501c90 * self.var_170e6bf47c501c90 )
    {
        targeteyepos = self.revivetarget getapproxeyepos();
        goalpos = findclosestlospointwithinradius( targeteyepos, self.var_170e6bf47c501c90, targeteyepos, self.origin );
        self setbtgoalpos( 3, goalpos );
        self setbtgoalradius( 3, 32 );
        self waittill( #"bt_goal" );
    }
    else
    {
        self setbtgoalstationary( 3 );
    }
    
    while ( self.arriving )
    {
        waitframe();
    }
}

// Namespace ai_revival
// Params 2
// Checksum 0x75732352, Offset: 0xf08
// Size: 0x4b
function remoterevive( statename, params )
{
    self endon( #"death" );
    self endon( #"end_revival" );
    cap::cap_start( "cap_ai_revival", "cap_ai_revival" );
    self waittill( #"cap_exit_completed" );
}

// Namespace ai_revival
// Params 2
// Checksum 0x34853338, Offset: 0xf5b
// Size: 0xa0
function providecoverfire( statename, params )
{
    self endon( #"death" );
    self endon( #"end_revival" );
    self.revivetarget = undefined;
    self.bulletsinclip = weaponclipsize( self.weapon );
    self.cachemaxfaceenemydist = self.maxfaceenemydist;
    self.maxfaceenemydist = 2048;
    self.providecoveringfire = 1;
    self.balwayscoverexposed = 1;
    self.shootstyleoverride = "full";
    wait self.var_8b0758c75353b418;
    coveringfirecleanup();
}

// Namespace ai_revival
// Params 2
// Checksum 0x40e3ac27, Offset: 0x1003
// Size: 0x3a
function waitforreviver( statename, params )
{
    self endon( #"death" );
    self endon( #"end_revival" );
    self waittill( #"shot_by_revive_pistol" );
}

// Namespace ai_revival
// Params 2
// Checksum 0x49f2855c, Offset: 0x1045
// Size: 0x67
function beingremoterevived( statename, params )
{
    self endon( #"death" );
    self endon( #"end_revival" );
    cap::cap_start( "cap_ai_revival", "cap_ai_revival" );
    self waittill( #"cap_exit_completed" );
    self.doinglongdeath = 0;
    self.health = self.maxhealth;
}

// Namespace ai_revival
// Params 0, eflags: 0x4
// Checksum 0x87841316, Offset: 0x10b4
// Size: 0x4b
function private coveringfirecleanup()
{
    if ( !isdefined( self.cachemaxfaceenemydist ) )
    {
        return;
    }
    
    self.providecoveringfire = 0;
    self.balwayscoverexposed = 0;
    self.shootstyleoverride = undefined;
    self.maxfaceenemydist = self.cachemaxfaceenemydist;
    self.cachemaxfaceenemydist = undefined;
}

// Namespace ai_revival
// Params 0, eflags: 0x4
// Checksum 0x80907b83, Offset: 0x1107
// Size: 0x3a
function private function_ea3f4aa8f5f16cdf()
{
    self.ignoreall = 0;
    self.combatmode = "cover";
    self setcanusecover( 1 );
    self allowedstances( "stand", "crouch" );
    self clearbtgoal( 3 );
}

// Namespace ai_revival
// Params 0, eflags: 0x4
// Checksum 0x1508617f, Offset: 0x1149
// Size: 0x21
function private function_410675d68e6e1260()
{
    helper = function_7ea6d66bfed6ffa9();
    
    if ( isdefined( helper ) )
    {
        helper unlink();
    }
}

// Namespace ai_revival
// Params 0, eflags: 0x4
// Checksum 0x4f701a90, Offset: 0x1172
// Size: 0x13a
function private adjustpos()
{
    startpos = self.origin;
    startangles = self.angles;
    assert( isdefined( self.revivetargetpos ) && isdefined( self.revivetargetangles ), "<dev string:xf9>" );
    
    if ( !isdefined( self.revivetargetpos ) || !isdefined( self.revivetargetangles ) )
    {
        return;
    }
    
    stilltoofar = distancesquared( startpos, self.revivetargetpos ) > 100;
    var_c3f330787d5d2243 = absangleclamp180( startangles[ 1 ] - self.revivetargetangles[ 1 ] ) > 7;
    
    if ( stilltoofar || var_c3f330787d5d2243 )
    {
        interval = 300;
        endtime = gettime() + interval;
        
        while ( endtime > gettime() )
        {
            fraction = 1 - ( endtime - gettime() ) / interval;
            newpos = vectorlerp( startpos, self.revivetargetpos, fraction );
            newangles = anglelerpquatfrac( startangles, self.revivetargetangles, fraction );
            self forceteleport( newpos, newangles );
            waitframe();
        }
    }
}

// Namespace ai_revival
// Params 1, eflags: 0x4
// Checksum 0xe32c706c, Offset: 0x12b4
// Size: 0x48
function private function_dd687aabb00ca84e( dyingguy )
{
    var_13951377932b459f = 6;
    damagedirsuffix = "_back";
    
    if ( isdefined( dyingguy ) )
    {
        var_13951377932b459f = cap_ai_revival::function_a7df89d3e427d246( dyingguy, self );
        damagedirsuffix = dyingguy cap_ai_revival::getdamagedirectionsuffix();
    }
    
    return var_13951377932b459f + damagedirsuffix;
}

// Namespace ai_revival
// Params 1, eflags: 0x4
// Checksum 0x390f6836, Offset: 0x1305
// Size: 0x39
function private function_8e6601c7cd695bf1( alias )
{
    if ( alias[ 0 ] == "4" )
    {
        return ( "6" + getsubstr( alias, 1 ) );
    }
    
    return "4" + getsubstr( alias, 1 );
}

// Namespace ai_revival
// Params 0, eflags: 0x4
// Checksum 0xc3f6b075, Offset: 0x1346
// Size: 0x19
function private earlyoutinteraction()
{
    function_dd518df9ee8d217c( self getinteractionid(), "death", 1 );
    self leaveinteraction();
}

// Namespace ai_revival
// Params 0, eflags: 0x4
// Checksum 0x39bba025, Offset: 0x1367
// Size: 0x2b
function private getdyingguy()
{
    id = self getinteractionid();
    users = getbsequserswithtag( id, "dying_guy" );
    return users[ 0 ];
}

// Namespace ai_revival
// Params 0, eflags: 0x4
// Checksum 0xbec4d14a, Offset: 0x139b
// Size: 0x2b
function private function_7ea6d66bfed6ffa9()
{
    id = self getinteractionid();
    users = getbsequserswithtag( id, "reviving_guy" );
    return users[ 0 ];
}

// Namespace ai_revival
// Params 4, eflags: 0x4
// Checksum 0x3870f92a, Offset: 0x13cf
// Size: 0x6b, Type: bool
function private tookdamageduringrevive( asmname, statename, tostatename, params )
{
    if ( !self.revival )
    {
        return false;
    }
    
    if ( self.health < self.revival.initialhealth )
    {
        function_dd518df9ee8d217c( self getinteractionid(), "death", 1 );
        return true;
    }
    
    return false;
}

