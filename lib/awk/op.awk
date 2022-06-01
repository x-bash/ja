
# Section: opt
function kpopt(){
    return
}
# EndSection

# Section: utils

function k_reset(){ _k_reset = 0; }
function k(val){
    if (_k_reset == 1) return _k
    _k_reset = 1
    return _k = juq( key )
}

# function k(val){
#     if (val == ""){
#         if (_k_reset == 1) return _k
#         _k_reset = 1
#         return _k = juq( key )
#     }

#     return k()==val
# }

function v_reset(){ _v_reset = 0 }
function v(){
    if (_v_reset == 1) return _v
    _v_reset = 1
    return _v = juq( $0 )
}

function kpgen( v1, v2, v3, v4, v5, v6, v7, v8, v9, _ret ){
    _ret = ""
    if ( v1 == "" ) return _ret
    _ret = _ret S qu( v1 )
    if ( v2 == "" ) return _ret
    _ret = _ret S qu( v2 )
    if ( v3 == "" ) return _ret
    _ret = _ret S qu( v3 )
    if ( v4 == "" ) return _ret
    _ret = _ret S qu( v4 )
    if ( v5 == "" ) return _ret
    _ret = _ret S qu( v5 )
    if ( v6 == "" ) return _ret
    _ret = _ret S qu( v6 )
    if ( v7 == "" ) return _ret
    _ret = _ret S qu( v7 )
    if ( v8 == "" ) return _ret
    _ret = _ret S qu( v8 )
    if ( v9 == "" ) return _ret
    _ret = _ret S qu( v9 )
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
    gsub(/\*/, "[^\001]+", key)
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


# Section: unqu and qu
function e(var, val){   printf("%s=%s", var, val); }
function e_(val){ e("_", val); }
function qe(var, val){   printf("%s=%s", var, qu(val)); }
function qe_(val){ eq("_", val); }

function uq(str){
    if (str !~ /^"/) { # "
        return str
    }
    gsub(/\\\\/, "\001\001", str)
    gsub(/\\"/, /"/, str)
    gsub("\001\001", "\\\\", str)
    return substr(str, 2, length(str)-2)
}

function qu(str){
    gsub(/\\/, "\\\\", str)
    gsub(/"/, "\\\"", str)
    return "\"" str "\""
}

function juq(str){
    if (str !~ /^"/) { # "
        return str
    }
    gsub(/\\\\/, "\001\001", str)
    gsub(/\\"/, /"/, str)
    gsub("\001\001", "\\\\", str)
    return substr(str, 2, length(str)-2)
}

function jqu(str){
    gsub(/\\/, "\\\\", str)
    gsub(/"/, "\\\"", str)
    return "\"" str "\""
}
# EndSection
