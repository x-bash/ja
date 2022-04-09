BEGIN {
    false = 0
    FALSE = 0
    true = 1
    TRUE = 1
    S = "\001"
    T = "\002"
    L = "\003"
}


# Section: utils
function k(){ return _k == "" ? _k = unquote( key ): _k; }
function v(){ return _v == "" ? _v = unquote( $0 ): _v; }

function kpgen( v1, v2, v3, v4, v5, v6, v7, v8, v9, _ret ){
    _ret = ""
    if ( v1 == "" ) return _ret
    _ret = _ret S quote( v1 )
    if ( v2 == "" ) return _ret
    _ret = _ret S quote( v2 )
    if ( v3 == "" ) return _ret
    _ret = _ret S quote( v3 )
    if ( v4 == "" ) return _ret
    _ret = _ret S quote( v4 )
    if ( v5 == "" ) return _ret
    _ret = _ret S quote( v5 )
    if ( v6 == "" ) return _ret
    _ret = _ret S quote( v6 )
    if ( v7 == "" ) return _ret
    _ret = _ret S quote( v7 )
    if ( v8 == "" ) return _ret
    _ret = _ret S quote( v8 )
    if ( v9 == "" ) return _ret
    _ret = _ret S quote( v9 )
    return _ret
}

function get( v1, v2, v3, v4, v5, v6, v7, v8, v9 ){
    return _[ kpgen( v1, v2, v3, v4, v5, v6, v7, v8, v9 ) ]
}

function g( v1, v2, v3, v4, v5, v6, v7, v8, v9 ){
    return _[ kp S kpgen( v1, v2, v3, v4, v5, v6, v7, v8, v9 ) ]
}

function kpmatch( v1, v2, v3, v4, v5, v6, v7, v8, v9 ){
    return match(kp, kpgen( v1, v2, v3, v4, v5, v6, v7, v8, v9 ) "$" )
}

function glob_item( key ){
    gsub(/\*/, /[^\001]+/, key)
    return key
}

function glob( v1, v2, v3, v4, v5, v6, v7, v8, v9 ){
    _ret = ""
    if ( v1 == "" ) return _ret
    _ret = _ret S glob_item( v1 )
    if ( v2 == "" ) return _ret
    _ret = _ret S glob_item( v2 )
    if ( v3 == "" ) return _ret
    _ret = _ret S glob_item( v3 )
    if ( v4 == "" ) return _ret
    _ret = _ret S glob_item( v4 )
    if ( v5 == "" ) return _ret
    _ret = _ret S glob_item( v5 )
    if ( v6 == "" ) return _ret
    _ret = _ret S glob_item( v6 )
    if ( v7 == "" ) return _ret
    _ret = _ret S glob_item( v7 )
    if ( v8 == "" ) return _ret
    _ret = _ret S glob_item( v8 )
    if ( v9 == "" ) return _ret
    _ret = _ret S glob_item( v9 )
    return _ret
}

function kpglob( v1, v2, v3, v4, v5, v6, v7, v8, v9 ){
    return match( kp, glob(v1, v2, v3, v4, v5, v6, v7, v8, v9) "$" )
}

# EndSection

# Section: Machine Stringify
function ___json_stringify_machine_dict(arr, keypath,     _klist, _l, _i, _key, _val, _ret){
    _l = jdict_keys2arr(arr, keypath, _klist)

    if (_l == 0) return "{\n}"

    for (_i=1; _i<=_l; _i++){
        _key = _klist[ _i ]
        # _val = arr[ keypath S _key ]
        _ret = _ret "\n,\n" _key "\n:\n" ___json_stringify_machine_value( arr, keypath S _key )
    }
    _ret = substr(_ret, 4)
    return "{\n" _ret "\n}"
}

function ___json_stringify_machine_list(arr, keypath,     _l, _i, _ret){
    _l = arr[ keypath T_LEN ]
    if (_l == 0) return "[\n]"
    _ret = ___json_stringify_machine_value( arr, keypath  S "\"" 1 "\"" )

    for (_i=2; _i<=_l; _i++){
        _ret = _ret "\n,\n" ___json_stringify_machine_value( arr, keypath S "\""  _i "\"" )
    }

    return "[\n" _ret "\n]"
}

