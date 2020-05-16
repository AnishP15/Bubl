import UIKit
import Firebase
import FirebaseFirestore

enum Colors {
    
    static let red = UIColor(red: 1.0, green: 0.0, blue: 77.0/255.0, alpha: 1.0)
    static let blue = UIColor.blue
    static let green = UIColor(red: 35.0/255.0 , green: 233/255, blue: 173/255.0, alpha: 1.0)
    static let yellow = UIColor(red: 1, green: 209/255, blue: 77.0/255.0, alpha: 1.0)
    
}

enum Images {
    
    static let box = UIImage(named: "Box")!
    //static let triangle = UIImage(named: "Triangle")!
    static let circle = UIImage(named: "Circle")!
    static let swirl = UIImage(named: "Spiral")!
    
}


class MatchesViewController: UIViewController {

    @IBOutlet weak var matchesLabel: UILabel!
    @IBOutlet weak var retakeTestButton: UIButton!
    var tap: UITapGestureRecognizer?
    
    var emitter = CAEmitterLayer()
    
    var colors:[UIColor] = [
        Colors.red,
        Colors.blue,
        Colors.green,
        Colors.yellow
    ]
    
    var images:[UIImage] = [
        Images.box,
        //Images.triangle,
        Images.circle,
        Images.swirl
    ]
    
    var velocities:[Int] = [
        100,
        90,
        150,
        200
    ]
    
    var matchArray = [String]()
    var currentUser = ""
    
    @IBAction func retakeTestBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    var match = ""
    
