// scripts\mp\gametypes\obj_killdrop.gsc  (hash_34f07e700cc942a5.gscc) (size: 24221 Bytes / 0x5e9d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc1839793 (3246626707)
// size ...... 24221 (0x5e9d)
// includes .. 11  (offset: 0x5ad9)
// strings ... 50  (offset: 0x5b31)
// dev strs .. 15  (offset: 0x5de5)
// exports ... 55  (offset: 0x3f09)
// cseg ...... 0x3b1 + 0x3b58 (0x3f09)
// imports ... 157 (offset: 0x47a1)
// animtree1 . 0   (offset: 0x5e9d)
// animtree2 . 0   (offset: 0x5e9d)
#using scripts\common\callbacks;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\points;
#using scripts\mp\damagefeedback;
#using scripts\mp\flags;
#using scripts\mp\loot\common_item;
#using scripts\mp\matchdata;

#namespace killdrop;

// Namespace killdrop
// Params 0, eflags: 0x1
// Checksum 0xa59de991, Offset: 0x3cf
// Size: 0x3f
function autoexec main()
{
    level callback::add( #"init_shared_func", &init );
    
    if ( getdvarint( @"scr_enable_killdrop_pinata", 0 ) )
    {
        level callback::add( #"hash_35e8c753e3a178cc", &function_e927db442d59ccb );
    }
}

// Namespace killdrop
// Params 1
// Checksum 0xce4022b2, Offset: 0x416
// Size: 0x189
function init( params )
{
    iszm = utility::iszm();
    
    if ( isdefined( level.sharedfuncs[ #"hash_fb941646c46755dd" ][ #"hash_c5ce315e6202408d" ] ) )
    {
        self [[ level.sharedfuncs[ #"hash_fb941646c46755dd" ][ #"hash_c5ce315e6202408d" ] ]]( params );
    }
    else if ( iszm )
    {
        level callback::add( "on_zombie_ai_killed", &onplayerdeath );
    }
    else
    {
        level callback::add( #"player_death", &onplayerdeath );
    }
    
    var_b77196d7f4482771 = level.gametypebundle.killdropbundle;
    
    if ( !var_b77196d7f4482771 )
    {
        return;
    }
    
    var_ebe17497781d41a1 = function_924b79a57af177d6();
    var_2c0a656dc113b5c = function_e8f076684742eadf();
    
    if ( !iszm && getdvarint( @"hash_42792771f38f9a84", 0 ) || iszm && getdvarint( @"hash_746a08d1d33d7aa4", 0 ) || getdvarint( @"scr_enable_killdrop_pinata", 0 ) )
    {
        function_cf89378d072ff892( var_b77196d7f4482771, var_ebe17497781d41a1, var_2c0a656dc113b5c, getdvarint( @"hash_bf7bd8dc1bea2332", 0 ) );
    }
    
    if ( !isdefined( level.var_c0085c8f54739e73 ) )
    {
        level.var_c0085c8f54739e73 = &spawnkilldrop;
    }
    
    level.var_70237f9b8c8ecc5d = &function_1f2b9af3c18c5f1b;
    
    if ( !isdefined( level.var_fc0b690d3a12b77b ) )
    {
        level.var_fc0b690d3a12b77b = [];
    }
    
    scriptable::scriptable_adddamagedcallback( &function_d4c5711682338df4 );
    
    /#
        level thread function_1ce0018dd49b2050();
    #/
}

// Namespace killdrop
// Params 4
// Checksum 0xca1daadb, Offset: 0x5a7
// Size: 0x42e
function function_cf89378d072ff892( bundlexhash, var_ebe17497781d41a1, var_2c0a656dc113b5c, var_4830ebfcbafaca03 = 0 )
{
    killdropbundle = getscriptbundle( bundlexhash );
    
    if ( killdropbundle )
    {
        var_a343ce1c83a4039 = [];
        var_6326f4006972c983 = 0;
        
        foreach ( killdropsetting in killdropbundle.var_a343ce1c83a4039 )
        {
            if ( var_4830ebfcbafaca03 == killdropsetting.poolindex )
            {
                if ( killdropsetting.loopingfx )
                {
                    level._effect[ killdropsetting.loopingfx ] = loadfxasset( killdropsetting.loopingfx );
                }
                
                if ( killdropsetting.pickupfx )
                {
                    level._effect[ killdropsetting.pickupfx ] = loadfxasset( killdropsetting.pickupfx );
                }
                
                if ( killdropsetting.expirefx )
                {
                    level._effect[ killdropsetting.expirefx ] = loadfxasset( killdropsetting.expirefx );
                }
                
                if ( killdropsetting.omnvarstringref )
                {
                    thread function_e8b770144a9de60( killdropsetting.omnvarstringref );
                }
                
                subchance = killdropsetting.var_211ec60954c114d5 ?? 0.3;
                dropamount = killdropsetting.dropamount ?? 1;
                
                if ( killdropsetting.stringref && killdropsetting.stringref != "" )
                {
                    if ( var_ebe17497781d41a1 && isnumber( var_ebe17497781d41a1[ killdropsetting.stringref ] ) )
                    {
                        subchance = var_ebe17497781d41a1[ killdropsetting.stringref ];
                    }
                    
                    if ( var_2c0a656dc113b5c && isnumber( var_2c0a656dc113b5c[ killdropsetting.stringref ] ) )
                    {
                        dropamount = var_2c0a656dc113b5c[ killdropsetting.stringref ];
                    }
                }
                
                killdropsetting.var_10d453f641168dd6 = subchance;
                killdropsetting.dropamount = dropamount;
                var_6326f4006972c983 += killdropsetting.var_10d453f641168dd6;
                var_a343ce1c83a4039[ var_a343ce1c83a4039.size ] = killdropsetting;
            }
        }
        
        level.killdrops[ bundlexhash ] = {};
        level.killdrops[ bundlexhash ].settinglist = var_a343ce1c83a4039;
        level.killdrops[ bundlexhash ].var_9d3459eaaf0322c = var_6326f4006972c983;
        level.killdrops[ bundlexhash ].bundle = killdropbundle;
    }
    
    if ( getdvarint( @"scr_enable_killdrop_pinata", 0 ) && killdropbundle.var_a860d936e9d88401 )
    {
        level.killdroppinata = spawnstruct();
        
        if ( killdropbundle.var_27cd95bc7b5fa220 )
        {
            level._effect[ killdropbundle.var_27cd95bc7b5fa220 ] = loadfxasset( killdropbundle.var_27cd95bc7b5fa220 );
        }
        
        if ( killdropbundle.pinataspawnvfx )
        {
            level._effect[ killdropbundle.pinataspawnvfx ] = loadfxasset( killdropbundle.pinataspawnvfx );
        }
        
        if ( killdropbundle.var_93f364ce102a7e7d )
        {
            level._effect[ killdropbundle.var_93f364ce102a7e7d ] = loadfxasset( killdropbundle.var_93f364ce102a7e7d );
        }
        
        if ( killdropbundle.var_5a59e1e01efa7f63 )
        {
            level._effect[ killdropbundle.var_5a59e1e01efa7f63 ] = loadfxasset( killdropbundle.var_5a59e1e01efa7f63 );
        }
        
        level thread function_d44b1ec8ad2b6cf6( killdropbundle, level.killdrops[ bundlexhash ] );
    }
    
    if ( isdefined( level.sharedfuncs[ #"hash_fb941646c46755dd" ][ #"hash_80c31d3f012c074d" ] ) )
    {
        self [[ level.sharedfuncs[ #"hash_fb941646c46755dd" ][ #"hash_80c31d3f012c074d" ] ]]( bundlexhash, var_ebe17497781d41a1, var_2c0a656dc113b5c, var_4830ebfcbafaca03 );
    }
    
    return level.killdrops[ bundlexhash ];
}

// Namespace killdrop
// Params 2, eflags: 0x4
// Checksum 0x88a716b0, Offset: 0x9de
// Size: 0xdf
function private function_d44b1ec8ad2b6cf6( killdropbundle, killdropinfo )
{
    level endon( #"game_ended" );
    level endon( #"hash_9e9305ab60b2630a" );
    level utility::flag_wait( "StartGameTypeCallbackFinished" );
    
    if ( isbrgamemode() )
    {
        flags::gameflagwait( "prematch_fade_done" );
    }
    
    delaytime = getdvarfloat( @"hash_df29f374b6a51877", killdropbundle.var_157d33226e3e18c7 ?? 3 );
    wait delaytime;
    
    while ( true )
    {
        pos = function_beeedb50dca707f9();
        
        if ( pos )
        {
            pinata = spawnpinata( pos, killdropbundle, killdropinfo );
            
            if ( pinata )
            {
                pinata waittill( #"pinata_destroyed" );
            }
        }
        
        delaytime = getdvarfloat( @"hash_b81543f82c3482eb", killdropbundle.var_8f140ca1f8ef7d81 ?? 3 );
        wait delaytime;
    }
}

// Namespace killdrop
// Params 1
// Checksum 0xc1855eea, Offset: 0xac5
// Size: 0x1b3
function onplayerdeath( params )
{
    deathdata = {};
    
    if ( isdefined( level.sharedfuncs[ #"hash_fb941646c46755dd" ][ #"getattackers" ] ) )
    {
        deathdata.attackers = [[ level.sharedfuncs[ #"hash_fb941646c46755dd" ][ #"getattackers" ] ]]( self );
    }
    else
    {
        deathdata.attackers = self.attackers ?? [ self.attacker ?? params.eattacker ];
    }
    
    foreach ( killdropinfo in level.killdrops )
    {
        if ( killdropinfo.bundle.var_d990ab661feeae0e )
        {
            continue;
        }
        
        if ( killdropinfo.bundle.var_eda4cbca9d6fb236 )
        {
            if ( function_a46f0728fb0c3bec( undefined, self, killdropinfo ) )
            {
                spawnkilldrop( undefined, 1, undefined, undefined, killdropinfo, deathdata );
            }
            
            continue;
        }
        
        if ( killdropinfo.bundle.var_e7354cba92a76f5c )
        {
            function_b2c2a7af14e6cc05( [ self.attacker ?? params.eattacker ], killdropinfo, deathdata );
            continue;
        }
        
        function_b2c2a7af14e6cc05( deathdata.attackers, killdropinfo, deathdata );
    }
}

// Namespace killdrop
// Params 5
// Checksum 0xd4d77439, Offset: 0xc80
// Size: 0x3e
function function_f2801b21f06fa312( var_f31cce14fa791068, isglobal, position, notimeout, killdropinfo )
{
    return spawnkilldrop( var_f31cce14fa791068, isglobal, position, notimeout, killdropinfo, undefined );
}

// Namespace killdrop
// Params 3, eflags: 0x4
// Checksum 0x7af64a04, Offset: 0xcc7
// Size: 0xa4
function private function_b2c2a7af14e6cc05( attackers, killdropinfo, deathdata )
{
    foreach ( attacker in attackers )
    {
        if ( function_3b62431b2163af22( attacker, self, killdropinfo ) )
        {
            spawnkilldrop( attacker, undefined, undefined, undefined, killdropinfo, deathdata );
        }
    }
}

// Namespace killdrop
// Params 1
// Checksum 0xd0e111d7, Offset: 0xd73
// Size: 0x47, Type: bool
function function_6485fcae007b7ef7( aestringref )
{
    for ( eventidx = 0; eventidx < 5 ; eventidx++ )
    {
        if ( self getplayerdata( "common", "inGameSeasonalEventData", "completedKillDropEventAERefs", eventidx ) == aestringref )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace killdrop
// Params 1, eflags: 0x4
// Checksum 0x86d5f116, Offset: 0xdc3
// Size: 0x2c, Type: bool
function private function_3d64ebd68be191a9( dropsetting )
{
    return dropsetting.aestringref && function_6485fcae007b7ef7( dropsetting.aestringref );
}

// Namespace killdrop
// Params 6
// Checksum 0x6f1d2b91, Offset: 0xdf8
// Size: 0x198
function spawnkilldrop( attacker, isglobal, positionoverride, hasnotimeout, killdropinfo, deathdata )
{
    if ( killdropinfo.var_ca3dab906efde673 )
    {
        dropsetting = self [[ killdropinfo.var_ca3dab906efde673 ]]( killdropinfo, attacker, self );
    }
    else
    {
        dropsetting = function_b1be33eda6fb0508( killdropinfo );
    }
    
    if ( !dropsetting )
    {
        return;
    }
    
    if ( attacker )
    {
        var_4f8445da3c85dd73 = attacker function_3d64ebd68be191a9( dropsetting );
        
        if ( var_4f8445da3c85dd73 )
        {
            return;
        }
    }
    
    position = function_6e1225beb0e93228( positionoverride, undefined, attacker, killdropinfo.bundle.var_9b527d42344cfc0f, killdropinfo.bundle.var_bd74ec870c1523e7 ?? 25, killdropinfo.bundle.var_a84f8833c6efd159 ?? 50 );
    
    if ( !position )
    {
        return;
    }
    
    if ( !isglobal && attacker )
    {
        if ( !isdefined( attacker.killdropdata ) )
        {
            attacker.killdropdata = {};
        }
        
        if ( !isdefined( attacker.killdropdata.var_fac81067ed0da33b ) )
        {
            attacker.killdropdata.var_fac81067ed0da33b = 0;
        }
        
        attacker.killdropdata.var_fac81067ed0da33b++;
    }
    
    if ( dropsetting.useitemspawnentry )
    {
        return function_ad86d226ec88ca07( attacker, isglobal, dropsetting, killdropinfo, deathdata );
    }
    
    return function_76963ae65781d153( attacker, isglobal, position, dropsetting, hasnotimeout, killdropinfo, deathdata );
}

// Namespace killdrop
// Params 5, eflags: 0x4
// Checksum 0xfa08e692, Offset: 0xf98
// Size: 0x1fd
function private function_ad86d226ec88ca07( attacker, isglobal, dropsetting, killdropinfo, deathdata )
{
    if ( isbot( attacker ) )
    {
        return;
    }
    
    if ( !function_2c09fa2e38e1fc1d( dropsetting.dropamount ) )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
    item = common_item::function_61c2c0251e742ffd( dropsetting.item, dropsetting.dropamount, spawnoptions );
    
    if ( !isdefined( item ) )
    {
        return;
    }
    
    item.dropsetting = dropsetting;
    item.killdropinfo = killdropinfo;
    item.var_281d6d35ad272fb8 = dropsetting.expirefx;
    item.expiresoundalias = dropsetting.expiresoundalias;
    item.var_4759a7ab5741f85f = dropsetting.pickupfx;
    item.aestringref = dropsetting.aestringref;
    item.omnvarstringref = dropsetting.omnvarstringref;
    item.stringref = dropsetting.stringref;
    item.dropamount = dropsetting.dropamount;
    item.lifetimesec = dropsetting.lifetimesec;
    item.attacker = attacker;
    item.victim = self;
    item thread function_c3b770691f1a9620();
    
    if ( !isglobal )
    {
        item function_7653c765b6c7b815();
        item enablescriptableplayeruse( attacker );
        item function_f2033e35d5f803c0( attacker );
    }
    else if ( !killdropinfo.var_7a2305059cadfaa8 )
    {
        item disablescriptableplayeruse( self );
    }
    
    if ( !arraycontains( level.var_fc0b690d3a12b77b, item ) )
    {
        level.var_fc0b690d3a12b77b[ level.var_fc0b690d3a12b77b.size ] = item;
    }
    
    return item;
}

// Namespace killdrop
// Params 7, eflags: 0x4
// Checksum 0x8cf61c87, Offset: 0x119e
// Size: 0x42a
function private function_76963ae65781d153( attacker, isglobal, position, dropsetting, hasnotimeout, killdropinfo, deathdata )
{
    visual = spawn( "script_model", position );
    visual setmodel( dropsetting.modelref ?? "military_dogtags_iw8_orange" );
    
    if ( !isglobal )
    {
        visual hide();
        
        if ( attacker )
        {
            visual showtoplayer( attacker );
        }
    }
    
    if ( dropsetting.modelanim.id )
    {
        visual scriptmodelplayanim( dropsetting.modelanim.id );
    }
    
    if ( utility::fxexists( dropsetting.loopingfx ) )
    {
        if ( !isglobal )
        {
            if ( attacker )
            {
                playfxontagforclients( level._effect[ dropsetting.loopingfx ], visual, dropsetting.var_449d9dab3944e8d2 ?? "tag_origin", attacker );
            }
        }
        else
        {
            playfxontag( level._effect[ dropsetting.loopingfx ], visual, dropsetting.var_449d9dab3944e8d2 ?? "tag_origin" );
        }
    }
    
    if ( dropsetting.dropsoundalias )
    {
        if ( !isglobal )
        {
            if ( attacker )
            {
                attacker playsoundtoplayer( dropsetting.dropsoundalias, attacker, visual );
            }
        }
        else
        {
            playsoundatpos( position, dropsetting.dropsoundalias );
        }
    }
    
    trigger = spawn( "trigger_radius", position, 0, 32, 32 );
    dropent = {};
    dropent.visual = visual;
    dropent.trigger = trigger;
    dropent.attacker = attacker;
    dropent.victim = self;
    dropent.isglobal = isglobal;
    dropent.lifetimesec = dropsetting.lifetimesec;
    dropent.idlesoundalias = dropsetting.idlesoundalias;
    dropent.pickupsoundalias = dropsetting.pickupsoundalias;
    dropent.expiresoundalias = dropsetting.expiresoundalias;
    dropent.var_4759a7ab5741f85f = dropsetting.pickupfx;
    dropent.var_281d6d35ad272fb8 = dropsetting.expirefx;
    dropent.aestringref = dropsetting.aestringref;
    dropent.omnvarstringref = dropsetting.omnvarstringref;
    dropent.dropamount = dropsetting.dropamount;
    dropent.stringref = dropsetting.stringref;
    dropent.killdropinfo = killdropinfo;
    dropent.deathdata = deathdata;
    var_30de47198eb0b8e7 = -1;
    
    foreach ( killdropscoreevent in dropsetting.var_9b20bce0fac0cf7e )
    {
        eliminationsrequired = killdropscoreevent.eliminationsrequired ?? 0;
        
        if ( eliminationsrequired > var_30de47198eb0b8e7 && ( self.var_9b5953146269e8f8 ?? 0 ) >= eliminationsrequired )
        {
            dropent.scoreevent = killdropscoreevent.scoreevent;
            var_30de47198eb0b8e7 = eliminationsrequired;
        }
    }
    
    if ( !hasnotimeout )
    {
        dropent thread function_c3b770691f1a9620();
    }
    
    dropent thread waitforpickup();
    
    if ( isdefined( level.sharedfuncs[ #"hash_fb941646c46755dd" ][ #"hash_6055b3dcd8038df5" ] ) )
    {
        self [[ level.sharedfuncs[ #"hash_fb941646c46755dd" ][ #"hash_6055b3dcd8038df5" ] ]]( dropent );
    }
    
    if ( !isglobal )
    {
        dropent thread function_4843a49af494ded8();
    }
    
    return dropent;
}

// Namespace killdrop
// Params 1
// Checksum 0xf3e7f87c, Offset: 0x15d1
// Size: 0xcc
function function_f2033e35d5f803c0( target )
{
    if ( !self scriptablemaskallowed() )
    {
        assertmsg( "<dev string:x6a>" + self.type );
        return;
    }
    
    if ( isbot( target ) || !isplayer( target ) )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        if ( player == target )
        {
            self function_6113853a877d5460( player );
            continue;
        }
        
        self function_d6a7b7ef13a57f38( player );
    }
}

// Namespace killdrop
// Params 1
// Checksum 0x6a8598cf, Offset: 0x16a5
// Size: 0xa2, Type: bool
function function_2c09fa2e38e1fc1d( count )
{
    level.var_fc0b690d3a12b77b = function_5713d46873b29625( level.var_fc0b690d3a12b77b );
    var_3aac7f5c4b57cc92 = function_479a91629c936167();
    var_a5df1965f51c1fb6 = getdvarint( @"hash_ed7595ea55994a7e", 40 );
    var_f908a6007ecf4b4c = level.var_fc0b690d3a12b77b.size + count;
    var_1ed51952ad228796 = var_3aac7f5c4b57cc92 <= count || var_a5df1965f51c1fb6 > 0 && var_f908a6007ecf4b4c >= var_a5df1965f51c1fb6;
    
    if ( var_1ed51952ad228796 )
    {
        thread function_2f65ffa1248d2a6a( count );
    }
    
    return var_3aac7f5c4b57cc92 > count && ( var_a5df1965f51c1fb6 <= 0 || var_f908a6007ecf4b4c <= var_a5df1965f51c1fb6 );
}

// Namespace killdrop
// Params 1, eflags: 0x4
// Checksum 0xba64e1a, Offset: 0x1750
// Size: 0x7c
function private function_2f65ffa1248d2a6a( count )
{
    level.var_fc0b690d3a12b77b = function_5713d46873b29625( level.var_fc0b690d3a12b77b );
    
    for ( index = 0; index < count && index < level.var_fc0b690d3a12b77b.size ; index++ )
    {
        item = level.var_fc0b690d3a12b77b[ index ];
        item notify( #"killdrop_cleanup" );
        waitframe();
        common_item::function_869d7676e359a627( item, 1 );
    }
}

// Namespace killdrop
// Params 1, eflags: 0x4
// Checksum 0xc8966e43, Offset: 0x17d4
// Size: 0xd5
function private function_b1be33eda6fb0508( killdropinfo )
{
    if ( killdropinfo.var_9d3459eaaf0322c <= 0 )
    {
        return;
    }
    
    random = randomfloatrange( -1, 0 );
    
    foreach ( killdropsetting in killdropinfo.settinglist )
    {
        random += ( killdropsetting.var_10d453f641168dd6 ?? 0.3 ) / killdropinfo.var_9d3459eaaf0322c;
        
        if ( random >= 0 )
        {
            return killdropsetting;
        }
    }
}

// Namespace killdrop
// Params 6, eflags: 0x4
// Checksum 0x75a75931, Offset: 0x18b2
// Size: 0x130
function private function_6e1225beb0e93228( var_2d7b3587f47c9aa1, drop_height_override = 20, attacker, var_4cb28d26dac3ad70, var_bd74ec870c1523e7, var_a84f8833c6efd159 )
{
    var_4a1cdac291025615 = var_bd74ec870c1523e7 < var_a84f8833c6efd159 ? randomintrange( var_bd74ec870c1523e7, var_a84f8833c6efd159 ) : var_bd74ec870c1523e7;
    var_8a905bc37c60c7dc = var_4a1cdac291025615 * vectornormalize( anglestoforward( ( 0, randomint( 360 ), 0 ) ) );
    rawpos = undefined;
    
    if ( var_2d7b3587f47c9aa1 )
    {
        rawpos = var_2d7b3587f47c9aa1 + var_8a905bc37c60c7dc;
    }
    else if ( self && self.origin )
    {
        rawpos = self.origin + var_8a905bc37c60c7dc;
    }
    else if ( attacker.origin && attacker.angles )
    {
        rawpos = attacker.origin + 250 * anglestoforward( ( 0, attacker.angles[ 1 ], 0 ) );
    }
    else
    {
        return;
    }
    
    if ( var_4cb28d26dac3ad70 )
    {
        pos = rawpos;
    }
    else
    {
        pos = function_edfcfce7db5baa4e( rawpos ) ?? rawpos;
    }
    
    pos += ( 0, 0, drop_height_override );
    return pos;
}

// Namespace killdrop
// Params 3, eflags: 0x4
// Checksum 0x983ee60, Offset: 0x19eb
// Size: 0xa7
function private function_3b62431b2163af22( attacker, victim, killdropinfo )
{
    if ( !isplayer( attacker ) )
    {
        return 0;
    }
    
    if ( attacker == victim )
    {
        return 0;
    }
    
    if ( level.teambased && attacker.team == victim.team )
    {
        return 0;
    }
    
    if ( attacker.killdropdata.var_fac81067ed0da33b >= getdvarint( @"hash_16de72c40f58385", killdropinfo.bundle.var_4831c243151c5ca0 ?? 0 ) )
    {
        return 0;
    }
    
    return function_a46f0728fb0c3bec( attacker, victim, killdropinfo );
}

// Namespace killdrop
// Params 3, eflags: 0x4
// Checksum 0xa9a303cb, Offset: 0x1a9b
// Size: 0xe9, Type: bool
function private function_a46f0728fb0c3bec( attacker, victim, killdropinfo )
{
    dropchance = killdropinfo.bundle.dropchance ?? 0.3;
    dropchance = getdvarfloat( @"hash_3dc3dbbe175267f0", dropchance );
    
    if ( isdefined( level.sharedfuncs[ #"hash_fb941646c46755dd" ][ #"hash_3d1d656e00699df1" ] ) )
    {
        var_20bfe1deb365922b = self [[ level.sharedfuncs[ #"hash_fb941646c46755dd" ][ #"hash_3d1d656e00699df1" ] ]]( attacker, victim, killdropinfo );
    }
    else if ( level.var_8ea2c9030bb6d770 )
    {
        var_20bfe1deb365922b = self [[ level.var_8ea2c9030bb6d770 ]]( attacker, victim, killdropinfo );
    }
    
    dropchance = var_20bfe1deb365922b ?? dropchance;
    
    if ( randomfloatrange( 0, 1 ) > dropchance )
    {
        return false;
    }
    
    return true;
}

// Namespace killdrop
// Params 0, eflags: 0x4
// Checksum 0x7fed8290, Offset: 0x1b8d
// Size: 0xb3
function private function_c3b770691f1a9620()
{
    level endon( #"game_ended" );
    self endon( #"collected" );
    self endon( #"entity_limit" );
    self endon( #"death" );
    lifetime = self.lifetimesec ?? 15;
    lifetime = getdvarfloat( @"scr_killdrop_lifetime_override", lifetime );
    utility::waittill_notify_or_timeout( "killdrop_cleanup", lifetime );
    self notify( #"timeout" );
    
    if ( utility::function_de1f80d93273abf5() )
    {
        if ( self getscriptablehaspart( "audio" ) )
        {
            self setscriptablepartstate( "audio", "expired" );
            waitframe();
            thread common_item::function_869d7676e359a627( self, 1 );
        }
        
        return;
    }
    
    cleanupdrop( 0 );
}

// Namespace killdrop
// Params 0, eflags: 0x4
// Checksum 0x2dd91478, Offset: 0x1c48
// Size: 0x5f
function private function_4843a49af494ded8()
{
    level endon( #"game_ended" );
    self.visual endon( #"death" );
    self.trigger endon( #"death" );
    
    if ( self.attacker )
    {
        self.attacker waittill( #"disconnect" );
    }
    
    thread cleanupdrop( 0 );
}

// Namespace killdrop
// Params 0, eflags: 0x4
// Checksum 0x41bfd26b, Offset: 0x1caf
// Size: 0x135
function private waitforpickup()
{
    level endon( #"game_ended" );
    self endon( #"timeout" );
    self endon( #"entity_limit" );
    self.trigger endon( #"death" );
    wait 0.5;
    
    if ( self.idlesoundalias )
    {
        self.visual playloopsound( self.idlesoundalias );
    }
    
    while ( self.trigger )
    {
        self.trigger waittill( #"trigger", ent );
        
        if ( !self.isglobal && ent == self.attacker || self.isglobal && isplayer( ent ) && ( ent != self.victim || self.killdropinfo.bundle.var_7a2305059cadfaa8 ) )
        {
            if ( !isalive( ent ) )
            {
                continue;
            }
            
            self notify( #"collected" );
            handlepickup( ent );
            ent callback::callback( "on_killdrop_pickedup", self );
            cleanupdrop( 1, ent );
            return;
        }
    }
}

// Namespace killdrop
// Params 1, eflags: 0x4
// Checksum 0xb03235a1, Offset: 0x1dec
// Size: 0x1ce
function private handlepickup( ent )
{
    if ( self.pickupsoundalias )
    {
        ent playlocalsound( self.pickupsoundalias );
    }
    
    if ( utility::fxexists( self.var_4759a7ab5741f85f ) )
    {
        origin = self.visual.origin ?? self.origin;
        angles = self.visual.angles ?? self.angles;
        
        if ( self.isglobal )
        {
            playfx( level._effect[ self.var_4759a7ab5741f85f ], origin, anglestoforward( angles ), anglestoup( angles ) );
        }
        else
        {
            playfx( level._effect[ self.var_4759a7ab5741f85f ], origin, anglestoforward( angles ), anglestoup( angles ), self.attacker );
        }
    }
    
    if ( self.scoreevent )
    {
        ent thread points::doscoreevent( self.scoreevent );
    }
    
    if ( self.aestringref )
    {
        challenges::function_37e945722d6497f3( ent, self.aestringref, 1 );
    }
    
    if ( self.omnvarstringref )
    {
        amount = self.dropamount ?? 1;
        var_4b96e227c1e1aadb = function_1b85389c8e710e90( self.aestringref );
        
        if ( isdefined( var_4b96e227c1e1aadb ) )
        {
            ent function_73ac4127f8af2dcf( var_4b96e227c1e1aadb, self.omnvarstringref, amount );
        }
        else
        {
            ent updatehudwidget( self.omnvarstringref, amount );
        }
    }
    
    if ( self.killdropinfo.var_d1e5ba2547561fb5 )
    {
        ent [[ self.killdropinfo.var_d1e5ba2547561fb5 ]]( self );
    }
}

// Namespace killdrop
// Params 1, eflags: 0x4
// Checksum 0xc297cde3, Offset: 0x1fc2
// Size: 0x83
function private function_1b85389c8e710e90( aestringref )
{
    if ( !level.brgametype.trophy_hunt_data )
    {
        return;
    }
    
    for ( i = 0; i < level.brgametype.trophy_hunt_data.var_fe91481cc125addd.size ; i++ )
    {
        if ( aestringref == level.brgametype.trophy_hunt_data.var_fe91481cc125addd[ i ] )
        {
            return i;
        }
    }
}

// Namespace killdrop
// Params 3, eflags: 0x4
// Checksum 0x8b944cc0, Offset: 0x204e
// Size: 0x81
function private function_73ac4127f8af2dcf( idx, var_48646764f8a928fa, amount )
{
    if ( !isdefined( self.br_trophy_counts ) )
    {
        self.br_trophy_counts = [];
    }
    
    if ( !isdefined( self.br_trophy_counts[ idx ] ) )
    {
        self.br_trophy_counts[ idx ] = 0;
    }
    
    self.br_trophy_counts[ idx ] += amount;
    self setclientomnvar( var_48646764f8a928fa, self.br_trophy_counts[ idx ] );
}

// Namespace killdrop
// Params 2, eflags: 0x4
// Checksum 0x9dc0113d, Offset: 0x20d7
// Size: 0x71
function private updatehudwidget( var_48646764f8a928fa, amount )
{
    if ( !isdefined( self.pers[ "killdropCount" ] ) )
    {
        self.pers[ "killdropCount" ] = 0;
    }
    
    self.pers[ "killdropCount" ] = self.pers[ "killdropCount" ] + amount;
    self setclientomnvar( var_48646764f8a928fa, self.pers[ "killdropCount" ] );
}

// Namespace killdrop
// Params 1, eflags: 0x4
// Checksum 0xbe387e5e, Offset: 0x2150
// Size: 0xbb
function private function_e8b770144a9de60( var_48646764f8a928fa )
{
    level endon( #"game_ended" );
    
    while ( !isdefined( level.players ) || level.players.size < 1 )
    {
        wait 0.5;
    }
    
    foreach ( player in level.players )
    {
        player updatehudwidget( var_48646764f8a928fa, 0 );
    }
}

/#

    // Namespace killdrop
    // Params 0, eflags: 0x4
    // Checksum 0x72cb78c0, Offset: 0x2213
    // Size: 0x9a, Type: dev
    function private function_1ce0018dd49b2050()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            waitframe();
            var_742825450f49c746 = getdvarint( @"hash_27fc7fdfc426a71c" );
            
            if ( var_742825450f49c746 != 0 )
            {
                function_2d594519957b1363( "<dev string:xa0>", var_742825450f49c746 );
                setdevdvar( @"hash_27fc7fdfc426a71c", "<dev string:xb1>" );
            }
            
            var_742824450f49c513 = getdvarint( @"hash_27fc82dfc426adb5" );
            
            if ( var_742824450f49c513 != 0 )
            {
                function_2d594519957b1363( "<dev string:xb3>", var_742824450f49c513 );
                setdevdvar( @"hash_27fc82dfc426adb5", "<dev string:xb1>" );
            }
        }
    }

    // Namespace killdrop
    // Params 2, eflags: 0x4
    // Checksum 0x49e078b, Offset: 0x22b5
    // Size: 0xa9, Type: dev
    function private function_2d594519957b1363( var_48646764f8a928fa, amount )
    {
        foreach ( player in level.players )
        {
            if ( isbot( player ) || istestclient( player ) )
            {
                continue;
            }
            
            player updatehudwidget( var_48646764f8a928fa, amount );
        }
    }

#/

// Namespace killdrop
// Params 2
// Checksum 0xf31bc5c8, Offset: 0x2366
// Size: 0x29d
function cleanupdrop( iscollected, collectplayer )
{
    if ( isdefined( level.sharedfuncs[ #"hash_fb941646c46755dd" ][ #"cleanupdrop" ] ) )
    {
        [[ level.sharedfuncs[ #"hash_fb941646c46755dd" ][ #"cleanupdrop" ] ]]( self );
    }
    
    function_ba23381f89a3f0cd( self, iscollected, collectplayer );
    
    if ( self.idlesoundalias && self.visual )
    {
        self.visual stoploopsound( self.idlesoundalias );
    }
    
    if ( !iscollected )
    {
        origin = self.visual.origin ?? self.origin;
        angles = self.visual.angles ?? self.angles;
        
        if ( self.isglobal )
        {
            if ( utility::fxexists( self.var_281d6d35ad272fb8 ) )
            {
                playfx( level._effect[ self.var_281d6d35ad272fb8 ], origin, anglestoforward( angles ), anglestoup( angles ) );
            }
            
            if ( self.expiresoundalias )
            {
                playsoundatpos( origin, self.expiresoundalias );
            }
        }
        else if ( self.attacker )
        {
            if ( utility::fxexists( self.var_281d6d35ad272fb8 ) )
            {
                playfx( level._effect[ self.var_281d6d35ad272fb8 ], origin, anglestoforward( angles ), anglestoup( angles ), self.attacker );
            }
            
            if ( self.expiresoundalias && self.visual )
            {
                self.visual playsoundtoplayer( self.expiresoundalias, self.attacker, self.visual );
            }
        }
    }
    
    if ( isdefined( self ) && utility::fxexists( "killdrop_looping_fx" ) && self.visual )
    {
        if ( !self.isglobal )
        {
            if ( self.attacker )
            {
                stopfxontagforclients( level._effect[ "killdrop_looping_fx" ], self.visual, "tag_origin", self.attacker );
            }
        }
        else
        {
            stopfxontag( level._effect[ "killdrop_looping_fx" ], self.visual, "tag_origin" );
        }
    }
    
    waitframe();
    
    if ( self.visual )
    {
        self.visual delete();
    }
    
    if ( self.trigger )
    {
        self.trigger delete();
    }
}

// Namespace killdrop
// Params 0, eflags: 0x4
// Checksum 0x7d7c30ef, Offset: 0x260b
// Size: 0xca
function private function_924b79a57af177d6()
{
    var_ebe17497781d41a1 = [];
    list = getdvar( @"hash_7acba169539fb4a" );
    list = strtok( list, ",", 1 );
    
    if ( list.size > 0 )
    {
        foreach ( pair in list )
        {
            pair = strtok( pair, " " );
            
            if ( pair.size == 2 )
            {
                var_ebe17497781d41a1[ pair[ 0 ] ] = float( pair[ 1 ] );
            }
        }
    }
    
    return var_ebe17497781d41a1;
}

// Namespace killdrop
// Params 1
// Checksum 0xd6c4a7ca, Offset: 0x26de
// Size: 0x53
function on_killdrop_cleanup( params )
{
    item = params.item;
    
    if ( !isdefined( item.dropsetting ) )
    {
        return;
    }
    
    item cleanupdrop( item.pickedup, item.pickedupplayer );
}

// Namespace killdrop
// Params 1
// Checksum 0x2f6c09ef, Offset: 0x2739
// Size: 0x53
function function_35b9ffb21f93a53a( params )
{
    player = params.player;
    item = params.item;
    
    if ( !isdefined( item.dropsetting ) )
    {
        return;
    }
    
    item handlepickup( player );
}

// Namespace killdrop
// Params 0, eflags: 0x4
// Checksum 0xf81479d1, Offset: 0x2794
// Size: 0xca
function private function_e8f076684742eadf()
{
    var_2c0a656dc113b5c = [];
    list = getdvar( @"hash_d03437d21c53cf99" );
    list = strtok( list, ",", 1 );
    
    if ( list.size > 0 )
    {
        foreach ( pair in list )
        {
            pair = strtok( pair, " " );
            
            if ( pair.size == 2 )
            {
                var_2c0a656dc113b5c[ pair[ 0 ] ] = int( pair[ 1 ] );
            }
        }
    }
    
    return var_2c0a656dc113b5c;
}

// Namespace killdrop
// Params 1
// Checksum 0xe09db130, Offset: 0x2867
// Size: 0x17
function function_18ea5879e5087593( scriptableref )
{
    level.var_32ffb11c9710bd25 = scriptableref;
}

// Namespace killdrop
// Params 1
// Checksum 0x73e955a3, Offset: 0x2886
// Size: 0x17
function function_8d5d58b9ecae31db( var_c0085c8f54739e73 )
{
    level.var_c0085c8f54739e73 = var_c0085c8f54739e73;
}

// Namespace killdrop
// Params 0, eflags: 0x4
// Checksum 0x55ddab1, Offset: 0x28a5
// Size: 0x5a
function private function_442fb874ce3200af()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"damage", idamage, eattacker, direction, point );
        function_9e0c6efcae5989d( idamage, eattacker, direction, point );
    }
}

// Namespace killdrop
// Params 11, eflags: 0x4
// Checksum 0xe14ae7bf, Offset: 0x2907
// Size: 0x97
function private function_d4c5711682338df4( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( instance.type != level.var_32ffb11c9710bd25 )
    {
        return;
    }
    
    instance function_9e0c6efcae5989d( idamage, eattacker, vdir, instance.origin );
}

// Namespace killdrop
// Params 4, eflags: 0x4
// Checksum 0x8c488be3, Offset: 0x29a6
// Size: 0x180
function private function_9e0c6efcae5989d( idamage, eattacker, direction, point )
{
    if ( !isplayer( eattacker ) )
    {
        return;
    }
    
    eattacker damagefeedback::updatehitmarker( "standard", self.drops >= self.maxdrops, 0, 1, "hitequip" );
    
    if ( isent( self ) )
    {
        self rotateby( ( 0, 1080, 0 ), self.bundle.var_90c36e950b13ad96 ?? 0.5, 0, 0 );
    }
    
    if ( utility::fxexists( self.bundle.var_27cd95bc7b5fa220 ) )
    {
        playfx( level._effect[ self.bundle.var_27cd95bc7b5fa220 ], point, anglestoforward( self.angles ), anglestoup( self.angles ) );
    }
    
    waitframe();
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.drops++;
    dropent = self [[ level.var_c0085c8f54739e73 ]]( eattacker, undefined, self.floor_pos, undefined, self.killdropinfo );
    
    if ( dropent )
    {
        dropent.frompinata = 1;
    }
    
    wait self.bundle.var_b78ca05cb5d042ed ?? 0.5;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( self.drops >= self.maxdrops )
    {
        destroypinata();
    }
}

// Namespace killdrop
// Params 0, eflags: 0x4
// Checksum 0x5500209f, Offset: 0x2b2e
// Size: 0x2e
function private function_935df636b2a8bb02()
{
    self endon( #"death" );
    self endon( #"pinata_destroyed" );
    level waittill( #"game_ended" );
    destroypinata();
}

// Namespace killdrop
// Params 0, eflags: 0x4
// Checksum 0x4ae769ac, Offset: 0x2b64
// Size: 0x193
function private destroypinata()
{
    if ( self && !self.destroyed )
    {
        self.destroyed = 1;
    }
    else
    {
        return;
    }
    
    self notify( #"pinata_destroyed" );
    
    if ( isent( self ) && self.bundle.var_a2933cd21adda194 )
    {
        self stoploopsound( self.bundle.var_a2933cd21adda194 );
    }
    
    waitframe();
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( self.bundle.var_d6fe01ee225fe762 )
    {
        playsoundatpos( self.origin, self.bundle.var_d6fe01ee225fe762 );
    }
    
    if ( isent( self ) && utility::fxexists( self.bundle.var_5a59e1e01efa7f63 ) )
    {
        killfxontag( level._effect[ self.bundle.var_5a59e1e01efa7f63 ], self, "tag_origin" );
    }
    
    if ( utility::fxexists( self.bundle.var_93f364ce102a7e7d ) )
    {
        playfx( level._effect[ self.bundle.var_93f364ce102a7e7d ], self.origin, anglestoforward( self.angles ?? ( 0, 0, 0 ) ), anglestoup( self.angles ?? ( 0, 0, 0 ) ) );
    }
    
    waitframe();
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isent( self ) )
    {
        self delete();
        return;
    }
    
    self freescriptable();
}

// Namespace killdrop
// Params 3, eflags: 0x4
// Checksum 0x964a35d, Offset: 0x2cff
// Size: 0x349
function private spawnpinata( position, killdropbundle, killdropinfo )
{
    if ( !isdefined( level.killdroppinata.var_a760c8da7c8eb2c3 ) )
    {
        level.killdroppinata.var_a760c8da7c8eb2c3 = 0;
    }
    
    maxpinata = getdvarint( @"hash_7aa8d385b9e12778", killdropbundle.maxpinata ?? 6 );
    
    if ( level.killdroppinata.var_a760c8da7c8eb2c3 >= maxpinata )
    {
        level notify( #"hash_9e9305ab60b2630a" );
        return;
    }
    
    if ( isdefined( level.var_32ffb11c9710bd25 ) )
    {
        pinata = spawnscriptable( level.var_32ffb11c9710bd25, position );
        pinata setscriptablepartstate( "base", "visible" );
    }
    else
    {
        pinata = spawn( "script_model", position );
    }
    
    if ( !isdefined( pinata ) )
    {
        return;
    }
    
    waitframe();
    
    if ( killdropbundle.var_c0399507ddbed12f )
    {
        playsoundatpos( position, killdropbundle.var_c0399507ddbed12f );
    }
    
    if ( utility::fxexists( killdropbundle.pinataspawnvfx ) )
    {
        playfx( level._effect[ killdropbundle.pinataspawnvfx ], pinata.origin, anglestoforward( pinata.angles ), anglestoup( pinata.angles ) );
    }
    
    pinata.health = 999999999;
    pinata.drops = 0;
    pinata.floor_pos = position - ( 0, 0, 80 );
    pinata.maxdrops = randomintrange( killdropbundle.var_81fd6d3ac4efdd77 ?? 3, killdropbundle.var_82207b3ac51643f9 ?? 6 );
    
    if ( isent( pinata ) && killdropbundle.var_a860d936e9d88401 )
    {
        pinata setmodel( killdropbundle.var_a860d936e9d88401 );
        pinata setcandamage( 1 );
    }
    
    if ( isent( pinata ) && utility::fxexists( killdropbundle.var_5a59e1e01efa7f63 ) )
    {
        playfxontag( level._effect[ killdropbundle.var_5a59e1e01efa7f63 ], pinata, "tag_origin" );
    }
    
    if ( isent( pinata ) && killdropbundle.pinataanim.id )
    {
        pinata scriptmodelplayanim( killdropbundle.pinataanim.id );
    }
    
    pinata.bundle = killdropbundle;
    pinata.killdropinfo = killdropinfo;
    pinata thread function_c9153093699d63a1();
    pinata thread function_442fb874ce3200af();
    pinata thread function_935df636b2a8bb02();
    
    /#
        if ( getdvarint( @"hash_3e362384e9b50105", 0 ) )
        {
            sphere( position, 32, ( 1, 0, 0 ), 0, 3000 );
            sphere( position + ( 0, 0, 1 ), 32, ( 1, 0, 0 ), 0, 3000 );
            
            if ( isent( pinata ) )
            {
                outline::outlineenableforplayer( pinata, level.players[ 0 ], "<dev string:xc4>", "<dev string:xcb>" );
            }
        }
    #/
    
    level.killdroppinata.var_a760c8da7c8eb2c3++;
    return pinata;
}

// Namespace killdrop
// Params 0, eflags: 0x4
// Checksum 0x87277c2d, Offset: 0x3051
// Size: 0x58
function private function_c9153093699d63a1()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    wait 0.5;
    
    if ( isent( self ) && self.bundle.var_a2933cd21adda194 )
    {
        self playloopsound( self.bundle.var_a2933cd21adda194 );
    }
}

// Namespace killdrop
// Params 0, eflags: 0x4
// Checksum 0x8be35c, Offset: 0x30b1
// Size: 0x16c
function private function_beeedb50dca707f9()
{
    retry = 0;
    
    while ( retry < 10 )
    {
        retry++;
        posvalid = 1;
        pos = function_c7e3f4d15d3b0e2f();
        
        if ( !pos )
        {
            waitframe();
            continue;
        }
        
        contents = physics_createcontents( [ "physicscontents_trigger", "physicscontents_playerclip", "physicscontents_missileclip", "physicscontents_vehicleclip" ] );
        results = physics_spherecast( pos, pos + ( 0, 0, 1 ), 32, contents, undefined, "physicsquery_all" );
        
        foreach ( result in results )
        {
            if ( result[ "entity" ] && result[ "entity" ].targetname == "OutOfBounds" )
            {
                posvalid = 0;
                break;
            }
            
            if ( result[ "hittype" ] == "hittype_world" )
            {
                posvalid = 0;
                break;
            }
        }
        
        if ( posvalid )
        {
            return pos;
        }
        
        waitframe();
    }
    
    if ( level.var_70237f9b8c8ecc5d )
    {
        return [[ level.var_70237f9b8c8ecc5d ]]();
    }
}

// Namespace killdrop
// Params 0, eflags: 0x4
// Checksum 0x819735f6, Offset: 0x3226
// Size: 0x9a
function private function_c7e3f4d15d3b0e2f()
{
    var_8a905bc37c60c7dc = randomintrange( 0, int( level.mapsize * 0.5 ) ) * vectornormalize( anglestoforward( ( 0, randomint( 360 ), 0 ) ) );
    zoffset = randomintrange( -500, 500 );
    point = ( level.var_654ffd608d133350 ?? level.mapcenter ) + var_8a905bc37c60c7dc + ( 0, 0, zoffset );
    point = function_edfcfce7db5baa4e( point );
    
    if ( !point )
    {
        return;
    }
    
    point += ( 0, 0, 80 );
    return point;
}

// Namespace killdrop
// Params 1
// Checksum 0xae4539db, Offset: 0x32c9
// Size: 0xbc
function function_e927db442d59ccb( params )
{
    var_b720e108ea382ac0 = getentarray( "flag_primary", #targetname );
    
    foreach ( flag in var_b720e108ea382ac0 )
    {
        if ( flag.script_label == "_b" )
        {
            level.var_654ffd608d133350 = flag.origin;
            break;
        }
    }
}

// Namespace killdrop
// Params 0, eflags: 0x4
// Checksum 0xa3c2f8b4, Offset: 0x338d
// Size: 0x43
function private function_1f2b9af3c18c5f1b()
{
    if ( level.var_654ffd608d133350 )
    {
        point = function_edfcfce7db5baa4e( level.var_654ffd608d133350 );
        
        if ( point )
        {
            point += ( 0, 0, 80 );
        }
        
        return point;
    }
}

// Namespace killdrop
// Params 1, eflags: 0x4
// Checksum 0x64d93d69, Offset: 0x33d9
// Size: 0x63
function private function_edfcfce7db5baa4e( point )
{
    if ( !point )
    {
        return;
    }
    
    point = getclosestpointonnavmesh( point, "human", 0, 0, 1, 1, 0 );
    
    if ( utility::issharedfuncdefined( #"zombie", #"hash_bad01cbc996e3dba" ) )
    {
        if ( !utility::callsharedfunc( #"zombie", #"hash_bad01cbc996e3dba", point ) )
        {
            return;
        }
    }
    
    return point;
}

// Namespace killdrop
// Params 3
// Checksum 0x670edeae, Offset: 0x3445
// Size: 0x2a3
function function_ba23381f89a3f0cd( dropent, iscollected, collectplayer )
{
    game_type = game_utility::getgametype() ?? "";
    map_name = game_utility::getmapname() ?? "";
    playlist_id = getplaylistid() ?? 0;
    playlist_name = getplaylistname() ?? "";
    time = matchdata::gettimefrommatchstart( gettime() );
    time = int( clamp( time, 0, 2147483647 ) );
    aestringref = dropent.aestringref ?? "";
    stringref = dropent.stringref ?? "";
    pos_x = dropent.visual.origin[ 0 ] ?? dropent.origin[ 0 ] ?? 0;
    pos_y = dropent.visual.origin[ 1 ] ?? dropent.origin[ 1 ] ?? 0;
    pos_z = dropent.visual.origin[ 2 ] ?? dropent.origin[ 2 ] ?? 0;
    frompinata = istrue( dropent.frompinata );
    destroyreason = iscollected ? "collected" : "expired";
    client_uno_id = "";
    
    if ( collectplayer )
    {
        client_uno_id = collectplayer getplayerunoid();
    }
    
    dlog_recordevent( "dlog_event_killdrop_destroy", [ "game_type", game_type, "map_name", map_name, "playlist_id", playlist_id, "playlist_name", playlist_name, "matchtime_ms", time, "pos_x", pos_x, "pos_y", pos_y, "pos_z", pos_z, "killdrop_ae_string_ref", aestringref, "killdrop_sub_string_ref", stringref, "from_pinata", frompinata, "destroy_reason", destroyreason, "client_uno_id", client_uno_id ] );
}

// Namespace killdrop
// Params 1
// Checksum 0x3efb7440, Offset: 0x36f0
// Size: 0x3b7
function function_3f2ce224daffdb48( killdropinfo )
{
    if ( self.var_6d758f0d37e445b5 )
    {
        assertmsg( "<dev string:xd5>" );
        return;
    }
    
    if ( !killdropinfo )
    {
        assertmsg( "<dev string:x11c>" );
        return;
    }
    
    killdropbundle = killdropinfo.bundle;
    
    if ( !killdropbundle )
    {
        assertmsg( "<dev string:x153>" );
        return;
    }
    
    self.var_6d758f0d37e445b5 = {};
    self.var_6d758f0d37e445b5.var_ded73796da737367 = killdropbundle.var_feb70c795ed13b63 ?? 0.85;
    self.var_6d758f0d37e445b5.var_ded73796da737367 = getdvarfloat( @"hash_35ade10974c1a9b0", self.var_6d758f0d37e445b5.var_ded73796da737367 );
    self.var_6d758f0d37e445b5.dropchance = killdropbundle.dropchance ?? 0.3;
    self.var_6d758f0d37e445b5.dropchance = getdvarfloat( @"hash_3dc3dbbe175267f0", self.var_6d758f0d37e445b5.dropchance );
    self.var_6d758f0d37e445b5.var_a20b05324052a6b = killdropbundle.var_92681e79ce6e5f1b ?? 0.01;
    self.var_6d758f0d37e445b5.var_a20b05324052a6b = getdvarfloat( @"hash_8cc96e344f2e48e4", self.var_6d758f0d37e445b5.var_a20b05324052a6b );
    self.var_6d758f0d37e445b5.var_2b6a1609554f72dd = killdropbundle.var_e85f0379fa34a71d ?? 1;
    self.var_6d758f0d37e445b5.var_2b6a1609554f72dd = getdvarfloat( @"hash_447e613a7f5ec846", self.var_6d758f0d37e445b5.var_2b6a1609554f72dd );
    self.var_6d758f0d37e445b5.inittime = gettime();
    self.var_6d758f0d37e445b5.totaldropped = 0;
    
    if ( !killdropbundle.var_fd890a7329eb0683 )
    {
        return;
    }
    
    if ( !isdefined( self.var_6d758f0d37e445b5.var_e64a4b9feecd6ef1 ) )
    {
        self.var_6d758f0d37e445b5.var_e64a4b9feecd6ef1 = [];
    }
    
    foreach ( var_f4686e34d12a1fdb in killdropbundle.var_fd890a7329eb0683 )
    {
        self.var_6d758f0d37e445b5.var_e64a4b9feecd6ef1[ var_f4686e34d12a1fdb.aicategory ] = var_f4686e34d12a1fdb.dropchance ?? self.var_6d758f0d37e445b5.dropchance;
        
        switch ( var_f4686e34d12a1fdb.aicategory )
        {
            case #"normal":
                dvarvalue = @"hash_85159d44b5aea90a";
                break;
            case #"special":
                dvarvalue = @"hash_8c3601e276a1c9b8";
                break;
            case #"elite":
                dvarvalue = @"hash_651cd17f6ac795c";
                break;
            default:
                break;
        }
        
        self.var_6d758f0d37e445b5.var_e64a4b9feecd6ef1[ var_f4686e34d12a1fdb.aicategory ] = getdvarfloat( dvarvalue, self.var_6d758f0d37e445b5.var_e64a4b9feecd6ef1[ var_f4686e34d12a1fdb.aicategory ] );
    }
}

// Namespace killdrop
// Params 1
// Checksum 0xfb41d6e6, Offset: 0x3aaf
// Size: 0x34
function function_141003841eb44dfe( cacheddata )
{
    return ( gettime() - cacheddata.inittime ) * 0.001 * 0.0167 / cacheddata.totaldropped;
}

// Namespace killdrop
// Params 2
// Checksum 0x26229b10, Offset: 0x3aec
// Size: 0xff
function function_96120de1a46b9110( attacker, cacheddata )
{
    if ( cacheddata.totaldropped == 0 )
    {
        attacker function_58b75b898bf4426c( 0.01 );
        return;
    }
    
    var_fcdf4980f55628ef = function_141003841eb44dfe( cacheddata );
    
    if ( var_fcdf4980f55628ef < cacheddata.var_ded73796da737367 - cacheddata.var_ded73796da737367 * 0.05 )
    {
        attacker function_58b75b898bf4426c( -0.01 );
    }
    else if ( var_fcdf4980f55628ef > cacheddata.var_ded73796da737367 + cacheddata.var_ded73796da737367 * 0.05 )
    {
        attacker function_58b75b898bf4426c( 0.01 );
    }
    
    /#
        if ( isdefined( level.sharedfuncs[ #"hash_fb941646c46755dd" ][ #"hash_63c4e9bff80aa931" ] ) )
        {
            attacker [[ level.sharedfuncs[ #"hash_fb941646c46755dd" ][ #"hash_63c4e9bff80aa931" ] ]]( var_fcdf4980f55628ef, cacheddata.totaldropped );
        }
    #/
}

// Namespace killdrop
// Params 4
// Checksum 0x5cfd65e1, Offset: 0x3bf3
// Size: 0x94
function function_c04b8561103a725e( bundlexhash, var_ebe17497781d41a1, var_2c0a656dc113b5c, var_4830ebfcbafaca03 )
{
    killdropbundle = getscriptbundle( bundlexhash );
    
    if ( !killdropbundle )
    {
        assertmsg( "<dev string:x1a9>" );
        return;
    }
    
    level.killdrops[ bundlexhash ].var_feb70c795ed13b63 = killdropbundle.var_feb70c795ed13b63;
    level.killdrops[ bundlexhash ].var_d78cac68b6333b51 = killdropbundle.var_d78cac68b6333b51;
}

// Namespace killdrop
// Params 1, eflags: 0x4
// Checksum 0x5ce4128a, Offset: 0x3c8f
// Size: 0x27a
function private function_58b75b898bf4426c( dropamount )
{
    if ( !isdefined( dropamount ) )
    {
        assertmsg( "<dev string:x1f6>" );
        return;
    }
    
    self.var_6d758f0d37e445b5.dropchance += dropamount;
    
    if ( dropamount > 0 )
    {
        self.var_6d758f0d37e445b5.dropchance = min( self.var_6d758f0d37e445b5.dropchance, self.var_6d758f0d37e445b5.var_2b6a1609554f72dd );
    }
    else
    {
        self.var_6d758f0d37e445b5.dropchance = max( self.var_6d758f0d37e445b5.dropchance, self.var_6d758f0d37e445b5.var_a20b05324052a6b );
    }
    
    println( "<dev string:x239>" + self.var_6d758f0d37e445b5.dropchance );
    
    if ( !self.var_6d758f0d37e445b5.var_e64a4b9feecd6ef1 )
    {
        return;
    }
    
    foreach ( aicategory, dropchance in self.var_6d758f0d37e445b5.var_e64a4b9feecd6ef1 )
    {
        self.var_6d758f0d37e445b5.var_e64a4b9feecd6ef1[ aicategory ] += dropamount;
        
        if ( dropamount > 0 )
        {
            self.var_6d758f0d37e445b5.var_e64a4b9feecd6ef1[ aicategory ] = min( self.var_6d758f0d37e445b5.var_e64a4b9feecd6ef1[ aicategory ], self.var_6d758f0d37e445b5.var_2b6a1609554f72dd );
        }
        else
        {
            self.var_6d758f0d37e445b5.var_e64a4b9feecd6ef1[ aicategory ] = max( self.var_6d758f0d37e445b5.var_e64a4b9feecd6ef1[ aicategory ], self.var_6d758f0d37e445b5.var_a20b05324052a6b );
        }
        
        println( "<dev string:x265>" + getxhashsourcename( aicategory ) + "<dev string:x29a>" + self.var_6d758f0d37e445b5.var_e64a4b9feecd6ef1[ aicategory ] );
    }
}

