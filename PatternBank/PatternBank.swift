
import Foundation

class PatternBank {
    
    var list = [Pattern]()
    
    init() {
        
        // Creating a quiz item and appending it to the list
        let item = Pattern(text: "Green, Red, Green, Red", correctGreen: true, wrongGreen: false, correctRed: true, wrongRed: false)
        
        // Add the Question to the list of questions
        list.append(item)
        
    }
    
}
