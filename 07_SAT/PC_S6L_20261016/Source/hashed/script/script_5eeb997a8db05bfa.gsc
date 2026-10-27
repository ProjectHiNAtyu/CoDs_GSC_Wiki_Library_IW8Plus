// script_5eeb997a8db05bfa  (hash_5eeb997a8db05bfa.gscc) (size: 5999 Bytes / 0x176f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8ec25ec3 (2395102915)
// size ...... 5999 (0x176f)
// includes .. 2   (offset: 0x1683)
// strings ... 16  (offset: 0x1693)
// dev strs .. 2   (offset: 0x1757)
// exports ... 15  (offset: 0xf17)
// cseg ...... 0x13d + 0xdda (0xf17)
// imports ... 45  (offset: 0x116f)
// animtree1 . 0   (offset: 0x176f)
// animtree2 . 0   (offset: 0x176f)
#using scripts\asm\rusher\smokebomb;
#using scripts\common\callbacks;

#namespace namespace_4892f42b0f0df0e5;

// Namespace namespace_4892f42b0f0df0e5
// Params 0, eflags: 0x1
// Checksum 0x4ee4e24e, Offset: 0x15b
// Size: 0x14
function autoexec rusher_init()
{
    level.var_4e5989b0a79b26f1 = loadfxasset( "vfx_sat_smoke_bomb_rusher" );
}

// Namespace namespace_4892f42b0f0df0e5
// Params 0
// Checksum 0x7a1268b, Offset: 0x177
// Size: 0x2
function compile_me()
{
    
}

// Namespace namespace_4892f42b0f0df0e5
// Params 1
// Checksum 0xc5224edb, Offset: 0x181
// Size: 0x156
function function_c0fac85fa0f4aab5( taskid )
{
    setupagent();
    self.var_17d4ea0b216b2d9e = 1;
    self.var_40c8156305f39845 = 1;
    healthmodifier = getdvarint( @"hash_4db8eab33e045701", 0 );
    
    if ( healthmodifier != 0 )
    {
        self.health += healthmodifier;
        self.maxhealth = self.health;
    }
    
    if ( self isscriptable() )
    {
        thread initscriptable();
    }
    
    self.var_4e5989b0a79b26f1 = level.var_4e5989b0a79b26f1;
    
    if ( self.var_a15aadb96a2f16cc )
    {
        self function_a3d3c0070f72e1df();
    }
    
    groundpos = getgroundposition( self.origin, 32 );
    
    if ( getdvarint( @"hash_98874c4025ebe46d", 1 ) == 1 && distancesquared( self.origin, groundpos ) < 400 )
    {
        thread function_ac2a8c7fcf725305();
    }
    
    self.pathenemyfightdist = 0;
    self setstrafeblocked( 1, "bt" );
    self enableavoidance( 1 );
    self.cornercheckenabled = 0;
    self.var_43662c03fff08065 = 1;
    self function_5c50b48c0c81d566( "all", 0, "bt" );
    self.var_f38802177d63ee0f = undefined;
    self.var_723fc92f02f8190f = &function_b6b8c3db0041643d;
    return anim.success;
}

// Namespace namespace_4892f42b0f0df0e5
// Params 0
// Checksum 0x55517328, Offset: 0x2e0
// Size: 0x61
function function_ac2a8c7fcf725305()
{
    waitframe();
    
    if ( self.var_9ba790bbbb4cf695 )
    {
        return;
    }
    
    smokebomb::function_d2b665b584e2aeeb( self.origin );
    smokebomb::function_b448955d5f49e6aa( self.origin, self.angles, getdvarint( @"hash_37448409e13a1af7", 1 ) == 1, 1 );
    self setgoalpos( self.origin, 32 );
}

// Namespace namespace_4892f42b0f0df0e5
// Params 0
// Checksum 0x46635038, Offset: 0x349
// Size: 0x13
function initscriptable()
{
    self setscriptablepartstate( "notetrack_handler", "active", 0 );
}

