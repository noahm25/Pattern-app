
import Foundation

class QuestionBank {
    var list = [Question]()
    
    
    init() {
        // Creating a quiz item and appending it to the list
        let item = Question(text: "Green", correctAnswer: true)
        
        // Add the Question to the list of questions
        list.append(item)
        
        // skipping one step and just creating the quiz item inside the append function
        list.append(Question(text: "Green.", correctAnswer: true))
        
        list.append(Question(text: "Red", correctAnswer: false))
        
        list.append(Question(text: "Red", correctAnswer: false))
        
        list.append(Question(text: "Green", correctAnswer: true))
        
        list.append(Question(text: "Green", correctAnswer: true))
        
        list.append(Question(text: "Red", correctAnswer: false))
        
        list.append(Question(text: "Red", correctAnswer: false))
        
    }
    
    
}
