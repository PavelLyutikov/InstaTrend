//
//  InstagramApi.swift
//  InsTrend
//
//  Created by Admin on 20/08/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

class InstagramApi {
    private enum BaseURL: String {
        case displayApi = "https://api.instagram.com/"
        case graphApi = "https://graph.instagram.com/"
    }
    
    private enum Method: String {
        case authorize = "oauth/authorize"
        case access_token = "oauth/access_token"
    }
    
    static let shared = InstagramApi()
    private let instagramAppID = "2966767990099862"
    private let redirectURIURLEncoded = "https%3A%2F%2Fsavage-developer-team.ru%2F"
    private let redirectURI = "https://savage-developer-team.ru/"
    private let app_secret = "1ad325a7b3527b47cfda6510f7bc27cf"
    private init () {}
    
    func authorizeApp(completion: @escaping (_ url: URL?) -> Void ) {
        let urlString =             "\(BaseURL.displayApi.rawValue)\(Method.authorize.rawValue)?app_id=\(instagramAppID)&redirect_uri=\(redirectURIURLEncoded)&scope=user_profile,user_media&response_type=code"
        let request = URLRequest(url: URL(string: urlString)!)
        let session = URLSession.shared
        
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            if let response = response {
                completion(response.url)
            }
        })
        
        task.resume()
    }
    
    private func getTokenFromCallbackURL(request: URLRequest) -> String? {
        let requestURLString = (request.url?.absoluteString)! as String
        
        if requestURLString.starts(with: "\(redirectURI)?code=") {
            if let range = requestURLString.range(of: "\(redirectURI)?code=") {
                return String(requestURLString[range.upperBound...].dropLast(2))
            }
        }
        
        return nil
    }
    
    func getTestUserIDAndToken(request: URLRequest, completion: @escaping (InstagramTestUser) -> Void) {
        guard let authToken = getTokenFromCallbackURL(request: request) else { return }

        let url = URL(string: BaseURL.displayApi.rawValue + Method.access_token.rawValue)!
        let params = ["client_id": "2966767990099862", "client_secret": "1ad325a7b3527b47cfda6510f7bc27cf", "grant_type": "authorization_code", "redirect_uri": "https://savage-developer-team.ru/", "code": authToken]

        FormPostRequest.callPost(url: url, params: params) { (error: Error?, data: Data?) in
            if (error != nil) {
                print(error!)
            } else {
                do {
                    let jsonData = try JSONDecoder().decode(InstagramTestUser.self, from: data!)

                    completion(jsonData)
                } catch let error as NSError {
                  print(error)
                }
            }
        }
    }
    
    func getInstagramUser(testUserData: InstagramTestUser, completion: @escaping (InstagramUser) -> Void) {
        let urlString = "\(BaseURL.graphApi.rawValue)\(testUserData.user_id)?fields=id,username,media_count&access_token=\(testUserData.access_token)"
        let request = URLRequest(url: URL(string: urlString)!)
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request, completionHandler: {(data, response, error) in
            if (error != nil) {
                print(error!)
            } else {
                do {
                    let jsonData = try JSONDecoder().decode(InstagramUser.self, from: data!)
                    
                    completion(jsonData)
                } catch let error as NSError {
                    print(error)
                }
            }
        })
        
        dataTask.resume()
    }
    
    private func getMediaData(testUserData: InstagramTestUser, completion: @escaping (Feed) -> Void) {
        let urlString = "\(BaseURL.graphApi.rawValue)me/media?fields=id,caption&access_token=\(testUserData.access_token)"
        let request = URLRequest(url: URL(string: urlString)!)
        let session = URLSession.shared
        
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            do {
                let jsonData = try JSONDecoder().decode(Feed.self, from: data!)
                
                completion(jsonData)
            } catch let error as NSError {
                print(error)
            }
        })
        
        task.resume()
    }
    
    func getMedia(testUserData: InstagramTestUser, instagramUser: InstagramUser, completion: @escaping ([InstagramMedia]) -> Void) {
        getMediaData(testUserData: testUserData) { (mediaFeed) in
            var media = [InstagramMedia]()

            for mediaFeedData in mediaFeed.data {
                let urlString = "\(BaseURL.graphApi.rawValue + mediaFeedData.id)?fields=id,media_type,media_url,username,timestamp&access_token=\(testUserData.access_token)"
                let request = URLRequest(url: URL(string: urlString)!)
                let session = URLSession.shared
                  
                let task = session.dataTask(with: request, completionHandler: { data, response, error in
                    do {
                        let jsonData = try JSONDecoder().decode(InstagramMedia.self, from: data!)
                        
                        media.append(jsonData)
                        
                        if instagramUser.media_count == media.count {
                            completion(media)
                        }
                    } catch let error as NSError {
                        print(error)
                    }
                })
                  
                task.resume()
            }
        }
    }
    
    func fetchImage(urlString: String, completion: @escaping (Data?) -> Void) {
        let request = URLRequest(url: URL(string: urlString)!)
        let session = URLSession.shared
        
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            completion(data)
        })
        
        task.resume()
    }
}
