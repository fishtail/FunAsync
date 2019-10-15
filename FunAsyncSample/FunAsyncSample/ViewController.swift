//
//  ViewController.swift
//  FunAsyncSample
//
//  Created by Alex Lin on 2019/10/13.
//  Copyright © 2019 Fisheep. All rights reserved.
//

import UIKit
import FunAsync

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        URLSession.shared.dataTask(urlString: "http://validate.jsontest.com/", params: ["json":"{\"key\":\"value\"}"])
        .jsonResponse() // general map for parsing response into JSON
        .map(clousre: { (jsonResponse) -> Bool? in // process the JSON dictionary to get the target data
            guard let dict = jsonResponse as? [String:Any] else { return nil }
            return dict["validate"] as? Bool
        })
        .catchError { (error) in
            // deal with the error
            print(String(describing: error))
        }
        .observe(on: DispatchQueue.main) // set the target dispatch queue to main queue
        .subscribe {
            if let validate = $0, validate {
                print("Yeah")
            }
        }
    }


}

