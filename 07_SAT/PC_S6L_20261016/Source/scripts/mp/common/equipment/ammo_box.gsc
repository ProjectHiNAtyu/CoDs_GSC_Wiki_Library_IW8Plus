// scripts\mp\common\equipment\ammo_box.gsc  (hash_593d3c2f92cbc61b.gscc) (size: 16492 Bytes / 0x406c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x335eee05 (861859333)
// size ...... 16492 (0x406c)
// includes .. 24  (offset: 0x3d20)
// strings ... 39  (offset: 0x3de0)
// dev strs .. 7   (offset: 0x4018)
// exports ... 52  (offset: 0x217c)
// cseg ...... 0x2e8 + 0x1e94 (0x217c)
// imports ... 167 (offset: 0x299c)
// animtree1 . 0   (offset: 0x406c)
// animtree2 . 0   (offset: 0x406c)
#using scripts\common\interactive;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\analyticslog;
#using scripts\mp\common\equipment\support_box;
#using scripts\mp\common\killstreaks\juggernaut;
#using scripts\mp\common\utility\damage;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\join_team_aggregator;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\usability;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\damage;
#using scripts\mp\emp_debuff;
#using scripts\mp\entityheadicons;
#using scripts\mp\hostmigration;
#using scripts\mp\movers;
#using scripts\mp\supers;
#using scripts\mp\weapons;

#namespace ammo_box;

// Namespace ammo_box
// Params 0
// Checksum 0x6fbdbe87, Offset: 0x306
// Size: 0x1f7
function ammobox_init()
{
    level.allammoboxes = [];
    interactive::interactive_addusedcallback( &ammobox_usedcallback, "equip_ammo_box" );
    join_team_aggregator::registeronplayerjointeamcallback( &ammobox_updateheadicononjointeam );
    level._effect[ "weapon_box_impact" ] = loadfxasset( "vfx_iw9_strk_smoke_signal_carepkg_landing_dust" );
    level._effect[ "vfx_iw8_mp_perk_weapon_drop_destr" ] = loadfxasset( "vfx_iw8_mp_perk_weapon_drop_destr" );
    level.ammoboxweapons = spawnstruct();
    level.ammoboxweapons.weapons = [];
    level.ammoboxweapons.probabilities = [];
    hasnvg = utility::function_2a082dafe6f4bd5b();
    ammobox_addrandomweapon( "weapon_assault", hasnvg );
    ammobox_addrandomweapon( "weapon_assault", hasnvg );
    ammobox_addrandomweapon( "weapon_battle", hasnvg );
    ammobox_addrandomweapon( "weapon_smg", hasnvg );
    ammobox_addrandomweapon( "weapon_smg", hasnvg );
    ammobox_addrandomweapon( "weapon_lmg", hasnvg );
    ammobox_addrandomweapon( "weapon_lmg", hasnvg );
    ammobox_addrandomweapon( "weapon_sniper", hasnvg );
    ammobox_addrandomweapon( "weapon_dmr", hasnvg );
    ammobox_addrandomweapon( "weapon_shotgun", hasnvg );
    ammobox_addrandomweapon( "weapon_pistol", hasnvg );
    totalprobability = 0;
    
    foreach ( probability in level.ammoboxweapons.probabilities )
    {
        totalprobability += probability;
    }
    
    level.ammoboxweapons.totalprobability = totalprobability;
    
    /#
        setdevdvarifuninitialized( @"hash_dda56d67bc308c3e", 0 );
        level thread function_85adfac28e31117c();
    #/
}

// Namespace ammo_box
// Params 2
// Checksum 0xc27468e7, Offset: 0x505
// Size: 0xb8
function ammobox_addrandomweapon( weapongroup, hasnvg )
{
    randomweapon = weapon::getrandomweaponfromgroup( weapongroup );
    var_ba7d2b302d6ae466 = weapon::buildweapon( randomweapon, undefined, undefined, undefined, undefined, undefined, undefined, undefined, hasnvg );
    numattachments = randomintrange( 2, 8 );
    
    for ( i = 0; i < numattachments ; i++ )
    {
        attachment = weapons::getrandomgraverobberattachment( var_ba7d2b302d6ae466 );
        
        if ( !isdefined( attachment ) )
        {
            break;
        }
        
        newweaponobj = weapons::addattachmenttoweapon( var_ba7d2b302d6ae466, attachment );
        
        if ( isdefined( newweaponobj ) )
        {
            var_ba7d2b302d6ae466 = newweaponobj;
        }
    }
    
    if ( isdefined( var_ba7d2b302d6ae466 ) )
    {
        ammobox_addboxweapon( var_ba7d2b302d6ae466, 10 );
    }
}

