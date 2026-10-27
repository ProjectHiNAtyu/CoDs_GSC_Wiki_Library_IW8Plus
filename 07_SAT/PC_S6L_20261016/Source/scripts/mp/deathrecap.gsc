// scripts\mp\deathrecap.gsc  (hash_509c5820f3608253.gscc) (size: 19459 Bytes / 0x4c03 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x40ca4ce9 (1086999785)
// size ...... 19459 (0x4c03)
// includes .. 6   (offset: 0x4a4f)
// strings ... 9   (offset: 0x4a7f)
// dev strs .. 14  (offset: 0x4b5b)
// exports ... 59  (offset: 0x344b)
// cseg ...... 0x125 + 0x3326 (0x344b)
// imports ... 91  (offset: 0x3d83)
// animtree1 . 0   (offset: 0x4c03)
// animtree2 . 0   (offset: 0x4c03)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_assassination_quest;
#using scripts\mp\common\utility\teams;

#namespace deathrecap;

// Namespace deathrecap
// Params 0, eflags: 0x5
// Checksum 0x3739e6d6, Offset: 0x143
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"deathrecap", undefined, undefined, &post_main );
}

// Namespace deathrecap
// Params 0
// Checksum 0x4ae5854f, Offset: 0x164
// Size: 0x72c
function function_16354e0a1318fede()
{
    level.attackerfunctions = [];
    level.attackerfunctions[ %"hash_3ff4eebd453506ea" ] = &function_67802b153747d6a5;
    level.attackerfunctions[ %"hash_7b481be28ab2f279" ] = &function_bda5c1633b02cb20;
    level.attackerfunctions[ %"hash_760d886b8c16d53f" ] = &function_e4e7fe71c5c1cd4e;
    level.attackerfunctions[ %"hash_54577a1f18fb283" ] = &function_d7f731572d6bd2f6;
    level.attackerfunctions[ %"hash_57187a1f1b5089e" ] = &function_d7f731572d6bd2f6;
    level.attackerfunctions[ %"hash_7633264406c5f537" ] = &function_ce5c32994cbd7b06;
    level.attackerfunctions[ %"hash_fe74683b21d478c" ] = &function_c163a22b89e06fef;
    level.attackerfunctions[ %"hash_6b2a69a5991f1873" ] = &function_52620a90e6609006;
    level.attackerfunctions[ %"hash_2fe26a0c520f7749" ] = &function_4dc19e4512e9bb83;
    level.attackerfunctions[ %"hash_2fca7e0c51fb0764" ] = &function_4dc19e4512e9bb83;
    level.attackerfunctions[ %"hash_1c958294e410a1c5" ] = &function_72bb0bc4ed23689d;
    level.attackerfunctions[ %"hash_2f1633c1fe5d9f6f" ] = &function_bd77e53e17b03eb2;
    level.attackerfunctions[ %"hash_51b974f7caca4ac2" ] = &function_852d6be72e0fba7d;
    level.attackerfunctions[ %"hash_16e0db7094d92d31" ] = &function_aad393efbd2d17e4;
    level.attackerfunctions[ %"hash_71cd649c8e87972b" ] = &function_c0e44c19a0a95c3c;
    level.attackerfunctions[ %"hash_40ca6bcb62aceb1d" ] = &function_e715efe234f5cd5b;
    level.attackerfunctions[ %"hash_4528e77cbe4b7b3" ] = &function_e715efe234f5cd5b;
    level.attackerfunctions[ %"hash_3d6c5a4f8373cccf" ] = &function_4b7d21f2c0f8d197;
    level.attackerfunctions[ %"hash_6cb19f70e6c2d04b" ] = &function_f802289d12650b75;
    level.attackerfunctions[ %"hash_521282289396bc83" ] = &function_d8522d2797845519;
    level.attackerfunctions[ %"hash_523e922893bc129e" ] = &function_d8522d2797845519;
    level.attackerfunctions[ %"hash_1cf19419a52894a5" ] = &function_6887bc3d59fe8a2c;
    level.attackerfunctions[ %"hash_1cf49819a52ad148" ] = &function_6887bc3d59fe8a2c;
    level.attackerfunctions[ %"hash_70bfd464697aac8d" ] = &function_6695f97df8e74502;
    level.attackerfunctions[ %"hash_61ae60d4110ed5a1" ] = &function_35efc1c4714718cc;
    level.attackerfunctions[ %"hash_225e9d08aa48e5f2" ] = &function_434ee6f46ae3f926;
    level.attackerfunctions[ %"hash_223fa508aa2e42fb" ] = &function_434ee6f46ae3f926;
    level.attackerfunctions[ %"hash_18975f6cf1dad77b" ] = &function_254ccd47fbe7a8ac;
    level.attackerfunctions[ %"hash_3949b791605b5119" ] = &function_254ccd47fbe7a8ac;
    level.attackerfunctions[ %"hash_b070a687aa242fa" ] = &function_b765a34a47426c86;
    level.attackerfunctions[ %"hash_b1ef2687ab6ac13" ] = &function_b765a34a47426c86;
    level.attackerfunctions[ %"hash_6aceda93bdace719" ] = &function_d85c856932e877e7;
    level.attackerfunctions[ %"hash_6ab7ee93bd9a2a34" ] = &function_d85c856932e877e7;
    level.attackerfunctions[ %"hash_4f462b8e1b79598b" ] = &function_ec990d15ac09cb6c;
    level.attackerfunctions[ %"hash_542331161fb84c89" ] = &function_ec990d15ac09cb6c;
    level.attackerfunctions[ %"hash_4df1777afe7f8507" ] = &function_6f58e3c0f4bc7616;
    level.attackerfunctions[ %"hash_645329b8b1dcc409" ] = &function_c6c16478e0bdc558;
    level.attackerfunctions[ %"hash_6c22eb4c354a2de4" ] = &function_a12c96ac754cab65;
    level.attackerfunctions[ %"hash_57b5150ef2af2a26" ] = &function_c025b76158d5a3ae;
    level.attackerfunctions[ %"hash_61cd67b8ac0980c2" ] = &function_284f0ea5cd70d448;
    level.attackerfunctions[ %"hash_41dec24b046e8b39" ] = &function_51f52c988695792a;
    level.attackerfunctions[ %"hash_42f0e74a8182e8e3" ] = &function_9ae0044993035c06;
    level.attackerfunctions[ %"hash_c20f4f8af78f1be" ] = &function_301a49b13dc0b937;
    level.attackerfunctions[ %"hash_daf2720fb90db5e" ] = &function_301a49b13dc0b937;
    level.attackerfunctions[ %"hash_77fe1ad96c01bdd7" ] = &function_fe0a1ea95adc4400;
    level.attackerfunctions[ %"hash_59e2926d979e1951" ] = &function_c3406c5cb68185cf;
    level.attackerfunctions[ %"hash_6f35cd7ffae8c1db" ] = &function_3890f46f8634e609;
    level.attackerfunctions[ %"hash_6f2bbd7ffae05226" ] = &function_3890f46f8634e609;
    level.attackerfunctions[ %"hash_41015053ae830dd6" ] = &function_d8b06d21d4d5cd31;
    level.attackerfunctions[ %"hash_41346853aeae9037" ] = &function_d8b06d21d4d5cd31;
    level.attackerfunctions[ %"hash_512d380690025c77" ] = &function_ea5ac7c76e0272b6;
    level.attackerfunctions[ %"hash_57b486ac71b3bdfa" ] = &function_ddc9076256fa4f62;
    level.victimfunctions = [];
    level.victimfunctions[ %"hash_6a9f770ac890dc3a" ] = &function_7423a68dae8d2f97;
    level.victimfunctions[ %"hash_1e2b9b3577e14962" ] = &function_82f0e2c3dab4c885;
    level.victimfunctions[ %"hash_429191cbd1ae192c" ] = &function_135d61a245c5194e;
    level.victimfunctions[ %"hash_10c17896305916f9" ] = &function_48c4bed69647eb4d;
    level.victimfunctions[ %"hash_1b5484676c589d40" ] = &function_496d9f3575d35521;
    level.victimfunctions[ %"hash_2eac16dc07338028" ] = &function_e46b9e19b8e9835b;
    level.victimfunctions[ %"hash_3b390fbd1d483bb" ] = &function_613b3dca722730c1;
    level.victimfunctions[ %"hash_bf121f39dcb2df2" ] = &function_ecfa49b6f3a49d2d;
    bundleref = isbrgamemode() ? %"hash_631f261d39053aac" : %"hash_1008778b264177a0";
    listbundle = getscriptbundle( bundleref );
    var_d522c8edab91ad2b = [];
    
    if ( listbundle )
    {
        var_d522c8edab91ad2b = listbundle.var_de6774e195462c7d;
    }
    
    foreach ( item in var_d522c8edab91ad2b )
    {
        if ( !item.entry )
        {
            continue;
        }
        
        entrybundle = getscriptbundle( item.entry );
        
        if ( entrybundle )
        {
            if ( !level.attackerfunctions[ item.entry ] && !level.victimfunctions[ item.entry ] )
            {
                continue;
            }
            
            level.var_eb394b32ded4b5eb[ item.entry ] = entrybundle;
        }
    }
}

