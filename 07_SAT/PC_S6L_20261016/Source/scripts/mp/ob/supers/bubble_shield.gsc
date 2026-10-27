// scripts\mp\ob\supers\bubble_shield.gsc  (hash_4d2fc60b215c93d3.gscc) (size: 16192 Bytes / 0x3f40 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcc6df85f (3429759071)
// size ...... 16192 (0x3f40)
// includes .. 17  (offset: 0x3ca8)
// strings ... 24  (offset: 0x3d30)
// dev strs .. 10  (offset: 0x3ec8)
// exports ... 41  (offset: 0x26fc)
// cseg ...... 0x25a + 0x24a2 (0x26fc)
// imports ... 128 (offset: 0x2d64)
// animtree1 . 0   (offset: 0x3f40)
// animtree2 . 0   (offset: 0x3f40)
#using script_16ea1b94f0f381b3;
#using scripts\anim\battlechatter;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\callbacks;
#using scripts\common\scriptable;
#using scripts\common\status_effects\effect_slow;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_exclusion_zone;
#using scripts\mp\common\equipment\emp_grenade;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\damage;
#using scripts\mp\damagefeedback;
#using scripts\mp\entityheadicons;
#using scripts\mp\hud_message;
#using scripts\mp\supers;
#using scripts\mp\weapons;

#namespace bubble_shield;

