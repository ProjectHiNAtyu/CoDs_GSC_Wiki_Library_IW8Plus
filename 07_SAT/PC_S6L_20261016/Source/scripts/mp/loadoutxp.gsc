// scripts\mp\loadoutxp.gsc  (hash_77303551f720e8e8.gscc) (size: 6289 Bytes / 0x1891 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb871d8f6 (3094468854)
// size ...... 6289 (0x1891)
// includes .. 9   (offset: 0x1829)
// strings ... 2   (offset: 0x1871)
// dev strs .. 0   (offset: 0x1891)
// exports ... 18  (offset: 0x1071)
// cseg ...... 0x75 + 0xffc (0x1071)
// imports ... 39  (offset: 0x1341)
// animtree1 . 0   (offset: 0x1891)
// animtree2 . 0   (offset: 0x1891)
#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\common\script;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\loot;
#using scripts\mp\equipment;
#using scripts\mp\flags;
#using scripts\mp\supers;

#namespace loadoutxp;

// Namespace loadoutxp
// Params 0, eflags: 0x1
// Checksum 0x89350abc, Offset: 0x93
// Size: 0xa
function autoexec preinit()
{
    level thread function_b81fe3a7e1d95228();
}

// Namespace loadoutxp
// Params 0, eflags: 0x4
// Checksum 0x77f6435e, Offset: 0xa5
// Size: 0x49
function private function_b81fe3a7e1d95228()
{
    level endon( #"game_ended" );
    flags::function_2f3408423ccc9b2e( "score_event_init_done" );
    level.var_72fd0d3e0e534637 = level.var_e2148c9fc8f801b1 && challenges::challengesenabled();
    
    if ( level.var_72fd0d3e0e534637 )
    {
        init();
    }
}

// Namespace loadoutxp
// Params 0, eflags: 0x4
// Checksum 0x4a752cc8, Offset: 0xf6
// Size: 0xb8
function private init()
{
    callback::add( #"loadout_given", &loadoutgiven );
    callback::add( #"hash_9622b7d2625165be", &function_bbcc4c72ef993f79 );
    callback::add( #"game_ended", &gameended );
    callback::add( #"player_death", &playerkilled );
    callback::add( #"player_disconnect", &playerdisconnect );
    callback::add( #"killstreak_activated", &onsuccessfulstreakactivation );
    callback::add( #"on_used_super", &function_7c22a3bc6a315a9b );
    callback::add( #"equipment_use_success", &function_b67c6072978bb716 );
    level.var_4a6ab8d878dcdb93 = &giveloadoutxp;
}

// Namespace loadoutxp
// Params 1, eflags: 0x4
// Checksum 0x93df75a7, Offset: 0x1b6
// Size: 0x72
function private function_bbcc4c72ef993f79( params )
{
    self endon( #"death_or_disconnect" );
    
    if ( !self.var_c2910df95cb8d2c2 )
    {
        return;
    }
    
    info = structcopy( self.var_c2910df95cb8d2c2 );
    var_f8214e332dc1b632 = gettime();
    script::waittillslowprocessallowed( 1, 1 );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    function_10437e5f6407f5c1( info, var_f8214e332dc1b632 );
    function_423ab163b587b28( info );
}

// Namespace loadoutxp
// Params 1, eflags: 0x4
// Checksum 0xbdbcc010, Offset: 0x230
// Size: 0x7e
function private playerkilled( params )
{
    attacker = params.attacker;
    
    if ( !isdefined( attacker ) )
    {
        return;
    }
    
    attacker endon( #"death_or_disconnect" );
    
    if ( !attacker.var_c2910df95cb8d2c2 )
    {
        return;
    }
    
    attacker notify( #"hash_236d60452349835a" );
    attacker endon( #"hash_236d60452349835a" );
    script::waittillslowprocessallowed( 1, 1 );
    
    if ( !isdefined( attacker ) )
    {
        return;
    }
    
    attacker function_c41f65d73af9eec4();
}

// Namespace loadoutxp
// Params 1, eflags: 0x4
// Checksum 0xaf25ab17, Offset: 0x2b6
// Size: 0x15
function private playerdisconnect( params )
{
    profilestart();
    function_c41f65d73af9eec4();
    profilestop();
}

// Namespace loadoutxp
// Params 1, eflags: 0x4
// Checksum 0x30be7e2e, Offset: 0x2d3
// Size: 0x84
function private onsuccessfulstreakactivation( params )
{
    if ( !self.var_c2910df95cb8d2c2 )
    {
        return;
    }
    
    if ( !params.streakinfo.bundle.var_868a0aca69dc2282 )
    {
        return;
    }
    
    giveloadoutxp( undefined, params.streakinfo.bundle.var_868a0aca69dc2282, params.streakinfo.bundle.lootid );
}

// Namespace loadoutxp
// Params 1, eflags: 0x4
// Checksum 0x7851ca56, Offset: 0x35f
// Size: 0xa2
function private function_7c22a3bc6a315a9b( params )
{
    if ( !self.var_c2910df95cb8d2c2 )
    {
        return;
    }
    
    if ( !params.superinfo.staticdata.bundle.var_e70074db1fa0b0e5 )
    {
        return;
    }
    
    giveloadoutxp( undefined, params.superinfo.staticdata.bundle.var_e70074db1fa0b0e5, params.superinfo.staticdata.bundle.lootid );
}

// Namespace loadoutxp
// Params 1, eflags: 0x4
// Checksum 0xa9d8dd31, Offset: 0x409
// Size: 0x84
function private function_b67c6072978bb716( params )
{
    if ( !self.var_c2910df95cb8d2c2 )
    {
        return;
    }
    
    if ( !params.tableinfo.bundle.var_e70074db1fa0b0e5 )
    {
        return;
    }
    
    giveloadoutxp( undefined, params.tableinfo.bundle.var_e70074db1fa0b0e5, params.tableinfo.bundle.lootid );
}

// Namespace loadoutxp
// Params 0, eflags: 0x4
// Checksum 0xe0347fe1, Offset: 0x495
// Size: 0x3e
function private function_c41f65d73af9eec4()
{
    profilestart();
    
    if ( !self.var_c2910df95cb8d2c2 )
    {
        profilestop();
        return;
    }
    
    function_10437e5f6407f5c1( self.var_c2910df95cb8d2c2, gettime() );
    function_423ab163b587b28( self.var_c2910df95cb8d2c2 );
    function_e51ab8de87ebc3cb();
    profilestop();
}

// Namespace loadoutxp
// Params 0, eflags: 0x4
// Checksum 0xa9922479, Offset: 0x4db
// Size: 0x4f
function private function_e51ab8de87ebc3cb()
{
    self.var_c2910df95cb8d2c2.var_63b8288544b6c843 = gettime();
    self.var_c2910df95cb8d2c2.loadoutxp = [ 8:0, 7:0, 6:0, 5:0, 0, 3:0, 2:0, 1:0 ];
}

// Namespace loadoutxp
// Params 1, eflags: 0x4
// Checksum 0xfd454617, Offset: 0x532
// Size: 0xe7
function private gameended( params )
{
    assert( self == level );
    endtime = gettime();
    script::waittillslowprocessallowed( 1, 1 );
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !isdefined( player.var_c2910df95cb8d2c2 ) )
        {
            continue;
        }
        
        player function_10437e5f6407f5c1( player.var_c2910df95cb8d2c2, endtime );
        player function_423ab163b587b28( player.var_c2910df95cb8d2c2 );
    }
}

// Namespace loadoutxp
// Params 2, eflags: 0x4
// Checksum 0xa053d7e0, Offset: 0x621
// Size: 0x137
function private function_10437e5f6407f5c1( info, endtime )
{
    if ( !level.var_7f87aa229a65fa05 )
    {
        return;
    }
    
    if ( !challenges::challengesenabledforplayer() )
    {
        return;
    }
    
    var_f09fd847ecee19cc = endtime - ( info.var_63b8288544b6c843 ?? 0 );
    
    if ( var_f09fd847ecee19cc < 0 )
    {
        return;
    }
    
    var_15749c938055cd7 = var_f09fd847ecee19cc * 0.001 / 60 * ( level.var_7f87aa229a65fa05 ?? 0 ) + ( self.pers[ #"hash_d40edc06b6ebfa47" ] ?? 0 );
    
    if ( var_15749c938055cd7 <= 0 )
    {
        return;
    }
    
    var_c33512f5cbb55f78 = int( floor( var_15749c938055cd7 ) );
    self.pers[ #"hash_d40edc06b6ebfa47" ] = var_15749c938055cd7 - var_c33512f5cbb55f78;
    
    for ( slot = 1; slot <= 10 ; slot++ )
    {
        if ( !info.loadoutlootid[ slot ] )
        {
            continue;
        }
        
        if ( !isdefined( info.loadoutxp[ slot ] ) )
        {
            info.loadoutxp[ slot ] = 0;
        }
        
        info.loadoutxp[ slot ] += var_c33512f5cbb55f78;
    }
}

// Namespace loadoutxp
// Params 1, eflags: 0x4
// Checksum 0xce6bf2e4, Offset: 0x760
// Size: 0x598
function private function_423ab163b587b28( info )
{
    aeeventname = #"loadout_xp";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [];
    
    if ( info.loadoutlootid[ 1 ] && info.loadoutxp[ 1 ] )
    {
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_d73a6e5ac18f8404" ) ] = info.loadoutxp[ 1 ] ?? 0;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_189b8a880a063e19" ) ] = info.loadoutlootid[ 1 ] ?? 0;
    }
    
    if ( info.loadoutlootid[ 2 ] && info.loadoutxp[ 2 ] )
    {
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_157586121588c63" ) ] = info.loadoutxp[ 2 ] ?? 0;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_e5f674ef74dd1294" ) ] = info.loadoutlootid[ 2 ] ?? 0;
    }
    
    if ( info.loadoutlootid[ 3 ] && info.loadoutxp[ 3 ] )
    {
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_d856626c6c055222" ) ] = info.loadoutxp[ 3 ] ?? 0;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_7c8336f8a4887167" ) ] = info.loadoutlootid[ 3 ] ?? 0;
    }
    
    if ( info.loadoutlootid[ 4 ] && info.loadoutxp[ 4 ] )
    {
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_2e85ac740740a9a1" ) ] = info.loadoutxp[ 4 ] ?? 0;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_44b7dc7b485b9802" ) ] = info.loadoutlootid[ 4 ] ?? 0;
    }
    
    if ( info.loadoutlootid[ 5 ] && info.loadoutxp[ 5 ] )
    {
        if ( !isdefined( var_32104ba222114444 ) )
        {
            var_32104ba222114444 = level.streakglobals.var_32104ba222114444;
        }
        
        var_5f429aeecb6159c4 = var_32104ba222114444[ info.loadoutlootid[ 5 ] ] ?? info.loadoutlootid[ 5 ];
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_5c08967a69ecdb00" ) ] = info.loadoutxp[ 5 ] ?? 0;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_4432beb4bfe0eaa5" ) ] = var_5f429aeecb6159c4 ?? 0;
    }
    
    if ( info.loadoutlootid[ 6 ] && info.loadoutxp[ 6 ] )
    {
        if ( !isdefined( var_32104ba222114444 ) )
        {
            var_32104ba222114444 = level.streakglobals.var_32104ba222114444;
        }
        
        var_5f429aeecb6159c4 = var_32104ba222114444[ info.loadoutlootid[ 6 ] ] ?? info.loadoutlootid[ 6 ];
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_72c60847956ca6f" ) ] = info.loadoutxp[ 6 ] ?? 0;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_3f5d067c623da380" ) ] = var_5f429aeecb6159c4 ?? 0;
    }
    
    if ( info.loadoutlootid[ 7 ] && info.loadoutxp[ 7 ] )
    {
        if ( !isdefined( var_32104ba222114444 ) )
        {
            var_32104ba222114444 = level.streakglobals.var_32104ba222114444;
        }
        
        var_5f429aeecb6159c4 = var_32104ba222114444[ info.loadoutlootid[ 7 ] ] ?? info.loadoutlootid[ 7 ];
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_34af6a8adc03322e" ) ] = info.loadoutxp[ 7 ] ?? 0;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_d5fca4ff22303363" ) ] = var_5f429aeecb6159c4 ?? 0;
    }
    
    if ( info.loadoutlootid[ 8 ] && info.loadoutxp[ 8 ] )
    {
        if ( !isdefined( var_32104ba222114444 ) )
        {
            var_32104ba222114444 = level.streakglobals.var_32104ba222114444;
        }
        
        var_5f429aeecb6159c4 = var_32104ba222114444[ info.loadoutlootid[ 8 ] ] ?? info.loadoutlootid[ 8 ];
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_9e43740daf1465fd" ) ] = info.loadoutxp[ 8 ] ?? 0;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_7ace9f6c9484915e" ) ] = var_5f429aeecb6159c4 ?? 0;
    }
    
    if ( info.loadoutlootid[ 9 ] && info.loadoutxp[ 9 ] )
    {
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_75425e18f9c0f55c" ) ] = info.loadoutxp[ 9 ] ?? 0;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_2d5da85abcf84451" ) ] = info.loadoutlootid[ 9 ] ?? 0;
    }
    
    if ( info.loadoutlootid[ 10 ] && info.loadoutxp[ 10 ] )
    {
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_342cb265a8eb88f2" ) ] = info.loadoutxp[ 10 ] ?? 0;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_5d026618c5195057" ) ] = info.loadoutlootid[ 10 ] ?? 0;
    }
    
    if ( ( eventparams.size ?? 0 ) == 0 )
    {
        return;
    }
    
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = challenges::getchallengegamemode();
    self function_2e45314624fdfdb8( aeeventid, eventparams );
}

