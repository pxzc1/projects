import random

def random():
    words = ['words', 'rainbow', 'hercules', 'apple', 'computer', 'greet', 'blanket', 'player', 'condition']
    word = random.choice(words)

    turns = 5
    print(f"You have {turns} turns to guess the word!")

    while turns > 0:
        guess = input("Enter guess: ").strip().lower()

        if guess == word:
            print(f'Correct! The word is {word!r}')
            break
        else:
            turns -= 1
            if turns > 0:
                print(f"Wrong! You have {turns} turns left.")
            else:
                print(f"No turns left! The word was {word!r}")

if __name__ == "__main__":
    random()