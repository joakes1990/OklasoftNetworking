# OklasoftNetworking

[![Build Status](https://travis-ci.org/oklasoftLLC/OklasoftNetworking.svg?branch=master)](https://travis-ci.org/oklasoftLLC/OklasoftNetworking)

## URLSession extention to simplify networking and make it a bit more swifty

This framework is still under active development and should see more utility added as it becomes the cornerstone of networking in more OKS projects.

Basic useage of OklasoftNetworking is acheaved by calling the `getReturnedDataFrom(url: URL, with completion: networkCompletion?)` method on a `URLSession` instance.
networkCompletion is typedefed to the same standard closure that is used for URLSession `{(Data?, URLResponce?, Error?) -> Void}`

You are free to write or include any closure you would normally use with URLSession here but this paramiter is an optional that when left nil will call the default completion.

The default completion will post 1 of 2 notifications. Ether `.networkingSuccessNotification` with the raw value of "URLSessionSuccess" or `.networkingErrorNotification` with the raw value of "URLSessionError"

Both of these notifications's userInfo properties contain all the information that the URL session has returned or the error returned from the session, server or the extention.
