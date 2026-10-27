// scripts\mp\zm\systems\zm_interaction.gsc  (hash_1fa94cdf07fb3fcf.gscc) (size: 2592 Bytes / 0xa20 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4694e587 (1184163207)
// size ...... 2592 (0xa20)
// includes .. 4   (offset: 0x9f0)
// strings ... 0   (offset: 0xa10)
// dev strs .. 1   (offset: 0xa10)
// exports ... 8   (offset: 0x610)
// cseg ...... 0x58 + 0x5b8 (0x610)
// imports ... 22  (offset: 0x750)
// animtree1 . 0   (offset: 0xa20)
// animtree2 . 0   (offset: 0xa20)
#using script_2693dc72a65ba196;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\weapon;

#namespace zm_interaction;

// Namespace zm_interaction
// Params 0
// Checksum 0xcf185180, Offset: 0x76
// Size: 0x20, Type: bool
function function_f575e8a9ce7d5b58()
{
    return isdefined( self.var_a0de55e36be21b7a ) && self.var_a0de55e36be21b7a Interactionholding::is_open( self );
}

// Namespace zm_interaction
// Params 2
// Checksum 0xa9191600, Offset: 0x9f
// Size: 0xa3
function function_307c21197e0798d4( var_ed466fad37317edc, str_caption )
{
    if ( !isdefined( self.var_a0de55e36be21b7a ) )
    {
        self.var_a0de55e36be21b7a = Interactionholding::register();
    }
    
    if ( !self.var_a0de55e36be21b7a Interactionholding::is_open( self ) )
    {
        self.var_a0de55e36be21b7a Interactionholding::open( self );
    }
    
    function_45e51da251cd5e3a( 0 );
    
    if ( !isdefined( var_ed466fad37317edc ) )
    {
        var_ed466fad37317edc = &"";
    }
    
    self.var_a0de55e36be21b7a Interactionholding::set_description( self, var_ed466fad37317edc );
    
    if ( !isdefined( str_caption ) )
    {
        str_caption = &"";
    }
    
    self.var_a0de55e36be21b7a Interactionholding::set_caption( self, str_caption );
}

