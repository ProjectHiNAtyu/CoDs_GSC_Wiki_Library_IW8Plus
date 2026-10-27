// scripts\mp\augments\zombie_augments.gsc  (hash_28b0cdf016eaa576.gscc) (size: 35160 Bytes / 0x8958 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc599f0c8 (3315200200)
// size ...... 35160 (0x8958)
// includes .. 16  (offset: 0x8188)
// strings ... 39  (offset: 0x8208)
// dev strs .. 86  (offset: 0x8534)
// exports ... 58  (offset: 0x6590)
// cseg ...... 0x411 + 0x617f (0x6590)
// imports ... 147 (offset: 0x6ea0)
// animtree1 . 0   (offset: 0x8958)
// animtree2 . 0   (offset: 0x8958)
#using script_16ea1b94f0f381b3;
#using script_1e4a6c98d6f83fe0;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\scene;
#using scripts\common\status_effects\status_effects;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\armor;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\common\utility\loot;
#using scripts\mp\damage;
#using scripts\mp\laststand;
#using scripts\mp\playerhealth;

#namespace zombie_augments;

// Namespace zombie_augments
// Params 0, eflags: 0x5
// Checksum 0x83674f0a, Offset: 0x42f
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zombie_augments", undefined, &init_augments, undefined );
}

