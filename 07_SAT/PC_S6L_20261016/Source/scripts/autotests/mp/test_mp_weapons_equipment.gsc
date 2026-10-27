// scripts\autotests\mp\test_mp_weapons_equipment.gsc  (hash_1f5d6ccba1be6a10.gscc) (size: 10229 Bytes / 0x27f5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa6e76e39 (2800184889)
// size ...... 10229 (0x27f5)
// includes .. 8   (offset: 0x2525)
// strings ... 34  (offset: 0x2565)
// dev strs .. 1   (offset: 0x27e9)
// exports ... 9   (offset: 0x1bf5)
// cseg ...... 0x691 + 0x1564 (0x1bf5)
// imports ... 58  (offset: 0x1d5d)
// animtree1 . 0   (offset: 0x27f5)
// animtree2 . 0   (offset: 0x27f5)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility;
#using scripts\autotests\autotests_utility_bot;
#using scripts\autotests\autotests_utility_player;
#using scripts\autotests\mp\autotests_utility_equipment;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\weapon;

#namespace test_mp_weapons_equipment;

// Namespace test_mp_weapons_equipment/testautomation
// Params 0, eflags: 0x20
// Checksum 0x20686e80, Offset: 0x6af
// Size: 0x2b
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/mp/test_mp_weapons_equipment.gsc", #"GP", &start_test, &setup, &cleanup, &parameterize );
}

