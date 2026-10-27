// scripts\vehicle\pluto\pluto_upgrades.gsc  (hash_2dd5c93ae114e652.gscc) (size: 4264 Bytes / 0x10a8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf660856f (4133520751)
// size ...... 4264 (0x10a8)
// includes .. 5   (offset: 0xf28)
// strings ... 25  (offset: 0xf50)
// dev strs .. 1   (offset: 0x109c)
// exports ... 8   (offset: 0x9e0)
// cseg ...... 0x28c + 0x754 (0x9e0)
// imports ... 32  (offset: 0xb20)
// animtree1 . 0   (offset: 0x10a8)
// animtree2 . 0   (offset: 0x10a8)
#using script_4880fce3c83f33ef;
#using script_54d7585f0a1791e6;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\vehicle\pluto\pluto_repair;

#namespace pluto_veh;

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0x7ef43648, Offset: 0x2aa
// Size: 0xf9
function private function_1b5dcffbcf193d44()
{
    vehicle = self;
    vehicle endon( #"death" );
    
    while ( true )
    {
        if ( vehicle.stagerequested != -1 )
        {
            vehicle function_110d8c23aa7f6c38( self.stagerequested );
            vehicle.stagerequested = -1;
        }
        else if ( vehicle.var_e36cfae7a208562c > vehicle.var_7493baa2cd62443 && vehicle.var_e36cfae7a208562c != -1 )
        {
            vehicle.stagerequested = vehicle.var_e36cfae7a208562c;
            vehicle.var_e36cfae7a208562c = -1;
        }
        else if ( getdvarint( @"hash_50d8a282925f2efc", 1 ) == 1 && vehicle.var_e36cfae7a208562c != -1 )
        {
            vehicle.stagerequested = vehicle.var_e36cfae7a208562c;
            vehicle.var_e36cfae7a208562c = -1;
        }
        
        waitframe();
    }
}

// Namespace pluto_veh
// Params 0
// Checksum 0xdcbfe8e4, Offset: 0x3ab
// Size: 0x5f
function function_ff56134103ad2ee7()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( self.owner )
        {
            self.owner setclientomnvar( "ui_killstreak_boost_recharge_percentage", self function_8219169c22f3c66d() );
            self.owner setclientomnvar( "ui_killstreak_boost_active", self isboosting() );
        }
        
        waitframe();
    }
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0x6abaf943, Offset: 0x412
// Size: 0x88
function private function_9e2ea618e6bac38c()
{
    self setscriptablepartstate( "boost_fx", "idle" );
    
    if ( isdefined( self.pap_sbl ) )
    {
        return;
    }
    
    self.pap_sbl = spawnscriptable( %"veh_sat_firefly_pluto_pap_part_invisible", self gettagorigin( "tag_ai_linkto_rear_center" ), self gettagangles( "tag_ai_linkto_rear_center" ) );
    self.pap_sbl utility::scriptable_setparententity( self, ( -134, 0, 26 ), ( 0, 180, 0 ) );
    thread function_ff56134103ad2ee7();
    setomnvar( "ui_pluto_show_speed_boost", 1 );
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0xd8aecc19, Offset: 0x4a2
// Size: 0xa8
function private function_844dae88741f99de()
{
    self.tedd = utility::spawn_model( %"c_sat_zmb_silver_head_fxanim", self.origin );
    self.tedd setmoverantilagged( 1 );
    self.tedd linkto( self, "tag_tedd_head", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    self.tedd playsound( "evt_quest_pap_head_place" );
    
    if ( utility::issharedfuncdefined( #"veh_pluto", #"on_attach_head" ) )
    {
        utility::callsharedfunc( #"veh_pluto", #"on_attach_head" );
    }
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0xcd436ed5, Offset: 0x552
// Size: 0x52
function private function_3db75fcba875bf7e()
{
    if ( self.isplayinganim )
    {
        self setscriptablepartstate( "abom_fxanim", "alsoidle" );
        self.isplayinganim = 0;
    }
    else
    {
        self setscriptablepartstate( "abom_fxanim", "idle" );
        self.isplayinganim = 1;
    }
    
    setomnvar( "ui_pluto_show_beam_attack", 1 );
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0x93938b99, Offset: 0x5ac
// Size: 0x1b
function private function_14d5c338e6a7af8d( bpname )
{
    self function_c8661270973a8e60( bpname );
    namespace_258c393149f2e837::function_6f973aa5086dcf35();
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0x4fab0fb7, Offset: 0x5cf
// Size: 0x411
function private function_110d8c23aa7f6c38( newstage )
{
    if ( newstage <= self.var_7493baa2cd62443 )
    {
        if ( getdvarint( @"hash_50d8a282925f2efc", 1 ) == 0 )
        {
            return;
        }
        else if ( self.var_7493baa2cd62443 == 4 )
        {
            self.occupantsreserving[ "gunner" ] = undefined;
        }
    }
    
    if ( newstage != 83 )
    {
        if ( self.var_7493baa2cd62443 == 0 )
        {
            set_vehicle_usable_state( self, 1 );
            function_844dae88741f99de();
        }
        
        if ( newstage >= 2 )
        {
            function_9e2ea618e6bac38c();
        }
        
        if ( newstage >= 3 )
        {
            function_3db75fcba875bf7e();
        }
        
        if ( newstage >= 4 )
        {
            level.var_e445b76f87f11639 = 0;
        }
    }
    else
    {
        function_9e2ea618e6bac38c();
    }
    
    self setscriptablepartstate( "turret_fx", "turret_fx_off" );
    self.occupantsreserving[ "gunner" ] = self;
    self.var_7493baa2cd62443 = newstage;
    setomnvar( "ui_pluto_upgrade_stage", clampint( newstage, 0, 5 ) );
    level utility::flag_set( "upgraded_pluto_to_stage_" + newstage );
    function_270cc051f221c8c2( self, 0 );
    setdvar( @"firefly_pluto_stage", self.var_7493baa2cd62443 );
    println( "<dev string:x24>" + newstage );
    params = { #newstage:newstage, #event:#"hash_8202d0016fc358bc" };
    level callback::callback( #"hash_6c71d319dc089c27", params );
    
    switch ( self.var_7493baa2cd62443 )
    {
        case 0:
            if ( utility::issharedfuncdefined( #"veh_pluto", #"hash_655975bf60d149e1" ) )
            {
                utility::callsharedfunc( #"veh_pluto", #"hash_655975bf60d149e1" );
            }
            
            break;
        case 1:
            function_14d5c338e6a7af8d( getxhashasset( "vehbp_sat_firefly_pluto_tedd" ) );
            
            if ( utility::issharedfuncdefined( #"veh_pluto", #"hash_655975bf60d149e1" ) )
            {
                utility::callsharedfunc( #"veh_pluto", #"hash_655975bf60d149e1" );
            }
            
            self setscriptablepartstate( "upgrades", "stagechange_tedd" );
            break;
        case 2:
        case 83:
            function_14d5c338e6a7af8d( getxhashasset( "vehbp_sat_firefly_pluto_pap" ) );
            
            if ( utility::issharedfuncdefined( #"veh_pluto", #"hash_8319538f82a49890" ) )
            {
                utility::callsharedfunc( #"veh_pluto", #"hash_8319538f82a49890" );
            }
            
            self setscriptablepartstate( "upgrades", "stagechange_pap" );
            break;
        case 3:
            function_14d5c338e6a7af8d( getxhashasset( "vehbp_sat_firefly_pluto_abom" ) );
            
            if ( utility::issharedfuncdefined( #"veh_pluto", #"hash_8319538f82a49890" ) )
            {
                utility::callsharedfunc( #"veh_pluto", #"hash_8319538f82a49890" );
            }
            
            if ( utility::issharedfuncdefined( #"veh_pluto", #"hash_c178a73f5131c339" ) )
            {
                utility::callsharedfunc( #"veh_pluto", #"hash_c178a73f5131c339" );
            }
            
            self setscriptablepartstate( "upgrades", "stagechange_abom" );
            break;
        case 4:
        case 5:
            function_14d5c338e6a7af8d( getxhashasset( "vehbp_sat_firefly_pluto_mg" ) );
            
            if ( utility::issharedfuncdefined( #"veh_pluto", #"hash_8319538f82a49890" ) )
            {
                utility::callsharedfunc( #"veh_pluto", #"hash_8319538f82a49890" );
            }
            
            if ( utility::issharedfuncdefined( #"veh_pluto", #"hash_171c9939fdff57dc" ) )
            {
                utility::callsharedfunc( #"veh_pluto", #"hash_171c9939fdff57dc" );
            }
            
            if ( utility::issharedfuncdefined( #"veh_pluto", #"hash_c178a73f5131c339" ) )
            {
                utility::callsharedfunc( #"veh_pluto", #"hash_c178a73f5131c339" );
            }
            
            self setscriptablepartstate( "upgrades", "stagechange_turret" );
            self.occupantsreserving[ "gunner" ] = undefined;
            break;
    }
}

