#Part I

class Text():
    def __init__(self, text):
        self.text = text

    def word_frequency (self, book):
        count = 0
        for word in self.text.split():
            if word == book:
                count += 1
        return count
    
    def common_word(self):
       my_string = self.text.split()
       multiWord = {}

       for word in self.text.split():
        if word in multiWord:
            multiWord[word] += 1
        else:
            multiWord[word] = 1

       most_common = ""
       max_count = 0

       for word, count in multiWord.items():
           if count > max_count:
              max_count = count
              most_common = word

       return most_common
    
    def uniqueWord(self):
        words = self.text.split()
        unique = set(words)
        return list(unique)


#part II
    @classmethod
    def from_file(cls, filename):
        with open(filename, 'r') as file:
            content = file.read()
        return cls(content)
    

text = Text("And, when you want something, all the universe conspires in helping you to achieve it.")
print(text.word_frequency("achieve"))
print(text.common_word())
print(text.uniqueWord())
