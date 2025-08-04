//
//  ResultViewController.swift
//  Personality Quiz
//
//  Created by Student on 31/07/25.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var resultDefinition: UILabel!
    
    var responses: [Answer]!

    override func viewDidLoad() {
        super.viewDidLoad()
        calculateResult()
        navigationItem.hidesBackButton = true

    }
    

    func calculateResult() {
        var frequencyofAnswers: [AnimalType: Int] = [:]
        
        let responseType = responses.map {$0.type}
        
        for response in responseType {
            frequencyofAnswers[response] = (frequencyofAnswers[response] ?? 0) + 1
        }
        
        let frequentAnswerSorted = frequencyofAnswers.sorted { (pair1, pair2) -> Bool in
            return pair1.value > pair2.value
            
        }
        let mostCommonAnswer = frequencyofAnswers.sorted { $0.1 > $1.1 }.first!.key
        
        resultLabel.text = "You are a \(mostCommonAnswer.rawValue)"
        resultDefinition.text = mostCommonAnswer.definition
    }
}
