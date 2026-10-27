// scripts\mp\zm\ztron\ztron_score.gsc  (hash_778531fe28c80026.gscc) (size: 15508 Bytes / 0x3c94 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf3e1d5e3 (4091663843)
// size ...... 15508 (0x3c94)
// includes .. 15  (offset: 0x3a9c)
// strings ... 28  (offset: 0x3b14)
// dev strs .. 3   (offset: 0x3c6c)
// exports ... 40  (offset: 0x2b04)
// cseg ...... 0x27b + 0x2889 (0x2b04)
// imports ... 75  (offset: 0x3144)
// animtree1 . 0   (offset: 0x3c94)
// animtree2 . 0   (offset: 0x3c94)
#using script_31ee2a173f3499b7;
#using script_5441a11286579ddc;
#using script_54a05cbb2455bc6f;
#using script_75994df35243cb2a;
#using scripts\common\utility;
#using scripts\mp\common\utility\stats;
#using scripts\mp\gamescore;
#using scripts\mp\playerlogic;
#using scripts\mp\rank;
#using scripts\mp\zm\ztron\ztron_debug;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_main;
#using scripts\mp\zm\ztron\ztron_meta_progression;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace ztron_score;

// Namespace ztron_score
// Params 0
// Checksum 0xfdb23cbc, Offset: 0x299
// Size: 0x1ba
function init()
{
    level thread function_151e6e47b881e9e4();
    level thread function_480fd50de0dfa367();
    level.ztron.var_42cf8c9378ff8c39 = [ 0, 0, 22, 40, 80, 160, 350, 850, 1500, 2800, 4800 ];
    level.ztron.gemsmax = 0;
    
    foreach ( item in level.ztron.var_42cf8c9378ff8c39 )
    {
        level.ztron.gemsmax += item;
    }
    
    level.ztron.var_e87c5db08e6ca300 = [ 0 ];
    total = 0;
    
    for ( i = 1; i <= 9 ; i++ )
    {
        next = level.ztron.var_42cf8c9378ff8c39[ i + 1 ];
        level.ztron.var_e87c5db08e6ca300[ level.ztron.var_e87c5db08e6ca300.size ] = total + next;
        total += next;
    }
}

// Namespace ztron_score
// Params 0
// Checksum 0x86b2f80f, Offset: 0x45b
// Size: 0x21
function initplayer()
{
    self.ztron.score = spawnstruct();
    function_7d21d2a60a97ae98();
}

