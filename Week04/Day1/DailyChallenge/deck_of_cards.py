class Card:
    def __init__(self, suit, value):
        self.suit = suit
        self.value = value
suits = ["Hearts", "Diamonds", "Clubs", "Spades"]
values = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"] 

class Deck:
    def __init__(self):
        self.cards = [] #an empty list to store the deck
        for suit in suits: #goes through each suit
            for value in values: #goes through each value
                self.cards.append(Card(suit, value)) #creates a new card and adds it to the deck
    
    def shuffle (self):
        import random #we call random so that we can reorder the list. 
        random.shuffle(self.cards)
    
    def deal (self):
        if len(self.cards) == 0: #we check to see if the deck is empty
            return None #prevents crashing the program if there is no card left to deal
        return self.cards.pop() #essentially it deals  a card and removes it from the deck so you can't select it again

d1 = Deck()
d1.shuffle()
print("Dealing 5 Cards:")

for _ in range (5):
    card = d1.deal()
    print(f"{card.value} of {card.suit}")
print (f"Cards remaining in deck: {len(d1.cards)}") 

print("\nDealing all remaining cards...")
while True: #we keep dealing until the deck is empty
    card =d1.deal()
    if card is None:
        print("The deck is now empty")
        break
    print(f"{card.value} of {card.suit}")

