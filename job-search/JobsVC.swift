import UIKit

class JobsVC: UITableViewController {
    var jobs = [[String: String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadJobs()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.jobs.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("jobCell", forIndexPath: indexPath) as! JobCell
        
        let job = self.jobs[indexPath.row]

        cell.urlLabel.text = job["url"]
        cell.noteLabel.text = job["note"]
        
        return cell
    }
    
    @IBAction func refresh() {
        self.loadJobs()
    }
    
    func loadJobs() {
        // Get a reference to our shared user defaults.
        guard let sharedDefaults = NSUserDefaults(suiteName: "group.ca.sundeepgupta.job-search") else {
            fatalError()
        }
        
        // Extract our jobs array from the defaults.
        // NSUserDefaults doesn't store the type information for our jobs array,
        // so we must cast it to the correct type.
        if let jobs = sharedDefaults.arrayForKey("jobs") as? [[String: String]] {
            self.jobs = jobs
        }
        
        self.tableView.reloadData()
    }
}