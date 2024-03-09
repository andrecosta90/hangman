# hangman
[hangman](https://en.wikipedia.org/wiki/Hangman_(game)): guessing game for one player

## How to Play

Hangman is a word-guessing game where players try to guess a secret word one letter at a time. Here's how to play:

1. **Starting the Game**:
   - To play the game, make sure you have Ruby installed on your system. Then, navigate to the directory containing the `lib` folder and run the following command:

     ```bash
     ruby lib/hangman.rb
     ```

2. **Options Menu**:
   - Upon starting the game, you'll be presented with an options menu:
     ```
     =========================
     Welcome to Hangman Game!
         1 - New game
         2 - Load game
     =========================
     ```
   
3. **Choosing an Option**:
   - Choose an option by entering the corresponding number and pressing `Enter`:
     - Enter `1` to start a new game.
     - Enter `2` to load a saved game from a file.

4. **New Game**: If you choose to start a new game, a random secret word will be selected, and you'll begin guessing letters to uncover the word.

5. **Load Game**: If you choose to load a saved game, you'll be prompted to enter the file name of the saved game. Make sure to provide the correct file path.

6. **Guessing Letters**:
   - Once the game starts, you'll be prompted to guess a letter.
   - Enter a single letter (A-Z) and press `Enter`.
   - If the letter is correct, it will be revealed in the secret word. Otherwise, it will be counted as an incorrect guess.

7. **Winning or Losing**:
    - Continue guessing letters until you either:
      - Successfully guess the entire word (`You Win!`), or
      - Run out of attempts (`You Lose!`).

8. **Saving the Game**:
   - During the game, you'll have the option to save your progress by entering `1` when prompted.
   - The game state will be saved to a JSON file in the `appdata` directory.

9. **Ending the Game**: The game will end once you win, lose, or choose to save and exit.

10. **Have Fun!**: Enjoy playing Hangman and see how many words you can guess!