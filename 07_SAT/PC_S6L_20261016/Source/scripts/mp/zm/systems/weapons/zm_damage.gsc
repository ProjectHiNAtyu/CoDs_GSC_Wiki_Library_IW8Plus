// scripts\mp\zm\systems\weapons\zm_damage.gsc  (hash_2af91afcd2ee0028.gscc) (size: 14724 Bytes / 0x3984 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xce14b092 (3457462418)
// size ...... 14724 (0x3984)
// includes .. 17  (offset: 0x3668)
// strings ... 35  (offset: 0x36f0)
// dev strs .. 10  (offset: 0x390c)
// exports ... 22  (offset: 0x2474)
// cseg ...... 0x295 + 0x21df (0x2474)
// imports ... 123 (offset: 0x27e4)
// animtree1 . 0   (offset: 0x3984)
// animtree2 . 0   (offset: 0x3984)
#using scripts\common\ai\aitypes\shared\zombie\zombie_damage;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\game_utility;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\common\weapon;
#using scripts\mp\ammomods\ammo_mod;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\damagefeedback;
#using scripts\mp\events;
#using scripts\mp\mp_agent_damage;

#namespace zm_damage;

// Namespace zm_damage
// Params 0
// Checksum 0xdc9867bb, Offset: 0x2b3
// Size: 0xbd
function init_zm_damage()
{
    level callback::add( "on_zombie_ai_spawned", &zombie_damage_on_spawned );
    level callback::add( "on_agent_spawned", &agent_damage_on_spawned );
    level callback::add( "on_zombie_ai_killed", &on_zombie_ai_killed );
    level callback::add( #"on_ai_killed", &function_9238338f068b6568 );
    scriptable::scriptable_adddamagedcallback( &on_scriptable_damaged );
    level.var_19dac4c03e6cd6cb = "evt_zm_core_zombie_objective_impact";
    level.var_e6d6d55c30c55761 = &function_2020d8f8c3d295a8;
    utility::registersharedfunc( #"damage", #"hash_1962174a5b426182", &vehicle_damage_modifiers );
    utility::registersharedfunc( #"damage", #"hash_537f8ab65c181efd", &function_b9480d70719e3987 );
    
    /#
        level thread function_9dbd516a2db8adde();
    #/
}

// Namespace zm_damage
// Params 1, eflags: 0x4
// Checksum 0xabc75bc7, Offset: 0x378
// Size: 0x2b
function private zombie_damage_on_spawned( params )
{
    self.agent_damage_callback = &function_ddf5f982ca376898;
    callback::add( "on_zombie_ai_damaged", &on_zombie_ai_damaged );
}

// Namespace zm_damage
// Params 1, eflags: 0x4
// Checksum 0x72343e49, Offset: 0x3ab
// Size: 0x76
function private agent_damage_on_spawned( params )
{
    agent = params.agent;
    
    if ( agent.unittype != "soldier" )
    {
        return;
    }
    
    agent.a_n_player_damage = [];
    agent.var_d4b7ed447e2bf50c = [];
    agent.agent_damage_callback = &agent_damage_callback;
    agent callback::add( "on_soldier_ai_damaged", &on_agent_ai_damaged );
}

// Namespace zm_damage
// Params 14
// Checksum 0x99140598, Offset: 0x429
// Size: 0xc2f
function function_ddf5f982ca376898( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon, poisedamage )
{
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
        
        if ( var_5861616f59906e99 > 0 && utility::percent_chance( var_5861616f59906e99 ) && self [[ level.ammo_mods[ "brainrot" ].var_866744e27c70eb1c ]]() && !( self.aicategory == "elite" || self.aicategory == "hvt" ) )
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
    
    if ( self.aicategory === "boss" && isdefined( eattacker.var_7bf6812e0ef8bdc9 ) )
    {
        eattacker.var_7bf6812e0ef8bdc9++;
    }
    
    can_affect = 1;
    
    if ( isplayer( eattacker ) && utility::issharedfuncdefined( #"zm", #"hash_8e5cbc74839b479b" ) )
    {
        can_affect = level [[ utility::getsharedfunc( #"zm", #"hash_8e5cbc74839b479b" ) ]]( eattacker, self );
    }
    
    if ( can_affect )
    {
        dmg_struct.var_5e5a2456deacd236 = zombie_damage::handle_status_effects( dmg_struct );
    }
    
    assert( isdefined( dmg_struct.idamage ) );
    
    if ( zombie_damage::should_skip_damage( eattacker, objweapon, smeansofdeath ) )
    {
        attacker_team = dmg_struct.eattacker.owner.team ?? dmg_struct.eattacker.team;
        
        if ( !dmg_struct.eattacker.allowfriendlyfire && self.team == attacker_team && self.var_43c7f6cb12eee2ee )
        {
            callback::callback( "friendly_zombie_damage", dmg_struct );
        }
        
        if ( isplayer( eattacker ) && self.team != attacker_team )
        {
            if ( self.var_698cf8d8d4a8cbb9 )
            {
                eattacker damagefeedback::updatedamagefeedback( "none" );
            }
            else
            {
                eattacker damagefeedback::updatedamagefeedback( "standard", 0 );
            }
        }
        
        return 0;
    }
    
    if ( self.var_7037157e68c4992b == dmg_struct.idamage )
    {
        dmg_struct.var_d33b5d20cf3b0e9b = 1;
        self.var_7037157e68c4992b = undefined;
    }
    
    dmg_struct.idamage = zombie_damage::function_cef159ba09a96f98( dmg_struct );
    dmg_struct.idamage = zombie_damage::function_40c3998760e0b954( dmg_struct );
    dmg_struct.idamage = zombie_damage::function_e01c2c6191f04821( dmg_struct );
    dmg_struct.idamage = zombie_damage::function_5fc0f527cde63905( dmg_struct );
    dmg_struct.idamage = zombie_damage::function_b9821f08dcbdc9d0( dmg_struct );
    dmg_struct.idamage = zombie_damage::function_881dfa87252ee0ea( dmg_struct );
    dmg_struct.idamage = zombie_damage::function_579261f41dfd0572( dmg_struct );
    dmg_struct.idamage = zombie_damage::function_e20f670a9518dbc0( dmg_struct );
    dmg_struct.idamage = zombie_damage::function_e06f2d26a28d8093( dmg_struct );
    dmg_struct.idamage = zombie_damage::function_fe961b174c288da0( dmg_struct );
    dmg_struct.idamage = zombie_damage::function_6da586fdebc81509( dmg_struct );
    dmg_struct.idamage = zombie_damage::function_87aebf397086e82f( dmg_struct );
    dmg_struct.idamage = zombie_damage::function_920710da910e04e8( dmg_struct );
    dmg_struct.idamage = zombie_damage::function_eb7d5e5b35444c8b( dmg_struct );
    dmg_struct.idamage = zombie_damage::function_a5d75273b1b77ffb( dmg_struct );
    dmg_struct.idamage = zombie_damage::function_e031bc5b6d914320( dmg_struct );
    assert( isdefined( dmg_struct.idamage ) );
    dmg_struct.idamage = zombie_damage::function_23f0f83c55de1ad( dmg_struct );
    
    if ( !isalive( self ) )
    {
        return 0;
    }
    
    if ( isplayer( dmg_struct.eattacker ) )
    {
        ammo_mod::default_ai_response( dmg_struct );
        dmg_struct.var_bd22ba6c600a23a3 = self.var_bd22ba6c600a23a3;
    }
    
    zombie_damage::check_damaged_armor( dmg_struct );
    thread zombie_damage::check_armor_hitmarker( dmg_struct.eattacker, dmg_struct.var_4f9d5587bf9a2b1e, dmg_struct.metabonename );
    zombie_damage::function_40c3998760e0b954( dmg_struct );
    zombie_damage::function_960f65c8626d199b( dmg_struct );
    zombie_damage::function_10e5fc0c6d63f99c( dmg_struct );
    zombie_damage::try_damage_metabone( dmg_struct );
    zombie_damage::function_bccc7eb65bfbb479( dmg_struct );
    zombie_damage::function_1f965cbbc7f5d5e7( dmg_struct );
    zombie_damage::function_f02b21908b7bd90d( dmg_struct );
    
    if ( self.killondamage )
    {
        dmg_struct.idamage = self.health;
    }
    
    zombie_damage::check_critical_kill( dmg_struct );
    dmg_struct.bimmune = dmg_struct.idamage <= 0;
    
    if ( level.var_cdca5e730e05bc39 )
    {
        dmg_struct.bimmune = val::get( "damageshield" );
    }
    
    if ( !val::get( "damage_knockback" ) )
    {
        self.modifiedidflags |= 4;
    }
    
    if ( isdefined( eattacker ) && ( isplayer( eattacker ) || isplayer( eattacker.owner ) ) )
    {
        eplayer = eattacker;
        var_b67d4fdd1ab59745 = undefined;
        var_2783eb34c3422e11 = undefined;
        dmgelement = dmg_struct.var_5e5a2456deacd236;
        
        if ( eplayer.var_525de68277d988e5 )
        {
            dmgelement = eplayer.var_525de68277d988e5;
            eplayer.var_525de68277d988e5 = undefined;
        }
        
        if ( eattacker.classname === "misc_turret" && isplayer( eattacker.occupants[ "gunner" ] ) )
        {
            eplayer = eattacker.occupants[ "gunner" ];
        }
        else if ( isplayer( eattacker.owner ) )
        {
            eplayer = eattacker.owner;
        }
        
        if ( isplayer( eplayer ) )
        {
            if ( isdefined( eplayer.pers[ "participation" ] ) )
            {
                if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( eplayer ) ) )
                {
                    if ( isdefined( eplayer.leaderboarddata[ "participation" ] ) )
                    {
                        eplayer.leaderboarddata[ "participation" ] = eplayer.leaderboarddata[ "participation" ] + 1;
                    }
                    
                    if ( isdefined( level.leaderboardfunc[ "participation" ] ) )
                    {
                        [[ level.leaderboardfunc[ "participation" ] ]]( eplayer, 1 );
                    }
                    
                    assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
                    
                    if ( isdefined( eplayer.pers[ "participation" ] ) )
                    {
                        eplayer.pers[ "participation" ] = eplayer.pers[ "participation" ] + 1;
                    }
                }
            }
            else
            {
                eplayer.pers[ "participation" ] = 1;
            }
        }
        
        if ( isarray( self.elementalweakness ) && isdefined( dmgelement ) )
        {
            var_b67d4fdd1ab59745 = self.elementalweakness[ dmgelement ];
        }
        
        if ( !dmg_struct.var_d20799805edf0194 && mp_agent_damage::function_e7d118eb7b017fa4() )
        {
            mp_agent_damage::function_eb8ba16055d6da7c( eplayer, self, shitloc, smeansofdeath, objweapon, int( dmg_struct.idamage ), vpoint, dmg_struct.bimmune, dmgelement, dmg_struct.biscritical, dmg_struct.var_4f9d5587bf9a2b1e || dmg_struct.bshielded, undefined, 0, einflictor );
        }
        
        if ( isplayer( eattacker ) && dmg_struct.idamage > 0 && shitloc != "shield" && !isdefined( var_2783eb34c3422e11 ) )
        {
            if ( damagefeedback::isusingstackablehitmarker() )
            {
                isbulletdamage = utility::isbulletdamage( smeansofdeath );
                isweaponkillstreak = weapon::iskillstreakweapon( objweapon );
                var_c3b5e08c98a28e3a = isweaponkillstreak && ( eattacker utility::isusingremote() || weapon::function_1344ad15d2d7bd21( objweapon ) );
                var_795e8a31194a39ac = damagefeedback::function_63bdec1d3fd95d25( 0, self, isbulletdamage, objweapon, smeansofdeath == "MOD_EXECUTION", smeansofdeath == "MOD_EXPLOSIVE_BULLET", isweaponkillstreak, var_c3b5e08c98a28e3a );
                var_53656931dee7c08e = 0;
                
                if ( isnullweapon( objweapon ) )
                {
                    var_53656931dee7c08e = 0;
                }
                else
                {
                    var_53656931dee7c08e = weapon::isprimaryweapon( objweapon );
                }
                
                hitmarkercategory = damagefeedback::function_a2c239c0552433dd( eattacker, sweapon, smeansofdeath, isbulletdamage, weapon::iskillstreakweapon( objweapon ), var_53656931dee7c08e, weapon::iswonderweapon( objweapon ), var_c3b5e08c98a28e3a );
                
                if ( self.var_698cf8d8d4a8cbb9 )
                {
                    eattacker damagefeedback::updatedamagefeedback( "none" );
                }
                else
                {
                    eattacker damagefeedback::updatedamagefeedback( "standard", dmg_struct.idamage >= self.health, dmg_struct.biscritical, undefined, undefined, undefined, undefined, undefined, var_795e8a31194a39ac, undefined, undefined, hitmarkercategory );
                }
            }
            else if ( self.var_698cf8d8d4a8cbb9 )
            {
                eattacker damagefeedback::updatedamagefeedback( "none" );
            }
            else
            {
                eattacker damagefeedback::updatedamagefeedback( "standard", dmg_struct.idamage >= self.health );
            }
        }
    }
    
    if ( isdefined( eattacker ) && eattacker vehicle::is_vehicle() )
    {
        eattacker notify( #"hash_7bafb4378d0bb015", self );
    }
    
    self.var_f8128ec93742e435 = self.var_f8128ec93742e435 ? self.var_f8128ec93742e435 + dmg_struct.idamage : dmg_struct.idamage;
    self.last_dmg_struct = dmg_struct;
    callback::callback( "on_zombie_ai_damaged", dmg_struct );
    callback::callback( "on_agent_ai_damaged", dmg_struct );
    return int( dmg_struct.idamage );
}

// Namespace zm_damage
// Params 1, eflags: 0x4
// Checksum 0xe5366e28, Offset: 0x1061
// Size: 0x179
function private on_zombie_ai_damaged( dmg_struct )
{
    if ( isplayer( dmg_struct.eattacker ) && isdefined( self.a_n_player_damage ) )
    {
        self.a_n_player_damage = arraycombineunique( self.a_n_player_damage, [ dmg_struct.eattacker ] );
    }
    
    if ( dmg_struct.eattacker && self.a_n_player_damage && dmg_struct.eattacker vehicle::is_vehicle() && isplayer( dmg_struct.eattacker.occupants[ "driver" ] ) )
    {
        self.a_n_player_damage = arraycombineunique( self.a_n_player_damage, [ dmg_struct.eattacker.occupants[ "driver" ] ] );
    }
    
    if ( isplayer( dmg_struct.eattacker ) && isdefined( self.var_d4b7ed447e2bf50c ) && isdefined( dmg_struct.sweapon ) )
    {
        playernum = dmg_struct.eattacker getentitynumber();
        weapon = dmg_struct.eattacker weapon_utility::function_8097c50c526bd683( dmg_struct.sweapon ) ?? dmg_struct.sweapon;
        self.var_d4b7ed447e2bf50c[ playernum ] = weapon;
    }
    
    vehicle_damage::function_182f0b7ab120aa9b( dmg_struct );
    thread zombie_damage::function_9238df0f5f57170a( dmg_struct );
}

// Namespace zm_damage
// Params 4, eflags: 0x4
// Checksum 0x2b37438b, Offset: 0x11e2
// Size: 0x94, Type: bool
function private get_insta_kill_damage_reduction( vehicle, zombie, bpbundle, vehbundle )
{
    if ( vehicle.owner && vehicle.owner utility::ent_flag( "powerup_insta_kill_active" ) )
    {
        if ( zombie.aicategory == "normal" )
        {
            return ( bpbundle.var_912e17053cb5355b ?? vehbundle.damage.var_912e17053cb5355b ?? 0 );
        }
    }
    
    return false;
}

// Namespace zm_damage
// Params 5, eflags: 0x4
// Checksum 0x6891bde3, Offset: 0x127f
// Size: 0x85
function private vehicle_damage_modifiers( var_8a871acb1f1990b7, vehicle, zombie, var_e2135a579d15e713, vehiclebundledata )
{
    if ( var_e2135a579d15e713.var_c4ad89374f89e4fa < 100 && vehicle isboosting() )
    {
        var_8a871acb1f1990b7 *= var_e2135a579d15e713.var_c4ad89374f89e4fa / 100;
    }
    
    var_912e17053cb5355b = get_insta_kill_damage_reduction( vehicle, zombie, var_e2135a579d15e713, vehiclebundledata );
    var_8a871acb1f1990b7 *= 1 - var_912e17053cb5355b;
    return var_8a871acb1f1990b7;
}

// Namespace zm_damage
// Params 4, eflags: 0x4
// Checksum 0x1a8e9284, Offset: 0x130d
// Size: 0x238
function private function_b9480d70719e3987( vehicle, zombie, bpbundle, vehbundle )
{
    if ( zombie.aicategory == "hvt" )
    {
        if ( zombie.var_698cf8d8d4a8cbb9 )
        {
            var_1889ca0c89277604 = bpbundle.var_fa48302c37050304 ?? vehbundle.damage.var_fa48302c37050304 ?? 0;
        }
        else
        {
            var_1889ca0c89277604 = bpbundle.var_63e605add1ac73ba ?? vehbundle.damage.var_63e605add1ac73ba ?? 0;
        }
    }
    else if ( zombie.aicategory == "normal" )
    {
        if ( zombie.var_698cf8d8d4a8cbb9 )
        {
            var_1889ca0c89277604 = bpbundle.var_64b24ab0b2b62645 ?? vehbundle.damage.var_64b24ab0b2b62645 ?? 0;
        }
        else
        {
            var_1889ca0c89277604 = bpbundle.var_629984d018f37877 ?? vehbundle.damage.var_629984d018f37877 ?? 0;
        }
    }
    else if ( zombie.aicategory == "special" )
    {
        if ( zombie.var_698cf8d8d4a8cbb9 )
        {
            var_1889ca0c89277604 = bpbundle.var_51958896b0e42223 ?? vehbundle.damage.var_51958896b0e42223 ?? 0;
        }
        else
        {
            var_1889ca0c89277604 = bpbundle.var_67ee6478ec16e55d ?? vehbundle.damage.var_67ee6478ec16e55d ?? 0;
        }
    }
    else if ( zombie.aicategory == "elite" )
    {
        if ( zombie.var_698cf8d8d4a8cbb9 )
        {
            var_1889ca0c89277604 = bpbundle.var_5eeb3e9d4656cc4f ?? vehbundle.damage.var_5eeb3e9d4656cc4f ?? 0;
        }
        else
        {
            var_1889ca0c89277604 = bpbundle.var_c628f12f50dc18e1 ?? vehbundle.damage.var_c628f12f50dc18e1 ?? 0;
        }
    }
    
    return var_1889ca0c89277604;
}

// Namespace zm_damage
// Params 1, eflags: 0x4
// Checksum 0xe14a621c, Offset: 0x154e
// Size: 0x89
function private on_zombie_ai_killed( params )
{
    playerattacker = params.eattacker;
    
    if ( isdefined( playerattacker ) && !isplayer( playerattacker ) && isplayer( playerattacker.owner ) )
    {
        playerattacker = playerattacker.owner;
    }
    
    if ( !isplayer( playerattacker ) )
    {
        return;
    }
    
    update_kills( playerattacker, params.einflictor, params.objweapon, params.smeansofdeath );
}

// Namespace zm_damage
// Params 4
// Checksum 0xad245a3b, Offset: 0x15df
// Size: 0x71
function update_kills( playerattacker, einflictor, objweapon, smeansofdeath )
{
    if ( !isplayer( playerattacker ) || self.var_4ed7db6a0182ca99 )
    {
        return;
    }
    
    playerattacker stats::function_ee7ea2a7c2c198f3();
    playerattacker thread mp_agent_damage::updaterecentagentkills( self, einflictor, objweapon );
    
    if ( isdefined( objweapon ) )
    {
        events::function_6c7ad7001bc34550( objweapon, smeansofdeath, einflictor );
    }
    
    self.var_4ed7db6a0182ca99 = 1;
}

// Namespace zm_damage
// Params 14
// Checksum 0xa8ffef8, Offset: 0x1658
// Size: 0x533
function agent_damage_callback( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon, poisedamage )
{
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
    dmg_struct.timehit = gettime();
    
    if ( isdefined( self.last_dmg_struct ) )
    {
        dmg_struct.num_hits = self.last_dmg_struct.num_hits;
    }
    else
    {
        dmg_struct.num_hits = 0;
    }
    
    dmg_struct.num_hits++;
    final_damage = dmg_struct.idamage;
    
    if ( isarray( level.var_e8f6b03121a2f56d ) )
    {
        foreach ( func in level.var_e8f6b03121a2f56d )
        {
            new_damage = self [[ func ]]( dmg_struct );
            
            if ( new_damage != -1 )
            {
                final_damage = new_damage;
            }
        }
    }
    
    if ( dmg_struct.eattacker.var_81dcc244c7c4591e )
    {
        dmg_struct.eattacker.var_81dcc244c7c4591e = undefined;
        
        if ( self.aicategory != "boss" )
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
            
            if ( isdefined( var_ea007afa6a78065 ) )
            {
                var_25ebc911e358603c = dmg_struct.idamage * ( var_ea007afa6a78065 - 1 );
                final_damage = dmg_struct.idamage + var_25ebc911e358603c;
            }
        }
    }
    
    dmg_struct.idamage = final_damage;
    dmg_struct.bimmune = dmg_struct.idamage <= 0;
    
    if ( isplayer( dmg_struct.eattacker ) && dmg_struct.idamage >= 0 && dmg_struct.shitloc != "shield" )
    {
        if ( dmg_struct.shitloc == "head" || dmg_struct.shitloc == "helmet" || dmg_struct.shitloc == "neck" )
        {
            dmg_struct.biscritical = 1;
        }
        
        if ( !dmg_struct.var_e221bd97b44a30c6 )
        {
            dmg_struct.eattacker damagefeedback::updatedamagefeedback( "standard", dmg_struct.idamage >= self.health, dmg_struct.biscritical );
        }
        
        if ( !self.doinglongdeath && !dmg_struct.var_d20799805edf0194 && mp_agent_damage::function_e257c518b45c4dbb() )
        {
            mp_agent_damage::function_eb8ba16055d6da7c( dmg_struct.eattacker, self, dmg_struct.shitloc, dmg_struct.smeansofdeath, dmg_struct.sweapon, int( dmg_struct.idamage ), dmg_struct.vpoint, dmg_struct.bimmune, dmg_struct.var_5e5a2456deacd236, dmg_struct.biscritical, dmg_struct.var_4f9d5587bf9a2b1e );
        }
    }
    
    self.last_dmg_struct = dmg_struct;
    
    if ( isplayer( dmg_struct.eattacker ) && level.gametypebundle.var_451ef421f1fcc5ad )
    {
        ammo_mod::default_ai_response( dmg_struct );
        dmg_struct.var_bd22ba6c600a23a3 = self.var_bd22ba6c600a23a3;
    }
    
    callback::callback( "on_soldier_ai_damaged", dmg_struct );
    callback::callback( "on_agent_ai_damaged", dmg_struct );
    return int( final_damage );
}

// Namespace zm_damage
// Params 1, eflags: 0x4
// Checksum 0x12966649, Offset: 0x1b94
// Size: 0xde
function private on_agent_ai_damaged( dmg_struct )
{
    if ( isplayer( dmg_struct.eattacker ) && isdefined( self.a_n_player_damage ) )
    {
        self.a_n_player_damage = arraycombineunique( self.a_n_player_damage, [ dmg_struct.eattacker ] );
    }
    
    if ( isplayer( dmg_struct.eattacker ) && isdefined( self.var_d4b7ed447e2bf50c ) && isdefined( dmg_struct.sweapon ) )
    {
        playernum = dmg_struct.eattacker getentitynumber();
        weapon = dmg_struct.eattacker weapon_utility::function_8097c50c526bd683( dmg_struct.sweapon ) ?? dmg_struct.sweapon;
        self.var_d4b7ed447e2bf50c[ playernum ] = weapon;
    }
}

// Namespace zm_damage
// Params 1, eflags: 0x4
// Checksum 0x9d162124, Offset: 0x1c7a
// Size: 0x13
function private function_9238338f068b6568( params )
{
    game_utility_common::removefromcharactersarray();
}

// Namespace zm_damage
// Params 2
// Checksum 0x82a14838, Offset: 0x1c95
// Size: 0x53
function register_scriptable_damage_callback( func, var_af70f02bb9462edd )
{
    if ( !isdefined( self.var_4f006656feac822d ) )
    {
        self.var_4f006656feac822d = [];
    }
    
    self.var_4f006656feac822d[ self.var_4f006656feac822d.size ] = func;
    
    if ( isdefined( var_af70f02bb9462edd ) )
    {
        self.var_af70f02bb9462edd = var_af70f02bb9462edd;
    }
}

// Namespace zm_damage
// Params 2
// Checksum 0x62d7b91, Offset: 0x1cf0
// Size: 0x4d
function function_c31f9d79d5ceb7ec( func, var_af70f02bb9462edd )
{
    if ( isdefined( var_af70f02bb9462edd ) )
    {
        self.var_af70f02bb9462edd = var_af70f02bb9462edd;
    }
    
    if ( !isdefined( self.var_4f006656feac822d ) )
    {
        return;
    }
    
    self.var_4f006656feac822d = arrayremove( self.var_4f006656feac822d, func );
}

// Namespace zm_damage
// Params 1, eflags: 0x4
// Checksum 0xb911d244, Offset: 0x1d45
// Size: 0xc1
function private function_4a51e3a9b7f9ab58( dmg_struct )
{
    if ( isarray( self.var_4f006656feac822d ) )
    {
        for ( var_1cc7f3cdaac35cf7 = 0; var_1cc7f3cdaac35cf7 < self.var_4f006656feac822d.size ; var_1cc7f3cdaac35cf7++ )
        {
            func = self.var_4f006656feac822d[ var_1cc7f3cdaac35cf7 ];
            profilestart();
            new_damage = self [[ func ]]( dmg_struct );
            profilestop();
            assert( isdefined( new_damage ) );
            
            if ( isdefined( new_damage ) && new_damage != -1 )
            {
                dmg_struct.idamage = new_damage;
                dmg_struct.bimmune = new_damage <= 0;
                dmg_struct.killingblow = dmg_struct.idamage >= self.health;
            }
        }
    }
}

// Namespace zm_damage
// Params 11, eflags: 0x4
// Checksum 0x9445bbf, Offset: 0x1e0e
// Size: 0x356
function private on_scriptable_damaged( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    profilestart();
    
    if ( !isdefined( instance ) || !instance.var_af70f02bb9462edd )
    {
        profilestop();
        return;
    }
    
    if ( isai( eattacker ) && instance.attractor )
    {
        profilestop();
        return;
    }
    
    hashealth = isdefined( instance.health );
    
    if ( hashealth && instance.health <= 0 )
    {
        profilestop();
        return;
    }
    
    shitloc = "none";
    timeoffset = undefined;
    dmg_struct = instance zombie_damage::build_damage_struct( einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon );
    dmg_struct.bimmune = dmg_struct.idamage <= 0;
    dmg_struct.killingblow = hashealth && dmg_struct.idamage >= instance.health;
    dmg_struct.instance = instance;
    dmg_struct.var_5e5a2456deacd236 = instance zombie_damage::get_element( dmg_struct.objweapon, dmg_struct.eattacker, dmg_struct.smeansofdeath, dmg_struct.einflictor );
    instance function_4a51e3a9b7f9ab58( dmg_struct );
    isbulletdamage = utility::isbulletdamage( dmg_struct.smeansofdeath );
    hitmarkercategory = instance.ihittype ?? 3;
    var_795e8a31194a39ac = damagefeedback::function_63bdec1d3fd95d25( 0, undefined, isbulletdamage, dmg_struct.objweapon );
    
    if ( !instance.var_436fc13baa7377d8 )
    {
        mp_agent_damage::function_eb8ba16055d6da7c( dmg_struct.eattacker, dmg_struct.instance, dmg_struct.shitloc, dmg_struct.smeansofdeath, dmg_struct.objweapon, int( dmg_struct.idamage ), dmg_struct.vpoint, dmg_struct.bimmune, dmg_struct.var_5e5a2456deacd236, dmg_struct.biscritical, dmg_struct.var_4f9d5587bf9a2b1e );
    }
    
    if ( !instance.var_18d4007b123c953a )
    {
        eattacker damagefeedback::updatedamagefeedback( !dmg_struct.bimmune ? "standard" : "hitspawnprotect", dmg_struct.killingblow, dmg_struct.biscritical, undefined, 0, 1, undefined, undefined, var_795e8a31194a39ac, undefined, undefined, hitmarkercategory );
    }
    
    if ( hashealth && !dmg_struct.bimmune )
    {
        if ( dmg_struct.killingblow )
        {
            instance.health = 0;
            instance.var_af70f02bb9462edd = 0;
            instance callback::callback( #"hash_11e40a4909e138f7", dmg_struct );
        }
        else
        {
            instance.health -= dmg_struct.idamage;
        }
    }
    
    profilestop();
}

// Namespace zm_damage
// Params 11
// Checksum 0x93d734d, Offset: 0x216c
// Size: 0x1ca
function function_2020d8f8c3d295a8( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( !instance.health )
    {
        return idamage;
    }
    
    dmg_struct = { #partname:partname, #modelindex:modelindex, #shitloc:"none", #vpoint:vpoint, #vdir:vdir, #objweapon:objweapon, #sweapon:objweapon, #smeansofdeath:smeansofdeath, #idflags:idflags, #idamage:idamage, #instance:instance, #eattacker:eattacker, #einflictor:einflictor };
    dmg_struct.idamage = instance zombie_damage::function_cef159ba09a96f98( dmg_struct );
    dmg_struct.idamage = instance zombie_damage::function_b9821f08dcbdc9d0( dmg_struct );
    dmg_struct.idamage = instance zombie_damage::function_881dfa87252ee0ea( dmg_struct );
    dmg_struct.idamage = instance zombie_damage::function_e06f2d26a28d8093( dmg_struct );
    dmg_struct.idamage = instance zombie_damage::function_fe961b174c288da0( dmg_struct );
    dmg_struct.idamage = instance zombie_damage::function_6da586fdebc81509( dmg_struct );
    dmg_struct.idamage = instance zombie_damage::function_eb7d5e5b35444c8b( dmg_struct );
    dmg_struct.idamage = instance zombie_damage::function_e031bc5b6d914320( dmg_struct );
    return dmg_struct.idamage;
}

/#

    // Namespace zm_damage
    // Params 0
    // Checksum 0x686a53b3, Offset: 0x233f
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
        
        iprintlnbold( "<dev string:x4a>" + getdvarint( @"hash_8a8ff6ed00ccc7a", 0 ) );
    }

    // Namespace zm_damage
    // Params 0
    // Checksum 0x248c9b60, Offset: 0x2398
    // Size: 0x8e, Type: dev
    function function_4253f4aae0942bb7()
    {
        concatmessage = "<dev string:x66>";
        
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
                concatmessage = "<dev string:x67>";
            }
        }
        
        iprintlnbold( concatmessage + "<dev string:x99>" + getdvarint( @"hash_1661f35e34f544eb", 0 ) );
    }

    // Namespace zm_damage
    // Params 0
    // Checksum 0x1f89d53, Offset: 0x242e
    // Size: 0x46, Type: dev
    function function_9dbd516a2db8adde()
    {
        devgui::function_9082edeb5db93280( "<dev string:xbb>" );
        devgui::add_devgui_func( "<dev string:xc6>", "<dev string:xe5>", &function_48a33238da7cf2f5, 0 );
        devgui::add_devgui_func( "<dev string:x104>", "<dev string:x127>", &function_4253f4aae0942bb7, 0 );
        devgui::function_77df7fe7dd273e10();
    }

#/
