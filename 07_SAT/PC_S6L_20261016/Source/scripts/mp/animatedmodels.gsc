// scripts\mp\animatedmodels.gsc  (hash_5c483c780db0b4ad.gscc) (size: 1063 Bytes / 0x427 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x16976748 (379021128)
// size ...... 1063 (0x427)
// includes .. 1   (offset: 0x413)
// strings ... 1   (offset: 0x41b)
// dev strs .. 0   (offset: 0x427)
// exports ... 3   (offset: 0x293)
// cseg ...... 0x7c + 0x217 (0x293)
// imports ... 9   (offset: 0x30b)
// animtree1 . 0   (offset: 0x427)
// animtree2 . 0   (offset: 0x427)
#using scripts\common\utility;

#namespace animatedmodels;

// Namespace animatedmodels
// Params 0
// Checksum 0xfb4e4db4, Offset: 0x9a
// Size: 0x170
function main()
{
    if ( !isdefined( level.anim_prop_models ) )
    {
        level.anim_prop_models = [];
    }
    
    model_keys = getarraykeys( level.anim_prop_models );
    
    foreach ( model_key in model_keys )
    {
        anim_keys = getarraykeys( level.anim_prop_models[ model_key ] );
        
        foreach ( anim_key in anim_keys )
        {
            precachempanim( level.anim_prop_models[ model_key ][ anim_key ] );
        }
    }
    
    waittillframeend();
    level.init_animatedmodels = [];
    animated_models = getentarray( "animated_model", #targetname );
    utility::array_thread_amortized( animated_models, &animatemodel, 0.05 );
    level.init_animatedmodels = undefined;
}

// Namespace animatedmodels
// Params 0
// Checksum 0x376a9aa, Offset: 0x212
// Size: 0x81
function animatemodel()
{
    if ( isdefined( self.animation ) )
    {
        animation = self.animation;
    }
    else
    {
        keys = getarraykeys( level.anim_prop_models[ self.model ] );
        animkey = keys[ randomint( keys.size ) ];
        animation = level.anim_prop_models[ self.model ][ animkey ];
    }
    
    self scriptmodelplayanim( animation );
    self willneverchange();
}

