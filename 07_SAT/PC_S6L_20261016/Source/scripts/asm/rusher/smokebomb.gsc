// scripts\asm\rusher\smokebomb.gsc  (hash_4e0a3b3f9bedd99d.gscc) (size: 6307 Bytes / 0x18a3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xba029103 (3120730371)
// size ...... 6307 (0x18a3)
// includes .. 12  (offset: 0x1713)
// strings ... 23  (offset: 0x1773)
// dev strs .. 1   (offset: 0x1897)
// exports ... 14  (offset: 0xce7)
// cseg ...... 0x1b0 + 0xb37 (0xce7)
// imports ... 70  (offset: 0xf17)
// animtree1 . 0   (offset: 0x18a3)
// animtree2 . 0   (offset: 0x18a3)
#using scripts\asm\asm;
#using scripts\asm\soldier\melee;
#using scripts\asm\soldier\throwgrenade;
#using scripts\common\ai;
#using scripts\mp\common\equipment\gas_grenade;
#using scripts\mp\common\equipment\molotov;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\ent_manager;
#using scripts\mp\shellshock;

#namespace smokebomb;

// Namespace smokebomb
// Params 3
// Checksum 0x2675523b, Offset: 0x1ce
// Size: 0x53
function function_c8bc0a420cccfe48( statename, var_d021f57dc55d46fa, var_d87b770a7324fa7c )
{
    function_8df58b397da8b737();
    self attach( getweaponmodel( self.grenadeweapon ), "TAG_ACCESSORY_LEFT" );
    self.var_123359c215982e6c = 1;
    thread function_3f48937d27aebec( statename, var_d021f57dc55d46fa, var_d87b770a7324fa7c );
}

// Namespace smokebomb
// Params 3
// Checksum 0x229bf599, Offset: 0x229
// Size: 0x60
function function_4012a5a131442339( asmname, statename, params )
{
    self endon( statename + "_finished" );
    
    if ( self.var_71ef0f4b1f42cbeb == getxhash( "TAG_ACCESSORY_LEFT" ) )
    {
        self function_70645ed294e955c5();
    }
    
    function_c8bc0a420cccfe48( statename, params[ 0 ], params[ 1 ] );
    asm::asm_playanimstate( asmname, statename, params );
}

// Namespace smokebomb
// Params 0
// Checksum 0xa821a29b, Offset: 0x291
// Size: 0x30
function function_8df58b397da8b737()
{
    if ( self.var_123359c215982e6c )
    {
        self detach( getweaponmodel( self.grenadeweapon ), "TAG_ACCESSORY_LEFT" );
        self.var_123359c215982e6c = 0;
    }
}