// Namespace deathrecap
// Params 2
// Checksum 0xb68e8c92, Offset: 0x898
// Size: 0x3b
function function_243d45bcade5e4ac( victim, killer )
{
    if ( isbrgamemode() || level.ismp )
    {
        function_16354e0a1318fede();
        function_b783e1eae2c7bdd4( victim, killer );
        return;
    }
}

// Namespace deathrecap
// Params 2
// Checksum 0x66d3a86f, Offset: 0x8db
// Size: 0x2e5
function function_b783e1eae2c7bdd4( victim, killer )
{
    /#
        if ( victim.attackers.size == 0 )
        {
            victim.attackers = [ killer ];
        }
    #/
    
    if ( !isdefined( victim.attackers ) )
    {
        self setclientomnvar( "death_recap_info", 0 );
        return;
    }
    
    if ( !isdefined( level.var_d5b10dc202a8af5b ) )
    {
        level.var_d5b10dc202a8af5b = function_6b6757bad86024f4();
    }
    
    var_57cd28ac2991d1e7 = 0;
    
    foreach ( attacker in victim.attackers )
    {
        if ( function_aba878ee2a652bb2( victim, attacker ) )
        {
            continue;
        }
        
        foreach ( key in getarraykeys( level.var_eb394b32ded4b5eb ) )
        {
            if ( !level.attackerfunctions[ key ] )
            {
                continue;
            }
            
            item = level.var_eb394b32ded4b5eb[ key ];
            bitmask = item.bitmask - 1;
            var_1373848dd05b736a = 1 << bitmask;
            
            if ( bitmask >= 0 && !( var_57cd28ac2991d1e7 & var_1373848dd05b736a ) && [[ level.attackerfunctions[ key ] ]]( victim, attacker ) )
            {
                var_57cd28ac2991d1e7 |= var_1373848dd05b736a;
            }
        }
    }
    
    foreach ( key in getarraykeys( level.var_eb394b32ded4b5eb ) )
    {
        if ( !level.victimfunctions[ key ] )
        {
            continue;
        }
        
        item = level.var_eb394b32ded4b5eb[ key ];
        bitmask = item.bitmask - 1;
        var_1373848dd05b736a = 1 << bitmask;
        
        if ( bitmask >= 0 && !( var_57cd28ac2991d1e7 & var_1373848dd05b736a ) && [[ level.victimfunctions[ key ] ]]( victim ) )
        {
            var_57cd28ac2991d1e7 |= var_1373848dd05b736a;
        }
    }
    
    self setclientomnvar( "death_recap_info", var_57cd28ac2991d1e7 );
    
    /#
        if ( getdvarint( @"hash_87258a7acfd6fc6f", 0 ) == 1 )
        {
            function_260a6bb00f5e30b6( victim, var_57cd28ac2991d1e7 );
        }
    #/
}

