module hash

import std/num/int64

val fnv1a_prime = 0x00000100000001b3
val fnv1a_offset = -3750763034362895579

val splitmix_c0 = 0x9E3779B97F4A7C15
val splitmix_c1 = 0xBF58476D1CE4E5B9
val splitmix_c2 = 0x94D049BB133111EB

val splitmix_steps = [
    (30, splitmix_c1),
    (27, splitmix_c2),
    (31, 1),
    ]

fun wrap_i64(x: int): int
    (x + 2^63) % 2^64 - 2^63

pub fun splitmix(input: int): int
    splitmix_steps.foldl((input + splitmix_c0).wrap_i64 , fn(hold, (shift, factor))
        val msk = 1.i64.shl(64 - shift) - 1.i64
        val shifted = hold.i64.shr(shift).and(msk)
        (hold.i64.xor(shifted).int * factor).wrap_i64
    )

pub fun fnv1a(input: string): int
    input.list.foldl(fnv1a_offset, fn(hash, char) 
        (hash.i64.xor(char.int.i64).int * fnv1a_prime).wrap_i64
    )

