import UIKit
import Firebase

protocol AddContentDelegate: AnyObject {
    func didSaveItem(_ item: Item)
}

class AddContentViewController: UIViewController {
    
    weak var delegate: AddContentDelegate?
    
    var user = UserDefaultsData.shared.getUser()
    let contentView = AddContentView()
    var testModel = dataSource
    
    override func loadView() {
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
    }
    
    func setNavigation() {
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
        
        self.navigationItem.leftBarButtonItem = cancelButton
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func saveButtonTapped() {
        let titleText = contentView.titleTextField.text ?? ""
        let locationText = contentView.locationTextField.text ?? ""
        let memoText = contentView.memoTextField.text ?? ""
        let dateString = contentView.dateResultLabel.text ?? ""
        
        let newItem = Item(title: titleText, date: dateString, location: locationText, memo: memoText, members: [self.user?.name ?? ""], emails: [self.user?.email ?? ""])
        let newItemDictionary = newItem.asDictionary()
        
        let database = Database.database().reference()
        let newItemRef = database.child("items").childByAutoId()
        
        newItemRef.setValue(newItemDictionary)
        
        delegate?.didSaveItem(newItem)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func cancelButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
