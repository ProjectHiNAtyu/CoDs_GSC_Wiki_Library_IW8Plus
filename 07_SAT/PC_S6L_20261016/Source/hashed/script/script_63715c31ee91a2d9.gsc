// script_63715c31ee91a2d9  (hash_63715c31ee91a2d9.gscc) (size: 3206 Bytes / 0xc86 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbbd5e3ca (3151356874)
// size ...... 3206 (0xc86)
// includes .. 2   (offset: 0xb4e)
// strings ... 18  (offset: 0xb5e)
// dev strs .. 0   (offset: 0xc86)
// exports ... 8   (offset: 0x7ae)
// cseg ...... 0x1d5 + 0x5d9 (0x7ae)
// imports ... 20  (offset: 0x8ee)
// animtree1 . 0   (offset: 0xc86)
// animtree2 . 0   (offset: 0xc86)
#using scripts\common\metabone;
#using scripts\common\utility;

#namespace zombie_boss_virgil_metabones;

// Namespace zombie_boss_virgil_metabones
// Params 0, eflags: 0x1
// Checksum 0x8d1ae6b5, Offset: 0x1f3
// Size: 0x3a
function autoexec main()
{
    var_fb56e56d94279338 = "zombie_boss_virgil";
    metabone::function_cd947f1a3391c065( var_fb56e56d94279338, &on_metabone_destroyed );
    level.var_731234a0d4782c02 = getdvarint( @"hash_24218857e5f61de7", 680 );
}

// Namespace zombie_boss_virgil_metabones
// Params 0
// Checksum 0xb098b287, Offset: 0x235
// Size: 0x15
function init_virgil_metabones()
{
    metabone::function_b68bd9932f284448( &function_a0db63ea3b052417 );
    thread function_7925a3d7192404f3();
}

// Namespace zombie_boss_virgil_metabones
// Params 1, eflags: 0x4
// Checksum 0xd2f660c1, Offset: 0x252
// Size: 0x1e
function private on_metabone_destroyed( params )
{
    _on_metabone_destroyed( params.metabone_name );
}

// Namespace zombie_boss_virgil_metabones
// Params 1, eflags: 0x4
// Checksum 0x3fac577c, Offset: 0x278
// Size: 0xc
function private _on_metabone_destroyed( metabone_name )
{
    
}