// Namespace namespace_4892f42b0f0df0e5
// Params 0
// Checksum 0x24933845, Offset: 0x364
// Size: 0x85b
function setupagent()
{
    if ( isdefined( self.aisettings ) && isdefined( self.aisettings.var_c72b569453167cda ) )
    {
        assert( issubstr( self.aisettings.var_fd4aff6c3601f21, "<dev string:x24>" ), "<dev string:x2b>" );
        rusherbundle = getscriptbundle( self.aisettings.var_c72b569453167cda );
        
        if ( isdefined( rusherbundle ) )
        {
            self.meleeonly = rusherbundle.meleeonly;
            
            if ( self.meleeonly )
            {
                self.meleeignoreplayerstance = 1;
            }
            
            if ( rusherbundle.knifemodel != "" )
            {
                self.var_9a00bf024c330775 = getxhashasset( rusherbundle.knifemodel );
                self.var_71ef0f4b1f42cbeb = rusherbundle.var_ae0439e7e2e166fa;
                self.var_a15aadb96a2f16cc = 1;
            }
            
            self.var_f77acc979849ea66 = rusherbundle.var_9f15be83f0a0446b;
            self.var_567f6376e2266ba8 = rusherbundle.var_4cc0fcf96bd96487;
            self.var_56a25976e24c9d62 = rusherbundle.var_4ce3eaf96bff84a9;
            self.var_951a5235529e4a94 = rusherbundle.runduration;
            self.var_51d2145ff9d27b85 = rusherbundle.var_29994bc24975cd72;
            self.var_51f51e5ff9f8d93b = rusherbundle.var_297655c2494f9bb8;
            self.var_4308c8b6165b8779 = rusherbundle.jogduration;
            self.var_1c256ba9eb3a71a0 = rusherbundle.var_9eb73de30e03afb9;
            self.var_1c0181a9eb12274a = rusherbundle.var_9e934fe30ddb5c97;
            self.var_acfc632d2781d26c = rusherbundle.var_d70c675f8463326d;
            self.var_a1d8010160e6f8dc = rusherbundle.flinchcooldown;
            self.var_9d5d30a5646a350 = getdvarint( @"hash_b3b0eeb5c0e71297", rusherbundle.var_1f971d1a33acc1b2 );
            self.var_b22d3da7b1ea4a5a = rusherbundle.var_8d9ff8a33b653105;
            self.var_b25027a7b21061b0 = rusherbundle.var_8dc302a33b8b8ebb;
            self.var_b7c7a4719555d038 = rusherbundle.var_55e2f75f2c369793;
            self.var_b7eaba71957c4852 = rusherbundle.var_56060d5f2c5d0fad;
            self.var_21a4ddc560e0e39 = rusherbundle.var_1dc9d87f602848fc;
            self.var_4c5acc8ca7550254 = rusherbundle.var_b82e61b7594803eb;
            self.var_5ac8458f5c69d67d = rusherbundle.attackrange;
            self.var_fa63c00625040314 = rusherbundle.var_f84501cb12543257;
            self.var_3909abbfcf77dde0 = rusherbundle.var_b11f96817b07f463;
            self.var_a9f29c35468dec2d = rusherbundle.var_ceb0208efb3f9736;
            self.var_a9cf863546677413 = rusherbundle.var_ced3128efb65c024;
            self.var_e5202875e8f53667 = rusherbundle.var_1350f3866fb22fcc;
            self.var_e5431675e91b5689 = rusherbundle.var_132e01866f8c06de;
            self.var_44ca279953fc8633 = rusherbundle.var_e655e35740257912;
            self.var_81f993894cf615a1 = rusherbundle.var_c062940e4883e1d2;
            self.var_6b446b3709e9a6c1 = rusherbundle.var_d5cece46d23dd4f0;
            self.var_655ea6cd527a20aa = rusherbundle.var_f80a1ce6abd056d5;
            self.var_64e929a119a7b6a0 = rusherbundle.var_2300cfc88bc5a6fb;
            self.var_64c53fa1197f6c4a = rusherbundle.var_22ddc5c88b9f4945;
            self.var_a7e8a05375572d9d = rusherbundle.var_6f1c705a7ef59fb0;
            self.var_a7c4aa53752ec8e3 = rusherbundle.var_6ef9665a7ecf41fa;
            self.var_b123461d3810124c = rusherbundle.var_386e83ddc53e0e85;
            self.var_b100541d37e9e95e = rusherbundle.var_38918dddc5646c3b;
            self.var_cc96096c3f06bab7 = rusherbundle.var_acffb4be11072cca;
            self.var_a70fb13d3292652 = rusherbundle.var_662ab65fe96e19af;
            self.var_ce035c13a5fc3b40 = rusherbundle.var_152985606a0a2cb9;
            self.var_55f997730e8b6cd4 = rusherbundle.var_f3c789ae83e7f621;
            self.var_70e56ec91ad8142d = rusherbundle.var_d00fdcbc19a159e;
            self.var_b0ed61be10cff2ef = rusherbundle.var_5088a407a226e900;
            self.var_5dd061105a3d0857 = rusherbundle.var_71eb16fbc95e94b8;
            self.var_abc1cdc1e1127296 = rusherbundle.var_a6e05452be501e67;
            self.var_c4a4a570ec85c0a9 = rusherbundle.var_45311669ddfe9cf2;
            self.var_5d970407a99d3238 = rusherbundle.var_7dd1f407df6ca255;
            self.var_5dba1a07a9c3aa52 = rusherbundle.var_7df4de07df92b9ab;
            self.var_1fe3915aaf7bd1d0 = rusherbundle.var_edcea75912950ca5;
            self.var_1fc0875aaf55741a = rusherbundle.var_edf1b15912bb6a5b;
            self.var_76b544285b1d00c6 = rusherbundle.var_516946a15162d75d;
            self.var_76d856285b437014 = rusherbundle.var_514650a1513ca5a3;
            self.var_242e1fad4885b188 = rusherbundle.var_159b298661cf665b;
            self.var_245115ad48abe342 = rusherbundle.var_15781f8661a908a5;
            self.var_dcb252ebd45a8825 = rusherbundle.var_ab2db2656ce52a28;
            self.var_dcd55cebd480e5db = rusherbundle.var_ab50a8656d0b5be2;
            self.var_3ea959bbdb5f4917 = rusherbundle.var_7b443932943908dc;
            self.var_112e5f438b91c35a = rusherbundle.var_2d92e28e33ccbbe1;
            self.var_115149438bb7dab0 = rusherbundle.var_2db6d48e33f517cf;
            self.var_6e022574c0fd36f4 = rusherbundle.smokeduration;
        }
    }
    
    self.ignoreme = 0;
    self.var_d65bd65272669bdd = "idle";
    self.var_b9ed1dec14d77d2f = "walk";
    self.var_274821e8c167d314 = 100;
    self.radius = 15;
    self.height = 40;
    self.var_3f09c8f65f4845bb = 2250000;
    self.var_26ec714bb40ffc63 = 1;
    self.guid = "RusherAgent" + self getentitynumber();
    self.var_977f373649c76f01 = 1;
    self.var_9bca2548ba3519ac = 1;
    self.var_113dfa17404fa26c = 1;
    self.var_54fc62842ec42c53 = 1;
    self.var_6f42d93a7fc38c74 = 0;
    self.var_c0ae34ecd12a0f0b = 0;
    self.allowcrouch = !self.meleeonly;
    self.var_32120addd78eb2d8 = self.var_5ac8458f5c69d67d;
    
    if ( self.meleeonly )
    {
        self.meleeignorefinalzdiff = 1;
        self allowedstances( "stand" );
    }
    
    self.var_c0b3bed46302bf4d = self.var_32120addd78eb2d8 * 1.5;
    self.var_8df7f1dd9e1adb41 = squared( self.var_5ac8458f5c69d67d );
    self.var_eb4cfef399e23d20 = squared( self.var_32120addd78eb2d8 );
    self.meleechargedistvsplayer = 90;
    self.meleechargedist = 90;
    self.meleebashmaxdistsq = 8100;
    self.var_69e970e30e2b2769 = self.var_eb4cfef399e23d20 * 1.2;
    self.var_cee263b2e4682fd5 = 1;
    self.var_818d2516ea63987 = 1;
    self.defaultgoalradius = self.radius + 1;
    self.died_poorly = 0;
    self.damaged_by_player = 0;
    self.full_gib = 0;
    self.var_f1945ce16e4562c6 = [];
    self.var_dc2a6b856fad88f = 200;
    self.var_696b9f525f45901a = 1;
    self.var_a2424f78b9c416ef = gettime();
    self.lasthittime = [];
    self.teamflashbangimmunity = 1;
    self.var_f556a8d9d6970ec = 1;
    self.var_a9f0556d9f9c656f = self.disablearrivals;
    rad = 15;
    
    if ( isdefined( level.avoidance_radius ) )
    {
        rad = level.avoidance_radius;
    }
    
    self setavoidanceradius( rad );
    
    if ( !isdefined( self.a ) )
    {
        self.a = spawnstruct();
    }
    
    self.a.disablepain = getdvarint( @"hash_38c150c4acc3342a", 0 ) == 1;
    self.lastweapon = self.weapon;
    self.deathfunction = &function_d370a29e37ae60dd;
    thread function_e23b151e1f68cdc2();
    thread function_b7abe7ff6f11b8ff();
    thread function_8399a890b874df62();
    callback::callback( "rusher_agent_setup" );
}

