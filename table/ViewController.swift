//
//  ViewController.swift
//  table
//
//  Created by harpanth kaur on 2021-01-22.
//

import UIKit
import CoreData

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let cellReuseIndentifier = "cell"
    
    @IBOutlet var tableview:UITableView!
     var model = [Labtest1]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      //  let models = self.model[indexPath.row]
        let cells = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        cells.textLabel?.text = " name :\(String(describing: model[indexPath.row].name)),tution : \(model[indexPath.row].tution) ,age :\(model[indexPath.row].age),date: \(String(describing: model[indexPath.row].termstartdate)) "
        return cells
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let  action = UIContextualAction(style:.destructive, title: "delete", handler: { _,_,_ in
            let itemtoremove = self.model[indexPath.row]
            self.context.delete(itemtoremove)
            do{
                try   self.context.save()
                
            }
            catch{
            }
            self.viewWillAppear(true)
        })
        
    //    getallitems()
   //     self.tableview.reloadData()
            
      return UISwipeActionsConfiguration(actions: [action])
        }
  
    

 func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: true)
        let item = model[indexPath.row]
        let sheet = UIAlertController(title: "Edit", message: nil , preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
    sheet.addAction(UIAlertAction(title: "Edit", style: .default, handler: {[weak self] _ in
          /*
        func prepare(for segue: UIStoryboardSegue, sender: UIBarButtonItem) {
                    let next: ViewController = segue.destination as! ViewController
                     self?.present(next, animated: true, completion: nil)*/
                
              // tableview.reloadData()
           // }
          let alert = UIAlertController(title: "Edit", message: "Editname", preferredStyle: .alert)
            alert.textFields?.first?.text = item.name
        alert.textFields?.first?.text = "\(item.age)"
        alert.textFields?.first?.text = "\(item.tution)"
        alert.textFields?.first?.text = "\(String(describing: item.termstartdate))";            alert.addTextField(configurationHandler: nil)
            alert.addAction(UIAlertAction(title: "Save", style: .cancel, handler: {[weak self] _ in
                guard let feild = alert.textFields?[0], let newName = feild.text, !newName.isEmpty else{
                    return
                }
                
                guard let field = alert.textFields?[1], let newAge = field.text, !newAge.isEmpty else{
                    return
                }
                
                guard let feild1 = alert.textFields?[2], let newTution = feild1.text, !newTution.isEmpty else{
                    return
                }
                guard let feild2 = alert.textFields?[3], let newTermstartdate = feild2.text, !newTermstartdate.isEmpty else{
                    return
                }
//self?.updateitem(item: item, newName: newName,  newAge: newAge, newTution: newTution, newTermstartdate:newTermstartdate)
                
           }))
        self?.present(alert , animated: true)
    }))
    // sheet.addAction(UIAlertAction(title: "delete", style: .destructive, handler: {[weak self] _ in
   //  self?.deleteitem(item: item)

            
      //  }))
      present(sheet , animated: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "core data"
        view.addSubview(tableview)
        getallitems()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.frame = view.bounds
     //  navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:#selector(didtapadd) )/
     
        tableview.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        getallitems()
        self.tableview.reloadData()
        //getallitems()
    }
    
func prepare(for segue: UIStoryboardSegue, sender: UIBarButtonItem) {
        let next: ViewController = segue.destination as! ViewController
         self.present(next, animated: true, completion: nil)
    
  // tableview.reloadData()
}

//    @objc private func didtapadd()
 //   {
     //   performSegue(withIdentifier: "pass", sender: self)
       // _ = self.storyboard?.instantiateViewController(withIdentifier: "pass") as! SecondViewController
     //   let next = self.storyboard?.instantiateViewController(withIdentifier: "pass") as! SecondViewController
     //   self.present(next, animated: true, completion: nil)
      //  self.navigationController?.pushViewController(SecondViewController, animated: true)
       /* let alert = UIAlertController(title: "name", message: "Enter name", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Save", style: .cancel, handler: {[weak self] _ in
            guard let feild = alert.textFields?.first, let text = feild.text, !text.isEmpty else{
                return
            }
            self?.createitem(name: text)
            
        }))
       present(alert , animated: true)*/
    //}
    
    func getallitems()
{
       // self.tableview.reloadData()
    do{
    model = try context.fetch(Labtest1.fetchRequest())
        DispatchQueue.main.async {
        //   self.tableview.reloadData()
        }
    }
    catch
    {
        
    }
}
    func createitem(name: String , age: Int , tution: Double , termstartdate:Date)
    {
        let newitem = Labtest1(context: context)
        newitem.name = name
        newitem.age = Int16(age)
        newitem.tution = tution
        newitem.termstartdate=Date()        
        do{
            try context.save()
            getallitems()
            
        }
        catch
        {
            
        }
    }
    func updateitem(item: Labtest1, newName: String , newAge: Int , newTution: Double , newTermstartdate:Date)
    
    {
        item.name = newName
        item.age = Int16(newAge)
        item.tution = newTution
        item.termstartdate = newTermstartdate
        do {
            try context.save()
            getallitems()
        } catch{
            
        }
    }
  func deleteitem(item: Labtest1)
    {
        context.delete(item)
        do {
            try context.save()
            getallitems()
        } catch  {
           
        }
    }
}

