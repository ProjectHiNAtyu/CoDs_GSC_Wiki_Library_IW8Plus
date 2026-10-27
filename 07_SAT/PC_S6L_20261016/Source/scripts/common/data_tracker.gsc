// scripts\common\data_tracker.gsc  (hash_413d0426f154bd91.gscc) (size: 4259 Bytes / 0x10a3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x87fed5cb (2281625035)
// size ...... 4259 (0x10a3)
// includes .. 0   (offset: 0xf8b)
// strings ... 4   (offset: 0xf8b)
// dev strs .. 17  (offset: 0xfbb)
// exports ... 25  (offset: 0x95b)
// cseg ...... 0x89 + 0x8d2 (0x95b)
// imports ... 18  (offset: 0xd43)
// animtree1 . 0   (offset: 0x10a3)
// animtree2 . 0   (offset: 0x10a3)
#namespace data_tracker;

// Namespace data_tracker
// Params 0
// Checksum 0x11e21f03, Offset: 0xa7
// Size: 0x8
function createstruct_datatracker()
{
    return _createstruct_datatracker();
}

// Namespace data_tracker
// Params 1
// Checksum 0x18fe2380, Offset: 0xb8
// Size: 0x2c
function function_201f17e24a1e13b9( var_846ead32453061b6 )
{
    if ( !isstruct( var_846ead32453061b6 ) )
    {
        assertmsg( "<dev string:x24>" );
    }
    
    _createstruct_datatracker( var_846ead32453061b6 );
}

// Namespace data_tracker
// Params 1
// Checksum 0x27ffa92, Offset: 0xec
// Size: 0x42
function adddataobject( dataobject )
{
    if ( !isdefined( dataobject.uniquename ) )
    {
        assertmsg( "<dev string:x64>" );
        return;
    }
    
    self.dataobjects[ dataobject.uniquename ] = dataobject;
}

// Namespace data_tracker
// Params 4
// Checksum 0xc26f688f, Offset: 0x136
// Size: 0x6f
function adddata( datauniquename, datatype, value, callbackfunction )
{
    if ( isdefined( self.dataobjects[ datauniquename ] ) )
    {
        assertmsg( "<dev string:xc4>" + datauniquename + "<dev string:xed>" );
        return;
    }
    
    dataobject = function_37961450ba1e44a4( datauniquename, datatype, value, callbackfunction );
    adddataobject( dataobject );
}

// Namespace data_tracker
// Params 3
// Checksum 0x930e45f1, Offset: 0x1ad
// Size: 0x50
function adddataint( datauniquename, value, callbackfunction )
{
    if ( !isint( value ) )
    {
        assertmsg( "<dev string:x119>" + datauniquename + "<dev string:x149>" );
        return;
    }
    
    adddata( datauniquename, "Integer", value, callbackfunction );
}

// Namespace data_tracker
// Params 3
// Checksum 0x45700c33, Offset: 0x205
// Size: 0x50
function adddatafloat( datauniquename, value, callbackfunction )
{
    if ( !isfloat( value ) )
    {
        assertmsg( "<dev string:x17f>" + datauniquename + "<dev string:x1b1>" );
        return;
    }
    
    adddata( datauniquename, "Float", value, callbackfunction );
}

// Namespace data_tracker
// Params 3
// Checksum 0xba9f17a9, Offset: 0x25d
// Size: 0x50
function adddatastring( datauniquename, value, callbackfunction )
{
    if ( !isstring( value ) )
    {
        assertmsg( "<dev string:x1e4>" + datauniquename + "<dev string:x217>" );
        return;
    }
    
    adddata( datauniquename, "String", value, callbackfunction );
}

// Namespace data_tracker
// Params 3
// Checksum 0xed3838da, Offset: 0x2b5
// Size: 0x2f
function adddataprogresstracker( datauniquename, value, callbackfunction )
{
    adddata( datauniquename, "ProgressTracker", value, callbackfunction );
}

// Namespace data_tracker
// Params 1
// Checksum 0x8d207865, Offset: 0x2ec
// Size: 0x18
function removedata( datauniquename )
{
    self.dataobjects[ datauniquename ] = undefined;
}

// Namespace data_tracker
// Params 2
// Checksum 0xd876c366, Offset: 0x30c
// Size: 0x62
function updatedata( dataobjectuniquename, updatedvalue )
{
    dataobject = self.dataobjects[ dataobjectuniquename ];
    
    if ( !isdefined( dataobject ) )
    {
        assertmsg( "<dev string:x24b>" + dataobjectuniquename + "<dev string:x277>" );
        return;
    }
    
    dataobject.value = updatedvalue;
    function_d2b6731449926c27( dataobjectuniquename );
}

// Namespace data_tracker
// Params 1
// Checksum 0x9aea26ed, Offset: 0x376
// Size: 0x4b
function function_d2b6731449926c27( dataobjectuniquename )
{
    dataobject = self.dataobjects[ dataobjectuniquename ];
    
    if ( !isdefined( dataobject ) )
    {
        assertmsg( "<dev string:x29e>" + dataobjectuniquename + "<dev string:x277>" );
        return;
    }
    
    function_eb9cbd7f1422d65d( dataobjectuniquename );
}

// Namespace data_tracker
// Params 2
// Checksum 0xf65ea6b9, Offset: 0x3c9
// Size: 0x41
function addcallback( callbackfunction, callonobject )
{
    newcallback = _createstruct_callback( callbackfunction, callonobject );
    self.shareddatacallbacks[ self.shareddatacallbacks.size ] = newcallback;
}

