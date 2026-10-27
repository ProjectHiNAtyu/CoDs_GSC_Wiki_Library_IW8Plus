// scripts\mp\common\equipment\adrenaline.gsc  (hash_75be2c45d5dd5a6c.gscc) (size: 11336 Bytes / 0x2c48 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa7610142 (2808152386)
// size ...... 11336 (0x2c48)
// includes .. 22  (offset: 0x2a60)
// strings ... 17  (offset: 0x2b10)
// dev strs .. 3   (offset: 0x2c20)
// exports ... 22  (offset: 0x19f0)
// cseg ...... 0x15d + 0x1893 (0x19f0)
// imports ... 110 (offset: 0x1d60)
// animtree1 . 0   (offset: 0x2c48)
// animtree2 . 0   (offset: 0x2c48)
#using script_74b851b7aa1ef32d;
#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\common\equipment_common;
#using scripts\common\shellshock_utility;
#using scripts\common\status_effects\status_tracking;
#using scripts\common\utility;
#using scripts\mp\challenges;
#using scripts\mp\common\equipment\debuff_util;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\emp_debuff;
#using scripts\mp\equipment;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\common;
#using scripts\mp\health_chunks;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_backpack_consumable;
#using scripts\mp\playerhealth;
#using scripts\mp\talking_gun;
#using scripts\mp\telemetry_mp;
#using scripts\mp\weapons;

#namespace adrenaline;