// Namespace zombie_boss_virgil_metabones
// Params 0, eflags: 0x4
// Checksum 0xa59ee1e3, Offset: 0x28c
// Size: 0x17a
function private function_7925a3d7192404f3()
{
    self endon( #"death" );
    utility::ent_flag_wait_or_timeout( "zombie_asm_init_finished", 1 );
    self.weak_point_objectives = [];
    weakpoint_locations = [ "weakspot_forearm_right", "weakspot_elbow_right", "weakspot_chest_right", "weakspot_stomach_left", "weakspot_armpit_left", "weakspot_elbow_left", "weakspot_forearm_left" ];
    weakpoint_tags = [ "tag_weakspot_1", "tag_weakspot_2", "tag_weakspot_3", "tag_weakspot_4", "tag_weakspot_5", "tag_weakspot_6", "tag_weakspot_7" ];
    
    for ( i = 0; i < weakpoint_tags.size ; i++ )
    {
        tag_name = weakpoint_tags[ i ];
        location = weakpoint_locations[ i ];
        tagorigin = self gettagorigin( tag_name );
        bone_ent = utility::spawn_model( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_5773644b7fca465e, tagorigin, self.angles );
        bone_ent linkto( self, tag_name, ( 0, 0, 0 ), ( 0, 0, 0 ) );
        bone_ent.tag_name = tag_name;
        self.weak_point_objectives[ location ] = bone_ent;
    }
}

// Namespace zombie_boss_virgil_metabones
// Params 1, eflags: 0x4
// Checksum 0xc16012e5, Offset: 0x40e
// Size: 0x30a
function private function_a0db63ea3b052417( dmg_struct )
{
    metabone_name = metabone::get_metabone_name( dmg_struct.shitloc, dmg_struct.partname, dmg_struct.vpoint, dmg_struct.vdir );
    
    if ( !metabone_name && isdefined( dmg_struct.partname ) )
    {
        switch ( dmg_struct.partname )
        {
            case #"tag_weakspot_1":
                metabone_name = "weakspot_forearm_right";
                break;
            case #"tag_weakspot_2":
                metabone_name = "weakspot_elbow_right";
                break;
            case #"tag_weakspot_3":
                metabone_name = "weakspot_chest_right";
                break;
            case #"tag_weakspot_4":
                metabone_name = "weakspot_stomach_left";
                break;
            case #"tag_weakspot_5":
                metabone_name = "weakspot_armpit_left";
                break;
            case #"tag_weakspot_6":
                metabone_name = "weakspot_elbow_left";
                break;
            case #"tag_weakspot_7":
                metabone_name = "weakspot_forearm_left";
                break;
            default:
                metabone_name = undefined;
                break;
        }
    }
    
    if ( metabone_name && ( metabone_name == "weakspot_armpit_left" || metabone_name == "weakspot_chest_right" ) && metabone::get_metabone_state_name( "weakspot_elbow_left" ) == "exposed_enabled" )
    {
        metabone_name = "weakspot_elbow_left";
    }
    
    hit_dir = undefined;
    chest_origin = undefined;
    chest_dot = undefined;
    var_f6dedb1f35f6f8f2 = anglestoright( self.angles );
    
    if ( metabone_name && metabone_name == "weakspot_chest_right" )
    {
        chest_origin = self gettagorigin( "tag_c_chest" );
        hit_dir = dmg_struct.vpoint - chest_origin;
        
        if ( vectordot( hit_dir, var_f6dedb1f35f6f8f2 ) < 0 )
        {
            metabone_name = undefined;
        }
        
        if ( isdefined( metabone_name ) )
        {
            chest_dot = function_597d6cdb5489a75a( dmg_struct );
            
            if ( chest_dot < 0.995 )
            {
                metabone_name = undefined;
            }
        }
    }
    
    if ( !isdefined( metabone_name ) && metabone::get_metabone_state_name( "weakspot_chest_right" ) == "exposed_enabled" && dmg_struct.partname == #"j_head" && dmg_struct.vpoint && isplayer( dmg_struct.eattacker ) )
    {
        if ( !isdefined( chest_dot ) )
        {
            chest_dot = function_597d6cdb5489a75a( dmg_struct );
        }
        
        if ( chest_dot >= 0.998 )
        {
            metabone_name = "weakspot_chest_right";
        }
    }
    
    if ( metabone_name == "weakspot_armpit_left" && dmg_struct.vpoint )
    {
        var_14dec997378c61f3 = self gettagorigin( "tag_weakspot_5" );
        var_a3b4957aa6cf804d = self gettagorigin( "tag_weakspot_6" );
        wp_dir = vectornormalize( var_14dec997378c61f3 - var_a3b4957aa6cf804d );
        shot_dir = vectornormalize( dmg_struct.vpoint - var_14dec997378c61f3 );
        dot = vectordot( wp_dir, shot_dir );
        
        if ( dot < -0.35 )
        {
            metabone_name = undefined;
        }
    }
    
    if ( metabone_name && metabone::get_metabone_state_name( metabone_name ) != "exposed_enabled" )
    {
        metabone_name = undefined;
    }
    
    return metabone_name;
}

// Namespace zombie_boss_virgil_metabones
// Params 1, eflags: 0x4
// Checksum 0x30b61d95, Offset: 0x721
// Size: 0x8c
function private function_597d6cdb5489a75a( dmg_struct )
{
    if ( !isplayer( dmg_struct.eattacker ) )
    {
        return;
    }
    
    weakspot_origin = self gettagorigin( "tag_weakspot_3" );
    shot_dir = anglestoforward( dmg_struct.eattacker getplayerangles() );
    var_8499ba17e13ec32a = vectornormalize( weakspot_origin - dmg_struct.eattacker.origin );
    dot = vectordot( shot_dir, var_8499ba17e13ec32a );
    return dot;
}