// Namespace namespace_4892f42b0f0df0e5
// Params 0
// Checksum 0x719fe17, Offset: 0xbc7
// Size: 0x35
function function_8399a890b874df62()
{
    self endon( #"death" );
    level waittill( #"game_ended" );
    self clearpath();
    self asmsetstate( self.asmname, "exposed_idle" );
}

// Namespace namespace_4892f42b0f0df0e5
// Params 0
// Checksum 0xd5932683, Offset: 0xc04
// Size: 0xaa
function function_e23b151e1f68cdc2()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"moving_up" );
        var_b2375da1cccc361e = self.battlechatterallowed;
        self.battlechatterallowed = 0;
        
        if ( issubstr( self.agent_type, "cradle" ) )
        {
            if ( soundexists( "dxx_ai_commando_rush_cradled" ) )
            {
                self playsoundatviewheight( #"dxx_ai_commando_rush_cradled" );
            }
        }
        else if ( soundexists( "dxx_ai_commando_rush" ) )
        {
            self playsoundatviewheight( #"dxx_ai_commando_rush" );
        }
        
        wait 2;
        self.battlechatterallowed = var_b2375da1cccc361e;
    }
}

// Namespace namespace_4892f42b0f0df0e5
// Params 0
// Checksum 0x6168f255, Offset: 0xcb6
// Size: 0xc6
function function_b7abe7ff6f11b8ff()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    var_7c08ba48efc7fffc = 0;
    
    while ( true )
    {
        if ( length( self getvelocity() ) == 0 && self.var_d65bd65272669bdd == "move" )
        {
            var_7c08ba48efc7fffc += 0.05;
        }
        else
        {
            var_7c08ba48efc7fffc = 0;
        }
        
        if ( var_7c08ba48efc7fffc > 2 )
        {
            var_9f570d109c44bb68 = self getnegotiationstartnode();
            
            if ( isdefined( var_9f570d109c44bb68 ) )
            {
                dist_sq = distancesquared( self.origin, var_9f570d109c44bb68.origin );
                
                if ( dist_sq < squared( 15 ) )
                {
                    self setorigin( var_9f570d109c44bb68.origin, 0 );
                }
            }
        }
        
        wait 0.05;
    }
}