// Namespace ammo_box
// Params 1
// Checksum 0xa9a5e679, Offset: 0x5c5
// Size: 0x8c
function ammobox_updateheadicononjointeam( player )
{
    foreach ( ammobox in level.allammoboxes )
    {
        if ( isdefined( ammobox ) )
        {
            ammobox support_box::supportbox_updateheadicon( player );
        }
    }
}

// Namespace ammo_box
// Params 2
// Checksum 0x4ceb590d, Offset: 0x659
// Size: 0x104
function ammobox_addboxweapon( weaponobj, probability )
{
    assert( isdefined( weaponobj ) );
    currentindex = level.ammoboxweapons.weapons.size;
    fullweaponname = getcompleteweaponname( weaponobj );
    var_55f787ddff5fc949 = "";
    attachmenttoks = strtok( fullweaponname, "+" );
    var_55f787ddff5fc949 = attachmenttoks[ 0 ];
    
    for ( i = 1; i < attachmenttoks.size ; i++ )
    {
        tok = attachmenttoks[ i ];
        varianttoks = strtok( tok, "|" );
        var_55f787ddff5fc949 += "+" + varianttoks[ 0 ];
    }
    
    var_724a93f00fbce5bf = makeweaponfromstring( var_55f787ddff5fc949 );
    level.ammoboxweapons.weapons[ currentindex ] = var_724a93f00fbce5bf;
    level.ammoboxweapons.probabilities[ currentindex ] = probability;
}

// Namespace ammo_box
// Params 1
// Checksum 0xafccc0a3, Offset: 0x765
// Size: 0xc1
function ammobox_settled( grenade )
{
    grenade thread ammobox_watchdisownedtimeout();
    self setscriptablepartstate( "visibility", "show", 0 );
    
    if ( true )
    {
        thread weapons::outlineequipmentforowner( grenade );
    }
    
    grenade.issuper = 1;
    weapons::onequipmentplanted( grenade, "equip_ammo_box", &ammobox_destroy );
    level.allammoboxes[ grenade getentitynumber() ] = grenade;
    grenade emp_debuff::set_apply_emp_callback( &ammobox_empapplied );
    
    if ( level.killstreak_emp_initialized )
    {
        grenade.ksempapplycallback = &ammobox_empapplied;
    }
    
    grenade ammobox_makedamageable();
    
    if ( !game_utility::function_d3f8957534dc62af() )
    {
        grenade ammobox_addheadicon();
    }
    
    grenade thread ammobox_preloadweapons();
    grenade thread ammobox_makeusable();
}

// Namespace ammo_box
// Params 0
// Checksum 0xea94c2d5, Offset: 0x82e
// Size: 0xb
function ammobox_destroy()
{
    thread ammobox_delete( 0, 0 );
}

