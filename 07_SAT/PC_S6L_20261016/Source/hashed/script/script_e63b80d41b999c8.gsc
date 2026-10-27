// script_e63b80d41b999c8  (hash_0e63b80d41b999c8.gscc) (size: 5292 Bytes / 0x14ac / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xad432459 (2906858585)
// size ...... 5292 (0x14ac)
// includes .. 9   (offset: 0x127c)
// strings ... 33  (offset: 0x12c4)
// dev strs .. 1   (offset: 0x14a0)
// exports ... 10  (offset: 0xbe4)
// cseg ...... 0x36b + 0x879 (0xbe4)
// imports ... 43  (offset: 0xd74)
// animtree1 . 0   (offset: 0x14ac)
// animtree2 . 0   (offset: 0x14ac)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\zm\ztron\ztron_enemy_ai;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;
#using scripts\mp\zm\ztron\ztron_vfx;

#namespace namespace_69e425310f27a5;

// Namespace namespace_69e425310f27a5
// Params 0, eflags: 0x5
// Checksum 0x8e7f0bc8, Offset: 0x389
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_8173723ae45cbc64", #"ztron_item", undefined, &init );
}

// Namespace namespace_69e425310f27a5
// Params 0
// Checksum 0xfcdb802c, Offset: 0x3b2
// Size: 0x99
function init()
{
    ztron_item::function_5844a9c240f7dc8d( #"teddy_bear", #"use", &useteddybear );
    utility::add_fx( "stunbear", "vfx_sat_zm_powerup_stun_bear_shield_ztron" );
    utility::add_fx( "stunbear_fade", "vfx_sat_zm_bio_butterfly_top_ztron" );
    utility::add_fx( "stunbear_affected", "vfx_sat_zm_powerup_stun_bear_fear_ztron" );
    utility::add_fx( "stunbear_contact", "vfx_sat_zm_powerup_stun_bear_shield_impact_ztron" );
    ztron_sound::function_4ac735395b173fe( "ztron_pickup_teddybear_active_lp", "evt_ztron_pickup_teddybear_active_lp", 1 );
    ztron_sound::function_4ac735395b173fe( "ztron_pickup_teddybear_repulse", "evt_ztron_pickup_teddybear_repulse" );
    ztron_sound::function_4ac735395b173fe( "ztron_pickup_teddybear_active_end", "evt_ztron_pickup_teddybear_active_end" );
}

// Namespace namespace_69e425310f27a5
// Params 1
// Checksum 0xcf809de6, Offset: 0x453
// Size: 0x2c
function useteddybear( params )
{
    player = params.player;
    activateteddybear( player );
}

// Namespace namespace_69e425310f27a5
// Params 1
// Checksum 0x8b8493a3, Offset: 0x487
// Size: 0x137
function activateteddybear( player )
{
    profilestart();
    
    if ( !isdefined( player.ztron.stunbear_trigger ) )
    {
        player.ztron.stunbear_trigger = spawn( "trigger_radius", player.origin, 9, 130, 50 );
        
        if ( isdefined( player.ztron.stunbear_trigger ) )
        {
            player.ztron.stunbear_trigger.targetname = "stunBear";
            player.ztron.stunbear_trigger enablelinkto();
            player.ztron.stunbear_trigger linkto( player );
            player.ztron.stunbear_trigger thread function_9500c32e4a86485d( player );
            ztron_sound::ztron_playsound( "ztron_pickup_teddybear_active_lp", undefined, player );
            playfxontag( utility::getfx( "stunbear" ), player, "tag_origin" );
            player thread function_889993db4b9b43e1();
            player thread function_c3416dce95b1ed46( player.ztron.stunbear_trigger );
        }
    }
    
    profilestop();
}

// Namespace namespace_69e425310f27a5
// Params 1, eflags: 0xc
// Checksum 0xd2c1fa21, Offset: 0x5c6
// Size: 0x1bb
function private function_9500c32e4a86485d( player )
{
    self notify( #"hash_ff65c4289a3e3af0" );
    self endon( #"hash_ff65c4289a3e3af0" );
    player endon( #"end_teddybear_stun" );
    
    if ( isplayer( player ) )
    {
        player endon( #"disconnect" );
    }
    
    self endon( #"death" );
    
    /#
        thread teddy_bear_debug( player );
    #/
    
    while ( true )
    {
        self waittill( #"trigger", guy );
        
        if ( !isdefined( guy ) || !isdefined( guy.ztron ) )
        {
            continue;
        }
        
        if ( guy.nostun || guy.ztron.boss )
        {
            continue;
        }
        
        if ( guy.ztron.stunned == 0 )
        {
            /#
                if ( getdvarint( @"hash_275913aa25d52f25", 0 ) )
                {
                    debugstar( guy.origin, ( 1, 1, 0 ), 60, "<dev string:x24>" );
                }
            #/
            
            ztron_sound::ztron_playsound( "ztron_pickup_teddybear_repulse", undefined, guy );
            playfxontag( utility::getfx( "stunbear_contact" ), guy, "tag_origin" );
            player thread ztron_player_utility::function_9dbd11353321b474( "teddybear", guy.var_945ef487faad2413 );
            player playrumbleonentity( "damage_heavy" );
            guy thread function_702e4e62b24b808c();
            
            if ( player.ztron.var_2588c7465d7536b2 & 4194304 && guy.ztron.var_ae555ddb6e30a0b0 )
            {
                guy.forceannihilate = 1;
                guy thread ztron_util::function_ea0a0be5c5468c48( 8 );
            }
        }
    }
}

// Namespace namespace_69e425310f27a5
// Params 0, eflags: 0xc
// Checksum 0x26f5ab57, Offset: 0x789
// Size: 0x81
function private function_889993db4b9b43e1()
{
    self notify( #"hash_2819a75aa61a9044" );
    self endon( #"hash_2819a75aa61a9044" );
    self endon( #"end_teddybear_stun" );
    
    if ( isplayer( self ) )
    {
        self endon( #"disconnect" );
    }
    
    timeout = ztron_player_utility::function_10777122eee28fa8( 20 );
    utility::waittill_any_timeout( timeout, "ztron_exit_taken", "kill_shield", "ztron_teleporter_taken", "disconnect", "clone_shutdown", "death" );
    self notify( #"end_teddybear_stun" );
}

// Namespace namespace_69e425310f27a5
// Params 1, eflags: 0xc
// Checksum 0x39732dd7, Offset: 0x812
// Size: 0xb9
function private function_c3416dce95b1ed46( trigger )
{
    self notify( #"hash_567ac7805774c142" );
    self endon( #"hash_567ac7805774c142" );
    
    if ( isplayer( self ) )
    {
        self endon( #"disconnect" );
    }
    
    utility::waittill_any( "end_teddybear_stun" );
    
    if ( isdefined( self ) )
    {
        stopfxontag( utility::getfx( "stunbear" ), self, "tag_origin" );
        playfxontag( utility::getfx( "stunbear_fade" ), self, "tag_origin" );
    }
    
    wait 0.5;
    
    if ( isdefined( self ) )
    {
        ztron_sound::ztron_stopsound( self );
        ztron_sound::ztron_playsound( "ztron_pickup_teddybear_active_end", undefined, self );
        stopfxontag( utility::getfx( "stunbear_fade" ), self, "tag_origin" );
    }
    
    if ( isdefined( trigger ) )
    {
        trigger delete();
    }
}

// Namespace namespace_69e425310f27a5
// Params 0, eflags: 0xc
// Checksum 0x902b86eb, Offset: 0x8d3
// Size: 0x2b1
function private function_702e4e62b24b808c()
{
    self notify( #"hash_71b34f6f419b57af" );
    self endon( #"hash_71b34f6f419b57af" );
    self endon( #"death" );
    self.ztron.stunned = 1;
    val::set( "flee", "collide_with_ai_allies", 0 );
    val::set( "flee", "script_pushable_by_ai", 0 );
    val::set( "flee", "script_pushable", 0 );
    val::set( "flee", "ignore_ai_collision", 1 );
    ztron_vfx::function_a2884eba34f8ea6b( utility::getfx( "stunbear_affected" ), self, "tag_origin" );
    
    if ( !self.ztron.var_e537e768b24c992f )
    {
        spawnpos = self.spawnloc.origin ?? self.ztron.original_origin;
        self.ztron.var_6eea70bb852776bb = spawnpos;
        navpoint = self getclosestreachablepointonnavmesh( spawnpos );
        
        if ( isdefined( navpoint ) && distance( navpoint, spawnpos ) > 20 )
        {
            self.ztron.var_6eea70bb852776bb = navpoint;
        }
        
        self.ztron.fleecontext = 1;
    }
    else
    {
        self.ztron.var_6eea70bb852776bb = self.origin;
        self.ztron.fleecontext = 2;
    }
    
    meleerange = self._blackboard.var_cedd501bdb70cc3f;
    self._blackboard.var_cedd501bdb70cc3f = 0;
    ztron_enemy_ai::function_83baeab9d0850baa( self.ztron.var_6eea70bb852776bb, 1, self.ztron.fleecontext, 20 );
    wait 20;
    self._blackboard.var_cedd501bdb70cc3f = meleerange;
    
    if ( self.var_361a087ab08adc1c == "walk" )
    {
        self.var_361a087ab08adc1c = "run";
    }
    
    self.ztron.stunned = 0;
    val::reset_all( "flee" );
    ztron_vfx::aistopfxontag( utility::getfx( "stunbear_affected" ), self, "tag_origin" );
    self.ignoreall = 0;
    self clearenemy();
    self.favoriteenemy = undefined;
    ztron_enemy_ai::function_29bbc6846013b71b();
    
    if ( isdefined( self.favoriteenemy ) )
    {
        self getenemyinfo( self.favoriteenemy );
        return;
    }
    
    if ( !self.marked_for_death )
    {
        thread ztron_util::function_ea0a0be5c5468c48( 1 );
    }
}

/#

    // Namespace namespace_69e425310f27a5
    // Params 1
    // Checksum 0x86237082, Offset: 0xb8c
    // Size: 0x58, Type: dev
    function teddy_bear_debug( player )
    {
        self endon( #"death" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_275913aa25d52f25", 0 ) )
            {
                drawtrigger( self, ( 0, 1, 0 ), 0, 0, 0, ( 0, 1, 0 ) );
            }
            
            waitframe();
        }
    }

#/
