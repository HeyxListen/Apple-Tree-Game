//
//  ViewController.swift
//  AppleTree2
//
//  Created by Stephen Coffaro on 10/16/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var treeImageView: UIImageView!
    
    @IBOutlet var correctWordLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    
    @IBOutlet var letterButtons: [UIButton]!
    
    var listOfWords = ["excellent", "halloween", "kitty", "incandescent", "buccaneer", "glorious", "programming"]
    let incorrectMovesAllowed: Int = 7
    var checkPlayerScored: Bool = false
    var numberOfPoints: Int = 0
    var totalWins: Int = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses: Int = 0 {
        didSet {
            newRound()
        }
    }
    var score: Int = 0 
        
    var currentGame: Game!

    @IBAction func letterButtonPressed(_ sender: UIButton) {
          sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        checkPlayerScored = currentGame.correctLetterGuessFunc(letter: letter)
        checkIfUserScored()
        currentGame.playerGuessed(letter: letter)
        updateGameStatus()
        checkPlayerScored = false
        numberOfPoints = 0
   }

      override func viewDidLoad() {
          super.viewDidLoad()
          newRound()
        // Do any additional setup after loading the view.
    }

    func newRound() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(enabled: true)
              updateUI()
        } else {
            enableLetterButtons(enabled: false)
        }
       
      }
    
    func enableLetterButtons(enabled: Bool) {
        for button in letterButtons {
            button.isEnabled = enabled
        }
    }
    
    func updateGameStatus() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        } else if currentGame.formattedWord == currentGame.word {
            //add 5 to score if the correct word is guessed
            score += 5
            totalWins += 1
        } else {
            updateUI()
        }
    }
    
    func checkIfUserScored() {
        if checkPlayerScored == true {
            //score += currentGame.numberOfCorrectCharactersGuessed
            //i tried to add 1 point per character correct, but couldnt manage it. So i did +1 point for every correct guess
            score += 1
        } else {
            score += 0
        }
    }

      func updateUI() {
        let letters = currentGame.formattedWord
        //add mapping func
        let mappedLetters = letters.map { String($0) }
//        commenting out old loop structure, replaced with mapping func
//        let letters = [String]()
//        for letter in currentGame.formattedWord {
//            letters.append(String(letter))
//        }
        
        let wordWithSpacing = mappedLetters.joined(separator: " ")
          correctWordLabel.text = wordWithSpacing
          scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses), Score: \(score), Remaining Guesses: \(currentGame.incorrectMovesRemaining)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
      }


}