// Namespace ztron_score
// Params 0
// Checksum 0x3bd0c40, Offset: 0x484
// Size: 0x2b1
function function_7d21d2a60a97ae98()
{
    self.ztron.score.points = 0;
    self.ztron.score.desired_points = 0;
    self.ztron.score.kills = 0;
    self.ztron.score.multix = 1;
    self.ztron.score.multiprogress = 0;
    self.ztron.score.gems = 0;
    self.ztron.score.desired_gems = 0;
    self.ztron.score.gemsnextlevel = function_9fa8b6a9b8f84ba2( self.ztron.score.multix );
    self.ztron.score.var_e294e535d5856517 = self.ztron.score.gemsnextlevel * 0.1;
    self.ztron.score.gemscurlevel = 0;
    initialbombs = 1;
    armorylvl = ztron_meta_progression::function_996793ae2b9b6a3c( self, "armory" );
    initialbombs += int( armorylvl / 2 );
    namespace_a6a7fe92789f4ad9::function_8cab6adef8e1bef2( initialbombs );
    initialboosts = 2;
    initialboosts += int( ( armorylvl + 1 ) / 2 );
    namespace_33e886a9a5b55137::function_992dffefa33a9534( initialboosts );
    function_928d324dea557052( getdvarint( @"hash_ecf2c670b066f427", 3 ) );
    self.currency = [];
    self.currency[ #"plunder" ] = 0;
    self.currency[ #"essence" ] = 0;
    self.ztron.score.nextextralife = 200000;
    
    if ( self.pers )
    {
        self.pers[ "deaths" ] = undefined;
        self.pers[ "score" ] = undefined;
        self.pers[ "kills" ] = undefined;
        playerlogic::initleanplayerstats();
        stats::setextrascore3( 0 );
        stats::setextrascore4( 0 );
        stats::function_fe615555f60e88b9( 0 );
    }
    
    function_eeef9f859a7ebd1();
    function_4ea454cb6435a318();
}

// Namespace ztron_score
// Params 0
// Checksum 0x7e4d72cd, Offset: 0x73d
// Size: 0x168
function function_27628918827d36a0()
{
    if ( !isdefined( self.ztron ) || !isdefined( self.ztron.score ) )
    {
        return;
    }
    
    var_cc532c88c257f342 = self.ztron.score.gems - self.ztron.score.gemscurlevel;
    var_ef605170d86d4090 = self.ztron.score.gemsnextlevel - self.ztron.score.gemscurlevel;
    prevalue = self.ztron.score.multiprogress;
    
    if ( var_ef605170d86d4090 > 0.1 )
    {
        self.ztron.score.multiprogress = int( min( 100, var_cc532c88c257f342 * 100 / var_ef605170d86d4090 ) );
    }
    else
    {
        self.ztron.score.multiprogress = 100;
    }
    
    if ( prevalue != self.ztron.score.multiprogress )
    {
        function_33efcadca04bd395();
    }
}

// Namespace ztron_score
// Params 0
// Checksum 0x45f1ba15, Offset: 0x8ad
// Size: 0x5ad
function updatepoints()
{
    if ( !isdefined( self.ztron ) || !isdefined( self.ztron.score ) )
    {
        return;
    }
    
    if ( self.ztron.score.points < self.ztron.score.desired_points )
    {
        delta = self.ztron.score.desired_points - self.ztron.score.points;
        frac = int( 0.025 * delta );
        frac = int( frac / 25 ) * 25;
        
        if ( frac < 25 )
        {
            frac = 25;
        }
        
        frac = function_edc4fe38f933ff8f( self.ztron.score.points, frac );
        self.ztron.score.points += frac;
        
        if ( self.ztron.score.points > self.ztron.score.desired_points )
        {
            self.ztron.score.points = self.ztron.score.desired_points;
        }
        
        function_eeef9f859a7ebd1();
        
        if ( self.ztron.score.points > self.ztron.score.nextextralife )
        {
            if ( function_4f2852a8848fa4ce() < getmaxlives() )
            {
                ztron_item::function_d2dd7af394ebdbdd( "ztron_extra_life" );
            }
            else
            {
                roll = randomint( 100 );
                
                if ( roll < 30 )
                {
                    ztron_item::function_d2dd7af394ebdbdd( "ztron_sprinkler" );
                }
                else if ( roll < 60 )
                {
                    ztron_item::function_d2dd7af394ebdbdd( "ztron_boxing_glove" );
                }
                else
                {
                    ztron_item::function_d2dd7af394ebdbdd( "ztron_coat_of_arms" );
                }
            }
            
            if ( ztron_fate::hasfate( 6 ) )
            {
                self.ztron.score.nextextralife += 150000;
            }
            else
            {
                self.ztron.score.nextextralife += 200000;
            }
        }
    }
    
    if ( !self.ztron.var_c3c0d348fe8b0280 && self.ztron.score.gems < self.ztron.score.desired_gems )
    {
        increment = 0.05;
        delta = self.ztron.score.desired_gems - self.ztron.score.gems;
        
        if ( delta > self.ztron.score.var_e294e535d5856517 )
        {
            increment = self.ztron.score.var_e294e535d5856517;
        }
        
        self.ztron.score.gems += increment;
        
        if ( self.ztron.score.gems > self.ztron.score.gemsnextlevel )
        {
            if ( self.ztron.score.multix <= 9 )
            {
                self.ztron.score.gemscurlevel = self.ztron.score.gemsnextlevel;
                self.ztron.score.gemsnextlevel = function_9fa8b6a9b8f84ba2( self.ztron.score.multix + 1 );
                self.ztron.score.var_e294e535d5856517 = self.ztron.score.gemsnextlevel * 0.1;
            }
            
            self.ztron.score.multix++;
            
            if ( self.ztron.score.multix >= 9 )
            {
                self.ztron.score.multix = 9;
            }
            
            function_4ea454cb6435a318();
        }
    }
    
    function_27628918827d36a0();
}

// Namespace ztron_score
// Params 0
// Checksum 0xc54471dd, Offset: 0xe62
// Size: 0x29
function function_5c25e66ab18c5162()
{
    if ( level.var_5ac542875a6578d7 )
    {
        return;
    }
    
    thread function_f36c799291e1a881( self.ztron.var_ee12821b601e753a );
}

// Namespace ztron_score
// Params 1
// Checksum 0x2a11e696, Offset: 0xe93
// Size: 0x6b1
function function_f36c799291e1a881( spill_protection = 0 )
{
    self notify( #"hash_3b191b38441c8d1b" );
    self endon( #"hash_3b191b38441c8d1b" );
    self endon( #"disconnect" );
    self.ztron.var_ee12821b601e753a = undefined;
    self.ztron.var_c3c0d348fe8b0280 = 1;
    var_22d19e518801c38 = int( self.ztron.score.gems / 4 );
    avgscale = 1;
    
    if ( var_22d19e518801c38 > 30 )
    {
        avgscale = clamp( var_22d19e518801c38 / 30, 1, 10 );
    }
    
    var_a77c0695839877e2 = clamp( var_22d19e518801c38, 0, 30 );
    
    if ( var_a77c0695839877e2 > 0 )
    {
        var_9c71742b38fdf519 = int( self.ztron.score.gems / var_a77c0695839877e2 );
        var_df4c126a3a2f472d = function_9fa8b6a9b8f84ba2( self.ztron.score.multix - 1 );
        var_8d91af80c32b2541 = var_9c71742b38fdf519;
        
        while ( self.ztron.score.gems > 0 && self.inlaststand )
        {
            decrement = int( self.ztron.score.multix * self.ztron.score.multix * self.ztron.score.multix / 9 ) + self.ztron.score.multix;
            self.ztron.score.gems -= decrement;
            
            if ( self.ztron.score.gems < 0 )
            {
                self.ztron.score.gems = 0;
            }
            
            var_8d91af80c32b2541 -= decrement;
            
            if ( var_8d91af80c32b2541 <= 0 )
            {
                var_8d91af80c32b2541 = var_9c71742b38fdf519;
                params = spawnstruct();
                params.launchforce = ( randomintrange( -10, 10 ), randomintrange( -10, 10 ), 400 );
                params.scale = 1;
                params.var_94a6561aeb9877de = avgscale;
                ztron_item::function_d0a061baefd87906( self.origin + ( 0, 0, 100 ), 1, 20, undefined, params );
            }
            
            if ( self.ztron.score.gems <= var_df4c126a3a2f472d )
            {
                self.ztron.score.multix--;
                
                if ( self.ztron.score.multix < 1 )
                {
                    self.ztron.score.multix = 1;
                }
                
                if ( ztron_fate::hasfate( 2 ) && self.ztron.score.multix < 2 )
                {
                    self.ztron.score.multix = 2;
                    self.ztron.score.gems = function_9fa8b6a9b8f84ba2( 1 );
                    function_4ea454cb6435a318();
                    break;
                }
                
                self.ztron.score.gemsnextlevel = function_9fa8b6a9b8f84ba2( self.ztron.score.multix );
                var_df4c126a3a2f472d = function_9fa8b6a9b8f84ba2( self.ztron.score.multix - 1 );
                self.ztron.score.gemscurlevel = var_df4c126a3a2f472d;
                self.ztron.score.var_e294e535d5856517 = self.ztron.score.gemsnextlevel * 0.1;
                function_4ea454cb6435a318();
                
                if ( spill_protection )
                {
                    break;
                }
            }
            
            waitframe();
        }
    }
    
    if ( self.ztron.score.gems <= 0 )
    {
        self.ztron.score.gems = 0;
        self.ztron.score.multix = ztron_fate::hasfate( 2 ) ? 2 : 1;
        self.ztron.score.gemscurlevel = 0;
        function_4ea454cb6435a318();
    }
    
    self.ztron.score.desired_gems = self.ztron.score.gems;
    self.ztron.score.gemsnextlevel = function_9fa8b6a9b8f84ba2( self.ztron.score.multix );
    self.ztron.score.var_e294e535d5856517 = self.ztron.score.gemsnextlevel * 0.1;
    
    if ( self.ztron.score.gemscurlevel == self.ztron.score.gemsnextlevel )
    {
        self.ztron.score.gemscurlevel = self.ztron.score.gemsnextlevel - 1;
    }
    
    self.ztron.var_c3c0d348fe8b0280 = undefined;
}

// Namespace ztron_score
// Params 2
// Checksum 0x1a445b66, Offset: 0x154c
// Size: 0x112
function function_7febfbfc901efb42( score = 100, victim )
{
    if ( !isdefined( self.ztron.score ) )
    {
        return;
    }
    
    if ( isdefined( self.ztron.var_18952cd0c4349dba ) )
    {
        roll = randomint( 100 );
        
        if ( roll < self.ztron.var_18952cd0c4349dba )
        {
            params = spawnstruct();
            params.launchforce = ( randomintrange( -10, 10 ), randomintrange( -10, 10 ), 400 );
            ztron_item::function_d0a061baefd87906( victim.origin + ( 0, 0, 100 ), 1, 20, undefined, params );
        }
    }
    
    multix = function_a266f7130e789994();
    self.ztron.score.kills++;
    function_785f67d24e19bb27( score * multix, #"ztron_score", victim );
}

// Namespace ztron_score
// Params 3
// Checksum 0x67b6ff37, Offset: 0x1666
// Size: 0x11f
function scorepickup( score, gems, itemtype )
{
    if ( !isdefined( self.ztron.score ) )
    {
        return;
    }
    
    multix = function_a266f7130e789994();
    
    if ( self.ztron.upgradeMask & 4294967296 )
    {
        score += 25;
        gems *= 1.15;
    }
    
    if ( itemtype == #"gem" )
    {
        if ( self.ztron.upgradeMask & 262144 )
        {
            score += 50;
            gems *= 1.15;
        }
    }
    
    function_11408ef3c67aca20( itemtype );
    
    if ( score > 0 )
    {
        function_785f67d24e19bb27( score * multix, #"ztron_score" );
    }
    
    if ( gems > 0 )
    {
        self.ztron.score.desired_gems += gems;
    }
}

// Namespace ztron_score
// Params 0
// Checksum 0x82e46560, Offset: 0x178d
// Size: 0x12
function getmaxlives()
{
    if ( ztron_fate::hasfate( 6 ) )
    {
        return 10;
    }
    
    return 9;
}

// Namespace ztron_score
// Params 0
// Checksum 0xf615ee07, Offset: 0x17a8
// Size: 0x12
function function_b986c55261cc358e()
{
    if ( ztron_fate::hasfate( 5 ) )
    {
        return 10;
    }
    
    return 9;
}

// Namespace ztron_score
// Params 0
// Checksum 0xd388d3c4, Offset: 0x17c3
// Size: 0x12
function getmaxboosts()
{
    if ( ztron_fate::hasfate( 4 ) )
    {
        return 10;
    }
    
    return 9;
}

// Namespace ztron_score
// Params 0
// Checksum 0x88e9ceda, Offset: 0x17de
// Size: 0x39
function function_4f2852a8848fa4ce()
{
    if ( !isdefined( self.ztron.score ) )
    {
        return 0;
    }
    
    return self.ztron.score.lives;
}

// Namespace ztron_score
// Params 0
// Checksum 0x39717e55, Offset: 0x1820
// Size: 0x39
function function_4c3f7434cb35b077()
{
    if ( !isdefined( self.ztron.score ) )
    {
        return 0;
    }
    
    return self.ztron.score.bombs;
}

// Namespace ztron_score
// Params 0
// Checksum 0xfb7c3134, Offset: 0x1862
// Size: 0x39
function function_1612411349eb9a97()
{
    if ( !isdefined( self.ztron.score ) )
    {
        return 0;
    }
    
    return self.ztron.score.var_59f1f1595961cbe;
}

// Namespace ztron_score
// Params 2
// Checksum 0xd1c9c62c, Offset: 0x18a4
// Size: 0x69
function function_928d324dea557052( value, forced = 0 )
{
    if ( value < 0 )
    {
        value = 0;
    }
    
    if ( value > getmaxlives() && !forced )
    {
        value = getmaxlives();
    }
    
    self.ztron.score.lives = value;
    function_9b1b2c15e3768d1f();
}

// Namespace ztron_score
// Params 0
// Checksum 0x30d8d3f, Offset: 0x1915
// Size: 0xbe
function function_936ed7d973a515bc()
{
    var_71476f5d30adac56 = function_b986c55261cc358e();
    var_88d533527d6d836e = function_4c3f7434cb35b077();
    
    if ( var_88d533527d6d836e < var_71476f5d30adac56 )
    {
        ztron_item::function_d2dd7af394ebdbdd( "ztron_nuke" );
        return;
    }
    
    maxboosts = getmaxboosts();
    curboosts = function_1612411349eb9a97();
    
    if ( curboosts < maxboosts )
    {
        ztron_item::function_d2dd7af394ebdbdd( "ztron_boost" );
        return;
    }
    
    if ( ztron_main::function_4da200e9b8d58a3c() == 1 && !isdefined( level.ztron.var_8a9067aa4cd65369 ) )
    {
        ztron_item::function_d2dd7af394ebdbdd( randomint( 100 ) > 50 ? "ztron_tank" : "ztron_helicopter" );
        return;
    }
    
    ztron_player_utility::function_8e1155bcebb3b7b3( 750 );
}

// Namespace ztron_score
// Params 1
// Checksum 0x7d004975, Offset: 0x19db
// Size: 0x59
function givelives( num = 1 )
{
    curlives = function_4f2852a8848fa4ce();
    maxlives = getmaxlives();
    
    if ( curlives == maxlives && num > 0 )
    {
        function_936ed7d973a515bc();
        return;
    }
    
    function_928d324dea557052( curlives + num );
}

// Namespace ztron_score
// Params 1
// Checksum 0x47d93a14, Offset: 0x1a3c
// Size: 0x41
function function_9fa8b6a9b8f84ba2( checklevel )
{
    assert( checklevel < level.ztron.var_e87c5db08e6ca300.size );
    return level.ztron.var_e87c5db08e6ca300[ checklevel ];
}

// Namespace ztron_score
// Params 0
// Checksum 0x48603a0a, Offset: 0x1a86
// Size: 0x50
function function_eeef9f859a7ebd1()
{
    params = { #count:self.ztron.score.points, #squadmemberindex:self.sessionuimemberindex };
    ztron_ui::function_ee51f6fb7a9e1e40( params );
}

// Namespace ztron_score
// Params 0
// Checksum 0x241d85aa, Offset: 0x1ade
// Size: 0x39
function function_4ea454cb6435a318()
{
    params = { #count:function_a266f7130e789994(), #squadmemberindex:self.sessionuimemberindex };
    ztron_ui::function_a412ceb9a2302a81( params );
}

// Namespace ztron_score
// Params 0
// Checksum 0xa7387069, Offset: 0x1b1f
// Size: 0xed
function function_a266f7130e789994()
{
    profilestart();
    multix = self.ztron.score.multix;
    
    if ( self.ztron.var_c516f6d55a2165b4 )
    {
        profilestop();
        return multix;
    }
    
    if ( isdefined( self.ztron.usingmutant ) )
    {
        profilestop();
        return multix;
    }
    
    if ( self.ztron.vehicle )
    {
        profilestop();
        return multix;
    }
    
    if ( self.ztron.var_a4c2f70bbc713f98 && ztron_main::function_4da200e9b8d58a3c() == 1 && !level.ztron.var_74a3707334cfe144 )
    {
        if ( multix < 4 )
        {
            multix = 4;
        }
        
        if ( self.ztron.upgradeMask & 1048576 )
        {
            if ( multix < 5 )
            {
                multix = 5;
            }
        }
    }
    
    profilestop();
    return multix;
}

// Namespace ztron_score
// Params 0
// Checksum 0x10e45a01, Offset: 0x1c16
// Size: 0x50
function function_9b1b2c15e3768d1f()
{
    params = { #count:self.ztron.score.lives, #squadmemberindex:self.sessionuimemberindex };
    ztron_ui::function_cd73203f57d03da0( params );
}

// Namespace ztron_score
// Params 0
// Checksum 0x2d9a1953, Offset: 0x1c6e
// Size: 0x50
function function_33efcadca04bd395()
{
    params = { #count:self.ztron.score.multiprogress, #squadmemberindex:self.sessionuimemberindex };
    ztron_ui::function_62fb0213ded4c790( params );
}

// Namespace ztron_score
// Params 2, eflags: 0x4
// Checksum 0xa57b85e3, Offset: 0x1cc6
// Size: 0x25
function private function_edc4fe38f933ff8f( base, inc )
{
    return minint( 4294967295, base + inc ) - base;
}

// Namespace ztron_score
// Params 3
// Checksum 0xe0d87b5a, Offset: 0x1cf4
// Size: 0x107
function function_785f67d24e19bb27( incscore, scoreeventtype, victim = undefined )
{
    inc = function_edc4fe38f933ff8f( self.ztron.score.desired_points, incscore );
    self.ztron.score.desired_points += inc;
    gamescore::giveplayerscore( scoreeventtype, inc, victim );
    
    if ( !level.ztron.advancedStart && self.ztron.score.desired_points > ( self.ztron.highestscore ?? 0 ) )
    {
        if ( !self isconnected() )
        {
            return;
        }
        
        self setclientomnvar( "ui_ztron_is_highest_score", 1 );
    }
}

// Namespace ztron_score
// Params 1, eflags: 0x4
// Checksum 0xc2210332, Offset: 0x1e03
// Size: 0x71
function private function_11408ef3c67aca20( itemtype )
{
    if ( itemtype != #"gem" )
    {
        return;
    }
    
    counter = self.pers[ "extrascore4" ];
    counter++;
    stats::setextrascore4( counter );
    
    if ( isdefined( level.ztron.var_ccad830a7a66e349 ) )
    {
        self [[ level.ztron.var_ccad830a7a66e349 ]]();
    }
}

// Namespace ztron_score
// Params 0, eflags: 0xc
// Checksum 0x968076f4, Offset: 0x1e7c
// Size: 0x35
function private function_151e6e47b881e9e4()
{
    self notify( #"hash_ce23c20d48fdbcc5" );
    self endon( #"hash_ce23c20d48fdbcc5" );
    level utility::flag_wait( "StartGameTypeCallbackFinished" );
    level.modifyunifiedpointscallback = &function_411cf7b68bf9d1c4;
}

// Namespace ztron_score
// Params 5, eflags: 0x4
// Checksum 0xbd220004, Offset: 0x1eb9
// Size: 0x31, Type: bool
function private function_411cf7b68bf9d1c4( points, event, player, objweapon, eventinfo )
{
    return false;
}

// Namespace ztron_score
// Params 0, eflags: 0xc
// Checksum 0xa0c8edfd, Offset: 0x1ef3
// Size: 0x3d
function private function_480fd50de0dfa367()
{
    self notify( #"hash_85edb1ebc60c4f4" );
    self endon( #"hash_85edb1ebc60c4f4" );
    level utility::flag_wait( "StartGameTypeCallbackFinished" );
    level.var_f49310927ee806e5 = &ztron_xp_override;
    level thread function_f7ec7e5871ecf000();
}

// Namespace ztron_score
// Params 3, eflags: 0x4
// Checksum 0x8453db69, Offset: 0x1f38
// Size: 0x1f, Type: bool
function private ztron_xp_override( player, type, xp )
{
    return false;
}

// Namespace ztron_score
// Params 0
// Checksum 0x290b5af4, Offset: 0x1f60
// Size: 0xe1
function function_1274c7ff344280d8()
{
    profilestart();
    
    if ( self == level )
    {
        foreach ( player in level.players )
        {
            player.ztron.var_a29b078042e8cf95 = 0;
            player.ztron.var_ac97b95694bb8caa = 0;
        }
    }
    else if ( self.ztron )
    {
        self.ztron.var_a29b078042e8cf95 = 0;
        self.ztron.var_ac97b95694bb8caa = 0;
    }
    
    profilestop();
}

// Namespace ztron_score
// Params 0
// Checksum 0x2c8cea1, Offset: 0x2049
// Size: 0xa5
function getscalar()
{
    profilestart();
    
    switch ( level.players.size )
    {
        case 1:
            profilestop();
            return getdvarfloat( @"hash_181cb687d97298b8", 1.9 );
        case 2:
            profilestop();
            return getdvarfloat( @"hash_dd8e1cbdeef7d14d", 1.9 );
        case 3:
            profilestop();
            return getdvarfloat( @"hash_b7e7a25e9db0ccdf", 1.9 );
        case 4:
            profilestop();
            return getdvarfloat( @"hash_db0b2116c2d2ecd8", 1.9 );
        default:
            profilestop();
            return 0;
    }
    
    profilestop();
}

// Namespace ztron_score
// Params 0
// Checksum 0xb512a3bf, Offset: 0x20f6
// Size: 0x131
function function_9c413f7b3e5eebb8()
{
    profilestart();
    xp = spawnstruct();
    xp.timexp = 0;
    xp.var_109a360d3070a93a = 0;
    
    if ( self.ztron.var_a29b078042e8cf95 > 0 )
    {
        xp.timexp = ztron_util::function_48adcba773dadf31( self.ztron.var_a29b078042e8cf95 );
    }
    
    if ( self.ztron.var_ac97b95694bb8caa > 0 )
    {
        xp.var_109a360d3070a93a = int( self.ztron.var_ac97b95694bb8caa + 0.5 );
    }
    
    xp.scalar = getscalar();
    xp.timexp = int( xp.timexp * xp.scalar );
    xp.var_109a360d3070a93a = int( xp.var_109a360d3070a93a * xp.scalar );
    xp.awardxp = xp.timexp + xp.var_109a360d3070a93a;
    profilestop();
    return xp;
}

// Namespace ztron_score
// Params 0
// Checksum 0x17fabb9, Offset: 0x2231
// Size: 0x18, Type: bool
function function_2b7590cd3349fd84()
{
    return level.ztron.roundnumber >= 5;
}

// Namespace ztron_score
// Params 1
// Checksum 0x49478155, Offset: 0x2252
// Size: 0x223
function awardxp( player )
{
    profilestart();
    
    if ( level.ztron.cabinetmode )
    {
        profilestop();
        return 0;
    }
    
    if ( !isdefined( player ) || !isdefined( player.ztron ) )
    {
        profilestop();
        return 0;
    }
    
    if ( isbot( player ) )
    {
        profilestop();
        return 0;
    }
    
    if ( !function_2b7590cd3349fd84() )
    {
        profilestop();
        return 0;
    }
    
    xp = player function_9c413f7b3e5eebb8();
    
    if ( xp.awardxp > 0 )
    {
        ztron_debug::debugmsg( "XP Awarded To Player:" + player.name, 1 );
        ztron_debug::debugmsg( "\t\tXP SCALAR:" + xp.scalar, 1 );
        ztron_debug::debugmsg( "\t\tTimeXP Award:" + xp.timexp, 1 );
        ztron_debug::debugmsg( "\t\tKillXP Award:" + xp.var_109a360d3070a93a, 1 );
        ztron_debug::debugmsg( "\t\tTOTAL AWARD:" + xp.awardxp, 1 );
        player rank::giverankxp( #"ztron_xp_award", xp.awardxp, undefined, 0, 1, 1, undefined );
        logstring( "XP Awarded To Player:" + player.name + " ztron_xp_award:" + xp.awardxp );
    }
    
    if ( player.ztron.var_a29b078042e8cf95 > 0 )
    {
        ztron_debug::debugmsg( "Gum XP Awarded To Player:" + player.name + " Time Credit: " + player.ztron.var_a29b078042e8cf95, 1 );
        ztron_player_utility::function_9137f806254e5d71( player, player.ztron.var_a29b078042e8cf95 );
        logstring( "GobbleGum accumulator:" + player.name + " gg_time_award:" + player.ztron.var_a29b078042e8cf95 );
    }
    
    player function_1274c7ff344280d8();
    player notify( #"xp_award", { #xp:xp.awardxp } );
    profilestop();
    return xp.awardxp;
}

// Namespace ztron_score
// Params 0
// Checksum 0xb3fd3d03, Offset: 0x247f
// Size: 0x153
function function_7cefb98972a39f08()
{
    self notify( #"hash_db61d26ae892bdb8" );
    self endon( #"hash_db61d26ae892bdb8" );
    
    /#
        self endon( #"disconnect" );
        level endon( #"ztron_game_is_over" );
        idx = 0;
        self.ztron.var_166b1f233a929b39 = [];
        minuteidx = 0;
        var_8d3e44e9b43d06f1 = 0;
        
        for ( i = 0; i < 60 ; i++ )
        {
            self.ztron.var_166b1f233a929b39[ i ] = 0;
        }
        
        var_c51645f7da066786 = undefined;
        
        while ( true )
        {
            result = utility::waittill_any_return_params_or_timeout( 1, "<dev string:x24>" );
            
            if ( result[ "<dev string:x2d>" ] == "<dev string:x24>" )
            {
                if ( isdefined( var_c51645f7da066786 ) )
                {
                    assert( gettime() - var_c51645f7da066786 >= 1000, "<dev string:x35>" );
                }
                
                self.ztron.var_166b1f233a929b39[ minuteidx ] = result[ 0 ].xp;
                var_c51645f7da066786 = gettime();
                continue;
            }
            
            var_8d3e44e9b43d06f1++;
            
            if ( var_8d3e44e9b43d06f1 >= 60 )
            {
                var_8d3e44e9b43d06f1 = 0;
                minuteidx = ( minuteidx + 1 ) % 60;
                self.ztron.var_166b1f233a929b39[ minuteidx ] = 0;
            }
        }
    #/
}

// Namespace ztron_score
// Params 0
// Checksum 0x1af02e9c, Offset: 0x25da
// Size: 0x67
function function_ec39c4ec5e5ffdca()
{
    profilestart();
    
    /#
        if ( !isdefined( self.ztron.var_166b1f233a929b39 ) )
        {
            profilestop();
            return 0;
        }
        
        total = 0;
        
        for ( i = 0; i < 60 ; i++ )
        {
            total += self.ztron.var_166b1f233a929b39[ i ];
        }
        
        profilestop();
        return total;
    #/
    
    profilestop();
    return 0;
}

// Namespace ztron_score
// Params 0
// Checksum 0x31425f9f, Offset: 0x264b
// Size: 0x4b9
function function_f7ec7e5871ecf000()
{
    self notify( #"hash_3ad102b2892bd118" );
    self endon( #"hash_3ad102b2892bd118" );
    level endon( #"ztron_game_is_over" );
    level function_1274c7ff344280d8();
    level.ztron.dev.var_c9eec3bd4fb84fe3 = 0;
    
    while ( true )
    {
        wait 1;
        
        foreach ( player in level.players )
        {
            if ( !player.ztron )
            {
                continue;
            }
            
            /#
                player.ztron.allowxp = 0;
            #/
        }
        
        if ( ztron_main::function_4da200e9b8d58a3c() == 1 && level utility::flag( "ztron_round_spawning" ) )
        {
            if ( utility::flag( "ztron_round_paused" ) || level.hostmigrationtimer )
            {
                continue;
            }
            
            level.ztron.dev.var_c9eec3bd4fb84fe3++;
            
            foreach ( player in level.players )
            {
                if ( !player.ztron )
                {
                    continue;
                }
                
                if ( isalive( player ) && !player.inlaststand && player.ztron.var_d0fa1c02675f0d94 < 10 )
                {
                    player.ztron.var_a29b078042e8cf95 += 1;
                    
                    /#
                        player.ztron.allowxp = 1;
                    #/
                }
            }
            
            continue;
        }
        
        if ( ztron_main::function_4da200e9b8d58a3c() == 5 && level utility::flag( "ztron_slayer_waves_spawning" ) )
        {
            level.ztron.dev.var_c9eec3bd4fb84fe3++;
            
            foreach ( player in level.players )
            {
                if ( !player.ztron )
                {
                    continue;
                }
                
                if ( isalive( player ) && !player.inlaststand && player.ztron.var_d0fa1c02675f0d94 < 10 )
                {
                    player.ztron.var_a29b078042e8cf95 += 1;
                    
                    /#
                        player.ztron.allowxp = 1;
                    #/
                }
            }
            
            continue;
        }
        
        if ( ztron_main::function_4da200e9b8d58a3c() == 3 && level.ztron.var_8a9067aa4cd65369.hazardzone )
        {
            level.ztron.dev.var_c9eec3bd4fb84fe3++;
            
            foreach ( player in level.players )
            {
                if ( !player.ztron )
                {
                    continue;
                }
                
                if ( isalive( player ) && !player.inlaststand && player.ztron.var_d0fa1c02675f0d94 < 10 )
                {
                    player.ztron.var_a29b078042e8cf95 += 1;
                    
                    /#
                        player.ztron.allowxp = 1;
                    #/
                }
            }
        }
    }
}

