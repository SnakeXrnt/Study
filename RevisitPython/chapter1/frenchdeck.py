import collections

from random import choice, shuffle

Card = collections.namedtuple("Card",["rank","suit"])

class FrenchDeck:
    ranks = [str(n) for n in range(2,11)] + list("JQKA")
    suits = 'spades diamonds clubs hearts'.split()

    def __init__(self) -> None:
        self._cards = [Card(rank,suit) for suit in self.suits for rank in self.ranks]

    def __len__(self):
        return len(self._cards)

    def __getitem__(self, position):
        return self._cards[position]

    def __iter__(self):
        for card in self._cards:
            yield card
    

"""
return = returning from a function, and it ends there
yield = returning from a function, but still save the thing


"""


Decoration : int = 10

def resolve_shadowing(Decoration): 
    Decoration = Decoration
    print("\nStart of resolve shadowing by printing decorator : ")
    print(Decoration)

deck = FrenchDeck()
print(len(deck))

beer_card = Card("7", "diamonds")
print(beer_card)


print("list of deck : ", deck[:15])

print("random : " , choice(deck)) 


print("\n\nfor loop test : ") 

for card in deck:
    print(card)

print("\n \nreversed for loop test : ")

for card in reversed(deck):
    print(card)


print("\n\nShuffle : ")

shuffle_list = list(deck) 

shuffle(shuffle_list)

for card in shuffle_list:
    print(card)


resolve_shadowing(Decoration);
