// scripts\anim\shared.gsc  (hash_3433ee6b63c7e243.gscc) (size: 23596 Bytes / 0x5c2c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb71bfd20 (3072064800)
// size ...... 23596 (0x5c2c)
// includes .. 10  (offset: 0x5588)
// strings ... 66  (offset: 0x55d8)
// dev strs .. 40  (offset: 0x5a18)
// exports ... 57  (offset: 0x3738)
// cseg ...... 0x4ca + 0x326e (0x3738)
// imports ... 174 (offset: 0x4020)
// animtree1 . 0   (offset: 0x5c1c)
// animtree2 . 1   (offset: 0x5c1c)
#using scripts\anim\animselector;
#using scripts\anim\combat_utility;
#using scripts\anim\utility;
#using scripts\anim\utility_common;
#using scripts\anim\weaponlist;
#using scripts\asm\asm_bb;
#using scripts\common\ai;
#using scripts\common\ai_lookat;
#using scripts\common\gameskill;
#using scripts\common\utility;

#namespace shared;

// Namespace shared
// Params 3
// Checksum 0xad4d586b, Offset: 0x4e8
// Size: 0x1ca
function placeweaponon( weapon, position, activeweapon )
{
    assert( isdefined( weapon ) );
    placeweaponobj = undefined;
    placeweaponname = undefined;
    
    if ( isweapon( weapon ) )
    {
        placeweaponobj = weapon;
        placeweaponname = getcompleteweaponname( weapon );
    }
    else
    {
        placeweaponobj = makeweaponfromstring( weapon );
        placeweaponname = weapon;
    }
    
    assert( utility::aihasweapon( placeweaponobj ) );
    self notify( #"weapon_position_change" );
    curposition = self.weaponinfo[ placeweaponname ].position;
    assert( curposition == "<dev string:x24>" || self.a.weaponpos[ curposition ] == placeweaponobj );
    
    if ( position != "none" && isdefined( self.a.weaponpos[ position ] ) && self.a.weaponpos[ position ] == placeweaponobj )
    {
        return;
    }
    
    detachallweaponmodels();
    
    if ( curposition != "none" )
    {
        detachweapon( placeweaponobj );
    }
    
    if ( position == "none" )
    {
        updateattachedweaponmodels();
        return;
    }
    
    if ( !isundefinedweapon( self.a.weaponpos[ position ] ) )
    {
        detachweapon( self.a.weaponpos[ position ] );
    }
    
    if ( !isdefined( activeweapon ) )
    {
        activeweapon = 1;
    }
    
    if ( activeweapon && ( position == "left" || position == "right" ) )
    {
        attachweapon( placeweaponobj, position );
        self.weapon = placeweaponobj;
    }
    else
    {
        attachweapon( placeweaponobj, position );
    }
    
    updateattachedweaponmodels();
}

// Namespace shared
// Params 1
// Checksum 0x638c5dcb, Offset: 0x6ba
// Size: 0x8c
function detachweapon( objweapon )
{
    assert( isweapon( objweapon ) );
    weaponname = getcompleteweaponname( objweapon );
    
    if ( isdefined( self.weaponinfo[ weaponname ].position ) )
    {
        self.a.weaponpos[ self.weaponinfo[ weaponname ].position ] = undefined;
        self.weaponinfo[ weaponname ].position = "none";
    }
}

// Namespace shared
// Params 2
// Checksum 0xf104943e, Offset: 0x74e
// Size: 0xa4
function attachweapon( objweapon, position )
{
    assert( isweapon( objweapon ) );
    weaponname = getcompleteweaponname( objweapon );
    self.weaponinfo[ weaponname ].position = position;
    self.a.weaponpos[ position ] = objweapon;
    
    if ( !isundefinedweapon( self.a.weaponposdropping[ position ] ) )
    {
        self notify( "end_weapon_drop_" + position );
        self.a.weaponposdropping[ position ] = undefined;
    }
}

// Namespace shared
// Params 1
// Checksum 0xccf5f2dc, Offset: 0x7fa
// Size: 0x9a
function getweaponforpos( position )
{
    if ( !isdefined( self.a ) )
    {
        return;
    }
    
    if ( !isdefined( self.a.weaponpos ) )
    {
        return;
    }
    
    weapon = self.a.weaponpos[ position ];
    
    if ( isundefinedweapon( weapon ) )
    {
        return self.a.weaponposdropping[ position ];
    }
    
    assert( isundefinedweapon( self.a.weaponposdropping[ position ] ) );
    return weapon;
}

// Namespace shared
// Params 0
// Checksum 0xf4ee8793, Offset: 0x89d
// Size: 0x11f
function detachallweaponmodels()
{
    positions = [ "right", "left", "chest", "back", "thigh", "inhand" ];
    self laseroff();
    
    foreach ( position in positions )
    {
        weapon = getweaponforpos( position );
        
        if ( isundefinedweapon( weapon ) )
        {
            continue;
        }
        
        if ( weapontype( weapon ) == "riotshield" && isdefined( self.shieldmodelvariant ) )
        {
            if ( self.shieldbroken )
            {
                playfxontag( utility::getfx( "riot_shield_dmg" ), self, "TAG_BRASS" );
                self.shieldbroken = undefined;
            }
        }
    }
    
    self updateentitywithweapons();
}

// Namespace shared
// Params 0
// Checksum 0x9247b6e, Offset: 0x9c4
// Size: 0x1fb
function updateattachedweaponmodels()
{
    weapons = [];
    tags = [];
    positions = [ "right", "left", "chest", "back", "thigh", "inhand" ];
    
    if ( !isdefined( self.a ) )
    {
        return;
    }
    
    if ( !isdefined( self.a.weaponpos ) )
    {
        return;
    }
    
    foreach ( position in positions )
    {
        iweapon = weapons.size;
        weapon = getweaponforpos( position );
        
        if ( !isundefinedweapon( weapon ) && !isnullweapon( weapon ) )
        {
            weaponname = getcompleteweaponname( weapon );
            
            if ( self.weaponinfo[ weaponname ].useclip && !self.weaponinfo[ weaponname ].hasclip )
            {
                assert( isdefined( weapon.magazine ) );
                weapon = weapon withoutattachment( weapon.magazine );
            }
        }
        
        if ( isdefined( weapon ) )
        {
            tagforpos = gettagforpos( position );
            
            if ( self tagexists( tagforpos ) )
            {
                weapons[ iweapon ] = weapon;
                tags[ tags.size ] = tagforpos;
            }
        }
    }
    
    /#
        if ( weapons.size > 4 )
        {
            assertmsg( "<dev string:x29>" );
        }
    #/
    
    self updateentitywithweapons( weapons[ 0 ], tags[ 0 ], weapons[ 1 ], tags[ 1 ], weapons[ 2 ], tags[ 2 ], weapons[ 3 ], tags[ 3 ] );
    self updatelaserstatus();
}

// Namespace shared
// Params 1
// Checksum 0x8eaf1f7b, Offset: 0xbc7
// Size: 0xb3
function gettagforpos( position )
{
    switch ( position )
    {
        case #"hash_fc2fdaa21f480e36":
            return "tag_stowed_chest";
        case #"hash_5163a22eb8c03302":
            return "tag_stowed_back";
        case #"hash_c9b3133a17a3b2d0":
            return "tag_weapon_left";
        case #"hash_96815ce4f2a3dbc5":
            return "tag_weapon_right";
        case #"hash_cc8437548a4a4480":
            return "tag_accessory_right";
        case #"hash_c274ab81bf2a0f8f":
            return "tag_stowed_thigh";
        case #"hash_40f6fb4e52241d83":
            return "tag_inhand";
        default:
            assertmsg( "<dev string:x54>" + position );
            break;
    }
}

// Namespace shared
// Params 1
// Checksum 0x2baa0af1, Offset: 0xc82
// Size: 0x141
function dropaiweaponinternal( weapon )
{
    if ( function_9b735f27e5cc1ed8() )
    {
        if ( weapon hasattachment( self.flashlight_attachment ) )
        {
            detachweapon( weapon );
            weapon = weapon withoutattachment( self.flashlight_attachment );
            forceuseweapon( weapon, self.flashlight_slot );
        }
    }
    
    weaponname = getcompleteweaponname( weapon );
    position = self.weaponinfo[ weaponname ].position;
    
    if ( self.dropweapon && position != "none" )
    {
        thread dropweaponwrapper( weapon, position );
    }
    
    detachweapon( weapon );
    
    if ( weapon == self.weapon )
    {
        self.weapon = nullweapon();
    }
    
    if ( weapon == self.primaryweapon )
    {
        self.primaryweapon = nullweapon();
    }
    
    if ( weapon == self.secondaryweapon )
    {
        self.secondaryweapon = nullweapon();
    }
    
    if ( weapon == self.sidearm )
    {
        if ( !isnullweapon( self.primaryweapon ) )
        {
            dropaiweaponinternal( self.primaryweapon );
        }
        
        self.sidearm = nullweapon();
    }
}

// Namespace shared
// Params 1
// Checksum 0x2c06c137, Offset: 0xdcb
// Size: 0xfb
function dropaiweapon( weapon = self.weapon )
{
    assert( isweapon( weapon ) );
    
    if ( isnullweapon( weapon ) )
    {
        return;
    }
    
    if ( isdefined( self.nodrop ) )
    {
        return;
    }
    
    detachallweaponmodels();
    dropaiweaponinternal( weapon );
    
    if ( isnullweapon( self.primaryweapon ) )
    {
        if ( !isnullweapon( self.weapon ) )
        {
            self.primaryweapon = self.weapon;
        }
        else if ( !isnullweapon( self.secondaryweapon ) )
        {
            self.primaryweapon = self.secondaryweapon;
        }
        else if ( !isnullweapon( self.sidearm ) )
        {
            self.primaryweapon = self.sidearm;
        }
        
        if ( self.primaryweapon == self.secondaryweapon )
        {
            self.secondaryweapon = nullweapon();
        }
    }
    
    updateattachedweaponmodels();
}

// Namespace shared
// Params 0
// Checksum 0xd4782a3a, Offset: 0xece
// Size: 0x1b1
function dropallaiweapons()
{
    if ( isdefined( self.nodrop ) )
    {
        return "none";
    }
    
    if ( !( isdefined( self.a ) && isdefined( self.a.weaponpos ) ) )
    {
        return;
    }
    
    positions = [ "left", "right", "chest", "back", "thigh", "inhand" ];
    detachallweaponmodels();
    
    foreach ( position in positions )
    {
        weapon = self.a.weaponpos[ position ];
        
        if ( isundefinedweapon( weapon ) )
        {
            continue;
        }
        
        weaponname = getcompleteweaponname( weapon );
        self.weaponinfo[ weaponname ].position = "none";
        self.a.weaponpos[ position ] = undefined;
        
        if ( function_9b735f27e5cc1ed8() )
        {
            if ( weapon hasattachment( self.flashlight_attachment ) )
            {
                weapon = weapon withoutattachment( self.flashlight_attachment );
            }
        }
        
        if ( self.dropweapon )
        {
            thread dropweaponwrapper( weapon, position );
            waitframe();
        }
    }
    
    self.weapon = nullweapon();
    updateattachedweaponmodels();
}

// Namespace shared
// Params 2
// Checksum 0x7e2497c4, Offset: 0x1087
// Size: 0x464
function dropweaponwrapper( weapon, position )
{
    if ( self isragdoll() && !self.forceweapondrop )
    {
        return "none";
    }
    
    assert( isundefinedweapon( self.a.weaponposdropping[ position ] ) );
    self.a.weaponposdropping[ position ] = weapon;
    actualdroppedweapon = weapon;
    baseweaponname = weapon.basename;
    
    if ( issubstr( tolower( baseweaponname ), "_ai" ) )
    {
        baseweaponname = getsubstr( baseweaponname, 0, baseweaponname.size - 3 );
        attachments = weapon.attachments;
        
        if ( self.var_c4f0a8627b548c6d )
        {
            attachments = getweapondefaultattachments( baseweaponname );
        }
        
        actualdroppedweapon = makeweapon( baseweaponname, attachments );
        assert( actualdroppedweapon.basename != "<dev string:x24>", "<dev string:x78>" + weapon.basename + "<dev string:x94>" );
    }
    
    thread dropped_weapon_thread();
    
    if ( isagent( self ) )
    {
        if ( isdefined( level.dropped_weapon_func ) )
        {
            self thread [[ level.dropped_weapon_func ]]( actualdroppedweapon, position );
        }
        else
        {
            self dropweaponnovelocity( actualdroppedweapon, position );
        }
        
        if ( isalive( self ) )
        {
            waitframe();
        }
    }
    else if ( canaiflingweapon( self ) )
    {
        if ( position == "back" || position == "thigh" )
        {
            tagname = "tag_stowed_" + position;
        }
        else
        {
            tagname = "tag_weapon_" + position;
        }
        
        if ( !utility::hastag( self.model, tagname ) )
        {
            self dropweapon( actualdroppedweapon, position, 0 );
            self endon( "end_weapon_drop_" + position );
            waitframe();
            return;
        }
        
        previoustagorigin = self gettagorigin( tagname );
        self endon( "end_weapon_drop_" + position );
        waitframe();
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        tagorigin = self gettagorigin( tagname );
        tagangles = self gettagangles( tagname );
        weaponcompletename = getcompleteweaponname( actualdroppedweapon );
        droppedweaponentity = spawn( "weapon_" + weaponcompletename, tagorigin );
        droppedweaponentity.angles = tagangles;
        tagdelta = tagorigin - previoustagorigin;
        normalizedtagdelta = vectornormalize( tagdelta );
        tagvelocityscalar = 20;
        maximumtagvelocity = 50;
        tagvelocitymagnitude = min( length( tagdelta ) * tagvelocityscalar, maximumtagvelocity );
        tagvelocity = normalizedtagdelta * tagvelocitymagnitude;
        upwardvelocity = ( 0, 0, 950 );
        launchvelocity = self.dropweaponvelocity ?? tagvelocity + upwardvelocity;
        
        if ( self.dropweaponpos )
        {
            tagorigin = self.dropweaponpos.origin;
            tagangles = self.dropweaponpos.angles ?? ( 0, 0, 0 );
            launchvelocity = self.dropweaponpos.velocity ?? launchvelocity;
            
            if ( self.dropweaponpos.local )
            {
                tagorigin = coordtransform( tagorigin, self.origin, self.angles );
                tagangles = combineangles( self.angles, tagangles );
                
                if ( isdefined( self.dropweaponpos.velocity ) )
                {
                    launchvelocity = rotatevector( launchvelocity, self.angles );
                }
            }
        }
        
        droppedweaponentity physicslaunchserveritem( tagorigin, launchvelocity );
        
        if ( weaponclass( actualdroppedweapon ) == "pistol" )
        {
            reductionamount = 0.2;
            bodyid = droppedweaponentity physics_getbodyid( 0 );
            bodyangvel = physics_getbodyangvel( bodyid ) * reductionamount;
            physics_setbodyangvel( bodyid, bodyangvel[ 0 ], bodyangvel[ 1 ], bodyangvel[ 2 ] );
        }
        
        level notify( #"weapon_dropped_ai", droppedweaponentity );
        self notify( #"weapon_dropped", droppedweaponentity );
    }
    else
    {
        self dropweapon( actualdroppedweapon, position, 0 );
        self endon( "end_weapon_drop_" + position );
        waitframe();
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isagent( self ) && !isalive( self ) )
    {
        return;
    }
    
    detachallweaponmodels();
    self.a.weaponposdropping[ position ] = undefined;
    updateattachedweaponmodels();
}

// Namespace shared
// Params 0
// Checksum 0x387f97ab, Offset: 0x14f3
// Size: 0x13, Type: bool
function function_9b735f27e5cc1ed8()
{
    if ( isdefined( self.flashlight_attachment ) )
    {
        return true;
    }
    
    return false;
}

// Namespace shared
// Params 1
// Checksum 0xc395a670, Offset: 0x150f
// Size: 0x56, Type: bool
function canaiflingweapon( ai )
{
    if ( !utility::issp() )
    {
        return false;
    }
    
    if ( !isdefined( ai.lastattacker ) )
    {
        return false;
    }
    
    if ( !isplayer( ai.lastattacker ) )
    {
        return false;
    }
    
    if ( isexplosivedamagemod( ai.damagemod ) )
    {
        return true;
    }
    
    return true;
}

// Namespace shared
// Params 0
// Checksum 0xf61c7234, Offset: 0x156e
// Size: 0x4a
function testing_notifies()
{
    if ( isdefined( self.var_74250d8d54a34adf ) )
    {
        return;
    }
    
    self.var_74250d8d54a34adf = 0;
    thread notify_thread();
    wait 0.3;
    
    /#
        iprintlnbold( "<dev string:xc9>" + self.var_74250d8d54a34adf );
    #/
    
    self notify( #"stop_notify_thread" );
}

// Namespace shared
// Params 0
// Checksum 0xeecdc3b2, Offset: 0x15c0
// Size: 0x39
function notify_thread()
{
    self endon( #"stop_notify_thread" );
    
    while ( true )
    {
        self waittill( #"weapon_dropped", droppedweapon );
        self.var_74250d8d54a34adf++;
    }
}

// Namespace shared
// Params 0
// Checksum 0xa40eff1a, Offset: 0x1601
// Size: 0x42
function dropped_weapon_thread()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"weapon_dropped", droppedweapon );
        
        if ( !droppedweapon )
        {
            continue;
        }
        
        droppedweapon thread droppedweapon_init( self );
    }
}

// Namespace shared
// Params 1
// Checksum 0x5fef84a8, Offset: 0x164b
// Size: 0xca
function droppedweapon_init( guy )
{
    self endon( #"death" );
    self.dontcleanup = guy.var_f901a9385978db80;
    weaponobj = self function_b87bf08bbabcdab();
    
    if ( isvaliddroppedweapon( weaponobj ) )
    {
        self physics_registerforcollisioncallback();
        thread weapondrop_physics_callback_monitor( weaponobj );
        setscriptammo( guy );
    }
    
    level utility::callsharedfunc( #"loot", #"dropweapon", self );
    level thread utility::callsharedfunc( #"loot", #"dropWeaponPost", self );
    basename = getweaponbasename( self );
    
    if ( guy.weaponlootitem[ basename ] )
    {
        self function_e44c4b30d4be97f6( guy.weaponlootitem[ basename ] );
    }
}

// Namespace shared
// Params 1
// Checksum 0xbf4ed7c2, Offset: 0x171d
// Size: 0x1e, Type: bool
function isvaliddroppedweapon( weapon )
{
    if ( weapon.ismelee )
    {
        return false;
    }
    
    return true;
}

// Namespace shared
// Params 1
// Checksum 0x46a22e65, Offset: 0x1744
// Size: 0xf3
function weapondrop_physics_callback_monitor( droppedent )
{
    self endon( #"death" );
    self endon( #"timeout" );
    thread weapondrop_physics_timeout( 2 );
    self waittill( #"collision", body0, body1, flag0, flag1, position, normal, impulse, ent );
    surface = physics_getsurfacetypefromflags( flag1 );
    surfacetype = getsubstr( surface[ "name" ], 9 );
    
    if ( surfacetype == "user_terrain1" )
    {
        surfacetype = "user_terrain_1";
    }
    
    if ( surfacetype == "unused0" )
    {
        surfacetype = "unused_0";
    }
    
    if ( isdefined( droppedent.classname ) && isdefined( self ) )
    {
        self playweapondropsound( surfacetype );
    }
}

// Namespace shared
// Params 1
// Checksum 0x4c960791, Offset: 0x183f
// Size: 0x1b
function weapondrop_physics_timeout( time )
{
    wait time;
    self notify( #"timeout" );
}

// Namespace shared
// Params 0
// Checksum 0x55f44339, Offset: 0x1862
// Size: 0x43
function getaimyawtoshootentorpos()
{
    if ( !isdefined( self.shootent ) )
    {
        if ( !isdefined( self.shootpos ) )
        {
            return 0;
        }
        
        return utility::getaimyawtopoint( self.shootpos );
    }
    
    return utility::getaimyawtopoint( self.shootent getshootatpos() );
}

// Namespace shared
// Params 0
// Checksum 0xe8994217, Offset: 0x18ae
// Size: 0x6b
function getaimpitchtoshootentorpos()
{
    pitch = getpitchtoshootentorpos();
    
    if ( self.script == "cover_crouch" && isdefined( self.a.covermode ) && self.a.covermode == "lean" )
    {
        pitch -= anim.covercrouchleanpitch;
    }
    
    return pitch;
}

// Namespace shared
// Params 0
// Checksum 0x9633761c, Offset: 0x1922
// Size: 0x43
function getpitchtoshootentorpos()
{
    if ( !isdefined( self.shootent ) )
    {
        if ( !isdefined( self.shootpos ) )
        {
            return 0;
        }
        
        return combat_utility::getpitchtoshootspot( self.shootpos );
    }
    
    return combat_utility::getpitchtoshootspot( self.shootent getshootatpos() );
}

// Namespace shared
// Params 1
// Checksum 0x5e593e86, Offset: 0x196e
// Size: 0x21
function ramboaim( baseyaw )
{
    self endon( #"killanimscript" );
    ramboaiminternal( baseyaw );
}

// Namespace shared
// Params 1
// Checksum 0xc32d315f, Offset: 0x1997
// Size: 0xc
function ramboaiminternal( baseyaw )
{
    
}

// Namespace shared
// Params 0
// Checksum 0x28290968, Offset: 0x19ab
// Size: 0xe3
function decidenumshotsforburst()
{
    numshots = 0;
    fixedburstcount = weaponburstcount( self.weapon );
    
    if ( fixedburstcount )
    {
        numshots = fixedburstcount;
    }
    else if ( weaponlist::usingsemiautoweapon() )
    {
        numshots = anim.semifirenumshots[ randomint( anim.semifirenumshots.size ) ];
    }
    else if ( self.fastburst )
    {
        numshots = anim.fastburstfirenumshots[ randomint( anim.fastburstfirenumshots.size ) ];
    }
    else
    {
        numshots = anim.burstfirenumshots[ randomint( anim.burstfirenumshots.size ) ];
    }
    
    if ( numshots <= self.bulletsinclip )
    {
        return numshots;
    }
    
    assert( self.bulletsinclip >= 0, self.bulletsinclip );
    
    if ( self.bulletsinclip <= 0 )
    {
        return 1;
    }
    
    return self.bulletsinclip;
}

// Namespace shared
// Params 0
// Checksum 0x80f74ccf, Offset: 0x1a97
// Size: 0x73
function decidenumshotsforfull()
{
    numshots = self.bulletsinclip;
    
    if ( weaponclass( self.weapon ) == "mg" )
    {
        choice = randomfloat( 10 );
        
        if ( choice < 3 )
        {
            numshots = randomintrange( 2, 6 );
        }
        else if ( choice < 8 )
        {
            numshots = randomintrange( 6, 12 );
        }
        else
        {
            numshots = randomintrange( 12, 20 );
        }
    }
    
    return numshots;
}

// Namespace shared
// Params 1
// Checksum 0x6b7d8ba6, Offset: 0x1b13
// Size: 0x2b
function hideweaponmagattachment( weaponname )
{
    self.weaponinfo[ weaponname ].hasclip = 0;
    updateattachedweaponmodels();
}

// Namespace shared
// Params 1
// Checksum 0x6b7d8ba7, Offset: 0x1b46
// Size: 0x2c
function showweaponmagattachment( weaponname )
{
    self.weaponinfo[ weaponname ].hasclip = 1;
    updateattachedweaponmodels();
}

// Namespace shared
// Params 1
// Checksum 0x84cd17c3, Offset: 0x1b7a
// Size: 0x328
function handledropclip( flagname )
{
    self endon( #"abort_reload" );
    self endon( flagname + "_finished" );
    
    /#
        self.var_ff4c8b05d3ce4627 = gettime();
    #/
    
    clipweapon = self.weapon;
    clipweaponname = getcompleteweaponname( clipweapon );
    clipmodel = undefined;
    
    if ( self.weaponinfo[ clipweaponname ].useclip )
    {
        clipmodel = getweaponclipmodel( self.weapon );
    }
    
    /#
        if ( isdefined( clipmodel ) )
        {
            thread function_4c55a5c08debdb0c( 4, flagname, clipmodel );
        }
    #/
    
    if ( self.weaponinfo[ clipweaponname ].hasclip )
    {
        if ( utility_common::isusingsidearm() )
        {
            self playsound( "weap_reload_pistol_clipout_npc" );
        }
        else
        {
            self playsound( "weap_reload_smg_clipout_npc" );
        }
        
        if ( isdefined( clipmodel ) )
        {
            hideweaponmagattachment( clipweaponname );
            thread dropclipmodel( clipmodel, "tag_clip" );
        }
    }
    
    bdone = 0;
    
    while ( !bdone )
    {
        self waittill( flagname, notes );
        
        if ( !isarray( notes ) )
        {
            notes = [ notes ];
        }
        
        foreach ( notetrack in notes )
        {
            switch ( notetrack )
            {
                case #"hash_5b5aa4b849bd2c6b":
                    if ( isdefined( clipmodel ) )
                    {
                        self attach( clipmodel, "tag_accessory_left" );
                    }
                    
                    break;
                case #"hash_ae1cecd9e4889cf4":
                    if ( isdefined( clipmodel ) )
                    {
                        self attach( clipmodel, "tag_accessory_right" );
                    }
                    
                    break;
                case #"hash_cd781db409868556":
                    if ( isdefined( clipmodel ) )
                    {
                        self detach( clipmodel, "tag_accessory_right" );
                    }
                    
                    break;
                case #"hash_d4a17c4550fa75c2":
                    if ( isdefined( clipmodel ) )
                    {
                        self detach( clipmodel, "tag_accessory_right" );
                        
                        if ( clipweapon == self.weapon )
                        {
                            showweaponmagattachment( clipweaponname );
                        }
                        else
                        {
                            self.weaponinfo[ getcompleteweaponname( self.weapon ) ].hasclip = 1;
                            self.weaponinfo[ clipweaponname ].hasclip = 1;
                        }
                        
                        self notify( #"clip_detached" );
                    }
                    
                    weaponlist::refillclip();
                    bdone = 1;
                    break;
                case #"hash_5d086fcae9cf9da1":
                    if ( isdefined( clipmodel ) )
                    {
                        self detach( clipmodel, "tag_accessory_left" );
                        
                        if ( clipweapon == self.weapon )
                        {
                            showweaponmagattachment( clipweaponname );
                        }
                        else
                        {
                            self.weaponinfo[ getcompleteweaponname( self.weapon ) ].hasclip = 1;
                            self.weaponinfo[ clipweaponname ].hasclip = 1;
                        }
                        
                        self notify( #"clip_detached" );
                    }
                    
                    weaponlist::refillclip();
                    bdone = 1;
                    break;
            }
        }
    }
}

// Namespace shared
// Params 2
// Checksum 0x489f9ce9, Offset: 0x1eaa
// Size: 0x15
function dropclipmodel( clipmodel, tagname )
{
    
}

/#

    // Namespace shared
    // Params 3
    // Checksum 0x1047c2c2, Offset: 0x1ec7
    // Size: 0x12f, Type: dev
    function function_4c55a5c08debdb0c( waittime, statename, clipmodel )
    {
        self endon( #"death" );
        self endon( #"abort_reload" );
        self endon( #"clip_detached" );
        wait waittime;
        msg1 = "<dev string:xd1>" + self getentitynumber() + "<dev string:xd5>" + waittime + "<dev string:x10b>";
        msg2 = "<dev string:x115>" + statename + "<dev string:x12a>" + clipmodel + "<dev string:x13a>" + self.weapon.basename + "<dev string:x14b>";
        msg3 = "<dev string:x14d>" + ( self function_51631ea7d587647d() ? "<dev string:x157>" : "<dev string:x15b>" ) + "<dev string:x15e>" + self asmgetcurrentstate( self.asmname );
        msg4 = "<dev string:x175>";
        msg5 = "<dev string:x1c3>";
        assertmsg( msg1 + "<dev string:x217>" + msg2 + "<dev string:x217>" + msg3 + "<dev string:x217>" + msg4 + "<dev string:x217>" + msg5 );
    }

#/

// Namespace shared
// Params 2
// Checksum 0x919922e, Offset: 0x1ffe
// Size: 0x150
function movetonodeovertime( node, time )
{
    self endon( #"killanimscript" );
    nodeorigin = node.origin;
    distsq = distancesquared( self.origin, nodeorigin );
    
    if ( distsq < 1 )
    {
        self safeteleport( nodeorigin );
        return;
    }
    
    if ( distsq > 256 && !self maymovetopoint( nodeorigin, !utility::actor_is3d() ) )
    {
        println( "<dev string:x219>" + nodeorigin + "<dev string:x246>" );
        return;
    }
    
    self.keepclaimednodeifvalid = 1;
    startdist = distance( self.origin, nodeorigin );
    frames = int( time * 20 );
    
    for ( i = 0; i < frames ; i++ )
    {
        nodeorigin = node.origin;
        nodetoself = self.origin - nodeorigin;
        nodetoself = vectornormalize( nodetoself );
        adjustedstartpos = nodeorigin + nodetoself * startdist;
        lerppos = adjustedstartpos + ( nodeorigin - adjustedstartpos ) * ( i + 1 ) / frames;
        self safeteleport( lerppos );
        wait 0.05;
    }
    
    self.keepclaimednodeifvalid = 0;
}

// Namespace shared
// Params 0
// Checksum 0x2f039683, Offset: 0x2156
// Size: 0x4, Type: bool
function returntrue()
{
    return true;
}

#using_animtree( "generic_human" );

// Namespace shared
// Params 3
// Checksum 0xb7fac528, Offset: 0x2163
// Size: 0x99
function playlookanimation( lookanim, looktime, canstopcallback = &returntrue )
{
    for ( i = 0; i < looktime * 10 ; i++ )
    {
        if ( isalive( self.enemy ) )
        {
            if ( utility_common::canseeenemy() && [[ canstopcallback ]]() )
            {
                return;
            }
        }
        
        if ( utility_common::issuppressedwrapper() && [[ canstopcallback ]]() )
        {
            return;
        }
        
        self setanimknoball( lookanim, %body, 1, 0.1 );
        wait 0.1;
    }
}

// Namespace shared
// Params 1
// Checksum 0xe25ffa20, Offset: 0x2204
// Size: 0x34
function throwdownweapon( swapanim )
{
    self endon( #"killanimscript" );
    placeweaponon( self.secondaryweapon, "right" );
    gameskill::didsomethingotherthanshooting();
}

// Namespace shared
// Params 0
// Checksum 0xeefcceef, Offset: 0x2240
// Size: 0xa1
function rpgplayerrepulsor()
{
    misses_remaining = utility::callsharedfunc( #"rpgplayer", #"misses_remaining" ) ?? level.var_3c046b82f96e963e ?? rpgplayerrepulsor_getnummisses();
    
    if ( misses_remaining == 0 )
    {
        return;
    }
    
    self endon( #"death" );
    
    for ( ;; )
    {
        self waittill( #"shooting" );
        
        if ( isdefined( level.var_4dce2a16c34c05b8 ) )
        {
            self [[ level.var_4dce2a16c34c05b8 ]]();
            continue;
        }
        
        if ( function_74931e0d742238ab() )
        {
            level thread rpgplayerrepulsor_create( self.enemy );
            misses_remaining--;
            
            if ( misses_remaining <= 0 )
            {
                return;
            }
        }
    }
}

// Namespace shared
// Params 0
// Checksum 0xec5d0712, Offset: 0x22e9
// Size: 0x33, Type: bool
function function_74931e0d742238ab()
{
    if ( isdefined( level.createrpgrepulsors ) && !level.createrpgrepulsors )
    {
        return false;
    }
    
    if ( isplayer( self.enemy ) )
    {
        return true;
    }
    
    return false;
}

// Namespace shared
// Params 0
// Checksum 0x111fcbaa, Offset: 0x2325
// Size: 0x70
function rpgplayerrepulsor_getnummisses()
{
    skill = utility::getdifficulty();
    
    switch ( skill )
    {
        case #"hash_22ce4003c1e5227b":
        case #"hash_ba826b0f31b00b60":
            return 2;
        case #"hash_420f6837f7efa409":
        case #"hash_c71b112fe04823d6":
        case #"hash_cc9157548a55043c":
            return 1;
        case #"hash_fa14cdf6bd53b8e4":
            return 0;
    }
    
    return 2;
}

// Namespace shared
// Params 1
// Checksum 0x2c59f067, Offset: 0x239e
// Size: 0x85
function rpgplayerrepulsor_create( ent )
{
    ent notify( #"stop_prev_repulsor" );
    ent endon( #"stop_prev_repulsor" );
    
    if ( !isdefined( ent.var_47894f862f7e492a ) )
    {
        ent.var_47894f862f7e492a = missile_createrepulsorent( ent, 5000, 800 );
    }
    
    repulsor = ent.var_47894f862f7e492a;
    ent utility::waittill_notify_or_timeout( "death", 4 );
    missile_deleteattractor( repulsor );
    ent.var_47894f862f7e492a = undefined;
}

// Namespace shared
// Params 0
// Checksum 0x3687b88a, Offset: 0x242b
// Size: 0xe7
function pickandsetforceweapon()
{
    if ( self.weaponoverride )
    {
        return;
    }
    
    if ( utility::within_fov( level.player.origin, level.player getplayerangles(), self.origin, 0.173648 ) )
    {
        return;
    }
    
    objweapon = undefined;
    
    if ( distancesquared( self.origin, self.enemy.origin ) < self.closeweaponmaxdist * self.closeweaponmaxdist )
    {
        objweapon = self.forcedweaponclose;
    }
    else
    {
        objweapon = self.forcedweaponfar;
    }
    
    if ( objweapon != self.weapon )
    {
        forceuseweapon( objweapon, "primary" );
        self.weapon_stow setmodel( getweaponmodel( self.forcedweapon ) );
        self.forcedweapon = objweapon;
    }
}

// Namespace shared
// Params 2
// Checksum 0xe3c9f47b, Offset: 0x251a
// Size: 0x232
function forceuseweapon( newweapon, targetslot )
{
    assert( isdefined( newweapon ) );
    assert( isdefined( targetslot ) );
    assert( targetslot == "<dev string:x269>" || targetslot == "<dev string:x271>" || targetslot == "<dev string:x27b>", "<dev string:x283>" );
    newweaponobj = undefined;
    
    if ( isweapon( newweapon ) )
    {
        assert( !isnullweapon( newweapon ) );
        newweaponobj = newweapon;
    }
    else
    {
        assert( newweapon != "<dev string:x24>" );
        newweaponobj = [[ level.fnbuildweapon ]]( newweapon );
    }
    
    if ( self.script_fakeactor || self.script_drone )
    {
        ai::gun_remove();
        ai::gun_create_fake( getweaponattachmentworldmodels( newweaponobj ) );
        return;
    }
    
    if ( !utility::isweaponinitialized( newweaponobj ) )
    {
        utility::initweapon( newweaponobj );
    }
    
    hasweapon = !isnullweapon( self.weapon );
    iscurrentsidearm = utility_common::isusingsidearm();
    isnewsidearm = targetslot == "sidearm";
    isnewsecondary = targetslot == "secondary";
    
    if ( hasweapon && iscurrentsidearm != isnewsidearm )
    {
        assert( self.weapon != newweaponobj );
        
        if ( iscurrentsidearm )
        {
            holstertarget = "none";
        }
        else if ( isnewsecondary )
        {
            holstertarget = "back";
        }
        else
        {
            holstertarget = "chest";
        }
        
        placeweaponon( self.weapon, holstertarget );
        self.lastweapon = self.weapon;
    }
    else
    {
        self.lastweapon = newweaponobj;
    }
    
    placeweaponon( newweaponobj, "right" );
    
    if ( isnewsidearm )
    {
        self.sidearm = newweaponobj;
    }
    else if ( isnewsecondary )
    {
        self.secondaryweapon = newweaponobj;
    }
    else
    {
        self.primaryweapon = newweaponobj;
    }
    
    self.weapon = newweaponobj;
    self.bulletsinclip = weaponclipsize( self.weapon );
    self notify( #"weapon_switch_done" );
    updateweaponarchetype( weaponclass( self.weapon ) );
}

// Namespace shared
// Params 1
// Checksum 0xc993bf89, Offset: 0x2754
// Size: 0x1c2
function updateweaponarchetype( weapclass )
{
    if ( !isdefined( self._blackboard ) || asm_bb::bb_isanimscripted() || !( isdefined( self.asm ) && isdefined( self.animsetname ) ) )
    {
        return;
    }
    
    if ( self ignoreweaponarchetypes() )
    {
        return;
    }
    
    basearchetypename = self getbasearchetype();
    
    if ( weapclass == "pistol" && archetypeassetloaded( self.animsetname + "_pistol" ) )
    {
        self setoverridearchetype( "weapon", self.animsetname + "_pistol", 1 );
        return;
    }
    
    if ( weapclass == "pistol" && archetypeassetloaded( basearchetypename + "_pistol" ) )
    {
        self setoverridearchetype( "weapon", basearchetypename + "_pistol", 1 );
        return;
    }
    
    if ( weapclass == "mg" && archetypeassetloaded( self.animsetname + "_lmg" ) )
    {
        self setoverridearchetype( "weapon", self.animsetname + "_lmg", 1 );
        return;
    }
    
    if ( weapclass == "mg" && archetypeassetloaded( basearchetypename + "_lmg" ) )
    {
        self setoverridearchetype( "weapon", basearchetypename + "_lmg", 1 );
        return;
    }
    
    if ( weapclass == "rocketlauncher" && archetypeassetloaded( self.animsetname + "_rpg" ) )
    {
        self setoverridearchetype( "weapon", self.animsetname + "_rpg", 1 );
        return;
    }
    
    if ( weapclass == "rocketlauncher" && archetypeassetloaded( basearchetypename + "_rpg" ) )
    {
        self setoverridearchetype( "weapon", basearchetypename + "_rpg", 1 );
        return;
    }
    
    self clearoverridearchetype( "weapon" );
}

// Namespace shared
// Params 0
// Checksum 0xbdfc804a, Offset: 0x291e
// Size: 0x31, Type: bool
function everusessecondaryweapon()
{
    if ( utility_common::isshotgun( self.secondaryweapon ) )
    {
        return true;
    }
    
    if ( weaponclass( self.primaryweapon ) == "rocketlauncher" )
    {
        return true;
    }
    
    return false;
}

// Namespace shared
// Params 1
// Checksum 0xc22bad09, Offset: 0x2958
// Size: 0x428
function default_weaponsetup( scriptedweaponassignment )
{
    if ( !isdefined( self.stowsidearmposition ) )
    {
        if ( self.bhasthighholster )
        {
            self.stowsidearmposition = "thigh";
        }
        else
        {
            self.stowsidearmposition = anim.stowsidearmpositiondefault;
        }
    }
    
    if ( self.scriptedweaponfailed )
    {
        if ( isdefined( level.fnscriptedweaponassignment ) )
        {
            if ( isdefined( self.scriptedweaponfailed_primaryarray ) )
            {
                self.primaryweapon = [[ level.fnscriptedweaponassignment ]]( self.scriptedweaponfailed_primaryarray );
                self.scriptedweaponfailed_primaryarray = undefined;
            }
            
            if ( isdefined( self.scriptedweaponfailed_sidearmarray ) )
            {
                self.sidearm = [[ level.fnscriptedweaponassignment ]]( self.scriptedweaponfailed_sidearmarray, "sidearm" );
                self.scriptedweaponfailed_sidearmarray = undefined;
            }
            
            if ( isdefined( self.scriptedweaponfailed_secondaryarray ) )
            {
                self.secondaryweapon = [[ level.fnscriptedweaponassignment ]]( self.scriptedweaponfailed_secondaryarray );
                self.scriptedweaponfailed_secondaryarray = undefined;
            }
        }
    }
    else if ( self.usescriptedweapon && isdefined( level.fnscriptedweaponassignment ) )
    {
        self.primaryweapon = [[ level.fnscriptedweaponassignment ]]( self.primaryweapon );
        self.secondaryweapon = [[ level.fnscriptedweaponassignment ]]( self.secondaryweapon );
        self.sidearm = [[ level.fnscriptedweaponassignment ]]( self.sidearm, "sidearm" );
    }
    else if ( !self.usescriptedweapon && !isdefined( self.agent_type ) )
    {
        if ( !utility::issp() )
        {
            if ( !isweapon( self.primaryweapon ) )
            {
                self.primaryweapon = [[ level.fnbuildweapon ]]( self.primaryweapon, [], "camo_none", "none" );
            }
            
            if ( !isweapon( self.secondaryweapon ) )
            {
                self.secondaryweapon = [[ level.fnbuildweapon ]]( self.secondaryweapon, [], "camo_none", "none" );
            }
            
            if ( !isweapon( self.sidearm ) )
            {
                self.sidearm = [[ level.fnbuildweapon ]]( self.sidearm, [], "camo_none", "none" );
            }
        }
        else
        {
            self.primaryweapon = [[ level.fnbuildweapon ]]( self.primaryweapon, [] );
            self.secondaryweapon = [[ level.fnbuildweapon ]]( self.secondaryweapon, [] );
            self.sidearm = [[ level.fnbuildweapon ]]( self.sidearm, [] );
        }
    }
    
    utility::initweapon( nullweapon() );
    
    if ( !isnullweapon( self.primaryweapon ) )
    {
        utility::initweapon( self.primaryweapon );
    }
    
    if ( !isnullweapon( self.secondaryweapon ) )
    {
        utility::initweapon( self.secondaryweapon );
    }
    
    if ( !isnullweapon( self.sidearm ) )
    {
        utility::initweapon( self.sidearm );
    }
    
    validatesidearm();
    self setdefaultaimlimits();
    self.a.weaponpos = [];
    self.a.weaponposdropping = [];
    self.lastweapon = self.weapon;
    
    if ( utility_common::usingrocketlauncher() )
    {
        thread rpgplayerrepulsor();
    }
    
    self.rocketammo = 100;
    
    if ( !isnullweapon( self.primaryweapon ) )
    {
        placeweaponon( self.primaryweapon, "right" );
    }
    
    if ( utility_common::isshotgun( self.secondaryweapon ) )
    {
        placeweaponon( self.secondaryweapon, "back" );
    }
    
    if ( !isnullweapon( self.sidearm ) && isdefined( self.stowsidearmposition ) )
    {
        placeweaponon( self.sidearm, self.stowsidearmposition );
    }
    
    if ( utility::issp() && self isbadguy() )
    {
        self.has_no_ir = 1;
    }
    
    weaponlist::refillclip();
}

// Namespace shared
// Params 0
// Checksum 0x3d3c393, Offset: 0x2d88
// Size: 0x13b
function validatesidearm()
{
    /#
        if ( self.primaryweapon == self.sidearm && !isnullweapon( self.primaryweapon ) )
        {
            exportstring = self.export ?? "<dev string:x2b8>";
            classnamestring = isagent( self ) ? self.agent_type : self.classname;
            assertmsg( "<dev string:x2b9>" + classnamestring + "<dev string:x2be>" + exportstring + "<dev string:x2ce>" + getcompleteweaponname( self.primaryweapon ) + "<dev string:x2fa>" );
        }
        
        if ( self.secondaryweapon == self.sidearm && !isnullweapon( self.secondaryweapon ) && everusessecondaryweapon() )
        {
            exportstring = self.export ?? "<dev string:x2b8>";
            classnamestring = isagent( self ) ? self.agent_type : self.classname;
            assertmsg( "<dev string:x2b9>" + classnamestring + "<dev string:x2be>" + exportstring + "<dev string:x2fd>" + getcompleteweaponname( self.primaryweapon ) + "<dev string:x2fa>" );
        }
    #/
}

// Namespace shared
// Params 0
// Checksum 0x518ec032, Offset: 0x2ecb
// Size: 0x9c
function initmeleecharges()
{
    anim.meleechargetimers[ "c6" ] = 0;
    anim.meleechargeintervals[ "c6" ] = 9000;
    anim.meleechargeplayertimers[ "c6" ] = 0;
    anim.meleechargeplayerintervals[ "c6" ] = 15000;
    anim.meleechargetimers[ "seeker" ] = 0;
    anim.meleechargeintervals[ "seeker" ] = 9000;
    anim.meleechargeplayertimers[ "seeker" ] = 0;
    anim.meleechargeplayerintervals[ "seeker" ] = 15000;
    
    /#
        thread combat_utility::showgrenadetimers();
    #/
}

// Namespace shared
// Params 0
// Checksum 0xdc3ce02e, Offset: 0x2f6f
// Size: 0x4c
function init_squadmanager()
{
    if ( anim.squadinitialized )
    {
        return;
    }
    
    anim.squadcreatefuncs = [];
    anim.squadcreatestrings = [];
    anim.squads = [];
    anim.squadindex = [];
    anim.squadrand = 0;
    anim.squadinitialized = 1;
}

// Namespace shared
// Params 0
// Checksum 0x170328b2, Offset: 0x2fc3
// Size: 0x271
function initanimvars()
{
    anim.animflagnameindex = 0;
    anim.combatmemorytimeconst = 10000;
    anim.combatmemorytimerand = 6000;
    anim.weaponsetupfuncs = [];
    anim.weaponsetupfuncs[ "c12" ] = &c12_weaponsetup;
    anim.dismemberheavyfx = [];
    anim.weaponstowfunction = &pickandsetforceweapon;
    
    if ( !isdefined( anim.optionalstepeffects ) )
    {
        anim.optionalstepeffects = [];
    }
    
    if ( !isdefined( anim.optionalstepeffectssmall ) )
    {
        anim.optionalstepeffectssmall = [];
    }
    
    if ( !isdefined( anim.optionalfootprinteffects ) )
    {
        anim.optionalfootprinteffects = [];
    }
    
    if ( !isdefined( anim.shootenemywrapper_func ) )
    {
        anim.shootenemywrapper_func = &utility::shootenemywrapper_shootnotify;
    }
    
    if ( !isdefined( anim.shootposwrapper_func ) )
    {
        anim.shootposwrapper_func = &utility::shootposwrapper;
    }
    
    setglobalaimsettings();
    anim.fire_notetrack_functions = [];
    anim.lastcarexplosiontime = -100000;
    anim.burstfirenumshots = [ 1, 2, 2, 2, 3, 3, 3, 3, 4, 4, 5 ];
    anim.fastburstfirenumshots = [ 2, 3, 3, 3, 4, 4, 4, 5, 5 ];
    anim.semifirenumshots = [ 1, 2, 2, 3, 3, 4, 4, 4, 4, 5, 5, 5 ];
    anim.badplaces = [];
    anim.badplaceint = 0;
    anim.nodeyaws = [];
    anim.grenadethrowanims = [];
    anim.grenadethrowoffsets = [];
    anim.var_50d4237318a10673 = [];
    
    if ( !isdefined( anim.var_7a467f51952fc7be ) )
    {
        anim.var_7a467f51952fc7be = &ai_lookat::enablelookatentity;
        anim.var_89690e2f5b3c4893 = &ai_lookat::disablelookatentity;
    }
    
    if ( !isdefined( anim.var_5458eb88a5c60307 ) )
    {
        anim.var_5458eb88a5c60307 = &detachallweaponmodels;
        anim.var_a539877b0796cf31 = &updateattachedweaponmodels;
    }
    
    initgestures();
    initmaxspeedforpathlengthtable();
    animselector::init();
}

// Namespace shared
// Params 0
// Checksum 0x2f3b45e3, Offset: 0x323c
// Size: 0xb4
function initgestures()
{
    gestures = [];
    gestures[ gestures.size ] = "point_casual";
    gestures[ gestures.size ] = "point_military";
    gestures[ gestures.size ] = "yes";
    gestures[ gestures.size ] = "no";
    gestures[ gestures.size ] = "hold";
    gestures[ gestures.size ] = "talk";
    gestures[ gestures.size ] = "shrug";
    gestures[ gestures.size ] = "getdown";
    gestures[ gestures.size ] = "nvg_on";
    gestures[ gestures.size ] = "nvg_off";
    gestures[ gestures.size ] = "beckon";
    gestures[ gestures.size ] = "lookback_right";
    gestures[ gestures.size ] = "wrist_com_lower";
    gestures[ gestures.size ] = "wrist_com_raise";
    anim.gestures = gestures;
}

// Namespace shared
// Params 0
// Checksum 0xb6e07066, Offset: 0x32f8
// Size: 0x8a
function setglobalaimsettings()
{
    anim.covercrouchleanpitch = 55;
    anim.aimyawdifffartolerance = 10;
    anim.aimyawdiffclosedistsq = 4096;
    anim.aimyawdiffclosetolerance = 45;
    anim.aimpitchdifftolerance = 20;
    anim.painyawdifffartolerance = 25;
    anim.painyawdiffclosedistsq = anim.aimyawdiffclosedistsq;
    anim.painyawdiffclosetolerance = anim.aimyawdiffclosetolerance;
    anim.painpitchdifftolerance = 30;
    anim.maxanglecheckyawdelta = 65;
    anim.maxanglecheckpitchdelta = 65;
}

// Namespace shared
// Params 0
// Checksum 0x319bfe3f, Offset: 0x338a
// Size: 0x2c
function c12_getweapontypeforweapon()
{
    if ( utility_common::usingrocketlauncher() )
    {
        return "rocket";
    }
    
    if ( utility_common::function_2fff89909fdbfbab( self.weapon ) )
    {
        return "minigun";
    }
}

// Namespace shared
// Params 0
// Checksum 0x14a964f5, Offset: 0x33bf
// Size: 0x96
function c12_weaponsetup()
{
    self.weapons = [];
    
    if ( !isnullweapon( self.primaryweapon ) )
    {
        self.weapon = self.primaryweapon;
        self.weapons[ "right" ] = c12_getweapontypeforweapon();
    }
    
    if ( !isnullweapon( self.secondaryweapon ) )
    {
        self.weapon = self.secondaryweapon;
        self.weapons[ "left" ] = c12_getweapontypeforweapon();
    }
    
    self.weapon = nullweapon();
    self.bulletsinclip = 1;
}

// Namespace shared
// Params 0
// Checksum 0x3abecdeb, Offset: 0x345d
// Size: 0xb3
function setuprandomtable()
{
    anim.randominttablesize = 60;
    anim.randominttable = [];
    
    for ( i = 0; i < anim.randominttablesize ; i++ )
    {
        anim.randominttable[ i ] = i;
    }
    
    for ( i = 0; i < anim.randominttablesize ; i++ )
    {
        switchwith = randomint( anim.randominttablesize );
        temp = anim.randominttable[ i ];
        anim.randominttable[ i ] = anim.randominttable[ switchwith ];
        anim.randominttable[ switchwith ] = temp;
    }
}

// Namespace shared
// Params 0
// Checksum 0xf70cbbaa, Offset: 0x3518
// Size: 0x52
function setupweapons()
{
    self endon( #"death" );
    utility::flag_wait( "load_finished" );
    
    if ( isdefined( anim.weaponsetupfuncs[ self.unittype ] ) )
    {
        self [[ anim.weaponsetupfuncs[ self.unittype ] ]]();
        return;
    }
    
    default_weaponsetup();
}

// Namespace shared
// Params 2
// Checksum 0x7039dc33, Offset: 0x3572
// Size: 0x1c6
function setscriptammo( inherit_from, has_under_barrel )
{
    if ( isdefined( inherit_from.script_ammo_clip ) )
    {
        assert( isdefined( inherit_from.script_ammo_clip ), "<dev string:x32b>" );
        assert( isdefined( inherit_from.script_ammo_extra ), "<dev string:x354>" );
        self itemweaponsetammo( inherit_from.script_ammo_clip, inherit_from.script_ammo_extra );
    }
    else if ( isdefined( inherit_from.script_ammo_extra ) )
    {
        assert( isdefined( inherit_from.script_ammo_extra ), "<dev string:x396>" );
        assert( isdefined( inherit_from.script_ammo_clip ), "<dev string:x3c0>" );
        self itemweaponsetammo( inherit_from.script_ammo_clip, inherit_from.script_ammo_extra );
    }
    
    if ( isdefined( inherit_from.script_ammo_alt_clip ) )
    {
        assert( isdefined( inherit_from.script_ammo_alt_clip ), "<dev string:x402>" );
        assert( isdefined( inherit_from.script_ammo_extra ), "<dev string:x42f>" );
        self itemweaponsetammo( inherit_from.script_ammo_alt_clip, inherit_from.script_ammo_alt_extra, undefined, 1 );
    }
    else if ( isdefined( inherit_from.script_ammo_alt_extra ) )
    {
        assert( isdefined( inherit_from.script_ammo_alt_extra ), "<dev string:x475>" );
        assert( isdefined( inherit_from.script_ammo_clip ), "<dev string:x4a3>" );
        self itemweaponsetammo( inherit_from.script_ammo_alt_clip, inherit_from.script_ammo_alt_extra, undefined, 1 );
    }
    
    if ( isdefined( inherit_from.script_ammo_max ) )
    {
        self itemweaponsetammo( weaponclipsize( self ), weaponmaxammo( self ) );
    }
    
    if ( has_under_barrel )
    {
        self itemweaponsetammo( 1, 6, 0, 1 );
    }
}