// Namespace ammo_box
// Params 2
// Checksum 0x77847966, Offset: 0x841
// Size: 0x12a
function ammobox_delete( deletiondelay, wasdestroyed )
{
    self notify( #"death" );
    self.isdestroyed = 1;
    self setcandamage( 0 );
    
    if ( isdefined( self.owner ) )
    {
        self.owner weapons::removeequip( self );
    }
    
    ammobox_removeheadicon();
    ammobox_makeunusable();
    analyticslog::logevent_fieldupgradeexpired( self.owner, self.superid, self.usedcount, istrue( wasdestroyed ) );
    
    if ( self isscriptable() )
    {
        self setscriptablepartstate( "effects", "destroy", 0 );
    }
    else if ( utility::fxexists( "vfx_iw8_mp_perk_weapon_drop_destr" ) )
    {
        effectid = utility::getfx( "vfx_iw8_mp_perk_weapon_drop_destr" );
        origin = self.origin;
        forward = anglestoforward( self.angles );
        up = anglestoup( self.angles );
        playfx( effectid, origin, forward, up );
    }
    
    self playsound( "mp_equip_box_destroyed" );
    wait deletiondelay;
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace ammo_box
// Params 0
// Checksum 0x8747e95f, Offset: 0x973
// Size: 0x4d
function ammobox_preloadweapons()
{
    preloadheight = 60;
    preloadradius = 256;
    preloadtrigger = spawn( "trigger_radius", self.origin, 0, preloadradius, preloadheight );
    ammobox_internalpreloadweapons( preloadtrigger );
    preloadtrigger delete();
}

// Namespace ammo_box
// Params 1
// Checksum 0x3240cfef, Offset: 0x9c8
// Size: 0xb3
function ammobox_internalpreloadweapons( preloadtrigger )
{
    self endon( #"death" );
    
    while ( true )
    {
        preloadtrigger waittill( #"trigger", player );
        
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        if ( isdefined( self.playersused[ player getentitynumber() ] ) )
        {
            continue;
        }
        
        bufferedweapon = ammobox_getbufferedweapon( player );
        loadweapons = [ bufferedweapon ];
        ammobox_checkclearbufferedattachmentweapon( player );
        bufferedattachmentweapon = ammobox_getbufferedattachmentweapon( player );
        
        if ( isdefined( bufferedattachmentweapon ) )
        {
            loadweapons[ loadweapons.size ] = bufferedattachmentweapon;
        }
        
        player loadweaponsforplayer( loadweapons, 1 );
    }
}

// Namespace ammo_box
// Params 0
// Checksum 0xfdbbeca, Offset: 0xa83
// Size: 0x79
function ammobox_makeusable()
{
    interactive::interactive_addusedcallbacktoentity( "equip_ammo_box" );
    self.usedcount = 0;
    self.playersused = [];
    usability::maketeamusable( self.team );
    self enablemissilehint( 1 );
    self setcursorhint( "HINT_NOICON" );
    self sethintstring( &"equipment_hints/ammo_box_use" );
    self setuserange( 128 );
    self setuseholdduration( "duration_none" );
    self sethinttag( "tag_hint" );
    thread ammobox_watchallplayeruse();
}

// Namespace ammo_box
// Params 0
// Checksum 0x5175b51f, Offset: 0xb04
// Size: 0x25
function ammobox_makeunusable()
{
    self notify( #"supportbox_makeunusable" );
    interactive::interactive_removeusedcallbackfromentity();
    self makeunusable();
    self.playersused = undefined;
}

// Namespace ammo_box
// Params 0
// Checksum 0x1399be19, Offset: 0xb31
// Size: 0x54
function ammobox_watchallplayeruse()
{
    self endon( #"death" );
    self endon( #"supportbox_makeunusable" );
    var_d94c20f799b7a19a = gettime();
    
    while ( true )
    {
        ammobox_updateplayersused();
        
        if ( gettime() >= var_d94c20f799b7a19a )
        {
            ammobox_updateplayerusevisibility();
            var_d94c20f799b7a19a = gettime() + 150;
        }
        
        waitframe();
    }
}

// Namespace ammo_box
// Params 0
// Checksum 0x61828c20, Offset: 0xb8d
// Size: 0xac
function ammobox_updateplayerusevisibility()
{
    nearplayers = utility::playersnear( self.origin, 300 );
    
    foreach ( player in nearplayers )
    {
        if ( isdefined( player ) )
        {
            if ( !ammobox_playercanuse( player ) )
            {
                self disableplayeruse( player );
                continue;
            }
            
            self enableplayeruse( player );
        }
    }
}

// Namespace ammo_box
// Params 0
// Checksum 0xa3aa871c, Offset: 0xc41
// Size: 0xba
function ammobox_updateplayersused()
{
    foreach ( player in self.playersused )
    {
        if ( isdefined( player ) )
        {
            entnum = player getentitynumber();
            
            if ( !player::isreallyalive( player ) && isdefined( self.playersused[ entnum ] ) )
            {
                self.playersused[ entnum ] = undefined;
                support_box::supportbox_updateheadicon( player );
            }
        }
    }
}

// Namespace ammo_box
// Params 1
// Checksum 0x72fef721, Offset: 0xd03
// Size: 0x5b, Type: bool
function ammobox_playercanuse( player )
{
    if ( !player::isreallyalive( player ) )
    {
        return false;
    }
    
    if ( !player val::get( "crate_use" ) )
    {
        return false;
    }
    
    if ( isdefined( self.playersused[ player getentitynumber() ] ) )
    {
        return false;
    }
    
    if ( player_utility::playersareenemies( player, self.owner ) )
    {
        return false;
    }
    
    return true;
}

// Namespace ammo_box
// Params 1
// Checksum 0xaa0613ba, Offset: 0xd67
// Size: 0x136, Type: bool
function ammobox_onplayerholduse( player )
{
    currentweapon = player.lastdroppableweaponobj;
    
    if ( isdefined( player.minigunprevweaponobject ) )
    {
        currentweapon = player.minigunprevweaponobject;
        player juggernaut::dropjuggernautweapon( "used_ammo_box", player.miniprevweaponobject );
    }
    
    newweapon = ammobox_getbufferedweapon( player );
    ammobox_clearbufferedweapon( player );
    
    if ( player.lastweaponobj.basename != "iw9_cyberemp_mp" )
    {
        numprimaries = player.primaryweapons.size;
        
        if ( !player hasweapon( level.defaultfist ) || numprimaries > 1 )
        {
            player inventory_utility::_takeweapon( currentweapon );
        }
    }
    
    player inventory_utility::_giveweapon( newweapon );
    player inventory_utility::_switchtoweaponimmediate( newweapon );
    
    if ( player.lastweaponobj.basename == "iw9_cyberemp_mp" )
    {
        previousweapon = player.lastdroppableweaponobj;
        player inventory_utility::_takeweapon( previousweapon );
    }
    
    player playlocalsound( "iw9_support_box_use" );
    weapon::fixupplayerweapons( player, newweapon );
    return true;
}

// Namespace ammo_box
// Params 1
// Checksum 0xca5388a0, Offset: 0xea6
// Size: 0x7c
function ammobox_getbufferedplayerdata( player )
{
    if ( !isdefined( player.bufferedammoboxdata ) )
    {
        buffereddata = spawnstruct();
        buffereddata.buffered = undefined;
        buffereddata.last = undefined;
        buffereddata.attachment = undefined;
        buffereddata.attachmentweapon = undefined;
        buffereddata.attachmentsourceweapon = undefined;
        player.bufferedammoboxdata = buffereddata;
    }
    
    return player.bufferedammoboxdata;
}

// Namespace ammo_box
// Params 1
// Checksum 0x9df1ff58, Offset: 0xf2b
// Size: 0xc7
function ammobox_getbufferedweapon( player )
{
    buffereddata = ammobox_getbufferedplayerdata( player );
    
    if ( !isdefined( buffereddata.buffered ) )
    {
        maxattempts = 10;
        safetyvalve = 0;
        randomweapon = undefined;
        primaries = player inventory_utility::getcurrentprimaryweaponsminusalt();
        
        while ( safetyvalve < maxattempts )
        {
            randomweapon = ammobox_getrandomweapon();
            
            if ( ammobox_isvalidrandomweapon( randomweapon, buffereddata.last, primaries ) )
            {
                break;
            }
            
            safetyvalve++;
        }
        
        assert( safetyvalve < maxattempts, "<dev string:x24>" + maxattempts + "<dev string:x5c>" );
        buffereddata.buffered = randomweapon;
    }
    
    return buffereddata.buffered;
}

// Namespace ammo_box
// Params 1
// Checksum 0x31e943fe, Offset: 0xffb
// Size: 0x95
function ammobox_getbufferedattachment( player )
{
    buffereddata = ammobox_getbufferedplayerdata( player );
    
    if ( !isdefined( buffereddata.attachment ) )
    {
        objweapon = player getcurrentprimaryweapon();
        
        if ( !isdefined( objweapon ) )
        {
            return;
        }
        
        if ( !ammobox_canweaponuserandomattachments( objweapon ) )
        {
            return;
        }
        
        if ( !ammobox_canweaponacceptmoreattachments( objweapon ) )
        {
            return;
        }
        
        randomattachment = weapons::getrandomgraverobberattachment( objweapon );
        
        if ( !isdefined( randomattachment ) )
        {
            return;
        }
        
        buffereddata.attachment = randomattachment;
    }
    
    return buffereddata.attachment;
}

// Namespace ammo_box
// Params 1
// Checksum 0x908c14c0, Offset: 0x1099
// Size: 0x34
function ammobox_getbufferedattachmentweapon( player )
{
    ammobox_bufferedattachmentweapon( player );
    buffereddata = ammobox_getbufferedplayerdata( player );
    return buffereddata.attachmentweapon;
}

// Namespace ammo_box
// Params 1
// Checksum 0x98177a6e, Offset: 0x10d6
// Size: 0x34
function ammobox_getbufferedattachmentsourceweapon( player )
{
    ammobox_bufferedattachmentweapon( player );
    buffereddata = ammobox_getbufferedplayerdata( player );
    return buffereddata.attachmentsourceweapon;
}

// Namespace ammo_box
// Params 1
// Checksum 0x691364c, Offset: 0x1113
// Size: 0xae
function ammobox_bufferedattachmentweapon( player )
{
    buffereddata = ammobox_getbufferedplayerdata( player );
    
    if ( !isdefined( buffereddata.attachmentweapon ) )
    {
        bufferedattachment = ammobox_getbufferedattachment( player );
        
        if ( !isdefined( bufferedattachment ) )
        {
            return;
        }
        
        oldweapon = player getcurrentprimaryweapon();
        newweapon = weapons::addattachmenttoweapon( oldweapon, bufferedattachment );
        assert( isdefined( newweapon ), oldweapon.basename + "<dev string:x64>" + bufferedattachment );
        
        if ( isdefined( newweapon ) )
        {
            buffereddata.attachmentsourceweapon = oldweapon;
            buffereddata.attachmentweapon = newweapon;
        }
    }
}

// Namespace ammo_box
// Params 1
// Checksum 0x24c2c0f5, Offset: 0x11c9
// Size: 0x42
function ammobox_clearbufferedweapon( player )
{
    buffereddata = ammobox_getbufferedplayerdata( player );
    buffereddata.last = buffereddata.buffered;
    buffereddata.buffered = undefined;
}

// Namespace ammo_box
// Params 1
// Checksum 0x2da76f7b, Offset: 0x1213
// Size: 0x41
function ammobox_clearbufferedattachmentweapon( player )
{
    buffereddata = ammobox_getbufferedplayerdata( player );
    buffereddata.attachment = undefined;
    buffereddata.attachmentweapon = undefined;
    buffereddata.attachmentsourceweapon = undefined;
}

// Namespace ammo_box
// Params 1
// Checksum 0xe80017f3, Offset: 0x125c
// Size: 0x8f
function ammobox_checkclearbufferedattachmentweapon( player )
{
    sourceweapon = ammobox_getbufferedattachmentsourceweapon( player );
    shouldclear = 0;
    
    if ( !isdefined( sourceweapon ) )
    {
        shouldclear = 1;
    }
    else
    {
        currentweapon = player getcurrentprimaryweapon();
        
        if ( !isdefined( currentweapon ) )
        {
            shouldclear = 1;
        }
        else
        {
            sourceweaponname = weapon::getweaponfullname( sourceweapon );
            currentweaponname = weapon::getweaponfullname( currentweapon );
            shouldclear = sourceweaponname != currentweaponname;
        }
    }
    
    if ( shouldclear )
    {
        ammobox_clearbufferedattachmentweapon( player );
    }
}

// Namespace ammo_box
// Params 3
// Checksum 0xfb0e634b, Offset: 0x12f3
// Size: 0xae, Type: bool
function ammobox_isvalidrandomweapon( randomweapon, lastweapon, primaries )
{
    if ( randomweapon == lastweapon )
    {
        return false;
    }
    
    foreach ( primary in primaries )
    {
        if ( primary.basename == randomweapon.basename )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace ammo_box
// Params 0
// Checksum 0x5a5e8e51, Offset: 0x13aa
// Size: 0xae
function ammobox_getrandomweapon()
{
    randomindex = randomint( level.ammoboxweapons.totalprobability );
    runningtotal = 0;
    selectedweapon = undefined;
    
    for ( i = 0; i < level.ammoboxweapons.weapons.size ; i++ )
    {
        runningtotal += level.ammoboxweapons.probabilities[ i ];
        
        if ( runningtotal > randomindex )
        {
            return level.ammoboxweapons.weapons[ i ];
        }
    }
    
    assert( isdefined( selectedweapon ), "<dev string:xa3>" );
}

// Namespace ammo_box
// Params 1
// Checksum 0x2702749d, Offset: 0x1461
// Size: 0x11a, Type: bool
function ammobox_onplayeruse( player )
{
    objweapon = player getcurrentweapon();
    
    if ( !ammobox_canweaponuserandomattachments( objweapon ) )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            player [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"mp/weapon_drop_incompat" );
        }
        
        return false;
    }
    
    if ( !ammobox_canweaponacceptmoreattachments( objweapon ) )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            player [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"mp/weapon_drop_too_many_attachments" );
        }
        
        return false;
    }
    
    results = player ammobox_giverandomattachment( objweapon );
    
    if ( !results )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            player [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"mp/weapon_drop_too_many_attachments" );
        }
        
        return false;
    }
    
    return true;
}

// Namespace ammo_box
// Params 1
// Checksum 0x80159a6f, Offset: 0x1584
// Size: 0x34, Type: bool
function ammobox_canweaponuserandomattachments( objweapon )
{
    if ( !weapon::iscacprimaryorsecondary( objweapon ) || weapon::issinglehitweapon( objweapon ) || weapon::ismeleeonly( objweapon ) )
    {
        return false;
    }
    
    return true;
}

// Namespace ammo_box
// Params 1
// Checksum 0xaee2bee2, Offset: 0x15c1
// Size: 0xa8, Type: bool
function ammobox_canweaponacceptmoreattachments( objweapon )
{
    attachments = getweaponattachments( objweapon );
    attachmentcount = 0;
    
    foreach ( attachment in attachments )
    {
        if ( !weapon::attachmentisselectable( objweapon, attachment ) )
        {
            continue;
        }
        
        attachmentcount++;
    }
    
    return attachmentcount < 8;
}

// Namespace ammo_box
// Params 1
// Checksum 0x8344ec59, Offset: 0x1672
// Size: 0x221, Type: bool
function ammobox_giverandomattachment( objweapon )
{
    if ( !isdefined( objweapon ) )
    {
        return false;
    }
    
    randomattachment = ammobox_getbufferedattachment( self );
    newweaponobj = ammobox_getbufferedattachmentweapon( self );
    
    if ( isdefined( newweaponobj ) )
    {
        ammobox_clearbufferedattachmentweapon( self );
        altweaponobj = undefined;
        switchtoalt = undefined;
        
        if ( objweapon.isalternate )
        {
            altweaponobj = objweapon;
            objweapon = objweapon getnoaltweapon();
            switchtoalt = weapons::shouldweaponsavealtstate( objweapon );
        }
        else
        {
            altweaponobj = objweapon getaltweapon();
            switchtoalt = 0;
        }
        
        var_8af02df24ab529a4 = newweaponobj getaltweapon();
        mainstockammo = self getweaponammostock( objweapon );
        var_2b2a96cf5e0949e4 = self getweaponammoclip( objweapon, "left" );
        var_5ff04e1c4febf1f5 = self getweaponammoclip( objweapon, "right" );
        altammotype = self getammotype( altweaponobj );
        altstockammo = self getweaponammostock( altweaponobj );
        var_23ce0d9eafa8b81a = self getweaponammoclip( altweaponobj, "left" );
        var_d791feef173fa7f3 = self getweaponammoclip( altweaponobj, "right" );
        var_5d8cc93233d1451a = switchtoalt ? var_8af02df24ab529a4 : newweaponobj;
        inventory_utility::_takeweapon( objweapon );
        inventory_utility::_giveweapon( var_5d8cc93233d1451a, -1, 0, 0 );
        inventory_utility::_switchtoweaponimmediate( var_5d8cc93233d1451a );
        weapon::fixupplayerweapons( self, var_5d8cc93233d1451a );
        self setweaponammostock( newweaponobj, mainstockammo );
        self setweaponammoclip( newweaponobj, var_2b2a96cf5e0949e4, "left" );
        self setweaponammoclip( newweaponobj, var_5ff04e1c4febf1f5, "right" );
        var_60d0ba0234acf87d = self getammotype( var_8af02df24ab529a4 );
        
        if ( altammotype == var_60d0ba0234acf87d )
        {
            self setweaponammostock( var_8af02df24ab529a4, altstockammo );
            self setweaponammoclip( var_8af02df24ab529a4, var_23ce0d9eafa8b81a, "left" );
            self setweaponammoclip( var_8af02df24ab529a4, var_d791feef173fa7f3, "right" );
        }
        
        wait 0.2;
        self playlocalsound( "attachment_pickup" );
        currentattachments = getweaponattachments( newweaponobj );
        attachmentindex = function_f02c63b99c9614c9( currentattachments, randomattachment );
        
        if ( !isdefined( attachmentindex ) )
        {
            assertmsg( "<dev string:xf8>" );
        }
        else
        {
            thread ammobox_showattachmentflyout( attachmentindex );
        }
        
        return true;
    }
    
    return false;
}

// Namespace ammo_box
// Params 1
// Checksum 0x5c7dc74e, Offset: 0x189c
// Size: 0x7b
function ammobox_showattachmentflyout( attachmentindex )
{
    self endon( #"disconnect" );
    pickupindex = attachmentindex + 1;
    
    if ( self.weaponpickupflyoutbit )
    {
        self.weaponpickupflyoutbit = undefined;
        pickupindex *= -1;
    }
    else
    {
        self.weaponpickupflyoutbit = 1;
    }
    
    self setclientomnvar( "ui_weapon_pickup", pickupindex );
    utility::waittill_any_timeout( 1, "death" );
    self setclientomnvar( "ui_weapon_pickup", 0 );
}

// Namespace ammo_box
// Params 0
// Checksum 0x528e3617, Offset: 0x191f
// Size: 0x1b
function ammobox_makedamageable()
{
    thread damage::monitordamage( 300, "hitequip", &ammobox_handlefataldamage, &ammobox_handledamage );
}

// Namespace ammo_box
// Params 1
// Checksum 0x6ae0aaef, Offset: 0x1942
// Size: 0xd0
function ammobox_handledamage( data )
{
    if ( data.meansofdeath == "MOD_IMPACT" )
    {
        return 0;
    }
    
    isenemydamage = !isdefined( self.owner ) || player_utility::playersareenemies( self.owner, data.attacker );
    hits = undefined;
    
    if ( isexplosivedamagemod( data.meansofdeath ) )
    {
        hits = ammobox_explosivedamagetohits( data, isenemydamage );
    }
    else if ( utility::isbulletdamage( data.meansofdeath ) )
    {
        hits = ammobox_bulletdamagetohits( data, isenemydamage );
    }
    
    if ( isdefined( hits ) )
    {
        return int( ceil( min( 1, hits / 20 ) * self.maxhealth ) );
    }
    
    return data.damage;
}

// Namespace ammo_box
// Params 1
// Checksum 0xd247e423, Offset: 0x1a1b
// Size: 0x25
function ammobox_handlefataldamage( data )
{
    ammobox_givepointsfordeath( data.attacker );
    thread ammobox_destroy();
}

// Namespace ammo_box
// Params 2
// Checksum 0x5532e165, Offset: 0x1a48
// Size: 0x9d
function ammobox_bulletdamagetohits( data, isenemydamage )
{
    basehits = damage::isfmjdamage( data.objweapon, data.meansofdeath ) && isenemydamage ? 2 : 0;
    
    if ( data.damage > 150 )
    {
        return ( basehits + 10 );
    }
    
    if ( data.damage >= 80 )
    {
        return ( basehits + 5 );
    }
    
    if ( data.damage >= 30 )
    {
        return ( basehits + 2 );
    }
    
    return basehits + 1;
}

// Namespace ammo_box
// Params 2
// Checksum 0x2ffa9e07, Offset: 0x1aed
// Size: 0x5a
function ammobox_explosivedamagetohits( data, isenemydamage )
{
    if ( data.damage > 200 )
    {
        return 20;
    }
    
    if ( data.damage > 70 )
    {
        return 10;
    }
    
    if ( data.damage > 30 )
    {
        return 7;
    }
    
    return 2;
}

// Namespace ammo_box
// Params 0
// Checksum 0x66a08f18, Offset: 0x1b4f
// Size: 0x20
function ammobox_removeowneroutline()
{
    if ( isdefined( self.outlineid ) )
    {
        outline::outlinedisable( self.outlineid, self );
    }
}

// Namespace ammo_box
// Params 0
// Checksum 0x6d962f83, Offset: 0x1b77
// Size: 0x3a
function ammobox_addheadicon()
{
    self.headiconbox = entityheadicons::setheadicon_singleimage( [], "hud_icon_fieldupgrade_weapon_drop", 20, 1, 1000, 100, undefined, 1 );
    self.headiconfaction = entityheadicons::setheadicon_equipment( self );
    support_box::supportbox_updateheadiconallplayers();
}

// Namespace ammo_box
// Params 0
// Checksum 0x4b0aec31, Offset: 0x1bb9
// Size: 0x50
function ammobox_removeheadicon()
{
    if ( isdefined( self.headiconbox ) )
    {
        entityheadicons::setheadicon_deleteicon( self.headiconbox );
        self.headiconbox = undefined;
    }
    
    if ( isdefined( self.headiconfaction ) )
    {
        entityheadicons::setheadicon_deleteicon( self.headiconfaction );
        self.headiconfaction = undefined;
    }
}

// Namespace ammo_box
// Params 1
// Checksum 0x88caa3f2, Offset: 0x1c11
// Size: 0x41
function ammobox_givepointsfordeath( attacker )
{
    if ( !isdefined( self.owner ) || player_utility::playersareenemies( self.owner, attacker ) )
    {
        attacker thread points::doscoreevent( #"destroyed_equipment" );
    }
}

// Namespace ammo_box
// Params 1
// Checksum 0x9e9072d8, Offset: 0x1c5a
// Size: 0x57
function ammobox_givexpforuse( player )
{
    if ( isdefined( self.owner ) && !player_utility::playersareenemies( self.owner, player ) )
    {
        if ( self.owner != player )
        {
            self.owner thread points::doscoreevent( #"hash_1854b1ca8856f504" );
        }
    }
}

// Namespace ammo_box
// Params 1
// Checksum 0x3fc194ec, Offset: 0x1cb9
// Size: 0x13
function ammobox_onmovingplatformdeath( data )
{
    ammobox_destroy();
}

// Namespace ammo_box
// Params 1
// Checksum 0x7a2bc5b3, Offset: 0x1cd4
// Size: 0x55
function ammobox_handlemovingplatforms( stuckto )
{
    data = spawnstruct();
    data.linkparent = stuckto;
    data.deathoverridecallback = &ammobox_onmovingplatformdeath;
    data.endonstring = "death";
    thread movers::handle_moving_platforms( data );
}

// Namespace ammo_box
// Params 0
// Checksum 0xe629420c, Offset: 0x1d31
// Size: 0x2f
function ammobox_watchdisownedtimeout()
{
    self endon( #"death" );
    ammobox_watchdisownedtimeoutinternal();
    
    if ( isdefined( self ) && !self.isdestroyed )
    {
        thread ammobox_destroy();
    }
}

// Namespace ammo_box
// Params 0
// Checksum 0xfb22e954, Offset: 0x1d68
// Size: 0x53
function ammobox_watchdisownedtimeoutinternal()
{
    self.owner endon( #"disconnect" );
    self.owner endon( #"joined_team" );
    self.owner endon( #"joined_spectators" );
    level endon( #"game_ended" );
    hostmigration::waitlongdurationwithhostmigrationpause( 60 );
}

// Namespace ammo_box
// Params 1
// Checksum 0x60018f5e, Offset: 0x1dc3
// Size: 0x13
function ammobox_empapplied( data )
{
    thread ammobox_destroy();
}

// Namespace ammo_box
// Params 2
// Checksum 0x7bee2386, Offset: 0x1dde
// Size: 0x1f
function ammobox_usedcallback( entity, player )
{
    thread ammobox_tryuse( entity, player );
}

// Namespace ammo_box
// Params 2
// Checksum 0x8a3f459, Offset: 0x1e05
// Size: 0x4d
function ammobox_tryuse( entity, player )
{
    if ( player.isusingammobox )
    {
        return;
    }
    
    player.isusingammobox = 1;
    ammobox_tryuseinternal( entity, player );
    
    if ( isdefined( player ) )
    {
        player.isusingammobox = undefined;
    }
}

// Namespace ammo_box
// Params 2
// Checksum 0x705aca4c, Offset: 0x1e5a
// Size: 0x28e
function ammobox_tryuseinternal( entity, player )
{
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    entity endon( #"death" );
    starttime = gettime();
    usebuttonheld = 1;
    
    while ( gettime() - starttime < 500 )
    {
        if ( !player usebuttonpressed() )
        {
            usebuttonheld = 0;
            break;
        }
        
        waitframe();
    }
    
    if ( player.isjuggernaut )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            player [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"killstreaks/jugg_cannot_be_used" );
        }
        
        return;
    }
    
    if ( !entity ammobox_playercanuse( player ) )
    {
        return;
    }
    
    result = undefined;
    
    if ( usebuttonheld )
    {
        result = entity ammobox_onplayerholduse( player );
    }
    else
    {
        result = entity ammobox_onplayeruse( player );
    }
    
    if ( result )
    {
        if ( isdefined( entity.owner ) )
        {
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( entity.owner ) ) )
            {
                if ( isdefined( entity.owner.leaderboarddata[ "ammoBoxUsed" ] ) )
                {
                    entity.owner.leaderboarddata[ "ammoBoxUsed" ] = entity.owner.leaderboarddata[ "ammoBoxUsed" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "ammoBoxUsed" ] ) )
                {
                    [[ level.leaderboardfunc[ "ammoBoxUsed" ] ]]( entity.owner, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x122>" );
                
                if ( isdefined( entity.owner.pers[ "ammoBoxUsed" ] ) )
                {
                    entity.owner.pers[ "ammoBoxUsed" ] = entity.owner.pers[ "ammoBoxUsed" ] + 1;
                }
            }
            
            entity.owner supers_mp::combatrecordsupermisc( "super_weapon_drop" );
        }
        
        entity.usedcount++;
        entity.playersused[ player getentitynumber() ] = player;
        entity support_box::supportbox_updateheadicon( player );
        entity ammobox_givexpforuse( player );
    }
}

/#

    // Namespace ammo_box
    // Params 0
    // Checksum 0xc61ca5d1, Offset: 0x20f0
    // Size: 0x8c, Type: dev
    function function_85adfac28e31117c()
    {
        setdevdvar( @"hash_dda56d67bc308c3e", 0 );
        
        while ( true )
        {
            if ( getdvarint( @"hash_dda56d67bc308c3e" ) != 0 )
            {
                setdevdvar( @"hash_dda56d67bc308c3e", 0 );
                
                if ( level.players.size < 1 )
                {
                    iprintlnbold( "<dev string:x148>" );
                    continue;
                }
                
                firstplayer = level.players[ 0 ];
                objweapon = firstplayer getcurrentweapon();
                firstplayer ammobox_giverandomattachment( objweapon );
            }
            
            waitframe();
        }
    }

#/
