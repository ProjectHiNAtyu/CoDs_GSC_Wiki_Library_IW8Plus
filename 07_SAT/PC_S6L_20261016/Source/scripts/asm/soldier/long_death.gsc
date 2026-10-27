// scripts\asm\soldier\long_death.gsc  (hash_1c26aa437f78ec66.gscc) (size: 13700 Bytes / 0x3584 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf88e3a9e (4170070686)
// size ...... 13700 (0x3584)
// includes .. 6   (offset: 0x3280)
// strings ... 35  (offset: 0x32b0)
// dev strs .. 8   (offset: 0x34c4)
// exports ... 38  (offset: 0x2098)
// cseg ...... 0x286 + 0x1e12 (0x2098)
// imports ... 87  (offset: 0x2688)
// animtree1 . 0   (offset: 0x3584)
// animtree2 . 0   (offset: 0x3584)
#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\asm\shared\death;
#using scripts\asm\soldier\death;
#using scripts\common\trace;
#using scripts\common\utility;

#namespace long_death;

// Namespace long_death
// Params 0, eflags: 0x5
// Checksum 0xb951a17, Offset: 0x2a4
// Size: 0x3b3
function private autoexec function_f0a41e51a299528d()
{
    if ( !isdefined( level.longdeath ) )
    {
        level.longdeath = spawnstruct();
        level.longdeath.var_217dde85e05aa633 = 1;
        settodefault = 1;
        
        if ( isxhashasset( level.gamemodebundle.var_c538a52da671e282 ) )
        {
            var_c538a52da671e282 = getscriptbundle( level.gamemodebundle.var_c538a52da671e282 );
            settodefault = 0;
            level.longdeath.var_e2e8999f74185bc6 = int( var_c538a52da671e282.var_82c27da9087b7ac ?? 10 );
            level.longdeath.var_3174101223c67dac = int( var_c538a52da671e282.var_40434db511e9c8e2 ?? 30 );
            level.longdeath.var_8663ae86c26eef9d = int( utility::function_4b74c15943231980( var_c538a52da671e282.var_fad3bdb17232b7c1 ?? 15 ) );
            level.longdeath.var_315d93678daea687 = int( utility::function_4b74c15943231980( var_c538a52da671e282.var_343d910811b0b4c3 ?? 60 ) );
            level.longdeath.var_62822a87609797b1 = int( var_c538a52da671e282.var_93ddf2f5e1d0b5d2 ?? 5 );
            level.longdeath.var_8da67f48bda44c1f = int( var_c538a52da671e282.var_f21b591129d154ec ?? 12 );
            level.longdeath.var_9cbc1d8a980d5de2 = int( utility::function_4b74c15943231980( var_c538a52da671e282.var_18e0a162a65f2f63 ?? 5 ) );
            level.longdeath.var_3a7de7fad0880fc = int( utility::function_4b74c15943231980( var_c538a52da671e282.var_57a148a435434829 ?? 25 ) );
            level.longdeath.var_2d05526fd0beaf9a = int( utility::function_4b74c15943231980( var_c538a52da671e282.var_61523712055ec1c2 ?? 7 ) );
            level.longdeath.var_aaa3e4ff68c1ca68 = int( utility::function_4b74c15943231980( var_c538a52da671e282.var_9ac2d192fd7d17fc ?? 13 ) );
            
            if ( var_c538a52da671e282.var_c1bdc9a6a549eb02 > 0 )
            {
                level.longdeath.revivepct = var_c538a52da671e282.var_c1bdc9a6a549eb02;
            }
            
            if ( isdefined( var_c538a52da671e282.var_67ee9446a31a267 ) && !var_c538a52da671e282.var_67ee9446a31a267 )
            {
                level.longdeath.var_217dde85e05aa633 = 0;
            }
        }
        
        if ( settodefault )
        {
            level.longdeath.var_e2e8999f74185bc6 = 10;
            level.longdeath.var_3174101223c67dac = 30;
            level.longdeath.var_8663ae86c26eef9d = int( utility::function_4b74c15943231980( 15 ) );
            level.longdeath.var_315d93678daea687 = int( utility::function_4b74c15943231980( 60 ) );
            level.longdeath.var_62822a87609797b1 = 5;
            level.longdeath.var_8da67f48bda44c1f = 12;
            level.longdeath.var_9cbc1d8a980d5de2 = int( utility::function_4b74c15943231980( 5 ) );
            level.longdeath.var_3a7de7fad0880fc = int( utility::function_4b74c15943231980( 25 ) );
            level.longdeath.var_2d05526fd0beaf9a = int( utility::function_4b74c15943231980( 7 ) );
            level.longdeath.var_aaa3e4ff68c1ca68 = int( utility::function_4b74c15943231980( 13 ) );
        }
    }
}