// Namespace namespace_4892f42b0f0df0e5
// Params 1
// Checksum 0x9696741e, Offset: 0xd84
// Size: 0x2c
function function_67cee59aaa2adb54( taskid )
{
    if ( !self.scripted_mode )
    {
        return anim.failure;
    }
    
    return anim.running;
}

// Namespace namespace_4892f42b0f0df0e5
// Params 2
// Checksum 0xa9faedd2, Offset: 0xdb9
// Size: 0x73
function function_b6b8c3db0041643d( var_28ef6b99d45ca409, var_b4ec81dae2f2e793 = 1000 )
{
    var_28ef6b99d45ca409 = getclosestpointonnavmesh( var_28ef6b99d45ca409, self );
    
    if ( !isdefined( var_28ef6b99d45ca409 ) )
    {
        return;
    }
    
    self.var_c55b4943e375630 = var_28ef6b99d45ca409;
    self.var_431907f499d9ced8 = var_b4ec81dae2f2e793;
    self.var_f518d4273d3d607c = 0.25 * var_b4ec81dae2f2e793;
    self.var_3edd7f91025a113d = 0.8 * var_b4ec81dae2f2e793;
    self.var_d97a00a41238e6b1 = 1;
}

// Namespace namespace_4892f42b0f0df0e5
// Params 0
// Checksum 0xc97be22a, Offset: 0xe34
// Size: 0xc
function function_83e6e0d7db1f108e()
{
    self.var_d97a00a41238e6b1 = 0;
}

// Namespace namespace_4892f42b0f0df0e5
// Params 0
// Checksum 0xd0d0703c, Offset: 0xe48
// Size: 0x9, Type: bool
function function_d370a29e37ae60dd()
{
    self function_70645ed294e955c5();
    return false;
}

// Namespace namespace_4892f42b0f0df0e5
// Params 2
// Checksum 0xde71fdeb, Offset: 0xe5a
// Size: 0xbc
function function_80882dc3f777a01( position, var_b32a27eb085bbeef = 18 )
{
    radius = self.radius ?? 15;
    height = self.height ?? 45;
    startpos = position + ( 0, 0, var_b32a27eb085bbeef );
    endpos = position + ( 0, 0, var_b32a27eb085bbeef * -1 );
    droppedpos = self aiphysicstrace( startpos, endpos, radius, height, 1 );
    
    if ( abs( droppedpos[ 2 ] - startpos[ 2 ] ) < 0.1 )
    {
        return;
    }
    
    if ( abs( droppedpos[ 2 ] - endpos[ 2 ] ) < 0.1 )
    {
        return;
    }
    
    return droppedpos;
}