// Namespace deathrecap
// Params 0
// Checksum 0x81858066, Offset: 0xbc8
// Size: 0x5d
function post_main()
{
    /#
        if ( getdvarint( @"hash_8df77c9b4d81fd0f", 0 ) == 0 && level.projectbundle.var_7b672c8455ce7ff1 == 1 && getdvarint( @"hash_3d2c809947e15af8", 0 ) == 1 )
        {
            level callback::add( #"player_spawned", &initdevgui );
        }
    #/
}

/#

    // Namespace deathrecap
    // Params 1
    // Checksum 0x12aba3ce, Offset: 0xc2d
    // Size: 0xc4, Type: dev
    function initdevgui( params )
    {
        players = level.players;
        
        for ( i = 0; i < players.size ; i++ )
        {
            player = players[ i ];
            devgui::add_devgui_command( "<dev string:x24>" + player.name, "<dev string:x45>" + player getentitynumber(), i );
            devgui::add_devgui_command( "<dev string:x9c>" + player.name, "<dev string:xbf>" + player getentitynumber(), i );
            devgui::add_devgui_command( "<dev string:x118>" + player.name, "<dev string:x13a>" + player getentitynumber(), i );
        }
        
        thread function_e30972f634b99a12();
    }

#/

// Namespace deathrecap
// Params 0
// Checksum 0xd7f4a431, Offset: 0xcf9
// Size: 0x4b9
function function_e30972f634b99a12()
{
    if ( !isdefined( level.var_f9b768232998984c[ "players_victim" ] ) )
    {
        level.var_f9b768232998984c[ "players_victim" ] = [];
        level.var_f9b768232998984c[ "players_attacker" ] = [];
    }
    
    while ( true )
    {
        var_ea004557879376bb = getdvarint( @"hash_e4e35f5d5c5721fb", -1 );
        
        if ( var_ea004557879376bb != -1 && !arraycontains( level.var_f9b768232998984c[ "players_victim" ], var_ea004557879376bb ) )
        {
            level.var_f9b768232998984c[ "players_victim" ][ level.var_f9b768232998984c[ "players_victim" ].size ] = var_ea004557879376bb;
            player = getentbynum( var_ea004557879376bb );
            player setclientomnvar( "ui_combat_report_num_attackers", 1 );
            setdvar( @"hash_e4e35f5d5c5721fb", -1 );
        }
        
        var_e727a8150731a1f8 = getdvarint( @"hash_cd59dfb38c6e2738", -1 );
        
        if ( var_e727a8150731a1f8 != -1 && !arraycontains( level.var_f9b768232998984c[ "players_attacker" ], var_e727a8150731a1f8 ) )
        {
            level.var_f9b768232998984c[ "players_attacker" ][ level.var_f9b768232998984c[ "players_attacker" ].size ] = var_e727a8150731a1f8;
            player = getentbynum( var_e727a8150731a1f8 );
            player setclientomnvar( "ui_combat_report_num_attackers", 1 );
            setdvar( @"hash_cd59dfb38c6e2738", -1 );
        }
        
        var_8ea78c13bb4b0005 = getdvarint( @"hash_5734536d1ccdfd6a", -1 );
        
        if ( var_8ea78c13bb4b0005 != -1 )
        {
            level.var_f9b768232998984c[ "players_attacker" ] = arrayremove( level.var_f9b768232998984c[ "players_attacker" ], var_8ea78c13bb4b0005 );
            level.var_f9b768232998984c[ "players_victim" ] = arrayremove( level.var_f9b768232998984c[ "players_victim" ], var_8ea78c13bb4b0005 );
            player = getentbynum( var_8ea78c13bb4b0005 );
            player setclientomnvar( "ui_combat_report_num_attackers", 0 );
            player setclientomnvar( "death_recap_info", 0 );
            setdvar( @"hash_5734536d1ccdfd6a", -1 );
        }
        
        foreach ( entnum in level.var_f9b768232998984c[ "players_victim" ] )
        {
            player = getentbynum( entnum );
            enemies = teams::getenemyplayers( player.team, 1 );
            closestdistance = 9999999;
            
            if ( player )
            {
                foreach ( enemy in enemies )
                {
                    var_852f36b89008d0a8 = distance2dsquared( player.origin, enemy.origin );
                    
                    if ( var_852f36b89008d0a8 < closestdistance && var_852f36b89008d0a8 > 1000 )
                    {
                        closestdistance = var_852f36b89008d0a8;
                        var_ca7b5e5ee6b1fcf3 = enemy;
                    }
                }
                
                if ( isdefined( var_ca7b5e5ee6b1fcf3 ) )
                {
                    player.deathtime = gettime();
                    player function_243d45bcade5e4ac( player, var_ca7b5e5ee6b1fcf3 );
                }
            }
        }
        
        foreach ( entnum in level.var_f9b768232998984c[ "players_attacker" ] )
        {
            player = getentbynum( entnum );
            enemies = teams::getenemyplayers( player.team, 1 );
            closestdistance = 99999;
            
            if ( player )
            {
                foreach ( enemy in enemies )
                {
                    var_852f36b89008d0a8 = distance2dsquared( player.origin, enemy.origin );
                    
                    if ( var_852f36b89008d0a8 < closestdistance && var_852f36b89008d0a8 > 1000 )
                    {
                        closestdistance = var_852f36b89008d0a8;
                        var_ca7b5e5ee6b1fcf3 = enemy;
                    }
                }
                
                if ( isdefined( var_ca7b5e5ee6b1fcf3 ) )
                {
                    var_ca7b5e5ee6b1fcf3.deathtime = gettime();
                    player function_243d45bcade5e4ac( var_ca7b5e5ee6b1fcf3, player );
                }
            }
        }
        
        wait 1;
    }
}

/#

    // Namespace deathrecap
    // Params 2
    // Checksum 0x523def5c, Offset: 0x11ba
    // Size: 0x1ff, Type: dev
    function function_260a6bb00f5e30b6( victim, var_66f80d0a5aaa693e )
    {
        attackers = "<dev string:x18f>";
        
        if ( isarray( victim.attackers ) )
        {
            foreach ( attacker in victim.attackers )
            {
                if ( isplayer( attacker ) && isdefined( attacker.name ) )
                {
                    attackers += attacker.name + "<dev string:x190>";
                }
            }
        }
        
        println( "<dev string:x192>" );
        
        if ( isdefined( victim.name ) )
        {
            println( "<dev string:x1d2>" + victim.name );
        }
        
        println( "<dev string:x1db>" + attackers );
        
        foreach ( key in getarraykeys( level.var_eb394b32ded4b5eb ) )
        {
            item = level.var_eb394b32ded4b5eb[ key ];
            bitmask = item.bitmask - 1;
            var_1373848dd05b736a = 1 << bitmask;
            println( item.devname + "<dev string:x1ef>" + istrue( var_66f80d0a5aaa693e & var_1373848dd05b736a ) );
        }
        
        println( "<dev string:x1f3>" + level.var_d5b10dc202a8af5b );
        println( "<dev string:x204>" );
    }

#/

// Namespace deathrecap
// Params 2, eflags: 0x4
// Checksum 0xbc0f14d2, Offset: 0x13c1
// Size: 0x58, Type: bool
function private function_aba878ee2a652bb2( victim, attacker )
{
    if ( attacker == victim )
    {
        return true;
    }
    
    if ( !isplayer( attacker ) || !isplayer( victim ) )
    {
        return true;
    }
    
    if ( attacker.gulag && victim.gulag )
    {
        return true;
    }
    
    return false;
}

// Namespace deathrecap
// Params 2, eflags: 0x4
// Checksum 0x8c74cb03, Offset: 0x1422
// Size: 0x40, Type: bool
function private function_591e05f330495a83( player, perkname )
{
    if ( isdefined( player.perks[ perkname ] ) )
    {
        return true;
    }
    
    if ( isdefined( player.var_fbdf9e00e56b1f10[ perkname ] ) )
    {
        return true;
    }
    
    return false;
}

// Namespace deathrecap
// Params 0, eflags: 0x4
// Checksum 0x90777ded, Offset: 0x146b
// Size: 0x34
function private function_6b6757bad86024f4()
{
    if ( isbrgamemode() )
    {
        return ( 7000 + getdvarint( @"hash_e2bd8c245d5a3e27", 4000 ) );
    }
    
    return 7000 + getdvarint( @"hash_e25c82245cef3caf", 0 );
}

// Namespace deathrecap
// Params 2, eflags: 0x4
// Checksum 0x80c6cf6d, Offset: 0x14a7
// Size: 0xa8, Type: bool
function private function_d8522d2797845519( victim, attacker )
{
    /#
        if ( getdvarint( @"hash_291d62d41ec18184", 0 ) == 1 )
        {
            return true;
        }
    #/
    
    if ( getdvarint( @"hash_46b01899848fd043", 0 ) == 1 )
    {
        return false;
    }
    
    if ( !isdefined( victim.var_72e7e9c4c9473c04 ) || !isdefined( victim.var_72e7e9c4c9473c04[ attacker.team ] ) )
    {
        return false;
    }
    
    if ( victim.var_72e7e9c4c9473c04[ attacker.team ] > victim.deathtime - level.var_d5b10dc202a8af5b )
    {
        return true;
    }
    
    return false;
}

// Namespace deathrecap
// Params 2, eflags: 0x4
// Checksum 0xb4ec1fa0, Offset: 0x1558
// Size: 0xc1
function private function_ec990d15ac09cb6c( victim, attacker )
{
    /#
        if ( getdvarint( @"hash_86d933a37d97fb01", 0 ) == 1 )
        {
            return 1;
        }
    #/
    
    if ( getdvarint( @"hash_69f2e56e023a7782", 0 ) == 1 )
    {
        return 0;
    }
    
    if ( function_591e05f330495a83( victim, "specialty_coldblooded" ) )
    {
        return 0;
    }
    
    if ( !isdefined( victim.var_829239c4c3a4a64 ) || !isdefined( victim.var_829239c4c3a4a64[ attacker.team ] ) )
    {
        return 0;
    }
    
    var_ff7e3242af643b49 = victim.var_829239c4c3a4a64[ attacker.team ] > victim.deathtime - level.var_d5b10dc202a8af5b;
    return var_ff7e3242af643b49;
}

// Namespace deathrecap
// Params 2, eflags: 0x4
// Checksum 0xde6bc56e, Offset: 0x1622
// Size: 0xc5, Type: bool
function private function_d8b06d21d4d5cd31( victim, attacker )
{
    /#
        if ( getdvarint( @"hash_65c4087c278a63db", 0 ) == 1 )
        {
            return true;
        }
    #/
    
    if ( getdvarint( @"hash_5b162c6288b0b1fc", 0 ) == 1 )
    {
        return false;
    }
    
    if ( function_591e05f330495a83( victim, "specialty_br_ghost" ) || function_591e05f330495a83( victim, "specialty_ghost" ) )
    {
        return false;
    }
    
    if ( !isdefined( level.var_ae09cd9b35c30f63 ) || !isdefined( level.var_ae09cd9b35c30f63[ attacker.team ] ) )
    {
        return false;
    }
    
    if ( level.var_ae09cd9b35c30f63[ attacker.team ] > victim.deathtime - level.var_d5b10dc202a8af5b )
    {
        return true;
    }
    
    return false;
}

// Namespace deathrecap
// Params 2, eflags: 0x4
// Checksum 0x3f82717c, Offset: 0x16f0
// Size: 0xa2, Type: bool
function private function_d7f731572d6bd2f6( victim, attacker )
{
    /#
        if ( getdvarint( @"hash_bc809e369deb19bc", 0 ) == 1 )
        {
            return true;
        }
    #/
    
    if ( !isdefined( level.var_6b5444dcdd38ca18 ) || !isdefined( level.var_6b5444dcdd38ca18[ attacker.team ] ) )
    {
        return false;
    }
    
    if ( getdvarint( @"hash_862675cd7d117765", 0 ) == 1 )
    {
        return false;
    }
    
    if ( level.var_6b5444dcdd38ca18[ attacker.team ] > victim.deathtime - level.var_d5b10dc202a8af5b )
    {
        return true;
    }
    
    return false;
}

// Namespace deathrecap
// Params 2, eflags: 0x4
// Checksum 0xe2f37e52, Offset: 0x179b
// Size: 0x10f
function private function_ea5ac7c76e0272b6( victim, attacker )
{
    /#
        if ( getdvarint( @"hash_5ae879d76b47fc21", 0 ) == 1 )
        {
            return 1;
        }
    #/
    
    if ( function_591e05f330495a83( victim, "specialty_ghost" ) || function_591e05f330495a83( victim, "specialty_br_ghost" ) )
    {
        return 0;
    }
    
    if ( !isdefined( attacker.var_43fc4e9032b52638 ) || !isdefined( attacker.var_b448d58f0f40f9a8 ) || !isdefined( attacker.var_f5cbb7e69e156fec ) )
    {
        return 0;
    }
    
    var_88c70e278cbab1f7 = distance2dsquared( attacker.var_f5cbb7e69e156fec, victim.origin ) <= attacker.var_b448d58f0f40f9a8 * attacker.var_b448d58f0f40f9a8;
    
    if ( !var_88c70e278cbab1f7 )
    {
        return 0;
    }
    
    if ( getdvarint( @"hash_8d09b92c4029fc5e", 0 ) == 1 )
    {
        return 0;
    }
    
    var_ea5ac7c76e0272b6 = attacker.var_43fc4e9032b52638 > victim.deathtime - level.var_d5b10dc202a8af5b;
    return var_ea5ac7c76e0272b6;
}

// Namespace deathrecap
// Params 1, eflags: 0x4
// Checksum 0x358cedf0, Offset: 0x18b3
// Size: 0x8d
function private function_135d61a245c5194e( victim )
{
    /#
        if ( getdvarint( @"hash_d58892f662e47226", 0 ) == 1 )
        {
            return 1;
        }
    #/
    
    if ( !isdefined( victim.var_5a4003bfe509b071 ) )
    {
        return 0;
    }
    
    if ( getdvarint( @"hash_d6fd41585ed36ee9", 0 ) == 1 )
    {
        return 0;
    }
    
    var_135d61a245c5194e = victim.var_5a4003bfe509b071 > victim.deathtime - level.var_d5b10dc202a8af5b;
    
    if ( var_135d61a245c5194e )
    {
        victim.var_5a4003bfe509b071 = undefined;
    }
    
    return var_135d61a245c5194e;
}

// Namespace deathrecap
// Params 2, eflags: 0x4
// Checksum 0xf1aeab16, Offset: 0x1949
// Size: 0x9d, Type: bool
function private function_52620a90e6609006( victim, attacker )
{
    /#
        if ( getdvarint( @"hash_da3bc68fc54be0fd", 0 ) == 1 )
        {
            return true;
        }
    #/
    
    if ( getdvarint( @"hash_edcf8a955750df56", 0 ) == 1 )
    {
        return false;
    }
    
    if ( br_assassination_quest::function_a63112a0f410ccf7( victim, attacker ) )
    {
        return true;
    }
    
    if ( victim.var_5cb861c1a2f605e5[ attacker.team ] )
    {
        return ( victim.var_5cb861c1a2f605e5[ attacker.team ] > victim.deathtime - level.var_d5b10dc202a8af5b );
    }
    
    return false;
}

// Namespace deathrecap
// Params 1, eflags: 0x4
// Checksum 0x490217df, Offset: 0x19ef
// Size: 0x8b, Type: bool
function private function_48c4bed69647eb4d( victim )
{
    /#
        if ( getdvarint( @"hash_5dc71a3e0cf02464", 0 ) == 1 )
        {
            return true;
        }
    #/
    
    if ( getdvarint( @"hash_c1f049d2ae72f37f", 0 ) == 1 )
    {
        return false;
    }
    
    if ( victim.var_48c4bed69647eb4d )
    {
        victim.var_48c4bed69647eb4d = undefined;
        return true;
    }
    
    if ( victim.var_da9e389e6db488d9 > victim.deathtime - level.var_d5b10dc202a8af5b )
    {
        victim.var_da9e389e6db488d9 = undefined;
        return true;
    }
    
    return false;
}

// Namespace deathrecap
// Params 2, eflags: 0x4
// Checksum 0xcec297c4, Offset: 0x1a83
// Size: 0xc5, Type: bool
function private function_3890f46f8634e609( victim, attacker )
{
    /#
        if ( getdvarint( @"hash_49bbe79f483a7c6c", 0 ) == 1 )
        {
            return true;
        }
    #/
    
    if ( function_c3406c5cb68185cf( victim, attacker ) )
    {
        return false;
    }
    
    if ( function_f802289d12650b75( victim, attacker ) )
    {
        return true;
    }
    
    if ( !isdefined( victim.var_96ea52dc3dbcbb6e ) || !isdefined( victim.var_96ea52dc3dbcbb6e[ attacker.team ] ) )
    {
        return false;
    }
    
    if ( getdvarint( @"hash_9a8c46e9a2f392e1", 0 ) == 1 )
    {
        return false;
    }
    
    if ( victim.var_96ea52dc3dbcbb6e[ attacker.team ] > victim.deathtime - level.var_d5b10dc202a8af5b )
    {
        return true;
    }
    
    return false;
}

// Namespace deathrecap
// Params 2, eflags: 0x4
// Checksum 0xf98a114c, Offset: 0x1b51
// Size: 0xbc, Type: bool
function private function_bda5c1633b02cb20( victim, attacker )
{
    /#
        if ( getdvarint( @"hash_9b634113dda17fe2", 0 ) == 1 )
        {
            return true;
        }
    #/
    
    var_dec36ab35413b4ef = victim.entnum ?? utility::get_entity_number( victim );
    
    if ( !isdefined( attacker.var_7c63335769f9511f ) || !isdefined( attacker.var_7c63335769f9511f[ var_dec36ab35413b4ef ] ) )
    {
        return false;
    }
    
    if ( getdvarint( @"hash_44748dcf48a89fed", 0 ) == 1 )
    {
        return false;
    }
    
    if ( attacker.var_7c63335769f9511f[ var_dec36ab35413b4ef ] + 1000 > victim.deathtime - level.var_d5b10dc202a8af5b )
    {
        return true;
    }
    
    return false;
}

// Namespace deathrecap
// Params 2, eflags: 0x4
// Checksum 0x75b15277, Offset: 0x1c16
// Size: 0xac, Type: bool
function private function_301a49b13dc0b937( victim, attacker )
{
    /#
        if ( getdvarint( @"hash_1c3093521b2fd238", 0 ) == 1 )
        {
            return true;
        }
    #/
    
    if ( getdvarint( @"hash_c3c3b44a05b67391", 0 ) == 1 )
    {
        return false;
    }
    
    if ( victim.var_f3b3baa8a49ac1e[ attacker.team ] > victim.deathtime - level.var_d5b10dc202a8af5b )
    {
        return true;
    }
    
    if ( victim.var_e665110f6dc5ad39[ attacker.team ] > victim.deathtime - level.var_d5b10dc202a8af5b )
    {
        return true;
    }
    
    return false;
}

// Namespace deathrecap
// Params 2, eflags: 0x4
// Checksum 0xecb5d474, Offset: 0x1ccb
// Size: 0xaf
function private function_fe0a1ea95adc4400( victim, attacker )
{
    /#
        if ( getdvarint( @"hash_72192917c0b3ff91", 0 ) == 1 )
        {
            return 1;
        }
    #/
    
    if ( !isdefined( victim.var_7d3f6f02c5ac5df9 ) || !isdefined( victim.var_7d3f6f02c5ac5df9[ attacker.team ] ) )
    {
        return 0;
    }
    
    if ( getdvarint( @"hash_eb51146a3264fbf4", 0 ) == 1 )
    {
        return 0;
    }
    
    var_6867e8133df8a200 = victim.var_7d3f6f02c5ac5df9[ attacker.team ] > victim.deathtime - level.var_d5b10dc202a8af5b;
    return var_6867e8133df8a200;
}

// Namespace deathrecap
// Params 2, eflags: 0x4
// Checksum 0x1a43052c, Offset: 0x1d83
// Size: 0x10f
function private function_254ccd47fbe7a8ac( victim, attacker )
{
    /#
        if ( getdvarint( @"hash_51078494da2235e5", 0 ) == 1 )
        {
            return 1;
        }
    #/
    
    if ( !isdefined( attacker.var_d84690daf210c17d ) || !isdefined( attacker.var_543ebeda38aa9b7f ) || !isdefined( attacker.var_484517e462eeec53 ) )
    {
        return 0;
    }
    
    if ( function_591e05f330495a83( victim, "specialty_ghost" ) || function_591e05f330495a83( victim, "specialty_br_ghost" ) )
    {
        return 0;
    }
    
    var_88c70e278cbab1f7 = distance2dsquared( attacker.var_484517e462eeec53, victim.origin ) <= attacker.var_543ebeda38aa9b7f * attacker.var_543ebeda38aa9b7f;
    
    if ( !var_88c70e278cbab1f7 )
    {
        return 0;
    }
    
    if ( getdvarint( @"hash_7b1d61a0b79abc1c", 0 ) == 1 )
    {
        return 0;
    }
    
    var_254ccd47fbe7a8ac = attacker.var_d84690daf210c17d > victim.deathtime - level.var_d5b10dc202a8af5b;
    return var_254ccd47fbe7a8ac;
}

// Namespace deathrecap
// Params 2, eflags: 0x4
// Checksum 0x38b4414a, Offset: 0x1e9b
// Size: 0xd7, Type: bool
function private function_6887bc3d59fe8a2c( victim, attacker )
{
    /#
        if ( getdvarint( @"hash_d67221904321d962", 0 ) == 1 )
        {
            return true;
        }
    #/
    
    if ( !isdefined( attacker.meatshieldtracking ) && !isdefined( attacker.var_bdafa8b75c3b0948 ) )
    {
        return false;
    }
    
    if ( getdvarint( @"hash_a041fb024e335ecb", 0 ) == 1 )
    {
        return false;
    }
    
    entnum = victim.entnum ?? utility::get_entity_number( victim );
    
    if ( attacker.meatshieldtracking[ entnum ] )
    {
        return true;
    }
    
    if ( attacker.var_bdafa8b75c3b0948[ entnum ] > victim.deathtime - level.var_d5b10dc202a8af5b )
    {
        attacker.var_bdafa8b75c3b0948[ entnum ] = undefined;
        return true;
    }
    
    return false;
}

// Namespace deathrecap
// Params 2, eflags: 0x4
// Checksum 0x9d229b7d, Offset: 0x1f7b
// Size: 0xde, Type: bool
function private function_c6c16478e0bdc558( victim, attacker )
{
    /#
        if ( getdvarint( @"hash_699157dfc4245c63", 0 ) == 1 )
        {
            return true;
        }
    #/
    
    if ( function_591e05f330495a83( victim, "specialty_ghost" ) )
    {
        return false;
    }
    
    if ( getdvarint( @"hash_9c2b667c42c9a8a8", 0 ) == 1 )
    {
        return false;
    }
    
    if ( isdefined( attacker.var_667ea7413e3ee64e ) && attacker.radarpingstate == 1 )
    {
        return ( distance2dsquared( attacker.origin, victim.origin ) <= attacker.var_667ea7413e3ee64e * attacker.var_667ea7413e3ee64e );
    }
    
    if ( attacker.var_dca79eccbe7842eb > victim.deathtime - level.var_d5b10dc202a8af5b )
    {
        attacker.var_dca79eccbe7842eb = undefined;
        return true;
    }
    
    return false;
}

// Namespace deathrecap
// Params 2, eflags: 0x4
// Checksum 0xe0119e5d, Offset: 0x2062
// Size: 0xac, Type: bool
function private function_9ae0044993035c06( victim, attacker )
{
    /#
        if ( getdvarint( @"hash_a699989215255fc5", 0 ) == 1 )
        {
            return true;
        }
    #/
    
    if ( !isdefined( attacker.var_cbd4681f351fbad2 ) && !isdefined( attacker.var_8c282bf5f0929c67 ) )
    {
        return false;
    }
    
    if ( getdvarint( @"hash_ed45f6660bfb91b6", 0 ) == 1 )
    {
        return false;
    }
    
    if ( attacker.var_cbd4681f351fbad2 )
    {
        return true;
    }
    
    if ( attacker.var_8c282bf5f0929c67 > victim.deathtime - level.var_d5b10dc202a8af5b )
    {
        attacker.var_8c282bf5f0929c67 = undefined;
        return true;
    }
    
    return false;
}

// Namespace deathrecap
// Params 1, eflags: 0x4
// Checksum 0xf24d1911, Offset: 0x2117
// Size: 0xa3, Type: bool
function private function_ecfa49b6f3a49d2d( victim )
{
    /#
        if ( getdvarint( @"hash_4018be89b90246dc", 0 ) == 1 )
        {
            return true;
        }
    #/
    
    if ( !isdefined( victim.var_ff8191a6766785f6 ) && !isdefined( victim.var_37986f991e47f03 ) )
    {
        return false;
    }
    
    if ( getdvarint( @"hash_fbac838092194883", 0 ) == 1 )
    {
        return false;
    }
    
    if ( victim.var_ff8191a6766785f6 )
    {
        return true;
    }
    
    if ( victim.var_37986f991e47f03 > victim.deathtime - level.var_d5b10dc202a8af5b )
    {
        victim.var_37986f991e47f03 = undefined;
        return true;
    }
    
    return false;
}

// Namespace deathrecap
// Params 2, eflags: 0x4
// Checksum 0x6f8180b3, Offset: 0x21c3
// Size: 0xd2
function private function_d85c856932e877e7( victim, attacker )
{
    /#
        if ( getdvarint( @"hash_9e0b11723a561036", 0 ) == 1 )
        {
            return 1;
        }
    #/
    
    if ( !isdefined( victim.var_1a28d2aca55547f9 ) || !isdefined( victim.var_1a28d2aca55547f9[ attacker.team ] ) )
    {
        return 0;
    }
    
    if ( function_591e05f330495a83( victim, "specialty_ghost" ) || function_591e05f330495a83( victim, "specialty_br_ghost" ) )
    {
        return 0;
    }
    
    if ( getdvarint( @"hash_576ac1983b72307", 0 ) == 1 )
    {
        return 0;
    }
    
    var_d85c856932e877e7 = victim.var_1a28d2aca55547f9[ attacker.team ] > victim.deathtime - level.var_d5b10dc202a8af5b;
    return var_d85c856932e877e7;
}

// Namespace deathrecap
// Params 2, eflags: 0x4
// Checksum 0xe2bd6c22, Offset: 0x229e
// Size: 0xaf
function private function_6f58e3c0f4bc7616( victim, attacker )
{
    /#
        if ( getdvarint( @"hash_15e928d40a7b0fb4", 0 ) == 1 )
        {
            return 1;
        }
    #/
    
    if ( !isdefined( victim.var_7f56b22cab8566fb ) || !isdefined( victim.var_7f56b22cab8566fb[ attacker.team ] ) )
    {
        return 0;
    }
    
    if ( getdvarint( @"hash_a2d2753ebea0bb3b", 0 ) == 1 )
    {
        return 0;
    }
    
    var_12d82d26274a0e97 = victim.var_7f56b22cab8566fb[ attacker.team ] > victim.deathtime - level.var_d5b10dc202a8af5b;
    return var_12d82d26274a0e97;
}

// Namespace deathrecap
// Params 1, eflags: 0x4
// Checksum 0xc35790ba, Offset: 0x2356
// Size: 0x75, Type: bool
function private function_613b3dca722730c1( victim )
{
    /#
        if ( getdvarint( @"hash_cddd6f2106e57b60", 0 ) == 1 )
        {
            return true;
        }
    #/
    
    if ( getdvarint( @"hash_d271e0c9ca2c2feb", 0 ) == 1 )
    {
        return false;
    }
    
    if ( victim.var_aaa4bf8b1e3f1cce )
    {
        return true;
    }
    
    if ( victim.var_e3a0eb63a8b650c4 > victim.deathtime - level.var_d5b10dc202a8af5b )
    {
        return true;
    }
    
    return false;
}

// Namespace deathrecap
// Params 1, eflags: 0x4
// Checksum 0xbd59747f, Offset: 0x23d4
// Size: 0x75, Type: bool
function private function_496d9f3575d35521( victim )
{
    /#
        if ( getdvarint( @"hash_2a39a6b1df23ce5a", 0 ) == 1 )
        {
            return true;
        }
    #/
    
    if ( getdvarint( @"hash_b4c46886b9183e41", 0 ) == 1 )
    {
        return false;
    }
    
    if ( victim.var_1789eb184d4295b2 )
    {
        return true;
    }
    
    if ( victim.var_63af23aefc9695 > victim.deathtime - level.var_d5b10dc202a8af5b )
    {
        return true;
    }
    
    return false;
}

// Namespace deathrecap
// Params 2, eflags: 0x4
// Checksum 0xa6635dda, Offset: 0x2452
// Size: 0xd6, Type: bool
function private function_e715efe234f5cd5b( victim, attacker )
{
    /#
        if ( getdvarint( @"hash_12950f687aebf874", 0 ) == 1 )
        {
            return true;
        }
    #/
    
    if ( !isdefined( victim.var_25ed22d5b74cd234 ) || !isdefined( victim.var_25ed22d5b74cd234[ attacker.entnum ?? utility::get_entity_number( attacker ) ] ) )
    {
        return false;
    }
    
    if ( function_591e05f330495a83( victim, "specialty_ghost" ) || function_591e05f330495a83( victim, "specialty_br_ghost" ) )
    {
        return false;
    }
    
    if ( getdvarint( @"hash_2fae15bc0aa3371", 0 ) == 1 )
    {
        return false;
    }
    
    if ( victim.var_25ed22d5b74cd234[ attacker.entnum ] > victim.deathtime - level.var_d5b10dc202a8af5b )
    {
        return true;
    }
    
    return false;
}

// Namespace deathrecap
// Params 2, eflags: 0x4
// Checksum 0x5d87d9d, Offset: 0x2531
// Size: 0xa1, Type: bool
function private function_72bb0bc4ed23689d( victim, attacker )
{
    /#
        if ( getdvarint( @"hash_6fa777557cd7e59e", 0 ) == 1 )
        {
            return true;
        }
    #/
    
    if ( !victim.var_22750a5d42d618f9[ attacker.entnum ?? utility::get_entity_number( attacker ) ] )
    {
        return false;
    }
    
    if ( getdvarint( @"hash_6a43511bcb5ab583", 0 ) == 1 )
    {
        return false;
    }
    
    if ( victim.var_22750a5d42d618f9[ attacker.entnum ] > victim.deathtime - level.var_d5b10dc202a8af5b )
    {
        return true;
    }
    
    return false;
}

// Namespace deathrecap
// Params 1, eflags: 0x4
// Checksum 0x9c0d73e9, Offset: 0x25db
// Size: 0x76, Type: bool
function private function_e46b9e19b8e9835b( victim )
{
    /#
        if ( getdvarint( @"hash_8a18544cd10121c6", 0 ) == 1 )
        {
            return true;
        }
    #/
    
    if ( !isdefined( victim.var_5d67576f2d0341bc ) )
    {
        return false;
    }
    
    if ( getdvarint( @"hash_ff8616a9a825c8eb", 0 ) == 1 )
    {
        return false;
    }
    
    if ( victim.var_5d67576f2d0341bc > victim.deathtime - level.var_d5b10dc202a8af5b )
    {
        return true;
    }
    
    return false;
}

// Namespace deathrecap
// Params 1, eflags: 0x4
// Checksum 0x47674202, Offset: 0x265a
// Size: 0x76, Type: bool
function private function_82f0e2c3dab4c885( victim )
{
    /#
        if ( getdvarint( @"hash_d6f160664c041f28", 0 ) == 1 )
        {
            return true;
        }
    #/
    
    if ( !isdefined( victim.var_6a87b5d2e21d59be ) )
    {
        return false;
    }
    
    if ( getdvarint( @"hash_b7c277f9aa57dfe5", 0 ) == 1 )
    {
        return false;
    }
    
    if ( victim.var_6a87b5d2e21d59be > victim.deathtime - level.var_d5b10dc202a8af5b )
    {
        return true;
    }
    
    return false;
}

// Namespace deathrecap
// Params 1, eflags: 0x4
// Checksum 0xc06cdaf4, Offset: 0x26d9
// Size: 0x76, Type: bool
function private function_7423a68dae8d2f97( victim )
{
    /#
        if ( getdvarint( @"hash_f44cb24a15e73178", 0 ) == 1 )
        {
            return true;
        }
    #/
    
    if ( !isdefined( victim.var_4ab6da7bfb8323fa ) )
    {
        return false;
    }
    
    if ( getdvarint( @"hash_65c133936f6944eb", 0 ) == 1 )
    {
        return false;
    }
    
    if ( victim.var_4ab6da7bfb8323fa > victim.deathtime - level.var_d5b10dc202a8af5b )
    {
        return true;
    }
    
    return false;
}

// Namespace deathrecap
// Params 2, eflags: 0x4
// Checksum 0x87bad18, Offset: 0x2758
// Size: 0xa3, Type: bool
function private function_ddc9076256fa4f62( victim, attacker )
{
    /#
        if ( getdvarint( @"hash_26713136d2f7cbcc", 0 ) == 1 )
        {
            return true;
        }
    #/
    
    if ( getdvarint( @"hash_e3a2d1da5afbcf95", 0 ) == 1 )
    {
        return false;
    }
    
    if ( attacker.vendettatarget == victim )
    {
        return true;
    }
    
    if ( isdefined( attacker.var_f70fa0618b1b1559 ) && attacker.var_d60e459a1a32188f == victim && attacker.var_f70fa0618b1b1559 > victim.deathtime - level.var_d5b10dc202a8af5b )
    {
        return true;
    }
    
    return false;
}

// Namespace deathrecap
// Params 2
// Checksum 0x568213d, Offset: 0x2804
// Size: 0xa8, Type: bool
function function_284f0ea5cd70d448( victim, attacker )
{
    /#
        if ( getdvarint( @"hash_49813639531f4795", 0 ) == 1 )
        {
            return true;
        }
    #/
    
    if ( !isdefined( victim.var_4395a821533743e7 ) || !isdefined( victim.var_4395a821533743e7[ attacker.team ] ) )
    {
        return false;
    }
    
    if ( getdvarint( @"hash_b8c0319a52cdd72f", 0 ) == 1 )
    {
        return false;
    }
    
    if ( victim.var_4395a821533743e7[ attacker.team ] > victim.deathtime - level.var_d5b10dc202a8af5b )
    {
        return true;
    }
    
    return false;
}

// Namespace deathrecap
// Params 2
// Checksum 0xbd52280, Offset: 0x28b5
// Size: 0xa1, Type: bool
function function_c0e44c19a0a95c3c( victim, attacker )
{
    /#
        if ( getdvarint( @"hash_49c48affe1d8d3da", 0 ) == 1 )
        {
            return true;
        }
    #/
    
    if ( getdvarint( @"hash_3735d1965261263", 0 ) == 1 )
    {
        return false;
    }
    
    if ( victim.var_c0e44c19a0a95c3c[ attacker.entnum ?? utility::get_entity_number( attacker ) ] )
    {
        return true;
    }
    
    if ( victim.var_eec3766336d91616[ attacker.entnum ] > victim.deathtime - level.var_d5b10dc202a8af5b )
    {
        return true;
    }
    
    return false;
}

// Namespace deathrecap
// Params 2
// Checksum 0x961db1fb, Offset: 0x295f
// Size: 0x7e, Type: bool
function function_67802b153747d6a5( victim, attacker )
{
    /#
        if ( getdvarint( @"hash_db5b6381253a086c", 0 ) == 1 )
        {
            return true;
        }
    #/
    
    if ( getdvarint( @"hash_4ff66a34905d443", 0 ) == 1 )
    {
        return false;
    }
    
    if ( attacker.var_67802b153747d6a5 )
    {
        return true;
    }
    
    if ( attacker.var_569f1dc25d9d7e03 > victim.deathtime - level.var_d5b10dc202a8af5b )
    {
        return true;
    }
    
    return false;
}

// Namespace deathrecap
// Params 2
// Checksum 0xa8a015e2, Offset: 0x29e6
// Size: 0xa6, Type: bool
function function_434ee6f46ae3f926( victim, attacker )
{
    /#
        if ( getdvarint( @"hash_18e8e55921d940a3", 0 ) == 1 )
        {
            return true;
        }
    #/
    
    if ( !isdefined( victim.var_4193d1557ef26d9[ attacker.entnum ?? utility::get_entity_number( attacker ) ] ) )
    {
        return false;
    }
    
    if ( getdvarint( @"hash_48c2275e16ca7bbe", 0 ) == 1 )
    {
        return false;
    }
    
    if ( victim.var_4193d1557ef26d9[ attacker.entnum ] + 1000 > victim.deathtime - level.var_d5b10dc202a8af5b )
    {
        return true;
    }
    
    return false;
}

// Namespace deathrecap
// Params 2
// Checksum 0xc239ac67, Offset: 0x2a95
// Size: 0x8b, Type: bool
function function_b765a34a47426c86( victim, attacker )
{
    /#
        if ( getdvarint( @"hash_f258c07b08682a8f", 0 ) == 1 )
        {
            return true;
        }
    #/
    
    if ( getdvarint( @"hash_a045f5f0fb7d2278", 0 ) == 1 )
    {
        return false;
    }
    
    victimdata = attacker.binocularsstruct.targetdata[ victim getentitynumber() ];
    
    if ( !victimdata || gettime() >= victimdata.expirationtimer )
    {
        return false;
    }
    
    return true;
}

// Namespace deathrecap
// Params 2
// Checksum 0x2693cdaa, Offset: 0x2b29
// Size: 0x76
function function_e4e7fe71c5c1cd4e( victim, attacker )
{
    /#
        if ( getdvarint( @"hash_9565048a070b7245", 0 ) == 1 )
        {
            return 1;
        }
    #/
    
    if ( function_ddc9076256fa4f62( victim, attacker ) )
    {
        return 1;
    }
    
    if ( getdvarint( @"hash_6704772df72c80e6", 0 ) == 1 )
    {
        return 0;
    }
    
    return victim.var_1425551d5d50527a[ attacker.entnum ?? utility::get_entity_number( attacker ) ];
}

// Namespace deathrecap
// Params 2
// Checksum 0xe715724d, Offset: 0x2ba8
// Size: 0xa2, Type: bool
function function_c163a22b89e06fef( victim, attacker )
{
    /#
        if ( getdvarint( @"hash_71d6cd0a128f8e2", 0 ) == 1 )
        {
            return true;
        }
    #/
    
    if ( !isdefined( victim.var_dd4aae4990623aea[ attacker.entnum ?? utility::get_entity_number( attacker ) ] ) )
    {
        return false;
    }
    
    if ( getdvarint( @"hash_519bc3f54cf18579", 0 ) == 1 )
    {
        return false;
    }
    
    if ( victim.var_dd4aae4990623aea[ attacker.entnum ] > victim.deathtime - level.var_d5b10dc202a8af5b )
    {
        return true;
    }
    
    return false;
}

// Namespace deathrecap
// Params 2
// Checksum 0x14eece3f, Offset: 0x2c53
// Size: 0xa2, Type: bool
function function_f802289d12650b75( victim, attacker )
{
    /#
        if ( getdvarint( @"hash_99e8bc4c05899fad", 0 ) == 1 )
        {
            return true;
        }
    #/
    
    if ( !isdefined( victim.var_645cb1131f4115[ attacker.entnum ?? utility::get_entity_number( attacker ) ] ) )
    {
        return false;
    }
    
    if ( getdvarint( @"hash_2e10d481b7a84360", 0 ) == 1 )
    {
        return false;
    }
    
    if ( victim.var_645cb1131f4115[ attacker.entnum ] > victim.deathtime - level.var_d5b10dc202a8af5b )
    {
        return true;
    }
    
    return false;
}

// Namespace deathrecap
// Params 2
// Checksum 0xb285b9d7, Offset: 0x2cfe
// Size: 0x7e, Type: bool
function function_6695f97df8e74502( victim, attacker )
{
    /#
        if ( getdvarint( @"hash_71b9bc6c1fd8bb37", 0 ) == 1 )
        {
            return true;
        }
    #/
    
    if ( getdvarint( @"hash_1980c680af344cde", 0 ) == 1 )
    {
        return false;
    }
    
    if ( attacker.var_d342c9285c347435 )
    {
        return true;
    }
    
    if ( attacker.var_9f977223c1d2bf5 > victim.deathtime - level.var_d5b10dc202a8af5b )
    {
        return true;
    }
    
    return false;
}

// Namespace deathrecap
// Params 2
// Checksum 0xa097d67f, Offset: 0x2d85
// Size: 0x6d, Type: bool
function function_a12c96ac754cab65( victim, attacker )
{
    /#
        if ( getdvarint( @"hash_33c69fef2f974a7a", 0 ) == 1 )
        {
            return true;
        }
    #/
    
    if ( getdvarint( @"hash_c7412875759bf515", 0 ) == 1 )
    {
        return false;
    }
    
    if ( attacker.var_da591267109e7023 > victim.deathtime - level.var_d5b10dc202a8af5b )
    {
        return true;
    }
    
    return false;
}

// Namespace deathrecap
// Params 2
// Checksum 0xac75a199, Offset: 0x2dfb
// Size: 0xa2, Type: bool
function function_4dc19e4512e9bb83( victim, attacker )
{
    /#
        if ( getdvarint( @"hash_a10c4ed0a1f92052", 0 ) == 1 )
        {
            return true;
        }
    #/
    
    if ( !isdefined( victim.var_483315f90a71728e[ attacker.entnum ?? utility::get_entity_number( attacker ) ] ) )
    {
        return false;
    }
    
    if ( getdvarint( @"hash_d16d0ebcbaf94ec9", 0 ) == 1 )
    {
        return false;
    }
    
    if ( victim.var_483315f90a71728e[ attacker.entnum ] > victim.deathtime - level.var_d5b10dc202a8af5b )
    {
        return true;
    }
    
    return false;
}

// Namespace deathrecap
// Params 2
// Checksum 0x6a16f9ed, Offset: 0x2ea6
// Size: 0xa2, Type: bool
function function_bd77e53e17b03eb2( victim, attacker )
{
    /#
        if ( getdvarint( @"hash_3e6717b0b6ba4299", 0 ) == 1 )
        {
            return true;
        }
    #/
    
    if ( !isdefined( victim.var_898e85ceb5f62e0c[ attacker.entnum ?? utility::get_entity_number( attacker ) ] ) )
    {
        return false;
    }
    
    if ( getdvarint( @"hash_25780cdc94aa4766", 0 ) == 1 )
    {
        return false;
    }
    
    if ( victim.var_898e85ceb5f62e0c[ attacker.entnum ] > victim.deathtime - level.var_d5b10dc202a8af5b )
    {
        return true;
    }
    
    return false;
}

// Namespace deathrecap
// Params 2
// Checksum 0x4176ac3b, Offset: 0x2f51
// Size: 0xa1, Type: bool
function function_c025b76158d5a3ae( victim, attacker )
{
    /#
        if ( getdvarint( @"hash_145daecbc8b100b8", 0 ) == 1 )
        {
            return true;
        }
    #/
    
    if ( getdvarint( @"hash_f562352bc0755c2f", 0 ) == 1 )
    {
        return false;
    }
    
    if ( victim.var_a195d2dcf0aee163[ attacker.entnum ?? utility::get_entity_number( attacker ) ] )
    {
        return true;
    }
    
    if ( victim.var_adf995dac725ef56[ attacker.entnum ] > victim.deathtime - level.var_d5b10dc202a8af5b )
    {
        return true;
    }
    
    return false;
}

// Namespace deathrecap
// Params 2
// Checksum 0x8afc43ba, Offset: 0x2ffb
// Size: 0x51, Type: bool
function function_35efc1c4714718cc( victim, attacker )
{
    /#
        if ( getdvarint( @"hash_f125175af38af583", 0 ) == 1 )
        {
            return true;
        }
    #/
    
    if ( getdvarint( @"hash_7c729a898d74622e", 0 ) == 1 )
    {
        return false;
    }
    
    return isdefined( victim.var_28aa1e3338af6677 );
}

// Namespace deathrecap
// Params 2
// Checksum 0x69a71f9a, Offset: 0x3055
// Size: 0xe1, Type: bool
function function_c3406c5cb68185cf( victim, attacker )
{
    /#
        if ( getdvarint( @"hash_f320cf507d9d915b", 0 ) == 1 )
        {
            return true;
        }
    #/
    
    if ( getdvarint( @"hash_90e3ba5bf2074930", 0 ) == 1 )
    {
        return false;
    }
    
    squad_link_specialty = "specialty_squad_link";
    
    if ( !level.perkbundles[ squad_link_specialty ] )
    {
        return false;
    }
    
    if ( !isdefined( victim.var_96ea52dc3dbcbb6e ) || !isdefined( victim.var_96ea52dc3dbcbb6e[ attacker.team ] ) )
    {
        return false;
    }
    
    if ( victim.var_96ea52dc3dbcbb6e[ attacker.team ] > victim.deathtime - level.var_d5b10dc202a8af5b )
    {
        return ( victim.var_ac5525151377528 == level.perkbundles[ squad_link_specialty ] );
    }
    
    return false;
}

// Namespace deathrecap
// Params 2
// Checksum 0xa76e9eff, Offset: 0x313f
// Size: 0x67, Type: bool
function function_852d6be72e0fba7d( victim, attacker )
{
    /#
        if ( getdvarint( @"hash_3b1bde06c71d1dc0", 0 ) == 1 )
        {
            return true;
        }
    #/
    
    if ( getdvarint( @"hash_226642b5196f2cb3", 0 ) == 1 )
    {
        return false;
    }
    
    if ( isdefined( victim.var_24834e79caa4ab28 ) && victim.var_24834e79caa4ab28 )
    {
        return true;
    }
    
    return false;
}

// Namespace deathrecap
// Params 2
// Checksum 0x219404e2, Offset: 0x31af
// Size: 0x67, Type: bool
function function_aad393efbd2d17e4( victim, attacker )
{
    /#
        if ( getdvarint( @"hash_99323d8071390907", 0 ) == 1 )
        {
            return true;
        }
    #/
    
    if ( getdvarint( @"hash_1798833790420070", 0 ) == 1 )
    {
        return false;
    }
    
    if ( isdefined( victim.var_e25b36cb2efc2c0d ) && victim.var_e25b36cb2efc2c0d )
    {
        return true;
    }
    
    return false;
}

// Namespace deathrecap
// Params 2
// Checksum 0xa1f06a29, Offset: 0x321f
// Size: 0xba, Type: bool
function function_51f52c988695792a( victim, attacker )
{
    /#
        if ( getdvarint( @"hash_777ade46b96e9f67", 0 ) == 1 )
        {
            return true;
        }
    #/
    
    if ( getdvarint( @"hash_83b2f1ce441c305a", 0 ) == 1 )
    {
        return false;
    }
    
    if ( !isdefined( victim.var_3de020a9a12fb43d ) || !isdefined( victim.var_3de020a9a12fb43d[ attacker.team ] ) )
    {
        return false;
    }
    
    if ( function_591e05f330495a83( victim, "specialty_coldblooded" ) )
    {
        return false;
    }
    
    if ( victim.var_3de020a9a12fb43d[ attacker.team ] <= victim.deathtime - level.var_d5b10dc202a8af5b )
    {
        return false;
    }
    
    return true;
}

// Namespace deathrecap
// Params 2
// Checksum 0x84feff68, Offset: 0x32e2
// Size: 0x95
function function_ce5c32994cbd7b06( victim, attacker )
{
    /#
        if ( getdvarint( @"hash_464b37e9426bae68", 0 ) == 1 )
        {
            return 1;
        }
    #/
    
    if ( getdvarint( @"hash_1852e3c541822da5", 0 ) == 1 )
    {
        return 0;
    }
    
    if ( function_591e05f330495a83( attacker, "specialty_overwatch" ) )
    {
        var_e6acbffa6272fe7c = function_254ccd47fbe7a8ac( victim, attacker ) || function_d8b06d21d4d5cd31( victim, attacker ) || function_ea5ac7c76e0272b6( victim, attacker ) || function_ec990d15ac09cb6c( victim, attacker );
        return var_e6acbffa6272fe7c;
    }
    
    return 0;
}

// Namespace deathrecap
// Params 2
// Checksum 0xe479df46, Offset: 0x3380
// Size: 0xca, Type: bool
function function_4b7d21f2c0f8d197( victim, attacker )
{
    /#
        if ( getdvarint( @"hash_b7ed6446c5c60860", 0 ) == 1 )
        {
            return true;
        }
    #/
    
    if ( getdvarint( @"hash_b9a8bf7f24b8f035", 0 ) == 1 )
    {
        return false;
    }
    
    if ( function_591e05f330495a83( victim, "specialty_coldblooded" ) )
    {
        return false;
    }
    
    var_dec36ab35413b4ef = victim.entnum ?? utility::get_entity_number( victim );
    
    if ( !isdefined( attacker.var_1eac61f0e82441d ) || !isdefined( attacker.var_1eac61f0e82441d[ var_dec36ab35413b4ef ] ) )
    {
        return false;
    }
    
    if ( attacker.var_1eac61f0e82441d[ var_dec36ab35413b4ef ] <= victim.deathtime - level.var_d5b10dc202a8af5b )
    {
        return false;
    }
    
    return true;
}