// Namespace long_death
// Params 0
// Checksum 0x511f74d6, Offset: 0x65f
// Size: 0x22f
function preventpainforashorttime()
{
    self endon( #"kill_long_death" );
    self endon( #"death" );
    self.flashbangimmunity = 1;
    self.longdeathstarting = 1;
    self.doinglongdeath = 1;
    self notify( #"long_death" );
    
    if ( level.longdeath.var_217dde85e05aa633 )
    {
        self.health = 120;
    }
    
    self.threatbias -= 5000;
    setnextcrawlingpaintime( gettime() + 3000 );
    setnextcrawlingpaintimefromlegdamage( gettime() + 3000 );
    wait 0.75;
    
    if ( level.longdeath.var_217dde85e05aa633 && self.health > 1 )
    {
        self.health = 1;
    }
    
    wait 0.05;
    self.longdeathstarting = undefined;
    self.a.mayonlydie = 1;
    wait 1;
    
    if ( isdefined( level.player ) && distancesquared( self.origin, level.player.origin ) < 1048576 )
    {
        setnumdeathsuntilcrawlingpain( randomintrange( level.longdeath.var_e2e8999f74185bc6, level.longdeath.var_3174101223c67dac ) );
        setnextcrawlingpaintime( gettime() + randomintrange( level.longdeath.var_8663ae86c26eef9d, level.longdeath.var_315d93678daea687 ) );
    }
    else
    {
        setnumdeathsuntilcrawlingpain( randomintrange( level.longdeath.var_62822a87609797b1, level.longdeath.var_8da67f48bda44c1f ) );
        setnextcrawlingpaintime( gettime() + randomintrange( level.longdeath.var_9cbc1d8a980d5de2, level.longdeath.var_3a7de7fad0880fc ) );
    }
    
    setnextcrawlingpaintimefromlegdamage( gettime() + randomintrange( level.longdeath.var_2d05526fd0beaf9a, level.longdeath.var_aaa3e4ff68c1ca68 ) );
}

// Namespace long_death
// Params 1
// Checksum 0xc091d277, Offset: 0x896
// Size: 0x1c2
function dyingcrawlbackaim( statename )
{
    self endon( #"death" );
    self notify( #"hash_5561c96a5122bb04" );
    self endon( #"hash_5561c96a5122bb04" );
    self endon( statename + "_finished" );
    
    if ( isagent( self ) )
    {
        return;
    }
    
    aim4 = asm::asm_getxanim( statename, asm::asm_lookupanimfromalias( statename, "aim_4" ) );
    aim6 = asm::asm_getxanim( statename, asm::asm_lookupanimfromalias( statename, "aim_6" ) );
    aim4_knob = asm::asm_getxanim( statename, asm::asm_lookupanimfromalias( statename, "aim_4_knob" ) );
    aim6_knob = asm::asm_getxanim( statename, asm::asm_lookupanimfromalias( statename, "aim_6_knob" ) );
    wait 0.05;
    self aisetanimlimited( aim4, 1, 0 );
    self aisetanimlimited( aim6, 1, 0 );
    prevyaw = 0;
    
    while ( true )
    {
        aimyaw = utility_common::getyawtoenemy();
        diff = angleclamp180( aimyaw - prevyaw );
        
        if ( abs( diff ) > 3 )
        {
            diff = utility::sign( diff ) * 3;
        }
        
        aimyaw = angleclamp180( prevyaw + diff );
        
        if ( aimyaw < 0 )
        {
            if ( aimyaw < -45 )
            {
                aimyaw = -45;
            }
            
            weight = aimyaw / -45;
            self setanim( aim4_knob, weight, 0.05 );
            self setanim( aim6_knob, 0, 0.05 );
        }
        else
        {
            if ( aimyaw > 45 )
            {
                aimyaw = 45;
            }
            
            weight = aimyaw / 45;
            self setanim( aim6_knob, weight, 0.05 );
            self setanim( aim4_knob, 0, 0.05 );
        }
        
        prevyaw = aimyaw;
        wait 0.05;
    }
}

// Namespace long_death
// Params 1
// Checksum 0x97adf73d, Offset: 0xa60
// Size: 0x5c
function setupaiming( statename )
{
    clearknob = asm::asm_lookupanimfromalias( statename, "clear_knob" );
    
    if ( isdefined( self.a.bdyingbackidleandshootsetup ) )
    {
        return;
    }
    
    thread dyingcrawlbackaim( statename );
    self.a.bdyingbackidleandshootsetup = 1;
}

// Namespace long_death
// Params 0
// Checksum 0x6ee9eaff, Offset: 0xac4
// Size: 0x118
function dodyingcrawlbloodsmear()
{
    self endon( #"death" );
    origintag = "J_SpineLower";
    angletag = "tag_origin";
    fx_rate = 6;
    fx = level._effect[ "crawling_death_blood_smear" ];
    
    if ( isdefined( self.a.crawl_fx_rate ) )
    {
        fx_rate = self.a.crawl_fx_rate;
    }
    
    if ( isdefined( self.a.crawl_fx ) )
    {
        fx = level._effect[ self.a.crawl_fx ];
    }
    
    while ( fx_rate )
    {
        org = self gettagorigin( origintag );
        angles = self gettagangles( angletag );
        forward = anglestoright( angles );
        up = anglestoforward( ( 270, 0, 0 ) );
        playfx( fx, org, up, forward );
        wait fx_rate;
    }
}

// Namespace long_death
// Params 1
// Checksum 0x48e6c109, Offset: 0xbe4
// Size: 0x25
function iscrawldeltaallowed( thexanim )
{
    if ( self.force_num_crawls > 0 )
    {
        return 1;
    }
    
    return isanimdeltaallowed( thexanim );
}

// Namespace long_death
// Params 1
// Checksum 0x86824fbd, Offset: 0xc12
// Size: 0x54
function startdyingcrawlbackaimsoon( statename )
{
    self endon( statename + "_finished" );
    wait 0.1;
    
    if ( isdefined( self.a.bdyingbackidleandshootsetup ) )
    {
        return;
    }
    
    thread dyingcrawlbackaim( statename );
    self.a.bdyingbackidleandshootsetup = 1;
}

// Namespace long_death
// Params 3
// Checksum 0xcb16e2fd, Offset: 0xc6e
// Size: 0x102, Type: bool
function handlebackcrawlnotetracks( statename, note, params )
{
    if ( !isdefined( self.bdoingbloodsmear ) && issubstr( note, "bodyfall" ) )
    {
        thread dodyingcrawlbloodsmear();
    }
    else if ( note == "fire_spray" )
    {
        if ( !utility_common::canseeenemy() )
        {
            return true;
        }
        
        if ( !self function_74abc5c338d34b0b() )
        {
            return true;
        }
        
        utility_common::shootenemywrapper();
        return true;
    }
    else if ( note == "pistol_pickup" )
    {
        thread startdyingcrawlbackaimsoon( statename );
        
        if ( self.weapon.classname == "pistol" )
        {
            return true;
        }
        
        return false;
    }
    else if ( note == "fire" )
    {
        utility_common::shootenemywrapper();
        return true;
    }
    else if ( note == "code_move" )
    {
        return true;
    }
    else if ( note == "gun drop" )
    {
        if ( self.weapon.classname == "pistol" )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace long_death
// Params 3
// Checksum 0x52cfe045, Offset: 0xd79
// Size: 0x1a0
function playdyingcrawl( asmname, statename, params )
{
    self endon( statename + "_finished" );
    
    if ( self.force_num_crawls > 0 )
    {
        numcrawls = self.force_num_crawls;
    }
    else
    {
        numcrawls = randomintrange( 1, 5 );
    }
    
    animid = asm::asm_getanim( asmname, statename );
    assert( isdefined( animid ), "<dev string:x24>" + statename + "<dev string:x36>" + asmname + "<dev string:x3f>" + self.classname );
    xanim = asm::asm_getxanim( statename, animid );
    assert( isdefined( xanim ), "<dev string:x45>" + animid + "<dev string:x59>" + statename + "<dev string:x36>" + asmname + "<dev string:x3f>" + self.classname );
    assert( animhasnotetrack( xanim, "<dev string:x64>" ), "<dev string:x6e>" + getxhashsourcename( getanimname( xanim ) ) + "<dev string:x74>" );
    self aisetanim( statename, animid );
    asm::asm_playfacialanim( asmname, statename, xanim );
    
    for ( i = 0; i < numcrawls ; i++ )
    {
        if ( !iscrawldeltaallowed( xanim ) )
        {
            break;
        }
        
        if ( isdefined( self.custom_crawl_sound ) )
        {
            self playsound( self.custom_crawl_sound );
        }
        
        while ( true )
        {
            endnote = asm::asm_donotetracks( asmname, statename, asm::asm_getnotehandler( asmname, statename ) );
            
            if ( endnote == "code_move" )
            {
                break;
            }
        }
    }
    
    asm::asm_fireevent( asmname, "dying_crawl_done" );
}

// Namespace long_death
// Params 3
// Checksum 0xbdb3ca78, Offset: 0xf21
// Size: 0x1b5
function playdyingcrawlback( asmname, statename, params )
{
    self endon( statename + "_finished" );
    
    if ( isdefined( self.enemy ) )
    {
        utility::lookatentity( self.enemy );
    }
    
    if ( self.force_num_crawls > 0 )
    {
        numcrawls = self.force_num_crawls;
    }
    else
    {
        numcrawls = randomintrange( 1, 5 );
    }
    
    setupaiming( statename );
    crawlanim = asm::asm_getanim( asmname, statename );
    assert( isdefined( crawlanim ), "<dev string:x24>" + statename + "<dev string:x36>" + asmname + "<dev string:x3f>" + self.classname );
    crawlxanim = asm::asm_getxanim( statename, crawlanim );
    assert( isdefined( crawlxanim ), "<dev string:x45>" + crawlanim + "<dev string:x59>" + statename + "<dev string:x36>" + asmname + "<dev string:x3f>" + self.classname );
    assert( animhasnotetrack( crawlxanim, "<dev string:x64>" ) );
    asm::asm_playfacialanim( asmname, statename, crawlxanim );
    self aisetanim( statename, crawlanim );
    
    for ( i = 0; i < numcrawls ; i++ )
    {
        if ( !iscrawldeltaallowed( crawlxanim ) )
        {
            break;
        }
        
        while ( true )
        {
            endnote = asm::asm_donotetrackswithinterceptor( asmname, statename, &handlebackcrawlnotetracks );
            
            if ( endnote == "end" )
            {
                break;
            }
        }
    }
    
    if ( !self.var_38a06ee92c60ee9e )
    {
        self.desiredtimeofdeath = gettime() + randomintrange( 4000, 20000 );
    }
    
    asm::asm_fireevent( asmname, "dying_back_crawl_done" );
}

// Namespace long_death
// Params 3
// Checksum 0xa7b2bf50, Offset: 0x10de
// Size: 0x34
function playcrawlflipover( asmname, statename, params )
{
    utility::lookatentity();
    asm::asm_playanimstatewithnotetrackinterceptor( asmname, statename, &handlebackcrawlnotetracks );
}

// Namespace long_death
// Params 3
// Checksum 0x85c1bf11, Offset: 0x111a
// Size: 0x83
function playcrawlingpaintransition( asmname, statename, params )
{
    setearlyfinishtime();
    
    if ( self.forcelongdeathskipintroanim )
    {
        if ( !asm::asm_eventfired( asmname, "end" ) )
        {
            asm::asm_fireevent( asmname, "end" );
        }
        
        return;
    }
    
    thread preventpainforashorttime();
    utility::lookatentity();
    self.ignoreall = 1;
    self.var_38a06ee92c60ee9e = 0;
    asm::asm_playanimstatewithnotetrackinterceptor( asmname, statename, &handlebackcrawlnotetracks );
}

// Namespace long_death
// Params 0
// Checksum 0x44aef82a, Offset: 0x11a5
// Size: 0x5b
function setearlyfinishtime()
{
    if ( !isdefined( self.asm.longdeathanims ) )
    {
        self.asm.longdeathanims = spawnstruct();
    }
    
    earlyfinishtime = self.longdeathanims_earlyfinishtimeoverride ?? 2000;
    self.longdeathanims_earlyfinishtime = gettime() + earlyfinishtime;
}

// Namespace long_death
// Params 3
// Checksum 0x863e0b2f, Offset: 0x1208
// Size: 0xb8
function playdyingbackshoot( asmname, statename, params )
{
    self endon( statename + "_finished" );
    setupaiming( statename );
    
    while ( true )
    {
        animid = asm::asm_getanim( asmname, statename );
        xanim = asm::asm_getxanim( statename, animid );
        asm::asm_playfacialanim( asmname, statename, xanim );
        self aisetanim( statename, animid );
        endnote = asm::asm_donotetrackswithinterceptor( asmname, statename, &handlebackcrawlnotetracks );
        
        if ( endnote == "end" )
        {
            if ( !asm::asm_eventfired( asmname, "end" ) )
            {
                asm::asm_fireevent( asmname, "end" );
            }
        }
    }
}

// Namespace long_death
// Params 3
// Checksum 0x8a0d6da2, Offset: 0x12c8
// Size: 0x42
function choosedyingbackidle( asmname, statename, params )
{
    if ( self.longdeathnoncombat )
    {
        return asm::asm_lookupanimfromalias( statename, "noncombat" );
    }
    
    return asm::asm_chooseanim( asmname, statename, params );
}

// Namespace long_death
// Params 3
// Checksum 0x73c45444, Offset: 0x1313
// Size: 0xc9
function playdyingbackidle( asmname, statename, params )
{
    self endon( statename + "_finished" );
    
    if ( !self.longdeathnoncombat )
    {
        self.nextlongdeathshoottime = gettime() + randomintrange( 500, 1000 );
        setupaiming( statename );
    }
    
    prevanim = undefined;
    
    while ( true )
    {
        animid = asm::asm_getanim( asmname, statename );
        xanim = asm::asm_getxanim( statename, animid );
        
        if ( animid != prevanim )
        {
            self aisetanim( statename, animid );
            prevanim = animid;
        }
        
        asm::asm_playfacialanim( asmname, statename, xanim );
        prevanim = animid;
        asm::asm_donotetrackssingleloop( asmname, statename, xanim, asm::asm_getnotehandler( asmname, statename ) );
    }
}

// Namespace long_death
// Params 3
// Checksum 0xe9e8157e, Offset: 0x13e4
// Size: 0x52
function playstumblingpaintransition( asmname, statename, params )
{
    thread preventpainforashorttime();
    setearlyfinishtime();
    self.ignoreall = 1;
    self.var_38a06ee92c60ee9e = 0;
    utility::lookatentity();
    asm::asm_playanimstate( asmname, statename );
}

// Namespace long_death
// Params 3
// Checksum 0xfb3bd83b, Offset: 0x143e
// Size: 0x16d
function playstumblingwander( asmname, statename, params )
{
    self endon( statename + "_finished" );
    animid = asm::asm_getanim( asmname, statename );
    collapsestatename = "stumbling_pain_collapse_death";
    collapseanimid = asm::asm_getanim( asmname, collapsestatename );
    collapsexanim = asm::asm_getxanim( collapsestatename, collapseanimid );
    assert( isdefined( animid ) );
    xanim = asm::asm_getxanim( statename, animid );
    
    if ( !animhasnotetrack( xanim, "code_move" ) )
    {
        asm::asm_fireevent( asmname, "pain_wander_done" );
        return;
    }
    
    collapsedelta = getmovedelta( collapsexanim );
    
    if ( self.var_77982791b5e3a0e4 > 0 )
    {
        var_131632401aabfd93 = self.var_77982791b5e3a0e4;
    }
    else
    {
        var_131632401aabfd93 = randomintrange( 1, 3 );
    }
    
    self aisetanim( statename, animid );
    asm::asm_playfacialanim( asmname, statename, xanim );
    
    while ( var_131632401aabfd93 > 0 )
    {
        endpos = self localtoworldcoords( collapsedelta );
        
        if ( !self maymovetopoint( endpos ) )
        {
            break;
        }
        
        while ( true )
        {
            endnote = asm::asm_donotetracks( asmname, statename, asm::asm_getnotehandler( asmname, statename ) );
            
            if ( endnote == "code_move" )
            {
                break;
            }
        }
        
        var_131632401aabfd93--;
    }
    
    asm::asm_fireevent( asmname, "pain_wander_done" );
}

// Namespace long_death
// Params 4
// Checksum 0x45bdd5f0, Offset: 0x15b3
// Size: 0x31, Type: bool
function hasbeenhitwithemp( asmname, statename, tostatename, params )
{
    return istrue( self.isempd );
}

// Namespace long_death
// Params 4
// Checksum 0x86177a8f, Offset: 0x15ed
// Size: 0x152, Type: bool
function shoulddodyingcrawl( asmname, statename, tostatename, params )
{
    if ( self.forcelongdeath == 4 )
    {
        return true;
    }
    
    if ( self.currentpose == "prone" )
    {
        return true;
    }
    
    if ( self.a.movement == "stop" )
    {
        if ( randomint( 100 ) <= 20 )
        {
            return true;
        }
        else if ( abs( self.damageyaw ) > 90 )
        {
            return true;
        }
    }
    else if ( abs( self getmotionangle() ) > 90 )
    {
        return true;
    }
    
    if ( self.currentpose != "prone" )
    {
        crawlanim = asm::asm_getanim( asmname, tostatename );
        assert( isdefined( crawlanim ), "<dev string:x24>" + statename + "<dev string:x36>" + asmname + "<dev string:x3f>" + self.classname );
        crawlxanim = asm::asm_getxanim( tostatename, crawlanim );
        assert( isdefined( crawlxanim ), "<dev string:x45>" + crawlanim + "<dev string:x59>" + statename + "<dev string:x36>" + asmname + "<dev string:x3f>" + self.classname );
        
        if ( !iscrawldeltaallowed( crawlxanim ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace long_death
// Params 3
// Checksum 0xb6b75056, Offset: 0x1748
// Size: 0x9e
function playlongdeathintro( asmname, statename, params )
{
    thread preventpainforashorttime();
    self.ignoreall = 1;
    
    if ( self.var_38a06ee92c60ee9e )
    {
        self.var_759c7a2961dbeb3a = self.var_38a06ee92c60ee9e;
        self.var_38a06ee92c60ee9e = 0;
    }
    
    death::stop_sounds();
    
    if ( self.forcelongdeathskipintroanim )
    {
        if ( !asm::asm_eventfired( asmname, "end" ) )
        {
            asm::asm_fireevent( asmname, "end" );
        }
        
        return;
    }
    
    setearlyfinishtime();
    playlongdeathanim( asmname, statename, 1 );
}

// Namespace long_death
// Params 3
// Checksum 0x7051247e, Offset: 0x17ee
// Size: 0x69
function playlongdeathintroterminate( asmname, statename, params )
{
    if ( self.var_759c7a2961dbeb3a )
    {
        self.var_38a06ee92c60ee9e = self.var_759c7a2961dbeb3a;
        self.var_759c7a2961dbeb3a = undefined;
        self.desiredtimeofdeath = gettime() + self.revive_bleedouttime;
    }
    
    self notify( #"killanimscript" );
}

// Namespace long_death
// Params 3
// Checksum 0xda5fb558, Offset: 0x185f
// Size: 0x29
function playlongdeathmercy( asmname, statename, params )
{
    playlongdeathanim( asmname, statename, 0 );
}

// Namespace long_death
// Params 3
// Checksum 0xd3ab4428, Offset: 0x1890
// Size: 0xad
function playlongdeathidle( asmname, statename, params )
{
    if ( self.var_e3e48677cb3f2b2b )
    {
        self.var_a3bca2baec630487 = gettime() + self.var_7aded615ddc3e6cf;
    }
    
    if ( isdefined( self.var_54ef91c66033b8d6 ) )
    {
        self.var_af9f526637646c19 = gettime() + self.var_54ef91c66033b8d6;
    }
    
    canplayanim = longdeathidlesingleloop( asmname, statename, params );
    
    if ( !canplayanim )
    {
        self.var_af9f526637646c19 = gettime();
        
        if ( !asm::asm_eventfired( asmname, "end" ) )
        {
            asm::asm_fireevent( asmname, "end" );
        }
    }
}

// Namespace long_death
// Params 3
// Checksum 0xd97bd9e2, Offset: 0x1945
// Size: 0xb8
function playshootinglongdeathidle( asmname, statename, params )
{
    if ( !isdefined( self.desiredtimeofdeath ) )
    {
        self.desiredtimeofdeath = gettime() + randomintrange( 4000, 20000 );
    }
    
    self.nextlongdeathshoottime = gettime() + randomintrange( 500, 1000 );
    self.timestartwaitingtoshoot = gettime();
    setupaiming( statename );
    canplayanim = longdeathidlesingleloop( asmname, statename, params );
    
    if ( !canplayanim )
    {
        self.var_af9f526637646c19 = gettime();
        
        if ( !asm::asm_eventfired( asmname, "end" ) )
        {
            asm::asm_fireevent( asmname, "end" );
        }
    }
}

// Namespace long_death
// Params 3
// Checksum 0x67e05482, Offset: 0x1a05
// Size: 0x28
function longdeathidlesingleloop( asmname, statename, params )
{
    return playlongdeathanim( asmname, statename, 0 );
}

// Namespace long_death
// Params 3
// Checksum 0xc2ab036d, Offset: 0x1a36
// Size: 0x4d
function playlongdeathgrenade( asmname, statename, params )
{
    self.var_40b133f4677e957d = gettime() + int( randomfloatrange( 1.5, 1.9 ) * 1000 );
    playlongdeathanim( asmname, statename, 0 );
}

// Namespace long_death
// Params 3
// Checksum 0x34b418d0, Offset: 0x1a8b
// Size: 0x4c
function playlongdeathgrenadepull( asmname, statename, params )
{
    self.asm.longdeathanims.onfinaldeathcallback = &onfinaldeathdropgrenade;
    playlongdeathanim( asmname, statename, 0 );
}

// Namespace long_death
// Params 3
// Checksum 0x93e1aa3d, Offset: 0x1adf
// Size: 0x82, Type: bool
function function_5b409d01e16ff42b( statename, note, params )
{
    if ( note == "pistol_pickup" )
    {
        if ( self.weapon.classname == "pistol" )
        {
            return true;
        }
    }
    else if ( note == "gun drop" || note == "dropgun" )
    {
        if ( self.weapon.classname == "pistol" )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace long_death
// Params 3
// Checksum 0x72fc6e89, Offset: 0x1b6a
// Size: 0x13f, Type: bool
function playlongdeathanim( asmname, statename, var_e52ab08341d6bac8 )
{
    deathanim = asm::asm_getanim( asmname, statename );
    assert( isdefined( deathanim ), "<dev string:x24>" + statename + "<dev string:x36>" + asmname + "<dev string:x3f>" + self.classname );
    deathxanim = asm::asm_getxanim( statename, deathanim );
    assert( isdefined( deathxanim ), "<dev string:x45>" + deathanim + "<dev string:x59>" + statename + "<dev string:x36>" + asmname + "<dev string:x3f>" + self.classname );
    
    if ( self.forcelongdeath > 0 || var_e52ab08341d6bac8 || isanimdeltaallowed( deathxanim ) )
    {
        customnotehandler = asm::asm_getnotehandler( asmname, statename );
        
        if ( self.longdeathanims_alias == "exposed_stand_crawl_shoot" || self.longdeathanims_alias == "exposed_crouch_crawl_shoot" )
        {
            asm::asm_playanimstatewithnotetrackinterceptor( asmname, statename, &function_5b409d01e16ff42b );
        }
        else
        {
            asm::asm_playfacialanim( asmname, statename, deathxanim );
            self aisetanim( statename, deathanim );
            asm::asm_donotetracks( asmname, statename, asm::asm_getnotehandler( asmname, statename ) );
        }
    }
    else
    {
        return false;
    }
    
    return true;
}

// Namespace long_death
// Params 1
// Checksum 0x8b23562f, Offset: 0x1cb2
// Size: 0x8d
function isanimdeltaallowed( thexanim )
{
    if ( self.var_612f38f4e6e8e6bc )
    {
        return 1;
    }
    
    var_3a7235d2e3177149 = 30;
    delta = getmovedelta( thexanim, 0, 1 );
    deltalength = length( delta );
    deltadirection = vectornormalize( delta );
    delta = deltadirection * ( deltalength + var_3a7235d2e3177149 );
    endpoint = self localtoworldcoords( delta );
    
    if ( !checkstairsoffsetpoint( endpoint ) )
    {
        return 0;
    }
    
    return self maymovetopoint( endpoint );
}

// Namespace long_death
// Params 1
// Checksum 0xd6bf4264, Offset: 0x1d48
// Size: 0x13
function checkstairsoffsetpoint( endpoint )
{
    return self isatvalidlongdeathspot( endpoint );
}

// Namespace long_death
// Params 3
// Checksum 0xd9a853ca, Offset: 0x1d64
// Size: 0x6a
function playlongdeathfinaldeath( asmname, statename, params )
{
    if ( isdefined( self.asm.longdeathanims.onfinaldeathcallback ) )
    {
        [[ self.asm.longdeathanims.onfinaldeathcallback ]]();
    }
    
    death::playdeathanim( asmname, statename, params );
}

// Namespace long_death
// Params 0
// Checksum 0x3eea94dd, Offset: 0x1dd6
// Size: 0x119
function onfinaldeathdropgrenade()
{
    if ( !isdefined( self.longdeathanims_grenadetag ) )
    {
        return;
    }
    
    velocity = ( 0, 0, 30 ) - anglestoright( self.angles ) * 70;
    
    if ( self.longdeathanims_grenadetag == "tag_accessory_left" )
    {
        velocity *= -1;
    }
    
    releasepoint = self gettagorigin( self.longdeathanims_grenadetag );
    releasepointlifted = releasepoint + ( 0, 0, 20 );
    releasepointdropped = releasepoint - ( 0, 0, 20 );
    trace = trace::ray_trace( releasepointlifted, releasepointdropped, self, undefined, 1 );
    
    if ( trace[ "fraction" ] < 0.5 )
    {
        releasepoint = trace[ "position" ];
    }
    
    playsoundatpos( releasepoint, "grenade_bounce_heavy" );
    self detach( getweaponmodel( self.grenadeweapon.basename ), self.longdeathanims_grenadetag );
    self function_de0ec7f52c8250bd( releasepoint, velocity, randomfloatrange( 2, 3 ) );
}

// Namespace long_death
// Params 1
// Checksum 0x2323cef5, Offset: 0x1ef7
// Size: 0x79
function longdeathgrenadepullnotetrackhandler( note )
{
    if ( note == "grenade_left" )
    {
        self.longdeathanims_grenadetag = "tag_accessory_left";
    }
    else if ( note == "grenade_right" )
    {
        self.longdeathanims_grenadetag = "tag_accessory_right";
    }
    
    assert( isdefined( self.longdeathanims_grenadetag ) );
    self attach( getweaponmodel( self.grenadeweapon.basename ), self.longdeathanims_grenadetag );
}

// Namespace long_death
// Params 4
// Checksum 0xd7a9c507, Offset: 0x1f78
// Size: 0x85, Type: bool
function function_9296d173d2abf3ae( asmname, statename, tostatename, params )
{
    if ( !isdefined( self.grenadeweapon ) || isnullweapon( self.grenadeweapon ) || !isdefined( self.grenadeweapon.basename ) )
    {
        return false;
    }
    
    if ( !issubstr( self.grenadeweapon.basename, "frag" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace long_death
// Params 4
// Checksum 0xb49ccb7a, Offset: 0x2006
// Size: 0x91, Type: bool
function shouldstayalive( asmname, statename, tostatename, params )
{
    if ( self.damageshield )
    {
        if ( level.longdeath.revivepct > 0 )
        {
            self.health = int( level.longdeath.revivepct * self.maxhealth );
        }
        else
        {
            self.health = 150;
        }
        
        self.doinglongdeath = 0;
        return true;
    }
    
    return false;
}

