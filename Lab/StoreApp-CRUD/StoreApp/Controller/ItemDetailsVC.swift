//
//  ItemDetailsVC.swift
//  StoreApp
//
//  Created by Macintosh on 03/11/2020.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var storePicker: UIPickerView!
    
    @IBOutlet weak var titleField: UITextField!
    
    @IBOutlet weak var priceField: UITextField!
    
    @IBOutlet weak var detailsField: UITextField!
    
    @IBOutlet weak var thumgImg: UIImageView!
    
    var stores = [Store]()
    var itemToEdit: Item?
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        }
        
        titleField.delegate = self
        priceField.delegate = self
        detailsField.delegate = self
        
        storePicker.delegate = self
        storePicker.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        // After the initial run, should comment out or delete the generateStores() function.
        generateStores()
        getStores()
        
        if itemToEdit != nil {
            loadItemData()
        }
        
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let store = stores[row]
        return store.name
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return stores.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func getStores() {
        
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        
        do {
            
            self.stores = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
            
        } catch {
            
            // handle the error
        }
    }
    
    @IBAction func savePressed(_ sender: Any) {
        
        var item: Item!
        let picture = Image(context: context)
        picture.image = thumgImg.image
        
        if itemToEdit == nil {
            
            item = Item(context: context)
            
        } else {
            
            item = itemToEdit
            
        }
        
         item.toImage = picture
        
        if let title = titleField.text {
            
            item.title = title
            
        }
        
        if let price = priceField.text {
            //Decimal(price)!
            item.price = Double(price)!
           // item.price = Decimal(price)!
        }
        
        if let details = detailsField.text {
            
            item.details = details
            
        }
        
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)]
        
        ad.saveContext()
        
        _ = navigationController?.popViewController(animated: true)
       
        
    }
    
    func loadItemData() {
        
        if let item = itemToEdit {
            
            titleField.text = item.title
            priceField.text = "\(item.price)"
            detailsField.text = item.details
            thumgImg.image = item.toImage?.image as? UIImage
            
            
            if let store = item.toStore {
                
                var index = 0
                repeat {
                    
                    let s = stores[index]
                    if s.name == store.name {
                        
                        storePicker.selectRow(index, inComponent: 0, animated: false)
                        break
                    }
                    index += 1
                    
                } while (index < stores.count)
            }
        }
    }
    
    
    @IBAction func addImage(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            thumgImg.image = img
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    /*
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
       
        
        
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        /*
        if let img = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage {
            
            thumgImg.image = img
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
 */
        
        /*
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            
        }
            
        if let img = info[.originalImage] as! UIImage
           
        {
                thumgImg.image = img
        }
        */
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    */
    
    @IBAction func deletePressed(_ sender: Any) {
        
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            ad.saveContext()
        }
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    
    func generateStores() {
        let store = Store(context: context)
        store.name = "Best Buy"
        let store2 = Store(context: context)
        store2.name = "Tesla Dealership"
        let store3 = Store(context: context)
        store3.name = "Frys Electronics"
        let store4 = Store(context: context)
        store4.name = "Target"
        let store5 = Store(context: context)
        store5.name = "Amazon"
        let store6 = Store(context: context)
        store6.name = "K Mart"
        
        ad.saveContext()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    

}
