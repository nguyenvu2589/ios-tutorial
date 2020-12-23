//
//  ViewController.swift
//  MeLazy
//
//  Created by Vu Nguyen on 10/28/20.
//

import UIKit
import SwifteriOS
import CoreML
import SwiftyJSON


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var TextField: UITextField!
    @IBOutlet weak var emojiField: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    let sentimentClassifier = TweetSentimentClassifier()
    let tweetCount = 100

    var TopTweets = [Tweet](repeating: Tweet(user: "", text: "", profile_url: "", media_url: ""), count: 5)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
    }

    @IBAction func predictPressed(_ sender: UIButton) {
        fetchTweets()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as UITableViewCell
        cell.textLabel?.numberOfLines = 0;
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.backgroundColor = UIColor.clear
        let index :Int  = indexPath.row
        if index < TopTweets.count{
            cell.textLabel?.text = TopTweets[index].text
        } else {
            cell.textLabel?.text = ""
        }
        
        return cell
    }
    
    func fetchTweets(){
        if let searchText = TextField.text{
            
            swifter.searchTweet(using: searchText, lang: "en", count: tweetCount, tweetMode: .extended ) { (results, metadata) in
                
                var tweets = [TweetSentimentClassifierInput]()
                for i in 0..<results.array!.count{
                    let tweet = Tweet(user: results[i]["user"]["screen_name"].string!, text: results[i]["full_text"].string ?? "", profile_url: results[i]["user"]["profile_image_url"].string ?? "", media_url: results[i]["retweeted_status"]["entities"]["media"][0]["media_url"].string ?? "")
                    
                    let tweetForClassification = TweetSentimentClassifierInput(text: tweet.text ?? "")
                    tweets.append(tweetForClassification)

                }
                self.makePrediction(tweets: tweets, results: results)
                self.updateUI()
                
            } failure: { (error) in
                print(error)
            }
        }
    }
    
    func makePrediction(tweets: [TweetSentimentClassifierInput], results: SwifteriOS.JSON ){
        do {
            let predictions = try self.sentimentClassifier.predictions(inputs: tweets)
            
            // count unique values in predictions array
            var counts: [String: Int] = [:]
            predictions.forEach { counts[$0.label, default: 0] += 1 }
            // sorted array
            let sorted_counts = counts.sorted(by: { $0.1 < $1.1 })
            let result = sorted_counts.last?.key
            print(sorted_counts)
            print(result)
            if ["negative", "Neg"].contains(result) {
                self.emojiField.text = "☹️"
                self.tableView.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
                self.view.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
                
            } else if ["positive", "Pos"].contains(result) {
                self.emojiField.text = "😍"
                self.view.backgroundColor = #colorLiteral(red: 0.547878027, green: 0.992023766, blue: 0.8387725949, alpha: 1)
                self.tableView.backgroundColor = #colorLiteral(red: 0.547878027, green: 0.992023766, blue: 0.8387725949, alpha: 1)
            } else {
                self.emojiField.text = "😐"
                self.view.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
                self.tableView.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            }

            self.getTopTweet(result: result, predictions: predictions, results: results)
            
            
        } catch{
            print("omg this is an error \(error)")
        }
    }
    
    func getTopTweet(result: String?, predictions: [TweetSentimentClassifierOutput], results: SwifteriOS.JSON ){
        self.TopTweets = [Tweet]()
        var i = 0;
        for predict in predictions{
            if i == 5 {
                break
            }
            if predict.label == result {
                let tweet = Tweet(user: results[i]["user"]["screen_name"].string!, text: results[i]["full_text"].string ?? "", profile_url: results[i]["user"]["profile_image_url"].string ?? "", media_url: results[i]["retweeted_status"]["entities"]["media"][0]["media_url"].string ?? "")
                self.TopTweets.append(tweet)
                i = i + 1
            }
        }
    }
    
    func updateUI() {
        UIView.transition(with: self.tableView, duration: 1.0, options: .transitionCrossDissolve, animations: {self.tableView.reloadData()}, completion: nil)
        
    }
    
}

extension Collection where Indices.Iterator.Element == Index {
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

