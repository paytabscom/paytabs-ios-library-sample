BIObjCHelpers
=============

Collection of Objective C helpers

[![Build Status](https://travis-ci.org/grigaci/BIObjCHelpers.svg?branch=master)](https://travis-ci.org/grigaci/BIObjCHelpers) [![Coverage Status](https://coveralls.io/repos/github/grigaci/BIObjCHelpers/badge.svg?branch=master)](https://coveralls.io/github/grigaci/BIObjCHelpers?branch=master) [![CocoaPods Version](https://cocoapod-badges.herokuapp.com/v/BIObjCHelpers/badge.png)](http://cocoapods.org/?q=BIObjCHelpers) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

# Build
Use Xcode 7.2 or above for building the projects.

# Contains

## Datasources
* __BIDatasourceTableView__ - Simple table view datasource
* __BIDatasourceFetchedTableView__ - CoreData table view data
* __BIDatasourceFeedTableView__ - Infinite table view datasource
* __BIDatasourceCollectionView__ - Simple collection view datasource
* __BIDatasourceFetchedCollectionView__ - CoreData collection view datasource

## Handlers
* __BIHandlerTableView__ - Simple table view handler

## Categories
* __NSBundle+BIExtra__ - NSBundle category for getting the full path of a file
* __NSString+BIExtra__ - NSString category for random string generation and email validation.
* __NSDate+BIAttributedString__ - NSDate category for getting attributed string date components

## Starters
* __BIStartersFactory__ - Application runner for keeping the AppDelegate simple and clean
* __BIStarterProtocol__ - Protocol to be used by the runner classes

## Other
* __BIOperationQueue__ - Simple operation queue