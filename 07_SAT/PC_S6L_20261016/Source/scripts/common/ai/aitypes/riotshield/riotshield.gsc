// scripts\common\ai\aitypes\riotshield\riotshield.gsc  (hash_51497c7579f0749c.gscc) (size: 9016 Bytes / 0x2338 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5a7e231 (94888497)
// size ...... 9016 (0x2338)
// includes .. 4   (offset: 0x209c)
// strings ... 38  (offset: 0x20bc)
// dev strs .. 6   (offset: 0x22e8)
// exports ... 22  (offset: 0x14b0)
// cseg ...... 0x312 + 0x119e (0x14b0)
// imports ... 72  (offset: 0x1820)
// animtree1 . 0   (offset: 0x2338)
// animtree2 . 0   (offset: 0x2338)
#using script_112673e9f8209cf8;
#using scripts\anim\shared;
#using scripts\asm\soldier\death;
#using scripts\common\utility;

#namespace riotshield;

// Namespace riotshield
// Params 1
// Checksum 0x6759bf01, Offset: 0x330
// Size: 0x12c
function function_73083095d3ae4436( taskid )
{
    if ( self.briotshieldinitialized )
    {
        return anim.success;
    }
    
    self.secondaryweapon = isnullweapon( self.secondaryweapon ) ? makeweapon( "rex_me_riotshield_breakable_mp" ) : self.secondaryweapon;
    assert( self.secondaryweapon.basename != "<dev string:x24>", "<dev string:x29>" );
    
    if ( self.secondaryweapon.basename != "none" )
    {
        utility::initweapon( self.secondaryweapon );
        self.riotshieldmodel = function_f470dac2408978f1( self.secondaryweapon );
        self.riotshieldmodeltag = "tag_weapon_left";
        self.bhasriotshieldattached = 1;
        self.briotshieldinitialized = 1;
        self.deathfunction = &function_98c75316275021fd;
        self.isdeathfunctiondefined = 1;
        self.var_9db3fecbc2f5e5f = %"soldier_agent";
        function_aa2f49b2a589cc9b();
        function_7f6d67613f263579();
        return anim.success;
    }
    
    return anim.failure;
}

// Namespace riotshield
// Params 1
// Checksum 0x33044d9d, Offset: 0x464
// Size: 0x1a8
function riotshield_init_ob( taskid )
{
    if ( self.briotshieldinitialized )
    {
        return anim.success;
    }
    
    weapon_name = "sat_me_riotshield_mp_ai";
    
    if ( issubstr( self.classname, "cradle" ) )
    {
        weapon_name = "sat_me_riotshield_mp_ai_cradled";
        self.impactalias = "hit_marker_riotshield_impact_cradled";
        self.dstalias = "eqp_marker_riotshield_destroy_cradled";
    }
    else
    {
        self.impactalias = "hit_marker_riotshield_impact";
        self.dstalias = "eqp_marker_riotshield_destroy";
    }
    
    attachments = getweapondefaultattachments( weapon_name );
    self.secondaryweapon = makeweapon( weapon_name, attachments );
    assert( self.secondaryweapon.basename != "<dev string:x24>", "<dev string:x55>" + weapon_name + "<dev string:x6c>" );
    
    if ( self.secondaryweapon.basename != "none" )
    {
        utility::initweapon( self.secondaryweapon );
        self.riotshieldmodel = function_f470dac2408978f1( self.secondaryweapon );
        self.riotshieldmodeltag = "tag_weapon_left";
        self.bhasriotshieldattached = 1;
        self.briotshieldinitialized = 1;
        self.deathfunction = &function_98c75316275021fd;
        self.isdeathfunctiondefined = 1;
        self.shoulddropriotshield = 1;
        self.var_9db3fecbc2f5e5f = "soldier_sat_ob";
        self.meleepoweroverride = 75;
        function_aa2f49b2a589cc9b();
        self enabletraversals( 0 );
        function_7f6d67613f263579();
        return anim.success;
    }
    
    return anim.failure;
}

