// scripts\mp\power_shards.gsc  (hash_50a46890c7322bd1.gscc) (size: 7537 Bytes / 0x1d71 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa5bbf920 (2780559648)
// size ...... 7537 (0x1d71)
// includes .. 8   (offset: 0x1c55)
// strings ... 10  (offset: 0x1c95)
// dev strs .. 7   (offset: 0x1d1d)
// exports ... 25  (offset: 0xff9)
// cseg ...... 0x171 + 0xe88 (0xff9)
// imports ... 74  (offset: 0x13e1)
// animtree1 . 0   (offset: 0x1d71)
// animtree2 . 0   (offset: 0x1d71)
#using script_16ea1b94f0f381b3;
#using script_72d1ece3cbd0884a;
#using script_7c98336d01c2aba2;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\mp\loot\common_item;

#namespace power_shards;

// Namespace power_shards
// Params 0, eflags: 0x1
// Checksum 0x6a2f5aed, Offset: 0x18f
// Size: 0x9
function autoexec main()
{
    function_3b4dfe5c886830b4();
}

// Namespace power_shards
// Params 0
// Checksum 0x78215631, Offset: 0x1a0
// Size: 0x87
function function_3b4dfe5c886830b4()
{
    if ( !common_item::items_isenabled() )
    {
        return;
    }
    
    utility::flag_wait( "common_items_init" );
    utility::add_fx( "power_cores_trail", "vfx_sat_wc_power_cores_trail" );
    scriptable::scriptable_addautousecallback( &function_b7553c6c20e4b836 );
    scriptable::scriptable_addusedcallback( &function_b7553c6c20e4b836 );
    common_item::function_84174b793b5fe9a7( "currency", #"caninteract", &function_b5b809a89d417a27 );
    namespace_4bd17a2ee56036fa::function_5cfef02beb796343( #"power_shard" );
    callback::add( "ob_content_process_create_script", &function_fb9c96141102c14 );
    
    /#
        function_4dc8e930cb1abcbf();
    #/
}

// Namespace power_shards
// Params 6, eflags: 0x4
// Checksum 0xa692e4b6, Offset: 0x22f
// Size: 0xbb
function private function_b7553c6c20e4b836( instance, part, state, player, bautouse, usestring )
{
    if ( instance.pickedup || instance.var_cfea6a18ae2b90c5 )
    {
        return;
    }
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    itembundle = common_item::function_33a2c00e46263d99( instance );
    
    if ( !itembundle )
    {
        return;
    }
    
    subtype = getscriptbundlefieldvalue( itembundle, #"subtype" );
    
    if ( subtype != #"power_shard" )
    {
        return;
    }
    
    thread function_86ac9f5353f199e5( instance, player );
    thread function_4bf8d82a114d3755( instance, itembundle, player );
}

// Namespace power_shards
// Params 2, eflags: 0x4
// Checksum 0x1c5df6c1, Offset: 0x2f2
// Size: 0x64
function private function_86ac9f5353f199e5( instance, player )
{
    level endon( #"game_ended" );
    player endon( #"orb_cleanup" );
    player waittill( #"death_or_disconnect" );
    instance utility::function_7c10ea82c1e305b8( instance.type, #"visible" );
    instance.var_cfea6a18ae2b90c5 = undefined;
}

// Namespace power_shards
// Params 3, eflags: 0x4
// Checksum 0xd492b442, Offset: 0x35e
// Size: 0xf5
function private function_4bf8d82a114d3755( instance, itembundle, player )
{
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    instance utility::function_7c10ea82c1e305b8( instance.type, #"hidden" );
    powershards = getscriptbundlefieldvalue( itembundle, #"powershards" );
    vfxorigin = instance.origin + ( 0, 0, 30 );
    player function_c853c299db2248eb( powershards, vfxorigin );
    instance.var_cfea6a18ae2b90c5 = 1;
    player waittill( #"hash_41a3e90dab05778d" );
    
    if ( !instance )
    {
        player notify( #"orb_cleanup" );
        return;
    }
    
    instance.allowabsorb = 1;
    player common_item::function_2b5e2ff57d5f392( instance, 1, 0 );
    player notify( #"orb_cleanup" );
}

// Namespace power_shards
// Params 1, eflags: 0x4
// Checksum 0x3f9d25cd, Offset: 0x45b
// Size: 0x44, Type: bool
function private function_b5b809a89d417a27( params )
{
    return params.itembundle.subtype != #"power_shard" || params.item.allowabsorb;
}

// Namespace power_shards
// Params 3, eflags: 0x4
// Checksum 0xa7ded245, Offset: 0x4a8
// Size: 0x32
function private function_ba77cf01e384eeba( orbdata, startpoint, endpoint )
{
    return length( endpoint - startpoint ) / orbdata.speed;
}

// Namespace power_shards
// Params 2, eflags: 0x4
// Checksum 0x9fd89e6c, Offset: 0x4e3
// Size: 0x170
function private function_c853c299db2248eb( var_8d56f13c2e31779, spawnlocation )
{
    self.var_265c06a84db4445c = undefined;
    playereye = function_b8ce326d80c0bf9c();
    orbdata = {};
    orbdata.maxarc = getdvarint( @"hash_4b2610a947ebbeaa", var_8d56f13c2e31779.var_aa05592c4c3619c5 ?? 60 );
    orbdata.minarc = getdvarint( @"hash_f9d98a8e0ceb9494", var_8d56f13c2e31779.var_b54577fffc8a412b ?? 25 );
    orbdata.speed = getdvarint( @"hash_99ad7845ed2c601b", var_8d56f13c2e31779.orbspeed ?? 490 );
    orbdata.traveltime = function_ba77cf01e384eeba( orbdata, spawnlocation, playereye );
    orbdata.effectid = utility::getfx( "power_cores_trail" );
    orbdata.var_acef864051de26a1 = 15;
    orbdata.heightadjustment = ( 0, 0, -5 );
    orb = utility::spawn_model( "tag_origin", spawnlocation );
    orb.data = orbdata;
    orb.owner = self;
    orb setentityowner( self );
    playfxontagforclients( orbdata.effectid, orb, "tag_origin", self );
    orb thread monitorownerdeath();
    orb thread function_231da219fd1a3ad0();
}

// Namespace power_shards
// Params 0, eflags: 0x4
// Checksum 0x74c212a7, Offset: 0x65b
// Size: 0x3e
function private monitorownerdeath()
{
    level endon( #"game_ended" );
    self.owner endon( #"orb_cleanup" );
    self.owner waittill( #"death_or_disconnect" );
    cleanuporb();
}

// Namespace power_shards
// Params 0, eflags: 0x4
// Checksum 0x7e5be7db, Offset: 0x6a1
// Size: 0x24
function private function_b8ce326d80c0bf9c()
{
    playereye = self geteye();
    
    if ( self getcamerathirdperson() )
    {
        playereye = self getcamerathirdpersonorigin();
    }
    
    return playereye;
}

// Namespace power_shards
// Params 1, eflags: 0x4
// Checksum 0xa0097741, Offset: 0x6ce
// Size: 0x82
function private function_4da0953a584cb733( zdirection = 0 )
{
    if ( !zdirection && randomint( 100 ) > 50 )
    {
        return randomfloatrange( -1 * self.data.maxarc, -1 * self.data.minarc );
    }
    
    return randomfloatrange( self.data.minarc, self.data.maxarc );
}

// Namespace power_shards
// Params 0, eflags: 0x4
// Checksum 0x912004f3, Offset: 0x759
// Size: 0x7d
function private function_b22776f923325c72()
{
    playereye = self.owner function_b8ce326d80c0bf9c();
    playerang = self.owner getplayerangles();
    forward = anglestoforward( playerang );
    endpoint = playereye + self.data.heightadjustment + self.data.var_acef864051de26a1 * forward;
    return endpoint;
}

// Namespace power_shards
// Params 0, eflags: 0x4
// Checksum 0xf6270caa, Offset: 0x7df
// Size: 0x262
function private function_231da219fd1a3ad0()
{
    level endon( #"game_ended" );
    self.owner endon( #"death_or_disconnect" );
    startpoint = self.origin;
    arcmodifier = ( function_4da0953a584cb733(), function_4da0953a584cb733(), function_4da0953a584cb733( 1 ) );
    endpoint = function_b22776f923325c72();
    time = self.data.traveltime;
    t = 0;
    move_start = gettime();
    
    while ( true )
    {
        if ( !self )
        {
            return;
        }
        
        if ( !self.owner )
        {
            break;
        }
        
        endpoint = function_b22776f923325c72();
        midpoint = ( startpoint + endpoint ) / 2;
        var_e9f987f7a7520eb3 = ( midpoint[ 0 ], midpoint[ 1 ], self.origin[ 2 ] );
        var_96e81673dd3580eb = var_e9f987f7a7520eb3 + arcmodifier;
        t = ( gettime() - move_start ) / 1000 / time;
        
        if ( t <= 1 )
        {
            op1 = pow( 1 - t, 2 );
            op2 = 2 * ( 1 - t ) * t;
            op3 = pow( t, 2 );
            xdest = op1 * startpoint[ 0 ] + op2 * var_96e81673dd3580eb[ 0 ] + op3 * endpoint[ 0 ];
            ydest = op1 * startpoint[ 1 ] + op2 * var_96e81673dd3580eb[ 1 ] + op3 * endpoint[ 1 ];
            zdest = op1 * startpoint[ 2 ] + op2 * var_96e81673dd3580eb[ 2 ] + op3 * endpoint[ 2 ];
            self.origin = ( xdest, ydest, zdest );
        }
        else
        {
            break;
        }
        
        waitframe();
    }
    
    var_4fce0eb9c5457e17 = getdvarint( @"hash_bb5cde77526acda4", 0 );
    
    if ( !self.owner.var_265c06a84db4445c && !var_4fce0eb9c5457e17 )
    {
        self.owner.var_265c06a84db4445c = 1;
        namespace_9d8e359c3b1041e5::playsoundtoplayersharedfunc( #"hash_d30ea14e52499726", self.owner );
    }
    
    self.owner notify( #"hash_41a3e90dab05778d" );
    self.owner utility::waittill_any_timeout( 0.25, "orb_cleanup" );
    cleanuporb();
}

// Namespace power_shards
// Params 0, eflags: 0x4
// Checksum 0x5040287e, Offset: 0xa49
// Size: 0x15
function private cleanuporb()
{
    if ( !self )
    {
        return;
    }
    
    self setentityowner( undefined );
    self delete();
}

/#

    // Namespace power_shards
    // Params 0, eflags: 0x4
    // Checksum 0x76748ff8, Offset: 0xa66
    // Size: 0x5a, Type: dev
    function private function_4dc8e930cb1abcbf()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x3a>", "<dev string:x40>", &function_e26a75d03cd06ef4 );
        devgui::add_devgui_func( "<dev string:x5b>", "<dev string:x62>", &function_6d8b12ea6ce0f0ce );
        devgui::add_devgui_func( "<dev string:x7e>", "<dev string:x84>", &function_69596b58fff2ce9c );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace power_shards
    // Params 0, eflags: 0x4
    // Checksum 0x1e62b251, Offset: 0xac8
    // Size: 0x15, Type: dev
    function private function_e26a75d03cd06ef4()
    {
        thread function_6a6bff5bae050e9( %"hash_28808f4f0ea66027" );
    }

    // Namespace power_shards
    // Params 0, eflags: 0x4
    // Checksum 0x3024b0ec, Offset: 0xae5
    // Size: 0x15, Type: dev
    function private function_6d8b12ea6ce0f0ce()
    {
        thread function_6a6bff5bae050e9( %"hash_1656bfeb0714dfcf" );
    }

    // Namespace power_shards
    // Params 0, eflags: 0x4
    // Checksum 0xf296c030, Offset: 0xb02
    // Size: 0x15, Type: dev
    function private function_69596b58fff2ce9c()
    {
        thread function_6a6bff5bae050e9( %"hash_3f79dca51ae0f87f" );
    }

    // Namespace power_shards
    // Params 1, eflags: 0x4
    // Checksum 0xf48663b2, Offset: 0xb1f
    // Size: 0x180, Type: dev
    function private function_6a6bff5bae050e9( shardbundle )
    {
        activatingplayer = undefined;
        
        foreach ( player in level.players )
        {
            if ( player ishost() )
            {
                activatingplayer = player;
            }
        }
        
        playerangles = activatingplayer getplayerangles();
        var_1456a5c4a368ab40 = function_1747c4a95957448f( activatingplayer.origin, playerangles );
        
        if ( !isdefined( var_1456a5c4a368ab40 ) )
        {
            spawndetails = { #angles:playerangles, #origin:activatingplayer.origin + ( 250, 250, 25 ) };
        }
        else
        {
            spawndetails = { #angles:playerangles, #origin:var_1456a5c4a368ab40 };
        }
        
        switch ( shardbundle )
        {
            case %"hash_28808f4f0ea66027":
                function_105a1767792e9463( spawndetails );
                break;
            case %"hash_1656bfeb0714dfcf":
                function_147047e908f0c6e9( spawndetails );
                break;
            case %"hash_3f79dca51ae0f87f":
                function_e0ce69a54b54f60b( spawndetails );
                break;
            default:
                break;
        }
    }

    // Namespace power_shards
    // Params 2, eflags: 0x4
    // Checksum 0xe859ac49, Offset: 0xca7
    // Size: 0xc9, Type: dev
    function private function_1747c4a95957448f( targetpoint, targetangles )
    {
        var_d946333816aa6583 = 22;
        var_ff79c0f122a821 = 36;
        var_17816a375a70253 = 0.5;
        scoring_player_fov = cos( 60 );
        var_c2d24cfa3b9e1a10 = 16;
        var_35ad3b14b95baa7b = targetpoint;
        var_20dd47a443f5a68f = level;
        var_31ebf063d0ac2c41 = namespace_f4242316def354f7::function_eba1cac9e953fe77( var_d946333816aa6583, var_ff79c0f122a821, var_17816a375a70253, var_35ad3b14b95baa7b, targetangles, scoring_player_fov, var_c2d24cfa3b9e1a10 );
        var_220a51ba4d74353d = namespace_f4242316def354f7::function_92290a260dcb23b();
        namespace_f4242316def354f7::findnearbyspawnpointguaranteed( targetpoint, 600, var_31ebf063d0ac2c41, var_220a51ba4d74353d, var_20dd47a443f5a68f );
        var_20dd47a443f5a68f waittill( #"hash_5c2ff3ac36ee1341", selected_position );
        return selected_position;
    }

#/

// Namespace power_shards
// Params 1
// Checksum 0x4453e7b9, Offset: 0xd78
// Size: 0x17f
function function_fb9c96141102c14( sparams )
{
    var_aa72fc23f7515d32 = utility::getstructarray( "content_struct", "variantname" );
    var_685d3c2a5f3d1368 = [];
    var_ff601fd7611ceda0 = [];
    var_c99d82eb2c1a99bc = [];
    
    foreach ( struct in var_aa72fc23f7515d32 )
    {
        if ( !isdefined( struct.content_key ) )
        {
            continue;
        }
        
        switch ( struct.content_key )
        {
            case #"hash_3d2cadbf479a0a89":
                var_685d3c2a5f3d1368[ var_685d3c2a5f3d1368.size ] = struct;
                break;
            case #"hash_c5c7e76930ee4fad":
                var_ff601fd7611ceda0[ var_ff601fd7611ceda0.size ] = struct;
                break;
            case #"hash_d13a71f954d1ee55":
                var_c99d82eb2c1a99bc[ var_c99d82eb2c1a99bc.size ] = struct;
                break;
            default:
                break;
        }
    }
    
    if ( isdefined( level.var_37ee95c5464d47be ) )
    {
        var_685d3c2a5f3d1368 = [[ level.var_37ee95c5464d47be ]]( "power_shard", var_685d3c2a5f3d1368, &function_e0ce69a54b54f60b );
        var_ff601fd7611ceda0 = [[ level.var_37ee95c5464d47be ]]( "power_shard", var_ff601fd7611ceda0, &function_147047e908f0c6e9 );
        var_c99d82eb2c1a99bc = [[ level.var_37ee95c5464d47be ]]( "power_shard", var_c99d82eb2c1a99bc, &function_105a1767792e9463 );
    }
}

// Namespace power_shards
// Params 1, eflags: 0x4
// Checksum 0x47f77bd0, Offset: 0xeff
// Size: 0x4e
function private function_105a1767792e9463( structspawn )
{
    dropbundle = getscriptbundle( %"hash_28808f4f0ea66027" );
    common_item::function_a87dc047f584d2c7( dropbundle, structspawn.origin, structspawn.angles, common_item::function_ea3b3088d82fd357( dropbundle ), 1 );
}

// Namespace power_shards
// Params 1, eflags: 0x4
// Checksum 0x1ab6f791, Offset: 0xf55
// Size: 0x4e
function private function_147047e908f0c6e9( structspawn )
{
    dropbundle = getscriptbundle( %"hash_1656bfeb0714dfcf" );
    common_item::function_a87dc047f584d2c7( dropbundle, structspawn.origin, structspawn.angles, common_item::function_ea3b3088d82fd357( dropbundle ), 1 );
}

// Namespace power_shards
// Params 1, eflags: 0x4
// Checksum 0x6abc7ee8, Offset: 0xfab
// Size: 0x4e
function private function_e0ce69a54b54f60b( structspawn )
{
    dropbundle = getscriptbundle( %"hash_3f79dca51ae0f87f" );
    common_item::function_a87dc047f584d2c7( dropbundle, structspawn.origin, structspawn.angles, common_item::function_ea3b3088d82fd357( dropbundle ), 1 );
}

