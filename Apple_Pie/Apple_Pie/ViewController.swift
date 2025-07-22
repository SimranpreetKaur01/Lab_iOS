//
//  ViewController.swift
//  Apple_Pie
//
//  Created by Simran on 21/07/25.
//

import UIKit

class ViewController: UIViewController {
    
    var listOfWords = ["biccaneer", "swift", "glorious", "incandescent", "bug", "program"]
    let incorrectMovesAllowed = 7
    var currentGame: Game!
    var totalWins = 0 {
        didSet{
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    
    @IBOutlet var treeImageView: UIImageView!
    @IBOutlet var correctWordLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    
    @IBOutlet var letterButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        guard let letterString = sender.configuration?.title else {
            print("Button title is nil for: \(sender)")
            return
        }

        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    
    func updateGameState () {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        } else {
            updateUI()
        }
    }
    
    func newRound() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
        } else {
            enableLetterButtons(false)
        }
    }
    
    
    func enableLetterButtons(_ enable: Bool) {
        guard let buttons = letterButtons else {
            print("letterButtons not connected!")
            return
        }
        for button in buttons {
            button.isEnabled = enable
        }
    }

    
    func updateUI() {
        var letters = [String] ()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
}


