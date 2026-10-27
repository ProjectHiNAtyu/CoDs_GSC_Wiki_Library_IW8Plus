// scripts\mp\ob\systems\weapons\ob_damage.gsc  (hash_48619caa0ec627d8.gscc) (size: 24581 Bytes / 0x6005 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x35359297 (892703383)
// size ...... 24581 (0x6005)
// includes .. 25  (offset: 0x5ba5)
// strings ... 51  (offset: 0x5c6d)
// dev strs .. 13  (offset: 0x5f5d)
// exports ... 35  (offset: 0x4325)
// cseg ...... 0x42c + 0x3ef9 (0x4325)
// imports ... 146 (offset: 0x489d)
// animtree1 . 0   (offset: 0x6005)
// animtree2 . 0   (offset: 0x6005)
#using script_16ea1b94f0f381b3;
#using script_3e14de319bce19ea;
#using scripts\common\ai\ai_utility;
#using scripts\common\ai\aitypes\shared\zombie\zombie_damage;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\game_utility;
#using scripts\common\metabone;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_occupancy;
#using scripts\common\weapon;
#using scripts\mp\agents\common_agent_damage;
#using scripts\mp\ammomods\ammo_mod;
#using scripts\mp\armor;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\damagefeedback;
#using scripts\mp\gametypes\ob;
#using scripts\mp\mp_agent_damage;
#using scripts\mp\ob\systems\ob_humans;
#using scripts\mp\vehicles\damage;
#using scripts\mp\weapons;

#namespace ob_damage;

