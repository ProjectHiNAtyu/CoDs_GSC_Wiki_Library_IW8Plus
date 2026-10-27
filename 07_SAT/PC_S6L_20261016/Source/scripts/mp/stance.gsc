// scripts\mp\stance.gsc  (hash_43a07608f1c7101a.gscc) (size: 16598 Bytes / 0x40d6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf6113339 (4128322361)
// size ...... 16598 (0x40d6)
// includes .. 5   (offset: 0x3db2)
// strings ... 41  (offset: 0x3dda)
// dev strs .. 18  (offset: 0x3ff2)
// exports ... 41  (offset: 0x2a62)
// cseg ...... 0x2d1 + 0x2791 (0x2a62)
// imports ... 101 (offset: 0x30ca)
// animtree1 . 0   (offset: 0x40d6)
// animtree2 . 0   (offset: 0x40d6)
#using scripts\common\callbacks;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\common\utility\teams;

#namespace stance;

// Namespace stance
// Params 0
// Checksum 0x43b792f4, Offset: 0x2ef
// Size: 0x8e
function init()
{
    if ( !stanceenabled() )
    {
        return;
    }
    
    /#
        setdevdvarifuninitialized( @"scr_stance_debug", 0 );
        setdevdvarifuninitialized( @"scr_stance_force", 0 );
        setdevdvarifuninitialized( @"scr_stance_disable", 0 );
    #/
    
    utility::registersharedfunc( #"dynamicstance", #"runlogic", &function_5f3bcd004f32a76f );
    utility::registersharedfunc( #"dynamicstance", #"stoplogic", &function_88652e274ca190e1 );
    callback::add( #"player_spawned", &onspawnplayer );
}

// Namespace stance
// Params 0
// Checksum 0xfd9c0234, Offset: 0x385
// Size: 0x4b
function function_d8138034d2e7fe59()
{
    if ( !isdefined( self.stance ) )
    {
        return;
    }
    
    self.stance.spawncooldown = 1;
    
    if ( self.stance.var_de54801bc657ab2c )
    {
        function_88652e274ca190e1();
        thread function_5f3bcd004f32a76f();
    }
}

// Namespace stance
// Params 0, eflags: 0x4
// Checksum 0x468d1062, Offset: 0x3d8
// Size: 0x64
function private stanceenabled()
{
    if ( level.gamemodebundle.stanceenabled && function_4042d2fbe6237835( #"stance" ) )
    {
        level.gamemodebundle.stanceenabled = 0;
    }
    
    if ( getdvarint( @"hash_c3ffbe42914e25db", 0 ) )
    {
        return 0;
    }
    
    return level.gamemodebundle.stanceenabled;
}

// Namespace stance
// Params 1, eflags: 0x4
// Checksum 0x88c861f9, Offset: 0x445
// Size: 0x13
function private onspawnplayer( spawndata )
{
    function_d8138034d2e7fe59();
}

// Namespace stance
// Params 0, eflags: 0x4
// Checksum 0xb1b5f8b4, Offset: 0x460
// Size: 0x201
function private initplayer()
{
    if ( !isdefined( self.stance ) )
    {
        self.stance = function_c594fdb1aac11f18();
        self.stance.relaxed = 0;
        self.stance.safe = 0;
        self.stance.var_ce60fccff8a85a18 = -999999;
        self.stance.var_e9cb6d571d863afa = -999999;
        self.stance.var_c0d957e78b320400 = -999999;
        self.stance.var_fa81bc72c82e1507 = -999999;
        self.stance.lastreloadtime = -999999;
        self.stance.var_9bdce06f344d199e = -999999;
        self.stance.var_cb64d8903dfd713 = -999999;
        self.stance.var_2e59c5f57800325b = -999999;
        self.stance.var_118d59134b5c9f00 = -999999;
        self.stance.var_636b9bcb7c5d5f26 = -999999;
        self.stance.scriptsafe = 0;
        self.stance.incombat = 0;
        self.stance.enemyinsight = undefined;
        self.stance.var_7930fb8bcb024670 = undefined;
        self.stance.var_d393093835812be = 0;
        self.stance.var_9e797b56362749b7 = function_faa5d330c1d09e50( 2000, 750 );
        self.stance.var_de54801bc657ab2c = 0;
        self.stance.spawncooldown = 1;
    }
    
    function_23b916a22bc0b8ac();
    function_906cf72d5524dd2f();
}

// Namespace stance
// Params 0, eflags: 0x4
// Checksum 0x11923b62, Offset: 0x669
// Size: 0x14
function private function_c594fdb1aac11f18()
{
    struct = spawnstruct();
    return struct;
}

// Namespace stance
// Params 0, eflags: 0x4
// Checksum 0x19f11b36, Offset: 0x686
// Size: 0x3a
function private function_38d38926beba7a0c()
{
    self.stance.lastcombattime = gettime();
    self.stance.var_9e797b56362749b7 = function_faa5d330c1d09e50( 2000, 750 );
}

// Namespace stance
// Params 0, eflags: 0xc
// Checksum 0xa07a636a, Offset: 0x6c8
// Size: 0xeee
function private function_5f3bcd004f32a76f()
{
    self notify( #"hash_b20e19d93774be44" );
    self endon( #"hash_b20e19d93774be44" );
    self notify( #"hash_657f40a6d8c9beab" );
    self endon( #"hash_657f40a6d8c9beab" );
    self endon( #"death_or_disconnect" );
    
    if ( !isplayer( self ) || isbot( self ) )
    {
        return;
    }
    
    if ( function_8eeaf0fbf4279762() )
    {
        return;
    }
    
    /#
        if ( getdvarint( @"hash_774f3e4557c4c0c3", 1 ) )
        {
            while ( true )
            {
                var_5bb1c7c47561cbeb = 0;
                
                foreach ( player in level.players )
                {
                    if ( isdefined( player ) && !isbot( player ) && player != self )
                    {
                        var_5bb1c7c47561cbeb = 1;
                    }
                }
                
                if ( var_5bb1c7c47561cbeb )
                {
                    break;
                }
                
                waitframe();
            }
        }
    #/
    
    initplayer();
    self.stance.var_de54801bc657ab2c = 1;
    
    if ( false )
    {
        var_632a61da790bc612 = function_faa5d330c1d09e50( 3000, 2000 );
        var_c3ed574f7a362f10 = function_faa5d330c1d09e50( 0, 400 );
        var_6e2213b544e0abbf = 0;
        var_d0037789a99d8ef6 = function_faa5d330c1d09e50( 750, 750 );
        var_d55f9d8725445514 = 0;
        var_2eef15fad1923a4b = function_faa5d330c1d09e50( 1300, 500 );
        var_733b75acac3e95b5 = 0;
        var_44fece7a031bf67a = function_faa5d330c1d09e50( 1700, 1500 );
        var_9cf8d6bd60790f8 = 0;
        var_afc7da14903402b0 = function_faa5d330c1d09e50( 3000, 2000 );
        var_e4bbfe9f9f93c56a = 0;
        var_491b39f46cbaf08b = function_faa5d330c1d09e50( 3000, 2000 );
        var_1b8c5d193b9950e0 = 0;
        var_5abc5ba132c8a56b = 0;
        var_acd4ab84ad481d99 = 0;
        var_46bde003bc4b90c0 = 0;
        shouldsafe = 0;
        var_1dc445f10cbe02b5 = 0;
        var_3416c3fc7cb16432 = 0;
    }
    
    var_70e50fd1ef0a1818 = function_faa5d330c1d09e50( 100, 400 );
    var_981ada68c2647ce3 = 0;
    var_fe58cd4190c9cbe4 = function_faa5d330c1d09e50( 200, 500 );
    var_c9cdc26579a3ae4b = 0;
    reloadcooldown = function_faa5d330c1d09e50( 3000, 1500 );
    reloadreroll = 0;
    var_9a0cb228e279087b = function_faa5d330c1d09e50( 200, 500 );
    var_cdb4acebf8b56684 = 0;
    var_120d1408d691bec4 = function_faa5d330c1d09e50( 200, 500 );
    var_31698ec478407b81 = 0;
    var_99d609111313d423 = function_faa5d330c1d09e50( 500, 500 );
    var_ea1076a78c973c7e = 0;
    var_e086986bac1cc7ed = 0;
    var_ef6279f81ab883c2 = 0;
    last_frame_velocity = ( 0, 0, 0 );
    childthread function_3e55eaae9b83ff38();
    shouldrelaxed = 0;
    tracecontent = trace::create_default_contents( 1 );
    var_d2d4687b57325df = 0;
    var_ab3b0236a8772906 = 0;
    
    if ( self.stance.spawncooldown )
    {
        self.stance.spawncooldown = undefined;
        wait 2;
    }
    
    while ( true )
    {
        /#
            if ( function_9ff36c5243613e6b() )
            {
                printtoscreen2d( 40, 405, "<dev string:x24>", ( 1, 1, 1 ), 1 );
                printtoscreen2d( 40, 420, "<dev string:x36>", ( 1, 1, 1 ), 1 );
            }
        #/
        
        if ( false )
        {
            blocksafe = [];
            disallowsafe = [];
            forcesafe = [];
        }
        
        blockrelaxed = [];
        disallowrelaxed = [];
        forcerelaxed = [];
        stance = self getstance();
        currenttime = gettime();
        var_4afaff7eba049a9b = self getvelocity();
        current_yaw = self getyawmove();
        acceleration = var_4afaff7eba049a9b - last_frame_velocity;
        last_frame_velocity = var_4afaff7eba049a9b;
        BehindCover = function_175376deb791b3b1( tracecontent );
        nearcover = function_5e20f3810ef7e7aa( tracecontent );
        recentlyfired = function_a874e8fff4b8dfed( currenttime );
        function_d7beab22a3f546a7( currenttime );
        
        if ( false )
        {
            if ( self.stance.var_d393093835812be )
            {
                self.stance.var_662e520d287e44f8 = currenttime;
                blocksafe[ blocksafe.size ] = "enemyInView";
                var_6e2213b544e0abbf = 1;
            }
            else if ( var_6e2213b544e0abbf )
            {
                var_c3ed574f7a362f10 = function_faa5d330c1d09e50( 0, 400 );
                var_6e2213b544e0abbf = 0;
            }
            
            disallowsafe = function_243649e1aae422fa( "enemyInFov", self.stance.var_662e520d287e44f8, var_c3ed574f7a362f10, currenttime, disallowsafe );
            disallowsafe = function_243649e1aae422fa( "RecentCombat", self.stance.lastcombattime, self.stance.var_9e797b56362749b7, currenttime, disallowsafe );
            
            if ( !shouldsafe )
            {
                disallowsafe = function_243649e1aae422fa( "recentSafeState", self.stance.var_49438468f712f23e, 500, currenttime, disallowsafe );
            }
        }
        
        if ( stance != "stand" )
        {
            last_frame_velocity = ( 0, 0, 0 );
            acceleration = ( 0, 0, 0 );
        }
        
        if ( false )
        {
            if ( stance == "crouch" && !BehindCover )
            {
                if ( !shouldsafe )
                {
                    disallowsafe[ disallowsafe.size ] = "crouchedNotIncover";
                }
            }
        }
        
        if ( recentlyfired )
        {
            if ( shouldrelaxed )
            {
                forcerelaxed[ forcerelaxed.size ] = "firingWhileRelaxed";
            }
            else
            {
                blockrelaxed[ blockrelaxed.size ] = "firingWeapon";
            }
        }
        
        if ( self isreloading() )
        {
            self.stance.lastreloadtime = currenttime;
            
            if ( reloadreroll )
            {
                reloadcooldown = function_faa5d330c1d09e50( 3000, 1500 );
                reloadreroll = 0;
            }
        }
        
        if ( false )
        {
            disallowsafe = function_243649e1aae422fa( "reload", self.stance.lastreloadtime, reloadcooldown, currenttime, disallowsafe );
        }
        
        if ( abs( current_yaw ) > 0.6 )
        {
            self.stance.var_cb64d8903dfd713 = currenttime;
        }
        
        if ( false )
        {
            if ( !shouldsafe )
            {
                disallowsafe = function_243649e1aae422fa( "turningFastWhileNotSafe", self.stance.var_cb64d8903dfd713, 150, currenttime, disallowsafe );
            }
        }
        
        if ( !shouldrelaxed )
        {
            disallowrelaxed = function_243649e1aae422fa( "turningFastWhileNotSafe", self.stance.var_cb64d8903dfd713, 150, currenttime, disallowrelaxed );
        }
        
        if ( self playerads() > 0 )
        {
            self.stance.var_d89ca748403b4fad = currenttime;
            var_981ada68c2647ce3 = 1;
            blockrelaxed[ blockrelaxed.size ] = "playerADS";
            
            if ( false )
            {
                blocksafe[ blocksafe.size ] = "playerADS";
            }
        }
        else
        {
            if ( var_981ada68c2647ce3 )
            {
                if ( false )
                {
                    var_632a61da790bc612 = function_faa5d330c1d09e50( 3000, 2000 );
                }
                
                var_70e50fd1ef0a1818 = function_faa5d330c1d09e50( 100, 400 );
                var_981ada68c2647ce3 = 0;
            }
            
            if ( false )
            {
                disallowsafe = function_243649e1aae422fa( "ADSCooldown", self.stance.var_d89ca748403b4fad, var_632a61da790bc612, currenttime, disallowsafe );
            }
            
            disallowrelaxed = function_243649e1aae422fa( "ADSCooldown", self.stance.var_d89ca748403b4fad, var_70e50fd1ef0a1818, currenttime, disallowrelaxed );
        }
        
        if ( false )
        {
            if ( shouldsafe )
            {
                cornercheckweight = 0.45;
            }
            else
            {
                cornercheckweight = 0;
            }
            
            if ( abs( self function_6549f6483c9b151f() ) > cornercheckweight )
            {
                self.stance.var_f40cc73c1676702a = currenttime;
                var_1b8c5d193b9950e0 = 1;
                blocksafe[ blocksafe.size ] = "cornerSlice";
            }
            else
            {
                if ( var_1b8c5d193b9950e0 )
                {
                    if ( false )
                    {
                        var_491b39f46cbaf08b = function_faa5d330c1d09e50( 3000, 2000 );
                    }
                    
                    var_1b8c5d193b9950e0 = 0;
                }
                
                disallowsafe = function_243649e1aae422fa( "cornerSlice", self.stance.var_f40cc73c1676702a, var_491b39f46cbaf08b, currenttime, disallowsafe );
            }
        }
        
        if ( self issprintsliding() || self isdiving() )
        {
            self.stance.var_df5a4b89237ab796 = currenttime;
            blockrelaxed[ blockrelaxed.size ] = "sliding";
            
            if ( false )
            {
                blocksafe[ blocksafe.size ] = "sliding";
            }
            
            var_cdb4acebf8b56684 = 1;
        }
        else
        {
            if ( var_cdb4acebf8b56684 )
            {
                var_9a0cb228e279087b = function_faa5d330c1d09e50( 200, 500 );
                var_cdb4acebf8b56684 = 0;
            }
            
            disallowrelaxed = function_243649e1aae422fa( "SlideCooldown", self.stance.var_df5a4b89237ab796, var_9a0cb228e279087b, currenttime, disallowrelaxed );
        }
        
        if ( self isswimming() )
        {
            blockrelaxed[ blockrelaxed.size ] = "swimming";
        }
        
        if ( self issprinting() )
        {
            if ( !var_e086986bac1cc7ed )
            {
                sprintCoinFlip = utility::cointoss();
                var_e086986bac1cc7ed = 1;
            }
            
            self.stance.var_70e9aa73bfe0e973 = currenttime;
            var_31698ec478407b81 = 1;
            
            if ( sprintCoinFlip )
            {
                blockrelaxed[ blockrelaxed.size ] = "sprintCoinFlip";
            }
            
            if ( false )
            {
                blocksafe[ blocksafe.size ] = "sprint";
                var_9cf8d6bd60790f8 = 1;
            }
        }
        else
        {
            if ( var_e086986bac1cc7ed )
            {
                var_e086986bac1cc7ed = 0;
            }
            
            if ( var_31698ec478407b81 )
            {
                var_120d1408d691bec4 = function_faa5d330c1d09e50( 200, 500 );
                var_31698ec478407b81 = 0;
            }
            
            if ( sprintCoinFlip )
            {
                disallowrelaxed = function_243649e1aae422fa( "SprintCooldown", self.stance.var_70e9aa73bfe0e973, var_120d1408d691bec4, currenttime, disallowrelaxed );
            }
            
            if ( false )
            {
                if ( var_9cf8d6bd60790f8 )
                {
                    var_44fece7a031bf67a = function_faa5d330c1d09e50( 1700, 1500 );
                    var_9cf8d6bd60790f8 = 0;
                }
                
                disallowsafe = function_243649e1aae422fa( "sprint", self.stance.var_70e9aa73bfe0e973, var_44fece7a031bf67a, currenttime, disallowsafe );
            }
        }
        
        if ( self ismantling() )
        {
            self.stance.var_118d59134b5c9f00 = currenttime;
            blockrelaxed[ blockrelaxed.size ] = "mantle";
            var_ea1076a78c973c7e = 1;
        }
        else
        {
            if ( var_ea1076a78c973c7e )
            {
                var_99d609111313d423 = function_faa5d330c1d09e50( 500, 500 );
                var_ea1076a78c973c7e = 0;
            }
            
            disallowrelaxed = function_243649e1aae422fa( "mantleCooldown", self.stance.var_118d59134b5c9f00, var_99d609111313d423, currenttime, disallowrelaxed );
        }
        
        if ( false )
        {
            if ( self ismeleeing() )
            {
                blocksafe[ blocksafe.size ] = "melee";
                var_e4bbfe9f9f93c56a = 1;
                self.stance.var_2e59c5f57800325b = currenttime;
            }
            else
            {
                if ( var_e4bbfe9f9f93c56a )
                {
                    var_afc7da14903402b0 = function_faa5d330c1d09e50( 3000, 2000 );
                    var_e4bbfe9f9f93c56a = 0;
                }
                
                disallowsafe = function_243649e1aae422fa( "melee", self.stance.var_2e59c5f57800325b, var_afc7da14903402b0, currenttime, disallowsafe );
            }
        }
        
        if ( stance == "prone" )
        {
            self.stance.var_9e9bab6b602e9f59 = currenttime;
            blockrelaxed[ blockrelaxed.size ] = "prone";
            
            if ( false )
            {
                blocksafe[ blocksafe.size ] = "prone";
            }
            
            var_c9cdc26579a3ae4b = 1;
        }
        else
        {
            if ( var_c9cdc26579a3ae4b )
            {
                var_fe58cd4190c9cbe4 = function_faa5d330c1d09e50( 200, 500 );
                var_c9cdc26579a3ae4b = 0;
            }
            
            disallowrelaxed = function_243649e1aae422fa( "ProneCooldown", self.stance.var_9e9bab6b602e9f59, var_fe58cd4190c9cbe4, currenttime, disallowrelaxed );
        }
        
        if ( stance == "crouch" && function_e80b1adbd73f0f2() )
        {
            blockrelaxed[ blockrelaxed.size ] = "crouchedWithPistol";
        }
        
        if ( false )
        {
            if ( self isswitchingweapon() )
            {
                self.stance.var_636b9bcb7c5d5f26 = currenttime;
                blocksafe[ blocksafe.size ] = "weapSwitch";
                var_733b75acac3e95b5 = 1;
            }
            else
            {
                if ( var_733b75acac3e95b5 )
                {
                    var_2eef15fad1923a4b = function_faa5d330c1d09e50( 1300, 500 );
                    var_733b75acac3e95b5 = 0;
                }
                
                disallowsafe = function_243649e1aae422fa( "weapSwitchCoolDown", self.stance.var_636b9bcb7c5d5f26, var_2eef15fad1923a4b, currenttime, disallowsafe );
            }
        }
        
        if ( length( acceleration ) > 18 )
        {
            self.stance.var_ac0d19ab066336a = currenttime;
            
            /#
                debugprintacceleration( acceleration, ( 0, 1, 0 ) );
            #/
        }
        else
        {
            if ( !shouldrelaxed )
            {
                disallowrelaxed[ disallowrelaxed.size ] = "waitingForMovement";
            }
            
            /#
                debugprintacceleration( acceleration, ( 1, 0, 0 ) );
            #/
        }
        
        if ( BehindCover )
        {
            self.stance.var_fb08b8b57d6c66d8 = currenttime;
            forcerelaxed[ forcerelaxed.size ] = "BehindCover";
            var_ef6279f81ab883c2 = currenttime - self.stance.var_9bdce06f344d199e;
        }
        
        /#
            function_1dfae8dd7bf79510( BehindCover, nearcover, var_ef6279f81ab883c2 );
        #/
        
        if ( isdefined( self.stance.enemyinsight ) && self.stance.enemyinsight.var_244f12323f818519 > 0.98 )
        {
            dist = distance( self.origin, self.stance.enemyinsight.origin );
            
            if ( dist < 400 && currenttime - self.stance.var_c0d957e78b320400 > 2000 )
            {
                forcerelaxed[ forcerelaxed.size ] = "AIdirectlyInfront";
                self.stance.var_7930fb8bcb024670 = undefined;
            }
            else if ( dist > 500 && currenttime - self.stance.var_e9cb6d571d863afa > 2000 && !nearcover && !BehindCover )
            {
                self.stance.var_7930fb8bcb024670 = self.stance.enemyinsight;
            }
        }
        else
        {
            if ( !shouldrelaxed )
            {
                disallowrelaxed[ disallowrelaxed.size ] = "NoAiInView";
            }
            
            self.stance.var_7930fb8bcb024670 = undefined;
        }
        
        if ( self.stance.var_7930fb8bcb024670 == self.stance.enemyinsight && !nearcover && !BehindCover )
        {
            disallowrelaxed[ disallowrelaxed.size ] = "AIFarInView";
            self.stance.var_9a01d4a7da4906c9 = gettime();
        }
        
        disallowrelaxed = function_243649e1aae422fa( "LongrangeTarget", self.stance.var_9a01d4a7da4906c9, 1000, currenttime, disallowrelaxed );
        
        if ( false )
        {
            if ( self.stance.scriptsafe )
            {
                forcesafe[ forcesafe.size ] = "ScriptedSafe";
            }
            
            /#
                var_3416c3fc7cb16432 = function_c63400edc3c0cb2a();
                var_1dc445f10cbe02b5 = function_66edeb0006ee7f7d();
            #/
            
            shouldsafe = function_65a304fd3eda2ac9( blocksafe, forcesafe, disallowsafe, &function_906cf72d5524dd2f, 420, var_3416c3fc7cb16432, var_1dc445f10cbe02b5 );
            
            if ( forcesafe.size > 0 )
            {
                forcerelaxed = [];
            }
            
            if ( forcerelaxed.size > 0 )
            {
                disallowsafe[ disallowsafe.size ] = "relaxedForece";
            }
            
            if ( shouldsafe )
            {
                disallowrelaxed = function_243649e1aae422fa( "safeCooldown", self.stance.var_49438468f712f23e, 3000, currenttime, disallowrelaxed );
            }
        }
        
        /#
            var_ab3b0236a8772906 = function_7fb9693753e8aeae();
            var_d2d4687b57325df = function_15fc976f002adef7();
        #/
        
        shouldrelaxed = function_65a304fd3eda2ac9( blockrelaxed, forcerelaxed, disallowrelaxed, &function_23b916a22bc0b8ac, 405, var_ab3b0236a8772906, var_d2d4687b57325df );
        
        if ( false )
        {
            function_21050f6c6ed2b9f7( shouldsafe );
        }
        
        function_af3a4f07709ab6b9( shouldrelaxed );
        waitframe();
    }
}

/#

    // Namespace stance
    // Params 0, eflags: 0x4
    // Checksum 0x83a11f4a, Offset: 0x15be
    // Size: 0x29, Type: dev
    function private function_c63400edc3c0cb2a()
    {
        return getdvarint( @"scr_stance_disable", 0 ) || getdvarint( @"scr_stance_force", 0 ) == 1;
    }

    // Namespace stance
    // Params 0, eflags: 0x4
    // Checksum 0x27663665, Offset: 0x15ef
    // Size: 0x2c, Type: dev
    function private function_66edeb0006ee7f7d()
    {
        return getdvarint( @"scr_stance_force", 0 ) == 2 || getdvarint( @"scr_stance_force", 0 ) == 3;
    }

    // Namespace stance
    // Params 0, eflags: 0x4
    // Checksum 0xc775c18a, Offset: 0x1623
    // Size: 0x29, Type: dev
    function private function_7fb9693753e8aeae()
    {
        return getdvarint( @"scr_stance_disable", 0 ) || getdvarint( @"scr_stance_force", 0 ) == 2;
    }

    // Namespace stance
    // Params 0, eflags: 0x4
    // Checksum 0xc2c97e8f, Offset: 0x1654
    // Size: 0x2c, Type: dev
    function private function_15fc976f002adef7()
    {
        return getdvarint( @"scr_stance_force", 0 ) == 1 || getdvarint( @"scr_stance_force", 0 ) == 3;
    }

#/

// Namespace stance
// Params 0, eflags: 0x4
// Checksum 0x11bc20df, Offset: 0x1688
// Size: 0x41, Type: bool
function private function_e80b1adbd73f0f2()
{
    return isdefined( self.currentweapon ) && isdefined( self.currentweapon.classname ) && self.currentweapon.classname == "pistol";
}

// Namespace stance
// Params 0, eflags: 0x4
// Checksum 0xb59fefbf, Offset: 0x16d2
// Size: 0x1f, Type: bool
function private function_8eeaf0fbf4279762()
{
    return isdefined( self.currentweapon ) && weapon::isakimbo( self.currentweapon );
}

// Namespace stance
// Params 0, eflags: 0x4
// Checksum 0x297596e1, Offset: 0x16fa
// Size: 0x40
function private function_88652e274ca190e1()
{
    self notify( #"hash_657f40a6d8c9beab" );
    
    if ( isdefined( self.stance ) )
    {
        self.stance.var_de54801bc657ab2c = 0;
    }
    
    function_af3a4f07709ab6b9( 0 );
    function_21050f6c6ed2b9f7( 0 );
}

// Namespace stance
// Params 5, eflags: 0x4
// Checksum 0xd19b58bb, Offset: 0x1742
// Size: 0x55
function private function_243649e1aae422fa( msg, var_aebf958acaa165ea, cooldown, currenttime, statearray )
{
    if ( currenttime - var_aebf958acaa165ea < cooldown )
    {
        /#
            msg = function_5ddc9280edd3da31( msg, currenttime - var_aebf958acaa165ea, cooldown );
        #/
        
        statearray[ statearray.size ] = msg;
    }
    
    return statearray;
}

// Namespace stance
// Params 7, eflags: 0x4
// Checksum 0xb3bee0dc, Offset: 0x17a0
// Size: 0xcc
function private function_65a304fd3eda2ac9( blockers, forcers, disallows, var_5135891156fddd74, var_20131ddd3836cae0, var_6b4becab33b775c9, var_c28f6bf3fbd46d24 )
{
    /#
        if ( var_6b4becab33b775c9 )
        {
            function_b1c39d3b4c320bdf( var_20131ddd3836cae0 );
            return 0;
        }
        else if ( var_c28f6bf3fbd46d24 )
        {
            function_677ff8dcc0d8975a( var_20131ddd3836cae0 );
            return 1;
        }
    #/
    
    if ( blockers.size != 0 )
    {
        /#
            debugprintblockers( blockers, var_20131ddd3836cae0 );
        #/
        
        return 0;
    }
    
    if ( forcers.size != 0 )
    {
        [[ var_5135891156fddd74 ]]();
        
        /#
            function_60f2be075f4bf964( forcers, var_20131ddd3836cae0 );
        #/
        
        return 1;
    }
    
    if ( disallows.size != 0 )
    {
        /#
            function_11c1225e49f925bc( disallows, var_20131ddd3836cae0 );
        #/
        
        return 0;
    }
    
    /#
        function_a1410bf4fe77eeeb( var_20131ddd3836cae0 );
    #/
    
    return 1;
}

/#

    // Namespace stance
    // Params 0, eflags: 0x4
    // Checksum 0x84ff56ef, Offset: 0x1874
    // Size: 0x3a, Type: dev
    function private function_9ff36c5243613e6b()
    {
        return getdvarint( @"scr_stance_debug", 0 ) || getdvarint( @"scr_stance_force", 0 ) > 0 || getdvarint( @"scr_stance_disable", 0 );
    }

    // Namespace stance
    // Params 0, eflags: 0x4
    // Checksum 0x68b1f603, Offset: 0x18b6
    // Size: 0x3b, Type: dev
    function private shoulddebugprint()
    {
        return getdvarint( @"scr_stance_debug", 0 ) && getdvarint( @"scr_stance_force", 0 ) == 0 && !getdvarint( @"scr_stance_disable", 0 );
    }

    // Namespace stance
    // Params 1, eflags: 0x4
    // Checksum 0x418d1cf6, Offset: 0x18f9
    // Size: 0x44, Type: dev
    function private function_b1c39d3b4c320bdf( yoffset )
    {
        var_b27de506bf87afa4 = "<dev string:x48>";
        color = ( 1, 0, 0 );
        printtoscreen2d( 172, yoffset, var_b27de506bf87afa4, color, 1 );
    }

    // Namespace stance
    // Params 1, eflags: 0x4
    // Checksum 0x5cd96415, Offset: 0x1945
    // Size: 0x44, Type: dev
    function private function_677ff8dcc0d8975a( yoffset )
    {
        var_b27de506bf87afa4 = "<dev string:x5b>";
        color = ( 0, 1, 0 );
        printtoscreen2d( 172, yoffset, var_b27de506bf87afa4, color, 1 );
    }

    // Namespace stance
    // Params 2, eflags: 0x4
    // Checksum 0xb6493817, Offset: 0x1991
    // Size: 0xca, Type: dev
    function private debugprintblockers( blockers, yoffset )
    {
        if ( shoulddebugprint() )
        {
            var_b27de506bf87afa4 = "<dev string:x6c>";
            color = ( 1, 0, 0 );
            
            foreach ( msg in blockers )
            {
                var_b27de506bf87afa4 = var_b27de506bf87afa4 + "<dev string:x78>" + msg;
            }
            
            printtoscreen2d( 172, yoffset, var_b27de506bf87afa4, color, 1 );
        }
    }

    // Namespace stance
    // Params 1, eflags: 0x4
    // Checksum 0x8f113472, Offset: 0x1a63
    // Size: 0x4d, Type: dev
    function private function_a1410bf4fe77eeeb( yoffset )
    {
        if ( shoulddebugprint() )
        {
            var_b27de506bf87afa4 = "<dev string:x7a>";
            color = ( 0, 1, 0 );
            printtoscreen2d( 172, yoffset, var_b27de506bf87afa4, color, 1 );
        }
    }

    // Namespace stance
    // Params 2, eflags: 0x4
    // Checksum 0xd0f09e4d, Offset: 0x1ab8
    // Size: 0xca, Type: dev
    function private function_60f2be075f4bf964( forcingevents, yoffset )
    {
        if ( shoulddebugprint() )
        {
            var_b27de506bf87afa4 = "<dev string:x81>";
            color = ( 0, 1, 0 );
            
            foreach ( msg in forcingevents )
            {
                var_b27de506bf87afa4 = var_b27de506bf87afa4 + "<dev string:x78>" + msg;
            }
            
            printtoscreen2d( 172, yoffset, var_b27de506bf87afa4, color, 1 );
        }
    }

    // Namespace stance
    // Params 2, eflags: 0x4
    // Checksum 0x49487424, Offset: 0x1b8a
    // Size: 0xca, Type: dev
    function private function_11c1225e49f925bc( cooldowns, yoffset )
    {
        if ( shoulddebugprint() )
        {
            var_b27de506bf87afa4 = "<dev string:x95>";
            color = ( 1, 1, 0 );
            
            foreach ( msg in cooldowns )
            {
                var_b27de506bf87afa4 = var_b27de506bf87afa4 + "<dev string:x78>" + msg;
            }
            
            printtoscreen2d( 172, yoffset, var_b27de506bf87afa4, color, 1 );
        }
    }

    // Namespace stance
    // Params 2, eflags: 0x4
    // Checksum 0xfed5e259, Offset: 0x1c5c
    // Size: 0x4c, Type: dev
    function private debugprintacceleration( acceleration, color )
    {
        if ( shoulddebugprint() )
        {
            acceleration = int( length( acceleration ) );
            printtoscreen2d( 40, 435, "<dev string:xab>" + acceleration + "<dev string:xc2>" + 18, color, 1 );
        }
    }

    // Namespace stance
    // Params 3, eflags: 0x4
    // Checksum 0x8b9a2e9e, Offset: 0x1cb0
    // Size: 0xba, Type: dev
    function private function_1dfae8dd7bf79510( BehindCover, nearcover, time )
    {
        if ( shoulddebugprint() )
        {
            if ( BehindCover )
            {
                if ( time > 500 )
                {
                    color = ( 0, 1, 0 );
                }
                else
                {
                    color = ( 1, 0.5, 0 );
                }
                
                msg = "<dev string:xc4>";
            }
            else if ( nearcover )
            {
                color = ( 1, 1, 0 );
                msg = "<dev string:xdd>";
            }
            else
            {
                color = ( 1, 0, 0 );
                msg = "<dev string:xf8>";
            }
            
            printtoscreen2d( 40, 450, msg + time, color, 1 );
        }
    }

    // Namespace stance
    // Params 3, eflags: 0x4
    // Checksum 0xf7484227, Offset: 0x1d72
    // Size: 0x4a, Type: dev
    function private function_5ddc9280edd3da31( msg, timedelta, cooldown )
    {
        if ( timedelta < cooldown )
        {
            timer = cooldown - timedelta;
        }
        else
        {
            timer = 0;
        }
        
        return msg + "<dev string:x115>" + timer;
    }

#/

// Namespace stance
// Params 0, eflags: 0x4
// Checksum 0x7dfc132e, Offset: 0x1dc4
// Size: 0x1d
function private function_3e55eaae9b83ff38()
{
    while ( true )
    {
        utility::waittill_any( "weapon_fired" );
        function_38d38926beba7a0c();
    }
}

// Namespace stance
// Params 1, eflags: 0x4
// Checksum 0x60c1693, Offset: 0x1de9
// Size: 0x62c
function private function_d7beab22a3f546a7( currenttime )
{
    myteam = teams::getfriendlyplayers( self.team, 0 );
    enemyteams = getplayersinradius( self.origin, 2000, 2000, 1, myteam );
    var_adababb6f193c007 = [];
    var_e96b7c265edceadd = [];
    playereye = self geteye();
    playerf = anglestoforward( self getplayerangles() );
    contentsoverride = trace::create_contents( 1, 1, 0, 0, 0, 1, 0, 0, 1 );
    
    foreach ( enemy in enemyteams )
    {
        enemyeye = enemy geteye();
        dirtoenemy = vectornormalize( enemyeye - playereye );
        dot = vectordot( dirtoenemy, playerf );
        enemy.var_244f12323f818519 = dot;
        
        if ( dot > 0.86 )
        {
            var_adababb6f193c007[ var_adababb6f193c007.size ] = enemy;
        }
    }
    
    if ( var_adababb6f193c007.size < 1 && isdefined( self.stance.enemyinsight ) )
    {
        if ( self.stance.enemyinsight.var_244f12323f818519 > 0.4 )
        {
            var_adababb6f193c007[ var_adababb6f193c007.size ] = self.stance.enemyinsight;
        }
    }
    
    self.stance.var_d393093835812be = 0;
    
    foreach ( enemy in var_adababb6f193c007 )
    {
        if ( isdefined( enemy.var_a59695740b58a4e0 ) && currenttime - enemy.var_a59695740b58a4e0 < 1100 )
        {
            self.stance.var_d393093835812be = 1;
            break;
        }
    }
    
    sightedplayers = self getsightedplayers();
    var_617950ddde346ff6 = [];
    
    foreach ( player in sightedplayers )
    {
        var_617950ddde346ff6[ player getentitynumber() ] = 1;
    }
    
    foreach ( enemy in var_adababb6f193c007 )
    {
        if ( isplayer( enemy ) || isbot( enemy ) )
        {
            if ( isdefined( var_617950ddde346ff6[ enemy getentitynumber() ] ) )
            {
                enemy.var_a59695740b58a4e0 = currenttime;
                var_e96b7c265edceadd[ var_e96b7c265edceadd.size ] = enemy;
            }
            
            continue;
        }
        
        enemyeye = enemy geteye();
        trace = trace::ray_trace( playereye, enemyeye, self, contentsoverride );
        
        if ( trace[ "entity" ] == enemy )
        {
            enemy.var_a59695740b58a4e0 = currenttime;
            var_e96b7c265edceadd[ var_e96b7c265edceadd.size ] = enemy;
        }
    }
    
    var_55ee90b059ffa371 = undefined;
    
    foreach ( enemy in var_e96b7c265edceadd )
    {
        if ( isdefined( var_55ee90b059ffa371 ) )
        {
            if ( enemy.var_244f12323f818519 > var_55ee90b059ffa371.var_244f12323f818519 )
            {
                var_55ee90b059ffa371 = enemy;
            }
            
            continue;
        }
        
        var_55ee90b059ffa371 = enemy;
    }
    
    /#
        if ( shoulddebugprint() )
        {
            foreach ( enemy in var_adababb6f193c007 )
            {
                if ( enemy == var_55ee90b059ffa371 )
                {
                    color = ( 0, 1, 0 );
                }
                else if ( arraycontains( var_e96b7c265edceadd, enemy ) )
                {
                    color = ( 0, 0, 1 );
                }
                else if ( isdefined( enemy.var_a59695740b58a4e0 ) && currenttime - enemy.var_a59695740b58a4e0 < 1100 )
                {
                    color = ( 1, 0, 1 );
                }
                else
                {
                    color = ( 1, 0, 0 );
                }
                
                dotprint = int( enemy.var_244f12323f818519 * 100 );
                distprint = int( distance( self.origin, enemy.origin ) );
                scale = 0.4;
                box( enemy.origin, 0, color, 0, 1 );
                print3d( enemy.origin + ( 0, 0, 74 ), "<dev string:x117>" + dotprint, color, 1, scale, 1, 1 );
                print3d( enemy.origin + ( 0, 0, 70 ), "<dev string:x11f>" + distprint, color, 1, scale, 1, 1 );
            }
        }
    #/
    
    self.stance.enemyinsight = var_55ee90b059ffa371;
}

// Namespace stance
// Params 0, eflags: 0x4
// Checksum 0x1a3183d8, Offset: 0x241d
// Size: 0x98
function private function_23b916a22bc0b8ac()
{
    self.stance.var_ac0d19ab066336a = -999999;
    self.stance.var_df5a4b89237ab796 = -999999;
    self.stance.var_70e9aa73bfe0e973 = -999999;
    self.stance.var_d89ca748403b4fad = -999999;
    self.stance.var_9e9bab6b602e9f59 = -999999;
    self.stance.var_9a01d4a7da4906c9 = -999999;
}

// Namespace stance
// Params 0, eflags: 0x4
// Checksum 0x708d5665, Offset: 0x24bd
// Size: 0x7f
function private function_906cf72d5524dd2f()
{
    self.stance.lastcombattime = -999999;
    self.stance.var_662e520d287e44f8 = -999999;
    self.stance.var_fb08b8b57d6c66d8 = -999999;
    self.stance.var_49438468f712f23e = -999999;
    self.stance.var_f40cc73c1676702a = -999999;
}

// Namespace stance
// Params 1, eflags: 0x4
// Checksum 0x80d2594a, Offset: 0x2544
// Size: 0x16
function private function_175376deb791b3b1( tracecontent )
{
    return covercheck( 3, tracecontent );
}

// Namespace stance
// Params 1, eflags: 0x4
// Checksum 0x732d683b, Offset: 0x2563
// Size: 0x24, Type: bool
function private function_5e20f3810ef7e7aa( tracecontent )
{
    return function_96750173c2a3ac40( 1, tracecontent ) || function_96750173c2a3ac40( -1, tracecontent );
}

// Namespace stance
// Params 1, eflags: 0x4
// Checksum 0x1a54534b, Offset: 0x2590
// Size: 0x2f, Type: bool
function private function_a874e8fff4b8dfed( currenttime )
{
    if ( isdefined( self.lastshotfiredtime ) )
    {
        if ( currenttime - self.lastshotfiredtime < 160 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace stance
// Params 2, eflags: 0x4
// Checksum 0x4a380a20, Offset: 0x25c8
// Size: 0x82
function private covercheck( radius, tracecontent )
{
    f = anglestoforward( self getplayerangles() );
    startpos = self geteye();
    endpos = startpos + f * 40;
    trace = trace::sphere_trace( startpos, endpos, radius, undefined, tracecontent );
    
    if ( trace[ "fraction" ] < 1 )
    {
        blocked = 1;
    }
    else
    {
        blocked = 0;
    }
    
    return blocked;
}

// Namespace stance
// Params 2, eflags: 0x4
// Checksum 0xef46c951, Offset: 0x2653
// Size: 0x139
function private function_96750173c2a3ac40( dir, tracecontent )
{
    playerang = self getplayerangles( 1 );
    foffset = anglestoforward( playerang ) * 40;
    roffset = anglestoright( playerang ) * dir;
    startpos = self geteye() + roffset;
    endpos = startpos + foffset + roffset * 40 * 0.5;
    trace = trace::ray_trace( startpos, endpos, undefined, tracecontent );
    
    if ( trace[ "fraction" ] < 1 )
    {
        blocked = 1;
        color = ( 0, 1, 0 );
    }
    else
    {
        blocked = 0;
        color = ( 1, 0, 0 );
    }
    
    /#
        if ( shoulddebugprint() )
        {
            offset = 0.2;
            line( startpos + ( 0, 0, offset ), trace[ "<dev string:x127>" ] + ( 0, 0, offset ), color, 1, 0, 1 );
            offset *= -1;
            line( startpos + ( 0, 0, offset ), trace[ "<dev string:x127>" ] + ( 0, 0, offset ), color, 1, 0, 1 );
        }
    #/
    
    return blocked;
}

// Namespace stance
// Params 2, eflags: 0x4
// Checksum 0xbf517168, Offset: 0x2795
// Size: 0x1e
function private function_faa5d330c1d09e50( basetime, variance )
{
    return basetime + randomint( variance );
}

// Namespace stance
// Params 1, eflags: 0x4
// Checksum 0xce216e63, Offset: 0x27bc
// Size: 0x199, Type: bool
function private function_af3a4f07709ab6b9( bool )
{
    /#
        if ( getdvarint( @"scr_stance_disable", 0 ) || getdvarint( @"scr_stance_force", 0 ) == 2 )
        {
            bool = 0;
        }
        else if ( getdvarint( @"scr_stance_force", 0 ) == 1 || getdvarint( @"scr_stance_force", 0 ) == 3 )
        {
            bool = 1;
        }
    #/
    
    if ( bool && !self.stance.relaxed )
    {
        currenttime = gettime();
        self notify( #"hash_f0cb2f4872e2e843" );
        self function_ca73eb5e48bdab1( bool );
        self.stance.relaxed = 1;
        self.stance.var_ce60fccff8a85a18 = currenttime;
        self.stance.var_e9cb6d571d863afa = currenttime;
        self.stance.var_fa81bc72c82e1507 = currenttime;
        return true;
    }
    else if ( !bool && self.stance.relaxed )
    {
        currenttime = gettime();
        self notify( #"hash_df474e43419cc6f1" );
        self function_ca73eb5e48bdab1( bool );
        self.stance.relaxed = 0;
        self.stance.var_ce60fccff8a85a18 = currenttime;
        self.stance.var_c0d957e78b320400 = currenttime;
        self.stance.var_fa81bc72c82e1507 = currenttime;
        return true;
    }
    
    return false;
}

// Namespace stance
// Params 1, eflags: 0x4
// Checksum 0x5465af7b, Offset: 0x295e
// Size: 0x103, Type: bool
function private function_21050f6c6ed2b9f7( bool )
{
    if ( bool && !self.stance.safe )
    {
        self notify( #"hash_9745208da02cff17" );
        self function_72d3c98481c7036f( bool );
        self.stance.safe = 1;
        self.stance.var_49438468f712f23e = gettime();
        self.stance.var_fa81bc72c82e1507 = gettime();
        return true;
    }
    else if ( !bool && self.stance.safe )
    {
        self notify( #"hash_7b27bab4ff20769d" );
        self function_72d3c98481c7036f( bool );
        self.stance.safe = 0;
        self.stance.var_49438468f712f23e = gettime();
        self.stance.var_fa81bc72c82e1507 = gettime();
        return true;
    }
    
    return false;
}

