class AnagramChecker():
    def __init__(self, wordList):
        with open(wordList, "r") as file:
         self.wordList = wordList
         lines = file.readlines()
         cleanedList = []
         for line in lines:
            cleanedWord=line.strip()
            cleanedList.append(cleanedWord)
         self.word_bank = cleanedList #makes cleanedList accessible anywhere via self.word_bank
    def is_valid_word(self, word): #method to access self.word_bank.
       word = word.upper() #ensure any user word is converted to uppercase so if the word appears in the sowpods.txt it will be a match
       if word in self.word_bank: #checking whether word is stored in self.word_bank  
          return True
       return False
    def get_anagrams(self, word):
       word = word.upper()
       anagrams = []#this will store each word that is a match between sowpods.txt and the user word
       for palabra in self.word_bank:
          if palabra != word and sorted(palabra) == sorted (word): #we use palabra != word to ensure it is not counted as an anagram of itself then we check to see if the user word and the word in the list has the same letters
           anagrams.append(palabra)# if it matches then it will be added to the anagrams list we created in line 18
       return anagrams  

