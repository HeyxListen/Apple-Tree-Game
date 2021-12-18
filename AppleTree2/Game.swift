//
//  Game.swift
//  AppleTree2
//
//  Created by csuftitan on 10/17/21.
//

import Foundation

struct Game {
    var word: String
    var incorrectMovesRemaining: Int
    var guessedLetters: [Character]
    //var numberOfCorrectCharactersGuessed: Int = 0
    
    var formattedWord: String {
        var guessedWord:String = ""
        for letter in word {
            if guessedLetters.contains(letter) {
                guessedWord += "\(letter)"
            } else {
                guessedWord += "_"
            }
        }
        return guessedWord
    }
    
    mutating func playerGuessed (letter: Character) {
        guessedLetters.append(letter)
        if !word.contains(letter) {
            incorrectMovesRemaining -= 1
        }
    }
    
    mutating func correctLetterGuessFunc (letter: Character) -> Bool {
        if word.contains(letter) {
            //numberOfCorrectCharactersGuessed = guessedLetters.count
            return true
        } else {
            return false
        }
    }
}

