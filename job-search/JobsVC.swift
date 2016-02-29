import UIKit

class JobsVC: UITableViewController {
    var jobs = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadJobs()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.jobs.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let job = self.jobs[indexPath.row]

        let cell = tableView.dequeueReusableCellWithIdentifier("jobCell", forIndexPath: indexPath)
        cell.textLabel?.text = job
        
        return cell
    }
    
    @IBAction func refresh() {
        self.loadJobs()
    }
    
    func loadJobs() {
        let sharedDefaults = NSUserDefaults(suiteName: "group.ca.sundeepgupta.job")
        if let jobs = sharedDefaults?.stringArrayForKey("jobs") {
            self.jobs = jobs
        } else {
            sharedDefaults?.setObject([], forKey: "jobs")
        }
        
        self.tableView.reloadData()
    }
}