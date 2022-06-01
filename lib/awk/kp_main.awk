{
    a = 1 - a
    if (a == 0) val = $0
    else {
        KP = $0
        D = split(KP, _, "\001")
        k = _[ D ]
        next
    }
}