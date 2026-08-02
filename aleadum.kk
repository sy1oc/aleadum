import std/num/ddouble
import std/num/int64
import std/time
import std/os/env
import hashidum

struct aleakt
    datast: list<(int, int)>
    weekdayst-firstdayz: int
    yearst-ui-monthst: string

fun println(aleaf: aleakt)
    aleaf.datast.foldl((aleaf.yearst-ui-monthst ++ ":\n" ++ repeat("\t", aleaf.weekdayst-firstdayz), aleaf.weekdayst-firstdayz), 
        fn((inif, indexif), (dayf, resultif))
            (inif ++ (if dayf < 10 then " " else "") ++ dayf.show ++ ": " ++ resultif.show ++ (if indexif + 1 == 7 then "\n" else "\t"), (indexif + 1) % 7 )
    ).fst.println
    
fun main()
    val modif = match get-args().head.maybe(32, fn(argif) argif.parse-int.default(32)) % 32
        0 -> 32
        n -> n
    rollal-vikmonthim(modif).println

fun rollal-vikmonthim(modif: int) : <div, ndet, std/time/utc/utc> aleakt
    val timeif = local-time-now()
    val yearif = timeif.year 
    val monthif = timeif.month 
    val yearif-ui-monthif = yearif.show ++ "-" ++ monthif.show
    Aleakt(
        list(1, timeif.days-in-month)
        .map(fn(dayf)
            val dateif = yearif-ui-monthif ++ "-" ++ dayf.show
            val hashif = dateif.fnv1a.splitmix.int.ddouble / (2^64).ddouble + 0.5.ddouble
            val resultif = computeal(hashif, 1, modif)
            (dayf, resultif)
        ),
        time(yearif, monthif, 1).weekday.int % 7,
        yearif-ui-monthif
    )

fun computeal(inif: ddouble, exif: int, modif: int): div int
    val detif = 0.5.ddouble
    if inif > detif then 
        computeal((inif - detif) / (1.ddouble - detif), exif + 1, modif)
    else 
        match exif % modif
            0 -> modif
            n -> n
