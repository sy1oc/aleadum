module hashidum

import std/num/int64

val fnv1a-prime: int64 = 0x00000100000001b3.i64
val fnv1a-offset: int64 = -3750763034362895579.i64

val splitmix-c0: int64 = -7046029254386353131.i64 
val splitmix-c1: int64 = -4658895280553007687.i64 
val splitmix-c2: int64 = -7723592293110705685.i64

pub fun splitmix(input: int64): int64
    val h1 = input + splitmix-c0
    val h2 = (h1 ^ h1.shr(30)) * splitmix-c1
    val h3 = (h2 ^ h2.shr(27)) * splitmix-c2
    h3 ^ h3.shr(31)

pub fun fnv1a(input: string): int64
    input.list.foldl(fnv1a-offset) fn(hash, char) 
        (hash ^ char.int.i64) * fnv1a-prime
