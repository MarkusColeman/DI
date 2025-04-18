from anagram_checker import AnagramChecker  #we're importing the class anagramChecker from the file anagram_checker.py
checker = AnagramChecker("sowpods.txt") # we create a class instance of AnagramChecker and loads sowpods.txt into it. Checker will be used to call the methods in the anagram_checker.py file that check the validity of the word (is_valid_word)  and to return the anagrams later (get_anagrams) 
while True:
    print("Menu: \n1. Enter a Word \n2. Exit")
    userChoice =input("Select Option (1 or 2): ")
    if userChoice == "2": #we first check to be sure the user doesn't want to exit and if so we print an exit message
        print("Ciao!")
        break # then we break out of the while true loop
    elif userChoice == "1":
        word =  input("Enter a single word: ").strip()# removing any leading or trailing whitespaces with .strip() so that the program has no issues comparing the users word against those in sowpods.txt 
        if not word.isalpha() or " " in word: # we can restrict the use of more than word or other characters
            print("Please enter a single word using letters A-Z.")
            continue
        if not checker.is_valid_word(word): # we use not to reverse the result of the method to ensure that all invalid words trigger the error message
            print("That word is not a valid word in English. Please try again") 
            continue #returns the user to the menu
        anagrams = checker.get_anagrams(word)
        print(f"\n YOUR WORD: \"{word.upper()}\"") #returns all valid anagrams
        print("This is a valid English Word") # prints the word in all caps
        print("Anagrams for your word:", ", ".join(anagrams)) #joins the anagram list into a string with commas in between each
