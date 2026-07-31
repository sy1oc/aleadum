import std/num/int64
import std/num/ddouble
import std/time
import std/os/env
import std/time
import hash

fun main()
    val mod = match get-args().head.maybe(32, fn(arg) arg.parse-int.default(32)) % 32
        0 -> 32
        n -> n
    roll_this_month(mod).map(fn((date,num))
        date ++ ": " ++ num.show
    ).join("\n").println

fun roll_this_month(mod: int) : <div, ndet, std/time/utc/utc> list<(string,int)>
    val time = local-time-now()
    val year = time.year
    val month = time.month
    list(1, time.days-in-month)
        .map(fn(day)
            val date = year.show ++ "-" ++ month.show ++ "-" ++ day.show
            val hash = date.fnv1a.splitmix
            val dec = hash.ddouble / (2^64).ddouble + 5.ddouble-exp(-1)
            val num = rec_rat(dec, 1, mod, 5.ddouble-exp(-1))
            (date, num)
        )

fun rec_rat(num: ddouble, count: int, mod: int, ratio: ddouble): div int
    if num > ratio.abs then 
        rec_rat((num - ratio.abs) / (1.ddouble - ratio.abs), count + 1, mod, ratio) 
    else 
        match count % mod
            0 -> mod
            n -> n