function ___json_stringify_machine_value(arr, keypath,     _t, _klist, _i, _ret){
    _t = arr[ keypath]
    if (_t == "{") {
        return ___json_stringify_machine_dict(arr, keypath)
    } else if (_t == "[") {
        return ___json_stringify_machine_list(arr, keypath)
    } else {
        return _t
    }
}

function json_stringify_machine(arr, keypath,    _i, _len,_ret){
    if (keypath != "") {
        keypath=jpath(keypath)
        return ___json_stringify_machine_value(arr, keypath)
    }
    _len = arr[ T_LEN ]
    if (_len < 1)  return ""

    _ret = ___json_stringify_machine_value( arr,  S "\"" 1 "\"")
    for (_i=2; _i<=_len; ++_i) {
        _ret = _ret "\n"___json_stringify_machine_value( arr,  S "\"" _i "\"")
    }

    return _ret
}
# EndSection

# Section: unquote and quote
function unquote(str){
    if (str !~ /^"/) { # "
        return str
    }
    gsub(/\\\\/, "\001\001", str)
    gsub(/\\"/, /"/, str)
    gsub("\001\001", "\\\\", str)
    return substr(str, 2, length(str)-2)
}

function quote(str){
    gsub(/\\/, "\\\\", str)
    gsub(/"/, "\\\"", str)
    return "\"" str "\""
}
# EndSection

# Section: jiter
function jiter_init( keypath_prefix ) {
    JITER_FA_KEYPATH    = keypath_prefix
    JITER_STATE         = T_ROOT
    JITER_LAST_KP       = ""
    JITER_LEVEL         = 0
    JITER_CURLEN        = 0

    JITER_OFFSET_FULLKP = 10000
}

function jiter( item,  _res ) {
    if (item ~ /^[,:]*$/) return
    if (item ~ /^[tfn"0-9+-]/) #"   # (item !~ /^[\{\}\[\]]$/) {
    {
        if ( JITER_LAST_KP != "" ) {
            _res = JITER_FA_KEYPATH S JITER_LAST_KP
            JITER_LAST_KP = ""
            key = JITER_LAST_KP
            return _res
        }
        JITER_CURLEN = JITER_CURLEN + 1
        if ( JITER_STATE != "{" ) {
            return JITER_FA_KEYPATH S "\"" JITER_CURLEN "\""
        }
        JITER_LAST_KP = item
        # return JITER_FA_KEYPATH S JITER_CURLEN
    } else if (item ~ /^[\[\{]$/) { # }
        if ( JITER_STATE != "{" } ) {
            JITER_CURLEN = JITER_CURLEN + 1
            _[ JITER_FA_KEYPATH T_LEN ] = JITER_CURLEN
            JITER_FA_KEYPATH = JITER_FA_KEYPATH S "\"" JITER_CURLEN "\""
            _[ ++ JITER_LEVEL ] = JITER_CURLEN
            key = JITER_CURLEN
        } else {
            _[ JITER_FA_KEYPATH T_LEN ] = JITER_CURLEN
            JITER_FA_KEYPATH = JITER_FA_KEYPATH S JITER_LAST_KP
            _[ ++ JITER_LEVEL ] = JITER_LAST_KP
            key = JITER_LAST_KP
            JITER_LAST_KP = ""
        }
        JITER_STATE = item
        JITER_CURLEN = 0

        _[ JITER_FA_KEYPATH ] = item
        _[ JITER_LEVEL + JITER_OFFSET_FULLKP ] = JITER_FA_KEYPATH
        return JITER_FA_KEYPATH
        # return ""
    } else {
        _[ JITER_FA_KEYPATH T_LEN ] = JITER_CURLEN

        _res = JITER_FA_KEYPATH

        JITER_FA_KEYPATH = _[ --JITER_LEVEL + JITER_OFFSET_FULLKP ]
        JITER_STATE = _[ JITER_FA_KEYPATH ]
        JITER_CURLEN = _[ JITER_FA_KEYPATH T_LEN ]

        return _res
    }
    return ""
}
# EndSection

{
    kp = jiter( $0 )
    if (kp == "") next
    l = JITER_LEVEL

    _v = ""
    _k = ""
}