    @IBAction func refreshTapped(_ sender: Any) {
        
        
        self.emitter.removeFromSuperlayer()
        
        // show confetti
        emitter.emitterPosition = CGPoint(x: view.frame.size.width / 2, y: -10)
        emitter.emitterShape = CAEmitterLayerEmitterShape.line
        emitter.emitterSize = CGSize(width: view.frame.size.width, height: 2.0)
        emitter.emitterCells = self.generateEmitterCells()
        view.layer.addSublayer(self.emitter)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
            self.emitter.removeFromSuperlayer()
            
        })
        
        // code to refresh the matches

        match = matchArray.randomElement()!
        
      
        let mainDisplayText = "You (@\(currentUser)) should connect with @\(match) on Instagram!"
        
        let rangeSignUp = NSString(string: mainDisplayText).range(of: "@\(match)", options: String.CompareOptions.caseInsensitive)
        
        let rangeFull = NSString(string: mainDisplayText).range(of: mainDisplayText, options: String.CompareOptions.caseInsensitive)
        
        let attrStr = NSMutableAttributedString.init(string:mainDisplayText)
        attrStr.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.black,
                               NSAttributedString.Key.font : UIFont.init(name: "Higarino Sans", size: 17)! as Any],range: rangeFull)
        attrStr.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.black,
                               NSAttributedString.Key.font : UIFont.init(name: "Higarino Sans", size: 20)!,
                              NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue as Any],range: rangeSignUp) // for swift 4 -> Change thick to styleThick
        self.matchesLabel.attributedText = attrStr
        
    }
    
    @objc func tapped() {
        guard let text = matchesLabel.attributedText?.string else {
                return
        }
        let matchText = (text as NSString).range(of: "\(match)")
        

        if tap!.didTapAttributedTextInLabel(label: matchesLabel, inRange: matchText) {
            let Username =  match // Your Instagram Username here
            let appURL = URL(string: "instagram://user?username=\(Username)")!
            let application = UIApplication.shared

            if application.canOpenURL(appURL) {
                application.open(appURL)
            } else {
                // if Instagram app is not installed, open URL inside Safari
                let webURL = URL(string: "https://instagram.com/\(Username)")!
                application.open(webURL)
            }        }
    }

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        retakeTestButton.layer.borderColor = #colorLiteral(red: 0.02608692087, green: 0.7744804025, blue: 0.6751230955, alpha: 1)
        tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        tap!.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap!)
        
        //SVProgressHUD.show()
        
        let db = Firestore.firestore()
        /*var currentUserSelectedActivity: String!
        var currentUserSelectedGender: String!
        var currentUserLookingForGender: String!
        var currentUserPersonalityType: String!
        var currentUserIg: String?*/
        
        
        let user = Auth.auth().currentUser
            if let user = user {
                db.collection("Users").document(user.uid).getDocument { (snapshot, error) in
                    let userData = snapshot?.data()
                    //print(userData!["selectedActivity"]!) as? String
                    
                    let currentUserSelectedActivity = (userData!["selectedActivity"]! as? String)!
                    let currentUserSelectedGender = (userData!["selectedGender"]! as? String)!
                    let currentUserLookingForGender = (userData!["lookingForGender"]! as? String)!
                    let currentUserPersonalityType = (userData!["personalityType"]! as? String)!
                    let currentUserIg = (userData!["igHandle"]! as? String)!
                    
                    self.currentUser = currentUserIg
                    //print(currentUserSelectedActivity)
                    
                    let allUsers = db.collection("Users")
                    allUsers.addSnapshotListener { (querySnapshot, error) in
                        guard let snapshot = querySnapshot else { return }
                        for document in snapshot.documents {
                            
                            var matchCounts = 0
                            
                            let data = document.data()
                            
                            if data["selectedGender"]! as? String == currentUserLookingForGender {
                                matchCounts = matchCounts + 1
                                
                            }
                            
                            if data["lookingForGender"]! as? String == currentUserSelectedGender {
                                matchCounts = matchCounts + 1
                                
                            }
                            
                            if data["personalityType"]! as? String == currentUserPersonalityType {
                                matchCounts = matchCounts + 1
                            
                            }
                            
                            if data["selectedActivity"]! as? String == currentUserSelectedActivity {
                                matchCounts = matchCounts + 1
                            
                            }
                                                        
                            if matchCounts >= 3 {
                                let matchIg = data["igHandle"] as! String
                                
                                if matchIg != currentUserIg {
                                
                                    self.matchArray.append(matchIg)
                                }
                                
                            }
                                
                            else {
                                self.matchesLabel.text = "We are still looking for matches!"
                            }
                            
                            
                        }
                        
                        self.match = self.matchArray.randomElement()!
                            
                        let mainDisplayText = "You (@\(self.currentUser)) should connect with @\(self.match) on Instagram!"
                                    
                        let rangeSignUp = NSString(string: mainDisplayText).range(of: "@\(self.match)", options: String.CompareOptions.caseInsensitive)
                                    
                        let rangeFull = NSString(string: mainDisplayText).range(of: mainDisplayText, options: String.CompareOptions.caseInsensitive)
                                    
                        let attrStr = NSMutableAttributedString.init(string:mainDisplayText)
                                    attrStr.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.black,
                                                           NSAttributedString.Key.font : UIFont.init(name: "Helvetica", size: 17)! as Any],range: rangeFull)
                        attrStr.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.black,
                                                           NSAttributedString.Key.font : UIFont.init(name: "Helvetica", size: 20)!,
                                                          NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue as Any],range: rangeSignUp) // for swift 4 -> Change thick to styleThick
                        self.matchesLabel.attributedText = attrStr
                            

                        
                        
                    }
                }
                
                
        }
        
        
        

        // Do any additional setup after loading the view.
        //SVProgressHUD.dismiss()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emitter.emitterPosition = CGPoint(x: view.frame.size.width / 2, y: -10)
        emitter.emitterShape = CAEmitterLayerEmitterShape.line
        emitter.emitterSize = CGSize(width: view.frame.size.width, height: 2.0)
        emitter.emitterCells = self.generateEmitterCells()
        view.layer.addSublayer(self.emitter)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
            self.emitter.removeFromSuperlayer()
            
        })
        
    }
    

    
    private func generateEmitterCells() -> [CAEmitterCell] {
        var cells:[CAEmitterCell] = [CAEmitterCell]()
        for index in 0..<16 {
            
            let cell = CAEmitterCell()
            
            cell.birthRate = 4.0
            cell.lifetime = 14.0
            cell.lifetimeRange = 0
            cell.velocity = CGFloat(getRandomVelocity())
            cell.velocityRange = 0
            cell.emissionLongitude = CGFloat(Double.pi)
            cell.emissionRange = 0.5
            cell.spin = 3.5
            cell.spinRange = 0
            cell.color = getNextColor(i: index)
            cell.contents = getNextImage(i: index)
            cell.scaleRange = 0.25
            cell.scale = 0.1
            
            cells.append(cell)
            
        }
        
        return cells
        
    }
    
    private func getRandomVelocity() -> Int {
        return velocities[getRandomNumber()]
    }
    
    private func getRandomNumber() -> Int {
        return Int(arc4random_uniform(4))
    }
    
    private func getNextColor(i:Int) -> CGColor {
        if i <= 4 {
            return colors[0].cgColor
        } else if i <= 8 {
            return colors[1].cgColor
        } else if i <= 12 {
            return colors[2].cgColor
        } else {
            return colors[3].cgColor
        }
    }
    
    private func getNextImage(i:Int) -> CGImage {
        return images[i % 3].cgImage!
    }
    
}