// Namespace test_mp_weapons_equipment
// Params 1, eflags: 0x4
// Checksum 0xa4abfaf8, Offset: 0x6e2
// Size: 0x16f
function private parameterize( datasets )
{
    bundle = autotests::function_41b85fc97bb5520( self.xhash_ref, [ #"hash_26a53ae0d3069ce6" ] );
    var_44ae89c28d292902 = [];
    
    foreach ( entry in bundle.var_e8141e846094fb55 )
    {
        var_44ae89c28d292902[ var_44ae89c28d292902.size ] = entry.ref;
    }
    
    var_53ea5266bdf0d85c = autotests_utility_equipment::function_d7fbf95af74b10e9( 1 );
    equipmentlist = [];
    
    foreach ( equipment in var_53ea5266bdf0d85c )
    {
        if ( arraycontains( var_44ae89c28d292902, equipment.ref ) )
        {
            continue;
        }
        
        equipmentlist[ equipmentlist.size ] = equipment.ref;
    }
    
    return equipmentlist;
}

// Namespace test_mp_weapons_equipment
// Params 0, eflags: 0x4
// Checksum 0x80507df, Offset: 0x85a
// Size: 0x13f
function private setup()
{
    autotests::function_5c8c87763724c132();
    player = autotests_utility_player::get_player();
    bundle = autotests::get_test_bundle( self.test.xhash_ref );
    
    if ( bundle.var_a8f94423d23cf0c0 )
    {
        testposition = autotests::get_struct_location( bundle.var_a8f94423d23cf0c0 );
        
        if ( testposition )
        {
            player setorigin( testposition );
        }
    }
    
    player function_ffb0711adb6d8d0d();
    player function_3a7598d6982eb648( 1 );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player is autopiloted?", isautopilot( player ), "scripts/autotests/mp/test_mp_weapons_equipment.gsc", 70 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    if ( !isingodmode( player ) )
    {
        autotests_utility_bot::set_bot_godmode( player, 1 );
    }
    
    isareaclear = player autotests_utility_player::function_d870458bee177685( 600 );
    autotests::function_d84657f448aaeef6( "Bots have space to execute the test", isareaclear, "scripts/autotests/mp/test_mp_weapons_equipment.gsc", 78 );
    level autotests_utility::function_4104f641c0755805( "smoke_grenade_explode", "smoke_exploded" );
    level.autotests.test_runtime.trace_contents = trace::create_contents( 0, 1 );
    return 1;
}

// Namespace test_mp_weapons_equipment
// Params 0, eflags: 0x4
// Checksum 0x7c99d033, Offset: 0x9a2
// Size: 0x18d
function private start_test()
{
    autotests_utility_bot::kick_all_bots();
    equipmentref = self.parameters[ 0 ];
    equipmentinfo = weapon::getequipmenttableinfo( equipmentref );
    player = autotests_utility_player::get_player();
    botdata = autotests_utility_bot::get_spawn_data( player, 350 );
    victim = autotests_utility_bot::function_978126f411fc8a11( player, botdata );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Could spawn victim?", isdefined( victim ), "scripts/autotests/mp/test_mp_weapons_equipment.gsc", 98 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    level.var_a5ecc4fd7d64db7b = 1;
    victim.maxhealth = 30000;
    victim.health = 30000;
    
    if ( equipmentinfo.bundle.uislot == 1 )
    {
        autotests::push_function( "Test Lethal" );
        test_result_int = test_lethal( player, victim, equipmentref, equipmentinfo ) ?? 0;
        test_result_int = autotests::function_e496a326e5d58a25( "Test Lethal", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_weapons_equipment.gsc", 107 );
        autotests::pop_function( "Test Lethal" );
        autotests::test_assert_return( test_result_int );
        return;
    }
    
    autotests::push_function( "Test Tactical" );
    test_result_int = test_tactical( player, victim, equipmentref, equipmentinfo ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Test Tactical", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_weapons_equipment.gsc", 111 );
    autotests::pop_function( "Test Tactical" );
    autotests::test_assert_return( test_result_int );
}

// Namespace test_mp_weapons_equipment
// Params 0, eflags: 0x4
// Checksum 0xadbd2795, Offset: 0xb37
// Size: 0x5e
function private cleanup()
{
    level.autotests.test_runtime.trace_contents = undefined;
    level autotests_utility::flag_remove_callback( "smoke_grenade_explode", "smoke_exploded" );
    player = autotests_utility_player::get_player();
    player playerexitautopilotmode();
    
    /#
        adddebugcommand( "<dev string:x24>" );
    #/
    
    autotests_utility_bot::kick_all_bots();
}

// Namespace test_mp_weapons_equipment
// Params 4, eflags: 0x4
// Checksum 0x19746c90, Offset: 0xb9d
// Size: 0x73f
function private test_tactical( attacker, victim, tacticalref, tacticalinfo )
{
    wait 2;
    targetangles = vectortoangles( victim.origin - attacker.origin );
    attacker setplayerangles( targetangles );
    var_c2a0cb458265c177 = vectortoangles( attacker.origin - victim.origin );
    victim setplayerangles( var_c2a0cb458265c177 );
    wait 2;
    previoushealth = victim.health;
    attacker utility::callsharedfunc( #"equipment", #"hash_54e1244070e4625c", tacticalref, tacticalinfo.defaultslot );
    
    switch ( tacticalref )
    {
        case #"hash_ceedbacc35c97d2d":
        case #"hash_ebc1610b1d4c8600":
        case #"hash_fb6b649176cec75d":
            attacker thread function_b4d4aa53d12b00cd( victim.origin );
            attacker botpressbutton( "tactical", 0.5 );
            grenadethrown = autotests::test_wait_any( "Tactical Equipment " + tacticalref + " used.", attacker, [ "grenade_thrown" ], 5, "scripts/autotests/mp/test_mp_weapons_equipment.gsc", 146 );
            
            if ( grenadethrown == 0 && tacticalinfo.bundle.smokeduration )
            {
                autotests_utility::flag_wait_or_timeout( "smoke_exploded", tacticalinfo.bundle.smokeduration + 1 );
                autotests_utility::flag_clear( "smoke_exploded" );
                autotests::function_d84657f448aaeef6( tacticalref + " Is in smoke? ", victim.var_ac6830fc9a3124c2, "scripts/autotests/mp/test_mp_weapons_equipment.gsc", 151 );
            }
            
            break;
        case #"hash_15d06a7d7efafe8":
        case #"hash_624488e9d0fe3d5":
        case #"hash_4b4a6458f00d9319":
        case #"hash_4f62b5fa00ecd075":
        case #"hash_7c09786dbc292c05":
        case #"hash_7ea1ab46382caf60":
        case #"hash_cb91f9b79f3d4771":
        case #"hash_cbcb2b145327e750":
        case #"hash_eb1d3d54e9981d38":
        case #"hash_f7e0c96ebdd8316b":
            attacker autotests_utility_bot::function_aaa2288bee31d766( "tactical", 1, 0.5 );
            autotests::function_d84657f448aaeef6( "Tactical Equipment " + tacticalref + " used.", 1, "scripts/autotests/mp/test_mp_weapons_equipment.gsc", 166 );
            break;
        case #"hash_5a562592c930b7d6":
            attacker thread function_b4d4aa53d12b00cd( victim.origin );
            attacker autotests_utility_bot::function_aaa2288bee31d766( "tactical", 1, 0.5 );
            wait 2 + getgrenadefusetime( tacticalinfo.objweapon ) / 1000;
            autotests::function_d84657f448aaeef6( "Tactical Equipment " + tacticalref, victim.var_54dfc5a46377bb64, "scripts/autotests/mp/test_mp_weapons_equipment.gsc", 173 );
            endhealth = victim.health;
            damagedone = previoushealth - endhealth;
            autotests::function_e4e4ff06e5a9c612( tacticalref + " Thrown Damage Done? " + damagedone, endhealth, previoushealth, "scripts/autotests/mp/test_mp_weapons_equipment.gsc", 176 );
            break;
        case #"hash_8df9cfc147eb2d86":
            attacker autotests_utility_bot::function_aaa2288bee31d766( "tactical", 1, 0.5 );
            wait 1;
            isshocked = victim.ishaywire;
            autotests::function_d84657f448aaeef6( "Tactical Equipment " + tacticalref, isshocked, "scripts/autotests/mp/test_mp_weapons_equipment.gsc", 183 );
            break;
        case #"hash_5fca4943a78ace9c":
            attacker thread function_b4d4aa53d12b00cd( victim.origin );
            attacker autotests_utility_bot::function_aaa2288bee31d766( "tactical", 1, 0.5 );
            wait 1.5;
            endhealth = victim.health;
            damagedone = previoushealth - endhealth;
            var_287229dcba61bff = isdefined( victim.var_ce186c9e315d6ed3 ) && victim.var_ce186c9e315d6ed3.attackers.size > 0;
            autotests::function_e4e4ff06e5a9c612( tacticalref + " Thrown Damage Done? " + damagedone, endhealth, previoushealth, "scripts/autotests/mp/test_mp_weapons_equipment.gsc", 194 );
            var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Concussion Attacker Exists", var_287229dcba61bff, "scripts/autotests/mp/test_mp_weapons_equipment.gsc", 195 );
            
            if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
            {
                if ( autotests::function_561cb32cd7469145() )
                {
                    return;
                }
                
                autotests::test_assert_return( var_63a718d91714219d );
            }
            
            break;
        case #"hash_25ac81b822cf0c9f":
            attacker autotests_utility_bot::function_aaa2288bee31d766( "tactical", 1, 0.5 );
            autotests::function_d84657f448aaeef6( "Tactical Equipment " + tacticalref, isdefined( attacker.var_2bee526696230275[ #"adrenaline_used_recently" ] ), "scripts/autotests/mp/test_mp_weapons_equipment.gsc", 200 );
            break;
        case #"hash_c848458cca24d656":
            attacker autotests_utility_bot::function_aaa2288bee31d766( "tactical", 1, 0.5 );
            var_3a48647337b421ea = attacker.health;
            victim utility::callsharedfunc( #"equipment", #"hash_54e1244070e4625c", "equip_frag", "primary" );
            wait 1;
            victim autotests_utility_bot::function_aaa2288bee31d766( "lethal", 1, 0.5 );
            wait 2.5;
            var_d2b203612aad2594 = attacker.health;
            damagedone = var_3a48647337b421ea - var_d2b203612aad2594;
            autotests::function_e50d1006e5d65c04( "Did the trophy eat the grenade? Damage Done: " + damagedone, var_d2b203612aad2594, var_3a48647337b421ea, "scripts/autotests/mp/test_mp_weapons_equipment.gsc", 212 );
            
            foreach ( grenade in level.grenades )
            {
                if ( grenade.equipmentref == "equip_trophy" && grenade.deletefunc )
                {
                    grenade [[ grenade.deletefunc ]]();
                    break;
                }
            }
            
            break;
        case #"hash_7167aaa91a5449a8":
            wait 2;
            var_767f791facec25b3 = victim getplayerangles();
            victimangles = vectortoangles( attacker.origin - victim.origin );
            victim setplayerangles( victimangles );
            attacker autotests_utility_bot::function_aaa2288bee31d766( "tactical", 1, 0.5 );
            wait 1.5;
            victim autotests_utility_bot::enable_movement();
            victim utility::callsharedfunc( #"bots", #"hash_af78c5b5a80e13b4", victimangles[ 1 ], 2, 1 );
            wait 2.7;
            victim autotests_utility_bot::disable_movement();
            endhealth = victim.health;
            damagedone = previoushealth - endhealth;
            autotests::function_e4e4ff06e5a9c612( tacticalref + " Mine Damage Done? " + damagedone, endhealth, previoushealth, "scripts/autotests/mp/test_mp_weapons_equipment.gsc", 240 );
            attackerangles = attacker getplayerangles();
            victim autotests_utility_player::set_player_location( attacker, 400, anglestoforward( attackerangles ) );
            victim setplayerangles( var_767f791facec25b3 );
            wait 2;
            break;
        default:
            autotests::function_d84657f448aaeef6( "Tactical Equipment " + tacticalref + " not setup to test", 0, "scripts/autotests/mp/test_mp_weapons_equipment.gsc", 249 );
            break;
    }
    
    victim.maxhealth = 30000;
    victim.health = 30000;
}

// Namespace test_mp_weapons_equipment
// Params 4, eflags: 0x4
// Checksum 0x9cc1a972, Offset: 0x12e4
// Size: 0x816
function private test_lethal( attacker, victim, lethalref, lethalinfo )
{
    wait 1;
    var_bee7e796d508ca76 = 0;
    victim.maxhealth = 30000;
    victim.health = 30000;
    targetangles = vectortoangles( victim.origin - attacker.origin );
    attacker setplayerangles( targetangles );
    previoushealth = victim.health;
    var_aad5d011ba543738 = 0;
    var_e5e0575a28a5f901 = 0;
    attacker utility::callsharedfunc( #"equipment", #"hash_54e1244070e4625c", lethalref, lethalinfo.defaultslot );
    
    switch ( lethalref )
    {
        case #"hash_142a787e36d7d7ce":
            var_bee7e796d508ca76 = lethalinfo.bundle.var_797382a688d68a64 ?? 6.75;
        case #"hash_311ee0f6295873c1":
        case #"hash_8c7819f0a3fbd1e0":
            if ( lethalref == "equip_thermobaric_grenade" )
            {
                var_e5e0575a28a5f901 = lethalinfo.bundle.var_e8e1c3a4ebc685cc ?? 0;
                var_e5e0575a28a5f901 += lethalinfo.bundle.var_62deefeb30d8595 ?? 0;
            }
            
            attacker thread function_b4d4aa53d12b00cd( victim.origin );
            var_aad5d011ba543738 = 1;
        case #"hash_d3a6dc7f9c517e66":
        case #"hash_f0907f858c134cb4":
            if ( !var_aad5d011ba543738 )
            {
                attacker thread function_b4d4aa53d12b00cd( victim.origin, ( 0, 20, 100 ) );
            }
        case #"hash_4333e52016aa489b":
            attacker botpressbutton( "lethal", 0.5 );
            fusetime = getgrenadefusetime( lethalinfo.objweapon ) / 1000;
            var_d6e9778e6b9b6d1a = autotests::test_wait_any( "Damage notification received?", victim, [ "damage" ], fusetime + var_e5e0575a28a5f901 + 2, "scripts/autotests/mp/test_mp_weapons_equipment.gsc", 297 );
            
            if ( var_d6e9778e6b9b6d1a == 0 )
            {
                endhealth = victim.health;
                damagedone = previoushealth - endhealth;
                autotests::function_e4e4ff06e5a9c612( lethalref + " Grenade Damage Done? " + damagedone, endhealth, previoushealth, "scripts/autotests/mp/test_mp_weapons_equipment.gsc", 302 );
            }
            
            break;
        case #"hash_3d4f7c9eccbce5e9":
        case #"hash_6fffe6ec011433ee":
        case #"hash_e156752cb79526e8":
            attacker autotests_utility_bot::function_aaa2288bee31d766( "lethal", 1, 0.5 );
            wait 1.5;
            endhealth = victim.health;
            damagedone = previoushealth - endhealth;
            autotests::function_e4e4ff06e5a9c612( lethalref + " Bunkerbuster Grenade Damage Done? " + damagedone, endhealth, previoushealth, "scripts/autotests/mp/test_mp_weapons_equipment.gsc", 313 );
            break;
        case #"hash_a825dc92f843028d":
            break;
        case #"hash_de4641ddbc44a7ba":
            if ( lethalinfo.bundle.thermite_tickcount && lethalinfo.bundle.thermite_tickinterval )
            {
                var_bee7e796d508ca76 = lethalinfo.bundle.thermite_tickcount * lethalinfo.bundle.thermite_tickinterval;
            }
        case #"hash_3923e5c5f4d1f90a":
        case #"hash_887c4c23176973ac":
        case #"hash_8e25c36b6bb38855":
        case #"hash_909e215cf9938b03":
        case #"hash_9ba0a6ff6081954e":
        case #"hash_c018a696dcbb53a8":
        case #"hash_caac46279c95dce3":
            wait 0.5;
            attacker autotests_utility_bot::function_aaa2288bee31d766( "lethal", 1, 0.5 );
            wait 0.25;
            endhealth = victim.health;
            damagedone = previoushealth - endhealth;
            autotests::function_e4e4ff06e5a9c612( lethalref + " throwable Damage Done? " + damagedone, endhealth, previoushealth, "scripts/autotests/mp/test_mp_weapons_equipment.gsc", 338 );
            break;
        case #"hash_15c765aa76e58c8a":
        case #"hash_2354208d9af64220":
        case #"hash_3995658e01f4fac1":
        case #"hash_4b6ab8d07b349016":
        case #"hash_94584bc84d5262fb":
            wait 2;
            var_767f791facec25b3 = victim getplayerangles();
            victimangles = vectortoangles( attacker.origin - victim.origin );
            victim setplayerangles( victimangles );
            attacker utility::callsharedfunc( #"equipment", #"hash_54e1244070e4625c", lethalref, lethalinfo.defaultslot );
            attacker autotests_utility_bot::function_aaa2288bee31d766( "lethal", 1, 0.5 );
            wait 1.5;
            victim autotests_utility_bot::enable_movement();
            victim utility::callsharedfunc( #"bots", #"hash_af78c5b5a80e13b4", victimangles[ 1 ], 2, 1 );
            wait 2.7;
            victim autotests_utility_bot::disable_movement();
            endhealth = victim.health;
            damagedone = previoushealth - endhealth;
            autotests::function_e4e4ff06e5a9c612( lethalref + " Mine Damage Done? " + damagedone, endhealth, previoushealth, "scripts/autotests/mp/test_mp_weapons_equipment.gsc", 363 );
            botangles = attacker getplayerangles();
            victim autotests_utility_player::set_player_location( attacker, 400, anglestoforward( botangles ) );
            victim setplayerangles( var_767f791facec25b3 );
            wait 2;
            break;
        case #"hash_3a18c38d0a34894d":
        case #"hash_3bc98c382ef38bfc":
            wait 2;
            var_767f791facec25b3 = victim getplayerangles();
            victimangles = vectortoangles( attacker.origin - victim.origin );
            victim setplayerangles( victimangles );
            targetangles = vectortoangles( victim.origin - attacker.origin );
            attacker setplayerangles( targetangles + ( 15, -10, 0 ) );
            attacker utility::callsharedfunc( #"equipment", #"hash_54e1244070e4625c", lethalref, lethalinfo.defaultslot );
            attacker autotests_utility_bot::function_aaa2288bee31d766( "lethal", 1, 0.5 );
            wait 1.5;
            attacker setplayerangles( targetangles + ( 15, 10, 0 ) );
            attacker autotests_utility_bot::function_aaa2288bee31d766( "lethal", 1, 0.5 );
            victim autotests_utility_bot::enable_movement();
            wait 1.5;
            victim utility::callsharedfunc( #"bots", #"hash_af78c5b5a80e13b4", victimangles[ 1 ], 2, 1 );
            wait 2.7;
            victim autotests_utility_bot::disable_movement();
            endhealth = victim.health;
            damagedone = previoushealth - endhealth;
            autotests::function_e4e4ff06e5a9c612( lethalref + " Mine Damage Done? " + damagedone, endhealth, previoushealth, "scripts/autotests/mp/test_mp_weapons_equipment.gsc", 395 );
            botangles = attacker getplayerangles();
            victim autotests_utility_player::set_player_location( attacker, 400, anglestoforward( botangles ) );
            victim setplayerangles( var_767f791facec25b3 );
            wait 2;
            break;
        case #"hash_4320d77f90725183":
            attacker thread function_b4d4aa53d12b00cd( victim.origin, ( 0, 20, 100 ) );
            attacker autotests_utility_bot::function_aaa2288bee31d766( "lethal", 1, 0.5 );
            wait 1.5;
            
            if ( lethalinfo.bundle.var_73c1e67728a7b727 )
            {
                attacker autotests_utility_bot::function_aaa2288bee31d766( "use", 0.35, 0.25 );
                attacker autotests_utility_bot::function_aaa2288bee31d766( "use", 0.35, 0.25 );
            }
            else
            {
                attacker autotests_utility_bot::function_aaa2288bee31d766( "detonate_offhand", 1, 0.5 );
            }
            
            wait 0.5;
            endhealth = victim.health;
            damagedone = previoushealth - endhealth;
            autotests::function_e4e4ff06e5a9c612( lethalref + " throwable Damage Done? " + damagedone, endhealth, previoushealth, "scripts/autotests/mp/test_mp_weapons_equipment.gsc", 420 );
            break;
        default:
            autotests::function_d84657f448aaeef6( "Lethal Equipment " + lethalref + " not setup to test", 0, "scripts/autotests/mp/test_mp_weapons_equipment.gsc", 424 );
            break;
    }
    
    victim.maxhealth = 30000;
    victim.health = 30000;
    
    if ( var_bee7e796d508ca76 > 0 )
    {
        wait var_bee7e796d508ca76;
    }
}

// Namespace test_mp_weapons_equipment
// Params 2, eflags: 0x4
// Checksum 0xa353abe6, Offset: 0x1b02
// Size: 0xf3
function private function_b4d4aa53d12b00cd( location, offset )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self waittill( #"grenade_fire", grenade, objweapon, tickpercent, originalowner );
    position = location;
    
    if ( offset )
    {
        position += offset;
    }
    else
    {
        trace = trace::ray_trace( position + ( 0, 0, 50 ), position - ( 0, 0, 50 ), self, level.autotests.test_runtime.trace_contents );
        
        if ( trace[ "hittype" ] == "hittype_world" )
        {
            position = trace[ "position" ];
        }
    }
    
    grenade.origin = position;
}

