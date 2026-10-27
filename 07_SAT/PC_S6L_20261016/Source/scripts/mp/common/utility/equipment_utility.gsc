// scripts\mp\common\utility\equipment_utility.gsc  (hash_2d7afcaab397c334.gscc) (size: 3475 Bytes / 0xd93 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x995ed116 (2573127958)
// size ...... 3475 (0xd93)
// includes .. 7   (offset: 0xceb)
// strings ... 9   (offset: 0xd23)
// dev strs .. 0   (offset: 0xd93)
// exports ... 14  (offset: 0x83f)
// cseg ...... 0xeb + 0x754 (0x83f)
// imports ... 22  (offset: 0xa6f)
// animtree1 . 0   (offset: 0xd93)
// animtree2 . 0   (offset: 0xd93)
#using scripts\mp\class;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\dialog_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\loot\common_item;
#using scripts\mp\supers;

#namespace equipment_utility;

// Namespace equipment_utility
// Params 5
// Checksum 0xccc64ceb, Offset: 0x109
// Size: 0x47
function function_2d044a0367c41bbf( weapon_ref, var_65246a83e689f027, dvar_str, bundle_val, default_val )
{
    function_609d935437fe085( weapon_ref, var_65246a83e689f027, dvar_str, bundle_val, default_val, #"int" );
}

// Namespace equipment_utility
// Params 5
// Checksum 0xccd5a26e, Offset: 0x158
// Size: 0x47
function function_19ac700f043604( weapon_ref, var_65246a83e689f027, dvar_str, bundle_val, default_val )
{
    function_609d935437fe085( weapon_ref, var_65246a83e689f027, dvar_str, bundle_val, default_val, #"float" );
}

// Namespace equipment_utility
// Params 5
// Checksum 0x87fb83a8, Offset: 0x1a7
// Size: 0x47
function function_8489870ea971d85f( weapon_ref, var_65246a83e689f027, dvar_str, bundle_val, default_val )
{
    function_609d935437fe085( weapon_ref, var_65246a83e689f027, dvar_str, bundle_val, default_val, #"string" );
}

// Namespace equipment_utility
// Params 6
// Checksum 0x52078805, Offset: 0x1f6
// Size: 0x86
function function_609d935437fe085( weapon_ref, var_65246a83e689f027, dvar_str, bundle_val, default_val, value_type )
{
    if ( !isdefined( weapon_ref ) || weapon_ref == "" )
    {
        return;
    }
    
    level.var_7e63dff3edafed9d[ weapon_ref ][ var_65246a83e689f027 ] = function_4ebb4dd5ed3659a1( dvar_str, bundle_val, default_val );
    
    if ( isdefined( value_type ) )
    {
        level.var_7e63dff3edafed9d[ weapon_ref ][ var_65246a83e689f027 ].type = value_type;
    }
}

// Namespace equipment_utility
// Params 3
// Checksum 0xc55b9bee, Offset: 0x284
// Size: 0x7c
function function_4ebb4dd5ed3659a1( dvar_str, bundle_val, default_val )
{
    var_38dca6af9a1f0358 = spawnstruct();
    
    if ( isdefined( dvar_str ) )
    {
        var_38dca6af9a1f0358.dvarstr = dvar_str;
    }
    
    if ( isdefined( bundle_val ) )
    {
        var_38dca6af9a1f0358.bundle_val = bundle_val;
    }
    
    if ( isdefined( default_val ) )
    {
        var_38dca6af9a1f0358.default_val = default_val;
    }
    else
    {
        var_38dca6af9a1f0358.default_val = 0;
    }
    
    return var_38dca6af9a1f0358;
}

// Namespace equipment_utility
// Params 2
// Checksum 0x49f62f2e, Offset: 0x309
// Size: 0x13b
function function_ba332b3b54d2a9c4( weapon_ref, var_65246a83e689f027 )
{
    if ( !isdefined( level.var_7e63dff3edafed9d[ weapon_ref ] ) )
    {
        return 0;
    }
    
    var_38dca6af9a1f0358 = level.var_7e63dff3edafed9d[ weapon_ref ][ var_65246a83e689f027 ];
    
    if ( !isdefined( var_38dca6af9a1f0358 ) )
    {
        return 0;
    }
    
    if ( isdefined( var_38dca6af9a1f0358.bundle_val ) )
    {
        return var_38dca6af9a1f0358.bundle_val;
    }
    
    if ( !( isdefined( var_38dca6af9a1f0358.dvarstr ) && isdefined( var_38dca6af9a1f0358.type ) ) )
    {
        return var_38dca6af9a1f0358.default_val;
    }
    
    if ( var_38dca6af9a1f0358.type == #"float" )
    {
        return getdvarfloat( var_38dca6af9a1f0358.dvarstr, var_38dca6af9a1f0358.default_val );
    }
    else if ( var_38dca6af9a1f0358.type == #"int" )
    {
        return getdvarint( var_38dca6af9a1f0358.dvarstr, var_38dca6af9a1f0358.default_val );
    }
    else if ( var_38dca6af9a1f0358.type == #"string" )
    {
        return getdvar( var_38dca6af9a1f0358.dvarstr, var_38dca6af9a1f0358.default_val );
    }
    
    return var_38dca6af9a1f0358.default_val;
}

// Namespace equipment_utility
// Params 1
// Checksum 0x82502634, Offset: 0x44d
// Size: 0x4b
function function_43352e2ff32f9a9c( equipmentname )
{
    bundle = level.equipment.table[ equipmentname ].bundle;
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    return bundle.minimapicon;
}

// Namespace equipment_utility
// Params 1, eflags: 0x4
// Checksum 0x727392af, Offset: 0x4a1
// Size: 0x4a
function private function_c931d3c740999c0d( delaytime )
{
    self endon( #"disconnect" );
    self notify( #"hash_ce544cef131519d" );
    self endon( #"hash_ce544cef131519d" );
    wait delaytime;
    
    if ( isdefined( self.var_f32d7f1379cb21bf ) )
    {
        self.var_f32d7f1379cb21bf = undefined;
    }
}

// Namespace equipment_utility
// Params 2
// Checksum 0x4ac97523, Offset: 0x4f3
// Size: 0x46
function function_364a1a0e0c018518( equipmentname, dialog )
{
    dialogueentry = game[ "dialog" ][ self.team ][ getxhash( equipmentname ) ][ dialog ];
    dialog_utility::function_78b949128eb252eb( dialog, dialogueentry );
}

// Namespace equipment_utility
// Params 3
// Checksum 0x195dc706, Offset: 0x541
// Size: 0x74
function function_72a91d0610eb601c( equipmentname, dialogsingle, dialogmultiple )
{
    if ( !isdefined( self.var_ce27f3b1a1cd47e1 ) )
    {
        self.var_ce27f3b1a1cd47e1 = [];
    }
    
    if ( self.var_ce27f3b1a1cd47e1[ equipmentname ] > gettime() )
    {
        function_364a1a0e0c018518( equipmentname, dialogmultiple );
    }
    else
    {
        function_364a1a0e0c018518( equipmentname, dialogsingle );
    }
    
    self.var_ce27f3b1a1cd47e1[ equipmentname ] = gettime() + 7000;
}

// Namespace equipment_utility
// Params 1
// Checksum 0xae0761ac, Offset: 0x5bd
// Size: 0x152
function function_9b8126f6415066aa( attacker )
{
    if ( !isplayer( self.owner ) )
    {
        return;
    }
    
    if ( !player_utility::playersareenemies( attacker, self.owner ) )
    {
        return;
    }
    
    if ( !( isdefined( self.superref ) && isdefined( supers_mp::issuper( self.superref ) ) ) )
    {
        return;
    }
    
    dialog = #"destroyed";
    
    if ( isdefined( self.owner.plantedsuperequip.size ) )
    {
        count = 0;
        
        foreach ( plantedsuper in self.owner.plantedsuperequip )
        {
            if ( plantedsuper.superref === self.superref )
            {
                count++;
                
                if ( count > 1 )
                {
                    dialog = #"destroyed_multiple";
                    break;
                }
            }
        }
    }
    
    self.owner thread function_364a1a0e0c018518( self.superref, dialog );
}

// Namespace equipment_utility
// Params 1
// Checksum 0x45b6e9b, Offset: 0x717
// Size: 0x6b
function function_53b772686abfc378( equipmentref )
{
    if ( !level.gamemodebundle.var_d0dc838595bfc1e3 )
    {
        return;
    }
    
    variantid = undefined;
    
    if ( isenumvaluevalid( level.loadoutsgroup, "Equipment", equipmentref ) )
    {
        variantid = self getplayerdata( level.loadoutsgroup, "customizationSetup", "equipmentCustomization", equipmentref, "variantID" );
    }
    
    return variantid;
}

// Namespace equipment_utility
// Params 1
// Checksum 0xa521b8d5, Offset: 0x78b
// Size: 0xb3
function function_9b440a99b2f01ec9( killstreakref )
{
    if ( !game_utility::function_6131f69cfe56ed90() )
    {
        return;
    }
    
    lootid = common_item::items_getlootidfromref( killstreakref );
    variantid = undefined;
    
    if ( class::function_4d362babbfd5b4b1() )
    {
        for ( index = 0; index < 20 ; index++ )
        {
            killstreaklootid = self getplayerdata( level.loadoutsgroup, "killstreakSetups", index, "killstreakLootID" );
            
            if ( killstreaklootid == lootid )
            {
                variantid = self getplayerdata( level.loadoutsgroup, "killstreakSetups", index, "blueprintLootID" );
                break;
            }
        }
    }
    
    if ( isdefined( variantid ) )
    {
        return killstreaks::function_a9203223832db05d( killstreakref, variantid );
    }
    
    return 0;
}