// Namespace bubble_shield
// Params 0, eflags: 0x5
// Checksum 0x6c25586, Offset: 0x278
// Size: 0x18
function private autoexec main()
{
    level callback::add( #"register_super", &register );
}

// Namespace bubble_shield
// Params 1, eflags: 0x4
// Checksum 0x7721eb4d, Offset: 0x298
// Size: 0xcf
function private register( params )
{
    staticdata = level.superglobals.staticsuperdata[ "super_bubble_shield" ];
    
    if ( !isdefined( staticdata ) )
    {
        return;
    }
    
    rootname = getweaponrootstring( staticdata.objweapon );
    bundle = staticdata.bundle;
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    supers_mp::function_48aaa60b2ce7b8a1( "super_bubble_shield", undefined, undefined, undefined, undefined, undefined, undefined, undefined );
    scriptable::scriptable_adddamagedcallback( &function_4f4873403a781676 );
    level callback::add( #"on_ai_killed", &function_36f2214e7a9900dc );
    level callback::add( #"player_death", &function_36f2214e7a9900dc );
    weapons::registerusedcallback( rootname, &weapon_used );
    function_9b3902b41590e087();
}

// Namespace bubble_shield
// Params 1, eflags: 0x4
// Checksum 0xc517dbd2, Offset: 0x36f
// Size: 0x2d
function private function_751fa2f4b6cda662( should_decay )
{
    slot = supers_mp::getsuperslot( "super_bubble_shield" );
    supers_mp::function_dd6d97545b84597d( should_decay, slot );
}

// Namespace bubble_shield
// Params 0, eflags: 0x4
// Checksum 0xa1e900d9, Offset: 0x3a4
// Size: 0x11, Type: bool
function private function_901be5321a579086()
{
    return self isonground() && !self isjumping();
}

// Namespace bubble_shield
// Params 0, eflags: 0x4
// Checksum 0xe931f9ef, Offset: 0x3be
// Size: 0xf, Type: bool
function private function_41c8d34fadc925fc()
{
    if ( function_a590d92f796f1ad6() )
    {
        return false;
    }
    
    return true;
}

// Namespace bubble_shield
// Params 0, eflags: 0x4
// Checksum 0xf2c1db1e, Offset: 0x3d6
// Size: 0x2a4
function private init_data()
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_bubble_shield" );
    data = {};
    data.var_7ff2b15d178975ed = bundle.var_24f0532b0a0098f8 ?? 0;
    var_135e34021a3776b7 = self.var_2373875a7731acb7.bundle.var_cae1d202b3f179c5 ?? 0;
    data.health = ( self.var_f6ce3f6c3c2ead86.bundle.var_480290b6ae0cd3b9 ?? bundle.bubbleshieldhealth ?? 1600 ) + var_135e34021a3776b7;
    data.lifetime = supers_mp::function_b302d192481449e7( level.superglobals.staticsuperdata[ "super_bubble_shield" ] );
    data.damageradiusmultiplier = bundle.var_9b68e6e30b5860f1 ?? 1;
    data.var_3080e759a26cd844 = bundle.var_446db2ad6d1ca831;
    data.var_6ed782b00e2247f = bundle.var_b8ef4ce26234af32;
    data.var_48afd0d39aecdecc = bundle.var_b9092e554648f288 ?? 1;
    data.var_1956e86f35009d24 = bundle.var_4a64e6e075d1821b ?? 0;
    data.var_2417fceafb5af915 = bundle.var_1e81197115e9a40e ?? 0;
    data.var_130a5cdc70c98749 = bundle.var_74e2daa5af97f986;
    data.var_8d82e19b407e8a9d = bundle.var_b20851ca588bf324;
    data.var_fd66655416004272 = bundle.var_3704ef361818bf55;
    data.xmodel = bundle.var_1bff71f32e38282c;
    data.var_f7f3c29a983ac216 = bundle.var_f7f3c29a983ac216 ?? 1000;
    data.var_c272397339d03bc2 = bundle.var_ef38ec7471ff4caf;
    data.var_7466ff13ec4679d4 = bundle.var_9416a2eea30b924b;
    data.submixkey = bundle.var_8b579fc538551ca0;
    data.var_366598a7478a3ab5 = bundle.var_7c7b182f000fd78;
    data.var_b0c39c758eb1764 = utility::function_b720276ae54a4d70( bundle.var_10ba77f9ae48fc53, "Bubble shield needs a valid max pre-activation time." );
    data.var_6708353a02eb3e88 = bundle.var_4e79633582d364c1;
    data.noteamcollision = bundle.noteamcollision;
    self.var_76d21985b86ceb6d = data;
}

// Namespace bubble_shield
// Params 1, eflags: 0x4
// Checksum 0x3c990d28, Offset: 0x682
// Size: 0x4b7
function private spawn_shield( grenade )
{
    assert( grenade, "<dev string:x24>" );
    data = self.var_76d21985b86ceb6d;
    assert( data.xmodel, "<dev string:x4b>" );
    var_7c170ceae0649b57 = [ #"teamselect", self.team ];
    scriptablename = self.var_76d21985b86ceb6d.noteamcollision ? "super_bubble_shield_noteam" : "super_bubble_shield";
    shield = spawnscriptable( scriptablename, ( 0, 0, data.var_7ff2b15d178975ed ), ( 0, 0, 0 ), grenade, var_7c170ceae0649b57 );
    shield.connectedplayer = self;
    shield.damageradiusmultiplier = data.damageradiusmultiplier;
    shield.var_3080e759a26cd844 = data.var_3080e759a26cd844;
    shield.var_6ed782b00e2247f = data.var_6ed782b00e2247f;
    shield.maxhealth = max( data.health, 1 );
    shield.health = data.health;
    shield.radius = function_decb653c5689e4ca( data.xmodel )[ 1 ];
    shield.var_c272397339d03bc2 = data.var_c272397339d03bc2;
    shield.var_7466ff13ec4679d4 = data.var_7466ff13ec4679d4;
    shield.submixkey = data.submixkey;
    shield.var_cd361b3d06fd5f62 = data.var_366598a7478a3ab5 ? shield.radius * data.var_366598a7478a3ab5 : shield.radius;
    shield.var_f7f3c29a983ac216 = data.var_f7f3c29a983ac216;
    shield.var_6708353a02eb3e88 = data.var_6708353a02eb3e88;
    shield.var_8d82e19b407e8a9d = data.var_8d82e19b407e8a9d;
    
    if ( data.var_130a5cdc70c98749 )
    {
        assert( data.var_8d82e19b407e8a9d > 0, "<dev string:x64>" );
        shield.badplaceid = createnavbadplacebyshape( grenade.origin, shield.angles, 8, shield.var_8d82e19b407e8a9d * shield.radius, shield.radius, "team_hundred_ninety", "team_two_hundred" );
        
        if ( grenade getlinkedparent() )
        {
            grenade thread function_17bb190e2627faed( shield );
        }
    }
    
    if ( data.var_fd66655416004272 > 0 )
    {
        assert( data.var_130a5cdc70c98749, "<dev string:xa4>" );
        shield.zombieattractor = zombie_attractor_manager::add_attractor( shield, 1, shield.radius * data.var_fd66655416004272, 1, &function_56cc52510ed5b1db, &zombie_attractor_validate );
    }
    
    if ( !isdefined( level.var_a0dcc921bb9a5edb ) )
    {
        level.var_a0dcc921bb9a5edb = [];
    }
    
    level.var_a0dcc921bb9a5edb[ level.var_a0dcc921bb9a5edb.size ] = shield;
    
    if ( !isdefined( self.bubbleshields ) )
    {
        self.bubbleshields = [];
    }
    
    self.bubbleshields[ self.bubbleshields.size ] = shield;
    shield.shieldscriptable = shield;
    shield.var_a16ffdbb5f30f3c3 = 0;
    shieldtrigger = spawn( "trigger_radius", shield.origin, 0, shield.radius, shield.radius );
    shieldtrigger.owner = shield;
    
    if ( utility::issharedfuncdefined( #"game", #"makeenterexittrigger" ) )
    {
        [[ utility::getsharedfunc( #"game", #"makeenterexittrigger" ) ]]( shieldtrigger, &enter_shield_trigger, &exit_shield_radius );
    }
    
    shieldtrigger enablelinkto();
    shieldtrigger linkto( grenade );
    shield.shieldtrigger = shieldtrigger;
    shield thread function_1b7d3833afc00fed();
    grenade thread function_d5b6bd083a200368( shieldtrigger );
    grenade thread function_77670871a9253fef( shield );
    slot = supers_mp::getsuperslot( "super_bubble_shield" );
    supers_mp::function_dd6d97545b84597d( 0, slot );
    battlechatter::broadcastnotify( self.origin, 1000, "react_player", "react_bubble_shield", { #var_282bf9970a98e27e:self.team, #otherent:self } );
    return shield;
}

// Namespace bubble_shield
// Params 1, eflags: 0x4
// Checksum 0xe9121119, Offset: 0xb42
// Size: 0xa1
function private function_17bb190e2627faed( shield )
{
    shield endon( #"hash_e95ced04f8eba21a" );
    
    while ( true )
    {
        if ( shield.badplaceid )
        {
            destroynavobstacle( shield.badplaceid );
        }
        
        if ( self )
        {
            shield.badplaceid = createnavbadplacebyshape( shield.origin, shield.angles, 8, shield.var_8d82e19b407e8a9d * shield.radius, shield.radius, "team_hundred_ninety", "team_two_hundred" );
        }
        else
        {
            return;
        }
        
        wait 0.1;
    }
}

// Namespace bubble_shield
// Params 0, eflags: 0x4
// Checksum 0x479e7dda, Offset: 0xbeb
// Size: 0x42
function private function_1b7d3833afc00fed()
{
    self endon( #"death" );
    
    if ( level.br_circle_disabled )
    {
        return;
    }
    
    if ( isbrgamemode() )
    {
        while ( true )
        {
            wait 1;
            
            if ( function_5569e869ba67ae22() )
            {
                self notify( #"bubble_shield_end" );
            }
        }
    }
}

// Namespace bubble_shield
// Params 0, eflags: 0x4
// Checksum 0x9c181019, Offset: 0xc35
// Size: 0x4f
function private function_5569e869ba67ae22()
{
    if ( level.br_circle_disabled )
    {
        return 0;
    }
    
    var_8b217f269a1d0c8d = exclusion_zones::function_1efc19de6199fff6( self.origin, 0, 0 ) == -1 && !br_circle_util::ispointindangercircle( self.origin, level.var_ea96217a33eb6457 );
    return var_8b217f269a1d0c8d;
}

// Namespace bubble_shield
// Params 0
// Checksum 0xcc36751d, Offset: 0xc8d
// Size: 0x1e
function function_9b3902b41590e087()
{
    if ( isbrgamemode() )
    {
        weapons::function_2cd25260a11d5e40( #"mutation_shield", &function_752abfea748ebb6 );
    }
}

// Namespace bubble_shield
// Params 1, eflags: 0x4
// Checksum 0xa4c9bfd9, Offset: 0xcb3
// Size: 0x44
function private function_752abfea748ebb6( params )
{
    if ( level.br_circle_disabled )
    {
        return;
    }
    
    if ( function_5569e869ba67ae22() )
    {
        hud_message::showerrormessage( %"equipment/plant_failed" );
        self playsoundtoplayer( "ui_select_purchase_deny", self );
        self canceloffhands();
    }
}

// Namespace bubble_shield
// Params 2, eflags: 0x4
// Checksum 0xaba2af06, Offset: 0xcff
// Size: 0x73, Type: bool
function private zombie_attractor_validate( attractor, zombie )
{
    var_2af5847588086068 = player_utility::isfriendly( zombie.team ?? zombie.agentteam, attractor.source.connectedplayer );
    
    if ( var_2af5847588086068 )
    {
        return false;
    }
    
    return attractor.source.var_5512e79e2c1c0098 > 0;
}

// Namespace bubble_shield
// Params 2, eflags: 0x4
// Checksum 0x295801a7, Offset: 0xd7b
// Size: 0x6b
function private function_56cc52510ed5b1db( attractor, zombie )
{
    shield = attractor.source;
    offset = vectornormalize2( zombie.origin - shield.origin );
    goalpoint = shield.origin + offset;
    return goalpoint;
}

// Namespace bubble_shield
// Params 2
// Checksum 0xd6b260a0, Offset: 0xdef
// Size: 0x132
function enter_shield_trigger( player, trigger )
{
    if ( isplayer( player ) )
    {
        if ( !player is_player_inside_bubble() )
        {
            player callback::add( #"hash_652eb614ba902b3d", &function_ae1d4449c07fe167 );
        }
        
        if ( trigger.owner )
        {
            trigger.owner.var_5512e79e2c1c0098 = ( trigger.owner.var_5512e79e2c1c0098 ?? 0 ) + 1;
        }
        
        if ( !isdefined( player.var_ae2956efdf721fbe ) )
        {
            player.var_ae2956efdf721fbe = [];
        }
        
        player.var_ae2956efdf721fbe[ player.var_ae2956efdf721fbe.size ] = trigger.owner;
        player callback::callback( #"hash_c68091d0c9dcd5d5" );
        
        if ( trigger.owner callback::exists_any( #"player_enter_bubble_shield" ) )
        {
            params = { #player:player };
            trigger.owner callback::callback( #"player_enter_bubble_shield", params );
        }
        
        player.var_b6f2224be9ed1a1b = 1;
    }
}

// Namespace bubble_shield
// Params 2
// Checksum 0x20313db8, Offset: 0xf29
// Size: 0x13b
function exit_shield_radius( player, trigger )
{
    if ( isplayer( player ) && player is_player_inside_bubble() )
    {
        if ( trigger.owner.var_5512e79e2c1c0098 )
        {
            trigger.owner.var_5512e79e2c1c0098 -= 1;
        }
        
        player.var_ae2956efdf721fbe = arrayremove( player.var_ae2956efdf721fbe, trigger.owner );
        player callback::callback( #"hash_c68091d0c9dcd5d5" );
        
        if ( trigger.owner callback::exists_any( #"player_enter_bubble_shield" ) )
        {
            params = { #player:player };
            trigger.owner callback::callback( #"player_exit_bubble_shield", params );
        }
        
        if ( player.var_ae2956efdf721fbe.size == 0 )
        {
            player callback::callback( "player_exit_bubble_shield" );
            player.var_b6f2224be9ed1a1b = undefined;
            player callback::remove( #"hash_652eb614ba902b3d", &function_ae1d4449c07fe167 );
        }
    }
}

// Namespace bubble_shield
// Params 1
// Checksum 0x6bcb55c3, Offset: 0x106c
// Size: 0x158
function function_fbdc182c2e4aac5f( trigger )
{
    if ( !trigger.owner )
    {
        return;
    }
    
    playersinradius = getplayersinradius( trigger.owner.origin, trigger.owner.radius, trigger.owner.radius );
    
    foreach ( player in playersinradius )
    {
        exit_shield_radius( player, trigger );
        
        if ( isdefined( trigger.owner.var_ac0fc14229cfc93b ) && arraycontains( trigger.owner.var_ac0fc14229cfc93b, player ) )
        {
            player playsoundevent( trigger.owner.var_7466ff13ec4679d4 );
            player clearsoundsubmix( trigger.owner.submixkey );
        }
    }
    
    if ( trigger )
    {
        trigger delete();
    }
}

// Namespace bubble_shield
// Params 1
// Checksum 0xa1ff05f3, Offset: 0x11cc
// Size: 0x22
function function_d5b6bd083a200368( trigger )
{
    self waittill( #"death" );
    function_fbdc182c2e4aac5f( trigger );
}

// Namespace bubble_shield
// Params 1, eflags: 0x4
// Checksum 0x401d5382, Offset: 0x11f6
// Size: 0x282
function private function_77670871a9253fef( shield )
{
    self endon( #"death" );
    shield endon( #"hash_e95ced04f8eba21a" );
    
    while ( true )
    {
        players_in_radius = getplayersinradius( shield.origin, shield.var_cd361b3d06fd5f62, shield.var_cd361b3d06fd5f62 );
        
        if ( !isdefined( shield.var_ac0fc14229cfc93b ) )
        {
            shield.var_ac0fc14229cfc93b = [];
        }
        
        current_players = [];
        
        foreach ( player in players_in_radius )
        {
            eyepos = player geteye();
            dist = distance( eyepos, shield.origin );
            
            if ( dist <= shield.var_cd361b3d06fd5f62 )
            {
                if ( !isdefined( current_players ) )
                {
                    current_players = [];
                }
                
                current_players[ current_players.size ] = player;
                
                if ( !arraycontains( shield.var_ac0fc14229cfc93b, player ) )
                {
                    if ( shield.var_c272397339d03bc2 )
                    {
                        player playsoundevent( shield.var_c272397339d03bc2 );
                    }
                    
                    if ( shield.submixkey )
                    {
                        player setsoundsubmix( shield.submixkey );
                    }
                    
                    if ( !isdefined( shield.var_ac0fc14229cfc93b ) )
                    {
                        shield.var_ac0fc14229cfc93b = [];
                    }
                    
                    shield.var_ac0fc14229cfc93b[ shield.var_ac0fc14229cfc93b.size ] = player;
                }
            }
        }
        
        players_to_remove = arrayremove( shield.var_ac0fc14229cfc93b, current_players );
        
        foreach ( player in players_to_remove )
        {
            player playsoundevent( shield.var_7466ff13ec4679d4 );
            player clearsoundsubmix( shield.submixkey );
            shield.var_ac0fc14229cfc93b = arrayremove( shield.var_ac0fc14229cfc93b, player );
        }
        
        wait 0.3;
    }
}

// Namespace bubble_shield
// Params 1, eflags: 0x4
// Checksum 0xdbf62770, Offset: 0x1480
// Size: 0xef
function private function_cd5b174d65783365( var_8f69c955fdeea3da )
{
    self endon( #"hash_e95ced04f8eba21a" );
    
    while ( true )
    {
        ai_array = getaiarrayinradius( self.origin, self.radius );
        
        foreach ( agent in ai_array )
        {
            if ( agent.agentteam != self.connectedplayer.team )
            {
                agent effect_slow::slow( "super_bubble_shield", var_8f69c955fdeea3da, 0.5, self.connectedplayer );
            }
        }
        
        wait 0.5;
    }
}

// Namespace bubble_shield
// Params 1, eflags: 0x4
// Checksum 0x7cd6608e, Offset: 0x1577
// Size: 0x479
function private weapon_used( grenade )
{
    grenade endon( #"death" );
    level endon( #"game_ended" );
    
    if ( function_901be5321a579086() )
    {
        function_751fa2f4b6cda662( 1 );
    }
    else
    {
        function_dcd0be752f6a3759( grenade );
        return;
    }
    
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_bubble_shield" );
    assert( isdefined( bundle ), "<dev string:xe8>" );
    init_data();
    
    if ( bundle.var_1bff71f32e38282c )
    {
        players = getplayersinradius( grenade.origin, 500 );
        
        foreach ( player in players )
        {
            player prestreamasset( "model", bundle.var_1bff71f32e38282c, 500 );
            player thread function_c3ce29ab93cae117( bundle.var_1bff71f32e38282c, grenade );
        }
    }
    
    pre_activation_time = self.var_76d21985b86ceb6d.var_b0c39c758eb1764;
    msg = grenade utility::waittill_any_timeout( pre_activation_time, "missile_stuck" );
    
    if ( msg == "timeout" )
    {
        function_dcd0be752f6a3759( grenade );
        return;
    }
    
    wait 0.2;
    
    if ( grenade function_41c8d34fadc925fc() )
    {
        function_751fa2f4b6cda662( 0 );
    }
    else
    {
        function_dcd0be752f6a3759( grenade );
        return;
    }
    
    grenade setscriptablepartstate( #"visibility", #"show", 1 );
    
    if ( self.bubbleshields.size >= self.var_76d21985b86ceb6d.var_48afd0d39aecdecc )
    {
        bubble_shield_end( self.bubbleshields[ 0 ] );
    }
    
    shield = spawn_shield( grenade );
    
    if ( bundle.var_c8193eb70d370b44 )
    {
        grenade.health = int( bundle.var_c8193eb70d370b44 );
        grenade.shield = shield;
        grenade function_210ee90ac15bdf05();
    }
    
    grenade.superref = "super_bubble_shield";
    entityheadicons::setheadicon_fieldupgrade( grenade, undefined, undefined, 1 );
    grenade setscriptablepartstate( #"active", #"active", 1 );
    self notify( #"bubble_shield_spawned", shield );
    shield thread function_5c8bd21a54425f4b( self.var_76d21985b86ceb6d.lifetime );
    
    if ( self.var_76d21985b86ceb6d.var_1956e86f35009d24 && self.var_76d21985b86ceb6d.var_2417fceafb5af915 )
    {
        assert( self.var_76d21985b86ceb6d.var_1956e86f35009d24 >= self.var_76d21985b86ceb6d.var_2417fceafb5af915, "<dev string:x145>" );
        var_e4ef945ff07e0fa7 = self.var_76d21985b86ceb6d.lifetime - self.var_76d21985b86ceb6d.var_1956e86f35009d24;
        var_7214160b86d92c98 = self.var_76d21985b86ceb6d.var_1956e86f35009d24 - self.var_76d21985b86ceb6d.var_2417fceafb5af915;
        shield thread function_17e3d2b7a35618a7( var_e4ef945ff07e0fa7, var_7214160b86d92c98 );
    }
    
    thread function_a9b73497aea883d8( shield );
    
    if ( bundle.var_8b9eade13fbfb044 )
    {
        assert( !callback::exists( #"super_cancel", &cancel, shield ) );
        callback::add( #"super_cancel", &cancel, shield );
    }
    
    if ( isdefined( bundle.var_38dff5fa9f7c1d43 ) )
    {
        shield thread function_cd5b174d65783365( bundle.var_38dff5fa9f7c1d43 );
    }
    
    foreach ( bubbleshield in self.bubbleshields )
    {
        if ( !bubbleshield.var_a16ffdbb5f30f3c3 )
        {
            bubbleshield.var_a16ffdbb5f30f3c3 = 1;
            bubbleshield thread delete_grenade( grenade );
        }
    }
}

// Namespace bubble_shield
// Params 1, eflags: 0x4
// Checksum 0xeacedd38, Offset: 0x19f8
// Size: 0x3a
function private function_dcd0be752f6a3759( grenade )
{
    function_cc96cf6590d4e0f4();
    slot = supers_mp::getsuperslot( "super_bubble_shield" );
    supers_mp::refundsuper( slot );
    grenade delete();
}

// Namespace bubble_shield
// Params 0, eflags: 0x4
// Checksum 0xc67f57f1, Offset: 0x1a3a
// Size: 0x5d, Type: bool
function private function_a590d92f796f1ad6()
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_bubble_shield" );
    max_water_depth = bundle.var_7b2c06a450677db1;
    
    if ( max_water_depth )
    {
        can_deploy = !utility::ispointinwater( self.origin + ( 0, 0, max_water_depth ) );
        
        if ( !can_deploy )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace bubble_shield
// Params 2, eflags: 0x4
// Checksum 0xc17cdbc3, Offset: 0x1aa0
// Size: 0x2f
function private cancel( params, bubbleshield )
{
    if ( isdefined( bubbleshield ) )
    {
        bubble_shield_end( bubbleshield, 1, #"super_cancel" );
    }
}

// Namespace bubble_shield
// Params 1, eflags: 0x4
// Checksum 0x336ebbdc, Offset: 0x1ad7
// Size: 0x90
function private delete_grenade( grenade )
{
    self waittill( #"hash_e95ced04f8eba21a", end_reason );
    is_safe_delete = grenade && end_reason != #"super_cancel" && end_reason != "game_ended";
    
    if ( !is_safe_delete )
    {
        return;
    }
    
    assert( grenade, "<dev string:x199>" );
    grenade setscriptablepartstate( #"destroy", #"active", 1 );
    wait 0.5;
    
    if ( grenade )
    {
        grenade delete();
    }
}

// Namespace bubble_shield
// Params 1, eflags: 0x4
// Checksum 0x1b4ef5c5, Offset: 0x1b6f
// Size: 0x27
function private function_5c8bd21a54425f4b( lifetime )
{
    self endon( #"hash_e95ced04f8eba21a" );
    wait lifetime;
    self notify( #"bubble_shield_end" );
}

// Namespace bubble_shield
// Params 2, eflags: 0xc
// Checksum 0xd20dbb6a, Offset: 0x1b9e
// Size: 0x60
function private function_17e3d2b7a35618a7( var_e4ef945ff07e0fa7, var_7214160b86d92c98 )
{
    self notify( #"hash_facc18116e023a94" );
    self endon( #"hash_facc18116e023a94" );
    self endon( #"hash_e95ced04f8eba21a", #"bubble_shield_heavy_damage" );
    wait var_e4ef945ff07e0fa7;
    function_4c933c70377b9554( "shield_light_damaged" );
    wait var_7214160b86d92c98;
    function_4c933c70377b9554( "shield_heavy_damaged" );
}

// Namespace bubble_shield
// Params 1, eflags: 0x4
// Checksum 0xd0a7c227, Offset: 0x1c06
// Size: 0x5f
function private function_a9b73497aea883d8( bubbleshield )
{
    bubbleshield endon( #"death" );
    result = bubbleshield utility::waittill_any_return( "bubble_shield_end", "bubble_shield_broken", "bubble_shield_overridden", "game_ended" );
    
    if ( result == "bubble_shield_broken" )
    {
        thread supers_mp::superusefinished();
    }
    
    bubble_shield_end( bubbleshield, 0, result );
}

// Namespace bubble_shield
// Params 0, eflags: 0x4
// Checksum 0x416a2575, Offset: 0x1c6d
// Size: 0x24
function private function_210ee90ac15bdf05()
{
    self setcandamage( 1 );
    thread damage::monitordamage( self.health, "hitequip", &function_3251f73a9b560b18 );
}

// Namespace bubble_shield
// Params 1
// Checksum 0x22bb4737, Offset: 0x1c99
// Size: 0x62
function function_3251f73a9b560b18( damagedata )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self setcandamage( 0 );
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_bubble_shield" );
    damagedata.attacker namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( bundle.var_afb5519f3a738c44 );
    self.shield notify( #"bubble_shield_broken" );
}

// Namespace bubble_shield
// Params 11
// Checksum 0xe143cdc3, Offset: 0x1d03
// Size: 0x374
function function_4f4873403a781676( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( !( isdefined( instance ) && isdefined( instance.type ) ) )
    {
        return;
    }
    
    if ( instance function_6a5838bd447d3d9b() && emp_grenade::is_equipment_ref_emp( einflictor ) && isdefined( einflictor.owner.team ) && einflictor.owner.team != instance.team )
    {
        einflictor detonate();
        instance thread function_5c8bd21a54425f4b( 0.5 );
        return;
    }
    
    if ( !instance function_6a5838bd447d3d9b() )
    {
        return;
    }
    
    if ( smeansofdeath == "MOD_MELEE" )
    {
        if ( !instance.var_6708353a02eb3e88 || !isagent( eattacker ) )
        {
            return;
        }
    }
    
    if ( !utility::playerwithindistance( eattacker, instance.origin, instance.radius ) )
    {
        instance.health -= idamage;
        eattacker damagefeedback::updatedamagefeedback( "hitequip", instance.health <= 0, 0, undefined, undefined, 1, undefined, undefined, undefined, undefined, undefined );
        
        if ( instance.connectedplayer callback::exists_any( #"super_bubble_shield_damaged" ) )
        {
            params = { #smeansofdeath:smeansofdeath, #attacker:eattacker };
            instance.connectedplayer callback::callback( #"super_bubble_shield_damaged", params );
        }
        
        if ( isplayer( instance.connectedplayer ) && utility::issharedfuncdefined( #"challenges", #"hash_331a82c13105b9dd" ) )
        {
            bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_bubble_shield" );
            instance.connectedplayer [[ utility::getsharedfunc( #"challenges", #"hash_331a82c13105b9dd" ) ]]( { #lootid:bundle.lootid, #idamage:idamage } );
        }
    }
    
    healthpercent = instance.health / instance.maxhealth;
    
    if ( instance.health <= 0 )
    {
        bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_bubble_shield" );
        eattacker namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( bundle.var_afb5519f3a738c44 );
        instance notify( #"bubble_shield_broken" );
    }
    else if ( healthpercent <= instance.var_6ed782b00e2247f )
    {
        instance function_4c933c70377b9554( "shield_heavy_damaged" );
    }
    else if ( healthpercent <= instance.var_3080e759a26cd844 )
    {
        instance function_4c933c70377b9554( "shield_light_damaged" );
    }
    
    if ( !instance.var_de268bc611446f83 && instance.maxhealth - instance.health >= instance.var_f7f3c29a983ac216 )
    {
        bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_bubble_shield" );
        instance.connectedplayer namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( bundle.var_fe8c837b55f4d149 );
        instance.var_de268bc611446f83 = 1;
    }
}

// Namespace bubble_shield
// Params 0
// Checksum 0x95a21cc0, Offset: 0x207f
// Size: 0x24, Type: bool
function function_6a5838bd447d3d9b()
{
    return self.type == "super_bubble_shield" || self.type == "super_bubble_shield_noteam";
}

// Namespace bubble_shield
// Params 1, eflags: 0x4
// Checksum 0xd87c226e, Offset: 0x20ac
// Size: 0x9f
function private function_36f2214e7a9900dc( params )
{
    if ( !isdefined( params.victim ) )
    {
        return;
    }
    
    attacker = params.attacker ?? params.eattacker;
    
    if ( !isdefined( attacker ) )
    {
        return;
    }
    
    if ( isplayer( attacker ) && attacker player_utility::isenemy( params.victim ) && attacker function_89b041c6de8fef6a() )
    {
        bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_bubble_shield" );
        attacker namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( bundle.var_76f16eec430397c9 );
    }
}

// Namespace bubble_shield
// Params 1, eflags: 0x4
// Checksum 0xf5627c37, Offset: 0x2153
// Size: 0x54
function private function_4c933c70377b9554( new_state )
{
    var_87705ec7eac1724b = self getscriptablepartstate( "shield_base" );
    
    if ( isdefined( var_87705ec7eac1724b ) && var_87705ec7eac1724b != new_state )
    {
        self setscriptablepartstate( "shield_base", new_state );
        
        if ( new_state == "shield_heavy_damaged" )
        {
            self notify( #"bubble_shield_heavy_damage" );
        }
    }
}

// Namespace bubble_shield
// Params 0, eflags: 0x4
// Checksum 0x703f4b3e, Offset: 0x21af
// Size: 0x42
function private function_cc96cf6590d4e0f4()
{
    if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
    {
        self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"hash_54af55626a2f0622" );
    }
}

// Namespace bubble_shield
// Params 3, eflags: 0x4
// Checksum 0x4ac53f2, Offset: 0x21f9
// Size: 0x19b
function private bubble_shield_end( bubbleshield, skipstatechange = 0, end_reason )
{
    if ( !skipstatechange )
    {
        bubbleshield.shieldscriptable setscriptablepartstate( "shield_base", "shield_destroyed" );
    }
    
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_bubble_shield" );
    
    if ( bundle.var_8b9eade13fbfb044 )
    {
        assert( callback::exists( #"super_cancel", &cancel, bubbleshield ) );
        callback::remove( #"super_cancel", &cancel, bubbleshield );
    }
    
    bubbleshield notify( #"hash_e95ced04f8eba21a", end_reason );
    
    if ( isdefined( bubbleshield.badplaceid ) )
    {
        destroynavobstacle( bubbleshield.badplaceid );
        bubbleshield.badplaceid = undefined;
    }
    
    if ( bubbleshield.zombieattractor )
    {
        zombie_attractor_manager::remove_attractor( bubbleshield.zombieattractor );
    }
    
    assert( arraycontains( level.var_a0dcc921bb9a5edb, bubbleshield ), "<dev string:x216>" );
    level.var_a0dcc921bb9a5edb = arrayremove( level.var_a0dcc921bb9a5edb, bubbleshield );
    
    if ( bubbleshield.connectedplayer )
    {
        bubbleshield.connectedplayer.bubbleshields = arrayremove( bubbleshield.connectedplayer.bubbleshields, bubbleshield );
    }
    
    bubbleshield.var_de268bc611446f83 = undefined;
    
    if ( !skipstatechange )
    {
        wait 1;
    }
    
    bubbleshield.shieldscriptable freescriptable();
    bubbleshield.shieldscriptable = undefined;
}

// Namespace bubble_shield
// Params 0, eflags: 0x4
// Checksum 0x50d91cef, Offset: 0x239c
// Size: 0x1b, Type: bool
function private is_player_inside_bubble()
{
    return self.var_ae2956efdf721fbe && self.var_ae2956efdf721fbe.size > 0;
}

// Namespace bubble_shield
// Params 0, eflags: 0x4
// Checksum 0xd9352237, Offset: 0x23c0
// Size: 0x98, Type: bool
function private function_89b041c6de8fef6a()
{
    foreach ( bubbleshield in self.var_ae2956efdf721fbe )
    {
        if ( bubbleshield.connectedplayer.team == self.team )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace bubble_shield
// Params 2, eflags: 0x4
// Checksum 0x14bc9810, Offset: 0x2461
// Size: 0x4d
function private function_c3ce29ab93cae117( var_2c8bae8aeb289cc1, grenade )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    grenade waittill( #"missile_stuck" );
    wait 2;
    self prestreamasset( "model", var_2c8bae8aeb289cc1, -1 );
}

// Namespace bubble_shield
// Params 1, eflags: 0x4
// Checksum 0xaa9eee5b, Offset: 0x24b6
// Size: 0x246
function private function_ae1d4449c07fe167( data )
{
    if ( !data.vpoint )
    {
        return;
    }
    
    foreach ( bubbleshield in self.var_ae2956efdf721fbe )
    {
        var_3ade75e26faffd0c = data.vpoint - bubbleshield.origin;
        hitdistance = length( var_3ade75e26faffd0c );
        shieldradius = bubbleshield.radius * bubbleshield.damageradiusmultiplier;
        var_68272db571dc93de = data.eattacker.origin - bubbleshield.origin;
        var_1f84a7e703c5fe1e = length( var_68272db571dc93de );
        
        if ( var_1f84a7e703c5fe1e < shieldradius )
        {
            return;
        }
        
        /#
            if ( getdvarint( @"hash_f13bd4736e473cff", 0 ) == 1 )
            {
                if ( hitdistance < shieldradius )
                {
                    self iprintlnbold( "<dev string:x241>" );
                }
                else
                {
                    difference = hitdistance - shieldradius;
                    self iprintlnbold( "<dev string:x253>" + difference );
                }
            }
        #/
        
        if ( hitdistance < shieldradius )
        {
            data.idamage = 0;
            break;
        }
        
        if ( self.var_71ef7e54d65ba63d == gettime() && data.smeansofdeath == "MOD_EXPLOSIVE" )
        {
            if ( bubbleshield.var_2449f5c0cb1137f2 != self.var_71ef7e54d65ba63d )
            {
                bubbleshield function_4f4873403a781676( data.einflictor, data.eattacker, bubbleshield, data.idamage, data.idflags, data.smeansofdeath, data.objweapon, data.vdir, data.vpoint );
                bubbleshield.var_2449f5c0cb1137f2 = self.var_71ef7e54d65ba63d;
            }
            
            data.idamage = 0;
            break;
        }
    }
}

