import UIKit
import Social
import CoreMedia

class ShareViewController: SLComposeServiceViewController {
    override func didSelectPost() {
        
        // Step by step peeling of all of the extension context layers to get to the NSItemProvider.
//        guard let context = self.extensionContext else { fatalError() }
//        let inputItems = context.inputItems
//        guard let extensionItem = inputItems.first else { fatalError() }
//        guard let attachments = extensionItem.attachments else { fatalError() }
//        guard let itemProvider = attachments?.first else { fatalError() }
        
        // Single line to get our NSItemProvider using optional chaining.
        guard let itemProvider = self.extensionContext?.inputItems.first?.attachments??.first else { fatalError() }
        

        // NSItemProvider is the object that has our url, but it could have other types like images, etc. 
        // First we check to make sure it has a url type.
        if itemProvider.hasItemConformingToTypeIdentifier("public.url") {
            
            // Now we load the url and pass a completion handler closure to handle the url data.
            itemProvider.loadItemForTypeIdentifier("public.url", options: nil, completionHandler: { item, error in
                
                // Cast the incoming item to what we expect NSURL.
                guard let item = item as? NSURL else { fatalError() }
                
                // Access our shared defaults and save the job data.
                guard let sharedDefaults = NSUserDefaults(suiteName: "group.ca.sundeepgupta.job-search") else { fatalError() }
                
                let job: [String: String] = [
                    "url": item.absoluteString,
                    "note": self.contentText as String
                ]
                
                if var jobs = sharedDefaults.arrayForKey("jobs") {
                    jobs.append(job)
                    sharedDefaults.setObject(jobs, forKey: "jobs")
                } else {
                    sharedDefaults.setObject([job], forKey: "jobs")
                }
                
                guard sharedDefaults.synchronize() else {
                    fatalError()
                }
            })
        }
        
        self.extensionContext!.completeRequestReturningItems([], completionHandler: nil)
    }
}