// Namespace ob_damage
// Params 0
// Checksum 0xcd46ef33, Offset: 0x44a
// Size: 0x35c
function init_ob_damage()
{
    level.modifyplayerdamage = &function_5ee53cd7d343f5;
    level.var_7879aa3e617f6484 = [];
    level.var_a8be3cca85c8b037 = getdvarint( @"hash_f6c436971939cdb2", 200 );
    setdvarifuninitialized( @"hash_14ab1422df231908", level.var_bb86f77304f193c4.var_72d9dfb860aed30c ?? 1 );
    setdvarifuninitialized( @"hash_77cd6cb575e98646", level.var_bb86f77304f193c4.var_faec3914eea60d3b ?? 1 );
    setdvarifuninitialized( @"hash_77cd6bb575e98413", level.var_bb86f77304f193c4.var_faec3a14eea60f6e ?? 1 );
    setdvarifuninitialized( @"hash_77cd6ab575e981e0", level.var_bb86f77304f193c4.var_faec3b14eea611a1 ?? 1 );
    setdvarifuninitialized( @"hash_77cd71b575e99145", level.var_bb86f77304f193c4.var_faec3c14eea613d4 ?? 1 );
    setdvarifuninitialized( @"hash_a368b0b00437628a", level.var_bb86f77304f193c4.var_7c6ebeff7b3b1ade ?? 1 );
    setdvarifuninitialized( @"hash_85449c0ffa0bf789", level.var_bb86f77304f193c4.var_294208a9830068be ?? 1 );
    setdvarifuninitialized( @"hash_8d8dd60f44118792", level.var_bb86f77304f193c4.var_e8db2aaa108bd871 ?? 1 );
    setdvarifuninitialized( @"hash_74ad710fed1eb5af", level.var_bb86f77304f193c4.var_8bfbc192af1ec214 ?? 1 );
    setdvarifuninitialized( @"hash_74c3650fed36ce7e", level.var_bb86f77304f193c4.var_8bfbbe92af1ebb7b ?? 1 );
    setdvarifuninitialized( @"hash_942a0c5b99958579", level.var_bb86f77304f193c4.var_a431fc83747baced ?? 0 );
    
    if ( level.var_6488d1fb560a08fb && ob::nightmare() )
    {
        setdvarifuninitialized( @"hash_e0e770048a0edc4", level.var_bb86f77304f193c4.var_d257ca6b8f90ea61 ?? 1 );
    }
    
    level callback::add( "on_zombie_ai_spawned", &zombie_damage_on_spawned );
    level callback::add( "on_agent_spawned", &agent_damage_on_spawned );
    level callback::add( "on_zombie_ai_killed", &on_zombie_ai_killed );
    level callback::add( #"on_ai_killed", &function_9238338f068b6568 );
    level callback::add( #"register_perk", &registerperks );
    level.var_19dac4c03e6cd6cb = "evt_zm_core_zombie_objective_impact";
    level.var_e6d6d55c30c55761 = &function_2020d8f8c3d295a8;
    callback::get_template( "zombie" ) callback::add( "on_zombie_ai_damaged", &on_zombie_ai_damaged );
    utility::registersharedfunc( #"damage", #"hash_1962174a5b426182", &ob_vehicle_damage_modifiers );
    utility::registersharedfunc( #"damage_effects", #"hash_10afaf820ce5cf12", &function_78483e0471fc768c );
    utility::registersharedfunc( #"zombie_damage", #"hash_d276db87d69299de", &function_521e3a9651f4745f );
    level callback::add( #"hash_2346898712859996", &function_78c83af1285b73ae );
    level callback::add( #"is_critical_hit", &function_c2ba2dacbaea351c );
    
    /#
        level thread setup_ob_damage_devgui();
    #/
}

// Namespace ob_damage
// Params 11
// Checksum 0xaf35093b, Offset: 0x7ae
// Size: 0x5f1
function function_5ee53cd7d343f5( einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, var_cdd29ad5d1362c2 )
{
    base_damage_mitigation = getdvarfloat( @"hash_a368b0b00437628a", level.var_bb86f77304f193c4.var_7c6ebeff7b3b1ade ?? 1 );
    
    if ( isdefined( einflictor ) )
    {
        n_scaled_damage = idamage;
        var_3082076e0d180f53 = eattacker.difficulty ?? einflictor.difficulty ?? "difficulty_easy";
        
        if ( einflictor.basearchetype == "soldier" || einflictor.basearchetype == "juggerbot" )
        {
            switch ( objweapon.classname )
            {
                case #"hash_6191aaef9f922f96":
                    switch ( var_3082076e0d180f53 )
                    {
                        case #"hash_651f76c0ad6741ec":
                            n_scaled_damage = min( 200, idamage );
                            break;
                        case #"hash_5343b465e56ec9a4":
                            n_scaled_damage = min( 150, idamage );
                            break;
                        case #"hash_af83e47edfa8900a":
                            n_scaled_damage = min( 120, idamage );
                            break;
                        default:
                            n_scaled_damage = min( 90, idamage );
                            break;
                    }
                    
                    if ( einflictor.agent_type == "actor_sat_ob_enemy_basic_soldier_dmr" )
                    {
                        n_scaled_damage = int( n_scaled_damage * getdvarfloat( @"hash_8d8dd60f44118792", level.var_bb86f77304f193c4.var_e8db2aaa108bd871 ?? 1 ) );
                    }
                    
                    break;
                case #"hash_690c0d6a821b42e":
                    base_damage_mitigation = getdvarfloat( @"hash_85449c0ffa0bf789", level.var_bb86f77304f193c4.var_294208a9830068be ?? 1 );
                default:
                    if ( var_3082076e0d180f53 == "difficulty_easy" && !level.var_bb86f77304f193c4.var_aab22481530ff9ff )
                    {
                        base_damage_mitigation = getdvarfloat( @"hash_74ad710fed1eb5af", level.var_bb86f77304f193c4.var_8bfbc192af1ec214 ?? 1 );
                    }
                    else if ( var_3082076e0d180f53 == "difficulty_darkaether" )
                    {
                        base_damage_mitigation = getdvarfloat( @"hash_74c3650fed36ce7e", level.var_bb86f77304f193c4.var_8bfbbe92af1ebb7b ?? 1 );
                    }
                    
                    n_scaled_damage = int( idamage * base_damage_mitigation );
                    break;
            }
        }
        else if ( isdefined( eattacker ) && eattacker.basearchetype == "soldier" )
        {
            if ( objweapon.classname == "rocketlauncher" )
            {
                switch ( var_3082076e0d180f53 )
                {
                    case #"hash_651f76c0ad6741ec":
                        n_scaled_damage = min( 200, idamage );
                        break;
                    case #"hash_5343b465e56ec9a4":
                        n_scaled_damage = min( 175, idamage );
                        break;
                    case #"hash_af83e47edfa8900a":
                        n_scaled_damage = min( 150, idamage );
                        break;
                    default:
                        n_scaled_damage = min( 125, idamage );
                        break;
                }
            }
        }
        
        if ( einflictor.sentrytype == "ai_sentry_turret" || einflictor.vehiclename == "veh_dag_turret_ob" )
        {
            n_scaled_damage = int( idamage * base_damage_mitigation );
        }
        
        if ( getdvarint( @"hash_14ab1422df231908", level.var_bb86f77304f193c4.var_72d9dfb860aed30c ?? 1 ) )
        {
            squad = teams::function_72b89edf6b47c40a( self );
            
            if ( squad.players && squad.players.size == 1 )
            {
                switch ( var_3082076e0d180f53 )
                {
                    case #"hash_651f76c0ad6741ec":
                        n_scaled_damage *= getdvarfloat( @"hash_77cd71b575e99145", level.var_bb86f77304f193c4.var_faec3c14eea613d4 ?? 1 );
                        break;
                    case #"hash_5343b465e56ec9a4":
                        n_scaled_damage *= getdvarfloat( @"hash_77cd6ab575e981e0", level.var_bb86f77304f193c4.var_faec3b14eea611a1 ?? 1 );
                        break;
                    case #"hash_af83e47edfa8900a":
                        n_scaled_damage *= getdvarfloat( @"hash_77cd6bb575e98413", level.var_bb86f77304f193c4.var_faec3a14eea60f6e ?? 1 );
                        break;
                    default:
                        n_scaled_damage *= getdvarfloat( @"hash_77cd6cb575e98646", level.var_bb86f77304f193c4.var_faec3914eea60d3b ?? 1 );
                        break;
                }
            }
        }
        
        if ( getdvarfloat( @"hash_942a0c5b99958579", level.var_bb86f77304f193c4.var_a431fc83747baced ?? 0 ) )
        {
            squad = teams::function_72b89edf6b47c40a( self );
            
            if ( squad.players && squad.players.size == 4 )
            {
                n_scaled_damage *= getdvarfloat( @"hash_942a0c5b99958579", level.var_bb86f77304f193c4.var_a431fc83747baced ?? 1 );
            }
        }
        
        idamage = n_scaled_damage;
    }
    
    if ( isdefined( eattacker ) && isdefined( eattacker.is_rover ) )
    {
        return 0;
    }
    
    foreach ( func in level.var_7879aa3e617f6484 )
    {
        idamage = [[ func ]]( einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, var_cdd29ad5d1362c2 );
    }
    
    return idamage;
}

// Namespace ob_damage
// Params 2
// Checksum 0x68562e5a, Offset: 0xda8
// Size: 0x3e
function function_316cb76449f3acf7( key, func )
{
    assert( !isdefined( level.var_7879aa3e617f6484[ key ] ), "<dev string:x24>" );
    level.var_7879aa3e617f6484[ key ] = func;
}

// Namespace ob_damage
// Params 2
// Checksum 0xf2b433b8, Offset: 0xdee
// Size: 0x21
function function_9ba96eafac5e5404( key, func )
{
    level.var_7879aa3e617f6484[ key ] = undefined;
}

// Namespace ob_damage
// Params 0
// Checksum 0x22a10c22, Offset: 0xe17
// Size: 0x45
function function_7ffefdc47a564d4c()
{
    assert( isdefined( level.vehicles ), "<dev string:x66>" );
    setdvarifuninitialized( @"hash_9cf7e7a1964e81cc", 0.65 );
    level.vehicles.damagecallback = &function_d4c7e333bbad9e98;
}

// Namespace ob_damage
// Params 1, eflags: 0x4
// Checksum 0x5e6d0ac2, Offset: 0xe64
// Size: 0x154
function private agent_damage_on_spawned( params )
{
    agent = params.agent;
    
    if ( agent.unittype != "soldier" && agent.unittype != "juggernaut" && agent.unittype != "dog" )
    {
        return;
    }
    
    agent.agent_damage_callback = &function_88e5812bbeba2168;
    var_98972365aa476fb = [ "molotov", "flashbang", "tear_gas", "thermobaric" ];
    agent.var_1a61fee8c309f5f3 = [];
    
    foreach ( exclusion in var_98972365aa476fb )
    {
        agent.var_1a61fee8c309f5f3[ exclusion ] = 1;
    }
    
    agent.a_n_player_damage = [];
    agent.var_d4b7ed447e2bf50c = [];
    agent callback::add( "on_soldier_ai_damaged", &on_soldier_ai_damaged );
}

// Namespace ob_damage
// Params 1, eflags: 0x4
// Checksum 0xa754248a, Offset: 0xfc0
// Size: 0x1a
function private zombie_damage_on_spawned( params )
{
    self.agent_damage_callback = &function_ddf5f982ca376898;
}

// Namespace ob_damage
// Params 14
// Checksum 0xf5067338, Offset: 0xfe2
// Size: 0xbe9
function function_ddf5f982ca376898( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon, poisedamage )
{
    if ( isplayer( eattacker ) )
    {
        eattacker thread namespace_4c6ef5221f3fa284::function_788c4ebdd65b5c58( self, shitloc, idamage );
    }
    
    if ( utility::issharedfuncdefined( #"zombie", #"player_has_augment" ) && isplayer( eattacker ) && eattacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"aether_shroud_shadow_blade" ) )
    {
        if ( eattacker.aether_shroud_active && smeansofdeath == "MOD_MELEE" )
        {
            smeansofdeath = "MOD_ELEMENTAL_DARK";
        }
    }
    
    if ( eattacker.var_bc3aafee8dfa99f5 && utility::issharedfuncdefined( #"zombie", #"player_has_augment" ) && isplayer( eattacker.var_bd22ba6c600a23a3 ) && eattacker.var_bd22ba6c600a23a3 utility::callsharedfunc( #"zombie", #"player_has_augment", #"brainrot_plague" ) )
    {
        var_5861616f59906e99 = level.zombie_augments[ #"brainrot_plague" ].var_5861616f59906e99 ?? 0;
        var_5861616f59906e99 *= 100;
        
        if ( isdefined( self.aicategory ) )
        {
            if ( self.aicategory == "special" )
            {
                var_5861616f59906e99 = level.zombie_augments[ #"brainrot_plague" ].var_19e1bcd5e5d7f5fc ?? 0;
                var_5861616f59906e99 *= 100;
            }
        }
        
        var_801b8ba167677ba4 = level.gametypebundle.var_a2b029d0cb1a61cc ?? 15;
        
        if ( ( level.var_7c526b990a6af27b < var_801b8ba167677ba4 || var_801b8ba167677ba4 == -1 ) && var_5861616f59906e99 > 0 && utility::percent_chance( var_5861616f59906e99 ) && !( self.aicategory == "elite" || self.aicategory == "hvt" ) )
        {
            if ( utility::issharedfuncdefined( #"zombie", #"brainrot_zombie" ) )
            {
                utility::callsharedfunc( #"zombie", #"brainrot_zombie", 0, eattacker.var_bd22ba6c600a23a3, undefined, undefined, undefined, undefined, undefined, 1 );
                sparams = spawnstruct();
                sparams.ammomod_name = "brainrot";
                sparams.sweapon = sweapon;
                sparams.victim = self;
                eattacker.var_bd22ba6c600a23a3 callback::callback( "ammomod_proc", sparams );
                return 0;
            }
        }
    }
    
    dmg_struct = zombie_damage::build_damage_struct( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon );
    
    if ( isdefined( self.last_dmg_struct ) )
    {
        dmg_struct.num_hits = self.last_dmg_struct.num_hits;
    }
    else
    {
        dmg_struct.num_hits = 0;
    }
    
    dmg_struct.num_hits++;
    dmg_struct.var_5e5a2456deacd236 = zombie_damage::handle_status_effects( dmg_struct );
    assert( isdefined( dmg_struct.idamage ) );
    var_81e8481c464e91b3 = function_8bd440fef2c377bf( dmg_struct ) == 0;
    
    if ( zombie_damage::should_skip_damage( eattacker, objweapon, smeansofdeath ) || var_81e8481c464e91b3 )
    {
        if ( isplayer( eattacker ) && self.team != eattacker.team )
        {
            eattacker damagefeedback::updatedamagefeedback( "standard", 0 );
        }
        
        return 0;
    }
    
    if ( self.var_7037157e68c4992b == dmg_struct.idamage )
    {
        dmg_struct.var_d33b5d20cf3b0e9b = 1;
        self.var_7037157e68c4992b = undefined;
    }
    
    function_df20523c91ab226c( dmg_struct );
    dmg_struct.idamage *= function_dc1ae9a333356966( dmg_struct );
    dmg_struct.idamage = zombie_damage::function_cef159ba09a96f98( dmg_struct );
    dmg_struct.idamage = zombie_damage::function_40c3998760e0b954( dmg_struct );
    dmg_struct.idamage = zombie_damage::function_e01c2c6191f04821( dmg_struct );
    dmg_struct.idamage = zombie_damage::function_5fc0f527cde63905( dmg_struct );
    dmg_struct.idamage = zombie_damage::function_b9821f08dcbdc9d0( dmg_struct );
    dmg_struct.idamage = zombie_damage::function_881dfa87252ee0ea( dmg_struct );
    dmg_struct.idamage = zombie_damage::function_579261f41dfd0572( dmg_struct );
    dmg_struct.idamage = zombie_damage::function_e20f670a9518dbc0( dmg_struct );
    dmg_struct.idamage = zombie_damage::function_e06f2d26a28d8093( dmg_struct );
    dmg_struct.idamage = zombie_damage::function_2bf9dd60a4f921ca( dmg_struct );
    dmg_struct.idamage = zombie_damage::function_87aebf397086e82f( dmg_struct );
    dmg_struct.idamage = zombie_damage::function_eb7d5e5b35444c8b( dmg_struct );
    assert( dmg_struct.idamage > 0 && int( dmg_struct.idamage ) > 0 );
    dmg_struct.idamage = zombie_damage::function_23f0f83c55de1ad( dmg_struct );
    
    if ( !isalive( self ) )
    {
        return 0;
    }
    
    if ( isdefined( dmg_struct.eattacker ) && isplayer( dmg_struct.eattacker.owner ) )
    {
        dmg_struct.eattacker = dmg_struct.eattacker.owner;
    }
    
    if ( isplayer( dmg_struct.eattacker ) )
    {
        ammo_mod::default_ai_response( dmg_struct );
        dmg_struct.var_bd22ba6c600a23a3 = self.var_bd22ba6c600a23a3;
    }
    
    if ( isexplosivedamagemod( smeansofdeath ) )
    {
        if ( utility::issharedfuncdefined( #"thermobaric_grenade", #"thermobaric_additional_explosive_damage" ) )
        {
            dmg_struct.idamage += [[ utility::getsharedfunc( #"thermobaric_grenade", #"thermobaric_additional_explosive_damage" ) ]]( self, eattacker, dmg_struct.idamage );
        }
    }
    
    damaged_armor = zombie_damage::check_damaged_armor( dmg_struct );
    headshot = damage_utility::isheadshot( dmg_struct.shitloc, dmg_struct.smeansofdeath, dmg_struct.eattacker );
    
    if ( !headshot && isdefined( self.armorhealth ) && self.armorhealth > 0 && dmg_struct.smeansofdeath != "MOD_CRUSH" && ( !isdefined( self.var_f424a6135c1dd01f ) || !( isdefined( dmg_struct.einflictor ) && arraycontains( self.var_f424a6135c1dd01f, dmg_struct.einflictor ) ) ) )
    {
        initial_damage = dmg_struct.idamage;
        unmodifieddamage = dmg_struct.idamage;
        [ dmg_struct.idamage, lightarmordamage ] = armor::function_4875d04d69b22ae( dmg_struct.eattacker, dmg_struct.einflictor, self, dmg_struct.idamage, dmg_struct.objweapon, dmg_struct.smeansofdeath, dmg_struct.shitloc, dmg_struct.idflags, initial_damage, unmodifieddamage );
        
        if ( dmg_struct.idamage <= 0 && lightarmordamage > 0 )
        {
            dmg_struct.idamage = 1;
            self.health += 1;
        }
        
        if ( lightarmordamage > 0 )
        {
            damaged_armor = 1;
        }
    }
    
    thread zombie_damage::check_armor_hitmarker( dmg_struct.eattacker, damaged_armor, "hitarmorlight" );
    zombie_damage::function_40c3998760e0b954( dmg_struct );
    zombie_damage::function_960f65c8626d199b( dmg_struct );
    zombie_damage::function_10e5fc0c6d63f99c( dmg_struct );
    zombie_damage::try_damage_metabone( dmg_struct );
    zombie_damage::function_bccc7eb65bfbb479( dmg_struct );
    zombie_damage::function_1f965cbbc7f5d5e7( dmg_struct );
    function_6229eec46b16b31f( dmg_struct.eattacker.var_2951937606aa477a, dmg_struct );
    zombie_damage::function_f02b21908b7bd90d( dmg_struct );
    
    if ( self.killondamage )
    {
        dmg_struct.idamage = self.health;
    }
    
    dmg_struct.bimmune = dmg_struct.idamage <= 0;
    
    if ( !val::get( "damage_knockback" ) )
    {
        self.modifiedidflags |= 4;
    }
    
    if ( isdefined( eattacker ) && ( isplayer( eattacker ) || isplayer( eattacker.owner ) ) )
    {
        eplayer = eattacker;
        var_b67d4fdd1ab59745 = undefined;
        var_2783eb34c3422e11 = undefined;
        
        if ( isplayer( eattacker.owner ) )
        {
            eplayer = eattacker.owner;
        }
        
        if ( isarray( self.elementalweakness ) && isdefined( dmg_struct.var_5e5a2456deacd236 ) )
        {
            var_b67d4fdd1ab59745 = self.elementalweakness[ dmg_struct.var_5e5a2456deacd236 ];
        }
        
        if ( !dmg_struct.var_d20799805edf0194 && mp_agent_damage::function_dc9f82a74577dbd9() && mp_agent_damage::function_e7d118eb7b017fa4() )
        {
            mp_agent_damage::function_eb8ba16055d6da7c( eplayer, self, shitloc, smeansofdeath, objweapon, int( dmg_struct.idamage ), vpoint, dmg_struct.bimmune, dmg_struct.var_5e5a2456deacd236, dmg_struct.biscritical, damaged_armor, undefined, 0, einflictor );
        }
        else if ( var_b67d4fdd1ab59745 && shitloc != "shield" )
        {
            var_2783eb34c3422e11 = level.var_7f713ff739629360[ dmg_struct.var_5e5a2456deacd236 ];
            eattacker damagefeedback::updatedamagefeedback( var_2783eb34c3422e11, dmg_struct.idamage >= self.health, dmg_struct.biscritical );
        }
        
        if ( isplayer( eattacker ) && dmg_struct.idamage > 0 && shitloc != "shield" && !isdefined( var_2783eb34c3422e11 ) )
        {
            eattacker damagefeedback::updatedamagefeedback( "standard", dmg_struct.idamage >= self.health, dmg_struct.biscritical );
        }
    }
    
    if ( isdefined( eattacker ) && eattacker vehicle::is_vehicle() )
    {
        eattacker notify( #"hash_7bafb4378d0bb015", self );
    }
    
    self.last_dmg_struct = dmg_struct;
    callback::callback( "on_zombie_ai_damaged", dmg_struct );
    
    if ( isdefined( eattacker ) && ( isdefined( eattacker.is_quest_ai ) || isdefined( eattacker.var_76ac6088f875328a ) ) )
    {
        var_dda424c349037c52 = 1;
        
        if ( isdefined( eattacker.is_quest_ai ) )
        {
            var_dda424c349037c52 = 200;
        }
        else if ( isdefined( eattacker.var_76ac6088f875328a ) )
        {
            var_dda424c349037c52 = eattacker.var_76ac6088f875328a;
        }
        
        if ( isdefined( dmg_struct.idamage ) )
        {
            dmg_struct.idamage *= var_dda424c349037c52;
        }
    }
    
    var_c354cbe81abad2 = int( dmg_struct.idamage );
    
    if ( !isdefined( var_c354cbe81abad2 ) || var_c354cbe81abad2 < 0 )
    {
        assert( 0 );
        var_c354cbe81abad2 = 0;
    }
    
    if ( level.var_6488d1fb560a08fb && ob::nightmare() && ( isplayer( eattacker ) || isplayer( eattacker.owner ) ) )
    {
        var_c354cbe81abad2 *= getdvarfloat( @"hash_e0e770048a0edc4", level.var_bb86f77304f193c4.var_d257ca6b8f90ea61 ?? 1 );
    }
    
    return var_c354cbe81abad2;
}

// Namespace ob_damage
// Params 1, eflags: 0x4
// Checksum 0xb911acba, Offset: 0x1bd4
// Size: 0xc6
function private on_zombie_ai_damaged( dmg_struct )
{
    if ( isplayer( dmg_struct.eattacker ) && isdefined( self.a_n_player_damage ) )
    {
        self.a_n_player_damage = arraycombineunique( self.a_n_player_damage, [ dmg_struct.eattacker ] );
    }
    
    if ( isplayer( dmg_struct.eattacker ) && isdefined( self.var_d4b7ed447e2bf50c ) && isdefined( dmg_struct.sweapon ) )
    {
        playernum = dmg_struct.eattacker getentitynumber();
        self.var_d4b7ed447e2bf50c[ playernum ] = dmg_struct.sweapon;
    }
    
    vehicle_damage::function_182f0b7ab120aa9b( dmg_struct );
    thread zombie_damage::function_9238df0f5f57170a( dmg_struct );
}

// Namespace ob_damage
// Params 1, eflags: 0x4
// Checksum 0x33f43377, Offset: 0x1ca2
// Size: 0xdd
function private function_df20523c91ab226c( dmg_struct )
{
    if ( dmg_struct.eattacker && dmg_struct.eattacker callback::exists_any( #"is_critical_hit" ) )
    {
        params = { #einflictor:dmg_struct.einflictor, #shitloc:dmg_struct.shitloc, #objweapon:dmg_struct.objweapon, #smeansofdeath:dmg_struct.smeansofdeath };
        is_critical_hit = dmg_struct.eattacker callback::response( 0, #"is_critical_hit", params );
    }
    
    if ( is_critical_hit )
    {
        dmg_struct.forcecrit = 1;
        dmg_struct.biscritical = 1;
    }
}

// Namespace ob_damage
// Params 5, eflags: 0x4
// Checksum 0xfc511d8a, Offset: 0x1d87
// Size: 0xea
function private ob_vehicle_damage_modifiers( var_8a871acb1f1990b7, vehicle, zombie, var_e2135a579d15e713, bundledata )
{
    if ( vehicle.var_8104535d1b0b4e4 )
    {
        return var_8a871acb1f1990b7;
    }
    
    regiondifficulty = "difficulty_easy";
    
    if ( isfunction( level.var_bb131187d6741752 ) )
    {
        regiondifficulty = [[ level.var_bb131187d6741752 ]]( vehicle.origin );
    }
    
    switch ( regiondifficulty )
    {
        case #"hash_af83e47edfa8900a":
            var_8a871acb1f1990b7 *= 2;
            break;
        case #"hash_5343b465e56ec9a4":
            var_8a871acb1f1990b7 *= 5;
            break;
        case #"hash_651f76c0ad6741ec":
            var_8a871acb1f1990b7 *= 10;
            break;
        case #"hash_c0250ffc2e87f2ff":
        case #"hash_c02510fc2e87f492":
            var_8a871acb1f1990b7 *= 20;
            break;
    }
    
    return var_8a871acb1f1990b7;
}

// Namespace ob_damage
// Params 0, eflags: 0x4
// Checksum 0x18068424, Offset: 0x1e7a
// Size: 0x74
function private function_ebf195b764552e41()
{
    if ( !self )
    {
        return 0;
    }
    
    if ( self == level.weaponnone )
    {
        return 1;
    }
    
    hash_weapon_name = self.var_1616e6fbba9a722d;
    
    if ( !hash_weapon_name )
    {
        return 0;
    }
    
    if ( level.weaponmetadata )
    {
        metadata = level.weaponmetadata[ hash_weapon_name ];
        
        if ( metadata.var_ebf195b764552e41 )
        {
            return metadata.var_ebf195b764552e41;
        }
    }
    
    return 0;
}

// Namespace ob_damage
// Params 1, eflags: 0x4
// Checksum 0x4d1ea39a, Offset: 0x1ef7
// Size: 0x6d
function private is_critical_allowed( dmg_struct )
{
    if ( dmg_struct.smeansofdeath == "MOD_MELEE" && !level.gamemodebundle.var_a6ddfde4d8752843 )
    {
        return;
    }
    
    return dmg_struct.forcecrit || isplayer( dmg_struct.eattacker ) && !dmg_struct.objweapon weapon::function_ebf195b764552e41();
}

// Namespace ob_damage
// Params 3, eflags: 0x4
// Checksum 0xd9722a11, Offset: 0x1f6d
// Size: 0x342
function private function_fd5f6e73cbb5e11( dmg_struct, shitloc, var_951c89546ec50477 )
{
    if ( !is_critical_allowed( dmg_struct ) )
    {
        return dmg_struct.idamage;
    }
    
    if ( shitloc == "head" || shitloc == "neck" || shitloc == "helmet" )
    {
        dmg_struct.biscritical = 1;
    }
    
    if ( !dmg_struct.biscritical )
    {
        if ( dmg_struct.eattacker callback::exists_any( #"is_critical_hit" ) )
        {
            params = { #einflictor:dmg_struct.einflictor, #shitloc:dmg_struct.shitloc, #objweapon:dmg_struct.objweapon, #smeansofdeath:dmg_struct.smeansofdeath };
            is_critical_hit = dmg_struct.eattacker callback::response( 0, #"is_critical_hit", params );
        }
        
        if ( is_critical_hit )
        {
            dmg_struct.biscritical = 1;
            
            if ( dmg_struct.idflags & 262144 )
            {
                weapondamagetype = 2;
            }
            else
            {
                weapondamagetype = 0;
            }
            
            var_ea007afa6a78065 = weapongetdamagelocationmodifier( dmg_struct.objweapon, "head", weapondamagetype );
            
            if ( var_ea007afa6a78065 )
            {
                dmg_struct.idamage *= var_ea007afa6a78065;
            }
        }
    }
    
    var_a04c11d813c699f7 = dmg_struct.biscritical && dmg_struct.smeansofdeath == "MOD_MELEE";
    
    if ( dmg_struct.eattacker.var_81dcc244c7c4591e )
    {
        dmg_struct.eattacker.var_81dcc244c7c4591e = undefined;
        
        if ( self.aicategory != "boss" )
        {
            dmg_struct.biscritical = 1;
            var_a04c11d813c699f7 = 1;
        }
    }
    
    if ( dmg_struct.biscritical )
    {
        if ( dmg_struct.eattacker.var_92a742437d824533 )
        {
            dmg_struct.idamage *= dmg_struct.eattacker.var_92a742437d824533;
            dmg_struct.var_ac6da6d4896af068 = 1;
        }
    }
    
    if ( var_a04c11d813c699f7 )
    {
        if ( dmg_struct.idflags & 262144 )
        {
            weapondamagetype = 2;
        }
        else
        {
            weapondamagetype = 0;
        }
        
        isgunbutt = !( isweapon( dmg_struct.objweapon ) && dmg_struct.objweapon.ismelee ) && dmg_struct.smeansofdeath === "MOD_MELEE";
        
        if ( isgunbutt )
        {
            var_ea007afa6a78065 = 1.5;
        }
        else
        {
            var_ea007afa6a78065 = weapongetdamagelocationmodifier( dmg_struct.objweapon, "head", weapondamagetype );
        }
        
        if ( var_ea007afa6a78065 )
        {
            var_25ebc911e358603c = dmg_struct.idamage * ( var_ea007afa6a78065 - 1 );
            dmg_struct.idamage += var_25ebc911e358603c;
        }
    }
    
    return dmg_struct.idamage;
}

// Namespace ob_damage
// Params 1, eflags: 0x4
// Checksum 0xc7687b2c, Offset: 0x22b8
// Size: 0x167
function private function_a84fd8fb924f64d9( dmg_struct )
{
    if ( dmg_struct.idflags & 1073741824 && level.var_bb86f77304f193c4.var_17b1c9f21dc77c5a )
    {
        dmg_struct.idamage *= level.var_bb86f77304f193c4.var_17b1c9f21dc77c5a;
    }
    
    if ( !( dmg_struct.idflags & 65536 ) )
    {
        eattacker = dmg_struct.eattacker;
        
        if ( isplayer( eattacker ) )
        {
            objweapon = zombie_damage::function_2a4a7ff773fb9d07( dmg_struct.objweapon, eattacker );
            smeansofdeath = dmg_struct.smeansofdeath;
            
            if ( utility::issharedfuncdefined( #"zombie_damage", #"hash_d276db87d69299de" ) )
            {
                var_b92817d29e3cb812 = utility::callsharedfunc( #"zombie_damage", #"hash_d276db87d69299de", objweapon, eattacker );
                dmg_struct.idamage *= var_b92817d29e3cb812;
            }
            
            rarity = eattacker zombie_damage::function_af20e81da38c49bc( objweapon );
            var_b92817d29e3cb812 = zombie_damage::function_6786d0923b8261db( objweapon, smeansofdeath, rarity );
            dmg_struct.idamage *= var_b92817d29e3cb812;
        }
    }
    
    return dmg_struct.idamage;
}

// Namespace ob_damage
// Params 1, eflags: 0x4
// Checksum 0x4ad5314d, Offset: 0x2428
// Size: 0xaa
function private function_dc1ae9a333356966( dmg_struct )
{
    if ( dmg_struct.sweapon.basename == "t10_hed_gasoline_barrel_01" || dmg_struct.sweapon.basename == "t10_hed_gasoline_tank_01" || dmg_struct.sweapon.basename == "t10_hed_acetylene_tank_01" || dmg_struct.sweapon.basename == "t10_hed_propane_tank_01" )
    {
        scalar = ob_humans::function_dab547bbe5a5731e( self.difficulty );
        return scalar;
    }
    
    return 1;
}

// Namespace ob_damage
// Params 14
// Checksum 0x8e8af86d, Offset: 0x24db
// Size: 0x90d
function function_88e5812bbeba2168( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon, poisedamage )
{
    if ( self.var_a6ecefe6814132d4 )
    {
        return 0;
    }
    
    if ( eattacker.var_bc3aafee8dfa99f5 && isplayer( eattacker.var_bd22ba6c600a23a3 ) && eattacker.var_bd22ba6c600a23a3 utility::callsharedfunc( #"zombie", #"player_has_augment", #"brainrot_plague" ) )
    {
        ai_tier = ai_utility::get_ai_tier();
        
        if ( ai_tier == 2 )
        {
            var_5861616f59906e99 = level.zombie_augments[ #"brainrot_plague" ].var_19e1bcd5e5d7f5fc ?? 0;
        }
        else
        {
            var_5861616f59906e99 = level.zombie_augments[ #"brainrot_plague" ].var_5861616f59906e99 ?? 0;
        }
        
        var_5861616f59906e99 *= 100;
        var_801b8ba167677ba4 = level.gametypebundle.var_a2b029d0cb1a61cc ?? 15;
        var_22ace50f473043a1 = level.var_7c526b990a6af27b < var_801b8ba167677ba4 || var_801b8ba167677ba4 == -1;
        validtarget = ai_tier && ai_tier != 3;
        
        if ( var_22ace50f473043a1 && validtarget && var_5861616f59906e99 > 0 && utility::percent_chance( var_5861616f59906e99 ) )
        {
            if ( utility::callsharedfunc( #"zombie", #"brainrot_zombie", 0, eattacker.var_bd22ba6c600a23a3, undefined, undefined, undefined, undefined, undefined, 1 ) )
            {
                sparams = spawnstruct();
                sparams.ammomod_name = "brainrot";
                sparams.sweapon = sweapon;
                sparams.victim = self;
                eattacker.var_bd22ba6c600a23a3 callback::callback( "ammomod_proc", sparams );
                return 0;
            }
        }
    }
    
    dmg_struct = spawnstruct();
    dmg_struct.einflictor = einflictor;
    dmg_struct.eattacker = eattacker;
    dmg_struct.idamage = idamage;
    dmg_struct.idflags = idflags;
    dmg_struct.smeansofdeath = smeansofdeath;
    dmg_struct.sweapon = sweapon;
    dmg_struct.vpoint = vpoint;
    dmg_struct.vdir = vdir;
    dmg_struct.shitloc = shitloc;
    dmg_struct.timeoffset = timeoffset;
    dmg_struct.modelindex = modelindex;
    dmg_struct.partname = partname;
    dmg_struct.objweapon = objweapon;
    dmg_struct.biscritical = 0;
    dmg_struct.var_4f9d5587bf9a2b1e = 0;
    
    if ( metabone::function_83525a0b05843168() )
    {
        dmg_struct.metabonename = metabone::function_b7f4a00525689bee( dmg_struct );
    }
    else
    {
        dmg_struct.metabonename = metabone::get_metabone_name( shitloc, partname, vpoint, vdir );
        
        if ( !isdefined( dmg_struct.metabonename ) && smeansofdeath == "MOD_EXPLOSIVE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_PROJECTILE_SPLASH" )
        {
            var_d906f3558dfa031f = metabone::function_30d906ccb9fe2142( "Types_Armor" );
            
            if ( var_d906f3558dfa031f.size > 0 )
            {
                dmg_struct.metabonename = utility::array_random( var_d906f3558dfa031f );
            }
        }
    }
    
    if ( metabone::function_3866ce438fcee825() )
    {
        dmg_struct.forcecrit = metabone::function_d985a5fbf5939161( dmg_struct );
    }
    
    if ( isdefined( self.last_dmg_struct ) )
    {
        dmg_struct.num_hits = self.last_dmg_struct.num_hits;
    }
    else
    {
        dmg_struct.num_hits = 0;
    }
    
    dmg_struct.num_hits++;
    var_951c89546ec50477 = 0;
    
    if ( utility::issharedfuncdefined( #"zombie", #"get_pap_level" ) && isplayer( dmg_struct.eattacker ) )
    {
        var_951c89546ec50477 = dmg_struct.eattacker utility::callsharedfunc( #"zombie", #"get_pap_level", dmg_struct.objweapon );
    }
    
    dmg_struct.idamage = function_8bd440fef2c377bf( dmg_struct );
    
    if ( var_951c89546ec50477 >= 1 )
    {
        dmg_struct.idamage /= 2;
    }
    
    if ( dmg_struct.smeansofdeath == "MOD_PROJECTILE" && isdefined( eattacker ) && isdefined( eattacker.var_5234da73eeab6e09 ) )
    {
        dmg_struct.idamage *= eattacker.var_5234da73eeab6e09;
    }
    
    dmg_struct.idamage = function_a84fd8fb924f64d9( dmg_struct );
    dmg_struct.idamage = zombie_damage::function_e01c2c6191f04821( dmg_struct );
    dmg_struct.idamage = function_fd5f6e73cbb5e11( dmg_struct, shitloc, var_951c89546ec50477 );
    
    if ( isplayer( eattacker ) && utility::issharedfuncdefined( #"player", #"hash_b0979c1a1f9ea686" ) )
    {
        var_4346ca48d4b756d8 = eattacker [[ utility::getsharedfunc( #"player", #"hash_b0979c1a1f9ea686" ) ]]( dmg_struct );
        
        if ( var_4346ca48d4b756d8 != -1 )
        {
            dmg_struct.idamage = var_4346ca48d4b756d8;
        }
    }
    
    if ( level.var_37f0dad872bed468 && utility::issharedfuncdefined( #"zombie", #"hash_8a860cb98efd603a" ) )
    {
        dmg_struct.idamage = utility::callsharedfunc( #"zombie", #"hash_8a860cb98efd603a", dmg_struct );
    }
    
    dmg_struct.idamage *= function_dc1ae9a333356966( dmg_struct );
    function_6229eec46b16b31f( level.var_e8f6b03121a2f56d, dmg_struct );
    function_6229eec46b16b31f( self.var_e8f6b03121a2f56d, dmg_struct );
    function_6229eec46b16b31f( dmg_struct.eattacker.var_a6b60fbbf92080ed, dmg_struct );
    final_damage = dmg_struct.idamage;
    dmg_struct.bimmune = final_damage <= 0;
    dmg_struct.var_4f9d5587bf9a2b1e = self.armorhealth > 0 && !dmg_struct.biscritical;
    
    if ( self.bhasriotshieldattached && smeansofdeath == "MOD_MELEE" && ( eattacker || vpoint ) && !common_agent_damage::function_892b05acb2029575( shitloc, eattacker, vpoint ) )
    {
        dmg_struct.var_4f9d5587bf9a2b1e = 1;
        final_damage = 0;
    }
    
    if ( isdefined( eattacker ) && ( isplayer( eattacker ) || isplayer( eattacker.owner ) ) && eattacker.team != self.team )
    {
        eplayer = eattacker;
        var_5e5a2456deacd236 = zombie_damage::get_element( sweapon );
        
        if ( isplayer( eattacker.owner ) )
        {
            eplayer = eattacker.owner;
        }
        
        if ( mp_agent_damage::function_e257c518b45c4dbb() )
        {
            mp_agent_damage::function_eb8ba16055d6da7c( eplayer, self, shitloc, smeansofdeath, sweapon, int( final_damage ), vpoint, dmg_struct.bimmune, var_5e5a2456deacd236, dmg_struct.biscritical, dmg_struct.var_4f9d5587bf9a2b1e, undefined, 0, einflictor );
        }
    }
    
    self.last_dmg_struct = dmg_struct;
    
    if ( isplayer( dmg_struct.eattacker ) && level.gametypebundle.var_451ef421f1fcc5ad )
    {
        ammo_mod::default_ai_response( dmg_struct );
        dmg_struct.var_bd22ba6c600a23a3 = self.var_bd22ba6c600a23a3;
    }
    
    callback::callback( "on_soldier_ai_damaged", dmg_struct );
    
    if ( isdefined( eattacker ) && isdefined( eattacker.is_quest_ai ) )
    {
        var_dda424c349037c52 = 180;
        
        if ( isdefined( final_damage ) )
        {
            final_damage *= var_dda424c349037c52;
        }
    }
    
    if ( self.bhasriotshieldattached && shitloc == "shield" )
    {
        if ( isagent( eattacker ) && eattacker.unittype == "zombie" )
        {
            self.forcehitlocation = "none";
            final_damage *= 0.5;
        }
    }
    
    dmg_struct.idamage = final_damage;
    zombie_damage::try_damage_metabone( dmg_struct );
    
    if ( level.var_6488d1fb560a08fb && ob::nightmare() && ( isplayer( eattacker ) || isplayer( eattacker.owner ) ) )
    {
        final_damage *= getdvarfloat( @"hash_e0e770048a0edc4", level.var_bb86f77304f193c4.var_d257ca6b8f90ea61 ?? 1 );
    }
    
    return int( final_damage );
}

// Namespace ob_damage
// Params 2, eflags: 0x4
// Checksum 0x3e3a32df, Offset: 0x2df1
// Size: 0xab
function private function_6229eec46b16b31f( callback_list, dmg_struct )
{
    foreach ( func in callback_list )
    {
        new_damage = self [[ func ]]( dmg_struct );
        
        if ( new_damage && new_damage != -1 )
        {
            dmg_struct.idamage = new_damage;
        }
    }
}

// Namespace ob_damage
// Params 1, eflags: 0x4
// Checksum 0x4242a457, Offset: 0x2ea4
// Size: 0xbd
function private on_soldier_ai_damaged( dmg_struct )
{
    if ( isplayer( dmg_struct.eattacker ) && isdefined( self.a_n_player_damage ) )
    {
        self.a_n_player_damage = arraycombineunique( self.a_n_player_damage, [ dmg_struct.eattacker ] );
    }
    
    if ( isplayer( dmg_struct.eattacker ) && isdefined( self.var_d4b7ed447e2bf50c ) && isdefined( dmg_struct.sweapon ) )
    {
        playernum = dmg_struct.eattacker getentitynumber();
        self.var_d4b7ed447e2bf50c[ playernum ] = dmg_struct.sweapon;
    }
    
    vehicle_damage::function_182f0b7ab120aa9b( dmg_struct );
}

// Namespace ob_damage
// Params 1, eflags: 0x4
// Checksum 0x64b1aa97, Offset: 0x2f69
// Size: 0x7d
function private on_zombie_ai_killed( params )
{
    playerattacker = params.eattacker;
    
    if ( isdefined( playerattacker ) && !isplayer( playerattacker ) && isplayer( playerattacker.owner ) )
    {
        playerattacker = playerattacker.owner;
    }
    
    if ( isplayer( playerattacker ) )
    {
        playerattacker thread mp_agent_damage::updaterecentagentkills( self, params.einflictor, params.objweapon );
    }
}

// Namespace ob_damage
// Params 1, eflags: 0x4
// Checksum 0x97ecc808, Offset: 0x2fee
// Size: 0x13
function private function_9238338f068b6568( params )
{
    game_utility_common::removefromcharactersarray();
}

// Namespace ob_damage
// Params 14
// Checksum 0x52b28288, Offset: 0x3009
// Size: 0x1d5
function function_d4c7e333bbad9e98( inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname, eventid )
{
    if ( isplayer( attacker ) )
    {
        if ( utility::issharedfuncdefined( #"zombie", #"get_pap_level" ) )
        {
            var_951c89546ec50477 = attacker utility::callsharedfunc( #"zombie", #"get_pap_level", objweapon );
            
            if ( var_951c89546ec50477 > 0 )
            {
                damage *= getdvarfloat( @"hash_9cf7e7a1964e81cc", 0.65 );
            }
        }
        
        if ( isdefined( self.team ) && self.team != "neutral" && isenemyteam( self.team, attacker.team ) )
        {
            var_bda53394c108f2e = getcompleteweaponname( objweapon );
            
            if ( issubstr( var_bda53394c108f2e, "jup_jp22_la_dromeo" ) )
            {
                occupants = vehicle_occupancy::function_8ed9bcd8e9ea74f5( self, 0 );
                
                if ( occupants.size > 0 )
                {
                    ob::function_d77d6c8f2ed70000( 10, attacker );
                }
            }
        }
    }
    
    if ( attacker.var_c0b2e8ebae7fced0 )
    {
        if ( attacker [[ attacker.var_c0b2e8ebae7fced0 ]]( self ) )
        {
            return;
        }
    }
    
    if ( self.var_7316d111af7090c5 )
    {
        if ( self.owner.team == attacker.team )
        {
            return;
        }
    }
    
    damage::callback_vehicledamage( inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname, eventid );
}

// Namespace ob_damage
// Params 1, eflags: 0x4
// Checksum 0x9d076a59, Offset: 0x31e6
// Size: 0x9d
function private function_8bd440fef2c377bf( dmg_struct )
{
    if ( dmg_struct.smeansofdeath == "MOD_CRUSH" && isdefined( dmg_struct.einflictor ) && dmg_struct.einflictor vehicle::is_vehicle() )
    {
        if ( utility::time_has_passed( self.var_18f3fd4230326451 ?? 0, getdvarfloat( @"hash_52fc7da1ba4e9d11", 1 ) ) )
        {
            self.var_18f3fd4230326451 = gettime();
            return dmg_struct.idamage;
        }
        
        self.var_18f3fd4230326451 = gettime();
        return 0;
    }
    
    return dmg_struct.idamage;
}

// Namespace ob_damage
// Params 0, eflags: 0x4
// Checksum 0xc216a6b, Offset: 0x328c
// Size: 0x15, Type: bool
function private function_78483e0471fc768c()
{
    if ( self.health > 90 )
    {
        return true;
    }
    
    return false;
}

// Namespace ob_damage
// Params 2, eflags: 0x4
// Checksum 0x63a8dbee, Offset: 0x32aa
// Size: 0x141, Type: bool
function private function_521e3a9651f4745f( objweapon, eattacker )
{
    if ( isplayer( eattacker ) )
    {
        rarity = eattacker namespace_9d8e359c3b1041e5::getplayerweaponraritysharedfunc( objweapon );
        obsettings = level.var_bb86f77304f193c4;
        
        if ( obsettings && isdefined( rarity ) )
        {
            switch ( rarity )
            {
                case 0:
                    return ( obsettings.var_460d34a62bbac1bb ?? 1 );
                case 1:
                    return ( obsettings.var_448dace96c35cbd2 ?? 1.25 );
                case 2:
                    return ( obsettings.var_404e6c13dae2f5e4 ?? 1.5 );
                case 3:
                    return ( obsettings.var_8284b277999b0053 ?? 1.75 );
                case 4:
                    return ( obsettings.var_738587d51901f61d ?? 2 );
                case 5:
                    return ( obsettings.var_5366b51fd2a111e2 ?? 2.25 );
                case 6:
                    return ( obsettings.var_5366b51fd2a111e2 ?? 2.25 );
            }
        }
    }
    
    return true;
}

// Namespace ob_damage
// Params 1, eflags: 0x4
// Checksum 0x9df73109, Offset: 0x33f4
// Size: 0x1cb
function private function_78c83af1285b73ae( params )
{
    if ( isplayer( params.eattacker ) )
    {
        rarity = params.eattacker namespace_9d8e359c3b1041e5::getplayerweaponraritysharedfunc( params.objweapon );
        obsettings = level.var_bb86f77304f193c4;
        
        if ( obsettings && isdefined( rarity ) )
        {
            switch ( rarity )
            {
                case 0:
                    params.idamage *= obsettings.var_58c02437c15f04 ?? 1;
                    break;
                case 1:
                    params.idamage *= obsettings.var_2ab08888379f9539 ?? 1.05;
                    break;
                case 2:
                    params.idamage *= obsettings.var_8a69e095d3b4b49b ?? 1.1;
                    break;
                case 3:
                    params.idamage *= obsettings.var_f0e343496ca3fdfc ?? 1.15;
                    break;
                case 4:
                    params.idamage *= obsettings.var_607eeaa754af492e ?? 1.2;
                    break;
                case 6:
                    params.idamage *= obsettings.var_1b0268ddc254f269 ?? 1.25;
                    break;
            }
        }
    }
}

// Namespace ob_damage
// Params 11
// Checksum 0x284dc943, Offset: 0x35c7
// Size: 0x166
function function_2020d8f8c3d295a8( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( !instance.health )
    {
        return idamage;
    }
    
    dmg_struct = { #partname:partname, #modelindex:modelindex, #shitloc:"none", #vpoint:vpoint, #vdir:vdir, #objweapon:objweapon, #sweapon:objweapon, #smeansofdeath:smeansofdeath, #idflags:idflags, #idamage:idamage, #instance:instance, #eattacker:eattacker, #einflictor:einflictor };
    idamage = instance zombie_damage::function_cef159ba09a96f98( dmg_struct );
    idamage = instance zombie_damage::function_b9821f08dcbdc9d0( dmg_struct );
    idamage = instance zombie_damage::function_881dfa87252ee0ea( dmg_struct );
    idamage = instance zombie_damage::function_e06f2d26a28d8093( dmg_struct );
    idamage = instance zombie_damage::function_fe961b174c288da0( dmg_struct );
    idamage = instance zombie_damage::function_6da586fdebc81509( dmg_struct );
    idamage = instance zombie_damage::function_eb7d5e5b35444c8b( dmg_struct );
    return idamage;
}

// Namespace ob_damage
// Params 1, eflags: 0x4
// Checksum 0x3e36a656, Offset: 0x3736
// Size: 0xb7, Type: bool
function private function_c2ba2dacbaea351c( params )
{
    issharpshooter = isdefined( self.perks[ "sat_wc_mod_headshot" ] );
    
    if ( issharpshooter )
    {
        var_751ba5b89237eb36 = weapons::weapon_hasperk( "sat_wc_mod_headshot" );
        
        if ( var_751ba5b89237eb36 )
        {
            if ( !isweapon( params.objweapon ) )
            {
                return false;
            }
            
            var_8cff028a994ff9f4 = params.objweapon function_4effdad40704b4c5() ?? [];
            
            if ( !arraycontains( var_8cff028a994ff9f4, "sat_wc_mod_headshot" ) )
            {
                return false;
            }
        }
        
        if ( params.shitloc == "neck" || params.shitloc == "torso_upper" )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace ob_damage
// Params 1, eflags: 0x4
// Checksum 0xd6d07dea, Offset: 0x37f6
// Size: 0x2f
function private registerperks( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "sat_wc_mod_headshot" );
    }
}

// Namespace ob_damage
// Params 14
// Checksum 0x23b73a95, Offset: 0x382d
// Size: 0x90d
function nm_boss_damage( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon, poisedamage )
{
    if ( self.var_a6ecefe6814132d4 )
    {
        return 0;
    }
    
    if ( eattacker.var_bc3aafee8dfa99f5 && isplayer( eattacker.var_bd22ba6c600a23a3 ) && eattacker.var_bd22ba6c600a23a3 utility::callsharedfunc( #"zombie", #"player_has_augment", #"brainrot_plague" ) )
    {
        ai_tier = ai_utility::get_ai_tier();
        
        if ( ai_tier == 2 )
        {
            var_5861616f59906e99 = level.zombie_augments[ #"brainrot_plague" ].var_19e1bcd5e5d7f5fc ?? 0;
        }
        else
        {
            var_5861616f59906e99 = level.zombie_augments[ #"brainrot_plague" ].var_5861616f59906e99 ?? 0;
        }
        
        var_5861616f59906e99 *= 100;
        var_801b8ba167677ba4 = level.gametypebundle.var_a2b029d0cb1a61cc ?? 15;
        var_22ace50f473043a1 = level.var_7c526b990a6af27b < var_801b8ba167677ba4 || var_801b8ba167677ba4 == -1;
        validtarget = ai_tier && ai_tier != 3;
        
        if ( var_22ace50f473043a1 && validtarget && var_5861616f59906e99 > 0 && utility::percent_chance( var_5861616f59906e99 ) )
        {
            if ( utility::callsharedfunc( #"zombie", #"brainrot_zombie", 0, eattacker.var_bd22ba6c600a23a3, undefined, undefined, undefined, undefined, undefined, 1 ) )
            {
                sparams = spawnstruct();
                sparams.ammomod_name = "brainrot";
                sparams.sweapon = sweapon;
                sparams.victim = self;
                eattacker.var_bd22ba6c600a23a3 callback::callback( "ammomod_proc", sparams );
                return 0;
            }
        }
    }
    
    dmg_struct = spawnstruct();
    dmg_struct.einflictor = einflictor;
    dmg_struct.eattacker = eattacker;
    dmg_struct.idamage = idamage;
    dmg_struct.idflags = idflags;
    dmg_struct.smeansofdeath = smeansofdeath;
    dmg_struct.sweapon = sweapon;
    dmg_struct.vpoint = vpoint;
    dmg_struct.vdir = vdir;
    dmg_struct.shitloc = shitloc;
    dmg_struct.timeoffset = timeoffset;
    dmg_struct.modelindex = modelindex;
    dmg_struct.partname = partname;
    dmg_struct.objweapon = objweapon;
    dmg_struct.biscritical = 0;
    dmg_struct.var_4f9d5587bf9a2b1e = 0;
    
    if ( metabone::function_83525a0b05843168() )
    {
        dmg_struct.metabonename = metabone::function_b7f4a00525689bee( dmg_struct );
    }
    else
    {
        dmg_struct.metabonename = metabone::get_metabone_name( shitloc, partname, vpoint, vdir );
        
        if ( !isdefined( dmg_struct.metabonename ) && smeansofdeath == "MOD_EXPLOSIVE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_PROJECTILE_SPLASH" )
        {
            var_d906f3558dfa031f = metabone::function_30d906ccb9fe2142( "Types_Armor" );
            
            if ( var_d906f3558dfa031f.size > 0 )
            {
                dmg_struct.metabonename = utility::array_random( var_d906f3558dfa031f );
            }
        }
    }
    
    if ( metabone::function_3866ce438fcee825() )
    {
        dmg_struct.forcecrit = metabone::function_d985a5fbf5939161( dmg_struct );
    }
    
    if ( isdefined( self.last_dmg_struct ) )
    {
        dmg_struct.num_hits = self.last_dmg_struct.num_hits;
    }
    else
    {
        dmg_struct.num_hits = 0;
    }
    
    dmg_struct.num_hits++;
    var_951c89546ec50477 = 0;
    
    if ( utility::issharedfuncdefined( #"zombie", #"get_pap_level" ) && isplayer( dmg_struct.eattacker ) )
    {
        var_951c89546ec50477 = dmg_struct.eattacker utility::callsharedfunc( #"zombie", #"get_pap_level", dmg_struct.objweapon );
    }
    
    dmg_struct.idamage = function_8bd440fef2c377bf( dmg_struct );
    
    if ( var_951c89546ec50477 >= 1 )
    {
        dmg_struct.idamage /= 2;
    }
    
    if ( dmg_struct.smeansofdeath == "MOD_PROJECTILE" && isdefined( eattacker ) && isdefined( eattacker.var_5234da73eeab6e09 ) )
    {
        dmg_struct.idamage *= eattacker.var_5234da73eeab6e09;
    }
    
    dmg_struct.idamage = function_a84fd8fb924f64d9( dmg_struct );
    dmg_struct.idamage = zombie_damage::function_e01c2c6191f04821( dmg_struct );
    dmg_struct.idamage = function_fd5f6e73cbb5e11( dmg_struct, shitloc, var_951c89546ec50477 );
    
    if ( isplayer( eattacker ) && utility::issharedfuncdefined( #"player", #"hash_b0979c1a1f9ea686" ) )
    {
        var_4346ca48d4b756d8 = eattacker [[ utility::getsharedfunc( #"player", #"hash_b0979c1a1f9ea686" ) ]]( dmg_struct );
        
        if ( var_4346ca48d4b756d8 != -1 )
        {
            dmg_struct.idamage = var_4346ca48d4b756d8;
        }
    }
    
    if ( level.var_37f0dad872bed468 && utility::issharedfuncdefined( #"zombie", #"hash_8a860cb98efd603a" ) )
    {
        dmg_struct.idamage = utility::callsharedfunc( #"zombie", #"hash_8a860cb98efd603a", dmg_struct );
    }
    
    dmg_struct.idamage *= function_dc1ae9a333356966( dmg_struct );
    function_6229eec46b16b31f( level.var_e8f6b03121a2f56d, dmg_struct );
    function_6229eec46b16b31f( self.var_e8f6b03121a2f56d, dmg_struct );
    function_6229eec46b16b31f( dmg_struct.eattacker.var_a6b60fbbf92080ed, dmg_struct );
    final_damage = dmg_struct.idamage;
    dmg_struct.bimmune = final_damage <= 0;
    dmg_struct.var_4f9d5587bf9a2b1e = self.armorhealth > 0 && !dmg_struct.biscritical;
    
    if ( isdefined( eattacker ) && ( isplayer( eattacker ) || isplayer( eattacker.owner ) ) && eattacker.team != self.team )
    {
        eplayer = eattacker;
        var_5e5a2456deacd236 = zombie_damage::get_element( sweapon );
        
        if ( isplayer( eattacker.owner ) )
        {
            eplayer = eattacker.owner;
        }
        
        if ( mp_agent_damage::function_e257c518b45c4dbb() )
        {
            mp_agent_damage::function_eb8ba16055d6da7c( eplayer, self, shitloc, smeansofdeath, sweapon, int( final_damage ), vpoint, dmg_struct.bimmune, var_5e5a2456deacd236, dmg_struct.biscritical, dmg_struct.var_4f9d5587bf9a2b1e, undefined, 0, einflictor );
        }
    }
    
    self.last_dmg_struct = dmg_struct;
    
    if ( isplayer( dmg_struct.eattacker ) && level.gametypebundle.var_451ef421f1fcc5ad )
    {
        ammo_mod::default_ai_response( dmg_struct );
        dmg_struct.var_bd22ba6c600a23a3 = self.var_bd22ba6c600a23a3;
    }
    
    callback::callback( "on_soldier_ai_damaged", dmg_struct );
    
    if ( isdefined( eattacker ) && isdefined( eattacker.is_quest_ai ) )
    {
        var_dda424c349037c52 = 180;
        
        if ( isdefined( final_damage ) )
        {
            final_damage *= var_dda424c349037c52;
        }
    }
    
    if ( self.bhasriotshieldattached && shitloc == "shield" )
    {
        if ( isagent( eattacker ) && eattacker.unittype == "zombie" )
        {
            self.forcehitlocation = "none";
            final_damage *= 0.5;
        }
    }
    
    dmg_struct.idamage = final_damage;
    zombie_damage::try_damage_metabone( dmg_struct );
    
    if ( level.var_6488d1fb560a08fb && ob::nightmare() && ( isplayer( eattacker ) || isplayer( eattacker.owner ) ) )
    {
        final_damage *= getdvarfloat( @"hash_e0e770048a0edc4", level.var_bb86f77304f193c4.var_d257ca6b8f90ea61 ?? 1 );
    }
    
    if ( self.nm_boss && isdefined( self.var_1b5e87bd56ab3e6b ) && isdefined( self.maxhealth ) )
    {
        final_damage = clamp( final_damage, 0, self.maxhealth * self.var_1b5e87bd56ab3e6b );
    }
    
    return int( final_damage );
}

/#

    // Namespace ob_damage
    // Params 0
    // Checksum 0x5de7af0d, Offset: 0x4143
    // Size: 0x51, Type: dev
    function function_48a33238da7cf2f5()
    {
        if ( getdvarint( @"hash_8a8ff6ed00ccc7a", 0 ) )
        {
            setdvar( @"hash_8a8ff6ed00ccc7a", 0 );
        }
        else
        {
            setdvar( @"hash_8a8ff6ed00ccc7a", 1 );
        }
        
        iprintlnbold( "<dev string:xb0>" + getdvarint( @"hash_8a8ff6ed00ccc7a", 0 ) );
    }

    // Namespace ob_damage
    // Params 0
    // Checksum 0x110167de, Offset: 0x419c
    // Size: 0x8e, Type: dev
    function function_4253f4aae0942bb7()
    {
        concatmessage = "<dev string:xcc>";
        
        if ( getdvarint( @"hash_1661f35e34f544eb", 0 ) )
        {
            setdvar( @"hash_1661f35e34f544eb", 0 );
        }
        else
        {
            setdvar( @"hash_1661f35e34f544eb", 1 );
            
            if ( !getdvarint( @"hash_8a8ff6ed00ccc7a", 0 ) )
            {
                setdvar( @"hash_8a8ff6ed00ccc7a", 1 );
                concatmessage = "<dev string:xcd>";
            }
        }
        
        iprintlnbold( concatmessage + "<dev string:xff>" + getdvarint( @"hash_1661f35e34f544eb", 0 ) );
    }

    // Namespace ob_damage
    // Params 0
    // Checksum 0x462d54be, Offset: 0x4232
    // Size: 0x8e, Type: dev
    function function_d2b79b41e04a890a()
    {
        concatmessage = "<dev string:xcc>";
        
        if ( getdvarint( @"hash_5e1b3bfc576b756", 0 ) )
        {
            setdvar( @"hash_5e1b3bfc576b756", 0 );
        }
        else
        {
            setdvar( @"hash_5e1b3bfc576b756", 1 );
            
            if ( !getdvarint( @"hash_8a8ff6ed00ccc7a", 0 ) )
            {
                setdvar( @"hash_8a8ff6ed00ccc7a", 1 );
                concatmessage = "<dev string:xcd>";
            }
        }
        
        iprintlnbold( concatmessage + "<dev string:xff>" + getdvarint( @"hash_1661f35e34f544eb", 0 ) );
    }

    // Namespace ob_damage
    // Params 0
    // Checksum 0xd4340e6, Offset: 0x42c8
    // Size: 0x5d, Type: dev
    function setup_ob_damage_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x121>" );
        devgui::add_devgui_func( "<dev string:x12c>", "<dev string:x14b>", &function_48a33238da7cf2f5, 0 );
        devgui::add_devgui_func( "<dev string:x16a>", "<dev string:x18d>", &function_4253f4aae0942bb7, 0 );
        devgui::add_devgui_func( "<dev string:x1a9>", "<dev string:x1cb>", &function_d2b79b41e04a890a, 0 );
        devgui::function_77df7fe7dd273e10();
    }

#/