// Namespace loadoutxp
// Params 1, eflags: 0x4
// Checksum 0x720daca8, Offset: 0xd00
// Size: 0x185
function private loadoutgiven( params )
{
    var_648d16a68046d1b6 = self.var_648d16a68046d1b6;
    self.var_c2910df95cb8d2c2 = { #loadoutlootid:[ 8:var_648d16a68046d1b6[ #"killstreak" ][ 6 ], 7:var_648d16a68046d1b6[ #"killstreak" ][ 2 ], 6:var_648d16a68046d1b6[ #"killstreak" ][ 1 ], 5:var_648d16a68046d1b6[ #"killstreak" ][ 0 ], var_648d16a68046d1b6[ #"fieldupgrade" ][ 1 ], 3:var_648d16a68046d1b6[ #"fieldupgrade" ][ 0 ], 2:var_648d16a68046d1b6[ #"equipmentsecondary" ], 1:var_648d16a68046d1b6[ #"equipmentprimary" ] ], #loadoutxp:[ 8:0, 7:0, 6:0, 5:0, 0, 3:0, 2:0, 1:0 ], #var_63b8288544b6c843:gettime() };
    
    foreach ( index, lootid in self.var_c2910df95cb8d2c2.loadoutlootid )
    {
        if ( !lootid )
        {
            continue;
        }
        
        self.var_c2910df95cb8d2c2.var_399094cd40ff7b80[ lootid ] = index;
    }
}

// Namespace loadoutxp
// Params 3, eflags: 0x4
// Checksum 0xb3e898d7, Offset: 0xe8d
// Size: 0xd5
function private giveloadoutxp( weaponobj, loadoutxp, lootid = level.var_b14ed74cb5735c94[ weaponobj.basenamehash ] )
{
    if ( !lootid )
    {
        if ( level.var_2bb99f84e2ed1bb4[ weaponobj.basenamehash ] )
        {
            return;
        }
        
        lootid = function_292c64e996d577e1( weaponobj ) ?? weaponobj.baseweaponlootid;
    }
    
    index = self.var_c2910df95cb8d2c2.var_399094cd40ff7b80[ lootid ];
    
    if ( !index )
    {
        return;
    }
    
    if ( !challenges::challengesenabledforplayer() )
    {
        return;
    }
    
    self.var_c2910df95cb8d2c2.loadoutxp[ index ] += loadoutxp;
}

// Namespace loadoutxp
// Params 1, eflags: 0x4
// Checksum 0x3b72c9d2, Offset: 0xf6a
// Size: 0x106
function private function_292c64e996d577e1( weaponobj )
{
    killstreakref = killstreak::getkillstreaknamefromweapon( weaponobj );
    
    if ( killstreakref && killstreakref != "" )
    {
        lootid = loot::getlootidfromref( killstreakref );
        level.var_b14ed74cb5735c94[ weaponobj.basenamehash ] = lootid;
        return lootid;
    }
    
    superref = supers_mp::getsuperrefforsuperoffhand( weaponobj );
    
    if ( superref && superref != "" )
    {
        lootid = loot::getlootidfromref( superref );
        level.var_b14ed74cb5735c94[ weaponobj.basenamehash ] = lootid;
        return lootid;
    }
    
    equipref = equipment_mp::getequipmentreffromweapon( weaponobj );
    
    if ( equipref && equipref != "" )
    {
        lootid = loot::getlootidfromref( equipref );
        level.var_b14ed74cb5735c94[ weaponobj.basenamehash ] = lootid;
        return lootid;
    }
    
    level.var_2bb99f84e2ed1bb4[ weaponobj.basenamehash ] = 1;
}

