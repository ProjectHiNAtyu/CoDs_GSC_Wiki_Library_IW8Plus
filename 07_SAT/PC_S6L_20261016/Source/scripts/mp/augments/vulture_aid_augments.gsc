// scripts\mp\augments\vulture_aid_augments.gsc  (hash_6b6b4a828ed4e924.gscc) (size: 11871 Bytes / 0x2e5f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x15920bb5 (361892789)
// size ...... 11871 (0x2e5f)
// includes .. 10  (offset: 0x2c1f)
// strings ... 35  (offset: 0x2c6f)
// dev strs .. 1   (offset: 0x2e53)
// exports ... 25  (offset: 0x1d8b)
// cseg ...... 0x36e + 0x1a1d (0x1d8b)
// imports ... 89  (offset: 0x2173)
// animtree1 . 0   (offset: 0x2e5f)
// animtree2 . 0   (offset: 0x2e5f)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\armor;
#using scripts\mp\challenges;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_equipment;
#using scripts\mp\supers;

#namespace vulture_aid_augments;

// Namespace vulture_aid_augments
// Params 0, eflags: 0x5
// Checksum 0xd9c39c61, Offset: 0x38c
// Size: 0x15
function private autoexec __init__system__()
{
    system::register( "vulture_aid_augments", undefined, undefined, &vulture_aid_augments_init );
}

// Namespace vulture_aid_augments
// Params 0
// Checksum 0x751482ce, Offset: 0x3a9
// Size: 0xa
function __init__()
{
    level thread vulture_aid_augments_init();
}

