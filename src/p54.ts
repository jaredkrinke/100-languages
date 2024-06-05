// Project Euler problem 54 (Poker Hands), solved entirely within TypeScript's type system

// Number utilities (representing N as an array of length N)
type UnaryZero = [];
type UnaryNumber = any[];
type UnaryToNumber<T extends UnaryNumber> = T extends { length: infer L extends number } ? L : never;
type UnaryIncrement<T extends UnaryNumber> = [...T, any];
type UnaryOne = UnaryIncrement<UnaryZero>;
type UnarySumRecursive<A extends UnaryNumber[], S extends UnaryNumber> = A extends [infer T extends UnaryNumber, ...infer Rest extends UnaryNumber[]] ? UnarySumRecursive<Rest, [...T, ...S]> : S;
type UnarySum<A extends UnaryNumber[]> = UnarySumRecursive<A, UnaryZero>;

// Array utilities
type ArrayLength<A extends any[]> = UnaryToNumber<A>;
type ArrayKeep<A extends any[], Item> =
    A extends [infer First, ...infer Rest]
        ? First extends Item
            ? [First, ...ArrayKeep<Rest, Item>]
            : ArrayKeep<Rest, Item>
        : [];

// Logic utilities
type Equal<A, B> = A extends B ? B extends A ? true : false : false;
type And<A, B> = A extends true ? B extends true ? true : false : false;
type Or<A, B> = A extends true ? true : B extends true ? true : false;
type Or4<A, B, C, D> = Or<A, Or<B, Or<C, D>>>;
type If<C, T, F> = C extends true ? T : F;

// Poker card representation
type RanksDescending = ["A", "K", "Q", "J", "T", "9", "8", "7", "6", "5", "4", "3", "2"];
type Rank = RanksDescending[number];
type Suit = "C" | "D" | "H" | "S";
type Card = { rank: Rank, suit: Suit };

type CardOfSuit<S extends Suit> = { suit: S };
type CardOfRank<R extends Rank> = { rank: R };

// Poker hand normalization
type Hand = Card[];
type RankCount = { rank: Rank, count: number };
type Data = { counts: RankCount[], flush: boolean };

type RankCountOfCount<C> = { count: C };
type CountRank<H extends Hand, R extends Rank> = { rank: R, count: ArrayLength<ArrayKeep<H, CardOfRank<R>>> };
type CountRanksRecursive<H extends Hand, R extends Rank[], Result extends RankCount[]> = R extends [infer First extends Rank, ...infer Rest extends Rank[]] ? CountRanksRecursive<H, Rest, [...Result, CountRank<H, First>]> : Result;
type CountRanks<H extends Hand> = CountRanksRecursive<H, RanksDescending, []>;
type SortedRankCounts<H extends Hand> = ArrayKeep<CountRanks<H>, { count: (1 | 2 | 3 | 4) }>;
type RankFromRankCount<R extends RankCount> = R extends { rank: infer CountRank } ? CountRank : never;
type RanksFromRankCounts<R extends RankCount[]> = R extends [infer First extends RankCount, ...infer Rest extends RankCount[]] ? [RankFromRankCount<First>, ...RanksFromRankCounts<Rest>] : [];
type FlushOfSuit<H extends Hand, S extends Suit> = Equal<5, ArrayLength<ArrayKeep<H, { suit: S }>>>;
type Flush<H extends Hand> = Or4<FlushOfSuit<H, "C">, FlushOfSuit<H, "S">, FlushOfSuit<H, "H">, FlushOfSuit<H, "D">>;

type DataFromHand<H extends Hand> = { counts: SortedRankCounts<H>, flush: Flush<H> };
type RankCountsFromData<D extends Data> = D extends { counts: infer Counts } ? Counts : never;

// Poker hand evaluation
type HandTypesDescending = ["straightFlush", "fourOfAKind", "fullHouse", "flush", "straight", "threeOfAKind", "twoPair", "pair", "highCard"];
type HandType = HandTypesDescending[number];
type Evaluation = { handType: HandType, tieBreakers: Rank[] };

type IsStraight<D extends Data> =
    D extends { counts: infer DataCounts }
        ? DataCounts extends [{ rank: "A" }, { rank: "5" }, { rank: "4" }, { rank: "3" }, { rank: "2" }] ? true
        : DataCounts extends [{ rank: "6" }, { rank: "5" }, { rank: "4" }, { rank: "3" }, { rank: "2" }] ? true
        : DataCounts extends [{ rank: "7" }, { rank: "6" }, { rank: "5" }, { rank: "4" }, { rank: "3" }] ? true
        : DataCounts extends [{ rank: "8" }, { rank: "7" }, { rank: "6" }, { rank: "5" }, { rank: "4" }] ? true
        : DataCounts extends [{ rank: "9" }, { rank: "8" }, { rank: "7" }, { rank: "6" }, { rank: "5" }] ? true
        : DataCounts extends [{ rank: "T" }, { rank: "9" }, { rank: "8" }, { rank: "7" }, { rank: "6" }] ? true
        : DataCounts extends [{ rank: "J" }, { rank: "T" }, { rank: "9" }, { rank: "8" }, { rank: "7" }] ? true
        : DataCounts extends [{ rank: "Q" }, { rank: "J" }, { rank: "T" }, { rank: "9" }, { rank: "8" }] ? true
        : DataCounts extends [{ rank: "K" }, { rank: "Q" }, { rank: "J" }, { rank: "T" }, { rank: "9" }] ? true
        : DataCounts extends [{ rank: "A" }, { rank: "K" }, { rank: "Q" }, { rank: "J" }, { rank: "T" }] ? true
        : false
    : false;

type IsFlush<D extends Data> = D extends { flush: true } ? true : false;
type IsStraightFlush<D extends Data> = And<IsStraight<D>, IsFlush<D>>;

type IsFourOfAKind<D extends Data> = Equal<1, ArrayLength<ArrayKeep<RankCountsFromData<D>, RankCountOfCount<4>>>>;
type HasThreeOfAKind<D extends Data> = Equal<1, ArrayLength<ArrayKeep<RankCountsFromData<D>, RankCountOfCount<3>>>>;
type IsTwoPair<D extends Data> = Equal<2, ArrayLength<ArrayKeep<RankCountsFromData<D>, RankCountOfCount<2>>>>;
type HasOnePair<D extends Data> = Equal<1, ArrayLength<ArrayKeep<RankCountsFromData<D>, RankCountOfCount<2>>>>;
type IsFullHouse<D extends Data> = And<HasThreeOfAKind<D>, HasOnePair<D>>;

type RankForNOfAKind<D extends Data, N extends number> = ArrayKeep<RankCountsFromData<D>, RankCountOfCount<N>> extends [{ rank: infer R extends Rank }] ? R : never;
type RanksForNsOfAKind<D extends Data, N extends number> = RanksFromRankCounts<ArrayKeep<RankCountsFromData<D>, RankCountOfCount<N>>>;
type RankForStraight<D extends Data> =
    D extends { counts: [{ rank: infer FirstRank extends Rank }, { rank: infer SecondRank }, ...infer Rest] }
        // Note the special case for straights that *begin* with an ace
        ? If<And<Equal<FirstRank, "A">, Equal<SecondRank, "5">>, "5", FirstRank>
        : never;

type EvaluationFromData<D extends Data> =
    If<IsStraightFlush<D>,  { handType: "straightFlush",    tieBreakers: [RankForStraight<D>] },
    If<IsFourOfAKind<D>,    { handType: "fourOfAKind",      tieBreakers: [RankForNOfAKind<D, 4>] },
    If<IsFullHouse<D>,      { handType: "fullHouse",        tieBreakers: [RankForNOfAKind<D, 3>, RankForNOfAKind<D, 2>] },
    If<IsFlush<D>,          { handType: "flush",            tieBreakers: RanksForNsOfAKind<D, 1> },
    If<IsStraight<D>,       { handType: "straight",         tieBreakers: [RankForStraight<D>] },
    If<HasThreeOfAKind<D>,  { handType: "threeOfAKind",     tieBreakers: [RankForNOfAKind<D, 3>] },
    If<IsTwoPair<D>,        { handType: "twoPair",          tieBreakers: [...RanksForNsOfAKind<D, 2>, RankForNOfAKind<D, 1>] },
    If<HasOnePair<D>,       { handType: "pair",             tieBreakers: [RankForNOfAKind<D, 2>, ...RanksForNsOfAKind<D, 1>] },
    /* High card */         { handType: "highCard",         tieBreakers: RanksForNsOfAKind<D, 1> }>>>>>>>>;

// Poker hand comparison
type GreaterRankRecursive<A extends Rank, B extends Rank, R extends Rank[]> =
    R extends [infer First, ...infer Rest extends Rank[]]
        ? A extends First
            ? B extends First
                ? false
                : true
            : B extends First
                ? false
                : GreaterRankRecursive<A, B, Rest>
        : false;

type GreaterRank<A extends Rank, B extends Rank> = GreaterRankRecursive<A, B, RanksDescending>;
type GreaterRanks<A extends Rank[], B extends Rank[]> =
    A extends [infer ARank extends Rank, ...infer ARest extends Rank[]]
        ? B extends [infer BRank extends Rank, ...infer BRest extends Rank[]]
            ? If<GreaterRank<ARank, BRank>, true, If<GreaterRank<BRank, ARank>, false, GreaterRanks<ARest, BRest>>>
            : never
        : false;

type BetterHandType<A extends HandType, B extends HandType, H extends HandType[]> =
    H extends [infer First, ...infer Rest extends HandType[]]
        ? A extends First
            ? B extends First
                ? false
                : true
            : B extends First
                ? false
                : BetterHandType<A, B, Rest>
        : false;

type BetterEvaluation<A extends Evaluation, B extends Evaluation> =
    A extends { handType: infer AH extends HandType, tieBreakers: infer AT extends Rank[] }
        ? B extends { handType: infer BH extends HandType, tieBreakers: infer BT extends Rank[] }
            ? If<BetterHandType<AH, BH, HandTypesDescending>, true, If<BetterHandType<BH, AH, HandTypesDescending>, false, GreaterRanks<AT, BT>>>
            : never
        : never;

