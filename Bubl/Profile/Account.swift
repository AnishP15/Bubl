import UIKit
import Firebase
import JGProgressHUD

class Account: UITableViewController {
    
    
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var igHandle: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Reachability.isConnectedToNetwork() == false {
            showAlertView(title: "Oops!", message: "Please connect to a network before you continue.")

            dismiss(animated: true, completion: nil)

        }else {
            retrieveUserInformation()
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Loading..."
        hud.show(in: self.view)

        
        retrieveUserInformation()
        
        hud.dismiss(afterDelay: 1)
    }

    func retrieveUserInformation() {
        let db = Firestore.firestore()
        
        let user = Auth.auth().currentUser
        if let user = user {
            db.collection("Users").document(user.uid).getDocument { (snapshot, error) in
                let userData = snapshot?.data()
                
                let currentUserIg = (userData!["igHandle"]! as? String)!
                
                self.email.text = Auth.auth().currentUser?.email
                self.igHandle.text = "@\(currentUserIg)"
            }
        }
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        try! Auth.auth().signOut()
        
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
            
        
        let logoutAction = UIAlertAction(title: "Logout", style: .destructive) { (action) in
            try! Auth.auth().signOut()
            self.logoutNavigation()
        }
        let cancelAction = UIAlertAction(title: "Save", style: .cancel)
                
        optionMenu.addAction(logoutAction)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    func logoutNavigation() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "logout")
        self.present(controller, animated: true, completion: nil)
    }
    
    func showAlertView(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

}
