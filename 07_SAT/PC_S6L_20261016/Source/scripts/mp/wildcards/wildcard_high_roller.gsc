// scripts\mp\wildcards\wildcard_high_roller.gsc  (hash_1fa6b583cbdeadea.gscc) (size: 6676 Bytes / 0x1a14 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8ce9cc12 (2364132370)
// size ...... 6676 (0x1a14)
// includes .. 3   (offset: 0x1888)
// strings ... 16  (offset: 0x18a0)
// dev strs .. 8   (offset: 0x19b4)
// exports ... 23  (offset: 0x10e4)
// cseg ...... 0x269 + 0xe7b (0x10e4)
// imports ... 35  (offset: 0x147c)
// animtree1 . 0   (offset: 0x1a14)
// animtree2 . 0   (offset: 0x1a14)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\mp\common\killstreaks\killstreaks;

#namespace wildcard_high_roller;

// Namespace wildcard_high_roller
// Params 0, eflags: 0x5
// Checksum 0x2888275c, Offset: 0x287
// Size: 0x18
function private autoexec preinit()
{
    level callback::add( #"register_perk", &function_58444f7322bdb955 );
}

// Namespace wildcard_high_roller
// Params 1
// Checksum 0x141fe1cf, Offset: 0x2a7
// Size: 0x15e
function function_58444f7322bdb955( params )
{
    bundle = level.wildcardbundles[ "wildcard_high_roller" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "wildcard_high_roller", &function_b61aa652f6c295e0, &function_9a5b5ccd01c88b31, [], &function_a6abc618b217065e );
    }
    
    level callback::add( #"hash_5ab6d087553bd62f", &function_df4762cd4c5a4d27 );
    level callback::add( #"hash_efd1801a62921f1c", &function_74f5300fa6f53030 );
    level callback::add( #"hash_263b7787b761917f", &function_5afc7eb048a89ecf );
    level callback::add( #"hash_152a1ab7758bead2", &function_ba6f75ad0a9a15d8 );
    level callback::add( #"hash_dd3af83b12238bf5", &function_19bb303f3a93e7e1 );
    level callback::add( #"hash_15b5bc31a89fd02b", &function_34d2b9325385441 );
    level callback::add( #"hash_bc53f926031ea3f6", &function_5cc1f88469699f3d );
    level callback::add( #"hash_dd3cc659d7255154", &function_c068712dd5be0c27 );
    level callback::add( #"hash_a1314093a84c7a9d", &function_43925749fce6925d );
    level callback::add( #"hash_2e73c786a3b2d7b2", &function_aed9781cf81dd1c2 );
    level callback::add( #"killstreak_finish_use", &function_c35bf7a73f65a349 );
    
    /#
        debuginit();
    #/
}

// Namespace wildcard_high_roller
// Params 0, eflags: 0x4
// Checksum 0xd950be96, Offset: 0x40d
// Size: 0x119
function private function_a6abc618b217065e()
{
    maxtries = 30;
    tries = 0;
    
    while ( !level.var_efe904b9522300b6 && tries < maxtries )
    {
        tries++;
        waitframe();
    }
    
    var_d095f005c0da8be0 = level.sharedfuncs[ #"killstreak" ][ #"hash_5f93815d19d9921b" ];
    
    if ( !isdefined( var_d095f005c0da8be0 ) )
    {
        assertmsg( "<dev string:x24>" );
    }
    
    streakomnvars = { #var_1aff168701aa25e3:"ui_score_streak_earned_time_high_roller", #stowableomnvar:"ui_score_streak_stowable_high_roller", #inboundomnvar:"ui_score_streak_inbound_high_roller", #var_9892270410a78bc6:"ui_score_streak_last_round_earned_high_roller", #var_6b5a9f1cf7b9a33b:"ui_score_streak_time_in_use_high_roller", #blockedomnvar:"ui_score_streak_blocked_state_high_roller", #var_d18451bc463ec462:"ui_score_streak_used_this_life_high_roller", #availableomnvar:"ui_score_streak_available_high_roller", #slotomnvar:"ui_score_streak_index_high_roller", #costomnvar:"ui_score_streak_cost_high_roller" };
    [[ var_d095f005c0da8be0 ]]( #"high_roller", streakomnvars );
}

// Namespace wildcard_high_roller
// Params 0, eflags: 0x4
// Checksum 0x13bb5760, Offset: 0x52e
// Size: 0x23
function private function_b61aa652f6c295e0()
{
    self [[ level.sharedfuncs[ #"killstreak" ][ #"hash_3163ed1117273710" ] ]]();
}

// Namespace wildcard_high_roller
// Params 0, eflags: 0x4
// Checksum 0x340ea388, Offset: 0x559
// Size: 0x23
function private function_9a5b5ccd01c88b31()
{
    self [[ level.sharedfuncs[ #"killstreak" ][ #"hash_3163ed1117273710" ] ]]();
}

// Namespace wildcard_high_roller
// Params 1, eflags: 0x4
// Checksum 0x3adf594f, Offset: 0x584
// Size: 0x92
function private function_df4762cd4c5a4d27( params )
{
    if ( isdefined( self.perks[ "wildcard_high_roller" ] ) )
    {
        params.var_bc80fe1ba4bc4e52[ params.var_bc80fe1ba4bc4e52.size ] = #"high_roller";
        return;
    }
    
    if ( self.streakdata.streaks[ #"high_roller" ].quantity > 0 )
    {
        params.var_bc80fe1ba4bc4e52[ params.var_bc80fe1ba4bc4e52.size ] = #"high_roller";
    }
}

// Namespace wildcard_high_roller
// Params 1, eflags: 0x4
// Checksum 0x7d4cffaf, Offset: 0x61e
// Size: 0x3e, Type: bool
function private function_74f5300fa6f53030( params )
{
    if ( params.classa.var_22adeafdea660e78 != params.classb.var_22adeafdea660e78 )
    {
        return false;
    }
    
    return true;
}

// Namespace wildcard_high_roller
// Params 1, eflags: 0x4
// Checksum 0x4d6496ad, Offset: 0x665
// Size: 0x62
function private function_880201aa8baef909( params )
{
    params.copystruct.var_22adeafdea660e78 = params.classstruct.var_22adeafdea660e78;
    params.copystruct.var_3dc3538e1b2c4de9 = params.classstruct.var_3dc3538e1b2c4de9;
}

// Namespace wildcard_high_roller
// Params 1, eflags: 0x4
// Checksum 0x4c6f995e, Offset: 0x6cf
// Size: 0x37
function private function_19bb303f3a93e7e1( params )
{
    params.copiedstruct.var_22adeafdea660e78 = params.classstruct.var_22adeafdea660e78;
}

// Namespace wildcard_high_roller
// Params 1, eflags: 0x4
// Checksum 0x99e2cd9e, Offset: 0x70e
// Size: 0x3e
function private function_34d2b9325385441( params )
{
    params.struct.var_22adeafdea660e78 = "none";
    params.struct.var_3dc3538e1b2c4de9 = 0;
}

// Namespace wildcard_high_roller
// Params 1, eflags: 0x4
// Checksum 0xb87e01f2, Offset: 0x754
// Size: 0x2a7
function private function_5cc1f88469699f3d( params )
{
    var_8c260c92a8bd05ea = level.sharedfuncs[ #"loot" ][ #"hash_ca4103c28ac67fef" ];
    
    /#
        if ( params.var_4d362babbfd5b4b1 && !var_8c260c92a8bd05ea )
        {
            assertmsg( "<dev string:x6e>" );
        }
    #/
    
    if ( level.gametypebundle.var_8c6019c19fcca74c )
    {
        cackillstreak = level.gametypebundle.var_8c6019c19fcca74c;
    }
    else if ( self.var_8c6019c19fcca74c )
    {
        cackillstreak = self.var_8c6019c19fcca74c;
    }
    else if ( params.var_4d362babbfd5b4b1 && var_8c260c92a8bd05ea )
    {
        lootid = self getplayerdata( level.loadoutdata, #"highrollerkillstreaksetup", #"killstreaklootid" );
        
        if ( lootid == 0 )
        {
            cackillstreak = "none";
        }
        else
        {
            cackillstreak = [[ var_8c260c92a8bd05ea ]]( lootid );
            
            if ( cackillstreak.size == 0 )
            {
                cackillstreak = "none";
            }
        }
        
        fromloadout = 1;
    }
    else
    {
        cackillstreak = self getplayerdata( level.loadoutdata, #"squadmembers", #"highrollerkillstreaksetup", #"killstreak" );
        fromloadout = 1;
    }
    
    if ( fromloadout && cackillstreak != "none" )
    {
        streakbundles = level.streakglobals.streakbundles;
        
        if ( !streakbundles[ cackillstreak ].var_883566fc1e9d2da3 )
        {
            cackillstreak = "none";
        }
        else if ( killstreakisrestricted( cackillstreak ) )
        {
            cackillstreak = "none";
        }
        else
        {
            var_32dbca3143d9c4a5 = level.sharedfuncs[ #"loot" ][ #"isitembannedbyref" ];
            
            if ( var_32dbca3143d9c4a5 && self [[ var_32dbca3143d9c4a5 ]]( cackillstreak ) )
            {
                cackillstreak = "none";
            }
        }
    }
    
    if ( cackillstreak == "none" )
    {
        if ( !level.onlinegame || getdvarint( @"xblive_privatematch" ) )
        {
            cackillstreak = function_78f358bd76c9853d( params );
        }
    }
    
    params.struct.var_22adeafdea660e78 = cackillstreak != "none" ? cackillstreak : "radar_ping";
    blueprintindex = function_9f6f840868cfaebb( params.var_4d362babbfd5b4b1, params.struct.var_22adeafdea660e78 );
    
    if ( level.gametypebundle.var_8c6019c19fcca74c )
    {
        blueprintindex = 0;
    }
    
    params.struct.var_3dc3538e1b2c4de9 = blueprintindex;
}

// Namespace wildcard_high_roller
// Params 2, eflags: 0x4
// Checksum 0x3f0cc7a9, Offset: 0xa03
// Size: 0x69
function private function_9f6f840868cfaebb( var_4d362babbfd5b4b1, killstreakref )
{
    if ( var_4d362babbfd5b4b1 )
    {
        lootid = self getplayerdata( level.loadoutdata, "highRollerKillstreakSetup", "blueprintLootID" );
    }
    else
    {
        lootid = self getplayerdata( level.loadoutdata, "squadMembers", "highRollerKillstreakSetup", "blueprintLootID" );
    }
    
    return killstreaks::function_a9203223832db05d( killstreakref, lootid );
}

// Namespace wildcard_high_roller
// Params 1, eflags: 0x4
// Checksum 0x6061bbd6, Offset: 0xa75
// Size: 0x37
function private function_c068712dd5be0c27( params )
{
    if ( self.var_8c6019c19fcca74c )
    {
        params.struct.var_22adeafdea660e78 = self.var_8c6019c19fcca74c;
    }
}

// Namespace wildcard_high_roller
// Params 1, eflags: 0x4
// Checksum 0xea1eff4, Offset: 0xab4
// Size: 0x86
function private function_5afc7eb048a89ecf( params )
{
    if ( isdefined( self.perks[ "wildcard_high_roller" ] ) )
    {
        var_71fa156e711338fc = level.gametypebundle.var_8c6019c19fcca74c ?? self.var_8c6019c19fcca74c;
        
        if ( !isdefined( var_71fa156e711338fc ) )
        {
            var_71fa156e711338fc = params.loadoutstruct.var_22adeafdea660e78 ?? "radar_ping";
        }
        
        params.namedstreaks[ #"high_roller" ] = var_71fa156e711338fc;
    }
}

// Namespace wildcard_high_roller
// Params 1, eflags: 0x4
// Checksum 0x2f260631, Offset: 0xb42
// Size: 0xaa
function private function_ba6f75ad0a9a15d8( params )
{
    playerstreakdata = self [[ level.sharedfuncs[ #"killstreak" ][ #"hash_37d5de4ac88dde74" ] ]]();
    var_ba30568bb8b61a7c = playerstreakdata.streaks[ #"high_roller" ];
    
    if ( isdefined( self.perks[ "wildcard_high_roller" ] ) )
    {
        if ( !isdefined( var_ba30568bb8b61a7c ) )
        {
            params.needsupdating = 1;
        }
        
        return;
    }
    
    if ( isdefined( var_ba30568bb8b61a7c ) )
    {
        if ( ( var_ba30568bb8b61a7c.quantity ?? 0 ) == 0 )
        {
            params.needsupdating = 1;
        }
    }
}

// Namespace wildcard_high_roller
// Params 1, eflags: 0x4
// Checksum 0xdce77d9f, Offset: 0xbf4
// Size: 0x13
function private function_43925749fce6925d( params )
{
    function_64930ca452e5c97d();
}

// Namespace wildcard_high_roller
// Params 1, eflags: 0x4
// Checksum 0xb5f905c2, Offset: 0xc0f
// Size: 0x94
function private function_aed9781cf81dd1c2( params )
{
    playerstreakdata = self [[ level.sharedfuncs[ #"killstreak" ][ #"hash_37d5de4ac88dde74" ] ]]();
    
    if ( !playerstreakdata )
    {
        return;
    }
    
    streakinfo = playerstreakdata.streaks[ #"high_roller" ];
    
    if ( !streakinfo )
    {
        return;
    }
    
    if ( isdefined( self.perks[ "wildcard_high_roller" ] ) )
    {
        streakinfo.earningblocked = undefined;
        return;
    }
    
    streakinfo.earningblocked = 1;
}

// Namespace wildcard_high_roller
// Params 1, eflags: 0x4
// Checksum 0x1cb33a3e, Offset: 0xcab
// Size: 0x100
function private function_c35bf7a73f65a349( params )
{
    streakinfo = params.streakinfo;
    owner = streakinfo.owner;
    
    if ( streakinfo.var_9384480e6997afd7 === #"high_roller" && isplayer( owner ) )
    {
        var_67784841ab96e816 = isdefined( owner.perks[ "wildcard_high_roller" ] );
        
        if ( !var_67784841ab96e816 )
        {
            owner function_64930ca452e5c97d();
            playerstreakdata = owner [[ level.sharedfuncs[ #"killstreak" ][ #"hash_37d5de4ac88dde74" ] ]]();
            
            if ( isdefined( playerstreakdata.streaks[ #"high_roller" ] ) )
            {
                playerstreakdata.streaks[ #"high_roller" ] = undefined;
            }
            
            owner [[ level.sharedfuncs[ #"killstreak" ][ #"hash_3163ed1117273710" ] ]]();
        }
    }
}

// Namespace wildcard_high_roller
// Params 0, eflags: 0x4
// Checksum 0x330fb67a, Offset: 0xdb3
// Size: 0x39
function private function_64930ca452e5c97d()
{
    slotomnvar = level.streakglobals.slotomnvars[ #"high_roller" ];
    
    if ( slotomnvar )
    {
        self setclientomnvar( slotomnvar, 0 );
    }
}

// Namespace wildcard_high_roller
// Params 1, eflags: 0x4
// Checksum 0x778b2180, Offset: 0xdf4
// Size: 0x236
function private function_78f358bd76c9853d( params )
{
    var_7237854e3be197ca = self.var_5f2121327659e90e;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    streakbundles = level.streakglobals.streakbundles;
    
    if ( !streakbundles.size )
    {
        return "none";
    }
    
    var_8c260c92a8bd05ea = level.sharedfuncs[ #"loot" ][ #"hash_ca4103c28ac67fef" ];
    var_b213b3316abf14c3 = "none";
    var_81d0e14e62e212db = 0;
    var_8461aa9f1cd909da = level.gamemodebundle.streakearn == #"score";
    var_8690962f9c477a03 = level.onlinegame && params.var_4d362babbfd5b4b1;
    
    foreach ( streakref, streakbundle in streakbundles )
    {
        if ( !streakbundle.var_883566fc1e9d2da3 )
        {
            continue;
        }
        
        if ( streakref == params.struct.loadoutkillstreak1 )
        {
            continue;
        }
        
        if ( streakref == params.struct.loadoutkillstreak2 )
        {
            continue;
        }
        
        if ( streakref == params.struct.loadoutkillstreak3 )
        {
            continue;
        }
        
        streakcost = var_8461aa9f1cd909da ? streakbundle.scorecost : streakbundle.kills;
        
        if ( streakcost > var_81d0e14e62e212db )
        {
            if ( var_8690962f9c477a03 )
            {
                var_b066a5a142a81f53 = [[ var_8c260c92a8bd05ea ]]( streakbundle.lootid );
                
                if ( var_b066a5a142a81f53 == streakref )
                {
                    var_b213b3316abf14c3 = streakref;
                    var_81d0e14e62e212db = streakcost;
                }
                
                continue;
            }
            
            var_b213b3316abf14c3 = streakref;
            var_81d0e14e62e212db = streakcost;
        }
    }
    
    if ( var_b213b3316abf14c3 == "none" )
    {
        return "none";
    }
    
    self.var_5f2121327659e90e = var_b213b3316abf14c3;
    return var_b213b3316abf14c3;
}

/#

    // Namespace wildcard_high_roller
    // Params 0, eflags: 0x4
    // Checksum 0xea2981f, Offset: 0x1033
    // Size: 0x2e, Type: dev
    function private debuginit()
    {
        devgui::function_9082edeb5db93280( "<dev string:xbb>" );
        devgui::add_devgui_func( "<dev string:xd1>", "<dev string:xe2>", &function_23b7426013768636 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace wildcard_high_roller
    // Params 0, eflags: 0x4
    // Checksum 0x12b02283, Offset: 0x1069
    // Size: 0x7b, Type: dev
    function private function_23b7426013768636()
    {
        player = getentbynum( 0 );
        
        if ( isdefined( player ) )
        {
            player [[ level.sharedfuncs[ #"perk" ][ #"giveperk" ] ]]( "<dev string:xe7>" );
            player [[ level.sharedfuncs[ #"killstreak" ][ #"awardkillstreak" ] ]]( "<dev string:xfc>", "<dev string:x107>", undefined, undefined, undefined, #"high_roller" );
        }
    }

#/
