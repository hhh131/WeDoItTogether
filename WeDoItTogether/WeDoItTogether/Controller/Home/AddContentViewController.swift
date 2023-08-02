import UIKit

protocol AddContentDelegate: AnyObject {
    func didSaveItem(_ item: Item)
}

class AddContentViewController: UIViewController {
    
    weak var delegate: AddContentDelegate?
    
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

        let newItem = Item(title: titleText, date: dateString, location: locationText, members: [])

        delegate?.didSaveItem(newItem)

        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func cancelButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
        
}