// Namespace zombie_augments
// Params 0
// Checksum 0xa5ddac1f, Offset: 0x450
// Size: 0x65f
function init_augments()
{
    if ( !level.zombie_augments_in_use )
    {
        return;
    }
    
    level.zombie_augments = [];
    level.var_3d48b3ded8cd7762 = [];
    level.zombie_augments[ "none" ] = spawnstruct();
    level.zombie_augments[ "none" ].augmentname = "none";
    level.var_b60ad519f1d7ca9 = [];
    callback::add( #"player_death", &function_54447594f10ae4c3 );
    callback::add( #"player_connect", &zombie_augments_on_player_connect );
    callback::add( #"player_spawned", &zombie_augments_on_player_spawned );
    utility::registersharedfunc( #"zombie", #"player_has_augment", &player_has_augment );
    utility::registersharedfunc( #"zombie", #"hash_15ca371de3d570b9", &function_f28300e9927081f0 );
    utility::registersharedfunc( #"zombie", #"hash_da0b8e642d871723", &function_98d8ceb53a4377d2 );
    utility::registersharedfunc( #"zombie", #"hash_fc017b4ab1759c43", &function_40b5e57ebb41796a );
    utility::registersharedfunc( #"zombie", #"hash_cdf6ce9b64729ea3", &function_c659d108d058aee );
    utility::registersharedfunc( #"zombie", #"hash_e895853edab9ed9b", &function_fa931f04bafb8f68 );
    utility::registersharedfunc( #"zombie", #"hash_c79aa134f08a6b6a", &function_8f49f77c9e468133 );
    utility::registersharedfunc( #"zombie", #"hash_6104e890a5cf3101", &function_1b9d0e4f166a4314 );
    utility::registersharedfunc( #"zombie", #"hash_f5dd6051946ae612", &function_3880026014e369cd );
    utility::registersharedfunc( #"zombie", #"hash_555f057b4e2d44f8", &function_fbf1a761f406d3d5 );
    utility::registersharedfunc( #"zombie", #"hash_dcff2d0c4d9b34ce", &function_5e33ff407f504c6b );
    utility::registersharedfunc( #"zombie", #"hash_8bd9ed022653701d", &function_58257e914c3ccf9e );
    utility::registersharedfunc( #"zombie", #"hash_d654f8d8c48840f", &function_fa474c76d4223324 );
    utility::registersharedfunc( #"zombie", #"hash_fb5407d9c2bf5a3c", &function_d217c2753618000f );
    utility::registersharedfunc( #"zombie", #"hash_d786003560132ad3", &function_10e6e9f2377297ac );
    utility::registersharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", &function_eb6eda6dd4bf18cb );
    utility::registersharedfunc( #"zombie", #"hash_f99b1e81a50f8886", &function_324d550f249c97c6 );
    utility::registersharedfunc( #"zombie", #"hash_1bb7010420d4bb53", &function_5808e7eb8ea59a3 );
    utility::registersharedfunc( #"zombie", #"hash_5ce026fb7bbda595", &function_7e9d3219104a3c94 );
    utility::registersharedfunc( #"zombie", #"hash_eb3e39f22c20878c", &function_eae5368ab01aaa9f );
    utility::registersharedfunc( #"zombie", #"hash_d99535fac86238ac", &function_a049aaca693a5205 );
    utility::registersharedfunc( #"zombie", #"hash_98ae30337a2ab40e", &function_6fedefd2388cfc5b );
    utility::registersharedfunc( #"zombie", #"hash_ce4704a324ef399f", &function_aac93cc049fd5090 );
    utility::registersharedfunc( #"zombie", #"hash_4f9869dbac8ed658", &function_1a56162ae28c662b );
    scene::function_85b13b837056bc8b( &function_e5b19517cb74fda7 );
    var_c8a341ae041e295 = getscriptbundle( level.gametypebundle.var_fdfa64f134fb7bb3 ?? level.gamemodebundle.var_fdfa64f134fb7bb3 );
    level.var_6dcdf8523d43f28f = var_c8a341ae041e295.var_850b4b9796353ac5 ?? [];
    level.var_27b2d2f16f8663ac = var_c8a341ae041e295.var_ec68e98b077e9372 ?? [];
    level.var_9a95556713e1d70c = var_c8a341ae041e295.var_36a6114fdcf4f626 ?? [];
    var_5c27c837e8fbbd3c = getdvarint( @"hash_7cd6c08fab82d233", 1 );
    
    foreach ( i, var_14ed5286d1bf5ebf in var_c8a341ae041e295.var_1deac75ed05e8444 )
    {
        if ( !isdefined( var_14ed5286d1bf5ebf.var_26750c2e741d4ccb ) )
        {
            continue;
        }
        
        augmentbundle = getscriptbundle( var_14ed5286d1bf5ebf.var_26750c2e741d4ccb );
        augmentname = augmentbundle.augmentname;
        
        if ( augmentname )
        {
            if ( var_5c27c837e8fbbd3c )
            {
                augmentbundle.unlocktype = undefined;
                augmentbundle.rarity = undefined;
                augmentbundle.visibilitylevel = undefined;
                augmentbundle.availableprojects = undefined;
                augmentbundle.unlockableprojects = undefined;
                augmentbundle.availableoffline = undefined;
                augmentbundle.var_15642e668475ba1a = undefined;
                augmentbundle.icon = undefined;
                augmentbundle.availablegamemodes = undefined;
                augmentbundle.var_7352c2073d1e6cec = undefined;
                augmentbundle.var_5cfb1af2fd2e5eac = undefined;
            }
            
            level.zombie_augments[ augmentname ] = augmentbundle;
            level.zombie_augments[ augmentname ].id = i + 1;
            level.var_3d48b3ded8cd7762[ level.zombie_augments[ augmentname ].id ] = augmentname;
            
            if ( augmentbundle.var_9f9a3afac6467400 > 0 )
            {
                level.var_b60ad519f1d7ca9[ level.var_b60ad519f1d7ca9.size ] = augmentname;
            }
            
            continue;
        }
        
        /#
            iprintlnbold( "<dev string:x24>" + var_14ed5286d1bf5ebf.var_26750c2e741d4ccb );
        #/
    }
    
    level.var_6194e300b7c6d351 = DyingWishLastChance::register();
    zombie_utils::function_dfae6a5bd222c586( &function_17fdfda41f9aa95a );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_e611f94500a0ce8", &function_7e16885c27956ff9 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_c4af8787e3b7183c", &function_83730e6a6e980360 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_3a0ae2589665454d", &function_ca476fa0ae102ab7 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"remove_all_augments", &remove_all_augments );
    level notify( #"zm_augments_init" );
    
    /#
        level thread setup_augments_devgui();
    #/
}

// Namespace zombie_augments
// Params 1
// Checksum 0xf47b660e, Offset: 0xab7
// Size: 0x82
function function_1a56162ae28c662b( var_69d14bf9a185f001 = 1 )
{
    var_e121d8c4f4342b29 = 0;
    
    if ( ( !var_69d14bf9a185f001 || utility::callsharedfunc( #"hash_e7a7d049d5f06935", #"hash_81cf46be569bf3bb", "specialty_quickrevive" ) ) && player_has_augment( #"quick_revive_dying_wish" ) )
    {
        if ( !isdefined( self.var_6f9595e5de90c2aa ) )
        {
            self.var_6f9595e5de90c2aa = 0;
        }
        
        var_e121d8c4f4342b29 = 3 - self.var_6f9595e5de90c2aa;
    }
    
    return var_e121d8c4f4342b29;
}

// Namespace zombie_augments
// Params 1
// Checksum 0xd8296adf, Offset: 0xb42
// Size: 0x13
function function_54447594f10ae4c3( sparams )
{
    function_5808e7eb8ea59a3();
}

// Namespace zombie_augments
// Params 1
// Checksum 0xa890d310, Offset: 0xb5d
// Size: 0x85
function function_e5b19517cb74fda7( sparams )
{
    foreach ( player in level.players )
    {
        player function_5808e7eb8ea59a3();
    }
}

// Namespace zombie_augments
// Params 2
// Checksum 0xe0f19931, Offset: 0xbea
// Size: 0x2f0
function function_324d550f249c97c6( var_6e4804e17287761c = 0, var_10a236a6b0ae505 = 0 )
{
    if ( !isdefined( level.var_6194e300b7c6d351 ) )
    {
        return;
    }
    
    if ( self isplayingxcam() || utility::ent_flag( "scene_active" ) )
    {
        return;
    }
    
    if ( !level.var_6194e300b7c6d351 DyingWishLastChance::is_open( self ) )
    {
        level.var_6194e300b7c6d351 DyingWishLastChance::open( self );
        
        if ( var_6e4804e17287761c )
        {
            level.var_6194e300b7c6d351 DyingWishLastChance::function_30b62bb66ae155a( self, 0 );
            level.var_6194e300b7c6d351 DyingWishLastChance::function_4d07e9a9329fb1bf( self, 1 );
            level.var_6194e300b7c6d351 DyingWishLastChance::function_ed4c3f6e49331aef( self, 0 );
            var_e121d8c4f4342b29 = 3 - self.var_6f9595e5de90c2aa;
            
            if ( var_e121d8c4f4342b29 < 0 )
            {
                var_e121d8c4f4342b29 = 0;
            }
            
            level.var_6194e300b7c6d351 DyingWishLastChance::function_86b9774ae7a14968( self, var_e121d8c4f4342b29 );
        }
        else if ( var_10a236a6b0ae505 )
        {
            level.var_6194e300b7c6d351 DyingWishLastChance::function_30b62bb66ae155a( self, 1 );
            level.var_6194e300b7c6d351 DyingWishLastChance::function_4d07e9a9329fb1bf( self, 0 );
            level.var_6194e300b7c6d351 DyingWishLastChance::function_ed4c3f6e49331aef( self, 0 );
            var_c43606613df86f6 = self.w_mod_savior_uses ?? 3;
            level.var_6194e300b7c6d351 DyingWishLastChance::function_cb231cb6c45dedc8( self, var_c43606613df86f6 );
        }
        else
        {
            var_e121d8c4f4342b29 = 3 - self.var_84cde01ffd2cb360;
            
            if ( var_e121d8c4f4342b29 < 0 )
            {
                var_e121d8c4f4342b29 = 0;
            }
            
            level.var_6194e300b7c6d351 DyingWishLastChance::function_2c729362688b0b38( self, var_e121d8c4f4342b29 );
            level.var_6194e300b7c6d351 DyingWishLastChance::function_30b62bb66ae155a( self, 0 );
            level.var_6194e300b7c6d351 DyingWishLastChance::function_4d07e9a9329fb1bf( self, 0 );
            level.var_6194e300b7c6d351 DyingWishLastChance::function_ed4c3f6e49331aef( self, 1 );
        }
        
        thread function_cababc718ac13fdd();
        return;
    }
    
    if ( var_6e4804e17287761c )
    {
        level.var_6194e300b7c6d351 DyingWishLastChance::function_30b62bb66ae155a( self, 0 );
        level.var_6194e300b7c6d351 DyingWishLastChance::function_4d07e9a9329fb1bf( self, 1 );
        level.var_6194e300b7c6d351 DyingWishLastChance::function_ed4c3f6e49331aef( self, 0 );
        var_e121d8c4f4342b29 = 3 - self.var_6f9595e5de90c2aa;
        
        if ( var_e121d8c4f4342b29 < 0 )
        {
            var_e121d8c4f4342b29 = 0;
        }
        
        level.var_6194e300b7c6d351 DyingWishLastChance::function_86b9774ae7a14968( self, var_e121d8c4f4342b29 );
        return;
    }
    
    if ( var_10a236a6b0ae505 )
    {
        level.var_6194e300b7c6d351 DyingWishLastChance::function_30b62bb66ae155a( self, 1 );
        level.var_6194e300b7c6d351 DyingWishLastChance::function_4d07e9a9329fb1bf( self, 0 );
        level.var_6194e300b7c6d351 DyingWishLastChance::function_ed4c3f6e49331aef( self, 0 );
        var_c43606613df86f6 = self.w_mod_savior_uses ?? 3;
        level.var_6194e300b7c6d351 DyingWishLastChance::function_cb231cb6c45dedc8( self, var_c43606613df86f6 );
        return;
    }
    
    var_e121d8c4f4342b29 = 3 - self.var_84cde01ffd2cb360;
    
    if ( var_e121d8c4f4342b29 < 0 )
    {
        var_e121d8c4f4342b29 = 0;
    }
    
    level.var_6194e300b7c6d351 DyingWishLastChance::function_2c729362688b0b38( self, var_e121d8c4f4342b29 );
    level.var_6194e300b7c6d351 DyingWishLastChance::function_30b62bb66ae155a( self, 0 );
    level.var_6194e300b7c6d351 DyingWishLastChance::function_4d07e9a9329fb1bf( self, 0 );
    level.var_6194e300b7c6d351 DyingWishLastChance::function_ed4c3f6e49331aef( self, 1 );
    thread function_cababc718ac13fdd();
}

// Namespace zombie_augments
// Params 0
// Checksum 0xea0b6b8f, Offset: 0xee2
// Size: 0x33
function function_cababc718ac13fdd()
{
    self notify( #"hash_8da50e06bacddb08" );
    self endon( #"hash_8da50e06bacddb08" );
    self endon( #"death_or_disconnect" );
    wait 5;
    function_5808e7eb8ea59a3();
}

// Namespace zombie_augments
// Params 0
// Checksum 0x9f4c6c2d, Offset: 0xf1d
// Size: 0x35
function function_5808e7eb8ea59a3()
{
    if ( !isdefined( level.var_6194e300b7c6d351 ) )
    {
        return;
    }
    
    if ( level.var_6194e300b7c6d351 DyingWishLastChance::is_open( self ) )
    {
        level.var_6194e300b7c6d351 DyingWishLastChance::close( self );
    }
}

// Namespace zombie_augments
// Params 1
// Checksum 0xfc036e89, Offset: 0xf5a
// Size: 0xe
function function_17fdfda41f9aa95a( params )
{
    return -1;
}

// Namespace zombie_augments
// Params 2
// Checksum 0xbe799f0f, Offset: 0xf71
// Size: 0x17e
function function_c9cb0ae85eefe639( augmentname, reason = #"unknown" )
{
    if ( !level.zombie_augments_in_use )
    {
        return;
    }
    
    augmentbundle = level.zombie_augments[ augmentname ];
    
    if ( !isdefined( augmentbundle ) )
    {
        return;
    }
    
    augmenttype = augmentbundle.augmenttype;
    ismajor = augmentbundle.ismajor;
    
    if ( ismajor )
    {
        if ( !arraycontains( self.zombie_augments[ augmenttype ].var_cafcc8be001cb0de, augmentname ) )
        {
            majorindex = self.zombie_augments[ augmenttype ].var_cafcc8be001cb0de.size;
            self.zombie_augments[ augmenttype ].var_cafcc8be001cb0de[ majorindex ] = augmentname;
        }
    }
    else if ( !arraycontains( self.zombie_augments[ augmenttype ].var_41a892151199064a, augmentname ) )
    {
        minorindex = self.zombie_augments[ augmenttype ].var_41a892151199064a.size;
        self.zombie_augments[ augmenttype ].var_41a892151199064a[ minorindex ] = augmentname;
    }
    
    params = { #reason:reason, #ismajor:ismajor, #augmenttype:augmenttype, #augmentname:augmentname };
    callback::callback( "on_player_augment_given", params );
}

// Namespace zombie_augments
// Params 3
// Checksum 0xa8cba53, Offset: 0x10f7
// Size: 0x1b7
function function_a049aaca693a5205( augmentname, var_5d4d563c38f4c7ed = 0, reason = #"unknown" )
{
    if ( !level.zombie_augments_in_use )
    {
        return;
    }
    
    if ( utility::callsharedfunc( #"zombie", #"hash_8bb723b1f8109716", augmentname ) )
    {
        return;
    }
    
    augmentbundle = level.zombie_augments[ augmentname ];
    
    if ( !isdefined( augmentbundle ) )
    {
        return;
    }
    
    augmenttype = augmentbundle.augmenttype;
    ismajor = augmentbundle.ismajor;
    
    if ( var_5d4d563c38f4c7ed )
    {
        if ( function_b0d3026dadf39ee5( augmenttype, ismajor ) )
        {
            return;
        }
    }
    
    var_1edd37b3f9ac79bd = "none";
    
    if ( ismajor )
    {
        var_1edd37b3f9ac79bd = self.zombie_augments[ augmenttype ].majorname;
        self.zombie_augments[ augmenttype ].majorname = augmentname;
    }
    else
    {
        var_1edd37b3f9ac79bd = self.zombie_augments[ augmenttype ].minorname;
        self.zombie_augments[ augmenttype ].minorname = augmentname;
    }
    
    if ( var_1edd37b3f9ac79bd != "none" )
    {
        params = { #ismajor:ismajor, #augmenttype:augmenttype, #var_1edd37b3f9ac79bd:var_1edd37b3f9ac79bd };
        callback::callback( "on_player_augment_taken", params );
    }
    
    params = { #reason:reason, #ismajor:ismajor, #augmenttype:augmenttype, #augmentname:augmentname };
    callback::callback( "on_player_augment_given", params );
}

// Namespace zombie_augments
// Params 1
// Checksum 0xb598215, Offset: 0x12b6
// Size: 0xf6
function function_6fedefd2388cfc5b( augmentname )
{
    if ( !level.zombie_augments_in_use )
    {
        return;
    }
    
    if ( player_has_augment( augmentname ) )
    {
        augmentbundle = level.zombie_augments[ augmentname ];
        augmenttype = augmentbundle.augmenttype;
        ismajor = augmentbundle.ismajor;
        
        if ( ismajor )
        {
            self.zombie_augments[ augmenttype ].majorname = "none";
        }
        else
        {
            self.zombie_augments[ augmenttype ].minorname = "none";
        }
        
        params = { #augment:self.zombie_augments[ augmenttype ], #ismajor:ismajor, #augmenttype:augmenttype, #augmentname:augmentname };
        callback::callback( "on_player_augment_taken", params );
    }
}

// Namespace zombie_augments
// Params 1
// Checksum 0xff2b88e4, Offset: 0x13b4
// Size: 0x129
function function_f28300e9927081f0( ammomodname )
{
    if ( isdefined( ammomodname ) )
    {
        ammomodname = getxhash( ammomodname );
        var_b0deb61cc9f45fb5 = "none";
        var_b490b4f52d9fe69 = "none";
        
        if ( isdefined( self.zombie_augments[ ammomodname ] ) )
        {
            var_b0deb61cc9f45fb5 = self.zombie_augments[ ammomodname ].majorname;
            var_b490b4f52d9fe69 = self.zombie_augments[ ammomodname ].minorname;
        }
        
        cooldownreduced = 0;
        
        if ( var_b0deb61cc9f45fb5 != "none" && isdefined( level.zombie_augments[ var_b0deb61cc9f45fb5 ] ) && isdefined( level.zombie_augments[ var_b0deb61cc9f45fb5 ].ammomodcooldown ) )
        {
            cooldownreduced += level.zombie_augments[ var_b0deb61cc9f45fb5 ].ammomodcooldown;
        }
        
        if ( var_b490b4f52d9fe69 != "none" && isdefined( level.zombie_augments[ var_b490b4f52d9fe69 ] ) && isdefined( level.zombie_augments[ var_b490b4f52d9fe69 ].ammomodcooldown ) )
        {
            cooldownreduced += level.zombie_augments[ var_b490b4f52d9fe69 ].ammomodcooldown;
        }
        
        return cooldownreduced;
    }
    
    return 0;
}

// Namespace zombie_augments
// Params 2
// Checksum 0xd058597c, Offset: 0x14e6
// Size: 0x151
function function_98d8ceb53a4377d2( ammomodname, cooldown = 1 )
{
    if ( isdefined( ammomodname ) )
    {
        ammomodname = getxhash( ammomodname );
        var_b0deb61cc9f45fb5 = "none";
        var_b490b4f52d9fe69 = "none";
        
        if ( isdefined( self.zombie_augments[ ammomodname ] ) )
        {
            var_b0deb61cc9f45fb5 = self.zombie_augments[ ammomodname ].majorname;
            var_b490b4f52d9fe69 = self.zombie_augments[ ammomodname ].minorname;
        }
        
        cooldownmodifier = 0;
        newcooldown = cooldown;
        
        if ( var_b0deb61cc9f45fb5 != "none" && isdefined( level.zombie_augments[ var_b0deb61cc9f45fb5 ] ) && isdefined( level.zombie_augments[ var_b0deb61cc9f45fb5 ].var_10fca521ede5ea4e ) )
        {
            cooldownmodifier = level.zombie_augments[ var_b0deb61cc9f45fb5 ].var_10fca521ede5ea4e;
        }
        
        if ( var_b490b4f52d9fe69 != "none" && isdefined( level.zombie_augments[ var_b490b4f52d9fe69 ] ) && isdefined( level.zombie_augments[ var_b490b4f52d9fe69 ].var_10fca521ede5ea4e ) )
        {
            cooldownmodifier = level.zombie_augments[ var_b490b4f52d9fe69 ].var_10fca521ede5ea4e;
        }
        
        newcooldown = max( cooldown - cooldown * cooldownmodifier, 0 );
        return newcooldown;
    }
    
    return cooldown;
}

// Namespace zombie_augments
// Params 1
// Checksum 0xc67b25a9, Offset: 0x1640
// Size: 0x1a8
function function_40b5e57ebb41796a( ammomodname )
{
    if ( isdefined( ammomodname ) )
    {
        ammomodname = getxhash( ammomodname );
        var_b0deb61cc9f45fb5 = "none";
        var_b490b4f52d9fe69 = "none";
        
        if ( isdefined( self.zombie_augments[ ammomodname ] ) )
        {
            var_b0deb61cc9f45fb5 = self.zombie_augments[ ammomodname ].majorname;
            var_b490b4f52d9fe69 = self.zombie_augments[ ammomodname ].minorname;
        }
        
        if ( var_b0deb61cc9f45fb5 != "none" && isdefined( level.zombie_augments[ var_b0deb61cc9f45fb5 ] ) && isdefined( level.zombie_augments[ var_b0deb61cc9f45fb5 ].var_9f9a3afac6467400 ) )
        {
            return level.zombie_augments[ var_b0deb61cc9f45fb5 ].var_9f9a3afac6467400;
        }
        else if ( var_b490b4f52d9fe69 != "none" && isdefined( level.zombie_augments[ var_b490b4f52d9fe69 ] ) && isdefined( level.zombie_augments[ var_b490b4f52d9fe69 ].var_9f9a3afac6467400 ) )
        {
            return level.zombie_augments[ var_b490b4f52d9fe69 ].var_9f9a3afac6467400;
        }
        
        foreach ( var_cda8051fc2da52d6 in level.var_b60ad519f1d7ca9 )
        {
            if ( function_8a71e350d2251381( var_cda8051fc2da52d6 ) )
            {
                return level.zombie_augments[ var_cda8051fc2da52d6 ].var_9f9a3afac6467400;
            }
        }
    }
    
    return 0;
}

// Namespace zombie_augments
// Params 1
// Checksum 0xaf4c4be6, Offset: 0x17f1
// Size: 0x118
function function_c659d108d058aee( ammomodname )
{
    if ( isdefined( ammomodname ) )
    {
        ammomodname = getxhash( ammomodname );
        var_b0deb61cc9f45fb5 = "none";
        var_b490b4f52d9fe69 = "none";
        
        if ( isdefined( self.zombie_augments[ ammomodname ] ) )
        {
            var_b0deb61cc9f45fb5 = self.zombie_augments[ ammomodname ].majorname;
            var_b490b4f52d9fe69 = self.zombie_augments[ ammomodname ].minorname;
        }
        
        if ( var_b0deb61cc9f45fb5 != "none" && isdefined( level.zombie_augments[ var_b0deb61cc9f45fb5 ] ) && isdefined( level.zombie_augments[ var_b0deb61cc9f45fb5 ].var_add1dbea796f093b ) )
        {
            return level.zombie_augments[ var_b0deb61cc9f45fb5 ].var_add1dbea796f093b;
        }
        else if ( var_b490b4f52d9fe69 != "none" && isdefined( level.zombie_augments[ var_b490b4f52d9fe69 ] ) && isdefined( level.zombie_augments[ var_b490b4f52d9fe69 ].var_add1dbea796f093b ) )
        {
            return level.zombie_augments[ var_b490b4f52d9fe69 ].var_add1dbea796f093b;
        }
    }
    
    return 0;
}

// Namespace zombie_augments
// Params 2
// Checksum 0x6d48b6f8, Offset: 0x1912
// Size: 0x2b
function function_d217c2753618000f( augmentname, var_855ec63389d2bef6 = 0 )
{
    self.var_34530cea34733ad0[ augmentname ] = var_855ec63389d2bef6;
}

// Namespace zombie_augments
// Params 1
// Checksum 0x7bacc942, Offset: 0x1945
// Size: 0xc0
function function_10e6e9f2377297ac( points = 0 )
{
    foreach ( var_d6d93610964027bc, hasbuff in self.var_34530cea34733ad0 )
    {
        if ( hasbuff && isdefined( level.zombie_augments[ var_d6d93610964027bc ] ) )
        {
            points += points * ( level.zombie_augments[ var_d6d93610964027bc ].var_bc0667ec1134e729 ?? 0.2 );
        }
    }
    
    return points;
}

// Namespace zombie_augments
// Params 1
// Checksum 0x8dd73a48, Offset: 0x1a0e
// Size: 0x7e3
function function_fbf1a761f406d3d5( sparams )
{
    idamage = sparams.idamage;
    
    if ( idamage < 0 )
    {
        idamage = 1;
    }
    
    foreach ( var_1617dd51250abbbc, hasbuff in self.var_bd752fd42b2e2193 )
    {
        if ( hasbuff && isdefined( level.zombie_augments[ var_1617dd51250abbbc ] ) )
        {
            idamage = int( clamp( idamage - idamage * ( level.zombie_augments[ var_1617dd51250abbbc ].var_c9c15e179d5eefad ?? 0.1 ), 0, idamage ) );
        }
    }
    
    if ( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_elemental_pop", #"elemental_pop_elemental_protection" ) )
    {
        if ( !isdefined( self.var_436d1d31c48df750 ) )
        {
            self.var_436d1d31c48df750 = 0;
        }
        
        chance = level.zombie_augments[ #"elemental_pop_elemental_protection" ].var_371da9b0b34b2caa;
        cooldownmult = level.perkbundles[ "specialty_elemental_pop" ].var_54d8132e73b1be17 ?? 2;
        currentcooldown = 0;
        
        if ( isdefined( self.var_9db3c6b649ecf485 ) )
        {
            currentcooldown = level.ammo_mods[ self.var_9db3c6b649ecf485 ].var_d8565ba5d24b8a01;
        }
        
        cooldown = cooldownmult * currentcooldown;
        
        if ( cooldown < level.perkbundles[ "specialty_elemental_pop" ].var_8b4c0ca328de0b6d )
        {
            cooldown = level.perkbundles[ "specialty_elemental_pop" ].var_8b4c0ca328de0b6d;
        }
        
        if ( isdefined( sparams ) && isdefined( sparams.eattacker ) && utility::percent_chance( chance ) && idamage > 1 && self.var_436d1d31c48df750 + utility::function_4b74c15943231980( cooldown ) < gettime() )
        {
            is_boss = isdefined( sparams.eattacker.aicategory ) && sparams.eattacker.aicategory == "boss";
            b_is_last_zombie = utility::callsharedfunc( #"zombie", #"hash_55b419086029b9a2", sparams.eattacker );
            
            if ( !is_boss && !b_is_last_zombie && utility::issharedfuncdefined( #"zombie", #"hash_a2a2812a52ad2527" ) )
            {
                meansofdeath = "MOD_PISTOL_BULLET";
                sparams.eattacker utility::callsharedfunc( #"zombie", #"hash_a2a2812a52ad2527", sparams, idamage, self, meansofdeath );
                idamage = abs( idamage - idamage * ( level.zombie_augments[ #"elemental_pop_elemental_protection" ].var_3df7d3e30f9efb5d ?? 0 ) );
            }
        }
    }
    
    var_73ec65db8ea0b60b = 0;
    modifieddamage = 0;
    
    if ( sparams.smeansofdeath == "MOD_FALLING" )
    {
        modifieddamage = damage::modifyfalldamage( self, idamage, sparams.idflags, sparams.smeansofdeath );
        
        if ( modifieddamage < idamage )
        {
            var_73ec65db8ea0b60b = 1;
        }
        else if ( self isdiving() && utility::callsharedfunc( #"hash_e7a7d049d5f06935", #"hash_81cf46be569bf3bb", "specialty_phd_flopper" ) )
        {
            var_73ec65db8ea0b60b = 1;
        }
        else if ( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_staminup", #"staminup_light_footed" ) )
        {
            var_73ec65db8ea0b60b = 1;
        }
    }
    
    if ( sparams.smeansofdeath == "MOD_SUICIDE" && isdefined( sparams.objweapon ) )
    {
        equipmentref = "none";
        
        if ( utility::issharedfuncdefined( #"equipment", #"getequipmentreffromweapon" ) )
        {
            equipmentref = self [[ utility::getsharedfunc( #"equipment", #"getequipmentreffromweapon" ) ]]( sparams.objweapon );
        }
        
        if ( equipmentref == "equip_frag" )
        {
            if ( utility::callsharedfunc( #"hash_e7a7d049d5f06935", #"hash_81cf46be569bf3bb", "specialty_phd_flopper" ) )
            {
                var_73ec65db8ea0b60b = 1;
            }
        }
    }
    
    attacker = sparams.eattacker;
    
    if ( attacker.classname == "worldspawn" )
    {
        attacker = undefined;
    }
    
    shouldreturn = damage::filterdamage( sparams.einflictor, attacker, self, sparams.idamage, sparams.idflags, sparams.smeansofdeath, sparams.objweapon, sparams.shitloc );
    
    if ( shouldreturn )
    {
        var_73ec65db8ea0b60b = 1;
    }
    
    if ( self.health - idamage <= 0 && !var_73ec65db8ea0b60b && val::get( "damage" ) )
    {
        [ healthdamage, lightarmordamage ] = armor::function_4875d04d69b22ae( sparams.eattacker, sparams.einflictor, self, sparams.idamage, sparams.objweapon, sparams.smeansofdeath, sparams.shitloc, sparams.idflags, sparams.var_cdd29ad5d1362c2, sparams.unmodifieddamage, sparams.partname, 1 );
        
        if ( self.health - healthdamage <= 0 )
        {
            /#
                iprintln( "<dev string:x39>" + healthdamage );
            #/
            
            if ( !isdefined( self.var_6f9595e5de90c2aa ) )
            {
                self.var_6f9595e5de90c2aa = 0;
            }
            
            if ( !self.var_ceb069654e508d3d && level.var_bf82e408b7a0e3c3 && laststand::function_7072b516e6cffb7c() )
            {
                idamage = 1;
                remaininghealth = level.zombie_augments[ #"quick_revive_dying_wish" ].var_dfaa48935da75e60 ?? 0;
                duration = level.zombie_augments[ #"quick_revive_dying_wish" ].var_1b2cf3087683f326 ?? 0;
                self.health = remaininghealth + idamage;
                self.var_ceb069654e508d3d = 1;
                self playsound( #"hash_502c7080fd3d0228" );
                thread function_b045bcfa8403e6e1( duration );
                
                if ( isdefined( level.removeselfrevivetoken ) )
                {
                    self [[ level.removeselfrevivetoken ]]( 1, 0 );
                }
            }
            else if ( !self.var_ceb069654e508d3d && self.var_6f9595e5de90c2aa < 3 && utility::issharedfuncdefined( #"hash_e7a7d049d5f06935", #"hash_81cf46be569bf3bb" ) && utility::callsharedfunc( #"hash_e7a7d049d5f06935", #"hash_81cf46be569bf3bb", "specialty_quickrevive" ) && player_has_augment( #"quick_revive_dying_wish" ) )
            {
                self.var_6f9595e5de90c2aa++;
                function_324d550f249c97c6( 1 );
                idamage = 1;
                remaininghealth = level.zombie_augments[ #"quick_revive_dying_wish" ].var_dfaa48935da75e60 ?? 0;
                duration = level.zombie_augments[ #"quick_revive_dying_wish" ].var_1b2cf3087683f326 ?? 0;
                self.health = remaininghealth + idamage;
                self.var_ceb069654e508d3d = 1;
                self playsound( #"hash_502c7080fd3d0228" );
                thread function_b045bcfa8403e6e1( duration );
                zombie_perks::take_perk( "specialty_quickrevive" );
            }
        }
    }
    
    return idamage;
}

// Namespace zombie_augments
// Params 1, eflags: 0x4
// Checksum 0x17e9cd37, Offset: 0x21fa
// Size: 0x4c
function private function_b045bcfa8403e6e1( duration )
{
    self endon( #"disconnect" );
    wait duration;
    self.var_ceb069654e508d3d = undefined;
    
    if ( self )
    {
        if ( !status_effects::has_status_effect_type( "wound" ) )
        {
            playerhealth::forcehealthregen( self, 1 );
            return;
        }
        
        thread function_99f73370291fa4ed();
    }
}

// Namespace zombie_augments
// Params 0, eflags: 0xc
// Checksum 0x8374405c, Offset: 0x224e
// Size: 0x41
function private function_99f73370291fa4ed()
{
    self notify( #"hash_711e8142a63cede6" );
    self endon( #"hash_711e8142a63cede6" );
    self endon( #"death_or_disconnect" );
    self waittill( #"hash_d3073c1d39f5eb56" );
    
    if ( self )
    {
        playerhealth::forcehealthregen( self, 1 );
    }
}

// Namespace zombie_augments
// Params 1
// Checksum 0x2a990ae0, Offset: 0x2297
// Size: 0xc4
function function_3880026014e369cd( idamage )
{
    if ( !isnumber( idamage ) )
    {
        return 0;
    }
    
    foreach ( var_b1cd36f79a285649, hasbuff in self.var_2de028ea974579b5 )
    {
        if ( hasbuff && isdefined( level.zombie_augments[ var_b1cd36f79a285649 ] ) )
        {
            idamage += idamage * ( level.zombie_augments[ var_b1cd36f79a285649 ].var_e3d0eb79fd6fe167 ?? 0.1 );
        }
    }
    
    return idamage;
}

// Namespace zombie_augments
// Params 1
// Checksum 0xa004fff, Offset: 0x2364
// Size: 0xb4
function function_5e33ff407f504c6b( idamage )
{
    foreach ( var_b1cd36f79a285649, hasbuff in self.var_8fbd699dbed14e85 )
    {
        if ( hasbuff && isdefined( level.zombie_augments[ var_b1cd36f79a285649 ] ) )
        {
            idamage += idamage * ( level.zombie_augments[ var_b1cd36f79a285649 ].var_ddb8618a8776472 ?? 0 );
        }
    }
    
    return idamage;
}

// Namespace zombie_augments
// Params 1
// Checksum 0x96e3024, Offset: 0x2421
// Size: 0x47
function function_1b9d0e4f166a4314( augmentname )
{
    var_ae248968c78c7a09 = 0;
    
    if ( isdefined( level.zombie_augments[ augmentname ] ) )
    {
        var_ae248968c78c7a09 = level.zombie_augments[ augmentname ].var_e3d0eb79fd6fe167 ?? 0;
    }
    
    return var_ae248968c78c7a09;
}

// Namespace zombie_augments
// Params 1
// Checksum 0x803b5405, Offset: 0x2471
// Size: 0x118
function function_fa931f04bafb8f68( ammomodname )
{
    if ( isdefined( ammomodname ) )
    {
        ammomodname = getxhash( ammomodname );
        var_b0deb61cc9f45fb5 = "none";
        var_b490b4f52d9fe69 = "none";
        
        if ( isdefined( self.zombie_augments[ ammomodname ] ) )
        {
            var_b0deb61cc9f45fb5 = self.zombie_augments[ ammomodname ].majorname;
            var_b490b4f52d9fe69 = self.zombie_augments[ ammomodname ].minorname;
        }
        
        if ( var_b0deb61cc9f45fb5 != "none" && isdefined( level.zombie_augments[ var_b0deb61cc9f45fb5 ] ) && isdefined( level.zombie_augments[ var_b0deb61cc9f45fb5 ].var_fbe96acb6cba1933 ) )
        {
            return level.zombie_augments[ var_b0deb61cc9f45fb5 ].var_fbe96acb6cba1933;
        }
        else if ( var_b490b4f52d9fe69 != "none" && isdefined( level.zombie_augments[ var_b490b4f52d9fe69 ] ) && isdefined( level.zombie_augments[ var_b490b4f52d9fe69 ].var_fbe96acb6cba1933 ) )
        {
            return level.zombie_augments[ var_b490b4f52d9fe69 ].var_fbe96acb6cba1933;
        }
    }
    
    return 0;
}

// Namespace zombie_augments
// Params 0
// Checksum 0xfee9df0e, Offset: 0x2592
// Size: 0x49
function function_8f49f77c9e468133()
{
    if ( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_elemental_pop", #"elemental_pop_advantage" ) )
    {
        return level.zombie_augments[ #"elemental_pop_advantage" ].var_ec1390b1caa727e3;
    }
}

// Namespace zombie_augments
// Params 2
// Checksum 0xe397a2e0, Offset: 0x25e3
// Size: 0x76, Type: bool
function function_eb6eda6dd4bf18cb( perkname, augmentname )
{
    if ( !level.zombie_augments_in_use )
    {
        return false;
    }
    
    bhasperk = 0;
    
    if ( utility::issharedfuncdefined( #"hash_e7a7d049d5f06935", #"hash_81cf46be569bf3bb" ) )
    {
        bhasperk = utility::callsharedfunc( #"hash_e7a7d049d5f06935", #"hash_81cf46be569bf3bb", perkname );
    }
    
    return bhasperk && player_has_augment( augmentname );
}

// Namespace zombie_augments
// Params 1
// Checksum 0x8ffb175c, Offset: 0x2662
// Size: 0x1ff, Type: bool
function player_has_augment( augmentname )
{
    if ( !level.zombie_augments_in_use )
    {
        return false;
    }
    
    if ( augmentname == "none" )
    {
        return false;
    }
    
    augmentbundle = level.zombie_augments[ augmentname ];
    
    if ( isdefined( augmentbundle ) )
    {
        augmenttype = augmentbundle.augmenttype;
        ismajor = augmentbundle.ismajor;
        
        if ( ismajor )
        {
            if ( self.zombie_augments[ augmenttype ].majorname === augmentname )
            {
                return true;
            }
            
            if ( self.zombie_augments[ augmenttype ].var_cafcc8be001cb0de.size > 0 )
            {
                foreach ( var_da3fc8e45d230f3 in self.zombie_augments[ augmenttype ].var_cafcc8be001cb0de )
                {
                    if ( var_da3fc8e45d230f3 === augmentname )
                    {
                        return true;
                    }
                }
            }
        }
        else
        {
            if ( self.zombie_augments[ augmenttype ].minorname === augmentname )
            {
                return true;
            }
            
            if ( self.zombie_augments[ augmenttype ].var_41a892151199064a.size > 0 )
            {
                foreach ( var_da3fc8e45d230f3 in self.zombie_augments[ augmenttype ].var_41a892151199064a )
                {
                    if ( var_da3fc8e45d230f3 === augmentname )
                    {
                        return true;
                    }
                }
            }
        }
        
        if ( function_8a71e350d2251381( augmentname ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zombie_augments
// Params 2
// Checksum 0x710d48a9, Offset: 0x286a
// Size: 0x74, Type: bool
function function_b0d3026dadf39ee5( augmenttype, ismajor )
{
    if ( !isdefined( self.zombie_augments[ augmenttype ] ) )
    {
        return false;
    }
    
    if ( ismajor )
    {
        if ( self.zombie_augments[ augmenttype ].majorname === "none" )
        {
            return false;
        }
    }
    else if ( self.zombie_augments[ augmenttype ].minorname === "none" )
    {
        return false;
    }
    
    return true;
}

// Namespace zombie_augments
// Params 2
// Checksum 0x67ae6c48, Offset: 0x28e7
// Size: 0x61
function function_8a71e350d2251381( augmentname, objweapon )
{
    if ( !isplayer( self ) )
    {
        return 0;
    }
    
    if ( !( level.var_f636f2beb27e1cff.size > 0 ) )
    {
        return 0;
    }
    
    if ( !isdefined( objweapon ) )
    {
        objweapon = self getcurrentweapon();
    }
    
    var_8ff1b2ae4df035f8 = function_748bf65ee56d053b( augmentname );
    
    if ( isdefined( var_8ff1b2ae4df035f8 ) )
    {
        return getweaponhasperk( objweapon, var_8ff1b2ae4df035f8 );
    }
    
    return 0;
}

// Namespace zombie_augments
// Params 3
// Checksum 0xbb8bc91a, Offset: 0x2951
// Size: 0x6e
function function_fa474c76d4223324( duration, indexname, notifyname = "damagemitigationsingleton" )
{
    self endon( #"disconnect" );
    self notify( notifyname );
    self endon( notifyname );
    wait duration;
    
    if ( isplayer( self ) && isdefined( indexname ) && isdefined( self.var_bd752fd42b2e2193[ indexname ] ) )
    {
        self.var_bd752fd42b2e2193[ indexname ] = undefined;
    }
}

// Namespace zombie_augments
// Params 3
// Checksum 0xcee4baf2, Offset: 0x29c7
// Size: 0x6e
function function_58257e914c3ccf9e( duration, indexname, notifyname = "damagebuffsingleton" )
{
    self endon( #"disconnect" );
    self notify( notifyname );
    self endon( notifyname );
    wait duration;
    
    if ( isplayer( self ) && isdefined( indexname ) && isdefined( self.var_2de028ea974579b5[ indexname ] ) )
    {
        self.var_2de028ea974579b5[ indexname ] = undefined;
    }
}

// Namespace zombie_augments
// Params 1
// Checksum 0x8c71a999, Offset: 0x2a3d
// Size: 0xc
function function_f43d4a41cd272c07( params )
{
    
}

// Namespace zombie_augments
// Params 1
// Checksum 0xfdee0d6a, Offset: 0x2a51
// Size: 0x9d
function zombie_augments_on_player_spawned( params )
{
    if ( !isbot( self ) && self.pers[ "telemetry" ] )
    {
        if ( !isdefined( self.pers[ "telemetry" ].major_augments_unlocked ) )
        {
            self.pers[ "telemetry" ].major_augments_unlocked = 0;
        }
        
        if ( !isdefined( self.pers[ "telemetry" ].minor_augments_unlocked ) )
        {
            self.pers[ "telemetry" ].minor_augments_unlocked = 0;
        }
        
        thread function_cfbed8bdfe4bef76();
    }
}

// Namespace zombie_augments
// Params 0
// Checksum 0xaf806975, Offset: 0x2af6
// Size: 0x21f
function function_cfbed8bdfe4bef76()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    augmentids = [];
    var_6fa6805d62892d92 = [];
    
    foreach ( augmentbundle in level.zombie_augments )
    {
        if ( !isdefined( augmentbundle.lootid ) )
        {
            continue;
        }
        
        var_6fa6805d62892d92[ augmentbundle.lootid ] = istrue( augmentbundle.ismajor );
        augmentids[ augmentids.size ] = augmentbundle.lootid;
    }
    
    if ( !self function_3f4c4a69158afb68( augmentids ) )
    {
        return;
    }
    
    self waittill( #"loot_validation_result", results );
    assert( results.size == augmentids.size, "<dev string:x57>" + results.size + "<dev string:x65>" + augmentids.size + "<dev string:x78>" );
    
    foreach ( item in results )
    {
        if ( item.quantity > 0 )
        {
            if ( var_6fa6805d62892d92[ item.id ] )
            {
                self.pers[ "telemetry" ].major_augments_unlocked = self.pers[ "telemetry" ].major_augments_unlocked + 1;
                continue;
            }
            
            self.pers[ "telemetry" ].minor_augments_unlocked = self.pers[ "telemetry" ].minor_augments_unlocked + 1;
        }
    }
}

// Namespace zombie_augments
// Params 2
// Checksum 0x24b7d0cb, Offset: 0x2d1d
// Size: 0xa84
function function_f5145dc8a684fc24( value, var_5d4d563c38f4c7ed = 0 )
{
    set1 = [ 51:#"tesla_storm_lithium_charged", 50:#"tesla_storm_shockwave", 49:#"shatterblast_blast_zone", 48:#"shatterblast_blast_chain", 47:#"mary_paris_party_animal", 46:#"mary_paris_dance_party", 45:#"lightray_express_remedy", 44:#"lightray_big_game", 43:#"deathperception_extra_change", 42:#"deathperception_critical_eye", 41:#"frost_blast_high_capacity", 40:#"frost_blast_slick", 39:#"vulture_aid_picky_eater", 38:#"vulture_aid_parting_gift", 37:#"d_mod_double_or_nothing", 36:#"d_mod_double_standard", 35:#"frenzied_guard_extension", 34:#"frenzied_guard_frenzy_fire", 33:#"elemental_pop_more_pop", 32:#"elemental_pop_tuned_frequency", 31:#"phdflopper_slide_boost", 30:#"phdflopper_slider", 29:#"energy_mine_high_capacity", 28:#"energy_mine_spire", 27:#"deadwire_haste", 26:#"deadwire_lightning_strike", 25:#"deadshot_gunslinger", 24:#"deadshot_first_strike", 23:#"napalmburst_contact_burn", 22:#"napalmburst_pyro", 21:#"m_mod_hidden_impact", 20:#"m_mod_faster_melee", 19:#"dark_flare_high_capacity", 18:#"dark_flare_extension", 17:#"shadowvortex_supermassive", 16:#"shadowvortex_big_game", 15:#"aether_shroud_high_capacity", 14:#"aether_shroud_group_shroud", 13:#"staminup_speed_boost", 12:#"staminup_stalker", 11:#"quick_revive_payback", 10:#"quick_revive_dying_wish", 9:#"juggernog_thicker_plates", 8:#"juggernog_reactive_armor", 7:#"speedcola_faster_equipment", 6:#"speedcola_classic_formula", 5:#"healingaura_stoic_presence", 4:#"healingaura_keep_perks", 3:#"cryofreeze_focus", 2:#"cryofreeze_ice_cloud", 1:#"brainrot_haste", 0:#"brainrot_bloat" ];
    set2 = [ 51:#"tesla_storm_lithium_charged", 50:#"tesla_storm_shockwave", 49:#"shatterblast_blast_zone", 48:#"shatterblast_blast_chain", 47:#"mary_paris_party_animal", 46:#"mary_paris_dance_party", 45:#"lightray_express_remedy", 44:#"lightray_big_game", 43:#"deathperception_extra_change", 42:#"deathperception_critical_eye", 41:#"frost_blast_high_capacity", 40:#"frost_blast_slick", 39:#"vulture_aid_picky_eater", 38:#"vulture_aid_parting_gift", 37:#"d_mod_double_play", 36:#"d_mod_double_standard", 35:#"frenzied_guard_extension", 34:#"frenzied_guard_frenzy_fire", 33:#"elemental_pop_more_pop", 32:#"elemental_pop_tuned_frequency", 31:#"phdflopper_slide_boost", 30:#"phdflopper_slider", 29:#"energy_mine_high_capacity", 28:#"energy_mine_spire", 27:#"deadwire_haste", 26:#"deadwire_lightning_strike", 25:#"deadshot_gunslinger", 24:#"deadshot_critical_efficiency", 23:#"napalmburst_contact_burn", 22:#"napalmburst_pyro", 21:#"m_mod_hidden_impact", 20:#"m_mod_faster_melee", 19:#"dark_flare_high_capacity", 18:#"dark_flare_extension", 17:#"shadowvortex_supermassive", 16:#"shadowvortex_big_game", 15:#"aether_shroud_high_capacity", 14:#"aether_shroud_group_shroud", 13:#"staminup_speed_boost", 12:#"staminup_stalker", 11:#"quick_revive_payback", 10:#"quick_revive_dying_wish", 9:#"juggernog_thicker_plates", 8:#"juggernog_reactive_armor", 7:#"speedcola_faster_equipment", 6:#"speedcola_classic_formula", 5:#"healingaura_stoic_presence", 4:#"healingaura_keep_perks", 3:#"cryofreeze_focus", 2:#"cryofreeze_ice_cloud", 1:#"brainrot_haste", 0:#"brainrot_bloat" ];
    var_ad79a314c169225f = [ 49:#"shatterblast_blast_zone", 48:#"shatterblast_blast_chain", 47:#"mary_paris_paris_favor", 46:#"mary_paris_arcane_fury", 45:#"lightray_extra_strength", 44:#"lightray_antibiotic", 43:#"deathperception_further_insight", 42:#"deathperception_critical_eye", 41:#"frost_blast_extension", 40:#"frost_blast_flash_freeze", 39:#"vulture_aid_picky_eater", 38:#"vulture_aid_fetidupgraid", 37:#"d_mod_double_play", 36:#"d_mod_double_standard", 35:#"frenzied_guard_extension", 34:#"frenzied_guard_retribution", 33:#"elemental_pop_advantage", 32:#"elemental_pop_tuned_frequency", 31:#"phdflopper_slide_boost", 30:#"phdflopper_slider", 29:#"energy_mine_siren", 28:#"energy_mine_spire", 27:#"deadwire_haste", 26:#"deadwire_lightning_strike", 25:#"deadshot_piercing_rounds", 24:#"deadshot_critical_efficiency", 23:#"napalmburst_incendiary", 22:#"napalmburst_pyro", 21:#"m_mod_backpedal", 20:#"m_mod_faster_melee", 19:#"dark_flare_slowdown", 18:#"dark_flare_extension", 17:#"shadowvortex_targeted", 16:#"shadowvortex_explosive_rain", 15:#"aether_shroud_extension", 14:#"aether_shroud_shadow_blade", 13:#"staminup_speed_boost", 12:#"staminup_endurance", 11:#"quick_revive_escape_plan", 10:#"quick_revive_dying_wish", 9:#"juggernog_thicker_plates", 8:#"juggernog_reactive_armor", 7:#"speedcola_faster_equipment", 6:#"speedcola_classic_formula", 5:#"healingaura_inner_strength", 4:#"healingaura_pillar_of_light", 3:#"cryofreeze_damage_boost", 2:#"cryofreeze_ice_cloud", 1:#"brainrot_explosive", 0:#"brainrot_bloat" ];
    var_ad79a014c1691bc6 = [ 49:#"shatterblast_blast_zone", 48:#"shatterblast_blast_chain", 47:#"mary_paris_paris_favor", 46:#"mary_paris_arcane_fury", 45:#"lightray_extra_strength", 44:#"lightray_antibiotic", 43:#"deathperception_further_insight", 42:#"deathperception_critical_eye", 41:#"frost_blast_extension", 40:#"frost_blast_flash_freeze", 39:#"vulture_aid_picky_eater", 38:#"vulture_aid_fetidupgraid", 37:#"d_mod_double_play", 36:#"d_mod_double_impact", 35:#"frenzied_guard_extension", 34:#"frenzied_guard_retribution", 33:#"elemental_pop_advantage", 32:#"elemental_pop_tuned_frequency", 31:#"phdflopper_slide_boost", 30:#"phdflopper_slider", 29:#"energy_mine_siren", 28:#"energy_mine_spire", 27:#"deadwire_haste", 26:#"deadwire_lightning_strike", 25:#"deadshot_piercing_rounds", 24:#"deadshot_first_strike", 23:#"napalmburst_incendiary", 22:#"napalmburst_pyro", 21:#"m_mod_backpedal", 20:#"m_mod_faster_melee", 19:#"dark_flare_slowdown", 18:#"dark_flare_extension", 17:#"shadowvortex_targeted", 16:#"shadowvortex_explosive_rain", 15:#"aether_shroud_extension", 14:#"aether_shroud_shadow_blade", 13:#"staminup_speed_boost", 12:#"staminup_endurance", 11:#"quick_revive_escape_plan", 10:#"quick_revive_dying_wish", 9:#"juggernog_thicker_plates", 8:#"juggernog_reactive_armor", 7:#"speedcola_faster_equipment", 6:#"speedcola_classic_formula", 5:#"healingaura_inner_strength", 4:#"healingaura_pillar_of_light", 3:#"cryofreeze_damage_boost", 2:#"cryofreeze_ice_cloud", 1:#"brainrot_explosive", 0:#"brainrot_bloat" ];
    chosen_set = undefined;
    
    if ( value == 1 )
    {
        chosen_set = set1;
    }
    else if ( value == 2 )
    {
        chosen_set = set2;
    }
    else if ( value == 3 )
    {
        chosen_set = var_ad79a314c169225f;
    }
    else
    {
        chosen_set = var_ad79a014c1691bc6;
    }
    
    foreach ( augment in chosen_set )
    {
        function_a049aaca693a5205( augment, var_5d4d563c38f4c7ed );
    }
}

// Namespace zombie_augments
// Params 2
// Checksum 0x239222d6, Offset: 0x37a9
// Size: 0x139f
function function_ae34f860566cce0b( value, var_5d4d563c38f4c7ed = 0 )
{
    set1 = [ 63:#"y_mod_wide_web", 62:#"y_mod_web_spinner", 61:#"wiley_fox_moltencore", 60:#"wiley_fox_freeradical", 59:#"toxic_growth_extra_charge", 58:#"toxic_growth_crescent", 57:#"fw_starlight", 56:#"fw_big_game", 55:#"z_mod_plate_hunter", 54:#"z_mod_pack_mule", 53:#"w_mod_extension", 52:#"w_mod_savior", 51:#"tesla_storm_lithium_charged", 50:#"tesla_storm_shockwave", 49:#"shatterblast_blast_zone", 48:#"shatterblast_blast_chain", 47:#"mary_paris_party_animal", 46:#"mary_paris_dance_party", 45:#"lightray_express_remedy", 44:#"lightray_big_game", 43:#"deathperception_extra_change", 42:#"deathperception_critical_eye", 41:#"frost_blast_high_capacity", 40:#"frost_blast_slick", 39:#"vulture_aid_picky_eater", 38:#"vulture_aid_parting_gift", 37:#"d_mod_double_or_nothing", 36:#"d_mod_double_standard", 35:#"frenzied_guard_extension", 34:#"frenzied_guard_frenzy_fire", 33:#"elemental_pop_more_pop", 32:#"elemental_pop_tuned_frequency", 31:#"phdflopper_slide_boost", 30:#"phdflopper_slider", 29:#"energy_mine_high_capacity", 28:#"energy_mine_spire", 27:#"deadwire_haste", 26:#"deadwire_lightning_strike", 25:#"deadshot_gunslinger", 24:#"deadshot_fmj", 23:#"napalmburst_contact_burn", 22:#"napalmburst_pyro", 21:#"m_mod_hidden_impact", 20:#"m_mod_faster_melee", 19:#"dark_flare_high_capacity", 18:#"dark_flare_extension", 17:#"shadowvortex_supermassive", 16:#"shadowvortex_big_game", 15:#"aether_shroud_high_capacity", 14:#"aether_shroud_afterimage", 13:#"staminup_speed_boost", 12:#"staminup_guns_up", 11:#"quick_revive_payback", 10:#"quick_revive_dying_wish", 9:#"juggernog_thicker_plates", 8:#"juggernog_turtle_shell", 7:#"speedcola_faster_equipment", 6:#"speedcola_classic_formula", 5:#"healingaura_stoic_presence", 4:#"healingaura_necromancer", 3:#"cryofreeze_focus", 2:#"cryofreeze_ice_cloud", 1:#"brainrot_haste", 0:#"brainrot_bloat" ];
    var_b2aa9be00482a0f7 = [ 31:#"y_mod_lethal_equipment", 30:#"wiley_fox_oxidizer", 29:#"fw_big_bang", 28:#"toxic_growth_ankle_shredder", 27:#"z_mod_fully_equipped", 26:#"w_mod_haste", 25:#"tesla_storm_overclocked", 24:#"shatterblast_blast_off", 23:#"mary_paris_social_butterfly", 22:#"lightray_extra_strength", 21:#"deathperception_further_insight", 20:#"frost_blast_extension", 19:#"vulture_aid_condors_reach", 18:#"d_mod_double_time", 17:#"frenzied_guard_repair_boost", 16:#"elemental_pop_advantage", 15:#"phdflopper_hair_trigger", 14:#"energy_mine_frequency_boost", 13:#"deadwire_aftershock", 12:#"deadshot_piercing_rounds", 11:#"napalmburst_backdraft", 10:#"m_mod_backpedal", 9:#"dark_flare_big_beam", 8:#"shadowvortex_haste", 7:#"aether_shroud_extension", 6:#"staminup_slippery_target", 5:#"quick_revive_escape_plan", 4:#"juggernog_well_constructed", 3:#"speedcola_faster_switch", 2:#"healingaura_bountiful_harvest", 1:#"hash_8725f48670c18643", 0:#"brainrot_explosive" ];
    set2 = [ 63:#"y_mod_extension", 62:#"y_mod_hatchling", 61:#"wiley_fox_heatsurge", 60:#"wiley_fox_firestorm", 59:#"toxic_growth_extra_charge", 58:#"toxic_growth_crescent", 57:#"fw_starlight", 56:#"fw_big_game", 55:#"z_mod_plate_hunter", 54:#"z_mod_pack_mule", 53:#"w_mod_extension", 52:#"w_mod_will_o_wisp", 51:#"tesla_storm_lithium_charged", 50:#"tesla_storm_shockwave", 49:#"shatterblast_blast_zone", 48:#"shatterblast_blast_chain", 47:#"mary_paris_party_animal", 46:#"mary_paris_dance_party", 45:#"lightray_mitosis", 44:#"lightray_booster_shot", 43:#"deathperception_extra_change", 42:#"deathperception_critical_eye", 41:#"frost_blast_high_capacity", 40:#"frost_blast_slick", 39:#"vulture_aid_picky_eater", 38:#"vulture_aid_parting_gift", 37:#"d_mod_double_play", 36:#"d_mod_double_standard", 35:#"frenzied_guard_extension", 34:#"frenzied_guard_frenzy_fire", 33:#"elemental_pop_more_pop", 32:#"elemental_pop_tuned_frequency", 31:#"phdflopper_slide_boost", 30:#"phdflopper_slider", 29:#"energy_mine_high_capacity", 28:#"energy_mine_spire", 27:#"deadwire_haste", 26:#"deadwire_lightning_strike", 25:#"deadshot_gunslinger", 24:#"deadshot_critical_efficiency", 23:#"napalmburst_contact_burn", 22:#"napalmburst_pyro", 21:#"m_mod_hidden_impact", 20:#"m_mod_faster_melee", 19:#"dark_flare_high_capacity", 18:#"dark_flare_extension", 17:#"shadowvortex_supermassive", 16:#"shadowvortex_big_game", 15:#"aether_shroud_high_capacity", 14:#"aether_shroud_group_shroud", 13:#"staminup_speed_boost", 12:#"staminup_stalker", 11:#"quick_revive_payback", 10:#"quick_revive_dying_wish", 9:#"juggernog_thicker_plates", 8:#"juggernog_reactive_armor", 7:#"speedcola_faster_equipment", 6:#"speedcola_classic_formula", 5:#"healingaura_stoic_presence", 4:#"healingaura_keep_perks", 3:#"cryofreeze_focus", 2:#"cryofreeze_ice_cloud", 1:#"brainrot_haste", 0:#"brainrot_bloat" ];
    var_b2aa9ce00482a32a = [ 31:#"y_mod_haste", 30:#"wiley_fox_backdraft", 29:#"fw_big_bang", 28:#"toxic_growth_ankle_shredder", 27:#"z_mod_fully_equipped", 26:#"w_mod_haste", 25:#"tesla_storm_overclocked", 24:#"shatterblast_blast_off", 23:#"mary_paris_social_butterfly", 22:#"lightray_extra_strength", 21:#"deathperception_further_insight", 20:#"frost_blast_extension", 19:#"vulture_aid_condors_reach", 18:#"d_mod_double_time", 17:#"frenzied_guard_repair_boost", 16:#"elemental_pop_advantage", 15:#"phdflopper_hair_trigger", 14:#"energy_mine_frequency_boost", 13:#"deadwire_aftershock", 12:#"deadshot_piercing_rounds", 11:#"napalmburst_backdraft", 10:#"m_mod_backpedal", 9:#"dark_flare_big_beam", 8:#"shadowvortex_haste", 7:#"aether_shroud_otherworldly_reload", 6:#"staminup_slippery_target", 5:#"quick_revive_escape_plan", 4:#"juggernog_well_constructed", 3:#"speedcola_faster_switch", 2:#"healingaura_bountiful_harvest", 1:#"hash_8725f48670c18643", 0:#"brainrot_explosive" ];
    var_ad79a314c169225f = [ 63:#"y_mod_wide_web", 62:#"y_mod_web_spinner", 61:#"wiley_fox_oxidizer", 60:#"wiley_fox_fireball", 59:#"toxic_growth_green_thumb", 58:#"toxic_growth_cordyception", 57:#"fw_starlight", 56:#"fw_farfalle", 55:#"z_mod_plate_hunter", 54:#"z_mod_multi_pack", 53:#"w_mod_extension", 52:#"w_mod_pretty_mask", 51:#"tesla_storm_sat_minor", 50:#"tesla_storm_sat_major", 49:#"shatterblast_blast_off", 48:#"shatterblast_blast_chain", 47:#"mary_paris_family_discount", 46:#"mary_paris_peek_health", 45:#"lightray_mitosis", 44:#"lightray_booster_shot", 43:#"deathperception_further_insight", 42:#"deathperception_sixth_sense", 41:#"frost_blast_extension", 40:#"frost_blast_stone_cold_stronghold", 39:#"vulture_aid_picky_eater", 38:#"vulture_aid_replate", 37:#"d_mod_double_time", 36:#"d_mod_double_standard", 35:#"frenzied_guard_extension", 34:#"frenzied_guard_frenzy_fire", 33:#"elemental_pop_advantage", 32:#"elemental_pop_rainbow_pop", 31:#"phdflopper_slide_boost", 30:#"phdflopper_slider", 29:#"energy_mine_frequency_boost", 28:#"energy_mine_smart_mine", 27:#"deadwire_aftershock", 26:#"deadwire_chain_lightning", 25:#"deadshot_gunslinger", 24:#"deadshot_fmj", 23:#"napalmburst_backdraft", 22:#"napalmburst_pyro", 21:#"m_mod_closing_argument", 20:#"m_mod_panic_knife", 19:#"dark_flare_shadow_burn", 18:#"dark_flare_phantasmal", 17:#"shadowvortex_supermassive", 16:#"shadowvortex_blackhole", 15:#"aether_shroud_high_capacity", 14:#"aether_shroud_group_shroud", 13:#"staminup_guns_up", 12:#"staminup_footwork", 11:#"quick_revive_escape_plan", 10:#"quick_revive_last_chance", 9:#"juggernog_thicker_plates", 8:#"juggernog_turtle_shell", 7:#"speedcola_stock_reload", 6:#"speedcola_sprint_reload", 5:#"healingaura_inner_strength", 4:#"healingaura_necromancer", 3:#"cryofreeze_post_freeze_damage", 2:#"cryofreeze_aoe_proc", 1:#"brainrot_extension", 0:#"brainrot_irradiated" ];
    var_b2aa9de00482a55d = [ 31:#"y_mod_lethal_equipment", 30:#"hash_2cd7ebd681eb141f", 29:#"fw_haste", 28:#"toxic_growth_ankle_shredder", 27:#"z_mod_fully_equipped", 26:#"w_mod_fetcher", 25:#"tesla_storm_lithium_charged", 24:#"shatterblast_blast_repair", 23:#"mary_paris_social_butterfly", 22:#"lightray_extra_strength", 21:#"deathperception_extra_change", 20:#"frost_blast_flash_freeze", 19:#"vulture_aid_condors_reach", 18:#"d_mod_double_dealer", 17:#"frenzied_guard_high_defense", 16:#"elemental_pop_more_pop", 15:#"phdflopper_wall_flopper", 14:#"energy_mine_high_capacity", 13:#"deadwire_damage_boost", 12:#"deadshot_piercing_rounds", 11:#"napalmburst_incendiary", 10:#"m_mod_hidden_impact", 9:#"dark_flare_big_beam", 8:#"shadowvortex_reload", 7:#"aether_shroud_extension", 6:#"staminup_speed_boost", 5:#"quick_revive_die_hard", 4:#"juggernog_well_constructed", 3:#"speedcola_faster_equipment", 2:#"healingaura_bountiful_harvest", 1:#"hash_191c77fd78486be6", 0:#"brainrot_more_damage" ];
    var_ad79a014c1691bc6 = [ 63:#"y_mod_wide_web", 62:#"y_mod_widows_bite", 61:#"wiley_fox_moltencore", 60:#"wiley_fox_flashover", 59:#"toxic_growth_plant_food", 58:#"toxic_growth_pollination", 57:#"fw_starlight", 56:#"fw_big_game", 55:#"z_mod_plate_hunter", 54:#"z_mod_multi_pack", 53:#"w_mod_extension", 52:#"w_mod_demon_mask", 51:#"tesla_storm_sat_minor", 50:#"tesla_storm_sat_major", 49:#"shatterblast_blast_zone", 48:#"shatterblast_blast_chain", 47:#"mary_paris_paris_favor", 46:#"mary_paris_arcane_fury", 45:#"lightray_extra_strength", 44:#"lightray_antibiotic", 43:#"deathperception_further_insight", 42:#"deathperception_critical_eye", 41:#"frost_blast_extension", 40:#"frost_blast_flash_freeze", 39:#"vulture_aid_picky_eater", 38:#"vulture_aid_fetidupgraid", 37:#"d_mod_double_play", 36:#"d_mod_double_impact", 35:#"frenzied_guard_extension", 34:#"frenzied_guard_retribution", 33:#"elemental_pop_advantage", 32:#"elemental_pop_tuned_frequency", 31:#"phdflopper_slide_boost", 30:#"phdflopper_slider", 29:#"energy_mine_siren", 28:#"energy_mine_spire", 27:#"deadwire_haste", 26:#"deadwire_lightning_strike", 25:#"deadshot_piercing_rounds", 24:#"deadshot_first_strike", 23:#"napalmburst_incendiary", 22:#"napalmburst_pyro", 21:#"m_mod_backpedal", 20:#"m_mod_faster_melee", 19:#"dark_flare_slowdown", 18:#"dark_flare_extension", 17:#"shadowvortex_targeted", 16:#"shadowvortex_explosive_rain", 15:#"aether_shroud_extension", 14:#"aether_shroud_shadow_blade", 13:#"staminup_speed_boost", 12:#"staminup_stalker", 11:#"quick_revive_escape_plan", 10:#"quick_revive_dying_wish", 9:#"juggernog_thicker_plates", 8:#"juggernog_reactive_armor", 7:#"speedcola_faster_equipment", 6:#"speedcola_classic_formula", 5:#"healingaura_inner_strength", 4:#"healingaura_pillar_of_light", 3:#"cryofreeze_damage_boost", 2:#"cryofreeze_ice_cloud", 1:#"brainrot_explosive", 0:#"brainrot_bloat" ];
    var_b2aa96e0048295f8 = [ 31:#"y_mod_lethal_equipment", 30:#"wiley_fox_backdraft", 29:#"fw_big_bang", 28:#"toxic_growth_ankle_shredder", 27:#"z_mod_fully_equipped", 26:#"w_mod_haste", 25:#"tesla_storm_overclocked", 24:#"shatterblast_blast_off", 23:#"mary_paris_social_butterfly", 22:#"lightray_mitosis", 21:#"deathperception_hidden_gems", 20:#"frost_blast_slow_extend", 19:#"vulture_aid_carrion_luggage", 18:#"d_mod_double_time", 17:#"frenzied_guard_repair_boost", 16:#"elemental_pop_elemental_equipment", 15:#"phdflopper_hair_trigger", 14:#"energy_mine_frequency_boost", 13:#"deadwire_aftershock", 12:#"deadshot_dead_heat", 11:#"napalmburst_backdraft", 10:#"m_mod_hidden_impact", 9:#"dark_flare_big_beam", 8:#"shadowvortex_haste", 7:#"aether_shroud_otherworldly_reload", 6:#"staminup_slippery_target", 5:#"quick_revive_payback", 4:#"juggernog_well_constructed", 3:#"speedcola_faster_switch", 2:#"healingaura_bountiful_harvest", 1:#"hash_8725f48670c18643", 0:#"brainrot_extension" ];
    chosen_set = undefined;
    var_290ae38abdedeb93 = undefined;
    
    if ( value == 1 )
    {
        chosen_set = set1;
        var_290ae38abdedeb93 = var_b2aa9be00482a0f7;
    }
    else if ( value == 2 )
    {
        chosen_set = set2;
        var_290ae38abdedeb93 = var_b2aa9ce00482a32a;
    }
    else if ( value == 3 )
    {
        chosen_set = var_ad79a314c169225f;
        var_290ae38abdedeb93 = var_b2aa9de00482a55d;
    }
    else
    {
        chosen_set = var_ad79a014c1691bc6;
        var_290ae38abdedeb93 = var_b2aa96e0048295f8;
    }
    
    foreach ( augment in chosen_set )
    {
        function_a049aaca693a5205( augment, var_5d4d563c38f4c7ed );
    }
    
    foreach ( augment in var_290ae38abdedeb93 )
    {
        function_c9cb0ae85eefe639( augment );
    }
}

// Namespace zombie_augments
// Params 1
// Checksum 0x9e0499aa, Offset: 0x4b50
// Size: 0xd6
function zombie_augments_on_player_connect( params )
{
    self.zombie_augments = [];
    self.var_2de028ea974579b5 = [];
    self.var_8fbd699dbed14e85 = [];
    self.var_bd752fd42b2e2193 = [];
    self.var_34530cea34733ad0 = [];
    function_eae5368ab01aaa9f();
    
    if ( !level.zombie_augments_in_use )
    {
        return;
    }
    
    callback::add( "on_player_augment_given", &function_f43d4a41cd272c07 );
    
    if ( getdvarint( @"hash_6d37b32fe50f0afd", 0 ) > 0 )
    {
        var_7df09472d1ea4928 = getdvarint( @"hash_6d37b32fe50f0afd", 0 );
        function_f5145dc8a684fc24( var_7df09472d1ea4928 );
        return;
    }
    
    function_6dec499dd490fc54();
    
    if ( utility::issharedfuncdefined( #"exotic_weapons", #"hash_30545f2ddec3de8e" ) )
    {
        utility::callsharedfunc( #"exotic_weapons", #"hash_30545f2ddec3de8e" );
    }
}

// Namespace zombie_augments
// Params 0
// Checksum 0xc163d8f7, Offset: 0x4c2e
// Size: 0x1d7
function function_eae5368ab01aaa9f()
{
    foreach ( augmentbundle in level.zombie_augments )
    {
        if ( isdefined( augmentbundle.augmenttype ) )
        {
            var_358c2e9b08399e08 = spawnstruct();
            var_358c2e9b08399e08.majorname = "none";
            var_358c2e9b08399e08.minorname = "none";
            var_358c2e9b08399e08.var_cafcc8be001cb0de = [];
            var_358c2e9b08399e08.var_41a892151199064a = [];
            params = undefined;
            augment = self.zombie_augments[ augmentbundle.augmenttype ];
            
            if ( augment )
            {
                augmenttype = augmentbundle.augmenttype;
                ismajor = augmentbundle.ismajor;
                
                if ( ismajor )
                {
                    augmentname = augment.majorname;
                }
                else
                {
                    augmentname = augment.minorname;
                }
                
                if ( augmentname != "none" || augment.var_cafcc8be001cb0de.size > 0 || augment.var_41a892151199064a.size > 0 )
                {
                    params = { #augment:augment, #ismajor:ismajor, #augmenttype:augmenttype, #augmentname:augmentname };
                }
            }
            
            self.zombie_augments[ augmentbundle.augmenttype ] = var_358c2e9b08399e08;
            
            if ( params )
            {
                callback::callback( "on_player_augment_taken", params );
            }
        }
    }
}

// Namespace zombie_augments
// Params 0
// Checksum 0x3cf5ffcd, Offset: 0x4e0d
// Size: 0x247
function function_aac93cc049fd5090()
{
    if ( !level.zombie_augments_in_use )
    {
        return;
    }
    
    foreach ( type, augment_struct in self.zombie_augments )
    {
        if ( isdefined( type ) && !augment_struct.var_5b4699915fe0cf21 )
        {
            var_550cf7164605ad94 = [ augment_struct.majorname, augment_struct.minorname ];
            var_550cf7164605ad94 = arraycombine( var_550cf7164605ad94, augment_struct.var_cafcc8be001cb0de );
            var_550cf7164605ad94 = arraycombine( var_550cf7164605ad94, augment_struct.var_41a892151199064a );
            var_358c2e9b08399e08 = spawnstruct();
            var_358c2e9b08399e08.majorname = "none";
            var_358c2e9b08399e08.minorname = "none";
            var_358c2e9b08399e08.var_cafcc8be001cb0de = [];
            var_358c2e9b08399e08.var_41a892151199064a = [];
            var_358c2e9b08399e08.var_5b4699915fe0cf21 = 1;
            self.zombie_augments[ type ] = var_358c2e9b08399e08;
            
            foreach ( equipped_augment in var_550cf7164605ad94 )
            {
                if ( equipped_augment != "none" )
                {
                    augmentbundle = level.zombie_augments[ equipped_augment ];
                    
                    if ( augmentbundle )
                    {
                        augmenttype = augmentbundle.augmenttype;
                        ismajor = augmentbundle.ismajor;
                        params = { #augment:augment_struct, #ismajor:ismajor, #augmenttype:augmenttype, #augmentname:equipped_augment };
                        callback::callback( "on_player_augment_taken", params );
                    }
                }
            }
        }
    }
}

// Namespace zombie_augments
// Params 0
// Checksum 0x57bbf282, Offset: 0x505c
// Size: 0x593
function function_6dec499dd490fc54()
{
    utility::ent_flag_set( "loadout_augments_setup_in_progress" );
    
    foreach ( perkref in level.var_27b2d2f16f8663ac )
    {
        if ( perkref.var_4f7f7255a5a5e05d == "" )
        {
            continue;
        }
        
        perk_augments = function_47bee6c8496154b3( perkref.var_4f7f7255a5a5e05d );
        
        if ( isdefined( perk_augments ) && isdefined( perk_augments.major ) )
        {
            majorname = getscriptbundlefieldvalue( perk_augments.major, #"augmentname" );
            
            if ( isdefined( majorname ) )
            {
                function_a049aaca693a5205( majorname, 0, #"perk" );
                logstring( "[ ZM Augments ] - GAVE PERK AUGMENT " + majorname + " to " + self.name );
            }
        }
        
        if ( isdefined( perk_augments ) && isdefined( perk_augments.minor ) )
        {
            minorname = getscriptbundlefieldvalue( perk_augments.minor, #"augmentname" );
            
            if ( isdefined( minorname ) )
            {
                function_a049aaca693a5205( minorname, 0, #"perk" );
                logstring( "[ ZM Augments ] - GAVE PERK AUGMENT " + minorname + " to " + self.name );
            }
        }
        
        if ( isdefined( perk_augments ) && isdefined( perk_augments.var_4b9e66d4864394df ) )
        {
            var_2684f2700794f4a5 = getscriptbundlefieldvalue( perk_augments.var_4b9e66d4864394df, #"augmentname" );
            
            if ( isdefined( var_2684f2700794f4a5 ) )
            {
                function_c9cb0ae85eefe639( var_2684f2700794f4a5, #"perk" );
                logstring( "[ ZM Augments ] - GAVE BONUS PERK AUGMENT " + var_2684f2700794f4a5 + " to " + self.name );
            }
        }
    }
    
    foreach ( superref in level.var_6dcdf8523d43f28f )
    {
        if ( superref.var_efe1aa95a67f4352 == "" )
        {
            continue;
        }
        
        super_augments = function_43a77f7693248e26( superref.var_efe1aa95a67f4352 );
        
        if ( isdefined( super_augments ) && isdefined( super_augments.major ) )
        {
            majorname = getscriptbundlefieldvalue( super_augments.major, #"augmentname" );
            
            if ( isdefined( majorname ) )
            {
                function_a049aaca693a5205( majorname, 0, #"field_upgrade" );
                logstring( "[ ZM Augments ] - GAVE SUPER AUGMENT " + majorname + " to " + self.name );
            }
        }
        
        if ( isdefined( super_augments ) && isdefined( super_augments.minor ) )
        {
            minorname = getscriptbundlefieldvalue( super_augments.minor, #"augmentname" );
            
            if ( isdefined( minorname ) )
            {
                function_a049aaca693a5205( minorname, 0, #"field_upgrade" );
                logstring( "[ ZM Augments ] - GAVE SUPER AUGMENT " + minorname + " to " + self.name );
            }
        }
        
        if ( isdefined( super_augments ) && isdefined( super_augments.var_4b9e66d4864394df ) )
        {
            var_2684f2700794f4a5 = getscriptbundlefieldvalue( super_augments.var_4b9e66d4864394df, #"augmentname" );
            
            if ( isdefined( var_2684f2700794f4a5 ) )
            {
                function_c9cb0ae85eefe639( var_2684f2700794f4a5, #"field_upgrade" );
                logstring( "[ ZM Augments ] - GAVE BONUS SUPER AUGMENT " + var_2684f2700794f4a5 + " to " + self.name );
            }
        }
    }
    
    foreach ( ammomodref in level.var_9a95556713e1d70c )
    {
        ammomod_augments = function_63dfe50717ac9ecf( ammomodref.var_1ec51d3bbd5eade1 );
        
        if ( isdefined( ammomod_augments ) && isdefined( ammomod_augments.major ) )
        {
            majorname = getscriptbundlefieldvalue( ammomod_augments.major, #"augmentname" );
            
            if ( isdefined( majorname ) )
            {
                function_a049aaca693a5205( majorname, 0, #"ammo_mod" );
                logstring( "[ ZM Augments ] - GAVE AMMOMOD AUGMENT " + majorname + " to " + self.name );
            }
        }
        
        if ( isdefined( ammomod_augments ) && isdefined( ammomod_augments.minor ) )
        {
            minorname = getscriptbundlefieldvalue( ammomod_augments.minor, #"augmentname" );
            
            if ( isdefined( minorname ) )
            {
                function_a049aaca693a5205( minorname, 0, #"ammo_mod" );
                logstring( "[ ZM Augments ] - GAVE AMMOMOD AUGMENT " + minorname + " to " + self.name );
            }
        }
        
        if ( isdefined( ammomod_augments ) && isdefined( ammomod_augments.var_4b9e66d4864394df ) )
        {
            var_2684f2700794f4a5 = getscriptbundlefieldvalue( ammomod_augments.var_4b9e66d4864394df, #"augmentname" );
            
            if ( isdefined( var_2684f2700794f4a5 ) )
            {
                function_c9cb0ae85eefe639( var_2684f2700794f4a5, #"ammo_mod" );
                logstring( "[ ZM Augments ] - GAVE BONUS AMMOMOD AUGMENT " + var_2684f2700794f4a5 + " to " + self.name );
            }
        }
    }
    
    utility::ent_flag_clear( "loadout_augments_setup_in_progress" );
    self notify( #"player_loadout_augments_given" );
}

// Namespace zombie_augments
// Params 1
// Checksum 0xb53bc1cf, Offset: 0x55f7
// Size: 0xbb
function function_47bee6c8496154b3( perkref )
{
    equipped_augment = undefined;
    var_42b707d141246e9b = self getplayerdata( level.loadoutdata, "perkCustomization", perkref, "majorAugment" );
    var_a34054183b824e5f = self getplayerdata( level.loadoutdata, "perkCustomization", perkref, "minorAugment" );
    
    if ( level.gamemodebundle.var_e1e0a503aafbb38f )
    {
        var_e50fd2cf30a540f3 = self getplayerdata( level.loadoutdata, "perkCustomization", perkref, "bonusMinorAugment" );
    }
    
    if ( var_42b707d141246e9b == 0 && var_a34054183b824e5f == 0 )
    {
        return equipped_augment;
    }
    
    equipped_augment = function_f4e1153c69f03c62( var_42b707d141246e9b, var_a34054183b824e5f, var_e50fd2cf30a540f3 );
    return equipped_augment;
}

// Namespace zombie_augments
// Params 1
// Checksum 0xb2f8d8d1, Offset: 0x56bb
// Size: 0xbb
function function_63dfe50717ac9ecf( ammomodname )
{
    equipped_augment = undefined;
    var_42b707d141246e9b = self getplayerdata( level.loadoutdata, "ammoModCustomization", ammomodname, "majorAugment" );
    var_a34054183b824e5f = self getplayerdata( level.loadoutdata, "ammoModCustomization", ammomodname, "minorAugment" );
    
    if ( level.gamemodebundle.var_e1e0a503aafbb38f )
    {
        var_e50fd2cf30a540f3 = self getplayerdata( level.loadoutdata, "ammoModCustomization", ammomodname, "bonusMinorAugment" );
    }
    
    if ( var_42b707d141246e9b == 0 && var_a34054183b824e5f == 0 )
    {
        return equipped_augment;
    }
    
    equipped_augment = function_f4e1153c69f03c62( var_42b707d141246e9b, var_a34054183b824e5f, var_e50fd2cf30a540f3 );
    return equipped_augment;
}

// Namespace zombie_augments
// Params 1
// Checksum 0xdb0a5347, Offset: 0x577f
// Size: 0xbb
function function_43a77f7693248e26( superref )
{
    equipped_augment = undefined;
    var_42b707d141246e9b = self getplayerdata( level.loadoutdata, "superCustomization", superref, "majorAugment" );
    var_a34054183b824e5f = self getplayerdata( level.loadoutdata, "superCustomization", superref, "minorAugment" );
    
    if ( level.gamemodebundle.var_e1e0a503aafbb38f )
    {
        var_e50fd2cf30a540f3 = self getplayerdata( level.loadoutdata, "superCustomization", superref, "bonusMinorAugment" );
    }
    
    if ( var_42b707d141246e9b == 0 && var_a34054183b824e5f == 0 )
    {
        return equipped_augment;
    }
    
    equipped_augment = function_f4e1153c69f03c62( var_42b707d141246e9b, var_a34054183b824e5f, var_e50fd2cf30a540f3 );
    return equipped_augment;
}

// Namespace zombie_augments
// Params 3
// Checksum 0x47a82460, Offset: 0x5843
// Size: 0xe3
function function_f4e1153c69f03c62( var_42b707d141246e9b, var_a34054183b824e5f, var_e50fd2cf30a540f3 = 0 )
{
    equipped_augment = spawnstruct();
    
    if ( var_42b707d141246e9b > 0 )
    {
        major_ref = loot::function_f54ecb89dfab8e8c( var_42b707d141246e9b );
        
        if ( major_ref )
        {
            equipped_augment.major = hashcat( %"hash_79cdb462dfebab86", major_ref );
        }
    }
    
    if ( var_a34054183b824e5f > 0 )
    {
        minor_ref = loot::function_f54ecb89dfab8e8c( var_a34054183b824e5f );
        
        if ( minor_ref )
        {
            equipped_augment.minor = hashcat( %"hash_79cdb462dfebab86", minor_ref );
        }
    }
    
    if ( var_e50fd2cf30a540f3 > 0 )
    {
        bonus_minor_ref = loot::function_f54ecb89dfab8e8c( var_e50fd2cf30a540f3 );
        
        if ( bonus_minor_ref )
        {
            equipped_augment.var_4b9e66d4864394df = hashcat( %"hash_79cdb462dfebab86", bonus_minor_ref );
        }
    }
    
    return equipped_augment;
}

// Namespace zombie_augments
// Params 2
// Checksum 0xdd1fe4ae, Offset: 0x592f
// Size: 0x39
function function_7e9d3219104a3c94( augmentname, var_e0dce76f78f805e4 )
{
    if ( !isdefined( level.var_f636f2beb27e1cff ) )
    {
        level.var_f636f2beb27e1cff = [];
    }
    
    level.var_f636f2beb27e1cff[ augmentname ] = var_e0dce76f78f805e4;
}

// Namespace zombie_augments
// Params 1
// Checksum 0xceffb47d, Offset: 0x5970
// Size: 0x29
function function_748bf65ee56d053b( augmentname )
{
    if ( isdefined( level.var_f636f2beb27e1cff[ augmentname ] ) )
    {
        return level.var_f636f2beb27e1cff[ augmentname ];
    }
}

// Namespace zombie_augments
// Params 1, eflags: 0x4
// Checksum 0x8d03323, Offset: 0x59a2
// Size: 0xa9
function private function_7e16885c27956ff9( params )
{
    iprintlnbold( "Resetting all augments to chosen loadouts for " + level.players.size + " players" );
    
    foreach ( player in level.players )
    {
        player function_eae5368ab01aaa9f();
        player function_6dec499dd490fc54();
    }
}

// Namespace zombie_augments
// Params 1, eflags: 0x4
// Checksum 0xb9435a3c, Offset: 0x5a53
// Size: 0x13e
function private function_83730e6a6e980360( params )
{
    var_ca845f48dfb97f1d = params[ 0 ] ?? 4;
    iprintlnbold( "Filling unused augment slots with slot " + var_ca845f48dfb97f1d + " from all " + level.players.size + " players" );
    
    foreach ( player in level.players )
    {
        player function_eae5368ab01aaa9f();
        player function_6dec499dd490fc54();
        
        switch ( var_ca845f48dfb97f1d )
        {
            case #"hash_31100fbc01bd387c":
                player function_f5145dc8a684fc24( 1, 1 );
                break;
            case #"hash_311012bc01bd3d35":
                player function_f5145dc8a684fc24( 2, 1 );
                break;
            case #"hash_311011bc01bd3ba2":
                player function_f5145dc8a684fc24( 3, 1 );
                break;
            default:
                player function_f5145dc8a684fc24( 4, 1 );
                break;
        }
    }
}

// Namespace zombie_augments
// Params 1, eflags: 0x4
// Checksum 0xb93daacd, Offset: 0x5b99
// Size: 0x13e
function private function_ca476fa0ae102ab7( params )
{
    var_ca845f48dfb97f1d = params[ 0 ] ?? 4;
    iprintlnbold( "Filling unused augment slots with slot " + var_ca845f48dfb97f1d + " from all " + level.players.size + " players" );
    
    foreach ( player in level.players )
    {
        player function_eae5368ab01aaa9f();
        player function_6dec499dd490fc54();
        
        switch ( var_ca845f48dfb97f1d )
        {
            case #"hash_31100fbc01bd387c":
                player function_ae34f860566cce0b( 1, 1 );
                break;
            case #"hash_311012bc01bd3d35":
                player function_ae34f860566cce0b( 2, 1 );
                break;
            case #"hash_311011bc01bd3ba2":
                player function_ae34f860566cce0b( 3, 1 );
                break;
            default:
                player function_ae34f860566cce0b( 4, 1 );
                break;
        }
    }
}

// Namespace zombie_augments
// Params 1, eflags: 0x4
// Checksum 0x69ddadb, Offset: 0x5cdf
// Size: 0xa0
function private remove_all_augments( params )
{
    iprintlnbold( "Removing all augments from all " + level.players.size + " players" );
    
    foreach ( player in level.players )
    {
        player function_eae5368ab01aaa9f();
    }
}

/#

    // Namespace zombie_augments
    // Params 0
    // Checksum 0xb660bb23, Offset: 0x5d87
    // Size: 0x375, Type: dev
    function setup_augments_devgui()
    {
        augmentfeatures = [];
        augmentfeatures = [ "<dev string:x374>":"<dev string:x36a>", "<dev string:x364>":"<dev string:x35e>", "<dev string:x351>":"<dev string:x344>", "<dev string:x33e>":"<dev string:x338>", "<dev string:x32d>":"<dev string:x320>", "<dev string:x31a>":"<dev string:x314>", "<dev string:x309>":"<dev string:x2fc>", "<dev string:x2ef>":"<dev string:x2e1>", "<dev string:x2d8>":"<dev string:x2cd>", "<dev string:x2c2>":"<dev string:x2b6>", "<dev string:x2a6>":"<dev string:x295>", "<dev string:x28a>":"<dev string:x27e>", "<dev string:x270>":"<dev string:x261>", "<dev string:x254>":"<dev string:x246>", "<dev string:x23b>":"<dev string:x22f>", "<dev string:x224>":"<dev string:x218>", "<dev string:x20f>":"<dev string:x206>", "<dev string:x200>":"<dev string:x1f5>", "<dev string:x1ec>":"<dev string:x1db>", "<dev string:x1cf>":"<dev string:x1c2>", "<dev string:x1bc>":"<dev string:x1ac>", "<dev string:x1a1>":"<dev string:x195>", "<dev string:x18b>":"<dev string:x180>", "<dev string:x173>":"<dev string:x167>", "<dev string:x15a>":"<dev string:x14c>", "<dev string:x143>":"<dev string:x13a>", "<dev string:x12e>":"<dev string:x121>", "<dev string:x116>":"<dev string:x10c>", "<dev string:x102>":"<dev string:xf7>", "<dev string:xeb>":"<dev string:xde>", "<dev string:xd3>":"<dev string:xc8>", "<dev string:xbf>":"<dev string:xb6>" ];
        devgui::function_9082edeb5db93280( "<dev string:x37e>" );
        devgui::add_devgui_func( "<dev string:x395>", "<dev string:x3a9>", &function_774dac7dbbf3ac93 );
        devgui::add_devgui_func( "<dev string:x3bd>", "<dev string:x3d5>", &function_8a7ad59b4c5925d0 );
        
        foreach ( var_9610f88e6fd3382d, featurevalue in augmentfeatures )
        {
            foreach ( augmentname, augmentbundle in level.zombie_augments )
            {
                if ( augmentname == "<dev string:x3ed>" )
                {
                    continue;
                }
                
                var_925da70dcd759cdb = getxhashsourcename( augmentname );
                var_15961f20b1f001e9 = getxhashsourcename( augmentbundle.augmenttype );
                
                if ( augmentbundle.ismajor )
                {
                    if ( var_9610f88e6fd3382d == var_15961f20b1f001e9 )
                    {
                        devgui::function_cd4e263c1f3018ae( featurevalue + "<dev string:x3f2>" + var_925da70dcd759cdb, "<dev string:x3ff>" + var_925da70dcd759cdb, &function_790c0c561b6b9d27, 0 );
                        devgui::function_cd4e263c1f3018ae( featurevalue + "<dev string:x40d>" + var_925da70dcd759cdb, "<dev string:x420>" + var_925da70dcd759cdb, &function_150c7f83499c93ff, 0 );
                    }
                    
                    continue;
                }
                
                if ( var_9610f88e6fd3382d == var_15961f20b1f001e9 )
                {
                    devgui::function_cd4e263c1f3018ae( featurevalue + "<dev string:x434>" + var_925da70dcd759cdb, "<dev string:x3ff>" + var_925da70dcd759cdb, &function_790c0c561b6b9d27, 0 );
                    devgui::function_cd4e263c1f3018ae( featurevalue + "<dev string:x441>" + var_925da70dcd759cdb, "<dev string:x420>" + var_925da70dcd759cdb, &function_150c7f83499c93ff, 0 );
                }
            }
        }
        
        devgui::add_devgui_func( "<dev string:x454>", "<dev string:x468>", &function_66dd932b8b356c4a );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_augments
    // Params 0
    // Checksum 0x67829604, Offset: 0x6104
    // Size: 0x155, Type: dev
    function function_774dac7dbbf3ac93()
    {
        foreach ( player in level.players )
        {
            foreach ( augmentname, augment in player.zombie_augments )
            {
                player.zombie_augments[ augmentname ].majorname = "<dev string:x3ed>";
                player.zombie_augments[ augmentname ].minorname = "<dev string:x3ed>";
                player.zombie_augments[ augmentname ].var_cafcc8be001cb0de = [];
                player.zombie_augments[ augmentname ].var_41a892151199064a = [];
            }
        }
    }

    // Namespace zombie_augments
    // Params 1
    // Checksum 0xc5179cf6, Offset: 0x6261
    // Size: 0x105, Type: dev
    function function_8a7ad59b4c5925d0( params )
    {
        foreach ( player in level.players )
        {
            foreach ( augmentname, augmentbundle in level.zombie_augments )
            {
                if ( augmentname == "<dev string:x3ed>" )
                {
                    continue;
                }
                
                player function_c9cb0ae85eefe639( augmentname );
            }
        }
    }

    // Namespace zombie_augments
    // Params 1
    // Checksum 0x187f7c48, Offset: 0x636e
    // Size: 0xac, Type: dev
    function function_150c7f83499c93ff( params )
    {
        augmentname = params[ 0 ];
        augmentname = getxhash( augmentname );
        
        foreach ( player in level.players )
        {
            iprintlnbold( "<dev string:x474>" + params[ 0 ] );
            player function_c9cb0ae85eefe639( augmentname );
        }
    }

    // Namespace zombie_augments
    // Params 1
    // Checksum 0xb2c2c101, Offset: 0x6422
    // Size: 0xac, Type: dev
    function function_790c0c561b6b9d27( params )
    {
        augmentname = params[ 0 ];
        augmentname = getxhash( augmentname );
        
        foreach ( player in level.players )
        {
            iprintlnbold( "<dev string:x474>" + params[ 0 ] );
            player function_a049aaca693a5205( augmentname );
        }
    }

    // Namespace zombie_augments
    // Params 0
    // Checksum 0xd0a3af2, Offset: 0x64d6
    // Size: 0xba, Type: dev
    function function_66dd932b8b356c4a()
    {
        foreach ( player in level.players )
        {
            speedcola_augments = player function_47bee6c8496154b3( "<dev string:x482>" );
            cryofreeze_augments = player function_63dfe50717ac9ecf( "<dev string:xd3>" );
            healingaura_augments = player function_43a77f7693248e26( "<dev string:x496>" );
        }
    }

#/
