// scripts\mp\br\gametypes\br_bosses.gsc  (hash_1cac0573db3fc3e9.gscc) (size: 3690 Bytes / 0xe6a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xefd50b40 (4023716672)
// size ...... 3690 (0xe6a)
// includes .. 3   (offset: 0xe0e)
// strings ... 1   (offset: 0xe26)
// dev strs .. 4   (offset: 0xe32)
// exports ... 11  (offset: 0x986)
// cseg ...... 0x65 + 0x921 (0x986)
// imports ... 24  (offset: 0xb3e)
// animtree1 . 0   (offset: 0xe6a)
// animtree2 . 0   (offset: 0xe6a)
#using scripts\mp\ai_mp_controller;
#using scripts\mp\br\gametypes\br_bosses_mi8jugg;
#using scripts\mp\br\gametypes\br_strongholds;

#namespace br_bosses;

// Namespace br_bosses
// Params 0
// Checksum 0xc76de5f, Offset: 0x83
// Size: 0x24f
function initbosses()
{
    level endon( #"game_ended" );
    
    if ( br_strongholds::function_15f893a51b7d6d7c() )
    {
        level waittill( #"hash_b9d03524089b1656" );
    }
    else
    {
        while ( !isdefined( level.fortressstruct ) || !level.fortressstruct.var_6dc29464d93d3edd )
        {
            waitframe();
        }
    }
    
    level.bosses = [];
    br_bosses_mi8jugg::mi8jugg_register();
    
    if ( isdefined( level.var_c09424dccafb5131 ) )
    {
        foreach ( var_c6dee3e34e6d40a9 in level.var_c09424dccafb5131 )
        {
            [[ var_c6dee3e34e6d40a9 ]]();
        }
    }
    
    foreach ( boss in level.bosses )
    {
        if ( getdvarint( hashcat( @"scr_", boss.name, "_disabled" ), 0 ) > 0 )
        {
            boss.disabled = 1;
            continue;
        }
        
        if ( isdefined( boss.initfunc ) )
        {
            [[ boss.initfunc ]]( boss );
        }
    }
    
    ai_mp_controller::function_7f833bacb64445a6();
    
    /#
        level thread function_e9812a02bc402039();
    #/
    
    foreach ( boss in level.bosses )
    {
        if ( !boss.disabled && isdefined( boss.var_3e06982b5b53e7a ) )
        {
            level thread [[ boss.var_3e06982b5b53e7a ]]();
        }
    }
}

// Namespace br_bosses
// Params 1
// Checksum 0xfa6537b4, Offset: 0x2da
// Size: 0x41
function function_9421c9785598d4b2( funcpointer )
{
    if ( !isdefined( funcpointer ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_c09424dccafb5131 ) )
    {
        level.var_c09424dccafb5131 = [];
    }
    
    level.var_c09424dccafb5131[ level.var_c09424dccafb5131.size ] = funcpointer;
}

// Namespace br_bosses
// Params 1
// Checksum 0x510cc146, Offset: 0x323
// Size: 0x24
function registerboss( detailsstruct )
{
    level.bosses[ detailsstruct.name ] = detailsstruct;
}

// Namespace br_bosses
// Params 2
// Checksum 0x7b7bd753, Offset: 0x34f
// Size: 0x2e
function spawnboss( name, node )
{
    return [[ level.bosses[ name ].spawnfunc ]]( node );
}

// Namespace br_bosses
// Params 1
// Checksum 0x719cdbad, Offset: 0x386
// Size: 0x149
function function_8c64e1696564998f( name )
{
    if ( !level.var_59ee0e50e002334f )
    {
        return;
    }
    
    foreach ( fortress in level.fortressstruct.chosenfortresses )
    {
        if ( !isdefined( fortress.boss ) )
        {
            continue;
        }
        
        if ( isdefined( fortress.boss ) && fortress.boss.size == 0 )
        {
            continue;
        }
        
        if ( randomfloat( 1 ) <= level.var_1787461f8b1c2f0f )
        {
            node = fortress.boss[ randomint( fortress.boss.size ) ];
            boss = spawnboss( name, node );
            
            if ( isdefined( boss ) )
            {
                fortress.bossagents[ fortress.bossagents.size ] = boss;
                boss.fortress = fortress;
            }
        }
    }
}

// Namespace br_bosses
// Params 2
// Checksum 0x54a66638, Offset: 0x4d7
// Size: 0x6c
function function_2fc885345d040baf( name, var_4d3a4e313aecf79c )
{
    self.var_4f8a92ebabf37ee = 0;
    self.var_2517193969180a2e = var_4d3a4e313aecf79c;
    
    if ( getdvarint( @"hash_b3a452dbb8a7c28", 0 ) > 0 )
    {
        self function_e2952bb17f46a796( 1, 4, level.bosses[ name ].uiname );
    }
    
    self function_1b0b5d1c994e3a69();
    thread function_28402a8ce3e5a94c( name );
}

// Namespace br_bosses
// Params 1
// Checksum 0xfcce28a, Offset: 0x54b
// Size: 0x31
function function_28402a8ce3e5a94c( name )
{
    level endon( #"game_ended" );
    self waittill( #"death", killer );
}

/#

    // Namespace br_bosses
    // Params 0
    // Checksum 0x2d55980b, Offset: 0x584
    // Size: 0x150, Type: dev
    function function_e9812a02bc402039()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            node = spawnstruct();
            node.origin = getclosestpointonnavmesh( level.players[ 0 ].origin + anglestoforward( level.players[ 0 ].angles ) * 128 );
            node.angles = level.players[ 0 ].angles;
            
            foreach ( boss in level.bosses )
            {
                if ( getdvarint( hashcat( @"hash_99aa34f6e7fd419b", boss.name ), 0 ) )
                {
                    level thread debug_spawnboss( boss.name, node );
                    setdvar( hashcat( @"hash_99aa34f6e7fd419b", boss.name ), 0 );
                }
            }
            
            wait 1;
        }
    }

    // Namespace br_bosses
    // Params 2
    // Checksum 0x1b4db2da, Offset: 0x6dc
    // Size: 0x178, Type: dev
    function debug_spawnboss( name, node )
    {
        level endon( #"hash_4d80cfc5e73f09b3" );
        boss = [[ level.bosses[ name ].spawnfunc_debug ]]( node );
        boss.var_de04c2fb38eec74a = 1;
        boss.var_1db1f2ef9c7f9036 = 350;
        boss.var_aaf12cbad4692c1b = 150;
        boss.goalheight = 80;
        boss.allowlongdeath = 1;
        boss.maxhealth = int( level.var_82b487c6eeaa99b9 * level.var_b2613d846d7edd32 );
        boss.health = int( level.var_82b487c6eeaa99b9 * level.var_b2613d846d7edd32 );
        boss.maxarmorhealth = int( level.var_9eae17470d33fc2d * level.var_38f3d6c9dca9ace );
        boss.armorhealth = int( level.var_9eae17470d33fc2d * level.var_38f3d6c9dca9ace );
        boss.maxhelmethealth = int( level.var_63383f67bf1f6c49 * level.var_1148e08e2afb2c82 );
        boss.helmethealth = int( level.var_63383f67bf1f6c49 * level.var_1148e08e2afb2c82 );
        level thread function_f69affa8cf63ac05( boss );
        level notify( #"hash_4d80cfc5e73f09b3" );
    }

    // Namespace br_bosses
    // Params 1
    // Checksum 0x491da82c, Offset: 0x85c
    // Size: 0x12a, Type: dev
    function function_f69affa8cf63ac05( boss )
    {
        boss endon( #"death" );
        
        while ( true )
        {
            waitframe();
            
            if ( isdefined( boss ) )
            {
                debugstar( boss.origin + ( 0, 0, 60 ), ( 0, 1, 0 ), 1, "<dev string:x24>" + boss.helmethealth + "<dev string:x32>" + boss.maxhelmethealth, 0.3 );
                debugstar( boss.origin + ( 0, 0, 40 ), ( 0, 1, 0 ), 1, "<dev string:x34>" + boss.armorhealth + "<dev string:x32>" + boss.maxarmorhealth, 0.3 );
                debugstar( boss.origin + ( 0, 0, 20 ), ( 0, 1, 0 ), 1, "<dev string:x41>" + boss.health + "<dev string:x32>" + boss.maxhealth, 0.3 );
            }
        }
    }

#/
