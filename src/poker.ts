// Poker hands exploration
type jack = Next<n10>;
type queen = Next<jack>;
type king = Next<queen>;

type PokerSuit = "hearts" | "diamonds" | "spades" | "clubs";
type PokerRank = n1 | n2 | n3 | n4 | n5 | n6 | n7 | n8 | n9 | n10 | jack | queen | king;

type PokerCard = {
    suit: PokerSuit;
    rank: PokerRank;
}

type PokerHand<A extends PokerCard, B extends PokerCard, C extends PokerCard, D extends PokerCard, E extends PokerCard> = {
    card1: A;
    card2: B;
    card3: C;
    card4: D;
    card5: E;
}

type AnyOfSuit<Suit extends PokerSuit> = {
    suit: Suit;
    rank: PokerRank;
}

type FlushOfSuit<Suit extends PokerSuit> = PokerHand<AnyOfSuit<Suit>, AnyOfSuit<Suit>, AnyOfSuit<Suit>, AnyOfSuit<Suit>, AnyOfSuit<Suit>>;
type PokerFlush = FlushOfSuit<"clubs"> | FlushOfSuit<"diamonds"> | FlushOfSuit<"hearts"> | FlushOfSuit<"spades">;

type t = {
    card1: { suit: "hearts", rank: jack },
    card2: { suit: "hearts", rank: jack },
    card3: { suit: "hearts", rank: jack },
    card4: { suit: "hearts", rank: jack },
    card5: { suit: "hearts", rank: jack },
} extends PokerFlush ? "true" : "false";

// Arithmetic
type Zero = {
    previous: never;
}

type NaturalNumber = {
    previous: NaturalNumber;
}

type Next<T extends NaturalNumber> = {
    previous: T;
}

type Previous<T extends NaturalNumber> = {
    previous: T["previous"]["previous"];
}

type Add<A extends NaturalNumber, B extends NaturalNumber> = B extends Zero ? A : Next<Add<A, Previous<B>>>;

type n0 = Zero;
type n1 = Next<n0>;
type n2 = Next<n1>;
type n3 = Next<n2>;
type n4 = Next<n3>;
type n5 = Next<n4>;
type n6 = Next<n5>;
type n7 = Next<n6>;
type n8 = Next<n7>;
type n9 = Next<n8>;
type n10 = Next<n9>;

type l = n9 extends n8 ? "true" : "false";

type Fibonacci<A extends NaturalNumber, B extends NaturalNumber> = Add<A, B>;

// type FibonacciNumber = {
//     twoBack: FibonacciNumber;
//     oneBack: FibonacciNumber;
// }

// type NextFibonacciNumber<TwoBack extends FibonacciNumber, OneBack extends FibonacciNumber> = {
//     twoBack: TwoBack;
//     oneBack: OneBack;
// }
