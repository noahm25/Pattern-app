
import UIKit
import Phidget22Swift

class ViewController: UIViewController {
    
    let button0 = DigitalInput()
    let button1 = DigitalInput()
    let led1 = DigitalOutput()
    let led2 = DigitalOutput()
    let allPatterns = PatternBank()
    var patternNumber : Int = 0
    var pickedAnswer1 : Bool = false
    var pickedAnswer2 : Bool = false
    var pickedAnswer3 : Bool = false
    var pickedAnswer4 : Bool = false
    var buttonOrder : Int = 0
    var score : Int = 0
    
    
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var patternTypeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        informationLabel.text = "Watch the pattern and repeat it using the buttons. Press the red or green button to start the game."
        patternTypeLabel.text = "The Pattern will be displayed here."
        scoreLabel.text = "Score:0"
        
        
        do{
    
            try Net.enableServerDiscovery(serverType: .deviceRemote)
            
            //address object
            try button0.setDeviceSerialNumber(528013)
            try button0.setHubPort(0)
            try button0.setIsHubPortDevice(true)
            
            try button1.setDeviceSerialNumber(528013)
            try button1.setHubPort(1)
            try button1.setIsHubPortDevice(true)
            
            try led1.setDeviceSerialNumber(528013)
            try led1.setHubPort(2)
            try led1.setIsHubPortDevice(true)
            
            try led2.setDeviceSerialNumber(528013)
            try led2.setHubPort(3)
            try led2.setIsHubPortDevice(true)
            
            
            //add attach hangler
            let _ = button0.attach.addHandler(attach_handler_button0)
            let _ = button1.attach.addHandler(attach_handler_button1)
            let _ = led1.attach.addHandler(attach_handler_button0)
            let _ = led2.attach.addHandler(attach_handler_button1)
            
            
            //add state change handler
            let _ = button0.stateChange.addHandler(state_change_button1)
            let _ = button1.stateChange.addHandler(state_change_button0)
            
            //open objects
            try button0.open()
            try button1.open()
            try led1.open()
            try led2.open()
            
        }catch let err as PhidgetError {
            print("Phidget Error " + err.description)
        }catch {
            //catch other errors here
        }
        
    }

    func patternChange() {
        DispatchQueue.main.async {
            self.patternTypeLabel.text = self.allPatterns.list[self.patternNumber].patternText
            self.informationLabel.text = "The Pattern Has Started.Repeat The Pattern"
        }
        
    }
    
    func checkAnswer() {
        
        let correctAnswer1 = allPatterns.list[patternNumber].answer1
        let correctAnswer2 = allPatterns.list[patternNumber].answer2
        let correctAnswer3 = allPatterns.list[patternNumber].answer3
        let correctAnswer4 = allPatterns.list[patternNumber].answer4
        
        if (correctAnswer1 == pickedAnswer1 && correctAnswer2 == pickedAnswer2 && correctAnswer3 == pickedAnswer3 && correctAnswer4 == pickedAnswer4)  {
            print("Correct")
            score += 10
            DispatchQueue.main.async {
                self.informationLabel.text = "You Are Correct!"
                self.patternTypeLabel.text = "If you would like to play again press the Green or Red Button."
                self.scoreLabel.text = "Score: \(self.score )"
                
            }
        }
            
        else{
            print("Incorrect")
            DispatchQueue.main.async {
                self.informationLabel.text = "You Are Incorrect Please Try Again."
                self.patternTypeLabel.text = "If you would like to play again press the Green Button."
            }
    
            startOver()
        }
        
    }

    func startOver() {
        buttonOrder = 0
        DispatchQueue.main.async {
            self.informationLabel.text = "Watch the pattern and repeat it using the buttons. Press the green button to start the game!."
            self.patternTypeLabel.text = "The Pattern will be displayed here."
        }
    }
    
    func attach_handler_button0(sender: Phidget){
        do{
            let hubPort = try sender.getHubPort()
            
            if(hubPort == 0){
                
                print("Button 0 attached")
                
            }
                
            else{
                print("Led 1 attached")
            }
            
        } catch let err as PhidgetError{
            print("Phidget Error " + err.description)
        } catch{
            //catch other errors here
        }
    }
    
    
    func attach_handler_button1(sender: Phidget){
        do{
            let hubPort = try sender.getHubPort()
            
            if(hubPort == 1){
                print("Button 1 attached")
            }
                
            else{
                print("Led 2 attached")
            }
            
        } catch let err as PhidgetError{
            print("Phidget Error " + err.description)
        } catch{
            //catch other errors here
        }
    }
    
    func state_change_button0(sender:DigitalInput, state:Bool){
        
        
        do {
            if(state == false){
                print("Button Green Pressed")
                try led1.setState(true)
                
                if(buttonOrder == 0){
                    patternChange()
                    buttonOrder+=1
                }
                    
                else if (buttonOrder == 1){
                    pickedAnswer1 = true
                    buttonOrder+=1
                }
                    
                else if (buttonOrder == 2){
                    pickedAnswer2 = true
                    buttonOrder+=1
                }
                    
                else if (buttonOrder == 3){
                    pickedAnswer3 = true
                    buttonOrder+=1
                }
                    
                else if (buttonOrder == 4){
                    pickedAnswer4 = true
                    checkAnswer()
                    
                }
                else if (buttonOrder == 5){
                    startOver()
                }
            }
                
            else{
                print("Button Green is Released")
                try led1.setState(false)
                
            }
            
        }catch let err as PhidgetError{
            print("Phidget Error" + err.description)
        } catch{
            
        }
    }
    
    
    
    func state_change_button1(sender:DigitalInput, state:Bool){
        do {
            if(state == false){
                print("Button Red Pressed")
                try led2.setState(true)
                
                if(buttonOrder == 0){
                    patternChange()
                    buttonOrder+=1
                }
                    
                else if (buttonOrder == 1){
                    pickedAnswer1 = false
                    buttonOrder+=1
                    
                }
                    
                else if (buttonOrder == 2){
                    pickedAnswer2 = false
                    buttonOrder+=1
                }
                    
                else if (buttonOrder == 3){
                    pickedAnswer3 = false
                    buttonOrder+=1
                }
                    
                else if (buttonOrder == 4){
                    pickedAnswer4 = false
                    checkAnswer()
                    
                }
                else if (buttonOrder == 5){
                    startOver()
                }
                
            }
                
            else{
                print("Button Red is Released")
                try led2.setState(false)
            }
        } catch let err as PhidgetError{
            print("Phidget Error" + err.description)
        } catch{
            
        }
    }    
}
