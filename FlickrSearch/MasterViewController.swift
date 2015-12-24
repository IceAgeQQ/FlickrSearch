

import UIKit

class MasterViewController: UIViewController {
  
  @IBOutlet var tableView: UITableView!
  @IBOutlet var searchBar: UISearchBar!
  var searches = OrderedDictionary<String, [Flickr.Photo]>()
    
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showDetail" {
        if let indexPath = self.tableView.indexPathForSelectedRow{
            let (_, photos) = self.searches[indexPath.row]
            (segue.destinationViewController
                as! DetailViewController).photos = photos
        }
    }
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    if let selectedIndexPath = self.tableView.indexPathForSelectedRow {
      self.tableView.deselectRowAtIndexPath(selectedIndexPath, animated: true)
    }
  }
}

extension MasterViewController: UITableViewDataSource, UITableViewDelegate {
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.searches.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
    
    let (term, photos) = self.searches[indexPath.row]
    cell.textLabel?.text = "\(term) (\(photos.count))"
    return cell
  }
  
  func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
  }
  
  func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
  }
  
}

extension MasterViewController: UISearchBarDelegate {
  
  func searchBarSearchButtonClicked(searchBar: UISearchBar!) {
    searchBar.resignFirstResponder()
    
    let searchTerm = searchBar.text
    Flickr.search(searchTerm!){
        switch ($0){
        case .Error:
            break
        case Flickr.SearchResult.Results(let results):
            self.searches.insert(results, forKey: searchTerm!, atIndex: 0)
            self.tableView.reloadData()
        }
    }
  }
  
}












