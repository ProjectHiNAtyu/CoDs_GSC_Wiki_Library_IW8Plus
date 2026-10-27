// scripts\mp\br\gametypes\br_interact_sidequest.gsc  (hash_6594e4c2783cdffa.gscc) (size: 17272 Bytes / 0x4378 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa7e6b6d4 (2816915156)
// size ...... 17272 (0x4378)
// includes .. 21  (offset: 0x40d4)
// strings ... 32  (offset: 0x417c)
// dev strs .. 6   (offset: 0x4330)
// exports ... 56  (offset: 0x2a70)
// cseg ...... 0x2c6 + 0x27aa (0x2a70)
// imports ... 117 (offset: 0x3330)
// animtree1 . 0   (offset: 0x4378)
// animtree2 . 0   (offset: 0x4378)
#using scripts\common\devgui;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\airdrop_scriptbundle;
#using scripts\mp\br\br_quest_inventory;
#using scripts\mp\br\gametypes\br_bunker_utility;
#using scripts\mp\br\gametypes\br_deployable_kiosk;
#using scripts\mp\br\gametypes\br_keypad_util;
#using scripts\mp\br\gametypes\br_map_quest;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\currency;
#using scripts\mp\flags;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;

#namespace br_sidequest_interact;

// Namespace br_sidequest_interact
// Params 0, eflags: 0x5
// Checksum 0x302aa2c9, Offset: 0x2e4
// Size: 0x37
function private autoexec __init__system__()
{
    system::register( #"br_interact_sidequest", [ #"br_map_quest", #"hash_60ba902b1d647a74" ], &pre_main, &post_main );
}

// Namespace br_sidequest_interact
// Params 0, eflags: 0x4
// Checksum 0x150df909, Offset: 0x323
// Size: 0x13
function private pre_main()
{
    level.var_d183bb82535202af = [];
    function_d6ec1821cce7b0a2();
}

// Namespace br_sidequest_interact
// Params 0, eflags: 0x4
// Checksum 0x743ffa2a, Offset: 0x33e
// Size: 0x1a
function private post_main()
{
    function_be42f4c9916fca3c();
    scriptable::scriptable_addusedcallbackbypart( "interact_sidequest_keypad", &keypadscriptableused );
}

// Namespace br_sidequest_interact
// Params 0
// Checksum 0x9de112b1, Offset: 0x360
// Size: 0x113
function function_be42f4c9916fca3c()
{
    foreach ( sidequest in level.var_d183bb82535202af )
    {
        if ( !level.br_map_quest.enabled )
        {
            level.br_map_quest.quests[ sidequest.name ].is_enabled = 0;
        }
        
        isenabled = level.br_map_quest.quests[ sidequest.name ].is_enabled;
        
        if ( !isenabled )
        {
            level.br_map_quest.quests[ sidequest.name ] function_1677d23360456063();
        }
    }
}

// Namespace br_sidequest_interact
// Params 0
// Checksum 0x366c0a49, Offset: 0x47b
// Size: 0x112
function function_d6ec1821cce7b0a2()
{
    mapinfo = getactivemapinfobundle();
    
    if ( !isdefined( mapinfo ) )
    {
        return;
    }
    
    if ( !isdefined( mapinfo.var_d183bb82535202af ) )
    {
        return;
    }
    
    var_1e9f007d452369d9 = getscriptbundle( mapinfo.var_d183bb82535202af );
    
    foreach ( sidequestbundle in var_1e9f007d452369d9.sidequestlist )
    {
        if ( isdefined( sidequestbundle.sidequest ) )
        {
            sidequest = getscriptbundle( sidequestbundle.sidequest );
            registersidequest( sidequest );
            level.var_d183bb82535202af[ level.var_d183bb82535202af.size ] = sidequest;
            
            /#
                level thread function_a0a4bc0df00e209c( sidequest.name );
            #/
        }
    }
}

// Namespace br_sidequest_interact
// Params 1
// Checksum 0x4a162270, Offset: 0x595
// Size: 0xf3
function registersidequest( sidequest )
{
    quest = { #interactsidequest:sidequest, #on_disabled:&on_disabled, #on_infil:&on_infil, #on_init:&on_init, #name:sidequest.name };
    quest.interactsidequest.var_993b47761b841edd = [];
    br_map_quest::register( quest );
    level.br_map_quest.quests[ quest.name ].is_enabled = isdefined( sidequest.disablesidequest ) ? !sidequest.disablesidequest : level.br_map_quest.quests[ quest.name ].is_enabled;
}

// Namespace br_sidequest_interact
// Params 0
// Checksum 0xe9639ef1, Offset: 0x690
// Size: 0x3f
function on_init()
{
    self.interactsidequest thread utility::callsharedfunc( #"interact_sidequest", getxhash( self.interactsidequest.name + "_on_init" ) );
    function_1677d23360456063();
}

// Namespace br_sidequest_interact
// Params 0
// Checksum 0x939f2aee, Offset: 0x6d7
// Size: 0x3f
function on_infil()
{
    self.interactsidequest thread utility::callsharedfunc( #"interact_sidequest", getxhash( self.interactsidequest.name + "_on_infil" ) );
    thread function_dae72d7119d24d4f();
}

// Namespace br_sidequest_interact
// Params 0
// Checksum 0x1685ae27, Offset: 0x71e
// Size: 0x38
function on_disabled()
{
    self.interactsidequest thread utility::callsharedfunc( #"interact_sidequest", getxhash( self.interactsidequest.name + "_on_disabled" ) );
}

// Namespace br_sidequest_interact
// Params 0
// Checksum 0xf447136f, Offset: 0x75e
// Size: 0x17e
function function_1677d23360456063()
{
    self.interactsidequest function_b23d4a24a5e9fe60();
    self.interactsidequest function_626ab4a41b25a440();
    
    if ( self.interactsidequest.lockeddoor.var_d2472b8f65b52d3 && isdefined( self.interactsidequest.doorlocation ) )
    {
        foreach ( doorlocation in self.interactsidequest.doorlocation )
        {
            thread lockdoor( doorlocation );
        }
    }
    
    if ( self.interactsidequest.killtrigger.var_367ff2bebb56c87f && isdefined( self.interactsidequest.killtrigger.var_d70bfd44c5336c03 ) )
    {
        self.interactsidequest thread function_ed4d3020827ad3c5( self.interactsidequest.killtrigger.var_d70bfd44c5336c03 );
    }
    
    if ( !level.br_map_quest.quests[ self.name ].is_enabled )
    {
        thread function_8d59e3b44d83ba5e();
    }
}

// Namespace br_sidequest_interact
// Params 0
// Checksum 0xb386870a, Offset: 0x8e4
// Size: 0x395
function function_dae72d7119d24d4f()
{
    if ( isdefined( self.interactsidequest.flag ) )
    {
        utility::flag_wait( self.interactsidequest.flag );
    }
    
    foreach ( interactlocation in self.interactsidequest.interactlocations )
    {
        if ( self.interactsidequest.keypad.usekeypad )
        {
            keypad = spawnscriptable( "interact_sidequest_keypad_scriptable", interactlocation.origin, interactlocation.angles );
            keypad.successfunction = &keypad_success;
            keypad.code[ "string" ] = self.interactsidequest.keypad.keypadpassword;
            keypad.quest = self.interactsidequest;
            keypad.script_codelength = int( self.interactsidequest.keypad.var_671f89c114619447 );
            
            if ( !isdefined( self.interactsidequest.keypads ) )
            {
                self.interactsidequest.keypads = [];
            }
            
            self.interactsidequest.keypads[ self.interactsidequest.keypads.size ] = keypad;
            continue;
        }
        
        scriptable = spawnscriptable( self.interactsidequest.var_80fd27cf385932eb ?? "interact_sidequest_scriptable", interactlocation.origin, interactlocation.angles );
        scriptable.interact = interaction::register_scriptable_interact( scriptable, &interactused, undefined, undefined, &interacthintstring );
        scriptable.interact.quest = self.interactsidequest;
        scriptable.interact.var_746b2f5b32febd08 = "sidequest_" + self.name;
        
        if ( !isdefined( self.interactsidequest.interactscriptables ) )
        {
            self.interactsidequest.interactscriptables = [];
        }
        
        self.interactsidequest.interactscriptables[ self.interactsidequest.interactscriptables.size ] = scriptable;
    }
    
    if ( isdefined( self.interactsidequest.keyitem.consumableitem ) && self.interactsidequest.keyitem.spawnitem )
    {
        self.interactsidequest.var_1a984eaf526e8054 = function_753e7ebd1e5ac65b( self.interactsidequest.keyitem.consumableitem, self.interactsidequest.var_ef25fd93a8c6e38d.origin, self.interactsidequest.var_ef25fd93a8c6e38d.angles );
    }
    
    flags::gameflaginit( self.name + "_interactScriptables_spawned", 1 );
}

// Namespace br_sidequest_interact
// Params 0
// Checksum 0x56b06a39, Offset: 0xc81
// Size: 0x4d3
function function_b23d4a24a5e9fe60()
{
    if ( isdefined( self.interacttarget ) )
    {
        interactlocations = utility::getstructarray( self.interacttarget );
        
        if ( isdefined( interactlocations ) )
        {
            self.interactlocations = [];
            
            foreach ( interactlocation in interactlocations )
            {
                newlocation = spawnstruct();
                newlocation.origin = interactlocation.origin;
                newlocation.angles = interactlocation.angles;
                self.interactlocations[ self.interactlocations.size ] = newlocation;
            }
        }
    }
    
    if ( self.interactlocations.size == 0 )
    {
        self.interactlocations = utility::callsharedfunc( #"interact_sidequest", getxhash( self.name + "_getInteractPositions" ) );
    }
    
    if ( self.var_6709de2d21f87343 )
    {
        if ( self.var_1e8f4bdd84ea4b34 == self.var_d36032a6687352f6 )
        {
            amount = self.var_1e8f4bdd84ea4b34;
        }
        else
        {
            amount = randomintrange( self.var_1e8f4bdd84ea4b34, self.var_d36032a6687352f6 + 1 );
        }
        
        self.interactlocations = arrayrandomize( self.interactlocations );
        self.interactlocations = utility::array_slice( self.interactlocations, 0, amount );
    }
    
    if ( isdefined( self.lootstruct ) )
    {
        foreach ( lootstruct in self.lootstruct )
        {
            if ( isdefined( lootstruct.var_c98547865c07f50d ) )
            {
                var_da342b4c9118421f = utility::getstruct( lootstruct.var_c98547865c07f50d );
                
                if ( isdefined( var_da342b4c9118421f ) )
                {
                    lootstruct.var_da342b4c9118421f = spawnstruct();
                    lootstruct.var_da342b4c9118421f.origin = var_da342b4c9118421f.origin;
                    lootstruct.var_da342b4c9118421f.angles = var_da342b4c9118421f.angles;
                }
            }
            
            if ( isdefined( lootstruct.var_3c7086f448fabffa ) )
            {
                var_2c6e29223118330a = utility::getstruct( lootstruct.var_3c7086f448fabffa );
                
                if ( isdefined( var_2c6e29223118330a ) )
                {
                    lootstruct.var_2c6e29223118330a = spawnstruct();
                    lootstruct.var_2c6e29223118330a.origin = var_2c6e29223118330a.origin;
                    lootstruct.var_2c6e29223118330a.angles = var_2c6e29223118330a.angles;
                }
            }
        }
    }
    
    if ( isdefined( self.keyitem.keytargets ) )
    {
        randomlocation = utility::array_random( self.keyitem.keytargets );
        var_ef25fd93a8c6e38d = utility::getstruct( randomlocation.location );
        
        if ( isdefined( var_ef25fd93a8c6e38d ) )
        {
            self.var_ef25fd93a8c6e38d = spawnstruct();
            self.var_ef25fd93a8c6e38d.origin = var_ef25fd93a8c6e38d.origin;
            self.var_ef25fd93a8c6e38d.angles = var_ef25fd93a8c6e38d.angles;
        }
    }
    
    if ( isdefined( self.lockeddoor.doortargetname ) )
    {
        doorlocations = utility::getstructarray( self.lockeddoor.doortargetname );
        
        if ( isdefined( doorlocations ) )
        {
            self.doorlocation = [];
            
            foreach ( doorlocation in doorlocations )
            {
                newlocation = spawnstruct();
                newlocation.origin = doorlocation.origin;
                newlocation.angles = doorlocation.angles;
                self.doorlocation[ self.doorlocation.size ] = newlocation;
            }
        }
    }
}

/#

    // Namespace br_sidequest_interact
    // Params 0
    // Checksum 0x33be51b4, Offset: 0x115c
    // Size: 0x5, Type: dev
    function function_8bea705ff109b3e3()
    {
        
    }

#/

// Namespace br_sidequest_interact
// Params 0
// Checksum 0xfd7c7889, Offset: 0x1169
// Size: 0x141
function function_626ab4a41b25a440()
{
    foreach ( lootstruct in self.lootstruct )
    {
        if ( lootstruct.lootdroptype == "airdrop" )
        {
            foreach ( airdropinfo in lootstruct.airdroppackages )
            {
                if ( !airdrop_scriptbundle::function_fa19528c206bd43( airdropinfo.airdrop ) )
                {
                    if ( airdropinfo.var_7bdf102b0db91211 )
                    {
                        level thread br_deployable_kiosk::function_1cc0e3b19bbe480c( airdropinfo.airdrop );
                        continue;
                    }
                    
                    airdrop_scriptbundle::registerairdrop( airdropinfo.airdrop );
                }
            }
        }
    }
}

// Namespace br_sidequest_interact
// Params 1
// Checksum 0x1863f1d6, Offset: 0x12b2
// Size: 0x1c7
function function_b5c048d9c5e0e3b7( player )
{
    if ( !isdefined( self.lootstruct ) )
    {
        return;
    }
    
    foreach ( lootstruct in self.lootstruct )
    {
        if ( lootstruct.itemspawnlist && lootstruct.var_74030fcf087ad767 )
        {
            assertmsg( "<dev string:x24>" );
            continue;
        }
        
        if ( lootstruct.lootdroptype == "airdrop" )
        {
            function_d0da89aba1a75b8e( lootstruct );
            continue;
        }
        else if ( lootstruct.lootdroptype == "at_pos" )
        {
            spawnoptions = common_item::function_bc5ff2958b71a708( lootstruct.var_2c6e29223118330a.origin, lootstruct.var_2c6e29223118330a.angles );
        }
        else if ( lootstruct.lootdroptype == "to_pos_from_pos" )
        {
            spawnoptions = common_item::function_f5dfaa3bbdf99a33( lootstruct.var_2c6e29223118330a.origin, lootstruct.var_da342b4c9118421f.origin, lootstruct.var_2c6e29223118330a.angles );
        }
        else
        {
            spawnoptions = common_item::items_initspawnoptions_spawnfromposition( lootstruct.var_da342b4c9118421f.origin, lootstruct.var_da342b4c9118421f.angles );
        }
        
        thread function_c0f00c1b27c12a35( lootstruct, spawnoptions, player );
    }
}

// Namespace br_sidequest_interact
// Params 3
// Checksum 0x31c1e17a, Offset: 0x1481
// Size: 0x136
function function_c0f00c1b27c12a35( lootstruct, spawnoptions, player )
{
    level endon( #"game_ended" );
    self endon( #"quest_completed" );
    spawnlistname = function_bcaa27f2008ecfa4( lootstruct );
    lootsetcount = lootstruct.lootsetcount ?? 1;
    
    if ( lootstruct.var_5f8fce9f698af946 )
    {
        multiplier = game_utility::function_f24780eadd3fb772();
        lootsetcount *= multiplier;
    }
    
    if ( lootstruct.var_16f2af8fba4e478b )
    {
        teamcount = teams::getteamdata( player.team, "teamCount" );
        lootstruct.lootquantity += teamcount;
    }
    
    var_1ee5b24d57cb5fb8 = lootstruct.var_8e487ce9f9d67ca8 ?? 0;
    var_a5c0a5382b2ad0cc = lootstruct.var_9ef58196fedeb5e ?? 0;
    wait var_1ee5b24d57cb5fb8;
    
    for ( i = 0; i < lootsetcount ; i++ )
    {
        common_item::function_38cde6a6acb68ea6( spawnlistname, lootstruct.lootquantity, spawnoptions );
        wait var_a5c0a5382b2ad0cc;
    }
}

// Namespace br_sidequest_interact
// Params 1
// Checksum 0x6e09af98, Offset: 0x15bf
// Size: 0x4e
function function_bcaa27f2008ecfa4( lootstruct )
{
    if ( lootstruct.var_74030fcf087ad767 )
    {
        spawnlist = common_cache::function_73fc13f2febd3a2( lootstruct.var_74030fcf087ad767 );
        return spawnlist.spawnlistname;
    }
    
    return lootstruct.itemspawnlist;
}

// Namespace br_sidequest_interact
// Params 1
// Checksum 0xf68da478, Offset: 0x1616
// Size: 0x9c
function function_d0da89aba1a75b8e( lootstruct )
{
    var_13ae67772953fa98 = getairdropbaseorigin( self, lootstruct );
    
    foreach ( airdrop in lootstruct.airdroppackages )
    {
        level thread function_ab944d711279b449( var_13ae67772953fa98, airdrop );
    }
}

// Namespace br_sidequest_interact
// Params 1, eflags: 0x4
// Checksum 0x4b181cec, Offset: 0x16ba
// Size: 0x40
function private function_233b3f80fd218b8f( airdropinfo )
{
    offset = airdropinfo.offset;
    
    if ( !isdefined( offset ) )
    {
        return ( 0, 0, 0 );
    }
    
    return utility::function_b73ecb08dfaa1bc5( offset );
}

// Namespace br_sidequest_interact
// Params 2, eflags: 0x4
// Checksum 0x980e58d7, Offset: 0x1703
// Size: 0x8e
function private getairdropbaseorigin( quest, lootstruct )
{
    var_7237854e3be197ca = lootstruct.var_2c6e29223118330a.origin;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    callbackname = getxhash( quest.name + "_getAirdropBaseOrigin" );
    callbackorigin = quest utility::callsharedfunc( #"interact_sidequest", callbackname, lootstruct );
    return callbackorigin ?? ( 0, 0, 0 );
}

// Namespace br_sidequest_interact
// Params 2
// Checksum 0xbbee97e6, Offset: 0x179a
// Size: 0x6f
function function_ab944d711279b449( var_13ae67772953fa98, airdropinfo )
{
    level endon( #"game_ended" );
    wait airdropinfo.delay;
    dropoffset = function_233b3f80fd218b8f( airdropinfo );
    overridestruct = { #droporigin:var_13ae67772953fa98 + dropoffset };
    thread airdrop_scriptbundle::startairdrop( airdropinfo.airdrop, undefined, undefined, overridestruct );
}

/#

    // Namespace br_sidequest_interact
    // Params 0
    // Checksum 0x300a2bf5, Offset: 0x1811
    // Size: 0x5, Type: dev
    function function_ca9b30633cbb6920()
    {
        
    }

#/

// Namespace br_sidequest_interact
// Params 3
// Checksum 0x17c9b24b, Offset: 0x181e
// Size: 0x53
function function_753e7ebd1e5ac65b( itemname, origin, angles )
{
    itembundle = common_item::function_cf68ad18114498b2( itemname );
    
    if ( !isdefined( itembundle ) )
    {
        return;
    }
    
    keyitem = common_item::function_a87dc047f584d2c7( itembundle, origin, angles, undefined, 1 );
    return keyitem;
}

/#

    // Namespace br_sidequest_interact
    // Params 0
    // Checksum 0x62f3e405, Offset: 0x187a
    // Size: 0x5, Type: dev
    function function_57ed1f26808f7c63()
    {
        
    }

#/

// Namespace br_sidequest_interact
// Params 1, eflags: 0x4
// Checksum 0xb32448b9, Offset: 0x1887
// Size: 0xae
function private keypad_success( instance )
{
    instance.quest sidequestcompleted( self, instance );
    
    foreach ( keypad in instance.quest.keypads )
    {
        keypad setscriptablepartstate( "interact_sidequest_keypad", "off" );
    }
}

// Namespace br_sidequest_interact
// Params 6, eflags: 0x4
// Checksum 0x8914fbc8, Offset: 0x193d
// Size: 0x48
function private keypadscriptableused( instance, part, state, player, bautouse, usestring )
{
    level thread _keypadscriptableused( instance, part, state, player, bautouse );
}

// Namespace br_sidequest_interact
// Params 5, eflags: 0x4
// Checksum 0x9e1b13ee, Offset: 0x198d
// Size: 0x88
function private _keypadscriptableused( instance, part, state, player, bautouse )
{
    assert( part == "<dev string:x64>" );
    instance setscriptablepartstate( part, "off" );
    player br_bunker_utility::keypad_playerinteractwithkeypadloop( instance );
    
    if ( isdefined( player ) )
    {
        player br_keypad_util::playersetkeypadstateindex( 0 );
    }
    
    wait 1;
    
    if ( instance.codestatus != 2 )
    {
        instance setscriptablepartstate( part, "on" );
    }
}

// Namespace br_sidequest_interact
// Params 0, eflags: 0x4
// Checksum 0x177190b4, Offset: 0x1a1d
// Size: 0xee
function private function_8d59e3b44d83ba5e()
{
    level endon( #"game_ended" );
    flags::function_2f3408423ccc9b2e( "prematch_fade_done" );
    
    if ( self.interactsidequest.keypad.usekeypad )
    {
        foreach ( interactlocation in self.interactsidequest.interactlocations )
        {
            keypad = spawnscriptable( "interact_sidequest_keypad_scriptable", interactlocation.origin, interactlocation.angles );
            keypad setscriptablepartstate( "interact_sidequest_keypad", "disabled" );
        }
    }
}

/#

    // Namespace br_sidequest_interact
    // Params 0
    // Checksum 0x4ed40bfe, Offset: 0x1b13
    // Size: 0x5, Type: dev
    function function_903998cc6c35e471()
    {
        
    }

#/

// Namespace br_sidequest_interact
// Params 1
// Checksum 0x6e584412, Offset: 0x1b20
// Size: 0x1e0
function interactused( player )
{
    if ( function_cd0dcb8dd3fa6f6f( player ) )
    {
        return;
    }
    
    needitem = isdefined( self.quest.keyitem.consumableitem ) || self.quest.keyitem.usemoney;
    
    if ( !function_f0cf2c461270fd6f( player ) && needitem )
    {
        interacterror( player, self.quest.keyitem.var_3bd3ce965dd8232c, self.quest.keyitem.var_2f21232714e2eebc, self.quest.keyitem.var_dc079e1e10efa47f, self.quest.keyitem.var_49a4cf2d60ed83ca );
        return;
    }
    
    interactsuccess = function_f177d852da235445( player );
    
    if ( !interactsuccess )
    {
        interacterror( player, self.quest.var_38678346c1ffcaf, self.quest.var_bf6248982a23cc7f, self.quest.var_231d97912268fb3e, self.quest.var_69baedaa065b351f );
        self setscriptablepartstate( "base", "failed" );
        thread function_d79025109554c3f0();
        utility::callsharedfunc( #"interact_sidequest", getxhash( self.name + "_on_interact_fail" ) );
        return;
    }
    
    disableinteracts();
    self.quest.var_993b47761b841edd[ self.quest.var_993b47761b841edd.size ] = player;
    self.quest sidequestcompleted( player, self );
}

// Namespace br_sidequest_interact
// Params 1
// Checksum 0x419e209b, Offset: 0x1d08
// Size: 0x63
function function_cd0dcb8dd3fa6f6f( player )
{
    if ( arraycontains( self.quest.var_993b47761b841edd, player ) )
    {
        if ( isdefined( self.quest.var_51922303d9229f0a ) )
        {
            player [[ level.showerrormessagefunc ]]( self.quest.var_51922303d9229f0a );
        }
        
        return 1;
    }
}

// Namespace br_sidequest_interact
// Params 1
// Checksum 0x7465057c, Offset: 0x1d73
// Size: 0x149
function function_f0cf2c461270fd6f( player )
{
    var_7089410b4e99793d = 0;
    
    if ( isdefined( self.quest.keyitem.consumableitem ) )
    {
        if ( player br_quest_inventory::has_quest_item( self.quest.keyitem.consumableitem ) )
        {
            var_7089410b4e99793d = 1;
            
            if ( self.quest.keyitem.useitem )
            {
                player br_quest_inventory::consume_quest_item( self.quest.keyitem.consumableitem );
            }
        }
    }
    else if ( self.quest.keyitem.usemoney )
    {
        if ( player currency::can_afford( level.gametypebundle.currencytype, self.quest.keyitem.interactcost ) )
        {
            var_7089410b4e99793d = 1;
            player currency::function_b5fe1e05c892a7f3( level.gametypebundle.currencytype, self.quest.keyitem.interactcost );
        }
    }
    
    return var_7089410b4e99793d;
}

// Namespace br_sidequest_interact
// Params 1
// Checksum 0xf384df0a, Offset: 0x1ec5
// Size: 0xa1
function function_f177d852da235445( player )
{
    success = 1;
    
    if ( self.quest.var_c0fceb8d457d783a < 100 )
    {
        success = utility::percent_chance( self.quest.var_c0fceb8d457d783a );
    }
    
    if ( self.quest.var_2817929e0b7be2b1 )
    {
        self.quest.var_c0fceb8d457d783a += self.quest.var_2817929e0b7be2b1;
    }
    
    return success;
}

// Namespace br_sidequest_interact
// Params 5
// Checksum 0xd2d223c1, Offset: 0x1f6f
// Size: 0x61
function interacterror( player, errormsg, errorsound, sounddelay, soundpos )
{
    if ( isdefined( errormsg ) )
    {
        player [[ level.showerrormessagefunc ]]( errormsg );
    }
    
    if ( isdefined( errorsound ) )
    {
        thread function_83b6a2cb36339066( player, self.origin, errorsound, sounddelay, soundpos );
    }
}

// Namespace br_sidequest_interact
// Params 0
// Checksum 0xf2b4888b, Offset: 0x1fd8
// Size: 0xba
function function_d79025109554c3f0()
{
    cooldown = self.quest.var_2365022442c4bed;
    
    if ( cooldown > 0 )
    {
        wait cooldown;
    }
    
    if ( self.quest.var_42e8f205ff738387 > 0 )
    {
        self.quest.var_2365022442c4bed += self.quest.var_42e8f205ff738387;
    }
    
    self.quest.var_1a3e06bbdeb76db--;
    
    if ( self.quest.var_1a3e06bbdeb76db > 0 )
    {
        self setscriptablepartstate( "base", "alive" );
    }
}

// Namespace br_sidequest_interact
// Params 0
// Checksum 0xe241aff2, Offset: 0x209a
// Size: 0xbd
function disableinteracts()
{
    if ( self.quest.repeatinteract )
    {
        self setscriptablepartstate( "base", "disabled" );
        thread function_d79025109554c3f0();
        return;
    }
    
    foreach ( interact in self.quest.interactscriptables )
    {
        interact setscriptablepartstate( "base", "disabled" );
    }
}

// Namespace br_sidequest_interact
// Params 2
// Checksum 0xd7c2eab7, Offset: 0x215f
// Size: 0xba
function interacthintstring( interact, player )
{
    hintstruct = { #interactable:1, #var_26bbd300351fde34:0, #string:interact.quest.prompt, #type:"HINT_BUTTON" };
    
    if ( interact.quest.keyitem.usemoney )
    {
        hintstruct.params = [ interact.quest.keyitem.interactcost * 10 ];
    }
    
    return hintstruct;
}

/#

    // Namespace br_sidequest_interact
    // Params 0
    // Checksum 0x65b53df1, Offset: 0x2222
    // Size: 0x5, Type: dev
    function function_8bd140bc23eeaab3()
    {
        
    }

#/

// Namespace br_sidequest_interact
// Params 2
// Checksum 0xed03c457, Offset: 0x222f
// Size: 0x106
function sidequestcompleted( player, interact )
{
    if ( self.is_completed && ( !self.repeatinteract || self.var_1a3e06bbdeb76db <= 0 ) )
    {
        return;
    }
    
    params = { #completed_by:teams::getteamdata( player.team, "players" ), #is_successful:1 };
    br_map_quest::on_completed( params );
    thread executecallbackfunction( player );
    thread function_83b6a2cb36339066( player, interact.origin, self.var_6734ad8de1962b51, self.var_815314d99ac1c1ed, self.var_915574c32490f60 );
    givescoreevent( player );
    function_b5c048d9c5e0e3b7( player );
    questexploder( self.completionexploder );
    unlockdoor();
    function_d76bd77d10b9cb22();
    challenges::function_37e945722d6497f3( player, self.challengeref, 1, 1 );
    function_62ae05f98f13c009( player );
}

// Namespace br_sidequest_interact
// Params 1
// Checksum 0xba431b81, Offset: 0x233d
// Size: 0x3a
function givescoreevent( player )
{
    if ( !isdefined( self.scoreeventref ) )
    {
        return;
    }
    
    points::function_40522c040a4e7b1( player.team, getxhash( self.scoreeventref ) );
}

// Namespace br_sidequest_interact
// Params 1
// Checksum 0x5456062f, Offset: 0x237f
// Size: 0x35
function function_62ae05f98f13c009( player )
{
    if ( isdefined( player ) )
    {
        player dlog_recordplayerevent( "dlog_event_interact_sidequest_completion", [ "quest_name", self.name ] );
    }
}

// Namespace br_sidequest_interact
// Params 1
// Checksum 0xb0a82c0c, Offset: 0x23bc
// Size: 0x2b
function executecallbackfunction( player )
{
    utility::callsharedfunc( #"interact_sidequest", getxhash( self.name ), player );
}

/#

    // Namespace br_sidequest_interact
    // Params 0
    // Checksum 0xed7f7af, Offset: 0x23ef
    // Size: 0x5, Type: dev
    function function_e51353074923d1c7()
    {
        
    }

#/

// Namespace br_sidequest_interact
// Params 1
// Checksum 0x2862d876, Offset: 0x23fc
// Size: 0xb1
function lockdoor( doorlocation )
{
    level waittill( #"scriptables_ready" );
    door = function_6cf720856f2ecd74( doorlocation.origin, 100 );
    
    if ( isdefined( door ) )
    {
        if ( !isdefined( self.interactsidequest.var_21711ffa03ce6d2f ) )
        {
            self.interactsidequest.var_21711ffa03ce6d2f = [];
        }
        
        self.interactsidequest.var_21711ffa03ce6d2f[ self.interactsidequest.var_21711ffa03ce6d2f.size ] = door;
        door scriptabledoorfreeze( 1 );
        
        if ( !self.is_enabled )
        {
            function_a3c9b47a06362985( door );
        }
    }
}

// Namespace br_sidequest_interact
// Params 1
// Checksum 0x6bc6242a, Offset: 0x24b5
// Size: 0x1b
function questexploder( exploderref )
{
    if ( isdefined( exploderref ) )
    {
        utility::exploder( exploderref );
    }
}

// Namespace br_sidequest_interact
// Params 0
// Checksum 0x253791fd, Offset: 0x24d8
// Size: 0x9e
function unlockdoor()
{
    if ( !isdefined( self.var_21711ffa03ce6d2f ) )
    {
        return;
    }
    
    foreach ( door in self.var_21711ffa03ce6d2f )
    {
        door scriptabledoorfreeze( 0 );
        playsoundatpos( door.origin, "evt_door_unlock" );
    }
}

// Namespace br_sidequest_interact
// Params 1
// Checksum 0xf22777cb, Offset: 0x257e
// Size: 0xfb
function function_a3c9b47a06362985( door )
{
    var_e367641af88b0c01 = anglestoforward( door.angles ) * 52 / 2;
    offset = var_e367641af88b0c01 + anglestoright( door.angles );
    gate = spawnscriptable( "blocker_toggleable_door_security_gate_single_vis", door.origin + offset, door.angles + ( 0, -90, 0 ) );
    gate setscriptablepartstate( "state", "visible" );
    var_a4010d4e681c2351 = var_e367641af88b0c01 + anglestoleft( door.angles );
    var_63e18d1dc3e03bf9 = spawnscriptable( "blocker_toggleable_door_security_gate_single_vis", door.origin + var_a4010d4e681c2351, door.angles + ( 0, 90, 0 ) );
    var_63e18d1dc3e03bf9 setscriptablepartstate( "state", "visible" );
}

/#

    // Namespace br_sidequest_interact
    // Params 0
    // Checksum 0x2053abde, Offset: 0x2681
    // Size: 0x5, Type: dev
    function function_143ade3a9e94a6c0()
    {
        
    }

#/

// Namespace br_sidequest_interact
// Params 1
// Checksum 0x3baefce3, Offset: 0x268e
// Size: 0xdc
function function_ed4d3020827ad3c5( triggertarget )
{
    level waittill( #"scriptables_ready" );
    triggerarray = getnoentvolumearray( triggertarget, #targetname );
    
    foreach ( trigger in triggerarray )
    {
        if ( isdefined( trigger ) )
        {
            if ( !isdefined( self.killtriggers ) )
            {
                self.killtriggers = [];
            }
            
            self.killtriggers[ self.killtriggers.size ] = trigger;
            trigger::makeenterexittrigger( trigger, &function_4c6242c8e3089a54 );
        }
    }
}

// Namespace br_sidequest_interact
// Params 2
// Checksum 0x778738e7, Offset: 0x2772
// Size: 0x38
function function_4c6242c8e3089a54( player, killtrigger )
{
    if ( isplayer( player ) )
    {
        player kill( player.origin, player, player, "MOD_TRIGGER_HURT" );
    }
}

// Namespace br_sidequest_interact
// Params 0
// Checksum 0x67b5d111, Offset: 0x27b2
// Size: 0x8e
function function_d76bd77d10b9cb22()
{
    if ( !isdefined( self.killtriggers ) )
    {
        return;
    }
    
    foreach ( trigger in self.killtriggers )
    {
        trigger notify( #"hash_73537c07898a047a" );
    }
}

/#

    // Namespace br_sidequest_interact
    // Params 0
    // Checksum 0x93bec948, Offset: 0x2848
    // Size: 0x5, Type: dev
    function function_fa5639188a80b1ea()
    {
        
    }

#/

// Namespace br_sidequest_interact
// Params 5
// Checksum 0xf6a802c7, Offset: 0x2855
// Size: 0x9a
function function_83b6a2cb36339066( player, interactorigin, soundname, sounddelay, soundpos )
{
    level endon( #"game_ended" );
    
    if ( !soundname )
    {
        return;
    }
    
    if ( sounddelay )
    {
        wait sounddelay;
    }
    
    switch ( soundpos )
    {
        case #"hash_79379a76247cec00":
            playsoundatpos( interactorigin, soundname );
            break;
        case #"hash_38498a8625c859b8":
            audio_utility::function_63bf1584c79c055( [ player ], soundname );
            break;
        default:
            break;
    }
}

/#

    // Namespace br_sidequest_interact
    // Params 1, eflags: 0x4
    // Checksum 0x10e1ee67, Offset: 0x28f7
    // Size: 0x44, Type: dev
    function private function_a0a4bc0df00e209c( questname )
    {
        devgui::function_9082edeb5db93280( "<dev string:x7e>" + questname + "<dev string:x8c>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x8e>", "<dev string:xa2>" + questname, &function_d2f086afc90ebef0 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace br_sidequest_interact
    // Params 1, eflags: 0x4
    // Checksum 0x67658b81, Offset: 0x2943
    // Size: 0x12d, Type: dev
    function private function_d2f086afc90ebef0( params )
    {
        player = level.players[ 0 ];
        
        if ( !isdefined( player ) )
        {
            return;
        }
        
        questname = params[ 0 ];
        
        foreach ( quest in level.var_d183bb82535202af )
        {
            if ( quest.name == questname )
            {
                var_96af409778b6b941 = quest.repeatinteract;
                var_abe455cebc74c0d = quest.var_1a3e06bbdeb76db;
                quest.repeatinteract = 1;
                quest.var_1a3e06bbdeb76db = var_abe455cebc74c0d + 1;
                quest sidequestcompleted( player, undefined );
                quest.repeatinteract = var_96af409778b6b941;
                quest.var_1a3e06bbdeb76db = var_abe455cebc74c0d;
                break;
            }
        }
    }

#/
