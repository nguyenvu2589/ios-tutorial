import Cocoa
import CreateML

let data = try MLDataTable(contentsOf: URL(fileURLWithPath: "/Users/vnguyen/Desktop/code/ios/Twittermenti-iOS13/twitter-sanders-apple3.csv"))

let (trainingData, testingData) = data.randomSplit(by: 0.8, seed: 123)

let sentimentClassifier = try MLTextClassifier(trainingData: trainingData, textColumn: "text", labelColumn: "class")

let evaluationMetrics = sentimentClassifier.evaluation(on: testingData, textColumn: "text", labelColumn: "class")
let evaluetionAccuracy = (1.0 - evaluationMetrics.classificationError) * 100

let metadata = MLModelMetadata(author: "vnguyen", shortDescription: "Model trained to classify sentiment on Tweets", version: "1.0")
try sentimentClassifier.write(to: URL(fileURLWithPath: "/Users/vnguyen/Desktop/code/ios/Twittermenti-iOS13/TweetSentimentClassifier.mlmodel"))


try sentimentClassifier.prediction(from: "@you this is a bad one")

try sentimentClassifier.prediction(from: "whaaaat? Nooooo")

try sentimentClassifier.prediction(from: "whaaaat? Nooooo")

try sentimentClassifier.prediction(from: "whatever")
