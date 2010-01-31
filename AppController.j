/*
 * AppController.j
 * CPCollectionViewBugDemo
 *
 * Created by Johannes Fahrenkrug on January 31, 2010.
 * Copyright 2010, Your Company All rights reserved.
 */

@import <Foundation/CPObject.j>
@import "MyListView.j"


@implementation AppController : CPObject
{
    MyListView masterList;
    MyListView detailList;
    CPArray detailArray;
    CPMutableArray conferences;
    CPMutableArray memes;
    CPMutableArray cities;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    var theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:CPBorderlessBridgeWindowMask],
        contentView = [theWindow contentView];

    conferences = ["WWDC", "NSConference", "JSConf"];
    memes = ["Keyboard Cat", "Chocolate Rain", "Rick Roll"];
    cities = ["San Francisco", "Berlin", "Vienna"];
    detailArray = [conferences, memes, cities];

    masterList = [[MyListView alloc] initWithFrame:CGRectMake(0.0, 0.0, 226.0, 200.0)];
    [masterList setContent:["Conferences", "Memes", "Cities"]];
    [masterList setDelegate:self];

    var masterScrollView = [[CPScrollView alloc] initWithFrame:CGRectMake(10.0, 65.0, 243.0, 300.0)];
    [masterScrollView setDocumentView:masterList];
    [masterScrollView setAutohidesScrollers:YES];
    [[masterScrollView contentView] setBackgroundColor:[CPColor whiteColor]];
    [contentView addSubview:masterScrollView];

    detailList = [[MyListView alloc] initWithFrame:CGRectMake(0.0, 0.0, 226.0, 200.0)];
    [detailList setContent:detailArray[0]];

    var detailScrollView = [[CPScrollView alloc] initWithFrame:CGRectMake(260.0, 65.0, 243.0, 300.0)];
    [detailScrollView setDocumentView:detailList];
    [detailScrollView setAutohidesScrollers:YES];
    [[detailScrollView contentView] setBackgroundColor:[CPColor whiteColor]];
    [contentView addSubview:detailScrollView];

    var addButton = [[CPButton alloc] initWithFrame:CGRectMake(260.0, 367.0, 60.0, 24.0)];
    [addButton setTitle:"Add one"];
    [addButton setTarget:self];
    [addButton setAction:@selector(addDetail)];
    [addButton setEnabled:YES];
    [contentView addSubview:addButton];

    var descView = [[CPTextField alloc] initWithFrame:CGRectMake(500.0, 65.0, 200, 400)];
    [descView setTextColor:[CPColor blackColor]];
    [descView setFont:[CPFont systemFontOfSize:12.0]];
    [descView setEditable:NO];
    [descView setLineBreakMode:CPLineBreakByWordWrapping];
    [descView setStringValue:@"Steps to reproduce: Click on Memes, click 'Add one', click on Conferences, click on Memes again. Both Keyboard Cat and New Detail will be selected"];
        
    [contentView addSubview:descView];


    [theWindow orderFront:self];

    // Uncomment the following line to turn on the standard menu bar.
    //[CPMenu setMenuBarVisible:YES];
}

- (void)collectionViewDidChangeSelection:(CPCollectionView)aCollectionView
{
    var index = [[masterList selectionIndexes] firstIndex];
    [detailList setContent:detailArray[index]];
    [detailList setSelectionIndexes:[CPIndexSet indexSetWithIndex:0]];
}

- (void)addDetail
{
    var index = [[masterList selectionIndexes] firstIndex];
    selectedDetailArray = detailArray[index];
    [selectedDetailArray addObject:"New Detail"];
    [detailList setContent:selectedDetailArray];
    [detailList reloadContent];
    [detailList setSelectionIndexes:[CPIndexSet indexSetWithIndex:([selectedDetailArray count] - 1)]];
}

@end
