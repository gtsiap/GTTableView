// Copyright (c) 2015-2016 Giorgos Tsiapaliokas <giorgos.tsiapaliokas@mykolab.com>
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

    func fetchThreads(threadType: ThreadType, completionHandler: @escaping CompletionHandler) {

        var url = "https://www.reddit.com/r/swift/"
        url += threadType.rawValue
        url += ".json"

        request(url, method: .get).responseJSON() { response in
            completionHandler(self.parseThreads(response: response))
        }
    } // end fetchThreads

    func fetchMoreThreads(
        threadType: ThreadType,
        after: String,
        completionHandler: @escaping CompletionHandler)
    {
        var url = "https://www.reddit.com/r/swift/"
        url += threadType.rawValue
        url += ".json"
        url += "?after=\(after)"

        request(url, method: .get).responseJSON() { response in
            completionHandler(self.parseThreads(response: response))
        }
    }

    private func parseThreads(response: DataResponse<Any>) -> [Thread] {
        var threads = [Thread]()

        guard let JSON = response.result.value as? [String : Any] else {
            print("Network error")
            return threads
        }

        guard let
            data = JSON["data"] as? [String : Any],
            let children = data["children"] as? [[String : AnyObject]]
        else {
            print("Error Parsing JSON")
            return threads
        }

        let after = data["after"] as? String

        for child in children {
            guard let
                childData = child["data"] as? [String : AnyObject],
                let title = childData["title"] as? String
            else { continue }

            let thread = Thread(name: title, after: after)
            threads.append(thread)
        }

        return threads
    }
}
