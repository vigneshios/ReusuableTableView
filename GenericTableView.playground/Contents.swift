
import UIKit

class GenericTableVw<T, CustomCell: UITableViewCell>: UITableView, UITableViewDataSource, UITableViewDelegate {
    
   //MARK:----Declaration------------
    var items: [T]!
    var configHandler:(T, CustomCell) -> ()
    var selectionHandler: (T) -> ()
    
    init(frame: CGRect, items: [T],
         configHandler: @escaping (T, CustomCell) -> (), selectionHandler: @escaping (T) -> ()) {
        self.items = items
        self.configHandler = configHandler
        self.selectionHandler = selectionHandler
        super.init(frame: frame, style: .plain)
        setupTblVw()
    }
    
   fileprivate func setupTblVw() {
        self.dataSource = self
        self.delegate = self
        self.register(CustomCell.self, forCellReuseIdentifier: "cell")
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:----- numberOfRowsInSection -----------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    //MARK:----------Cell For Row---------------------
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
      //  cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell") as! CustomCell
        let item = items[indexPath.row]
        configHandler(item, cell)
        return cell
    }
    //MARK:----------didSelectRowAt indexPath---------------------
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRow = items[indexPath.row]
        selectionHandler(selectedRow)
    }
    


}




/*
 1.Create a tableview class
 2.Add datasource, delegate
 3.Conformance to the datasource, delgates
 4.Declare a generic item
 5.Declare a generic cell of uitableview cell
 6.Createa config closure with item, cell
 7.Call the same in cell for row.
 8.Create initialisers with the added closures, arrays with escaping for closures in init(frame: , items: Item, config: @escaping (item,cell){}
 9.Add self.datasouce = self; self.delegate = self in init.frame method
 10.Register cell in init.frame method
 11.Declare a reusuable tblvw in vc.
 12.Setuptblvw
 13.Call the function with closure with array items.
 14.Create a selectionHandler with item closure and use it in did select method.
 15.improvise the init.frame method.
 16.Use extension and create a reload data class with dispatch queue block with items and reloadData() inbuild function.
 17. Use a timer func and check the reload functionality.
 
 */
