#Exercise 1
import random

def get_word_from_file():
    with open('Wordlist.txt', 'r') as file: # open file
        text = file.read() #load as single string
        words = text.split() # list of words using space to seperate
        return words

def get_random_sentence(length): # length will be the number of words in the sentence
    words = get_word_from_file()
    selectWord = random.choices(words, k=length) # function will pick random words from the file and length will be the number of them
    sentence = ' '.join(selectWord).lower()  #turn list of words into a sentence
    return sentence

print(get_random_sentence(8))

def main():
    print("This program generates a random sentence with a length of your choice (between 2 and 20 words).")
    user_input = int(input("Select a number between 2 and 20"))
    if user_input >= 2 and user_input <= 20:
        print(get_random_sentence(user_input))
    else:
        print("Error: Number must be between 2 and 20. ")

main()



