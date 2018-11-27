
import Foundation

class Pattern {
    var patternText : String
    let answer1 : Bool
    let answer2 : Bool
    let answer3 : Bool
    let answer4 : Bool
    
    init(text: String, correctGreen: Bool, wrongGreen: Bool, correctRed: Bool, wrongRed: Bool){
        patternText = text
        answer1 = correctGreen
        answer2 = wrongGreen
        answer3 = correctRed
        answer4 = wrongRed
    }
}
