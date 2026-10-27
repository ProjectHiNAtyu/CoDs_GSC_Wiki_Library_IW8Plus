// script_59143e62a1ecdc59  (hash_59143e62a1ecdc59.gscc) (size: 12946 Bytes / 0x3292 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xaf058d01 (2936376577)
// size ...... 12946 (0x3292)
// includes .. 11  (offset: 0x30ba)
// strings ... 19  (offset: 0x3112)
// dev strs .. 11  (offset: 0x320e)
// exports ... 45  (offset: 0x1dce)
// cseg ...... 0x198 + 0x1c36 (0x1dce)
// imports ... 97  (offset: 0x24d6)
// animtree1 . 0   (offset: 0x3292)
// animtree2 . 0   (offset: 0x3292)
#using scripts\common\ai\ai_utility;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\ammomods\ammo_mod;
#using scripts\mp\common\utility\loot;
#using scripts\mp\equipment;
#using scripts\mp\supers;

#namespace namespace_64a89dd78801462c;

// Namespace namespace_64a89dd78801462c
// Params 0
// Checksum 0xeb3e8a1f, Offset: 0x1b6
// Size: 0x1f8
function init()
{
    level callback::add( #"skill_removed", &function_6a1dff7522b181b7 );
    utility::registersharedfunc( #"skills", #"hash_1f0a435d01dc412b", &function_4ab02db1ecff548f );
    utility::registersharedfunc( #"skills", #"hash_7839ce6cac4cb514", &function_45a49fa10ba1c5c0 );
    utility::registersharedfunc( #"skills", #"hash_785df5a84d4d0b95", &function_bf36e8bef03c3f29 );
    utility::registersharedfunc( #"skills", #"hash_d1b0a8ba618e0ca8", &function_fd2abc8cbad7a194 );
    utility::registersharedfunc( #"skills", #"getsuperupgrades", &function_2ff5f9d82052295f );
    utility::registersharedfunc( #"skills", #"hash_f6f9d82b37317d8c", &function_74adff8703084a80 );
    utility::registersharedfunc( #"skills", #"hash_681432bc15a47888", &function_6da65aab0b45cfec );
    utility::registersharedfunc( #"skills", #"hash_a6980b8a3e3542b2", &function_f1797517b1c59066 );
    utility::registersharedfunc( #"skills", #"getsuperpointsneeded", &function_cf6f2c63f66e5130 );
    utility::registersharedfunc( #"skills", #"hash_cff4503d5032d9d2", &function_cd501488b483301e );
    utility::registersharedfunc( #"skills", #"hash_2ae7f8231121f66c", &function_eb8063e8d65960a8 );
    utility::registersharedfunc( #"skills", #"hash_28be1e74b50af850", &function_6815cff7e2c84a4 );
    utility::registersharedfunc( #"skills", #"hash_b5a7f9c7f63c374a", &function_219fb835c057409e );
    utility::registersharedfunc( #"skills", #"hash_2fd3deb81c953c81", &function_5fdf96bb61d3685d );
    utility::registersharedfunc( #"skills", #"apply_invulnerability", &function_c002df3eb0e0b80f );
    utility::registersharedfunc( #"skills", #"hash_79530ea7319d30d6", &function_e248dde09eb60e6a );
}

// Namespace namespace_64a89dd78801462c
// Params 1, eflags: 0x4
// Checksum 0x9cbc36a3, Offset: 0x3b6
// Size: 0x5a
function private function_6a1dff7522b181b7( params )
{
    if ( !params.player || !params.skillref || !params.skilllevel )
    {
        return;
    }
    
    waittillframeend();
    params.player function_ddd2baaccd197e94( params.skillref );
}

// Namespace namespace_64a89dd78801462c
// Params 2, eflags: 0x4
// Checksum 0xd6c5552b, Offset: 0x418
// Size: 0x7e
function private function_fd4ed25107f47900( skillref, skilllevel )
{
    if ( !skillref )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    if ( !isdefined( skilllevel ) )
    {
        assertmsg( "<dev string:x52>" );
        return;
    }
    
    skillbundle = level.skillbundles[ skillref ][ skilllevel ];
    
    if ( !skillbundle )
    {
        assertmsg( "<dev string:x82>" + getxhashsourcename( skillref ) );
        return;
    }
    
    return skillbundle;
}

// Namespace namespace_64a89dd78801462c
// Params 2, eflags: 0x4
// Checksum 0xaf4e8718, Offset: 0x49f
// Size: 0x80
function private function_4ab02db1ecff548f( skillref, skilllevel )
{
    skillbundle = function_fd4ed25107f47900( skillref, skilllevel );
    
    if ( !skillbundle )
    {
        assertmsg( "<dev string:xb6>" + getxhashsourcename( skillref ) );
        return 0;
    }
    
    lootid = skillbundle.lootid;
    
    if ( !isdefined( lootid ) )
    {
        assertmsg( "<dev string:xea>" + getxhashsourcename( skillref ) );
        return 0;
    }
    
    return lootid;
}

// Namespace namespace_64a89dd78801462c
// Params 2, eflags: 0x4
// Checksum 0xec61a874, Offset: 0x528
// Size: 0x82
function private function_45a49fa10ba1c5c0( skillref, skilllevel )
{
    skillbundle = function_fd4ed25107f47900( skillref, skilllevel );
    
    if ( !skillbundle )
    {
        assertmsg( "<dev string:x11a>" + getxhashsourcename( skillref ) );
        return;
    }
    
    skillcategory = skillbundle.skillcategory;
    
    if ( !isxhash( skillbundle.skillcategory ) )
    {
        skillcategory = tolower( skillcategory );
        skillcategory = getxhash( skillcategory );
    }
    
    return skillcategory;
}

// Namespace namespace_64a89dd78801462c
// Params 2, eflags: 0x4
// Checksum 0xd6deda6f, Offset: 0x5b3
// Size: 0x59
function private function_bf36e8bef03c3f29( skillref, skilllevel )
{
    skillbundle = function_fd4ed25107f47900( skillref, skilllevel );
    
    if ( !skillbundle )
    {
        assertmsg( "<dev string:x150>" + getxhashsourcename( skillref ) );
        return;
    }
    
    return loot::function_c09d31266119497d( skillbundle.rarity );
}

// Namespace namespace_64a89dd78801462c
// Params 1, eflags: 0x4
// Checksum 0x54fb223d, Offset: 0x615
// Size: 0x21
function private function_fd2abc8cbad7a194( weapon )
{
    return level.var_7b319720bc04b783[ weapon.basenamehash ];
}

// Namespace namespace_64a89dd78801462c
// Params 0, eflags: 0x4
// Checksum 0xae48bd2a, Offset: 0x63f
// Size: 0x29
function private function_2ff5f9d82052295f()
{
    superref = supers_mp::getcurrentsuperref( #"default" );
    return level.var_df3fc2ed023c3c0d[ superref ];
}

// Namespace namespace_64a89dd78801462c
// Params 0, eflags: 0x4
// Checksum 0x4f5a7f12, Offset: 0x671
// Size: 0x29
function private function_74adff8703084a80()
{
    superref = supers_mp::getcurrentsuperref( #"tactical" );
    return level.var_df3fc2ed023c3c0d[ superref ];
}

// Namespace namespace_64a89dd78801462c
// Params 0, eflags: 0x4
// Checksum 0x582da27a, Offset: 0x6a3
// Size: 0x45
function private function_6da65aab0b45cfec()
{
    var_39c738dac988d353 = supers_mp::getcurrentsuperref( #"default" ) ?? [];
    var_ca2d8b6cdb364f = supers_mp::getcurrentsuperref( #"tactical" ) ?? [];
    return arraycombine( var_39c738dac988d353, var_ca2d8b6cdb364f );
}

// Namespace namespace_64a89dd78801462c
// Params 1, eflags: 0x4
// Checksum 0xcfdb53e3, Offset: 0x6f1
// Size: 0x17f
function private function_c002df3eb0e0b80f( invulnerability_data )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    assert( invulnerability_data.duration > 0, "<dev string:x189>" );
    val::set( invulnerability_data.id, "damage", 0 );
    val::set( invulnerability_data.id, "damage_protection_omnvar", "ui_squadmate_show_damage_protection_" + self.sessionuimemberindex );
    
    if ( invulnerability_data.scriptable_part && invulnerability_data.scriptable_state_on )
    {
        self setscriptablepartstate( invulnerability_data.scriptable_part, invulnerability_data.scriptable_state_on, 0 );
    }
    
    if ( invulnerability_data.pbg_post_fx )
    {
        val::set( invulnerability_data.id, "damage_protection_pgb_post_fx", invulnerability_data.pbg_post_fx );
    }
    
    wait invulnerability_data.duration;
    val::reset( invulnerability_data.id, "damage" );
    val::reset( invulnerability_data.id, "damage_protection_omnvar" );
    
    if ( invulnerability_data.scriptable_part && invulnerability_data.scriptable_state_off )
    {
        self setscriptablepartstate( invulnerability_data.scriptable_part, invulnerability_data.scriptable_state_off, 0 );
    }
    
    if ( invulnerability_data.pbg_post_fx )
    {
        val::reset( invulnerability_data.id, "damage_protection_pgb_post_fx" );
    }
}

// Namespace namespace_64a89dd78801462c
// Params 1, eflags: 0x4
// Checksum 0xa42ba0d0, Offset: 0x878
// Size: 0x47c
function private function_e248dde09eb60e6a( data )
{
    player = data.player;
    
    if ( data.cooldown && data.skill_name && function_bfbb0fac6a373179( data ) )
    {
        return;
    }
    
    if ( !data.var_b121bc46582c97be || !isplayer( self ) )
    {
        ai_tier = ai_utility::get_power_tier();
        
        if ( !ai_tier || !arraycontains( data.var_3b55b60765b98d29, ai_tier ) )
        {
            return;
        }
    }
    
    if ( randomfloat( 1 ) > data.probability )
    {
        return;
    }
    
    var_5e94b7b011663cfd = data.idamage > self.health;
    weapon = data.sweapon ?? data.objweapon;
    
    if ( !weapon )
    {
        weapon = player getcurrentweapon();
    }
    
    var_41c8d742f46ed3fb = player ammo_mod::get_ammo_mod_name( weapon );
    var_58e7e0121c794d5c = getarraykeys( level.ammo_mods );
    var_58e7e0121c794d5c = arrayremove( var_58e7e0121c794d5c, "none" );
    
    if ( data.var_563eb10bd0071b7d && var_41c8d742f46ed3fb && var_58e7e0121c794d5c.size > 1 )
    {
        var_58e7e0121c794d5c = arrayremove( var_58e7e0121c794d5c, var_41c8d742f46ed3fb );
    }
    
    if ( data.weights_table.size > 0 )
    {
        struct = utility::random_weighted_struct( data.weights_table );
        var_35a7e90f80366839 = struct.ammomod;
    }
    
    if ( !var_35a7e90f80366839 )
    {
        var_35a7e90f80366839 = utility::array_random( var_58e7e0121c794d5c );
    }
    
    player.var_88cc283ee5d29498 = 1;
    var_b1ece7ee0e8bf412 = weapon::buildweapon( level.laststandweapon );
    player ammo_mod::add_ammo_mod_to_weapon( var_b1ece7ee0e8bf412, var_35a7e90f80366839, 0 );
    
    if ( ai_tier == 3 )
    {
        var_1a0a60539bea873f = [ "fw_ammomod":#"fw_big_game", "deadwire":#"deadwire_big_game", "napalmburst":#"napalmburst_big_game", "shadowvortex":#"shadowvortex_big_game", "cryofreeze":#"cryofreeze_big_game", "brainrot":#"brainrot_big_game", "shatterblast":#"shatterblast_big_game", "lightray":#"lightray_big_game" ];
        var_b1487eb1ce65e991 = var_1a0a60539bea873f[ var_35a7e90f80366839 ];
        ammo_mod_xhash = getxhash( var_35a7e90f80366839 );
        var_40c64f99a08dd9de = player.zombie_augments[ ammo_mod_xhash ];
        var_d2c1edec5a9f0994 = level.zombie_augments[ var_b1487eb1ce65e991 ].var_9f9a3afac6467400;
        player.zombie_augments[ ammo_mod_xhash ] = { #majorname:var_b1487eb1ce65e991 };
        level.zombie_augments[ var_b1487eb1ce65e991 ].var_9f9a3afac6467400 = 1;
    }
    
    var_ad5d0f2a4afb15ff = level.perkbundles[ "specialty_elemental_pop" ].var_9de0bd5324529537;
    successfully_triggered = ammo_mod::ammo_mod_response( var_5e94b7b011663cfd, data.inflictor, player, data.idamage, data.idflags, "MOD_PISTOL_BULLET", var_b1ece7ee0e8bf412, data.vpoint, data.vdir, data.shitloc, data.timeoffset, data.modelindex, data.partname, data.objweapon, var_ad5d0f2a4afb15ff, weapon, data.var_b8f3721c1cf18fb7, data.var_b121bc46582c97be );
    
    if ( data.cooldown && data.skill_name && successfully_triggered )
    {
        if ( !isdefined( player.var_76e0ffe10856577c ) )
        {
            player.var_76e0ffe10856577c = [];
        }
        
        player.var_76e0ffe10856577c[ data.skill_name ] = gettime();
    }
    
    if ( var_b1487eb1ce65e991 )
    {
        player.zombie_augments[ ammo_mod_xhash ] = var_40c64f99a08dd9de;
        level.zombie_augments[ var_b1487eb1ce65e991 ].var_9f9a3afac6467400 = var_d2c1edec5a9f0994;
    }
    
    player ammo_mod::function_e6267ae500506234( var_b1ece7ee0e8bf412, 0 );
    
    if ( var_41c8d742f46ed3fb != "" && var_41c8d742f46ed3fb != "none" )
    {
        if ( !player ammo_mod::function_ba9b2ecd18bdbdd8( weapon, var_41c8d742f46ed3fb ) )
        {
            player ammo_mod::add_ammo_mod_to_weapon( weapon, var_41c8d742f46ed3fb );
        }
    }
    
    return var_35a7e90f80366839;
}

// Namespace namespace_64a89dd78801462c
// Params 1, eflags: 0x4
// Checksum 0x67a3a205, Offset: 0xcfd
// Size: 0x58, Type: bool
function private function_bfbb0fac6a373179( data )
{
    last_timestamp = data.player.var_76e0ffe10856577c[ data.skill_name ];
    
    if ( !last_timestamp )
    {
        return false;
    }
    
    return gettime() - last_timestamp < data.cooldown * 1000;
}

// Namespace namespace_64a89dd78801462c
// Params 1, eflags: 0x4
// Checksum 0x715666f6, Offset: 0xd5e
// Size: 0x27
function private function_ddd2baaccd197e94( skill_name )
{
    if ( self.var_76e0ffe10856577c[ skill_name ] )
    {
        self.var_76e0ffe10856577c[ skill_name ] = undefined;
    }
}

// Namespace namespace_64a89dd78801462c
// Params 3
// Checksum 0x2b5b1cda, Offset: 0xd8d
// Size: 0x71
function function_6a7d11fd91f732df( slot, var_1078d7a3549450d5, var_27be419a6e61f096 )
{
    if ( !var_1078d7a3549450d5 || !var_27be419a6e61f096 || var_1078d7a3549450d5 == var_27be419a6e61f096 )
    {
        return;
    }
    
    if ( supers_mp::issuperinuse( slot ) )
    {
        return;
    }
    
    currentpoints = supers_mp::getcurrentsuperpoints( slot );
    newpointtotal = currentpoints / var_1078d7a3549450d5 * var_27be419a6e61f096;
    supers_mp::setsuperbasepoints( newpointtotal, undefined, slot );
}

// Namespace namespace_64a89dd78801462c
// Params 2
// Checksum 0x27eca533, Offset: 0xe06
// Size: 0x51
function function_4b8f034991c3fe5d( skillref, skilllevel )
{
    function_9380fc57c2a829d( skillref, skilllevel );
    function_6fad2a8b0930a12c( skillref, skilllevel );
    function_e1389f7630ec7788( skillref, skilllevel );
    function_36b8e52f94f491a1( skillref, skilllevel );
    function_859141ea84ce4e6a( skillref, skilllevel );
    function_6a019a7eeb535781( skillref, skilllevel );
}

// Namespace namespace_64a89dd78801462c
// Params 1
// Checksum 0xbdec884d, Offset: 0xe5f
// Size: 0xf5
function function_c399dada8a4f94b2( skillref )
{
    if ( self.skilldata )
    {
        foreach ( fieldxhash in getarraykeys( self.skilldata ) )
        {
            self.skilldata[ fieldxhash ][ skillref ] = undefined;
            
            if ( self.skilldata[ fieldxhash ].size == 0 )
            {
                self.skilldata[ fieldxhash ] = undefined;
            }
        }
        
        function_c35a3b1295699754( skillref );
    }
    
    if ( self.skilldata.size == 0 )
    {
        self.skilldata = undefined;
    }
    
    utility::delaythreadendon( level.framedurationseconds, "disconnect", &function_bf5ff675b6c367d3, 0 );
}

// Namespace namespace_64a89dd78801462c
// Params 3, eflags: 0x4
// Checksum 0xfde5cf60, Offset: 0xf5c
// Size: 0x9d
function private function_27fd0af9fd93c540( fieldxhash, skillref, value )
{
    assert( fieldxhash, "<dev string:x1b0>" );
    assert( skillref, "<dev string:x1cc>" );
    prevvalue = function_1210c3276b4ef680( fieldxhash, skillref );
    
    if ( value != prevvalue )
    {
        if ( !isdefined( self.skilldata ) )
        {
            self.skilldata = [];
        }
        
        if ( !isdefined( self.skilldata[ fieldxhash ] ) )
        {
            self.skilldata[ fieldxhash ] = [];
        }
        
        self.skilldata[ fieldxhash ][ skillref ] = value;
    }
    
    return prevvalue;
}

// Namespace namespace_64a89dd78801462c
// Params 1, eflags: 0x4
// Checksum 0x4af87bb6, Offset: 0x1002
// Size: 0x28
function private function_65556bd459a1a91c( fieldxhash )
{
    return self.skilldata ? self.skilldata[ fieldxhash ] : undefined;
}

// Namespace namespace_64a89dd78801462c
// Params 2, eflags: 0x4
// Checksum 0x987113e8, Offset: 0x1033
// Size: 0x40
function private function_1210c3276b4ef680( fieldxhash, skillref )
{
    if ( self.skilldata && self.skilldata[ fieldxhash ] )
    {
        return self.skilldata[ fieldxhash ][ skillref ];
    }
}

// Namespace namespace_64a89dd78801462c
// Params 2, eflags: 0x4
// Checksum 0x7745f374, Offset: 0x107c
// Size: 0x4c
function private function_9380fc57c2a829d( skillref, skilllevel )
{
    skillbundle = level.skillbundles[ skillref ][ skilllevel ];
    function_27fd0af9fd93c540( #"hash_ffd1a1ccd059fcd4", skillref, skillbundle.var_8a7e931ef8403306 );
}

// Namespace namespace_64a89dd78801462c
// Params 2, eflags: 0x4
// Checksum 0x122c743c, Offset: 0x10d0
// Size: 0x4c
function private function_859141ea84ce4e6a( skillref, skilllevel )
{
    skillbundle = level.skillbundles[ skillref ][ skilllevel ];
    function_27fd0af9fd93c540( #"hash_6d51a40fc283e39e", skillref, skillbundle.var_fd5d1a68b3e94d53 );
}

// Namespace namespace_64a89dd78801462c
// Params 2, eflags: 0x4
// Checksum 0xcbd3c75f, Offset: 0x1124
// Size: 0x4c
function private function_6fad2a8b0930a12c( skillref, skilllevel )
{
    skillbundle = level.skillbundles[ skillref ][ skilllevel ];
    function_27fd0af9fd93c540( #"clip_ammo", skillref, skillbundle.var_b5897eb9041c5c6d );
}

// Namespace namespace_64a89dd78801462c
// Params 2, eflags: 0x4
// Checksum 0x520ba141, Offset: 0x1178
// Size: 0x4c
function private function_e1389f7630ec7788( skillref, skilllevel )
{
    skillbundle = level.skillbundles[ skillref ][ skilllevel ];
    function_27fd0af9fd93c540( #"hash_fe095f357d0f1c28", skillref, skillbundle.var_d7b45ec30f3ee649 );
}

// Namespace namespace_64a89dd78801462c
// Params 2, eflags: 0x4
// Checksum 0xc6d10005, Offset: 0x11cc
// Size: 0x5b
function private function_36b8e52f94f491a1( skillref, skilllevel )
{
    skillbundle = level.skillbundles[ skillref ][ skilllevel ];
    function_601b362c69da0cbf( skillref, skillbundle.var_e42104ee9ff4294, 1 );
    function_770ff107d609a9( skillref, skillbundle.var_384debb260d2cd06, 1 );
}

// Namespace namespace_64a89dd78801462c
// Params 2, eflags: 0x4
// Checksum 0x68faf912, Offset: 0x122f
// Size: 0x11b
function private function_6a019a7eeb535781( skillref, skilllevel )
{
    skillbundle = level.skillbundles[ skillref ][ skilllevel ];
    ai_damage_mult = skillbundle.var_2f6dcf180e151dd8;
    player_damage_mult = skillbundle.var_e9c95aa8826a1df;
    
    if ( ai_damage_mult || player_damage_mult )
    {
        function_27fd0af9fd93c540( #"ai_damage_mult", skillref, ai_damage_mult ?? 1 );
        function_27fd0af9fd93c540( #"player_damage_mult", skillref, player_damage_mult ?? 1 );
        function_27fd0af9fd93c540( #"super_ref", skillref, skillbundle.abilityref );
        
        if ( !self.var_38986895a5efbd15 )
        {
            zombie_utils::function_dfae6a5bd222c586( &function_43ab268c730b0234 );
            agent_utils::function_bc89b9076dd93902( &function_43ab268c730b0234 );
            assert( !callback::exists( #"hash_2346898712859996", &skills_onplayerdamaged ) );
            callback::add( #"hash_2346898712859996", &skills_onplayerdamaged );
            self.var_38986895a5efbd15 = 1;
        }
    }
}

// Namespace namespace_64a89dd78801462c
// Params 1, eflags: 0x4
// Checksum 0xdefe2de9, Offset: 0x1352
// Size: 0xdc
function private function_c35a3b1295699754( skillref )
{
    assert( self.skilldata, "<dev string:x1e6>" );
    
    if ( self.var_38986895a5efbd15 )
    {
        ai_damage_data = self.skilldata[ #"ai_damage_mult" ];
        player_damage_data = self.skilldata[ #"player_damage_mult" ];
        
        if ( ( !ai_damage_data || ai_damage_data.size == 0 ) && ( !player_damage_data || player_damage_data.size == 0 ) )
        {
            zombie_utils::function_10c0c35c21e3ed9d( &function_43ab268c730b0234 );
            agent_utils::function_def5273cfe3c9109( &function_43ab268c730b0234 );
            assert( callback::exists( #"hash_2346898712859996", &skills_onplayerdamaged ) );
            callback::remove( #"hash_2346898712859996", &skills_onplayerdamaged );
            self.var_38986895a5efbd15 = undefined;
        }
    }
}

// Namespace namespace_64a89dd78801462c
// Params 1, eflags: 0x4
// Checksum 0xf34bcf86, Offset: 0x1436
// Size: 0x63
function private function_43ab268c730b0234( params )
{
    attacker = params.eattacker;
    
    if ( !attacker || !attacker.skilldata )
    {
        return params.idamage;
    }
    
    return skills_onentitydamaged( params, attacker, attacker.skilldata[ #"ai_damage_mult" ] );
}

// Namespace namespace_64a89dd78801462c
// Params 1, eflags: 0x4
// Checksum 0x39183465, Offset: 0x14a2
// Size: 0x6f
function private skills_onplayerdamaged( params )
{
    attacker = params.eattacker;
    
    if ( !attacker || !attacker.skilldata )
    {
        return;
    }
    
    params.idamage = params.victim skills_onentitydamaged( params, attacker, attacker.skilldata[ #"player_damage_mult" ] );
}

// Namespace namespace_64a89dd78801462c
// Params 3, eflags: 0x4
// Checksum 0x4bc6ff15, Offset: 0x1519
// Size: 0x174
function private skills_onentitydamaged( params, attacker, var_b2eea1b9a32706f7 )
{
    if ( !var_b2eea1b9a32706f7 )
    {
        return params.idamage;
    }
    
    weapon = params.sweapon ?? params.objweapon;
    
    if ( !weapon )
    {
        return params.idamage;
    }
    
    super_ref = supers_mp::getsuperrefforsuperweapon( weapon );
    
    if ( !super_ref )
    {
        return params.idamage;
    }
    
    super_ref_data = attacker.skilldata[ #"super_ref" ];
    
    if ( !super_ref_data )
    {
        return params.idamage;
    }
    
    var_e89946f072a20d65 = getxhash( super_ref );
    
    foreach ( skillref in getarraykeys( var_b2eea1b9a32706f7 ) )
    {
        skill_super_ref = super_ref_data[ skillref ];
        
        if ( var_e89946f072a20d65 == skill_super_ref )
        {
            damage_mult = var_b2eea1b9a32706f7[ skillref ];
            return ( params.idamage * damage_mult );
        }
    }
    
    return params.idamage;
}

// Namespace namespace_64a89dd78801462c
// Params 2, eflags: 0x4
// Checksum 0x400fc4d7, Offset: 0x1696
// Size: 0xe8
function private function_f1797517b1c59066( superref, points )
{
    var_82a7497bcb70d506 = function_65556bd459a1a91c( #"hash_ffd1a1ccd059fcd4" );
    
    if ( !var_82a7497bcb70d506 )
    {
        return points;
    }
    
    var_d77b0c0449252ab6 = isxhash( superref ) ? superref : getxhash( superref );
    
    foreach ( skillref, var_1110daa6b567a1fb in var_82a7497bcb70d506 )
    {
        if ( var_1110daa6b567a1fb > 0 )
        {
            var_5f7758fa25fcb3a3 = skills_getsuperref( skillref );
            
            if ( var_5f7758fa25fcb3a3 == var_d77b0c0449252ab6 )
            {
                points += points * var_1110daa6b567a1fb;
            }
        }
    }
    
    return points;
}

// Namespace namespace_64a89dd78801462c
// Params 1, eflags: 0x4
// Checksum 0x7cb2b6e, Offset: 0x1787
// Size: 0x1d
function private function_cf6f2c63f66e5130( superref )
{
    return function_a2865af38597ad8b( superref, #"hash_6d51a40fc283e39e" );
}

// Namespace namespace_64a89dd78801462c
// Params 1, eflags: 0x4
// Checksum 0x27e08deb, Offset: 0x17ad
// Size: 0x1d
function private function_cd501488b483301e( superref )
{
    return function_a2865af38597ad8b( superref, #"clip_ammo" );
}

// Namespace namespace_64a89dd78801462c
// Params 1, eflags: 0x4
// Checksum 0x3eecaac2, Offset: 0x17d3
// Size: 0x1d
function private function_eb8063e8d65960a8( superref )
{
    return function_a2865af38597ad8b( superref, #"hash_fe095f357d0f1c28" );
}

// Namespace namespace_64a89dd78801462c
// Params 2, eflags: 0x4
// Checksum 0x96064741, Offset: 0x17f9
// Size: 0xd8
function private function_a2865af38597ad8b( superref, field )
{
    if ( !superref )
    {
        return;
    }
    
    var_77e54b067da365cf = function_65556bd459a1a91c( field );
    
    if ( !var_77e54b067da365cf )
    {
        return;
    }
    
    var_d77b0c0449252ab6 = isxhash( superref ) ? superref : getxhash( superref );
    
    foreach ( skillref, value in var_77e54b067da365cf )
    {
        var_5f7758fa25fcb3a3 = skills_getsuperref( skillref );
        
        if ( var_5f7758fa25fcb3a3 == var_d77b0c0449252ab6 )
        {
            return value;
        }
    }
}

// Namespace namespace_64a89dd78801462c
// Params 6, eflags: 0x4
// Checksum 0x619e2361, Offset: 0x18d9
// Size: 0x68
function private function_b6c00c93ca4ce13a( fieldxhash, skillref, slot, value, var_2f3a5b6401c9cc5c, var_27bb3647b99f3704 )
{
    prevvalue = function_27fd0af9fd93c540( fieldxhash, skillref, value );
    
    if ( ( value ?? 0 ) != ( prevvalue ?? 0 ) )
    {
        function_bf5ff675b6c367d3( var_2f3a5b6401c9cc5c );
    }
}

// Namespace namespace_64a89dd78801462c
// Params 4, eflags: 0x4
// Checksum 0x57522438, Offset: 0x1949
// Size: 0x62
function private function_5fdf96bb61d3685d( skillref, bonusmaxammo, slot, reloadslot )
{
    field = slot == "primary" ? #"hash_9bb70f7f991a48a" : #"hash_7d73bf9bd1c973ea";
    function_b6c00c93ca4ce13a( field, skillref, slot, bonusmaxammo, reloadslot, 0 );
}

// Namespace namespace_64a89dd78801462c
// Params 3, eflags: 0x4
// Checksum 0x9ed7b219, Offset: 0x19b3
// Size: 0x3a
function private function_601b362c69da0cbf( skillref, var_ae23c0ade44cbe7d, rechargesuper )
{
    function_b6c00c93ca4ce13a( #"hash_ae78d3e4be74f738", skillref, "secondary", var_ae23c0ade44cbe7d, rechargesuper, 1 );
}

// Namespace namespace_64a89dd78801462c
// Params 3, eflags: 0x4
// Checksum 0xe54643a5, Offset: 0x19f5
// Size: 0x3a
function private function_770ff107d609a9( skillref, var_ff5dfcb3c876202a, rechargesuper )
{
    function_b6c00c93ca4ce13a( #"hash_64e81ec7f6efd538", skillref, "secondary", var_ff5dfcb3c876202a, rechargesuper, 1 );
}

// Namespace namespace_64a89dd78801462c
// Params 1, eflags: 0x4
// Checksum 0xde431243, Offset: 0x1a37
// Size: 0x11a
function private function_bf5ff675b6c367d3( reloadslot )
{
    foreach ( equipref in equipment_mp::function_46b102c55f314986() )
    {
        maxammo = equipment_mp::getequipmentmaxammo( equipref );
        currentammo = equipment_mp::getequipmentammo( equipref );
        newammo = reloadslot || currentammo > maxammo ? maxammo : currentammo;
        equipment_mp::setequipmentammo( equipref, newammo, maxammo );
        tableinfo = equipment_mp::getequipmenttableinfo( equipref );
        
        if ( tableinfo.bundle.issuper )
        {
            if ( newammo >= maxammo )
            {
                supers_mp::function_235acb90dc5ccdbe( #"tactical" );
                continue;
            }
            
            supers_mp::superpointschanged( #"tactical" );
        }
    }
}

// Namespace namespace_64a89dd78801462c
// Params 1, eflags: 0x4
// Checksum 0xa20b8894, Offset: 0x1b59
// Size: 0x18a
function private function_6815cff7e2c84a4( equipmentref )
{
    bonusmaxammo = 0;
    superref = function_e51b0662d0dd8f13( equipmentref );
    
    if ( superref )
    {
        skilldata = function_65556bd459a1a91c( #"hash_ae78d3e4be74f738" );
        
        if ( skilldata )
        {
            foreach ( skillref, bonus in skilldata )
            {
                superref = skills_getsuperref( skillref );
                
                if ( superref == superref )
                {
                    bonusmaxammo += bonus;
                }
            }
        }
    }
    else
    {
        slot = equipment_mp::findequipmentslot( equipmentref );
        
        if ( slot )
        {
            datafield = slot == "primary" ? #"hash_9bb70f7f991a48a" : #"hash_7d73bf9bd1c973ea";
            skilldata = function_65556bd459a1a91c( datafield );
            
            if ( skilldata )
            {
                foreach ( bonus in skilldata )
                {
                    bonusmaxammo += bonus ?? 0;
                }
            }
        }
    }
    
    return bonusmaxammo;
}

// Namespace namespace_64a89dd78801462c
// Params 1, eflags: 0x4
// Checksum 0x833b954, Offset: 0x1cec
// Size: 0x4f
function private function_219fb835c057409e( equipmentref )
{
    superref = function_e51b0662d0dd8f13( equipmentref );
    
    if ( superref )
    {
        skilldata = function_65556bd459a1a91c( #"hash_64e81ec7f6efd538" );
        
        if ( skilldata.size > 0 )
        {
            return utility::array_max( skilldata );
        }
    }
}

// Namespace namespace_64a89dd78801462c
// Params 1, eflags: 0x4
// Checksum 0x945601cd, Offset: 0x1d44
// Size: 0x5c
function private function_e51b0662d0dd8f13( equipmentref )
{
    tableinfo = equipment_mp::getequipmenttableinfo( equipmentref );
    superref = tableinfo.bundle.superref;
    
    if ( superref )
    {
        superref = isxhash( superref ) ? superref : getxhash( superref );
    }
    
    return superref;
}

// Namespace namespace_64a89dd78801462c
// Params 1, eflags: 0x4
// Checksum 0x3447647a, Offset: 0x1da9
// Size: 0x24
function private skills_getsuperref( skillref )
{
    return level.skillbundles[ skillref ][ 0 ].abilityref;
}

