//
//  PullRequestTableViewController.swift
//  GitHubAllStars
//
//  Created by Raphael Araújo on 23/10/17.
//  Copyright © 2017 Raphael Araújo. All rights reserved.
//

import UIKit

class PullRequestTableViewController: UITableViewController {
    var repository: Repository?
    var pullRequests = [PullRequest]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        let nib = UINib(nibName: "PullRequestTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier:
            "PullRequestTableViewCell")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 150
        
        self.loadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pullRequests.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PullRequestTableViewCell", for: indexPath) as! PullRequestTableViewCell
        cell.pullRequest = self.pullRequests[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let pullRequest = self.pullRequests[indexPath.row]
        UIApplication.shared.openURL(URL(string: pullRequest.html_url)!)
    }
    
    func loadData() {
        if let fullRepositoryName = self.repository?.fullName {
            DataManager.sharedInstance.getPullRequest(repository: fullRepositoryName) { (error, message, pullRequestsResponse) in
                if(!error) {
                    if let prs = pullRequestsResponse {
                        self.pullRequests.append(contentsOf: prs)
                        print("PRS: \(self.pullRequests.count)")
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
}