// scripts\common\ai\aitypes\zombie_callisto\zombie_callisto_metabones.gsc  (hash_37c0940fa951af6f.gscc) (size: 1854 Bytes / 0x73e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7e143241 (2115252801)
// size ...... 1854 (0x73e)
// includes .. 6   (offset: 0x68e)
// strings ... 8   (offset: 0x6be)
// dev strs .. 1   (offset: 0x732)
// exports ... 5   (offset: 0x392)
// cseg ...... 0xfa + 0x298 (0x392)
// imports ... 19  (offset: 0x45a)
// animtree1 . 0   (offset: 0x73e)
// animtree2 . 0   (offset: 0x73e)
#using script_7c2e89079a7b7f97;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_callisto\zombie_callisto_zombees;
#using scripts\common\metabone;
#using scripts\common\utility;

#namespace zombie_callisto_metabones;

// Namespace zombie_callisto_metabones
// Params 0, eflags: 0x1
// Checksum 0xbbcd9d86, Offset: 0x118
// Size: 0x21
function autoexec main()
{
    var_fb56e56d94279338 = "zombie_callisto";
    metabone::function_cd947f1a3391c065( var_fb56e56d94279338, &on_metabone_destroyed );
}

// Namespace zombie_callisto_metabones
// Params 1, eflags: 0x4
// Checksum 0x1bc8f1f8, Offset: 0x141
// Size: 0x1e
function private on_metabone_destroyed( params )
{
    _on_metabone_destroyed( params.metabone_name );
}

// Namespace zombie_callisto_metabones
// Params 1, eflags: 0x4
// Checksum 0xfdbdcca7, Offset: 0x167
// Size: 0x1c6
function private _on_metabone_destroyed( metabone_name )
{
    if ( self getscriptablehaspart( metabone_name ) )
    {
        self setscriptablepartstate( metabone_name, "destroyed" );
        metabone::set_metabone_state( metabone_name, "destroyed" );
        metabone::set_metabone_active( metabone_name, 1 );
        metabones_def = metabone::get_metabones_def( self.metabones.bundle_name );
        metabone = metabones_def.var_2972332beaa5b174[ metabone_name ];
        tag = metabone.tags[ 0 ];
        assert( isdefined( tag.tagname ) );
        
        if ( !self.var_ea0339471f98d3c7 )
        {
            zombie_callisto_zombeehive::spawn_zombeehive( tag.tagname );
        }
        
        zombie_callisto_zombees::function_f6c84cfcf2964ef0();
        thread enrage_callisto();
        
        if ( self getaiblackboarddynamic( "in_special_pain_window" ) )
        {
            end_time = self getaiblackboarddynamic( "special_pain_end_time" );
            
            if ( isdefined( end_time ) )
            {
                self function_786bb6aa1b76c7ee( "special_pain_end_time", end_time + utility::function_4b74c15943231980( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_5e11ddc6b7936666 ) );
            }
            
            loop_time = self getaiblackboarddynamic( "special_pain_duration" );
            self function_786bb6aa1b76c7ee( "special_pain_duration", loop_time + int( utility::function_4b74c15943231980( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_5e11ddc6b7936666 ) ) );
        }
        else
        {
            asm::function_7256f5ba459c840b( "special_pain_in" );
            self function_786bb6aa1b76c7ee( "special_pain_duration", int( utility::function_4b74c15943231980( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_22a1914b2d0450b9 ) ) );
        }
        
        return;
    }
    
    assertmsg( "<dev string:x24>" + metabone_name );
}

// Namespace zombie_callisto_metabones
// Params 0, eflags: 0xc
// Checksum 0x8f0d13d7, Offset: 0x335
// Size: 0x5d
function private enrage_callisto()
{
    self notify( #"hash_ec867109fa366d9c" );
    self endon( #"hash_ec867109fa366d9c" );
    self endon( #"death" );
    self waittill( #"start_enrage" );
    zombie_utils::function_a8ce00e0448cb6f0( "super_sprint", "callisto_enrage", 30 );
    wait 10;
    
    if ( isdefined( self ) )
    {
        zombie_utils::function_a8ce00e0448cb6f0( undefined, "callisto_enrage", 30 );
    }
}

