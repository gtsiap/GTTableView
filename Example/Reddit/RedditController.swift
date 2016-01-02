// Copyright (c) 2015 Giorgos Tsiapaliokas <giorgos.tsiapaliokas@mykolab.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Alamofire

class RedditController {
    typealias CompletionHandler = ([Thread]) -> ()

    func fetchThreads(threadType: ThreadType, completionHandler: CompletionHandler) {
        var threads = [Thread]()

        var url = "https://www.reddit.com/r/swift/"
        url += threadType.rawValue
        url += ".json"

        request(.GET, url).responseJSON()
        { response in
            guard let JSON = response.result.value else {
                print("Network error")
                return
            }

            guard let
                data = JSON["data"] as? [String : AnyObject],
                children = data["children"] as? [[String : AnyObject]]
            else {
                print("Error Parsing JSON")
                return
            }

            let after = data["after"] as? String

            for child in children {
                guard let
                    childData = child["data"] as? [String : AnyObject],
                    title = childData["title"] as? String
                else { continue }                

                let thread = Thread(name: title, after: after)
                threads.append(thread)
            }
            completionHandler(threads)
        } // end request
    } // end fetchThreads
}