// Namespace data_tracker
// Params 3
// Checksum 0x7983de11, Offset: 0x412
// Size: 0x5f
function function_7a13b0495df1c3e( callbackfunction, dataobjectuniquename, callonobject )
{
    dataobject = self.dataobjects[ dataobjectuniquename ];
    
    if ( !isdefined( dataobject ) )
    {
        assertmsg( "<dev string:x2d8>" + dataobjectuniquename + "<dev string:x277>" );
        return;
    }
    
    function_337916484954e107( dataobject, callbackfunction, callonobject );
}

// Namespace data_tracker
// Params 1
// Checksum 0x6a4075ce, Offset: 0x479
// Size: 0x6d
function removecallback( callbackfunction )
{
    for ( callbackid = 0; callbackid < self.shareddatacallbacks.size ; callbackid++ )
    {
        if ( self.shareddatacallbacks[ callbackid ].callbackfunction == callbackfunction )
        {
            self.shareddatacallbacks[ callbackid ] = undefined;
        }
    }
    
    self.shareddatacallbacks = function_5713d46873b29625( self.callbacks );
}

// Namespace data_tracker
// Params 2
// Checksum 0x2635d164, Offset: 0x4ee
// Size: 0xb5
function function_b00d978433f1f79b( callbackfunction, dataobjectuniquename )
{
    dataobject = self.dataobjects[ dataobjectuniquename ];
    
    if ( !isdefined( dataobject ) )
    {
        assertmsg( "<dev string:x310>" + dataobjectuniquename + "<dev string:x277>" );
        return;
    }
    
    for ( callbackid = 0; callbackid < dataobject.callbacks.size ; callbackid++ )
    {
        if ( dataobject.callbacks[ callbackid ].callbackfunction == callbackfunction )
        {
            dataobject.callbacks[ callbackid ] = undefined;
        }
    }
    
    dataobject.callbacks = function_5713d46873b29625( dataobject.callbacks );
}

// Namespace data_tracker
// Params 1
// Checksum 0xc1713625, Offset: 0x5ab
// Size: 0x4d
function getdatavalue( dataobjectuniquename )
{
    dataobject = self.dataobjects[ dataobjectuniquename ];
    
    if ( !isdefined( dataobject ) )
    {
        assertmsg( "<dev string:x34b>" + dataobjectuniquename + "<dev string:x277>" );
        return;
    }
    
    return dataobject.value;
}

// Namespace data_tracker
// Params 1
// Checksum 0x95fcbd13, Offset: 0x601
// Size: 0x44
function getdataobject( dataobjectuniquename )
{
    dataobject = self.dataobjects[ dataobjectuniquename ];
    
    if ( !isdefined( dataobject ) )
    {
        assertmsg( "<dev string:x34b>" + dataobjectuniquename + "<dev string:x277>" );
        return;
    }
    
    return dataobject;
}

// Namespace data_tracker
// Params 1
// Checksum 0x29ac3e25, Offset: 0x64e
// Size: 0x19, Type: bool
function function_72b9e57bfc6deb7a( dataobjectuniquename )
{
    return isdefined( self.dataobjects[ dataobjectuniquename ] );
}

// Namespace data_tracker
// Params 1
// Checksum 0xf340a8e3, Offset: 0x670
// Size: 0x164
function function_eb9cbd7f1422d65d( dataobjectuniquename )
{
    dataobject = self.dataobjects[ dataobjectuniquename ];
    
    if ( !isdefined( dataobject ) )
    {
        assertmsg( "<dev string:x378>" + dataobjectuniquename + "<dev string:x277>" );
        return;
    }
    
    foreach ( callback in dataobject.callbacks )
    {
        if ( isdefined( callback ) )
        {
            callback.callon ?? level thread [[ callback.callbackfunction ]]( self, dataobject );
        }
    }
    
    foreach ( callback in self.shareddatacallbacks )
    {
        if ( isdefined( callback ) )
        {
            callback.callon ?? level thread [[ callback.callbackfunction ]]( self, dataobject );
        }
    }
}

// Namespace data_tracker
// Params 1
// Checksum 0xa1db9511, Offset: 0x7dc
// Size: 0x17
function function_83a7663cb3e8d879( dataobject )
{
    return dataobject.uniquename;
}

// Namespace data_tracker
// Params 1, eflags: 0x4
// Checksum 0xea2d07f2, Offset: 0x7fc
// Size: 0x33
function private _createstruct_datatracker( datatrackerstruct = spawnstruct() )
{
    datatrackerstruct.dataobjects = [];
    datatrackerstruct.shareddatacallbacks = [];
    return datatrackerstruct;
}

// Namespace data_tracker
// Params 4, eflags: 0x4
// Checksum 0xcdd1b1ce, Offset: 0x838
// Size: 0x80
function private function_37961450ba1e44a4( uniquename, datatype, value, callbackfunction )
{
    dataobject = spawnstruct();
    dataobject.uniquename = uniquename;
    dataobject.datatype = datatype;
    dataobject.value = value;
    dataobject.callbacks = [];
    
    if ( isdefined( callbackfunction ) )
    {
        function_337916484954e107( dataobject, callbackfunction );
    }
    
    return dataobject;
}

// Namespace data_tracker
// Params 2, eflags: 0x4
// Checksum 0xc8b5fc10, Offset: 0x8c1
// Size: 0x43
function private _createstruct_callback( callbackfunction, callonobject )
{
    newcallback = spawnstruct();
    newcallback.callon = callonobject;
    newcallback.callbackfunction = callbackfunction;
    return newcallback;
}

// Namespace data_tracker
// Params 3, eflags: 0x4
// Checksum 0x6b7a7141, Offset: 0x90d
// Size: 0x4e
function private function_337916484954e107( dataobject, callbackfunction, callonobject )
{
    newcallback = _createstruct_callback( callbackfunction, callonobject );
    dataobject.callbacks[ dataobject.callbacks.size ] = newcallback;
}

