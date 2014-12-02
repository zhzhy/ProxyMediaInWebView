ProxyMediaInWebView
===================
##Overview

With this kit, you can cache media played in UIWebView, simultaneously, proxy the online media request with your wish. Of course media played with AVPlayer can be cached and proxyed, for they also request data with **AVURLAssert**.

After Hacking, I found media engine in UIWebView is AVPlayer, we know AVPlayer is powerful! After iOS6 with AVAssetResourceLoaderDelegate can cache and proxy media online request, this is public and useful. All is completed silently, you don't konw there is AVPlayer or AVURLAssert, then with Objective-C Runtime, they can eszily work.

**Just enjoy it!!**

##Proxy
We all konw UIWebView can play audio and video, this is awesome! Sometimes, we want to proxy audio or video request to specific Host for saving flow or statistic. With this  Kit you can finish it easily, just include codes in MediaProxy, then the Kit will complete the remaining.

##Cache
Sometimes we want to cache audio or video played in UIWebView for saving flow or reducing next connection time. This Kit Can help you.
