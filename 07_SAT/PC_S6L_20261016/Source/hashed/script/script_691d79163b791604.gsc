// script_691d79163b791604  (hash_691d79163b791604.gscc) (size: 8142 Bytes / 0x1fce / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb7a02249 (3080725065)
// size ...... 8142 (0x1fce)
// includes .. 8   (offset: 0x1f06)
// strings ... 2   (offset: 0x1f46)
// dev strs .. 7   (offset: 0x1f7a)
// exports ... 30  (offset: 0x13c2)
// cseg ...... 0x89 + 0x1339 (0x13c2)
// imports ... 56  (offset: 0x1872)
// animtree1 . 0   (offset: 0x1fce)
// animtree2 . 0   (offset: 0x1fce)
#using scripts\common\devgui;
#using scripts\common\scripted_widgets;
#using scripts\common\utility;
#using scripts\mp\ammomods\ammo_mod;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\teams;
#using scripts\mp\gamelogic;

#namespace clash_ops_rewards;

// Namespace clash_ops_rewards
// Params 0
// Checksum 0x919ac118, Offset: 0xa7
// Size: 0x5d
function ensureinit()
{
    if ( level.var_b4f5d478cf93f9a3 )
    {
        return;
    }
    
    level.var_b4f5d478cf93f9a3 = { #var_46a4974d63c4cbbc:[], #var_9add203e4823ba3c:[], #var_c9406560d0978b30:[], #ammomodpool:[], #perkpool:[] };
    loadpool();
    
    /#
        level thread function_5715ac416b1aab22();
    #/
}

// Namespace clash_ops_rewards
// Params 0
// Checksum 0x17074291, Offset: 0x10c
// Size: 0x1d6
function loadpool()
{
    rewardid = 1;
    
    if ( level.var_4e147a96a4a5740d.rewardpool )
    {
        foreach ( entry in level.var_4e147a96a4a5740d.rewardpool )
        {
            rewardentry = { #weight:entry.weight ?? 1, #var_c93f3e77d52281f8:entry.var_c93f3e77d52281f8, #type:entry.type, #id:rewardid };
            rewardid++;
            
            if ( rewardentry.type == #"perk" )
            {
                level.var_b4f5d478cf93f9a3.perkpool[ level.var_b4f5d478cf93f9a3.perkpool.size ] = rewardentry;
                continue;
            }
            
            if ( rewardentry.type == #"ammo_mod" )
            {
                level.var_b4f5d478cf93f9a3.ammomodpool[ level.var_b4f5d478cf93f9a3.ammomodpool.size ] = rewardentry;
                continue;
            }
            
            if ( rewardentry.type == #"double_points" )
            {
                level.var_b4f5d478cf93f9a3.var_c29ec973052e014 = 1;
                level thread function_3b7241377ac0c9d1();
                continue;
            }
            
            assertmsg( "<dev string:x24>" + entry.type );
        }
    }
}

// Namespace clash_ops_rewards
// Params 1
// Checksum 0x3dd051c0, Offset: 0x2ea
// Size: 0x15
function onplayerconnect( player )
{
    player function_14ecf183432df3f8();
}

// Namespace clash_ops_rewards
// Params 1
// Checksum 0xb38218b5, Offset: 0x307
// Size: 0x4b
function onplayerspawn( player )
{
    player setclientomnvar( o"hash_433ef1817ea9e0e5", 0 );
    player thread function_6e8e8815d3e41a1f();
    
    if ( player && level.var_b4f5d478cf93f9a3.var_c29ec973052e014 )
    {
        player function_94a17933f583a943();
    }
}

// Namespace clash_ops_rewards
// Params 0, eflags: 0xc
// Checksum 0xf53132dc, Offset: 0x35a
// Size: 0xf6
function private function_6e8e8815d3e41a1f()
{
    self notify( #"hash_7b57b4a431762e45" );
    self endon( #"hash_7b57b4a431762e45" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    waitframe();
    ensureinit();
    
    if ( !self.team )
    {
        return;
    }
    
    var_545e371a62335624 = level.var_b4f5d478cf93f9a3.var_c9406560d0978b30[ self.team ];
    
    if ( !var_545e371a62335624 )
    {
        return;
    }
    
    foreach ( rewardid in var_545e371a62335624 )
    {
        self setclientomnvar( o"hash_433ef1817ea9e0e5", rewardid );
        wait 0.15;
    }
}

// Namespace clash_ops_rewards
// Params 2
// Checksum 0x3b4b6efe, Offset: 0x458
// Size: 0x7e
function function_1abc637181e4ab6c( team, task )
{
    ensureinit();
    
    if ( level.var_b4f5d478cf93f9a3.perkpool.size > 0 )
    {
        function_cbee1e44520a562f( team );
    }
    
    /#
        if ( getdvarint( @"hash_a4f4828097164912", 0 ) > 0 )
        {
            function_2006ebe2a306405b( team );
            return;
        }
    #/
    
    if ( randomint( 2 ) == 0 )
    {
        function_2006ebe2a306405b( team );
        return;
    }
    
    function_d325653b0f8e7a2e( team );
}

// Namespace clash_ops_rewards
// Params 1, eflags: 0x4
// Checksum 0x406c4588, Offset: 0x4de
// Size: 0xf1
function private function_cbee1e44520a562f( team )
{
    reward = function_489ff95d5e68e245( team );
    
    if ( !reward )
    {
        return;
    }
    
    function_49783098c96734fd( team, reward.id );
    function_d35b78a2202fedad( team, reward );
    teamplayers = teams::getteamdata( team, "players" );
    
    foreach ( player in teamplayers )
    {
        player thread function_14ecf183432df3f8();
        player thread function_443a19ef1948d1af( reward );
        player setclientomnvar( o"hash_433ef1817ea9e0e5", reward.id );
    }
}

// Namespace clash_ops_rewards
// Params 2, eflags: 0x4
// Checksum 0x5332f98c, Offset: 0x5d7
// Size: 0x13d
function private function_d35b78a2202fedad( team, reward )
{
    if ( !reward.var_c93f3e77d52281f8 )
    {
        return;
    }
    
    if ( !isdefined( level.var_b4f5d478cf93f9a3.var_9add203e4823ba3c[ team ] ) )
    {
        level.var_b4f5d478cf93f9a3.var_9add203e4823ba3c[ team ] = [];
    }
    
    foreach ( perkref in reward.var_c93f3e77d52281f8 )
    {
        if ( !perkref.ref )
        {
            continue;
        }
        
        if ( !arraycontains( level.var_b4f5d478cf93f9a3.var_9add203e4823ba3c[ team ], perkref.ref ) )
        {
            level.var_b4f5d478cf93f9a3.var_9add203e4823ba3c[ team ][ level.var_b4f5d478cf93f9a3.var_9add203e4823ba3c[ team ].size ] = perkref.ref;
        }
    }
}

// Namespace clash_ops_rewards
// Params 1, eflags: 0x4
// Checksum 0x66062918, Offset: 0x71c
// Size: 0x101
function private function_489ff95d5e68e245( team )
{
    awardedids = level.var_b4f5d478cf93f9a3.var_c9406560d0978b30[ team ] ?? [];
    candidates = [];
    weights = [];
    
    foreach ( entry in level.var_b4f5d478cf93f9a3.perkpool )
    {
        if ( arraycontains( awardedids, entry.id ) )
        {
            continue;
        }
        
        candidates[ candidates.size ] = entry;
        weights[ weights.size ] = entry.weight;
    }
    
    if ( candidates.size == 0 )
    {
        return;
    }
    
    return utility::random_weighted( candidates, weights );
}

// Namespace clash_ops_rewards
// Params 2, eflags: 0x4
// Checksum 0x6f2f6d61, Offset: 0x826
// Size: 0x95
function private function_49783098c96734fd( team, rewardid )
{
    if ( !isdefined( level.var_b4f5d478cf93f9a3.var_c9406560d0978b30[ team ] ) )
    {
        level.var_b4f5d478cf93f9a3.var_c9406560d0978b30[ team ] = [];
    }
    
    if ( !arraycontains( level.var_b4f5d478cf93f9a3.var_c9406560d0978b30[ team ], rewardid ) )
    {
        level.var_b4f5d478cf93f9a3.var_c9406560d0978b30[ team ][ level.var_b4f5d478cf93f9a3.var_c9406560d0978b30[ team ].size ] = rewardid;
    }
}

// Namespace clash_ops_rewards
// Params 2, eflags: 0x4
// Checksum 0x6a63c453, Offset: 0x8c3
// Size: 0x59
function private function_a296c4c6999d0daa( player, ammomodname )
{
    if ( !scripted_widgets::is_active( "scripted_widget_clash_ops_ammo_mod" ) )
    {
        widget = scripted_widgets::function_652736891a41e948( "scripted_widget_clash_ops_ammo_mod" );
        player scripted_widgets::create( "scripted_widget_clash_ops_ammo_mod", widget );
        scripted_widgets::set_param( "scripted_widget_clash_ops_ammo_mod", ammomodname );
    }
}

// Namespace clash_ops_rewards
// Params 1, eflags: 0x4
// Checksum 0x8d08173f, Offset: 0x924
// Size: 0x28
function private function_432c6050ea4ba506( player )
{
    if ( scripted_widgets::is_active( "scripted_widget_clash_ops_ammo_mod" ) )
    {
        player scripted_widgets::destroy( "scripted_widget_clash_ops_ammo_mod" );
    }
}

// Namespace clash_ops_rewards
// Params 1, eflags: 0x4
// Checksum 0xaf5a2b9a, Offset: 0x954
// Size: 0xfa
function private function_2006ebe2a306405b( team )
{
    if ( level.var_b4f5d478cf93f9a3.ammomodpool.size == 0 )
    {
        return;
    }
    
    teamplayers = teams::getteamdata( team, "players" );
    
    foreach ( player in teamplayers )
    {
        reward = player function_309ca534e47f95e1();
        
        if ( !reward )
        {
            continue;
        }
        
        player function_583d187c9ac992f5( reward.id );
        ammomodname = function_d0750be6ce095434( reward );
        
        if ( !ammomodname )
        {
            continue;
        }
        
        player thread applyammomod( ammomodname );
    }
}

// Namespace clash_ops_rewards
// Params 0, eflags: 0x4
// Checksum 0xe04bf3a2, Offset: 0xa56
// Size: 0x116
function private function_309ca534e47f95e1()
{
    if ( level.var_b4f5d478cf93f9a3.ammomodpool.size == 0 )
    {
        return;
    }
    
    if ( !isdefined( self.var_d817f736d2ec22d7 ) )
    {
        self.var_d817f736d2ec22d7 = [];
    }
    
    awardedids = self.var_d817f736d2ec22d7;
    candidates = [];
    weights = [];
    
    foreach ( entry in level.var_b4f5d478cf93f9a3.ammomodpool )
    {
        if ( arraycontains( awardedids, entry.id ) )
        {
            continue;
        }
        
        candidates[ candidates.size ] = entry;
        weights[ weights.size ] = entry.weight;
    }
    
    if ( candidates.size == 0 )
    {
        return;
    }
    
    return utility::random_weighted( candidates, weights );
}

// Namespace clash_ops_rewards
// Params 1, eflags: 0x4
// Checksum 0x433b0c1b, Offset: 0xb75
// Size: 0x4c
function private function_583d187c9ac992f5( rewardid )
{
    if ( !isdefined( self.var_d817f736d2ec22d7 ) )
    {
        self.var_d817f736d2ec22d7 = [];
    }
    
    if ( !arraycontains( self.var_d817f736d2ec22d7, rewardid ) )
    {
        self.var_d817f736d2ec22d7[ self.var_d817f736d2ec22d7.size ] = rewardid;
    }
}

// Namespace clash_ops_rewards
// Params 1, eflags: 0x4
// Checksum 0x2f1d807b, Offset: 0xbc9
// Size: 0x3e
function private function_d0750be6ce095434( reward )
{
    assert( reward.var_c93f3e77d52281f8.size > 0, "<dev string:x6e>" );
    return reward.var_c93f3e77d52281f8[ 0 ].ref;
}

// Namespace clash_ops_rewards
// Params 1, eflags: 0x4
// Checksum 0xe25ad62c, Offset: 0xc10
// Size: 0xbd
function private function_443a19ef1948d1af( reward )
{
    assert( reward.var_c93f3e77d52281f8.size > 0, "<dev string:xa9>" );
    
    foreach ( perkref in reward.var_c93f3e77d52281f8 )
    {
        if ( !perkref.ref )
        {
            continue;
        }
        
        perk::giveperk( perkref.ref );
    }
}

// Namespace clash_ops_rewards
// Params 0, eflags: 0xc
// Checksum 0x72a41bf3, Offset: 0xcd5
// Size: 0x4e
function private function_14ecf183432df3f8()
{
    self notify( #"hash_eb5c1644c76c3826" );
    self endon( #"hash_eb5c1644c76c3826" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"giveloadout" );
        function_8552236dc6f84fc6();
    }
}

// Namespace clash_ops_rewards
// Params 0, eflags: 0x4
// Checksum 0x687140a, Offset: 0xd2b
// Size: 0xa2
function private function_8552236dc6f84fc6()
{
    perkrefs = level.var_b4f5d478cf93f9a3.var_9add203e4823ba3c[ self.team ];
    
    if ( !perkrefs )
    {
        return;
    }
    
    foreach ( perkref in perkrefs )
    {
        perk::giveperk( perkref );
    }
}

// Namespace clash_ops_rewards
// Params 1, eflags: 0x4
// Checksum 0x90b37c08, Offset: 0xdd5
// Size: 0x97
function private applyammomod( ammomodname )
{
    self.var_794a92e2ff5aad24 = ammomodname;
    
    /#
        var_109550c79f8165b4 = getdvar( @"hash_409d8e418d6cfa1e", "<dev string:xdc>" );
        
        if ( var_109550c79f8165b4 )
        {
            self.var_794a92e2ff5aad24 = var_109550c79f8165b4;
        }
    #/
    
    thread function_f94e3f696fb048c4();
    self.var_ba1165828e9b92df = self.class;
    
    if ( self.primaryweaponobj )
    {
        function_a296c4c6999d0daa( self, self.var_794a92e2ff5aad24 );
        ammo_mod::add_ammo_mod_to_weapon( self.primaryweaponobj, self.var_794a92e2ff5aad24 );
    }
}

// Namespace clash_ops_rewards
// Params 0, eflags: 0xc
// Checksum 0x996cef5e, Offset: 0xe74
// Size: 0xde
function private function_f94e3f696fb048c4()
{
    self notify( #"hash_f0a2dd182279e192" );
    self endon( #"hash_f0a2dd182279e192" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"giveloadout" );
        
        if ( !self.var_794a92e2ff5aad24 )
        {
            continue;
        }
        
        if ( self.class == self.var_ba1165828e9b92df )
        {
            if ( self.primaryweaponobj )
            {
                function_a296c4c6999d0daa( self, self.var_794a92e2ff5aad24 );
                ammo_mod::add_ammo_mod_to_weapon( self.primaryweaponobj, self.var_794a92e2ff5aad24 );
            }
            
            continue;
        }
        
        if ( self.primaryweaponobj )
        {
            ammo_mod::function_e6267ae500506234( self.primaryweaponobj );
        }
        
        function_432c6050ea4ba506( self );
        self.var_794a92e2ff5aad24 = undefined;
        self.var_ba1165828e9b92df = undefined;
    }
}

// Namespace clash_ops_rewards
// Params 1, eflags: 0x4
// Checksum 0x26ef43a0, Offset: 0xf5a
// Size: 0x46
function private function_d325653b0f8e7a2e( team )
{
    if ( !level.var_b4f5d478cf93f9a3.var_c29ec973052e014 )
    {
        return;
    }
    
    level.var_b4f5d478cf93f9a3.var_46a4974d63c4cbbc[ team ] = 1;
    function_6022bbbbadfdef2c( team );
}

// Namespace clash_ops_rewards
// Params 0, eflags: 0x4
// Checksum 0x83b03425, Offset: 0xfa8
// Size: 0x2a
function private function_3b7241377ac0c9d1()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"hash_974fecacc94e1b75" );
        function_7f347b9e3aef49f5();
    }
}

// Namespace clash_ops_rewards
// Params 1, eflags: 0x4
// Checksum 0x2144aeca, Offset: 0xfda
// Size: 0xbc
function private function_6022bbbbadfdef2c( team )
{
    teamplayers = teams::getteamdata( team, "players" );
    
    foreach ( player in teamplayers )
    {
        player function_95229e1ae84b0321( 2 );
        player setclientomnvar( o"hash_b2c726bcaccdadb7", 1 );
    }
    
    waitframe();
    dialog::leaderdialogonplayers( #"trial_double_points", teamplayers );
}

// Namespace clash_ops_rewards
// Params 0, eflags: 0x4
// Checksum 0xa17c488e, Offset: 0x109e
// Size: 0xd7
function private function_7f347b9e3aef49f5()
{
    foreach ( player in level.players )
    {
        if ( player.team && level.var_b4f5d478cf93f9a3.var_46a4974d63c4cbbc[ player.team ] == 1 )
        {
            player function_95229e1ae84b0321( 1 );
            player setclientomnvar( o"hash_b2c726bcaccdadb7", 0 );
        }
    }
    
    level.var_b4f5d478cf93f9a3.var_46a4974d63c4cbbc = [];
}

// Namespace clash_ops_rewards
// Params 0
// Checksum 0xe6d7efe2, Offset: 0x117d
// Size: 0x3b
function function_94a17933f583a943()
{
    if ( self.team && level.var_b4f5d478cf93f9a3.var_46a4974d63c4cbbc[ self.team ] == 1 )
    {
        function_95229e1ae84b0321( 2 );
    }
}

// Namespace clash_ops_rewards
// Params 1, eflags: 0x4
// Checksum 0x347f93c8, Offset: 0x11c0
// Size: 0x17
function private function_95229e1ae84b0321( scalar )
{
    self.point_scalar = scalar;
}

/#

    // Namespace clash_ops_rewards
    // Params 0
    // Checksum 0x7af80d85, Offset: 0x11df
    // Size: 0x115, Type: dev
    function function_5715ac416b1aab22()
    {
        level endon( #"game_ended" );
        
        while ( !level.var_4e147a96a4a5740d )
        {
            waitframe();
        }
        
        ensureinit();
        
        while ( !level.var_b4f5d478cf93f9a3.ammomodpool )
        {
            waitframe();
        }
        
        foreach ( i, reward in level.var_b4f5d478cf93f9a3.ammomodpool )
        {
            if ( !reward.var_c93f3e77d52281f8.size )
            {
                continue;
            }
            
            ammomodname = function_d0750be6ce095434( reward );
            
            if ( !ammomodname )
            {
                continue;
            }
            
            devgui::function_cd4e263c1f3018ae( "<dev string:xdd>" + ammomodname, "<dev string:x102>" + i, &function_866bd978125f6b96, 0, i );
        }
        
        logstring( "<dev string:x11d>" );
    }

    // Namespace clash_ops_rewards
    // Params 1
    // Checksum 0x39d6f8d7, Offset: 0x12fc
    // Size: 0xc6, Type: dev
    function function_866bd978125f6b96( params )
    {
        index = int( params[ 0 ] );
        
        if ( !level.var_b4f5d478cf93f9a3.ammomodpool )
        {
            return;
        }
        
        if ( index < 0 || index >= level.var_b4f5d478cf93f9a3.ammomodpool.size )
        {
            return;
        }
        
        reward = level.var_b4f5d478cf93f9a3.ammomodpool[ index ];
        
        if ( !reward.var_c93f3e77d52281f8.size )
        {
            return;
        }
        
        ammomodname = function_d0750be6ce095434( reward );
        
        if ( !ammomodname )
        {
            return;
        }
        
        host = gamelogic_mp::gethostplayer();
        
        if ( host )
        {
            host applyammomod( ammomodname );
        }
    }

#/
