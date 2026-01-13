import random

def guess():
    value = random.randint(1,100)
    guess = int(input().strip())
    counts = 0
    
    while guess != value:
        counts += 1
        if guess > value:
            print(f'Guess: {counts}: Too high')
        elif guess < value:
            print(f'Guess {counts}: Too low')
        guess = int(input().strip())
        
    print(f'Guess {counts}: Correct!')
    print(f'Total Guess(es): {counts}.')
    
if __name__ == "__main__":
    guess()
    
#This one is the first project provided in geeksforgeeks.