// scripts\common\ai\aitypes\zombie_shade\zombie_shade_vehicle_attack.gsc  (hash_50409b85a7ae7a30.gscc) (size: 5684 Bytes / 0x1634 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x71243dbf (1898200511)
// size ...... 5684 (0x1634)
// includes .. 5   (offset: 0x14b0)
// strings ... 21  (offset: 0x14d8)
// dev strs .. 5   (offset: 0x15f8)
// exports ... 14  (offset: 0xd50)
// cseg ...... 0x3b7 + 0x999 (0xd50)
// imports ... 43  (offset: 0xf80)
// animtree1 . 0   (offset: 0x1634)
// animtree2 . 0   (offset: 0x1634)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_vehicle_attack;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;

#namespace zombie_shade_vehicle_attack;

// Namespace zombie_shade_vehicle_attack
// Params 1
// Checksum 0x75584541, Offset: 0x3d5
// Size: 0x29
function precache_zombie_shade_vehicle_attack( var_4b4d72d84afd1ebd )
{
    if ( isdefined( var_4b4d72d84afd1ebd ) )
    {
        utility::add_fx( "zombie_shade_vehicle_attack_crushed", var_4b4d72d84afd1ebd.var_8b37c573c77f5e5d );
    }
}

// Namespace zombie_shade_vehicle_attack
// Params 0
// Checksum 0x947e6a1e, Offset: 0x406
// Size: 0x6c
function init_zombie_shade_vehicle_attack_global()
{
    callback::get_template( self.animsetname ) callback::add( "on_zombie_vehicle_attack_latch_on_complete", &function_21d6830d1fc9e408 );
    callback::get_template( self.animsetname ) callback::add( "on_zombie_vehicle_attack_hit", &function_120ab9e2bf4bf65c );
    callback::get_template( self.animsetname ) callback::add( "on_zombie_vehicle_attack_crushed_while_latched", &function_578b6e30d4c1bab );
    
    /#
        setup_zombie_shade_vehicle_attack_devgui();
    #/
}

// Namespace zombie_shade_vehicle_attack
// Params 0
// Checksum 0x50ccd57d, Offset: 0x47a
// Size: 0x15
function init_zombie_shade_vehicle_attack()
{
    zombie_vehicle_attack::init_zombie_vehicle_attack();
    zombie_vehicle_attack::set_vehicle_collision_impact_vfx( "scriptable_zombie_shade_hit_vehicle" );
}

// Namespace zombie_shade_vehicle_attack
// Params 1, eflags: 0x4
// Checksum 0xaa0d16c9, Offset: 0x497
// Size: 0x9b
function private function_21d6830d1fc9e408( params )
{
    if ( isdefined( params.targetvehicle ) && isdefined( params.var_fb8c55c535ed177e ) )
    {
        if ( params.var_fb8c55c535ed177e == "tag_ai_linkto_front_right" )
        {
            var_3aad7a285aea251 = 1.25;
            zombie_vehicle_attack::function_cddc67295266ee84( self._blackboard.var_504b6217e686d548 + var_3aad7a285aea251 );
        }
        
        if ( getdvarint( @"hash_d3e31a973b64462d", 1 ) )
        {
            thread function_9f63bd237a9702cb( params.targetvehicle, params.var_fb8c55c535ed177e );
        }
    }
}