// Namespace smokebomb
// Params 3
// Checksum 0x96edb7c3, Offset: 0x2c9
// Size: 0x45d
function function_3f48937d27aebec( statename, var_d021f57dc55d46fa, var_d87b770a7324fa7c )
{
    self endon( #"death" );
    self endon( statename + "_finished" );
    var_f60f7eb779f3f5f0 = 0;
    
    while ( !var_f60f7eb779f3f5f0 )
    {
        self waittill( statename, notes );
        
        if ( !isarray( notes ) )
        {
            notes = [ notes ];
        }
        
        foreach ( notetrack in notes )
        {
            if ( notetrack == "grenade_throw" || notetrack == "grenade throw" )
            {
                var_f60f7eb779f3f5f0 = 1;
                continue;
            }
            
            assert( notetrack != "<dev string:x24>" );
            
            if ( notetrack == "end" )
            {
                if ( isplayer( self.var_62cab1d078e4afb ) )
                {
                    self.var_62cab1d078e4afb function_88a6736ac53d2a25();
                }
                
                self notify( #"hash_5ad7dd4a92990c59" );
                var_f60f7eb779f3f5f0 = 1;
            }
        }
    }
    
    function_8df58b397da8b737();
    self notify( #"hash_1a12860c6527fe71" );
    self notify( #"hash_bb8187042c2ea92e" );
    
    if ( issubstr( self.grenadeweapon.basename, "smoke" ) )
    {
        vectotarget = anglestoforward( self.origin );
        
        if ( isdefined( self.enemy ) )
        {
            vectotarget = self.enemy.origin - self.origin;
        }
        
        var_7bc30af9d99b49e5 = randomfloatrange( var_d021f57dc55d46fa, var_d87b770a7324fa7c );
        var_d37bf2b3df78ecd5 = rotatevector( vectotarget, ( 0, randomfloatrange( -5, 5 ), 0 ) );
        var_d37bf2b3df78ecd5 = var_7bc30af9d99b49e5 * vectornormalize( var_d37bf2b3df78ecd5 );
        newgrenade = self function_de0ec7f52c8250bd( self.origin + var_d37bf2b3df78ecd5 + ( 0, 0, 10 ), ( 0, 0, 15 ), 0.5 );
    }
    else
    {
        armoffset = ( 12.9077, 17.6221, 28.1187 );
        throwtime = randomfloatrange( 1, 1.5 );
        throwvel = self checkgrenadethrowpos( armoffset, self.enemy.origin, 0, "min time", "min energy" );
        
        if ( !isdefined( throwvel ) )
        {
            vectotarget = anglestoforward( self.origin );
            
            if ( isdefined( self.enemy ) )
            {
                vectotarget = self.enemy.origin - self.origin;
            }
            
            var_7bc30af9d99b49e5 = length( vectotarget ) * randomfloatrange( 0.95, 1.05 );
            var_d37bf2b3df78ecd5 = rotatevector( vectotarget, ( 0, randomfloatrange( -5, 5 ), 0 ) );
            throwvel = var_7bc30af9d99b49e5 / throwtime * vectornormalize( var_d37bf2b3df78ecd5 ) + ( 0, 0, 200 );
        }
        
        newgrenade = self function_de0ec7f52c8250bd( self.origin + armoffset, throwvel, throwtime );
    }
    
    newgrenade.owner = self;
    newgrenade.weapon_name = self.grenadeweapon.basename;
    var_6f0d3134570347c2 = throwgrenade::getdesiredgrenadetimervalue();
    throwgrenade::setgrenadetimer( min( gettime() + 3000, var_6f0d3134570347c2 ) );
    throwingat = self.enemy;
    
    if ( isplayer( throwingat ) && throwgrenade::usingplayergrenadetimer() )
    {
        throwingat function_884711fc94b10261();
        thread throwgrenade::reducegiptponkillanimscript( statename, throwingat );
        
        if ( self.var_a0c0473ec3dea373 == "lethal" )
        {
            if ( throwingat function_ea1c30d42bd9c659() <= 1 )
            {
                throwingat function_e45b1e2106a2e439( gettime() );
            }
        }
    }
    
    if ( self.grenadeweapon.basename == "smoke_bomb_rusher_mp" )
    {
        function_b448955d5f49e6aa( newgrenade.origin, newgrenade.angles, getdvarint( @"hash_5d839447a2947c11", 1 ) == 1 );
        return;
    }
    
    if ( issubstr( self.grenadeweapon.basename, "molotov" ) )
    {
        newgrenade thread shellshock::grenade_earthquake();
        thread molotov::molotov_used( newgrenade );
    }
}

// Namespace smokebomb
// Params 4
// Checksum 0x96194d27, Offset: 0x72e
// Size: 0x9d
function function_b448955d5f49e6aa( position, angles, var_baa0f26e57c2604b, var_cec3b10016f986ae )
{
    if ( !var_cec3b10016f986ae )
    {
        wait 0.5;
    }
    
    if ( getdvarint( @"hash_f784bdc2ab0eedde", 0 ) == 1 )
    {
        ai::function_5b4f66c4d86eea91( position );
    }
    
    thread function_8b1ac912040060df( position );
    var_9a1fcd0ca0fe6ba2 = spawnscriptable( "grenade_smoke_v0_rusher_mp_fx", position, angles );
    var_9a1fcd0ca0fe6ba2 thread function_8a1796b54f9ea000( self );
    
    if ( var_baa0f26e57c2604b )
    {
        thread function_d7dad109966017cd( position, self, self.team, 4.5, 0.25 );
    }
}

// Namespace smokebomb
// Params 1
// Checksum 0x15d39d0e, Offset: 0x7d3
// Size: 0x2d
function function_d2b665b584e2aeeb( position )
{
    playfx( self.var_4e5989b0a79b26f1, position, anglestoup( ( 0, 90, 0 ) ) );
}

// Namespace smokebomb
// Params 1
// Checksum 0xb2602d04, Offset: 0x808
// Size: 0x3b
function function_8a1796b54f9ea000( owner )
{
    self setscriptablepartstate( "sfx_smoke_bomb", "sfx_expl" );
    wait 0.25;
    self setscriptablepartstate( "sfx_smoke_bomb", "sfx_smoke_fade_out" );
    wait 4;
    self freescriptable();
}

// Namespace smokebomb
// Params 1
// Checksum 0x936838e3, Offset: 0x84b
// Size: 0x40
function function_8b1ac912040060df( position )
{
    level endon( #"game_ended" );
    wait 1;
    id = outline::addoutlineoccluder( position, 64 );
    wait 5.1;
    outline::removeoutlineoccluder( id );
}

// Namespace smokebomb
// Params 5
// Checksum 0x9cf91b1d, Offset: 0x893
// Size: 0xf1
function function_d7dad109966017cd( position, owner, team, duration = 4.5, scale = 1 )
{
    trigger = spawn( "trigger_radius", position + ( 0, 0, int( -57.75 * scale ) ), 0, int( 256 * scale ), int( 175 * scale ) );
    trigger ent_manager::registerspawn( 1, &gas_grenade::sweepgas );
    trigger endon( #"death" );
    trigger.owner = owner;
    trigger.team = team;
    trigger.playersintrigger = [];
    trigger.var_a8d0289a93e5a155 = [];
    trigger thread gas_watchtriggerenter();
    trigger thread gas_grenade::gas_watchtriggerexit();
    wait duration;
    trigger thread gas_grenade::gas_destroytrigger();
}

// Namespace smokebomb
// Params 0
// Checksum 0xa3530fb5, Offset: 0x98c
// Size: 0x1a9
function gas_watchtriggerenter()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"trigger", player );
        
        if ( !isplayer( player ) )
        {
            if ( isagent( player ) )
            {
                if ( player != self.owner && player.team != self.team )
                {
                    if ( !arraycontains( self.var_a8d0289a93e5a155, player ) || player.flashendtime < gettime() )
                    {
                        self.var_a8d0289a93e5a155[ self.var_a8d0289a93e5a155.size ] = player;
                        
                        if ( player.radimmune )
                        {
                            continue;
                        }
                        
                        player notify( #"flashbang", player.origin, 1, 1, self.owner, self.team, 9 );
                    }
                }
            }
            
            continue;
        }
        
        if ( player killstreak::isjuggernaut() )
        {
            continue;
        }
        
        if ( gas_grenade::function_8de1f4bd0dc11222( player ) )
        {
            continue;
        }
        
        if ( !player player::isreallyalive() )
        {
            continue;
        }
        
        if ( isdefined( self.playersintrigger[ player getentitynumber() ] ) )
        {
            continue;
        }
        
        if ( level.teambased )
        {
            if ( isalive( self.owner ) )
            {
                if ( player != self.owner && !player_utility::playersareenemies( player, self.owner ) )
                {
                    continue;
                }
            }
            else if ( player_utility::isfriendly( self.team, player ) )
            {
                continue;
            }
        }
        
        self.playersintrigger[ player getentitynumber() ] = player;
        player thread gas_grenade::gas_onentertrigger( self );
    }
}

// Namespace smokebomb
// Params 3
// Checksum 0xd088fc2c, Offset: 0xb3d
// Size: 0x46
function function_8ba54189bb2ab617( asmname, statename, params )
{
    melee::playmeleechargesound();
    self.var_4ff0a015a19a428e = 1;
    self.var_2d4dd3f57eb8b4ed = 1;
    melee::playmeleeanim_vsplayer( asmname, statename, params );
}

// Namespace smokebomb
// Params 4
// Checksum 0xad244cb8, Offset: 0xb8b
// Size: 0x6b
function function_620d06fa3e8848a2( note, flagname, customfunction, customparams )
{
    switch ( note )
    {
        case #"hash_472546bae3eac510":
            self orientmode( "face enemy" );
            self animmode( "normal" );
            asm::asm_fireevent( self.asmname, "code_move" );
            break;
    }
}

// Namespace smokebomb
// Params 3
// Checksum 0xd33cf9ae, Offset: 0xbfe
// Size: 0xe8
function function_d43c315f48d42472( asmname, statename, params )
{
    var_87e3e662c7aab3d5 = -40;
    var_411971cf8a972d19 = 40;
    
    if ( isdefined( self.var_274608bab2c25acb ) )
    {
        var_411971cf8a972d19 = self.var_274608bab2c25acb;
    }
    
    zdiff = self.enemy.origin[ 2 ] - self.origin[ 2 ];
    meleealias = "attack";
    
    if ( zdiff >= var_411971cf8a972d19 )
    {
        meleealias = "high_attack";
    }
    else if ( zdiff <= var_87e3e662c7aab3d5 || isplayer( self.enemy ) && self.enemy getstance() == "prone" )
    {
        meleealias = "low_attack";
    }
    
    meleeanim = asm::asm_lookupanimfromalias( statename, meleealias );
    return meleeanim;
}