// Parsing
type NonNewline = Rank | Suit | " ";
type Character = "\n" | NonNewline;
type SplitLines<I extends string, L extends string, O extends string[]> =
    I extends ""
        ? [...O, L]
        : I extends `${infer C extends Character}${infer Rest}`
            ? C extends NonNewline
                ? SplitLines<Rest, `${L}${C}`, O>
                : SplitLines<Rest, "", [...O, L]>
            : never;

type ParseCard<S extends string> =
    S extends `${infer CardRank extends Rank}${infer CardSuit extends Suit}`
        ? { rank: CardRank, suit: CardSuit }
        : never;

type ProcessLine<L extends string> =
    L extends `${infer A1} ${infer A2} ${infer A3} ${infer A4} ${infer A5} ${infer B1} ${infer B2} ${infer B3} ${infer B4} ${infer B5}`
        ? [
            EvaluationFromData<DataFromHand<[ParseCard<A1>, ParseCard<A2>, ParseCard<A3>, ParseCard<A4>, ParseCard<A5>]>>,
            EvaluationFromData<DataFromHand<[ParseCard<B1>, ParseCard<B2>, ParseCard<B3>, ParseCard<B4>, ParseCard<B5>]>>,
        ]
        : never;

// Scoring
type ProcessLinesRecursive<A extends string[], H extends Evaluation[][]> = A extends [infer First extends string, ...infer Rest extends string[]] ? ProcessLinesRecursive<Rest, [...H, ProcessLine<First>]> : H;
type ProcessLines<A extends string[]> = ProcessLinesRecursive<A, []>;

type ScoreRound<A extends Evaluation[]> = A extends [infer First extends Evaluation, infer Second extends Evaluation] ? If<BetterEvaluation<First, Second>, UnaryOne, UnaryZero> : never;
type ScoreRoundsRecursive<A extends Evaluation[][], S extends UnaryNumber[]> = A extends [infer Line extends Evaluation[], ...infer Rest extends Evaluation[][]] ? ScoreRoundsRecursive<Rest, [...S, ScoreRound<Line>]> : S;
type ScoreRounds<A extends Evaluation[][]> = ScoreRoundsRecursive<A, []>;

type ScoreBlock<S extends string> = UnarySum<ScoreRounds<ProcessLines<SplitLines<S, "", []>>>>;

