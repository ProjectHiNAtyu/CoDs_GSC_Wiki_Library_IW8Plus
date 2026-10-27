// script_43edbec8fd295dfe  (hash_43edbec8fd295dfe.gscc) (size: 3156 Bytes / 0xc54 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x79014baa (2030128042)
// size ...... 3156 (0xc54)
// includes .. 5   (offset: 0xbb8)
// strings ... 9   (offset: 0xbe0)
// dev strs .. 0   (offset: 0xc54)
// exports ... 9   (offset: 0x6b0)
// cseg ...... 0xee + 0x5c2 (0x6b0)
// imports ... 32  (offset: 0x818)
// animtree1 . 0   (offset: 0xc54)
// animtree2 . 0   (offset: 0xc54)
#using script_2fe74ee229c972c3;
#using scripts\common\callbacks;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\weapons;

#namespace skill_teleport_upgrade;

// Namespace skill_teleport_upgrade
// Params 0, eflags: 0x1
// Checksum 0xdd80ca56, Offset: 0x10c
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"teleport_upgrade", &init );
}

// Namespace skill_teleport_upgrade
// Params 0
// Checksum 0x7f6b63e, Offset: 0x12b
// Size: 0x7a
function init()
{
    utility::registersharedfunc( #"teleport_upgrade", #"hash_f89602d29c289ca4", &function_1321989bae991e4f );
    utility::registersharedfunc( #"teleport_upgrade", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"teleport_upgrade", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
    utility::registersharedfunc( #"super_teleport", #"hash_548a96a46473e85f", &function_3cceba3fce463ccc );
}

// Namespace skill_teleport_upgrade
// Params 1, eflags: 0x4
// Checksum 0x3594a1d8, Offset: 0x1ad
// Size: 0x6c
function private function_1321989bae991e4f( skill_bundle )
{
    if ( skill_bundle.var_9a74600c9c411871 )
    {
        fx_asset = loadfxasset( skill_bundle.var_9a74600c9c411871 );
        fx_id = "teleport_upgrade_damage_vfx_" + skill_bundle.skilllevel;
        level._effect[ fx_id ] = fx_asset;
        skill_bundle.var_d519d1a7d0f0ae44 = fx_id;
    }
}

// Namespace skill_teleport_upgrade
// Params 1, eflags: 0x4
// Checksum 0x80581ab1, Offset: 0x221
// Size: 0x7b, Type: bool
function private on_give_skill( skill_bundle )
{
    self.var_d147fe79e085acd3 = { #bundle:skill_bundle };
    
    if ( skill_bundle.var_4ccf917191611bf4 )
    {
        assert( !callback::exists( #"on_super_use_finished", &function_86724ad848b512e5, skill_bundle.var_4ccf917191611bf4, 1 ) );
        callback::add( #"on_super_use_finished", &function_86724ad848b512e5, skill_bundle.var_4ccf917191611bf4 );
    }
    
    return true;
}

// Namespace skill_teleport_upgrade
// Params 0, eflags: 0x4
// Checksum 0x562eff55, Offset: 0x2a5
// Size: 0x2f, Type: bool
function private function_a2f1157282b6d4fa()
{
    return isdefined( self.var_d147fe79e085acd3 ) && self.var_d147fe79e085acd3.bundle.var_97a36ccfdfa4c50b > 0;
}

// Namespace skill_teleport_upgrade
// Params 1, eflags: 0x4
// Checksum 0x7cac3e37, Offset: 0x2dd
// Size: 0x45
function private function_c51f1692ecb73bfe( skill_bundle )
{
    self.var_d147fe79e085acd3 = undefined;
    
    if ( callback::exists( #"on_super_use_finished", &function_86724ad848b512e5, undefined, 1 ) )
    {
        callback::remove( #"on_super_use_finished", &function_86724ad848b512e5 );
    }
}

// Namespace skill_teleport_upgrade
// Params 2, eflags: 0x4
// Checksum 0x4cc921e4, Offset: 0x32a
// Size: 0x46
function private function_86724ad848b512e5( superinfo, clip_percentage )
{
    if ( superinfo.staticdata.ref != #"super_teleport" )
    {
        return;
    }
    
    weapons::function_937faff615744271( self getcurrentweapon(), clip_percentage );
}

// Namespace skill_teleport_upgrade
// Params 1, eflags: 0x4
// Checksum 0x8d5ee320, Offset: 0x378
// Size: 0x338
function private function_3cceba3fce463ccc( aparams )
{
    if ( !function_a2f1157282b6d4fa() )
    {
        return;
    }
    
    start_pos = aparams.start_pos;
    end_pos = aparams.end_pos;
    capsule = self getcollision( "stand" );
    player_radius = capsule.capsule_radius;
    player_height = capsule.capsule_halfheight + capsule.capsule_midpoint_height + capsule.capsule_radius;
    contents = trace::create_contents( 1 );
    capsule_trace = physics_capsulecast( start_pos, end_pos, player_radius, player_height, self.angles, contents, [ self ], "physicsquery_all" );
    
    /#
        if ( getdvarint( @"hash_f88052d363ed6ba9", 0 ) == 1 )
        {
            line( start_pos, end_pos, ( 1, 0, 0 ), 1, 1, 200 );
            utility::draw_capsule( start_pos, player_radius, player_height, ( 0, 0, 0 ), ( 0, 1, 0 ), 1, 200 );
            utility::draw_capsule( end_pos, player_radius, player_height, ( 0, 0, 0 ), ( 0, 1, 0 ), 1, 200 );
        }
    #/
    
    if ( capsule_trace.size )
    {
        bundle = self.var_d147fe79e085acd3.bundle;
        damage_amount = bundle.var_97a36ccfdfa4c50b;
        
        foreach ( trace_result in capsule_trace )
        {
            var_90ec0886f9ccf215 = trace_result[ "entity" ];
            
            if ( isalive( var_90ec0886f9ccf215 ) && var_90ec0886f9ccf215.team != self.team )
            {
                if ( bundle.var_d519d1a7d0f0ae44 )
                {
                    tag = bundle.var_830c40b623a33604 ?? "tag_origin";
                    var_f50f068662b98974 = trace_result[ "position" ];
                    
                    if ( utility::hastag( var_90ec0886f9ccf215.model, tag ) )
                    {
                        var_f50f068662b98974 = var_90ec0886f9ccf215 gettagorigin( tag );
                    }
                    
                    effect_id = utility::getfx( bundle.var_d519d1a7d0f0ae44 );
                    playfx( effect_id, var_f50f068662b98974 );
                }
                
                if ( bundle.var_521c910c674bcbf6 )
                {
                    playsoundatpos( trace_result[ "position" ], bundle.var_521c910c674bcbf6 );
                }
                
                var_90ec0886f9ccf215 dodamage( damage_amount, trace_result[ "position" ], self, self, "MOD_IMPACT", "<explicitweaponnone>", "torso_upper" );
                
                /#
                    if ( getdvarint( @"hash_f88052d363ed6ba9", 0 ) == 1 )
                    {
                        utility::draw_capsule( var_90ec0886f9ccf215.origin, player_radius, player_height, ( 0, 0, 0 ), ( 1, 0, 0 ), 1, 200 );
                    }
                #/
            }
        }
    }
}

