// script_1d1a071d172fd938  (hash_1d1a071d172fd938.gscc) (size: 2654 Bytes / 0xa5e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x350787d8 (889685976)
// size ...... 2654 (0xa5e)
// includes .. 4   (offset: 0x9ba)
// strings ... 2   (offset: 0x9da)
// dev strs .. 8   (offset: 0x9fa)
// exports ... 12  (offset: 0x46e)
// cseg ...... 0x6f + 0x3ff (0x46e)
// imports ... 30  (offset: 0x64e)
// animtree1 . 0   (offset: 0xa5e)
// animtree2 . 0   (offset: 0xa5e)
#using scripts\mp\br\gametypes\br_armory_kiosk;
#using scripts\mp\br\gametypes\br_dev;
#using scripts\mp\br\gametypes\br_secondary_victory;
#using scripts\mp\br\gametypes\br_secondary_victory_util;

#namespace namespace_750cbbebd1081e7f;

// Namespace namespace_750cbbebd1081e7f
// Params 0, eflags: 0x1
// Checksum 0xbd662229, Offset: 0x8d
// Size: 0x40
function autoexec main()
{
    /#
        iprintln( "<dev string:x24>" + "<dev string:x38>" + "<dev string:x3d>" );
    #/
    
    br_secondary_victory_util::registermission( "cash", &init, &getplayercash );
    
    /#
        br_dev::registerhandlecommand( &function_84b8f67097b27e23 );
    #/
}

// Namespace namespace_750cbbebd1081e7f
// Params 3, eflags: 0x4
// Checksum 0x3eb5205e, Offset: 0xd5
// Size: 0xde
function private init( scriptbundle, maxcash, xpbonus )
{
    assert( scriptbundle.scriptid == "<dev string:x38>" );
    
    /#
        iprintln( "<dev string:x50>" + maxcash + "<dev string:x84>" + xpbonus + "<dev string:x8a>" );
    #/
    
    level.secondaryvictory.var_64e27faf32a25d5d = &function_64e27faf32a25d5d;
    level.secondaryvictory.var_8d3bef423cae23c0 = &function_8d3bef423cae23c0;
    level.secondaryvictory.onkioskpurchase = &onkioskpurchase;
    function_8246bf93975603ae( level.secondaryvictory.maxexfils );
    br_secondary_victory_util::function_12aa07de3f40e3c6( 1 );
    br_secondary_victory_util::function_12a6b5a1caae1219( 1 );
    function_3c781a3c5e547340( maxcash );
    level thread function_29b9e16f339abeb4();
}

// Namespace namespace_750cbbebd1081e7f
// Params 0, eflags: 0x4
// Checksum 0xb5c154e2, Offset: 0x1bb
// Size: 0x23
function private function_29b9e16f339abeb4()
{
    level endon( #"game_ended" );
    level waittill( #"gulag_closed" );
    br_secondary_victory_util::function_12a6b5a1caae1219( 0 );
}

// Namespace namespace_750cbbebd1081e7f
// Params 0, eflags: 0x4
// Checksum 0x147f6ec6, Offset: 0x1e6
// Size: 0x17
function private function_64e27faf32a25d5d()
{
    br_secondary_victory_util::function_365c973b739b5a8c( "cash", self.team );
}

// Namespace namespace_750cbbebd1081e7f
// Params 0, eflags: 0x4
// Checksum 0x2b2d56c5, Offset: 0x205
// Size: 0x21
function private getplayercash()
{
    var_7237854e3be197ca = self.plundercount;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    return 0;
}

// Namespace namespace_750cbbebd1081e7f
// Params 1, eflags: 0x4
// Checksum 0x7e300954, Offset: 0x22f
// Size: 0x48
function private function_8246bf93975603ae( count )
{
    assert( count > 0 );
    level.secondaryvictory.inventorycount = count;
    br_secondary_victory_util::function_d7a05a475a10368f( level.secondaryvictory.inventorycount );
}

// Namespace namespace_750cbbebd1081e7f
// Params 0, eflags: 0x4
// Checksum 0x736fe322, Offset: 0x27f
// Size: 0x4d
function private function_8a0436106a06e639()
{
    assert( level.secondaryvictory.inventorycount > 0 );
    level.secondaryvictory.inventorycount--;
    br_secondary_victory_util::function_d7a05a475a10368f( level.secondaryvictory.inventorycount );
}

// Namespace namespace_750cbbebd1081e7f
// Params 0, eflags: 0x4
// Checksum 0xc09e4e20, Offset: 0x2d4
// Size: 0x74
function private function_8d3bef423cae23c0()
{
    response = br_secondary_victory::function_2aeac7abf32f6563();
    
    if ( isdefined( level.gulag ) && level.gulag.shutdown )
    {
        /#
            iprintln( "<dev string:x8e>" + self.name + "<dev string:xa9>" );
        #/
        
        response = 0;
    }
    
    if ( response != 2 )
    {
        br_secondary_victory_util::function_5e0cd9df5676b7e8( response, self.origin );
    }
    
    return response;
}

// Namespace namespace_750cbbebd1081e7f
// Params 1, eflags: 0x4
// Checksum 0x9a299b3f, Offset: 0x351
// Size: 0x54
function private onkioskpurchase( cost )
{
    player = self;
    br_armory_kiosk::function_759b296c1e3322a5( "br_sv_exfil", 1 );
    player br_secondary_victory_util::function_34db2671554188b1( cost, level.secondaryvictory.inventorycount );
    function_8a0436106a06e639();
    player br_secondary_victory::function_c7e28ddd986fbc81();
}

// Namespace namespace_750cbbebd1081e7f
// Params 1, eflags: 0x4
// Checksum 0x7b030359, Offset: 0x3ad
// Size: 0x23
function private function_3c781a3c5e547340( cost )
{
    br_secondary_victory_util::function_99c1eb39be1129bb( cost );
    br_armory_kiosk::function_bcf4f6771edcb548( "br_sv_exfil", cost );
}

/#

    // Namespace namespace_750cbbebd1081e7f
    // Params 2
    // Checksum 0x22f5ff5f, Offset: 0x3d8
    // Size: 0x96, Type: dev
    function function_84b8f67097b27e23( command, args )
    {
        switch ( command )
        {
            case #"hash_a9ea817c60179bbf":
                br_secondary_victory_util::function_12aa07de3f40e3c6( int( args[ 0 ] ) );
                break;
            case #"hash_22f1a0a6299aa80":
                br_secondary_victory_util::function_12a6b5a1caae1219( int( args[ 0 ] ) );
                break;
            case #"hash_b3134eabc9b4c82":
                function_3c781a3c5e547340( int( args[ 0 ] ) );
                break;
            case #"hash_d14dd86d102e2aa":
                function_8246bf93975603ae( int( args[ 0 ] ) );
                break;
        }
    }

#/