// Data (note: need to process in batches of 25 lines due to recursion depth limits in TypeScript)
type t1 = ScoreBlock<"8C TS KC 9H 4S 7D 2S 5D 3S AC\n5C AD 5D AC 9C 7C 5H 8D TD KS\n3H 7H 6S KC JS QH TD JC 2D 8S\nTH 8H 5C QS TC 9H 4D JC KS JS\n7C 5H KC QH JD AS KH 4C AD 4S\n5H KS 9C 7D 9H 8D 3S 5D 5C AH\n6H 4H 5C 3H 2H 3S QH 5S 6S AS\nTD 8C 4H 7C TC KC 4C 3H 7S KS\n7C 9C 6D KD 3H 4C QS QC AC KH\nJC 6S 5H 2H 2D KD 9D 7C AS JS\nAD QH TH 9D 8H TS 6D 3S AS AC\n2H 4S 5C 5S TC KC JD 6C TS 3C\nQD AS 6H JS 2C 3D 9H KC 4H 8S\nKD 8S 9S 7C 2S 3S 6D 6S 4H KC\n3C 8C 2D 7D 4D 9S 4S QH 4H JD\n8C KC 7S TC 2D TS 8H QD AC 5C\n3D KH QD 6C 6S AD AS 8H 2H QS\n6S 8D 4C 8S 6C QH TC 6D 7D 9D\n2S 8D 8C 4C TS 9S 9D 9C AC 3D\n3C QS 2S 4H JH 3D 2D TD 8S 9H\n5H QS 8S 6D 3C 8C JD AS 7H 7D\n6H TD 9D AS JH 6C QC 9S KD JC\nAH 8S QS 4D TH AC TS 3C 3D 5C\n5S 4D JS 3D 8H 6C TS 3S AD 8C\n6D 7C 5D 5H 3S 5C JC 2H 5S 3D">;
type t2 = ScoreBlock<"5H 6H 2S KS 3D 5D JD 7H JS 8H\nKH 4H AS JS QS QC TC 6D 7C KS\n3D QS TS 2H JS 4D AS 9S JC KD\nQD 5H 4D 5D KH 7H 3D JS KD 4H\n2C 9H 6H 5C 9D 6C JC 2D TH 9S\n7D 6D AS QD JH 4D JS 7C QS 5C\n3H KH QD AD 8C 8H 3S TH 9D 5S\nAH 9S 4D 9D 8S 4H JS 3C TC 8D\n2C KS 5H QD 3S TS 9H AH AD 8S\n5C 7H 5D KD 9H 4D 3D 2D KS AD\nKS KC 9S 6D 2C QH 9D 9H TS TC\n9C 6H 5D QH 4D AD 6D QC JS KH\n9S 3H 9D JD 5C 4D 9H AS TC QH\n2C 6D JC 9C 3C AD 9S KH 9D 7D\nKC 9C 7C JC JS KD 3H AS 3C 7D\nQD KH QS 2C 3S 8S 8H 9H 9C JC\nQH 8D 3C KC 4C 4H 6D AD 9H 9D\n3S KS QS 7H KH 7D 5H 5D JD AD\n2H 2C 6H TH TC 7D 8D 4H 8C AS\n4S 2H AC QC 3S 6D TH 4D 4C KH\n4D TC KS AS 7C 3C 6D 2D 9H 6C\n8C TD 5D QS 2C 7H 4C 9C 3H 9H\n5H JH TS 7S TD 6H AD QD 8H 8S\n5S AD 9C 8C 7C 8D 5H 9D 8S 2S\n4H KH KS 9S 2S KC 5S AD 4S 7D">;
type t3 = ScoreBlock<"QS 9C QD 6H JS 5D AC 8D 2S AS\nKH AC JC 3S 9D 9S 3C 9C 5S JS\nAD 3C 3D KS 3S 5C 9C 8C TS 4S\nJH 8D 5D 6H KD QS QD 3D 6C KC\n8S JD 6C 3S 8C TC QC 3C QH JS\nKC JC 8H 2S 9H 9C JH 8S 8C 9S\n8S 2H QH 4D QC 9D KC AS TH 3C\n8S 6H TH 7C 2H 6S 3C 3H AS 7S\nQH 5S JS 4H 5H TS 8H AH AC JC\n9D 8H 2S 4S TC JC 3C 7H 3H 5C\n3D AD 3C 3S 4C QC AS 5D TH 8C\n6S 9D 4C JS KH AH TS JD 8H AD\n4C 6S 9D 7S AC 4D 3D 3S TC JD\nAD 7H 6H 4H JH KC TD TS 7D 6S\n8H JH TC 3S 8D 8C 9S 2C 5C 4D\n2C 9D KC QH TH QS JC 9C 4H TS\nQS 3C QD 8H KH 4H 8D TD 8S AC\n7C 3C TH 5S 8H 8C 9C JD TC KD\nQC TC JD TS 8C 3H 6H KD 7C TD\nJH QS KS 9C 6D 6S AS 9H KH 6H\n2H 4D AH 2D JH 6H TD 5D 4H JD\nKD 8C 9S JH QD JS 2C QS 5C 7C\n4S TC 7H 8D 2S 6H 7S 9C 7C KC\n8C 5D 7H 4S TD QC 8S JS 4H KS\nAD 8S JH 6D TD KD 7C 6C 2D 7D">;
type t4 = ScoreBlock<"JC 6H 6S JS 4H QH 9H AH 4C 3C\n6H 5H AS 7C 7S 3D KH KC 5D 5C\nJC 3D TD AS 4D 6D 6S QH JD KS\n8C 7S 8S QH 2S JD 5C 7H AH QD\n8S 3C 6H 6C 2C 8D TD 7D 4C 4D\n5D QH KH 7C 2S 7H JS 6D QC QD\nAD 6C 6S 7D TH 6H 2H 8H KH 4H\nKS JS KD 5D 2D KH 7D 9C 8C 3D\n9C 6D QD 3C KS 3S 7S AH JD 2D\nAH QH AS JC 8S 8H 4C KC TH 7D\nJC 5H TD 7C 5D KD 4C AD 8H JS\nKC 2H AC AH 7D JH KH 5D 7S 6D\n9S 5S 9C 6H 8S TD JD 9H 6C AC\n7D 8S 6D TS KD 7H AC 5S 7C 5D\nAH QC JC 4C TC 8C 2H TS 2C 7D\nKD KC 6S 3D 7D 2S 8S 3H 5S 5C\n8S 5D 8H 4C 6H KC 3H 7C 5S KD\nJH 8C 3D 3C 6C KC TD 7H 7C 4C\nJC KC 6H TS QS TD KS 8H 8C 9S\n6C 5S 9C QH 7D AH KS KC 9S 2C\n4D 4S 8H TD 9C 3S 7D 9D AS TH\n6S 7D 3C 6H 5D KD 2C 5C 9D 9C\n2H KC 3D AD 3H QD QS 8D JC 4S\n8C 3H 9C 7C AD 5D JC 9D JS AS\n5D 9H 5C 7H 6S 6C QC JC QD 9S">;
type t5 = ScoreBlock<"JC QS JH 2C 6S 9C QC 3D 4S TC\n4H 5S 8D 3D 4D 2S KC 2H JS 2C\nTD 3S TH KD 4D 7H JH JS KS AC\n7S 8C 9S 2D 8S 7D 5C AD 9D AS\n8C 7H 2S 6C TH 3H 4C 3S 8H AC\nKD 5H JC 8H JD 2D 4H TD JH 5C\n3D AS QH KS 7H JD 8S 5S 6D 5H\n9S 6S TC QS JC 5C 5D 9C TH 8C\n5H 3S JH 9H 2S 2C 6S 7S AS KS\n8C QD JC QS TC QC 4H AC KH 6C\nTC 5H 7D JH 4H 2H 8D JC KS 4D\n5S 9C KH KD 9H 5C TS 3D 7D 2D\n5H AS TC 4D 8C 2C TS 9D 3H 8D\n6H 8D 2D 9H JD 6C 4S 5H 5S 6D\nAD 9C JC 7D 6H 9S 6D JS 9H 3C\nAD JH TC QS 4C 5D 9S 7C 9C AH\nKD 6H 2H TH 8S QD KS 9D 9H AS\n4H 8H 8D 5H 6C AH 5S AS AD 8S\nQS 5D 4S 2H TD KS 5H AC 3H JC\n9C 7D QD KD AC 6D 5H QH 6H 5S\nKC AH QH 2H 7D QS 3H KS 7S JD\n6C 8S 3H 6D KS QD 5D 5C 8H TC\n9H 4D 4S 6S 9D KH QC 4H 6C JD\nTD 2D QH 4S 6H JH KD 3C QD 8C\n4S 6H 7C QD 9D AS AH 6S AD 3C">;
type t6 = ScoreBlock<"2C KC TH 6H 8D AH 5C 6D 8S 5D\nTD TS 7C AD JC QD 9H 3C KC 7H\n5D 4D 5S 8H 4H 7D 3H JD KD 2D\nJH TD 6H QS 4S KD 5C 8S 7D 8H\nAC 3D AS 8C TD 7H KH 5D 6C JD\n9D KS 7C 6D QH TC JD KD AS KC\nJH 8S 5S 7S 7D AS 2D 3D AD 2H\n2H 5D AS 3C QD KC 6H 9H 9S 2C\n9D 5D TH 4C JH 3H 8D TC 8H 9H\n6H KD 2C TD 2H 6C 9D 2D JS 8C\nKD 7S 3C 7C AS QH TS AD 8C 2S\nQS 8H 6C JS 4C 9S QC AD TD TS\n2H 7C TS TC 8C 3C 9H 2D 6D JC\nTC 2H 8D JH KS 6D 3H TD TH 8H\n9D TD 9H QC 5D 6C 8H 8C KC TS\n2H 8C 3D AH 4D TH TC 7D 8H KC\nTS 5C 2D 8C 6S KH AH 5H 6H KC\n5S 5D AH TC 4C JD 8D 6H 8C 6C\nKC QD 3D 8H 2D JC 9H 4H AD 2S\nTD 6S 7D JS KD 4H QS 2S 3S 8C\n4C 9H JH TS 3S 4H QC 5S 9S 9C\n2C KD 9H JS 9S 3H JC TS 5D AC\nAS 2H 5D AD 5H JC 7S TD JS 4C\n2D 4S 8H 3D 7D 2C AD KD 9C TS\n7H QD JH 5H JS AC 3D TH 4C 8H">;
type t7 = ScoreBlock<"6D KH KC QD 5C AD 7C 2D 4H AC\n3D 9D TC 8S QD 2C JC 4H JD AH\n6C TD 5S TC 8S AH 2C 5D AS AC\nTH 7S 3D AS 6C 4C 7H 7D 4H AH\n5C 2H KS 6H 7S 4H 5H 3D 3C 7H\n3C 9S AC 7S QH 2H 3D 6S 3S 3H\n2D 3H AS 2C 6H TC JS 6S 9C 6C\nQH KD QD 6D AC 6H KH 2C TS 8C\n8H 7D 3S 9H 5D 3H 4S QC 9S 5H\n2D 9D 7H 6H 3C 8S 5H 4D 3S 4S\nKD 9S 4S TC 7S QC 3S 8S 2H 7H\nTC 3D 8C 3H 6C 2H 6H KS KD 4D\nKC 3D 9S 3H JS 4S 8H 2D 6C 8S\n6H QS 6C TC QD 9H 7D 7C 5H 4D\nTD 9D 8D 6S 6C TC 5D TS JS 8H\n4H KC JD 9H TC 2C 6S 5H 8H AS\nJS 9C 5C 6S 9D JD 8H KC 4C 6D\n4D 8D 8S 6C 7C 6H 7H 8H 5C KC\nTC 3D JC 6D KS 9S 6H 7S 9C 2C\n6C 3S KD 5H TS 7D 9H 9S 6H KH\n3D QD 4C 6H TS AC 3S 5C 2H KD\n4C AS JS 9S 7C TS 7H 9H JC KS\n4H 8C JD 3H 6H AD 9S 4S 5S KS\n4C 2C 7D 3D AS 9C 2S QS KC 6C\n8S 5H 3D 2S AC 9D 6S 3S 4D TD">;
type t8 = ScoreBlock<"QD TH 7S TS 3D AC 7H 6C 5D QC\nTC QD AD 9C QS 5C 8D KD 3D 3C\n9D 8H AS 3S 7C 8S JD 2D 8D KC\n4C TH AC QH JS 8D 7D 7S 9C KH\n9D 8D 4C JH 2C 2S QD KD TS 4H\n4D 6D 5D 2D JH 3S 8S 3H TC KH\nAD 4D 2C QS 8C KD JH JD AH 5C\n5C 6C 5H 2H JH 4H KS 7C TC 3H\n3C 4C QC 5D JH 9C QD KH 8D TC\n3H 9C JS 7H QH AS 7C 9H 5H JC\n2D 5S QD 4S 3C KC 6S 6C 5C 4C\n5D KH 2D TS 8S 9C AS 9S 7C 4C\n7C AH 8C 8D 5S KD QH QS JH 2C\n8C 9D AH 2H AC QC 5S 8H 7H 2C\nQD 9H 5S QS QC 9C 5H JC TH 4H\n6C 6S 3H 5H 3S 6H KS 8D AC 7S\nAC QH 7H 8C 4S KC 6C 3D 3S TC\n9D 3D JS TH AC 5H 3H 8S 3S TC\nQD KH JS KS 9S QC 8D AH 3C AC\n5H 6C KH 3S 9S JH 2D QD AS 8C\n6C 4D 7S 7H 5S JC 6S 9H 4H JH\nAH 5S 6H 9S AD 3S TH 2H 9D 8C\n4C 8D 9H 7C QC AD 4S 9C KC 5S\n9D 6H 4D TC 4C JH 2S 5D 3S AS\n2H 6C 7C KH 5C AD QS TH JD 8S">;
type t9 = ScoreBlock<"3S 4S 7S AH AS KC JS 2S AD TH\nJS KC 2S 7D 8C 5C 9C TS 5H 9D\n7S 9S 4D TD JH JS KH 6H 5D 2C\nJD JS JC TH 2D 3D QD 8C AC 5H\n7S KH 5S 9D 5D TD 4S 6H 3C 2D\n4S 5D AC 8D 4D 7C AD AS AH 9C\n6S TH TS KS 2C QC AH AS 3C 4S\n2H 8C 3S JC 5C 7C 3H 3C KH JH\n7S 3H JC 5S 6H 4C 2S 4D KC 7H\n4D 7C 4H 9S 8S 6S AD TC 6C JC\nKH QS 3S TC 4C 8H 8S AC 3C TS\nQD QS TH 3C TS 7H 7D AH TD JC\nTD JD QC 4D 9S 7S TS AD 7D AC\nAH 7H 4S 6D 7C 2H 9D KS JC TD\n7C AH JD 4H 6D QS TS 2H 2C 5C\nTC KC 8C 9S 4C JS 3C JC 6S AH\nAS 7D QC 3D 5S JC JD 9D TD KH\nTH 3C 2S 6H AH AC 5H 5C 7S 8H\nQC 2D AC QD 2S 3S JD QS 6S 8H\nKC 4H 3C 9D JS 6H 3S 8S AS 8C\n7H KC 7D JD 2H JC QH 5S 3H QS\n9H TD 3S 8H 7S AC 5C 6C AH 7C\n8D 9H AH JD TD QS 7D 3S 9C 8S\nAH QH 3C JD KC 4S 5S 5D TD KS\n9H 7H 6S JH TH 4C 7C AD 5C 2D">;
type t10 = ScoreBlock<"7C KD 5S TC 9D 6S 6C 5D 2S TH\nKC 9H 8D 5H 7H 4H QC 3D 7C AS\n6S 8S QC TD 4S 5C TH QS QD 2S\n8S 5H TH QC 9H 6S KC 7D 7C 5C\n7H KD AH 4D KH 5C 4S 2D KC QH\n6S 2C TD JC AS 4D 6C 8C 4H 5S\nJC TC JD 5S 6S 8D AS 9D AD 3S\n6D 6H 5D 5S TC 3D 7D QS 9D QD\n4S 6C 8S 3S 7S AD KS 2D 7D 7C\nKC QH JC AC QD 5D 8D QS 7H 7D\nJS AH 8S 5H 3D TD 3H 4S 6C JH\n4S QS 7D AS 9H JS KS 6D TC 5C\n2D 5C 6H TC 4D QH 3D 9H 8S 6C\n6D 7H TC TH 5S JD 5C 9C KS KD\n8D TD QH 6S 4S 6C 8S KC 5C TC\n5S 3D KS AC 4S 7D QD 4C TH 2S\nTS 8H 9S 6S 7S QH 3C AH 7H 8C\n4C 8C TS JS QC 3D 7D 5D 7S JH\n8S 7S 9D QC AC 7C 6D 2H JH KC\nJS KD 3C 6S 4S 7C AH QC KS 5H\nKS 6S 4H JD QS TC 8H KC 6H AS\nKH 7C TC 6S TD JC 5C 7D AH 3S\n3H 4C 4H TC TH 6S 7H 6D 9C QH\n7D 5H 4S 8C JS 4D 3D 8S QH KC\n3H 6S AD 7H 3S QC 8S 4S 7S JS">;
type t11 = ScoreBlock<"3S JD KH TH 6H QS 9C 6C 2D QD\n4S QH 4D 5H KC 7D 6D 8D TH 5S\nTD AD 6S 7H KD KH 9H 5S KC JC\n3H QC AS TS 4S QD KS 9C 7S KC\nTS 6S QC 6C TH TC 9D 5C 5D KD\nJS 3S 4H KD 4C QD 6D 9S JC 9D\n8S JS 6D 4H JH 6H 6S 6C KS KH\nAC 7D 5D TC 9S KH 6S QD 6H AS\nAS 7H 6D QH 8D TH 2S KH 5C 5H\n4C 7C 3D QC TC 4S KH 8C 2D JS\n6H 5D 7S 5H 9C 9H JH 8S TH 7H\nAS JS 2S QD KH 8H 4S AC 8D 8S\n3H 4C TD KD 8C JC 5C QS 2D JD\nTS 7D 5D 6C 2C QS 2H 3C AH KS\n4S 7C 9C 7D JH 6C 5C 8H 9D QD\n2S TD 7S 6D 9C 9S QS KH QH 5C\nJC 6S 9C QH JH 8D 7S JS KH 2H\n8D 5H TH KC 4D 4S 3S 6S 3D QS\n2D JD 4C TD 7C 6D TH 7S JC AH\nQS 7S 4C TH 9D TS AD 4D 3H 6H\n2D 3H 7D JD 3D AS 2S 9C QC 8S\n4H 9H 9C 2C 7S JH KD 5C 5D 6H\nTC 9H 8H JC 3C 9S 8D KS AD KC\nTS 5H JD QS QH QC 8D 5D KH AH\n5D AS 8S 6S 4C AH QC QD TH 7H">;
type t12 = ScoreBlock<"3H 4H 7D 6S 4S 9H AS 8H JS 9D\nJD 8C 2C 9D 7D 5H 5S 9S JC KD\nKD 9C 4S QD AH 7C AD 9D AC TD\n6S 4H 4S 9C 8D KS TC 9D JH 7C\n5S JC 5H 4S QH AC 2C JS 2S 9S\n8C 5H AS QD AD 5C 7D 8S QC TD\nJC 4C 8D 5C KH QS 4D 6H 2H 2C\nTH 4S 2D KC 3H QD AC 7H AD 9D\nKH QD AS 8H TH KC 8D 7S QH 8C\nJC 6C 7D 8C KH AD QS 2H 6S 2D\nJC KH 2D 7D JS QC 5H 4C 5D AD\nTS 3S AD 4S TD 2D TH 6S 9H JH\n9H 2D QS 2C 4S 3D KH AS AC 9D\nKH 6S 8H 4S KD 7D 9D TS QD QC\nJH 5H AH KS AS AD JC QC 5S KH\n5D 7D 6D KS KD 3D 7C 4D JD 3S\nAC JS 8D 5H 9C 3H 4H 4D TS 2C\n6H KS KH 9D 7C 2S 6S 8S 2H 3D\n6H AC JS 7S 3S TD 8H 3H 4H TH\n9H TC QC KC 5C KS 6H 4H AC 8S\nTC 7D QH 4S JC TS 6D 6C AC KH\nQH 7D 7C JH QS QD TH 3H 5D KS\n3D 5S 8D JS 4C 2C KS 7H 9C 4H\n5H 8S 4H TD 2C 3S QD QC 3H KC\nQC JS KD 9C AD 5S 9D 7D 7H TS">;
type t13 = ScoreBlock<"8C JC KH 7C 7S 6C TS 2C QD TH\n5S 9D TH 3C 7S QH 8S 9C 2H 5H\n5D 9H 6H 2S JS KH 3H 7C 2H 5S\nJD 5D 5S 2C TC 2S 6S 6C 3C 8S\n4D KH 8H 4H 2D KS 3H 5C 2S 9H\n3S 2D TD 7H 8S 6H JD KC 9C 8D\n6S QD JH 7C 9H 5H 8S 8H TH TD\nQS 7S TD 7D TS JC KD 7C 3C 2C\n3C JD 8S 4H 2D 2S TD AS 4D AC\nAH KS 6C 4C 4S 7D 8C 9H 6H AS\n5S 3C 9S 2C QS KD 4D 4S AC 5D\n2D TS 2C JS KH QH 5D 8C AS KC\nKD 3H 6C TH 8S 7S KH 6H 9S AC\n6H 7S 6C QS AH 2S 2H 4H 5D 5H\n5H JC QD 2C 2S JD AS QC 6S 7D\n6C TC AS KD 8H 9D 2C 7D JH 9S\n2H 4C 6C AH 8S TD 3H TH 7C TS\nKD 4S TS 6C QH 8D 9D 9C AH 7D\n6D JS 5C QD QC 9C 5D 8C 2H KD\n3C QH JH AD 6S AH KC 8S 6D 6H\n3D 7C 4C 7S 5S 3S 6S 5H JC 3C\nQH 7C 5H 3C 3S 8C TS 4C KD 9C\nQD 3S 7S 5H 7H QH JC 7C 8C KD\n3C KD KH 2S 4C TS AC 6S 2C 7C\n2C KH 3C 4C 6H 4D 5H 5S 7S QD">;
type t14 = ScoreBlock<"4D 7C 8S QD TS 9D KS 6H KD 3C\nQS 4D TS 7S 4C 3H QD 8D 9S TC\nTS QH AC 6S 3C 9H 9D QS 8S 6H\n3S 7S 5D 4S JS 2D 6C QH 6S TH\n4C 4H AS JS 5D 3D TS 9C AC 8S\n6S 9C 7C 3S 5C QS AD AS 6H 3C\n9S 8C 7H 3H 6S 7C AS 9H JD KH\n3D 3H 7S 4D 6C 7C AC 2H 9C TH\n4H 5S 3H AC TC TH 9C 9H 9S 8D\n8D 9H 5H 4D 6C 2H QD 6S 5D 3S\n4C 5C JD QS 4D 3H TH AC QH 8C\nQC 5S 3C 7H AD 4C KS 4H JD 6D\nQS AH 3H KS 9H 2S JS JH 5H 2H\n2H 5S TH 6S TS 3S KS 3C 5H JS\n2D 9S 7H 3D KC JH 6D 7D JS TD\nAC JS 8H 2C 8C JH JC 2D TH 7S\n5D 9S 8H 2H 3D TC AH JC KD 9C\n9D QD JC 2H 6D KH TS 9S QH TH\n2C 8D 4S JD 5H 3H TH TC 9C KC\nAS 3D 9H 7D 4D TH KH 2H 7S 3H\n4H 7S KS 2S JS TS 8S 2H QD 8D\n5S 6H JH KS 8H 2S QC AC 6S 3S\nJC AS AD QS 8H 6C KH 4C 4D QD\n2S 3D TS TD 9S KS 6S QS 5C 8D\n3C 6D 4S QC KC JH QD TH KH AD">;
type t15 = ScoreBlock<"9H AH 4D KS 2S 8D JH JC 7C QS\n2D 6C TH 3C 8H QD QH 2S 3S KS\n6H 5D 9S 4C TS TD JS QD 9D JD\n5H 8H KH 8S KS 7C TD AD 4S KD\n2C 7C JC 5S AS 6C 7D 8S 5H 9C\n6S QD 9S TS KH QS 5S QH 3C KC\n7D 3H 3C KD 5C AS JH 7H 6H JD\n9D 5C 9H KC 8H KS 4S AD 4D 2S\n3S JD QD 8D 2S 7C 5S 6S 5H TS\n6D 9S KC TD 3S 6H QD JD 5C 8D\n5H 9D TS KD 8D 6H TD QC 4C 7D\n6D 4S JD 9D AH 9S AS TD 9H QD\n2D 5S 2H 9C 6H 9S TD QC 7D TC\n3S 2H KS TS 2C 9C 8S JS 9D 7D\n3C KC 6D 5D 6C 6H 8S AS 7S QS\nJH 9S 2H 8D 4C 8H 9H AD TH KH\nQC AS 2S JS 5C 6H KD 3H 7H 2C\nQD 8H 2S 8D 3S 6D AH 2C TC 5C\nJD JS TS 8S 3H 5D TD KC JC 6H\n6S QS TC 3H 5D AH JC 7C 7D 4H\n7C 5D 8H 9C 2H 9H JH KH 5S 2C\n9C 7H 6S TH 3S QC QD 4C AC JD\n2H 5D 9S 7D KC 3S QS 2D AS KH\n2S 4S 2H 7D 5C TD TH QH 9S 4D\n6D 3S TS 6H 4H KS 9D 8H 5S 2D">;
type t16 = ScoreBlock<"9H KS 4H 3S 5C 5D KH 6H 6S JS\nKC AS 8C 4C JC KH QC TH QD AH\n6S KH 9S 2C 5H TC 3C 7H JC 4D\nJD 4S 6S 5S 8D 7H 7S 4D 4C 2H\n7H 9H 5D KH 9C 7C TS TC 7S 5H\n4C 8D QC TS 4S 9H 3D AD JS 7C\n8C QS 5C 5D 3H JS AH KC 4S 9D\nTS JD 8S QS TH JH KH 2D QD JS\nJD QC 5D 6S 9H 3S 2C 8H 9S TS\n2S 4C AD 7H JC 5C 2D 6D 4H 3D\n7S JS 2C 4H 8C AD QD 9C 3S TD\nJD TS 4C 6H 9H 7D QD 6D 3C AS\nAS 7C 4C 6S 5D 5S 5C JS QC 4S\nKD 6S 9S 7C 3C 5S 7D JH QD JS\n4S 7S JH 2C 8S 5D 7H 3D QH AD\nTD 6H 2H 8D 4H 2D 7C AD KH 5D\nTS 3S 5H 2C QD AH 2S 5C KH TD\nKC 4D 8C 5D AS 6C 2H 2S 9H 7C\nKD JS QC TS QS KH JH 2C 5D AD\n3S 5H KC 6C 9H 3H 2H AD 7D 7S\n7S JS JH KD 8S 7D 2S 9H 7C 2H\n9H 2D 8D QC 6S AD AS 8H 5H 6C\n2S 7H 6C 6D 7D 8C 5D 9D JC 3C\n7C 9C 7H JD 2H KD 3S KH AD 4S\nQH AS 9H 4D JD KS KD TS KH 5H">;
type t17 = ScoreBlock<"4C 8H 5S 3S 3D 7D TD AD 7S KC\nJS 8S 5S JC 8H TH 9C 4D 5D KC\n7C 5S 9C QD 2C QH JS 5H 8D KH\nTD 2S KS 3D AD KC 7S TC 3C 5D\n4C 2S AD QS 6C 9S QD TH QH 5C\n8C AD QS 2D 2S KC JD KS 6C JC\n8D 4D JS 2H 5D QD 7S 7D QH TS\n6S 7H 3S 8C 8S 9D QS 8H 6C 9S\n4S TC 2S 5C QD 4D QS 6D TH 6S\n3S 5C 9D 6H 8D 4C 7D TC 7C TD\nAH 6S AS 7H 5S KD 3H 5H AC 4C\n8D 8S AH KS QS 2C AD 6H 7D 5D\n6H 9H 9S 2H QS 8S 9C 5D 2D KD\nTS QC 5S JH 7D 7S TH 9S 9H AC\n7H 3H 6S KC 4D 6D 5C 4S QD TS\nTD 2S 7C QD 3H JH 9D 4H 7S 7H\nKS 3D 4H 5H TC 2S AS 2D 6D 7D\n8H 3C 7H TD 3H AD KC TH 9C KH\nTC 4C 2C 9S 9D 9C 5C 2H JD 3C\n3H AC TS 5D AD 8D 6H QC 6S 8C\n2S TS 3S JD 7H 8S QH 4C 5S 8D\nAC 4S 6C 3C KH 3D 7C 2D 8S 2H\n4H 6C 8S TH 2H 4S 8H 9S 3H 7S\n7C 4C 9C 2C 5C AS 5D KD 4D QH\n9H 4H TS AS 7D 8D 5D 9S 8C 2H">;
type t18 = ScoreBlock<"QC KD AC AD 2H 7S AS 3S 2D 9S\n2H QC 8H TC 6D QD QS 5D KH 3C\nTH JD QS 4C 2S 5S AD 7H 3S AS\n7H JS 3D 6C 3S 6D AS 9S AC QS\n9C TS AS 8C TC 8S 6H 9D 8D 6C\n4D JD 9C KC 7C 6D KS 3S 8C AS\n3H 6S TC 8D TS 3S KC 9S 7C AS\n8C QC 4H 4S 8S 6C 3S TC AH AC\n4D 7D 5C AS 2H 6S TS QC AD TC\nQD QC 8S 4S TH 3D AH TS JH 4H\n5C 2D 9S 2C 3H 3C 9D QD QH 7D\nKC 9H 6C KD 7S 3C 4D AS TC 2D\n3D JS 4D 9D KS 7D TH QC 3H 3C\n8D 5S 2H 9D 3H 8C 4C 4H 3C TH\nJC TH 4S 6S JD 2D 4D 6C 3D 4C\nTS 3S 2D 4H AC 2C 6S 2H JH 6H\nTD 8S AD TC AH AC JH 9S 6S 7S\n6C KC 4S JD 8D 9H 5S 7H QH AH\nKD 8D TS JH 5C 5H 3H AD AS JS\n2D 4H 3D 6C 8C 7S AD 5D 5C 8S\nTD 5D 7S 9C 4S 5H 6C 8C 4C 8S\nJS QH 9C AS 5C QS JC 3D QC 7C\nJC 9C KH JH QS QC 2C TS 3D AD\n5D JH AC 5C 9S TS 4C JD 8C KS\nKC AS 2D KH 9H 2C 5S 4D 3D 6H">;
type t19 = ScoreBlock<"TH AH 2D 8S JC 3D 8C QH 7S 3S\n8H QD 4H JC AS KH KS 3C 9S 6D\n9S QH 7D 9C 4S AC 7H KH 4D KD\nAH AD TH 6D 9C 9S KD KS QH 4H\nQD 6H 9C 7C QS 6D 6S 9D 5S JH\nAH 8D 5H QD 2H JC KS 4H KH 5S\n5C 2S JS 8D 9C 8C 3D AS KC AH\nJD 9S 2H QS 8H 5S 8C TH 5C 4C\nQC QS 8C 2S 2C 3S 9C 4C KS KH\n2D 5D 8S AH AD TD 2C JS KS 8C\nTC 5S 5H 8H QC 9H 6H JD 4H 9S\n3C JH 4H 9H AH 4S 2H 4C 8D AC\n8S TH 4D 7D 6D QD QS 7S TC 7C\nKH 6D 2D JD 5H JS QD JH 4H 4S\n9C 7S JH 4S 3S TS QC 8C TC 4H\nQH 9D 4D JH QS 3S 2C 7C 6C 2D\n4H 9S JD 5C 5H AH 9D TS 2D 4C\nKS JH TS 5D 2D AH JS 7H AS 8D\nJS AH 8C AD KS 5S 8H 2C 6C TH\n2H 5D AD AC KS 3D 8H TS 6H QC\n6D 4H TS 9C 5H JS JH 6S JD 4C\nJH QH 4H 2C 6D 3C 5D 4C QS KC\n6H 4H 6C 7H 6S 2S 8S KH QC 8C\n3H 3D 5D KS 4H TD AD 3S 4D TS\n5S 7C 8S 7D 2C KS 7S 6C 8C JS">;
type t20 = ScoreBlock<"5D 2H 3S 7C 5C QD 5H 6D 9C 9H\nJS 2S KD 9S 8D TD TS AC 8C 9D\n5H QD 2S AC 8C 9H KS 7C 4S 3C\nKH AS 3H 8S 9C JS QS 4S AD 4D\nAS 2S TD AD 4D 9H JC 4C 5H QS\n5D 7C 4H TC 2D 6C JS 4S KC 3S\n4C 2C 5D AC 9H 3D JD 8S QS QH\n2C 8S 6H 3C QH 6D TC KD AC AH\nQC 6C 3S QS 4S AC 8D 5C AD KH\n5S 4C AC KH AS QC 2C 5C 8D 9C\n8H JD 3C KH 8D 5C 9C QD QH 9D\n7H TS 2C 8C 4S TD JC 9C 5H QH\nJS 4S 2C 7C TH 6C AS KS 7S JD\nJH 7C 9H 7H TC 5H 3D 6D 5D 4D\n2C QD JH 2H 9D 5S 3D TD AD KS\nJD QH 3S 4D TH 7D 6S QS KS 4H\nTC KS 5S 8D 8H AD 2S 2D 4C JH\n5S JH TC 3S 2D QS 9D 4C KD 9S\nAC KH 3H AS 9D KC 9H QD 6C 6S\n9H 7S 3D 5C 7D KC TD 8H 4H 6S\n3C 7H 8H TC QD 4D 7S 6S QH 6C\n6D AD 4C QD 6C 5D 7D 9D KS TS\nJH 2H JD 9S 7S TS KH 8D 5D 8H\n2D 9S 4C 7D 9D 5H QD 6D AC 6S\n7S 6D JC QD JH 4C 6S QS 2H 7D">;
type t21 = ScoreBlock<"8C TD JH KD 2H 5C QS 2C JS 7S\nTC 5H 4H JH QD 3S 5S 5D 8S KH\nKS KH 7C 2C 5D JH 6S 9C 6D JC\n5H AH JD 9C JS KC 2H 6H 4D 5S\nAS 3C TH QC 6H 9C 8S 8C TD 7C\nKC 2C QD 9C KH 4D 7S 3C TS 9H\n9C QC 2S TS 8C TD 9S QD 3S 3C\n4D 9D TH JH AH 6S 2S JD QH JS\nQD 9H 6C KD 7D 7H 5D 6S 8H AH\n8H 3C 4S 2H 5H QS QH 7S 4H AC\nQS 3C 7S 9S 4H 3S AH KS 9D 7C\nAD 5S 6S 2H 2D 5H TC 4S 3C 8C\nQH TS 6S 4D JS KS JH AS 8S 6D\n2C 8S 2S TD 5H AS TC TS 6C KC\nKC TS 8H 2H 3H 7C 4C 5S TH TD\nKD AD KH 7H 7S 5D 5H 5S 2D 9C\nAD 9S 3D 7S 8C QC 7C 9C KD KS\n3C QC 9S 8C 4D 5C AS QD 6C 2C\n2H KC 8S JD 7S AC 8D 5C 2S 4D\n9D QH 3D 2S TC 3S KS 3C 9H TD\nKD 6S AC 2C 7H 5H 3S 6C 6H 8C\nQH TC 8S 6S KH TH 4H 5D TS 4D\n8C JS 4H 6H 2C 2H 7D AC QD 3D\nQS KC 6S 2D 5S 4H TD 3H JH 4C\n7S 5H 7H 8H KH 6H QS TH KD 7D">;
type t22 = ScoreBlock<"5H AD KD 7C KH 5S TD 6D 3C 6C\n8C 9C 5H JD 7C KC KH 7H 2H 3S\n7S 4H AD 4D 8S QS TH 3D 7H 5S\n8D TC KS KD 9S 6D AD JD 5C 2S\n7H 8H 6C QD 2H 6H 9D TC 9S 7C\n8D 6D 4C 7C 6C 3C TH KH JS JH\n5S 3S 8S JS 9H AS AD 8H 7S KD\nJH 7C 2C KC 5H AS AD 9C 9S JS\nAD AC 2C 6S QD 7C 3H TH KS KD\n9D JD 4H 8H 4C KH 7S TS 8C KC\n3S 5S 2H 7S 6H 7D KS 5C 6D AD\n5S 8C 9H QS 7H 7S 2H 6C 7D TD\nQS 5S TD AC 9D KC 3D TC 2D 4D\nTD 2H 7D JD QD 4C 7H 5D KC 3D\n4C 3H 8S KD QH 5S QC 9H TC 5H\n9C QD TH 5H TS 5C 9H AH QH 2C\n4D 6S 3C AC 6C 3D 2C 2H TD TH\nAC 9C 5D QC 4D AD 8D 6D 8C KC\nAD 3C 4H AC 8D 8H 7S 9S TD JC\n4H 9H QH JS 2D TH TD TC KD KS\n5S 6S 9S 8D TH AS KH 5H 5C 8S\nJD 2S 9S 6S 5S 8S 5D 7S 7H 9D\n5D 8C 4C 9D AD TS 2C 7D KD TC\n8S QS 4D KC 5C 8D 4S KH JD KD\nAS 5C AD QH 7D 2H 9S 7H 7C TC">;
type t23 = ScoreBlock<"2S 8S JD KH 7S 6C 6D AD 5D QC\n9H 6H 3S 8C 8H AH TC 4H JS TD\n2C TS 4D 7H 2D QC 9C 5D TH 7C\n6C 8H QC 5D TS JH 5C 5H 9H 4S\n2D QC 7H AS JS 8S 2H 4C 4H 8D\nJS 6S AC KD 3D 3C 4S 7H TH KC\nQH KH 6S QS 5S 4H 3C QD 3S 3H\n7H AS KH 8C 4H 9C 5S 3D 6S TS\n9C 7C 3H 5S QD 2C 3D AD AC 5H\nJH TD 2D 4C TS 3H KH AD 3S 7S\nAS 4C 5H 4D 6S KD JC 3C 6H 2D\n3H 6S 8C 2D TH 4S AH QH AD 5H\n7C 2S 9H 7H KC 5C 6D 5S 3H JC\n3C TC 9C 4H QD TD JH 6D 9H 5S\n7C 6S 5C 5D 6C 4S 7H 9H 6H AH\nAD 2H 7D KC 2C 4C 2S 9S 7H 3S\nTH 4C 8S 6S 3S AD KS AS JH TD\n5C TD 4S 4D AD 6S 5D TC 9C 7D\n8H 3S 4D 4S 5S 6H 5C AC 3H 3D\n9H 3C AC 4S QS 8S 9D QH 5H 4D\nJC 6C 5H TS AC 9C JD 8C 7C QD\n8S 8H 9C JD 2D QC QH 6H 3C 8D\nKS JS 2H 6H 5H QH QS 3H 7C 6D\nTC 3H 4S 7H QC 2H 3S 8C JS KH\nAH 8H 5S 4C 9H JD 3H 7S JC AC">;
type t24 = ScoreBlock<"3C 2D 4C 5S 6C 4S QS 3S JD 3D\n5H 2D TC AH KS 6D 7H AD 8C 6H\n6C 7S 3C JD 7C 8H KS KH AH 6D\nAH 7D 3H 8H 8S 7H QS 5H 9D 2D\nJD AC 4H 7S 8S 9S KS AS 9D QH\n7S 2C 8S 5S JH QS JC AH KD 4C\nAH 2S 9H 4H 8D TS TD 6H QH JD\n4H JC 3H QS 6D 7S 9C 8S 9D 8D\n5H TD 4S 9S 4C 8C 8D 7H 3H 3D\nQS KH 3S 2C 2S 3C 7S TD 4S QD\n7C TD 4D 5S KH AC AS 7H 4C 6C\n2S 5H 6D JD 9H QS 8S 2C 2H TD\n2S TS 6H 9H 7S 4H JC 4C 5D 5S\n2C 5H 7D 4H 3S QH JC JS 6D 8H\n4C QH 7C QD 3S AD TH 8S 5S TS\n9H TC 2S TD JC 7D 3S 3D TH QH\n7D 4C 8S 5C JH 8H 6S 3S KC 3H\nJC 3H KH TC QH TH 6H 2C AC 5H\nQS 2H 9D 2C AS 6S 6C 2S 8C 8S\n9H 7D QC TH 4H KD QS AC 7S 3C\n4D JH 6S 5S 8H KS 9S QC 3S AS\nJD 2D 6S 7S TC 9H KC 3H 7D KD\n2H KH 7C 4D 4S 3H JS QD 7D KC\n4C JC AS 9D 3C JS 6C 8H QD 4D\nAH JS 3S 6C 4C 3D JH 6D 9C 9H">;
type t25 = ScoreBlock<"9H 2D 8C 7H 5S KS 6H 9C 2S TC\n6C 8C AD 7H 6H 3D KH AS 5D TH\nKS 8C 3S TS 8S 4D 5S 9S 6C 4H\n9H 4S 4H 5C 7D KC 2D 2H 9D JH\n5C JS TC 9D 9H 5H 7S KH JC 6S\n7C 9H 8H 4D JC KH JD 2H TD TC\n8H 6C 2H 2C KH 6H 9D QS QH 5H\nAC 7D 2S 3D QD JC 2D 8D JD JH\n2H JC 2D 7H 2C 3C 8D KD TD 4H\n3S 4H 6D 8D TS 3H TD 3D 6H TH\nJH JC 3S AC QH 9H 7H 8S QC 2C\n7H TD QS 4S 8S 9C 2S 5D 4D 2H\n3D TS 3H 2S QC 8H 6H KC JC KS\n5D JD 7D TC 8C 6C 9S 3D 8D AC\n8H 6H JH 6C 5D 8D 8S 4H AD 2C\n9D 4H 2D 2C 3S TS AS TC 3C 5D\n4D TH 5H KS QS 6C 4S 2H 3D AD\n5C KC 6H 2C 5S 3C 4D 2D 9H 9S\nJD 4C 3H TH QH 9H 5S AH 8S AC\n7D 9S 6S 2H TD 9C 4H 8H QS 4C\n3C 6H 5D 4H 8C 9C KC 6S QD QS\n3S 9H KD TC 2D JS 8C 6S 4H 4S\n2S 4C 8S QS 6H KH 3H TH 8C 5D\n2C KH 5S 3S 7S 7H 6C 9D QD 8D\n8H KS AC 2D KH TS 6C JS KC 7H">;
type t26 = ScoreBlock<"9C KS 5C TD QC AH 6C 5H 9S 7C\n5D 4D 3H 4H 6S 7C 7S AH QD TD\n2H 7D QC 6S TC TS AH 7S 9D 3H\nTH 5H QD 9S KS 7S 7C 6H 8C TD\nTH 2D 4D QC 5C 7D JD AH 9C 4H\n4H 3H AH 8D 6H QC QH 9H 2H 2C\n2D AD 4C TS 6H 7S TH 4H QS TD\n3C KD 2H 3H QS JD TC QC 5D 8H\nKS JC QD TH 9S KD 8D 8C 2D 9C\n3C QD KD 6D 4D 8D AH AD QC 8S\n8H 3S 9D 2S 3H KS 6H 4C 7C KC\nTH 9S 5C 3D 7D 6H AC 7S 4D 2C\n5C 3D JD 4D 2D 6D 5H 9H 4C KH\nAS 7H TD 6C 2H 3D QD KS 4C 4S\nJC 3C AC 7C JD JS 8H 9S QC 5D\nJD 6S 5S 2H AS 8C 7D 5H JH 3D\n8D TC 5S 9S 8S 3H JC 5H 7S AS\n5C TD 3D 7D 4H 8D 7H 4D 5D JS\nQS 9C KS TD 2S 8S 5C 2H 4H AS\nTH 7S 4H 7D 3H JD KD 5D 2S KC\nJD 7H 4S 8H 4C JS 6H QH 5S 4H\n2C QS 8C 5S 3H QC 2S 6C QD AD\n8C 3D JD TC 4H 2H AD 5S AC 2S\n5D 2C JS 2D AD 9D 3D 4C 4S JH\n8D 5H 5D 6H 7S 4D KS 9D TD JD">;
type t27 = ScoreBlock<"3D 6D 9C 2S AS 7D 5S 5C 8H JD\n7C 8S 3S 6S 5H JD TC AD 7H 7S\n2S 9D TS 4D AC 8D 6C QD JD 3H\n9S KH 2C 3C AC 3D 5H 6H 8D 5D\nKS 3D 2D 6S AS 4C 2S 7C 7H KH\nAC 2H 3S JC 5C QH 4D 2D 5H 7S\nTS AS JD 8C 6H JC 8S 5S 2C 5D\n7S QH 7H 6C QC 8H 2D 7C JD 2S\n2C QD 2S 2H JC 9C 5D 2D JD JH\n7C 5C 9C 8S 7D 6D 8D 6C 9S JH\n2C AD 6S 5H 3S KS 7S 9D KH 4C\n7H 6C 2C 5C TH 9D 8D 3S QC AH\n5S KC 6H TC 5H 8S TH 6D 3C AH\n9C KD 4H AD TD 9S 4S 7D 6H 5D\n7H 5C 5H 6D AS 4C KD KH 4H 9D\n3C 2S 5C 6C JD QS 2H 9D 7D 3H\nAC 2S 6S 7S JS QD 5C QS 6H AD\n5H TH QC 7H TC 3S 7C 6D KC 3D\n4H 3D QC 9S 8H 2C 3S JC KS 5C\n4S 6S 2C 6H 8S 3S 3D 9H 3H JS\n4S 8C 4D 2D 8H 9H 7D 9D AH TS\n9S 2C 9H 4C 8D AS 7D 3D 6D 5S\n6S 4C 7H 8C 3H 5H JC AH 9D 9C\n2S 7C 5S JD 8C 3S 3D 4D 7D 6S\n3C KC 4S 5D 7D 3D JD 7H 3H 4H">;
type t28 = ScoreBlock<"9C 9H 4H 4D TH 6D QD 8S 9S 7S\n2H AC 8S 4S AD 8C 2C AH 7D TC\nTS 9H 3C AD KS TC 3D 8C 8H JD\nQC 8D 2C 3C 7D 7C JD 9H 9C 6C\nAH 6S JS JH 5D AS QC 2C JD TD\n9H KD 2H 5D 2D 3S 7D TC AH TS\nTD 8H AS 5D AH QC AC 6S TC 5H\nKS 4S 7H 4D 8D 9C TC 2H 6H 3H\n3H KD 4S QD QH 3D 8H 8C TD 7S\n8S JD TC AH JS QS 2D KH KS 4D\n3C AD JC KD JS KH 4S TH 9H 2C\nQC 5S JS 9S KS AS 7C QD 2S JD\nKC 5S QS 3S 2D AC 5D 9H 8H KS\n6H 9C TC AD 2C 6D 5S JD 6C 7C\nQS KH TD QD 2C 3H 8S 2S QC AH\n9D 9H JH TC QH 3C 2S JS 5C 7H\n6C 3S 3D 2S 4S QD 2D TH 5D 2C\n2D 6H 6D 2S JC QH AS 7H 4H KH\n5H 6S KS AD TC TS 7C AC 4S 4H\nAD 3C 4H QS 8C 9D KS 2H 2D 4D\n4S 9D 6C 6D 9C AC 8D 3H 7H KD\nJC AH 6C TS JD 6D AD 3S 5D QD\nJC JH JD 3S 7S 8S JS QC 3H 4S\nJD TH 5C 2C AD JS 7H 9S 2H 7S\n8D 3S JH 4D QC AS JD 2C KC 6H">;
type t29 = ScoreBlock<"2C AC 5H KD 5S 7H QD JH AH 2D\nJC QH 8D 8S TC 5H 5C AH 8C 6C\n3H JS 8S QD JH 3C 4H 6D 5C 3S\n6D 4S 4C AH 5H 5S 3H JD 7C 8D\n8H AH 2H 3H JS 3C 7D QC 4H KD\n6S 2H KD 5H 8H 2D 3C 8S 7S QD\n2S 7S KC QC AH TC QS 6D 4C 8D\n5S 9H 2C 3S QD 7S 6C 2H 7C 9D\n3C 6C 5C 5S JD JC KS 3S 5D TS\n7C KS 6S 5S 2S 2D TC 2H 5H QS\nAS 7H 6S TS 5H 9S 9D 3C KD 2H\n4S JS QS 3S 4H 7C 2S AC 6S 9D\n8C JH 2H 5H 7C 5D QH QS KH QC\n3S TD 3H 7C KC 8D 5H 8S KH 8C\n4H KH JD TS 3C 7H AS QC JS 5S\nAH 9D 2C 8D 4D 2D 6H 6C KC 6S\n2S 6H 9D 3S 7H 4D KH 8H KD 3D\n9C TC AC JH KH 4D JD 5H TD 3S\n7S 4H 9D AS 4C 7D QS 9S 2S KH\n3S 8D 8S KS 8C JC 5C KH 2H 5D\n8S QH 2C 4D KC JS QC 9D AC 6H\n8S 8C 7C JS JD 6S 4C 9C AC 4S\nQH 5D 2C 7D JC 8S 2D JS JH 4C\nJS 4C 7S TS JH KC KH 5H QD 4S\nQD 8C 8D 2D 6S TD 9D AC QH 5S">;
type t30 = ScoreBlock<"QH QC JS 3D 3C 5C 4H KH 8S 7H\n7C 2C 5S JC 8S 3H QC 5D 2H KC\n5S 8D KD 6H 4H QD QH 6D AH 3D\n7S KS 6C 2S 4D AC QS 5H TS JD\n7C 2D TC 5D QS AC JS QC 6C KC\n2C KS 4D 3H TS 8S AD 4H 7S 9S\nQD 9H QH 5H 4H 4D KH 3S JC AD\n4D AC KC 8D 6D 4C 2D KH 2C JD\n2C 9H 2D AH 3H 6D 9C 7D TC KS\n8C 3H KD 7C 5C 2S 4S 5H AS AH\nTH JD 4H KD 3H TC 5C 3S AC KH\n6D 7H AH 7S QC 6H 2D TD JD AS\nJH 5D 7H TC 9S 7D JC AS 5S KH\n2H 8C AD TH 6H QD KD 9H 6S 6C\nQH KC 9D 4D 3S JS JH 4H 2C 9H\nTC 7H KH 4H JC 7D 9S 3H QS 7S\nAD 7D JH 6C 7H 4H 3S 3H 4D QH\nJD 2H 5C AS 6C QC 4D 3C TC JH\nAC JD 3H 6H 4C JC AD 7D 7H 9H\n4H TC TS 2C 8C 6S KS 2H JD 9S\n4C 3H QS QC 9S 9H 6D KC 9D 9C\n5C AD 8C 2C QH TH QD JC 8D 8H\nQC 2C 2S QD 9C 4D 3S 8D JH QS\n9D 3S 2C 7S 7C JC TD 3C TC 9H\n3C TS 8H 5C 4C 2C 6S 8D 7C 4H">;
type t31 = ScoreBlock<"KS 7H 2H TC 4H 2C 3S AS AH QS\n8C 2D 2H 2C 4S 4C 6S 7D 5S 3S\nTH QC 5D TD 3C QS KD KC KS AS\n4D AH KD 9H KS 5C 4C 6H JC 7S\nKC 4H 5C QS TC 2H JC 9S AH QH\n4S 9H 3H 5H 3C QD 2H QC JH 8H\n5D AS 7H 2C 3D JH 6H 4C 6S 7D\n9C JD 9H AH JS 8S QH 3H KS 8H\n3S AC QC TS 4D AD 3D AH 8S 9H\n7H 3H QS 9C 9S 5H JH JS AH AC\n8D 3C JD 2H AC 9C 7H 5S 4D 8H\n7C JH 9H 6C JS 9S 7H 8C 9D 4H\n2D AS 9S 6H 4D JS JH 9H AD QD\n6H 7S JH KH AH 7H TD 5S 6S 2C\n8H JH 6S 5H 5S 9D TC 4C QC 9S\n7D 2C KD 3H 5H AS QD 7H JS 4D\nTS QH 6C 8H TH 5H 3C 3H 9C 9D\nAD KH JS 5D 3H AS AC 9S 5C KC\n2C KH 8C JC QS 6D AH 2D KC TC\n9D 3H 2S 7C 4D 6D KH KS 8D 7D\n9H 2S TC JH AC QC 3H 5S 3S 8H\n3S AS KD 8H 4C 3H 7C JH QH TS\n7S 6D 7H 9D JH 4C 3D 3S 6C AS\n4S 2H 2C 4C 8S 5H KC 8C QC QD\n3H 3S 6C QS QC 2D 6S 5D 2C 9D">;
type t32 = ScoreBlock<"2H 8D JH 2S 3H 2D 6C 5C 7S AD\n9H JS 5D QH 8S TS 2H 7S 6S AD\n6D QC 9S 7H 5H 5C 7D KC JD 4H\nQC 5S 9H 9C 4D 6S KS 2S 4C 7C\n9H 7C 4H 8D 3S 6H 5C 8H JS 7S\n2D 6H JS TD 4H 4D JC TH 5H KC\nAC 7C 8D TH 3H 9S 2D 4C KC 4D\nKD QS 9C 7S 3D KS AD TS 4C 4H\nQH 9C 8H 2S 7D KS 7H 5D KD 4C\n9C 2S 2H JC 6S 6C TC QC JH 5C\n7S AC 8H KC 8S 6H QS JC 3D 6S\nJS 2D JH 8C 4S 6H 8H 6D 5D AD\n6H 7D 2S 4H 9H 7C AS AC 8H 5S\n3C JS 4S 6D 5H 2S QH 6S 9C 2C\n3D 5S 6S 9S 4C QS 8D QD 8S TC\n9C 3D AH 9H 5S 2C 7D AD JC 3S\n7H TC AS 3C 6S 6D 7S KH KC 9H\n3S TC 8H 6S 5H JH 8C 7D AC 2S\nQD 9D 9C 3S JC 8C KS 8H 5D 4D\nJS AH JD 6D 9D 8C 9H 9S 8H 3H\n2D 6S 4C 4D 8S AD 4S TC AH 9H\nTS AC QC TH KC 6D 4H 7S 8C 2H\n3C QD JS 9D 5S JC AH 2H TS 9H\n3H 4D QH 5D 9C 5H 7D 4S JC 3S\n8S TH 3H 7C 2H JD JS TS AC 8D">;
type t33 = ScoreBlock<"9C 2H TD KC JD 2S 8C 5S AD 2C\n3D KD 7C 5H 4D QH QD TC 6H 7D\n7H 2C KC 5S KD 6H AH QC 7S QH\n6H 5C AC 5H 2C 9C 2D 7C TD 2S\n4D 9D AH 3D 7C JD 4H 8C 4C KS\nTH 3C JS QH 8H 4C AS 3D QS QC\n4D 7S 5H JH 6D 7D 6H JS KH 3C\nQD 8S 7D 2H 2C 7C JC 2S 5H 8C\nQH 8S 9D TC 2H AD 7C 8D QD 6S\n3S 7C AD 9H 2H 9S JD TS 4C 2D\n3S AS 4H QC 2C 8H 8S 7S TD TC\nJH TH TD 3S 4D 4H 5S 5D QS 2C\n8C QD QH TC 6D 4S 9S 9D 4H QC\n8C JS 9D 6H JD 3H AD 6S TD QC\nKC 8S 3D 7C TD 7D 8D 9H 4S 3S\n6C 4S 3D 9D KD TC KC KS AC 5S\n7C 6S QH 3D JS KD 6H 6D 2D 8C\nJD 2S 5S 4H 8S AC 2D 6S TS 5C\n5H 8C 5S 3C 4S 3D 7C 8D AS 3H\nAS TS 7C 3H AD 7D JC QS 6C 6H\n3S 9S 4C AC QH 5H 5D 9H TS 4H\n6C 5C 7H 7S TD AD JD 5S 2H 2S\n7D 6C KC 3S JD 8D 8S TS QS KH\n8S QS 8D 6C TH AC AH 2C 8H 9S\n7H TD KH QH 8S 3D 4D AH JD AS">;
type t34 = ScoreBlock<"TS 3D 2H JC 2S JH KH 6C QC JS\nKC TH 2D 6H 7S 2S TC 8C 9D QS\n3C 9D 6S KH 8H 6D 5D TH 2C 2H\n6H TC 7D AD 4D 8S TS 9H TD 7S\nJS 6D JD JC 2H AC 6C 3D KH 8D\nKH JD 9S 5D 4H 4C 3H 7S QS 5C\n4H JD 5D 3S 3C 4D KH QH QS 7S\nJD TS 8S QD AH 4C 6H 3S 5S 2C\nQS 3D JD AS 8D TH 7C 6S QC KS\n7S 2H 8C QC 7H AC 6D 2D TH KH\n5S 6C 7H KH 7D AH 8C 5C 7S 3D\n3C KD AD 7D 6C 4D KS 2D 8C 4S\n7C 8D 5S 2D 2S AH AD 2C 9D TD\n3C AD 4S KS JH 7C 5C 8C 9C TH\nAS TD 4D 7C JD 8C QH 3C 5H 9S\n3H 9C 8S 9S 6S QD KS AH 5H JH\nQC 9C 5S 4H 2H TD 7D AS 8C 9D\n8C 2C 9D KD TC 7S 3D KH QC 3C\n4D AS 4C QS 5S 9D 6S JD QH KS\n6D AH 6C 4C 5H TS 9H 7D 3D 5S\nQS JD 7C 8D 9C AC 3S 6S 6C KH\n8H JH 5D 9S 6D AS 6S 3S QC 7H\nQD AD 5C JH 2H AH 4H AS KC 2C\nJH 9C 2C 6H 2D JS 5D 9H KC 6D\n7D 9D KD TH 3H AS 6S QC 6H AD">;
type t35 = ScoreBlock<"JD 4H 7D KC 3H JS 3C TH 3D QS\n4C 3H 8C QD 5H 6H AS 8H AD JD\nTH 8S KD 5D QC 7D JS 5S 5H TS\n7D KC 9D QS 3H 3C 6D TS 7S AH\n7C 4H 7H AH QC AC 4D 5D 6D TH\n3C 4H 2S KD 8H 5H JH TC 6C JD\n4S 8C 3D 4H JS TD 7S JH QS KD\n7C QC KD 4D 7H 6S AD TD TC KH\n5H 9H KC 3H 4D 3D AD 6S QD 6H\nTH 7C 6H TS QH 5S 2C KC TD 6S\n7C 4D 5S JD JH 7D AC KD KH 4H\n7D 6C 8D 8H 5C JH 8S QD TH JD\n8D 7D 6C 7C 9D KD AS 5C QH JH\n9S 2C 8C 3C 4C KS JH 2D 8D 4H\n7S 6C JH KH 8H 3H 9D 2D AH 6D\n4D TC 9C 8D 7H TD KS TH KD 3C\nJD 9H 8D QD AS KD 9D 2C 2S 9C\n8D 3H 5C 7H KS 5H QH 2D 8C 9H\n2D TH 6D QD 6C KC 3H 3S AD 4C\n4H 3H JS 9D 3C TC 5H QH QC JC\n3D 5C 6H 3S 3C JC 5S 7S 2S QH\nAC 5C 8C 4D 5D 4H 2S QD 3C 3H\n2C TD AH 9C KD JS 6S QD 4C QC\nQS 8C 3S 4H TC JS 3H 7C JC AD\n5H 4D 9C KS JC TD 9S TS 8S 9H">;
type t36 = ScoreBlock<"QD TS 7D AS AC 2C TD 6H 8H AH\n6S AD 8C 4S 9H 8D 9D KH 8S 3C\nQS 4D 2D 7S KH JS JC AD 4C 3C\nQS 9S 7H KC TD TH 5H JS AC JH\n6D AC 2S QS 7C AS KS 6S KH 5S\n6D 8H KH 3C QS 2H 5C 9C 9D 6C\nJS 2C 4C 6H 7D JC AC QD TD 3H\n4H QC 8H JD 4C KD KS 5C KC 7S\n6D 2D 3H 2S QD 5S 7H AS TH 6S\nAS 6D 8D 2C 8S TD 8H QD JC AH\n9C 9H 2D TD QH 2H 5C TC 3D 8H\nKC 8S 3D KH 2S TS TC 6S 4D JH\n9H 9D QS AC KC 6H 5D 4D 8D AH\n9S 5C QS 4H 7C 7D 2H 8S AD JS\n3D AC 9S AS 2C 2D 2H 3H JC KH\n7H QH KH JD TC KS 5S 8H 4C 8D\n2H 7H 3S 2S 5H QS 3C AS 9H KD\nAD 3D JD 6H 5S 9C 6D AC 9S 3S\n3D 5D 9C 2D AC 4S 2S AD 6C 6S\nQC 4C 2D 3H 6S KC QH QD 2H JH\nQC 3C 8S 4D 9S 2H 5C 8H QS QD\n6D KD 6S 7H 3S KH 2H 5C JC 6C\n3S 9S TC 6S 8H 2D AD 7S 8S TS\n3C 6H 9C 3H 5C JC 8H QH TD QD\n3C JS QD 5D TD 2C KH 9H TH AS">;
type t37 = ScoreBlock<"9S TC JD 3D 5C 5H AD QH 9H KC\nTC 7H 4H 8H 3H TD 6S AC 7C 2S\nQS 9D 5D 3C JC KS 4D 6C JH 2S\n9S 6S 3C 7H TS 4C KD 6D 3D 9C\n2D 9H AH AC 7H 2S JH 3S 7C QC\nQD 9H 3C 2H AC AS 8S KD 8C KH\n2D 7S TD TH 6D JD 8D 4D 2H 5S\n8S QH KD JD QS JH 4D KC 5H 3S\n3C KH QC 6D 8H 3S AH 7D TD 2D\n5S 9H QH 4S 6S 6C 6D TS TH 7S\n6C 4C 6D QS JS 9C TS 3H 8D 8S\nJS 5C 7S AS 2C AH 2H AD 5S TC\nKD 6C 9C 9D TS 2S JC 4H 2C QD\nQS 9H TC 3H KC KS 4H 3C AD TH\nKH 9C 2H KD 9D TC 7S KC JH 2D\n7C 3S KC AS 8C 5D 9C 9S QH 3H\n2D 8C TD 4C 2H QC 5D TC 2C 7D\nKS 4D 6C QH TD KH 5D 7C AD 8D\n2S 9S 8S 4C 8C 3D 6H QD 7C 7H\n6C 8S QH 5H TS 5C 3C 4S 2S 2H\n8S 6S 2H JC 3S 3H 9D 8C 2S 7H\nQC 2C 8H 9C AC JD 4C 4H 6S 3S\n3H 3S 7D 4C 9S 5H 8H JC 3D TC\nQH 2S 2D 9S KD QD 9H AD 6D 9C\n8D 2D KS 9S JC 4C JD KC 4S TH">;
type t38 = ScoreBlock<"KH TS 6D 4D 5C KD 5H AS 9H AD\nQD JS 7C 6D 5D 5C TH 5H QH QS\n9D QH KH 5H JH 4C 4D TC TH 6C\nKH AS TS 9D KD 9C 7S 4D 8H 5S\nKH AS 2S 7D 9D 4C TS TH AH 7C\nKS 4D AC 8S 9S 8D TH QH 9D 5C\n5D 5C 8C QS TC 4C 3D 3S 2C 8D\n9D KS 2D 3C KC 4S 8C KH 6C JC\n8H AH 6H 7D 7S QD 3C 4C 6C KC\n3H 2C QH 8H AS 7D 4C 8C 4H KC\nQD 5S 4H 2C TD AH JH QH 4C 8S\n3H QS 5S JS 8H 2S 9H 9C 3S 2C\n6H TS 7S JC QD AC TD KC 5S 3H\nQH AS QS 7D JC KC 2C 4C 5C 5S\nQH 3D AS JS 4H 8D 7H JC 2S 9C\n5D 4D 2S 4S 9D 9C 2D QS 8H 7H\n6D 7H 3H JS TS AC 2D JH 7C 8S\nJH 5H KC 3C TC 5S 9H 4C 8H 9D\n8S KC 5H 9H AD KS 9D KH 8D AH\nJC 2H 9H KS 6S 3H QC 5H AH 9C\n5C KH 5S AD 6C JC 9H QC 9C TD\n5S 5D JC QH 2D KS 8H QS 2H TS\nJH 5H 5S AH 7H 3C 8S AS TD KH\n6H 3D JD 2C 4C KC 7S AH 6C JH\n4C KS 9D AD 7S KC 7D 8H 3S 9C">;
type t39 = ScoreBlock<"7H 5C 5H 3C 8H QC 3D KH 6D JC\n2D 4H 5D 7D QC AD AH 9H QH 8H\nKD 8C JS 9D 3S 3C 2H 5D 6D 2S\n8S 6S TS 3C 6H 8D 5S 3H TD 6C\nKS 3D JH 9C 7C 9S QS 5S 4H 6H\n7S 6S TH 4S KC KD 3S JC JH KS\n7C 3C 2S 6D QH 2C 7S 5H 8H AH\nKC 8D QD 6D KH 5C 7H 9D 3D 9C\n6H 2D 8S JS 9S 2S 6D KC 7C TC\nKD 9C JH 7H KC 8S 2S 7S 3D 6H\n4H 9H 2D 4C 8H 7H 5S 8S 2H 8D\nAD 7C 3C 7S 5S 4D 9H 3D JC KH\n5D AS 7D 6D 9C JC 4C QH QS KH\nKD JD 7D 3D QS QC 8S 6D JS QD\n6S 8C 5S QH TH 9H AS AC 2C JD\nQC KS QH 7S 3C 4C 5C KC 5D AH\n6C 4H 9D AH 2C 3H KD 3D TS 5C\nTD 8S QS AS JS 3H KD AC 4H KS\n7D 5D TS 9H 4H 4C 9C 2H 8C QC\n2C 7D 9H 4D KS 4C QH AD KD JS\nQD AD AH KH 9D JS 9H JC KD JD\n8S 3C 4S TS 7S 4D 5C 2S 6H 7C\nJS 7S 5C KD 6D QH 8S TD 2H 6S\nQH 6C TC 6H TD 4C 9D 2H QC 8H\n3D TS 4D 2H 6H 6S 2C 7H 8S 6C">;
type t40 = ScoreBlock<"9H 9D JD JH 3S AH 2C 6S 3H 8S\n2C QS 8C 5S 3H 2S 7D 3C AD 4S\n5C QC QH AS TS 4S 6S 4C 5H JS\nJH 5C TD 4C 6H JS KD KH QS 4H\nTC KH JC 4D 9H 9D 8D KC 3C 8H\n2H TC 8S AD 9S 4H TS 7H 2C 5C\n4H 2S 6C 5S KS AH 9C 7C 8H KD\nTS QH TD QS 3C JH AH 2C 8D 7D\n5D KC 3H 5S AC 4S 7H QS 4C 2H\n3D 7D QC KH JH 6D 6C TD TH KD\n5S 8D TH 6C 9D 7D KH 8C 9S 6D\nJD QS 7S QC 2S QH JC 4S KS 8D\n7S 5S 9S JD KD 9C JC AD 2D 7C\n4S 5H AH JH 9C 5D TD 7C 2D 6S\nKC 6C 7H 6S 9C QD 5S 4H KS TD\n6S 8D KS 2D TH TD 9H JD TS 3S\nKH JS 4H 5D 9D TC TD QC JD TS\nQS QD AC AD 4C 6S 2D AS 3H KC\n4C 7C 3C TD QS 9C KC AS 8D AD\nKC 7H QC 6D 8H 6S 5S AH 7S 8C\n3S AD 9H JC 6D JD AS KH 6S JH\nAD 3D TS KS 7H JH 2D JS QD AC\n9C JD 7C 6D TC 6H 6C JC 3D 3S\nQC KC 3S JC KD 2C 8D AH QS TS\nAS KD 3D JD 8H 7C 8C 5C QD 6C">;

// tsc will output the correct answer as a type-checking error
type CorrectAnswer = UnaryToNumber<UnarySum<[t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13, t14, t15, t16, t17, t18, t19, t20, t21, t22, t23, t24, t25, t26, t27, t28, t29, t30, t31, t32, t33, t34, t35, t36, t37, t38, t39, t40]>>;
const guess: CorrectAnswer = 42;