// Namespace adrenaline
// Params 0, eflags: 0x1
// Checksum 0x26420823, Offset: 0x17b
// Size: 0x18
function autoexec main()
{
    level callback::add( #"equipment_init", &adrenaline_init );
}

// Namespace adrenaline
// Params 1
// Checksum 0xaa370734, Offset: 0x19b
// Size: 0x4ed
function adrenaline_init( params )
{
    adrenalinebundle = equipment_mp::function_c90a9aa89b223dd7( "equip_adrenaline" );
    level.adrenalinesettings = {};
    level.adrenalinesettings.healingrate = adrenalinebundle.var_bb29895c3faff1cb ?? 160;
    level.adrenalinesettings.healdelay = adrenalinebundle.var_5025d4ca9f4cba3c ?? 0;
    level.adrenalinesettings.var_eda22c68624dc5a9 = adrenalinebundle.var_baac991c9e0659e6 ?? 0.03;
    level.adrenalinesettings.var_8490b6e9e7bd449c = adrenalinebundle.var_692989684b036199 ? adrenalinebundle.var_8128ad33c3e4ebc8 ?? 0.03 : level.adrenalinesettings.var_eda22c68624dc5a9;
    level.adrenalinesettings.var_ee2b8e5bbb1eafba = adrenalinebundle.var_7e5932481ecad49e ?? 5;
    level.adrenalinesettings.duration = adrenalinebundle.adrenaline_duration ?? 1;
    level.adrenalinesettings.var_8472c8f25aa97105 = adrenalinebundle.var_2c0f5710df0cb961 ?? 5;
    level.adrenalinesettings.speedsuit = adrenalinebundle.var_869c6eb7541ddcb1;
    level.adrenalinesettings.lootid = adrenalinebundle.lootid;
    level.adrenalinesettings.var_e0782c1878e8614d = adrenalinebundle.var_893209c7d24000ab ?? #"hash_95d183c8c1031543";
    level.adrenalinesettings.var_5639f33ce00d26f = utility::function_48f723fdc612ec65( @"hash_89f237ca61667415", 0.6, adrenalinebundle.var_4afde7cfeace1e62 );
    
    if ( level.adrenalinesettings.var_e0782c1878e8614d == #"hash_9ffa0ab20d4a8815" )
    {
        if ( function_985d3d3463cfc510( #"hash_e230937b3df8064b" ) )
        {
            level.adrenalinesettings.var_e0782c1878e8614d = #"hash_95d183c8c1031543";
        }
        
        if ( level.adrenalinesettings.var_e0782c1878e8614d == #"hash_9ffa0ab20d4a8815" )
        {
            level.adrenalinesettings.var_325e62660a466f46 = adrenalinebundle.var_5b060df359752fc7 ?? 0.5;
            
            if ( level.adrenalinesettings.var_325e62660a466f46 < 0 )
            {
                level.adrenalinesettings.var_325e62660a466f46 = level.adrenalinesettings.healdelay;
            }
            
            assert( level.adrenalinesettings.var_325e62660a466f46 >= 0 );
        }
    }
    
    var_1c85ba908305cc4b = getdvarint( @"hash_3b85029cf1af7129", -1 );
    var_5f931e73865a6956 = getdvarint( @"hash_d94cba8f8128ba00", -1 );
    
    if ( var_1c85ba908305cc4b >= 0 )
    {
        level.adrenalinesettings.healingrate = var_1c85ba908305cc4b;
    }
    
    if ( var_5f931e73865a6956 >= 0 )
    {
        level.adrenalinesettings.healdelay = var_5f931e73865a6956;
    }
    
    equipment_mp::registercallback( "equip_adrenaline", "onFired", &onequipmentfired );
    equipment_mp::registercallback( "equip_adrenaline", "onTake", &onequipmenttaken );
    
    if ( level.var_47dc93bc4166ba18 )
    {
        foreach ( entry in adrenalinebundle.var_8f21800662496353 )
        {
            var_c42d0bfe9ef2e956 = level.equipment.protable[ getxhashasset( entry.proasset ) ].bundle;
            equipment_mp::registercallback( var_c42d0bfe9ef2e956.var_a4f8ae3bf93f2bee, "onFired", &onequipmentfired );
            equipment_mp::registercallback( var_c42d0bfe9ef2e956.var_a4f8ae3bf93f2bee, "onTake", &onequipmenttaken );
        }
    }
    
    utility::registersharedfunc( #"adrenaline", #"hash_180f842b74797065", &gethealthpersec );
    thread utility::callsharedfunc( #"analytics", #"hash_eb9d0dae8f38111f", { #customend:1, #customstart:1, #equipref:"equip_adrenaline" } );
    level callback::add( #"game_ended", &ongameended );
    level callback::add( #"player_laststand_death", &function_2f9a54ccc96fd099 );
}

// Namespace adrenaline
// Params 0, eflags: 0x4
// Checksum 0x46051acc, Offset: 0x690
// Size: 0x15
function private gethealthpersec()
{
    return level.adrenalinesettings.healingrate;
}

// Namespace adrenaline
// Params 3, eflags: 0x4
// Checksum 0x28ee88b3, Offset: 0x6ae
// Size: 0x14d
function private onequipmentfired( equipmentref, slot, objweapon )
{
    self painvisionoff();
    adrenalinebundle = equipment_mp::getEquipmentBundleFromWeaponName( objweapon.basename );
    
    if ( adrenalinebundle.var_bf567eca025ceda3 && isdefined( adrenalinebundle.var_bbc10c7647ec8d58 ) )
    {
        pbgpostfxbundlestart( self, adrenalinebundle.var_bbc10c7647ec8d58 );
    }
    
    if ( self isthrowingbackgrenade() )
    {
        self function_4bdf2fa26c2d815d();
        
        if ( isdefined( objweapon ) )
        {
            ammo = self getweaponammoclip( objweapon );
            newammo = int( max( ammo - 1, 0 ) );
            self setweaponammoclip( objweapon, newammo );
        }
    }
    
    eventdata = utility::callsharedfunc( #"analytics", #"hash_22a37c3ed1cf5035", { #equipref:equipmentref, #attacker:self, #einflictor:objweapon } );
    useadrenaline( equipmentref, objweapon );
    thread utility::callsharedfunc( #"analytics", #"hash_e348d92f8fdade0c", { #position:self.origin, #attacker:self, #eventid:eventdata.eventid } );
}

// Namespace adrenaline
// Params 2, eflags: 0x4
// Checksum 0x14cf4096, Offset: 0x803
// Size: 0x581, Type: bool
function private useadrenaline( equipmentref, adrenalineweapon )
{
    self endon( #"disconnect" );
    self notify( #"end_explosiveregenhalt" );
    self notify( #"hash_8b605d80865f1bc5" );
    self notify( #"hash_c4700f9ace6b3e19" );
    adrenalinebundle = equipment_mp::function_c90a9aa89b223dd7( equipmentref );
    
    if ( adrenalinebundle.var_c7709714d768097c && adrenalineweapon hasattachmenthash( adrenalinebundle.var_c7709714d768097c ) )
    {
        thread shellshock_utility::_stopshellshock();
        player::hidehudclear();
        emp_debuff::clear_emp();
        emp_debuff::clear_emp_scramble();
        
        if ( self.ksempd )
        {
            utility::callsharedfunc( #"emp", #"hash_6781b1898af33d91" );
        }
        
        var_35a846a6bc3711bd = adrenalinebundle.var_498e4d5abade4e71 ?? 3;
        thread debuff_util::function_780612a55bca1527( var_35a846a6bc3711bd );
        
        if ( adrenalinebundle.var_2d86725d99bc8890 )
        {
            thread debuff_util::function_737a6ab503796ece( var_35a846a6bc3711bd );
        }
    }
    
    if ( adrenalinebundle.var_2489f5a1752e9cb3 || adrenalinebundle.var_e36b84555e7df1d3 && adrenalineweapon hasattachmenthash( adrenalinebundle.var_e36b84555e7df1d3 ) )
    {
        thread speedboost( adrenalinebundle );
    }
    
    if ( level.adrenalinesettings.var_e0782c1878e8614d == #"hash_9ffa0ab20d4a8815" )
    {
        thread function_f299f0cd4e2178a1( adrenalinebundle.var_575703d6c4d54130 ?? 8 );
    }
    
    self refreshsprinttime();
    talking_gun::talkinggun_event( self, #"self_apply" );
    
    if ( !isai( self ) )
    {
        self playsoundtoplayer( "plr_stim_shot", self, self );
    }
    
    status_tracking::function_820d05797324eca0( self, #"adrenaline_used_recently" );
    thread status_tracking::function_67efe0a002b0b0a5( self, #"adrenaline_used_recently", 2 );
    status_tracking::function_820d05797324eca0( self, #"adrenaline_active" );
    thread status_tracking::function_be3ac604aeea243c( self, #"adrenaline_active", self, #"hash_6752b3d195492f9e" );
    thread lifetimemanager( adrenalineweapon );
    self notify( #"adrenaline_used" );
    callback::callback( #"on_adrenaline_used" );
    thread gamelogic_mp::threadedsetweaponstatbyname( adrenalineweapon, 1, "shots" );
    wait level.adrenalinesettings.healdelay;
    
    if ( self.health > 0 && self.health < self.maxhealth || level.adrenalinesettings.var_e0782c1878e8614d == #"hash_9ffa0ab20d4a8815" )
    {
        challenges::function_3d7a169dbae062fb( equipmentref, self, undefined, ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"use" ) );
        self.var_4d4846a416f04721 = self.health;
        playerhealth::function_bdfdee3e2bcb10d8( &function_66a1524e828ee51e );
        
        if ( level.adrenalinesettings.var_e0782c1878e8614d == #"hash_95d183c8c1031543" )
        {
            if ( !callback::exists( #"hash_42a51c712c475d6", &onfullhealth ) )
            {
                callback::add( #"hash_42a51c712c475d6", &onfullhealth );
            }
        }
        
        if ( !callback::exists( #"player_damaged", &ondamagetaken ) )
        {
            callback::add( #"player_damaged", &ondamagetaken );
        }
        
        foreach ( attacker in self.attackers )
        {
            if ( attacker == self )
            {
                continue;
            }
            
            hasattacker = 1;
            break;
        }
        
        if ( hasattacker )
        {
            if ( isdefined( level.sharedfuncs[ #"radiation" ][ #"hash_4a15807eba7b42d9" ] ) )
            {
                inradiation = [[ level.sharedfuncs[ #"radiation" ][ #"hash_4a15807eba7b42d9" ] ]]( self.origin );
            }
            
            if ( !inradiation )
            {
                namespace_5f4bb62dbf67ff87::doonactionscoreevent( 0, "adrenalineHeal", 15, { #objweapon:adrenalineweapon } );
            }
        }
        
        utility::function_a9cdce367aa4fef5( #"hash_29a97a3a45b445e4", 2, #"death_or_disconnect" );
    }
    
    self.var_cf4cee668305d845 = 0;
    
    if ( common_item::items_isenabled() && health_chunks::isenabled() )
    {
        itembundle = common_item::function_b202b16941992cca( level.adrenalinesettings.lootid );
        thread item_backpack_consumable::function_eddb0aeb3f2d9019( undefined, itembundle, level.adrenalinesettings.lootid, 1 );
    }
    
    if ( adrenalinebundle.var_9bea1715f015b0c8 && self.health >= self.maxhealth )
    {
        overcharge_amount = adrenalinebundle.var_68ad2fc8f9274bf8 ?? 50;
        utility::callsharedfunc( #"health", #"hash_291dc25cfb86af01", self, equipmentref, overcharge_amount );
    }
    
    self.adrenalinepoweractive = 1;
    
    if ( self.health > 0 && self.health < self.maxhealth )
    {
        callbackparams = { #regenspeedmod:1 };
        callback::callback( #"hash_83a1950e73246811", callbackparams );
        playerhealth::forcehealthregen( self, undefined, callbackparams.regenspeedmod );
    }
    
    gamelogic_mp::sethasdonecombat( self, 1 );
    return true;
}

// Namespace adrenaline
// Params 1, eflags: 0xc
// Checksum 0xe4c5b783, Offset: 0xd8d
// Size: 0x14a
function private lifetimemanager( adrenalineweapon )
{
    self notify( #"hash_149d2871fbb88f67" );
    self endon( #"hash_149d2871fbb88f67" );
    self endon( #"disconnect" );
    
    if ( !callback::exists( #"hash_244314ef9125e636", &function_a34aef984160a893 ) )
    {
        callback::add( #"hash_244314ef9125e636", &function_a34aef984160a893 );
        callback::add( #"hash_d878d6ba342dc1b", &function_d3c1ffdaa4969af2 );
    }
    
    utility::waittill_any_timeout( 2, #"death" );
    callback::remove( #"hash_244314ef9125e636", &function_a34aef984160a893 );
    callback::remove( #"hash_d878d6ba342dc1b", &function_d3c1ffdaa4969af2 );
    
    if ( level.adrenalinesettings.var_e0782c1878e8614d == #"hash_95d183c8c1031543" )
    {
        callback::remove( #"hash_42a51c712c475d6", &onfullhealth );
        callback::remove( #"player_damaged", &ondamagetaken );
    }
    
    if ( self.adrenalinekills >= 2 )
    {
        thread points::doscoreevent( #"double_stim", adrenalineweapon );
        self.adrenalinekills = undefined;
    }
    
    if ( level.adrenalinesettings.var_e0782c1878e8614d == #"hash_95d183c8c1031543" )
    {
        removeadrenaline();
    }
}

// Namespace adrenaline
// Params 2, eflags: 0x4
// Checksum 0x91877f0c, Offset: 0xedf
// Size: 0x1c
function private onequipmenttaken( equipmentref, slot )
{
    removeadrenaline();
}

// Namespace adrenaline
// Params 0, eflags: 0x4
// Checksum 0xbc99e5c7, Offset: 0xf03
// Size: 0x97
function private removeadrenaline()
{
    self notify( #"hash_6752b3d195492f9e" );
    self.adrenalinepoweractive = undefined;
    self.var_cf4cee668305d845 = undefined;
    
    if ( self.var_4d4846a416f04721 && self.health - self.var_4d4846a416f04721 >= 10 )
    {
        challenges::function_3d7a169dbae062fb( "equip_adrenaline", self, undefined, ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"end" ), self.health - self.var_4d4846a416f04721 );
    }
    
    self.var_4d4846a416f04721 = undefined;
    playerhealth::function_bb4ad93e7c8b503( &function_66a1524e828ee51e );
}

// Namespace adrenaline
// Params 1, eflags: 0x4
// Checksum 0x16bd42b0, Offset: 0xfa2
// Size: 0x171
function private function_66a1524e828ee51e( amounthealed )
{
    adrenalineweapon = self.var_e6d8cfcc28a79324[ "secondary" ];
    
    if ( !adrenalineweapon )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    if ( isdefined( self.var_cf4cee668305d845 ) )
    {
        self.var_cf4cee668305d845 += amounthealed;
        
        if ( self.var_cf4cee668305d845 >= 10 )
        {
            if ( getcodegate( #"hash_2a0fdaf2d3f83dd3" ) )
            {
                lastheal = gettime();
                bundle = equipment::function_3637cad9a44ab42( "equip_adrenaline" );
                
                if ( bundle.var_153f17041a32dd7c > 0 )
                {
                    timeout_ms = bundle.var_153f17041a32dd7c * 1000;
                    
                    if ( isdefined( self.lastdamagedtime ) && lastheal - self.lastdamagedtime < timeout_ms )
                    {
                        var_b52c60914e97b097 = 1;
                    }
                }
                
                challengeparams = { #var_b52c60914e97b097:var_b52c60914e97b097, #equipmentref:"equip_adrenaline", #amounthealed:self.var_cf4cee668305d845, #player:self };
                callback::callback( #"on_heal", challengeparams );
            }
            
            self.var_cf4cee668305d845 = undefined;
            thread points::doscoreevent( #"hash_2ee002365969d014", adrenalineweapon );
        }
    }
    
    thread gamelogic_mp::threadedsetweaponstatbyname( adrenalineweapon, amounthealed, "buff_assists" );
}

// Namespace adrenaline
// Params 0, eflags: 0x4
// Checksum 0xb84cc860, Offset: 0x111b
// Size: 0x9
function private function_3ac491257714db42()
{
    removeadrenaline();
}

// Namespace adrenaline
// Params 1, eflags: 0x4
// Checksum 0xe1fd4379, Offset: 0x112c
// Size: 0x9a
function private ongameended( params )
{
    foreach ( player in level.players )
    {
        if ( status_tracking::statusactive( player, player, #"adrenaline_active" ) )
        {
            player function_3ac491257714db42();
        }
    }
}

// Namespace adrenaline
// Params 1, eflags: 0xc
// Checksum 0x6901fa1d, Offset: 0x11ce
// Size: 0x225
function private speedboost( bundle )
{
    self notify( #"hash_5cd89780885c2f3" );
    self endon( #"hash_5cd89780885c2f3" );
    self notify( #"hash_61d980afe5f6f4de" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( !common::function_8ff835bf23198a0( "adrenaline" ) )
    {
        common::function_ac4bf3256b2545e3( "adrenaline", 0 );
    }
    else
    {
        common::function_a0f5c85d465c5f0a( "adrenaline", 0 );
    }
    
    self.var_923f8270632d115c = 0;
    
    if ( bundle.var_efdf5a135934f2e8 )
    {
        thread suitupdate();
    }
    
    self lerpfovbypreset( "zombiedefault" );
    self setclientomnvar( "ui_speedboost_overlay", 0 );
    
    for ( i = 0; i < level.adrenalinesettings.var_ee2b8e5bbb1eafba ; i++ )
    {
        common::function_473eb5f3e0662540( "adrenaline", level.adrenalinesettings.var_8490b6e9e7bd449c );
        self.var_923f8270632d115c += level.adrenalinesettings.var_8490b6e9e7bd449c;
        weapons::updatemovespeedscale();
        wait 0.2;
    }
    
    wait level.adrenalinesettings.duration;
    self lerpfovbypreset( "default_2seconds" );
    
    if ( isdefined( level.sharedfuncs[ #"super_deadsilence" ][ #"endhudsequence" ] ) )
    {
        self [[ level.sharedfuncs[ #"super_deadsilence" ][ #"endhudsequence" ] ]]();
    }
    
    for ( i = 0; i < level.adrenalinesettings.var_8472c8f25aa97105 ; i++ )
    {
        common::function_473eb5f3e0662540( "adrenaline", level.adrenalinesettings.var_eda22c68624dc5a9 * -1 );
        self.var_923f8270632d115c -= level.adrenalinesettings.var_eda22c68624dc5a9;
        weapons::updatemovespeedscale();
        wait 0.2;
    }
    
    common::function_d85a92c557ea5a52( "adrenaline" );
    weapons::updatemovespeedscale();
    self.var_923f8270632d115c = undefined;
}

// Namespace adrenaline
// Params 0, eflags: 0x4
// Checksum 0x9caed64c, Offset: 0x13fb
// Size: 0x131
function private suitupdate()
{
    if ( isdefined( level.sharedfuncs[ #"gametype" ][ #"hash_50796d7d1b7c251a" ] ) )
    {
        self [[ level.sharedfuncs[ #"gametype" ][ #"hash_50796d7d1b7c251a" ] ]]();
        return;
    }
    
    self notify( #"hash_78ff16d7864f9a7e" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    prevsuit = self.suit;
    adrenalinesuit = utility::function_e02da4fab371fbcf();
    player::_setsuit( adrenalinesuit );
    
    /#
        iprintln( "<dev string:xab>" + self.suit + "<dev string:xb2>" + prevsuit );
    #/
    
    self endon( #"hash_78ff16d7864f9a7e" );
    utility::waittill_any_ents_or_timeout_return( level.adrenalinesettings.duration, self, "death" );
    
    if ( self.suit == adrenalinesuit )
    {
        if ( prevsuit == utility::function_f825237e0eda5adf() )
        {
            player::_setsuit( prevsuit );
        }
        else if ( prevsuit == adrenalinesuit )
        {
            player::_setsuit( prevsuit );
        }
    }
    
    /#
        iprintln( "<dev string:xab>" + self.suit );
    #/
}

// Namespace adrenaline
// Params 1, eflags: 0x4
// Checksum 0xc6babbfa, Offset: 0x1534
// Size: 0x2d
function private onfullhealth( params )
{
    playerhealth::function_bb4ad93e7c8b503( &function_66a1524e828ee51e );
    callback::remove( #"hash_42a51c712c475d6", &onfullhealth );
}

// Namespace adrenaline
// Params 1, eflags: 0x4
// Checksum 0xb3329137, Offset: 0x1569
// Size: 0xeb
function private ondamagetaken( damagedata )
{
    if ( isbrgamemode() && ( damagedata.smeansofdeath == "MOD_TRIGGER_HURT" || damagedata.smeansofdeath == "MOD_UNKNOWN" ) )
    {
        return;
    }
    
    switch ( level.adrenalinesettings.var_e0782c1878e8614d )
    {
        case #"hash_95d183c8c1031543":
        default:
            damagedata.victim playerhealth::function_bb4ad93e7c8b503( &function_66a1524e828ee51e );
            damagedata.victim callback::remove( #"player_damaged", &ondamagetaken );
            break;
        case #"hash_9ffa0ab20d4a8815":
            damagedata.victim thread playerhealth::forcehealthregendelay( damagedata.victim, 0, level.adrenalinesettings.var_325e62660a466f46 );
            break;
    }
}

// Namespace adrenaline
// Params 1, eflags: 0x4
// Checksum 0x4894f12, Offset: 0x165c
// Size: 0x5f
function private function_f299f0cd4e2178a1( duration )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( !callback::exists( #"player_death", &function_41a3b0b744556508 ) )
    {
        callback::add( #"player_death", &function_41a3b0b744556508 );
    }
    
    wait duration;
    
    if ( self )
    {
        stopadrenaline();
    }
}

// Namespace adrenaline
// Params 1, eflags: 0x4
// Checksum 0xfc83a04, Offset: 0x16c3
// Size: 0x20
function private function_41a3b0b744556508( params )
{
    profilestart();
    params.victim stopadrenaline();
    profilestop();
}

// Namespace adrenaline
// Params 0, eflags: 0x4
// Checksum 0x4a8cc0fa, Offset: 0x16eb
// Size: 0x56
function private stopadrenaline()
{
    profilestart();
    playerhealth::function_bb4ad93e7c8b503( &function_66a1524e828ee51e );
    callback::remove( #"hash_42a51c712c475d6", &onfullhealth );
    callback::remove( #"player_damaged", &ondamagetaken );
    callback::remove( #"player_death", &function_41a3b0b744556508 );
    removeadrenaline();
    profilestop();
}

// Namespace adrenaline
// Params 1, eflags: 0x4
// Checksum 0x91527be5, Offset: 0x1749
// Size: 0xf3
function private function_2f9a54ccc96fd099( deathdata )
{
    downer = deathdata.downedby;
    
    if ( !downer.var_e9e48c11dfcafd0a || !arraycontains( downer.var_e9e48c11dfcafd0a, deathdata.victim ) )
    {
        return;
    }
    
    victim = deathdata.victim;
    downer.var_e9e48c11dfcafd0a = arrayremove( downer.var_e9e48c11dfcafd0a, victim );
    
    if ( !downer.var_e9e48c11dfcafd0a.size )
    {
        downer.var_e9e48c11dfcafd0a = undefined;
    }
    
    adrenalineweapon = downer.var_e6d8cfcc28a79324[ "secondary" ];
    downer thread points::doscoreevent( #"hash_dacd1969cd263815", adrenalineweapon );
    downer thread gamelogic_mp::threadedsetweaponstatbyname( adrenalineweapon, 1, "buff_kills" );
    victim thread gamelogic_mp::threadedsetweaponstatbyname( adrenalineweapon, 1, "killed_by", undefined, downer );
}

// Namespace adrenaline
// Params 1, eflags: 0x4
// Checksum 0x9beeb53c, Offset: 0x1844
// Size: 0x80
function private function_d3c1ffdaa4969af2( downeddata )
{
    downer = downeddata.attacker;
    downer.adrenalinekills = ( downer.adrenalinekills ?? 0 ) + 1;
    
    if ( !isdefined( downer.var_e9e48c11dfcafd0a ) )
    {
        downer.var_e9e48c11dfcafd0a = [];
    }
    
    downer.var_e9e48c11dfcafd0a[ downer.var_e9e48c11dfcafd0a.size ] = downeddata.victim;
}

// Namespace adrenaline
// Params 1, eflags: 0x4
// Checksum 0x710853ba, Offset: 0x18cc
// Size: 0x124
function private function_a34aef984160a893( deathdata )
{
    attacker = deathdata.attacker;
    victim = deathdata.victim;
    var_c12dab43886044d9 = deathdata.attacker.var_2bee526696230275[ #"adrenaline_used_recently" ];
    
    if ( !isdefined( var_c12dab43886044d9 ) || attacker == victim )
    {
        return;
    }
    
    adrenalineweapon = attacker.var_e6d8cfcc28a79324[ "secondary" ];
    attacker thread points::doscoreevent( #"hash_dacd1969cd263815", adrenalineweapon );
    attacker.var_ecbbdda6352284db = 1;
    
    if ( !attacker.var_e9e48c11dfcafd0a || !arraycontains( attacker.var_e9e48c11dfcafd0a, victim ) )
    {
        attacker.adrenalinekills = ( attacker.adrenalinekills ?? 0 ) + 1;
        attacker thread gamelogic_mp::threadedsetweaponstatbyname( adrenalineweapon, 1, "buff_kills" );
        attacker telemetry_mp::function_89a5d8fb8ed3a4fe( undefined, attacker, var_c12dab43886044d9, adrenalineweapon );
        victim thread gamelogic_mp::threadedsetweaponstatbyname( adrenalineweapon, 1, "killed_by", undefined, attacker );
    }
}