// Namespace riotshield
// Params 0
// Checksum 0x105dd519, Offset: 0x614
// Size: 0xff, Type: bool
function function_98c75316275021fd()
{
    self aisetriotshieldweapon( nullweapon() );
    
    if ( self.bhasriotshieldattached )
    {
        if ( function_4d4f5575c4166352() )
        {
            self detach( self.riotshieldmodel, self.riotshieldmodeltag );
        }
        
        if ( death::shoulddropriotshield() && !isexplosivedamagemod( self.damagemod ) )
        {
            death::dropriotshield();
        }
        
        self.bhasriotshieldattached = undefined;
    }
    
    foreach ( throwingweapon in self.var_e45e4b29480e5368 )
    {
        if ( isdefined( throwingweapon.deletefunction ) )
        {
            throwingweapon [[ throwingweapon.deletefunction ]]();
        }
    }
    
    self.var_e45e4b29480e5368 = [];
    return false;
}

// Namespace riotshield
// Params 0, eflags: 0x4
// Checksum 0x50ba9ba, Offset: 0x71c
// Size: 0x4f, Type: bool
function private function_4d4f5575c4166352()
{
    count = self getattachsize();
    
    for ( i = 0; i < count ; i++ )
    {
        attachmentname = self getattachmodelname( i );
        
        if ( attachmentname == self.riotshieldmodel )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace riotshield
// Params 1
// Checksum 0xf372a15c, Offset: 0x774
// Size: 0x155
function function_72c13095d35f81c6( taskid )
{
    if ( self.briotshieldinitialized )
    {
        return anim.success;
    }
    
    assert( self.secondaryweapon.basename != "<dev string:x24>", "<dev string:x78>" );
    self setcanusecover( 0, "entity" );
    self.script_goalheight = 80;
    
    if ( self.secondaryweapon.basename != "none" )
    {
        utility::initweapon( self.secondaryweapon );
        self.riotshieldmodel = getweaponmodel( self.secondaryweapon );
        self.riotshieldmodeltag = "tag_weapon_left";
        self attach( self.riotshieldmodel, self.riotshieldmodeltag );
        function_3c74a6db3a1770f0( self.riotshieldmodel );
        self.bhasriotshieldattached = 1;
        self.briotshieldinitialized = 1;
        self.deathfunction = &function_3662e8b753e42227;
        self.isdeathfunctiondefined = 1;
        
        if ( level.riotshielddamagefeedback || self.riotshielddamagefeedback )
        {
            childthread utility::function_182a53e9f537187f();
        }
        
        function_aa2f49b2a589cc9b();
        utility::delaythread( 0.05, &function_7f6d67613f263579 );
        return anim.success;
    }
    
    return anim.failure;
}

// Namespace riotshield
// Params 0
// Checksum 0xc06c3f21, Offset: 0x8d1
// Size: 0xb2
function riotshield_stow_monitor()
{
    self endon( #"death" );
    wait 0.5;
    
    if ( !self.stealth_enabled )
    {
        return;
    }
    
    if ( utility::issp() )
    {
        function_3656eba8a037b7b2();
    }
    else
    {
        function_363ce7a8a01b85dc();
    }
    
    while ( true )
    {
        msg = utility::waittill_any_return( "stealth_combat", "stealth_combat_exited" );
        
        if ( msg == "stealth_combat_exited" && self.shieldstowed )
        {
            continue;
        }
        
        if ( msg == "stealth_combat" && !self.shieldstowed )
        {
            continue;
        }
        
        if ( utility::issp() )
        {
            function_3656eba8a037b7b2();
        }
        else
        {
            function_363ce7a8a01b85dc();
        }
        
        waitframe();
    }
}

// Namespace riotshield
// Params 0
// Checksum 0xd17ad7f1, Offset: 0x98b
// Size: 0xb3
function function_3656eba8a037b7b2()
{
    detachtag = self.shieldstowed ? "tag_stowed_back" : "tag_weapon_left";
    self.shieldstowed = !self.shieldstowed;
    attachtag = self.shieldstowed ? "tag_stowed_back" : "tag_weapon_left";
    self detach( self.riotshieldmodel, detachtag );
    self attach( self.riotshieldmodel, attachtag );
    function_3c74a6db3a1770f0( self.riotshieldmodel );
    self.riotshieldmodeltag = attachtag;
    waitframe();
    self aisetriotshieldweapon( self.secondaryweapon, self.shieldstowed );
}

// Namespace riotshield
// Params 0
// Checksum 0x82e75159, Offset: 0xa46
// Size: 0x80
function function_363ce7a8a01b85dc()
{
    detachtag = self.shieldstowed ? "tag_stowed_back" : "tag_weapon_left";
    self.shieldstowed = !self.shieldstowed;
    attachtag = self.shieldstowed ? "tag_stowed_back" : "tag_weapon_left";
    self.riotshieldmodeltag = attachtag;
    self aisetriotshieldweapon( self.secondaryweapon, self.shieldstowed );
}

// Namespace riotshield
// Params 1
// Checksum 0xb937e3b6, Offset: 0xace
// Size: 0xf5
function function_3c74a6db3a1770f0( model )
{
    if ( !getdvarint( @"hash_5fa7d6d6ec9dcdee" ) )
    {
        parts = [ "tag_lgt_dmg", "tag_lgt_dmg_mid", "tag_lgt_dmg_bottom", "tag_med_dmg", "tag_med_dmg_mid", "tag_med_dmg_bottom", "tag_hvy_dmg", "tag_hvy_dmg_mid", "tag_hvy_dmg_bottom" ];
        
        foreach ( partname in parts )
        {
            if ( modelhastag( model, partname ) )
            {
                self hidepart( partname, model );
            }
        }
    }
}

// Namespace riotshield
// Params 0
// Checksum 0xabedf90f, Offset: 0xbcb
// Size: 0x11
function function_7f6d67613f263579()
{
    self aisetriotshieldweapon( self.secondaryweapon );
}

// Namespace riotshield
// Params 0
// Checksum 0x62633f4e, Offset: 0xbe4
// Size: 0xc
function function_46457626376d14f8()
{
    self aisetriotshieldweapon( nullweapon() );
}

// Namespace riotshield
// Params 0
// Checksum 0xbe6a1002, Offset: 0xbf8
// Size: 0x74, Type: bool
function function_3662e8b753e42227()
{
    if ( !self.dropweapon || self.bdroppingshield || self.script_noloot || self.script_nodrop )
    {
        return false;
    }
    
    droppedweapon = function_e526b1995b2fb46e();
    
    if ( isdefined( droppedweapon ) && isdefined( droppedweapon.model ) )
    {
        droppedweapon function_3c74a6db3a1770f0( droppedweapon.model );
    }
    
    return false;
}

// Namespace riotshield
// Params 0, eflags: 0x4
// Checksum 0x4c03ca56, Offset: 0xc75
// Size: 0x160
function private function_e526b1995b2fb46e()
{
    tagorigin = self gettagorigin( self.riotshieldmodeltag );
    
    if ( !self.var_6357802f7e466fae )
    {
        shieldweapon = self.secondaryweapon;
        
        if ( isnullweapon( shieldweapon ) )
        {
            shieldweapon = self.primaryweapon;
        }
        
        weap_name = "weapon_" + getcompleteweaponname( shieldweapon );
        droppedweapon = spawn( weap_name, tagorigin );
    }
    else
    {
        droppedweapon = spawn( "script_model", tagorigin );
        droppedweapon setmodel( self.riotshieldmodel );
    }
    
    droppedweapon.angles = self gettagangles( self.riotshieldmodeltag );
    var_9e726b6baabc2349 = self.var_260179037954d261 ?? ( 0, 0, 15 );
    forward = vectornormalize2( droppedweapon.origin - self.origin );
    force = ( forward[ 0 ] * var_9e726b6baabc2349[ 0 ], forward[ 1 ] * var_9e726b6baabc2349[ 1 ], var_9e726b6baabc2349[ 2 ] );
    
    if ( !self.var_6357802f7e466fae )
    {
        droppedweapon physicslaunchserveritem( droppedweapon.origin, force );
        thread utility::callsharedfunc( #"loot", #"dropWeaponPost", droppedweapon );
    }
    else
    {
        droppedweapon physicslaunchserver( tagorigin, force );
    }
    
    return droppedweapon;
}

// Namespace riotshield
// Params 0
// Checksum 0xeb192019, Offset: 0xdde
// Size: 0x1fb
function function_aa2f49b2a589cc9b()
{
    self allowedstances( "stand" );
    self.minpaindamage = 0;
    self.var_2ffc71aa3aa17005 = 0;
    self.aggressivemode = 1;
    self.disablereload = 1;
    self.meleechargedistvsplayer = 120;
    self.meleechargedist = 120;
    self.meleestopattackdistsq = 14400;
    self.meleemaxzdiff = 500;
    self.var_11b2a6e302382a4b = 2500;
    self.meleetryhard = 0;
    self.meleeignorefinalzdiff = 0;
    self.meleeignoreplayerstance = 1;
    self.dontsyncmelee = 1;
    self.dontmeleeme = 1;
    self.disablebulletwhizbyreaction = 1;
    self setcanusecover( 0, "entity" );
    self.disablerunngun = 1;
    self.disabledodge = 1;
    self.pathenemyfightdist = 0;
    self.maxfaceenemydist = 1200;
    self.var_b09276edf0475d09 = 0;
    self.allowlongdeath = 0;
    self setlongdeathblocked( 1, "entity" );
    self.ignoresuppression = 0;
    self.var_5f72f15650225b82 = 0.03;
    self.suppressiondecrement = 0.005;
    self.suppressionthreshold = 0.5;
    self.shieldstowed = 0;
    self.var_c21cefdb0d231840 = 3000;
    self.var_1db1f2ef9c7f9036 = 512;
    self.var_aaf12cbad4692c1b = 360;
    self.var_47627bac27bc94ff = 360;
    self.var_e5d5b423587e876 = 128;
    self.var_d4b1e70a1931ada9 = 25;
    self.goalheight = 80;
    self.var_6b23d3ee096a27b4 = 0;
    self.cautiousnavigation = 0;
    self.var_1f8b3b00067dec6c = 40;
    self.var_c6f797c2ad63b8d6 = 1000;
    self.var_c71a89c2ad89e1c4 = 2000;
    self.var_26a62248c00aefec = 1000;
    self.var_26823048bfe293fe = 2000;
    self.var_aac9c74cd0f5eba8 = 1;
    self enabletraversals( 1 );
}

// Namespace riotshield
// Params 0
// Checksum 0x2ec2075e, Offset: 0xfe1
// Size: 0xb0
function function_6e32436b6aca936a()
{
    self allowedstances( "stand", "crouch", "prone" );
    self.minpaindamage = 0;
    self.aggressivemode = 0;
    self.ignoresuppression = 0;
    self.disablereload = 0;
    self.meleedamageoverride = undefined;
    self.meleemaxzdiff = 36;
    self.meleeignoreplayerstance = 0;
    self.dontsyncmelee = undefined;
    self.dontmeleeme = 0;
    self.disablebulletwhizbyreaction = 0;
    self.combatmode = "cover";
    self.disablerunngun = 0;
    self.disabledodge = 0;
    self.pathenemyfightdist = 0;
    self enabletraversals( 1 );
}

// Namespace riotshield
// Params 0
// Checksum 0xa76017ce, Offset: 0x1099
// Size: 0x20
function function_9d77cafed83b2301()
{
    self.bhasthermitestucktoshield = 0;
    self.thermitestucktoshield = undefined;
    self.thermitestuckpains = undefined;
}

// Namespace riotshield
// Params 0
// Checksum 0xcea47cd0, Offset: 0x10c1
// Size: 0x4d
function function_3ebb653d71583255()
{
    if ( self.bhasriotshieldattached )
    {
        if ( utility::issp() )
        {
            self detach( self.riotshieldmodel, self.riotshieldmodeltag );
        }
        
        self.riotshieldmodel = undefined;
        self.riotshieldmodeltag = undefined;
        self.bhasriotshieldattached = undefined;
    }
}

// Namespace riotshield
// Params 1
// Checksum 0xf6fb2d7e, Offset: 0x1116
// Size: 0x29
function function_7cee7016601aefb9( taskid )
{
    if ( !self.bdroppingshield )
    {
        thread function_b9ef8f914edf945a();
    }
    
    return anim.success;
}

// Namespace riotshield
// Params 1
// Checksum 0xce26143b, Offset: 0x1148
// Size: 0x7e
function function_5b5148f237a69ae( taskid )
{
    if ( self.bdroppingshield )
    {
        assert( isdefined( self.weapon ) && weaponclass( self.weapon ) != "<dev string:xc8>" );
        self._blackboard.weaponrequest = "mg";
        self setbtgoalpos( 4, self.origin );
        return anim.running;
    }
    
    return anim.failure;
}

// Namespace riotshield
// Params 2
// Checksum 0xb029b631, Offset: 0x11cf
// Size: 0x2b8
function function_b9ef8f914edf945a( var_54dac5ebdab3983, newarchetype = "soldier" )
{
    self endon( #"death" );
    self.bdroppingshield = 1;
    
    if ( !var_54dac5ebdab3983 )
    {
        waitframe();
        ctimeout = 10000;
        var_4e2fb3bbaa92cf43 = gettime();
        
        while ( !self asmeventfired( self.asmname, "drop_shield" ) && var_4e2fb3bbaa92cf43 + ctimeout > gettime() )
        {
            waitframe();
        }
        
        var_bab0872a332490f1 = var_4e2fb3bbaa92cf43 + ctimeout <= gettime();
        
        if ( var_bab0872a332490f1 )
        {
            function_9d77cafed83b2301();
            self._blackboard.weaponrequest = "none";
            self.bdroppingshield = 0;
            self clearbtgoal( 4 );
            return;
        }
    }
    
    if ( issubstr( self.animsetname, "core" ) )
    {
        self setbasearchetype( "soldier/core_soldier" );
        
        if ( newarchetype == "soldier" )
        {
            self setoverridearchetype( "default", "soldier/core_soldier" );
        }
        else
        {
            self setoverridearchetype( "default", newarchetype );
        }
    }
    else if ( getprojectname() == "SAT" )
    {
        self setbasearchetype( "sat_soldier" );
        self setoverridearchetype( "default", "sat_soldier" );
    }
    else
    {
        self setbasearchetype( "soldier" );
        self setoverridearchetype( "default", newarchetype );
    }
    
    if ( !level.var_76b3c0b7aff5a045 )
    {
        droppedweapon = function_e526b1995b2fb46e();
        
        if ( !self.var_177e9abb267ab0b9 )
        {
            droppedweapon thread deleteaftertime( 10 );
        }
    }
    
    if ( isdefined( self.thermitestucktoshield ) )
    {
        foreach ( thermite in self.thermitestucktoshield )
        {
            if ( isdefined( thermite ) )
            {
                thermite delete();
            }
        }
    }
    
    self.allowlongdeath = 1;
    self notify( #"shield_dropped" );
    function_46457626376d14f8();
    function_3ebb653d71583255();
    function_9d77cafed83b2301();
    self.bdroppingshield = 0;
    self clearbtgoal( 4 );
    function_6e32436b6aca936a();
    self._blackboard.weaponrequest = "none";
    
    if ( isdefined( self.var_9db3fecbc2f5e5f ) )
    {
        bt_util::bt_terminateandreplace( self.var_9db3fecbc2f5e5f );
    }
    
    weapclass = weaponclass( self.weapon );
    shared::updateweaponarchetype( weapclass );
}

// Namespace riotshield
// Params 1
// Checksum 0x6f0b5be2, Offset: 0x148f
// Size: 0x21
function deleteaftertime( t )
{
    self endon( #"death" );
    wait t;
    self delete();
}

