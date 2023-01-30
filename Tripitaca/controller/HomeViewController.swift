//
//  HomeViewController.swift
//  Tripitaca
//
//  Created by Ernest Mwangi on 26/01/2023.
//

import UIKit

class HomeViewController: UIViewController {


    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    var listData = [PropertyDataClass]()
    var filteredData = [PropertyDataClass]()
    var fm = FileManager.default
    var subUrl: URL?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()

        let nib = UINib(nibName: "TableViewCustomCell", bundle: nil)
        tableView?.register(nib, forCellReuseIdentifier: "TableViewCustomCell")
        tableView.backgroundColor = .white
        tableView?.delegate = self
        tableView?.dataSource = self

        getData()

    }

    func setupViews(){
        searchBar.delegate = self
        searchBar.placeholder = "Where do you want to go?"
        searchBar.backgroundColor = Colors.colorWhite
        searchBar.searchTextField.tintColor = Colors.primaryTextColor
        searchBar.searchTextField.backgroundColor = Colors.colorAltWhite
        searchBar.searchTextField.textColor = Colors.primaryTextColor
    }

    func getData(){
        guard let mainUrl = Bundle.main.url(forResource: "tripitacaData", withExtension: "json") else { return }

        do {
            let documentDirectory = try fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
            let subUrl = documentDirectory.appendingPathComponent("tripitacaData.json")
            loadFile(mainPath: mainUrl, subPath: subUrl)
        } catch {
            print(error)
        }
    }

    func loadFile(mainPath: URL?, subPath: URL?){
        if fm.fileExists(atPath: subPath!.path){
            decodeData(pathName: subPath!)

            if listData.isEmpty{
                decodeData(pathName: mainPath!)
            }

        }else{
            decodeData(pathName: mainPath!)
        }

        self.tableView.reloadData()
    }

    func decodeData(pathName: URL){
         do{
             let jsonData = try Data(contentsOf: pathName)
             let decoder = JSONDecoder()
             listData = try decoder.decode([PropertyDataClass].self, from: jsonData)

             filteredData = listData
         }
        catch let DecodingError.dataCorrupted(context) {
           print(context)
       } catch let DecodingError.keyNotFound(key, context) {
           print("Key '\(key)' not found:", context.debugDescription)
           print("codingPath:", context.codingPath)
       } catch let DecodingError.valueNotFound(value, context) {
           print("Value '\(value)' not found:", context.debugDescription)
           print("codingPath:", context.codingPath)
       } catch let DecodingError.typeMismatch(type, context)  {
           print("Type '\(type)' mismatch:", context.debugDescription)
           print("codingPath:", context.codingPath)
       } catch {
           print("error: ", error)
       }
     }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCustomCell", for: indexPath) as! TableViewCustomCell
        cell.configureCells(with: filteredData[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: [indexPath.row], animated: true)

        let storyBoard: UIStoryboard = UIStoryboard(name: "ListingDetail", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ListingDetailVC") as! ListingDetailVC
        newViewController.passedImage = listData[indexPath.row].featuredImage!
        newViewController.passedName = listData[indexPath.row].name!
        newViewController.passedLocation = listData[indexPath.row].location!
        newViewController.passedDesc = listData[indexPath.row].description!
        newViewController.passedRating = listData[indexPath.row].rating!
        newViewController.passedPrice = listData[indexPath.row].price!
        newViewController.passedLatitude = listData[indexPath.row].coordinates?.latitude!
        newViewController.passedLongitude = listData[indexPath.row].coordinates?.longitude!

        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: true, completion: nil)
    }
}

extension HomeViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        filteredData = searchText.isEmpty ? listData : listData.filter { (item: PropertyDataClass) -> Bool in
                // If dataItem matches the searchText, return true to include it
            return item.name?.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil

            }

        tableView.reloadData()
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            self.searchBar.showsCancelButton = true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.showsCancelButton = false
            searchBar.text = ""
            searchBar.resignFirstResponder()
            self.tableView.reloadData()
    }
}