// Namespace zombie_shade_vehicle_attack
// Params 2, eflags: 0x4
// Checksum 0x41e57165, Offset: 0x53a
// Size: 0x16d
function private function_9f63bd237a9702cb( targetvehicle, var_fb8c55c535ed177e )
{
    self endon( #"death" );
    self endon( #"vehicle_attack_unlatch_start" );
    self endon( #"vehicle_attack_end" );
    self endon( #"vehicle_attack_disabled" );
    
    while ( true )
    {
        rockingmsg = utility::waittill_any_return( "vehicle_attack_rocking_pulling", "vehicle_attack_rocking_pushing" );
        var_7cadbbb28ef5fb82 = targetvehicle function_1dcd1edbad560a45() == targetvehicle function_dd8036d3c66a69c();
        var_c4f6dde4eae85fd3 = var_7cadbbb28ef5fb82 && getdvarint( @"hash_d3e31a973b64462d", 1 );
        
        if ( var_c4f6dde4eae85fd3 )
        {
            var_305b4e7d0254e40e = 32000;
            forcevec = targetvehicle.origin + function_c175c99137ef4ead( rockingmsg );
            forcevec = coordtransformtranspose( forcevec, targetvehicle.origin, targetvehicle.angles );
            forcevec = vectornormalize( forcevec );
            forcevec *= getdvarfloat( @"hash_5ead7ce8ee69199d", function_56f9c90ae520e79( var_fb8c55c535ed177e ) );
            
            if ( var_fb8c55c535ed177e == "tag_ai_linkto_rear_left" )
            {
                var_b0403b3aa92f70a1 = 0.05;
            }
            else
            {
                var_b0403b3aa92f70a1 = 0;
            }
            
            targetvehicle vehphys_force( forcevec, coordtransformtranspose( targetvehicle gettagorigin( var_fb8c55c535ed177e ), targetvehicle.origin, targetvehicle.angles ), getdvarfloat( @"hash_a723251865c84cd5", var_b0403b3aa92f70a1 ) );
        }
    }
}

// Namespace zombie_shade_vehicle_attack
// Params 1, eflags: 0x4
// Checksum 0x599665a8, Offset: 0x6af
// Size: 0xb4
function private function_c175c99137ef4ead( rockingmsg )
{
    switch ( rockingmsg )
    {
        case #"hash_6516d25267c972fe":
            return ( -1 * anglestoup( self.angles ) );
        case #"hash_c95f7350f6084487":
            dir = -1 * anglestoforward( self.angles );
            return rotatepointaroundvector( anglestoright( self.angles ), dir, 15 );
        case #"hash_34cc1c0857939ae2":
            return ( -1 * anglestoforward( self.angles ) );
        case #"hash_8d0ed1411e381ef3":
            return anglestoforward( self.angles );
    }
}

// Namespace zombie_shade_vehicle_attack
// Params 1, eflags: 0x4
// Checksum 0xf11d9647, Offset: 0x76b
// Size: 0x6a
function private function_56f9c90ae520e79( var_fb8c55c535ed177e )
{
    switch ( var_fb8c55c535ed177e )
    {
        case #"hash_d2ca974134337660":
            return 30000;
        case #"hash_897050f424482c86":
            return 40000;
        case #"hash_728085424a2d586f":
            return 400000;
        case #"hash_45fbf808083bcca":
            return 150000;
        default:
            return 30000;
    }
}

// Namespace zombie_shade_vehicle_attack
// Params 1, eflags: 0x4
// Checksum 0xadbc54c9, Offset: 0x7dd
// Size: 0x21a
function private function_120ab9e2bf4bf65c( params )
{
    if ( isdefined( params.hitvehicle ) )
    {
        if ( self._blackboard.var_16bcf486107e6291 == "tag_ai_linkto_front_right" )
        {
            var_fea62b66eb7388ba = 13;
            params.hitvehicle dodamage( var_fea62b66eb7388ba, self.origin, self, self, "MOD_MELEE" );
        }
        
        if ( isdefined( params.var_4fe75e13164e5ab7 ) )
        {
            var_5911cb551186cc4a = 0.5;
            thread function_df97d651e6de3ec9( params.var_4fe75e13164e5ab7 );
            
            if ( params.var_4fe75e13164e5ab7 == "both_legs" )
            {
                params.var_4fe75e13164e5ab7 = "tag_origin";
            }
            
            var_36960dc561931084 = self gettagorigin( params.var_4fe75e13164e5ab7 );
            var_6a0ff9b2c8e46362 = params.hitvehicle function_1dcd1edbad560a45() == params.hitvehicle function_dd8036d3c66a69c();
            var_c4f6dde4eae85fd3 = var_6a0ff9b2c8e46362 && !params.var_fe3e86e233a02f92 && getdvarint( @"hash_d3e31a973b64462d", 1 );
            
            if ( var_c4f6dde4eae85fd3 )
            {
                var_82eed42c55c7a10c = 72000;
                forcevec = params.hitvehicle.origin + function_d8cd004c0868932b( self._blackboard.var_16bcf486107e6291 );
                forcevec = coordtransformtranspose( forcevec, params.hitvehicle.origin, params.hitvehicle.angles );
                forcevec = vectornormalize( forcevec );
                forcevec *= getdvarfloat( @"hash_5ff3fc1c425c3a00", var_82eed42c55c7a10c );
                params.hitvehicle vehphys_force( forcevec, coordtransformtranspose( var_36960dc561931084, params.hitvehicle.origin, params.hitvehicle.angles ) );
            }
            
            playrumbleonposition( "zombie_vehicle_attack_impact_rumble", var_36960dc561931084 );
        }
    }
}

// Namespace zombie_shade_vehicle_attack
// Params 1, eflags: 0x4
// Checksum 0x81ebe1d6, Offset: 0x9ff
// Size: 0xfe
function private function_df97d651e6de3ec9( var_4fe75e13164e5ab7 )
{
    self endon( #"death" );
    
    switch ( var_4fe75e13164e5ab7 )
    {
        case #"hash_de9ffaed3aaf2f50":
            utility::function_32b24db3127bff40( "vehicle_hit", "head" );
            break;
        case #"hash_f084fe13d20c80bc":
            utility::function_32b24db3127bff40( "vehicle_hit", "mouth" );
            break;
        case #"hash_490819a022507b47":
            utility::function_32b24db3127bff40( "vehicle_hit", "right_arm" );
            break;
        case #"hash_572b1015a5a7e37a":
            utility::function_32b24db3127bff40( "vehicle_hit", "left_arm" );
            break;
        case #"hash_c50161d69a58f7b5":
            utility::function_32b24db3127bff40( "vehicle_hit", "right_leg" );
            break;
        case #"hash_e98e93069693d456":
            utility::function_32b24db3127bff40( "vehicle_hit", "both_legs" );
            break;
    }
    
    wait 0.15;
    
    if ( isdefined( self ) )
    {
        utility::function_32b24db3127bff40( "vehicle_hit", "off" );
    }
}

// Namespace zombie_shade_vehicle_attack
// Params 1, eflags: 0x4
// Checksum 0x56ad1801, Offset: 0xb05
// Size: 0x100
function private function_d8cd004c0868932b( var_651a76a27944889d )
{
    switch ( var_651a76a27944889d )
    {
        case #"hash_adbda7454599a63f":
        case #"hash_d2ca974134337660":
            return ( -1 * anglestoforward( self.angles ) );
        case #"hash_abf2feca4c74873b":
            return ( -1 * anglestoup( self.angles ) );
        case #"hash_897050f424482c86":
        case #"hash_9651b96345d56e12":
            return ( -1 * anglestoforward( self.angles ) );
        case #"hash_728085424a2d586f":
            return anglestoforward( self.angles );
        case #"hash_34da89bdd1112aa2":
            return ( -1 * anglestoup( self.angles ) );
        case #"hash_45fbf808083bcca":
        case #"hash_8e1148f5d1a3c359":
        case #"hash_988fc3758df3eccc":
            return ( -1 * anglestoup( self.angles ) );
    }
}

// Namespace zombie_shade_vehicle_attack
// Params 1, eflags: 0x4
// Checksum 0xf6fa7eb0, Offset: 0xc0d
// Size: 0x6a
function private function_578b6e30d4c1bab( params )
{
    var_3ac21f70dfa7911 = 20;
    self.forceannihilate = 1;
    self.vehicle_attack_crushed = 1;
    var_4c80401f846e3e34 = self gettagorigin( "j_mainroot" ) + anglestoforward( self.angles ) * var_3ac21f70dfa7911;
    playfx( utility::getfx( "zombie_shade_vehicle_attack_crushed" ), var_4c80401f846e3e34 );
}

/#

    // Namespace zombie_shade_vehicle_attack
    // Params 0
    // Checksum 0x68ad67ad, Offset: 0xc7f
    // Size: 0x30, Type: dev
    function setup_zombie_shade_vehicle_attack_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x3b>", "<dev string:x85>", &function_77a8d593f09a9d15, 1 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_shade_vehicle_attack
    // Params 0, eflags: 0x4
    // Checksum 0xf2f52cbf, Offset: 0xcb7
    // Size: 0x99, Type: dev
    function private function_77a8d593f09a9d15()
    {
        targetvehicle = level.players[ 0 ] getlinkedparent();
        
        if ( isdefined( targetvehicle ) )
        {
            aitype = function_b3988325430ce242( "<dev string:xbd>" );
            best_spawn_area = zombie_vehicle_attack::function_cf284e8470c97328( targetvehicle );
            shade = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( aitype, best_spawn_area.origin, best_spawn_area.angles, level.var_ece703e3d116381c ?? "<dev string:xca>" );
            shade zombie_vehicle_attack::function_b2f3f65e87ad25af( targetvehicle, best_spawn_area.var_309a32167a388a30 );
        }
    }

#/