// Namespace vulture_aid_augments
// Params 0
// Checksum 0xe96e2f06, Offset: 0x3bb
// Size: 0xdd
function vulture_aid_augments_init()
{
    if ( !level.zombie_augments_in_use )
    {
        return;
    }
    
    utility::registersharedfunc( #"zombie", #"hash_714e4483f900e0b8", &function_14c2b4abdb31002d );
    level._effect[ #"vulture_aid_camouflage" ] = loadfxasset( "vfx_t10_gameplay_zm_augment_gas_cloud_concealing" );
    level._effect[ #"vulture_aid_fetidupgraid" ] = loadfxasset( "vfx_t10_gameplay_zm_augment_gas_cloud_charging" );
    callback::add( "zm_perk_obtained", &function_d6c7e7ef3462add );
    callback::add( "on_combat_axe_used", &function_2d34a4f61c871fbf );
    callback::add( #"hash_aa7c0dbef3e86ee4", &function_1c9ac719b480fb17 );
    callback::add( "armor_pip_broken", &function_1c9ac719b480fb17 );
    callback::add( #"give_armor_plates", &function_1c9ac719b480fb17 );
    callback::add( "give_vulture_aid", &on_give_vulture_aid );
    function_1103831922daa969();
}

// Namespace vulture_aid_augments
// Params 0, eflags: 0x4
// Checksum 0xdbe32c5f, Offset: 0x4a0
// Size: 0x2cb
function private function_1103831922daa969()
{
    wait 1;
    var_984e04305f74d00f = level.zombie_augments[ #"vulture_aid_picky_eater" ].var_f4eee770994a896b;
    var_eee02d81801aab54 = getscriptbundle( "itemspawnlist:" + var_984e04305f74d00f );
    level.var_b0ab8ba64b1718e = [];
    
    foreach ( bundle in var_eee02d81801aab54.itementries )
    {
        spawnentry = bundle.itemspawnentry;
        
        if ( isdefined( spawnentry ) )
        {
            level.var_b0ab8ba64b1718e[ spawnentry ] = bundle;
        }
    }
    
    var_66313d6f92caabed = level.zombie_augments[ #"vulture_aid_condors_reach" ].var_f4eee770994a896b;
    var_e24d1daa83bc2bce = getscriptbundle( "itemspawnlist:" + var_66313d6f92caabed );
    level.var_b72a8f947c6040b1 = [];
    
    foreach ( bundle in var_e24d1daa83bc2bce.itementries )
    {
        spawnentry = getscriptbundle( bundle.itemspawnentry );
        
        if ( isdefined( spawnentry.perplayerscriptable ) )
        {
            level.var_b72a8f947c6040b1[ level.var_b72a8f947c6040b1.size ] = spawnentry.perplayerscriptable;
        }
        
        if ( isdefined( spawnentry.scriptable ) )
        {
            level.var_b72a8f947c6040b1[ level.var_b72a8f947c6040b1.size ] = spawnentry.scriptable;
        }
    }
    
    var_66313d6f92caabed = level.zombie_augments[ #"vulture_aid_condors_reach" ].var_f3f055a11eec0ebb;
    var_e24d1daa83bc2bce = getscriptbundle( "itemspawnlist:" + var_66313d6f92caabed );
    
    foreach ( bundle in var_e24d1daa83bc2bce.itementries )
    {
        spawnentry = getscriptbundle( bundle.itemspawnentry );
        level.var_b72a8f947c6040b1[ level.var_b72a8f947c6040b1.size ] = spawnentry.scriptable;
    }
}

// Namespace vulture_aid_augments
// Params 1, eflags: 0x4
// Checksum 0xc6020e00, Offset: 0x773
// Size: 0x2bd
function private function_14c2b4abdb31002d( params )
{
    victimstruct = spawnstruct();
    victimstruct.biscritical = istrue( self.last_dmg_struct.biscritical );
    victimstruct.var_5e0be30a5816a64d = self.var_5e0be30a5816a64d;
    victimstruct.angles = self.angles;
    victimstruct.aicategory = self.aicategory;
    
    if ( !isdefined( level.vulture_aid_augment_kill_throttle ) )
    {
        level.vulture_aid_augment_kill_throttle = throttle::throttle_initialize( "vulture_aid_augment_kill_throttle", 1 );
    }
    
    level throttle::throttle_wait_in_queue( level.vulture_aid_augment_kill_throttle, victimstruct );
    
    if ( isplayer( params.eattacker ) && isalive( params.eattacker ) )
    {
        if ( !isdefined( params.eattacker.var_e780a61de4233a8a ) )
        {
            params.eattacker.var_e780a61de4233a8a = [];
        }
        
        params.eattacker.var_c145f4d2fcf2dc99 = undefined;
        
        if ( params.eattacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"vulture_aid_camouflage" ) )
        {
            params.eattacker.var_c145f4d2fcf2dc99 = #"vulture_aid_camouflage";
        }
        else if ( params.eattacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"vulture_aid_fetidupgraid" ) )
        {
            params.eattacker.var_c145f4d2fcf2dc99 = #"vulture_aid_fetidupgraid";
        }
        
        if ( isdefined( params.eattacker.var_c145f4d2fcf2dc99 ) )
        {
            level function_f5dd3beb4b2825c1( params.eattacker, victimstruct );
        }
        
        if ( params.eattacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"vulture_aid_picky_eater" ) )
        {
            level function_66701232918612cf( params.eattacker, victimstruct, params.var_20a9d5ca930e86e1 );
        }
        
        if ( params.eattacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"vulture_aid_carrion_luggage" ) )
        {
            level function_91936ae029165694( params.eattacker, victimstruct );
        }
        
        if ( params.eattacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"vulture_aid_extra_serving" ) )
        {
            level function_90407f7a207bb9c8( params.eattacker, victimstruct );
        }
    }
}

// Namespace vulture_aid_augments
// Params 2, eflags: 0x4
// Checksum 0xaa924bb6, Offset: 0xa38
// Size: 0x158
function private function_90407f7a207bb9c8( player, victimstruct )
{
    dropchance = level.zombie_augments[ #"vulture_aid_extra_serving" ].var_bf1eebd6a5d1cd80 ?? 0.5;
    dropchance *= 100;
    
    if ( ( victimstruct.aicategory == "special" || victimstruct.aicategory == "elite" ) && utility::percent_chance( dropchance ) )
    {
        var_149193b37ce2e826 = level.perkbundles[ "specialty_vulture_aid" ].var_91a690d121868494 ?? 0.2;
        spawn_options = common_item::items_initspawnoptions_spawnfromposition( victimstruct.var_5e0be30a5816a64d, victimstruct.angles );
        spawn_options.dropradiusscale = var_149193b37ce2e826;
        spawn_options.var_c580c0e8b49f1fcc = 1;
        var_149193b37ce2e826 += 0.2;
        spawn_options.spawnpositionindex = 7;
        spawn_options.var_4a4b419f66681601 = [ player ];
        droplist = level.zombie_augments[ #"vulture_aid_extra_serving" ].var_f4eee770994a896b;
        item = player common_item::function_38cde6a6acb68ea6( droplist, 1, spawn_options );
    }
}

// Namespace vulture_aid_augments
// Params 2, eflags: 0x4
// Checksum 0x51cf6b4a, Offset: 0xb98
// Size: 0x13f
function private function_91936ae029165694( player, victimstruct )
{
    if ( victimstruct.biscritical == 1 && isplayer( player ) )
    {
        dropchance = level.zombie_augments[ #"vulture_aid_carrion_luggage" ].var_bfeec9b8beb29012 ?? 5;
        
        if ( utility::percent_chance( dropchance ) )
        {
            var_149193b37ce2e826 = level.perkbundles[ "specialty_vulture_aid" ].var_91a690d121868494 ?? 0.2;
            spawn_options = common_item::items_initspawnoptions_spawnfromposition( victimstruct.var_5e0be30a5816a64d, victimstruct.angles );
            spawn_options.dropradiusscale = var_149193b37ce2e826;
            spawn_options.var_c580c0e8b49f1fcc = 1;
            var_149193b37ce2e826 += 0.2;
            spawn_options.spawnpositionindex = 6;
            spawn_options.var_4a4b419f66681601 = [ player ];
            droplist = level.zombie_augments[ #"vulture_aid_carrion_luggage" ].var_f4eee770994a896b;
            item = player common_item::function_38cde6a6acb68ea6( droplist, 1, spawn_options );
        }
    }
}

// Namespace vulture_aid_augments
// Params 3, eflags: 0x4
// Checksum 0x7e509e30, Offset: 0xcdf
// Size: 0xcb
function private function_66701232918612cf( player, victimstruct, var_20a9d5ca930e86e1 )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    var_f3beaab24cb4457a = [ "equip_aether_blade" ];
    
    if ( isarray( var_20a9d5ca930e86e1 ) )
    {
        var_f3beaab24cb4457a = arraycombine( var_f3beaab24cb4457a, var_20a9d5ca930e86e1 );
    }
    
    if ( player.var_819dfee5ff9a56d6 )
    {
        return;
    }
    
    slot_chosen = undefined;
    
    if ( utility::percent_chance( 50 ) )
    {
        slot_chosen = "primary";
    }
    else
    {
        slot_chosen = "secondary";
    }
    
    if ( player.equipment && player.equipment[ slot_chosen ] && arraycontains( var_f3beaab24cb4457a, player.equipment[ slot_chosen ] ) )
    {
        return;
    }
    
    player drop_equipment( slot_chosen, victimstruct );
}

// Namespace vulture_aid_augments
// Params 2
// Checksum 0xa1bbb2a0, Offset: 0xdb2
// Size: 0x21d
function drop_equipment( slot, victimstruct )
{
    if ( !isdefined( level.vulture_aid_augment_equipment_drop_throttle ) )
    {
        level.vulture_aid_augment_equipment_drop_throttle = throttle::throttle_initialize( "vulture_aid_augment_equipment_drop_throttle", 1 );
    }
    
    level throttle::throttle_wait_in_queue( level.vulture_aid_augment_equipment_drop_throttle, victimstruct );
    var_d7c96fc4f4c96b12 = undefined;
    currentprimary = item_equipment::function_e9df1741d677f1bb();
    currentsecondary = item_equipment::function_c6a7cabfb1d70632();
    dropchance = level.zombie_augments[ #"vulture_aid_picky_eater" ].var_acdd40f188089acc ?? 5;
    
    switch ( slot )
    {
        case #"hash_325cb2e66f67d5b9":
            var_d7c96fc4f4c96b12 = currentprimary;
            break;
        case #"hash_511d3c24fcedcdb1":
            var_d7c96fc4f4c96b12 = currentsecondary;
            break;
        default:
            break;
    }
    
    equipment_bundle = level.var_b0ab8ba64b1718e[ var_d7c96fc4f4c96b12.name ];
    
    if ( isdefined( equipment_bundle ) )
    {
        if ( equipment_bundle.weight > 0 )
        {
            dropchance = level.zombie_augments[ #"vulture_aid_picky_eater" ].var_74d5d15786d40794 ?? 1;
        }
        else
        {
            dropchance = 0;
        }
    }
    
    if ( utility::percent_chance( dropchance ) )
    {
        if ( !isdefined( var_d7c96fc4f4c96b12 ) )
        {
            return;
        }
        
        if ( !isdefined( var_d7c96fc4f4c96b12.name ) )
        {
            return;
        }
        
        dropquantity = level.zombie_augments[ #"vulture_aid_picky_eater" ].var_673b0ffde5ace64a ?? 1;
        var_149193b37ce2e826 = level.perkbundles[ "specialty_vulture_aid" ].var_91a690d121868494 ?? 0.2;
        var_149193b37ce2e826 += 0.2;
        spawn_options = common_item::items_initspawnoptions_spawnfromposition( victimstruct.var_5e0be30a5816a64d, victimstruct.angles );
        spawn_options.dropradiusscale = var_149193b37ce2e826;
        spawn_options.spawnpositionindex = 5;
        common_item::function_61c2c0251e742ffd( var_d7c96fc4f4c96b12.name, dropquantity, spawn_options );
    }
}

// Namespace vulture_aid_augments
// Params 2, eflags: 0x4
// Checksum 0x5dd4885c, Offset: 0xfd7
// Size: 0x15d
function private function_f5dd3beb4b2825c1( player, victimstruct )
{
    if ( !isplayer( player ) || !isalive( player ) )
    {
        return;
    }
    
    if ( !isdefined( player.var_e780a61de4233a8a[ player.var_c145f4d2fcf2dc99 ] ) )
    {
        player.var_e780a61de4233a8a[ player.var_c145f4d2fcf2dc99 ] = 0;
    }
    
    if ( gettime() >= player.var_e780a61de4233a8a[ player.var_c145f4d2fcf2dc99 ] )
    {
        procchance = level.zombie_augments[ player.var_c145f4d2fcf2dc99 ].procchance ?? 20;
        
        if ( !isdefined( player.vultureaid_smokes ) )
        {
            player.vultureaid_smokes = 0;
        }
        
        if ( isdefined( procchance ) && utility::percent_chance( procchance ) && player.vultureaid_smokes < 3 )
        {
            level thread function_fbba686c2b45ca6e( victimstruct.var_5e0be30a5816a64d, player );
            level thread function_eb37a5b1b3bf78cb( victimstruct.var_5e0be30a5816a64d, player );
            player.var_e780a61de4233a8a[ player.var_c145f4d2fcf2dc99 ] = gettime() + utility::function_4b74c15943231980( level.zombie_augments[ player.var_c145f4d2fcf2dc99 ].cooldowntime ?? 20 );
        }
    }
}

// Namespace vulture_aid_augments
// Params 2, eflags: 0x4
// Checksum 0x5d33505b, Offset: 0x113c
// Size: 0x1af
function private function_fbba686c2b45ca6e( position, owner )
{
    level endon( #"game_ended" );
    
    if ( !isplayer( owner ) )
    {
        return;
    }
    
    owner.vultureaid_smokes++;
    fx_model = utility::spawn_tag_origin( position + ( 0, 0, 20 ), ( 0, 0, 0 ) );
    fx_model show();
    triggermaxsize = level.zombie_augments[ owner.var_c145f4d2fcf2dc99 ].radius ?? 70;
    trigger = spawn( "trigger_radius", position, 0, triggermaxsize, triggermaxsize );
    trigger endon( #"death" );
    trigger.owner = owner;
    trigger.playersintrigger = [];
    trigger.var_4b47655c33f51e24 = fx_model;
    waitframe();
    
    if ( isplayer( trigger.owner ) )
    {
        fx = playfxontagforclients( level._effect[ owner.var_c145f4d2fcf2dc99 ], fx_model, "tag_origin", trigger.owner );
    }
    
    if ( utility::issharedfuncdefined( #"game", #"makeenterexittrigger" ) )
    {
        [[ utility::getsharedfunc( #"game", #"makeenterexittrigger" ) ]]( trigger, &function_1a446d215fa69f28, &function_7a96e24dc69940a6 );
    }
    
    duration = level.zombie_augments[ owner.var_c145f4d2fcf2dc99 ].duration ?? 7;
    wait duration;
    trigger thread function_9f3b09c2b03a8124();
}

// Namespace vulture_aid_augments
// Params 0, eflags: 0x4
// Checksum 0x9923f109, Offset: 0x12f3
// Size: 0xc1
function private function_9f3b09c2b03a8124()
{
    foreach ( player in self.playersintrigger )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        function_7a96e24dc69940a6( player, self );
    }
    
    if ( isplayer( self.owner ) )
    {
        self.owner.vultureaid_smokes = 0;
    }
    
    self.var_4b47655c33f51e24 thread function_e87ad71b5f4d876e();
    self delete();
}

// Namespace vulture_aid_augments
// Params 0, eflags: 0x4
// Checksum 0xdfc69ba6, Offset: 0x13bc
// Size: 0x66
function private function_e87ad71b5f4d876e()
{
    var_df82735a380280da = #"vulture_aid_camouflage";
    var_ab19f3771635f49b = #"vulture_aid_fetidupgraid";
    
    if ( isdefined( self ) )
    {
        stopfxontag( level._effect[ var_df82735a380280da ], self, "tag_origin" );
        stopfxontag( level._effect[ var_ab19f3771635f49b ], self, "tag_origin" );
        wait 3;
        self delete();
    }
}

// Namespace vulture_aid_augments
// Params 2, eflags: 0x4
// Checksum 0x78d873d2, Offset: 0x142a
// Size: 0xdf
function private function_1a446d215fa69f28( player, trigger )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( trigger.owner == player )
    {
        if ( player.var_c145f4d2fcf2dc99 == #"vulture_aid_camouflage" )
        {
            if ( player getscriptablepartstate( "zm_generic_fx", 1 ) == "invisible" )
            {
                return;
            }
        }
        
        if ( isdefined( trigger.playersintrigger[ player getentitynumber() ] ) )
        {
            return;
        }
        
        trigger.playersintrigger[ player getentitynumber() ] = player;
        player.var_d6a4c8d12e422b28 = 1;
        
        if ( player.var_c145f4d2fcf2dc99 == #"vulture_aid_camouflage" )
        {
            player thread function_3b7228afd1cd9f9c();
            return;
        }
        
        if ( player.var_c145f4d2fcf2dc99 == #"vulture_aid_fetidupgraid" )
        {
            player thread function_4dffa5fc2883754();
        }
    }
}

// Namespace vulture_aid_augments
// Params 2, eflags: 0x4
// Checksum 0xb0795f8b, Offset: 0x1511
// Size: 0x4c
function private function_7a96e24dc69940a6( player, trigger )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( trigger.owner == player )
    {
        trigger.playersintrigger[ player getentitynumber() ] = undefined;
        player function_7f4dc0343c6512e7();
    }
}

// Namespace vulture_aid_augments
// Params 0, eflags: 0x4
// Checksum 0x2357d8ef, Offset: 0x1565
// Size: 0x4a
function private function_3b7228afd1cd9f9c()
{
    waitframe();
    
    if ( !isplayer( self ) || !isalive( self ) )
    {
        return;
    }
    
    utility::function_32b24db3127bff40( "vulture_aid_camouflage_fx", "camouflage_fx_on" );
    val::set( "vulture_augment_camouflage", "ignoreme", 1 );
    pbgpostfxbundlestart( self, %"cer_zm_hidden_smoke_vignette" );
}

// Namespace vulture_aid_augments
// Params 0, eflags: 0xc
// Checksum 0xdb732641, Offset: 0x15b7
// Size: 0x110
function private function_4dffa5fc2883754()
{
    self notify( #"hash_833428408d1b4ad0" );
    self endon( #"hash_833428408d1b4ad0" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    waitframe();
    
    if ( !isplayer( self ) || !isalive( self ) )
    {
        return;
    }
    
    utility::function_32b24db3127bff40( "vulture_aid_fetid_upgrade_fx", "fetid_upgrade_fx_on" );
    
    while ( self.var_d6a4c8d12e422b28 )
    {
        chargerate = level.zombie_augments[ #"vulture_aid_fetidupgraid" ].var_4335b050d6c1995d ?? 2;
        wait chargerate;
        
        if ( isplayer( self ) && isalive( self ) )
        {
            if ( !level.superglobals.var_7528e3d743bcb734 && !self.var_2364be08b6facb67 && self.var_d6a4c8d12e422b28 )
            {
                pointsgiven = level.zombie_augments[ #"vulture_aid_fetidupgraid" ].var_8797d2812132f26d ?? 5;
                supers_mp::givesuperpoints( pointsgiven );
            }
        }
    }
}

// Namespace vulture_aid_augments
// Params 0, eflags: 0x4
// Checksum 0x1d0fe6be, Offset: 0x16cf
// Size: 0x6e
function private function_7f4dc0343c6512e7()
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    self.var_d6a4c8d12e422b28 = 0;
    
    if ( self.var_c145f4d2fcf2dc99 == #"vulture_aid_camouflage" )
    {
        val::reset( "vulture_augment_camouflage", "ignoreme" );
        pbgpostfxbundleend( self, %"cer_zm_hidden_smoke_vignette" );
    }
    
    utility::function_32b24db3127bff40( "vulture_aid_camouflage_fx", "camouflage_fx_off" );
    utility::function_32b24db3127bff40( "vulture_aid_fetid_upgrade_fx", "fetid_upgrade_fx_off" );
}

// Namespace vulture_aid_augments
// Params 2, eflags: 0x4
// Checksum 0x488302dc, Offset: 0x1745
// Size: 0xa9
function private function_eb37a5b1b3bf78cb( position, player )
{
    level endon( #"game_ended" );
    wait 0.2;
    
    if ( isplayer( player ) )
    {
        soundorg = spawn( "script_origin", position );
        soundorg playloopsound( "smoke_grenade_smoke_lp" );
        duration = level.zombie_augments[ player.var_c145f4d2fcf2dc99 ].duration ?? 7;
        wait duration - 3;
        thread utility::play_sound_in_space( "smoke_grenade_smoke_tail", position );
        
        if ( isdefined( soundorg ) )
        {
            soundorg stoploopsound();
        }
        
        soundorg delete();
    }
}

// Namespace vulture_aid_augments
// Params 1, eflags: 0x4
// Checksum 0x498f2009, Offset: 0x17f6
// Size: 0x24
function private on_give_vulture_aid( params )
{
    function_1c9ac719b480fb17( {} );
    function_1c9ac719b480fb17( {} );
    function_1c9ac719b480fb17( {} );
}

// Namespace vulture_aid_augments
// Params 1, eflags: 0x4
// Checksum 0x1c2389f2, Offset: 0x1822
// Size: 0x2dc
function private function_1c9ac719b480fb17( params )
{
    if ( params.var_a020da1150a5423e < 1 )
    {
        return;
    }
    
    currentcount = armor::function_22290101992e4874();
    
    if ( currentcount <= 0 )
    {
        return;
    }
    
    if ( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_vulture_aid", #"vulture_aid_replate" ) )
    {
        var_29f0796005cbd34b = armor::function_3988e68b87d5acc0() ?? 1;
        var_219886ad4a381968 = level.var_1e9e024bcfca2274.var_3839236eb9dabdc4 ?? 125;
        var_554023bac16105cf = level.var_1e9e024bcfca2274.var_ba2fc513d06dd9d5 ?? 300;
        var_3dc0c4e27d22d986 = level.var_1e9e024bcfca2274.var_c02aad60bddb8f16 ?? 669;
        var_76c67b4b8a9ef4da = 0;
        
        switch ( var_29f0796005cbd34b )
        {
            case 1:
                var_76c67b4b8a9ef4da = self.armorhealth == 0;
                break;
            case 2:
                var_e2560e7a98540207 = var_554023bac16105cf / 2;
                var_76c67b4b8a9ef4da = self.armorhealth <= var_e2560e7a98540207;
                break;
            case 3:
                var_e2560e7a98540207 = var_3dc0c4e27d22d986 / 3;
                var_76c67b4b8a9ef4da = self.armorhealth <= var_e2560e7a98540207 * 2;
                break;
        }
        
        if ( !self.var_ae30f86752261e5f && var_76c67b4b8a9ef4da )
        {
            newarmorhealth = 0;
            
            if ( isdefined( level.var_6b5a5711823ede8c ) )
            {
                newarmorhealth = self [[ level.var_6b5a5711823ede8c ]]();
            }
            else
            {
                var_3b4517e2840c4873 = max( 1, armor::function_cb22658f54166b6b() );
                newarmorhealth = int( self.armorhealth + var_3b4517e2840c4873 );
            }
            
            if ( isdefined( self.pers[ "telemetry" ] ) && isdefined( self.pers[ "telemetry" ].armor_equipped ) )
            {
                self.pers[ "telemetry" ].armor_equipped++;
            }
            
            armor::setarmorhealth( newarmorhealth );
            newcount = maxint( 0, currentcount - 1 );
            armor::function_b359444c252374fc( newcount );
            challenges::function_4cfe18f48cc7a55c( self, undefined, level.armorref ?? "equip_armorplate" );
            
            if ( isdefined( self.armorapplied ) )
            {
                self.armorapplied += 1;
            }
            
            if ( utility::issharedfuncdefined( #"game", #"hash_fb0cbf750a27a0bc" ) )
            {
                utility::callsharedfunc( #"game", #"hash_fb0cbf750a27a0bc" );
            }
            
            callback::callback( #"hash_42a07c459e05796d" );
            
            if ( armor::getarmorhealth() == self.maxarmorhealth )
            {
                level notify( "equiped_full_armor_" + self.team, self );
            }
        }
    }
}

// Namespace vulture_aid_augments
// Params 1, eflags: 0x4
// Checksum 0x8015a244, Offset: 0x1b06
// Size: 0x4b
function private function_d6c7e7ef3462add( params )
{
    if ( params.var_ffc1674def575bfa == "specialty_vulture_aid" )
    {
        if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"vulture_aid_condors_reach" ) )
        {
            thread function_36cfe0c4d555f84e();
        }
    }
}

// Namespace vulture_aid_augments
// Params 0, eflags: 0xc
// Checksum 0xf6e59ec2, Offset: 0x1b59
// Size: 0x18f
function private function_36cfe0c4d555f84e()
{
    self notify( #"hash_7155895b6ae95855" );
    self endon( #"hash_7155895b6ae95855" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( "specialty_vulture_aid" + "_stop" );
    
    while ( true )
    {
        if ( isplayer( self ) )
        {
            validloot = level.var_b72a8f947c6040b1;
            
            if ( isdefined( validloot ) )
            {
                range = level.zombie_augments[ #"vulture_aid_condors_reach" ].radius ?? 150;
                pickuploot = getlootscriptablearrayinradius( validloot, undefined, self.origin, range );
                
                foreach ( item in pickuploot )
                {
                    waitframe();
                    
                    if ( !isdefined( item ) )
                    {
                        continue;
                    }
                    
                    if ( item.disable )
                    {
                        continue;
                    }
                    
                    itembundle = common_item::function_6b8ff3d5f2688336( item );
                    itembundlename = common_item::function_33a2c00e46263d99( item );
                    
                    if ( common_item::function_5f81801cb8c86ac2( itembundlename, itembundle, item, 1 ) )
                    {
                        common_item::function_96119bed8ab4c5d9( item, 1, 0, 0 );
                    }
                }
            }
            else
            {
                assertmsg( "<dev string:x24>" );
            }
        }
        
        wait 0.2;
    }
}

// Namespace vulture_aid_augments
// Params 1, eflags: 0x4
// Checksum 0x6574bcec, Offset: 0x1cf0
// Size: 0x9b
function private function_2d34a4f61c871fbf( params )
{
    if ( !isplayer( self.owner ) )
    {
        return;
    }
    
    if ( !self.owner utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_vulture_aid", #"vulture_aid_condors_reach" ) )
    {
        self.owner.var_e771ace57fbed908 = undefined;
        return;
    }
    
    self.owner.var_e771ace57fbed908 = level.zombie_augments[ #"vulture_aid_condors_reach" ].radius ?? 150;
}

