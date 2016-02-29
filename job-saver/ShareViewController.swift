import UIKit
import Social
import CoreMedia

class ShareViewController: SLComposeServiceViewController {
    override func didSelectPost() {
        guard let item = self.extensionContext?.inputItems.first as? NSExtensionItem else {
            fatalError("error fetching the input item")
        }

        guard let itemProvider = item.attachments?.first as? NSItemProvider else {
            fatalError("error fetching the item provider")
        }
        
        if itemProvider.hasItemConformingToTypeIdentifier("public.url") {
            itemProvider.loadItemForTypeIdentifier("public.url", options: nil, completionHandler: { item, error in
                guard let item = item as? NSURL else {
                    fatalError("the item was not a url")
                }
                
                let sharedDefaults = NSUserDefaults(suiteName: "group.ca.sundeepgupta.job")
                
                if var jobs = sharedDefaults?.stringArrayForKey("jobs") {
                    let url = item.absoluteString
                    jobs.append(url)
                    sharedDefaults?.setObject(jobs, forKey: "jobs")
                } else {
                    sharedDefaults?.setObject([], forKey: "jobs")
                }
                
                sharedDefaults?.synchronize()
            })
        }
        
        self.extensionContext!.completeRequestReturningItems([], completionHandler: nil)
    }
}