// Namespace zm_interaction
// Params 1
// Checksum 0xb761bb9f, Offset: 0x14a
// Size: 0x48
function function_45e51da251cd5e3a( frac )
{
    assert( isdefined( self.var_a0de55e36be21b7a ), "<dev string:x24>" );
    self notify( #"hash_b2c8a65bb4eb6893", frac );
    self.var_a0de55e36be21b7a Interactionholding::set_progressfrac( self, frac * 360 );
}

// Namespace zm_interaction
// Params 0
// Checksum 0x8df40ffb, Offset: 0x19a
// Size: 0x5b
function function_7c7ed762cd4d0333()
{
    assert( isdefined( self.var_a0de55e36be21b7a ), "<dev string:x24>" );
    callback::remove( #"player_laststand", &function_31bdb221a1e771cb );
    function_45e51da251cd5e3a( 0 );
    waitframe();
    
    if ( self.var_a0de55e36be21b7a Interactionholding::is_open( self ) )
    {
        self.var_a0de55e36be21b7a Interactionholding::close( self );
    }
}

// Namespace zm_interaction
// Params 7
// Checksum 0x47e5e1d0, Offset: 0x1fd
// Size: 0x31e
function function_df340931f1a0fe6e( hold_time, var_4eb7bbc8eb7cea79, radius, var_72e52350a5016ee6, var_7db86d9b3e6952c5, var_f0d87f75743a9881, var_68b32a8bafee7061 )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"last_stand_enter" );
    self endon( #"hash_38101be0adc9a0bf" );
    self endon( #"blackhole_teleporting" );
    
    if ( var_68b32a8bafee7061 )
    {
        self endon( var_68b32a8bafee7061 );
    }
    
    var_7161dc5d09bfd375 = 0;
    start_time = gettime();
    result = 0;
    waitframe();
    
    if ( !isdefined( hold_time ) )
    {
        hold_time = 3;
    }
    
    if ( !isdefined( self.var_83cebc8cbb76e120 ) )
    {
        self.var_83cebc8cbb76e120 = 0;
    }
    
    if ( !isdefined( var_f0d87f75743a9881 ) )
    {
        var_f0d87f75743a9881 = 0;
    }
    
    if ( var_72e52350a5016ee6 )
    {
        if ( var_f0d87f75743a9881 )
        {
            if ( !isdefined( self.var_6d238ed5f0bf5c99 ) )
            {
                self.var_6d238ed5f0bf5c99 = [];
            }
            
            if ( isdefined( var_7db86d9b3e6952c5.var_83cebc8cbb76e120 ) && arraycontains( self.var_6d238ed5f0bf5c99, var_7db86d9b3e6952c5 ) )
            {
                self.var_83cebc8cbb76e120 = var_7db86d9b3e6952c5.var_83cebc8cbb76e120;
            }
            else
            {
                self.var_6d238ed5f0bf5c99[ self.var_6d238ed5f0bf5c99.size ] = var_7db86d9b3e6952c5;
                self.var_83cebc8cbb76e120 = 0;
            }
        }
        else if ( self.var_79d4743aaada7261 != var_7db86d9b3e6952c5 )
        {
            self notify( #"hash_e4dfcf56c4fe219d", self.var_83cebc8cbb76e120 );
            self.var_83cebc8cbb76e120 = 0;
        }
    }
    else
    {
        self.var_83cebc8cbb76e120 = 0;
    }
    
    callback::add( #"player_laststand", &function_31bdb221a1e771cb );
    
    while ( true )
    {
        if ( isdefined( var_4eb7bbc8eb7cea79 ) && isdefined( radius ) )
        {
            if ( self usebuttonpressed() && distance2d( self.origin, var_4eb7bbc8eb7cea79.origin ) <= radius )
            {
                var_7161dc5d09bfd375 = utility::function_6f5d2e1f1ff70482( gettime() - start_time + self.var_83cebc8cbb76e120 ) / hold_time;
                
                if ( var_7161dc5d09bfd375 <= 1 )
                {
                    if ( self.inlaststand )
                    {
                        return;
                    }
                    
                    /#
                        iprintlnbold( var_7161dc5d09bfd375 );
                    #/
                    
                    function_45e51da251cd5e3a( var_7161dc5d09bfd375 );
                }
                else
                {
                    result = 1;
                    break;
                }
            }
            else
            {
                result = 0;
                break;
            }
        }
        else
        {
            info = weapon::function_e418c15787e60727( self );
            var_b69d7072ddcca9ea = info.var_17a7b9ae2a4d76d5;
            
            if ( self usebuttonpressed() || var_b69d7072ddcca9ea )
            {
                var_7161dc5d09bfd375 = utility::function_6f5d2e1f1ff70482( gettime() - start_time + self.var_83cebc8cbb76e120 ) / hold_time;
                
                if ( var_7161dc5d09bfd375 <= 1 )
                {
                    if ( self.inlaststand )
                    {
                        return;
                    }
                    
                    /#
                        iprintlnbold( var_7161dc5d09bfd375 );
                    #/
                    
                    function_45e51da251cd5e3a( var_7161dc5d09bfd375 );
                }
                else
                {
                    result = 1;
                    break;
                }
            }
            else
            {
                result = 0;
                break;
            }
        }
        
        waitframe();
    }
    
    function_7c7ed762cd4d0333();
    wait 0.05;
    
    if ( var_72e52350a5016ee6 )
    {
        self.var_83cebc8cbb76e120 = self.var_83cebc8cbb76e120 + gettime() - start_time;
        self.var_79d4743aaada7261 = var_7db86d9b3e6952c5;
        
        if ( isdefined( var_7db86d9b3e6952c5 ) && var_f0d87f75743a9881 )
        {
            var_7db86d9b3e6952c5.var_83cebc8cbb76e120 = self.var_83cebc8cbb76e120;
        }
    }
    
    return result;
}

// Namespace zm_interaction
// Params 1
// Checksum 0x1f0fb1f5, Offset: 0x524
// Size: 0x1f
function function_31bdb221a1e771cb( params )
{
    self notify( #"hash_38101be0adc9a0bf" );
    function_7c7ed762cd4d0333();
}

// Namespace zm_interaction
// Params 2
// Checksum 0x1b03488e, Offset: 0x54b
// Size: 0xc5
function function_54d885543db575f3( player, var_7db86d9b3e6952c5 )
{
    if ( isplayer( player ) )
    {
        player.var_83cebc8cbb76e120 = 0;
    }
    else
    {
        foreach ( player in level.players )
        {
            if ( isdefined( player.var_83cebc8cbb76e120 ) )
            {
                player.var_83cebc8cbb76e120 = 0;
            }
        }
    }
    
    if ( isdefined( var_7db86d9b3e6952c5 ) )
    {
        var_7db86d9b3e6952c5.var_83cebc8cbb76e120 = 0;
    }
}

